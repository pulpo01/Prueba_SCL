CREATE OR REPLACE PACKAGE PV_INFORMA_LIMSCORING_ATL_PG IS

PROCEDURE PV_INFORMA_LIMSCORING_ATL_PR (EN_num_celular     IN GA_ABOCEL.num_celular%TYPE,
                                                                         SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                                                         SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                                                         SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento);

END PV_INFORMA_LIMSCORING_ATL_PG;
/
SHOW ERRORS
