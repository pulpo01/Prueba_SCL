CREATE OR REPLACE PACKAGE CO_EXCLUIDOS_ACCIONES_SN_PG

IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE co_agrega_pr (
      EN_tip_exclusion IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      ED_fec_ingreso    IN         CO_EXCLUIDOS_ACCIONES_TO.fec_ingreso%type,
      ED_fec_ini_exclusion        IN         CO_EXCLUIDOS_ACCIONES_TO.fec_ini_exclusion%type,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE co_elimina_pr (
      EN_tip_exclusion  IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      SN_filas_afectadas OUT NOCOPY NUMBER,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE co_consulta_pr (
      EN_tip_exclusion  IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      SD_fec_ingreso    OUT NOCOPY        CO_EXCLUIDOS_ACCIONES_TO.fec_ingreso%type,
      SD_fec_ini_exclusion        OUT NOCOPY   CO_EXCLUIDOS_ACCIONES_TO.fec_ini_exclusion%type,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END CO_EXCLUIDOS_ACCIONES_SN_PG;
/
SHOW ERRORS
