CREATE OR REPLACE PACKAGE ge_seguridad_web_pg AS

   PROCEDURE ge_optener_ticket_seguridad_pr (
     sv_username   OUT VARCHAR2,
	 sn_sid        OUT NUMBER,
	 sn_serial     OUT NUMBER
   );

   PROCEDURE ge_valida_ticket_seguridad_pr (
      ev_username    IN       VARCHAR2,
	  en_sid         IN       NUMBER,
	  en_serial      IN       NUMBER);

  PROCEDURE PV_Id_Seguridad_PR
       (
  	   COD_USER 		   IN	 			VARCHAR2,
	   ID_PROGRAMA 		   IN				VARCHAR2,
	   ID_USER 			   OUT NOCOPY		VARCHAR2,
  	   SN_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
  	   SV_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
  	   SN_num_evento       OUT NOCOPY		ge_errores_pg.evento);

  PROCEDURE PV_Id_VerificaSeg_PR
           (
       SO_Seguridad        IN OUT NOCOPY	PV_IDSEGURIDAD_QT,
       SN_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento       OUT NOCOPY		ge_errores_pg.evento);

END ge_seguridad_web_pg;
/
SHOW ERRORS