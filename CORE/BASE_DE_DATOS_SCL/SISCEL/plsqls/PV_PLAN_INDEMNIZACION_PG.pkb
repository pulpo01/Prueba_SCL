CREATE OR REPLACE PACKAGE BODY PV_PLAN_INDEMNIZACION_PG IS
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "PV_PLAN_INDEMNIZACION_PG" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.0.0" Programador="Jorge Marin" Ambiente="BD">
<Descripción>Calculo para obtención de cargo por conepto de indemnizacion</Descripción>
</Elemento>
</Documentación>
*/

FUNCTION PV_RETORNA_VERSION_GENERAL_FN RETURN VARCHAR2
/*
<Documentación TipoDoc = "Function">
<Elemento Nombre = "PV_RETORNA_VERSION_GENERAL_FN" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.2.0" Programador="Jorge Marin" Ambiente="BD">
<Retorno>VERSION</Retorno>
<Descripción>Función que retorna la versión</Descripción>
</Elemento>
</Documentación>
*/
IS
  GV_version    CONSTANT VARCHAR2(3) := '001';
  GV_subversion CONSTANT VARCHAR2(3) := '001';
BEGIN
   RETURN('Version : '||GV_version||' <--> SubVersion : '||GV_subversion);
END;

PROCEDURE PV_RETORNA_PARAM_PR (EV_modulo       IN ge_modulos.cod_modulo%TYPE
                                                           ,EV_nomparam    IN ga_parametros_sistema_vw.nom_parametro%TYPE
                                                           ,SN_valornum    OUT nocopy ga_parametros_sistema_vw.valor_numerico%TYPE
                                                           ,SV_valortext   OUT nocopy ga_parametros_sistema_vw.valor_texto%TYPE
                                                           ,SV_valordom    OUT nocopy ga_parametros_sistema_vw.valor_dominio%TYPE
                                                           ,SV_cod_error   OUT NOCOPY VARCHAR2
                                                           ,SV_des_error   OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "PV_RETORNA_PARAM_PR" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.2.0" Programador="Patricia Castro" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Retorna parametro</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_modulo"   Tipo="VARCHAR2">código de modulo</param>
<param nom="EV_nomparam" Tipo="VARCHAR2">nombre de parametro</param>
</Entrada>
<Salida>
<param nom="SN_valornum"  Tipo="VARCHAR2">valor parametro numerico</param>
<param nom="SV_valortext" Tipo="VARCHAR2">valor parametro texto</param>
<param nom="SV_valordom"  Tipo="VARCHAR2">valor parametro dominio</param>
<param nom="SV_cod_error" Tipo="VARCHAR2">codigo error de salida</param>
<param nom="SV_des_error" Tipo="VARCHAR2">mensaje errorde salida</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
--   LV_operlocal               ge_operadora_scl_local.cod_operadora_scl%TYPE;
   LV_vista                     VARCHAR2(50);
   LV_nomparametro      VARCHAR2(50);
   PARAM_NO_CONFIG EXCEPTION;
BEGIN

         GV_operlocal:= GE_FN_OPERADORA_SCL();

         LV_nomparametro := EV_nomparam || '_' || EV_modulo;

         IF EV_modulo = 'CO' THEN
                  SELECT param.valor_texto
                           , param.valor_numerico
                           , param.valor_dominio
                   INTO  SV_valorText
                           , SN_valornum
                           , SV_valorDom
                  FROM CO_PARAMETROS_SISTEMA_VW param
                 WHERE param.nom_parametro = LV_nomparametro
                   AND param.cod_operadora = GV_operlocal;

                IF SV_valorText IS NULL AND SN_valornum IS NULL AND SV_valorDom IS NULL THEN
                   RAISE PARAM_NO_CONFIG;
                END IF;

         ELSE
                 SELECT param.valor_texto
                           , param.valor_numerico
                           , param.valor_dominio
                   INTO  SV_valorText
                           , SN_valornum
                           , SV_valorDom
                  FROM GA_PARAMETROS_SISTEMA_VW param
                 WHERE param.nom_parametro = LV_nomparametro
                   AND param.cod_operadora = GV_operlocal;

                IF SV_valorText IS NULL AND SN_valornum IS NULL AND SV_valorDom IS NULL THEN
                   RAISE PARAM_NO_CONFIG;
                END IF;

         END IF;

         SV_cod_error :='0';

                exception
                WHEN PARAM_NO_CONFIG THEN
                         SV_cod_error :='1';
                         SV_des_error:= 'PARAMETRO SIN VALOR.';
                WHEN OTHERS THEN
                         SV_cod_error :='2';
                         SV_des_error:= SQLERRM;

END;


PROCEDURE PV_STANDARD_PR(  EN_numabonado            IN  ga_abocel.num_abonado%TYPE,
                                                   EV_modulo                            IN      ge_modulos.cod_modulo%TYPE,
                                                   SN_Monto                                 OUT NOCOPY NUMBER,
                                                   SV_IndAut                        OUT NOCOPY VARCHAR2,
                                                   SV_Cod_error             OUT NOCOPY VARCHAR2,--NUMBER,
                                                   SV_Des_error             OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "PV_STANDARD_PR" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.0.0" Programador="Jorge Marin" Ambiente="BD">
<Descripción>Descripción</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_numabonado" Tipo="STRING">Numero de abonado</param>
<param nom="EV_modulo" Tipo="STRING">codigo de modulo</param>
</Entrada>
<Salida>
<param nom="SN_Monto" Tipo="STRING">Monto de indemnizacion</param>
<param nom="SV_IndAut" Tipo="STRING">Indicador de automatizacion</param>
<param nom="SV_Cod_error" Tipo="STRING">Codigo de error</param>
<param nom="SV_Des_error" Tipo="STRING">Descripción de error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
  LN_codpenaliza   ga_percontrato.cod_penaliza%TYPE;
  LV_codservicio   ga_actuaserv.cod_servicio%TYPE;
  LV_numcomtrato   ga_abocel.num_contrato%TYPE;
  LV_numanexo      ga_abocel.num_anexo%TYPE;
  LN_codcuenta     ga_abocel.cod_cuenta%TYPE;

  LN_valornum           GA_PARAMETROS_SISTEMA_VW.VALOR_NUMERICO%TYPE;
  LV_valortext          GA_PARAMETROS_SISTEMA_VW.VALOR_TEXTO%TYPE;
  LV_valordom           GA_PARAMETROS_SISTEMA_VW.VALOR_DOMINIO%TYPE;
  LV_cod_error          VARCHAR2(2);
  LV_des_error          VARCHAR2(255);

  CV_nomparameven       CONSTANT GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='BAJA_INDEM_ESTAND';
  GV_NOMPARAMSERV       CONSTANT GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='COD_SERV_STANDARD';

  RESTRICCION_PROCESO  EXCEPTION;
  RESTRICCION_OK EXCEPTION;
  FALTA_PARAM EXCEPTION;

BEGIN

         PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparamcobr,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);

         IF LV_cod_error = '0' THEN
                GV_aplicacobro:= TRIM(LV_valordom);
         ELSE
                 RAISE FALTA_PARAM;
         END IF;

         IF GV_aplicacobro = 'TRUE' THEN

                 SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO GV_Secuencia FROM DUAL;

                 PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparameven,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);

                 IF LV_cod_error = '0' THEN
                        GV_evento:=LV_valortext;
                 ELSE
                         RAISE FALTA_PARAM;
                 END IF;

                 PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparamactu,LN_valornum,LV_valortext,LV_valorDom,LV_cod_error,LV_des_error);

                 IF LV_cod_error = '0' THEN
                GV_codactuacion:= LV_valortext;
                 ELSE
                         RAISE FALTA_PARAM;
                 END IF;

                 GV_parametro := '|||||' || EN_numabonado || '|||||||||||||||';


                 PV_PR_EJECUTA_RESTRICCION (GV_Secuencia,EV_modulo,CN_codproducto,GV_codactuacion,GV_Evento,GV_Parametro);

                         SELECT tran.cod_retorno
                                        ,tran.des_cadena
                           INTO GN_CodRetorno
                                        ,GV_Descripcion
                       FROM GA_TRANSACABO tran
                      WHERE tran.num_transaccion = GV_Secuencia;

                     IF GN_CodRetorno <> 0 THEN
                                IF GV_Descripcion = 'OK' THEN
                                   RAISE RESTRICCION_OK;
                                ELSE
                                        RAISE RESTRICCION_PROCESO ;
                                END IF;
                     END IF;

                         SELECT abo.num_contrato
                                        , abo.num_anexo
                                        , abo.cod_cuenta
                         INTO   LV_numcomtrato
                                        , LV_numanexo
                                        , LN_codcuenta
                         FROM   GA_ABOCEL abo
                         WHERE  abo.num_abonado = EN_numabonado;

         /* Inicio Soporte RyC 37739 16.02.2007 mfqg. Se incluye manejo de exception */
                 BEGIN
                         SELECT  perc.COD_PENALIZA
                         INTO    LN_CodPenaliza
                         FROM    GA_PERCONTRATO perc
                                         , GA_CONTCTA cta
                         WHERE   cta.cod_cuenta       = LN_codcuenta
                           AND   cta.num_contrato (+) = LV_numcomtrato
                           AND   cta.num_anexo    (+) = LV_numanexo
                           AND   cta.cod_tipcontrato  = perc.cod_tipcontrato (+)
                           AND   cta.num_meses        = perc.num_meses       (+)
                           AND   cta.cod_producto     = perc.cod_producto    (+);
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               LN_CodPenaliza := 0;
                 END;
         /* Fin Soporte RyC 37739 16.02.2007 mfqg */


                 PV_RETORNA_PARAM_PR (EV_modulo,GV_NOMPARAMSERV,LN_valornum,LV_valortext,LV_valorDom,LV_cod_error,LV_des_error);
                 IF LV_cod_error = '0' THEN
                        LV_codservicio:= NVL(LN_valornum,LV_valortext);
                 ELSE
                         RAISE FALTA_PARAM;
                 END IF;

                 PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparamsero,LN_valornum,LV_valortext,LV_valorDom,LV_cod_error,LV_des_error);
                 IF LV_cod_error ='0' THEN
                        GV_codtipserv:= NVL(LN_valornum,LV_valortext);
                 ELSE
                         RAISE FALTA_PARAM;
                 END IF;

                 BEGIN
                        SELECT c.ind_autman, e.imp_penaliza
                    INTO   SV_IndAut,  SN_Monto
                        FROM  GA_ACTUASERV a, GA_SERVICIOS c, GA_IMPPENALIZA e
                        WHERE a.cod_producto  = CN_codproducto
                          AND a.cod_actabo        = GV_codactuacion
                          AND a.cod_tipserv   = GV_codtipserv
                          AND c.cod_producto  = a.cod_producto
                          AND c.cod_servicio  = a.cod_servicio
                          AND a.cod_servicio  = LV_codservicio
                          AND e.cod_penaliza  = LN_codpenaliza
                          AND SYSDATE            >= e.fec_desde
                          AND SYSDATE            <= NVL(e.fec_hasta, SYSDATE);
                 EXCEPTION
                                  WHEN NO_DATA_FOUND THEN
                                  --No es error, ya que, si no existe configuración debe continuar y no
                                  --realizar el cargo.
                                           NULL;
                END;
END IF;

                        SV_Cod_error := '0';

EXCEPTION
                WHEN RESTRICCION_OK THEN
                                 SV_Cod_error := '0';
                WHEN RESTRICCION_PROCESO THEN
                                 SV_Cod_error := '3';
                                 SV_Des_error := GV_Descripcion;
                WHEN FALTA_PARAM          THEN
                                 SV_Cod_error := '5';
                                 SV_Des_error := 'ERROR AL OBTENER PARAMETRO:' || SV_Des_error;
                WHEN OTHERS THEN
                                 SV_Cod_error := '4';
                                 SV_Des_error := SQLERRM;

END PV_STANDARD_PR;

PROCEDURE PV_ESCALONADA_PR (EN_numabonado            IN  ga_abocel.num_abonado%TYPE,
                                                   EV_modulo                            IN      ge_modulos.cod_modulo%TYPE,
                                                   SN_Monto                                 OUT NOCOPY NUMBER,
                                                   SV_IndAut                        OUT NOCOPY VARCHAR2,
                                                   SV_Cod_error             OUT NOCOPY VARCHAR2,--NUMBER,
                                                   SV_Des_error             OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "PV_ESCALONADA_PR" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.0.0" Programador="Jorge Marin" Ambiente="BD">
<Descripción>Descripción</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_numabonado" Tipo="STRING">Numero de abonado</param>
<param nom="EV_modulo" Tipo="STRING">codigo de modulo</param>
</Entrada>
<Salida>
<param nom="SN_Monto" Tipo="STRING">Monto de indemnizacion</param>
<param nom="SV_IndAut" Tipo="STRING">Indicador de automatizacion</param>
<param nom="SV_Cod_error" Tipo="STRING">Codigo de error</param>
<param nom="SV_Des_error" Tipo="STRING">Descripción de error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
  LV_codservicio       ga_actuaserv.cod_servicio%TYPE;
  LN_nummeses              NUMBER(5);
  LD_fecalta               ga_abocel.fec_alta%TYPE;
  LD_fecprorroga           ga_abocel.fec_prorroga%TYPE;
  LV_codtipcontrato        ga_abocel.cod_tipcontrato%TYPE;
  LN_nummesescont          ga_percontrato.num_meses%TYPE;
  LV_nomparameven          Constant GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='BAJA_INDEM_ESCAL';
  LV_nomparamserv          Constant GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='COD_SERV_ESCAL';

  LN_valornum              ga_parametros_sistema_vw.valor_numerico%TYPE;
  LV_valortext             ga_parametros_sistema_vw.valor_texto%Type;
  lv_valordom              ga_parametros_sistema_vw.valor_dominio%TYPE;
  LV_cod_error             VARCHAR2(2);
  LV_des_error             VARCHAR2(255);

  RESTRICCION_PROCESO  EXCEPTION;
  FALTA_PARAM EXCEPTION;
  RESTRICCION_OK EXCEPTION;
BEGIN

         PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparamcobr,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);

         IF LV_cod_error ='0' THEN
                GV_aplicacobro:= TRIM(lV_valordom);
         ELSE
                   RAISE FALTA_PARAM;
         END IF;

         IF GV_aplicacobro = 'TRUE' THEN

                  GV_operlocal:= GE_FN_OPERADORA_SCL();

                  PV_RETORNA_PARAM_PR (EV_modulo,LV_NOMPARAMEVEN,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);

                  IF LV_cod_error ='0' THEN
                  GV_evento:= LV_valortext;
                  ELSE
                          RAISE FALTA_PARAM;
              END IF;

                  PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparamactu,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
                  IF LV_cod_error ='0' THEN
                         GV_codactuacion:= LV_valortext;
                  ELSE
                         RAISE FALTA_PARAM;
                  END IF;

                  SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO GV_secuencia FROM DUAL;

                  GV_Parametro := '|||||' || EN_numabonado || '|||||||||||||||';

                  PV_PR_EJECUTA_RESTRICCION (GV_Secuencia,EV_Modulo,CN_codproducto,GV_codactuacion,GV_Evento,GV_Parametro);

                  SELECT tran.cod_retorno
                                 , tran.des_cadena
                  INTO GN_CodRetorno
                                 ,GV_Descripcion
                  FROM ga_transacabo tran
                  WHERE tran.num_transaccion = GV_Secuencia;

                  IF GN_CodRetorno <> 0 THEN
                         IF GV_Descripcion = 'OK' THEN
                                RAISE RESTRICCION_OK;
                         ELSE
                                RAISE RESTRICCION_PROCESO ;
                         END IF;
                  END IF;

                  SELECT  abo.fec_alta
                                , abo.fec_prorroga
                                , abo.cod_tipcontrato
                                , ctra.num_meses
                  INTO    LD_fecalta
                                , LD_fecprorroga
                                , LV_codtipcontrato
                                , LN_nummesescont
                  FROM    ga_percontrato ctra
                                , ga_abocel abo
                  WHERE   abo.num_abonado     = EN_numabonado
                  AND     ctra.cod_producto   = CN_codproducto
                  AND     abo.cod_tipcontrato = ctra.cod_tipcontrato;

                  IF LD_fecprorroga IS NOT NULL THEN
                         LN_nummeses := TRUNC(MONTHS_BETWEEN(SYSDATE,LD_fecprorroga));
                  ELSE
                          LN_nummeses := TRUNC(MONTHS_BETWEEN(SYSDATE,LD_fecalta));
                  END IF;

                  PV_RETORNA_PARAM_PR (EV_Modulo,LV_nomparamserv,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
                  IF LV_Cod_error = '0' THEN
                         LV_codservicio:= NVL(LN_valornum,LV_valortext);
                  ELSE
                         RAISE FALTA_PARAM;
                  END IF;

                  PV_RETORNA_PARAM_PR (EV_Modulo,CV_nomparamsero,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
                  IF LV_cod_error = '0' THEN
                         GV_codtipserv:= NVL(LN_valornum,LV_valortext);
                  ELSE
                         RAISE FALTA_PARAM;
                  END IF;

                  SELECT   e.valor
                                 , c.ind_autman
                  INTO     SN_Monto
                                 , SV_IndAut
                  FROM     ga_actuaserv a
                             , ga_servicios c
                                 , ge_monedas d
                                 , ga_cargos_indemnizacion e
                  WHERE a.cod_producto = CN_codproducto
                  AND a.cod_actabo         = GV_codactuacion
                  AND a.cod_tipserv    = GV_codtipserv
                  AND c.cod_producto   = a.cod_producto
                  AND c.cod_servicio   = a.cod_servicio
                  AND d.cod_moneda         = e.cod_moneda
                  AND a.cod_servicio   = LV_codservicio
                  AND e.meses_contrato = LN_nummesescont
                  AND e.num_meses          = LN_nummeses
                  AND SYSDATE             >= e.fec_desde
                  AND SYSDATE             <= NVL(e.fec_hasta,SYSDATE);

         END IF;

         SV_Cod_error := '0';

         EXCEPTION
                WHEN RESTRICCION_OK THEN
                                 SV_Cod_error := '0';
                WHEN RESTRICCION_PROCESO  THEN
                                 SV_Cod_error:= '3';
                                 SV_Des_error:= GV_Descripcion;
                WHEN FALTA_PARAM          THEN
                                 SV_Cod_error := '5';
                                 SV_Des_error := 'ERROR AL OBTENER PARAMETRO:' || SV_Des_error;
                WHEN OTHERS THEN
                                 SV_Cod_error:= '4';
                                 SV_Des_error:= SQLERRM;

END PV_ESCALONADA_PR;

PROCEDURE PV_POREQUIPO_PR (EN_numabonado            IN  ga_abocel.num_abonado%TYPE,
                                                   EV_modulo                            IN      ge_modulos.cod_modulo%TYPE,
                                                   SN_Monto                                 OUT NOCOPY NUMBER,
                                                   SV_IndAut                        OUT NOCOPY VARCHAR2,
                                                   SV_Cod_error             OUT NOCOPY VARCHAR2,--NUMBER,
                                                   SV_Des_error             OUT NOCOPY VARCHAR2)

/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "PV_POREQUIPO_PR" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.0.0" Programador="Jorge Marin" Ambiente="BD">
<Descripción>Descripción</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_numabonado" Tipo="STRING">Numero de abonado</param>
<param nom="EV_modulo" Tipo="STRING">codigo de modulo</param>
</Entrada>
<Salida>
<param nom="SN_Monto" Tipo="STRING">Monto de indemnizacion</param>
<param nom="SV_IndAut" Tipo="STRING">Indicador de automatizacion</param>
<param nom="SV_Cod_error" Tipo="STRING">Codigo de error</param>
<param nom="SV_Des_error" Tipo="STRING">Descripción de error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

IS

  LV_codservicio                  ga_actuaserv.cod_servicio%TYPE;
  LV_tecnologia                   ga_abocel.cod_tecnologia%TYPE;
  LV_tecnologiaAux                ga_abocel.cod_tecnologia%TYPE;
  LV_imei                                 ga_abocel.num_imei%TYPE;
  LV_numserie                     ga_abocel.num_serie%TYPE;
  LV_tipcontrato                  GA_ABOCEL.cod_tipcontrato%TYPE;
  LV_codplantarif                 GA_ABOCEL.cod_plantarif%TYPE;
  LN_codcliente                   GA_ABOCEL.COD_CLIENTE%TYPE;
  LN_tipstock                     GA_EQUIPABOSER.tip_stock%TYPE;
  LN_codarticulo                  GA_EQUIPABOSER.cod_articulo%TYPE;
  LN_coduso                       GA_EQUIPABOSER.cod_uso%TYPE;
  LN_codestado                    GA_EQUIPABOSER.cod_estado%TYPE;
  LN_modventa                     GA_EQUIPABOSER.cod_modventa%TYPE;
  LN_importe                      GA_EQUIPABOSER.IMP_CARGO%TYPE;
  LN_tipodto                      GA_EQUIPABOSER.TIP_DTO%TYPE;
  LN_valdto                               GA_EQUIPABOSER.VAL_DTO%TYPE;
  LD_fecalta                      GA_EQUIPABOSER.fec_alta%TYPE;
  LN_prcequipo                    NUMBER;
  LV_indequiacc                   AL_ARTICULOS.ind_equiacc%TYPE;
  LN_prclista                     AL_PRECIOS_VENTA.prc_venta%TYPE;
  LN_indrecambio                  AL_PRECIOS_VENTA.ind_recambio%TYPE;
  LN_mesecontrato                 GA_PERCONTRATO.num_meses%TYPE;
  LV_numseraux                    GA_EQUIPABOSER.num_serie%TYPE;
  LN_ValMensual                   NUMBER;
  LN_diasEnte                     NUMBER;
  CV_nomparameven                 CONSTANT GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='BAJA_INDEM_X_EQUI';
  CV_nomparamuso                  CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE:='USO_PREPAGO';
  CV_nomparammese         CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE:='MESES_COMPRA';
  CV_nomparaminde                 CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE:='INDICADOR_EQUIPO';
  CV_nomparamsimc         CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE:='COD_SIMCARD_GSM';
  CV_nomparamserv                 CONSTANT GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='COD_SERV_POREQUIP';
  CV_nomparamgrup                 CONSTANT GA_PARAMETROS_SISTEMA_VW.NOM_PARAMETRO%TYPE:='GRUPO_TEC_GSM';
  CV_indciclo                     CONSTANT FA_TIPDOCUMEN.IND_CICLO%TYPE:=1;
  LV_modulo                     CONSTANT GE_MODULOS.COD_MODULO%TYPE:='GA';


  LN_mesescompra                  NUMBER;
  LN_codpromedio                  AL_PROMFACT.COD_PROMEDIO%TYPE;
  LN_nummesesant                  NUMBER;
  LN_codantiguedad                AL_ANTIGUEDAD.COD_ANTIGUEDAD%TYPE;
  LV_tip_terminal    ged_parametros.val_parametro%TYPE;

  LN_valornum              ga_parametros_sistema_vw.valor_numerico%TYPE;
  LV_valortext             ga_parametros_sistema_vw.valor_texto%Type;
  lv_valordom              ga_parametros_sistema_vw.valor_dominio%TYPE;
  LV_cod_error             VARCHAR2(2);
  LV_des_error             VARCHAR2(255);


  RESTRICCION_PROCESO  EXCEPTION;
  RESTRICCION_OK EXCEPTION;
  FALTA_PARAM EXCEPTION;

BEGIN
         PV_RETORNA_PARAM_PR (EV_modulo,CV_NOMPARAMCOBR ,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
         IF LV_cod_error = '0' THEN
                GV_aplicacobro:= TRIM(LV_valordom);
         ELSE
                 RAISE FALTA_PARAM;
         END IF;

         IF GV_aplicacobro = 'TRUE' THEN

                GV_operlocal:= GE_FN_OPERADORA_SCL();

                SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO GV_Secuencia FROM DUAL;

        PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparameven,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
        IF LV_cod_error = '0' THEN
                   GV_Evento:= LV_valortext;
                ELSE
                        RAISE FALTA_PARAM;
                END IF;

                PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparamactu,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
                IF LV_cod_error = '0' THEN
                   GV_codactuacion:= LV_valortext;
                ELSE
                        RAISE FALTA_PARAM;
                END IF;

                GV_Parametro := '|||||' || EN_numabonado || '|||||||||||||||';

                PV_PR_EJECUTA_RESTRICCION (GV_Secuencia,EV_modulo,CN_codproducto,GV_codactuacion,GV_Evento,GV_Parametro);

                SELECT tran.cod_retorno
                                 , tran.des_cadena
                INTO GN_CodRetorno
                                 ,GV_Descripcion
                FROM ga_transacabo tran
                WHERE tran.num_transaccion = GV_Secuencia;

                IF GN_CodRetorno <> 0 THEN
                   IF GV_Descripcion = 'OK' THEN
                          RAISE RESTRICCION_OK;
                   ELSE
                           RAISE RESTRICCION_PROCESO ;
                   END IF;
                END IF;

                -- Obtiene datos del abonado
                SELECT    abo.cod_tecnologia
                                , abo.num_imei
                                , abo.num_serie
                                , abo.cod_tipcontrato
                                , abo.cod_plantarif
                                , abo.cod_cliente
                INTO      LV_tecnologia
                                , LV_imei
                                , LV_numserie
                                , LV_tipcontrato
                                , LV_codplantarif
                                , LN_codcliente
                FROM   GA_ABOCEL abo
                WHERE  abo.num_abonado = EN_numabonado;

                -- Obtiene Grupo tecnologico  GSM
                LV_tecnologiaAux :=  GE_FN_DEVVALPARAM(EV_modulo,CN_codproducto,CV_nomparamgrup);


                IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(LV_tecnologia) = LV_tecnologiaAux THEN
                   LV_numseraux := LV_imei;
                ELSE
                        LV_numseraux := LV_numserie;
                END IF;

                SELECT  equip.tip_stock
                           , equip.cod_articulo
                           , equip.cod_uso
                           , equip.cod_estado
                           , equip.cod_modventa
                          -- , equip.ind_procequi
                           , NVL(equip.imp_cargo,0)
                           , NVL(equip.tip_dto,0)
                           , NVL(equip.val_dto,0)
                           , equip.fec_alta
                INTO    LN_tipstock
                           , LN_codarticulo
                           , LN_coduso
                           , LN_codestado
                           , LN_modventa
--                         , LV_procequi
                           , LN_importe
                           , LN_tipodto
                           , LN_valdto
                           , LD_fecalta
                FROM   GA_EQUIPABOSER equip
                WHERE  equip.num_abonado = EN_numabonado
                AND  equip.num_serie   = LV_numseraux
                AND  equip.fec_alta    = (SELECT MAX(b.fec_alta)
                                                              FROM GA_EQUIPABOSER  b
                                                              WHERE b.num_abonado = equip.num_abonado
                                                              AND   b.num_serie   = equip.num_serie );
                BEGIN
                        SELECT a.valor_texto
                        INTO LV_indequiacc
                        FROM GA_PARAMETROS_SISTEMA_VW a
                        WHERE a.nom_parametro = CV_nomparaminde
                        AND a.cod_operadora = GV_operlocal;
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                 SV_Des_error:= CV_nomparaminde ||  ': ' || SQLERRM;
                                 RAISE FALTA_PARAM;
                END;

                SELECT a.num_meses
                INTO   LN_mesecontrato
                FROM   GA_PERCONTRATO a
                WHERE a.cod_producto = CN_codproducto
                AND a.cod_tipcontrato = LV_tipcontrato;

                LV_tip_terminal := GE_FN_DEVVALPARAM ('',CN_codproducto,CV_nomparamsimc);

                -- Para obtener el Precio Lista

                SELECT COUNT(1)
                INTO   LN_indrecambio
                FROM   GA_EQUIPABOSER a
                WHERE  a.num_abonado = EN_numabonado
                AND NOT a.TIP_TERMINAL = LV_tip_terminal;

                IF LN_indrecambio > 1 THEN
                   LN_indrecambio := 1;

                   SELECT A.COD_PROMEDIO
                   INTO LN_codpromedio
                   FROM AL_PROMFACT A,
                                 ( SELECT  ROUND(NVL(SUM(U.TOT_FACTURA)/MAX(V.CUENTA),0))  TOTAL
                                   FROM FA_HISTDOCU U,
                                                ( SELECT  COUNT (DISTINCT TO_CHAR(FEC_EMISION,'MM')) CUENTA
                                                  FROM    FA_HISTDOCU
                                                  WHERE  COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = CV_indciclo)
                                                  AND     FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                                  AND COD_CLIENTE = LN_codcliente ) V
                                        WHERE   U.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = CV_indciclo)
                                        AND     U.FEC_EMISION > ADD_MONTHS(SYSDATE,-6)
                                        AND     U.COD_CLIENTE = LN_codcliente
                                  )B
                        WHERE B.TOTAL >= A.FACT_DESDE
                        AND B.TOTAL <= A.FACT_HASTA;

                        LN_nummesesant := TRUNC(MONTHS_BETWEEN(SYSDATE, LD_fecalta));


                        SELECT  COD_ANTIGUEDAD
                        INTO  LN_codantiguedad
                        FROM AL_ANTIGUEDAD a
                        WHERE a.NUM_MESES= LN_mesecontrato
                        AND  LN_nummesesant  >= ANT_DESDE
                        AND LN_nummesesant  <= ANT_hasta;

                        BEGIN
                                SELECT  a.prc_venta
                                 INTO   LN_prclista
                                FROM    AL_PRECIOS_VENTA a
                                           ,AL_ARTICULOS b
                                           ,GE_MONEDAS c
                                           , (SELECT W.COD_CATEGORIA CATEGORIA FROM VE_CATPLANTARIF V, VE_CATEGORIAS W
                                            WHERE V.COD_PLANTARIF = LV_codplantarif
                                                AND   V.COD_CATEGORIA = W.COD_CATEGORIA ) Z
                                WHERE  a.tip_stock               = LN_tipstock
                                 AND   a.cod_articulo    = LN_codarticulo
                                 AND   a.cod_uso                 = LN_coduso
                                 AND   a.cod_estado      = LN_codestado
                                 AND   a.COD_CATEGORIA   = Z.CATEGORIA
                                 AND   a.cod_modventa    = LN_modventa
                                 AND   LD_fecalta        >= a.fec_desde
                                 AND   LD_fecalta        <= NVL(a.fec_hasta, SYSDATE)
                                 AND   b.cod_articulo    = a.cod_articulo
                                 AND   c.cod_moneda      = a.cod_moneda
                                 AND   a.ind_recambio    = LN_indrecambio
                                 AND   a.num_meses               = LN_mesecontrato
                                 AND   a.cod_antiguedad  = LN_codantiguedad
                                 AND   a.cod_promedio    = LN_codpromedio
                                 AND   TO_CHAR(a.cod_uso) NOT IN (SELECT param.val_parametro FROM GED_PARAMETROS param
                                                                                                  WHERE  param.nom_parametro = CV_nomparamuso
                                                                                                  AND    param.cod_modulo    = LV_modulo
                                                                                                  AND    param.cod_producto  = CN_codproducto)
                                 AND   b.ind_equiacc = LV_indequiacc;
                        EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                                  --No existe configuración de cargos y debe continuar sin
                                                  -- realizar cargo.
                                                  RAISE RESTRICCION_OK;
                        END;

                ELSE
                        LN_indrecambio := 0;

                        BEGIN
                                SELECT  a.prc_venta
                                 INTO   LN_prclista
                                FROM    AL_PRECIOS_VENTA a
                                           ,AL_ARTICULOS b
                                           ,GE_MONEDAS c
                                           , (SELECT W.COD_CATEGORIA CATEGORIA FROM VE_CATPLANTARIF V, VE_CATEGORIAS W
                                            WHERE V.COD_PLANTARIF = LV_codplantarif
                                                AND V.COD_CATEGORIA = W.COD_CATEGORIA ) Z
                                WHERE  a.tip_stock         = LN_tipstock
                                 AND   a.cod_articulo  = LN_codarticulo
                                 AND   a.cod_uso           = LN_coduso
                                 AND   a.cod_estado    = LN_codestado
                                 AND   a.COD_CATEGORIA = Z.CATEGORIA
                                 AND   a.cod_modventa  = LN_modventa
                                 AND   LD_fecalta     >= a.fec_desde
                                 AND   LD_fecalta     <= NVL(a.fec_hasta, SYSDATE)
                                 AND   b.cod_articulo  = a.cod_articulo
                                 AND   c.cod_moneda    = a.cod_moneda
                                 AND   a.ind_recambio  = LN_indrecambio
                                 AND   a.num_meses = LN_mesecontrato
                                 AND   TO_CHAR(a.cod_uso) NOT IN (SELECT param.val_parametro FROM GED_PARAMETROS param
                                                                                                  WHERE  param.nom_parametro = CV_nomparamuso
                                                                                                  AND    param.cod_modulo    = LV_modulo
                                                                                                  AND    param.cod_producto  = CN_codproducto)
                                 AND   b.ind_equiacc = LV_indequiacc;
                        EXCEPTION
                                         WHEN NO_DATA_FOUND THEN
                                                  --No existe configuración de cargos y debe continuar sin
                                                  -- realizar cargo.
                                                  RAISE RESTRICCION_OK;
                        END;

                END IF;


                IF LN_importe >0 THEN
                   --   TIP_DTO =1 PORCENTAJE
                   -- TIP_DTO = 0 IMPORTE

                   IF LN_importe IS NOT NULL AND LN_tipodto IS NOT NULL and  LN_valdto IS NOT NULL THEN
                          IF LN_tipodto = 1 THEN -- Tipo descuento porcentaje
                                 LN_valdto := (LN_importe * LN_valdto)/100;
                          END IF;
                          LN_prcequipo := LN_valdto - LN_importe;
                   Else
                          LN_prcequipo := 0;
                   END IF;
                ELSE
                          LN_prcequipo := 0;
                END IF;


                LN_ValMensual := (LN_prclista - LN_prcequipo)/LN_mesecontrato;


                LN_diasEnte := TRUNC(SYSDATE - LD_fecalta);

                PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparammese ,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
                IF LV_cod_error = '0' THEN
                   LN_mesescompra:= TRIM(LN_valornum);
                ELSE
                   RAISE FALTA_PARAM;
            END IF;


                SN_Monto := ABS(LN_Valmensual * (LN_mesecontrato - (LN_diasEnte / LN_mesescompra)));

                PV_RETORNA_PARAM_PR (EV_modulo,CV_nomparamserv,LN_valornum,LV_valortext,LV_valordom,LV_cod_error,LV_des_error);
                IF LV_cod_error = '0' THEN
                   LV_codservicio:= NVL(LN_valornum,LV_valortext);
                ELSE
                        RAISE FALTA_PARAM;
                END IF;

                SELECT A.IND_AUTMAN
                INTO SV_IndAut
                FROM GA_SERVICIOS A
                WHERE COD_PRODUCTO = CN_codproducto
                AND COD_SERVICIO = LV_codservicio;
         END IF;
     SV_Cod_error := '0';

         EXCEPTION
                WHEN RESTRICCION_OK THEN
                                 SV_Cod_error := '0';
                WHEN RESTRICCION_PROCESO THEN
                                 SV_Cod_error := '3';
                                 SV_Des_error := GV_Descripcion;
                WHEN FALTA_PARAM          THEN
                                 SV_Cod_error := '5';
                                 SV_Des_error := 'ERROR AL OBTENER PARAMETRO: ' || SV_Des_error;
                WHEN OTHERS THEN
                                 SV_Cod_error := '4';
                                 SV_Des_error := SQLERRM;
END PV_POREQUIPO_PR;


PROCEDURE PV_INDEMNIZACION_PR (EN_numabonado        IN  GA_ABOCEL.num_abonado%TYPE,
                                                          EV_modulo                             IN GE_MODULOS.COD_MODULO%TYPE,
                                                          SV_IndAut                             OUT NOCOPY VARCHAR2,
                                                      SV_Monto                          OUT NOCOPY VARCHAR2,
                                                          SV_CodConcepto                OUT NOCOPY VARCHAR2,
                                                          SV_Cod_error          OUT NOCOPY VARCHAR2,
                                                          SV_Des_error          OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "PV_INDEMNIZACION_PR" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.0.0" Programador="Jorge Marin" Ambiente="BD">
<Descripción>Descripción</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_numabonado" Tipo="STRING">Numero de abonado</param>
<param nom="EV_modulo" Tipo="STRING">codigo de modulo</param>
</Entrada>
<Salida>
<param nom="SV_IndAut" Tipo="STRING">Indicador de automatizacion</param>
<param nom="SN_Monto" Tipo="STRING">Monto de indemnizacion</param>
<param nom="SV_CodConcepto" Tipo="STRING">Concepto facturable</param>
<param nom="SV_Cod_error" Tipo="STRING">Codigo de error</param>
<param nom="SV_Des_error" Tipo="STRING">Descripción de error</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
                LV_nom_procedure           PV_PLAN_INDEMNIZACION_TD.NOM_PROCEDURE%TYPE;
                LV_COMANDO                         VARCHAR2(100);

BEGIN

                 SV_Cod_error :='';

                 SELECT B.nom_procedure, B.cod_concepto
                   INTO LV_nom_procedure, SV_CodConcepto
                   FROM GA_ABOCEL A
                                , PV_PLAN_INDEMNIZACION_TD B
                  WHERE A.num_abonado = EN_numabonado
                    AND A.cod_indemnizacion = B. cod_plan_indemnizacion;

                 LV_COMANDO:= 'BEGIN ' || LV_nom_procedure ||' (:a,:b,:c,:d,:e,:f); END;';

         EXECUTE IMMEDIATE LV_COMANDO USING IN EN_numabonado, IN EV_modulo,OUT SV_Monto, OUT SV_IndAut, OUT Sv_Cod_error, OUT SV_Des_error;

                 SV_IndAut:=NVL(SV_IndAut,'');
                 SV_Monto:=NVL(SV_Monto,'');
                 SV_CodConcepto:=NVL(SV_CodConcepto,'');

                 SV_Cod_error := NVL(Sv_Cod_error,'');
                 SV_Des_error:= NVL(LV_nom_procedure || ':' || SV_Des_error,'');

exception
                WHEN OTHERS THEN
                         SV_Cod_error :='2';
                         SV_Des_error:= SQLERRM;
END PV_INDEMNIZACION_PR;

END PV_PLAN_INDEMNIZACION_PG;
/
SHOW ERRORS
