CREATE OR REPLACE PACKAGE BODY FA_CARGOS_REC_SN_PG AS

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_REC_ALTA_PR (REGISTRO        IN OUT NOCOPY FA_CARGOS_REC_QT,
                                SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.evento
) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_ALTA_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado de hacer el alta de los cargos recurrentes</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
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

ERR_CLIENTE_ERRONEO         EXCEPTION;
ERR_ABONADO_ERRONEO         EXCEPTION;
ERR_CLIENTEABONADO_ERRONEO  EXCEPTION;
ERR_FEC_ALTA_ERRONEO        EXCEPTION;
ERR_FECHA_ANTERIOR          EXCEPTION;
ERR_FEC_BAJA_ERRONEO        EXCEPTION;
ERR_CARGO_ERRONEO           EXCEPTION;
ERR_CONCEPTO_ERRONEO        EXCEPTION;
ERR_PRODUCTO_ERRONEO        EXCEPTION;
ERR_CARGO_REC_ALTA_ERROR    EXCEPTION;
LN_NUM_ABONADO              GA_ABOCEL.NUM_ABONADO%TYPE;

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    IF REGISTRO.COD_CLIENTESERV IS NULL THEN
        RAISE ERR_CLIENTE_ERRONEO;
    END IF;
    IF REGISTRO.NUM_ABONADOSERV IS NULL THEN
        RAISE ERR_ABONADO_ERRONEO;
    END IF;

    -- (+) EV 26-03-2010, Se quita abonado cero y se reemplaza por el primer abonado activo
    --INICIO INC 194913 AFD Se comenta validación para abonado cero
        --    IF (REGISTRO.NUM_ABONADOSERV = 0) THEN
        --        LN_NUM_ABONADO := 0;

        --        SELECT MAX(ABONADO) INTO LN_NUM_ABONADO
        --        FROM (
        --                SELECT MIN(NUM_ABONADO) AS ABONADO
        --                    FROM GA_ABOCEL
        --                    WHERE COD_CLIENTE = REGISTRO.COD_CLIENTESERV
        --                    AND COD_SITUACION NOT IN ('BAA','BAP')
        --                UNION
        --                SELECT MIN(NUM_ABONADO) AS ABONADO
        --                    FROM GA_ABOAMIST
        --                    WHERE COD_CLIENTE = REGISTRO.COD_CLIENTESERV
        --                    AND COD_SITUACION NOT IN ('BAA','BAP')
        --             );

        --        REGISTRO.NUM_ABONADOSERV := LN_NUM_ABONADO;
        --        REGISTRO.NUM_ABONADOPAGO := LN_NUM_ABONADO;

        --    END IF;
    --FIN INC 194913 AFD
    -- (-) EV 26-03-2010, Se quita abonado cero y se reemplaza por el primer abonado activo


    IF NOT FA_CARGOS_SB_PG.FA_VALIDA_CLIENTE_ABONADO_FN (REGISTRO.COD_CLIENTESERV,
                                     REGISTRO.NUM_ABONADOSERV,
                                     SN_cod_retorno  ,
                                     SV_mens_retorno ,
                                     SN_num_evento   ) THEN
        RAISE ERR_CLIENTEABONADO_ERRONEO;
    END IF;

    -- Valida fecha de alta
    IF REGISTRO.FEC_ALTA IS NULL THEN
        RAISE ERR_FEC_ALTA_ERRONEO;
    END IF;

    IF TO_DATE (TO_CHAR(REGISTRO.FEC_ALTA,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') THEN
        RAISE ERR_FECHA_ANTERIOR;
    END IF;

    -- Valida fecha de baja
    IF REGISTRO.FEC_BAJA IS NULL THEN
        REGISTRO.FEC_BAJA := TO_DATE ('30001231','YYYYMMDD');
    END IF;

    IF REGISTRO.FEC_BAJA < REGISTRO.FEC_ALTA THEN
        RAISE ERR_FEC_BAJA_ERRONEO;
    END IF;

    IF REGISTRO.COD_CARGO_CONTRATADO IS NULL THEN
        RAISE ERR_CARGO_ERRONEO;
    END IF;

    IF REGISTRO.COD_PROD_CONTRATADO IS NULL THEN
        RAISE ERR_PRODUCTO_ERRONEO;
    END IF;

    IF REGISTRO.COD_CONCEPTO IS NULL THEN
        RAISE ERR_CONCEPTO_ERRONEO;
    END IF;

    IF NOT FA_CARGOS_SB_PG.FA_VALIDA_CONCEPTO_FN (REGISTRO.cod_concepto ,
                                  SN_cod_retorno  ,
                                  SV_mens_retorno ,
                                  SN_num_evento   ) THEN
        RAISE ERR_CONCEPTO_ERRONEO;
    END IF;

    IF REGISTRO.COD_CLIENTEPAGO IS NULL THEN REGISTRO.COD_CLIENTEPAGO := REGISTRO.COD_CLIENTESERV ;
    END IF;
    IF REGISTRO.NUM_ABONADOPAGO IS NULL THEN REGISTRO.NUM_ABONADOPAGO := REGISTRO.NUM_ABONADOSERV ;
    END IF;
    IF REGISTRO.FEC_DESDECOBR IS NULL THEN REGISTRO.FEC_DESDECOBR := REGISTRO.FEC_ALTA ;
    END IF;
    IF REGISTRO.FEC_HASTACOBR IS NULL THEN REGISTRO.FEC_HASTACOBR := REGISTRO.FEC_BAJA ;
    END IF;
    IF REGISTRO.IND_CARGOPRO IS NULL THEN REGISTRO.IND_CARGOPRO := 0 ;
    END IF;

    FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_I_PR ( REGISTRO,
                             SN_cod_retorno ,
                            SV_mens_retorno,
                            SN_num_evento );

    IF SN_cod_retorno <> 0 THEN
        RAISE ERR_CARGO_REC_ALTA_ERROR;
    END IF;


EXCEPTION
  WHEN ERR_CLIENTEABONADO_ERRONEO THEN
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_FEC_BAJA_ERRONEO THEN
      SN_cod_retorno := 1158 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CLIENTE_ERRONEO THEN
      SN_cod_retorno := 1616 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_ABONADO_ERRONEO THEN
      SN_cod_retorno := 1616 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_FEC_ALTA_ERRONEO THEN
      SN_cod_retorno := 200302 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CARGO_ERRONEO THEN
      SN_cod_retorno := 1618 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_PRODUCTO_ERRONEO THEN
      SN_cod_retorno := 1540 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CONCEPTO_ERRONEO THEN
      SN_cod_retorno := 1620 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CARGO_REC_ALTA_ERROR THEN
     SN_cod_retorno := 880 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
     SN_cod_retorno := 880 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_ALTA_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_REC_ALTA_PR;

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_REC_BAJA_PR (REGISTRO        IN  FA_CARGOS_REC_QT,
                                 SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                 ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_BAJA_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado registrar la baja de cargos recurrentes</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
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

ERR_CLIENTE_ERRONEO     EXCEPTION;
ERR_ABONADO_ERRONEO        EXCEPTION;
ERR_FEC_ALTA_ERRONEO       EXCEPTION;
ERR_FEC_BAJA_ERRONEO       EXCEPTION;
ERR_CARGO_ERRONEO       EXCEPTION;
ERR_PRODUCTO_ERRONEO       EXCEPTION;
ERR_CONCEPTO_ERRONEO       EXCEPTION;
ERR_CARGO_REC_BAJA_ERROR EXCEPTION;

REGISTRO_TMP FA_CARGOS_REC_QT := REGISTRO;

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    IF REGISTRO.COD_CLIENTESERV IS NULL THEN
        RAISE ERR_CLIENTE_ERRONEO;
    END IF;
    IF REGISTRO.NUM_ABONADOSERV IS NULL THEN
        RAISE ERR_ABONADO_ERRONEO;
    END IF;

    -- Valida fecha de alta
    IF REGISTRO.FEC_ALTA IS NULL THEN
        RAISE ERR_FEC_ALTA_ERRONEO;
    END IF;

    -- Valida fecha de baja
    IF REGISTRO.FEC_BAJA IS NULL THEN
        REGISTRO_TMP.FEC_BAJA := SYSDATE;
    END IF;

    IF REGISTRO.FEC_BAJA < REGISTRO.FEC_ALTA  THEN
        RAISE ERR_FEC_BAJA_ERRONEO;
    END IF;

    IF REGISTRO.FEC_HASTACOBR     IS NULL THEN
        REGISTRO_TMP.FEC_HASTACOBR := REGISTRO.FEC_BAJA;
    END IF;

    IF REGISTRO.COD_CARGO_CONTRATADO IS NULL THEN
        RAISE ERR_CARGO_ERRONEO;
    END IF;

    IF REGISTRO.COD_PROD_CONTRATADO IS NULL THEN
        RAISE ERR_PRODUCTO_ERRONEO;
    END IF;

    IF REGISTRO.COD_CONCEPTO IS NULL THEN
        RAISE ERR_CONCEPTO_ERRONEO;
    END IF;

    FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_PR (REGISTRO_TMP ,
                                               SN_Cod_retorno ,
                                               SV_Mens_retorno,
                                               SN_Num_evento  );


    IF SN_cod_retorno <> 0 THEN
        RAISE ERR_CARGO_REC_BAJA_ERROR;
    END IF;

EXCEPTION

  WHEN ERR_CARGO_REC_BAJA_ERROR THEN
      SN_cod_retorno := 1433 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );


  WHEN ERR_FEC_BAJA_ERRONEO THEN
      SN_cod_retorno := 1158 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );
  WHEN ERR_PRODUCTO_ERRONEO THEN
      SN_cod_retorno := 1540 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CARGO_ERRONEO THEN
      SN_cod_retorno := 1618 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_FEC_ALTA_ERRONEO THEN
      SN_cod_retorno := 200302 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CLIENTE_ERRONEO THEN
      SN_cod_retorno :=1616 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_ABONADO_ERRONEO THEN
      SN_cod_retorno := 1616 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 880 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_BAJA_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_BAJA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_REC_BAJA_PR;
-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_REC_ELIMINA_PR (REGISTRO        IN  FA_CARGOS_REC_QT,
                                 SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                 ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_ELIMINA_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado registrar la baja de cargos recurrentes</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
         </Entrada>
         <Salida>
            <param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
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

ERR_CLIENTE_ERRONEO     EXCEPTION;
ERR_ABONADO_ERRONEO        EXCEPTION;
ERR_FEC_ALTA_ERRONEO       EXCEPTION;
ERR_FEC_BAJA_ERRONEO       EXCEPTION;
ERR_CARGO_ERRONEO       EXCEPTION;
ERR_PRODUCTO_ERRONEO       EXCEPTION;
ERR_CONCEPTO_ERRONEO       EXCEPTION;
ERR_CARGO_REC_BAJA_ERROR EXCEPTION;

REGISTRO_TMP FA_CARGOS_REC_QT := REGISTRO;

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    IF REGISTRO.COD_CLIENTESERV IS NULL THEN
        RAISE ERR_CLIENTE_ERRONEO;
    END IF;
    IF REGISTRO.NUM_ABONADOSERV IS NULL THEN
        RAISE ERR_ABONADO_ERRONEO;
    END IF;

    -- Valida fecha de alta
    IF REGISTRO.FEC_ALTA IS NULL THEN
        RAISE ERR_FEC_ALTA_ERRONEO;
    END IF;

    -- Valida fecha de baja
    IF REGISTRO.FEC_BAJA IS NULL THEN
        REGISTRO_TMP.FEC_BAJA := SYSDATE;
    END IF;

    IF REGISTRO.FEC_BAJA < REGISTRO.FEC_ALTA  THEN
        RAISE ERR_FEC_BAJA_ERRONEO;
    END IF;

    IF REGISTRO.FEC_HASTACOBR     IS NULL THEN
        REGISTRO_TMP.FEC_HASTACOBR := REGISTRO.FEC_BAJA;
    END IF;

    IF REGISTRO.COD_CARGO_CONTRATADO IS NULL THEN
        RAISE ERR_CARGO_ERRONEO;
    END IF;

    IF REGISTRO.COD_PROD_CONTRATADO IS NULL THEN
        RAISE ERR_PRODUCTO_ERRONEO;
    END IF;

    IF REGISTRO.COD_CONCEPTO IS NULL THEN
        RAISE ERR_CONCEPTO_ERRONEO;
    END IF;

    FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_D_PR (REGISTRO_TMP ,
                                               SN_Cod_retorno ,
                                               SV_Mens_retorno,
                                               SN_Num_evento  );


    IF SN_cod_retorno <> 0 THEN
        RAISE ERR_CARGO_REC_BAJA_ERROR;
    END IF;

EXCEPTION

  WHEN ERR_CARGO_REC_BAJA_ERROR THEN
      SN_cod_retorno := 1433 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );


  WHEN ERR_FEC_BAJA_ERRONEO THEN
      SN_cod_retorno := 1158 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );
  WHEN ERR_PRODUCTO_ERRONEO THEN
      SN_cod_retorno := 1540 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CARGO_ERRONEO THEN
      SN_cod_retorno := 1618 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_FEC_ALTA_ERRONEO THEN
      SN_cod_retorno := 200302 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_CLIENTE_ERRONEO THEN
      SN_cod_retorno :=1616 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_ABONADO_ERRONEO THEN
      SN_cod_retorno := 1616 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 880 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_BAJA_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_ELIMINA_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_REC_ELIMINA_PR;

PROCEDURE FA_CARGOS_REC_BAJA_SEG_PR (REGISTRO        IN  FA_CARGOS_REC_QT,
                                    SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

/*
<Documentacion TipoDoc = "Procedure">
<Elemento
Nombre = "FA_CARGOS_REC_BAJA_SEG_PR"
Fecha modificacion=" "
Fecha creacion="02-08-2007"
Programador="rao"
Diseñador=""
Ambiente Desarrollo="BD">
<Retorno>N/A</Retorno>
<Descripcion>Procedimiento encargado registrar la baja de cargos recurrentes</Descripcion>
<Parametros>
<Entrada>
<param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
</Entrada>
<Salida>
<param nom="REGISTRO"        Tipo="Registro">Registro de la tabla FA_CARGOS_REC_TO</param>
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

ERR_CLIENTE_ERRONEO        EXCEPTION;
ERR_ABONADO_ERRONEO        EXCEPTION;
ERR_FEC_ALTA_ERRONEO       EXCEPTION;
ERR_FEC_BAJA_ERRONEO       EXCEPTION;
ERR_CARGO_ERRONEO          EXCEPTION;
ERR_PRODUCTO_ERRONEO       EXCEPTION;
ERR_CONCEPTO_ERRONEO       EXCEPTION;
ERR_CARGO_REC_BAJA_ERROR EXCEPTION;

REGISTRO_TMP FA_CARGOS_REC_QT := REGISTRO;


BEGIN

SN_Cod_retorno  := 0;
SV_Mens_retorno := NULL;
SN_Num_evento   := 0;



    IF REGISTRO.COD_CLIENTESERV IS NULL THEN
        RAISE ERR_CLIENTE_ERRONEO;
    END IF;

    IF REGISTRO.NUM_ABONADOSERV IS NULL THEN
        RAISE ERR_ABONADO_ERRONEO;
    END IF;

    -- Valida fecha de alta
    IF REGISTRO.FEC_ALTA IS NULL THEN
        RAISE ERR_FEC_ALTA_ERRONEO;
    END IF;

    -- Valida fecha de baja
    IF REGISTRO.FEC_BAJA IS NULL THEN
        REGISTRO_TMP.FEC_BAJA := SYSDATE;
    END IF;


    IF REGISTRO.FEC_BAJA < REGISTRO.FEC_ALTA  THEN
        RAISE ERR_FEC_BAJA_ERRONEO;
    END IF;

    IF REGISTRO.FEC_HASTACOBR  IS NULL THEN
        REGISTRO_TMP.FEC_HASTACOBR := REGISTRO.FEC_BAJA;
    END IF;


    IF REGISTRO.COD_CARGO_CONTRATADO IS NULL THEN
        RAISE ERR_CARGO_ERRONEO;
    END IF;

    IF REGISTRO.COD_PROD_CONTRATADO IS NULL THEN
        RAISE ERR_PRODUCTO_ERRONEO;
    END IF;

    IF REGISTRO.COD_CONCEPTO IS NULL THEN
        RAISE ERR_CONCEPTO_ERRONEO;
    END IF;

    FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_SEG_PR (REGISTRO_TMP ,
    SN_Cod_retorno ,
    SV_Mens_retorno,
    SN_Num_evento  );


    IF SN_cod_retorno <> 0 THEN
        RAISE ERR_CARGO_REC_BAJA_ERROR;
    END IF;

EXCEPTION

WHEN ERR_CARGO_REC_BAJA_ERROR THEN
    SN_cod_retorno := 1433 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


WHEN ERR_FEC_BAJA_ERRONEO THEN
    SN_cod_retorno := 1158 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


WHEN ERR_PRODUCTO_ERRONEO THEN
    SN_cod_retorno := 1540 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


WHEN ERR_CARGO_ERRONEO THEN
    SN_cod_retorno := 1618 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


WHEN ERR_FEC_ALTA_ERRONEO THEN
    SN_cod_retorno := 200302 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


WHEN ERR_CLIENTE_ERRONEO THEN
    SN_cod_retorno :=1616 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


WHEN ERR_ABONADO_ERRONEO THEN
    SN_cod_retorno := 1616 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_SN_PG(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


WHEN OTHERS THEN
    SN_cod_retorno := 880 ;
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
    SV_mens_retorno := cv_error_no_clasif;
    END IF;
    LV_des_error   := 'FA_CARGOS_REC_TO_BAJA_SEG_PR(); - ' || SQLERRM;
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
    'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_TO_BAJA_SEG_PR',
    LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_CARGOS_REC_BAJA_SEG_PR;


END FA_CARGOS_REC_SN_PG;
/
SHOW ERROR