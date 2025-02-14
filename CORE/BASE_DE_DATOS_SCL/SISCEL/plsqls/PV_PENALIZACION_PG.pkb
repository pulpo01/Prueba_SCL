CREATE OR REPLACE PACKAGE BODY PV_PENALIZACION_PG
AS
---------------------------------------------------------------------------------------------------------
PROCEDURE PV_DATOS_PR(NUM_ABONADO      IN PV_PENALIZACION_TMP.NUM_ABONADO%type,
                      COD_CLIENTE      IN PV_PENALIZACION_TMP.COD_CLIENTE%type,
                      IND_MOVILFIJO    IN PV_PENALIZACION_TMP.IND_MOVILFIJO%type,
                      COD_PRESTACION   IN PV_PENALIZACION_TMP.COD_PRESTACION%type,
                      MTO_MINGARANTIZADO IN PV_PENALIZACION_TMP.MTO_MINGARANTIZADO%type,
                      FEC_FINCONTRA      IN PV_PENALIZACION_TMP.FEC_FINCONTRA%type,
                      FEC_ACEPVENTA      IN PV_PENALIZACION_TMP.FEC_ACEPVENTA%type,
                      NUM_CONTRATO       IN PV_PENALIZACION_TMP.NUM_CONTRATO%type,
                      NUM_ANEXO          IN PV_PENALIZACION_TMP.NUM_ANEXO%type,
                      COD_CUENTA         IN PV_PENALIZACION_TMP.COD_CUENTA%type,
                      COD_INDEMNIZACION  IN PV_PENALIZACION_TMP.COD_INDEMNIZACION%type,
                      FEC_ALTA           IN PV_PENALIZACION_TMP.FEC_ALTA%type,
                      FEC_PRORROGA       IN PV_PENALIZACION_TMP.FEC_PRORROGA%type,
                      FEC_RENOVACION     IN PV_PENALIZACION_TMP.FEC_RENOVACION%type,
                      DES_MESES          IN PV_PENALIZACION_TMP.DES_MESES%type,
                      IMP_CARGO          IN PV_PENALIZACION_TMP.IMP_CARGO%type,
                      MTO_CARGO          IN PV_PENALIZACION_TMP.MTO_CARGO%type,
                      DES_ARTICULO       IN PV_PENALIZACION_TMP.DES_ARTICULO%type,
                      NOM_CLIENTE        IN PV_PENALIZACION_TMP.NOM_CLIENTE%type,
                      NOM_APECLIEN1      IN PV_PENALIZACION_TMP.NOM_APECLIEN1%type,
                      NOM_APECLIEN2      IN PV_PENALIZACION_TMP.NOM_APECLIEN2%type,
                      COD_TIPCONTRATO    IN PV_PENALIZACION_TMP.COD_TIPCONTRATO%type,
                      DES_TIPCONTRATO    IN PV_PENALIZACION_TMP.DES_TIPCONTRATO%type,
                      MESES_MINIMO       IN PV_PENALIZACION_TMP.MESES_MINIMO%type,
                      IMP_CARGOBASICO    IN PV_PENALIZACION_TMP.IMP_CARGOBASICO%type,
                      COD_PLANTARIF      IN PV_PENALIZACION_TMP.COD_PLANTARIF%type,
                      DES_PLANTARIF      IN PV_PENALIZACION_TMP.DES_PLANTARIF%type,
                      PEN_TERMINAL       IN PV_PENALIZACION_TMP.PEN_TERMINAL%type,
                      PEN_CARGOBASICO    IN PV_PENALIZACION_TMP.PEN_CARGOBASICO%type,
                      PEN_EQUIPO         IN PV_PENALIZACION_TMP.PEN_EQUIPO%type,
                      IMP_PENALIZA       IN PV_PENALIZACION_TMP.IMP_PENALIZA%type,
                      IMP_TRAFICO        IN PV_PENALIZACION_TMP.IMP_TRAFICO%type,
                      IMP_CUOTAS         IN PV_PENALIZACION_TMP.IMP_CUOTAS%type,
                      COD_ERROR          IN PV_PENALIZACION_TMP.COD_ERROR%type,
                      DESCRIPCION_ERROR  IN PV_PENALIZACION_TMP.DESCRIPCION_ERROR%type,
                      NUM_CELULAR        IN PV_PENALIZACION_TMP.NUM_CELULAR%type,
                      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                      SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                      SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
                      
IS
/*--
        <Documentacion TipoDoc = "PROCEDURE">
            Elemento Nombre = "PV_DATOS_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
            Inserta los datos en QT del abonado
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
 lv_des_error      ge_errores_pg.DesEvent;
 lv_sSql           ge_errores_pg.vQuery;
BEGIN
 SN_num_evento:= 0;
 SN_cod_retorno:=0;
 SV_mens_retorno:='';

  lv_sSql:='INSERT  INTO PV_PENALIZACION_TMP';

  INSERT  INTO PV_PENALIZACION_TMP
  ( NUM_ABONADO,
    COD_CLIENTE,
    NUM_CELULAR,
    IND_MOVILFIJO,
    COD_PRESTACION,
    MTO_MINGARANTIZADO,
    FEC_FINCONTRA,
    FEC_ACEPVENTA,
    NUM_CONTRATO,
    NUM_ANEXO,
    COD_CUENTA,
    COD_INDEMNIZACION,
    FEC_ALTA,
    FEC_PRORROGA,
    FEC_RENOVACION,
    DES_MESES,
    IMP_CARGO,
    MTO_CARGO,
    DES_ARTICULO,
    NOM_CLIENTE,
    NOM_APECLIEN1,
    NOM_APECLIEN2,
    COD_TIPCONTRATO,
    DES_TIPCONTRATO,
    MESES_MINIMO,
    IMP_CARGOBASICO,
    COD_PLANTARIF,
    DES_PLANTARIF,
    PEN_TERMINAL,
    PEN_CARGOBASICO,
    PEN_EQUIPO,
    IMP_PENALIZA,
    IMP_TRAFICO,
    IMP_CUOTAS,
    COD_ERROR,
    DESCRIPCION_ERROR)
   VALUES (NUM_ABONADO,
    COD_CLIENTE,
    NUM_CELULAR,
    IND_MOVILFIJO,
    COD_PRESTACION,
    MTO_MINGARANTIZADO,
    FEC_FINCONTRA,
    FEC_ACEPVENTA,
    NUM_CONTRATO,
    NUM_ANEXO,
    COD_CUENTA,
    COD_INDEMNIZACION,
    FEC_ALTA,
    FEC_PRORROGA,
    FEC_RENOVACION,
    DES_MESES,
    IMP_CARGO,
    MTO_CARGO,
    DES_ARTICULO,
    NOM_CLIENTE,
    NOM_APECLIEN1,
    NOM_APECLIEN2,
    COD_TIPCONTRATO,
    DES_TIPCONTRATO,
    MESES_MINIMO,
    IMP_CARGOBASICO,
    COD_PLANTARIF,
    DES_PLANTARIF,
    PEN_TERMINAL,
    PEN_CARGOBASICO,
    PEN_EQUIPO,
    IMP_PENALIZA,
    IMP_TRAFICO,
    IMP_CUOTAS,
    COD_ERROR,
    DESCRIPCION_ERROR);

EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno:=4;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_ERROR_NO_CLASIF;
        END IF;
        LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_DATOS_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
        SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'PV_PENALIZACION_PG.PV_DATOSQT_PR', lv_sSql, SN_cod_retorno, LV_des_error );

END;
---------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENERTOTCANCUOTAS_FN(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                                   EN_num_abonado    IN ga_abocel.num_abonado%type,
                                   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = "function">
            Elemento Nombre = "PV_OBTENERTOTCANCUOTAS_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            Obtiene Total cancelado por cliente/abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> n+mero del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> n+mero delo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_importe_debe   co_cancelados.importe_debe%type;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

      lv_sSql := 'SELECT SUM(co.importe_debe) ';
      lv_sSql := lv_sSql || ' FROM co_cancelados co';
      lv_sSql := lv_sSql || ' WHERE co.cod_cliente = '|| EN_cod_cliente;
      lv_sSql := lv_sSql || '  AND co.num_abonado  ='|| EN_num_abonado;
      lv_sSql := lv_sSql || '  AND co.sec_cuota    > 0';
      lv_sSql := lv_sSql || '  AND co.ind_facturado=1';

      BEGIN
       SELECT SUM(co.importe_debe)
       INTO ln_importe_debe
       FROM co_cancelados co
       WHERE co.cod_cliente =EN_cod_cliente
        AND co.num_abonado  =EN_num_abonado
        AND co.sec_cuota    > 0
        AND co.ind_facturado=1;

      EXCEPTION
       WHEN NO_DATA_FOUND THEN
         ln_importe_debe:=0;
      END;

      return ln_importe_debe;

     EXCEPTION
      WHEN OTHERS THEN
       SN_cod_retorno:=4;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
       END IF;
       LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERTOTCANCUOTAS_FN('|| EN_cod_cliente || ',' || EN_num_abonado || '); - '||  SQLERRM,1,CN_LARGOERRTEC);
       SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
       SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
       'PV_PENALIZACION_PG.PV_OBTENERTOTCANCUOTAS_FN', lv_sSql, SN_cod_retorno, LV_des_error );
       return 0;
END;
---------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENERCICLO_FN(SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN VARCHAR2 IS

/*--
        <Documentacion TipoDoc = "Function">
            Elemento Nombre = "PV_OBTENERCICLO_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  VARCHAR2 </Retorno>
        <Descripcion>
            retornar ciclo abonado
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
PARAM_NO_CONFIG   EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_cod_ciclfact   fa_ciclfact.cod_ciclfact%type;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        lv_sSql := 'SELECT fa.cod_ciclfact';
        lv_sSql := lv_sSql || ' FROM fa_ciclfact fa';
        lv_sSql := lv_sSql || ' WHERE fa.cod_ciclo = '|| rec.cod_ciclo;
        lv_sSql := lv_sSql || ' AND SYSDATE BETWEEN fa.fec_desdeocargos AND fa.fec_hastaocargos';

        SELECT fa.cod_ciclfact
        INTO lv_cod_ciclfact
        FROM fa_ciclfact fa
        WHERE fa.cod_ciclo = rec.cod_ciclo
        AND SYSDATE BETWEEN fa.fec_desdeocargos AND fa.fec_hastaocargos;

        RETURN lv_cod_ciclfact;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCICLO_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERCICLO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN '';
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCICLO_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERCICLO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN '';
END;
---------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENERVPN_FN(EN_num_abonado    IN  ga_abocel.num_abonado%type,
                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = ""Function>
            Elemento Nombre = "PV_OBTENERVPN_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            MONTO TARIFARIO VPN
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"     Tipo="NUMBER"> codigo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
PARAM_NO_CONFIG   EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
ln_imp_tarifa     ga_tarifas.imp_tarifa%type;
LN_COD_CLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
ln_cantidad       INTEGER;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


         /*lv_sSql := 'SELECT SUM(NVL(ga.imp_tarifa,0)) ';
         lv_sSql := lv_sSql || ' FROM  ga_tarifas ga ';
         lv_sSql := lv_sSql || ' WHERE ga.cod_producto = 1 ';
         lv_sSql := lv_sSql || ' AND ga.cod_servicio in (SELECT cod_servicio FROM  ga_servsuplabo a';
         lv_sSql := lv_sSql || ' WHERE a.num_abonado =' || EN_num_abonado;
         lv_sSql := lv_sSql || ' AND a.cod_servicio in (SELECT v.valor FROM  GE_VALORES_DOMINIOS_VW v';
         lv_sSql := lv_sSql || '                        WHERE v.COD_DOMINIO  = ' || CV_CLIENTEVPN || ')';
         lv_sSql := lv_sSql || ' AND a.ind_estado = 2)';
         lv_sSql := lv_sSql || ' AND ga.cod_planserv = ' || rec.cod_planserv;
         lv_sSql := lv_sSql || ' AND SYSDATE BETWEEN ga.fec_desde and ga.fec_hasta';

         SELECT SUM(NVL(ga.imp_tarifa,0))
         INTO  ln_imp_tarifa
         FROM  ga_tarifas ga
         WHERE ga.cod_producto = 1
         AND ga.cod_servicio in (SELECT cod_servicio FROM  ga_servsuplabo a
         WHERE a.num_abonado = EN_num_abonado
         AND a.cod_servicio in (SELECT v.valor FROM  GE_VALORES_DOMINIOS_VW v
                                WHERE v.COD_DOMINIO  = CV_CLIENTEVPN)
         AND a.ind_estado = 2)
         AND ga.cod_planserv = rec.cod_planserv
         AND SYSDATE BETWEEN ga.fec_desde and ga.fec_hasta;*/

         --OCB INI PENALIZA

         SELECT  COD_CLIENTE 
         INTO LN_COD_CLIENTE FROM GA_ABOCEL
         WHERE NUM_ABONADO = EN_num_abonado
         UNION
         SELECT  COD_CLIENTE FROM GA_ABOAMIST
         WHERE NUM_ABONADO = EN_num_abonado;
         

         SELECT count(1) into ln_cantidad
         from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
         WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
         AND   UPPER(B.DES_PROD_OFERTADO) LIKE '%RPV%'
         AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
         AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
         AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA;
 
         IF ln_cantidad > 0 THEN
         
                  lv_sSql := ' SELECT SUM(cargos.monto_importe) INTO ln_imp_tarifa';
                  lv_sSql := lv_sSql || ' FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
                  lv_sSql := lv_sSql || '        pf_conceptos_prod_td concepto';
                  lv_sSql := lv_sSql || ' WHERE  catalogo.cod_concepto      = concepto.cod_concepto';
                  lv_sSql := lv_sSql || ' AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
                  lv_sSql := lv_sSql || ' AND      catalogo.cod_cargo         = cargos.cod_cargo';
                  lv_sSql := lv_sSql || ' AND      catalogo.cod_prod_ofertado IN (  SELECT B.COD_PROD_OFERTADO';
                  lv_sSql := lv_sSql || '                                           from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B';
                  lv_sSql := lv_sSql || '                                           WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO';
                  lv_sSql := lv_sSql || '                                           AND   UPPER(B.DES_PROD_OFERTADO) LIKE %RPV%';
                  lv_sSql := lv_sSql || '                                           AND   A.COD_CLIENTE_BENEFICIARIO='||LN_COD_CLIENTE;
                  lv_sSql := lv_sSql || '                                           AND   A.NUM_ABONADO_BENEFICIARIO='||EN_num_abonado;
                  lv_sSql := lv_sSql || '                                           AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)';
                  lv_sSql := lv_sSql || ' AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia ';
                  lv_sSql := lv_sSql || ' AND        concepto.tipo_cargo = R';
         
                  SELECT nvl(SUM(cargos.monto_importe*conv.cambio),0) INTO ln_imp_tarifa
                  FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
                         pf_conceptos_prod_td concepto, ge_conversion conv
                  WHERE  catalogo.cod_concepto        = concepto.cod_concepto
                  AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
                  AND      catalogo.cod_cargo         = cargos.cod_cargo
                  AND      conv.cod_moneda            = cargos.cod_moneda
                  AND      sysdate between conv.fec_desde and conv.fec_hasta
                  AND      catalogo.cod_prod_ofertado IN (  SELECT B.COD_PROD_OFERTADO
                                                            from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
                                                            WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
                                                            AND   UPPER(B.DES_PROD_OFERTADO) LIKE '%RPV%'
                                                            AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
                                                            AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
                                                            AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)
                  --AND      catalogo.cod_canal = EV_COD_CANAL  -->>COMENTO Y  CONSIDERO TODOS LOS CANALES !!!!!!
                  AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia 
                  AND        concepto.tipo_cargo = 'R';-->> CONSIDERO SOLO  TIPO RECURENTE 
         END IF;


        --OCB FIN PENALIZA


         RETURN ln_imp_tarifa;

    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          RETURN 0;
     WHEN PARAM_NO_CONFIG THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERVPN_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERVPN_PR', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
     WHEN OTHERS THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERVPN_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERVPN_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
END;


FUNCTION PV_OBTENERMTOGARAN_FN(EN_num_abonado    IN  ga_abocel.num_abonado%type,
                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = ""Function>
            Elemento Nombre = "PV_OBTENERMTOGARAN_FN"
            Lenguaje="PL/SQL"
            Fecha="09/07/2010"
            Version="1.0.0"
            Dise¨ador="ocb"
            Programador="ocb
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            MONTO TARIFARIO VPN
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"     Tipo="NUMBER"> codigo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
PARAM_NO_CONFIG   EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
ln_imp_tarifa     ga_tarifas.imp_tarifa%type;
LN_COD_CLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
ln_cantidad       INTEGER;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


         --OCB INI PENALIZA

         SELECT  COD_CLIENTE 
         INTO LN_COD_CLIENTE FROM GA_ABOCEL
         WHERE NUM_ABONADO = EN_num_abonado
         UNION
         SELECT  COD_CLIENTE FROM GA_ABOAMIST
         WHERE NUM_ABONADO = EN_num_abonado;
         
         
         
         ln_cantidad:= 0;
         SELECT count(1) into  ln_cantidad 
         from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
         WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
         AND   UPPER(B.DES_PROD_OFERTADO) LIKE '%GARAN%'
         AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
         AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
         AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA;

         if ln_cantidad > 0 then
       
                lv_sSql :=  ' SELECT SUM(cargos.monto_importe) INTO ln_imp_tarifa';
                lv_sSql := lv_sSql || 'FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
                lv_sSql := lv_sSql || '       pf_conceptos_prod_td concepto';
                lv_sSql := lv_sSql || 'WHERE  catalogo.cod_concepto      = concepto.cod_concepto';
                lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
                lv_sSql := lv_sSql || 'AND      catalogo.cod_cargo         = cargos.cod_cargo';
                lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado IN (  SELECT B.COD_PROD_OFERTADO';
                lv_sSql := lv_sSql || '                                         from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B';
                lv_sSql := lv_sSql || '                                         WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO';
                lv_sSql := lv_sSql || '                                         AND   UPPER(B.DES_PROD_OFERTADO) LIKE %GARAN%';
                lv_sSql := lv_sSql || '                                         AND   A.COD_CLIENTE_BENEFICIARIO='||LN_COD_CLIENTE;
                lv_sSql := lv_sSql || '                                         AND   A.NUM_ABONADO_BENEFICIARIO='||EN_num_abonado;
                lv_sSql := lv_sSql || '                                         AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)';
                lv_sSql := lv_sSql || 'AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia'; 
                lv_sSql := lv_sSql || 'AND        concepto.tipo_cargo = R';
         
                SELECT nvl(SUM(cargos.monto_importe*conv.cambio),0) INTO ln_imp_tarifa
                FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
                       pf_conceptos_prod_td concepto, ge_conversion conv
                WHERE  catalogo.cod_concepto        = concepto.cod_concepto
                AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
                AND      catalogo.cod_cargo         = cargos.cod_cargo
                AND      conv.cod_moneda            = cargos.cod_moneda
                AND      sysdate between conv.fec_desde and conv.fec_hasta
                AND      catalogo.cod_prod_ofertado IN (  SELECT B.COD_PROD_OFERTADO
                                                          from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
                                                          WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
                                                          AND   UPPER(B.DES_PROD_OFERTADO) LIKE '%GARAN%'
                                                          AND   A.COD_CLIENTE_BENEFICIARIO=389148
                                                          AND   A.NUM_ABONADO_BENEFICIARIO=31201842
                                                          AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)
                --AND      catalogo.cod_canal = EV_COD_CANAL  -->>COMENTO Y  CONSIDERO TODOS LOS CANALES !!!!!!
                AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia 
                AND        concepto.tipo_cargo = 'R';-->> CONSIDERO SOLO  TIPO RECURENTE 
         end if;


        --OCB FIN PENALIZA


         RETURN ln_imp_tarifa;

    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          RETURN 0;
     WHEN PARAM_NO_CONFIG THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERMTOGARAN_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERMTOGARAN_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
     WHEN OTHERS THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERMTOGARAN_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERMTOGARAN_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
END;



FUNCTION PV_OBTENERCARGBASMEN_FN(EN_num_abonado    IN  ga_abocel.num_abonado%type,
                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = ""Function>
            Elemento Nombre = "PV_OBTENERCARGBASMEN_FN"
            Lenguaje="PL/SQL"
            Fecha="09/07/2010"
            Version="1.0.0"
            Dise¨ador="ocb"
            Programador="ocb
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            MONTO TARIFARIO VPN
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"     Tipo="NUMBER"> codigo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
PARAM_NO_CONFIG   EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
ln_imp_tarifa     ga_tarifas.imp_tarifa%type;
ln_imp_tarifa2     ga_tarifas.imp_tarifa%type;
ln_imp_tarifa3     ga_tarifas.imp_tarifa%type;
LN_COD_CLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
ln_cantidad       INTEGER;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


         --OCB INI PENALIZA

         SELECT  COD_CLIENTE 
         INTO LN_COD_CLIENTE FROM GA_ABOCEL
         WHERE NUM_ABONADO = EN_num_abonado
         UNION
         SELECT  COD_CLIENTE FROM GA_ABOAMIST
         WHERE NUM_ABONADO = EN_num_abonado;



         ln_cantidad:=0;

         SELECT count(1) into ln_cantidad
         from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
         WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
         AND   UPPER(a.tipo_comportamiento) = 'CMOV'
         AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
         AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
         AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA;

         IF ln_cantidad > 0 THEN --TIENE CORREO MOVISTAR


                  lv_sSql :=  'SELECT SUM(cargos.monto_importe)';
                  lv_sSql := lv_sSql || 'FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
                  lv_sSql := lv_sSql || 'pf_conceptos_prod_td concepto';
                  lv_sSql := lv_sSql || 'WHERE  catalogo.cod_concepto      = concepto.cod_concepto';
                  lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
                  lv_sSql := lv_sSql || 'AND      catalogo.cod_cargo         = cargos.cod_cargo';
                  lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado IN ( SELECT B.COD_PROD_OFERTADO';
                  lv_sSql := lv_sSql || '                                         from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B';
                  lv_sSql := lv_sSql || '                                         WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO';
                  lv_sSql := lv_sSql || '                                         AND   UPPER(a.tipo_comportamiento) = CMOV';
                  lv_sSql := lv_sSql || '                                         AND   A.COD_CLIENTE_BENEFICIARIO='||LN_COD_CLIENTE;
                  lv_sSql := lv_sSql || '                                         AND   A.NUM_ABONADO_BENEFICIARIO='||EN_num_abonado;
                  lv_sSql := lv_sSql || '                                         AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)';
                  lv_sSql := lv_sSql || 'AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia'; 
                  lv_sSql := lv_sSql || 'AND        concepto.tipo_cargo = R';-->> CONSIDERO SOLO  TIPO RECURENTE 


                  SELECT nvl(SUM(cargos.monto_importe*conv.cambio),0) INTO ln_imp_tarifa2
                  FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
                         pf_conceptos_prod_td concepto, ge_conversion conv
                  WHERE  catalogo.cod_concepto      = concepto.cod_concepto
                  AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
                  AND      catalogo.cod_cargo         = cargos.cod_cargo
                  AND      conv.cod_moneda            = cargos.cod_moneda
                  AND      sysdate between conv.fec_desde and conv.fec_hasta
                  AND      catalogo.cod_prod_ofertado IN ( SELECT B.COD_PROD_OFERTADO
                                                           from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
                                                           WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
                                                           AND   UPPER(a.tipo_comportamiento) = 'CMOV'
                                                           AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
                                                           AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
                                                           AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)
                  --AND      catalogo.cod_canal = EV_COD_CANAL  -->>COMENTO Y  CONSIDERO TODOS LOS CANALES !!!!!!
                  AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia 
                  AND        concepto.tipo_cargo = 'R';-->> CONSIDERO SOLO  TIPO RECURENTE 
         End if;

         ln_cantidad:=0;

        SELECT count(1) into ln_cantidad
        from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
        WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
        AND   UPPER(B.DES_PROD_OFERTADO) LIKE 'GPRS'
        AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
        AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
        AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA;
 
        IF ln_cantidad > 0 THEN --TIENE CORREO DE DATOS


                        lv_sSql := 'SELECT SUM(cargos.monto_importe)';
                        lv_sSql := lv_sSql || 'FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
                        lv_sSql := lv_sSql || 'pf_conceptos_prod_td concepto';
                        lv_sSql := lv_sSql || 'WHERE  catalogo.cod_concepto      = concepto.cod_concepto';
                        lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
                        lv_sSql := lv_sSql || 'AND      catalogo.cod_cargo         = cargos.cod_cargo';
                        lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado IN (  SELECT B.COD_PROD_OFERTADO';
                        lv_sSql := lv_sSql || '                                          from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B';
                        lv_sSql := lv_sSql || '                                          WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO';
                        lv_sSql := lv_sSql || '                                          AND   UPPER(B.DES_PROD_OFERTADO) LIKE GPRS ';
                        lv_sSql := lv_sSql || '                                          AND   A.COD_CLIENTE_BENEFICIARIO='||LN_COD_CLIENTE;
                        lv_sSql := lv_sSql || '                                          AND   A.NUM_ABONADO_BENEFICIARIO='||EN_num_abonado;
                        lv_sSql := lv_sSql || '                                          AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)';
                        lv_sSql := lv_sSql || 'AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia'; 
                        lv_sSql := lv_sSql || 'AND        concepto.tipo_cargo = R';-->> CONSIDERO SOLO  TIPO RECURENTE

                        SELECT nvl(SUM(cargos.monto_importe),0) INTO ln_imp_tarifa3
                        FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
                        pf_conceptos_prod_td concepto
                        WHERE  catalogo.cod_concepto      = concepto.cod_concepto
                        AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
                        AND      catalogo.cod_cargo         = cargos.cod_cargo
                        AND      catalogo.cod_prod_ofertado IN (  SELECT B.COD_PROD_OFERTADO
                                                                  from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
                                                                  WHERE A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
                                                                  AND   UPPER(B.DES_PROD_OFERTADO) LIKE 'GPRS'
                                                                  AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
                                                                  AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
                                                                  AND   SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA)
                       --AND      catalogo.cod_canal = EV_COD_CANAL  -->>COMENTO Y  CONSIDERO TODOS LOS CANALES !!!!!!
                       AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia 
                       AND        concepto.tipo_cargo = 'R';-->> CONSIDERO SOLO  TIPO RECURENTE 

        END IF;

        ln_imp_tarifa:= ln_imp_tarifa2 + ln_imp_tarifa3;

        --OCB FIN PENALIZA


         RETURN ln_imp_tarifa;

    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          RETURN 0;
     WHEN PARAM_NO_CONFIG THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCARGBASMEN_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERCARGBASMEN_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
     WHEN OTHERS THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCARGBASMEN_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERCARGBASMEN_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
END;


FUNCTION PV_OBTENERCUOTPEND_FN(EN_num_abonado    IN  ga_abocel.num_abonado%type,
                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = ""Function>
            Elemento Nombre = "PV_OBTENERCUOTPEND_FN"
            Lenguaje="PL/SQL"
            Fecha="09/07/2010"
            Version="1.0.0"
            Dise¨ador="ocb"
            Programador="ocb
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            MONTO TARIFARIO VPN
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"     Tipo="NUMBER"> codigo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
PARAM_NO_CONFIG   EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
ln_imp_tarifa     ga_tarifas.imp_tarifa%type;
LN_COD_CLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
ln_cantidad       INTEGER;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


         --OCB INI PENALIZA



        SELECT  COD_CLIENTE 
        INTO LN_COD_CLIENTE FROM GA_ABOCEL
        WHERE NUM_ABONADO = EN_num_abonado
        UNION
        SELECT  COD_CLIENTE FROM GA_ABOAMIST
        WHERE NUM_ABONADO = EN_num_abonado;




        lv_sSql :=  'SELECT SUM(cargos.monto_importe) INTO ln_imp_tarifa';
        lv_sSql := lv_sSql || 'FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,';
        lv_sSql := lv_sSql || 'pf_conceptos_prod_td concepto';
        lv_sSql := lv_sSql || 'WHERE  catalogo.cod_concepto      = concepto.cod_concepto';
        lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado';
        lv_sSql := lv_sSql || 'AND      catalogo.cod_cargo         = cargos.cod_cargo';
        lv_sSql := lv_sSql || 'AND      catalogo.cod_prod_ofertado IN (SELECT B.COD_PROD_OFERTADO';
        lv_sSql := lv_sSql || '                                        from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B';
        lv_sSql := lv_sSql || '                                        WHERE'; 
        lv_sSql := lv_sSql || '                                        A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO';
        lv_sSql := lv_sSql || '                                        AND   (UPPER(B.DES_PROD_OFERTADO) LIKE GPRS or    UPPER(a.tipo_comportamiento) = CMOV)';
        lv_sSql := lv_sSql || '                                        AND   A.COD_CLIENTE_BENEFICIARIO='||LN_COD_CLIENTE;
        lv_sSql := lv_sSql || '                                        AND   A.NUM_ABONADO_BENEFICIARIO='||EN_num_abonado;
        lv_sSql := lv_sSql || '                                        AND   SYSDATE >= A.FEC_INICIO_VIGENCIA AND  rec.fec_fincontra <=B.FEC_TERMINO_VIGENCIA)';
        lv_sSql := lv_sSql || 'AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia'; 
        lv_sSql := lv_sSql || 'AND        concepto.tipo_cargo = R';-->> CONSIDERO SOLO  TIPO RECURENTE


        SELECT nvl(SUM(cargos.monto_importe*conv.cambio),0) INTO ln_imp_tarifa
        FROM   pf_cargos_productos_td cargos, pf_catalogo_ofertado_td catalogo,
               pf_conceptos_prod_td concepto, ge_conversion conv
        WHERE  catalogo.cod_concepto      = concepto.cod_concepto
        AND      catalogo.cod_prod_ofertado = concepto.cod_prod_ofertado
        AND      catalogo.cod_cargo         = cargos.cod_cargo
        AND      conv.cod_moneda            = cargos.cod_moneda
        AND      sysdate between conv.fec_desde and conv.fec_hasta
        AND      catalogo.cod_prod_ofertado IN (SELECT B.COD_PROD_OFERTADO
                                                from PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
                                                WHERE 
                                                A.COD_PROD_OFERTADO=B.COD_PROD_OFERTADO
                                                AND   (UPPER(B.DES_PROD_OFERTADO) LIKE 'GPRS' or    UPPER(a.tipo_comportamiento) = 'CMOV')
                                                AND   A.COD_CLIENTE_BENEFICIARIO=LN_COD_CLIENTE
                                                AND   A.NUM_ABONADO_BENEFICIARIO=EN_num_abonado
                                                AND   SYSDATE >= A.FEC_INICIO_VIGENCIA AND  rec.fec_fincontra <=B.FEC_TERMINO_VIGENCIA)
       --AND      catalogo.cod_canal = EV_COD_CANAL  -->>COMENTO Y  CONSIDERO TODOS LOS CANALES !!!!!!
       AND   SYSDATE BETWEEN   catalogo.fec_inicio_vigencia AND   catalogo.fec_termino_vigencia 
       AND        concepto.tipo_cargo = 'R';-->> CONSIDERO SOLO  TIPO RECURENTE


        --OCB FIN PENALIZA


         RETURN ln_imp_tarifa;

    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          RETURN 0;
     WHEN PARAM_NO_CONFIG THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCUOTPEND_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERCUOTPEND_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
     WHEN OTHERS THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCUOTPEND_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERCUOTPEND_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
END;




FUNCTION PV_OBTENERCUOTASBASICAS_FN(EN_cod_cliente    IN  ga_abocel.cod_cliente%type,
                                    EN_num_abonado    IN  ga_abocel.num_abonado%type,
                                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = ""Function>
            Elemento Nombre = "PV_OBTENERCUOTASBASICAS_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            retornar codigo servicio 1 VPN 0 NO es servicio VPN
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"      Tipo="NUMBER"> codigo abonado </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
PARAM_NO_CONFIG    EXCEPTION;
PARAM_PENALIZACION EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_cargo_basico   ta_cargosbasico.imp_cargobasico%type;
ln_imp_tarifa     ga_tarifas.imp_tarifa%type;
ln_imp_tarifa2    ga_tarifas.imp_tarifa%type;
ln_importe        co_cancelados.importe_debe%type;
ln_importe2       co_cancelados.importe_debe%type;
ln_cuotas_pend    co_cancelados.importe_debe%type;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


         CASE rec.cod_grupo
          WHEN  '01' THEN
          --PLAN MILENIO PYME
                            ln_imp_tarifa:=PV_OBTENERVPN_FN(EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                            IF SN_cod_retorno <> 0 THEN
                               RAISE PARAM_PENALIZACION;
                            END IF;
                            ln_cargo_basico:=rec.imp_cargobasico + ln_imp_tarifa;   
            
          WHEN  '02' THEN
            --PLAN CORPORATIVO MILENIO
                            ln_imp_tarifa:=PV_OBTENERVPN_FN(EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                            
                            IF SN_cod_retorno <> 0 THEN
                               RAISE PARAM_PENALIZACION;
                            END IF;
                            
                            ln_cargo_basico:=rec.imp_cargobasico + ln_imp_tarifa; 
                            
                            
                            ln_imp_tarifa2:=PV_OBTENERMTOGARAN_FN(EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                            
                            IF SN_cod_retorno <> 0 THEN
                               RAISE PARAM_PENALIZACION;
                            END IF;
                          
                            
                            ln_cargo_basico:= ln_cargo_basico + ln_imp_tarifa2;
            
            
          WHEN  '03' THEN
          --PLAN RESIDENCIAL
                            ln_cargo_basico:=rec.imp_cargobasico;
            
            
          WHEN  '04' THEN
          --PLANES CON CORREO GPRS/CORREO MOVISTAR
                        /*IF rec.cod_modventa IN (CV_CREDITO,CV_CREDITO_CONSIGNACION) THEN
                           lv_sSql := 'PV_OBTENERTOTCANCUOTAS_FN('||EN_cod_cliente||','||EN_num_abonado||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                           ln_importe:=PV_OBTENERTOTCANCUOTAS_FN(EN_cod_cliente,EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                           IF  SN_cod_retorno <> 0 THEN
                               RAISE PARAM_PENALIZACION;
                           END IF;
                           ln_cuotas_pend := rec.imp_cargo - ln_importe;
                        ELSE
                           ln_cuotas_pend :=0;
                        END IF;
                        ln_cargo_basico:=rec.imp_cargobasico + ln_cuotas_pend;*/
                        
                        ln_importe:=PV_OBTENERCARGBASMEN_FN(EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF  SN_cod_retorno <> 0 THEN
                               RAISE PARAM_PENALIZACION;
                        END IF;
                        
                        
                        ln_importe2:=PV_OBTENERCUOTPEND_FN(EN_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF  SN_cod_retorno <> 0 THEN
                               RAISE PARAM_PENALIZACION;
                        END IF;
                        
                        ln_cargo_basico:= ln_importe + ln_importe2;
                        
                        
          WHEN  '05' THEN
          --PLANES FIJOS y DATOS
                            ln_cargo_basico:=rec.imp_cargobasico;
          ELSE
          --Otro grupo
                            ln_cargo_basico:=0;
         END CASE;


         RETURN ln_cargo_basico;

    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          RETURN 0;
     WHEN PARAM_PENALIZACION THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCUOTASBASICAS_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERVPN_PR', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
     WHEN PARAM_NO_CONFIG THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCUOTASBASICAS_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERVPN_PR', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
     WHEN OTHERS THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCUOTASBASICAS_FN('||EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERCUOTASBASICAS_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          RETURN 0;
END;

FUNCTION PV_OBTENCTASCANCELEQUIPO_FN(EN_num_abonado    IN ga_abocel.num_abonado%type,
                    EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN VARCHAR2 IS
/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENCTASCANCELEQUIPO_FN"
            Lenguaje="PL/SQL"
            Fecha="02/10/2009"
            Version="1.0.0"
            Dise¨ador="Jaime Bravo"
            Programador="Jaime Bravo"
            Ambiente="BD"
        <Retorno> VARCHAR2 </Retorno>
        <Descripcion>
            grupo de prestaci–n del abonado.
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_monto     number;
EN_NUMVENTA    number;

BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        lv_monto:= 0;


    lv_sSql := 'SELECT NUM_VENTA';
    lv_sSql := lv_sSql || ' INTO EN_NUMVENTA';
    lv_sSql := lv_sSql || ' FROM GA_ABOCEL';
    lv_sSql := lv_sSql || ' WHERE  NUM_ABONADO = ' || EN_num_abonado;        

    SELECT NUM_VENTA
    INTO EN_NUMVENTA
    FROM GA_ABOCEL
    WHERE  NUM_ABONADO = EN_num_abonado;    
    
    lv_sSql := 'SELECT NVL(SUM(CO.IMPORTE_DEBE),0) ';
    lv_sSql := lv_sSql || 'into lv_monto FROM CO_CANCELADOS CO WHERE CO.COD_CLIENTE = ' || EN_cod_cliente ;
    lv_sSql := lv_sSql || ' AND CO.NUM_ABONADO  = EN_ABONADO AND CO.NUM_VENTA = ' || EN_num_abonado;
    lv_sSql := lv_sSql || ' AND CO.SEC_CUOTA > 0 AND CO.IND_FACTURADO=1';
    
    SELECT NVL(SUM(CO.IMPORTE_DEBE),0) 
    into lv_monto
    FROM CO_CANCELADOS CO
    WHERE CO.COD_CLIENTE = EN_cod_cliente
    AND CO.NUM_ABONADO  = EN_num_abonado       
    AND CO.NUM_VENTA = EN_NUMVENTA
    AND CO.SEC_CUOTA    > 0
    AND CO.IND_FACTURADO=1;

        return lv_monto;
        
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENCTASCANCELEQUIPO_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENCTASCANCELEQUIPO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENCTASCANCELEQUIPO_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENCTASCANCELEQUIPO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
END;

PROCEDURE PV_OBTENERPARAM_PR(EV_nom_parametro  IN ga_parametros_sistema_vw.nom_parametro%type,
                             SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  IS
/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERPARAM_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
            retornar parametro del sistema LIB-General
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_nom_parametro"    Tipo="NUMBER> parametro sistema</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
PARAM_NO_CONFIG   EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

          lv_nom_parametro := EV_nom_parametro || '_' || CV_MODULO_GA;


         lv_sSql := 'SELECT param.valor_texto ';
         lv_sSql := lv_sSql || ', param.valor_numerico';
         lv_sSql := lv_sSql || ', param.valor_dominio';
         lv_sSql := lv_sSql || 'FROM ga_parametros_sistema_vw param';
         lv_sSql := lv_sSql || 'WHERE param.nom_parametro = ' || lv_nom_parametro;


           SELECT param.valor_texto
                 , param.valor_numerico
                 , param.valor_dominio
            INTO rec_param
            FROM ga_parametros_sistema_vw param
           WHERE param.nom_parametro = lv_nom_parametro;


             IF rec_param.valor_texto IS NULL AND rec_param.valor_numerico IS NULL AND rec_param.valor_dominio IS NULL THEN
                RAISE PARAM_NO_CONFIG;
             END IF;


    EXCEPTION
     WHEN PARAM_NO_CONFIG THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPARAM_PR('|| EV_nom_parametro || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERPARAM_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN OTHERS THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPARAM_PR('|| EV_nom_parametro || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERPARAM_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;

PROCEDURE PV_STANDARD_PR(EN_num_abonado    IN ga_abocel.num_abonado%type,
                         SN_imp_cargo      OUT NOCOPY ga_imppenaliza.imp_penaliza%type,
                         SV_ind_autman     OUT NOCOPY ga_servicios.ind_autman%type,
                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERPARAM_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"      Tipo="NUMBER> numero abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

IS
RESTRICCION_PROCESO  EXCEPTION;
RESTRICCION_OK       EXCEPTION;
PARAM_NO_CONFIG      EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
lv_codactuacion   ga_parametros_sistema_vw.valor_texto%type;
lv_evento         ga_parametros_sistema_vw.valor_texto%type;
lv_aplicacobro    ga_parametros_sistema_vw.valor_dominio%type;
lv_secuencia      number;
lv_parametro      varchar2(255);
lv_cod_retorno    ga_transacabo.cod_retorno%type;
lv_des_cadena     ga_transacabo.des_cadena%type;
ln_cod_penaliza   ga_percontrato.cod_penaliza%type;
lv_cod_tipserv    ga_actuaserv.cod_tipserv%type;
lv_cod_servicio   ga_actuaserv.cod_servicio%type;
BEGIN
   SN_num_evento:= 0;
   SN_cod_retorno:=0;
   SV_mens_retorno:='';

    lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMCOBR ||')';
    PV_OBTENERPARAM_PR(CV_NOMPARAMCOBR,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    IF SN_cod_retorno = 0 THEN
        lv_aplicacobro:= TRIM(rec_param.valor_dominio);
    ELSE
        RAISE PARAM_NO_CONFIG;
    END IF;

    IF lv_aplicacobro = 'TRUE' THEN
        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO lv_secuencia FROM DUAL;

      lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMEVENEST ||')';
      PV_OBTENERPARAM_PR(CV_NOMPARAMEVENEST,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
      IF SN_cod_retorno = 0 THEN
        lv_evento:=TRIM(rec_param.valor_texto);
      ELSE
        RAISE PARAM_NO_CONFIG;
      END IF;

      lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMACTU ||')';
      PV_OBTENERPARAM_PR(CV_NOMPARAMACTU,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
      IF SN_cod_retorno = 0 THEN
        lv_codactuacion:= TRIM(rec_param.valor_texto);
      ELSE
        RAISE PARAM_NO_CONFIG;
      END IF;

      lv_parametro := '|||||' || EN_num_abonado || '|||||||||||||||';
      lv_sSql:='PV_PR_EJECUTA_RESTRICCION('||lv_secuencia||','||CV_MODULO_GA||','||
      rec.cod_producto||','||      lv_codactuacion||','||lv_evento||','||lv_parametro||')';
      PV_PR_EJECUTA_RESTRICCION (lv_secuencia,CV_MODULO_GA,rec.cod_producto,lv_codactuacion,lv_evento,lv_parametro);

       SELECT tran.cod_retorno
             ,tran.des_cadena
       INTO  lv_cod_retorno
             ,lv_des_cadena
       FROM ga_transacabo tran
       WHERE tran.num_transaccion = lv_secuencia;

        IF lv_cod_retorno <> 0 THEN
          IF lv_des_cadena = 'OK' THEN
             RAISE RESTRICCION_OK;
          ELSE
             RAISE RESTRICCION_PROCESO;
          END IF;
        END IF;

         BEGIN
             SELECT  perc.cod_penaliza
             INTO    ln_cod_penaliza
             FROM    ga_percontrato perc, ga_contcta cta
             WHERE   cta.cod_cuenta       = rec.cod_cuenta
               AND   cta.num_contrato (+) = rec.num_contrato
               AND   cta.num_anexo    (+) = rec.num_anexo
               AND   cta.cod_tipcontrato  = perc.cod_tipcontrato (+)
               AND   cta.num_meses        = perc.num_meses       (+)
               AND   cta.cod_producto     = perc.cod_producto    (+);

       EXCEPTION
         WHEN NO_DATA_FOUND THEN
             ln_cod_penaliza := 0;
         END;

      lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMSERVEST ||')';
      PV_OBTENERPARAM_PR(CV_NOMPARAMSERVEST,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
      IF SN_cod_retorno = 0 THEN
         lv_cod_servicio:= NVL(rec_param.valor_numerico,rec_param.valor_texto);
      ELSE
         RAISE PARAM_NO_CONFIG;
      END IF;

      lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMSERO ||')';
      PV_OBTENERPARAM_PR(CV_NOMPARAMSERO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
      IF SN_cod_retorno = 0 THEN
        lv_cod_tipserv:= NVL(rec_param.valor_numerico,rec_param.valor_texto);
      ELSE
        RAISE PARAM_NO_CONFIG;
      END IF;

      BEGIN
       SELECT c.ind_autman, e.imp_penaliza
       INTO  SV_ind_autman,SN_imp_cargo
       FROM  ga_actuaserv a, ga_servicios c, ga_imppenaliza e
       WHERE a.cod_producto  = rec.cod_producto
       AND a.cod_actabo      = lv_codactuacion
       AND a.cod_tipserv   = lv_cod_tipserv
       AND c.cod_producto  = a.cod_producto
       AND c.cod_servicio  = a.cod_servicio
       AND a.cod_servicio  = lv_cod_servicio
       AND e.cod_penaliza  = ln_cod_penaliza
       AND SYSDATE        >= e.fec_desde
       AND SYSDATE        <= NVL(e.fec_hasta, SYSDATE);

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SN_imp_cargo:=0;
      END;
    END IF;

EXCEPTION
    WHEN RESTRICCION_OK THEN
      SN_cod_retorno:=0;
      SN_imp_cargo:=0;
      SV_ind_autman :='';
    WHEN RESTRICCION_PROCESO THEN
      SN_cod_retorno := 3;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('RESTRICCION_PROCESO:PV_PENALIZACION_PG.PV_STANDARD_PR('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_STANDARD_PR', lv_sSql, SN_cod_retorno, LV_des_error );
   WHEN PARAM_NO_CONFIG THEN
      SN_cod_retorno:=274;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('PARAM_NO_CONFIG:PV_PENALIZACION_PG.PV_STANDARD_PR('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_STANDARD_PR', lv_sSql, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_STANDARD_PR('|| EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_STANDARD_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;

PROCEDURE PV_ESCALONADA_PR(EN_num_abonado    IN ga_abocel.num_abonado%type,
                           SN_imp_cargo      OUT NOCOPY ga_imppenaliza.imp_penaliza%type,
                           SV_ind_autman     OUT NOCOPY ga_servicios.ind_autman%type,
                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERPARAM_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"      Tipo="NUMBER> numero abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

IS

RESTRICCION_PROCESO  EXCEPTION;
RESTRICCION_OK       EXCEPTION;
PARAM_NO_CONFIG      EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
lv_codactuacion   ga_parametros_sistema_vw.valor_texto%type;
lv_evento         ga_parametros_sistema_vw.valor_texto%type;
lv_aplicacobro    ga_parametros_sistema_vw.valor_dominio%type;
lv_secuencia      number;
lv_parametro      varchar2(255);
lv_cod_retorno    ga_transacabo.cod_retorno%type;
lv_des_cadena     ga_transacabo.des_cadena%type;
ln_cod_penaliza   ga_percontrato.cod_penaliza%type;
lv_cod_tipserv    ga_actuaserv.cod_tipserv%type;
lv_cod_servicio   ga_actuaserv.cod_servicio%type;
ln_nummeses       number;
BEGIN
   SN_num_evento:= 0;
   SN_cod_retorno:=0;
   SV_mens_retorno:='';

   lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMCOBR ||')';
   PV_OBTENERPARAM_PR(CV_NOMPARAMCOBR,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno = 0 THEN
         lv_aplicacobro:= TRIM(rec_param.valor_dominio);
     ELSE
          RAISE PARAM_NO_CONFIG;
      END IF;

     IF lv_aplicacobro = 'TRUE' THEN
         SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO lv_secuencia FROM DUAL;

     lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMEVENESC ||')';
     PV_OBTENERPARAM_PR(CV_NOMPARAMEVENESC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno = 0 THEN
             lv_evento:=TRIM(rec_param.valor_texto);
     ELSE
      RAISE PARAM_NO_CONFIG;
     END IF;

     lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMACTU ||')';
     PV_OBTENERPARAM_PR(CV_NOMPARAMACTU,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno = 0 THEN
        lv_codactuacion:= TRIM(rec_param.valor_texto);
     ELSE
        RAISE PARAM_NO_CONFIG;
     END IF;

          lv_parametro := '|||||' || EN_num_abonado || '|||||||||||||||';

         lv_sSql :='PV_PR_EJECUTA_RESTRICCION('||lv_secuencia||','||CV_MODULO_GA||','||rec.cod_producto||','||
         lv_codactuacion||','||lv_evento||','||lv_parametro||')';
         PV_PR_EJECUTA_RESTRICCION (lv_secuencia,CV_MODULO_GA,rec.cod_producto,lv_codactuacion,lv_evento,lv_parametro);

       SELECT tran.cod_retorno
                        ,tran.des_cadena
       INTO  lv_cod_retorno
                       ,lv_des_cadena
       FROM ga_transacabo tran
       WHERE tran.num_transaccion = lv_secuencia;

        IF lv_cod_retorno <> 0 THEN
          IF lv_des_cadena = 'OK' THEN
             RAISE RESTRICCION_OK;
          ELSE
             RAISE RESTRICCION_PROCESO ;
          END IF;
        END IF;

        IF rec.fec_prorroga IS NOT NULL THEN
           ln_nummeses := TRUNC(MONTHS_BETWEEN(SYSDATE,rec.fec_prorroga));
        ELSE
           ln_nummeses := TRUNC(MONTHS_BETWEEN(SYSDATE,rec.fec_alta));
        END IF;

     lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMSERVESC ||')';
     PV_OBTENERPARAM_PR(CV_NOMPARAMSERVESC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno = 0 THEN
        lv_cod_servicio:= NVL(rec_param.valor_numerico,rec_param.valor_texto);
     ELSE
        RAISE PARAM_NO_CONFIG;
     END IF;

     lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMSERO ||')';
     PV_OBTENERPARAM_PR(CV_NOMPARAMSERO,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
     IF SN_cod_retorno = 0 THEN
       lv_cod_tipserv:= NVL(rec_param.valor_numerico,rec_param.valor_texto);
     ELSE
       RAISE PARAM_NO_CONFIG;
     END IF;

     BEGIN
          SELECT c.ind_autman,e.valor
          INTO   SV_ind_autman,SN_imp_cargo
          FROM   ga_actuaserv a, ga_servicios c, ge_monedas d, ga_cargos_indemnizacion e
          WHERE a.cod_producto = rec.cod_producto
          AND a.cod_actabo        = lv_codactuacion
          AND a.cod_tipserv    = lv_cod_tipserv
          AND c.cod_producto   = a.cod_producto
          AND c.cod_servicio   = a.cod_servicio
          AND d.cod_moneda        = e.cod_moneda
          AND a.cod_servicio   = lv_cod_servicio
          AND e.meses_contrato = rec.meses_minimo
          AND e.num_meses        = ln_nummeses
          AND SYSDATE              >= e.fec_desde
           AND SYSDATE              <= NVL(e.fec_hasta,SYSDATE);

         EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  SN_imp_cargo:=0;
        END;

     END IF;

EXCEPTION
    WHEN RESTRICCION_OK THEN
      SN_cod_retorno:=0;
      SN_imp_cargo:=0;
      SV_ind_autman :='';
    WHEN RESTRICCION_PROCESO THEN
            SN_cod_retorno := 3;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('RESTRICCION_PROCESO:PV_PENALIZACION_PG.PV_ESCALONADA_PR('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_ESCALONADA_PR', lv_sSql, SN_cod_retorno, LV_des_error );
   WHEN PARAM_NO_CONFIG THEN
      SN_cod_retorno:=274;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('PARAM_NO_CONFIG:PV_PENALIZACION_PG.PV_ESCALONADA_PR('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_ESCALONADA_PR', lv_sSql, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_ESCALONADA_PR('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_ESCALONADA_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END ;


FUNCTION PV_OBTENER_SUSPENSIONES_FN(EN_num_abonado    IN ga_abocel.num_abonado%type,
                                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = "FUNCTION">
            Elemento Nombre = "PV_OBTENER_SUSPENSIONES_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            Obtiene meses de suspension del abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"    Tipo="NUMBER> n+mero del abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
lv_des_error         ge_errores_pg.DesEvent;
lv_sSql              ge_errores_pg.vQuery;
ln_num_suspensionSUS number:=0;
ln_num_suspensionVOL number:=0;
ln_dias_susp         number:=0;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

      lv_sSql := 'SELECT SUM((NVL(trunc(a.FEC_REHABD),SYSDATE) - trunc(a.FEC_SUSPBD))) as Num_Dias ';
      lv_sSql := lv_sSql || ' FROM ga_susprehabo a ';
      lv_sSql := lv_sSql || ' WHERE a.num_abonado =' || EN_num_abonado;

      BEGIN
        SELECT SUM((NVL(trunc(a.FEC_REHABD),SYSDATE) - trunc(a.FEC_SUSPBD))) as Num_Dias
        INTO ln_num_suspensionSUS
        FROM ga_susprehabo a
        WHERE a.num_abonado = EN_num_abonado;

      EXCEPTION
      WHEN NO_DATA_FOUND THEN
           NULL;
      END;

      lv_sSql := 'SELECT SUM((NVL(trunc(a.fec_rehabilitacion),SYSDATE) - trunc(a.a.fec_suspension))) as Num_Dias';
      lv_sSql := lv_sSql || ' FROM pv_det_suspvolprog_to a ';
      lv_sSql := lv_sSql || ' WHERE a.num_abonado = ' || EN_num_abonado;
      --lv_sSql := lv_sSql || ' AND a.estado IN (' || CV_COD_SUS || ',' || CV_COD_PRG || ',' || CV_COD_REH || ')';

      BEGIN
       SELECT SUM((NVL(trunc(a.fec_rehabilitacion),SYSDATE) - trunc(a.fec_suspension))) as Num_Dias
       INTO  ln_num_suspensionVOL
       FROM pv_det_suspvolprog_to a
       WHERE a.num_abonado =  EN_num_abonado;
       --AND a.estado IN (CV_COD_SUS,CV_COD_PRG,CV_COD_REH);

       EXCEPTION
       WHEN NO_DATA_FOUND THEN
           NULL;
      END;

      ln_dias_susp := (NVL(ln_num_suspensionSUS,0) + NVL(ln_num_suspensionVOL,0));

      return ln_dias_susp;

    EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno:=4;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_ERROR_NO_CLASIF;
        END IF;
                LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENER_SUSPENSIONES_FN('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
        SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'PV_PENALIZACION_PG.PV_OBTENER_SUSPENSIONES_FN', lv_sSql, SN_cod_retorno, LV_des_error );
        return 0;
END;


FUNCTION PV_OBTENERDEDUCIBLE_FN(EN_num_abonado    IN ga_abocel.num_abonado%type,
                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN NUMBER IS
/*--
        <Documentacion TipoDoc = "FUNCTION">
            Elemento Nombre = "PV_OBTENERDEDUCIBLE_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> DATE </Retorno>
        <Descripcion>
            Obtiene deducible abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"    Tipo="NUMBER> n+mero delo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_seguro         number:=0;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

      lv_sSql := 'SELECT COUNT(1) ';
      lv_sSql := lv_sSql || ' FROM GA_SEGUROABONADO_TO a';
      lv_sSql := lv_sSql || ' WHERE a.num_abonado = '||EN_num_abonado;
      lv_sSql := lv_sSql || ' AND  a.fec_fincontrato >= sysdate';

      SELECT COUNT(1)
      INTO ln_seguro
      FROM GA_SEGUROABONADO_TO a
      WHERE a.num_abonado = EN_num_abonado
      AND  a.fec_fincontrato >= sysdate;

      return ln_seguro;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return 0;
    WHEN OTHERS THEN
        SN_cod_retorno:=4;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_ERROR_NO_CLASIF;
        END IF;
                LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERDEDUCIBLE_FN('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
        SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'PV_PENALIZACION_PG.PV_OBTENERDEDUCIBLE_FN', lv_sSql, SN_cod_retorno, LV_des_error );
        return 0;
END;


FUNCTION PV_RENOVACION_FN(EN_num_abonado    IN ga_abocel.num_abonado%type,
                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN DATE IS
/*--
        <Documentacion TipoDoc = "FUNCTION">
            Elemento Nombre = "PV_RENOVACION_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> DATE </Retorno>
        <Descripcion>
            Obtiene fecha de renovacion del abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"    Tipo="NUMBER> n+mero delo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ld_fec_ingreso    pv_registra_renovacion_os_to.fec_ingreso%type;
BEGIN
       SN_num_evento:= 0;
       SN_cod_retorno:=0;
       SV_mens_retorno:='';

      lv_sSql := 'SELECT MAX(TO_CHAR(a.fec_ingreso,' || GV_formato_sel2 || ')) ';
      lv_sSql := lv_sSql || ' FROM pv_registra_renovacion_os_to a ';
      lv_sSql := lv_sSql || ' AND   a.num_abonado = ' || EN_num_abonado;


      SELECT MAX(TO_DATE(a.fec_ingreso,GV_formato_sel1))
      INTO  ld_fec_ingreso
      FROM pv_registra_renovacion_os_to a
      WHERE a.num_abonado = EN_num_abonado;

      return ld_fec_ingreso;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return null;
    WHEN OTHERS THEN
        SN_cod_retorno:=4;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_ERROR_NO_CLASIF;
        END IF;
        LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_RENOVACION_FN('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
        SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'PV_PENALIZACION_PG.PV_RENOVACION_FN', lv_sSql, SN_cod_retorno, LV_des_error );
        return null;
END;

FUNCTION PV_OBTENERPARAMGENERAL_FN(SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN NUMBER IS

/*--
        <Documentacion TipoDoc = "Funcion">
            Elemento Nombre = "PV_OBTENERPARAMGENERAL_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripcion>
            retornar parametro del sistema LIB-General
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_cod_notacre    fa_datosgener.cod_notacre%type;
BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    lv_sSql := ' SELECT a.cod_notacre FROM FA_DATOSGENER a ';

    SELECT a.cod_notacre
    INTO   ln_cod_notacre
    FROM fa_datosgener a;

    return ln_cod_notacre;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SN_cod_retorno:=890003;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_ERROR_NO_CLASIF;
        END IF;
        LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPARAMGENERAL_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
        SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'PV_PENALIZACION_PG.PV_OBTENERPARAMGENERAL_FN', lv_sSql, SN_cod_retorno, LV_des_error );
    return -1;
    WHEN OTHERS THEN
        SN_cod_retorno:=1362;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_ERROR_NO_CLASIF;
        END IF;
        LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPARAMGENERAL_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
        SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'PV_PENALIZACION_PG.PV_OBTENERPARAMGENERAL_FN', lv_sSql, SN_cod_retorno, LV_des_error );
        return -1;
END;

PROCEDURE PV_OBTENERCUOTAS_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                              EN_num_abonado    IN ga_abocel.num_abonado%type,
                              SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                              SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                              SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

/*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "PV_OBTENERCUOTAS_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
            Obtiene Cuotas del cliente/Abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> n+mero del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> n+mero delo abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;

BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

      lv_sSql := 'SELECT unique a.num_cuota,a.sec_cuota ';
      lv_sSql := lv_sSql || ' FROM  co_cancelados a ';
      lv_sSql := lv_sSql || ' WHERE a.cod_cliente = ' || EN_cod_cliente;
      lv_sSql := lv_sSql || ' AND   a.num_abonado = ' || EN_num_abonado;
      lv_sSql := lv_sSql || ' AND   a.sec_cuota in ( SELECT MAX(b.sec_cuota) FROM co_cancelados b WHERE b.cod_cliente = a.cod_cliente AND b.num_abonado = a.num_abonado AND b.sec_cuota > 0)';

      SELECT unique nvl(a.num_cuota,0),nvl(a.sec_cuota,0)
      INTO   reccuota
      FROM  co_cancelados a
      WHERE a.cod_cliente = EN_cod_cliente
      AND   a.num_abonado = EN_num_abonado
      AND   a.sec_cuota in ( SELECT MAX(b.sec_cuota) FROM co_cancelados b
                             WHERE b.cod_cliente = a.cod_cliente
                             AND b.num_abonado = a.num_abonado
                             AND b.sec_cuota > 0);


      EXCEPTION
      WHEN NO_DATA_FOUND THEN
       reccuota.num_cuota := 0;
       reccuota.sec_cuota := 0;
      WHEN OTHERS THEN
       SN_cod_retorno:=4;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
       END IF;
       LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERCUOTAS_PR('|| EN_cod_cliente || ',' || EN_num_abonado || '); - '||  SQLERRM,1,CN_LARGOERRTEC);
       SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
       SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
       'PV_PENALIZACION_PG.PV_OBTENERCUOTAS_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;



PROCEDURE PV_NOTACREDITO_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                            EN_num_abonado    IN ga_abocel.num_abonado%type,
                            SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "PV_NOTACREDITO_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> n+mero del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> n+mero del abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

ERROR_FORMATO     EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_num_secuenci   fa_histdocu.num_secuenci%type;
ln_num_securel    fa_histdocu.num_securel%type;
ln_num_abonado    ga_abocel.num_abonado%type;
ld_fec_emision    fa_histdocu.fec_emision%type;
li_pos            integer:=0;
li_arr            integer:=0;
ln_tot_factura    fa_histdocu.tot_factura%type;
lb_sw             integer:=0;

TYPE cursorTYPE IS REF CURSOR;  -- define control ref cursor type  --
co_cur cursorTYPE;     -- declare cursor variable         --
CURSOR fa_cur IS
       SELECT a.num_securel,a.num_secuenci
       FROM siscel.fa_histdocu a
       WHERE a.cod_cliente = EN_cod_cliente
       AND a.cod_tipdocum  = GN_NC;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

          lv_sSql := 'SELECT a.num_securel,a.num_secuenci ';
          lv_sSql := lv_sSql || ' FROM fa_histdocu a';
          lv_sSql := lv_sSql || ' WHERE a.cod_cliente = ' || EN_cod_cliente;
          lv_sSql := lv_sSql || ' AND a.cod_tipdocum = '|| GN_NC;

      nc_abonado.delete;

      OPEN fa_cur ;
      LOOP
        FETCH fa_cur INTO ln_num_securel,ln_num_secuenci;
        EXIT WHEN fa_cur%NOTFOUND;

             lv_sSql := 'SELECT a.tot_factura';
             lv_sSql := lv_sSql || ' FROM siscel.fa_histdocu a';
             lv_sSql := lv_sSql || ' WHERE a.num_secuenci = ' || ln_num_securel;
             lv_sSql := lv_sSql || ' and  a.cod_tipdocum not in (select b.cod_tipdocum from ge_tipdocumen b where b.des_tipdocum like ' || '%MISCELANEA%' || ')';
             lv_sSql := lv_sSql || ' and  a.cod_cliente = ' || EN_cod_cliente;
             lv_sSql := lv_sSql || ' and to_date(a.fec_emision,' || GV_formato_sel2 || ') <= to_date(' || rec.fec_fincontra ||','||GV_formato_sel2||')';

            BEGIN
             SELECT a.tot_factura
             INTO ln_tot_factura
             FROM siscel.fa_histdocu a
             WHERE a.num_secuenci = ln_num_securel
             and   a.cod_tipdocum not in (select b.cod_tipdocum from ge_tipdocumen b where b.des_tipdocum like '%MISCELANEA%')
             and   a.cod_cliente = EN_cod_cliente
             and   to_date(a.fec_emision,GV_formato_sel2) <= to_date(rec.fec_fincontra,GV_formato_sel2);


             EXCEPTION
               WHEN NO_DATA_FOUND THEN
                   null;
            END;

             IF ln_tot_factura > 0 THEN
                lv_sSql := 'SELECT distinct b.num_abonado ';
                lv_sSql := lv_sSql || ' FROM siscel.co_cancelados b';
                lv_sSql := lv_sSql || ' WHERE b.cod_cliente = :1';
                lv_sSql := lv_sSql || ' AND b.num_secuenci = :2';

                IF EN_num_abonado <> 0 THEN
                   lv_sSql := lv_sSql || ' AND b.num_abonado= :3';
                END IF;

              IF EN_num_abonado <> 0 THEN
                 OPEN co_cur FOR lv_sSql USING EN_cod_cliente,ln_num_secuenci,EN_num_abonado;
              ELSE
                 OPEN co_cur FOR lv_sSql USING EN_cod_cliente,ln_num_secuenci;
              END IF;

              LOOP
               FETCH co_cur INTO ln_num_abonado;
               EXIT WHEN co_cur%NOTFOUND;

                IF nc_abonado.count = 0 THEN
                   nc_abonado(Li_arr).num_abonado := ln_num_abonado;
                   nc_abonado(Li_arr).tot_notcredito :=  ln_tot_factura;
                ELSE
                   lb_sw:=0;
                   FOR Li_pos IN 0 .. nc_abonado.count-1 LOOP
                     IF  nc_abonado(Li_pos).num_abonado  = ln_num_abonado THEN
                         nc_abonado(Li_pos).tot_notcredito := nc_abonado(Li_pos).tot_notcredito + ln_tot_factura;
                         lb_sw := 1;
                     END IF;
                   END LOOP;

                   IF lb_sw = 0 THEN
                     Li_arr:=Li_arr+1;
                     nc_abonado(Li_arr).num_abonado := ln_num_abonado;
                     nc_abonado(Li_arr).tot_notcredito :=  ln_tot_factura;
                   END IF;

                END IF;



              END LOOP;
              CLOSE co_cur;
            END IF;


      END LOOP;

     IF nc_abonado.count = 0 THEN
        nc_abonado(0).tot_notcredito :=0;
     END IF;

      CLOSE fa_cur;

      EXCEPTION
          WHEN NO_DATA_FOUND THEN
               SN_num_evento:= 0;
               SN_cod_retorno:=0;
               SV_mens_retorno:='';

          WHEN OTHERS THEN
              SN_cod_retorno:=314;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_ERROR_NO_CLASIF;
              END IF;
              LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_NOTACREDITO_PR('|| EN_cod_cliente ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
              SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
              SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
              'PV_PENALIZACION_PG.PV_NOTACREDITO_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;

FUNCTION PV_OBTENERPARAMETRO_FN(EV_nom_parametro  IN ged_parametros.nom_parametro%type,
                                EV_cod_modulo     IN ged_parametros.cod_modulo%type,
                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN VARCHAR2 IS

/*--
        <Documentacion TipoDoc = "Funcion">
            Elemento Nombre = "PV_OBTENERPARAMETRO_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> VARCHAR2 </Retorno>
        <Descripcion>
            retornar parametro del sistema LIB-General
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_nom_parametro"    Tipo="NUMBER> parametro sistema</param>
            <param nom="EV_cod_modulo"       Tipo="VARCHAR2> Modulo</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_val_parametro  ged_parametros.val_parametro%type;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        lv_sSql := ' SELECT  a.val_parametro ';
        lv_sSql := lv_sSql || ' FROM ged_parametros a ';
        lv_sSql := lv_sSql || ' WHERE a.cod_modulo = ' || CV_MODULO_GE;
        lv_sSql := lv_sSql || ' AND a.cod_producto = ' || CV_COD_PRODUCTO;
        lv_sSql := lv_sSql || ' AND a.nom_parametro = ' || EV_nom_parametro;

        SELECT  a.val_parametro
        INTO  LV_val_parametro
        FROM ged_parametros a
        WHERE a.cod_modulo = CV_MODULO_GE
        AND a.cod_producto = CV_COD_PRODUCTO
        AND a.nom_parametro = EV_nom_parametro;

    return LV_val_parametro;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPARAMETRO_FN('|| EV_nom_parametro || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERPARAMETRO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPARAMETRO_FN('|| EV_nom_parametro || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERPARAMETRO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
END;


PROCEDURE PV_CAL_MES_DIA_CONTRATO_PR(SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "PV_CAL_MES_DIA_CONTRATO_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

ERROR_FORMATO     EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_dia_mes        number(2);
ln_acepventa      number(2);
ln_fincontra      number(2);
ln_sumadias       number(2);
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

       -- Meses faltantes finalizar contrato
       --recfincontrato.vigcontrato:= ROUND(MONTHS_BETWEEN(trunc(rec.fec_fincontra), trunc(rec.fec_alta)));
       recfincontrato.vigcontrato:= trunc(rec.fec_fincontra) -  trunc(rec.fec_alta);
       recfincontrato.mes:= ROUND(MONTHS_BETWEEN(trunc(rec.fec_fincontra), sysdate));
       recfincontrato.dias_mes:= trunc(NVL(rec.fec_fincontra,sysdate)) -  trunc(sysdate);
       IF recfincontrato.dias_mes > 0 THEN
           -- Ultimo dia del mes
           ln_dia_mes := TO_CHAR(LAST_DAY(TRUNC(sysdate)),'dd');
           -- Dia del mes acepta venta
           ln_acepventa := TO_CHAR(TRUNC(sysdate),'dd');
           -- Dia Fin contrato
           ln_fincontra := TO_CHAR(TRUNC(rec.fec_fincontra),'dd');

           -- Calcula dias restantes fin contrato
           ln_sumadias :=  (ln_dia_mes - ln_acepventa) + ln_fincontra;
           IF  ln_sumadias > ln_dia_mes THEN
               recfincontrato.dias := ln_sumadias - ln_dia_mes;
           ELSE
               recfincontrato.dias := ln_sumadias;
           END IF;
           recfincontrato.descripcion := recfincontrato.mes || ' meses ' || recfincontrato.dias || ' d¨as';
       ELSE
           recfincontrato.descripcion := '';
       END IF;

    EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno:=4;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
           SV_mens_retorno := CV_ERROR_NO_CLASIF;
        END IF;
        LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_CAL_MES_DIA_CONTRATO_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
        SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
        SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'PV_PENALIZACION_PG.PV_CAL_MES_DIA_CONTRATO_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;

FUNCTION PV_OBTENERPRESTACION_FN(SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)  RETURN VARCHAR2 IS
/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERPRESTACION_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> VARCHAR2 </Retorno>
        <Descripcion>
            grupo de prestaci–n del abonado.
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_grp_prestacion ge_prestaciones_td.grp_prestacion%type;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        lv_sSql := 'SELECT a.grp_prestacion  ';
        lv_sSql := lv_sSql || ' FROM ge_prestaciones_td a';
        lv_sSql := lv_sSql || ' WHERE a.cod_prestacion ='|| rec.cod_prestacion;

        SELECT a.grp_prestacion
        INTO  lv_grp_prestacion
        FROM ge_prestaciones_td a
        WHERE a.cod_prestacion = rec.cod_prestacion;

        return lv_grp_prestacion;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPRESTACION_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERPRESTACION_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPRESTACION_FN(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PENALIZACION_PG.PV_OBTENERPRESTACION_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
END;

PROCEDURE PV_DATOSABONADO_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                             EN_num_abonado    IN ga_abocel.num_abonado%type,
                             SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "PV_DATOSABONADO_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> n+mero del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> n+mero del abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

ERROR_FORMATO     EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
SV_PRESTACION         GE_PRESTACIONES_TD.GRP_PRESTACION%type;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';
      SV_PRESTACION:='';


    lv_sSql := 'SELECT GRP_PRESTACION FROM GE_PRESTACIONES_TD WHERE COD_PRESTACION IN (select COD_PRESTACION from ga_abocel where num_abonado = ' || EN_num_abonado || ')';

    SELECT GRP_PRESTACION
    INTO SV_PRESTACION
    FROM GE_PRESTACIONES_TD
    WHERE COD_PRESTACION IN (
    select COD_PRESTACION from ga_abocel
    where num_abonado = EN_num_abonado);

    lv_sSql := 'SELECT  eq.ind_procequi,';
    lv_sSql := lv_sSql || ' TO_CHAR(ga.fec_fincontra,' || GV_formato_sel2 || '), ';
    lv_sSql := lv_sSql || ' TO_CHAR(ga.fec_acepventa,' || GV_formato_sel2 || '), ';
    lv_sSql := lv_sSql || ' al.des_articulo, ';
    lv_sSql := lv_sSql || ' nvl(eq.imp_cargo,0), ';
    lv_sSql := lv_sSql || ' DECODE(eq.tip_dto,1,nvl(eq.imp_cargo,0) - ((nvl(eq.imp_cargo,0) * nvl(eq.val_dto,0)) /100),nvl(eq.imp_cargo,0)-nvl(eq.val_dto,0)), cli.nom_cliente,cli.nom_apeclien1,cli.nom_apeclien2 ';
    lv_sSql := lv_sSql || ' FROM ga_abocel ga,ga_equipaboser eq,al_articulos al, ga_tipcontrato tip,ge_clientes cli ';
    lv_sSql := lv_sSql || ' WHERE ga.num_abonado = eq.num_abonado ';
    lv_sSql := lv_sSql || ' and ga.num_abonado  = ' || EN_num_abonado ;
    lv_sSql := lv_sSql || ' and ga.num_imei  = eq.num_serie ';
    lv_sSql := lv_sSql || ' and eq.fec_alta = (select max(eq1.fec_alta) from ga_equipaboser eq1 where ga.num_abonado   = eq1.num_abonado and eq1.tip_terminal = T)';
    lv_sSql := lv_sSql || ' and ga.cod_cliente = ' || EN_cod_cliente;
    lv_sSql := lv_sSql || ' and ga.cod_situacion not in ( BAP,BAA,AOP,ATP,TVP,APF)';
    lv_sSql := lv_sSql || ' and eq.cod_articulo = al.cod_articulo';
    lv_sSql := lv_sSql || ' and ga.cod_tipcontrato= tip.cod_tipcontrato';
    lv_sSql := lv_sSql || ' and cli.cod_cliente = ga.cod_cliente';

    IF SV_PRESTACION = 'TM' THEN
        lv_sSql := lv_sSql || '--> TM';
        /*jbs*/
        /* Formatted on 2009/09/23 11:37 (Formatter Plus v4.8.8) */
        SELECT 'M', ga.cod_prestacion,
                -- indicador de procedencia
                lis.ind_procequi,
               --fecha fin de contrato
               TO_DATE (ga.fec_fincontra, 'DD-MM-YY'),
               -- fecha aceptacion de la venta
               TO_DATE (ga.fec_acepventa, 'DD-MM-YY'), al.des_articulo,
               --Precio de Lista del Terminal (Alta/Renov) obtenido desde la ge_cargos
               NVL (lis.prc_venta, 0),
               --Valor pagado por Terminal) obtenido desde la ge_cargos
               DECODE (lis.tip_dto,
                       1, NVL (lis.prc_venta, 0)
                        - ((NVL (lis.prc_venta, 0) * NVL (lis.val_dto, 0)) / 100),
                       NVL (lis.prc_venta, 0) - NVL (lis.val_dto, 0)
                      ),
               cli.nom_cliente, cli.nom_apeclien1, cli.nom_apeclien2, NULL,
               tip.cod_tipcontrato, tip.des_tipcontrato, ta.cod_plantarif,
               ta.des_plantarif, ga.num_contrato, ga.num_anexo, ga.cod_cuenta,
               ga.cod_producto, ga.cod_indemnizacion, ga.fec_alta, ga.fec_prorroga,
               tip.meses_minimo, nvl((car.imp_cargobasico * conv.cambio),0), ga.num_celular, ta.cod_grupo,
               ga.cod_planserv, ga.cod_modventa, ga.cod_ciclo,
               nvl(ga.mto_valor_referencia,0)
              into rec
          FROM ga_abocel ga,
               al_articulos al,
               ge_clientes cli,
               ta_plantarif ta,
               ga_tipcontrato tip,
               ta_cargosbasico car,
               ga_equipaboser lis,
               ge_conversion conv
         WHERE ga.num_abonado = EN_num_abonado
           AND trunc(lis.fec_alta) =
                  (SELECT MAX (trunc(b.fec_alta))
                     FROM  al_articulos c, ga_equipaboser b
                  WHERE b.num_abonado = EN_num_abonado
                      AND b.cod_articulo = c.cod_articulo
                      AND b.tip_terminal = 'T')
           AND ga.cod_cliente = EN_cod_cliente
           AND ga.cod_situacion NOT IN ('BAP', 'BAA', 'AOP', 'ATP', 'TVP', 'APF')
           --AND eq.cod_concepto = al.cod_conceptoart
           AND cli.cod_cliente = ga.cod_cliente
           AND ga.cod_producto = ta.cod_producto
           AND ga.cod_plantarif = ta.cod_plantarif
           AND ga.cod_producto = tip.cod_producto
           AND ga.cod_tipcontrato = tip.cod_tipcontrato
           AND ga.cod_cargobasico = car.cod_cargobasico
           AND conv.cod_moneda    = car.cod_moneda
           AND sysdate between conv.fec_desde and conv.fec_hasta           
           AND SYSDATE >= car.fec_desde
           AND SYSDATE <= NVL (car.fec_hasta, SYSDATE)
           AND lis.num_abonado = ga.num_abonado
           AND lis.cod_articulo = al.cod_articulo
           AND lis.tip_terminal = 'T';
    ELSE
        
          lv_sSql := lv_sSql || '--> ' || SV_PRESTACION;
             SELECT
                'F',
                ga.cod_prestacion,
                -- indicador de procedencia
                'I',
                --fecha fin de contrato
                TO_DATE(ga.fec_fincontra,GV_formato_sel1),
                -- fecha aceptacion de la venta
                TO_DATE(ga.fec_acepventa,GV_formato_sel1),
                'N/A',
                --Precio de Lista del Terminal (Alta/Renov)
                0,
                --Valor pagado por Terminal)
                0,
                cli.nom_cliente,
                cli.nom_apeclien1,
                cli.nom_apeclien2,null,
                tip.cod_tipcontrato,
                tip.des_tipcontrato,
                ta.cod_plantarif,
                ta.des_plantarif,
                ga.num_contrato,
                ga.num_anexo,
                ga.cod_cuenta,
                ga.cod_producto,
                ga.cod_indemnizacion,
                ga.fec_alta,
                ga.fec_prorroga,
                tip.meses_minimo,
                car.imp_cargobasico * conv.cambio,
                ga.num_celular,
                ta.cod_grupo,
                ga.cod_planserv,
                ga.cod_modventa,
                ga.cod_ciclo,
                ga.mto_valor_referencia
            INTO rec
            FROM ga_abocel ga, ge_clientes cli,ta_plantarif ta,ga_tipcontrato tip,ta_cargosbasico car, ge_conversion conv
            WHERE ga.num_abonado  = EN_num_abonado
            and ga.cod_cliente =  EN_cod_cliente
            and ga.cod_situacion not in ( 'BAP','BAA','AOP','ATP','TVP','APF')
            and cli.cod_cliente = ga.cod_cliente
            and ga.cod_producto= ta.cod_producto
            and ga.cod_plantarif = ta.cod_plantarif
            and ga.cod_producto= tip.cod_producto
            and ga.cod_tipcontrato= tip.cod_tipcontrato
            and ga.cod_cargobasico = car.cod_cargobasico
            and conv.cod_moneda    = car.cod_moneda
            and sysdate between conv.fec_desde and conv.fec_hasta           
            and SYSDATE          >= car.fec_desde
            and SYSDATE          <= NVL(car.fec_hasta, SYSDATE);
          
    END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=218;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ERROR_NO_CLASIF;
            END IF;
            LV_des_error := SUBSTR('NO_DATA_FOUND:PV_PENALIZACION_PG.PV_DATOSABONADO_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||');
            - '|| SQLERRM,1,CN_LARGOERRTEC);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
            'PV_PENALIZACION_PG.PV_DATOSABONADO_PR', lv_sSql, SN_cod_retorno, LV_des_error );

        WHEN OTHERS THEN
            SN_cod_retorno:=314;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ERROR_NO_CLASIF;
            END IF;
            LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_DATOSABONADO_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||');
            - '|| SQLERRM,1,CN_LARGOERRTEC);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
            'PV_PENALIZACION_PG.PV_DATOSABONADO_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;

PROCEDURE PV_PENALIZASTANDARD_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                                 EN_num_abonado    IN ga_abocel.num_abonado%type,
                                 EV_cod_modulo     IN ge_modulos.cod_modulo%type,
                                 SV_imp_cargo      OUT NOCOPY varchar2,
                                 SV_ind_autman     OUT NOCOPY varchar2,
                                 SV_cod_retorno    OUT NOCOPY varchar2,
                                 SV_mens_retorno   OUT NOCOPY varchar2)
/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_PENALIZASTANDARD_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"      Tipo="NUMBER> codigo cliente</param>
            <param nom="EN_num_abonado"      Tipo="NUMBER> numero abonado</param>
            <param nom="EV_cod_modulo"       Tipo="VARCHAR2> Modulo</param>
        </Entrada>
        <Salida>
            <param nom="SV_imp_cargo"       Tipo="NUMBER"> Monto </param>
            <param nom="SV_ind_autman"      Tipo="NUMBER"> codigo indicador A – M </param>
            <param nom="SV_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

IS
RESTRICCION_PROCESO  EXCEPTION;
RESTRICCION_OK       EXCEPTION;
PARAM_NO_CONFIG      EXCEPTION;
ERROR_FORMATO        EXCEPTION;
PARAM_PENALIZACION   EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_nom_parametro  ga_parametros_sistema_vw.nom_parametro%type;
lv_codactuacion   ga_parametros_sistema_vw.valor_texto%type;
lv_evento         ga_parametros_sistema_vw.valor_texto%type;
lv_aplicacobro    ga_parametros_sistema_vw.valor_dominio%type;
lv_secuencia      number:=0;
lv_parametro      varchar2(255):='';
lv_cod_retorno    ga_transacabo.cod_retorno%type:='';
lv_des_cadena     ga_transacabo.des_cadena%type:='';
ln_num_evento     ge_errores_pg.Evento:='';
ln_cod_retorno    ge_errores_pg.CodError;
lv_mensaje        ge_errores_pg.DesEvent:='';
lv_cod_servicio   ga_servicios.cod_servicio%type:='';
ln_deducible      number:=0;
lv_grp_prest      ge_prestaciones_td.grp_prestacion%type;
ln_cuotapendpagar number(14,6):=0;
ln_penalizacion_equipo      ga_equipaboser.imp_cargo%type:=0;
ln_penalizacion_terminal    ga_equipaboser.imp_cargo%type:=0;
ln_penalizacion_cargobasico ga_equipaboser.imp_cargo%type:=0;
ln_trafico                  ga_equipaboser.imp_cargo%type:=0;
ln_imp_cargobasico          ta_cargosbasico.imp_cargobasico%type:=0;
ln_imp_penaliza             ga_imppenaliza.imp_penaliza%type:=0;
ln_importe                  co_cancelados.importe_debe%type:=0;
ln_monto_cargo              ga_equipaboser.imp_cargo%type:=0;
ln_valor                    ga_equipaboser.imp_cargo%type:=0;
lv_cod_ciclfact             fa_ciclfact.cod_ciclfact%type;
ln_duracion                 number(16,4);
ln_tot_notcredito           number(14,4):=0;
ld_fecha_max                date;
montoCancelado            ga_equipaboser.imp_cargo%type:=0;
--ln_factor                   number;
BEGIN
             SV_cod_retorno:='0';
             SV_mens_retorno:='';
             montoCancelado:= 0;
/*
             IF MOD(TO_NUMBER(TO_CHAR(sysdate,'yyyy')),4) = 0 THEN
                ln_factor := CN_FACTORBIS;
             ELSE
                ln_factor := CN_FACTOR;
             END IF;
*/
             lv_sSql := 'GE_OBTIENE_OPERADORA_LOCAL_FN';
             GV_cod_oper := GE_OBTIENE_OPERADORA_LOCAL_FN(ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF  ln_cod_retorno <> 0 THEN
                    ln_cod_retorno:=274;
                    raise PARAM_NO_CONFIG;
             END IF;

             lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_FORMATO_SEL2  ||','||CV_MODULO_GE||')';
             GV_formato_sel2 := PV_OBTENERPARAMETRO_FN(CV_FORMATO_SEL2,CV_MODULO_GE,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF ln_cod_retorno <> 0 THEN
                raise ERROR_FORMATO;
             END IF;

             lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_FORMATO_SEL1  ||','||CV_MODULO_GE||')';
             GV_formato_sel1 := PV_OBTENERPARAMETRO_FN(CV_FORMATO_SEL1,CV_MODULO_GE,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF ln_cod_retorno <> 0 THEN
                raise ERROR_FORMATO;
             END IF;


             lv_sSql := 'PV_OBTENERPARAMGENERAL_FN()';
             GN_NC   := PV_OBTENERPARAMGENERAL_FN(ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF  ln_cod_retorno <> 0 THEN
                 raise PARAM_NO_CONFIG;
             END IF;

            --Obtiene datos del abonado
             lv_sSql := 'PV_DATOSABONADO_PR('||EN_cod_cliente||','||EN_num_abonado||')';
             PV_DATOSABONADO_PR(EN_cod_cliente,EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF  ln_cod_retorno <> 0 THEN
                 lv_mensaje:=CV_ERROR_NO_CLASIF;
                 raise RESTRICCION_OK;
             END IF;

             --Valida procedencia equipo
             IF rec.ind_procequi = CV_EXTERNO THEN
               raise RESTRICCION_OK;
             END IF;

/*
             --Valida deducible abonado
             lv_sSql := 'PV_OBTENERDEDUCIBLE_FN('||EN_num_abonado||')';
             ln_deducible := PV_OBTENERDEDUCIBLE_FN(EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF  ln_deducible > 0 THEN
                 raise RESTRICCION_OK;
             END IF;
*/
             --Valida Fecha Ultima renovaci–n
             lv_sSql := 'PV_RENOVACION_FN('||EN_num_abonado||')';
             rec.fec_renovacion := PV_RENOVACION_FN(EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF  ln_cod_retorno <> 0 THEN
                 lv_mensaje:=CV_ERROR_NO_CLASIF;
                 raise PARAM_PENALIZACION;
             END IF;

             -- Calculo vigencia contrato
             if trim(rec.cod_tipcontrato)<>'82' then
                 lv_sSql := 'PV_CAL_MES_DIA_CONTRATO_PR()';
                 PV_CAL_MES_DIA_CONTRATO_PR(ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                 IF  ln_cod_retorno <> 0 THEN
                     lv_mensaje:=CV_ERROR_NO_CLASIF;
                     raise PARAM_PENALIZACION;
                 END IF;

                 IF recfincontrato.dias_mes <=0 THEN
                    raise RESTRICCION_OK;
                 END IF;
             end if;

             --Obtiene tipo de Prestacion Movil – Fija
             lv_sSql := 'PV_OBTENERPRESTACION_FN()';
             lv_grp_prest:=PV_OBTENERPRESTACION_FN(ln_cod_retorno,SV_mens_retorno,ln_num_evento);
             IF CV_GRP_PREST_TM = lv_grp_prest THEN
                IF GV_cod_oper = CV_COD_OPER_TMG THEN
                   --Obtener Suspensiones
                   lv_sSql := 'PV_OBTENER_SUSPENSIONES_FN(' || EN_num_abonado||')';
                   recsuspension.dias_mes := PV_OBTENER_SUSPENSIONES_FN(EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);

                   --Obtener Nota Creditos
                   lv_sSql := 'PV_NOTACREDITO_PR(' || EN_cod_cliente ||','||EN_num_abonado||')';
                   PV_NOTACREDITO_PR(EN_cod_cliente,EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                   IF  ln_cod_retorno <> 0 THEN
                       lv_mensaje:=CV_ERROR_NO_CLASIF;
                       raise PARAM_PENALIZACION;
                   END IF;

                   --Cantidad de Meses por facturados
                   ln_cuotapendpagar := 0;
                   if rec.cod_tipcontrato<>82 then
                     ln_cuotapendpagar := round((recfincontrato.dias_mes - recsuspension.dias_mes)/ 30);
                     IF ln_cuotapendpagar < 0 THEN
                        ln_cuotapendpagar := 0;
                     END IF;
                   end if;

                   --Penalizaci–n por terminales
                       montoCancelado := PV_OBTENCTASCANCELEQUIPO_FN(EN_num_abonado,EN_cod_cliente,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                        ln_penalizacion_terminal := rec.mto_cargo - montoCancelado;

                   --Penalizaci–n por Cargos B+sicos
                     lv_sSql := 'PV_OBTENERCUOTASBASICAS_FN('||EN_cod_cliente||','||EN_num_abonado||')';
                     ln_penalizacion_cargobasico:=0;
                     IF ln_cuotapendpagar > 0 THEN
                        ln_monto_cargo := PV_OBTENERCUOTASBASICAS_FN(EN_cod_cliente,EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                        IF ln_monto_cargo > 0 THEN
                           IF nc_abonado.count > 0 THEN
                              ln_tot_notcredito := nc_abonado(0).tot_notcredito;
                           END IF;

                           ln_penalizacion_cargobasico:=nvl(((ln_monto_cargo*ln_cuotapendpagar) - ln_tot_notcredito),0);
                           IF ln_penalizacion_cargobasico < 0 THEN
                                 ln_penalizacion_cargobasico:=ln_penalizacion_cargobasico + (rec.IMP_CARGOBASICO * ln_cuotapendpagar);
                           END IF;
                        ELSE
                           ln_penalizacion_cargobasico:=ln_penalizacion_cargobasico + (rec.IMP_CARGOBASICO * ln_cuotapendpagar);
                        END IF;
                     END IF;
                     
                     --OCB INI PENALIZA
                     
                     IF ln_penalizacion_terminal > ln_penalizacion_cargobasico THEN
                            SV_imp_cargo := ln_penalizacion_terminal;
                     END IF ;
                     
                     
                     IF ln_penalizacion_terminal < ln_penalizacion_cargobasico THEN
                            SV_imp_cargo :=  ln_penalizacion_cargobasico; 
                     END IF ;
                     
                     --OCB FIN PENALIZA
                    
                ELSE
                      IF rec.cod_modventa IN (CV_CREDITO,CV_CREDITO_CONSIGNACION) THEN
                         lv_sSql := 'PV_OBTENERTOTCANCUOTAS_FN('||EN_cod_cliente||','||EN_num_abonado||','||ln_cod_retorno||','||SV_mens_retorno||','||ln_num_evento||')';
                         ln_importe :=PV_OBTENERTOTCANCUOTAS_FN(EN_cod_cliente,EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                         IF  ln_cod_retorno <> 0 THEN
                             lv_mensaje:=CV_ERROR_NO_CLASIF;
                             raise PARAM_PENALIZACION;
                         END IF;
                      ELSE
                         ln_importe :=0;
                      END IF;

                      IF rec.imp_cargo > 0 AND recfincontrato.dias_mes > 0 THEN
                         ln_valor:=round(recfincontrato.dias_mes/30);
                         if ln_valor>0 then
                            ln_valor := rec.imp_cargo*(round(recfincontrato.dias_mes/30));
                         end if;
                      ELSE
                         ln_valor :=0;
                      END IF;

                      LV_cod_ciclfact:=PV_OBTENERCICLO_FN(LN_cod_retorno,SV_mens_retorno,LN_num_evento);
                      IF LN_cod_retorno <> 0 THEN
                       raise PARAM_PENALIZACION;
                      END IF;

                      ln_trafico := 0;
                      TOL_CONSULTA_TRAFICO_PG.Tol_Consumo_Cliente_Pr@LNK_PRODUC_SCL_TOL(EN_num_abonado,EN_cod_cliente,LV_cod_ciclfact,rec.cod_ciclo,ln_duracion,ld_fecha_max,LN_cod_retorno,SV_mens_retorno,LN_num_evento);
                      IF LN_cod_retorno<>0 THEN
                          IF rec.mto_valor_referencia > 0 AND ln_duracion > 0 THEN
                             ln_trafico := rec.mto_valor_referencia * (ln_duracion * 60);
                          END IF;
                      END IF;

                      ln_penalizacion_equipo :=  (ln_trafico +  ln_valor) - ln_importe;
                      SV_imp_cargo := ln_penalizacion_equipo;
                END IF;
             ELSIF CV_GRP_PREST_TF = lv_grp_prest THEN
                   rec.ind_movilfijo :='F';
              IF GV_cod_oper = CV_COD_OPER_TMG THEN
                   --cargos b+sicos pendientes de facturar hasta el termino de contrato.
                    IF recfincontrato.dias_mes > 0 AND rec.imp_cargobasico > 0 THEN
                       ln_imp_cargobasico := rec.imp_cargobasico; --* (round(recfincontrato.dias_mes/30));
                    ELSE
                       ln_imp_cargobasico :=0;
                    END IF;
                               -- cargo indemnizacion fijo = valor en ga_abocel cod_indemnizacion = 1
                    IF rec.cod_indemnizacion = 1 THEN
                       lv_sSql := 'PV_STANDARD_PR('||EN_num_abonado||','||ln_imp_penaliza||','||SV_ind_autman||','||ln_cod_retorno||','||SV_mens_retorno||','||ln_num_evento||')';
                       PV_STANDARD_PR(EN_num_abonado,ln_imp_penaliza,SV_ind_autman,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                    ELSIF rec.cod_indemnizacion = 2 THEN
                       lv_sSql := 'PV_ESCALONADA_PR('||EN_num_abonado||','||ln_imp_penaliza||','||SV_ind_autman||','||ln_cod_retorno||','||SV_mens_retorno||','||ln_num_evento||')';
                       PV_ESCALONADA_PR(EN_num_abonado,ln_imp_penaliza,SV_ind_autman,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                    ELSE
                       ln_imp_penaliza:=0;
                    END IF;

                    IF  ln_cod_retorno <> 0 THEN
                        lv_mensaje:=CV_ERROR_NO_CLASIF;
                        raise PARAM_PENALIZACION;
                    END IF;

                    
                    --OCB INI PENALIZA
                     
                     IF ln_penalizacion_terminal > ln_penalizacion_cargobasico THEN
                            SV_imp_cargo := ln_penalizacion_terminal;
                     END IF ;
                     
                     
                     IF ln_penalizacion_terminal < ln_penalizacion_cargobasico THEN
                            SV_imp_cargo :=  ln_penalizacion_cargobasico; 
                     END IF ;
                     
                     --OCB FIN PENALIZA
                    
              ELSE
                   lv_sSql := 'PV_OBTENERTOTCANCUOTAS_FN('||EN_cod_cliente||','||EN_num_abonado||','||ln_cod_retorno||
                   ','||SV_mens_retorno||','||ln_num_evento||')';
                   ln_importe :=PV_OBTENERTOTCANCUOTAS_FN(EN_cod_cliente,EN_num_abonado,ln_cod_retorno,SV_mens_retorno,ln_num_evento);
                   IF  ln_cod_retorno <> 0 THEN
                       lv_mensaje:=CV_ERROR_NO_CLASIF;
                       raise PARAM_PENALIZACION;
                   END IF;

                   ln_penalizacion_equipo :=  rec.imp_cargo - ln_importe;
                   SV_imp_cargo := ln_penalizacion_equipo;
              END IF;
             ELSE
                SV_imp_cargo :=0;
             END IF;

EXCEPTION

    WHEN PARAM_PENALIZACION THEN
      ln_cod_retorno:=4;
      SV_cod_retorno:=ln_cod_retorno;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(ln_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := lv_mensaje;
      END IF;
      LV_des_error := SUBSTR('PARAM_PENALIZACION:PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR('||  EN_num_abonado ||');
      - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      ln_num_evento := Ge_Errores_Pg.Grabarpl(ln_num_evento,EV_cod_modulo,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR', lv_sSql, ln_cod_retorno, LV_des_error );
    WHEN ERROR_FORMATO THEN
      ln_cod_retorno:=143;
      SV_cod_retorno:=ln_cod_retorno;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(ln_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('ERROR_FORMATO:PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR('||  EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      ln_num_evento := Ge_Errores_Pg.Grabarpl(ln_num_evento,EV_cod_modulo,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR', lv_sSql, ln_cod_retorno, LV_des_error );
    WHEN RESTRICCION_OK THEN
      SV_cod_retorno:='0';
      SV_imp_cargo:='0';
      SV_ind_autman :='A';
    WHEN RESTRICCION_PROCESO THEN
      ln_cod_retorno := 3;
      SV_cod_retorno:=ln_cod_retorno;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(ln_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := lv_mensaje;
      END IF;
      LV_des_error := SUBSTR('RESTRICCION_PROCESO:PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR('|| EN_num_abonado || '); - '
      || SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      ln_num_evento := Ge_Errores_Pg.Grabarpl(ln_num_evento,EV_cod_modulo,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR', lv_sSql, ln_cod_retorno, LV_des_error );
   WHEN PARAM_NO_CONFIG THEN
      SV_cod_retorno:=ln_cod_retorno;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(ln_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('PARAM_NO_CONFIG:PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR(('|| EN_num_abonado || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      ln_num_evento := Ge_Errores_Pg.Grabarpl(ln_num_evento,EV_cod_modulo,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR', lv_sSql, ln_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      ln_cod_retorno:=4;
      SV_cod_retorno:=ln_cod_retorno;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(ln_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR(('|| EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
      ln_num_evento := Ge_Errores_Pg.Grabarpl(ln_num_evento,EV_cod_modulo,SV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZASTANDARD_PR', lv_sSql, ln_cod_retorno, LV_des_error );
END;


PROCEDURE PV_INDEMNIZACION_PR (EN_num_abonado       IN  ga_abocel.num_abonado%type,
                               EV_modulo            IN  ge_modulos.cod_modulo%type,
                               SV_ind_autman        OUT NOCOPY varchar2,
                               SV_imp_cargo         OUT NOCOPY varchar2,
                               SV_cod_concepto      OUT NOCOPY varchar2,
                               SV_cod_retorno       OUT NOCOPY varchar2,
                               SV_mens_retorno      OUT NOCOPY varchar2)
/*--
        <Documentacion TipoDoc = "procedure">
            Elemento Nombre = "PV_INDEMNIZACION_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Procedimiento Utilizado por Cargos obtener monto penalizaci–n x abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_num_abonado"     Tipo="NUMBER"> numero del abonado</param>
            <param nom="EV_modulo"          Tipo="VARCHAR"> modulo</param>
        </Entrada>
        <Salida>
            <param nom="SV_ind_autman"      Tipo="VARCHAR"> indicador  </param>
            <param nom="SV_imp_cargo"       Tipo="VARCHAR"> monto penalizacion </param>
            <param nom="SV_cod_concepto"    Tipo="VARCHAR"> concepto </param>
            <param nom="SV_cod_retorno"     Tipo="VARCHAR"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="VARCHAR"> glosa mensaje error </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
IS
        NO_APLICA               EXCEPTION;
        lv_nom_procedure        pv_plan_indemnizacion_td.nom_procedure%type;
        lv_comando              varchar2(100);
        ln_cod_cliente          ga_abocel.cod_cliente%type;
        lv_aplicacobro    ga_parametros_sistema_vw.valor_dominio%type;
        lv_des_error      ge_errores_pg.DesEvent;
        lv_sSql           ge_errores_pg.vQuery;
        LN_CANTIDAD       INTEGER;
        LV_COD_CAUSA      PV_PARAM_ABOCEL.COD_CAUSA%TYPE;
        SN_cod_retorno    ge_errores_pg.CodError;
        lv_cod_situacion  ga_Abocel.cod_situacion%type;
        SN_num_evento     ge_errores_pg.Evento;
BEGIN
       
--marca

        --- LMV, 28-09-2010 incidencia 147398  proyecto Guatemala
        SV_cod_retorno:='0';
        SV_imp_cargo:='';
        SV_ind_autman :='A';
        SV_mens_retorno:='';


        lv_sSql :='PV_OBTENERPARAM_PR('|| CV_NOMPARAMCOBR ||')';
        PV_OBTENERPARAM_PR(CV_NOMPARAMCOBR,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno = 0 THEN
             lv_aplicacobro:= TRIM(rec_param.valor_dominio);
        
        END IF;

        IF lv_aplicacobro = 'TRUE' THEN --aplica cobro por penalizacion


                      select  cod_situacion 
                      into lv_cod_situacion
                      from ga_Abocel
                      where num_abonado =EN_num_abonado
                      union
                      select  cod_situacion 
                      from ga_Aboamist
                      where num_abonado =EN_num_abonado;
                      
                      
                      if TRIM(lv_cod_situacion)='BAP' THEN
                      
                          BEGIN
                          
                          
                          SELECT  COD_CAUSA INTO LV_COD_CAUSA 
                          FROM PV_PARAM_ABOCEL
                          WHERE NUM_OS IN (SELECT NUM_OS FROM PV_CAMCOM 
                                           WHERE NUM_ABONADO =  EN_num_abonado);                     
                      
                      
                          EXCEPTION
                                  WHEN NO_DATA_FOUND THEN
                                  NULL;
                          
                          END; 
                          
                          LN_CANTIDAD:= 0;
                          
                          IF TRIM(LV_COD_CAUSA) <> ' ' THEN
                                  BEGIN
                                    
                                          SELECT COUNT(1) INTO LN_CANTIDAD
                                          FROM GA_CAUSABAJA
                                          WHERE IND_FRAUDE = 1 
                                          AND COD_CAUSABAJA =  LV_COD_CAUSA;
                                                                            
                                          IF LN_CANTIDAD> 0 THEN
                                                raise NO_APLICA;---- NO aplica cobro por penalizacion PORQUE LA CAUSA DE BAJA ES FRAUDE
                                          END IF; 
                                      
                                  EXCEPTION
                                          WHEN NO_DATA_FOUND THEN
                                          NULL;
                                  
                                  
                                  END;
                          END IF;   
                                         
                      END IF;

                       BEGIN
                         SELECT a.cod_cliente,B.nom_procedure, B.cod_concepto
                         INTO   ln_cod_cliente,lv_nom_procedure, sv_cod_concepto
                         FROM ga_abocel a, pv_plan_indemnizacion_td b
                         WHERE A.num_abonado = EN_num_abonado
                         AND   A.cod_indemnizacion = B.cod_plan_indemnizacion;

                        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            raise NO_APLICA;
                       END;

                         LV_COMANDO:= 'BEGIN ' || LV_nom_procedure ||' (:a,:b,:c,:d,:e,:f,:g); END;';
                         EXECUTE IMMEDIATE LV_COMANDO USING IN ln_cod_cliente,IN EN_num_abonado, IN EV_modulo,OUT SV_imp_cargo,
                         OUT SV_ind_autman, OUT SV_cod_retorno, OUT SV_mens_retorno;

                         SV_ind_autman:=NVL(SV_ind_autman,'A');
                         IF TRIM(SV_imp_cargo) = '0' THEN
                            SV_imp_cargo:='';
                         END IF;
                         SV_cod_concepto:=NVL(SV_cod_concepto,'');
                         SV_cod_retorno := NVL(SV_cod_retorno,'0');


        end if;    

EXCEPTION
      WHEN NO_APLICA THEN
        SV_cod_retorno:='0';
        SV_imp_cargo:='';
        SV_ind_autman :='A';
        SV_mens_retorno:='';
      WHEN OTHERS THEN
        SV_cod_retorno:='2';
        SV_mens_retorno:= SQLERRM;
END PV_INDEMNIZACION_PR;

PROCEDURE PV_PENALIZACION_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                             EN_num_abonado    IN ga_abocel.num_abonado%type,
                             cursor_pen        OUT NOCOPY cursorTYPE) IS
/*--
        <Documentacion TipoDoc = "procedure">
            Elemento Nombre = "PV_PENALIZACION_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Dise¨ador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> NA </Retorno>
        <Descripcion>
            Proceso Main de penalizaci–n todos los abonados cliente y num_abonado = 0
                                         solo abonado cliente y num_abonado <> 0
        </Descripcion>
        <Parametros>
        <Entrada>
        <param nom="EN_cod_cliente"       Tipo="NUMBER"> codigo del cliente</param>
        <param nom="EN_num_abonado"       Tipo="NUMBER"> numero del abonado</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
   cursor_abo cursorTYPE;     -- declare cursor variable         --

   PARAM_NO_CONFIG   EXCEPTION;
   PARAM_CONFIG      EXCEPTION;
   ERROR_FORMATO     EXCEPTION;
   PARAM_ENTRADA_CONFIG EXCEPTION;
   PARAM_PENALIZACION  EXCEPTION;
   lv_des_error      ge_errores_pg.DesEvent;
   lv_sSql           ge_errores_pg.vQuery;
   lv_grp_prest      ge_prestaciones_td.grp_prestacion%type;
   ln_imp_cargobasico ta_cargosbasico.imp_cargobasico%type:=0;
   ln_imp_penaliza   ga_imppenaliza.imp_penaliza%type:=0;
   lv_ind_autman     ga_servicios.ind_autman%type;
   ln_importe        co_cancelados.importe_debe%type:=0;
   ln_penalizacion_equipo      ga_equipaboser.imp_cargo%type:=0;
   ln_penalizacion_terminal    ga_equipaboser.imp_cargo%type:=0;
   ln_penalizacion_cargobasico ga_equipaboser.imp_cargo%type:=0;
   ln_monto_cargo              ga_equipaboser.imp_cargo%type:=0;
   ln_trafico                  ga_equipaboser.imp_cargo%type:=0;
   ln_valor                    ga_equipaboser.imp_cargo%type:=0;
   ln_cuotapendpagar           number(14,6):=0;
   ln_deducible                number:=0;
   lv_mensaje                  ge_errores_pg.DesEvent;
   LN_num_abonado              ga_abocel.num_abonado%type;
   LN_cod_cliente              ga_abocel.cod_cliente%type;
   LV_cod_ciclfact             fa_ciclfact.cod_ciclfact%type;
   LN_cod_retorno              ge_errores_pg.CodError;
   LV_mens_retorno             ge_errores_pg.MsgError;
   LN_num_evento               ge_errores_pg.Evento;
   ln_duracion                 number(16,4);
   ld_fecha_max                date;
  -- ln_factor                   number;
   ln_tot_notcredito           number(14,4):=0;
   LEE_OTRO                    EXCEPTION;
   montoCancelado            ga_equipaboser.imp_cargo%type:=0;

BEGIN
        LN_num_evento:= 0;
        LN_cod_retorno:=0;
        LV_mens_retorno:='';
/*
        IF MOD(TO_NUMBER(TO_CHAR(sysdate,'yyyy')),4) = 0 THEN
           ln_factor := CN_FACTORBIS;
        ELSE
           ln_factor := CN_FACTOR;
        END IF;
*/
        lv_sSql := 'GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        GV_cod_oper := GE_OBTIENE_OPERADORA_LOCAL_FN(LN_cod_retorno,LV_mens_retorno,LN_num_evento);
        IF  LN_cod_retorno <> 0 THEN
            LN_cod_retorno:=274;
            raise PARAM_NO_CONFIG;
        END IF;

        lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_FORMATO_SEL2  ||','||CV_MODULO_GE||')';
        GV_formato_sel2 := PV_OBTENERPARAMETRO_FN(CV_FORMATO_SEL2,CV_MODULO_GE,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
        IF LN_cod_retorno <> 0 THEN
          raise ERROR_FORMATO;
        END IF;
        lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_FORMATO_SEL1  ||','||CV_MODULO_GE||')';
        GV_formato_sel1 := PV_OBTENERPARAMETRO_FN(CV_FORMATO_SEL1,CV_MODULO_GE,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
        IF LN_cod_retorno <> 0 THEN
          raise ERROR_FORMATO;
        END IF;

        lv_sSql := 'PV_OBTENERPARAMGENERAL_FN()';
        GN_NC   := PV_OBTENERPARAMGENERAL_FN(LN_cod_retorno,LV_mens_retorno,LN_num_evento);
        IF  LN_cod_retorno <> 0 THEN
            raise PARAM_NO_CONFIG;
        END IF;


       lv_sSql :='SELECT a.num_abonado,a.cod_cliente  FROM ga_abocel a WHERE ';

       IF EN_cod_cliente <> 0 AND EN_num_abonado <> 0 THEN
          lv_sSql :=lv_sSql || ' a.num_abonado = :1 ';
          lv_sSql :=lv_sSql || ' AND a.cod_cliente = :2';
          lv_sSql :=lv_sSql || ' AND a.cod_situacion NOT IN (:3,:4,:5,:6,:7,:8)';
          lv_sSql :=lv_sSql || ' AND A.COD_PRESTACION IN (select cod_prestacion from ge_prestaciones_td where grp_prestacion  in (:9,:10))';
          OPEN cursor_abo FOR lv_sSql USING EN_num_abonado,EN_cod_cliente,'BAP','BAA','AOP','ATP','TVP','APF','TM','TF';
       ELSE
          IF EN_cod_cliente <> 0 AND EN_num_abonado = 0 THEN
              lv_sSql :=lv_sSql || ' a.cod_cliente = :1 ';
              lv_sSql :=lv_sSql || ' AND a.cod_situacion NOT IN (:2,:3,:4,:5,:6,:7)';
              lv_sSql :=lv_sSql || ' AND A.COD_PRESTACION IN (select cod_prestacion from ge_prestaciones_td where grp_prestacion  in (:8,:9))';
              OPEN cursor_abo FOR lv_sSql USING EN_cod_cliente,'BAP','BAA','AOP','ATP','TVP','APF','TM','TF';
         else
              lv_sSql :=lv_sSql || ' a.num_abonado = :1 ';
              lv_sSql :=lv_sSql || ' AND a.cod_situacion NOT IN (:2,:3,:4,:5,:6,:7)';
              lv_sSql :=lv_sSql || ' AND A.COD_PRESTACION IN (select cod_prestacion from ge_prestaciones_td where grp_prestacion  in (:8,:9))';
              OPEN cursor_abo FOR lv_sSql USING EN_num_abonado,'BAP','BAA','AOP','ATP','TVP','APF','TM','TF';

         end if;

       END IF;

       LOOP
       BEGIN
             FETCH cursor_abo INTO LN_num_abonado,LN_cod_cliente;
             EXIT WHEN cursor_abo%NOTFOUND;

             ln_imp_cargobasico:=0;
             ln_imp_penaliza:=0;
             ln_importe:=0;
             ln_penalizacion_equipo:=0;
             ln_penalizacion_terminal:=0;
             ln_penalizacion_cargobasico:=0;
             ln_trafico:=0;
             ln_cuotapendpagar:=0;
             ln_deducible:=0;

             --Obtiene datos del abonado
             lv_sSql := 'PV_DATOSABONADO_PR('||LN_cod_cliente||','||LN_num_abonado||')';
             PV_DATOSABONADO_PR(LN_cod_cliente,LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
             IF  LN_cod_retorno <> 0 THEN
                 lv_mensaje:=CV_ERROR_NO_CLASIF;
                 raise LEE_OTRO;
             END IF;

            CASE  rec.ind_procequi
             WHEN CV_INTERNO THEN
             /*
             --Valida deducible abonado
             lv_sSql := 'PV_OBTENERDEDUCIBLE_FN('||LN_num_abonado||')';
             ln_deducible := PV_OBTENERDEDUCIBLE_FN(LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
             IF  ln_deducible > 0 THEN
                 ln_penalizacion_equipo:=0;
                 ln_penalizacion_terminal:=0;
                 ln_penalizacion_cargobasico:=0;
             ELSE
             */
               --Valida Fecha Ultima renovaci–n
               lv_sSql := 'PV_RENOVACION_FN('||LN_num_abonado||')';
               rec.fec_renovacion := PV_RENOVACION_FN(LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
               IF  LN_cod_retorno <> 0 THEN
                   lv_mensaje:=CV_ERROR_NO_CLASIF;
                   raise LEE_OTRO;
               END IF;

               -- Calculo vigencia contrato
               lv_sSql := 'PV_CAL_MES_DIA_CONTRATO_PR()';
               PV_CAL_MES_DIA_CONTRATO_PR(LN_cod_retorno,LV_mens_retorno,LN_num_evento);
               IF  LN_cod_retorno <> 0 THEN
                   lv_mensaje:=CV_ERROR_NO_CLASIF;
                   raise LEE_OTRO;
               END IF;

               IF recfincontrato.dias_mes <=0 THEN
                   ln_penalizacion_equipo:=0;
                   ln_penalizacion_terminal:=0;
                   ln_penalizacion_cargobasico:=0;
                   LV_mens_retorno:='Vigencia del Contrato a finalizado ';
               ELSE
                      --Obtiene tipo de Prestacion Movil – Fija
                      lv_sSql := 'PV_OBTENERPRESTACION_FN()';
                      lv_grp_prest:=PV_OBTENERPRESTACION_FN(LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                      IF CV_GRP_PREST_TM = lv_grp_prest THEN
                         IF GV_cod_oper = CV_COD_OPER_TMG THEN
                            --Obtener Suspensiones
                             lv_sSql := 'PV_OBTENER_SUSPENSIONES_FN(' || LN_num_abonado||')';
                             recsuspension.dias_mes := PV_OBTENER_SUSPENSIONES_FN(LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                             --Obtener Nota Creditos
                             lv_sSql := 'PV_NOTACREDITO_PR(' || LN_cod_cliente ||','||LN_num_abonado||')';
                             PV_NOTACREDITO_PR(LN_cod_cliente,LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                             IF  LN_cod_retorno <> 0 THEN
                                 lv_mensaje:=CV_ERROR_NO_CLASIF;
                                 raise LEE_OTRO;
                             END IF;
                             --Cantidad de Meses por facturados
                             ln_cuotapendpagar:=round((nvl(recfincontrato.dias_mes,0) - nvl(recsuspension.dias_mes,0))/30);
                             IF ln_cuotapendpagar < 0 THEN
                                ln_cuotapendpagar := 0;
                             END IF;

                             --Penalizaci–n por terminales
                             montoCancelado := PV_OBTENCTASCANCELEQUIPO_FN(LN_num_abonado,LN_cod_cliente,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                             ln_penalizacion_terminal := rec.mto_cargo - montoCancelado;

                            --Penalizaci–n por Cargos B+sicos
                             lv_sSql := 'PV_OBTENERCUOTASBASICAS_FN('||LN_cod_cliente||','||LN_num_abonado||')';
                             IF ln_cuotapendpagar > 0 THEN
                                ln_monto_cargo :=  PV_OBTENERCUOTASBASICAS_FN(LN_cod_cliente,LN_num_abonado,ln_cod_retorno,LV_mens_retorno,ln_num_evento);

                                IF ln_monto_cargo > 0 THEN
                                   IF nc_abonado.count > 0 THEN
                                      ln_tot_notcredito := nc_abonado(0).tot_notcredito;
                                   ELSE
                                      ln_tot_notcredito := 0;
                                   END IF;

                                   ln_penalizacion_cargobasico:=(ln_monto_cargo*ln_cuotapendpagar) - ln_tot_notcredito;
                                   IF ln_penalizacion_cargobasico < 0 THEN
                                      ln_penalizacion_cargobasico:=ln_penalizacion_cargobasico+ (rec.IMP_CARGOBASICO*ln_cuotapendpagar);
                                   END IF;
                                ELSE
                                    ln_penalizacion_cargobasico:=ln_penalizacion_cargobasico+ (rec.IMP_CARGOBASICO*ln_cuotapendpagar);
                                END IF;
                             ELSE
                                ln_penalizacion_cargobasico:=0;
                             END IF;
                                
                             
                                                       
                            
                            
                         ELSE
                            IF rec.cod_modventa IN (CV_CREDITO,CV_CREDITO_CONSIGNACION) THEN
                             lv_sSql := 'PV_OBTENERTOTCANCUOTAS_FN('||LN_cod_cliente||','||LN_num_abonado||','||LN_cod_retorno||','||LV_mens_retorno||','||LN_num_evento||')';
                             ln_importe :=PV_OBTENERTOTCANCUOTAS_FN(LN_cod_cliente,LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                             IF  LN_cod_retorno <> 0 THEN
                                 lv_mensaje:=CV_ERROR_NO_CLASIF;
                                 raise LEE_OTRO;
                             END IF;
                            ELSE
                             ln_importe :=0;
                            END IF;

                            IF rec.imp_cargo > 0 AND recfincontrato.dias_mes > 0 THEN
                                ln_valor:=round(recfincontrato.dias_mes/30);
                                if ln_valor>0 then
                                   ln_valor := rec.imp_cargo*(round(recfincontrato.dias_mes/30));
                                end if;
                            ELSE
                                ln_valor :=0;
                            END IF;


                            LV_cod_ciclfact:=PV_OBTENERCICLO_FN(LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                            IF LN_cod_retorno <> 0 THEN
                               raise LEE_OTRO;
                            END IF;
                           
                            TOL_CONSULTA_TRAFICO_PG.Tol_Consumo_Cliente_Pr@LNK_PRODUC_SCL_TOL(LN_num_abonado,LN_cod_cliente,LV_cod_ciclfact,rec.cod_ciclo,ln_duracion,ld_fecha_max,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                            ln_trafico := 0;
                            IF LN_cod_retorno<>0 THEN
                               IF rec.mto_valor_referencia > 0 AND ln_duracion > 0 THEN
                                  ln_trafico := rec.mto_valor_referencia * (ln_duracion * 60);
                               END IF;
                            END IF;
                            ln_penalizacion_terminal  :=  (ln_trafico +  ln_valor) - ln_importe;
                         END IF;
                         
                         
                         
                      ELSIF CV_GRP_PREST_TF = lv_grp_prest THEN
                            rec.ind_movilfijo :='F';
                            IF GV_cod_oper = CV_COD_OPER_TMG THEN
                               --cargos b+sicos pendientes de facturar hasta el termino de contrato.
                               IF recfincontrato.dias_mes > 0 AND rec.imp_cargobasico > 0 THEN
                                   --ln_imp_cargobasico:=round(recfincontrato.dias_mes /30);
                                   --if  ln_imp_cargobasico > 0 then
                                   ln_imp_cargobasico := rec.imp_cargobasico ;--* (round(recfincontrato.dias_mes /30));
                                   --else
                                   --ln_imp_cargobasico :=0;
                                   --end if;
                               ELSE
                                   ln_imp_cargobasico :=8;
                               END IF;
                               -- cargo indemnizacion fijo = valor en ga_abocel cod_indemnizacion = 1
                               IF rec.cod_indemnizacion = 1 THEN
                                  lv_sSql := 'PV_STANDARD_PR('||LN_num_abonado||','||ln_imp_penaliza||','||lv_ind_autman||','||LN_cod_retorno||','||LV_mens_retorno||','||LN_num_evento||')';
                                  PV_STANDARD_PR(LN_num_abonado,ln_imp_penaliza,lv_ind_autman,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                               ELSIF rec.cod_indemnizacion = 2 THEN
                                  lv_sSql := 'PV_ESCALONADA_PR('||LN_num_abonado||','||ln_imp_penaliza||','||lv_ind_autman||','||LN_cod_retorno||','||LV_mens_retorno||','||LN_num_evento||')';
                                  PV_ESCALONADA_PR(LN_num_abonado,ln_imp_penaliza,lv_ind_autman,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                               ELSE
                                  ln_imp_penaliza:=0;
                               END IF;

                               IF  LN_cod_retorno <> 0 THEN
                                   lv_mensaje:=CV_ERROR_NO_CLASIF;
                                   raise LEE_OTRO;
                               END IF;

                               ln_penalizacion_equipo := ln_imp_penaliza + ln_imp_cargobasico;
                            ELSE
                               lv_sSql := 'PV_OBTENERTOTCANCUOTAS_FN('||LN_cod_cliente||','||LN_num_abonado||','||LN_cod_retorno||','||LV_mens_retorno||','||LN_num_evento||')';
                               ln_importe :=PV_OBTENERTOTCANCUOTAS_FN(LN_cod_cliente,LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
                               IF  LN_cod_retorno <> 0 THEN
                                   lv_mensaje:=CV_ERROR_NO_CLASIF;
                                    raise LEE_OTRO;
                               END IF;

                               ln_penalizacion_equipo :=  rec.imp_cargo - ln_importe;
                            END IF;
                      ELSE
                             ln_penalizacion_equipo:=0;
                             ln_penalizacion_terminal:=0;
                             ln_penalizacion_cargobasico:=0;
                             lv_mensaje:=CV_MOVILFIJO;
                      END IF;
               END IF;
--             END IF;

            WHEN CV_EXTERNO THEN
                ln_penalizacion_equipo:=0;
                ln_penalizacion_terminal:=0;
                ln_penalizacion_cargobasico:=0;
                LV_mens_retorno :=CV_PROCEDENCIA;
            END CASE;

                      PV_DATOS_PR(LN_num_abonado,
                      LN_cod_cliente,
                      rec.ind_movilfijo,
                      rec.cod_prestacion,
                      1,--rec.mto_mingarantizado,
                      rec.fec_fincontra,
                      rec.fec_acepventa,
                      rec.num_contrato,
                      rec.num_anexo,
                      rec.cod_cuenta,
                      rec.cod_indemnizacion,
                      rec.fec_alta,
                      rec.fec_prorroga,
                      rec.fec_renovacion,
                      recfincontrato.descripcion,
                      rec.imp_cargo,
                      rec.mto_cargo,
                      rec.des_articulo,
                      rec.nom_cliente,
                      rec.nom_apeclien1,
                      rec.nom_apeclien2,
                      rec.cod_tipcontrato,
                      rec.des_tipcontrato,
                      rec.meses_minimo,
                      rec.imp_cargobasico,
                      rec.cod_plantarif,
                      rec.des_plantarif,
                      ln_penalizacion_terminal,
                      ln_penalizacion_cargobasico,
                      ln_penalizacion_equipo,
                      ln_imp_penaliza,
                      ln_trafico,
                      ln_importe,
                      LN_cod_retorno,
                      LV_mens_retorno,
                      rec.num_celular,
                      LN_cod_retorno,
                      LV_mens_retorno,
                      LN_num_evento);
              if ln_cod_retorno<>0 then
                 raise lee_otro;
              end if;
      EXCEPTION
      WHEN LEE_OTRO THEN
           NULL;
           LN_cod_retorno:=0;
           LV_mens_retorno:='';
      END;
      END LOOP;
      CLOSE cursor_abo;

      --Lee registros
      OPEN cursor_pen FOR
      SELECT  NUM_ABONADO,COD_CLIENTE,IND_MOVILFIJO,COD_PRESTACION,MTO_MINGARANTIZADO,FEC_FINCONTRA,FEC_ACEPVENTA,
              NUM_CONTRATO,NUM_ANEXO,COD_CUENTA,COD_INDEMNIZACION,FEC_ALTA,FEC_PRORROGA,FEC_RENOVACION,DES_MESES,IMP_CARGO,
              MTO_CARGO,DES_ARTICULO,NOM_CLIENTE,NOM_APECLIEN1,NOM_APECLIEN2,COD_TIPCONTRATO,DES_TIPCONTRATO,MESES_MINIMO,
              IMP_CARGOBASICO,COD_PLANTARIF,DES_PLANTARIF,PEN_TERMINAL,PEN_CARGOBASICO,PEN_EQUIPO,IMP_PENALIZA,IMP_TRAFICO,
              IMP_CUOTAS, COD_ERROR, DESCRIPCION_ERROR,NUM_CELULAR
      FROM PV_PENALIZACION_TMP;

EXCEPTION
    WHEN PARAM_PENALIZACION THEN
      CLOSE cursor_abo;
      LN_cod_retorno:=0;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := lv_mensaje;
      END IF;
      LV_des_error := SUBSTR('PARAM_PENALIZACION:PV_PENALIZACION_PG.PV_PENALIZACION_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      LV_mens_retorno:=SUBSTR(LV_mens_retorno,1,CN_LARGODESC);
      LN_num_evento := Ge_Errores_Pg.Grabarpl(LN_num_evento,CV_MODULO_GA,LV_mens_retorno, '1.0', USER,'PV_PENALIZACION_PG.PV_PENALIZACION_PR', lv_sSql, LN_cod_retorno, LV_des_error );
    WHEN ERROR_FORMATO THEN
      LN_cod_retorno:=143;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('ERROR_FORMATO:PV_PENALIZACION_PG.PV_PENALIZACION_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      LV_mens_retorno:=SUBSTR(LV_mens_retorno,1,CN_LARGODESC);
      LN_num_evento := Ge_Errores_Pg.Grabarpl(LN_num_evento,CV_MODULO_GA,LV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZACION_PR', lv_sSql, LN_cod_retorno, LV_des_error );

    WHEN PARAM_ENTRADA_CONFIG THEN
      LN_cod_retorno:=98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('PARAM_CONFIG:PV_PENALIZACION_PG.PV_PENALIZACION_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      LV_mens_retorno:=SUBSTR(LV_mens_retorno,1,CN_LARGODESC);
      LN_num_evento := Ge_Errores_Pg.Grabarpl(LN_num_evento,CV_MODULO_GA,LV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZACION_PR', lv_sSql, LN_cod_retorno, LV_des_error );
    WHEN PARAM_CONFIG THEN
      LN_cod_retorno:=791;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('PARAM_CONFIG:PV_PENALIZACION_PG.PV_PENALIZACION_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      LV_mens_retorno:=SUBSTR(LV_mens_retorno,1,CN_LARGODESC);
      LN_num_evento := Ge_Errores_Pg.Grabarpl(LN_num_evento,CV_MODULO_GA,LV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZACION_PR', lv_sSql, LN_cod_retorno, LV_des_error );

    WHEN PARAM_NO_CONFIG THEN
      LN_cod_retorno:=274;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('PARAM_NO_CONFIG:PV_PENALIZACION_PG.PV_PENALIZACION_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      LV_mens_retorno:=SUBSTR(LV_mens_retorno,1,CN_LARGODESC);
      LN_num_evento := Ge_Errores_Pg.Grabarpl(LN_num_evento,CV_MODULO_GA,LV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZACION_PR', lv_sSql, LN_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
      LN_cod_retorno:=4;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
         LV_mens_retorno := CV_ERROR_NO_CLASIF;
      END IF;
      LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_PENALIZACION_PR('|| EN_cod_cliente || ',' || EN_num_abonado ||'); - '|| SQLERRM,1,CN_LARGOERRTEC);
      LV_mens_retorno:=SUBSTR(LV_mens_retorno,1,CN_LARGODESC);
      LN_num_evento := Ge_Errores_Pg.Grabarpl(LN_num_evento,CV_MODULO_GA,LV_mens_retorno, '1.0', USER,
      'PV_PENALIZACION_PG.PV_PENALIZACION_PR', lv_sSql, LN_cod_retorno, LV_des_error );
END;
END;
/


