CREATE OR REPLACE PACKAGE BODY GE_VALORES_DOMINIOS_KNL_D_PG
IS
  TIPO_DOMINIO_MODIFICABLE CONSTANT NUMBER(1) := 2;
  TIPO_DOMINIO_NO_VALIDO EXCEPTION;
  FUNCTION GE_CHEQUEA_INTEGRIDAD_FN(EV_nom_dominio IN ge_valores_dominios_td.cod_dominio%TYPE,
                                EV_val_dominio IN ge_valores_dominios_td.valor%TYPE)
								RETURN NUMBER AS
	CURSOR cur_columna_dominio (v1 varchar2) IS
	       SELECT NOMbre_TABLA, NOMbre_COLUMNA
		   FROM GE_COLUMNAS_DOMINIOS_TD
		   WHERE cod_dominio =v1;
	LN_total NUMBER(9);
	LN_sql VARCHAR2(3000);
	LV_TABLA varchar2(100);
	LV_columna varchar2(100);
	LN_retorno number(1);
BEGIN
   LN_retorno := 0;

   OPEN cur_columna_dominio (EV_nom_dominio);
   LOOP
      FETCH  cur_columna_dominio INTO LV_tabla, LV_columna;
	  EXIT WHEN cur_columna_dominio%NOTFOUND OR LN_retorno = 1;

		  LN_sql := 'SELECT COUNT(1) FROM ' || LV_tabla  || ' WHERE ' || LV_columna || '=:v1 ';
		  BEGIN
		      EXECUTE IMMEDIATE LN_sql INTO LN_total USING EV_val_dominio ;
			  IF LN_total > 0 THEN
		         LN_retorno:= 1;
      		  END IF;
		  EXCEPTION
		    WHEN OTHERS THEN
			  LN_total := 0;
			  LN_retorno:= 1;
		  END;
   END LOOP;
   close cur_columna_dominio;
   IF LN_retorno >0 THEN
      IF LN_total > 0 THEN
	     RAISE_APPLICATION_ERROR(-20111,'Existe dependencia del valor en otra tabla');
	  ELSE
         RAISE_APPLICATION_ERROR(-20112,'No se pudo validar tabla');
	  END IF;
   END IF;
   RETURN LN_retorno;
END;

  FUNCTION GE_ELIMINAR_FN
               (
               EN_tipo_ingreso IN ge_dominios_td.tipo%TYPE
                ,EV_cod_dominio IN ge_valores_dominios_td.cod_dominio%TYPE
               ,EV_valor IN ge_valores_dominios_td.valor%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ELIMINAR_FN Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina un valor de un dominio. Se realiza la eliminaci¢n en la tabla GE_VALORES_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EN_tipo_ingreso" Tipo="Number">Valor que determina si se ingresa dominio sistema (1) o modificable (2)</param>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio a eliminar</param>
	<param nom="EV_valor" Tipo="STRING">Nuevo valor de domnio</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
  LN_tipo ge_dominios_td.tipo%TYPE;
  LN_salida NUMBER(1);
	  BEGIN
	       SELECT tipo
	       INTO LN_tipo
		   FROM
	       ge_dominios_td
	       WHERE cod_dominio = EV_cod_dominio;

	       IF LN_tipo != EN_tipo_ingreso THEN
	          RAISE TIPO_DOMINIO_NO_VALIDO;
	       END IF;

               LN_salida := GE_CHEQUEA_INTEGRIDAD_FN  (EV_cod_dominio,EV_valor);

               DELETE
               ge_valores_dominios_td
               WHERE
               cod_dominio = EV_cod_dominio
               AND valor = EV_valor
               ;

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN TIPO_DOMINIO_NO_VALIDO THEN
	      	RAISE_APPLICATION_ERROR(-20102, 'Error en GE_VALORES_DOMINIOS_KNL_D_PG ' || 'Tipo de dominio no es valido para eliminar');
	      WHEN NO_DATA_FOUND THEN
	      	RAISE_APPLICATION_ERROR(-20101, 'Error en GE_VALORES_DOMINIOS_KNL_D_PG ' || 'Dominio no existe.');
	      WHEN OTHERS THEN

	       RAISE_APPLICATION_ERROR(-20100, 'Error en GE_VALORES_DOMINIOS_KNL_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ELIMINAR_FN;


 END GE_VALORES_DOMINIOS_KNL_D_PG;
/
SHOW ERRORS
