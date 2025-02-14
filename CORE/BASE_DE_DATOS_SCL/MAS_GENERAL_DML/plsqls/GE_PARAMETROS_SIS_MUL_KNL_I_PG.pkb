CREATE OR REPLACE PACKAGE BODY GE_PARAMETROS_SIS_MUL_KNL_I_PG
IS
  TIPO_PARAMETRO_SISTEMA_MUL CONSTANT VARCHAR2(2) := 'SM';
  ERROR_PARAMETROS EXCEPTION;

  FUNCTION GE_AGREGAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
                ,EV_nombre IN ge_parametros_td.nom_parametro%TYPE
				,EV_descripcion IN ge_parametros_td.des_parametro%TYPE
				,EV_cod_dominio IN ge_parametros_td.cod_dominio%TYPE
				,EV_tipo_valor IN ge_parametros_td.tipo_valor%TYPE
				,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
      RETURN NUMBER
	 /*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_AGREGAR_PADRE_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega un parametro del tipo multiple (con hijos)/Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo" Tipo="NUMBER">Codigo del parametro</param>
	<param nom="EV_nombre" Tipo="STRING">Nombre del parametro</param>
	<param nom="EV_descripcion" Tipo="STRING">Nombre del parametro</param>
	<param nom="EV_cod_modulo" Tipo="STRING">Codigo de modulo</param>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio</param>
	<param nom="EV_tipo_valor" Tipo="STRING">Tipo de dato que representa el valor del parametro. N=numerico, C=texto o D=fecha</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN
	  	 IF EV_cod_dominio IS NULL
		  AND EV_tipo_valor = 'O'
	     THEN
		 	     raise ERROR_PARAMETROS;
		 ELSIF EV_cod_dominio IS NOT NULL
		  AND EV_tipo_valor <> 'O'
		 THEN
  		 	     raise ERROR_PARAMETROS;
	     END IF;

               INSERT INTO ge_parametros_td
               (
                cod_parametro
			   ,nom_parametro
			   ,des_parametro
			   ,cod_modulo
   			   ,tipo_parametro
			   ,cod_dominio_padre
			   ,valor_numerico
			   ,valor_texto
			   ,valor_fecha
			   ,tipo_valor
			   ,vigencia_desde
			   ,vigencia_hasta
			   ,cod_parametro_padre
			   ,valor_dominio
			   ,cod_dominio
			   ,cod_operadora
			   ,ind_hijos
               )
               VALUES
               (
		    	EN_codigo
			   ,EV_nombre
			   ,EV_descripcion
			   ,EV_codigo_modulo
			   ,TIPO_PARAMETRO_SISTEMA_MUL
			   ,EV_cod_dominio
                           ,NULL
			   ,NULL
			   ,NULL
			   ,EV_tipo_valor
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL
			   ,1
               );

               RETURN  SQL%ROWCOUNT;

	  EXCEPTION
          WHEN ERROR_PARAMETROS THEN
	            RAISE_APPLICATION_ERROR(-20101, 'Error en GE_PARAMETROS_SISTEMA_MUL_I_PG 20101: Error en parametros');
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_PARAMETROS_SISTEMA_MUL_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_AGREGAR_PADRE_FN;


 FUNCTION GE_AGREGAR_HIJO_FN
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
		,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
      RETURN NUMBER
	 /*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_AGREGAR_HIJO_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega un parametro del tipo multiple (con hijos)/Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo_padre" Tipo="NUMBER">Codigo de parametro padre para ser asociado al nuevo registro</param>
	<param nom="EN_codigo_hijo" Tipo="NUMBER">Codigo de parametro nuevo a insertar</param>
	<param nom="EN_valor_numerico" Tipo="NUMBER">Valor del par metro. Esta columna se poblar  solo si el valor del parametro es numerico</param>
	<param nom="EV_valor_texto" Tipo="STRING">Valor del par metro. Esta columna se poblar  solo si el valor del parametro es un string</param>
	<param nom="ED_valor_fecha" Tipo="DATE">Valor del par metro. Esta columna se poblar  solo si el valor del parametro es una fecha</param>
	<param nom="EV_tipo_valor" Tipo="STRING">Tipo de dato que representa el valor del parametro. N=numerico, C=texto o D=fecha</param>
	<param nom="EV_vigencia_desde" Tipo="DATE">Fecha de inicio de vigencia del par metro</param>
	<param nom="EV_vigencia_hasta" Tipo="DATE">Fecha de termino de vigencia del par metro</param>
	<param nom="EV_valor_dominio Tipo="STRING">Valor que corresponde a un dominio definido en la tabla GE_VALORES_DOMINIOS_TD</param>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio</param>
	<param nom="EV_cod_operadora" Tipo="STRING">Codigo de operadora que referencia el parametro</param>
	<param nom="EV_cod_modulo" Tipo="STRING">Codigo de modulo</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN
	     IF EN_valor_numerico IS NULL
		  AND EV_valor_texto IS NULL
		  AND ED_valor_fecha IS NOT NULL
		  AND EV_valor_dominio IS NULL
	     THEN
	        IF EV_tipo_valor <> 'D'  THEN
		     raise ERROR_PARAMETROS;
		    END IF;
		 ELSIF  EN_valor_numerico IS NULL
          AND ED_valor_fecha IS NULL
		  AND EV_valor_texto IS NOT NULL
		  AND EV_valor_dominio IS NULL
		 THEN
	        IF EV_tipo_valor <> 'C'  THEN
		      raise ERROR_PARAMETROS;
		    END IF;
		ELSIF   EN_valor_numerico IS NOT NULL
          AND ED_valor_fecha IS NULL
		  AND EV_valor_texto IS NULL
		  AND EV_valor_dominio IS NULL
		THEN
	       IF EV_tipo_valor <> 'N'  THEN
		     raise ERROR_PARAMETROS;
		   END IF;
		ELSIF   EN_valor_numerico IS NULL
          AND ED_valor_fecha IS NULL
		  AND EV_valor_texto IS NULL
		  AND EV_valor_dominio IS NOT NULL
		THEN
	       IF EV_tipo_valor <> 'O'  THEN
		     raise ERROR_PARAMETROS;
		   END IF;
		ELSE
		   --Error por que s¢lo un valor debe tener informaci¢n
		    raise ERROR_PARAMETROS;
		END IF;

               INSERT INTO ge_parametros_td
               (
                cod_parametro
			   ,nom_parametro
			   ,des_parametro
			   ,cod_modulo
   			   ,tipo_parametro
			   ,cod_dominio_padre
			   ,valor_numerico
			   ,valor_texto
			   ,valor_fecha
			   ,tipo_valor
			   ,vigencia_desde
			   ,vigencia_hasta
			   ,cod_parametro_padre
			   ,valor_dominio
			   ,cod_dominio
			   ,cod_operadora
			   ,ind_hijos
               )
               VALUES
               (
		    	EN_codigo_hijo
			   ,NULL
			   ,NULL
			   ,EV_codigo_modulo
			   ,TIPO_PARAMETRO_SISTEMA_MUL
			   ,NULL
               ,EN_valor_numerico
			   ,EV_valor_texto
			   ,ED_valor_fecha
			   ,NULL
			   ,ED_vigencia_desde
			   ,ED_vigencia_hasta
			   ,EN_codigo_padre
			   ,EV_valor_dominio
			   ,EV_cod_dominio
			   ,EV_cod_operadora
			   ,0
               );

               RETURN  SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN ERROR_PARAMETROS THEN
	            RAISE_APPLICATION_ERROR(-20101, 'Error en GE_PARAMETROS_SISTEMA_MUL_I_PG 20101: Error en parametros');
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_PARAMETROS_SISTEMA_MUL_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_AGREGAR_HIJO_FN;
 END GE_PARAMETROS_SIS_MUL_KNL_I_PG;
/
SHOW ERRORS
