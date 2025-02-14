CREATE OR REPLACE PACKAGE BODY Co_Cancelacion_Pg
IS
   PROCEDURE co_insertar_errores_pr (
      en_numtransaccion   IN   NUMBER,
      en_retorno          IN   NUMBER,
      ev_glosa            IN   VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_INSERTAR_ERRORES_PR" Lenguaje="PL/SQL" Fecha="22-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Inserta Error en tabla ga_transacabo</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_numtransaccion"    Tipo="NUMBER">   Numero de Transaccion </param>
		<param nom="EN_retorno"           Tipo="NUMBER">   Indicador de si hubo error. 0=Sin Error, 1=Con Error </param>
		<param nom="EV_glosa"     		  Tipo="VARCHAR2"> Descripcion del Error ocurrido </param>
		<Entrada>
		<Salida>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      INSERT INTO GA_TRANSACABO
                  (num_transaccion, cod_retorno, des_cadena
                  )
           VALUES (en_numtransaccion, en_retorno, ev_glosa
                  );

      COMMIT;
   END;

   PROCEDURE co_actualizacartera_pr (
      en_concepto         IN              co_cartera_qt,
      en_numtransaccion   IN              NUMBER,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_ACTUALIZACARTERA_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Actualiza Importe Debe o Haber de la Cartera</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_concepto"       Tipo="TYPE">     Estructura de Concepto a Actualizar </param>
		<param nom="en_numtransaccion" Tipo="TYPE">  Numero de Transaccion </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"     Tipo="NUMKBER">  Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
      gn_numdecimal   NUMBER (1) := 0;
   BEGIN
      sn_retorno := 0;
      sv_glosa   := sv_glosa || ' Error al Obtener Numero de Decimales. ';
      gn_numdecimal := ge_pac_general.param_general ('num_decimal');
      sv_glosa :=
             sv_glosa
          || 'Error al Actualizar Importe de la Cartera. '
          || ' debe :'
          || en_concepto.importe_debe
          || ' haber :'
          || en_concepto.importe_haber;

      UPDATE CO_CARTERA
         SET importe_debe =
                ge_pac_general.redondea (en_concepto.importe_debe,
                                         gn_numdecimal,
                                         0
                                        ),
             importe_haber =
                ge_pac_general.redondea (en_concepto.importe_haber,
                                         gn_numdecimal,
                                         0
                                        ),
             fec_pago = SYSDATE
       WHERE cod_cliente = en_concepto.cod_cliente
         AND num_secuenci = en_concepto.num_secuenci
         AND cod_tipdocum = en_concepto.cod_tipdocum
         AND cod_vendedor_agente = en_concepto.cod_vendedor_agente
         AND letra = en_concepto.letra
         AND cod_centremi = en_concepto.cod_centremi
         AND cod_concepto = en_concepto.cod_concepto
         AND columna = en_concepto.columna;

   		 /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
   		 /*                   Desc   :  Cancelacion de conceptos */
         IF (en_concepto.importe_debe = en_concepto.importe_haber) THEN
             co_cancelaconcepto_pr (en_concepto,
                                    gd_feccancelacion,
                                    gn_numtransaccion,
                                    sn_retorno,
                                    sv_glosa);
         END IF;

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;
   		 /* XO-200509070609 Fin   */

   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_actualizacartera_pr;

   PROCEDURE co_obtieneabonos_pr (
      en_codcliente       IN              NUMBER,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            IN OUT NOCOPY   VARCHAR2,
      se_abonos           IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion   IN              NUMBER
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_OBTIENEABONOS_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Modificaci¢n = "Incidencia RA-200603160921" Fecha="30-05-2006" Versi¢n="1.0.2">
		<Retorno>NA</Retorno>
		<Descripci¢n>Obtiene Abonos de un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente"  Tipo="NUMBER">   Estructura de Concepto a Actualizar </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"     Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<param nom="SE_cargos"     	Tipo="TYPE">     Estructura de Cargos del Cliente. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/

      gv_nomtabla           VARCHAR2 (10)                   := 'CO_CARTERA';
      gv_nomcolumna         VARCHAR2 (12)                   := 'COD_TIPDOCUM';
      tn_indfacturado       CO_CARTERA.ind_facturado%TYPE   := 1;
      tn_indabono           CO_TIPCONCEP.ind_abono%TYPE     := 1;

      CURSOR cur_abonos (en_codcliente NUMBER)
      IS
         SELECT   c.cod_tipdocum, c.cod_centremi, c.cod_concepto,
                  c.num_secuenci, c.cod_vendedor_agente, c.letra, c.columna,
                  c.cod_producto, c.importe_debe, c.importe_haber,
                  c.NUM_ABONADO, c.num_folio, c.num_cuota, c.sec_cuota,
                  c.num_transaccion, c.num_venta, c.pref_plaza,
                  c.cod_operadora_scl, c.cod_plaza, tc.cod_tipconce
             FROM CO_CARTERA c, CO_CONCEPTOS co, CO_TIPCONCEP tc
            WHERE tc.cod_tipconce = co.cod_tipconce
              AND co.cod_concepto = c.cod_concepto
              AND tc.ind_abono = tn_indabono
              AND c.cod_tipdocum NOT IN (
                     SELECT TO_NUMBER (cod.cod_valor)
                       FROM CO_CODIGOS cod
                      WHERE cod.nom_tabla = gv_nomtabla
                        AND cod.nom_columna = gv_nomcolumna)
              AND c.ind_facturado = tn_indfacturado
              AND c.cod_cliente = en_codcliente
         ORDER BY c.fec_vencimie, c.num_secuenci, c.columna; /* SQ 30-05-2006 RA-200603160921 */

      gn_i                  NUMBER (6)                      := 0;
      ln_estructuraabonos   co_cartera_qt;
      gn_numdecimal         NUMBER (1)                      := 0;
   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Error al Obtener Numero de Decimales. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';
      gn_numdecimal := ge_pac_general.param_general ('num_decimal');
      sv_glosa := 'Inicializa estructura de Abonos. ';

      ln_estructuraabonos :=
         co_cartera_qt (0,
                        0,
                        0,
                        0,
                        '',
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        '',
                        '',
                        '',
                        '',
                        0,
                        0
                       );
      sv_glosa :=
             'Error al recorrer cursor de Abonos del Cliente. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      FOR reg IN cur_abonos (en_codcliente)
      LOOP
         ln_estructuraabonos.cod_cliente := en_codcliente;
         ln_estructuraabonos.num_secuenci := reg.num_secuenci;
         ln_estructuraabonos.cod_tipdocum := reg.cod_tipdocum;
         ln_estructuraabonos.cod_vendedor_agente := reg.cod_vendedor_agente;
         ln_estructuraabonos.letra := reg.letra;
         ln_estructuraabonos.cod_centremi := reg.cod_centremi;
         ln_estructuraabonos.cod_concepto := reg.cod_concepto;
         ln_estructuraabonos.columna := reg.columna;
         ln_estructuraabonos.cod_producto := reg.cod_producto;
         ln_estructuraabonos.NUM_ABONADO := reg.NUM_ABONADO;
         ln_estructuraabonos.importe_debe :=
                 ge_pac_general.redondea (reg.importe_debe, gn_numdecimal, 0);
         ln_estructuraabonos.importe_haber :=
                ge_pac_general.redondea (reg.importe_haber, gn_numdecimal, 0);
         ln_estructuraabonos.cod_tipconce := reg.cod_tipconce;
         ln_estructuraabonos.ind_cancelado := 'N';
         se_abonos.EXTEND;
         gn_i := gn_i + 1;
         se_abonos (gn_i) := ln_estructuraabonos;
      END LOOP;

      gn_numabonos := gn_i;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_obtieneabonos_pr;

   PROCEDURE co_obtienecargos_pr (
      en_codcliente       IN              NUMBER,
      sn_retorno          OUT NOCOPY      NUMBER,
      ev_tipcancelacion   IN              VARCHAR2 DEFAULT NULL,
      sv_glosa            OUT NOCOPY      VARCHAR2,
      se_cargos           IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion   IN              NUMBER
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_OBTIENECARGOS_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Obtiene Cargos de un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente"     Tipo="NUMBER">   Estructura de Concepto a Actualizar </param>
		<param nom="EV_tipcancelacion" Tipo="VARCHAR2"> Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"        Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	   Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<param nom="SE_cargos"     	   Tipo="TYPE">     Estructura de Cargos del Cliente. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
      gv_nomtabla           VARCHAR2 (10)                   := 'CO_CARTERA';
      gv_nomcolumna         VARCHAR2 (12)                   := 'COD_TIPDOCUM';
      tn_indfacturado       CO_CARTERA.ind_facturado%TYPE   := 1;
      tn_conceptocastigo    CO_CARTERA.cod_concepto%TYPE    := 6;
      tn_conceptoabono      CO_CARTERA.cod_concepto%TYPE    := 2;

      CURSOR cur_cargos (en_codcliente NUMBER)
      IS
         SELECT   c.cod_tipdocum, c.cod_centremi, c.num_secuenci,
                  c.cod_vendedor_agente, c.letra, c.cod_concepto, c.columna,
                  c.cod_producto, c.importe_debe, c.importe_haber,
                  c.NUM_ABONADO, c.num_folio, c.num_cuota, c.sec_cuota,
                  c.num_transaccion, c.num_venta, c.pref_plaza,
                  c.cod_operadora_scl, c.cod_plaza, co.cod_tipconce
             FROM CO_CARTERA c, CO_CONCEPTOS co, CO_TIPCONCEP tc
            WHERE tc.cod_tipconce = co.cod_tipconce
              AND co.cod_concepto = c.cod_concepto
              AND c.cod_tipdocum NOT IN (
                     SELECT TO_NUMBER (cod.cod_valor)
                       FROM CO_CODIGOS cod
                      WHERE cod.nom_tabla = gv_nomtabla
                        AND cod.nom_columna = gv_nomcolumna)
              AND c.cod_concepto NOT IN
                                       (tn_conceptoabono, tn_conceptocastigo)
              AND c.ind_facturado = tn_indfacturado
              AND c.cod_cliente = en_codcliente
         ORDER BY c.fec_vencimie,
                  c.num_secuenci,
                  co.orden_can,
                  c.cod_producto,
                  c.NUM_ABONADO;

      gn_i                  NUMBER (6)                      := 0;
      ln_estructuracargos   co_cartera_qt;
      gn_numdecimal         NUMBER (1)                      := 0;
   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Error al Obtener Numero de Decimales. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';
      gn_numdecimal := ge_pac_general.param_general ('num_decimal');
      sv_glosa := 'Inicializa estructura de Cargos. ';

      ln_estructuracargos :=
         co_cartera_qt (0,
                        0,
                        0,
                        0,
                        '',
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        '',
                        '',
                        '',
                        '',
                        0,
                        0
                       );
      sv_glosa :=
             'Error al Obtener Cargos del Cliente. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      FOR reg IN cur_cargos (en_codcliente)
      LOOP
         ln_estructuracargos.cod_cliente := en_codcliente;
         ln_estructuracargos.num_secuenci := reg.num_secuenci;
         ln_estructuracargos.cod_tipdocum := reg.cod_tipdocum;
         ln_estructuracargos.cod_vendedor_agente := reg.cod_vendedor_agente;
         ln_estructuracargos.letra := reg.letra;
         ln_estructuracargos.cod_centremi := reg.cod_centremi;
         ln_estructuracargos.cod_concepto := reg.cod_concepto;
         ln_estructuracargos.columna := reg.columna;
         ln_estructuracargos.cod_producto := reg.cod_producto;
         ln_estructuracargos.importe_debe :=
                 ge_pac_general.redondea (reg.importe_debe, gn_numdecimal, 0);
         ln_estructuracargos.importe_haber :=
                ge_pac_general.redondea (reg.importe_haber, gn_numdecimal, 0);
         ln_estructuracargos.NUM_ABONADO := reg.NUM_ABONADO;
         ln_estructuracargos.num_folio := reg.num_folio;
         ln_estructuracargos.num_cuota := reg.num_cuota;
         ln_estructuracargos.sec_cuota := reg.sec_cuota;
         ln_estructuracargos.num_transaccion := reg.num_transaccion;
         ln_estructuracargos.num_venta := reg.num_venta;
         ln_estructuracargos.pref_plaza := reg.pref_plaza;
         ln_estructuracargos.cod_operadora_scl := reg.cod_operadora_scl;
         ln_estructuracargos.cod_plaza := reg.cod_plaza;
         ln_estructuracargos.cod_tipconce := reg.cod_tipconce;
         ln_estructuracargos.ind_cancelado := 'N';
         se_cargos.EXTEND;
         gn_i := gn_i + 1;
         se_cargos (gn_i) := ln_estructuracargos;
      END LOOP;

      gn_numcargos := gn_i;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_obtienecargos_pr;

   PROCEDURE co_cancelaconcepto_pr (
      en_estructuracargo   IN              co_cartera_qt,
      ed_feccancelacion    IN              DATE,
      en_numtransaccion    IN              NUMBER,
      sn_retorno           OUT NOCOPY      NUMBER,
      sv_glosa             OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACONCEPTO_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Registra como cancelado un concepto espec¡fico</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_estructuracargo" Tipo="NUMBER">   Estructura de Concepto a Actualizar </param>
		<param nom="ED_feccancelacion"  Tipo="DATE">     Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/

      CURSOR c_cursor_cancelados (
         en_codcliente     IN   NUMBER,
         en_codtipdocum    IN   NUMBER,
         en_codcentremi    IN   NUMBER,
         en_numsecuenci    IN   NUMBER,
         en_codagente      IN   NUMBER,
         en_letra          IN   VARCHAR2,
         en_codproducto    IN   VARCHAR2,
         en_numabonado     IN   NUMBER,
         en_codconcepto    IN   NUMBER,
         en_columna        IN   NUMBER,
         en_fechistorico   IN   DATE
      )
      IS
         SELECT car.cod_cliente, car.cod_tipdocum, car.cod_centremi,
                car.num_secuenci, car.cod_vendedor_agente, car.letra,
                car.cod_concepto, car.columna, car.cod_producto,
                car.importe_debe, car.importe_haber, car.ind_contado,
                car.ind_facturado, car.fec_efectividad,
                ed_feccancelacion AS fec_cancelacion, 0 AS ind_portador,
                car.fec_vencimie, car.fec_caducida, car.fec_antiguedad,
                SYSDATE AS fec_pago, car.NUM_ABONADO, car.num_folio,
                car.num_folioctc, car.num_cuota, car.sec_cuota,
                car.num_transaccion, car.num_venta, car.pref_plaza,
                car.cod_operadora_scl, car.cod_plaza
           FROM CO_CARTERA car
          WHERE car.cod_cliente = en_codcliente
            AND car.cod_tipdocum = en_codtipdocum
            AND car.cod_centremi = en_codcentremi
            AND car.num_secuenci = en_numsecuenci
            AND car.cod_vendedor_agente = en_codagente
            AND car.letra = en_letra
            AND car.cod_producto = en_codproducto
            AND car.NUM_ABONADO = en_numabonado
            AND car.cod_concepto = en_codconcepto
            AND car.columna = en_columna;

      gn_numdecimal   NUMBER (1) := 0;
   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Error al Obtener Numero de Decimales. '
          || 'Fecha : '
          || SYSDATE
          || '. ';
      gn_numdecimal := ge_pac_general.param_general ('num_decimal');
      sv_glosa :=
             'Error al Insertar en CO_CANCELADOS. Cliente : '
          || en_estructuracargo.cod_cliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      FOR rreg IN c_cursor_cancelados (en_estructuracargo.cod_cliente,
                                       en_estructuracargo.cod_tipdocum,
                                       en_estructuracargo.cod_centremi,
                                       en_estructuracargo.num_secuenci,
                                       en_estructuracargo.cod_vendedor_agente,
                                       en_estructuracargo.letra,
                                       en_estructuracargo.cod_producto,
                                       en_estructuracargo.NUM_ABONADO,
                                       en_estructuracargo.cod_concepto,
                                       en_estructuracargo.columna,
                                       ed_feccancelacion
                                      )
      LOOP
         BEGIN
            INSERT INTO CO_CANCELADOS
                        (cod_cliente, cod_tipdocum,
                         cod_centremi, num_secuenci,
                         cod_vendedor_agente, letra,
                         cod_concepto, columna, cod_producto,
                         importe_debe,
                         importe_haber,
                         ind_contado, ind_facturado,
                         fec_efectividad, fec_cancelacion,
                         ind_portador, fec_vencimie,
                         fec_caducida, fec_antiguedad,
                         fec_pago, NUM_ABONADO, num_folio,
                         num_folioctc, num_cuota, sec_cuota,
                         num_transaccion, num_venta,
                         pref_plaza, cod_operadora_scl,
                         cod_plaza
                        )
                 VALUES (rreg.cod_cliente, rreg.cod_tipdocum,
                         rreg.cod_centremi, rreg.num_secuenci,
                         rreg.cod_vendedor_agente, rreg.letra,
                         rreg.cod_concepto, rreg.columna, rreg.cod_producto,
                         ge_pac_general.redondea (rreg.importe_debe,
                                                  gn_numdecimal,
                                                  0
                                                 ),
                         ge_pac_general.redondea (rreg.importe_haber,
                                                  gn_numdecimal,
                                                  0
                                                 ),
                         rreg.ind_contado, rreg.ind_facturado,
                         rreg.fec_efectividad, rreg.fec_cancelacion,
                         rreg.ind_portador, rreg.fec_vencimie,
                         rreg.fec_caducida, rreg.fec_antiguedad,
                         rreg.fec_pago, rreg.NUM_ABONADO, rreg.num_folio,
                         rreg.num_folioctc, rreg.num_cuota, rreg.sec_cuota,
                         rreg.num_transaccion, rreg.num_venta,
                         rreg.pref_plaza, rreg.cod_operadora_scl,
                         rreg.cod_plaza
                        );
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
               sn_retorno := 1;
               sv_glosa := sv_glosa || SQLERRM;
            WHEN OTHERS
            THEN
               sn_retorno := 1;
               sv_glosa := sv_glosa || SQLERRM;
         END;

         BEGIN
            sv_glosa :=
                   'Error al Eliminar CO_CARTERA. Cliente : '
                || en_estructuracargo.cod_cliente
                || ', Fecha : '
                || SYSDATE
                || '. ';

            DELETE      CO_CARTERA
                  WHERE cod_cliente = rreg.cod_cliente
                    AND cod_tipdocum = rreg.cod_tipdocum
                    AND cod_centremi = rreg.cod_centremi
                    AND num_secuenci = rreg.num_secuenci
                    AND cod_vendedor_agente = rreg.cod_vendedor_agente
                    AND letra = rreg.letra
                    AND cod_concepto = rreg.cod_concepto
                    AND columna = rreg.columna
                    AND cod_producto = rreg.cod_producto
                    AND NUM_ABONADO = rreg.NUM_ABONADO;

            sv_glosa := ' Exito al borrar co_cartera ';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sn_retorno := 1;
               sv_glosa := sv_glosa || SQLERRM;
            WHEN OTHERS
            THEN
               sn_retorno := 1;
               sv_glosa := sv_glosa || SQLERRM;
         END;
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_cancelaconcepto_pr;

   PROCEDURE co_registrarelconcep_pr (
      en_estructuraabono   IN              co_cartera_qt,
      en_estructuracargo   IN              co_cartera_qt,
      en_numtransaccion    IN              NUMBER,
      sn_retorno           OUT NOCOPY      NUMBER,
      sv_glosa             OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_REGISTRARELCONCEP_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Registra la Relacion del concepto de Abono con el concepto de Cargo en tabla CO_PAGOSCONC</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_estructuraabono" Tipo="TYPE"> Estructura del Abono </param>
		<param nom="EN_estructuracargo" Tipo="TYPE"> Estructura del Cargo </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Error al registrar la relacion del concepto. Cliente : '
          || en_estructuraabono.cod_cliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      INSERT INTO CO_PAGOSCONC
                  (cod_tipdocum,
                   cod_centremi,
                   num_secuenci,
                   cod_vendedor_agente,
                   letra,
                   imp_concepto,
                   cod_producto,
                   cod_tipdocrel,
                   cod_centrrel,
                   num_securel,
                   cod_agenterel,
                   letra_rel, cod_concepto,
                   columna,
                   NUM_ABONADO,
                   num_folio,
                   num_cuota,
                   sec_cuota,
                   num_transaccion,
                   num_venta,
                   pref_plaza,
                   cod_operadora_scl,
                   cod_plaza
                  )
           VALUES (en_estructuraabono.cod_tipdocum,
                   en_estructuraabono.cod_centremi,
                   en_estructuraabono.num_secuenci,
                   en_estructuraabono.cod_vendedor_agente,
                   en_estructuraabono.letra,
                   ge_pac_general.redondea (en_estructuracargo.mto_pagado,gn_numdecimal,0),
                   en_estructuracargo.cod_producto,
                   en_estructuracargo.cod_tipdocum,
                   en_estructuracargo.cod_centremi,
                   en_estructuracargo.num_secuenci,
                   en_estructuracargo.cod_vendedor_agente,
                   en_estructuracargo.letra, en_estructuracargo.cod_concepto,
                   en_estructuracargo.columna,
                   en_estructuracargo.NUM_ABONADO,
                   en_estructuracargo.num_folio,
                   en_estructuracargo.num_cuota,
                   en_estructuracargo.sec_cuota,
                   en_estructuracargo.num_transaccion,
                   en_estructuracargo.num_venta,
                   en_estructuracargo.pref_plaza,
                   en_estructuracargo.cod_operadora_scl,
                   en_estructuracargo.cod_plaza
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_registrarelconcep_pr;

   PROCEDURE co_cancelacartera_pr (
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      en_indcarrier         IN OUT NOCOPY   NUMBER,
      en_estructuraabonos   IN              co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN              co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN              VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACARTERA_PR" Lenguaje="PL/SQL" Fecha="14-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Cancela los cargos de un Cliente con los abonos existentes en su Cta. Cte.</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente" 		 Tipo="NUMBER">   Codigo del Cliente </param>
		<param nom="ED_feccancelacion"   Tipo="DATE">     Fecha de Cancelacion </param>
		<param nom="EN_numtransaccion"   Tipo="NUMBER">   Numero de Transaccion para errores </param>
		<param nom="EN_estructuraabonos" Tipo="TYPE">     Estructura de Abonos a Cancelar (Opcional) </param>
		<param nom="EN_estructuracargos" Tipo="TYPE">     Estructura de Cargos a Cancelar (Opcional) </param>
		<param nom="EV_tipcancelacion"   Tipo="VARCHAR2"> Tipo de Cancelaci¢n (Opcional, se usar  para no cancelar cargos con castigo) </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">    Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2">  Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/

      ln_estructuraabonos   co_carteraconc_qt         := co_carteraconc_qt ();
      ln_estructuracargos   co_carteraconc_qt         := co_carteraconc_qt ();
      tn_montocredito       CO_CARTERA.importe_debe%TYPE;
      tn_montocargo         CO_CARTERA.importe_debe%TYPE;
      tn_totalcredito       CO_CARTERA.importe_haber%TYPE;
      tn_montoimporte       CO_CARTERA.importe_debe%TYPE;
      tn_sumadeuda          CO_CARTERA.importe_debe%TYPE;
      lb_sort               BOOLEAN                         := FALSE;
      sn_totabono           CO_CARTERA.importe_debe%TYPE;
      sn_resto              CO_CARTERA.importe_debe%TYPE;
      sn_ultreg             NUMBER (6);
      sn_sumadeuda          CO_CARTERA.importe_debe%TYPE;
   BEGIN
      sn_retorno := 0;
      gb_salir := TRUE;
      sv_glosa :=
             'Error al Obtener Numero de Decimales. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';
      gn_numdecimal := ge_pac_general.param_general ('num_decimal');

      IF en_estructuraabonos IS NULL
      THEN
         sv_glosa :=
                'Error en llamada a Procedimiento CO_OBTIENEABONOS_PR. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_obtieneabonos_pr (en_codcliente,
                              sn_retorno,
                              sv_glosa,
                              ln_estructuraabonos,
                              en_numtransaccion
                             );

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;
      ELSE
         sv_glosa :=
                'Error en Traspaso de Estructura Abonos. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         ln_estructuraabonos := en_estructuraabonos;
         gn_numabonos := en_estructuraabonos.COUNT;
      END IF;

      IF en_estructuracargos IS NULL
      THEN
         sv_glosa :=
                'Error en llamada a Procedimiento CO_OBTIENECARGOS_PR. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_obtienecargos_pr (en_codcliente,
                              sn_retorno,
                              ev_tipcancelacion,
                              sv_glosa,
                              ln_estructuracargos,
                              en_numtransaccion
                             );

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;

         lb_sort := TRUE; -- DATOS VIENEN ORDENADOS
      ELSE
         sv_glosa :=
                'Error en Traspaso de Estructura Cargos. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         ln_estructuracargos := en_estructuracargos;
         gn_numcargos := en_estructuracargos.COUNT;
         lb_sort := FALSE; -- DATOS VIENEN EXTERNOS AL PROGRAMA
      END IF;

      sv_glosa :=
             'Inicio de Cursor de Abonos. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

/* 1 - TOTALIZAR ABONOS */

      co_sumaabonos_pr (ln_estructuraabonos, sn_totabono, sn_retorno,
                        sv_glosa);

      IF sn_retorno <> 0
      THEN
         RAISE error_exception;
      END IF;

      IF gn_numabonos = 0
      THEN
         sn_retorno := 0; -- proceso termina con exito, sin avisar, para no provocar problemas a otros procesos
         RETURN;
      END IF;

/*  2 - SOLO SI EL CARGO VIENE POR PARAMETRO, SE UTILIZAR METODO BURBUJA  */
      IF NOT lb_sort
      THEN
         co_ordenacargos_pr (ln_estructuracargos,
                             en_numtransaccion,
                             sn_retorno,
                             sv_glosa
                            );

         IF sn_retorno <> 0
         THEN
            RETURN;
         END IF;
      END IF;

      IF gn_numcargos = 0
      THEN
         sn_retorno := 0; -- proceso termina con exito, sin avisar, para no provocar problemas a otros procesos
         RETURN;
      END IF;

/* 3 - GENERAR TOTAL X DOCUMENTO  */
      co_generatotalcargos_pr (ln_estructuracargos,
                               en_numtransaccion,
                               sn_retorno,
                               sv_glosa
                              );

      IF sn_retorno <> 0
      THEN
         sv_glosa := sv_glosa || SQLERRM;
         RAISE error_exception;
      END IF;

/* 4 - VERIFICO SI CANCELO 100 % O PARCIAL EL DOCUMENTO  */
      gn_j := gv_totdocumento.COUNT;

      FOR gn_i IN 1 .. gn_j
      LOOP --Loop Totales por documento
         IF sn_totabono >= gv_totdocumento (gn_i).monto
         THEN

            co_cancela_total_pr (ln_estructuracargos,
                                 ln_estructuraabonos,
                                 gv_totdocumento (gn_i).num_secuenci,
                                 en_codcliente,
                                 ed_feccancelacion,
                                 en_numtransaccion,
                                 sn_retorno,
                                 sv_glosa
                                );

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;

            sn_totabono := sn_totabono - gv_totdocumento (gn_i).monto;
         ELSE
            co_cancela_parcial_100_pr (ln_estructuracargos,
                                       ln_estructuraabonos,
                                       gv_totdocumento (gn_i).num_secuenci,
                                       en_codcliente,
                                       ed_feccancelacion,
                                       en_numtransaccion,
                                       sn_ultreg,
                                       sn_sumadeuda,
                                       sn_resto,
                                       sn_retorno,
                                       sv_glosa
                                      );

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;

            IF sn_sumadeuda > 0 AND sn_resto > 0
            THEN
               co_cancela_parcial_resto_pr (ln_estructuracargos,
                                            ln_estructuraabonos,
                                            gv_totdocumento (gn_i).num_secuenci,
                                            en_codcliente,
                                            ed_feccancelacion,
                                            en_numtransaccion,
                                            sn_ultreg,
                                            sn_sumadeuda,
                                            sn_resto,
                                            sn_retorno,
                                            sv_glosa
                                           );

               IF sn_retorno <> 0
               THEN
                  RAISE error_exception;
               END IF;
            END IF;

            sn_totabono := 0;
         END IF;
      END LOOP;
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
         ROLLBACK;
         co_insertar_errores_pr (en_numtransaccion, sn_retorno, sv_glosa);
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
         ROLLBACK;
         co_insertar_errores_pr (en_numtransaccion, sn_retorno, sv_glosa);
   END co_cancelacartera_pr;

   PROCEDURE co_cancelacarrier_pr (
      en_codcliente       IN              NUMBER,
      en_numtransaccion   IN              NUMBER,
      ev_tipcancelacion   IN              VARCHAR2 DEFAULT NULL,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACARRIER_PR" Lenguaje="PL/SQL" Fecha="14-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Cancela los conceptos Carrier que tenga un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente" 		 Tipo="NUMBER">   Codigo del Cliente </param>
		<param nom="ED_feccancelacion"   Tipo="DATE">     Fecha de Cancelacion </param>
		<param nom="EN_numtransaccion"   Tipo="NUMBER">   Numero de Transaccion para errores </param>
		<param nom="EV_tipcancelacion"   Tipo="VARCHAR2"> Tipo de Cancelaci¢n (Opcional, se usar  para no cancelar cargos con castigo) </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">    Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2">  Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
      gv_nomtabla             VARCHAR2 (10)                   := 'CO_CARTERA';
      gv_nomcolumna           VARCHAR2 (12)                 := 'COD_TIPDOCUM';

      CURSOR c_cursor_carrier (en_codcliente IN NUMBER)
      IS
         SELECT   a.num_secuenci, a.cod_tipdocum, a.cod_vendedor_agente,
                  a.letra, a.cod_centremi, a.cod_concepto, a.cod_producto,
                  a.columna, a.importe_debe, a.importe_haber, a.NUM_ABONADO,
                  a.num_folio, a.num_cuota, a.sec_cuota, a.num_transaccion,
                  a.num_venta, a.pref_plaza, a.cod_operadora_scl,
                  a.cod_plaza, b.cod_tipconce
             FROM CO_CARTERA a, CO_CONCEPTOS b, CO_DATGEN c
            WHERE c.tip_concepcarrier = b.cod_tipconce
              AND b.cod_concepto = a.cod_concepto
              AND a.cod_cliente = en_codcliente
              AND a.ind_facturado = 1
              AND a.cod_tipdocum NOT IN (
                     SELECT TO_NUMBER (c.cod_valor)
                       FROM CO_CODIGOS c
                      WHERE c.nom_tabla = gv_nomtabla
                        AND c.nom_columna = gv_nomcolumna)
         ORDER BY a.fec_vencimie, b.orden_can, a.cod_producto, a.NUM_ABONADO;

      tn_importecarrier       CO_CARTERA.importe_debe%TYPE;
      tn_importeabonos        CO_CARTERA.importe_debe%TYPE;
      tn_indabono             CO_TIPCONCEP.ind_abono%TYPE     := 1;
      tn_indfacturado         CO_CARTERA.ind_facturado%TYPE   := 1;
      gn_indcarrier           NUMBER (1)                      := 1;
      ln_estructuracarrier    co_cartera_qt;
      ln_estructuratraspaso   co_carteraconc_qt        := co_carteraconc_qt ();
   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Inicio de Cursor de Conceptos Carrier. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      FOR rreg IN c_cursor_carrier (en_codcliente)
      LOOP
         tn_importecarrier := rreg.importe_debe - rreg.importe_haber;

         IF tn_importecarrier <= 0
         THEN
            --Error
            sn_retorno := 1;
            sv_glosa :=
                   'Error, Monto de Concepto Carrier Menor a Cero. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            RAISE error_exception;
         END IF;

         sv_glosa :=
                'Obtiene Importe de los Conceptos. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';

         SELECT SUM (c.importe_haber - c.importe_debe)
           INTO tn_importeabonos
           FROM CO_CARTERA c, CO_CONCEPTOS co, CO_TIPCONCEP tc
          WHERE tc.cod_tipconce = co.cod_concepto
            AND co.cod_concepto = c.cod_concepto
            AND tc.ind_abono = tn_indabono
            AND c.cod_tipdocum NOT IN (
                   SELECT TO_NUMBER (cod.cod_valor)
                     FROM CO_CODIGOS cod
                    WHERE cod.nom_tabla = gv_nomtabla
                      AND cod.nom_columna = gv_nomcolumna)
            AND c.ind_facturado = tn_indfacturado
            AND c.cod_cliente = en_codcliente;

         IF tn_importeabonos >= tn_importecarrier
         THEN
            sv_glosa :=
                   'Inicializa estructura de Cargos Carrier. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            ln_estructuracarrier :=
               co_cartera_qt (0,
                              0,
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              '',
                              0,
                              0
                             );
            sv_glosa :=
                   'Llena Estructura de Cargos Carrier. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            ln_estructuracarrier.cod_cliente := en_codcliente;
            ln_estructuracarrier.num_secuenci := rreg.num_secuenci;
            ln_estructuracarrier.cod_tipdocum := rreg.cod_tipdocum;
            ln_estructuracarrier.cod_vendedor_agente :=
                                                      rreg.cod_vendedor_agente;
            ln_estructuracarrier.letra := rreg.letra;
            ln_estructuracarrier.cod_centremi := rreg.cod_centremi;
            ln_estructuracarrier.cod_concepto := rreg.cod_concepto;
            ln_estructuracarrier.columna := rreg.columna;
            ln_estructuracarrier.cod_producto := rreg.cod_producto;
            ln_estructuracarrier.importe_debe := rreg.importe_debe;
            ln_estructuracarrier.importe_haber := rreg.importe_haber;
            ln_estructuracarrier.NUM_ABONADO := rreg.NUM_ABONADO;
            ln_estructuracarrier.num_folio := rreg.num_folio;
            ln_estructuracarrier.num_cuota := rreg.num_cuota;
            ln_estructuracarrier.sec_cuota := rreg.sec_cuota;
            ln_estructuracarrier.num_transaccion := rreg.num_transaccion;
            ln_estructuracarrier.num_venta := rreg.num_venta;
            ln_estructuracarrier.pref_plaza := rreg.pref_plaza;
            ln_estructuracarrier.cod_operadora_scl := rreg.cod_operadora_scl;
            ln_estructuracarrier.cod_plaza := rreg.cod_plaza;
            ln_estructuracarrier.cod_tipconce := rreg.cod_tipconce;
            ln_estructuracarrier.ind_cancelado := 'N';
            ln_estructuratraspaso.EXTEND;
            ln_estructuratraspaso (1) := ln_estructuracarrier;
            sv_glosa :=
                   'Error en llamada a Procedimiento CO_CANCELACREDITOS_PR. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            co_cancelacartera_pr (en_codcliente,
                                  SYSDATE,
                                  en_numtransaccion,
                                  gn_indcarrier,
                                  NULL,
                                  ln_estructuratraspaso,
                                  ev_tipcancelacion,
                                  sn_retorno,
                                  sv_glosa
                                 );

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;
         END IF;
      END LOOP;
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1; --  co_cancelacartera ya realizo grabado en tabla de errores
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
         ROLLBACK;
         co_insertar_errores_pr (en_numtransaccion, sn_retorno, sv_glosa);
   END co_cancelacarrier_pr;

   PROCEDURE co_cancelacreditos_pr (
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      en_indcarrier         IN OUT NOCOPY   NUMBER,
      en_estructuraabonos   IN              co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN              co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN              VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACARRIER_PR" Lenguaje="PL/SQL" Fecha="14-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Cancela los conceptos Carrier que tenga un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente" 		 Tipo="NUMBER">   Codigo del Cliente </param>
		<param nom="ED_feccancelacion"   Tipo="DATE">     Fecha de Cancelacion </param>
		<param nom="EN_numtransaccion"   Tipo="NUMBER">   Numero de Transaccion para errores </param>
		<param nom="EN_indcarrier"       Tipo="NUMBER">   Indicador de Cancelar solo conceptos carrier 1=Si , 0=No </param>
		<param nom="EN_estructuraabonos" Tipo="TYPE">     Estructura de Abonos a Cancelar (Opcional) </param>
		<param nom="EN_estructuracargos" Tipo="TYPE">     Estructura de Cargos a Cancelar (Opcional) </param>
		<param nom="EV_tipcancelacion"   Tipo="VARCHAR2"> Tipo de Cancelaci¢n (Opcional, se usar  para no cancelar cargos con castigo) </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">    Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2">  Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/

   BEGIN
      sn_retorno := 0;
	  sv_glosa   := 'OK';

   	  /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
      /*                   Desc   :  Inicializacion de fecha de cancelacion y numero de transaccion */
	  gd_feccancelacion := ed_feccancelacion;
      gn_numtransaccion := en_numtransaccion;
      /* XO-200509070609 Fin   */

      IF en_indcarrier = 0
      THEN
         co_cancelacartera_pr (en_codcliente,
                               ed_feccancelacion,
                               en_numtransaccion,
                               en_indcarrier,
                               en_estructuraabonos,
                               en_estructuracargos,
                               ev_tipcancelacion,
                               sn_retorno,
                               sv_glosa
                              );
      END IF;

      IF en_indcarrier = 1 AND sn_retorno = 0
      THEN
         co_cancelacarrier_pr (en_codcliente,
                               en_numtransaccion,
                               ev_tipcancelacion,
                               sn_retorno,
                               sv_glosa
                              );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_cancelacreditos_pr;

/* NUEVOS PROCEDIMIENTOS DEL PACKAGE */
   PROCEDURE co_sumaabonos_pr (
      en_estructuraabonos   IN              co_carteraconc_qt DEFAULT NULL,
      sn_totabono           OUT NOCOPY      NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : CO_SUMAABONOS_PR</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza. </MODULO >
		<AUTOR >     : Claudio Machuca  / Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Suma Abonos a repartir </DESCRIPCION>
		<FECHAMOD >  : DD/MM/YYYY </FECHAMOD >
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuraabonos: Estructura de Abonos a Cancelar (Opcional) </ParamEntr>
		<ParamSal >  : SN_totabono: Entrega total abonos a repartir </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      tn_montocredito   CO_CARTERA.importe_debe%TYPE;
   BEGIN
      sn_retorno  := 0;
      sn_totabono := 0;
	  sv_glosa    := 'OK';

      FOR gn_i IN 1 .. gn_numabonos
      LOOP -- Loop conceptos de Abono
         tn_montocredito :=
               en_estructuraabonos (gn_i).importe_haber
             - en_estructuraabonos (gn_i).importe_debe;
         sn_totabono := sn_totabono + tn_montocredito;
      END LOOP;
   END co_sumaabonos_pr;

   PROCEDURE co_ordenacargos_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion     IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : CO_ORDENACARGOS_PR</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Ordena los cargos a ser cancelados </DESCRIPCION>
		<FECHAMOD >  : DD/MM/YYYY </FECHAMOD >
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuraabonos: Estructura de Cargos a Ordenar </ParamEntr>
		<ParamEntr>  : en_numtransaccion: Numero de Transaccion </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      lb_finsort   BOOLEAN                       := FALSE;
      lv_key_act   VARCHAR2 (30)           := '99999999999999999999999999999';
      lv_key_ant   VARCHAR2 (30)           := '99999999999999999999999999999';
      ln_orden     CO_CONCEPTOS.orden_can%TYPE;
   BEGIN
      sn_retorno := 0;

      FOR gn_i IN gn_numcargos .. 1
      LOOP -- Loop conceptos para recorrer Cargos
         lb_finsort := FALSE;

         BEGIN
            SELECT orden_can
              INTO ln_orden
              FROM CO_CONCEPTOS
             WHERE cod_concepto = en_estructuracargos (gn_i).cod_concepto;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sv_glosa :=
                   'Error al Ordenar Cargos ' || 'Fecha : ' || SYSDATE
                   || '. ';
               RAISE error_exception;
            WHEN OTHERS
            THEN
               sv_glosa :=
                   'Error al Ordenar Cargos ' || 'Fecha : ' || SYSDATE
                   || '. ';
               RAISE error_exception;
         END;

         lv_key_ant :=
                LPAD (TO_CHAR (en_estructuracargos (gn_i).num_secuenci), 8, 0)
             || LPAD (TO_CHAR (ln_orden), 3, 0);

         FOR gn_j IN 1 .. gn_i
         LOOP
            IF gn_j <= gn_numcargos
            THEN
               lv_key_act :=
                      LPAD (TO_CHAR (en_estructuracargos (gn_i).num_secuenci),
                            8,
                            0
                           )
                   || LPAD (TO_CHAR (ln_orden), 3, 0);

               IF lv_key_ant < lv_key_act
               THEN -- debo hacer swap
                  en_estructuracargos (gn_i + 1) :=
                                                   en_estructuracargos (gn_i);
                  en_estructuracargos (gn_i) := en_estructuracargos (gn_j);
                  en_estructuracargos (gn_j) :=
                                               en_estructuracargos (gn_i + 1);
                  lb_finsort := TRUE;
               END IF;
            END IF;
         END LOOP;

         IF NOT lb_finsort
         THEN
            EXIT; -- NO HAY MAS CAMBIOS
         END IF;
      END LOOP;
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sv_glosa := ' Falla en CO_ORDENACARGOS_PR ';
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_ordenacargos_pr;

   PROCEDURE co_generatotalcargos_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion     IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : CO_GENERATOTALCARGOS_PR</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Genera total de Cargos x documento en cobranza</DESCRIPCION>
		<FECHAMOD >  : DD/MM/YYYY </FECHAMOD >
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuraabonos: Estructura de Cargos a Ordenar </ParamEntr>
		<ParamEntr>  : en_numtransaccion: Numero de Transaccion </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      ln_num_secuenci   CO_CARTERA.num_secuenci%TYPE   := 0;
      ln_montocargo     CO_CARTERA.importe_debe%TYPE   := 0;
   BEGIN
      sn_retorno := 0;
      ln_num_secuenci := 99999999;
      ln_montocargo := 0;
      gn_j := 0;

      FOR gn_i IN 1 .. gn_numcargos
      LOOP -- Loop conceptos para recorrer Cargos
         IF en_estructuracargos (gn_i).num_secuenci <> ln_num_secuenci
         THEN -- cambio documento
            IF ln_montocargo > 0
            THEN
               gn_j := gn_j + 1;
               gv_totdocumento (gn_j).num_secuenci := ln_num_secuenci;
               gv_totdocumento (gn_j).monto := ln_montocargo;
            END IF;

            ln_montocargo := 0;
            ln_num_secuenci := en_estructuracargos (gn_i).num_secuenci;
         END IF;

         ln_montocargo :=
               ln_montocargo
             + en_estructuracargos (gn_i).importe_debe
             - en_estructuracargos (gn_i).importe_haber;
      END LOOP;

      IF ln_montocargo > 0
      THEN
         gn_j := gn_j + 1;
         gv_totdocumento (gn_j).num_secuenci := ln_num_secuenci;
         gv_totdocumento (gn_j).monto := ln_montocargo;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_generatotalcargos_pr;

   PROCEDURE co_cancela_total_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : CO_CANCELA_TOTAL</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Realiza pago total del documento indicado</DESCRIPCION>
		<FECHAMOD >  : "30-05-2006" </FECHAMOD >
		<MODIFICACION> : "Incidencia RA-200603160921"  </MODIFICACION>
		<VERSION MOD>  : "1.1" </VERSION MOD>
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuracargos: Estructura de Cargos a Cancelar </ParamEntr>
		<ParamEntr>  : EN_estructuraabonos: Estructura de Abonos a Aplicar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_CLIENTE: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : ED_FECCANCELACION: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : en_numtransaccion: Numero de Transaccion </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      ln_pago              CO_CARTERA.importe_debe%TYPE   := 0;
      ln_deuda             CO_CARTERA.importe_debe%TYPE   := 0;
      tn_conceptocastigo   CO_CARTERA.cod_concepto%TYPE   := 6;
   BEGIN
      sn_retorno := 0;

      FOR gn_i IN 1 .. gn_numabonos
      LOOP -- Loop conceptos para recorrer Abonos
         IF en_estructuraabonos (gn_i).ind_cancelado != 'S'
         THEN -- ANALIZO SOLO SI NO FUE CANCELADO
            ln_pago :=
                  en_estructuraabonos (gn_i).importe_haber
                - en_estructuraabonos (gn_i).importe_debe;

            FOR gn_j IN 1 .. gn_numcargos
            LOOP -- Loop conceptos para recorrer Cargos
			  IF ln_pago = 0 THEN EXIT; END IF;	/* CAGV 30-05-2006 RA-200603160921 */
               IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                  AND en_estructuracargos (gn_j).num_secuenci =
                                                               en_num_secuenci
               THEN
                  ln_deuda :=
                        en_estructuracargos (gn_j).importe_debe
                      - en_estructuracargos (gn_j).importe_haber;

                  IF ln_pago > ln_deuda
                  THEN -- El abono es mayor a la deuda
                     en_estructuracargos (gn_j).ind_cancelado := 'S'; --marcar cargo cancelado
                     ln_pago := ln_pago - ln_deuda;
					 /* CAGV 30-05-2006 RA-200603160921 */
                     /*en_estructuracargos (gn_j).mto_pagado :=
                              en_estructuracargos (gn_j).mto_pagado
                              + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
					 en_estructuracargos (gn_j).mto_pagado :=	ln_deuda;	/* CAGV 30-05-2006 RA-200603160921 */
                     en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
                     en_estructuraabonos (gn_i).importe_debe :=
                            en_estructuraabonos (gn_i).importe_debe
                            + ln_deuda;
                     sv_glosa :=
                            'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                         || SYSDATE
                         || '. ';
                     co_actualizacartera_pr (en_estructuracargos (gn_j),
                                             en_numtransaccion,
                                             sn_retorno,
                                             sv_glosa
                                            ); --Actualiza Cartera (cargo)

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;

                     sv_glosa :=
                            'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (1). Fecha : '
                         || SYSDATE
                         || '. ';
                     co_cancelaconcepto_pr (en_estructuracargos (gn_j),
                                            ed_feccancelacion,
                                            en_numtransaccion,
                                            sn_retorno,
                                            sv_glosa
                                           ); --Cancela concepto (cargo)

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;
                  ELSE
                     IF ln_pago = ln_deuda
                     THEN -- El abono es igual a la deuda
                        en_estructuracargos (gn_j).ind_cancelado := 'S'; --marcar cargo cancelado
                        en_estructuraabonos (gn_i).ind_cancelado := 'S'; --marcar abono cancelado
                        ln_pago := 0;
						/* CAGV 30-05-2006 RA-200603160921 */
                        /*en_estructuracargos (gn_j).mto_pagado :=
                              en_estructuracargos (gn_j).mto_pagado
                              + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
						en_estructuracargos (gn_j).mto_pagado := ln_deuda;	  /* CAGV 30-05-2006 RA-200603160921 */
                        en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
                        en_estructuraabonos (gn_i).importe_debe :=
                                     en_estructuraabonos (gn_i).importe_haber; -- haber = debe
                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuracargos (gn_j),
                                                en_numtransaccion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (1). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_cancelaconcepto_pr (en_estructuracargos (gn_j),
                                               ed_feccancelacion,
                                               en_numtransaccion,
                                               sn_retorno,
                                               sv_glosa
                                              ); --Cancela concepto (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (2). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                                en_numtransaccion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (2). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                               ed_feccancelacion,
                                               en_numtransaccion,
                                               sn_retorno,
                                               sv_glosa
                                              ); --Cancela concepto (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;
                     ELSE -- El abono es menor a la deuda
 					    /* CAGV 30-05-2006 RA-200603160921 */
                        /*en_estructuracargos (gn_j).mto_pagado :=
                               en_estructuracargos (gn_j).mto_pagado
                               + ln_pago; --- se incrementa el pago con el saldo restante */
						en_estructuracargos (gn_j).mto_pagado := ln_pago;	   /* CAGV 30-05-2006 RA-200603160921 */
                        en_estructuraabonos (gn_i).ind_cancelado := 'S'; --marcar abono cancelado
                        en_estructuraabonos (gn_i).importe_debe :=
                                     en_estructuraabonos (gn_i).importe_haber; -- haber = debe
                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                                en_numtransaccion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (3). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                               ed_feccancelacion,
                                               en_numtransaccion,
                                               sn_retorno,
                                               sv_glosa
                                              ); --Cancela concepto (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        en_estructuracargos (gn_j).importe_haber :=
                             en_estructuracargos (gn_j).importe_haber
                             + ln_pago;
                        ln_pago := 0;
                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuracargos (gn_j),
                                                en_numtransaccion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;
                     END IF;
                  END IF;

                  sv_glosa :=
                         'Error en llamada a Procedimiento CO_REGISTRARELCONCEP_PR. Fecha: '
                      || SYSDATE
                      || '. ';
                  co_registrarelconcep_pr (en_estructuraabonos (gn_i),
                                           en_estructuracargos (gn_j),
                                           en_numtransaccion,
                                           sn_retorno,
                                           sv_glosa
                                          ); --Registra relacion conceptos saldados

                  IF sn_retorno <> 0
                  THEN
                     RAISE error_exception;
                  END IF;

                  IF en_estructuracargos (gn_j).cod_tipconce =
                                                            tn_conceptocastigo
                  THEN
                     --Actualiza Castigo (cargo)
                     sv_glosa :=
                            'Error en llamada a Procedimiento CO_CASTIGOS_EXTERNOS. Fecha : '
                         || SYSDATE
                         || '. '
                         || ' Fol :'
                         || en_estructuracargos (gn_j).num_folio
                         || ' Pla :'
                         || en_estructuracargos (gn_j).pref_plaza
                         || ' Fec :'
                         || TO_CHAR (ed_feccancelacion,
                                     'DD-MM-YYYY HH24:MI:SS'
                                    )
                         || ' Pag :'
                         || en_estructuraabonos (gn_i).mto_pagado
                         || ' xxx :'
                         || '1'
                         || ' Cuo :'
                         || en_estructuracargos (gn_j).sec_cuota
                         || ' Ret :'
                         || sn_retorno;
                     co_castigos_externos (en_codcliente,
                                           en_estructuracargos (gn_j).num_folio,
                                           en_estructuracargos (gn_j).pref_plaza,
                                           TO_CHAR (ed_feccancelacion,
                                                    'DD-MM-YYYY HH24:MI:SS'
                                                   ),
                                           en_estructuraabonos (gn_i).mto_pagado,
                                           1,
                                           en_estructuracargos (gn_j).sec_cuota,
                                           sn_retorno
                                          );

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;
                  END IF;
               END IF;
			 /* END IF;  --Cierre if abono > 0  /* CAGV 30-05-2006 RA-200603160921 */
            END LOOP; -- fin cargos
         END IF;

         IF en_estructuraabonos (gn_i).ind_cancelado !=
                                                 'S' -- quedo saldo sin aplicar
         THEN
            co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                    en_numtransaccion,
                                    sn_retorno,
                                    sv_glosa
                                   ); --Actualiza Saldo Abono no aplicado

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;
         END IF;
      END LOOP; -- fin abonos
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_cancela_total_pr;

   PROCEDURE co_cancela_parcial_100_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      sn_ultreg             OUT NOCOPY      NUMBER,
      sn_sumadeuda          OUT NOCOPY      NUMBER,
      sn_resto              OUT NOCOPY      NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : co_cancela_parcial_100_pr</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Realiza pago total del documento indicado</DESCRIPCION>
		<FECHAMOD >  : "30-05-2006" </FECHAMOD >
		<MODIFICACION> : "Incidencia RA-200603160921"  </MODIFICACION>
		<VERSION MOD>  : "1.1" </VERSION MOD>
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuracargos: Estructura de Cargos a Cancelar </ParamEntr>
		<ParamEntr>  : EN_estructuraabonos: Estructura de Abonos a Aplicar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_CLIENTE: Documento de Cargo a Cancelar </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      ln_pago              CO_CARTERA.importe_debe%TYPE       := 0;
      ln_deuda             CO_CARTERA.importe_debe%TYPE       := 0;
      ln_indporcentaje     CO_CONCEPTOS.ind_porcentaje%TYPE   := 0;
      tn_conceptocastigo   CO_CARTERA.cod_concepto%TYPE       := 6;
   BEGIN
      sn_retorno := 0;
      sn_ultreg := 0;
      sn_sumadeuda := 0;
      sn_resto := 0;

      FOR gn_i IN 1 .. gn_numabonos
      LOOP -- Loop conceptos para recorrer Abonos
         IF en_estructuraabonos (gn_i).ind_cancelado != 'S'
         THEN -- ANALIZO SOLO SI NO FUE CANCELADO
            ln_pago :=
                  en_estructuraabonos (gn_i).importe_haber
                - en_estructuraabonos (gn_i).importe_debe;

            IF ln_pago > 0
            THEN
               FOR gn_j IN 1 .. gn_numcargos
               LOOP -- Loop conceptos para recorrer Cargos
	            IF ln_pago = 0 THEN	EXIT; END IF; /* CAGV 30-05-2006 RA-200603160921 */
                  IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                     AND en_estructuracargos (gn_j).num_secuenci =
                                                               en_num_secuenci
                  THEN
                     ln_deuda :=
                           en_estructuracargos (gn_j).importe_debe
                         - en_estructuracargos (gn_j).importe_haber;

                     IF ln_deuda > 0
                     THEN
                        ln_indporcentaje := 0;

                        BEGIN
                           SELECT ind_porcentaje
                             INTO ln_indporcentaje
                             FROM CO_CONCEPTOS
                            WHERE cod_concepto =
                                       en_estructuracargos (gn_j).cod_concepto;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              sv_glosa :=
                                     'No existe concepto. Fecha : '
                                  || SYSDATE
                                  || '. ';
                              RAISE error_exception;
                           WHEN OTHERS
                           THEN
                              sv_glosa :=
                                     'No existe concepto. Fecha : '
                                  || SYSDATE
                                  || '. ';
                              RAISE error_exception;
                        END;

                        IF ln_indporcentaje = 0
                        THEN -- NO APLICA
                           IF ln_pago > ln_deuda
                           THEN
                              -- El abono es mayor a la deuda
                              en_estructuracargos (gn_j).ind_cancelado := 'S'; --marcar cargo cancelado
                              en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
							  /* CAGV 30-05-2006 RA-200603160921 */
                              /*en_estructuracargos (gn_j).mto_pagado :=
                                    en_estructuracargos (gn_j).mto_pagado
                                  + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
							  en_estructuracargos (gn_j).mto_pagado := ln_deuda;    /* CAGV 30-05-2006 RA-200603160921*/
                              sv_glosa :=
                                     'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                                  || SYSDATE
                                  || '. ';
                              co_actualizacartera_pr (en_estructuracargos (gn_j
                                                                          ),
                                                      en_numtransaccion,
                                                      sn_retorno,
                                                      sv_glosa
                                                     ); --Actualiza Cartera (cargo)

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;

                              sv_glosa :=
                                     'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (1). Fecha : '
                                  || SYSDATE
                                  || '. ';

                              co_cancelaconcepto_pr (en_estructuracargos (gn_j),
                                                     ed_feccancelacion,
                                                     en_numtransaccion,
                                                     sn_retorno,
                                                     sv_glosa
                                                    ); --Cancela concepto (cargo)

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;

                              ln_pago := ln_pago - ln_deuda; -- rebajo la deuda al pago

                                                             ---  actualizo pago en abono
                              en_estructuraabonos (gn_i).importe_debe :=
                                    en_estructuraabonos (gn_i).importe_debe
                                  + ln_deuda;
                              sv_glosa :=
                                     'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Fecha : '
                                  || SYSDATE
                                  || '. ';
                              co_actualizacartera_pr (en_estructuraabonos (gn_i
                                                                          ),
                                                      en_numtransaccion,
                                                      sn_retorno,
                                                      sv_glosa
                                                     ); --Actualiza Cartera (cargo)

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;
---
                           ELSE
                              IF ln_pago = ln_deuda
                              THEN -- El abono es igual a la deuda
                                 en_estructuracargos (gn_j).ind_cancelado :=
                                                                          'S'; --marcar cargo cancelado
                                 en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
							     /* CAGV 30-05-2006 RA-200603160921*/
                                 /*en_estructuracargos (gn_j).mto_pagado :=
                                       en_estructuracargos (gn_j).mto_pagado
                                     + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
								 en_estructuracargos (gn_j).mto_pagado := ln_deuda;	 /* CAGV 30-05-2006 RA-200603160921 */
                                 en_estructuraabonos (gn_i).importe_debe :=
                                      en_estructuracargos (gn_i).importe_haber; -- haber = debe
                                 en_estructuraabonos (gn_i).ind_cancelado :=
                                                                           'S'; --marcar abono cancelado
                                 ln_pago := 0; -- saldo el pago
                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (2). Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuracargos (gn_j
                                                                             ),
                                                         en_numtransaccion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (cargo). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_cancelaconcepto_pr (en_estructuracargos (gn_j
                                                                            ),
                                                        ed_feccancelacion,
                                                        en_numtransaccion,
                                                        sn_retorno,
                                                        sv_glosa
                                                       ); --Cancela concepto (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (2). Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuraabonos (gn_i
                                                                             ),
                                                         en_numtransaccion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (abono). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_cancelaconcepto_pr (en_estructuraabonos (gn_i
                                                                            ),
                                                        ed_feccancelacion,
                                                        en_numtransaccion,
                                                        sn_retorno,
                                                        sv_glosa
                                                       ); --Cancela concepto (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;
                              ELSE -- El abono es menor a la deuda
							     /* CAGV 30-05-2006 RA-200603160921*/
                                 /*en_estructuracargos (gn_j).mto_pagado :=
                                       en_estructuracargos (gn_j).mto_pagado
                                     + ln_pago; --- se incrementa el pago con el saldo restante*/
								 en_estructuracargos (gn_j).mto_pagado := ln_pago; 	/* CAGV 30-05-2006 RA-200603160921*/
                                 en_estructuracargos (gn_j).importe_haber :=
                                       en_estructuracargos (gn_j).importe_haber
                                     + ln_pago;
                                 en_estructuraabonos (gn_i).ind_cancelado :=
                                                                           'S'; --marcar abono cancelado
                                 en_estructuraabonos (gn_i).importe_debe :=
                                      en_estructuraabonos (gn_i).importe_haber; -- haber = debe
                                 ln_pago := 0; -- saldo a cancelar queda en 0
                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuraabonos (gn_i
                                                                             ),
                                                         en_numtransaccion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (2). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_cancelaconcepto_pr (en_estructuraabonos (gn_i
                                                                            ),
                                                        ed_feccancelacion,
                                                        en_numtransaccion,
                                                        sn_retorno,
                                                        sv_glosa
                                                       ); --Cancela concepto (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuracargos (gn_j
                                                                             ),
                                                         en_numtransaccion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;
                              END IF;
                           END IF;                -- if analisis deuda
                                   --Registra relacion conceptos saldados

                           sv_glosa :=
                                  'Error en llamada a Procedimiento CO_REGISTRARELCONCEP_PR. Cliente : '
                               || en_codcliente
                               || ', Fecha : '
                               || SYSDATE
                               || '. ';
                           co_registrarelconcep_pr (en_estructuraabonos (gn_i),
                                                    en_estructuracargos (gn_j),
                                                    en_numtransaccion,
                                                    sn_retorno,
                                                    sv_glosa
                                                   ); --Registra relacion conceptos saldados

                           IF sn_retorno <> 0
                           THEN
                              RAISE error_exception;
                           END IF;

                           --Actualiza Castigo (cargo)
                           IF en_estructuracargos (gn_j).cod_tipconce =
                                                            tn_conceptocastigo
                           THEN
                              sv_glosa :=
                                     'Error 100 en llamada a Procedimiento CO_CASTIGOS_EXTERNOS. Cliente : '
                                  || en_codcliente
                                  || ', Fecha : '
                                  || SYSDATE
                                  || '. ';
                              co_castigos_externos (en_codcliente,
                                                    en_estructuracargos (gn_j).num_folio,
                                                    en_estructuracargos (gn_j).pref_plaza,
                                                    TO_CHAR (ed_feccancelacion,
                                                             'DD-MM-YYYY HH24:MI:SS'
                                                            ),
                                                    en_estructuraabonos (gn_i).mto_pagado,
                                                    1,
                                                    en_estructuracargos (gn_j).sec_cuota,
                                                    sn_retorno
                                                   );

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;
                           END IF;
                        ELSE -- APLICA PROPORCIONALIDAD
                           IF gn_i = 1
                           THEN
                              sn_sumadeuda := sn_sumadeuda + ln_deuda;
                              sn_ultreg := gn_j; -- para saber en que registro debo ajustar el saldo
                           END IF;
                        END IF;
                     END IF;-- cierre if si deuda > 0
                  END IF; -- cierra if de cargo cancelado
				/* END IF; --Cierre if abono > 0  /* CAGV 30-05-2006 RA-200603160921*/
               END LOOP;-- cargos
            END IF; -- pago mayor a 0
         END IF; -- registro no cancelado

         sn_resto := sn_resto + ln_pago;
      END LOOP; -- abonos
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_cancela_parcial_100_pr;

   PROCEDURE co_cancela_parcial_resto_pr (
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      en_ultreg             IN              NUMBER,
      en_sumadeuda          IN              NUMBER,
      en_resto              IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : co_cancela_parcial_resto_pr</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Realiza pago proporcional al documento indicado</DESCRIPCION>
		<FECHAMOD >  : "30-05-2006" </FECHAMOD >
		<MODIFICACION> : "Incidencia RA-200603160921"  </MODIFICACION>
		<VERSION MOD>  : "1.1" </VERSION MOD>
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuracargos: Estructura de Cargos a Cancelar </ParamEntr>
		<ParamEntr>  : EN_estructuraabonos: Estructura de Abonos a Aplicar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_CLIENTE: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : En_saldo: Saldo Documento a Cancelar </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      tn_conceptocastigo   CO_CARTERA.cod_concepto%TYPE   := 6;
      ln_pago              CO_CARTERA.importe_debe%TYPE   := 0;
      ln_pagado            CO_CARTERA.importe_debe%TYPE   := 0;
      ln_deuda             CO_CARTERA.importe_debe%TYPE   := 0;
      ln_pordeuda          NUMBER (8, 2)                  := 0;
      ln_montopagos        CO_CARTERA.importe_debe%TYPE   := 0;
      ln_sumapagos         CO_CARTERA.importe_debe%TYPE   := 0;
      ln_sumadeuda         CO_CARTERA.importe_debe%TYPE   := 0;
      ln_ultreg            NUMBER (8)                     := 0;
   BEGIN
      sn_retorno := 0;
      ln_sumadeuda := en_sumadeuda;
      ln_ultreg := en_ultreg;

      FOR gn_i IN 1 .. gn_numabonos
      LOOP -- Loop conceptos para recorrer Abonos
         IF gn_i > 1
         THEN -- debo recalcular el saldo de deuda
            ln_sumadeuda := 0;

            FOR gn_j IN 1 .. gn_numcargos
            LOOP -- Loop conceptos para recorrer Cargos
               IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                  AND en_estructuracargos (gn_j).num_secuenci =
                                                               en_num_secuenci
               THEN
                  ln_deuda :=
                        en_estructuracargos (gn_j).importe_debe
                      - en_estructuracargos (gn_j).importe_haber;
                  ln_sumadeuda := ln_sumadeuda + ln_deuda;
                  ln_ultreg := gn_j;
               END IF;
            END LOOP;
         END IF;

         IF en_estructuraabonos (gn_i).ind_cancelado != 'S'
         THEN -- ANALIZO SOLO SI NO FUE CANCELADO
            ln_pago :=
                  en_estructuraabonos (gn_i).importe_haber
                - en_estructuraabonos (gn_i).importe_debe;
            ln_sumapagos := 0;

            FOR gn_j IN 1 .. gn_numcargos
            LOOP -- Loop conceptos para recorrer Cargos
	           IF ln_pago = 0 THEN	EXIT; END IF; /* CAGV 30-05-2006 RA-200603160921 */
               IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                  AND en_estructuracargos (gn_j).num_secuenci =
                                                               en_num_secuenci
               THEN
                  ln_deuda :=
                        en_estructuracargos (gn_j).importe_debe
                      - en_estructuracargos (gn_j).importe_haber;
   	  				 /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
                     /*                   Desc   : Variable no se utiliza */
/*                  ln_pordeuda := (ln_deuda / ln_sumadeuda) * 100;*/

  			        /* XO-200509070609 Fin   */
                  IF gn_j = en_ultreg
                  THEN
                     ln_montopagos := ln_pago - ln_sumapagos;
                  ELSE
   	  				 /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
                     /*                   Desc   : Calculo de monto proporcional */
/*                     ln_montopagos := (ln_pago * ln_pordeuda) / 100;*/
                     ln_montopagos := (ln_pago * ((ln_deuda / ln_sumadeuda) * 100)) / 100;
  			        /* XO-200509070609 Fin   */

	                 ln_montopagos := ge_pac_general.redondea (ln_montopagos,gn_numdecimal,0);

                     ln_sumapagos := ln_sumapagos + ln_montopagos;
                  END IF;
 /* CAGV 30-05-2006 RA-200603160921 */
/*                  en_estructuracargos (gn_j).mto_pagado :=
                          en_estructuracargos (gn_j).mto_pagado
                          + ln_montopagos; --- se incrementa el pago con la deuda proporcional*/
                  en_estructuracargos (gn_j).mto_pagado := ln_montopagos; 	 /* CAGV 30-05-2006 RA-200603160921 */
                  en_estructuracargos (gn_j).importe_haber :=
                       en_estructuracargos (gn_j).importe_haber
                       + ln_montopagos;
                  sv_glosa :=
                         'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Cliente : '
                      || en_codcliente
                      || ', Fecha : '
                      || SYSDATE
                      || '. ';
                  co_actualizacartera_pr (en_estructuracargos (gn_j),
                                          en_numtransaccion,
                                          sn_retorno,
                                          sv_glosa
                                         ); --Actualiza Cartera (cargo)

                  IF sn_retorno <> 0
                  THEN
                     RAISE error_exception;
                  END IF;

                  --Registra relacion conceptos saldados
                  sv_glosa :=
                         'Error en llamada a Procedimiento CO_REGISTRARELCONCEP_PR. Cliente : '
                      || en_codcliente
                      || ', Fecha : '
                      || SYSDATE
                      || '. ';
                  co_registrarelconcep_pr (en_estructuraabonos (gn_i),
                                           en_estructuracargos (gn_j),
                                           en_numtransaccion,
                                           sn_retorno,
                                           sv_glosa
                                          ); --Registra relacion conceptos saldados

                  IF sn_retorno <> 0
                  THEN
                     RAISE error_exception;
                  END IF;

                  --Actualiza Castigo (cargo)
                  IF en_estructuracargos (gn_j).cod_tipconce =
                                                            tn_conceptocastigo
                  THEN
                     sv_glosa :=
                            'Error 100 en llamada a Procedimiento CO_CASTIGOS_EXTERNOS. Cliente : '
                         || en_codcliente
                         || ', Fecha : '
                         || SYSDATE
                         || '. ';
                     co_castigos_externos (en_codcliente,
                                           en_estructuracargos (gn_j).num_folio,
                                           en_estructuracargos (gn_j).pref_plaza,
                                           TO_CHAR (ed_feccancelacion,
                                                    'DD-MM-YYYY HH24:MI:SS'
                                                   ),
                                           en_estructuraabonos (gn_i).mto_pagado,
                                           1,
                                           en_estructuracargos (gn_j).sec_cuota,
                                           sn_retorno
                                          );

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;
                  END IF;
               END IF;
            END LOOP; -- cargos
         END IF;

--- Procedo a cancelar abono distribuido
         en_estructuraabonos (gn_i).importe_debe :=
                                      en_estructuraabonos (gn_i).importe_haber;
         sv_glosa :=
                'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                 en_numtransaccion,
                                 sn_retorno,
                                 sv_glosa
                                ); --Actualiza Cartera (abono)

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;

         sv_glosa :=
                'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (2). Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                ed_feccancelacion,
                                en_numtransaccion,
                                sn_retorno,
                                sv_glosa
                               ); --Cancela concepto (cargo)

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;
      END LOOP; -- abonos
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_cancela_parcial_resto_pr;

-----------------------------------------------------------------
   PROCEDURE co_actualizacartera_pr (
      -- PasoCobrosCICLO
      en_concepto         IN              co_cartera_qt,
      en_numtransaccion   IN              NUMBER,
	  en_decimales        IN              NUMBER,
	  ed_feccancelacion   IN              DATE,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_ACTUALIZACARTERA_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Actualiza Importe Debe o Haber de la Cartera</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_concepto"       Tipo="TYPE">     Estructura de Concepto a Actualizar </param>
		<param nom="en_numtransaccion" Tipo="TYPE">  Numero de Transaccion </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"     Tipo="NUMKBER">  Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
   BEGIN
      sn_retorno := 0;
      sv_glosa   := sv_glosa || ' Error al Obtener Numero de Decimales. ';

      sv_glosa :=
             sv_glosa
          || 'Error al Actualizar Importe de la Cartera. '
          || ' debe :'
          || en_concepto.importe_debe
          || ' haber :'
          || en_concepto.importe_haber;

      UPDATE CO_CARTERA
         SET importe_debe = ROUND ( en_concepto.importe_debe, en_decimales ),
             importe_haber = ROUND ( en_concepto.importe_haber, en_decimales ),
             fec_pago = SYSDATE
       WHERE cod_cliente = en_concepto.cod_cliente
         AND num_secuenci = en_concepto.num_secuenci
         AND cod_tipdocum = en_concepto.cod_tipdocum
         AND cod_vendedor_agente = en_concepto.cod_vendedor_agente
         AND letra = en_concepto.letra
         AND cod_centremi = en_concepto.cod_centremi
         AND cod_concepto = en_concepto.cod_concepto
         AND columna = en_concepto.columna;

   		 /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
   		 /*                   Desc   :  Cancelacion de conceptos */
         IF (en_concepto.importe_debe = en_concepto.importe_haber) THEN
             co_cancelaconcepto_pr (en_concepto,
                                    ed_feccancelacion,
                                    en_numtransaccion,
									en_decimales,
                                    sn_retorno,
                                    sv_glosa);
         END IF;

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;
   		 /* XO-200509070609 Fin   */

   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_actualizacartera_pr;

   PROCEDURE co_obtieneabonos_pr (
      en_codcliente       IN              NUMBER,
	  en_decimales        IN              NUMBER,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            IN OUT NOCOPY   VARCHAR2,
      se_abonos           IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion   IN              NUMBER
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_OBTIENEABONOS_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Modificaci¢n = "Incidencia RA-200603160921" Fecha="30-05-2006" Versi¢n="1.0.2">
		<Retorno>NA</Retorno>
		<Descripci¢n>Obtiene Abonos de un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente"  Tipo="NUMBER">   Estructura de Concepto a Actualizar </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"     Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<param nom="SE_cargos"     	Tipo="TYPE">     Estructura de Cargos del Cliente. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/

      gv_nomtabla           VARCHAR2 (10)                   := 'CO_CARTERA';
      gv_nomcolumna         VARCHAR2 (12)                   := 'COD_TIPDOCUM';
      tn_indfacturado       CO_CARTERA.ind_facturado%TYPE   := 1;
      tn_indabono           CO_TIPCONCEP.ind_abono%TYPE     := 1;
--
   BEGIN
      sn_retorno := 0;
	  sv_glosa := 'Lectura de abonos';
         SELECT   co_cartera_qt (
			          en_codcliente,
	                  c.num_secuenci,
			          c.cod_tipdocum,
					  c.cod_vendedor_agente,
					  c.letra,
					  c.cod_centremi,
					  c.cod_concepto,
					  c.columna,
	                  c.cod_producto,
					  ROUND (c.importe_debe, en_decimales),
					  ROUND (c.importe_haber, en_decimales),
	                  c.NUM_ABONADO,
					  c.num_folio,
					  c.num_cuota,
					  c.sec_cuota,
	                  c.num_transaccion,
					  c.num_venta,
					  c.pref_plaza,
	                  c.cod_operadora_scl,
					  c.cod_plaza,
					  'N',
					  tc.cod_tipconce,
					  0.0
				  )
		BULK COLLECT INTO se_abonos
             FROM CO_CARTERA c, CO_CONCEPTOS co, CO_TIPCONCEP tc
            WHERE tc.cod_tipconce = co.cod_tipconce
              AND co.cod_concepto = c.cod_concepto
              AND tc.ind_abono = tn_indabono
              AND c.cod_tipdocum NOT IN (
                     SELECT TO_NUMBER (cod.cod_valor)
                       FROM CO_CODIGOS cod
                      WHERE cod.nom_tabla = gv_nomtabla
                        AND cod.nom_columna = gv_nomcolumna)
              AND c.ind_facturado = tn_indfacturado
              AND c.cod_cliente = en_codcliente
         ORDER BY c.fec_vencimie, c.num_secuenci, c.columna;

	  IF se_abonos IS NULL THEN
	  gn_numabonos := 0;
	  ELSE gn_numabonos := se_abonos.COUNT;
	  END IF;

   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || '(' || SQLERRM || ')';
   END co_obtieneabonos_pr;

   PROCEDURE co_obtienecargos_pr (
      -- PasoCobrosCICLO
      en_codcliente       IN              NUMBER,
	  en_decimales        IN              NUMBER,
      sn_retorno          OUT NOCOPY      NUMBER,
      ev_tipcancelacion   IN              VARCHAR2 DEFAULT NULL,
      sv_glosa            OUT NOCOPY      VARCHAR2,
      se_cargos           IN OUT NOCOPY   co_carteraconc_qt,
      en_numtransaccion   IN              NUMBER
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_OBTIENECARGOS_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Obtiene Cargos de un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente"     Tipo="NUMBER">   Estructura de Concepto a Actualizar </param>
		<param nom="EV_tipcancelacion" Tipo="VARCHAR2"> Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"        Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	   Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<param nom="SE_cargos"     	   Tipo="TYPE">     Estructura de Cargos del Cliente. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
      gv_nomtabla           VARCHAR2 (10)                   := 'CO_CARTERA';
      gv_nomcolumna         VARCHAR2 (12)                   := 'COD_TIPDOCUM';
      tn_indfacturado       CO_CARTERA.ind_facturado%TYPE   := 1;
      tn_conceptocastigo    CO_CARTERA.cod_concepto%TYPE    := 6;
      tn_conceptoabono      CO_CARTERA.cod_concepto%TYPE    := 2;

      CURSOR cur_cargos (en_codcliente NUMBER)
      IS
         SELECT   co_cartera_qt (
			          en_codcliente,
	                  c.num_secuenci,
			          c.cod_tipdocum,
					  c.cod_vendedor_agente,
					  c.letra,
					  c.cod_centremi,
					  c.cod_concepto,
					  c.columna,
	                  c.cod_producto,
					  ROUND ( c.importe_debe, en_decimales ),
					  ROUND ( c.importe_haber, en_decimales ),
	                  c.NUM_ABONADO,
					  c.num_folio,
					  c.num_cuota,
					  c.sec_cuota,
	                  c.num_transaccion,
					  c.num_venta,
					  c.pref_plaza,
	                  c.cod_operadora_scl,
					  c.cod_plaza,
					  'N',
					  tc.cod_tipconce,
					  0.0
				  )
             FROM CO_CARTERA c, CO_CONCEPTOS co, CO_TIPCONCEP tc
            WHERE tc.cod_tipconce = co.cod_tipconce
              AND co.cod_concepto = c.cod_concepto
              AND c.cod_tipdocum NOT IN (
                     SELECT TO_NUMBER (cod.cod_valor)
                       FROM CO_CODIGOS cod
                      WHERE cod.nom_tabla = gv_nomtabla
                        AND cod.nom_columna = gv_nomcolumna)
              AND c.cod_concepto NOT IN
                                       (tn_conceptoabono, tn_conceptocastigo)
              AND c.ind_facturado = tn_indfacturado
              AND c.cod_cliente = en_codcliente
         ORDER BY c.fec_vencimie,
                  c.num_secuenci,
                  co.orden_can,
                  c.cod_producto,
                  c.NUM_ABONADO;

   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Error al Obtener Numero de Decimales. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

         SELECT   co_cartera_qt (
			          en_codcliente,
	                  c.num_secuenci,
			          c.cod_tipdocum,
					  c.cod_vendedor_agente,
					  c.letra,
					  c.cod_centremi,
					  c.cod_concepto,
					  c.columna,
	                  c.cod_producto,
					  c.importe_debe,
					  c.importe_haber,
	                  c.NUM_ABONADO,
					  c.num_folio,
					  c.num_cuota,
					  c.sec_cuota,
	                  c.num_transaccion,
					  c.num_venta,
					  c.pref_plaza,
	                  c.cod_operadora_scl,
					  c.cod_plaza,
					  'N',
					  tc.cod_tipconce,
					  0.0
				  )
		 BULK COLLECT INTO se_cargos
         FROM CO_CARTERA c, CO_CONCEPTOS co, CO_TIPCONCEP tc
            WHERE tc.cod_tipconce = co.cod_tipconce
              AND co.cod_concepto = c.cod_concepto
              AND c.cod_tipdocum NOT IN (
                     SELECT TO_NUMBER (cod.cod_valor)
                       FROM CO_CODIGOS cod
                      WHERE cod.nom_tabla = gv_nomtabla
                        AND cod.nom_columna = gv_nomcolumna)
              AND c.cod_concepto NOT IN
                                       (tn_conceptoabono, tn_conceptocastigo)
              AND c.ind_facturado = tn_indfacturado
              AND c.cod_cliente = en_codcliente
         ORDER BY c.fec_vencimie,
                  c.num_secuenci,
                  co.orden_can,
                  c.cod_producto,
                  c.NUM_ABONADO  ;


	  IF se_cargos IS NULL THEN
	      gn_numcargos := 0;
	  ELSE
	   	  gn_numcargos := se_cargos.COUNT;
	  END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   END co_obtienecargos_pr;

   PROCEDURE co_cancelaconcepto_pr (
      -- PasoCobrosCICLO
      en_estructuracargo   IN              co_cartera_qt,
      ed_feccancelacion    IN              DATE,
      en_numtransaccion    IN              NUMBER,
	  en_decimales         IN              NUMBER,
      sn_retorno           OUT NOCOPY      NUMBER,
      sv_glosa             OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACONCEPTO_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Registra como cancelado un concepto espec¡fico</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_estructuracargo" Tipo="NUMBER">   Estructura de Concepto a Actualizar </param>
		<param nom="ED_feccancelacion"  Tipo="DATE">     Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/

   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Error al Insertar en CO_CANCELADOS. Cliente : '
          || en_estructuracargo.cod_cliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

         BEGIN
            INSERT INTO CO_CANCELADOS
                        (cod_cliente, cod_tipdocum,
                         cod_centremi, num_secuenci,
                         cod_vendedor_agente, letra,
                         cod_concepto, columna, cod_producto,
                         importe_debe,
                         importe_haber,
                         ind_contado, ind_facturado,
                         fec_efectividad, fec_cancelacion,
                         ind_portador, fec_vencimie,
                         fec_caducida, fec_antiguedad,
                         fec_pago, NUM_ABONADO, num_folio,
                         num_folioctc, num_cuota, sec_cuota,
                         num_transaccion, num_venta,
                         pref_plaza, cod_operadora_scl,
                         cod_plaza
                        )
			         SELECT car.cod_cliente, car.cod_tipdocum, car.cod_centremi,
			                car.num_secuenci, car.cod_vendedor_agente, car.letra,
			                car.cod_concepto, car.columna, car.cod_producto,
			                ROUND( car.importe_debe, en_decimales),
							ROUND( car.importe_haber, en_decimales),
							car.ind_contado,
			                car.ind_facturado, car.fec_efectividad,
			                ed_feccancelacion AS fec_cancelacion, 0 AS ind_portador,
			                car.fec_vencimie, car.fec_caducida, car.fec_antiguedad,
			                SYSDATE AS fec_pago, car.NUM_ABONADO, car.num_folio,
			                car.num_folioctc, car.num_cuota, car.sec_cuota,
			                car.num_transaccion, car.num_venta, car.pref_plaza,
			                car.cod_operadora_scl, car.cod_plaza
			           FROM CO_CARTERA car
			          WHERE car.cod_cliente = en_estructuracargo.cod_cliente
			            AND car.cod_tipdocum = en_estructuracargo.cod_tipdocum
			            AND car.cod_centremi = en_estructuracargo.cod_centremi
			            AND car.num_secuenci = en_estructuracargo.num_secuenci
			            AND car.cod_vendedor_agente = en_estructuracargo.cod_vendedor_agente
			            AND car.letra = en_estructuracargo.letra
			            AND car.cod_producto = en_estructuracargo.cod_producto
			            AND car.NUM_ABONADO = en_estructuracargo.NUM_ABONADO
			            AND car.cod_concepto = en_estructuracargo.cod_concepto
			            AND car.columna = en_estructuracargo.columna;

         EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
               sn_retorno := 1;
               sv_glosa := sv_glosa || SQLERRM;
            WHEN OTHERS
            THEN
               sn_retorno := 1;
               sv_glosa := sv_glosa || SQLERRM;
         END;

		 IF sn_retorno = 0 THEN

	         BEGIN
	            sv_glosa :=
	                   'Error al Eliminar CO_CARTERA. Cliente : '
	                || en_estructuracargo.cod_cliente
	                || ', Fecha : '
	                || SYSDATE
	                || '. ';

	            DELETE      CO_CARTERA car
			          WHERE car.cod_cliente = en_estructuracargo.cod_cliente
			            AND car.cod_tipdocum = en_estructuracargo.cod_tipdocum
			            AND car.cod_centremi = en_estructuracargo.cod_centremi
			            AND car.num_secuenci = en_estructuracargo.num_secuenci
			            AND car.cod_vendedor_agente = en_estructuracargo.cod_vendedor_agente
			            AND car.letra = en_estructuracargo.letra
			            AND car.cod_producto = en_estructuracargo.cod_producto
			            AND car.NUM_ABONADO = en_estructuracargo.NUM_ABONADO
			            AND car.cod_concepto = en_estructuracargo.cod_concepto
			            AND car.columna = en_estructuracargo.columna;

	            sv_glosa := ' Exito al borrar co_cartera ';
	         EXCEPTION
	            WHEN NO_DATA_FOUND
	            THEN
	               sn_retorno := 1;
	               sv_glosa := sv_glosa || SQLERRM;
	            WHEN OTHERS
	            THEN
	               sn_retorno := 1;
	               sv_glosa := sv_glosa || SQLERRM;
	         END;
		 END IF;

   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   -- PasoCobrosCICLO
   END co_cancelaconcepto_pr;

   PROCEDURE co_registrarelconcep_pr (
   -- PasoCobrosCICLO
      en_estructuraabono   IN              co_cartera_qt,
      en_estructuracargo   IN              co_cartera_qt,
      en_numtransaccion    IN              NUMBER,
	  en_decimales         IN              NUMBER,
      sn_retorno           OUT NOCOPY      NUMBER,
      sv_glosa             OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_REGISTRARELCONCEP_PR" Lenguaje="PL/SQL" Fecha="13-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Registra la Relacion del concepto de Abono con el concepto de Cargo en tabla CO_PAGOSCONC</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_estructuraabono" Tipo="TYPE"> Estructura del Abono </param>
		<param nom="EN_estructuracargo" Tipo="TYPE"> Estructura del Cargo </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">   Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2"> Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Error al registrar la relacion del concepto. Cliente : '
          || en_estructuraabono.cod_cliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      INSERT INTO CO_PAGOSCONC
                  (cod_tipdocum,
                   cod_centremi,
                   num_secuenci,
                   cod_vendedor_agente,
                   letra,
                   imp_concepto,
                   cod_producto,
                   cod_tipdocrel,
                   cod_centrrel,
                   num_securel,
                   cod_agenterel,
                   letra_rel, cod_concepto,
                   columna,
                   NUM_ABONADO,
                   num_folio,
                   num_cuota,
                   sec_cuota,
                   num_transaccion,
                   num_venta,
                   pref_plaza,
                   cod_operadora_scl,
                   cod_plaza
                  )
           VALUES (en_estructuraabono.cod_tipdocum,
                   en_estructuraabono.cod_centremi,
                   en_estructuraabono.num_secuenci,
                   en_estructuraabono.cod_vendedor_agente,
                   en_estructuraabono.letra,
                   ROUND ( en_estructuracargo.mto_pagado, en_decimales),
                   en_estructuracargo.cod_producto,
                   en_estructuracargo.cod_tipdocum,
                   en_estructuracargo.cod_centremi,
                   en_estructuracargo.num_secuenci,
                   en_estructuracargo.cod_vendedor_agente,
                   en_estructuracargo.letra, en_estructuracargo.cod_concepto,
                   en_estructuracargo.columna,
                   en_estructuracargo.NUM_ABONADO,
                   en_estructuracargo.num_folio,
                   en_estructuracargo.num_cuota,
                   en_estructuracargo.sec_cuota,
                   en_estructuracargo.num_transaccion,
                   en_estructuracargo.num_venta,
                   en_estructuracargo.pref_plaza,
                   en_estructuracargo.cod_operadora_scl,
                   en_estructuracargo.cod_plaza
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   -- PasoCobrosCICLO
   END co_registrarelconcep_pr;

   PROCEDURE co_cancelacartera_pr (
   -- PasoCobrosCICLO
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
	  en_decimales          IN              NUMBER,
      en_indcarrier         IN OUT NOCOPY   NUMBER,
      en_estructuraabonos   IN              co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN              co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN              VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACARTERA_PR" Lenguaje="PL/SQL" Fecha="14-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Cancela los cargos de un Cliente con los abonos existentes en su Cta. Cte.</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente" 		 Tipo="NUMBER">   Codigo del Cliente </param>
		<param nom="ED_feccancelacion"   Tipo="DATE">     Fecha de Cancelacion </param>
		<param nom="EN_numtransaccion"   Tipo="NUMBER">   Numero de Transaccion para errores </param>
		<param nom="EN_estructuraabonos" Tipo="TYPE">     Estructura de Abonos a Cancelar (Opcional) </param>
		<param nom="EN_estructuracargos" Tipo="TYPE">     Estructura de Cargos a Cancelar (Opcional) </param>
		<param nom="EV_tipcancelacion"   Tipo="VARCHAR2"> Tipo de Cancelaci¢n (Opcional, se usar  para no cancelar cargos con castigo) </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">    Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2">  Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
      ln_estructuraabonos   co_carteraconc_qt         := co_carteraconc_qt ();
      ln_estructuracargos   co_carteraconc_qt         := co_carteraconc_qt ();
      tn_montocredito       CO_CARTERA.importe_debe%TYPE;
      tn_montocargo         CO_CARTERA.importe_debe%TYPE;
      tn_totalcredito       CO_CARTERA.importe_haber%TYPE;
      tn_montoimporte       CO_CARTERA.importe_debe%TYPE;
      tn_sumadeuda          CO_CARTERA.importe_debe%TYPE;
      lb_sort               BOOLEAN                         := FALSE;
      sn_totabono           CO_CARTERA.importe_debe%TYPE;
      sn_resto              CO_CARTERA.importe_debe%TYPE;
      sn_ultreg             NUMBER (6);
      sn_sumadeuda          CO_CARTERA.importe_debe%TYPE;
   BEGIN
      sn_retorno := 0;
      --gb_salir := TRUE;
      sv_glosa :=
             'Error al Obtener Numero de Decimales. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      IF en_estructuraabonos IS NULL
      THEN
         sv_glosa :=
                'Error en llamada a Procedimiento CO_OBTIENEABONOS_PR. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_obtieneabonos_pr (en_codcliente,
							  en_decimales,
                              sn_retorno,
                              sv_glosa,
                              ln_estructuraabonos,
                              en_numtransaccion
                             );

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;
      ELSE
         sv_glosa :=
                'Error en Traspaso de Estructura Abonos. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         ln_estructuraabonos := en_estructuraabonos;
         gn_numabonos := en_estructuraabonos.COUNT;
      END IF;

      IF en_estructuracargos IS NULL
      THEN
         sv_glosa :=
                'Error en llamada a Procedimiento CO_OBTIENECARGOS_PR. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_obtienecargos_pr (en_codcliente,
		                      en_decimales,
                              sn_retorno,
                              ev_tipcancelacion,
                              sv_glosa,
                              ln_estructuracargos,
                              en_numtransaccion
                             );

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;

         lb_sort := TRUE; -- DATOS VIENEN ORDENADOS
      ELSE
         sv_glosa :=
                'Error en Traspaso de Estructura Cargos. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         ln_estructuracargos := en_estructuracargos;
         gn_numcargos := en_estructuracargos.COUNT;
         lb_sort := FALSE; -- DATOS VIENEN EXTERNOS AL PROGRAMA
      END IF;

      sv_glosa :=
             'Inicio de Cursor de Abonos. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

/* 1 - TOTALIZAR ABONOS */

      co_sumaabonos_pr ( ln_estructuraabonos, sn_totabono, sn_retorno, sv_glosa);

      IF sn_retorno <> 0
      THEN
         RAISE error_exception;
      END IF;

      IF gn_numabonos = 0
      THEN
         sn_retorno := 0; -- proceso termina con exito, sin avisar, para no provocar problemas a otros procesos
         RETURN;
      END IF;

/*  2 - SOLO SI EL CARGO VIENE POR PARAMETRO, SE UTILIZAR METODO BURBUJA  */
      IF NOT lb_sort
      THEN
         co_ordenacargos_pr (ln_estructuracargos,
                             en_numtransaccion,
                             sn_retorno,
                             sv_glosa
                            );

         IF sn_retorno <> 0
         THEN
            RETURN;
         END IF;
      END IF;

      IF gn_numcargos = 0
      THEN
         sn_retorno := 0; -- proceso termina con exito, sin avisar, para no provocar problemas a otros procesos
         RETURN;
      END IF;

/* 3 - GENERAR TOTAL X DOCUMENTO  */
      co_generatotalcargos_pr (ln_estructuracargos,
                               en_numtransaccion,
                               sn_retorno,
                               sv_glosa
                              );

      IF sn_retorno <> 0
      THEN
         sv_glosa := sv_glosa || SQLERRM;
         RAISE error_exception;
      END IF;

/* 4 - VERIFICO SI CANCELO 100 % O PARCIAL EL DOCUMENTO  */
      gn_j := gv_totdocumento.COUNT;

      FOR gn_i IN 1 .. gn_j
      LOOP --Loop Totales por documento
         IF sn_totabono >= gv_totdocumento (gn_i).monto
         THEN

            co_cancela_total_pr (ln_estructuracargos,
                                 ln_estructuraabonos,
                                 gv_totdocumento (gn_i).num_secuenci,
                                 en_codcliente,
                                 ed_feccancelacion,
                                 en_numtransaccion,
								 en_decimales,
                                 sn_retorno,
                                 sv_glosa
                                );

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;

            sn_totabono := sn_totabono - gv_totdocumento (gn_i).monto;
         ELSE
            co_cancela_parcial_100_pr (ln_estructuracargos,
                                       ln_estructuraabonos,
                                       gv_totdocumento (gn_i).num_secuenci,
                                       en_codcliente,
                                       ed_feccancelacion,
                                       en_numtransaccion,
									   en_decimales,
                                       sn_ultreg,
                                       sn_sumadeuda,
                                       sn_resto,
                                       sn_retorno,
                                       sv_glosa
                                      );

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;

            IF sn_sumadeuda > 0 AND sn_resto > 0
            THEN
               co_cancela_parcial_resto_pr (ln_estructuracargos,
                                            ln_estructuraabonos,
                                            gv_totdocumento (gn_i).num_secuenci,
                                            en_codcliente,
                                            ed_feccancelacion,
                                            en_numtransaccion,
                                            sn_ultreg,
                                            sn_sumadeuda,
                                            sn_resto,
											en_decimales,
                                            sn_retorno,
                                            sv_glosa
                                           );

               IF sn_retorno <> 0
               THEN
                  RAISE error_exception;
               END IF;
            END IF;

            sn_totabono := 0;
         END IF;
      END LOOP;
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
         ROLLBACK;
         co_insertar_errores_pr (en_numtransaccion, sn_retorno, sv_glosa);
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
         ROLLBACK;
         co_insertar_errores_pr (en_numtransaccion, sn_retorno, sv_glosa);
   -- PasoCobrosCICLO
   END co_cancelacartera_pr;

   PROCEDURE co_cancelacarrier_pr (
   -- PasoCobrosCICLO (revisar)
      en_codcliente       IN              NUMBER,
      en_numtransaccion   IN              NUMBER,
	  en_decimales        IN             NUMBER,
      ev_tipcancelacion   IN              VARCHAR2 DEFAULT NULL,
      sn_retorno          OUT NOCOPY      NUMBER,
      sv_glosa            OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACARRIER_PR" Lenguaje="PL/SQL" Fecha="14-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Cancela los conceptos Carrier que tenga un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente" 		 Tipo="NUMBER">   Codigo del Cliente </param>
		<param nom="ED_feccancelacion"   Tipo="DATE">     Fecha de Cancelacion </param>
		<param nom="EN_numtransaccion"   Tipo="NUMBER">   Numero de Transaccion para errores </param>
		<param nom="EV_tipcancelacion"   Tipo="VARCHAR2"> Tipo de Cancelaci¢n (Opcional, se usar  para no cancelar cargos con castigo) </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">    Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2">  Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
      gv_nomtabla             VARCHAR2 (10)                   := 'CO_CARTERA';
      gv_nomcolumna           VARCHAR2 (12)                 := 'COD_TIPDOCUM';

      CURSOR c_cursor_carrier (en_codcliente IN NUMBER)
      IS
         SELECT   a.num_secuenci, a.cod_tipdocum, a.cod_vendedor_agente,
                  a.letra, a.cod_centremi, a.cod_concepto, a.cod_producto,
                  a.columna, a.importe_debe, a.importe_haber, a.NUM_ABONADO,
                  a.num_folio, a.num_cuota, a.sec_cuota, a.num_transaccion,
                  a.num_venta, a.pref_plaza, a.cod_operadora_scl,
                  a.cod_plaza, b.cod_tipconce
             FROM CO_CARTERA a, CO_CONCEPTOS b, CO_DATGEN c
            WHERE c.tip_concepcarrier = b.cod_tipconce
              AND b.cod_concepto = a.cod_concepto
              AND a.cod_cliente = en_codcliente
              AND a.ind_facturado = 1
              AND a.cod_tipdocum NOT IN (
                     SELECT TO_NUMBER (c.cod_valor)
                       FROM CO_CODIGOS c
                      WHERE c.nom_tabla = gv_nomtabla
                        AND c.nom_columna = gv_nomcolumna)
         ORDER BY a.fec_vencimie, b.orden_can, a.cod_producto, a.NUM_ABONADO;

      tn_importecarrier       CO_CARTERA.importe_debe%TYPE;
      tn_importeabonos        CO_CARTERA.importe_debe%TYPE;
      tn_indabono             CO_TIPCONCEP.ind_abono%TYPE     := 1;
      tn_indfacturado         CO_CARTERA.ind_facturado%TYPE   := 1;
      gn_indcarrier           NUMBER (1)                      := 1;
      ln_estructuracarrier    co_cartera_qt;
      ln_estructuratraspaso   co_carteraconc_qt        := co_carteraconc_qt ();
   BEGIN
      sn_retorno := 0;
      sv_glosa :=
             'Inicio de Cursor de Conceptos Carrier. Cliente : '
          || en_codcliente
          || ', Fecha : '
          || SYSDATE
          || '. ';

      FOR rreg IN c_cursor_carrier (en_codcliente)
      LOOP
         tn_importecarrier := rreg.importe_debe - rreg.importe_haber;

         IF tn_importecarrier <= 0
         THEN
            --Error
            sn_retorno := 1;
            sv_glosa :=
                   'Error, Monto de Concepto Carrier Menor a Cero. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            RAISE error_exception;
         END IF;

         sv_glosa :=
                'Obtiene Importe de los Conceptos. Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';

         SELECT SUM (c.importe_haber - c.importe_debe)
           INTO tn_importeabonos
           FROM CO_CARTERA c, CO_CONCEPTOS co, CO_TIPCONCEP tc
          WHERE tc.cod_tipconce = co.cod_concepto
            AND co.cod_concepto = c.cod_concepto
            AND tc.ind_abono = tn_indabono
            AND c.cod_tipdocum NOT IN (
                   SELECT TO_NUMBER (cod.cod_valor)
                     FROM CO_CODIGOS cod
                    WHERE cod.nom_tabla = gv_nomtabla
                      AND cod.nom_columna = gv_nomcolumna)
            AND c.ind_facturado = tn_indfacturado
            AND c.cod_cliente = en_codcliente;

         IF tn_importeabonos >= tn_importecarrier
         THEN
            sv_glosa :=
                   'Inicializa estructura de Cargos Carrier. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            ln_estructuracarrier :=
               co_cartera_qt (0,
                              0,
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              '',
                              0,
                              0
                             );
            sv_glosa :=
                   'Llena Estructura de Cargos Carrier. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            ln_estructuracarrier.cod_cliente := en_codcliente;
            ln_estructuracarrier.num_secuenci := rreg.num_secuenci;
            ln_estructuracarrier.cod_tipdocum := rreg.cod_tipdocum;
            ln_estructuracarrier.cod_vendedor_agente :=
                                                      rreg.cod_vendedor_agente;
            ln_estructuracarrier.letra := rreg.letra;
            ln_estructuracarrier.cod_centremi := rreg.cod_centremi;
            ln_estructuracarrier.cod_concepto := rreg.cod_concepto;
            ln_estructuracarrier.columna := rreg.columna;
            ln_estructuracarrier.cod_producto := rreg.cod_producto;
            ln_estructuracarrier.importe_debe := rreg.importe_debe;
            ln_estructuracarrier.importe_haber := rreg.importe_haber;
            ln_estructuracarrier.NUM_ABONADO := rreg.NUM_ABONADO;
            ln_estructuracarrier.num_folio := rreg.num_folio;
            ln_estructuracarrier.num_cuota := rreg.num_cuota;
            ln_estructuracarrier.sec_cuota := rreg.sec_cuota;
            ln_estructuracarrier.num_transaccion := rreg.num_transaccion;
            ln_estructuracarrier.num_venta := rreg.num_venta;
            ln_estructuracarrier.pref_plaza := rreg.pref_plaza;
            ln_estructuracarrier.cod_operadora_scl := rreg.cod_operadora_scl;
            ln_estructuracarrier.cod_plaza := rreg.cod_plaza;
            ln_estructuracarrier.cod_tipconce := rreg.cod_tipconce;
            ln_estructuracarrier.ind_cancelado := 'N';
            ln_estructuratraspaso.EXTEND;
            ln_estructuratraspaso (1) := ln_estructuracarrier;
            sv_glosa :=
                   'Error en llamada a Procedimiento CO_CANCELACREDITOS_PR. Cliente : '
                || en_codcliente
                || ', Fecha : '
                || SYSDATE
                || '. ';
            co_cancelacartera_pr (en_codcliente,
                                  SYSDATE,
                                  en_numtransaccion,
								  en_decimales,
                                  gn_indcarrier,
                                  NULL,
                                  ln_estructuratraspaso,
                                  ev_tipcancelacion,
                                  sn_retorno,
                                  sv_glosa
                                 );

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;
         END IF;
      END LOOP;
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1; --  co_cancelacartera ya realizo grabado en tabla de errores
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
         ROLLBACK;
         co_insertar_errores_pr (en_numtransaccion, sn_retorno, sv_glosa);
   -- PasocobrosCICLO
   END co_cancelacarrier_pr;

   PROCEDURE co_cancelacreditos_pr (
      -- PasoCobrosCiclo
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
	  en_decimales          IN              NUMBER,
      en_indcarrier         IN OUT NOCOPY   NUMBER,
      en_estructuraabonos   IN              co_carteraconc_qt DEFAULT NULL,
      en_estructuracargos   IN              co_carteraconc_qt DEFAULT NULL,
      ev_tipcancelacion     IN              VARCHAR2 DEFAULT NULL,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<Documentaci¢n TipoDoc = "Procedimiento">
		<Elemento Nombre = "CO_CANCELACARRIER_PR" Lenguaje="PL/SQL" Fecha="14-12-2004" Versi¢n="1.0.1" Dise¤ador="NN" Programador="Hilda Quezada" Ambiente="BD NN">
		<Retorno>NA</Retorno>
		<Descripci¢n>Cancela los conceptos Carrier que tenga un Cliente</Descripci¢n>
		<Par metros>
		<Entrada>
		<param nom="EN_codcliente" 		 Tipo="NUMBER">   Codigo del Cliente </param>
		<param nom="ED_feccancelacion"   Tipo="DATE">     Fecha de Cancelacion </param>
		<param nom="EN_numtransaccion"   Tipo="NUMBER">   Numero de Transaccion para errores </param>
		<param nom="EN_indcarrier"       Tipo="NUMBER">   Indicador de Cancelar solo conceptos carrier 1=Si , 0=No </param>
		<param nom="EN_estructuraabonos" Tipo="TYPE">     Estructura de Abonos a Cancelar (Opcional) </param>
		<param nom="EN_estructuracargos" Tipo="TYPE">     Estructura de Cargos a Cancelar (Opcional) </param>
		<param nom="EV_tipcancelacion"   Tipo="VARCHAR2"> Tipo de Cancelaci¢n (Opcional, se usar  para no cancelar cargos con castigo) </param>
		<Entrada>
		<Salida>
		<param nom="SN_retorno"         Tipo="NUMBER">    Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </param>
		<param nom="SV_glosa"     	    Tipo="VARCHAR2">  Descripcion del Error ocurrido. </param>
		<Salida>
		</Par metros>
		</Elemento>
		</Documentaci¢n>
		*/
   BEGIN
      sn_retorno := 0;
	  sv_glosa   := 'OK';

   	  /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
      /*                   Desc   :  Inicializacion de fecha de cancelacion y numero de transaccion */
	  --gd_feccancelacion := ed_feccancelacion;
      --gn_numtransaccion := en_numtransaccion;
      /* XO-200509070609 Fin   */

      IF en_indcarrier = 0
      THEN
         co_cancelacartera_pr (en_codcliente,
                               ed_feccancelacion,
                               en_numtransaccion,
							   en_decimales,
                               en_indcarrier,
                               en_estructuraabonos,
                               en_estructuracargos,
                               ev_tipcancelacion,
                               sn_retorno,
                               sv_glosa
                              );
      END IF;

      IF en_indcarrier = 1 AND sn_retorno = 0
      THEN
         co_cancelacarrier_pr (en_codcliente,
                               en_numtransaccion,
							   en_decimales,
                               ev_tipcancelacion,
                               sn_retorno,
                               sv_glosa
                              );
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   -- PasoCobrosCiclo
   END co_cancelacreditos_pr;

   PROCEDURE co_cancela_total_pr (
    -- PasoCobrosCICLO
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
	  en_decimales          IN NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : CO_CANCELA_TOTAL</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Realiza pago total del documento indicado</DESCRIPCION>
		<FECHAMOD >  : "30-05-2006" </FECHAMOD >
		<MODIFICACION> : "Incidencia RA-200603160921"  </MODIFICACION>
		<VERSION MOD>  : "1.1" </VERSION MOD>
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuracargos: Estructura de Cargos a Cancelar </ParamEntr>
		<ParamEntr>  : EN_estructuraabonos: Estructura de Abonos a Aplicar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_CLIENTE: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : ED_FECCANCELACION: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : en_numtransaccion: Numero de Transaccion </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      ln_pago              CO_CARTERA.importe_debe%TYPE   := 0;
      ln_deuda             CO_CARTERA.importe_debe%TYPE   := 0;
      tn_conceptocastigo   CO_CARTERA.cod_concepto%TYPE   := 6;
   BEGIN
      sn_retorno := 0;

      FOR gn_i IN 1 .. gn_numabonos
      LOOP -- Loop conceptos para recorrer Abonos
         IF en_estructuraabonos (gn_i).ind_cancelado != 'S'
         THEN -- ANALIZO SOLO SI NO FUE CANCELADO
            ln_pago :=
                  en_estructuraabonos (gn_i).importe_haber
                - en_estructuraabonos (gn_i).importe_debe;

            FOR gn_j IN 1 .. gn_numcargos
            LOOP -- Loop conceptos para recorrer Cargos
			  IF ln_pago = 0 THEN EXIT; END IF;	/* CAGV 30-05-2006 RA-200603160921 */
               IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                  AND en_estructuracargos (gn_j).num_secuenci = en_num_secuenci
               THEN
                  ln_deuda :=
                        en_estructuracargos (gn_j).importe_debe
                      - en_estructuracargos (gn_j).importe_haber;

                  IF ln_pago > ln_deuda
                  THEN -- El abono es mayor a la deuda
                     en_estructuracargos (gn_j).ind_cancelado := 'S'; --marcar cargo cancelado
                     ln_pago := ln_pago - ln_deuda;
					 /* CAGV 30-05-2006 RA-200603160921 */
                     /*en_estructuracargos (gn_j).mto_pagado :=
                              en_estructuracargos (gn_j).mto_pagado
                              + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
					 en_estructuracargos (gn_j).mto_pagado :=	ln_deuda;	/* CAGV 30-05-2006 RA-200603160921 */
                     en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
                     en_estructuraabonos (gn_i).importe_debe :=
                            en_estructuraabonos (gn_i).importe_debe
                            + ln_deuda;
                     sv_glosa := 'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                         || SYSDATE
                         || '. ';
                     co_actualizacartera_pr (en_estructuracargos (gn_j),
                                             en_numtransaccion,
                                             en_decimales,
											 ed_feccancelacion,
											 sn_retorno,
                                             sv_glosa
                                            ); --Actualiza Cartera (cargo)

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;

                     sv_glosa :=
                            'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (1). Fecha : '
                         || SYSDATE
                         || '. ';
                     co_cancelaconcepto_pr (en_estructuracargos (gn_j),
                                            ed_feccancelacion,
                                            en_numtransaccion,
											en_decimales,
                                            sn_retorno,
                                            sv_glosa
                                           ); --Cancela concepto (cargo)

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;
                  ELSE
                     IF ln_pago = ln_deuda
                     THEN -- El abono es igual a la deuda
                        en_estructuracargos (gn_j).ind_cancelado := 'S'; --marcar cargo cancelado
                        en_estructuraabonos (gn_i).ind_cancelado := 'S'; --marcar abono cancelado
                        ln_pago := 0;
						/* CAGV 30-05-2006 RA-200603160921 */
                        /*en_estructuracargos (gn_j).mto_pagado :=
                              en_estructuracargos (gn_j).mto_pagado
                              + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
						en_estructuracargos (gn_j).mto_pagado := ln_deuda;	  /* CAGV 30-05-2006 RA-200603160921 */
                        en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
                        en_estructuraabonos (gn_i).importe_debe :=
                                     en_estructuraabonos (gn_i).importe_haber; -- haber = debe
                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuracargos (gn_j),
                                                en_numtransaccion,
												en_decimales,
												ed_feccancelacion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (1). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_cancelaconcepto_pr (en_estructuracargos (gn_j),
                                               ed_feccancelacion,
                                               en_numtransaccion,
											   en_decimales,
                                               sn_retorno,
                                               sv_glosa
                                              ); --Cancela concepto (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (2). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                                en_numtransaccion,
												en_decimales,
												ed_feccancelacion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (2). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                               ed_feccancelacion,
                                               en_numtransaccion,
											   en_decimales,
                                               sn_retorno,
                                               sv_glosa
                                              ); --Cancela concepto (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;
                     ELSE -- El abono es menor a la deuda
 					    /* CAGV 30-05-2006 RA-200603160921 */
                        /*en_estructuracargos (gn_j).mto_pagado :=
                               en_estructuracargos (gn_j).mto_pagado
                               + ln_pago; --- se incrementa el pago con el saldo restante */
						en_estructuracargos (gn_j).mto_pagado := ln_pago;	   /* CAGV 30-05-2006 RA-200603160921 */
                        en_estructuraabonos (gn_i).ind_cancelado := 'S'; --marcar abono cancelado
                        en_estructuraabonos (gn_i).importe_debe :=
                                     en_estructuraabonos (gn_i).importe_haber; -- haber = debe
                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                                en_numtransaccion,
												en_decimales,
												ed_feccancelacion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (3). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                               ed_feccancelacion,
                                               en_numtransaccion,
											   en_decimales,
                                               sn_retorno,
                                               sv_glosa
                                              ); --Cancela concepto (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;

                        en_estructuracargos (gn_j).importe_haber :=
                             en_estructuracargos (gn_j).importe_haber
                             + ln_pago;
                        ln_pago := 0;
                        sv_glosa :=
                               'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                            || SYSDATE
                            || '. ';
                        co_actualizacartera_pr (en_estructuracargos (gn_j),
                                                en_numtransaccion,
												en_decimales,
												ed_feccancelacion,
                                                sn_retorno,
                                                sv_glosa
                                               ); --Actualiza Cartera (cargo)

                        IF sn_retorno <> 0
                        THEN
                           RAISE error_exception;
                        END IF;
                     END IF;
                  END IF;

                  sv_glosa :=
                         'Error en llamada a Procedimiento CO_REGISTRARELCONCEP_PR. Fecha: '
                      || SYSDATE
                      || '. ';
                  co_registrarelconcep_pr (en_estructuraabonos (gn_i),
                                           en_estructuracargos (gn_j),
                                           en_numtransaccion,
										   en_decimales,
                                           sn_retorno,
                                           sv_glosa
                                          ); --Registra relacion conceptos saldados

                  IF sn_retorno <> 0
                  THEN
                     RAISE error_exception;
                  END IF;

                  IF en_estructuracargos (gn_j).cod_tipconce =
                                                            tn_conceptocastigo
                  THEN
                     --Actualiza Castigo (cargo)
                     sv_glosa :=
                            'Error en llamada a Procedimiento CO_CASTIGOS_EXTERNOS. Fecha : '
                         || SYSDATE
                         || '. '
                         || ' Fol :'
                         || en_estructuracargos (gn_j).num_folio
                         || ' Pla :'
                         || en_estructuracargos (gn_j).pref_plaza
                         || ' Fec :'
                         || TO_CHAR (ed_feccancelacion,
                                     'DD-MM-YYYY HH24:MI:SS'
                                    )
                         || ' Pag :'
                         || en_estructuraabonos (gn_i).mto_pagado
                         || ' xxx :'
                         || '1'
                         || ' Cuo :'
                         || en_estructuracargos (gn_j).sec_cuota
                         || ' Ret :'
                         || sn_retorno;
                     co_castigos_externos (en_codcliente,
                                           en_estructuracargos (gn_j).num_folio,
                                           en_estructuracargos (gn_j).pref_plaza,
                                           TO_CHAR (ed_feccancelacion,
                                                    'DD-MM-YYYY HH24:MI:SS'
                                                   ),
                                           en_estructuraabonos (gn_i).mto_pagado,
                                           1,
                                           en_estructuracargos (gn_j).sec_cuota,
                                           sn_retorno
                                          );

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;
                  END IF;
               END IF;
			 /* END IF;  --Cierre if abono > 0  /* CAGV 30-05-2006 RA-200603160921 */
            END LOOP; -- fin cargos
         END IF;

         IF en_estructuraabonos (gn_i).ind_cancelado !=
                                                 'S' -- quedo saldo sin aplicar
         THEN
            co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                    en_numtransaccion,
									en_decimales,
									ed_feccancelacion,
                                    sn_retorno,
                                    sv_glosa
                                   ); --Actualiza Saldo Abono no aplicado

            IF sn_retorno <> 0
            THEN
               RAISE error_exception;
            END IF;
         END IF;
      END LOOP; -- fin abonos
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
    -- PasoCobrosCICLO
   END co_cancela_total_pr;

   PROCEDURE co_cancela_parcial_100_pr (
   -- PasoCobrosCICLO
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
	  en_decimales          IN              NUMBER,
      sn_ultreg             OUT NOCOPY      NUMBER,
      sn_sumadeuda          OUT NOCOPY      NUMBER,
      sn_resto              OUT NOCOPY      NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : co_cancela_parcial_100_pr</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Realiza pago total del documento indicado</DESCRIPCION>
		<FECHAMOD >  : "30-05-2006" </FECHAMOD >
		<MODIFICACION> : "Incidencia RA-200603160921"  </MODIFICACION>
		<VERSION MOD>  : "1.1" </VERSION MOD>
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuracargos: Estructura de Cargos a Cancelar </ParamEntr>
		<ParamEntr>  : EN_estructuraabonos: Estructura de Abonos a Aplicar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_CLIENTE: Documento de Cargo a Cancelar </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      ln_pago              CO_CARTERA.importe_debe%TYPE       := 0;
      ln_deuda             CO_CARTERA.importe_debe%TYPE       := 0;
      ln_indporcentaje     CO_CONCEPTOS.ind_porcentaje%TYPE   := 0;
      tn_conceptocastigo   CO_CARTERA.cod_concepto%TYPE       := 6;
   BEGIN
      sn_retorno := 0;
      sn_ultreg := 0;
      sn_sumadeuda := 0;
      sn_resto := 0;

      FOR gn_i IN 1 .. gn_numabonos
      LOOP -- Loop conceptos para recorrer Abonos
         IF en_estructuraabonos (gn_i).ind_cancelado != 'S'
         THEN -- ANALIZO SOLO SI NO FUE CANCELADO
            ln_pago :=
                  en_estructuraabonos (gn_i).importe_haber
                - en_estructuraabonos (gn_i).importe_debe;

            IF ln_pago > 0
            THEN
               FOR gn_j IN 1 .. gn_numcargos
               LOOP -- Loop conceptos para recorrer Cargos
	            IF ln_pago = 0 THEN	EXIT; END IF; /* CAGV 30-05-2006 RA-200603160921 */
                  IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                     AND en_estructuracargos (gn_j).num_secuenci =
                                                               en_num_secuenci
                  THEN
                     ln_deuda :=
                           en_estructuracargos (gn_j).importe_debe
                         - en_estructuracargos (gn_j).importe_haber;

                     IF ln_deuda > 0
                     THEN
                        ln_indporcentaje := 0;

                        BEGIN
                           SELECT ind_porcentaje
                             INTO ln_indporcentaje
                             FROM CO_CONCEPTOS
                            WHERE cod_concepto = en_estructuracargos (gn_j).cod_concepto;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              sv_glosa := 'No existe concepto. Fecha : '
                                  || SYSDATE
                                  || '. ';
                              RAISE error_exception;
                           WHEN OTHERS
                           THEN
                              sv_glosa :=
                                     'No existe concepto. Fecha : '
                                  || SYSDATE
                                  || '. ';
                              RAISE error_exception;
                        END;

                        IF ln_indporcentaje = 0
                        THEN -- NO APLICA
                           IF ln_pago > ln_deuda
                           THEN
                              -- El abono es mayor a la deuda
                              en_estructuracargos (gn_j).ind_cancelado := 'S'; --marcar cargo cancelado
                              en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
							  /* CAGV 30-05-2006 RA-200603160921 */
                              /*en_estructuracargos (gn_j).mto_pagado :=
                                    en_estructuracargos (gn_j).mto_pagado
                                  + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
							  en_estructuracargos (gn_j).mto_pagado := ln_deuda;    /* CAGV 30-05-2006 RA-200603160921*/
                              sv_glosa := 'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (1). Fecha : '
                                  || SYSDATE
                                  || '. ';
                              co_actualizacartera_pr (en_estructuracargos (gn_j),
                                                      en_numtransaccion,
													  en_decimales,
													  ed_feccancelacion,
                                                      sn_retorno,
                                                      sv_glosa
                                                     ); --Actualiza Cartera (cargo)

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;

                              sv_glosa :=
                                     'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (1). Fecha : '
                                  || SYSDATE
                                  || '. ';

                              co_cancelaconcepto_pr (en_estructuracargos (gn_j),
                                                     ed_feccancelacion,
                                                     en_numtransaccion,
													 en_decimales,
                                                     sn_retorno,
                                                     sv_glosa
                                                    ); --Cancela concepto (cargo)

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;

                              ln_pago := ln_pago - ln_deuda; -- rebajo la deuda al pago

                                                             ---  actualizo pago en abono
                              en_estructuraabonos (gn_i).importe_debe :=
                                    en_estructuraabonos (gn_i).importe_debe + ln_deuda;
                              sv_glosa :=
                                     'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Fecha : '
                                  || SYSDATE
                                  || '. ';
                              co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                                      en_numtransaccion,
													  en_decimales,
													  ed_feccancelacion,
                                                      sn_retorno,
                                                      sv_glosa
                                                     ); --Actualiza Cartera (cargo)

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;
---
                           ELSE
                              IF ln_pago = ln_deuda
                              THEN -- El abono es igual a la deuda
                                 en_estructuracargos (gn_j).ind_cancelado :=
                                                                          'S'; --marcar cargo cancelado
                                 en_estructuracargos (gn_j).importe_haber :=
                                      en_estructuracargos (gn_j).importe_debe; -- haber = debe
							     /* CAGV 30-05-2006 RA-200603160921*/
                                 /*en_estructuracargos (gn_j).mto_pagado :=
                                       en_estructuracargos (gn_j).mto_pagado
                                     + ln_deuda; --- se incrementa el pago solo en la deuda, no el pago total*/
								 en_estructuracargos (gn_j).mto_pagado := ln_deuda;	 /* CAGV 30-05-2006 RA-200603160921 */
                                 en_estructuraabonos (gn_i).importe_debe :=
                                      en_estructuracargos (gn_i).importe_haber; -- haber = debe
                                 en_estructuraabonos (gn_i).ind_cancelado :=
                                                                           'S'; --marcar abono cancelado
                                 ln_pago := 0; -- saldo el pago
                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (2). Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuracargos (gn_j),
                                                         en_numtransaccion,
														 en_decimales,
														 ed_feccancelacion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (cargo). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_cancelaconcepto_pr (en_estructuracargos (gn_j),
                                                        ed_feccancelacion,
                                                        en_numtransaccion,
														en_decimales,
                                                        sn_retorno,
                                                        sv_glosa
                                                       ); --Cancela concepto (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (2). Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                                         en_numtransaccion,
														 en_decimales,
														 ed_feccancelacion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (abono). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                                        ed_feccancelacion,
                                                        en_numtransaccion,
														en_decimales,
                                                        sn_retorno,
                                                        sv_glosa
                                                       ); --Cancela concepto (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;
                              ELSE -- El abono es menor a la deuda
							     /* CAGV 30-05-2006 RA-200603160921*/
                                 /*en_estructuracargos (gn_j).mto_pagado :=
                                       en_estructuracargos (gn_j).mto_pagado
                                     + ln_pago; --- se incrementa el pago con el saldo restante*/
								 en_estructuracargos (gn_j).mto_pagado := ln_pago; 	/* CAGV 30-05-2006 RA-200603160921*/
                                 en_estructuracargos (gn_j).importe_haber :=
                                       en_estructuracargos (gn_j).importe_haber
                                     + ln_pago;
                                 en_estructuraabonos (gn_i).ind_cancelado :=
                                                                           'S'; --marcar abono cancelado
                                 en_estructuraabonos (gn_i).importe_debe :=
                                      en_estructuraabonos (gn_i).importe_haber; -- haber = debe
                                 ln_pago := 0; -- saldo a cancelar queda en 0
                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                                         en_numtransaccion,
														 en_decimales,
														 ed_feccancelacion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (2). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                                        ed_feccancelacion,
                                                        en_numtransaccion,
														en_decimales,
                                                        sn_retorno,
                                                        sv_glosa
                                                       ); --Cancela concepto (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;

                                 sv_glosa :=
                                        'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Cliente : '
                                     || en_codcliente
                                     || ', Fecha : '
                                     || SYSDATE
                                     || '. ';
                                 co_actualizacartera_pr (en_estructuracargos (gn_j),
                                                         en_numtransaccion,
														 en_decimales,
														 ed_feccancelacion,
                                                         sn_retorno,
                                                         sv_glosa
                                                        ); --Actualiza Cartera (cargo)

                                 IF sn_retorno <> 0
                                 THEN
                                    RAISE error_exception;
                                 END IF;
                              END IF;
                           END IF;                -- if analisis deuda
                                   --Registra relacion conceptos saldados

                           sv_glosa :=
                                  'Error en llamada a Procedimiento CO_REGISTRARELCONCEP_PR. Cliente : '
                               || en_codcliente
                               || ', Fecha : '
                               || SYSDATE
                               || '. ';
                           co_registrarelconcep_pr (en_estructuraabonos (gn_i),
                                                    en_estructuracargos (gn_j),
                                                    en_numtransaccion,
													en_decimales,
                                                    sn_retorno,
                                                    sv_glosa
                                                   ); --Registra relacion conceptos saldados

                           IF sn_retorno <> 0
                           THEN
                              RAISE error_exception;
                           END IF;

                           --Actualiza Castigo (cargo)
                           IF en_estructuracargos (gn_j).cod_tipconce =
                                                            tn_conceptocastigo
                           THEN
                              sv_glosa :=
                                     'Error 100 en llamada a Procedimiento CO_CASTIGOS_EXTERNOS. Cliente : '
                                  || en_codcliente
                                  || ', Fecha : '
                                  || SYSDATE
                                  || '. ';
                              co_castigos_externos (en_codcliente,
                                                    en_estructuracargos (gn_j).num_folio,
                                                    en_estructuracargos (gn_j).pref_plaza,
                                                    TO_CHAR (ed_feccancelacion,
                                                             'DD-MM-YYYY HH24:MI:SS'
                                                            ),
                                                    en_estructuraabonos (gn_i).mto_pagado,
                                                    1,
                                                    en_estructuracargos (gn_j).sec_cuota,
                                                    sn_retorno
                                                   );

                              IF sn_retorno <> 0
                              THEN
                                 RAISE error_exception;
                              END IF;
                           END IF;
                        ELSE -- APLICA PROPORCIONALIDAD
                           IF gn_i = 1
                           THEN
                              sn_sumadeuda := sn_sumadeuda + ln_deuda;
                              sn_ultreg := gn_j; -- para saber en que registro debo ajustar el saldo
                           END IF;
                        END IF;
                     END IF;-- cierre if si deuda > 0
                  END IF; -- cierra if de cargo cancelado
				/* END IF; --Cierre if abono > 0  /* CAGV 30-05-2006 RA-200603160921*/
               END LOOP;-- cargos
            END IF; -- pago mayor a 0
         END IF; -- registro no cancelado

         sn_resto := sn_resto + ln_pago;
      END LOOP; -- abonos
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   -- PasoCobrosCICLO
   END co_cancela_parcial_100_pr;

   PROCEDURE co_cancela_parcial_resto_pr (
   -- PasoCobrosCICLO
      en_estructuracargos   IN OUT NOCOPY   co_carteraconc_qt,
      en_estructuraabonos   IN OUT NOCOPY   co_carteraconc_qt,
      en_num_secuenci       IN              NUMBER,
      en_codcliente         IN              NUMBER,
      ed_feccancelacion     IN              DATE,
      en_numtransaccion     IN              NUMBER,
      en_ultreg             IN              NUMBER,
      en_sumadeuda          IN              NUMBER,
      en_resto              IN              NUMBER,
	  en_decimales          IN              NUMBER,
      sn_retorno            OUT NOCOPY      NUMBER,
      sv_glosa              OUT NOCOPY      VARCHAR2
   )
   IS
		/*
		<NOMBRE>     : co_cancela_parcial_resto_pr</NOMBRE>
		<FECHACREA>  : 29/04/2005<FECHACREA/>
		<MODULO >    : Cobranza </MODULO >
		<AUTOR >     : Claudio Machuca - Marcelo Quiroz </AUTOR >
		<VERSION >   : 1.0</VERSION >
		<DESCRIPCION>: Realiza pago proporcional al documento indicado</DESCRIPCION>
		<FECHAMOD >  : "30-05-2006" </FECHAMOD >
		<MODIFICACION> : "Incidencia RA-200603160921"  </MODIFICACION>
		<VERSION MOD>  : "1.1" </VERSION MOD>
		<DESCMOD >   : Breve descripci¢n de Modificaci¢n </DESCMOD >
		<ParamEntr>  : EN_estructuracargos: Estructura de Cargos a Cancelar </ParamEntr>
		<ParamEntr>  : EN_estructuraabonos: Estructura de Abonos a Aplicar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_SECUENCI: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : EN_NUM_CLIENTE: Documento de Cargo a Cancelar </ParamEntr>
		<ParamEntr>  : En_saldo: Saldo Documento a Cancelar </ParamEntr>
		<ParamSal >  : SN_retorno: Indica si hubo error en la Pl. 0=Sin Error, 1=Con Error </ParamEntr>
		<ParamSal >  : SV_glosa: Descripcion del Error ocurrido. </ParamEntr>
		*/
      tn_conceptocastigo   CO_CARTERA.cod_concepto%TYPE   := 6;
      ln_pago              CO_CARTERA.importe_debe%TYPE   := 0;
      ln_pagado            CO_CARTERA.importe_debe%TYPE   := 0;
      ln_deuda             CO_CARTERA.importe_debe%TYPE   := 0;
      ln_pordeuda          NUMBER (8, 2)                  := 0;
      ln_montopagos        CO_CARTERA.importe_debe%TYPE   := 0;
      ln_sumapagos         CO_CARTERA.importe_debe%TYPE   := 0;
      ln_sumadeuda         CO_CARTERA.importe_debe%TYPE   := 0;
      ln_ultreg            NUMBER (8)                     := 0;
   BEGIN
      sn_retorno := 0;
      ln_sumadeuda := en_sumadeuda;
      ln_ultreg := en_ultreg;

      FOR gn_i IN 1 .. gn_numabonos
      LOOP -- Loop conceptos para recorrer Abonos
         IF gn_i > 1
         THEN -- debo recalcular el saldo de deuda
            ln_sumadeuda := 0;

            FOR gn_j IN 1 .. gn_numcargos
            LOOP -- Loop conceptos para recorrer Cargos
               IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                  AND en_estructuracargos (gn_j).num_secuenci =
                                                               en_num_secuenci
               THEN
                  ln_deuda :=
                        en_estructuracargos (gn_j).importe_debe
                      - en_estructuracargos (gn_j).importe_haber;
                  ln_sumadeuda := ln_sumadeuda + ln_deuda;
                  ln_ultreg := gn_j;
               END IF;
            END LOOP;
         END IF;

         IF en_estructuraabonos (gn_i).ind_cancelado != 'S'
         THEN -- ANALIZO SOLO SI NO FUE CANCELADO
            ln_pago :=
                  en_estructuraabonos (gn_i).importe_haber
                - en_estructuraabonos (gn_i).importe_debe;
            ln_sumapagos := 0;

            FOR gn_j IN 1 .. gn_numcargos
            LOOP -- Loop conceptos para recorrer Cargos
	           IF ln_pago = 0 THEN	EXIT; END IF; /* CAGV 30-05-2006 RA-200603160921 */
               IF     en_estructuracargos (gn_j).ind_cancelado != 'S'
                  AND en_estructuracargos (gn_j).num_secuenci =
                                                               en_num_secuenci
               THEN
                  ln_deuda :=
                        en_estructuracargos (gn_j).importe_debe
                      - en_estructuracargos (gn_j).importe_haber;
   	  				 /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
                     /*                   Desc   : Variable no se utiliza */
/*                  ln_pordeuda := (ln_deuda / ln_sumadeuda) * 100;*/

  			        /* XO-200509070609 Fin   */
                  IF gn_j = en_ultreg
                  THEN
                     ln_montopagos := ln_pago - ln_sumapagos;
                  ELSE
   	  				 /* XO-200509070609 : Inicio : Responsable cambio : mfqg : fecha:16.09.2005 */
                     /*                   Desc   : Calculo de monto proporcional */
/*                     ln_montopagos := (ln_pago * ln_pordeuda) / 100;*/
                     ln_montopagos := (ln_pago * ((ln_deuda / ln_sumadeuda) * 100)) / 100;
  			        /* XO-200509070609 Fin   */

	                 --ln_montopagos := ge_pac_general.redondea (ln_montopagos,gn_numdecimal,0);

					 ln_montopagos := ROUND (ln_montopagos, en_decimales);

                     ln_sumapagos := ln_sumapagos + ln_montopagos;
                  END IF;
 /* CAGV 30-05-2006 RA-200603160921 */
/*                  en_estructuracargos (gn_j).mto_pagado :=
                          en_estructuracargos (gn_j).mto_pagado
                          + ln_montopagos; --- se incrementa el pago con la deuda proporcional*/
                  en_estructuracargos (gn_j).mto_pagado := ln_montopagos; 	 /* CAGV 30-05-2006 RA-200603160921 */
                  en_estructuracargos (gn_j).importe_haber :=
                       en_estructuracargos (gn_j).importe_haber + ln_montopagos;
                  sv_glosa :=
                         'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Cliente : '
                      || en_codcliente
                      || ', Fecha : '
                      || SYSDATE
                      || '. ';
                  co_actualizacartera_pr (en_estructuracargos (gn_j),
                                          en_numtransaccion,
										  en_decimales,
										  ed_feccancelacion,
                                          sn_retorno,
                                          sv_glosa
                                         ); --Actualiza Cartera (cargo)

                  IF sn_retorno <> 0
                  THEN
                     RAISE error_exception;
                  END IF;

                  --Registra relacion conceptos saldados
                  sv_glosa :=
                         'Error en llamada a Procedimiento CO_REGISTRARELCONCEP_PR. Cliente : '
                      || en_codcliente
                      || ', Fecha : '
                      || SYSDATE
                      || '. ';
                  co_registrarelconcep_pr (en_estructuraabonos (gn_i),
                                           en_estructuracargos (gn_j),
                                           en_numtransaccion,
										   en_decimales,
                                           sn_retorno,
                                           sv_glosa
                                          ); --Registra relacion conceptos saldados

                  IF sn_retorno <> 0
                  THEN
                     RAISE error_exception;
                  END IF;

                  --Actualiza Castigo (cargo)
                  IF en_estructuracargos (gn_j).cod_tipconce = tn_conceptocastigo
                  THEN
                     sv_glosa :=
                            'Error 100 en llamada a Procedimiento CO_CASTIGOS_EXTERNOS. Cliente : '
                         || en_codcliente
                         || ', Fecha : '
                         || SYSDATE
                         || '. ';
                     co_castigos_externos (en_codcliente,
                                           en_estructuracargos (gn_j).num_folio,
                                           en_estructuracargos (gn_j).pref_plaza,
                                           TO_CHAR ( ed_feccancelacion, 'DD-MM-YYYY HH24:MI:SS' ),
                                           en_estructuraabonos (gn_i).mto_pagado,
                                           1,
                                           en_estructuracargos (gn_j).sec_cuota,
                                           sn_retorno
                                          );

                     IF sn_retorno <> 0
                     THEN
                        RAISE error_exception;
                     END IF;
                  END IF;
               END IF;
            END LOOP; -- cargos
         END IF;

--- Procedo a cancelar abono distribuido
         en_estructuraabonos (gn_i).importe_debe :=
                                      en_estructuraabonos (gn_i).importe_haber;
         sv_glosa :=
                'Error en llamada a Procedimiento CO_ACTUALIZACARTERA_PR (3). Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_actualizacartera_pr (en_estructuraabonos (gn_i),
                                 en_numtransaccion,
								 en_decimales,
								 ed_feccancelacion,
                                 sn_retorno,
                                 sv_glosa
                                ); --Actualiza Cartera (abono)

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;

         sv_glosa :=
                'Error en llamada a Procedimiento CO_CANCELACONCEPTO_PR (2). Cliente : '
             || en_codcliente
             || ', Fecha : '
             || SYSDATE
             || '. ';
         co_cancelaconcepto_pr (en_estructuraabonos (gn_i),
                                ed_feccancelacion,
                                en_numtransaccion,
								en_decimales,
                                sn_retorno,
                                sv_glosa
                               ); --Cancela concepto (cargo)

         IF sn_retorno <> 0
         THEN
            RAISE error_exception;
         END IF;
      END LOOP; -- abonos
   EXCEPTION
      WHEN error_exception
      THEN
         sn_retorno := 1;
      WHEN OTHERS
      THEN
         sn_retorno := 1;
         sv_glosa := sv_glosa || SQLERRM;
   -- PasoCobrosCICLO
   END co_cancela_parcial_resto_pr;
-----------------------------------------------------------------

END Co_Cancelacion_Pg;
/
SHOW ERRORS
