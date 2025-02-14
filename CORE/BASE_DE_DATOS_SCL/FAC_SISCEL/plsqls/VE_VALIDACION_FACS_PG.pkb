CREATE OR REPLACE PACKAGE BODY            VE_validacion_FACS_PG IS

PROCEDURE VE_validaArticulo_pr(EV_codarticulo   IN          al_articulos.cod_articulo%TYPE,
                               SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_validaArticulo_pr"
           Lenguaje="PL/SQL"
           Fecha="11-11-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Validacion Articulo /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_codarticulo" Tipo="STRING">Codigo del articulo</param>
     </Entrada>
     <Salida>
      <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,' cod_articulo =' || EV_codarticulo , 'WEB', 'ECUCOL_006', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

    IF SN_cod_retornoau IS NULL THEN
       VE_validaequipo_PG.ve_valida_articulo_pr(EV_codarticulo,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
          RAISE ERR_MOAUDITORIA;
       END IF;

    ELSE
       RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END VE_validaArticulo_pr;


PROCEDURE VE_validaCliente_pr(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                              EV_numident      IN  ge_clientes.num_ident%TYPE,
                              SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_validaCliente_pr"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Validacion cliente moroso-vetado /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente a verificar</param>
      <param nom="EV_numident" Tipo="STRING">Numero de identidad del cliente a verificar</param>
     </Entrada>
     <Salida>
      <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,'Tip_ident =' || EV_tipident || ' Num_ident =' || EV_numident , 'WEB', 'ECUCOL_002', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

    IF SN_cod_retornoau IS NULL THEN
       ve_validacliente_pg.ve_valida_pr(EV_tipident,EV_numident,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
          RAISE ERR_MOAUDITORIA;
       END IF;

    ELSE
       RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END VE_validaCliente_pr;

PROCEDURE VE_validaVendedor_pr(EV_codvendealer  IN   VE_validavendedor_PG.cod_vendealer,
                               EV_canalvendedor IN   VARCHAR2,
                               SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_validaVendedor_pr"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Validacion Vendedor  /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_codvendealer" Tipo="STRING">Codigo Vendedor</param>
      <param nom="EV_canalvendedor" Tipo="STRING">Canal Vendedor</param>
     </Entrada>
     <Salida>
      <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,'Cod vendedor =' || EV_codvendealer || ' Canal Vendedor =' || EV_canalvendedor , 'WEB', 'ECUCOL_001', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

    IF SN_cod_retornoau IS NULL THEN
       VE_validavendedor_PG.ve_valida_pr(EV_codvendealer,EV_canalvendedor,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
          RAISE ERR_MOAUDITORIA;
       END IF;

    ELSE
       RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END VE_validaVendedor_pr;

PROCEDURE VE_validaEquipoICC_pr(EV_icc           IN ga_aboamist.num_serie%TYPE,
                                EN_codvendealer  IN  ve_vendealer.cod_vendealer%TYPE,
                                EV_canalvendedor IN  VARCHAR2,
                                SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_validaEquipoICC_pr"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Validacion equipo ICC /Descripción>
    <Parámetros>
     <Entrada>
      <param nom="EV_icc"           Tipo="STRING">Serie a buscar en listas negras</param>
      <param nom="EN_codvendealer " Tipo="STRING">Codigo del vendedor</param>
      <param nom="EV_canalvendedor" Tipo="STRING">canal del vendedor</param>
     </Entrada>
     <Salida>
      <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
      <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,' icc =' || EV_icc || ',' ||EN_codvendealer || ',' || EV_canalvendedor , 'WEB', 'ECUCOL_003', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

    IF SN_cod_retornoau IS NULL THEN
       ve_validaequipo_pg.ve_valida_icc_pr(EV_icc,EN_codvendealer,EV_canalvendedor,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
          RAISE ERR_MOAUDITORIA;
       END IF;

    ELSE
       RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END VE_validaEquipoICC_pr;

PROCEDURE VE_validaEquipoIMEI_pr(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                                 EN_cod_vendedor     IN ve_vendealer.cod_vendealer%TYPE,
                                 EV_cod_canal        IN VARCHAR2,
                                 EV_cod_procediencia IN CHAR,
                                 SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE)
AS
/*
<Documentación TipoDoc = "procedure">
 <Elemento Nombre = "VE_validaEquipoIMEI_pr"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versión="1.0.0"
           Diseñador="Vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA/Retorno>
   <Descripción> Validacion equipo IMEI /Descripción>
    <Parámetros>
     <Entrada>
            <param nom="EV_num_imei        " Tipo="CARACTER">numero del imei</param>
            <param nom="EN_cod_vendedor    " Tipo="NUMERICO">Código del vendedor</param
            <param nom="EV_cod_canal       " Tipo="CARACTER">Canal del vendedor</param>
            <param nom="EV_cod_procediencia" Tipo="CARACTER">procedencia equipo</param>
     </Entrada>
     <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="STRING">Mensaje de Retorno</param>
     </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
    ERR_AGAUDITORIA    EXCEPTION;
    ERR_MOAUDITORIA    EXCEPTION;
    nsNEvento          ge_errores_pg.Evento;
    SN_cod_retornoau   ge_errores_pg.coderror;
    SV_mens_retornoau  ge_errores_pg.msgerror;
    SN_num_eventoau    ge_errores_pg.Evento;
    SN_num_transaccion ge_auditoria_to.num_ticket%TYPE;
BEGIN

    ge_auditoria_pg.ge_agregaauditoria_pr( SN_num_transaccion, 'INICI', USER, NULL,'num_imei ='|| EV_num_imei ||',cod_vendedor ='|| EN_cod_vendedor ||',cod_canal =' || EV_cod_canal || ',cod_procediencia ='|| EV_cod_procediencia, 'WEB', 'ECUCOL_004', NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

    IF SN_cod_retornoau IS NULL THEN
       VE_validaequipo_PG.VE_valida_imei_PR(EV_num_imei,EN_cod_vendedor,EV_cod_canal,EV_cod_procediencia,SN_cod_retorno, SV_mens_retorno, nsNEvento);
       ge_auditoria_pg.ge_modificaauditoria_pr( 'TERMI', nsNEvento, SN_cod_retorno, SN_num_transaccion, NULL, NULL, SN_cod_retornoau, SV_mens_retornoau, SN_num_eventoau);

       IF SN_cod_retornoau IS NOT NULL THEN
          RAISE ERR_MOAUDITORIA;
       END IF;

    ELSE
       RAISE ERR_AGAUDITORIA;
    END IF;

    EXCEPTION

    WHEN ERR_AGAUDITORIA THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

    WHEN ERR_MOAUDITORIA  THEN
        SN_cod_retorno  := SN_cod_retornoau;
        SV_mens_retorno := SV_mens_retornoau;

END VE_validaEquipoIMEI_pr;

END VE_validacion_FACS_PG;
/
SHOW ERRORS
