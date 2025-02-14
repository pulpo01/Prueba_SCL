CREATE OR REPLACE PACKAGE BODY PV_LIMITE_CONSUMO_RANGO_PG AS

PROCEDURE PV_LIMITE_CONSUMO_RANGO_PR ( VP_PRODUCTO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_CODLIMCO IN VARCHAR2 ,
  VP_FECSYS IN DATE ,
  VP_IMP_CODLIMCO IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2  )
  
 IS
   

   
   CURSOR C1 is
   SELECT ROWID,COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
          FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
          IND_FRIENDS,IND_DIASESP,COD_CELDA,
          TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
          NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
          COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
          COD_GRUPO,COD_PORTADOR,COD_USO
     FROM GA_INTARCEL
    WHERE COD_CLIENTE = VP_CLIENTE
      AND NUM_ABONADO = VP_ABONADO
      AND VP_FECSYS BETWEEN FEC_DESDE
                        AND FEC_HASTA;
                        
   V_CLIENTE        GA_INTARCEL.COD_CLIENTE%TYPE;
   V_ABONADO        GA_INTARCEL.NUM_ABONADO%TYPE;
   V_NUMERO         GA_INTARCEL.IND_NUMERO%TYPE;
   V_FECDESDE       GA_INTARCEL.FEC_DESDE%TYPE;
   V_FECHASTA       GA_INTARCEL.FEC_HASTA%TYPE;
   V_LIMCONSUMO     GA_INTARCEL.IMP_LIMCONSUMO%TYPE;
   V_FRIENDS        GA_INTARCEL.IND_FRIENDS%TYPE;
   V_DIASESP        GA_INTARCEL.IND_DIASESP%TYPE;
   V_CELDA          GA_INTARCEL.COD_CELDA%TYPE;
   V_TIPPLANTARIF   GA_INTARCEL.TIP_PLANTARIF%TYPE;
   V_PLANTARIF      GA_INTARCEL.COD_PLANTARIF%TYPE;
   V_SERIE          GA_INTARCEL.NUM_SERIE%TYPE;
   V_SERIETRUNK     GA_INTARTRUNK.NUM_SERIE%TYPE;
   V_SERIETREK      GA_INTARTREK.NUM_SERIE%TYPE;
   V_CELULAR        GA_INTARCEL.NUM_CELULAR%TYPE;
   V_CARGOBASICO    GA_INTARCEL.COD_CARGOBASICO%TYPE;
   V_CICLO          GA_INTARCEL.COD_CICLO%TYPE;
   V_PLANCOM        GA_INTARCEL.COD_PLANCOM%TYPE;
   V_PLANSERV       GA_INTARCEL.COD_PLANSERV%TYPE;
   V_GRPSERV        GA_INTARCEL.COD_GRPSERV%TYPE;
   V_GRUPO          GA_INTARCEL.COD_GRUPO%TYPE;
   V_PORTADOR       GA_INTARCEL.COD_PORTADOR%TYPE;
   V_CAPCODE        GA_INTARBEEP.CAP_CODE%TYPE;
   V_BEEPER         GA_INTARBEEP.NUM_BEEPER%TYPE;
   V_RADIO          GA_INTARTRUNK.NUM_RADIO%TYPE;
   V_MAN            GA_INTARTREK.NUM_MAN%TYPE;
   V_LIMCONS        TOL_LIMITE_TD.IMP_LIMITE%TYPE; 
   V_USO            GA_INTARCEL.COD_USO%TYPE;
   V_NUM_IMSI       GA_INTARCEL.NUM_IMSI%TYPE;
   V_TECNOLOGIA     GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   V_NUM_SERIE      GA_ABOCEL.NUM_SERIE%TYPE;
   vFecDesdeProximo GA_LIMITE_CLIABO_TO.FEC_DESDE%TYPE;
   V_FECHASUP       GA_INTARCEL.FEC_DESDE%TYPE;
   
   V_ROWID ROWID;
   YA_EXISTE VARCHAR2(1);
   
   
BEGIN
   VP_PROC := 'PV_LIMITE_CONSUMO_RANGO_PR';
   VP_ACT := 'S';
   YA_EXISTE := 'N'; 
   VP_ERROR := '0';
   
   DBMS_OUTPUT.PUT_LINE('*1');

   IF VP_PRODUCTO = 1 THEN
          VP_TABLA := 'C1';
          VP_ACT := 'O';

          V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
     
          OPEN C1;
          LOOP
                     VP_TABLA := 'C1';
                     VP_ACT := 'F';
                     FETCH C1 INTO V_ROWID,V_CLIENTE,V_ABONADO,V_NUMERO,
                                   V_FECDESDE,V_FECHASTA,V_LIMCONSUMO,
                                   V_FRIENDS,V_DIASESP,V_CELDA,
                                   V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                                   V_CELULAR,V_CARGOBASICO,V_CICLO,
                                   V_PLANCOM,V_PLANSERV,V_GRPSERV,
                                   V_GRUPO,V_PORTADOR,V_USO;
                     EXIT WHEN C1%NOTFOUND;

                     IF V_ABONADO <> 0 THEN
                          SELECT COD_TECNOLOGIA, NUM_SERIE
                            INTO  V_TECNOLOGIA, V_NUM_SERIE
                            FROM  GA_ABOCEL
                           WHERE NUM_ABONADO = V_ABONADO;

                           IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TECNOLOGIA) = V_TECNOLOGIA_GSM THEN
                              SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO V_NUM_IMSI FROM DUAL;
                           END IF;
                     END IF;

                     BEGIN
                       
                         YA_EXISTE := 'N';
                         SELECT 'S' INTO YA_EXISTE
                         FROM   GA_INTARCEL
                         WHERE COD_CLIENTE = VP_CLIENTE
                         AND NUM_ABONADO = VP_ABONADO
                         AND IND_NUMERO = V_NUMERO
                         AND VP_FECSYS = FEC_DESDE;
                         
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             YA_EXISTE := 'N';
                     END;

                     IF YA_EXISTE = 'N' THEN 
                     
                         VP_TABLA := 'GA_INTARCEL';
                         VP_ACT := 'U';
                     
                         UPDATE GA_INTARCEL
                         SET FEC_HASTA = VP_FECSYS - (1/(24*60*60)),NUM_IMSI=V_NUM_IMSI
                         WHERE ROWID = V_ROWID;
                     
                         VP_TABLA := 'GA_INTARCEL';
                         VP_ACT := 'S';
                     
                         SELECT MIN(FEC_DESDE)
                           INTO V_FECHASUP
                           FROM GA_INTARCEL
                          WHERE COD_CLIENTE = V_CLIENTE
                            AND NUM_ABONADO = V_ABONADO
                            AND IND_NUMERO = V_NUMERO
                            AND FEC_DESDE > VP_FECSYS;
                     
                     
                         IF V_FECHASUP IS NULL THEN
                            V_FECHASUP := V_FECHASTA;
                         ELSE
                            V_FECHASUP := V_FECHASUP - (1/(24*60*60));
                         END IF;
                     
                     
                         VP_TABLA := 'GA_INTARCEL';
                         VP_ACT := 'I';
                        
                         IF V_TIPPLANTARIF = 'E' THEN
                            BEGIN
                         
                               SELECT COD_EMPRESA INTO V_GRUPO
                               FROM GA_EMPRESA
                               WHERE COD_CLIENTE = VP_CLIENTE;
                         
                            EXCEPTION
                               WHEN NO_DATA_FOUND THEN
                                  V_GRUPO := NULL;
                            END;
                         
                         ELSE
                            V_GRUPO := NULL;
                         END IF;


     
                         BEGIN
                                   SELECT fec_desde
                                   INTO vFecDesdeProximo
                                   FROM GA_INTARCEL
                                   WHERE fec_desde > sysdate
                                   AND COD_CLIENTE = VP_CLIENTE
                                   AND NUM_ABONADO = VP_ABONADO;
                                   
                         EXCEPTION
                                   WHEN NO_DATA_FOUND THEN
                                        vFecDesdeProximo:=NULL;
                         END;

                         IF vFecDesdeProximo IS NOT NULL then
                         
                                                 DELETE FROM GA_INTARCEL
                                                 WHERE COD_CLIENTE = VP_CLIENTE
                                                 AND NUM_ABONADO = VP_ABONADO
                                                 AND FEC_DESDE=vFecDesdeProximo;
                         END IF;
                        
                         IF VP_IMP_CODLIMCO >0 THEN
                            
                                 INSERT INTO GA_INTARCEL
                                            (COD_CLIENTE,NUM_ABONADO,IND_NUMERO,
                                             FEC_DESDE,FEC_HASTA,IMP_LIMCONSUMO,
                                             IND_FRIENDS,IND_DIASESP,COD_CELDA,
                                             TIP_PLANTARIF,COD_PLANTARIF,NUM_SERIE,
                                             NUM_CELULAR,COD_CARGOBASICO,COD_CICLO,
                                             COD_PLANCOM,COD_PLANSERV,COD_GRPSERV,
                                             COD_GRUPO,COD_PORTADOR,COD_USO,NUM_IMSI)
                                     VALUES (V_CLIENTE,V_ABONADO,V_NUMERO,
                                             VP_FECSYS,V_FECHASUP,VP_IMP_CODLIMCO,
                                             V_FRIENDS,V_DIASESP,V_CELDA,
                                             V_TIPPLANTARIF,V_PLANTARIF,V_SERIE,
                                             V_CELULAR,V_CARGOBASICO,V_CICLO,
                                             V_PLANCOM,V_PLANSERV,V_GRPSERV,
                                             V_GRUPO,V_PORTADOR,V_USO,V_NUM_IMSI);
                         END IF;                    


                    ELSE 

                             VP_TABLA := 'GA_INTARCEL(E)';
                             VP_ACT := 'U';

                             UPDATE GA_INTARCEL
                             SET IMP_LIMCONSUMO = VP_IMP_CODLIMCO,
                                 NUM_IMSI = V_NUM_IMSI
                             WHERE COD_CLIENTE = V_CLIENTE
                             AND NUM_ABONADO = V_ABONADO
                             AND IND_NUMERO = V_NUMERO
                             AND FEC_DESDE = VP_FECSYS;

                    END IF;
                    
                     
          VP_TABLA := 'GA_INTARCEL';
          VP_ACT := 'U';
          
          UPDATE GA_INTARCEL
          SET IMP_LIMCONSUMO = VP_IMP_CODLIMCO,
              NUM_IMSI = V_NUM_IMSI
          WHERE COD_CLIENTE = V_CLIENTE
          AND NUM_ABONADO = V_ABONADO
          AND IND_NUMERO = V_NUMERO
          AND FEC_DESDE > VP_FECSYS;
          
          
      END LOOP;
      
      VP_TABLA := 'C1';
      VP_ACT := 'C';
      
      CLOSE C1;
   
    END IF;
EXCEPTION

   
   WHEN OTHERS THEN
   		VP_SQLCODE := SQLCODE;
		VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';


END PV_LIMITE_CONSUMO_RANGO_PR;

END PV_LIMITE_CONSUMO_RANGO_PG; 
/
SHOW ERROR