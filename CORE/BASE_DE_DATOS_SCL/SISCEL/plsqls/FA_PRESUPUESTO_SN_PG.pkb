CREATE OR REPLACE PACKAGE BODY FA_PRESUPUESTO_SN_PG AS
-- INI COL|77754|12-02-2009|SAQL
PROCEDURE FA_VALIDA_ELIM_PRES_PR(
   FA_PRESUP_NUM_PROC   IN    FA_PRESUPUESTO.NUM_PROCESO%TYPE,
   FA_PRESUP_NUM_VTA    IN    FA_PRESUPUESTO.NUM_VENTA%TYPE,
   SN_cod_retorno       OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT   NOCOPY ge_errores_pg.evento
) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento Nombre = "FA_BORRA_PRES_EXCEP_PR"
      Fecha creacion="12-02-2009"
      Programador="Sebastian Quevedo L."
      Diseñador="Sebastian Quevedo L."
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado de hacer la baja de un presupuesto</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="FA_PRESUP_REG" Tipo="Registro">Registro de la tabla FA_PRESUPUESTO_TO</param>
         </Entrada>
         <Salida>
            <param nom="FA_PRESUP_REG"   Tipo="Registro">Registro de la tabla FA_PRESUPUESTO_TO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
   CURSOR FACTURAS IS
      SELECT A.COD_TIPDOCUM, A.PREF_PLAZA, A.NUM_FOLIO, A.NUM_PROCESO
      FROM FA_INTERFACT A
      WHERE A.NUM_VENTA = FA_PRESUP_NUM_VTA
      AND A.NUM_PROCESO <> FA_PRESUP_NUM_PROC;

   NCOD_TIPDOCUM  FA_INTERFACT.COD_TIPDOCUM%TYPE;
   NCOD_VENDEDOR  GA_VENTAS.COD_VENDEDOR%TYPE;
   VCOD_OFICINA   GA_VENTAS.COD_OFICINA%TYPE;
   VCOD_OPERADORA GA_VENTAS.COD_OPERADORA%TYPE;
   VPREF_PLAZA    FA_INTERFACT.PREF_PLAZA%TYPE;
   NNUM_FOLIO     FA_INTERFACT.NUM_FOLIO%TYPE;
   VSTATUS_FOLIO  VARCHAR2(1000);
BEGIN
   FOR X IN FACTURAS LOOP
      IF X.NUM_FOLIO IS NOT NULL THEN
         BEGIN
            SELECT COD_VENDEDOR, COD_OFICINA, COD_OPERADORA
            INTO NCOD_VENDEDOR, VCOD_OFICINA, VCOD_OPERADORA
            FROM GA_VENTAS
            WHERE NUM_VENTA = FA_PRESUP_NUM_VTA;
            NNUM_FOLIO := X.NUM_FOLIO;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               NNUM_FOLIO := NULL;
         END;

         IF NNUM_FOLIO IS NOT NULL THEN -- se debe anular el folio
            VSTATUS_FOLIO := FA_FOLIACION_PG.FA_ANULA_FOLIO_FN(NCOD_TIPDOCUM, NCOD_VENDEDOR, VCOD_OFICINA, VCOD_OPERADORA, VPREF_PLAZA, NNUM_FOLIO);
         END IF;
      END IF;

      -- ACTUALIZO FA_INTERFACT A 900 - 3
      UPDATE FA_INTERFACT SET
      COD_ESTADOC = 900,
      COD_ESTPROC = 3
      WHERE NUM_PROCESO = X.NUM_PROCESO;

      -- ELIMINO FA_FACTDOCU_NOCICLO
      DELETE FA_FACTDOCU_NOCICLO
      WHERE NUM_PROCESO = X.NUM_PROCESO;

      -- ELIMINO FA_PRESUPUESTO
      DELETE FA_PRESUPUESTO WHERE NUM_PROCESO = X.NUM_PROCESO;
   END LOOP;
   SN_cod_retorno := 0;
   SV_mens_retorno := NULL;
   SN_num_evento := 0;
EXCEPTION
   WHEN OTHERS THEN
      SN_cod_retorno := -1;
      SV_mens_retorno := SQLCODE||' - '||SUBSTR(SQLERRM,1,100);
      SN_num_evento := -1;

END FA_VALIDA_ELIM_PRES_PR;
-- FIN COL|77754|12-02-2009|SAQL

-------------------------------------------------------------------------------
PROCEDURE FA_PRESUPUESTO_BORRA_PR ( REGISTRO        IN OUT NOCOPY FA_PRESUPUESTO_QT,
                           SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                           SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                           SN_num_evento       OUT NOCOPY ge_errores_pg.evento
) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_PRESUPUESTO_ALTA_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado de hacer el alta de los cargos ocacionales</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_PRESUPUESTO_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_PRESUPUESTO_TO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"   Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/

-- v1.1 COL 77754|12-02-2009|SAQL

   LV_des_error               ge_errores_pg.DesEvent;
   LV_sSql                    ge_errores_pg.vQuery;

   ERR_NUM_PROCESO_ERRONEO    EXCEPTION;
   ERR_BORRA_PRESUPUESTO      EXCEPTION;
   ERR_NUM_PROCESO_FACTURADO  EXCEPTION;
   ERR_BORRA_GECARGOS         EXCEPTION;
   REGISTROCARGOS             GE_CARGOS_QT := PV_INICIA_ESTRUCTURAS_PG.GE_CARGOS_QT_FN;
   -- INI COL|77754|13-02-2009|SAQL
   E_SIN_ERROR                EXCEPTION;
   NCANTIDAD                  NUMBER;
   -- FIN COL|77754|13-02-2009|SAQL
BEGIN
   SN_Cod_retorno  := 0;
   SV_Mens_retorno := NULL;
   SN_Num_evento   := 0;
   ---------------------------------------------------------------------------
   -- VALIDACIONES GENERALES
   ---------------------------------------------------------------------------
   IF REGISTRO.NUM_PROCESO IS NULL THEN
      RAISE ERR_NUM_PROCESO_ERRONEO;
   END IF;

   -- INI COL|77754|13-02-2009|SAQL
   SELECT COUNT(1) INTO NCANTIDAD
   FROM FA_PRESUPUESTO
   WHERE NUM_PROCESO = REGISTRO.NUM_PROCESO;
   IF NCANTIDAD = 0 THEN
      RAISE E_SIN_ERROR;
   END IF;
   -- FIN COL|77754|13-02-2009|SAQL

   LV_sSql := 'FA_CARGOS_SB_PG.FA_VALIDA_INTERFACT_FN('||REGISTRO.NUM_PROCESO||')';
   IF FA_CARGOS_SB_PG.FA_VALIDA_INTERFACT_FN (REGISTRO.NUM_PROCESO, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE ERR_NUM_PROCESO_FACTURADO;
   END IF;

   -- BORRA REGISTROS DEL PROESUPUESTO INDICADO
   LV_sSql := 'FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_D_PR('||REGISTRO.NUM_PROCESO||')';
   FA_PRESUPUESTO_SP_PG.FA_PRESUPUESTO_D_PR (REGISTRO, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
   IF SN_cod_retorno>0 THEN
      RAISE ERR_BORRA_PRESUPUESTO;
   END IF;

   -- BORRA REGISTROS DE CARGOS INDICADO
   REGISTROCARGOS.NUM_VENTA:=REGISTRO.NUM_VENTA;
   -- LV_sSql := 'FA_CARGOS_SP_PG.FA_CARGOS_TO_D_PR ('||REGISTROCARGOS.NUM_VENTA||')';
   LV_sSql := 'GE_CARGOS_SP_PG.GE_CARGOS_D_PR ('||REGISTROCARGOS.NUM_VENTA||')';
   GE_CARGOS_SP_PG.GE_CARGOS_D_PR(REGISTROCARGOS, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
   IF SN_cod_retorno>0 THEN
      RAISE ERR_BORRA_GECARGOS;
   END IF;
EXCEPTION
   -- INI COL|77754|13-02-2009|SAQL
   WHEN E_SIN_ERROR THEN
      SN_Cod_retorno  := 0;
      SV_Mens_retorno := NULL;
      SN_Num_evento   := 0;
   -- FIN COL|77754|13-02-2009|SAQL
   WHEN ERR_NUM_PROCESO_FACTURADO THEN
      SN_cod_retorno := 1643 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_BORRA_PR (); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,cv_cod_modulo, SV_mens_retorno, CV_version, USER,'FA_PRESUPUESTO_SN_PG.FA_PRESUPUESTO_BORRA_PR',LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERR_NUM_PROCESO_ERRONEO THEN
      SN_cod_retorno := 1642 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_BORRA_PR (); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,cv_cod_modulo, SV_mens_retorno, CV_version, USER,'FA_PRESUPUESTO_SN_PG.FA_PRESUPUESTO_BORRA_PR',LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERR_BORRA_PRESUPUESTO THEN
      SN_cod_retorno := 1428 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_BORRA_PR (); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,cv_cod_modulo, SV_mens_retorno, CV_version, USER,'FA_PRESUPUESTO_SN_PG.FA_PRESUPUESTO_BORRA_PR',LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN ERR_BORRA_GECARGOS THEN
      SN_cod_retorno := 3 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'ERR_BORRA_GECARGOS (); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,cv_cod_modulo, SV_mens_retorno, CV_version, USER,'FA_PRESUPUESTO_SN_PG.FA_PRESUPUESTO_BORRA_PR',LV_sSQL, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno := 1428 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_PRESUPUESTO_BORRA_PR (); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,cv_cod_modulo, SV_mens_retorno, CV_version, USER,'FA_PRESUPUESTO_SN_PG.FA_PRESUPUESTO_BORRA_PR',LV_sSQL, SN_cod_retorno, LV_des_error );
END FA_PRESUPUESTO_BORRA_PR;
-------------------------------------------------------------------------------------------------
END FA_PRESUPUESTO_SN_PG;
/
SHOW ERRORS
