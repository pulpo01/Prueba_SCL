CREATE OR REPLACE PROCEDURE        GA_P_MODIFICA_PTEINMEDIATO
 (VP_PRODUCTO IN NUMBER,
                VP_EMPRESA IN NUMBER,
                VP_PLANTARIF IN VARCHAR2,
                VP_FECSYS IN OUT DATE,
                VP_PROC IN OUT VARCHAR2,
                VP_TABLA IN OUT VARCHAR2,
                VP_ACT IN OUT VARCHAR2,
                VP_SQLCODE IN OUT VARCHAR2,
                VP_SQLERRM IN OUT VARCHAR2,
                VP_ERROR IN OUT VARCHAR2) is
--
-- Procedimiento que refleja el cambio y efectividad deL NUEVO PLANTARIFARIO
-- para empresas
-- en las tablas de interfase con tarificacion
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
--ABONADOS CELULAR
        CURSOR ABOCEL IS
           SELECT A.NUM_ABONADO,A.COD_CICLO, A.COD_CLIENTE
           FROM GA_INTARCEL A, GA_EMPRESA B
           WHERE A.COD_CLIENTE =B.COD_CLIENTE
           AND B.COD_EMPRESA=VP_EMPRESA
           AND A.TIP_PLANTARIF = 'E'
           AND VP_FECSYS BETWEEN A.FEC_DESDE AND A.FEC_HASTA;
--ABONADOS BEEPER
        CURSOR ABOBEEP IS
           SELECT A.NUM_ABONADO, A.COD_CICLO, A.COD_CLIENTE
           FROM GA_INTARBEEP A, GA_EMPRESA B
           WHERE A.COD_CLIENTE=B.COD_CLIENTE
	   AND B.COD_EMPRESA   = VP_EMPRESA
           AND A.TIP_PLANTARIF = 'E'
           AND VP_FECSYS BETWEEN A.FEC_DESDE AND A.FEC_HASTA;
V_CICLO FA_CICLOS.COD_CICLO%TYPE;
V_CLIENTE GE_CLIENTES.COD_CLIENTE%TYPE;
V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
VP_CODCARGOBASICO GA_ABOCEL.COD_PLANTARIF%type;
V_CLIENTE_AUX GA_ABOCEL.COD_CLIENTE%TYPE;
V_FILAS_PENDIENTES NUMBER;
V_PLANTARIF_CICLO GA_ABOCEL.COD_PLANTARIF%TYPE;
V_FECHA_CICLO GA_FINCICLO.FEC_DESDELLAM%TYPE;
V_FECHA_HASTA GA_INTARCEL.FEC_HASTA%TYPE;
V_ABONADO_EMPRESA GA_ABOCEL.NUM_ABONADO%TYPE;
V_DIAS TA_PLANTARIF.NUM_DIAS%TYPE;
ERROR_PROCESO EXCEPTION;
BEGIN
        V_ABONADO_EMPRESA:=0;
        VP_PROC := 'GA_P_MODIFICA_PTINMEDIATO';
        BEGIN
                SELECT COD_CLIENTE
                INTO V_CLIENTE_AUX
                FROM GA_EMPRESA
                WHERE COD_EMPRESA=VP_EMPRESA;
              EXCEPTION
           WHEN NO_DATA_FOUND THEN
               RAISE ERROR_PROCESO;
        END;
        BEGIN
           V_FILAS_PENDIENTES:=0;
           SELECT COUNT(*)
           INTO V_FILAS_PENDIENTES
           FROM GA_FINCICLO
           WHERE COD_CLIENTE= V_CLIENTE_AUX
           AND TIP_PLANTARIF='E'
           AND COD_PLANTARIF IS NOT NULL;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN
                V_FILAS_PENDIENTES :=0;
        END;
        IF VP_PRODUCTO = 1 THEN
        --LEEMOS DATOS DE ABONADOS CELULARES PERTENECIENTES A ESTE CLIENTE
           -- Validacisn de Cambios Pendientes.
           IF V_FILAS_PENDIENTES > 0 THEN
               BEGIN
                 --Elimina cambio pendiente en Ga_finciclo
                 VP_TABLA := 'GA_FINCICLO';
                 VP_ACT := 'S';
                 SELECT COD_PLANTARIF,FEC_DESDELLAM
                  INTO V_PLANTARIF_CICLO,V_FECHA_CICLO
                 FROM GA_FINCICLO
                 WHERE COD_CLIENTE=V_CLIENTE_AUX
                 AND COD_PLANTARIF IS NOT NULL
                 AND TIP_PLANTARIF='E'
                 AND ROWNUM =1;
                 VP_TABLA := 'GA_INTARCEL';
                 VP_ACT := 'S';
                 SELECT FEC_HASTA
                 INTO V_FECHA_HASTA
                 FROM GA_INTARCEL
                 WHERE COD_CLIENTE=V_CLIENTE_AUX
                 AND NUM_ABONADO=V_ABONADO_EMPRESA
                 AND FEC_DESDE = V_FECHA_CICLO;
                 VP_TABLA := 'GA_INTARCEL';
                 VP_ACT := 'U';
                 UPDATE GA_INTARCEL
                   SET FEC_HASTA=V_FECHA_HASTA
                 WHERE COD_CLIENTE=V_CLIENTE_AUX
                 AND VP_FECSYS BETWEEN FEC_DESDE AND FEC_HASTA;
                 VP_TABLA := 'GA_INTARCEL';
                 VP_ACT := 'D';
                 DELETE GA_INTARCEL
                 WHERE COD_CLIENTE=V_CLIENTE_AUX
                 AND FEC_DESDE = V_FECHA_CICLO;
                 VP_TABLA := 'GA_FINCICLO';
                 VP_ACT := 'D';
                 DELETE GA_FINCICLO
                 WHERE COD_CLIENTE=V_CLIENTE_AUX
                 AND COD_PLANTARIF IS NOT NULL
                 AND TIP_PLANTARIF ='E';
               EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                    RAISE ERROR_PROCESO;
                 WHEN OTHERS THEN
                   RAISE ERROR_PROCESO;
               END;
           END IF;
           OPEN ABOCEL;
           LOOP
                        FETCH ABOCEL INTO V_ABONADO, V_CICLO, V_CLIENTE;
                        EXIT WHEN ABOCEL%NOTFOUND;
                        --LLAMAMOS AL PL DE CAMBIO DE CICLO POR ABONADO
                        GA_P_CAMBIO_PLANTARIF2(VP_PRODUCTO, V_CLIENTE, V_ABONADO, VP_PLANTARIF,
                                        V_CICLO, VP_EMPRESA, VP_FECSYS, VP_PROC, VP_TABLA, VP_ACT, VP_SQLCODE,
                                        VP_SQLERRM, VP_ERROR);
                        IF VP_ERROR = '4' THEN
                                -- SI FALLA AUNQUE SOLO SEA EN UNO NOS SALIMOS
                                RAISE ERROR_PROCESO;
                        END IF;
            END LOOP;
            CLOSE ABOCEL;
           --CAMBIAMOS EL CICLO A LOS QUE NO ESTEN EN LAS INTAR
            BEGIN
                 SELECT COD_CARGOBASICO,NUM_DIAS
                 INTO VP_CODCARGOBASICO,V_DIAS
                 FROM TA_PLANTARIF
                 WHERE COD_PLANTARIF=VP_PLANTARIF
                 AND COD_PRODUCTO=1;
                 UPDATE GA_ABOCEL
                         SET COD_PLANTARIF = VP_PLANTARIF,
                              COD_CARGOBASICO=VP_CODCARGOBASICO,
                             FEC_CUMPLAN=VP_FECSYS + V_DIAS
                 WHERE TIP_PLANTARIF = 'E'
                 AND COD_EMPRESA = VP_EMPRESA;
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         NULL;
                    WHEN OTHERS THEN
                         VP_ERROR := '4';
                         RAISE ERROR_PROCESO;
                   END;
        END IF;
        IF VP_PRODUCTO = 2 THEN
        --LEEMOS DATOS DE ABONADOS BEEPERS PERTENECIENTES A ESTE CLIENTE
                VP_TABLA := 'GA_ABOBEEP';
                OPEN ABOBEEP;
                LOOP
                        FETCH ABOBEEP INTO V_ABONADO, V_CICLO, V_CLIENTE;
                        EXIT WHEN ABOBEEP%NOTFOUND;
                        --LLAMAMOS AL PL DE CAMBIO DE CICLO POR ABONADO
                        GA_P_CAMBIO_PLANTARIF2(VP_PRODUCTO, V_CLIENTE, V_ABONADO, VP_PLANTARIF,
                                        V_CICLO, VP_EMPRESA, VP_FECSYS, VP_PROC, VP_TABLA, VP_ACT, VP_SQLCODE,
                                        VP_SQLERRM, VP_ERROR);
                        IF VP_ERROR = '4' THEN
                                -- SI FALLA AUNQUE SOLO SEA EN UNO NOS SALIMOS
                                RAISE ERROR_PROCESO;
                        END IF;
                END LOOP;
                CLOSE ABOBEEP;
                  BEGIN
                        UPDATE GA_ABOBEEP SET COD_PLANTARIF = VP_PLANTARIF
                        WHERE TIP_PLANTARIF = 'E'
                        AND COD_EMPRESA = VP_EMPRESA;
                   EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                NULL;
                        WHEN OTHERS THEN
                                VP_ERROR := '4';
                                RAISE ERROR_PROCESO;
                   END;
        END IF;
EXCEPTION
 WHEN ERROR_PROCESO THEN
   VP_ERROR := 4;
 WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
