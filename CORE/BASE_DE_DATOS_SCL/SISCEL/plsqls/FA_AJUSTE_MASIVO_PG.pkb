CREATE OR REPLACE PACKAGE BODY FA_AJUSTE_MASIVO_PG AS
/* ************************************************************************* */
/*                              Items privados                                   */
/* ************************************************************************* */

/* ESTRUCTURAS PARA LOS DOCUMENTOS DE LA SOLICITUD DE AJUSTES MASIVO */
TYPE T_AJUSTES IS RECORD (r_rowid                ROWID,
                          r_proceso              FA_AJUSTES_TO.PROCESO%TYPE,
                          r_ind_tipdocum         FA_AJUSTES_TO.IND_TIPDOCUM%TYPE,
                          r_cod_operadora        FA_AJUSTES_TO.COD_OPERADORA%TYPE,
                          r_pref_folio           FA_AJUSTES_TO.PREF_FOLIO%TYPE,
                          r_num_folio            FA_AJUSTES_TO.NUM_FOLIO %TYPE,
                          r_cod_cliente          FA_AJUSTES_TO.COD_CLIENTE%TYPE,
                          r_tot_docum            FA_AJUSTES_TO.TOT_DOCUM%TYPE,
                          r_estado               FA_AJUSTES_TO.ESTADO%TYPE,
                          r_num_proceso          FA_AJUSTES_TO.NUM_PROCESO%TYPE,
                          r_fec_vencimie         FA_AJUSTES_TO.FEC_VENCIMIE%TYPE,
                          r_usuario              FA_AJUSTES_TO.USUARIO%TYPE,
                          r_obs_estado           FA_AJUSTES_TO.OBS_ESTADO%TYPE,
                          r_cod_tipologia        FA_AJUSTES_TO.COD_TIPOLOGIA%TYPE,
                          r_cod_areaimputable    FA_AJUSTES_TO.COD_AREAIMPUTABLE%TYPE,
                          r_cod_areasolicitantes FA_AJUSTES_TO.COD_AREASOLICITANTE%TYPE);

TYPE TIPTABAJUSTES IS TABLE OF T_AJUSTES INDEX BY BINARY_INTEGER;

TabAjustes TIPTABAJUSTES;

/* ESTRUCTURA PARA LOS CONCEPTOS DE LA SOLICITUD DE AJUSTES MASIVO */
TYPE T_CONCAJUSTES IS RECORD (r_rowid         ROWID,
                              r_cod_concepto  FA_DETAJUSTES_TO.COD_CONCEPTO%TYPE,
                              r_cod_columna   FA_DETAJUSTES_TO.COD_COLUMNA%TYPE,
                              r_num_abonado   FA_DETAJUSTES_TO.NUM_ABONADO%TYPE,
                              r_monto_dinero  FA_DETAJUSTES_TO.MONTO_DINERO%TYPE,
                              r_monto_porcen  FA_DETAJUSTES_TO.MONTO_PORCEN%TYPE,
                              r_ide_tipmonto  FA_DETAJUSTES_TO.IDE_TIPMONTO%TYPE,
                              r_cod_tecno     FA_DETAJUSTES_TO.COD_TECNO%TYPE,
                              r_ind_activo    FA_CONCEPTOS.IND_ACTIVO%TYPE);

TYPE TIPTABCONCAJUSTES IS TABLE OF T_CONCAJUSTES INDEX BY BINARY_INTEGER;

TabConcAjustes TIPTABCONCAJUSTES;

j               PLS_INTEGER;
vg_Modulo       VARCHAR2(60);
vg_FormatoFecha GED_PARAMETROS.VAL_PARAMETRO%TYPE;


/* ESTRUCTURA PARA NUEVOS LOS CONCEPTOS (DESCUENTOS LIQUIDADOS) */
TYPE T_CONCDESCTOS IS RECORD (r_cod_concepto  FA_FACTCONC_NOCICLO.COD_CONCEPTO%TYPE,
                              r_cod_columna   FA_FACTCONC_NOCICLO.COLUMNA%TYPE,
                              r_imp_factura   FA_FACTCONC_NOCICLO.IMP_FACTURABLE%TYPE,
                              r_fec_valor     FA_FACTCONC_NOCICLO.FEC_VALOR%TYPE);

TYPE TIPTABCONCDESCTOS IS TABLE OF T_CONCDESCTOS INDEX BY BINARY_INTEGER;

TYPE TipoCursor IS REF CURSOR;

szhPathDir           FAD_PARAMETROS.VAL_CARACTER%TYPE;
sControlPath         VARCHAR2(1);
szhNombArchLog       VARCHAR2(128);
szhModoOpen          VARCHAR2(1);
fh                   utl_file.FILE_TYPE ;


/* ************************************************************************* */
/*                              CURSORES                                     */
/* ************************************************************************* */
CURSOR C_AJUSTES (v_ideajuste PLS_INTEGER, v_estado PLS_INTEGER)
IS
    SELECT ROWID
         , PROCESO
         , IND_TIPDOCUM
         , COD_OPERADORA
         , PREF_FOLIO
         , NUM_FOLIO
         , COD_CLIENTE
         , TOT_DOCUM
         , NVL(ESTADO,0)
         , NUM_PROCESO
         , FEC_VENCIMIE
         , USUARIO
         , 'OK'
         , COD_TIPOLOGIA
         , COD_AREAIMPUTABLE
         , COD_AREASOLICITANTE
    FROM FA_AJUSTES_TO
    WHERE IDE_AJUSTE = v_ideajuste
      AND ESTADO = v_estado;

CURSOR C_CONCAJUSTES (v_proceso PLS_INTEGER)
IS
    SELECT A.ROWID
         , A.COD_CONCEPTO
         , A.COD_COLUMNA
         , A.NUM_ABONADO
         , A.MONTO_DINERO
         , A.MONTO_PORCEN
         , A.IDE_TIPMONTO
         , A.COD_TECNO
         , B.IND_ACTIVO
    FROM FA_DETAJUSTES_TO A, FA_CONCEPTOS B
    WHERE PROCESO = v_proceso
      AND A.COD_CONCEPTO = B.COD_CONCEPTO;


/* ************************************************************************* */
/* ************************************************************************* */
/*                              FUNCIONES PRIVADAS                               */
/* ************************************************************************* */
/* ************************************************************************* */

/* ************************************************************************* */
/*       : Lee los registros de los documentos a ajustar                                 */
/* ************************************************************************* */
FUNCTION fLeeAjustes( vp_id_ajuste IN PLS_INTEGER
                                        , p_TabAjustes OUT TIPTABAJUSTES
                                        , vp_estado        IN PLS_INTEGER
) RETURN BOOLEAN IS

X                       PLS_INTEGER;
BEGIN
        vg_Modulo       := 'fLeeAjustes';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||'] Ide.Ajuste : ['||vp_id_ajuste||']  Estado : ['||vp_estado||']');
        p_TabAjustes.DELETE;
        X := 1;
        FOR Cur_Ajustes IN C_AJUSTES(vp_id_ajuste, vp_estado) LOOP
        p_TabAjustes(X):= Cur_Ajustes;
                X:=X +1;
    END LOOP;

        RETURN TRUE;
EXCEPTION
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM1 : ['||SQLERRM||']');
                RETURN FALSE;

END;

/* ************************************************************************* */
/* fLeeDetAjustes : Lee registros de detalle de los documentos a ajustar         */
/* ************************************************************************* */
FUNCTION fLeeDetAjustes( vp_proceso IN PLS_INTEGER
                                                , p_TabConcAjustes OUT TIPTABCONCAJUSTES
) RETURN BOOLEAN IS

X                       PLS_INTEGER;

BEGIN
        vg_Modulo       := 'fLeeDetAjustes';
        utl_file.Put_Line(fh,'Modulo :['||vg_Modulo||'] Proceso :['||vp_proceso||']');

        p_TabConcAjustes.DELETE;
        X := 1;
        FOR Cur_Ajustes IN C_CONCAJUSTES(vp_proceso) LOOP
        p_TabConcAjustes(X):= Cur_Ajustes;
                X:=X +1;
    END LOOP;

        RETURN TRUE;
EXCEPTION
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;

END;

/* ************************************************************************* */
/* fConsultaConcOrigen : Lee conc. originales desde el documento origional       */
/* ************************************************************************* */
FUNCTION fConsultaConcOrigen (p_TabConcAjustes  IN OUT T_CONCAJUSTES
                                                        , VP_NOMTABLACONC       IN VARCHAR2
                                                        , VP_INDORDENTOTAL      IN PLS_INTEGER
                                                        , VP_TOTFACTURABLE  OUT NUMBER
                                                        , VP_TOTSALDO           OUT NUMBER
) RETURN BOOLEAN IS

v_StrSql_1      varchar2(1000);
v_StrSql_2      varchar2(1000);
v_TotFacturable NUMBER;
v_TotDesc               NUMBER;
v_Columna               PLS_INTEGER;
v_NumAbonado    PLS_INTEGER;
BEGIN
        vg_Modulo               := 'fConsultaConcOrigen';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

--        v_StrSql_1 := 'SELECT COLUMNA, NUM_ABONADO, IMP_CONCEPTO ';
        v_StrSql_1 := 'SELECT COLUMNA, NUM_ABONADO, IMP_FACTURABLE ';  -- PGG - 192820 - 4-04-2013
        v_StrSql_1 := v_StrSql_1 ||' FROM '||VP_NOMTABLACONC;
        v_StrSql_1 := v_StrSql_1 ||' WHERE IND_ORDENTOTAL = :indordentotal ';
        v_StrSql_1 := v_StrSql_1 ||'AND COD_TIPCONCE = 3 '; /* CARGO */
        v_StrSql_1 := v_StrSql_1 ||'AND COD_CONCEPTO = :codconcepto ' ;

        IF p_TabConcAjustes.r_cod_columna IS NOT NULL THEN
                v_StrSql_1 := v_StrSql_1 ||'AND COLUMNA = :columna ' ;
                utl_file.Put_Line(fh,'v_StrSql_1 : ['||v_StrSql_1||']');
                EXECUTE IMMEDIATE v_StrSql_1
                INTO v_Columna, v_NumAbonado, v_TotFacturable
                USING  VP_INDORDENTOTAL
                         , p_TabConcAjustes.r_cod_concepto
                         , p_TabConcAjustes.r_cod_columna;

        ELSE
                IF p_TabConcAjustes.r_num_abonado IS NOT NULL THEN
                        v_StrSql_1 := v_StrSql_1 ||'AND NUM_ABONADO = :numabonado ' ;

                        EXECUTE IMMEDIATE v_StrSql_1
                        INTO v_Columna, v_NumAbonado, v_TotFacturable
                        USING  VP_INDORDENTOTAL
                                 , p_TabConcAjustes.r_cod_concepto
                                 , p_TabConcAjustes.r_num_abonado;

                        p_TabConcAjustes.r_cod_columna:= v_Columna;
                END IF;
        END IF;

--        v_StrSql_2 := 'SELECT NVL(SUM(IMP_CONCEPTO),0 ) IMP_DESC ';
        v_StrSql_2 := 'SELECT NVL(SUM(IMP_FACTURABLE),0 ) IMP_DESC ';   -- PGG - 192820 - 4-04-2013
        v_StrSql_2 := v_StrSql_2 ||' FROM '||VP_NOMTABLACONC;
        v_StrSql_2 := v_StrSql_2 ||' WHERE IND_ORDENTOTAL = :indordentotal ';
        v_StrSql_2 := v_StrSql_2 ||' AND COD_TIPCONCE = 2 ';
        v_StrSql_2 := v_StrSql_2 ||' AND COD_CONCEREL = :codconcepto ' ;

        IF p_TabConcAjustes.r_cod_columna IS NOT NULL THEN
                v_StrSql_2 := v_StrSql_2 ||' AND COLUMNA_REL = :columna ' ;
                /* utl_file.Put_Line(fh,'v_StrSql_2 : ['||v_StrSql_2||']'); */
                EXECUTE IMMEDIATE v_StrSql_2
                INTO v_TotDesc
                USING  VP_INDORDENTOTAL
                         , p_TabConcAjustes.r_cod_concepto
                         , p_TabConcAjustes.r_cod_columna;
        ELSE
                IF p_TabConcAjustes.r_num_abonado IS NOT NULL THEN
                        v_StrSql_2 := v_StrSql_2 ||' AND NUM_ABONADO = :numabonado ' ;
                        /* utl_file.Put_Line(fh,'v_StrSql_2 : ['||v_StrSql_2||']'); */
                        EXECUTE IMMEDIATE v_StrSql_2
                        INTO v_TotDesc
                        USING  VP_INDORDENTOTAL
                                 , p_TabConcAjustes.r_cod_concepto
                                 , p_TabConcAjustes.r_num_abonado;
                END IF;
        END IF;

        p_TabConcAjustes.r_num_abonado  := v_NumAbonado;
        p_TabConcAjustes.r_cod_columna  := v_Columna;
        VP_TOTFACTURABLE                                := v_TotFacturable;
        VP_TOTSALDO                                     := v_TotFacturable + v_TotDesc;
        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Modulo : ['||vg_Modulo||']');
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Modulo : ['||vg_Modulo||']');
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;

END;

/* ************************************************************************* */
/* fConsultaConcOrigen : Lee conc. originales desde el NC anterior           */
/* ************************************************************************* */
FUNCTION fConsultaConcOrigenNC ( p_TabConcAjustes  IN OUT T_CONCAJUSTES
                               , VP_TIPOTABLA      IN CHAR
                               , VP_CODCICLFACT    IN PLS_INTEGER
                               , VP_NOMTABLACONC   IN CHAR
                               , VP_INDORDENTOTAL  IN PLS_INTEGER
                               , VP_TOTFACTURABLE OUT NUMBER
                               , VP_TOTSALDO      OUT NUMBER ) RETURN BOOLEAN IS
v_tablaDocu     VARCHAR2(40);
v_tablaConc     VARCHAR2(40);
v_StrSql        VARCHAR2(3000);
v_Columna       PLS_INTEGER;
v_TotFacturable NUMBER;
v_TotSaldo      NUMBER;
v_CodtipDocum   PLS_INTEGER;
v_PrefFolio     VARCHAR2(10);
v_NumFolio      PLS_INTEGER;
v_CodCliente    PLS_INTEGER;

BEGIN
    vg_Modulo := 'fConsultaConcOrigenNC';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    IF VP_TIPOTABLA = 'H' THEN /* HISTORICO  */
        v_tablaDocu := 'FA_HISTDOCU ';
    ELSE
        IF VP_CODCICLFACT = 19010102 THEN  /* NO CICLO */
            v_tablaDocu := 'FA_FACTDOCU_NOCICLO ';
        ELSE
            v_tablaDocu := 'FA_FACTDOCU_'||VP_CODCICLFACT ;
        END IF;
    END IF;
    utl_file.Put_Line(fh,'v_tablaDocu : ['||v_tablaDocu||']');

    v_StrSql := 'SELECT COD_TIPDOCUM, PREF_PLAZA, NUM_FOLIO, COD_CLIENTE ';
    v_StrSql := v_StrSql || 'FROM '||v_tablaDocu;
    v_StrSql := v_StrSql || ' WHERE IND_ORDENTOTAL = :indordentotal ';

    utl_file.Put_Line(fh,'Query : ['||v_StrSql||']');

    EXECUTE IMMEDIATE v_StrSql
    INTO v_CodtipDocum, v_PrefFolio, v_NumFolio, v_CodCliente
    USING  VP_INDORDENTOTAL;

    v_tablaConc := '';
    IF VP_TIPOTABLA = 'H' THEN /* HISTORICO  */
        SELECT FA_HISTCONC
        INTO v_tablaConc
        FROM FA_ENLACEHIST
        WHERE COD_CICLFACT = VP_CODCICLFACT;
    ELSE
        IF VP_CODCICLFACT = 19010102 THEN  /* NO CICLO */
            v_tablaConc := 'FA_FACTCONC_NOCICLO ';
        ELSE
            v_tablaConc := 'FA_FACTCONC_'||VP_CODCICLFACT ;
        END IF;
    END IF;

    utl_file.Put_Line(fh,'v_tablaDocu : ['||v_tablaDocu||']');
    utl_file.Put_Line(fh,'v_tablaConc : ['||v_tablaConc||']');

    v_StrSql := '';
    v_StrSql := v_StrSql || 'SELECT A.COLUMNA,';
    v_StrSql := v_StrSql || ' (MIN(A.IMP_FACTURABLE)+NVL(SUM(CC.IMP_FACTURABLE),0)) AS IMP_FACTURABLE,';
    v_StrSql := v_StrSql || ' DTOA(MIN(A.IMP_FACTURABLE-A.IMP_CONCEPTO)+NVL(SUM(CC.IMP_FACTURABLE-CC.IMP_CONCEPTO),0)) AS IMP_CONCEPTO ';
    v_StrSql := v_StrSql || 'FROM FA_AJUSTECONC A,';
    v_StrSql := v_StrSql || ' GE_MONEDAS B,';
    v_StrSql := v_StrSql || ' (SELECT C.IMP_FACTURABLE,';
    v_StrSql := v_StrSql || ' C.IMP_CONCEPTO,';
    v_StrSql := v_StrSql || ' D.COD_CONCEREL,';
    v_StrSql := v_StrSql || ' D.COLUMNA_REL';
    v_StrSql := v_StrSql || ' FROM FA_AJUSTECONC C,';
    v_StrSql := v_StrSql || ' ' || v_tablaConc || ' D';
    v_StrSql := v_StrSql || ' WHERE C.COD_CONCEPTO=D.COD_CONCEPTO';
    v_StrSql := v_StrSql || ' AND C.COLUMNA=D.COLUMNA';
    v_StrSql := v_StrSql || ' AND C.COD_TIPCONCE=2';
    v_StrSql := v_StrSql || ' AND D.IND_ORDENTOTAL=:indordentotal';
    v_StrSql := v_StrSql || ' AND C.PREF_PLAZA=:prefplaza';
    v_StrSql := v_StrSql || ' AND C.NUM_FOLIO=:numfolio';
    v_StrSql := v_StrSql || ' AND C.COD_CLIENTE=:codcliente';
    v_StrSql := v_StrSql || ' AND C.COD_TIPDOCUM=:codtipdocum) CC ';
    v_StrSql := v_StrSql || 'WHERE A.PREF_PLAZA=:prefplaza';
    v_StrSql := v_StrSql || ' AND A.NUM_FOLIO=:numfolio';
    v_StrSql := v_StrSql || ' AND A.COD_CLIENTE=:codcliente';
    v_StrSql := v_StrSql || ' AND A.COD_MONEDA=B.COD_MONEDA';
    v_StrSql := v_StrSql || ' AND A.COD_TIPDOCUM=:codtipdocum';
    v_StrSql := v_StrSql || ' AND A.COD_TIPCONCE=3';
    v_StrSql := v_StrSql || ' AND A.COD_CONCEPTO=CC.COD_CONCEREL(+)';
    v_StrSql := v_StrSql || ' AND A.COLUMNA=CC.COLUMNA_REL(+)';
    v_StrSql := v_StrSql || ' AND A.COD_CONCEPTO=:codconcepto';

    IF p_TabConcAjustes.r_cod_columna IS NOT NULL THEN
        v_StrSql := v_StrSql || ' AND A.COLUMNA=:columnarel';
        v_StrSql := v_StrSql || ' GROUP BY A.COLUMNA';
        utl_file.Put_Line(fh,'Query : ['||v_StrSql||']');

        utl_file.Put_Line(fh,'VP_INDORDENTOTAL                : ['||VP_INDORDENTOTAL               ||']');
        utl_file.Put_Line(fh,'v_PrefFolio                     : ['||v_PrefFolio                    ||']');
        utl_file.Put_Line(fh,'v_NumFolio                      : ['||v_NumFolio                     ||']');
        utl_file.Put_Line(fh,'v_CodCliente                    : ['||v_CodCliente                   ||']');
        utl_file.Put_Line(fh,'v_CodtipDocum                   : ['||v_CodtipDocum                  ||']');
        utl_file.Put_Line(fh,'v_PrefFolio                     : ['||v_PrefFolio                    ||']');
        utl_file.Put_Line(fh,'v_NumFolio                      : ['||v_NumFolio                     ||']');
        utl_file.Put_Line(fh,'v_CodCliente                    : ['||v_CodCliente                   ||']');
        utl_file.Put_Line(fh,'v_CodtipDocum                   : ['||v_CodtipDocum                  ||']');
        utl_file.Put_Line(fh,'p_TabConcAjustes.r_cod_concepto : ['||p_TabConcAjustes.r_cod_concepto||']');
        utl_file.Put_Line(fh,'p_TabConcAjustes.r_cod_columna  : ['||p_TabConcAjustes.r_cod_columna ||']');

        EXECUTE IMMEDIATE v_StrSql
        INTO  v_Columna, v_TotFacturable, v_TotSaldo
        USING  VP_INDORDENTOTAL
             , v_PrefFolio
             , v_NumFolio
             , v_CodCliente
             , v_CodtipDocum
             , v_PrefFolio
             , v_NumFolio
             , v_CodCliente
             , v_CodtipDocum
             , p_TabConcAjustes.r_cod_concepto
             , p_TabConcAjustes.r_cod_columna;
    ELSE
        IF p_TabConcAjustes.r_num_abonado IS NOT NULL THEN
            v_StrSql := v_StrSql || ' AND A.NUM_ABONADO=:numabonado ' ;
            v_StrSql := v_StrSql || ' GROUP BY A.COLUMNA';
            utl_file.Put_Line(fh,'Query : ['||v_StrSql||']');

            utl_file.Put_Line(fh,'VP_INDORDENTOTAL                : ['||VP_INDORDENTOTAL               ||']');
            utl_file.Put_Line(fh,'v_PrefFolio                     : ['||v_PrefFolio                    ||']');
            utl_file.Put_Line(fh,'v_NumFolio                      : ['||v_NumFolio                     ||']');
            utl_file.Put_Line(fh,'v_CodCliente                    : ['||v_CodCliente                   ||']');
            utl_file.Put_Line(fh,'v_CodtipDocum                   : ['||v_CodtipDocum                  ||']');
            utl_file.Put_Line(fh,'v_PrefFolio                     : ['||v_PrefFolio                    ||']');
            utl_file.Put_Line(fh,'v_NumFolio                      : ['||v_NumFolio                     ||']');
            utl_file.Put_Line(fh,'v_CodCliente                    : ['||v_CodCliente                   ||']');
            utl_file.Put_Line(fh,'v_CodtipDocum                   : ['||v_CodtipDocum                  ||']');
            utl_file.Put_Line(fh,'p_TabConcAjustes.r_cod_concepto : ['||p_TabConcAjustes.r_cod_concepto||']');
            utl_file.Put_Line(fh,'p_TabConcAjustes.r_num_abonado  : ['||p_TabConcAjustes.r_num_abonado ||']');

            EXECUTE IMMEDIATE v_StrSql
            INTO  v_Columna, v_TotFacturable, v_TotSaldo
            USING  VP_INDORDENTOTAL
                 , v_PrefFolio
                 , v_NumFolio
                 , v_CodCliente
                 , v_CodtipDocum
                 , v_PrefFolio
                 , v_CodCliente
                 , v_CodtipDocum
                 , p_TabConcAjustes.r_cod_concepto
                 , p_TabConcAjustes.r_num_abonado;
        ELSE
            utl_file.Put_Line(fh,'Registro no contiene los datos Necesarios');
            utl_file.Put_Line(fh,'cod_columna  : ['||p_TabConcAjustes.r_cod_columna  ||']');
            utl_file.Put_Line(fh,'num_abonado  : ['||p_TabConcAjustes.r_num_abonado  ||']');
            utl_file.Put_Line(fh,'monto_dinero : ['||p_TabConcAjustes.r_monto_dinero ||']');
            utl_file.Put_Line(fh,'monto_porcen : ['||p_TabConcAjustes.r_monto_porcen ||']');
            utl_file.Put_Line(fh,'ide_tipmonto : ['||p_TabConcAjustes.r_ide_tipmonto ||']');
            utl_file.Put_Line(fh,'cod_tecno    : ['||p_TabConcAjustes.r_cod_tecno    ||']');
            utl_file.Put_Line(fh,'ind_activo   : ['||p_TabConcAjustes.r_ind_activo   ||']');
        END IF;
    END IF;

    utl_file.Put_Line(fh,'v_Columna [' || v_Columna || ']');
    utl_file.Put_Line(fh,'v_TotFacturable [' || v_TotFacturable || ']');
    utl_file.Put_Line(fh,'v_TotSaldo [' || v_TotSaldo || ']');

    p_TabConcAjustes.r_cod_columna := v_Columna;
    VP_TOTFACTURABLE  := v_TotFacturable;
    VP_TOTSALDO       := v_TotSaldo;

    RETURN TRUE;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    utl_file.Put_Line(fh,'SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    utl_file.Put_Line(fh,'SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;

END;


/* ************************************************************************* */
/* fConsultaDocumento : Consulta documento original                                                      */
/* ************************************************************************* */
FUNCTION fConsultaDocumento ( p_TabAjuste       IN OUT T_AJUSTES,
                                                        VP_TABLA                OUT CHAR,
                                                        VP_ORDENTOTAL   OUT PLS_INTEGER,
                                                        VP_CICLOFACT    OUT PLS_INTEGER,
                                                        VP_INDSUPERTEL  OUT PLS_INTEGER,
                                                        VP_CODMODVENTA  OUT PLS_INTEGER,
                                                        VP_INDRESTNC    OUT PLS_INTEGER,
                                                        VP_CODTIPDOCUM  OUT PLS_INTEGER) RETURN BOOLEAN IS
V_CICLO                 PLS_INTEGER;
V_ORDENTOTAL    PLS_INTEGER;
V_INDSUPERTEL   PLS_INTEGER;
V_CODMODVENTA   PLS_INTEGER;
V_INDRESTNC     PLS_INTEGER;
V_CODTIPDOCUM   PLS_INTEGER;

ERROR_NO_ENCONTRADO EXCEPTION;
BEGIN
        vg_Modulo       := 'fConsultaDocumento';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        VP_ORDENTOTAL   := 0;
        VP_CICLOFACT    := 0;
        VP_TABLA                := 'P'; /* EN PROCESO */
        VP_INDSUPERTEL  := 0;
        VP_CODMODVENTA  := 0;
        BEGIN
                SELECT IND_ORDENTOTAL, COD_CICLFACT, IND_SUPERTEL, COD_MODVENTA, IND_RESTNC, A.COD_TIPDOCUM
                  INTO V_ORDENTOTAL, V_CICLO, V_INDSUPERTEL, V_CODMODVENTA, V_INDRESTNC, V_CODTIPDOCUM
                  FROM FA_FACTDOCU_NOCICLO A, FA_TIPDOCUMEN B
                 WHERE A.COD_OPERADORA  = p_TabAjuste.r_cod_operadora
                   AND A.PREF_PLAZA     = p_TabAjuste.r_pref_folio
                   AND A.NUM_FOLIO              = p_TabAjuste.r_num_folio
                   AND A.COD_CLIENTE    = p_TabAjuste.r_cod_cliente
                   AND A.COD_TIPDOCUM   = B.COD_TIPDOCUMMOV ;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        VP_TABLA         := 'H'; /* HISTORICO */
                        BEGIN
                                SELECT IND_ORDENTOTAL, COD_CICLFACT, IND_SUPERTEL, COD_MODVENTA, IND_RESTNC, A.COD_TIPDOCUM
                                  INTO V_ORDENTOTAL, V_CICLO, V_INDSUPERTEL, V_CODMODVENTA, V_INDRESTNC, V_CODTIPDOCUM
                                  FROM FA_HISTDOCU A, FA_TIPDOCUMEN B
                                 WHERE A.COD_OPERADORA = p_TabAjuste.r_cod_operadora
                                   AND A.PREF_PLAZA      = p_TabAjuste.r_pref_folio
                                   AND A.NUM_FOLIO       = p_TabAjuste.r_num_folio
                                   AND A.COD_CLIENTE     = p_TabAjuste.r_cod_cliente
                                   AND A.COD_TIPDOCUM = B.COD_TIPDOCUMMOV ;
                        EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        p_TabAjuste.r_obs_estado := 'NO SE ENCONTRO DOCUMENTO HISTORICO O EN PROCESO';
                                        RAISE ERROR_NO_ENCONTRADO;
                                WHEN OTHERS THEN
                                        p_TabAjuste.r_obs_estado := SQLERRM;
                                        RAISE ERROR_NO_ENCONTRADO;
                        END;
                WHEN OTHERS THEN
                        p_TabAjuste.r_obs_estado := SQLERRM;
                        RAISE ERROR_NO_ENCONTRADO;
        END;
        VP_CODTIPDOCUM  := V_CODTIPDOCUM;
        VP_INDRESTNC    := V_INDRESTNC;
        VP_INDSUPERTEL  := V_INDSUPERTEL;
        VP_CODMODVENTA  := V_CODMODVENTA;
        VP_ORDENTOTAL   := V_ORDENTOTAL;
        VP_CICLOFACT    := V_CICLO;

        RETURN TRUE;
EXCEPTION
        WHEN ERROR_NO_ENCONTRADO THEN
                p_TabAjuste.r_estado := 2;  /* NO OK */
                RETURN FALSE;

END;

/* ************************************************************************* */
/* fObtieneTablaConc : consulta tabla de conceptos dcto. original                        */
/* ************************************************************************* */
FUNCTION fObtieneTablaConc  ( v_CiclFact        IN NUMBER
                                                        , v_NomTabla    OUT VARCHAR2 ) RETURN BOOLEAN IS
BEGIN
        vg_Modulo       := 'fObtieneTablaConc';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        BEGIN
                        SELECT FA_HISTCONC
                          INTO v_NomTabla
                          FROM FA_ENLACEHIST
                         WHERE COD_CICLFACT = v_CiclFact;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN FALSE;
                WHEN OTHERS THEN
                        RETURN FALSE;
        END;

        RETURN TRUE;
EXCEPTION
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fConsultaAjustes : consulta ajustes anteriores                                                        */
/* ************************************************************************* */
FUNCTION fConsultaAjustes   ( p_TabAjuste       IN OUT T_AJUSTES
                                                        , VP_CODTIPDOCUM IN PLS_INTEGER
                                                        , VP_CUENTA OUT PLS_INTEGER ) RETURN BOOLEAN IS
BEGIN
        vg_Modulo       := 'fConsultaAjustes';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COUNT(1)
          INTO VP_CUENTA
          FROM FA_AJUSTES
         WHERE PREF_PLAZA       = p_TabAjuste.r_pref_folio
           AND NUM_FOLIO        = p_TabAjuste.r_num_folio
           AND COD_CLIENTE      = p_TabAjuste.r_cod_cliente
           AND ACUM_NETOGRAVNC + ACUM_NETONOGRAVNC > 0
           AND COD_TIPDOCUM = VP_CODTIPDOCUM;

        RETURN TRUE;

EXCEPTION
        WHEN OTHERS THEN
                p_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;

END;

/* ************************************************************************* */
/* fConsultaAjustesAplic : consulta conceptos de ajustes anteriores                      */
/* ************************************************************************* */
FUNCTION fConsultaAjustesAplic ( p_TabAjuste    IN OUT  T_AJUSTES
                               , VP_CODTIPDOCUM IN PLS_INTEGER
                               , VP_CUENTA     OUT PLS_INTEGER ) RETURN BOOLEAN IS
BEGIN
    vg_Modulo:= 'fConsultaAjustesAplic';

    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    SELECT COUNT(1)
      INTO VP_CUENTA
      FROM FA_AJUSTECONC
     WHERE PREF_PLAZA   = p_TabAjuste.r_pref_folio
       AND NUM_FOLIO    = p_TabAjuste.r_num_folio
       AND COD_CLIENTE  = p_TabAjuste.r_cod_cliente
       AND COD_TIPDOCUM = VP_CODTIPDOCUM
       AND IMP_FACTURABLE <> IMP_CONCEPTO;

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
    p_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
    RETURN FALSE;

END;

/* ************************************************************************* */
/* fActualizaDetAjustes : Actualiza el detalle de los ajustes                            */
/* ************************************************************************* */
FUNCTION fActualizaDetAjustes (p_ConcTabAjuste IN OUT T_CONCAJUSTES) RETURN BOOLEAN IS
BEGIN
        vg_Modulo       := 'fActualizaDetAjustes';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        UPDATE FA_DETAJUSTES_TO
           SET MONTO_DINERO = p_ConcTabAjuste.r_monto_dinero
                 , COD_COLUMNA  = p_ConcTabAjuste.r_cod_columna
         WHERE ROWID = p_ConcTabAjuste.r_rowid;

        RETURN TRUE;

EXCEPTION
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;

END ;

/* ************************************************************************* */
/* fValidaConceptos : Valida el detalle de los conceptos de los ajustes          */
/* ************************************************************************* */
FUNCTION fValidaConceptos ( p_TabAjuste    IN OUT T_AJUSTES
                          , VP_TIPOTABLA   IN CHAR
                          , VP_CODCICLFACT IN PLS_INTEGER
                          , VP_ORDENTOTAL  IN PLS_INTEGER
                          , VP_INDNCANTER  IN PLS_INTEGER ) RETURN BOOLEAN IS
v_NomTablaConc  VARCHAR2(40);
v_TotFacturable NUMBER;
v_TotSaldo      NUMBER;
i               PLS_INTEGER;

ERROR_FALTA_DATOS        EXCEPTION;
ERROR_TAB_CONC_NO_EXISTE EXCEPTION;
ERROR_DET_NO_ENCONTRADO  EXCEPTION;
ERROR_CONC_NO_ENCONTRADO EXCEPTION;
ERROR_NO_CONCAJUSTE      EXCEPTION;
BEGIN
    vg_Modulo := 'fValidaConceptos';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');
    utl_file.Put_Line(fh,'VP_CODCICLFACT : ['||VP_CODCICLFACT||']');
    p_TabAjuste.r_estado := 1;  /* OK */

    IF VP_TIPOTABLA = 'P' THEN
        v_NomTablaConc := 'FA_FACTCONC_NOCICLO';
    ELSE
        IF NOT fObtieneTablaConc (VP_CODCICLFACT, v_NomTablaConc) THEN
            RAISE ERROR_TAB_CONC_NO_EXISTE;
        END IF;
    END IF;

    IF NOT fLeeDetAjustes (p_TabAjuste.r_proceso, TabConcAjustes) THEN
        RAISE ERROR_DET_NO_ENCONTRADO;
    END IF;

    IF TabConcAjustes.COUNT > 0 THEN
        FOR i IN 1..TabConcAjustes.LAST LOOP
            IF TabConcAjustes(i).r_cod_columna IS NULL AND TabConcAjustes(i).r_num_abonado IS NULL THEN
                RAISE ERROR_FALTA_DATOS;
            END IF;
            IF VP_INDNCANTER = 1 THEN
                IF NOT fConsultaConcOrigenNC ( TabConcAjustes(i)
                                             , VP_TIPOTABLA
                                             , VP_CODCICLFACT
                                             , v_NomTablaConc
                                             , VP_ORDENTOTAL
                                             , v_TotFacturable
                                             , v_TotSaldo) THEN
                    RAISE ERROR_CONC_NO_ENCONTRADO;
                END IF;
            ELSE
                IF NOT fConsultaConcOrigen ( TabConcAjustes(i)
                                           , v_NomTablaConc
                                           , VP_ORDENTOTAL
                                           , v_TotFacturable
                                           , v_TotSaldo) THEN
                    RAISE ERROR_CONC_NO_ENCONTRADO;
                END IF;

            END IF;

            IF TabConcAjustes(i).r_ide_tipmonto = 1 THEN /* PORCENTUAL */
                TabConcAjustes(i).r_monto_dinero := (v_TotFacturable * TabConcAjustes(i).r_monto_porcen ) /100;
            END IF;
            IF NOT fActualizaDetAjustes (TabConcAjustes(i)) THEN
                RAISE ERROR_CONC_NO_ENCONTRADO;
            END IF;

            IF TabConcAjustes(i).r_monto_dinero > v_TotFacturable THEN /* PRS TM-200412211169 - Se actualiza signo >= por > */
                p_TabAjuste.r_estado := 2;  /* NO OK */
                p_TabAjuste.r_obs_estado := 'CONCEPTO ORIGINAL CON MONTO INSUFICIENTE';
                EXIT;
            END IF;
            /* Inc 45207 PPV 03/12/2007 se quita validacion para poder ajustar por el total*/
            /*IF VP_INDNCANTER = 1 THEN
                IF TabConcAjustes(i).r_monto_dinero >= v_TotSaldo THEN
                    p_TabAjuste.r_estado := 2; */ /* NO OK */
                    /*p_TabAjuste.r_obs_estado := 'CONCEPTO ORIGINAL CON N. CREDITO POR EL TOTAL';
                    EXIT;
                END IF;
            ELSE*/
                IF TabConcAjustes(i).r_monto_dinero > v_TotSaldo THEN /* PRS TM-200412211169 - Se actualiza signo >= por > */
                    p_TabAjuste.r_estado := 2;  /* NO OK */
                    p_TabAjuste.r_obs_estado := 'AJUS CONC, MAYORMONTO ORIGINAL + DESCUENTO';
                    EXIT;
                END IF;
            /*END IF;*/
        END LOOP;
    END IF;

    RETURN TRUE;


EXCEPTION
  WHEN ERROR_TAB_CONC_NO_EXISTE THEN
    p_TabAjuste.r_estado := 2;  /* NO OK */
    p_TabAjuste.r_obs_estado := 'NO SE ENCONTRO TABLA DE HISTORICO DE CONCEPTOS';
    RETURN TRUE;
  WHEN ERROR_DET_NO_ENCONTRADO THEN
    p_TabAjuste.r_estado := 2;  /* NO OK */
    p_TabAjuste.r_obs_estado := 'NO SE ENCONTRARON DETALLES DE AJUSTES';
    RETURN TRUE;
  WHEN ERROR_CONC_NO_ENCONTRADO THEN
    p_TabAjuste.r_estado := 2;  /* NO OK */
    p_TabAjuste.r_obs_estado := 'NO SE ENCONTRO CONCEPTO PARA APLICAR AJUSTE';
    RETURN TRUE;
  WHEN ERROR_FALTA_DATOS THEN
    p_TabAjuste.r_estado := 2;  /* NO OK */
    p_TabAjuste.r_obs_estado := 'COLUMNA Y ABONADO NULOS' ;
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN TRUE;

END;

/* ************************************************************************* */
/* fValidaDocumento : realiza las validaciones del documento indicado            */
/* ************************************************************************* */
FUNCTION fValidaDocumento ( p_TabAjuste         IN OUT T_AJUSTES
                                                  , VP_TIPOTABLA        OUT CHAR
                                                  , VP_CODCICLFACT      OUT NUMBER
                                                  , VP_ORDENTOTAL       OUT NUMBER
                                                  , VP_INDNCANTER       OUT NUMBER) RETURN BOOLEAN IS
v_TipoTabla     CHAR;
v_IndOrdentotal PLS_INTEGER;
v_CiclFact              PLS_INTEGER;
v_NomTablaConc  CHAR;
v_IndSupertel   PLS_INTEGER;
v_CodModVenta   PLS_INTEGER;
v_IndRestNC     PLS_INTEGER;
v_CodTipDocum   PLS_INTEGER;
v_CuentaNC              PLS_INTEGER;
v_CuentaNCConc  PLS_INTEGER;

ERROR_CONSULTADCTO  EXCEPTION;
ERROR_AJUSTES           EXCEPTION;
ERROR_AJUSTECONC        EXCEPTION;
ERROR_DOC_INVALIDO      EXCEPTION;
BEGIN
        vg_Modulo       := 'fValidaDocumento';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        p_TabAjuste.r_estado := 1; /* OK */

        VP_INDNCANTER   := 0;
        VP_TIPOTABLA    := '';
        VP_CODCICLFACT  := 0;
        VP_ORDENTOTAL   := 0;

        IF fConsultaDocumento   ( p_TabAjuste
                                                        , v_TipoTabla
                                                        , v_IndOrdentotal
                                                        , v_CiclFact
                                                        , v_IndSupertel
                                                        , v_CodModVenta
                                                        , v_IndRestNC
                                                        , v_CodTipDocum) THEN

                VP_TIPOTABLA    := v_TipoTabla;
                VP_CODCICLFACT  := v_CiclFact;
                VP_ORDENTOTAL   := v_IndOrdentotal;
                IF v_IndSupertel = 1 THEN /* FACTURA SUPERTELEFONO */
                        p_TabAjuste.r_obs_estado := 'FACTURA SUPERTENEFONO';
                        RAISE ERROR_DOC_INVALIDO;
                ELSE
                        IF v_CodModVenta = 5 THEN  /* MODALIDAD DE VENTA REGALO */
                                p_TabAjuste.r_obs_estado := 'FACTURA VENTA REGALO';
                                RAISE ERROR_DOC_INVALIDO;
                        ELSE
                                IF NOT (v_IndRestNC = 0 OR v_IndRestNC = 2 ) THEN  /* RESTRICCION DE NC PARCIAL */
                                        p_TabAjuste.r_obs_estado := 'FACTURA CON RESTRICCION';
                                        RAISE ERROR_DOC_INVALIDO;
                                ELSE
                                        IF NOT fConsultaAjustes( p_TabAjuste , v_CodTipDocum, v_CuentaNC)  THEN
                                                RAISE ERROR_AJUSTES;
                                        ELSE
                                                IF v_CuentaNC > 0 THEN
                                                        IF NOT fConsultaAjustesAplic( p_TabAjuste , v_CodTipDocum, v_CuentaNCConc) THEN
                                                                RAISE ERROR_AJUSTECONC;
                                                        ELSE
                                                                IF v_CuentaNCConc = 0 THEN
                                                                        p_TabAjuste.r_obs_estado := 'DCTO. SIN SALDO A DESCONTAR';
                                                                        RAISE ERROR_DOC_INVALIDO;
                                                                END IF;
                                                                VP_INDNCANTER := 1;
                                                        END IF;
                                                END IF;
                                        END IF;
                                END IF;
                        END IF;
                END IF;
        ELSE
                RAISE ERROR_CONSULTADCTO;
        END IF;

        RETURN TRUE;
EXCEPTION
        WHEN ERROR_CONSULTADCTO THEN
                p_TabAjuste.r_estado := 2; /* NO OK */
                RETURN TRUE;
        WHEN ERROR_AJUSTES              THEN
                p_TabAjuste.r_estado := 2; /* NO OK */
                RETURN TRUE;
        WHEN ERROR_AJUSTECONC   THEN
                p_TabAjuste.r_estado := 2; /* NO OK */
                RETURN TRUE;
        WHEN ERROR_DOC_INVALIDO THEN
                p_TabAjuste.r_estado := 2; /* NO OK */
                RETURN TRUE;

END;

/* ************************************************************************* */
/* fValida_NotaCred : realiza las validaciones de Notas de Credito                       */
/* ************************************************************************* */
FUNCTION fValida_NotaCred (TabAjuste IN OUT T_AJUSTES) RETURN BOOLEAN IS
v_TipoTabla     CHAR;
v_CiclFact      PLS_INTEGER;
v_IndOrdentotal PLS_INTEGER;
v_IndNCAnterior PLS_INTEGER;

ERROR_VALIDADOCTO  EXCEPTION;
ERROR_VALIDACONCEP EXCEPTION;
BEGIN
    vg_Modulo := 'fValida_NotaCred';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    IF fValidaDocumento(TabAjuste, v_TipoTabla, v_CiclFact, v_IndOrdentotal, v_IndNCAnterior ) THEN
        IF TabAjuste.r_estado <> 2 THEN
            IF NOT fValidaConceptos(TabAjuste, v_TipoTabla, v_CiclFact, v_IndOrdentotal,v_IndNCAnterior) THEN
                RAISE ERROR_VALIDACONCEP;
            END IF;
        END IF;
    END IF;
RETURN TRUE;

END;

/* ************************************************************************* */
/* fActualizaAjustes : actualiza los registros de ajuste                     */
/* ************************************************************************* */
FUNCTION fActualizaAjustes (TabAjuste IN OUT T_AJUSTES) RETURN BOOLEAN IS
BEGIN
    vg_Modulo := 'fActualizaAjustes';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    UPDATE FA_AJUSTES_TO
    SET ESTADO = TabAjuste.r_estado,
        OBS_ESTADO = TabAjuste.r_obs_estado,
        FEC_ESTADO = SYSDATE,
        NUM_PROCESO = TabAjuste.r_num_proceso
    WHERE ROWID = TabAjuste.r_rowid;

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;

END ;

/* ************************************************************************* */
/* fValidaCliente : valida que el cliente exista y no esta de baja                       */
/* ************************************************************************* */
FUNCTION fValidaCliente (vp_TabAjuste IN OUT T_AJUSTES ) RETURN BOOLEAN IS
v_cod_cliente PLS_INTEGER;
BEGIN
        vg_Modulo       := 'fValidaCliente';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_CLIENTE
          INTO v_cod_cliente
          FROM GE_CLIENTES
         WHERE COD_CLIENTE = vp_TabAjuste.r_cod_cliente
           AND FEC_BAJA IS NULL;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'CLIENTE NO EXISTE';
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
END;


/* ************************************************************************* */
/* fValida_FactMisc : VALIDA LOS DATOS PARA LA FACTURA MISCELANEA                        */
/* ************************************************************************* */
FUNCTION fValida_FactMisc(p_TabAjuste IN OUT T_AJUSTES) RETURN BOOLEAN IS
X                       PLS_INTEGER;

ERROR_CONC_INACTIVO             EXCEPTION;
ERROR_NO_DETALLE EXCEPTION;
BEGIN
        vg_Modulo       := 'fValida_FactMisc';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        p_TabAjuste.r_estado := 1; /* OK */
        IF fValidaCliente (p_TabAjuste) THEN
                IF NOT fLeeDetAjustes (p_TabAjuste.r_proceso, TabConcAjustes) THEN
                        RAISE ERROR_NO_DETALLE;
                END IF;

                IF TabConcAjustes.COUNT > 0 THEN
                        FOR X IN 1..TabConcAjustes.LAST LOOP
                                IF TabConcAjustes(X).r_ind_activo = 0 THEN
                                        RAISE ERROR_CONC_INACTIVO;
                                END IF;
                        END LOOP;
                ELSE
                        RAISE ERROR_NO_DETALLE;
                END IF;
        END IF;

        RETURN TRUE;
EXCEPTION
        WHEN ERROR_NO_DETALLE THEN
                p_TabAjuste.r_estado := 2;  /* NO OK */
                p_TabAjuste.r_obs_estado := 'NO EXISTE DETALLE AJUSTE PARA APLICAR';
                RETURN TRUE;
        WHEN ERROR_CONC_INACTIVO THEN
                p_TabAjuste.r_estado := 2;  /* NO OK */
                p_TabAjuste.r_obs_estado := 'CONCEPTO INACTIVO ';
                RETURN TRUE;
END;

/* ************************************************************************* */
/* fGrabaTransac : GRABA EL ESTADO DE LA TRANSACCION                                             */
/* ************************************************************************* */
FUNCTION fGrabaTransac ( VP_NUMTRANSAC IN NUMBER
                       , VP_ESTTRANSAC IN NUMBER
                       , VP_DESTRANSAC IN VARCHAR2
) RETURN BOOLEAN IS

BEGIN
    vg_Modulo := 'fGrabaTransac';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    INSERT INTO GA_TRANSACABO(
        NUM_TRANSACCION,
        COD_RETORNO,
        DES_CADENA)
    VALUES (
        VP_NUMTRANSAC,
        VP_ESTTRANSAC,
        SUBSTR(VP_DESTRANSAC,1,255));


    RETURN TRUE;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('TRANSACCION DUPLICADA ');
    RETURN FALSE;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;
END;



/* ************************************************************************* */
/* fConsultaCentrEmisor : consulta el Modo de generacion del documento       */
/* ************************************************************************* */
FUNCTION fConsultaCentrEmisor ( vp_TabAjuste IN OUT T_AJUSTES
                                                          , VP_CODTIPDOCUM  IN PLS_INTEGER
                                                          , VP_CODOFICINA       IN VARCHAR2
                                                          , VP_CODCENTREMI      OUT PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaCentrEmisor';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_CENTREMI
          INTO VP_CODCENTREMI
          FROM AL_DOCUM_SUCURSAL
         WHERE COD_OFICINA = VP_CODOFICINA
           AND COD_TIPDOCUM = VP_CODTIPDOCUM;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE CENTRO EMISOR PARA LA OFICINA '||VP_CODOFICINA;
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'ERROR :['||SQLERRM ||']';
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fConsultaModGener : consulta el Modo de generacion del documento                      */
/* ************************************************************************* */
FUNCTION fConsultaModGener  ( vp_TabAjuste IN OUT T_AJUSTES
                                                        , VP_CODCENTREMI        IN PLS_INTEGER
                                                        , VP_CODCATRIBUT        IN CHAR
                                                        , VP_CODMODGENER        OUT CHAR
                                                        , VP_CODMISCELA         OUT PLS_INTEGER

) RETURN BOOLEAN IS
BEGIN
        vg_Modulo       := 'fConsultaModGener';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT A.COD_MODGENER, B.COD_MISCELA
          INTO VP_CODMODGENER, VP_CODMISCELA
          FROM FA_GENCENTREMI A, FA_DATOSGENER B, GA_DATOSGENER C
         WHERE COD_CENTREMI = VP_CODCENTREMI
           AND COD_TIPMOVIMIEN = B.COD_MISCELA
           AND COD_MODVENTA = C.COD_CONTADO
           AND COD_APLIC ='FAC'
           AND COD_CATRIBUT=VP_CODCATRIBUT;


        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE MODO DE GENERACION';
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_obs_estado := 'ERROR :['||SQLERRM ||']';
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fConsultaLetra : consulta la letra del documento                                              */
/* ************************************************************************* */
FUNCTION fConsultaLetra ( vp_TabAjuste          IN OUT T_AJUSTES
                                                , VP_CODTIPDOCUM        IN PLS_INTEGER
                                                , VP_CODCATIMPOS        IN PLS_INTEGER
                                                , VP_LETRA                      OUT VARCHAR2
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaLetra';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT  LETRA
          INTO  VP_LETRA
          FROM  GE_LETRAS
         WHERE  COD_TIPDOCUM = VP_CODTIPDOCUM
           AND  COD_CATIMPOS = VP_CODCATIMPOS;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE LETRA PARA DOC./CAT.IMPOSITIVA '||VP_CODTIPDOCUM||'/'||VP_CODCATIMPOS;
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;


/* ************************************************************************* */
/* fConsultaCaTributClie : consulta la categoria tributaria del cliente          */
/* ************************************************************************* */
FUNCTION fConsultaCaTributClie ( vp_TabAjuste   IN OUT T_AJUSTES
                                                           , VP_CODCATRIBUT OUT  CHAR
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaCaTributClie';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_CATRIBUT
          INTO VP_CODCATRIBUT
          FROM GA_CATRIBUTCLIE
         WHERE COD_CLIENTE =vp_TabAjuste.r_cod_cliente
           AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;


        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE C. TRIBUTARIA VIGENTE CLIENTE '||vp_TabAjuste.r_cod_cliente;
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;
/* ************************************************************************* */
/* fConsultaCatImposCliente : consulta la categoria tributaria del cliente       */
/* ************************************************************************* */
FUNCTION fConsultaCatImposCliente ( vp_TabAjuste   IN OUT T_AJUSTES
                                  , VP_CODCATIMPOS    OUT  PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
    vg_Modulo := 'fConsultaCatImposCliente';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    SELECT COD_CATIMPOS
      INTO VP_CODCATIMPOS
      FROM GE_CATIMPCLIENTES
     WHERE COD_CLIENTE =vp_TabAjuste.r_cod_cliente
       AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

    RETURN TRUE;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    vp_TabAjuste.r_estado := 2;  /* NO OK */
    vp_TabAjuste.r_obs_estado := 'NO EXITE C. IMPOSITIVA CLIENTE '||vp_TabAjuste.r_cod_cliente;
    RETURN FALSE;
  WHEN OTHERS THEN
    vp_TabAjuste.r_estado := 2;  /* NO OK */
    vp_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
    RETURN FALSE;
END;

/* ************************************************************************* */
/* fConsultaCodTipDocum : consulta el codigo de documento a generar                      */
/* ************************************************************************* */
FUNCTION fConsultaCodTipDocum ( vp_TabAjuste    IN OUT T_AJUSTES
                                                          , VP_CODCATIMPOS      IN      PLS_INTEGER
                                                          , VP_CODCATRIBUT      IN      CHAR
                                                          , VP_CODTIPDOCUM  OUT PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaCodTipDocum';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_TIPDOCUM
          INTO VP_CODTIPDOCUM
          FROM FA_TIPMOVIMIEN A, FA_DATOSGENER B, GA_DATOSGENER C
         WHERE COD_TIPMOVIMIEN= B.COD_MISCELA
           AND COD_MODVENTA = C.COD_CONTADO
           AND COD_CATRIBUT = VP_CODCATRIBUT
           AND COD_TIPIMPOSITIVA = VP_CODCATIMPOS;


        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE CODIGO DE DOCUMENTO '||VP_CODCATRIBUT||'/'||VP_CODCATIMPOS;
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;
/* ************************************************************************* */
/* fConsultaLineas : consulta el codigo de documento a generar                           */
/* ************************************************************************* */
FUNCTION fConsultaLineas ( VP_FORMULARIO        IN      PLS_INTEGER
                                                 , VP_BLOQUE            IN      PLS_INTEGER
                                                 , VP_NUMLINEAS     OUT PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaLineas';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||'] VP_FORMULARIO :['||VP_FORMULARIO||'] VP_BLOQUE :['||VP_BLOQUE||']');

        SELECT CANT_LINEASMEN
          INTO VP_NUMLINEAS
          FROM FA_parmensaje
         WHERE COD_FORMULARIO = VP_FORMULARIO
           AND COD_BLOQUE = VP_BLOQUE;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
        WHEN OTHERS THEN
                RETURN FALSE;
END;
/* ************************************************************************* */
/* fConsultaDirecClie : consulta direccion del cliente                                           */
/* ************************************************************************* */
FUNCTION fConsultaDirecClie ( vp_TabAjuste      IN OUT T_AJUSTES
                                                        , VP_CODREGION          OUT VARCHAR2
                                                        , VP_CODPROVINCIA       OUT VARCHAR2
                                                        , VP_CODCIUDAD          OUT     VARCHAR2
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaDirecClie';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_REGION, COD_PROVINCIA, COD_CIUDAD
          INTO VP_CODREGION, VP_CODPROVINCIA, VP_CODCIUDAD
          FROM GE_DIRECCIONES A, GA_DIRECCLI B,  GE_CLIENTES C
         WHERE C.COD_CLIENTE = vp_TabAjuste.r_cod_cliente
           AND C.COD_CLIENTE = B.COD_CLIENTE
           AND b.COD_TIPDIRECCION = 1  /* DIRECCION DE FACTURACION */
       AND B.COD_DIRECCION = a.COD_DIRECCION;


        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE DIRECCION CLIENTE'||vp_TabAjuste.r_cod_cliente;
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fConsultaMonedaFact : consulta la monada de facturacion                                       */
/* ************************************************************************* */
FUNCTION fConsultaMonedaFact ( VP_MONEDAFACT    OUT VARCHAR2
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaMonedaFact';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_MONEFACT
          INTO VP_MONEDAFACT
          FROM FA_DATOSGENER;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
        WHEN OTHERS THEN
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fConsultaPlanCom : consulta la monada de facturacion                                          */
/* ************************************************************************* */
FUNCTION fConsultaPlanCom ( vp_TabAjuste        IN OUT T_AJUSTES
                                                  , VP_CODPLANCOM       OUT PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaPlanCom';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_PLANCOM
          INTO VP_CODPLANCOM
          FROM GA_CLIENTE_PCOM
         WHERE COD_CLIENTE = vp_TabAjuste.r_cod_cliente
           AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE+1);

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE PLAN COMERCIAL CLIENTE '||vp_TabAjuste.r_cod_cliente;
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fLeeSecuencia : Lee el numero entregado por la secuencia entregada            */
/* ************************************************************************* */
FUNCTION fLeeSecuencia (  VP_NOMSECUENCIA IN VARCHAR2
                                                , VP_NUMSECUENCIA OUT PLS_INTEGER
) RETURN BOOLEAN IS

v_StrSql        VARCHAR2(1000);
BEGIN

        vg_Modulo               := 'fLeeSecuencia';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        v_StrSql := 'SELECT '||VP_NOMSECUENCIA||'.NEXTVAL ';
        v_StrSql := v_StrSql || ' FROM DUAL ';

        EXECUTE IMMEDIATE v_StrSql
        INTO VP_NUMSECUENCIA;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;

END;

/* ************************************************************************* */
/* fGrabaProceso : Graba los datos del proceso                                                           */
/* ************************************************************************* */
FUNCTION fGrabaProceso ( VP_SEQNUMPROC          IN PLS_INTEGER
                                           , VP_CODTIPDOCUM             IN PLS_INTEGER
                                           , VP_COD_VENDEDOR    IN PLS_INTEGER
                                           , VP_CODCENTREMI             IN PLS_INTEGER
                                           , VP_USUARIO                 IN VARCHAR2
                                           , VP_LETRA                   IN VARCHAR2
                                           , VP_SEQNUMEMIS              IN PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fGrabaProceso';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||'] PROCESO : ['||VP_SEQNUMPROC||']');

        INSERT
          INTO FA_PROCESOS ( NUM_PROCESO
                                                , COD_TIPDOCUM
                                                , COD_VENDEDOR_AGENTE
                                                , COD_CENTREMI
                                                , FEC_EFECTIVIDAD
                                                , NOM_USUARORA
                                                , LETRAAG
                                                , NUM_SECUAG)
           VALUES       ( VP_SEQNUMPROC
                                , VP_CODTIPDOCUM
                                , VP_COD_VENDEDOR
                                , VP_CODCENTREMI
                                , SYSDATE
                                , VP_USUARIO
                                , VP_LETRA
                                , VP_SEQNUMEMIS);


        RETURN TRUE;
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('NUMERO DE PROCESO DUPLICADO');
                RETURN FALSE;
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fGrabaProceso : Graba los datos del proceso                                                           */
/* ************************************************************************* */
FUNCTION fGrabaMensaje ( VP_SEQNUMPROC          IN PLS_INTEGER
                                           , VP_CORRMENSAJE             IN PLS_INTEGER
                                           , VP_NUMLINEAS               IN PLS_INTEGER
                                           , VP_USUARIO                 IN VARCHAR2
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fGrabaMensaje';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        INSERT
          INTO FA_MENSPROCESO ( NUM_PROCESO
                                                  , COD_FORMULARIO
                                                  , COD_BLOQUE
                                                  , CORR_MENSAJE
                                                  , NUM_LINEAS
                                                  , COD_ORIGEN
                                                  , DESC_MENSAJE
                                                  , IND_FACTURADO
                                                  , NOM_USUARIO
                                                  , FEC_INGRESO)
           VALUES       ( VP_SEQNUMPROC
                                , 1
                                , 3
                                , VP_CORRMENSAJE
                                , VP_NUMLINEAS
                                , 'FA'
                                , 'MENSAJE AJUSTE MASIVO'
                                , 0
                                , VP_USUARIO
                                , SYSDATE);


        RETURN TRUE;
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('NUMERO DE PROCESO DUPLICADO');
                RETURN FALSE;
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
END;

/* ************************************************************************* */
/* fGrabaPrefactura : Graba los datos de la prefactura                                           */
/* ************************************************************************* */
FUNCTION fGrabaPrefactura ( VP_SEQNUMPROC               IN PLS_INTEGER
                                                  , VP_CODCLIENTE               IN PLS_INTEGER
                                                  , p_TabConcAjustes    IN T_CONCAJUSTES
                                                  , VP_MONEDAFACT               IN VARCHAR2
                                                  , VP_REGION                   IN VARCHAR2
                                                  , VP_PROVINCIA                IN VARCHAR2
                                                  , VP_CIUDAD                   IN VARCHAR2
                                                  , VP_CODPLANCOM               IN PLS_INTEGER
                                                  , VP_CODCATIMPOS              IN PLS_INTEGER
                                                  , VP_USUARIO                  IN VARCHAR2
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fGrabaPrefactura';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        INSERT
          INTO FA_PREFACTURA ( NUM_PROCESO
                                                 , COD_CLIENTE
                                                 , COD_CONCEPTO
                                                 , COLUMNA
                                                 , COD_PRODUCTO
                                                 , COD_MONEDA
                                                 , FEC_VALOR
                                                 , FEC_EFECTIVIDAD
                                                 , IMP_CONCEPTO
                                                 , IMP_FACTURABLE
                                                 , IMP_MONTOBASE
                                                 , COD_REGION
                                                 , COD_PROVINCIA
                                                 , COD_CIUDAD
                                                 , COD_MODULO
                                                 , COD_PLANCOM
                                                 , IND_FACTUR
                                                 , NUM_UNIDADES
                                                 , COD_CATIMPOS
                                                 , IND_ESTADO
                                                 , COD_TIPCONCE
                                                 , NUM_ABONADO
                                                 , IND_MODVENTA)
           VALUES       ( VP_SEQNUMPROC
                                , VP_CODCLIENTE
                                , p_TabConcAjustes.r_cod_concepto
                                , p_TabConcAjustes.r_cod_columna
                                , 1
                                , VP_MONEDAFACT
                                , SYSDATE
                                , SYSDATE
                                , p_TabConcAjustes.r_monto_dinero
                                , p_TabConcAjustes.r_monto_dinero
                                , 0
                                , VP_REGION
                                , VP_PROVINCIA
                                , VP_CIUDAD
                                , 'FA'
                                , VP_CODPLANCOM
                                , 1
                                , 1
                                , VP_CODCATIMPOS
                                , 0
                                , 3
                                , p_TabConcAjustes.r_num_abonado
                                , 1);



        RETURN TRUE;
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('NUMERO DE PROCESO DUPLICADO');
                RETURN FALSE;
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
END;
/* ************************************************************************* */
/* fGrabaSecuenciaEmi : Actualiza el munero de la secuencia de emision           */
/* ************************************************************************* */
FUNCTION fGrabaSecuenciaEmi ( VP_CODTIPDOCUM    IN PLS_INTEGER
                                                        , VP_CENTROEMISOR       IN PLS_INTEGER
                                                        , VP_LETRA                      IN CHAR
                                                        , VP_SECUENCIAEMI       IN PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fGrabaSecuenciaEmi';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        UPDATE GE_SECUENCIASEMI SET NUM_SECUENCI=VP_SECUENCIAEMI
         WHERE COD_TIPDOCUM=VP_CODTIPDOCUM
           AND COD_CENTREMI=VP_CENTROEMISOR
           AND LETRA=VP_LETRA;

        RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO EXISTE SECUENCIA');
                RETURN FALSE;
        WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
END;
/* ************************************************************************* */
/* fValidaTransac : Valida la ejecucion de algun sql a traves ga_transacabo      */
/* ************************************************************************* */
FUNCTION fValidaTransac ( p_TabAjuste           IN OUT T_AJUSTES
                                                , VP_SECTRANSAC         IN PLS_INTEGER
) RETURN BOOLEAN IS
v_CodRetorno PLS_INTEGER;
v_DesTransac VARCHAR2(255);
BEGIN
        vg_Modulo       := 'fValidaTransac';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');
        utl_file.Put_Line(fh,'VP_SECTRANSAC : ['||VP_SECTRANSAC||']');

        SELECT COD_RETORNO, NVL(DES_CADENA,' ')
          INTO v_CodRetorno, v_DesTransac
          FROM GA_TRANSACABO
         WHERE NUM_TRANSACCION = VP_SECTRANSAC;

        utl_file.Put_Line(fh,'rao 1');
        IF v_CodRetorno <> 0 THEN
        utl_file.Put_Line(fh,'rao 2');
                p_TabAjuste.r_estado := 4;
                p_TabAjuste.r_obs_estado :=substr (v_DesTransac, 1, 50);
                RETURN FALSE;
        END IF;
        utl_file.Put_Line(fh,'rao 3');

        RETURN TRUE;

EXCEPTION
        WHEN OTHERS THEN
                p_TabAjuste.r_estado := 4;
                p_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;


/* ************************************************************************* */
/*       : realiza las consultas y generacion de la prfactura    */
/* ************************************************************************* */
FUNCTION fGeneraPrefactura  ( p_TabAjuste               IN OUT T_AJUSTES
                                                        , p_TabConcAjustes      IN OUT T_CONCAJUSTES
                                                        , VP_CODTIPDOCUM        IN PLS_INTEGER
                                                        , VP_CODREGION          IN VARCHAR2
                                                        , VP_CODPROVINCIA       IN VARCHAR2
                                                        , VP_CODCIUDAD          IN VARCHAR2
                                                        , VP_CODMONEDA          IN VARCHAR2
                                                        , VP_CODCATIMPOS        IN PLS_INTEGER
                                                        , VP_CODPLANCOM         IN PLS_INTEGER
                                                        , VP_CODMOVMISCEL       IN PLS_INTEGER
                                                        , VP_CODMODGENER        IN VARCHAR2
                                                        , VP_CODCATRIBUT        IN CHAR
                                                        , VP_SECNUMPROC         IN PLS_INTEGER
                                                        , VP_SECTRANSAC         IN PLS_INTEGER
) RETURN BOOLEAN IS

v_salida_proc   CHAR;
v_SeqTransac    PLS_INTEGER;

BEGIN
        vg_Modulo       := 'fGeneraPrefactura';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        p_TabAjuste.r_estado := 4;
        p_TabConcAjustes.r_cod_columna := 1; /* se fuerza un cod.concepto */
        IF fGrabaPrefactura ( VP_SECNUMPROC     , p_TabAjuste.r_cod_cliente
                                                , p_TabConcAjustes, VP_CODMONEDA
                                                , VP_CODREGION, VP_CODPROVINCIA
                                                , VP_CODCIUDAD, VP_CODPLANCOM
                                                , VP_CODCATIMPOS, p_TabAjuste.r_usuario)
        THEN
                IF fLeeSecuencia ('GA_SEQ_TRANSACABO', v_SeqTransac)
                THEN /*SECUENCIA DE TRANSAC. */
                        FA_INS_INTERFACT ( v_SeqTransac, VP_SECNUMPROC, 0
                                                         , VP_CODMODGENER, VP_CODMOVMISCEL
                                                         , VP_CODCATRIBUT, NULL , 100, 3
                                                         , TO_CHAR (p_TabAjuste.r_fec_vencimie,vg_FormatoFecha)
                                                         , v_salida_proc, 1, 0 , NULL
                                                         , NULL, VP_CODTIPDOCUM);

                        IF fValidaTransac(p_TabAjuste, v_SeqTransac)
                        THEN
                                p_TabAjuste.r_estado := 3; /* ok */
                        END IF;
                ELSE
                        p_TabAjuste.r_obs_estado := 'ERROR AL LEER SECUENCIA TRANSACABO ';
                        RETURN FALSE;
                END IF;
        ELSE
                p_TabAjuste.r_obs_estado := 'ERROR AL GRABAR PREFACTURA';
                RETURN FALSE;
        END IF;


        RETURN TRUE;
EXCEPTION
        WHEN OTHERS THEN
                p_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
                RETURN FALSE;
END;


/* ************************************************************************* */
/* fGrabaNCParcial : graba en FA_NCPRACIAL                                                                       */
/* ************************************************************************* */
FUNCTION fGrabaNCParcial ( p_TabAjuste          IN OUT T_AJUSTES
                                                 , VP_SECNCPARCIAL      IN PLS_INTEGER
                                                 , VP_INDORDENTOTAL     IN PLS_INTEGER
                                                 , VP_CODTIPDOCUM       IN PLS_INTEGER
                                                 , VP_CODCONCEPTO       IN PLS_INTEGER
                                                 , VP_COLUMNA           IN PLS_INTEGER
                                                 , VP_MONTO_DINERO      IN NUMBER
                                                 , VP_NUMPROCESO        IN PLS_INTEGER
) RETURN BOOLEAN IS
BEGIN
        vg_Modulo       := 'fGrabaNCParcial';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');
        utl_file.Put_Line(fh,'VP_SECNCPARCIAL : ['||VP_SECNCPARCIAL||']');
        utl_file.Put_Line(fh,'VP_INDORDENTOTAL : ['||VP_INDORDENTOTAL||']');
        utl_file.Put_Line(fh,'VP_CODTIPDOCUM : ['||VP_CODTIPDOCUM||']');
        utl_file.Put_Line(fh,'VP_CODCONCEPTO : ['||VP_CODCONCEPTO||']');
        utl_file.Put_Line(fh,'VP_COLUMNA : ['||VP_COLUMNA||']');
        utl_file.Put_Line(fh,'VP_MONTO_DINERO : ['||VP_MONTO_DINERO||']');
        utl_file.Put_Line(fh,'VP_NUMPROCESO : ['||VP_NUMPROCESO||']');

        INSERT
                INTO FA_NCPARCIAL (NUM_SECUENCIA
                                                  , COD_CLIENTE
                                                  , IND_ORDENTOTAL
                                                  , COD_TIPDOCUM
                                                  , COD_CONCEPTO
                                                  , COLUMNA
                                                  , IMP_CONCEPTO
                                                  , FLG_EMINC
                                                  , FEC_SOLICITUD
                                                  , NOM_USUARIO
                                                  , NUM_PROCESO)
                VALUES  ( VP_SECNCPARCIAL
                                , p_TabAjuste.r_cod_cliente
                                , VP_INDORDENTOTAL
                                , VP_CODTIPDOCUM
                                , VP_CODCONCEPTO
                                , VP_COLUMNA
                                , VP_MONTO_DINERO
                                , 0
                                , SYSDATE
                                , p_TabAjuste.r_usuario
                                , VP_NUMPROCESO);


        RETURN TRUE;
EXCEPTION
        WHEN OTHERS THEN
                p_TabAjuste.r_estado := 4;
                p_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;


/* ************************************************************************* */
/* fEjecutaNCPacial : graba en FA_NCPRACIAL                                                                      */
/* ************************************************************************* */
FUNCTION fEjecutaNCPacial ( p_TabAjuste         IN OUT T_AJUSTES
                                                  , VP_SECTRANSAC       IN PLS_INTEGER
                                                  , VP_SECNCEMISI       IN PLS_INTEGER
) RETURN BOOLEAN IS
BEGIN
        vg_Modulo       := 'fEjecutaNCPacial';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        FA_PRE_NOTACREDPARCIAL (VP_SECTRANSAC, VP_SECNCEMISI);

        RETURN fValidaTransac(p_TabAjuste, VP_SECTRANSAC);

EXCEPTION
        WHEN OTHERS THEN
                p_TabAjuste.r_estado := 4;
                p_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;


/* ************************************************************************* */
/* fConsultaMontos : Busca Montos para liquidar descuentos                   */
/* ************************************************************************* */
FUNCTION fConsultaMontos ( p_TabConcAjustes  IN T_CONCAJUSTES
                         , VP_INDORDENTOTAL  IN PLS_INTEGER
                         , VP_TOTFACTURABLE OUT NUMBER
                         , VP_TOTSALDO      OUT NUMBER ) RETURN BOOLEAN IS
v_tablaDocu     VARCHAR2(40);
v_tablaConc     VARCHAR2(40);
v_StrSql        VARCHAR2(3000);
v_Columna       PLS_INTEGER;
v_TotFacturable NUMBER;
v_TotSaldo      NUMBER;
v_CodtipDocum   PLS_INTEGER;
v_PrefFolio     VARCHAR2(10);
v_NumFolio      PLS_INTEGER;
v_CodCliente    PLS_INTEGER;
v_TipoTabla     CHAR(1);
v_CodCilcfact   PLS_INTEGER;
v_ExisteAjuste  PLS_INTEGER;
v_ExisteDescto  PLS_INTEGER;

BEGIN
    vg_Modulo := 'fConsultaMontos';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    SELECT COD_CICLFACT, TIPOTABLA
    INTO v_CodCilcfact, v_TipoTabla
    FROM (SELECT A.COD_CICLFACT, 'H' TIPOTABLA
          FROM FA_HISTDOCU A
          WHERE A.IND_ORDENTOTAL = VP_INDORDENTOTAL
            AND A.COD_TIPDOCUM <> 25
            AND A.IND_FACTUR != 0
          UNION ALL
          SELECT B.COD_CICLFACT, 'N'  TIPOTABLA
          FROM FA_FACTDOCU_NOCICLO B
          WHERE B.IND_ORDENTOTAL  = VP_INDORDENTOTAL
            AND B.NUM_FOLIO > 0
            AND B.IND_ANULADA = 0
            AND B.COD_TIPDOCUM <> 25
            AND B.IND_FACTUR != 0);


    IF v_TipoTabla = 'H' THEN /* HISTORICO  */
        v_tablaDocu := 'FA_HISTDOCU ';
    ELSE
        v_tablaDocu := 'FA_FACTDOCU_NOCICLO ';
    END IF;

    utl_file.Put_Line(fh,'v_tablaDocu : ['||v_tablaDocu||']');

    v_StrSql := 'SELECT COD_TIPDOCUM, PREF_PLAZA, NUM_FOLIO, COD_CLIENTE ';
    v_StrSql := v_StrSql || 'FROM '||v_tablaDocu;
    v_StrSql := v_StrSql || ' WHERE IND_ORDENTOTAL = :indordentotal ';

    utl_file.Put_Line(fh,'Query : ['||v_StrSql||']');

    EXECUTE IMMEDIATE v_StrSql
    INTO v_CodtipDocum, v_PrefFolio, v_NumFolio, v_CodCliente
    USING  VP_INDORDENTOTAL;

    v_tablaConc := '';
    IF v_TipoTabla = 'H' THEN /* HISTORICO  */
        SELECT FA_HISTCONC
        INTO v_tablaConc
        FROM FA_ENLACEHIST
        WHERE COD_CICLFACT = v_CodCilcfact;
    ELSE
        v_tablaConc := 'FA_FACTCONC_NOCICLO ';
    END IF;

    utl_file.Put_Line(fh,'v_tablaConc : ['||v_tablaConc||']');

    SELECT count(1)
    INTO v_ExisteAjuste
    FROM FA_AJUSTECONC A, GE_MONEDAS B
    WHERE A.PREF_PLAZA   = v_PrefFolio
      AND A.NUM_FOLIO    = v_NumFolio
      AND A.COD_CLIENTE  = v_CodCliente
      AND A.COD_MONEDA   = B.COD_MONEDA
      AND A.COD_TIPDOCUM = v_CodtipDocum
      AND A.COD_CONCEPTO = p_TabConcAjustes.r_cod_concepto
      AND A.COLUMNA      = p_TabConcAjustes.r_cod_columna;

    IF v_ExisteAjuste > 0 THEN
        v_StrSql := '';
        v_StrSql := v_StrSql || 'SELECT';
        v_StrSql := v_StrSql || ' (MIN(A.IMP_FACTURABLE)+NVL(SUM(CC.IMP_FACTURABLE),  0)) AS IMP_FACTURABLE,';
        v_StrSql := v_StrSql || ' DTOA(MIN(A.IMP_FACTURABLE-A.IMP_CONCEPTO)+NVL(SUM(CC.IMP_FACTURABLE-CC.IMP_CONCEPTO),0)) AS IMP_CONCEPTO';
        v_StrSql := v_StrSql || 'FROM FA_AJUSTECONC A,';
        v_StrSql := v_StrSql || ' GE_MONEDAS B,';
        v_StrSql := v_StrSql || ' (SELECT C.IMP_FACTURABLE,';
        v_StrSql := v_StrSql || ' C.IMP_CONCEPTO,';
        v_StrSql := v_StrSql || ' D.COD_CONCEREL,';
        v_StrSql := v_StrSql || ' D.COLUMNA_REL';
        v_StrSql := v_StrSql || ' FROM FA_AJUSTECONC C,';
        v_StrSql := v_StrSql || ' ' || v_tablaConc || ' D';
        v_StrSql := v_StrSql || ' WHERE C.COD_CONCEPTO=D.COD_CONCEPTO';
        v_StrSql := v_StrSql || ' AND C.COLUMNA=D.COLUMNA';
        v_StrSql := v_StrSql || ' AND C.COD_TIPCONCE=2';
        v_StrSql := v_StrSql || ' AND D.IND_ORDENTOTAL=:indordentotal';
        v_StrSql := v_StrSql || ' AND C.PREF_PLAZA=:prefplaza';
        v_StrSql := v_StrSql || ' AND C.NUM_FOLIO=:numfolio';
        v_StrSql := v_StrSql || ' AND C.COD_CLIENTE=:codcliente';
        v_StrSql := v_StrSql || ' AND C.COD_TIPDOCUM=:codtipdocum) CC ';
        v_StrSql := v_StrSql || 'WHERE A.PREF_PLAZA=:prefplaza';
        v_StrSql := v_StrSql || ' AND A.NUM_FOLIO=:numfolio';
        v_StrSql := v_StrSql || ' AND A.COD_CLIENTE=:codcliente';
        v_StrSql := v_StrSql || ' AND A.COD_MONEDA=B.COD_MONEDA';
        v_StrSql := v_StrSql || ' AND A.COD_TIPDOCUM=:codtipdocum';
        v_StrSql := v_StrSql || ' AND A.COD_TIPCONCE=3';
        v_StrSql := v_StrSql || ' AND A.COD_CONCEPTO=CC.COD_CONCEREL(+)';
        v_StrSql := v_StrSql || ' AND A.COLUMNA=CC.COLUMNA_REL(+)';
        v_StrSql := v_StrSql || ' AND A.COD_CONCEPTO=:codconcepto';
        v_StrSql := v_StrSql || ' AND A.COLUMNA=:columnarel';

        utl_file.Put_Line(fh,'v_StrSql : ['||v_StrSql||']');

        EXECUTE IMMEDIATE v_StrSql
        INTO  v_TotFacturable, v_TotSaldo
        USING  VP_INDORDENTOTAL
             , v_PrefFolio
             , v_NumFolio
             , v_CodCliente
             , v_CodtipDocum
             , v_PrefFolio
             , v_CodCliente
             , v_CodtipDocum
             , p_TabConcAjustes.r_cod_concepto
             , p_TabConcAjustes.r_cod_columna;
    ELSE
        v_StrSql := '';
        v_StrSql := v_StrSql || 'SELECT COUNT(1) ';
        v_StrSql := v_StrSql || 'FROM ' || v_tablaConc || ' ';
        v_StrSql := v_StrSql || 'WHERE IND_ORDENTOTAL = :indordentotal';
        v_StrSql := v_StrSql || '  AND COD_TIPCONCE = 2';
        v_StrSql := v_StrSql || '  AND COD_CONCEREL = :codconcepto';
        v_StrSql := v_StrSql || '  AND COLUMNA_REL = :columnarel';

        utl_file.Put_Line(fh,'v_StrSql : ['||v_StrSql||']');

        EXECUTE IMMEDIATE v_StrSql
        INTO  v_ExisteDescto
        USING  VP_INDORDENTOTAL
             , p_TabConcAjustes.r_cod_concepto
             , p_TabConcAjustes.r_cod_columna;

        IF (v_ExisteDescto > 0) THEN
            v_StrSql := '';
            v_StrSql := v_StrSql ||'SELECT  A.IMP_FACTURABLE - NVL(B.IMP_FACTURABLE,0), 0 ';
            v_StrSql := v_StrSql ||'FROM ' || v_tablaConc || ' A ,' || v_tablaConc || ' B ';
            v_StrSql := v_StrSql ||'WHERE A.IND_ORDENTOTAL = :indordentotal';
            v_StrSql := v_StrSql ||'  AND A.COD_TIPCONCE   <> 1';
            v_StrSql := v_StrSql ||'  AND (A.COD_TIPCONCE <> 2 OR (A.COD_TIPCONCE = 2 AND (A.COD_CONCEREL = 0 OR A.COD_CONCEREL IS NULL)))';
            v_StrSql := v_StrSql ||'  AND A.IND_ORDENTOTAL = B.IND_ORDENTOTAL';
            v_StrSql := v_StrSql ||'  AND A.COD_CONCEPTO = B.COD_CONCEREL';
            v_StrSql := v_StrSql ||'  AND A.COLUMNA = B.COLUMNA_REL';
            v_StrSql := v_StrSql ||'  AND B.COD_TIPCONCE = 2';
            v_StrSql := v_StrSql ||'  AND A.COD_CONCEPTO = :codconcepto';
            v_StrSql := v_StrSql ||'  AND A.COLUMNA = :columnarel';
        ELSE
            v_StrSql := '';
            v_StrSql := v_StrSql ||'SELECT  IMP_FACTURABLE , 0 ';
            v_StrSql := v_StrSql ||'FROM ' || v_tablaConc || ' ';
            v_StrSql := v_StrSql ||'WHERE IND_ORDENTOTAL = :indordentotal';
            v_StrSql := v_StrSql ||'  AND COD_TIPCONCE   <> 1';
            v_StrSql := v_StrSql ||'  AND (COD_TIPCONCE <> 2 OR (COD_TIPCONCE = 2 AND (COD_CONCEREL = 0 OR COD_CONCEREL IS NULL)))';
            v_StrSql := v_StrSql ||'  AND COD_CONCEPTO = :codconcepto';
            v_StrSql := v_StrSql ||'  AND COLUMNA = :columnarel';
        END IF;
        utl_file.Put_Line(fh,'v_StrSql : ['||v_StrSql||']');

        EXECUTE IMMEDIATE v_StrSql
        INTO v_TotFacturable, v_TotSaldo
        USING  VP_INDORDENTOTAL
             , p_TabConcAjustes.r_cod_concepto
             , p_TabConcAjustes.r_cod_columna;
    END IF;

    VP_TOTFACTURABLE  := v_TotFacturable;
    VP_TOTSALDO       := v_TotSaldo;

    RETURN TRUE;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;

END; /* FIN fConsultaMontos */


/* ************************************************************************* */
/* fBuscaEstructuraDeDescuento : Busca estructura de Descuentos              */
/* ************************************************************************* */
FUNCTION fBuscaEstructuraDeDescuento ( vp_IndOrdenTotal  IN PLS_INTEGER
                                     , vp_CodConcepto    IN PLS_INTEGER
                                     , vp_Columna        IN PLS_INTEGER
                                     , p_TabConcDesctos OUT TIPTABCONCDESCTOS
                                     , p_Cantidad       OUT PLS_INTEGER) RETURN BOOLEAN IS
v_tablaDocu     VARCHAR2(40);
v_tablaConc     VARCHAR2(40);
v_StrSql        VARCHAR2(2000);
v_Columna       PLS_INTEGER;
v_TotFacturable NUMBER;
v_TotSaldo      NUMBER;
v_CodtipDocum   PLS_INTEGER;
v_PrefFolio     VARCHAR2(10);
v_NumFolio      PLS_INTEGER;
v_CodCliente    PLS_INTEGER;
v_TipoTabla     CHAR(1);
v_CodCilcfact   PLS_INTEGER;
v_ExisteAjuste  PLS_INTEGER;
v_ExisteDescto  PLS_INTEGER;
X               PLS_INTEGER;
C_DESCTOS       TipoCursor;
Cur_Desctos     C_DESCTOS%TYPE;
c_CodConcepto   PLS_INTEGER;
c_Columna       PLS_INTEGER;
c_Impfacturable NUMBER;
c_FecValor      VARCHAR2(50);
BEGIN
    vg_Modulo := 'fBuscaEstructuraDeDescuento';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    SELECT COD_CICLFACT, TIPOTABLA
    INTO v_CodCilcfact, v_TipoTabla
    FROM (SELECT A.COD_CICLFACT, 'H' TIPOTABLA
          FROM FA_HISTDOCU A
          WHERE A.IND_ORDENTOTAL = vp_IndOrdenTotal
            AND A.COD_TIPDOCUM <> 25
            AND A.IND_FACTUR != 0
          UNION ALL
          SELECT B.COD_CICLFACT, 'N'  TIPOTABLA
          FROM FA_FACTDOCU_NOCICLO B
          WHERE B.IND_ORDENTOTAL  = vp_IndOrdenTotal
            AND B.NUM_FOLIO > 0
            AND B.IND_ANULADA = 0
            AND B.COD_TIPDOCUM <> 25
            AND B.IND_FACTUR != 0);


    IF v_TipoTabla = 'H' THEN /* HISTORICO  */
        v_tablaDocu := 'FA_HISTDOCU ';
    ELSE
        v_tablaDocu := 'FA_FACTDOCU_NOCICLO ';
    END IF;

    utl_file.Put_Line(fh,'v_tablaDocu : ['||v_tablaDocu||']');

    v_StrSql := 'SELECT COD_TIPDOCUM, PREF_PLAZA, NUM_FOLIO, COD_CLIENTE ';
    v_StrSql := v_StrSql || 'FROM '||v_tablaDocu;
    v_StrSql := v_StrSql || ' WHERE IND_ORDENTOTAL = :indordentotal ';

    utl_file.Put_Line(fh,'Query : ['||v_StrSql||']');

    EXECUTE IMMEDIATE v_StrSql
    INTO v_CodtipDocum, v_PrefFolio, v_NumFolio, v_CodCliente
    USING  vp_IndOrdenTotal;

    v_tablaConc := '';
    IF v_TipoTabla = 'H' THEN /* HISTORICO  */
        SELECT FA_HISTCONC
        INTO v_tablaConc
        FROM FA_ENLACEHIST
        WHERE COD_CICLFACT = v_CodCilcfact;
    ELSE
        v_tablaConc := 'FA_FACTCONC_NOCICLO ';
    END IF;

    utl_file.Put_Line(fh,'v_tablaConc : ['||v_tablaConc||']');

    SELECT COUNT(1)
    INTO v_ExisteAjuste
    FROM FA_AJUSTECONC A, GE_MONEDAS B
    WHERE A.PREF_PLAZA   = v_PrefFolio
      AND A.NUM_FOLIO    = v_NumFolio
      AND A.COD_CLIENTE  = v_CodCliente
      AND A.COD_MONEDA   = B.COD_MONEDA
      AND A.COD_TIPDOCUM = v_CodtipDocum
      AND A.COD_CONCEPTO = vp_CodConcepto
      AND A.COLUMNA      = vp_Columna;

    IF v_ExisteAjuste > 0 THEN
        p_Cantidad := 0;
    ELSE
        v_StrSql := '';
        v_StrSql := v_StrSql || 'SELECT B.COD_CONCEPTO COD_CONCEPTO,';
        v_StrSql := v_StrSql || '       A.COLUMNA COLUMNA,';
        v_StrSql := v_StrSql || '       B.IMP_FACTURABLE IMP_FACTURABLE,';
        v_StrSql := v_StrSql || '       TO_CHAR(A.FEC_VALOR,' || vg_FormatoFecha || ') FEC_VALOR ';
        v_StrSql := v_StrSql || 'FROM ' || v_tablaConc || ' A, FA_AJUSTECONC B ';
        v_StrSql := v_StrSql || 'WHERE A.COD_CONCEPTO   = B.COD_CONCEPTO';
        v_StrSql := v_StrSql || '  AND A.COLUMNA        = B.COLUMNA';
        v_StrSql := v_StrSql || '  AND A.COD_TIPCONCE   = 2';
        v_StrSql := v_StrSql || '  AND A.IND_ORDENTOTAL = ' || vp_IndOrdenTotal;
        v_StrSql := v_StrSql || '  AND A.COD_CONCEREL   = ' || vp_CodConcepto;
        v_StrSql := v_StrSql || '  AND A.COLUMNA_REL    = ' || vp_Columna;
        v_StrSql := v_StrSql || '  AND B.PREF_PLAZA     = ' || '''' || v_PrefFolio || '''';
        v_StrSql := v_StrSql || '  AND B.NUM_FOLIO      = ' || v_NumFolio;
        v_StrSql := v_StrSql || '  AND B.COD_CLIENTE    = ' || v_CodCliente;
        v_StrSql := v_StrSql || '  AND B.COD_TIPDOCUM   = ' || v_CodtipDocum;

        utl_file.Put_Line(fh,'v_StrSql : ['||v_StrSql||']');

        OPEN C_DESCTOS FOR v_StrSql;
        LOOP
            c_CodConcepto   := 0;
            c_Columna       := 0;
            c_Impfacturable := 0;
            c_FecValor      := '';
            FETCH C_DESCTOS INTO c_CodConcepto, c_Columna, c_Impfacturable, c_FecValor;
            EXIT WHEN C_DESCTOS%NOTFOUND;
            p_TabConcDesctos(X).r_cod_concepto := c_CodConcepto;
            p_TabConcDesctos(X).r_cod_columna  := c_Columna;
            p_TabConcDesctos(X).r_imp_factura  := c_Impfacturable;
            p_TabConcDesctos(X).r_fec_valor    := c_FecValor;
            X:=X +1;
        END LOOP;
        p_Cantidad := X;
        CLOSE C_DESCTOS;
    END IF;

    RETURN TRUE;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;

END; /* FIN fBuscaEstructuraDeDescuento */

/* ************************************************************************* */
/* fActualizaFaAjustes : actualiza los registros de Tabla FA_AJUSTES         */
/* ************************************************************************* */
FUNCTION fActualizaFaAjustes (TabAjuste       IN T_AJUSTES,
                              VP_COD_TIPDOCUM IN PLS_INTEGER) 
RETURN BOOLEAN IS
BEGIN
    vg_Modulo := 'fActualizaFaAjustes';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    UPDATE FA_AJUSTES
           SET COD_TIPOLOGIA       = TabAjuste.r_cod_tipologia,
               COD_AREAIMPUTABLE   = TabAjuste.r_cod_areaimputable,
               COD_AREASOLICITANTE = TabAjuste.r_cod_areasolicitantes
    WHERE PREF_PLAZA   = TabAjuste.r_pref_folio
    AND   NUM_FOLIO    = TabAjuste.r_num_folio
    AND   COD_CLIENTE  = TabAjuste.r_cod_cliente
    AND   COD_TIPDOCUM = VP_COD_TIPDOCUM;

    RETURN TRUE;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    RETURN FALSE;

END ;

/* ************************************************************************* */
/* fConsultaPlanCom : consulta Cod_Miscela                                   */
/* ************************************************************************* */
FUNCTION fConsultaCodMiscela ( vp_TabAjuste   IN OUT T_AJUSTES
                             , VP_CODMISCELA  OUT PLS_INTEGER
) RETURN BOOLEAN IS

BEGIN
        vg_Modulo       := 'fConsultaCodMiscela';
        utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

        SELECT COD_MISCELA
          INTO VP_CODMISCELA
        FROM FA_DATOSGENER;

        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := 'NO EXISTE COD_MISCELA ';
                RETURN FALSE;
        WHEN OTHERS THEN
                vp_TabAjuste.r_estado := 2;  /* NO OK */
                vp_TabAjuste.r_obs_estado := substr ('ERROR :['||SQLERRM ||']', 1, 50);
                RETURN FALSE;
END;

/* ************************************************************************* */
/*                           PROCEDIMIENTOS PUBILICOS                            */
/* ************************************************************************* */

/* ************************************************************************* */
/* FA_VALIDA_AJUSTES_PR : VALIDA LOS REGISTROS DE LA SOLICITUD DE AJUSTE         */
/* ************************************************************************* */
PROCEDURE FA_VALIDA_AJUSTES_PR  ( VP_NUMTRASAC   IN  PLS_INTEGER /* N° TRANSACCION */
                                , VP_IDE_AJUSTE  IN PLS_INTEGER /* IDENT. DE LA SOLICITUD */
                                , VP_ESTADO     OUT PLS_INTEGER /* RETORNO DE ESTADO */
) IS

v_DesTransac VARCHAR2(255);

ERROR_NCREDITO EXCEPTION;
ERROR_FMISCELANEA EXCEPTION;
ERROR_TRANSACCION EXCEPTION;
BEGIN
    szhPathDir:=' ';
    SELECT  VAL_CARACTER
    INTO    szhPathDir
    FROM    FAD_PARAMETROS
    WHERE   COD_MODULO = 'FA'
    AND     COD_PARAMETRO = 3;

    szhNombArchLog := 'AJUSTE_MASIVO_FA_VALIDA_AJUSTES_PR_' || to_char(SYSDATE,'YYYYMMDD') || '.log' ;
    szhModoOpen := 'w';
    fh := utl_file.fopen(szhPathDir,szhNombArchLog,szhModoOpen);

    utl_file.Put_Line(fh,'------------------------------------------------------');

    v_DesTransac := 'OK';
    vg_Modulo := 'FA_VALIDA_AJUSTES_PR.main';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    IF NOT VP_NUMTRASAC > 0 THEN /* VALIDA N° TRANSACCION */
        RAISE ERROR_TRANSACCION;
    END IF;

    VP_ESTADO := 0;
    IF NOT fLeeAjustes( VP_IDE_AJUSTE, TabAjustes, 0 ) THEN
        RAISE ERROR_NCREDITO;
    END IF;

    IF TabAjustes.COUNT > 0  THEN
        FOR j IN 1..TabAjustes.LAST LOOP
            IF TabAjustes(j).r_ind_tipdocum = 0 THEN
                IF NOT fValida_NotaCred(TabAjustes(j)) THEN
                    RAISE ERROR_NCREDITO;
                END IF;
            ELSE
                IF NOT fValida_FactMisc(TabAjustes(j)) THEN
                    RAISE ERROR_FMISCELANEA;
                END IF;
            END IF;

            IF fActualizaAjustes(TabAjustes(j)) THEN
               COMMIT;
            END IF;
        END LOOP;
    ELSE
        VP_ESTADO := 3;
        v_DesTransac := 'NO SE ENCONTRARON AJUSTES A VALIDAR';
    END IF;

    IF  NOT fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
        RAISE ERROR_TRANSACCION;
    END IF;

    COMMIT;
    utl_file.fclose(fh);

EXCEPTION
  WHEN ERROR_NCREDITO THEN
    VP_ESTADO := 1;
    v_DesTransac := 'ERROR EN VALIDACION N.CREDITO';
    IF NOT fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO ,v_DesTransac) THEN
        RAISE ERROR_TRANSACCION;
    END IF;
    utl_file.fclose(fh);
  WHEN ERROR_FMISCELANEA THEN
    VP_ESTADO := 2;
    v_DesTransac := 'ERROR EN VALIDACION F.MISCELANEA';
    IF NOT fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO ,v_DesTransac) THEN
        RAISE ERROR_TRANSACCION;
    END IF;
    utl_file.fclose(fh);
  WHEN ERROR_TRANSACCION THEN
    DBMS_OUTPUT.PUT_LINE('ERROR NUMERO DE TRANSACCION INCORRECTO ['||VP_NUMTRASAC||']');
    utl_file.Put_Line(fh,'ERROR NUMERO DE TRANSACCION INCORRECTO ['||VP_NUMTRASAC||']');
    VP_ESTADO := 3;
    utl_file.fclose(fh);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    utl_file.Put_Line(fh,'SQLERRM : ['||SQLERRM||']');
    VP_ESTADO := 3;
    v_DesTransac := 'SQLERRM : ['||SQLERRM||']';
    IF NOT  fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
        RAISE ERROR_TRANSACCION;
    END IF;
    utl_file.fclose(fh);
END;

/* ************************************************************************* */
/* FA_AJUSTE_FMISCELANEA_PR : GENERA LOS DATOS PARA LAS FACTURAS MISCELANEAS */
/* ************************************************************************* */
PROCEDURE FA_AJUSTE_FMISCELANEA_PR ( VP_NUMTRASAC     IN PLS_INTEGER  /* N° TRANSACCION         */
                                   , VP_IDE_AJUSTE    IN PLS_INTEGER  /* IDENT. DE LA SOLICITUD */
                                   , VP_COD_OFICINA   IN VARCHAR2     /* OF. USUARIO EMISOR     */
                                   , VP_COD_VENDEDOR  IN PLS_INTEGER  /* OF. USUARIO EMISOR     */
                                   , VP_CORR_MENSAJE  IN PLS_INTEGER  /* ID.                    */
                                   , VP_ESTADO       OUT PLS_INTEGER  /* RETORNO DE ESTADO      */
) IS
v_CodCaTribut   CHAR;
v_CodTipDocum   PLS_INTEGER;
v_CodMiscela    PLS_INTEGER;
v_CodCentrEmi   PLS_INTEGER;
v_SecMensajes   PLS_INTEGER;
v_CodCatImpos   PLS_INTEGER;
v_CodModGener   VARCHAR(3);
v_NumLineas     PLS_INTEGER;
v_CodRegion     VARCHAR(3);
v_CodProvincia  VARCHAR(5);
v_CodCiudad     VARCHAR(5);
v_CodMoneda     VARCHAR(3);
v_CodPlanCom    PLS_INTEGER;
v_MovMiscelanea PLS_INTEGER;
v_Letra         CHAR;
v_SeqNumProc    PLS_INTEGER;
v_SeqNumEmis    PLS_INTEGER;
v_DesTransac    VARCHAR2(255);

ERROR_FMISCELANEA EXCEPTION;
ERROR_TRANSACCION EXCEPTION;
BEGIN
    szhPathDir:=' ';
    SELECT  VAL_CARACTER
    INTO    szhPathDir
    FROM    FAD_PARAMETROS
    WHERE   COD_MODULO = 'FA'
    AND     COD_PARAMETRO = 3;

    szhNombArchLog := 'AJUSTE_MASIVO_FA_AJUSTE_FMISCELANEA_PR_' || to_char(SYSDATE,'YYYYMMDD') || '.log' ;
    szhModoOpen := 'w';
    fh := utl_file.fopen(szhPathDir,szhNombArchLog,szhModoOpen);

    utl_file.Put_Line(fh,'------------------------------------------------------');

    vg_Modulo   := 'FA_AJUSTE_FMISCELANEA_PR.main';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    IF NOT VP_NUMTRASAC > 0 THEN /* VALIDA N° TRANSACCION */
        RAISE ERROR_TRANSACCION;
    END IF;
    /* Obtiene el formato de fecha para PL */
    vg_FormatoFecha :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');

    v_DesTransac := 'OK';
    VP_ESTADO := 0;

    IF NOT fLeeAjustes( VP_IDE_AJUSTE, TabAjustes, 1 ) THEN
        RAISE ERROR_FMISCELANEA;
    END IF;

    IF NOT fConsultaLineas( 1,3, v_NumLineas) THEN
        RAISE ERROR_FMISCELANEA;
    END IF;

    IF NOT fConsultaMonedaFact ( v_CodMoneda ) THEN
        RAISE ERROR_FMISCELANEA;
    END IF;

    IF TabAjustes.COUNT > 0  THEN
        FOR j IN 1..TabAjustes.LAST LOOP
            IF fConsultaCatImposCliente(TabAjustes(j), v_CodCatImpos) THEN
                IF fConsultaCaTributClie(TabAjustes(j), v_CodCaTribut) THEN
                    IF fConsultaCodTipDocum(TabAjustes(j), v_CodCatImpos, v_CodCaTribut, v_CodTipDocum) THEN
                        IF fConsultaCentrEmisor( TabAjustes(j), v_CodTipDocum, VP_COD_OFICINA, v_CodCentrEmi) THEN --aqui DOC
                            IF fConsultaModGener( TabAjustes(j), v_CodCentrEmi, v_CodCaTribut, v_CodModGener, v_MovMiscelanea) THEN
                                IF fConsultaLetra ( TabAjustes(j), v_CodTipDocum, v_CodCatImpos, v_Letra) THEN --aqui DOC
                                    IF fLeeDetAjustes (TabAjustes(j).r_proceso, TabConcAjustes) THEN
                                        IF fConsultaDirecClie ( TabAjustes(j), v_CodRegion, v_CodProvincia, v_CodCiudad) THEN
                                            IF fConsultaPlanCom(TabAjustes(j), v_CodPlanCom) THEN
                                                IF fLeeSecuencia ('FA_SEQ_NUMPRO', v_SeqNumProc) THEN /*SEQ DE PROCESOS */
                                                    IF fLeeSecuencia ('FA_SEQ_CONTADO', v_SeqNumEmis) THEN /*SECUENCIA DE EMISION */
                                                       IF fConsultaCodMiscela(TabAjustes(j),v_CodMiscela) THEN /* OBTIENE COD_MISCELA */                                                       
                                                          IF fGrabaProceso ( v_SeqNumProc, v_CodMiscela
                                                                           , VP_COD_VENDEDOR, v_CodCentrEmi
                                                                           , TabAjustes(j).r_usuario
                                                                           , v_Letra, v_SeqNumEmis) THEN
                                                             utl_file.Put_Line(fh,'VP_CORR_MENSAJE : ['||VP_CORR_MENSAJE||']');
                                                             IF VP_CORR_MENSAJE IS NOT NULL AND NOT fGrabaMensaje ( v_SeqNumProc
                                                                                                                  , VP_CORR_MENSAJE
                                                                                                                  , v_NumLineas
                                                                                                                  , TabAjustes(j).r_usuario) THEN
                                                                 EXIT;
                                                             END IF;
                                                             FOR X IN 1..TabConcAjustes.LAST LOOP
                                                                 IF NOT fGeneraPrefactura ( TabAjustes(j)
                                                                                          , TabConcAjustes(x)
                                                                                          , v_CodTipDocum --v_CodMiscela
                                                                                          , v_CodRegion
                                                                                          , v_CodProvincia
                                                                                          , v_CodCiudad
                                                                                          , v_CodMoneda
                                                                                          , v_CodCatImpos
                                                                                          , v_CodPlanCom
                                                                                          , v_MovMiscelanea
                                                                                          , v_CodModGener
                                                                                          , v_CodCaTribut
                                                                                          , v_SeqNumProc
                                                                                          , v_SeqNumEmis) THEN
                                                                     EXIT;
                                                                 END IF;
                                                             END LOOP;
                                                             IF TabAjustes(j).r_estado = 3
                                                             THEN
                                                                 IF NOT fGrabaSecuenciaEmi ( v_CodTipDocum
                                                                                           , v_CodCentrEmi
                                                                                           , v_Letra
                                                                                           , v_SeqNumEmis) THEN
                                                                     TabAjustes(j).r_estado := 4;
                                                                     TabAjustes(j).r_obs_estado := 'ERROR AL GRABAR SECUENCIA EMISION';
                                                                 END IF;
                                                             ELSE
                                                                 TabAjustes(j).r_estado := 4;
                                                             END IF;
                                                         END IF;
                                                       END IF;
                                                     ---- FIN MODIFICACION    
                                                    END IF;
                                                END IF;
                                            END IF;
                                        END IF;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
            IF TabAjustes(j).r_estado = 3 THEN
                TabAjustes(j).r_num_proceso := v_SeqNumProc;
            ELSE
                TabAjustes(j).r_num_proceso := 0;
            END IF;
            IF fActualizaAjustes(TabAjustes(j)) THEN
               COMMIT;
            END IF;
        END LOOP;
    ELSE
        VP_ESTADO := 4;
        v_DesTransac := 'NO SE ENCONTRARON AJUSTES PARA APLICAR';
    END IF;

    IF  NOT fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
        RAISE ERROR_TRANSACCION;
    END IF;

    COMMIT;

EXCEPTION
  WHEN ERROR_TRANSACCION THEN
    DBMS_OUTPUT.PUT_LINE('Error Transaccion: ['||SQLERRM||']');
    utl_file.Put_Line(fh,'Error Transaccion: ['||SQLERRM||']');
  WHEN  ERROR_FMISCELANEA THEN
    VP_ESTADO := 2;
    v_DesTransac := SUBSTR('SQLERRM : ['||SQLERRM||']',1,255);
    IF NOT  fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
        RAISE ERROR_TRANSACCION;
    END IF;
    utl_file.fclose(fh);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ['||SQLERRM||']');
    utl_file.Put_Line(fh,'SQLERRM : ['||SQLERRM||']');
    VP_ESTADO := 3;
    v_DesTransac := SUBSTR('SQLERRM : ['||SQLERRM||']',1,255);
    IF NOT  fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
      RAISE ERROR_TRANSACCION;
    END IF;
    utl_file.fclose(fh);
END;

/* ************************************************************************* */
/* FA_AJUSTE_NCREDITO_PR : GENERA LOS DATOS PARA LAS NOTAS DE CREDITO            */
/* ************************************************************************* */
PROCEDURE FA_AJUSTE_NCREDITO_PR ( VP_NUMTRASAC     IN PLS_INTEGER /* N° TRANSACCION         */
                                , VP_IDE_AJUSTE    IN PLS_INTEGER /* IDENT. DE LA SOLICITUD */
                                , VP_COD_OFICINA   IN VARCHAR2    /* OF. USUARIO EMISOR     */
                                , VP_COD_VENDEDOR  IN PLS_INTEGER /* OF. USUARIO EMISOR     */
                                , VP_CORR_MENSAJE  IN PLS_INTEGER /* ID.                    */
                                , VP_ESTADO       OUT PLS_INTEGER /* RETORNO DE ESTADO      */
) IS

v_TipoTabla     CHAR;
v_IndOrdentotal PLS_INTEGER;
v_CiclFact      PLS_INTEGER;
v_NomTablaConc  CHAR;
v_IndSupertel   PLS_INTEGER;
v_CodModVenta   PLS_INTEGER;
v_IndRestNC     PLS_INTEGER;
v_CodTipDocum   PLS_INTEGER;

v_SeqProceso    PLS_INTEGER;
v_SeqTransac    PLS_INTEGER;
v_SeqNCParci    PLS_INTEGER;

v_NumLineas     PLS_INTEGER;
v_CodCatImpos   PLS_INTEGER;
v_DesTransac    VARCHAR2(255);
v_ManejoNC      PLS_INTEGER;
v_ImpSaldoAux   NUMBER;
v_ImpFactuAux   NUMBER;

TabConcAjusAux  TIPTABCONCAJUSTES;
TabConcDesctos  TIPTABCONCDESCTOS;
v_CantDescto    PLS_INTEGER;

ERROR_NCREDITO EXCEPTION;
ERROR_TRANSACCION EXCEPTION;
BEGIN
    szhPathDir:=' ';
    SELECT  VAL_CARACTER
    INTO    szhPathDir
    FROM    FAD_PARAMETROS
    WHERE   COD_MODULO = 'FA'
    AND     COD_PARAMETRO = 3;

    szhNombArchLog := 'AJUSTE_MASIVO_FA_AJUSTE_NCREDITO_PR_' || to_char(SYSDATE,'YYYYMMDD') || '.log' ;
    szhModoOpen    := 'w';
    fh             := utl_file.fopen(szhPathDir,szhNombArchLog,szhModoOpen);

    utl_file.Put_Line(fh,'------------------------------------------------------');

    vg_Modulo := 'FA_AJUSTE_NCREDITO_PR.main';
    utl_file.Put_Line(fh,'Modulo : ['||vg_Modulo||']');

    SELECT VAL_NUMERICO
    INTO v_ManejoNC
    FROM FAD_PARAMETROS
    WHERE COD_PARAMETRO = 209
      AND COD_MODULO    = 'FA';

    IF NOT VP_NUMTRASAC > 0 THEN /* VALIDA N° TRANSACCION */
        RAISE ERROR_TRANSACCION;
    END IF;
    v_DesTransac := 'OK';

    VP_ESTADO := 0;
    IF NOT fLeeAjustes( VP_IDE_AJUSTE, TabAjustes, 1 ) THEN
        RAISE ERROR_NCREDITO;
    END IF;

    IF NOT fConsultaLineas( 1,3, v_NumLineas) THEN
        RAISE ERROR_NCREDITO;
    END IF;

    IF TabAjustes.COUNT > 0  THEN
        FOR j IN 1..TabAjustes.LAST LOOP
            IF fConsultaDocumento ( TabAjustes(j)
                                  , v_TipoTabla
                                  , v_IndOrdentotal
                                  , v_CiclFact
                                  , v_IndSupertel
                                  , v_CodModVenta
                                  , v_IndRestNC
                                  , v_CodTipDocum) THEN
                IF fConsultaCatImposCliente(TabAjustes(j), v_CodCatImpos) THEN
                    IF fLeeSecuencia ('FA_SEQ_NUMPRO', v_SeqProceso) THEN /*SECUENCIA DE PROCESO */
                        IF fLeeSecuencia ('GA_SEQ_TRANSACABO', v_SeqTransac) THEN /*SECUENCIA DE TRANSAC. */
                            IF fLeeSecuencia ('FA_SEQ_NCPARCIAL', v_SeqNCParci) THEN /*SECUENCIA DE NC.PARCIAL */
                                IF VP_CORR_MENSAJE IS NOT NULL AND NOT (fGrabaMensaje ( v_SeqProceso
                                                                                      , VP_CORR_MENSAJE
                                                                                      , v_NumLineas
                                                                                      , TabAjustes(j).r_usuario)) THEN
                                    EXIT;
                                END IF;
                                IF fLeeDetAjustes (TabAjustes(j).r_proceso, TabConcAjustes) THEN
                                    IF TabConcAjustes.COUNT > 0 THEN
                                        FOR X IN 1..TabConcAjustes.LAST LOOP
                                            IF NOT fGrabaNCParcial  ( TabAjustes(j)
                                                                    , v_SeqNCParci
                                                                    , v_IndOrdentotal
                                                                    , v_CodTipDocum
                                                                    , TabConcAjustes(x).r_cod_concepto
                                                                    , TabConcAjustes(x).r_cod_columna
                                                                    , TabConcAjustes(x).r_monto_dinero
                                                                    , v_SeqProceso) THEN
                                                TabAjustes(j).r_estado := 4;
                                                EXIT;
                                            END IF;
                                            IF (v_ManejoNC = 1) THEN /* Se ingresan a la Nota de Crédito Parcial los descuentos si no exiete ningun valor más que ajustar */
                                                IF (fConsultaMontos (TabConcAjustes(x),v_IndOrdentotal, v_ImpFactuAux,v_ImpSaldoAux)) THEN
                                                    IF ((v_ImpFactuAux - (v_ImpSaldoAux + TabConcAjustes(x).r_monto_dinero)) = 0) THEN
                                                        IF fBuscaEstructuraDeDescuento ( v_IndOrdentotal
                                                                                       , TabConcAjustes(x).r_cod_concepto
                                                                                       , TabConcAjustes(x).r_cod_columna
                                                                                       , TabConcDesctos
                                                                                       , v_CantDescto) THEN
                                                            IF (v_CantDescto > 0) THEN
                                                                FOR z IN 1..TabConcDesctos.LAST LOOP
                                                                    IF NOT fGrabaNCParcial  ( TabAjustes(j)
                                                                                            , v_SeqNCParci
                                                                                            , v_IndOrdentotal
                                                                                            , v_CodTipDocum
                                                                                            , TabConcDesctos(x).r_cod_concepto
                                                                                            , TabConcDesctos(x).r_cod_columna
                                                                                            , TabConcDesctos(x).r_imp_factura
                                                                                            , v_SeqProceso) THEN
                                                                        TabAjustes(j).r_estado := 4;
                                                                        EXIT;
                                                                    END IF;
                                                                END LOOP;
                                                            END IF;
                                                        END IF;
                                                    END IF;
                                                END IF;
                                            END IF;
                                        END LOOP; /* LOOP DE CONCEPTOS */
                                        IF TabAjustes(j).r_estado <> 4
                                            AND fEjecutaNCPacial ( TabAjustes(j), v_SeqTransac, v_SeqNCParci)
                                        THEN
                                            TabAjustes(j).r_estado := 3; /* OK */
                                            /* P-MIX-09004 140268 */
                                            IF NOT fActualizaFaAjustes (TabAjustes(j),v_CodTipDocum)
                                            THEN
                                               TabAjustes(j).r_estado := 4; /* ERROR */
                                               TabAjustes(j).r_obs_estado := 'ERROR EN UPDATE FA_AJUSTES';                                               
                                               EXIT;
                                            END IF;                                          
                                            /* P-MIX-09004 140268 */
                                        END IF;
                                    ELSE
                                        TabAjustes(j).r_estado := 4;
                                        TabAjustes(j).r_obs_estado := 'ERROR NO EXISTEN CONCEPTOS';
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
            TabAjustes(j).r_num_proceso := v_SeqProceso;
            IF fActualizaAjustes(TabAjustes(j)) THEN
                COMMIT;
            END IF;
        END LOOP; /* LOOP DE DOCUMENTOS */
    ELSE
        VP_ESTADO := 4;
        v_DesTransac := 'NO SE ENCONTRARON AJUSTES';
    END IF;

    IF  NOT fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
        RAISE ERROR_TRANSACCION;
    END IF;

    COMMIT;
    utl_file.fclose(fh);
EXCEPTION
  WHEN ERROR_TRANSACCION THEN
    DBMS_OUTPUT.PUT_LINE('Error Transaccion: ['||SQLERRM||']');
    utl_file.Put_Line(fh,'Error Transaccion: ['||SQLERRM||']');
    utl_file.fclose(fh);
  WHEN  ERROR_NCREDITO  THEN
    VP_ESTADO := 2;
    v_DesTransac := 'ERROR EJECUCION AJUSTES NCREDITO';
    IF  NOT fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
      RAISE ERROR_TRANSACCION;
    END IF;
    utl_file.fclose(fh);
  WHEN OTHERS THEN
    v_DesTransac := SUBSTR('SQLERRM : ['||SQLERRM||']',1,255);
    VP_ESTADO := 3;
    v_DesTransac := 'SQLERRM : ['||SQLERRM||']';
    IF  NOT fGrabaTransac ( VP_NUMTRASAC,VP_ESTADO,v_DesTransac) THEN
      RAISE ERROR_TRANSACCION;
    END IF;
    utl_file.fclose(fh);
END;

END FA_AJUSTE_MASIVO_PG ;
/
SHOW ERRORS