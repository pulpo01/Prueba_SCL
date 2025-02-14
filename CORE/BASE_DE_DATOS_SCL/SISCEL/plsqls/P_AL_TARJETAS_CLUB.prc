CREATE OR REPLACE PROCEDURE        P_AL_TARJETAS_CLUB(
vp_num_serie    	in al_tarjetas_club.num_serie%TYPE,
vp_cod_estado   	in al_tarjetas_club.cod_estado%TYPE,
vp_cod_usuario   	in al_tarjetas_club.cod_usuario%TYPE,
vp_num_abonado   	in al_tarjetas_club.num_abonado%TYPE,
vp_usu_proceso   	in al_tarjetas_club.usu_peticion%TYPE,
vp_fec_proceso   	in al_tarjetas_club.fec_peticion%TYPE,
vp_cod_causabaja   	in al_tarjetas_club.cod_causabaja%TYPE,
vp_err                  OUT NUMBER
)
as
vp_cont_estado   number;
vp_cont_abo      number;
vp_estado        al_tarjetas_club.cod_estado%type;
vp_situ          al_tarjetas_club.cod_estado%type;
vp_dur_vigencia  al_club_general.dur_vigencia%TYPE;
BEGIN
vp_cont_abo:=0;
vp_situ:= null;
vp_err:=0;
      SELECT COUNT(*) INTO vp_cont_abo
      FROM AL_TARJETAS_CLUB
      WHERE NUM_ABONADO = vp_num_abonado
      AND COD_ESTADO <> 'BA';
      if vp_cont_abo = 0 then
         vp_situ := 'PD';
      end if;
      if vp_cont_abo = 1 then
         SELECT COD_ESTADO INTO vp_situ
         FROM AL_TARJETAS_CLUB
         WHERE NUM_ABONADO = vp_num_abonado
         AND COD_ESTADO <> 'BA';
      end if;
      if vp_cont_abo > 1 then
         vp_err:=1;
 	   raise_application_error (-20261,'CLUB:' || to_char(SQLCODE)|| 'ERROR NUE.');
      end if;
--      if vp_estado <> 'PD' then
--         SELECT COUNT(*) INTO vp_cont_estado
--         FROM AL_TARJETAS_CLUB
--         WHERE NUM_SERIE = vp_num_serie;
--      end if;
--      if vp_cont_estado > 1 then
--         vp_err:=1;
--	 raise_application_error (-20260,
--		    'CLUB:' || to_char(SQLCODE)|| 'ERROR PD');
--      end if;
      if vp_cod_estado = 'PD' and vp_err=0 and vp_cont_abo = 0 then
         SELECT DUR_VIGENCIA INTO vp_dur_vigencia FROM AL_CLUB_GENERAL;
         INSERT INTO AL_TARJETAS_CLUB(num_serie,cod_estado,cod_usuario,num_abonado,cod_producto,
                                      usu_peticion,fec_peticion,usu_creacion,fec_creacion,usu_envio,
				      fec_envio,usu_recepcion,fec_recepcion,usu_baja,fec_baja,
				      usu_vigencia,fec_vigencia,cod_causabaja) values
                                      (vp_num_serie,vp_cod_estado,vp_cod_usuario,vp_num_abonado,
				      1,vp_usu_proceso,vp_fec_proceso,null,null,null,null,null,null,
                                      null,null,vp_usu_proceso,ADD_MONTHS(TRUNC(SYSDATE,'MONTH'),vp_dur_vigencia +1),null);
      end if;
      if vp_cod_estado= 'NU' and vp_err=0 then
         if vp_situ = 'PD' then
            UPDATE AL_TARJETAS_CLUB SET usu_creacion = vp_usu_proceso,fec_creacion=vp_fec_proceso,cod_estado=vp_cod_estado
                where num_serie=vp_num_serie;
         else
        	vp_err:=2;
		raise_application_error (-20261,
		    'CLUB:' || to_char(SQLCODE)|| 'ERROR NUE.');
         end if;
      end if;
      if vp_cod_estado= 'EN' and vp_err=0 then
         if vp_situ = 'NU' then
            UPDATE AL_TARJETAS_CLUB SET usu_envio = vp_usu_proceso,fec_envio=vp_fec_proceso,cod_estado=vp_cod_estado
                where num_serie=vp_num_serie;
         else
            	vp_err:=2;
		raise_application_error (-20261,
		    'CLUB:' || to_char(SQLCODE)|| 'ERROR ENV.');
         end if;
      end if;
      if vp_cod_estado= 'RE' and vp_err=0 then
         if vp_situ = 'EN' then
            UPDATE AL_TARJETAS_CLUB SET usu_recepcion =vp_usu_proceso,fec_recepcion=vp_fec_proceso,cod_estado=vp_cod_estado
                where num_serie=vp_num_serie;
         else
		vp_err:=2;
		raise_application_error (-20261,
		    'CLUB:' || to_char(SQLCODE)|| 'ERROR REC.');
         end if;
      end if;
      if vp_cod_estado= 'BA' and vp_err=0 then
         if vp_situ = 'RE' then
                      UPDATE AL_TARJETAS_CLUB SET usu_baja = vp_usu_proceso,fec_baja=vp_fec_proceso,cod_causabaja_club=vp_cod_causabaja,cod_estado=vp_cod_estado
                where num_serie=vp_num_serie;
         else
		vp_err:=2;
		raise_application_error (-20261,
		    'CLUB:' || to_char(SQLCODE)|| 'ERROR BAJA.');
         end if;
      end if;
EXCEPTION
   WHEN OTHERS then
        VP_ERR:= SQLCODE;
	raise_application_error (-20262,
		    'CLUB:' || to_char(SQLCODE)|| 'ERROR GENERICO.');
END;
/
SHOW ERRORS
