CREATE OR REPLACE FUNCTION P_OBTIENENUMERADO_FN(
IV_kit   IN al_lin_agredes_kit.num_serie_kit%TYPE) RETURN VARCHAR2 IS
/*
<NOMBRE>	  : P_OBTIENENUMERADO_FN
<FECHACREA>	  : 21/04/2004
<MODULO >	  : AL
<AUTOR >      : Ulises Patricio Uribe Flores
<VERSION >    : 1.0
<DESCRIPCION> : Retorna Componente Numerado de un kit, when others retorna null
<FECHAMOD >   :
<DESCMOD >    :
<ParamEntr>   : IV Kit
<ParamSal >   : OV_return
*/
  		 OV_return    AL_LIN_AGREDES_KIT.num_serie_kit%TYPE;
 		 CI_zero 	  CONSTANT INTEGER :='0';
BEGIN
        SELECT num_serie
		INTO   OV_return
		FROM   al_componente_kit
		WHERE  num_kit = IV_kit
		AND    num_telefono IS NOT NULL
		AND    num_serie > CI_zero;
		RETURN OV_return;
EXCEPTION
		  WHEN OTHERS THEN
		   	 RETURN NULL;
END  P_OBTIENENUMERADO_FN;
/
SHOW ERRORS
