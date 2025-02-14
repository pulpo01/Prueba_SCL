CREATE OR REPLACE PACKAGE BODY VE_DEVOLUCION_PEDIDO_PG IS
PROCEDURE DEVOLUCION_PEDIDO
/*
<NOMBRE>       : VE_DEVOLUCION_PEDIDO_PG.</NOMBRE>
--<FECHACREA>       : 21/04/2004<FECHACREA/>
<MODULO >       : VE</MODULO >
<AUTOR >       : Yury Andres Alvarez Tapia</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : DEVOLUCIoN DE KIT SIN DESVINCULAR</DESCRIPCION>
<FECHAMOD >    : 23/06/2006 </FECHAMOD >
<DESCMOD >     : Optimizar los accesos que se realizan a la tabla NPT_ESTADO_PEDIDO Inc MA-200606190940  </DESCMOD >
<VERSIONMOD>   : 1.1</VERSIONMOD>
<FECHAMOD >    : 01/09/2006 </FECHAMOD >
<DESCMOD >     : Se agrega variable de control de error: ind_error, para verificar el funcionamiento del control de los errores en los registros bloqueados CO-200604190066_1  </DESCMOD >
<VERSIONMOD>   : 1.2</VERSIONMOD>
<FECHAMOD >    : 25-03-2008 </FECHAMOD >
<DESCMOD >     : Se agrega control para determinar que un pedido no quede incompleto al momento de ser procesado, el pedido debe quedar en estado 92.
--                 Incidencia: 63202  ZMH
</DESCMOD>
<VERSIONMOD>  : 1.3</VERSIONMOD>
<FECHAMOD >   : 15/04/2008 </FECHAMOD >
<AUTORMOD >   : Z M H </AUTORMOD >
<DESCMOD >    : Incidencia 64611, Se modifica la selección de una devolución la que debe tener el campo: NOT_CRE_DEVOLUCION distinto de null, para que sea considerado por el
                proceso de aprobación de la devolución.   </DESCMOD >
<VERSIONMOD > : 1.4 </VERSIONMOD >
<FECHAMOD >   : 11/12/2008 </FECHAMOD >
<AUTORMOD >   : Z M H </AUTORMOD >
<DESCMOD >    : Incidencia 74337, Se modifica la actualización de una devolución, con el objetivo de no tomar la misma devolución en el proceso de
                devolución de series a un pedido.   </DESCMOD >
<VERSIONMOD > : 1.5 </VERSIONMOD >

<FECHAMOD >    : 11/08/2009 </FECHAMOD >
<DESCMOD >     : Modificación a PL para: P-MIX-09003-Guatemala-Salvador   </DESCMOD >
<VERSIONMOD>   : 1.6    </VERSIONMOD>
<AUTOR>        : Z.M.H. </AUTORMOD>


*/

--***************************************************************************************
  /*PARAMETROS DE LA CADENA PARA EJECUCION DE PROCESOS*/
--****************************************************************************************
/*1:= cod_pedido
 2:= cod_devolucion.
 3:= cod_cliente.
 4:= cod_uso.
 5:= tip_doc_pedido.
 6:= tip_movimiento.
 7:= tip_articulo.
 8:= cod_serie_pedido.
 9:= cod_articulo.
 10:= ind_equiacc.
 11:= tip_terminal.
 12:= ind_seriado.
 13:= cod_transaccion.
 14:= cod_estado.
 15:= num_abonado.
 16:= num_celular.
 17:= num_serie.
 18:= cod_actabo.
 19:= cod_actuacion.
 20:= cod_causa.
 21:= num_usuarora.
 22:= cod_modulo.
 23:= saldo.
 24:= cod_tecnologia.
 25:= cod_bodega.
 26:= ind_entsal.
 27:= fec_modif.
 28:= tip_artkid.
 29:= ind_telefono -indicador telefonico.
 30:= cod_central
 31:= tip_stock_orig  --indicador stock de origen.
 32:= cod_estado_dev
 33:= tip_stock       --indicador stock
 34:= GN_ejecuta_proceso */
--****************************************************************************************
is

      LV_ARTICULOTARJETA   GED_PARAMETROS.val_parametro%TYPE;  -- P-MIX-09003-Guatemala-Salvador
    --    Inicio  CO-200604190066    01-09-2006 PHG
    ind_error            number:=0;
    --    fin  CO-200604190066    01-09-2006 PHG

    GV_nom_proceso       VARCHAR2(50); --DATOS DE  SALIDA P_EJECUTA_PROCESO_DEV_PR  (pv.pedido.ga.abocel --> sale de nom_Rutina)
    GV_nom_tabla         VARCHAR2(50); --DATOS DE  SALIDA P_EJECUTA_PROCESO_DEV_PR  (ga_abocel)
    GV_cod_act           VARCHAR2(1);  --DATOS DE  SALIDA P_EJECUTA_PROCESO_DEV_PR  (I-U-S)
    GV_retorno_cadena    VARCHAR2(255);--DATOS DE  SALIDA P_EJECUTA_PROCESO_DEV_PR  (cadena de parametros INVOCA)
    GV_cod_error         VARCHAR2(15); --DATOS DE  SALIDA P_EJECUTA_PROCESO_DEV_PR  (numero de error -8988)
    GV_cadena            VARCHAR2(5000);--aqui se genera la cadena que llevara los valores al P_EJECUTA_PROCESO_DEV_PR (PLS)...
    GN_ejecuta_proceso     PLS_INTEGER;
    CI_zero CONSTANT PLS_INTEGER :=0;

    -- CURSOR DE PEDIDOS
    TN_cod_pedido        NPT_DETALLE_DEVOLUCION.cod_pedido%TYPE;
    TN_cod_devolucion    NPT_DEVOLUCION.cod_devolucion%TYPE;
    TN_cod_cliente       NPT_PEDIDO.cod_cliente%TYPE;
    TN_cod_uso           NPT_DETALLE_PEDIDO.cod_uso%TYPE;
    TN_tip_doc_pedido    NPT_PEDIDO.tip_doc_pedido%TYPE;
    TN_tip_articulo      AL_ARTICULOS.tip_articulo%TYPE;
    TV_ind_equiacc       AL_ARTICULOS.ind_equiacc%TYPE;
    TV_tip_terminal      AL_ARTICULOS.tip_terminal%TYPE;
    TN_ind_seriado       AL_ARTICULOS.ind_seriado%TYPE;
    TN_cod_bodega        NPT_DETALLE_PEDIDO.cod_bodega%TYPE;
    TN_tip_stock         NPT_DETALLE_PEDIDO.tip_stock%TYPE;
    TN_tip_stock_orig     NPT_DETALLE_PEDIDO.tip_stock_orig%TYPE;
    TN_cod_estado_dev    NPD_TIPO_DEVOLUCION.cod_estado_dev%TYPE;
    TV_cod_devol         NPT_DEVOLUCION.cod_devolucion%TYPE; --XO-200509210710
   -- CURSOR DE SERIES
    TV_cod_serie_pedido  NPT_DETALLE_DEVOLUCION.cod_serie_pedido%TYPE;
    TN_cod_articulo      NPT_DETALLE_PEDIDO.cod_articulo%TYPE;
    TN_lin_det_pedido    NPT_DETALLE_PEDIDO.lin_det_pedido%TYPE;   
    TV_serie             AL_SERIES.num_serie%TYPE;
    TN_ind_telefono      NPT_DETALLE_DEVOLUCION.ind_telefono%TYPE;
   -- VARIABLES QUE ENTREGA EL PROCESO PARA OBTENER ABONADO
    TN_abonado           GA_ABOAMIST.num_abonado%TYPE;
    TN_celular           GA_ABOAMIST.num_celular%TYPE;
    TV_tecnologia        GA_ABOAMIST.cod_tecnologia%TYPE;
    TV_serie_aux         AL_SERIES.num_serie%TYPE;
    TN_cod_central       GA_ABOAMIST.cod_central%TYPE;
-- XO-200510050801 Inicio : Responsable cambio : Pablo Hernandez : fecha:07-10-2005 :  Desc: crea definicion campos de Plan y Carga *
    TN_plan                 GA_ABOAMIST.COD_PLANTARIF%type;
    TN_carga             GA_ABOAMIST.CARGA_INICIAL%TYPE;
-- Fin Cambio Incidencia XO-200510050801
    GV_nivel_actuacion   NPT_DETALLE_DEVOLUCION.ind_telefono%TYPE;
   -- VARIABLES QUE SE GENERAN A NIVEL DE PEDIDOS
       TV_user              NPD_USUARIO.login_usuario%TYPE;
    TD_fec_max           NPT_ESTADO_DEVOLUCION.fec_cre_est_devolucion%TYPE;
    GV_tip_movimiento    VE_VENTA_MOVIMIENTO_TD.tip_movimiento%TYPE;
    GV_ind_entsal        VE_VENTA_MOVIMIENTO_TD.ind_entsal%TYPE;
    TV_tipo_venta        VE_VENTA_MOVIMIENTO_TD.tipo_venta%TYPE;
    TV_cod_transaccion   GED_PARAMETROS.val_parametro%TYPE;
    TV_cod_estado        GED_PARAMETROS.val_parametro%TYPE;
    TV_cod_causa         GED_PARAMETROS.val_parametro%TYPE;
    TV_flujo             GED_PARAMETROS.val_parametro%TYPE; --APROB_DEVOLUCION      54 -
    TV_flujo_2           GED_PARAMETROS.val_parametro%TYPE; --DEV_PROC_EXITO        91 -
    TV_flujo_3           GED_PARAMETROS.val_parametro%TYPE; --DEV_PROC_ERROR        92 -
    TV_tip_artKit        GED_PARAMETROS.val_parametro%TYPE;
    TN_usuario_cre       NPT_ESTADO_DEVOLUCION.cod_usuario_cre%TYPE;
    TN_usuario_ing       NPT_ESTADO_DEVOLUCION.cod_usuario_ing%TYPE;
    GD_fec_control       DATE;
    GD_fecsys            VARCHAR2(25);
    TD_FormatoFecha      GED_PARAMETROS.val_parametro%TYPE;
    TD_FormatoHora       GED_PARAMETROS.val_parametro%TYPE;
    TV_operadora_local   GE_OPERADORA_SCL.cod_operadora_scl%TYPE;
---------------------------
    TN_cod_actuacion     GA_ACTABO.cod_actcen%TYPE;
   --CONSTANTES GENERALES
    CN_saldo             CONSTANT NUMBER := 0;
    CN_vigencia          CONSTANT NUMBER := 1;
    CN_producto          CONSTANT NUMBER := 1;
    CN_estado            CONSTANT FA_INTQUEUEPROC.cod_estado%TYPE:= 1;
    CN_flag              CONSTANT NPD_TIPO_DEVOLUCION.flg_proc_devolucion%TYPE:='TRUE';
    CV_formato_fec       GED_PARAMETROS.nom_parametro%TYPE :='FORMATO_SEL2';
    CV_formato_hora      GED_PARAMETROS.nom_parametro%TYPE :='FORMATO_SEL7';
    GV_nompara1          GED_PARAMETROS.nom_parametro%TYPE :='APROB_DEVOLUCION';
    GV_nompara2          GED_PARAMETROS.nom_parametro%TYPE :='DEV_PROC_EXITO';
    GV_nompara3          GED_PARAMETROS.nom_parametro%TYPE :='DEV_PROC_ERROR';
    GV_nompara4          GED_PARAMETROS.nom_parametro%TYPE :='TRANSCCIONDEVOLUCION';
    GV_nompara5          GED_PARAMETROS.nom_parametro%TYPE :='TEMPORAL_DEVOLUCION';
    GV_nompara6          GED_PARAMETROS.nom_parametro%TYPE :='BAJA_MAS_DEVOLUCION';
    GV_nompara7          GED_PARAMETROS.nom_parametro%TYPE :='TIP_ARTICULO_KIT';
    GV_nompara8          GED_PARAMETROS.nom_parametro%TYPE :='PENDIENTE_REPROCESO';
    GV_nompara10         GED_PARAMETROS.nom_parametro%TYPE :='ARTICULONOSERIADO'; 

    GV_modulo1           GED_PARAMETROS.cod_modulo%TYPE    :='AL';
    GV_modulo2           GED_PARAMETROS.cod_modulo%TYPE    :='VE';
    GV_modulo3           GED_PARAMETROS.cod_modulo%TYPE    :='GA';
    CV_cod_actabo        CONSTANT GA_ACTABO.cod_actabo%TYPE:='BT';
    CV_cod_modgener      CONSTANT FA_INTQUEUEPROC.cod_modgener%TYPE:='LYP';
    CV_cod_aplic         CONSTANT FA_INTQUEUEPROC.cod_aplic%TYPE:='LYP';
    CN_cod_proceso       CONSTANT FA_INTQUEUEPROC.cod_proceso%TYPE:= 977;
    CV_cod_situacion     CONSTANT GA_ABOAMIST.cod_situacion%TYPE:='AAA';
 ---------------------------

    TV_nom_proceso       GA_ERRORES.nom_proc%TYPE;
    TV_tabla               GA_ERRORES.nom_tabla%TYPE;
    TV_act                GA_ERRORES.cod_act%TYPE;
    TV_sqlcode             GA_ERRORES.cod_sqlcode%TYPE;
    TV_sqlerrm             GA_ERRORES.cod_sqlerrm%TYPE;
    LN_numero            number;    --Inc. 63202  ZMH  25-03-2008


  ERROR_DEMOSTRACION EXCEPTION;


 CURSOR recup_pedidos (TV_flujo     GED_PARAMETROS.val_parametro%TYPE,
                        TV_cod_devol NPT_DEVOLUCION.cod_devolucion%TYPE,
                        TV_flujo_2   GED_PARAMETROS.val_parametro%TYPE,
                        TV_flujo_3   GED_PARAMETROS.val_parametro%TYPE
                           ) is
 SELECT distinct a.cod_pedido
        ,b.cod_usuario_cre
        ,b.cod_usuario_ing
        ,b.cod_devolucion
        ,c.cod_cliente
        ,c.tip_doc_pedido
        ,d.cod_articulo
        ,d.cod_uso
        ,d.cod_bodega
        ,d.tip_stock_orig
        ,d.tip_stock
        ,f.tip_articulo
        ,f.ind_equiacc
        ,f.tip_terminal
        ,f.ind_seriado
        ,g.cod_estado_dev
        ,d.cod_tecnologia
  FROM   NPT_DETALLE_DEVOLUCION a
        ,NPT_DEVOLUCION b
        ,NPT_PEDIDO c
        ,NPT_DETALLE_PEDIDO d
        ,NPT_ESTADO_PEDIDO e
        ,AL_ARTICULOS f
        ,NPD_TIPO_DEVOLUCION g
-- XO-200510050801 Inicio : Responsable cambio : Pablo Hernandez : fecha:07-10-2005 :  Desc: Se establece que el campo flg_proc_devolucion, siempre debe estar en mayuscula *
  WHERE upper(g.flg_proc_devolucion) = CN_flag
-- Fin Cambio Incidencia XO-200510050801
  AND   d.cod_articulo           = f.cod_articulo
  AND   nvl(f.cod_articulo,f.cod_articulo) > 0                      --Inc MA-200606190940 ipct
  AND   c.cod_pedido             = e.cod_pedido
  AND   nvl(c.cod_pedido,c.cod_pedido) > 0                          --Inc MA-200606190940 ipct
  AND   nvl(e.cod_pedido,e.cod_pedido) > 0                          --Inc MA-200606190940 ipct
  AND   c.cod_pedido             = d.cod_pedido
  AND   b.estado_devolucion      = TV_flujo
  AND   b.cod_devolucion         = TV_cod_devol   --XO-200509210710
  AND   a.cod_devolucion         = b.cod_devolucion
  AND   nvl(a.cod_devolucion ,a.cod_devolucion ) > 0               --Inc MA-200606190940 ipct
  AND   a.lin_det_pedido         = d.lin_det_pedido
  AND   a.cod_pedido             = c.cod_pedido
  AND   a.cod_tipo_devolucion    = g.cod_tipo_devolucion
  order by a.cod_pedido;

  CURSOR recup_series (
                       TN_cod_pedido        NPT_DETALLE_DEVOLUCION.cod_pedido%TYPE,
                       TN_cod_devolucion    NPT_DEVOLUCION.cod_devolucion%TYPE,
                       TN_cod_articulo        NPT_DETALLE_PEDIDO.cod_articulo%TYPE
                      )is
  SELECT a.cod_pedido
        ,a.cod_devolucion
        ,a.cod_serie_pedido
        ,P_OBTIENENUMERADO_FN(a.cod_serie_pedido)
        ,a.ind_telefono
        ,DECODE(a.ind_telefono,0,'0',1,'0',2,'1',3,'1',4,'1',5,'1',6,'1',7,'1', null, '1') 
        ,b.cod_articulo,b.lin_det_pedido  
  FROM  NPT_DETALLE_DEVOLUCION a, NPT_DETALLE_PEDIDO b
  WHERE a.cod_pedido     = TN_cod_pedido
  AND   a.cod_pedido     = b.cod_pedido
  AND   a.lin_det_pedido = b.lin_det_pedido
  AND   a.cod_devolucion = TN_cod_devolucion
  AND    b.COD_ARTICULO      = TN_cod_articulo;

--  Inc. 63202  ZMH  25-03-2008

 Cursor cLeePedidoDevol is
   select distinct COD_PEDIDO from npt_detalle_devolucion
   where cod_devolucion  = TV_cod_devol;

 Cursor leeNoSeriado is   -- Incidencia:  84681  ZMH  13-04-2009
    SELECT distinct   d.cod_articulo
        ,d.cod_uso
        ,d.cod_bodega
        ,f.tip_articulo
        ,f.ind_equiacc
        ,f.ind_seriado
        ,b.CAN_DET_DEVOLUCION
        ,b.cod_pedido
        ,b.lin_det_pedido
     FROM  NPT_detalle_DEVOLUCION b
        ,NPT_DETALLE_PEDIDO d
        ,AL_ARTICULOS f
   WHERE   d.cod_articulo           = f.cod_articulo
     and   f.IND_SERIADO            = 0
     AND   b.lin_det_pedido         = d.lin_det_pedido
     AND   b.cod_pedido             = d.cod_pedido
     AND   b.cod_devolucion         = TV_cod_devol;




 v_COD_ESTADO_FLUJO          npt_estado_pedido.COD_ESTADO_FLUJO%TYPE;
 v_FEC_CRE_EST_PEDIDO        npt_estado_pedido.FEC_CRE_EST_PEDIDO%TYPE;
--  Fin 63202


BEGIN --1

    ----------------------------
    TD_FormatoFecha    := SP_FN_FORMATOFECHA(CV_formato_fec);
    TD_FormatoHora     := SP_FN_FORMATOFECHA(CV_formato_hora);
    GD_fecsys          := TO_CHAR(SYSDATE,TD_FormatoFecha||' '||TD_FormatoHora);
    GD_fec_control     := TO_DATE(GD_fecsys,TD_FormatoFecha||' '||TD_FormatoHora);
    TV_operadora_local := GE_FN_OPERADORA_SCL;
    ----------------------------
    TV_sqlcode := -20200;
    SELECT val_parametro
    INTO   TV_flujo
    FROM   GED_PARAMETROS a
          ,NPD_ESTADO_FLUJO b
    WHERE  a.nom_parametro = GV_nompara1
    AND    a.cod_producto  = CN_producto
    AND    a.cod_modulo    = GV_modulo2
    AND    a.val_parametro = b.cod_estado_flujo;

    SELECT val_parametro
    INTO   TV_flujo_2
    FROM   GED_PARAMETROS a
          ,NPD_ESTADO_FLUJO b
    WHERE  a.nom_parametro = GV_nompara2
    AND    a.cod_producto  = CN_producto
    AND    a.cod_modulo    = GV_modulo2
    AND    a.val_parametro = b.cod_estado_flujo;

    SELECT val_parametro
    INTO   TV_flujo_3
    FROM   GED_PARAMETROS a
          ,NPD_ESTADO_FLUJO b
    WHERE  a.nom_parametro = GV_nompara3
    AND    a.cod_producto  = CN_producto
    AND    a.cod_modulo    = GV_modulo2
    AND    a.val_parametro = b.cod_estado_flujo;

    ----------------------------
    TV_sqlcode := -20210;
    SELECT val_parametro
    INTO   TV_cod_transaccion
    FROM   GED_PARAMETROS
    WHERE  nom_parametro = GV_nompara4
    AND    cod_producto  = CN_producto
    AND    cod_modulo    = GV_modulo1;


    SELECT val_parametro
    INTO   TV_cod_estado
    FROM   GED_PARAMETROS
    WHERE  nom_parametro = GV_nompara5
    AND    cod_producto  = CN_producto
    AND    cod_modulo    = GV_modulo1;

    ----------------------------
    TV_sqlcode := -20220;
    SELECT val_parametro
    INTO   TV_cod_causa
    FROM   GED_PARAMETROS a
          ,GA_CAUSABAJA b
    WHERE  a.nom_parametro = GV_nompara6
    AND    a.cod_producto  = CN_producto
    AND    a.cod_modulo    = GV_modulo3
    AND    a.val_parametro = b.cod_causabaja
    AND    b.cod_producto  = CN_producto
    AND    b.ind_vigencia  = CN_vigencia;

    ----------------------------
    TV_sqlcode := -20230;
    SELECT val_parametro
    INTO   TV_tip_artKit
    FROM   GED_PARAMETROS
    WHERE  nom_parametro = GV_nompara7
    AND    cod_producto  = CN_producto
    AND    cod_modulo    = GV_modulo1;

    /* inicio XO-200509210710*/

    SELECT NVL(min(b.cod_devolucion),0)
    INTO   TV_cod_devol
    FROM   NPT_DETALLE_DEVOLUCION a
          ,NPT_DEVOLUCION b
          ,NPD_TIPO_DEVOLUCION c
    WHERE c.flg_proc_devolucion    = CN_flag
    AND   b.estado_devolucion      = TV_flujo
    --and   b.not_cre_devolucion     is not null  -- Incidencia: 64611, ZMH  29-01-2008
    AND   a.cod_devolucion         = b.cod_devolucion
    AND   a.cod_tipo_devolucion    = c.cod_tipo_devolucion;

    /* fin XO-200509210710*/

    OPEN recup_pedidos (TV_flujo,TV_cod_devol,TV_flujo_2,TV_flujo_3);
    LOOP

        FETCH recup_pedidos
        INTO TN_cod_pedido
            ,TN_usuario_cre
            ,TN_usuario_ing
            ,TN_cod_devolucion
            ,TN_cod_cliente
            ,TN_tip_doc_pedido
            ,TN_cod_articulo
            ,TN_cod_uso
            ,TN_cod_bodega
            ,TN_tip_stock_orig
            ,TN_tip_stock
            ,TN_tip_articulo
            ,TV_ind_equiacc
            ,TV_tip_terminal
            ,TN_ind_seriado
            ,TN_cod_estado_dev
            ,TV_tecnologia;
          EXIT WHEN recup_pedidos%NOTFOUND;
            BEGIN    --Inc. 74337  ZMH  11-12-2008
          Update NPT_DEVOLUCION set
          estado_devolucion  = 90
          Where TV_cod_devol = cod_devolucion;
          commit;
            END;

            BEGIN
            SELECT b.login_usuario,MAX(a.fec_cre_est_devolucion)
            INTO   TV_user,TD_fec_max
            FROM   NPT_ESTADO_DEVOLUCION a,NPD_USUARIO b
            WHERE  a.cod_devolucion   = TN_cod_devolucion
            AND    a.cod_estado_flujo = TV_flujo
            AND    a.cod_usuario_cre  = b.cod_usuario
            GROUP BY b.login_usuario;
            EXCEPTION
             WHEN NO_DATA_FOUND THEN
               TV_user := '';
            END;

            TV_sqlcode := -20240;
            SELECT tip_movimiento
                  ,ind_entsal
                  ,tipo_venta
            INTO   GV_tip_movimiento,GV_ind_entsal,TV_tipo_venta
            FROM   VE_VENTA_MOVIMIENTO_TD
            WHERE  tipo_documento_web = TN_tip_doc_pedido
            AND    cod_uso = TN_cod_uso;

            GV_retorno_cadena :='ERROR GENERAL DEL PROCESO DEVOLUCION DE KIT';
            GV_cod_error := '4';
            GN_ejecuta_proceso:= CI_zero;


            If TN_ind_seriado = 0 then  
               SELECT to_number(VAL_PARAMETRO) INTO GV_tip_movimiento
               FROM   GED_PARAMETROS
               WHERE  nom_parametro = GV_nompara10
               AND    cod_producto  = CN_producto
               AND    cod_modulo    = GV_modulo1;
               if TN_tip_doc_pedido = 1  then  
                  GV_ind_entsal := 'E';
               end if;
            End if;

          BEGIN
               OPEN recup_series (TN_cod_pedido,TN_cod_devolucion, TN_cod_articulo);
            LOOP
                FETCH recup_series
                INTO TN_cod_pedido
                  ,TN_cod_devolucion
                  ,TV_cod_serie_pedido
                  ,TV_serie
                  ,TN_ind_telefono
                  ,GV_nivel_actuacion
                  ,TN_cod_articulo,TN_lin_det_pedido;
              EXIT WHEN recup_series%NOTFOUND;
               IF  TV_ind_equiacc = 'E' THEN

                  IF TN_tip_articulo = TV_tip_artKit THEN

                       SELECT b.cod_tecnologia
                     INTO TV_tecnologia
                     FROM   al_componente_kit a, icg_central b
                     WHERE  a.num_kit      = TV_cod_serie_pedido
                     AND    a.num_serie    = TV_serie
                     AND    a.cod_central = b.cod_central;

                     IF TV_tecnologia is NULL THEN

                         SELECT b.cod_tecnologia
                        INTO   TV_tecnologia
                        FROM   al_componente_kit a, al_tecnoarticulo_TD b
                        WHERE  a.num_kit      = TV_cod_serie_pedido
                        AND    a.num_serie    = TV_serie
                        AND    b.cod_articulo = a.cod_articulo
                        AND    b.ind_defecto = 1;

                    END IF;

                    SELECT a.ind_telefono
                    ,b.tip_terminal
                    INTO   TN_ind_telefono,TV_tip_terminal
                    FROM   al_componente_kit a,  al_articulos b
                    WHERE  a.num_kit      = TV_cod_serie_pedido
                    AND    a.num_serie    = TV_serie
                    AND    b.cod_articulo = a.cod_articulo;

                    IF TN_ind_telefono > 1 THEN
                         GV_nivel_actuacion := '1';
                       ELSE
                               GV_nivel_actuacion := '0';
                    END IF;
                END IF;

                    TN_abonado:= NULL;
                    TN_celular:= NULL;
                    TN_cod_central:= NULL;
                    TN_cod_actuacion:= NULL;

                    IF TN_ind_telefono > 0 THEN --9.
                     BEGIN
                      IF TN_tip_articulo = TV_tip_artKit  AND TN_tip_doc_pedido = 1 THEN
                         TV_serie_aux := TV_serie;
                      ELSE
                         TV_serie_aux := TV_cod_serie_pedido;
                      END IF;

                         SELECT  num_abonado
                                ,num_celular
                                ,cod_tecnologia
                                ,cod_central
-- XO-200510050801 Inicio : Responsable cambio : Pablo Hernandez : fecha:07-10-2005 :  Desc: Seleccion del Plan y la Carga inicial para una serie *
                                ,cod_plantarif
                                ,carga_inicial
                         INTO    TN_abonado, TN_celular,TV_tecnologia,TN_cod_central,TN_plan, TN_carga
-- Fin Cambio Incidencia XO-200510050801
                         FROM    GA_ABOAMIST
                         WHERE   num_serie     = TV_serie_aux
                         AND     cod_cliente   = TN_cod_cliente
                         AND     cod_situacion = CV_cod_situacion;

                         EXCEPTION --2
                             WHEN NO_DATA_FOUND THEN
                             BEGIN --4
                                SELECT num_abonado
                                        ,num_celular
                                        ,cod_tecnologia
                                     ,cod_central
                                INTO   TN_abonado, TN_celular,TV_tecnologia,TN_cod_central
                               FROM   GA_ABOCEL
                               WHERE  num_serie     = TV_serie_aux
                               AND    cod_cliente   = TN_cod_cliente
                               AND    cod_situacion = CV_cod_situacion;

                                 EXCEPTION --3
                                     WHEN NO_DATA_FOUND THEN
                                        BEGIN
                                         SELECT num_telefono
                                               ,cod_central
                                         INTO   TN_celular,TN_cod_central
                                         FROM   AL_SERIES
                                         WHERE  num_serie = TV_serie_aux;

                                         EXCEPTION
                                           WHEN NO_DATA_FOUND THEN
                                             TV_sqlcode := -20280;
                                           RAISE ERROR_DEMOSTRACION;
                                        END;
                                     WHEN OTHERS THEN
                                           TV_sqlcode := -20290;
                                          RAISE ERROR_DEMOSTRACION;
                               END;--4

                         WHEN OTHERS THEN
                         TV_sqlcode := -20300;
                         RAISE ERROR_DEMOSTRACION;
                     END;
                    ELSE
                      TV_serie_aux := TV_cod_serie_pedido;
                    END IF;--9.
                     BEGIN

                         SELECT cod_actcen
                         INTO   TN_cod_actuacion
                         FROM   GA_ACTABO
                         WHERE  cod_producto   = CN_producto
                         AND    cod_actabo     = CV_cod_actabo
                         AND    cod_tecnologia = TV_tecnologia
                         AND    cod_modulo     = GV_modulo3;

                            EXCEPTION --3
                                 WHEN NO_DATA_FOUND THEN
                                       TV_sqlcode := -20320;
                                      RAISE ERROR_DEMOSTRACION;
                                 WHEN OTHERS THEN
                                       TV_sqlcode := -20290;
                                      RAISE ERROR_DEMOSTRACION;
                       END;
               ELSE
                       TV_serie_aux := TV_cod_serie_pedido;
               END IF;

                     GV_cadena :='';

                     GV_cadena := '|'|| TN_cod_pedido ||'|'|| TN_cod_devolucion ||'|'|| TN_cod_cliente ||
                                  '|'|| TN_cod_uso ||'|'|| TN_tip_doc_pedido ||'|'|| GV_tip_movimiento ||
                                  '|'|| TN_tip_articulo ||'|'|| TV_cod_serie_pedido ||'|'|| TN_cod_articulo ||
                                  '|'|| TV_ind_equiacc ||'|'|| TV_tip_terminal || '|'|| TN_ind_seriado ||
                                  '|'|| TV_cod_transaccion ||'|'|| TV_cod_estado ||'|'|| TN_abonado ||
                                  '|'|| TN_celular ||'|'|| TV_serie_aux ||'|'|| CV_cod_actabo ||
                                  '|'|| TN_cod_actuacion ||'|'|| TV_cod_causa ||'|'|| user ||
                                  '|'|| GV_modulo1 ||'|'|| CN_saldo ||'|'|| TV_tecnologia ||
                                  '|'|| TN_cod_bodega ||'|'|| GV_ind_entsal ||'|'|| GD_fecsys ||
                                  '|'|| TV_tip_artKit ||'|'|| TN_ind_telefono ||'|'|| TN_cod_central ||
-- XO-200510050801 Inicio : Responsable cambio : Pablo Hernandez : fecha:07-10-2005 :  Desc: agrega en la cadena los campos Plan y la Carga inicial para una serie *
                                  '|'|| TN_tip_stock_orig ||'|'||TN_cod_estado_dev||'|'||TN_tip_stock||
                                  '|'|| TN_plan||'|'|| TN_carga||'|'|| TN_lin_det_pedido  ||'|'; 
-- Fin Cambio Incidencia XO-200510050801

                     GV_retorno_cadena :='ERROR EN LA EJECUCION DEL PROCESO DE DEVOLUCION DE KIT';
                     GV_cod_error := '4';
                     TV_sqlcode := -20250;
dbms_output.put_line('GV_cadena:' ||GV_cadena);
                     P_EJECUTA_PROCESO_DEV_PR(GV_modulo2,CN_producto,TN_tip_articulo,TV_ind_equiacc,TN_cod_uso,GV_nivel_actuacion,GV_cadena,TV_operadora_local,
                                              TN_tip_doc_pedido,GV_nom_proceso,GV_nom_tabla,GV_cod_act,GV_cod_error,GV_retorno_cadena,GN_ejecuta_proceso);


                     IF GV_cod_error <> '0' THEN
                       TV_sqlcode := -20310;
                       RAISE ERROR_DEMOSTRACION;
                     END IF;



            END LOOP;

                GD_fecsys          := TO_CHAR(SYSDATE,TD_FormatoFecha||' '||TD_FormatoHora);
                GD_fec_control     := TO_DATE(GD_fecsys,TD_FormatoFecha||' '||TD_FormatoHora);


            CLOSE  recup_series;
            EXCEPTION
            WHEN ERROR_DEMOSTRACION THEN
                       IF TV_sqlcode = -20280 THEN
                          TV_nom_proceso:= SUBSTR('SE:'||TV_serie_aux||',DEV:'||TN_cod_devolucion||',PED:'||TN_cod_pedido||'',1,50);
                          TV_tabla      := 'GA_ABOCEL';
                          TV_act        := 'S';
                          TV_sqlerrm    := 'NO SE ENCUENTRA DATO PARA SERIE :('||TV_serie_aux||')';
                       ELSIF TV_sqlcode = -20290 THEN
                          TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
                          TV_tabla      := 'GA_ABOCEL';
                          TV_act        := 'S';
                          TV_sqlerrm    := 'EN LA OBTENCION DEL ABONADO Y DATOS COMPLEMENTARIOS';
                       ELSIF TV_sqlcode = -20300 THEN
                          TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
                          TV_tabla      := 'GA_ABOAMIST';
                          TV_act        := 'S';
                          TV_sqlerrm    := 'EN LA OBTENCION DEL ABONADO Y DATOS COMPLEMENTARIOS';
                       ELSIF TV_sqlcode = -20320 THEN
                          TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
                          TV_tabla      := 'GA_ACTABO';
                          TV_act        := 'S';
                          TV_sqlerrm    := 'EN LA OBTENCION DEL CODIGO ACTUACION CENTRAL';
                       ELSIF TV_sqlcode = -20310 THEN
                          TV_nom_proceso:= SUBSTR('SE:'||TV_serie_aux||',DEV:'||TN_cod_devolucion||',PED:'||TN_cod_pedido||'',1,50);
                          TV_tabla      := SUBSTR(GV_nom_tabla||'-'||GV_nom_proceso,1,50);
                          TV_act        := SUBSTR(GV_cod_act,1,1);
                          TV_sqlcode    := SUBSTR(GV_cod_error,1,15);
                          TV_sqlerrm    := SUBSTR(GV_retorno_cadena,1,60);
--                       ELSE
--                           dbms_output.PUT_LINE ('ERROR INESPERADO EN DEVOLUCION:'||TN_cod_devolucion);
                       END IF;

                           GD_fecsys          := TO_CHAR(SYSDATE,TD_FormatoFecha||' '||TD_FormatoHora);
                        GD_fec_control     := TO_DATE(GD_fecsys,TD_FormatoFecha||' '||TD_FormatoHora);

                        --insert de flujo procesado con error 92 .
    --    Inicio  CO-200604190066    01-09-2006  PHG
                        ind_error:= 1;
    --    Fin  CO-200604190066    01-09-2006  PHG
                        GRABA_ERROR(CV_cod_actabo,TN_cod_devolucion,GD_fec_control,CN_producto,TV_nom_proceso,TV_tabla,
                                    TV_act,TV_sqlcode,TV_sqlerrm,TN_cod_pedido,TV_user,TV_flujo_3,TN_usuario_cre,TN_usuario_ing,
                                    CV_cod_modgener,CV_cod_aplic,CN_cod_proceso,CN_estado);

                        CLOSE  recup_series;
                        ROLLBACK;
        END;--99

    END LOOP;

       CLOSE  recup_pedidos;

       SELECT VAL_PARAMETRO into LV_ARTICULOTARJETA   -- P-MIX-09003-Guatemala-Salvador
       FROM GED_PARAMETROS
       WHERE nom_parametro = 'TIP_ART_ACTIVACION2';

       If TN_tip_articulo = LV_ARTICULOTARJETA and ind_error = 0 then  -- P-MIX-09003-Guatemala-Salvador
          Np_Activacion_Tarjetas_Pg.NP_GENERA_RANGOS_DEVOLUCION_PR(GV_cadena, TV_tabla, TV_act, TV_sqlcode, TV_sqlerrm);

          If TV_sqlcode <> '0' Then
             TV_sqlcode := -20410;
             ind_error:= 1;
             TV_nom_proceso:= SUBSTR('Np_Activacion_Tarjetas_Pg.NP_GENERA_RANGOS_DEVOLUCION_PR',1,50);
             TV_tabla      := SUBSTR(TV_tabla,1,50);
             TV_act        := SUBSTR(TV_act,1,1);
             TV_sqlcode    := SUBSTR(TV_sqlcode,1,15);
             TV_sqlerrm    := SUBSTR(TV_sqlerrm,1,60);

             GRABA_ERROR(CV_cod_actabo,TN_cod_devolucion,GD_fec_control,CN_producto,TV_nom_proceso,TV_tabla,
             TV_act,TV_sqlcode,TV_sqlerrm,TN_cod_pedido,TV_user,TV_flujo_3,TN_usuario_cre,TN_usuario_ing,
             CV_cod_modgener,CV_cod_aplic,CN_cod_proceso,CN_estado);
          End if;
       End if;

    --    Inicio  CO-200604190066    01-09-2006  PHG
    IF TV_cod_devol > 0 and ind_error = 0 THEN
    --    Fin  CO-200604190066    01-09-2006  PHG

    --    inicio XO-200509210710
        INSERT INTO NPT_ESTADO_DEVOLUCION
            (cod_devolucion,fec_cre_est_devolucion,cod_usuario_cre,cod_usuario_ing,cod_motivo_rechazo,cod_estado_flujo,fec_inf_est_devolucion,obs_est_devolucion)
        VALUES (TN_cod_devolucion,GD_fec_control,TN_usuario_cre,TN_usuario_ing,NULL,TV_flujo_2,GD_fec_control,NULL);


    --    fin XO-200509210710
    END IF;


    UPDATE FA_INTQUEUEPROC
    SET   cod_estado  = CN_estado,
          fec_estado  = sysdate      -- P-MIX-09003-Guatemala-Salvador
    WHERE cod_aplic   = CV_cod_aplic
    AND   cod_modgener= CV_cod_modgener
    AND   cod_proceso = CN_cod_proceso;

--  Inc. 63202  ZMH  25-03-2008
    SELECT COUNT(1) INTO LN_numero FROM GA_ERRORES
    WHERE     COD_ACTABO = CV_cod_actabo
    AND     CODIGO = TV_cod_devol
    AND TRUNC(FEC_ERROR) = TRUNC(SYSDATE);

    IF LN_numero = 0 THEN

        FOR VLEEPEDIDODEVOL IN CLEEPEDIDODEVOL
        LOOP

              For vleeNoSeriado in leeNoSeriado loop  -- Incidencia:  84681  ZMH  13-04-2009
                                            Update npt_detalle_pedido set
                                        CAN_ASIG_DETALLE_PEDIDO = CAN_ASIG_DETALLE_PEDIDO - vleeNoSeriado.CAN_DET_DEVOLUCION
                                        Where cod_pedido =   vleeNoSeriado.cod_pedido
                                          And lin_det_pedido = vleeNoSeriado.lin_det_pedido;
             End loop;


            SELECT COD_ESTADO_FLUJO, FEC_CRE_EST_PEDIDO INTO V_COD_ESTADO_FLUJO, V_FEC_CRE_EST_PEDIDO
            FROM NPT_ESTADO_PEDIDO
            WHERE COD_PEDIDO = VLEEPEDIDODEVOL.COD_PEDIDO
            AND FEC_CRE_EST_PEDIDO = (SELECT MAX(FEC_CRE_EST_PEDIDO) FROM NPT_ESTADO_PEDIDO
            WHERE COD_PEDIDO = VLEEPEDIDODEVOL.COD_PEDIDO AND NVL(COD_PEDIDO,COD_PEDIDO) > 0);

            UPDATE NPT_ESTADO_PEDIDO SET
               COD_ESTADO_FLUJO = 49
            WHERE COD_PEDIDO = VLEEPEDIDODEVOL.COD_PEDIDO
            AND   FEC_CRE_EST_PEDIDO = V_FEC_CRE_EST_PEDIDO;

            DELETE NPT_SERIE_PEDIDO
            WHERE (COD_SERIE_PEDIDO,COD_PEDIDO,LIN_DET_PEDIDO) IN
            (SELECT COD_SERIE_PEDIDO,COD_PEDIDO,LIN_DET_PEDIDO
            FROM NPT_DETALLE_DEVOLUCION
            WHERE COD_DEVOLUCION = TV_COD_DEVOL
            AND   COD_PEDIDO = VLEEPEDIDODEVOL.COD_PEDIDO);

            UPDATE NPT_ESTADO_PEDIDO SET
               COD_ESTADO_FLUJO = V_COD_ESTADO_FLUJO
            WHERE COD_PEDIDO = VLEEPEDIDODEVOL.COD_PEDIDO
            AND   FEC_CRE_EST_PEDIDO = V_FEC_CRE_EST_PEDIDO;

        END LOOP;

--  Fin Inc. 63202
       COMMIT;
--  Inc. 63202  ZMH  25-03-2008
    ELSE
       ROLLBACK;
    END IF;
--  Fin Inc. 63202

EXCEPTION
WHEN NO_DATA_FOUND  THEN
    IF TV_sqlcode = -20200 THEN
       TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
       TV_tabla      := 'GED_PARAMETROS';
       TV_act        := 'S';
       TV_sqlerrm    := 'NO SE ENCUENTRAN DATOS PARA LOS ESTADOS DE FLUJOS';
    ELSIF TV_sqlcode = -20210 THEN
       TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
       TV_tabla      := 'GED_PARAMETROS';
       TV_act        := 'S';
       TV_sqlerrm    := 'NO SE ENCUENTRA DATOS EN GED_PARAMETROS';
    ELSIF TV_sqlcode = -20220 THEN
       TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
       TV_tabla      := 'GED_PARAMETROS';
       TV_act        := 'S';
       TV_sqlerrm    := 'NO SE ENCUENTRAN DATOS DE CAUSA DEVOLUCION KIT';
    ELSIF TV_sqlcode = -20230 THEN
       TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
       TV_tabla      := 'GED_PARAMETROS';
       TV_act        := 'S';
       TV_sqlerrm    := 'NO SE ENCUENTRA TIPO ARTICULO KIT';
    ELSIF TV_sqlcode = -20240 THEN
       TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
       TV_tabla      := 'VE_VENTA_MOVIMIENTO_TD';
       TV_act        := 'S';
       TV_sqlerrm    := 'NO SE ENCUENTRAN DATOS PARA TIPO DOCUMENTO '||TN_tip_doc_pedido;
--    ELSE
--       dbms_output.PUT_LINE ('ERROR INESPERADO EN DEVOLUCION:'||TN_cod_devolucion);
    END IF;
    --    Inicio  CO-200604190066    01-09-2006 PHG
    ind_error:=1;
    --    Fin  CO-200604190066    01-09-2006 PHG
    GRABA_ERROR(CV_cod_actabo,TN_cod_devolucion,GD_fec_control,CN_producto,TV_nom_proceso,TV_tabla,
                TV_act,TV_sqlcode,TV_sqlerrm,TN_cod_pedido,TV_user,TV_flujo_3,TN_usuario_cre,TN_usuario_ing,
                CV_cod_modgener,CV_cod_aplic,CN_cod_proceso,CN_estado);
     ROLLBACK;

WHEN OTHERS THEN
    IF TV_sqlcode = -20200 THEN
       TV_tabla      := 'GED_PARAMETROS - TV_Flujos';
       TV_act        := 'S';
       TV_sqlerrm    := SUBSTR(SQLERRM,1,60);
    ELSIF TV_sqlcode = -20210 THEN
       TV_tabla      := 'GED_PARAMETROS - TV_cod_estado';
       TV_act        := 'S';
       TV_sqlerrm    := SUBSTR(SQLERRM,1,60);
    ELSIF TV_sqlcode = -20220 THEN
       TV_tabla      := 'GED_PARAMETROS - TV_cod_causa';
       TV_act        := 'S';
       TV_sqlerrm    := SUBSTR(SQLERRM,1,60);
    ELSIF TV_sqlcode = -20230 THEN
       TV_tabla      := 'GED_PARAMETROS - TV_tip_artKit';
       TV_act        := 'S';
       TV_sqlerrm    := SUBSTR(SQLERRM,1,60);
    ELSIF TV_sqlcode = -20240 THEN
       TV_tabla      := 'VE_VENTA_MOVIMIENTO - tip_movimiento';
       TV_act        := 'S';
       TV_sqlerrm    := SUBSTR(SQLERRM,1,60);
    ELSIF TV_sqlcode = -20250 THEN
       TV_nom_proceso:= 'VE_DEVOLUCION_PEDIDO_PG.DEVOLUCION_PEDIDO';
       TV_tabla      := 'NO DEFINIDA';
       TV_act        := 'N';
       TV_sqlerrm    := SUBSTR(SQLERRM,1,60);
--    ELSE
--       dbms_output.PUT_LINE ('ERROR INESPERADO EN DEVOLUCION:'||TN_cod_devolucion);
    END IF;
    --    Inicio  CO-200604190066    01-09-2006  PHG
     ind_error:=1;
    --    Fin  CO-200604190066    01-09-2006  PHG
     GRABA_ERROR(CV_cod_actabo,TN_cod_devolucion,GD_fec_control,CN_producto,TV_nom_proceso,TV_tabla,
                 TV_act,TV_sqlcode,TV_sqlerrm,TN_cod_pedido,TV_user,TV_flujo_3,TN_usuario_cre,TN_usuario_ing,
                 CV_cod_modgener,CV_cod_aplic,CN_cod_proceso,CN_estado);
     ROLLBACK;

END DEVOLUCION_PEDIDO; --1


PROCEDURE P_EJECUTA_PROCESO_DEV_PR (
          EV_modulo          IN  VARCHAR2,
          EN_producto        IN  VARCHAR2,
          EV_tipo_articulo   IN  AL_ARTICULOS.tip_articulo%TYPE,
          EV_ind_equiacc     IN  AL_ARTICULOS.ind_equiacc%TYPE,
          EV_cod_uso         IN  NPT_DETALLE_PEDIDO.cod_uso%TYPE,
          EV_nivel_actuacion IN  VARCHAR2,
          EV_param_entrada   IN  VARCHAR2,
          EV_operadora_local IN  GE_OPERADORA_SCL.cod_operadora_scl%TYPE,
          EN_tip_doc_pedido  IN  VARCHAR2,
          SV_nom_proceso     OUT NOCOPY VARCHAR2,
          SV_nom_tabla       OUT NOCOPY VARCHAR2,
          SV_cod_act         OUT NOCOPY VARCHAR2,
          SV_error           OUT NOCOPY VARCHAR2,
          SV_cadena          OUT NOCOPY VARCHAR2,
          GN_ejecuta_proceso IN OUT NOCOPY PLS_INTEGER
)
/*
<NOMBRE>      : P_EJECUTA_PROCESO_DEV_PR.</NOMBRE>
<FECHACREA>      : 21/04/2004<FECHACREA/>
<MODULO >      : Modulo al que pertenece PL; Script; trigger; cursor; funcion. </MODULO >
<AUTOR >      : Yury Andres Alvarez Tapia</AUTOR >
<VERSION >    : 1.0</VERSION >
<DESCRIPCION> : EJECUTA PL?S QUE PROCESAN DEVOLUCIONES DE PEDIDOS</DESCRIPCION>
<FECHAMOD >   : 21/04/2004 </FECHAMOD >
<DESCMOD >    : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>   : EV_modulo,EN_producto,EV_tipo_articulo,EV_ind_equiacc,EV_cod_uso,EV_nivel_actuacion,
                EV_param_entrada,EV_operadora_local</ParamEntr>
<ParamSal >   : SV_nom_proceso,SV_nom_tabla,SV_cod_act,SV_error,SV_cadena</ParamEntr>
*/
IS
     --VARIABLES DEL CURSOR.
     TN_num_restriccion   PV_ACTUAC_RESTRICCION.num_restriccion%TYPE;
     TV_tip_rutina        PV_RESTRICCIONES.tip_rutina%TYPE;
     --TV_nom_rutina        PV_RESTRICCIONES.nom_rutina%TYPE;
     TV_nom_rutina        GE_PROCESOS_TD.NOM_PROCESO%TYPE;
     -- CONSTANTES
     CN_flag              CONSTANT NPD_TIPO_DEVOLUCION.flg_proc_devolucion%TYPE:='TRUE';
     --VARIABLES QUE SE USAN PARA EJECUCION DE LOS PL'S .
     GV_param_tabla       VARCHAR2(2000) := '';--no se puede debido a que no se lo que puede venir en PL .
     GV_param_act         VARCHAR2(2000) := '';
     GV_param_error       VARCHAR2(15);
     GV_param_cadena      VARCHAR2(2000) := '';
     -- VARIABLES DE ARMADO DE LLAMADA A PL'S.
     GV_param_entrada_cte VARCHAR2(2000) := '';
     GV_comando_sql       VARCHAR2(2000) := '';

     CV_cod_modulo CONSTANT GE_PROCESOS_TD.COD_MODULO%TYPE := 'VE';
     CN_cod_producto CONSTANT GE_PROCESOS_TD.COD_PRODUCTO%TYPE := 1;
     CN_num_proceso CONSTANT GE_PROCESOS_TD.NUM_PROCESO%TYPE := 4;
     CI_zero CONSTANT PLS_INTEGER :=0;
     CI_uno CONSTANT PLS_INTEGER :=1;


     ERROR_PROCESO EXCEPTION;

     CURSOR recup_ejecproc IS
     SELECT num_proceso
     FROM   GE_EJECUTA_PROCESO_TD
     WHERE  cod_operadora   = EV_operadora_local
     AND    cod_modulo      = EV_modulo
     AND    cod_producto    = EN_producto
     AND    condicion_1     = EV_tipo_articulo
     AND    condicion_2     = EV_ind_equiacc
     AND    condicion_3     = EV_cod_uso
     AND    condicion_4     = EV_nivel_actuacion
     AND    condicion_5     = EN_tip_doc_pedido
     AND    flg_estado      = CN_flag
     ORDER BY ind_orden ASC;


BEGIN
---- Selecciona rutina a ejecutar y valida su existencia
     SV_error  := '0';
     SV_cadena := 'OK';

     OPEN recup_ejecproc;
     LOOP
         FETCH recup_ejecproc INTO TN_num_restriccion;
         EXIT WHEN recup_ejecproc%NOTFOUND;
         TV_tip_rutina := '';
         TV_nom_rutina := '';

         SELECT tip_proceso, nom_proceso
         INTO   TV_tip_rutina, TV_nom_rutina
         FROM   GE_PROCESOS_TD
         WHERE  cod_modulo      = EV_modulo
         AND    cod_producto    = EN_producto
         AND    num_proceso     = TN_num_restriccion;
         IF LTRIM(RTRIM(TV_tip_rutina)) =''  OR (TV_tip_rutina IS NULL) THEN
            SV_nom_proceso := 'P_EJECUTA_PROCESO_DEV_PR';
            SV_nom_tabla   := 'GE_PROCESOS_TD';
            SV_cod_act     := 'S';
            SV_error       := '4';
            SV_cadena      := 'NO SE ENCUENTRAN DATOS.';
            CLOSE  recup_ejecproc;
            RAISE ERROR_PROCESO;
         END IF;

         SV_nom_proceso := 'P_EJECUTA_PROCESO_DEV_PR';
         SV_nom_tabla   := 'GE_PROCESOS_TD';
         SV_cod_act     := 'S';
         GV_param_error := '0';
         GV_param_tabla := 'OK';
--       Llama a la otra rutina diferenciando Funcion, PL sin parametros y PL con parametros
         
         IF TV_tip_rutina = 'FC' THEN
            GV_comando_sql:='SELECT '||TV_nom_rutina||'('||EV_param_entrada||') FROM DUAL';
            EXECUTE IMMEDIATE GV_comando_sql INTO GV_param_tabla;

         ELSIF TV_tip_rutina = 'PL' THEN
               IF TRIM(EV_param_entrada) = '' OR (EV_param_entrada IS NULL) THEN  -- sin parametros
                  GV_param_entrada_cte := ':GV_param_error,:GV_param_tabla';
                  GV_comando_sql:= 'BEGIN ' || TV_nom_rutina||'('|| GV_param_entrada_cte ||'); END;';
                  EXECUTE IMMEDIATE GV_comando_sql USING OUT GV_param_error, OUT GV_param_tabla;

               ELSE --con 1 parametro compuesto entrada y 4 compuestos de salida
                  IF TN_num_restriccion <> CN_num_proceso AND EV_modulo = CV_cod_modulo AND EN_producto = CN_cod_producto THEN
                      GV_param_entrada_cte := ':EV_param_entrada,:GV_param_tabla,:GV_param_act,:GV_param_error,:GV_param_cadena';
                      GV_comando_sql:= 'BEGIN ' || TV_nom_rutina||'('|| GV_param_entrada_cte ||'); END;';

                        EXECUTE IMMEDIATE GV_comando_sql USING  IN  EV_param_entrada
                                                              , OUT GV_param_tabla
                                                              , OUT GV_param_act
                                                              , OUT GV_param_error
                                                              , OUT GV_param_cadena;
                  ELSE
                      IF GN_ejecuta_proceso = CI_zero THEN
                          GV_param_entrada_cte := ':EV_param_entrada,:GV_param_tabla,:GV_param_act,:GV_param_error,:GV_param_cadena';
                          GV_comando_sql:= 'BEGIN ' || TV_nom_rutina||'('|| GV_param_entrada_cte ||'); END;';

                            EXECUTE IMMEDIATE GV_comando_sql USING  IN  EV_param_entrada
                                                                  , OUT GV_param_tabla
                                                                  , OUT GV_param_act
                                                                  , OUT GV_param_error
                                                                  , OUT GV_param_cadena;
                            GN_ejecuta_proceso := CI_uno;
                      END IF;

                 END IF;

               END IF;
          ELSE
               SV_nom_proceso := 'P_EJECUTA_PROCESO_DEV_PR';
               SV_nom_tabla   := 'GE_PROCESOS_TD';
               SV_cod_act     := 'S';
               SV_error       := '4';
               SV_cadena      := 'NO HABILITADO PARA EJECUTAR TIPO RUTINA INVOCADO ('||TV_tip_rutina||').';
               CLOSE  recup_ejecproc;
               RAISE ERROR_PROCESO;
          END IF;

         IF GV_param_error <> '0' THEN
            SV_nom_proceso := SUBSTR(TV_nom_rutina,1,50);
            SV_nom_tabla   := SUBSTR(GV_param_tabla,1,50);
            SV_cod_act     := SUBSTR(GV_param_act,1,1);
            SV_error       := SUBSTR(GV_param_error,1,15);
            SV_cadena      := SUBSTR(GV_param_cadena,1,60);
            CLOSE  recup_ejecproc;
            RAISE ERROR_PROCESO;
         END IF;

     END LOOP;

         IF TN_num_restriccion IS NULL THEN
            SV_nom_proceso := 'P_EJECUTA_PROCESO_DEV_PR';
            SV_nom_tabla   := 'GE_EJECUTA_PROCESO_TD';
            SV_cod_act     := 'S';
            SV_error       := '4';
            SV_cadena      := 'NO SE ENCUENTRAN DATOS.';
            CLOSE  recup_ejecproc;
            RAISE ERROR_PROCESO;
         END IF;

     CLOSE  recup_ejecproc;
     EXCEPTION
     WHEN ERROR_PROCESO THEN
            SV_nom_proceso := SUBSTR(SV_nom_proceso,1,50);
            SV_nom_tabla   := SUBSTR(SV_nom_tabla,1,50);
            SV_cod_act     := SUBSTR(SV_cod_act,1,1);
            SV_error       := SUBSTR(SV_error,1,15);
            SV_cadena      := SUBSTR(SV_cadena,1,60);


END P_EJECUTA_PROCESO_DEV_PR;


PROCEDURE PV_INVOCA_BAJA_PR
(   EV_entrada       IN  VARCHAR2,
    SV_tabla         OUT NOCOPY VARCHAR2, --SV_nom_tabla
    SV_actabo        OUT NOCOPY VARCHAR2, --SV_cod_act
    SV_error         OUT NOCOPY VARCHAR2, --SV_error
    SV_proc          OUT NOCOPY VARCHAR2  --SV_cadena
)
/*
<NOMBRE>      : PV_INVOCA_BAJA_PR.</NOMBRE>
<FECHACREA>      : 21/04/2004<FECHACREA/>
<MODULO >      : Modulo al que pertenece PL; Script; trigger; cursor; funcion. </MODULO >
<AUTOR >      : Yury Andres Alvarez Tapia</AUTOR >
<VERSION >    : 1.0</VERSION >
<DESCRIPCION> : EJECUTA PL PV_PR_BAJA_PREPAGO_PP_PR MEDIANTE DEVOLUCION./DESCRIPCION>
<FECHAMOD >   : 21/04/2004 </FECHAMOD >
<DESCMOD >    : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>   : EV_entrada</ParamEntr>
<ParamSal >   : SV_tabla,SV_actabo,SV_error,SV_proc </ParamEntr>
*/
IS

    string siscel.GE_TABTYPE_VCH2ARRAY:= siscel.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


   --Procedimiento que realiza la Llamada al PL del Abonado prepago
   TN_transaccion       GA_TRANSACABO.num_transaccion%TYPE;
   TN_abonado           GA_ABOAMIST.num_abonado%TYPE;
   TV_actabo            GAD_ORIDESUSO.cod_actabo%TYPE;
   TV_usuario           VARCHAR2(25);--Se asigna la fecha del proceso .
   TV_causa               GA_CAUSABAJA.cod_causabaja%TYPE;
   GV_saldo             NUMBER;
   TN_retorno           GA_TRANSACABO.cod_retorno%TYPE;
   TV_cadena_retorno    GA_TRANSACABO.des_cadena%TYPE;

   ERROR_PROCESO EXCEPTION;

BEGIN --0

     SELECT GA_SEQ_TRANSACABO.NEXTVAL
     INTO   TN_transaccion
     FROM   DUAL;
     IF LTRIM(RTRIM(TN_transaccion)) ='' OR (TN_transaccion IS NULL) THEN
       SV_tabla        := 'SECUENCIA GA_SEQ_TRANSACABO';
       SV_actabo     := 'S';
       SV_error     := '4';
       SV_proc      := 'AL RECUPERAR SECUENCIA';
       RAISE ERROR_PROCESO;
     END IF;

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_entrada, string);

     TN_abonado      := string(15);
     TV_actabo       := string(18);
     TV_usuario      := string(21);
     TV_causa        := string(20);
     GV_saldo        := TO_NUMBER(string(23));

     SV_proc        := 'ERROR RECUPERANDO DATOS DE LA CADENA';
     SV_error       := '4';

    PV_PR_BAJA_PREPAGO_PP_PR (TN_transaccion,TN_abonado,TV_actabo,TV_usuario,TV_causa,GV_saldo);

    SELECT COD_RETORNO, DES_CADENA
    INTO   TN_retorno , TV_cadena_retorno
    FROM   GA_TRANSACABO
    WHERE  NUM_TRANSACCION = TN_transaccion;

    IF  TN_retorno <> '0' THEN
        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(TV_cadena_retorno, string);
        SV_tabla        := string(1);
        SV_actabo         := string(2);
        SV_error         := string(3);
        SV_proc         := string(4);
    END IF;
    RAISE ERROR_PROCESO;

EXCEPTION
    WHEN ERROR_PROCESO THEN
        IF SV_error <> '0' THEN
           SV_tabla        := SV_tabla;
           SV_actabo     := SV_actabo;
           SV_error     := SV_error;
           SV_proc      := SV_proc;
        END IF;
       WHEN NO_DATA_FOUND THEN
           SV_tabla        := '';
           SV_actabo     := '';
           SV_error     := '0';
           SV_proc      := 'OK';

END PV_INVOCA_BAJA_PR;

PROCEDURE GRABA_ERROR (EV_modulo         IN VARCHAR2,
                       EN_cod_devolucion IN NUMBER, --aqui deberia ir el abonado. (EN_abonado).
                       ED_fecsys         IN DATE,
                       EN_producto       IN NUMBER,
                       EV_proceso        IN VARCHAR2,
                       EV_tabla          IN VARCHAR2,
                       EV_act            IN VARCHAR2,
                       EV_cod_error      IN VARCHAR2,
                       EV_msg_error      IN VARCHAR2,
                       EN_cod_pedido     IN NUMBER,
                       EV_user           IN VARCHAR2,
                       EV_flujo_error     IN VARCHAR2,
                       EN_usuario_cre    IN NUMBER,
                       EN_usuario_ing    IN NUMBER,
                       EV_cod_modgener   IN VARCHAR2,
                       EV_cod_aplic      IN VARCHAR2,
                       EN_cod_proceso    IN NUMBER,
                       EN_estado         IN NUMBER)
/*
<NOMBRE>      : GRABA_ERROR.</NOMBRE>
<FECHACREA>      : 21/04/2004<FECHACREA/>
<MODULO >      : Modulo al que pertenece PL; Script; trigger; cursor; funcion. </MODULO >
<AUTOR >      : Yury Andres Alvarez Tapia</AUTOR >
<VERSION >    : 1.0</VERSION >
<DESCRIPCION> : REALIZA COMMIT DEL ERROR DESHACIENDO LOS PROCESOS HECHOS PREVIAMENTE./DESCRIPCION>
<FECHAMOD >   : 21/04/2004 </FECHAMOD >
<DESCMOD >    : Breve descripcion de Modificacion </DESCMOD >
<ParamEntr>   : EV_modulo,EN_abonado,ED_fecsys,EN_producto,EV_proceso,EV_tabla,EV_act,EV_cod_error,EV_msg_error,
                EN_cod_pedido,EV_user,EV_flujo_error,EN_usuario_cre,EN_usuario_ing,EV_cod_modgener,EV_cod_aplic,EN_cod_proceso
                EN_estado</ParamEntr>
<ParamSal >   : </ParamEntr>
<VERSION >    : 1.1</VERSION >
<FECHAMOD >   : 24/04/2006 </FECHAMOD >
<DESCMOD >    : Incidencia : CO-200604190066 Incorporación de validación por bloqueo de tablas de inventarios. </DESCMOD >

*/
IS
  PRAGMA AUTONOMOUS_TRANSACTION;

 --PROCEDIMIENTO QUE GRABA EL ERROR DEFINIENDO UNA TRANSACCION AUTONOMA...
  TN_cod_devolucion  NPT_DEVOLUCION.cod_devolucion%TYPE:='';
  irev               NUMBER;

  BEGIN
         ROLLBACK;

         IF LTRIM(RTRIM(EN_cod_devolucion)) ='' OR (EN_cod_devolucion IS NULL) THEN
            TN_cod_devolucion := 1;
         ELSE
            TN_cod_devolucion := EN_cod_devolucion;
         END IF;

 --    inicio CO-200604190066  24-04-2006 ipct

         irev := INSTR(EV_msg_error,'ORA-20155');

         INSERT INTO GA_ERRORES
         (cod_actabo,codigo,fec_error,cod_producto,nom_proc,nom_tabla,cod_act,cod_sqlcode,cod_sqlerrm)
         VALUES
         (EV_modulo,TN_cod_devolucion,ED_fecsys,EN_producto,EV_proceso,EV_tabla,EV_act,EV_cod_error,EV_msg_error);

         IF irev = 0 THEN

              IF NOT LTRIM(RTRIM(EN_cod_devolucion)) ='' OR (EN_cod_devolucion IS NOT NULL) THEN

              INSERT INTO NPT_ESTADO_DEVOLUCION
              (cod_devolucion,fec_cre_est_devolucion,cod_usuario_cre,cod_usuario_ing,cod_motivo_rechazo,cod_estado_flujo,fec_inf_est_devolucion,obs_est_devolucion)
              VALUES
              (EN_cod_devolucion,ED_fecsys,EN_usuario_cre,EN_usuario_ing,NULL,EV_flujo_error,ED_fecsys,NULL);

              END IF;

              UPDATE FA_INTQUEUEPROC
              SET   cod_estado  = EN_estado
              WHERE cod_aplic   = EV_cod_aplic
              AND   cod_modgener= EV_cod_modgener
              AND   cod_proceso = EN_cod_proceso;

         END IF;
              COMMIT;

         EXCEPTION
             WHEN OTHERS THEN
                 NULL;

    --    fin  CO-200604190066    24-04-2006 ipct


END GRABA_ERROR;

END VE_DEVOLUCION_PEDIDO_PG; 
/
SHOW ERRORS
