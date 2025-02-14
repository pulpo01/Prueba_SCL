CREATE OR REPLACE PACKAGE FA_CARGOS_SB_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_CARGOS_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="30-07-2007"
          Versión="1.0"
          Diseñador=""
          Programador="rao"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Servicios base de cargos</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS
   	cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
   	cv_cod_modulo           VARCHAR2 (2)  := 'FA';
   	cv_version              VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION FA_VALIDA_CLIENTE_ABONADO_FN (EN_cod_cliente 	IN GA_ABOCEL.cod_cliente%TYPE,
	                               EN_num_abonado   IN GA_ABOCEL.num_abonado%TYPE,
	                               SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                               SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                               SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN ;

FUNCTION FA_VALIDA_CONCEPTO_FN (EN_cod_concepto IN FA_CONCEPTOS.cod_concepto%TYPE,
                               SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN;


FUNCTION FA_VALIDA_CICLOFACT_FN ( EN_cod_ciclfact  IN GA_ABOCEL.cod_cliente%TYPE,
	                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN;

FUNCTION FA_VALIDA_CODMONEDA_FN ( EV_cod_moneda   IN ge_monedas.cod_moneda%TYPE,
	                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento) RETURN BOOLEAN;

FUNCTION FA_TRAS_REGS_CARGOS_FN ( ES_reg_fa_cargos  IN FA_CARGOS_QT,
								  ES_reg_ge_cargos  IN OUT NOCOPY GE_CARGOS_QT,
	                              SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento        OUT NOCOPY ge_errores_pg.evento)  RETURN BOOLEAN;

FUNCTION FA_VALIDA_INTERFACT_FN ( EN_num_proceso  IN fa_interfact.num_proceso%TYPE,
	                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento)	  RETURN BOOLEAN;
END FA_CARGOS_SB_PG;
/
SHOW ERRORS
