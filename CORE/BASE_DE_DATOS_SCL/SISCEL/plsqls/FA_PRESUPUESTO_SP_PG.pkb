CREATE OR REPLACE PACKAGE BODY FA_PRESUPUESTO_SP_PG AS

-------------------------------------------------------------------------------
PROCEDURE FA_PRESUPUESTO_I_PR ( REGISTRO 		IN FA_PRESUPUESTO_QT,
			                    SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
			                    SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
			                    SN_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_PRESUPUESTO_I_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado insertar registros en la tabla FA_PRESUPUESTO.</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
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

    INSERT INTO FA_PRESUPUESTO
    (NUM_PROCESO
	,COD_CLIENTE
	,COD_CONCEPTO
	,COLUMNA
	,COD_PRODUCTO
	,COD_MONEDA
	,FEC_VALOR
	,FEC_EFECTIVIDAD
	,IMP_CONCEPTO
	,IMP_FACTURABLE
	,IMP_MONTOBASE
	,COD_REGION
	,COD_PROVINCIA
	,COD_CIUDAD
	,COD_MODULO
	,COD_PLANCOM
	,IND_FACTUR
	,FEC_VENTA
	,NUM_UNIDADES
	,COD_CATIMPOS
	,IND_ESTADO
	,COD_PORTADOR
	,COD_TIPCONCE
	,COD_CICLFACT
	,COD_CONCEREL
	,COLUMNA_REL
	,NUM_ABONADO
	,NUM_TERMINAL
	,CAP_CODE
	,NUM_SERIEMEC
	,NUM_SERIELE
	,FLAG_IMPUES
	,FLAG_DTO
	,PRC_IMPUESTO
	,VAL_DTO
	,TIP_DTO
	,NUM_VENTA
	,MES_GARANTIA
	,IND_ALTA
	,IND_SUPERTEL
	,NUM_PAQUETE
	,NUM_TRANSACCION
	,IND_CUOTA
	,NUM_GUIA
	,NUM_CUOTAS
	,ORD_CUOTA
	,COD_TECNOLOGIA
	)
    VALUES
	(REGISTRO.NUM_PROCESO
	,REGISTRO.COD_CLIENTE
	,REGISTRO.COD_CONCEPTO
	,REGISTRO.COLUMNA
	,REGISTRO.COD_PRODUCTO
	,REGISTRO.COD_MONEDA
	,REGISTRO.FEC_VALOR
	,REGISTRO.FEC_EFECTIVIDAD
	,REGISTRO.IMP_CONCEPTO
	,REGISTRO.IMP_FACTURABLE
	,REGISTRO.IMP_MONTOBASE
	,REGISTRO.COD_REGION
	,REGISTRO.COD_PROVINCIA
	,REGISTRO.COD_CIUDAD
	,REGISTRO.COD_MODULO
	,REGISTRO.COD_PLANCOM
	,REGISTRO.IND_FACTUR
	,REGISTRO.FEC_VENTA
	,REGISTRO.NUM_UNIDADES
	,REGISTRO.COD_CATIMPOS
	,REGISTRO.IND_ESTADO
	,REGISTRO.COD_PORTADOR
	,REGISTRO.COD_TIPCONCE
	,REGISTRO.COD_CICLFACT
	,REGISTRO.COD_CONCEREL
	,REGISTRO.COLUMNA_REL
	,REGISTRO.NUM_ABONADO
	,REGISTRO.NUM_TERMINAL
	,REGISTRO.CAP_CODE
	,REGISTRO.NUM_SERIEMEC
	,REGISTRO.NUM_SERIELE
	,REGISTRO.FLAG_IMPUES
	,REGISTRO.FLAG_DTO
	,REGISTRO.PRC_IMPUESTO
	,REGISTRO.VAL_DTO
	,REGISTRO.TIP_DTO
	,REGISTRO.NUM_VENTA
	,REGISTRO.MES_GARANTIA
	,REGISTRO.IND_ALTA
	,REGISTRO.IND_SUPERTEL
	,REGISTRO.NUM_PAQUETE
	,REGISTRO.NUM_TRANSACCION
	,REGISTRO.IND_CUOTA
	,REGISTRO.NUM_GUIA
	,REGISTRO.NUM_CUOTAS
	,REGISTRO.ORD_CUOTA
	,REGISTRO.COD_TECNOLOGIA
	);

EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 1633 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_I_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
      											'FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_I_PR',
      											LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_PRESUPUESTO_I_PR;

-------------------------------------------------------------------------------
PROCEDURE FA_PRESUPUESTO_U_PR (REGISTRO           IN FA_PRESUPUESTO_QT,
	                         SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	                         SV_Mens_retorno	OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	                         SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
	                         ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_PRESUPUESTO_U_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado actualizar registros en la tabla FA_PRESUPUESTO.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
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

	LV_sSql := 'UPDATE FA_PRESUPUESTO SET IND_ESTADO = '||REGISTRO.IND_ESTADO;
	LV_sSql := LV_sSql || ' WHERE NUM_PROCESO = '||REGISTRO.NUM_PROCESO;

    UPDATE FA_PRESUPUESTO
    SET IND_ESTADO = REGISTRO.IND_ESTADO
    WHERE NUM_PROCESO = REGISTRO.NUM_PROCESO;

EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 1625 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_U_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
												'FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_U_PR',
												LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_PRESUPUESTO_U_PR;

-------------------------------------------------------------------------------

PROCEDURE FA_PRESUPUESTO_S_PR (REGISTRO    IN OUT NOCOPY FA_PRESUPUESTO_QT,
		                     SR_Row_Id       OUT NOCOPY ROWID,
		                     SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
		                     SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
		                     SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
   IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_PRESUPUESTO_S_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado leer registros en la tabla FA_PRESUPUESTO.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
         </Entrada>
         <Salida>
            <param nom="SR_Row_Id" 		 Tipo="ROWID">RowID de la tabla FA_PRESUPUESTO</param>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
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
    ,NUM_PROCESO
	,COD_CLIENTE
	,COD_CONCEPTO
	,COLUMNA
	,COD_PRODUCTO
	,COD_MONEDA
	,FEC_VALOR
	,FEC_EFECTIVIDAD
	,IMP_CONCEPTO
	,IMP_FACTURABLE
	,IMP_MONTOBASE
	,COD_REGION
	,COD_PROVINCIA
	,COD_CIUDAD
	,COD_MODULO
	,COD_PLANCOM
	,IND_FACTUR
	,FEC_VENTA
	,NUM_UNIDADES
	,COD_CATIMPOS
	,IND_ESTADO
	,COD_PORTADOR
	,COD_TIPCONCE
	,COD_CICLFACT
	,COD_CONCEREL
	,COLUMNA_REL
	,NUM_ABONADO
	,NUM_TERMINAL
	,CAP_CODE
	,NUM_SERIEMEC
	,NUM_SERIELE
	,FLAG_IMPUES
	,FLAG_DTO
	,PRC_IMPUESTO
	,VAL_DTO
	,TIP_DTO
	,NUM_VENTA
	,MES_GARANTIA
	,IND_ALTA
	,IND_SUPERTEL
	,NUM_PAQUETE
	,NUM_TRANSACCION
	,IND_CUOTA
	,NUM_GUIA
	,NUM_CUOTAS
	,ORD_CUOTA
	,COD_TECNOLOGIA
    INTO
    SR_Row_Id
    ,REGISTRO.NUM_PROCESO
	,REGISTRO.COD_CLIENTE
	,REGISTRO.COD_CONCEPTO
	,REGISTRO.COLUMNA
	,REGISTRO.COD_PRODUCTO
	,REGISTRO.COD_MONEDA
	,REGISTRO.FEC_VALOR
	,REGISTRO.FEC_EFECTIVIDAD
	,REGISTRO.IMP_CONCEPTO
	,REGISTRO.IMP_FACTURABLE
	,REGISTRO.IMP_MONTOBASE
	,REGISTRO.COD_REGION
	,REGISTRO.COD_PROVINCIA
	,REGISTRO.COD_CIUDAD
	,REGISTRO.COD_MODULO
	,REGISTRO.COD_PLANCOM
	,REGISTRO.IND_FACTUR
	,REGISTRO.FEC_VENTA
	,REGISTRO.NUM_UNIDADES
	,REGISTRO.COD_CATIMPOS
	,REGISTRO.IND_ESTADO
	,REGISTRO.COD_PORTADOR
	,REGISTRO.COD_TIPCONCE
	,REGISTRO.COD_CICLFACT
	,REGISTRO.COD_CONCEREL
	,REGISTRO.COLUMNA_REL
	,REGISTRO.NUM_ABONADO
	,REGISTRO.NUM_TERMINAL
	,REGISTRO.CAP_CODE
	,REGISTRO.NUM_SERIEMEC
	,REGISTRO.NUM_SERIELE
	,REGISTRO.FLAG_IMPUES
	,REGISTRO.FLAG_DTO
	,REGISTRO.PRC_IMPUESTO
	,REGISTRO.VAL_DTO
	,REGISTRO.TIP_DTO
	,REGISTRO.NUM_VENTA
	,REGISTRO.MES_GARANTIA
	,REGISTRO.IND_ALTA
	,REGISTRO.IND_SUPERTEL
	,REGISTRO.NUM_PAQUETE
	,REGISTRO.NUM_TRANSACCION
	,REGISTRO.IND_CUOTA
	,REGISTRO.NUM_GUIA
	,REGISTRO.NUM_CUOTAS
	,REGISTRO.ORD_CUOTA
	,REGISTRO.COD_TECNOLOGIA
    FROM FA_PRESUPUESTO
    WHERE  NUM_PROCESO = REGISTRO.NUM_PROCESO;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1639 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
												' FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_S_PR',
												LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1629 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
      											SV_mens_retorno, CV_version, USER,
												'FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_S_PR',
												LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_PRESUPUESTO_S_PR;

-------------------------------------------------------------------------------

PROCEDURE FA_PRESUPUESTO_D_PR(REGISTRO        IN FA_PRESUPUESTO_QT,
						SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
						SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
						SN_Num_evento   OUT NOCOPY ge_errores_pg.evento)
 IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_PRESUPUESTO_D_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado eliminar registros en forma fisica de la tabla FA_PRESUPUESTO.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_PRESUPUESTO</param>
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

	LV_sSql := 'DELETE FROM FA_PRESUPUESTO WHERE NUM_PROCESO = '||REGISTRO.NUM_PROCESO;

    DELETE FROM FA_PRESUPUESTO
    WHERE  NUM_PROCESO = REGISTRO.NUM_PROCESO;

EXCEPTION

  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1639 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_D_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento,
                                                'FA',
                                                SV_mens_retorno,
                                                CV_version, USER,
                                                'FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1428;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_D_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento,
                                                'FA',
                                                SV_Mens_retorno,
                                                CV_version, USER,
                                                'FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_PRESUPUESTO_D_PR;

-------------------------------------------------------------------------------

PROCEDURE FA_CONS_ARCH_FACT_PR (
   en_num_proceso    IN              fa_interimpresion_td.num_proceso%TYPE,
   sv_rutafac        OUT NOCOPY      VARCHAR2,
   sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
   sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
   sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "FA_CONS_ARCH_FACT_PR"
      Lenguaje="PL/SQL"
      Fecha="03-09-2007"
      Versión="1.0"
      Diseñador="Marcelo Godoy""
      Programador="Marcelo Godoy"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta de servicios contratados y contratables de un abonado ECU-050050</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="en_num_proceso"     Tipo="NUMERICO">Numero de Proceso</param>
         </Entrada>
         <Salida>
            <param nom="sv_rutafac"         Tipo="CARACTER">Cursor de los servicios contratables</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
   AS
      error_ejecucion   EXCEPTION;
      v_des_error       ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := '0';
      sn_num_evento := 0;
      sv_mens_retorno := NULL;

	  ssql:= 'SELECT val_caracter || dir_web'
	      || ' FROM fa_interimpresion_td, fad_parametros'
          || ' WHERE num_proceso = '||en_num_proceso
		  || ' AND cod_parametro = '||cn_num66;

      SELECT val_caracter || dir_web
        INTO sv_rutafac
        FROM fa_interimpresion_td, fad_parametros
       WHERE num_proceso = en_num_proceso AND cod_parametro = cn_num66;

   EXCEPTION
      WHEN error_ejecucion THEN
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;
         v_des_error := SUBSTR ('error_ejecucion: fa_cons_arch_fact_pr('|| en_num_proceso||'); - '|| SQLERRM,1,cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento,'SS',sv_mens_retorno,'1.0',USER,'FA_PRESUPUESTO_SP_PG.fa_cons_arch_fact_pr',ssql,SQLCODE,v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '302';
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;
         v_des_error := SUBSTR('Others: fa_cons_arch_fact_pr('||en_num_proceso||'); - '||SQLERRM,1,cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento :=
         ge_errores_pg.grabarpl (sn_num_evento,'SS',sv_mens_retorno,'1.0',USER,'FA_PRESUPUESTO_SP_PG.fa_cons_arch_fact_pr',ssql,SQLCODE,v_des_error);
   END FA_CONS_ARCH_FACT_PR;

-------------------------------------------------------------------------------

END FA_PRESUPUESTO_SP_PG;
/
SHOW ERRORS
