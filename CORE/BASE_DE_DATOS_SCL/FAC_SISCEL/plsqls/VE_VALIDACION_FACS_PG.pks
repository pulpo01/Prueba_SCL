CREATE OR REPLACE PACKAGE            VE_validacion_FACS_PG IS

/*
<Documentaci�n TipoDoc = "package"
 <Elemento Nombre = "VE_validacion_FACS_PG"
           Lenguaje="PL/SQL"
           Fecha="31-08-2005"
           Versi�n="1.0.0"
           Dise�ador="vladimir Maureira"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA</Retorno>
   <Descripci�n> Encabezado de VE_validacion_FACS_PG /Descripci�n>
    <Par�metros>
    </Par�metros>
 </Elemento>
</Documentaci�n>
*/

PROCEDURE VE_validaArticulo_pr(EV_codarticulo   IN          al_articulos.cod_articulo%TYPE,
                               SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE VE_validaCliente_pr(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                              EV_numident      IN  ge_clientes.num_ident%TYPE,
                              SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE VE_validaVendedor_pr(EV_codvendealer  IN VE_validavendedor_PG.cod_vendealer,
                               EV_canalvendedor IN VARCHAR2,
                               SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE VE_validaEquipoICC_pr(EV_icc           IN ga_aboamist.num_serie%TYPE,
                                EN_codvendealer  IN  ve_vendealer.cod_vendealer%TYPE,
                                EV_canalvendedor IN  VARCHAR2,
                                SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE VE_validaEquipoIMEI_pr(EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                                 EN_cod_vendedor     IN ve_vendealer.cod_vendealer%TYPE,
                                 EV_cod_canal        IN VARCHAR2,
                                 EV_cod_procediencia IN CHAR,
                                 SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);

END VE_validacion_FACS_PG;
/
SHOW ERRORS
