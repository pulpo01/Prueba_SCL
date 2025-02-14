CREATE OR REPLACE PACKAGE PV_PROMOCION_PG
IS

   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_Comb_Pospos		   CONSTANT VARCHAR2 (6)  := 'POSPAGOPOSPAGO';
   CV_Comb_Pospre		   CONSTANT VARCHAR2 (6)  := 'POSPAGOPREPAGO';
   CN_Aplica			   CONSTANT NUMBER   (1)  := 1;
   ---------------------------------------------------------------------------------------
--1.- Metodo eliminarPromocion

	PROCEDURE PV_ELIMINAR_PROMOCION_PR(EO_GA_PROMOC		   IN OUT NOCOPY	PV_GA_PROMOC_QT,
								       SN_cod_retorno         OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
								       SV_mens_retorno        OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
								       SN_num_evento          OUT NOCOPY	ge_errores_pg.evento);

   ---------------------------------------------------------------------------------------
END PV_PROMOCION_PG;
/
SHOW ERRORS
