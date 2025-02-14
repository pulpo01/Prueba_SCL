CREATE OR REPLACE PACKAGE BODY pv_cambio_simcard_sb_pg
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_param_val_cuasa_fn (
      eo_ga_caucaser       IN              ga_caucaser_qt,
      sn_ind_dev_almacen   OUT NOCOPY      ga_caucaser.ind_dev_almacen%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_rec_param_val_cuasa_fn"
            Fecha modificacion=" "
            Fecha creacion="03-04-2006"
            Programador="Marcelo Godoy S. - Carlos Navarro"
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="eo_ga_caucaser" Tipo="NUMERICO">Nombre de tabla</param>
               </Entrada>
               <Salida>
               <param nom="SN_ind_dev_almacen" Tipo="NUMERICO">Indicador Devolución Almacén</param>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT ind_dev_almacen FROM ga_caucaser';
      lv_ssql :=
             lv_ssql || ' WHERE cod_producto = ''' || cv_prod_celular || '''';
      lv_ssql :=
            lv_ssql
         || ' AND cod_caucaser = '''
         || eo_ga_caucaser.cod_caucaser
         || '''';

      SELECT ind_dev_almacen
        INTO sn_ind_dev_almacen
        FROM ga_caucaser
       WHERE cod_producto = cv_prod_celular
         AND cod_caucaser = eo_ga_caucaser.cod_caucaser;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
            'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          cv_cod_modulo,
                          sn_cod_retorno || ' -- ' || sv_mens_retorno,
                          '1.0',
                          USER,
                          'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn',
                          lv_ssql,
                          SQLCODE,
                          lv_des_error
                         );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
            'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                         (sn_num_evento,
                          cv_cod_modulo,
                          sn_cod_retorno || ' -- ' || sv_mens_retorno,
                          '1.0',
                          USER,
                          'pv_cambio_simcard_sb_pg.pv_rec_param_val_cuasa_fn',
                          lv_ssql,
                          SQLCODE,
                          lv_des_error
                         );
         RETURN FALSE;
   END pv_rec_param_val_cuasa_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_proc_equipo_fn (
      en_num_abonado    IN              ga_equipaboser.num_abonado%TYPE,
      ev_num_serie      IN              ga_equipaboser.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_proc_equipo_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EN_num_abonado" Tipo="NUMERICO">Número Abonado</param>
              <param nom="EV_num_serie" Tipo="CARACTER">Número de serie equipo</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN VARCHAR2
   IS
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      lv_ind_procequi   ga_equipaboser.ind_procequi%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT ind_procequi FROM ga_equipaboser a ';
      lv_ssql := lv_ssql || ' WHERE a.num_abonado = ' || en_num_abonado;
      lv_ssql := lv_ssql || ' AND a.num_serie =''' || ev_num_serie || '''';
      lv_ssql :=
            lv_ssql
         || ' AND a.fec_alta IN (SELECT max(fec_alta) FROM ga_equipaboser b ';
      lv_ssql :=
            lv_ssql
         || ' WHERE a.num_abonado=b.num_abonado AND a.num_serie=b.num_serie)';

      SELECT ind_procequi
        INTO lv_ind_procequi
        FROM ga_equipaboser a
       WHERE a.num_abonado = en_num_abonado
         AND a.num_serie = ev_num_serie
         AND a.fec_alta IN (
                SELECT MAX (fec_alta)
                  FROM ga_equipaboser b
                 WHERE a.num_abonado = b.num_abonado
                   AND a.num_serie = b.num_serie);

      RETURN lv_ind_procequi;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
             'pv_cambio_simcard_sb_pg.pv_valida_proc_equipo_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sn_cod_retorno || ' -- ' || sv_mens_retorno,
                           '1.0',
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_valida_proc_equipo_fn',
                           lv_ssql,
                           SQLCODE,
                           lv_des_error
                          );
         RETURN NULL;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
             'pv_cambio_simcard_sb_pg.pv_valida_proc_equipo_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sn_cod_retorno || ' -- ' || sv_mens_retorno,
                           '1.0',
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_valida_proc_equipo_fn',
                           lv_ssql,
                           SQLCODE,
                           lv_des_error
                          );
         RETURN NULL;
   END pv_valida_proc_equipo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_plazo_fn (
      en_num_abonado    IN              ga_equipaboser.num_abonado%TYPE,
      ev_num_serie      IN              ga_equipaboser.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_plazo_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EN_num_abonado" Tipo="NUMERICO">Número Abonado</param>
              <param nom="EV_num_serie" Tipo="CARACTER">Número de serie equipo</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN NUMBER
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ln_plazo       NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT TO_NUMBER(SYSDATE - TO_CHAR(add_months(fec_alta,12),''dd-mm-yyyy''))';
      lv_ssql :=
            lv_ssql
         || ' FROM ga_equipaboser a WHERE num_abonado = '
         || en_num_abonado;
      lv_ssql := lv_ssql || ' AND num_serie = ''' || ev_num_serie || '''';
      lv_ssql :=
            lv_ssql
         || ' AND a.fec_alta IN (SELECT max(fec_alta) FROM ga_equipaboser b ';
      lv_ssql :=
            lv_ssql
         || ' WHERE a.num_abonado=b.num_abonado AND a.num_serie=b.num_serie)';

      SELECT TO_NUMBER (  SYSDATE
                        - TO_CHAR (ADD_MONTHS (fec_alta, 12), 'dd-mm-yyyy')
                       )
        INTO ln_plazo
        FROM ga_equipaboser a
       WHERE num_abonado = en_num_abonado
         AND num_serie = ev_num_serie
         AND a.fec_alta IN (
                SELECT MAX (fec_alta)
                  FROM ga_equipaboser b
                 WHERE a.num_abonado = b.num_abonado
                   AND a.num_serie = b.num_serie);

      RETURN ln_plazo;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                   'pv_cambio_simcard_sb_pg.pv_valida_plazo_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 cv_cod_modulo,
                                 sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                 '1.0',
                                 USER,
                                 'pv_cambio_simcard_sb_pg.pv_valida_plazo_fn',
                                 lv_ssql,
                                 SQLCODE,
                                 lv_des_error
                                );
         RETURN 0;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
                   'pv_cambio_simcard_sb_pg.pv_valida_plazo_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                                (sn_num_evento,
                                 cv_cod_modulo,
                                 sn_cod_retorno || ' -- ' || sv_mens_retorno,
                                 '1.0',
                                 USER,
                                 'pv_cambio_simcard_sb_pg.pv_valida_plazo_fn',
                                 lv_ssql,
                                 SQLCODE,
                                 lv_des_error
                                );
         RETURN 0;
   END pv_valida_plazo_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_plazo_garantia_fn (
      en_num_abonado    IN              ga_equipaboser.num_abonado%TYPE,
      ev_num_serie      IN              ga_equipaboser.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_plazo_garantia_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EN_num_abonado" Tipo="NUMERICO">Número Abonado</param>
              <param nom="EV_num_serie" Tipo="CARACTER">Número de serie equipo</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      IF pv_valida_proc_equipo_fn (en_num_abonado,
                                   ev_num_serie,
                                   sn_cod_retorno,
                                   sv_mens_retorno,
                                   sn_num_evento
                                  ) = 'I'
      THEN
         IF pv_valida_plazo_fn (en_num_abonado,
                                ev_num_serie,
                                sn_cod_retorno,
                                sv_mens_retorno,
                                sn_num_evento
                               ) > 0
         THEN
            RETURN FALSE;
         ELSE
            RETURN TRUE;
         END IF;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_valida_plazo_garantia_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                       (sn_num_evento,
                        cv_cod_modulo,
                        sn_cod_retorno || ' -- ' || sv_mens_retorno,
                        '1.0',
                        USER,
                        'pv_cambio_simcard_sb_pg.pv_valida_plazo_garantia_fn',
                        lv_ssql,
                        SQLCODE,
                        lv_des_error
                       );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_valida_plazo_garantia_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                       (sn_num_evento,
                        cv_cod_modulo,
                        sn_cod_retorno || ' -- ' || sv_mens_retorno,
                        '1.0',
                        USER,
                        'pv_cambio_simcard_sb_pg.pv_valida_plazo_garantia_fn',
                        lv_ssql,
                        SQLCODE,
                        lv_des_error
                       );
         RETURN FALSE;
   END pv_valida_plazo_garantia_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_estado_reserva_fn (
      sn_cod_estado     OUT NOCOPY   al_datos_generales.cod_estado_rvt%TYPE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_plazo_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
               </Entrada>
               <Salida>
                param nom="SN_cod_estado" Tipo="NUMERICO">Codigo estado</param>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ln_estado      NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT cod_Estado_rvt FROM al_datos_generales';

      SELECT cod_estado_rvt
        INTO ln_estado
        FROM al_datos_generales;

      sn_cod_estado := ln_estado;
      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_valida_estado_reserva_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                       (sn_num_evento,
                        cv_cod_modulo,
                        sn_cod_retorno || ' -- ' || sv_mens_retorno,
                        '1.0',
                        USER,
                        'pv_cambio_simcard_sb_pg.pv_valida_estado_reserva_fn',
                        lv_ssql,
                        SQLCODE,
                        lv_des_error
                       );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_valida_estado_reserva_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                       (sn_num_evento,
                        cv_cod_modulo,
                        sn_cod_retorno || ' -- ' || sv_mens_retorno,
                        '1.0',
                        USER,
                        'pv_cambio_simcard_sb_pg.pv_valida_estado_reserva_fn',
                        lv_ssql,
                        SQLCODE,
                        lv_des_error
                       );
         RETURN FALSE;
   END pv_valida_estado_reserva_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_lista_negra_fn (
      ev_num_serie      IN              ga_equipaboser.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_lista_negra_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
              <param nom="EV_num_serie" Tipo="CARACTER">Número de serie equipo</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ln_contador    NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT COUNT(1)';
      lv_ssql :=
               lv_ssql || ' FROM ga_lncelu a, ta_operadores b, ga_causinie c';
      lv_ssql := lv_ssql || ' WHERE a.num_serie = ' || ev_num_serie;
      lv_ssql := lv_ssql || ' AND b.cod_operador = a.cod_operador';
      lv_ssql := lv_ssql || ' AND c.cod_causa(+) = a.cod_causa;';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_lncelu a, ta_operadores b, ga_causinie c
       WHERE a.num_serie = ev_num_serie
         AND b.cod_operador = a.cod_operador
         AND c.cod_causa(+) = a.cod_causa;

      IF ln_contador = 0
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
             'pv_cambio_simcard_sb_pg.pv_valida_lista_negra_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sn_cod_retorno || ' -- ' || sv_mens_retorno,
                           '1.0',
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_valida_lista_negra_fn',
                           lv_ssql,
                           SQLCODE,
                           lv_des_error
                          );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
             'pv_cambio_simcard_sb_pg.pv_valida_lista_negra_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sn_cod_retorno || ' -- ' || sv_mens_retorno,
                           '1.0',
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_valida_lista_negra_fn',
                           lv_ssql,
                           SQLCODE,
                           lv_des_error
                          );
         RETURN FALSE;
   END pv_valida_lista_negra_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_restricciones_fn (
      pv_restricciones   IN              pv_restricciones_qt,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_restricciones_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
              <param nom="pv_restricciones" Tipo="">Restricciones</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error     ge_errores_pg.desevent;
      lv_ssql          ge_errores_pg.vquery;
      seq_transacabo   NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      SELECT ga_seq_transacabo.NEXTVAL
        INTO seq_transacabo
        FROM DUAL;

      pv_pr_ejecuta_restriccion (seq_transacabo,
                                 pv_restricciones.cod_modulo,
                                 cv_prod_celular,
                                 pv_restricciones.cod_actuacion,
                                 pv_restricciones.cod_evento,
                                 pv_restricciones.parametros
                                );

      SELECT cod_retorno, des_cadena
        INTO sn_cod_retorno, sv_mens_retorno
        FROM ga_transacabo
       WHERE num_transaccion = seq_transacabo;

      IF sn_cod_retorno = 0
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
            'pv_cambio_simcard_sb_pg.pv_valida_restricciones_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sn_cod_retorno || ' -- ' || sv_mens_retorno,
                         '1.0',
                         USER,
                         'pv_cambio_simcard_sb_pg.pv_valida_restricciones_fn',
                         lv_ssql,
                         SQLCODE,
                         lv_des_error
                        );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
            'pv_cambio_simcard_sb_pg.pv_valida_restricciones_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sn_cod_retorno || ' -- ' || sv_mens_retorno,
                         '1.0',
                         USER,
                         'pv_cambio_simcard_sb_pg.pv_valida_restricciones_fn',
                         lv_ssql,
                         SQLCODE,
                         lv_des_error
                        );
         RETURN FALSE;
   END pv_valida_restricciones_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_promocion_fn (
      en_num_abonado    IN              ga_equipaboser.num_abonado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_plazo_garantia_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EN_num_abonado" Tipo="NUMERICO">Número Abonado</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      ln_contador       NUMBER;
      lv_tip_terminal   ga_abocel.tip_terminal%TYPE;
      ln_num_celular    ga_abocel.num_celular%TYPE;
      ln_ind_supertel   ga_abocel.ind_supertel%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      SELECT tip_terminal, num_celular, ind_supertel
        INTO lv_tip_terminal, ln_num_celular, ln_ind_supertel
        FROM ga_abocel
       WHERE num_abonado = en_num_abonado;

      IF lv_tip_terminal = 'A'
      THEN
         SELECT COUNT (1)
           INTO ln_contador
           FROM ci_promocion_analogos
          WHERE num_celular = ln_num_celular AND ind_promocion = 'A';

         IF ln_contador <> 0
         THEN
            IF ln_ind_supertel = '1'
            THEN
               RETURN FALSE;
            ELSE
               RETURN TRUE;
            END IF;
         ELSE
            RETURN FALSE;
         END IF;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_valida_promocion_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sn_cod_retorno || ' -- ' || sv_mens_retorno,
                             '1.0',
                             USER,
                             'pv_cambio_simcard_sb_pg.pv_valida_promocion_fn',
                             lv_ssql,
                             SQLCODE,
                             lv_des_error
                            );
         RETURN FALSE;
   END pv_valida_promocion_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_cod_antiguedad_fn (
      ed_fec_alta         IN              ga_equipaboser.fec_alta%TYPE,
      sn_cod_antiguedad   OUT NOCOPY      gat_opciones_equipos.cod_antiguedad%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_rec_cod_antiguedad_fn"
            Fecha modificacion=" "
            Fecha creacion="03-04-2006"
            Programador="Marcelo Godoy S. - Carlos Navarro"
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="ed_fec_alta" Tipo="DATE">Fecha Alta</param>
               </Entrada>
               <Salida>
               <param nom="sn_cod_antiguedad" Tipo="NUMERICO">Antiguedad</param>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error        ge_errores_pg.desevent;
      lv_ssql             ge_errores_pg.vquery;
      ln_cod_antiguedad   gat_opciones_equipos.cod_antiguedad%TYPE;
      lv_ind_politica     ged_parametros.val_parametro%TYPE;
      lv_descripcion      ged_parametros.des_parametro%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';

      IF pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn
                                                      ('SW_POLITICA_SIMCARD',
                                                       cv_cod_modulo_ga,
                                                       lv_ind_politica,
                                                       lv_descripcion,
                                                       sn_cod_retorno,
                                                       sv_mens_retorno,
                                                       sn_num_evento
                                                      )
      THEN
         IF lv_ind_politica = '1'
         THEN
            ln_cod_antiguedad :=
                                TRUNC(MONTHS_BETWEEN (TRUNC (SYSDATE), ed_fec_alta));

            SELECT cod_rango
              INTO sn_cod_antiguedad
              FROM gad_rangos_antiguedad
             WHERE cod_tiprango = 'M'
               AND ln_cod_antiguedad BETWEEN ran_desde AND ran_hasta;
         ELSE
            ln_cod_antiguedad := 0;

            SELECT cod_rango
              INTO sn_cod_antiguedad
              FROM gad_rangos_antiguedad
             WHERE cod_tiprango = 'M'
               AND ln_cod_antiguedad BETWEEN ran_desde AND ran_hasta;
         END IF;
      END IF;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
             'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sn_cod_retorno || ' -- ' || sv_mens_retorno,
                           '1.0',
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn',
                           lv_ssql,
                           SQLCODE,
                           lv_des_error
                          );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
             'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sn_cod_retorno || ' -- ' || sv_mens_retorno,
                           '1.0',
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_rec_cod_antiguedad_fn',
                           lv_ssql,
                           SQLCODE,
                           lv_des_error
                          );
         RETURN FALSE;
   END pv_rec_cod_antiguedad_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_serie_en_bodega_fn (
      eo_sesion         IN              ge_sesion_qt,
      eo_uso            IN              al_uso_qt,
      eo_tip_terminal   IN              al_tipos_terminales_qt,
      eo_dat_abo        IN              pv_datos_abo_qt,
      eo_al_serie       IN              al_serie_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_valida_serie_en_bodega_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>

               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      lc_bodega      refcursor;
      ln_contador    NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT COUNT(1)';
      lv_ssql := lv_ssql || ' FROM AL_TIPOS_STOCK B,AL_ARTICULOS C,';
      lv_ssql := lv_ssql || ' AL_SERIES A, AL_TECNOARTICULO_TD D';
      lv_ssql := lv_ssql || ' WHERE A.COD_USO = ' || eo_uso.cod_uso;
      lv_ssql :=
            lv_ssql
         || ' AND C.TIP_TERMINAL = '''
         || eo_tip_terminal.tip_terminal
         || '''';
      lv_ssql := lv_ssql || ' AND A.COD_PRODUCTO = ' || cv_prod_celular;

      IF TRIM (eo_al_serie.num_serie) IS NOT NULL
      THEN
         lv_ssql :=
            lv_ssql || ' AND A.NUM_SERIE= ''' || eo_al_serie.num_serie
            || '''';
      END IF;

      lv_ssql := lv_ssql || ' AND A.NUM_TELEFONO IS NULL';
      lv_ssql := lv_ssql || ' AND A.COD_ARTICULO = C.COD_ARTICULO';
      lv_ssql := lv_ssql || ' AND A.COD_ARTICULO = D.COD_ARTICULO';
      lv_ssql :=
            lv_ssql
         || ' AND D.COD_TECNOLOGIA = '''
         || eo_dat_abo.cod_tecnologia
         || '''';
      lv_ssql := lv_ssql || ' AND B.TIP_STOCK = A.TIP_STOCK ';

      IF pv_valida_promocion_fn (eo_sesion.num_abonado,
                                 sn_cod_retorno,
                                 sv_mens_retorno,
                                 sn_num_evento
                                )
      THEN
         lv_ssql :=
               lv_ssql
            || ' AND A.COD_ARTICULO IN([11249], [11321], [11288], [11361])';
      END IF;

      OPEN lc_bodega FOR lv_ssql;

      FETCH lc_bodega
       INTO ln_contador;

      IF ln_contador <> 0
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_valida_serie_en_bodega_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                      (sn_num_evento,
                       cv_cod_modulo,
                       sn_cod_retorno || ' -- ' || sv_mens_retorno,
                       '1.0',
                       USER,
                       'pv_cambio_simcard_sb_pg.pv_valida_serie_en_bodega_fn',
                       lv_ssql,
                       SQLCODE,
                       lv_des_error
                      );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_valida_serie_en_bodega_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                      (sn_num_evento,
                       cv_cod_modulo,
                       sn_cod_retorno || ' -- ' || sv_mens_retorno,
                       '1.0',
                       USER,
                       'pv_cambio_simcard_sb_pg.pv_valida_serie_en_bodega_fn',
                       lv_ssql,
                       SQLCODE,
                       lv_des_error
                      );
         RETURN FALSE;
   END pv_valida_serie_en_bodega_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_verifica_plan_comercial_fn (
      eo_sesion         IN              ge_sesion_qt,
      eo_caucaser       IN              ga_caucaser_qt,
      eo_modventa       IN              ge_modventa_qt,
      eo_uso            IN              al_uso_qt,
      eo_tip_terminal   IN              al_tipos_terminales_qt,
      eo_al_serie       IN              al_serie_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_verifica_plan_comercial_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>

               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error         ge_errores_pg.desevent;
      lv_ssql              ge_errores_pg.vquery;
      ln_contador          NUMBER;
      ln_ind_dev_almacen   NUMBER;
      ln_ind_recambio      NUMBER;
      lc_plan_comercial    refcursor;
      lv_cod_operacion     ga_actabo.cod_actabo%TYPE                  := 'SA';
      lv_ind_causa         ged_parametros.val_parametro%TYPE;
      lv_descripcion       ged_parametros.des_parametro%TYPE;
      ln_cod_antiguedad    gat_opciones_equipos.cod_antiguedad%TYPE;
      o_dat_abo            pv_datos_abo_qt             := NEW pv_datos_abo_qt;
      o_tipcontrato        ga_tipcontrato_qt         := NEW ga_tipcontrato_qt;
      error_ejecucion      EXCEPTION;
      o_catplantarif       ve_catplantarif_qt       := NEW ve_catplantarif_qt;
	  lvCodArticulo		   al_series.cod_articulo%TYPE;

   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      o_dat_abo.num_abonado := eo_sesion.num_abonado;
      pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr (o_dat_abo,
                                                    sn_cod_retorno,
                                                    sv_mens_retorno,
                                                    sn_num_evento
                                                   );

      IF sn_cod_retorno <> 0
      THEN
         RAISE error_ejecucion;
      END IF;

      o_tipcontrato.cod_tipcontrato := o_dat_abo.cod_tipcontrato;

      IF NOT (pv_cambio_serie_sb_pg.pv_rec_tipo_contrato_fn (o_tipcontrato,
                                                             sn_cod_retorno,
                                                             sv_mens_retorno,
                                                             sn_num_evento
                                                            )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn
                                                            (lv_cod_operacion,
                                                             cv_cod_modulo_ga,
                                                             lv_ind_causa,
                                                             lv_descripcion,
                                                             sn_cod_retorno,
                                                             sv_mens_retorno,
                                                             sn_num_evento
                                                            )
      THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_rec_param_val_cuasa_fn (eo_caucaser,
                                         ln_ind_dev_almacen,
                                         sn_cod_retorno,
                                         sv_mens_retorno,
                                         sn_num_evento
                                        )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      IF ln_ind_dev_almacen = 1
      THEN
         ln_ind_recambio := 1;
      ELSE
         ln_ind_recambio := 0;
      END IF;

      IF NOT (pv_rec_cod_antiguedad_fn (o_dat_abo.fec_alta,
                                        ln_cod_antiguedad,
                                        sn_cod_retorno,
                                        sv_mens_retorno,
                                        sn_num_evento
                                       )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      o_catplantarif.cod_plantarif := o_dat_abo.cod_plantarif;

      IF NOT (pv_cambio_serie_sb_pg.pv_rec_cat_plan_tarif_fn (o_catplantarif,
                                                              sn_cod_retorno,
                                                              sv_mens_retorno,
                                                              sn_num_evento
                                                             )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

	  LV_sSql:= 'SELECT cod_articulo';
	  LV_sSql:= LV_sSql || ' FROM al_series ';
	  LV_sSql:= LV_sSql || ' WHERE num_serie = ' || eo_al_serie.num_serie;

	  SELECT cod_articulo
	  INTO lvCodArticulo
	  FROM al_series
	  WHERE num_serie = eo_al_serie.num_serie;

      lv_ssql := 'SELECT COUNT(1)';
      lv_ssql :=
            lv_ssql
         || 'FROM AL_TIPOS_STOCK B, AL_ARTICULOS C, AL_SERIES A, AL_TECNOARTICULO_TD D';
      lv_ssql := lv_ssql || ' WHERE A.COD_USO = ' || eo_uso.cod_uso;
      lv_ssql :=
            lv_ssql
         || ' AND C.TIP_TERMINAL ='''
         || eo_tip_terminal.tip_terminal
         || '''';
      lv_ssql := lv_ssql || ' AND A.COD_PRODUCTO =' || cv_prod_celular;

      IF TRIM (o_dat_abo.num_serie) IS NOT NULL
      THEN
         lv_ssql :=
            lv_ssql || ' AND A.NUM_SERIE= ''' || eo_al_serie.num_serie
            || '''';
      END IF;

      lv_ssql := lv_ssql || ' AND A.NUM_TELEFONO IS NULL';
      lv_ssql := lv_ssql || ' AND A.COD_ARTICULO = C.COD_ARTICULO';
      lv_ssql := lv_ssql || ' AND B.TIP_STOCK = A.TIP_STOCK ';
      lv_ssql := lv_ssql || ' AND A.COD_ARTICULO = D.COD_ARTICULO';
      lv_ssql :=
            lv_ssql
         || ' AND D.COD_TECNOLOGIA = '''
         || o_dat_abo.cod_tecnologia
         || '''';

      IF pv_valida_promocion_fn (o_dat_abo.num_abonado,
                                 sn_cod_retorno,
                                 sv_mens_retorno,
                                 sn_num_evento
                                )
      THEN
         lv_ssql :=
               lv_ssql
            || ' AND A.COD_ARTICULO IN([11249], [11321], [11288], [11361])';
      END IF;

      lv_ssql :=
            lv_ssql
         || ' AND A.COD_ARTICULO IN(SELECT D.COD_ARTICULO FROM GAT_OPCIONES_EQUIPOS D ';
      lv_ssql :=
         lv_ssql || ' WHERE D.COD_TIPCONTRATO = ''' || o_dat_abo.cod_tipcontrato || '''';
      lv_ssql :=
                lv_ssql || ' AND D.NUM_MESES = ' || o_tipcontrato.meses_minimo;
      lv_ssql :=
            lv_ssql || ' AND D.COD_OPERACION = ''' || lv_cod_operacion || '''';
      lv_ssql := lv_ssql || ' AND D.IND_CAUSA = ' || lv_ind_causa;

      IF lv_ind_causa <> '0' AND TRIM (eo_caucaser.cod_caucaser) <> ''
      THEN
         lv_ssql :=
                 lv_ssql || ' AND D.COD_CAUSA = ' || eo_caucaser.cod_caucaser;
      END IF;

      lv_ssql :=
            lv_ssql
         || ' AND D.COD_CATEGORIA = '''
         || o_catplantarif.cod_categoria
         || '''';
      lv_ssql :=
                lv_ssql || ' AND D.COD_MODPAGO = ' || eo_modventa.cod_modventa;

      IF (ln_ind_recambio <> 1)
      THEN
         IF NOT pv_cambio_serie_sb_pg.pv_valida_permisos_fn
                                                     (eo_sesion.nom_usuario,
                                                      eo_sesion.cod_programa,
                                                      eo_sesion.num_version,
                                                      'COD_PROC_INDGMC',
                                                      sn_cod_retorno,
                                                      sv_mens_retorno,
                                                      sn_num_evento
                                                     )
         THEN
            lv_ssql :=
                   lv_ssql || ' AND D.COD_ANTIGUEDAD = ' || ln_cod_antiguedad;
         END IF;
      END IF;

      lv_ssql :=
                lv_ssql || ' AND SYSDATE BETWEEN D.FEC_DESDE AND D.FEC_HASTA ';
      lv_ssql := lv_ssql || ' AND A.COD_ARTICULO = D.COD_ARTICULO)';

      OPEN lc_plan_comercial FOR lv_ssql;

      FETCH lc_plan_comercial
       INTO ln_contador;

      IF ln_contador <> 0
      THEN
         RETURN TRUE;
      ELSE
         sn_cod_retorno := 358;
              SV_mens_retorno := 'Serie no es aplicable al plan comercial';
              SV_mens_retorno := SV_mens_retorno || ' |Producto:' || cv_prod_celular;
              SV_mens_retorno := SV_mens_retorno || ' |Artículo:' || lvCodArticulo;
              SV_mens_retorno := SV_mens_retorno || ' |Cod. Uso:' || eo_uso.cod_uso;
              SV_mens_retorno := SV_mens_retorno || ' |Tipo Terminal:' || eo_tip_terminal.Tip_Terminal;
              SV_mens_retorno := SV_mens_retorno || ' |Tipo Contrato:' || o_dat_abo.cod_tipcontrato;
              SV_mens_retorno := SV_mens_retorno || ' |Meses:' || o_tipcontrato.meses_minimo;
              SV_mens_retorno := SV_mens_retorno || ' |Cod. Operación:' || lv_cod_operacion;
              SV_mens_retorno := SV_mens_retorno || ' |Ind. Causa:' || lv_Ind_Causa;
              SV_mens_retorno := SV_mens_retorno || ' |Cod. Causa:' || eo_caucaser.cod_caucaser;
              SV_mens_retorno := SV_mens_retorno || ' |Categoría:' || o_catplantarif.cod_categoria;
              SV_mens_retorno := SV_mens_retorno || ' |Mod. Venta:' || eo_modventa.cod_modventa;
              SV_mens_retorno := SV_mens_retorno || ' |Cod. Antiguedad:' || ln_cod_antiguedad;
              SV_mens_retorno := SV_mens_retorno || ' |FAVOR CONFIRMAR OPERACIÓN A REALIZAR';
              SV_mens_retorno := SV_mens_retorno || ' |CON POLÍTICA DE RECAMBIO ACTUAL.';
         RAISE error_ejecucion;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                     (sn_num_evento,
                      cv_cod_modulo,
                      sv_mens_retorno,
                      cv_version,
                      USER,
                      'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn',
                      lv_ssql,
                      sn_cod_retorno,
                      lv_des_error
                     );
         RETURN FALSE;
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                     (sn_num_evento,
                      cv_cod_modulo,
                      sn_cod_retorno || ' -- ' || sv_mens_retorno,
                      '1.0',
                      USER,
                      'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn',
                      lv_ssql,
                      SQLCODE,
                      lv_des_error
                     );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                     (sn_num_evento,
                      cv_cod_modulo,
                      sn_cod_retorno || ' -- ' || sv_mens_retorno,
                      '1.0',
                      USER,
                      'pv_cambio_simcard_sb_pg.pv_verifica_plan_comercial_fn',
                      lv_ssql,
                      SQLCODE,
                      lv_des_error
                     );
         RETURN FALSE;
   END pv_verifica_plan_comercial_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_verifica_reserva_fn (
      ev_num_serie      IN              ga_equipaboser.num_serie%TYPE,
      sn_cod_bodega     OUT NOCOPY      ga_equipaboser.cod_bodega%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_verifica_reserva_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
              <param nom="EV_num_serie" Tipo="CARACTER">Número de serie equipo</param>
               </Entrada>
               <Salida>
               <param nom="sn_cod_bodega Tipo="NUMERICO">Codigo Bodega</param>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      ln_estado         al_series.cod_estado%TYPE;
      ln_cod_bodega     al_series.cod_bodega%TYPE;
      error_de_estado   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT a.cod_estado, a.cod_bodega FROM al_series a ';
      lv_ssql := lv_ssql || ' WHERE num_serie = ''' || ev_num_serie || '''';

      SELECT a.cod_estado, a.cod_bodega
        INTO ln_estado, ln_cod_bodega
        FROM al_series a
       WHERE num_serie = ev_num_serie;

      sn_cod_bodega := ln_cod_bodega;

      IF (ln_estado = 1 OR ln_estado = 2 OR ln_estado = 3)
      THEN
         RETURN TRUE;
      ELSE
         RAISE error_de_estado;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '107';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_reserva_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sn_cod_retorno || ' -- ' || sv_mens_retorno,
                             '1.0',
                             USER,
                             'pv_cambio_simcard_sb_pg.pv_verifica_reserva_fn',
                             lv_ssql,
                             SQLCODE,
                             lv_des_error
                            );
         RETURN FALSE;
      WHEN error_de_estado
      THEN
         sn_cod_retorno := '998';
         sv_mens_retorno :=
                        'La serie ya se encuentra reservada.';
         lv_des_error :=
              'pv_cambio_simcard_sb_pg.pv_verifica_reserva_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sn_cod_retorno || ' -- ' || sv_mens_retorno,
                            '1.0',
                            USER,
                            'pv_cambio_simcard_sb_pg.pv_verifica_reserva_fn',
                            lv_ssql,
                            SQLCODE,
                            lv_des_error
                           );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_reserva_fn; - ' || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                            (sn_num_evento,
                             cv_cod_modulo,
                             sn_cod_retorno || ' -- ' || sv_mens_retorno,
                             '1.0',
                             USER,
                             'pv_cambio_simcard_sb_pg.pv_verifica_reserva_fn',
                             lv_ssql,
                             SQLCODE,
                             lv_des_error
                            );
         RETURN FALSE;
   END pv_verifica_reserva_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_verifica_vendedor_bodega_fn (
      en_cod_vendedor   IN              ve_vendalmac.cod_vendedor%TYPE,
      en_cod_cliente    IN              ge_clientes.cod_cliente%TYPE,
      en_cod_bodega     IN              al_series.cod_bodega%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_verifica_vendedor_fn"
            Fecha modificacion=" "
            Fecha creacion="07-11-2007"
            Programador=CAGV
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion></Descripcion>
            <Parametros>
               <Entrada>
              <param nom="EV_num_serie" Tipo="CARACTER">Número de serie equipo</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN BOOLEAN
   IS
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      cant_bodega       NUMBER;
      error_ejecucion   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      lv_ssql := ' SELECT  A.COD_BODEGA ';
      lv_ssql := lv_ssql || ' FROM   VE_VENDALMAC A, AL_BODEGAS B, ';
      lv_ssql := lv_ssql || ' AL_BODEGANODO C, GE_OPERADORA_SCL D ';
      lv_ssql := lv_ssql || ' WHERE  A.COD_VENDEDOR = ' || en_cod_vendedor;
      lv_ssql := lv_ssql || ' AND    SYSDATE BETWEEN A.FEC_ASIGNACION ';
      lv_ssql := lv_ssql || ' AND    NVL(A.FEC_DESASIGNAC,SYSDATE) ';
      lv_ssql := lv_ssql || ' AND    A.COD_BODEGA = B.COD_BODEGA ';
      lv_ssql := lv_ssql || ' AND    B.COD_BODEGA = C.COD_BODEGA ';
      lv_ssql := lv_ssql || ' AND    C.COD_BODEGANODO = D.COD_BODEGANODO ';
      lv_ssql :=
            lv_ssql
         || '  AND    D.COD_OPERADORA_SCL =fn_obtiene_opercliente('
         || en_cod_cliente
         || ')';

      SELECT COUNT (1)
        INTO cant_bodega
        FROM ve_vendalmac a, al_bodegas b, al_bodeganodo c,
             ge_operadora_scl d
       WHERE a.cod_vendedor = en_cod_vendedor
         AND SYSDATE BETWEEN a.fec_asignacion AND NVL (a.fec_desasignac,
                                                       SYSDATE
                                                      )
         AND a.cod_bodega = b.cod_bodega
         AND b.cod_bodega = c.cod_bodega
         AND a.cod_bodega = en_cod_bodega
         AND c.cod_bodeganodo = d.cod_bodeganodo
         AND d.cod_operadora_scl = fn_obtiene_opercliente (en_cod_cliente);

      IF cant_bodega > 0
      THEN
         RETURN TRUE;
      ELSE
         sv_mens_retorno := 'Error - El Vendedor no tiene acceso a la bodega';
         sn_cod_retorno := 36;
         RAISE error_ejecucion;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_vendedor_bodega_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                    (sn_num_evento,
                     cv_cod_modulo,
                     sn_cod_retorno || ' -- ' || sv_mens_retorno,
                     '1.0',
                     USER,
                     'pv_cambio_simcard_sb_pg.pv_verifica_vendedor_bodega_fn',
                     lv_ssql,
                     SQLCODE,
                     lv_des_error
                    );
         RETURN FALSE;
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_vendedor_bodega_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                    (sn_num_evento,
                     cv_cod_modulo,
                     sn_cod_retorno || ' -- ' || sv_mens_retorno,
                     '1.0',
                     USER,
                     'pv_cambio_simcard_sb_pg.pv_verifica_vendedor_bodega_fn',
                     lv_ssql,
                     SQLCODE,
                     lv_des_error
                    );
         RETURN FALSE;
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_vendedor_bodega_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                    (sn_num_evento,
                     cv_cod_modulo,
                     sn_cod_retorno || ' -- ' || sv_mens_retorno,
                     '1.0',
                     USER,
                     'pv_cambio_simcard_sb_pg.pv_verifica_vendedor_bodega_fn',
                     lv_ssql,
                     SQLCODE,
                     lv_des_error
                    );
         RETURN FALSE;
   END pv_verifica_vendedor_bodega_fn;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION pv_verifica_numero_desviado_fn (
      ev_num_desviado   IN              tol_rannume_td.NUM_LINI%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      /*
      <Documentacion TipoDoc = "Function">
         <Elemento
            Nombre = "pv_verifica_numero_desviado_fn"
            Fecha modificacion=" "
            Fecha creacion="12/09/2011"
            Programador=Felipe Diaz Lineros
            Diseñador=""
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>
            <Descripcion>Verifica la existencia del numero de desvio</Descripcion>
            <Parametros>
               <Entrada>
              <param nom="ev_num_desviado" Tipo="VARCHAR2">Numero de desvio</param>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
   RETURN VARCHAR2
   IS
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      cant_numeros      NUMBER;
      error_ejecucion   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sn_num_evento := 0;
      sv_mens_retorno := '';
      
      LV_SSQL := 'SELECT COUNT(1) FROM tol_rannume_td ';
      LV_SSQL := LV_SSQL || 'WHERE num_lini < ' || ev_num_desviado;
      LV_SSQL := LV_SSQL || ' AND num_linf > ' ||ev_num_desviado;
        
      SELECT COUNT(1) 
      INTO cant_numeros
      FROM tol_rannume_td
      WHERE num_lini < ev_num_desviado
      AND num_linf > ev_num_desviado;
      

      IF cant_numeros > 0
      THEN
         RETURN 'TRUE';
      ELSE
         sv_mens_retorno := 'Error - No existe el numero de desvio';
         sn_cod_retorno := 36;
         RAISE error_ejecucion;
      END IF;
      
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_numero_desviado_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                    (sn_num_evento,
                     cv_cod_modulo,
                     sn_cod_retorno || ' -- ' || sv_mens_retorno,
                     '1.0',
                     USER,
                     'pv_cambio_simcard_sb_pg.pv_verifica_numero_desviado_fn',
                     lv_ssql,
                     SQLCODE,
                     lv_des_error
                    );
         RETURN 'FALSE';
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := '5';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_numero_desviado_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                    (sn_num_evento,
                     cv_cod_modulo,
                     sn_cod_retorno || ' -- ' || sv_mens_retorno,
                     '1.0',
                     USER,
                     'pv_cambio_simcard_sb_pg.pv_verifica_numero_desviado_fn',
                     lv_ssql,
                     SQLCODE,
                     lv_des_error
                    );
         RETURN 'FALSE';
      WHEN OTHERS
      THEN
         sn_cod_retorno := '6';

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_verifica_numero_desviado_fn; - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                    (sn_num_evento,
                     cv_cod_modulo,
                     sn_cod_retorno || ' -- ' || sv_mens_retorno,
                     '1.0',
                     USER,
                     'pv_cambio_simcard_sb_pg.pv_verifica_numero_desviado_fn',
                     lv_ssql,
                     SQLCODE,
                     lv_des_error
                    );
         RETURN 'FALSE';
   END pv_verifica_numero_desviado_fn;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
   PROCEDURE pv_rec_modalidad_pago_pr (
      eo_caucaser       IN              ga_caucaser_qt,
      eo_sesion         IN              ge_sesion_qt,
      sc_mod_pago       OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "pv_rec_info_abonado_pr"
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Diseñador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno>SEO_dat_abo</Retorno>>
            <Descripción>Recupera Modalidad de Pago</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="EO_sesion Tipo="estructura"></param>>
               <param nom="EO_caucaser Tipo="estructura"></param>>
               <param nom="EV_ind_politica Tipo="CARACTER"></param>>
               </Entrada>
               <Salida>
                <param nom="SC_mod_pago  Tipo="CURSOR"></param>>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_des_error       ge_errores_pg.desevent;
      lv_ssql            ge_errores_pg.vquery;
      lv_indcausa        ged_parametros.val_parametro%TYPE;
      lv_des_parametro   ged_parametros.des_parametro%TYPE;
      o_ve_tipcomis      ve_tipcomis_qt                 := NEW ve_tipcomis_qt;
      o_tipcontrato      ga_tipcontrato_qt           := NEW ga_tipcontrato_qt;
      o_catplantarif     ve_catplantarif_qt         := NEW ve_catplantarif_qt;
      o_seg_usuario      ge_seg_usuario_qt           := NEW ge_seg_usuario_qt;
      o_dat_abo          pv_datos_abo_qt               := NEW pv_datos_abo_qt;
      error_ejecucion    EXCEPTION;
      lv_ind_politica    ged_parametros.val_parametro%TYPE;
      lv_descripcion     ged_parametros.des_parametro%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      o_seg_usuario.nom_usuario := eo_sesion.nom_usuario;

      IF NOT (pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn (o_seg_usuario,
                                                              sn_cod_retorno,
                                                              sv_mens_retorno,
                                                              sn_num_evento
                                                             )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      o_dat_abo.num_abonado := eo_sesion.num_abonado;
      pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr (o_dat_abo,
                                                    sn_cod_retorno,
                                                    sv_mens_retorno,
                                                    sn_num_evento
                                                   );

      IF sn_cod_retorno <> 0
      THEN
         RAISE error_ejecucion;
      END IF;

      o_ve_tipcomis.cod_tipcomis := o_seg_usuario.cod_tipcomis;

      IF NOT (ve_general_servicios_pg.pv_rec_canal_venta_fn (o_ve_tipcomis,
                                                             sn_cod_retorno,
                                                             sv_mens_retorno,
                                                             sn_num_evento
                                                            )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      IF pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn
                                                       ('SW_POLITICA_SIMCARD',
                                                        cv_cod_modulo_ga,
                                                        lv_ind_politica,
                                                        lv_descripcion,
                                                        sn_cod_retorno,
                                                        sv_mens_retorno,
                                                        sn_num_evento
                                                       )
      THEN
         IF lv_ind_politica = '1'
         THEN
            o_tipcontrato.cod_tipcontrato := o_dat_abo.cod_tipcontrato;

            IF NOT (pv_cambio_serie_sb_pg.pv_rec_tipo_contrato_fn
                                                             (o_tipcontrato,
                                                              sn_cod_retorno,
                                                              sv_mens_retorno,
                                                              sn_num_evento
                                                             )
                   )
            THEN
               RAISE error_ejecucion;
            END IF;
         ELSE
            o_tipcontrato.meses_minimo := 0;
         END IF;
      ELSE
         RAISE error_ejecucion;
      END IF;

      IF NOT (pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn
                                                            ('CE',
                                                             cv_cod_modulo_ga,
                                                             lv_indcausa,
                                                             lv_des_parametro,
                                                             sn_cod_retorno,
                                                             sv_mens_retorno,
                                                             sn_num_evento
                                                            )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      o_catplantarif.cod_plantarif := o_dat_abo.cod_plantarif;

      IF NOT (pv_cambio_serie_sb_pg.pv_rec_cat_plan_tarif_fn (o_catplantarif,
                                                              sn_cod_retorno,
                                                              sv_mens_retorno,
                                                              sn_num_evento
                                                             )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_ssql :=
            'SELECT UNIQUE a.cod_modventa, a.des_modventa, a.ind_cuotas, a.ind_pagado, a.cod_caupago, a.ind_abono'
         || ' FROM ge_modventa a, ga_modvent_aplic b'
         || ' WHERE a.cod_modventa = b.cod_modventa'
         || ' AND b.cod_producto = '
         || cv_prod_celular
         || ' AND b.cod_aplic LIKE ''%CSC%'''
         || ' AND b.cod_canal = '
         || o_ve_tipcomis.ind_vta_externa
         || ' AND a.cod_modventa IN ('
         || ' SELECT cod_modpago'
         || ' FROM gad_modpago_catplan c'
         || ' WHERE c.cod_tipcontrato = '
         || o_dat_abo.cod_tipcontrato
         || ' AND c.num_meses = '
         || o_tipcontrato.meses_minimo
         || ' AND c.cod_operacion = ''SA'''
         || ' AND c.ind_causa = '
         || lv_indcausa
         || ' AND c.cod_causa = '''
         || eo_caucaser.cod_caucaser
         || ''''
         || ' AND c.cod_categoria = '''
         || o_catplantarif.cod_categoria
         || ''''
         || ' AND c.cod_canal_vta = '
         || o_ve_tipcomis.ind_vta_externa
         || ' AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta'
         || ' AND c.cod_modpago = a.cod_modventa)';

      IF NOT (pv_cambio_serie_sb_pg.pv_valida_permisos_fn
                                                      (eo_sesion.nom_usuario,
                                                       eo_sesion.cod_programa,
                                                       eo_sesion.num_version,
                                                       'COD_PROC_MODVENTA',
                                                       sn_cod_retorno,
                                                       sv_mens_retorno,
                                                       sn_num_evento
                                                      )
             )
      THEN
         lv_ssql := lv_ssql || ' AND IND_CUOTAS <> -1';
      END IF;

      OPEN sc_mod_pago FOR lv_ssql;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_rec_modalidad_pago_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_rec_modalidad_pago_pr',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_rec_modalidad_pago_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_rec_modalidad_pago_pr',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
   END pv_rec_modalidad_pago_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_val_cau_cam_serie_pr (
      eo_sesion         IN              ge_sesion_qt,
      eo_caucaser       IN              ga_caucaser_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "pv_val_cau_cam_serie_pr"
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Diseñador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno>SEO_dat_abo</Retorno>>
            <Descripción>Causa Cambio de Serie</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="EO_sesion Tipo="estructura"></param>>
               <param nom="EO_caucaser Tipo="estructura"></param>>
               </Entrada>
               <Salida>
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
      error_ejecucion     EXCEPTION;
      n_ind_dev_almacen   NUMBER;
      o_dat_abo           pv_datos_abo_qt        := NEW pv_datos_abo_qt;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF NOT (pv_rec_param_val_cuasa_fn (eo_caucaser,
                                         n_ind_dev_almacen,
                                         sn_cod_retorno,
                                         sv_mens_retorno,
                                         sn_num_evento
                                        )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      IF n_ind_dev_almacen = 1
      THEN
         IF NOT pv_cambio_serie_sb_pg.pv_valida_permisos_fn
                                                     (eo_sesion.nom_usuario,
                                                      eo_sesion.cod_programa,
                                                      eo_sesion.num_version,
                                                      'COD_PROC_CSERGAR',
                                                      sn_cod_retorno,
                                                      sv_mens_retorno,
                                                      sn_num_evento
                                                     )
         THEN
            sv_mens_retorno :=
               'No tiene permisos para seleccionar causa de Cambio de Simcard';
            sn_cod_retorno := 1;
            RAISE error_ejecucion;
         END IF;

         o_dat_abo.num_abonado := eo_sesion.num_abonado;
         pv_cambio_serie_sb_pg.pv_rec_info_abonado_pr (o_dat_abo,
                                                       sn_cod_retorno,
                                                       sv_mens_retorno,
                                                       sn_num_evento
                                                      );

         IF sn_cod_retorno <> 0
         THEN
            RAISE error_ejecucion;
         END IF;

         IF NOT pv_valida_plazo_garantia_fn (eo_sesion.num_abonado,
                                             o_dat_abo.num_serie,
                                             sn_cod_retorno,
                                             sv_mens_retorno,
                                             sn_num_evento
                                            )
         THEN
            sv_mens_retorno := 'Abonado Esta Fuera de Plazo de Garantia.';
            RAISE error_ejecucion;
         END IF;
      END IF;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_val_cau_cam_serie_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_cambio_simcard_sb_pg.pv_val_cau_cam_serie_pr',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_val_cau_cam_serie_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_cambio_simcard_sb_pg.pv_val_cau_cam_serie_pr',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_val_cau_cam_serie_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_cambio_simcard_sb_pg.pv_val_cau_cam_serie_pr',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
   END pv_val_cau_cam_serie_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_reserva_simcard_pr (
      ev_serie                   IN              al_series.num_serie%TYPE,
      en_nummovimientobloqdesb   OUT NOCOPY      al_movimientos.num_transaccion%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "pv_reserva_simcard_pr"
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Diseñador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno>SEO_dat_abo</Retorno>>
            <Descripción>Reserva simcard</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="EV_serie Tipo="CARACTER">Número de Serie</param>>
               <param nom="EN_num_transaccion Tipo="NUMERICO">Numero transaccion</param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lr_movim             al_movimientos%ROWTYPE;
      lv_des_error         ge_errores_pg.desevent;
      lv_ssql              ge_errores_pg.vquery;
      lv_tip_movimiento    ged_parametros.val_parametro%TYPE;
      lv_descripcion       ged_parametros.des_parametro%TYPE;
      ln_cod_estado        al_movimientos.cod_estado_dest%TYPE;
      ln_cod_transaccion   al_tipos_transaccion.cod_transaccion%TYPE   := 24;
      error_ejecucion      EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF NOT pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn
                                                          ('TIP_MOV_RES',
                                                           cv_cod_modulo_ga,
                                                           lv_tip_movimiento,
                                                           lv_descripcion,
                                                           sn_cod_retorno,
                                                           sv_mens_retorno,
                                                           sn_num_evento
                                                          )
      THEN
         RAISE error_ejecucion;
      END IF;

      IF NOT pv_valida_estado_reserva_fn (ln_cod_estado,
                                          sn_cod_retorno,
                                          sv_mens_retorno,
                                          sn_num_evento
                                         )
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_ssql :=
         ' SELECT al_seq_mvto.NEXTVAL,''' || lv_tip_movimiento
         || ''', sysdate,';
      lv_ssql := lv_ssql || 'tip_stock, cod_bodega, cod_articulo, cod_uso, ';
      lv_ssql :=
               lv_ssql || 'cod_estado,' || ln_cod_estado || ', ''SO'', USER, ';
      lv_ssql :=
               lv_ssql || 'num_serie, 0,' || ln_cod_transaccion || ' , NULL, ';
      lv_ssql :=
            lv_ssql
         || 'num_telefono, cod_producto, cod_central,cod_subalm, cod_cat,';
      lv_ssql :=
         lv_ssql
         || 'cod_central,cod_subalm, cod_cat,ind_telefono, plan, carga';
      lv_ssql := lv_ssql || 'FROM al_series ';
      lv_ssql := lv_ssql || 'WHERE num_serie = ''' || ev_serie || '''';

      SELECT al_seq_mvto.NEXTVAL
        INTO en_nummovimientobloqdesb
        FROM DUAL;

      SELECT en_nummovimientobloqdesb, lv_tip_movimiento,
             SYSDATE, tip_stock,
             cod_bodega, cod_articulo, cod_uso,
             cod_estado, ln_cod_estado,
             'SO', USER,
             num_serie, 0,
             ln_cod_transaccion, NULL,
             num_telefono, cod_producto,
             cod_central, cod_subalm, cod_cat,
             cod_central, cod_subalm,
             cod_cat, ind_telefono, PLAN,
             carga, 1
        INTO lr_movim.num_movimiento, lr_movim.tip_movimiento,
             lr_movim.fec_movimiento, lr_movim.tip_stock,
             lr_movim.cod_bodega, lr_movim.cod_articulo, lr_movim.cod_uso,
             lr_movim.cod_estado, lr_movim.cod_estado_dest,
             lr_movim.cod_estadomov, lr_movim.nom_usuarora,
             lr_movim.num_serie, lr_movim.num_desde,
             lr_movim.cod_transaccion, lr_movim.num_transaccion,
             lr_movim.num_telefono, lr_movim.cod_producto,
             lr_movim.cod_central, lr_movim.cod_subalm, lr_movim.cod_cat,
             lr_movim.cod_central_dest, lr_movim.cod_subalm_dest,
             lr_movim.cod_cat_dest, lr_movim.ind_telefono, lr_movim.PLAN,
             lr_movim.carga, lr_movim.num_cantidad
        FROM al_series
       WHERE num_serie = ev_serie;

      al_pac_validaciones.p_inserta_movim (lr_movim);
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 102;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
   END pv_reserva_simcard_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_desreserva_simcard_pr (
      ev_serie                   IN              al_series.num_serie%TYPE,
      en_nummovimientobloqdesb   OUT NOCOPY      al_movimientos.num_transaccion%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "pv_desreserva_simcard_pr"
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Diseñador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno>SEO_dat_abo</Retorno>>
            <Descripción>Des-Reserva simcard</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="EV_serie Tipo="CARACTER">Número de Serie</param>>
               <param nom="EN_num_transaccion Tipo="NUMERICO">Numero transaccion</param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lr_movim             al_movimientos%ROWTYPE;
      lv_des_error         ge_errores_pg.desevent;
      lv_ssql              ge_errores_pg.vquery;
      lv_tip_movimiento    ged_parametros.val_parametro%TYPE;
      lv_descripcion       ged_parametros.des_parametro%TYPE;
      ln_cod_transaccion   al_tipos_transaccion.cod_transaccion%TYPE   := 25;
      error_ejecucion      EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF NOT pv_cambio_serie_sb_pg.pv_obtiene_ged_parametros_fn
                                                          ('TIP_MOV_DESRES',
                                                           cv_cod_modulo_ga,
                                                           lv_tip_movimiento,
                                                           lv_descripcion,
                                                           sn_cod_retorno,
                                                           sv_mens_retorno,
                                                           sn_num_evento
                                                          )
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_ssql :=
         ' SELECT al_seq_mvto.NEXTVAL,''' || lv_tip_movimiento
         || ''', sysdate,';
      lv_ssql := lv_ssql || 'tip_stock, cod_bodega, cod_articulo, ';
      lv_ssql :=
              lv_ssql || 'cod_uso, cod_estado, 1, ''SO'', USER,num_serie, 0, ';
      lv_ssql :=
               lv_ssql || '' || ln_cod_transaccion || ', NULL, num_telefono, ';
      lv_ssql := lv_ssql || 'cod_producto, cod_central,cod_subalm, cod_cat,';
      lv_ssql :=
         lv_ssql
         || 'cod_central,cod_subalm, cod_cat,ind_telefono, plan, carga';
      lv_ssql := lv_ssql || 'FROM al_series ';
      lv_ssql := lv_ssql || 'WHERE num_serie = ''' || ev_serie || '''';

      SELECT al_seq_mvto.NEXTVAL
        INTO en_nummovimientobloqdesb
        FROM DUAL;

      SELECT en_nummovimientobloqdesb, lv_tip_movimiento,
             SYSDATE, tip_stock,
             cod_bodega, cod_articulo, cod_uso,
             cod_estado, 1,
             'SO', USER,
             num_serie, 0,
             ln_cod_transaccion, NULL,
             num_telefono, cod_producto,
             cod_central, cod_subalm, cod_cat,
             cod_central, cod_subalm,
             cod_cat, ind_telefono, PLAN,
             carga, 1
        INTO lr_movim.num_movimiento, lr_movim.tip_movimiento,
             lr_movim.fec_movimiento, lr_movim.tip_stock,
             lr_movim.cod_bodega, lr_movim.cod_articulo, lr_movim.cod_uso,
             lr_movim.cod_estado, lr_movim.cod_estado_dest,
             lr_movim.cod_estadomov, lr_movim.nom_usuarora,
             lr_movim.num_serie, lr_movim.num_desde,
             lr_movim.cod_transaccion, lr_movim.num_transaccion,
             lr_movim.num_telefono, lr_movim.cod_producto,
             lr_movim.cod_central, lr_movim.cod_subalm, lr_movim.cod_cat,
             lr_movim.cod_central_dest, lr_movim.cod_subalm_dest,
             lr_movim.cod_cat_dest, lr_movim.ind_telefono, lr_movim.PLAN,
             lr_movim.carga, lr_movim.num_cantidad
        FROM al_series
       WHERE num_serie = ev_serie;

      al_pac_validaciones.p_inserta_movim (lr_movim);
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_desreserva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_desreserva_simcard_pr',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_desreserva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_desreserva_simcard_pr',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_desreserva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                          (sn_num_evento,
                           cv_cod_modulo,
                           sv_mens_retorno,
                           cv_version,
                           USER,
                           'pv_cambio_simcard_sb_pg.pv_desreserva_simcard_pr',
                           lv_ssql,
                           sn_cod_retorno,
                           lv_des_error
                          );
   END pv_desreserva_simcard_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_evento_restricciones_pr (
      sc_cod_evento     OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "pv_evento_restricciones_pr
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Diseñador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno>SEO_dat_abo</Retorno>>
            <Descripción>eventos restricciones/Descripción>>
            <Parámetros>
               <Entrada>
               </Entrada>
               <Salida>
                <param nom="SC_cod_evento Tipo="CUSOR">listado de eventos</param>>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := 'SELECT cod_evento';
      lv_ssql :=
                lv_ssql || 'FROM pv_actuac_restriccion a, pv_restricciones b';
      lv_ssql := lv_ssql || 'WHERE a.cod_actuacion = ''SA''';
      lv_ssql := lv_ssql || 'AND b.num_restriccion = a.num_restriccion';

      OPEN sc_cod_evento FOR lv_ssql;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_evento_restricciones_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'pv_cambio_simcard_sb_pg.pv_evento_restricciones_pr',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_evento_restricciones_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                        (sn_num_evento,
                         cv_cod_modulo,
                         sv_mens_retorno,
                         cv_version,
                         USER,
                         'pv_cambio_simcard_sb_pg.pv_evento_restricciones_pr',
                         lv_ssql,
                         sn_cod_retorno,
                         lv_des_error
                        );
   END pv_evento_restricciones_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_registra_nueva_simcard_pr (
      er_equipaboser    IN              ga_equipaboser%ROWTYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "pv_registra_nueva_simcard_pr"
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Diseñador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno>SEO_dat_abo</Retorno>>
            <Descripción></Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="ER_equipaboser Tipo="">datos para registrar nueva simcard</param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_ssql := 'INSERT INTO GA_EQUIPABOSER ';
      lv_ssql :=
            lv_ssql || '(NUM_ABONADO, NUM_SERIE, COD_PRODUCTO, IND_PROCEQUI,';
      lv_ssql := lv_ssql || '  FEC_ALTA, IND_PROPIEDAD, ';

      IF TRIM (er_equipaboser.cod_bodega) <> ''
      THEN
         lv_ssql := lv_ssql || ' COD_BODEGA, TIP_STOCK, ';
      END IF;

      lv_ssql := lv_ssql || ' COD_ARTICULO, IND_EQUIACC, COD_MODVENTA, ';
      lv_ssql := lv_ssql || ' TIP_TERMINAL, COD_USO, COD_CUOTA, ';

      IF TRIM (er_equipaboser.cod_estado) <> ''
      THEN
         lv_ssql := lv_ssql || ' COD_ESTADO,';
      END IF;

      IF TRIM (er_equipaboser.num_seriemec) <> ''
      THEN
         lv_ssql := lv_ssql || ' NUM_SERIEMEC, ';
      END IF;

      lv_ssql := lv_ssql || ' DES_EQUIPO ';

      IF TRIM (er_equipaboser.num_movimiento) <> ''
      THEN
         lv_ssql := lv_ssql || ', NUM_MOVIMIENTO ';
      END IF;

      lv_ssql :=
         lv_ssql || ' , COD_CAUSA, IND_EQPRESTADO , NUM_IMEI,COD_TECNOLOGIA) ';
      lv_ssql :=
            lv_ssql
         || ' VALUES( '
         || er_equipaboser.num_abonado
         || ','
         || er_equipaboser.num_serie;
      lv_ssql :=
            lv_ssql
         || ' ,'
         || cv_prod_celular
         || ','
         || er_equipaboser.ind_procequi
         || ',sysdate';
      lv_ssql := lv_ssql || ' ,' || er_equipaboser.ind_propiedad || ',';

      IF TRIM (er_equipaboser.cod_bodega) <> ''
      THEN
         lv_ssql :=
               lv_ssql
            || ' '
            || er_equipaboser.cod_bodega
            || ','
            || er_equipaboser.tip_stock
            || ',';
      END IF;

      lv_ssql :=
            lv_ssql
         || ' '
         || er_equipaboser.cod_articulo
         || ',''E'','
         || er_equipaboser.cod_modventa;
      lv_ssql :=
            lv_ssql
         || ','
         || er_equipaboser.tip_terminal
         || ','
         || er_equipaboser.cod_uso
         || ','
         || er_equipaboser.cod_cuota;

      IF TRIM (er_equipaboser.cod_estado) <> ''
      THEN
         lv_ssql := lv_ssql || ' ' || er_equipaboser.cod_estado || ',';
      END IF;

      IF TRIM (er_equipaboser.num_seriemec) <> ''
      THEN
         lv_ssql := lv_ssql || ' ' || er_equipaboser.num_seriemec || ',';
      END IF;

      lv_ssql := lv_ssql || ' ' || er_equipaboser.des_equipo;

      IF TRIM (er_equipaboser.num_movimiento) <> ''
      THEN
         lv_ssql := lv_ssql || ', ' || er_equipaboser.num_movimiento;
      END IF;

      lv_ssql := lv_ssql || ',NULL, 0, ' || er_equipaboser.num_imei || ',';
      lv_ssql := lv_ssql || ' ' || er_equipaboser.cod_tecnologia || ')';

      EXECUTE IMMEDIATE lv_ssql;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_registra_nueva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                      (sn_num_evento,
                       cv_cod_modulo,
                       sv_mens_retorno,
                       cv_version,
                       USER,
                       'pv_cambio_simcard_sb_pg.pv_registra_nueva_simcard_pr',
                       lv_ssql,
                       sn_cod_retorno,
                       lv_des_error
                      );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_registra_nueva_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                      (sn_num_evento,
                       cv_cod_modulo,
                       sv_mens_retorno,
                       cv_version,
                       USER,
                       'pv_cambio_simcard_sb_pg.pv_registra_nueva_simcard_pr',
                       lv_ssql,
                       sn_cod_retorno,
                       lv_des_error
                      );
   END pv_registra_nueva_simcard_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_rec_datos_simcard_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sc_dat_sim        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "pv_rec_datos_simcard_pr"
            Lenguaje="PL/SQL"
            Fecha="18-07-2007"
            Versión="1.0"
            Diseñador="Marcelo Godoy'
            Programador="Marcelo Godoy"
            Ambiente Desarrollo="BD">
            <Retorno>SEO_dat_abo</Retorno>>
            <Descripción>Recupera Datos simcard</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="EV_serie Tipo="CARACTER">Numero de serie</param>>
               </Entrada>
               <Salida>
                <param nom="SC_dat_sim   Tipo="CURSOR">Datos Simcard</param>>
                  <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      sn_cod_bodega     ga_equipaboser.cod_bodega%TYPE;
      error_ejecucion   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF NOT (pv_verifica_reserva_fn (ev_serie,
                                      sn_cod_bodega,
                                      sn_cod_retorno,
                                      sv_mens_retorno,
                                      sn_num_evento
                                     )
             )
      THEN
         RAISE error_ejecucion;
      END IF;

      lv_ssql := 'SELECT ';
      lv_ssql :=
         lv_ssql || ' a.cod_bodega,a.cod_articulo,a.cod_estado,b.des_articulo';
      lv_ssql := lv_ssql || ' FROM al_series a ,al_articulos  b ';
      lv_ssql := lv_ssql || ' WHERE num_serie=''' || ev_serie || '''';
      lv_ssql := lv_ssql || ' AND a.COD_ARTICULO = b.COD_ARTICULO(+)';

      OPEN sc_dat_sim FOR lv_ssql;
   EXCEPTION
      WHEN error_ejecucion
      THEN
         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_rec_datos_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                             (sn_num_evento,
                              cv_cod_modulo,
                              sv_mens_retorno,
                              cv_version,
                              USER,
                              'pv_cambio_simcard_sb_pg.pv_reserva_simcard_pr',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );
      WHEN NO_DATA_FOUND
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_rec_datos_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_cambio_simcard_sb_pg.pv_rec_datos_simcard_pr',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
      WHEN OTHERS
      THEN
         sn_cod_retorno := 999;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=
               'pv_cambio_simcard_sb_pg.pv_rec_datos_simcard_pr('
            || '); - '
            || SQLERRM;
         sn_num_evento :=
            ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'pv_cambio_simcard_sb_pg.pv_rec_datos_simcard_pr',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
   END pv_rec_datos_simcard_pr;


   /* inicio RRG   03-02-2009 70904 - validar serie externa */
   PROCEDURE pv_valida_serie_externa_pr (
      ev_serie                   IN              al_series.num_serie%TYPE,
      sn_cod_retorno             OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno            OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento              OUT NOCOPY      ge_errores_pg.evento




   )
   IS

      LN_ocupada_abonado			 number(2);
	  LN_existe_al_series		 number(2);
	  LN_dias_anul_baja			 number(4);

	  lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;

	  error_ejecucion      EXCEPTION;

	  LB_es_lista_Negra	   boolean;

	  LV_DesError VARCHAR2(100);
	  LN_CodError NUMBER(3);


   begin

	  sn_cod_retorno := 0;
   	  sv_mens_retorno := NULL;
   	  sn_num_evento := 0;

	  -- Valida listas negras

	  lv_ssql := 'SELECT pv_valida_lista_negra_fn(ev_serie,sn_cod_retorno,sv_mens_retorno,sn_num_evento) FROM dual';

	  /*IF  not pv_cambio_simcard_sb_pg.pv_valida_lista_negra_fn(ev_serie,sn_cod_retorno,sv_mens_retorno,sn_num_evento) THEN
		  sn_cod_retorno := 473;
	  	  RAISE error_ejecucion;
	  END IF;*/

	  PAC_NSR_NEG.P_CONS_NSR_NEG(ev_serie,LB_es_lista_Negra,LN_CodError,LV_DesError);

	  IF LB_es_lista_Negra THEN
	  	  sn_cod_retorno := 473;
	  	  RAISE error_ejecucion;
	  END IF;


	  -- valida abonado


	  lv_ssql := 'SELECT val_parametro FROM ged_parametros WHERE nom_parametro = NUM_DIASMAXANULBAJA';


	  SELECT val_parametro
	  INTO  LN_dias_anul_baja
	  FROM ged_parametros
	  WHERE nom_parametro = 'NUM_DIASMAXANULBAJA';


	  lv_ssql := 'SELECT count(1) FROM ga_abocel WHERE num_imei = ev_serie AND fec_baja + N_dias_anul_baja > sysdate ';
	  lv_ssql := lv_ssql || ' union ';
	  lv_ssql := lv_ssql || 'SELECT count(1) FROM ga_abocel WHERE num_imei = ev_serie AND fec_baja + N_dias_anul_baja > sysdate ';
	  lv_ssql := lv_ssql || 'AND rownum=1;';

	  SELECT count(1)
	  INTO LN_ocupada_abonado
	  FROM ga_abocel
	  WHERE num_imei = ev_serie
	  AND cod_situacion = 'AAA';

	  IF LN_ocupada_abonado > 0 THEN
		  sn_cod_retorno := 474;
	  	  RAISE error_ejecucion;
	  END IF;

	  SELECT count(1)
	  INTO LN_ocupada_abonado
	  FROM ga_aboamist
	  WHERE num_imei = ev_serie
	  AND cod_situacion = 'AAA';

	  IF LN_ocupada_abonado > 0 THEN
		  sn_cod_retorno := 475;
	  	  RAISE error_ejecucion;
	  END IF;


	  --- validar abonados de baja
	  SELECT count(1)
	  INTO LN_ocupada_abonado
	  FROM ga_abocel
	  WHERE
	  fec_baja >= (sysdate - LN_dias_anul_baja)
	  AND num_imei = ev_serie
	  AND cod_situacion in ('BAA','BAP');

	  IF LN_ocupada_abonado > 0 THEN
		  sn_cod_retorno := 474;
	  	  RAISE error_ejecucion;
	  END IF;

	  SELECT count(1)
	  INTO LN_ocupada_abonado
	  FROM ga_aboamist
	  WHERE
	  fec_baja >= (sysdate - LN_dias_anul_baja)
	  AND num_imei = ev_serie
	  AND cod_situacion in ('BAA','BAP');

	  IF LN_ocupada_abonado > 0 THEN
		  sn_cod_retorno := 475;
	  	  RAISE error_ejecucion;
	  END IF;




	  -- valida al_series

	  lv_ssql := 'SELECT count(1) FROM al_series WHERE num_serie = ev_serie';

	  SELECT count(1)
	  INTO LN_existe_al_series
	  FROM al_series
	  WHERE num_serie = ev_serie;

	  IF LN_existe_al_series > 0 THEN
		  sn_cod_retorno:=523;
	  	  RAISE error_ejecucion;
	  END IF;


	  sn_cod_retorno := 0;
      sv_mens_retorno:= 'OK';
      sn_num_evento  := 0;


   Exception

   WHEN error_ejecucion THEN

		IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := 'no clasIFicado';
         END IF;

   		lv_des_error := 'pv_cambio_simcard_sb_pg.pv_valida_serie_externa_pr('|| ev_serie ||');';

        sn_num_evento := ge_errores_pg.grabarpl
                     (sn_num_evento,
                      'GA',
                      sv_mens_retorno,
                      1,
                      USER,
                      'pv_cambio_simcard_sb_pg.pv_valida_serie_externa_pr',
                      lv_ssql,
                      sn_cod_retorno,
                      lv_des_error
                     );



   WHEN others THEN
   		 sn_cod_retorno := 102;
         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := 'no clasIFicado';
         END IF;
         lv_des_error := 'pv_cambio_simcard_sb_pg.pv_valida_serie_externa_pr('|| ev_serie ||');';

         sn_num_evento :=  ge_errores_pg.grabarpl
                             (sn_num_evento,
                              'GA',
                              sv_mens_retorno,
                              1,
                              USER,
                              'pv_cambio_simcard_sb_pg.pv_valida_serie_externa_pr',
                              lv_ssql,
                              sn_cod_retorno,
                              lv_des_error
                             );




   END pv_valida_serie_externa_pr;
   /* fin RRG  03-02-2009 70904 - validar serie externa */


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END pv_cambio_simcard_sb_pg;
/
SHOW ERRORS