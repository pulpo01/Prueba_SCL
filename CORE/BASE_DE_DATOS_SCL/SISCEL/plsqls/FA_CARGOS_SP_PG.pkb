CREATE OR REPLACE PACKAGE BODY FA_CARGOS_SP_PG AS

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_TO_I_PR (REGISTRO 		IN FA_CARGOS_QT,
	                        SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                        SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                        SN_num_evento   OUT NOCOPY ge_errores_pg.evento
	                        ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_TO_I_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado insertar registros en la tabla FA_CARGOS_TO.</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
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

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    INSERT INTO FA_CARGOS_TO
    (SEQ_CARGO
	,COD_CLIENTE
	,NUM_ABONADO
	,COD_PROD_CONTRATADO
	,ID_CARGO
	,COD_CONCEPTO
	,COLUMNA
	,FEC_ALTA
	,IMP_CARGO
	,COD_MONEDA
	,COD_PLANCOM
	,NUM_UNIDADES
	,IND_FACTUR
	,NUM_TRANSACCION
	,NUM_VENTA
	,NUM_PAQUETE
	,NUM_TERMINAL
	,COD_CICLFACT
	,NUM_SERIE
	,NUM_SERIEMEC
	,CAP_CODE
	,MES_GARANTIA
	,NUM_PREGUIA
	,NUM_GUIA
	,COD_CONCEREL
	,COLUMNA_REL
	,COD_CONCEPTO_DTO
	,VAL_DTO
	,TIP_DTO
	,IND_CUOTA
	,NUM_CUOTAS
	,ORD_CUOTA
	,IND_SUPERTEL
	,IND_MANUAL
	,PREF_PLAZA
	,COD_TECNOLOGIA
	,GLS_DESCRIP
	,NUM_FACTURA
	,FEC_ULTMOD
	,NOM_USUARIO)
    VALUES
    (REGISTRO.SEQ_CARGO
	,REGISTRO.COD_CLIENTE
	,REGISTRO.NUM_ABONADO
	,REGISTRO.COD_PROD_CONTRATADO
	,REGISTRO.ID_CARGO
	,REGISTRO.COD_CONCEPTO
	,REGISTRO.COLUMNA
	,REGISTRO.FEC_ALTA
	,REGISTRO.IMP_CARGO
	,REGISTRO.COD_MONEDA
	,REGISTRO.COD_PLANCOM
	,REGISTRO.NUM_UNIDADES
	,REGISTRO.IND_FACTUR
	,REGISTRO.NUM_TRANSACCION
	,REGISTRO.NUM_VENTA
	,REGISTRO.NUM_PAQUETE
	,REGISTRO.NUM_TERMINAL
	,REGISTRO.COD_CICLFACT
	,REGISTRO.NUM_SERIE
	,REGISTRO.NUM_SERIEMEC
	,REGISTRO.CAP_CODE
	,REGISTRO.MES_GARANTIA
	,REGISTRO.NUM_PREGUIA
	,REGISTRO.NUM_GUIA
	,REGISTRO.COD_CONCEREL
	,REGISTRO.COLUMNA_REL
	,REGISTRO.COD_CONCEPTO_DTO
	,REGISTRO.VAL_DTO
	,REGISTRO.TIP_DTO
	,REGISTRO.IND_CUOTA
	,REGISTRO.NUM_CUOTAS
	,REGISTRO.ORD_CUOTA
	,REGISTRO.IND_SUPERTEL
	,REGISTRO.IND_MANUAL
	,REGISTRO.PREF_PLAZA
	,REGISTRO.COD_TECNOLOGIA
	,REGISTRO.GLS_DESCRIP
	,REGISTRO.NUM_FACTURA
    ,SYSDATE -- FEC_ULTMOD
    ,DECODE(REGISTRO.NOM_USUARIO,NULL,USER,'',USER,REGISTRO.NOM_USUARIO)    -- NOM_USUARIO
    );

EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 1419 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_TO_I_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
      											'FA_CARGOS_SP_PG.FA_CARGOS_TO_I_PR',
      											LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_TO_I_PR;

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_TO_U_PR (REGISTRO           IN FA_CARGOS_QT,
	                         SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                         SV_Mens_retorno	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                         SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
	                         ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_TO_U_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado actualizar registros en la tabla FA_CARGOS_TO.</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error    ge_errores_pg.DesEvent;
LV_sSql         ge_errores_pg.vQuery;

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

	LV_sSql := 'UPDATE FA_CARGOS_TO SET IMP_CARGO = '||REGISTRO.IMP_CARGO;
	LV_sSql := LV_sSql || ' COD_MONEDA = '||REGISTRO.COD_MONEDA;
	LV_sSql := LV_sSql || ' IND_FACTUR = '||REGISTRO.IND_FACTUR;
	LV_sSql := LV_sSql || ' WHERE COD_CLIENTE = '||REGISTRO.COD_CLIENTE;
	LV_sSql := LV_sSql || ' AND NUM_ABONADO = '||REGISTRO.NUM_ABONADO;
	LV_sSql := LV_sSql || ' AND COD_CONCEPTO = '||REGISTRO.COD_CONCEPTO;
	LV_sSql := LV_sSql || ' AND COD_PROD_CONTRATADO = '||REGISTRO.COD_PROD_CONTRATADO;
	LV_sSql := LV_sSql || ' AND ID_CARGO = '||REGISTRO.ID_CARGO;

    UPDATE FA_CARGOS_TO
    SET IMP_CARGO     = REGISTRO.IMP_CARGO,
        COD_MONEDA	  = REGISTRO.COD_MONEDA,
        IND_FACTUR	  = REGISTRO.IND_FACTUR,
        FEC_ULTMOD    = SYSDATE,
        NOM_USUARIO   = USER
    WHERE COD_CLIENTE			= REGISTRO.COD_CLIENTE
      AND NUM_ABONADO   		= REGISTRO.NUM_ABONADO
      AND COD_CICLFACT  		= REGISTRO.COD_CICLFACT
      AND COD_CONCEPTO          = REGISTRO.COD_CONCEPTO
      AND COD_PROD_CONTRATADO 	= REGISTRO.COD_PROD_CONTRATADO
      AND ID_CARGO  			= REGISTRO.ID_CARGO;

EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 1623 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_TO_U_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
												'FA_CARGOS_SP_PG.FA_CARGOS_TO_U_PR',
												LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_TO_U_PR;

-------------------------------------------------------------------------------

PROCEDURE FA_CARGOS_TO_S_PR (REGISTRO        IN OUT NOCOPY FA_CARGOS_QT,
	                         SR_Row_Id       OUT NOCOPY ROWID,
	                         SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                         SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                         SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
   IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_TO_S_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado leer registros en la tabla FA_CARGOS_TO.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="SR_Row_Id" 		 Tipo="ROWID">RowID de la tabla FA_CARGOS_TO</param>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
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

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    SELECT
    ROWID
    ,SEQ_CARGO
	,COD_CLIENTE
	,NUM_ABONADO
	,COD_PROD_CONTRATADO
	,ID_CARGO
	,COD_CONCEPTO
	,COLUMNA
	,FEC_ALTA
	,IMP_CARGO
	,COD_MONEDA
	,COD_PLANCOM
	,NUM_UNIDADES
	,IND_FACTUR
	,NUM_TRANSACCION
	,NUM_VENTA
	,NUM_PAQUETE
	,NUM_TERMINAL
	,COD_CICLFACT
	,NUM_SERIE
	,NUM_SERIEMEC
	,CAP_CODE
	,MES_GARANTIA
	,NUM_PREGUIA
	,NUM_GUIA
	,COD_CONCEREL
	,COLUMNA_REL
	,COD_CONCEPTO_DTO
	,VAL_DTO
	,TIP_DTO
	,IND_CUOTA
	,NUM_CUOTAS
	,ORD_CUOTA
	,IND_SUPERTEL
	,IND_MANUAL
	,PREF_PLAZA
	,COD_TECNOLOGIA
	,GLS_DESCRIP
	,NUM_FACTURA
	,FEC_ULTMOD
	,NOM_USUARIO
    INTO
    SR_Row_Id
    ,REGISTRO.SEQ_CARGO
	,REGISTRO.COD_CLIENTE
	,REGISTRO.NUM_ABONADO
	,REGISTRO.COD_PROD_CONTRATADO
	,REGISTRO.ID_CARGO
	,REGISTRO.COD_CONCEPTO
	,REGISTRO.COLUMNA
	,REGISTRO.FEC_ALTA
	,REGISTRO.IMP_CARGO
	,REGISTRO.COD_MONEDA
	,REGISTRO.COD_PLANCOM
	,REGISTRO.NUM_UNIDADES
	,REGISTRO.IND_FACTUR
	,REGISTRO.NUM_TRANSACCION
	,REGISTRO.NUM_VENTA
	,REGISTRO.NUM_PAQUETE
	,REGISTRO.NUM_TERMINAL
	,REGISTRO.COD_CICLFACT
	,REGISTRO.NUM_SERIE
	,REGISTRO.NUM_SERIEMEC
	,REGISTRO.CAP_CODE
	,REGISTRO.MES_GARANTIA
	,REGISTRO.NUM_PREGUIA
	,REGISTRO.NUM_GUIA
	,REGISTRO.COD_CONCEREL
	,REGISTRO.COLUMNA_REL
	,REGISTRO.COD_CONCEPTO_DTO
	,REGISTRO.VAL_DTO
	,REGISTRO.TIP_DTO
	,REGISTRO.IND_CUOTA
	,REGISTRO.NUM_CUOTAS
	,REGISTRO.ORD_CUOTA
	,REGISTRO.IND_SUPERTEL
	,REGISTRO.IND_MANUAL
	,REGISTRO.PREF_PLAZA
	,REGISTRO.COD_TECNOLOGIA
	,REGISTRO.GLS_DESCRIP
	,REGISTRO.NUM_FACTURA
	,REGISTRO.FEC_ULTMOD
	,REGISTRO.NOM_USUARIO
    FROM FA_CARGOS_TO
    WHERE  COD_CLIENTE			= REGISTRO.COD_CLIENTE
      AND NUM_ABONADO   		= REGISTRO.NUM_ABONADO
      AND COD_CICLFACT  		= REGISTRO.COD_CICLFACT
      AND COD_CONCEPTO          = REGISTRO.COD_CONCEPTO
      AND COD_PROD_CONTRATADO 	= REGISTRO.COD_PROD_CONTRATADO
      AND ID_CARGO  			= REGISTRO.ID_CARGO;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1637 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_TO_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
												' FA_CARGOS_SP_PG.FA_CARGOS_TO_S_PR',
												LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1626 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_TO_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
												'FA_CARGOS_SP_PG.FA_CARGOS_TO_S_PR',
												LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_TO_S_PR;

-------------------------------------------------------------------------------

PROCEDURE FA_CARGOS_TO_D_PR(REGISTRO        IN FA_CARGOS_QT,
			                SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
			                SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
			                SN_Num_evento   OUT NOCOPY ge_errores_pg.evento)
 IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_TO_D_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado eliminar registros en forma fisica de la tabla FA_CARGOS_TO.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_TO</param>
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

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

	LV_sSql := 'DELETE FROM FA_CARGOS_TO WHERE COD_PROD_CONTRATADO = '||REGISTRO.COD_PROD_CONTRATADO;

    DELETE FROM FA_CARGOS_TO
    WHERE  COD_PROD_CONTRATADO = REGISTRO.COD_PROD_CONTRATADO;

EXCEPTION

  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1637 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_TO_D_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento,
                                                'FA',
                                                SV_mens_retorno,
                                                CV_version, USER,
                                                'FA_CARGOS_SP_PG.FA_CARGOS_TO_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1418;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_TO_D_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento,
                                                'FA',
                                                SV_Mens_retorno,
                                                CV_version, USER,
                                                'FA_CARGOS_SP_PG.FA_CARGOS_TO_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_TO_D_PR;

END FA_CARGOS_SP_PG;
/
SHOW ERRORS
