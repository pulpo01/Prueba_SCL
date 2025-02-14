CREATE OR REPLACE PACKAGE ve_validaciones_clientes_pg IS

/*
<Documentación TipoDoc = "package"
 <Elemento Nombre = "VE_VALIDACIONES_CLIENTES_PG"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA</Retorno>
   <Descripción> Encabezado de VE_validacion_FACS_PG /Descripción>
    <Parámetros>
    </Parámetros>
 </Elemento>
</Documentación>
*/

  CV_version                CONSTANT  VARCHAR2(10):='1.0';
  CV_error_no_clasif        CONSTANT  VARCHAR2(30):='Error no clasificado';
  CV_codmodulo              CONSTANT  VARCHAR2(2):='GA';
  CV_nom_tabla              CONSTANT  ged_codigos.nom_tabla%TYPE:='DESBLOQUEO_PREPAGO';
  CV_nom_columna            CONSTANT  ged_codigos.nom_columna%TYPE:='PROCESO_EXITOSO';
  TYPE refcursor            IS REF CURSOR;
  CN_ARTCOMERCIALIZABLE_WEB CONSTANT  VARCHAR2(1):=1;
  CN_ESTADOSERIEOK          CONSTANT  VARCHAR2(1):=1;
  -- + Requerimiento Adicional 05.06.2008 - 11.06.2008
  CN_PRODUCTO               CONSTANT NUMBER       := 1;
  CN_TIPOSTOCKMERCDEALER    CONSTANT NUMBER       := 4; -- mercaderia dealer
  CN_USOPREPAGO             CONSTANT NUMBER       := 3; -- prepago
  CN_ERRORLEERPARAMETROS    CONSTANT NUMBER       := 802;
  CV_ERRORLEERPARAMETROS    CONSTANT VARCHAR2(34) := 'Error, al leer tabla de parametros';
  CN_ERRORNOTAPEDIDOWEB     CONSTANT NUMBER       := 803;
  CV_ERRORNOTAPEDIDOWEB     CONSTANT VARCHAR2(41) := 'Serie NO recepcionada por Nota Pedido Web';
  CN_ERRORNOFOUNDALSERIES   CONSTANT NUMBER       := 804;
  CV_ERRORNOFOUNDALSERIES   CONSTANT VARCHAR2(35) := 'Error, no encontro tipo stock y uso';
  CN_ERRORARTICULONOCOMERC  CONSTANT NUMBER       := 805;
  CV_ERRORARTICULONOCOMERC  CONSTANT VARCHAR2(60) := 'Serie no Corresponde a Articulo Comercializable por Web';
  CN_ERRORUSOPREPAGO        CONSTANT NUMBER       := 806;
  CV_ERRORUSOPREPAGO        CONSTANT VARCHAR2(33) := 'Error, Serie es de uso prepago';
  CN_SERIERESERVADA         CONSTANT NUMBER       := 807;
  CV_SERIERESERVADA        CONSTANT VARCHAR2(45) :=  'Error, la serie esta en un estado incorrecto';

  -- - Requerimiento Adicional 05.06.2008 - 11.06.2008

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Procedure ve_valida_cliente_moroso_pr(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                                      EV_numident      IN  ge_clientes.num_ident%TYPE,
                                      SN_Monto         OUT NOCOPY NUMBER,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_valida_imei_pr(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                            EN_cod_vendedor     IN ve_vendealer.cod_vendealer%TYPE,
                            EV_cod_canal        IN CHAR,
                            EV_cod_procediencia IN CHAR,
                            SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                            SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_validaciones_clientes_pg;
/
SHOW ERRORS
