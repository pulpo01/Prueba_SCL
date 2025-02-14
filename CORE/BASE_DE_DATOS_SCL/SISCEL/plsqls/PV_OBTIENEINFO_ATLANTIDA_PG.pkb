CREATE OR REPLACE PACKAGE BODY PV_OBTIENEINFO_ATLANTIDA_PG IS

--PV_OBTIENEINFO_ATLANTIDA_PG v1.1 INI XO-200605221111 HPG--
--PV_OBTIENEINFO_ATLANTIDA_PG v1.2 Inc. XO-200606141136
--PV_OBTIENEINFO_ATLANTIDA_PG v1.3 XO-200607171174 26.07.2006 --
--PV_OBTIENEINFO_ATLANTIDA_PG v1.4 Inc. XO-200608091191
--PV_OBTIENEINFO_ATLANTIDA_PG v1.5 INI gbm - soporte 27-01-2007 - 36481
--PV_OBTIENEINFO_ATLANTIDA_PG v1.6 INICIO 39162 RRG COL Abril 10, 2007
--PV_OBTIENEINFO_ATLANTIDA_PG v1.7 P-MIX-06003-G1 43120 - ini - spz Agosto 16, 2007
--PV_OBTIENEINFO_ATLANTIDA_PG v1.8 --COL-71929|17-10-2008|GEZ

--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------
PROCEDURE PV_RECUPERA_LIMITES_PR(
    EN_num_abonado  IN GA_ABOCEL.num_abonado%TYPE,
    ET_nummovimiento IN ICC_MOVIMIENTO.num_movimiento%TYPE,
    SV_LimiteMax     OUT NOCOPY VARCHAR2,
    SV_LimiteEmp     OUT NOCOPY VARCHAR2,
    SV_LimiteUsu  OUT NOCOPY VARCHAR2,

    SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
    SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
    SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_RECUPERA_LIMITES_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
   <param nom="ET_nummovimiento"     Tipo="CARACTER">Numero de Abonado</param>
         </Entrada>
         <Salida>
       <param nom="SV_LimiteMax"           Tipo="VARCHAR2">Limite maximo</param>
      <param nom="SV_LimiteEmp"           Tipo="VARCHAR2">Limite empresa</param>
      <param nom="SV_LimiteUsu"           Tipo="VARCHAR2">Limite usuario</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS
        LV_des_error         ge_errores_pg.DesEvent;
  sSql                 ge_errores_pg.vQuery;

  LT_plan     ICC_MOVIMIENTO.PLAN%TYPE;
  LT_cod_plantarif  TA_PLANTARIF.cod_plantarif%TYPE;
  LT_tip_plantarif  GA_ABOCEL.tip_plantarif%TYPE;
  LT_cod_cargobasico  TA_PLANTARIF.cod_cargobasico%TYPE;

  LT_imp_cargobasico  TA_CARGOSBASICO.imp_cargobasico%TYPE;
  LT_imp_limconsumo  TA_LIMCONSUMO.imp_limconsumo%TYPE;

  LT_codcliente        GE_CLIENTES.cod_cliente%TYPE;
     LV_num_ident        GE_CLIENTES.num_ident%TYPE;
  LV_cod_tipident      GE_CLIENTES.cod_tipident%TYPE;

  LV_calificacion   VARCHAR2(7);

     LV_signo             VARCHAR2(1);
  LV_digitos          VARCHAR2(4);
  LV_decimales         VARCHAR2(2);

  LV_valor_cadena       VARCHAR2(7);
  LN_valor          NUMBER(14,4);


  LV_coderror    NUMBER(1);
  ERROR_LIMEMPRESA  EXCEPTION;
  ERROR_SCORING   EXCEPTION;

BEGIN

 -- VERIFICAMOS SI MOVIMIENTO TIENE PLAN ASOCIADO. SI NO SE ENCUENTRA, LO OBTENEMOS DEL PLAN...

 sSql:='SELECT cod_cliente INTO LT_codcliente FROM GA_ABOCEL WHERE num_abonado =' || EN_num_abonado;
 SELECT cod_cliente --Inc. XO-200606141136 Se agrega cliente
   INTO LT_codcliente --Inc. XO-200606141136 Se agrega cliente
   FROM GA_ABOCEL
  WHERE num_abonado = EN_num_abonado;

 BEGIN
     sSql:='SELECT plan INTO LT_cod_plantarif FROM ICC_MOVIMIENTO WHERE num_movimiento = ' || ET_nummovimiento;
  SELECT PLAN
  INTO LT_cod_plantarif
  FROM ICC_MOVIMIENTO
  WHERE num_movimiento = ET_nummovimiento;

  IF LT_cod_plantarif = '' OR LT_cod_plantarif IS NULL THEN
      BEGIN
    sSql:='SELECT cod_plantarif INTO LT_cod_plantarif FROM GA_FINCICLO WHERE num_abonado =' || EN_num_abonado;
    SELECT cod_plantarif --Inc. XO-200608091191
      INTO LT_cod_plantarif
      FROM GA_FINCICLO
     WHERE cod_cliente = LT_codcliente
             AND num_abonado = EN_num_abonado
             AND cod_ciclfact IS NOT NULL
             AND cod_plantarif IS NOT NULL;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN

        sSql:='SELECT cod_plantarif INTO LT_cod_plantarif FROM GA_ABOCEL WHERE num_abonado =' || EN_num_abonado;
     SELECT cod_plantarif
     INTO LT_cod_plantarif
     FROM GA_ABOCEL
     WHERE num_abonado = EN_num_abonado;
   END;
  END IF;

 EXCEPTION
  WHEN NO_DATA_FOUND THEN

      BEGIN
    sSql:='SELECT tip_plantarif INTO LT_tip_plantarif FROM GA_ABOCEL WHERE num_abonado =' || EN_num_abonado;
    SELECT cod_plantarif --Inc. XO-200608091191
      INTO LT_cod_plantarif
      FROM GA_FINCICLO
     WHERE cod_cliente = LT_codcliente
             AND num_abonado = EN_num_abonado
             AND cod_ciclfact IS NOT NULL
             AND cod_plantarif IS NOT NULL;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN

        sSql:='SELECT cod_plantarif INTO LT_cod_plantarif FROM GA_ABOCEL WHERE num_abonado =' || EN_num_abonado;
     SELECT cod_plantarif
     INTO LT_cod_plantarif
     FROM GA_ABOCEL
     WHERE num_abonado = EN_num_abonado;
   END;
 END;


    -- OBTENEMOS TIPO DE PLAN TARIFARIO...
 sSql:='SELECT tip_plantarif INTO LT_tip_plantarif FROM GA_ABOCEL WHERE num_abonado =' || EN_num_abonado;
 SELECT tip_plantarif, cod_cliente --Inc. XO-200606141136 Se agrega cliente
   INTO LT_tip_plantarif, LT_codcliente --Inc. XO-200606141136 Se agrega cliente
   FROM GA_ABOCEL
  WHERE num_abonado = EN_num_abonado;


 -- PLAN EMPRESA...
    IF  LT_tip_plantarif = 'E' THEN

  -- LIMITE EMPRESA...
  IF  PV_IMP_CARGOBASICO_FN(LT_cod_plantarif, LT_imp_cargobasico) THEN
   SV_LimiteEmp := TO_CHAR(PV_CALCULA_IMPTO_FN(LT_imp_cargobasico));
     ELSE
   SN_cod_retorno   := 4;
   SV_mens_retorno  := 'ERROR IMPORTE CARGO BASICO';
   --RAISE ERROR_LIMEMPRESA;
  END IF;

  -- LIMITE MAXIMO...
  --Inc. XO-200606141136
  --IF  PV_IMP_LIMCONSUMO_FN(LT_cod_plantarif, LT_imp_limconsumo) THEN
  IF  PV_IMP_LIMCONSUMO_FN(EN_num_abonado, LT_imp_limconsumo) THEN
  -- Fin XO-200606141136
   SV_LimiteMax := TO_CHAR(PV_CALCULA_IMPTO_FN(LT_imp_limconsumo));
     ELSE
   SN_cod_retorno   := 4;
   SV_mens_retorno  := 'ERROR LIMITE DE CONSUMO';
   --RAISE ERROR_LIMEMPRESA;
  END IF;

  -- LIMITE USUARIO ...
  SV_LimiteUsu := '';

 END IF;

    -- PLAN INDIVIDUAL...
 IF LT_tip_plantarif = 'I' THEN

  -- LIMITE EMPRESA...
     SV_LimiteEmp := '';

  -- LIMITE USUARIO ...
  IF  PV_IMP_CARGOBASICO_FN(LT_cod_plantarif, LT_imp_cargobasico) THEN
   SV_LimiteUsu := TO_CHAR(PV_CALCULA_IMPTO_FN(LT_imp_cargobasico));
     ELSE
   SN_cod_retorno   := 4;
   SV_mens_retorno  := 'ERROR IMPORTE CARGO BASICO';
   --RAISE ERROR_LIMEMPRESA;
  END IF;

  -- LIMITE MAXIMO...Scoring de la cuenta
  /*SELECT cod_cliente
  INTO LT_codcliente
  FROM GA_ABOCEL
  WHERE num_abonado = EN_num_abonado;*/

  SELECT num_ident,cod_tipident
  INTO LV_num_ident,LV_cod_tipident
  FROM GE_CLIENTES
  WHERE cod_cliente = LT_codcliente;

  IF PV_CLIENTE_EXCEPCION_FN(LV_num_ident,LV_cod_tipident) THEN

   SV_LimiteMax := '';

  ELSE

   IF PV_OBTIENE_SCORING_FN(LV_num_ident, LV_cod_tipident, LN_valor) THEN

--     LV_signo := SUBSTR(LV_calificacion,1,1);
--     LV_digitos := SUBSTR(LV_calificacion,2,4);
--     LV_decimales := SUBSTR(LV_calificacion,5,2);
--
--     LV_valor_cadena := LV_digitos || '.' || LV_decimales;
--     LN_valor := TO_NUMBER(LV_valor_cadena);

    SV_LimiteMax := TO_CHAR(PV_CALCULA_IMPTO_FN(LN_valor));

   ELSE

    SN_cod_retorno   := 4;
    SV_mens_retorno  := 'ERROR SCORING';
    --RAISE ERROR_SCORING;

   END IF;

  END IF;


 ELSE
     SV_mens_retorno := 'PLAN TARIFARIO NO CORRESPONDE';
 END IF;

 SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;


EXCEPTION
 WHEN NO_DATA_FOUND THEN
    NULL;

 WHEN OTHERS THEN
  SV_mens_retorno:= '';--CV_error_no_clasif;
  LV_des_error:='PV_RECUPERA_LIMITES_PR(' || EN_num_abonado || ', ' || ET_nummovimiento  || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'VE_desbloqueaprepago_sms_PG.VE_OBTIENE_DATOS_ARTICULO', sSql, SQLCODE, LV_des_error );


END PV_RECUPERA_LIMITES_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION  PV_IMP_CARGOBASICO_FN       (ET_cod_plantarif  IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
              ST_ImpCargoBasico OUT TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "PV_IMP_CARGOBASICO_FN "
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción> Obtiene Valor Cargo Básico</Descripción>
       <Parámetros>
         <Entrada>
    <param nom="ET_cod_plantarif"     Tipo="CARACTER">Numero de Identificacion/param>
         </Entrada>
         <Salida>
    <param nom="ST_ImpCargoBasico    Tipo="CARACTER">Importe Cargo Basico/param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

 LT_cod_cargobasico   TA_PLANTARIF.cod_cargobasico%TYPE;
 LT_imp_cargobasico   TA_CARGOSBASICO.imp_cargobasico%TYPE;
 V_des_error        ge_errores_pg.DesEvent;
 LV_sql             ge_errores_pg.vQuery;

 SN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
 SV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
 SN_num_evento       ge_errores_pg.Evento;


BEGIN

    LV_sql := 'SELECT cod_cargobasico';
    LV_sql := LV_sql || ' INTO LT_cod_cargobasico';
    LV_sql := LV_sql || ' FROM TA_PLANTARIF';
    LV_sql := LV_sql || ' WHERE cod_plantarif = '|| ET_cod_plantarif;
    LV_sql := LV_sql || ' AND   cod_producto = 1;';

 SELECT cod_cargobasico
 INTO LT_cod_cargobasico
 FROM TA_PLANTARIF
 WHERE cod_plantarif = ET_cod_plantarif
 AND   cod_producto = 1;


    LV_sql := 'SELECT imp_cargobasico';
    LV_sql := LV_sql || ' INTO LT_imp_cargobasico';
    LV_sql := LV_sql || ' FROM TA_CARGOSBASICO';
    LV_sql := LV_sql || ' WHERE cod_cargobasico = '|| LT_cod_cargobasico;
    LV_sql := LV_sql || ' AND fec_desde < SYSDATE';
    LV_sql := LV_sql || ' AND fec_hasta > SYSDATE';
    LV_sql := LV_sql || ' AND   cod_producto = 1;';

 SELECT imp_cargobasico
 INTO LT_imp_cargobasico
 FROM TA_CARGOSBASICO
 WHERE cod_cargobasico = LT_cod_cargobasico
 AND fec_desde < SYSDATE
 AND fec_hasta > SYSDATE
 AND cod_producto = 1;

 ST_ImpCargoBasico := LT_imp_cargobasico;

 RETURN TRUE;

EXCEPTION

 WHEN NO_DATA_FOUND THEN
     SV_mens_retorno := CV_error_no_clasif;
  V_des_error := 'PV_IMP_CARGOBASICO_FN('||ET_cod_plantarif||'); - ' || SQLERRM;
  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, '1.0', USER, 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_IMP_CARGOBASICO_FN', LV_sql, SQLCODE, V_des_error );
  RETURN FALSE;

 WHEN OTHERS THEN
  SN_cod_retorno := 4; -- 'Error al obtener Importe Cargo Basico'--
  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno := CV_error_no_clasif;
  END IF;
  V_des_error := 'PV_IMP_CARGOBASICO_FN('||ET_cod_plantarif||'); - ' || SQLERRM;
  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, '1.0', USER, 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_IMP_CARGOBASICO_FN', LV_sql, SQLCODE, V_des_error );

  RETURN FALSE;

END PV_IMP_CARGOBASICO_FN;

--------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION  PV_OBTIENE_SCORING_FN       (ET_num_ident    IN  GE_CLIENTES.NUM_IDENT%TYPE,
              ET_cod_tipident IN  GE_CLIENTES.COD_TIPIDENT%TYPE,
              SN_calificacion OUT NOCOPY ERT_SOLICITUD.MTO_RENTA%TYPE
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "PV_OBTIENE_SCORING_FN"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción> Obtiene valor scoring</Descripción>
       <Parámetros>
         <Entrada>
    <param nom="ET_num_ident"     Tipo="CARACTER">Numero de Identificacion/param>
    <param nom="ET_cod_tipident"     Tipo="CARACTER">Numero de Identificacion/param>
         </Entrada>
         <Salida>
    <param nom="SN_calificacion     Tipo="NUMBER">Scoring/param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS


 LV_porc_renta   ERD_PARAMETROS.VAL_PARAMETRO1%TYPE;
 LN_tipo_clie    NUMBER(2);
 LN_mto_renta    ERT_SOLICITUD.MTO_RENTA%TYPE;

--  LB_sw       BOOLEAN;
--  LV_trama       VARCHAR2(1079);--ERT_DATOS_CONSULTA_TO.trama_externa%TYPE;
--  LV_trama_aux  ERT_DATOS_CONSULTA_TO.trama_externa%TYPE;
--  LV_trama_resto VARCHAR2(1079);--ERT_DATOS_CONSULTA_TO.trama_externa%TYPE;
--
--  LV_calif   VARCHAR2(7);
--  LI_largotrama  INTEGER;
--  LV_error   INTEGER(1);

BEGIN

--  LB_sw := TRUE;
--  LV_trama := '';
--  LV_trama_aux := '';
--  LV_trama_resto := '';
--  LV_error := 4;

 SELECT VAL_PARAMETRO1
 INTO   LV_porc_renta
 FROM   ERD_PARAMETROS
 WHERE  COD_CODIGO=300
 AND    COD_SUBCODIGO =2 AND COD_PARAMETRO=1;

 -- VERIFICO TIPO DE CLIENTE --

 BEGIN

   SELECT IND_TIPO_CLIENTE,MTO_RENTA
   INTO   LN_tipo_clie,LN_mto_renta
   FROM   ERT_SOLICITUD
   WHERE  NUM_IDENT_CLIENTE = ET_num_ident
   AND    COD_TIPIDENT = ET_cod_tipident;

   IF LN_tipo_clie = 0 OR LN_tipo_clie = 1 THEN
    -- CLIENTE ANTIGUO : 0 --
   -- CLIENTE NUEVO   : 1 --
    SN_calificacion := (LN_mto_renta * TO_NUMBER(LV_porc_renta))/100;

   END IF;

   IF LN_tipo_clie = 2 THEN
    -- CLIENTES ANTIGUOS PREFERENCIALES --
   SN_calificacion := NULL;
   END IF;

 EXCEPTION
 WHEN NO_DATA_FOUND THEN

                 -- INICIO 39162 RRG COL

   -- TABLA HISTORICA --
                 /*SELECT IND_TIPO_CLIENTE,MTO_RENTA
   INTO LN_tipo_clie,LN_mto_renta
   FROM   ERH_SOLICITUD
   WHERE  NUM_IDENT_CLIENTE = ET_num_ident
   AND    COD_TIPIDENT = ET_cod_tipident
   AND    FEC_INGRESO_H IN (SELECT MAX(FEC_INGRESO_H)
              FROM   ERH_SOLICITUD
           WHERE  NUM_IDENT_CLIENTE = ET_num_ident
                                                                  AND    COD_TIPIDENT = ET_cod_tipident); */



                SELECT
                        IND_TIPO_CLIENTE,MTO_RENTA
                        INTO    LN_tipo_clie,LN_mto_renta
                        FROM
                        ERH_SOLICITUD
                        WHERE
                        NUM_IDENT_CLIENTE = ET_num_ident
                        AND     COD_TIPIDENT = ET_cod_tipident
                        AND     num_solicitud = (
                        SELECT MAX(num_solicitud)
                        FROM ERH_SOLICITUD
                        WHERE   NUM_IDENT_CLIENTE = ET_num_ident AND COD_TIPIDENT = ET_cod_tipident );


                -- INICIO 39162 RRG COL

   IF LN_tipo_clie = 0 OR LN_tipo_clie = 1 THEN
    -- CLIENTE ANTIGUO : 0 --
   -- CLIENTE NUEVO   : 1 --
    SN_calificacion := (LN_mto_renta * TO_NUMBER(LV_porc_renta))/100;

   END IF;

   IF LN_tipo_clie = 2 THEN
    -- CLIENTES ANTIGUOS PREFERENCIALES --
   SN_calificacion := NULL;
   END IF;

 END;

 RETURN TRUE;

EXCEPTION
 WHEN OTHERS THEN
  SN_calificacion := NULL;
   RETURN TRUE;

END PV_OBTIENE_SCORING_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION  PV_IMP_LIMCONSUMO_FN       (EN_num_abonado    IN  GA_ABOCEL.NUM_ABONADO%TYPE,
             ST_imp_limconsumo OUT TOL_LIMITE_TD.IMP_LIMITE%TYPE
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "PV_IMP_LIMCONSUMO_FN"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción> Calcula importe por limite de consumo</Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="NUMBER">Codigo Cliente/param>
         </Entrada>
         <Salida>
    <param nom="ST_imp_limconsumo"     Tipo="CARACTER">Valor del limite de consumo/param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

 V_des_error        ge_errores_pg.DesEvent;
 LV_sql             ge_errores_pg.vQuery;

 SN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
 SV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
 SN_num_evento       ge_errores_pg.Evento;

 LT_cod_limconsumo  TA_PLANTARIF.cod_limconsumo%TYPE;
 LT_imp_limconsumo  TA_LIMCONSUMO.imp_limconsumo%TYPE;


BEGIN

 --Modificacion obtencion de Importe Limite de consumo. Inc XO-200606141136

 --Codigo Limite de Consumo
    LV_sql := 'SELECT cod_limconsumo';
    LV_sql := LV_sql || ' INTO   LT_cod_limconsumo';
    LV_sql := LV_sql || ' FROM   GA_ABOCEL';
    LV_sql := LV_sql || ' WHERE  num_abonado = EN_num_abonado';


 SELECT cod_limconsumo
 INTO   LT_cod_limconsumo
 FROM   GA_ABOCEL
 WHERE  num_abonado = EN_num_abonado;



 --Importe Limite de Consumo.
    LV_sql := 'SELECT imp_limite';
    LV_sql := LV_sql || ' INTO LT_imp_limconsumo';
    LV_sql := LV_sql || ' FROM TOL_LIMITE_TD';
    LV_sql := LV_sql || ' WHERE SYSDATE >= fec_desde';
    LV_sql := LV_sql || ' AND SYSDATE <= fec_hasta';
    LV_sql := LV_sql || ' AND cod_limconsumo = ' || LT_cod_limconsumo;

 /*SELECT imp_limconsumo
 INTO LT_imp_limconsumo
 FROM TA_LIMCONSUMO
 WHERE cod_limconsumo = LT_cod_limconsumo
 AND cod_producto = 1;*/

 SELECT imp_limite
 INTO   LT_imp_limconsumo
 FROM   TOL_LIMITE_TD
 WHERE  cod_limcons = LT_cod_limconsumo
 AND    (SYSDATE >= fec_desde AND (SYSDATE <= fec_hasta OR fec_hasta IS NULL));

 ST_imp_limconsumo := LT_imp_limconsumo;

 RETURN TRUE;

EXCEPTION

 WHEN NO_DATA_FOUND THEN
     SV_mens_retorno := CV_error_no_clasif;
  V_des_error := 'PV_IMP_LIMCONSUMO_FN('|| EN_num_abonado ||'); - ' || SQLERRM;
  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, '1.0', USER, 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_IMP_LIMCONSUMO_FN', LV_sql, SQLCODE, V_des_error );
  RETURN FALSE;

 WHEN OTHERS THEN
     SV_mens_retorno := CV_error_no_clasif;
  V_des_error := 'PV_IMP_LIMCONSUMO_FN('|| EN_num_abonado ||'); - ' || SQLERRM;
  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, '1.0', USER, 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_IMP_LIMCONSUMO_FN', LV_sql, SQLCODE, V_des_error );

  RETURN FALSE;

END PV_IMP_LIMCONSUMO_FN;


----------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION  PV_CALCULA_IMPTO_FN       (EN_valor  IN  NUMBER
) RETURN NUMBER
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "PV_CALCULA_IMPTO_FN "
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción> Calcula impuesto</Descripción>
       <Parámetros>
         <Entrada>
    <param nom="ET_calificacion "     Tipo="CARACTER">Importe/param>
         </Entrada>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    /*LV_signo             VARCHAR2(1);
 LV_digitos          VARCHAR2(4);
 LV_decimales         VARCHAR2(2);

 LV_valor_cadena       VARCHAR2(7);*/
 LN_valor          NUMBER;
 LV_aplic_impto     VARCHAR2(10);
 LV_AplicaImpAtl    VARCHAR2(5);
 SN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
 SV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
 SN_num_evento       ge_errores_pg.Evento;

 LV_impto_ice    VARCHAR2(3);
 LV_impto_iva    VARCHAR2(3);

 LN_importefinal    NUMBER;

 V_des_error        ge_errores_pg.DesEvent;
 LV_sql             ge_errores_pg.vQuery;


BEGIN

 LN_valor := EN_valor;

 LV_AplicaImpAtl := PV_OBTIENE_PARAM_VISTA_FN(CV_codmodulo, 'APLICA_IMPTO_ATL');

 LV_aplic_impto := GE_FN_DEVVALPARAM(CV_codmodulo, CN_producto, 'FLAG_IMPUESTO');


 IF LV_AplicaImpAtl = 'TRUE' THEN

     IF LV_aplic_impto = '1' THEN --APLICA IMPUESTO --

      LV_impto_ice := ge_fn_devvalparam(CV_codmodulo, CN_producto, 'IMPUESTO_ICE');
   LV_impto_iva := ge_fn_devvalparam(CV_codmodulo, CN_producto, 'IMPUESTO_IVA');

   LN_importefinal := LN_valor + ((LN_valor * TO_NUMBER(LV_impto_ice))/100) + ((LN_valor * TO_NUMBER(LV_impto_iva))/100);

   LN_importefinal := ROUND(LN_importefinal);

  ELSE

   LN_importefinal := ROUND(LN_valor);

  END IF;

 ELSE

  LN_importefinal := ROUND(LN_valor);

 END IF;


 RETURN LN_importefinal;

EXCEPTION

 WHEN NO_DATA_FOUND THEN
     SV_mens_retorno := CV_error_no_clasif;
  V_des_error := 'PV_CALCULA_IMPTO_FN('|| EN_valor ||'); - ' || SQLERRM;
  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, '1.0', USER, 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_CALCULA_IMPTO_FN', LV_sql, SQLCODE, V_des_error );
  RETURN TO_NUMBER(EN_valor);

 WHEN OTHERS THEN
     SV_mens_retorno := CV_error_no_clasif;
  V_des_error := 'PV_CALCULA_IMPTO_FN('|| EN_valor ||'); - ' || SQLERRM;
  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, '1.0', USER, 'PV_OBTIENEINFO_ATLANTIDA_PG.PV_CALCULA_IMPTO_FN', LV_sql, SQLCODE, V_des_error );

  RETURN TO_NUMBER(EN_valor);

END PV_CALCULA_IMPTO_FN;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_OBTIENE_PARAM_VISTA_FN(EV_cod_modulo IN VARCHAR2,
         EV_nom_parametro IN VARCHAR2 ) RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "PV_OBTIENE_PARAM_VISTA_FN "
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción> Recupera Parametros</Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EV_cod_modulo  "     Tipo="CARACTER">Modulo</param>
    <param nom="EV_nom_parametro"     Tipo="CARACTER">Parametro que se busca</param>
         </Entrada>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

   LT_val_parametro ged_parametros.val_parametro%TYPE;

BEGIN

 SELECT valor_texto
 INTO   LT_val_parametro
 FROM   GA_PARAMETROS_SIMPLES_VW
 WHERE  nom_parametro = EV_nom_parametro
 AND    cod_modulo = EV_cod_modulo;

    RETURN LT_val_parametro;

EXCEPTION
   WHEN OTHERS THEN
       RETURN 'ERROR';
END;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_CLIENTE_EXCEPCION_FN(ET_num_ident IN GE_CLIENTES.NUM_IDENT%TYPE,
          ET_cod_tipident IN  GE_CLIENTES.COD_TIPIDENT%TYPE
         ) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "PV_CLIENTE_EXCEPCION_FN"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción> Verifica si cliente tiene excepcion de evaluacion</Descripción>
       <Parámetros>
         <Entrada>
    <param nom="ET_num_ident  "     Tipo="CARACTER">Modulo</param>
   <param nom="ET_cod_tipident  "     Tipo="CARACTER">Modulo</param>
         </Entrada>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    LN_cantidad NUMBER;

BEGIN

 SELECT COUNT(1)
 INTO   LN_cantidad
 FROM   ERD_EXCEPCION
 WHERE  num_ident = ET_num_ident
 AND    cod_tipident = ET_cod_tipident;

 IF LN_cantidad > 0 THEN
     RETURN TRUE;
 ELSE
     RETURN FALSE;
 END IF;


EXCEPTION
   WHEN OTHERS THEN
       RETURN FALSE;
END;


--------------------------------------------------------------

FUNCTION PV_CLIENTEESATLANTIDA_FN(
    ET_COD_CLIENTE  IN ga_abocel.COD_CLIENTE%TYPE)
RETURN NUMBER IS

ln_existe NUMBER;
BEGIN

    BEGIN
    -- Para determinar si existe un abonado con el servicio atlantida activo --
    SELECT 1 INTO ln_existe
        FROM ga_abocel a
    WHERE  a.cod_cliente = ET_COD_CLIENTE
    AND cod_situacion NOT IN ('BAA','BAP', 'TAP' )
    AND EXISTS (SELECT 1 FROM ga_servsuplabo b
                    WHERE a.num_abonado = b.num_abonado
                        AND EXISTS (SELECT 1
                                        FROM   ged_codigos c
                                        WHERE  cod_modulo = 'GA'
                                        AND  nom_tabla = 'GAD_SERVSUP_PLAN'
                                                AND  nom_columna = 'COD_SERVICIO'
                                                AND b.cod_servicio = c.cod_valor )
                        AND b.ind_estado<3)
    AND ROWNUM=1;

    RETURN TO_NUMBER(1);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN TO_NUMBER(0);
                WHEN OTHERS THEN
            RETURN TO_NUMBER(0);

    END;

END pv_clienteesatlantida_fn;

-------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_RECUPERA_EMAIL_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SV_email  OUT NOCOPY GE_CLIENTES.nom_email%TYPE,
    SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
    SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
    SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_RECUPERA_EMAIL_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
         </Entrada>
         <Salida>
     <param nom="SV_email"           Tipo="VARCHAR2">Limite usuario</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS
        LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;
  ST_email    GE_CLIENTES.nom_email%TYPE;

BEGIN

     --obtener tipo de plan Invidual/Empresa

 sSql := 'SELECT C.nom_email INTO ST_email FROM GA_ABOCEL A, GE_CLIENTES C ';
 sSql := sSql || 'WHERE A.num_abonado = EN_num_abonado AND   A.cod_situacion NOT IN ''BAA'', ''BAP''';
 sSql := sSql || 'AND   A.cod_cliente = C.cod_cliente';

 SELECT C.nom_email
 INTO ST_email
 FROM GA_ABOCEL A, GE_CLIENTES C
 WHERE A.num_abonado = EN_num_abonado
 AND   A.cod_situacion NOT IN ('BAA', 'BAP')
 AND   A.cod_cliente = C.cod_cliente;

 SV_email := LTRIM(RTRIM(ST_email));

 SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
  SN_cod_retorno   := 4;
  SV_mens_retorno  := 'No Posee e-mail';
  SN_num_evento    := NULL;

 WHEN OTHERS THEN
     SN_cod_retorno   := 4;
  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error := 'PV_RECUPERA_EMAIL_PR (' || EN_num_abonado || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'VE_desbloqueaprepago_sms_PG.PV_RECUPERA_EMAIL_PR', sSql, SQLCODE, LV_des_error );

END PV_RECUPERA_EMAIL_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_EXISTEABOATLANTIDA_PR(
    EN_num_abonado IN GA_ABOCEL.num_abonado%TYPE,
    SV_existeabo OUT NOCOPY VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_EXISTEABOATLANTIDA_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_cod_cliente"     Tipo="CARACTER">Codigo de cliente</param>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
         </Entrada>
         <Salida>
     <param nom="SV_email"           Tipo="VARCHAR2">Limite usuario</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

 ST_cont         NUMBER;
 LT_cod_cliente   GA_ABOCEL.COD_CLIENTE%TYPE;
    LV_des_error         GE_ERRORES_PG.DesEvent;
 sSql                 GE_ERRORES_PG.vQuery;
 LV_ServiciosATL   VARCHAR2(50);

BEGIN

    SELECT cod_cliente
 INTO LT_cod_cliente
 FROM GA_ABOCEL
 WHERE num_abonado = EN_num_abonado;

-- INI XO-200605221111 HPG--
 PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
 IF LV_ServiciosATL = '' OR LV_ServiciosATL IS NULL THEN
  SV_mens_retorno := 'Error en obtencion de Servicios Atlantida';
 END IF;

 sSql := 'SELECT COUNT(1) FROM   GA_SERVSUPLABO A ';
 sSql := sSql || ' WHERE  A.num_abonado IN (SELECT B.num_abonado ';
 sSql := sSql || ' FROM GA_ABOCEL B ';
 sSql := sSql || ' WHERE B.cod_cliente = ' ||  LT_cod_cliente ;
 sSql := sSql || ' AND B.num_abonado <> ' ||  EN_num_abonado ;
 sSql := sSql || ' AND B.cod_situacion NOT IN (''BAA'', ''BAP''))';
 sSql := sSql || ' AND   A.cod_servicio IN (' || LV_ServiciosATL || ')';
 sSql := sSql || ' AND    A.ind_estado < 3 ';
 EXECUTE IMMEDIATE Ssql INTO ST_cont;
-- FIN XO-200605221111 HPG--

 IF ST_cont > 0 THEN
    SV_existeabo := 'TRUE';
 ELSE
    SV_existeabo := 'FALSE';
 END IF;

 SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
  SV_existeabo := 'FALSE';

 WHEN OTHERS THEN
  SV_existeabo := 'FALSE';
  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error:= 'PV_EXISTEABOATLANTIDA_PR(' || EN_num_abonado || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA_PR', sSql, SQLCODE, LV_des_error );
END PV_EXISTEABOATLANTIDA_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_RECUPERAIDEMP_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SN_cliente  OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_RECUPERAIDEM_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
         </Entrada>
         <Salida>
     <param nom="SN_cliente"           Tipo="VARCHAR2">Cliente</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS
        LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;
  ST_cliente    GE_CLIENTES.cod_cliente%TYPE;

BEGIN


 sSql := 'SELECT C.cod_cliente INTO ST_cliente FROM GA_ABOCEL A ';
 sSql := sSql || 'WHERE A.num_abonado = EN_num_abonado; ';

 SELECT A.cod_cliente
 INTO   ST_cliente
 FROM   GA_ABOCEL A
 WHERE  A.num_abonado = EN_num_abonado;

 SN_cliente := ST_cliente;

 SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;


EXCEPTION
 WHEN NO_DATA_FOUND THEN
  SV_mens_retorno:= 'ABONADO NO EXISTE COMO CLIENTE POST-PAGO';
  LV_des_error:='PV_RECUPERAIDEMP_PR(' || EN_num_abonado || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_RECUPERAIDEM_PR', sSql, SQLCODE, LV_des_error );

    NULL;
 WHEN OTHERS THEN
  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error:='PV_RECUPERAIDEMP_PR(' || EN_num_abonado || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_RECUPERAIDEM_PR', sSql, SQLCODE, LV_des_error );
END PV_RECUPERAIDEMP_PR;

------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENEFECHARES_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SN_fechares  OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENEFECHARES_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
         </Entrada>
         <Salida>
     <param nom="SN_fechares"           Tipo="VARCHAR2">Fecha de reseteo</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS
        LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;
  ST_fechares    FA_CICLFACT.COD_CICLFACT%TYPE;

BEGIN


 sSql := 'SELECT F.cod_ciclfact INTO   ST_cliente FROM   GA_ABOCEL A, GE_CLIENTES B, FA_CICLFACT F ';
 sSql := sSql || 'WHERE  A.num_abonado = EN_num_abonado ';
 sSql := sSql || 'AND    A.cod_cliente = B.cod_cliente ';
 sSql := sSql || 'AND    F.cod_ciclo = B.cod_ciclo ';
 sSql := sSql || 'AND    SYSDATE BETWEEN F.FEC_DESDEOCARGOS AND F.FEC_HASTAOCARGOS; ';

 SELECT F.cod_ciclfact
 INTO   ST_fechares
 FROM   GA_ABOCEL A, GE_CLIENTES B, FA_CICLFACT F
 WHERE  A.num_abonado = EN_num_abonado
 AND    A.cod_cliente = B.cod_cliente
 AND    F.cod_ciclo = B.cod_ciclo
 AND    SYSDATE BETWEEN F.fec_desdellam AND F.fec_hastallam;

 SN_fechares := ST_fechares;

 SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;


EXCEPTION
 WHEN NO_DATA_FOUND THEN
  --SV_error := 4;
  --SV_sqlcode := SQLCODE;
  --SV_sqlerrm := 'NO SE ENCONTRO E-MAIL';

    NULL;
 WHEN OTHERS THEN
  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error:='PV_OBTIENEFECHARES_PR(' || EN_num_abonado || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENEFECHARES_PR', sSql, SQLCODE, LV_des_error );
END PV_OBTIENEFECHARES_PR;

------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENEREPRES_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SV_nombreresp OUT NOCOPY VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENEREPRES_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
         </Entrada>
         <Salida>
     <param nom="SV_nombreresp"           Tipo="VARCHAR2">Nombre de Representante</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS
    LV_des_error         GE_ERRORES_PG.DesEvent;
 sSql                 GE_ERRORES_PG.vQuery;
 ST_nombreresp      VARCHAR2(100);
 ST_usuario    GA_ABOCEL.COD_USUARIO%TYPE;

BEGIN


 sSql := 'SELECT R.nom_responsable INTO   ST_nombreresp FROM   GA_ABOCEL A, GA_RESPCLIENTES R ';
 sSql := sSql || 'WHERE  A.num_abonado = EN_num_abonado ';
 sSql := sSql || 'AND    A.cod_cliente = R.cod_cliente; ';

 SELECT R.nom_responsable
 INTO   ST_nombreresp
 FROM   GA_ABOCEL A, GA_RESPCLIENTES R
 WHERE  A.num_abonado = EN_num_abonado
 AND    A.cod_cliente = R.cod_cliente;

 SV_nombreresp := ST_nombreresp;

 SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;


EXCEPTION
 WHEN NO_DATA_FOUND THEN

   SELECT COD_USUARIO
   INTO   ST_usuario
   FROM   GA_ABOCEL
   WHERE  NUM_ABONADO=EN_num_abonado;

   SELECT NOM_USUARIO || ' ' || NOM_APELLIDO1 || ' ' || NOM_APELLIDO2
   INTO   ST_nombreresp
   FROM   GA_USUARIOS
   WHERE  COD_USUARIO = ST_usuario;

     SV_nombreresp := ST_nombreresp;

   SN_cod_retorno   := 0;
   SV_mens_retorno  := 'OK';
   SN_num_evento    := 0;

 WHEN OTHERS THEN
  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error:='PV_OBTIENEREPRES_PR(' || EN_num_abonado || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENEREPRES_PR', sSql, SQLCODE, LV_des_error );
END PV_OBTIENEREPRES_PR;

------------------------------------------------------------------------------------------------
PROCEDURE PV_EXISTEABOATLANTIDA2_PR(
    EN_num_abonado IN ga_abocel.num_abonado%TYPE,
    SV_existeabo OUT NOCOPY VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_EXISTEABOATLANTIDA2_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
         </Entrada>
         <Salida>
     <param nom="SV_existeabo"           Tipo="VARCHAR2">TRUE: Existe y FALSE : No Existe</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS
 LV_des_error         GE_ERRORES_PG.DesEvent;
 sSql                 GE_ERRORES_PG.vQuery;
 ST_cont         NUMBER;
 LV_ServiciosATL   VARCHAR2(50);

BEGIN

-- INI XO-200605221111 HPG--
 PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
 IF LV_ServiciosATL = '' OR LV_ServiciosATL IS NULL THEN
  SV_mens_retorno := 'Error en obtencion de Servicios Atlantida (GED_CODIGOS)';
 END IF;

    Ssql:= 'SELECT COUNT(1) ';
    Ssql:= SSql || ' FROM   GA_SERVSUPLABO A';
    Ssql:= Ssql || ' WHERE  A.num_abonado =  ' || EN_num_abonado ;
 Ssql:= Ssql || ' AND    A.cod_servicio IN (' || LV_ServiciosATL || ')' ;
 Ssql:= SSql || ' AND    A.ind_estado<3';
 EXECUTE IMMEDIATE Ssql INTO ST_cont;
-- FIN XO-200605221111 HPG--

 IF ST_cont > 0 THEN
    SV_existeabo := 'TRUE';
 ELSE
    SV_existeabo := 'FALSE';
 END IF;

 SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;


EXCEPTION
 WHEN NO_DATA_FOUND THEN
  SV_existeabo := 'FALSE';
 WHEN OTHERS THEN
  SV_existeabo := 'FALSE';
  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error:='PV_EXISTEABOATLANTIDA2_PR(' || EN_num_abonado || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA2_PR', sSql, SQLCODE, LV_des_error );
END PV_EXISTEABOATLANTIDA2_PR;

------------------------------------------------------------------------------------------------
PROCEDURE PV_INSERTAMOV_ATL_PR(
      EN_num_abonado IN GA_ABOCEL.num_abonado%TYPE,
    EN_plan_destino IN GA_ABOCEL.cod_plantarif%TYPE,
    EN_cod_cliente  IN  GA_ABOCEL.cod_cliente%TYPE,
    EV_param  IN  VARCHAR2,
    SV_insertook OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INSERTAMOV_ATL_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_num_abonado"     Tipo="CARACTER">Numero de Abonado</param>
    <param nom="EN_plan_destino"     Tipo="CARACTER">Plan Tarifario Destino</param>
         </Entrada>
         <Salida>
     <param nom="SV_insertook"           Tipo="VARCHAR2">0: OK y 1: No inserto Ok</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS
    LV_des_error         GE_ERRORES_PG.DesEvent;
  sSql                 GE_ERRORES_PG.vQuery;
  LN_cont_origen   NUMBER;
  LN_cont_destino   NUMBER;
  LN_CANT_ABO          NUMBER;
  LN_CANT_ABO2   NUMBER;

  LT_plan_origen   GA_ABOCEL.COD_PLANTARIF%TYPE;
  LN_po_atlantida   NUMBER; -- 0:NO ES ATLANTIDA    1:ES ATLANTIDA --
  LN_pd_atlantida   NUMBER; -- 0:NO ES ATLANTIDA    1:ES ATLANTIDA --
  LN_num_mov    NUMBER;
  LN_COD_CLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;
  LV_tipoplandestino   TA_PLANTARIF.TIP_PLANTARIF%TYPE;
  LV_existeatlantida  VARCHAR2(10);
  LN_cont     NUMBER;
  LV_param          VARCHAR2(1);

  Lt_actabo    GA_ACTABO.COD_ACTABO%TYPE;
  LT_codactcen   GA_ACTABO.COD_ACTCEN%TYPE;
  LT_numcelular   GA_ABOCEL.NUM_CELULAR%TYPE;
  LT_codcentral   GA_ABOCEL.COD_CENTRAL%TYPE;
  LT_numserie    GA_ABOCEL.NUM_SERIE%TYPE;
  LT_tipterminal   GA_ABOCEL.TIP_TERMINAL%TYPE;
  LT_tecnologia   GA_ABOCEL.COD_TECNOLOGIA%TYPE;
 LT_num_os    PV_IORSERV.NUM_OS%TYPE;
 LT_num_movimiento  PV_MOVIMIENTOS.NUM_MOVIMIENTO%TYPE;
  LV_ServiciosATL   VARCHAR2(50);
 LV_ClaseSS    PV_CAMCOM.CLASE_SERVICIO_ACT%TYPE;

BEGIN

 Lt_actabo := '';
 SN_cod_retorno   := 0;

 IF EV_param IS NULL THEN

  LV_param := 'C';

 ELSE

  LV_param := 'T';

 END IF;

 sSql := 'SELECT COD_PLANTARIF,COD_CLIENTE INTO   LT_plan_origen,LN_COD_CLIENTE FROM GA_ABOCEL ';
 sSql := sSql || 'WHERE  NUM_ABONADO = ' || EN_num_abonado;
 SELECT cod_plantarif,COD_CLIENTE
 INTO   LT_plan_origen,LN_COD_CLIENTE
 FROM   GA_ABOCEL
 WHERE  num_abonado = EN_num_abonado;

-- INI XO-200605221111 HPG--
 PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
 IF LV_ServiciosATL = '' OR LV_ServiciosATL IS NULL THEN
  SV_mens_retorno := 'Error en obtencion de Servicios Atlantida';
 END IF;

 sSql := 'SELECT COUNT(1) FROM   GA_SERVSUPL A ';
 sSql := sSql || ' WHERE  A.cod_servicio IN (SELECT cod_servicio ';
 sSql := sSql || ' FROM   GAD_SERVSUP_PLAN ';
 sSql := sSql || ' WHERE  cod_plantarif = ''' || LT_plan_origen || '''';
 sSql := sSql || ' AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA)' ;
 sSql := sSql || ' AND   A.cod_servicio IN (' || LV_ServiciosATL || ')';
 EXECUTE IMMEDIATE Ssql INTO LN_cont_origen;
-- FIN XO-200605221111 HPG--

 IF LN_cont_origen > 0 THEN
    LN_po_atlantida := 1;
 ELSE
    LN_po_atlantida := 0;
 END IF;

 -- INI.MAM 08.08.2006
 -- Plan Destino : Existen SS Atlantida
 -- SI ES INDIVIDUAL O EMPRESA --
 SELECT TIP_PLANTARIF
 INTO   LV_tipoplandestino
 FROM   TA_PLANTARIF
 WHERE  COD_PRODUCTO=1
 AND    COD_PLANTARIF=EN_plan_destino;

 sSql := 'SELECT COUNT(1) FROM   GA_SERVSUPLABO A ';
 sSql := sSql || ' WHERE  A.num_abonado IN (SELECT B.num_abonado ';
 sSql := sSql || ' FROM GA_ABOCEL B ';
 sSql := sSql || ' WHERE B.cod_cliente = ' || EN_cod_cliente ;
 sSql := sSql || ' AND B.cod_situacion NOT IN (''BAA'', ''BAP''))' ;
 sSql := sSql || ' AND   A.cod_servicio IN (' || LV_ServiciosATL || ')';
 Ssql := SSql || ' AND    A.ind_estado = 2'; -- INC. XO-200605230007
 EXECUTE IMMEDIATE Ssql INTO LN_cont;


 IF LN_cont > 0 THEN
    -- CLIENTE TIENE ATLANTIDA --
    LV_existeatlantida := 'TRUE';
 ELSE
       -- CLIENTE NO TIENE ATLANTIDA --
    LV_existeatlantida := 'FALSE';
 END IF;
 -- FIN.MAM 08.08.2006

 sSql := 'SELECT COUNT(1) FROM   GA_SERVSUPL A ';
 sSql := sSql || ' WHERE  A.cod_servicio IN (SELECT cod_servicio ';
 sSql := sSql || ' FROM   GAD_SERVSUP_PLAN ';
 sSql := sSql || ' WHERE  cod_plantarif = ''' || EN_plan_destino || '''';
 sSql := sSql || ' AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA)' ;
 sSql := sSql || ' AND   A.cod_servicio IN (' || LV_ServiciosATL || ')';
 EXECUTE IMMEDIATE Ssql INTO LN_cont_destino;

 IF LN_cont_destino > 0 THEN
    LN_pd_atlantida := 1;
 ELSE
    LN_pd_atlantida := 0;
 END IF;

 -- ORIGEN:ATLANTIDA  DESTINO:ATLANTIDA
 IF ((LN_po_atlantida = 1 AND LN_pd_atlantida = 1) AND (LT_plan_origen <> EN_plan_destino)) THEN

    -- INI.MAM 08.08.2006
    IF  LV_tipoplandestino = 'I' THEN
        -- PLAN DESTINO ES INDIVIDUAL --

     IF LV_existeatlantida = 'TRUE' AND LN_pd_atlantida = 1 AND TRIM(LV_param) <> 'T' THEN
        -- CLIENTE TIENE ATLANTIDA --
     Lt_actabo := 'I1'; -- REALIZA CAMBIO DE LIMITE --

     END IF;

     IF LV_existeatlantida = 'FALSE' AND LN_pd_atlantida = 1 THEN
        -- CLIENTE NO TIENE ATLANTIDA --
              Lt_actabo := 'I2'; -- REALIZA ALTA DE CUENTA --

     END IF;

    ELSE

        IF TRIM(LV_param) <> 'T' THEN

        Lt_actabo := 'I1'; -- REALIZA CAMBIO DE LIMITE --

     -- Insertamos el movimiento para el cambio de limite empresa
   SELECT MIN(b.num_os)
   INTO LT_num_os
   FROM pv_camcom a, pv_iorserv b, pv_erecorrido c
   WHERE a.cod_cliente = EN_COD_CLIENTE -- 01.08.2006 --
   AND TRUNC(b.fh_ejecucion) <= TRUNC(SYSDATE) -- XO-200607061166 --
   AND a.num_os = b.num_os
   AND b.cod_os IN (10022,10029)
   AND c.num_os = b.num_os
   AND c.cod_estado = 210
   AND c.tip_estado = 1;


       SELECT NVL(num_movimiento,0)
       INTO LT_num_movimiento
       FROM PV_MOVIMIENTOS
      WHERE num_os = LT_num_os;

      IF LT_num_movimiento = 0 THEN

     sSql := 'SELECT ICC_SEQ_NUMMOV.NEXTVAL into LN_num_mov FROM DUAL; ';
     SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO LN_num_mov
     FROM DUAL;

     sSql := 'SELECT COD_ACTCEN INTO   LT_codactcen FROM GA_ACTABO ';
     sSql := sSql || 'WHERE  COD_ACTABO = ' || Lt_actabo;

     SELECT cod_actcen
     INTO   LT_codactcen
     FROM   GA_ACTABO
     WHERE  cod_actabo = 'I3';

     SELECT num_celular,cod_central,num_serie,tip_terminal,cod_tecnologia
     INTO   LT_numcelular,LT_codcentral,LT_numserie,LT_tipterminal,LT_tecnologia
     FROM   GA_ABOCEL
     WHERE  NUM_ABONADO = EN_num_abonado;

     INSERT INTO ICC_MOVIMIENTO (num_movimiento, num_abonado, num_celular,
     cod_estado, cod_modulo, cod_actuacion, nom_usuarora,
     fec_ingreso,cod_central, num_serie, tip_terminal,
     cod_actabo,tip_tecnologia,PLAN)
     VALUES
     (LN_num_mov, EN_num_abonado, LT_numcelular, 1, CV_codmodulo, LT_codactcen, USER ,
     SYSDATE,LT_codcentral, LT_numserie,LT_tipterminal, 'I3',
     LT_tecnologia,EN_plan_destino);

     UPDATE PV_MOVIMIENTOS
        SET NUM_MOVIMIENTO = LN_num_mov
      WHERE NUM_OS = LT_num_os;

     END IF;

     -- INI.MAM XO-200606141135 14.06.2006 --
     ELSE
         -- TRASPASO --
      IF LV_existeatlantida = 'FALSE' AND LN_pd_atlantida = 1 THEN
         -- CLIENTE NO TIENE ATLANTIDA --
               Lt_actabo := 'I2'; -- REALIZA ALTA DE CUENTA --
      END IF;

              -- FIN.MAM XO-200606141135 14.06.2006 --
     END IF;
    END IF;

      -- FIN.MAM 08.08.2006
 END IF;

 -- INI.XO-200606081132 13.06.2006 --
 IF TRIM(LV_param) = 'T' THEN
     -- SOLO TRASPASOS
     IF ((LN_po_atlantida = 1 AND LN_pd_atlantida = 1) AND (LT_plan_origen = EN_plan_destino)) THEN

     IF LV_existeatlantida = 'FALSE' AND LN_pd_atlantida = 1 THEN
        -- CLIENTE NO TIENE ATLANTIDA --
              Lt_actabo := 'I2'; -- REALIZA ALTA DE CUENTA --

     END IF;

  END IF;
 END IF;
 -- FIN.XO-200606081132 13.06.2006 --
 -- ORIGEN:NO ATLANTIDA  DESTINO:ATLANTIDA
 IF LN_po_atlantida = 0 AND LN_pd_atlantida = 1 THEN

    -- INI.MAM 08.08.2006
    IF  LV_tipoplandestino = 'I' THEN
        -- PLAN DESTINO ES INDIVIDUAL --

     IF LV_existeatlantida = 'FALSE' AND LN_pd_atlantida = 1 THEN
        -- CLIENTE NO TIENE ATLANTIDA --
              Lt_actabo := 'I2'; -- REALIZA ALTA DE CUENTA --

     END IF;

     IF LV_existeatlantida = 'TRUE' AND TRIM(LV_param) <> 'T'  THEN
        -- CLIENTE TIENE ATLANTIDA --
              Lt_actabo := 'I2'; -- REALIZA ALTA DE CUENTA --

     END IF;


    ELSE

        IF TRIM(LV_param) <> 'T' THEN

         Lt_actabo := 'I2'; -- REALIZA ALTA DE CUENTA --

     ELSE

      -- CLIENTE VACIO
      SELECT COUNT(1)
      INTO   LN_CANT_ABO2
      FROM   GA_ABOCEL A
      WHERE  A.COD_CLIENTE  =  LN_COD_CLIENTE;

      IF LN_CANT_ABO2 = 0 THEN

      Lt_actabo := 'I2'; -- REALIZA ALTA DE CUENTA --

      END IF;

     END IF;

    END IF;

 END IF;

 IF Lt_actabo <> '' OR Lt_actabo IS NOT NULL THEN


  IF TRIM(LV_param) = 'T' THEN
     -- TRASPASOS --

         SELECT COUNT(1)
   INTO   LN_CANT_ABO
   FROM   GA_ABOCEL A
   WHERE
   A.COD_CLIENTE  =  LN_COD_CLIENTE AND
   A.NUM_ABONADO <>  EN_num_abonado AND
   A.NUM_ABONADO IN (SELECT  B.NUM_ABONADO FROM ICC_MOVIMIENTO B
                     WHERE A.NUM_ABONADO = B.NUM_ABONADO AND
                           COD_ACTABO= 'I2');


   IF LN_CANT_ABO > 0 THEN
              SN_cod_retorno   := 2;
      END IF;


         IF  SN_cod_retorno  =0 THEN


    sSql := 'SELECT ICC_SEQ_NUMMOV.NEXTVAL into LN_num_mov FROM DUAL; ';
    SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO LN_num_mov
    FROM DUAL;

    sSql := 'SELECT COD_ACTCEN INTO   LT_codactcen FROM GA_ACTABO ';
    sSql := sSql || 'WHERE  COD_ACTABO = ' || Lt_actabo;

    SELECT cod_actcen
    INTO   LT_codactcen
    FROM   GA_ACTABO
    WHERE  cod_actabo = Lt_actabo;

    SELECT num_celular,cod_central,num_serie,tip_terminal,cod_tecnologia
    INTO   LT_numcelular,LT_codcentral,LT_numserie,LT_tipterminal,LT_tecnologia
    FROM   GA_ABOCEL
    WHERE  NUM_ABONADO=EN_num_abonado;

       IF Lt_actabo  ='I2' THEN
              SN_cod_retorno   := 2;
       END IF ;

    sSql := 'INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO, NUM_ABONADO, NUM_CELULAR, ';
    sSql := sSql || 'COD_ESTADO, COD_MODULO, COD_ACTUACION, NOM_USUARORA,  ';
    sSql := sSql || 'FEC_INGRESO,COD_CENTRAL, NUM_SERIE, TIP_TERMINAL,   ';
    sSql := sSql || 'COD_ACTABO,TIP_TECNOLOGIA,PLAN) ';
    sSql := sSql || 'VALUES (' || LN_num_mov || ', ' || EN_num_abonado || ', ' || LT_numcelular || ', 1, ''GA'', ' || LT_codactcen || ', USER , ';
    sSql := sSql || 'SYSDATE, ' || LT_codcentral || ', ' || LT_numserie ||', ' || LT_tipterminal || ', ' ||Lt_actabo || ', ';
    sSql := sSql || LT_tecnologia || ', ' ||EN_plan_destino || '); ';

    INSERT INTO ICC_MOVIMIENTO (num_movimiento, num_abonado, num_celular,
    cod_estado, cod_modulo, cod_actuacion, nom_usuarora,
    fec_ingreso,cod_central, num_serie, tip_terminal,
    cod_actabo,tip_tecnologia,PLAN)
    VALUES
    (LN_num_mov, EN_num_abonado, LT_numcelular, 1, CV_codmodulo, LT_codactcen, USER ,
    SYSDATE,LT_codcentral, LT_numserie,LT_tipterminal, Lt_actabo,
    LT_tecnologia,EN_plan_destino);
         END IF;

  END IF;

  IF TRIM(LV_param) <> 'T' THEN
      -- CAMBIO DE PLANES --

--          SELECT COUNT(1)
--    INTO   LN_CANT_ABO
--    FROM   GA_ABOCEL A
--    WHERE
--    A.COD_CLIENTE  =  LN_COD_CLIENTE AND
--    A.NUM_ABONADO <>  EN_num_abonado AND
--    A.NUM_ABONADO IN (SELECT  B.NUM_ABONADO FROM ICC_MOVIMIENTO B
--                      WHERE A.NUM_ABONADO = B.NUM_ABONADO AND
--                            COD_ACTABO= 'I2');


--   IF LV_existeatlantida = 'TRUE' AND Lt_actabo = 'I2' THEN
--      -- CLIENTE ES ATLANTIDA Y REALIZA ALTA DE CUENTA --
--             SN_cod_retorno   := 2;
--      END IF;


--         IF  SN_cod_retorno  =0 THEN

     -- INI.CONTROLAMOS MOVIMIENTO I2, UNA SOLA VEZ

        IF Lt_actabo = 'I2' THEN

    SELECT MIN(b.num_os)
    INTO LT_num_os
    FROM pv_camcom a, pv_iorserv b, pv_erecorrido c
    WHERE a.cod_cliente = EN_COD_CLIENTE -- 01.08.2006 --
    AND TRUNC(b.fh_ejecucion) <= TRUNC(SYSDATE) -- XO-200607061166 --
    AND a.num_os = b.num_os
    AND b.cod_os IN (10022,10029,10020) -- XO-200607061166 18.07.2006--
    --AND b.cod_estado = 110; -- 24.07.2006 --
    AND c.num_os = b.num_os
    AND c.cod_estado = 210
    AND c.tip_estado = 1;

        SELECT NVL(num_movimiento,0)
        INTO LT_num_movimiento
        FROM PV_MOVIMIENTOS
       WHERE num_os = LT_num_os;

       IF LT_num_movimiento = 0 THEN

      sSql := 'SELECT ICC_SEQ_NUMMOV.NEXTVAL into LN_num_mov FROM DUAL; ';
      SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO LN_num_mov
      FROM DUAL;

      sSql := 'SELECT COD_ACTCEN INTO   LT_codactcen FROM GA_ACTABO ';
      sSql := sSql || 'WHERE  COD_ACTABO = ' || Lt_actabo;

      SELECT cod_actcen
      INTO   LT_codactcen
      FROM   GA_ACTABO
      WHERE  cod_actabo = Lt_actabo;

      SELECT num_celular,cod_central,num_serie,tip_terminal,cod_tecnologia
      INTO   LT_numcelular,LT_codcentral,LT_numserie,LT_tipterminal,LT_tecnologia
      FROM   GA_ABOCEL
      WHERE  NUM_ABONADO=EN_num_abonado;

--          IF Lt_actabo  ='I2' THEN
--                SN_cod_retorno   := 2;
--          END IF ;

      sSql := 'INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO, NUM_ABONADO, NUM_CELULAR, ';
      sSql := sSql || 'COD_ESTADO, COD_MODULO, COD_ACTUACION, NOM_USUARORA,  ';
      sSql := sSql || 'FEC_INGRESO,COD_CENTRAL, NUM_SERIE, TIP_TERMINAL,   ';
      sSql := sSql || 'COD_ACTABO,TIP_TECNOLOGIA,PLAN) ';
      sSql := sSql || 'VALUES (' || LN_num_mov || ', ' || EN_num_abonado || ', ' || LT_numcelular || ', 1, ''GA'', ' || LT_codactcen || ', USER , ';
      sSql := sSql || 'SYSDATE, ' || LT_codcentral || ', ' || LT_numserie ||', ' || LT_tipterminal || ', ' ||Lt_actabo || ', ';
      sSql := sSql || LT_tecnologia || ', ' ||EN_plan_destino || '); ';

      INSERT INTO ICC_MOVIMIENTO (num_movimiento, num_abonado, num_celular,
      cod_estado, cod_modulo, cod_actuacion, nom_usuarora,
      fec_ingreso,cod_central, num_serie, tip_terminal,
      cod_actabo,tip_tecnologia,PLAN)
      VALUES
      (LN_num_mov, EN_num_abonado, LT_numcelular, 1, CV_codmodulo, LT_codactcen, USER ,
      SYSDATE,LT_codcentral, LT_numserie,LT_tipterminal, Lt_actabo,
      LT_tecnologia,EN_plan_destino);

      UPDATE PV_MOVIMIENTOS
         SET NUM_MOVIMIENTO = LN_num_mov
       WHERE NUM_OS = LT_num_os;

           END IF;
         -- FIN.CONTROLAMOS MOVIMIENTO I2, UNA SOLA VEZ
     END IF;

     IF Lt_actabo = 'I1' THEN

-- P-MIX-06003-G1 43120 - ini - spz
        -- INI gbm - soporte 27-01-2007 - 36481
        IF LT_NUM_OS IS NULL THEN
           SELECT MIN(B.NUM_OS) INTO LT_NUM_OS
           FROM PV_CAMCOM A, PV_IORSERV B, PV_ERECORRIDO C
           WHERE A.COD_CLIENTE = EN_COD_CLIENTE
           AND A.NUM_ABONADO = EN_NUM_ABONADO
           AND TRUNC(B.FH_EJECUCION) <= TRUNC(SYSDATE)
           AND A.NUM_OS = B.NUM_OS
           AND B.COD_OS IN (10020,10022,10029)
           AND C.NUM_OS = B.NUM_OS
           AND C.COD_ESTADO = 210
           AND C.TIP_ESTADO = 1;
        END IF;

        SELECT CLASE_SERVICIO_ACT
        INTO   LV_ClaseSS
        FROM   PV_CAMCOM
        WHERE  NUM_OS = LT_NUM_OS;

        IF LV_CLASESS = '*' THEN
           LV_CLASESS := NULL;
        END IF;
        -- FIN gbm - soporte 27-01-2007 - 36481

-- P-MIX-06003-G1 43120 - fin - spz

     sSql := 'SELECT ICC_SEQ_NUMMOV.NEXTVAL into LN_num_mov FROM DUAL; ';
     SELECT ICC_SEQ_NUMMOV.NEXTVAL INTO LN_num_mov
     FROM DUAL;

     sSql := 'SELECT COD_ACTCEN INTO   LT_codactcen FROM GA_ACTABO ';
     sSql := sSql || 'WHERE  COD_ACTABO = ' || Lt_actabo;

     SELECT cod_actcen
     INTO   LT_codactcen
     FROM   GA_ACTABO
     WHERE  cod_actabo = Lt_actabo;

     SELECT num_celular,cod_central,num_serie,tip_terminal,cod_tecnologia
     INTO   LT_numcelular,LT_codcentral,LT_numserie,LT_tipterminal,LT_tecnologia
     FROM   GA_ABOCEL
     WHERE  NUM_ABONADO=EN_num_abonado;

     sSql := 'INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO, NUM_ABONADO, NUM_CELULAR, ';
     sSql := sSql || 'COD_ESTADO, COD_MODULO, COD_ACTUACION, NOM_USUARORA,  ';
     sSql := sSql || 'FEC_INGRESO,COD_CENTRAL, NUM_SERIE, TIP_TERMINAL,   ';
     sSql := sSql || 'COD_ACTABO,TIP_TECNOLOGIA,PLAN,COD_SERVICIOS) '; -- XO-200607171174 26.07.2006 --
     sSql := sSql || 'VALUES (' || LN_num_mov || ', ' || EN_num_abonado || ', ' || LT_numcelular || ', 1, ''GA'', ' || LT_codactcen || ', USER , ';
     sSql := sSql || 'SYSDATE, ' || LT_codcentral || ', ' || LT_numserie ||', ' || LT_tipterminal || ', ' ||Lt_actabo || ', ';
     sSql := sSql || LT_tecnologia || ', ' ||EN_plan_destino || ',' || LV_ClaseSS || ')'; -- XO-200607171174 26.07.2006 --

     INSERT INTO ICC_MOVIMIENTO (num_movimiento, num_abonado, num_celular,
     cod_estado, cod_modulo, cod_actuacion, nom_usuarora,
     fec_ingreso,cod_central, num_serie, tip_terminal,
     cod_actabo,tip_tecnologia,PLAN,cod_servicios) --XO-200607171174 26.07.2006 --
     VALUES
     (LN_num_mov, EN_num_abonado, LT_numcelular, 1, CV_codmodulo, LT_codactcen, USER ,
     SYSDATE,LT_codcentral, LT_numserie,LT_tipterminal, Lt_actabo,
     LT_tecnologia,EN_plan_destino,LV_ClaseSS); --XO-200607171174 26.07.2006 --

     END IF;

  END IF;


 END IF;

 SV_insertook :=0;



 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;


EXCEPTION
 WHEN NO_DATA_FOUND THEN
  --SV_insertook :=1;

  PV_INSERTAMOV_ATL_PR( EN_num_abonado,EN_plan_destino,
    EN_cod_cliente, EV_param, SV_insertook, SN_cod_retorno,SV_mens_retorno, SN_num_evento );

        IF (SV_insertook = 1) THEN
          SN_cod_retorno   := 4;
          SV_mens_retorno:= SQLERRM;
          LV_des_error:='PV_INSERTAMOV_ATL_PR(' || EN_num_abonado || ', ' || EN_plan_destino || ')';
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'PV_OBTIENEINFO_ATLANTIDA_PG.PV_INSERTAMOV_ATL_PR', sSql, SQLCODE, LV_des_error );
        END IF;


 WHEN OTHERS THEN
    --SV_insertook :=1;


        PV_INSERTAMOV_ATL_PR( EN_num_abonado,EN_plan_destino,
    EN_cod_cliente, EV_param, SV_insertook, SN_cod_retorno,SV_mens_retorno, SN_num_evento );

        IF (SV_insertook = 1) THEN
          SN_cod_retorno   := 4;
          SV_mens_retorno:= CV_error_no_clasif;
          LV_des_error:='PV_INSERTAMOV_ATL_PR(' || EN_num_abonado || ', ' || EN_plan_destino || ')';
          SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
      'PV_OBTIENEINFO_ATLANTIDA_PG.PV_INSERTAMOV_ATL_PR', sSql, SQLCODE, LV_des_error );
        END IF;


END PV_INSERTAMOV_ATL_PR;

------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENESERVICIO_ATL_PR(
    EN_plan_destino   IN  GA_ABOCEL.cod_plantarif%TYPE,
    SV_SERVICIO       OUT NOCOPY VARCHAR2,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENESERVICIO_ATL_PR"
      Lenguaje="PL/SQL"
      Fecha="20-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Orlando Cabezas B."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
       <Descripción></Descripción>
       <Parámetros>
         <Entrada>
    <param nom="EN_plan_destino"     Tipo="CARACTER">Plan Destino</param>
      </Entrada>
         <Salida>
     <param nom="SV_SERVICIO "           Tipo="VARCHAR2">servicio atlantida</param>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje error de negocio Retornado</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Nro de evento</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

 LT_cod_cliente   GA_ABOCEL.COD_CLIENTE%TYPE;
 LV_grupo       VARCHAR2(3);
 LV_nivel       VARCHAR2(5);
 LV_des_error         GE_ERRORES_PG.DesEvent;
 sSql                 GE_ERRORES_PG.vQuery;
 LV_ServiciosATL   VARCHAR2(50);

BEGIN
    SN_cod_retorno   := 0;
 SV_mens_retorno  := 'OK';
 SN_num_evento    := 0;

-- INI XO-200605221111 HPG--
 PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
 IF LV_ServiciosATL = '' OR LV_ServiciosATL IS NULL THEN
  SV_mens_retorno := 'Error en obtencion de Servicios Atlantida';
 END IF;

 sSql := ' SELECT to_char(A.COD_SERVSUPL,''09''),TO_CHAR(a.cod_nivel,''0009'') ';
 sSql := sSql || ' FROM   GA_SERVSUPL A ' ;
 sSql := sSql || ' WHERE A.COD_PRODUCTO = 1';
 sSql := sSql || ' AND A.COD_SERVICIO IN (SELECT B.COD_SERVICIO';
 sSql := sSql || ' FROM GAD_SERVSUP_PLAN B';
 sSql := sSql || '   WHERE B.cod_producto = 1';
 --sSql := sSql || '   AND  B.cod_plantarif = ' || EN_plan_destino ;
 -- Modificado XO-200606031122
 sSql := sSql || '   AND  B.cod_plantarif = ''' || EN_plan_destino || '''' ;
 -- Fin XO-200606031122
 sSql := sSql || '   AND   B.cod_servicio IN (' || LV_ServiciosATL || '))';
 EXECUTE IMMEDIATE Ssql INTO LV_grupo,LV_nivel;
-- FIN XO-200605221111 HPG--

    --SV_SERVICIO := '"' || TRIM(LV_grupo) || TRIM(LV_nivel) || '"';
 SV_SERVICIO := CONCAT(SV_SERVICIO,TRIM(LV_grupo));
 SV_SERVICIO := CONCAT(SV_SERVICIO,TRIM(LV_nivel));



EXCEPTION
 WHEN NO_DATA_FOUND THEN
        SV_SERVICIO :='' ;
  SV_mens_retorno:= 'NO SE ENCONTRARON SERVICIOS ATLANTIDA PARA EL PLAN';
  LV_des_error:= 'PV_OBTIENESERVICIO_ATL_PR(' || EN_plan_destino || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENESERVICIO_ATL_PR', sSql, SQLCODE, LV_des_error );

 WHEN OTHERS THEN
        SV_SERVICIO :='';
  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error:= 'PV_OBTIENESERVICIO_ATL_PR(' || EN_plan_destino || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENESERVICIO_ATL_PR', sSql, SQLCODE, LV_des_error );
END PV_OBTIENESERVICIO_ATL_PR;

---------------------------------------------------------------------------------------------------------------

PROCEDURE PV_CADENASERV_ATLANTIDA_PR(
    SV_ServAtlantida OUT NOCOPY VARCHAR2
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CADENASERV_ATLANTIDA_PR"
      Lenguaje="PL/SQL"
      Fecha="23-06-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>Devuelve string con cadena de servicios atlantida</Retorno>
       <Descripción>Devuelve 1 o N servicios anidados en un string con formato 'X1, 'X2','Xn'</Descripción>
       <Parámetros>
         <Entrada>
    <param> </param>
         </Entrada>
         <Salida>
            <param nom="SV_ServAtlantida"    Tipo="VARCHAR2">Servicios Atlantida ged_codigos</param>
            <param nom="SV_cod_retorno"   Tipo="CARACTER">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">mensaje error Retornado</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

 CURSOR C_ServAtlantida IS
     SELECT cod_valor
     FROM   GED_CODIGOS
     WHERE  cod_modulo = 'GA'
     AND  nom_tabla = 'GAD_SERVSUP_PLAN'
     AND  nom_columna = 'COD_SERVICIO';

 LI_sw         NUMBER;
 LV_CadServicios      VARCHAR2(50);
 LV_servicio    VARCHAR2(50);
BEGIN


 LI_sw := 0;
 OPEN C_ServAtlantida;
 LOOP
  FETCH C_ServAtlantida INTO LV_servicio;
  EXIT WHEN C_ServAtlantida%NOTFOUND;

   IF LI_sw < 1 THEN
    LV_CadServicios := '''' || LV_servicio || '''';
    LI_sw := 1;
   ELSE
    LV_CadServicios := LV_CadServicios || ', ''' || LV_servicio || '''';
   END IF;

 END LOOP;
 CLOSE C_ServAtlantida;
 SV_ServAtlantida := TRIM(LV_CadServicios);


EXCEPTION
 WHEN NO_DATA_FOUND THEN
   NULL;
 WHEN OTHERS THEN
   NULL;
END PV_CADENASERV_ATLANTIDA_PR;

---------------------------------------------------------------------------------------------------------------

PROCEDURE PV_ESCAMBIOPLAN_ATL_PR(
    EN_num_movimiento IN  ICC_MOVIMIENTO.num_movimiento%TYPE,
    SV_existeooss     OUT NOCOPY NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
       )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ESCAMBIOPLAN_ATL_PR"
      Lenguaje="PL/SQL"
      Fecha="23-06-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
   Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>Devuelve 1 si movimiento corresponde a un cambio de plan c/Atlantida</Retorno>
       <Descripción>Devuelve 1 si existe cambio de plan y 0 si no existe</Descripción>
       <Parámetros>
         <Entrada>
   <param nom="EN_num_movimiento"     Tipo="NUMBER">Numero de Movimiento</param>
         </Entrada>
         <Salida>
            <param nom="SV_existeooss"    Tipo="NUMBER">1: Existe OOSS 0: No existe OOSS</param>
            <param nom="SV_cod_retorno"   Tipo="CARACTER">Codigo error de negocio Retornado</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">mensaje error Retornado</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

   LI_NumOS         NUMBER;
   LV_CodOS              PV_IORSERV.COD_OS%TYPE;
   LV_des_error          GE_ERRORES_PG.DesEvent;
   sSql                  GE_ERRORES_PG.vQuery;

   LV_ServiciosATL   VARCHAR2(50);
   LN_cont_origen   NUMBER;
   LN_cont_destino   NUMBER;
   LN_po_atlantida   NUMBER;
   LN_pd_atlantida   NUMBER;
   LT_plan_origen   GA_ABOCEL.COD_PLANTARIF%TYPE;
   LT_plan_destino   GA_ABOCEL.COD_PLANTARIF%TYPE;

BEGIN

  SV_existeooss :=0;

  sSql := 'SELECT cod_plantarif INTO   LT_plan_origen FROM GA_ABOCEL';
   sSql := sSql || 'WHERE num_abonado IN (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE NUM_MOVIMIENTO = ' || EN_num_movimiento;

  -- RESCATAMOS PLAN ORIGEN --
    SELECT cod_plantarif
  INTO   LT_plan_origen
  FROM   GA_ABOCEL
  WHERE  num_abonado IN (SELECT NUM_ABONADO FROM ICC_MOVIMIENTO WHERE NUM_MOVIMIENTO = EN_num_movimiento);

  sSql := 'SELECT NUM_OS INTO LI_NumOS FROM PV_MOVIMIENTOS';
   sSql := sSql || 'WHERE  NUM_MOVIMIENTO = ' || EN_num_movimiento;

  -- RESCATAMOS OOSS ASOCIADA --
  SELECT NUM_OS
  INTO   LI_NumOS
  FROM   PV_MOVIMIENTOS
  WHERE  NUM_MOVIMIENTO = EN_num_movimiento;

  sSql := 'SELECT COD_OS INTO LV_CodOS FROM PV_IORSERV';
   sSql := sSql || 'WHERE  NUM_OS = ' || LI_NumOS;

  -- RESCATAMOS QUE ORDEN DE SERVICIO ASOCIADA TIENE EL MOVIMIENTO --
  SELECT COD_OS
  INTO   LV_CodOS
  FROM   PV_IORSERV
  WHERE  NUM_OS= LI_NumOS;

  sSql := 'SELECT cod_plantarif INTO   LT_plan_destino FROM PV_PARAM_ABOCEL';
   sSql := sSql || 'WHERE  NUM_OS = ' || LI_NumOS;

  -- RESCATAMOS PLAN DESTINO--
  --SELECT cod_plantarif 	  	  	  	 		  --COL-71929|17-10-2008|GEZ
  SELECT NVL(cod_plantarif_nue,cod_plantarif) 	  --COL-71929|17-10-2008|GEZ
  INTO   LT_plan_destino
  FROM   pv_param_abocel
  WHERE  num_os = LI_NumOS;

  IF LV_CodOS = CV_cp_ind OR LV_CodOS = CV_cp_fam OR LV_CodOS = CV_cp_emp THEN

  -- SE GENERO SS POR CAMBIO DE PLAN
  -- Se verifica si es ATL-ATL

  PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
  IF LV_ServiciosATL = '' OR LV_ServiciosATL IS NULL THEN
   SV_mens_retorno := 'Error en obtencion de Servicios Atlantida';
  END IF;

  sSql := 'SELECT COUNT(1) FROM   GA_SERVSUPL A ';
  sSql := sSql || ' WHERE  A.cod_servicio IN (SELECT cod_servicio ';
  sSql := sSql || ' FROM   GAD_SERVSUP_PLAN ';
  sSql := sSql || ' WHERE  cod_plantarif = ''' || LT_plan_origen || '''';
  sSql := sSql || ' AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA)' ;
  sSql := sSql || ' AND   A.cod_servicio IN (' || LV_ServiciosATL || ')';
  EXECUTE IMMEDIATE sSql INTO LN_cont_origen;

  IF LN_cont_origen > 0 THEN
     LN_po_atlantida := 1;
  ELSE
     LN_po_atlantida := 0;
  END IF;

  sSql := 'SELECT COUNT(1) FROM   GA_SERVSUPL A ';
  sSql := sSql || ' WHERE  A.cod_servicio IN (SELECT cod_servicio ';
  sSql := sSql || ' FROM   GAD_SERVSUP_PLAN ';
  sSql := sSql || ' WHERE  cod_plantarif = ''' || LT_plan_destino || '''';
  sSql := sSql || ' AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA)' ;
  sSql := sSql || ' AND   A.cod_servicio IN (' || LV_ServiciosATL || ')';
  EXECUTE IMMEDIATE sSql INTO LN_cont_destino;

  IF LN_cont_destino > 0 THEN
     LN_pd_atlantida := 1;
  ELSE
     LN_pd_atlantida := 0;
  END IF;

  IF LN_po_atlantida = 1 AND LN_pd_atlantida = 1 THEN
     -- ES CAMBIO DE PLAN DE ATLANTIDA A ATLANTIDA --
     SV_existeooss :=1;
  END IF;

  END IF;


EXCEPTION
 WHEN NO_DATA_FOUND THEN
  SV_existeooss :=0;
  SV_mens_retorno:= SQLERRM;
  LV_des_error:='PV_ESCAMBIOPLAN_ATL_PR(' || EN_num_movimiento || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_ESCAMBIOPLAN_ATL_PR', sSql, SQLCODE, LV_des_error );

 WHEN OTHERS THEN
  SV_existeooss :=0;

  SV_mens_retorno:= CV_error_no_clasif;
  LV_des_error:='PV_ESCAMBIOPLAN_ATL_PR(' || EN_num_movimiento || ')';
  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
    'PV_OBTIENEINFO_ATLANTIDA_PG.PV_ESCAMBIOPLAN_ATL_PR', sSql, SQLCODE, LV_des_error );

END PV_ESCAMBIOPLAN_ATL_PR;
-------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_INS_MOV_BAJATL_PR (
                                                                EN_num_movimiento  IN icc_movimiento.NUM_MOVIMIENTO%TYPE,
                                                                EV_cod_modulo      IN icc_movimiento.COD_MODULO%TYPE,
                                                                EV_cod_cliente     IN icc_movimiento.NUM_CELULAR_NUE%TYPE,
                                                                EV_atlantida       IN icc_movimiento.PARAM1_MENS%TYPE,
                                                                EV_codplantarif    IN icc_movimiento.PLAN%TYPE,
                                                                EV_cod_tecnologia  IN icc_movimiento.TIP_TECNOLOGIA%TYPE,
                                                                EV_error           IN OUT NOCOPY VARCHAR2 )
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_ins_mov_bajatl_PR"
    Lenguaje="PL/SQL"
    Fecha="27-02-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos C"
    Programador="Yury alvarez T."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que permite insertar movimiento de baja cliente atlantida>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/


IS

sSql                 ge_errores_pg.vQuery;

/*variable recuperada desde GA_PARAMETROS_SIMPLES_VW  */
LV_cod_actabo           ga_actabo.cod_actabo%TYPE;

LN_cod_tiplan           ta_plantarif.cod_tiplan%TYPE;

LV_atlantida        ga_parametros_simples_vw.valor_texto%TYPE;

/*Variable que se rescata de la función FN_CODACTCEN */
LN_cod_actuacion        icc_movimiento.cod_actuacion%TYPE;

/*Variable que rescata de parametros si va la tecnologia o no */
LV_tecnologia       ged_parametros.val_parametro%TYPE;

/*Variable que en que dejamo la tecnologia o el valor del parametro */
LV_tecno_final      ged_parametros.val_parametro%TYPE;

/* Constante para recuper el codigo de actuación*/
CV_param_codactabo      CONSTANT  VARCHAR2(20) := 'BAJA_CLIE_ATLANTIDA'; --de aqui saco el codigo de actuacion...

/*variable recuperada desde GA_abocel a traves del Cliente */
LN_cod_central          ga_abocel.cod_central%TYPE;
LN_num_celular          ga_abocel.num_celular%TYPE;
LV_num_serie        ga_abocel.num_serie%TYPE;



CN_carga                        CONSTANT  NUMBER(1) := 0;

CN_si                           CONSTANT  VARCHAR2(1) := '1';
CN_no                           CONSTANT  VARCHAR2(1) := '0';

CV_aplica_atlan     CONSTANT  ga_parametros_simples_vw.nom_parametro%TYPE :='APLICA_ATLANTIDA';
CV_tecnologia       CONSTANT  ged_parametros.nom_parametro%TYPE :='NO_TECNOLOGIA';
CV_central_default  CONSTANT  ged_parametros.nom_parametro%TYPE :='CENTRAL_DEFAULT';

/*Constantes de Errores */
CN_C0                           CONSTANT NUMBER := 0;
CN_C4                           CONSTANT NUMBER := 4;
CN_20010            CONSTANT NUMBER := -20010;
CN_20011                        CONSTANT NUMBER := -20011;

/*Variables de control de errores*/
fin_ejecucion_error             EXCEPTION;
fin_ejecucion                   EXCEPTION;
err_ins_iccmov                  EXCEPTION;
LV_v_verror                     VARCHAR2(255);


/*Variable que se llena consultando una secuencia para el control de errores */
LN_p_correlativo        icc_movimiento.num_movimiento%TYPE;

/*Variables que controlan la respuesta de errores en ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR */
LN_p_filasafectas       NUMBER;
LN_p_retornora          NUMBER;
LN_p_nroevento          NUMBER;
LV_p_vcod_retorno       VARCHAR2(10);
ln_atlantatida          NUMBER;
ln_existe               NUMBER;
LV_COD_PLANTARIF        GA_INTARCEL.COD_PLANTARIF%TYPE;
LV_FEC_HASTA            GA_INTARCEL.FEC_HASTA%TYPE;

BEGIN



         IF NVL(trim(EV_error),CN_C0) = CN_C4 THEN
            RAISE fin_ejecucion_error;
         END IF;

         EV_error := '0';
         LV_v_verror := 'Proceso Exitoso';

         SELECT VALOR_TEXTO
         INTO   LV_atlantida
         FROM   GA_PARAMETROS_SIMPLES_VW
         WHERE  NOM_PARAMETRO = CV_aplica_atlan
         AND    COD_MODULO    = CV_codmodulo;

         IF LV_atlantida = 'FALSE' THEN
             RAISE fin_ejecucion;
         END IF;

         IF EV_atlantida = CN_no THEN
                RAISE fin_ejecucion;
         END IF;

        ln_existe:=0;

        BEGIN

        SELECT COUNT(1) INTO ln_existe
        FROM ga_abocel a
        WHERE  a.cod_cliente = EV_COD_CLIENTE
        AND cod_situacion NOT IN ('BAA','BAP', 'TAP' );

        EXCEPTION
                   WHEN  NO_DATA_FOUND THEN
            ln_existe:=0;
        END;


        SELECT  MAX(FEC_HASTA)
        INTO LV_FEC_HASTA FROM GA_INTARCEL
        WHERE COD_CLIENTE  = EV_cod_cliente;

        SELECT  COD_PLANTARIF
        INTO LV_COD_PLANTARIF FROM GA_INTARCEL
        WHERE COD_CLIENTE  = EV_cod_cliente
        AND FEC_HASTA =LV_FEC_HASTA
        AND ROWNUM=1;


        ln_atlantatida:=0;

        SELECT COUNT(1) INTO ln_atlantatida FROM gad_servsup_plan b
        WHERE b.cod_plantarif = LV_COD_PLANTARIF
        AND cod_servicio IN  (SELECT c.COD_VALOR
                              FROM   ged_codigos c
                              WHERE  cod_modulo = 'GA'
                              AND  nom_tabla = 'GAD_SERVSUP_PLAN'
                              AND  nom_columna = 'COD_SERVICIO');


         IF (ln_atlantatida> 0 AND  ln_existe= 0) THEN
               NULL;
         ELSE
               RAISE fin_ejecucion;
         END IF;


         /*
         IF PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(EV_cod_cliente) = CN_cliente_es_atl  THEN -- aqui se pregunta si sigue siendo atlantida.
           RAISE fin_ejecucion;
         END IF;
         */
         BEGIN
                 SELECT cod_central,num_celular,num_serie
                 INTO   LN_cod_central,LN_num_celular,LV_num_serie
                    FROM   GA_ABOCEL
                    WHERE  cod_cliente = EV_cod_cliente
                 AND    ROWNUM = 1;
         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                          --Cuando el total de abonados del cliente fueron traspasados
                                   LN_cod_central := 0;
                                   LN_num_celular := 0;
                                   LV_num_serie := '0';
         END;


 SELECT cod_tiplan
 INTO   LN_cod_tiplan
 FROM   TA_PLANTARIF
 WHERE  cod_plantarif = EV_codplantarif;


 SELECT a.valor_texto
 INTO   LV_cod_actabo
 FROM   GA_PARAMETROS_SIMPLES_VW a
 WHERE  a.nom_parametro  = CV_param_codactabo;
 --AND    A. cod_operadora = ge_fn_operadora_scl();


 SELECT VAL_PARAMETRO
 INTO   LV_tecnologia
 FROM   GED_PARAMETROS
 WHERE  NOM_PARAMETRO = CV_tecnologia
 AND    COD_MODULO    = CV_codmodulo_venta;


 -- Se consulta por la tecnologia si es vacia asignamos lo que viene por parametro --
 IF EV_cod_tecnologia IS NULL THEN
    LV_tecno_final := LV_tecnologia;
          ELSE
             LV_tecno_final := EV_cod_tecnologia;
 END IF;

 BEGIN

  SELECT cod_actabo
  INTO   LV_cod_actabo
  FROM   PV_ACTABO_TIPLAN
  WHERE  cod_tipmodi = LV_cod_actabo
  AND    cod_tiplan  = LN_cod_tiplan;


 EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                           NULL;
 END;

 IF LN_cod_central = 0 THEN

         SELECT VALOR_NUMERICO
         INTO   LN_cod_central
         FROM   GA_PARAMETROS_SIMPLES_VW
         WHERE  NOM_PARAMETRO = CV_central_default
         AND    COD_MODULO    = CV_codmodulo;

         IF LN_cod_central IS NULL THEN
                  RAISE fin_ejecucion_error;
         END IF;

 END IF;

LN_cod_actuacion := FN_CODACTCEN(CN_producto,LV_cod_actabo,CV_codmodulo,LV_tecno_final);

IF LN_cod_actuacion IS NULL THEN
         RAISE fin_ejecucion_error;
END IF;

LV_p_vcod_retorno := CN_C4;

   ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(
          NULL,                            -- NUM_MOVIMIENTO -
          0,                       -- NUM_ABONADO -
          1,                       -- COD_ESTADO - default 1.
          LV_cod_actabo,           -- COD_ACTABO -
          'GA',                    -- COD_MODULO -
          0,                                       -- NUM_INTENTOS -
          NULL,                    -- COD_CENTRAL_NUE -
          'PENDIENTE',                     -- DES_RESPUESTA - default 'pendiente'
          LN_cod_actuacion,        -- COD_ACTUACION -
          USER,                                    -- NOM_USUARIO -
          SYSDATE,                 -- FEC_INGRESO -
          'G',                     -- TIP_TERMINAL -
          LN_cod_central,          -- COD_CENTRAL -
          NULL,                                    -- FECHA_LECTURA -
          0,                                   -- IND_BLOQUEO -
          NULL,                                    -- FECHA_EJECUCION -
          NULL,                                    -- TIP_TERMINAL_NUE -
          NULL,                    -- NUM_MOVENT -
          LN_num_celular,          -- NUM_CELULAR -
          NULL,                    -- NUM_MOVPOS -
          LV_num_serie,            -- NUM_SERIE -
          NULL,                    -- NUM_PERSONAL -
          EV_cod_cliente,          -- NUM_CELULAR_NUE -  AQUI ENVIAMOS AL CLIENTE.
          NULL,                                    -- NUM_SERIE_NUE -
          NULL,                                    -- NUM_PERSONAL_NUE -
          NULL,                                    -- NUM_MSNB -
          NULL,                                    -- NUM_MSNB_NUE -
          NULL,                                    -- COD_SUSPREHA -
          NULL,                    -- COD_SERVICIOS -
                  NULL,                                    -- NUM_MIN -
          NULL,                                    -- NUM_MIN_NUE .
          NULL,                                    -- STA -
          NULL,                                    -- COD_MENSAJE -
          NULL,                                    -- PARAM1_MENS -  AQUI SE ENVIA MARCA SI ES ATLANTIDA = 1 Y NO = 0 -
          NULL,                                    -- PARAM2_MENS -
          NULL,                                    -- PARAM3_MENS -
         NULL,                                     -- PLAN -
          CN_carga,                                -- CARGA -
          NULL,                                    -- VALOR_PLAN -
          NULL,                                    -- PIN -
          NULL,                                    -- FEC_EXPIRA -
          NULL,                                    -- DES_MENSAJE -
          NULL,                                    -- COD_PIN,
          NULL,                                    -- COD_IDIOMA -
          NULL,                                    -- COD_ENRUTAMIENTO -
          NULL,                                    -- TIP_ENRUTAMIENTO -
          NULL,                                    -- DES_ORIGEN_PIN -
          NULL,                                    -- NUM_LOTE_PIN -
          NULL,                                    -- NUM_SERIE_PIN -
          EV_cod_tecnologia,       -- TIP_TECNOLOGIA -
          NULL,                                    -- IMSI -
          NULL,                                    -- IMSI_NUE -
          NULL,                            -- IMEI -
          NULL,                                    -- IMEI_NUE -
          NULL,                            -- ICC -
          NULL,                                    -- ICC_NUE -
          'PV',                                    -- COD_PROGRAMA -
         LN_p_correlativo,
                  LN_p_filasafectas,
                  LN_p_retornora,
                  LN_p_nroevento,
                  LV_p_vcod_retorno
          );


        IF LV_p_vcod_retorno = CN_C0 THEN
                    EV_error := '0';
                        LV_v_verror := 'Proceso Exitoso';
                        PV_ins_err_transaccion_PR(EN_num_movimiento,0,LV_v_verror);
        ELSE
                RAISE err_ins_iccmov;
        END IF;

EXCEPTION
                 WHEN fin_ejecucion THEN
                          EV_error := '0';
                          LV_v_verror := 'Proceso Exitoso';
                          PV_ins_err_transaccion_PR(EN_num_movimiento,0,LV_v_verror);
                 WHEN fin_ejecucion_error THEN
                          EV_error := '2';
                          LV_v_verror := 'Error faltan parametros';
                          PV_ins_err_transaccion_PR(EN_num_movimiento,2,LV_v_verror);
                 WHEN err_ins_iccmov THEN
                      EV_error := '3';
                          LV_v_verror := 'Error en inserción en la tabla ICC_MOVIMIENTO. N° evento es ' || LN_p_nroevento || '.';
                          PV_ins_err_transaccion_PR(EN_num_movimiento,3,LV_v_verror);
                          RAISE_APPLICATION_ERROR(CN_20011,LV_v_verror);
                 WHEN OTHERS THEN
                      EV_error := '4';
                          LV_v_verror := SUBSTR(SQLERRM,1,255);
                          PV_ins_err_transaccion_PR(EN_num_movimiento,4,LV_v_verror);
                          RAISE_APPLICATION_ERROR(CN_20010, LV_v_verror );

END PV_INS_MOV_BAJATL_PR;

-------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_INS_MOV_CAMNOMCL_PR (
                                                                  EN_num_movimiento  IN icc_movimiento.NUM_MOVIMIENTO%TYPE,
                                                                  EV_cod_modulo      IN icc_movimiento.COD_MODULO%TYPE,
                                                                  EV_cod_cliente     IN icc_movimiento.NUM_CELULAR_NUE%TYPE,
                                                                  EV_error           IN OUT NOCOPY VARCHAR2 )
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_ins_mov_camnomcl_PR"
    Lenguaje="PL/SQL"
    Fecha="27-02-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos C"
    Programador="Yury alvarez T."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que permite insertar movimiento de Cambio de nombrec cliente atlantida>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/


IS

sSql                 ge_errores_pg.vQuery;

/*variable recuperada desde GA_PARAMETROS_SIMPLES_VW  */
LV_cod_actabo           ga_actabo.cod_actabo%TYPE;

LN_cod_tiplan           ta_plantarif.cod_tiplan%TYPE;

LV_atlantida        ga_parametros_simples_vw.valor_texto%TYPE;

/*variable recuperada desde GA_abocel a traves del Cliente */
LV_codplantarif     ga_abocel.cod_plantarif%TYPE;
LN_cod_central          ga_abocel.cod_central%TYPE;
LN_num_celular          ga_abocel.num_celular%TYPE;
LV_num_serie        ga_abocel.num_serie%TYPE;
LV_cod_tecnologia   ga_abocel.cod_tecnologia%TYPE:= '';


/*Variable que se rescata de la función FN_CODACTCEN */
LN_cod_actuacion        icc_movimiento.cod_actuacion%TYPE;

/*Variable que rescata de parametros si va la tecnologia o no */
LV_tecnologia       ged_parametros.val_parametro%TYPE;

/*Variable que en que dejamo la tecnologia o el valor del parametro */
LV_tecno_final      ged_parametros.val_parametro%TYPE;

/* Constante para recuper el codigo de actuación*/
CV_param_codactabo      CONSTANT  VARCHAR2(16) := 'ACTABO_CAMNOMATL';


CN_carga                        CONSTANT  NUMBER(1) := 0;


CV_aplica_atlan     CONSTANT  ga_parametros_simples_vw.nom_parametro%TYPE :='APLICA_ATLANTIDA';
CV_tecnologia       CONSTANT  ged_parametros.nom_parametro%TYPE :='NO_TECNOLOGIA';

/*Constantes de Errores */
CN_C0                           CONSTANT NUMBER := 0;
CN_C4                           CONSTANT NUMBER := 4;
CN_20010            CONSTANT NUMBER := -20010;
CN_20011                        CONSTANT NUMBER := -20011;

/*Variables de control de errores*/
fin_ejecucion                   EXCEPTION;
fin_ejecucion_error             EXCEPTION;
err_ins_iccmov                  EXCEPTION;
LV_v_verror                     VARCHAR2(255);


/*Variable que se llena consultando una secuencia para el control de errores */
LN_p_correlativo        icc_movimiento.num_movimiento%TYPE;

/*Variables que controlan la respuesta de errores en ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR */
LN_p_filasafectas       NUMBER;
LN_p_retornora          NUMBER;
LN_p_nroevento          NUMBER;
LV_p_vcod_retorno       VARCHAR2(10);

BEGIN


         IF NVL(trim(EV_error),CN_C0) = CN_C4 THEN
            RAISE fin_ejecucion_error;
         END IF;

         EV_error := '0';
         LV_v_verror := 'Proceso Exitoso';

         SELECT VALOR_TEXTO
         INTO   LV_atlantida
         FROM   GA_PARAMETROS_SIMPLES_VW
     WHERE  NOM_PARAMETRO = CV_aplica_atlan
     AND    COD_MODULO    = CV_codmodulo;

         IF LV_atlantida = 'FALSE' THEN
             RAISE fin_ejecucion;
         END IF;

        IF NOT PV_OBTIENEINFO_ATLANTIDA_PG.PV_CLIENTEESATLANTIDA_FN(EV_cod_cliente) = CN_cliente_es_atl  THEN -- aqui se pregunta si sigue siendo atlantida.
           RAISE fin_ejecucion;
        END IF;

         SELECT cod_plantarif,cod_central,num_celular,num_serie
         INTO   LV_codplantarif,LN_cod_central,LN_num_celular,LV_num_serie
     FROM   GA_ABOCEL
     WHERE  cod_cliente = EV_cod_cliente
         AND    ROWNUM = 1;

         SELECT cod_tiplan
         INTO   LN_cod_tiplan
     FROM   TA_PLANTARIF
     WHERE  cod_plantarif = LV_codplantarif;

         SELECT a.valor_texto
         INTO   LV_cod_actabo
         FROM   GA_PARAMETROS_SIMPLES_VW a
         WHERE  a.nom_parametro  = CV_param_codactabo;
         --AND    A. cod_operadora = ge_fn_operadora_scl();

         SELECT VAL_PARAMETRO
         INTO   LV_tecnologia
         FROM   GED_PARAMETROS
         WHERE  NOM_PARAMETRO = CV_tecnologia
         AND    COD_MODULO    = CV_codmodulo_venta;


         -- Se consulta por la tecnologia si es vacia asignamos lo que viene por parametro --
         LV_tecno_final := LV_tecnologia;

         BEGIN
                 SELECT cod_actabo
                 INTO   LV_cod_actabo
                 FROM   PV_ACTABO_TIPLAN
                 WHERE  cod_tipmodi = LV_cod_actabo
                 AND    cod_tiplan  = LN_cod_tiplan;

         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   NULL;
         END;


        LN_cod_actuacion := FN_CODACTCEN(CN_producto,LV_cod_actabo,CV_codmodulo,LV_tecno_final);

        IF LN_cod_actuacion IS NULL THEN
          RAISE fin_ejecucion_error;
        END IF;

        LV_p_vcod_retorno := CN_C4;
    ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(
                  NULL,                            -- NUM_MOVIMIENTO -
                  0,                       -- NUM_ABONADO -
                  1,                       -- COD_ESTADO - default 1.
                  LV_cod_actabo,           -- COD_ACTABO -
                  'GA',                    -- COD_MODULO -
                  0,                                       -- NUM_INTENTOS -
                  NULL,                    -- COD_CENTRAL_NUE -
                  'PENDIENTE',                     -- DES_RESPUESTA - default 'pendiente'
                  LN_cod_actuacion,        -- COD_ACTUACION -
                  USER,                                    -- NOM_USUARIO -
                  SYSDATE,                 -- FEC_INGRESO -
                  'G',                     -- TIP_TERMINAL -
                  LN_cod_central,          -- COD_CENTRAL -
                  NULL,                                    -- FECHA_LECTURA -
                  0,                                   -- IND_BLOQUEO -
                  NULL,                                    -- FECHA_EJECUCION -
                  NULL,                                    -- TIP_TERMINAL_NUE -
                  NULL,                    -- NUM_MOVENT -
                  LN_num_celular,          -- NUM_CELULAR -
                  NULL,                    -- NUM_MOVPOS -
                  LV_num_serie,            -- NUM_SERIE -
                  NULL,                    -- NUM_PERSONAL -
                  EV_cod_cliente,          -- NUM_CELULAR_NUE -  AQUI ENVIAMOS AL CLIENTE.
                  NULL,                                    -- NUM_SERIE_NUE -
                  NULL,                                    -- NUM_PERSONAL_NUE -
                  NULL,                                    -- NUM_MSNB -
                  NULL,                                    -- NUM_MSNB_NUE -
                  NULL,                                    -- COD_SUSPREHA -
                  NULL,                    -- COD_SERVICIOS -
                  NULL,                                    -- NUM_MIN -
                  NULL,                                    -- NUM_MIN_NUE .
                  NULL,                                    -- STA -
                  NULL,                                    -- COD_MENSAJE -
                  NULL,                                    -- PARAM1_MENS -
                  NULL,                                    -- PARAM2_MENS -
                  NULL,                                    -- PARAM3_MENS -
          NULL,                                    -- PLAN -
                  CN_carga,                                -- CARGA -
                  NULL,                                    -- VALOR_PLAN -
                  NULL,                                    -- PIN -
                  NULL,                                    -- FEC_EXPIRA -
                  NULL,                                    -- DES_MENSAJE -
                  NULL,                                    -- COD_PIN,
                  NULL,                                    -- COD_IDIOMA -
                  NULL,                                    -- COD_ENRUTAMIENTO -
                  NULL,                                    -- TIP_ENRUTAMIENTO -
                  NULL,                                    -- DES_ORIGEN_PIN -
                  NULL,                                    -- NUM_LOTE_PIN -
                  NULL,                                    -- NUM_SERIE_PIN -
                  'NOTECNO',               -- TIP_TECNOLOGIA -
                  NULL,                                    -- IMSI -
                  NULL,                                    -- IMSI_NUE -
                  NULL,                            -- IMEI -
                  NULL,                                    -- IMEI_NUE -
                  NULL,                            -- ICC -
                  NULL,                                    -- ICC_NUE -
                  'PV',                                    -- COD_PROGRAMA -
          LN_p_correlativo,
                  LN_p_filasafectas,
                  LN_p_retornora,
                  LN_p_nroevento,
                  LV_p_vcod_retorno
                  );


                IF LV_p_vcod_retorno = CN_C0 THEN
                            EV_error := '0';
                                LV_v_verror := 'Proceso Exitoso';
                                PV_ins_err_transaccion_PR(EN_num_movimiento,0,LV_v_verror);
                ELSE
                        RAISE err_ins_iccmov;
                END IF;

EXCEPTION
                 WHEN fin_ejecucion THEN
                          EV_error := '0';
                          LV_v_verror := 'Proceso Exitoso';
                          PV_ins_err_transaccion_PR(EN_num_movimiento,0,LV_v_verror);
                 WHEN fin_ejecucion_error THEN
                          EV_error := '4';
                          LV_v_verror := 'Error faltan parametros';
                          PV_ins_err_transaccion_PR(EN_num_movimiento,4,LV_v_verror);
                 WHEN err_ins_iccmov THEN
                      EV_error := '4';
                          LV_v_verror := 'Error en inserción en la tabla ICC_MOVIMIENTO. N° evento es ' || LN_p_nroevento || '.';
                          PV_ins_err_transaccion_PR(EN_num_movimiento,4,LV_v_verror);
                          RAISE_APPLICATION_ERROR(CN_20011,LV_v_verror);
                 WHEN OTHERS THEN
                      EV_error := '4';
                          LV_v_verror := SUBSTR(SQLERRM,1,255);

                          PV_ins_err_transaccion_PR(EN_num_movimiento,4,LV_v_verror);

                          --RAISE_APPLICATION_ERROR(CN_20010, LV_v_verror);

END PV_INS_MOV_CAMNOMCL_PR ;

PROCEDURE PV_ins_mov_atlan_PR(
                                                                                                                EN_num_abonado  IN icc_movimiento.num_abonado%TYPE,
                                                                                                                EV_cod_actabo   IN icc_movimiento.cod_actabo%TYPE,
                                                                                                                EN_carga                IN icc_movimiento.carga%TYPE,
                                                                                                                EV_num_os               IN icc_movimiento.cod_pin%TYPE,
                                                                                                         SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                                                                                         SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                                                                                         SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento)
/*
<Documentación
TipoDoc = "Procedure">
 <Elemento
    Nombre = "PV_ins_mov_central_atlan_PR"
    Lenguaje="PL/SQL"
    Fecha="27-02-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos C"
    Programador="Yury alvarez T."
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package que permite insertar movimiento de central para
                                 Limite de consumo>
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/


IS

/*variable recuperada desde GA_PARAMETROS_SIMPLES_VW  */
LV_cod_actabo           ga_actabo.cod_actabo%TYPE;


LV_cod_modulo       ga_actabo.cod_modulo%TYPE:='GA';
LN_cod_tiplan           ta_plantarif.cod_tiplan%TYPE;


/*Variables desde la tabla GA_ABOCEL */
LN_num_celular          ga_abocel.num_celular%TYPE;
LN_cod_central          ga_abocel.cod_central%TYPE;
LV_num_serie            icc_movimiento.num_serie%TYPE;
LV_tip_terminal         ga_abocel.tip_terminal%TYPE;
LV_cod_tecnologia       ga_abocel.cod_tecnologia%TYPE;
LV_num_seriehex     ga_abocel.num_serie%TYPE;
LV_num_imei                     ga_abocel.num_imei%TYPE;
LN_cod_producto         ga_abocel.cod_producto%TYPE;
LV_codplantarif     ga_abocel.cod_plantarif%TYPE;
LN_cod_actuacion        icc_movimiento.cod_actuacion%TYPE; /*Variable que se rescata de la función FN_CODACTCEN */
LV_imsi                         icc_movimiento.imsi%TYPE:=NULL;
LV_imei                         icc_movimiento.imei%TYPE:=NULL;
LV_icc                          icc_movimiento.icc%TYPE:=NULL;
LN_cod_cliente          ga_abocel.cod_cliente%TYPE;

/*Variable que se llena consultando una secuencia */
LN_p_correlativo        icc_movimiento.num_movimiento%TYPE;

/*Constantes de Errores */
CN_20010            CONSTANT NUMBER := -20010;
CN_C0                           CONSTANT NUMBER := 0;
CN_C4                           CONSTANT NUMBER := 4;
CN_20011                        CONSTANT NUMBER := -20011;

/*Variables e control de errores*/
err_ins_iccmov          EXCEPTION;
LV_v_verror                     VARCHAR2(255);

/*Variables que contienen la respuesta de ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR */
LN_p_filasafectas       NUMBER;
LN_p_retornora          NUMBER;
LN_p_nroevento          NUMBER;
LV_p_vcod_retorno       VARCHAR2(10);

CN_cod_estado           CONSTANT NUMBER(1) := 1;
CN_num_intentos         CONSTANT NUMBER(1) := 0;
CN_ind_bloqueo          CONSTANT NUMBER(1) := 0;
LV_des_error            VARCHAR2(255);

BEGIN


         SELECT num_celular
               ,cod_central
                   ,num_serie
                   ,tip_terminal
                   ,cod_tecnologia
                   ,num_serie
                   ,num_imei
                   ,cod_producto
                   ,cod_plantarif
                   ,cod_cliente
         INTO   LN_num_celular
               ,LN_cod_central
                   ,LV_num_seriehex
                   ,LV_tip_terminal
                   ,LV_cod_tecnologia
                   ,LV_num_serie
                   ,LV_num_imei
                   ,LN_cod_producto
                   ,LV_codplantarif
                   ,LN_cod_cliente
         FROM   GA_ABOCEL
         WHERE  num_abonado = EN_num_abonado;

         SELECT cod_tiplan INTO LN_cod_tiplan
     FROM   TA_PLANTARIF
     WHERE  cod_plantarif = LV_codplantarif;


         BEGIN


                 SELECT cod_actabo
                 INTO   LV_cod_actabo
                 FROM   PV_ACTABO_TIPLAN
                 WHERE  cod_tipmodi = EV_cod_actabo
                 AND    cod_tiplan  = LN_cod_tiplan;

         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   LV_cod_actabo := EV_cod_actabo ;
         END;

        LN_cod_actuacion := FN_CODACTCEN(LN_cod_producto,LV_cod_actabo,LV_cod_modulo,LV_cod_tecnologia);

        LV_p_vcod_retorno := CN_C4;


    ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(NULL,
                  EN_num_abonado,    --GA_ABOCEL
                  CN_cod_estado,
                  LV_cod_actabo,
                  LV_cod_modulo,
                  CN_num_intentos,                                       --num_intentos
                  NULL,
                  'PENDIENTE',                                           --des_respuesta
                  LN_cod_actuacion,
                  USER,
                  SYSDATE,
                  LV_tip_terminal,   --GA_ABOCEL
                  LN_cod_central,    --GA_ABOCEL
                  NULL,
                  CN_ind_bloqueo,                                        --ind_bloqueo
                  NULL,
                  NULL,
                  NULL,
                  LN_num_celular,    --GA_ABOCEL
                  NULL,
                  LV_num_seriehex,   --GA_ABOCEL
                  NULL,
                  LN_cod_cliente,-- num_celular_nue
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
          NULL,
                  EN_carga,                                                      --CARGA.
                  NULL,
                  NULL,
                  NULL,
                  NULL,                                                          --des_mensaje,
                  NULL,                                                          --cod_pin,
                  NULL,                                                          --cod_idioma,
                  NULL,                                                  --cod_enrutamiento,
                  NULL,                                                          --tip_enrutamiento,
                  NULL,                                                          --des_origen_pin,
                  NULL,                                                          --num_lote_pin,
                  NULL,                                                          --num_serie_pin,
                  LV_cod_tecnologia,   --GA_ABOCEL   --tip_tecnologia,
                  LV_imsi,                 -- NULL               --imsi,
                  NULL,                                                          --imsi_nue,
                  LV_imei,                         -- NULL               --imei,
                  NULL,                                                          --imei_nue,
                  LV_icc,                          -- NULL               --icc,
                  NULL,                                                          --icc_nue.
                  'PV',                                                          --Cod_programa.
          LN_p_correlativo,
                  LN_p_filasafectas,
                  LN_p_retornora,
                  LN_p_nroevento,
                  LV_p_vcod_retorno
                  );


                --Para movimiento  I4 ---
                IF TRIM(EV_num_os) IS NOT NULL THEN
                        UPDATE pv_movimientos
                        SET num_movimiento = LN_p_correlativo
                        WHERE num_os = TO_NUMBER(EV_num_os);
                END IF;

                IF LV_p_vcod_retorno = CN_C0 THEN
                 SN_cod_retorno := 0;
                 SV_mens_retorno := 'OK';
                ELSE
                        RAISE err_ins_iccmov;
                END IF;


EXCEPTION
                 WHEN err_ins_iccmov THEN
                 SN_cod_retorno := 3;
                 SV_mens_retorno := 'Error en inserción en la tabla ICC_MOVIMIENTO.';
                         SN_num_evento:= 0;
                 WHEN OTHERS THEN
                 SN_cod_retorno := 4;
                 SV_mens_retorno := 'Error no controlado.';
                         LV_des_error := SUBSTR(SQLERRM,1,255);
                         SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                                                                        'GA',SV_mens_retorno, '1.0', USER,
                                                                                                        'PV_OBTIENEINFO_ATLANTIDA_PG.PV_ins_mov_atlan_PR',
                                                                                                        NULL, SQLCODE, LV_des_error );
END PV_ins_mov_atlan_PR;

END PV_OBTIENEINFO_ATLANTIDA_PG;
/
SHOW ERRORS
