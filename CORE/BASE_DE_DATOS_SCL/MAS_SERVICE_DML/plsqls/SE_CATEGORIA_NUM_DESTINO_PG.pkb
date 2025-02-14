CREATE OR REPLACE PACKAGE BODY SE_CATEGORIA_NUM_DESTINO_PG AS

FUNCTION SE_DETERMINA_GED_PARAM_FN(EO_CATEG_NUM		IN OUT     SE_CATEGORIAS_QT,
		 						   EN_COD_OPERADOR  IN 		   NUMBER,
						   		   SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						         SV_mens_retorno     OUT NOCOPY     ge_errores_pg.msgerror,
						          SN_num_evento       OUT NOCOPY	ge_errores_pg.evento) return BOOLEAN
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_CANAL_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Alejandro Diaz"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	j		   		   number(9);
	LV_variable  	   number ;
	SV_PARAMETROS 	   VARCHAR(512);
	LV_CARACTER    	   number ;
	LN_LUGAR 		   number ;
	LN_NUMBER 		   number ;
	i			   	   number;
	ERROR_PARAMETROS EXCEPTION;


		BEGIN
	        SN_cod_retorno 	:= 0;
        	SV_mens_retorno := ' ';
        	SN_num_evento 	:= 0;
			j:=0;
			i:=1;
			LV_VARIABLE:=NULL;


			IF EN_COD_OPERADOR IS NULL THEN
			   RAISE ERROR_PARAMETROS;
			ELSE

				LV_sSql := 'SELECT(VAL_PARAMETRO)||'',''  ';
				LV_sSql := LV_sSql || ' FROM GED_PARAMETROS  ';
				LV_sSql := LV_sSql || ' WHERE NOM_PARAMETRO = ''OPER_FRECUENTES_MOV''  ';
				LV_sSql := LV_sSql || ' AND COD_MODULO = ''GA'' ';
				LV_sSql := LV_sSql || ' AND COD_PRODUCTO = 1';


				SELECT (VAL_PARAMETRO)||','
				INTO SV_PARAMETROS
				FROM GED_PARAMETROS
				WHERE NOM_PARAMETRO = 'OPER_FRECUENTES_MOV'
				AND COD_MODULO = 'GA'
				AND COD_PRODUCTO = 1;

				 WHILE (i <= LENGTH(SV_PARAMETROS)) LOOP

	                       LV_sSql := 'SELECT INSTR(SV_PARAMETROS,'','',i)  ';
				           LV_sSql := LV_sSql || ' FROM DUAL ';

						   SELECT INSTR(SV_PARAMETROS,',',i)
						   INTO LN_LUGAR FROM DUAL;

						   LN_NUMBER:=TO_NUMBER(SUBSTR(SV_PARAMETROS,i,LN_LUGAR-i));


						 IF LN_NUMBER = EN_COD_OPERADOR THEN
						    EO_CATEG_NUM.COD_CATEGORIA_DEST := 'ONN';
							EO_CATEG_NUM.DES_CATEGORIA := 'ON NET';
  		  	  			    RETURN TRUE;
						ELSE
							i:= LN_LUGAR+1;

					     END IF;
	 	     	  END LOOP;
							EO_CATEG_NUM.COD_CATEGORIA_DEST := 'OFN';
							EO_CATEG_NUM.DES_CATEGORIA := 'OFF NET';
							RETURN TRUE;
		  END IF;


EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_DETERMINA_GED_PARAM_FN(COD_CATEGORIA_DESTINO); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.SE_DETERMINA_GED_PARAM_FN', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 215;

	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  RETURN FALSE;
		  LV_des_error   := 'SE_DETERMINA_GED_PARAM_FN(COD_CATEGORIA_DESTINO); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_CATEGORIA_NUM_DESTINO_PG.SE_DETERMINA_GED_PARAM_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		   RETURN FALSE;
		  LV_des_error   := 'SE_DETERMINA_GED_PARAM_FN(COD_CATEGORIA_DESTINO); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_CATEGORIA_NUM_DESTINO_PG.SE_DETERMINA_GED_PARAM_FN', LV_sSQL, SN_cod_retorno, LV_des_error );

	END SE_DETERMINA_GED_PARAM_FN;
     -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
PROCEDURE SE_DETERMINA_CATEGORIA_PR(EO_CATEG_NUM IN OUT SE_CATEGORIAS_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_CANAL_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Alejandro Diaz"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
	/*
	LV_des_error	 ge_errores_pg.DesEvent;
	LV_sSql			 ge_errores_pg.vQuery;
	v_contador		 number(9);
	error_funcion    EXCEPTION;
	error_rangos     EXCEPTION;
--	b_Bandera 		 boolean;
	LV_TABLA		 VARCHAR2(29);
	LN_OPERADOR		 NUMBER;
	LN_PORTADOR NUMBER;
		BEGIN
	        SN_COD_RETORNO 	:= 0;
        	SV_MENS_RETORNO := ' ';
        	SN_NUM_EVENTO 	:= 0;
--			B_BANDERA := FALSE;

		SELECT CV_NUMINTERNACIONAL AS TABLA,
			   CN_INTERNACIONAL AS OPERADOR,
			   CN_INTERNACIONAL AS PORTADOR
		INTO   LV_TABLA,
			   LN_OPERADOR,
			   LN_PORTADOR
		FROM   TA_NUMINTERNACIONAL A,
			   GE_PAISES B
		WHERE EO_CATEG_NUM.NUM_CELULAR  BETWEEN TO_NUMBER(A.NUM_TDESDE) AND TO_NUMBER(A.NUM_THASTA)
		AND    A.COD_PAIS = B.COD_PAIS
		UNION
		SELECT CV_NUMNACIONAL AS TABLA,
			   A.COD_OPERADOR AS OPERADOR,
			   B.IND_PORTADOR AS CLASIFICACION
		FROM   TA_NUMNACIONAL A,
			   TA_OPERADORES B
		WHERE  EO_CATEG_NUM.NUM_CELULAR BETWEEN TO_NUMBER(NUM_TDESDE) AND TO_NUMBER(NUM_THASTA)
		AND    A.COD_OPERADOR = B.COD_OPERADOR;

		IF LV_TABLA = CV_NUMINTERNACIONAL THEN  -- Si el resultado proviene de la tabla internacional
		   EO_CATEG_NUM.COD_CATEGORIA_DEST := 'INT';
		   EO_CATEG_NUM.DES_CATEGORIA := 'INTERNACIONAL';
		ELSE -- En caso de que sea de numeracion nacional
	   	   IF LN_PORTADOR = CN_RED_FIJA THEN -- Si es de los operadores de red fija
		   	  EO_CATEG_NUM.COD_CATEGORIA_DEST := 'RDF';
		   	  EO_CATEG_NUM.DES_CATEGORIA := 'RED-FIJA';
		   ELSE -- en caso de que no sea red fija
		   	  IF NOT SE_DETERMINA_GED_PARAM_FN(EO_CATEG_NUM, LN_OPERADOR, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO) THEN
	   		  	 RAISE ERROR_FUNCION;
	   		  END IF;
		   END IF;
		END IF;

EXCEPTION
WHEN ERROR_RANGOS THEN
   SN_COD_RETORNO := 666;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
   WHEN ERROR_FUNCION THEN
   SN_COD_RETORNO := 1395;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
	WHEN NO_DATA_FOUND THEN
	      SN_COD_RETORNO := 303;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
	WHEN OTHERS THEN
	      SN_COD_RETORNO := 156;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

	END SE_DETERMINA_CATEGORIA_PR;*/

     -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE SE_DETERMINA_CATEGORIA_PR(EO_CATEG_NUM IN OUT SE_CATEGORIAS_QT,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_CANAL_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Alejandro Diaz"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	 ge_errores_pg.DesEvent;
	LV_sSql			 ge_errores_pg.vQuery;
	v_contador		 number(9);
	error_funcion    EXCEPTION;
	error_categoria  EXCEPTION;
	LV_TABLA		 VARCHAR2(29);
	LV_TIPO_OPERADOR VARCHAR2(10);
		BEGIN
	        SN_COD_RETORNO 	:= 0;
        	SV_MENS_RETORNO := ' ';
        	SN_NUM_EVENTO 	:= 0;

		LV_sSql := ' SELECT '|| CV_NUMINTERNACIONAL||' AS TABLA, ';
		LV_sSql := LV_sSql || CV_INTERNACIONAL ||' AS OPERADOR ';
		LV_sSql := LV_sSql || ' FROM   TA_NUMINTERNACIONAL A, ';
		LV_sSql := LV_sSql || ' GE_PAISES B ';
		LV_sSql := LV_sSql || ' WHERE '|| EO_CATEG_NUM.NUM_CELULAR ||' BETWEEN TO_NUMBER(A.NUM_TDESDE) AND TO_NUMBER(A.NUM_THASTA) ';
		LV_sSql := LV_sSql || ' AND    A.COD_PAIS = B.COD_PAIS ';
		LV_sSql := LV_sSql || ' UNION ';
		LV_sSql := LV_sSql || ' SELECT '||CV_NUMNACIONAL ||' AS TABLA, ';
		LV_sSql := LV_sSql || ' B.COD_TOPE AS OPERADOR ';
		LV_sSql := LV_sSql || ' FROM   TA_NUMNACIONAL A, ';
		LV_sSql := LV_sSql || ' TA_OPERADORES B ';
		LV_sSql := LV_sSql || ' WHERE '|| EO_CATEG_NUM.NUM_CELULAR ||' BETWEEN TO_NUMBER(NUM_TDESDE) AND TO_NUMBER(NUM_THASTA) ';
		LV_sSql := LV_sSql || ' AND    A.COD_OPERADOR = B.COD_OPERADOR';

		SELECT CV_NUMINTERNACIONAL AS TABLA,
			   CV_INTERNACIONAL AS OPERADOR
		INTO   LV_TABLA,
			   LV_TIPO_OPERADOR
		FROM   TA_NUMINTERNACIONAL A,
			   GE_PAISES B
		WHERE EO_CATEG_NUM.NUM_CELULAR  BETWEEN TO_NUMBER(A.NUM_TDESDE) AND TO_NUMBER(A.NUM_THASTA)
		AND    A.COD_PAIS = B.COD_PAIS
		UNION
		SELECT CV_NUMNACIONAL AS TABLA,
			   B.COD_TOPE AS OPERADOR
		FROM   TA_NUMNACIONAL A,
			   TA_OPERADORES B
		WHERE  EO_CATEG_NUM.NUM_CELULAR BETWEEN TO_NUMBER(NUM_TDESDE) AND TO_NUMBER(NUM_THASTA)
		AND    A.COD_OPERADOR = B.COD_OPERADOR;

		IF LV_TABLA = CV_NUMINTERNACIONAL THEN  -- Si el resultado proviene de la tabla internacional
		   EO_CATEG_NUM.COD_CATEGORIA_DEST := 'INT';
		   EO_CATEG_NUM.DES_CATEGORIA := 'INTERNACIONAL';
		ELSE -- En caso de que sea de numeracion nacional
	   	   IF LV_TIPO_OPERADOR = CV_REDFIJA THEN -- Si es de los operadores de red fija
		   	  EO_CATEG_NUM.COD_CATEGORIA_DEST := 'RDF';
		   	  EO_CATEG_NUM.DES_CATEGORIA := 'RED-FIJA';
		   ELSIF LV_TIPO_OPERADOR = CV_PROPIA THEN -- Si es de los operadores Propios
		   	  EO_CATEG_NUM.COD_CATEGORIA_DEST := 'ONN';
		   	  EO_CATEG_NUM.DES_CATEGORIA := 'ON-NET';
		   ELSIF LV_TIPO_OPERADOR = CV_MOVIL THEN -- Si es de los operadores Moviles
		   	  EO_CATEG_NUM.COD_CATEGORIA_DEST := 'OFN';
		   	  EO_CATEG_NUM.DES_CATEGORIA := 'OFF-NET';
		   ELSE
		      RAISE ERROR_CATEGORIA;
	   	   END IF;
		END IF;

EXCEPTION
WHEN ERROR_CATEGORIA THEN
   SN_COD_RETORNO := 666;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
   WHEN ERROR_FUNCION THEN
   SN_COD_RETORNO := 1395;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
	WHEN NO_DATA_FOUND THEN
	      SN_COD_RETORNO := 303;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
	WHEN OTHERS THEN
	      SN_COD_RETORNO := 156;
	      IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
	         SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
	      END IF;
		  LV_DES_ERROR   := 'SE_DETERMINA_CATEGORIA_PR(Lista Catalogos); '||SQLERRM;
	      SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PF_PRODUCTO_OFERTADO_PG.SE_DETERMINA_CATEGORIA_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

	END SE_DETERMINA_CATEGORIA_PR;

END SE_CATEGORIA_NUM_DESTINO_PG;
/
SHOW ERRORS
