CREATE OR REPLACE PACKAGE BODY CO_EXCLUIDOS_ACCIONES_SN_PG

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
sSQL VARCHAR2(100);
ld_fec_ingreso DATE;


ERROR_VALIDACION EXCEPTION ;


BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;

    IF EN_tip_exclusion IS NULL THEN
       SN_cod_retorno := 1819; --Tipo de exclusión no puede ser nulo.
       RAISE Error_validacion;
    END IF;

    IF EN_cod_cliente IS NULL THEN
       SN_cod_retorno := 1820; --Código de cliente no puede ser nulo.
       RAISE Error_Validacion;
    END IF;


    LD_fec_ingreso := NVL(Ed_fec_ingreso, SYSDATE);


    sSQL := 'co_excluidos_acciones_sb_pg.co_agrega_pr()';

    co_excluidos_acciones_sb_pg.co_agrega_pr(EN_tip_exclusion, EN_cod_cliente, LD_fec_ingreso, ed_fec_ini_exclusion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

EXCEPTION

   WHEN ERROR_VALIDACION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SN_PG.CO_AGREGA_PR', sSql, SN_cod_retorno, SV_mens_retorno );
   WHEN OTHERS THEN
      SN_cod_retorno := 1821;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SN_PG.CO_AGREGA_PR', sSql, SQLCODE, SQLERRM );
END;

PROCEDURE co_elimina_pr (
      EN_tip_exclusion  IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      SN_filas_afectadas OUT NOCOPY NUMBER,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) AS

sSQL VARCHAR2(100);
ERROR_VALIDACION EXCEPTION ;

BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;
    SN_filas_afectadas := 0;

    IF EN_tip_exclusion IS NULL THEN
       SN_cod_retorno := 1819; --Tipo de exclusión no puede ser nulo.
       RAISE Error_validacion;
    END IF;

    IF EN_cod_cliente IS NULL THEN
       SN_cod_retorno := 1820; --Código de cliente no puede ser nulo.
       RAISE Error_Validacion;
    END IF;

    sSQL := 'co_excluidos_acciones_sb_pg.co_elimina_pr' ;

    co_excluidos_acciones_sb_pg.co_elimina_pr(EN_tip_exclusion, EN_cod_cliente, SN_filas_afectadas, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

EXCEPTION
 WHEN ERROR_VALIDACION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SN_PG.co_elimina_pr', sSql, SN_cod_retorno, SV_mens_retorno );
   WHEN OTHERS THEN
      SN_cod_retorno := 1822;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SN_PG.co_elimina_pr', sSql, SQLCODE, SQLERRM );
END;

PROCEDURE co_consulta_pr (
      EN_tip_exclusion  IN CO_EXCLUIDOS_ACCIONES_TO.tip_exclusion%type,
      EN_cod_cliente     IN         CO_EXCLUIDOS_ACCIONES_TO.cod_cliente%type,
      SD_fec_ingreso    OUT NOCOPY        CO_EXCLUIDOS_ACCIONES_TO.fec_ingreso%type,
      SD_fec_ini_exclusion        OUT NOCOPY   CO_EXCLUIDOS_ACCIONES_TO.fec_ini_exclusion%type,
      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
      SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
      SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) AS
sSQL varchar2(100);
ERROR_VALIDACION EXCEPTION ;
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0  ;
    SV_mens_retorno:= NULL;

    IF EN_tip_exclusion IS NULL THEN
       SN_cod_retorno := 1819 ; --xxx1 Tipo de exclusión no puede ser nulo.
       RAISE Error_validacion;
    END IF;

    IF EN_cod_cliente IS NULL THEN
       SN_cod_retorno := 1820; --xxx2 Código de cliente no puede ser nulo.
       RAISE Error_Validacion;
    END IF;

    sSQL := 'co_excluidos_acciones_sb_pg.co_consulta_pr()';

    co_excluidos_acciones_sb_pg.co_consulta_pr(en_tip_exclusion, en_cod_cliente, sd_fec_ingreso, sd_fec_ini_exclusion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

EXCEPTION
 WHEN ERROR_VALIDACION THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SN_PG.co_consulta_pr', sSql, SN_cod_retorno, SV_mens_retorno );
   WHEN OTHERS THEN
      SN_cod_retorno := 1824;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := 'Error no clasificado';
	  END IF;
	  SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'CO', SN_cod_retorno || ' ' || SV_mens_retorno, '1.0', USER, 'CO_EXCLUIDOS_ACCIONES_SN_PG.co_consulta_pr', sSql, SQLCODE, SQLERRM );

END;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
END CO_EXCLUIDOS_ACCIONES_SN_PG;
/
SHOW ERRORS
