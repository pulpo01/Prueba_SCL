CREATE OR REPLACE PROCEDURE        P_Reponer_Ventas (v_producto IN VARCHAR2)
IS
--
-- Procedimiento de depuracion de tablas en ventas incompletas de los
-- diferentes productos
--
   v_rowid         ROWID;
   v_abonado       ga_abocel.num_abonado%TYPE;
   v_error         VARCHAR2 (1) := '0';
   v_holding       ga_abocel.cod_holding%TYPE;
   v_empresa       ga_abocel.cod_empresa%TYPE;
   v_usuario       ga_abocel.cod_usuario%TYPE;
   v_subcuenta     ga_abocel.cod_subcuenta%TYPE;
   v_cuenta        ga_abocel.cod_cuenta%TYPE;
   v_cliente       ga_abocel.cod_cliente%TYPE;
   v_venta         ga_abocel.num_venta%TYPE;
   v_supertel      ga_abocel.ind_supertel%TYPE;
   v_ciclo         ga_abocel.cod_ciclo%TYPE;
   v_celular       ga_abocel.num_celular%TYPE;
   v_telefija      ga_abocel.num_telefija%TYPE;
   v_uso           ga_abocel.cod_uso%TYPE;
   v_origen        VARCHAR2 (15);
   v_fec_alta      ga_abocel.fec_alta%TYPE;
   v_situacion     ga_abocel.cod_situacion%TYPE;
   vp_producto     ga_abocel.cod_producto%TYPE;
   vp_error        VARCHAR2 (2);

   v_prepago       ged_codigos.cod_valor%TYPE;
   v_hibrido       ged_codigos.cod_valor%TYPE;
   v_plantarif     ga_abocel.cod_plantarif%TYPE;
   v_tiplan        ta_plantarif.cod_tiplan%TYPE;


   CURSOR c1
   IS
      SELECT ROWID, num_abonado, cod_situacion, cod_plantarif
	    FROM ga_ABOAMIST
       WHERE cod_producto = TO_NUMBER(v_producto)
         AND cod_situacion = 'TVP'
         AND TRUNC (fec_alta) <=   SYSDATE - 1
       UNION
      SELECT ROWID, num_abonado, cod_situacion, cod_plantarif
        FROM ga_abocel
       WHERE cod_producto = TO_NUMBER(v_producto)
         AND cod_situacion = 'TVP'
         AND TRUNC (fec_alta) <=   SYSDATE - 1;

   CURSOR c2
   IS
      SELECT a.ROWID, a.num_abonado, b.cod_situacion, cod_plantarif
        FROM ga_transacventa a, ga_abobeep b
       WHERE a.cod_producto = vp_producto
         AND a.num_abonado = b.num_abonado
         AND b.cod_situacion = 'TVP'
         AND TRUNC (fec_inicventa) <=   SYSDATE
                                      - 1;

   error_proceso   EXCEPTION;
BEGIN
   vp_producto := TO_NUMBER (v_producto);
   v_cliente := 0;

   SELECT val_parametro INTO v_prepago
     FROM ged_parametros
    WHERE nom_parametro = 'TIP_PLAN_PREPAGO'
      AND cod_modulo    = 'GA'
          AND cod_producto  = 1;

   SELECT val_parametro INTO v_hibrido
     FROM ged_parametros
    WHERE nom_parametro = 'TIP_PLAN_HIBRIDO'
      AND cod_modulo    = 'GA'
          AND cod_producto  = 1;



   IF vp_producto = '1'
   THEN
      OPEN c1;
   END IF;

   IF vp_producto = '2'
   THEN
      OPEN c2;
   END IF;

   LOOP
      BEGIN
         vp_error := '0';

         IF vp_producto = '1'
         THEN
            FETCH c1 INTO v_rowid, v_abonado, v_situacion, v_plantarif;
            EXIT WHEN c1%NOTFOUND;
         ELSIF vp_producto = '2'
         THEN
            FETCH c2 INTO v_rowid, v_abonado, v_situacion, v_plantarif;
            EXIT WHEN c2%NOTFOUND;
         END IF;

         -- Seleccionando cliente desde abonados
         IF vp_producto = 1
         THEN
            BEGIN
               SELECT cod_cliente, ind_supertel, cod_ciclo, num_celular,
                      cod_uso, num_telefija, TO_CHAR (fec_alta, 'DD-MON-YY')
                 INTO v_cliente, v_supertel, v_ciclo, v_celular,
                      v_uso, v_telefija, v_fec_alta
                 FROM ga_abocel
                WHERE num_abonado = v_abonado;
               v_origen := 'GA_ABOCEL';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  SELECT cod_cliente, ind_supertel, cod_ciclo, num_celular,
                         cod_uso, num_telefija,
                         TO_CHAR (fec_alta, 'DD-MON-YY')
                    INTO v_cliente, v_supertel, v_ciclo, v_celular,
                         v_uso, v_telefija,
                         v_fec_alta
                    FROM ga_aboamist
                   WHERE num_abonado = v_abonado;
                  v_origen := 'GA_ABOAMIST';
            END;
         ELSIF vp_producto = 2
         THEN
            SELECT cod_cliente
              INTO v_cliente
              FROM ga_abobeep
             WHERE num_abonado = v_abonado;
         END IF;

         IF    v_origen = 'GA_ABOCEL'
            OR v_origen = 'GA_ABOAMIST'
         THEN
            p_recinf_abonado (
               vp_producto,
               v_abonado,
               v_holding,
               v_empresa,
               v_venta,
               vp_error
            );

            IF vp_error <> '0'
            THEN
               vp_error := '0';
   			   DBMS_OUTPUT.PUT_LINE('Problemas en p_recinf_abonado'); --Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
               RAISE error_proceso;
            END IF;
         END IF;

         p_del_equipabonoser (vp_producto, v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
  		    DBMS_OUTPUT.PUT_LINE('Problemas en p_del_equipabonoser');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_equipaboser (vp_producto, v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_equipaboser');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_diasabo (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_diasabo');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_numespabo (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_numespabo');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_servsuplabo (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_servsuplabo');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_segurabo (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_segurabo');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

	     p_del_promocion (v_abonado, v_cliente, vp_error);
		 IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_promocion');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_amistprom (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_amistprom');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         IF v_holding IS NOT NULL
         THEN
            p_updte_holding (vp_producto, v_holding, vp_error);

            IF vp_error <> '0'
            THEN
               vp_error := '0';
               DBMS_OUTPUT.PUT_LINE('Problemas en p_updte_holding');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
               RAISE error_proceso;
            END IF;
         END IF;

         IF v_empresa IS NOT NULL
         THEN
            p_updte_empresa (vp_producto, v_empresa, vp_error);

            IF vp_error <> '0'
            THEN
               vp_error := '0';
               DBMS_OUTPUT.PUT_LINE('Problemas en p_updte_empresa');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
               RAISE error_proceso;
            END IF;
         END IF;

         p_updte_movimiento (vp_producto, v_abonado, vp_error);
         p_del_cargos (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_updte_movimiento');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         IF v_cliente > 0
         THEN
            P_Upd_Histdocu (v_cliente, v_venta, vp_error);

            IF vp_error <> '0'
            THEN
               vp_error := '0';
               DBMS_OUTPUT.PUT_LINE('Problemas en p_upd_histdocu');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
               RAISE error_proceso;
            END IF;
         END IF;

         IF      v_supertel = 1
             AND v_ciclo = 10
         THEN
            p_del_ctcmovim (v_telefija, vp_error);

            IF vp_error <> '0'
            THEN
               vp_error := '0';
               DBMS_OUTPUT.PUT_LINE('Problemas en p_del_ctcmovim');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
               RAISE error_proceso;
            END IF;
         END IF;


         SELECT cod_tiplan
           INTO v_tiplan
           FROM ta_plantarif
          WHERE cod_plantarif = v_plantarif;

         IF (v_tiplan = v_hibrido) OR (v_tiplan = v_prepago)
         THEN
            --P_Del_Movcontr (v_celular, v_abonado, v_fec_alta, vp_error); Modificación de Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
              P_Del_Movcontr (v_abonado, v_celular, v_fec_alta, vp_error);

            IF vp_error <> '0'
            THEN
               vp_error := '0';
               DBMS_OUTPUT.PUT_LINE('Problemas en p_del_movcontr');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
               RAISE error_proceso;
            END IF;
         END IF;

         IF (v_uso = 17)
         THEN
            p_del_movibox (v_cliente, v_abonado, vp_error);

            IF vp_error <> '0'
            THEN
               vp_error := '0';
               DBMS_OUTPUT.PUT_LINE('Problemas en p_del_movibox');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
               RAISE error_proceso;
            END IF;
         END IF;

         P_Ins_Audrest (vp_producto, v_abonado, 'P_REPONER_VENTAS', vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_ins_audrest');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_limitecliabo (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_limitecliabo');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         P_Del_Abonados (vp_producto, v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_abonados');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_petiguias (v_abonado, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_petiguias');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         p_del_ventas (v_venta, vp_error);

         IF vp_error <> '0'
         THEN
            vp_error := '0';
            DBMS_OUTPUT.PUT_LINE('Problemas en p_del_ventas');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
            RAISE error_proceso;
         END IF;

         DELETE      ga_transacventa
               --WHERE ROWID = v_rowid;
			   where num_abonado=v_abonado;

         COMMIT;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ROLLBACK;
       		DBMS_OUTPUT.PUT_LINE('Datos No encontrados en Cursor ');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
         WHEN error_proceso
         THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error_Proceso en Cursor -> Rollback ');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
         WHEN OTHERS
         THEN
            ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('Problemas en Cursor -> Rollback ');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
      END;
   END LOOP;

   IF vp_producto = '1'
   THEN
      CLOSE c1;
      p_del_camserie (vp_producto, vp_error);

      IF vp_error <> '0'
      THEN
         vp_error := '0';
         --RAISE error_proceso;
      END IF;

      COMMIT;
      p_del_restitucion (vp_producto, vp_error);

      IF vp_error <> '0'
      THEN
         vp_error := '0';
         --RAISE error_proceso;
      END IF;

      COMMIT;

      p_del_camnumero(vp_producto,vp_error);
      IF vp_error <> '0'
      THEN
         vp_error := '0';
		 --RAISE error_proceso;
      END IF;

      COMMIT;
   END IF;

   IF vp_producto = '2'
   THEN
      CLOSE c2;
   END IF;

   p_desbloq_vendedor (vp_producto, vp_error);

   IF vp_error <> '0'
   THEN
      vp_error := '0';
   END IF;

   p_recupera_ventas_almacen (vp_producto, vp_error);

   IF vp_error <> '0'
   THEN
      vp_error := '0';
   END IF;

   P_Recupera_Articulos (vp_producto, vp_error);

   IF vp_error <> '0'
   THEN
      vp_error := '0';
   END IF;

   COMMIT;

   -- Ini. TMC: 33131 Claudio Leyton 9/8/2006
   VE_RECARTLOGISTICA_PR;
   -- Fin TMC: 33131 Claudio Leyton 9/8/2006

   p_recupera_numeracion (vp_producto, vp_error);

   IF vp_error <> '0'
   THEN
      vp_error := '0';
      DBMS_OUTPUT.PUT_LINE('Problemas en p_recupera_numeracion ');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
      RAISE error_proceso;
   END IF;

   COMMIT;
EXCEPTION
   WHEN error_proceso
   THEN
      ROLLBACK;
  	  DBMS_OUTPUT.PUT_LINE('Se ha realizado Rollback Bloque Principal ');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
   WHEN OTHERS
   THEN
      NULL;
	  DBMS_OUTPUT.PUT_LINE('Problemas Bloque Principal ');--Modificación Incidencia CH-220820031246 (Patricia Molina 11-03-2004)
END;
/
SHOW ERRORS
