CREATE OR REPLACE PACKAGE BODY SC_PARAMETROS_MULTIPLES_I_PG
IS

  CODIGO_MODULO CONSTANT VARCHAR2(2) := 'SC';

  FUNCTION SC_AGREGAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
                ,EV_nombre IN ge_parametros_td.nom_parametro%TYPE
				,EV_descripcion IN ge_parametros_td.des_parametro%TYPE
				,EV_cod_dominio IN ge_parametros_td.cod_dominio%TYPE
				,EV_tipo_valor IN ge_parametros_td.tipo_valor%TYPE
               )
      RETURN NUMBER
	 /*<Documentacion TipoDoc = "Funci�n">
	<Elemento Nombre = "SC_AGREGAR_PADRE_FN" Lenguaje="PL/SQL" Fecha="" Versi�n"1.0.0" Dise�ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega un parametro del tipo multiple (con hijos)/Descripci�n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo" Tipo="NUMBER">Codigo del parametro</param>
	<param nom="EV_nombre" Tipo="STRING">Nombre del parametro</param>
	<param nom="EV_descripcion" Tipo="STRING">Nombre del parametro</param>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio</param>
	<param nom="EV_tipo_valor" Tipo="STRING">Tipo de dato que representa el valor del parametro. N=numerico, C=texto o D=fecha</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci�n>
	*/
  IS
      LN_registros_afectados NUMBER;
	  BEGIN

              LN_registros_afectados := GE_PARAMETROS_MUL_KNL_I_PG.GE_AGREGAR_PADRE_FN
               (EN_codigo
                ,EV_nombre
				,EV_descripcion
				,EV_cod_dominio
				,EV_tipo_valor
		    	,CODIGO_MODULO
               );

               RETURN  LN_registros_afectados;

	  EXCEPTION
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en SC_PARAMETROS_MULTIPLES_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END SC_AGREGAR_PADRE_FN;


 FUNCTION SC_AGREGAR_HIJO_FN
	       (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
		,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
		,EN_valor_numerico IN ge_parametros_td.valor_numerico%TYPE
		,EV_valor_texto IN ge_parametros_td.valor_texto%TYPE
		,ED_valor_fecha IN ge_parametros_td.valor_fecha%TYPE
		,EV_tipo_valor IN ge_parametros_td.tipo_valor%TYPE
		,ED_vigencia_desde IN ge_parametros_td.vigencia_desde%TYPE
		,ED_vigencia_hasta IN ge_parametros_td.vigencia_hasta%TYPE
		,EV_valor_dominio IN ge_parametros_td.valor_dominio%TYPE
		,EV_cod_dominio IN ge_parametros_td.cod_dominio%TYPE
		,EV_cod_operadora IN ge_parametros_td.cod_operadora%TYPE
               )
      RETURN NUMBER
	 /*<Documentacion TipoDoc = "Funci�n">
	<Elemento Nombre = "SC_AGREGAR_HIJO_FN" Lenguaje="PL/SQL" Fecha="" Versi�n"1.0.0" Dise�ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega un parametro del tipo multiple (con hijos)/Descripci�n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo_padre" Tipo="NUMBER">Codigo de parametro padre para ser asociado al nuevo registro</param>
	<param nom="EN_codigo_hijo" Tipo="NUMBER">Codigo de parametro nuevo a insertar</param>
	<param nom="EN_valor_numerico" Tipo="NUMBER">Valor del par�metro. Esta columna se poblar� solo si el valor del parametro es numerico</param>
	<param nom="EV_valor_texto" Tipo="STRING">Valor del par�metro. Esta columna se poblar� solo si el valor del parametro es un string</param>
	<param nom="ED_valor_fecha" Tipo="DATE">Valor del par�metro. Esta columna se poblar� solo si el valor del parametro es una fecha</param>
	<param nom="EV_tipo_valor" Tipo="STRING">Tipo de dato que representa el valor del parametro. N=numerico, C=texto o D=fecha</param>
	<param nom="EV_vigencia_desde" Tipo="DATE">Fecha de inicio de vigencia del par�metro</param>
	<param nom="EV_vigencia_hasta" Tipo="DATE">Fecha de termino de vigencia del par�metro</param>
	<param nom="EV_valor_dominio Tipo="STRING">Valor que corresponde a un dominio definido en la tabla GE_VALORES_DOMINIOS_TD</param>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio</param>
	<param nom="EV_cod_operadora" Tipo="STRING">Codigo de operadora que referencia el parametro</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci�n>
	*/
  IS
  LN_registros_afectados NUMBER;
	  BEGIN
	          LN_registros_afectados := GE_PARAMETROS_MUL_KNL_I_PG.GE_AGREGAR_HIJO_FN
	       (EN_codigo_padre
			,EN_codigo_hijo
			,EN_valor_numerico
			,EV_valor_texto
			,ED_valor_fecha
			,EV_tipo_valor
			,ED_vigencia_desde
			,ED_vigencia_hasta
			,EV_valor_dominio
			,EV_cod_dominio
			,EV_cod_operadora
			,CODIGO_MODULO
               );

               RETURN  LN_registros_afectados;

	  EXCEPTION
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en SC_PARAMETROS_MULTIPLES_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END SC_AGREGAR_HIJO_FN;
 END SC_PARAMETROS_MULTIPLES_I_PG;
/
SHOW ERRORS
