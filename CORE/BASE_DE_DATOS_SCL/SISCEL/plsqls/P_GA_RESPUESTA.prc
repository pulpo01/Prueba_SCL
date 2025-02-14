CREATE OR REPLACE PROCEDURE P_Ga_Respuesta
(
 VP_PRODUCTO IN NUMBER ,
 VP_REG_BMOV IN ICB_MOVIMIENTO%ROWTYPE ,
 VP_REG_CMOV IN ICC_MOVIMIENTO%ROWTYPE ,
 VP_REG_MMOV IN ICM_MOVIMIENTO%ROWTYPE ,
 VP_REG_RMOV IN ICR_MOVIMIENTO%ROWTYPE )
IS
/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = SISCEL."P_Ga_Respuesta" Lenguaje="PL/SQL" Fecha="00-00-000" Versión="1.0" Diseñador="****" Programador="****" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento de control de respuesta de movimientos. El proceso actualiza las tablas del modulo de Gestion de Abonados en funcion de la actuacion realizada. El proceso no devuelve parametros.</Descripción>
<Parámetros>
    <Entrada>
        <param nom="VP_PRODUCTO" Tipo="NUMBER">Código de Producto </param>
        <param nom="VP_REG_BMOV" Tipo="ROWTYPE">Recistro de tabla ICB_MOVIMIENTO </param>
        <param nom="VP_REG_CMOV" Tipo="ROWTYPE">Recistro de tabla ICC_MOVIMIENTO </param>
        <param nom="VP_REG_MMOV" Tipo="ROWTYPE">Recistro de tabla ICM_MOVIMIENTO </param>
        <param nom="VP_REG_RMOV" Tipo="ROWTYPE">Recistro de tabla ICR_MOVIMIENTO </param>
    </Entrada>
    <Salida>    </Salida>
</Parámetros>
</Elemento>
</Documentación>


--
-- Procedimiento de control de respuesta de movimientos. El proceso
-- actualiza las tablas del modulo de Gestion de Abonados en funcion
-- de la actuacion realizada. El proceso no devuelve parametros.
--
-- Modificación : 19-05-2003
-- Responsable : IVUN
-- Modificación : Se agrego  la actualización de retorno para límite de consumo.

-- Modificación : 21-06-2004
-- Responsable : PCR
-- Modificación : Se agrego actuacion para proyecto abono tarjeta RASCA (Actuacion BR )

-- Modificación : 29-06-2004
-- Responsable : JRUZ
-- Modificación : Se  agrega actuación BT . Proyecto  DR_TMM_03051

-- Modificación : 06-09-2004
-- Modificación : Homologaciones HD-200405170764 (CH-200403031710)
--                        HD-200407051044 (TM-200406250787)
--                        HD-200407121085 (TM-200406300803)

-- Modificación : Proyecto MIX-06002 05-09-2006 PAGC
-- Se agrega llamada al procedimiento GA_NUMCEL_PERSONAL_PG.GA_ACTLZA_NUMCEL_PERSONAL_PR
-- para regularizar la tabla GA_NUMCEL_PERSONAL_TO.
-- Se homologa la incidencia CO-200608140314.

 <FECHAMOD> 06-11-2006       </FECHAMOD>
 <AUTORMOD> Zenén Muñoz H. </AUTORMOD>
 <VERSIONMOD>  1.1         </VERSIONMOD>
 <DESCMOD>  Proyecto: P-COL-06051, Se agrega llamada a Procedimiento NP_GESTOR_MAYORISTAS_PG.NP_ACTUALIZAESTADOSERIE_PR, donde se actualiza el estado de una serie mayorista a un pedido </DESCMOD>

 <FECHAMOD> 22-01-2007       </FECHAMOD>
 <AUTORMOD> Zenén Muñoz H. </AUTORMOD>
 <VERSIONMOD>  1.2         </VERSIONMOD>
 <DESCMOD>  Incidencia de homologación: 36916, Se homologa según incidencia de producción: COL-35715 (German Espinoza)</DESCMOD>

-- Modificación : 20-03-2007
-- Responsable : Jubitza Villanueva G,
-- Modificación : Proyecto: P-COL-07002, Se agrega llamada a Procedimiento NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTA_F2_PR, en actuacion CE,SA,BA para tipo de producto 1,

-- Modificación : 02-08-2007
-- Responsable : Jubitza Villanueva G,
-- Modificación : Merge de incidencias 40100,40541,40723,40774,41134--

-- Modificación : 13-10-2011
-- Responsable : GPA
-- Modificación : CSR-11002 INC-176071,Se agrega actabo MH en las llamadas del actabo VO 
*/

   V_FECULTMOD          DATE;
   V_FECSYS             DATE;
   V_ABONADO            ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
   V_ACTUACION          ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
   V_TIPTERM            ICC_MOVIMIENTO.TIP_TERMINAL%TYPE;
   V_CLASEABO           ICC_MOVIMIENTO.COD_SERVICIOS%TYPE;
   V_SUSPREHA           ICC_MOVIMIENTO.COD_SUSPREHA%TYPE;
   V_MOVPOS             ICC_MOVIMIENTO.NUM_MOVPOS%TYPE;
   V_ACTABO             ICC_MOVIMIENTO.COD_ACTABO%TYPE;
   V_PERFIL             GA_ABOCEL.PERFIL_ABONADO%TYPE;
   V_CLASE              GA_ABOCEL.CLASE_SERVICIO%TYPE;
   V_MODULO             ICC_MOVIMIENTO.COD_MODULO%TYPE;
   V_MOVIMIENTO         ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
   V_RESPUESTA          ICC_MOVIMIENTO.DES_RESPUESTA%TYPE;
   V_MSNB               ICC_MOVIMIENTO.NUM_MSNB%TYPE;
   V_SERIE              ICC_MOVIMIENTO.NUM_SERIE%TYPE;
   V_SERIE_OLD          ICC_MOVIMIENTO.NUM_SERIE%TYPE;
   V_PCODE              ICC_MOVIMIENTO.NUM_PERSONAL%TYPE;
   V_USUADORA           ICC_MOVIMIENTO.NOM_USUARORA%TYPE;
   V_FECINGRESO         ICC_MOVIMIENTO.FEC_INGRESO%TYPE;
   V_PLAN               ICC_MOVIMIENTO.PLAN%TYPE;
   V_INDSUSP            NUMBER(1) := 0;
   V_RENT               NUMBER(1) := 0;
   V_ROWID              ROWID;
   V_PROC               VARCHAR2(60);
   V_ABONADO_CHAR       VARCHAR2(8);
   V_NUMTRANSACABO_CHAR VARCHAR(9);
   V_ACTUACION_CHAR     VARCHAR2(5);
   V_RESULTADO          NUMBER(1);
   V_ERROR              VARCHAR2(100);
   V_MSGERROR           VARCHAR2(200);
   V_FECBAJA            GA_ABOCEL.FEC_BAJA%TYPE;
   V_CARGA              ICC_MOVIMIENTO.CARGA%TYPE;
   V_CLIENTE            GA_ABOCEL.COD_CLIENTE%TYPE;
   V_IMSI               ICC_MOVIMIENTO.IMSI%TYPE;
   V_ABONADO_VER        GA_ABOCEL.NUM_ABONADO%TYPE;--CH-061020031379, German Espinoza Zuñiga, 09/10/2003 17:45 Hrs.
   secuencia            NUMBER; -- gbm - 23-09-2003
   retorno              GA_TRANSACABO.COD_RETORNO%TYPE; -- gbm - 23-09-2003 - CH-240720031121
   cadena               GA_TRANSACABO.DES_CADENA%TYPE; -- gbm - 23-09-2003 - CH-240720031121
   V_ICC                ICC_MOVIMIENTO.ICC%TYPE;                                            --       29.06.2004. JRUZ
   V_TIP_TECNOLOGIA     ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE; --       29.06.2004. JRUZ
   -- INI TMM_04026
   V_TECNOLOGIA_GSM     GA_ABOCEL.COD_TECNOLOGIA%TYPE;
   -- FIN TMM_04026

   --Inicio incidencia CO-200608140314 [GSA 30-08-2006, soporte] se comenta inc CO-162
   --Inicio incidencia CO-200605240162 [PAAA 19-06-2006, soporte]
   --V_TOTABO NUMBER;
   --Fin incidencia CO-200605240162
   --Fin incidencia CO-200608140314

   v_tasahibridos VARCHAR2(10); --   Modificación  Facturacion de Trafico Mensajeria preimium para planes hibridos  2005.10.25 JLR

   LV_UsoAbonado ga_abocel.cod_uso%TYPE; --COL-35715: German Espinoza Z; 28/11/2006

   ERROR_PROCESO EXCEPTION;
   V_NUM_CELULAR            ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
   V_NUM_CELULAR_NUE       ICC_MOVIMIENTO.NUM_CELULAR_NUE%TYPE;
   VL_Error                varchar2(150) := '';

   --INI.PAGC 18-04-2007 Cambio tecnologia c/cambio plan
   LV_cod_limcons           ga_limite_cliabo_to.cod_limcons%TYPE;
   LD_fec_hasta            ga_limite_cliabo_to.fec_hasta%TYPE;
   --FIN

   --Inicio P-COL-07002
   SN_cod_retorno      ge_errores_pg.CodError;
   SV_mens_retorno     ge_errores_pg.MsgError;
   SN_num_evento       ge_errores_pg.Evento;
   SV_causa               VARCHAR2(3);
   SV_estado_ini       NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE;
   SR_config_evento    NP_CONFIG_EVENTO_TD%ROWTYPE;
   CV_restitucion       CONSTANT   VARCHAR2(3):='RE';
   V_IMEI_p            ICC_MOVIMIENTO.IMEI%TYPE;
   V_IMEI_NUE_p        ICC_MOVIMIENTO.IMEI_NUE%TYPE;
   V_ICC_p               ICC_MOVIMIENTO.ICC%TYPE;
   V_ICC_NUE_p           ICC_MOVIMIENTO.ICC_NUE%TYPE;
   V_NUM_p               ICC_MOVIMIENTO.NUM_SERIE%TYPE;
   V_cod_cliente_may   ga_abocel.cod_cliente%TYPE;
   --Fin P-COL-07002
   LV_num_ip           PV_IPSERVSUPLABO_TO.NUM_IP%TYPE;


BEGIN
   V_FECSYS         := SYSDATE;
   V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');

   IF VP_PRODUCTO = 1 THEN
      V_MOVPOS    := VP_REG_CMOV.NUM_MOVPOS;
      IF (V_MOVPOS IS NULL) OR (V_MOVPOS =0 ) THEN
         --Inicio incidencia CO-200608140314 [GSA 30-08-2006, soporte] Se comenta incidencia CO-162
         --Inicio incidencia CO-200605240162 [PAAA 19-06-2006, soporte]
         --Se agrega bolque para que se extraiga la cadena de servicios suplementarios desde las tablas de la venta
         --y no desde centrales
         --SELECT COUNT (1)
         -- INTO V_TOTABO
         -- FROM GA_ABOCEL
         -- WHERE NUM_ABONADO =  V_ABONADO;

         -- IF V_TOTABO < 1 THEN
         --   SELECT CLASE_SERVICIO
         --    INTO V_CLASEABO
         --    FROM GA_ABOAMIST
         --    WHERE NUM_ABONADO =  V_ABONADO;
         -- ELSE
         --    SELECT CLASE_SERVICIO
         --    INTO V_CLASEABO
             --    FROM GA_ABOCEL
         --    WHERE NUM_ABONADO =  V_ABONADO;
         -- END IF;
         --Fin incidencia CO-200605240162
         --Fin incidencia CO-200608140314

         V_ABONADO   := VP_REG_CMOV.NUM_ABONADO;
         V_ACTUACION := VP_REG_CMOV.COD_ACTUACION;
         --Inicio incidencia CO-200608140314 [GSA 30-08-2006, soporte] Se quita comentario
         --Inicio incidencia CO-200605240162 [PAAA 19-06-2006, soporte] se comenta traspaso de información desde
         --estructura de centrales
          V_CLASEABO  := VP_REG_CMOV.COD_SERVICIOS;
         --Fin incidencia CO-200605240162
         --Fin incidencia CO-200608140314

         V_SUSPREHA  := VP_REG_CMOV.COD_SUSPREHA;
         V_ACTABO    := VP_REG_CMOV.COD_ACTABO;
         V_MODULO    := VP_REG_CMOV.COD_MODULO;
         V_MOVIMIENTO:= VP_REG_CMOV.NUM_MOVIMIENTO;
         V_RESPUESTA := VP_REG_CMOV.DES_RESPUESTA;
         V_MSNB      := VP_REG_CMOV.NUM_MSNB_NUE;
         V_SERIE     := VP_REG_CMOV.NUM_SERIE_NUE;
         V_SERIE_OLD := VP_REG_CMOV.NUM_SERIE;
         V_PCODE     := VP_REG_CMOV.NUM_PERSONAL_NUE;
         V_TIPTERM   := VP_REG_CMOV.TIP_TERMINAL;
         V_ICC       := VP_REG_CMOV.ICC;
         V_TIP_TECNOLOGIA := VP_REG_CMOV.TIP_TECNOLOGIA;
         V_USUADORA  := VP_REG_CMOV.NOM_USUARORA;
         V_FECINGRESO:= VP_REG_CMOV.FEC_INGRESO;
         V_PLAN      := VP_REG_CMOV.PLAN;
         V_CARGA     := VP_REG_CMOV.CARGA;
         V_NUM_CELULAR    := VP_REG_CMOV.NUM_CELULAR;
         V_NUM_CELULAR_NUE := VP_REG_CMOV.NUM_CELULAR_NUE;

         --Inicio P-COL-07002...
         V_ICC_p     := VP_REG_CMOV.ICC;
         V_ICC_NUE_p := VP_REG_CMOV.ICC_NUE;
         V_IMEI_p     := VP_REG_CMOV.IMEI;
         V_IMEI_NUE_p:= VP_REG_CMOV.IMEI_NUE;
         --Fin P-COL-07002....

         IF V_ABONADO <> 0 THEN
                P_BLOQUEA_ABONADO (V_MODULO, VP_PRODUCTO, V_ACTABO, V_ABONADO);
         END IF;

         IF (V_ACTABO = 'AT' OR V_ACTABO = 'VA' OR V_ACTABO = 'VX' OR 
               V_ACTABO = 'TR' OR V_ACTABO = 'P1' OR V_ACTABO = 'P3' OR
               --INI 06 09 2004 Se agrega actuacion P4- HD-200407051044 - TM-200406250787
               V_ACTABO = 'VD' OR V_ACTABO = 'AJ' OR V_ACTABO = 'P4') THEN
               --FIN 06 09 2004 HD-200407051044 - TM-200406250787

               Pv_Act_Recargaprepago (V_MOVIMIENTO,V_ACTABO,V_CARGA);
         END IF;

         --IF V_ACTABO = 'VO'  OR V_ACTABO = 'V1' THEN CSR-11002 INC-176071
         IF V_ACTABO = 'VO'  OR V_ACTABO = 'V1' OR V_ACTABO = 'MH' THEN
            /* Venta celular en oficina */

            P_ALTA_CELULAR_OFI(V_ABONADO,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);
            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,1,V_CLASEABO,V_SERIE_OLD,V_SERIE );
         ELSIF V_ACTABO = 'PP' THEN
            /*Orden de Servicio*/
            NULL;
            --  21 06 2004 Proyecto Abono Tarjeta RASCA (PCR)
         ELSIF V_ACTABO = 'BR' THEN
            NULL;
            -- fin
            -- INI 29 07 2004. Proyecto FASE II ALTAMIRA.
         -- INI.PROYECTO INTEGRACION SCL ATLANTIDA
         ELSIF V_ACTABO = 'I1' OR  V_ACTABO = 'I2' OR  V_ACTABO = 'I3' THEN
            /*Cambio de Limite , Alta de Cuenta o Cambio Límite Empresa*/
            NULL;
         -- FIN.PROYECTO INTEGRACION SCL ATLANTIDA
         ELSIF V_ACTABO = 'CU' THEN
            /*Cambio de Umbral */
            NULL;
         ELSIF V_ACTABO = 'BS' THEN
            /*Abono de SMS */
            NULL;
            -- fin.
         ELSIF V_ACTABO = 'FJ' THEN
            /*Asignacion de IP_FIJA*/
            /*NULL;*/

            select A.num_ip
            INTO LV_num_ip
            from PV_IPSERVSUPLABO_TO A
            where A.num_abonado= V_ABONADO
            AND SUBSTR(A.num_ip,1,3) IN (select SUBSTR(C.OCTETO_1,1,3) from  AIP_IP_TO C
                                      WHERE
                                      C.OCTETO_1    =SUBSTR(A.num_ip,1,3)
                                      AND C.OCTETO_2=SUBSTR(A.num_ip,5,3)
                                      AND C.OCTETO_3=SUBSTR(A.num_ip,9,3)
                                      AND C.OCTETO_4=SUBSTR(A.num_ip,13,3)
                                      AND C.COD_ESTADO_IP=3
                                      );



            pv_ipfija_pg.pv_cambiar_estado_ip_pr(LV_num_ip, V_NUM_CELULAR, 'ESTADO_USO', SN_cod_retorno, SV_mens_retorno, SN_num_evento);
            -- fin.
         ELSIF V_ACTABO = 'AL' THEN -- XO-200508190402 Christian Estay M. 22-08-2005
                     /*Abono de cambio de plan por articulo */
                    NULL;
           -- fin.
         ELSIF V_ACTABO = 'DC' THEN
            /*Dias de caducidad por Proyecto Integración SCL-Altamira fase IV*/
            NULL;
         ELSIF V_ACTABO = 'TN' THEN
            /*Propiedades de Notificación, por Proyecto Integración SCL-Altamira fase IV*/
            NULL;
         ELSIF V_ACTABO = 'R5' THEN
            /*Periodo validez recarga, por Proyecto Integración SCL-Altamira fase IV*/
            NULL;
         ELSIF V_ACTABO = 'ID' THEN
            /*Cambio de Idioma, por Proyecto Integración SCL-Altamira fase IV*/
            NULL;
         ELSIF V_ACTABO = 'VC' OR V_ACTABO = 'V3' THEN

            /* Venta celular en oficina CTC */
            P_ALTA_CELULAR_CTC        (V_ABONADO  ,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO  ,V_CLASEABO,V_FECSYS);
            P_CONFIRMAR_VENTA         (VP_PRODUCTO,V_ABONADO ,V_FECSYS);

         ELSIF V_ACTABO = 'VM' THEN

            /* Venta celular en oficina Movivox */
            P_ALTA_CELULAR_OFI        (V_ABONADO,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);

         ELSIF  V_ACTABO = 'V7' OR V_ACTABO='VA' OR V_ACTABO = 'VX' OR  V_ACTABO='VD' THEN

            /* Venta Contrato en oficina */
            P_MODIFICA_ESTADOABO      (VP_PRODUCTO, V_ABONADO , V_INDSUSP, V_RENT, V_FECSYS);
            P_ALTA_CELULAR_PREPAGO    (V_ABONADO  , V_CLASEABO, V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO  , V_CLASEABO, V_FECSYS);
            PV_PR_RESP_CENTRAL(V_MOVIMIENTO);

            --INI Homologacion HD-200405170764 - Incidencia CH-200403031710
            P_RECUPERA_PERFILABO      (VP_PRODUCTO, V_ABONADO , V_PERFIL  , V_CLASE , V_RENT, V_FECSYS);
            P_ACTUALIZA_PERFIL        (VP_PRODUCTO, V_ABONADO , V_CLASEABO, V_PERFIL, V_RENT, V_FECSYS);
            --FIN Homologacion HD-200405170764 - Incidencia CH-200403031710

            --OCB-INI-TMM-04010
            GA_HIST_MIGR_PG.GA_ACT_INGRESO_SS_PR ( V_ACTABO, V_ABONADO, VP_REG_CMOV.NUM_CELULAR );
            --OCB-FIN-TMM-04010
            -- Inicio : COL-06051, determina que en una serie se ha realizado una activación, Fecha: 13-11-2006
            IF (V_ACTABO = 'VA' OR V_ACTABO = 'VX') Then
                  NP_GESTOR_MAYORISTAS_PG.NP_ACTUALIZAESTADOSERIE_PR(V_SERIE, V_ABONADO, VL_Error);
                  if VL_Error <> '' then
                       RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||VL_Error);
                  end if;
            END if;
            -- Fin : COL-06051

         ELSIF V_ACTABO = 'AT' OR V_ACTABO = 'V8' OR V_ACTABO='V9' THEN

            /* Venta AMISTAR en terreno */
            P_ALTA_CELULAR_SAV        (V_ABONADO,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);

         ELSIF V_ACTABO = 'TD' OR V_ACTABO = 'V4' THEN

            /* Venta celular en oficina uso Cuenta controlada*/
            P_ALTA_CELULAR_OFI        (V_ABONADO,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);

            --Inicio incidencia CO-200608140314 (GSA 30-08-2006 Soporte) se quita comentario
            --Inicio incidencia CO-200605240162 NRCA
         ELSIF V_ACTABO = 'VT' OR V_ACTABO = 'V2' THEN

         --ELSIF V_ACTABO = 'VT' OR V_ACTABO = 'V2' OR V_ACTABO = 'HH' THEN
         --Fin incidencia CO-200605240162 NRCA
         --Fin incidencia CO-200608140314

            /* Venta celular en terreno */
            P_ALTA_CELULAR_SAV        (V_ABONADO   ,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO   ,V_CLASEABO,V_FECSYS);
            P_IC_ACTUALIZA_AKEYS      (V_MOVIMIENTO,V_ACTABO  ,1       ,V_CLASEABO,V_SERIE_OLD,V_SERIE );

         ELSIF V_ACTABO = 'TT' OR V_ACTABO = 'V5' THEN

            /* Venta celular en terreno uso Cuenta controlada*/
            P_ALTA_CELULAR_SAV        (V_ABONADO,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);

         ELSIF V_ACTABO = 'RV' THEN

            /* Rechazo de venta celular */
            P_RECHAZO_VENTA   (VP_PRODUCTO,V_ABONADO,V_FECSYS);
            P_CIERRA_SERVICIOS(V_ABONADO  ,V_FECSYS);

            --Inicio P-COL-07002 Liq.Mayorista Fase 2.
            --Para la serie...
            V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR';
            NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR(V_ABONADO,V_ACTABO,V_SERIE_OLD,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            --Para el imei...
            IF TRIM(V_IMEI_p) IS NOT NULL THEN
                V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR';
                NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR(V_ABONADO,V_ACTABO,V_IMEI_p,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            END IF;
            --Fin P-COL-07002.

         ELSIF V_ACTABO = 'NU' THEN
            /* Anulacion de venta en Terreno */
            /* No hay que hacer nada */
            NULL;

         ELSIF V_ACTABO = 'CP' THEN
            /* Anulacion de venta en Terreno */
            /* No hay que hacer nada */
            NULL;

         ELSIF V_ACTABO = 'AV' THEN
            /* Aceptacion de venta celular */
            P_CONFIRMAR_VENTA(VP_PRODUCTO,V_ABONADO,V_FECSYS);

         ELSIF V_ACTABO = 'GB' THEN

            /* Tratamiento servicios suplementarios */
            P_RECUPERA_PERFILABO (VP_PRODUCTO ,V_ABONADO,V_PERFIL  ,V_CLASE   , V_RENT,V_FECSYS);
            P_PROCESO_SERVICIOS  (VP_PRODUCTO ,V_ABONADO,V_CLASEABO,V_FECSYS);
            P_ACTUALIZA_PERFIL   (VP_PRODUCTO ,V_ABONADO,V_CLASEABO,V_PERFIL  , V_RENT,V_FECSYS);
            P_LIMPIAR_CLASEABO   (VP_PRODUCTO ,V_ABONADO,V_CLASE);
            P_IC_ACTUALIZA_AKEYS (V_MOVIMIENTO,V_ACTABO ,0         ,V_CLASEABO, V_SERIE_OLD,V_SERIE );
            PV_PR_RESP_CENTRAL   (V_MOVIMIENTO);
            --OCB-INI-TMM-04010
            GA_HIST_MIGR_PG.GA_ACT_INGRESO_NFREC_PR ( V_ACTABO, V_ABONADO, V_MOVIMIENTO );
            --OCB-FIN-TMM-04010

         -- Inicio Fase III Integracion SCL - Altamira
         ELSIF V_ACTABO = 'SX' THEN

            /* Tratamiento servicios suplementarios TUXEDO*/
            P_RECUPERA_PERFILABO (VP_PRODUCTO ,V_ABONADO,V_PERFIL  ,V_CLASE   , V_RENT    ,V_FECSYS);
            P_PROCESO_SERVICIOS  (VP_PRODUCTO ,V_ABONADO,V_CLASEABO,V_FECSYS);
            P_ACTUALIZA_PERFIL   (VP_PRODUCTO ,V_ABONADO,V_CLASEABO,V_PERFIL  , V_RENT    ,V_FECSYS);
            P_LIMPIAR_CLASEABO   (VP_PRODUCTO ,V_ABONADO,V_CLASE);
            P_IC_ACTUALIZA_AKEYS (V_MOVIMIENTO,V_ACTABO ,0         ,V_CLASEABO,V_SERIE_OLD,V_SERIE );
            PV_PR_RESP_CENTRAL(V_MOVIMIENTO);
            -- Fin Fase III Integracion SCL - Altamira

         --ELSIF V_ACTABO = 'SI' THEN
         --      NULL;
         -- HOM. HC-251120030175, RACB -> SE ELIMINA CONDICIÓN V_ACTABO='SI' POR ENCONTRARSE EN BLOQUE POSTERIOR. SOPORTE RYC 19-11-2003 R.V.R. TM-81
         ELSIF V_ACTABO = 'SP'  THEN

            /* Tratamiento suspensiones parciales */
            P_RECUPERA_PERFILABO   (VP_PRODUCTO,V_ABONADO,V_PERFIL  , V_CLASE , V_RENT  ,V_FECSYS);
            P_PROCESO_SUSPENSIONES (VP_PRODUCTO,V_ABONADO,V_SUSPREHA, V_MODULO, V_FECSYS,V_ROWID);
            P_ACTUALIZA_PERFIL     (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL ,V_RENT   ,V_FECSYS);
         -- HOM TM-200406300803, German Espinoza Z; 05/07/2004

         -- INI 06 09 2004 Se agregan dos actabos el S5 y S6 -- HD-200407121085 - TM-200406300803

         ELSIF V_ACTABO = 'S7' OR V_ACTABO = 'S8' OR V_ACTABO = 'S9' THEN

            /* Tratamiento suspensiones UNIDIRECCIONAL */
            P_VALIDA_SUSPENSIONES_PARCIAL (V_ABONADO  ,V_INDSUSP);
            P_RECUPERA_PERFILABO  (VP_PRODUCTO,V_ABONADO,V_PERFIL  ,V_CLASE ,V_RENT  ,V_FECSYS);
            P_PROCESO_SUSPENSIONES(VP_PRODUCTO,V_ABONADO,V_SUSPREHA,V_MODULO,V_FECSYS,V_ROWID);
            P_ACTUALIZA_PERFIL    (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT  ,V_FECSYS);
            P_MODIFICA_ESTADOABO  (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS,1,V_MODULO);
            PV_PR_RESP_CENTRAL(V_MOVIMIENTO);


         ELSIF V_ACTABO = 'ST' OR V_ACTABO = 'SV' OR V_ACTABO = 'EN' OR V_ACTABO = 'SB' OR V_ACTABO = 'SU' OR V_ACTABO = 'SI' OR V_ACTABO = 'SL' OR V_ACTABO = 'SN' OR V_ACTABO = 'BD' OR V_ACTABO = 'S5' OR V_ACTABO = 'S6'THEN
         -- FIN 06 09 2004 Se agregan dos actabos el S5 y S6 -- HD-200407121085 - TM-200406300803
            /* Tratamiento suspensiones totales */
            P_VALIDA_SUSPENSIONES (V_ABONADO  ,V_INDSUSP);
            P_RECUPERA_PERFILABO  (VP_PRODUCTO,V_ABONADO,V_PERFIL  ,V_CLASE ,V_RENT  ,V_FECSYS);
            P_PROCESO_SUSPENSIONES(VP_PRODUCTO,V_ABONADO,V_SUSPREHA,V_MODULO,V_FECSYS,V_ROWID);
            P_ACTUALIZA_PERFIL    (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT  ,V_FECSYS);
            ------------------------------
            -- MOdificacion proyecto ECU - COL CEM
            P_MODIFICA_ESTADOABO  (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS,1,V_MODULO);
            ---------------------------
            PV_PR_RESP_CENTRAL(V_MOVIMIENTO);

         ELSIF V_ACTABO = 'RP' THEN
            /* Tratamiento rehabilitaciones parciales */
            P_RECUPERA_PERFILABO      (VP_PRODUCTO,V_ABONADO,V_PERFIL  ,V_CLASE ,V_RENT  ,V_FECSYS);
            P_PROCESO_REHABILITACIONP (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,V_MODULO,V_FECSYS);
            P_ACTUALIZA_PERFIL        (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT  ,V_FECSYS);

         ELSIF V_ACTABO = 'RT' OR V_ACTABO = 'DN' OR V_ACTABO = 'RI' OR V_ACTABO = 'RC' OR V_ACTABO = 'RU' OR V_ACTABO = 'RL' OR V_ACTABO = 'RF' OR V_ACTABO = 'RN' OR V_ACTABO = 'AD' THEN
            /* Tratamiento rehabilitaciones totales */
            P_RECUPERA_PERFILABO      (VP_PRODUCTO,V_ABONADO,V_PERFIL  ,V_CLASE ,V_RENT  ,V_FECSYS);
            P_PROCESO_REHABILITACIONT (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,V_MODULO,V_FECSYS,V_ROWID);
            P_ACTUALIZA_PERFIL        (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT  ,V_FECSYS);
            P_HISTORICO_SUSPENSIONES  (V_ROWID    ,V_FECSYS);
            P_VALIDA_SUSPENSIONES     (V_ABONADO  ,V_INDSUSP);
            ------------------------------
            -- MOdificacion proyecto ECU - COL CEM
            P_MODIFICA_ESTADOABO      (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS,1,V_MODULO);
            PV_PR_RESP_CENTRAL        (V_MOVIMIENTO);

         ELSIF V_ACTABO = 'MJ' OR V_ACTABO = 'MH' OR V_ACTABO = 'MI' OR V_ACTABO = 'MS' THEN
            /* Mensajeria Cobranza */
            NULL;

         ELSIF V_ACTABO = 'PR' THEN --TMM-189330(MA)|25-10-2012|GEZ.
            NULL;                   --TMM-189330(MA)|25-10-2012|GEZ.

         ELSIF V_ACTABO = 'BA' OR V_ACTABO = 'BF'  THEN
            /* Baja de abonados */
            P_BAJA_ABONADOCEN(VP_PRODUCTO,V_ABONADO,V_FECSYS);

            --Inicio modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842
            P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
            --Fin modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS,1,V_MODULO);
            ---------------------------
            PV_PR_RESP_CENTRAL(V_MOVIMIENTO);

            -- Inicio Modificación - GBM - TM-200408250915 - 14-10-2004
            P_PROCESO_SERVICIOS(VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
            -- Fin Modificación - GBM - TM-200408250915 - 14-10-2004
            /* Inicio Modificación GBM 23-09-2003 - CH-240720031121 */
            BEGIN
               SELECT GA_SEQ_TRANSACABO.NEXTVAL
               INTO secuencia
               FROM DUAL;

               CO_BAJAS_ABO(secuencia,V_ABONADO,'BAJA');

               SELECT COD_RETORNO, DES_CADENA
               INTO retorno, cadena
               FROM GA_TRANSACABO
               WHERE NUM_TRANSACCION = secuencia;

               DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = secuencia;

               IF retorno <> 0 THEN
                  RAISE ERROR_PROCESO;
               END IF;

            EXCEPTION
               WHEN ERROR_PROCESO THEN
                    RAISE_APPLICATION_ERROR(-20203, V_PROC||'(CO_BAJAS_ABO):' || TO_CHAR(RETORNO) || ' ' || CADENA);
               WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||SQLERRM);
            END;
            /* Fin Modificación GBM 23-09-2003 - CH-240720031121 */
            /* Tarjeta Club */
            BEGIN
                V_ACTUACION_CHAR := TO_CHAR(V_ACTUACION);
                V_ABONADO_CHAR := TO_CHAR(V_ABONADO);

                P_AL_INTERFAZ_CLUB(V_ABONADO_CHAR,V_USUADORA,NULL,V_ACTUACION_CHAR,V_ACTABO);
            EXCEPTION
               WHEN OTHERS THEN
                   NULL;
            END;
            /*Autenticacion*/
            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,2,V_CLASEABO,V_SERIE_OLD,V_SERIE );
            -- Inicio modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842


         --ELSIF V_ACTABO = 'BP' OR V_ACTABO = 'BE' OR V_ACTABO = 'B3' THEN
         ELSIF V_ACTABO = 'BP' OR V_ACTABO = 'BE' OR V_ACTABO = 'B3' THEN

            -- Inicio modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842
            /* Baja Prepago */
            V_PROC := 'Problemas al insertar fecha baja en central';
            SELECT FEC_BAJA,cod_uso INTO V_FECBAJA,LV_UsoAbonado  --COL-35715|28-11-2006|GEZ
              FROM GA_ABOAMIST
             WHERE NUM_ABONADO = V_ABONADO
            union
            SELECT FEC_BAJA,cod_uso--COL-35715: German Espinoza Z; 28/11/2006
              FROM GA_ABOCEL
             WHERE NUM_ABONADO = V_ABONADO;

            IF V_FECBAJA <> '' OR V_FECBAJA IS NOT NULL THEN
               P_BAJA_ABONADOCEN(VP_PRODUCTO,V_ABONADO,V_FECSYS);
            END IF;

            --   INI - SP - a solicitud de TMCOL se saca incidencia 35715 del proyecto p-col-07003 por no estar este código en producción.
            --   18-05-2007

            --    --XO-200509290765: German Espinoza Z; 30/09/2005
            IF GE_FN_DEVVALPARAM('GA', 1, 'RESP_BAJA_ALTAMIRA')=0 THEN

--                 --INI/COL-35715: German Espinoza Z; 28/11/2006
--                 --UPDATE ga_aboamist
--                         --SET cod_situacion='BAA'
--                         --WHERE num_abonado = V_ABONADO;
--
                 IF LV_UsoAbonado=GE_FN_DEVVALPARAM('GA', 1, 'USO_PREPAGO') THEN

                   UPDATE ga_aboamist
                      SET cod_situacion='BAA'
                    WHERE num_abonado = V_ABONADO;

                   ELSIF LV_UsoAbonado=GE_FN_DEVVALPARAM('GA', 1, 'USO_HIBRIDO_GSM_TDMA') THEN
                   UPDATE ga_abocel
                      SET cod_situacion='BAA'
                    WHERE num_abonado = V_ABONADO;

                 --INI 40541-COL|16-05-2007|PCR
                ELSE
                    UPDATE ga_abocel
                       SET cod_situacion='BAA'
                     WHERE num_abonado = V_ABONADO;
                --FIN 40541-COL|16-05-2007|PCR

                 END IF;

--               --FIN/COL-35715: German Espinoza Z; 28/11/2006

              ELSE
                P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
              END IF;
              --     XO-200509290765: German Espinoza Z; 30/09/2005
              --
              --     FIN - SP - a solicitud de TMCOL se saca incidencia 35715 del proyecto p-col-07003 por no estar este código en producción.

              P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);

              --XO-200509290765: German Espinoza Z; 30/09/2005
              P_PROCESO_SERVICIOS(VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);--COL-35715|28-11-2006|GEZ

              --INI Homologacion HD-200405170764 - Incidencia CH-200403031710

              P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,V_RENT,V_FECSYS);
              P_ACTUALIZA_PERFIL   (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT,V_FECSYS);
              --FIN Homologacion HD-200405170764 - Incidencia CH-200403031710


         ELSIF V_ACTABO = 'BM' THEN

            /* Baja masiva de abonados */
            P_BAJA_ABONADOCEN(VP_PRODUCTO,V_ABONADO,V_FECSYS);
            P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
            /* Inicio Modificación GBM 23-09-2003 - CH-240720031121 */
                BEGIN
                        SELECT GA_SEQ_TRANSACABO.NEXTVAL
                        INTO secuencia
                        FROM DUAL;

                        CO_BAJAS_ABO(secuencia,V_ABONADO,'BAJA');

                        SELECT COD_RETORNO, DES_CADENA
                        INTO retorno, cadena
                        FROM GA_TRANSACABO
                        WHERE NUM_TRANSACCION = secuencia;

                        DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = secuencia;

                        IF retorno <> 0 THEN
                           RAISE ERROR_PROCESO;
                        END IF;

                EXCEPTION
                     WHEN ERROR_PROCESO THEN
                          RAISE_APPLICATION_ERROR(-20203, V_PROC||'(CO_BAJAS_ABO):' || TO_CHAR(RETORNO) || ' ' || CADENA);
                     WHEN OTHERS THEN
                          RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||SQLERRM);
                END;

            /* Fin Modificación GBM 23-09-2003 - CH-240720031121 */
            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,2,V_CLASEABO,V_SERIE_OLD,V_SERIE );

         ELSIF V_ACTABO = 'AB' THEN

            /* Anulacion de  baja de abonados */
            P_VALIDA_SUSPENSIONES (V_ABONADO  ,V_INDSUSP);
            P_MODIFICA_ESTADOABO  (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);

            -- Inicio Modificación - GBM - TM-200408250915 - 14-10-2004
            P_PROCESO_SERVICIOS   (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
            -- Fin Modificación - GBM - TM-200408250915 - 14-10-2004

            /* Inicio Modificación GBM 23-09-2003 - CH-240720031121 */
            BEGIN
                 SELECT GA_SEQ_TRANSACABO.NEXTVAL
                 INTO secuencia
                 FROM DUAL;

                 CO_BAJAS_ABO(secuencia,V_ABONADO,'ALTA');

                 SELECT COD_RETORNO, DES_CADENA
                 INTO retorno, cadena
                 FROM GA_TRANSACABO
                 WHERE NUM_TRANSACCION = secuencia;

                 DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = secuencia;

                 IF retorno <> 0 THEN
                    RAISE ERROR_PROCESO;
                 END IF;

            EXCEPTION
               WHEN ERROR_PROCESO THEN
                    RAISE_APPLICATION_ERROR(-20203, V_PROC||'(CO_BAJAS_ABO):' || TO_CHAR(RETORNO) || ' ' || CADENA);
               WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||SQLERRM);
            END;

            /* Fin Modificación GBM 23-09-2003 - CH-240720031121 */
            /* Tarjeta Club */
            BEGIN
               V_ABONADO_CHAR := TO_CHAR(V_ABONADO);
               P_AL_INTERFAZ_CLUB(V_ABONADO_CHAR,V_USUADORA,NULL,NULL, V_ACTABO);
            EXCEPTION
              WHEN OTHERS THEN
                 NULL;
            END;
            /*Autenticacion*/
            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,0,V_CLASEABO,V_SERIE_OLD,V_SERIE);

         ELSIF V_ACTABO = 'AF' THEN
            /* Anulacion de  baja Final */
            P_VALIDA_SUSPENSIONES (V_ABONADO  ,V_INDSUSP);
            --Modificación por Proyecto ECU-COL 'CEM'
            P_MODIFICA_ESTADOABO  (VP_PRODUCTO,V_ABONADO,V_INDSUSP, V_RENT,V_FECSYS,1,V_MODULO);
            ---------------------------

            -- Inicio Requerimiento de Soporte #74371 MGG 18-12-2008
            P_PROCESO_SERVICIOS(VP_PRODUCTO  ,V_ABONADO,V_CLASEABO,V_FECSYS);
            -- Fin Requerimiento de Soporte #74371 MGG 18-12-2008

            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,1,V_CLASEABO,V_SERIE_OLD,V_SERIE);

            --OCB-INI-TMM-04010
            GA_HIST_MIGR_PG.GA_ACT_INGRESO_SS_PR ( V_ACTABO, V_ABONADO, VP_REG_CMOV.NUM_CELULAR );
            --OCB-FIN-TMM-04010

         ELSIF V_ACTABO = 'AP' THEN

            /* Anulacion de  baja de abonados prepago */
            P_VALIDA_SUSPENSIONES (V_ABONADO  ,V_INDSUSP);
            P_MODIFICA_ESTADOABO  (VP_PRODUCTO,V_ABONADO,V_INDSUSP, V_RENT,V_FECSYS);

--INI. PAGC 18-04-2007
-- Agregar actuación T3 de cambio de tecnologia TDMA a GSM c/cambio de plan ...
--         ELSIF V_ACTABO = 'CE' OR V_ACTABO = 'GT' OR V_ACTABO = 'TG' OR V_ACTABO = 'ET' OR V_ACTABO = 'EG' OR V_ACTABO = 'SA' OR V_ACTABO = 'SD' THEN
         ELSIF V_ACTABO = 'CE' OR V_ACTABO = 'GT' OR V_ACTABO = 'TG' OR V_ACTABO = 'ET' OR V_ACTABO = 'EG' OR V_ACTABO = 'SA' OR V_ACTABO = 'SD' OR V_ACTABO = 'T3' OR V_ACTABO = 'T4' THEN
--FIN
            /* Cambio de serie o equipo */
            P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
            IF V_CLASEABO IS NOT NULL THEN
               P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL  ,V_CLASE ,V_RENT,V_FECSYS);
               P_PROCESO_SERVICIOS  (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
               P_ACTUALIZA_PERFIL   (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT,V_FECSYS);
            END IF;

            P_MODIFICA_ESTADOABO    (VP_PRODUCTO ,V_ABONADO,V_INDSUSP,V_RENT    ,V_FECSYS);
            /*Autenticacion*/
            P_IC_ACTUALIZA_AKEYS    (V_MOVIMIENTO,V_ACTABO ,3        ,V_CLASEABO,V_SERIE_OLD,V_SERIE);

            --Homologacion 14-10-2003 RACB */
            /* Llamamos al pl para la intarcel CEM */
            --incidencia CH-061020031379, German Espinoza Zuñiga, 09/10/2003 17:45 Hrs.
            BEGIN
                        SELECT NUM_ABONADO
                        INTO V_ABONADO_VER
                        FROM GA_ABOCEL
                        WHERE NUM_ABONADO=V_ABONADO;
              --incidencia CH-061020031379, German Espinoza Zuñiga, 09/10/2003 17:45 Hrs.


--INI. PAGC 18-04-2007
-- Agregar actuación T3 de cambio de tecnologia TDMA a GSM c/cambio de plan ...
--                     IF V_ACTABO = 'GT' OR V_ACTABO = 'ET' OR V_ACTABO = 'EG' OR V_ACTABO = 'TG' THEN
                       IF V_ACTABO = 'GT' OR V_ACTABO = 'ET' OR V_ACTABO = 'EG' OR V_ACTABO = 'TG' OR V_ACTABO = 'T3' THEN
                       IF V_ACTABO = 'GT' OR V_ACTABO = 'ET' THEN   -- A TDMA
                            SELECT COD_CLIENTE,NULL
                            INTO V_CLIENTE,V_IMSI
                            FROM GA_ABOCEL
                            WHERE NUM_ABONADO = V_ABONADO;
--INI. PAGC 18-04-2007
-- Agregar actuación T3 de cambio de tecnologia TDMA a GSM c/cambio de plan ...
                             --ELSIF V_ACTABO = 'EG' OR V_ACTABO = 'TG' THEN -- A GSM
                       ELSIF V_ACTABO = 'EG' OR V_ACTABO = 'TG' OR V_ACTABO = 'T3' THEN -- A GSM
                            SELECT COD_CLIENTE,FN_RECUPERA_IMSI(NUM_SERIE)
                            INTO V_CLIENTE,V_IMSI
                            FROM GA_ABOCEL
                            WHERE NUM_ABONADO = V_ABONADO;
                       END IF;

                       SELECT TO_CHAR(GA_SEQ_TRANSACABO.NEXTVAL)
                       INTO V_NUMTRANSACABO_CHAR
                        FROM DUAL;

                       P_ACTZA_IMSI_INTARCEL(V_NUMTRANSACABO_CHAR,V_CLIENTE,V_ABONADO,V_IMSI);

                       --INI. PAGC 18-04-2007 Cambio de tecnologia TDMA a GSM c/cambio de plan
                       -- Debemos actualizar nuevo plan y limite de consumo por cambio de Tecnologia c/cambio de plan (T3) --
                       IF V_ACTABO = 'T3' THEN

                             BEGIN
                            SELECT cod_limcons
                            INTO LV_cod_limcons
                            FROM tol_limite_plan_td
                            WHERE cod_plantarif = V_PLAN
                            AND SYSDATE BETWEEN FEC_DESDE
                            AND NVL(fec_hasta, SYSDATE)
                            AND ind_default = 'S';
                           EXCEPTION
                                     WHEN NO_DATA_FOUND THEN
                                   RAISE_APPLICATION_ERROR(-20205, 'No existe limite consumo: tol_limite_plan_td.cod_plantarif=' || V_PLAN);
                             END;

                          BEGIN
                                  SELECT fec_hasta INTO LD_fec_hasta
                                FROM ga_limite_cliabo_to
                                WHERE cod_cliente = V_CLIENTE
                                AND num_abonado = V_ABONADO
                                AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);

                                UPDATE ga_limite_cliabo_to
                                SET fec_hasta = V_FECSYS
                                WHERE cod_cliente = V_CLIENTE
                                AND num_abonado = V_ABONADO
                                AND SYSDATE BETWEEN fec_desde AND NVL(fec_hasta,SYSDATE);

                                INSERT INTO  ga_limite_cliabo_to
                                (cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta,
                                     nom_usuarora,fec_asignacion,cod_plantarif)
                                VALUES
                                (V_CLIENTE,V_ABONADO,LV_cod_limcons,SYSDATE,LD_fec_hasta,
                                USER,SYSDATE,V_PLAN);

                                IF LD_fec_hasta IS NOT NULL THEN
                                    UPDATE ga_limite_cliabo_to
                                           SET cod_plantarif = V_PLAN
                                    WHERE cod_cliente = V_CLIENTE
                                    AND num_abonado = V_ABONADO
                                    AND fec_desde > NVL(fec_hasta,SYSDATE);
                                END IF;

                          EXCEPTION
                                     WHEN NO_DATA_FOUND THEN
                                   --No existe registro debemos insertarlo
                                   INSERT INTO  ga_limite_cliabo_to
                                   (cod_cliente, num_abonado, cod_limcons, fec_desde,
                                      nom_usuarora,fec_asignacion,cod_plantarif)
                                   VALUES
                                   (V_CLIENTE,V_ABONADO,LV_cod_limcons,SYSDATE,
                                   USER,SYSDATE,V_PLAN);
                          END;


                       END IF;
                       --FIN --

                   END IF;
              --incidencia CH-061020031379, German Espinoza Zuñiga, 09/10/2003 17:45 Hrs.
                EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                     NULL;
              END;
             --fin modificacion CH-061020031379
             --Fin Homologacion 14-10-2003 RACB */

                     --Inicio P-COL-07002 Liq.Mayorista Fase 2.
                                                V_NUM_p:=NULL;
                        IF TRIM(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TIP_TECNOLOGIA)) = TRIM(V_TECNOLOGIA_GSM)  THEN
                                                         --Es GSM y utiliza ICC, ICC_NUE, IMEI,IMEI_NUE...
                                                         IF V_ICC_NUE_p IS NOT NULL AND V_ICC_p <> V_ICC_NUE_p  THEN
                                                                        V_NUM_p:=V_ICC_NUE_p;
                                                         ELSE
                                                                     IF V_IMEI_NUE_p IS NOT NULL AND V_IMEI_p <> V_IMEI_NUE_p  THEN
                                                                           V_NUM_p:=V_IMEI_NUE_p;
                                                                        END IF;
                                                            END IF;
                                                ELSE
                                                            V_NUM_p:=V_SERIE;
                                                END IF;

                                                IF V_NUM_p IS NOT NULL THEN
                                                            --Obtener causa del cambio.....
                                                            SV_causa:='0';
                                                            SN_cod_retorno:=0;
                                                            SV_mens_retorno:=NULL;
                                                            SN_num_evento:=0;
                                                         V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CAUSA_CAMBIO_FN';
                                                            IF NOT NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CAUSA_CAMBIO_FN(V_ABONADO,V_NUM_p,SV_causa,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                               NULL;
                                                            END IF;

                                                            IF SV_causa IS NULL THEN
                                                               SV_causa:='0';
                                                            END IF;

                                                            V_cod_cliente_may:=NULL;
                           IF LTRIM(RTRIM(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TIP_TECNOLOGIA))) = LTRIM(RTRIM(V_TECNOLOGIA_GSM))  THEN
                                                                                --Inicio Cambio nro de simcard
                                                                                IF V_ICC_NUE_p IS NOT NULL AND V_ICC_p <> V_ICC_NUE_p THEN
                                                                                                    --Nueva cambia al estado que corresponda y si cambia a PE debe registrar los precios...
                                                                                                    --Obtener estado de la nueva en el ultimo pedido de mayorista..
                                                                                                    --Si no existe en mayorista entonces no hace nada.
                                                                                                    SV_estado_ini:=NULL;
                                                                                                    V_cod_cliente_may:=NULL;
                                                                                                    begin
                                                                                                                    SELECT C.COD_ESTADO,C.COD_CLIENTE INTO SV_estado_ini,V_cod_cliente_may
                                                                                                                       FROM NPT_PEDIDO A,NP_DETSER_ACTVTA_MAYORISTAS_TO C
                                                                                                                    WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO)
                                                                                                     FROM NPT_SERIE_PEDIDO A
                                                                                                    WHERE A.COD_SERIE_PEDIDO = V_ICC_NUE_p)
                                                                                                                                        AND C.COD_CLIENTE=A.cod_cliente
                                                                                                                                  AND C.COD_PEDIDO=A.COD_PEDIDO
                                                                                                                                        AND C.NUM_SERIE=V_ICC_NUE_p;
                                                                                                    exception
                                                                                                    when others then
                                                                                                          SV_estado_ini:=NULL;
                                                                                                    end;

                                                                                                    IF SV_estado_ini IS NOT NULL THEN
                                                                                                                --Obtener conf. del evento para validar si cambiará a PE.
                                                                                                                SN_cod_retorno:=0;
                                                                                                                SV_mens_retorno:=NULL;
                                                                                                                SN_num_evento:=0;
                                                                                                                SR_config_evento:=NULL;
                                                                                                       V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN';
                                                                                                                IF NOT NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN(V_ACTABO,SV_estado_ini,SV_causa,SR_config_evento,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                                                                                   NULL;
                                                                                                                END IF;

                                                                                                                --Si cambia a PE debe registrar valores en modelo mayorista...
                                                                                                                --en caso contrario no hace nada...
                                                                                                                IF SR_config_evento.estado_final='PE' THEN
                                                                                                                V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_REGISTRAVALORSERIE_PR';
                                                                                                                   NP_GESTOR_MAYORISTAS_PG.NP_REGISTRAVALORSERIE_PR(V_ICC_NUE_p,V_ABONADO,V_cod_cliente_may,v_actabo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                                                                                                END IF;
                                                                                                    END IF;

                                                                                           --La antigua cambia al estado que corresponda sólo si causa es distinta a restitución...
                                                                                           IF V_ICC_p IS NOT NULL THEN
                                                                                                                        SV_estado_ini:=NULL;
                                                                                                                        begin
                                                                                                                                        SELECT C.COD_ESTADO INTO SV_estado_ini
                                                                                                                                           FROM NPT_PEDIDO A,NP_DETSER_ACTVTA_MAYORISTAS_TO C
                                                                                                                                        WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO)
                                                                                                                         FROM NPT_SERIE_PEDIDO A
                                                                                                                        WHERE A.COD_SERIE_PEDIDO = V_ICC_p)
                                                                                                                                                            AND C.COD_CLIENTE=A.cod_cliente
                                                                                                                                                      AND C.COD_PEDIDO=A.COD_PEDIDO
                                                                                                                                                            AND C.NUM_SERIE=V_ICC_p;
                                                                                                                        exception
                                                                                                                        when others then
                                                                                                                              SV_estado_ini:=NULL;
                                                                                                                        end;

                                                                                                                        IF SV_estado_ini IS NOT NULL THEN
                                                                                                                                    IF SV_causa='0' OR TRIM(SV_causa) <> CV_restitucion THEN
                                                                                                                                             SN_cod_retorno:=0;
                                                                                                                                                SV_mens_retorno:=NULL;
                                                                                                                                                SN_num_evento:=0;
                                                                                                                              V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR';
                                                                                                                                                NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR(V_ABONADO,V_ACTABO,V_ICC_p,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                                                                                                                    END IF;
                                                                                                                        END IF;
                                                                                                    END IF;
                                                                                        END IF;    --Fin Cambio nro de simcard...


                                                                                        --Inicio Cambio serie del equipo.....
                                                                                        IF V_IMEI_p IS NOT NULL AND V_IMEI_p <> V_IMEI_NUE_p THEN
                                                                                                    --Nueva cambia al estado que corresponda y si cambia a PE debe registrar los precios...
                                                                                                    --Obtener estado de la nueva en el ultimo pedido de mayorista..
                                                                                                    --Si no existe en mayorista entonces no hace nada.
                                                                                                    SV_estado_ini:=NULL;
                                                                                                    V_cod_cliente_may:=NULL;
                                                                                                    begin
                                                                                                                    SELECT  C.COD_ESTADO,C.COD_CLIENTE INTO SV_estado_ini,V_cod_cliente_may
                                                                                                                       FROM NPT_PEDIDO A,NP_DETSER_ACTVTA_MAYORISTAS_TO C
                                                                                                                    WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO)
                                                                                                     FROM NPT_SERIE_PEDIDO A
                                                                                                    WHERE A.COD_SERIE_PEDIDO = V_IMEI_NUE_p)
                                                                                                                                        AND C.COD_CLIENTE=A.cod_cliente
                                                                                                                                  AND C.COD_PEDIDO=A.COD_PEDIDO
                                                                                                                                        AND C.NUM_SERIE=V_IMEI_NUE_p;
                                                                                                    exception
                                                                                                    when others then
                                                                                                          SV_estado_ini:=NULL;
                                                                                                    end;

                                                                                                    IF SV_estado_ini IS NOT NULL THEN
                                                                                                                --Obtener conf. del evento para validar si cambiará a PE.
                                                                                                                SN_cod_retorno:=0;
                                                                                                                SV_mens_retorno:=NULL;
                                                                                                                SN_num_evento:=0;
                                                                                                                SR_config_evento:=NULL;
                                                                                                       V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN';
                                                                                                                IF NOT NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN(V_ACTABO,SV_estado_ini,SV_causa,SR_config_evento,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                                                                                   NULL;
                                                                                                                END IF;

                                                                                                                --Si cambia a PE debe registrar valores en modelo mayorista...
                                                                                                                --en caso contrario no hace nada...
                                                                                                                IF SR_config_evento.estado_final='PE' THEN
                                                                                                                V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_REGISTRAVALORSERIE_PR';
                                                                                                                   NP_GESTOR_MAYORISTAS_PG.NP_REGISTRAVALORSERIE_PR(V_IMEI_NUE_p,V_ABONADO,V_cod_cliente_may,v_actabo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                                                                                                END IF;

                                                                                                    END IF;

                                                                                           --La antigua cambia al estado que corresponda sólo si causa es distinta a restitución...
                                                                                           IF V_IMEI_p IS NOT NULL THEN
                                                                                                                        SV_estado_ini:=NULL;
                                                                                                                        begin
                                                                                                                                        SELECT C.COD_ESTADO INTO SV_estado_ini
                                                                                                                                           FROM NPT_PEDIDO A,NP_DETSER_ACTVTA_MAYORISTAS_TO C
                                                                                                                                        WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO)
                                                                                                                         FROM NPT_SERIE_PEDIDO A
                                                                                                                        WHERE A.COD_SERIE_PEDIDO = V_IMEI_p)
                                                                                                                                                            AND C.COD_CLIENTE=A.cod_cliente
                                                                                                                                                      AND C.COD_PEDIDO=A.COD_PEDIDO
                                                                                                                                                            AND C.NUM_SERIE=V_IMEI_p;
                                                                                                                        exception
                                                                                                                        when others then
                                                                                                                              SV_estado_ini:=NULL;
                                                                                                                        end;

                                                                                                                        IF SV_estado_ini IS NOT NULL THEN
                                                                                                                                    IF SV_causa='0' OR TRIM(SV_causa) <> CV_restitucion THEN
                                                                                                                                             SN_cod_retorno:=0;
                                                                                                                                                SV_mens_retorno:=NULL;
                                                                                                                                                SN_num_evento:=0;
                                                                                                                              V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR';
                                                                                                                                                NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR(V_ABONADO,V_ACTABO,V_IMEI_p,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                                                                                                                    END IF;
                                                                                                                        END IF;
                                                                                                    END IF;
                                                                                     END IF; --Fin Cambio serie del equipo.....

                                                         ELSE
                                                                                        --Inicio Cambio serie del equipo.....
                                                                                        IF V_SERIE IS NOT NULL AND V_SERIE <> V_SERIE_OLD THEN
                                                                                                    --Nueva cambia al estado que corresponda y si cambia a PE debe registrar los precios...
                                                                                                    --Obtener estado de la nueva en el ultimo pedido de mayorista..
                                                                                                    --Si no existe en mayorista entonces no hace nada.
                                                                                                    SV_estado_ini:=NULL;
                                                                                                    V_cod_cliente_may:=NULL;
                                                                                                    begin
                                                                                                                    SELECT  C.COD_ESTADO,C.COD_CLIENTE INTO SV_estado_ini,V_cod_cliente_may
                                                                                                                       FROM NPT_PEDIDO A,NP_DETSER_ACTVTA_MAYORISTAS_TO C
                                                                                                                    WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO)
                                                                                                     FROM NPT_SERIE_PEDIDO A
                                                                                                    WHERE A.COD_SERIE_PEDIDO = V_SERIE)
                                                                                                                                        AND C.COD_CLIENTE=A.cod_cliente
                                                                                                                                  AND C.COD_PEDIDO=A.COD_PEDIDO
                                                                                                                                        AND C.NUM_SERIE=V_SERIE;
                                                                                                    exception
                                                                                                    when others then
                                                                                                          SV_estado_ini:=NULL;
                                                                                                    end;

                                                                                                    IF SV_estado_ini IS NOT NULL THEN
                                                                                                                --Obtener conf. del evento para validar si cambiará a PE.
                                                                                                                SN_cod_retorno:=0;
                                                                                                                SV_mens_retorno:=NULL;
                                                                                                                SN_num_evento:=0;
                                                                                                                SR_config_evento:=NULL;
                                                                                                       V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN';
                                                                                                                IF NOT NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN(V_ACTABO,SV_estado_ini,SV_causa,SR_config_evento,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                                                                                   NULL;
                                                                                                                END IF;

                                                                                                                --Si cambia a PE debe registrar valores en modelo mayorista...
                                                                                                                --en caso contrario no hace nada...
                                                                                                                IF SR_config_evento.estado_final='PE' THEN
                                                                                                                V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_REGISTRAVALORSERIE_PR';
                                                                                                                   NP_GESTOR_MAYORISTAS_PG.NP_REGISTRAVALORSERIE_PR(V_SERIE,V_ABONADO,V_cod_cliente_may,v_actabo,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                                                                                                END IF;

                                                                                                    END IF;

                                                                                           --La antigua cambia al estado que corresponda sólo si causa es distinta a restitución...
                                                                                           IF V_SERIE_OLD IS NOT NULL THEN
                                                                                                                        SV_estado_ini:=NULL;
                                                                                                                        begin
                                                                                                                                        SELECT C.COD_ESTADO INTO SV_estado_ini
                                                                                                                                           FROM NPT_PEDIDO A,NP_DETSER_ACTVTA_MAYORISTAS_TO C
                                                                                                                                        WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO)
                                                                                                                         FROM NPT_SERIE_PEDIDO A
                                                                                                                        WHERE A.COD_SERIE_PEDIDO = V_SERIE_OLD)
                                                                                                                                                            AND C.COD_CLIENTE=A.cod_cliente
                                                                                                                                                      AND C.COD_PEDIDO=A.COD_PEDIDO
                                                                                                                                                            AND C.NUM_SERIE=V_SERIE_OLD;
                                                                                                                        exception
                                                                                                                        when others then
                                                                                                                              SV_estado_ini:=NULL;
                                                                                                                        end;

                                                                                                                        IF SV_estado_ini IS NOT NULL THEN
                                                                                                                                    IF SV_causa='0' OR TRIM(SV_causa) <> CV_restitucion THEN
                                                                                                                                             SN_cod_retorno:=0;
                                                                                                                                                SV_mens_retorno:=NULL;
                                                                                                                                                SN_num_evento:=0;
                                                                                                                              V_PROC:='NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR';
                                                                                                                                                NP_GESTOR_MAYORISTAS_PG.NP_MAIN_LIQ_MAYORISTAF2_PR(V_ABONADO,V_ACTABO,V_SERIE_OLD,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                                                                                                                    END IF;
                                                                                                                        END IF;
                                                                                                    END IF;
                                                                                     END IF; --Fin Cambio serie del equipo.....

                                                            END IF;

                                                END IF;
                                          --Fin P-COL-07002.

         ELSIF V_ACTABO = 'SC' THEN
            /* Cambio de serie o equipo */
            P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
            IF V_CLASEABO IS NOT NULL THEN
               P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                     V_RENT,V_FECSYS);
               P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,
                                    V_FECSYS);
               P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                   V_RENT,V_FECSYS);
            END IF;
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                 V_RENT,V_FECSYS);
            /*Autenticacion*/
            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,3,V_CLASEABO,V_SERIE_OLD,V_SERIE);
         ELSIF V_ACTABO = 'NN' THEN /* Cambio de Nzmero CPP<-->MPP */
            IF V_CLASEABO IS NOT NULL THEN
              P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,V_RENT,V_FECSYS);
              P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT,V_FECSYS);
            END IF;
            P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
            /*Autenticacion*/
            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,0,V_CLASEABO,V_SERIE_OLD,V_SERIE);
         ELSIF V_ACTABO = 'PC' THEN
            /* Recarga Prepago SCL CEM */
            PV_PRC_UPDATE_RECARGAPREPAGO(V_MOVIMIENTO,V_ABONADO,V_ACTABO,VP_PRODUCTO);
         ELSIF V_ACTABO = '1N' THEN /* Asignacion de segundo numero */
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                 V_RENT,V_FECSYS);
         ELSIF V_ACTABO = '2N' THEN
            /* Desasignacion de segundo numero */
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
         ELSIF V_ACTABO = 'CA' THEN
            /* Consulta de abonados en central */
            P_CONSULTA_CENTRAL(V_MOVIMIENTO,V_RESPUESTA,V_MSNB,V_SERIE,
                               V_PCODE,V_CLASEABO);
         ELSIF V_ACTABO = 'OR' OR V_ACTABO = 'V6' THEN
            /* Alta de operaciones rent a phone */
            P_ALTA_RENT(V_ABONADO,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);
         ELSIF V_ACTABO = 'RB' THEN
            /* Baja de abonados rent a phone */
            P_BAJA_ABONADORENT(V_ABONADO,V_FECSYS);
       ELSIF V_ACTABO = 'RS' THEN
            /* Tratamiento suspensiones totales RAP*/
            V_RENT := 1;
            P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,V_RENT,V_FECSYS);
            P_PROCESO_SUSPENSIONES (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,V_MODULO,V_FECSYS,V_ROWID);
            P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT,V_FECSYS);
            P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
       ELSIF V_ACTABO = 'RR' THEN
            /* Tratamiento rehabilitaciones totales RAP*/
            V_RENT := 1;
            P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,V_RENT,V_FECSYS);
            P_PROCESO_REHABILITACIONT (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,V_MODULO,V_FECSYS,V_ROWID);
            P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT,V_FECSYS);
            P_HISTORICO_SUSPENSIONES (V_ROWID,V_FECSYS);
            P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                 V_RENT,V_FECSYS);
       ELSIF V_ACTABO = 'ER' THEN
            /* Cambio de serie o equipo rent a phone*/
            V_RENT := 1;
            P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
            IF V_CLASEABO IS NOT NULL THEN
               P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,V_RENT,V_FECSYS);
               P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
               P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,V_RENT,V_FECSYS);
            END IF;
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
       ELSIF V_ACTABO = 'SR' THEN
            /* Servicios suplementarios RAP */
            V_RENT := 1;
            P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                  V_RENT,V_FECSYS);
/*          P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
*/
            P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                V_RENT,V_FECSYS);
            P_LIMPIAR_CLASEABO (VP_PRODUCTO,V_ABONADO,V_CLASE);
       ELSIF V_ACTABO = 'AR' THEN
            /* Alta de abonados roaming visitantes */
            P_ACTUALIZA_ABOROAVIS(V_ABONADO,V_FECSYS,1);
       ELSIF V_ACTABO = 'BV' THEN
            /* Baja de abonados roaming visitantes */
            P_ACTUALIZA_ABOROAVIS(V_ABONADO,V_FECSYS,0);
            P_ACTUALIZA_INFACROA(V_ABONADO);
            /*Autenticacion*/
            P_IC_ACTUALIZA_AKEYS(V_MOVIMIENTO,V_ACTABO,2,V_CLASEABO,V_SERIE_OLD,V_SERIE);
       ELSIF V_ACTABO = 'MR' THEN
            /* Modificacion roaming visitante */
            NULL;
       ELSIF V_ACTABO = 'CR' THEN
            /* Suspension Total Roaming visitantes */
            /* P_PROCESO_SUSPENSIONES (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                       V_MODULO,V_FECSYS,V_ROWID);
               P_ESTADO_ABOROA (V_ABONADO,V_INDSUSP);
            */
            /* Tratamiento servicios suplementarios */
            P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                  V_RENT,V_FECSYS);
            P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
            P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                V_RENT,V_FECSYS);
            P_LIMPIAR_CLASEABO (VP_PRODUCTO,V_ABONADO,V_CLASE);
       ELSIF V_ACTABO = 'VR' THEN
            /* Rehabilitacion Total Roaming */
            /* P_PROCESO_REHABILITACIONT (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                          V_MODULO,V_FECSYS,V_ROWID);
               P_HISTORICO_SUSPENSIONES (V_ROWID,V_FECSYS);
               P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
               P_ESTADO_ABOROA (V_ABONADO,V_INDSUSP);
            */
            P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                  V_RENT,V_FECSYS);
            P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
            P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                V_RENT,V_FECSYS);
            P_LIMPIAR_CLASEABO (VP_PRODUCTO,V_ABONADO,V_CLASE);
       ELSIF V_ACTABO = 'VP' THEN
            /* Venta Rent a Phone Prepago en oficina */
            P_ALTA_CELULAR_OFI(V_ABONADO,V_CLASEABO,V_FECSYS);
            P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);

                                                -- Inicio : COL-06051, determina que en una serie se ha realizado una activación, Fecha: 13-11-2006
               NP_GESTOR_MAYORISTAS_PG.NP_ACTUALIZAESTADOSERIE_PR(V_SERIE, V_ABONADO, VL_Error);
                                                if VL_Error <> '' then
                                                    RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||VL_Error);
                                                end if;
                                                -- Fin : COL-06051

          ELSIF V_ACTABO = 'MP' THEN
                     /* Modifica Plan  Prepago, en especial Cuenta Segura */
            NULL;
            --INI 06 09 2004 Se Agrega actuacion P4-- HD-200407051044 - TM-200406250787
       ELSIF V_ACTABO = 'P1' OR V_ACTABO = 'P3' OR V_ACTABO ='P2' OR V_ACTABO ='P4' THEN
         -- FIN 06 09 2004 -- HD-200407051044 - TM-200406250787
          /* Carga de Amistar */
            NULL;
       ELSIF V_ACTABO = 'SU' THEN
          /* Mensaje de suspencion */
                     NULL;
       ELSIF V_ACTABO = 'FI' OR V_ACTABO = 'FM' OR V_ACTABO = 'MN' THEN
                  /*Agregar o Modificar nzmero frecuente*/
             NULL;
       ELSIF V_ACTABO = 'TR' THEN
                 /*Recarga prepago*/
             NULL;
       ELSIF V_ACTABO = 'FB' THEN
                /* Eliminacion de Frecuente */
                PV_PRC_DELFRECUENTE(V_ABONADO, V_FECINGRESO);
       ELSIF V_ACTABO = 'BP' OR V_ACTABO = 'B3' THEN
                /* Baja de Abonado Prepago CEM */
               /*PV_PRC_SMS(V_ABONADO,10234,V_ACTABO,V_USUADORA,V_RESULTADO,V_ERROR,V_MSGERROR);*/
                P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
       ELSIF V_ACTABO = 'C5' THEN
                /* Activacion de Celular Prepago CEM */
               /*PV_PRC_SMS(V_ABONADO,10093,V_ACTABO,V_USUADORA,V_RESULTADO,V_ERROR,V_MSGERROR);*/
                P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
       ELSIF V_ACTABO = 'C6' THEN
                /* Desactivaci?n de Celular Prepago CEM */
                /*PV_PRC_SMS(V_ABONADO,10092,V_ACTABO,V_USUADORA,V_RESULTADO,V_ERROR,V_MSGERROR);*/
                P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
       ELSIF V_ACTABO = 'C2' THEN
                /* Cambio de Contrase±a Prepago CEM */
               /*PV_PRC_SMS(V_ABONADO,10710,V_ACTABO,V_USUADORA,V_RESULTADO,V_ERROR,V_MSGERROR);*/
                P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
       ELSIF V_ACTABO = 'BQ' THEN
                /* Bloqueo de Celular Prepago CEM */
                /*PV_PRC_SMS(V_ABONADO,10701,V_ACTABO,V_USUADORA,V_RESULTADO,V_ERROR,V_MSGERROR);*/
                 P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
      ELSIF V_ACTABO = 'DQ' THEN
                /* Desbloqueo de Celular Prepago CEM */
                /*PV_PRC_SMS(V_ABONADO,10702,V_ACTABO,V_USUADORA,V_RESULTADO,V_ERROR,V_MSGERROR);*/
                P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);

                                                                -- Inicio : COL-06051, determina que en una serie se ha realizado una activación, Fecha: 13-11-2006
                NP_GESTOR_MAYORISTAS_PG.NP_ACTUALIZAESTADOSERIE_PR(V_SERIE, V_ABONADO, VL_Error);
                                                       if VL_Error <> '' then
                                                            RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||VL_Error);
                                                       end if;
                                                                -- Fin : COL-06051
        --HOMOLOGACIÓN HB-071020030056 PAGC (Inc.CH-250920031344) 18-03-2004
       ELSIF V_ACTABO = 'BT' THEN  --       Inicio 29.06.2004. JRUZ
          IF V_SERIE IS NULL THEN
             -- INI TMM_04026
             --IF V_TIP_TECNOLOGIA='GSM' THEN
             IF LTRIM(RTRIM(GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(V_TIP_TECNOLOGIA)))= LTRIM(RTRIM(V_TECNOLOGIA_GSM))  THEN

                           Al_Devolucionkit_Pg.P_CAMBIOESTADO_PR(V_ICC,V_SUSPREHA);
             ELSE
                           Al_Devolucionkit_Pg.P_CAMBIOESTADO_PR(V_SERIE_OLD,V_SUSPREHA);
             END IF;
          ELSE
                  Al_Devolucionkit_Pg.P_CAMBIOESTADO_PR(V_SERIE,V_SUSPREHA);
          END IF; --       Fin 29.06.2004. JRUZ
       ELSIF V_ACTABO = 'GO' THEN
              P_MODIFICA_ESTADOABO (VP_PRODUCTO, V_ABONADO, V_INDSUSP, V_RENT, V_FECSYS);
       --FIN HB-071020030056
       -- Inicio modificacion by SAQL/Soporte 11/10/2005 - XO-200510080842
       ELSIF V_ACTABO = 'PQ' THEN
             /* MIX-09002: Tratamiento rangos numeracion */
             /* No hay que hacer nada */
             NULL;
       ELSIF V_ACTABO = 'PS' THEN
            /* MIX-09002: Asocia/desasocia rangos a numeros piloto */
            /* No hay que hacer nada */
             NULL;
       ELSIF V_ACTABO = 'IH' OR V_ACTABO = 'OH' THEN
             IF V_CLASEABO IS NOT NULL THEN
              P_RECUPERA_PERFILABO(VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,V_RENT,V_FECSYS);
              P_LIMPIAR_PERFILABO_PR( VP_PRODUCTO, V_ABONADO,V_CLASE);
           END IF;
              P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
              P_PROCESO_SERVICIOS(VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
       -- Fin modificacion by SAQL/Soporte 11/10/2005 - XO-200510080842
       ELSE
                   /* ACTUACIONES CORRESPONDIENTES A GESTOR CORPORATIVO
                   ACTUACIONES
                   GB = BAJA GESTOR ABONADO
                   GO = CAMBIO DE ABONADO GESTOR
                   GC = CAMBIO DE CICLO GESTOR
                   */

                   /* ACTUACION CORRESPONDIENTE A ENRUTAMIENTO DE LLAMADA
                   MV = MODIFICACION FECHA DE ENRUTAMIENTO
                   */
                 IF ( V_ACTABO != 'TR' AND V_ACTABO != 'AJ' AND V_ACTABO != 'GB'AND V_ACTABO != 'GC' AND V_ACTABO != 'MV')  THEN --Homologación HB-071020030056 18-03-2004
                      RAISE_APPLICATION_ERROR(-20201,
                      ' Actuacion no contemplada, Gestion de Abonados');
                 END IF;
       END IF;

       IF V_ACTABO = 'AV' OR V_ACTABO = 'TT' OR V_ACTABO = 'TD' OR V_ACTABO = 'V1' OR V_ACTABO = 'V2' OR V_ACTABO = 'V3'
              --Inicio incidencia CO-200608140314 (GSA 30-08-2006 Soporte)
               --Inicio incidencia CO-200605240162 NRCA
               --OR V_ACTABO = 'V4' OR V_ACTABO = 'V5' OR V_ACTABO = 'VC' OR V_ACTABO = 'VO' OR V_ACTABO = 'VT' THEN
               --OR V_ACTABO = 'V4' OR V_ACTABO = 'V5' OR V_ACTABO = 'VC' OR V_ACTABO = 'VO' OR V_ACTABO = 'VT' OR V_ACTABO = 'HH'  THEN
               --Fin incidencia CO-200605240162 NRCA
              --Fin incidencia CO-200608140314
              --INICIO CSR-11002 INC-176071
              OR V_ACTABO = 'V4' OR V_ACTABO = 'V5' OR V_ACTABO = 'VC' OR V_ACTABO = 'VO' OR V_ACTABO = 'VT' OR V_ACTABO = 'MH' THEN
              --FIN CSR-11002 INC-176071
               BEGIN
                --   Modificación  Facturacion de Trafico Mensajeria preimium para planes hibridos  2005.10.25 JLR
                  BEGIN
                    SELECT VAL_PARAMETRO INTO v_tasahibridos
                    FROM GED_PARAMETROS
                    WHERE NOM_PARAMETRO = 'COD_TIPLAN'
                    AND COD_MODULO = 'GE'
                    AND COD_PRODUCTO = 1;
                  EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                     v_tasahibridos := 'FALSE';
                  WHEN OTHERS THEN
                     RAISE_APPLICATION_ERROR  (-20004,'ERROR INESPERADO EN TRIGGER (select sobre GED_PARAMETROS) : '||SQLERRM||'.');
                  END;

                               --Inicio incidencia CO-200608140314 (GSA 30-08-2006 Soporte)
                                --Inicio incidencia CO-200605240162 NRCA
                                --INICIO CSR-11002 INC-176071 GPA
                                IF (V_ACTABO = 'VT') OR (V_ACTABO = 'VO') or (V_ACTABO = 'MH') THEN
                                --FIN CSR-11002 INC-176071 GPA
                              --  IF (V_ACTABO = 'VT') OR (V_ACTABO = 'VO') THEN
                                               -- IF (V_ACTABO = 'VT') OR (V_ACTABO = 'VO') OR (V_ACTABO = 'HH' AND v_tasahibridos = 'TRUE' )  THEN
                                                --Fin incidencia CO-200605240162 NRCA
                                               --Fin incidencia CO-200608140314
                                                V_ABONADO_CHAR := TO_CHAR(V_ABONADO);
                                                /*Código obtenido desde módulo VB de la Venta Celular, por Inc. TM-200411151095 CHV 06-12-2004*/
                                                P_LIMCONSUMO_CLIABO(V_ABONADO_CHAR);
                                                /*SE INCORPORA VALIDACIONES E INSERT AL PL, IMPORTADOS DESDE VBASIC (YA NO ESTAN EN MODULOS DE VENTAS)*/
                                END IF;
                 V_ABONADO_CHAR := TO_CHAR(V_ABONADO);
                 SELECT TO_CHAR(GA_SEQ_TRANSACABO.NEXTVAL)
                       INTO V_NUMTRANSACABO_CHAR
                 FROM DUAL;
                 P_INTERFASES_ABONADOS(V_NUMTRANSACABO_CHAR,'AV','1',V_ABONADO_CHAR,'','','','GA');

                                                                    -- Inicio : COL-06051, determina que en una serie se ha realizado una activación, Fecha: 13-11-2006
                                                                    --INICIO CSR-11002 INC-176071
                                                                    --IF (V_ACTABO = 'VO' OR V_ACTABO = 'VT') Then
                                                                    IF (V_ACTABO = 'VO' OR V_ACTABO = 'VT' OR V_ACTABO = 'MH') Then
                                                                    --FIN CSR-11002 INC-176071
                                                                        NP_GESTOR_MAYORISTAS_PG.NP_ACTUALIZAESTADOSERIE_PR(V_SERIE, V_ABONADO, VL_Error);
                                                                                  if VL_Error <> '' then
                                                                                            RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||VL_Error);
                                                                                  end if;
                                                                    End if;
                                                                    -- Fin : COL-06051

               EXCEPTION
               WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||SQLERRM);
               END;
            /* Tarjeta Club Modulo de Ventas
            BEGIN
                 P_AL_INTERFAZ_CLUB(V_ABONADO_CHAR,V_USUADORA,NULL,NULL,'PD');
            EXCEPTION
                 WHEN OTHERS THEN
                      null;
            END;*/
         END IF ;

             /*  AQUI SE GESTIONA LA LLAMADA PARA EL GESTOR DE CONTACTO O DE RETENCIONES.....*/
             Pv_Informar_Estado_Tafi_Pr(NULL,NULL,V_ABONADO,V_MOVIMIENTO,'CERRADA','CERRADA');

             -- Proyecto Interfaz SCL-Plataformas PAGC 13-04-2004
             Pv_Actualizaestado_Pr(V_MODULO,VP_REG_CMOV.TIP_TECNOLOGIA,V_MOVIMIENTO,NULL);

      END IF;

         GA_NUMCEL_PERSONAL_PG.GA_ACTLZA_NUMCEL_PERSONAL_PR(V_NUM_CELULAR,V_NUM_CELULAR_NUE,V_ACTABO);

      --Registra inicio vigencia de perfil Altamira para el celular.-
      IF  V_ACTABO = 'VA' OR V_ACTABO = 'VX' OR V_ACTABO = 'IH' OR V_ACTABO = 'OH' OR V_ACTABO = 'C3' OR V_ACTABO = 'C9' THEN
          IC_PERFILES_PG.GA_INICIA_PERFIL_PR(V_MOVIMIENTO);
      END IF;

   ELSIF VP_PRODUCTO = 2 THEN
     V_ABONADO   := VP_REG_BMOV.NUM_ABONADO;
     V_ACTUACION := VP_REG_BMOV.COD_ACTUACION;
     V_CLASEABO  := VP_REG_BMOV.COD_SERVICIOS;
     V_MOVPOS    := VP_REG_BMOV.NUM_MOVPOS;
     V_SUSPREHA  := VP_REG_BMOV.COD_SUSPREHA;
     V_ACTABO    := VP_REG_BMOV.COD_ACTABO;
     V_MODULO    := VP_REG_BMOV.COD_MODULO;
     V_MOVIMIENTO := VP_REG_BMOV.NUM_MOVIMIENTO;
     V_RESPUESTA := VP_REG_BMOV.DES_RESPUESTA;
     P_BLOQUEA_ABONADO (V_MODULO, VP_PRODUCTO, V_ACTABO, V_ABONADO);
     IF V_ACTABO = 'VO' THEN
        /* Venta beeper en oficina */
        P_ALTA_BEEPER_OFI(V_ABONADO,V_CLASEABO,V_FECSYS);
        P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);
     ELSIF V_ACTABO = 'VT' THEN
        /* Venta beeper en terreno */
        P_ALTA_BEEPER_SAV(V_ABONADO,V_CLASEABO,V_FECSYS);
        P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);
     ELSIF V_ACTABO = 'RV' THEN /* Rechazo de venta beeper */
        P_RECHAZO_VENTA(VP_PRODUCTO,V_ABONADO,V_FECSYS);
        P_CIERRA_SERVICIOS(V_ABONADO,V_FECSYS);
     ELSIF V_ACTABO = 'NU' THEN
        /* Anulacion de venta en Terreno  Beeper*/
        /* No hay que hacer nada */
        NULL;
     ELSIF V_ACTABO = 'MU' THEN
        /* Anulacion de venta en Terreno  Beeper*/
        /* No hay que hacer nada */
        NULL;
     ELSIF V_ACTABO = 'AV' THEN
        /* Aceptacion de venta beeper */
        P_CONFIRMAR_VENTA(VP_PRODUCTO,V_ABONADO,V_FECSYS);
     ELSIF V_ACTABO = 'SS' THEN
        /* Tratamiento servicios suplementarios */
        P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                              V_RENT,V_FECSYS);
        P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
        P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                            V_RENT,V_FECSYS);
        P_LIMPIAR_CLASEABO (VP_PRODUCTO,V_ABONADO,V_CLASE);
     ELSIF V_ACTABO = 'SP' THEN
        /* Tratamiento suspensiones parciales */
        P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                              V_RENT,V_FECSYS);
        P_PROCESO_SUSPENSIONES (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                V_MODULO,V_FECSYS,V_ROWID);
        P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                            V_RENT,V_FECSYS);
     ELSIF V_ACTABO = 'ST' OR V_ACTABO = 'SB' THEN
        /* Tratamiento suspensiones totales */
        P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                              V_RENT,V_FECSYS);
        P_PROCESO_SUSPENSIONES (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                V_MODULO,V_FECSYS,V_ROWID);
        P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                            V_RENT,V_FECSYS);
            ------------------------------
            -- MOdificacion proyecto ECU - COL CEM
           P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                V_RENT,V_FECSYS,1,V_MODULO);
            ---------------------------


     ELSIF V_ACTABO = 'RP' OR V_ACTABO = 'RC' OR V_ACTABO = 'RU' OR V_ACTABO = 'RL' OR V_ACTABO = 'RF' THEN
        /* Tratamiento rehabilitaciones parciales */
        P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                              V_RENT,V_FECSYS);
        P_PROCESO_REHABILITACIONP (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                   V_MODULO,V_FECSYS);
        P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                            V_RENT,V_FECSYS);



     ELSIF V_ACTABO = 'RT' OR V_ACTABO = 'RI' THEN
        /* Tratamiento rehabilitaciones totales */
        P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                              V_RENT,V_FECSYS);
        P_PROCESO_REHABILITACIONT (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                   V_MODULO,V_FECSYS,V_ROWID);
        P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                            V_RENT,V_FECSYS);
        P_HISTORICO_SUSPENSIONES (V_ROWID,V_FECSYS);
        P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
            ------------------------------
            -- MOdificacion proyecto ECU - COL CEM
           P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                V_RENT,V_FECSYS,1,V_MODULO);
            ---------------------------

    PV_PR_RESP_CENTRAL(V_MOVIMIENTO);

    ELSIF V_ACTABO = 'MJ' OR V_ACTABO = 'MH' OR V_ACTABO = 'MI' OR V_ACTABO = 'MS' THEN
        /* Mensajeria Cobranza */
        NULL;
     ELSIF V_ACTABO = 'AB' THEN
        /* Anulacion de  baja de abonados */
        P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
        P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                             V_RENT,V_FECSYS);



     ELSIF V_ACTABO = 'AF' OR V_ACTABO = 'AH' THEN
        /* Anulacion de  baja Final */
        P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
            --Modificación por Proyecto ECU-COL 'CEM'
           P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                V_RENT,V_FECSYS,1,V_MODULO);
            ---------------------------
     ELSIF V_ACTABO = 'CE'  OR V_ACTABO = 'GT' OR V_ACTABO = 'TG' OR V_ACTABO = 'ET' OR V_ACTABO = 'EG' OR V_ACTABO = 'SA' OR V_ACTABO = 'SD' THEN
        /* Cambio de serie o equipo */
        P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
        IF V_CLASEABO IS NOT NULL THEN
           P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                 V_RENT,V_FECSYS);
           P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,
                                V_FECSYS);
           P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                               V_RENT,V_FECSYS);
        END IF;
        P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                             V_RENT,V_FECSYS);
     --ELSIF V_ACTABO = 'CN'  THEN   INC 40774|COL|29-05-2007|JLM
     ELSIF V_ACTABO = 'CN' OR V_ACTABO = 'C8' THEN -- INC 40774|COL|29-05-2007|JLM
        /* Cambio de numero de beeper */
        IF V_CLASEABO IS NOT NULL THEN
           P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                 V_RENT,V_FECSYS);
           P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                               V_RENT,V_FECSYS);
        END IF;
        P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
        P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                              V_RENT,V_FECSYS);



     ELSIF V_ACTABO = 'AG' THEN
        /* Alta de grupos beeper */
        P_ALTA_GRUPOS (V_ABONADO,V_FECSYS);
     ELSIF V_ACTABO = 'BG' THEN
        /* Baja de grupos beeper */
        P_BAJA_GRUPOS (V_ABONADO,V_FECSYS);
        P_HISTORICO_GRUPOS (V_ABONADO,V_FECSYS);
     ELSIF V_ACTABO = 'SG' THEN
        /* Suspension grupos beeper */
        NULL;
     ELSIF V_ACTABO = 'RG' THEN
        /* Rehabilitacion grupos Beeper */
        NULL;
     ELSIF V_ACTABO = 'MC' THEN
        /* Baja de abonados Beeper */
        NULL;
     ELSIF V_ACTABO = 'BA' OR V_ACTABO = 'BF' OR V_ACTABO = 'PB' THEN
        /* Baja de abonados */
        P_BAJA_ABONADOCEN(VP_PRODUCTO,V_ABONADO,V_FECSYS);
        --Inicio modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842
          P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
        --Fin modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842


            --Modificación por Proyecto ECU-COL 'CEM'
           P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                V_RENT,V_FECSYS,1,V_MODULO);
            ---------------------------
     ELSE
        NULL;
     END IF;
   ELSIF VP_PRODUCTO = 4 THEN
         V_MOVPOS    := VP_REG_MMOV.NUM_MOVPOS;
         IF V_MOVPOS IS NULL THEN
           V_ABONADO   := VP_REG_MMOV.NUM_ABONADO;
           V_ACTUACION := VP_REG_MMOV.COD_ACTUACION;
           V_CLASEABO  := VP_REG_MMOV.COD_SERVICIOS;
           V_SUSPREHA  := VP_REG_MMOV.COD_SUSPREHA;
           V_ACTABO    := VP_REG_MMOV.COD_ACTABO;
           V_MODULO    := VP_REG_MMOV.COD_MODULO;
           V_MOVIMIENTO := VP_REG_MMOV.NUM_MOVIMIENTO;
           V_RESPUESTA := VP_REG_MMOV.DES_RESPUESTA;
           P_BLOQUEA_ABONADO (V_MODULO, VP_PRODUCTO, V_ACTABO, V_ABONADO);
           IF V_ACTABO = 'VO' THEN
              /* Venta celular en oficina */
              P_ALTA_TREK_OFI(V_ABONADO,V_CLASEABO,V_FECSYS);
              P_CARGA_SERVSUPLABO_PERFIL(V_ABONADO,V_CLASEABO,V_FECSYS);
           ELSIF V_ACTABO = 'RV' THEN
              /* Rechazo de venta trek */
              P_RECHAZO_VENTA(VP_PRODUCTO,V_ABONADO,V_FECSYS);
              P_CIERRA_SERVICIOS(V_ABONADO,V_FECSYS);
           ELSIF V_ACTABO = 'AV' THEN
              /* Aceptacion de venta trek */
              P_CONFIRMAR_VENTA(VP_PRODUCTO,V_ABONADO,V_FECSYS);
           ELSIF V_ACTABO = 'SS' THEN
              /* Tratamiento servicios suplementarios */
              P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                    V_RENT,V_FECSYS);
              P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
              P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                  V_RENT,V_FECSYS);
              P_LIMPIAR_CLASEABO (VP_PRODUCTO,V_ABONADO,V_CLASE);
           ELSIF V_ACTABO = 'SP' THEN
              /* Tratamiento suspensiones parciales */
              P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                    V_RENT,V_FECSYS);
              P_PROCESO_SUSPENSIONES (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                      V_MODULO,V_FECSYS,V_ROWID);
              P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                  V_RENT,V_FECSYS);
           ELSIF V_ACTABO = 'ST' OR V_ACTABO = 'SB' THEN
              /* Tratamiento suspensiones totales */
              P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                    V_RENT,V_FECSYS);
              P_PROCESO_SUSPENSIONES (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                      V_MODULO,V_FECSYS,V_ROWID);
              P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                  V_RENT,V_FECSYS);
                        ------------------------------
                        -- MOdificacion proyecto ECU - COL CEM
                  P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                       V_RENT,V_FECSYS,1,V_MODULO);
                        ---------------------------



           ELSIF V_ACTABO = 'RP' OR V_ACTABO = 'RC' OR V_ACTABO = 'RU' OR V_ACTABO = 'RL' OR V_ACTABO = 'RF' THEN
              /* Tratamiento rehabilitaciones parciales */
              P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                    V_RENT,V_FECSYS);
              P_PROCESO_REHABILITACIONP (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                         V_MODULO,V_FECSYS);
              P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                               V_RENT,V_FECSYS);



           ELSIF V_ACTABO = 'RT' OR V_ACTABO = 'RI' THEN /* Tratamiento rehabilitaciones totales */
              P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                    V_RENT,V_FECSYS);
              P_PROCESO_REHABILITACIONT (VP_PRODUCTO,V_ABONADO,V_SUSPREHA,
                                         V_MODULO,V_FECSYS,V_ROWID);
              P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                  V_RENT,V_FECSYS);
              P_HISTORICO_SUSPENSIONES (V_ROWID,V_FECSYS);
              P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
                        ------------------------------
                        -- MOdificacion proyecto ECU - COL CEM
                  P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                       V_RENT,V_FECSYS,1,V_MODULO);
                        ---------------------------

        PV_PR_RESP_CENTRAL(V_MOVIMIENTO);

           ELSIF V_ACTABO = 'MJ' OR V_ACTABO = 'MH' OR V_ACTABO = 'MI' OR V_ACTABO = 'MS' THEN
              /* Mensajeria Cobranza */
              NULL;
           ELSIF V_ACTABO = 'AB' THEN
              /* Anulacion de  baja de abonados */
              P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
              P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                   V_RENT,V_FECSYS);




           ELSIF V_ACTABO = 'CE'  OR V_ACTABO = 'GT' OR V_ACTABO = 'TG' OR V_ACTABO = 'ET' OR V_ACTABO = 'EG' OR V_ACTABO = 'SA' OR V_ACTABO = 'SD' THEN
              /* Cambio de serie o equipo */
              P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
              IF V_CLASEABO IS NOT NULL THEN
                 V_PROC := 'P_RECUPERA_PERFILABO';
                 P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                       V_RENT,V_FECSYS);
                 V_PROC := 'P_PROCESO_SERVICIOS';
                 P_PROCESO_SERVICIOS (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_FECSYS);
                 V_PROC := 'P_ACTUALIZA_PERFIL';
                 P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                     V_RENT,V_FECSYS);
              END IF;
              V_PROC := 'P_MODIFICA_ESTADOABO';
              P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT
                                  ,V_FECSYS);

           ELSIF V_ACTABO = 'CN' OR V_ACTABO = 'C8' THEN
              /* Cambio de numero de trek */
              IF V_CLASEABO IS NOT NULL THEN
                 P_RECUPERA_PERFILABO (VP_PRODUCTO,V_ABONADO,V_PERFIL,V_CLASE,
                                       V_RENT,V_FECSYS);
                 P_ACTUALIZA_PERFIL (VP_PRODUCTO,V_ABONADO,V_CLASEABO,V_PERFIL,
                                     V_RENT,V_FECSYS);
              END IF;
              P_VALIDA_SUSPENSIONES (V_ABONADO,V_INDSUSP);
              P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                    V_RENT,V_FECSYS);



           ELSIF V_ACTABO = 'MC' THEN
              /* Baja de abonados trek */
              NULL;
           ELSIF V_ACTABO =  'BA' OR V_ACTABO = 'BF' OR V_ACTABO = 'BH' OR V_ACTABO = 'PB' THEN
              /* Baja de abonados */
              P_BAJA_ABONADOCEN(VP_PRODUCTO,V_ABONADO,V_FECSYS);
              --Inicio modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842
              IF GE_FN_DEVVALPARAM('GA', 1, 'RESP_BAJA_ALTAMIRA') = 0 and V_ACTABO = 'BH' THEN

                 --XO-200510150882: German Espinoza Z; 15/10/2005
                 --UPDATE ga_aboamist
                 UPDATE ga_abocel
                 --FIN/XO-200510150882: German Espinoza Z; 15/10/2005
                 SET cod_situacion='BAA'
                 WHERE num_abonado = V_ABONADO;
              ELSE
                 P_MODIFICA_ESTADOABO (VP_PRODUCTO,V_ABONADO,V_INDSUSP,V_RENT,V_FECSYS);
              END IF;
              --Fin modificacion by SAQL/Soporte 12/10/2005 - XO-200510100842


                  --Modificación por Proyecto ECU-COL 'CEM'
            P_MODIFICA_ESTADOABO(VP_PRODUCTO,V_ABONADO,V_INDSUSP,
                                 V_RENT,V_FECSYS,1,V_MODULO);
                  ---------------------------



           ELSE
              NULL;
         END IF;
     END IF;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20203, V_PROC||' '||SQLERRM);
END; 
/

