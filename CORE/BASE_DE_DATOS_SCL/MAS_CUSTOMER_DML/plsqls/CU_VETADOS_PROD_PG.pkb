CREATE OR REPLACE PACKAGE BODY CU_VETADOS_PROD_PG

AS

PROCEDURE CU_VETADOS_S_PR( EO_ABONADO_VETADO IN 		   CU_VETADOS_PROD_QT,
  							   SO_VETADOS_PROD	OUT NOCOPY refCursor,
						  	   SN_cod_retorno	OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentación
	TipoDoc = "Procedure">>
	<Elemento
		Nombre = "CU_ABOCONTRA_S_PR"
		Lenguaje="PL/SQL"
		Fecha="20-07-2007"
		Versión="La del package"
		Diseñador="Andrés Osorio"
		Programador="Andrés Osorio"
		Ambiente Desarrollo="BD">
		<Retorno>N/A</Retorno>>
		<Descripción>Procedimiento de Consulta de la lista de Abonados Beneficiarios de un Abonado</Descripción>>
		<Parámetros>
		<Entrada>
			<param nom="EO_ABONADO_BENEF" Tipo="estructura">Abonado Contratante</param>>
		</Entrada>
		<Salida>
			<param nom="SO_ABONADOS_PROD" Tipo="Cursor">Lista de Abonados Beneficiarios</param>>
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
v_contador		   number(9);
ERROR_PARAMETROS EXCEPTION;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_ABONADO_VETADO IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE

		LV_sSql := ' SELECT  b.num_celular, ';
		LV_sSql := LV_sSql || ' c.NOM_cliente || c.NOM_APECLIEN1 || c.NOM_APECLIEN2 as nombre, ';
		LV_sSql := LV_sSql || ' b.COD_CLIENTE, ';
		LV_sSql := LV_sSql || ' b.NUM_ABONADO, ';
		LV_sSql := LV_sSql || ' DECODE(a.TIPO_COMPORTAMIENTO,null,N,S) as ind_vetado, ';
		LV_sSql := LV_sSql || ' a.FEC_INICIO_VIGENCIA, ';
		LV_sSql := LV_sSql || ' a.FEC_TERMINO_VIGENCIA ';
		LV_sSql := LV_sSql || ' FROM   CU_VETADOS_PROD_TO a, ga_abocel b, ga_usuarios c ';
		LV_sSql := LV_sSql || ' WHERE  b.COD_CLIENTE = '||EO_ABONADO_VETADO.COD_CLIENTE ;
		LV_sSql := LV_sSql || ' and	   a.cod_cliente(+) = b.cod_cliente ';
		LV_sSql := LV_sSql || ' AND	   a.NUM_ABONADO(+) = b.num_abonado ';
		LV_sSql := LV_sSql || ' AND    sysdate BETWEEN a.fec_inicio_vigencia(+) AND a.fec_termino_vigencia(+) ';
		LV_sSql := LV_sSql || ' AND	   b.cod_usuario = c.cod_usuario ';
		LV_sSql := LV_sSql || ' UNION  ';
		LV_sSql := LV_sSql || ' SELECT  b.num_celular, ';
		LV_sSql := LV_sSql || ' c.NOM_cliente || c.NOM_APECLIEN1 || c.NOM_APECLIEN2 as nombre, ';
		LV_sSql := LV_sSql || ' b.COD_CLIENTE, ';
		LV_sSql := LV_sSql || ' b.NUM_ABONADO, ';
		LV_sSql := LV_sSql || ' DECODE(a.TIPO_COMPORTAMIENTO,null,N,S) as ind_vetado, ';
		LV_sSql := LV_sSql || ' a.FEC_INICIO_VIGENCIA, ';
		LV_sSql := LV_sSql || ' a.FEC_TERMINO_VIGENCIA ';
		LV_sSql := LV_sSql || ' FROM   CU_VETADOS_PROD_TO a, ga_aboamist b, ge_clientes c ';
		LV_sSql := LV_sSql || ' WHERE  b.COD_CLIENTE = '||EO_ABONADO_VETADO.COD_CLIENTE ;
		LV_sSql := LV_sSql || ' and	   a.cod_cliente(+) = b.cod_cliente ';
		LV_sSql := LV_sSql || ' AND	   a.NUM_ABONADO(+) = b.num_abonado ';
		LV_sSql := LV_sSql || ' AND    sysdate BETWEEN a.fec_inicio_vigencia(+) AND a.fec_termino_vigencia(+) ';
		LV_sSql := LV_sSql || ' AND	   b.cod_cliente = c.cod_cliente ';

		OPEN SO_VETADOS_PROD FOR
		SELECT  b.num_celular,
				c.NOM_USUARIO ||' '|| c.NOM_APELLIDO1 ||' '|| c.NOM_APELLIDO2 as nombre,
				b.COD_CLIENTE,
				b.NUM_ABONADO,
				DECODE(a.TIPO_COMPORTAMIENTO,null,'N','S') as ind_vetado,
				a.FEC_INICIO_VIGENCIA,
				a.FEC_TERMINO_VIGENCIA
		FROM   CU_VETADOS_PROD_TO a, ga_abocel b, ga_usuarios c
		WHERE  b.COD_CLIENTE = EO_ABONADO_VETADO.COD_CLIENTE
		AND	   A.COD_CLIENTE(+) = B.COD_CLIENTE
		AND	   a.NUM_ABONADO(+) = b.num_abonado
		AND    sysdate BETWEEN a.fec_inicio_vigencia(+) AND a.fec_termino_vigencia(+)
		AND	   b.cod_usuario = c.cod_usuario
		UNION
		SELECT  b.num_celular,
				c.NOM_cliente ||' '|| c.NOM_APECLIEN1 ||' '|| c.NOM_APECLIEN2 as nombre,
				b.COD_CLIENTE,
				b.NUM_ABONADO,
				DECODE(a.TIPO_COMPORTAMIENTO,null,'N','S') as ind_vetado,
				a.FEC_INICIO_VIGENCIA,
				a.FEC_TERMINO_VIGENCIA
		FROM   CU_VETADOS_PROD_TO a, ga_aboamist b, ge_clientes c
		WHERE  b.COD_CLIENTE = EO_ABONADO_VETADO.COD_CLIENTE
		AND	   A.COD_CLIENTE(+) = B.COD_CLIENTE
		AND	   a.NUM_ABONADO(+) = b.num_abonado
		AND    sysdate BETWEEN a.fec_inicio_vigencia(+) AND a.fec_termino_vigencia(+)
		AND	   b.cod_cliente = c.cod_cliente;

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_VETADOS_S_PR('
					   	   ||EO_ABONADO_VETADO.COD_CLIENTE||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_VETADOS_PROD_PG.CU_VETADOS_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
		SN_cod_retorno := 0;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_VETADOS_S_PR('
					   	   ||EO_ABONADO_VETADO.COD_CLIENTE||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_VETADOS_PROD_PG.CU_VETADOS_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_VETADOS_S_PR('
					   	   ||EO_ABONADO_VETADO.COD_CLIENTE||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_VETADOS_PROD_PG.CU_VETADOS_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_VETADOS_S_PR;

PROCEDURE CU_VETADOS_I_PR( EO_ABONADOS_VETADOS IN		   CU_VETADOS_PROD_LST_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentación
	TipoDoc = "Procedure">>
	<Elemento
		Nombre = "CU_BENEFICIA_I_PR"
		Lenguaje="PL/SQL"
		Fecha="20-07-2007"
		Versión="La del package"
		Diseñador="Andrés Osorio"
		Programador="Andrés Osorio"
		Ambiente Desarrollo="BD">
		<Retorno>N/A</Retorno>>
		<Descripción>Procedimiento de Inserción de la lista de Abonados Beneficiarios de un Abonado</Descripción>>
		<Parámetros>
		<Entrada>
			<param nom="EO_ABONADOS_VETADOS" Tipo="estructura">Lista Abonados Beneficiarios</param>>
		</Entrada>
		<Salida>
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
v_contador		   number(9);
ERROR_PARAMETROS EXCEPTION;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_ABONADOS_VETADOS IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := 'INSERT INTO CU_VETADOS_PROD_TO  ';
		LV_sSql := LV_sSql || ' (COD_CLIENTE, NUM_ABONADO, TIPO_COMPORTAMIENTO, ';
		LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, FEC_TERMINO_VIGENCIA) ';
		LV_sSql := LV_sSql || ' (SELECT A.COD_CLIENTE, A.NUM_ABONADO, A.TIPO_COMPORTAMIENTO, ';
		LV_sSql := LV_sSql || ' A.FEC_INICIO_VIGENCIA, A.FEC_TERMINO_VIGENCIA ';
		LV_sSql := LV_sSql || ' FROM TABLE(CAST(EO_ABONADOS_VETADOS AS CU_VETADOS_PROD_LST_QT)) A) ';

		INSERT INTO CU_VETADOS_PROD_TO
			   (COD_CLIENTE, NUM_ABONADO, TIPO_COMPORTAMIENTO,
			    FEC_INICIO_VIGENCIA, FEC_TERMINO_VIGENCIA)
			   (SELECT A.COD_CLIENTE, A.NUM_ABONADO, A.TIPO_COMPORTAMIENTO,
			   		   A.FEC_INICIO_VIGENCIA, A.FEC_TERMINO_VIGENCIA
				FROM TABLE(CAST(EO_ABONADOS_VETADOS AS CU_VETADOS_PROD_LST_QT)) A);

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_VETADOS_I_PR(Lista de Abonados Vetados); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_VETADOS_PROD_PG.CU_VETADOS_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_VETADOS_I_PR(Lista de Abonados Vetados); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_VETADOS_PROD_PG.CU_VETADOS_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_VETADOS_I_PR;

PROCEDURE CU_VETADOS_U_PR( EO_ABONADO_VETADO IN 		   CU_VETADOS_PROD_QT,
						  	   SN_cod_retorno	 OUT NOCOPY ge_errores_pg.coderror,
						  	   SV_mens_retorno	 OUT NOCOPY ge_errores_pg.msgerror,
						  	   SN_num_evento	 OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentación
	TipoDoc = "Procedure">>
	<Elemento
		Nombre = "CU_ABOCONTRA_D_PR"
		Lenguaje="PL/SQL"
		Fecha="20-07-2007"
		Versión="La del package"
		Diseñador="Andrés Osorio"
		Programador="Andrés Osorio"
		Ambiente Desarrollo="BD">
		<Retorno>N/A</Retorno>>
		<Descripción>Procedimiento de Eliminación de la lista de Abonados Beneficiarios de un Abonado</Descripción>>
		<Parámetros>
		<Entrada>
			<param nom="EO_ABONADOS_VETADOS" Tipo="estructura">Abonado Beneficiarios</param>>
		</Entrada>
		<Salida>
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
v_contador		   number(9);
ERROR_PARAMETROS EXCEPTION;

BEGIN
	SN_cod_retorno 	:= 0;
	SV_mens_retorno := ' ';
	SN_num_evento 	:= 0;

	IF EO_ABONADO_VETADO IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := ' UPDATE CU_VETADOS_PROD_TO ';
		LV_sSql := LV_sSql || ' SET	   FEC_TERMINO_VIGENCIA = '||EO_ABONADO_VETADO.FEC_TERMINO_VIGENCIA;
		LV_sSql := LV_sSql || ' WHERE COD_CLIENTE  = ' || EO_ABONADO_VETADO.COD_CLIENTE;
		LV_sSql := LV_sSql || ' AND NUM_ABONADO = ' || EO_ABONADO_VETADO.NUM_ABONADO;
		LV_sSql := LV_sSql || ' AND TIPO_COMPORTAMIENTO = ' || EO_ABONADO_VETADO.TIPO_COMPORTAMIENTO;
		LV_sSql := LV_sSql || ' AND FEC_INICIO_VIGENCIA = ' || EO_ABONADO_VETADO.FEC_INICIO_VIGENCIA;

		UPDATE CU_VETADOS_PROD_TO
		SET	   FEC_TERMINO_VIGENCIA = EO_ABONADO_VETADO.FEC_TERMINO_VIGENCIA
		WHERE  COD_CLIENTE  = EO_ABONADO_VETADO.COD_CLIENTE
		AND    NUM_ABONADO  = EO_ABONADO_VETADO.NUM_ABONADO
		AND	   TIPO_COMPORTAMIENTO = EO_ABONADO_VETADO.TIPO_COMPORTAMIENTO
		AND	   FEC_INICIO_VIGENCIA = EO_ABONADO_VETADO.FEC_INICIO_VIGENCIA;



	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_VETADOS_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_VETADOS_PROD_PG.CU_VETADOS_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_VETADOS_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_VETADOS_PROD_PG.CU_VETADOS_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_VETADOS_U_PR;

END CU_VETADOS_PROD_PG;
/
SHOW ERRORS
