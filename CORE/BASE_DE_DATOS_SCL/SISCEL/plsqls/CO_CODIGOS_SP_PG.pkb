CREATE OR REPLACE PACKAGE BODY CO_CODIGOS_SP_PG

IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE co_valida_codigo_pr (
      EV_nom_tabla     IN         co_codigos.NOM_TABLA%type,
	  EV_nom_columna   IN  CO_CODIGOS.NOM_COLUMNA%TYPE,
	  EV_valor         IN CO_CODIGOS.COD_VALOR%TYPE,
	  SN_cantidad OUT NOCOPY number,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) AS

sSQL varchar2(500);
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;

    sSQL := 'SELECT count(1) FROM co_codigos ';

    SELECT count(1)
    INTO SN_cantidad
    FROM  co_codigos
    WHERE nom_tabla = EV_nom_tabla
    AND nom_columna = EV_nom_columna
	AND cod_valor = EV_valor;

EXCEPTION
    WHEN OTHERS THEN
      SN_cod_retorno:= 1827;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_CODIGOS_SP_PG.co_valida_codigo_pr', sSql, SQLCODE, SQLERRM );

END;


END CO_CODIGOS_SP_PG;
/
SHOW ERRORS
