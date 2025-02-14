CREATE OR REPLACE PROCEDURE PV_HLRABONADO_PR (EN_cod_central IN ICG_CENTRAL.COD_CENTRAL%TYPE,
	   	  		  			   EN_cod_producto   IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
							   SV_cod_hlr	 OUT ICG_HLRS.COD_HLR%TYPE,
							   SV_des_hlr	 OUT ICG_HLRS.DES_HLR%TYPE,
							   SV_coderror   OUT VARCHAR2,
							   SV_deserror   OUT VARCHAR2
                              )
AS

/*
<NOMBRE>  		  		  :PV_HLRABONADO_PR</NOMBRE>
<FECHACREA>				  :14/01/2005</FECHACREA>
<MODULO>				  :POSTVENTA</MODULO>
<AUTOR>					  :HECTOR PEREZ GUZMAN</AUTOR>
<VERSION>				  :1.0</VERSION>
<DESCRIPCION>			  :RETORNA HLR DE ABONADO</DESCRIPCION>
<FECHAMOD>				  :</FECHAMOD>
<PARAMENTR>				  :CODIGO DE CENTRAL /PARAMENTR>
<PARAMSAL>				  : RESULTADO DE CONSULTA, DESCRIPCION ERROR</PARAMSAL>
*/



BEGIN

    SV_coderror := 0;
	SV_deserror := 'OK';

		SELECT b.cod_hlr, b.des_hlr
		INTO   SV_cod_hlr, SV_des_hlr
		FROM   ICG_CENTRAL a, ICG_HLRS b
		WHERE  a.cod_producto = EN_cod_producto
		AND    a.cod_central = EN_cod_central
		AND    b.cod_hlr     = a.cod_hlr;


	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 SV_coderror := 4;
			 SV_deserror := 'Abonado sin datos para el HLR';


		WHEN OTHERS THEN
			 SV_coderror := 4;
			 SV_deserror := SUBSTR(SQLERRM,1,60);


END PV_HLRABONADO_PR;
/
SHOW ERRORS
