CREATE OR REPLACE PACKAGE BODY GE_PARAMETROS_SIM_KNL_U_PG
IS
  TIPO_PARAMETRO_MODIFICABLE CONSTANT VARCHAR(2) := 'MS';
  ERROR_PARAMETROS EXCEPTION;
  ERROR_PADRE_CON_HIJOS EXCEPTION;
  ERROR_REGISTRO_CON_DETALLE EXCEPTION;
  FUNCTION GE_ACTUALIZAR_PADRE_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro%TYPE
			    ,EV_descripcion IN ge_parametros_td.des_parametro%TYPE
				,EV_cod_dominio IN ge_parametros_td.cod_dominio%TYPE
				,EV_tipo_valor IN ge_parametros_td.tipo_valor%TYPE
				,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
  RETURN NUMBER
  	 /*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ACTUALIZAR_HIJO_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Actualiza informacion de parametros vigentes del tipo multiple (con hijos)/Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo_padre" Tipo="NUMBER">Codigo de parametro padre para ser asociado al registro</param>
	<param nom="EV_descripcion" Tipo="STRING">Codigo de modulo que referencia el parametro</param>
	<param nom="EV_codigo_modulo" Tipo="STRING">Codigo de modulo que referencia el parametro</param>
    <param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio</param>
	<param nom="EV_tipo_valor" Tipo="STRING">Tipo de dato que representa el valor del parametro. N=numerico, C=texto, D=fecha u O=Dominio</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/


  IS
  	LN_total_hijos NUMBER(5);
	LN_total NUMBER(5);
	  BEGIN
           SELECT COUNT(1) INTO LN_total_hijos
	       FROM ge_parametros_td
	       WHERE  cod_parametro_padre = EN_codigo_padre
			   AND tipo_parametro = TIPO_PARAMETRO_MODIFICABLE
			   AND cod_modulo = EV_codigo_modulo
			   AND ind_hijos = 0;


	       IF LN_total_hijos > 0 THEN
		   	  SELECT COUNT(1) INTO LN_total
	       	  FROM ge_parametros_td
	       	  WHERE  cod_parametro = EN_codigo_padre
			   AND tipo_parametro = TIPO_PARAMETRO_MODIFICABLE
			   AND cod_modulo = EV_codigo_modulo
			   AND ind_hijos = 1
			   AND (cod_dominio_padre <> EV_cod_dominio
			   OR tipo_valor <> EV_tipo_valor);
			   --Si tiene hijos y se modifica dominio o tipo es un error
			   IF LN_total > 0 THEN
    	       	  raise ERROR_PADRE_CON_HIJOS;
			   END IF;
	       END IF;

		   IF EV_cod_dominio IS NULL
			  AND EV_tipo_valor = 'O'
		     THEN
			 	     raise ERROR_PARAMETROS;
		   ELSIF EV_cod_dominio IS NOT NULL
			  AND EV_tipo_valor <> 'O'
			 THEN
	  		 	     raise ERROR_PARAMETROS;
		   END IF;

            UPDATE ge_parametros_td
               SET
                 des_parametro = EV_descripcion
				 ,cod_dominio_padre = EV_cod_dominio
				 ,tipo_valor = EV_tipo_valor
               WHERE cod_parametro = EN_codigo_padre
           AND tipo_parametro = TIPO_PARAMETRO_MODIFICABLE
	       AND cod_modulo = EV_codigo_modulo
	       AND ind_hijos = 1;

               RETURN  SQL%ROWCOUNT;

	  EXCEPTION
	  	  WHEN ERROR_PADRE_CON_HIJOS THEN
		      RAISE_APPLICATION_ERROR(-20110, 'Error en GE_PARAMETROS_SIMPLES_U_PG 20100: No se puede modificar dominio o tipo por existir valores asociados');
		  WHEN ERROR_PARAMETROS THEN
	            RAISE_APPLICATION_ERROR(-20101, 'Error en GE_PARAMETROS_SIMPLES_U_PG 20101: Error en parametros');
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_PARAMETROS_SIMPLES_U_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ACTUALIZAR_PADRE_FN;


  FUNCTION GE_ACTUALIZAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
		,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
		,EN_valor_numerico IN ge_parametros_td.valor_numerico%TYPE
		,EV_valor_texto IN ge_parametros_td.valor_texto%TYPE
		,ED_valor_fecha IN ge_parametros_td.valor_fecha%TYPE
		,EV_tipo_valor IN ge_parametros_td.tipo_valor%TYPE
		,ED_vigencia_desde IN ge_parametros_td.vigencia_desde%TYPE
		,ED_vigencia_hasta IN ge_parametros_td.vigencia_hasta%TYPE
		,EV_valor_dominio IN ge_parametros_td.valor_dominio%TYPE
		,EV_cod_operadora IN ge_parametros_td.cod_operadora%TYPE
		,EV_codigo_modulo IN ge_parametros_td.cod_modulo%TYPE
               )
      RETURN NUMBER
	 /*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ACTUALIZAR_HIJO_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Actualiza informacion de parametros vigentes del tipo multiple (con hijos)/Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EN_codigo_padre" Tipo="NUMBER">Codigo de parametro padre para ser asociado al registro</param>
	<param nom="EN_codigo_hijo" Tipo="NUMBER">Codigo de parametro nuevo a modificar</param>
	<param nom="EN_valor_numerico" Tipo="NUMBER">Valor del par metro. Esta columna se poblar  solo si el valor del parametro es numerico</param>
	<param nom="EV_valor_texto" Tipo="STRING">Valor del par metro. Esta columna se poblar  solo si el valor del parametro es un string</param>
	<param nom="ED_valor_fecha" Tipo="DATE">Valor del par metro. Esta columna se poblar  solo si el valor del parametro es una fecha</param>
	<param nom="EV_tipo_valor" Tipo="STRING">Tipo de dato que representa el valor del parametro. N=numerico, C=texto o D=fecha</param>
	<param nom="EV_vigencia_desde" Tipo="DATE">Fecha de inicio de vigencia del par metro</param>
	<param nom="EV_vigencia_hasta" Tipo="DATE">Fecha de termino de vigencia del par metro</param>
	<param nom="EV_valor_dominio Tipo="STRING">Valor que corresponde a un dominio definido en la tabla GE_VALORES_DOMINIOS_TD</param>
	<param nom="EV_cod_operadora" Tipo="STRING">Codigo de operadora que referencia el parametro</param>
	<param nom="EV_codigo_modulo" Tipo="STRING">Codigo de modulo que referencia el parametro</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
        LV_tipo_valor VARCHAR2(1);
	    LN_vigencia NUMBER(1);
		LN_total_registros NUMBER(5);
		LV_cod_operadora ge_parametros_td.cod_operadora%type;
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

		SELECT cod_operadora INTO LV_cod_operadora
		FROM ge_parametros_td
		WHERE cod_parametro_padre = EN_codigo_padre
		AND cod_parametro = EN_codigo_hijo
		AND cod_modulo = EV_codigo_modulo
		AND tipo_parametro = TIPO_PARAMETRO_MODIFICABLE;

		IF LV_cod_operadora <> EV_cod_operadora THEN
			IF EV_cod_operadora IS NULL THEN
				SELECT COUNT(1)
				INTO LN_total_registros
				FROM ge_parametros_td
				WHERE cod_parametro_padre = EN_codigo_padre
				AND cod_operadora IS NULL
				AND cod_modulo = EV_codigo_modulo
				AND tipo_parametro = TIPO_PARAMETRO_MODIFICABLE
				AND ind_hijos = 0;
			ELSE
				SELECT COUNT(1)
				INTO LN_total_registros
				FROM ge_parametros_td
				WHERE cod_parametro_padre = EN_codigo_padre
				AND cod_operadora = EV_cod_operadora
				AND cod_modulo = EV_codigo_modulo
				AND tipo_parametro = TIPO_PARAMETRO_MODIFICABLE
				AND ind_hijos = 0;
			END IF;

			IF LN_total_registros > 0 THEN
			   raise ERROR_REGISTRO_CON_DETALLE;
			END IF;
		END IF;

            UPDATE ge_parametros_td
               SET
                 valor_numerico = EN_valor_numerico
                 ,valor_texto = EV_valor_texto
                 ,valor_fecha = ED_valor_fecha
                 ,tipo_valor = EV_tipo_valor
		 ,vigencia_desde = ED_vigencia_desde
		 ,vigencia_hasta = ED_vigencia_hasta
		 ,valor_dominio = EV_valor_dominio
		 ,cod_operadora = EV_cod_operadora
               WHERE cod_parametro = EN_codigo_hijo
               AND cod_parametro_padre = EN_codigo_padre
	       AND tipo_parametro = TIPO_PARAMETRO_MODIFICABLE
	       AND cod_modulo = EV_codigo_modulo
	       AND ind_hijos = 0;

               RETURN  SQL%ROWCOUNT;

	  EXCEPTION
	     WHEN ERROR_REGISTRO_CON_DETALLE THEN
		        RAISE_APPLICATION_ERROR(-20101, 'Error en GE_PARAMETROS_SIMPLES_U_PG 20101: Error registro ya existe');
	      WHEN ERROR_PARAMETROS THEN
	            RAISE_APPLICATION_ERROR(-20101, 'Error en GE_PARAMETROS_SIMPLES_U_PG 20101: Error en parametros');
	      WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_PARAMETROS_SIMPLES_U_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ACTUALIZAR_HIJO_FN;


 END GE_PARAMETROS_SIM_KNL_U_PG;
/
SHOW ERRORS
