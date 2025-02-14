CREATE OR REPLACE PACKAGE BODY Co_Validatarjeta_Pg IS

FUNCTION CO_RETORNA_VERSION_GENERAL_FN RETURN VARCHAR2
IS
	GV_version    CONSTANT VARCHAR2(3) := '001';
	GV_subversion CONSTANT VARCHAR2(3) := '001';
BEGIN
	RETURN('Version : '||GV_version||' <--> SubVersion : '||GV_subversion);
END;

-- *********************************************************************************

FUNCTION Co_Validatarjeta_Fn (
EV_cod_tarjeta     IN VARCHAR2,
EV_num_tarjeta     IN VARCHAR2
) RETURN VARCHAR2 IS
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "CO_VALIDATARJETA_FN"
      Fecha modificación=" "
      Fecha creación="30/05/2005"
      Constructor="Manuel Garcia"
      Modificador=" "
      Ambiente Desarrollo="">
      <Retorno>VARCHAR2</Retorno>
      <Descripción>Valida el codigo de una tarjeta de acuerdo a parametrizacion de la operadora</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_tarjeta"   Tipo="CARACTER">Codigo de Tipo de Tarjeta</param>
			<param nom="EN_num_tarjeta"   Tipo="CARACTER">Numero de la tarjeta</param>
         </Entrada>
         <Salida>
			<param nom=""   Tipo=""></param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

TV_nom_param1	CONSTANT GED_PARAMETROS.nom_parametro%TYPE := 'VAL_LENTARJETA';
TV_nom_param2	CONSTANT GED_PARAMETROS.nom_parametro%TYPE := 'VAL_PREFTARJETA';
TV_nom_param3	CONSTANT GED_PARAMETROS.nom_parametro%TYPE := 'VAL_BINTARJETA';
LV_len_tarjeta	GED_PARAMETROS.val_parametro%TYPE;
LV_pref_tarjeta	GED_PARAMETROS.val_parametro%TYPE;
LV_bin_tarjeta	GED_PARAMETROS.val_parametro%TYPE;
CV_modulo		CONSTANT VARCHAR2(2):='CO';
LV_DescError	VARCHAR2(255);
SN_retorno		VARCHAR2(501);

ERROR_PROCESO EXCEPTION;

BEGIN

	LV_DescError := 'Select Ged_Parametros validar largo tarjeta';
	SELECT val_parametro
	  INTO LV_len_tarjeta
	  FROM GED_PARAMETROS
	 WHERE nom_parametro = TV_nom_param1
	   AND cod_modulo    = CV_modulo;

	LV_DescError := 'Select Ged_Parametros validar prefijo tarjeta';
	SELECT val_parametro
	  INTO LV_pref_tarjeta
	  FROM GED_PARAMETROS
	 WHERE nom_parametro = TV_nom_param2
	   AND cod_modulo    = CV_modulo;

	LV_DescError := 'Select Ged_Parametros validar bin tarjeta';
	SELECT val_parametro
	  INTO LV_bin_tarjeta
	  FROM GED_PARAMETROS
	 WHERE nom_parametro = TV_nom_param3
	   AND cod_modulo    = CV_modulo;

	IF LV_len_tarjeta = 'SI' THEN
		LV_DescError := 'Error en llamada a Funcion CO_VALIDALARGO_FN.';
		SN_retorno := Co_Validalargo_Fn( EV_cod_tarjeta , EV_num_tarjeta );

		IF SUBSTR( SN_retorno, 1, 1 ) <> '0' THEN
			RETURN SN_retorno;
		END IF;
	END IF;

	IF LV_pref_tarjeta = 'SI' THEN
		LV_DescError := 'Error en llamada a Funcion CO_VALIDAPREFIJO_FN.';
		SN_retorno := Co_Validaprefijo_Fn( EV_cod_tarjeta , EV_num_tarjeta );

		IF SUBSTR( SN_retorno, 1, 1 ) <> '0' THEN
			RETURN SN_retorno;
		END IF;
	END IF;

	IF LV_bin_tarjeta = 'SI' THEN
		LV_DescError := 'Error en llamada a Funcion CO_VALIDABIN_FN.';
		SN_retorno := Co_ValidaBin_Fn( EV_cod_tarjeta , EV_num_tarjeta );

		IF SUBSTR( SN_retorno, 1, 1 ) <> '0' THEN
			RETURN SN_retorno;
		END IF;
	END IF;

	RETURN SN_retorno;

EXCEPTION
	WHEN OTHERS THEN
		RETURN -1;
END Co_Validatarjeta_Fn;

-- *********************************************************************************

FUNCTION Co_Validalargo_Fn (
	EV_cod_tarjeta    IN   VARCHAR2,
	EV_num_tarjeta    IN   VARCHAR2
) RETURN VARCHAR2 IS
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "CO_VALIDALARGO_FN"
      Fecha modificación=" "
      Fecha creación="30/05/2005"
      Constructor="Manuel Garcia"
      Modificador=" "
      Ambiente Desarrollo="">
      <Retorno>VARCHAR2</Retorno>
      <Descripción>Valida el largo de un codigo de tarjeta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_tarjeta"   Tipo="CARACTER">Codigo de Tipo de Tarjeta</param>
			<param nom="EN_num_tarjeta"   Tipo="CARACTER">Numero de la tarjeta</param>
         </Entrada>
         <Salida>
			<param nom=""   Tipo=""></param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DescError	VARCHAR2(255);
LN_largotarjeta	NUMBER;
LN_Cnt			NUMBER;

BEGIN

	LN_largotarjeta := RTRIM( LENGTH( EV_num_tarjeta ) );

	LV_DescError := 'Error en Select COUNT(1) CO_LARGOTARJETAS_TD.';
	SELECT COUNT(1)
	  INTO LN_Cnt
	  FROM CO_LARGOTARJETAS_TD
	 WHERE cod_tarjeta = EV_cod_tarjeta
	   AND longitud = LN_largotarjeta;

	IF LN_Cnt = 0 THEN
		RETURN '1|||Largo de Tarjeta Invalido';
	END IF;

	RETURN '0|||';

EXCEPTION
	WHEN OTHERS THEN
		RETURN '-1|||' || LV_DescError;
END;

-- *********************************************************************************

FUNCTION Co_Validaprefijo_Fn (
EV_cod_tarjeta    IN   VARCHAR2,
EV_num_tarjeta    IN   VARCHAR2
) RETURN VARCHAR2 IS
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "CO_VALIDAPREFIJO_FN"
      Fecha modificación=" "
      Fecha creación="30/05/2005"
      Constructor="Manuel Garcia"
      Modificador=" "
      Ambiente Desarrollo="">
      <Retorno>VARCHAR2</Retorno>
      <Descripción>Valida el prefijo de un codigo de tarjeta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_tarjeta"   Tipo="CARACTER">Codigo de Tipo de Tarjeta</param>
			<param nom="EN_num_tarjeta"   Tipo="CARACTER">Numero de la tarjeta</param>
         </Entrada>
         <Salida>
			<param nom=""   Tipo=""></param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DescError	VARCHAR2(255);
LN_Cnt			NUMBER;

BEGIN

	LV_DescError := 'Error en Select COUNT(1) CO_PREFTARJETAS_TD.';
	SELECT COUNT(1)
	  INTO LN_Cnt
	  FROM CO_PREFTARJETAS_TD
	 WHERE cod_tarjeta  = EV_cod_tarjeta
	   AND prefijo = SUBSTR( EV_num_tarjeta, 1, LENGTH( prefijo ) );

	IF LN_Cnt = 0 THEN
		RETURN '2|||Prefijo de Tarjeta Invalido';
	END IF;

	RETURN '0|||';

EXCEPTION
	WHEN OTHERS THEN
		RETURN '-1|||' || LV_DescError;
END;

-- *********************************************************************************

FUNCTION Co_ValidaBin_Fn (
EV_cod_tarjeta    IN   VARCHAR2,
EV_num_tarjeta    IN   VARCHAR2
) RETURN VARCHAR2 IS
/*
<Documentación
  TipoDoc = "Función">
   <Elemento
      Nombre = "CO_VALIDABIN_FN"
      Fecha modificación=" "
      Fecha creación="30/05/2005"
      Constructor="Manuel Garcia"
      Modificador=" "
      Ambiente Desarrollo="">
      <Retorno>VARCHAR2</Retorno>
      <Descripción>Valida el bin de un codigo de tarjeta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_tarjeta"   Tipo="CARACTER">Codigo de Tipo de Tarjeta</param>
			<param nom="EN_num_tarjeta"   Tipo="CARACTER">Numero de la tarjeta</param>
         </Entrada>
         <Salida>
			<param nom=""   Tipo=""></param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DescError	VARCHAR2(255);
LV_cod_estado	CO_BINES_TD.cod_estado%TYPE;
LV_cod_banco	CO_BINES_TD.cod_banco%TYPE := '';
LV_cod_tarjasoc	GE_TIPTARJETAS.cod_tarjeta_asoc%TYPE := '';
LN_valida_bin	GE_TIPTARJETAS.ind_valbin%TYPE;

BEGIN

	BEGIN
		LV_DescError := 'Error en Co_ValidaBin_Fn, Select GE_TIPTARJETAS.';
		SELECT ind_valbin, cod_tarjeta_asoc
		  INTO LN_valida_bin, LV_cod_tarjasoc
		  FROM GE_TIPTARJETAS
		 WHERE cod_tiptarjeta = EV_cod_tarjeta;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				LN_valida_bin := 0;
				LV_cod_tarjasoc := NULL;
	END;

	IF LN_valida_bin <> 0 THEN -- se valida bin

		BEGIN
			LV_DescError := 'Error en Co_ValidaBin_Fn, Select CO_BINES_TD.';
			SELECT cod_estado, cod_banco
			  INTO LV_cod_estado, LV_cod_banco
			  FROM CO_BINES_TD
			 WHERE num_bin = SUBSTR( EV_num_tarjeta, 1 ,6 );

			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					LV_cod_estado := NULL;
					LV_cod_banco := NULL;
		END;

		IF LV_cod_estado IS NULL AND LV_cod_estado IS NULL THEN

			IF LV_cod_tarjasoc IS NULL THEN
				RETURN '3|||Bin de Tarjeta Invalido';
			END IF;

		ELSE

			IF LV_cod_estado = 'B' THEN
				RETURN '3|||BIN dado de baja, se rechaza Tarjeta';
			END IF;

			LV_cod_tarjasoc := NULL;

		END IF;

	END IF; --IF LN_valida_bin

	RETURN '0|' || LV_cod_banco || '|' || LV_cod_tarjasoc || '|';

EXCEPTION
	WHEN OTHERS THEN
		RETURN '-1|||' || LV_DescError;
END;

END Co_Validatarjeta_Pg;
/
SHOW ERRORS
