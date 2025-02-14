CREATE OR REPLACE PACKAGE BODY GE_CARGOS_SP_PG AS

-------------------------------------------------------------------------------
PROCEDURE GE_CARGOS_I_PR (REGISTRO   IN GE_CARGOS_QT,
                     SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                     SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                     SN_num_evento   OUT NOCOPY ge_errores_pg.evento
) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GE_CARGOS_I_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado insertar registros en la tabla GE_CARGOS.</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla GE_CARGOS</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla GE_CARGOS</param>
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

    INSERT INTO GE_CARGOS
    (NUM_CARGO
 ,COD_CLIENTE
 ,COD_PRODUCTO
 ,COD_CONCEPTO
 ,FEC_ALTA
 ,IMP_CARGO
 ,COD_MONEDA
 ,COD_PLANCOM
 ,NUM_UNIDADES
 ,IND_FACTUR
 ,NUM_TRANSACCION
 ,NUM_VENTA
 ,NUM_PAQUETE
 ,NUM_ABONADO
 ,NUM_TERMINAL
 ,COD_CICLFACT
 ,NUM_SERIE
 ,NUM_SERIEMEC
 ,CAP_CODE
 ,MES_GARANTIA
 ,NUM_PREGUIA
 ,NUM_GUIA
 ,NUM_FACTURA
 ,COD_CONCEPTO_DTO
 ,VAL_DTO
 ,TIP_DTO
 ,IND_CUOTA
 ,IND_SUPERTEL
 ,IND_MANUAL
 ,NOM_USUARORA
 ,PREF_PLAZA
 ,COD_TECNOLOGIA
 )
    VALUES
 (REGISTRO.NUM_CARGO
 ,REGISTRO.COD_CLIENTE
 ,REGISTRO.COD_PRODUCTO
 ,REGISTRO.COD_CONCEPTO
 ,REGISTRO.FEC_ALTA
 ,REGISTRO.IMP_CARGO
 ,REGISTRO.COD_MONEDA
 ,REGISTRO.COD_PLANCOM
 ,REGISTRO.NUM_UNIDADES
 ,REGISTRO.IND_FACTUR
 ,REGISTRO.NUM_TRANSACCION
 ,REGISTRO.NUM_VENTA
 ,REGISTRO.NUM_PAQUETE
 ,REGISTRO.NUM_ABONADO
 ,REGISTRO.NUM_TERMINAL
 ,REGISTRO.COD_CICLFACT
 ,REGISTRO.NUM_SERIE
 ,REGISTRO.NUM_SERIEMEC
 ,REGISTRO.CAP_CODE
 ,REGISTRO.MES_GARANTIA
 ,REGISTRO.NUM_PREGUIA
 ,REGISTRO.NUM_GUIA
 ,REGISTRO.NUM_FACTURA
 ,REGISTRO.COD_CONCEPTO_DTO
 ,REGISTRO.VAL_DTO
 ,REGISTRO.TIP_DTO
 ,REGISTRO.IND_CUOTA
 ,REGISTRO.IND_SUPERTEL
 ,REGISTRO.IND_MANUAL
 ,DECODE(REGISTRO.NOM_USUARORA,NULL,USER,'',USER,REGISTRO.NOM_USUARORA)
 ,REGISTRO.PREF_PLAZA
 ,REGISTRO.COD_TECNOLOGIA
 );

EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 1633 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'GE_CARGOS_I_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
                 SV_mens_retorno, CV_version, USER,
                 'GE_CARGOS_SP_PG.GE_CARGOS_I_PR',
                 LV_sSQL, SN_cod_retorno, LV_des_error );

END GE_CARGOS_I_PR;

-------------------------------------------------------------------------------
PROCEDURE GE_CARGOS_U_PR (REGISTRO           IN GE_CARGOS_QT,
                          SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                          SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                          SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                          ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GE_CARGOS_U_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado actualizar registros en la tabla GE_CARGOS.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla GE_CARGOS</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla GE_CARGOS</param>
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

 LV_sSql := 'UPDATE GE_CARGOS SET IMP_CARGO = '||REGISTRO.IMP_CARGO;
 LV_sSql := LV_sSql || ' COD_MONEDA = '||REGISTRO.COD_MONEDA;
 LV_sSql := LV_sSql || ' IND_FACTUR = '||REGISTRO.IND_FACTUR;
 LV_sSql := LV_sSql || ' WHERE COD_CLIENTE = '||REGISTRO.COD_CLIENTE;
 LV_sSql := LV_sSql || ' AND NUM_ABONADO = '||REGISTRO.NUM_ABONADO;
 LV_sSql := LV_sSql || ' AND COD_CONCEPTO = '||REGISTRO.COD_CONCEPTO;

    UPDATE GE_CARGOS
    SET IMP_CARGO     = NVL(REGISTRO.IMP_CARGO, IMP_CARGO),
        COD_MONEDA   = NVL(REGISTRO.COD_MONEDA, COD_MONEDA),
        IND_FACTUR   = NVL(REGISTRO.IND_FACTUR, IND_FACTUR),
        NOM_USUARORA   = USER
    WHERE COD_CLIENTE   = REGISTRO.COD_CLIENTE
      AND NUM_ABONADO     = REGISTRO.NUM_ABONADO
      AND COD_CICLFACT    = REGISTRO.COD_CICLFACT
      AND COD_CONCEPTO          = REGISTRO.COD_CONCEPTO;

EXCEPTION
  WHEN OTHERS THEN
     SN_cod_retorno := 1625 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'GE_CARGOS_U_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
                 SV_mens_retorno, CV_version, USER,
            'GE_CARGOS_SP_PG.GE_CARGOS_U_PR',
            LV_sSQL, SN_cod_retorno, LV_des_error );

END GE_CARGOS_U_PR;

-------------------------------------------------------------------------------

PROCEDURE GE_CARGOS_S_PR (REGISTRO    IN OUT NOCOPY GE_CARGOS_QT,
                      SR_Row_Id       OUT NOCOPY ROWID,
                      SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                      SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                      SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
   IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GE_CARGOS_S_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado leer registros en la tabla GE_CARGOS.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla GE_CARGOS</param>
         </Entrada>
         <Salida>
            <param nom="SR_Row_Id"    Tipo="ROWID">RowID de la tabla GE_CARGOS</param>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla GE_CARGOS</param>
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
    ,NUM_CARGO
 ,COD_CLIENTE
 ,COD_PRODUCTO
 ,COD_CONCEPTO
 ,FEC_ALTA
 ,IMP_CARGO
 ,COD_MONEDA
 ,COD_PLANCOM
 ,NUM_UNIDADES
 ,IND_FACTUR
 ,NUM_TRANSACCION
 ,NUM_VENTA
 ,NUM_PAQUETE
 ,NUM_ABONADO
 ,NUM_TERMINAL
 ,COD_CICLFACT
 ,NUM_SERIE
 ,NUM_SERIEMEC
 ,CAP_CODE
 ,MES_GARANTIA
 ,NUM_PREGUIA
 ,NUM_GUIA
 ,NUM_FACTURA
 ,COD_CONCEPTO_DTO
 ,VAL_DTO
 ,TIP_DTO
 ,IND_CUOTA
 ,IND_SUPERTEL
 ,IND_MANUAL
 ,NOM_USUARORA
 ,PREF_PLAZA
 ,COD_TECNOLOGIA
    INTO
    SR_Row_Id
    ,REGISTRO.NUM_CARGO
 ,REGISTRO.COD_CLIENTE
 ,REGISTRO.COD_PRODUCTO
 ,REGISTRO.COD_CONCEPTO
 ,REGISTRO.FEC_ALTA
 ,REGISTRO.IMP_CARGO
 ,REGISTRO.COD_MONEDA
 ,REGISTRO.COD_PLANCOM
 ,REGISTRO.NUM_UNIDADES
 ,REGISTRO.IND_FACTUR
 ,REGISTRO.NUM_TRANSACCION
 ,REGISTRO.NUM_VENTA
 ,REGISTRO.NUM_PAQUETE
 ,REGISTRO.NUM_ABONADO
 ,REGISTRO.NUM_TERMINAL
 ,REGISTRO.COD_CICLFACT
 ,REGISTRO.NUM_SERIE
 ,REGISTRO.NUM_SERIEMEC
 ,REGISTRO.CAP_CODE
 ,REGISTRO.MES_GARANTIA
 ,REGISTRO.NUM_PREGUIA
 ,REGISTRO.NUM_GUIA
 ,REGISTRO.NUM_FACTURA
 ,REGISTRO.COD_CONCEPTO_DTO
 ,REGISTRO.VAL_DTO
 ,REGISTRO.TIP_DTO
 ,REGISTRO.IND_CUOTA
 ,REGISTRO.IND_SUPERTEL
 ,REGISTRO.IND_MANUAL
 ,REGISTRO.NOM_USUARORA
 ,REGISTRO.PREF_PLAZA
 ,REGISTRO.COD_TECNOLOGIA
    FROM GE_CARGOS
    WHERE  COD_CLIENTE   = REGISTRO.COD_CLIENTE
      AND NUM_ABONADO     = REGISTRO.NUM_ABONADO
      AND COD_CICLFACT    = REGISTRO.COD_CICLFACT
      AND COD_CONCEPTO          = REGISTRO.COD_CONCEPTO;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1639 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'GE_CARGOS_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
                 SV_mens_retorno, CV_version, USER,
            ' GE_CARGOS_SP_PG.GE_CARGOS_S_PR',
            LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1629 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'GE_CARGOS_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
                 SV_mens_retorno, CV_version, USER,
            'GE_CARGOS_SP_PG.GE_CARGOS_S_PR',
            LV_sSQL, SN_cod_retorno, LV_des_error );

END GE_CARGOS_S_PR;

-------------------------------------------------------------------------------

PROCEDURE GE_CARGOS_D_PR(REGISTRO        IN GE_CARGOS_QT,
      SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      SN_Num_evento   OUT NOCOPY ge_errores_pg.evento)
 IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "GE_CARGOS_D_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado eliminar registros en forma fisica de la tabla GE_CARGOS.</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="REGISTRO" Tipo="Registro">Registro de la tabla GE_CARGOS</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla GE_CARGOS</param>
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

 LV_sSql := 'DELETE FROM GE_CARGOS WHERE NUM_VENTA = '||REGISTRO.NUM_VENTA;

    DELETE FROM GE_CARGOS
    WHERE  NUM_VENTA = REGISTRO.NUM_VENTA;

EXCEPTION

  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1639 ; -- Generar otro codigo
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'GE_CARGOS_D_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento,
                                                'FA',
                                                SV_mens_retorno,
                                                CV_version, USER,
                                                'GE_CARGOS_SP_PG.GE_CARGOS_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1428;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'GE_CARGOS_D_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento,
                                                'FA',
                                                SV_Mens_retorno,
                                                CV_version, USER,
                                                'GE_CARGOS_SP_PG.GE_CARGOS_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END GE_CARGOS_D_PR;

END GE_CARGOS_SP_PG;
/
SHOW ERRORS
