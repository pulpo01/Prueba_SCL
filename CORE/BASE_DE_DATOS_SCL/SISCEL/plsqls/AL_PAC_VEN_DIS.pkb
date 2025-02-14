CREATE OR REPLACE PACKAGE BODY al_pac_ven_dis
IS
   PROCEDURE insertar_al_petiguias_abo (
      v_num_venta      IN   al_cargos.num_venta%TYPE,
      v_num_terminal   IN   al_cargos.num_terminal%TYPE,
      v_num_abonado    IN   al_cargos.num_abonado%TYPE,
      v_cod_cliente    IN   al_cargos.cod_cliente%TYPE,
      v_cod_bodega     IN   al_cargos.cod_bodega%TYPE,
      v_cod_articulo   IN   al_cargos.cod_articulo%TYPE,
      v_num_unidades   IN   al_cargos.num_unidades%TYPE,
      v_cod_moneda     IN   al_cargos.cod_moneda%TYPE,
      v_imp_cargo      IN   al_cargos.imp_cargo%TYPE,
      v_num_serie      IN   al_cargos.num_serie%TYPE,
      v_num_cargo      IN   al_cargos.num_cargo%TYPE,
      v_cod_concepto   IN   al_cargos.cod_concepto%TYPE
   )
   IS
      v_cod_oficina   al_ventas.cod_oficina%TYPE;
      v_guia          al_petiguias_abo.num_peticion%TYPE;
   BEGIN
      SELECT cod_oficina
        INTO v_cod_oficina
        FROM al_ventas
       WHERE num_venta = v_num_venta;
      SELECT al_seq_petiguias.NEXTVAL
        INTO v_guia
        FROM DUAL;

      INSERT INTO al_petiguias_abo
                  (num_telefono, num_peticion, num_abonado, num_orden,
                   cod_cliente, cod_bodega, cod_articulo,
                   num_cantidad, cod_oficina, cod_moneda, val_linea,
                   num_serie, num_cargo, cod_concepto, num_venta)
           VALUES (v_num_terminal, v_guia, v_num_abonado, 1,
                   v_cod_cliente, v_cod_bodega, v_cod_articulo,
                   v_num_unidades, v_cod_oficina, v_cod_moneda, v_imp_cargo,
                   v_num_serie, v_num_cargo, v_cod_concepto, v_num_venta);
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20200,    'ErrPet'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_icc_movimiento (
      v_cod_uso             IN   al_cargos.cod_uso%TYPE,
      v_cod_articulo        IN   al_cargos.cod_articulo%TYPE,
      v_num_serie           IN   al_cargos.num_serie%TYPE,
      v_cod_central         IN   al_cargos.cod_central%TYPE,
      v_num_terminal        IN   al_cargos.num_terminal%TYPE,
      v_ind_telefono        IN   al_cargos.ind_telefono%TYPE,
      v_plan                IN   al_cargos.PLAN%TYPE,
      v_carga               IN   al_cargos.carga%TYPE,
      var_ind_activacion    IN   al_ventas.ind_activacion%TYPE,
      v_cod_ami_plantarif   IN   ga_datosgener.cod_ami_plantarif%TYPE,
      v_tip_tecnologia      IN   icc_movimiento.tip_tecnologia%TYPE, -- GSM
      v_imsi                IN   icc_movimiento.imsi%TYPE, -- GSM IMSI
      v_imei                IN   icc_movimiento.imei%TYPE, -- GSM IMEI
      v_icc                 IN   icc_movimiento.icc%TYPE -- GSM ICC
   )
   IS
      v_movimiento        icc_movimiento.num_movimiento%TYPE;
      v_actuacion         icc_movimiento.cod_actuacion%TYPE;
      v_actuacion_ami     icc_movimiento.cod_actuacion%TYPE;
      v_actuacion_nores   icc_movimiento.cod_actuacion%TYPE;
      v_minutos           icc_movimiento.num_min%TYPE;
      v_serhex            icc_movimiento.num_serie%TYPE;
      v_tip_terminal      icc_movimiento.tip_terminal%TYPE;
      v_comando           VARCHAR2 (500);
      v_val_parametro     ged_parametros.val_parametro%TYPE;
      v_tecnologia          al_tecnologia.cod_tecnologia%type;
   BEGIN
      SELECT icc_seq_nummov.NEXTVAL
        INTO v_movimiento
        FROM DUAL;

        BEGIN
             SELECT cod_tecnologia
             INTO   v_tecnologia
             FROM   icg_central
             WHERE cod_central =v_cod_central;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            v_tecnologia := null;
        END;

        BEGIN
                SELECT cod_actcen
             INTO   v_actuacion
             FROM   ga_actabo
             WHERE  cod_modulo ='AL'
             AND    cod_producto = 1
              AND    cod_tecnologia =v_tecnologia
             AND    cod_actabo ='AA';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            v_actuacion := null;
        END;
         --
        BEGIN
             SELECT cod_actcen
             INTO   v_actuacion_ami
             FROM   ga_actabo
             WHERE  cod_modulo ='AL'
             AND    cod_producto = 1
              AND    cod_tecnologia =v_tecnologia
             AND    cod_actabo ='MM';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            v_actuacion_ami := null;
        END;
         --
        BEGIN
             SELECT cod_actcen
             INTO   v_actuacion_nores
             FROM   ga_actabo
             WHERE  cod_modulo ='AL'
             AND    cod_producto = 1
              AND    cod_tecnologia =v_tecnologia
             AND    cod_actabo ='NA';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            v_actuacion_nores := null;
        END;
         --
      SELECT num_min
        INTO v_minutos
        FROM al_usos_min
       WHERE cod_uso = v_cod_uso
         AND fec_desde <= TRUNC (SYSDATE)
         AND NVL (fec_hasta, TRUNC (SYSDATE)) >= TRUNC (SYSDATE);
         --
      SELECT tip_terminal
        INTO v_tip_terminal
        FROM al_articulos
       WHERE cod_articulo = v_cod_articulo;
      al_proc_es_extra.p_conv_serhex (v_num_serie, v_serhex);

      IF v_ind_telefono = 1
      THEN
         INSERT INTO icc_movimiento
                     (num_movimiento, num_abonado, cod_estado, cod_modulo,
                      num_intentos, des_respuesta, cod_actuacion, cod_actabo,
                      nom_usuarora, fec_ingreso, cod_central, num_celular,
                      num_serie, tip_terminal, ind_bloqueo, num_min,
                      tip_tecnologia, imsi, imei, icc)
              VALUES (v_movimiento, 0, 1, 'AL',
                      0, 'PENDIENTE', v_actuacion, 'XX',
                      USER, SYSDATE, v_cod_central, v_num_terminal,
                      v_serhex, v_tip_terminal, 0, v_minutos,
                      v_tip_tecnologia, v_imsi, v_imei, v_icc);

         SELECT icc_seq_nummov.NEXTVAL
           INTO v_movimiento
           FROM DUAL;

                -- movimientos de alta amistar y alta amistar restringida necesitan
                -- la carga
-- Para poder parear , ingresamos el movimiento en la ga_movccontrol, como procesado .
--
         IF v_carga IS NOT NULL
         THEN
            v_comando :=    'm 9'
                         || v_num_terminal
                         || ',SERVICE=PPS,STATE=DISABLED,USER=INFOHIA|D 9'
                         || v_num_terminal
                         || ',SERVICE=PPS,USER=INFOHIA|'
                         || 'C 9'
                         || v_num_terminal
                         || ',SERVICE=PPS,COS='
                         || v_val_parametro
                         || ',SP=A1,TIME_ZONE=:America/Santiago,BALANCE='
                         || v_carga
                         || ',USER=INFOHIA';

            INSERT INTO ga_movccontrol
                        (num_linea, fec_inicio, cod_plantarif, ind_tipmov,
                         ind_procesado, cmd_comverse)
                 VALUES (v_num_terminal, SYSDATE, v_cod_ami_plantarif, '1',
                         1, v_comando);
         END IF;

         INSERT INTO icc_movimiento
                     (num_movimiento, num_abonado, cod_estado, cod_modulo,
                      num_intentos, des_respuesta, cod_actuacion, cod_actabo,
                      nom_usuarora, fec_ingreso, cod_central, num_celular,
                      num_serie, tip_terminal, ind_bloqueo, num_min, PLAN,
                      carga, tip_tecnologia, imsi, imei, icc)
              VALUES (v_movimiento, 0, 1, 'AL',
                      0, 'PENDIENTE', v_actuacion_ami, 'XX',
                      USER, SYSDATE, v_cod_central, v_num_terminal,
                      v_serhex, v_tip_terminal, 0, v_minutos, v_plan,
                      v_carga, v_tip_tecnologia, v_imsi, v_imei, v_icc);
      ELSE
         IF (    v_ind_telefono = 6
             AND var_ind_activacion = 1
            )
         THEN
            INSERT INTO icc_movimiento
                        (num_movimiento, num_abonado, cod_estado, cod_modulo,
                         num_intentos, des_respuesta, cod_actuacion,
                         cod_actabo, nom_usuarora, fec_ingreso, cod_central,
                         num_celular, num_serie, tip_terminal, ind_bloqueo,
                         num_min, tip_tecnologia, imsi, imei, icc)
                 VALUES (v_movimiento, 0, 1, 'AL',
                         0, 'PENDIENTE', v_actuacion_nores,
                         'XX', USER, SYSDATE, v_cod_central,
                         v_num_terminal, v_serhex, v_tip_terminal, 0,
                         v_minutos, v_tip_tecnologia, v_imsi, v_imei, v_icc);
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20203,    'ErrIcc'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_ga_ventas (var_ventas IN al_ventas%ROWTYPE)
   IS
      v_cod_plaza   ga_ventas.cod_plaza%TYPE;
   BEGIN
      v_cod_plaza := fn_obtiene_plazacliente (var_ventas.cod_cliente);

      INSERT INTO ga_ventas
                  (num_venta, cod_producto,
                   cod_oficina, cod_tipcomis,
                   cod_vendedor, cod_vendedor_agente,
                   num_unidades, fec_venta,
                   cod_region, cod_provincia,
                   cod_ciudad, ind_estventa, num_transaccion,
                   nom_usuar_vta, ind_venta,
                   imp_venta, ind_tipventa,
                   cod_cliente, cod_modventa,
                   tip_valor, cod_tiptarjeta,
                   num_tarjeta, cod_auttarj,
                   fec_vencitarj, cod_bancotarj,
                   num_ctacorr, num_cheque,
                   cod_banco, cod_sucursal,
                   fec_aceprec, cod_tipdocum,
                   tip_foliacion, cod_operadora,
                   cod_plaza)
           VALUES (var_ventas.num_venta, var_ventas.cod_producto,
                   var_ventas.cod_oficina, var_ventas.cod_tipcomis,
                   var_ventas.cod_vendedor, var_ventas.cod_vendedor_agente,
                   var_ventas.num_unidades, var_ventas.fec_venta,
                   var_ventas.cod_region, var_ventas.cod_provincia,
                   var_ventas.cod_ciudad, 'VP', var_ventas.num_transaccion,
                   var_ventas.nom_usuar_vta, var_ventas.ind_venta,
                   var_ventas.imp_venta, var_ventas.ind_tipventa,
                   var_ventas.cod_cliente, var_ventas.cod_modventa,
                   var_ventas.tip_valor, var_ventas.cod_tiptarjeta,
                   var_ventas.num_tarjeta, var_ventas.cod_auttarj,
                   var_ventas.fec_vencitarj, var_ventas.cod_bancotarj,
                   var_ventas.num_ctacorr, var_ventas.num_cheque,
                   var_ventas.cod_banco, var_ventas.cod_sucursal,
                   var_ventas.fec_aceprec, var_ventas.cod_tipdocum,
                   var_ventas.tip_foliacion, var_ventas.cod_operadora,
                   v_cod_plaza);
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20204,    'ErrVen'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_ge_cargos (
      var_cargos          IN   al_cargos%ROWTYPE,
      var_nom_usuar_vta        al_ventas.nom_usuar_vta%TYPE
   )
   IS
   BEGIN
      INSERT INTO ge_cargos
                  (num_cargo, cod_cliente,
                   cod_producto, cod_concepto,
                   fec_alta, imp_cargo,
                   cod_moneda, cod_plancom,
                   num_unidades, ind_factur,
                   num_transaccion, num_venta,
                   num_abonado, num_terminal,
                   cod_ciclfact, num_serie,
                   mes_garantia, cod_concepto_dto,
                   val_dto, tip_dto, nom_usuarora,
                   cod_tecnologia)
           VALUES (var_cargos.num_cargo, var_cargos.cod_cliente,
                   var_cargos.cod_producto, var_cargos.cod_concepto,
                   var_cargos.fec_alta, var_cargos.imp_cargo,
                   var_cargos.cod_moneda, var_cargos.cod_plancom,
                   var_cargos.num_unidades, var_cargos.ind_factur,
                   var_cargos.num_transaccion, var_cargos.num_venta,
                   var_cargos.num_abonado, var_cargos.num_terminal,
                   var_cargos.cod_ciclfact, var_cargos.num_serie,
                   var_cargos.mes_garantia, var_cargos.cod_concepto_dto,
                   var_cargos.val_dto, var_cargos.tip_dto, var_nom_usuar_vta,
                   var_cargos.cod_tecnologia);
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20205,    'ErrCar'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE upd_fa_interfact (
      v_folio         IN   al_ventas.num_folio%TYPE,
      v_num_venta     IN   VARCHAR2,
      v_fec_venci     IN   al_ventas.fec_vencimiento%TYPE,
      v_num_proceso   IN   fa_interfact.num_proceso%TYPE
   )
   IS
      v_fec_vencimiento   al_ventas.fec_vencimiento%TYPE;
   BEGIN
      IF v_fec_venci IS NOT NULL
      THEN
         v_fec_vencimiento := v_fec_venci;

         UPDATE fa_interfact
            SET cod_estadoc = 100,
                fec_ingreso = SYSDATE,
                cod_estproc = 3,
                num_folio = v_folio,
                fec_vencimiento = v_fec_vencimiento
          WHERE num_venta = v_num_venta
            AND num_proceso = v_num_proceso;
      ELSE
         UPDATE fa_interfact
            SET cod_estadoc = 100,
                fec_ingreso = SYSDATE,
                cod_estproc = 3,
                num_folio = v_folio
          WHERE num_venta = v_num_venta
            AND num_proceso = v_num_proceso;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20206,    'ErrFai'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE upd_ga_ventas (
      v_ind_estventa   IN   al_ventas.ind_estventa%TYPE,
      v_num_venta      IN   al_ventas.num_venta%TYPE
   )
   IS
   BEGIN
      UPDATE ga_ventas
         SET ind_estventa = v_ind_estventa
       WHERE num_venta = v_num_venta;
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20207,    'ErrUga'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_ga_docventa (
      v_num_venta      IN   al_ventas.num_venta%TYPE,
      v_cod_tipdocum   IN   al_ventas.cod_tipdocum%TYPE,
      v_num_folio      IN   al_ventas.num_folio%TYPE
   )
   IS
   BEGIN
      INSERT INTO ga_docventa
                  (num_venta, cod_tipdocum, num_folio)
           VALUES (v_num_venta, v_cod_tipdocum, v_num_folio);
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20208,    'ErrDov'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_ga_reservart (
      v_num_transaccion   IN   al_cargos.num_transaccion%TYPE,
      v_cod_articulo      IN   al_cargos.cod_articulo%TYPE,
      v_cod_bodega        IN   al_cargos.cod_bodega%TYPE,
      v_tip_stock         IN   al_cargos.tip_stock%TYPE,
      v_cod_estado        IN   al_cargos.cod_estado%TYPE,
      v_cod_uso           IN   al_cargos.cod_uso%TYPE,
      v_num_unidades      IN   al_cargos.num_unidades%TYPE,
      v_num_serie         IN   al_cargos.num_serie%TYPE,
      v_num_venta         IN   al_cargos.num_venta%TYPE,
      ilinea              IN   ga_reservart.num_linea%TYPE,
      iorden              IN   ga_reservart.num_orden%TYPE,
      v_cod_producto      IN   al_ventas.cod_producto%TYPE
   )
   IS
   BEGIN
      INSERT INTO ga_reservart
                  (num_transaccion, num_linea, num_orden, cod_articulo,
                   cod_producto, fec_reserva, cod_bodega, tip_stock,
                   cod_uso, cod_estado, num_unidades, nom_usuario,
                   num_serie, cap_code, num_venta)
           VALUES (v_num_transaccion, ilinea, iorden, v_cod_articulo,
                   v_cod_producto,   SYSDATE
                                   - 1, v_cod_bodega, v_tip_stock,
                   v_cod_uso, v_cod_estado, v_num_unidades, USER,
                   v_num_serie, NULL, v_num_venta);
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20209,    'ErrGar'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE obtener_servsupl (
      v_cod_producto     IN             al_cargos.cod_producto%TYPE,
      v_cod_articulo     IN             al_cargos.cod_articulo%TYPE,
      v_cod_tecnologia   IN             ga_actabo.cod_tecnologia%TYPE,
      v_cod_servicios    IN OUT NOCOPY  icg_actuaciontercen.cod_servicios%TYPE
   )
   IS
      v_tip_terminal   al_articulos.tip_terminal%TYPE;
      v_cod_actcen     ga_actabo.cod_actcen%TYPE;
      v_cod_actabo     ga_actabo.cod_actabo%TYPE;
   BEGIN
      v_cod_actabo := 'AM';
      SELECT DECODE (tip_terminal, 'T', 'G', tip_terminal)
        INTO v_tip_terminal
        FROM al_articulos
       WHERE cod_articulo = v_cod_articulo;

      SELECT cod_actcen
        INTO v_cod_actcen
        FROM ga_actabo
       WHERE cod_producto = v_cod_producto
         AND cod_actabo = v_cod_actabo
         AND cod_tecnologia = v_cod_tecnologia;

      SELECT cod_servicios
        INTO v_cod_servicios
        FROM icg_actuaciontercen
       WHERE cod_producto = v_cod_producto
         AND cod_actuacion = v_cod_actcen
         AND tip_terminal = v_tip_terminal
         AND tip_tecnologia = v_cod_tecnologia
         AND cod_sistema = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20213,    'ErrSSV'
                                          || TO_CHAR (SQLCODE));
   END;

  PROCEDURE insertar_ga_aboamist (
      v_num_abonado           IN               ga_aboamist.num_abonado%TYPE,
      v_cod_articulo          IN               al_cargos.cod_articulo%TYPE,
      v_num_terminal          IN               al_cargos.num_terminal%TYPE,
      v_cod_producto          IN               al_cargos.cod_producto%TYPE,
      v_cod_cliente           IN               al_cargos.cod_cliente%TYPE,
      v_cod_cuenta            IN               al_ventas.cod_cuenta%TYPE,
      v_cod_central           IN               al_cargos.cod_central%TYPE,
      v_cod_uso               IN               al_cargos.cod_uso%TYPE,
      v_cod_vendedor          IN               al_ventas.cod_vendedor%TYPE,
      v_cod_vendedor_agente   IN               al_ventas.cod_vendedor_agente%TYPE,
      v_num_serie             IN               al_cargos.num_serie%TYPE,
      v_num_venta             IN               al_ventas.num_venta%TYPE,
      v_cod_modventa          IN            al_ventas.cod_modventa%TYPE,
      v_cod_servicios         IN OUT NOCOPY icg_actuaciontercen.cod_servicios%TYPE,
      v_ind_telefono          IN               al_cargos.ind_telefono%TYPE,
      v_cod_plantarif         IN               ga_aboamist.cod_plantarif%TYPE,
      v_tip_plantarif         IN               ga_aboamist.tip_plantarif%TYPE,
      v_cod_usuario           IN               ga_usuarios.cod_usuario%TYPE,
      vs_ind_telefono         IN               al_series.ind_telefono%TYPE,
      vs_plan                 IN               al_series.PLAN%TYPE,
      vs_carga                IN               al_series.carga%TYPE,
      v_cod_tecnologia        IN               al_tecnologia.cod_tecnologia%TYPE, -- GSM
      v_imei                  IN               icc_movimiento.imei%TYPE, -- GSM
      v_cod_bodega_det        IN               npt_detalle_pedido.cod_bodega%TYPE,
      v_min_mdn                  IN               ga_aboamist.NUM_MIN_MDN%TYPE,
      v_cod_subalm              IN               al_series.COD_SUBALM%TYPE
   )
   IS
      v_tip_terminal     al_articulos.tip_terminal%TYPE;
      v_serhex           icc_movimiento.num_serie%TYPE;
      v_clase_servicio   ga_aboamist.clase_servicio%TYPE;
      v_perfil_abonado   ga_aboamist.perfil_abonado%TYPE;
      v_cod_ciudad       ga_aboamist.cod_ciudad%TYPE;
      v_cod_region       ga_aboamist.cod_region%TYPE;
      v_cod_provincia    ga_aboamist.cod_provincia%TYPE;
      v_cod_celda         ge_celdas.COD_CELDA%TYPE;
      v_cod_oficinaPrin  ga_aboamist.cod_oficina_principal%TYPE;
      v_cod_planserv     ga_aboamist.cod_planserv%TYPE;
      v_cod_cargobasico  ta_cargosbasico.cod_cargobasico%TYPE; --incidencia  XO-200509210709 IPCT

      -- 129251---
      LV_cod_prestacion  ga_aboamist.COD_PRESTACION%type;
      LE_error           exception;
      
      
-- COD_PASWORD , 4 ultimos digitos de la serie
   BEGIN
      SELECT tip_terminal
        INTO v_tip_terminal
        FROM al_articulos
       WHERE cod_articulo = v_cod_articulo;
       
      al_proc_es_extra.p_conv_serhex (v_num_serie, v_serhex);

      --Inicio  129251---
      v_clase_servicio:=null;
      v_perfil_abonado:=null;
      LV_cod_prestacion:=null;
      begin
          select clase_servicio, perfil_abonado,substr(trim(val_atributo),1,5)
            into v_clase_servicio,v_perfil_abonado,LV_cod_prestacion
            from al_atributos_articulos where cod_articulo=v_cod_articulo and rownum=1;
      EXCEPTION
        WHEN OTHERS THEN
            raise le_error;
      END;
     --FIN  129251---



     v_cod_servicios := v_clase_servicio;
     
    SELECT a.cod_ciudad, a.cod_region, a.cod_provincia, a.cod_celda
    INTO v_cod_ciudad, v_cod_region, v_cod_provincia, v_cod_celda
    FROM ge_ciudades a, ge_celdas b
    WHERE a.cod_celda = b.cod_celda
    AND b.cod_subalm = v_cod_subalm
    AND rownum = 1;

      select VALOR_PARAMETRO into v_cod_planserv
      from npt_parametro
      where ALIAS_PARAMETRO = 'PLAN_SERV';

    v_cod_oficinaPrin := PV_OBTENER_OFIPRINC_FN(v_cod_region, v_cod_provincia, v_cod_ciudad);

 --inicio XO-200509210709 IPCT
    BEGIN
        SELECT NVL(cod_cargobasico,NULL)
        INTO v_cod_cargobasico
        FROM TA_PLANTARIF
        WHERE cod_plantarif = v_cod_plantarif;

    EXCEPTION
        WHEN OTHERS THEN
            v_cod_cargobasico:= NULL;
    END;
-- XO-200509210709 Inicio : Responsable cambio : Zenen Muñoz H. : fecha:12-10-2005 :  Desc: Cambio de condición de '=' a 'is' *
    if (v_cod_cargobasico is null) then
-- Fin incidencia XO-200509210709
       v_cod_cargobasico:= 'AMI';
    end if;
    --fin XO-200509210709 IPCT

      -- ind_procalta, 1-interno, 0-externo
      INSERT INTO ga_aboamist
                  (num_abonado, num_celular, cod_producto,
                   cod_cliente, cod_cliente_dist, cod_cuenta, cod_cuenta_dist,
                   cod_central, cod_uso, cod_situacion, ind_procalta,
                   ind_procequi, cod_vendedor, cod_vendedor_agente,
                   tip_terminal, cod_planserv, num_serie, num_seriehex,
                   nom_usuarora, fec_alta, num_seriemec, num_venta,
                   cod_modventa, ind_suspen, ind_rehabi, fec_acepventa,
                   fec_actcen, fec_baja, fec_bajacen, fec_ultmod,
                   cod_causabaja, clase_servicio, perfil_abonado,
                   cod_vendealer, ind_disp,
                   cod_password, ind_password,
                   cod_plantarif, tip_plantarif, cod_usuario, cod_cargobasico, plan_kit,  --insert de cod_cargobasico XO-200509210709 IPCT
                   carga_inicial, ind_telefono, cod_tecnologia, num_imei,
                   cod_ciudad, cod_region, cod_provincia, num_min_mdn, cod_celda, cod_oficina_principal,cod_prestacion) 
           VALUES (v_num_abonado, v_num_terminal, v_cod_producto,
                   v_cod_cliente, v_cod_cliente, v_cod_cuenta, v_cod_cuenta,
                   v_cod_central, v_cod_uso, 'AAA', '1',
                   'I', v_cod_vendedor, v_cod_vendedor_agente,
                   v_tip_terminal, v_cod_planserv, v_num_serie, v_serhex,
                   USER, SYSDATE, NULL, v_num_venta,
                   v_cod_modventa, 0, 0, SYSDATE,
                   SYSDATE, NULL, NULL, NULL,
                   NULL, v_clase_servicio, v_perfil_abonado,
                   NULL, NULL,
                   SUBSTR (v_num_serie,   LENGTH (v_num_serie)
                                        - 3, 4), NULL,
                   v_cod_plantarif, v_tip_plantarif, v_cod_usuario, v_cod_cargobasico, vs_plan,  --insert de v_cod_cargobasico XO-200509210709 IPCT
                   vs_carga, vs_ind_telefono, v_cod_tecnologia, v_imei,
                   v_cod_ciudad, v_cod_region, v_cod_provincia, v_min_mdn, v_cod_celda,v_cod_oficinaPrin,lv_cod_prestacion);
   EXCEPTION
      WHEN le_error 
      THEN
          RAISE_APPLICATION_ERROR (-20211, 'Problemas al obtener clase servicio, perfil abonado y cod.prestacion.'|| TO_CHAR (SQLCODE));

      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20210,    'ErrAboAmi' || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_ga_usuamist (
      v_num_abonado    IN   ga_aboamist.num_abonado%TYPE,
      v_cod_tipident   IN   ge_clientes.cod_tipident%TYPE,
      v_num_ident      IN   ge_clientes.num_ident%TYPE,
      v_cod_usuario    IN   ga_usuarios.cod_usuario%TYPE
   )
   IS
      v_nom_usuario     ga_usuarios.nom_usuario%TYPE;
      v_nom_apellido1   ga_usuarios.nom_apellido1%TYPE;
   BEGIN
      v_nom_usuario := 'SIN USUARIO';
      v_nom_apellido1 := '.';

      INSERT INTO ga_usuamist
                  (cod_usuario, num_abonado, nom_usuario,
                   nom_apellido1, fec_alta, cod_tipident, num_ident)
           VALUES (v_cod_usuario, v_num_abonado, v_nom_usuario,
                   v_nom_apellido1, SYSDATE, v_cod_tipident, v_num_ident);
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20213,    'ErrUsuAmi'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_ga_equipaboser (
      v_num_abonado          IN   ga_aboamist.num_abonado%TYPE,
      v_num_serie            IN   al_cargos.num_serie%TYPE,
      v_cod_producto         IN   al_cargos.cod_producto%TYPE,
      v_cod_bodega           IN   al_cargos.cod_bodega%TYPE,
      v_tip_stock            IN   al_cargos.tip_stock%TYPE,
      v_cod_articulo         IN   al_cargos.cod_articulo%TYPE,
      v_cod_modventa         IN   al_ventas.cod_modventa%TYPE,
      v_cod_uso              IN   al_cargos.cod_uso%TYPE,
      v_cod_estado           IN   al_cargos.cod_estado%TYPE,
      v_des_cadena           IN   ga_transacabo.des_cadena%TYPE,
      v_num_serie_terminal   IN   ga_equipaboser.num_imei%TYPE, -- GSM
      v_cod_tecnologia         IN   al_cargos.COD_TECNOLOGIA%TYPE
   )
   IS
      v_tip_terminal     al_articulos.tip_terminal%TYPE;
      v_des_articulo     al_articulos.des_articulo%TYPE;
      v_des_cadena_aux   ga_transacabo.des_cadena%TYPE;
      v_num_movto        al_movimientos.num_movimiento%TYPE;
   BEGIN
      SELECT tip_terminal, des_articulo
        INTO v_tip_terminal, v_des_articulo
        FROM al_articulos
       WHERE cod_articulo = v_cod_articulo;

      --SELECT REPLACE (v_des_cadena, '/0/', '')
      --INTO v_des_cadena_aux
      --FROM DUAL;

      v_des_cadena_aux:= REPLACE (v_des_cadena, '/0/', '');

      --SELECT TO_NUMBER (REPLACE (v_des_cadena_aux, '/', ''))
      --INTO v_num_movto
      --FROM DUAL;

      v_num_movto:= TO_NUMBER (REPLACE (v_des_cadena_aux, '/', ''));

      INSERT INTO ga_equipaboser
                  (num_abonado, num_serie, cod_producto, ind_procequi,
                   fec_alta, ind_propiedad, cod_bodega, tip_stock,
                   cod_articulo, ind_equiacc, cod_modventa, tip_terminal,
                   cod_uso, cod_cuota, cod_estado, cap_code, cod_protocolo,
                   num_velocidad, cod_frecuencia, cod_version, num_seriemec,
                   des_equipo, cod_paquete, num_movimiento, cod_causa,
                   num_imei, cod_tecnologia )
           VALUES (v_num_abonado, v_num_serie, v_cod_producto, 'I',
                   SYSDATE, 'C', v_cod_bodega, v_tip_stock,
                   v_cod_articulo, 'E', v_cod_modventa, v_tip_terminal,
                   v_cod_uso, NULL, v_cod_estado, NULL, NULL,
                   NULL, NULL, NULL, NULL,
                   v_des_articulo, NULL, v_num_movto, NULL,
                   v_num_serie_terminal, v_cod_tecnologia);
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20211,    'ErrAboSer'
                                          || TO_CHAR (SQLCODE));
   END;

   PROCEDURE insertar_ga_servsuplabo (
      v_num_abonado     IN   ga_aboamist.num_abonado%TYPE,
      v_cod_producto    IN   al_cargos.cod_producto%TYPE,
      v_num_terminal    IN   al_cargos.num_terminal%TYPE,
      v_cod_servicios   IN   icg_actuaciontercen.cod_servicios%TYPE
   )
   IS
      v_cont                  NUMBER;
      v_cod_servsupl          ga_servsupl.cod_servsupl%TYPE;
      v_cod_nivel             ga_servsupl.cod_nivel%TYPE;
      v_cod_actabo_fa         ga_actabo.cod_actabo%TYPE;
      v_serv_suplementarios   NUMBER (1);
   BEGIN
      -- IND_ESTADO DE GA_SERVSUPLABO
      -- 1-alta en BD
      -- 2-alta en centrales,actualizado por centrales
      -- 3-baja en BD
      -- 4-baja en centrales,actualizado por centrales
      -- 5-baja abonado
      -- 6-anulacion baja abonado
      -- usamos 2 porque no esperamos a que centrales
      -- procese nuestro movimiento
      -- servicios son del tipo '090000140004'
      v_cod_actabo_fa := 'FA';
      v_serv_suplementarios := 2;

      FOR v_cont IN 0 ..   ((LENGTH (v_cod_servicios)) / 6)
                         - 1
      LOOP
         --SELECT TO_NUMBER (SUBSTR (v_cod_servicios,   (v_cont * 6) + 1, 2))
         --INTO v_cod_servsupl
         --FROM DUAL;

         v_cod_servsupl:= TO_NUMBER (SUBSTR (v_cod_servicios,   (v_cont * 6) + 1, 2));

         --SELECT TO_NUMBER (SUBSTR (v_cod_servicios,   (v_cont * 6) + 3, 4))
         --INTO v_cod_nivel
         --FROM DUAL;

         v_cod_nivel:= TO_NUMBER (SUBSTR (v_cod_servicios,   (v_cont * 6) + 3, 4));

         -- solo graba cod_concepto si esta asociado a 'FA' de la ga_actuaserv
         -- solo graba el registro si cod_nivel <> 0
         INSERT INTO ga_servsuplabo
                     (num_abonado, cod_servicio, fec_altabd, cod_servsupl,
                      cod_nivel, cod_producto, num_terminal, nom_usuarora,
                      ind_estado, fec_altacen, fec_bajabd, fec_bajacen,
                      cod_concepto, num_diasnum)
            SELECT v_num_abonado, a.cod_servicio, SYSDATE, a.cod_servsupl,
                   a.cod_nivel, v_cod_producto, v_num_terminal, USER, 2,
                   SYSDATE, NULL, NULL, e.cod_concepto, NULL
              FROM ga_servsupl a, ga_actuaserv e
             WHERE a.cod_servsupl = v_cod_servsupl
               AND a.cod_nivel = v_cod_nivel
               AND a.cod_producto = v_cod_producto
               AND a.cod_producto = e.cod_producto(+)
               AND a.cod_servicio = e.cod_servicio(+)
               AND e.cod_actabo(+) = v_cod_actabo_fa
               AND e.cod_tipserv(+) = v_serv_suplementarios;
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20212,    'ErrSuplAbo'
                                          || TO_CHAR (SQLCODE));
   END;
END al_pac_ven_dis; 
/
SHOW ERRORS