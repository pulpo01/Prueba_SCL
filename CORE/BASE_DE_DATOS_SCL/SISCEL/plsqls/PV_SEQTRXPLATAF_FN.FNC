CREATE OR REPLACE FUNCTION PV_SEQTRXPLATAF_FN(
	TV_tecnologia 		AL_TECNOLOGIA.cod_tecnologia%TYPE,
	TN_num_abonado		GA_ABOAMIST.num_abonado%TYPE DEFAULT NULL
)
RETURN BOOLEAN
/*
<NOMBRE>	: PV_SEQTRXPLATAF_FN</NOMBRE>
<FECHACREA>	: 02/04/2004 <FECHACREA/>
<MODULO >	: Gestion Abonados </MODULO >
<AUTOR >        : Patricio Gallegos C. </AUTOR >
<VERSION >    	: 1.0 </VERSION >
<DESCRIPCION>   : Funcion que recibe codigo de tecnologia o numero del abonado, retornando verdadero si la
plataforma (depende de la tecnologia) entrega secuencia de lo contrario falso. </DESCRIPCION>
<FECHAMOD >     : DD/MM/YYYY </FECHAMOD>
<DESCMOD >      : Breve descripcion de Modificacion </DESCMOD >
<ParamEnt >     : codigo tecnologia (TV_tecnologia)
	        : numero del abonado (TN_num_abonado) </ParamEnt>
<ParamSal >     : </ParamSal>
*/

IS
	 TV_tec_gsm			GED_PARAMETROS.val_parametro%TYPE:=GE_FN_DEVVALPARAM('GA', 1, 'GRUPO_TEC_GSM');
	 TV_tec_tdma			GED_PARAMETROS.val_parametro%TYPE:=GE_FN_DEVVALPARAM('GA', 1, 'GRUPO_TEC_DMA');
	 TV_seqtrxplat			GED_PARAMETROS.val_parametro%TYPE:='FALSE';
	 TV_tec_abo			GA_ABOAMIST.cod_tecnologia%TYPE;
BEGIN

	 IF TV_tecnologia IS NULL THEN
	 	SELECT cod_tecnologia INTO TV_tec_abo
	 	FROM	GA_ABOAMIST WHERE num_abonado = TN_num_abonado
	 	UNION
	 	SELECT cod_tecnologia
	 	FROM	GA_ABOCEL WHERE num_abonado = TN_num_abonado;
	 ELSE
	 	 TV_tec_abo:=TV_tecnologia;
	 END IF;

	 /* OCB-INI-TMM_04008               */
	 /* IF TV_tec_abo = TV_tec_gsm THEN */
	 /* OCB-FIN-TMM_04008               */


	 IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(TV_tec_abo) = TV_tec_gsm THEN
	 	TV_seqtrxplat := GE_FN_DEVVALPARAM('GA',1,'SEQTRX_PLAT_GSM');
	 /* OCB-INI-TMM_04008               */
	 /* ELSIF TV_tec_abo  = TV_tec_tdma THEN  */
	 ELSIF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(TV_tec_abo) = TV_tec_tdma THEN
	 /* OCB-FIN-TMM_04008               */
	  	TV_seqtrxplat := GE_FN_DEVVALPARAM('GA',1,'SEQTRX_PLAT_TDMA');
	 END IF;

	 IF TV_seqtrxplat='TRUE' THEN
	 	RETURN TRUE;
	 ELSE
	 	RETURN FALSE;
	 END IF;
EXCEPTION
	WHEN OTHERS THEN
	 	 RETURN FALSE;
END;
/
SHOW ERRORS
