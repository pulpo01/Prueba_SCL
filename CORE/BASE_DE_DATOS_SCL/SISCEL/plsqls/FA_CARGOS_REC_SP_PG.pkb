CREATE OR REPLACE PACKAGE BODY FA_CARGOS_REC_SP_PG AS

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_REC_TO_I_PR (REGISTRO IN FA_CARGOS_REC_QT,
                                SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.evento
                                ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_TO_I_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado insertar registros en la tabla FA_CARGOS_REC_TO.</Descripcion>
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

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    INSERT INTO FA_CARGOS_REC_TO
    (COD_CLIENTESERV
    ,NUM_ABONADOSERV
    ,COD_PROD_CONTRATADO
    ,COD_CARGO_CONTRATADO
    ,COD_CLIENTEPAGO
    ,NUM_ABONADOPAGO
    ,COD_TIPSERV
    ,COD_SERVICIO
    ,COD_PLANSERV
    ,IND_CARGOPRO
    ,COD_CONCEPTO
    ,FEC_ALTA
    ,FEC_BAJA
    ,FEC_DESDECOBR
    ,FEC_HASTACOBR
    ,IND_BLOQUEO
    ,EST_BLOQUEO
    ,FEC_DESDEBLOC
    ,FEC_HASTABLOC
    ,FEC_ULTFACTURA
    ,COD_ULTCICLFACT
    ,NUM_ULTPROCESO
    ,FEC_ULTMOD
    ,NOM_USUARIO)
    VALUES
    (REGISTRO.COD_CLIENTESERV
    ,REGISTRO.NUM_ABONADOSERV
    ,REGISTRO.COD_PROD_CONTRATADO
    ,REGISTRO.COD_CARGO_CONTRATADO
    ,REGISTRO.COD_CLIENTEPAGO
    ,REGISTRO.NUM_ABONADOPAGO
    ,REGISTRO.COD_TIPSERV
    ,REGISTRO.COD_SERVICIO
    ,REGISTRO.COD_PLANSERV
    ,REGISTRO.IND_CARGOPRO
    ,REGISTRO.COD_CONCEPTO
    ,NVL(REGISTRO.FEC_ALTA, SYSDATE) -- FEC_ALTA
    ,REGISTRO.FEC_BAJA
    ,REGISTRO.FEC_DESDECOBR
    ,REGISTRO.FEC_HASTACOBR
    ,REGISTRO.IND_BLOQUEO
    ,REGISTRO.EST_BLOQUEO
    ,REGISTRO.FEC_DESDEBLOC
    ,REGISTRO.FEC_HASTABLOC
    ,REGISTRO.FEC_ULTFACTURA
    ,REGISTRO.COD_ULTCICLFACT
    ,REGISTRO.NUM_ULTPROCESO
    ,SYSDATE -- FEC_ULTMOD
    ,DECODE(REGISTRO.NOM_USUARIO,NULL,USER,'',USER,REGISTRO.NOM_USUARIO)    -- NOM_USUARIO
    );

EXCEPTION
  WHEN OTHERS THEN
      SN_cod_retorno := 880 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_I_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                  'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_I_PR',
                                                  LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_REC_TO_I_PR;

-------------------------------------------------------------------------------
PROCEDURE FA_CARGOS_REC_TO_U_PR (REGISTRO           IN FA_CARGOS_REC_QT,
                                 SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                 ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_TO_U_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado actualizar registros en la tabla FA_CARGOS_REC_TO.</Descripcion>
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

ERR_FECHA_INCORRECTA    EXCEPTION;

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    --IF    (REGISTRO.FEC_BAJA IS NOT NULL AND TO_DATE (TO_CHAR(REGISTRO.FEC_BAJA,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') )//inc198305 JLGR
    IF    (REGISTRO.FEC_BAJA IS  NULL )
        --INI 198305 JLGR 
    -- OR (REGISTRO.FEC_DESDECOBR IS NOT NULL AND TO_DATE (TO_CHAR(REGISTRO.FEC_DESDECOBR,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') )
    -- OR (REGISTRO.FEC_HASTACOBR IS NOT NULL AND TO_DATE (TO_CHAR(REGISTRO.FEC_DESDECOBR,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') )
    THEN
      LV_sSql :=  LV_sSql|| ' REGISTRO.FEC_BAJA'||REGISTRO.FEC_BAJA||'REGISTRO.FEC_DESDECOBR'||REGISTRO.FEC_DESDECOBR||'REGISTRO.FEC_HASTACOBR'||REGISTRO.FEC_HASTACOBR;
        --FIN 198305 JLGR
        RAISE ERR_FECHA_INCORRECTA;
    END IF;

    LV_sSql := 'UPDATE FA_CARGOS_REC_TO SET FEC_BAJA = '||REGISTRO.FEC_BAJA;
    LV_sSql := LV_sSql || ' WHERE COD_CLIENTESERV = '||REGISTRO.COD_CLIENTESERV;
    LV_sSql := LV_sSql || ' AND NUM_ABONADOSERV = '||REGISTRO.NUM_ABONADOSERV;
    LV_sSql := LV_sSql || ' AND COD_PROD_CONTRATADO = '||REGISTRO.COD_PROD_CONTRATADO;

    UPDATE FA_CARGOS_REC_TO
    SET FEC_BAJA      = NVL(REGISTRO.FEC_BAJA,FEC_BAJA ),
        FEC_DESDECOBR = NVL(REGISTRO.FEC_DESDECOBR,FEC_DESDECOBR),
        FEC_HASTACOBR = NVL(REGISTRO.FEC_HASTACOBR,FEC_HASTACOBR),
        FEC_ULTMOD    = SYSDATE,
        NOM_USUARIO   = NVL(REGISTRO.NOM_USUARIO,USER)
    WHERE COD_CLIENTESERV         = REGISTRO.COD_CLIENTESERV
      AND NUM_ABONADOSERV        = REGISTRO.NUM_ABONADOSERV
      AND COD_PROD_CONTRATADO   = REGISTRO.COD_PROD_CONTRATADO;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1638 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_D_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_FECHA_INCORRECTA THEN
      SN_cod_retorno := 200302 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SP_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );
  WHEN OTHERS THEN
      SN_cod_retorno := 881 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_U_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_REC_TO_U_PR;

-------------------------------------------------------------------------------

PROCEDURE FA_CARGOS_REC_TO_S_PR (REGISTRO        IN OUT NOCOPY FA_CARGOS_REC_QT,
                                 SR_Row_Id       OUT NOCOPY ROWID,
                                 SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
   IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_TO_S_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado leer registros en la tabla FA_CARGOS_REC_TO.</Descripcion>
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

BEGIN
    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    SELECT
    ROWID
    ,COD_CLIENTESERV
    ,NUM_ABONADOSERV
    ,COD_PROD_CONTRATADO
    ,COD_CARGO_CONTRATADO
    ,COD_CLIENTEPAGO
    ,NUM_ABONADOPAGO
    ,COD_TIPSERV
    ,COD_SERVICIO
    ,COD_PLANSERV
    ,IND_CARGOPRO
    ,COD_CONCEPTO
    ,FEC_ALTA
    ,FEC_BAJA
    ,FEC_DESDECOBR
    ,FEC_HASTACOBR
    ,IND_BLOQUEO
    ,EST_BLOQUEO
    ,FEC_DESDEBLOC
    ,FEC_HASTABLOC
    ,FEC_ULTFACTURA
    ,COD_ULTCICLFACT
    ,NUM_ULTPROCESO
    ,FEC_ULTMOD
    ,NOM_USUARIO
    INTO
    SR_Row_Id
    ,REGISTRO.COD_CLIENTESERV
    ,REGISTRO.NUM_ABONADOSERV
    ,REGISTRO.COD_PROD_CONTRATADO
    ,REGISTRO.COD_CARGO_CONTRATADO
    ,REGISTRO.COD_CLIENTEPAGO
    ,REGISTRO.NUM_ABONADOPAGO
    ,REGISTRO.COD_TIPSERV
    ,REGISTRO.COD_SERVICIO
    ,REGISTRO.COD_PLANSERV
    ,REGISTRO.IND_CARGOPRO
    ,REGISTRO.COD_CONCEPTO
    ,REGISTRO.FEC_ALTA
    ,REGISTRO.FEC_BAJA
    ,REGISTRO.FEC_DESDECOBR
    ,REGISTRO.FEC_HASTACOBR
    ,REGISTRO.IND_BLOQUEO
    ,REGISTRO.EST_BLOQUEO
    ,REGISTRO.FEC_DESDEBLOC
    ,REGISTRO.FEC_HASTABLOC
    ,REGISTRO.FEC_ULTFACTURA
    ,REGISTRO.COD_ULTCICLFACT
    ,REGISTRO.NUM_ULTPROCESO
    ,REGISTRO.FEC_ULTMOD
    ,REGISTRO.NOM_USUARIO
    FROM FA_CARGOS_REC_TO
    WHERE COD_CLIENTESERV       = REGISTRO.COD_CLIENTESERV
      AND COD_PROD_CONTRATADO   = REGISTRO.COD_PROD_CONTRATADO
      AND COD_CARGO_CONTRATADO  = REGISTRO.COD_CARGO_CONTRATADO
      AND COD_CONCEPTO          = REGISTRO.COD_CONCEPTO
      AND TO_DATE (TO_CHAR(FEC_ALTA,'YYYYMMDD'), 'YYYYMMDD') <= TO_DATE (TO_CHAR(REGISTRO.FEC_ALTA,'YYYYMMDD'), 'YYYYMMDD')
      AND TO_DATE (TO_CHAR(FEC_BAJA,'YYYYMMDD'), 'YYYYMMDD') >= NVL(REGISTRO.FEC_BAJA, TO_DATE ('30001231', 'YYYYMMDD'));

EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1638 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_S_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_S_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 1627 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_S_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_S_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_CARGOS_REC_TO_S_PR;

-------------------------------------------------------------------------------

PROCEDURE FA_CARGOS_REC_TO_D_PR(REGISTRO        IN FA_CARGOS_REC_QT,
                                SN_Cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_Mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_Num_evento   OUT NOCOPY ge_errores_pg.evento)
 IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_TO_D_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado eliminar registros en forma fisica de la tabla FA_CARGOS_REC_TO.</Descripcion>
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

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    LV_sSql := 'DELETE FROM FA_CARGOS_REC_TO WHERE COD_CLIENTE = '||REGISTRO.COD_CLIENTESERV;
    LV_sSql := LV_sSql || ' AND NUM_ABONADO = '||REGISTRO.NUM_ABONADOSERV;
    LV_sSql := LV_sSql || ' AND COD_PROD_CONTRATADO = '||REGISTRO.COD_PROD_CONTRATADO;

    DELETE FROM FA_CARGOS_REC_TO
    WHERE COD_CLIENTESERV       = REGISTRO.COD_CLIENTESERV
      AND NUM_ABONADOSERV        = REGISTRO.NUM_ABONADOSERV
      AND COD_PROD_CONTRATADO   = REGISTRO.COD_PROD_CONTRATADO
      AND TO_DATE (TO_CHAR(FEC_ALTA,'YYYYMMDD'), 'YYYYMMDD')  <= TO_DATE (TO_CHAR(REGISTRO.FEC_ALTA,'YYYYMMDD'), 'YYYYMMDD')
      AND TO_DATE (TO_CHAR(FEC_BAJA,'YYYYMMDD'), 'YYYYMMDD')  >= NVL(REGISTRO.FEC_BAJA, TO_DATE ('30001231', 'YYYYMMDD'));

    DBMS_OUTPUT.PUT_LINE (LV_sSql);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1638 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_D_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );
  WHEN OTHERS THEN
      SN_cod_retorno := 1433;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_D_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                  'FA', SV_mens_retorno, CV_version, USER,
                                                'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_D_PR',
                                                LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CARGOS_REC_TO_D_PR;



PROCEDURE FA_CARGOS_REC_TO_U_SEG_PR (REGISTRO           IN FA_CARGOS_REC_QT,
                                 SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                 ) IS

/*

<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CARGOS_REC_TO_U_SEG_PR"
      Fecha modificacion=" "
      Fecha creacion="02-08-2007"
      Programador="rao"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado actualizar registros en la tabla FA_CARGOS_REC_TO.</Descripcion>
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

ERR_FECHA_INCORRECTA    EXCEPTION;


BEGIN



    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;


    IF    (REGISTRO.FEC_BAJA IS NOT NULL AND TO_DATE (TO_CHAR(REGISTRO.FEC_BAJA,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') )
       OR (REGISTRO.FEC_DESDECOBR IS NOT NULL AND TO_DATE (TO_CHAR(REGISTRO.FEC_DESDECOBR,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') )
       OR (REGISTRO.FEC_HASTACOBR IS NOT NULL AND TO_DATE (TO_CHAR(REGISTRO.FEC_DESDECOBR,'YYYYMMDD'),'YYYYMMDD') < TO_DATE (TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') )

    THEN
        RAISE ERR_FECHA_INCORRECTA;
    END IF;



    LV_sSql := 'UPDATE FA_CARGOS_REC_TO SET FEC_BAJA = '||REGISTRO.FEC_BAJA;
    LV_sSql := LV_sSql ||' FEC_DESDECOBR = '||REGISTRO.FEC_DESDECOBR;
    LV_sSql := LV_sSql ||' FEC_HASTACOBR = '||REGISTRO.FEC_BAJA;
    LV_sSql := LV_sSql ||' FEC_HASTABLOC = '||REGISTRO.FEC_BAJA;
    LV_sSql := LV_sSql ||' FEC_ULTMOD = '||SYSDATE;
    LV_sSql := LV_sSql ||' WHERE COD_CLIENTESERV = '||REGISTRO.COD_CLIENTESERV;
    LV_sSql := LV_sSql ||' AND NUM_ABONADOSERV = '||REGISTRO.NUM_ABONADOSERV;
    LV_sSql := LV_sSql ||' AND COD_PROD_CONTRATADO = '||REGISTRO.COD_PROD_CONTRATADO;
    LV_sSql := LV_sSql ||' AND COD_CONCEPTO = '||REGISTRO.COD_CONCEPTO;
    LV_sSql := LV_sSql ||' AND FEC_ALTA <= SYSDATE';
    LV_sSql := LV_sSql ||' AND FEC_BAJA > SYSDATE';

    UPDATE FA_CARGOS_REC_TO
    SET FEC_BAJA      = NVL(REGISTRO.FEC_BAJA,FEC_BAJA ),
        FEC_DESDECOBR = NVL(REGISTRO.FEC_DESDECOBR,FEC_DESDECOBR),
        ----FEC_HASTACOBR = NVL(REGISTRO.FEC_HASTACOBR,FEC_HASTACOBR),
        FEC_HASTACOBR = NVL(REGISTRO.FEC_BAJA,FEC_BAJA),
        FEC_HASTABLOC = REGISTRO.FEC_BAJA,
        FEC_ULTMOD    = SYSDATE,
        NOM_USUARIO   = NVL(REGISTRO.NOM_USUARIO,USER)
    WHERE COD_CLIENTESERV          = REGISTRO.COD_CLIENTESERV
      AND NUM_ABONADOSERV         = REGISTRO.NUM_ABONADOSERV
      AND COD_PROD_CONTRATADO     = REGISTRO.COD_PROD_CONTRATADO
      AND COD_CARGO_CONTRATADO    = REGISTRO.COD_CARGO_CONTRATADO
      AND COD_CONCEPTO            = REGISTRO.COD_CONCEPTO
      AND FEC_ALTA <= SYSDATE
      AND FEC_BAJA > SYSDATE;

EXCEPTION

  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1638 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_D_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,'FA', SV_mens_retorno, CV_version, USER,
     'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_SEG_PR',LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN ERR_FECHA_INCORRECTA THEN
      SN_cod_retorno := 200302 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_SP_PG(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento,
         'FA', SV_mens_retorno, CV_version, USER,    'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_SEG_PR', LV_sSQL, SN_cod_retorno,
      LV_des_error );

  WHEN OTHERS THEN
      SN_cod_retorno := 881 ;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_CARGOS_REC_TO_U_SEG_PR(); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER,
    'FA_CARGOS_REC_SP_PG.FA_CARGOS_REC_TO_U_SEG_PR',LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_CARGOS_REC_TO_U_SEG_PR;

END FA_CARGOS_REC_SP_PG;
/
