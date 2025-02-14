CREATE OR REPLACE PACKAGE BODY GSM_ANULACION_AUC_PG IS
-- *************************************************************
-- * Paquete            : GSM_ANULACION_AUC_PKG
-- * Descripci"n        : Subsistema de Gesti"n de Simcard.
-- * Fecha de creaci"n  : Agosto 2004
-- * Responsable        : Maritza Tapia A
-- *************************************************************

PROCEDURE GSM_INSERTA_MOVIMIENTO_PR (EN_solicitud IN  GSM_SOL_ANULACION_TO.NUM_SEQ_ANULACION%TYPE)
IS

        TN_cod_actabo    ICC_MOVIMIENTO.COD_ACTABO%TYPE;
        TN_cod_actuacion ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
        TV_tip_tecno     ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
        TN_cod_central   ICC_MOVIMIENTO.COD_CENTRAL%TYPE;
        v_serie_simcard  VARCHAR2(150);
        v_glosa_error    VARCHAR2(20);
        v_retorno        VARCHAR2(512);
        V_TABLA          VARCHAR2(200);
                CN_zero          PLS_INTEGER:=0;
        CN_uno            PLS_INTEGER:=1;
                CV_des_respuesta CONSTANT VARCHAR2(20):='PENDIENTE';
                CV_cod_modulo CONSTANT VARCHAR2(20):='GS';
        ERROR_PROCESO_GENERAL EXCEPTION;
        v_i         BINARY_INTEGER:=0;

                TYPE Tip_NumSimcard IS TABLE OF GSM_SIMCARD_TO.NUM_SIMCARD%TYPE INDEX BY BINARY_INTEGER;
        TYPE Tip_CodCentral IS TABLE OF ICG_CENTRAL.COD_CENTRAL%TYPE INDEX BY BINARY_INTEGER;
        TYPE Tip_Secuencia IS TABLE OF ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE INDEX BY BINARY_INTEGER;
        c_NumSimcard  Tip_NumSimcard;
        c_CodCentral  Tip_CodCentral;
                c_NumMovimiento Tip_Secuencia;


---------------------------------------------------------------------------------------------
-- CURSOR
---------------------------------------------------------------------------------------------

CURSOR Parametros IS
                SELECT  cod_identificador, des_parametro, cod_parametro
                FROM    GSM_PARAMETROS_TD
                WHERE   cod_identificador = 'VALBAJAAUC'
                                AND     cod_parametro IN ('TIP_TECNO','BAJA','ACTABO');

BEGIN
        V_TABLA := 'GSM_PARAMETROS_TD';
        FOR Param IN Parametros LOOP
                IF Param.COD_PARAMETRO =  'BAJA' THEN
                        TN_cod_actuacion := Param.DES_PARAMETRO;
                ELSE
                         IF Param.COD_PARAMETRO =  'TIP_TECNO' THEN
                                                TV_tip_tecno := Param.DES_PARAMETRO;
                        ELSE
                                                IF  Param.COD_PARAMETRO =  'ACTABO' THEN
                                                        TN_cod_actabo:= Param.DES_PARAMETRO;
                                                ELSE
                                                        v_retorno := 'Parametro invalido '|| Param.COD_PARAMETRO;
                                                        RAISE  ERROR_PROCESO_GENERAL;
                                                END IF;
                        END IF;
                END IF;
        END LOOP;



                BEGIN
                                V_TABLA := 'GSM_SIMCARD_TO/GSM_DETSOL_ANULACION_TO';


                                SELECT a.num_simcard, c.cod_central, icc_seq_nummov.NEXTVAL BULK COLLECT INTO c_NumSimcard,     c_CodCentral, c_NumMovimiento
                                  FROM icg_central c, gsm_simcard_to a, gsm_detsol_anulacion_to b
                                 WHERE b.num_seq_anulacion = EN_solicitud
                                   AND a.num_simcard = b.num_simcard
                                   AND c.cod_hlr = a.cod_hlr
                                   AND c.cod_central =
                                          (SELECT MAX (x.cod_central)
                                             FROM icg_central x
                                            WHERE x.cod_producto = 1
                                              AND x.cod_tecnologia = 'GSM'
                                              AND x.cod_hlr = a.cod_hlr);


                EXCEPTION
                WHEN NO_DATA_FOUND  THEN
                        v_retorno := 'Error en Recuperar las Simcard';
                        RAISE  ERROR_PROCESO_GENERAL;
                END;

                FORALL v_i IN c_NumSimcard.FIRST .. c_NumSimcard.LAST
                                INSERT INTO ICC_MOVIMIENTO
                                       (num_movimiento, num_abonado, cod_estado, cod_modulo,
                                        num_intentos, des_respuesta, cod_actuacion, cod_actabo,
                                        nom_usuarora, fec_ingreso, cod_central, num_celular, num_serie,
                                        tip_terminal, ind_bloqueo, num_min, tip_tecnologia, icc, imsi
                                       )
                                VALUES (c_NumMovimiento(v_i), CN_zero, CN_uno, CV_cod_modulo,
                                        CN_zero, CV_des_respuesta, TN_cod_actuacion, TN_cod_actabo,
                                        USER, SYSDATE, c_codcentral (v_i), CN_zero, '0',
                                        'D', CN_zero, 'min', TV_tip_tecno, c_numsimcard (v_i), '*'
                                       );


                 V_TABLA := 'GSM_DET_ANULACION_TO';
                 FORALL v_i IN c_NumSimcard.FIRST .. c_NumSimcard.LAST
                            UPDATE GSM_DETSOL_ANULACION_TO
                                SET    num_movimiento = c_NumMovimiento(v_i),
                                       fec_actualizacion = SYSDATE,
                                           cod_usuario = user
                                WHERE num_simcard = c_numsimcard (v_i);



    EXCEPTION
        WHEN ERROR_PROCESO_GENERAL THEN
        RAISE_APPLICATION_ERROR (-20001,'GSM_INSERTA_MOVIMIENTO_PR :' || V_TABLA ||' ' ||v_retorno);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20002,'GSM_INSERTA_MOVIMIENTO_PR : Envio SIMCARDS AUTENTIFICAR EN SIMCARD '|| v_serie_simcard || ' Error :' || V_TABLA || ' '|| TO_CHAR(SQLCODE) || ' ' ||SQLERRM);
END GSM_INSERTA_MOVIMIENTO_PR;

PROCEDURE GSM_PREFIJOS_RECICLADOS_PR(EV_num_simcard  GSM_SIMCARD_TO.NUM_SIMCARD%TYPE)
IS

        v_serie_simcard  VARCHAR2(150);
        v_glosa_error    VARCHAR2(20);
        v_retorno        VARCHAR2(512);
        V_TABLA          VARCHAR2(200);
        v_i              BINARY_INTEGER:=0;
                v_j              BINARY_INTEGER:=0;
                GB_Existe        BOOLEAN;
                TV_num_simcard   GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
                TV_des_parametro GSM_PARAMETROS_TD.DES_PARAMETRO%TYPE   ;
                GN_Secuencia     GSM_PREFIJOS_RECICLADOS_TO.NUM_SEQ_ASOCIACION%TYPE;
                GN_resp          BOOLEAN;
                VN_prefreciop    NUMBER(3);
                CN_count         NUMBER(3);
        ERROR_PROCESO_GENERAL EXCEPTION;

                TYPE TipRegReciclados IS RECORD (
                COD_CAMPO   GSM_DET_PREFIJOS_RECICLADOS_TO.COD_PREFIJO%TYPE,
                COD_VALOR   GSM_DET_PREFIJOS_RECICLADOS_TO.NUM_PREFIJO%TYPE,
                SECUENCIA   GSM_PREFIJOS_RECICLADOS_TO.NUM_SEQ_ASOCIACION%TYPE,
                COD_HLR     GSM_SIMCARD_TO.COD_HLR%TYPE,
                COD_MODULO  GSM_SIMCARD_TO.COD_MODULO%TYPE,
                COD_ESTADO  GSM_SIMCARD_TO.COD_ESTADO%TYPE,
                SIMCARD     GSM_SIMCARD_TO.NUM_SIMCARD%TYPE);
                TYPE TipTab_Reciclados   IS TABLE  OF  TipRegReciclados INDEX BY  BINARY_INTEGER;
                Tab_Reciclados        TipTab_Reciclados;

---------------------------------------------------------------------------------------------
-- CURSOR
---------------------------------------------------------------------------------------------

CURSOR Parametros IS

                SELECT DES_PARAMETRO
                FROM GSM_PARAMETROS_TD
                WHERE COD_IDENTIFICADOR = 'PREF_RECI'
                AND   COD_PARAMETRO <> 'HEADER'
                AND   COD_VIGENCIA = 1;

BEGIN
                        CN_count := GSM_ANULACION_AUC_PG.GSM_CANTIDAD_PARAMETROS_FN;

            TV_num_simcard :=  EV_num_simcard;
                        GN_resp := GSM_ANULACION_AUC_PG.Gsm_Valida_Simcard_Fn(CN_count, TV_num_simcard);

                        IF NOT GN_resp THEN
                                  GSM_RANGOS_PREFIJOS.GSM_RANGOS_SIMCARD(TV_num_simcard);

                        ELSE
                                        V_TABLA := 'En obtenci"n de la secuencia';
                                        BEGIN
                                                 SELECT GSM_RECICLADOS_SQ.NEXTVAL INTO GN_Secuencia FROM DUAL;
                                                 EXCEPTION
                                                        WHEN NO_DATA_FOUND  THEN
                                                           v_retorno := 'Error en obtener la secuencia';
                                                           RAISE  ERROR_PROCESO_GENERAL;
                                        END;


                                        FOR L IN Parametros  LOOP
                                        EXIT WHEN Parametros%NOTFOUND;
                                        TV_des_parametro := L.DES_PARAMETRO;
                                                V_TABLA := 'GSM_DET_SIMCARD_TO';
                                                BEGIN


                                                  SELECT DISTINCT e.cod_prefijo, f.val_campo, GN_Secuencia, a.cod_hlr, a.cod_modulo, a.cod_estado, a.num_simcard
                                                   INTO Tab_Reciclados(v_i).COD_CAMPO, Tab_Reciclados(v_i).COD_VALOR, Tab_Reciclados(v_i).SECUENCIA, Tab_Reciclados(v_i).COD_HLR, Tab_Reciclados(v_i).COD_MODULO, Tab_Reciclados(v_i).COD_ESTADO, Tab_Reciclados(v_i).SIMCARD
                                           FROM GSM_SIMCARD_TO a,
                                                GSM_DETSOL_SIMCARD_TO b,
                                                GSM_CAMPOS_TO c,
                                                GSM_PREFIJO_TO d,
                                                GSM_RANGOS_PREFIJOS_TO e,
                                                GSM_DET_SIMCARD_TO f
                                          WHERE a.num_simcard = TV_num_simcard
                                            AND f.num_simcard = a.num_simcard
                                            AND f.cod_campo = c.cod_campo
                                            AND b.num_seq_solicitud = a.num_seq_solicitud
                                            AND b.cod_campo = c.cod_campo
                                            AND c.ind_tabla = 'P'
                                            AND d.cod_prefijo = b.val_campo
                                            AND e.cod_prefijo = d.cod_prefijo
                                            AND b.cod_campo =  TV_des_parametro;

                                                        EXCEPTION
                                                                        WHEN NO_DATA_FOUND  THEN
                                                                          v_retorno := 'Error en obtener Prefijos';
                                                                          RAISE ERROR_PROCESO_GENERAL ;
                                                        END;
                                                        v_i := v_i +1 ;
                                        END LOOP;

                                        IF      VN_prefreciop > 0 THEN
                                                 GSM_ANULACION_AUC_PG.GSM_PREFIJOS_SIMCARD_PR(TV_num_simcard);
                                        END IF;




                        v_j := 0;
                        V_TABLA := 'GSM_PREFIJOS_RECICLADOS_TO';
                INSERT INTO GSM_PREFIJOS_RECICLADOS_TO
                             (num_seq_asociacion, cod_hlr, num_simcard, cod_modulo,
                              cod_estado, cod_estado_reciclado)
                      VALUES (Tab_Reciclados(v_j).SECUENCIA, Tab_Reciclados(v_j).COD_HLR, Tab_Reciclados(v_j).SIMCARD,
                              Tab_Reciclados(v_j).COD_MODULO,  Tab_Reciclados(v_j).COD_ESTADO, 'PB'
                             );



                        V_TABLA := 'GSM_DET_PREFIJOS_RECICLADOS_TO';
                FOR v_j IN Tab_Reciclados.FIRST .. Tab_Reciclados.LAST LOOP

                    INSERT INTO GSM_DET_PREFIJOS_RECICLADOS_TO
                                (num_seq_asociacion, cod_prefijo, num_prefijo)
                         VALUES (Tab_Reciclados(v_j).SECUENCIA, Tab_Reciclados(v_j).COD_CAMPO,
                                 Tab_Reciclados(v_j).COD_VALOR
                                );


                END LOOP;

                        V_TABLA := 'GSM_SIMCARD_TO';
                FOR v_j IN Tab_Reciclados.FIRST .. Tab_Reciclados.LAST LOOP
                                 DELETE GSM_SIMCARD_TO
                                 WHERE num_simcard = Tab_Reciclados(v_j).SIMCARD;
                END LOOP;

        END IF;

        EXCEPTION
        WHEN ERROR_PROCESO_GENERAL THEN
        RAISE_APPLICATION_ERROR (-20003,'GSM_PREFIJOS_RECICLADOS_PR :' || V_TABLA ||' ' ||v_retorno);
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20004,'GSM_PREFIJOS_RECICLADOS_PR : Error en Reciclamiento de Prefijos Error :' || V_TABLA || ' '|| TO_CHAR(SQLCODE) || ' ' ||SQLERRM);

END GSM_PREFIJOS_RECICLADOS_PR;

PROCEDURE GSM_PREFIJOS_SIMCARD_PR (V_SIMCARD IN GSM_SIMCARD_TO.NUM_SIMCARD%TYPE) IS

        V_GLOSA_ERROR  VARCHAR2(30);
        V_SECUENCIA    GSM_SIMCARD_TO.NUM_SIMCARD%TYPE;
        V_SOLICITUD    GSM_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE;
        V_PREFIJO      GSM_PREFIJO_TO.COD_PREFIJO%TYPE;
        V_INTERVALO    NUMBER(19):=0 ;
        V_SIGUE        BOOLEAN := TRUE;
        VP_SQLCODE     VARCHAR2(100);
        VP_SQLERRM             VARCHAR2(100);
        V_PREFIJO_GENERADO NUMBER(3);
        ERROR_PROCESO_G_RSIMCARD   EXCEPTION;

---------------------------------------------------------------------------------------------
-- CURSOR : Recupera prefijos asociados a una solicitud
---------------------------------------------------------------------------------------------
CURSOR  SIMCARD IS
                           SELECT DISTINCT e.cod_prefijo,
                                SUBSTR (f.val_campo,
                                         LENGTH (d.cod_prefijo_generado) + 1
                                       ) AS campo,
                                f.val_campo, f.cod_campo, b.num_seq_solicitud
                           FROM GSM_SIMCARD_TO a,
                                GSM_DETSOL_SIMCARD_TO b,
                                GSM_CAMPOS_TO c,
                                GSM_PREFIJO_TO d,
                                GSM_RANGOS_PREFIJOS_TO e,
                                GSM_DET_SIMCARD_TO f
                          WHERE a.num_simcard = v_simcard
                            AND f.num_simcard = a.num_simcard
                            AND f.cod_campo = c.cod_campo
                            AND b.num_seq_solicitud = a.num_seq_solicitud
                            AND b.cod_campo = c.cod_campo
                            AND c.ind_tabla = 'P'
                            AND d.cod_prefijo = b.val_campo
                            AND e.cod_prefijo = d.cod_prefijo
                            AND b.cod_campo <> 'ICC'
                                        AND b.cod_campo in (SELECT DES_PARAMETRO
                                                                                  FROM GSM_PARAMETROS_TD
                                                                                 WHERE COD_IDENTIFICADOR = 'PREFRECIOP'
                                                                                   AND   COD_PARAMETRO <> 'HEADER'
                                                                                   AND   COD_VIGENCIA = 1)
                       ORDER BY 1, 2;

BEGIN
---------------------------------------------------------------------------------------------
-- Validaci"n  parametros de entrada
---------------------------------------------------------------------------------------------
        IF V_SIMCARD IS NULL OR V_SIMCARD = '' THEN
                    V_GLOSA_ERROR := 'ERROR RANGOS_SIMCARD: Parametro de entrada, Nx de Simcard';
                    RAISE ERROR_PROCESO_G_RSIMCARD ;
        END IF;

        FOR R IN SIMCARD
        LOOP
            V_PREFIJO := R.COD_PREFIJO;
            V_SECUENCIA := R.CAMPO;

                IF R.COD_CAMPO <> 'IMSIR' and  R.COD_CAMPO <> 'IMSI' THEN
                                          Gsm_Rangos_Prefijos.INSERT_RANGOS_PREFIJO(V_PREFIJO,V_SECUENCIA, V_SECUENCIA, V_INTERVALO);

                END IF;
                END LOOP;

---------------------------------------------------------------------------------------------
-- INSERTA ICC
---------------------------------------------------------------------------------------------

            BEGIN
                SELECT DISTINCT LENGTH(C.COD_PREFIJO_GENERADO) + 1, C.COD_PREFIJO, A.NUM_SEQ_SOLICITUD
                  INTO V_PREFIJO_GENERADO, V_PREFIJO, V_SOLICITUD
                  FROM GSM_SIMCARD_TO A, GSM_DETSOL_SIMCARD_TO B, GSM_PREFIJO_TO C
                 WHERE A.NUM_SIMCARD = V_SIMCARD
                   AND A.NUM_SEQ_SOLICITUD = B.NUM_SEQ_SOLICITUD
                   AND B.COD_CAMPO = 'ICC'
                   AND B.VAL_CAMPO = C.COD_PREFIJO;
                   EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                                V_GLOSA_ERROR := 'ERROR SELECT GSM_SIMCARD_TO/GSM_DETSOL_SIMCARD_TO/GSM_PREFIJO_TO '|| V_SIMCARD;
                                RAISE  ERROR_PROCESO_G_RSIMCARD;
           END;

            V_SECUENCIA:= SUBSTR(SUBSTR(V_SIMCARD, V_PREFIJO_GENERADO),0, LENGTH(SUBSTR(V_SIMCARD, V_PREFIJO_GENERADO))-1);

            GSM_RANGOS_PREFIJOS.INSERT_RANGOS_PREFIJO(V_PREFIJO,V_SECUENCIA, V_SECUENCIA, V_INTERVALO);

            GSM_RANGOS_PREFIJOS.INSERTA_RANGOS_SOLICITUD(V_SOLICITUD);


    EXCEPTION
        WHEN ERROR_PROCESO_G_RSIMCARD  THEN
                RAISE_APPLICATION_ERROR (-20005,'GSM_PREFIJOS_SIMCARD_PR : ERROR_PROCESO_GENERAL ' ||V_GLOSA_ERROR );
     WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR (-20006,'GSM_PREFIJOS_SIMCARD_PR : ' || TO_CHAR(SQLCODE) || ' ' ||SQLERRM );

END GSM_PREFIJOS_SIMCARD_PR;


FUNCTION Gsm_Valida_Simcard_Fn(EN_Cantidad  IN NUMBER, EV_simcard GSM_SIMCARD_TO.NUM_SIMCARD%TYPE) RETURN BOOLEAN
is
VN_cont_parametros      NUMBER(3);
VN_contador_simcard     NUMBER(3);


BEGIN

                SELECT COUNT (1)
                  INTO VN_contador_simcard
                  FROM GSM_DET_SIMCARD_TO
                 WHERE num_simcard = EV_simcard
                   AND cod_campo IN (
                           SELECT des_parametro
                             FROM gsm_parametros_td
                            WHERE cod_identificador = 'PREF_RECI'
                                  AND cod_parametro <> 'HEADER'
                                                  AND cod_vigencia = 1);

                IF EN_Cantidad  = VN_contador_simcard THEN
                    RETURN TRUE;
                ELSE
                        RETURN FALSE;
                END IF;

   EXCEPTION
      WHEN NO_DATA_FOUND   THEN
                 RETURN FALSE;
      WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20007,'GSM_VALIDA_SIMCARD_FN : '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END;


FUNCTION GSM_CANTIDAD_PARAMETROS_FN RETURN   NUMBER
is
VN_cont_parametros  NUMBER;

BEGIN
                SELECT COUNT (1)
                INTO VN_cont_parametros
                FROM gsm_parametros_td
                WHERE cod_identificador = 'PREF_RECI'
                AND cod_parametro <> 'HEADER'
                AND cod_vigencia = 1;
                RETURN          VN_cont_parametros;
END;


END GSM_ANULACION_AUC_PG;
/
SHOW ERRORS
