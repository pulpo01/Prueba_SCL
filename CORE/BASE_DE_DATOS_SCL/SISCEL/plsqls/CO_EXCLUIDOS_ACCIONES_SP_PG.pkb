CREATE OR REPLACE PACKAGE BODY CO_EXCLUIDOS_ACCIONES_SP_PG

IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE co_agrega_pr (
      EN_tip_exclusion IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      ED_fec_ingreso    IN         CO_EXCLUIDOS_ACCIONES_TO.fec_ingreso%type,
      ED_fec_ini_exclusion        IN         CO_EXCLUIDOS_ACCIONES_TO.fec_ini_exclusion%type,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
      IS
sSQL VARCHAR2(500);
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;

    sSQL := 'INSERT INTO CO_EXCLUIDOS_ACCIONES_TO (TIP_EXCLUSION, COD_CLIENTE, FEC_INGRESO, FEC_INI_EXCLUSION) ';
    sSQL := sSQL || ' VALUES (' || EN_tip_exclusion || ',' || EN_cod_cliente || ',' || ED_fec_ingreso || ',' || ED_fec_ini_exclusion || ');';

    INSERT INTO CO_EXCLUIDOS_ACCIONES_TO (TIP_EXCLUSION, COD_CLIENTE, FEC_INGRESO, FEC_INI_EXCLUSION)
      VALUES (EN_tip_exclusion, EN_cod_cliente, ED_fec_ingreso, ED_fec_ini_exclusion);

EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
      SN_cod_retorno:= 1825;  --xxx4 error al intentar eliminar cliente de exclusiones.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SP_PG.co_agrega_pr', sSql, SQLCODE, SQLERRM );

   WHEN OTHERS THEN
      SN_cod_retorno:= 1821;  --xxx3 error al intentar registrar cliente para exclusión.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SP_PG.co_agrega_pr', sSql, SQLCODE, SQLERRM );

END;

PROCEDURE co_elimina_pr (
      EN_tip_exclusion  IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      SN_filas_afectadas OUT NOCOPY NUMBER,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) AS

sSQL VARCHAR2(500);
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;
    SN_filas_afectadas := 0;

    sSQL := 'DELETE CO_EXCLUIDOS_ACCIONES_TO WHERE tip_exclusion = ' || en_tip_exclusion || ' AND cod_cliente = '|| EN_cod_cliente ;

    DELETE CO_EXCLUIDOS_ACCIONES_TO
    WHERE tip_exclusion = EN_tip_exclusion
    AND cod_cliente = EN_cod_cliente;

    SN_filas_afectadas := SQL%rowcount;
EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno:= 1822;  --xxx4 error al intentar eliminar cliente de exclusiones.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SP_PG.co_elimina_pr', sSql, SQLCODE, SQLERRM );

END;

PROCEDURE co_consulta_pr (
      EN_tip_exclusion  IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      SD_fec_ingreso    OUT NOCOPY        CO_EXCLUIDOS_ACCIONES_TO.fec_ingreso%type,
      SD_fec_ini_exclusion        OUT NOCOPY   CO_EXCLUIDOS_ACCIONES_TO.fec_ini_exclusion%type,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) AS

sSQL varchar2(500);
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;

    sSQL := 'SELECT * FROM CO_EXCLUIDOS_ACCIONES_TO WHERE TIP_EXCLUSION =' || EN_tip_exclusion || ' AND COD_CLIENTE =' || EN_cod_cliente;

    SELECT fec_ingreso, fec_ini_exclusion
    INTO SD_fec_ingreso, SD_fec_ini_exclusion
    FROM  co_excluidos_acciones_to
    WHERE tip_exclusion = EN_tip_exclusion
    AND cod_cliente = EN_cod_cliente;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno:= 1823;  --xxx6 Cliente no se encuentra registrado como exluido.
	   IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	   END IF;
	   SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SP_PG.co_consulta_pr', sSql, SQLCODE, SQLERRM );

    WHEN OTHERS THEN
      SN_cod_retorno:= 1824;  --xxx5 error al intentar recuperar cliente excluido.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SP_PG.co_consulta_pr', sSql, SQLCODE, SQLERRM );

END;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

PROCEDURE co_consulta_cliente_pr (
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
	  SN_cantidad OUT NOCOPY number,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) AS

sSQL varchar2(500);
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;

    sSQL := 'SELECT count(1) FROM GE_CLIENTES WHERE COD_CLIENTE =' || EN_COD_CLIENTE;

    SELECT count(1)
    INTO SN_cantidad
    FROM  ge_clientes
    WHERE cod_cliente = EN_cod_cliente;

EXCEPTION
    WHEN OTHERS THEN
      SN_cod_retorno:= 1760;  --xxx5 error al intentar recuperar cliente excluido.
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SP_PG.co_consulta_cliente_pr', sSql, SQLCODE, SQLERRM );

END;


END CO_EXCLUIDOS_ACCIONES_SP_PG;
/
SHOW ERRORS
