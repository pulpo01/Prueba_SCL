CREATE OR REPLACE PACKAGE BODY Ga_Consumo_Pg

AS

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_tol_detfactura_fn (
   EN_num_abonado       IN         GA_ABOCEL.NUM_ABONADO%TYPE,
   EV_record_type       IN         tol_detfactura_00.record_type%TYPE,
   EN_clie              IN         NUMBER,
   EV_cod_sent          IN         VARCHAR2,
   SN_can_reg           OUT NOCOPY NUMBER,
   SN_val_reg           OUT NOCOPY NUMBER,
   SN_tiempo_extra_reg  OUT NOCOPY NUMBER,  -- 34629 -rast- 28/09/2006 Tiempo Extra
   SN_tiempo_total_reg  OUT NOCOPY NUMBER,
   SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_TOL_DETFACTURA_FN"
      Fecha modificacion=" "
      Fecha creacion="16-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Agrupa Registros de Facturas Retornando </Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EV_record_type" Tipo="NUMERICO">Tipo de Registro </param>
            <param nom="EN_clie"        Tipo="NUMERICO">Ultimo numero del codigo de clietne</param>
            <param nom="EV_cod_sent"    Tipo="NUMERICO">Codigo de Sentido</param>
         </Entrada>
         <Salida>
            <param nom="SN_can_reg"          Tipo="NUMERICO">Cantidad de Registros</param>
            <param nom="SN_val_reg"          Tipo="NUMERICO">Valor total de los registros</param>
            <param nom="SN_tiempo_total_reg" Tipo="NUMERICO">Tiempo descto (plan) de los registros</param>
            <param nom="SN_tiempo_extra_reg" Tipo="NUMERICO">Tiempo extra (a facturar) de los registros</param>
            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
<Código de Incidencia>
   <Datos Incidencia="MCO-200608180004" Descripción="Solicitud de retorno de Tiempo Extra y Plan por separado"></Datos>
   <Fecha Cambio="29/09/2006"></Fecha>
   <Programador Nombre="Robinson A. Soto Toloza"></Programador>
</Código de Incidencia>
*/
RETURN BOOLEAN
AS
   LV_des_error     ge_errores_pg.DesEvent;
   LV_sSql          ge_errores_pg.vQuery;
   error_parametros EXCEPTION;
BEGIN
   SV_mens_retorno     := '';
   SN_cod_retorno      := 0;
   SN_num_evento       := 0;
   SN_can_reg          := 0;
   SN_val_reg          := 0;
   SN_tiempo_total_reg := 0;
   SN_tiempo_extra_reg := 0; -- 34629 -rast- 28/09/2006 Tiempo Extra

   IF EN_clie >= 0 AND EN_clie < 10 THEN
      -- RA-200603090892 PBR 09/03/2006
      --LV_sSql := 'SELECT COUNT(1) AS cantidad, SUM(tfac.mto_fact) AS total, sum(tfac.dur_fact/60) timpo_total FROM tol_detfactura_00 tfac, ga_abocel abo, fa_ciclfact facf'
      --LV_sSql := 'SELECT COUNT(1) AS cantidad, ROUND(SUM(tfac.mto_fact)) AS total, ROUND(sum(tfac.dur_fact/60)) timpo_total FROM tol_detfactura_00 tfac, ga_abocel abo, fa_ciclfact facf'
      LV_sSql := 'SELECT COUNT(1) AS cantidad, ROUND(SUM(tfac.mto_fact)) AS total, ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra, ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto FROM tol_detfactura_00 tfac, ga_abocel abo, fa_ciclfact facf'
         || ' WHERE tfac.num_clie = abo.cod_cliente AND tfac.num_abon = abo.num_abonado AND facf.cod_ciclfact = tfac.cod_ciclfact'
         || ' AND facf.cod_ciclo = abo.cod_ciclo AND abo.num_celular = '||EN_num_abonado||' AND facf.fec_desdellam <= '||SYSDATE
         || ' AND facf.fec_hastallam >= '||SYSDATE||' AND tfac.record_type = '||EV_record_type||' AND tfac.cod_sent = '||EV_cod_sent;
   ELSE
      RAISE error_parametros;
   END IF;

   CASE EN_clie
         -- INCIDENCIA  : MCO-200608180004
         -- FECHA CAMBIO: 23/08/2006
         -- PROGRAMADOR : Eduardo Tapia
         -- DESCRIPCION : SE SOLICITA AGREGAR DURACION DESCONTADA A CONSULTA DE CONSUMO
         -- FECHA CAMBIO: 28/09/2006
         -- PROGRAMADOR : Robinson Soto
         -- DESCRIPCION : Se solicita devolver tiempo extra (a facturar) por separado del tiempo de descuento (plan)
      WHEN 0 THEN
        -- RA-200603090892 PBR 09/03/2006
        -- SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
        -- Se separa el tiempo total entre el extra y el descontado por plan -rast- 28/09/2006
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_00 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 1 THEN
        -- RA-200603090892 PBR 09/03/2006
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_01 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 2 THEN
       -- RA-200603090892 PBR 09/03/2006
        -- SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_02 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 3 THEN
        -- RA-200603090892 PBR 09/03/2006
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_03 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 4 THEN
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_04 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 5 THEN
        -- RA-200603090892 PBR 09/03/2006
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_05 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 6 THEN
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_06 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 7 THEN
        -- RA-200603090892 PBR 09/03/2006
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_07 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 8 THEN
        -- RA-200603090892 PBR 09/03/2006
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_08 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
      WHEN 9 THEN
        -- RA-200603090892 PBR 09/03/2006
        --SELECT COUNT(1) AS cantidad, NVL(SUM(tfac.mto_fact),0) total, NVL(SUM(tfac.dur_fact/60),0) timpo_total
         SELECT
            COUNT(1) AS cantidad,
            ROUND(NVL(SUM(tfac.mto_fact),0)) total,
            ROUND(NVL(SUM(tfac.dur_fact/60),0)) tiempo_extra,
            ROUND(NVL(SUM(tfac.dur_dcto/60),0)) tiempo_decto
         INTO
            SN_can_reg,
            SN_val_reg,
            SN_tiempo_extra_reg,
            SN_tiempo_total_reg
         FROM
            tol_detfactura_09 tfac,
            GA_ABOCEL abo,
            FA_CICLFACT facf
         WHERE
            tfac.num_clie = abo.cod_cliente
            AND tfac.num_abon = abo.NUM_ABONADO
            AND facf.cod_ciclfact = tfac.cod_ciclfact
            AND facf.cod_ciclo = abo.cod_ciclo
            AND abo.NUM_ABONADO = EN_num_abonado
            AND facf.fec_desdellam <= SYSDATE
            AND facf.fec_hastallam >= SYSDATE
            AND tfac.record_type = EV_record_type
            AND tfac.cod_sent = EV_cod_sent;
   END CASE;

   RETURN TRUE;

EXCEPTION
   WHEN error_parametros THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_tol_detfactura_fn('||EN_num_abonado||', '||EV_record_type||', '||EN_clie||', '||EV_cod_sent||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_tol_detfactura_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 324;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_tol_detfactura_fn('||EN_num_abonado||', '||EV_record_type||', '||EN_clie||', '||EV_cod_sent||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_tol_detfactura_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_tol_detfactura_fn('||EN_num_abonado||', '||EV_record_type||', '||EN_clie||', '||EV_cod_sent||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_tol_detfactura_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_tol_detfactura_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_minutos_promocion_fn (
   EN_num_abonado        IN         GA_ABOCEL.NUM_ABONADO%TYPE,
   EN_clie               IN         NUMBER,
   SN_minutos_prom       OUT NOCOPY NUMBER,
   SN_cod_retorno        OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno       OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento         OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_MINUTOS_PROMOCION_FN"
      Fecha modificacion=" "
      Fecha creacion="16-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recupera Minutos consumidos por promocion</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="EN_clie"        Tipo="NUMERICO">Ultimo numero del codigo de clietne</param>
         </Entrada>
         <Salida>
            <param nom="SN_minutos_prom"      Tipo="NUMERICO">Cantidad de Minutos promocion</param>>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS

   LV_des_error       ge_errores_pg.DesEvent;
   LV_sSql            ge_errores_pg.vQuery;
   error_parametros   EXCEPTION;
BEGIN
   SV_mens_retorno:= '';
   SN_cod_retorno := 0;
   SN_num_evento  := 0;

   IF EN_clie >= 0 AND EN_clie < 10 THEN
      LV_sSql := 'SELECT sum(dur_real/60) timpo_total INTO SN_minutos_prom FROM tol_detfactura_NN tfac, ga_abocel abo, fa_ciclfact facf'
           || ' WHERE tfac.num_clie = abo.cod_cliente AND tfac.num_abon = abo.num_abonado AND facf.cod_ciclfact = tfac.cod_ciclfact'
           || ' AND facf.cod_ciclo = abo.cod_ciclo AND abo.num_abonado = '||EN_num_abonado||' AND facf.fec_desdellam <= '||SYSDATE
           || ' AND facf.fec_hastallam >= '||SYSDATE||' AND tfac.tip_dcto IS NOT NULL';
   ELSE
      RAISE error_parametros;
   END IF;

   CASE EN_clie

      WHEN 0 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_00 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 1 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_01 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 2 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_02 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 3 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_03 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 4 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_04 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 5 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_05 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 6 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_06 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 7 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_07 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 8 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_08 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
      WHEN 9 THEN
        SELECT SUM(dur_real/60) timpo_total
          INTO SN_minutos_prom
          FROM tol_detfactura_09 tfac, GA_ABOCEL abo, FA_CICLFACT facf
         WHERE tfac.num_clie = abo.cod_cliente
           AND tfac.num_abon = abo.NUM_ABONADO
           AND facf.cod_ciclfact = tfac.cod_ciclfact
           AND facf.cod_ciclo = abo.cod_ciclo
           AND abo.NUM_ABONADO = EN_num_abonado
           AND facf.fec_desdellam <= SYSDATE
           AND facf.fec_hastallam >= SYSDATE
           AND tfac.tip_dcto IS NOT NULL;
   END CASE;
   SN_minutos_prom:= ROUND(SN_minutos_prom); -- RA-200603090892 PBR 09/03/2006
   RETURN TRUE;

EXCEPTION
   WHEN error_parametros THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_minutos_promocion_fn('||EN_num_abonado||', '||EN_clie||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_minutos_promocion_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 324;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_minutos_promocion_fn('||EN_num_abonado||', '||EN_clie||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_minutos_promocion_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_minutos_promocion_fn('||EN_num_abonado||', '||EN_clie||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_minutos_promocion_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_minutos_promocion_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ga_minutos_bolsa_abonado_fn (
   EN_num_abonado        IN  GA_ABOCEL.NUM_ABONADO%TYPE,
   /* Inicio modificacion by SAQL/Soporte 16/05/2006 - CO-200605050102 */
   -- SN_minutos_paln       OUT NOCOPY tol_acumbolsa_gral.val_inicial%TYPE,
   -- SN_minutos_consumidos OUT NOCOPY tol_acumbolsa_gral.val_consumido%TYPE,
   -- SN_minutos_disponible OUT NOCOPY tol_acumbolsa_gral.val_disponible%TYPE,
   SN_minutos_paln       OUT NOCOPY NUMBER,
   SN_minutos_consumidos OUT NOCOPY NUMBER,
   SN_minutos_disponible OUT NOCOPY NUMBER,
   SN_ind_unidad         OUT NOCOPY NUMBER, -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   /* Fin modificacion by SAQL/Soporte 16/05/2006 - CO-200605050102 */
   SN_cod_retorno        OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno       OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento         OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_TOLMENSAJES_00_FN"
      Fecha modificacion=" "
      Fecha creacion="16-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recupera el total de mensajes enviados y recividos</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_minutos_paln"       Tipo="NUMERICO">Minutos libres plan</param>
            <param nom="SN_minutos_consumidos" Tipo="NUMERICO">Minutos consumidos</param>
            <param nom="SN_minutos_disponible" Tipo="NUMERICO">minutos disponibles</param>
            <param nom="SN_ind_unidad"         Tipo="SMALLINT">Tipo de unidad</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
<Código de Incidencia>
   <Datos Incidencia="34629" Descripción="Consulta por bolsa individual y empresarial"></Datos>
   <Fecha Cambio="05/10/2006"></Fecha>
   <Programador Nombre="Robinson A. Soto Toloza"></Programador>
</Código de Incidencia>
<Código de Incidencia>
   <Datos Incidencia="35869" Descripción="Se agrega indicador de unidad en trama de consulta tasación"></Datos>
   <Fecha Cambio="05/12/2006"></Fecha>
   <Programador Nombre="Robinson A. Soto Toloza"></Programador>
</Código de Incidencia>
*/
RETURN BOOLEAN
AS
   LV_des_error          ge_errores_pg.DesEvent;
   LV_sSql               ge_errores_pg.vQuery;
   --Inicio 34629
   LN_NUMABONADO         GA_ABOCEL.NUM_ABONADO%TYPE;
   LN_CODCLIENTE         GA_ABOCEL.COD_CLIENTE%TYPE;
   LN_CODCICLO           GA_ABOCEL.COD_CICLO%TYPE;
   LV_CODPLAN            GA_ABOCEL.COD_PLANTARIF%TYPE;
   LV_CODSITUACION       VARCHAR2(3):='AAA';
   LV_MODULO             VARCHAR2(2):='GA';
   LV_TABLA              VARCHAR2(10):='TOL_BOLSAS';
   LV_COLUMNA            VARCHAR2(9):='COD_BOLSA';
   --Fin 34629

   error_bolsa    EXCEPTION;
   error_abocel   EXCEPTION;
BEGIN

    SV_mens_retorno:= '';
    SN_cod_retorno := 0;
    SN_num_evento  := 0;

   --Inicio 34629
   BEGIN

      LV_sSql := '';
      LV_sSql := 'SELECT';
      LV_sSql := LV_sSql || ' COD_CLIENTE, COD_CICLO, COD_PLANTARIF';
      LV_sSql := LV_sSql || ' DECODE(TIP_PLANTARIF, ''I'', EN_num_abonado, ''E'', 0)';
      LV_sSql := LV_sSql || ' INTO LN_CODCLIENTE, LN_CODCICLO, LV_CODPLAN, LN_NUMABONADO';
      LV_sSql := LV_sSql || ' FROM GA_ABOCEL';
      LV_sSql := LV_sSql || ' WHERE NUM_ABONADO = ' || EN_num_abonado;
      LV_sSql := LV_sSql || ' AND COD_SITUACION = ' || LV_CODSITUACION;

      SELECT
         COD_CLIENTE,
         COD_CICLO,
         COD_PLANTARIF,
         DECODE(TIP_PLANTARIF, 'I', EN_num_abonado, 'E', 0)
      INTO
         LN_CODCLIENTE,
         LN_CODCICLO,
         LV_CODPLAN,
         LN_NUMABONADO
      FROM
         GA_ABOCEL
      WHERE
         NUM_ABONADO = EN_num_abonado
         AND COD_SITUACION = LV_CODSITUACION;

      IF  (LN_CODCLIENTE IS NULL)
      AND (LN_CODCICLO IS NULL)
      AND (LN_NUMABONADO IS NULL) THEN
         RAISE error_abocel;
      END IF;

   END;

   -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   -- Se rescada indicador de unidad de bolsa del cliente
   LV_sSql := '';
   LV_sSql := 'SELECT';
   LV_sSql := LV_sSql || ' acmgra.val_inicial, acmgra.val_consumido, acmgra.val_disponible, DECODE(acmgra.ind_unidad,''''M'''',0,''''V'''',1) AS ind_unidad';
   LV_sSql := LV_sSql || ' INTO SN_minutos_paln, SN_minutos_consumidos, SN_minutos_disponible';
   LV_sSql := LV_sSql || ' FROM tol_acumbolsa_gral acmgra, FA_CICLFACT facf';
   LV_sSql := LV_sSql || ' WHERE acmgra.cod_cliente = ' || LN_CODCLIENTE;
   LV_sSql := LV_sSql || ' AND acmgra.cod_abonado = ' || LN_NUMABONADO;
   LV_sSql := LV_sSql || ' AND facf.cod_ciclo = ' || LN_CODCICLO;
   LV_sSql := LV_sSql || ' AND acmgra.fec_tasa = facf.cod_ciclfact';
   LV_sSql := LV_sSql || ' AND acmgra.cod_plan = ''' || LV_CODPLAN || '''';
   LV_sSql := LV_sSql || ' AND ACMGRA.COD_BOLSA NOT IN ( SELECT COD_VALOR';
   LV_sSql := LV_sSql || ' FROM GED_CODIGOS';
   LV_sSql := LV_sSql || ' WHERE COD_MODULO = '''|| LV_MODULO ||'''';
   LV_sSql := LV_sSql || ' AND NOM_TABLA =  '''|| LV_TABLA ||'''';
   LV_sSql := LV_sSql || ' AND NOM_COLUMNA =  '''|| LV_COLUMNA ||'''';
   LV_sSql := LV_sSql || ' )';
   LV_sSql := LV_sSql || ' AND facf.fec_desdellam <= SYSDATE AND facf.fec_hastallam >= SYSDATE';

   -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   -- Se rescada indicador de unidad de bolsa del cliente
   SELECT
      acmgra.val_inicial,
      acmgra.val_consumido,
      acmgra.val_disponible,
      DECODE(acmgra.ind_unidad,'M',0,'V',1) AS ind_unidad
   INTO
      SN_minutos_paln,
      SN_minutos_consumidos,
      SN_minutos_disponible,
      SN_ind_unidad
   FROM
      tol_acumbolsa_gral acmgra,
      FA_CICLFACT facf
   WHERE
      acmgra.cod_cliente = LN_CODCLIENTE
      AND acmgra.cod_abonado = LN_NUMABONADO
      AND facf.cod_ciclo = LN_CODCICLO
      AND acmgra.fec_tasa = facf.cod_ciclfact
      AND acmgra.cod_plan = LV_CODPLAN
      AND ACMGRA.COD_BOLSA NOT IN (
                                   SELECT
                                      COD_VALOR
                                   FROM
                                      GED_CODIGOS
                                   WHERE
                                      COD_MODULO = LV_MODULO
                                      AND NOM_TABLA = LV_TABLA
                                      AND NOM_COLUMNA = LV_COLUMNA
                                   )
      AND facf.fec_desdellam <= SYSDATE
      AND facf.fec_hastallam >= SYSDATE;
   --Fin 34629

   /* 35869 -rast- Se cambia por mantención adaptativa que solicita devolver el tipo de unidad
      LV_sSql := 'SELECT';
      LV_sSql := LV_sSql || ' SUM(acmgra.val_inicial), SUM(acmgra.val_consumido), SUM(acmgra.val_disponible)';

      SELECT
         SUM(acmgra.val_inicial),
         SUM(acmgra.val_consumido),
         SUM(acmgra.val_disponible),
   */

   /*
       LV_sSql := 'SELECT SUM(acmgra.val_inicial),SUM(acmgra.val_consumido),SUM(acmgra.val_disponible)';
       LV_sSql := LV_sSql || ' INTO SN_minutos_paln, SN_minutos_consumidos, SN_minutos_disponible';
       LV_sSql := LV_sSql || ' FROM tol_acumbolsa_gral acmgra, ga_abocel abo, fa_ciclfact facf';
       LV_sSql := LV_sSql || ' WHERE acmgra.cod_cliente = abo.cod_cliente';
       LV_sSql := LV_sSql || ' AND acmgra.cod_abonado = abo.num_abonado';
       LV_sSql := LV_sSql || ' AND facf.cod_ciclo = abo.cod_ciclo';
       LV_sSql := LV_sSql || ' AND acmgra.fec_tasa = facf.cod_ciclfact';
       LV_sSql := LV_sSql || ' AND abo.num_abonado = '||EN_num_abonado;
       LV_sSql := LV_sSql || ' AND facf.fec_desdellam <= SYSDATE';
       LV_sSql := LV_sSql || ' AND facf.fec_hastallam >= SYSDATE;';
   */
   /*
      SELECT SUM(acmgra.val_inicial),SUM(acmgra.val_consumido),SUM(acmgra.val_disponible)
      INTO SN_minutos_paln, SN_minutos_consumidos, SN_minutos_disponible
      FROM tol_acumbolsa_gral acmgra, GA_ABOCEL abo, FA_CICLFACT facf
      WHERE acmgra.cod_cliente = abo.cod_cliente
      AND acmgra.cod_abonado = abo.NUM_ABONADO
      AND facf.cod_ciclo = abo.cod_ciclo
      AND acmgra.fec_tasa = facf.cod_ciclfact
      AND abo.NUM_ABONADO = EN_num_abonado
       */
      /* Inicio modificacion by SAQL/Soporte 25/05/2006 - CO-200605230154 */
      /*
      AND ACMGRA.COD_BOLSA NOT IN (
      SELECT COD_VALOR
      FROM GED_CODIGOS
      WHERE COD_MODULO = 'GA'
      AND NOM_TABLA = 'TOL_BOLSAS'
      AND NOM_COLUMNA = 'COD_BOLSA'
      )
   */
   /* Fin modificacion by SAQL/Soporte 25/05/2006 - CO-200605230154 */
   /*
      AND facf.fec_desdellam <= SYSDATE
      AND facf.fec_hastallam >= SYSDATE;
   */

   IF  (SN_minutos_paln       IS NULL)
   AND (SN_minutos_consumidos IS NULL)
   AND (SN_minutos_disponible IS NULL) THEN
      RAISE error_bolsa;
   END IF;

   RETURN TRUE;

EXCEPTION
   WHEN error_abocel THEN
      SN_cod_retorno := 324;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_minutos_bolsa_abonado_fn('||EN_num_abonado||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_minutos_bolsa_abonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN error_bolsa THEN
      SN_cod_retorno := 324;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_minutos_bolsa_abonado_fn('||EN_num_abonado||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_minutos_bolsa_abonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_minutos_bolsa_abonado_fn('||EN_num_abonado||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_minutos_bolsa_abonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_minutos_bolsa_abonado_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_impuesto_plan_tarifario_fn (
   EN_num_abonado   IN       GA_ABOCEL.num_celular%TYPE,
   SN_imp_cargo     OUT      NOCOPY NUMBER,
   SN_cod_retorno   OUT      NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT      NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT      NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_IMPUESTO_PLAN_TARIFARIO_FN"
      Lenguaje="PL/SQL"
      Fecha="26-12-2004"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera el impuesto del un Cargo Basico</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="SN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_imp_cargo"       Tipo="CARACTER">Valor del Impuesto Expresado en Porcentaje</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

    AS
        CURSOR PlanCargo_CU IS
          SELECT catclie.cod_catimpos, cargba.imp_cargobasico, 25 cod_concepto, 1 cod_columna--, cod_cargobasico
            FROM GA_ABOCEL abo, GE_CLIENTES clie, GE_CATIMPCLIENTES catclie, TA_CARGOSBASICO cargba
           WHERE catclie.cod_cliente = clie.cod_cliente
             AND abo.cod_cliente = clie.cod_cliente
             AND cargba.cod_producto = abo.cod_producto
             AND abo.cod_cargobasico = cargba.cod_cargobasico
             AND abo.NUM_ABONADO = EN_num_abonado;


       error_ejecucion EXCEPTION;
       LV_des_error       ge_errores_pg.DesEvent;
       LV_sSql            ge_errores_pg.vQuery;
       LN_cod_zonaimpo    GE_ZONACIUDAD.cod_zonaimpo%TYPE;
       LN_cod_catimpos    GE_CATIMPCLIENTES.cod_catimpos%TYPE;

BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';

    IF NOT Ga_Segmentacion_Pg.ga_recupera_parametros_fn ('COD_ZONAIMPO', 'FA', 1, LN_cod_zonaimpo, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE error_ejecucion;
    END IF;

    LV_sSql := 'SELECT catclie.cod_catimpos INTO N_cod_catimpos FROM ga_abocel abo, ge_clientes clie, ge_catimpclientes catclie'
          || 'WHERE catclie.cod_cliente = clie.cod_cliente AND abo.cod_cliente = clie.cod_cliente AND abo.num_celular = '||EN_num_abonado;

    SELECT catclie.cod_catimpos
      INTO LN_cod_catimpos
      FROM GA_ABOCEL abo, GE_CLIENTES clie, GE_CATIMPCLIENTES catclie
     WHERE catclie.cod_cliente = clie.cod_cliente
       AND abo.cod_cliente = clie.cod_cliente
       AND abo.NUM_ABONADO = EN_num_abonado;


    LV_sSql := 'SELECT SUM(prc_impuesto) INTO SN_imp_cargo FROM GE_IMPUESTOS WHERE COD_ZONAIMPO = '||LN_cod_zonaimpo||' AND COD_CATIMPOS = '||LN_cod_catimpos
         || 'AND COD_GRPSERVI = (SELECT COD_GRPSERVI FROM FA_GRPSERCONC WHERE COD_CONCEPTO IN (SELECT COD_ABONOCEL FROM  FA_DATOSGENER )) AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA';

    SELECT SUM(prc_impuesto)
      INTO SN_imp_cargo
      FROM GE_IMPUESTOS
     WHERE cod_zonaimpo = LN_cod_zonaimpo
       AND cod_catimpos = LN_cod_catimpos
     /* Inicio modificacion by SAQL/Soporte 30/03/2006 - RA-200603140913 */
       AND COD_ZONAABON IN (
          SELECT A.COD_ZONAIMPO
          FROM GE_ZONACIUDAD A, GE_DIRECCIONES B, GA_DIRECUSUAR C, GA_ABOCEL D
          WHERE D.NUM_ABONADO = EN_num_abonado
          AND C.COD_USUARIO = D.COD_USUARIO
          AND C.COD_TIPDIRECCION = '2'
          AND C.COD_DIRECCION = B.COD_DIRECCION
          AND A.COD_REGION = B.COD_REGION
          AND A.COD_PROVINCIA = B.COD_PROVINCIA
          AND A.COD_CIUDAD = B.COD_CIUDAD
          AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA
          )
     /* Fin modificacion by SAQL/Soporte 30/03/2006 - RA-200603140913 */
       AND cod_grpservi IN (SELECT cod_grpservi
                             FROM FA_GRPSERCONC
                            WHERE cod_concepto = (SELECT cod_abonocel FROM FA_DATOSGENER ))
      AND SYSDATE BETWEEN fec_desde AND fec_hasta;

    RETURN TRUE;

EXCEPTION
    WHEN error_ejecucion THEN
       LV_des_error := 'ga_impuesto_plan_tarifario_fn('||EN_num_abonado||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_impuesto_plan_tarifario_fn', LV_sSql, SN_cod_retorno, LV_des_error );
       RETURN FALSE;

    WHEN NO_DATA_FOUND THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
       END IF;
       LV_des_error := 'ga_impuesto_plan_tarifario_fn('||EN_num_abonado||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_impuesto_plan_tarifario_fn', LV_sSql, SN_cod_retorno, LV_des_error );
       RETURN FALSE;

    WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
       END IF;
       LV_des_error := 'ga_impuesto_plan_tarifario_fn('||EN_num_abonado||'); - ' || SQLERRM;
       SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_impuesto_plan_tarifario_fn', LV_sSql, SN_cod_retorno, LV_des_error );
       RETURN FALSE;

END ga_impuesto_plan_tarifario_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_consumo_fn (
   EN_ind_ordentotal   IN   FA_HISTDOCU.ind_ordentotal%TYPE,
   EN_cod_ciclfact    IN FA_HISTDOCU.cod_ciclfact%TYPE
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_CONSUMO_FN"
      Lenguaje="PL/SQL"
      Fecha="16-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Recupera los minutos consumidos en una factura</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_ind_ordentotal" Tipo="NUMERICO">Indicador de Orden Total</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Ciclo de Facturacion</param>
         </Entrada>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN NUMBER
IS
    LV_sSql           ge_errores_pg.vQuery;
 LV_qry            VARCHAR2(1000);
    LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno   ge_errores_td.det_msgerror%TYPE;
    LN_num_evento     ge_errores_pg.Evento;
    LV_fa_histconc    FA_ENLACEHIST.fa_histconc%TYPE;
 LN_consumo    NUMBER;

 error_ejecucion  EXCEPTION;
BEGIN

 -- Se recupera la tabla de conceptos dependiendo del ciclo de facturacion
 IF NOT Ga_Facturas_Pg.ga_recupera_tablaenlace_fn(EN_cod_ciclfact,LV_fa_histconc,LN_cod_retorno,LV_mens_retorno,LN_num_evento) THEN
     RAISE error_ejecucion;
 END IF;

 -- Se obtiene el consumo del documento
    LV_sSql := 'SELECT ROUND(SUM(a.seg_consumido)/60) consumo';
    LV_sSql := LV_sSql || ' FROM '||LV_fa_histconc||' a';
    LV_sSql := LV_sSql || ' WHERE a.ind_ordentotal = '||EN_ind_ordentotal;

 LV_qry := 'SELECT ROUND(SUM(a.seg_consumido)/60) consumo';
    LV_qry := LV_qry || ' FROM '||LV_fa_histconc||' a';
    LV_qry := LV_qry || ' WHERE a.ind_ordentotal = :indorden';

 EXECUTE IMMEDIATE LV_qry
 INTO LN_consumo
 USING EN_ind_ordentotal;

 RETURN LN_consumo;

EXCEPTION

    WHEN error_ejecucion THEN
        LN_consumo := 0;
     RETURN LN_consumo;

    WHEN OTHERS THEN
        LN_consumo := 0;
        RETURN LN_consumo;

END ga_recupera_consumo_fn;

-------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_cobro_consulta_tasacion_pr(
    EN_num_celular    IN  NUMBER,
    SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_COBRO_CONSULTA_TASACION_PR"
      Lenguaje="PL/SQL"
      Fecha="08-06-2005"
      Versión="1.0"
      Diseñador=""Oscar Jorquera"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Cobro de consulta de tasación, dependiendo de un número celular y el código tipo de transacción</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"  Tipo="VARCHAR" >Código de Retorno (descripción de error)</param>
            <param nom="sv_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="sn_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
   </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    SN_cod_producto  NUMBER;
    LN_cod_error  NUMBER;
    LV_cod_planserv     GA_PLANTECPLSERV.cod_planserv%TYPE;
    LN_cod_ciclfact  FA_CICLFACT.cod_ciclfact%TYPE;
    LN_imp_tarifa  GA_TARIFAS.imp_tarifa%TYPE;
    LV_des_moneda  GE_MONEDAS.des_moneda%TYPE;
    LN_cod_concepto  GA_ACTUASERV.cod_concepto%TYPE;
    LV_cod_moneda  GE_MONEDAS.cod_moneda%TYPE;
    LN_cod_plancom     GA_CLIENTE_PCOM.cod_plancom%TYPE;
    LN_cod_atencion  NUMBER;

    LN_seq_cargos  NUMBER;
    LV_obs_atencion     VARCHAR2(60);
    LV_cod_oficina   VARCHAR2(10);
    LV_cod_tipserv  VARCHAR2(1);
    LV_cod_tiplan  VARCHAR2(5);
    LV_usuario   VARCHAR2(50):=USER;
    LV_des_error   ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */
    LV_Val_Parametro GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    LV_COD_CONCEPTO FA_CONCEPTOS.COD_CONCEPTO%TYPE;
    /* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */

    situacion_no_permit EXCEPTION;
    cod_tipoplan_no_enc EXCEPTION;
    cod_tipoplan_no_val EXCEPTION;
    plan_serv_no_enc  EXCEPTION;
    ciclo_fact_no_enc  EXCEPTION;
    cod_tipser_no_enc  EXCEPTION;
    tarifa_no_enc   EXCEPTION;
    cod_plancom_no_enc EXCEPTION;
    error_ingreso_cobro EXCEPTION;
    error_reg_atencion EXCEPTION;
    cod_oficina_no_enc EXCEPTION;
    error_ejecucion     EXCEPTION;

BEGIN

   SN_cod_retorno  := 0;
  SV_mens_retorno :='';
  SN_num_evento := 0;
  LN_cod_atencion := 509;

   -- Obtiene datos del abonado
    IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                        GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                       GN_cod_prod, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
  END IF;

  IF (GV_cod_situacion = GV_cod_situacion_AAA OR GV_cod_situacion = GV_cod_situacion_SAA) AND GV_cod_plantarif IS NOT NULL THEN

   -- Verificar si es PostPago Puro
   LV_sSql := 'SELECT cod_tiplan ';
   LV_sSql := LV_sSql ||'INTO LV_cod_tiplan ';
   LV_sSql := LV_sSql ||'FROM ta_plantarif ';
   LV_sSql := LV_sSql ||'WHERE cod_plantarif = SV_cod_plantarif ';

   SELECT cod_tiplan
   INTO LV_cod_tiplan
   FROM TA_PLANTARIF
   WHERE cod_plantarif = GV_cod_plantarif;

         /* Inicio modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
         /* IF LV_cod_tiplan IS NOT NULL AND LV_cod_tiplan = GV_cod_tiplan THEN */
         IF LV_cod_tiplan IS NOT NULL THEN
         /* Fin modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */

     -- Obtener código del plan del servicio:
     LV_sSql := 'SELECT a.cod_planserv INTO LV_cod_planserv FROM ga_plantecplserv a';
     LV_sSql := LV_sSql ||'WHERE a.cod_producto = 1';
     LV_sSql := LV_sSql ||'AND   a.cod_plantarif = '||GV_cod_plantarif;
     LV_sSql := LV_sSql ||'AND   a.cod_tecnologia= '||GV_cod_tecnologia;
     LV_sSql := LV_sSql ||'AND   SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';

     SELECT
         a.cod_planserv
     INTO  LV_cod_planserv
     FROM GA_PLANTECPLSERV a
     WHERE a.cod_producto = 1
     AND   a.cod_plantarif = GV_cod_plantarif
     AND   a.cod_tecnologia = GV_cod_tecnologia
     AND   SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE);

    IF LV_cod_planserv IS NULL OR LV_cod_planserv = '' THEN
       RAISE plan_serv_no_enc;
    ELSE

      --  Obtener ciclo de facturación del cliente:
      LV_sSql := 'SELECT a.cod_ciclfact INTO LN_cod_ciclfact ';
      LV_sSql := LV_sSql ||'FROM fa_ciclfact a';
      LV_sSql := LV_sSql ||'WHERE a.cod_ciclo = '||GN_cod_ciclo ;
      LV_sSql := LV_sSql ||'AND SYSDATE BETWEEN a.fec_desdeocargos AND NVL(a.fec_hastaocargos, SYSDATE)';

      SELECT
        a.cod_ciclfact
      INTO  LN_cod_ciclfact
      FROM FA_CICLFACT a
      WHERE a.cod_ciclo = GN_cod_ciclo
      AND SYSDATE BETWEEN a.FEC_DESDEOCARGOS AND NVL(a.FEC_HASTAOCARGOS, SYSDATE);

      IF LN_cod_ciclfact IS NULL THEN
      RAISE ciclo_fact_no_enc;
      ELSE
      /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */
      SELECT VAL_PARAMETRO INTO LV_Val_Parametro
      FROM GED_PARAMETROS
      WHERE COD_MODULO = 'GA'
      AND NOM_PARAMETRO = 'COBRO_CONS_CONSUMO';
      /* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */

      -- Obtener el Código del tipo de Servicio
      /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */
      /* LV_sSql := 'SELECT COD_TIPSERV INTO LV_cod_tipserv FROM ga_actuaserv '; */
      LV_sSql := 'SELECT COD_TIPSERV, COD_CONCEPTO INTO LV_cod_tipserv, LV_COD_CONCEPTO FROM ga_actuaserv ';
      LV_sSql := LV_sSql ||'WHERE COD_ACTABO = '|| GV_cod_actabo ;
      LV_sSql := LV_sSql ||' AND COD_SERVICIO = '|| LV_Val_Parametro ;
      /* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */

          /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */
           --SELECT a.cod_tipserv
           --INTO LV_cod_tipserv
           SELECT a.cod_tipserv, a.cod_concepto
           INTO LV_cod_tipserv, LV_COD_CONCEPTO
           FROM GA_ACTUASERV a
           WHERE a.cod_actabo = GV_cod_actabo
           --AND a.cod_producto = gn_cod_producto;
           AND a.cod_producto = gn_cod_producto
           AND A.COD_SERVICIO = LV_VAL_PARAMETRO;
           /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603130906 */

      IF LV_cod_tipserv IS NULL THEN
       RAISE cod_tipser_no_enc;
      ELSE

       --Obtener tarifa asociada al cobro de consulta de tasación:
       LV_sSql := 'SELECT b.imp_tarifa,d.des_moneda,a.cod_concepto,b.cod_moneda ';
       LV_sSql := LV_sSql ||' INTO LN_imp_tarifa, LV_des_moneda,LN_cod_concepto,LV_cod_moneda';
       LV_sSql := LV_sSql ||'FROM  ga_actuaserv a, ga_tarifas b, ga_servicios c,ge_monedas d ';
       LV_sSql := LV_sSql ||'WHERE a.cod_producto = 1';
       LV_sSql := LV_sSql ||' AND a.cod_actabo = '||GV_cod_actabo;
       LV_sSql := LV_sSql ||'AND a.cod_tipserv = '||LV_cod_tipserv;  --< ga_tipserv.cod_tipserv=1>
       LV_sSql := LV_sSql ||' AND b.cod_producto = a.cod_producto';
       LV_sSql := LV_sSql ||'AND b.cod_actabo = a.cod_actabo';
       LV_sSql := LV_sSql ||' AND b.cod_tipserv = a.cod_tipserv';
       LV_sSql := LV_sSql ||'AND b.cod_servicio = a.cod_servicio';
       LV_sSql := LV_sSql ||'AND b.cod_planserv = '||LV_cod_planserv;
       LV_sSql := LV_sSql ||'AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)';
       LV_sSql := LV_sSql ||' AND C.cod_producto = A.cod_producto';
       LV_sSql := LV_sSql ||'AND C.cod_servicio = A.cod_servicio';
       LV_sSql := LV_sSql ||'AND D.cod_moneda = B.cod_moneda';
       /* Inicio modificacion by SAQL/Soporte 16/03/2006 - RA-200603140913 */
       LV_sSql := LV_sSql ||'AND a.cod_concepto = '||LV_COD_CONCEPTO;
       /* Fin modificacion by SAQL/Soporte 16/03/2006 - RA-200603140913 */


          SELECT
           b.imp_tarifa,d.des_moneda,a.cod_concepto,b.cod_moneda
           INTO LN_imp_tarifa, LV_des_moneda,LN_cod_concepto,LV_cod_moneda
        FROM  GA_ACTUASERV a, GA_TARIFAS b, GA_SERVICIOS c,GE_MONEDAS d
        WHERE a.cod_producto = 1
        AND a.cod_actabo = GV_cod_actabo
        AND a.cod_tipserv = LV_cod_tipserv
        AND b.cod_producto = a.cod_producto
        AND b.cod_actabo = a.cod_actabo
        AND b.cod_tipserv = a.cod_tipserv
        AND b.cod_servicio = a.cod_servicio
        AND b.cod_planserv = LV_cod_planserv
        AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
        AND C.cod_producto = A.cod_producto
        AND C.cod_servicio = A.cod_servicio
        /* Inicio modificacion by SAQL/Soporte 16/03/2006 - RA-200603140913 */
        /* AND D.cod_moneda = B.cod_moneda; */
        AND D.cod_moneda = B.cod_moneda
        AND A.COD_CONCEPTO = LV_COD_CONCEPTO;
        /* Fin modificacion by SAQL/Soporte 16/03/2006 - RA-200603140913 */

       IF LN_imp_tarifa IS NULL THEN
           RAISE tarifa_no_enc;
       ELSE

        --Buscar código de plan comercial del cliente:
        LV_sSql := 'SELECT a.cod_plancom INTO LN_cod_plancom ';
        LV_sSql := LV_sSql ||'FROM ga_cliente_pcom a ';
        LV_sSql := LV_sSql ||'WHERE a.cod_cliente = '||GN_cod_cliente ;
        LV_sSql := LV_sSql ||'AND '||SYSDATE||' BETWEEN a.fec_desde AND NVL(a.fec_hasta,'||SYSDATE||')';

        SELECT
          a.cod_plancom INTO LN_cod_plancom
        FROM GA_CLIENTE_PCOM a
        WHERE
           a.cod_cliente = GN_cod_cliente
           AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE);

        IF LN_cod_plancom IS NULL THEN
         RAISE cod_plancom_no_enc;
        ELSE

          -- Generar insert en la tabla ge_cargos:
          LV_sSql := 'GA_INGRESO_COBRO_PR(ge_seq_cargos.NEXTVAL,';
          LV_sSql := LV_sSql || GN_cod_cliente||',';
          LV_sSql := LV_sSql || GN_cod_producto||',';
          LV_sSql := LV_sSql || GN_num_abonado||',';
          LV_sSql := LV_sSql || EN_num_celular||',';
          LV_sSql := LV_sSql || LN_cod_plancom||',';
          LV_sSql := LV_sSql || LN_cod_ciclfact||',';
          LV_sSql := LV_sSql || LN_cod_concepto||',';
          LV_sSql := LV_sSql || LN_imp_tarifa||',';
          LV_sSql := LV_sSql || LV_cod_moneda||',';
          LV_sSql := LV_sSql || GV_num_serie||',';
          LV_sSql := LV_sSql || SN_cod_retorno||',';
          LV_sSql := LV_sSql || SV_mens_retorno||',';
             LV_sSql := LV_sSql || SN_num_evento||')';

          SN_cod_retorno    := 0;
          SV_mens_retorno :='';
          SN_num_evento   := 0;

          GA_INGRESO_COBRO_PR(GN_cod_cliente,
               GN_cod_producto,
               GN_num_abonado,
               EN_num_celular,
               LN_cod_plancom,
               LN_cod_ciclfact,
               LN_cod_concepto,
               LN_imp_tarifa,
               LV_cod_moneda,
               GV_num_serie,
               SN_cod_retorno,
               SV_mens_retorno,
               SN_num_evento);

          IF SN_cod_retorno <> 0 THEN
              RAISE error_ingreso_cobro;
          ELSE
           -- Una vez realizado el cobro por consulta de tasación se debe registrar la atención
           LV_obs_atencion := 'Se atendió al Celular ' || EN_num_celular;
          END IF;
        END IF;
       END IF;
      END IF;
     END IF;
    END IF;
   ELSE
    IF LV_cod_tiplan IS NULL THEN
       RAISE cod_tipoplan_no_enc;
    ELSE
       RAISE cod_tipoplan_no_val;
    END IF;
   END IF;
  ELSE
   RAISE situacion_no_permit;
  END IF;

   COMMIT;

EXCEPTION
   WHEN error_ejecucion THEN
      LV_des_error :=SUBSTR('error_ejecucion: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
   SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
   SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN situacion_no_permit THEN
      LN_cod_error := 321;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('situacion_no_permit: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN cod_tipoplan_no_enc THEN
      LN_cod_error := 282;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('cod_tipoplan_no_enc: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN cod_tipoplan_no_val THEN
      LN_cod_error := 292;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('cod_tipoplan_no_val: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN plan_serv_no_enc THEN
      LN_cod_error := 283;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('plan_serv_no_enc: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN ciclo_fact_no_enc THEN
      LN_cod_error := 200;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('ciclo_fact_no_enc: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN cod_tipser_no_enc THEN
      LN_cod_error := 403;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('cod_tipser_no_enc: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN tarifa_no_enc THEN
      LN_cod_error := 404;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('tarifa_no_enc: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN cod_plancom_no_enc THEN
      LN_cod_error := 322;
      SN_cod_retorno := LN_cod_error;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_error,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('cod_plancom_no_enc: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN cod_oficina_no_enc THEN
      SN_cod_retorno := 280;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('cod_oficina_no_enc: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN error_ingreso_cobro THEN
      LV_des_error :=SUBSTR('error_ingreso_cobro: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN error_reg_atencion THEN
      LV_des_error :=SUBSTR('error_reg_atencion: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := gv_error_no_clasif;
      END IF;
      LV_des_error :=SUBSTR('others: GA_COBRO_CONSULTA_TASACION_PR('||EN_num_celular||'); - ' || SQLERRM,1,GN_largoerrtec);
      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, gv_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_cobro_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_cobro_consulta_tasacion_pr;

-------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_ingreso_cobro_pr(
    EN_cod_cliente     IN GE_CARGOS.cod_cliente%TYPE,
    EN_cod_producto    IN GE_CARGOS.cod_producto%TYPE,
    EN_num_abonado     IN GE_CARGOS.NUM_ABONADO%TYPE,
    EN_num_celular     IN GE_CARGOS.num_terminal%TYPE,
    EN_cod_plancom     IN GE_CARGOS.cod_plancom%TYPE,
    EN_cod_ciclfact    IN GE_CARGOS.cod_ciclfact%TYPE,
    EN_cod_concepto    IN GE_CARGOS.cod_concepto%TYPE,
    EN_imp_tarifa     IN GE_CARGOS.imp_cargo%TYPE,
    EV_cod_moneda     IN GE_CARGOS.cod_moneda%TYPE,
    EV_num_serie      IN GE_CARGOS.num_serie%TYPE,
    SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_INGRESO_COBRO_PR"
      Lenguaje="PL/SQL"
      Fecha="09-06-2005"
      Versión="1.0"
      Diseñador=""Oscar Jorquera"
      Programador="Oscar Jorquera"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Ingreso Cobro de consulta de tasación</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="LN_seq_cargos " Tipo="NUMERICO">Numero Secuencial del cargo</param>
   <param nom="SN_cod_cliente" Tipo="NUMERICO">Código Cliente</param>
   <param nom="GN_cod_producto" Tipo="NUMERICO">Código Producto</param>
   <param nom="SN_num_abonado" Tipo="NUMERICO">Número Abonado</param>
   <param nom="SN_num_celular" Tipo="NUMERICO">Número Celular</param>
   <param nom="LN_cod_plancom" Tipo="NUMERICO">Código Plan Comercial</param>
   <param nom="LN_cod_ciclfact" Tipo="NUMERICO">Código ciclo Facturación</param>
   <param nom="LN_cod_concepto" Tipo="NUMERICO">Código concepto</param>
   <param nom="LN_imp_tarifa" Tipo="NUMERICO">Tarifa</param>
   <param nom="LV_cod_moneda" Tipo="VARCHAR2">Código Moneda</param>
         </Entrada>
         <Salida>
            <param nom="sn_cod_retorno"  Tipo="VARCHAR" >Código de Retorno (descripción de error)</param>
            <param nom="sv_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="sn_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
   </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_sSql    ge_errores_pg.vQuery;
    LV_des_error   ge_errores_pg.DesEvent;

    error_ejecucion  EXCEPTION;
BEGIN

  SN_cod_retorno  := 0;
  SV_mens_retorno := '';
  SN_num_evento := 0;

  LV_sSql := 'INSERT INTO ge_cargos(';
  LV_sSql := LV_sSql ||  'num_cargo  ,cod_cliente ,cod_producto ,num_abonado  ,num_terminal,';
  LV_sSql := LV_sSql ||  'cod_plancom,cod_ciclfact,fec_alta     ,cod_concepto ,imp_cargo,';
  LV_sSql := LV_sSql ||  'cod_moneda ,num_serie   ,num_unidades ,ind_factur   ,num_transaccion,';
  LV_sSql := LV_sSql ||  'num_venta  ,nom_usuarora)';
  LV_sSql := LV_sSql ||  'VALUES ( ';
  LV_sSql := LV_sSql ||  ' ge_seq_cargos.NEXTVAL,'|| EN_cod_cliente ||','|| GN_cod_producto ||','|| EN_num_abonado ||',';
  LV_sSql := LV_sSql ||   EN_num_celular ||','|| EN_cod_plancom ||','||EN_cod_ciclfact ||','|| TO_DATE(TO_CHAR(SYSDATE,'dd-mm-yyyy hh24:mi:ss'),'dd-mm-yyyy hh24:mi:ss') ||',';
  LV_sSql := LV_sSql ||   EN_cod_concepto ||','||EN_imp_tarifa ||','|| EV_cod_moneda ||','||EV_num_serie ||','|| GN_num_unidades ||',';
  LV_sSql := LV_sSql ||   GN_ind_factur ||','|| GN_num_transaccion ||','|| GN_num_venta ||','|| USER ||')';


  INSERT INTO GE_CARGOS(
            num_cargo,
          cod_cliente,
          cod_producto,
         NUM_ABONADO,
         num_terminal,
         cod_plancom,
         cod_ciclfact,
         fec_alta,
         cod_concepto,
         imp_cargo,
         cod_moneda,
         num_serie,
         num_unidades,
         ind_factur,
         num_transaccion,
         num_venta,
         nom_usuarora)
     VALUES
        (
         ge_seq_cargos.NEXTVAL,
         EN_cod_cliente,
         GN_cod_producto,
         EN_num_abonado,
         EN_num_celular,
         EN_cod_plancom,
         EN_cod_ciclfact,
         TO_DATE(TO_CHAR(SYSDATE,'dd-mm-yyyy hh24:mi:ss'),'dd-mm-yyyy hh24:mi:ss'),
         EN_cod_concepto,
         EN_imp_tarifa,
         EV_cod_moneda,
         EV_num_serie,
         GN_num_unidades,
         GN_ind_factur,
         GN_num_transaccion,
         GN_num_venta,
         USER);

     IF SN_cod_retorno <> 0 THEN
     RAISE  error_ejecucion;
  END IF;

EXCEPTION

 WHEN error_ejecucion THEN
 SN_cod_retorno := 406;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
     SV_mens_retorno := gv_error_no_clasif;
 END IF;
 LV_des_error :=SUBSTR('error_ejecucion: GA_INGRESO_COBRO_PR('||EN_cod_cliente||','||GN_cod_producto||','||EN_num_abonado||','||EN_num_celular||','||EN_cod_plancom||','||EN_cod_ciclfact||','||EN_cod_concepto||','||EN_imp_tarifa||','||EV_cod_moneda||','||EV_num_serie||'); - ' || SQLERRM,1,GN_largoerrtec);
 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'ga_ingreso_cobro_pr', LV_sSql, SN_cod_retorno, LV_des_error );

 WHEN OTHERS THEN
 SN_cod_retorno := 156;
 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
     SV_mens_retorno := gv_error_no_clasif;
 END IF;

 LV_des_error :=SUBSTR('others: GA_INGRESO_COBRO_PR('||EN_cod_cliente||','||GN_cod_producto||','||EN_num_abonado||','||EN_num_celular||','||EN_cod_plancom||','||EN_cod_ciclfact||','||EN_cod_concepto||','||EN_imp_tarifa||','||EV_cod_moneda||','||EV_num_serie||'); - ' || SQLERRM,1,GN_largoerrtec);
 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, GV_cod_modulo,SV_mens_retorno, CV_version, USER, 'GA_INGRESO_COBRO_PR', LV_sSql, SN_cod_retorno, LV_des_error );


END ga_ingreso_cobro_pr;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_saldo_pr(
    EN_num_celular     IN  NUMBER,
    SN_saldo    OUT NOCOPY   NUMBER,
    SN_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento     OUT NOCOPY   ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_SALDO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar el Saldo del cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
      <param nom="SN_saldo"           Tipo="NUMERICO">Saldo de deuda</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_nom_tabla    CO_CODIGOS.nom_tabla%TYPE  := 'CO_CARTERA';
    LV_nom_columna  CO_CODIGOS.nom_columna%TYPE:= 'COD_TIPDOCUM';
    LN_1      NUMBER(1)      := 1;
    LN_Deuda     CO_CARTERA.importe_debe%TYPE;
    LN_dias   CO_CATEGORIAS_TD.nro_dgracia%TYPE;
    LV_des_error  ge_errores_pg.DesEvent;
    LV_sSql      ge_errores_pg.vQuery;

    error_ejecucion EXCEPTION;
 error_abonado   EXCEPTION;

BEGIN
    SN_cod_retorno  := 0;
        SV_mens_retorno := '';
  SN_num_evento  := 0;

     -- Obtiene datos del abonado
    IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                         GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                       GN_cod_prod, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

           RAISE error_ejecucion;
     END IF;

  -- Validamos que no sea Prepago --
  IF GV_tip_abonado = CV_prepago THEN
     RAISE error_abonado;
  END IF;

        -- Obtiene cantidad de dias de gracia
     LV_sSql:=' SELECT cat.nro_dgracia ' ||
            ' FROM   ge_clientes cli, co_categorias_td cat, co_catcobclie_td cob' ||
           ' WHERE  cob.cod_catecli = cli.cod_categoria ' ||
          'AND cat.cod_categoria = cob.cod_catecob' ||
       'AND cod_cliente = ' || GN_cod_cliente;

  SELECT cat.nro_dgracia
  INTO  LN_dias
  FROM  GE_CLIENTES cli, CO_CATEGORIAS_TD cat, CO_CATCOBCLIE_TD cob
  WHERE cob.cod_catecli = cli.cod_categoria
      AND cat.cod_categoria = cob.cod_catecob
     AND cli.cod_cliente = GN_cod_cliente;

  -- Obtiene Deuda -
     LV_sSql:='SELECT NVL(SUM(a.importe_debe - a.importe_haber),0)' ||
     'FROM   co_cartera a' ||
     'WHERE  a.cod_cliente   = ' || GN_cod_cliente ||
     'AND    a.ind_facturado = ' || LN_1 ||
     'AND    a.fec_vencimie  < TRUNC(SYSDATE)' ||
     'AND    a.fec_vencimie  + ' || LN_dias || ' < TRUNC(SYSDATE)' ||
     'AND    NOT EXISTS (SELECT 1' ||
                     'FROM   co_codigos b'||
                     'WHERE  b.nom_tabla        = ' || LV_nom_tabla ||
                     'AND    b.nom_columna          = ' || LV_nom_columna ||
         'AND    TO_NUMBER(b.cod_valor) = a.cod_tipdocum)';

  SELECT NVL(SUM(a.importe_debe - a.importe_haber),0)
  INTO   LN_Deuda
  FROM   CO_CARTERA a
  WHERE  a.cod_cliente   = GN_cod_cliente
  AND    a.ind_facturado = LN_1
  AND    a.fec_vencimie  < TRUNC(SYSDATE)
  AND    a.fec_vencimie  + LN_dias  < TRUNC(SYSDATE)
  AND    NOT EXISTS (SELECT 1
                     FROM   CO_CODIGOS b
                     WHERE  b.nom_tabla      = LV_nom_tabla
                     AND    b.nom_columna          = LV_nom_columna
         AND    TO_NUMBER(b.cod_valor) = a.cod_tipdocum);

  SN_saldo := LN_Deuda ;

EXCEPTION
     WHEN error_ejecucion THEN
    LV_des_error    := 'ga_consulta_saldo_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consumo_pg.ga_consulta_saldo_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    WHEN error_abonado THEN
          SN_cod_retorno := 318;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := GV_error_no_clasif;
          END IF;
          LV_des_error := 'ga_consulta_saldo_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consumo_pg.ga_consulta_saldo_pr', LV_sSql, SN_cod_retorno, LV_des_error );

  WHEN NO_DATA_FOUND THEN
     SN_cod_retorno := 266;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := GV_error_no_clasif;
         END IF;
       LV_des_error  :='ga_consulta_saldo_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consumo_pg.ga_consulta_saldo_pr', LV_sSql, SN_cod_retorno, LV_des_error );


  WHEN VALUE_ERROR THEN
     SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := GV_error_no_clasif;
         END IF;
       LV_des_error  :='ga_consulta_saldo_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consumo_pg.ga_consulta_saldo_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
     SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := GV_error_no_clasif;
         END IF;
    LV_des_error    := 'ga_consulta_saldo_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consumo_pg.ga_consulta_saldo_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_saldo_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_consumo_6meses_pr (
   EN_num_celular    IN    GA_ABOCEL.num_celular%TYPE,
   SC_cur_consumo    OUT   NOCOPY refcursor,
   SN_cod_retorno    OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT   NOCOPY ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_CONSUMO_6MESES_PR"
      Lenguaje="PL/SQL"
      Fecha="17-06-2005"
      Versión="La del package"
      Diseñador="Carlos Navarro H - MArcelo Godoy S"
      Programador="Carlos Navarro H - MArcelo Godoy S"
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Recupera el consumo de los ultimos 6 meses</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="CARACTER">Numero de Celular</param>
         </Entrada>
         <Salida>
   <param nom="SC_cur_consumo" Tipo="CARACTER">Cursor de Salida</param>
   <param nom="SN_cod_retorno" Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
 LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
 LN_cod_notacre    NUMBER;
 LN_cod_atencion    NUMBER;
 LV_obs_atencion    VARCHAR2(100);

 error_ejecucion    EXCEPTION;
 error_abonado      EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
 LN_cod_atencion := 512;

    OPEN SC_cur_consumo FOR
    SELECT NULL cod_ciclfact, NULL ind_ordentotal, NULL num_folio, NULL des_tipdocum, NULL monto, NULL impuesto, NULL consumo
      FROM DUAL
     WHERE ROWNUM = 0;


 -- Se Obtienen datos del abonado
    IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                   GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                   GN_cod_prod, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE error_ejecucion;
    END IF;

    -- Se válida que el cliente no sea de Prepago
    IF GV_tip_abonado = CV_prepago THEN
        RAISE error_abonado;
    END IF;

 LV_sSql := 'SELECT cod_notacre INTO LN_cod_notacre FROM fa_datosgener';

 SELECT cod_notacre
   INTO LN_cod_notacre
   FROM FA_DATOSGENER;

 LV_sSql := 'SELECT a.cod_ciclfact, a.ind_ordentotal, a.num_folio, c.des_tipdocum, a.tot_pagar monto,';
 LV_sSql := LV_sSql || ' a.acum_iva impuesto, ga_recupera_consumo_fn(a.ind_ordentotal, a.cod_ciclfact) consumo';
 LV_sSql := LV_sSql || ' FROM fa_histdocu a, fa_tipdocumen b, ge_tipdocumen c, fa_ciclfact d';
 LV_sSql := LV_sSql || ' WHERE a.cod_tipdocum = b.cod_tipdocum';
 LV_sSql := LV_sSql || ' AND a.cod_tipdocum = c.cod_tipdocum';
 LV_sSql := LV_sSql || ' AND b.cod_tipdocummov = c.cod_tipdocum';
 LV_sSql := LV_sSql || ' AND a.cod_ciclfact = d.cod_ciclfact';
 LV_sSql := LV_sSql || ' AND a.cod_tipdocum != '||LN_cod_notacre;
 LV_sSql := LV_sSql || ' AND a.cod_cliente = '||GN_cod_cliente;
 LV_sSql := LV_sSql || ' AND a.fec_emision > SYSDATE - 180';
 LV_sSql := LV_sSql || ' ORDER BY A.cod_ciclfact DESC;';

   OPEN SC_cur_consumo FOR
    SELECT a.cod_ciclfact, a.ind_ordentotal, a.num_folio, c.des_tipdocum, a.tot_pagar monto,
        a.acum_iva impuesto, ga_recupera_consumo_fn(a.ind_ordentotal, a.cod_ciclfact) consumo
      FROM FA_HISTDOCU a, FA_TIPDOCUMEN b, GE_TIPDOCUMEN c, FA_CICLFACT d
     WHERE a.cod_tipdocum = b.cod_tipdocum
       AND a.cod_tipdocum = c.cod_tipdocum
       AND b.cod_tipdocummov = c.cod_tipdocum
       AND a.cod_ciclfact = d.cod_ciclfact
       AND a.cod_tipdocum != LN_cod_notacre
       AND a.cod_cliente = GN_cod_cliente
       AND a.fec_emision > SYSDATE - 180
     ORDER BY A.cod_ciclfact DESC;

   -- Registro de atención del Cliente
   LV_obs_atencion := 'Se atendió al Celular: ';
   Ga_Segmentacion_Pg.ga_reg_atencion_cliente_pr(EN_num_celular, LN_cod_atencion, LV_obs_atencion, USER, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
   IF SN_cod_retorno <> 0 THEN
    RAISE error_ejecucion;
   END IF;


EXCEPTION

    WHEN error_ejecucion THEN
        LV_des_error := 'ga_consulta_consumo_6meses_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version, USER, 'ga_consulta_consumo_6meses_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    WHEN error_abonado THEN
        SN_cod_retorno := 318;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
        END IF;
        LV_des_error := 'ga_consulta_consumo_6meses_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version, USER, 'ga_consulta_consumo_6meses_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
        SN_cod_retorno := 151;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
        END IF;
        LV_des_error := 'ga_consulta_consumo_6meses_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version, USER, 'ga_consulta_consumo_6meses_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_consumo_6meses_pr;

-----------------------------------------------------------------------------------------------------------------
PROCEDURE ga_plan_detallado_pr (
   EN_num_celular       IN   GA_ABOCEL.num_celular%TYPE,
   SV_cod_plantarif  OUT  NOCOPY TA_PLANTARIF.cod_plantarif%TYPE,
   SV_fec_vigencia  OUT  NOCOPY GA_ABOCEL.fec_cumplan%TYPE,
   SN_num_unidades  OUT  NOCOPY TA_PLANTARIF.num_unidades%TYPE,
   SN_imp_cargobasico OUT  NOCOPY TA_CARGOSBASICO.imp_cargobasico%TYPE,
   SN_cod_retorno       OUT  NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT  NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT  NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_PLAN_DETALLADO_PR"
      Fecha modificacion=" "
      Fecha creacion="17-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recupera informacion del plan tarifario</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_plantarif" Tipo="CARACTER">Codigo de Plan Tarifario</param>
            <param nom="SV_fec_vigencia" Tipo="CARACTER">Fecha de Vigencia</param>
            <param nom="SN_num_unidades" Tipo="NUMERICO">Numero de Unidades</param>
            <param nom="SN_imp_cargobasico" Tipo="NUMERICO">Cargo Basico</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
IS
    LV_des_error          ge_errores_pg.DesEvent;
    LV_sSql            ge_errores_pg.vQuery;
    N_imp_cargo        NUMBER;
 N_cod_notacre    NUMBER;
 LN_cod_atencion    NUMBER;
 LV_obs_atencion    VARCHAR2(100);
 LN_cod_ciclfact    FA_CICLFACT.cod_ciclfact%TYPE; -- ahott RA-*913 01-04-2006
 LN_clie     NUMBER; -- ahott RA-*913 01-04-2006

 error_ejecucion    EXCEPTION;
 error_abonado      EXCEPTION;
BEGIN

    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
 LN_cod_atencion := 503;

 -- Se Obtienen datos del abonado
    IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                   GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                   GN_cod_prod, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE error_ejecucion;
    END IF;

    -- Se válida que el cliente no sea de Prepago
    IF GV_tip_abonado = CV_prepago THEN
        RAISE error_abonado;
    END IF;

    -- Se calcula el impuesto del cargo basico
    IF NOT ga_impuesto_plan_tarifario_fn (GN_num_abonado, N_imp_cargo, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE error_ejecucion;
    END IF;

 -- Se obtiene la inforcion del plan tarifario
 /* Inicio modificacion by SAQL/Soporte 30/03/2006 - RA-200603140913
 LV_sSql := 'SELECT b.cod_plantarif, a.fec_cumplan, b.num_unidades, (c.imp_cargobasico * (('||N_imp_cargo||'/100) + 1)) imp_cargobasico';
 LV_sSql := LV_sSql || ' INTO SV_cod_plantarif, SV_fec_vigencia, SN_num_unidades, SN_imp_cargobasico';
 LV_sSql := LV_sSql || ' FROM ga_abocel a, ta_plantarif b, ta_cargosbasico c';
 LV_sSql := LV_sSql || ' WHERE a.cod_plantarif = b.cod_plantarif';
 LV_sSql := LV_sSql || ' AND a.cod_producto = b.cod_producto';
 LV_sSql := LV_sSql || ' AND b.cod_cargobasico = c.cod_cargobasico';
 LV_sSql := LV_sSql || ' AND b.cod_producto = c.cod_producto';
 LV_sSql := LV_sSql || ' AND a.num_abonado = '||GN_num_abonado;
 LV_sSql := LV_sSql || ' AND a.cod_producto = '||GN_cod_producto;

    SELECT b.cod_plantarif, a.fec_cumplan, b.num_unidades, (c.imp_cargobasico * ((N_imp_cargo/100) + 1)) imp_cargobasico
   INTO SV_cod_plantarif, SV_fec_vigencia, SN_num_unidades, SN_imp_cargobasico
      FROM GA_ABOCEL a, TA_PLANTARIF b, TA_CARGOSBASICO c
     WHERE a.cod_plantarif = b.cod_plantarif
       AND a.cod_producto = b.cod_producto
       AND b.cod_cargobasico = c.cod_cargobasico
       AND b.cod_producto = c.cod_producto
       AND a.NUM_ABONADO = GN_num_abonado
       AND a.cod_producto = GN_cod_producto; */

    LV_sSql := 'SELECT B.COD_PLAN, B.FEC_TER_VIG, C.CNT_BOLSA, D.IMP_TARIFA';
    LV_sSql := LV_sSql || ' INTO SV_cod_plantarif, SV_fec_vigencia, SN_num_unidades, SN_imp_cargobasico';
    LV_sSql := LV_sSql || ' FROM TOL_CLIESERVSUPL_TD A, TOL_BOLSA_PLAN B, TOL_BOLSAS C, GA_TARIFAS D';
    LV_sSql := LV_sSql || ' WHERE A.COD_SERVSUPL = 19 ';
    LV_sSql := LV_sSql || ' AND A.IND_SERV = D.COD_ACTABO ';
    LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN A.FEC_INI_VIG AND NVL(A.FEC_TER_VIG,SYSDATE)';
    LV_sSql := LV_sSql || ' AND A.NUM_ABONADO = GN_num_abonado';
    LV_sSql := LV_sSql || ' AND A.COD_PLAN = B.COD_PLAN';
    LV_sSql := LV_sSql || ' AND C.COD_BOLSA = B.COD_BOLSA';
    LV_sSql := LV_sSql || ' AND A.COD_SERV = D.COD_SERVICIO;';

    BEGIN

      --Inicio ahott RA-*913 01-04-2006
      SELECT
      a.cod_ciclfact
      INTO LN_cod_ciclfact
      FROM FA_CICLFACT a
      WHERE a.cod_ciclo = GN_cod_ciclo
      AND SYSDATE BETWEEN a.FEC_DESDEOCARGOS AND NVL(a.FEC_HASTAOCARGOS, SYSDATE);
      --Fin ahott RA-*913 01-04-2006
      /* Inicio modificacion by SAQL/Soporte 03/04/2006 */
      BEGIN
         SELECT B.COD_PLAN, B.FEC_TER_VIG --, C.CNT_BOLSA, D.IMP_TARIFA
         INTO SV_cod_plantarif, SV_fec_vigencia --, SN_num_unidades, SN_imp_cargobasico
         FROM TOL_CLIESERVSUPL_TD A, TOL_BOLSA_PLAN B, TOL_BOLSAS C, GA_TARIFAS D, GA_ABOCEL E
         WHERE A.COD_SERVSUPL = '19'
         AND A.IND_SERV = D.COD_ACTABO
         AND SYSDATE BETWEEN A.FEC_INI_VIG AND NVL(A.FEC_TER_VIG,SYSDATE)
         AND SYSDATE BETWEEN B.FEC_INI_VIG AND NVL(B.FEC_TER_VIG,SYSDATE)
         AND A.NUM_ABONADO = GN_num_abonado
         AND A.COD_PLAN = B.COD_PLAN
         AND C.COD_BOLSA = B.COD_BOLSA
         AND A.COD_SERV = D.COD_SERVICIO
         AND A.NUM_ABONADO = E.NUM_ABONADO
         AND A.COD_CLIENTE = E.COD_CLIENTE
         AND D.COD_PLANSERV = E.COD_PLANSERV;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SV_cod_plantarif := NULL;
            SV_fec_vigencia  := NULL;
      END;
      /* Fin modificacion by SAQL/Soporte 03/04/2006 */
       LN_clie := SUBSTR(GN_cod_cliente,LENGTH(GN_cod_cliente),1); -- ahott RA-*913 01-04-2006

       -- Inicio ahott RA-*913 01-04-2006
       CASE LN_clie
           WHEN 0 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_00
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 1 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_01
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 2 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_02
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 3 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_03
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 4 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_04
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 5 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_05
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 6 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_06
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 7 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_07
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 8 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_08
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
           WHEN 9 THEN
  SELECT COUNT(1), SUM(MTO_FACT) - SUM(MTO_DCTO)
  INTO SN_num_unidades, SN_imp_cargobasico
  FROM TOL_DETFACTURA_09
  WHERE NUM_ABON = GN_num_abonado
  AND NUM_CLIE = GN_cod_cliente
  AND COD_CICLFACT = LN_cod_ciclfact
  AND RECORD_TYPE = 'SC'
  ORDER BY DATE_START_CHARG, TIME_START_CHARG;
        END CASE;

        --Fin ahott RA-*913 01-04-2006


    EXCEPTION
       WHEN NO_DATA_FOUND THEN
          SV_cod_plantarif := NULL;
          SV_fec_vigencia := NULL;
          SN_num_unidades := 0;
          SN_imp_cargobasico := 0;
    END;
    /* Fin modificacion by SAQL/Soporte 30/03/2006 - RA-200603140913 */

EXCEPTION

    WHEN error_ejecucion THEN
        LV_des_error := 'ga_plan_detallado_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_plan_detallado_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    WHEN error_abonado THEN
        SN_cod_retorno := 318;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
        END IF;
        LV_des_error := 'ga_plan_detallado_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_plan_detallado_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
        END IF;
        LV_des_error := 'ga_plan_detallado_pr('||EN_num_celular||'); - ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_plan_detallado_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_plan_detallado_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_mensaje_pr  (
   EN_num_celular       IN         GA_ABOCEL.NUM_ABONADO%TYPE,
   SN_cargo_basico      OUT NOCOPY NUMBER,
   SN_can_mensaje_recib OUT NOCOPY NUMBER,
   SN_val_mensaje_recib OUT NOCOPY NUMBER,
   SN_can_mensaje_envia OUT NOCOPY NUMBER,
   SN_val_mensaje_envia OUT NOCOPY NUMBER,
   SN_tot_valor_servic  OUT NOCOPY NUMBER,
   SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "GA_RECUPERA_TOLMENSAJES_00_FN"
      Fecha modificacion=" "
      Fecha creacion="16-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recupera cantidad y valor de mensajes recibidos y enviados</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_can_mensaje_recib" Tipo="NUMERICO">cantidad de mensajes recibidos</param>
            <param nom="SN_val_mensaje_recib" Tipo="NUMERICO">valor mensajes recibidos</param>
            <param nom="SN_can_mensaje_envia" Tipo="NUMERICO">cantidad de mensajes enviados</param>
            <param nom="SN_val_mensaje_envia" Tipo="NUMERICO">valor mensajes enviados</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS
   LV_des_error       ge_errores_pg.DesEvent;
   LV_sSql            ge_errores_pg.vQuery;
   LN_cargo_basico    NUMBER;
   LN_impuesto        NUMBER;
   paso1              NUMBER;
   LN_cod_atencion    NUMBER;
   LV_obs_atencion    VARCHAR2(100);
   LV_cod_plantarif   TA_PLANTARIF.cod_plantarif%TYPE;
   LV_fec_vigencia   VARCHAR2(15);
   LN_num_unidades   TA_PLANTARIF.num_unidades%TYPE;

   LN_ext_llam_sal      NUMBER; --Tiempo Extra Saliente -rast- 28/09/2006
   LN_ext_llam_ent      NUMBER; --Tiempo Extra Entrante -rast- 28/09/2006

   error_ejecucion    EXCEPTION;
   error_parametros   EXCEPTION;
   error_abonado   EXCEPTION;
BEGIN

   SN_cod_retorno  := 0;
   SV_mens_retorno := '';
   SN_num_evento   := 0;
   LN_cod_atencion := 504;

   LN_ext_llam_sal :=0;  --Tiempo Extra Saliente -rast- 28/09/2006
   LN_ext_llam_ent :=0;  --Tiempo Extra Saliente -rast- 28/09/2006

 -- Se Obtienen datos del abonado
   IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                            GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                            GN_cod_prod, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
        RAISE error_ejecucion;
    END IF;

    -- Se válida que el cliente no sea de Prepago
    IF GV_tip_abonado = CN_abonado_prepago THEN
        RAISE error_abonado;
    END IF;

   Ga_Consumo_Pg.ga_plan_detallado_pr (EN_num_celular,LV_cod_plantarif,LV_fec_vigencia,LN_num_unidades,SN_cargo_basico,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno <> 0 THEN
      RAISE error_ejecucion;
   END IF;

   IF NOT ga_tol_detfactura_fn (GN_num_abonado, 'SM', SUBSTR(GN_cod_cliente,LENGTH(GN_cod_cliente),1), 'S', SN_can_mensaje_envia, SN_val_mensaje_envia, LN_ext_llam_sal, paso1, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;
   IF NOT ga_tol_detfactura_fn (GN_num_abonado, 'SM', SUBSTR(GN_cod_cliente,LENGTH(GN_cod_cliente),1), 'E', SN_can_mensaje_recib, SN_val_mensaje_recib, LN_ext_llam_ent, paso1, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   SN_tot_valor_servic := SN_val_mensaje_recib + SN_val_mensaje_envia;

EXCEPTION

   WHEN error_ejecucion THEN
      LV_des_error := 'ga_consulta_mensaje_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consulta_mensaje_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN error_abonado THEN
      SN_cod_retorno := 318;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_consulta_mensaje_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consulta_mensaje_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_consulta_mensaje_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consulta_mensaje_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_mensaje_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_tasacion_pr  (
   EN_num_abonado       IN  GA_ABOCEL.NUM_ABONADO%TYPE,
   SN_tim_llam_ent      OUT NOCOPY NUMBER,
   SN_val_llam_ent      OUT NOCOPY NUMBER,
   SN_tim_llam_sal      OUT NOCOPY NUMBER,
   SN_val_llam_sal      OUT NOCOPY NUMBER,
   SN_tim_llam_dat      OUT NOCOPY NUMBER,
   SN_val_llam_dat      OUT NOCOPY NUMBER,
   SN_tim_tota_voz      OUT NOCOPY NUMBER,
   SN_tim_text_voz      OUT NOCOPY NUMBER,  -- 34629 -rast- 28/09/2006 Tiempo Extra
   SN_val_tota_voz      OUT NOCOPY NUMBER,
   SN_tim_oper_tot      OUT NOCOPY NUMBER,
   SN_tim_cons_pla      OUT NOCOPY NUMBER,
   SN_tim_cons_npl      OUT NOCOPY NUMBER,
   SN_ind_unidad        OUT NOCOPY NUMBER,  -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   SN_minutos_prom      OUT NOCOPY NUMBER,
   SN_cont_tasacion     OUT NOCOPY NUMBER,
   SN_VAL_MINTOTAL      OUT NOCOPY NUMBER,
   SN_VAL_USADO         OUT NOCOPY NUMBER,
   SN_VAL_DISPONIBLE    OUT NOCOPY NUMBER,
   SN_USADO_BOLSA       OUT NOCOPY NUMBER,
   SN_DISPONIBLE_BOLSA  OUT NOCOPY NUMBER,
   SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "GA_CONSULTA_TASACION_PR"
      Fecha modificacion=" "
      Fecha creacion="16-06-2005"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador="
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recupera cantidad y valor de mensajes recibidos y enviados</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
         </Entrada>
         <Salida>
            <param nom="SN_tim_llam_ent"     Tipo="NUMERICO">Minutos llamadas entrantes</param>
            <param nom="SN_val_llam_ent"     Tipo="NUMERICO">Valor llamadas entrantes  </param>
            <param nom="SN_tim_llam_sal"     Tipo="NUMERICO">Minutos llamadas salientes</param>
            <param nom="SN_val_llam_sal"     Tipo="NUMERICO">Valor llamadas salientes  </param>
            <param nom="SN_tim_llam_dat"     Tipo="NUMERICO">Minutos datos </param>
            <param nom="SN_val_llam_dat"     Tipo="NUMERICO">Valor datos  </param>
            <param nom="SN_tim_tota_voz"     Tipo="NUMERICO">Minutos plan llamadas de voz</param>
            <param nom="SN_tim_text_voz"     Tipo="NUMERICO">Minutos extra llamadas de voz</param>
            <param nom="SN_val_tota_voz"     Tipo="NUMERICO">Valor total llamadas de voz</param>
            <param nom="SN_tim_oper_tot"     Tipo="NUMERICO">Total minutos de trafico</param>
            <param nom="SN_tim_cons_pla"     Tipo="NUMERICO">Minutos consumidos del plan</param>
            <param nom="SN_tim_cons_npl"     Tipo="NUMERICO">Minutos consumidos fuera del plan</param>
            <param nom="SN_ind_unidad"       Tipo="NUMERICO">Indicador de unidad de bolsa</param>
            <param nom="SN_minutos_prom"     Tipo="NUMERICO">Minutos consumidos por promocion</param>
            <param nom="SN_cont_tasacion"    Tipo="NUMERICO">Cantidad de consultas de tasacion en el dia</param>
            <param nom="SN_VAL_MINTOTAL"     Tipo="NUMERICO">Cantidad de Minutos de Extratiempo contratado</param>
            <param nom="SN_VAL_USADO"        Tipo="NUMERICO">Cantidad de Minutos Usados en extratiempo</param>
            <param nom="SN_VAL_DISPONIBLE"   Tipo="NUMERICO">Cantidad de Minutos disponible en extratiempo</param>
            <param nom="SN_USADO_BOLSA"      Tipo="NUMERICO">Cantidad de Minutos Usados en bolsa</param>
            <param nom="SN_DISPONIBLE_BOLSA" Tipo="NUMERICO">Cantidad de Minutos Disponibles en bolsa</param>
            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
AS
   LV_des_error         ge_errores_pg.DesEvent;
   LV_sSql              ge_errores_pg.vQuery;

   /* Inicio modificacion by SAQL/Soporte 16/05/2006 - CO-200605050102 */
   -- LN_minutos_plan       NUMBER(9);
   -- LN_minutos_consumidos NUMBER(9);
   -- LN_minutos_disponible NUMBER(9);
   LN_minutos_plan       NUMBER;
   LN_minutos_consumidos NUMBER;
   LN_minutos_disponible NUMBER;
   /* Fin modificacion by SAQL/Soporte 16/05/2006 - CO-200605050102 */

   -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   LN_ind_unidad        NUMBER;

   paso1                NUMBER(5);
   LN_cod_atencion      NUMBER;
   LV_obs_atencion      VARCHAR2(100);
   EN_num_celular       NUMBER(15);

   -- 34629 -rast- 28/09/2006 Tiempo Extra
   LN_ext_llam_sal      NUMBER;
   LN_ext_llam_ent      NUMBER;
   LN_ext_llam_dat      NUMBER;

   error_ejecucion      EXCEPTION;
   error_parametros     EXCEPTION;
   error_abonado        EXCEPTION;
   error_extratiempo    EXCEPTION;
   retorna_ceros exception; /* Modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */

   LV_COD_PLAN          VARCHAR2(5);
   LN_VAL_MINTOTAL      NUMBER :=0;
   LN_VAL_USADO         NUMBER :=0;
   LN_VAL_DISPONIBLE    NUMBER :=0;
   LN_USADO_BOLSA       NUMBER :=0;
   LN_DISPONIBLE_BOLSA  NUMBER :=0;

   CV_param_usuario     CONSTANT   ged_parametros.nom_parametro%TYPE:='USUARIO_SERV_PL_SQL';
   LV_usuario           ged_parametros.val_parametro%TYPE;
   CN_cod_producto      CONSTANT NUMBER(1):=1;

   /* Inicio modificacion by SAQL/Soporte 22/03/2006 - RA-200603140913 */
   LN_Cursor_EX         NUMBER := 0;
   LN_CicloFacturacion  NUMBER := 0;
   /* Fin modificacion by SAQL/Soporte 22/03/2006 - RA-200603140913 */

   CURSOR c_planesx IS
      --INI COL-35846|02-12-2006|GEZ
	  /*SELECT
         a.cod_dcto
      FROM
         tol_cliedcto_det a
      WHERE
         a.COD_ABONADO = EN_NUM_ABONADO
         AND SUBSTR(a.cod_dcto,1,LENGTH(LV_PREFIJOX)) = LV_PREFIJOX
      ORDER BY
         a.fec_ini_vig;*/
	  SELECT a.cod_dcto
	  FROM tol_cliedcto_det a,tol_cliedcto_to b
	  WHERE a.COD_ABONADO = EN_NUM_ABONADO
      AND SUBSTR(a.cod_dcto,1,LENGTH(LV_PREFIJOX)) = LV_PREFIJOX
	  AND a.tip_dcto=b.tip_dcto
	  AND a.cod_dcto=b.cod_dcto
	  AND a.cod_cliente=b.cod_cliente
	  AND B.fec_ter_vig> SYSDATE
	  AND a.fec_ini_vig=b.fec_ini_vig
	  ORDER BY a.fec_ini_vig;
	  --FIN COL-35846|02-12-2006|GEZ

BEGIN
   SN_VAL_MINTOTAL :=0;
   SN_VAL_USADO :=0;
   SN_VAL_DISPONIBLE :=0;
   SN_USADO_BOLSA :=0;
   SN_DISPONIBLE_BOLSA :=0;

   SN_cod_retorno  := 0;
   SV_mens_retorno := '';
   SN_num_evento   := 0;
   LN_cod_atencion := 502;

   -- 34629 -rast- 28/09/2006 Tiempo Extra
   LN_ext_llam_sal := 0;
   LN_ext_llam_ent := 0;
   LN_ext_llam_dat := 0;

   SELECT num_celular
     INTO EN_num_celular
     FROM GA_ABOCEL
    WHERE NUM_ABONADO = EN_num_abonado
    UNION
   SELECT num_celular
     FROM GA_ABOAMIST
    WHERE NUM_ABONADO = EN_num_abonado;

   -- Se obtienen datos del abonado
   IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                  GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                  GN_cod_prod, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
       RAISE error_ejecucion;
   END IF;

   -- Se válida que el cliente no sea de Prepago
   /* Inicio modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
   /* IF GV_tip_abonado = CN_abonado_prepago OR GV_tip_abonado = CN_abonado_hibrido THEN */
   IF GV_tip_abonado = CN_abonado_prepago THEN
   /* Fin modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
       RAISE error_abonado ;
   END IF;

   /* Inicio modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
   IF GV_tip_abonado = CN_abonado_hibrido THEN
      LV_obs_atencion := 'Se atendió al Celular: ';
      LV_usuario:=NULL;
      LV_sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_usuario||','||'GE'||','||CN_cod_producto||');';

	  IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_usuario,'GE',CN_cod_producto,LV_usuario,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
         SN_cod_retorno:=215;
         RAISE  error_ejecucion;
      END IF;

	  Ga_Segmentacion_Pg.ga_reg_atencion_cliente_pr(EN_num_celular, LN_cod_atencion, LV_obs_atencion, LV_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );

	  IF SN_cod_retorno <> 0 THEN
         RAISE error_ejecucion;
      ELSE
         SELECT COUNT(1)
         INTO SN_cont_tasacion
         FROM CI_REG_ATENCION_CLIENTES
         WHERE fec_inicio BETWEEN TRUNC(SYSDATE) AND trunc(sysdate+1)-1/86400
  		 AND NUM_ABONADO  = GN_num_abonado
  		 AND cod_atencion = LN_cod_atencion;
         RAISE retorna_ceros;
      END IF;

   END IF;
   /* Fin modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */

   --Tiempo Extra Saliente -rast- 28/09/2006
   IF NOT (ga_tol_detfactura_fn (GN_num_abonado, 'S', SUBSTR(GN_cod_cliente,LENGTH(GN_cod_cliente),1), 'S', paso1, SN_val_llam_sal, LN_ext_llam_sal, SN_tim_llam_sal, SN_cod_retorno, SV_mens_retorno, SN_num_evento) AND
           ga_tol_detfactura_fn (GN_num_abonado, 'E', SUBSTR(GN_cod_cliente,LENGTH(GN_cod_cliente),1), 'E', paso1, SN_val_llam_ent, LN_ext_llam_ent, SN_tim_llam_ent, SN_cod_retorno, SV_mens_retorno, SN_num_evento) AND
           ga_tol_detfactura_fn (GN_num_abonado, 'C', SUBSTR(GN_cod_cliente,LENGTH(GN_cod_cliente),1), 'S', paso1, SN_val_llam_dat, LN_ext_llam_dat, SN_tim_llam_dat, SN_cod_retorno, SV_mens_retorno, SN_num_evento)) THEN
       RAISE error_ejecucion;
   END IF;

   -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M)
   IF NOT ga_minutos_bolsa_abonado_fn (GN_num_abonado, LN_minutos_plan, LN_minutos_consumidos, LN_minutos_disponible, LN_ind_unidad, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF NOT ga_minutos_promocion_fn (GN_num_abonado, SUBSTR(GN_cod_cliente,LENGTH(GN_cod_cliente),1), SN_minutos_prom, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

/*
   -rast- 13/10/2006 Inc 34629

   IF LN_minutos_plan > LN_minutos_consumidos THEN
      SN_tim_cons_pla := LN_minutos_consumidos;
      SN_tim_cons_npl := 0;
   ELSE
      SN_tim_cons_pla := LN_minutos_plan;
      SN_tim_cons_npl := LN_minutos_consumidos - LN_minutos_plan;
   END IF;

   SN_tim_cons_pla:= ROUND(SN_tim_cons_pla); -- RA-200603090892 PBR 09/03/2006
   SN_tim_cons_npl:= ROUND(SN_tim_cons_npl); -- RA-200603090892 PBR 09/03/2006
*/
   -- -rast- 13/10/2006 Inc 34629
   -- Se devuelven los valores consumidos y disponibles de la bolsa del Plan
   SN_tim_cons_pla:= ROUND(LN_minutos_consumidos);
   SN_tim_cons_npl:= ROUND(LN_minutos_disponible);

   -- 35869 -rast- 04/12/2006 (1 Si es V y 0 Si es M), Se asigna valor a variable de retorno para TRAMA
   SN_ind_unidad:= LN_ind_unidad;

   SN_tim_oper_tot := SN_tim_llam_dat + SN_tim_llam_sal + SN_tim_llam_ent;
   SN_tim_tota_voz := SN_tim_llam_sal + SN_tim_llam_ent;

   --Tiempo Extra Saliente -rast- 28/09/2006
   SN_tim_text_voz := LN_ext_llam_sal + LN_ext_llam_ent;
   SN_val_tota_voz := SN_val_llam_ent + SN_val_llam_sal;
   -- Registro de atención del Cliente
   LV_obs_atencion := 'Se atendió al Celular: ';

   LV_usuario:=NULL;
   LV_sSql:='ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_param_usuario||','||'GE'||','||CN_cod_producto||');';

   IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_param_usuario,'GE',
              CN_cod_producto,LV_usuario,
                       SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
    	SN_cod_retorno:=215;
    	RAISE  error_ejecucion;
   END IF;

   Ga_Segmentacion_Pg.ga_reg_atencion_cliente_pr(EN_num_celular, LN_cod_atencion, LV_obs_atencion, LV_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );

   IF SN_cod_retorno <> 0 THEN
      RAISE error_ejecucion;
   END IF;

   LV_sSql :=  ' SELECT COUNT(1) ' ||
            ' FROM ci_reg_atencion_clientes ' ||
            ' WHERE ' ||
            ' fec_inicio BETWEEN TO_DATE(SYSDATE ' || '00:00:00 ,DD-MM-YYYY HH24:MI:SS' || ' ) ' ||
            ' AND TO_DATE(SYSDATE ' || '23:59:59 ,DD-MM-YYYY HH24:MI:SS' || ' ) ' ||
            ' AND num_abonado  = '||GN_num_abonado  ||
            ' AND cod_atencion = '||LN_cod_atencion;

    SELECT COUNT(1)
   	INTO SN_cont_tasacion
   	FROM CI_REG_ATENCION_CLIENTES
  	WHERE fec_inicio BETWEEN TO_DATE(SYSDATE || ' 00:00:00','DD-MM-YYYY HH24:MI:SS')
    AND TO_DATE(SYSDATE ||' 23:59:59', 'DD-MM-YYYY HH24:MI:SS')
    AND NUM_ABONADO  = GN_num_abonado
    AND cod_atencion = LN_cod_atencion;

  	-- Obtiene prefijo extratiempo
  	IF NOT ga_extra_tiempo_pg.ga_obtiene_prefijo_fn(LV_PREFIJOX,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
       LV_sSql := 'IF NOT ga_extra_tiempo_pg.ga_obtiene_prefijo_fn(LV_PREFIJOX,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO)';
       RAISE error_extratiempo;
    END IF;

  -- Obtiene planes de Extratiempo
  OPEN c_planesx;

  LOOP
	   FETCH c_planesx INTO LV_COD_PLAN;
	   EXIT WHEN c_planesx%NOTFOUND;

	   /* Inicio modificacion by SAQL/Soporte 22/03/2006 - RA-200603140913 */
	   LN_Cursor_EX := 1;
	   /* Fin modificacion by SAQL/Soporte 22/03/2006 - RA-200603140913 */

	   -- Obtiene valores de minutos de extratiempo y bolsa --
	   ga_extra_tiempo_pg.ga_extratiempo_consulta_pr(EN_NUM_CELULAR,
	                      LV_COD_PLAN,
	                FALSE,--Indicador de registro en SAC
	                LN_VAL_MINTOTAL,
	                LN_VAL_USADO,
	                LN_VAL_DISPONIBLE,
	                LN_USADO_BOLSA,
	                LN_DISPONIBLE_BOLSA,
	                SN_COD_RETORNO,
	                SV_MENS_RETORNO,
	                SN_NUM_EVENTO
	                );

	   IF SN_COD_RETORNO != 0 THEN
	      LV_sSql := 'ga_extra_tiempo_pg.ga_extratiempo_consulta_pr(EN_NUM_CELULAR,'
	            ||LV_COD_PLAN||','
	      ||'TRUE,'
	      ||'LN_VAL_MINTOTAL,'
	      ||'LN_VAL_USADO,'
	      ||'LN_VAL_DISPONIBLE,'
	      ||'LN_USADO_BOLSA,'
	      ||'LN_DISPONIBLE_BOLSA,'
	      ||'SN_COD_RETORNO,'
	      ||'SV_MENS_RETORNO,'
	      ||'SN_NUM_EVENTO)';
	      RAISE error_extratiempo;
	   END IF;

	   SN_VAL_MINTOTAL     := SN_VAL_MINTOTAL     + LN_VAL_MINTOTAL;
	   SN_VAL_USADO        := SN_VAL_USADO        + LN_VAL_USADO;
	   SN_VAL_DISPONIBLE   := SN_VAL_DISPONIBLE   + LN_VAL_DISPONIBLE;


  END LOOP;

  CLOSE c_planesx;

  /* Inicio modificacion by SAQL/Soporte 22/03/2006 - RA-200603140913 */
  IF LN_Cursor_EX = 1 THEN
      SN_USADO_BOLSA      := LN_USADO_BOLSA;
      SN_DISPONIBLE_BOLSA := LN_DISPONIBLE_BOLSA;
  ELSE
     IF NOT ge_validaciones_pg.ge_obtiene_ciclofact_fn (GN_cod_ciclo,LN_CicloFacturacion, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO) THEN
      	raise error_ejecucion;
     ELSE

		IF NOT ga_extra_tiempo_pg.ga_minutos_bolsa_fn(LN_CicloFacturacion, GN_num_abonado, SN_USADO_BOLSA, SN_DISPONIBLE_BOLSA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO) THEN
           raise error_ejecucion;
        END IF;

     END IF;
  END IF;
  SN_minutos_prom := 0;
  /* Fin modificacion by SAQL/Soporte 22/03/2006 - RA-200603140913 */

  -- Inicio RA-200603090892 PBR 09/03/2006
  SN_VAL_DISPONIBLE   := ROUND(SN_VAL_DISPONIBLE);
  SN_VAL_USADO        := ROUND(SN_VAL_USADO);
  SN_VAL_MINTOTAL     := ROUND(SN_VAL_MINTOTAL);
  -- Fin RA-200603090892 PBR 09/03/2006

EXCEPTION
   /* Inicio modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
   WHEN retorna_ceros THEN
      SN_tim_llam_ent := 0;
      SN_val_llam_ent := 0;
      SN_tim_llam_sal := 0;
      SN_val_llam_sal := 0;
      SN_tim_llam_dat := 0;
      SN_val_llam_dat := 0;
      SN_tim_tota_voz := 0;
      SN_val_tota_voz := 0;
      SN_tim_oper_tot := 0;
      SN_tim_cons_pla := 0;
      SN_tim_cons_npl := 0;
      SN_minutos_prom := 0;
      SN_VAL_MINTOTAL := 0;
      SN_VAL_USADO := 0;
      SN_VAL_DISPONIBLE := 0;
      SN_USADO_BOLSA := 0;
      SN_DISPONIBLE_BOLSA := 0;
      SN_cod_retorno := 0;
   /* Fin modificacion by SAQL/Soporte 17/03/2006 - RA-200603140913 */
   WHEN error_ejecucion THEN
      LV_des_error := 'ga_consulta_tasacion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN error_abonado THEN
      SN_cod_retorno := 314;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_consulta_tasacion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN error_extratiempo THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
      END IF;
   LV_des_error := 'ga_consulta_tasacion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version||'.'||CV_subversion, USER, 'ga_consumo_pg.ga_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_consulta_tasacion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo, SV_mens_retorno, CV_version, USER, 'ga_consulta_tasacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );



END ga_consulta_tasacion_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END Ga_Consumo_Pg;
/
SHOW ERRORS
