CREATE OR REPLACE PACKAGE Co_Servicios_Cobranza_Pg
/*
<Documentación
 TipoDoc = "Package">
 <Elemento
     Nombre = "CO_SERVICIOS_COBRANZA_PG"
     Lenguaje="PL/SQL"
     Fecha="14-06-2006"
     Versión="1.0"
     Diseñador=""
     Programador="Soporte RyC"
     Ambiente Desarrollo="BD">
         Modificacion="Se agregan PL por proyecto MIX_06003_G2_PV"
     <Retorno>NA</Retorno>
     <Descripción>Package que contiene servicios asociados al modulo de Recaudacion y Cobranza,  14.06.2006 Se crea por incidencia CO-200606070176</Descripción>
     <Parámetros>
        <Entrada>NA</Entrada>
        <Salida>NA</Salida>
     </Parámetros>
  </Elemento>
 </Documentación>
*/
IS
   CV_version            CONSTANT VARCHAR2(2) :='1';
   CV_subversion         CONSTANT VARCHAR2(2) :='0';
   cv_error_no_clasif    CONSTANT VARCHAR2(30):='Error no clasificado';
   cv_cod_modulo         CONSTANT VARCHAR2(2) :='CO';
   CV_comportamiento     CONSTANT VARCHAR2(2) :='SI';
   CV_MODULO_GA          CONSTANT VARCHAR2(2) := 'GA';
   CN_LARGOERRTEC        CONSTANT NUMBER      := 4000;
   CN_LARGODESC          CONSTANT NUMBER      := 2000;
   

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE co_interfaz_web_pr (
      EN_codcliente     IN         NUMBER,
      EN_importepago    IN         NUMBER,
      EN_fecpago        IN         VARCHAR2,
      EN_codbanco       IN         VARCHAR2,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento  );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
   ) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION co_version_fn RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE CO_getDescCodigoABC_PR(EV_codABC       IN  co_abc.cod_abc%TYPE,
                                                                         SV_desCodigoABC OUT NOCOPY co_abc.des_abc%TYPE,
                                                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE CO_getDescCodigo123_PR(EV_cod123       IN  co_123.cod_123%TYPE,
                                                                         SV_desCodigo123 OUT NOCOPY co_123.des_123%TYPE,
                                                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE CO_insPagoAutomatico_PR(EN_codcliente   IN  co_unipac.cod_cliente%TYPE,
                                                                          EV_codbanco     IN  co_unipac.cod_banco%TYPE,
                                                                          EN_numtelefono  IN  co_unipac.num_telefono%TYPE,
                                                                          EV_codzona      IN  co_unipac.cod_zona%TYPE,
                                                                          EV_codcentral   IN  co_unipac.cod_central%TYPE,
                                                                          EN_codbcoi      IN  co_unipac.cod_bcoi%TYPE,
                                                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE CO_ValidaTarjeta_PR(
                              EV_TIP_TARJETA  IN GE_CLIENTES.COD_TIPTARJETA%TYPE, 
                              EV_NUM_TARJETA  IN GE_CLIENTES.NUM_TARJETA%TYPE,
                              SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);
------------------------------------------------------------------------------------------------------------------------------------
END Co_Servicios_Cobranza_Pg; 
/
SHOW ERRORS
