CREATE OR REPLACE PACKAGE BODY ve_portabilidad_pg AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_val_numcelular_fn (
      ev_num_celular    IN              ga_celnum_reutil.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      cantnumero           NUMBER;
      error_numnoportado   EXCEPTION;
    error_numportado_null EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

    ssql := 'ev_num_celular = ['||ev_num_celular||']';
    IF (ev_num_celular IS NULL OR trim(ev_num_celular) = '') THEN
       RAISE error_numportado_null;
    END IF;

      ssql := 'SELECT COUNT (1)'
           || ' FROM ga_abocel a'
           || ' WHERE a.num_celular = '||ev_num_celular
         || ' AND a.cod_situacion NOT IN (''BAA'')'
         || ' UNION'
           || ' SELECT COUNT (1)'
           || ' FROM ga_aboamist a'
           || ' WHERE a.num_celular = '||ev_num_celular
         || ' AND a.cod_situacion NOT IN (''BAA'')';



  SELECT sum(CANT)
  INTO cantnumero
  FROM (
      SELECT COUNT (1) as cant
        FROM ga_abocel a
       WHERE a.num_celular = ev_num_celular
       AND a.cod_situacion NOT IN ('BAA')
     UNION
      SELECT COUNT (1)  as cant
        FROM ga_aboamist a
       WHERE a.num_celular = ev_num_celular
       AND a.cod_situacion NOT IN ('BAA') );

      IF cantnumero > 0 THEN
         RAISE error_numnoportado;
      END IF;

      RETURN TRUE;

   EXCEPTION
      WHEN error_numportado_null THEN
         sn_cod_retorno := '320011';
         sv_mens_retorno := 'Error el numero de celular portado no puede ser vacio o nulo - num_celular ['||ev_num_celular||']';
         v_des_error := 've_portabilidad_pg.ve_val_numcelular_fn (); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_numcelular_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN error_numnoportado THEN
         sn_cod_retorno := '310011';
         sv_mens_retorno := 'Error el numero se encuentra en las tablas de abonados - num_celular ['||ev_num_celular||']';
         v_des_error := 've_portabilidad_pg.ve_val_numcelular_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_numcelular_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '320012';
         sv_mens_retorno := 'Error no definido al buscar informacion del numero en las tablas de abonados  - num_celular ['||ev_num_celular||']';
         v_des_error := 've_portabilidad_pg.ve_val_numcelular_fn (); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_numcelular_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_val_numcelular_fn ;
--------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ve_num_simcard_I_fn (
      ev_num_celular    IN              ga_celnum_reutil.num_celular%TYPE,
    ev_num_serie      IN              al_series.num_serie%TYPE,
    ev_cod_central    IN              al_series.cod_central%TYPE,
    ev_cod_subalm     IN              al_series.cod_subalm%TYPE,
    ev_ind_proceq     IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      cantnumero           NUMBER;
      error_numnoportado   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

    IF (ev_ind_proceq != 'E') THEN
         ssql := 'SELECT COUNT (1)'
              || ' FROM al_series a'
              || ' WHERE a.num_serie = '||ev_num_serie
            || ' AND a.cod_estado = 1'
          || ' AND a.num_telefono IS NULL';

         SELECT COUNT (1)
           INTO cantnumero
           FROM al_series a
          WHERE a.num_serie = ev_num_serie
          AND a.cod_estado = 1
        AND a.num_telefono IS NULL;

         IF cantnumero < 1 THEN
            RAISE error_numnoportado;
         END IF;

          ssql := 'UPDATE al_series ';
       UPDATE al_series
            SET ind_telefono = 7,
            cod_cat = 89,
          cod_central = ev_cod_central,
          cod_subalm = ev_cod_subalm,
                num_telefono = ev_num_celular
          WHERE num_serie = ev_num_serie;
      END IF;

      ssql := 'delete ga_celnum_reutil';
        DELETE ga_celnum_reutil
         WHERE num_celular = ev_num_celular;


      RETURN TRUE;

   EXCEPTION
      WHEN error_numnoportado THEN
         sn_cod_retorno := '210011';
         sv_mens_retorno := 'Error no se encuentra la serie ['||ev_num_serie||']';
         v_des_error := 've_portabilidad_pg.ve_num_simcard_I_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_num_simcard_I_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '220012';
         sv_mens_retorno := 'Error no definido al buscar informacion del numero en la reutil';
         v_des_error := 've_portabilidad_pg.ve_num_simcard_I_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_num_simcard_I_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_num_simcard_I_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 FUNCTION ve_num_simcard_P_fn (
      ev_num_celular    IN              ga_celnum_reutil.num_celular%TYPE,
    ev_num_serie      IN              al_series.num_serie%TYPE,
    ev_cod_central    IN              al_series.cod_central%TYPE,
    ev_cod_subalm     IN              al_series.cod_subalm%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      cantnumero           NUMBER;
      error_numnoportado   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      ssql := 'SELECT COUNT (1)'
           || ' FROM al_series a'
           || ' WHERE a.num_serie = '||ev_num_serie
         || ' AND a.cod_estado = 1';

      SELECT COUNT (1)
        INTO cantnumero
        FROM al_series a
       WHERE a.num_serie = ev_num_serie
       AND a.cod_estado = 1
     AND a.num_telefono IS NULL;

      IF cantnumero < 1 THEN
         RAISE error_numnoportado;
      END IF;


   UPDATE al_series
         SET ind_telefono = 7,
             cod_cat = 89,
       cod_central = ev_cod_central,
       cod_subalm = ev_cod_subalm,
             num_telefono = ev_num_celular
       WHERE num_serie = ev_num_serie;

      RETURN TRUE;

   EXCEPTION
      WHEN error_numnoportado THEN
         sn_cod_retorno := '210011';
         sv_mens_retorno := 'Error la serie no se encuentra en la AL_SERIES';
         v_des_error := 've_portabilidad_pg.ve_num_simcard_P_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_num_simcard_P_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '220012';
         sv_mens_retorno := 'Error no definido al buscar serie en logistica';
         v_des_error := 've_portabilidad_pg.ve_num_simcard_P_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_num_simcard_P_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_num_simcard_P_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 FUNCTION ve_val_cel_reutil_I_fn (
      ev_num_celular    IN              ga_celnum_reutil.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      cantnumero           NUMBER;
      error_numnoportado   EXCEPTION;
    sv_valparametro      VARCHAR2(100);
    error_ejecucion      EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';


    ve_intermediario_pg.ve_obtiene_valor_parametro_pr ('FEC_REUTIL_PORTADO','GA',1,sv_valparametro,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
    IF sn_cod_retorno <> 0 THEN
       RAISE error_ejecucion;
    END IF;

      ssql := 'SELECT COUNT (1)'
           || ' FROM ga_celnum_reutil a'
           || ' WHERE a.num_celular = '||ev_num_celular
         || ' AND a.fec_baja =  to_date('||sv_valparametro||',''DD-MM-YYYY HH24:MI:SS'')';

      SELECT COUNT (1)
        INTO cantnumero
        FROM ga_celnum_reutil a
       WHERE a.num_celular = ev_num_celular
       AND a.fec_baja =  to_date(sv_valparametro,'DD-MM-YYYY HH24:MI:SS');

      IF cantnumero < 1 THEN
         RAISE error_numnoportado;
      END IF;

      RETURN TRUE;

   EXCEPTION
    WHEN error_ejecucion THEN
         v_des_error := 've_portabilidad_pg.ve_val_cel_reutil_I_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_cel_reutil_I_fn', ssql, SQLCODE, v_des_error);
      WHEN error_numnoportado THEN
         sn_cod_retorno := '210011';
         sv_mens_retorno := 'Error el numero no se encuentra la tabla de reutil - ['||cantnumero||'] ['||ev_num_celular||']';
         v_des_error := 've_portabilidad_pg.ve_val_cel_reutil_I_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_cel_reutil_I_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '220012';
         sv_mens_retorno := 'Error no definido al buscar informacion del numero en la reutil';
         v_des_error := 've_portabilidad_pg.ve_val_cel_reutil_I_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_cel_reutil_I_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_val_cel_reutil_I_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 FUNCTION ve_val_cel_reutil_P_fn (
      ev_num_celular    IN              ga_celnum_reutil.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      cantnumero           NUMBER;
      error_numnoportado   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql := 'SELECT count(1)' || ' FROM al_series a' || ' WHERE a.num_serie = ev_num_serie';

      SELECT COUNT (1)
        INTO cantnumero
        FROM ga_celnum_reutil a
       WHERE a.num_celular = ev_num_celular;

      IF cantnumero > 1 THEN
         RAISE error_numnoportado;
      END IF;

    SELECT COUNT (1)
      INTO cantnumero
        FROM ga_reserva  a
       WHERE a.num_celular = ev_num_celular;

    IF cantnumero > 1 THEN
         RAISE error_numnoportado;
      END IF;

      SELECT COUNT (1)
    INTO cantnumero
        FROM ga_celnum_uso a
       WHERE ev_num_celular BETWEEN a.NUM_DESDE AND a.NUM_HASTA
         AND num_siguiente = ev_num_celular;

      IF cantnumero > 1 THEN
         RAISE error_numnoportado;
      END IF;

      RETURN TRUE;

   EXCEPTION
      WHEN error_numnoportado THEN
         sn_cod_retorno := '220011';
         sv_mens_retorno := 'Error el numero se encuentra la tabla de reutil';
         v_des_error := 've_portabilidad_pg.ve_val_cel_reutil_P_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_cel_reutil_P_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '230012';
         sv_mens_retorno := 'Error no definido al buscar informacion del numero en la reutil';
         v_des_error := 've_portabilidad_pg.ve_val_cel_reutil_P_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_cel_reutil_P_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_val_cel_reutil_P_fn;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_val_imei_interno_fn (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      cantserie            NUMBER;
      error_serieinterna   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql := 'SELECT count(1)' || ' FROM al_series a' || ' WHERE a.num_serie = ev_num_serie';

      SELECT COUNT (1)
        INTO cantserie
        FROM al_series a
       WHERE a.num_serie = ev_num_serie;

      IF cantserie > 0 THEN
         RAISE error_serieinterna;
      END IF;

      RETURN TRUE;

   EXCEPTION
      WHEN error_serieinterna THEN
         sn_cod_retorno := '200011';
         sv_mens_retorno := 'Error Serie registra informacion en almacen';
         v_des_error := 've_portabilidad_pg.ve_val_imei_interno_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_imei_interno_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '200012';
         sv_mens_retorno := 'Error no definido al buscar informacion de serie en almacen';
         v_des_error := 've_portabilidad_pg.ve_val_imei_interno_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_imei_interno_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_val_imei_interno_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_val_listas_negras_imei_fn (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      cantserie            NUMBER;
      error_listasnegras   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      SELECT COUNT (1)
        INTO cantserie
        FROM ga_lncelu
       WHERE num_serie = ev_num_serie;

      IF cantserie > 0 THEN
         RAISE error_listasnegras;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_listasnegras THEN
         sn_cod_retorno := '200013';
         sv_mens_retorno := 'Error la serie se encuentras en listas negras';
         v_des_error := 've_portabilidad_pg.ve_val_listas_negras_imei_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_listas_negras_imei_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '200014';
         sv_mens_retorno := 'Error no es posible validar la serie en listas negras';
         v_des_error := 've_portabilidad_pg.ve_val_listas_negras_imei_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_listas_negras_imei_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_val_listas_negras_imei_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_val_repeticion_imei_fn (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error        ge_errores_pg.desevent;
      ssql               ge_errores_pg.vquery;
      can_imei           NUMBER;
      can_repeticion     VARCHAR2 (10);
      error_repeticion   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      SELECT COUNT (1)
        INTO can_imei
        FROM (SELECT 1
                FROM ga_abocel
               WHERE num_imei = ev_num_serie AND cod_situacion NOT IN ('BAA', 'BAP') AND cod_uso <> 3
              UNION ALL
              SELECT 1
                FROM ga_aboamist
               WHERE num_imei = ev_num_serie AND cod_situacion NOT IN ('BAA', 'BAP'));

      SELECT val_parametro
        INTO can_repeticion
        FROM ged_parametros
       WHERE nom_parametro = 'NUM_REPETICION_IMEI' AND cod_modulo = 'GA' AND cod_producto = 1;

      IF can_imei > TO_NUMBER (can_repeticion) THEN
         RAISE error_repeticion;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_repeticion THEN
         sn_cod_retorno := '200015';
         sv_mens_retorno := 'Error la serie ya esta habilitada en otro aboando';
         v_des_error := 've_portabilidad_pg.ve_val_repeticion_imei_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_repeticion_imei_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '200016';
         sv_mens_retorno := 'Error no es posible validar la repeticion de la serie en abonados';
         v_des_error := 've_portabilidad_pg.ve_val_repeticion_imei_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_repeticion_imei_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_val_repeticion_imei_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_val_formato_imei_fn (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      v_des_error           ge_errores_pg.desevent;
      ssql                  ge_errores_pg.vquery;
      v_table_name          VARCHAR2 (45);
      v_serie1a14           VARCHAR2 (20);
      v_serie15             VARCHAR2 (2);
      v_retorno             VARCHAR2 (20);
      error_largo_serie     EXCEPTION;
      error_formato_serie   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      IF LENGTH (ev_num_serie) = 15 THEN
         v_serie1a14 := SUBSTR (ev_num_serie, 1, 14);
         v_serie15 := SUBSTR (ev_num_serie, 15);

         IF v_serie15 != '0' THEN
            v_retorno := ge_fn_luhn (v_serie1a14);

            IF v_serie15 != v_retorno THEN
               RAISE error_formato_serie;
            END IF;
         END IF;
      ELSE
         RAISE error_largo_serie;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN error_largo_serie THEN
         sn_cod_retorno := '200017';
         sv_mens_retorno := 'Error en el largo de la serie';
         v_des_error := 've_portabilidad_pg.ve_val_formato_imei_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_formato_imei_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN error_formato_serie THEN
         sn_cod_retorno := '200018';
         sv_mens_retorno := 'Error en el formato de la serie';
         v_des_error := 've_portabilidad_pg.ve_val_formato_imei_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_formato_imei_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := '200019';
         sv_mens_retorno := 'Error no es posible validar el formato de la serie';
         v_des_error := 've_portabilidad_pg.ve_val_formato_imei_fn(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_formato_imei_fn', ssql, SQLCODE, v_des_error);
         RETURN FALSE;
   END ve_val_formato_imei_fn;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_central_pr (
      ev_cod_celda      IN              ge_celdas.cod_celda%TYPE,
      sc_centrales      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) AS
      can_centrales        NUMBER;
      v_des_error          ge_errores_pg.desevent;
      ssql                 ge_errores_pg.vquery;
      error_cant_central   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql :=
         'SELECT cod_central, e.nom_central , c.cod_subalm' || ' FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e' || ' WHERE b.cod_celda = ' || ev_cod_celda || ' AND c.cod_subalm = b.cod_subalm' || ' AND d.cod_alm = c.cod_alm'
         || ' AND e.cod_alm = d.cod_alm' || ' AND e.cod_producto = 1';

      OPEN sc_centrales FOR
         SELECT cod_central, e.nom_central, c.cod_subalm
           FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e
          WHERE b.cod_celda = ev_cod_celda AND c.cod_subalm = b.cod_subalm AND d.cod_alm = c.cod_alm AND e.cod_alm = d.cod_alm AND e.cod_producto = 1;

      ssql :=
         'SELECT count(1)' || ' FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e' || ' WHERE b.cod_celda = ' || ev_cod_celda || ' AND c.cod_subalm = b.cod_subalm' || ' AND d.cod_alm = c.cod_alm' || ' AND e.cod_alm = d.cod_alm'
         || ' AND e.cod_producto = 1';

      SELECT COUNT (1)
        INTO can_centrales
        FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e
       WHERE b.cod_celda = ev_cod_celda AND c.cod_subalm = b.cod_subalm AND d.cod_alm = c.cod_alm AND e.cod_alm = d.cod_alm AND e.cod_producto = 1;

      IF (can_centrales < 1) THEN
         RAISE error_cant_central;
      END IF;
   EXCEPTION
      WHEN error_cant_central THEN
         sn_cod_retorno := '200020';
         sv_mens_retorno := 'Error no existen centrales';
         v_des_error := 've_portabilidad_pg.ve_rec_central_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_central_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200021';
         sv_mens_retorno := 'Error no posible recuperar centrales';
         v_des_error := 've_portabilidad_pg.ve_rec_central_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_central_pr', ssql, SQLCODE, v_des_error);
   END ve_rec_central_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_imei_pr (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) AS
      v_des_error       ge_errores_pg.desevent;
      ssql              ge_errores_pg.vquery;
      error_no_data     EXCEPTION;
      error_ejecucion   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      IF NOT (ve_val_imei_interno_fn (ev_num_serie, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ve_val_listas_negras_imei_fn (ev_num_serie, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ve_val_repeticion_imei_fn (ev_num_serie, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (ve_val_formato_imei_fn (ev_num_serie, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;
   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error := 've_portabilidad_pg.ve_val_imei_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_imei_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200022';
         sv_mens_retorno := 'Error no definido al validar IMEI';
         v_des_error := 've_portabilidad_pg.ve_val_imei_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_imei_pr', ssql, SQLCODE, v_des_error);
   END ve_val_imei_pr;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_tip_contrato_pr (
      ev_cod_tipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      sn_cod_producto      OUT NOCOPY      ga_tipcontrato.cod_producto%TYPE,
      sv_cod_tipcontrato   OUT NOCOPY      ga_tipcontrato.cod_tipcontrato%TYPE,
      sv_des_tipcontrato   OUT NOCOPY      ga_tipcontrato.des_tipcontrato%TYPE,
      sv_ind_contseg       OUT NOCOPY      ga_tipcontrato.ind_contseg%TYPE,
      sv_ind_contcel       OUT NOCOPY      ga_tipcontrato.ind_contcel%TYPE,
      sn_ind_comodato      OUT NOCOPY      ga_tipcontrato.ind_comodato%TYPE,
      sn_canal_vta         OUT NOCOPY      ga_tipcontrato.canal_vta%TYPE,
      sn_meses_minimo      OUT NOCOPY      ga_tipcontrato.meses_minimo%TYPE,
      sv_ind_procequi      OUT NOCOPY      ga_tipcontrato.ind_procequi%TYPE,
      sv_ind_preciolista   OUT NOCOPY      ga_tipcontrato.ind_preciolista%TYPE,
      sv_ind_gmc           OUT NOCOPY      ga_tipcontrato.ind_gmc%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      can_registros   NUMBER;
      error_no_data   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql :=
         'SELECT SELECT cod_producto, cod_tipcontrato, des_tipcontrato, ind_contseg, ind_contcel,' || ' ind_comodato, canal_vta, meses_minimo, ind_procequi, ind_preciolista, ind_gmc' || ' FROM ga_tipcontrato'
         || ' WHERE SYSDATE BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)' || ' AND cod_tipcontrato = ' || ev_cod_tipcontrato || ' AND cod_producto = 1';

      SELECT cod_producto, cod_tipcontrato, des_tipcontrato, ind_contseg, ind_contcel, ind_comodato, canal_vta, meses_minimo, ind_procequi, ind_preciolista, ind_gmc
        INTO sn_cod_producto, sv_cod_tipcontrato, sv_des_tipcontrato, sv_ind_contseg, sv_ind_contcel, sn_ind_comodato, sn_canal_vta, sn_meses_minimo, sv_ind_procequi, sv_ind_preciolista, sv_ind_gmc
        FROM ga_tipcontrato
       WHERE SYSDATE BETWEEN fec_desde AND NVL (fec_hasta, SYSDATE) AND cod_tipcontrato = ev_cod_tipcontrato AND cod_producto = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := '200026';
         sv_mens_retorno := 'Error no existen tipo de contrato';
         v_des_error := 've_portabilidad_pg.ve_val_rago_operadora_scl_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_rago_operadora_scl_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200027';
         sv_mens_retorno := 'Error no definido al recuperar tipo de contrato';
         v_des_error := 've_portabilidad_pg.ve_val_rago_operadora_scl_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_rago_operadora_scl_pr', ssql, SQLCODE, v_des_error);
   END ve_tip_contrato_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_rago_operadora_scl_pr (
      ev_num_celuar     IN              ta_numnacional.num_tdesde%TYPE,
      tip_numero        OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      can_registros   NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql :=
         'SELECT COUNT(1)' || ' FROM ta_operadores a, ta_numnacional b' || ' WHERE a.cod_dope = ''P''' || ' AND a.cod_tope = ''P''' || ' AND b.cod_dope = a.cod_dope' || ' AND b.cod_operador = a.cod_operador' || ' AND ' || ev_num_celuar
         || ' BETWEEN b.num_tdesde AND b.num_thasta';

      SELECT COUNT (1)
        INTO can_registros
        FROM tol_rannume_td b
       WHERE b.cod_oper IN (SELECT cod_valor
                            FROM ged_codigos
               WHERE nom_tabla = 'TA_OPERADORES'
                 AND nom_columna = 'COD_OPERADOR'
                )
     AND ev_num_celuar BETWEEN b.num_lini AND b.num_linf;

      IF (can_registros > 0) THEN
         tip_numero := 'I';
      ELSE
         tip_numero := 'E';
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := '200028';
         sv_mens_retorno := 'Error no definido al validar rango Operadora SCL';
         v_des_error := 've_portabilidad_pg.ve_val_rago_operadora_scl_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_rago_operadora_scl_pr', ssql, SQLCODE, v_des_error);
   END ve_val_rago_operadora_scl_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_icc_automatica_pr (
      en_cod_bodega     IN              al_series.cod_bodega%TYPE,
      en_tip_stock      IN              al_series.tip_stock%TYPE,
      en_cod_articulo   IN              al_series.cod_articulo%TYPE,
      en_cod_uso        IN              al_series.cod_uso%TYPE,
      ev_num_serie      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
   IS
      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
    num_mov         VARCHAR2(10);
    error_ejecucion EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql := 'SELECT num_serie' || ' FROM al_series a' || ' WHERE a.cod_bodega = ' || en_cod_bodega || ' AND a.tip_stock = ' || en_tip_stock || ' AND a.cod_articulo = ' || en_cod_articulo || ' AND a.cod_estado = 1' || ' AND ROWNUM < 2';

      SELECT num_serie
        INTO ev_num_serie
        FROM al_series a
       WHERE a.cod_bodega = en_cod_bodega
       AND a.tip_stock = en_tip_stock
     AND a.cod_articulo = en_cod_articulo
     AND a.cod_uso = en_cod_uso
     AND a.cod_estado = 1
     AND ROWNUM < 2;

    al_series_portabilidad_pg.al_reserva_series_pr(ev_num_serie,user,1,num_mov,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
    IF sn_cod_retorno <> 0 THEN
       RAISE error_ejecucion;
    END IF;

   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error := 've_portabilidad_pg.ve_rec_icc_automatica_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_icc_automatica_pr', ssql, SQLCODE, v_des_error);
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := '200029';
         sv_mens_retorno := 'Error no existen SimCard  automatica';
         v_des_error := 've_portabilidad_pg.ve_rec_icc_automatica_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_icc_automatica_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200030';
         sv_mens_retorno := 'Error no definido recuperar SimCard automatica';
         v_des_error := 've_portabilidad_pg.ve_rec_icc_automatica_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_icc_automatica_pr', ssql, SQLCODE, v_des_error);
   END ve_rec_icc_automatica_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_bodegas_vendedor_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sc_bodegas        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      v_des_error           ge_errores_pg.desevent;
      ssql                  ge_errores_pg.vquery;
      can_bodegas           NUMBER;
      error_no_data_found   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql := 'SELECT b.cod_bodega, b.des_bodega' || ' FROM ve_vendalmac a, al_bodegas b' || ' WHERE a.cod_vendedor = ' || en_cod_vendedor || ' AND a.cod_bodega = b.cod_bodega';

      OPEN sc_bodegas FOR
         SELECT b.cod_bodega, b.des_bodega
           FROM ve_vendalmac a, al_bodegas b
          WHERE a.cod_vendedor = en_cod_vendedor AND a.cod_bodega = b.cod_bodega;

      SELECT COUNT (1)
        INTO can_bodegas
        FROM ve_vendalmac a, al_bodegas b
       WHERE a.cod_vendedor = en_cod_vendedor AND a.cod_bodega = b.cod_bodega;

      IF can_bodegas < 1 THEN
         RAISE error_no_data_found;
      END IF;
   EXCEPTION
      WHEN error_no_data_found THEN
         sn_cod_retorno := '200031';
         sv_mens_retorno := 'Error no existen Bodegas para el vendedor';
         v_des_error := 've_portabilidad_pg.ve_rec_bodegas_vendedor_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_bodegas_vendedor_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200032';
         sv_mens_retorno := 'Error no definido al recueprar Bodegas para el vendedor';
         v_des_error := 've_portabilidad_pg.ve_rec_bodegas_vendedor_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_bodegas_vendedor_pr', ssql, SQLCODE, v_des_error);
   END ve_rec_bodegas_vendedor_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_cargos_sim_pre_pr (
      sc_cargos_sim     OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      v_des_error           ge_errores_pg.desevent;
      ssql                  ge_errores_pg.vquery;
      can_bodegas           NUMBER;
      error_no_data_found   EXCEPTION;
      v_parametro1          ged_parametros.val_parametro%TYPE;
      v_parametro2          ged_parametros.val_parametro%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      SELECT val_parametro
        INTO v_parametro1
        FROM ged_parametros
       WHERE nom_parametro = 'CONC_SIM_ACTIVACION' AND cod_modulo = 'VE';

      SELECT val_parametro
        INTO v_parametro2
        FROM ged_parametros
       WHERE nom_parametro = 'CONC_SIM_TIEPOAIRE' AND cod_modulo = 'VE';

      IF (v_parametro1 IS NULL OR TRIM (v_parametro1) = '') THEN
         v_parametro1 := 'NULL';
      END IF;

      IF (v_parametro2 IS NULL OR TRIM (v_parametro2) = '') THEN
         v_parametro2 := 'NULL';
      END IF;

      ssql :=
         'SELECT round(b.imp_tarifa,2), a.cod_concepto, b.cod_moneda' || ' FROM ga_actuaserv a, ga_tarifas b, ga_servicios c, ge_monedas d' || ' WHERE a.cod_producto = 1' || ' AND a.cod_actabo = ''AM''' || ' AND a.cod_tipserv = ''1'''
         || ' AND b.cod_producto = a.cod_producto' || ' AND b.cod_actabo = a.cod_actabo' || ' AND b.cod_tipserv = a.cod_tipserv' || ' AND b.cod_servicio = a.cod_servicio' || ' AND b.cod_planserv = ''03'''
         || ' AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE)' || ' AND c.cod_producto = a.cod_producto' || ' AND c.cod_servicio = a.cod_servicio' || ' AND d.cod_moneda = b.cod_moneda' || ' AND b.imp_tarifa > 0' || ' AND cod_concepto in ('
         || v_parametro1 || ',' || v_parametro2 || ')';

      OPEN sc_cargos_sim FOR ssql;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := '200034';
         sv_mens_retorno := 'Error no definido al recueprar conceptos simcard prepago';
         v_des_error := 've_portabilidad_pg.ve_rec_cargos_sim_pre_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_cargos_sim_pre_pr', ssql, SQLCODE, v_des_error);
   END ve_rec_cargos_sim_pre_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_plan_imp_pre_pr (
      ev_plantarifario     IN              VARCHAR2,
      ev_cod_vendedor      IN              VARCHAR2,
      sv_cod_plantarif     OUT NOCOPY      VARCHAR2,
      sv_des_plantarif     OUT NOCOPY      VARCHAR2,
      sv_cod_cargobasico   OUT NOCOPY      VARCHAR2,
      sv_des_cargobasico   OUT NOCOPY      VARCHAR2,
      sn_imp_cargobasico   OUT NOCOPY      NUMBER,
      sn_valorimpuesto     OUT NOCOPY      NUMBER,
      sn_total             OUT NOCOPY      NUMBER,
      sn_impuesto          OUT NOCOPY      NUMBER,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      v_des_error           ge_errores_pg.desevent;
      ssql                  ge_errores_pg.vquery;
      can_bodegas           NUMBER;
      error_no_data_found   EXCEPTION;
      v_parametro           ged_parametros.val_parametro%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      SELECT a.cod_plantarif, a.des_plantarif, b.cod_cargobasico, b.des_cargobasico, b.imp_cargobasico,
          b.imp_cargobasico * (ve_portabilidad_impuesto_pg.ve_obtenerimpuesto_clie_fn(ev_cod_vendedor) - 1) AS valorimpuesto,
             b.imp_cargobasico * ve_portabilidad_impuesto_pg.ve_obtenerimpuesto_clie_fn (ev_cod_vendedor) AS total, (ve_portabilidad_impuesto_pg.ve_obtenerimpuesto_clie_fn (ev_cod_vendedor) - 1) * 100 AS impuesto
        INTO sv_cod_plantarif, sv_des_plantarif, sv_cod_cargobasico, sv_des_cargobasico, sn_imp_cargobasico, sn_valorimpuesto,
             sn_total, sn_impuesto
        FROM ta_plantarif a, ta_cargosbasico b
       WHERE b.cod_cargobasico = a.cod_cargobasico AND b.cod_producto = 1 AND a.cod_plantarif = ev_plantarifario AND a.cla_plantarif <> 'SRV' AND SYSDATE BETWEEN b.fec_desde AND b.fec_hasta AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := '200035';
         sv_mens_retorno := 'Error al recuperar plan, cargo basico e impuesto';
         v_des_error := 've_portabilidad_pg.ve_rec_plan_imp_pre_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_plan_imp_pre_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200036';
         sv_mens_retorno := 'Error no definido al recuperar plan, cargo basico e impuesto';
         v_des_error := 've_portabilidad_pg.ve_rec_plan_imp_pre_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_plan_imp_pre_pr', ssql, SQLCODE, v_des_error);
   END ve_rec_plan_imp_pre_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_datos_abo_pr (
      so_abonado        IN OUT NOCOPY   GA_ABONADO_PORTAB_QT,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "GA_CONS_DATOS_ABO_MIST_PR
       Lenguaje="PL/SQL"
       Fecha="04-06-2007"
       Versión="La del package"
       Diseñador="Matías Guajardo"
       Programador="Matías Guajardo"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
          </Entrada>
          <Salida>
             <param nom="SO_Abonado" Tipo="estructura">estructura de los datos de un abonado</param>>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
      lv_des_error        ge_errores_pg.desevent;
      lv_ssql             ge_errores_pg.vquery;
      error_num_abonado   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := ' ';
      sn_num_evento := 0;
      lv_ssql := lv_ssql || 'SELECT a.cod_cliente,b.num_abonado,b.num_celular,b.num_serie,b.num_imei,b.cod_tecnologia,b.cod_situacion,';
      lv_ssql := lv_ssql || '   d.des_situacion,';
      lv_ssql := lv_ssql || '   b.tip_plantarif,';
      lv_ssql := lv_ssql || '   DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
      lv_ssql := lv_ssql || '   b.cod_plantarif,';
      lv_ssql := lv_ssql || '   c.des_plantarif,';
      lv_ssql := lv_ssql || '   b.cod_ciclo,';
      lv_ssql := lv_ssql || '   c.cod_limconsumo,';
      lv_ssql := lv_ssql || '   e.des_limconsumo,';
      lv_ssql := lv_ssql || '   b.cod_planserv,';
      lv_ssql := lv_ssql || '   b.cod_uso,';
      lv_ssql := lv_ssql || '   c.cod_tiplan,';
      lv_ssql := lv_ssql || '   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
      lv_ssql := lv_ssql || '   b.cod_tipcontrato,b.fec_alta,b.fec_fincontra,b.ind_eqprestado,b.fec_prorroga,c.flg_rango,f.imp_cargobasico,';
      lv_ssql := lv_ssql || '   b.num_anexo,';
      lv_ssql := lv_ssql || '   b.cod_usuario,';
      lv_ssql := lv_ssql || '   b.tip_terminal,';
      lv_ssql := lv_ssql || '   g.des_terminal,';
      lv_ssql := lv_ssql || '   b.num_venta';
      lv_ssql := lv_ssql || ' FROM ge_clientes a,';
      lv_ssql := lv_ssql || '   ga_abocel b,';
      lv_ssql := lv_ssql || '   ta_plantarif c,';
      lv_ssql := lv_ssql || '   ga_situabo d,';
      lv_ssql := lv_ssql || '   ta_limconsumo e,';
      lv_ssql := lv_ssql || '   ta_cargosbasico f';
      lv_ssql := lv_ssql || '   al_tipos_terminales g';
      lv_ssql := lv_ssql || ' WHERE b.num_abonado = ' || so_abonado.num_celular;
      lv_ssql := lv_ssql || '   AND a.cod_cliente   = b.cod_cliente';
      lv_ssql := lv_ssql || '   AND b.cod_plantarif = c.cod_plantarif';
      lv_ssql := lv_ssql || '   AND b.cod_situacion = d.cod_situacion';
      lv_ssql := lv_ssql || '   AND e.cod_limconsumo = c.cod_limconsumo';
      lv_ssql := lv_ssql || '   AND c.cod_cargobasico = f.cod_cargobasico';
      lv_ssql := lv_ssql || '   AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
      lv_ssql := lv_ssql || '   AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
      lv_ssql := lv_ssql || '   AND g.cod_producto = b.cod_producto';
      lv_ssql := lv_ssql || '   AND g.tip_terminal = b.tip_terminal';
      lv_ssql := lv_ssql || '   AND rownum=1';
      lv_ssql := lv_ssql || ' UNION';
      lv_ssql := lv_ssql || ' SELECT a.cod_cliente,';
      lv_ssql := lv_ssql || '   b.num_abonado,';
      lv_ssql := lv_ssql || '   b.num_celular,';
      lv_ssql := lv_ssql || '   b.num_serie,';
      lv_ssql := lv_ssql || '   b.num_imei,';
      lv_ssql := lv_ssql || '   b.cod_tecnologia,';
      lv_ssql := lv_ssql || '   b.cod_situacion,';
      lv_ssql := lv_ssql || '   d.des_situacion,';
      lv_ssql := lv_ssql || '   b.tip_plantarif,';
      lv_ssql := lv_ssql || '   DECODE(b.tip_plantarif,''E'',''EMPRESA'', ''I'', ''INDIVIDUAL'') AS des_tipplantarif,';
      lv_ssql := lv_ssql || '   b.cod_plantarif,';
      lv_ssql := lv_ssql || '   c.des_plantarif,';
      lv_ssql := lv_ssql || '   b.cod_ciclo,';
      lv_ssql := lv_ssql || '   c.cod_limconsumo,';
      lv_ssql := lv_ssql || '   e.des_limconsumo,';
      lv_ssql := lv_ssql || '   b.cod_planserv,';
      lv_ssql := lv_ssql || '   b.cod_uso,';
      lv_ssql := lv_ssql || '   c.cod_tiplan,';
      lv_ssql := lv_ssql || '   DECODE(c.cod_tiplan,''1'',''PREPAGO'', ''2'', ''POSPAGO'', ''3'', ''HIBRIDO'') AS des_tiplan,';
      lv_ssql := lv_ssql || '   b.cod_tipcontrato,';
      lv_ssql := lv_ssql || '   b.fec_alta,';
      lv_ssql := lv_ssql || '   b.fec_fincontra,';
      lv_ssql := lv_ssql || '   null ind_eqprestado,';
      lv_ssql := lv_ssql || '   null fec_prorroga,';
      lv_ssql := lv_ssql || '   c.flg_rango,';
      lv_ssql := lv_ssql || '   f.imp_cargobasico,';
      lv_ssql := lv_ssql || '   b.num_anexo,';
      lv_ssql := lv_ssql || '   b.cod_usuario,';
      lv_ssql := lv_ssql || '   b.tip_terminal,';
      lv_ssql := lv_ssql || '   g.des_terminal,';
      lv_ssql := lv_ssql || '   b.num_venta';
      lv_ssql := lv_ssql || ' FROM ge_clientes a,';
      lv_ssql := lv_ssql || '   ga_aboamist b,';
      lv_ssql := lv_ssql || '   ta_plantarif c,';
      lv_ssql := lv_ssql || '   ga_situabo d,';
      lv_ssql := lv_ssql || '   ta_limconsumo e,';
      lv_ssql := lv_ssql || '   ta_cargosbasico f,';
      lv_ssql := lv_ssql || '   al_tipos_terminales g';
      lv_ssql := lv_ssql || ' WHERE b.num_abonado = ' || so_abonado.num_celular;
      lv_ssql := lv_ssql || '  AND a.cod_cliente   = b.cod_cliente';
      lv_ssql := lv_ssql || '  AND b.cod_plantarif = c.cod_plantarif';
      lv_ssql := lv_ssql || '  AND b.cod_situacion = d.cod_situacion';
      lv_ssql := lv_ssql || '  AND e.cod_limconsumo = c.cod_limconsumo';
      lv_ssql := lv_ssql || '  AND c.cod_cargobasico = f.cod_cargobasico';
      lv_ssql := lv_ssql || '  AND b.cod_situacion NOT IN (''BAA'',''BAP'')';
      lv_ssql := lv_ssql || '  AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta';
      lv_ssql := lv_ssql || '  AND g.cod_producto = b.cod_producto';
      lv_ssql := lv_ssql || '  AND g.tip_terminal = b.tip_terminal';
      lv_ssql := lv_ssql || '  AND rownum=1';

      SELECT a.cod_cliente, b.num_abonado, b.num_celular, b.num_serie, b.num_imei, b.cod_tecnologia, b.cod_situacion, d.des_situacion, b.tip_plantarif,
             DECODE (b.tip_plantarif, 'E', 'EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif, b.cod_plantarif, c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, e.des_limconsumo, b.cod_planserv, b.cod_uso, c.cod_tiplan,
             DECODE (c.cod_tiplan, '1', 'PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan, b.cod_tipcontrato, b.fec_alta, b.fec_fincontra, b.ind_eqprestado, b.fec_prorroga, f.imp_cargobasico, b.num_anexo, b.cod_usuario,
             b.tip_terminal, g.des_terminal, b.num_venta, b.cod_cuenta, b.cod_subcuenta, b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen,
             b.fec_ultmod, b.cod_empresa, b.fec_acepventa, b.num_contrato, b.cod_modventa, b.cod_cargobasico, b.cod_central, DECODE (b.ind_disp, NULL, -1), u.nom_usuario || ' ' || u.nom_apellido1 || ' ' || u.nom_apellido2,
             NVL (b.cod_vendealer, 0)
        INTO so_abonado.cod_cliente, so_abonado.num_abonado, so_abonado.num_celular, so_abonado.num_serie, so_abonado.num_simcard, so_abonado.cod_tecnologia, so_abonado.cod_situacion, so_abonado.des_situacion, so_abonado.tip_plantarif,
             so_abonado.des_tipplantarif, so_abonado.cod_plantarif, so_abonado.des_plantarif, so_abonado.cod_ciclo, so_abonado.cod_limconsumo, so_abonado.des_limconsumo, so_abonado.cod_planserv, so_abonado.cod_uso, so_abonado.cod_tiplan,
             so_abonado.des_tiplan, so_abonado.cod_tipcontrato, so_abonado.fecha_alta, so_abonado.fec_fincontra, so_abonado.ind_eqprestado, so_abonado.fecha_prorroga, so_abonado.imp_cargobasico, so_abonado.num_anexo, so_abonado.cod_usuario,
             so_abonado.tip_terminal, so_abonado.des_terminal, so_abonado.num_venta, so_abonado.cod_cuenta, so_abonado.cod_subcuenta, so_abonado.cod_vendedor, so_abonado.cod_causa_venta, so_abonado.fecha_baja, so_abonado.fecha_bajacen,
             so_abonado.fecha_ultmod, so_abonado.cod_empresa, so_abonado.fecha_acepventa, so_abonado.num_contrato, so_abonado.modalidad_de_pago, so_abonado.cod_cargobasico, so_abonado.cod_central, so_abonado.ind_disp, so_abonado.nombre_abonado,
             so_abonado.cod_vendealer
        FROM ge_clientes a, ga_abocel b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g, ga_usuarios u
       WHERE b.num_abonado > 0
          AND b.num_celular = so_abonado.num_celular AND a.cod_cliente = b.cod_cliente AND b.cod_plantarif = c.cod_plantarif AND b.cod_situacion = d.cod_situacion AND b.tip_terminal = g.tip_terminal AND g.cod_producto = cn_producto
             AND e.cod_limconsumo = c.cod_limconsumo AND e.cod_producto = cn_producto AND c.cod_cargobasico = f.cod_cargobasico AND f.cod_producto = cn_producto AND b.cod_situacion NOT IN ('BAA', 'BAP') AND b.cod_usuario = u.cod_usuario
             AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta AND ROWNUM = 1
      UNION
      SELECT a.cod_cliente, b.num_abonado, b.num_celular, b.num_serie, b.num_imei, b.cod_tecnologia, b.cod_situacion, d.des_situacion, b.tip_plantarif, DECODE (b.tip_plantarif, 'E', 'EMPRESA', 'I', 'INDIVIDUAL') AS des_tipplantarif, b.cod_plantarif,
             c.des_plantarif, b.cod_ciclo, c.cod_limconsumo, e.des_limconsumo, b.cod_planserv, b.cod_uso, c.cod_tiplan, DECODE (c.cod_tiplan, '1', 'PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO') AS des_tiplan, b.cod_tipcontrato, b.fec_alta, b.fec_fincontra,
             NULL ind_eqprestado, NULL fec_prorroga, f.imp_cargobasico, b.num_anexo, b.cod_usuario, b.tip_terminal, g.des_terminal, b.num_venta, b.cod_cuenta, b.cod_subcuenta, b.cod_vendedor, b.cod_causa_venta, b.fec_baja, b.fec_bajacen, b.fec_ultmod,
             b.cod_empresa, b.fec_acepventa, b.num_contrato, b.cod_modventa, b.cod_cargobasico, b.cod_central, DECODE (b.ind_disp, NULL, -1), u.nom_usuario || ' ' || u.nom_apellido1 || ' ' || u.nom_apellido2, NVL (b.cod_vendealer, 0)
        FROM ge_clientes a, ga_aboamist b, ta_plantarif c, ga_situabo d, ta_limconsumo e, ta_cargosbasico f, al_tipos_terminales g, ga_usuamist u
       WHERE b.num_abonado > 0
          AND b.num_celular = so_abonado.num_celular AND a.cod_cliente = b.cod_cliente AND b.cod_plantarif = c.cod_plantarif AND b.cod_situacion = d.cod_situacion AND b.tip_terminal = g.tip_terminal AND g.cod_producto = cn_producto
             AND e.cod_limconsumo = c.cod_limconsumo AND e.cod_producto = cn_producto AND c.cod_cargobasico = f.cod_cargobasico AND f.cod_producto = cn_producto AND b.cod_situacion NOT IN ('BAA', 'BAP') AND b.cod_usuario = u.cod_usuario
             AND SYSDATE BETWEEN f.fec_desde AND f.fec_hasta AND ROWNUM = 1;
   EXCEPTION
      WHEN error_num_abonado THEN
         sn_cod_retorno := 10873;
         sv_mens_retorno :='Error al consultar estructura de los datos de un abonado. Numero de abonado erroneo.';

         lv_des_error := ' ve_portabilidad_pg.ga_cons_datos_abo_pr(' || so_abonado.num_abonado || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_portabilidad_pg.ga_cons_datos_abo_pr', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10874;
         sv_mens_retorno :='Error al consultar estructura de los datos de un abonado. No se retornaron datos';

         lv_des_error := ' ve_portabilidad_pg.ga_cons_datos_abo_pr(' || so_abonado.num_abonado || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_portabilidad_pg.ga_cons_datos_abo_pr', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10918;
         sv_mens_retorno :='Error al intentar obtener datos de abonado';

         lv_des_error := ' ve_portabilidad_pg.ga_cons_datos_abo_pr(' || so_abonado.num_abonado || '); ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, cv_version, USER, 've_portabilidad_pg.ga_cons_datos_abo_pr', lv_ssql, sn_cod_retorno, lv_des_error);
   END ga_cons_datos_abo_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_cuenta_ident_pr (
      ev_cod_tipident         IN              ga_cuentas.cod_tipident%TYPE,
      ev_num_ident            IN              ga_cuentas.num_ident%TYPE,
      sn_cod_cuenta           OUT NOCOPY      ga_cuentas.cod_cuenta%TYPE,
      sv_des_cuenta           OUT NOCOPY      ga_cuentas.des_cuenta%TYPE,
      sv_tip_cuenta           OUT NOCOPY      ga_cuentas.tip_cuenta%TYPE,
      sv_nom_responsable      OUT NOCOPY      ga_cuentas.nom_responsable%TYPE,
      sv_cod_tipident         OUT NOCOPY      ga_cuentas.cod_tipident%TYPE,
      sv_num_ident            OUT NOCOPY      ga_cuentas.num_ident%TYPE,
      sn_cod_direccion        OUT NOCOPY      ga_cuentas.cod_direccion%TYPE,
      sd_fec_alta             OUT NOCOPY      ga_cuentas.fec_alta%TYPE,
      sv_ind_estado           OUT NOCOPY      ga_cuentas.ind_estado%TYPE,
      sv_tel_contacto         OUT NOCOPY      ga_cuentas.tel_contacto%TYPE,
      sv_ind_sector           OUT NOCOPY      ga_cuentas.ind_sector%TYPE,
      sv_cod_clascta          OUT NOCOPY      ga_cuentas.cod_clascta%TYPE,
      sv_cod_catribut         OUT NOCOPY      ga_cuentas.cod_catribut%TYPE,
      sv_des_valor            OUT NOCOPY      ged_codigos.des_valor%TYPE,
      sn_cod_categoria        OUT NOCOPY      ga_cuentas.cod_categoria%TYPE,
      sn_cod_sector           OUT NOCOPY      ga_cuentas.cod_sector%TYPE,
      sv_cod_subcategori      OUT NOCOPY      ga_cuentas.cod_subcategoria%TYPE,
      sv_ind_multuso          OUT NOCOPY      ga_cuentas.ind_multuso%TYPE,
      sv_ind_cliepotencial    OUT NOCOPY      ga_cuentas.ind_cliepotencial%TYPE,
      sv_des_razon_social     OUT NOCOPY      ga_cuentas.des_razon_social%TYPE,
      sd_fec_inivta_pac       OUT NOCOPY      ga_cuentas.fec_inivta_pac%TYPE,
      sv_cod_tipcomis         OUT NOCOPY      ga_cuentas.nom_usuario_asesor%TYPE,
      sv_nom_usuario_asesor   OUT NOCOPY      ga_cuentas.nom_usuario_asesor%TYPE,
      sd_fec_nacimiento       OUT NOCOPY      ga_cuentas.fec_nacimiento%TYPE,
      sn_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY      ge_errores_pg.evento) IS
      v_des_error           ge_errores_pg.desevent;
      ssql                  ge_errores_pg.vquery;
      can_bodegas           NUMBER;
      error_no_data_found   EXCEPTION;
      v_parametro           ged_parametros.val_parametro%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      ssql :=
         'SELECT cod_cuenta, des_cuenta, tip_cuenta, nom_responsable, cod_tipident,' || ' num_ident, cod_direccion, fec_alta, ind_estado, tel_contacto,' || ' ind_sector, cod_clascta, cod_catribut, b.des_valor, cod_categoria, cod_sector,'
         || ' cod_subcategoria, ind_multuso, ind_cliepotencial, des_razon_social,' || ' fec_inivta_pac, cod_tipcomis, nom_usuario_asesor, fec_nacimiento' || ' FROM ga_cuentas a, ged_codigos b' || ' WHERE a.cod_tipident = ' || ev_cod_tipident
         || ' AND a.num_ident = ' || ev_num_ident || ' AND b.nom_tabla = ''GA_CUENTAS''' || ' AND b.nom_columna = ''COD_CATRIBUT''' || ' AND b.cod_valor = a.cod_catribut';

      SELECT cod_cuenta, des_cuenta, tip_cuenta, nom_responsable, cod_tipident, num_ident, cod_direccion, fec_alta, ind_estado, tel_contacto, ind_sector, cod_clascta, cod_catribut, b.des_valor, cod_categoria,
             cod_sector, cod_subcategoria, ind_multuso, ind_cliepotencial, des_razon_social, fec_inivta_pac, cod_tipcomis, nom_usuario_asesor, fec_nacimiento
        INTO sn_cod_cuenta, sv_des_cuenta, sv_tip_cuenta, sv_nom_responsable, sv_cod_tipident, sv_num_ident, sn_cod_direccion, sd_fec_alta, sv_ind_estado, sv_tel_contacto, sv_ind_sector, sv_cod_clascta, sv_cod_catribut, sv_des_valor, sn_cod_categoria,
             sn_cod_sector, sv_cod_subcategori, sv_ind_multuso, sv_ind_cliepotencial, sv_des_razon_social, sd_fec_inivta_pac, sv_cod_tipcomis, sv_nom_usuario_asesor, sd_fec_nacimiento
        FROM ga_cuentas a, ged_codigos b
       WHERE a.cod_tipident = ev_cod_tipident AND a.num_ident = ev_num_ident AND b.nom_tabla = 'GA_CUENTAS' AND b.nom_columna = 'COD_CATRIBUT' AND b.cod_valor = a.cod_catribut;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := '200600';
         sv_mens_retorno := 'Error al validar, numero de identificacion en la cuenta';
         v_des_error := 've_portabilidad_pg.ve_val_cuenta_ident_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_cuenta_ident_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200601';
         sv_mens_retorno := 'Error no definido al validar, numero de identificacion en la cuenta';
         v_des_error := 've_portabilidad_pg.ve_val_cuenta_ident_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_val_cuenta_ident_pr', ssql, SQLCODE, v_des_error);
   END ve_val_cuenta_ident_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_obtiene_info_mdn_pr (
      en_mdn            IN              al_series.num_telefono%TYPE,
      sn_central        OUT NOCOPY      al_series.cod_central%TYPE,
      sn_uso            OUT NOCOPY      al_series.cod_uso%TYPE,
      sn_cat            OUT NOCOPY      al_series.cod_cat%TYPE,
      sv_subalm         OUT NOCOPY      al_series.cod_subalm%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      IS
      lv_des_error      VARCHAR2 (300);
      lv_ssql           VARCHAR2 (1000);

   BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := ' ';
      sn_num_evento   := 0;


         lv_ssql := 'SELECT cod_subalm, cod_central, cod_cat, cod_uso';
         lv_ssql := lv_ssql || 'FROM ga_celnum_uso';
         lv_ssql := lv_ssql || 'WHERE '      || en_mdn || ' between num_desde and num_hasta';
         lv_ssql := lv_ssql || 'AND ROWNUM=' || 1;

         SELECT cod_subalm, cod_central, cod_cat, cod_uso
           INTO sv_subalm, sn_central, sn_cat, sn_uso
           FROM ga_celnum_uso
          WHERE en_mdn BETWEEN num_desde AND num_hasta AND ROWNUM = 1;


      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 147;
         sv_mens_retorno:='El celular ingresado no pertenece al plan de numeración de la operadora.';

         lv_des_error := SUBSTR ('ve_portabilidad_pg.AL_OBTIENE_INFO_MDN_PR' || ' - ' || SQLERRM, 1, 250);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, 250);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'VE', sv_mens_retorno, cv_version, USER, 'AL_PORTABILIDAD_PG.AL_OBTIENE_INFO_MDN_PR', lv_ssql, SQLCODE, SQLERRM);

      WHEN OTHERS THEN
         sn_cod_retorno := 147;
         sv_mens_retorno:='El celular ingresado no pertenece al plan de numeración de la operadora.';


         lv_des_error := SUBSTR ('Others: AL_PORTABILIDAD_PG.AL_OBTIENE_INFO_MDN_PR' || ' - ' || SQLERRM, 1, 250);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, 250);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'VE', sv_mens_retorno, cv_version, USER, 'AL_PORTABILIDAD_PG.AL_OBTIENE_INFO_MDN_PR', lv_ssql, SQLCODE, SQLERRM);
   END ve_obtiene_info_mdn_pr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_numeraserie_portabilidad_pr (
    ev_num_serie      IN              al_series.num_serie%TYPE,
    ev_num_celular    IN              ta_numnacional.num_tdesde%TYPE,
    ev_cod_central    IN              al_series.cod_central%TYPE,
    ev_cod_subalm     IN              al_series.cod_subalm%TYPE,
    ev_tip_terminal   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS

      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
      can_registros   NUMBER;
    sv_largoTDMA    NUMBER;
    tip_numero      VARCHAR2(10);
    error_ejecucion exception;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

    ve_intermediario_pg.ve_obtiene_valor_parametro_pr ('LARGO_SERIE_TTDMA','AL',1,sv_largoTDMA,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
    IF sn_cod_retorno <> 0 THEN
       RAISE error_ejecucion;
    END IF;

    IF NOT (ve_val_numcelular_fn (ev_num_celular,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
       RAISE error_ejecucion;
    END IF;

    ve_val_rago_operadora_scl_pr (ev_num_celular,tip_numero,sn_cod_retorno,sv_mens_retorno,sn_num_evento);
    IF sn_cod_retorno <> 0 THEN
       RAISE error_ejecucion;
    END IF;

    IF (tip_numero = 'I') THEN

       IF NOT (ve_val_cel_reutil_I_fn (ev_num_celular,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
        RAISE error_ejecucion;
       ELSE
          IF NOT (ve_num_simcard_I_fn (ev_num_celular,ev_num_serie,ev_cod_central, ev_cod_subalm, ev_tip_terminal, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
             RAISE error_ejecucion;
          END IF;
     END IF;
    ELSE
       IF NOT (ve_val_cel_reutil_P_fn (ev_num_celular,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
        RAISE error_ejecucion;
     ELSIF (ev_tip_terminal <> 'E' ) THEN

        IF NOT (ve_num_simcard_P_fn (ev_num_celular,ev_num_serie, ev_cod_central, ev_cod_subalm, sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

     END IF;
    END IF;




   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error := 've_portabilidad_pg.ve_numeraserie_portabilidad_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_numeraserie_portabilidad_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200028';
         sv_mens_retorno := 'Error no definido al validar rango Operadora SCL';
         v_des_error := 've_portabilidad_pg.ve_numeraserie_portabilidad_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_numeraserie_portabilidad_pr', ssql, SQLCODE, v_des_error);
   END ve_numeraserie_portabilidad_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_agrega_BYP_prepago_pr (
    ev_num_abonado    IN              ge_seg_usuario.nom_usuario%TYPE,
    ev_ind_procequi   IN              ga_equipaboser.ind_procequi%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS

      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
    beneficio_pre   VARCHAR2(1000);
    num_transacc    NUMBER;
    n_cod_retorno   NUMBER;
    v_des_cadena    VARCHAR(4000);
    error_ejecucion EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';



    beneficio_pre := bp_promociones_pg.bp_promocion_omision_fn(ev_num_abonado,'VE',1);


    IF beneficio_pre IS NOT NULL AND LENGTH(beneficio_pre) > 0 THEN

         SELECT ga_seq_transacabo.NEXTVAL
           INTO num_transacc
           FROM DUAL;

         bp_promociones_pg.bp_promocion_omision_pr(num_transacc,ev_num_abonado,'VE',1,'A',ev_ind_procequi,null,null,'N');

         SELECT a.cod_retorno, a.des_cadena
       INTO n_cod_retorno, v_des_cadena
       FROM ga_transacabo a
      WHERE a.num_transaccion = num_transacc;

      IF n_cod_retorno <> 0 THEN
         sn_cod_retorno  := n_cod_retorno;
             sv_mens_retorno := v_des_cadena;
       RAISE error_ejecucion;
      END IF;



    END IF;



   EXCEPTION
      WHEN error_ejecucion THEN
         v_des_error := 've_portabilidad_pg.ve_numeraserie_portabilidad_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_numeraserie_portabilidad_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200028';
         sv_mens_retorno := 'Error no definido al validar rango Operadora SCL';
         v_des_error := 've_portabilidad_pg.ve_numeraserie_portabilidad_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_numeraserie_portabilidad_pr', ssql, SQLCODE, v_des_error);
   END ve_agrega_BYP_prepago_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_val_usuario_scl_pr (
    ev_nom_usuario    IN              ge_seg_usuario.nom_usuario%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS

      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
    error_usuario EXCEPTION;
    canUsuario      NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

    SELECT count(1)
      INTO canUsuario
        FROM ge_seg_usuario
       WHERE nom_usuario = ev_nom_usuario;

     IF canUsuario < 1 THEN
        RAISE error_usuario;
     END IF;

   EXCEPTION
      WHEN error_usuario THEN
         sn_cod_retorno := '200300';
         sv_mens_retorno := 'El usuario no existe en SCL';
         v_des_error := 've_portabilidad_pg.ve_numeraserie_portabilidad_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_numeraserie_portabilidad_pr', ssql, SQLCODE, v_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := '200301';
         sv_mens_retorno := 'Error no definido al validar usuario en SCL';
         v_des_error := 've_portabilidad_pg.ve_numeraserie_portabilidad_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_numeraserie_portabilidad_pr', ssql, SQLCODE, v_des_error);
   END ve_val_usuario_scl_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_rec_limc_clie_emp_pr (
    ev_cod_cliente    IN              ge_clientes.cod_cliente%TYPE,
    ev_cod_limiteclie OUT NOCOPY      ga_limite_cliabo_to.cod_limcons%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS

      v_des_error     ge_errores_pg.desevent;
      ssql            ge_errores_pg.vquery;
    error_usuario   EXCEPTION;
    canCliAbo       NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';


      SELECT COUNT (1)
        INTO cancliabo
        FROM ga_limite_cliabo_to a
       WHERE a.cod_cliente = ev_cod_cliente
       AND a.num_abonado = 0
       AND a.fec_hasta is null; --Incidencia 143338 [ACP Soporte Ventas 18-08-2010]

     IF cancliabo < 1 THEN
        ev_cod_limiteclie := '';
     ELSE
         SELECT a.cod_limcons
           INTO ev_cod_limiteclie
           FROM ga_limite_cliabo_to a
          WHERE a.cod_cliente = ev_cod_cliente
        AND a.num_abonado = 0
        AND a.fec_hasta is null; --Incidencia 143338 [ACP Soporte Ventas 18-08-2010];
     END IF;

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := '200302';
         sv_mens_retorno := 'Error no definido al recuperar limite de consumo';
         v_des_error := 've_portabilidad_pg.ve_rec_limc_clie_emp_pr(); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 've_portabilidad_pg.ve_rec_limc_clie_emp_pr', ssql, SQLCODE, v_des_error);
   END ve_rec_limc_clie_emp_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



END ve_portabilidad_pg;
/

SHOW ERRORS
