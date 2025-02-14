CREATE OR REPLACE PACKAGE CO_EXCLUIDOS_ACCIONES_FS_PG

IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE CO_AGREGA_CLIENTE_PR (
      EN_cod_cliente     IN NUMBER,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_msg_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_cod_evento     OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE CO_ELIMINA_CLIENTE_PR (
      EN_cod_cliente     IN NUMBER,
      SN_cant_eliminados  OUT NOCOPY NUMBER,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_msg_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_cod_evento     OUT NOCOPY ge_errores_pg.Evento);

   PROCEDURE CO_CONSULTA_CLIENTE_PR (
      EN_cod_cliente     IN NUMBER,
      SD_fec_ingreso     OUT NOCOPY DATE,
      SD_fec_ini_exclusion        OUT NOCOPY   DATE,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_msg_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_cod_evento     OUT NOCOPY ge_errores_pg.Evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END CO_EXCLUIDOS_ACCIONES_FS_PG;
/
SHOW ERRORS
