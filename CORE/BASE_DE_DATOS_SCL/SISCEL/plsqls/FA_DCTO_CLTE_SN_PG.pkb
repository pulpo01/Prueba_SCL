CREATE OR REPLACE PACKAGE BODY FA_DCTO_CLTE_SN_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_INS_DCTO_CLTE_BLSDINAM_PR (
                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  EN_Cod_cargobasico             IN FA_DCTOS_SERV_REC_TD.COD_CARGOBASICO%TYPE,
                                                                  EV_Cod_plantarif                       IN FA_DCTOS_SERV_REC_TD.COD_PLANTARIF%TYPE,
                                                                  EN_Mto_descuento               IN FA_DCTOS_SERV_REC_TD.IMP_DESCUENTO%TYPE,
                                                                  ED_Fec_desdedcto                       IN FA_DCTOS_SERV_REC_TD.FEC_DESDEDCTO%TYPE,
                                                                  ED_Fec_hastadcto                       IN FA_DCTOS_SERV_REC_TD.FEC_HASTADCTO%TYPE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_INS_DCTO_CLTE_BLSDINAM_PR "
      Fecha modificacion=" "
      Fecha creacion="20-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función que permite la configuración de descuentos a clientes </Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_Cod_cliente" Tipo="numerico">Código del cliente</param>
                         <param nom="EN_Cod_cargobasico" Tipo="numerico">Código del cargo básico</param>
                         <param nom="EV_Cod_plantarif" Tipo="caracter">Código de plan tarifario</param>
                         <param nom="EN_mto_descuento"Tipo="numerico">Monto del descuento</param>
                         <param nom="ED_fec_desdedcto" Tipo="fecha">Fecha de inicio de vigencia del descuento</param>
                         <param nom="ED_fec_hastadcto" Tipo="fecha">Fecha de TERMINO de vigencia del descuento</param>
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
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql            ge_errores_pg.vQuery;

REG                        FA_DCTOS_SERV_REC_TD%ROWTYPE;

LV_Cod_moneda      TA_CARGOSBASICO.COD_MONEDA%TYPE;
LN_Num_registros   NUMBER;
EV_flg_rango       TA_PLANTARIF.FLG_RANGO%TYPE;

error_proceso      EXCEPTION;
error_validacion   EXCEPTION;

BEGIN
    SN_Cod_retorno      := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento       := 0;



        IF EN_Cod_cliente IS NULL THEN
          SN_cod_retorno := 877;
          LV_des_error   :='FA_INS_DCTO_CLTE_BLSDINAM_PR(); - Parametro codigo cliente nulo';
          RAISE error_validacion;
        END IF;

        IF EN_Mto_descuento < 0 THEN
          SN_cod_retorno := 1160;
          LV_des_error   :='FA_INS_DCTO_CLTE_BLSDINAM_PR(); - Monto de descuento menor a cero';
          RAISE error_validacion;
        END IF;

        IF ED_Fec_hastadcto < ED_Fec_desdedcto THEN
      SN_cod_retorno := 1158;
          LV_des_error   :='FA_INS_DCTO_CLTE_BLSDINAM_PR(); - La fecha de termino de vigencia no puede ser anterior a la fecha de inicio de la vigencia.';
          RAISE error_validacion;
        END IF;

    FA_DCTO_CLTE_SB_PG.FA_VALIDA_RANGO_FECHA_SB_PR(EN_Cod_cliente, ED_Fec_desdedcto, ED_Fec_hastadcto, LN_Num_registros, SN_Cod_retorno, SV_mens_retorno ,SN_Num_evento);
        IF LN_Num_registros > 0 THEN
          SN_cod_retorno := 1154;
          LV_des_error   :='FA_INS_DCTO_CLTE_BLSDINAM_PR(); - Alguna de las fechas ya tiene rango existente';
          RAISE error_validacion;
        END IF;


    FA_DCTO_CLTE_SB_PG.FA_VALIDA_CLTE_EMPRESA_SB_PR (EN_Cod_cliente ,REG.Cod_Plantarif, SN_Cod_retorno, SV_Mens_retorno ,SN_Num_evento);
        IF SN_cod_retorno <> 0 THEN
          RAISE error_proceso;
        END IF;

        FA_DCTO_CLTE_SB_PG.FA_VALIDA_PLANTAR_BDINAM_SB_PR (EN_Cod_cliente, EV_Cod_plantarif, REG.Cod_cargobasico, EV_flg_rango, SN_Cod_retorno, SV_Mens_retorno, SN_Num_evento );
        IF SN_cod_retorno <> 0 THEN
          RAISE error_proceso;
        END IF;


        FA_DCTO_CLTE_SB_PG.FA_OBTIENE_CARGO_BASICO_SB_PR (REG.Cod_cargobasico, REG.Fec_desdedcto, REG.Fec_hastadcto, REG.Imp_cargo_basico, LV_Cod_moneda, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
        IF SN_cod_retorno <> 0 THEN
          RAISE error_proceso;
        ELSE
           IF EN_Mto_descuento > REG.Imp_cargo_basico THEN
                  SN_cod_retorno := 1156;
              LV_des_error       :='FA_INS_DCTO_CLTE_BLSDINAM_PR(); - El monto del descuento debe ser menor que el cargo básico';
              RAISE error_validacion;
           END IF;
        END IF;


    REG.COD_CLIENTE         := EN_Cod_cliente;
        REG.COD_CARGOBASICO := EN_Cod_cargobasico;
        REG.COD_PLANTARIF       := EV_Cod_plantarif;
        REG.IMP_DESCUENTO       := EN_Mto_descuento;
        REG.IMP_CARGO_FINAL     := REG.Imp_cargo_basico - EN_Mto_descuento;
        REG.FEC_DESDEDCTO   := ED_Fec_desdedcto;
        REG.FEC_HASTADCTO   := ED_Fec_hastadcto;
        REG.FEC_ULTMOD          := SYSDATE;
        REG.NOM_USUARORA        := USER;


        FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_I_PR(Reg, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
        IF SN_cod_retorno <> 0 THEN
          RAISE error_proceso;
        END IF;



EXCEPTION
  WHEN error_proceso THEN
      NULL;

  WHEN error_validacion THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_INS_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_INS_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_INS_DCTO_CLTE_BLSDINAM_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_MODIF_DCTO_CLTE_BLSDINAM_PR (
                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_vigencia                        IN DATE,
                                                                  ED_Fec_desdedcto_new           IN FA_DCTOS_SERV_REC_TD.FEC_DESDEDCTO%TYPE,
                                                                  ED_Fec_hastadcto_new           IN FA_DCTOS_SERV_REC_TD.FEC_HASTADCTO%TYPE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento
                                                              )
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_MODIF_DCTO_CLTE_BLSDINAM_PR"
      Fecha modificacion=" "
      Fecha creacion="21-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función encargada modificar  los descuentos que se aplicaran a los clientes </Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_Cod_cliente" Tipo="numerico">Código del cliente</param>
                         <param nom="ED_fec_vigencia" Tipo="fecha">Fecha para buscar el periodo</param>
                         <param nom="ED_fec_desdedcto_new" Tipo="fecha">Fecha de inicio de vigencia del descuento</param>
                         <param nom="ED_fec_hastadcto_new" Tipo="fecha">Fecha de TERMINO de vigencia del descuento</param>
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

REG                       FA_DCTOS_SERV_REC_TD%ROWTYPE;

LV_Cod_moneda     TA_CARGOSBASICO.COD_MONEDA%TYPE;
LN_Num_registros  NUMBER;
LR_Row_id                 ROWID;

error_proceso     EXCEPTION;
error_validacion  EXCEPTION;

BEGIN
    sn_cod_retorno      := 0;
    sv_mens_retorno := NULL;
    sn_num_evento       := 0;


        IF EN_Cod_cliente IS NULL THEN
          SN_Cod_retorno := 877;
          LV_Des_error   :='FA_MODIF_DCTO_CLTE_BLSDINAM_PR(); - Parametro codigo cliente nulo';
          RAISE error_validacion;
        END IF;

        -- Alguna de las fechas nuevas debe llevar valor
        IF ED_Fec_hastadcto_new IS NULL AND ED_Fec_desdedcto_new IS NULL THEN
      SN_Cod_retorno := 1163;
          LV_Des_error   :='FA_MODIF_DCTO_CLTE_BLSDINAM_PR(); - Al menos una de las fechas debe llevar un valor, ya sea de inicio o término de vigencia.';
          RAISE error_validacion;
        END IF;

        -- La fecha de termino de vigencia no puede ser anterior a la fecha de inicio de la vigencia.
        IF ED_Fec_hastadcto_new < ED_Fec_desdedcto_new THEN
      SN_Cod_retorno := 1158;
          LV_Des_error   :='FA_MODIF_DCTO_CLTE_BLSDINAM_PR(); - La fecha de termino de vigencia no puede ser anterior a la fecha de inicio de la vigencia.';
          RAISE error_validacion;
        END IF;


        --Solamente se podrá modificar la fecha de inicio de vigencia cuando esta sea posterior a la fecha actual del sistema.
        IF ED_Fec_desdedcto_new < SYSDATE AND ED_Fec_hastadcto_new < SYSDATE THEN
      SN_cod_retorno := 1157;
          LV_des_error   :='FA_MODIF_DCTO_CLTE_BLSDINAM_PR(); - la fecha de inicio de vigencia debe ser posterior a la fecha actual del sistema.';
          RAISE error_validacion;
        END IF;

        -- busca el registro para actualizar
        FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_S_PR(EN_Cod_cliente, ED_Fec_vigencia, Reg, LR_Row_id, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    IF SN_cod_retorno <> 0 AND reg.Cod_cliente IS NULL THEN
          SN_cod_retorno := 1162;
          LV_des_error   :='FA_MODIF_DCTO_CLTE_BLSDINAM_PR(); - No existen registros con rangos de la fecha de vigencia: ' || ED_Fec_vigencia;
          RAISE error_validacion;
        END IF;


        -- valida rangos existentes
    FA_DCTO_CLTE_SB_PG.FA_VALIDA_RANGO_FECHA_M_SB_PR(EN_Cod_cliente, LR_Row_id, NVL(ED_Fec_desdedcto_new, Reg.Fec_desdedcto), NVL(ED_Fec_hastadcto_new, Reg.Fec_hastadcto), LN_Num_registros, SN_Cod_retorno, SV_Mens_retorno ,SN_Num_evento);
        IF LN_Num_registros > 0 THEN
          SN_cod_retorno := 1154;
          LV_des_error   :='FA_MODIF_DCTO_CLTE_BLSDINAM_PR(); - Alguna de las fechas ya tiene rango existente';
          RAISE error_validacion;
        END IF;

                --  Existencia del registro de abonado 0 para el cliente en la tabla GA_INTARCEL.
        FA_DCTO_CLTE_SB_PG.FA_VALIDA_CLTE_EMPRESA_SB_PR (EN_Cod_cliente ,REG.Cod_Plantarif,SN_Cod_retorno, SV_Mens_retorno ,SN_Num_evento);
        IF SN_Cod_retorno <> 0 THEN
          RAISE error_proceso;
        END IF;

        -- actualiza con los datos nuevos
        FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_U_PR(ED_Fec_desdedcto_new,ED_Fec_hastadcto_new, Reg, SN_Cod_retorno, SV_Mens_retorno, SN_Num_evento);
        IF SN_Cod_retorno <> 0 THEN
          RAISE error_proceso;
        END IF;



EXCEPTION
  WHEN error_proceso THEN
      NULL;

  WHEN error_validacion THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_Mens_retorno) THEN
         SV_Mens_retorno := cv_error_no_clasif;
      END IF;
          LV_Des_error   := 'FA_MODIF_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_Num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_Mens_retorno, CV_Version, USER, 'FA_DCTO_CLTE_SN_PG.FA_MODIF_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_Cod_retorno, LV_Des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_Mens_retorno) THEN
         SV_Mens_retorno := cv_error_no_clasif;
      END IF;
          LV_Des_error   := 'FA_MODIF_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_Num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_Mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_MODIF_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_Cod_retorno, LV_Des_error );

END FA_MODIF_DCTO_CLTE_BLSDINAM_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_BORRA_DCTO_CLTE_BLSDINAM_PR (
                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_cierre_Vigencia         IN DATE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento
                                                              ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_BORRA_DCTO_CLTE_BLSDINAM_PR"
      Fecha modificacion=" "
      Fecha creacion="21-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Permite cerrar la vigencia de un descuento</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_cod_cliente" Tipo="numerico">Codigo del cliente</param>
                         <param nom="ED_fec_cierre_Vigencia Tipo="fecha">Fecha de cierre</param>
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

LV_des_error        ge_errores_pg.DesEvent;
LV_sSql             ge_errores_pg.vQuery;
error_proceso           EXCEPTION;
error_validacion        EXCEPTION;
LR_Row_id                       ROWID;
REG                             FA_DCTOS_SERV_REC_TD%ROWTYPE;

BEGIN

        IF EN_Cod_cliente IS NULL THEN
          SN_cod_retorno := 877;
          LV_des_error   :='FA_BORRA_DCTO_CLTE_BLSDINAM_PR(); - Parametro codigo cliente nulo';
          RAISE error_validacion;
        END IF;

    IF ED_Fec_cierre_Vigencia < SYSDATE THEN
      SN_Cod_retorno := 1159;
          LV_Des_error   :='FA_BORRA_DCTO_CLTE_BLSDINAM_PR(); - La fecha de termino de vigencia no puede ser anterior a la fecha del sistema.';
          RAISE error_validacion;
        END IF;

        -- busca el registro para eliminar
        FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_S_PR(EN_Cod_cliente, ED_fec_cierre_Vigencia, Reg, LR_Row_id, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    IF SN_Cod_retorno <> 0 AND Reg.Cod_cliente IS NULL THEN
          SN_Cod_retorno := 1162;
          LV_Des_error   :='FA_BORRA_DCTO_CLTE_BLSDINAM_PR(); - No existen registros con rangos de la fecha de vigencia ' || ED_fec_cierre_Vigencia;
          RAISE error_validacion;
        END IF;

        Reg.FEC_HASTADCTO:=ED_Fec_cierre_Vigencia;

        IF Reg.FEC_DESDEDCTO  < SYSDATE OR Reg.FEC_HASTADCTO  < SYSDATE THEN
                -- actualiza con los datos nuevos
                FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_U_PR(Reg.Fec_desdedcto, Reg.Fec_hastadcto, Reg, SN_Cod_retorno, SV_Mens_retorno, SN_Num_evento);
        ELSE
                FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_D_PR(EN_Cod_cliente, ED_fec_cierre_Vigencia , SN_Cod_retorno, SV_Mens_retorno, SN_Num_evento);
        END IF;

        IF SN_Cod_retorno <> 0 THEN
                   RAISE error_proceso;
        END IF;



EXCEPTION
  WHEN error_proceso THEN

      NULL;

  WHEN error_validacion THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_BORRA_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_Mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_Des_error   := 'FA_BORRA_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_Num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_Mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_INS_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_BORRA_DCTO_CLTE_BLSDINAM_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_CONS_DCTO_CLTE_BLSDINAM_PR (
                                                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_valida_vigencia     IN DATE,
                                                                  SV_Cod_plantarif                   OUT NOCOPY FA_DCTOS_SERV_REC_TD.COD_PLANTARIF%TYPE,
                                                                  SN_Imp_descuento                   OUT NOCOPY FA_DCTOS_SERV_REC_TD.IMP_DESCUENTO%TYPE,
                                                                  SD_Fec_desdedcto           OUT NOCOPY FA_DCTOS_SERV_REC_TD.FEC_DESDEDCTO%TYPE,
                                                                  SD_Fec_hastadcto                   OUT NOCOPY FA_DCTOS_SERV_REC_TD.FEC_HASTADCTO%TYPE,
                                  SN_Cod_retorno             OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno            OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento              OUT NOCOPY ge_errores_pg.evento
                                                              ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CONS_DCTO_CLTE_BLSDINAM_PR"
      Fecha modificacion=" "
      Fecha creacion="22-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función encargada consultar el monto del descuento asociado a un cliente empresa para una determinada fecha</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_cod_cliente" Tipo="numerico">Codigo del cliente</param>
                         <param nom="ED_fec_valida_vigencia" Tipo="numerico">Fecha en la que se valida la vigencia del descuento</param>
         </Entrada>
         <Salida>
                    <param nom="SV_cod_plantarif" Tipo="NUMERICO">Código del plan tarifario asociado al descuento</param>
                        <param nom="SN_Imp_descuento" Tipo="NUMERICO">Monto del descuento</param>
                        <param nom="SD_Fec_desdedcto" Tipo="FECHA">Fecha de inicio de la vigencia del descuento</param>
                        <param nom="SD_Fec_hastadcto" Tipo="FECHA">Fecha de termino de la vigencia del descuento</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/

LV_des_error        ge_errores_pg.DesEvent;
LV_sSql             ge_errores_pg.vQuery;
error_proceso           EXCEPTION;
error_validacion        EXCEPTION;
LR_Row_id                       ROWID;
REG                             FA_DCTOS_SERV_REC_TD%ROWTYPE;

BEGIN

        -- busca el registro para consultar
        FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_S_PR(EN_Cod_cliente, ED_fec_valida_vigencia, Reg, LR_Row_id , SN_cod_retorno, SV_mens_retorno, SN_num_evento);
    IF SN_cod_retorno <> 0 AND Reg.cod_cliente IS NULL THEN
          SN_cod_retorno := 1162;
          LV_des_error   :='FA_CONS_DCTO_CLTE_BLSDINAM_PR(); - No existen registros con rangos de la fecha de vigencia ' || ED_fec_valida_vigencia;
          RAISE error_validacion;
        END IF;

        SV_cod_plantarif:=Reg.Cod_plantarif;
        SN_Imp_descuento:=Reg.Imp_Descuento;
        SD_Fec_desdedcto:=Reg.Fec_desdedcto;
        SD_Fec_hastadcto:=Reg.Fec_hastadcto;

EXCEPTION
  WHEN error_proceso THEN
      NULL;

  WHEN error_validacion THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_CONS_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_Num_evento  := Ge_Errores_Pg.Grabarpl( SN_Num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_CONS_DCTO_CLTE_BLSDINAM_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CONS_DCTO_CLTE_BLSDINAM_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_CONS_CARGO_BASICO_CLTE (
                                                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_valida_vigencia         IN DATE,
                                                                  SN_Imp_CargoBasico             OUT NOCOPY FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento
                                                              ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_CONS_CARGO_BASICO_CLTE"
      Fecha modificacion=" "
      Fecha creacion="22-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función encargada cosultar el cargo basico del cliente</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_cod_cliente" Tipo="numerico">Codigo del cliente</param>
                         <param nom="ED_fec_valida_vigencia" Tipo="Fecha">Codigo del cliente</param>
         </Entrada>
         <Salida>
                    <param nom="SN_Imp_CargoBasico"   Tipo="NUMERICO"></param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/



LV_des_error        ge_errores_pg.DesEvent;
LV_sSql             ge_errores_pg.vQuery;
error_proceso           EXCEPTION;
error_validacion        EXCEPTION;
LR_Row_id                       ROWID;
REG                 FA_DCTOS_SERV_REC_TD%ROWTYPE;
LV_Cod_moneda       TA_CARGOSBASICO.COD_MONEDA%TYPE;
LN_Imp_CargoBasico  TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
LN_Imp_Descuento    TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
EN_flg_rango        TA_PLANTARIF.FLG_RANGO%TYPE;

BEGIN

        LN_Imp_CargoBasico:= 0;
        LN_Imp_Descuento:= 0;
        SN_Imp_CargoBasico:=0;

        FA_DCTO_CLTE_SB_PG.FA_VALIDA_CLTE_EMPRESA_SB_PR (EN_Cod_cliente ,REG.Cod_Plantarif,SN_Cod_retorno, SV_Mens_retorno ,SN_Num_evento);
        IF SN_Cod_retorno <> 0 THEN
          RAISE error_proceso;
        END IF;

        FA_DCTO_CLTE_SB_PG.FA_VALIDA_PLANTAR_BDINAM_SB_PR (EN_Cod_cliente, REG.Cod_plantarif, REG.Cod_cargobasico, EN_flg_rango, SN_Cod_retorno, SV_Mens_retorno, SN_Num_evento );
        IF SN_cod_retorno <> 0 THEN
           RAISE error_proceso;
        END IF;

        FA_DCTO_CLTE_SB_PG.FA_OBTIENE_CARGO_BASICO_SB_PR (REG.Cod_cargobasico, REG.Fec_desdedcto, REG.Fec_hastadcto, REG.Imp_cargo_basico, LV_Cod_moneda, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
        IF SN_cod_retorno <> 0 THEN
           RAISE error_proceso;
        END IF;

        LN_Imp_CargoBasico:=REG.Imp_Cargo_basico;

        IF EN_flg_rango = 0 THEN
          LN_Imp_Descuento:=0;
        ELSIF EN_flg_rango=1 THEN
          -- busca el registro para actualizar
          FA_DCTO_CLTE_SP_PG.FA_DCTOS_SERV_REC_TD_S_PR(EN_Cod_cliente, ED_fec_valida_vigencia, Reg, LR_Row_id, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
          IF SN_cod_retorno <> 0 AND Reg.cod_cliente IS NULL THEN
                  SN_cod_retorno := 1162;
                  LV_des_error   :='FA_BORRA_DCTO_CLTE_BLSDINAM_PR(); - No existen registros con rangos de la fecha de vigencia ' || ED_fec_valida_vigencia;
                  RAISE error_validacion;
          END IF;
          LN_Imp_Descuento:=REG.Imp_Descuento;

        END IF;

        SN_Imp_CargoBasico :=LN_Imp_CargoBasico - LN_Imp_Descuento;

EXCEPTION
  WHEN error_proceso THEN
      NULL;

  WHEN error_validacion THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_CONS_CARGO_BASICO_CLTE('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_CONS_CARGO_BASICO_CLTE', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
          LV_des_error   := 'FA_CONS_CARGO_BASICO_CLTE('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SN_PG.FA_CONS_CARGO_BASICO_CLTE', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_CONS_CARGO_BASICO_CLTE;


END FA_DCTO_CLTE_SN_PG;
/
SHOW ERRORS
