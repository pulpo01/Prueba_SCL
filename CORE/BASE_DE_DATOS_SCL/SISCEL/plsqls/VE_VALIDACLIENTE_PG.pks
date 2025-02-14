CREATE OR REPLACE PACKAGE        VE_VALIDACLIENTE_PG IS

/*
<Documentación TipoDoc = "package"
 <Elemento Nombre = "VE_VALIDACLIENTE_PG"
           Lenguaje="PL/SQL"
           Fecha="16-06-2005"
           Versión="1.1.0"
           Diseñador="Rayen Ceballos"
           Programador="Vladimir Maureira"
           Ambiente="DEIMOS_ANDINA">
  <Retorno>NA</Retorno>
   <Descripción> Encabezado de VE_validacliente_PG /Descripción>
    <Parámetros>
    </Parámetros>
 </Elemento>
</Documentación>
*/

FUNCTION VE_validaClienteMoroso_FN(EV_cod_cliente   IN ge_clientes.cod_cliente%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN;

FUNCTION VE_validaClienteVetado_FN(EV_numident      IN  ge_clientes.num_ident%TYPE,
                                   EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) RETURN BOOLEAN;

PROCEDURE ve_valida_pr(EV_tipident      IN  ge_clientes.cod_tipident%TYPE,
                       EV_numident      IN  ge_clientes.num_ident%TYPE,
                       SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                       SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

END VE_VALIDACLIENTE_PG; 
/
SHOW ERRORS
