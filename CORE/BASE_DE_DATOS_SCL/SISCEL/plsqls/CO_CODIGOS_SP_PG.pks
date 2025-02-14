CREATE OR REPLACE PACKAGE CO_CODIGOS_SP_PG

IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


   PROCEDURE co_valida_codigo_pr (
      EV_nom_tabla     IN         co_codigos.NOM_TABLA%type,
	  EV_nom_columna   IN  CO_CODIGOS.NOM_COLUMNA%TYPE,
	  EV_valor         IN CO_CODIGOS.COD_VALOR%TYPE,
	  SN_cantidad OUT NOCOPY number,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END CO_CODIGOS_SP_PG;
/
SHOW ERRORS
