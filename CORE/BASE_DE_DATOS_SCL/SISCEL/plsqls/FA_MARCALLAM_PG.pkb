CREATE OR REPLACE PACKAGE BODY Fa_Marcallam_Pg AS

/* Variables Globales */
 GV_Cod_Carg           NUMBER(5);
 GV_Tip_Unidad         VARCHAR2(5);
 GV_Factor             PLS_INTEGER;
 GV_Tip_Unidad_Factor  VARCHAR2(5);
 --
 GV_des_Auxiliar       GE_ERRORES_PG.VQUERY;   /* Sub tipo asociado a paquete de errores */
 GV_cod_Retorno        VARCHAR2(6);
 GV_msg_Retorno        VARCHAR2(100);

FUNCTION  FA_UPDATEMARCADET_FN ( EV_Cod_Marca       IN VARCHAR2,
                                 EV_Ind_Impresion   IN VARCHAR2,
                                 EN_Num_Pulso       IN NUMBER,
                                 EN_Valor_Unidad    IN NUMBER,
                                 EN_Cod_Ciclfact    IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                 EN_digito          IN NUMBER,
                                 EN_ROWID           IN ROWID)
                                RETURN BOOLEAN IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_UPDATEMARCADET_FN" Lenguaje="PL/SQL" Fecha="20-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>BOOLEAN</Retorno>
4.  <Descripción>Funcion para actualizar Tabla PF_TOLTARIFICA</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EV_Cod_Marca" Tipo="VARCHAR2">Código Marca</param>
7.  <param nom="EV_Ind_Impresion" Tipo="VARCHAR2">Indicador de Impresion</param>
7.  <param nom="EN_Num_Pulso" Tipo="NUMBER">Número de Pulso</param>
7.  <param nom="EN_Valor_Unidad" Tipo="NUMBER">Valor Unidad</param>
7.  <param nom="EN_Cod_Ciclfact" Tipo="NUMBER">Código Ciclo de Facturación</param>
7.  <param nom="EN_digito" Tipo="NUMBER">Digit</param>
7.  <param nom="EN_ROWID" Tipo="ROWID">Row Id.</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/
    LV_Query            VARCHAR2(500);
    LV_cod_marca        PF_TOLTARIFICA.cod_marca%TYPE;
    LV_ind_impresion    PF_TOLTARIFICA.ind_impresion%TYPE;
    LN_num_pulso        PF_TOLTARIFICA.num_pulso%TYPE;
    LN_valor_unidad     PF_TOLTARIFICA.mto_real%TYPE;
    LR_ROWID            ROWID;
    LB_Exito            BOOLEAN := TRUE;

    MSG_ERROR_UPDATE    VARCHAR2(60):= 'No se pudo actualizar datos';
    LV_parametros       VARCHAR2(2000);
    SN_cod_CodMegError  GE_ERRORES_TD.COD_MSGERROR%TYPE;
    SV_msg_DetMsgError  GE_ERRORES_TD.DET_MSGERROR%TYPE;
    SN_num_Evento       GE_EVENTO_DETALLE_TO.EVENTO%TYPE;

BEGIN
    BEGIN
        LV_cod_marca     := EV_Cod_Marca;
        LV_ind_impresion := EV_Ind_Impresion;
        LN_num_pulso     := EN_Num_Pulso;
        LN_valor_unidad  := EN_Valor_Unidad;
        LR_ROWID         := EN_ROWID;

        LV_Query := 'UPDATE SISCEL.PF_TOLTARIFICA_' || EN_cod_ciclfact;
        LV_Query := LV_Query || ' SET COD_MARCA = :vb_cod_marca, ';
        LV_Query := LV_Query || ' IND_IMPRESION = :vb_ind_impresion, ';
        LV_Query := LV_Query || ' NUM_PULSO = :vb_num_pulso, ';
        LV_Query := LV_Query || ' VALOR_UNIDAD = :vb_valor_unidad ';
        LV_Query := LV_Query || ' WHERE rowid   = :vb_rowid ';

        GV_des_Auxiliar := LV_Query ;

        EXECUTE IMMEDIATE LV_Query USING LV_cod_marca, LV_ind_impresion, LN_num_pulso, LN_valor_unidad, LR_ROWID;

    EXCEPTION
        WHEN OTHERS THEN
            LV_parametros := 'FA_MARCADET_PR(' || EN_cod_ciclfact || '|';
            LV_parametros := LV_parametros || EN_digito || '|)';
            GV_cod_Retorno     := '2'; --'No se pudo actualizar datos.'
            IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
                GV_msg_Retorno := MSG_ERROR_UPDATE;
            END IF;
            SN_num_Evento:=0;
            SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                         ,'FA'
                                                         ,GV_msg_Retorno
                                                         ,'1.0'
                                                         ,USER
                                                         ,'FA_UPDATEMARCADET_FN'
                                                         ,GV_des_Auxiliar
                                                         ,SQLCODE
                                                         ,LV_parametros || '-' || SQLERRM);
            LB_Exito           := FALSE;
            ROLLBACK WORK;
    END;

    RETURN LB_Exito;

END FA_UPDATEMARCADET_FN;

FUNCTION FA_TIPOLLAMADAUNIDAD_FN ( EN_Cod_Carg        IN NUMBER,
                                   EN_cod_ciclfact    IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                   EN_digito          IN NUMBER)
                                  RETURN VARCHAR2 IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_TIPOLLAMADAUNIDAD_FN" Lenguaje="PL/SQL" Fecha="06-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>VARCHAR2</Retorno>
4.  <Descripción>Funcion para recuperar Tipo Unidad</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_Cod_Carg" Tipo="NUMBER">Código Concepto</param>
7.  <param nom="EN_cod_ciclfact" Tipo="NUMBER">Código Ciclo Facturación</param>
7.  <param nom="EN_digito" Tipo="NUMBER">Dígito</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/
--
    LV_Tip_Unidad             VARCHAR(5):= '';

    MSG_ERROR_UPDATE          VARCHAR2(60):= 'No se pudo recuperar datos';
    LV_parametros             VARCHAR2(2000);
    SN_cod_CodMegError        GE_ERRORES_TD.COD_MSGERROR%TYPE;
    SV_msg_DetMsgError        GE_ERRORES_TD.DET_MSGERROR%TYPE;
    SN_num_Evento             GE_EVENTO_DETALLE_TO.EVENTO%TYPE :=0;
--
BEGIN

    IF (GV_Cod_Carg != EN_Cod_Carg) THEN

        GV_des_Auxiliar := 'SELECT G.TIP_UNIDAD FROM  FAD_IMPCONCEPTOS C, ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' FAD_IMPSUBGRUPOS S, ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' FAD_IMPGRUPOS G ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' WHERE C.COD_CONCEPTO = ' || En_Cod_Carg;
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   C.COD_SUBGRUPO = S.COD_SUBGRUPO ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   S.COD_GRUPO    = G.COD_GRUPO ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   EXISTS (SELECT 1 FROM FAD_PARAMETROS P ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' WHERE P.COD_MODULO = ' ||''''||'FA'||''''||'';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   P.COD_PARAMETRO = 12 ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   P.VAL_NUMERICO = G.COD_FORMULARIO) ';

        BEGIN
            SELECT G.TIP_UNIDAD
              INTO LV_Tip_Unidad
              FROM FAD_IMPCONCEPTOS C,
                   FAD_IMPSUBGRUPOS S,
                   FAD_IMPGRUPOS G
             WHERE C.COD_CONCEPTO = En_Cod_Carg
               AND C.COD_SUBGRUPO = S.COD_SUBGRUPO
               AND S.COD_GRUPO    = G.COD_GRUPO
               AND EXISTS (SELECT 1
                             FROM FAD_PARAMETROS P
                            WHERE P.COD_MODULO    = 'FA'
                              AND P.COD_PARAMETRO = 12
                              AND P.VAL_NUMERICO  = G.COD_FORMULARIO);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                GV_Cod_Carg   := EN_Cod_Carg;
                GV_Tip_Unidad := LV_Tip_Unidad;
                LV_parametros := 'FA_MARCADET_PR(' || EN_cod_ciclfact || '|';
                LV_parametros := LV_parametros || EN_digito || '|)';

                GV_cod_Retorno     := '1'; --'No se pudo recuperar datos'
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
                    GV_msg_Retorno := MSG_ERROR_UPDATE;
                END IF;
                SN_num_Evento :=0;
                SN_num_Evento := Ge_Errores_Pg.Grabarpl( SN_num_Evento
                                                        , 'FA'
                                                        , GV_msg_Retorno
                                                        , '1.0'
                                                        , USER
                                                        , 'FA_TIPOLLAMADAUNIDAD_FN'
                                                        , GV_des_Auxiliar
                                                        , SQLCODE
                                                        , LV_parametros || '-' || SQLERRM);

               LV_Tip_Unidad := 'NK';
               RETURN LV_Tip_Unidad;
       END;

       GV_Cod_Carg   := EN_Cod_Carg;
       GV_Tip_Unidad := LV_Tip_Unidad;

    END IF;

    RETURN GV_Tip_Unidad;

END FA_TIPOLLAMADAUNIDAD_FN;

FUNCTION FA_GETFACTOR_FN ( EV_Tip_Unidad IN VARCHAR2 ) RETURN NUMBER IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_GETFACTOR_FN" Lenguaje="PL/SQL" Fecha="06-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>Funcion recuperar factor de conversion</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EV_Tip_Unidad" Tipo="VARCHAR2">Tipo Unidad</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

    LN_factor PLS_INTEGER := 1;

BEGIN

    IF (GV_Tip_Unidad_factor != EV_Tip_Unidad) THEN
        BEGIN
          SELECT TO_NUMBER(DESCRIPCION_VALOR)
            INTO LN_factor
            FROM FA_FACTOR_TIPO_UNIDAD_VW
           WHERE TRIM(VALOR) = TRIM(EV_Tip_Unidad);

        END;

        GV_Factor            := LN_Factor;
        GV_Tip_Unidad_factor := EV_Tip_Unidad;

    END IF;

    RETURN GV_Factor;

END FA_GETFACTOR_FN;

FUNCTION FA_CALCPULSO_FN ( EN_Dur_Real IN NUMBER,
                           EN_factor IN NUMBER)
                          RETURN NUMBER IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_CALCPULSO_FN" Lenguaje="PL/SQL" Fecha="06-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>Funcion para calculo de pulso</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_Dur_Real" Tipo="NUMBER">Duración real llamada</param>
8.  <param nom="EN_factor" Tipo="NUMBER">Factor de conversión</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

    LN_pulso     NUMBER := 0;

BEGIN

    IF (EN_Dur_Real > 0) AND (EN_factor > 0) THEN
        LN_pulso := CEIL(EN_Dur_Real / EN_factor);
    END IF;

    RETURN LN_pulso;

END FA_CALCPULSO_FN;

FUNCTION FA_CALCVALORUNIDAD_FN ( EN_mto_real IN NUMBER,
                                 EN_num_pulso IN NUMBER)
                               RETURN NUMBER IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_CALCVALORUNIDAD_FN" Lenguaje="PL/SQL" Fecha="26-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>Funcion para calculo de valor unidad</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_mto_real" Tipo="NUMBER">Monto real</param>
7.  <param nom="EN_num_pulso" Tipo="NUMBER">Número pulso</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

    LN_valor_unidad          PF_TOLTARIFICA.mto_real%TYPE;

BEGIN

    LN_valor_unidad := 0;

    IF (EN_mto_real > 0) AND (EN_num_pulso > 0) THEN
        LN_valor_unidad := EN_mto_real / EN_num_pulso;
    END IF;

    RETURN LN_valor_unidad;

END FA_CALCVALORUNIDAD_FN;

--===================================================================================================

PROCEDURE FA_MARCADET_PR ( EN_cod_ciclfact    IN FA_CICLFACT.COD_CICLFACT%TYPE,
                           EN_digito          IN NUMBER,
                           SN_cod_CodMegError OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                           SV_msg_DetMsgError OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                           SN_num_Evento      OUT NOCOPY GE_EVENTO_DETALLE_TO.EVENTO%TYPE)
IS
/*
1.  <Nombre del procedimiento= "FA_MARCADET_PR" Lenguaje="PL/SQL" Fecha="30-11-2005" Versión="1" >
2.  <Llamada =  Desde programa Loadtarif.pc>
3.  <Retorno = SN_cod_CodMegError  ; SV_msg_DetMsgError  ; SN_num_Evento>
4.  <Descripción>funcion para actualizar PF_TOLTARIFICA en los campos COD_MARCA e IND_IMPRESION>
5.  <Parámetros entrada= Cod_ciclo y ultimo digito de numero de cliente >
    < EN_cod_ciclfact       IN FA_CICLFACT.COD_CICLFACT%TYPE>
    < EN_digito             IN NUMBER>
*/
    LN_CONTADOR              PLS_INTEGER;
    LN_CANTIDAD              PLS_INTEGER;
    LN_CONTA_CURSOR          PLS_INTEGER;

    LB_si_direccion          CHAR(1) :='N';
    LB_si_subfranja1         CHAR(1) :='N';
    LB_si_subfranja2         CHAR(1) :='N';
    LV_cod_marca             PF_TOLTARIFICA.cod_marca%TYPE;
    LV_ind_impresion         PF_TOLTARIFICA.ind_impresion%TYPE;
    LN_num_pulso             PF_TOLTARIFICA.num_pulso%TYPE;
    LN_valor_unidad          PF_TOLTARIFICA.mto_real%TYPE;
    LN_mto_real              PF_TOLTARIFICA.mto_real%TYPE;
    LV_valor_generico        PF_TOLTARIFICA.cod_tdir%TYPE;

    SIN_PROMOCION            EXCEPTION;
    SIN_MINUTOS_LIBRES       EXCEPTION;
    SIN_DOMINIOS             EXCEPTION;
    SIN_DIRECCION            EXCEPTION;
    SIN_SUBFRANJA2           EXCEPTION;
    SIN_SUBFRANJA1           EXCEPTION;
    ERROR_PROCEDURE          EXCEPTION;

    MSG_ERROR_NOCLASIF         VARCHAR2(50):= 'No es posible clasificar el error';
    MSG_ERROR_PROCEDURE        VARCHAR2(50):= 'Falla controlada en procedure.';
    LV_parametros              VARCHAR2(2000);

    LV_Query                   VARCHAR2(2000):= '';
    LN_id_Select_pftoltarif    INTEGER;
    LR_ROWID                   ROWID;
    LV_toltarif_tipdcto        VARCHAR(5);
    LV_toltarif_coddcto        VARCHAR(5);
    LV_toltarif_codsubfranja   VARCHAR(5);
    LV_toltarif_codtdir        VARCHAR(5);
    LN_toltarif_codcarg        PLS_INTEGER;
    LN_toltarif_durreal        PLS_INTEGER;
    LV_toltarif_codmarcamp     VARCHAR2(6);
    LV_toltarif_indimpresionmp VARCHAR2(2);
    LV_toltarif_codmarcam      VARCHAR2(6);
    LV_toltarif_indimpresionm  VARCHAR2(2);
    LN_toltarif_mtoreal        PF_TOLTARIFICA.mto_real%TYPE;

    LB_Exito                   BOOLEAN;
    LV_tip_unidad              FAD_IMPGRUPOS.tip_unidad%TYPE;
    LN_factor                  PLS_INTEGER;

    fdbk                       INTEGER;

BEGIN

    GV_Cod_Carg                :=0;
    GV_Tip_Unidad              :='99';
    GV_Factor                  :=1;
    GV_Tip_Unidad_Factor       :='99';

    LN_CONTADOR                :=0;
    LN_CONTA_CURSOR            :=0;

    LV_parametros := 'FA_MARCADET_PR(' || EN_cod_ciclfact || '|';
    LV_parametros := LV_parametros || EN_digito || '|)';

    SN_cod_CodMegError         :=0;
    SV_msg_DetMsgError         :='';
    SN_num_Evento              :=0;

    GV_des_Auxiliar            :='';

    LV_Query := 'SELECT /*+ FULL (T) PARALLEL (T,10) */';
    LV_Query := LV_Query || ' T.ROWID, ';
    LV_Query := LV_Query || ' T.TIP_DCTO, ';
    LV_Query := LV_Query || ' T.COD_DCTO, ';
    LV_Query := LV_Query || ' T.COD_SUBFRANJA, ';
    LV_Query := LV_Query || ' T.COD_TDIR, ';
    LV_Query := LV_Query || ' T.COD_CARG, ';
    LV_Query := LV_Query || ' T.DUR_REAL, ';
    LV_Query := LV_Query || ' NVL(MP.COD_MARCA,'||''''||'SM'||''''||') AS COD_MARCAMP, ';
    LV_Query := LV_Query || ' NVL(MP.IND_IMPRESION,'||''''||'SI'||''''||') AS IND_IMPRESIONMP, ';
    LV_Query := LV_Query || ' NVL(M.COD_MARCA,'||''''||'SM'||''''||') AS COD_MARCAM, ';
    LV_Query := LV_Query || ' NVL(M.IND_IMPRESION,'||''''||'SI'||''''||') AS IND_IMPRESIONM, ';
    LV_Query := LV_Query || ' T.MTO_REAL ';
    LV_Query := LV_Query || ' FROM SISCEL.PF_TOLTARIFICA_'|| EN_cod_ciclfact || ' T, ';
    LV_Query := LV_Query || '      (SELECT COD_MARCA,IND_IMPRESION,COD_PROMO ';
    LV_Query := LV_Query || '       FROM FA_MARCAPROMO_TD WHERE TIP_MARCA = '||''''||'PR'||''''||') MP, ';
    LV_Query := LV_Query || '      (SELECT COD_MARCA,IND_IMPRESION,TIP_MARCA ';
    LV_Query := LV_Query || '       FROM FA_MARCA_TD WHERE TIP_MARCA = '||''''||'ML'||''''||'';
    lv_query := LV_Query || '       AND ROWNUM < 2) M ';
    LV_Query := LV_Query || ' WHERE T.NUM_CLIE > 0 ';
    LV_Query := LV_Query || ' AND T.NUM_ABON > 0 ';
    LV_Query := LV_Query || ' AND T.COD_CICLFACT = '|| EN_cod_ciclfact ;
    LV_Query := LV_Query || ' AND T.COD_DCTO = MP.COD_PROMO(+) ';
    LV_Query := lv_Query || ' AND T.TIP_DCTO = M.TIP_MARCA(+) ';

    GV_des_Auxiliar := LV_Query;

    LN_id_Select_pftoltarif := DBMS_SQL.OPEN_CURSOR;

    DBMS_SQL.PARSE(LN_id_Select_pftoltarif, LV_Query, dbms_sql.NATIVE);
    DBMS_SQL.DEFINE_COLUMN_ROWID(LN_id_Select_pftoltarif, 1, LR_ROWID);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 2,  LV_toltarif_tipdcto,5);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 3,  LV_toltarif_coddcto,5);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 4,  LV_toltarif_codsubfranja,5);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 5,  LV_toltarif_codtdir,5);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 6,  LN_toltarif_codcarg);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 7,  LN_toltarif_durreal);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 8,  LV_toltarif_codmarcamp,6);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 9,  LV_toltarif_indimpresionmp,2);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 10,  LV_toltarif_codmarcam,6);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 11,  LV_toltarif_indimpresionm,2);
    DBMS_SQL.DEFINE_COLUMN(LN_id_Select_pftoltarif, 12,  LN_toltarif_mtoreal);

    fdbk := DBMS_SQL.EXECUTE (LN_id_Select_pftoltarif);

    LOOP
        EXIT WHEN DBMS_SQL.FETCH_ROWS (LN_id_Select_pftoltarif)= 0 ;

        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 1,  LR_ROWID);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 2,  LV_toltarif_tipdcto);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 3,  LV_toltarif_coddcto);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 4,  LV_toltarif_codsubfranja);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 5,  LV_toltarif_codtdir);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 6,  LN_toltarif_codcarg);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 7,  LN_toltarif_durreal);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 8,  LV_toltarif_codmarcamp);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 9,  LV_toltarif_indimpresionmp);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 10,  LV_toltarif_codmarcam);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 11,  LV_toltarif_indimpresionm);
        DBMS_SQL.COLUMN_VALUE(LN_id_Select_pftoltarif, 12,  LN_toltarif_mtoreal);

        LB_si_subfranja1 :='N';
        LB_si_subfranja2 :='N';
        LB_si_direccion  :='N';

        LV_cod_marca     :='';
        LV_ind_impresion :='';
        LN_num_pulso     :=0;
        LN_valor_unidad  :=0;
        LV_valor_generico:='';

        LN_CONTA_CURSOR  := LN_CONTA_CURSOR + 1;

        IF LTRIM(RTRIM(LV_toltarif_tipdcto)) = 'PR' THEN
            LV_cod_marca     := LV_toltarif_codmarcamp;
            LV_ind_impresion := LV_toltarif_indimpresionmp;

        ELSE
            IF LTRIM(RTRIM(LV_toltarif_tipdcto)) = 'ML' THEN
                LV_cod_marca     := LV_toltarif_codmarcam;
                LV_ind_impresion := LV_toltarif_indimpresionm;

            ELSE
                GV_des_Auxiliar := 'SELECT COUNT(1) FROM FA_DIRECCION_LLAMADA_VW';
                GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(VALOR)) = ' || RTRIM(LTRIM(LV_toltarif_codsubfranja));

                LN_CANTIDAD     := 0;

                SELECT COUNT(1)
                INTO  LN_CANTIDAD
                FROM  FA_DIRECCION_LLAMADA_VW
                WHERE RTRIM(LTRIM(VALOR)) = RTRIM(LTRIM(LV_toltarif_codtdir));

                LB_si_direccion :='S';

                IF (LN_CANTIDAD = 0) THEN
                    GV_des_Auxiliar := 'SELECT COUNT(1) FROM  FA_SUBFRANJA_1_VW';
                    GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(VALOR)) = ' || RTRIM(LTRIM(LV_toltarif_codsubfranja));

                    LN_CANTIDAD     := 0;

                    SELECT COUNT(1)
                    INTO  LN_CANTIDAD
                    FROM  FA_SUBFRANJA_1_VW
                    WHERE RTRIM(LTRIM(VALOR)) = RTRIM(LTRIM(LV_toltarif_codsubfranja));

                    LB_si_subfranja1 :='S';

                    IF (LN_CANTIDAD = 0) THEN
                        GV_des_Auxiliar := 'SELECT SELECT COUNT(1 FROM FA_SUBFRANJA_2_VW ';
                        GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(VALOR)) = ' || RTRIM(LTRIM(LV_toltarif_codsubfranja));

                        LN_CANTIDAD     := 0;

                        SELECT COUNT(1)
                        INTO  LN_CANTIDAD
                        FROM  FA_SUBFRANJA_2_VW
                        WHERE RTRIM(LTRIM(VALOR)) = RTRIM(LTRIM(LV_toltarif_codsubfranja));

                        LB_si_subfranja2 :='S';

                        IF (LN_CANTIDAD = 0) THEN
                            GV_cod_Retorno := '600'; --'No se cumple ninguna condicion '
                            IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
                                GV_msg_Retorno := MSG_ERROR_NOCLASIF;
                            END IF;
                            SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                                        ,'FA'
                                                                        ,GV_msg_Retorno
                                                                        ,'1.0'
                                                                        ,USER
                                                                        ,'FA_MARCADET_PR'
                                                                        ,GV_des_Auxiliar
                                                                        ,SQLCODE
                                                                        ,LV_parametros || '-' || SQLERRM);
                            LB_si_subfranja1 :='N';
                            LB_si_subfranja2 :='N';
                            LB_si_direccion  :='N';
                        END IF;
                    END IF;
                END IF;

                IF LB_si_direccion ='S'      THEN
                    LV_valor_generico := LV_toltarif_codtdir;
                ELSIF (LB_si_subfranja1 ='S' OR LB_si_subfranja2 ='S') THEN
                    LV_valor_generico := LV_toltarif_codsubfranja;
                END IF;

                IF (LB_si_direccion ='S' OR LB_si_subfranja1 ='S' OR LB_si_subfranja2 ='S') THEN
                    GV_des_Auxiliar := 'SELECT COD_MARCA, IND_IMPRESION  ';
                    GV_des_Auxiliar := GV_des_Auxiliar || 'FROM FA_MARCA_TD ';
                    GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(TIP_MARCA)) = ' || RTRIM(LTRIM(LV_valor_generico));
                    GV_des_Auxiliar := GV_des_Auxiliar || ' AND rownum < 2';
                    BEGIN
                        SELECT COD_MARCA, IND_IMPRESION
                        INTO LV_cod_marca, LV_ind_impresion
                        FROM FA_MARCA_TD
                        WHERE RTRIM(LTRIM(TIP_MARCA)) = RTRIM(LTRIM(LV_valor_generico))
                          AND ROWNUM < 2;
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                             NULL;
                    END;
                END IF;
            END IF;
        END IF;

        /* Recuperacion Tipo de Unidad */
        LV_tip_unidad   := FA_TIPOLLAMADAUNIDAD_FN(LN_toltarif_codcarg, EN_cod_ciclfact,EN_digito);

        /* Si Tipo de Unidad no Existe entonces ERROR */
        IF LV_tip_unidad = 'NK' THEN
           RAISE ERROR_PROCEDURE;
        END IF;

        /* Recuperacion Factor con Tipo de Unidad */
        LN_factor       := FA_GETFACTOR_FN(LV_tip_unidad);

        /* Calculo de Numero de Pulso */
        LN_num_pulso    := FA_CALCPULSO_FN(LN_toltarif_durreal,LN_factor);

        /* Calculo de Valor Unidad */
        LN_valor_unidad := FA_CALCVALORUNIDAD_FN(LN_toltarif_mtoreal,LN_num_pulso);

        /* Actualizacion de Tabla PF_TOLTARIFICA con valores leídos y calculados */
        LB_Exito := FA_UPDATEMARCADET_FN(LV_cod_marca, LV_ind_impresion,
                                         LN_num_pulso, LN_valor_unidad,
                                         EN_cod_ciclfact, EN_digito, LR_ROWID);
        IF LB_Exito THEN
           LN_CONTADOR := LN_CONTADOR + 1;
        ELSE
           RAISE ERROR_PROCEDURE;
        END IF;

        IF MOD(LN_CONTADOR,1000)= 0 THEN
           COMMIT WORK;
        END IF;
    END LOOP;

    DBMS_SQL.CLOSE_CURSOR(LN_id_Select_pftoltarif);

    GV_des_Auxiliar := 'COMMIT WORK';
    COMMIT WORK;

    SV_msg_DetMsgError :='';
    SV_msg_DetMsgError := ' Leidos en cursor :  ' || LN_CONTA_CURSOR || '  ***Actualizados : ' || LN_CONTADOR ;

    EXCEPTION
      WHEN SIN_PROMOCION THEN
        GV_cod_Retorno := '595'; --'No existen datos en tabla FA_MARCAPROMO_TD'
        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
           GV_msg_Retorno := MSG_ERROR_NOCLASIF;
        END IF;
        SN_num_Evento      := 0;
        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                     ,'FA'
                                                     ,GV_msg_Retorno
                                                     ,'1.0'
                                                     ,USER
                                                     ,'FA_MARCADET_PR'
                                                     ,GV_des_Auxiliar
                                                     ,SQLCODE
                                                     ,LV_parametros || '-' || SQLERRM);
        SV_msg_DetMsgError := GV_msg_Retorno;
        SN_cod_CodMegError := GV_cod_Retorno;
        ROLLBACK WORK;

      WHEN SIN_MINUTOS_LIBRES THEN
        GV_cod_Retorno := '596'; --'No existe datos en tabla FA_MARCA_TD '
        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
           GV_msg_Retorno := MSG_ERROR_NOCLASIF;
        END IF;
        SN_num_Evento      := 0;
        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                     ,'FA'
                                                     ,GV_msg_Retorno
                                                     ,'1.0'
                                                     ,USER
                                                     ,'FA_MARCADET_PR'
                                                     ,GV_des_Auxiliar
                                                     ,SQLCODE
                                                     ,LV_parametros || '-' || SQLERRM);
        SV_msg_DetMsgError := GV_msg_Retorno;
        SN_cod_CodMegError := GV_cod_Retorno;
        ROLLBACK WORK;

      WHEN SIN_DIRECCION THEN
        GV_cod_Retorno := '597'; --'No existen datos en tabla FA_MARCA_TD'
        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
           GV_msg_Retorno := MSG_ERROR_NOCLASIF;
        END IF;
        SN_num_Evento      := 0;
        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                     ,'FA'
                                                     ,GV_msg_Retorno
                                                     ,'1.0'
                                                     ,USER
                                                     ,'FA_MARCADET_PR'
                                                     ,GV_des_Auxiliar
                                                     ,SQLCODE
                                                     ,LV_parametros || '-' || SQLERRM);
        SV_msg_DetMsgError := GV_msg_Retorno;
        SN_cod_CodMegError := GV_cod_Retorno;
        ROLLBACK WORK;

      WHEN SIN_SUBFRANJA1 THEN
        GV_cod_Retorno := '598'; --'No existen datos en tabla FA_MARCA_TD'
        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
           GV_msg_Retorno := MSG_ERROR_NOCLASIF;
        END IF;
        SN_num_Evento      := 0;
        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                     ,'FA'
                                                     ,GV_msg_Retorno
                                                     ,'1.0'
                                                     ,USER
                                                     ,'FA_MARCADET_PR'
                                                     ,GV_des_Auxiliar
                                                     ,SQLCODE
                                                     ,LV_parametros || '-' || SQLERRM);
        SV_msg_DetMsgError := GV_msg_Retorno;
        SN_cod_CodMegError := GV_cod_Retorno;
        ROLLBACK WORK;

      WHEN SIN_SUBFRANJA2 THEN
        GV_cod_Retorno := '599'; --'No existen datos en tabla FA_MARCA_TD'
        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
           GV_msg_Retorno := MSG_ERROR_NOCLASIF;
        END IF;
        SN_num_Evento      := 0;
        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                     ,'FA'
                                                     ,GV_msg_Retorno
                                                     ,'1.0'
                                                     ,USER
                                                     ,'FA_MARCADET_PR'
                                                     ,GV_des_Auxiliar
                                                     ,SQLCODE
                                                     ,LV_parametros || '-' || SQLERRM);
        SV_msg_DetMsgError := GV_msg_Retorno;
        SN_cod_CodMegError := GV_cod_Retorno;
        ROLLBACK WORK;

      WHEN ERROR_PROCEDURE THEN
        GV_cod_Retorno := '2'; --'No se pudo Actualizar datos'
        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
           GV_msg_Retorno := MSG_ERROR_PROCEDURE;
        END IF;
        SN_num_Evento      := 0;
        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                    ,'FA'
                                                    ,GV_msg_Retorno
                                                    ,'1.0'
                                                    ,USER
                                                    ,'FA_MARCADET_PR'
                                                    ,GV_des_Auxiliar
                                                    ,SQLCODE
                                                    ,LV_parametros || '-' || SQLERRM);
        SV_msg_DetMsgError := GV_msg_Retorno;
        SN_cod_CodMegError := GV_cod_Retorno;
        ROLLBACK WORK;

      WHEN OTHERS THEN
        GV_cod_Retorno := '602'; --'Falla no controlada en FA_MARCADET_PR'
        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
           GV_msg_Retorno := MSG_ERROR_NOCLASIF;
        END IF;
        SN_num_Evento      := 0;
        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                    ,'FA'
                                                    ,GV_msg_Retorno
                                                    ,'1.0'
                                                    ,USER
                                                    ,'FA_MARCADET_PR'
                                                    ,GV_des_Auxiliar
                                                    ,SQLCODE
                                                    ,LV_parametros || '-' || SQLERRM);
        SV_msg_DetMsgError := GV_msg_Retorno;
        SN_cod_CodMegError := GV_cod_Retorno;
        ROLLBACK WORK;

END FA_MARCADET_PR;

END Fa_Marcallam_Pg;
/
SHOW ERRORS
