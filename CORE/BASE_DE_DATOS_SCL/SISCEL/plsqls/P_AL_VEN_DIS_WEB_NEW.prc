CREATE OR REPLACE PROCEDURE p_al_ven_dis_web_new (
   v_num_venta       IN            NUMBER,
   v_num_proceso     IN            NUMBER,
   v_cod_pedido      IN            npt_pedido.cod_pedido%TYPE,
   v_tip_foliacion   IN            fa_gencentremi.tip_foliacion%TYPE,
   v_errores         OUT NOCOPY    al_errores_web%ROWTYPE,
   v_err_pedido      OUT NOCOPY    NUMBER
)
IS
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "p_al_ven_dis_web_new" Lenguaje="PL/SQL" Fecha="26-04-2006" Versión="1.0.0"
        Diseñador="****" Programador="****" Ambiente="BD">
<Retorno>               : NA</Retorno>
<Parámetros>
<Entrada></Entrada>
<Salida></Salida>
</Parámetros>
</Elemento>
</Documentación>

<Versionmod>="1.1"  </Versionmod>
<Fechamod> : 10-10-2007 </Fechamod>
<Desmod> : Se agrega en la lista de valores, el campo: LN_ClieMayorista, el que establece que un cliente es mayorista o no,
           con esto se establece cuando rescatar los artículos no seriados para realizar la baja definitiva. Inc 44724
<Versionmod>="1.2"  </Versionmod>
<Fechamod> : 25-10-2007 </Fechamod>
<Desmod> :  Se comenta salida definitiva para Mayorista o Dealer, se hace para todos, 25-10-2007. ZMH 44724
            Para que acepte el movimiento de articulos no seriados, para Mayoristas o Dealers.
<FECHAMOD >    : 11/08/2009 </FECHAMOD >
<DESCMOD >     : Modificación a PL para: P-MIX-09003-Guatemala-Salvador   </DESCMOD >
<VERSIONMOD>   : 1.3    </VERSIONMOD>
<AUTOR>        : Z.M.H. </AUTORMOD>

--   LN_ClieMayorista  IN            NUMBER DEFAULT 0
 </Desmod>

*/

   TYPE al_componente_kit_plus IS RECORD (
      num_kit                       al_componente_kit.num_kit%TYPE,
      cod_kit                       al_componente_kit.cod_kit%TYPE,
      cod_articulo                  al_componente_kit.cod_articulo%TYPE,
      num_serie                     al_componente_kit.num_serie%TYPE,
      can_articulo                  al_componente_kit.can_articulo%TYPE,
      cod_bodega                    al_componente_kit.cod_bodega%TYPE,
      tip_stock                     al_componente_kit.tip_stock%TYPE,
      cod_uso                       al_componente_kit.cod_uso%TYPE,
      cod_estado                    al_componente_kit.cod_estado%TYPE,
      num_desde                     al_componente_kit.num_desde%TYPE,
      num_hasta                     al_componente_kit.num_hasta%TYPE,
      fec_entrada                   al_componente_kit.fec_entrada%TYPE,
      ind_telefono                  al_componente_kit.ind_telefono%TYPE,
      cap_code                      al_componente_kit.cap_code%TYPE,
      num_telefono                  al_componente_kit.num_telefono%TYPE,
      num_seriemec                  al_componente_kit.num_seriemec%TYPE,
      prc_compra                    al_componente_kit.prc_compra%TYPE,
      cod_producto                  al_componente_kit.cod_producto%TYPE,
      cod_central                   al_componente_kit.cod_central%TYPE,
      cod_subalm                    al_componente_kit.cod_subalm%TYPE,
      cod_cat                       al_componente_kit.cod_cat%TYPE,
      num_sec_loca                  al_componente_kit.num_sec_loca%TYPE,
      PLAN                          al_componente_kit.PLAN%TYPE,
      carga                         al_componente_kit.carga%TYPE,
      num_serie_terminal            al_componente_kit.num_serie%TYPE,
      tipo_terminal                 al_articulos.tip_terminal%TYPE,
      cod_tecnologia                al_tecnologia.cod_tecnologia%TYPE);

   v_is_kit                NUMBER (1);
   v_caducada              al_ventas.num_venta%TYPE;
   v_registro              al_cargos%ROWTYPE;
   v_cod_tecnologia        al_tecnologia.cod_tecnologia%TYPE;
   reg_ventas              al_ventas%ROWTYPE;
   reg_al_componente_kit   al_componente_kit_plus;
   v_transaccion           ga_transacabo.num_transaccion%TYPE;
   v_transacventa          ga_transacabo.num_transaccion%TYPE;
   v_actabo                VARCHAR2 (2);
   v_flag                  VARCHAR2 (1);
   v_producto              ge_productos.cod_producto%TYPE;
   v_cliente               ge_clientes.cod_cliente%TYPE;
   v_origen                al_ventas.num_venta%TYPE;
   v_destino               al_ventas.num_transaccion%TYPE;
   --  v_num_proceso           fa_interfact.num_proceso%TYPE;
   v_modgener              fa_gencentremi.cod_modgener%TYPE;
   v_fechafact             VARCHAR2 (10);
   var_num_venta           al_ventas.num_venta%TYPE;
   var_cod_oficina         al_ventas.cod_oficina%TYPE;
   var_cod_tipdocum        al_ventas.cod_tipdocum%TYPE;
   var_cod_centremi        al_docum_sucursal.cod_centremi%TYPE;
   v_cod_catribut          fa_gencentremi.cod_catribut%TYPE;
   v_doc_guia              al_ventas.cod_tipdocum%TYPE;
   v_doc_boleta            al_ventas.cod_tipdocum%TYPE;
   v_folio                 al_ventas.num_folio%TYPE;
   v_cod_retorno           ga_transacabo.cod_retorno%TYPE;
   v_tipomov               al_gainteral.tipo%TYPE;
   v_ilinea                ga_reservart.num_linea%TYPE;
   v_iorden                ga_reservart.num_orden%TYPE;
   v_des_cadena            ga_transacabo.des_cadena%TYPE;
   v_reg_interal           al_gainteral%ROWTYPE;
   v_ind_estventa          al_ventas.ind_estventa%TYPE;
   v_total_series          NUMBER;
   v_total_cargos          NUMBER;
   v_inter                 ga_pac_interal.type_inter;
   errorc                  al_ventas.SQLCODE%TYPE;
   errorm                  al_ventas.SQLERRM%TYPE;
   v_cod_servicios         icg_actuaciontercen.cod_servicios%TYPE;
   v_num_abonado           ga_aboamist.num_abonado%TYPE;
   v_cod_tipident          ge_clientes.cod_tipident%TYPE;
   v_num_ident             ge_clientes.num_ident%TYPE;
   v_cod_ami_plantarif     ga_abocel.cod_plantarif%TYPE;
   v_tip_ami_plantarif     ga_abocel.tip_plantarif%TYPE;
   v_cod_usuario           ga_usuarios.cod_usuario%TYPE;
   v_imsi                  icc_movimiento.imsi%TYPE;
   sformatofecha           ged_parametros.val_parametro%TYPE;
   v_cod_vendedor_aux      ga_ventas.cod_vendedor%TYPE;
   v_cod_bodega_det        npt_detalle_pedido.cod_bodega%TYPE;
   v_tip_articulo_kit      ged_parametros.val_parametro%TYPE;
   v_min_mdn                   ga_aboamist.NUM_MIN_MDN%TYPE;

   LV_ind_equiacc                  al_articulos.ind_equiacc%TYPE;
   LV_tip_terminal                 al_articulos.tip_terminal%TYPE;
   LB_sal_imei                     npt_parametro.valor_parametro%TYPE;
   ln_num_dias            NUMBER;
   
   v_valparam_clinofac            npt_parametro.valor_parametro%TYPE;
   v_factcli_aplica              boolean;
   v_clinofac_count              NUMBER;


   ---****INCIDENCIA XO-200611011241*****------
   LV_cod_tipcomis_may  ged_codigos.COD_VALOR%TYPE :=0;
   LV_cod_tipcomis      ve_vendedores.COD_TIPCOMIS%TYPE :=0;
   LN_cod_cliente       NPT_PEDIDO.COD_CLIENTE%TYPE;
   CV_VE                    CONSTANT VARCHAR2(3) := 'VE';
   CV_VE_TIPCOMIS       CONSTANT VARCHAR2(15) := 'VE_TIPCOMIS';
   CV_COD_TIPCOMIS      CONSTANT VARCHAR2(15) := 'COD_TIPCOMIS';
   LB_MovimientoInv     BOOLEAN;
   CN_POSTPAGO          CONSTANT PLS_INTEGER:=2;
   CN_PREPAGO                   CONSTANT PLS_INTEGER:=3;
   CV_COD_TIP_DOC_PEDIDO  PLS_INTEGER:=6; -- TRASPASO MERCADERIA DEALER 





  CURSOR c_kit (vc_num_serie al_componente_kit.num_kit%TYPE)
   IS
                 SELECT  A.NUM_KIT,A.COD_KIT,A.COD_ARTICULO,A.NUM_SERIE,
                 A.CAN_ARTICULO,A.COD_BODEGA ,A.TIP_STOCK,
                 A.COD_USO,A.COD_ESTADO,A.NUM_DESDE,A.NUM_HASTA,A.FEC_ENTRADA,A.IND_TELEFONO,A.CAP_CODE,
                 NVL(A.NUM_TELEFONO,0) NUM_TELEFONO,A.NUM_SERIEMEC,A.PRC_COMPRA,A.COD_PRODUCTO,A.COD_CENTRAL,
                 A.COD_SUBALM,A.COD_CAT,A.NUM_SEC_LOCA,A.PLAN,A.CARGA,
                 DECODE(B.TIP_TERMINAL ,'G',X.NUM_SERIE_TERMINAL) NUM_SERIE_TERMINAL,B.TIP_TERMINAL , f.COD_TECNOLOGIA
                  FROM AL_COMPONENTE_KIT A, AL_ARTICULOS B, AL_TIPOS_TERMINALES D , al_tecnoarticulo_td f ,
                     (
                     SELECT AX.NUM_SERIE NUM_SERIE_TERMINAL,AX.NUM_KIT
                         FROM   AL_COMPONENTE_KIT AX,AL_ARTICULOS BX
                         WHERE  BX.TIP_TERMINAL = 'T'  AND AX.NUM_KIT = vc_num_serie
                          AND AX.COD_ARTICULO = BX.COD_ARTICULO
                         ) x
                         WHERE x.num_kit = vc_num_serie AND
                         x.num_kit = a.num_kit AND
                         a.cod_articulo = b.cod_articulo AND
                         b.tip_terminal = d.tip_terminal (+) AND
                         d.TIP_TERMINAL IN ( 'G','T','D'  )  AND
                         B.IND_EQUIACC = 'E' AND
                         B.COD_PRODUCTO = D.COD_PRODUCTO (+)
                         AND b.COD_ARTICULO = f.COD_ARTICULO;


/*
   CURSOR c_kit (vc_num_serie al_componente_kit.num_kit%TYPE)
   IS
    SELECT a.num_kit, a.cod_kit, a.cod_articulo, a.num_serie,
             a.can_articulo, a.cod_bodega, a.tip_stock, a.cod_uso,
             a.cod_estado, a.num_desde, a.num_hasta, a.fec_entrada,
             a.ind_telefono, a.cap_code,
             NVL (a.num_telefono, 0) AS num_telefono, a.num_seriemec,
             a.prc_compra, a.cod_producto, a.cod_central, a.cod_subalm,
             a.cod_cat, a.num_sec_loca, a.PLAN, a.carga,
             DECODE (b.tip_terminal, 'G', x.num_serie_terminal) AS num_serie_terminal,
             b.tip_terminal, f.cod_tecnologia
        FROM al_componente_kit a,
             al_articulos b,
             al_tipos_terminales d, al_tecnoarticulo_td f ,
             (SELECT ax.num_serie AS num_serie_terminal, ax.num_kit
                FROM al_componente_kit ax, al_articulos bx
               WHERE bx.tip_terminal = 'T'
                 AND ax.num_kit = vc_num_serie
                 AND ax.cod_articulo = bx.cod_articulo) x
       WHERE a.num_kit = vc_num_serie
         AND a.cod_articulo = b.cod_articulo
         AND b.tip_articulo = 1
         AND a.num_kit = x.num_kit(+)
         AND b.ind_equiacc = 'E'
         AND b.cod_producto = d.cod_producto(+)
         AND b.tip_terminal = d.tip_terminal(+)
         AND b.tip_terminal IN ('G', 'T', 'D')
                 AND b.COD_ARTICULO = f.COD_ARTICULO;
*/

   CURSOR cargos
   IS
      SELECT   *
          FROM al_cargos
         WHERE num_venta = v_num_venta
           AND num_cargo > -1
      ORDER BY num_venta, num_cargo;

   CURSOR ventas
   IS
      SELECT   *
          FROM al_ventas
         WHERE cod_estado = 'PW'
           AND num_venta = v_num_venta
      ORDER BY num_venta;

   CURSOR series_conceptos (v_tip_articulo_kit     ged_parametros.val_parametro%TYPE )
   IS
      -- Seleccion de los articulos no KIT
      SELECT a.cod_articulo, a.cod_bodega, a.tip_stock, a.cod_estado,
             a.cod_uso, 1, a.num_serie, v_num_venta, a.cod_producto,
             a.ind_telefono, a.num_telefono, a.cod_central, a.ind_telefono,
             a.PLAN, a.carga, f.cod_bodega
                   AS cod_bodega_det, -- adicion tip_tecnologia GSM
                         c.cod_tecnologia,
                         a.COD_SUBALM,
                         e.IND_EQUIACC,
                         e.TIP_TERMINAL
        FROM al_series a,
             npt_serie_pedido b,
             npt_detalle_pedido c,
             al_articulos e,
             al_tipos_terminales d,
             npt_pedido f
       WHERE a.num_serie = b.cod_serie_pedido
         AND c.cod_pedido = f.cod_pedido
         AND b.cod_pedido = v_cod_pedido
         AND b.cod_pedido = c.cod_pedido
         AND b.lin_det_pedido = c.lin_det_pedido
         AND a.cod_uso IN (SELECT val_parametro
                             FROM ged_parametros
                            WHERE nom_parametro LIKE 'USO_PREPAGO%') -- GSM 
         AND f.tip_doc_pedido != CV_COD_TIP_DOC_PEDIDO                   
         AND a.cod_articulo = e.cod_articulo
         AND e.cod_producto = d.cod_producto(+)
         AND e.tip_terminal = d.tip_terminal(+)
         AND e.tip_articulo != v_tip_articulo_kit
--               AND e.ind_equiacc != DECODE(LV_ind_equiacc,null,' ',LV_ind_equiacc)
--               AND e.tip_terminal != DECODE(LV_tip_terminal,null,' ',LV_tip_terminal)
      UNION
      -- Seleccion de los kit
      SELECT a.cod_articulo, a.cod_bodega, a.tip_stock, a.cod_estado,
             a.cod_uso, 1, a.num_serie, v_num_venta, a.cod_producto,
             a.ind_telefono, a.num_telefono, a.cod_central, a.ind_telefono,
             a.PLAN, a.carga,
             f.cod_bodega AS cod_bodega_det,  -- adicion tip_tecnologia GSM
                         NULL AS cod_tecnologia,
                         a.COD_SUBALM,
                         e.IND_EQUIACC,
                         e.TIP_TERMINAL
        FROM al_series a,
             npt_serie_pedido b,
             npt_detalle_pedido c,
             al_articulos e,
             npt_pedido f
       WHERE a.num_serie = b.cod_serie_pedido
         AND c.cod_pedido = f.cod_pedido
         AND b.cod_pedido = v_cod_pedido
         AND b.cod_pedido = c.cod_pedido
         AND b.lin_det_pedido = c.lin_det_pedido
         AND a.cod_uso IN (SELECT val_parametro
                             FROM ged_parametros
                            WHERE nom_parametro LIKE 'USO_PREPAGO%') -- GSM 
         AND f.tip_doc_pedido != CV_COD_TIP_DOC_PEDIDO                             
         AND a.cod_articulo = e.cod_articulo
         AND e.tip_articulo = v_tip_articulo_kit
-- Inicio Inc 44724, Zenén Muñoz H., control de salida definitiva para Clientes Dealer.
         UNION
         SELECT a.cod_articulo, f.cod_bodega, a.tip_stock, a.cod_estado,
                a.cod_uso , c.can_asig_detalle_pedido cantidad, NULL NUM_SERIE, v_num_venta,
                1 COD_PRODUCTO, 0 IND_TELEFONO, 0 NUM_TELEFONO, 0 COD_CENTRAL,  0 IND_TELEFONO,
                '0' PLAN,  0 CARGA, f.cod_bodega AS cod_bodega_det, c.cod_tecnologia,
                'XX' COD_SUBALM, e.IND_EQUIACC, e.TIP_TERMINAL
         FROM al_stock a, npt_detalle_pedido c, al_articulos e, npt_pedido f
         WHERE c.cod_pedido = f.cod_pedido
         AND f.cod_pedido = v_cod_pedido
         AND a.cod_uso = c.cod_uso
         AND a.cod_articulo = c.cod_articulo
         AND a.cod_articulo = e.cod_articulo
         AND a.cod_estado = c.cod_estado
         AND a.tip_stock = c.tip_stock
         AND A.COD_BODEGA=C.COD_BODEGA
         AND e.IND_SERIADO = 0
         AND e.IND_EQUIACC ='A';
-- Se comenta salida definitiva para Mayorista o Dealer, se hace para todos, 25-10-2007. ZMH 44724
--         AND LN_ClieMayorista = 0;
-- Fin Inc 44724

   error_venta             EXCEPTION;
   exception_intabo        EXCEPTION;
   exception_interal       EXCEPTION;
   exception_series        EXCEPTION;
   error_proceso_general   EXCEPTION;
   v_paso                  VARCHAR2 (1024);
BEGIN
   /* Ahora comienza el proceso ------------------------------------------------*/
   v_paso := '(VEN_DIS_WEB) COMIENZA VEN_DIS_WEB';
   v_err_pedido := 0;
   v_actabo := 'PB';
   v_producto := '5';
   sformatofecha := ge_pac_general.param_general ('FORMATO_SEL2');

        -- SE
    SELECT val_parametro
    INTO v_tip_articulo_kit
        FROM ged_parametros
        WHERE cod_modulo='AL'
        AND nom_parametro='TIP_ARTICULO_KIT'
        AND cod_producto=1;

        SELECT a.valor_parametro
        INTO LB_sal_imei
        FROM npt_parametro a
        WHERE a.cod_parametro > 0
        AND a.alias_parametro = 'SAL_IMEI';

        IF LB_sal_imei = 'TRUE' THEN
           LV_ind_equiacc := 'E';
           LV_tip_terminal := 'T';
        END IF;

   OPEN ventas;

   LOOP
      errorm := NULL;
      FETCH ventas INTO reg_ventas;
      EXIT WHEN ventas%NOTFOUND;
      v_err_pedido := 0;
      v_paso :=
               '(VEN_DIS_WEB) CUENTA SERIES DE VENTA='
            || reg_ventas.num_venta;
      SELECT COUNT (*)
        INTO v_total_series
        FROM al_series a, al_cargos b, al_ventas c
       WHERE a.num_serie > '0'
         AND b.num_cargo > 0
         AND c.num_venta > 0
         AND c.num_venta = reg_ventas.num_venta
         AND b.num_venta = c.num_venta
         AND c.cod_estado = 'PW'
         AND a.num_serie = b.num_serie
         AND a.tip_stock = b.tip_stock
         AND a.cod_uso = b.cod_uso
         AND a.cod_bodega = b.cod_bodega
         AND a.cod_estado = b.cod_estado
         AND a.cod_articulo = b.cod_articulo;

      IF v_total_series = 0
      THEN
         v_paso :=    '(VEN_DIS_WEB) VERIFICA SERIES EN STOCK PARA VENTA= '
                   || reg_ventas.num_venta;
         SELECT SUM (a.can_stock)
           INTO v_total_series
           FROM al_stock a, al_cargos b, al_ventas c
          WHERE b.num_cargo > 0
            AND c.num_venta > 0
            AND c.num_venta = reg_ventas.num_venta
            AND b.num_venta = c.num_venta
            AND c.cod_estado = 'PW'
            AND a.tip_stock = b.tip_stock
            AND a.cod_uso = b.cod_uso
            AND a.cod_bodega = b.cod_bodega
            AND a.cod_estado = b.cod_estado
            AND a.cod_articulo = b.cod_articulo;
         v_paso :=
                  '(VEN_DIS_WEB) CUENTA UNIDADES DE CONCEPTOS PARA VENTA= '
               || reg_ventas.num_venta;
         SELECT SUM (a.num_unidades)
           INTO v_total_cargos
           FROM al_cargos a, al_ventas b
          WHERE a.num_cargo > 0
            AND b.num_venta = reg_ventas.num_venta
            AND a.num_venta = b.num_venta
            AND b.cod_estado = 'PW';

         IF v_total_cargos > v_total_series
         THEN
            v_paso :=
                     '(VEN_DIS_WEB) SERIES SOLICITADAS MAYOR QUE STOCK (VENTA = '
                  || reg_ventas.num_venta
                  || ')';
            v_errores.glosa_error_venta := SQLERRM;
            RAISE error_proceso_general;
         END IF;
      ELSE
         SELECT COUNT (*)
           INTO v_total_cargos
           FROM al_cargos a, al_ventas b
          WHERE a.num_cargo > 0
            AND b.num_venta = reg_ventas.num_venta
            AND a.num_venta = b.num_venta
            AND b.cod_estado = 'PW';

         IF v_total_cargos <> v_total_series
         THEN
            v_paso :=
                     '(VEN_DIS_WEB) SERIES DISTINTAS A LAS DE STOCK. (VENTA='
                  || reg_ventas.num_venta
                  || ')';
            v_errores.glosa_error_venta := SQLERRM;
            RAISE error_proceso_general;
         END IF;
      END IF;

      var_num_venta := reg_ventas.num_venta;
      SELECT ga_seq_transacabo.NEXTVAL
        INTO v_transacventa
        FROM DUAL;
      v_paso :=
               '(VEN_DIS_WEB) ACTUALIZAR NUM_TRANSACCION DE AL_VENTAS Y AL_CARGOS (VENTA= '
            || reg_ventas.num_venta
            || ')';

      UPDATE al_ventas
         SET num_transaccion = v_transacventa
       WHERE num_venta = reg_ventas.num_venta;

      v_paso :=
               '(VEN_DIS_WEB) ACTUALIZAR NUM_TRANSACCION DE AL_CARGOS (VENTA= '
            || reg_ventas.num_venta
            || ')';

      UPDATE al_cargos
         SET num_transaccion = v_transacventa
       WHERE num_venta = reg_ventas.num_venta
         AND num_cargo > 0;

      reg_ventas.num_transaccion := v_transacventa; --!OJO con esto
      v_paso := '(VEN_DIS_WEB) INSERTAR EN GA_VENTAS.';
      al_pac_ven_dis.insertar_ga_ventas (reg_ventas);
      v_paso :=
               '(VEN_DIS_WEB) OBTENER TIPO Y NUM IDENTIFICACION PARA CLIENTE= '
            || reg_ventas.cod_cliente;
      SELECT cod_tipident, num_ident
        INTO v_cod_tipident, v_num_ident
        FROM ge_clientes
       WHERE cod_cliente = reg_ventas.cod_cliente;
      v_paso := '(VEN_DIS_WEB) OBTENER PLAN TARIFARIO PARA AMISTAR';
      SELECT cod_ami_plantarif
        INTO v_cod_ami_plantarif
        FROM ga_datosgener;
      v_paso :=
               '(VEN_DIS_WEB) OBTENER TIPO PLAN TARIFARIO PARA CODIGO AMISTAR='
            || v_cod_ami_plantarif;
      SELECT tip_plantarif
        INTO v_tip_ami_plantarif
        FROM ta_plantarif
       WHERE cod_plantarif = v_cod_ami_plantarif;
      v_ilinea := 0;
      v_iorden := 0;
      OPEN cargos;

      LOOP
         FETCH cargos INTO v_registro;
         v_paso :=    '(VEN_DIS_WEB) LEER REGISTRO PARA CARGO='
                   || v_registro.num_cargo;
         EXIT WHEN cargos%NOTFOUND;
         v_registro.num_transaccion := v_transacventa;
         v_tipomov := 4;
         v_paso :=    '(VEN_DIS_WEB) INSERTAR EN GE_CARGOS (CARGO='
                   || v_registro.num_cargo
                   || ')';
         al_pac_ven_dis.insertar_ge_cargos (
            v_registro,
            reg_ventas.nom_usuar_vta
         );
      END LOOP;
      CLOSE cargos;

                  --****Se valida si el cliente del pedido es mayorsta o dealer
          BEGIN
           v_paso :=
                  '(VEN_DIS_WEB) OBTENER TIPO CLIENTE MAYORISTA O DEALER PARA EL PEDIDO :'
               || v_cod_pedido;
                  SELECT a.cod_valor
                  INTO LV_cod_tipcomis_may
                  FROM  ged_codigos a
                  WHERE a.cod_modulo = CV_VE
                  AND a.nom_tabla = CV_VE_TIPCOMIS
                  AND a.nom_columna = CV_COD_TIPCOMIS;

                  SELECT a.cod_cliente
                  INTO  LN_cod_cliente
                  FROM  NPT_PEDIDO a
                  WHERE a.COD_PEDIDO  = v_cod_pedido ;

                  SELECT COUNT(DISTINCT a.cod_tipcomis) --*** Si es 1 es mayorista -- 0 es dealer
                  INTO LV_cod_tipcomis
                  FROM ve_vendedores a
                  WHERE a.cod_cliente = LN_cod_cliente
                  AND   a.cod_tipcomis = LV_cod_tipcomis_may;
          EXCEPTION
          WHEN OTHERS
            THEN
            v_errores.glosa_error_venta := SQLERRM;
            RAISE error_proceso_general;
      END;


      OPEN series_conceptos(v_tip_articulo_kit);

      LOOP

         FETCH series_conceptos INTO v_registro.cod_articulo,
                                     v_registro.cod_bodega,
                                     v_registro.tip_stock,
                                     v_registro.cod_estado,
                                     v_registro.cod_uso,
                                     v_registro.num_unidades,
                                     v_registro.num_serie,
                                     v_registro.num_venta,
                                     v_registro.cod_producto,
                                     v_registro.ind_telefono,
                                     v_registro.num_terminal,
                                     v_registro.cod_central,
                                     v_registro.ind_telefono,
                                     v_registro.PLAN,
                                     v_registro.carga,
                                     v_cod_bodega_det,
                                                                         v_registro.cod_tecnologia,
                                                                         v_registro.cod_subalm,
                                                                         LV_ind_equiacc,
                                                                         LV_tip_terminal
                                                                         ;

         EXIT WHEN series_conceptos%NOTFOUND;


                 /**SE VALIDA  LAS SERIES QUE DEBEN QUEDAR  EN TRASPASO(MERCADERIA DEALER Y BODEGA MAYORISTA**/
                 LB_MovimientoInv := TRUE;


                 CASE LV_cod_tipcomis
                 WHEN  1 THEN--Si es mayorista
                        IF LV_ind_equiacc = 'E' AND LV_tip_terminal = 'G' THEN
                            IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                        LB_MovimientoInv := FALSE;
                                END IF;
                        ELSIF LV_ind_equiacc = 'E' AND LV_tip_terminal = 'T' AND v_registro.cod_uso = CN_PREPAGO THEN
                                          LB_MovimientoInv := FALSE;
                        ELSIF LV_ind_equiacc = 'E' AND (LV_tip_terminal = 'D' OR LV_tip_terminal = 'A') THEN
                                 IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                         LB_MovimientoInv := FALSE;
                                 END IF;
                        END IF;
                 WHEN 0 THEN--Dealer
                        IF LV_ind_equiacc = 'E' AND LV_tip_terminal = 'G' THEN
--   P-MIX-09003-Guatemala-Salvador
                            null;
/*
                                 IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                          LB_MovimientoInv := FALSE;
                                 END IF;
--   P-MIX-09003-Guatemala-Salvador
*/                      ELSIF LV_ind_equiacc = 'E' AND (LV_tip_terminal = 'D' OR LV_tip_terminal= 'A') THEN
                                 IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                         LB_MovimientoInv := FALSE;
                                 END IF;
                        END IF;
                 END CASE;
                 
                 

                 IF LB_MovimientoInv THEN
                          v_ilinea :=   v_ilinea
                                     + 1;
                         v_paso :=    '(VEN_DIS_WEB) INCREMENTAR LINEA A '
                                   || v_ilinea;

                         IF v_ilinea = 999
                         THEN
                            v_ilinea := 0;
                            v_iorden :=   v_iorden
                                        + 1;
                         END IF;

                         v_paso :=    '(VEN_DIS_WEB) INSERTAR GA_RESERVART (NUM_TRANSACCION='
                                   || v_registro.num_transaccion
                                   || ' ,  NUM_LINEA='
                                   || v_ilinea
                                   || ',  NUM_ORDEN='
                                   || v_iorden
                                   || ')';
                         al_pac_ven_dis.insertar_ga_reservart (
                            v_registro.num_transaccion,
                            v_registro.cod_articulo,
                            v_registro.cod_bodega,
                            v_registro.tip_stock,
                            v_registro.cod_estado,
                            v_registro.cod_uso,
                            v_registro.num_unidades,
                            v_registro.num_serie,
                            v_registro.num_venta,
                            v_ilinea,
                            v_iorden,
                            reg_ventas.cod_producto
                         );
                         -- Salida de almacen, igual que p_ga_interal
                         SELECT ga_seq_transacabo.NEXTVAL
                           INTO v_transaccion
                           FROM DUAL;
                         v_paso :=    '(VEN_DIS_WEB) TRANSACCION='
                                   || v_transaccion;
                         v_inter.tipo := v_tipomov;
                         v_inter.tipstock := v_registro.tip_stock;
                         v_inter.bodega := v_registro.cod_bodega;
                         v_inter.articulo := v_registro.cod_articulo;
                         v_inter.uso := v_registro.cod_uso;
                         v_inter.estado := v_registro.cod_estado;
                         v_inter.venta := v_registro.num_venta;
                         v_inter.cantid := v_registro.num_unidades;
                         v_inter.serie := v_registro.num_serie;
                         v_inter.indtel := v_registro.ind_telefono;
                         v_inter.transac := v_transaccion;
                         v_inter.error := 0;
                         v_inter.central := NULL;
                         v_inter.subalm := NULL;
                         v_inter.celular := NULL;
                         v_inter.cat := NULL;

                         BEGIN
                             v_paso :=
                                     '(VEN_DIS_WEB) EJECUTA P_TRATA_INTERFAZ

                                 (transaccion='
                                  || v_inter.transac
                                  || ',  articulo='
                                  || v_inter.articulo
                                  || ',  venta='
                                  || v_inter.venta
                                  || ')';
                            ga_pac_interal.p_trata_interfaz (v_inter);
                         EXCEPTION
                            WHEN OTHERS
                            THEN
                            v_errores.glosa_error_venta := SQLERRM;
                               RAISE error_proceso_general;
                         END;

                         v_paso :=
                                  '(VEN_DIS_WEB) OBTENER COD_RETORNO Y DES_CADENA DE GA_TRANSACABO PARA TRANSACCION='
                               || v_transaccion;
                         SELECT cod_retorno, des_cadena
                           INTO v_cod_retorno, v_des_cadena
                           FROM ga_transacabo
                          WHERE num_transaccion = v_transaccion;

                         IF v_cod_retorno <> 0
                         THEN
                            v_errores.glosa_error_venta := TO_CHAR(v_cod_retorno) || ' ' || v_des_cadena;
                            RAISE error_proceso_general;
                         ELSE
                            IF v_des_cadena = NULL
                            THEN
                               v_paso :=
                                        '(VEN_DIS_WEB) COD_RETORNO IS NULL EN GA_TRANSACABO PARA TRANSACCION='
                                     || v_transaccion;
                               v_errores.glosa_error_venta := TO_CHAR(v_cod_retorno) || ' ' || v_des_cadena;
                               RAISE error_proceso_general;
                            END IF;
                         END IF;

                         v_paso :=
                                  '(VEN_DIS_WEB) ELIMINAR REGISTRO DE GA_TRANSACABO PARA TRANSACCION='
                               || v_transaccion;

                         DELETE      ga_transacabo
                         WHERE num_transaccion = v_transaccion;
                 END IF;
      END LOOP;

      CLOSE series_conceptos;

         BEGIN
             -- VALIDA PARAMETRO SI APLICA CLIENTES QUE NO GENERAN FACTURA      
             SELECT valor_parametro INTO v_valparam_clinofac
             FROM npt_parametro WHERE ALIAS_parametro = 'CLI_NO_FAC'; 
             
             IF UPPER(v_valparam_clinofac) = 'TRUE' THEN
                 -- VALIDA SI CLIENTE NO DEBE GENERAR FACTURA                 
                 SELECT count(cod_valor) into v_clinofac_count 
                   FROM ged_codigos
                 WHERE nom_tabla = 'GE_CLIENTES'
                   AND nom_columna = 'COD_CLIENTE'
                   AND cod_valor = reg_ventas.cod_cliente;
                   
                   IF v_clinofac_count > 0 THEN
                        v_factcli_aplica:= FALSE; -- NO APLICA FACTURACION 
                   ELSE
                        v_factcli_aplica:= TRUE; -- APLICA FACTURACION
                   END IF;
                   
                   
             ELSE
                   v_factcli_aplica:= TRUE; -- APLICA FACTURACION  
                    
             END IF;
             
         EXCEPTION
             WHEN NO_DATA_FOUND THEN         
              v_factcli_aplica:= TRUE;  -- APLICA FACTURACION        
         END;
         
     
        -- SI EL CLIENTE ESTA PARAMETRIZADO NO GENERA FACTURA 
        IF v_factcli_aplica THEN
        

              v_paso := '(VEN_DIS_WEB) INICIA ETAPA DE FACTURACION';
              -- FACTURACION ----------------------------
              SELECT ga_seq_transacabo.NEXTVAL
                INTO v_transaccion
                FROM DUAL;
              v_cliente := reg_ventas.cod_cliente;
              v_origen := reg_ventas.num_venta;
              v_destino := reg_ventas.num_transaccion;
              v_paso := '(VEN_DIS_WEB) OBTENER COD.GUIA Y COD.BOLETA DE GA_DATOSGENER';      
              SELECT cod_docguia, cod_docboleta
                INTO v_doc_guia, v_doc_boleta
                FROM ga_datosgener;
              IF reg_ventas.cod_tipdocum = v_doc_boleta
              THEN
                 v_cod_catribut := 'B';
              ELSE
                 IF reg_ventas.cod_tipdocum = v_doc_guia
                 THEN
                    v_cod_catribut := 'F';
                 END IF;
              END IF;
               v_paso := '(VEN_DIS_WEB) OBTENER COD.GUIA Y COD.BOLETA DE GA_DATOSGENER';
              SELECT cod_modgener
                INTO v_modgener
                FROM fa_gencentremi
               WHERE cod_centremi IN (SELECT cod_centremi
                                        FROM al_docum_sucursal
                                       WHERE cod_oficina = reg_ventas.cod_oficina
                                         AND cod_tipdocum = reg_ventas.cod_tipdocum)
                 AND cod_modventa = reg_ventas.cod_modventa
                 AND cod_tipmovimien = 1
                 AND cod_catribut = v_cod_catribut
                 AND tip_foliacion = v_tip_foliacion;
              v_paso := '(VEN_DIS_WEB)OBTENER FECHA ACTUAL DEL SISTEMA';


                -- inicio XO-200509130655 14-09-2005 IPCT
                v_fechafact:=TO_CHAR (SYSDATE, sformatofecha);
                --DBMS_OUTPUT.put_line (v_fechafact);
                -- fin XO-200509130655 14-09-2005 IPCT



              v_paso :=    '(VEN_DIS_WEB)(EJECUTA PREBILLING) TRANSACCION='
                        || v_transaccion
                        || ', CLIENTE='
                        || v_cliente;
              p_interfases_abonados (
                 TO_CHAR (v_transaccion),
                 v_actabo,
                 v_producto,
                 TO_CHAR (v_cliente),
                 TO_CHAR (v_origen),
                 TO_CHAR (v_destino),
                 TO_CHAR (v_num_proceso),
                 v_modgener,
                 v_cod_catribut,
                 v_fechafact
              );
              v_paso :=
                       '(VEN_DIS_WEB) despues de ejecución prebilling OBTENER COD RETORNO DE GA_TRANSACABO PARA TRANSACCION=='
                    || TO_CHAR (v_transaccion);
              v_paso :=    v_paso
                        || ' cliente: '
                        || TO_CHAR (v_cliente);
              v_paso :=    v_paso
                        || ' Origen: '
                        || TO_CHAR (v_origen);
              v_paso :=    v_paso
                        || ' Destino: '
                        || TO_CHAR (v_destino);
              v_paso :=    v_paso
                        || ' Num. Proceso: '
                        || TO_CHAR (v_num_proceso);
              v_paso :=    v_paso
                        || ' Modo Generacion: '
                        || v_modgener;
              v_paso :=    v_paso
                        || ' categoria tributaria: '
                        || v_cod_catribut;
              v_paso :=    v_paso
                        || ' Fecha '
                        || v_fechafact;
              SELECT cod_retorno, des_cadena
                INTO v_cod_retorno, v_des_cadena
                FROM ga_transacabo
               WHERE num_transaccion = v_transaccion;
              v_paso :=
                       '(VEN_DIS_WEB) despues de ejecución prebilling Resultado RETORNO DE GA_TRANSACABO PARA TRANSACCION=='
                    || v_des_cadena;
              v_paso :=    v_paso
                        || ' Datos que envio a Prebilling cliente: '
                        || TO_CHAR (v_cliente);
              v_paso :=    v_paso
                        || ' Origen: '
                        || TO_CHAR (v_origen);
              v_paso :=    v_paso
                        || ' Destino: '
                        || TO_CHAR (v_destino);
              v_paso :=    v_paso
                        || ' Num. Proceso: '
                        || TO_CHAR (v_num_proceso);
              v_paso :=    v_paso
                        || ' Modo Generacion: '
                        || v_modgener;
              v_paso :=    v_paso
                        || ' categoria tributaria: '
                        || v_cod_catribut;
              v_paso :=    v_paso
                        || ' Fecha '
                        || v_fechafact;

              IF v_cod_retorno <> 0
              THEN
                 v_errores.glosa_error_venta := TO_CHAR(v_cod_retorno) || ' ' || v_des_cadena;
                 RAISE error_proceso_general;
              END IF;

              v_paso :=
                       '(VEN_DIS_WEB) despues de ejecución prebilling ELIMINAR GA_TRANSACABO PARA TRANSACCION='
                    || v_transaccion;

              DELETE      ga_transacabo
                    WHERE num_transaccion = v_transaccion;

              var_cod_tipdocum := reg_ventas.cod_tipdocum;

              IF reg_ventas.cod_tipdocum = v_doc_boleta
              THEN
                 v_folio := reg_ventas.num_folio;
              ELSE
                 IF reg_ventas.cod_tipdocum = v_doc_guia
                 THEN
                    v_folio := NULL;
                 END IF;
              END IF;

              v_paso :=
                       '(VEN_DIS_WEB) OBTENER FECHA VENC. DOCUM. DE NPT_DOCUMENTO PARA PEDIDO= '
                    || reg_ventas.cod_pedido;


               --LMV, 07-01-2010, P-MIX-09003  Se deja no vigente el vencimiento segun el tipo de pago para el pedido
               --------------------------------------------------------------------------------------------
               --SELECT TRUNC (NVL (MAX (fec_ven_documento), SYSDATE))
               -- INTO reg_ventas.fec_vencimiento
               -- FROM npt_documento
               --WHERE cod_pedido = reg_ventas.cod_pedido;

              -- inicio XO-200509130655 14-09-2005 IPCT
                 -- IF (reg_ventas.fec_vencimiento = TRUNC(SYSDATE)) THEN
                 --     SELECT TRUNC(SYSDATE) + NVL(int_tipo_pago,0)
                 -- INTO reg_ventas.fec_vencimiento
                 --         FROM npd_tipo_pago
                  --WHERE cod_tipo_pago=(SELECT cod_tipo_pago FROM npt_pedido WHERE cod_pedido = reg_ventas.cod_pedido);
                  --END IF;

                 -- Fin XO-200509130655 14-09-2005 IPCT


              --LMV, 07-01-2010, P-MIX-09003 Obtenemos la Fecha de Vencimiento + los dias que tiene configurado el Cliente...
              ----------------------------------------------------------------------------------------------------
              SELECT TRUNC (NVL (MAX (fec_ven_documento), SYSDATE))
                INTO reg_ventas.fec_vencimiento
                FROM npt_documento
               WHERE cod_pedido = reg_ventas.cod_pedido;


                  IF (reg_ventas.fec_vencimiento = TRUNC(SYSDATE)) THEN

                      BEGIN
                        SELECT nvl(num_dias,0)
                             INTO ln_num_dias
                        FROM npt_usuario_cliente
                        WHERE cod_cliente = reg_ventas.cod_cliente;
                      EXCEPTION
                        WHEN OTHERS
                            THEN
                              ln_num_dias := 0;
                      END;
                      reg_ventas.fec_vencimiento:= TRUNC(SYSDATE) + NVL(ln_num_dias,0);

                  END IF;


              v_paso :=    '(VEN_DIS_WEB) ACTUALIZAR FA_INTERFAC (100,3). Folio='
                        || v_folio
                        || ' ,  Venta='
                        || v_num_venta;
              al_pac_ven_dis.upd_fa_interfact (
                 v_folio,
                 v_num_venta,
                 reg_ventas.fec_vencimiento,
                 v_num_proceso
              );
              v_paso :=
                     '(VEN_DIS_WEB) INGRESA GLOSA FACTURA PARA PEDIDO='
                  || v_cod_pedido;
              p_ga_ins_glosafact (v_cod_pedido);

        -- ************************************************
            END IF; 
  
      v_ind_estventa := 'AC';
      v_paso :=
               '(VEN_DIS_WEB) ACTUALIZA GA_VENTAS CON IND_ESTVENTA=AC PARA VENTA='
            || reg_ventas.num_venta;
      al_pac_ven_dis.upd_ga_ventas (v_ind_estventa, reg_ventas.num_venta);
      OPEN series_conceptos (v_tip_articulo_kit);

      LOOP
         FETCH series_conceptos INTO v_registro.cod_articulo,
                                     v_registro.cod_bodega,
                                     v_registro.tip_stock,
                                     v_registro.cod_estado,
                                     v_registro.cod_uso,
                                     v_registro.num_unidades,
                                     v_registro.num_serie,
                                     v_registro.num_venta,
                                     v_registro.cod_producto,
                                     v_registro.ind_telefono,
                                     v_registro.num_terminal,
                                     v_registro.cod_central,
                                     v_registro.ind_telefono,
                                     v_registro.PLAN,
                                     v_registro.carga,
                                     v_cod_bodega_det,
                                                                         v_registro.cod_tecnologia,
                                                                         v_registro.cod_subalm,
                                                                         LV_ind_equiacc,
                                                                         LV_tip_terminal;

         EXIT WHEN series_conceptos%NOTFOUND;


                                 /**SE VALIDA  LAS SERIES QUE DEBEN QUEDAR  EN TRASPASO(MERCADERIA DEALER Y BODEGA MAYORISTA**/
                 LB_MovimientoInv := TRUE;

                 CASE LV_cod_tipcomis
                 WHEN  1 THEN--Si es mayorista
                        IF LV_ind_equiacc = 'E' AND LV_tip_terminal = 'G' THEN
                            IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                        LB_MovimientoInv := FALSE;
                                END IF;
                        ELSIF LV_ind_equiacc = 'E' AND LV_tip_terminal = 'T' AND v_registro.cod_uso = CN_PREPAGO THEN
                                          LB_MovimientoInv := FALSE;
                        ELSIF LV_ind_equiacc = 'E' AND (LV_tip_terminal = 'D' OR LV_tip_terminal = 'A') THEN
                                 IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                         LB_MovimientoInv := FALSE;
                                 END IF;
                        END IF;
                 WHEN 0 THEN--Dealer
                        IF LV_ind_equiacc = 'E' AND LV_tip_terminal = 'G' THEN
--   P-MIX-09003-Guatemala-Salvador
                           NULL;
/*
                                 IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                          LB_MovimientoInv := FALSE;
                                 END IF;
*/
--   P-MIX-09003-Guatemala-Salvador
                        ELSIF LV_ind_equiacc = 'E' AND (LV_tip_terminal = 'D' OR LV_tip_terminal= 'A') THEN
                                 IF  v_registro.ind_telefono = 0 AND v_registro.num_terminal IS NULL  AND v_registro.cod_uso = CN_PREPAGO THEN
                                         LB_MovimientoInv := FALSE;
                                 END IF;
                        END IF;
                 END CASE;
                 
                 

                 IF LB_MovimientoInv THEN
                                 v_registro.num_transaccion := v_transacventa;
                                 v_tipomov := 1;
                                 v_paso :=    '(VEN_DIS_WEB) VERIFICA SI ES KIT. PARA SERIE='
                                           || v_registro.num_serie;
                                 SELECT DECODE (COUNT (*), 0, 0, 1)
                                   INTO v_is_kit
                                   FROM al_series a, al_articulos b
                                  WHERE a.num_serie = v_registro.num_serie
                                    AND a.cod_articulo = b.cod_articulo
                                    AND b.tip_articulo = v_tip_articulo_kit; -- 20 Indica tipo de articulo KIT
                                 v_paso := '(VEN_DIS_WEB) OBTIENE SECUENCIA DE TRANSACCION';
                                 SELECT ga_seq_transacabo.NEXTVAL
                                   INTO v_transaccion
                                   FROM DUAL;
                                 -- esto esta igual que p_ga_interal
                                 v_inter.tipo := v_tipomov;
                                 v_inter.tipstock := v_registro.tip_stock;
                                 v_inter.bodega := v_registro.cod_bodega;
                                 v_inter.articulo := v_registro.cod_articulo;
                                 v_inter.uso := v_registro.cod_uso;
                                 v_inter.estado := v_registro.cod_estado;
                                 v_inter.venta := v_registro.num_venta;
                                 v_inter.cantid := v_registro.num_unidades;
                                 v_inter.serie := v_registro.num_serie;
                                 v_inter.indtel := v_registro.ind_telefono;
                                 v_inter.transac := v_transaccion;
                                 v_inter.error := 0;
                                 v_inter.central := NULL;
                                 v_inter.subalm := NULL;
                                 v_inter.celular := NULL;
                                 v_inter.cat := NULL;

                                 BEGIN
                                    v_paso :=    '(VEN_DIS_WEB) EJECUTA P_TRATA_INTERFAZ (VENTA='
                                              || v_num_venta
                                              || ',  PEDIDO='
                                              || v_cod_pedido
                                              || ',  SERIE='
                                              || v_inter.serie;
                                    ga_pac_interal.p_trata_interfaz (v_inter);
                                 EXCEPTION
                                    WHEN OTHERS
                                    THEN
                                       v_errores.glosa_error_venta := SQLERRM;
                                       RAISE error_proceso_general;
                                 END;

                                 v_paso :=
                                          '(VEN_DIS_WEB) despues actualización stock (P_TRATA_INTERFAZ) OBTENER COD_RETORNO DE GA_TRANSACABO PARA TRANSACCION='
                                       || v_transaccion;
                                 SELECT cod_retorno, des_cadena
                                   INTO v_cod_retorno, v_des_cadena
                                   FROM ga_transacabo
                                  WHERE num_transaccion = v_transaccion;

                                 IF v_cod_retorno <> 0
                                 THEN
                                    v_paso :=
                                             '(VEN_DIS_WEB)(ERROR EN P_TRATA_INTERFAZ) OBTENER COD_RETORNO (GA_TRANSACABO) PARA TRANSACCION='
                                          || v_transaccion;
                                            v_errores.glosa_error_venta := TO_CHAR(v_cod_retorno) || ' ' || v_des_cadena;
                                    RAISE error_proceso_general;
                                 ELSE
                                    IF v_des_cadena = NULL
                                    THEN
                                       v_paso :=
                                                '(VEN_DIS_WEB)(ERROR EN P_TRATA_INTERFAZ) (RETORNO NULL) TRANSACCION='
                                             || v_transaccion;
                                               v_errores.glosa_error_venta := TO_CHAR(v_cod_retorno) || ' ' || v_des_cadena;
                                       RAISE error_proceso_general;
                                    END IF;
                                 END IF;

                                 DELETE      ga_transacabo
                                       WHERE num_transaccion = v_transaccion;

                                 v_paso :=
                                          '(VEN_DIS_WEB) OBTENER VENDEDOR DE NPT_PEDIDO PARA PEDIDO='
                                       || v_cod_pedido
                                       || ')';
                                 SELECT NVL (cod_vendedor, reg_ventas.cod_vendedor)
                                   INTO v_cod_vendedor_aux
                                   FROM npt_pedido
                                  WHERE cod_pedido = v_cod_pedido;
                                 v_paso := '(VEN_DIS_WEB)(SI NO ES KIT)';

                                 IF v_is_kit = 0
                                 THEN
                                    IF v_registro.num_terminal > 0
                                    THEN
                                       v_paso := '(VEN_DIS_WEB)(SI ES EQUIPO)';
                                       v_cod_servicios := NULL;
                                       SELECT ga_seq_numabo.NEXTVAL
                                         INTO v_num_abonado
                                         FROM DUAL;
                                       v_paso := '(VEN_DIS_WEB)(OBTENER SERV SUPL)';

                                       al_pac_ven_dis.obtener_servsupl (
                                          reg_ventas.cod_producto,
                                          v_registro.cod_articulo,
                                          v_registro.cod_tecnologia,
                                          v_cod_servicios
                                       );


                                       SELECT ga_seq_usuarios.NEXTVAL
                                         INTO v_cod_usuario
                                         FROM DUAL;


                                       -- inicio XO-200509130655 14-09-2005 IPCT
                                       v_min_mdn:=ge_fn_min_de_mdn (v_registro.num_terminal);
                                       -- FIN XO-200509130655 14-09-2005 IPCT
                                       v_paso :=    '(VEN_DIS_WEB)(INSERTAR ABONADO='
                                                 || v_num_abonado
                                                 || ' EN GA_ABOAMIST)';
                                       al_pac_ven_dis.insertar_ga_aboamist (
                                          v_num_abonado,
                                          v_registro.cod_articulo,
                                          v_registro.num_terminal,
                                          reg_ventas.cod_producto,
                                          reg_ventas.cod_cliente,
                                          reg_ventas.cod_cuenta,
                                          v_registro.cod_central,
                                          v_registro.cod_uso,
                                          v_cod_vendedor_aux,
                                          reg_ventas.cod_vendedor_agente,
                                          v_registro.num_serie,
                                          reg_ventas.num_venta,
                                          reg_ventas.cod_modventa,
                                          v_cod_servicios,
                                          v_registro.ind_telefono,
                                          v_cod_ami_plantarif,
                                          v_tip_ami_plantarif,
                                          v_cod_usuario,
                                          NVL (v_registro.ind_telefono, 6),
                                          NVL (v_registro.PLAN, 'KL'),
                                          NVL (v_registro.carga, 0),
                                          v_registro.cod_tecnologia,                                 /* GSM  */
                                          NULL,
                                          v_cod_bodega_det, /*GSM  */
                                                          v_min_mdn,
                                                          v_registro.cod_subalm
                                       );
                                       v_paso :=    '(VEN_DIS_WEB)(INSERTAR ABONADO='
                                                 || v_num_abonado
                                                 || ' EN GA_EQUIPABOSER)';
                                       al_pac_ven_dis.insertar_ga_equipaboser (
                                          v_num_abonado,
                                          v_registro.num_serie,
                                          reg_ventas.cod_producto,
                                          v_registro.cod_bodega,
                                          v_registro.tip_stock,
                                          v_registro.cod_articulo,
                                          reg_ventas.cod_modventa,
                                          v_registro.cod_uso,
                                          v_registro.cod_estado,
                                          v_des_cadena,
                                          NULL ,/* GSM  Serie terminal GSM */
                                                          v_registro.cod_tecnologia
                                       );
                                       v_paso :=    '(VEN_DIS_WEB)(INSERTAR ABONADO='
                                                 || v_num_abonado
                                                 || ' EN GA_SERVSUPLABO)';
                                       al_pac_ven_dis.insertar_ga_servsuplabo (
                                          v_num_abonado,
                                          reg_ventas.cod_producto,
                                          v_registro.num_terminal,
                                          v_cod_servicios
                                       );
                                       v_paso :=    '(VEN_DIS_WEB)(INSERTAR ABONADO='
                                                 || v_num_abonado
                                                 || ' EN GA_USUAMIST)';
                                       al_pac_ven_dis.insertar_ga_usuamist (
                                          v_num_abonado,
                                          v_cod_tipident,
                                          v_num_ident,
                                          v_cod_usuario
                                       );

                                       IF v_registro.ind_telefono <> 7
                                       THEN
                                          v_paso := '(VEN_DIS_WEB)(INSERTAR ICC MOVIMIENTO)';
                                          al_pac_ven_dis.insertar_icc_movimiento (
                                             v_registro.cod_uso,
                                             v_registro.cod_articulo,
                                             v_registro.num_serie,
                                             v_registro.cod_central,
                                             v_registro.num_terminal,
                                             v_registro.ind_telefono,
                                             v_registro.PLAN,
                                             v_registro.carga,
                                             reg_ventas.ind_activacion,
                                             v_cod_ami_plantarif,
                                             v_cod_tecnologia,
                                             NULL /*GSM IMSI*/,
                                             NULL /*GSM IMEI*/,
                                             NULL /*GSM ICC*/
                                          );
                                       END IF;
                                    END IF;
                                 ELSE
                                    v_paso := '(VEN_DIS_WEB) SI ES KIT';
                                    SELECT ga_seq_numabo.NEXTVAL
                                      INTO v_num_abonado
                                      FROM DUAL;
                                    OPEN c_kit (v_registro.num_serie);

                                    LOOP
                                       FETCH c_kit INTO reg_al_componente_kit;
                                       EXIT WHEN c_kit%NOTFOUND;
                                       v_paso :=
                                                '(VEN_DIS_WEB)(INSERTAR GA_EQUIPABOSER): ABONADO= '
                                             || v_num_abonado
                                             || '  ,SERIE= '
                                             || reg_al_componente_kit.num_serie;
                                       al_pac_ven_dis.insertar_ga_equipaboser (
                                          v_num_abonado,
                                          reg_al_componente_kit.num_serie,
                                          reg_ventas.cod_producto,
                                          reg_al_componente_kit.cod_bodega,
                                          reg_al_componente_kit.tip_stock,
                                          reg_al_componente_kit.cod_articulo,
                                          reg_ventas.cod_modventa,
                                          reg_al_componente_kit.cod_uso,
                                          reg_al_componente_kit.cod_estado,
                                          NULL,
                                          reg_al_componente_kit.num_serie_terminal, /*GSM IMEI*/
                                                          reg_al_componente_kit.cod_tecnologia
                                       );

                                       IF reg_al_componente_kit.num_telefono > 0
                                       THEN
                                          v_cod_servicios := NULL;
                                          v_paso :=
                                                   '(VEN_DIS_WEB) OBTENER SERV SUPL PARA ARTICULO = '
                                                || reg_al_componente_kit.cod_articulo;
                                          al_pac_ven_dis.obtener_servsupl (
                                             reg_ventas.cod_producto,
                                             reg_al_componente_kit.cod_articulo,
                                             reg_al_componente_kit.cod_tecnologia,
                                             v_cod_servicios
                                          );
                                          SELECT ga_seq_usuarios.NEXTVAL
                                            INTO v_cod_usuario
                                            FROM DUAL;


                                          -- Inicio XO-200510250959  IPCT
                                          v_min_mdn:= ge_fn_min_de_mdn (reg_al_componente_kit.num_telefono);
                                          -- Fin XO-200510250959  IPCT
                                          v_paso :=
                                                   '(VEN_DIS_WEB)(INSERTAR GA_ABOAMIST): ABONADO= '
                                                || v_num_abonado
                                                || ' , ARTICULO='
                                                || reg_al_componente_kit.cod_articulo;
                                          al_pac_ven_dis.insertar_ga_aboamist (
                                             v_num_abonado,
                                             reg_al_componente_kit.cod_articulo,
                                             reg_al_componente_kit.num_telefono,
                                             reg_ventas.cod_producto,
                                             reg_ventas.cod_cliente,
                                             reg_ventas.cod_cuenta,
                                             reg_al_componente_kit.cod_central,
                                             reg_al_componente_kit.cod_uso,
                                             v_cod_vendedor_aux,
                                             reg_ventas.cod_vendedor_agente,
                                             reg_al_componente_kit.num_serie,
                                             reg_ventas.num_venta,
                                             reg_ventas.cod_modventa,
                                             v_cod_servicios,
                                             reg_al_componente_kit.ind_telefono,
                                             v_cod_ami_plantarif,
                                             v_tip_ami_plantarif,
                                             v_cod_usuario,
                                             NVL (reg_al_componente_kit.ind_telefono, 6),
                                             NVL (reg_al_componente_kit.PLAN, 'KL'),
                                             NVL (reg_al_componente_kit.carga, 0),
                                             reg_al_componente_kit.cod_tecnologia,            /* GSM*/
                                             reg_al_componente_kit.num_serie_terminal,
                                             v_cod_bodega_det, /* GSM IMEI*/
                                                                 v_min_mdn,
                                                                 reg_al_componente_kit.cod_subalm
                                          );
                                          v_paso :=
                                                   '(VEN_DIS_WEB)(INSERTAR GA_SERVSUPLABO) ABONADO='
                                                || v_num_abonado
                                                || ', SERVICIO ='
                                                || v_cod_servicios;
                                          al_pac_ven_dis.insertar_ga_servsuplabo (
                                             v_num_abonado,
                                             reg_ventas.cod_producto,
                                             reg_al_componente_kit.num_telefono,
                                             v_cod_servicios
                                          );
                                          v_paso :=    '(VEN_DIS_WEB)(INSERTAR GA_USUAMIST) ABONADO='
                                                    || v_num_abonado
                                                    || ', USUARIO ='
                                                    || v_cod_usuario;
                                          al_pac_ven_dis.insertar_ga_usuamist (
                                             v_num_abonado,
                                             v_cod_tipident,
                                             v_num_ident,
                                             v_cod_usuario
                                          );

                                          IF reg_al_componente_kit.ind_telefono <> 7
                                          THEN                               /*telefono sin bloqueo */
                                             v_paso :=
                                                      '(VEN_DIS_WEB)(TELEFONO SIN BLOQUEO) RECUPERA SIMCARD PARA SERIE'
                                                   || reg_al_componente_kit.num_serie;

                                             BEGIN
                                                IF reg_al_componente_kit.tipo_terminal = 'G'
                                                THEN
                                                   v_imsi :=
                                                         frecupersimcard_fn (
                                                            reg_al_componente_kit.num_serie,
                                                            'IMSI'
                                                         );
                                                ELSE
                                                   v_imsi := NULL;
                                                END IF;
                                             EXCEPTION
                                                WHEN OTHERS
                                                THEN
                                                   v_imsi := NULL;
                                             END;

                                             v_paso :=
                                                      '(VEN_DIS_WEB)(TELEFONO SIN BLOQUEO)(INSERTA ICC_MOVIMIENTO) ARTICULO='
                                                   || reg_al_componente_kit.cod_articulo;
                                             al_pac_ven_dis.insertar_icc_movimiento (
                                                reg_al_componente_kit.cod_uso,
                                                reg_al_componente_kit.cod_articulo,
                                                reg_al_componente_kit.num_serie,
                                                reg_al_componente_kit.cod_central,
                                                reg_al_componente_kit.num_telefono,
                                                reg_al_componente_kit.ind_telefono,
                                                reg_al_componente_kit.PLAN,
                                                reg_al_componente_kit.carga,
                                                reg_ventas.ind_activacion,
                                                v_cod_ami_plantarif,
                                                reg_al_componente_kit.cod_tecnologia, -- GSM tip_tecnoligia es igua a cod_tecnologia ???
                                                v_imsi, -- GSM IMSI fRecuperSIMCARD_FN(reg_al_componente_kit.num_serie => '25408852480001', 'IMSI')
                                                reg_al_componente_kit.num_serie_terminal, -- GSM IMEI aun no esta
                                                reg_al_componente_kit.num_serie -- GSM ICC numero de serie de la tarjeta (igual al del kit)
                                             );
                                          END IF;
                                       END IF;
                                    END LOOP;
                                    CLOSE c_kit;
                                 END IF;
                        END IF;
      END LOOP;

      CLOSE series_conceptos;
      v_paso :=    '(VEN_DIS_WEB)(FINAL: ACTUALIZA VENTAS): VENTA='
                || v_num_venta
                || ', FOLIO='
                || reg_ventas.num_folio;

      UPDATE al_ventas
         SET cod_estado = 'CE',
             nom_usuaproc = USER,
             fec_proceso = SYSDATE
       WHERE num_venta = v_num_venta;

      v_folio := reg_ventas.num_folio;

      IF v_tip_foliacion = 'P'
      THEN
         v_paso :=    '(VEN_DIS_WEB)(FINAL: INSERTA GA_DOCVENTA): VENTA='
                   || v_num_venta
                   || ', FOLIO='
                   || v_folio
                   || ', TIP_DOC='
                   || var_cod_tipdocum;
         al_pac_ven_dis.insertar_ga_docventa (
            v_num_venta,
            var_cod_tipdocum,
            v_folio
         );
      END IF;

      v_paso :=    '(VEN_DIS_WEB)(FINAL: ELIMINA GA_RESERVART): VENDEDOR='
                || reg_ventas.cod_vendedor
                || ', FOLIO='
                || v_folio
                || ', TIP_DOC='
                || reg_ventas.cod_tipdocum;

      DELETE      ga_reservart
            WHERE num_transaccion = reg_ventas.num_transaccion;

      DELETE      ga_reservfol
            WHERE num_folio = reg_ventas.num_folio
              AND cod_vendedor = reg_ventas.cod_vendedor
              AND cod_tipdocum = reg_ventas.cod_tipdocum
              AND num_serie > '0';

      -- si no hay sqlcode es que se proceso bien, y en sqlerrm queda la historia
      v_paso :=    '(VEN_DIS_WEB)(FINAL: ACTUALIZA AL_VENTAS): VENTA='
                || v_num_venta
                || ',  SQLCODE = NULL';

      UPDATE al_ventas
         SET SQLCODE = NULL
       WHERE num_venta = v_num_venta;
   END LOOP; -- del principal

   CLOSE ventas;
   v_paso :=    '(VEN_DIS_WEB)(FIN PL) FECHA= '
             || TO_CHAR (SYSDATE, 'dd-mm-yyyy hh24:mi:ss');
EXCEPTION
   WHEN error_proceso_general
   THEN
      ROLLBACK;
      v_err_pedido := 1;
      SELECT al_seq_errores_web.NEXTVAL
        INTO v_errores.num_error
        FROM DUAL;

      IF NOT v_cod_pedido IS NULL
      THEN
         v_errores.cod_pedido := v_cod_pedido;
      END IF;

      v_errores.num_serie := reg_al_componente_kit.num_serie;
      v_errores.cod_articulo := reg_al_componente_kit.cod_articulo;
      v_errores.num_venta := v_num_venta;
      v_errores.fec_error := SYSDATE;
      v_errores.glosa_error_venta := SQLERRM;
      v_errores.glosa_error_traspaso := v_paso;
      v_errores.cod_estado_error := 'PR';

      INSERT INTO al_errores_web
                  (num_error, cod_pedido,
                   lin_pedido, num_serie,
                   cod_articulo, fec_error,
                   num_venta, num_traspaso_masivo,
                   glosa_error_traspaso,
                   glosa_error_venta, cod_estado_error)
           VALUES (v_errores.num_error, v_errores.cod_pedido,
                   v_errores.lin_pedido, v_errores.num_serie,
                   v_errores.cod_articulo, v_errores.fec_error,
                   v_errores.num_venta, v_errores.num_traspaso_masivo,
                   v_errores.glosa_error_traspaso,
                   v_errores.glosa_error_venta, v_errores.cod_estado_error);

      UPDATE al_ventas
         SET SQLCODE = SUBSTR (SQLERRM, 1, 10),
             SQLERRM =    v_paso
                       || TO_CHAR (SYSDATE, 'DD-MM-YYYY HH24:MI')
       WHERE num_venta = v_num_venta;

      IF cargos%ISOPEN
      THEN
         CLOSE cargos;
      END IF;

      IF ventas%ISOPEN
      THEN
         CLOSE ventas;
      END IF;

      COMMIT;
   WHEN OTHERS
   THEN
      ROLLBACK;
      v_err_pedido := 1;
      SELECT al_seq_errores_web.NEXTVAL
        INTO v_errores.num_error
        FROM DUAL;

      IF NOT v_cod_pedido IS NULL
      THEN
         v_errores.cod_pedido := v_cod_pedido;
      END IF;

      v_errores.num_serie := reg_al_componente_kit.num_serie;
      v_errores.cod_articulo := reg_al_componente_kit.cod_articulo;
      v_errores.num_venta := v_num_venta;
      v_errores.fec_error := SYSDATE;
      v_errores.glosa_error_venta := SQLERRM;
      v_errores.glosa_error_traspaso := v_paso;
      v_errores.cod_estado_error := 'PR';

      /*al_pac_trasven_web.insertar_al_errores_web (v_errores);*/
      INSERT INTO al_errores_web
                  (num_error, cod_pedido,
                   lin_pedido, num_serie,
                   cod_articulo, fec_error,
                   num_venta, num_traspaso_masivo,
                   glosa_error_traspaso,
                   glosa_error_venta, cod_estado_error)
           VALUES (v_errores.num_error, v_errores.cod_pedido,
                   v_errores.lin_pedido, v_errores.num_serie,
                   v_errores.cod_articulo, v_errores.fec_error,
                   v_errores.num_venta, v_errores.num_traspaso_masivo,
                   v_errores.glosa_error_traspaso,
                   v_errores.glosa_error_venta, v_errores.cod_estado_error);

      /* fin modificación*/

      UPDATE al_ventas
         SET SQLCODE = SUBSTR (SQLERRM, 1, 10),
             SQLERRM = TO_CHAR (SYSDATE, 'DD-MM-YYYY HH24:MI')
       WHERE num_venta = v_num_venta;

      IF cargos%ISOPEN
      THEN
         CLOSE cargos;
      END IF;

      IF ventas%ISOPEN
      THEN
         CLOSE ventas;
      END IF;

      COMMIT;
END; 
/

