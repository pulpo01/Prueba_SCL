CREATE OR REPLACE PACKAGE BODY CU_BENEF_PROD_PG

AS

PROCEDURE CU_ABOCONTRA_S_PR(    EO_ABONADO_BENEF IN         CU_BENEF_PROD_QT,
								SO_ABONADOS_PROD OUT NOCOPY refCursor,
								SN_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
								SV_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
								SN_num_evento    OUT NOCOPY	ge_errores_pg.evento)
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

	IF EO_ABONADO_BENEF IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := 'SELECT COD_CLIENTE_CONTRATANTE,';
		LV_sSql := LV_sSql || ' NUM_ABONADO_CONTRATANTE,';
		LV_sSql := LV_sSql || ' TIPO_COMPORTAMIENTO,';
		LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA,';
		LV_sSql := LV_sSql || ' NUM_ABONADO_BENEFICIARIO,';
		LV_sSql := LV_sSql || ' FEC_TERMINO_VIGENCIA';
		LV_sSql := LV_sSql || ' FROM CU_BENEF_PROD_TO';
		LV_sSql := LV_sSql || ' WHERE COD_CLIENTE_CONTRATANTE = '||EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE;
		LV_sSql := LV_sSql || ' AND NUM_ABONADO_CONTRATANTE = '||EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE;
		LV_sSql := LV_sSql || ' AND	   sysdate BETWEEN a.FEC_INICIO_VIGENCIA and a.FEC_TERMINO_VIGENCIA ';

		OPEN SO_ABONADOS_PROD FOR
		SELECT  b.num_celular,
				c.NOM_USUARIO ||' '|| c.NOM_APELLIDO1 ||' '|| c.NOM_APELLIDO2 as nombre,
				a.COD_CLIENTE_CONTRATANTE,
				a.NUM_ABONADO_CONTRATANTE,
				a.TIPO_COMPORTAMIENTO,
				a.FEC_INICIO_VIGENCIA,
				a.NUM_ABONADO_BENEFICIARIO,
				a.FEC_TERMINO_VIGENCIA
		FROM   CU_BENEF_PROD_TO a, ga_abocel b, ga_usuarios c
		WHERE  COD_CLIENTE_CONTRATANTE = EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE
		AND	   NUM_ABONADO_CONTRATANTE = EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE
		AND	   sysdate BETWEEN a.FEC_INICIO_VIGENCIA and a.FEC_TERMINO_VIGENCIA
		AND	   a.NUM_ABONADO_BENEFICIARIO = b.num_abonado
		AND	   b.cod_usuario = c.cod_usuario
		UNION
		SELECT  b.num_celular,
				c.NOM_cliente ||' '|| c.NOM_APECLIEN1 ||' '|| c.NOM_APECLIEN2 as nombre,
				a.COD_CLIENTE_CONTRATANTE,
				a.NUM_ABONADO_CONTRATANTE,
				a.TIPO_COMPORTAMIENTO,
				a.FEC_INICIO_VIGENCIA,
				a.NUM_ABONADO_BENEFICIARIO,
				a.FEC_TERMINO_VIGENCIA
		FROM   CU_BENEF_PROD_TO a, ga_aboamist b, ge_clientes c
		WHERE  COD_CLIENTE_CONTRATANTE = EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE
		AND	   NUM_ABONADO_CONTRATANTE = EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE
		AND	   sysdate BETWEEN a.FEC_INICIO_VIGENCIA and a.FEC_TERMINO_VIGENCIA
		AND	   a.NUM_ABONADO_BENEFICIARIO = b.num_abonado
		AND	   b.cod_cliente = c.cod_cliente;

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_ABOCONTRA_S_PR('
					   	   ||EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE||','
						   ||EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_ABOCONTRA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
		SN_cod_retorno := 0;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_ABOCONTRA_S_PR('
					   	   ||EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE||','
						   ||EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_ABOCONTRA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_ABOCONTRA_S_PR('
					   	   ||EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE||','
						   ||EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_ABOCONTRA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_ABOCONTRA_S_PR;

PROCEDURE CU_BENEFICIA_S_PR(    EN_NUMCELULAR 	 IN         NUMBER,
								SO_ABONADOS_PROD OUT NOCOPY refCursor,
								SN_cod_retorno   OUT NOCOPY ge_errores_pg.coderror,
								SV_mens_retorno  OUT NOCOPY ge_errores_pg.msgerror,
								SN_num_evento    OUT NOCOPY	ge_errores_pg.evento)
IS
/*
<Documentación
	TipoDoc = "Procedure">>
	<Elemento
		Nombre = "CU_BENEFICIA_S_PR"
		Lenguaje="PL/SQL"
		Fecha="20-07-2007"
		Versión="La del package"
		Diseñador="Andrés Osorio"
		Programador="Andrés Osorio"
		Ambiente Desarrollo="BD">
		<Retorno>N/A</Retorno>>
		<Descripción>Procedimiento de Consulta los datos de un Abonado Beneficiario</Descripción>>
		<Parámetros>
		<Entrada>
			<param nom="EO_ABONADO_BENEF" Tipo="estructura">Número de Celular</param>>
		</Entrada>
		<Salida>
			<param nom="SO_ABONADOS_PROD" Tipo="Cursor">Abonado Beneficiario</param>>
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

	IF EN_NUMCELULAR IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := 'SELECT a.num_celular, a.num_abonado, a.cod_cliente, ';
		LV_sSql := LV_sSql || ' b.nom_usuario + b.nom_apellido1 + b.nom_apellido2 AS nombre';
		LV_sSql := LV_sSql || ' FROM   ga_abocel a, ga_usuarios b';
		LV_sSql := LV_sSql || ' WHERE  a.cod_usuario = b.cod_usuario';
		LV_sSql := LV_sSql || ' AND	   a.num_celular = ' || EN_NUMCELULAR;
		LV_sSql := LV_sSql || ' AND	   a.cod_situacion NOT IN (' || CV_SituaBaja||','||CV_SituaBajaPendiente||')';
		LV_sSql := LV_sSql || ' UNION';
		LV_sSql := LV_sSql || ' SELECT a.num_celular, a.num_abonado, a.cod_cliente, _ as nombre';
		LV_sSql := LV_sSql || ' FROM ga_aboamist a';
		LV_sSql := LV_sSql || ' WHERE a.num_celular = ' || EN_NUMCELULAR;
		LV_sSql := LV_sSql || ' AND	   a.cod_situacion NOT IN (' || CV_SituaBaja||','||CV_SituaBajaPendiente||')';

		OPEN SO_ABONADOS_PROD FOR
		SELECT a.num_celular, a.num_abonado, a.cod_cliente,
			   b.nom_usuario || ' ' || b.nom_apellido1 || ' ' || nvl(b.nom_apellido2,'') AS nombre
		FROM   ga_abocel a, ga_usuarios b
		WHERE  a.cod_usuario = b.cod_usuario
		AND	   a.num_celular = EN_NUMCELULAR
		AND	   a.cod_situacion NOT IN (CV_SituaBaja,CV_SituaBajaPendiente)
		UNION
		SELECT a.num_celular, a.num_abonado, a.cod_cliente,
			   b.nom_cliente ||' '|| b.nom_apeclien1 ||' '|| b.nom_apeclien2 AS nombre
		FROM   ga_aboamist a, ge_clientes b
		WHERE  a.num_celular = EN_NUMCELULAR
		AND	   a.cod_cliente = b.cod_cliente
		AND	   a.cod_situacion NOT IN (CV_SituaBaja,CV_SituaBajaPendiente);

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_BENEFICIA_S_PR('||EN_NUMCELULAR||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_BENEFICIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
		SN_cod_retorno := 0;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_BENEFICIA_S_PR('||EN_NUMCELULAR||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_BENEFICIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_BENEFICIA_S_PR('||EN_NUMCELULAR||'); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_BENEFICIA_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_BENEFICIA_S_PR;

PROCEDURE CU_BENEFICIA_I_PR(    EO_ABONADOS_BENEF IN 	     CU_BENEF_PROD_QT_LISTA_QT,
								SN_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
								SV_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
								SN_num_evento     OUT NOCOPY ge_errores_pg.evento)
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
			<param nom="EO_ABONADOS_BENEF" Tipo="estructura">Lista Abonados Beneficiarios</param>>
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

	IF EO_ABONADOS_BENEF IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := 'INSERT INTO CU_BENEF_PROD_TO ';
		LV_sSql := LV_sSql || ' (COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, TIPO_COMPORTAMIENTO, ';
		LV_sSql := LV_sSql || ' FEC_INICIO_VIGENCIA, NUM_ABONADO_BENEFICIARIO, FEC_TERMINO_VIGENCIA)';
		LV_sSql := LV_sSql || ' (SELECT A.COD_CLIENTE_CONTRATANTE, A.NUM_ABONADO_CONTRATANTE, A.TIPO_COMPORTAMIENTO, ';
		LV_sSql := LV_sSql || ' A.FEC_INICIO_VIGENCIA, A.NUM_ABONADO_BENEFICIARIO, A.FEC_TERMINO_VIGENCIA';
		LV_sSql := LV_sSql || ' FROM TABLE(CAST(EO_ABONADOS_BENEF AS CU_BENEF_PROD_QT_LISTA_QT)) A) ';

		INSERT INTO CU_BENEF_PROD_TO
			   (COD_CLIENTE_CONTRATANTE, NUM_ABONADO_CONTRATANTE, TIPO_COMPORTAMIENTO,
			    FEC_INICIO_VIGENCIA, NUM_ABONADO_BENEFICIARIO, FEC_TERMINO_VIGENCIA)
			   (SELECT A.COD_CLIENTE_CONTRATANTE, A.NUM_ABONADO_CONTRATANTE, A.TIPO_COMPORTAMIENTO,
			   		   A.FEC_INICIO_VIGENCIA, A.NUM_ABONADO_BENEFICIARIO, A.FEC_TERMINO_VIGENCIA
				FROM TABLE(CAST(EO_ABONADOS_BENEF AS CU_BENEF_PROD_QT_LISTA_QT)) A);

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_BENEFICIA_I_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_BENEFICIA_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_BENEFICIA_I_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_BENEFICIA_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_BENEFICIA_I_PR;

PROCEDURE CU_BENEFICIA_U_PR(    EO_ABONADO_BENEF  IN	     CU_BENEF_PROD_QT,
								SN_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
								SV_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
								SN_num_evento     OUT NOCOPY ge_errores_pg.evento)
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
			<param nom="EO_ABONADO_BENEF" Tipo="estructura">Abonado Beneficiarios</param>>
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

	IF EO_ABONADO_BENEF IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := ' UPDATE CU_BENEF_PROD_TO';
		LV_sSql := LV_sSql || ' SET	   FEC_TERMINO_VIGENCIA = '||EO_ABONADO_BENEF.FEC_TERMINO_VIGENCIA;
		LV_sSql := LV_sSql || ' WHERE COD_CLIENTE_CONTRATANTE  = ' || EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE;
		LV_sSql := LV_sSql || ' AND NUM_ABONADO_CONTRATANTE  = ' || EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE;
		LV_sSql := LV_sSql || ' AND NUM_ABONADO_BENEFICIARIO = ' || EO_ABONADO_BENEF.NUM_ABONADO_BENEFICIARIO;

		UPDATE CU_BENEF_PROD_TO
		SET	   FEC_TERMINO_VIGENCIA = EO_ABONADO_BENEF.FEC_TERMINO_VIGENCIA
		WHERE  COD_CLIENTE_CONTRATANTE  = EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE
		AND	   NUM_ABONADO_CONTRATANTE  = EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE
		AND    NUM_ABONADO_BENEFICIARIO = EO_ABONADO_BENEF.NUM_ABONADO_BENEFICIARIO;

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_BENEFICIA_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_BENEFICIA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_BENEFICIA_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_BENEFICIA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_BENEFICIA_U_PR;

PROCEDURE CU_CADUCA_U_PR(    EO_ABONADO_BENEF  IN	     CU_BENEF_PROD_QT,
								SN_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
								SV_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
								SN_num_evento     OUT NOCOPY ge_errores_pg.evento)
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
			<param nom="EO_ABONADO_BENEF" Tipo="estructura">Abonado Beneficiarios</param>>
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

	IF EO_ABONADO_BENEF IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := ' UPDATE CU_BENEF_PROD_TO';
		LV_sSql := LV_sSql || ' SET	   FEC_TERMINO_VIGENCIA = '||EO_ABONADO_BENEF.FEC_TERMINO_VIGENCIA;
		LV_sSql := LV_sSql || ' WHERE COD_CLIENTE_CONTRATANTE  = ' || EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE;
		LV_sSql := LV_sSql || ' AND NUM_ABONADO_CONTRATANTE  = ' || EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE;

		UPDATE CU_BENEF_PROD_TO
		SET	   FEC_TERMINO_VIGENCIA = EO_ABONADO_BENEF.FEC_TERMINO_VIGENCIA
		WHERE  COD_CLIENTE_CONTRATANTE  = EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE
		AND	   NUM_ABONADO_CONTRATANTE  = EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE;

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_CADUCA_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_CADUCA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_CADUCA_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_CADUCA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_CADUCA_U_PR;

PROCEDURE CU_ELIMINA_U_PR(    EO_ABONADO_BENEF  IN	     CU_BENEF_PROD_QT,
								SN_cod_retorno    OUT NOCOPY ge_errores_pg.coderror,
								SV_mens_retorno   OUT NOCOPY ge_errores_pg.msgerror,
								SN_num_evento     OUT NOCOPY ge_errores_pg.evento)
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
			<param nom="EO_ABONADO_BENEF" Tipo="estructura">Abonado Beneficiarios</param>>
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

	IF EO_ABONADO_BENEF IS NULL THEN
		RAISE ERROR_PARAMETROS;
	ELSE
		LV_sSql := ' UPDATE CU_BENEF_PROD_TO';
		LV_sSql := LV_sSql || ' SET	   FEC_TERMINO_VIGENCIA = '||EO_ABONADO_BENEF.FEC_TERMINO_VIGENCIA;
		LV_sSql := LV_sSql || ' WHERE NUM_ABONADO_BENEFICIARIO = ' || EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE;

		UPDATE CU_BENEF_PROD_TO
		SET	   FEC_TERMINO_VIGENCIA = EO_ABONADO_BENEF.FEC_TERMINO_VIGENCIA
		WHERE  NUM_ABONADO_BENEFICIARIO = EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE;

	END IF;

EXCEPTION
	WHEN ERROR_PARAMETROS THEN
		SN_cod_retorno := 98;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_CADUCA_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_CADUCA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := CV_error_no_clasif;
		END IF;
		LV_des_error   := 'CU_CADUCA_U_PR(Lista de Abonados Beneficiarios); '||SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CU_BENEF_PROD_PG.CU_CADUCA_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CU_ELIMINA_U_PR;

END CU_BENEF_PROD_PG;
/
SHOW ERRORS
