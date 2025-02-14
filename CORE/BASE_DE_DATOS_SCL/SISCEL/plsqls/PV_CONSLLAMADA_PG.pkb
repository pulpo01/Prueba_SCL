create or replace
PACKAGE BODY                  PV_CONSLLAMADA_PG AS

 PROCEDURE PV_DETALLE_FACTURADO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                   EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                   EO_FEC_INI               IN              DATE,
                                   EO_FEC_TERM              IN              DATE,
                                   EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                   EO_CAMPO                 IN              VARCHAR2:=NULL,
                                   EO_TIPO_ORDEN            IN              VARCHAR2:=NULL,
                                   SO_Lista_Abonado         OUT NOCOPY      refCursor,
                                   SN_COD_RETORNO           OUT NOCOPY      ge_errores_pg.CodError,
                                   SV_MENS_RETORNO          OUT NOCOPY      ge_errores_pg.MsgError,
                                   SN_NUM_EVENTO            OUT NOCOPY      ge_errores_pg.Evento)

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="08-06-2009"
       Versión="PV_DETALLE_FACTURADO_PR"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
             <param nom="EO_COD_CICLO" Tipo="NUMERICO">CODIGO CICLO<param>>
             <param nom="EO_FEC_INI" Tipo="CARACTER">FECHA INICIO <param>>
             <param nom="EO_FEC_TERM"  Tipo="CARACTER">FECHA TERMINO<param>>
             <param nom="EO_USUARIO"  Tipo="CARACTER">USUARIO<param>>
             <param nom="EO_CAMPO"  Tipo="CARACTER">Campo por el cual se desea ordenar<param>>
             <param nom="EO_TIPO_ORDEN"  Tipo="CARACTER">Tipo de orden a realizar (ASC, DESC)<param>>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO DETALLE LLAMADAS<param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
IS

 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 LV_COD_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
 LV_NOM_TABLA    FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_NOM_TABLA2   FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_NOM_TABLA3   FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_COD_CLIENTE  GA_ABOCEL.COD_CLIENTE%TYPE;
 LV_ABONADO      GA_ABOCEL.NUM_ABONADO%TYPE;
 LV_DIGITOS      GED_PARAMETROS.VAL_PARAMETRO%TYPE;

 LV_COD_CICLFACT_NOCICLO FA_HISTDOCU.COD_CICLFACT%TYPE := '19010102'; --Código de Ciclo de facturación para documentos NO CICLO

 V_FORMATO_SEL19  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 V_FORMATO_SEL7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;

 LV_IMPUESTO     NUMBER;

 C_CURSOR REFCURSOR;

 LN_VALOR NUMBER;

 LO_NO_DATA EXCEPTION;
 LD_FEC_INI DATE;
 LD_FEC_TERM DATE;
 LS_FEC_INI VARCHAR2(50);
 LS_FEC_TERM VARCHAR2(50);

BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := NULL;
    SN_NUM_EVENTO   := 0;
    LV_ABONADO      := EO_NUM_ABONADO;
    V_FORMATO_SEL19 := GE_PAC_GENERAL.PARAM_GENERAL(CV_GSFORMATO19);
    V_FORMATO_SEL7  := GE_PAC_GENERAL.PARAM_GENERAL(CV_GSFORMATO7);
    LD_FEC_INI  := EO_FEC_INI;
    LD_FEC_TERM := EO_FEC_TERM;


    LV_SSQL :=' SELECT  COD_CLIENTE';
    LV_SSQL :=LV_SSQL ||' INTO  '||LV_COD_CLIENTE;
    LV_SSQL :=LV_SSQL ||' FROM  GA_ABOCEL';
    LV_SSQL :=LV_SSQL ||' WHERE NUM_ABONADO= '||LV_ABONADO;


    SELECT  COD_CLIENTE
    INTO  LV_COD_CLIENTE
    FROM  GA_ABOCEL
    WHERE NUM_ABONADO = LV_ABONADO;


    LV_IMPUESTO     :=FA_OBTENERIMPUESTO_FN(LV_COD_CLIENTE, EO_USUARIO);

    LV_SSQL :=' SELECT  TRIM(VAL_PARAMETRO)';
    LV_SSQL :=LV_SSQL ||' INTO '||LV_DIGITOS;
    LV_SSQL :=LV_SSQL ||' FROM GED_PARAMETROS';
    LV_SSQL :=LV_SSQL ||' WHERE NOM_PARAMETRO =''CANT_DIGITOS_VISTA''';


    SELECT  TRIM(VAL_PARAMETRO)
    INTO LV_DIGITOS
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='CANT_DIGITOS_VISTA';

    IF EO_COD_CICLFACT IS NOT NULL THEN
        LV_COD_CICLFACT := EO_COD_CICLFACT;
    ELSE
        LV_SSQL :=' SELECT  COD_CICLFACT';
        LV_SSQL :=LV_SSQL ||' INTO  '||LV_COD_CICLFACT;
        LV_SSQL :=LV_SSQL ||' FROM  FA_HISTDOCU';
        LV_SSQL :=LV_SSQL ||' WHERE NUM_FOLIO = ' || EO_NUM_FOLIO;
        LV_SSQL :=LV_SSQL ||' COD_CICLFACT <> ' || LV_COD_CICLFACT_NOCICLO;

        SELECT  COD_CICLFACT
        INTO  LV_COD_CICLFACT
        FROM  FA_HISTDOCU
        WHERE NUM_FOLIO = EO_NUM_FOLIO AND
              COD_CICLFACT <> LV_COD_CICLFACT_NOCICLO;
    END IF;

    IF (LD_FEC_INI IS NULL AND LD_FEC_TERM IS NULL) THEN --si ambas fechas son NULL
        LV_SSQL :='SELECT a.fec_desdellam, a.fec_hastallam';
        LV_SSQL :=LV_SSQL || ' FROM fa_ciclfact a';
        LV_SSQL :=LV_SSQL || ' WHERE a.cod_ciclfact = ' || LV_COD_CICLFACT;

        SELECT a.fec_desdellam, a.fec_hastallam
        INTO LD_FEC_INI, LD_FEC_TERM
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = LV_COD_CICLFACT;
    ELSIF (LD_FEC_INI IS NULL AND LD_FEC_TERM IS NOT NULL) THEN--si la fecha de inicio es nula y la de fin es no nula
        LV_SSQL :=' SELECT COUNT(1)';
        LV_SSQL :=LV_SSQL || ' FROM fa_ciclfact a';
        LV_SSQL :=LV_SSQL || ' WHERE a.cod_ciclfact = ' || LV_COD_CICLFACT || ' AND ';
        LV_SSQL :=LV_SSQL || LD_FEC_TERM || ' BETWEEN a.fec_desdellam AND a.fec_hastallam';

        SELECT COUNT(1)
        INTO LN_VALOR
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = LV_COD_CICLFACT AND
              LD_FEC_TERM BETWEEN a.fec_desdellam AND a.fec_hastallam;

        IF LN_VALOR=0 THEN
            RAISE LO_NO_DATA; --se genera exception
        END IF;

        SELECT a.fec_desdellam
        INTO LD_FEC_INI
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = LV_COD_CICLFACT;
    ELSIF (LD_FEC_INI IS NOT NULL AND LD_FEC_TERM IS NULL) THEN--si la fecha de inicio no es nula y la de fin es nula
        LV_SSQL :=' SELECT COUNT(1)';
        LV_SSQL :=LV_SSQL || ' FROM fa_ciclfact a';
        LV_SSQL :=LV_SSQL || ' WHERE a.cod_ciclfact = ' || LV_COD_CICLFACT || ' AND ';
        LV_SSQL :=LV_SSQL || LD_FEC_INI || ' BETWEEN a.fec_desdellam AND a.fec_hastallam';

        SELECT COUNT(1)
        INTO LN_VALOR
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = LV_COD_CICLFACT AND
              LD_FEC_INI BETWEEN a.fec_desdellam AND a.fec_hastallam;

        IF LN_VALOR=0 THEN
            RAISE LO_NO_DATA; --se genera exception
        END IF;

        SELECT a.fec_hastallam
        INTO LD_FEC_TERM
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = LV_COD_CICLFACT;
    ELSE --si ambas fechas son no nulas
        LV_SSQL :=' SELECT COUNT(1)';
        LV_SSQL :=LV_SSQL || ' FROM fa_ciclfact a';
        LV_SSQL :=LV_SSQL || ' WHERE a.cod_ciclfact = ' || LV_COD_CICLFACT || ' AND ';
        LV_SSQL :=LV_SSQL || LD_FEC_INI || ' BETWEEN a.fec_desdellam AND a.fec_hastallam AND ';
        LV_SSQL :=LV_SSQL || LD_FEC_TERM || ' BETWEEN a.fec_desdellam AND a.fec_hastallam';

        SELECT COUNT(1)
        INTO LN_VALOR
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = LV_COD_CICLFACT AND
              LD_FEC_INI BETWEEN a.fec_desdellam AND a.fec_hastallam AND
              LD_FEC_TERM BETWEEN a.fec_desdellam AND a.fec_hastallam;

        IF LN_VALOR=0 THEN
            RAISE LO_NO_DATA; --se genera exception
        END IF;
    END IF;

    LV_NOM_TABLA2   := 'FA_HISTCONC_' || LV_COD_CICLFACT;
    LV_NOM_TABLA3   := 'FA_HISTDOCU';

    LV_SSQL :=' SELECT a.FA_DETCELULAR';
    LV_SSQL :=LV_SSQL ||' INTO '||LV_NOM_TABLA;
    LV_SSQL :=LV_SSQL ||' FROM FA_ENLACEHIST a';
    LV_SSQL :=LV_SSQL ||' WHERE COD_CICLFACT = '||LV_COD_CICLFACT;

    SELECT a.FA_DETCELULAR
    INTO LV_NOM_TABLA
    FROM FA_ENLACEHIST a
    WHERE COD_CICLFACT = LV_COD_CICLFACT;

    LS_FEC_INI := TO_CHAR(LD_FEC_INI, 'DD-MM-YYYY HH24:MI:SS');
    LS_FEC_TERM := TO_CHAR(LD_FEC_TERM, 'DD-MM-YYYY HH24:MI:SS');

    LV_SSQL :=' SELECT';
    LV_SSQL :=LV_SSQL ||' C.NUM_FOLIO,';
    LV_SSQL :=LV_SSQL ||' TO_DATE(A.DATE_START_CHARG,''' || V_FORMATO_SEL19 || ''') AS FEC_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' TO_CHAR(TO_DATE(A.TIME_START_CHARG,''' || V_FORMATO_SEL7 || '''), ''' || V_FORMATO_SEL7 || ''') AS HORA_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' A.B_SUSC_NUMBER AS NUM_DESTINO,';
    LV_SSQL :=LV_SSQL ||' A.MTO_FACT AS MTO_LLAM_SIN_IMP,';
    LV_SSQL :=LV_SSQL ||' (A.MTO_FACT+ (A.MTO_FACT* (' || LV_IMPUESTO || '/100))) AS MTO_LLAM_CON_IMP,';
    LV_SSQL :=LV_SSQL ||' D.GLS_PARAM AS DES_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' A.DUR_FACT AS DUR_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' F.GLS_PARAM AS UNIDAD_LLAMADA';
    LV_SSQL :=LV_SSQL ||' FROM ' || LV_NOM_TABLA || ' A, ';
    --LV_SSQL :=LV_SSQL ||            LV_NOM_TABLA2 || ' B, ';
    LV_SSQL :=LV_SSQL ||            LV_NOM_TABLA3 || ' C,';
    LV_SSQL :=LV_SSQL ||'           SCH_CODIGOS D,';
    LV_SSQL :=LV_SSQL ||'           TOL_TIPOLLAM_TD E,';
    LV_SSQL :=LV_SSQL ||'           SCH_CODIGOS F';
    LV_SSQL :=LV_SSQL ||' WHERE';
    LV_SSQL :=LV_SSQL ||' A.NUM_CLIE          = ' || LV_COD_CLIENTE;
    LV_SSQL :=LV_SSQL ||' AND A.NUM_ABON      = ' || EO_NUM_ABONADO;
    LV_SSQL :=LV_SSQL ||' AND TO_DATE(A.DATE_START_CHARG,''' || V_FORMATO_SEL19 || ''')  BETWEEN TO_DATE(''' || LS_FEC_INI || ''',''DD-MM-YYYY HH24:MI:SS'') AND TO_DATE(''' || LS_FEC_TERM || ''',''DD-MM-YYYY HH24:MI:SS'')';
    LV_SSQL :=LV_SSQL ||'  AND A.COD_CARG      in ( select distinct B.COD_CONCEPTO from ' ||LV_NOM_TABLA2 || ' b where    B.IMP_CONCEPTO >0 AND B.NUM_ABONADO   = A.NUM_ABON)';
    LV_SSQL :=LV_SSQL ||'  AND C.IND_ORDENTOTAL in ( select distinct B.IND_ORDENTOTAL from ' ||LV_NOM_TABLA2 || ' b where  B.COD_CONCEPTO= A.COD_CARG  AND B.IMP_CONCEPTO >0 AND B.NUM_ABONADO   = A.NUM_ABON)';
    --LV_SSQL :=LV_SSQL ||' AND A.COD_CARG      = B.COD_CONCEPTO';
    --LV_SSQL :=LV_SSQL ||' AND B.NUM_ABONADO   = A.NUM_ABON';
    --LV_SSQL :=LV_SSQL ||' AND B.IMP_CONCEPTO >0';
    --LV_SSQL :=LV_SSQL ||' AND C.IND_ORDENTOTAL= B.IND_ORDENTOTAL';
    LV_SSQL :=LV_SSQL ||' AND C.COD_CLIENTE   = A.NUM_CLIE';
    LV_SSQL :=LV_SSQL ||' AND C.COD_CICLFACT  = A.COD_CICLFACT';
    LV_SSQL :=LV_SSQL ||' AND A.COD_LLAM      = D.COD_PARAM';
    LV_SSQL :=LV_SSQL ||' AND D.COD_TIPO      = ''CODLLAM''';
    LV_SSQL :=LV_SSQL ||' AND A.COD_SENT      = E.COD_SENTIDO';
    LV_SSQL :=LV_SSQL ||' AND A.COD_LLAM      = E.COD_LLAM';
    LV_SSQL :=LV_SSQL ||' AND SYSDATE BETWEEN E.FEC_INI_VIG AND E.FEC_TER_VIG';
    LV_SSQL :=LV_SSQL ||' AND E.COD_UNIDAD    = F.COD_PARAM';
    LV_SSQL :=LV_SSQL ||' AND F.COD_TIPO      = ''INDUNIDAD''';
    IF (EO_CAMPO IS NULL AND EO_TIPO_ORDEN IS NULL) THEN
        LV_SSQL :=LV_SSQL ||' ORDER BY A.DATE_START_CHARG, A.TIME_START_CHARG, A.COD_LLAM, C.NUM_FOLIO';
    ELSE
        LV_SSQL :=LV_SSQL ||' ORDER BY ' || EO_CAMPO || ', A.TIME_START_CHARG, A.COD_LLAM, C.NUM_FOLIO ' || EO_TIPO_ORDEN;
    END IF;

    OPEN  SO_Lista_Abonado FOR  LV_sSql;


EXCEPTION
                WHEN LO_NO_DATA THEN
                         SN_COD_RETORNO := 4;
                         SV_MENS_RETORNO := 'Las fechas de inicio y término ingresadas están fuera de rango para el ciclo de facturación correspondiente a la factura ingresada';

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR('|| EO_NUM_ABONADO  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_COD_CICLFACT  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_NUM_FOLIO  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_FEC_INI ||','|| EO_FEC_TERM||',' || EO_CAMPO || ',' || EO_TIPO_ORDEN || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO   ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, EO_USUARIO, 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

                WHEN NO_DATA_FOUND THEN
                         SN_COD_RETORNO := 4;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR('|| EO_NUM_ABONADO  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_COD_CICLFACT  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_NUM_FOLIO  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_FEC_INI ||','|| EO_FEC_TERM||',' || EO_CAMPO || ',' || EO_TIPO_ORDEN || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO   ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


                WHEN OTHERS THEN
                         SN_COD_RETORNO := 156;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR('|| EO_NUM_ABONADO  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_COD_CICLFACT  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_NUM_FOLIO  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_FEC_INI ||','|| EO_FEC_TERM||',' || EO_CAMPO || ',' || EO_TIPO_ORDEN || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO   ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, EO_USUARIO, 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );




END PV_DETALLE_FACTURADO_PR;

PROCEDURE PV_DETALLE_FACTURADO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                  EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                  EO_FEC_INI               IN              varchar2,
                                  EO_FEC_TERM              IN              varchar2,
                                  EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                  EO_CAMPO                 IN              VARCHAR2:=NULL,
                                  EO_TIPO_ORDEN            IN              VARCHAR2:=NULL,
                                  SO_Lista_Abonado         OUT NOCOPY      refCursor)


 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="08-06-2009"
       Versión="PV_DETALLE_FACTURADO_PR"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
             <param nom="EO_COD_CICLO" Tipo="NUMERICO">CODIGO CICLO<param>>
             <param nom="EO_FEC_INI" Tipo="CARACTER">FECHA INICIO <param>>
             <param nom="EO_FEC_TERM"  Tipo="CARACTER">FECHA TERMINO<param>>
             <param nom="EO_USUARIO"  Tipo="CARACTER">USUARIO<param>>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO DETALLE LLAMADAS<param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
IS

 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 SN_COD_RETORNO  ge_errores_pg.CodError;
 SV_MENS_RETORNO ge_errores_pg.MsgError;
 SN_NUM_EVENTO   ge_errores_pg.Evento;
 LD_FEC_INI      DATE;
 LD_FEC_TERM     DATE;

 ERROR_EJECUCION EXCEPTION;

BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := NULL;
    SN_NUM_EVENTO   := 0;

    LD_FEC_INI      :=TO_DATE(EO_FEC_INI,'DD-MM-YYYY HH24:MI:SS');
    LD_FEC_TERM     :=TO_DATE(EO_FEC_TERM,'DD-MM-YYYY HH24:MI:SS');

    LV_SSQL := 'PV_DETALLE_FACTURADO_PR (' || EO_NUM_ABONADO || ', ' ;
    LV_SSQL := LV_SSQL || EO_COD_CICLFACT || ', ';
    LV_SSQL := LV_SSQL || EO_NUM_FOLIO || ', ';
    LV_SSQL := LV_SSQL || LD_FEC_INI || ', ';
    LV_SSQL := LV_SSQL || LD_FEC_TERM || ', ';
    LV_SSQL := LV_SSQL || EO_USUARIO || ', ';
    LV_SSQL := LV_SSQL || 'SO_LISTA_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO)';

    PV_DETALLE_FACTURADO_PR (EO_NUM_ABONADO, EO_COD_CICLFACT, EO_NUM_FOLIO, LD_FEC_INI, LD_FEC_TERM, EO_USUARIO, EO_CAMPO, EO_TIPO_ORDEN, SO_LISTA_ABONADO, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO);

    IF SN_COD_RETORNO<>0 THEN
        RAISE ERROR_EJECUCION;
    END IF;

EXCEPTION
                WHEN ERROR_EJECUCION THEN
                         SN_COD_RETORNO := 156;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'POSVENTA: PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR('|| EO_NUM_ABONADO  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_COD_CICLFACT  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_NUM_FOLIO  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_FEC_INI ||','|| EO_FEC_TERM||',' || EO_CAMPO || ',' || EO_TIPO_ORDEN || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO   ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, EO_USUARIO, 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

                WHEN OTHERS THEN
                         SN_COD_RETORNO := 156;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'POSVENTA: PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR('|| EO_NUM_ABONADO  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_COD_CICLFACT  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_NUM_FOLIO  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_FEC_INI ||','|| EO_FEC_TERM||',' || EO_CAMPO || ',' || EO_TIPO_ORDEN || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO   ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, EO_USUARIO, 'PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_DETALLE_FACTURADO_PR;

PROCEDURE PV_CONVERSOR_MONEDA_PR(               EO_MONE_ORI              IN              GE_MONEDAS.COD_MONEDA%TYPE,
                                                EO_MONE_DES              IN              GE_MONEDAS.COD_MONEDA%TYPE,
                                                EO_MONTO                 IN              NUMBER,
                                                SO_VALOR_CALC            OUT NOCOPY      NUMBER,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento) IS

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="08-06-2009"
       Versión="PV_CONVERSOR_MONEDA_PR"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
             <param nom="EO_COD_CLIENTE Tipo="NUMERICO">CODIGO CLIENTE<param>>
             <param nom="EO_COD_CICLO" Tipo="NUMERICO">CODIGO CICLO<param>>
             <param nom="EO_FEC_INI" Tipo="CARACTER">FECHA INICIO <param>>
             <param nom="EO_FEC_TERM"  Tipo="CARACTER">FECHA TERMINO<param>>
             <param nom="EO_USUARIO"  Tipo="CARACTER">USUARIO<param>>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO DETALLE LLAMADAS<param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 LV_MONE_ORI     GE_MONEDAS.COD_MONEDA%TYPE;
 LV_MONE_DES     GE_MONEDAS.COD_MONEDA%TYPE;
BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := NULL;
    SN_NUM_EVENTO   := 0;
    LV_MONE_ORI     :=EO_MONE_ORI;
    LV_MONE_DES     :=EO_MONE_DES;

    LV_SSQL:='p_convertir_precio('|| LV_MONE_ORI ||','||LV_MONE_DES||','||EO_MONTO||','||SO_VALOR_CALC ||','|| SYSDATE ||')';
    p_convertir_precio(LV_MONE_ORI ,LV_MONE_DES,EO_MONTO,SO_VALOR_CALC ,SYSDATE);

EXCEPTION
                WHEN OTHERS THEN
                         SN_COD_RETORNO := 4;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_CONVERSOR_MONEDA_PR('|| EO_MONE_ORI ||','||EO_MONE_DES||','||EO_MONTO||','||SO_VALOR_CALC||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PV_CONSLLAMADA_PG.PV_CONVERSOR_MONEDA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


END PV_CONVERSOR_MONEDA_PR;


PROCEDURE PV_CONS_FACTURACLI_PR( EO_COD_CLIENTE            IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                                 EN_num_opcion             IN              NUMBER,
                                 SO_Lista_Abonado         OUT NOCOPY      refCursor)
IS

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versión="PV_CONS_FACTURACLI_PR"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_COD_CLIENTE" Tipo="NUMERICO">CODIGO CLIENTE<param>>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO DETALLE LLAMADAS<param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */


 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 SN_COD_RETORNO  ge_errores_pg.CodError;
 SV_MENS_RETORNO ge_errores_pg.MsgError;
 SN_NUM_EVENTO   ge_errores_pg.Evento;

 LV_ERRORCLASIF  VARCHAR2 (500) := 'No ha sido posible obtener las facturas del cliente';
 error_exception  EXCEPTION;
 LN_cantidad     NUMBER;
BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;


    IF EN_num_opcion = 1 THEN

        LV_sSql := ' SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio, ';
        LV_sSql := LV_sSql || 'DECODE(f.folio_cancelado, NULL, ''NO PAGADA'', ''PAGADA'') AS estado, f.cod_tipdocum, ';
        LV_sSql := LV_sSql || '  f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva, ';
        LV_sSql := LV_sSql || '  f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact ';
        LV_sSql := LV_sSql || ' FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio, ';
        LV_sSql := LV_sSql || ' b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum, ';
        LV_sSql := LV_sSql || ' a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva ,';
        LV_sSql := LV_sSql || ' a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact ';
        LV_sSql := LV_sSql || ' FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e ';
        LV_sSql := LV_sSql || ' WHERE a.cod_cliente = b.cod_cliente(+) AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum(+) AND ';
        LV_sSql := LV_sSql || ' a.num_folio = b.num_folio(+) AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = c.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = d.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' c.cod_tipdocummov = d.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' a.cod_ciclfact = e.cod_ciclfact AND ';
        LV_sSql := LV_sSql || ' a.cod_cliente = ' ||  EO_COD_CLIENTE || ' AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND ';
        LV_sSql := LV_sSql || ' a.cod_ciclfact <> ' || 19010102 ;
        LV_sSql := LV_sSql || ' ORDER BY a.fec_emision DESC) f ';

        SELECT  COUNT(*) INTO LN_cantidad
        FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                          b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                          a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                          a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
                    FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                    WHERE a.cod_cliente = b.cod_cliente(+) AND
                          a.cod_tipdocum = b.cod_tipdocum(+) AND
                          a.num_folio = b.num_folio(+) AND
                          a.cod_tipdocum = c.cod_tipdocum AND
                          a.cod_tipdocum = d.cod_tipdocum AND
                          c.cod_tipdocummov = d.cod_tipdocum AND
                          a.cod_ciclfact = e.cod_ciclfact AND
                          a.cod_cliente = EO_COD_CLIENTE AND
                          a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                          a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
                ORDER BY a.fec_emision DESC) f;

       IF LN_cantidad = 0 THEN
             RAISE error_exception;
       END IF;


      OPEN SO_Lista_Abonado FOR
        SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio,
           DECODE(f.folio_cancelado, NULL, 'NO PAGADA', 'PAGADA') AS estado, f.cod_tipdocum,
           f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva,
           f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact
        FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                          b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                          a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                          a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
                    FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                    WHERE a.cod_cliente = b.cod_cliente(+) AND
                          a.cod_tipdocum = b.cod_tipdocum(+) AND
                          a.num_folio = b.num_folio(+) AND
                          a.cod_tipdocum = c.cod_tipdocum AND
                          a.cod_tipdocum = d.cod_tipdocum AND
                          c.cod_tipdocummov = d.cod_tipdocum AND
                          a.cod_ciclfact = e.cod_ciclfact AND
                          a.cod_cliente = EO_COD_CLIENTE AND
                          a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                          a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
                ORDER BY a.fec_emision DESC) f;

    END IF;

    IF EN_num_opcion = 2 THEN

        LV_sSql := ' SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio, ';
        LV_sSql := LV_sSql || '''NO PAGADA'' AS estado, f.cod_tipdocum, ';
        LV_sSql := LV_sSql || '  f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva, ';
        LV_sSql := LV_sSql || '  f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact ';
        LV_sSql := LV_sSql || ' FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio, ';
        LV_sSql := LV_sSql || ' b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum, ';
        LV_sSql := LV_sSql || ' a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva ,';
        LV_sSql := LV_sSql || ' a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact ';
        LV_sSql := LV_sSql || ' FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e ';
        LV_sSql := LV_sSql || ' WHERE a.cod_cliente = b.cod_cliente(+) AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum(+) AND ';
        LV_sSql := LV_sSql || ' a.num_folio = b.num_folio(+) AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = c.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = d.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' c.cod_tipdocummov = d.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' a.cod_ciclfact = e.cod_ciclfact AND ';
        LV_sSql := LV_sSql || ' a.cod_cliente = ' ||  EO_COD_CLIENTE || ' AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND ';
        LV_sSql := LV_sSql || ' a.cod_ciclfact <> ' || 19010102 ;
        LV_sSql := LV_sSql || ' ORDER BY a.fec_emision DESC) f ';

        SELECT COUNT(*) INTO LN_cantidad
        FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                          b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                          a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                          a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
                    FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                    WHERE a.cod_cliente = b.cod_cliente(+) AND
                          a.cod_tipdocum = b.cod_tipdocum(+) AND
                          a.num_folio = b.num_folio(+) AND
                          a.cod_tipdocum = c.cod_tipdocum AND
                          a.cod_tipdocum = d.cod_tipdocum AND
                          c.cod_tipdocummov = d.cod_tipdocum AND
                          a.cod_ciclfact = e.cod_ciclfact AND
                          a.cod_cliente = EO_COD_CLIENTE AND
                          a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                          a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
                ORDER BY a.fec_emision DESC) f;

       IF LN_cantidad = 0 THEN
             RAISE error_exception;
       END IF;





      OPEN SO_Lista_Abonado FOR
        SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio,
           'NO PAGADA' AS estado, f.cod_tipdocum,
           f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva,
           f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact
        FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                          b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                          a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                          a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
                    FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                    WHERE a.cod_cliente = b.cod_cliente(+) AND
                          a.cod_tipdocum = b.cod_tipdocum(+) AND
                          a.num_folio = b.num_folio(+) AND
                          a.cod_tipdocum = c.cod_tipdocum AND
                          a.cod_tipdocum = d.cod_tipdocum AND
                          c.cod_tipdocummov = d.cod_tipdocum AND
                          a.cod_ciclfact = e.cod_ciclfact AND
                          a.cod_cliente = EO_COD_CLIENTE AND
                          a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                          a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
                ORDER BY a.fec_emision DESC) f;





    END IF;

    IF  EN_num_opcion = 3 THEN

        LV_sSql := ' SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio, ';
        LV_sSql := LV_sSql || '''PAGADA'' AS estado, f.cod_tipdocum, ';
        LV_sSql := LV_sSql || '  f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva, ';
        LV_sSql := LV_sSql || '  f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact ';
        LV_sSql := LV_sSql || ' FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,  ';
        LV_sSql := LV_sSql || ' b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum, ';
        LV_sSql := LV_sSql || ' a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva ,';
        LV_sSql := LV_sSql || ' a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact ';
        LV_sSql := LV_sSql || ' FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e';
        LV_sSql := LV_sSql || ' WHERE a.cod_cliente = b.cod_cliente AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' a.num_folio = b.num_folio AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = c.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum = d.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' c.cod_tipdocummov = d.cod_tipdocum AND ';
        LV_sSql := LV_sSql || ' a.cod_ciclfact = e.cod_ciclfact AND ';
        LV_sSql := LV_sSql || ' a.cod_cliente = ' ||  EO_COD_CLIENTE || ' AND ';
        LV_sSql := LV_sSql || ' a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND ';
        LV_sSql := LV_sSql || ' a.cod_ciclfact <> ' || 19010102 ;
        LV_sSql := LV_sSql || ' ORDER BY a.fec_emision DESC) f ';

        SELECT COUNT(*) INTO LN_cantidad
        FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                          b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                          a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                          a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
              FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
              WHERE a.cod_cliente = b.cod_cliente AND
                    a.cod_tipdocum = b.cod_tipdocum AND
                    a.num_folio = b.num_folio AND
                    a.cod_tipdocum = c.cod_tipdocum AND
                    a.cod_tipdocum = d.cod_tipdocum AND
                    c.cod_tipdocummov = d.cod_tipdocum AND
                    a.cod_ciclfact = e.cod_ciclfact AND
                    a.cod_cliente = EO_COD_CLIENTE AND
                    a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                    a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
             ORDER BY a.fec_emision DESC) f;

       IF LN_cantidad = 0 THEN
             RAISE error_exception;
       END IF;

      OPEN SO_Lista_Abonado FOR
      SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio,  'PAGADA' AS estado, f.cod_tipdocum,
             f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva,
             f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact
      FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                          b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                          a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                          a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
            FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
            WHERE a.cod_cliente = b.cod_cliente AND
                  a.cod_tipdocum = b.cod_tipdocum AND
                  a.num_folio = b.num_folio AND
                  a.cod_tipdocum = c.cod_tipdocum AND
                  a.cod_tipdocum = d.cod_tipdocum AND
                  c.cod_tipdocummov = d.cod_tipdocum AND
                  a.cod_ciclfact = e.cod_ciclfact AND
                  a.cod_cliente =  EO_COD_CLIENTE AND
                  a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                  a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
           ORDER BY a.fec_emision DESC) f;
    END IF;

    IF EN_num_opcion != 1  AND EN_num_opcion != 2 AND EN_num_opcion != 3 THEN
          RAISE error_exception;
    END IF;

    EXCEPTION
            WHEN error_exception THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  ' PV_CONS_FACTURACLI_PR ('||'); - ' || SQLERRM;
                SV_mens_retorno :=  LV_ERRORCLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_CONSLLAMADA_PG.PV_CONS_FACTURACLI_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_CONS_FACTURACLI_PR ('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  LV_ERRORCLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_CONSLLAMADA_PG.PV_CONS_FACTURACLI_PR ',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );



END PV_CONS_FACTURACLI_PR;



 PROCEDURE PV_RESUMEN_FACTURADO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                   EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                   EO_FEC_INI               IN              varchar2,
                                   EO_FEC_TERM              IN              varchar2,
                                   EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                   SO_Lista_Abonado         OUT NOCOPY      refCursor)

IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versión="PV_RESUMEN_FACTURADO_PR
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
             <param nom="EO_COD_CICLFACT "Tipo="NUMERICO">CODIGO CICLO<param>>
             <param nom=" EO_NUM_FOLIO "  Tipo="NUMERICO">NUMERO FOLIO<param>>
             <param nom="EO_FEC_INI" Tipo="CARACTER">FECHA INICIO <param>>
             <param nom="EO_FEC_TERM"  Tipo="CARACTER">FECHA TERMINO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */


 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 SN_COD_RETORNO  ge_errores_pg.CodError;
 SV_MENS_RETORNO ge_errores_pg.MsgError;
 SN_NUM_EVENTO   ge_errores_pg.Evento;

 LV_COD_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
 LV_NOM_TABLA    FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_NOM_TABLA2   FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_NOM_TABLA3   FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_COD_CLIENTE  GA_ABOCEL.COD_CLIENTE%TYPE;
 LV_ABONADO      GA_ABOCEL.NUM_ABONADO%TYPE;
 LV_DIGITOS      GED_PARAMETROS.VAL_PARAMETRO%TYPE;

 LV_COD_CICLFACT_NOCICLO FA_HISTDOCU.COD_CICLFACT%TYPE := '19010102'; --Código de Ciclo de facturación para documentos NO CICLO

 V_FORMATO_SEL19  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 V_FORMATO_SEL7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 LV_FEC_INI_AUX   VARCHAR2(10);
 LV_FEC_FIN_AUX   VARCHAR2(10);

 LV_IMPUESTO     NUMBER;



 LV_ERRORCLASIF  VARCHAR2 (500) := 'No ha sido posible obtener las facturas del cliente';
 error_exception  EXCEPTION;
 LN_cantidad     NUMBER;

BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

    /*LV_FEC_INI_AUX   :=to_CHAR(EO_FEC_INI,'dd-mm-yyyy');
    LV_FEC_FIN_AUX   :=to_CHAR(EO_FEC_TERM,'dd-mm-yyyy');*/
    
    LV_FEC_INI_AUX   :=EO_FEC_INI;
    LV_FEC_FIN_AUX   :=EO_FEC_TERM;


    LV_ABONADO      := EO_NUM_ABONADO;
    V_FORMATO_SEL19 := GE_PAC_GENERAL.PARAM_GENERAL(CV_GSFORMATO19);
    V_FORMATO_SEL7  := GE_PAC_GENERAL.PARAM_GENERAL(CV_GSFORMATO7);


    LV_SSQL :=' SELECT  COD_CLIENTE';
    LV_SSQL :=LV_SSQL ||' INTO  '||LV_COD_CLIENTE;
    LV_SSQL :=LV_SSQL ||' FROM  GA_ABOCEL';
    LV_SSQL :=LV_SSQL ||' WHERE NUM_ABONADO= '||LV_ABONADO;


    SELECT  COD_CLIENTE
    INTO  LV_COD_CLIENTE
    FROM  GA_ABOCEL
    WHERE NUM_ABONADO = LV_ABONADO;


    LV_IMPUESTO     :=FA_OBTENERIMPUESTO_FN(LV_COD_CLIENTE, EO_USUARIO);

    LV_SSQL :=' SELECT  TRIM(VAL_PARAMETRO)';
    LV_SSQL :=LV_SSQL ||' INTO '||LV_DIGITOS;
    LV_SSQL :=LV_SSQL ||' FROM GED_PARAMETROS';
    LV_SSQL :=LV_SSQL ||' WHERE NOM_PARAMETRO =''CANT_DIGITOS_VISTA''';


    SELECT  TRIM(VAL_PARAMETRO)
    INTO LV_DIGITOS
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='CANT_DIGITOS_VISTA';

    IF EO_COD_CICLFACT IS NOT NULL THEN
        LV_COD_CICLFACT := EO_COD_CICLFACT;
    ELSE
        LV_SSQL :=' SELECT  COD_CICLFACT';
        LV_SSQL :=LV_SSQL ||' INTO  '||LV_COD_CICLFACT;
        LV_SSQL :=LV_SSQL ||' FROM  FA_HISTDOCU';
        LV_SSQL :=LV_SSQL ||' WHERE NUM_FOLIO = ' || EO_NUM_FOLIO;
        LV_SSQL :=LV_SSQL ||' COD_CICLFACT <> ' || LV_COD_CICLFACT_NOCICLO;

        SELECT  COD_CICLFACT
        INTO  LV_COD_CICLFACT
        FROM  FA_HISTDOCU
        WHERE NUM_FOLIO = EO_NUM_FOLIO AND
              COD_CICLFACT <> LV_COD_CICLFACT_NOCICLO;
    END IF;

    LV_NOM_TABLA2   := 'FA_HISTCONC_' || LV_COD_CICLFACT;
    LV_NOM_TABLA3   := 'FA_HISTDOCU';

    LV_SSQL :=' SELECT a.FA_DETCELULAR';
    LV_SSQL :=LV_SSQL ||' INTO '||LV_NOM_TABLA;
    LV_SSQL :=LV_SSQL ||' FROM FA_ENLACEHIST a';
    LV_SSQL :=LV_SSQL ||' WHERE COD_CICLFACT = '||LV_COD_CICLFACT;

    SELECT a.FA_DETCELULAR
    INTO LV_NOM_TABLA
    FROM FA_ENLACEHIST a
    WHERE COD_CICLFACT = LV_COD_CICLFACT;

    LV_SSQL :=' SELECT   E.cod_unidad ,';
    LV_SSQL :=LV_SSQL ||' DECODE(E.cod_unidad, '||'''S'''||',' ||'''MINUTOS'''||','||'''Q'''||',' ||'''MENSAJES'''||',  '||'''K'''||','||'''KB'''||', A.cod_llam) cod_unidad,';
    LV_SSQL :=LV_SSQL ||' DECODE(E.cod_unidad,'||'''S'''||',SUM(a.dur_FACT)/60,SUM(a.dur_FACT)) dur_real, ';
    LV_SSQL :=LV_SSQL ||' a.cod_llam ';
    LV_SSQL :=LV_SSQL ||' FROM ' || LV_NOM_TABLA || ' A, ';
    --    LV_SSQL :=LV_SSQL ||            LV_NOM_TABLA2 || ' B, ';
    LV_SSQL :=LV_SSQL ||            LV_NOM_TABLA3 || ' C,';
    LV_SSQL :=LV_SSQL ||'           SCH_CODIGOS D,';
    LV_SSQL :=LV_SSQL ||'           TOL_TIPOLLAM_TD E,';
    LV_SSQL :=LV_SSQL ||'           SCH_CODIGOS F';
    LV_SSQL :=LV_SSQL ||' WHERE';
    LV_SSQL :=LV_SSQL ||' A.NUM_CLIE          = ' || LV_COD_CLIENTE;
    LV_SSQL :=LV_SSQL ||' AND A.NUM_ABON      = ' || EO_NUM_ABONADO;
    LV_SSQL :=LV_SSQL ||' AND TO_DATE(A.DATE_START_CHARG,''' || V_FORMATO_SEL19 || ''')  BETWEEN TO_DATE(''' || LV_FEC_INI_AUX || ''',''DD-MM-YYYY HH24:MI:SS'') AND TO_DATE(''' || LV_FEC_FIN_AUX || ''',''DD-MM-YYYY HH24:MI:SS'')';
    LV_SSQL :=LV_SSQL ||'  AND A.COD_CARG      in ( select distinct B.COD_CONCEPTO from ' ||LV_NOM_TABLA2 || ' b where    B.IMP_CONCEPTO >=0 AND B.NUM_ABONADO   = A.NUM_ABON)';
    LV_SSQL :=LV_SSQL ||'  AND C.IND_ORDENTOTAL in ( select distinct B.IND_ORDENTOTAL from ' ||LV_NOM_TABLA2 || ' b where  B.COD_CONCEPTO= A.COD_CARG  AND B.IMP_CONCEPTO >=0 AND B.NUM_ABONADO   = A.NUM_ABON)';
    LV_SSQL :=LV_SSQL ||' AND C.COD_CLIENTE   = A.NUM_CLIE';
    LV_SSQL :=LV_SSQL ||' AND C.COD_CICLFACT  = A.COD_CICLFACT';
    LV_SSQL :=LV_SSQL ||' AND A.COD_LLAM      = D.COD_PARAM';
    LV_SSQL :=LV_SSQL ||' AND D.COD_TIPO      = ''CODLLAM''';
    LV_SSQL :=LV_SSQL ||' AND A.COD_SENT      = E.COD_SENTIDO';
    LV_SSQL :=LV_SSQL ||' AND A.COD_LLAM      = E.COD_LLAM';
    LV_SSQL :=LV_SSQL ||' AND SYSDATE BETWEEN E.FEC_INI_VIG AND E.FEC_TER_VIG';
    LV_SSQL :=LV_SSQL ||' AND E.COD_UNIDAD    = F.COD_PARAM';
    LV_SSQL :=LV_SSQL ||' AND F.COD_TIPO      = ''INDUNIDAD''';
    LV_SSQL :=LV_SSQL ||' GROUP BY E.COD_UNIDAD,A.COD_LLAM';
    OPEN SO_Lista_Abonado FOR  LV_SSQL;



EXCEPTION
            WHEN error_exception THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  ' PV_RESUMEN_FACTURADO_PR ('||'); - ' || SQLERRM;
                SV_mens_retorno :=  LV_ERRORCLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_CONSLLAMADA_PG.PV_RESUMEN_FACTURADO_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_RESUMEN_FACTURADO_PR ('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  LV_ERRORCLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_CONSLLAMADA_PG.PV_RESUMEN_FACTURADO_PR ',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_RESUMEN_FACTURADO_PR;

 PROCEDURE PV_DETALLE_FACT_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EO_COD_CICLFACT          IN              FA_HISTDOCU.COD_CICLFACT%TYPE,
                                   EO_NUM_FOLIO             IN              FA_HISTDOCU.NUM_FOLIO%TYPE,
                                   EO_FEC_INI               IN              varchar2,
                                   EO_FEC_TERM              IN              varchar2,
                                   EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                   SO_Lista_Abonado         OUT NOCOPY      refCursor)

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="08-06-2009"
       Versión="PV_DETALLE_FACT_PR"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
             <param nom="EO_COD_CICLO" Tipo="NUMERICO">CODIGO CICLO<param>>
             <param nom="EO_FEC_INI" Tipo="CARACTER">FECHA INICIO <param>>
             <param nom="EO_FEC_TERM"  Tipo="CARACTER">FECHA TERMINO<param>>
             <param nom="EO_USUARIO"  Tipo="CARACTER">USUARIO<param>>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO DETALLE LLAMADAS<param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
IS

 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 LV_COD_CICLFACT FA_CICLFACT.COD_CICLFACT%TYPE;
 LV_NOM_TABLA    FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_NOM_TABLA2   FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_NOM_TABLA3   FA_ENLACEHIST.FA_DETCELULAR%TYPE;
 LV_COD_CLIENTE  GA_ABOCEL.COD_CLIENTE%TYPE;
 LV_ABONADO      GA_ABOCEL.NUM_ABONADO%TYPE;
 LV_DIGITOS      GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 SN_COD_RETORNO  ge_errores_pg.CodError;
 SV_MENS_RETORNO ge_errores_pg.MsgError;
 SN_NUM_EVENTO   ge_errores_pg.Evento;
 LV_COD_CICLFACT_NOCICLO FA_HISTDOCU.COD_CICLFACT%TYPE := '19010102'; --Código de Ciclo de facturación para documentos NO CICLO
 V_FORMATO_SEL19  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 V_FORMATO_SEL7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
 LV_IMPUESTO     NUMBER;
 LV_FEC_INI_AUX   VARCHAR2(10);
 LV_FEC_FIN_AUX   VARCHAR2(10);
 C_CURSOR REFCURSOR;

BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := NULL;
    SN_NUM_EVENTO   := 0;
    LV_ABONADO      := EO_NUM_ABONADO;
    V_FORMATO_SEL19 := GE_PAC_GENERAL.PARAM_GENERAL(CV_GSFORMATO19);
    V_FORMATO_SEL7  := GE_PAC_GENERAL.PARAM_GENERAL(CV_GSFORMATO7);


    /*LV_FEC_INI_AUX   :=to_CHAR(EO_FEC_INI,'dd-mm-yyyy');
    LV_FEC_FIN_AUX   :=to_CHAR(EO_FEC_TERM,'dd-mm-yyyy');*/
    
    LV_FEC_INI_AUX   :=EO_FEC_INI;
    LV_FEC_FIN_AUX   :=EO_FEC_TERM;

    LV_SSQL :=' SELECT  COD_CLIENTE';
    LV_SSQL :=LV_SSQL ||' INTO  '||LV_COD_CLIENTE;
    LV_SSQL :=LV_SSQL ||' FROM  GA_ABOCEL';
    LV_SSQL :=LV_SSQL ||' WHERE NUM_ABONADO= '||LV_ABONADO;


    SELECT  COD_CLIENTE
    INTO  LV_COD_CLIENTE
    FROM  GA_ABOCEL
    WHERE NUM_ABONADO = LV_ABONADO;


    LV_IMPUESTO     :=FA_OBTENERIMPUESTO_FN(LV_COD_CLIENTE, EO_USUARIO);

    LV_SSQL :=' SELECT  TRIM(VAL_PARAMETRO)';
    LV_SSQL :=LV_SSQL ||' INTO '||LV_DIGITOS;
    LV_SSQL :=LV_SSQL ||' FROM GED_PARAMETROS';
    LV_SSQL :=LV_SSQL ||' WHERE NOM_PARAMETRO =''CANT_DIGITOS_VISTA''';


    SELECT  TRIM(VAL_PARAMETRO)
    INTO LV_DIGITOS
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='CANT_DIGITOS_VISTA';

    IF EO_COD_CICLFACT IS NOT NULL THEN
        LV_COD_CICLFACT := EO_COD_CICLFACT;
    ELSE
        LV_SSQL :=' SELECT  COD_CICLFACT';
        LV_SSQL :=LV_SSQL ||' INTO  '||LV_COD_CICLFACT;
        LV_SSQL :=LV_SSQL ||' FROM  FA_HISTDOCU';
        LV_SSQL :=LV_SSQL ||' WHERE NUM_FOLIO = ' || EO_NUM_FOLIO;
        LV_SSQL :=LV_SSQL ||' COD_CICLFACT <> ' || LV_COD_CICLFACT_NOCICLO;

        SELECT  COD_CICLFACT
        INTO  LV_COD_CICLFACT
        FROM  FA_HISTDOCU
        WHERE NUM_FOLIO = EO_NUM_FOLIO AND
              COD_CICLFACT <> LV_COD_CICLFACT_NOCICLO;
    END IF;

    LV_NOM_TABLA2   := 'FA_HISTCONC_' || LV_COD_CICLFACT;
    LV_NOM_TABLA3   := 'FA_HISTDOCU';

    LV_SSQL :=' SELECT a.FA_DETCELULAR';
    LV_SSQL :=LV_SSQL ||' INTO '||LV_NOM_TABLA;
    LV_SSQL :=LV_SSQL ||' FROM FA_ENLACEHIST a';
    LV_SSQL :=LV_SSQL ||' WHERE COD_CICLFACT = '||LV_COD_CICLFACT;

    SELECT a.FA_DETCELULAR
    INTO LV_NOM_TABLA
    FROM FA_ENLACEHIST a
    WHERE COD_CICLFACT = LV_COD_CICLFACT;

    LV_SSQL :=' SELECT';
    LV_SSQL :=LV_SSQL ||' C.NUM_FOLIO,';
    LV_SSQL :=LV_SSQL ||' TO_DATE(A.DATE_START_CHARG,''' || V_FORMATO_SEL19 || ''') AS FEC_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' TO_CHAR(TO_DATE(A.TIME_START_CHARG,''' || V_FORMATO_SEL7 || '''), ''' || V_FORMATO_SEL7 || ''') AS HORA_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' A.B_SUSC_NUMBER AS NUM_DESTINO,';
    LV_SSQL :=LV_SSQL ||' A.MTO_FACT AS MTO_LLAM_SIN_IMP,';
    LV_SSQL :=LV_SSQL ||' (A.MTO_FACT+ (A.MTO_FACT* (' || LV_IMPUESTO || '/100))) AS MTO_LLAM_CON_IMP,';
    LV_SSQL :=LV_SSQL ||' D.GLS_PARAM AS DES_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' A.DUR_FACT AS DUR_LLAMADA,';
    LV_SSQL :=LV_SSQL ||' F.GLS_PARAM AS UNIDAD_LLAMADA';
    LV_SSQL :=LV_SSQL ||' FROM ' || LV_NOM_TABLA || ' A, ';
    --LV_SSQL :=LV_SSQL ||            LV_NOM_TABLA2 || ' B, ';
    LV_SSQL :=LV_SSQL ||            LV_NOM_TABLA3 || ' C,';
    LV_SSQL :=LV_SSQL ||'           SCH_CODIGOS D,';
    LV_SSQL :=LV_SSQL ||'           TOL_TIPOLLAM_TD E,';
    LV_SSQL :=LV_SSQL ||'           SCH_CODIGOS F';
    LV_SSQL :=LV_SSQL ||' WHERE';
    LV_SSQL :=LV_SSQL ||' A.NUM_CLIE          = ' || LV_COD_CLIENTE;
    LV_SSQL :=LV_SSQL ||' AND A.NUM_ABON      = ' || EO_NUM_ABONADO;
    LV_SSQL :=LV_SSQL ||' AND TO_DATE(A.DATE_START_CHARG,''' || V_FORMATO_SEL19 || ''')  BETWEEN TO_DATE(''' || LV_FEC_INI_AUX || ''',''DD-MM-YYYY HH24:MI:SS'') AND TO_DATE(''' ||   LV_FEC_FIN_AUX || ''',''DD-MM-YYYY HH24:MI:SS'')';
    LV_SSQL :=LV_SSQL ||'  AND A.COD_CARG      in ( select distinct B.COD_CONCEPTO from ' ||LV_NOM_TABLA2 || ' b where    B.IMP_CONCEPTO >=0 AND B.NUM_ABONADO   = A.NUM_ABON)';
    LV_SSQL :=LV_SSQL ||'  AND C.IND_ORDENTOTAL in ( select distinct B.IND_ORDENTOTAL from ' ||LV_NOM_TABLA2 || ' b where  B.COD_CONCEPTO= A.COD_CARG  AND B.IMP_CONCEPTO >=0 AND B.NUM_ABONADO   = A.NUM_ABON)';
    LV_SSQL :=LV_SSQL ||' AND C.COD_CLIENTE   = A.NUM_CLIE';
    LV_SSQL :=LV_SSQL ||' AND C.COD_CICLFACT  = A.COD_CICLFACT';
    LV_SSQL :=LV_SSQL ||' AND A.COD_LLAM      = D.COD_PARAM';
    LV_SSQL :=LV_SSQL ||' AND D.COD_TIPO      = ''CODLLAM''';
    LV_SSQL :=LV_SSQL ||' AND A.COD_SENT      = E.COD_SENTIDO';
    LV_SSQL :=LV_SSQL ||' AND A.COD_LLAM      = E.COD_LLAM';
    LV_SSQL :=LV_SSQL ||' AND SYSDATE BETWEEN E.FEC_INI_VIG AND E.FEC_TER_VIG';
    LV_SSQL :=LV_SSQL ||' AND E.COD_UNIDAD    = F.COD_PARAM';
    LV_SSQL :=LV_SSQL ||' AND F.COD_TIPO      = ''INDUNIDAD''';
    LV_SSQL :=LV_SSQL ||' ORDER BY A.DATE_START_CHARG, A.TIME_START_CHARG, A.COD_LLAM, C.NUM_FOLIO';

    OPEN  SO_Lista_Abonado FOR  LV_sSql;


EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         SN_COD_RETORNO := 4;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_DETALLE_FACT_PR('|| EO_NUM_ABONADO  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_COD_CICLFACT  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_NUM_FOLIO  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_FEC_INI ||','|| EO_FEC_TERM||',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO   ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PV_CONSLLAMADA_PG.PV_DETALLE_FACT_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


                WHEN OTHERS THEN
                         SN_COD_RETORNO := 156;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_DETALLE_FACT_PR('|| EO_NUM_ABONADO  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_COD_CICLFACT  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_NUM_FOLIO  ||',' ;
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_FEC_INI ||','|| EO_FEC_TERM||',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO   ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PV_CONSLLAMADA_PG.PV_DETALLE_FACT_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_DETALLE_FACT_PR;


PROCEDURE PV_IMPUESTO_PR(                       EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                                                EO_USUARIO               IN              GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                                SO_VALOR_CALC            OUT NOCOPY      NUMBER,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="08-06-2009"
       Versión="PV_DETALLE_FACT_PR"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
              <param nom="EO_COD_CLIENTE"  Tipo="NUMERICO">CODIGO CLIENTE<param>>
              <param nom="EO_USUARIO"  Tipo="CARACTER">USUARIO<param>>
          </Entrada>
          <Salida>
             <param nom=" SO_VALOR_CALC="NUMERICO">IMPUESTOparam>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */
IS
 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 LV_IMPUESTO     VARCHAR2(100);

BEGIN

    LV_SSQL  :='SO_VALOR_CALC :=FA_ObtenerImpuesto_FN('||EO_COD_CLIENTE||','||EO_USUARIO||')';
    LV_IMPUESTO :=FA_ObtenerImpuesto_FN(EO_COD_CLIENTE,EO_USUARIO);

    IF (TRIM(LV_IMPUESTO)= '' OR TRIM(LV_IMPUESTO) IS NULL) THEN
      LV_IMPUESTO:=0;
    END IF;



    SO_VALOR_CALC :=TO_NUMBER(LV_IMPUESTO);


EXCEPTION
  WHEN NO_DATA_FOUND THEN
                         SN_COD_RETORNO := 4;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_IMPUESTO_PR('|| EO_COD_CLIENTE  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO  ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PV_CONSLLAMADA_PG.PV_IMPUESTO_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


                WHEN OTHERS THEN
                         SN_COD_RETORNO := 156;
                         IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                         END IF;

                         LV_DES_ERROR   := 'PV_CONSLLAMADA_PG.PV_IMPUESTO_PR('|| EO_COD_CLIENTE  || ',';
                         LV_DES_ERROR   := LV_DES_ERROR ||   EO_USUARIO  ||')' ||SQLERRM;

                         SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PV_CONSLLAMADA_PG.PV_IMPUESTO_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );



END PV_IMPUESTO_PR;

END PV_CONSLLAMADA_PG; 
/
SHOW ERRORS