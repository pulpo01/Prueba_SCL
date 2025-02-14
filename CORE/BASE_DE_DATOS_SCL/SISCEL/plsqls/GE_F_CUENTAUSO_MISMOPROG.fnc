CREATE OR REPLACE FUNCTION        GE_F_CUENTAUSO_MISMOPROG
( NomUserID in varchar,NomModulo in varchar ) return number is
Begin
--Nombre de la Funcion  : GE_F_CUENTAUSO_MISMOPROG
--Creado Por            : Marcelo Navarrete.
--Descripcion           : La finalidad de aplicacion, es Validar que ningun usuario pueda
--                        tener mas de una session abierta, ya sea en un mismo PC o en Otros.
--Parametros de Input   : NomUsr  = Nombre del Usuario.
--                        NomMod  = Nombre del modulo EXE.  "%CONSAC%"
--Parametro de Salida   : Retorna la cantidad de Sessiones Abiertas para un Usuario y un Modulo.
--
--Fecha e Historia      : Martes, 18 de Enero del 2000 : Creado.
--
--                      : Jueves, 29 de Junio del 2000 : Optimizar la restriccisn de sesiones.
--                                                       Cuando cuente la cantidad de sesiones existentes
--                                                       ademas revise que la columna STATUS no sea "KILLED"
--							               ni "SNIPED", que son dos estados en que el Oracle deja
--						                     las sesiones que por algzn motivo fueron desconectados.
 declare
   NumSess number;
   begin
	SELECT COUNT(*)
	INTO NumSess
	FROM V$SESSION
	WHERE USERNAME = NomUserID
	AND STATUS <> 'KILLED'
	AND STATUS <> 'SNIPED'
	AND UPPER(PROGRAM) LIKE NomModulo ;
	return( NumSess );
 end;
End;
/
SHOW ERRORS
