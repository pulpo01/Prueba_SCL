CREATE OR REPLACE PACKAGE BODY FA_ZONAIMPOSITIVA_PG IS
-------------------------------------------------------------------------------------------------------------
    PROCEDURE FA_RESPALDO_PR(
        EV_cod_ciclfact   IN NUMBER,
        EV_host_id        IN VARCHAR2)
    AS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "FA_RESPALDO_PR" Lenguaje="PL/SQL" Fecha="17-01-2006" Versión="1.1.0" Diseñador="JPP" Programador="****" Ambiente="BD">
    <Retorno>NA</Retorno>
    <Descripción>Respaldo de todos los registros de acumuladores de llamadas para aplicar zana impositiva </Descripción>
    <Parámetros>
    <Entrada>
    <param nom=""></param>
    </Entrada>
    <Salida>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
        LV_CodParam      NUMBER(3)   := 304;
        LV_CodProceso    VARCHAR2(5) := 'RZOIM';
        LV_CodMod        VARCHAR2(2) := 'FA';
        CV_CodEstadoTER  VARCHAR2(5) := 'TER';
        CV_enProc        VARCHAR2(5) := 'PRC';
        LV_cod_estado    VARCHAR2(5);
        LN_val_minimo    NUMBER(14);
        LN_val_maximo    NUMBER(14);
        LN_num_bloque    NUMBER(8);
        LN_ExistData     NUMBER(2);
        LV_modulo        VARCHAR2(8) := '0';
        LN_num_rowsproc  NUMBER(8)   := 0;
        v_rowid_min      ROWID;
        CN_cero          NUMBER(2)   := 0;
        CN_uno           NUMBER(2)   := 1;
        v_cod_carg       NUMBER(5);
        v_cod_operador   VARCHAR2(5);
        v_cod_grupo      NUMBER(8);
        v_ind_regi       VARCHAR2(2);
        v_cod_cliente    NUMBER(8);
        v_num_abonado    NUMBER(8);
        LV_cod_ciclfact  VARCHAR2(8);
        LV_num_proceso   NUMBER(8);
        v_ind_exedente   VARCHAR2(1);
        LV_cod_plan      VARCHAR2(5);
        LV_ind_billete   VARCHAR2(2);
        v_tip_mone       VARCHAR2(5);
        LV_tip_dcto      VARCHAR2(5);
        LV_cod_dcto      VARCHAR2(5);
        v_cod_item       VARCHAR2(5);
        GV_ind_unidad    VARCHAR2(5);
        v_mto_real       NUMBER(14,4);
        v_mto_fact       NUMBER(14,4);
        v_dur_real       NUMBER(9);
        GN_dur_fact      NUMBER(9);
        v_mto_dcto       NUMBER(14,4);
        v_dur_dcto       NUMBER(9);
        v_cnt_real       NUMBER(14,4);
        GN_cnt_llam_real NUMBER(8);
        GN_cnt_llam_dcto NUMBER(8);
        GN_cnt_llam_fact NUMBER(8);
        GN_val_inicial   NUMBER(14,4);
        LV_cod_areaa     VARCHAR2(5)  := ' ';
        v_count_ins      NUMBER(14)   :=0;
        LN_cod_clienteini NUMBER(10);
        LN_cod_clientefin NUMBER(10);
        LN_opcion_rango   NUMBER(1);
        LV_host_id        VARCHAR2(20);

        TYPE CursorType     IS REF CURSOR;
        cursorRespZonaImp   CursorType;
    BEGIN
        --*****************************************************************
        -- Identifica numero de bloques para procesamientos entre commit
        --*****************************************************************
        LN_num_bloque := 0;
        LV_modulo     := 0;

        LN_opcion_rango := 1;
        LV_host_id      := EV_host_id;
        BEGIN
            SELECT nvl(COD_CLIENTEINI,0),
                   nvl(COD_CLIENTEFIN,0)
              INTO LN_cod_clienteini,
                   LN_cod_clientefin
              FROM FA_RANGOSHOST_TO
            WHERE COD_CICLFACT = EV_cod_ciclfact
              AND HOST_ID = EV_host_id;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR (-20010, 'No existe Rango para dupla Host_ID y Ciclo de Facturacion');
          WHEN OTHERS THEN
            -- '(1) Error en Select FA_RANGOSHOST_TO (Bloque)
            RAISE_APPLICATION_ERROR (-20001, SQLERRM );
        END;

        BEGIN
            SELECT VAL_NUMERICO
              INTO LN_num_bloque
             FROM FAD_PARAMETROS
            WHERE COD_PARAMETRO   = LV_CodParam
              AND COD_MODULO  = LV_CodMod;
        EXCEPTION
          WHEN OTHERS THEN
            -- '(1) Error en Select FAD_PARAMETROS (Bloque)
            RAISE_APPLICATION_ERROR (-20001, SQLERRM );
        END;

        --************************************************************/
        --  While principal de procesamiento por bloques             */
        --************************************************************/
        LN_ExistData := CN_cero;
        WHILE ( LN_ExistData = CN_cero ) LOOP
            --*******************************************************
            -- Identifica Enganche en caso de haber caido antes
            --*******************************************************
            BEGIN
                SELECT val_minimo,
                       val_maximo,
                       cod_estado
                  INTO LN_val_minimo,
                       LN_val_maximo,
                       LV_cod_estado
                  FROM fa_recovery_to
                WHERE cod_proc  = LV_CodProceso
                 AND num_modulo = LV_modulo
                 AND ((HOST_ID = EV_host_id) OR (1 <> LN_opcion_rango));
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                LN_val_maximo := 0;
                LV_cod_estado := 'INI';
                BEGIN
                    INSERT INTO fa_recovery_to(
                        COD_PROC,
                        NUM_MODULO,
                        HOST_ID)
                    VALUES(
                        LV_CodProceso,
                        LV_modulo,
                        LV_host_id);
                EXCEPTION
                  WHEN OTHERS THEN
                    -- '(0) Error en INSERT FA_RECOVERY_TO '
                    RAISE_APPLICATION_ERROR (-20002, SQLERRM );
                END;
                COMMIT;
              WHEN OTHERS THEN
                -- '(1) Error en Select FA_RECOVERY_TO '
                RAISE_APPLICATION_ERROR (-20003, SQLERRM );
            END;

            --*********************************************************
            -- Control para la verificacion si tabla ya fue procesada *
            --*********************************************************

            LN_ExistData    := CN_uno;
            LN_num_rowsproc := 0;

            IF ( LV_cod_estado != CV_CodEstadoTER ) THEN  -- Si Estado = 'TER' Procesamiento ya Finalizado para el modulo
                BEGIN
                     SELECT  MIN(cod_cliente), MAX(cod_cliente)
                       INTO  LN_val_minimo,LN_val_maximo
                       FROM ( SELECT DISTINCT cod_cliente FROM tol_acumoper_to
                               WHERE ROWNUM < LN_num_bloque
                               AND cod_cliente > LN_val_maximo
                               AND ((COD_CLIENTE BETWEEN LN_cod_clienteini AND LN_cod_clientefin) OR (1<>LN_opcion_rango)));
                EXCEPTION
                        WHEN OTHERS THEN
                                -- '(2) Error en Select MIN y MAX para Bloque '
                                RAISE_APPLICATION_ERROR (-20004, SQLERRM );
                END;


                BEGIN
                    DECLARE CURSOR cursorRespZonaImp
                    IS
                    SELECT /*+ PARALLEL + INDEX (TOL_ACUMOPER_TO TOL_ACUM_CLIE_IE) */ --SAAM-200611100 Homologaciones P-COL-06046
                        COD_OPERADOR  ,
                        COD_REGI      ,
                        COD_GRUPO     ,
                        COD_CLIENTE   ,
                        NUM_ABONADO   ,
                        COD_CICLFACT  ,
                        NUM_PROCESO   ,
                        IND_EXEDENTE  ,
                        COD_PLAN      ,
                        IND_BILLETE   ,
                        COD_CARG      ,
                        nvl(TIP_DCTO,' '),
                        nvl(COD_DCTO,' '),
                        nvl(COD_ITEM,' '),
                        IND_UNIDAD    ,
                        CNT_INICIAL   ,
                        CNT_AUX       ,
                        MTO_REAL      ,
                        MTO_FACT      ,
                        MTO_DCTO      ,
                        DUR_REAL      ,
                        DUR_FACT      ,
                        DUR_DCTO      ,
                        TIP_MONE      ,
                        CNT_LLAM_REAL ,
                        CNT_LLAM_DCTO ,
                        CNT_LLAM_FACT ,
                        COD_AREAA
                      FROM TOL_ACUMOPER_TO A
                     WHERE A.COD_CLIENTE  BETWEEN LN_val_minimo AND LN_val_maximo;

                    BEGIN
                        OPEN cursorRespZonaImp;
                        LOOP
                            FETCH
                                  cursorRespZonaImp
                            INTO  v_cod_operador   ,
                                  v_ind_regi       ,
                                  v_cod_grupo      ,
                                  v_cod_cliente    ,
                                  v_num_abonado    ,
                                  LV_cod_ciclfact  ,
                                  LV_num_proceso   ,
                                  v_ind_exedente   ,
                                  LV_cod_plan      ,
                                  LV_ind_billete   ,
                                  v_cod_carg       ,
                                  LV_tip_dcto      ,
                                  LV_cod_dcto      ,
                                  v_cod_item       ,
                                  GV_ind_unidad    ,
                                  GN_val_inicial   ,
                                  v_cnt_real       ,
                                  v_mto_real       ,
                                  v_mto_fact       ,
                                  v_mto_dcto       ,
                                  v_dur_real       ,
                                  GN_dur_fact      ,
                                  v_dur_dcto       ,
                                  v_tip_mone       ,
                                  GN_cnt_llam_real ,
                                  GN_cnt_llam_dcto ,
                                  GN_cnt_llam_fact ,
                                  LV_cod_areaa;

                            EXIT WHEN cursorRespZonaImp%NOTFOUND;

                            LN_ExistData    := CN_cero;

                             -- ********************************************************************* --
                             -- Elimina Registros no vigentes por cambio de zona impositiva
                             -- Para evitar duplicar la llave a la hora de actualizar
                             -- ********************************************************************* --

                            BEGIN
                                   INSERT /*+ APPEND */ INTO FA_ACUMOPER_RESP_TH
                                      (COD_OPERADOR  , COD_REGI      , COD_GRUPO     , COD_CLIENTE   , NUM_ABONADO   ,
                                       COD_CICLFACT  , NUM_PROCESO   , IND_EXEDENTE  , COD_PLAN      , IND_BILLETE   ,
                                       COD_CARG      , TIP_DCTO      , COD_DCTO      , COD_ITEM      , IND_UNIDAD    ,
                                       CNT_INICIAL   , CNT_AUX       , MTO_REAL      , MTO_FACT      , MTO_DCTO      ,
                                       DUR_REAL      , DUR_FACT      , DUR_DCTO      , TIP_MONE      , CNT_LLAM_REAL ,
                                       CNT_LLAM_DCTO , CNT_LLAM_FACT , COD_AREAA )
                                   VALUES
                                      (v_cod_operador   , v_ind_regi       , v_cod_grupo     ,
                                       v_cod_cliente    , v_num_abonado   , LV_cod_ciclfact  , LV_num_proceso   ,
                                       v_ind_exedente   , LV_cod_plan     , LV_ind_billete   , v_cod_carg       ,
                                       LV_tip_dcto      , LV_cod_dcto     , v_cod_item       , GV_ind_unidad    ,
                                       GN_val_inicial   , v_cnt_real      , v_mto_real       , v_mto_fact       ,
                                       v_mto_dcto       , v_dur_real      , GN_dur_fact      , v_dur_dcto       ,
                                       v_tip_mone       , GN_cnt_llam_real, GN_cnt_llam_dcto , GN_cnt_llam_fact ,
                                       LV_cod_areaa);
                            EXCEPTION
                                    WHEN OTHERS THEN
                                            -- ROLLBACK;
                                            -- '(6) Error en Insert FA_ACUMOPER_RESP_TH'
                                            RAISE_APPLICATION_ERROR (-20005, SQLERRM || TO_CHAR(SQLCODE) );
                            END;

                            v_count_ins:= v_count_ins + SQL%ROWCOUNT;

                            IF ( SQL%ROWCOUNT = 0 ) THEN -- No Existe acumulador
                                -- '(2) No existe registro para actualizar tol_acumoper_to con nueva zona impositiva '
                                RAISE_APPLICATION_ERROR (-20007, SQLERRM );
                            END IF; --if (SQL%ROWCOUNT = 0)

                            LN_num_rowsproc := LN_num_rowsproc + CN_uno;
                        END LOOP;
                        CLOSE cursorRespZonaImp;
                    END;

                EXCEPTION
                  WHEN OTHERS THEN
                    -- '(2) Error Al Declarar Cursor'
                    RAISE_APPLICATION_ERROR (-20008, SQLERRM );
                END;

                IF ( LN_ExistData = CN_cero ) THEN
                    BEGIN
                        UPDATE
                            fa_recovery_to
                        SET
                            val_minimo = LN_val_minimo,
                            val_maximo = LN_val_maximo,
                            cod_estado = CV_enProc,
                            num_rows   = num_rows   + LN_num_rowsproc,
                            num_bloque = num_bloque + CN_uno
                        WHERE cod_proc   = LV_CodProceso
                          AND num_modulo = LV_modulo
                          AND ((HOST_ID = EV_host_id) OR (1 <> LN_opcion_rango));
                    EXCEPTION
                      WHEN OTHERS THEN
                         -- '(9) Error en Udate TOL_RECOVERY_TO '
                         RAISE_APPLICATION_ERROR (-20009, SQLERRM );
                    END;
                ELSE
                    BEGIN
                        UPDATE
                                fa_recovery_to
                        SET
                                cod_estado     = CV_CodEstadoTER
                        WHERE
                                cod_proc       = LV_CodProceso
                                AND num_modulo = LV_modulo;
                    EXCEPTION
                      WHEN OTHERS THEN
                           --'(10) Error en Udate de Termino TOL_RECOVERY_TO '
                           RAISE_APPLICATION_ERROR (-20010, SQLERRM );
                    END;
                END IF;
                COMMIT;
            END IF;  -- IF ( LV_cod_estado = CV_CodEstadoTER ) THEN;
        END LOOP; -- WHILE ( LN_ExistData = CN_cero ) LOOP  ;
    EXCEPTION
      WHEN OTHERS THEN
        IF ( SQLCODE <= -20000 AND SQLCODE >= -20999 ) THEN
             RAISE_APPLICATION_ERROR(SQLCODE, SUBSTR(SQLERRM,12) );
        ELSE
             RAISE_APPLICATION_ERROR(-20104, SQLERRM );
        END IF;
    END;
-------------------------------------------------------------------------------------------------------------
    PROCEDURE FA_AGRUPACION_PR(EV_fec_emision    IN DATE,
                               EV_cod_ciclfact   IN NUMBER,
                               EN_ExisteRango    IN NUMBER,
                               EN_ClienteInicial IN NUMBER,
                               EN_ClienteFinal   IN NUMBER)
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "FA_AGRUPACION_PR" Lenguaje="PL/SQL" Fecha="17-01-2006" Versión="1.1.0" Diseñador="JPP" Programador="****" Ambiente="BD">
    <Retorno>NA</Retorno>
    <Descripción>Agrupacion de de acumuladores de llamadas por zana impositiva </Descripción>
    <Parámetros>
    <Entrada>
    <param nom="EV_cod_ciclfac" Tipo="NUMBER">Ciclo a procesar</param>
    <param nom="EV_fec_emision" Tipo="DATE">Fecha de Emision</param>
    </Entrada>
    <Salida>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
    IS
        LV_CodParam      NUMBER(3)   := 304;
        LV_CodProceso    VARCHAR2(5) := 'ZOIMP';
        LV_CodMod        VARCHAR2(2) := 'FA';
        CV_CodEstadoTER  VARCHAR2(5) := 'TER';
        CV_enProc        VARCHAR2(5) := 'PRC';
        LV_cod_estado    VARCHAR2(5);
        LN_val_minimo    NUMBER(14);
        LN_val_maximo    NUMBER(14);
        LN_num_bloque    NUMBER(8);
        LN_ExistData     NUMBER(2);
        LV_modulo        VARCHAR2(8) := '0';
        LN_num_rowsproc  NUMBER(8)   := 0;
        v_rowid_min      ROWID;
        CN_cero          NUMBER(2)   := 0;
        CN_uno           NUMBER(2)   := 1;
        v_cod_carg       NUMBER(5);
        v_cod_operador   VARCHAR2(5);
        v_cod_grupo      NUMBER(8);
        v_ind_regi       VARCHAR2(2);
        v_cod_cliente    NUMBER(8);
        v_num_abonado    NUMBER(8);
        LV_cod_ciclfact  VARCHAR2(8);
        LV_num_proceso   NUMBER(8);
        v_ind_exedente   VARCHAR2(1);
        LV_cod_plan      VARCHAR2(5);
        LV_ind_billete   VARCHAR2(2);
        v_tip_mone       VARCHAR2(5);
        LV_tip_dcto      VARCHAR2(5);
        LV_cod_dcto      VARCHAR2(5);
        v_cod_item       VARCHAR2(5);
        GV_ind_unidad    VARCHAR2(5);
        v_mto_real       NUMBER(14,4);
        v_mto_fact       NUMBER(14,4);
        v_dur_real       NUMBER(9);
        GN_dur_fact      NUMBER(9);
        v_mto_dcto       NUMBER(14,4);
        v_dur_dcto       NUMBER(9);
        v_cnt_real       NUMBER(14,4);
        GN_cnt_llam_real NUMBER(8);
        GN_cnt_llam_dcto NUMBER(8);
        GN_cnt_llam_fact NUMBER(8);
        GN_val_inicial   NUMBER(14,4);
        LV_cod_areaa     VARCHAR2(5)  := ' ';
        LV_cod_areaa_old VARCHAR2(5)  := ' ';
        v_count_del      NUMBER(14)   :=0;
        v_count_upd      NUMBER(14)   :=0;
        LV_host          VARCHAR2(10);

        TYPE CursorType   IS REF CURSOR;
        cursorZonaImp   CursorType;
    BEGIN
        --*****************************************************************
        -- Identifica numero de bloques para procesamientos entre commit
        --*****************************************************************
        LN_num_bloque := 0;
        LV_modulo := EV_cod_ciclfact;

        BEGIN
            SELECT VAL_NUMERICO
              INTO LN_num_bloque
            FROM FAD_PARAMETROS
            WHERE COD_PARAMETRO   = LV_CodParam
              AND COD_MODULO  = LV_CodMod;
        EXCEPTION
          WHEN OTHERS THEN
            -- '(1) Error en Select FAD_PARAMETROS (Bloque)
            RAISE_APPLICATION_ERROR (-20001, SQLERRM );
        END;

        IF (EN_ExisteRango = 1) THEN
            BEGIN
                SELECT HOST_ID
                  INTO LV_host
                FROM FA_RANGOSHOST_TO
                WHERE COD_CICLFACT    = EV_cod_ciclfact
                  AND COD_CLIENTEINI  = EN_ClienteInicial
                  AND COD_CLIENTEFIN  = EN_ClienteFinal;
            EXCEPTION
              WHEN OTHERS THEN
                -- '(1) Error en Select FAD_PARAMETROS (Bloque)
                RAISE_APPLICATION_ERROR (-20001, SQLERRM );
            END;
        ELSE
            LV_host:= '';
        END IF;

        --************************************************************/
        --  While principal de procesamiento por bloques             */
        --************************************************************/
        LN_ExistData := CN_cero;
        WHILE ( LN_ExistData = CN_cero ) LOOP
            --*******************************************************
            -- Identifica Enganche en caso de haber caido antes
            --*******************************************************
            BEGIN
                SELECT VAL_MINIMO,
                       VAL_MAXIMO,
                       COD_ESTADO
                INTO   LN_val_minimo,
                       LN_val_maximo,
                       LV_cod_estado
                FROM FA_RECOVERY_TO
                WHERE COD_PROC   = LV_CodProceso
                  AND NUM_MODULO = LV_modulo
                  AND ((HOST_ID = LV_host) OR (1 <> EN_ExisteRango));
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                LN_val_maximo := 0;
                LV_cod_estado := 'INI';
                BEGIN
                    INSERT INTO FA_RECOVERY_TO(
                        COD_PROC,
                        NUM_MODULO,
                        HOST_ID)
                    VALUES(
                        LV_CodProceso,
                        LV_modulo,
                        LV_host);
                EXCEPTION
                  WHEN OTHERS THEN
                    -- '(0) Error en INSERT FA_RECOVERY_TO '
                    RAISE_APPLICATION_ERROR (-20002, SQLERRM );
                END;
                    COMMIT;
              WHEN OTHERS THEN
                -- '(1) Error en Select FA_RECOVERY_TO '
                RAISE_APPLICATION_ERROR (-20003, SQLERRM );
            END;

            --*********************************************************
            -- Control para la verificacion si tabla ya fue procesada *
            --*********************************************************

            LN_ExistData    := CN_uno;
            LN_num_rowsproc := 0;

            IF ( LV_cod_estado != CV_CodEstadoTER ) THEN  -- Si Estado = 'TER' Procesamiento ya Finalizado para el modulo
                BEGIN
                    SELECT MIN(cod_cliente),
                           MAX(cod_cliente)
                      INTO LN_val_minimo,
                           LN_val_maximo
                    FROM (SELECT DISTINCT COD_CLIENTE
                          FROM TOL_ACUMOPER_TO
                          WHERE ROWNUM < LN_num_bloque
                            AND COD_CLIENTE > LN_val_maximo
                            AND ((COD_CLIENTE BETWEEN EN_ClienteInicial AND EN_ClienteFinal) OR (1<>EN_ExisteRango))
                            AND COD_CICLFACT = EV_cod_ciclfact );
                EXCEPTION
                    WHEN OTHERS THEN
                    -- '(2) Error en Select MIN y MAX para Bloque '
                        RAISE_APPLICATION_ERROR (-20004, SQLERRM );
                END;


                BEGIN
                    dbms_output.put_line('LN_val_minimo : ' ||  LN_val_minimo || ' LN_val_maximo : ' || LN_val_maximo || ' LV_cod_estado : ' || LV_cod_estado );
                    DECLARE CURSOR cursorZonaImp IS
                        SELECT MIN(A.ROWID) AS LINEA,
                               A.COD_OPERADOR ,
                               A.COD_REGI     ,
                               A.COD_GRUPO  ,
                               A.COD_CLIENTE ,
                               A.NUM_ABONADO,
                               A.COD_CICLFACT ,
                               A.NUM_PROCESO  ,
                               A.IND_EXEDENTE ,
                               A.COD_PLAN   ,
                               A.IND_BILLETE ,
                               A.COD_CARG    ,
                               A.TIP_DCTO    ,
                               A.COD_DCTO    ,
                               A.COD_ITEM   ,
                               A.IND_UNIDAD  ,
                               SUM(A.CNT_INICIAL),
                               SUM(A.CNT_AUX) ,
                               SUM(A.MTO_REAL),
                               SUM(A.MTO_FACT),
                               SUM(A.MTO_DCTO),
                               SUM(A.DUR_REAL),
                               SUM(A.DUR_FACT),
                               SUM(A.DUR_DCTO),
                               A.TIP_MONE,
                               SUM(A.CNT_LLAM_REAL),
                               SUM(A.CNT_LLAM_DCTO),
                               SUM(A.CNT_LLAM_FACT),
                               NVL(B.COD_AREA_IMP,A.COD_AREAA)
                          FROM TOL_ACUMOPER_TO A,
                               FA_AREAIMP_TD B
                        WHERE A.COD_CLIENTE  BETWEEN LN_val_minimo AND LN_val_maximo
                          AND A.COD_CICLFACT = EV_cod_ciclfact
                          AND A.COD_AREAA    = B.COD_AREA (+)
                          AND SYSDATE BETWEEN B.FEC_INI_VIG (+) AND B.FEC_TER_VIG (+)
                        GROUP BY A.COD_OPERADOR,
                                 A.COD_REGI,
                                 A.COD_GRUPO,
                                 A.COD_CLIENTE,
                                 A.NUM_ABONADO,
                                 A.COD_CICLFACT,
                                 A.NUM_PROCESO,
                                 A.IND_EXEDENTE,
                                 A.COD_PLAN,
                                 A.IND_BILLETE,
                                 A.COD_CARG,
                                 A.TIP_DCTO,
                                 A.COD_DCTO,
                                 A.COD_ITEM,
                                 A.IND_UNIDAD,
                                 A.TIP_MONE,
                                 NVL(B.COD_AREA_IMP,A.COD_AREAA);
                    BEGIN
                        OPEN cursorZonaImp;
                        LOOP
                            FETCH cursorZonaImp
                             INTO v_rowid_min    ,
                                  v_cod_operador ,
                                  v_ind_regi     ,
                                  v_cod_grupo    ,
                                  v_cod_cliente  ,
                                  v_num_abonado  ,
                                  LV_cod_ciclfact,
                                  LV_num_proceso ,
                                  v_ind_exedente ,
                                  LV_cod_plan    ,
                                  LV_ind_billete ,
                                  v_cod_carg     ,
                                  LV_tip_dcto    ,
                                  LV_cod_dcto    ,
                                  v_cod_item     ,
                                  GV_ind_unidad  ,
                                  GN_val_inicial ,
                                  v_cnt_real     ,
                                  v_mto_real     ,
                                  v_mto_fact     ,
                                  v_mto_dcto     ,
                                  v_dur_real     ,
                                  GN_dur_fact    ,
                                  v_dur_dcto     ,
                                  v_tip_mone     ,
                                  GN_cnt_llam_real,
                                  GN_cnt_llam_dcto,
                                  GN_cnt_llam_fact ,
                                  LV_cod_areaa;

                            EXIT WHEN cursorZonaImp%NOTFOUND;

                            LN_ExistData    := CN_cero;

                            -- ********************************************************************* --
                            -- Elimina Registros no vigentes por cambio de zona impositiva
                            -- Para evitar duplicar la llave a la hora de actualizar
                            -- ********************************************************************* --

                            BEGIN
                                DELETE FROM TOL_ACUMOPER_TO A
                                WHERE A.rowid != v_rowid_min
                                  AND A.COD_OPERADOR     = v_cod_operador
                                  AND A.COD_REGI         = v_ind_regi
                                  AND A.COD_GRUPO        = v_cod_grupo
                                  AND A.COD_CLIENTE      = v_cod_cliente
                                  AND A.NUM_ABONADO      = v_num_abonado
                                  AND A.COD_CICLFACT     = LV_cod_ciclfact
                                  AND A.NUM_PROCESO      = LV_num_proceso
                                  AND A.IND_EXEDENTE     = v_ind_exedente
                                  AND A.COD_PLAN         = LV_cod_plan
                                  AND A.IND_BILLETE      = LV_ind_billete
                                  AND A.COD_CARG         = v_cod_carg
                                  AND A.TIP_DCTO         = LV_tip_dcto
                                  AND A.COD_DCTO         = LV_cod_dcto
                                  AND A.COD_ITEM         = v_cod_item
                                  AND A.IND_UNIDAD       = GV_ind_unidad
                                  AND A.TIP_MONE         = v_tip_mone
                                  AND A.COD_AREAA IN ( SELECT COD_AREA
                                                       FROM FA_AREAIMP_TD
                                                       WHERE COD_AREA_IMP = LV_cod_areaa);
                            EXCEPTION
                              WHEN OTHERS THEN
                                -- ROLLBACK;
                                -- '(6) Error en Update tol_acumoper CA '
                                RAISE_APPLICATION_ERROR (-20005, SQLERRM || TO_CHAR(SQLCODE) );
                            END;

                            dbms_output.put_line('rowid : ' ||  v_rowid_min || ' Zona : ' || LV_cod_areaa);

                            v_count_del:= v_count_del + SQL%ROWCOUNT;

                            -- ********************************************************************* --
                            -- Actualiza un registro (min rowid) con los nuevos acumulados y zona impositiva
                            -- ********************************************************************* --
                            BEGIN
                                UPDATE TOL_ACUMOPER_TO
                                SET
                                    mto_real      = v_mto_real,
                                    mto_fact      = v_mto_fact,
                                    mto_dcto      = v_mto_dcto,
                                    dur_real      = v_dur_real,
                                    dur_fact      = GN_dur_fact,
                                    dur_dcto      = v_dur_dcto,
                                    cnt_llam_real = GN_cnt_llam_real,
                                    cnt_llam_dcto = GN_cnt_llam_dcto,
                                    cnt_llam_fact = GN_cnt_llam_fact,
                                    cod_areaa     = LV_cod_areaa
                                WHERE ROWID =  v_rowid_min;
                            EXCEPTION
                              WHEN OTHERS THEN
                                -- '(3) Error en Update tol_acumoper_to con Zona Impositiva '
                                RAISE_APPLICATION_ERROR (-20006, SQLERRM );
                            END;

                            v_count_upd:= v_count_upd + SQL%ROWCOUNT;

                            IF ( SQL%ROWCOUNT = 0 ) THEN -- No Existe acumulador
                                -- '(2) No existe registro para actualizar tol_acumoper_to con nueva zona impositiva '
                                RAISE_APPLICATION_ERROR (-20007, SQLERRM );
                            END IF; --if (SQL%ROWCOUNT = 0)

                            LN_num_rowsproc := LN_num_rowsproc + CN_uno;
                        END LOOP;
                        CLOSE cursorZonaImp;
                    END;
                EXCEPTION
                  WHEN OTHERS THEN
                    -- '(2) Error Al Declarar Cursor'
                    RAISE_APPLICATION_ERROR (-20008, SQLERRM );
                END;

                IF ( LN_ExistData = CN_cero ) THEN
                    BEGIN
                        UPDATE fa_recovery_to
                        SET
                            VAL_MINIMO = LN_val_minimo,
                            VAL_MAXIMO = LN_val_maximo,
                            COD_ESTADO = CV_enProc,
                            NUM_ROWS   = num_rows   + LN_num_rowsproc,
                            NUM_BLOQUE = num_bloque + CN_uno
                        WHERE COD_PROC   = LV_CodProceso
                          AND NUM_MODULO = LV_modulo
                          AND ((HOST_ID = LV_host) OR (1 <> EN_ExisteRango));
                    EXCEPTION
                      WHEN OTHERS THEN
                        -- '(9) Error en Udate TOL_RECOVERY_TO '
                        RAISE_APPLICATION_ERROR (-20009, SQLERRM );
                    END;
                ELSE
                    BEGIN
                        UPDATE fa_recovery_to
                        SET
                            cod_estado     = CV_CodEstadoTER
                        WHERE cod_proc       = LV_CodProceso
                          AND num_modulo = LV_modulo;
                    EXCEPTION
                      WHEN OTHERS THEN
                        --'(10) Error en Udate de Termino TOL_RECOVERY_TO '
                        RAISE_APPLICATION_ERROR (-20010, SQLERRM );
                    END;
                END IF;
                COMMIT;
            END IF;  -- IF ( LV_cod_estado = CV_CodEstadoTER ) THEN;
        END LOOP; -- WHILE ( LN_ExistData = CN_cero ) LOOP  ;
    EXCEPTION
      WHEN OTHERS THEN
        IF ( SQLCODE <= -20000 AND SQLCODE >= -20999 ) THEN
            RAISE_APPLICATION_ERROR(SQLCODE, SUBSTR(SQLERRM,12) );
        ELSE
            RAISE_APPLICATION_ERROR(-20104, SQLERRM );
        END IF;
    END;
-------------------------------------------------------------------------------------------------------------
END FA_ZONAIMPOSITIVA_PG;
/
SHOW ERRORS
