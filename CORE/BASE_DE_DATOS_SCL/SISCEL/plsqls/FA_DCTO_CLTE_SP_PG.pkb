CREATE OR REPLACE PACKAGE BODY FA_DCTO_CLTE_SP_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_DCTOS_SERV_REC_TD_I_PR (REGISTRO IN FA_DCTOS_SERV_REC_TD%ROWTYPE,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.evento
                                                              ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DCTOS_SERV_REC_TD_I_PR"
      Fecha modificacion=" "
      Fecha creacion="20-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado insertar registros en la tabla FA_DCTOS_SERV_REC_TD.</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_DCTOS_SERV_REC_TD</param>
         </Entrada>
         <Salida>
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

BEGIN

    SN_Cod_retorno      := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento       := 0;

        INSERT INTO FA_DCTOS_SERV_REC_TD
        (
        COD_CLIENTE,
        NUM_ABONADO,
        COD_PLANTARIF,
        COD_CARGOBASICO,
        IMP_CARGO_BASICO,
        IMP_DESCUENTO,
        IMP_CARGO_FINAL,
        FEC_DESDEDCTO,
        FEC_HASTADCTO,
        FEC_ULTMOD,
        NOM_USUARORA)
        VALUES
        (
        REGISTRO.COD_CLIENTE,
        NVL(REGISTRO.NUM_ABONADO,0),
        REGISTRO.COD_PLANTARIF,
        REGISTRO.COD_CARGOBASICO,
        REGISTRO.IMP_CARGO_BASICO,
        REGISTRO.IMP_DESCUENTO,
        REGISTRO.IMP_CARGO_FINAL,
        REGISTRO.FEC_DESDEDCTO,
        REGISTRO.FEC_HASTADCTO,
        REGISTRO.FEC_ULTMOD,
        REGISTRO.NOM_USUARORA
        );


EXCEPTION
  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_DCTOS_SERV_REC_TD_I_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_I_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_DCTOS_SERV_REC_TD_I_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE FA_DCTOS_SERV_REC_TD_U_PR (ED_Fec_desdedcto                  IN DATE,
                                                                     ED_Fec_hastadcto                  IN DATE,
                                                                         REGISTRO                                          IN FA_DCTOS_SERV_REC_TD%ROWTYPE,
                                     SN_Cod_retorno                        OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_Mens_retorno                       OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     SN_Num_evento                         OUT NOCOPY ge_errores_pg.evento
                                                              ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DCTOS_SERV_REC_TD_U_PR"
      Fecha modificacion=" "
      Fecha creacion="21-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado actualizar registros en la tabla FA_DCTOS_SERV_REC_TD.</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_DCTOS_SERV_REC_TD</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error      ge_errores_pg.DesEvent;
LV_sSql             ge_errores_pg.vQuery;

BEGIN

    SN_Cod_retorno      := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento       := 0;

        UPDATE FA_DCTOS_SERV_REC_TD
        SET FEC_DESDEDCTO = NVL(ED_fec_desdedcto,FEC_DESDEDCTO ),
                FEC_HASTADCTO = NVL(ED_fec_hastadcto,FEC_HASTADCTO),
                FEC_ULTMOD    = SYSDATE,
                NOM_USUARORA  = USER
        WHERE COD_CLIENTE = REGISTRO.COD_CLIENTE
                  AND  REGISTRO.FEC_DESDEDCTO BETWEEN FEC_DESDEDCTO AND FEC_HASTADCTO;

EXCEPTION
  WHEN OTHERS THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_DCTOS_SERV_REC_TD_U_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_U_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_DCTOS_SERV_REC_TD_U_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE FA_DCTOS_SERV_REC_TD_S_PR (EN_Cod_cliente         IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                            ED_Fec_vigencia     IN DATE,
                                                                                REGISTRO                        OUT NOCOPY FA_DCTOS_SERV_REC_TD%ROWTYPE,
                                                                                SR_Row_Id                       OUT NOCOPY ROWID,
                                                                                SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento       OUT NOCOPY ge_errores_pg.evento)
   IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DCTOS_SERV_REC_TD_S_PR"
      Fecha modificacion=" "
      Fecha creacion="21-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado leer registros en la tabla FA_DCTOS_SERV_REC_TD.</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_Cod_cliente" Tipo="numerico">Codigo del cliente</param>
                         <param nom="ED_Fec_vigencia" Tipo="Fecha">Fecha de vigencia</param>
         </Entrada>
         <Salida>
                    <param nom="REGISTRO" Tipo="Registro">Registro de la tabla FA_DCTOS_SERV_REC_TD</param>
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

BEGIN

    SN_Cod_retorno      := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento       := 0;

        SELECT
        ROWID,
        COD_CLIENTE,
    NUM_ABONADO ,
    COD_PLANTARIF,
    COD_CARGOBASICO,
    IMP_CARGO_BASICO,
    IMP_DESCUENTO,
    IMP_CARGO_FINAL,
    FEC_DESDEDCTO,
    FEC_HASTADCTO,
    FEC_ULTMOD,
    NOM_USUARORA
        INTO
        SR_Row_Id,
    REGISTRO.COD_CLIENTE,
    REGISTRO.NUM_ABONADO ,
    REGISTRO.COD_PLANTARIF,
    REGISTRO.COD_CARGOBASICO,
    REGISTRO.IMP_CARGO_BASICO,
    REGISTRO.IMP_DESCUENTO,
    REGISTRO.IMP_CARGO_FINAL,
    REGISTRO.FEC_DESDEDCTO,
    REGISTRO.FEC_HASTADCTO,
    REGISTRO.FEC_ULTMOD,
    REGISTRO.NOM_USUARORA
        FROM FA_DCTOS_SERV_REC_TD
        WHERE COD_CLIENTE=EN_Cod_cliente
                  AND ED_Fec_vigencia BETWEEN FEC_DESDEDCTO AND FEC_HASTADCTO;



EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1162;

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_DCTOS_SERV_REC_TD_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_DCTOS_SERV_REC_TD_S_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_mens_retorno, CV_version, USER, ' FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_DCTOS_SERV_REC_TD_S_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_DCTOS_SERV_REC_TD_D_PR (   EN_Cod_cliente      IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                            ED_Fec_vigencia     IN DATE,
                                                                                SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                SN_Num_evento       OUT NOCOPY ge_errores_pg.evento)
 IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_DCTOS_SERV_REC_TD_D_PR"
      Fecha modificacion=" "
      Fecha creacion="01-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Procedimiento encargado eliminar registros en forma fisica de la tabla FA_DCTOS_SERV_REC_TD.</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_Cod_cliente" Tipo="Numerico">Codigo de cliente del registro a eliminar</param>
                         <param nom="ED_Fec_vigencia" Tipo="Fecha">Fecha de vigencia posterior a la fecha actual</param>
         </Entrada>
         <Salida>
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

BEGIN

    SN_Cod_retorno      := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento       := 0;

        DELETE FROM FA_DCTOS_SERV_REC_TD
        WHERE COD_CLIENTE = EN_Cod_cliente
                  AND ED_Fec_vigencia BETWEEN FEC_DESDEDCTO AND FEC_HASTADCTO;


EXCEPTION
  WHEN OTHERS THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_DCTOS_SERV_REC_TD_D_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_Mens_retorno, CV_version, USER, ' FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_D_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_DCTOS_SERV_REC_TD_D_PR;



END FA_DCTO_CLTE_SP_PG;
/
SHOW ERRORS
