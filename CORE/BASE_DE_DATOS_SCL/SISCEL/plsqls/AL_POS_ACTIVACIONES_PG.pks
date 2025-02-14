CREATE OR REPLACE PACKAGE AL_POS_ACTIVACIONES_PG AS
-- Servicio de posactivación  - Logística - Guatemala.
-- Junio 2010 - Ulises Uribe.
PROCEDURE P_ACTIVACION_PUNTUAL_PR( EV_serie    IN   al_series.num_serie%type,
                         EN_cliente  IN   ge_clientes.cod_cliente%type,
                         SN_numero   OUT  NOCOPY   ga_aboamist.num_celular%type,
                         SN_cod_retorno   OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno  OUT  NOCOPY ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento    OUT  NOCOPY ge_errores_pg.Evento);
--
END ;
/
SHOW ERRORS