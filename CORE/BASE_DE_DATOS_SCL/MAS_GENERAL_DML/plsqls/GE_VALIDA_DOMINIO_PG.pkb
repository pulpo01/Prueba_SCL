CREATE OR REPLACE PACKAGE BODY GE_VALIDA_DOMINIO_PG
AS
    FUNCTION GE_VALIDA_VALOR_DOMINIO_FN (EV_nom_tabla IN GE_DOMINIOS_TD.COD_DOMINIO%TYPE
                                   ,EV_nom_columna IN GE_COLUMNAS_DOMINIOS_TD.NOMBRE_COLUMNA%TYPE
								   ,EV_val_dominio IN GE_VALORES_DOMINIOS_TD.VALOR%TYPE
								   ) RETURN NUMBER IS
        /*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_VALIDA_VALOR_DOMINIO_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>
	0 -> dominio es correcto
	1 -> dominio no existe
	2 -> inconsistencia en los datos
	</Retorno>
	<Descripcion>Chequea la existencia de un valor de dominio para una tabla/columna dada</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_nom_tabla" Tipo="STRING">Nombre de tabla a buscar</param>
	<param nom="EV_nom_columna" Tipo="STRING">Nombre de columna a buscar</param>
	<param nom="EV_val_dominio" Tipo="STRING">Valor de dominio a buscar</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
	 LN_tot_registros NUMBER(2);
	 LN_cod_error NUMBER(2);
    BEGIN
	     LN_cod_error := CN_dominio_codigo_ok;

		 SELECT COUNT(1)
		 INTO LN_tot_registros
		 FROM ge_valores_dominios_knl_vw a
		      ,ge_columnas_dominios_knl_vw b
		      ,ge_dominios_knl_vw c
		 WHERE b.cod_dominio = c.cod_dominio
		 AND c.cod_dominio = a.cod_dominio
		 AND c.tipo = CN_tipo_dominio_valor
		 AND b.nombre_columna = EV_nom_columna
		 AND b.nombre_tabla = EV_nom_tabla
		 AND a.valor = EV_val_dominio;


		 IF LN_tot_registros = 0 THEN
		 	LN_cod_error := CN_dominio_not_found_codigo;
		 ELSIF LN_tot_registros > 1 THEN
		 	LN_cod_error := CN_dominio_invalid_codigo;
		 END IF;

		 RETURN LN_cod_error;
    EXCEPTION
	   WHEN OTHERS THEN
	      RAISE_APPLICATION_ERROR(-20100, 'Error en VALIDA_VALOR_DOMINIO ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_VALIDA_VALOR_DOMINIO_FN;
END GE_VALIDA_DOMINIO_PG;
/
SHOW ERRORS
