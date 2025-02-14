CREATE OR REPLACE PACKAGE BODY Pv_restriccion_pg AS

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALPLANSERTEC_WEB_PR(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
IS

/*
<Documentaci—n
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "PV_VALPLANSERTEC_WEB_PR"
    Lenguaje="PL/SQL"
    Fecha="20-08-2008"
    Versi—n="1.0"
    Dise™ador="Orlando Cabezas"
    Programador="Orlando Cabezas"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripci—n> Validacion de tecnologia por plan</Descripci—n>
    <Parømetros>
       <Entrada>
       <param nom="LV_param_entrada" Tipo="VARCHAR">Cadena con parømetros de entrada</param>
       </Entrada>
       <Salida>
       <param nom="LV_resultado" Tipo="VARCHAR">Resultado de la validaci—n</param>
       <param nom="LV_mensaje" Tipo="VARCHAR">mensaje de error en caso de aplicar la restricci—n</param>
       </Salida>
    </Parømetros>
 </Elemento>
</Documentaci—n>
*/

STRING SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

EV_COD_TECNOLOGIA     VARCHAR2(7);
EV_COD_PLANTARIF      VARCHAR2(3);
EV_COD_PLANTARIF_AUX  VARCHAR2(3);
EV_NABONADO           VARCHAR2(8);
EV_CODPLANSERV        VARCHAR2(3);-- 71896/20-10-2008/EFR
LN_CANTIDAD_AUX       NUMBER(3);

BEGIN
   GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_PARAM_ENTRADA, STRING);

   EV_NABONADO       := TO_NUMBER(STRING(5));
   EV_COD_PLANTARIF  := STRING(12); -- PLAN NUEVO
   LN_CANTIDAD_AUX   := 0;
   SV_RESULTADO      := 'TRUE';


   SELECT COD_TECNOLOGIA
   INTO   EV_COD_TECNOLOGIA
   FROM   GA_ABOCEL
   WHERE  NUM_ABONADO = EV_NABONADO;

   /*
   SELECT COD_TECNOLOGIA, COD_PLANSERV
   INTO   EV_COD_TECNOLOGIA, EV_CODPLANSERV
   FROM   GA_ABOCEL
   WHERE  NUM_ABONADO = EV_NABONADO;
   */
   -- FIN 71896/20-10-2008/EFR

   --SELECT NVL(COD_PLANSERV,'')
   SELECT COUNT(0)
   --INTO   EV_COD_PLANTARIF_AUX
   INTO   LN_CANTIDAD_AUX
   FROM   GA_PLANTECPLSERV
   WHERE  COD_PRODUCTO   = 1
   AND    COD_TECNOLOGIA = EV_COD_TECNOLOGIA
   AND    COD_PLANTARIF  =  EV_COD_PLANTARIF;
   /* AND    COD_PLANSERV = EV_CODPLANSERV; -- 71896/20-10-2008/EFR */

   --IF TRIM(EV_COD_PLANTARIF_AUX) = '' THEN

   IF LN_CANTIDAD_AUX = 0 THEN

      --SV_MENSAJE   := 'El plan seleccionado no es compatible con la tecnolog™a del abonado';-- 71896/20-10-2008/EFR
      --SV_MENSAJE   := 'El plan seleccionado no es compatible con el plan deservicio y la tecnolog™a del abonado';-- 71896/20-10-2008/EFR
      SV_MENSAJE   := 'El plan seleccionado no tiene configuraci—n  plan de servicio y  tecnolog™a';
      SV_RESULTADO := 'FALSE';
   END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
         --SV_MENSAJE   := 'El plan seleccionado no es compatible con la tecnolog™a del abonado';-- 71896/20-10-2008/EFR
     --SV_MENSAJE   := 'El plan seleccionado no es compatible con el plan deservicio y la tecnolog™a del abonado';-- 71896/20-10-2008/EFR
     SV_MENSAJE   := 'El plan seleccionado no tiene configuraci—n  plan de servicio y  tecnolog™a';
         SV_RESULTADO := 'FALSE';
    WHEN OTHERS THEN
         SV_MENSAJE   := 'ERROR EN PV_VALPLANSERTEC_WEB_PR: ' || SQLERRM;
         SV_RESULTADO := 'FALSE';

END PV_VALPLANSERTEC_WEB_PR;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALTECNO_PRODUCTO_PR(
                                                                                        EV_param_entrada IN  VARCHAR2,
                                                                                        SV_RESULTADO    OUT NOCOPY VARCHAR2,
                                                                                SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentaci—n
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VALTECNO_PRODUCTO_PR"
      Lenguaje="PL/SQL"
      Fecha="04-09-2008"
      Versi—n="1.0"
      Dise™ador="Orlando Cabezas"
          Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parømetros>
         <Entrada>
                        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
                <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
                <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parømetros>
  </Elemento>
</Documentaci—n>
*/
IS

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------

        LV_ABONADO            GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_PLANDESTINO        GA_ABOCEL.COD_PLANTARIF%TYPE;
        LV_COD_TECNOLOGIA     GA_ABOCEL.COD_TECNOLOGIA%TYPE;
        LV_COD_TECNOLOGIA_DES GA_ABOCEL.COD_TECNOLOGIA%TYPE;


        ------------------------------------------------




        CN_producto  CONSTANT number        := 1;




BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);

        LV_ABONADO          := string(5);
        LV_PLANDESTINO  := string(12);



        -- SE OBTIENE LA TECNOLOGIA DEL ABONADO
        SELECT  trim(COD_TECNOLOGIA)
        INTO  LV_COD_TECNOLOGIA
        FROM GA_ABOCEL
        WHERE
        NUM_ABONADO  =  LV_ABONADO;



        -- CON LA TECNOLOGIA DEL ABONADO ORIGEN , SE BUSCA QUE EL PLAN DESTINO TENGA ESA MISMA TECNOLOGIA

        SELECT  trim(COD_TECNOLOGIA)
        INTO  LV_COD_TECNOLOGIA_DES
        FROM GA_PLANTECPLSERV
        WHERE
        COD_PRODUCTO   =  CN_producto       AND
        COD_TECNOLOGIA =  LV_COD_TECNOLOGIA AND
        COD_PLANTARIF  =  LV_PLANDESTINO    AND
        SYSDATE BETWEEN  FEC_DESDE AND FEC_HASTA;




          IF (LV_COD_TECNOLOGIA = LV_COD_TECNOLOGIA_DES)  THEN
                 SV_MENSAJE   := ' ';
                 SV_RESULTADO := 'TRUE';


          ELSE
                 SV_MENSAJE   := 'No se puede realizar traspaso entre productos diferentes, con distinta tecnologia';
                 SV_RESULTADO := 'FALSE';
          END IF;


EXCEPTION

     WHEN NO_DATA_FOUND THEN
          SV_MENSAJE   := 'No se puede realizar traspaso entre productos diferentes, con distinta tecnologia';
          SV_RESULTADO := 'FALSE';


     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VALTECNO_PRODUCTO_PR: NO SE PUEDE VALIDAR TECNOLOGIAS ENTRE PRODUCTOS';
          SV_RESULTADO := 'FALSE';
END PV_VALTECNO_PRODUCTO_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_ABO_CLIENTE_PR(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
IS
/*
<Documentaci—n
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "PV_VAL_ABO_CLIENTE_PR"
    Lenguaje="PL/SQL"
    Fecha="30-12-2008"
    Versi—n="1.0"
    Dise™ador=""
    Programador=""
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripci—n> Validacion que exista algun abonado del cliente en una situacion valida.</Descripci—n>
    <Parømetros>
       <Entrada>
       <param nom="LV_param_entrada" Tipo="VARCHAR">Cadena con parømetros de entrada</param>
       </Entrada>
       <Salida>
       <param nom="LV_resultado" Tipo="VARCHAR">Resultado de la validaci—n</param>
       <param nom="LV_mensaje" Tipo="VARCHAR">mensaje de error en caso de aplicar la restricci—n</param>
       </Salida>
    </Parømetros>
 </Elemento>
</Documentaci—n>
*/

   string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

   ---- parametros reales de entrada --------------
   LN_CLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
   LV_ACTABO     GA_ACTABO.COD_ACTABO%TYPE;
   ------------------------------------------------
   LN_COUNT NUMBER;

BEGIN

   GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
   LN_CLIENTE := TO_NUMBER(string(6));
   LV_ACTABO  := string(4);

    SV_RESULTADO := 'TRUE';
    SV_MENSAJE   := '.';

    SELECT COUNT(0)
    INTO   LN_COUNT
    FROM   pvd_actuacion_situacion b, ga_abocel a
    WHERE  b.cod_producto  = a.cod_producto
    AND    b.cod_actabo    = LV_ACTABO
    AND    b.cod_situacion = a.cod_situacion
    and    a.cod_cliente = LN_CLIENTE;

    IF (LN_COUNT = 0) THEN
        SV_RESULTADO := 'FALSE';
        SV_MENSAJE   := 'Cliente no posee abonados con situaci—n permitida para esta operaci—n.';
    END IF;

/*   SELECT 'TRUE' INTO SV_RESULTADO
   FROM   ga_abocel a
   WHERE  a.cod_cliente = LN_CLIENTE
   AND    EXISTS (SELECT 1
                  FROM   pvd_actuacion_situacion b
                  WHERE  b.cod_producto  = a.cod_producto
                  AND    b.cod_actabo    = LV_ACTABO
                  AND    b.cod_situacion = a.cod_situacion)
   AND    ROWNUM = 1;*/

   EXCEPTION
   WHEN NO_DATA_FOUND THEN
        SV_RESULTADO := 'FALSE';
        SV_MENSAJE   := 'Cliente no posee abonados con situaci—n permitida para esta operaci—n.';

   WHEN OTHERS THEN
        SV_RESULTADO := 'FALSE';
        SV_MENSAJE   := 'ERROR EN PV_VAL_ABO_CLIENTE_PR: NO SE PUEDE VALIDAR SITUACION DEL CLIENTE.';

END PV_VAL_ABO_CLIENTE_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ABO_CLI_CON_OSPENDIENTES(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                      SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                      SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
IS
/*
<Documentaci—n
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "PV_ABO_CLI_CON_OSPENDIENTES"
    Lenguaje="PL/SQL"
    Fecha="30-12-2008"
    Versi—n="1.0"
    Dise™ador=""
    Programador=""
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripci—n> Validacion que NO existan abonados del cliente con OOSS pendientes.</Descripci—n>
    <Parømetros>
       <Entrada>
       <param nom="LV_param_entrada" Tipo="VARCHAR">Cadena con parømetros de entrada</param>
       </Entrada>
       <Salida>
       <param nom="LV_resultado" Tipo="VARCHAR">Resultado de la validaci—n</param>
       <param nom="LV_mensaje" Tipo="VARCHAR">mensaje de error en caso de aplicar la restricci—n</param>
       </Salida>
    </Parømetros>
 </Elemento>
</Documentaci—n>
*/
   string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------
   nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
   vACTABO     GA_ACTABO.COD_ACTABO%TYPE;
------------------------------------------------

   vCantidad          NUMBER(3);
   iTIPESTADOA        NUMBER(2);
   iCODESTADO         NUMBER(3);
   nestado            NUMBER(3);
   iTIPESTADOB        NUMBER(2);
   iCODESTCANCELADA      NUMBER(2);
   iMAXINTENTOS          NUMBER(2);

   V_DES_VALOR       GED_CODIGOS.DES_VALOR%TYPE;


BEGIN

   GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
   vACTABO      := string(4);
   nCLIENTE     := -1;
   nCLIENTE     := TO_NUMBER(string(6));

   SV_RESULTADO := 'TRUE';
   vCantidad    := 0;
   iTIPESTADOA  := 3;
   iTIPESTADOB  := 1;


   BEGIN
      SELECT VAL_PARAMETRO
      INTO   iCODESTADO
      FROM   GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'ESTADO_PV_MENSAJE';

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              SV_RESULTADO := 'FALSE';
              SV_MENSAJE   := 'NO SE ENCONTRO PARAMETRO ESTADO_PV_MENSAJES EN GED_PARAMETROS.' || SQLERRM || '.';
   END;

   BEGIN
      SELECT VAL_PARAMETRO
      INTO   iCODESTCANCELADA
      FROM   GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'EST_BAJA_CANCELADA';

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              SV_RESULTADO := 'FALSE';
              SV_MENSAJE   := 'NO SE ENCONTRO PARAMETRO EST_BAJA_CANCELADA EN GED_PARAMETROS.' || SQLERRM || '.';
   END;

   BEGIN
      SELECT VAL_PARAMETRO
      INTO   iMAXINTENTOS
      FROM   GED_PARAMETROS
      WHERE  NOM_PARAMETRO = 'MAX_INTENTOS';

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              SV_RESULTADO := 'FALSE';
              SV_MENSAJE   := 'NO SE ENCONTRO PARAMETRO MAX_INTENTOS EN GED_PARAMETROS.' || SQLERRM || '.';
   END;


   SELECT COUNT(*)
   INTO   vCantidad
   FROM   PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
   WHERE  A.NUM_OS      = B.NUM_OS
   AND    A.NUM_OS      = C.NUM_OS
   AND    B.NUM_OS      = C.NUM_OS
   AND    B.COD_CLIENTE = nCLIENTE
   AND    A.COD_ESTADO  < iCODESTADO
   AND    A.COD_ESTADO <> iCODESTCANCELADA
   AND    A.COD_ESTADO  = C.COD_ESTADO
   AND    (C.TIP_ESTADO = iTIPESTADOA OR C.TIP_ESTADO = iTIPESTADOB);

   IF vCantidad <> 0 THEN
      nestado := 0;
      BEGIN
         SELECT a.cod_estado
         INTO   nestado
         FROM   PV_IORSERV A, PV_CAMCOM B, PV_ERECORRIDO C
         WHERE  A.NUM_OS      = B.NUM_OS
         AND    A.NUM_OS      = C.NUM_OS
         AND    B.NUM_OS      = C.NUM_OS
         AND    B.cod_cliente = nCLIENTE
         AND    a.cod_os     in ('10020','10233','10530','10539','10022')
         AND    a.cod_estado  > 110
         AND    NUM_INTENTOS IS NULL
         AND    ROWNUM        = 1;

         IF nestado > 110 THEN
            vCantidad := 1;
         ELSIF nestado>0  THEN
               vCantidad := 0;
         END IF;

         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 NULL;
      END;

   END IF;


   IF vCantidad <> 0 THEN
      SV_RESULTADO := 'FALSE';
      SV_MENSAJE   := 'Algunos abonados del cliente tienen Orden se Servicio pendiente';
   END IF;

   EXCEPTION
      WHEN OTHERS THEN
           SV_RESULTADO := 'FALSE';
           SV_MENSAJE   := 'ERROR EN PV_ABO_CLI_CON_OSPENDIENTES: NO SE PUEDE VALIDAR OOSS PENDIENTES PARA LOS ABONADOS DEL CLIENTE.' || SQLERRM || '.';

END PV_ABO_CLI_CON_OSPENDIENTES;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALTECNO_CLIABO_PR(EV_PARAM_ENTRADA  IN  VARCHAR2,
                                  SV_RESULTADO      OUT NOCOPY VARCHAR2,
                                  SV_MENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
IS
/*
<Documentaci—n
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "PV_VALTECNO_CLIABO_PR"
    Lenguaje="PL/SQL"
    Fecha="20-08-2008"
    Versi—n="1.0"
    Dise™ador="Orlando Cabezas"
    Programador="Orlando Cabezas"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripci—n> Validacion de tecnologia por plan</Descripci—n>
    <Parømetros>
       <Entrada>
       <param nom="LV_param_entrada" Tipo="VARCHAR">Cadena con parømetros de entrada</param>
       </Entrada>
       <Salida>
       <param nom="LV_resultado" Tipo="VARCHAR">Resultado de la validaci—n</param>
       <param nom="LV_mensaje" Tipo="VARCHAR">mensaje de error en caso de aplicar la restricci—n</param>
       </Salida>
    </Parømetros>
 </Elemento>
</Documentaci—n>
*/

STRING SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

EV_NABONADO           NUMBER;
EV_CODCLIENTE          NUMBER;
EV_COD_TECNOLOGIA      VARCHAR2(4);
EN_Contador              NUMBER;
EN_Contador2              NUMBER;

BEGIN
   GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_PARAM_ENTRADA, STRING);

   EV_NABONADO    := TO_NUMBER(STRING(5));
   EV_CODCLIENTE  := TO_NUMBER(STRING(6)); -- PLAN NUEVO

   SV_RESULTADO      := 'TRUE';

    IF ((EV_NABONADO != 0) AND EV_NABONADO IS NOT NULL) THEN

        SELECT cod_tecnologia
        INTO   EV_COD_TECNOLOGIA
        FROM   ga_abocel
        WHERE  num_abonado = EV_NABONADO
        UNION
        SELECT cod_tecnologia
        FROM   ga_aboamist
        WHERE  num_abonado = EV_NABONADO;

        IF EV_COD_TECNOLOGIA != 'GSM' AND EV_COD_TECNOLOGIA != 'FIJO' THEN
            SV_MENSAJE   := 'El Abonado no tiene Tecnolog™a GSM/FIJO';
            SV_RESULTADO := 'FALSE';
        END IF;

    ELSE

        SELECT COUNT(0)
        INTO   EN_Contador
        FROM   ga_abocel
        WHERE  cod_cliente = EV_CODCLIENTE
        AND       cod_tecnologia != 'GSM'
            AND       cod_tecnologia != 'FIJO'
        AND       cod_situacion != 'BAA';

        SELECT COUNT(0)
        INTO   EN_Contador2
        FROM   ga_aboamist
        WHERE  cod_cliente = EV_CODCLIENTE
        AND       cod_tecnologia != 'GSM'
            AND       cod_tecnologia != 'FIJO'
        AND       cod_situacion != 'BAA';

        IF (EN_Contador+EN_Contador2 > 0) THEN
            SV_MENSAJE   := 'El Cliente posee abonados activos sin Tecnolog™a GSM/FIJO';
            SV_RESULTADO := 'FALSE';
        END IF;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
         --SV_MENSAJE   := 'El plan seleccionado no es compatible con la tecnolog™a del abonado';-- 71896/20-10-2008/EFR
         SV_MENSAJE   := 'Abonado informado no existe';-- 71896/20-10-2008/EFR
         SV_RESULTADO := 'FALSE';
    WHEN OTHERS THEN
         SV_MENSAJE   := 'ERROR EN PV_VALTECNO_CLIABO_PR: ' || SQLERRM;
         SV_RESULTADO := 'FALSE';

END PV_VALTECNO_CLIABO_PR;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE PV_ANTIGUEDAD_RENOVACION_PR (EV_param_entrada IN  VARCHAR2,
                                       SV_RESULTADO    OUT NOCOPY VARCHAR2,
                                       SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentaci—n
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ANTIGUEDAD_RENOVACION_PR "
      Lenguaje="PL/SQL"
      Fecha="07-05-2009"
      Versi—n="1.0"
      Dise™ador="Orlando Cabezas"
          Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parømetros>
         <Entrada>
                        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
                <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
                <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parømetros>
  </Elemento>
</Documentaci—n>
*/
IS

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------

        LV_ABONADO            GA_ABOCEL.NUM_ABONADO%TYPE;
        LV_CLIENTE            GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_PLANTARIF      GA_ABOCEL.COD_PLANTARIF%TYPE;
        LN_RENOVA_ANTIG       TA_PLANTARIF.NUM_MESES_RENOVA%type;
        LN_CANTIDAD_MESES     NUMBER(3);

        ------------------------------------------------

        CN_producto  CONSTANT number        := 1;

BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);

        LV_ABONADO          := string(5);
        LV_CLIENTE          := string(6);

        LN_RENOVA_ANTIG     :=0;
        LN_CANTIDAD_MESES   :=0;

        SV_MENSAJE   := 'OK';
        SV_RESULTADO := 'TRUE';



        SELECT  trunc(MONTHS_BETWEEN(sysdate, fec_alta)),COD_PLANTARIF
        INTO LN_CANTIDAD_MESES, LV_COD_PLANTARIF
        FROM   GA_ABOCEL
        WHERE  NUM_ABONADO = LV_ABONADO
        AND    COD_CLIENTE = LV_CLIENTE;


        SELECT  NUM_MESES_RENOVA
        INTO LN_RENOVA_ANTIG
        FROM TA_PLANTARIF
        WHERE COD_PLANTARIF =LV_COD_PLANTARIF;


        IF LN_CANTIDAD_MESES < LN_RENOVA_ANTIG THEN
            SV_MENSAJE   := 'RENOVACION, Abonado no cumple los meses minimos de antiguedad para realizar esta solicitud de renovaci—n';
                SV_RESULTADO := 'FALSE';
        END IF;



EXCEPTION

     WHEN NO_DATA_FOUND THEN
          SV_MENSAJE   := 'OK';
          SV_RESULTADO := 'TRUE';


     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_ANTIGUEDAD_RENOVACION_PR : NO SE PUEDE VALIDAR ANTIGUEDAD POR RENOVACI-N';
          SV_RESULTADO := 'FALSE';
END PV_ANTIGUEDAD_RENOVACION_PR ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_CENTRAL_PR  (EV_param_entrada IN  VARCHAR2,
                                       SV_RESULTADO    OUT NOCOPY VARCHAR2,
                                       SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentaci—n
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_CENTRAL_PR "
      Lenguaje="PL/SQL"
      Fecha="07-05-2009"
      Versi—n="1.0"
      Dise™ador="Orlando Cabezas"
          Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parømetros>
         <Entrada>
                        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
                <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
                <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parømetros>
  </Elemento>
</Documentaci—n>
*/

IS
        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------
        lv_abonado            ga_abocel.num_abonado%type;
        lv_cliente            ga_abocel.cod_cliente%type;
        lv_cod_os             ci_tiporserv.cod_os%type;
        lv_cod_nivel          pv_prestacion_ooss_to.cod_nivel%type;
        ln_cod_prestacion     pv_prestacion_ooss_to.cod_prestacion%type;
        ln_cod_prestacion_aux pv_prestacion_ooss_to.cod_prestacion%type;
        ------------------------------------------------
        cn_producto  constant number        := 1;
begin
        ge_pac_arreglopr.ge_pr_retornaarreglo(ev_param_entrada, string);
        lv_abonado          := string(5);
        lv_cliente          := string(6);
        lv_cod_os           := string(9);

        sv_mensaje   := 'OK';
        sv_resultado := 'TRUE';

         begin

                select a.cod_nivel
                into  lv_cod_nivel
                from pv_prestacion_ooss_to a
                where a.cod_os = lv_cod_os
                AND ROWNUM= 1;

                case lv_cod_nivel
                     when 1  then-- nivel de abonado

                        select a.cod_prestacion
                        into  ln_cod_prestacion
                        from pv_prestacion_ooss_to a
                        where a.cod_prestacion in (select b.cod_prestacion
                                                   from ga_abocel b
                                                   where b.num_abonado =  lv_abonado
                                                   union
                                                   select b.cod_prestacion
                                                   from ga_aboamist b
                                                   where b.num_abonado =  lv_abonado)
                              and a.cod_os = trim(lv_cod_os)
                              and sysdate between a.fec_desde and a.fec_hasta;


                     when  2  then-- nivel de cuenta
                        null;
                     when 3 then-- nivel de cliente
                        null;
                     when 4 then -- nivel de usuario

                        if (trim(lv_cod_os)='10019' or trim(lv_cod_os)='50006') then

                            select  num_abonado,b.cod_prestacion
                            into lv_abonado, ln_cod_prestacion
                            from ga_abocel b
                            where b.cod_usuario =  lv_abonado
                            union
                            select  num_abonado,b.cod_prestacion
                            from ga_aboamist b
                            where b.cod_usuario =  lv_abonado;


                            select a.cod_prestacion
                            into  ln_cod_prestacion_aux
                            from pv_prestacion_ooss_to a
                            where a.cod_prestacion = ln_cod_prestacion
                            and a.cod_os           = trim(lv_cod_os)
                            and sysdate between a.fec_desde and a.fec_hasta;

                        else
                            null;
                        end if;
                end case;







        exception

             when no_data_found then
                  sv_mensaje   := 'No Existe Prestaci—n definida para el abonado';
                  sv_resultado := 'FALSE';
        end;






exception

     when no_data_found then
          sv_mensaje   := 'No Existe Prestaci—n definida para el abonado';
          sv_resultado := 'FALSE';
     when others then
          sv_mensaje   := 'ERROR EN PV_VAL_CENTRAL_PR  : NO SE PUEDE VALIDAR LA CENTRAL';
          sv_resultado := 'FALSE';
END PV_VAL_CENTRAL_PR;



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_GRUPOPRES_ABO_PR (EV_param_entrada IN  VARCHAR2,
                                       SV_RESULTADO    OUT NOCOPY VARCHAR2,
                                       SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentaci—n
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_GRUPOPRES_ABO_PR"
      Lenguaje="PL/SQL"
      Fecha="01-10-2009"
      Versi—n="1.0"
      Dise™ador="Orlando Cabezas"
          Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parømetros>
         <Entrada>
                        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
                <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
                <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parømetros>
  </Elemento>
</Documentaci—n>
*/

IS
        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------
        lv_cliente            ga_abocel.cod_cliente%type;
        lv_cliented           ga_abocel.cod_cliente%type;
        LV_cantidad           number(4);
        lv_count              number(4);
        lv_grupo_pretacion    ge_prestaciones_td.grp_prestacion%type;
        ------------------------------------------------
        cn_producto  constant number        := 1;

        CURSOR CURSOR_pretacion is
        select count(1),b.grp_prestacion
        from ga_abocel a,ge_prestaciones_td b
        where a.cod_cliente=  lv_cliente
        and a.cod_situacion not in ('BAP','BAA')
        and a.cod_prestacion = b.cod_prestacion
        GROUP BY b.grp_prestacion;



begin
        ge_pac_arreglopr.ge_pr_retornaarreglo(ev_param_entrada, string);
        lv_cliente          := string(6);


        sv_mensaje   := 'OK';
        sv_resultado := 'TRUE';

        lv_count   :=0;
        OPEN CURSOR_pretacion;
        LOOP
            FETCH CURSOR_pretacion INTO LV_cantidad,Lv_grupo_pretacion;
            EXIT WHEN CURSOR_pretacion%NOTFOUND;

            lv_count :=lv_count + 1;

        END LOOP;
        CLOSE CURSOR_pretacion;


        if lv_count> 1 then
           sv_mensaje   := 'El cliente ' || lv_cliente ||'  posee abonados con distinta grupo de prestaci—n';
           sv_resultado := 'FALSE';
        end if;


exception

     when others then
          sv_mensaje   := 'ERROR EN PV_VAL_GRUPOPRES_ABO_PR  : NO SE PUEDE AGRUPACIÀN DE PRESTACIÀN';
          sv_resultado := 'FALSE';
END PV_VAL_GRUPOPRES_ABO_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_GRUPOPRES_ORIDES_PR (EV_param_entrada IN  VARCHAR2,
                                       SV_RESULTADO    OUT NOCOPY VARCHAR2,
                                       SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentaci—n
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_GRUPOPRES_ORIDES_PR"
      Lenguaje="PL/SQL"
      Fecha="01-10-2009"
      Versi—n="1.0"
      Dise™ador="Orlando Cabezas"
          Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parømetros>
         <Entrada>
                        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
                <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
                <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parømetros>
  </Elemento>
</Documentaci—n>
*/

IS
        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------
        lv_cliente            ga_abocel.cod_cliente%type;
         lv_count              number(4);
        lv_grupo_pretacion    ge_prestaciones_td.grp_prestacion%type;
        lv_grupo              ge_prestaciones_td.grp_prestacion%type;
        ------------------------------------------------
        cn_producto  constant number        := 1;

        CURSOR CURSOR_pretacion is
        select b.grp_prestacion
        from ga_abocel a,ge_prestaciones_td b
        where a.cod_cliente=  lv_cliente
        and a.cod_situacion not in ('BAP','BAA')
        and a.cod_prestacion = b.cod_prestacion
        GROUP BY b.grp_prestacion;



begin
        ge_pac_arreglopr.ge_pr_retornaarreglo(ev_param_entrada, string);
        lv_cliente          := string(6);
        lv_grupo           := string(16);

        sv_mensaje   := 'OK';
        sv_resultado := 'TRUE';

        lv_count   :=0;
        OPEN CURSOR_pretacion;
        LOOP
            FETCH CURSOR_pretacion INTO Lv_grupo_pretacion;
            EXIT WHEN CURSOR_pretacion%NOTFOUND;

            IF TRIM(Lv_grupo_pretacion)<>TRIM(lv_grupo)   THEN
               lv_count :=1;
            END IF;

        END LOOP;
        CLOSE CURSOR_pretacion;


        if lv_count= 1 then
           sv_mensaje   := 'Lo(s) abonado(s) poseen grupo prestaci—n diferente a los abonados del cliente destino';
           sv_resultado := 'FALSE';
        end if;


exception

     when others then
          sv_mensaje   := 'ERROR EN PV_VAL_GRUPOPRES_ORIDES_PR : NO SE PUEDE VALIDAR GRUPO PRESTACION ORIGEN/DESTINO';
          sv_resultado := 'FALSE';
END PV_VAL_GRUPOPRES_ORIDES_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_NUMERO_PILOTO_PR (EV_param_entrada IN  VARCHAR2,
                    SV_RESULTADO    OUT NOCOPY VARCHAR2,
                    SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentacion
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_NUMERO_PILOTO_PR"
      Lenguaje="PL/SQL"
      Fecha="07-05-2009"
      Versi—n="1.0"
      Dise±ador="Jaime Bravo"
      Programador="Jaime Bravo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parﬂmetros>
         <Entrada>
        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
        <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
        <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parﬂmetros>
  </Elemento>
</Documentaciøn>
*/
IS

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------

        LV_ABONADO            GA_ABOCEL.NUM_ABONADO%TYPE;
        LN_CANTIDAD_LINEA   NUMBER(2);
        LN_PERMITIDO     NUMBER(2);

        ------------------------------------------------

        CN_producto  CONSTANT number        := 1;

BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
        LV_ABONADO          := string(5);
        LN_PERMITIDO   :=0;
        SV_MENSAJE   := 'OK';
        SV_RESULTADO := 'TRUE';

    SELECT COUNT(1)
    INTO LN_CANTIDAD_LINEA
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = LV_ABONADO
     AND  NUM_CELULAR IN
        (SELECT NUM_PILOTO
         FROM GA_NRO_PILOTO_RANGO_TO);

        IF LN_PERMITIDO < LN_CANTIDAD_LINEA THEN
            SV_MENSAJE   := 'No continuar, Transacciøn no permitida para n∑meros pilotos';
            SV_RESULTADO := 'FALSE';
        END IF;
EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SV_MENSAJE   := 'OK';
          SV_RESULTADO := 'TRUE';

     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_NUMERO_PILOTO_PR : NO SE PUEDE VALIDAR NUMERO PILOTO';
          SV_RESULTADO := 'FALSE';
END PV_VAL_NUMERO_PILOTO_PR ;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_CICLOS_CONTRA_ASOCIA_PR (EV_param_entrada IN  VARCHAR2,
                    SV_RESULTADO    OUT NOCOPY VARCHAR2,
                    SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentacion
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_CICLOS_CONTRA_ASOCIA_PR"
      Lenguaje="PL/SQL"
      Fecha="29-01-2010"
      Versi—n="1.0"
      Dise±ador="Jaime Bravo"
      Programador="Jaime Bravo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parﬂmetros>
         <Entrada>
        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
        <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
        <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parﬂmetros>
  </Elemento>
</Documentaciøn>
*/
IS
        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------

        LV_CLIENTEORI            GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_CLIENTEDES            GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COD_CICLOORI       NUMBER(2);
        LV_COD_CICLODES         NUMBER(2);
        ------------------------------------------------

BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
    LV_CLIENTEORI := string(6);
    LV_CLIENTEDES := string(16);

    SV_MENSAJE   := 'OK';
    SV_RESULTADO := 'TRUE';

    SELECT COD_CICLO
    INTO LV_COD_CICLOORI
    FROM GE_CLIENTES
    WHERE COD_CLIENTE = LV_CLIENTEORI;


    SELECT COD_CICLO
    INTO LV_COD_CICLODES
    FROM GE_CLIENTES
    WHERE COD_CLIENTE = LV_CLIENTEDES;

        IF TRIM(LV_COD_CICLODES) <> TRIM(LV_COD_CICLOORI) THEN
            SV_MENSAJE   := 'LOS CICLOS SON DIFERENTES';
            SV_RESULTADO := 'FALSE';
        END IF;
EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SV_MENSAJE   := 'NO POSEEN CICLO';
          SV_RESULTADO := 'FALSE';

     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_CICLOS_CONTRA_ASOCIA_PR : NO SE PUEDEN VALIDAR CICLOS';
          SV_RESULTADO := 'FALSE';
END PV_VAL_CICLOS_CONTRA_ASOCIA_PR ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_CLIE_CONTRA_NO_ASOC_PR (EV_param_entrada IN  VARCHAR2,
                    SV_RESULTADO    OUT NOCOPY VARCHAR2,
                    SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentacion
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_CLIE_CONTRA_NO_ASOC_PR"
      Lenguaje="PL/SQL"
      Fecha="29-01-2010"
      Versi—n="1.0"
      Dise±ador="Jaime Bravo"
      Programador="Jaime Bravo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parﬂmetros>
         <Entrada>
        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
        <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
        <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parﬂmetros>
  </Elemento>
</Documentaciøn>
*/
IS

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------
        LV_CLIENTE            GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_COUNT_CICL         NUMBER(4);
        ------------------------------------------------

BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
    LV_CLIENTE := string(6);

    LV_COUNT_CICL   :=0;
    SV_MENSAJE   := 'OK';
    SV_RESULTADO := 'TRUE';

    SELECT count(cod_cliente_asoc)
    INTO LV_COUNT_CICL
    FROM fa_det_facturacion_dif_to
    WHERE cod_cliente_asoc = LV_CLIENTE;

        IF (LV_COUNT_CICL > 0) THEN
            SV_MENSAJE   := 'ES CLIENTE ASOCIADO';
            SV_RESULTADO := 'FALSE';
        END IF;

EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SV_MENSAJE   := 'ERROR AL VALIDAR CLIENTE ASOCIADO';
          SV_RESULTADO := 'FALSE';

     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_CLIE_CONTRA_NO_ASOC_PR : NO SE PUEDE VALIDAR CLIENTES';
          SV_RESULTADO := 'FALSE';
END PV_VAL_CLIE_CONTRA_NO_ASOC_PR ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_SSASIS911_CONTRA_PR (EV_param_entrada IN  VARCHAR2,
                    SV_RESULTADO    OUT NOCOPY VARCHAR2,
                    SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentacion
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_SSASIS911_CONTRA__PR"
      Lenguaje="PL/SQL"
      Fecha="01-04-2010"
      Versi—n="1.0"
      Dise±ador="ORLANDO CABEZAS"
      Programador="ORLANDO CABEZAS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripci—n></Descripci—n>
       <Parﬂmetros>
         <Entrada>
        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
        <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
        <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parﬂmetros>
  </Elemento>
</Documentaciøn>
*/
IS

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------

        LV_ABONADO            GA_ABOCEL.NUM_ABONADO%TYPE;
        LN_CANTIDAD         NUMBER(2);
        LV_SS_ASISTENCIA_911            ged_parametros.val_parametro%TYPE;
        LN_pos              NUMBER(3);
        LN_MAX              NUMBER(3);
        LN_pos2             NUMBER(3);
        LN_MAX2             NUMBER(3);
        LV_CADENA           VARCHAR2(255);
        LV_CADENA2          VARCHAR2(5);
        LV_CADENA_FINAL     VARCHAR2(255);

        ------------------------------------------------



BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
        LV_ABONADO          := string(5);
        SV_MENSAJE   := 'OK';
        SV_RESULTADO := 'TRUE';



        SELECT VAL_PARAMETRO
        INTO LV_SS_ASISTENCIA_911
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = 'SS_ASISTENCIA_911';

        LN_pos:=0;
        LN_MAX:=LENGTH(LV_SS_ASISTENCIA_911);


        WHILE (LN_pos< NVL(LN_MAX,0)) LOOP
                LN_pos2 :=INSTR(LV_SS_ASISTENCIA_911,',');
                IF LN_POS2= 0 THEN

                   --LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX -1);
                   --LN_pos := lN_MAX+1;

                   IF  LN_pos> 0 THEN
                      LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX -1);
                       LN_pos := lN_MAX+1;
                   END IF;

                   IF  LN_pos= 0 THEN
                      LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_MAX);
                       LN_pos := lN_MAX+1;
                   END IF;


                ELSE

                   LV_CADENA2:= SUBSTR(LV_SS_ASISTENCIA_911,1,LN_POS2 - 1);


                END IF;

                Insert into GED_CODIGOS
                (COD_MODULO, NOM_TABLA, NOM_COLUMNA, COD_VALOR, DES_VALOR, FEC_ULTMOD, NOM_USUARIO)
                Values
               ('GA', 'GA_CONTACTO_ABONADO_TO', 'COD_SERVICIO', LV_CADENA2, 'SERVICIO ASISTENCIA 911', SYSDATE,USER);


                dbms_output.PUT_LINE('  LV_CADENA2:'||  LV_CADENA2);
                if LN_pos < lN_MAX then
                LN_pos:=LN_pos + 1;
                LV_SS_ASISTENCIA_911:=SUBSTR(LV_SS_ASISTENCIA_911,LN_POS2+1,LN_MAX);
                end if;

        END LOOP;

        SELECT count(1)
        into LN_CANTIDAD
        FROM GA_servsuplabo B
        WHERE b.NUM_ABONADO= LV_ABONADO
        AND B.COD_servsupl in (SELECT  TRIM(COD_VALOR) FROM GED_CODIGOS
                               WHERE COD_MODULO='GA'AND NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND NOM_COLUMNA ='COD_SERVICIO')
        AND B.IND_ESTADO < 3;

        IF LN_CANTIDAD  = 0 THEN
            SV_MENSAJE   := 'Error no posee Servicios de asistencia 911';
            SV_RESULTADO := 'FALSE';
        END IF;

        DELETE
        GED_CODIGOS
        WHERE COD_MODULO='GA'AND
        NOM_TABLA ='GA_CONTACTO_ABONADO_TO' AND
        NOM_COLUMNA ='COD_SERVICIO' AND
        DES_VALOR='SERVICIO ASISTENCIA 911';


EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SV_MENSAJE   := 'Error no posee Servicios de asistencia 911';
          SV_RESULTADO := 'FALSE';

     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_SSASIS911_CONTRA__PR : NO SE PUEDE VALIDAR SS ASISTENCIA 911';
          SV_RESULTADO := 'FALSE';

END PV_VAL_SSASIS911_CONTRA_PR ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VAL_PERM_MIGR_PREP_PR(
                                   EV_PARAM_ENTRADA IN  VARCHAR2,
                                   SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                   SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
)
 /*
<DocumentaciÛn
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_PERM_MIGR_PREP_PR"
      Lenguaje="PL/SQL"
      Fecha="17-05-2011"
      VersiÛn="1.0"
      DiseÒador="EVERIS"
      Programador="EVERIS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <DescripciÛn> PERMITE VALIDAR PERMISO DE ACCESO DEL USUARIO PARA REALIZAR UN CAMBIO BAJA OPTA PREPAGO</DescripciÛn>
      <Par·metros>
         <ENTRADA>
              <PARAM NOM="EV_param_entrada" TIPO="VARCHAR2"> PARAMETROS DE ENTRADA PARA LA VALIDACION</PARAM>
         </ENTRADA>
         <Salida>
            <param nom="SV_RESULTADO"  Tipo="VARCHAR2" >INDICA SI LA EJECUCION FUE CORRECTA</param>
            <param nom="SV_MENSAJE"  Tipo="VARCHAR2" >MENSAJE DE ERROR RETORNADO</param>
         </Salida>
      </Par·metros>
   </Elemento>
</DocumentaciÛn>
*/
IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
    
    ---- parametros reales de entrada --------------
    LV_USUARIO     	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE;
    
    LV_CODPROCESO  GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    
    LV_AUX   		 GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    ------------------------------------------------    

BEGIN

    SV_MENSAJE   := 'OK';
    SV_RESULTADO := 'TRUE';

    GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_PARAM_ENTRADA, STRING);

    LV_USUARIO := STRING(10);

    SELECT COD_PROCESO INTO LV_CODPROCESO FROM GAD_PROCESOS_PERFILES WHERE NOM_PERFIL_PROCESO = 'PER_PL_MIG_PREPAGO';

    BEGIN
    
	 	  IF (LV_USUARIO = '') OR (LV_USUARIO IS NULL) THEN
                        
		      SELECT A.COD_PROCESO
		      INTO LV_AUX
		      FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
		      WHERE B.NOM_USUARIO  = USER
		      AND   A.COD_GRUPO    = B.COD_GRUPO
		      AND   A.COD_PROCESO  = LV_CODPROCESO
		      AND ROWNUM     = 1;
		  ELSE
              
		      SELECT A.COD_PROCESO
		      INTO LV_AUX
		      FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
		      WHERE B.NOM_USUARIO  = LV_USUARIO
		      AND   A.COD_GRUPO    = B.COD_GRUPO
		      AND   A.COD_PROCESO  = LV_CODPROCESO
		      AND ROWNUM     = 1;
		  END IF;
	
    EXCEPTION
	      WHEN NO_DATA_FOUND THEN
	      LV_AUX:=NULL;
	END;

	IF LV_AUX IS NOT NULL THEN
        
        SV_RESULTADO := 'TRUE';
        
    ELSE
    
        SV_RESULTADO := 'FALSE';
        SV_MENSAJE   := 'USUARIO SIN PERMISOS PARA MIGRACI”N A PREPAGO, EL CASO DEBE DERIVARSE A UN SUPERVISOR';
        
	END IF;  

EXCEPTION
    
     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_PERM_MIGR_PREP_PR : NO SE PUEDE VALIDAR ACCESO PARA MIGRACION OPTA PREPAGO';
          SV_RESULTADO := 'FALSE';

END PV_VAL_PERM_MIGR_PREP_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VAL_PERM_MIGR_PRE_POS_PR(
                                   EV_PARAM_ENTRADA IN  VARCHAR2,
                                   SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                   SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
)
 /*
<DocumentaciÛn
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_PERM_MIGR_PRE_POS_PR"
      Lenguaje="PL/SQL"
      Fecha="18-05-2011"
      VersiÛn="1.0"
      DiseÒador="EVERIS"
      Programador="EVERIS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <DescripciÛn> PERMITE VALIDAR PERMISO DE ACCESO DEL USUARIO PARA REALIZAR UN CAMBIO DE PREPAGO A POSPAGO</DescripciÛn>
      <Par·metros>
         <ENTRADA>
              <PARAM NOM="EV_param_entrada" TIPO="VARCHAR2"> PARAMETROS DE ENTRADA PARA LA VALIDACION</PARAM>
         </ENTRADA>
         <Salida>
            <param nom="SV_RESULTADO"  Tipo="VARCHAR2" >INDICA SI LA EJECUCION FUE CORRECTA</param>
            <param nom="SV_MENSAJE"  Tipo="VARCHAR2" >MENSAJE DE ERROR RETORNADO</param>
         </Salida>
      </Par·metros>
   </Elemento>
</DocumentaciÛn>
*/
IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
    
    ---- parametros reales de entrada --------------
    LV_USUARIO     	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE;
    
    LV_CODPROCESO  GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    
    LV_AUX   		 GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    ------------------------------------------------    

BEGIN

    SV_MENSAJE   := 'OK';
    SV_RESULTADO := 'TRUE';

    GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_PARAM_ENTRADA, STRING);

    LV_USUARIO := STRING(10);

    SELECT COD_PROCESO INTO LV_CODPROCESO FROM GAD_PROCESOS_PERFILES WHERE NOM_PERFIL_PROCESO = 'PER_PL_MIG_PRE_POS';

    BEGIN
    
	 	  IF (LV_USUARIO = '') OR (LV_USUARIO IS NULL) THEN
    
		      SELECT A.COD_PROCESO
		      INTO LV_AUX
		      FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
		      WHERE B.NOM_USUARIO  = USER
		      AND   A.COD_GRUPO    = B.COD_GRUPO
		      AND   A.COD_PROCESO  =LV_CODPROCESO
		      AND ROWNUM     = 1;
		  ELSE
          
		      SELECT A.COD_PROCESO
		      INTO LV_AUX
		      FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
		      WHERE B.NOM_USUARIO  = LV_USUARIO
		      AND   A.COD_GRUPO    = B.COD_GRUPO
		      AND   A.COD_PROCESO  = LV_CODPROCESO
		      AND ROWNUM     = 1;
		  END IF;
	
    EXCEPTION
	      WHEN NO_DATA_FOUND THEN
	      LV_AUX:=NULL;
	END;

	IF LV_AUX IS NOT NULL THEN
        
        SV_RESULTADO := 'TRUE';
        
    ELSE
    
        SV_RESULTADO := 'FALSE';
        SV_MENSAJE   := 'USUARIO SIN PERMISOS PARA MIGRACI”N DE PREPAGO A POSPAGO/HÕBRIDO, EL CASO DEBE DERIVARSE A UN SUPERVISOR';
        
	END IF;  

EXCEPTION
    
     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_PERM_MIGR_PRE_POS_PR : NO SE PUEDE VALIDAR ACCESO PARA MIGRACION DE PREPAGO A POSPAGO';
          SV_RESULTADO := 'FALSE';

END PV_VAL_PERM_MIGR_PRE_POS_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_VAL_PERM_CAMBPLAN_MAYMEN_PR(
                                        EV_PARAM_ENTRADA IN  VARCHAR2,
                                        SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                        SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
)
 /*
<DocumentaciÛn
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_PERM_CAMBPLAN_MAYMEN_PR"
      Lenguaje="PL/SQL"
      Fecha="20-05-2011"
      VersiÛn="1.0"
      DiseÒador="EVERIS"
      Programador="EVERIS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <DescripciÛn> PERMITE VALIDAR PERMISO DE ACCESO DEL USUARIO PARA REALIZAR UN CAMBIO DE UN PLAN CON MAYOR A MENOR CARGO</DescripciÛn>
      <Par·metros>
         <ENTRADA>
              <PARAM NOM="EV_param_entrada" TIPO="VARCHAR2"> PARAMETROS DE ENTRADA PARA LA VALIDACION</PARAM>
         </ENTRADA>
         <Salida>
            <param nom="SV_RESULTADO"  Tipo="VARCHAR2" >INDICA SI LA EJECUCION FUE CORRECTA</param>
            <param nom="SV_MENSAJE"  Tipo="VARCHAR2" >MENSAJE DE ERROR RETORNADO</param>
         </Salida>
      </Par·metros>
   </Elemento>
</DocumentaciÛn>
*/
IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
    
    ---- parametros reales de entrada --------------
    LV_USUARIO               GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE;
    LV_CODPROCESO            GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    LV_AUX                   GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    
    LN_NUM_ABONADO         GA_ABOCEL.NUM_ABONADO%TYPE;
    LV_PLANTARIF_ORI       TA_PLANTARIF.COD_PLANTARIF%TYPE;
    LV_PLANTARIF_DEST      TA_PLANTARIF.COD_PLANTARIF%TYPE;
    LV_CARGOBASICO_ORIGEN  TA_CARGOSBASICO.COD_CARGOBASICO%TYPE; 
    LV_CARGOBASICO_DEST    TA_CARGOSBASICO.COD_CARGOBASICO%TYPE;
    
    LN_IMPCARGO_ORIGEN     TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
    LN_IMPCARGO_DESTINO    TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
    ------------------------------------------------    

BEGIN

    SV_MENSAJE   := 'OK';
    SV_RESULTADO := 'TRUE';
    
    GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_PARAM_ENTRADA, STRING);

    LV_USUARIO := STRING(10);
    LN_NUM_ABONADO := STRING(5);
    LV_PLANTARIF_DEST := STRING(12);
    
    
    -- OBTENER EL CODIGO DEL PLAN TARIFARIO ORIGEN O ACTUAL DEL ABONADO
    SELECT COD_PLANTARIF
    INTO LV_PLANTARIF_ORI
    FROM GA_ABOCEL
    WHERE NUM_ABONADO = LN_NUM_ABONADO;

    -- OBTENER EL CODIGO DEL CARGO BASICO ACTUAL DEL PLAN TARIFARIO ACTUAL DEL ABONADO
    SELECT COD_CARGOBASICO
    INTO LV_CARGOBASICO_ORIGEN
    FROM TA_PLANTARIF
    WHERE COD_PLANTARIF=LV_PLANTARIF_ORI;

    -- OBTENER EL CODIGO DEL CARGO BASICO DEL PLAN DESTINO
    SELECT COD_CARGOBASICO
    INTO LV_CARGOBASICO_DEST
    FROM TA_PLANTARIF
    WHERE COD_PLANTARIF=LV_PLANTARIF_DEST;

    -- OBTENER CARGO BASICO DEL PLAN ORIGEN
    SELECT IMP_CARGOBASICO
    INTO LN_IMPCARGO_ORIGEN
    FROM TA_CARGOSBASICO
    WHERE COD_CARGOBASICO= LV_CARGOBASICO_ORIGEN
    AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

    -- OBTENER CARGO BASICO DEL PLAN DESTINO
    SELECT IMP_CARGOBASICO
    INTO LN_IMPCARGO_DESTINO
    FROM TA_CARGOSBASICO
    WHERE COD_CARGOBASICO= LV_CARGOBASICO_DEST
    AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
    
    IF LN_IMPCARGO_ORIGEN > LN_IMPCARGO_DESTINO THEN
    
        SELECT COD_PROCESO INTO LV_CODPROCESO FROM GAD_PROCESOS_PERFILES WHERE NOM_PERFIL_PROCESO = 'PER_PL_CAMBIO_PLAN_MAY_MEN';
    
        BEGIN
    
            IF (LV_USUARIO = '') OR (LV_USUARIO IS NULL) THEN
                        
                SELECT A.COD_PROCESO
                INTO LV_AUX
                FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
                WHERE B.NOM_USUARIO  = USER
                AND   A.COD_GRUPO    = B.COD_GRUPO
                AND   A.COD_PROCESO  = LV_CODPROCESO
                AND ROWNUM     = 1;
            
            ELSE
              
                SELECT A.COD_PROCESO
                INTO LV_AUX
                FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
                WHERE B.NOM_USUARIO  = LV_USUARIO
                AND   A.COD_GRUPO    = B.COD_GRUPO
                AND   A.COD_PROCESO  = LV_CODPROCESO
                AND ROWNUM     = 1;
                
            END IF;
	
        EXCEPTION
	        WHEN NO_DATA_FOUND THEN
	        LV_AUX:=NULL;
	    END;

	    IF LV_AUX IS NOT NULL THEN
        
            SV_RESULTADO := 'TRUE';
        
        ELSE
    
            SV_RESULTADO := 'FALSE';
            SV_MENSAJE   := 'USUARIO SIN PERMISOS PARA REALIZAR CAMBIO DE PLAN DE MAYOR A MENOR VALOR DEL CARGO B¡SICO, POR FAVOR CONSULTAR CON UN SUPERVISOR O DIRIGIRSE A UNA OFICINA DE MOVISTAR';
        
	    END IF;
    
    ELSE
    
        SV_RESULTADO := 'TRUE';    
    
    END IF;

EXCEPTION
    
     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_PERM_CAMBPLAN_MAYMEN_PR : NO SE PUEDE VALIDAR ACCESO PARA MIGRACION DE MAYOR A MENOR CARGO';
          SV_RESULTADO := 'FALSE';

END PV_VAL_PERM_CAMBPLAN_MAYMEN_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_PERM_MIGR_PLANTARIF_PR(
                                   EV_PARAM_ENTRADA IN  VARCHAR2,
                                   SV_RESULTADO     OUT NOCOPY VARCHAR2,
                                   SV_MENSAJE       OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
)
 /*
<DocumentaciÛn
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VAL_PERM_MIGR_PREP_PR"
      Lenguaje="PL/SQL"
      Fecha="17-05-2011"
      VersiÛn="1.0"
      DiseÒador="EVERIS"
      Programador="EVERIS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <DescripciÛn> PERMITE VALIDAR PERMISO DE ACCESO DEL USUARIO PARA REALIZAR UN CAMBIO BAJA OPTA PREPAGO</DescripciÛn>
      <Par·metros>
         <ENTRADA>
              <PARAM NOM="EV_param_entrada" TIPO="VARCHAR2"> PARAMETROS DE ENTRADA PARA LA VALIDACION</PARAM>
         </ENTRADA>
         <Salida>
            <param nom="SV_RESULTADO"  Tipo="VARCHAR2" >INDICA SI LA EJECUCION FUE CORRECTA</param>
            <param nom="SV_MENSAJE"  Tipo="VARCHAR2" >MENSAJE DE ERROR RETORNADO</param>
         </Salida>
      </Par·metros>
   </Elemento>
</DocumentaciÛn>
*/
IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
    
    ---- parametros reales de entrada --------------
    
    
    LV_CODPROCESO  GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    
    LV_AUX   		 GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;
    ------------------------------------------------    
    LN_ABONADO      GA_ABOCEL.NUM_ABONADO%TYPE;
    LV_COD_OS       CI_TIPORSERV.COD_OS%TYPE;
    LV_USUARIO     	GE_SEG_GRPUSUARIO.NOM_USUARIO%TYPE;
    LV_CodPTarifNuevo TA_PLANTARIF.COD_PLANTARIF%TYPE;
    
    
    LV_CodPTarifOrigen TA_PLANTARIF.COD_PLANTARIF%TYPE;
        
    LV_TipCodPlanOrigen  TA_PLANTARIF.COD_TIPLAN%TYPE;
    LV_TipCodPlanDest    TA_PLANTARIF.COD_TIPLAN%TYPE;
    LV_NomPerfilProc     GAD_PROCESOS_PERFILES.NOM_PERFIL_PROCESO%TYPE;
    
    LV_MesjError         GA_TRANSACABO.DES_CADENA%TYPE;

BEGIN

    SV_MENSAJE   := 'OK';
    SV_RESULTADO := 'TRUE';

    GE_PAC_ARREGLOPR.GE_PR_RETORNAARREGLO(EV_PARAM_ENTRADA, STRING);


    LN_ABONADO := TO_NUMBER(string(5));
    LV_COD_OS  := string(9);
    LV_USUARIO := STRING(10);
    LV_CodPTarifNuevo  :=STRING(12);
    
    
       
        --  obtenemos el plantarifario (origen)  del abonado
        Select cod_plantarif into LV_CodPTarifOrigen
        from ga_abocel
        where num_abonado = LN_ABONADO
        and cod_situacion not in ('BAA', 'BAP');
    
    
  
        SELECT COD_TIPLAN INTO LV_TipCodPlanOrigen
        FROM TA_PLANTARIF
        where cod_plantarif = LV_CodPTarifOrigen;
    

        SELECT COD_TIPLAN INTO LV_TipCodPlanDest
        FROM TA_PLANTARIF
        where cod_plantarif = LV_CodPTarifNuevo ;

        if LV_TipCodPlanOrigen = 2 and  LV_TipCodPlanDest = 2 then -- POSPAGO - POSPAGO
            
            LV_MesjError := 'USUARIO SIN PERMISOS PARA MIGRACI”N A POSTPAGO, EL CASO DEBE DERIVARSE A UN SUPERVISOR';
            
            IF LV_COD_OS = 10503 THEN
            
                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_POST_POST';
                
            ELSIF (LV_COD_OS = 10020 OR LV_COD_OS = 10530 OR LV_COD_OS = 10539 OR LV_COD_OS = 10508) THEN -- EQUIVALE A COD_OS 40006 Y 40008
            
                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_POS_POS_CPU';
                
            END IF;
            
        elsif LV_TipCodPlanOrigen = 2 and  LV_TipCodPlanDest = 3 then -- POSPAGO - HIBRIDO

            LV_MesjError := 'USUARIO SIN PERMISOS PARA MIGRACI”N A HIBRIDO, EL CASO DEBE DERIVARSE A UN SUPERVISOR';
                            
            IF LV_COD_OS = 10503 THEN
            
                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_POST_HIB';

            
            ELSIF (LV_COD_OS = 10020 OR LV_COD_OS = 10530 OR LV_COD_OS = 10539 OR LV_COD_OS = 10508) THEN
            
                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_POS_HIB_CPU';
                

            END IF;
            
        elsif LV_TipCodPlanOrigen = 3 and  LV_TipCodPlanDest = 2 then -- HIBRIDO - POSPAGO
            
            LV_MesjError := 'USUARIO SIN PERMISOS PARA MIGRACI”N A POSTPAGO, EL CASO DEBE DERIVARSE A UN SUPERVISOR';
        
            IF LV_COD_OS = 10503 THEN
            
                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_HIB_POST';
                
            ELSIF (LV_COD_OS = 10020 OR LV_COD_OS = 10530 OR LV_COD_OS = 10539 OR LV_COD_OS = 10508) THEN
            
                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_HIB_POS_CPU';
                
            END IF;
            
        elsif LV_TipCodPlanOrigen = 3 and  LV_TipCodPlanDest = 3 then -- HIBRIDO - HIBRIDO
            
            LV_MesjError := 'USUARIO SIN PERMISOS PARA MIGRACI”N A HIBRIDO, EL CASO DEBE DERIVARSE A UN SUPERVISOR';
        
            IF LV_COD_OS = 10503 THEN
            
                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_HIB_HIB';
                
            ELSIF (LV_COD_OS = 10020 OR LV_COD_OS = 10530 OR LV_COD_OS = 10539 OR LV_COD_OS = 10508) THEN

                LV_NomPerfilProc := 'PER_PL_CAMBIO_PLAN_HIB_HIB_CPU';

            END IF;
            
        end if;
  
    
    IF LV_NomPerfilProc IS NOT NULL THEN

        SELECT COD_PROCESO INTO LV_CODPROCESO 
        FROM GAD_PROCESOS_PERFILES 
        WHERE NOM_PERFIL_PROCESO =LV_NomPerfilProc ;
        
    

        BEGIN
        
              IF (LV_USUARIO = '') OR (LV_USUARIO IS NULL) THEN
                  SELECT A.COD_PROCESO
                  INTO LV_AUX
                  FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
                  WHERE B.NOM_USUARIO  = USER
                  AND   A.COD_GRUPO    = B.COD_GRUPO
                  AND   A.COD_PROCESO  = LV_CODPROCESO
                  AND ROWNUM     = 1;
              ELSE
                  SELECT A.COD_PROCESO
                  INTO LV_AUX
                  FROM  GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
                  WHERE B.NOM_USUARIO  = LV_USUARIO
                  AND   A.COD_GRUPO    = B.COD_GRUPO
                  AND   A.COD_PROCESO  = LV_CODPROCESO
                  AND ROWNUM     = 1;
              END IF;
    	
        EXCEPTION
              WHEN NO_DATA_FOUND THEN
              SV_RESULTADO := 'FALSE';
              SV_MENSAJE   := LV_MesjError;
        END;
        

        IF LV_AUX IS NOT NULL THEN
            
            SV_RESULTADO := 'TRUE';
            
        ELSE
        
            SV_RESULTADO := 'FALSE';
            SV_MENSAJE   := LV_MesjError;
            
        END IF;
        
    ELSE
    
        SV_RESULTADO := 'TRUE';              
        
    END IF;      

EXCEPTION
    
     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VAL_PERM_MIGR_PLANTARIF_PR : NO SE PUEDE VALIDAR ACCESO PARA MIGRACION DE PLAN TARIFARIO';
          SV_RESULTADO := 'FALSE';

END PV_VAL_PERM_MIGR_PLANTARIF_PR;
---------------------------------------------------------------------------------------------------------------------------------------
END Pv_restriccion_pg; 
/
SHOW ERRORS
