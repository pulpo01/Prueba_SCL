CREATE OR REPLACE Function PV_HOMOLOGACIONPLAN_FN
(
  TV_cod_interno 					IN AL_CODIGO_EXTERNO.codigo_interno%TYPE
  )
  return varchar2
  IS
/*
<NOMBRE>	: PV_HOMOLOGACIONPLAN_FN</NOMBRE>
<FECHACREA>	: 23/04/2004 <FECHACREA/>
<MODULO >	: Gestion Abonados </MODULO >
<AUTOR >    : Patricio Gallegos C. </AUTOR >
<VERSION >    	: 1.0 </VERSION >
<DESCRIPCION> : Funcion que recibe codigo de plan tarifario prepago y devuelve codigo externo. </DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD>
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamEnt >  : codigo externo (TV_cod_interno)
		    :  		  		  					  </ParamEnt>
<ParamSal >  : </ParamSal>
*/

TV_cod_externo 				 AL_CODIGO_EXTERNO.codigo_externo%TYPE;
TV_plataforma				 GED_PARAMETROS.val_parametro%TYPE;
TV_tip_codigo				 GED_PARAMETROS.val_parametro%TYPE;
BEGIN

     SELECT val_parametro
	 INTO TV_plataforma
	 FROM GED_PARAMETROS
	 WHERE COD_PRODUCTO=1
	 AND cod_modulo='GA'
	 AND nom_parametro='PLAT_CDMA';

	 SELECT val_parametro
	 INTO TV_tip_codigo
	 FROM GED_PARAMETROS
	 WHERE COD_PRODUCTO=1
	 AND cod_modulo='GA'
	 AND nom_parametro='TIP_CODIGO';

	 SELECT codigo_externo
     INTO TV_cod_externo
     FROM AL_CODIGO_EXTERNO
     WHERE cod_plataforma = TV_plataforma
     AND  tip_codigo     = TV_tip_codigo
     AND  codigo_interno = TV_cod_interno;

	 RETURN TV_cod_externo;

 EXCEPTION
 		 WHEN OTHERS THEN
		 	  RETURN SQLERRM;
END;

/
SHOW ERRORS
