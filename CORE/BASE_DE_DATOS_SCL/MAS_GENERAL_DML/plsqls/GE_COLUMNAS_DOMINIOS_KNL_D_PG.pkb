CREATE OR REPLACE PACKAGE BODY GE_COLUMNAS_DOMINIOS_KNL_D_PG
IS

  FUNCTION GE_ELIMINAR_FN
               (
                EV_cod_dominio ge_columnas_dominios_td.cod_dominio%TYPE
               ,EV_nom_tabla ge_columnas_dominios_td.nombre_tabla%TYPE
               ,EV_nom_columna ge_columnas_dominios_td.nombre_columna%TYPE
               )
      RETURN NUMBER
	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ELIMINAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina un registro en la tabla GE_COLUMNAS_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio</param>
	<param nom="EN_nom_tabla" Tipo="Number">Nombre de tabla a eliminar</param>
	<param nom="EV_nom_columna" Tipo="STRING">Nombre de columna a eliminar</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN
               DELETE
               ge_columnas_dominios_td
               WHERE
               cod_dominio = EV_cod_dominio
               AND nombre_tabla = EV_nom_tabla
               AND nombre_columna = EV_nom_columna
               ;

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20100, 'Error en GE_COLUMNAS_DOMINIOS_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ELIMINAR_FN;


 END GE_COLUMNAS_DOMINIOS_KNL_D_PG;
/
SHOW ERRORS
