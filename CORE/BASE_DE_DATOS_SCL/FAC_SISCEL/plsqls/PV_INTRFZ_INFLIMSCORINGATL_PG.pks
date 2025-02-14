CREATE OR REPLACE PACKAGE PV_INTRFZ_INFLIMSCORINGATL_PG IS

-- *************************************************************
-- * Paquete            : PV_INTRFZ_INFLIMSCORINGATL_PG.
-- * Fecha de creaci¢n  : Marzo 2007.
-- * Responsable        : Yury Alvarez T.
-- *************************************************************

PROCEDURE PV_INTRFZ_INFLIMSCORINGATL_PR (EN_num_celular     IN GA_ABOCEL.num_celular%TYPE,
                                                                         SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                                                         SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                                                         SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento);




END PV_INTRFZ_INFLIMSCORINGATL_PG;
/
SHOW ERRORS
