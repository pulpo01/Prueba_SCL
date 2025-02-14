CREATE OR REPLACE PACKAGE BODY AUD_AUDITORIA_PG
IS

FUNCTION AUD_REGISTRA_AUDITORIA_FN (
										EV_owner		IN VARCHAR2
 									,	EV_tabla		IN VARCHAR2
									,	EV_operacion	IN VARCHAR2
									,	EV_pk			IN VARCHAR2
									,	EV_detalle  	IN VARCHAR2 ) RETURN NUMBER
IS

/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "AUD_REGISTRA_AUDITORIA_FN" Lenguaje="PL/SQL" Fecha="01-09-2005" Versión="1.0" Diseñador="David Sutherland" Programador="José Castillo Pinto" Ambiente="BD">
<Retorno>NUMBER</Retorno>
<Descripción>Función para registras los datos de la auditoría</Descripción>
<Parámetros>
<Entrada>
	<param nom="EV_owner" 		Tipo="VARCHAR2">USUARIO DUEÑO DE LA TABLA AUDITADA</param>
	<param nom="EV_tabla" 		Tipo="VARCHAR2">NOMBRE DE LA TABLA AUDITADA</param>
	<param nom="EV_operacion"	Tipo="VARCHAR2">EVENTO AUDITADO (DELETE, UPDATE O INSERT)</param>
	<param nom="EV_pk"			Tipo="VARCHAR2">COLUMNAS CONCATENADAS DE LA PK DE LA TABLA AUDITADA</param>
	<param nom="EV_detalle "	Tipo="VARCHAR2">COLUMNAS CONCATENADAS RELEVANTES DEL REGISTRO AFECTADO EN LA TABLA AUDITADA</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/


v_usuario_ora	AUD_REGISTRO_AUDITORIA_TO.USUARIO_ORA%TYPE;
v_usuario_so 	AUD_REGISTRO_AUDITORIA_TO.USUARIO_SO%TYPE;
v_maquina    	AUD_REGISTRO_AUDITORIA_TO.MAQUINA%TYPE;
v_terminal   	AUD_REGISTRO_AUDITORIA_TO.TERMINAL%TYPE;
v_programa   	AUD_REGISTRO_AUDITORIA_TO.PROGRAMA%TYPE;
v_modulo     	AUD_REGISTRO_AUDITORIA_TO.MODULO%TYPE;


BEGIN
	SELECT	username
	,		osuser
	,		machine
	,		terminal
	,		program
	,		module
	INTO	v_usuario_ora
  	,		v_usuario_so
  	,		v_maquina
  	,		v_terminal
  	,		v_programa
  	,		v_modulo
	FROM	v$session
	WHERE	audsid = userenv('sessionid');


	INSERT INTO AUD_REGISTRO_AUDITORIA_TO
	(
	  	CORRELATIVO
	  ,	OWNER
	  ,	TABLA
	  ,	HORA
	  ,	PK
	  ,	OPERACION
	  ,	DETALLE
	  ,	USUARIO_ORA
	  ,	USUARIO_SO
	  ,	MAQUINA
	  ,	TERMINAL
	  ,	PROGRAMA
	  ,	MODULO
	)
	VALUES
	(
		AUD_REAU_SQ.NEXTVAL
	,	EV_owner
	,	EV_tabla
	,	SYSDATE
	,	EV_pk
	,	EV_operacion
	,	EV_detalle
	,	v_usuario_ora
	,	v_usuario_so
	,	v_maquina
	,	v_terminal
	,	v_programa
	,	v_modulo
	);

	RETURN 0;

	EXCEPTION
		WHEN OTHERS THEN
			RETURN SQLCODE;

END;

END AUD_AUDITORIA_PG;
/
SHOW ERRORS
