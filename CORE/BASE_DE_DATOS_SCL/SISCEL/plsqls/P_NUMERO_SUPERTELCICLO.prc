CREATE OR REPLACE PROCEDURE P_NUMERO_SUPERTELCICLO (VP_CLIENTE IN NUMBER,
                                               VP_ABONADO IN NUMBER,
                                               VP_TELEFIJA IN VARCHAR2,
                                               VP_INDSTM  IN NUMBER,
                                               VP_OPREDFIJA IN NUMBER,
                                               VP_CICLO IN NUMBER,
                                               VP_FECSYS IN DATE,
                                               VP_PROC IN OUT VARCHAR2,
                                               VP_TABLA IN OUT VARCHAR2,
                                               VP_ACT IN OUT VARCHAR2,
                                               VP_SQLCODE IN OUT VARCHAR2,
                                               VP_SQLERRM IN OUT VARCHAR2,
                                               VP_ERROR IN OUT VARCHAR2) is
--
-- Procedimiento que refleja el numero de telefonia fija asociado a la linea
-- de supertelefono en las tablas de interfase con facturacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_CICLFACT GA_INFACCEL.COD_CICLFACT%TYPE;
   V_FECFIN DATE;
   V_FECNEXT DATE;
   V_CICLFACTNEXT GA_INFACCEL.COD_CICLFACT%TYPE;
   V_ROWID ROWID;
   V_ROWID2 ROWID;
   V_FECDESDEFIJOS DATE ;
   ERROR_PROCESO EXCEPTION;
BEGIN
    VP_PROC := 'P_NUMERO_SUPERTEL';
    VP_TABLA := 'FA_CICLFACT';
    VP_ACT := 'S';
--seleccion del proximo ciclo de facturacion
  SELECT min(FEC_DESDELLAM) INTO V_FECDESDEFIJOS
     FROM FA_CICLFACT
  WHERE COD_CICLO =VP_CICLO
       AND TRUNC(FEC_DESDELLAM) > TRUNC(sysdate)
       AND IND_FACTURACION = 0 ;
  SELECT COD_CICLFACT, FEC_DESDELLAM
    INTO V_CICLFACTNEXT, V_FECNEXT
  FROM FA_CICLFACT
    WHERE COD_CICLO = VP_CICLO
  AND FEC_DESDELLAM =  V_FECDESDEFIJOS
  AND IND_FACTURACION = 0
  AND ROWNUM = 1
  ORDER BY FEC_DESDELLAM;
  --  SELECT COD_CICLFACT, FEC_DESDELLAM
  --    INTO V_CICLFACTNEXT, V_FECNEXT
  --    FROM FA_CICLFACT
  --   WHERE COD_CICLO = VP_CICLO
  --    AND TRUNC(FEC_DESDECFIJOS) > TRUNC(VP_FECSYS)
  --    AND IND_FACTURACION = 0
  --    AND ROWNUM = 1
  --    ORDER BY FEC_DESDECFIJOS;
      V_FECFIN := V_FECNEXT - (1/(24*60*60));
--seleccionamos elciclo de facturacion actual
    VP_TABLA := 'FA_CICLFACT';
    VP_ACT := 'S';
    SELECT COD_CICLFACT
      INTO V_CICLFACT
      FROM FA_CICLFACT
    WHERE COD_CICLO = VP_CICLO
       AND VP_FECSYS BETWEEN FEC_DESDELLAM
                         AND FEC_HASTALLAM;
    VP_TABLA := 'GA_INFACCEL';
    VP_ACT := 'U';
 BEGIN
    SELECT ROWID INTO V_ROWID2
    FROM  GA_INFACCEL
    WHERE COD_CLIENTE  = VP_CLIENTE
       AND NUM_ABONADO  = VP_ABONADO
       AND COD_CICLFACT = V_CICLFACTNEXT
       AND IND_ACTUAC <> 6;
dbms_output.put_line ('update ga_infaccel' || VP_TELEFIJA || ' ' || VP_INDSTM || ' ' || VP_OPREDFIJA  );
    UPDATE GA_INFACCEL
       SET NUM_TELEFIJA = VP_TELEFIJA,
           IND_SUPERTEL = VP_INDSTM,
           COD_SUPERTEL = VP_OPREDFIJA
     WHERE ROWID = V_ROWID2;
 EXCEPTION
      WHEN NO_DATA_FOUND THEN
         dbms_output.put_line ('INSERT EN INFACCEL PARA EL SIGUIENTE ciclo');
--SI NO ENCONTRAMOS DATOS PARA EL PROXIMO CICLO SE AQADE NUEVO
                VP_TABLA := 'GA_INFACCEL';
                VP_ACT := 'I';
              INSERT INTO GA_INFACCEL (
                        COD_CLIENTE,
                        NUM_ABONADO,
                        COD_CICLFACT,
                        FEC_ALTA,
                        FEC_BAJA,
                        NUM_CELULAR,
                        IND_ACTUAC,
                        FEC_FINCONTRA,
                        IND_ALTA,
                        IND_DETALLE,
                        IND_FACTUR,
                        IND_CUOTAS,
                        IND_ARRIENDO ,
                        IND_CARGOS,
                        IND_PENALIZA,
                        IND_SUPERTEL,
                        NUM_TELEFIJA,
                        COD_SUPERTEL,
                        IND_CARGOPRO,
                        IND_CUENCONTROLADA)
                SELECT
                        COD_CLIENTE,
                        NUM_ABONADO,
                        V_CICLFACTNEXT,
                        V_FECNEXT,
                        TO_DATE('31-12-3000','DD-MM-YYYY'),
                        NUM_CELULAR,
                        IND_ACTUAC,
                        FEC_FINCONTRA,
                        IND_ALTA,
                        IND_DETALLE,
                        IND_FACTUR,
                        IND_CUOTAS,
                        IND_ARRIENDO,
                        IND_CARGOS,
                        IND_PENALIZA,
                        VP_INDSTM,
                        VP_TELEFIJA,
                        VP_OPREDFIJA,
                        IND_CARGOPRO,
                        IND_CUENCONTROLADA
                FROM GA_INFACCEL
                WHERE COD_CLIENTE  = VP_CLIENTE
                AND NUM_ABONADO  = VP_ABONADO
                AND COD_CICLFACT = V_CICLFACT
                AND IND_ACTUAC <> 6;
             VP_TABLA := 'GA_INFACCEL';
             VP_ACT := 'U';
--MODFIICAR FECHA DE BAJA DEL ANTERIOR CICLO
       UPDATE GA_INFACCEL
       SET FEC_BAJA = V_FECFIN
     WHERE COD_CLIENTE  = VP_CLIENTE
       AND NUM_ABONADO  = VP_ABONADO
       AND COD_CICLFACT = V_CICLFACT
       AND IND_ACTUAC <> 6;
        WHEN OTHERS THEN
         dbms_output.put_line ('ERROR CHUNGO');
                VP_ERROR := '4';
                RAISE ERROR_PROCESO;
 END;
        RAISE ERROR_PROCESO;
EXCEPTION
   WHEN ERROR_PROCESO THEN
                dbms_output.put_line ('Dentro del Error Proceso');
        IF VP_ERROR = '0' THEN
           BEGIN
              VP_TABLA := 'GA_FINCICLO';
              VP_ACT := 'S';
              SELECT ROWID
                INTO V_ROWID
                FROM GA_FINCICLO
               WHERE COD_CLIENTE = VP_CLIENTE
                 AND NUM_ABONADO = VP_ABONADO
                 AND COD_CICLFACT = V_CICLFACT;
              VP_TABLA := 'GA_FINCICLO';
              VP_ACT := 'U';
              UPDATE GA_FINCICLO
                 SET IND_SUPERTEL = VP_INDSTM,
                     NUM_TELEFIJA = VP_TELEFIJA ,
                     COD_OPREDFIJA =VP_OPREDFIJA,
                     FEC_DESDECARGOS = DECODE(FEC_DESDECARGOS,NULL,V_FECNEXT, FEC_DESDECARGOS)
               WHERE ROWID = V_ROWID;
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   VP_TABLA := 'GA_FINCICLO';
                   VP_ACT := 'I';
                  INSERT INTO GA_FINCICLO (COD_CLIENTE,
                                            COD_CICLFACT,
                                            NUM_ABONADO,
                                            COD_PRODUCTO,
                                            IND_SUPERTEL,
                                            NUM_TELEFIJA,
                                            COD_OPREDFIJA,
                                            FEC_DESDELLAM)
                                    VALUES (VP_CLIENTE,
                                            V_CICLFACT,
                                            VP_ABONADO,
                                            1,
                                            VP_INDSTM,
                                            VP_TELEFIJA,
                                            VP_OPREDFIJA,
                                            V_FECNEXT);
              WHEN OTHERS THEN
                   VP_SQLCODE := SQLCODE;
                   VP_SQLERRM := SQLERRM;
                   VP_ERROR := '4';
           END;
        ELSE
           IF VP_SQLCODE IS NULL THEN
              VP_SQLCODE := SQLCODE;
              VP_SQLERRM := SQLERRM;
            END IF;
        END IF;
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
        dbms_output.put_line ('KK:' || sqlerrm);
END;
/
SHOW ERRORS
