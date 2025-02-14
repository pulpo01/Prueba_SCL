CREATE OR REPLACE PACKAGE BODY ve_servicios_direc_quiosco_pg IS
--------------------
-- PROCEDIMIENTOS --
--------------------
   PROCEDURE ve_getdireccion_pr (
      ev_codsujeto       IN              VARCHAR2,
      en_tipsujeto       IN              NUMBER,
      en_tipdireccion    IN              NUMBER,
      en_tipdisplay      IN              NUMBER,
      sv_cod_region      OUT NOCOPY      VARCHAR2,
      sv_cod_provincia   OUT NOCOPY      VARCHAR2,
      sv_cod_ciudad      OUT NOCOPY      VARCHAR2,
      sv_cod_comuna      OUT NOCOPY      VARCHAR2,
      sv_nom_calle       OUT NOCOPY      VARCHAR2,
      sv_num_calle       OUT NOCOPY      VARCHAR2,
      sv_num_piso        OUT NOCOPY      VARCHAR2,
      sv_num_casilla     OUT NOCOPY      VARCHAR2,
      sv_obs_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_direc1      OUT NOCOPY      VARCHAR2,
      sv_des_direc2      OUT NOCOPY      VARCHAR2,
      sv_cod_pueblo      OUT NOCOPY      VARCHAR2,
      sv_cod_estado      OUT NOCOPY      VARCHAR2,
      sv_zip             OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getDireccion_PR"
         Lenguaje="PL/SQL"
         Fecha="12-04-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
         Retorna direccion del cliente
      </Retorno>
      <Descripción>
         Retorna direccion del cliente
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_codSujeto"    Tipo="VARCHAR2"> copdigo tipo de sujero </param>
         <param nom="EV_tipSujeto"    Tipo="VARCHAR2"> tipo de sujero </param>
         <param nom="EV_tipDireccion" Tipo="VARCHAR2"> tipo direccion </param>
         <param nom="EV_tipDisplay"   Tipo="VARCHAR2"> tipo display (descr. corta o larga) </param>
      </Entrada>
      <Salida>
         <param nom="SV_valor"        Tipo="VARCHAR2"> direccion cliente </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER">codigo de retorno del procedimiento</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
         <param nom="SN_num_evento"   Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      le_exception_fin   EXCEPTION;
      la_arreglo1        ve_intermediario_pg.tipoarray := ve_intermediario_pg.tipoarray ();
      la_arreglo2        ve_intermediario_pg.tipoarray := ve_intermediario_pg.tipoarray ();
      lv_des_error       ge_errores_pg.desevent;
      lv_sql             ge_errores_pg.vquery;
      lv_string          VARCHAR2 (1000);
      lv_dato1           VARCHAR2 (100);
      lv_dato2           VARCHAR2 (100);
      ln_indice1         NUMBER;
      ln_indice2         NUMBER;
      ln_columna         NUMBER;
      lv_valorcolumna    VARCHAR2 (100);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      sv_cod_region := '';
      sv_cod_provincia := '';
      sv_cod_ciudad := '';
      sv_cod_comuna := '';
      sv_nom_calle := '';
      sv_num_calle := '';
      sv_num_piso := '';
      sv_num_casilla := '';
      sv_obs_direccion := '';
      sv_des_direc1 := '';
      sv_des_direc2 := '';
      sv_cod_pueblo := '';
      sv_cod_estado := '';
      sv_zip := '';
      lv_sql := 'SELECT GE_FN_OBTIENE_DIRCLIE(EV_codSujeto,EV_tipSujeto,EV_tipDireccion,EV_tipDisplay)' || ' FROM DUAL ';

      SELECT ge_fn_obtiene_dirclie (ev_codsujeto, en_tipsujeto, en_tipdireccion, en_tipdisplay)
        INTO lv_string
        FROM DUAL;

      IF (en_tipdisplay = 1) THEN
         -- tipo display 1 (descripcion corta direccion)
         sv_des_direc1 := lv_string;
      ELSE
         -- tipo display 2 (codigos direccion) 3 (descripcion completa direccion)
         la_arreglo1 := ve_intermediario_pg.ve_descompone_cadena_fn (lv_string, ';', sn_cod_retorno, sv_mens_retorno, sn_num_evento);

         IF (sn_cod_retorno <> 0) THEN
            RAISE le_exception_fin;
         END IF;

         -- Recorremos arreglo que contiene la direccion
         ln_indice1 := 1;

         FOR ln_indice1 IN 1 .. la_arreglo1.COUNT - 1 LOOP
            lv_dato1 := la_arreglo1 (ln_indice1);
            la_arreglo2 := ve_intermediario_pg.ve_descompone_cadena_fn (lv_dato1, ':', sn_cod_retorno, sv_mens_retorno, sn_num_evento);

            IF (sn_cod_retorno <> 0) THEN
               RAISE le_exception_fin;
            END IF;

            -- Obtenemos identificador columna y valor columna
            FOR ln_indice2 IN 1 .. la_arreglo2.COUNT LOOP
               lv_dato2 := la_arreglo2 (ln_indice2);

               IF (ln_indice2 = 1) THEN
                  ln_columna := la_arreglo2 (ln_indice2);
               END IF;

               IF (en_tipdisplay = 2 AND ln_indice2 = 2) THEN
                  lv_valorcolumna := la_arreglo2 (ln_indice2);
               END IF;

               IF (en_tipdisplay = 3 AND ln_indice2 = 3) THEN
                  lv_valorcolumna := la_arreglo2 (ln_indice2);
               END IF;

               IF (lv_valorcolumna = '0') THEN
                  lv_valorcolumna := '';
               END IF;
            END LOOP;

            CASE ln_columna
               WHEN cn_region THEN
                  sv_cod_region := lv_valorcolumna;
               WHEN cn_provincia THEN
                  sv_cod_provincia := lv_valorcolumna;
               WHEN cn_ciudad THEN
                  sv_cod_ciudad := lv_valorcolumna;
               WHEN cn_comuna THEN
                  sv_cod_comuna := lv_valorcolumna;
               WHEN cn_calle THEN
                  sv_nom_calle := lv_valorcolumna;
               WHEN cn_numero THEN
                  sv_num_calle := lv_valorcolumna;
               WHEN cn_piso THEN
                  sv_num_piso := lv_valorcolumna;
               WHEN cn_casilla THEN
                  sv_num_casilla := lv_valorcolumna;
               WHEN cn_observacion THEN
                  sv_obs_direccion := lv_valorcolumna;
               WHEN cn_des_direc1 THEN
                  sv_des_direc1 := lv_valorcolumna;
               WHEN cn_des_direc2 THEN
                  sv_des_direc2 := lv_valorcolumna;
               WHEN cn_pueblo THEN
                  sv_cod_pueblo := lv_valorcolumna;
               WHEN cn_estado THEN
                  sv_cod_estado := lv_valorcolumna;
               WHEN cn_zip THEN
                  sv_zip := lv_valorcolumna;
               ELSE                                                                                                                                                                   --_output.put_line('ERROR, en identificador columna' || LV_valorColumna);
                  RAISE le_exception_fin;
            END CASE;
         END LOOP;
      END IF;
   EXCEPTION
      WHEN le_exception_fin THEN
         sn_cod_retorno := 3;
         lv_des_error := 'LE_exception_fin: ve_servicios_direc_quiosco_pg.VE_getDireccion_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getDireccion_PR', lv_sql, SQLCODE, lv_des_error);
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10919;
         sv_mens_retorno:= 'Error al intentar retornar direccion del cliente';

         lv_des_error := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_getDireccion_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getDireccion_PR', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10919;
         sv_mens_retorno:= 'Error el intentar recuperar direccion de cliente.';


         lv_des_error := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_getDireccion_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getDireccion_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_getdireccion_pr;

   PROCEDURE ve_getdireccioncodigo_pr (
      en_cod_direccion   IN              NUMBER,
      sv_cod_provincia   OUT NOCOPY      VARCHAR2,
      sv_cod_region      OUT NOCOPY      VARCHAR2,
      sv_cod_ciudad      OUT NOCOPY      VARCHAR2,
      sv_cod_comuna      OUT NOCOPY      VARCHAR2,
      sv_nom_calle       OUT NOCOPY      VARCHAR2,
      sv_num_calle       OUT NOCOPY      VARCHAR2,
      sv_num_piso        OUT NOCOPY      VARCHAR2,
      sv_num_casilla     OUT NOCOPY      VARCHAR2,
      sv_obs_direccion   OUT NOCOPY      VARCHAR2,
      sv_des_direc1      OUT NOCOPY      VARCHAR2,
      sv_des_direc2      OUT NOCOPY      VARCHAR2,
      sv_cod_pueblo      OUT NOCOPY      VARCHAR2,
      sv_cod_estado      OUT NOCOPY      VARCHAR2,
      sv_zip             OUT NOCOPY      VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getDireccionCodigo_PR"
         Lenguaje="PL/SQL"
         Fecha="22-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Obtiene direccion segun codigo
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
          </Entrada>
            <Salida>
              <param nom="SV_cod_provincia"  Tipo="STRING"> codigo provincia </param>
              <param nom="SV_cod_region"       Tipo="STRING"> codigo region </param>
              <param nom="SV_cod_ciudad"       Tipo="STRING"> codigo ciudad </param>
              <param nom="SV_cod_comuna"       Tipo="STRING"> codigo cimuna </param>
              <param nom="SV_nom_calle"     Tipo="STRING"> nombre calle </param>
              <param nom="SV_num_calle"     Tipo="STRING"> numero calle </param>
              <param nom="SV_num_piso"      Tipo="STRING"> numero piso </param>
              <param nom="SV_num_casilla"    Tipo="STRING"> numero casilla </param>
              <param nom="SV_obs_direccion"  Tipo="STRING"> observacion </param>
              <param nom="SV_des_direc1"       Tipo="STRING"> descripcion 1 </param>
              <param nom="SV_des_direc2"       Tipo="STRING"> descripcion 2 </param>
              <param nom="SV_cod_pueblo"       Tipo="STRING"> codigo pueblo </param>
              <param nom="SV_cod_estado"       Tipo="STRING"> codigo estado </param>
              <param nom="SV_zip"        Tipo="STRING"> zip </param>
            <param nom="SN_codRetorno"     Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"     Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"      Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'SELECT a.cod_region, ' || 'a.cod_provincia, ' || 'a.cod_ciudad, ' || 'a.cod_comuna, ' || 'a.nom_calle, ' || 'a.num_calle, ' || 'a.num_piso, ' || 'a.num_casilla, ' || 'a.obs_direccion, ' || 'a.des_direc1, ' || 'a.des_direc2, '
         || 'a.cod_pueblo, ' || 'a.cod_estado, ' || 'a.zip ' || 'FROM ge_direcciones a ' || 'WHERE a.cod_direccion = ' || en_cod_direccion;

      SELECT a.cod_region, a.cod_provincia, a.cod_ciudad, a.cod_comuna, a.nom_calle, a.num_calle, a.num_piso, a.num_casilla, a.obs_direccion, a.des_direc1, a.des_direc2, a.cod_pueblo, a.cod_estado, a.zip
        INTO sv_cod_region, sv_cod_provincia, sv_cod_ciudad, sv_cod_comuna, sv_nom_calle, sv_num_calle, sv_num_piso, sv_num_casilla, sv_obs_direccion, sv_des_direc1, sv_des_direc2, sv_cod_pueblo, sv_cod_estado, sv_zip
        FROM ge_direcciones a
       WHERE a.cod_direccion = en_cod_direccion;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10920;
         sv_menretorno:= 'Error al intentar recuperar dirección según código ingresado';

         lv_deserror := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_getDireccionCodigo_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getDireccionCodigo_PR', lv_sql, SQLCODE, lv_deserror);
      WHEN OTHERS THEN
         sn_codretorno := 10920;
         sv_menretorno:= 'Error al intentar recuperar dirección según código ingresado';


         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_getDireccionCodigo_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getDireccionCodigo_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getdireccioncodigo_pr;

--------------------------------------------------------------------------------------------
--* CURSORES - LISTAS
--------------------------------------------------------------------------------------------
   PROCEDURE ve_getlistconfigdirecciones_pr (
      ev_codoperadora   IN              ge_paramdiroperad.cod_operad%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListConfigDirecciones_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna configuracion que deben tener las operadoras
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codOperadora" Tipo="STRING"> codigo operadora </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'SELECT a.cod_paramdir, ' || 'a.tip_dat, ' || 'a.sec_dat, ' || 'a.caption, ' || 'a.nom_column, ' || 'a.tip_format, ' || 'b.orden, ' || 'b.ind_obligatorio, ' || 'a.largo ' || 'FROM ge_paramdir a, ge_paramdiroperad b ' || 'WHERE b.cod_operad = '''
         || ev_codoperadora || '''' || 'AND b.cod_paramdir = a.cod_paramdir ' || 'ORDER BY b.orden';
      ln_contador := 0;

      SELECT   COUNT (1)
          INTO ln_contador
          FROM ge_paramdir a, ge_paramdiroperad b
         WHERE b.cod_operad = ev_codoperadora AND b.cod_paramdir = a.cod_paramdir
      ORDER BY b.orden;

      OPEN sc_cursordatos FOR
         SELECT   a.cod_paramdir, a.tip_dat, a.sec_dat, a.caption, a.nom_column, a.tip_format, b.orden, b.ind_obligatorio, a.largo
             FROM ge_paramdir a, ge_paramdiroperad b
            WHERE b.cod_operad = ev_codoperadora AND b.cod_paramdir = a.cod_paramdir
         ORDER BY b.orden;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10921;
         sv_menretorno := 'Error al intentar recuperar configuracion de operadoras';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:ve_servicios_direc_quiosco_pg.VE_getListConfigDirecciones_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListConfigDirecciones_PR', lv_sql, sn_codretorno, lv_deserror);
      WHEN OTHERS THEN
         sn_codretorno := 10921;
         sv_menretorno := 'Error al intentar recuperar configuracion de operadoras';


         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_getListConfigDirecciones_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListConfigDirecciones_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistconfigdirecciones_pr;

   PROCEDURE ve_getlistcomunas_pr (
      ev_codregion      IN              ge_ciucom.cod_region%TYPE,
      ev_codprovincia   IN              ge_ciucom.cod_provincia%TYPE,
      ev_codciudad      IN              ge_ciucom.cod_ciudad%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListComunas_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna listado de comunas segun parametros de entrada
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codRegion"    Tipo="STRING"> codigo region </param>
            <param nom="EN_codProvincia" Tipo="STRING"> codigo provinvia </param>
            <param nom="EN_codCiudad"    Tipo="STRING"> codigo ciudad </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;

      IF (ev_codciudad IS NOT NULL) AND (LENGTH (ev_codciudad)) > 0 THEN
         SELECT COUNT (1)
           INTO ln_contador
           FROM ge_ciucom a, ge_comunas b
          WHERE a.cod_region = ev_codregion AND a.cod_provincia = ev_codprovincia AND a.cod_ciudad = ev_codciudad AND a.cod_region = b.cod_region AND a.cod_provincia = b.cod_provincia AND a.cod_comuna = b.cod_comuna;

         lv_sql :=
            'SELECT a.cod_comuna, b.des_comuna ' || ' FROM ge_ciucom a, ge_comunas b ' || ' WHERE a.cod_region = ''' || ev_codregion || '''' || ' AND a.cod_provincia = ''' || ev_codprovincia || '''' || ' AND a.cod_ciudad = ''' || ev_codciudad || ''''
            || ' AND a.cod_region = b.cod_region ' || ' AND a.cod_provincia = b.cod_provincia ' || ' AND a.cod_comuna = b.cod_comuna';
      ELSE
         SELECT COUNT (1)
           INTO ln_contador
           FROM ge_comunas a
          WHERE a.cod_region = ev_codregion AND a.cod_provincia = ev_codprovincia;

         lv_sql := 'SELECT a.cod_comuna, a.des_comuna ' || ' FROM ge_comunas a ' || ' WHERE a.cod_region = ''' || ev_codregion || '''' || ' AND a.cod_provincia = ''' || ev_codprovincia || '''';
      END IF;

      OPEN sc_cursordatos FOR lv_sql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10922;
         sv_menretorno:= 'Error al intentar retornar listado de comunas.';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:ve_servicios_direc_quiosco_pg.VE_getListComunas_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListComunas_PR', lv_sql, sn_codretorno, lv_deserror);
      WHEN OTHERS THEN
         sn_codretorno := 10922;
         sv_menretorno:= 'Error al intentar retornar listado de comunas.';


         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_getListComunas_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListComunas_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistcomunas_pr;

   PROCEDURE ve_getlistestados_pr (
      ev_indorden      IN              VARCHAR2,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListEstados_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna listado de estados
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_indOrden" Tipo="STRING"> indicador orden </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'SELECT a.cod_estado, a.des_estado ' || 'FROM ge_estados a ';

      IF (ev_indorden = 'S') THEN
         lv_sql := lv_sql || 'ORDER BY 2';
      END IF;

      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_estados;

      OPEN sc_cursordatos FOR lv_sql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
                  sn_codretorno := 10923;
         sv_menretorno:= 'Error al intentar recuperar listado de estados';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:ve_servicios_direc_quiosco_pg.VE_getListEstados_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListEstados_PR', lv_sql, sn_codretorno, lv_deserror);
      WHEN OTHERS THEN
         sn_codretorno := 10923;
         sv_menretorno:= 'Error al intentar recuperar listado de estados';


         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_getListEstados_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListEstados_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistestados_pr;

   PROCEDURE ve_getlistpueblos_pr (
      ev_codestado     IN              ge_pueblos.cod_estado%TYPE,
      ev_indorden      IN              VARCHAR2,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListPueblos_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna listado de pueblos segun cosigo de estado
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_indOrden" Tipo="STRING"> indicador orden </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'SELECT a.cod_pueblo, a.des_pueblo ' || 'FROM ge_pueblos a ' || 'WHERE a.cod_estado = ''' || ev_codestado || '''';

      IF (ev_indorden = 'S') THEN
         lv_sql := lv_sql || ' ORDER BY 2';
      END IF;

      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_pueblos a
       WHERE a.cod_estado = ev_codestado;

      OPEN sc_cursordatos FOR lv_sql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10924;
         sv_menretorno:='Error al intenetar recuperar codigo de estado de pueblos.';


         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:ve_servicios_direc_quiosco_pg.VE_getListPueblos_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListPueblos_PR', lv_sql, sn_codretorno, lv_deserror);
      WHEN OTHERS THEN
         sn_codretorno := 10924;
         sv_menretorno:='Error al intenetar recuperar codigo de estado de pueblos.';


         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_getListPueblos_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListPueblos_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistpueblos_pr;

   PROCEDURE ve_getlistzip_pr (
      ev_codzona       IN              ge_zipcode_td.cod_zona%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListZip_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna listado de ZIP segun zona.
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codZona" Tipo="STRING"> codigo zona </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'SELECT a.zip ' || 'FROM ge_zipcode_td a ' || 'WHERE a.cod_zona = ''' || ev_codzona || '''';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_zipcode_td a
       WHERE a.cod_zona = ev_codzona;

      OPEN sc_cursordatos FOR
         SELECT a.zip
           FROM ge_zipcode_td a
          WHERE a.cod_zona = ev_codzona;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10925;
         sv_menretorno:='Error al intentar recuperar listado de ZIP.';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:ve_servicios_direc_quiosco_pg.VE_getListZip_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListZip_PR', lv_sql, sn_codretorno, lv_deserror);
      WHEN OTHERS THEN
         sn_codretorno := 10925;
         sv_menretorno:='Error al intentar recuperar listado de ZIP.';



         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_getListZip_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_getListZip_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistzip_pr;

   PROCEDURE ve_listadoregiones_pr (
      ev_indorden       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_listadoregiones_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Listado de regiones</Retorno>
                                                             <Descripción>
                                                                Listado de regiones
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada> NA</Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con regiones</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT region.cod_region, region.des_region' || ' FROM ge_regiones region';

      IF (ev_indorden = 'S') THEN
         lv_sql := lv_sql || ' ORDER BY 2';
      END IF;

      SELECT COUNT (1)
        INTO ln_count
        FROM ge_regiones region
       WHERE ROWNUM <= 1;

      OPEN sc_cursordatos FOR lv_sql;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno := 0;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_errornoclasif;
         END IF;

         lv_des_error := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_listadoregiones_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadoregiones_PR()', lv_sql, SQLCODE, lv_des_error);
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10926;
         sv_mens_retorno:='Error al intentar recuperar regiones.';


         lv_des_error := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_listadoregiones_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadoregiones_PR()', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10926;
         sv_mens_retorno:='Error al intentar recuperar regiones.';


         lv_des_error := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_listadoregiones_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadoregiones_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_listadoregiones_pr;

   PROCEDURE ve_listadoprovincias_pr (
      ev_codregion      IN              ge_regiones.cod_region%TYPE,
      ev_indorden       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_listadoprovincias_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Listado de provincias</Retorno>
                                                             <Descripción>
                                                                Listado de provincias
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EV_codregion" Tipo="VARCHAR2">codigo region</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con provincias</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT provincia.cod_provincia, provincia.des_provincia' || ' FROM ge_provincias provincia' || ' WHERE provincia.cod_region = ''' || ev_codregion || '''';

      IF (ev_indorden = 'S') THEN
         lv_sql := lv_sql || ' ORDER BY 2';
      END IF;

      SELECT COUNT (1)
        INTO ln_count
        FROM ge_provincias provincia
       WHERE provincia.cod_region = ev_codregion AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR lv_sql;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno := 0;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_errornoclasif;
         END IF;

         lv_des_error := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_listadoprovincias_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadoprovincias_PR()', lv_sql, SQLCODE, lv_des_error);
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10927;
         sv_mens_retorno:='Error al intetar recuperar provincias.';


         lv_des_error := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_listadoprovincias_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadoprovincias_PR()', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10927;
         sv_mens_retorno:='Error al intetar recuperar provincias.';


         lv_des_error := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_listadoprovincias_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadoprovincias_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_listadoprovincias_pr;

   PROCEDURE ve_listadociudades_pr (
      ev_codregion      IN              ge_regiones.cod_region%TYPE,
      ev_codprovincia   IN              ge_provincias.cod_provincia%TYPE,
      ev_indorden       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentación TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_listadociudades_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="21-03-2007"
                                                                Versión="1.0.0"
                                                                Diseñador="Roberto Pérez Varas"
                                                                Programador="Roberto Pérez Varas"
                                                                Ambiente="BD"
                                                             <Retorno>Listado de ciudades</Retorno>
                                                             <Descripción>
                                                                Listado de ciudades
                                                             </Descripción>
                                                             <Parametros>
                                                             <Entrada>
                                                                  <param nom="EV_codregion" Tipo="VARCHAR2">codigo region</param>
                                                                  <param nom="EV_codprovincia" Tipo="VARCHAR2">codigo provincia</param>
                                                             </Entrada>
                                                             <Salida>
                                                                  <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con ciudades</param>
                                                                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentación>
                                                             */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_sql                    ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT ciudad.cod_ciudad, ciudad.des_ciudad' || ' FROM ge_ciudades ciudad' || ' WHERE ciudad.cod_region = ''' || ev_codregion || '''' || ' AND ciudad.cod_provincia = ''' || ev_codprovincia || '''';

      IF (ev_indorden = 'S') THEN
         lv_sql := lv_sql || ' ORDER BY 2';
      END IF;

      SELECT COUNT (1)
        INTO ln_count
        FROM ge_ciudades ciudad
       WHERE ciudad.cod_region = ev_codregion AND ciudad.cod_provincia = ev_codprovincia AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR lv_sql;

      IF ln_count = 0 THEN
         RAISE le_no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN le_no_data_found_cursor THEN
         sn_cod_retorno := 0;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
            sv_mens_retorno := cv_errornoclasif;
         END IF;

         lv_des_error := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_listadociudades_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadociudades_PR()', lv_sql, SQLCODE, lv_des_error);
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10928;
         sv_mens_retorno:='Error al intentar recuperar ciudades';


         lv_des_error := 'NO_DATA_FOUND:ve_servicios_direc_quiosco_pg.VE_listadociudades_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadociudades_PR()', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10928;
         sv_mens_retorno:='Error al intentar recuperar ciudades';


         lv_des_error := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_listadociudades_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_listadociudades_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_listadociudades_pr;

--------------------------------------------------------------------------------------------
--* INSERTS , UPDATES y DELETES
--------------------------------------------------------------------------------------------
   PROCEDURE ve_upddireccion_pr (
      en_cod_direccion   IN              NUMBER,
      ev_cod_provincia   IN              VARCHAR2,
      ev_cod_region      IN              VARCHAR2,
      ev_cod_ciudad      IN              VARCHAR2,
      ev_cod_comuna      IN              VARCHAR2,
      ev_nom_calle       IN              VARCHAR2,
      ev_num_calle       IN              VARCHAR2,
      ev_num_piso        IN              VARCHAR2,
      ev_num_casilla     IN              VARCHAR2,
      ev_obs_direccion   IN              VARCHAR2,
      ev_des_direc1      IN              VARCHAR2,
      ev_des_direc2      IN              VARCHAR2,
      ev_cod_pueblo      IN              VARCHAR2,
      ev_cod_estado      IN              VARCHAR2,
      ev_zip             IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updDireccion_PR"
         Lenguaje="PL/SQL"
         Fecha="21-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Actualiza direccion
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
              <param nom="EV_cod_provincia"  Tipo="STRING"> codigo provincia </param>
              <param nom="EV_cod_region"       Tipo="STRING"> codigo region </param>
              <param nom="EV_cod_ciudad"       Tipo="STRING"> codigo ciudad </param>
              <param nom="EV_cod_comuna"       Tipo="STRING"> codigo cimuna </param>
              <param nom="EV_nom_calle"     Tipo="STRING"> nombre calle </param>
              <param nom="EV_num_calle"     Tipo="STRING"> numero calle </param>
              <param nom="EV_num_piso"      Tipo="STRING"> numero piso </param>
              <param nom="EV_num_casilla"    Tipo="STRING"> numero casilla </param>
              <param nom="EV_obs_direccion"  Tipo="STRING"> observacion </param>
              <param nom="EV_des_direc1"       Tipo="STRING"> descripcion 1 </param>
              <param nom="EV_des_direc2"       Tipo="STRING"> descripcion 2 </param>
              <param nom="EV_cod_pueblo"       Tipo="STRING"> codigo pueblo </param>
              <param nom="EV_cod_estado"       Tipo="STRING"> codigo estado </param>
              <param nom="EV_zip"        Tipo="STRING"> zip </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'UPDATE ge_direcciones a ' || ' SET a.cod_provincia = ' || ev_cod_provincia || ' a.cod_region    = ' || ev_cod_region || ' a.cod_ciudad    = ' || ev_cod_ciudad || ' a.cod_comuna    = ' || ev_cod_comuna || ' a.nom_calle     = ' || ev_nom_calle
         || ' a.num_calle     = ' || ev_num_calle || ' a.num_piso      = ' || ev_num_piso || ' a.num_casilla   = ' || ev_num_casilla || ' a.obs_direccion = ' || ev_obs_direccion || ' a.des_direc1    = ' || ev_des_direc1 || ' a.des_direc2    = '
         || ev_des_direc2 || ' a.cod_pueblo    = ' || ev_cod_pueblo || ' a.cod_estado    = ' || ev_cod_estado || ' a.zip           = ' || ev_zip || ' WHERE a.cod_direccion = ' || en_cod_direccion;

      UPDATE ge_direcciones a
         SET a.cod_provincia = ev_cod_provincia,
             a.cod_region = ev_cod_region,
             a.cod_ciudad = ev_cod_ciudad,
             a.cod_comuna = ev_cod_comuna,
             a.nom_calle = ev_nom_calle,
             a.num_calle = ev_num_calle,
             a.num_piso = ev_num_piso,
             a.num_casilla = ev_num_casilla,
             a.obs_direccion = ev_obs_direccion,
             a.des_direc1 = ev_des_direc1,
             a.des_direc2 = ev_des_direc2,
             a.cod_pueblo = ev_cod_pueblo,
             a.cod_estado = ev_cod_estado,
             a.zip = ev_zip
       WHERE a.cod_direccion = en_cod_direccion;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10929;
         sv_menretorno:='Error al actualizar direccion.';

         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_updDireccion_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_updDireccion_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_upddireccion_pr;

   PROCEDURE ve_deldireccion_pr (
      en_cod_direccion   IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_delDireccion_PR"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Elimina direccion segun codigo
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'DELETE ge_direcciones ' || ' WHERE cod_direccion = ' || en_cod_direccion;

      DELETE      ge_direcciones
            WHERE cod_direccion = en_cod_direccion;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10930;
         sv_menretorno:='Error al intentar elimina direccion.';


         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_delDireccion_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_delDireccion_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_deldireccion_pr;

   PROCEDURE ve_inserta_direccion_pr (
      en_cod_direccion   IN              NUMBER,
      ev_cod_provincia   IN              VARCHAR2,
      ev_cod_region      IN              VARCHAR2,
      ev_cod_ciudad      IN              VARCHAR2,
      ev_cod_comuna      IN              VARCHAR2,
      ev_nom_calle       IN              VARCHAR2,
      ev_num_calle       IN              VARCHAR2,
      ev_num_piso        IN              VARCHAR2,
      ev_num_casilla     IN              VARCHAR2,
      ev_obs_direccion   IN              VARCHAR2,
      ev_des_direc1      IN              VARCHAR2,
      ev_des_direc2      IN              VARCHAR2,
      ev_cod_pueblo      IN              VARCHAR2,
      ev_cod_estado      IN              VARCHAR2,
      ev_zip             IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_inserta_direccion_PR"
         Lenguaje="PL/SQL"
         Fecha="23-06-2007"
         Versión="1.0.0"
         Diseñador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              inserta direccion
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
              <param nom="EV_cod_provincia"  Tipo="STRING"> codigo provincia </param>
              <param nom="EV_cod_region"       Tipo="STRING"> codigo region </param>
              <param nom="EV_cod_ciudad"       Tipo="STRING"> codigo ciudad </param>
              <param nom="EV_cod_comuna"       Tipo="STRING"> codigo cimuna </param>
              <param nom="EV_nom_calle"     Tipo="STRING"> nombre calle </param>
              <param nom="EV_num_calle"     Tipo="STRING"> numero calle </param>
              <param nom="EV_num_piso"      Tipo="STRING"> numero piso </param>
              <param nom="EV_num_casilla"    Tipo="STRING"> numero casilla </param>
              <param nom="EV_obs_direccion"  Tipo="STRING"> observacion </param>
              <param nom="EV_des_direc1"       Tipo="STRING"> descripcion 1 </param>
              <param nom="EV_des_direc2"       Tipo="STRING"> descripcion 2 </param>
              <param nom="EV_cod_pueblo"       Tipo="STRING"> codigo pueblo </param>
              <param nom="EV_cod_estado"       Tipo="STRING"> codigo estado </param>
              <param nom="EV_zip"        Tipo="STRING"> zip </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'INSERT INTO ge_direcciones ( ' || ' cod_direccion, cod_provincia, cod_region, ' || ' cod_ciudad, cod_comuna, nom_calle, ' || ' num_calle, num_piso, num_casilla, ' || ' obs_direccion, des_direc1, des_direc2, ' || ' cod_pueblo, cod_estado, zip) '
         || ' VALUES ( ' || en_cod_direccion || ', ''' || ev_cod_provincia || ''',''' || ev_cod_region || ''',''' || ev_cod_ciudad || ''',''' || ev_cod_comuna || ''',''' || ev_nom_calle || ''',''' || ev_num_calle || ''',''' || ev_num_piso || ''','''
         || ev_num_casilla || ''',''' || ev_obs_direccion || ''',''' || ev_des_direc1 || ''',''' || ev_des_direc2 || ''',''' || ev_cod_pueblo || ''',''' || ev_cod_estado || ''',''' || ev_zip || ''',)';

      INSERT INTO ge_direcciones
                  (cod_direccion, cod_provincia, cod_region, cod_ciudad, cod_comuna, nom_calle, num_calle, num_piso, num_casilla, obs_direccion, des_direc1, des_direc2, cod_pueblo, cod_estado, zip)
      VALUES      (en_cod_direccion, ev_cod_provincia, ev_cod_region, ev_cod_ciudad, ev_cod_comuna, ev_nom_calle, ev_num_calle, ev_num_piso, ev_num_casilla, ev_obs_direccion, ev_des_direc1, ev_des_direc2, ev_cod_pueblo, ev_cod_estado, ev_zip);
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10931;
         sv_menretorno:='Error al intentar insertar dirección.';

         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_inserta_direccion_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_inserta_direccion_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_inserta_direccion_pr;

   PROCEDURE ve_insdireccionusuario_pr (
      en_coddireccion   IN              NUMBER,
      ev_codusuario     IN              VARCHAR2,
      ev_tipdireccion   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insDireccionUsuario_PR"
         Lenguaje="PL/SQL"
         Fecha="11-09-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              inserta direccion usuario
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codDireccion"    Tipo="STRING"> codigo direccion </param>
              <param nom="EV_codUsuario"      Tipo="STRING"> codigo usuario </param>
            <param nom="EV_tipDireccion"    Tipo="STRING"> tipoDireccion </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'INSERT INTO ga_direcusuar ( ' || ' cod_direccion, cod_usuario, cod_tipdireccion) ' || ' VALUES ( ' || en_coddireccion || ', ''' || ev_codusuario || ''',''' || ev_tipdireccion || ''')';

      INSERT INTO ga_direcusuar
                  (cod_direccion, cod_usuario, cod_tipdireccion)
      VALUES      (en_coddireccion, ev_codusuario, ev_tipdireccion);
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10932;
         sv_menretorno:='Error al intentar insertar dirección de usuario.';


         lv_deserror := 'OTHERS:ve_servicios_direc_quiosco_pg.VE_insDireccionUsuario_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_servicios_direc_quiosco_pg.VE_insDireccionUsuario_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_insdireccionusuario_pr;
END ve_servicios_direc_quiosco_pg; 
/

SHOW ERRORS
