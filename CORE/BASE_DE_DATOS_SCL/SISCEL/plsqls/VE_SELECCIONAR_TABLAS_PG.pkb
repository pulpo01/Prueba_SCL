CREATE OR REPLACE PACKAGE BODY VE_SELECCIONAR_TABLAS_PG AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_SEL_VE_VENDEALER_PR (SO_Lista_Conceptos OUT NOCOPY	 refCursor,
   			 					  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_CodConcepto 	  fa_conceptos.cod_concepto%TYPE;
LN_CodTipConce	  fa_conceptos.cod_tipconce%TYPE;
BEGIN

    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento 	:= 0;

		OPEN SO_Lista_Conceptos FOR
		SELECT a.cod_vendedor, a.nom_vendedor  vend
        FROM ve_vendedores a, ve_tipcomis b
		WHERE a.Cod_Tipcomis = b.Cod_Tipcomis
		AND b.ind_vta_externa='1'
		AND sysdate BETWEEN a.fec_contrato
		AND  nvl(fec_fincontrato, sysdate)
		ORDER BY vend;

EXCEPTION
   WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1095; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'VE_SELECCIONAR_TABLAS_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CONCEPTOS_SP_PG.FA_CONCEPTOS_SP_PG', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=1;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_PROCFACT ';
	  LV_des_error   := 'VE_SELECCIONAR_TABLAS_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CONCEPTOS_SP_PG.FA_CONCEPTOS_SP_PG', LV_sSQL, SN_cod_retorno, LV_des_error );

END VE_SEL_VE_VENDEALER_PR ;

PROCEDURE VE_SEL_GE_MONEDAS_PR   (SO_Lista_Conceptos OUT NOCOPY	 refCursor,
   			 					  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_CodConcepto 	  fa_conceptos.cod_concepto%TYPE;
LN_CodTipConce	  fa_conceptos.cod_tipconce%TYPE;
BEGIN

    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento 	:= 0;

		OPEN SO_Lista_Conceptos FOR
		SELECT COD_MONEDA,DES_MONEDA
		FROM GE_MONEDAS;

EXCEPTION
   WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1095; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'VE_SELECCIONAR_TABLAS_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CONCEPTOS_SP_PG.FA_CONCEPTOS_SP_PG', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=1;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_PROCFACT ';
	  LV_des_error   := 'VE_SELECCIONAR_TABLAS_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CONCEPTOS_SP_PG.FA_CONCEPTOS_SP_PG', LV_sSQL, SN_cod_retorno, LV_des_error );

END VE_SEL_GE_MONEDAS_PR ;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END VE_SELECCIONAR_TABLAS_PG;
/
SHOW ERRORS
