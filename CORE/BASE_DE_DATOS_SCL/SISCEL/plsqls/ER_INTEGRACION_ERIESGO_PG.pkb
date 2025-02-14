CREATE OR REPLACE PACKAGE BODY er_integracion_eriesgo_pg IS

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_activo_buro_fn
   RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
       v_valor                VARCHAR2(2);
   BEGIN


          LV_sql := 'SELECT ind_activo'
                 || ' FROM erd_productos'
             || ' WHERE cod_fuente = 2'
                 || ' AND cod_producto = 2';


      SELECT ind_activo
            INTO v_valor
        FROM erd_productos
       WHERE cod_fuente = cn_erd_fuente2
             AND cod_producto = cn_erd_producto2;


      IF v_valor = 'S' THEN
             RETURN TRUE;
          ELSE
             RETURN FALSE;
          END IF;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
     WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR('-20001','Producto BU-BURO INTEGRAL + DCIFRA no activo');

   END er_activo_buro_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_is_number_fn (
      ev_number IN VARCHAR2
   ) RETURN BOOLEAN
   IS
      n_valor NUMBER;
   BEGIN
      IF (ev_number IS NOT NULL) THEN
             n_valor := TO_NUMBER(ev_number);
      ELSE
             RETURN FALSE;
          END IF;
      RETURN TRUE;
   EXCEPTION
     WHEN value_error THEN
           RETURN FALSE;
   END er_is_number_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_calcula_gama_fn (
      ev_gama           IN OUT NOCOPY  VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       lv_sql                 ge_errores_pg.vquery;

           v_gama                 VARCHAR2(5);
           n_tipo_score           NUMBER;
           v_signo                VARCHAR2(10);
           v_decim                VARCHAR2(10);
           v_valor                VARCHAR2(10);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           /*calcular gama*/
           DBMS_OUTPUT.Put_Line('ev_gama tram= [' || TO_CHAR(ev_gama)||']');
           v_gama := trim(ev_gama);
                   ev_gama := trim(ev_gama);

           IF (trim(ev_gama) = '') OR (trim(ev_gama) IS NULL) THEN
              ev_gama := trim(v_gama);
           ELSE
           FOR i IN 1..length(ev_gama) LOOP
                        IF substr(ev_gama,1,1) = '0' THEN
                            ev_gama := substr(ev_gama,2,length(ev_gama)-1);
                                                        DBMS_OUTPUT.Put_Line('ev_gama FOR= [' || TO_CHAR(ev_gama)||']');
                        ELSE
                           EXIT;
                        END IF;
           END LOOP;
               IF (trim(ev_gama) = '') OR (trim(ev_gama) IS NULL) THEN
                   ev_gama := trim(v_gama);
                   END IF;
           END IF;
                   DBMS_OUTPUT.Put_Line('ev_gama RETORNO= [' || TO_CHAR(ev_gama)||']');

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
         sn_cod_retorno  := '457';
         sv_mens_retorno := 'Error: al calcular gama';
         lv_des_error    := 'er_integracion_eriesgo_pg.er_calcula_gama_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_calcula_gama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_calcula_gama_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_calcula_calificacion_fn (
      ev_calificacion   IN             VARCHAR2,
          sn_puntaje        OUT NOCOPY     NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

       v_signo                VARCHAR2(10);
           v_decim                VARCHAR2(10);
           v_valor                VARCHAR2(10);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           v_signo    := substr(ev_calificacion,1,1);
           v_decim    := substr(ev_calificacion,length(ev_calificacion),1);
           v_valor    := substr(ev_calificacion,2,length(ev_calificacion)-2);

       IF (v_valor IS NOT NULL) THEN
           sn_puntaje := to_number( TO_CHAR (v_signo||v_valor||'.'||v_decim));
       ELSE
              sn_puntaje := 0;
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
         sn_cod_retorno  := '458';
         sv_mens_retorno := 'Error: al calcular calificacion';
         lv_des_error    := 'er_integracion_eriesgo_pg.er_calcula_calificacion_fn(); -  ' || ev_calificacion || ' ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_calcula_calificacion_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_calcula_calificacion_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_obtiene_erd_parametros_fn (
      eo_erd_parametros IN OUT NOCOPY  ERD_PARAMETROS_OT,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           d_fecha_actualizacion  ert_datos_consulta_to.fecha_actualizacion%TYPE;
           trama_no_vigente       EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

          LV_sql:= 'SELECT cod_codigo, cod_subcodigo, des_codigo, cod_parametro, ind_tipo_parametro,des_parametro1, des_parametro2, val_operador1, val_operador2, val_parametro1,val_parametro2, nom_usuario_modi, fec_modi_h'
            || ' FROM erd_parametros'
            || ' WHERE cod_codigo = '||eo_erd_parametros.cod_codigo
                || ' AND cod_subcodigo = '||eo_erd_parametros.cod_subcodigo
                    || ' AND cod_parametro = '||eo_erd_parametros.cod_parametro;

      SELECT cod_codigo, cod_subcodigo, des_codigo, cod_parametro, ind_tipo_parametro,
             des_parametro1, des_parametro2, val_operador1, val_operador2, val_parametro1,
             val_parametro2, nom_usuario_modi, fec_modi_h
        INTO eo_erd_parametros.cod_codigo, eo_erd_parametros.cod_subcodigo, eo_erd_parametros.des_codigo, eo_erd_parametros.cod_parametro, eo_erd_parametros.ind_tipo_parametro,
             eo_erd_parametros.des_parametro1, eo_erd_parametros.des_parametro2, eo_erd_parametros.val_operador1, eo_erd_parametros.val_operador2, eo_erd_parametros.val_parametro1,
             eo_erd_parametros.val_parametro2, eo_erd_parametros.nom_usuario_modi, eo_erd_parametros.fec_modi_h
        FROM erd_parametros
       WHERE cod_codigo = eo_erd_parametros.cod_codigo
             AND cod_subcodigo = eo_erd_parametros.cod_subcodigo
                 AND cod_parametro = eo_erd_parametros.cod_parametro;


           RETURN TRUE;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := '459';
         sv_mens_retorno := 'Error: No existe parametrización para tipo de proceso';
         lv_des_error    := 'er_integracion_eriesgo_pg.er_obtiene_erd_parametros_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtiene_erd_parametros_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
         sn_cod_retorno  := '460';
         sv_mens_retorno := 'Error: general al recuperar parametro';
         lv_des_error    := 'er_integracion_eriesgo_pg.er_obtiene_erd_parametros_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtiene_erd_parametros_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obtiene_erd_parametros_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_valida_reg99_fn (
      ev_personeria     IN             VARCHAR2,
          eo_datosburo      IN             ER_DATOSBURO_OT,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           error_reg99            EXCEPTION;
           error_personeria       EXCEPTION;
       o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           o_erd_parametros.cod_codigo := 101;
           o_erd_parametros.cod_subcodigo := 1;
           o_erd_parametros.cod_parametro := eo_datosburo.registro99.cod_respuesta;--  13;
           IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

           IF ev_personeria = 'PN' THEN
          IF o_erd_parametros.val_operador2 != 'T' THEN
                     RAISE error_reg99;
                  END IF;
           ELSIF ev_personeria = 'PJ' THEN
          IF o_erd_parametros.des_parametro2 != 'T' THEN
                     RAISE error_reg99;
                  END IF;
           ELSE
              RAISE error_personeria;
           END IF;


           RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        sn_cod_retorno  := '461';
        sv_mens_retorno:= 'No se pudo obtener descripción en ERD_PARAMETROS (101, 1,' || eo_datosburo.registro99.cod_respuesta ||')';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN error_personeria THEN
        sn_cod_retorno  := '461';
        sv_mens_retorno := 'Error: al validar personeria';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN error_reg99 THEN

        IF ev_personeria = 'PN' THEN
           IF o_erd_parametros.val_operador2 IS NULL THEN
                      sn_cod_retorno  := '459';
              sv_mens_retorno := 'No se pudo obtener mensaje en ERD_PARAMETROS';
           ELSE
              sn_cod_retorno  :=  eo_datosburo.registro99.cod_respuesta;
              sv_mens_retorno :=  o_erd_parametros.des_parametro1 || 'No se puede continuar a menos que realice excepcion';
           END IF;
            ELSIF ev_personeria = 'PJ' THEN
           IF o_erd_parametros.des_parametro2 IS NULL THEN
                      sn_cod_retorno  := '459';
              sv_mens_retorno := 'No se pudo obtener mensaje en ERD_PARAMETROS';
           ELSE
              sn_cod_retorno  :=  eo_datosburo.registro99.cod_respuesta;
              sv_mens_retorno :=  o_erd_parametros.des_parametro1 || ' No se puede continuar a menos que realice excepcion';
           END IF;
            END IF;

        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg99_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
         sn_cod_retorno  := '463';
         sv_mens_retorno := 'Error: no determinado validar reg99';
         lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg99_fn(); - ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg99_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_valida_reg99_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_valida_reg20_fn (
      ev_personeria     IN             VARCHAR2,
          eo_datosburo      IN             ER_DATOSBURO_OT,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       lv_des_error           ge_errores_pg.desevent;
       lv_sql                 ge_errores_pg.vquery;
           error_personeria       EXCEPTION;
           error_reg20            EXCEPTION;
           mens_error             ge_errores_td.det_msgerror%TYPE;
           v_ind_pn               VARCHAR2(2);
           v_ind_pj               VARCHAR2(2);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           lv_sql := 'SELECT mens_usuario, ind_pn, ind_pj FROM er_clasif_buro_td'
              || ' WHERE cod_clasificacion = '||eo_datosburo.registro20.clasificacion;

       SELECT mens_usuario, ind_pn, ind_pj
         INTO mens_error, v_ind_pn, v_ind_pj
         FROM er_clasif_buro_td
        WHERE cod_clasificacion = eo_datosburo.registro20.clasificacion;

           IF ev_personeria = 'PN' THEN
          IF v_ind_pn != 'T' THEN
                     RAISE error_reg20;
                  END IF;
           ELSIF ev_personeria = 'PJ' THEN
          IF v_ind_pj != 'T' THEN
                     RAISE error_reg20;
                  END IF;
           ELSE
              RAISE error_personeria;
           END IF;

           RETURN TRUE;

   EXCEPTION

     WHEN error_personeria THEN
        sn_cod_retorno  := '464';
        sv_mens_retorno := 'Error: al validar personeria';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg20_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg20_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN error_reg20 THEN
        sn_cod_retorno  := '465';
        IF TRIM(mens_error) is null THEN
           sv_mens_retorno:='No se pudo obtener descripción en ER_CLASIF_BURO_TD (clasificacion: ' || eo_datosburo.registro20.clasificacion || ')';
        ELSE
        sv_mens_retorno := mens_error ;
        END IF;
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg20_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg20_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := '466';
        sv_mens_retorno := 'Error: Debe configurar la clasificación en el mantenedor indicadores de rechazo de clasificación';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg20_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg20_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '466';
        sv_mens_retorno := 'Error: Debe configurar la clasificación en el mantenedor indicadores de rechazo de clasificación';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_reg20_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_reg20_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_valida_reg20_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_obtener_puntajes_fn (
      ev_personeria     IN             VARCHAR2,
          eo_datosburo      IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
       o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();
           v_gama                 VARCHAR2(5);
           n_tipo_score           NUMBER;
           v_signo                VARCHAR2(10);
           v_decim                VARCHAR2(10);
           v_valor                VARCHAR2(10);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           /*calcular gama*/
           IF (trim(eo_datosburo.registro20.gama) = '') OR (trim(eo_datosburo.registro20.gama) IS NULL) THEN
              v_gama := '00000';
           ELSE
                   v_gama :=  eo_datosburo.registro20.gama;
           FOR i IN 1..length(v_gama) LOOP
                        IF substr(v_gama,1,1) = '0' THEN
                            v_gama := substr(v_gama,2,length(v_gama)-1);
                        ELSE
                           EXIT;
                        END IF;
           END LOOP;
               IF (trim(v_gama) = '') OR (trim(v_gama) IS NULL) THEN
                   v_gama := '00000';
                   END IF;
           END IF;


           /*calcular tipo escor*/
           IF (er_is_number_fn(eo_datosburo.registro20.tipo_score)) AND (trim(eo_datosburo.registro20.tipo_score) IS NOT NULL) THEN
              v_signo := substr(eo_datosburo.registro20.calificacion,1,1);
                  v_decim := substr(eo_datosburo.registro20.calificacion,length(eo_datosburo.registro20.calificacion),1);
                  v_valor := substr(eo_datosburo.registro20.calificacion,2,length(eo_datosburo.registro20.calificacion)-2);
                  n_tipo_score := to_number(v_signo||v_valor||'.'||v_decim);
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '467';
        sv_mens_retorno := 'Error: no determinado al obtener puntaje';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_obtener_puntajes_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtener_puntajes_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obtener_puntajes_fn;

   FUNCTION er_obtener_usuario_fn (
      ev_cod_usuario    IN              erd_usuarios.COD_USUARIO%TYPE,
      ev_nom_usuario    OUT NOCOPY      erd_usuarios.NOM_USUARIO%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
       o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();
           v_gama                 VARCHAR2(5);
           n_tipo_score           NUMBER;
           v_signo                VARCHAR2(10);
           v_decim                VARCHAR2(10);
           v_valor                VARCHAR2(10);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      LV_sql:='SELECT NOM_USUARIO FROM ERD_USUARIOS '
      || ' WHERE COD_USUARIO =' || ev_cod_usuario
      || ' AND SYSDATE BETWEEN FEC_INICIO_H AND FEC_TERMINO_H'
      || ' AND IND_VIGENTE=1';


      SELECT NOM_USUARIO
      INTO ev_nom_usuario
      FROM ERD_USUARIOS
      WHERE COD_USUARIO=ev_cod_usuario
      AND SYSDATE BETWEEN FEC_INICIO_H AND FEC_TERMINO_H
      AND IND_VIGENCIA=1;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '494';
        sv_mens_retorno := 'Error: Usuario no vigente en el Sistema';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_obtener_usuario_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtener_usuario_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obtener_usuario_fn;




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_obtiene_cargosbasicos_fn (
      ev_num_ident      IN              ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN              ged_parametros.cod_modulo%TYPE,
          en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sn_importeimp     OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           imp_cargobasico            NUMBER;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';


           LV_sql := 'SELECT sum(imp_cargobasico) FROM ( SELECT cod_cliente, round(c.imp_cargobasico * er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn(cod_cliente,'||en_cod_vendedor||')) FROM ga_cuentas a, ga_abocel b, ta_cargosbasico c'
              || ' WHERE b.cod_cuenta = a.cod_cuenta'
              || ' AND a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND b.cod_situacion <> ''BAA'''
              || ' AND b.cod_cargobasico = c.cod_cargobasico'
              || ' AND b.cod_plantarif NOT IN (SELECT cod_plantarif'
              || ' FROM ta_plantarif'
              || ' WHERE ind_familiar = 1 AND tip_plantarif = ''E'')'
              || ' UNION'
              || ' SELECT cod_cliente, round(c.imp_cargobasico*ER_INTEGRACION_IMPUESTO_PG.er_obtenerimpuesto_clie_fn(cod_cliente,'||en_cod_vendedor||'))'
              || ' FROM ga_cuentas a, ga_abocel b, ta_cargosbasico c'
              || ' WHERE b.cod_cuenta = a.cod_cuenta'
              || ' AND a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND b.cod_situacion <> ''BAA'''
              || ' AND b.cod_cargobasico = c.cod_cargobasico'
              || ' AND b.cod_plantarif IN (SELECT cod_plantarif'
              || ' FROM ta_plantarif'
              || ' WHERE ind_familiar = 1 AND tip_plantarif = ''E''))';


       SELECT nvl(ROUND(sum(impo)),0)
       INTO sn_importeimp
       FROM (
       SELECT b.num_abonado, a.cod_cliente, ROUND(c.imp_cargobasico * er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn(a.cod_cliente,en_cod_vendedor)) as impo
         FROM ge_clientes a, ga_abocel b, ta_cargosbasico c
        WHERE b.cod_cliente = a.cod_cliente
          AND a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
          AND b.cod_situacion <> 'BAA'
          AND b.cod_cargobasico = c.cod_cargobasico
                  AND c.cod_producto = 1
                  AND NVL(c.fec_hasta,SYSDATE) >= SYSDATE
          AND b.cod_plantarif NOT IN (SELECT cod_plantarif
                                        FROM ta_plantarif
                                       WHERE ind_familiar = 1 AND tip_plantarif = 'E')
       UNION
       SELECT b.num_abonado, a.cod_cliente, ROUND(c.imp_cargobasico * er_integracion_impuesto_pg.er_obtenerimpuesto_clie_fn(a.cod_cliente,en_cod_vendedor)) as impo
         FROM ge_clientes a, ga_abocel b, ta_cargosbasico c
        WHERE b.cod_cliente = a.cod_cliente
          AND a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
          AND b.cod_situacion <> 'BAA'
          AND b.cod_cargobasico = c.cod_cargobasico
                  AND c.cod_producto = 1
                  AND NVL(c.fec_hasta,SYSDATE) >= SYSDATE
          AND b.cod_plantarif IN (SELECT cod_plantarif
                                    FROM ta_plantarif
                                   WHERE ind_familiar = 1 AND tip_plantarif = 'E'));


           RETURN TRUE;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := '468';
        sv_mens_retorno := 'Error: no se encuentran planes tarifarios que cumplan los criterios de evaluación';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_obtiene_cargosbasicos_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtiene_cargosbasicos_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        sn_cod_retorno  := '469';
        sv_mens_retorno := 'Error: no determinado calcular cargos basicos';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_obtiene_cargosbasicos_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtiene_cargosbasicos_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obtiene_cargosbasicos_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_val_existe_cliente_fn (
      ev_num_ident      IN          ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN          ged_parametros.cod_modulo%TYPE,
          sb_exist_clie     OUT NOCOPY  BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           cant_abonados          NUMBER(2);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           LV_sql := 'SELECT count(1) FROM ga_cuentas a, ge_clientes b, ga_abocel c'
              || ' WHERE a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND b.cod_cuenta = a.cod_cuenta'
              || ' AND c.cod_cliente = b.cod_cliente'
              || ' AND c.cod_situacion not in (BAA,BAP,PFB,REA,REP,RRD)';


       SELECT count(1)
             INTO cant_abonados
         FROM ga_cuentas a, ge_clientes b, ga_abocel c
        WHERE a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
          AND b.cod_cuenta = a.cod_cuenta
                  AND c.cod_cliente = b.cod_cliente
          AND c.cod_situacion not in ('BAA','BAP','PFB','REA','REP','RRD');

           IF cant_abonados < 1 THEN
          sb_exist_clie := FALSE;
           ELSE
          sb_exist_clie := TRUE;
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '470';
        sv_mens_retorno := 'Error: al verificar si existe el cliente';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_existe_cliente_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_existe_cliente_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_val_existe_cliente_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_val_antiguedad_abon_fn (
      ev_num_ident      IN          ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN          ged_parametros.cod_modulo%TYPE,
          sb_antiguedad     OUT NOCOPY  BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();

           CURSOR antiguedad IS
       SELECT b.num_abonado, b.fec_alta, nvl(b.fec_altantras,sysdate)
         FROM ga_cuentas a, ga_abocel b
        WHERE a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
          AND b.cod_cuenta = a.cod_cuenta;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           o_erd_parametros.cod_codigo := 1;
           o_erd_parametros.cod_subcodigo := 18;
           o_erd_parametros.cod_parametro := 1;

           IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

           LV_sql := 'SELECT b.num_abonado, b.fec_alta, nvl(b.fec_altantras,sysdate)'
              || ' FROM ga_cuentas a, ga_abocel b'
              || ' WHERE a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND b.cod_cuenta = a.cod_cuenta';

           sb_antiguedad := TRUE;
           FOR vcantiguedad IN antiguedad() LOOP
          IF vcantiguedad.fec_alta +o_erd_parametros.val_parametro1 > sysdate THEN
             sb_antiguedad := FALSE;
                         EXIT;
                  END IF;
           END LOOP;

           RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_antiguedad_abon_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_antiguedad_abon_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '471';
        sv_mens_retorno := 'Error: no determinado al validar antiguedad del cliente';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_antiguedad_abon_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_antiguedad_abon_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_val_antiguedad_abon_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_val_baja_no_validas_fn (
      ev_num_ident      IN          ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN          ged_parametros.cod_modulo%TYPE,
          sb_bajas_n_val    OUT NOCOPY  BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           cant_baja            NUMBER(2);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           LV_sql := 'SELECT count(1) FROM ga_cuentas a, ga_abocel b'
              || ' WHERE a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND b.cod_cuenta = a.cod_cuenta'
              || ' AND b.cod_causabaja IN (SELECT val_parametro1'
              ||                           ' FROM erd_parametros'
                  ||                                           ' WHERE cod_codigo = '||cod_codigo_1
                  ||                                           ' AND Cod_subcodigo = '||cod_subcodigo_19
                          ||                           ' AND cod_parametro > 0)';


       SELECT count(1)
             INTO cant_baja
         FROM ga_cuentas a, ga_abocel b
        WHERE a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
          AND b.cod_cuenta = a.cod_cuenta
          AND b.cod_causabaja IN (SELECT val_parametro1
                                    FROM erd_parametros
                                                           WHERE cod_codigo = cod_codigo_1
                                                             AND Cod_subcodigo = cod_subcodigo_19
                                                                         AND cod_parametro > 0);

           IF cant_baja > 0 THEN
          sb_bajas_n_val := TRUE;
           ELSE
          sb_bajas_n_val := FALSE;
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '472';
        sv_mens_retorno := 'Error: no determinado al validar bajas de abonados';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_baja_no_validas_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_baja_no_validas_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_val_baja_no_validas_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_val_sus_no_validas_fn (
      ev_num_ident      IN          ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN          ged_parametros.cod_modulo%TYPE,
          sb_suspen_n_val   OUT NOCOPY  BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           cant_suspen            NUMBER(2);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           LV_sql := 'SELECT COUNT (1) FROM ga_cuentas a, ga_abocel b, ga_susprehabo c'
              || ' WHERE a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND b.cod_cuenta = a.cod_cuenta'
              || ' AND c.num_abonado = b.num_abonado'
              || ' AND c.cod_producto = 1'
              || ' AND c.fec_suspbd IS NOT NULL'
              || ' AND c.cod_caususp IN (SELECT val_parametro1'
              ||                         ' FROM erd_parametros'
                  ||                                        ' WHERE cod_codigo = '||cod_codigo_1
                  ||                                          ' AND Cod_subcodigo = '||cod_subcodigo_21||')'
                          ||                          ' AND cod_parametro > 0)';

       SELECT COUNT (1)
         INTO cant_suspen
         FROM ga_cuentas a, ga_abocel b, ga_susprehabo c
        WHERE a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
          AND b.cod_cuenta = a.cod_cuenta
          AND c.num_abonado = b.num_abonado
          AND c.cod_producto = 1
          AND c.fec_suspbd IS NOT NULL
          AND c.COD_CAUSUSP IN (SELECT val_parametro1
                                  FROM erd_parametros
                                                         WHERE cod_codigo = cod_codigo_1
                                                           AND Cod_subcodigo = cod_subcodigo_21
                                                                   AND cod_parametro > 0);

           IF cant_suspen > 0 THEN
          sb_suspen_n_val := TRUE;
           ELSE
          sb_suspen_n_val := FALSE;
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '473';
        sv_mens_retorno := 'Error: no determinado al validar suspenciones';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_sus_no_validas_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_sus_no_validas_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_val_sus_no_validas_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_val_ven_no_validas_fn (
      ev_num_ident      IN             ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN             ged_parametros.cod_modulo%TYPE,
          sb_vent_n_val     OUT NOCOPY     BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           cant_ventarec          NUMBER(2);

   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           LV_sql := 'SELECT COUNT (1) FROM ga_cuentas a, ge_clientes b, ga_ventas c'
              || ' WHERE a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND b.cod_cuenta = a.cod_cuenta'
              || ' AND c.cod_cliente = b.cod_cliente'
              || ' AND c.cod_producto = 1'
              || ' AND c.cod_causarec IN (SELECT val_parametro1'
              ||                          ' FROM erd_parametros'
              ||                         ' WHERE cod_codigo = '||cod_codigo_1
                  ||                                       ' AND cod_subcodigo = '||cod_subcodigo_20||')'
                          ||                          ' AND cod_parametro > 0)';

       SELECT COUNT (1)
         INTO cant_ventarec
         FROM ga_cuentas a, ge_clientes b, ga_ventas c
        WHERE a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
          AND b.cod_cuenta = a.cod_cuenta
          AND c.cod_cliente = b.cod_cliente
          AND c.cod_producto = 1
          AND c.cod_causarec IN (SELECT val_parametro1
                                   FROM erd_parametros
                                  WHERE cod_codigo = cod_codigo_1
                                                        AND cod_subcodigo = cod_subcodigo_20
                                                                        AND cod_parametro > 0);

           IF cant_ventarec > 0 THEN
          sb_vent_n_val := TRUE;
           ELSE
          sb_vent_n_val := FALSE;
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '474';
        sv_mens_retorno := 'Error: no determinado al validar ventas';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_ven_no_validas_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_ven_no_validas_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_val_ven_no_validas_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_obtiene_valor_parametro_fn (
      ev_nomparametro   IN         ged_parametros.nom_parametro%TYPE,
      ev_codmodulo      IN         ged_parametros.cod_modulo%TYPE,
      ev_codproducto    IN         ged_parametros.cod_producto%TYPE,
      sv_valparametro   OUT NOCOPY ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           d_fecha_actualizacion  ert_datos_consulta_to.fecha_actualizacion%TYPE;
           trama_no_vigente       EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

       LV_Sql := 'SELECT a.val_parametro '
              || 'FROM ged_parametros a '
              || 'WHERE a.nom_parametro = ' || EV_nomparametro
              || ' AND a.cod_modulo = ' || EV_codmodulo
              || ' AND a.cod_producto = ' || EV_codproducto;

       SELECT a.val_parametro
         INTO SV_valparametro
         FROM ged_parametros a
        WHERE a.nom_parametro  = EV_nomparametro
          AND a.cod_modulo     = EV_codmodulo
          AND a.cod_producto   = EV_codproducto;

           RETURN TRUE;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := '475';
        sv_mens_retorno := 'Error: el parametro no existe';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_obtiene_valor_parametro_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtiene_valor_parametro_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        sn_cod_retorno  := '476';
        sv_mens_retorno := 'Error: no determinado al recueprar parametro';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_obtiene_valor_parametro_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_obtiene_valor_parametro_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obtiene_valor_parametro_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_val_cliente_vetado_fn (
      ev_num_ident      IN          ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN          ged_parametros.cod_modulo%TYPE,
      sb_clie_vetado    OUT NOCOPY  BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
       cant_vetado            NUMBER(2);
           error_vetado   EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

       LV_Sql := 'SELECT count(1) FROM erd_clientes_vetados WHERE num_ident_cliente = '||ev_num_ident
              || ' AND cod_tipident = '||ev_cod_tipident
              || ' AND '||SYSDATE||' BETWEEN fec_impedimento_h AND fec_hasta';

       SELECT count(1)
         INTO cant_vetado
         FROM erd_clientes_vetados
        WHERE num_ident_cliente = ev_num_ident
          AND cod_tipident = ev_cod_tipident
          AND SYSDATE BETWEEN fec_impedimento_h AND fec_hasta;

       IF cant_vetado > 0 THEN
          RAISE error_vetado;
       END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN error_vetado THEN
        sn_cod_retorno  := '477';
        sv_mens_retorno := 'Error: Cliente vetado no puede generar evaluación de riesgo';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_cliente_vetado_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_cliente_vetado_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '512';
        sv_mens_retorno := 'Error: al evaluar cliente vetado';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_val_cliente_vetado_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_val_cliente_vetado_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
   END er_val_cliente_vetado_fn;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_rec_personeria_cliente_fn (
      ev_cod_tipident   IN          VARCHAR2,
          sv_personeria     OUT NOCOPY  VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           cant_vetado            NUMBER(2);
           v_tipident_juridico    VARCHAR2(100);
           error_ejecucion        EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           IF NOT (er_obtiene_valor_parametro_fn(cv_ind_tipidentjuridico,cv_modulo_ga,cn_producto,v_tipident_juridico,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
          RAISE error_ejecucion;
           END IF;

       LV_sql := ev_cod_tipident||' = SUBSTR('||v_tipident_juridico||', 1,2) OR '||ev_cod_tipident||' = SUBSTR('||v_tipident_juridico||', 3,2)';

           IF (ev_cod_tipident = SUBSTR(v_tipident_juridico, 1,2) OR ev_cod_tipident = SUBSTR(v_tipident_juridico, 3,2)) THEN
              sv_personeria := 'PJ';
           ELSE
              sv_personeria := 'PN';
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_personeria_cliente_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_personeria_cliente_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '478';
        sv_mens_retorno := 'Error: no determinado al recueperar personeria';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_personeria_cliente_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_personeria_cliente_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_rec_personeria_cliente_fn;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_def_tipo_cliente_fn (
      ev_num_ident      IN          ert_datos_consulta_to.num_ident%TYPE ,
      ev_cod_tipident   IN          ert_datos_consulta_to.cod_tipident%TYPE,
          sv_tip_clie           OUT NOCOPY  VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           exist_proceso          EXCEPTION;
           b_exist_clie           BOOLEAN;
           b_bajas_n_val          BOOLEAN;
           b_suspen_n_val         BOOLEAN;
           b_vent_n_val           BOOLEAN;
           b_antiguedad           BOOLEAN;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';


       IF NOT (er_val_existe_cliente_fn (ev_num_ident,ev_cod_tipident,b_exist_clie,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
          RAISE error_ejecucion;
       END IF;

           IF (NOT b_exist_clie) THEN
              sv_tip_clie := 'NU';
              RAISE exist_proceso;
           ELSE
              sv_tip_clie := 'AA';
           END IF;

/*         IF NOT (er_val_antiguedad_abon_fn (ev_num_ident,ev_cod_tipident,b_antiguedad,sn_codretorno,sv_menretorno,sn_numevento)) THEN
              RAISE error_ejecucion;
           END IF;

           IF NOT (b_antiguedad) THEN
          sv_tip_clie := 'AA';
              RAISE exist_proceso;
           END IF;

       IF NOT (er_val_baja_no_validas_fn (ev_num_ident,ev_cod_tipident,b_bajas_n_val,sn_codretorno,sv_menretorno,sn_numevento)) THEN
          RAISE error_ejecucion;
       END IF;

           IF (b_bajas_n_val) THEN
          sv_tip_clie := 'AA';
              RAISE exist_proceso;
           END IF;

       IF NOT (er_val_sus_no_validas_fn (ev_num_ident,ev_cod_tipident,b_suspen_n_val,sn_codretorno,sv_menretorno,sn_numevento)) THEN
          RAISE error_ejecucion;
       END IF;

           IF (b_suspen_n_val) THEN
          sv_tip_clie := 'AA';
              RAISE exist_proceso;
           END IF;

       IF NOT (er_val_ven_no_validas_fn (ev_num_ident,ev_cod_tipident,b_vent_n_val,sn_codretorno,sv_menretorno,sn_numevento)) THEN
          RAISE error_ejecucion;
       END IF;

           IF (b_vent_n_val) THEN
          sv_tip_clie := 'AA';
              RAISE exist_proceso;
           END IF;              */

           RETURN TRUE;


   EXCEPTION
     WHEN exist_proceso THEN
            RETURN TRUE;
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_def_tipo_cliente_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_def_tipo_cliente_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '479';
        sv_mens_retorno := 'Error: no determinado al calcular tipo de cliente';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_def_tipo_cliente_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_def_tipo_cliente_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_def_tipo_cliente_fn;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_valida_vig_trama_fn (
      ev_num_ident          IN          ert_datos_consulta_to.num_ident%TYPE ,
      ev_cod_tipident       IN          ert_datos_consulta_to.cod_tipident%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           d_fecha_actualizacion  ert_datos_consulta_to.fecha_actualizacion%TYPE;
           vig_dat_externa        ged_parametros.val_parametro%TYPE;
           error_ejecucion        EXCEPTION;
           trama_no_vigente       EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           IF NOT (er_obtiene_valor_parametro_fn ('VIGENCIA_DAT_EXTERNA','GA',1,vig_dat_externa,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

           LV_sql := 'SELECT max(a.fecha_actualizacion)'
              || ' FROM ert_datos_consulta_to a'
              || ' WHERE a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
                      || ' AND a.ind_tipo_solicitud = 1';

       SELECT max(a.fecha_actualizacion)
             INTO d_fecha_actualizacion
         FROM ert_datos_consulta_to a
        WHERE a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
                  AND a.ind_tipo_solicitud = 1;


       IF d_fecha_actualizacion IS  NULL THEN
          RAISE NO_DATA_FOUND;
       END IF;


           LV_sql := 'IF '||d_fecha_actualizacion||' + '||vig_dat_externa||' <= '||TRUNC(SYSDATE)||' THEN';

           IF d_fecha_actualizacion + vig_dat_externa <= TRUNC(SYSDATE) THEN
              RAISE trama_no_vigente;
           END IF;

           RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN trama_no_vigente THEN
        sn_cod_retorno  := '480';
        sv_mens_retorno := 'Error: trama no vigente';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := '481';
        sv_mens_retorno := 'Error: no existe trama';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        sn_cod_retorno  := '482';
        sv_mens_retorno := 'Error: no determinado validar vigencia trama';
        lv_des_error    := 'er_integracion_eriesgo_pg.pv_upd_fh_eje_iorserv_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_valida_vig_trama_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_rec_renta_pj_fn (
          ev_tipo_score        IN          VARCHAR2,
          en_puntaje           IN          NUMBER,
          en_ingresos          IN          NUMBER,
      sn_cod_proceso       OUT NOCOPY  erd_procesos.cod_proceso%TYPE,
          sv_nom_proceso       OUT NOCOPY  erd_procesos.nom_proceso%TYPE,
          sn_cod_acreditacion  OUT NOCOPY  erd_procesos.cod_acreditacion%TYPE,
          sn_cod_esquema       OUT NOCOPY  erd_procesos.cod_esquema%TYPE,
          sn_mto_garantia      OUT NOCOPY  erd_procesos.mto_garantia%TYPE,
          sn_mto_renta         OUT NOCOPY  erd_procesos.mto_renta%TYPE,
          sn_tip_proceso       OUT NOCOPY  erd_procesos.tip_proceso%TYPE,
          sn_val_rentacb_ini   OUT NOCOPY  er_clasif_cargo_basico_td.val_rentacb_ini%TYPE,
          sn_val_rentacb_fin   OUT NOCOPY  er_clasif_cargo_basico_td.val_rentacb_fin%TYPE,
      sn_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       error_ejecucion        EXCEPTION;
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           cant_suspen            NUMBER(2);
           esq_sel_tip_a          VARCHAR2(10);

           o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           sn_val_rentacb_ini   := NULL;
           sn_val_rentacb_fin   := NULL;

           o_erd_parametros.cod_codigo := 300;
           o_erd_parametros.cod_subcodigo := 4;
           o_erd_parametros.cod_parametro := 1;
           IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

           esq_sel_tip_a := o_erd_parametros.val_parametro1;

       LV_sql := 'SELECT cod_proceso, nom_proceso, cod_acreditacion, cod_esquema, mto_garantia, mto_renta, tip_proceso'
              || ' FROM erd_procesos WHERE cod_acreditacion IS NOT NULL'
                      || ' AND tip_proceso = '||esq_sel_tip_a
                          || ' AND mto_renta_minima IN (SELECT MAX (mto_renta_minima)'
                                                        || ' FROM erd_procesos a'
                                                        || ' WHERE a.cod_acreditacion IS NOT NULL'
                                                        || ' AND a.tip_proceso = '||esq_sel_tip_a
                                                        || ' AND '||en_ingresos||' >= a.mto_renta_minima)'
                                                  || ' AND mto_renta >= '||en_ingresos;

           IF (er_is_number_fn(ev_tipo_score)) THEN

           LV_sql := LV_sql || ' AND COD_PROCESO IN'
                            || ' (SELECT COD_PROCESO'
                            || ' FROM ERD_PUNTAJE_TD'
                            || ' WHERE '|| en_puntaje ||'  BETWEEN RANGO_DESDE AND RANGO_HASTA )';
       END IF;

           EXECUTE IMMEDIATE LV_sql INTO sn_cod_proceso, sv_nom_proceso, sn_cod_acreditacion, sn_cod_esquema, sn_mto_garantia, sn_mto_renta, sn_tip_proceso;

       sn_cod_acreditacion  := NULL;

       IF (sv_nom_proceso IS NULL) THEN
           RAISE NO_DATA_FOUND;
       END IF;


           RETURN TRUE;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := '495';
        sv_mens_retorno := 'Error: INGRESOS no parametrizados en ERD_PROCESOS';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_pj_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_pj_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_pj_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_pj_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '483';
        sv_mens_retorno := 'Error: no determinado al calcular renta persona juridica';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_pj_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_pj_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_rec_renta_pj_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_rec_renta_pn_fn (
      ev_clasificacion     IN          er_clasif_cargo_basico_td.cod_gama%TYPE,
      ev_gama              IN          er_clasif_cargo_basico_td.cod_clasificacion%TYPE,
          ev_gcc               IN          VARCHAR2,
          sn_cod_acreditacion  OUT NOCOPY  erd_procesos.cod_acreditacion%TYPE,
          sn_cod_esquema       OUT NOCOPY  erd_procesos.cod_esquema%TYPE,
          sn_mto_garantia      OUT NOCOPY  erd_procesos.mto_garantia%TYPE,
      sn_mto_limcargobas   OUT NOCOPY  er_clasif_cargo_basico_td.mto_limcargobas%TYPE,
          sn_val_rentacb_ini   OUT NOCOPY  er_clasif_cargo_basico_td.val_rentacb_ini%TYPE,
          sn_val_rentacb_fin   OUT NOCOPY  er_clasif_cargo_basico_td.val_rentacb_fin%TYPE,
      sn_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           cant_suspen            NUMBER(2);
           error_dato_null        EXCEPTION;
           error_cla_gama         EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

       IF ((Trim(ev_clasificacion) IS NULL) AND Trim(ev_gama) IS NULL) THEN
          LV_sql := 'Trim(['||ev_clasificacion||']) IS NULL) AND Trim(['||ev_gama||']) IS NULL';
                  RAISE error_cla_gama;
       ELSE

               LV_sql := 'SELECT a.mto_limcargobas, a.val_rentacb_ini, a.val_rentacb_fin FROM er_clasif_cargo_basico_td a'
                  || ' WHERE a.fec_vigencia_fin >= '||SYSDATE
                              || ' AND a.fec_vigencia_ini = (SELECT MAX (b.fec_vigencia_ini) FROM er_clasif_cargo_basico_td b'
                  || ' WHERE b.cod_clasificacion = '||ev_clasificacion
                                  || ' AND b.cod_gama = '||ev_gama||')'
                              || ' AND a.cod_clasificacion = '||ev_clasificacion
                              || ' AND a.cod_gama = '||ev_gama;

           SELECT a.mto_limcargobas, a.val_rentacb_ini, a.val_rentacb_fin
             INTO sn_mto_limcargobas, sn_val_rentacb_ini, sn_val_rentacb_fin
             FROM er_clasif_cargo_basico_td a
            WHERE a.fec_vigencia_fin >= SYSDATE
                          AND a.fec_vigencia_ini = (SELECT MAX (b.fec_vigencia_ini)
                                          FROM er_clasif_cargo_basico_td b
                                         WHERE b.cod_clasificacion = ev_clasificacion
                                                                                   AND b.cod_gama = ev_gama)
                          AND a.cod_clasificacion = ev_clasificacion
                          AND a.cod_gama = ev_gama;

          IF ((sn_mto_limcargobas IS NULL) OR (sn_val_rentacb_ini IS NULL) OR (sn_val_rentacb_fin IS NULL)) Then
             LV_sql := '('||sn_mto_limcargobas||' IS NULL) OR ('||sn_val_rentacb_ini||' IS NULL) OR ('||sn_val_rentacb_fin||' IS NULL';
                 RAISE error_dato_null;
          END IF;

       END IF;

           /*el gcc siempre prima antes del valor de la tabla*/

       IF er_is_number_fn(ev_gcc) THEN
          IF (to_number(ev_gcc) > 0) THEN
                     DBMS_OUTPUT.Put_Line('PN ev_gcc * 1000');
             sn_mto_limcargobas := ev_gcc * 1000;
                     DBMS_OUTPUT.Put_Line('PN RENTA['||sn_mto_limcargobas||']');
          END IF;
       END IF;

           sn_cod_acreditacion  := 1;
           sn_cod_esquema       := 0;
           sn_mto_garantia      := 0;
           sn_cod_acreditacion  := NULL;

           RETURN TRUE;

   EXCEPTION
     WHEN error_cla_gama THEN
        sn_cod_retorno  := '484';
        sv_mens_retorno := 'Error: al validar clasificacion o gama';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
     WHEN error_dato_null THEN
        sn_cod_retorno  := '485';
        sv_mens_retorno := 'Error: No existe paramerización para los montos límites de Cargos básicos';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
     WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := '485';
        sv_mens_retorno := 'Error: No existe paramerización para los montos límites de Cargos básicos';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '486';
        sv_mens_retorno := 'Error: no determinado al calcular renta persona natural';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_pn_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END  er_rec_renta_pn_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_rec_renta_clie_fn (
      ev_num_ident        IN             ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident     IN             ged_parametros.cod_modulo%TYPE,
      ev_personeria       IN             VARCHAR2,
      en_ingresos         IN             NUMBER,
          en_cod_vendedor     IN             ve_vendedores.cod_vendedor%TYPE,
      eo_datosburo        IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_mto_renta        OUT NOCOPY     NUMBER,
      sn_val_rentacb_ini  OUT NOCOPY     er_clasif_cargo_basico_td.val_rentacb_ini%TYPE,
      sn_val_rentacb_fin  OUT NOCOPY     er_clasif_cargo_basico_td.val_rentacb_fin%TYPE,
      sn_cod_acreditacion OUT NOCOPY     erd_procesos.cod_acreditacion%TYPE,
      sn_mto_garantia     OUT NOCOPY     erd_procesos.mto_garantia%TYPE,
      sn_cod_esquema      OUT NOCOPY     erd_procesos.cod_esquema%TYPE,
      sn_gcc              OUT NOCOPY     NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();
       n_procentajerenta      NUMBER;
           n_puntaje              NUMBER;
       n_cod_proceso          erd_procesos.cod_proceso%TYPE;
           v_nom_proceso          erd_procesos.nom_proceso%TYPE;



           n_tip_proceso          erd_procesos.tip_proceso%TYPE;
       n_mto_limcargobas      er_clasif_cargo_basico_td.mto_limcargobas%TYPE;
           n_importeimp           NUMBER;
       error_personeria       EXCEPTION;
           error_ejecucion        EXCEPTION;
           error_gcc              EXCEPTION;
       lv_cant_decimales  ged_parametros.val_parametro%type;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';




          IF NOT (er_obtiene_cargosbasicos_fn (ev_num_ident,ev_cod_tipident,en_cod_vendedor,n_importeimp,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

           o_erd_parametros.cod_codigo := 300;
           o_erd_parametros.cod_subcodigo := 2;
           o_erd_parametros.cod_parametro := 1;
           IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;
           n_procentajerenta := o_erd_parametros.val_parametro1;

           IF NOT (er_calcula_gama_fn (eo_datosburo.registro20.gama,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

       IF NOT (er_calcula_calificacion_fn (eo_datosburo.registro20.calificacion,n_puntaje,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

           IF ev_personeria = 'PN' THEN

                 IF NOT (er_rec_renta_pn_fn (eo_datosburo.registro20.clasificacion,
                                                             eo_datosburo.registro20.gama,
                                                                                         eo_datosburo.registro20.gcc,
                                                                                         sn_cod_acreditacion,
                                                                                         sn_cod_esquema,
                                                                                         sn_mto_garantia,
                                                                                         sn_mto_renta,
                                                                                         sn_val_rentacb_ini, sn_val_rentacb_fin,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
                     RAISE error_ejecucion;
                  END IF;

                  /* para persona natural se debe inferir la renta en base al gcc*/
                  LV_sql := '('||sn_mto_renta||' * '||100||') / '||n_procentajerenta;

                                  DBMS_OUTPUT.Put_Line('sn_gcc = RENTA-IMP['||sn_mto_renta||'] - ['||n_importeimp||']');
                  sn_gcc := sn_mto_renta-n_importeimp;
                  sn_mto_renta := ((sn_mto_renta * 100) / n_procentajerenta);
                  IF sn_gcc <= 0 THEN
                     RAISE error_gcc;
                  END IF;
           ELSIF ev_personeria = 'PJ' THEN

                  IF NOT (er_rec_renta_pj_fn (eo_datosburo.registro20.tipo_score,n_puntaje,en_ingresos,n_cod_proceso,v_nom_proceso,sn_cod_acreditacion,sn_cod_esquema,sn_mto_garantia,sn_mto_renta,n_tip_proceso,sn_val_rentacb_ini,sn_val_rentacb_fin,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
                     RAISE error_ejecucion;
                  END IF;
                  LV_sql := '('||sn_mto_renta||' * '||n_procentajerenta||') / '||100;

                  --MLCB : Monto limite de cargos basicos
                  sn_gcc := ((sn_mto_renta * n_procentajerenta) / 100) - n_importeimp;
                  IF sn_gcc <= 0 THEN
                     RAISE error_gcc;
                  END IF;

          ELSE
              RAISE error_personeria;
          END IF;


          IF NOT (er_obtiene_valor_parametro_fn (CV_PARAMETRO_DECIMAL,cv_modulo_ge,cn_producto,lv_cant_decimales,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
             RAISE error_ejecucion;
          END IF;

          sn_mto_renta:=round(sn_mto_renta,NVL(lv_cant_decimales,0));

           RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN error_personeria THEN
        sn_cod_retorno  := '487';
        sv_mens_retorno := 'Error: personeria no existente';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN error_gcc THEN
        sn_cod_retorno  := '488';
        sv_mens_retorno := 'La suma de cargos Basicos es mayor al monto limite';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '489';
        sv_mens_retorno := 'Error: no determinado al calcular la renta del cliente';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_renta_clie_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_rec_renta_clie_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_rec_planes_fn (
      ev_num_ident      IN              ged_parametros.nom_parametro%TYPE,
      ev_cod_tipident   IN              ged_parametros.cod_modulo%TYPE,
      ev_personeria     IN              VARCHAR2,
      en_renta_ini      IN              NUMBER,
      en_renta_fin      IN              NUMBER,
      en_cargo_bas_max  IN              NUMBER,
      ev_tipo_producto  IN              VARCHAR2,
      ev_tipo_plan      IN              VARCHAR2,
          en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sc_planes         OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
       LV_sql1                ge_errores_pg.vquery;
       LV_sql2                ge_errores_pg.vquery;
       LV_sql3                ge_errores_pg.vquery;
       n_imp                  NUMBER;
       LV_tipoProducto        ta_plantarif.COD_TIPLAN%TYPE;
           lv_count               NUMBER;
           error_planes           EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

           n_imp := ER_INTEGRACION_IMPUESTO_PG.er_obtenerimpuesto_num_fn(ev_num_ident,ev_cod_tipident,en_cod_vendedor);

           LV_sql1 := 'SELECT a.cod_plantarif, a.des_plantarif';

           LV_sql3 := 'SELECT count(1)';

           LV_sql2 := ' FROM ta_cargosbasico b, ta_plantarif a, ga_planuso c WHERE a.cod_cargobasico = b.cod_cargobasico'
              || ' AND a.cod_producto  = b.cod_producto'
              || ' AND a.cod_producto  = 1'
              || ' AND a.cla_plantarif <> ''SRV'''
              || ' AND a.ind_comer_web = '||CN_PLANCOMERVIAWEB
              || ' AND a.cod_plantarif = c.cod_plantarif'
              || ' AND a.cod_producto  = c.cod_producto(+)'
              || ' AND NVL (a.fec_hasta, SYSDATE) >= SYSDATE'
              || ' AND NVL (b.fec_hasta, SYSDATE) >= SYSDATE';

       IF (ev_tipo_plan IS NOT NULL) THEN
          LV_sql2 := LV_sql2|| ' AND a.tip_plantarif = ''' ||  UPPER(ev_tipo_plan)|| '''';
       END IF;



       IF (ev_tipo_producto = CV_TIPPROCOL_PREPAGO) THEN
           LV_tipoProducto := CV_TIPPROSCL_PREPAGO;
       END IF;

       -- Tipo producto postpago
       IF (ev_tipo_producto = CV_TIPPROCOL_POSTPAGO) THEN
           LV_tipoProducto := CV_TIPPROSCL_POSTPAGO;
       END IF;

       -- Tipo producto hibrido
       IF (ev_tipo_producto = CV_TIPPROCOL_HIBRIDO) THEN
           LV_tipoProducto := CV_TIPPROSCL_HIBRIDO;
       END IF;

       IF (ev_tipo_producto IS NOT NULL) THEN
          LV_sql2 := LV_sql2|| ' AND a.cod_tiplan = ' || LV_tipoProducto;
       END IF;

       IF (LV_tipoProducto = cn_coduso_postpago) THEN
          LV_sql2 := LV_sql2|| ' AND c.cod_uso = '||cn_coduso_postpago ;
       ELSIF (LV_tipoProducto = cn_coduso_hibrido) THEN
          LV_sql2 := LV_sql2|| ' AND c.cod_uso = '||cn_coduso_hibrido;
       END IF;

           DBMS_OUTPUT.Put_Line('en_cargo_bas_max = ' || TO_CHAR(en_cargo_bas_max));
           DBMS_OUTPUT.Put_Line('en_renta_fin = ' || TO_CHAR(en_renta_fin));

       IF (ev_personeria = 'PN') THEN
           IF (en_cargo_bas_max < en_renta_fin) THEN
               LV_sql2 := LV_sql2 || ' AND ROUND(b.imp_cargobasico*' || n_imp || ') between '||en_renta_ini||' AND '|| en_cargo_bas_max;
           ELSE
               LV_sql2 := LV_sql2 || ' AND ROUND(b.imp_cargobasico*'||n_imp||') between '||en_renta_ini||' AND '|| en_renta_fin;
           END IF;

       ELSE
           LV_sql2 := LV_sql2 || ' AND ROUND(b.imp_cargobasico* TO_NUMBER(TO_CHAR(''' || n_imp || '''))' ||') <= TO_NUMBER(TO_CHAR(''' || en_cargo_bas_max || '''))';
       END IF;

           LV_sql := LV_sql3||LV_sql2;

           EXECUTE IMMEDIATE LV_sql INTO lv_count;

           IF (lv_count = 0 OR lv_count IS NULL) THEN
              RAISE error_planes;
           END IF;

           LV_sql := LV_sql1||LV_sql2;

       OPEN sc_planes FOR LV_sql;

       RETURN TRUE;

   EXCEPTION
     WHEN error_planes THEN
        sn_cod_retorno  := '468';
        sv_mens_retorno := 'Error: no se encuentran planes tarifarios que cumplan los criterios de evaluación';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_planes_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_planes_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '490';
        sv_mens_retorno := 'Error: no determinado al recuparar planes';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_planes_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_planes_fn', lv_sql, SQLCODE, lv_des_error);
        RETURN FALSE;
   END er_rec_planes_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_registra_solicitud_fn (
      ev_cod_tipident            IN              VARCHAR2,
      ev_num_ident               IN              VARCHAR2,
      ev_ind_personeria          IN              VARCHAR2,
      ev_ind_tipo_cliente        IN              VARCHAR2,
      en_cod_esquema             IN              NUMBER,
      ev_cod_usuario_evaluacion  IN              VARCHAR2,
      ev_usuario_evaluacion      IN              VARCHAR2,
      en_cod_vendedor            IN              NUMBER,
      en_cod_vendealer           IN              NUMBER,
      en_monto_renta             IN OUT NOCOPY   NUMBER,
      en_cod_acreditacion        IN              NUMBER,
      en_monto_garantia          IN              NUMBER,
          ec_planes                  IN              refcursor,
      eo_datosburo               IN OUT NOCOPY   ER_DATOSBURO_OT,
          sn_num_solicitud           OUT NOCOPY      NUMBER,
      sn_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           n_imp                  NUMBER;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

       SELECT ers_solicitud.NEXTVAL
             INTO sn_num_solicitud
         FROM DUAL;

       IF NOT (er_integracion_solicitud_pg.er_procesa_solicitud_fn(sn_num_solicitud,eo_datosburo,ev_ind_personeria,ev_cod_tipident,ev_num_ident,ev_ind_tipo_cliente,en_cod_esquema,ev_cod_usuario_evaluacion,en_cod_vendedor,en_cod_vendealer,ev_usuario_evaluacion,en_monto_renta,en_cod_acreditacion,en_monto_garantia,eo_datosburo.registro99.cod_respuesta,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

           IF NOT (er_integracion_solicitud_pg.er_procesa_solicitud_planes_fn (sn_num_solicitud,ec_planes,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

           IF NOT (er_integracion_solicitud_pg.er_procesa_detcampos_fn(sn_num_solicitud,eo_datosburo,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;

       IF NOT (er_integracion_solicitud_pg.er_procesa_solicitudcampos_fn(sn_num_solicitud,eo_datosburo,ev_ind_personeria,ev_cod_tipident,ev_num_ident,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
           END IF;


           RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_registra_solicitud_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_registra_solicitud_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '491';
        sv_mens_retorno := 'Error: no determinado al registrar solicitud';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_registra_solicitud_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_registra_solicitud_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_registra_solicitud_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_rec_inf_solicitud_fn (
      en_numsolicitud    IN         ert_solicitud.NUM_SOLICITUD%TYPE,
          ev_tipoproducto    IN         ta_plantarif.COD_TIPLAN%TYPE,
          ev_tipplantarif    IN         ta_plantarif.TIP_PLANTARIF%TYPE,
      sv_nombre          OUT NOCOPY ert_solicitud_campos.nombre_cliente%TYPE,
          sv_apellido        OUT NOCOPY ert_solicitud_campos.primer_apellido%TYPE,
          sv_apellido2       OUT NOCOPY ert_solicitud_campos.segundo_apellido%TYPE,
      sv_nom_usuario     OUT NOCOPY ert_solicitud.nom_usuario_evaluacion%TYPE,
          sv_fecha_creacion      OUT NOCOPY ert_solicitud.fec_ingreso_h%TYPE,
          sc_cursordatos     OUT NOCOPY refcursor,
      sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           n_imp                  NUMBER;
       n_num_solicitud        NUMBER;
       LV_tipoProducto        TA_PLANTARIF.COD_TIPLAN%TYPE;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      IF (ev_tipoproducto = CV_TIPPROCOL_PREPAGO) THEN
           LV_tipoProducto := CV_TIPPROSCL_PREPAGO;
       END IF;

       -- Tipo producto postpago
       IF (ev_tipoproducto = CV_TIPPROCOL_POSTPAGO) THEN
           LV_tipoProducto := CV_TIPPROSCL_POSTPAGO;
       END IF;

       -- Tipo producto hibrido
       IF (ev_tipoproducto = CV_TIPPROCOL_HIBRIDO) THEN
           LV_tipoProducto := CV_TIPPROSCL_HIBRIDO;
       END IF;

       er_servicios_evalriesgo_web_pg.er_getlistplantarifsolic_pr(en_numsolicitud,LV_tipoProducto,ev_tipplantarif,sc_cursordatos,sn_cod_retorno, sv_mens_retorno, sn_num_evento);
       IF SN_cod_Retorno <> 0 THEN
          RAISE error_ejecucion;
           END IF;

       er_servicios_evalriesgo_web_pg.er_getnombrecliente_pr(en_numsolicitud,sv_nombre,sv_apellido,sv_apellido2,sn_cod_retorno, sv_mens_retorno, sn_num_evento);
       IF SN_cod_Retorno <> 0 THEN
          RAISE error_ejecucion;
           END IF;


           er_servicios_evalriesgo_web_pg.ER_getdatosSolicitud_PR(en_numsolicitud,sv_nom_usuario,sv_fecha_creacion,sn_cod_retorno, sv_mens_retorno, sn_num_evento);

           RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_inf_solicitud_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_inf_solicitud_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '492';
        sv_mens_retorno := 'Error: no determinado al recuperar solicitud';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_rec_inf_solicitud_fn(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_rec_inf_solicitud_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_rec_inf_solicitud_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION er_cuenta_solicitud_fn (
      ev_num_ident          IN          ert_Solicitud.num_ident_cliente%TYPE ,
      ev_cod_tipident       IN          ert_solicitud.cod_tipident%TYPE,
      ev_cod_estado         IN          VARCHAR2,
      en_num_solicitud      IN          ert_solicitud.num_solicitud%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           trama_no_vigente       EXCEPTION;
       LV_COUNT               NUMBER(4);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

   IF  en_num_solicitud is NULL THEN

           DBMS_OUTPUT.Put_Line('en_num_solicitud ['||en_num_solicitud||']');

       LV_sql:='SELECT COUNT(1)'
       || ' FROM ERT_SOLICITUD'
       || ' WHERE NUM_IDENT_CLIENTE = ''' || ev_num_ident ||''''
       || ' AND COD_TIPIDENT = '''|| ev_cod_tipident||''''
       || ' AND COD_ESTADO  IN ('||ev_cod_estado||')';


           DBMS_OUTPUT.Put_Line('en_num_solicitud ['||LV_sql||']');
           DBMS_OUTPUT.Put_Line('ev_cod_tipident ['||ev_cod_tipident||']');
           DBMS_OUTPUT.Put_Line('en_num_solicitud ['||ev_num_ident||']');

           EXECUTE IMMEDIATE LV_sql INTO lv_count;



   ELSE
       LV_sql:='SELECT COUNT(1)'
       || ' FROM ERT_SOLICITUD'
       || ' WHERE NUM_Solicitud = ' ||  en_num_solicitud
       || ' AND COD_ESTADO  IN ('||ev_cod_estado||')';

           EXECUTE IMMEDIATE LV_sql INTO lv_count;

   END IF;

   IF LV_COUNT >0 THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;



   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '500';
        sv_mens_retorno := 'Error al recuperar estado de la solicitud';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_cuenta_solicitud_fn; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_cuenta_solicitud_fn;

   FUNCTION er_cuenta_planesSolic_fn (
      en_num_solicitud      IN              ert_solicitud.num_solicitud%TYPE,
      ev_cod_plantarif      IN              ert_solicitud_planes.cod_plantarif%TYPE,
      sn_cod_retorno        OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno       OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           trama_no_vigente       EXCEPTION;
       LV_COUNT               NUMBER(4);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

   LV_sql:='SELECT COUNT(1)'
   || 'FROM ERT_SOLICITUD_PLANES'
   || 'WHERE COD_PLANTARIF= ' || ev_cod_plantarif;

   SELECT COUNT (1)
     INTO lv_count
     FROM ert_solicitud_planes
    WHERE cod_plantarif = ev_cod_plantarif;


   IF LV_COUNT >0 THEN
      RETURN TRUE;
   ELSE
      RAISE NO_DATA_FOUND;
      RETURN FALSE;
   END IF;


   EXCEPTION
    WHEN NO_DATA_FOUND THEN
        sn_cod_retorno  := '501';
        sv_mens_retorno := 'Plan Tarifario no existe para esta solicitud';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_cuenta_solicitud_fn; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '501';
        sv_mens_retorno := 'Plan Tarifario no existe para esta solicitud';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_cuenta_solicitud_fn; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_cuenta_planesSolic_fn;


FUNCTION er_obt_datosEval_fn (
      en_num_solicitud      IN          ert_solicitud.num_solicitud%TYPE,
      sv_num_ident          OUT NOCOPY  ert_Solicitud.num_ident_cliente%TYPE ,
      sv_cod_tipident       OUT NOCOPY  ert_solicitud.cod_tipident%TYPE,
      sn_cod_retorno        OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno       OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
      sn_num_evento         OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           error_ejecucion        EXCEPTION;
           trama_no_vigente       EXCEPTION;
       LV_COUNT               NUMBER(4);
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';


      LV_sql:='SELECT NUM_IDENT_CLIENTE,COD_TIPIDENT'
      ||' FROM ERT_SOLICITUD'
      || 'WHERE NUM_SOLICITUD= ' || en_num_solicitud;

      SELECT num_ident_cliente, cod_tipident
        INTO sv_num_ident, sv_cod_tipident
        FROM ert_solicitud
       WHERE num_solicitud = en_num_solicitud;

      RETURN TRUE;


   EXCEPTION
     WHEN OTHERS THEN
        sn_cod_retorno  := '501';
        sv_mens_retorno := 'Error al recuperar datos de la solicitud';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_cuenta_solicitud_fn; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_valida_vig_trama_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_obt_datosEval_fn;
   FUNCTION er_elimina_preevaluaciones_fn (
      ev_num_ident          IN          ert_Solicitud.num_ident_cliente%TYPE ,
      ev_cod_tipident       IN          ert_solicitud.cod_tipident%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
       error_ejecucion        EXCEPTION;
       LV_COUNT               NUMBER(4);
       o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();
       Cn_Codigo_Estado           CONSTANT NUMBER       := 100;
       Cn_Subcodigo_Estado        CONSTANT NUMBER       := 6;
       Cn_Parametro_Estado        CONSTANT NUMBER       := 10;
       Cn_Parametro_Rechazada     CONSTANT NUMBER       := 9;
       Cn_Parametro_Eval          CONSTANT NUMBER       := 1;
       ERROR_PARAMETRO            EXCEPTION;
   BEGIN

      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      /**1.- Obtener Parametro con estado valido para la Preevaluacion*/
       o_erd_parametros.cod_codigo :=    CN_CODIGO_ESTADO;
       o_erd_parametros.cod_subcodigo := CN_SUBCODIGO_ESTADO;
       o_erd_parametros.cod_parametro := CN_PARAMETRO_ESTADO;
       IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
          RAISE ERROR_PARAMETRO;
       END IF;


      update ert_solicitud
      set cod_estado=Cn_Parametro_Rechazada
      where num_ident_cliente=ev_num_ident
      and cod_tipident=ev_cod_tipident
      and cod_estado = o_erd_parametros.val_parametro1
      and ind_tipo_solicitud=Cn_Parametro_Eval;


      RETURN TRUE;

   EXCEPTION
     WHEN ERROR_PARAMETRO THEN
        sn_cod_retorno  := '514';
        sv_mens_retorno := 'Error al eliminar preevaluaciones';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_elimina_preevaluaciones_fn; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_elimina_preevaluaciones_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        sn_cod_retorno  := '514';
        sv_mens_retorno := 'Error al eliminar preevaluaciones';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_elimina_preevaluaciones_fn; - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_elimina_preevaluaciones_fn', lv_sql, SQLCODE, lv_des_error);
            RETURN FALSE;
   END er_elimina_preevaluaciones_fn;



   PROCEDURE er_listar_planes_pr (
      ev_num_ident          IN              ERT_SOLICITUD.NUM_IDENT_CLIENTE%TYPE,
      ev_cod_tipident       IN              GE_TIPIDENT.COD_TIPIDENT%TYPE,
      en_ingresos           IN              NUMBER,
      ev_cod_usuario        IN              ERT_SOLICITUD.COD_USUARIO_EVALUACION%TYPE,
      en_cod_vendedor       IN              VE_VENDEDORES.COD_VENDEDOR%TYPE,
      en_cod_vendealer      IN              VE_VENDEALER.COD_VENDEALER%TYPE,
      ev_tipo_producto      IN              VARCHAR2,
      ev_tipo_plan          IN              TA_PLANTARIF.TIP_PLANTARIF%TYPE,
      sn_solic              OUT NOCOPY      ERT_SOLICITUD.NUM_SOLICITUD%TYPE,
      sv_nombre             OUT NOCOPY      ert_solicitud_campos.nombre_cliente%TYPE,
      sv_apellido           OUT NOCOPY      ert_solicitud_campos.primer_apellido%TYPE,
      sv_apellido2          OUT NOCOPY      ert_solicitud_campos.segundo_apellido%TYPE,
      sv_usuario            OUT NOCOPY      ERT_SOLICITUD.NOM_USUARIO_EVALUACION%TYPE,
      sv_gcc                OUT NOCOPY      NUMBER,
      sv_fecha_creacion     OUT NOCOPY      ert_solicitud.fec_ingreso_h%TYPE,
      sc_cursordatos        OUT NOCOPY      refcursor,
      sn_cod_retorno        OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno       OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento
   )
   IS
       LV_des_error       ge_errores_pg.desevent;
       LV_sql             ge_errores_pg.vquery;
       c_trama            CLOB;
       error_ejecucion    EXCEPTION;
       b_clie_vetado      BOOLEAN;
       v_personeria       VARCHAR2(2);
       v_tip_clie         VARCHAR2(2);
       o_objeto           ER_DATOSBURO_OT := NEW ER_DATOSBURO_OT();
       n_monto_renta      NUMBER;
       n_val_rentacb_ini  er_clasif_cargo_basico_td.val_rentacb_ini%TYPE;
       n_val_rentacb_fin  er_clasif_cargo_basico_td.val_rentacb_fin%TYPE;
       n_cod_acreditacion erd_procesos.cod_acreditacion%TYPE;
       n_mto_garantia     erd_procesos.mto_garantia%TYPE;
       n_cod_esquema      erd_procesos.cod_esquema%TYPE;
       n_gcc              NUMBER;
       c_planes           refcursor;
       error_ingresos     EXCEPTION;
       error_ingresos2    EXCEPTION;
       lv_usuario         ert_solicitud.nom_usuario_evaluacion%type;
           v_cod_usuario      ert_solicitud.cod_usuario_evaluacion%type;
   BEGIN
      sn_cod_retorno  := 0;
      sn_num_evento   := 0;
      sv_mens_retorno := '';

      sv_usuario:=ev_cod_usuario;
          LV_sql := 'substr('||ev_cod_usuario||',1,12)';
          v_cod_usuario := substr(ev_cod_usuario,1,12);

      LV_sql := 'IF er_activo_buro_fn THEN';


      IF er_activo_buro_fn THEN


          LV_sql := 'er_val_cliente_vetado_fn';
          IF NOT (er_val_cliente_vetado_fn(ev_num_ident,ev_cod_tipident,b_clie_vetado,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_valida_vig_trama_fn';
          IF NOT (er_valida_vig_trama_fn(ev_num_ident,ev_cod_tipident,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_rec_personeria_cliente_fn';
          IF NOT (er_rec_personeria_cliente_fn(ev_cod_tipident,v_personeria,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          IF (v_personeria ='PJ') THEN
              IF en_ingresos is NULL THEN
                 RAISE error_ingresos2;
              END IF;
          END IF;

          LV_sql := 'er_def_tipo_cliente_fn';
          IF NOT (er_def_tipo_cliente_fn(ev_num_ident,ev_cod_tipident,v_tip_clie,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_integracion_buro_pg.er_recuperar_trama_fn';
          IF NOT (er_integracion_buro_pg.er_recuperar_trama_fn(ev_num_ident,ev_cod_tipident,c_trama,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_integracion_buro_pg.er_arma_objeto_trama2099_fn';
          IF NOT (er_integracion_buro_pg.er_arma_objeto_trama2099_fn(c_trama,o_objeto,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_valida_reg99_fn';
          IF NOT (er_valida_reg99_fn(v_personeria,o_objeto,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_valida_reg20_fn';
          IF NOT (er_valida_reg20_fn(v_personeria,o_objeto,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_rec_renta_clie_fn';
          IF NOT (er_rec_renta_clie_fn (ev_num_ident,ev_cod_tipident,v_personeria,en_ingresos,en_cod_vendedor,o_objeto,n_monto_renta,n_val_rentacb_ini, n_val_rentacb_fin,n_cod_acreditacion,n_mto_garantia,n_cod_esquema,n_gcc,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_rec_planes_fn';
          IF NOT (er_rec_planes_fn (ev_num_ident,ev_cod_tipident,v_personeria,n_val_rentacb_ini,n_val_rentacb_fin,n_gcc,ev_tipo_producto,ev_tipo_plan,en_cod_vendedor,c_planes,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_integracion_buro_pg.er_arma_objeto_trama_fn';
          IF NOT (er_integracion_buro_pg.er_arma_objeto_trama_fn(c_trama,o_objeto,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_elimina_preevaluaciones_fn';
          IF NOT (er_elimina_preevaluaciones_fn (ev_num_ident,ev_cod_tipident,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
             RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_registra_solicitud_fn';
          IF NOT (er_registra_solicitud_fn (ev_cod_tipident,ev_num_ident,v_personeria,v_tip_clie,n_cod_esquema,v_cod_usuario,sv_usuario,en_cod_vendedor,en_cod_vendealer,n_monto_renta,n_cod_acreditacion,n_mto_garantia,c_planes,o_objeto,sn_solic,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          LV_sql := 'er_rec_inf_solicitud_fn';
          IF NOT (er_rec_inf_solicitud_fn (sn_solic,ev_tipo_producto,ev_tipo_plan,sv_nombre,sv_apellido,sv_apellido2,lv_usuario,sv_fecha_creacion,sc_cursordatos,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;
          --Se asigna a parametro de salida el valor del GCC NRCA 16-12-2008
          sv_gcc:=n_gcc;

      ELSE

          IF en_ingresos is NULL THEN
             RAISE error_ingresos;
          END IF;

          v_personeria := 'PJ';

          IF NOT (er_val_cliente_vetado_fn(ev_num_ident,ev_cod_tipident,b_clie_vetado,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          IF NOT (er_def_tipo_cliente_fn(ev_num_ident,ev_cod_tipident,v_tip_clie,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          IF NOT (er_rec_renta_clie_fn (ev_num_ident,ev_cod_tipident,v_personeria,en_ingresos,en_cod_vendedor,o_objeto,n_monto_renta,n_val_rentacb_ini, n_val_rentacb_fin,n_cod_acreditacion,n_mto_garantia,n_cod_esquema,n_gcc,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          IF NOT (er_rec_planes_fn (ev_num_ident,ev_cod_tipident,v_personeria,n_val_rentacb_ini,n_val_rentacb_fin,n_gcc,ev_tipo_producto,ev_tipo_plan,en_cod_vendedor,c_planes,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          IF NOT (er_elimina_preevaluaciones_fn (ev_num_ident,ev_cod_tipident,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
             RAISE error_ejecucion;
          END IF;

          IF NOT (er_registra_solicitud_fn (ev_cod_tipident,ev_num_ident,v_personeria,v_tip_clie,n_cod_esquema,v_cod_usuario,sv_usuario,en_cod_vendedor,en_cod_vendealer,n_monto_renta,n_cod_acreditacion,n_mto_garantia,c_planes,o_objeto,sn_solic,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

          IF NOT (er_rec_inf_solicitud_fn (sn_solic,ev_tipo_producto,ev_tipo_plan,sv_nombre,sv_apellido,sv_apellido2,lv_usuario,sv_fecha_creacion,sc_cursordatos,sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
              RAISE error_ejecucion;
          END IF;

         --Se asigna a parametro de salida el valor del GCC NRCA 16-12-2008
          sv_gcc:=n_gcc;

       END IF;


   EXCEPTION
     WHEN error_ingresos THEN
        sn_cod_retorno  := '496';
        sv_mens_retorno := 'Error: Buro inactivo, ingresos debe contener un valor';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_listar_planes_pr(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_listar_planes_pr', LV_sql, SQLCODE, lv_des_error);

     WHEN error_ingresos2 THEN
        sn_cod_retorno  := '496';
        sv_mens_retorno := 'Error: El campo ingresos es obligatorio para persona Juridicas';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_listar_planes_pr(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_listar_planes_pr', LV_sql, SQLCODE, lv_des_error);


     WHEN error_ejecucion THEN
        lv_des_error    := 'er_integracion_eriesgo_pger_listar_planes_pr(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_listar_planes_pr', LV_sql, SQLCODE, lv_des_error);

     WHEN OTHERS THEN
        sn_cod_retorno  := '493';
        sv_mens_retorno := 'Error: no determinado al listar planes';
        lv_des_error    := 'er_integracion_eriesgo_pg.er_listar_planes_pr(); - ' || SQLERRM;
        sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, 'GA', sn_cod_retorno || ' -- ' || sv_mens_retorno, '1.0', USER, 'er_integracion_eriesgo_pg.er_listar_planes_pr', LV_sql, SQLCODE, lv_des_error);
   END er_listar_planes_pr;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ER_ACTUALIZA_PREEVALUACION_PR (
      Ev_Num_Solicitud      IN              Ert_Solicitud.Num_Solicitud%Type,
      Ev_Cod_Plantarif      IN              Ert_Solicitud_Planes.Cod_Plantarif%Type,
      Sn_Codretorno         OUT NOCOPY      Ge_Errores_Pg.Coderror,
      Sv_Menretorno         OUT NOCOPY      Ge_Errores_Pg.Msgerror,
      Sn_Numevento          OUT NOCOPY      Ge_Errores_Pg.Evento
   )
   IS
       Cn_Codigo_Estado           CONSTANT NUMBER       := 100;
       Cn_Subcodigo_Estado        CONSTANT NUMBER       := 6;
       Cn_Parametro_Estado        CONSTANT NUMBER       := 10;
       Cn_Parametro_Rechazada     CONSTANT NUMBER       := 4;
       Ln_Estado_Preevaluacion    Ert_Solicitud.Cod_Estado%Type;
       Lv_Des_Error    Ge_Errores_Pg.Desevent;
       Lv_Sql          Ge_Errores_Pg.Vquery;
           Lv_Tipident_Cliente Ert_Solicitud.Cod_Tipident%Type;
       Lv_Numident_Cliente Ert_Solicitud.Num_Ident_Cliente%Type;
       Lv_Count Number(3);
       Error_Ejecucion EXCEPTION;
       Error_Evaluacion_Vigente EXCEPTION;
       Error_Parametro EXCEPTION;
       o_erd_parametros       ERD_PARAMETROS_OT := NEW ERD_PARAMETROS_OT();
       Error_fraude    EXCEPTION;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;


       /**1.- Obtener Parametro con estado valido para la Preevaluacion*/
           o_erd_parametros.cod_codigo :=    CN_CODIGO_ESTADO;
           o_erd_parametros.cod_subcodigo := CN_SUBCODIGO_ESTADO;
           o_erd_parametros.cod_parametro := CN_PARAMETRO_ESTADO;
           IF NOT (er_obtiene_erd_parametros_fn (o_erd_parametros,sn_codretorno, sv_menretorno, sn_numevento)) THEN
              RAISE ERROR_PARAMETRO;
           END IF;

       /**2.- Obtengo Datos de la solicitud */

      IF NOT (er_obt_datosEval_fn(Ev_Num_Solicitud,Lv_Numident_Cliente,Lv_Tipident_Cliente,Sn_Codretorno,Sv_Menretorno,Sn_Numevento)) THEN
         RAISE NO_DATA_FOUND;
      END IF;


      /**3.- Verifico si el Numero y Tipo de identificacion tienen otras solicitudes de evaluacion
      de riesgo*/

       IF NOT (er_cuenta_solicitud_fn (Lv_Numident_Cliente,Lv_Tipident_Cliente,1,Ev_Num_Solicitud,Sn_Codretorno,Sv_Menretorno,Sn_Numevento) OR er_cuenta_solicitud_fn (LV_NUMIDENT_CLIENTE,LV_TIPIDENT_CLIENTE,2,EV_NUM_SOLICITUD,SN_CODRETORNO,SV_MENRETORNO,SN_NUMEVENTO) ) THEN
          /**4.- Si no hay solicitudes de Evaluacion de Riesgo por VB entonces se verifica que la solicitud sea una solicitud de preevaluacion*/
          IF (er_cuenta_solicitud_fn (Lv_Numident_Cliente,Lv_Tipident_Cliente,O_Erd_Parametros.Val_Parametro1,Ev_Num_Solicitud,Sn_Codretorno,Sv_Menretorno,Sn_Numevento)) THEN

              IF NOT (er_cuenta_solicitud_fn (Lv_Numident_Cliente,Lv_Tipident_Cliente,'1,2,3',Null,Sn_Codretorno,Sv_Menretorno,Sn_Numevento) Or Er_Cuenta_Solicitud_Fn (Lv_Numident_Cliente,Lv_Tipident_Cliente,2,Null,Sn_Codretorno,Sv_Menretorno,Sn_Numevento) ) THEN
                 IF (er_cuenta_planesSolic_fn (Ev_Num_Solicitud,Ev_Cod_Plantarif,Sn_Codretorno,Sv_Menretorno,Sn_Numevento)) THEN

                     Select Count(A.Num_Solicitud)
                     into Lv_Count
                     From Erh_Solicitud A, Ert_Solicitud B
                     Where B.Num_Solicitud=Ev_Num_Solicitud
                     And A.Num_Ident_Cliente=B.Num_Ident_Cliente
                     And A.Cod_Tipident=B.Cod_Tipident
                     And A.Cod_Estado=Cn_Parametro_Rechazada
                     And A.Fec_Ingreso_H Between B.Fec_Ingreso_H And Sysdate;

                     IF LV_COUNT > 0 THEN
                        RAISE ERROR_FRAUDE;
                     END IF;




                    /**4.1 Se borra de la tabla ERT_SOLICITUD_PLANES todos los planes a excepcion del elegido*/
                    DELETE ert_solicitud_planes
                    WHERE num_solicitud = ev_num_solicitud
                    AND cod_plantarif <> ev_cod_plantarif;

                   /**4.2 Se actualiza el estado de la preevaluacion*/

                    UPDATE ert_solicitud
                    SET cod_estado = 1
                    WHERE num_solicitud = ev_num_solicitud
                    AND cod_estado = o_erd_parametros.val_parametro1;
                 ELSE
                    RAISE  error_ejecucion;
                 END IF;
              ELSE
                 RAISE ERROR_EVALUACION_VIGENTE;
              END IF;
         END IF;
       END IF;



   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        SN_codRetorno := 403;
        LV_des_error   := 'La solicitud especificada no existe o no es valida' || SQLERRM;
        SV_menRetorno := 'La solicitud especificada no existe o no es valida';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_eriesgo_pg.ER_ACTUALIZA_PREEVALUACION_PR',LV_Sql, SQLCODE, LV_des_error);

    WHEN ERROR_PARAMETRO THEN
        SN_codRetorno := 426;
        LV_des_error   := 'No se encuentra parametro que contiene estado valido para preevaluación' || SQLERRM;
        SV_menRetorno := 'No se encuentra parametro que contiene estado valido para preevaluación';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_eriesgo_pg.ER_ACTUALIZA_PREEVALUACION_PR',LV_Sql, SQLCODE, LV_des_error);
    WHEN ERROR_EVALUACION_VIGENTE THEN
        SN_codRetorno := 404;
        LV_des_error   := 'Cliente Posee evaluacion de riesgo vigente o en proceso de venta.' || SQLERRM;
        SV_menRetorno  := 'Cliente Posee evaluacion de riesgo vigente o en proceso de venta.';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_eriesgo_pg.ER_ACTUALIZA_PREEVALUACION_PR',LV_Sql, SQLCODE, LV_des_error);
     WHEN error_ejecucion THEN
        LV_des_error   := 'Error al realizar proceso de actualizacion de preevaluacion' || SQLERRM;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_eriesgo_pg.ER_ACTUALIZA_PREEVALUACION_PR',LV_Sql, SQLCODE, LV_des_error);
     WHEN Error_fraude  THEN
          SN_codRetorno := 513;
          LV_des_error   := 'Se ha realizado una venta durante el proceso' || SQLERRM;
          SV_menRetorno := 'Se ha realizado una venta durante el proceso';
          SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_eriesgo_pg.ER_ACTUALIZA_PREEVALUACION_PR',LV_Sql, SQLCODE, LV_des_error);
     WHEN OTHERS THEN
        SN_codRetorno := 402;
        LV_des_error   := 'Error al realizar proceso de actualizacion de preevaluacion' || SQLERRM;
        SV_menRetorno := 'Error al realizar proceso de actualizacion de preevaluacion';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_eriesgo_pg.ER_ACTUALIZA_PREEVALUACION_PR',LV_Sql, SQLCODE, LV_des_error);
   END ER_ACTUALIZA_PREEVALUACION_PR;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END er_integracion_eriesgo_pg;
/
SHOW ERRORS
