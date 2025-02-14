CREATE OR REPLACE PACKAGE BODY PV_MOV_SUSPETOTSIN_PG AS

PROCEDURE PV_REGISTRA_MOV_PR(                    EO_FEC_TRANS     IN DATE,
                                                 SN_RESULTADO     OUT NOCOPY INTEGER,
                                                 SV_SQLCODE       OUT NOCOPY VARCHAR2,
                                                 SV_SQLERRM       OUT NOCOPY VARCHAR2
                                                 )
IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_REGISTRA_MOV_PR"
       Lenguaje="PL/SQL"
       Fecha="18-01-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_FEC_TRANS" Tipo="DATE">FECHA DE TRANSACCION<param>>
          </Entrada>
          <Salida>
             <param nom="SN_RESULTADO" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_SQLCODE" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SV_SQLERRM" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
 LV_COD_SERVICIO GA_SINIESTROS.COD_SERVICIO%TYPE;
 LN_DIAS_SUSPE   NUMBER(3);
 LN_CANTIDAD     NUMBER(2);
 LV_OPERADORA    ge_parametros_sistema_vw.VALOR_TEXTO%TYPE;
 LV_NUM_ABONADO  GA_ABOCEL.NUM_ABONADO%TYPE;
 LD_SINIESTRO    DATE;
 
 
 VP_NUMSECUENCIA 	NUMBER(9);
 VP_NUMABONADO   	GA_ABOCEL.NUM_ABONADO%TYPE;
 VP_CODESTADO	   	VARCHAR2(3):=1;
 VP_CODACTABO	   	GA_ACTABO.COD_ACTABO%TYPE:='ST';
 VP_CODMODULO	   	VARCHAR2(2):='GA';
 VP_USUARIO	   	    VARCHAR2(30):='SISCEL';
 VP_FECINGRE	    VARCHAR2(19);
 VP_TIPTERMINAL  	VARCHAR2(1);
 VP_CODCENTRAL   	GA_ABOCEL.COD_CENTRAL%TYPE;
 VP_INDBLOQUEO   	NUMBER(1):=0;
 VP_TIPTERMINAL_NUE VARCHAR2(1):=NULL;
 VP_NUMCELULAR		GA_ABOCEL.NUM_CELULAR%TYPE;
 VP_NUMSERIE		GA_ABOCEL.NUM_SERIE%TYPE;
 VP_NUMCELULAR_NUE	GA_ABOCEL.NUM_CELULAR%TYPE:=NULL;
 VP_NUMSERIE_NUE	GA_ABOCEL.NUM_SERIE%TYPE:=NULL;
 VP_CODSUSPREHA		VARCHAR2(3);
 VP_CODSERVICIOS	VARCHAR2(255):=NULL;
 VP_NUMMIN		    GA_ABOCEL.NUM_MIN%TYPE:=NULL;
 VP_NUMMIN_NUE		GA_ABOCEL.NUM_MIN%TYPE:=NULL;
 VP_TIPTECNOLOGIA	ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE:='GSM';
 VP_IMSI_NUE		ICC_MOVIMIENTO.IMSI%TYPE:=NULL;
 VP_IMEI			ICC_MOVIMIENTO.IMEI%TYPE:=NULL;
 VP_IMEI_NUE		ICC_MOVIMIENTO.IMEI%TYPE:=NULL;
 VP_ICC			    ICC_MOVIMIENTO.ICC%TYPE:=NULL;
 VP_ICC_NUE		    ICC_MOVIMIENTO.ICC%TYPE:=NULL;
 VP_CARGA		    ICC_MOVIMIENTO.CARGA%TYPE:=NULL;
 VP_CENTRAL_NUE		ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE:=NULL;
 VP_PLAN			ICC_MOVIMIENTO.PLAN%TYPE:=NULL;
 VP_VALORPLAN		ICC_MOVIMIENTO.VALOR_PLAN%TYPE:=NULL;
 VP_NUMMSNB		    ICC_MOVIMIENTO.NUM_MSNB%TYPE:=NULL;
 VP_NUMERROR		PV_ERRORES_OOSS_TO.COD_ERROR%TYPE:=0;
 VP_NUMOOSS		    PV_ERRORES_OOSS_TO.NUM_OS%TYPE:=0;
 VP_CODOS		    PV_ERRORES_OOSS_TO.COD_OS%TYPE:=0;
 VP_NUMMOVANT       ICC_MOVIMIENTO.NUM_MOVANT%TYPE:=NULL;
 
 
 V_GRP_TECNO_GSM   AL_TECNOLOGIA.COD_GRUPO%TYPE;
 V_GRP_TECNO_DMA   AL_TECNOLOGIA.COD_GRUPO%TYPE;

 V_GRP_TECNOLOGICO AL_TECNOLOGIA.COD_GRUPO%TYPE;
 V_CODACTUACION 	 GA_ACTABO.COD_ACTCEN%TYPE; -- Actuacion de central
 V_IMSI			 ICC_MOVIMIENTO.IMSI%TYPE;
 V_ICC			 ICC_MOVIMIENTO.ICC%TYPE;
 V_NUMSERIE		 ICC_MOVIMIENTO.NUM_SERIE%TYPE;


 v_Formato_Sel2   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 v_Formato_Sel7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 v_Formato_Sel19  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

 VP_FECHA_AUX   VARCHAR2(30); 
 ERROR_PROCESO EXCEPTION;
 
 CURSOR C1 is
 SELECT DISTINCT  B.NUM_ABONADO  FROM GA_SINIESTROS B
                              WHERE
                              B.COD_ESTADO = 'FO'
                              AND   B.FEC_FORMALIZA IS NOT NULL
                              AND TRUNC(B.FEC_FORMALIZA)-TRUNC(B.FEC_SINIESTRO)   >= 90
                              AND B.FEC_SINIESTRO IN (SELECT MAX(C.FEC_SINIESTRO) FROM GA_SINIESTROS C
                                                      WHERE C.NUM_ABONADO = B.NUM_ABONADO
                                                      AND   C.COD_ESTADO = 'FO'
                                                      AND   C.FEC_FORMALIZA IS NOT NULL
                                                      )                                                      
                              AND  B.NUM_ABONADO  IN (SELECT  A.NUM_ABONADO FROM GA_SUSPREHABO A
                                                                              WHERE  
                                                                              A.NUM_ABONADO=B.NUM_ABONADO
                                                                              AND   A.COD_SERVICIO = B.COD_SERVICIO
                                                                               AND   A.FEC_SUSPBD IN (SELECT  MAX(B.FEC_SUSPBD) FROM GA_SUSPREHABO B
                                                                                                     WHERE B.NUM_ABONADO  = B.NUM_ABONADO
                                                                                                     AND   B.COD_SERVICIO = B.COD_SERVICIO
                                                                                                     AND   B.TIP_SUSP     <>'T'
                                                                                                     AND   A.TIP_REGISTRO= 1)
                                                                              AND   A.TIP_SUSP     <>'T'
                                                                              AND   A.TIP_REGISTRO= 1);                     
                       
                       
BEGIN                                      

      
      SELECT valor_texto 
      into   LV_OPERADORA 
      FROM   ge_parametros_sistema_vw 
      WHERE  nom_parametro = 'COD_OPERADORA_LOCAL'
      AND    cod_modulo    ='GE';
      
      IF TRIM(LV_OPERADORA)  ='TMS' THEN
                      SELECT  TO_NUMBER(VAL_PARAMETRO) 
                      INTO LN_DIAS_SUSPE
                      FROM GED_PARAMETROS 
                      WHERE NOM_PARAMETRO='MAX_DIAS_SUSTOT'
                      AND COD_MODULO ='GA'; 
                      
                      OPEN C1;
                      
                      LOOP
                      FETCH C1 INTO LV_NUM_ABONADO;
                      EXIT WHEN C1%NOTFOUND;
                      
                                     
   
                                      BEGIN   
                                      SELECT A.COD_CENTRAL,A.NUM_CELULAR ,A.NUM_IMEI
                                      INTO   VP_CODCENTRAL,VP_NUMCELULAR,VP_IMEI
                                      FROM GA_ABOCEL A
                                      WHERE A.NUM_ABONADO =LV_NUM_ABONADO
                                      AND   A.COD_SITUACION ='SAA' 
                                      UNION
                                      SELECT A.COD_CENTRAL,A.NUM_CELULAR ,A.NUM_IMEI
                                      FROM GA_ABOAMIST A
                                      WHERE A.NUM_ABONADO =LV_NUM_ABONADO
                                      AND   A.COD_SITUACION ='SAA' ;
                      
                                       EXCEPTION
                                       
                                        WHEN NO_DATA_FOUND THEN
                                          VP_NUMCELULAR:= 0;
                                       END;
                                       
                                      IF (TRIM(VP_NUMCELULAR) <>''  ) OR (TRIM(VP_NUMCELULAR) IS NOT NULL  ) THEN     
                                              LV_COD_SERVICIO:='';
                                              
                                                    
                                              SELECT  A.COD_SERVICIO ,A.NUM_SERIE, A.FEC_SINIESTRO
                                              INTO   LV_COD_SERVICIO,VP_NUMSERIE, LD_SINIESTRO
                                              FROM  GA_SINIESTROS A
                                              WHERE A.NUM_ABONADO = LV_NUM_ABONADO
                                              AND   A.COD_ESTADO = 'FO' 
                                              AND   A.FEC_FORMALIZA IS NOT NULL 
                                              AND   A.FEC_SINIESTRO IN (SELECT  MAX(B.FEC_SINIESTRO) FROM GA_SINIESTROS B
                                                                        WHERE B.NUM_ABONADO = LV_NUM_ABONADO
                                                                        AND   B.COD_ESTADO = 'FO'
                                                                        AND   B.FEC_FORMALIZA IS NOT NULL);
                                                                      
                                              IF (TRIM(LV_COD_SERVICIO) <>''  ) OR (TRIM(LV_COD_SERVICIO) IS NOT NULL  ) THEN                        
                                              
                                              
                                                          LN_CANTIDAD := 0;  
                                                          SELECT  COUNT(1) 
                                                          INTO LN_CANTIDAD
                                                          FROM PV_REG_SUSTOT_JOB_TO
                                                          WHERE 
                                                          NUM_ABONADO = LV_NUM_ABONADO AND 
                                                          COD_ESTADO  = 1              AND
                                                          TRUNC(FEC_ING) > TRUNC(LD_SINIESTRO);
                                                          
                                                          IF LN_CANTIDAD = 0 THEN   
                                              
                                                                              UPDATE  GA_SUSPREHABO A
                                                                              SET   A.TIP_SUSP ='T' ,
                                                                                    A.TIP_REGISTRO ='1'
                                                                              WHERE A.NUM_ABONADO  = LV_NUM_ABONADO
                                                                              AND   A.COD_SERVICIO = LV_COD_SERVICIO
                                                                              AND   A.TIP_SUSP     <>'T'
                                                                              AND   A.FEC_SUSPBD IN (SELECT  MAX(B.FEC_SUSPBD) FROM GA_SUSPREHABO B
                                                                                                     WHERE B.NUM_ABONADO  = LV_NUM_ABONADO
                                                                                                     AND   B.COD_SERVICIO = LV_COD_SERVICIO
                                                                                                     AND   B.TIP_SUSP     <>'T');
                                                                              
                                                                            
                                                                              VP_FECINGRE:=SYSDATE;
                                                                              VP_TIPTERMINAL :='G';
                                                                              VP_CODSUSPREHA :=LV_COD_SERVICIO;	
                                                                
                                                                              V_GRP_TECNO_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
                                                                              V_GRP_TECNO_DMA := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_DMA');
                                                                              v_Formato_Sel2  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
                                                                              v_Formato_Sel7  := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL7');
                                                                              v_Formato_Sel19 := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL19');

                                                                              SELECT FN_CODACTCEN (1,VP_CODACTABO,VP_CODMODULO,VP_TIPTECNOLOGIA)
                                                                              INTO V_CODACTUACION
                                                                              FROM DUAL;
                 
                                                                             IF LTRIM(RTRIM(V_CODACTUACION)) = '' THEN
                                                                                RAISE ERROR_PROCESO;
                                                                             END IF;

                                                                             V_NUMSERIE	:= VP_NUMSERIE;
                                                                             IF V_NUMSERIE IS NULL OR TRIM(V_NUMSERIE) IS NULL  THEN 
                                                                                V_NUMSERIE := VP_ICC;
                                                                             END IF;

                                                                             IF V_GRP_TECNO_GSM = GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(VP_TIPTECNOLOGIA) THEN
                                                                                SELECT FN_RECUPERA_IMSI(V_NUMSERIE)
                                                                                  INTO V_IMSI
                                                                                  FROM DUAL;
                                                                                   VP_ICC   := VP_NUMSERIE;
                                                                             ELSE
                                                                                V_IMSI := 'NO ENTRO';
                                                                             END IF;


                                                                             SELECT ICC_SEQ_NUMMOV.NEXTVAL
                                                                              INTO VP_NUMSECUENCIA
                                                                              FROM DUAL;
                                                                             
                                                                             INSERT INTO ICC_MOVIMIENTO(NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO, COD_ACTABO, COD_MODULO,
                                                                                                             COD_ACTUACION,CARGA,COD_CENTRAL_NUE,
                                                                                                             NOM_USUARORA, FEC_INGRESO, TIP_TERMINAL, COD_CENTRAL,
                                                                                                             IND_BLOQUEO, TIP_TERMINAL_NUE, NUM_CELULAR,
                                                                                                             NUM_SERIE, NUM_CELULAR_NUE, NUM_SERIE_NUE,
                                                                                                             COD_SUSPREHA, COD_SERVICIOS,PLAN,VALOR_PLAN,
                                                                                                             NUM_MIN, NUM_MIN_NUE,NUM_MSNB,
                                                                                                             TIP_TECNOLOGIA, IMSI, IMSI_NUE, IMEI,
                                                                                                             IMEI_NUE, ICC, ICC_NUE
                                                                                                             ,NUM_MOVANT,STA
                                                                                                             )
                                                                                                      VALUES(VP_NUMSECUENCIA,LV_NUM_ABONADO,VP_CODESTADO,VP_CODACTABO,VP_CODMODULO,
                                                                                                             V_CODACTUACION,VP_CARGA,VP_CENTRAL_NUE,
                                                                                                             VP_USUARIO,SYSDATE,VP_TIPTERMINAL,VP_CODCENTRAL, 
                                                                                                             VP_INDBLOQUEO,VP_TIPTERMINAL_NUE,VP_NUMCELULAR,
                                                                                                             VP_NUMSERIE,VP_NUMCELULAR_NUE,VP_NUMSERIE_NUE,
                                                                                                             VP_CODSUSPREHA,VP_CODSERVICIOS,VP_PLAN,VP_VALORPLAN,
                                                                                                             VP_NUMMIN,VP_NUMMIN_NUE,VP_NUMMSNB,
                                                                                                             VP_TIPTECNOLOGIA,V_IMSI,VP_IMSI_NUE,VP_IMEI,
                                                                                                             VP_IMEI_NUE,VP_ICC,VP_ICC_NUE
                                                                                                             ,VP_NUMMOVANT,'S'
                                                                                                             );
                                                                                                                            
                                                                             INSERT INTO PV_REG_SUSTOT_JOB_TO(NUM_MOVIMIENTO  ,  
                                                                                                                 NUM_ABONADO     ,     
                                                                                                                 FEC_ING         ,
                                                                                                                 DES_GLOSA       ,
                                                                                                                 NOM_PROCESO     ,
                                                                                                                 COD_ESTADO
                                                                                                                 )
                                                                             VALUES
                                                                                (VP_NUMSECUENCIA,
                                                                                 LV_NUM_ABONADO ,
                                                                                 SYSDATE	,
                                                                                 'Se ha Procesado suspension bidireccional para abonado formalizados por siniestros', 
                                                                                 'PV_MOV_SUSPETOTSIN_PG.PV_REGISTRA_MOV_PR',
                                                                                 1
                                                                             );
                                                         ELSE
                                                         
                                                                                INSERT INTO PV_REG_SUSTOT_JOB_TO(NUM_MOVIMIENTO  ,  
                                                                                                                 NUM_ABONADO     ,     
                                                                                                                 FEC_ING         ,
                                                                                                                 DES_GLOSA       ,
                                                                                                                 NOM_PROCESO     ,
                                                                                                                 COD_ESTADO
                                                                                                                 )
                                                                                VALUES
                                                                                (0,
                                                                                 LV_NUM_ABONADO ,
                                                                                 SYSDATE	,
                                                                                 'No Se ha Procesado suspension bidireccional , ya tiene una suspension en proceso', 
                                                                                 'PV_MOV_SUSPETOTSIN_PG.PV_REGISTRA_MOV_PR',
                                                                                 0
                                                                                );                       
                                                         END IF;  
                                                         
                                              ELSE
                                                                                INSERT INTO PV_REG_SUSTOT_JOB_TO(NUM_MOVIMIENTO  ,  
                                                                                                                 NUM_ABONADO     ,     
                                                                                                                 FEC_ING         ,
                                                                                                                 DES_GLOSA       ,
                                                                                                                 NOM_PROCESO     ,
                                                                                                                 COD_ESTADO
                                                                                                                 )
                                                                                VALUES
                                                                                (0,
                                                                                 LV_NUM_ABONADO ,
                                                                                 SYSDATE	,
                                                                                 'No Se ha Procesado suspension bidireccional ,no tiene registro de siniestro', 
                                                                                 'PV_MOV_SUSPETOTSIN_PG.PV_REGISTRA_MOV_PR',
                                                                                 0
                                                                                );  
                                                         
                                              END IF;
                                      END IF;
                                             
                      END LOOP;
                      CLOSE C1;
      END IF;
      
      
      

      
EXCEPTION
                WHEN no_data_found THEN
                  SN_RESULTADO     :=0;
                  SV_SQLCODE       :=SQLCODE;
                  SV_SQLERRM       :=SQLERRM;
                  
                WHEN ERROR_PROCESO THEN
                  SN_RESULTADO     :=4;
                  SV_SQLCODE       :=SQLCODE;
                  SV_SQLERRM       :=SQLERRM;  
                     
                WHEN OTHERS THEN
                  SN_RESULTADO     :=4;
                  SV_SQLCODE       :=SQLCODE;
                  SV_SQLERRM       :=SQLERRM;
                         
END PV_REGISTRA_MOV_PR;                         
  

END PV_MOV_SUSPETOTSIN_PG;
/
