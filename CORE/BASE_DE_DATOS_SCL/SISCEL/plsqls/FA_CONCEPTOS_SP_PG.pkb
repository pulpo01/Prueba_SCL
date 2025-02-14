CREATE OR REPLACE PACKAGE BODY FA_CONCEPTOS_SP_PG AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_SEL_FA_CONCEPTOS_PR (EO_Fa_Conceptos	 IN OUT NOCOPY TipRegconceptos,
								  SO_Lista_Conceptos OUT NOCOPY	 refCursor,
   			 					  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_SEL_FA_CONCEPTOS_PR"
      Fecha modificacion=" "
      Fecha creacion="30-07-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Lee un registro de la tabla FA_PROCFACT</Descripcion>
      <Parametros>
         <Salida>
		    <param nom="EO_Fa_Conceptos" Tipo="Registro">Registro deL TYPE TipRegconceptos</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_CodConcepto 	  fa_conceptos.cod_concepto%TYPE;
LN_CodTipConce	  fa_conceptos.cod_tipconce%TYPE;
BEGIN

    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento 	:= 0;

	if (EO_Fa_Conceptos.COD_CONCEPTO IS NOT NULL AND EO_Fa_Conceptos.COD_CONCEPTO > 0) THEN
		LN_CodConcepto := EO_Fa_Conceptos.COD_CONCEPTO;
		OPEN SO_Lista_Conceptos FOR
		SELECT   COD_CONCEPTO
				,COD_PRODUCTO
				,DES_CONCEPTO
				,COD_TIPCONCE
				,COD_MODULO
				,IND_ACTIVO
				,COD_MONEDA
				,COD_CONCORIG
				,COD_TIPDESCU
				,NOM_USUARIO
				,FEC_ULTMOD
				,COD_PRODSERVTFN
				,IND_RECURRENTE
				,COD_SUBCONCEPTO
				,IND_TECNOLOGIA
				,DEF_TECNOLOGIA
				,COD_GRPCONCEPTO
	  	  FROM FA_CONCEPTOS
		 WHERE COD_CONCEPTO = LN_CodConcepto
		   AND IND_ACTIVO   = 1;
	ELSE
		LN_CodTipConce := EO_Fa_Conceptos.COD_TIPCONCE;
		OPEN SO_Lista_Conceptos FOR
		SELECT   COD_CONCEPTO
				,COD_PRODUCTO
				,DES_CONCEPTO
				,COD_TIPCONCE
				,COD_MODULO
				,IND_ACTIVO
				,COD_MONEDA
				,COD_CONCORIG
				,COD_TIPDESCU
				,NOM_USUARIO
				,FEC_ULTMOD
				,COD_PRODSERVTFN
				,IND_RECURRENTE
				,COD_SUBCONCEPTO
				,IND_TECNOLOGIA
				,DEF_TECNOLOGIA
				,COD_GRPCONCEPTO
	  	  FROM FA_CONCEPTOS
		 WHERE COD_TIPCONCE = LN_CodTipConce
		   AND IND_ACTIVO   = 1;
	END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1628;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_CONCEPTOS_SP_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_CONCEPTOS_SP_PG.FA_CONCEPTOS_SP_PG', LV_sSQL, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_Cod_retorno:=1628;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  SV_mens_retorno:=SV_mens_retorno || ' Tabla FA_PROCFACT ';
	  LV_des_error   := 'FA_CONCEPTOS_SP_PG('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_CONCEPTOS_SP_PG.FA_CONCEPTOS_SP_PG', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_SEL_FA_CONCEPTOS_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END FA_CONCEPTOS_SP_PG;
/
SHOW ERRORS
