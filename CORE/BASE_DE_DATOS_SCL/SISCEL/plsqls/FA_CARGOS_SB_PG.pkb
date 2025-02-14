CREATE OR REPLACE PACKAGE BODY        FA_CARGOS_SB_PG AS

-------------------------------------------------------------------------------
FUNCTION FA_VALIDA_CLIENTE_ABONADO_FN (EN_cod_cliente 	IN GA_ABOCEL.cod_cliente%TYPE,
		                               EN_num_abonado   IN GA_ABOCEL.num_abonado%TYPE,
		                               SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
		                               SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
		                               SN_num_evento   OUT NOCOPY ge_errores_pg.evento
		                               )
RETURN BOOLEAN
IS
/*
<Documentacion TipoDoc = "function">
   <Elemento
      Nombre = "FA_VALIDA_CLIENTEA_BONADO_FN"
      Fecha modificacion="22-04-2008"
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>TRUE si el cliente/abonado existe si no FALSE</Retorno>
      <Descripcion>Funcion que valida el cliente/abonado en la interfaz de facturacion ciclo</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EN_cod_cliente" Tipo="NUMBER">Codigo de cliente</param>
             <param nom="EN_num_abonado" Tipo="NUMBER">Numero abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_CntCli		  PLS_INTEGER;
BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

	LV_sSql := 'SELECT SUM (NVL(TOTAL,0)) FROM ( SELECT 1 TOTAL FROM GA_ABOCEL/GA_ABOAMIST WHERE COD_CLIENTE = '||EN_cod_cliente;
	LV_sSql := LV_sSql || ' AND NUM_ABONADO = '||EN_num_abonado;

	IF (EN_num_abonado != 0) THEN
        SELECT SUM (NVL(TOTAL,0))
		INTO LN_CntCli
        FROM ( SELECT 1 TOTAL
                 FROM GA_ABOCEL
                WHERE COD_CLIENTE = EN_cod_cliente
                  AND NUM_ABONADO = EN_num_abonado
              UNION ALL
               SELECT 1 TOTAL
                 FROM GA_ABOAMIST
	            WHERE COD_CLIENTE = EN_cod_cliente
	              AND NUM_ABONADO = EN_num_abonado );

	ELSE
        SELECT SUM (NVL(TOTAL,0))
		INTO LN_CntCli
        FROM ( SELECT 1 TOTAL
                 FROM GA_ABOCEL
                WHERE COD_CLIENTE = EN_cod_cliente
              UNION ALL
               SELECT 1 TOTAL
                 FROM GA_ABOAMIST
	            WHERE COD_CLIENTE = EN_cod_cliente );
	END IF;

	IF LN_CntCli > 0 THEN
		RETURN TRUE;
	ELSE
		SN_cod_retorno := 1640 ;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
			SV_mens_retorno := cv_error_no_clasif;
		END IF;
		LV_des_error   := 'FA_CARGOS_SB_PG(); - ' || SQLERRM;
		SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
		                                       	  'FA', SV_mens_retorno, CV_version, USER,
		                                       	  'FA_CARGOS_SB_PG.FA_VALIDA_CLIENTE_ABONADO_FN',
		                                       	  LV_sSQL, SN_cod_retorno, LV_des_error );
		RETURN FALSE;
	END IF;

EXCEPTION

  WHEN OTHERS THEN
      SN_cod_retorno := 1640 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SB_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SB_PG.FA_VALIDA_CLIENTE_ABONADO_FN',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_VALIDA_CLIENTE_ABONADO_FN;



-------------------------------------------------------------------------------
FUNCTION FA_VALIDA_CONCEPTO_FN (EN_cod_concepto IN FA_CONCEPTOS.cod_concepto%TYPE,
                               SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento   OUT NOCOPY ge_errores_pg.evento
                               )
RETURN BOOLEAN
IS
/*
<Documentacion TipoDoc = "function">
   <Elemento
      Nombre = "FA_VALIDA_CONCEPTO_FN"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>TRUE si el cliente/abonado existe si no FALSE</Retorno>
      <Descripcion>Funcion que valida el cliente/abonado en la interfaz de facturacion ciclo</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EN_cod_concepto" Tipo="NUMBER">Codigo de concepto</param>
             <param nom="EN_num_abonado" Tipo="NUMBER">Numero abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LO_ListaConc	  FA_CONCEPTOS_SP_PG.refCursor;
LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
LN_num_evento     ge_errores_pg.evento;
LR_Concepto		  FA_CONCEPTOS_SP_PG.TipRegconceptos;
en				  FA_CONCEPTOS%ROWTYPE;
BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

	LR_Concepto.COD_CONCEPTO := EN_cod_concepto;
	FA_CONCEPTOS_SP_PG.FA_SEL_FA_CONCEPTOS_PR (LR_Concepto, LO_ListaConc,
	                        SN_Cod_retorno,
	                        SV_Mens_retorno,
	                        SN_Num_evento  );
	BEGIN
		fetch LO_ListaConc INTO en;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN FALSE;
	END;

	RETURN TRUE;
EXCEPTION

  WHEN OTHERS THEN
      SN_cod_retorno := 1628 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SB_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SB_PG.FA_VALIDA_CONCEPTO_FN',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_VALIDA_CONCEPTO_FN;
-------------------------------------------------------------------------------
FUNCTION FA_VALIDA_CICLOFACT_FN ( EN_cod_ciclfact  IN GA_ABOCEL.cod_cliente%TYPE,
	                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN
IS
/*
<Documentacion TipoDoc = "function">
   <Elemento
      Nombre = "FA_VALIDA_CICLOFACT_FN"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>TRUE si el ciclo informado existe si no FALSE</Retorno>
      <Descripcion>Funcion que valida el ciclo de facturacin </Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EN_cod_ciclfact" Tipo="NUMBER">Codigo de ciclo</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_CntCiclo		  PLS_INTEGER;
BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

	LV_sSql := 'SELECT COUNT(1) FROM FA_CICLFACT WHERE COD_CICLFACT = '||EN_cod_ciclfact;

    SELECT COUNT(1)
	INTO LN_CntCiclo
    FROM FA_CICLFACT
    WHERE COD_CICLFACT = EN_cod_ciclfact;

	IF LN_CntCiclo > 0 THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;

EXCEPTION

  WHEN OTHERS THEN
      SN_cod_retorno := 998 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SB_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SB_PG.FA_VALIDA_CICLOFACT_FN',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_VALIDA_CICLOFACT_FN;

-------------------------------------------------------------------------------

FUNCTION FA_VALIDA_CODMONEDA_FN ( EV_cod_moneda  IN ge_monedas.cod_moneda%TYPE,
	                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN
IS
/*
<Documentacion TipoDoc = "function">
   <Elemento
      Nombre = "FA_VALIDA_CODMONEDA_FN"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>TRUE si el codigo de moneda existe si no FALSE</Retorno>
      <Descripcion>Funcion que valida el codigo de moneda</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EV_cod_ciclfact" Tipo="CARACTER">Codigo de moneda</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_Cnt			  PLS_INTEGER;
BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

	LV_sSql := 'SELECT COUNT(1) FROM GE_MONEDAS WHERE COD_MONEDA = '||EV_cod_moneda;

    SELECT COUNT(1)
	INTO LN_Cnt
    FROM GE_MONEDAS
    WHERE COD_MONEDA = EV_cod_moneda;

	IF LN_Cnt > 0 THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;

EXCEPTION

  WHEN OTHERS THEN
      SN_cod_retorno := 1001 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SB_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SB_PG.FA_VALIDA_CODMONEDA_FN',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_VALIDA_CODMONEDA_FN;

-------------------------------------------------------------------------------
FUNCTION FA_TRAS_REGS_CARGOS_FN ( ES_reg_fa_cargos  IN FA_CARGOS_QT,
								  ES_reg_ge_cargos  IN OUT NOCOPY GE_CARGOS_QT,
	                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN
IS
/*
<Documentacion TipoDoc = "function">
   <Elemento
      Nombre = "FA_VALIDA_CODMONEDA_FN"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>TRUE si el codigo de moneda existe si no FALSE</Retorno>
      <Descripcion>Funcion que valida el codigo de moneda</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EV_cod_ciclfact" Tipo="CARACTER">Codigo de moneda</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_Cnt			  PLS_INTEGER;
BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

	-- TipRegGeCargos 	||		TipRegCargos
	ES_reg_ge_cargos.NUM_CARGO         := ES_reg_fa_cargos.SEQ_CARGO;
	ES_reg_ge_cargos.COD_CLIENTE       := ES_reg_fa_cargos.COD_CLIENTE;
	ES_reg_ge_cargos.COD_PRODUCTO      := 1;
	ES_reg_ge_cargos.COD_CONCEPTO      := ES_reg_fa_cargos.COD_CONCEPTO;
	ES_reg_ge_cargos.FEC_ALTA          := ES_reg_fa_cargos.FEC_ALTA;
	ES_reg_ge_cargos.IMP_CARGO         := ES_reg_fa_cargos.IMP_CARGO;
	ES_reg_ge_cargos.COD_MONEDA        := ES_reg_fa_cargos.COD_MONEDA;
	ES_reg_ge_cargos.COD_PLANCOM       := ES_reg_fa_cargos.COD_PLANCOM;
	ES_reg_ge_cargos.NUM_UNIDADES      := ES_reg_fa_cargos.NUM_UNIDADES;
	ES_reg_ge_cargos.IND_FACTUR        := ES_reg_fa_cargos.IND_FACTUR;
	ES_reg_ge_cargos.NUM_TRANSACCION   := ES_reg_fa_cargos.NUM_TRANSACCION;
	ES_reg_ge_cargos.NUM_VENTA         := ES_reg_fa_cargos.NUM_VENTA;
	ES_reg_ge_cargos.NUM_PAQUETE       := ES_reg_fa_cargos.NUM_PAQUETE;
	ES_reg_ge_cargos.NUM_ABONADO       := ES_reg_fa_cargos.NUM_ABONADO;
	ES_reg_ge_cargos.NUM_TERMINAL      := ES_reg_fa_cargos.NUM_TERMINAL;
	ES_reg_ge_cargos.COD_CICLFACT      := ES_reg_fa_cargos.COD_CICLFACT;
	ES_reg_ge_cargos.NUM_SERIE         := ES_reg_fa_cargos.NUM_SERIE;
	ES_reg_ge_cargos.NUM_SERIEMEC      := ES_reg_fa_cargos.NUM_SERIEMEC;
	ES_reg_ge_cargos.CAP_CODE          := ES_reg_fa_cargos.CAP_CODE;
	ES_reg_ge_cargos.MES_GARANTIA      := ES_reg_fa_cargos.MES_GARANTIA;
	ES_reg_ge_cargos.NUM_PREGUIA       := ES_reg_fa_cargos.NUM_PREGUIA;
	ES_reg_ge_cargos.NUM_GUIA          := ES_reg_fa_cargos.NUM_GUIA;
	ES_reg_ge_cargos.NUM_FACTURA       := ES_reg_fa_cargos.NUM_FACTURA;
	ES_reg_ge_cargos.COD_CONCEPTO_DTO  := ES_reg_fa_cargos.COD_CONCEPTO_DTO;
	ES_reg_ge_cargos.VAL_DTO           := ES_reg_fa_cargos.VAL_DTO;
	ES_reg_ge_cargos.TIP_DTO           := ES_reg_fa_cargos.TIP_DTO;
	ES_reg_ge_cargos.IND_CUOTA         := ES_reg_fa_cargos.IND_CUOTA;
	ES_reg_ge_cargos.IND_SUPERTEL      := ES_reg_fa_cargos.IND_SUPERTEL;
	ES_reg_ge_cargos.IND_MANUAL        := ES_reg_fa_cargos.IND_MANUAL;
	ES_reg_ge_cargos.NOM_USUARORA      := ES_reg_fa_cargos.NOM_USUARIO;
	ES_reg_ge_cargos.PREF_PLAZA        := ES_reg_fa_cargos.PREF_PLAZA;
	ES_reg_ge_cargos.COD_TECNOLOGIA    := ES_reg_fa_cargos.COD_TECNOLOGIA;

	RETURN TRUE;

EXCEPTION

  WHEN OTHERS THEN
      SN_cod_retorno := 1415 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SB_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SB_PG.FA_TRAS_REGS_CARGOS_FN',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_TRAS_REGS_CARGOS_FN;

-------------------------------------------------------------------------------
FUNCTION FA_VALIDA_INTERFACT_FN ( EN_num_proceso  IN fa_interfact.num_proceso%TYPE,
	                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
RETURN BOOLEAN
IS
/*
<Documentacion TipoDoc = "function">
   <Elemento
      Nombre = "FA_VALIDA_CODMONEDA_FN"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>TRUE si el codigo de moneda existe si no FALSE</Retorno>
      <Descripcion>Funcion que valida el codigo de moneda</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EV_cod_ciclfact" Tipo="CARACTER">Codigo de moneda</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql           ge_errores_pg.vQuery;
LN_Cnt			  PLS_INTEGER;
BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;


	-- VALIDA EN INTERFACT
	LV_sSql := 'SELECT COUNT(1) FROM FA_INTERFACT WHERE NUM_PROCESO = '||EN_num_proceso;
    SELECT COUNT(1)
	INTO LN_Cnt
    FROM FA_INTERFACT
    WHERE NUM_PROCESO = EN_num_proceso
      AND COD_ESTADOC >= 200 ; -- FACTURACION

	IF LN_Cnt > 0 THEN
		RETURN TRUE;
	END IF;

	-- VALIDA EN INTERFACT HISTORICA
	LV_sSql := 'SELECT COUNT(1) FROM FA_HISTINTERFACT WHERE NUM_PROCESO = '||EN_num_proceso;
    SELECT COUNT(1)
	INTO LN_Cnt
    FROM FA_HISTINTERFACT
    WHERE NUM_PROCESO = EN_num_proceso;

	IF LN_Cnt > 0 THEN
		RETURN TRUE;
	END IF;

	RETURN FALSE;

EXCEPTION

  WHEN OTHERS THEN
      SN_cod_retorno := 1634 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_SB_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_SB_PG.FA_VALIDA_INTERFACT_FN',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_VALIDA_INTERFACT_FN;


-------------------------------------------------------------------------------
END FA_CARGOS_SB_PG;
/
SHOW ERRORS
