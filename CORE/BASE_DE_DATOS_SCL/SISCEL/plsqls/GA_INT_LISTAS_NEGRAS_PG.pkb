CREATE OR REPLACE PACKAGE BODY GA_INT_LISTAS_NEGRAS_PG AS
--INC 1-1 158942 JRCH 10-12-2010
--INC 1-2 158942 JRCH 23-12-2010
FUNCTION GA_CONTADOR_VAL_FN (EV_NOM_SECUENCIA IN VARCHAR2)RETURN NUMBER
/*
Función que retorna cantidad de registros válidos
*/
IS
LV_cantidad number;
BEGIN
    SELECT COUNT(1) into LV_cantidad
    FROM ga_series_ln_oop_to a
    WHERE a.cod_proceso = EV_NOM_SECUENCIA
    AND a.cod_estado = CN_estado_valido;
    RETURN LV_cantidad;
END GA_CONTADOR_VAL_FN;

------------------------------------------------------------------------------

FUNCTION GA_CONTADOR_INV_FN (EV_NOM_SECUENCIA IN VARCHAR2)RETURN NUMBER
/*
Función que retorna cantidad de registros válidos
*/
IS
LV_cantidad number;
BEGIN
    SELECT COUNT(1) into LV_cantidad
    FROM ga_series_ln_oop_to a
    WHERE a.cod_proceso = EV_NOM_SECUENCIA
    AND a.cod_estado != CN_estado_valido;
    RETURN LV_cantidad;
END GA_CONTADOR_INV_FN;

------------------------------------------------------------------------------

FUNCTION GA_REC_SECUENCIA_FN (EV_NOM_SECUENCIA IN VARCHAR2)RETURN NUMBER

/*
Función para recuperar número de secuencia de la tabla "GA_SERIES_LN_OOP_TO"
valor: GA_SERIESLN_SQ
*/

IS
LV_sql             VARCHAR2(250);
LN_secuencia    NUMBER;
BEGIN

    LV_sql := 'SELECT '||EV_NOM_SECUENCIA||'.NEXTVAL FROM DUAL';
    EXECUTE IMMEDIATE LV_sql INTO LN_secuencia;
    RETURN LN_secuencia;

END GA_REC_SECUENCIA_FN;

------------------------------------------------------------------------------
FUNCTION GA_REG_SERIES_LN_FN(LT_tabla_tmp       IN  TIP_GA_LNCELU,
                            SN_COD_ERROR        OUT ge_errores_pg.CodError,
                            SV_MENS_RETORNO     OUT ge_errores_pg.MsgError,
                            SV_SQL              OUT ge_errores_pg.vQuery
) RETURN BOOLEAN
/*
Recibe el objeto "LT_tabla_tmp" y lo inserta en la tabla "GA_LNCELU"
*/

IS
    i NUMBER;
BEGIN
    SN_COD_ERROR:=0;
    SV_SQL:='INSERT INTO GA_LNCELU VALUES LT_tabla_tmp(i)';
    FORALL i IN 1..LT_tabla_tmp.COUNT
    INSERT INTO GA_LNCELU VALUES LT_tabla_tmp(i);

    RETURN TRUE;

    EXCEPTION
        WHEN OTHERS THEN
            SN_COD_ERROR  := 1127;
            SV_MENS_RETORNO := 'GA_REG_SERIES_LN_FN' ||' : '||SQLERRM;
            RETURN FALSE;
END GA_REG_SERIES_LN_FN;
----------------------------------------------------------------------------------

FUNCTION GA_SEL_SERIES_LN_FN(EN_COD_PROCESO      IN   ga_series_ln_oop_to.cod_proceso%TYPE,
                            LT_tabla_tmp         OUT  TIP_GA_LNCELU,
                            SN_COD_ERROR         OUT  ge_errores_pg.CodError,
                            SV_MENS_RETORNO      OUT  ge_errores_pg.MsgError,
                            SV_SQL               OUT  ge_errores_pg.vQuery
) RETURN BOOLEAN
/*
Devuelve el objeto "LT_tabla_tmp" con los registros válidos
correspondientes al EN_COD_PROCESO y con el tipo de acción INGRESO
para insertarlos en la tabla "GA_LNCELU"
*/
IS
    LV_IND_PROCEQUI     GA_LNCELU.ind_procequi%TYPE;
    LN_COD_FABRICANTE   GA_LNCELU.cod_fabricante%TYPE;
    LN_COD_ARTICULO     GA_LNCELU.cod_articulo%TYPE;
    LV_NUM_SERIEMEC     GA_LNCELU.num_seriemec%TYPE;
    LN_NUM_CELULAR      GA_LNCELU.num_celular%TYPE;
    LN_NUM_ABONADO      GA_LNCELU.num_abonado%TYPE;
    LN_COD_CLIENTE      GA_LNCELU.cod_cliente%TYPE;
    LN_IND_RESTRICCION  GA_LNCELU.ind_restriccion%TYPE;
    LN_COD_ASEG         GA_LNCELU.cod_aseg%TYPE;
    LD_FEC_CONSTPOL     GA_LNCELU.fec_constpol%TYPE;
    LV_TIP_ABONADO      GA_LNCELU.tip_abonado%TYPE;
    LV_COD_CAUSA        GA_LNCELU.cod_causa%TYPE;
    LV_IND_INFORMADO    GA_LNCELU.ind_informado%TYPE;
    LV_TIP_LISTA        GA_LNCELU.tip_lista%TYPE;
    LV_COD_OPERADOR     ga_series_ln_oop_to.CAMPO_1%TYPE;
    LD_FEC_ALTA         ga_series_ln_oop_to.CAMPO_4%TYPE;
    LV_NUM_CONSTPOL     ga_series_ln_oop_to.CAMPO_8%TYPE;
    LV_DES_CAUSA        ga_series_ln_oop_to.CAMPO_5%TYPE;
    LV_DES_MARCA_EQUIPO ga_series_ln_oop_to.CAMPO_6%TYPE;
    LV_NUM_SERIE        ga_series_ln_oop_to.CAMPO_3%TYPE;
    i NUMBER;



    CURSOR C1 IS
    SELECT  a.campo_3, TO_NUMBER(a.campo_1),TO_CHAR(sysdate,'ddmmyy hh24mi'),
            a.campo_8, a.campo_5, a.campo_6
    FROM    ga_series_ln_oop_to a
    WHERE   a.cod_proceso = EN_COD_PROCESO
    AND     a.campo_7 = CN_accion_ingreso
    AND     a.cod_estado = CN_estado_valido;




BEGIN
    SN_COD_ERROR:=0;
    --SV_MENS_RETORNO:='Error al buscar datos para insertar en GA_LNCELU';

    LV_IND_PROCEQUI     := 'E';
    LN_COD_FABRICANTE   := 0;
    LN_COD_ARTICULO     := 0;
    LV_NUM_SERIEMEC     := '';
    LN_NUM_CELULAR      := 0;
    LN_NUM_ABONADO      := 0;
    LN_COD_CLIENTE      := 0;
    LN_IND_RESTRICCION  := 0;
    LN_COD_ASEG         := 0;
    LD_FEC_CONSTPOL     := null;
    LV_TIP_ABONADO      := '';
    LV_COD_CAUSA        := '';
    LV_IND_INFORMADO    := '0';
    LV_TIP_LISTA        := 'B';

    i:=1;

    OPEN C1;
        LOOP
        FETCH C1 INTO LV_NUM_SERIE,LV_COD_OPERADOR,LD_FEC_ALTA,LV_NUM_CONSTPOL,LV_DES_CAUSA,LV_DES_MARCA_EQUIPO;
        EXIT WHEN C1%NOTFOUND;


                        LT_tabla_tmp(i).NUM_SERIE        :=LV_NUM_SERIE    ;
                        LT_tabla_tmp(i).IND_PROCEQUI     :=LV_IND_PROCEQUI ;
                        LT_tabla_tmp(i).COD_OPERADOR     :=TO_NUMBER(LV_COD_OPERADOR) ;
                        LT_tabla_tmp(i).COD_FABRICANTE   :=LN_COD_FABRICANTE ;
                        LT_tabla_tmp(i).COD_ARTICULO     :=LN_COD_ARTICULO   ;
                        LT_tabla_tmp(i).NUM_SERIEMEC     :=LV_NUM_SERIEMEC   ;
                        LT_tabla_tmp(i).NUM_CELULAR      :=LN_NUM_CELULAR    ;
                        LT_tabla_tmp(i).NUM_ABONADO      :=LN_NUM_ABONADO    ;
                        LT_tabla_tmp(i).COD_CLIENTE      :=LN_COD_CLIENTE    ;
                        LT_tabla_tmp(i).FEC_ALTA         :=to_date(LD_FEC_ALTA,'ddmmyy hh24mi');
                        LT_tabla_tmp(i).IND_RESTRICCION  :=LN_IND_RESTRICCION ;
                        LT_tabla_tmp(i).COD_ASEG         :=LN_COD_ASEG        ;
                        LT_tabla_tmp(i).FEC_CONSTPOL     := LD_FEC_CONSTPOL   ;
                        LT_tabla_tmp(i).NUM_CONSTPOL     :=LV_NUM_CONSTPOL    ;
                        LT_tabla_tmp(i).TIP_ABONADO      :=LV_TIP_ABONADO     ;
                        LT_tabla_tmp(i).COD_CAUSA        :=LV_COD_CAUSA       ;
                        LT_tabla_tmp(i).IND_INFORMADO    := LV_IND_INFORMADO  ;
                        LT_tabla_tmp(i).TIP_LISTA        :=LV_TIP_LISTA       ;
                        LT_tabla_tmp(i).DES_CAUSA        :=LV_DES_CAUSA       ;
                        LT_tabla_tmp(i).DES_MARCA_EQUIPO :=LV_DES_MARCA_EQUIPO;

           i:= i +1;
        END LOOP;
    CLOSE C1;





    RETURN TRUE;

    EXCEPTION
        WHEN OTHERS THEN
            SN_COD_ERROR  := 1128;
            SV_MENS_RETORNO := 'GA_SEL_SERIES_LN_FN' ||' : '||SQLERRM;
            RETURN FALSE;
END GA_SEL_SERIES_LN_FN;

----------------------------------------------------------------------------------

FUNCTION GA_DEL_SERIES_EG_FN(EN_COD_PROCESO      IN   ga_series_ln_oop_to.cod_proceso%TYPE,
                            SN_COD_ERROR         OUT ge_errores_pg.CodError,
                            SV_MENS_RETORNO      OUT ge_errores_pg.MsgError,
                            SV_SQL               OUT ge_errores_pg.vQuery
) RETURN BOOLEAN
/*
Elimina los registros válidos
correspondientes al EN_COD_PROCESO y con el tipo de acción EGRESO
de la tabla "GA_LNCELU"
*/
IS
    i NUMBER;

BEGIN
    SN_COD_ERROR:=0;
    --SV_MENS_RETORNO:='Error al buscar datos para insertar en GA_LNCELU';

    DELETE FROM GA_LNCELU a
        WHERE EXISTS (SELECT 1
                    FROM ga_series_ln_oop_to b
                    WHERE b.cod_proceso = EN_COD_PROCESO
                    AND   b.campo_7 = CN_accion_egreso
                    AND   b.cod_estado = CN_estado_valido
                    AND   b.campo_3 = a.num_serie);

    RETURN TRUE;

    EXCEPTION
        WHEN OTHERS THEN
            SN_COD_ERROR  := 1129;
            SV_MENS_RETORNO := 'GA_DEL_SERIES_EG_FN' ||' : '||SQLERRM;
            RETURN FALSE;
END GA_DEL_SERIES_EG_FN;


----------------------------------------------------------------------------------

FUNCTION GA_SEL_SERIES_VAL_FN(EN_COD_PROCESO      IN   ga_series_ln_oop_to.cod_proceso%TYPE,
                            LT_tabla_tmp         OUT  TIP_ga_series_ln_oop_to,
                            SN_COD_ERROR         OUT ge_errores_pg.CodError,
                            SV_MENS_RETORNO      OUT ge_errores_pg.MsgError,
                            SV_SQL               OUT ge_errores_pg.vQuery
) RETURN BOOLEAN
/*
Devuelve el objeto "LT_tabla_tmp" con todas las series válidas
correspondientes al EN_COD_PROCESO
*/
IS
lv_COD_PROCESO  ga_series_ln_oop_to.COD_PROCESO%type;
lv_CAMPO_1      ga_series_ln_oop_to.CAMPO_1%type;
lv_CAMPO_2      ga_series_ln_oop_to.CAMPO_2%type;
lv_CAMPO_3      ga_series_ln_oop_to.CAMPO_3%type;
lv_CAMPO_4      ga_series_ln_oop_to.CAMPO_4%type;
lv_CAMPO_5      ga_series_ln_oop_to.CAMPO_5%type;
lv_CAMPO_6      ga_series_ln_oop_to.CAMPO_6%type;
lv_CAMPO_7      ga_series_ln_oop_to.CAMPO_7%type;
lv_CAMPO_8      ga_series_ln_oop_to.CAMPO_8%type;
lv_CAMPO_9      ga_series_ln_oop_to.CAMPO_9%type;
lv_COD_ESTADO   ga_series_ln_oop_to.COD_ESTADO%type;
lv_des_error    ga_series_ln_oop_to.des_error%type;
lv_indice       ga_series_ln_oop_to.indice%type;

i number(3);

CURSOR C1 IS
SELECT  a.cod_proceso, a.campo_1, a.campo_2, a.campo_3,
            a.campo_4, a.campo_5, a.campo_6, a.campo_7, a.campo_8,
            a.campo_9, a.cod_estado, a.des_error, a.indice
    FROM    ga_series_ln_oop_to a
    WHERE   a.cod_proceso = EN_COD_PROCESO
    AND     a.cod_estado = CN_estado_valido;

BEGIN
    SN_COD_ERROR := 0;

    i:=1;

    OPEN C1;
        LOOP
        FETCH C1 INTO lv_COD_PROCESO,lv_CAMPO_1,lv_CAMPO_2,lv_CAMPO_3,lv_CAMPO_4,lv_CAMPO_5,
                      lv_CAMPO_6,lv_CAMPO_7,lv_CAMPO_8,lv_CAMPO_9,lv_COD_ESTADO,lv_des_error,lv_indice;
        EXIT WHEN C1%NOTFOUND;


                        LT_tabla_tmp(i).COD_PROCESO:=  lv_COD_PROCESO;
                        LT_tabla_tmp(i).CAMPO_1    :=  lv_CAMPO_1    ;
                        LT_tabla_tmp(i).CAMPO_2    :=  lv_CAMPO_2    ;
                        LT_tabla_tmp(i).CAMPO_3    :=  lv_CAMPO_3    ;
                        LT_tabla_tmp(i).CAMPO_4    :=  lv_CAMPO_4    ;
                        LT_tabla_tmp(i).CAMPO_5    :=  lv_CAMPO_5    ;
                        LT_tabla_tmp(i).CAMPO_6    :=  lv_CAMPO_6    ;
                        LT_tabla_tmp(i).CAMPO_7    :=  lv_CAMPO_7    ;
                        LT_tabla_tmp(i).CAMPO_8    :=  lv_CAMPO_8    ;
                        LT_tabla_tmp(i).CAMPO_9    :=  lv_CAMPO_9    ;
                        LT_tabla_tmp(i).COD_ESTADO :=  lv_COD_ESTADO ;
                        LT_tabla_tmp(i).des_error  :=  lv_des_error  ;
                        LT_tabla_tmp(i).indice     :=  lv_indice     ;

           i:= i +1;
        END LOOP;
    CLOSE C1;


    RETURN TRUE;

    EXCEPTION
        WHEN OTHERS THEN
            SN_COD_ERROR  := 1130;
            SV_MENS_RETORNO := 'Error al recuperar series del proceso de carga para Listas Negras.';
            SV_MENS_RETORNO := 'GA_SEL_SERIES_VAL_FN' ||' : '||SQLERRM;
            RETURN FALSE;
END GA_SEL_SERIES_VAL_FN;

----------------------------------------------------------------------------------

PROCEDURE GA_VAL_DUPLIC_SERIE_LN_PR(EN_COD_PROCESO  IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                    SN_COD_RETORNO  OUT NOCOPY      ge_errores_pg.CodError,
                                    SV_MENS_RETORNO OUT NOCOPY      ge_errores_pg.MsgError,
                                    SN_NUM_EVENTO   OUT NOCOPY      ge_errores_pg.evento)
/*
Valida las series duplicadas correspondientes al EN_COD_PROCESO de la tabla "ga_series_ln_oop_to"
*/
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    LT_tabla_tmp    TIP_ga_series_ln_oop_to;
BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento   := 0;


    UPDATE GA_SERIES_LN_OOP_TO A
    SET     A.COD_ESTADO   = CN_ERROR_DUPLICADO
           ,A.DES_ERROR    = CV_ERROR_DUPLICADO
    WHERE   A.COD_PROCESO  = EN_COD_PROCESO
    AND    A.CAMPO_3 IN     (SELECT CAMPO_3 FROM GA_SERIES_LN_OOP_TO B
                         WHERE  B.COD_PROCESO = A.COD_PROCESO
                             GROUP  BY CAMPO_3 HAVING COUNT(1) > 1);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 1131;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_DUPLIC_SERIE_LN_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_DUPLIC_SERIE_LN_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_VAL_DUPLIC_SERIE_LN_PR;

------------------------------------------------------------------------------

PROCEDURE GA_VAL_EXISTS_SCL_LN_PR(EN_COD_PROCESO  IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                  sn_cod_retorno  OUT NOCOPY      ge_errores_pg.CodError,
                                  sv_mens_retorno OUT NOCOPY      ge_errores_pg.MsgError,
                                  sn_num_evento   OUT NOCOPY      ge_errores_pg.Evento)
/*
Valida existencia en "GA_LNCELU" de las series correspondientes
al EN_COD_PROCESO según el "campo7" Acción, y actualiza el "cod_estado"
en la tabla "LN_SERIESOTRASOP_TO" en caso que no sean válidas
*/
IS

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;

BEGIN
        sn_cod_retorno := 0;
        sn_num_evento  := 0;

        LV_sSql:='  UPDATE GA_SERIES_LN_OOP_TO A SET';
        LV_sSql:=LV_sSql||' A.COD_ESTADO = ' || CN_error_exscl;
        LV_sSql:=LV_sSql||' ,A.DES_ERROR = ' || CV_error_exscl;
        LV_sSql:=LV_sSql||'  WHERE  NOT EXISTS (SELECT 1 FROM GA_ABOCEL B';
        LV_sSql:=LV_sSql||'                     WHERE  B.NUM_IMEI = A.CAMPO_3';
        LV_sSql:=LV_sSql||'                     AND    B.COD_SITUACION != '|| CV_situa_baa || ')';
        LV_sSql:=LV_sSql||' AND   A.COD_PROCESO =  ' || EN_COD_PROCESO;
        LV_sSql:=LV_sSql||' AND   A.COD_ESTADO  =  ' || CN_estado_valido;


        UPDATE GA_SERIES_LN_OOP_TO A SET
               A.COD_ESTADO = CN_error_exscl
              ,A.DES_ERROR  = CV_error_exscl
        WHERE  NOT EXISTS (SELECT 1 FROM GA_ABOCEL B
                           WHERE  B.NUM_IMEI = A.CAMPO_3
                           AND    B.COD_SITUACION != CV_situa_baa)
        AND   A.COD_PROCESO = EN_COD_PROCESO
        AND   A.COD_ESTADO  = CN_estado_valido;

        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 1132;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_EXISTS_SCL_LN_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_EXISTS_SCL_LN_PR', LV_sSQL, sn_cod_retorno, LV_des_error );
END GA_VAL_EXISTS_SCL_LN_PR;
------------------------------------------------------------------------------

PROCEDURE GA_VAL_EXISTS_SERIE_LN_PR(EN_COD_PROCESO  IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                sn_cod_retorno      OUT NOCOPY      ge_errores_pg.CodError,
                                sv_mens_retorno     OUT NOCOPY      ge_errores_pg.MsgError,
                                sn_num_evento       OUT NOCOPY      ge_errores_pg.Evento)
/*
Valida existencia en "GA_LNCELU" de las series correspondientes
al EN_COD_PROCESO según el "campo7" Acción, y actualiza el "cod_estado"
en la tabla "LN_SERIESOTRASOP_TO" en caso que no sean válidas
*/
IS

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;

BEGIN
        sn_cod_retorno  := 0;
        sn_num_evento  := 0;

        LV_sSql:=' UPDATE LN_SERIESOTRASOP_TO A SET';
        LV_sSql:=LV_sSql||' A.COD_ESTADO = ' || CN_error_ingreso;
        LV_sSql:=LV_sSql||' ,A.DES_ERROR = ' ||CV_error_ingreso;
        LV_sSql:=LV_sSql||' WHERE EXISTS (SELECT 1 FROM GA_LNCELU B';
        LV_sSql:=LV_sSql||' WHERE B.NUM_SERIE = A.CAMPO_3)';
        LV_sSql:=LV_sSql||' AND A.COD_PROCESO = ' || EN_COD_PROCESO;
        LV_sSql:=LV_sSql||' AND A.CAMPO_7 = ' || CN_accion_ingreso;
        LV_sSql:=LV_sSql||' AND A.COD_ESTADO = ' || CN_estado_valido;

        UPDATE GA_SERIES_LN_OOP_TO A SET
               A.COD_ESTADO = CN_error_ingreso
              ,A.DES_ERROR  = CV_error_ingreso
        WHERE EXISTS (SELECT 1 FROM GA_LNCELU B
                      WHERE  B.NUM_SERIE =  A.CAMPO_3)
        AND   A.COD_PROCESO = EN_COD_PROCESO
        AND   A.CAMPO_7     = CN_accion_ingreso
        AND   A.COD_ESTADO  = CN_estado_valido;

        LV_sSql:=' UPDATE GA_SERIES_LN_OOP_TO A SET';
        LV_sSql:=LV_sSql||' A.COD_ESTADO = ' || CN_error_egreso;
        LV_sSql:=LV_sSql||' ,A.DES_ERROR = ' || CV_error_egreso;
        LV_sSql:=LV_sSql||' WHERE EXISTS (SELECT 1 FROM GA_LNCELU B';
        LV_sSql:=LV_sSql||' WHERE B.NUM_SERIE = A.CAMPO_3)';
        LV_sSql:=LV_sSql||' AND A.COD_PROCESO = ' || EN_COD_PROCESO;
        LV_sSql:=LV_sSql||' AND A.CAMPO_7 = ' || CN_accion_egreso;
        LV_sSql:=LV_sSql||' AND A.COD_ESTADO = ' || CN_estado_valido;

        UPDATE GA_SERIES_LN_OOP_TO A SET
               A.COD_ESTADO = CN_error_egreso
               ,A.DES_ERROR = CV_error_egreso
        WHERE NOT EXISTS (SELECT 1 FROM GA_LNCELU B
                      WHERE  B.NUM_SERIE =  A.CAMPO_3)
        AND   A.COD_PROCESO = EN_COD_PROCESO
        AND   A.CAMPO_7     = CN_accion_egreso
        AND   A.COD_ESTADO  = CN_estado_valido;

        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 1133;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_EXISTS_SERIE_LN_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_VAL_EXISTS_SERIE_LN_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_VAL_EXISTS_SERIE_LN_PR;

-------------------------------------------------------------------------------

PROCEDURE GA_INS_SERIE_LN_TEMP_PR(EN_COD_PROCESO    IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                EN_CAMPO_1          IN              ga_series_ln_oop_to.campo_1%TYPE,
                                EN_CAMPO_2          IN              ga_series_ln_oop_to.campo_2%TYPE,
                                EN_CAMPO_3          IN              ga_series_ln_oop_to.campo_3%TYPE,
                                EN_CAMPO_4          IN              ga_series_ln_oop_to.campo_4%TYPE,
                                EN_CAMPO_5          IN              ga_series_ln_oop_to.campo_5%TYPE,
                                EN_CAMPO_6          IN              ga_series_ln_oop_to.campo_6%TYPE,
                                EN_CAMPO_7          IN              ga_series_ln_oop_to.campo_7%TYPE,
                                EN_CAMPO_8          IN              ga_series_ln_oop_to.campo_8%TYPE,
                                EN_CAMPO_9          IN              ga_series_ln_oop_to.campo_9%TYPE,
                                EN_COD_ESTADO       IN              ga_series_ln_oop_to.cod_estado%TYPE,
                                EN_DES_ERROR        IN              ga_series_ln_oop_to.des_error%TYPE,
                                EN_INDICE           IN              ga_series_ln_oop_to.indice%TYPE,
                                SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento )
/*
Realiza INSERT de un nuevo registro en la tabla "ga_series_ln_oop_to" con los datos sacados de la matriz
*/

IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento  := 0;

    LV_sSql := 'INSERT INTO ga_series_ln_oop_to (cod_proceso, campo_1, ';
    LV_sSql := LV_sSql || ' campo_2, campo_3, campo_4, campo_5, campo_6, ';
    LV_sSql := LV_sSql || ' campo_7, campo_8, campo_9, cod_estado, des_error, ';
    LV_sSql := LV_sSql || ' indice) VALUES (SN_COD_PROCESO, EN_CAMPO_1, ';
    LV_sSql := LV_sSql || ' EN_CAMPO_2, EN_CAMPO_3, EN_CAMPO_4, EN_CAMPO_5, ';
    LV_sSql := LV_sSql || ' EN_CAMPO_6, EN_CAMPO_7, EN_CAMPO_8, EN_CAMPO_9, ';
    LV_sSql := LV_sSql || ' EN_COD_ESTADO, EN_DES_ERROR, EN_INDICE)';

    INSERT INTO ga_series_ln_oop_to (cod_proceso, campo_1, campo_2,
                campo_3, campo_4, campo_5, campo_6, campo_7, campo_8,
                campo_9, cod_estado, des_error, indice)
    VALUES (EN_COD_PROCESO, EN_CAMPO_1, EN_CAMPO_2, EN_CAMPO_3, EN_CAMPO_4 ,
                EN_CAMPO_5, EN_CAMPO_6, EN_CAMPO_7, EN_CAMPO_8, EN_CAMPO_9,
                EN_COD_ESTADO, EN_DES_ERROR, EN_INDICE);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 1135;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_INS_SERIE_LN_TEMP_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INS_SERIE_LN_TEMP_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_INS_SERIE_LN_TEMP_PR;

----------------------------------------------------------------------------------

PROCEDURE GA_BUSCAR_LN_VALIDAS_PR(EN_COD_PROCESO       IN ga_series_ln_oop_to.cod_proceso%TYPE,
                                  SC_DATOS_SERIES_LN  OUT NOCOPY      refCursor)
/*
Retorna un cursor con las series VALIDAS correspondientes al EN_COD_PROCESO
*/
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
    error_exception     EXCEPTION;
    LN_cantidad         NUMBER;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;

    LV_sSql := 'SELECT count(1) ';
    LV_sSql := LV_sSql || ' FROM ga_series_ln_oop_to a ';
    LV_sSql := LV_sSql || ' WHERE a.cod_proceso = ' || EN_COD_PROCESO;
    LV_sSql := LV_sSql || ' AND a.cod_estado = ' || CN_estado_valido;

    SELECT count(1) INTO LN_cantidad
    FROM ga_series_ln_oop_to a
    WHERE a.cod_proceso = EN_COD_PROCESO
    AND a.cod_estado = CN_estado_valido;

    IF LN_cantidad = 0 THEN
         RAISE error_exception;
    END IF;

    LV_sSql := 'SELECT a.campo_1, a.campo_2, b.des_operador, a.campo_3, a.campo_4, ';
    LV_sSql := LV_sSql || ' a.campo_5, a.campo_6, a.campo_7, a.campo_8, a.campo_9 ';
    LV_sSql := LV_sSql || ' FROM ga_series_ln_oop_to a, ta_operadores b ';
    LV_sSql := LV_sSql || ' WHERE a.cod_proceso = ' || EN_COD_PROCESO;
    LV_sSql := LV_sSql || ' AND a.cod_proceso = ' || CN_estado_valido;
    LV_sSql := LV_sSql || ' a.campo_2 = b.cod_operador';

    OPEN SC_DATOS_SERIES_LN FOR
    SELECT a.campo_1, a.campo_2, b.des_operador, a.campo_3, a.campo_4,
            a.campo_5, a.campo_6, a.campo_7, a.campo_8, a.campo_9
    FROM ga_series_ln_oop_to a, ta_operadores b
    WHERE a.cod_proceso = EN_COD_PROCESO
    AND a.cod_estado = CN_estado_valido
    AND a.campo_2 = b.cod_operador;

    EXCEPTION
        WHEN error_exception THEN
             SN_cod_retorno := 1135;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VALIDAS_PR ';
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VALIDAS_PR', LV_sSQL, sn_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := 1136;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VALIDAS_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VALIDAS_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_BUSCAR_LN_VALIDAS_PR;

----------------------------------------------------------------------------------

PROCEDURE GA_BUSCAR_LN_NOVALIDAS_PR(EN_COD_PROCESO  IN  ga_series_ln_oop_to.cod_proceso%TYPE,
                                    SC_DATOS_SERIES_LN  OUT NOCOPY      refCursor)
/*
Retorna un cursor con las series NO-VALIDAS correspondientes al EN_COD_PROCESO
*/
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    error_exception EXCEPTION;
    LN_cantidad     NUMBER;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;

    LV_sSql := 'SELECT count(1) ';
    LV_sSql := LV_sSql || ' FROM ga_series_ln_oop_to a ';
    LV_sSql := LV_sSql || ' WHERE a.cod_proceso = ' || EN_COD_PROCESO;
    LV_sSql := LV_sSql || ' AND a.cod_estado != ' || CN_estado_valido;

    SELECT count(1) INTO LN_cantidad
    FROM ga_series_ln_oop_to a
    WHERE a.cod_proceso  = EN_COD_PROCESO
    AND a.cod_estado    != CN_estado_valido;

    IF LN_cantidad = 0 THEN
         RAISE error_exception;
    END IF;

    LV_sSql := 'SELECT a.cod_proceso, a.indice, a.campo_3, a.des_error ';
    LV_sSql := LV_sSql || ' FROM ga_series_ln_oop_to a ';
    LV_sSql := LV_sSql || ' WHERE a.cod_proceso = ' || EN_COD_PROCESO;
    LV_sSql := LV_sSql || ' WHERE a.cod_proceso != ' || CN_estado_valido;

    OPEN SC_DATOS_SERIES_LN FOR
    SELECT a.cod_proceso, a.indice, a.campo_3, a.des_error
    FROM ga_series_ln_oop_to a
    WHERE a.cod_proceso = EN_COD_PROCESO
    AND a.cod_estado != CN_estado_valido
    ORDER BY a.indice;

    EXCEPTION
        WHEN error_exception THEN
             SN_cod_retorno := 1137;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_NOVALIDA_PR ';
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_NOVALIDA_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

        WHEN OTHERS THEN
             SN_cod_retorno := 1138;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_NOVALIDAS_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_NOVALIDAS_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_BUSCAR_LN_NOVALIDAS_PR;

----------------------------------------------------------------------------------

PROCEDURE GA_DEL_SERIES_LN_TMP_PR(EN_COD_PROCESO    IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento )
/*
Elimina de la tabla "ga_series_ln_oop_to" las series correspondientes al EN_COD_PROCESO
*/
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;

BEGIN
    sn_cod_retorno := 0;
    sn_num_evento  := 0;

    LV_sSql := 'DELETE FROM ga_series_ln_oop_to a ';
    LV_sSql := LV_sSql || ' WHERE a.cod_proceso = ' || EN_COD_PROCESO ;

    DELETE FROM ga_series_ln_oop_to a
    WHERE a.cod_proceso = EN_COD_PROCESO;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 1139;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_DEL_SERIES_LN_TMP_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_DEL_SERIES_LN_TMP_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_DEL_SERIES_LN_TMP_PR;

----------------------------------------------------------------------------------

PROCEDURE GA_EJECUTA_SERIES_LN_PR(EN_COD_PROCESO    IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                EV_COD_CAUSA        IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                EV_COD_TIPOLISTA    IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                EV_COD_OS           IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                EV_COD_ORIGEN       IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento )
/*
Ingreso de Listas Negras: Inserta en la tabla GA_LNCELU todas las series válidas
de la tabla "ga_series_ln_oop_to" correspondientes al EN_COD_PROCESO
*/
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    LT_tabla_tmp    TIP_GA_LNCELU;
    LT_tabla_tmp1   TIP_ga_series_ln_oop_to;
    ERROR_FUNCION   EXCEPTION;

BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento   := 0;

    IF NOT GA_SEL_SERIES_LN_FN(EN_COD_PROCESO, LT_tabla_tmp,sn_cod_retorno,sv_mens_retorno,LV_sSql) THEN
        RAISE ERROR_FUNCION;
    END IF;


    IF NOT GA_REG_SERIES_LN_FN(LT_tabla_tmp,sn_cod_retorno,sv_mens_retorno,LV_sSql) THEN
        RAISE ERROR_FUNCION;
    END IF;


    GA_INT_LISTAS_NEGRAS_PG.GA_INSCRIBE_CAUSALISTA_PR(EN_COD_PROCESO,EV_COD_CAUSA,EV_COD_TIPOLISTA,EV_COD_OS,EV_COD_ORIGEN,0,sn_cod_retorno,sv_mens_retorno,SN_NUM_EVENTO ) ;

    IF sn_cod_retorno <>'0' THEN
       RAISE ERROR_FUNCION;
    END IF;


    IF NOT GA_DEL_SERIES_EG_FN(EN_COD_PROCESO, sn_cod_retorno,sv_mens_retorno,LV_sSql) THEN
        RAISE ERROR_FUNCION;
    END IF;


    GA_INT_LISTAS_NEGRAS_PG.GA_HISTORICO_CAUSALISTA_PR(EN_COD_PROCESO,EV_COD_CAUSA,EV_COD_TIPOLISTA,EV_COD_OS,EV_COD_ORIGEN,1,sn_cod_retorno,sv_mens_retorno,SN_NUM_EVENTO ) ;

    IF sn_cod_retorno <>'0' THEN
       RAISE ERROR_FUNCION;
    END IF;




    EXCEPTION
        WHEN ERROR_FUNCION THEN
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INGRESO_SERIES_LN_PR', LV_sSQL, sn_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := 1140;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_INGRESO_SERIES_LN_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INGRESO_SERIES_LN_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_EJECUTA_SERIES_LN_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE GA_BUSCAR_LN_VAL_MISMA_PR(EN_COD_PROCESO           IN  ga_series_ln_oop_to.cod_proceso%TYPE,
                                    SC_DATOS_MISMASERIES_LN  OUT NOCOPY      refCursor)
/*
Retorna un cursor con las series VALIDAS correspondientes al EN_COD_PROCESO
*/
IS
    SN_COD_RETORNO      ge_errores_pg.CodError;
    SV_MENS_RETORNO     ge_errores_pg.MsgError;
    SN_NUM_EVENTO       ge_errores_pg.evento;

    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    error_exception EXCEPTION;
    LN_cantidad     NUMBER;

BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento  := 0;

    LV_sSql := 'SELECT count(1) ';
    LV_sSql := LV_sSql || ' from ga_equipaboser a , ga_abocel b ,  al_articulos c , ga_series_ln_oop_to d ';
    LV_sSql := LV_sSql || ' where b.num_imei     = d.campo_3 ';
    LV_sSql := LV_sSql || '  and  b.num_abonado  = a.num_abonado';
    LV_sSql := LV_sSql || '  and  b.num_imei     = a.num_serie ';
    LV_sSql := LV_sSql || '  and  c.cod_articulo = a.cod_articulo';
    LV_sSql := LV_sSql || '  and  d.cod_proceso  = ' || EN_COD_PROCESO;
    LV_sSql := LV_sSql || '  and  d.cod_estado   = ' || CN_estado_valido;
    LV_sSql := LV_sSql || '  and  a.fec_alta     = (select max(e.fec_alta) from ga_equipaboser e';
    LV_sSql := LV_sSql || '                         where  e.num_abonado =  a.num_abonado';
    LV_sSql := LV_sSql || '                         and    e.num_serie   =  a.num_serie)';


    SELECT count(1) INTO LN_cantidad
    FROM ga_equipaboser a , ga_abocel b ,  al_articulos c , ga_series_ln_oop_to d
    WHERE b.num_imei     = d.campo_3
    AND   b.num_abonado  = a.num_abonado
    AND   b.num_imei     = a.num_serie
    AND   c.cod_articulo = a.cod_articulo
    AND   d.cod_proceso  = EN_COD_PROCESO
    AND   d.cod_estado   = CN_estado_valido
    AND   a.fec_alta = (SELECT max(e.fec_alta) from ga_equipaboser e
                        WHERE  e.num_abonado =  a.num_abonado
                        AND    e.num_serie   =  a.num_serie);

    IF LN_cantidad = 0 THEN
         RAISE error_exception;
    END IF;

    LV_sSql := 'SELECT campo_1, campo_3, campo_8, campo_5 ,des_articulo,1,null,null ';
    LV_sSql := LV_sSql || ' from ga_equipaboser a , ga_abocel b ,  al_articulos c , ga_series_ln_oop_to d ';
    LV_sSql := LV_sSql || ' where b.num_imei     = d.campo_3 ';
    LV_sSql := LV_sSql || '  and  b.num_abonado  = a.num_abonado';
    LV_sSql := LV_sSql || '  and  b.num_imei     = a.num_serie ';
    LV_sSql := LV_sSql || '  and  c.cod_articulo = a.cod_articulo';
    LV_sSql := LV_sSql || '  and  d.cod_proceso  = ' || EN_COD_PROCESO;
    LV_sSql := LV_sSql || '  and  d.cod_estado  = ' || CN_estado_valido;

     OPEN SC_DATOS_MISMASERIES_LN FOR
     SELECT campo_1, campo_3, campo_8, 'LISTAS SCL',des_articulo,1,null,null
     FROM ga_equipaboser a , ga_abocel b ,  al_articulos c , ga_series_ln_oop_to d
     WHERE b.num_imei     = d.campo_3
     AND   b.num_abonado  = a.num_abonado
     AND   b.num_imei     = a.num_serie
     AND   c.cod_articulo = a.cod_articulo
     AND   d.cod_proceso  = EN_COD_PROCESO
     AND   d.cod_estado   = CN_estado_valido
     AND   a.fec_alta     = (SELECT max(e.fec_alta) from ga_equipaboser e
                             WHERE  e.num_abonado =  a.num_abonado
                             AND    e.num_serie   =  a.num_serie);

    EXCEPTION
        WHEN error_exception THEN
             SN_cod_retorno := 1141;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             sv_mens_retorno:= 'No hay registros de Series válidas para la secuencia ingresada';
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VAL_MISMA_PR ';
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VALIDAS_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

        WHEN OTHERS THEN
             SN_cod_retorno := 1142;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VAL_MISMA_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_BUSCAR_LN_VALIDAS_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_BUSCAR_LN_VAL_MISMA_PR;


---------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION GA_SEL_SERIES_LN_SCL_FN(EN_COD_PROCESO      IN   ga_series_ln_oop_to.cod_proceso%TYPE,
                                 LT_tabla_tmp        IN OUT  TIP_GA_LNCELU,
                                 SN_COD_ERROR         OUT ge_errores_pg.CodError,
                                 SV_MENS_RETORNO      OUT ge_errores_pg.MsgError,
                                 SV_SQL               OUT ge_errores_pg.vQuery
) RETURN BOOLEAN
/*
Devuelve el objeto "LT_tabla_tmp" con los registros válidos
correspondientes al EN_COD_PROCESO y con el tipo de acción INGRESO
para insertarlos en la tabla "GA_LNCELU"
*/
IS
    LV_TIP_LISTA        GA_LNCELU.tip_lista%TYPE;
    LV_COD_OPERADOR     GA_LNCELU.cod_operador%TYPE;
    lv_ind_procequi     ga_Abocel.IND_PROCEQUI%type;
    lv_cod_fabricante   al_articulos.COD_FABRICANTE%type;
    lv_cod_articulo     ga_equipaboser.cod_articulo%type;
    lv_num_celular     ga_abocel.num_celular%type;
    lv_num_abonado     ga_abocel.num_abonado%type;
    lv_cod_cliente     ga_abocel.cod_cliente%type;
    LD_FEC_ALTA         ga_series_ln_oop_to.CAMPO_4%TYPE;
    LV_NUM_SERIE        ga_series_ln_oop_to.CAMPO_3%TYPE;
    i NUMBER;


CURSOR C1 IS
  SELECT  d.campo_3
             ,b.ind_procequi
             ,c.cod_fabricante
             ,a.cod_articulo
             ,b.num_celular
             ,b.num_abonado
        ,b.cod_cliente
        ,TO_CHAR(sysdate,'ddmmyy hh24mi')
      FROM  ga_equipaboser a , ga_abocel b , al_articulos c, ga_series_ln_oop_to d
      WHERE b.num_imei     = d.campo_3
    AND   b.num_abonado  = a.num_abonado
    AND   b.num_imei     = a.num_serie
    AND   c.cod_articulo = a.cod_articulo
    AND   d.cod_proceso  = EN_COD_PROCESO
    AND   d.cod_estado   = CN_estado_valido
    AND   a.fec_alta = (SELECT max(e.fec_alta) FROM ga_equipaboser e
                        WHERE  e.num_abonado =  a.num_abonado
                        AND    e.num_serie   =  a.num_serie);



BEGIN
    SN_COD_ERROR:=0;

    LV_TIP_LISTA        := LT_tabla_tmp(1).tip_lista;
    LV_COD_OPERADOR     := LT_tabla_tmp(1).cod_operador;

    i:=1;

    OPEN C1;
        LOOP
        FETCH C1 INTO LV_NUM_SERIE,lv_ind_procequi,lv_cod_fabricante,lv_cod_articulo,lv_num_celular,lv_num_abonado,lv_cod_cliente,LD_FEC_ALTA;
        EXIT WHEN C1%NOTFOUND;


                        LT_tabla_tmp(i).NUM_SERIE        :=LV_NUM_SERIE      ;
                        LT_tabla_tmp(i).IND_PROCEQUI     :=LV_IND_PROCEQUI   ;
                        LT_tabla_tmp(i).COD_OPERADOR     :=TO_NUMBER(LV_COD_OPERADOR) ;
                        LT_tabla_tmp(i).COD_FABRICANTE   :=Lv_COD_FABRICANTE ;
                        LT_tabla_tmp(i).COD_ARTICULO     :=Lv_COD_ARTICULO   ;
                        LT_tabla_tmp(i).NUM_SERIEMEC     :=NULL              ;
                        LT_tabla_tmp(i).NUM_CELULAR      :=Lv_NUM_CELULAR    ;
                        LT_tabla_tmp(i).NUM_ABONADO      :=Lv_NUM_ABONADO    ;
                        LT_tabla_tmp(i).COD_CLIENTE      :=Lv_COD_CLIENTE    ;
                        LT_tabla_tmp(i).FEC_ALTA         :=to_DATE(LD_FEC_ALTA,'ddmmyy hh24mi');
                        LT_tabla_tmp(i).IND_RESTRICCION  :=CN_CERO           ;
                        LT_tabla_tmp(i).COD_ASEG         :=NULL              ;
                        LT_tabla_tmp(i).FEC_CONSTPOL     :=NULL              ;
                        LT_tabla_tmp(i).NUM_CONSTPOL     :=NULL              ;
                        LT_tabla_tmp(i).TIP_ABONADO      :=CV_tip_abocont    ;
                        LT_tabla_tmp(i).COD_CAUSA        :=NULL              ;
                        LT_tabla_tmp(i).IND_INFORMADO    := 0                ;
                        LT_tabla_tmp(i).TIP_LISTA        :=LV_TIP_LISTA      ;
                        LT_tabla_tmp(i).DES_CAUSA        :=NULL              ;
                        LT_tabla_tmp(i).DES_MARCA_EQUIPO :=NULL              ;

           i:= i +1;
        END LOOP;
    CLOSE C1;


    RETURN TRUE;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            SN_COD_ERROR  := 1135;
            SV_MENS_RETORNO := 'GA_SEL_SERIES_SCL_FN' ||' : '||SQLERRM;
            RETURN FALSE;
        WHEN OTHERS THEN
            SN_COD_ERROR  := 1136;
            SV_MENS_RETORNO := 'GA_SEL_SERIES_SCL_FN' ||' : '||SQLERRM;
            RETURN FALSE;
END GA_SEL_SERIES_LN_SCL_FN;



----------------------------------------------------------------------------------

PROCEDURE GA_EJECUTA_SERIES_LN_SCL_PR(EN_COD_PROCESO      IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                      EV_TIPO             IN              ga_lncelu.tip_lista%TYPE,
                                      EV_COD_OPERADORA    IN              ga_lncelu.cod_operador%TYPE,
                                      EV_COD_CAUSA        IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                                      EV_COD_TIPOLISTA    IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                      EV_COD_OS           IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                      EV_COD_ORIGEN       IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                      SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                      SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                      SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento )
/*
Ingreso de Listas Negras: Inserta en la tabla ga_lncelu todas las series válidas
de la tabla "ga_series_ln_oop_to" correspondientes al EN_COD_PROCESO
*/
IS
    LV_des_error    ge_errores_pg.DesEvent;
    LV_sSql         ge_errores_pg.vQuery;
    LT_tabla_tmp    TIP_GA_LNCELU;
    ERROR_FUNCION   EXCEPTION;

BEGIN
    sn_cod_retorno  := 0;
    sn_num_evento   := 0;

    LT_tabla_tmp(1).cod_operador :=ev_cod_operadora;
    LT_tabla_tmp(1).tip_lista    :=ev_tipo;

    IF NOT GA_SEL_SERIES_LN_SCL_FN(EN_COD_PROCESO,LT_tabla_tmp,sn_cod_retorno,sv_mens_retorno,LV_sSql) THEN
        RAISE ERROR_FUNCION;
    END IF;



   IF NOT GA_REG_SERIES_LN_FN(LT_tabla_tmp,sn_cod_retorno,sv_mens_retorno,LV_sSql) THEN
        RAISE ERROR_FUNCION;
   END IF;

   GA_INT_LISTAS_NEGRAS_PG.GA_INSCRIBE_CAUSALISTA_PR(EN_COD_PROCESO,EV_COD_CAUSA,EV_COD_TIPOLISTA,EV_COD_OS,EV_COD_ORIGEN,0,sn_cod_retorno,sv_mens_retorno,SN_NUM_EVENTO ) ;



    EXCEPTION
        WHEN ERROR_FUNCION THEN
            sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INGRESO_SERIES_LN_PR', LV_sSQL, sn_cod_retorno, LV_des_error );
        WHEN OTHERS THEN
             SN_cod_retorno := 1140;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
                    sv_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'GA_INT_LISTAS_NEGRAS_PG.GA_EJECUTA_SERIES_LN_SCL_PR ' || SQLERRM;
             sn_num_evento  := Ge_Errores_Pg.Grabarpl( sn_num_evento, CV_cod_modulo, sv_mens_retorno, CV_version, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INGRESO_SERIES_LN_PR', LV_sSQL, sn_cod_retorno, LV_des_error );

END GA_EJECUTA_SERIES_LN_SCL_PR;


----------------------------------------------------------------------------------
FUNCTION GA_REC_SERIE_ING_FN   (EM_TABLA              OUT NOCOPY TIP_ICC_MOVIMIENTO,
                                EN_NUM_SERIE          IN  ga_lncelu.num_serie%TYPE,
                                ED_FEC_ALTA           IN  DATE,
                                SN_COD_ERROR          OUT NOCOPY NUMBER,
                                SV_MENS_RETORNO       OUT NOCOPY VARCHAR2,
                                SV_SQL                OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;
  LV_num_imei   icc_movimiento.imei%TYPE;
  i number(3);


    lv_NUM_MOVIMIENTO     icc_movimiento.NUM_MOVIMIENTO%type;
    lv_NUM_ABONADO       icc_movimiento.NUM_ABONADO%type;
    lv_COD_ESTADO        icc_movimiento.COD_ESTADO%type;
    lv_COD_ACTABO        icc_movimiento.COD_ACTABO%type;
    lv_COD_MODULO        icc_movimiento.COD_MODULO%type;
    lv_NUM_INTENTOS      icc_movimiento.NUM_INTENTOS%type;
    lv_COD_CENTRAL_NUE  icc_movimiento.COD_CENTRAL_NUE%type;
    lv_DES_RESPUESTA    icc_movimiento.DES_RESPUESTA%type;
    lv_COD_ACTUACION    icc_movimiento.COD_ACTUACION%type;
    lv_NOM_USUARORA     icc_movimiento.NOM_USUARORA%type;
    lv_FEC_INGRESO      icc_movimiento.FEC_INGRESO%type;
    lv_TIP_TERMINAL     icc_movimiento.TIP_TERMINAL%type;
    lv_COD_CENTRAL      icc_movimiento.COD_CENTRAL%type;
    lv_FEC_LECTURA      icc_movimiento.FEC_LECTURA%type;
    lv_IND_BLOQUEO      icc_movimiento.IND_BLOQUEO%type;
    lv_FEC_EJECUCION      icc_movimiento.FEC_EJECUCION%type;
    lv_TIP_TERMINAL_NUE icc_movimiento.TIP_TERMINAL_NUE%type;
    lv_NUM_MOVANT          icc_movimiento.NUM_MOVANT%type;
    lv_NUM_CELULAR      icc_movimiento.NUM_CELULAR%type;
    lv_NUM_MOVPOS          icc_movimiento.NUM_MOVPOS%type;
    lv_NUM_SERIE          icc_movimiento.NUM_SERIE%type;
    lv_NUM_PERSONAL      icc_movimiento.NUM_PERSONAL%type;
    lv_NUM_CELULAR_NUE  icc_movimiento.NUM_CELULAR_NUE%type;
    lv_NUM_SERIE_NUE      icc_movimiento.NUM_SERIE_NUE%type;
    lv_NUM_PERSONAL_NUE icc_movimiento.NUM_PERSONAL_NUE%type;
    lv_NUM_MSNB          icc_movimiento.NUM_MSNB%type;
    lv_NUM_MSNB_NUE      icc_movimiento.NUM_MSNB_NUE%type;
    lv_COD_SUSPREHA      icc_movimiento.COD_SUSPREHA%type;
    lv_COD_SERVICIOS     icc_movimiento.COD_SERVICIOS%type;
    lv_NUM_MIN          icc_movimiento.NUM_MIN%type;
    lv_NUM_MIN_NUE      icc_movimiento.NUM_MIN_NUE%type;
    lv_STA              icc_movimiento.STA%type;
    lv_COD_MENSAJE      icc_movimiento.COD_MENSAJE%type;
    lv_PARAM1_MENS      icc_movimiento.PARAM1_MENS%type;
    lv_PARAM2_MENS      icc_movimiento.PARAM2_MENS%type;
    lv_PARAM3_MENS      icc_movimiento.PARAM3_MENS%type;
    lv_PLAN              icc_movimiento.PLAN%type;
    lv_CARGA             icc_movimiento.CARGA%type;
    lv_VALOR_PLAN          icc_movimiento.VALOR_PLAN%type;
    lv_PIN              icc_movimiento.PIN%type;
    lv_FEC_EXPIRA          icc_movimiento.FEC_EXPIRA%type;
    lv_DES_MENSAJE      icc_movimiento.DES_MENSAJE%type;
    lv_COD_PIN          icc_movimiento.COD_PIN%type;
    lv_COD_IDIOMA          icc_movimiento.COD_IDIOMA%type;
    lv_COD_ENRUTAMIENTO    icc_movimiento.COD_ENRUTAMIENTO%type;
    lv_TIP_ENRUTAMIENTO icc_movimiento.TIP_ENRUTAMIENTO%type;
    lv_DES_ORIGEN_PIN      icc_movimiento.DES_ORIGEN_PIN%type;
    lv_NUM_LOTE_PIN      icc_movimiento.NUM_LOTE_PIN%type;
    lv_NUM_SERIE_PIN      icc_movimiento.NUM_SERIE_PIN%type;
    lv_TIP_TECNOLOGIA      icc_movimiento.TIP_TECNOLOGIA%type;
    lv_IMSI              icc_movimiento.IMSI%type;
    lv_IMSI_NUE          icc_movimiento.IMSI_NUE%type;
    lv_IMEI              icc_movimiento.IMEI%type;
    lv_IMEI_NUE          icc_movimiento.IMEI_NUE%type;
    lv_ICC              icc_movimiento.ICC%type;
    lv_ICC_NUE          icc_movimiento.ICC_NUE%type;
    lv_FEC_ACTIVACION      icc_movimiento.FEC_ACTIVACION%type;
    lv_COD_ESPEC_PROV      icc_movimiento.COD_ESPEC_PROV%type;
    lv_COD_PROD_CONTRATADO  icc_movimiento.COD_PROD_CONTRATADO%type;
    lv_IND_BAJATRANS      icc_movimiento.IND_BAJATRANS%type;
    lv_cod_causa_os     ga_causaeir_to.COD_CAUSA_OS%type;
    lv_cod_os           ga_causaeir_to.COD_OS%type;
    LN_IND_EIR          ga_causabaja.IND_EIR%TYPE;
    LN_num_secuencia    ga_transacabo.NUM_TRANSACCION%TYPE;
    LB_flg_eir          BOOLEAN;
    lv_valor_texto      ge_parametros_sistema_vw.VALOR_TEXTO%type;
    ln_cod_retorno      ge_errores_pg.CodError;
    lv_mens_retorno     ge_errores_pg.MsgError;
    ln_num_evento       ge_errores_pg.evento;
    lv_aplica_luhn      ged_parametros.val_parametro%type;
    LN_CANT_FORMALIZA   number(3);


  CURSOR C1 IS
   select   a.num_abonado
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,a.tip_terminal
            ,a.cod_central
            ,a.num_celular
            ,a.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,a.cod_tecnologia
            ,a.num_imei
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_abocel a, ga_lncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    ,ga_siniestros f --INC 1-1 158942 JRCH
    where  a.num_abonado     =   b.num_abonado
    and    (a.num_imei       =   b.num_serie or     a.num_serie       =   b.num_serie)
    and    b.num_serie       =   nvl(lv_num_imei,b.num_serie)
    and    b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   0
    --and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate)) --INC 1-1 158942 JRCH
    and    trunc(f.fec_formaliza) = nvl(ed_fec_alta,trunc(sysdate)) --INC 1-1 158942 JRCH
    and    a.num_abonado    = f.num_abonado   --INC 1-1 158942 JRCH
    and    f.cod_estado = 'FO'  --INC 1-1 158942 JRCH
    and    f.num_serie = nvl(lv_num_imei,b.num_serie) --INC 1-1 158942 JRCH
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR  e.cod_tipolista   =   CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    c.cod_tecnologia  =   a.cod_tecnologia
    and    c.cod_modulo      =   CV_modulo_li
    and    e.cod_causa      !=   CN_cero
    union
    select  a.num_abonado
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,a.tip_terminal
            ,a.cod_central
            ,a.num_celular
            ,a.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,a.cod_tecnologia
            ,a.num_imei
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_aboamist a, ga_lncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    ,ga_siniestros f --INC 1-1 158942 JRCH
    where  a.num_abonado     =   b.num_abonado
    and    (a.num_imei       =   b.num_serie or     a.num_serie       =   b.num_serie)
    and    b.num_serie       =   nvl(lv_num_imei,b.num_serie)
    and    b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   0
    --and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate)) --INC 1-1 158942 JRCH
    and    trunc(f.fec_formaliza) = nvl(ed_fec_alta,trunc(sysdate)) --INC 1-1 158942 JRCH
    and    a.num_abonado    = f.num_abonado   --INC 1-1 158942 JRCH
    and    f.cod_estado = 'FO'  --INC 1-1 158942 JRCH
    and    f.num_serie = nvl(lv_num_imei,b.num_serie) --INC 1-1 158942 JRCH
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =   CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    c.cod_tecnologia  =   a.cod_tecnologia
    and    c.cod_modulo      =   CV_modulo_li
    and    e.cod_causa      !=   CN_cero
    union
    --INI-OCB 31.01.2011 
    --se agregan estas nuevas querys oara que cubra el requerimiento de las Otras 
    --OOSS que generan listas negras y que no forman parte de la GA_SINIESTROS
    
      select   a.num_abonado
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,a.tip_terminal
            ,a.cod_central
            ,a.num_celular
            ,a.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,a.cod_tecnologia
            ,a.num_imei
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_abocel a, ga_lncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where  a.num_abonado     =   b.num_abonado
    and    (a.num_imei       =   b.num_serie or     a.num_serie       =   b.num_serie)
    and    b.num_serie       =   nvl(lv_num_imei,b.num_serie)
    and    b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   0
    and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate)) 
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR  e.cod_tipolista   =   CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    c.cod_tecnologia  =   a.cod_tecnologia
    and    c.cod_modulo      =   CV_modulo_li
    and    e.cod_causa      !=   CN_cero
    AND    e.cod_os         !=   '10060'
    union
    select  a.num_abonado
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,a.tip_terminal
            ,a.cod_central
            ,a.num_celular
            ,a.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,a.cod_tecnologia
            ,a.num_imei
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_aboamist a, ga_lncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where  a.num_abonado     =   b.num_abonado
    and    (a.num_imei       =   b.num_serie or     a.num_serie       =   b.num_serie)
    and    b.num_serie       =   nvl(lv_num_imei,b.num_serie)
    and    b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   0
    and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate)) 
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =   CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    c.cod_tecnologia  =   a.cod_tecnologia
    and    c.cod_modulo      =   CV_modulo_li
    and    e.cod_causa      !=   CN_cero
    AND    e.cod_os         !=   '10060'
    --FIN -OCB 31.01.2011 
    union
    select   0
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,'T'
            ,0
            ,0
            ,e.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,null
            ,e.num_serie
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_lncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where
           b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   0
    and    (b.num_abonado     = 0 or b.num_abonado is null)
     and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate))
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =    CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    length(trim(e.num_serie))  = 15
    and    c.cod_tecnologia  =   'GSM'
    and    c.cod_modulo      =   CV_modulo_li
    and    e.cod_causa      !=   0
    AND   (E.COD_OS = 0 OR E.COD_OS IS NULL)
    union
    select  0
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,'A'
            ,0
            ,0
            ,e.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,null
            ,e.num_serie
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_lncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where
           b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   0
    and    (b.num_abonado     = 0 or b.num_abonado is null)
     and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate))
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =    CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    (length(trim(e.num_serie))  < 15 or  length(trim(e.num_serie)) > 15)
    and    c.cod_tecnologia  =   'CDMA'
    and    c.cod_modulo      =   CV_modulo_li
    and    e.cod_causa      !=   0
    AND   (E.COD_OS = 0 OR E.COD_OS IS NULL);


BEGIN

    SV_SQL:='';
    lv_num_imei:=  EN_NUM_SERIE;

    i:=1;

    lv_aplica_luhn:=ge_fn_devvalparam('GE',1,'APLICA_LUHN');


    OPEN C1;
        LOOP

        FETCH C1 INTO lv_NUM_ABONADO,lv_COD_ACTABO,lv_COD_MODULO,lv_COD_ACTUACION,lv_TIP_TERMINAL,lv_COD_CENTRAL,
                      lv_NUM_CELULAR,lv_NUM_SERIE,lv_PARAM1_MENS,lv_DES_ORIGEN_PIN,lv_TIP_TECNOLOGIA,lv_IMEI,lv_cod_causa_os,lv_cod_os;
        EXIT WHEN C1%NOTFOUND;

            select   icc_seq_nummov.nextval
            into lv_NUM_MOVIMIENTO from dual;

            LB_flg_eir  := false;
            LN_IND_EIR  :=0;

            ln_cod_retorno :=0;
            if lv_aplica_luhn = 'TRUE' then

                LN_num_secuencia:= GA_REC_SECUENCIA_FN('GA_SEQ_TRANSACABO');
                ga_valida_luhn_pr(LN_num_secuencia,lv_imei,ln_cod_retorno,lv_mens_retorno,ln_num_evento);
            end if;

            DBMS_OUTPUT.PUT_LINE('Se evalua algotitmo de luhn :'||ln_cod_retorno);
            IF ln_cod_retorno = 0 THEN

                 DBMS_OUTPUT.PUT_LINE('Se evalua generacion del movimiento');

                if (trim(lv_cod_os)= '' OR  trim(lv_cod_os)= '0' OR lv_cod_os IS NULL) then
                    LB_flg_eir  := true;
                ELSE

                    IF (trim(lv_cod_os)='50013' OR TRIM(lv_cod_os)='50002') THEN -- bajas por fraude


                            BEGIN

                              SELECT  IND_EIR INTO LN_IND_EIR
                              FROM GA_CAUSABAJA
                              WHERE  COD_PRODUCTO =1
                              AND COD_CAUSABAJA =lv_cod_causa_os;

                            EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    LN_IND_EIR:=0;
                            END;

                    END IF;

                    IF (TRIM(lv_cod_os)='10094' OR TRIM(lv_cod_os)='10090' OR TRIM(lv_cod_os)='50016') THEN -- suspension voluntaria

                            BEGIN

                              SELECT  IND_EIR INTO LN_IND_EIR
                              FROM GA_CAUSUSP
                              WHERE  COD_PRODUCTO =1
                              AND COD_CAUSUSP =lv_cod_causa_os;

                            EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    LN_IND_EIR:=0;
                            END;

                    END IF;

                    IF (TRIM(lv_cod_os)= '50007' OR TRIM(lv_cod_os)= '50008')  THEN --bloqueo por fraude

                           BEGIN

                                            SELECT  IND_EIR INTO LN_IND_EIR
                                            FROM PV_CAUSABLODESQ
                                            WHERE  COD_PRODUCTO =1
                                            AND COD_CAUSABLODES =lv_cod_causa_os;

                           EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                            LN_IND_EIR:=0;
                           END;

                    END IF;

                    IF TRIM(lv_cod_os)= '10060' THEN       --aviso siniestro

                           BEGIN
                             SELECT  IND_EIR INTO LN_IND_EIR
                             FROM   GA_CAUSINIE
                             WHERE  COD_PRODUCTO =1
                             AND COD_CAUSA =lv_cod_causa_os;

                           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    LN_IND_EIR:=0;
                           END;


                           LN_CANT_FORMALIZA:=0;

                           BEGIN
                             SELECT  COUNT(1) INTO LN_CANT_FORMALIZA
                             FROM   GA_SINIESTROS
                             WHERE  COD_PRODUCTO       =  1
                             AND    num_abonado        =  lv_NUM_ABONADO
                             AND    NUM_SERIE          =  lv_IMEI
                             AND    COD_ESTADO         =  'FO'
                             AND    NUM_CONSTPOL_ANULA IS NULL
                             AND    FEC_SINIESTRO     IN (SELECT MAX(FEC_SINIESTRO)
                                                          FROM   GA_SINIESTROS
                                                          WHERE  COD_PRODUCTO       =  1
                                                          AND    num_abonado        =  lv_NUM_ABONADO
                                                          AND    NUM_SERIE          =  lv_IMEI
                                                          AND    COD_ESTADO         =  'FO'
                                                          AND    NUM_CONSTPOL_ANULA IS NULL
                                                          );


                             if LN_CANT_FORMALIZA = 0 Then
                                 LN_IND_EIR:=0;
                                 DBMS_OUTPUT.PUT_LINE('NO GENERA MOVIMIENTO AL EIR YA QUE NO SE ENCUENTRA FORMALIZADO EL SINIESTRO');
                             end if;

                           EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                    LN_IND_EIR:=0;
                           END;

                    END IF;


                      IF (LN_IND_EIR =1 and  TRIM(lv_PARAM1_MENS) IS NOT NULL) THEN
                        LB_flg_eir  := true;
                    END IF;

                end if;

-------------- Validamos fue proceso en ICC el movimiento de listas negras...
-------------- 
                IF  GA_VALIDA_EXIST_ICC_FN(lv_COD_ACTABO,lv_NUM_ABONADO,lv_IMEI,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
                   LB_flg_eir  := false;
                    DBMS_OUTPUT.PUT_LINE('NO GENERA MOVIMIENTO YA QUE EXISTEN MOVIMIENTOS PENDIENTES O YA HABIA SIDO PROCESADO');
                END IF;

        --------------------------------------
            --INI INC 158942 GUA OCB 27-01-2011
            --------------------------------------                 
           --IF TRIM(lv_cod_os)= '10060' then
                
            IF GA_VAL_INDRESTRIC_FN (lv_IMEI, SN_COD_ERROR, SV_MENS_RETORNO, SV_SQL) = 0 THEN
                IF LB_flg_eir = FALSE THEN
                    --regulariza data antes del cambio
                          UPDATE GA_LNCELU set ind_restriccion = 1 
                          WHERE num_serie = lv_IMEI; 
                          DBMS_OUTPUT.PUT_LINE  (' Retorno no genera mov  1:' );               
                else
                    LB_flg_eir  := true; --genera movimiento
                    DBMS_OUTPUT.PUT_LINE  (' Retorno  genera mov 2 :' );
                END IF;
            ELSE -- La función tiene valor 1
                 IF LB_flg_eir = FALSE THEN
                    null; -- no genera movimiento
                    DBMS_OUTPUT.PUT_LINE  (' Retorno no genera mov3  :' );
                ELSE
                    LB_flg_eir  := false; --genera movimiento 
                    DBMS_OUTPUT.PUT_LINE  (' Retorno  genera mov  4:' );
                END IF;
            END IF;
            
        
           --End If;
    
               --------------------------------------
            --FIN INC     GUA OCB 27-01-2011
            --------------------------------------                     
    
 
    
    
                IF  LB_flg_eir  = true THEN

                        EM_tabla(i).NUM_MOVIMIENTO      := lv_NUM_MOVIMIENTO      ;
                        EM_tabla(i).NUM_ABONADO         := lv_NUM_ABONADO         ;
                        EM_tabla(i).COD_ESTADO          := 1;
                        EM_tabla(i).COD_ACTABO          := lv_COD_ACTABO          ;
                        EM_tabla(i).COD_MODULO          := lv_COD_MODULO          ;
                        EM_tabla(i).NUM_INTENTOS        := CN_CERO;
                        EM_tabla(i).COD_CENTRAL_NUE     := NULL;
                        EM_tabla(i).DES_RESPUESTA       := cv_pendiente;
                        EM_tabla(i).COD_ACTUACION       := lv_COD_ACTUACION       ;
                        EM_tabla(i).NOM_USUARORA        := USER;
                        EM_tabla(i).FEC_INGRESO         := SYSDATE;
                        EM_tabla(i).TIP_TERMINAL        := lv_TIP_TERMINAL        ;
                        EM_tabla(i).COD_CENTRAL         := lv_COD_CENTRAL         ;
                        EM_tabla(i).FEC_LECTURA         := NULL;
                        EM_tabla(i).IND_BLOQUEO         := CN_CERO;
                        EM_tabla(i).FEC_EJECUCION       := null;
                        EM_tabla(i).TIP_TERMINAL_NUE    := null;
                        EM_tabla(i).NUM_MOVANT          := null;
                        EM_tabla(i).NUM_CELULAR         := lv_NUM_CELULAR         ;
                        EM_tabla(i).NUM_MOVPOS          := null;
                        EM_tabla(i).NUM_SERIE           := lv_NUM_SERIE           ;
                        EM_tabla(i).NUM_PERSONAL        := null;
                        EM_tabla(i).NUM_CELULAR_NUE     := null;
                        EM_tabla(i).NUM_SERIE_NUE       := null;
                        EM_tabla(i).NUM_PERSONAL_NUE    := null;
                        EM_tabla(i).NUM_MSNB            := null;
                        EM_tabla(i).NUM_MSNB_NUE        := null;
                        EM_tabla(i).COD_SUSPREHA        := null;
                        EM_tabla(i).COD_SERVICIOS       := null;
                        EM_tabla(i).NUM_MIN             := null;
                        EM_tabla(i).NUM_MIN_NUE         := null;
                        EM_tabla(i).STA                 := null;
                        EM_tabla(i).COD_MENSAJE         := null;
                        EM_tabla(i).PARAM1_MENS         := lv_PARAM1_MENS         ;
                        EM_tabla(i).PARAM2_MENS         := null;
                        EM_tabla(i).PARAM3_MENS         := lv_cod_os; --se cambia null para poder distinguir que OOSS de servicio genero el ingreso o egreso;
                        EM_tabla(i).PLAN                := null;
                        EM_tabla(i).CARGA               := null;
                        EM_tabla(i).VALOR_PLAN          := null;
                        EM_tabla(i).PIN                 := null;
                        EM_tabla(i).FEC_EXPIRA          := null;
                        EM_tabla(i).DES_MENSAJE         := null;
                        EM_tabla(i).COD_PIN             := null;
                        EM_tabla(i).COD_IDIOMA          := null;
                        EM_tabla(i).COD_ENRUTAMIENTO    := null;
                        EM_tabla(i).TIP_ENRUTAMIENTO    := null;
                        EM_tabla(i).DES_ORIGEN_PIN      := lv_DES_ORIGEN_PIN      ;
                        EM_tabla(i).NUM_LOTE_PIN        := null;
                        EM_tabla(i).NUM_SERIE_PIN       := null;
                        EM_tabla(i).TIP_TECNOLOGIA      := lv_TIP_TECNOLOGIA      ;
                        EM_tabla(i).IMSI                := null;
                        EM_tabla(i).IMSI_NUE            := null;
                        EM_tabla(i).IMEI                := lv_IMEI                ;
                        EM_tabla(i).IMEI_NUE            := null;
                        EM_tabla(i).ICC                 := null;
                        EM_tabla(i).ICC_NUE             := null;
                        EM_tabla(i).FEC_ACTIVACION      := null;
                        EM_tabla(i).COD_ESPEC_PROV      := null;
                        EM_tabla(i).COD_PROD_CONTRATADO := null;
                        EM_tabla(i).IND_BAJATRANS       := null;
                        i:= i +1;
                END IF;
            END IF;

        END LOOP;
    CLOSE C1;



    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 1143;
         SV_MENS_RETORNO := 'GA_REC_SERIE_ING_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END GA_REC_SERIE_ING_FN;


/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION GA_REC_SERIE_EGS_FN   (EM_TABLA              OUT NOCOPY TIP_ICC_MOVIMIENTO,
                                EN_NUM_SERIE          IN  ga_lncelu.num_serie%TYPE,
                                ED_FEC_ALTA           IN  DATE,
                                SN_COD_ERROR          OUT NOCOPY NUMBER,
                                SV_MENS_RETORNO       OUT NOCOPY VARCHAR2,
                                SV_SQL                OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;
  LV_num_imei   icc_movimiento.imei%TYPE;
  i number(3);
   lv_NUM_MOVIMIENTO     icc_movimiento.NUM_MOVIMIENTO%type;
    lv_NUM_ABONADO       icc_movimiento.NUM_ABONADO%type;
    lv_COD_ESTADO        icc_movimiento.COD_ESTADO%type;
    lv_COD_ACTABO        icc_movimiento.COD_ACTABO%type;
    lv_COD_MODULO        icc_movimiento.COD_MODULO%type;
    lv_NUM_INTENTOS      icc_movimiento.NUM_INTENTOS%type;
    lv_COD_CENTRAL_NUE  icc_movimiento.COD_CENTRAL_NUE%type;
    lv_DES_RESPUESTA    icc_movimiento.DES_RESPUESTA%type;
    lv_COD_ACTUACION    icc_movimiento.COD_ACTUACION%type;
    lv_NOM_USUARORA     icc_movimiento.NOM_USUARORA%type;
    lv_FEC_INGRESO      icc_movimiento.FEC_INGRESO%type;
    lv_TIP_TERMINAL     icc_movimiento.TIP_TERMINAL%type;
    lv_COD_CENTRAL      icc_movimiento.COD_CENTRAL%type;
    lv_FEC_LECTURA      icc_movimiento.FEC_LECTURA%type;
    lv_IND_BLOQUEO      icc_movimiento.IND_BLOQUEO%type;
    lv_FEC_EJECUCION      icc_movimiento.FEC_EJECUCION%type;
    lv_TIP_TERMINAL_NUE icc_movimiento.TIP_TERMINAL_NUE%type;
    lv_NUM_MOVANT          icc_movimiento.NUM_MOVANT%type;
    lv_NUM_CELULAR      icc_movimiento.NUM_CELULAR%type;
    lv_NUM_MOVPOS          icc_movimiento.NUM_MOVPOS%type;
    lv_NUM_SERIE          icc_movimiento.NUM_SERIE%type;
    lv_NUM_PERSONAL      icc_movimiento.NUM_PERSONAL%type;
    lv_NUM_CELULAR_NUE  icc_movimiento.NUM_CELULAR_NUE%type;
    lv_NUM_SERIE_NUE      icc_movimiento.NUM_SERIE_NUE%type;
    lv_NUM_PERSONAL_NUE icc_movimiento.NUM_PERSONAL_NUE%type;
    lv_NUM_MSNB          icc_movimiento.NUM_MSNB%type;
    lv_NUM_MSNB_NUE      icc_movimiento.NUM_MSNB_NUE%type;
    lv_COD_SUSPREHA      icc_movimiento.COD_SUSPREHA%type;
    lv_COD_SERVICIOS     icc_movimiento.COD_SERVICIOS%type;
    lv_NUM_MIN          icc_movimiento.NUM_MIN%type;
    lv_NUM_MIN_NUE      icc_movimiento.NUM_MIN_NUE%type;
    lv_STA              icc_movimiento.STA%type;
    lv_COD_MENSAJE      icc_movimiento.COD_MENSAJE%type;
    lv_PARAM1_MENS      icc_movimiento.PARAM1_MENS%type;
    lv_PARAM2_MENS      icc_movimiento.PARAM2_MENS%type;
    lv_PARAM3_MENS      icc_movimiento.PARAM3_MENS%type;
    lv_PLAN              icc_movimiento.PLAN%type;
    lv_CARGA             icc_movimiento.CARGA%type;
    lv_VALOR_PLAN          icc_movimiento.VALOR_PLAN%type;
    lv_PIN              icc_movimiento.PIN%type;
    lv_FEC_EXPIRA          icc_movimiento.FEC_EXPIRA%type;
    lv_DES_MENSAJE      icc_movimiento.DES_MENSAJE%type;
    lv_COD_PIN          icc_movimiento.COD_PIN%type;
    lv_COD_IDIOMA          icc_movimiento.COD_IDIOMA%type;
    lv_COD_ENRUTAMIENTO    icc_movimiento.COD_ENRUTAMIENTO%type;
    lv_TIP_ENRUTAMIENTO icc_movimiento.TIP_ENRUTAMIENTO%type;
    lv_DES_ORIGEN_PIN      icc_movimiento.DES_ORIGEN_PIN%type;
    lv_NUM_LOTE_PIN      icc_movimiento.NUM_LOTE_PIN%type;
    lv_NUM_SERIE_PIN      icc_movimiento.NUM_SERIE_PIN%type;
    lv_TIP_TECNOLOGIA      icc_movimiento.TIP_TECNOLOGIA%type;
    lv_IMSI              icc_movimiento.IMSI%type;
    lv_IMSI_NUE          icc_movimiento.IMSI_NUE%type;
    lv_IMEI              icc_movimiento.IMEI%type;
    lv_IMEI_NUE          icc_movimiento.IMEI_NUE%type;
    lv_ICC              icc_movimiento.ICC%type;
    lv_ICC_NUE          icc_movimiento.ICC_NUE%type;
    lv_FEC_ACTIVACION      icc_movimiento.FEC_ACTIVACION%type;
    lv_COD_ESPEC_PROV      icc_movimiento.COD_ESPEC_PROV%type;
    lv_COD_PROD_CONTRATADO  icc_movimiento.COD_PROD_CONTRATADO%type;
    lv_IND_BAJATRANS      icc_movimiento.IND_BAJATRANS%type;
    lv_cod_causa_os     GA_CAUSAEIR_TO.COD_CAUSA_OS%type;
    lv_cod_os           GA_CAUSAEIR_TO.COD_OS%type;
    LN_IND_EIR          GA_CAUSABAJA.IND_EIR%TYPE;
    LB_flg_eir          BOOLEAN;
    LN_num_secuencia    ga_transacabo.NUM_TRANSACCION%TYPE;
    lv_valor_texto      ge_parametros_sistema_vw.VALOR_TEXTO%type;
    ln_cod_retorno      ge_errores_pg.CodError;
    lv_mens_retorno     ge_errores_pg.MsgError;
    ln_num_evento       ge_errores_pg.evento;
    lv_aplica_luhn      ged_parametros.val_parametro%type;


  CURSOR C1 IS
  select    a.num_abonado
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,a.tip_terminal
            ,a.cod_central
            ,a.num_celular
            ,a.num_serie
            ,e.COD_CAUSA_REV
            ,b.cod_operador
            ,a.cod_tecnologia
            ,a.num_imei
            ,e.COD_CAUSA_OS_REV
            ,e.COD_OS_REV
    from   ga_abocel a, ga_histlncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where  a.num_abonado     =   b.num_abonado
    and    (a.num_imei       =   b.num_serie or     a.num_serie       =   b.num_serie)
    and    b.num_serie       =   nvl(lv_num_imei,b.num_serie)
    and    b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   1
    and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate))
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =   CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    c.cod_tecnologia  =   a.cod_tecnologia
    and    c.cod_modulo      =   CV_modulo_le
    and    e.cod_causa      !=   CN_cero
    union
    select   a.num_abonado
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,a.tip_terminal
            ,a.cod_central
            ,a.num_celular
            ,a.num_serie
            ,e.COD_CAUSA_REV
            ,b.cod_operador
            ,a.cod_tecnologia
            ,a.num_imei
            ,e.COD_CAUSA_OS_REV
            ,e.COD_OS_REV
    from   ga_aboamist a, ga_histlncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where  a.num_abonado     =   b.num_abonado
    and    (a.num_imei       =   b.num_serie or     a.num_serie       =   b.num_serie)
    and    b.num_serie       =   nvl(lv_num_imei,b.num_serie)
    and    b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   1
    and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate))
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =   CV_tip_listaB)
  and    c.cod_actabo      =   d.cod_actabo
    and    c.cod_tecnologia  =   a.cod_tecnologia
    and    c.cod_modulo      =   CV_modulo_le
    and    e.cod_causa      !=   CN_cero
     union
    select   0
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,'T'
            ,0
            ,0
            ,e.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,null
            ,e.num_serie
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_histlncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where
           b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   1
    and    (b.num_abonado     = 0 or b.num_abonado is null)
     and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate))
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =    CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    length(trim(e.num_serie))  = 15
    and    c.cod_tecnologia  =   'GSM'
    and    c.cod_modulo      =   CV_modulo_le
    AND   (E.COD_OS = 0 OR E.COD_OS IS NULL)
    union
    select  0
            ,c.cod_actabo
            ,c.cod_modulo
            ,c.cod_actcen
            ,'A'
            ,0
            ,0
            ,e.num_serie
            ,e.cod_causa
            ,b.cod_operador
            ,null
            ,e.num_serie
            ,e.cod_causa_os
            ,e.COD_OS
    from   ga_histlncelu b, ga_actabo c , ga_tipo_lista_ln_td d,ga_causaeir_to e
    where
           b.num_serie       =   e.NUM_SERIE
    and    e.COD_ESTADO      =   1
    and    (b.num_abonado     = 0 or b.num_abonado is null)
     and    trunc(b.fec_alta) =   nvl(ed_fec_alta,trunc(sysdate))
    and    d.cod_tipo_lista  =   b.tip_lista
    and    (d.cod_tipo_lista  =   e.cod_tipolista OR     e.cod_tipolista   =    CV_tip_listaB)
    and    c.cod_actabo      =   d.cod_actabo
    and    (length(trim(e.num_serie))  < 15 or  length(trim(e.num_serie)) > 15)
    and    c.cod_tecnologia  =   'CDMA'
    and    c.cod_modulo      =   CV_modulo_le
    AND   (E.COD_OS = 0 OR E.COD_OS IS NULL);


BEGIN

    SV_SQL:='';

    lv_num_imei:=  EN_NUM_SERIE;
    lv_aplica_luhn:=ge_fn_devvalparam('GE',1,'APLICA_LUHN');
    i:=1;

    OPEN C1;
        LOOP
        FETCH C1 INTO lv_NUM_ABONADO,lv_COD_ACTABO,lv_COD_MODULO,lv_COD_ACTUACION,lv_TIP_TERMINAL,lv_COD_CENTRAL,
                      lv_NUM_CELULAR,lv_NUM_SERIE,lv_PARAM1_MENS,lv_DES_ORIGEN_PIN,lv_TIP_TECNOLOGIA,lv_IMEI,lv_cod_causa_os,lv_cod_os;
        EXIT WHEN C1%NOTFOUND;


              select   icc_seq_nummov.nextval
            into lv_NUM_MOVIMIENTO from dual;

            LB_flg_eir  := false;
            LN_IND_EIR  :=0;

            ln_cod_retorno :=0;
            if lv_aplica_luhn = 'TRUE' then
                LN_num_secuencia:= GA_REC_SECUENCIA_FN('GA_SEQ_TRANSACABO');
                ga_valida_luhn_pr(LN_num_secuencia,lv_imei,ln_cod_retorno,lv_mens_retorno,ln_num_evento);
            end if;

            IF ln_cod_retorno = 0 THEN
                if (trim(lv_cod_os)= '' OR  trim(lv_cod_os)= '0' OR lv_cod_os IS NULL) then
                    LB_flg_eir  := true;
                ELSE

                    IF (TRIM(lv_cod_os)='50014' OR TRIM(lv_cod_os)='50015') THEN -- anulación de baja por fraude

                            BEGIN

                              SELECT  IND_EIR INTO LN_IND_EIR
                              FROM GA_CAUSABAJA
                              WHERE  COD_PRODUCTO =1
                              AND COD_CAUSABAJA =lv_cod_causa_os;

                            EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    LN_IND_EIR:=0;
                            END;

                    END IF;

                    IF (TRIM(lv_cod_os)='10096') THEN -- reposion programada de la suspension

                            BEGIN

                              SELECT  IND_EIR INTO LN_IND_EIR
                              FROM GA_CAUSUSP
                              WHERE  COD_PRODUCTO =1
                              AND COD_CAUSUSP =lv_cod_causa_os;

                            EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    LN_IND_EIR:=0;
                            END;

                    END IF;

                    IF (TRIM(lv_cod_os)= '50009' OR TRIM(lv_cod_os)= '50010')  THEN  --desbloqueo por fraude

                            BEGIN


                                            SELECT  IND_EIR INTO LN_IND_EIR
                                            FROM PV_CAUSABLODESQ
                                            WHERE  COD_PRODUCTO =1
                                            AND COD_CAUSABLODES =lv_cod_causa_os;


                            EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                            LN_IND_EIR:=0;
                            END;

                    END IF;

                    IF TRIM(lv_cod_os)= '10231' THEN   -- anula siniestro

                           BEGIN
                             SELECT  IND_EIR INTO LN_IND_EIR
                             FROM   GA_CAUSINIE
                             WHERE  COD_PRODUCTO =1
                             AND COD_CAUSA =lv_cod_causa_os;

                           EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                    LN_IND_EIR:=0;
                           END;
                    END IF;


                      IF (LN_IND_EIR =1 and  TRIM(lv_PARAM1_MENS) IS NOT NULL) THEN
                        LB_flg_eir  := true;
                    END IF;

                end if;

-------------- Validamos fue proceso en ICC el movimiento de listas negras...
-------------- 
                IF  GA_VALIDA_EXIST_ICC_FN(lv_COD_ACTABO,lv_NUM_ABONADO,lv_IMEI,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
                   LB_flg_eir  := false;
                END IF;

        --------------------------------------
            --INI INC 158942 GUA OCB 27-11-2011
            --------------------------------------                 
            IF TRIM(lv_cod_os)= '10231' THEN
                  
            IF GA_VAL_INDRESTRIC_FN (lv_IMEI, SN_COD_ERROR, SV_MENS_RETORNO, SV_SQL) = 0 THEN
                IF LB_flg_eir = FALSE THEN
                    null;            
                else
                    LB_flg_eir  := true; --genera movimiento
                END IF;
            ELSE -- La función tiene valor 1
                 IF LB_flg_eir = FALSE THEN
                    null; -- no genera movimiento
                ELSE
                    LB_flg_eir  := true; --genera movimiento
                END IF;
            END IF;
            End If;
        --------------------------------------
            --FIN INC 158942 GUA OCB 27-11-2011
            --------------------------------------                        


                IF  LB_flg_eir  = true THEN

                        EM_tabla(i).NUM_MOVIMIENTO      := lv_NUM_MOVIMIENTO      ;
                        EM_tabla(i).NUM_ABONADO         := lv_NUM_ABONADO         ;
                        EM_tabla(i).COD_ESTADO          := 1;
                        EM_tabla(i).COD_ACTABO          := lv_COD_ACTABO          ;
                        EM_tabla(i).COD_MODULO          := lv_COD_MODULO          ;
                        EM_tabla(i).NUM_INTENTOS        := CN_CERO;
                        EM_tabla(i).COD_CENTRAL_NUE     := NULL;
                        EM_tabla(i).DES_RESPUESTA       := cv_pendiente;
                        EM_tabla(i).COD_ACTUACION       := lv_COD_ACTUACION       ;
                        EM_tabla(i).NOM_USUARORA        := USER;
                        EM_tabla(i).FEC_INGRESO         := SYSDATE;
                        EM_tabla(i).TIP_TERMINAL        := lv_TIP_TERMINAL        ;
                        EM_tabla(i).COD_CENTRAL         := lv_COD_CENTRAL         ;
                        EM_tabla(i).FEC_LECTURA         := NULL;
                        EM_tabla(i).IND_BLOQUEO         := CN_CERO;
                        EM_tabla(i).FEC_EJECUCION       := null;
                        EM_tabla(i).TIP_TERMINAL_NUE    := null;
                        EM_tabla(i).NUM_MOVANT          := null;
                        EM_tabla(i).NUM_CELULAR         := lv_NUM_CELULAR         ;
                        EM_tabla(i).NUM_MOVPOS          := null;
                        EM_tabla(i).NUM_SERIE           := lv_NUM_SERIE           ;
                        EM_tabla(i).NUM_PERSONAL        := null;
                        EM_tabla(i).NUM_CELULAR_NUE     := null;
                        EM_tabla(i).NUM_SERIE_NUE       := null;
                        EM_tabla(i).NUM_PERSONAL_NUE    := null;
                        EM_tabla(i).NUM_MSNB            := null;
                        EM_tabla(i).NUM_MSNB_NUE        := null;
                        EM_tabla(i).COD_SUSPREHA        := null;
                        EM_tabla(i).COD_SERVICIOS       := null;
                        EM_tabla(i).NUM_MIN             := null;
                        EM_tabla(i).NUM_MIN_NUE         := null;
                        EM_tabla(i).STA                 := null;
                        EM_tabla(i).COD_MENSAJE         := null;
                        EM_tabla(i).PARAM1_MENS         := lv_PARAM1_MENS         ;
                        EM_tabla(i).PARAM2_MENS         := null;
                        EM_tabla(i).PARAM3_MENS         := lv_cod_os; --se cambia null para poder distinguir que OOSS de servicio genero el ingreso o egreso
                        EM_tabla(i).PLAN                := null;
                        EM_tabla(i).CARGA               := null;
                        EM_tabla(i).VALOR_PLAN          := null;
                        EM_tabla(i).PIN                 := null;
                        EM_tabla(i).FEC_EXPIRA          := null;
                        EM_tabla(i).DES_MENSAJE         := null;
                        EM_tabla(i).COD_PIN             := null;
                        EM_tabla(i).COD_IDIOMA          := null;
                        EM_tabla(i).COD_ENRUTAMIENTO    := null;
                        EM_tabla(i).TIP_ENRUTAMIENTO    := null;
                        EM_tabla(i).DES_ORIGEN_PIN      := lv_DES_ORIGEN_PIN      ;
                        EM_tabla(i).NUM_LOTE_PIN        := null;
                        EM_tabla(i).NUM_SERIE_PIN       := null;
                        EM_tabla(i).TIP_TECNOLOGIA      := lv_TIP_TECNOLOGIA      ;
                        EM_tabla(i).IMSI                := null;
                        EM_tabla(i).IMSI_NUE            := null;
                        EM_tabla(i).IMEI                := lv_IMEI                ;
                        EM_tabla(i).IMEI_NUE            := null;
                        EM_tabla(i).ICC                 := null;
                        EM_tabla(i).ICC_NUE             := null;
                        EM_tabla(i).FEC_ACTIVACION      := null;
                        EM_tabla(i).COD_ESPEC_PROV      := null;
                        EM_tabla(i).COD_PROD_CONTRATADO := null;
                        EM_tabla(i).IND_BAJATRANS       := null;
                        i:= i +1;
                END IF;
            END IF;
        END LOOP;
    CLOSE C1;


    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 1143;
         SV_MENS_RETORNO := 'GA_REC_SERIE_EGS_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END GA_REC_SERIE_EGS_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION GA_REG_MOVIMIENTO_FN (EM_TABLA         IN  TIP_ICC_MOVIMIENTO,
                               SN_COD_ERROR       OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                               SV_SQL                 OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
BEGIN

    SV_SQL:='';

    --FORALL i IN 1..EM_TABLA.COUNT                   --INC 158942 GUA JRCH 23-12-2010
    --INSERT INTO ICC_MOVIMIENTO VALUES EM_TABLA(i);  --INC 158942 GUA JRCH 23-12-2010 
    
    --INI INC 158942 GUA JRCH 23-12-2010
    
    FOR i IN 1..EM_TABLA.COUNT
    LOOP
    
    dbms_output.put_line('SERIE:'||EM_TABLA(i).IMEI);    
    dbms_output.put_line('COD_ACTABO:'||EM_TABLA(i).COD_ACTABO);    
      
      INSERT INTO ICC_MOVIMIENTO VALUES EM_TABLA(i);
      
      IF   ((EM_TABLA(i).COD_ACTABO ='L2' OR  EM_TABLA(i).COD_ACTABO ='L3' OR  EM_TABLA(i).COD_ACTABO ='L1') ) THEN  
       --   and   EM_TABLA(i).PARAM3_MENS= '10060') THEN --FNI INC 158942 GUA OCB 27-01-2011
    
      UPDATE GA_LNCELU set ind_restriccion = 1 
      WHERE num_serie = EM_TABLA(i).IMEI;
      
     END IF; 

     
    END LOOP;
   
    --FNI INC 158942 GUA JRCH 23-12-2010


    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 1144;
         SV_MENS_RETORNO := 'GA_REG_MOVIMIENTO_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END GA_REG_MOVIMIENTO_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/

PROCEDURE GA_INSCRIBE_MOV_LN_PR(EN_NUM_SERIE             IN              ga_lncelu.num_serie%TYPE,
                                ED_FEC_ALTA              IN              DATE,
                                SV_MENS_RETORNO          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                SN_NUM_EVENTO            OUT NOCOPY      ge_errores_pg.evento)
IS

 LM_ICC_MOVMIENTO   TIP_ICC_MOVIMIENTO;
 LV_des_error       ge_errores_pg.DesEvent;
 LV_Sql             ge_errores_pg.vQuery;
 LN_COD_ERROR       NUMBER;
 ERROR_FUNCION      EXCEPTION;

BEGIN

         sv_mens_retorno := NULL;
         sn_num_evento  := 0;



    IF NOT GA_REC_SERIE_ING_FN(LM_ICC_MOVMIENTO,EN_NUM_SERIE,ED_FEC_ALTA,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
          RAISE ERROR_FUNCION;
    END IF;



    IF NOT GA_REG_MOVIMIENTO_FN(LM_ICC_MOVMIENTO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
          RAISE ERROR_FUNCION;
    END IF;



    IF NOT GA_REC_SERIE_EGS_FN(LM_ICC_MOVMIENTO,EN_NUM_SERIE,ED_FEC_ALTA,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
          RAISE ERROR_FUNCION;
    END IF;


    IF NOT GA_REG_MOVIMIENTO_FN(LM_ICC_MOVMIENTO,LN_COD_ERROR,SV_MENS_RETORNO,LV_Sql) THEN
          RAISE ERROR_FUNCION;
    END IF;


EXCEPTION
    WHEN ERROR_FUNCION THEN
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INSCRIBE_MOV_LN_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
        ROLLBACK;
        WHEN OTHERS THEN
                SV_MENS_RETORNO := SV_MENS_RETORNO;
                SN_NUM_EVENTO     := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INSCRIBE_MOV_LN_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
        ROLLBACK;
    END GA_INSCRIBE_MOV_LN_PR;



PROCEDURE GA_INSCRIBE_CAUSALISTA_PR(       EN_COD_PROCESO           IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                           EV_COD_CAUSA             IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                                           EV_COD_TIPOLISTA         IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                           EV_COD_OS                IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                           EN_ORIGEN                IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                           EN_COD_ESTADO        IN              GA_CAUSAEIR_TO.COD_ESTADO%TYPE,
                                           SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                           SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                           SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento)
IS

 LV_des_error       ge_errores_pg.DesEvent;
 LV_Sql             ge_errores_pg.vQuery;
 LV_NUM_SERIE       GA_LNCELU.NUM_SERIE%TYPE;
 LN_COD_ERROR       NUMBER;
 LN_CERO            NUMBER(3);

 CURSOR C1 IS
 SELECT CAMPO_3
 FROM ga_series_ln_oop_to
 WHERE
 COD_PROCESO      = EN_COD_PROCESO
 AND   campo_7    = CN_accion_ingreso
 AND   cod_estado = CN_estado_valido
 AND  CAMPO_3 IS NOT NULL;



BEGIN



        SN_COD_RETORNO  :=0;
        SV_MENS_RETORNO :='';
        SN_NUM_EVENTO   :=0;
          OPEN C1;
        LOOP
        FETCH C1 INTO LV_NUM_SERIE;
        EXIT WHEN C1%NOTFOUND;


              LN_CERO:=0;
              SELECT  COUNT(1)
              INTO LN_CERO
              FROM ga_lncelu A
              WHERE
              A.NUM_SERIE =LV_NUM_SERIE;

              IF LN_CERO >0 THEN

                LV_Sql :='INSERT INTO GA_CAUSAEIR_TO(NUM_SERIE,COD_CAUSA,COD_TIPOLISTA,COD_OS,FEC_ING,NOM_USUARIO,ORIG_TRANS) VALUES';
                LV_Sql := LV_Sql ||'('||LV_NUM_SERIE||','||EV_COD_CAUSA||','||EV_COD_TIPOLISTA||','||EV_COD_OS||','|| SYSDATE||','||USER||','||EN_ORIGEN||')';

                INSERT INTO GA_CAUSAEIR_TO(NUM_SERIE,COD_CAUSA,COD_TIPOLISTA,COD_OS,FEC_ING,NOM_USUARIO,ORIG_TRANS,COD_ESTADO)
                VALUES
                (LV_NUM_SERIE,EV_COD_CAUSA,EV_COD_TIPOLISTA,EV_COD_OS,SYSDATE,USER,EN_ORIGEN,EN_COD_ESTADO);
                commit;
              end if  ;

       END LOOP;

       CLOSE C1;
EXCEPTION

        WHEN OTHERS THEN
                SN_COD_RETORNO  :=4;
                SV_MENS_RETORNO := 'GA_INT_LISTAS_NEGRAS_PG.GA_INSCRIBE_CAUSALISTA_PR' || SQLERRM;
                SN_NUM_EVENTO     := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_INSCRIBE_CAUSALISTA_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );

END GA_INSCRIBE_CAUSALISTA_PR;



PROCEDURE GA_HISTORICO_CAUSALISTA_PR(       EN_COD_PROCESO           IN              ga_series_ln_oop_to.cod_proceso%TYPE,
                                           EV_COD_CAUSA             IN              GA_CAUSAEIR_TO.COD_CAUSA%TYPE,
                                           EV_COD_TIPOLISTA         IN              GA_CAUSAEIR_TO.COD_TIPOLISTA%TYPE,
                                           EV_COD_OS                IN              GA_CAUSAEIR_TO.COD_OS%TYPE,
                                           EN_ORIGEN                IN              GA_CAUSAEIR_TO.ORIG_TRANS%TYPE,
                                           EN_COD_ESTADO        IN              GA_CAUSAEIR_TO.COD_ESTADO%TYPE,
                                           SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                           SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                           SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento)
IS

 LV_des_error       ge_errores_pg.DesEvent;
 LV_Sql             ge_errores_pg.vQuery;
 LV_NUM_SERIE       GA_LNCELU.NUM_SERIE%TYPE;
 LN_COD_ERROR        NUMBER;
 LN_CERO            NUMBER(3);


 CURSOR C1 IS
 SELECT CAMPO_3
 FROM ga_series_ln_oop_to
 WHERE
 COD_PROCESO      = EN_COD_PROCESO
 AND   campo_7    = CN_accion_EGRESO
 AND   cod_estado = CN_estado_valido
 AND  CAMPO_3 IS NOT NULL;




BEGIN



        SN_COD_RETORNO  :=0;
        SV_MENS_RETORNO :='';
        SN_NUM_EVENTO   :=0;


        OPEN C1;
        LOOP
        FETCH C1 INTO LV_NUM_SERIE;
        EXIT WHEN C1%NOTFOUND;

              LN_CERO:=0;
              SELECT  COUNT(1)
              INTO LN_CERO
              FROM ga_histlncelu A
              WHERE
              A.NUM_SERIE =LV_NUM_SERIE AND
              A.NUM_SERIE IN (SELECT  B.NUM_SERIE FROM ga_histlncelu B
                            WHERE
                            B.NUM_SERIE =A.NUM_SERIE AND
                            B.FEC_BAJA IN (SELECT  MAX(C.FEC_BAJA) FROM ga_histlncelu C
                                     WHERE  C.NUM_SERIE =B.NUM_SERIE ));

              IF LN_CERO >0 THEN
                      UPDATE GA_CAUSAEIR_TO
                      SET
                      COD_ESTADO = 1,
                      NOM_USUARIO=USER
                      WHERE NUM_SERIE =LV_NUM_SERIE
                      AND COD_ESTADO =0;
              END IF;

       END LOOP;

       CLOSE C1;
EXCEPTION

        WHEN OTHERS THEN
                SN_COD_RETORNO  :=4;
                SV_MENS_RETORNO := 'GA_INT_LISTAS_NEGRAS_PG.GA_HISTORICO_CAUSALISTA_PR' || SQLERRM;
                SN_NUM_EVENTO     := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_HISTORICO_CAUSALISTA_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );

END GA_HISTORICO_CAUSALISTA_PR;




PROCEDURE GA_VALIDA_LUHN_PR(               EN_NUM_SECUENCIA            IN      GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                           EV_NUM_IMEI                 IN      GA_LNCELU.NUM_SERIE%TYPE,
                                           SN_COD_RETORNO      OUT NOCOPY      ge_errores_pg.CodError,
                                           SV_MENS_RETORNO     OUT NOCOPY      ge_errores_pg.MsgError,
                                           SN_NUM_EVENTO       OUT NOCOPY      ge_errores_pg.evento)


IS

    LV_des_error       ge_errores_pg.DesEvent;
    LV_Sql             ge_errores_pg.vQuery;
    LV_NUM_SERIE       GA_LNCELU.NUM_SERIE%TYPE;
    LN_COD_ERROR        NUMBER;
    LN_CERO            NUMBER(3);
    LB_retorno       BOOLEAN;

    LN_largoimei     ga_aboamist.num_imei%TYPE;
    LN_len           number:=0;
    LV_dig           varchar2(2);
    LV_num           varchar2(16);
    LV_digval        varchar2(2);
    LV_CADENA        varchar2(255) := NULL;
    LV_ERROR         VARCHAR2(1) := '0';

    error_datos      EXCEPTION;


BEGIN

        SN_COD_RETORNO  :=0;
        SV_MENS_RETORNO :='';
        SN_NUM_EVENTO   :=0;

           LB_retorno:= ve_recuperaparametros_sms_pg.ve_recupera_parametros_fn('LARGO_SERIE_TGSM', 'AL', 1, LN_largoimei, SN_COD_RETORNO , SV_MENS_RETORNO,SN_NUM_EVENTO );
           IF NOT LB_retorno THEN
                   LV_ERROR := '1';
                   RAISE error_datos;
           END IF;


           LN_len := LENGTH(TRIM(EV_num_imei));
           IF LN_len<>TO_NUMBER(LN_largoimei) THEN
                   LV_ERROR := '2'; --ERROR_LARGO_IMSI
                   RAISE error_datos;
           END IF;

           LV_dig := substr(EV_num_imei,LN_len, 1);
           LV_num := substr(EV_num_imei,1, LN_len-1);

           LV_digval := GE_FN_LUHN(LV_num);

           IF LV_dig<>LV_digval THEN
                   LV_ERROR := '3';
                   LV_CADENA := 'Digito encontrado:' || LV_digval;
                   RAISE error_datos;
           END IF;


           LV_CADENA := EV_num_imei;
           RAISE error_datos;



EXCEPTION

         WHEN error_datos THEN
           INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (EN_NUM_SECUENCIA,
                   LV_ERROR,
                   LV_CADENA);

        WHEN OTHERS THEN
                SN_COD_RETORNO  :=4;
                SV_MENS_RETORNO := 'GA_INT_LISTAS_NEGRAS_PG.GA_VALIDA_LUHN_PR' || SQLERRM;
                SN_NUM_EVENTO     := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'GA_INT_LISTAS_NEGRAS_PG.GA_VALIDA_LUHN_PR', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );

END GA_VALIDA_LUHN_PR;


FUNCTION GA_VALIDA_EXIST_ICC_FN (EV_COD_ACTABO        IN  icc_movimiento.COD_ACTABO%type,
                                EN_ABONADO            IN  icc_movimiento.NUM_ABONADO%type,
                                EV_IMEI               IN  icc_movimiento.IMEI%type,
                                SN_COD_ERROR          OUT NOCOPY ge_errores_pg.CodError,
                                SV_MENS_RETORNO       OUT NOCOPY ge_errores_pg.MsgError,
                                SV_SQL                OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

LV_sql             VARCHAR2(2000);
LN_MODULO           ga_actabo.cod_modulo%type;
LV_EGS_ACTABO       ga_actabo.COD_ACTABO%type;
LV_ING_ACTABO       ga_actabo.COD_ACTABO%type;
LN_COD_ESTADO       icc_movimiento.COD_ESTADO%type;
LN_COD_ESTADO1      icc_movimiento.COD_ESTADO%type;
LN_MOV              NUMBER(5);
LV_periodo          VARCHAR2(8);
LV_fecha1           DATE;
LV_fecha2           DATE;
LN_SW               NUMBER(1);
LN_SW1              NUMBER(1);

LN_ind_restriccion  NUMBER(1); --INC 158942 GUA JRCH 23-12-2010

BEGIN

    SV_SQL:='';
    
    --------------------------------------
    --INI INC 158942 GUA JRCH 23-12-2010
    --------------------------------------    
    BEGIN
    select ind_restriccion into LN_ind_restriccion 
    from GA_LNCELU where num_Serie=EV_IMEI;
    
    IF LN_ind_restriccion = 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
    
     EXCEPTION
        WHEN OTHERS THEN
            RETURN FALSE;
     END;
     
    -- Todo Lo Posterior se debe evaluar si se comenta o no
    -- dependiendo del EGRESO
    
    --------------------------------------    
    --FIN INC 158942 GUA JRCH 23-12-2010
    --------------------------------------    
    
    select to_char(sysdate,'MMYYYY') into LV_periodo from dual;

--     ---Obtenemos si es Ingreso o Egreso 
     BEGIN

     SELECT COD_MODULO INTO LN_MODULO
     FROM GA_ACTABO
     WHERE COD_PRODUCTO=1
      AND COD_ACTABO = EV_COD_ACTABO;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
     END;
--     

     
    CASE  LN_MODULO
      WHEN 'LI' THEN               
      
              --- Obtenemos el movimiento contrario al ingreso...
              IF EV_COD_ACTABO = 'L2' THEN --- Ingreso Seri Lista Negra
                   LV_EGS_ACTABO := 'D2';   --- Egreso SeriE Lista Negra
              ELSE
                IF EV_COD_ACTABO = 'L3' THEN --- Ingreso Seri Lista Gris
                   LV_EGS_ACTABO := 'D9';   --- Egreso SeriE Lista Gris
                ELSE
                   IF EV_COD_ACTABO = 'L1' THEN --- Ingreso SeriE Lista Blanca
                      LV_EGS_ACTABO := 'D1';   --- Egreso Seri Lista Blanca                           
                   END IF;
                END IF;
              END IF;
              
              ---DBMS_OUTPUT.PUT_LINE('222222222222222222222222 :'||LV_EGS_ACTABO);
                                  
              ---Validamos si ya existe el movimiento en icc
              ---------------------------------------------------
               BEGIN
               
                  IF EN_ABONADO IS NOT NULL AND EN_ABONADO > 0 THEN
                  
                      SELECT A.COD_ESTADO INTO LN_COD_ESTADO 
                       FROM ICC_MOVIMIENTO A
                      WHERE A.NUM_ABONADO   = EN_ABONADO
                        AND A.COD_ACTABO = EV_COD_ACTABO
                        AND A.IMEI          = EV_IMEI
                        AND A.FEC_INGRESO   = (SELECT MAX(B.FEC_INGRESO) FROM ICC_MOVIMIENTO B
                                         WHERE B.NUM_ABONADO = EN_ABONADO 
                                           AND B.IMEI = EV_IMEI
                                           AND B.COD_ACTABO = EV_COD_ACTABO);  
                  ELSE
                  
                      SELECT A.COD_ESTADO INTO LN_COD_ESTADO
                       FROM ICC_MOVIMIENTO A
                      WHERE A.COD_ACTABO = EV_COD_ACTABO
                        AND A.IMEI          = EV_IMEI
                        AND A.FEC_INGRESO   = (SELECT MAX(B.FEC_INGRESO) FROM ICC_MOVIMIENTO B
                                         WHERE B.COD_ACTABO = EV_COD_ACTABO
                                           AND B.IMEI = EV_IMEI);                     
                  END IF;
                                  
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                       NULL;
               END;
               
               ---DBMS_OUTPUT.PUT_LINE('333333333333333333333333333 :'||LN_COD_ESTADO );
               
               --ojo, solo si el registro icc es valido lo excluimos altiro...
               IF LN_COD_ESTADO IS NOT NULL THEN
                   IF LN_COD_ESTADO IN (1,2,9,0,11,12) THEN
                     if LN_ind_restriccion = 1 then
                     RETURN TRUE;
                     end if;
                   END IF;
               END IF;
                                
                        
               
               ---- Historicos icc          
               --------------------------------------------------------
              IF EN_ABONADO IS NOT NULL AND EN_ABONADO > 0 THEN
                                             
                  ---buscamos el ingreso
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.NUM_ABONADO = '||EN_ABONADO; 
                  LV_sql := LV_sql || '   AND A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.NUM_ABONADO = '||EN_ABONADO;
                  LV_sql := LV_sql || '   AND B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha1,LN_COD_ESTADO; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;
                                                       
                          
                   --revisamos si el historico es valido...         
                   LN_SW :=0;
                   IF LN_COD_ESTADO IS NOT NULL THEN
                       IF LN_COD_ESTADO IN (1,2,9,0,11,12) THEN
                           LN_SW := 1;  --- OK es valido
                       END IF;
                   END IF;
                                                    
                  ---buscamos el egreso
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.NUM_ABONADO = '||EN_ABONADO; 
                  LV_sql := LV_sql || '   AND A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| LV_EGS_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.NUM_ABONADO = '||EN_ABONADO;
                  LV_sql := LV_sql || '   AND B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||LV_EGS_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha2,LN_COD_ESTADO; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;
                                                  
                  
                   --revisamos si el historico es valido...      
                   LN_SW1 :=0;
                   IF LN_COD_ESTADO1 IS NOT NULL THEN
                       IF LN_COD_ESTADO IN (1,2,9,0,11,12) THEN
                           LN_SW1 := 1; --- OK es valido
                       END IF;
                   END IF;                  
                          
                   
                 --- como el  historico  de Ingeso y egreso son validos, averiguamos cual fue el ultimo movimiento...
                  IF LN_SW = 1 AND LN_SW1 = 1 THEN
                  
                      IF LV_fecha2 IS NOT NULL THEN      
                      
                        IF LV_fecha1 > LV_fecha2 THEN
                            if LN_ind_restriccion = 1 then
                           RETURN TRUE;
                               end if;
                        END IF;
                      
                      ELSE
                      
                        IF LV_fecha1 IS NOT NULL THEN  
                           RETURN TRUE;
                        END IF;
                      
                      END IF;  
                      
                 ELSE
                 
                    --- Si  el historico ya tiene un ingreso lo filtramos ...
                     IF LN_SW = 1 THEN
                        RETURN TRUE;
                     END IF;
                    
--                     IF LN_SW1 = 1 THEN
--                        DBMS_OUTPUT.PUT_LINE('10101010101010101:'||LN_SW );
--                        RETURN TRUE;                     
--                     END IF;
                      
                 END IF;
                                                     
                      
            ELSE
                  ---buscamos el ingreso
                                    
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha1,LN_COD_ESTADO; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;
                                    
                  
                   --revisamos si el historico es valido...         
                   LN_SW :=0;
                   IF LN_COD_ESTADO IS NOT NULL THEN
                       IF LN_COD_ESTADO IN (1,2,9,0,11,12) THEN
                           LN_SW := 1;  --- OK es valido
                       END IF;
                   END IF;              
                  
                  ---buscamos el egreso
                                   
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| LV_EGS_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||LV_EGS_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha2,LN_COD_ESTADO1; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;                  
                     
                  --revisamos si el historico es valido...  
                   LN_SW1 :=0;
                   IF LN_COD_ESTADO1 IS NOT NULL THEN
                       IF LN_COD_ESTADO1 IN (1,2,9,0,11,12) THEN
                           LN_SW1 := 1;  --- OK es valido
                       END IF;
                   END IF; 
                   
                --- como el  historico  de Ingeso y egreso son validos, averiguamos cual fue el eltimo movimiento...
  
                  IF LN_SW = 1 AND LN_SW1 = 1 THEN
                  
                      IF LV_fecha2 IS NOT NULL THEN      
                      
                        IF LV_fecha1 > LV_fecha2 THEN
                           RETURN TRUE;
                        END IF;
                      
                      ELSE
                      
                        IF LV_fecha1 IS NOT NULL THEN  
                           RETURN TRUE;
                        END IF;
                      
                      END IF;  
                      
                 ELSE
                 
                     --- Si en el historico ya tiene un ingreso lo filtramos ...
                     IF LN_SW = 1 THEN
                        RETURN TRUE;
                     END IF;
                    
--                     IF LN_SW1 = 1 THEN
--                        RETURN TRUE;                     
--                     END IF;
                      
                 END IF;
                 
                                    
            END IF;    
                     

               
      WHEN 'LE' THEN 
      
              --- Obtenemos el movimiento contrario al egreso...
              IF EV_COD_ACTABO = 'D2' THEN --- Egreso  Seri Lista Negra
                   LV_ING_ACTABO := 'L2';   --- IngresoSeriE Lista Negra
              ELSE
                IF EV_COD_ACTABO = 'D9' THEN --- Egreso Seri Lista Gris
                   LV_ING_ACTABO := 'L3';   --- IngresoSeriE Lista Gris
                ELSE
                   IF EV_COD_ACTABO = 'D1' THEN --- Egreso SeriE Lista Blanca
                      LV_ING_ACTABO := 'L1';   --- Ingreso Seri Lista Blanca                           
                   END IF;
                END IF;
              END IF;
              
                                        
                                  
              ---Validamos si ya existe el movimiento en icc
              ---------------------------------------------------
               BEGIN
               
                  IF EN_ABONADO IS NOT NULL AND EN_ABONADO > 0 THEN
                  
                      SELECT A.COD_ESTADO INTO LN_COD_ESTADO 
                       FROM ICC_MOVIMIENTO A
                      WHERE A.COD_ACTABO = EV_COD_ACTABO
                        AND A.IMEI          = EV_IMEI
                        AND A.NUM_ABONADO   = EN_ABONADO
                        AND A.FEC_INGRESO   = (SELECT MAX(B.FEC_INGRESO) FROM ICC_MOVIMIENTO B
                                         WHERE B.COD_ACTABO = EV_COD_ACTABO
                                           AND B.IMEI = EV_IMEI
                                           AND B.NUM_ABONADO = EN_ABONADO);  
                  ELSE
                  
                      SELECT A.COD_ESTADO INTO LN_COD_ESTADO
                       FROM ICC_MOVIMIENTO A
                      WHERE A.COD_ACTABO = EV_COD_ACTABO
                        AND A.IMEI          = EV_IMEI
                        AND A.FEC_INGRESO   = (SELECT MAX(B.FEC_INGRESO) FROM ICC_MOVIMIENTO B
                                         WHERE B.COD_ACTABO = EV_COD_ACTABO
                                           AND B.IMEI = EV_IMEI);                     
                  END IF;
                                  
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                       NULL;
               END;
               
               --ojo, solo si el registro icc es valido lo excluimos altiro...
               IF LN_COD_ESTADO IS NOT NULL THEN
                   IF LN_COD_ESTADO IN (1,2,9,0,11,12) THEN
                     RETURN TRUE;
                   END IF;
               END IF;
                              
                              
               ---- Historicos icc          
               --------------------------------------------------------
              IF EN_ABONADO IS NOT NULL AND EN_ABONADO > 0 THEN
              
                  ---buscamos el egreso
                                   
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.NUM_ABONADO = '||EN_ABONADO; 
                  LV_sql := LV_sql || '   AND A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.NUM_ABONADO = '||EN_ABONADO;
                  LV_sql := LV_sql || '   AND B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha1,LN_COD_ESTADO; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;
                                    
                   LN_SW :=0;
                   IF LN_COD_ESTADO IS NOT NULL THEN
                       IF LN_COD_ESTADO IN (1,2,9,0,11,12) THEN
                           LN_SW := 1;
                       END IF;
                   END IF;                  
                  
                  ---buscamos el ingreso
                                   
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.NUM_ABONADO = '||EN_ABONADO; 
                  LV_sql := LV_sql || '   AND A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| LV_ING_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.NUM_ABONADO = '||EN_ABONADO;
                  LV_sql := LV_sql || '   AND B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||LV_ING_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha2,LN_COD_ESTADO1; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;
                                    
                   LN_SW1 :=0;
                   IF LN_COD_ESTADO1 IS NOT NULL THEN
                       IF LN_COD_ESTADO1 IN (1,2,9,0,11,12) THEN
                           LN_SW1 := 1;
                       END IF;
                   END IF; 
                                     
                     
                --- como el  historico  de Ingeso y egreso son validos, averiguamos cual fue el eltimo movimiento...
  
                  IF LN_SW = 1 AND LN_SW1 = 1 THEN
                  
                      IF LV_fecha2 IS NOT NULL THEN      
                      
                        IF LV_fecha1 > LV_fecha2 THEN
                           RETURN TRUE;
                        END IF;
                      
                      ELSE
                      
                        IF LV_fecha1 IS NOT NULL THEN  
                           RETURN TRUE;
                        END IF;
                      
                      END IF;  
                      
                 ELSE
                 
                 -- Si en el historico ya tiene un egreso lo filtramos ...
                     IF LN_SW = 1 THEN
                        RETURN TRUE;
                     END IF;
                     
                    
--                     IF LN_SW1 = 1 THEN
--                        RETURN TRUE;                     
--                     END IF;
                      
                 END IF;
                      
            ELSE
                  ---buscamos el egreso
                                    
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||EV_COD_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha1,LN_COD_ESTADO; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;
                  
                                    
                   LN_SW :=0;
                   IF LN_COD_ESTADO IS NOT NULL THEN
                       IF LN_COD_ESTADO IN (1,2,9,0,11,12) THEN
                           LN_SW := 1;
                       END IF;
                   END IF;          
                             
                  
                  ---buscamos el ingreso
                                    
                  BEGIN
                  
                  LV_sql := 'SELECT A.FEC_INGRESO,A.COD_ESTADO ';
                  LV_sql := LV_sql || ' FROM ICC_HISTMOV'||LV_periodo||' A';
                  LV_sql := LV_sql || ' WHERE A.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND A.COD_ACTABO = '||''''|| LV_ING_ACTABO||'''';
                  LV_sql := LV_sql || '   AND A.FEC_INGRESO = (SELECT MAX(B.FEC_INGRESO) FROM ICC_HISTMOV'||LV_periodo||' B ';
                  LV_sql := LV_sql || ' WHERE B.IMEI = '||''''||EV_IMEI||'''';
                  LV_sql := LV_sql || '   AND B.COD_ACTABO = '||''''||LV_ING_ACTABO||'''';
                  LV_sql := LV_sql || ' ) ';
                  
                    EXECUTE IMMEDIATE LV_sql INTO LV_fecha2,LN_COD_ESTADO1; 
                  
                  EXCEPTION 
                   WHEN NO_DATA_FOUND THEN 
                    NULL;
                  END;
                                    
                   LN_SW1 :=0;
                   IF LN_COD_ESTADO1 IS NOT NULL THEN
                       IF LN_COD_ESTADO1 IN (1,2,9,0,11,12) THEN
                           LN_SW1 := 1;
                       END IF;
                   END IF;                   
                     
                --- como el  historico  de Ingeso y egreso son validos, averiguamos cual fue el eltimo movimiento...
  
                  IF LN_SW = 1 AND LN_SW1 = 1 THEN
                  
                      IF LV_fecha2 IS NOT NULL THEN      
                      
                        IF LV_fecha1 > LV_fecha2 THEN
                           RETURN TRUE;
                        END IF;
                      
                      ELSE
                      
                        IF LV_fecha1 IS NOT NULL THEN  
                           RETURN TRUE;
                        END IF;
                      
                      END IF;  
                      
                 ELSE
                 
                 -- Si en el historico ya tiene un egreso lo filtramos ...
                     IF LN_SW = 1 THEN
                        RETURN TRUE;
                     END IF;
                    
--                     IF LN_SW1 = 1 THEN
--                        RETURN TRUE;                     
--                     END IF;
                      
                 END IF;
                  
            END IF;    


    END CASE;
        
    RETURN FALSE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 1143;
         SV_MENS_RETORNO := 'GA_VALIDA_EXIST_ICC_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END GA_VALIDA_EXIST_ICC_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION GA_VAL_INDRESTRIC_FN (EV_IMEI               IN  icc_movimiento.IMEI%type,
                               SN_COD_ERROR       OUT NOCOPY NUMBER,
                               SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
                               SV_SQL                 OUT NOCOPY VARCHAR2
) RETURN INTEGER
IS

LN_ind_restriccion  NUMBER(1); --INC 158942 GUA JRCH 23-12-2010    
    
BEGIN

    SV_SQL:='';

   
    --------------------------------------
    --INI INC 158942 GUA JRCH 23-12-2010
    --------------------------------------    
    BEGIN
    select ind_restriccion into LN_ind_restriccion 
    from GA_LNCELU where num_Serie=EV_IMEI;
    
    IF LN_ind_restriccion = 0 THEN
      RETURN 0;
    ELSE
      RETURN 1;
    END IF;
    
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            select ind_restriccion into LN_ind_restriccion 
            from GA_HISTLNCELU where
             num_Serie=EV_IMEI
             and fec_alta in (select fec_alta from GA_HISTLNCELU 
                              where     num_Serie=EV_IMEI) ; --revisar nombre de tabla historica
            
                    
            IF LN_ind_restriccion = 1 THEN
              UPDATE     GA_HISTLNCELU
              set ind_restriccion = 0 -- para que no lo genere otra vez
              where num_Serie=EV_IMEI;
              
              RETURN 0; --genero movimiento
            ELSE
              RETURN 1; 
            END IF;            
            
     END;
     
    -- Todo Lo Posterior se debe evaluar si se comenta o no
    -- dependiendo del EGRESO
    
    --------------------------------------    
    --FIN INC 158942 GUA JRCH 23-12-2010
    --------------------------------------     
    

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 1145;
         SV_MENS_RETORNO := 'GA_VAL_INDRESTRIC_FN' ||' : '||SQLERRM;
         RETURN 1;
END GA_VAL_INDRESTRIC_FN;

end GA_INT_LISTAS_NEGRAS_PG;
/
SHOW ERRORS