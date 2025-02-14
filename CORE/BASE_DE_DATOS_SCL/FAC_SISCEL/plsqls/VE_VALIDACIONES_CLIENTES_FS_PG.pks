CREATE OR REPLACE PACKAGE ve_validaciones_clientes_fs_pg IS

/*
<Documentación TipoDoc = "package"
 <Elemento Nombre = "VE_validacion_FACS_PG"
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



PROCEDURE ve_valida_cliente_moroso_pr(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                                      EV_numident      IN  ge_clientes.num_ident%TYPE,
                                      SN_total         OUT  NOCOPY NUMBER,
                                                                                SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);

PROCEDURE ve_valida_imei_pr          (EV_num_imei         IN ga_aboamist.num_serie%TYPE,
                                      EN_cod_vendedor     IN ve_vendealer.cod_vendealer%TYPE,
                                      EV_cod_canal        IN VARCHAR2,
                                      EV_cod_procediencia IN CHAR,
                                      SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE);




END ve_validaciones_clientes_fs_pg;
/
SHOW ERRORS
