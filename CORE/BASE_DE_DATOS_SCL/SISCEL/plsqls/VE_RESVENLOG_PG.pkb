CREATE OR REPLACE PACKAGE BODY VE_RESVENLOG_PG

AS

function VE_RESVEN_IL_FN (EN_niv_log number,
		 				  EV_msglog varchar2
) return varchar2
is

PRAGMA AUTONOMOUS_TRANSACTION;
LN_max_sec ve_resvenlog_tt.max_sec%TYPE;
--
/*
<Documentaci�n TipoDoc = "Funci�n">
<Elemento Nombre = "VE_RESVEN_IL_FN" Lenguaje="PL/SQL" Fecha="28-12-2006" Versi�n="1.1.0" Dise�ador="Rodrigo Araneda" Programador="Rodrigo Araneda" Ambiente="BD">
<Retorno>varchar2</Retorno>
<Descripci�n>Ingreso de LOG de reversa de venta</Descripci�n>
<Par�metros>
    <Entrada>
        <param nom="EN_niv_log" Tipo="NUMBER">Nivel de Log</param>
		<param nom="EV_msglog" Tipo="VARCHAR2">Mensaje de Log</param>
    </Entrada>
</Par�metros>
</Elemento>
</Documentaci�n>
*/
BEGIN
    LN_max_sec := 0;

	BEGIN
	   SELECT  max_sec
	   INTO LN_max_sec
	   FROM ve_resvenlog_tt
	   WHERE num_sec = 1;

	   EXCEPTION
	      WHEN NO_DATA_FOUND THEN
	   	  LN_max_sec := 0;
	END;

	INSERT INTO ve_resvenlog_tt (num_sec, niv_log, msg_log, max_sec)
	VALUES (LN_max_sec + 1, EN_niv_log, EV_msglog, DECODE(LN_max_sec,0,0,NULL));

	UPDATE ve_resvenlog_tt
	SET max_sec = LN_max_sec + 1
	WHERE num_sec = 1;

	COMMIT;

	RETURN '0';
	 --*********************************************************
EXCEPTION

   WHEN OTHERS THEN
      RETURN 'SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM;
END VE_RESVEN_IL_FN;

procedure VE_RESVEN_INIT_PR (SN_cod_retorno out nocopy number
)is
/*
<Documentaci�n TipoDoc = "Procedure">
<Elemento Nombre = "VE_RESVEN_INIT_PR" Lenguaje="PL/SQL" Fecha="06-12-2006" Versi�n="1.1.0" Dise�ador="Rodrigo Araneda" Programador="Rodrigo Araneda" Ambiente="BD">
<Retorno></Retorno>
<Descripci�n>Inicializa tabla de LOG</Descripci�n>
<Par�metros>
    <Entrada>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>
    </Salida>
</Par�metros>
</Elemento>
</Documentaci�n>
*/
PRAGMA AUTONOMOUS_TRANSACTION;

begin

	 DELETE FROM ve_resvenlog_tt;
	 COMMIT;

	 SN_cod_retorno := 0;

	 EXCEPTION
	 WHEN OTHERS THEN
	 	  SN_cod_retorno := 1;


end VE_RESVEN_INIT_PR;

END VE_RESVENLOG_PG;
/
SHOW ERRORS
