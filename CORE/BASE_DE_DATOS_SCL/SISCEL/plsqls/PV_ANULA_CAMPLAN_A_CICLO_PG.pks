CREATE OR REPLACE PACKAGE PV_ANULA_CAMPLAN_A_CICLO_PG
	IS
	CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
	CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
	CV_version              CONSTANT VARCHAR2 (2)  := '3';
	CN_POSPAGO				CONSTANT VARCHAR2 (5)  := '2';
	CN_HIBRIDO				CONSTANT VARCHAR2 (5)  := '3';

--------------------------------------------------------------------------------------------------
	PROCEDURE PV_ANULA_CAMPLAN_A_CICLO_PR(
	  EV_cod_cliente           IN               ge_clientes.cod_cliente%TYPE,
          EV_num_abonado           IN               ga_abocel.num_abonado%TYPE,
	  EV_cod_plantarif         IN               ta_plantarif.cod_plantarif%TYPE,
	  SV_cod_retorno           OUT              VARCHAR2,--1 tiene 0 no tiene 4 error
          SV_glosa_retorno         OUT              VARCHAR2,
	  SV_plan_NUEVO            OUT              ta_plantarif.cod_plantarif%TYPE,
	  SV_NUM_OOSS              OUT              pv_camcom.num_os%TYPE,
	  SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
          SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
          SN_num_evento            OUT NOCOPY		ge_errores_pg.evento
	  );
--------------------------------------------------------------------------------------------------
end PV_ANULA_CAMPLAN_A_CICLO_PG ;
/
SHOW ERRORS
