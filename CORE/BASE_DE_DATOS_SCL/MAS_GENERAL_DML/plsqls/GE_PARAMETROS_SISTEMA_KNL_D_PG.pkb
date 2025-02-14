CREATE OR REPLACE PACKAGE BODY GE_PARAMETROS_SISTEMA_KNL_D_PG
IS
  TIPO_PARAMETRO_SISTEMA CONSTANT VARCHAR(2) := 'SS';
  ERROR_PADRE_CON_HIJOS EXCEPTION;

  FUNCTION GE_ELIMINAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
			   ,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
      RETURN NUMBER
	 /*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ELIMINAR_PADRE_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina logicamente  un parametro del tipo multiple (con hijos)/Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo" Tipo="NUMBER">Codigo del parametro</param>
	<param nom="EV_codigo_modulo" Tipo="STRING">Codigo de modulo</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
          LN_total_hijos NUMBER;

	  BEGIN
	       SELECT COUNT(1) INTO LN_total_hijos
	       FROM ge_parametros_td
	       WHERE  cod_parametro_padre = EN_codigo
			   AND tipo_parametro = TIPO_PARAMETRO_SISTEMA
			   AND cod_modulo = EV_codigo_modulo
			   AND ind_hijos = 0;

	       IF LN_total_hijos > 0 THEN
	       	  raise ERROR_PADRE_CON_HIJOS;
	       END IF;

               DELETE ge_parametros_td
               WHERE cod_parametro = EN_codigo
			   AND tipo_parametro = TIPO_PARAMETRO_SISTEMA
			   AND cod_modulo = EV_codigo_modulo
			   AND ind_hijos = 1;

               RETURN  SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN ERROR_PADRE_CON_HIJOS THEN
	              RAISE_APPLICATION_ERROR(-20102, 'Error en GE_PARAMETROS_SISTEMA_D_PG 20102: El registro a eliminar posee dependencia con otros registros.');
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_PARAMETROS_SISTEMA_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ELIMINAR_PADRE_FN;

  FUNCTION GE_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
			   ,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
      RETURN NUMBER
	 /*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ELIMINAR_PADRE_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina logicamente  un parametro del tipo multiple (con hijos)/Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo_padre" Tipo="NUMBER">Codigo padre del parametro</param>
	<param nom="EN_codigo_hijo" Tipo="NUMBER">Codigo del parametro a eliminar</param>
	<param nom="EV_codigo_modulo" Tipo="STRING">Codigo de modulo</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN

               DELETE ge_parametros_td
               WHERE cod_parametro = EN_codigo_hijo
			   AND cod_parametro_padre = EN_codigo_padre
			   AND tipo_parametro = TIPO_PARAMETRO_SISTEMA
			   AND cod_modulo = EV_codigo_modulo
			   AND ind_hijos = 0;

               RETURN  SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_PARAMETROS_SISTEMA_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ELIMINAR_HIJO_FN;

 END GE_PARAMETROS_SISTEMA_KNL_D_PG;
/
SHOW ERRORS
