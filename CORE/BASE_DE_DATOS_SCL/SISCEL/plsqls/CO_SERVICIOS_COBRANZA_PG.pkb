CREATE OR REPLACE PACKAGE BODY Co_Servicios_Cobranza_Pg
AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE co_interfaz_web_pr (
        EN_codcliente     IN         NUMBER  ,
        EN_importepago    IN         NUMBER  ,
        EN_fecpago        IN         VARCHAR2,
        EN_codbanco       IN         VARCHAR2,
        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
) IS
/*<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "CO_INTERFAZ_WEB_PR"
      Fecha modificacion=" "
      Fecha creacion="14-06-2006"
      Programador="Soporte RyC"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Valida si un Abonado tiene Servicios de la Plataforma Atlantida para insertar Pago en tabla CO_INTERFAZ_PAGOS</Descripcion>
      <Parametros>
         <Entrada>
                                <param nom="EN_codcliente"  Tipo="NUMERICO">Código del Cliente que realiza el Pago </param>
                                <param nom="EN_importepago" Tipo="NUMERICO">Monto pagado </param>
                                <param nom="EN_fecpago"     Tipo="CARACTER">Fecha del pago </param>
                                <param nom="EN_codbanco"    Tipo="CARACTER">Codigo del banco </param>
         </Entrada>
         <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
                <param nom="SV_mens_retorno"Tipo="CARACTER">Mensaje de Retorno</param>
                <param nom="SN_num_evento"  Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion
    14.06.2006 Se crea package por incidencia CO-200606070176 >
*/

   sSql                ge_errores_pg.vQuery;
   error_cliente       EXCEPTION;
   error_montopago     EXCEPTION;
   error_banco         EXCEPTION;
   error_ejecucion     EXCEPTION;
   LV_retorno          NUMBER;
   LV_nom_proceso      VARCHAR2(20);
   LV_des_error            ge_errores_pg.DesEvent;
   TN_coderror         CO_INTERFAZ_PAGOS.COD_ERROR%TYPE        := NULL;
   TV_codestado        CO_INTERFAZ_PAGOS.COD_ESTADO%TYPE       := NULL;
   TV_emprecaudadora   CO_INTERFAZ_PAGOS.EMP_RECAUDADORA%TYPE  := 'WEB';
   TV_cajarecauda      CO_INTERFAZ_PAGOS.COD_CAJA_RECAUDA%TYPE := '01' ;
   TV_sersolicitado    CO_INTERFAZ_PAGOS.SER_SOLICITADO%TYPE   := 'REX';
   TN_numtransaccion   CO_INTERFAZ_PAGOS.NUM_TRANSACCION%TYPE;
   TV_tiptransaccion   CO_INTERFAZ_PAGOS.TIP_TRANSACCION%TYPE  := 'K';
   TV_subtiptransac    CO_INTERFAZ_PAGOS.SUB_TIP_TRANSAC%TYPE  := 'O';
   TN_tipservicio      CO_INTERFAZ_PAGOS.COD_SERVICIO%TYPE     := 2;
   TN_numcelular       CO_INTERFAZ_PAGOS.NUM_CELULAR%TYPE      := 0;
   TN_folioctc         CO_INTERFAZ_PAGOS.NUM_FOLIOCTC%TYPE     := 0;
   TV_numident         CO_INTERFAZ_PAGOS.NUM_IDENT%TYPE        := '0000';
   TN_tipvalor         CO_INTERFAZ_PAGOS.TIP_VALOR%TYPE        := 12;
   TN_numdocumento     CO_INTERFAZ_PAGOS.NUM_DOCUMENTO%TYPE    := 1;

BEGIN
    LV_nom_proceso := 'co_interfaz_web_pr';

    -- Genera numero de transaccion
    sSql := 'SELECT CO_SEQ_TRANSACINT.NEXTVAL INTO TN_numtransaccion FROM dual = ' || EN_codcliente;
    SELECT CO_SEQ_TRANSACINT.NEXTVAL INTO TN_numtransaccion
      FROM dual;

    --Valida Codigo del Cliente
    sSql := 'SELECT COUNT(1) INTO LV_retorno FROM ge_clientes clie WHERE  clie.cod_cliente = ' || EN_codcliente;
    SELECT COUNT(1) INTO LV_retorno
      FROM ge_clientes clie
     WHERE clie.cod_cliente = TO_NUMBER(EN_codcliente);

        IF LV_retorno = 0 THEN
        TN_coderror  := 501;
        TV_codestado := 'PEN';
        /*  registrar pago con estado PENDIENTE*/
            IF NOT CO_GRABAPAGO_FN(TV_emprecaudadora, TV_cajarecauda   , TV_sersolicitado ,
                               EN_fecpago       , TN_numtransaccion, TV_tiptransaccion,
                               TV_subtiptransac , TN_tipservicio   , EN_codcliente    ,
                               TN_numcelular    , EN_importepago   , TN_folioctc      ,
                               TV_numident      , TN_tipvalor      , TN_numdocumento  ,
                               EN_codbanco      , TV_codestado     , TN_coderror      ,
                               SN_cod_retorno   , SV_mens_retorno  , SN_num_evento  ) THEN
           RAISE error_ejecucion;
                END IF;
            RAISE error_cliente;
        END IF;

    --Valida Importe del Pago
    sSql := 'Valida importe del pago del cliente = ' || EN_codcliente;
    IF TO_NUMBER(EN_importepago) <= 0 THEN
                TN_coderror := 503;
        TV_codestado := 'PEN';
        /*  registrar pago con estado PENDIENTE*/
            IF NOT CO_GRABAPAGO_FN(TV_emprecaudadora, TV_cajarecauda   , TV_sersolicitado ,
                               EN_fecpago       , TN_numtransaccion, TV_tiptransaccion,
                               TV_subtiptransac , TN_tipservicio   , EN_codcliente    ,
                               TN_numcelular    , EN_importepago   , TN_folioctc      ,
                               TV_numident      , TN_tipvalor      , TN_numdocumento  ,
                               EN_codbanco      , TV_codestado     , TN_coderror      ,
                               SN_cod_retorno   , SV_mens_retorno  , SN_num_evento  ) THEN
           RAISE error_ejecucion;
                END IF;
                RAISE error_montopago;
    END IF;

    --Valida Código del Banco
    sSql := 'SELECT COUNT(1) INTO LV_retorno FROM ge_bancos ban WHERE  ban.cod_banco = ' || EN_codbanco;
    SELECT COUNT(1) INTO LV_retorno
      FROM ge_bancos ban
         WHERE ban.cod_banco = EN_codbanco;

        IF LV_retorno = 0 THEN
            TN_coderror  := 505;
        TV_codestado := 'PEN';
        /*  registrar pago con estado PENDIENTE*/
            IF NOT CO_GRABAPAGO_FN(TV_emprecaudadora, TV_cajarecauda   , TV_sersolicitado ,
                               EN_fecpago       , TN_numtransaccion, TV_tiptransaccion,
                               TV_subtiptransac , TN_tipservicio   , EN_codcliente    ,
                               TN_numcelular    , EN_importepago   , TN_folioctc      ,
                               TV_numident      , TN_tipvalor      , TN_numdocumento  ,
                               EN_codbanco      , TV_codestado     , TN_coderror      ,
                               SN_cod_retorno   , SV_mens_retorno  , SN_num_evento  ) THEN
           RAISE error_ejecucion;
                END IF;
            RAISE error_banco;
        END IF;

    --Obtiene Caja de Oficina NT
    sSql := 'SELECT emp.cod_caja INTO TV_cajarecauda FROM co_empresas_rex emp WHERE  emp_recaudadora = ' || TV_emprecaudadora;
    SELECT emp.cod_caja INTO TV_cajarecauda
      FROM co_empresas_rex emp
     WHERE emp_recaudadora = TV_emprecaudadora;

    /*  registrar pago */
    IF NOT CO_GRABAPAGO_FN(TV_emprecaudadora, TV_cajarecauda   , TV_sersolicitado ,
                           EN_fecpago       , TN_numtransaccion, TV_tiptransaccion,
                           TV_subtiptransac , TN_tipservicio   , EN_codcliente    ,
                           TN_numcelular    , EN_importepago   , TN_folioctc      ,
                           TV_numident      , TN_tipvalor      , TN_numdocumento  ,
                           EN_codbanco      , TV_codestado     , TN_coderror      ,
                           SN_cod_retorno   , SV_mens_retorno  , SN_num_evento  ) THEN
       RAISE error_ejecucion;
        END IF;

EXCEPTION
   WHEN error_montopago THEN
      SN_cod_retorno := 157;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error  := LV_nom_proceso||'('|| EN_codcliente||','||CV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, LV_nom_proceso, sSql, SQLCODE, LV_des_error );

   WHEN error_cliente THEN
      SN_cod_retorno := 225;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error  := LV_nom_proceso||'('|| EN_codcliente||','||CV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, LV_nom_proceso, sSql, SQLCODE, LV_des_error );

   WHEN error_banco THEN
      SN_cod_retorno := 779;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error  := LV_nom_proceso||'('|| EN_codcliente||','||CV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, LV_nom_proceso, sSql, SQLCODE, LV_des_error );

   WHEN error_ejecucion THEN
      LV_des_error := LV_nom_proceso||'('|| EN_codcliente||','||CV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, LV_nom_proceso, sSql, SQLCODE, LV_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error  := LV_nom_proceso||'('|| EN_codcliente||','||CV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, LV_nom_proceso, sSql, SQLCODE, LV_des_error );

END co_interfaz_web_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION co_grabapago_fn (
      EN_emprecaudadora  IN         CO_INTERFAZ_PAGOS.EMP_RECAUDADORA%TYPE,
      EN_cajarecauda     IN         CO_INTERFAZ_PAGOS.COD_CAJA_RECAUDA%TYPE,
      EN_sersolicitado   IN         CO_INTERFAZ_PAGOS.SER_SOLICITADO%TYPE,
      EN_fecpago         IN         VARCHAR2,
      EN_numtransaccion  IN         CO_INTERFAZ_PAGOS.NUM_TRANSACCION%TYPE,
      EN_tiptransaccion  IN         CO_INTERFAZ_PAGOS.TIP_TRANSACCION%TYPE,
      EN_subtiptransac   IN         CO_INTERFAZ_PAGOS.SUB_TIP_TRANSAC%TYPE,
      EN_tipservicio     IN         CO_INTERFAZ_PAGOS.COD_SERVICIO%TYPE,
      EN_codcliente      IN         CO_INTERFAZ_PAGOS.COD_CLIENTE%TYPE,
      EN_numcelular      IN         CO_INTERFAZ_PAGOS.NUM_CELULAR%TYPE,
      EN_importepago     IN         CO_INTERFAZ_PAGOS.IMP_PAGO%TYPE,
      EN_folioctc        IN         CO_INTERFAZ_PAGOS.NUM_FOLIOCTC%TYPE,
      EN_numident        IN         CO_INTERFAZ_PAGOS.NUM_IDENT%TYPE,
      EN_tipvalor        IN         CO_INTERFAZ_PAGOS.TIP_VALOR%TYPE,
      EN_numdocumento    IN         CO_INTERFAZ_PAGOS.NUM_DOCUMENTO%TYPE,
      EN_codbanco        IN         CO_INTERFAZ_PAGOS.COD_BANCO%TYPE,
      EN_codestado       IN         CO_INTERFAZ_PAGOS.COD_ESTADO%TYPE,
      EN_coderror        IN         CO_INTERFAZ_PAGOS.COD_ERROR%TYPE,
      SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
)
RETURN BOOLEAN
/*<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "CO_GRABAPAGO_FN"
      Lenguaje="PL/SQL"
      Fecha="15-06-2006"
      Versión="1.0"
      Diseñador=""
      Programador="Soporte RyC"
      Ambiente Desarrollo="BD">
     <Retorno>BOOLEAN</Retorno>
      <Descripción>Registra pago en la tabla co_interfaz_pago</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_emprecaudadora"  Tipo="CARACTER">Codigo de Empresa Recaudadora</param>
            <param nom="EN_cajarecauda"     Tipo="NUMERICO">Codigo de Caja Recaudadora</param>
            <param nom="EN_sersolicitado"   Tipo="CARACTER">Servicio solicitado</param>
            <param nom="EN_fecpago"         Tipo="CARACTER">Fecha de Pago</param>
            <param nom="EN_numtransaccion"  Tipo="NUMERICO">Numero de transaccion</param>
            <param nom="EN_tiptransaccion"  Tipo="CARACTER">Tipo de transaccion</param>
            <param nom="EN_subtiptransac"   Tipo="CARACTER">Sub Tipo de transaccion</param>
            <param nom="EN_tipservicio"     Tipo="NUMERICO">Codigo de servicio</param>
            <param nom="EN_codcliente"      Tipo="NUMERICO">Codigo de cliente</param>
            <param nom="EN_numcelular"      Tipo="NUMERICO">Numero de celular</param>
            <param nom="EN_importepago"     Tipo="NUMERICO">Importe pago</param>
            <param nom="EN_folioctc"        Tipo="NUMERICO">Numero de folio CTC</param>
            <param nom="EN_numident"        Tipo="CARACTER">Numero de Identificacion</param>
            <param nom="EN_tipvalor"        Tipo="NUMERICO">Tipo de valor</param>
            <param nom="EN_numdocumento"    Tipo="NUMERICO">Numero de documento</param>
            <param nom="EN_codbanco"        Tipo="CARACTER">Codigo de banco</param>
            <param nom="EN_codestado"       Tipo="CARACTER">Codigo de estado de la transaccion</param>
            <param nom="EN_coderror"        Tipo="NUMERICO">Codigo de error de la transaccion</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación
    14.06.2006 Se crea package por incidencia CO-200606070176>
*/
AS
   error_ejecucion     EXCEPTION;
   LV_nom_proceso      VARCHAR2(20);
   sSql                ge_errores_pg.vQuery;
   LV_des_error            ge_errores_pg.DesEvent;


BEGIN
    LV_nom_proceso := 'co_grabapago_fn';
    SN_cod_retorno := '0';
    SN_num_evento  :=  0;
    SV_mens_retorno:= '0';

    --Inserta pago en la tabla co_interfaz_pago
    sSql := 'INSERT INTO CO_INTERFAZ_PAGOS ' || EN_codcliente;
    INSERT INTO CO_INTERFAZ_PAGOS
            (emp_recaudadora, cod_caja_recauda, ser_solicitado,
             fec_efectividad, num_transaccion , nom_usuarora  ,
             tip_transaccion, sub_tip_transac , cod_servicio  ,
             num_ejercicio  , cod_cliente     , num_celular   ,
             imp_pago       , num_folioctc    , num_ident     ,
             tip_valor      , num_documento   , cod_banco     ,
             cta_corriente  , cod_autoriza    , can_debe      ,
             mto_debe       , can_haber       , mto_haber     ,
             cod_estado     , cod_error       , num_compago   ,
             num_tarjeta    , cod_tipident    , pref_plaza )
    VALUES
            (EN_emprecaudadora        , EN_cajarecauda   , EN_sersolicitado ,
             TO_DATE(EN_fecpago, 'DD-MM-YYYY HH24:MI:SS'), EN_numtransaccion, 'COBRANZA',--USER,
             EN_tiptransaccion        , EN_subtiptransac , EN_tipservicio,
             TO_CHAR(TO_DATE(EN_fecpago, 'DD-MM-YYYY HH24:MI:SS'), 'YYYYMMDD'), TO_NUMBER(EN_codcliente), EN_numcelular,
             TO_NUMBER(EN_importepago), EN_folioctc      , EN_numident      ,
             EN_tipvalor              , EN_numdocumento  , EN_codbanco      ,
             NULL                     , NULL             , NULL             ,
             NULL                     , NULL             , NULL             ,
             EN_codestado             , EN_coderror      , NULL             ,
             NULL                     , NULL             , NULL  );

   COMMIT;
   RETURN TRUE;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := LV_nom_proceso||'('|| EN_codcliente||','||CV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, LV_nom_proceso, sSql, SQLCODE, LV_des_error );
      RETURN FALSE;

END co_grabapago_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION co_version_fn RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función>
   <Elemento
      Nombre = "CO_VERSION_FN"
      Lenguaje="PL/SQL"
      Fecha="14-06-2004"
      Versión="La del package"
      Diseñador=""
      Programador="Soporte RyC"
      Ambiente Desarrollo="BD">
      <Retorno>Versión y subversión del package</Retorno>
      <Descripción>Mostrar versión y subversión del package</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación
    14.06.2006 Se crea package por incidencia CO-200606070176>
*/
IS
BEGIN
   RETURN('Version : '||CV_version||' <--> SubVersion : '||CV_subversion);
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE CO_getDescCodigoABC_PR(EV_codABC       IN  co_abc.cod_abc%TYPE,
                                                                         SV_desCodigoABC OUT NOCOPY co_abc.des_abc%TYPE,
                                                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "CO_getDescCodigoABC_PR"
                        Lenguaje="PL/SQL"
                        Fecha="17-05-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Retorna descripcion del codigo ABC
                </Retorno>
                <Descripción>
                                  Retorna descripcion del codigo ABC
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codABC" Tipo="STRING"> codigo ABC </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_desCodigoABC" Tipo="STRING"> descripcion codiogo ABC </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='SELECT a.des_abc '
                        || 'FROM co_abc a '
                        || 'WHERE a.cod_abc = ' || EV_codABC;

                SELECT a.des_abc
                INTO   SV_desCodigoABC
                FROM   co_abc a
                WHERE  a.cod_abc = EV_codABC;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := cv_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:CO_servicios_cobranza_PG.CO_getDescCodigoABC_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'CO_servicios_cobranza_PG.CO_getDescCodigoABC_PR', LV_Sql, SQLCODE, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := cv_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:CO_servicios_cobranza_PG.CO_getDescCodigoABC_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'CO_servicios_cobranza_PG.CO_getDescCodigoABC_PR', LV_Sql, SQLCODE, LV_desError );
        END CO_getDescCodigoABC_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE CO_getDescCodigo123_PR(EV_cod123       IN  co_123.cod_123%TYPE,
                                                                         SV_desCodigo123 OUT NOCOPY co_123.des_123%TYPE,
                                                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "CO_getDescCodigo123_PR"
                        Lenguaje="PL/SQL"
                        Fecha="17-05-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Retorna descripcion del codigo 123
                </Retorno>
                <Descripción>
                                  Retorna descripcion del codigo 123
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_cod123" Tipo="STRING"> codigo 123 </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_desCodigo123 Tipo="STRING"> descripcion codiogo 123 </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='SELECT a.des_123 '
                        || 'FROM co_123 a '
                        || 'WHERE a.cod_123 = ' || EV_cod123;

                SELECT a.des_123
                INTO SV_desCodigo123
                FROM co_123 a
                WHERE a.cod_123 = EV_cod123;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                SN_codRetorno := 1;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := cv_error_no_clasif;
                                END IF;
                                LV_desError  := 'NO_DATA_FOUND:CO_servicios_cobranza_PG.CO_getDescCodigo123_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                                'CO_servicios_cobranza_PG.CO_getDescCodigo123_PR', LV_Sql, SQLCODE, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := cv_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:CO_servicios_cobranza_PG.CO_getDescCodigo123_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'CO_servicios_cobranza_PG.CO_getDescCodigo123_PR', LV_Sql, SQLCODE, LV_desError );
        END CO_getDescCodigo123_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE CO_insPagoAutomatico_PR(EN_codcliente   IN  co_unipac.cod_cliente%TYPE,
                                                                          EV_codbanco     IN  co_unipac.cod_banco%TYPE,
                                                                          EN_numtelefono  IN  co_unipac.num_telefono%TYPE,
                                                                          EV_codzona      IN  co_unipac.cod_zona%TYPE,
                                                                          EV_codcentral   IN  co_unipac.cod_central%TYPE,
                                                                          EN_codbcoi      IN  co_unipac.cod_bcoi%TYPE,
                                                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "CO_insPagoAutomatico_PR"
                        Lenguaje="PL/SQL"
                        Fecha="06-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Inserta pago automatico
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_codcliente"   Tipo="NUMBER"> codigo cliente </param>
                           <param nom="EV_codbanco"     Tipo="STRING"> codigo banco </param>
                           <param nom="EN_numtelefono"  Tipo="NUMBER"> numero telefono </param>
                           <param nom="EV_codzona"      Tipo="STRING"> codigo zona </param>
                           <param nom="EV_codcentral"   Tipo="STRING"> codigo central </param>
                           <param nom="EN_codbcoi"      Tipo="NUMBER"> codigo bcoi </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='INSERT INTO co_unipac(cod_cliente, '
                         || 'cod_banco, '
                         || 'num_telefono, '
                         || 'cod_zona, '
                         || 'cod_central, '
                         || 'cod_bcoi) '
                         || 'VALUES ('||EN_codcliente||', '
                         || EV_codbanco||','
                         || EN_numtelefono||','
                         || EV_codzona||','
                         || EV_codcentral||','
                         || EN_codbcoi||')';

                INSERT INTO co_unipac(cod_cliente,
                                                          cod_banco,
                                                          num_telefono,
                                                          cod_zona,
                                                          cod_central,
                                                          cod_bcoi)
                VALUES (EN_codcliente,
                                EV_codbanco,
                                EN_numtelefono,
                                EV_codzona,
                                EV_codcentral,
                                EN_codbcoi);

        EXCEPTION
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := cv_error_no_clasif;
                                END IF;
                                LV_desError  := 'OTHERS:CO_servicios_cobranza_PG.CO_insPagoAutomatico_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'CO_servicios_cobranza_PG.CO_insPagoAutomatico_PR', LV_Sql, SQLCODE, LV_desError );
        END CO_insPagoAutomatico_PR;

---------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE CO_ValidaTarjeta_PR(
                              EV_TIP_TARJETA  IN GE_CLIENTES.COD_TIPTARJETA%TYPE, 
                              EV_NUM_TARJETA  IN GE_CLIENTES.NUM_TARJETA%TYPE,
                              SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
 



        LV_desError ge_errores_pg.desevent;
        LV_sql          ge_errores_pg.vquery;
        LV_cadena   VARCHAR2(100); 
        LA_arreglo VE_INTERMEDIARIO_PG.tipoArray := VE_INTERMEDIARIO_PG.tipoArray();
        
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;
                
                LV_sql:='SELECT CO_VALIDATARJETA_PG.CO_VALIDATARJETA_FN(' || EV_TIP_TARJETA || ', ' ||  EV_NUM_TARJETA || ') FROM DUAL';
                
                SELECT CO_VALIDATARJETA_PG.CO_VALIDATARJETA_FN(EV_TIP_TARJETA,EV_NUM_TARJETA) 
                INTO LV_cadena
                FROM DUAL;
                
                
                LA_arreglo := VE_INTERMEDIARIO_PG.VE_descompone_cadena_FN(LV_cadena,'|', SN_codRetorno, SV_menRetorno, SN_numEvento);
                --4 valores 
                IF LA_arreglo(1)<> '0' THEN
                   SN_codRetorno:=514;
                   SV_menRetorno:=UPPER(LA_arreglo(4));  
                END IF; 
        
        EXCEPTION
                WHEN OTHERS THEN
                     SN_codRetorno := 514;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                        SV_menRetorno := 'ERROR AL VALIDAR TARJETA DE CREDITO';
                     END IF;
                     LV_desError  := 'OTHERS:CO_servicios_cobranza_PG.CO_ValidaTarjeta_PR;- ' || SQLERRM;
                     SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                     'CO_servicios_cobranza_PG.CO_ValidaTarjeta_PR', LV_Sql, SQLCODE, LV_desError );
        END CO_ValidaTarjeta_PR;
----------------------------------------------------------------------------------------------------------------------------------------------------------


END Co_Servicios_Cobranza_Pg; 
/
SHOW ERRORS
