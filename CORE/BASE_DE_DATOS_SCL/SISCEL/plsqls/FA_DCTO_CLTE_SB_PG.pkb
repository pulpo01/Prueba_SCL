CREATE OR REPLACE PACKAGE BODY FA_DCTO_CLTE_SB_PG AS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_VALIDA_CLTE_EMPRESA_SB_PR (
                                  EN_Cod_cliente    IN  GA_INTARCEL.COD_CLIENTE%TYPE,
                                  SV_Cod_Plantarif  OUT NOCOPY TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                  SN_Cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento     OUT NOCOPY ge_errores_pg.evento
                                  )
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_VALIDA_CLTE_EMPRESA_SB_PR"
      Fecha modificacion=" "
      Fecha creacion="19-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función encargada validar un cliente empresa en el sistema</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EN_cod_cliente" Tipo="numerico">Codigo del cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_Cod_Plantarif"     Tipo="CARACTER">Codigo de plan tarifario</param>
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
LN_Num_Abonado    ga_abocel.num_abonado%TYPE;
LB_IndVenta       BOOLEAN := FALSE;
BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

    LV_sSql := ' SELECT cod_plantarif '
            || ' INTO SV_Cod_Plantarif '
            || ' FROM ga_empresa '
            || ' WHERE cod_cliente = '|| EN_Cod_cliente;

    SELECT cod_plantarif
       INTO SV_Cod_Plantarif
       FROM ga_empresa
       WHERE cod_cliente =EN_Cod_cliente;

    BEGIN
            SELECT num_abonado
              INTO LN_Num_Abonado
              FROM GA_ABOCEL
             WHERE cod_cliente =EN_Cod_cliente
               AND COD_SITUACION NOT IN ('BAP', 'BAA')
               AND ROWNUM = 1;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    LB_IndVenta := TRUE;
    END;

    IF NOT LB_IndVenta THEN
        BEGIN
            LV_sSql:='SELECT cod_plantarif INTO LT_cod_plantarif FROM GA_FINCICLO WHERE COD_CLIENTE = ' || EN_Cod_cliente
             || ' AND num_abonado = '|| LN_Num_Abonado;
         SELECT cod_plantarif
           INTO SV_Cod_Plantarif
           FROM GA_FINCICLO
          WHERE cod_cliente = EN_Cod_cliente
            AND num_abonado = LN_Num_Abonado
            AND cod_ciclfact IS NOT NULL
            AND cod_plantarif IS NOT NULL;
       EXCEPTION
        WHEN NO_DATA_FOUND THEN

            LV_sSql :='SELECT cod_plantarif INTO LT_cod_plantarif FROM GA_ABOCEL WHERE cod_cliente =' || EN_Cod_cliente
                    ||' AND num_abonado = '|| LN_Num_Abonado;
            SELECT cod_plantarif
              INTO SV_Cod_Plantarif
              FROM GA_ABOCEL
             WHERE cod_cliente = EN_Cod_cliente
               AND num_abonado = LN_Num_Abonado;
       END;
    END IF;

EXCEPTION

  WHEN DUP_VAL_ON_INDEX OR TOO_MANY_ROWS THEN
      SN_cod_retorno :=1164; -- Existen registros duplicados del cliente empresa
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_VALIDA_CLTE_EMPRESA_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_VALIDA_CLTE_EMPRESA_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


  WHEN NO_DATA_FOUND THEN

      SN_cod_retorno := 1155; -- Cliente no es empresa o no está vigente
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_VALIDA_CLTE_EMPRESA_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_VALIDA_CLTE_EMPRESA_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN


      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_VALIDA_CLTE_EMPRESA_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_VALIDA_CLTE_EMPRESA_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_VALIDA_CLTE_EMPRESA_SB_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_OBTIENE_CARGO_BASICO_SB_PR (
                                  EV_Cod_cargobasico         IN  TA_PLANTARIF.COD_CARGOBASICO%TYPE,
                                  SD_Fec_desdedcto           OUT NOCOPY DATE,
                                  SD_Fec_hastadcto           OUT NOCOPY DATE,
                                  SN_Imp_cargobasico         OUT NOCOPY FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE,
                                  SV_Cod_moneda              OUT NOCOPY TA_CARGOSBASICO.COD_MONEDA%TYPE,
                                  SN_Cod_retorno             OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno            OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento              OUT NOCOPY ge_errores_pg.evento
                                  ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_OBTIENE_CARGO_BASICO_SB_PR"
      Fecha modificacion=" "
      Fecha creacion="19-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función que obtiene el cargo basico de un cliente</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EV_Cod_cargobasico" Tipo="caracter">Codigo de Cargo basico</param>
         </Entrada>
         <Salida>
            <param nom="SD_Fec_desdedcto"     Tipo="FECHA">Fecha de inicio de vigencia</param>
            <param nom="SD_Fec_hastadcto"     Tipo="FECHA">Fecha de termino de vigencia</param>
            <param nom="SD_Imp_cargobasico"   Tipo="NUMERICO">Monto del cargo basico</param>
            <param nom="SV_Cod_moneda"        Tipo="CARACTER">Codigo de moneda</param>
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

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;



    LV_sSql := ' SELECT a.fec_desde, a.fec_hasta, a.imp_cargo_basico, a.cod_moneda '
       || ' INTO SD_Fec_desdedcto, SD_Fec_hastadcto, SN_Imp_cargobasico, SV_Cod_moneda '
       || ' FROM ta_cargosbasico a '
       || ' WHERE cod_cargobasico= ' || EV_Cod_cargobasico ;

       SELECT a.fec_desde, a.fec_hasta, a.imp_cargobasico, a.cod_moneda
       INTO SD_Fec_desdedcto, SD_Fec_hastadcto, SN_Imp_cargobasico, SV_Cod_moneda
       FROM ta_cargosbasico a
       WHERE cod_cargobasico=EV_Cod_cargobasico;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 1161; -- No existe cargo basico
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_OBTIENE_CARGO_BASICO_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_OBTIENE_CARGO_BASICO_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_OBTIENE_CARGO_BASICO_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_OBTIENE_CARGO_BASICO_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_OBTIENE_CARGO_BASICO_SB_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_VALIDA_PLANTAR_BDINAM_SB_PR (EN_Cod_cliente    IN  GA_INTARCEL.COD_CLIENTE%TYPE,
                                  EV_Cod_plantarif          IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                  SV_Cod_cargoBasico        OUT NOCOPY TA_PLANTARIF.COD_CARGOBASICO%TYPE,
                                  SN_flg_rango              OUT NOCOPY TA_PLANTARIF.FLG_RANGO%TYPE,
                                  SN_Cod_retorno            OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno           OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento             OUT NOCOPY ge_errores_pg.evento)
 IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_VALIDA_PLANTAR_BDINAM_SB_PR"
      Fecha modificacion=" "
      Fecha creacion="21-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función encargada validar si un plan tarifario corresponde a un plan tarifario de bolsas dinámicas</Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EN_cod_cliente" Tipo="numerico">Codigo del cliente</param>
             <param nom="EN_cod_plantarif" Tipo="numerico">Código del plan tarifario</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_cargobasico"   Tipo="CARACTER">Codigo de cargo básico</param>
            <param nom="SN_flg_rango          Tipo="NUMERICO">Indicador de Rango de bolsas dinámicas</param>
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

BEGIN

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;

    SN_flg_rango:=0;

    LV_sSql := ' SELECT b.cod_cargobasico, b.flg_rango '
       ||' INTO SV_cod_cargobasico, SN_flg_rango '
       ||' FROM ta_plantarif b '
       ||' WHERE b.cod_plantarif= EN_Cod_plantarif ';

       SELECT b.cod_cargobasico, b.flg_rango
       INTO SV_cod_cargobasico, SN_flg_rango
       FROM ta_plantarif b
       WHERE b.cod_plantarif= EV_Cod_plantarif;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
       NULL;

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_VALIDA_PLANTAR_BDINAM_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_VALIDA_PLANTAR_BDINAM_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_VALIDA_PLANTAR_BDINAM_SB_PR;




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_VALIDA_RANGO_FECHA_SB_PR (
                                  EN_Cod_cliente     IN GA_INTARCEL.COD_CLIENTE%TYPE,
                                  ED_Fec_desdedcto   IN DATE,
                                  ED_Fec_hastadcto   IN DATE,
                                  SN_Num_Registros   OUT NOCOPY NUMBER,
                                  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                  ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_VALIDA_RANGO_FECHA_SB_PR"
      Fecha modificacion=" "
      Fecha creacion="23-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función encargada validar los rangos de descuento de un cliente empresa en el sistema</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="numerico">Codigo del cliente</param>
            <param nom="ED_Fec_vigencia"     Tipo="FECHA">Fecha de vigencia</param>
            <param nom="ED_Fec_desdedcto"     Tipo="FECHA">Fecha de inicio de vigencia</param>
            <param nom="ED_Fec_hastadcto"     Tipo="FECHA">Fecha de termino de vigencia</param>
         </Entrada>
         <Salida>
            <param nom="SN_Num_Registros"     Tipo="NUMERICO">Numero de registros encontrados</param>
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

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;



    LV_sSql := ' SELECT COUNT(1) '
       || ' INTO SN_Num_registros '
       || ' FROM FA_DCTOS_SERV_REC_TD '
       || ' WHERE Cod_cliente = ' || EN_Cod_cliente
       || '      AND (fec_desdedcto BETWEEN ' || ED_Fec_desdedcto || ' AND ' || ED_Fec_hastadcto
       || '      OR fec_hastadcto BETWEEN ' || ED_Fec_desdedcto || ' AND ' || ED_Fec_hastadcto
       || '          OR ' || ED_Fec_desdedcto || ' BETWEEN fec_desdedcto AND fec_hastadcto '
       || '          OR ' || ED_Fec_hastadcto || ' BETWEEN fec_desdedcto AND fec_hastadcto);';

       SELECT COUNT(1)
       INTO SN_Num_registros
       FROM FA_DCTOS_SERV_REC_TD
       WHERE Cod_cliente = EN_Cod_cliente
             AND (fec_desdedcto BETWEEN ED_Fec_desdedcto AND ED_Fec_hastadcto
             OR fec_hastadcto BETWEEN ED_Fec_desdedcto AND ED_Fec_hastadcto
             OR ED_Fec_desdedcto BETWEEN fec_desdedcto AND fec_hastadcto
             OR ED_Fec_hastadcto BETWEEN fec_desdedcto AND fec_hastadcto);


EXCEPTION
    WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_VALIDA_RANGO_FECHA_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_VALIDA_RANGO_FECHA_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_VALIDA_RANGO_FECHA_SB_PR;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE FA_VALIDA_RANGO_FECHA_M_SB_PR (
                                  EN_Cod_cliente     IN GA_INTARCEL.COD_CLIENTE%TYPE,
                                  ER_Row_Id          IN RowId,
                                  ED_Fec_desdedcto   IN DATE,
                                  ED_Fec_hastadcto   IN DATE,
                                  SN_Num_Registros   OUT NOCOPY NUMBER,
                                  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                  ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_VALIDA_RANGO_FECHA_SB_PR"
      Fecha modificacion=" "
      Fecha creacion="23-02-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Función encargada validar los rangos de descuento de un cliente empresa en el sistema</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="numerico">Codigo del cliente</param>
            <param nom="ED_Fec_vigencia"     Tipo="FECHA">Fecha de vigencia</param>
            <param nom="ED_Fec_desdedcto"     Tipo="FECHA">Fecha de inicio de vigencia</param>
            <param nom="ED_Fec_hastadcto"     Tipo="FECHA">Fecha de termino de vigencia</param>
         </Entrada>
         <Salida>
            <param nom="SN_Num_Registros"     Tipo="NUMERICO">Numero de registros encontrados</param>
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

    SN_Cod_retorno  := 0;
    SV_Mens_retorno := NULL;
    SN_Num_evento   := 0;



    LV_sSql := ' SELECT COUNT(1) '
       || ' INTO SN_Num_registros '
       || ' FROM FA_DCTOS_SERV_REC_TD '
       || ' WHERE Cod_cliente = ' || EN_Cod_cliente
       || '      AND (fec_desdedcto BETWEEN ' || ED_Fec_desdedcto || ' AND ' || ED_Fec_hastadcto
       || '      OR fec_hastadcto BETWEEN ' || ED_Fec_desdedcto || ' AND ' || ED_Fec_hastadcto
       || '          OR ' || ED_Fec_desdedcto || ' BETWEEN fec_desdedcto AND fec_hastadcto '
       || '          OR ' || ED_Fec_hastadcto || ' BETWEEN fec_desdedcto AND fec_hastadcto);';

       SELECT COUNT(1)
       INTO SN_Num_registros
       FROM FA_DCTOS_SERV_REC_TD
       WHERE Cod_cliente = EN_Cod_cliente
             AND (fec_desdedcto BETWEEN ED_Fec_desdedcto AND ED_Fec_hastadcto
             OR fec_hastadcto BETWEEN ED_Fec_desdedcto AND ED_Fec_hastadcto
             OR ED_Fec_desdedcto BETWEEN fec_desdedcto AND fec_hastadcto
             OR ED_Fec_hastadcto BETWEEN fec_desdedcto AND fec_hastadcto)
             AND ROWID <> ER_Row_Id;

EXCEPTION
    WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'FA_VALIDA_RANGO_FECHA_SB_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_DCTO_CLTE_SB_PG.FA_VALIDA_RANGO_FECHA_SB_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END FA_VALIDA_RANGO_FECHA_M_SB_PR;



END FA_DCTO_CLTE_SB_PG;
/
SHOW ERRORS
