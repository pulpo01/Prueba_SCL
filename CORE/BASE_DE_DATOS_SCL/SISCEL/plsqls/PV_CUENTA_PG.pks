CREATE OR REPLACE PACKAGE PV_CUENTA_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CN_prepago                      CONSTANT NUMBER        := 1;
   CN_pospago                      CONSTANT NUMBER        := 2;
   CN_hibrido                      CONSTANT NUMBER        := 3;
   CN_codciclo_prepago     CONSTANT NUMBER        := 25;

   ---------------------------------------------------------------------------------------
        PROCEDURE PV_OBTIENE_CLIENTE_CUENTA_PR(
                          EO_Cliente                                IN                       PV_CLIENTE_QT,
                          SO_Lista_CliCuenta_Prepago    OUT NOCOPY               refCursor,
                          SO_Lista_CliCuenta_Pospago    OUT NOCOPY               refCursor,
                          SO_Lista_CliCuenta_Hibrido    OUT NOCOPY               refCursor,
                  SN_cod_retorno                        OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno                       OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento                         OUT NOCOPY               ge_errores_pg.evento
        );

   ---------------------------------------------------------------------------------------
        PROCEDURE PV_OBTIENE_SUBCUENTA_CUENTA_PR(
                  EO_Cliente          IN                           PV_CLIENTE_QT,
                      SO_Lista_SubCuentas OUT  NOCOPY      refCursor,
                  SN_cod_retorno          OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno         OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento           OUT NOCOPY       ge_errores_pg.evento
        );

   ---------------------------------------------------------------------------------------
        PROCEDURE PV_INS_CONTRATO_CUENTA_PR(
                         EO_PARAM            IN           PV_GA_ABOCEL_QT,
                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento
        );

   ---------------------------------------------------------------------------------------
		  PROCEDURE PV_OBTIENE_NUM_CLI_CUENTA_PR(
      EO_Cliente                        IN              PV_CLIENTE_QT,
	  SN_MAX_CLI					    OUT NOCOPY 		NUMBER,
      SN_cod_retorno                    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno                   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento                     OUT NOCOPY      ge_errores_pg.evento
	   );

   ---------------------------------------------------------------------------------------
	  PROCEDURE PV_LISTA_CLIENTES_CUENTA_PR(
      EO_Cliente                    IN               PV_CLIENTE_QT,
      SO_Lista_CliCuenta    		OUT NOCOPY       refCursor,
      SN_cod_retorno                OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno               OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento                 OUT NOCOPY       ge_errores_pg.evento
	   );

   ---------------------------------------------------------------------------------------

END PV_CUENTA_PG;
/
SHOW ERRORS
