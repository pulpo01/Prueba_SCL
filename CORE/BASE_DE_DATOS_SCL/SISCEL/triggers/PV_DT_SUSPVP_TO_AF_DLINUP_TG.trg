CREATE OR REPLACE TRIGGER PV_DT_SUSPVP_TO_AF_DLINUP_TG
BEFORE INSERT OR UPDATE
ON PV_DET_SUSPVOLPROG_TO
FOR EACH ROW
DECLARE
BEGIN

   INSERT INTO pv_det_suspvolprog_th
               (num_det_sus_vol_prg,num_abonado,num_periodosusp_1,num_periodosusp_2,fec_solicitud,
			    fec_suspension,fec_rehabilitacion,fec_actualizacion,dias_periodosusp_1,
                dias_periodosusp_2,estado,cod_causal,usuario,num_os_sus,num_os_reh
			   )
        VALUES (:new.num_det_sus_vol_prg,:new.num_abonado,:new.num_periodosusp_1,:new.num_periodosusp_2,:new.fec_solicitud,
			    :new.fec_suspension,:new.fec_rehabilitacion,:new.fec_actualizacion,:new.dias_periodosusp_1,
                :new.dias_periodosusp_2,:new.estado,:new.cod_causal,:new.usuario,:new.num_os_sus,:new.num_os_reh
			   );


   EXCEPTION
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20098,'Se produjo un error al registrar histórico. - ['||SQLCODE||'] -- ['||SQLERRM||']');

END PV_DT_SUSPVP_TO_AF_DLINUP_TG;
/
SHOW ERRORS
