CREATE OR REPLACE PROCEDURE P_Ga_Facturacion_Global
IS
   v_sal_proc         VARCHAR (5);
   i_stmt             INTEGER; -- indica donde ocurre un error
   v_msj              VARCHAR (255); -- mensaje de error
   v_cod_sqlcode      ga_errores.cod_sqlcode%TYPE;
   v_cod_sqlerrm      ga_errores.cod_sqlerrm%TYPE;
   error_proceso      EXCEPTION;
   reg_fa_interfact   fa_interfact%ROWTYPE;
   v_cod_miscela      fa_datosgener.cod_miscela%TYPE;
   v_num_proceso      fa_procesos.num_proceso%TYPE;
   v_cod_vendedor     ge_seg_usuario.cod_vendedor%TYPE;
   v_cod_cliente      GE_OPERPLAZA_TD.cod_cliente%TYPE;
   v_cod_centremi     al_docum_sucursal.cod_centremi%TYPE;
   v_cod_catimpos     ge_catimpclientes.cod_catimpos%TYPE;
   v_letra            ge_letras.letra%TYPE;
   v_cod_modgener     FA_GENCENTREMI.cod_modgener%TYPE;
   v_tip_foliacion    GE_TIPDOCUMEN.tip_foliacion%TYPE;
   v_seqmiscelanea    fa_procesos.num_secuag%TYPE;
   v_seq_transacabo   ga_transacabo.num_transaccion%TYPE;
   v_cod_contado      fa_datosgener.cod_contado%TYPE;
   v_cod_retorno      ga_transacabo.cod_retorno%TYPE;

   CURSOR c_fa_interfact
   IS
      SELECT   b.cod_operadora, b.cod_plaza, b.cod_oficina, b.cod_modventa,
               a.cod_catribut
          FROM fa_interfact a, ga_ventas b
         WHERE a.cod_estadoc = 0
           AND a.cod_estproc = 3
           AND a.num_venta = b.num_venta
           AND a.cod_catribut = 'F'
      GROUP BY b.cod_operadora,
               b.cod_plaza,
               b.cod_oficina,
               b.cod_modventa,
               a.cod_catribut;

   CURSOR c_ge_cargos (
      vc_cod_operadora   ga_ventas.cod_operadora%TYPE,
      vc_cod_plaza       ga_ventas.cod_plaza%TYPE,
      vc_cod_oficina     ga_ventas.cod_oficina%TYPE,
      vc_cod_modventa    ga_ventas.cod_modventa%TYPE
   )
   IS
      SELECT DISTINCT ccg.cod_concepto
                 FROM ge_cargos ccg,
                      ge_oficinas a,
                      ge_direcciones b,
                      ga_cliente_pcom c
                WHERE ccg.num_venta IN (SELECT a.num_venta
                                          FROM fa_interfact a, ga_ventas b
                                         WHERE a.cod_estadoc = 0
                                           AND a.cod_estproc = 3
                                           AND a.num_venta = b.num_venta
                                           AND b.cod_operadora =
                                                             vc_cod_operadora
                                           AND b.cod_plaza = vc_cod_plaza
                                           AND b.cod_oficina = vc_cod_oficina
                                           AND b.cod_modventa =
                                                              vc_cod_modventa)
                  AND c.cod_cliente = v_cod_cliente
                  AND SYSDATE BETWEEN c.fec_desde
                                  AND NVL (c.fec_hasta,   SYSDATE
                                                        + 1)
                  AND a.cod_oficina = vc_cod_oficina
                  AND a.cod_direccion = b.cod_direccion;
BEGIN
   v_sal_proc := 0;
   SELECT cod_miscela
     INTO v_cod_miscela
     FROM fa_datosgener;
   SELECT cod_contado
     INTO v_cod_contado
     FROM fa_datosgener;
   -- Codigo de vendedor
   i_stmt := 1;
   v_msj := 'Error, obteniendo codigo de vendedor';
   SELECT cod_vendedor
     INTO v_cod_vendedor
     FROM ge_seg_usuario
    WHERE nom_usuario = USER
      AND cod_vendedor IS NOT NULL;

   FOR ccf IN c_fa_interfact
   LOOP
      -- Recupero el valor de la secuencia
      SELECT fa_seq_numpro.NEXTVAL
        INTO v_num_proceso
        FROM DUAL;
      -- Codigo de cliente ficticio
      i_stmt := 2;
      v_msj := 'Error, obteniendo codigo de cliente';
      SELECT a.cod_cliente
        INTO v_cod_cliente
        FROM GE_OPERPLAZA_TD a
       WHERE a.cod_plaza = ccf.cod_plaza
         AND a.cod_operadora_scl = ccf.cod_operadora;
      -- Centro emisor de la factura
      i_stmt := 3;
      v_msj := 'Error, obteniendo centro emisor';
      SELECT a.cod_centremi
        INTO v_cod_centremi
        FROM al_docum_sucursal a
       WHERE a.cod_oficina = ccf.cod_oficina
         AND a.cod_tipdocum = v_cod_miscela;
      -- Categoria impositiva
      i_stmt := 4;
      v_msj := 'Error, obteniendo categoria impositiva';
      SELECT cod_catimpos
        INTO v_cod_catimpos
        FROM ge_catimpclientes
       WHERE cod_cliente = v_cod_cliente
         AND SYSDATE BETWEEN fec_desde AND fec_hasta;
      -- Obtiene Letra
      i_stmt := 5;
      v_msj := 'Error, obteniendo letra';
      SELECT letra
        INTO v_letra
        FROM ge_letras
       WHERE cod_tipdocum = v_cod_miscela
         AND cod_catimpos = v_cod_catimpos;
      -- Recupera la secuencia segun el tipo de documento
      SELECT fa_seq_miscelanea.NEXTVAL
        INTO v_seqmiscelanea
        FROM DUAL;
      -- Inserta en FA_PROCESOS
      i_stmt := 6;
      v_msj := 'Error, insertando en la fa_procesos';

      INSERT INTO fa_procesos
                  (num_proceso, cod_tipdocum, cod_vendedor_agente,
                   cod_centremi, fec_efectividad, nom_usuarora, letraag,
                   num_secuag, cod_tipdocnot, cod_vendedor_agentenot,
                   letranot, cod_centrnot, num_secunot, ind_estado,
                   cod_ciclfact)
           VALUES (v_num_proceso, v_cod_miscela, v_cod_vendedor,
                   v_cod_centremi, SYSDATE, USER, v_letra,
                   v_seqmiscelanea, NULL, NULL,
                   NULL, NULL, NULL, 0,
                   NULL);

      FOR ccc IN c_ge_cargos (
                    ccf.cod_operadora,
                    ccf.cod_plaza,
                    ccf.cod_oficina,
                    ccf.cod_modventa
                 )
      LOOP
         -- Inicio de Prefactura
         i_stmt := 7;
         v_msj := 'Error, insertando en la fa_prefactura';

         INSERT INTO fa_prefactura
                     (num_proceso, cod_cliente, cod_concepto, columna,
                      cod_producto, cod_moneda, fec_valor, fec_efectividad,
                      imp_concepto, imp_facturable, imp_montobase, cod_region,
                      cod_provincia, cod_ciudad, cod_modulo, cod_plancom,
                      ind_factur, cod_catimpos, cod_portador, ind_estado,
                      cod_tipconce, num_unidades, num_seriele, flag_impues,
                      flag_dto, ind_modventa)
            SELECT v_num_proceso, v_cod_cliente, ccg.cod_concepto,
                   ROWNUM AS columna, ccg.cod_producto, ccg.cod_moneda,
                   SYSDATE, SYSDATE, imp_cargo, imp_cargo, 0, a.cod_region,
                   a.cod_provincia, b.cod_ciudad, 'AL', c.cod_plancom,
                   ccg.ind_factur, v_cod_catimpos, 0, 0, 3, ccg.num_unidades,
                   '0', 0, 0, 1
              FROM ge_cargos ccg,
                   ge_oficinas a,
                   ge_direcciones b,
                   ga_cliente_pcom c
             WHERE ccg.num_venta IN (SELECT a.num_venta
                                       FROM fa_interfact a, ga_ventas b
                                      WHERE a.cod_estadoc = 0
                                        AND a.cod_estproc = 3
                                        AND a.num_venta = b.num_venta
                                        AND b.cod_operadora =
                                                            ccf.cod_operadora
                                        AND b.cod_plaza = ccf.cod_plaza
                                        AND b.cod_oficina = ccf.cod_oficina
                                        AND b.cod_modventa = ccf.cod_modventa)
               AND ccg.cod_concepto = ccc.cod_concepto
               AND c.cod_cliente = v_cod_cliente
               AND SYSDATE BETWEEN c.fec_desde
                               AND NVL (c.fec_hasta,   SYSDATE
                                                     + 1)
               AND a.cod_oficina = ccf.cod_oficina
               AND a.cod_direccion = b.cod_direccion;

         UPDATE ga_ventas
            SET num_proceso = v_num_proceso
          WHERE num_venta IN
                      (SELECT ccg.num_venta
                         FROM ge_cargos ccg,
                              ge_oficinas a,
                              ge_direcciones b,
                              ga_cliente_pcom c
                        WHERE ccg.num_venta IN (SELECT a.num_venta
                                                  FROM fa_interfact a,
                                                       ga_ventas b
                                                 WHERE a.cod_estadoc = 0
                                                   AND a.cod_estproc = 3
                                                   AND a.num_venta =
                                                                  b.num_venta
                                                   AND b.cod_operadora =
                                                            ccf.cod_operadora
                                                   AND b.cod_plaza =
                                                                ccf.cod_plaza
                                                   AND b.cod_oficina =
                                                              ccf.cod_oficina
                                                   AND b.cod_modventa =
                                                             ccf.cod_modventa)
                          AND ccg.cod_concepto = ccc.cod_concepto
                          AND c.cod_cliente = v_cod_cliente
                          AND SYSDATE BETWEEN c.fec_desde
                                          AND NVL (
                                                 c.fec_hasta,
                                                   SYSDATE
                                                 + 1
                                              )
                          AND a.cod_oficina = ccf.cod_oficina
                          AND a.cod_direccion = b.cod_direccion);
      END LOOP;

      -- Tipo de foliacion
      i_stmt := 9;
      v_msj := 'Error, obteniendo tipo de foliacion';
      SELECT tip_foliacion
        INTO v_tip_foliacion
        FROM GE_TIPDOCUMEN
       WHERE cod_tipdocum = v_cod_miscela;
      --  obteniendo cod_modgener
      i_stmt := 8;
      v_msj := 'Error, obteniendo cod_modgener';
      SELECT cod_modgener
        INTO v_cod_modgener
        FROM FA_GENCENTREMI
       WHERE cod_centremi = v_cod_centremi
         AND cod_tipmovimien = v_cod_miscela
         AND cod_catribut = ccf.cod_catribut
         AND cod_modventa = ccf.cod_modventa
         AND tip_foliacion = v_tip_foliacion;
      -- Excecute pl
      SELECT ga_seq_transacabo.NEXTVAL
        INTO v_seq_transacabo
        FROM DUAL;
      i_stmt := 5;
      v_msj := 'Error, al ejecutar PL fa_ins_interfact';

      BEGIN
         Fa_Ins_Interfact (
            v_seq_transacabo,
            v_num_proceso,
            0,
            v_cod_modgener,
            v_cod_miscela,
            ccf.cod_catribut,
            '',
            '100',
            '3',
            SYSDATE,
            v_sal_proc,
            v_cod_contado, -- contado, regalo, consignacion
            0, -- num cuotas
            '',
            v_tip_foliacion,
            v_cod_miscela
         );
      END;

      SELECT cod_retorno
        INTO v_cod_retorno
        FROM ga_transacabo
       WHERE num_transaccion = v_seq_transacabo;

      IF v_cod_retorno != 0
      THEN
         i_stmt := 6;
         v_msj := 'ERROR, dentro del PL fa_ins_interfact';
         RAISE error_proceso;
      END IF;
   END LOOP;

   UPDATE fa_interfact
      SET cod_estadoc = 950
    WHERE num_proceso IN (SELECT a.num_proceso
                            FROM fa_interfact a, ga_ventas b
                           WHERE a.cod_estadoc = 0
                             AND a.cod_estproc = 3
                             AND a.num_venta = b.num_venta
                             AND a.cod_catribut = 'F');

   COMMIT;
EXCEPTION
   WHEN OTHERS
   THEN
      v_cod_sqlcode := SQLCODE;
      v_cod_sqlerrm := SUBSTR (SQLERRM, 1, 60);
      DBMS_OUTPUT.put_line (SQLERRM);
      ROLLBACK;
      SELECT ga_seq_transacabo.NEXTVAL
        INTO v_seq_transacabo
        FROM DUAL;

      INSERT INTO ga_transacabo
                  (num_transaccion, cod_retorno, des_cadena)
           VALUES (v_seq_transacabo, i_stmt, v_msj);

      COMMIT;
END;
/
SHOW ERRORS
