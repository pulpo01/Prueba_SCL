CREATE OR REPLACE PACKAGE BODY al_notapedidoweb_pg
IS
------------------------------------------------------------------------------------------------------
   PROCEDURE al_estado_pedido_pr (
      en_cod_pedido     IN              npt_estado_pedido.cod_pedido%TYPE,
      en_cod_funcion    IN              npt_fun_estado_flujo_lee.cod_funcion%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      le_error           EXCEPTION;
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_estado_pedido   npt_estado_pedido.cod_estado_flujo%TYPE;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT COUNT(1) '
         || 'FROM   npt_estado_pedido a, npt_fun_estado_flujo_lee c '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido
         || 'AND    a.cod_estado_flujo =(SELECT MAX(b.cod_estado_flujo) '
         || '                            FROM   npt_estado_pedido b '
         || '                            WHERE  a.cod_pedido = b.cod_pedido '
         || '                            AND    NVL(b.cod_pedido,b.cod_pedido) > 0) '
         || 'AND    a.cod_estado_flujo = c.cod_estado_flujo '
         || 'AND    c.cod_funcion = '
         || en_cod_funcion;

      SELECT COUNT (1)
        INTO ln_estado_pedido
        FROM npt_estado_pedido a, npt_fun_estado_flujo_lee c
       WHERE cod_pedido = en_cod_pedido
         AND a.cod_estado_flujo =
                (SELECT MAX (b.cod_estado_flujo)
                   FROM npt_estado_pedido b
                  WHERE a.cod_pedido = b.cod_pedido
                    AND NVL (b.cod_pedido, b.cod_pedido) > 0)
         AND a.cod_estado_flujo = c.cod_estado_flujo
         AND c.cod_funcion = en_cod_funcion;

      IF ln_estado_pedido = 0
      THEN
         sn_cod_retorno := 900008;         --Estado del pedido no corresponde
         RAISE le_error;
      END IF;
   EXCEPTION
      WHEN le_error
      THEN
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'El Pedido se encuentra con estado distinto a Asignado despachador';
         lv_des_error :=
              'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_PEDIDO_PR();' || ' - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    cv_cod_moduloal,
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                    'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_estado_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_existe_pedido_pr (
      en_cod_pedido     IN              npt_estado_pedido.cod_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      le_error           EXCEPTION;
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_existe_pedido   NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'EXISTE PEDIDO';
      sn_cod_retorno := 1;
      /*lv_ssql :=
            'SELECT 1 '
         || 'FROM   np_validacion_series_to '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido;

      SELECT COUNT (0)
        INTO ln_existe_pedido
        FROM np_validacion_series_to
       WHERE cod_pedido = en_cod_pedido;*/
       
      lv_ssql :=
            'SELECT 1 '
         || 'FROM   np_val_series_temp_to '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido;

      SELECT COUNT (0)
        INTO ln_existe_pedido
        FROM np_val_series_temp_to
       WHERE cod_pedido = en_cod_pedido;

      IF ln_existe_pedido = 0
      THEN
         RAISE le_error;
      END IF;
   EXCEPTION
      WHEN le_error
      THEN
         sv_mens_retorno := 'NO EXISTE PEDIDO';
         sn_cod_retorno := 0;
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                    'AL_NOTAPEDIDOWEB_PG.AL_EXISTE_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_EXISTE_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_existe_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_val_serie_pedido_pr (
      en_cod_pedido     IN              npt_estado_pedido.cod_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_existe_pedido   NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT COUNT(0) '
         || 'FROM   np_validacion_series_to '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido
         || 'AND    cod_error <> NULL';

      SELECT COUNT (0)
        INTO ln_existe_pedido
        FROM np_validacion_series_to
       WHERE cod_pedido = en_cod_pedido AND estado = 'ERROR';

      IF ln_existe_pedido <> 0
      THEN
         sv_mens_retorno := 'Series con Error';
         sn_cod_retorno := 1;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                 'AL_NOTAPEDIDOWEB_PG.AL_VAL_SERIE_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 'AL',
                                 sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                 '1.0',
                                 USER,
                                 'AL_NOTAPEDIDOWEB_PG.AL_VAL_SERIE_PEDIDO_PR',
                                 lv_ssql,
                                 SQLCODE,
                                 lv_des_error
                                );
   END al_val_serie_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_elimina_pedido_pr (
      en_cod_pedido     IN              npt_estado_pedido.cod_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_existe_pedido   NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'DELETE np_validacion_series_to '
         || 'WHERE cod_pedido = '
         || en_cod_pedido;

      DELETE      np_validacion_series_to
            WHERE cod_pedido = en_cod_pedido;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900009;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Error al Eliminar pedido de la tabla de Validacion de Series';
         lv_des_error :=
                   'AL_NOTAPEDIDOWEB_PG.AL_ELIMINA_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                  (sn_num_evento,
                                   'AL',
                                   sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                   '1.0',
                                   USER,
                                   'AL_NOTAPEDIDOWEB_PG.AL_ELIMINA_PEDIDO_PR',
                                   lv_ssql,
                                   SQLCODE,
                                   lv_des_error
                                  );
   END al_elimina_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_cantidad_pedido_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sn_cant_pedido    OUT NOCOPY      npt_pedido.can_total_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_existe_pedido   NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT can_total_pedido '
         || 'FROM   npt_pedido '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido;

      SELECT can_total_pedido
        INTO sn_cant_pedido
        FROM npt_pedido
       WHERE cod_pedido = en_cod_pedido;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 900010;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'No se Encuentra cantidad total del pedido';
         lv_des_error :=
                  'AL_NOTAPEDIDOWEB_PG.AL_CANTIDAD_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  'AL',
                                  sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                  '1.0',
                                  USER,
                                  'AL_NOTAPEDIDOWEB_PG.AL_CANTIDAD_PEDIDO_PR',
                                  lv_ssql,
                                  SQLCODE,
                                  lv_des_error
                                 );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                  'AL_NOTAPEDIDOWEB_PG.AL_CANTIDAD_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  'AL',
                                  sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                  '1.0',
                                  USER,
                                  'AL_NOTAPEDIDOWEB_PG.AL_CANTIDAD_PEDIDO_PR',
                                  lv_ssql,
                                  SQLCODE,
                                  lv_des_error
                                 );
   END al_cantidad_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_cantidad_pedido_x_linea_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_existe_pedido   NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT lin_det_pedido, cod_articulo, can_detalle_pedido '
         || 'FROM   NPT_DETALLE_PEDIDO '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido;

      OPEN sc_cursordatos FOR
         SELECT lin_det_pedido, cod_articulo, can_detalle_pedido
           FROM npt_detalle_pedido
          WHERE cod_pedido = en_cod_pedido;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900011;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al Obtener detalle del pedido por linea';
         lv_des_error :=
               'AL_NOTAPEDIDOWEB_PG.AL_CANTIDAD_PEDIDO_X_LINEA_PR(); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          'AL',
                          sn_cod_retorno || ' -- ' || sv_mens_retorno,
                          '1.0',
                          USER,
                          'AL_NOTAPEDIDOWEB_PG.AL_CANTIDAD_PEDIDO_X_LINEA_PR',
                          lv_ssql,
                          SQLCODE,
                          lv_des_error
                         );
   END al_cantidad_pedido_x_linea_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_datos_pedido_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sn_cod_user_cre   OUT NOCOPY      npt_pedido.cod_usuario_cre%TYPE,
      sn_cod_user_ing   OUT NOCOPY      npt_pedido.cod_usuario_ing%TYPE,
      sv_sysdate        OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT cod_usuario_cre, cod_usuario_ing '
         || 'FROM   npt_pedido '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido;

      SELECT cod_usuario_cre, cod_usuario_ing
        INTO sn_cod_user_cre, sn_cod_user_ing
        FROM npt_pedido
       WHERE cod_pedido = en_cod_pedido;

      lv_ssql := 'SELECT TO_CHAR(SYSDATE,DD-MM-YYYY HH24:MI:SS) FROM dual';

      SELECT TO_CHAR (SYSDATE, 'dd-mm-yyyy hh24:mi')
        INTO sv_sysdate
        FROM DUAL;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 900012;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurro un error al Obtener los datos del Pedido;
         lv_des_error :=
                     'AL_NOTAPEDIDOWEB_PG.AL_DATOS_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_DATOS_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                     'AL_NOTAPEDIDOWEB_PG.AL_DATOS_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_DATOS_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_datos_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_pedido_control_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sn_existe         OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT COUNT(0) '
         || 'FROM   np_control_ing_series_to '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido
         || ' '
         || 'AND    estado_registro IS NULL';

      SELECT COUNT (0)
        INTO sn_existe
        FROM np_control_ing_series_to
       WHERE cod_pedido = en_cod_pedido AND estado_registro IS NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                   'AL_NOTAPEDIDOWEB_PG.AL_PEDIDO_CONTROL_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                  (sn_num_evento,
                                   'AL',
                                   sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                   '1.0',
                                   USER,
                                   'AL_NOTAPEDIDOWEB_PG.AL_PEDIDO_CONTROL_PR',
                                   lv_ssql,
                                   SQLCODE,
                                   lv_des_error
                                  );
   END al_pedido_control_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_pedido_baja_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sn_ped_baja       OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT  COUNT(0) '
         || 'FROM    npt_estado_pedido '
         || 'WHERE   cod_pedido = '
         || en_cod_pedido
         || ' '
         || 'AND NVL(cod_estado_flujo, cod_estado_flujo) = 49';

      SELECT COUNT (0)
        INTO sn_ped_baja
        FROM npt_estado_pedido
       WHERE cod_pedido = en_cod_pedido
         AND NVL (cod_estado_flujo, cod_estado_flujo) = 49;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                      'AL_NOTAPEDIDOWEB_PG.AL_PEDIDO_BAJA_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_PEDIDO_BAJA_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_pedido_baja_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_insert_control_serie_pr (
      en_cod_pedido     IN              np_control_ing_series_to.cod_pedido%TYPE,
      ev_nom_user       IN              np_control_ing_series_to.usuario_web%TYPE,
      en_cantidad       IN              np_control_ing_series_to.cantidad_series%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'INSERT INTO np_control_ing_series_to(cod_pedido, usuario_web, fecha_inicio, estado_proceso, fecha_termino, '
         || '                                     cantidad_series, estado_registro, fecha_eliminacion) '
         || 'VALUES('
         || en_cod_pedido
         || ','
         || ev_nom_user
         || ', SYSDATE, ''PENDIENTE'', SYSDATE,'
         || en_cantidad
         || ', '''', '''')';

      INSERT INTO np_control_ing_series_to
                  (cod_pedido, usuario_web, fecha_inicio, estado_proceso,
                   fecha_termino, cantidad_series, estado_registro,
                   fecha_eliminacion
                  )
           VALUES (en_cod_pedido, ev_nom_user, SYSDATE, 'PENDIENTE',
                   SYSDATE, en_cantidad, '',
                   ''
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900013;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al registrar estado del pedido';
         lv_des_error :=
             'AL_NOTAPEDIDOWEB_PG.AL_INSERT_CONTROL_SERIE_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             'AL',
                             sn_cod_retorno || ' -- ' || sv_mens_retorno,
                             '1.0',
                             USER,
                             'AL_NOTAPEDIDOWEB_PG.AL_INSERT_CONTROL_SERIE_PR',
                             lv_ssql,
                             SQLCODE,
                             lv_des_error
                            );
   END al_insert_control_serie_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_parametro_npw_pr (
      en_alias           IN              npt_parametro.alias_parametro%TYPE,
      sn_val_parametro   OUT NOCOPY      npt_parametro.valor_parametro%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT valor_parametro '
         || 'FROM   npt_parametro '
         || 'WHERE  alias_parametro = '
         || en_alias;

      SELECT valor_parametro
        INTO sn_val_parametro
        FROM npt_parametro
       WHERE alias_parametro = en_alias;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 900014;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'No Existe Parametro ingresado
         lv_des_error :=
                    'AL_NOTAPEDIDOWEB_PG.AL_PARAMETRO_NPW_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_PARAMETRO_NPW_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                    'AL_NOTAPEDIDOWEB_PG.AL_PARAMETRO_NPW_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_PARAMETRO_NPW_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_parametro_npw_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_estado_flujo_esc_pr (
      en_cod_funcion    IN              npt_fun_estado_flujo_esc.cod_funcion%TYPE,
      sn_val_estado     OUT NOCOPY      npt_fun_estado_flujo_esc.cod_estado_flujo%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT cod_estado_flujo '
         || 'FROM   npt_fun_estado_flujo_esc '
         || 'WHERE  cod_funcion = '
         || sn_val_estado
         || 'ORDER BY orden_fun_est_flu_esc';

      SELECT   cod_estado_flujo
          INTO sn_val_estado
          FROM npt_fun_estado_flujo_esc
         WHERE cod_funcion = en_cod_funcion
      ORDER BY orden_fun_est_flu_esc;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 900015;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al Obtener Estado de Flujo del Pedido
         lv_des_error :=
                 'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_FLUJO_ESC_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 'AL',
                                 sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                 '1.0',
                                 USER,
                                 'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_FLUJO_ESC_PR',
                                 lv_ssql,
                                 SQLCODE,
                                 lv_des_error
                                );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                 'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_FLUJO_ESC_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 'AL',
                                 sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                 '1.0',
                                 USER,
                                 'AL_NOTAPEDIDOWEB_PG.AL_ESTADO_FLUJO_ESC_PR',
                                 lv_ssql,
                                 SQLCODE,
                                 lv_des_error
                                );
   END al_estado_flujo_esc_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_val_deta_valida_serie_pr (
      en_cod_pedido     IN              npt_detalle_pedido.cod_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql             ge_errores_pg.vquery;
      lv_des_error        ge_errores_pg.desevent;
      lv_lin_det_pedido   npt_detalle_pedido.lin_det_pedido%TYPE;
      lv_asig_deta_pedi   npt_detalle_pedido.can_asig_detalle_pedido%TYPE;
      ln_can_ing_serie    NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT dp.lin_det_pedido, dp.can_asig_detalle_pedido, COUNT(*) can_ing_serie_pedido '
         || 'FROM   npt_detalle_pedido dp, np_validacion_series_to sp '
         || 'WHERE  dp.cod_pedido = '
         || en_cod_pedido
         || ' '
         || 'AND    dp.cod_pedido = sp.cod_pedido '
         || 'AND    dp.lin_det_pedido = sp.lin_det_pedido'
         || 'AND    SUBSTR(sp.num_serie, 1, 10) != ''NO SERIADO'''
         || 'GROUP BY dp.lin_det_pedido, dp.can_asig_detalle_pedido '
         || 'HAVING dp.can_asig_detalle_pedido != COUNT(*)';

      SELECT   dp.lin_det_pedido, dp.can_asig_detalle_pedido,
               COUNT (*) can_ing_serie_pedido
          INTO lv_lin_det_pedido, lv_asig_deta_pedi,
               ln_can_ing_serie
          FROM npt_detalle_pedido dp, np_validacion_series_to sp
         WHERE dp.cod_pedido = en_cod_pedido
           AND dp.cod_pedido = sp.cod_pedido
           AND dp.lin_det_pedido = sp.lin_det_pedido
           AND SUBSTR (sp.num_serie, 1, 10) != 'NO SERIADO'
      GROUP BY dp.lin_det_pedido, dp.can_asig_detalle_pedido
        HAVING dp.can_asig_detalle_pedido != COUNT (*);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
            'AL_NOTAPEDIDOWEB_PG.AL_VAL_DETA_VALIDA_SERIE_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            'AL',
                            sn_cod_retorno || ' -- ' || sv_mens_retorno,
                            '1.0',
                            USER,
                            'AL_NOTAPEDIDOWEB_PG.AL_VAL_DETA_VALIDA_SERIE_PR',
                            lv_ssql,
                            SQLCODE,
                            lv_des_error
                           );
   END al_val_deta_valida_serie_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_val_serie_pedido_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sn_ped_serie      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT COUNT (0) '
         || 'FROM   npt_serie_pedido '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido;

      SELECT COUNT (0)
        INTO sn_ped_serie
        FROM npt_serie_pedido
       WHERE cod_pedido = en_cod_pedido;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                 'AL_NOTAPEDIDOWEB_PG.AL_VAL_SERIE_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 'AL',
                                 sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                 '1.0',
                                 USER,
                                 'AL_NOTAPEDIDOWEB_PG.AL_VAL_SERIE_PEDIDO_PR',
                                 lv_ssql,
                                 SQLCODE,
                                 lv_des_error
                                );
   END al_val_serie_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_val_estado_control_pr (
      en_cod_pedido       IN              npt_pedido.cod_pedido%TYPE,
      en_estado_proceso   IN              np_control_ing_series_to.estado_proceso%TYPE,
      sn_est_serie        OUT NOCOPY      NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT COUNT (0) '
         || 'FROM   np_control_ing_series_to '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido
         || 'AND    estado_proceso = '
         || en_estado_proceso;

      SELECT COUNT (0)
        INTO sn_est_serie
        FROM np_control_ing_series_to
       WHERE cod_pedido = en_cod_pedido AND estado_proceso = en_estado_proceso;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'AL_NOTAPEDIDOWEB_PG.AL_VAL_ESTADO_CONTROL_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               'AL',
                               sn_cod_retorno || ' -- ' || sv_mens_retorno,
                               '1.0',
                               USER,
                               'AL_NOTAPEDIDOWEB_PG.AL_VAL_ESTADO_CONTROL_PR',
                               lv_ssql,
                               SQLCODE,
                               lv_des_error
                              );
   END al_val_estado_control_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_upd_estado_control_pr (
      en_cod_pedido      IN              npt_pedido.cod_pedido%TYPE,
      en_estado_actual   IN              np_control_ing_series_to.estado_proceso%TYPE,
      en_estado_nuevo    IN              np_control_ing_series_to.estado_proceso%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'UPDATE np_control_ing_series_to'
         || 'SET    estado_proceso = '
         || en_estado_nuevo
         || ','
         || '       fecha_termino = SYSDATE '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido
         || 'AND    estado_proceso = '
         || en_estado_actual
         || 'AND    estado_registro IS NULL';

      UPDATE np_control_ing_series_to
         SET estado_proceso = en_estado_nuevo,
             fecha_termino = SYSDATE
       WHERE cod_pedido = en_cod_pedido
         AND estado_proceso = en_estado_actual
         AND estado_registro IS NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900016;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al actualizar estado del Proceso del Pedido
         lv_des_error :=
               'AL_NOTAPEDIDOWEB_PG.AL_UPD_ESTADO_CONTROL_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                              (sn_num_evento,
                               'AL',
                               sn_cod_retorno || ' -- ' || sv_mens_retorno,
                               '1.0',
                               USER,
                               'AL_NOTAPEDIDOWEB_PG.AL_UPD_ESTADO_CONTROL_PR',
                               lv_ssql,
                               SQLCODE,
                               lv_des_error
                              );
   END al_upd_estado_control_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_ins_serie_pedido_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'INSERT INTO npt_serie_pedido(cod_pedido, lin_det_pedido, cod_serie_pedido, cod_bar_ser_pedido, ind_telefono) '
         || 'SELECT a.cod_pedido, a.lin_det_pedido, a.num_serie, a.cod_barra_serie, b.ind_telefono '
         || 'FROM   np_validacion_series_to a, al_series b '
         || 'WHERE  cod_pedido = '
         || en_cod_pedido
         || 'AND    a.num_serie = b.num_serie';

      INSERT INTO npt_serie_pedido
                  (cod_pedido, lin_det_pedido, cod_serie_pedido,
                   cod_bar_ser_pedido, ind_telefono)
         SELECT a.cod_pedido, a.lin_det_pedido, a.num_serie,
                a.cod_barra_serie, b.ind_telefono
           FROM np_validacion_series_to a, al_series b
          WHERE cod_pedido = en_cod_pedido AND a.num_serie = b.num_serie;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900017;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al registrar serie pedido
         lv_des_error :=
                 'AL_NOTAPEDIDOWEB_PG.AL_INS_SERIE_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 'AL',
                                 sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                 '1.0',
                                 USER,
                                 'AL_NOTAPEDIDOWEB_PG.AL_INS_SERIE_PEDIDO_PR',
                                 lv_ssql,
                                 SQLCODE,
                                 lv_des_error
                                );
   END al_ins_serie_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_bodega_pedido_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sn_cod_bodega     OUT NOCOPY      npt_pedido.cod_bodega%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT a.cod_bodega '
         || 'FROM   npt_pedido a '
         || 'WHERE  a.cod_pedido = '
         || en_cod_pedido;

      SELECT a.cod_bodega
        INTO sn_cod_bodega
        FROM npt_pedido a
       WHERE a.cod_pedido = en_cod_pedido;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 900018;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'No existe información de bodega para el pedido
         lv_des_error :=
                    'AL_NOTAPEDIDOWEB_PG.AL_BODEGA_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_BODEGA_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                    'AL_NOTAPEDIDOWEB_PG.AL_BODEGA_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_BODEGA_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_bodega_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_upd_pedido_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      en_num_guia       IN              npt_pedido.num_guia%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'UPDATE npt_pedido '
         || 'SET    NUM_GUIA = '
         || en_num_guia
         || 'WHERE  cod_pedido = '
         || en_cod_pedido;

      UPDATE npt_pedido
         SET num_guia = en_num_guia
       WHERE cod_pedido = en_cod_pedido;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900019;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al actualizar número de guia del Pedido
         lv_des_error :=
                       'AL_NOTAPEDIDOWEB_PG.AL_UPD_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_UPD_PEDIDO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_upd_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_series_erroneas_pr (
      en_cod_pedido     IN              npt_pedido.cod_pedido%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT a.num_serie, b.des_error '
         || 'FROM   NP_VALIDACION_SERIES_TO a, NP_ERRORES_SERIES_TD b '
         || 'WHERE  a.cod_error = b.cod_error '
         || 'AND    a.estado = ''ERROR'''
         || 'AND    a.cod_pedido = '
         || en_cod_pedido;

      OPEN sc_cursordatos FOR
         SELECT a.num_serie, b.des_error
           FROM np_validacion_series_to a, np_errores_series_td b
          WHERE a.cod_error = b.cod_error
            AND a.estado = 'ERROR'
            AND a.cod_pedido = en_cod_pedido;
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900011;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al Obtener detalle del pedido por linea';
         lv_des_error :=
                  'AL_NOTAPEDIDOWEB_PG.AL_SERIES_ERRONEAS_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                 (sn_num_evento,
                                  'AL',
                                  sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                  '1.0',
                                  USER,
                                  'AL_NOTAPEDIDOWEB_PG.AL_SERIES_ERRONEAS_PR',
                                  lv_ssql,
                                  SQLCODE,
                                  lv_des_error
                                 );
   END al_series_erroneas_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_upd_control_reproceso_pr (
      en_cod_pedido        IN              npt_pedido.cod_pedido%TYPE,
      ev_estado_registro   IN              np_control_ing_series_to.estado_registro%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'UPDATE np_control_ing_series_to and '
         || 'SET    estado_registro = '
         || ev_estado_registro
         || ','
         || '       fecha_eliminacion = SYSDATE'
         || 'WHERE  a.cod_pedido = '
         || en_cod_pedido
         || ' '
         || 'AND    a.fecha_inicio in (SELECT MAX(fecha_inicio) '
         || '                          FROM   np_control_ing_series_to b'
         || '                          WHERE a.cod_pedido = b.cod_pedido)';

      UPDATE np_control_ing_series_to a
         SET estado_registro = ev_estado_registro,
             fecha_eliminacion = SYSDATE
       WHERE a.cod_pedido = en_cod_pedido
         AND a.fecha_inicio IN (SELECT MAX (fecha_inicio)
                                  FROM np_control_ing_series_to b
                                 WHERE a.cod_pedido = b.cod_pedido);
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900024;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Ocurrio un error al actualizar estado registro de control de ingreso de series
         lv_des_error :=
            'AL_NOTAPEDIDOWEB_PG.AL_UPD_CONTROL_REPROCESO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            'AL',
                            sn_cod_retorno || ' -- ' || sv_mens_retorno,
                            '1.0',
                            USER,
                            'AL_NOTAPEDIDOWEB_PG.AL_UPD_CONTROL_REPROCESO_PR',
                            lv_ssql,
                            SQLCODE,
                            lv_des_error
                           );
   END al_upd_control_reproceso_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_des_articulo_pr (
      en_cod_articulo   IN              al_articulos.cod_articulo%TYPE,
      sv_des_articulo   OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'SELECT des_articulo '
         || 'FROM   al_articulos '
         || 'WHERE  cod_articulo = '
         || en_cod_articulo;

      SELECT des_articulo
        INTO sv_des_articulo
        FROM al_articulos
       WHERE cod_articulo = en_cod_articulo;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 900025;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Articulo no Existe
         lv_des_error :=
                     'AL_NOTAPEDIDOWEB_PG.AL_DES_ARTICULO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_DES_ARTICULO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                     'AL_NOTAPEDIDOWEB_PG.AL_DES_ARTICULO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl (sn_num_evento,
                                    'AL',
                                    sn_cod_retorno || ' -- '
                                    || sv_mens_retorno,
                                    '1.0',
                                    USER,
                                    'AL_NOTAPEDIDOWEB_PG.AL_DES_ARTICULO_PR',
                                    lv_ssql,
                                    SQLCODE,
                                    lv_des_error
                                   );
   END al_des_articulo_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_des_estado_pedido_pr (
      en_cod_pedido     IN              npt_estado_pedido.cod_pedido%TYPE,
      sn_cod_estado     OUT NOCOPY      npd_estado_flujo.cod_estado_flujo%TYPE,
      sv_des_estado     OUT NOCOPY      npd_estado_flujo.des_estado_flujo%TYPE,
      sv_esok           OUT NOCOPY      VARCHAR,
      sc_errores        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      ln_count       NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      sv_esok:='SI';
      lv_ssql :=
            'SELECT c.des_estado_flujo, c.cod_estado_flujo '
         || 'FROM   npt_estado_pedido b, npd_estado_flujo c '
         || 'WHERE  b.cod_pedido = '
         || en_cod_pedido
         || ' '
         || 'AND    b.cod_estado_flujo = c.cod_estado_flujo '
         || 'AND    b.cod_estado_flujo =(SELECT MAX(a.cod_estado_flujo) '
         || '                            FROM   npt_estado_pedido a '
         || '                            WHERE  b.cod_pedido = a.cod_pedido )';

      SELECT c.des_estado_flujo, c.cod_estado_flujo
        INTO sv_des_estado, sn_cod_estado
        FROM npt_estado_pedido b, npd_estado_flujo c
       WHERE b.cod_pedido = en_cod_pedido
         AND b.cod_estado_flujo = c.cod_estado_flujo
         AND b.cod_estado_flujo = (SELECT MAX (a.cod_estado_flujo)
                                     FROM npt_estado_pedido a
                                    WHERE a.cod_pedido = b.cod_pedido);

      IF sn_cod_estado <= cn_pedido_despachador
      THEN
      
       --SELECT count(1) into ln_count
       --FROM np_validacion_series_to a
       --WHERE a.cod_pedido = en_cod_pedido;
       
       SELECT count(1) into ln_count
       FROM   np_val_series_temp_to a
       WHERE  a.cod_pedido = en_cod_pedido;      
      
      IF ln_count > 0 then 
        sv_esok:='NO';
      
      ELSE
        sv_esok:='PR';
      end if;
      
            --OPEN sc_errores FOR
            --  SELECT a.num_serie, b.des_error
            --     FROM np_validacion_series_to a, np_errores_series_td b
            --    WHERE a.cod_pedido = en_cod_pedido
            --      AND b.cod_error = a.cod_error;
            
             OPEN sc_errores FOR
               SELECT a.num_serie, b.des_error
                 FROM np_val_series_temp_to a, np_errores_series_td b
                WHERE a.cod_pedido = en_cod_pedido
                  AND b.cod_error = a.cod_error;      
                                                                            
      END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 900026;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         sv_esok:='NO';
         
         lv_des_error :=
                'AL_NOTAPEDIDOWEB_PG.AL_DES_ESTADO_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                               (sn_num_evento,
                                'AL',
                                sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                '1.0',
                                USER,
                                'AL_NOTAPEDIDOWEB_PG.AL_DES_ESTADO_PEDIDO_PR',
                                lv_ssql,
                                SQLCODE,
                                lv_des_error
                               );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;
         
         sv_esok:='NO';
         
         lv_des_error :=
                'AL_NOTAPEDIDOWEB_PG.AL_DES_ESTADO_PEDIDO_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                               (sn_num_evento,
                                'AL',
                                sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                '1.0',
                                USER,
                                'AL_NOTAPEDIDOWEB_PG.AL_DES_ESTADO_PEDIDO_PR',
                                lv_ssql,
                                SQLCODE,
                                lv_des_error
                               );
   END al_des_estado_pedido_pr;

------------------------------------------------------------------------------------------------------
   PROCEDURE al_elimina_pedido_temp_pr (
      en_cod_pedido     IN              np_val_series_temp_to.cod_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_existe_pedido   NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      lv_ssql :=
            'DELETE np_val_series_temp_to '
         || 'WHERE cod_pedido = '
         || en_cod_pedido;

      DELETE np_val_series_temp_to
      WHERE cod_pedido = en_cod_pedido;
      
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 900009;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         --SV_mens_retorno := 'Error al Eliminar pedido de la tabla de Validacion de Series';
         lv_des_error :=
                   'AL_NOTAPEDIDOWEB_PG.AL_ELIMINA_PEDIDO_TEMP_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                  (sn_num_evento,
                                   'AL',
                                   sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                   '1.0',
                                   USER,
                                   'AL_NOTAPEDIDOWEB_PG.AL_ELIMINA_PEDIDO_TEMP_PR',
                                   lv_ssql,
                                   SQLCODE,
                                   lv_des_error
                                  );
   END al_elimina_pedido_temp_pr;   

------------------------------------------------------------------------------------------------------
   PROCEDURE al_inserta_pedido_temp_pr (
      en_cod_pedido     IN              np_validacion_series_to.cod_pedido%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      lv_ssql            ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      ln_existe_pedido   NUMBER;
   BEGIN
      sn_num_evento := 0;
      sv_mens_retorno := 'OK';
      sn_cod_retorno := 0;
      
      lv_ssql :=
            'INSERT INTO np_val_series_temp_to(cod_pedido, num_serie, cod_error) '
         || 'SELECT cod_pedido, num_serie, cod_error '
         || 'FROM   NP_VALIDACION_SERIES_TO '
         || 'WHERE  cod_pedido = '||en_cod_pedido||' '
         || 'AND    estado = ''ERROR''';

      INSERT INTO np_val_series_temp_to(cod_pedido, num_serie, cod_error)
      SELECT cod_pedido, num_serie, cod_error
      FROM   NP_VALIDACION_SERIES_TO
      WHERE  cod_pedido = en_cod_pedido
      AND    estado = 'ERROR';
      
   EXCEPTION
      WHEN OTHERS
      THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                   'AL_NOTAPEDIDOWEB_PG.AL_INSERTA_PEDIDO_TEMP_PR(); - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                  (sn_num_evento,
                                   'AL',
                                   sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                   '1.0',
                                   USER,
                                   'AL_NOTAPEDIDOWEB_PG.AL_INSERTA_PEDIDO_TEMP_PR',
                                   lv_ssql,
                                   SQLCODE,
                                   lv_des_error
                                  );
   END al_inserta_pedido_temp_pr;     
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
END al_notapedidoweb_pg;
/
SHOW ERRORS