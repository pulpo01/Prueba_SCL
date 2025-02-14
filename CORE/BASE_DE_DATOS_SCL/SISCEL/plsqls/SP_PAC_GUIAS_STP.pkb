CREATE OR REPLACE PACKAGE BODY SP_PAC_GUIAS_STP IS
  --
  PROCEDURE sp_p_genera_guias(
  v_peticion IN SP_PETIGUIAS.num_peticion%TYPE ,
  v_detalle IN AL_CAB_GUIAS.ind_detalle%TYPE )
  IS
      --
         v_cabguia     AL_CAB_GUIAS%ROWTYPE;
         v_linguia     AL_LIN_GUIAS%ROWTYPE;
         v_linguias    AL_DATOS_GENERALES.num_linguias%TYPE;
         v_inter       AL_INTERGUIAS%ROWTYPE;
         v_contador    NUMBER(2) := 0;
         v_petidor     SP_PETIGUIAS.tip_petidor%TYPE;
         v_numpeti     SP_PETIGUIAS.num_petidor%TYPE;
         v_ind_equiacc  AL_ARTICULOS.ind_equiacc%TYPE;
      BEGIN
         v_inter.num_peticion   := v_peticion;
         v_inter.cod_retorno    := 0;
         v_cabguia.num_peticion := v_peticion;
         v_cabguia.ind_detalle  := v_detalle;
         sp_p_select_peticion (v_peticion,
                            v_petidor,
                            v_numpeti,
                            v_inter.cod_retorno,
                            v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
            RAISE EXCEPTION_ERROR;
         END IF;
         IF v_petidor = 1 THEN
         -- ENVIO MASIVO DE O.R. A TALLER
        sp_p_trata_envios(v_peticion,
                     v_detalle,
             v_contador,
                    v_inter.cod_retorno,
                    v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
         ELSIF v_petidor = 2 THEN
         -- ENTREGA DE REEMPLAZO PARA UNA O.R.
       -- cuyo num_orden tengo en v_numpeti
            sp_p_carga_cabecera (v_petidor,
                              v_numpeti,
                              v_cabguia,
                              v_inter.cod_retorno,
                              v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
            sp_p_select_numguia(v_cabguia.num_guia,
                             v_cabguia.fec_guia,
                             v_contador,
                             v_inter.cod_retorno,
                             v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
            sp_p_genera_cabecera (v_cabguia,
                               v_inter.cod_retorno,
                               v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
       -- tras primer insert al_cab_guias
       -- modifico el petidor para que num_guia = la creada
       sp_p_pone_numguia (v_numpeti,
           v_petidor,
                v_cabguia.num_guia,
           v_inter.cod_retorno,
                              v_inter.des_cadena);
       IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
       --
       sp_p_obtiene_filas (v_linguias,
                             v_inter.cod_retorno,
                             v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
            v_linguia.num_guia := v_cabguia.num_guia;
            v_linguia.lin_guia := 0;
        sp_p_carga_linea_or (v_numpeti,
                              v_petidor,
                              v_linguia,
                              v_cabguia,
                              v_linguias,
                              v_contador,
          v_ind_equiacc,
                    v_inter.cod_retorno,
                              v_inter.des_cadena);
        IF v_inter.cod_retorno <> 0 THEN
                 RAISE EXCEPTION_ERROR;
             END IF;
        IF v_ind_equiacc = 'E' THEN
        -- EQUIPO
        -- puede tener accesorios en sp_accesorios_reemplazo
         sp_p_carga_lineas (v_numpeti,
                          v_petidor,
                               v_linguia,
                               v_cabguia,
                               v_linguias,
                               v_contador,
                               v_inter.cod_retorno,
                               v_inter.des_cadena);
          -- else
        -- ACCESORIO de reemplazo, no tengo lineas a tratar
        END IF;
         ELSE --v_petidor = 3
         -- ENTREGA EQUIPO / ACCESORIOS AL CLIENTE PARA UNA O.R. QUE SE FINALIZA
       -- y cuyo num_orden tengo en v_numpeti
            sp_p_carga_cabecera (v_petidor,
                              v_numpeti,
                              v_cabguia,
                              v_inter.cod_retorno,
                              v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
            sp_p_select_numguia(v_cabguia.num_guia,
                             v_cabguia.fec_guia,
                             v_contador,
                             v_inter.cod_retorno,
                             v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
            sp_p_genera_cabecera (v_cabguia,
                               v_inter.cod_retorno,
                               v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
       -- tras primer insert al_cab_guias
       -- aqui NO modifico el petidor para que num_guia = la creada
       -- porque no se guarda
       --
       sp_p_obtiene_filas (v_linguias,
                             v_inter.cod_retorno,
                             v_inter.des_cadena);
            IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
            END IF;
            v_linguia.num_guia := v_cabguia.num_guia;
            v_linguia.lin_guia := 0;
        sp_p_carga_linea_or (v_numpeti,
                              v_petidor,
                              v_linguia,
                              v_cabguia,
                              v_linguias,
                              v_contador,
           v_ind_equiacc,
                     v_inter.cod_retorno,
                               v_inter.des_cadena);
        IF v_inter.cod_retorno <> 0 THEN
                 RAISE EXCEPTION_ERROR;
             END IF;
        IF v_ind_equiacc = 'E' THEN
        -- EQUIPO
        -- puede tener accesorios en sp_accesorios_orden
         sp_p_carga_lineas (v_numpeti,
                         v_petidor,
                                v_linguia,
                                v_cabguia,
                                v_linguias,
                                v_contador,
                                v_inter.cod_retorno,
                                v_inter.des_cadena);
           -- else
        -- ACCESORIO de orden, no tengo lineas a tratar
        END IF;
       END IF;
         -- de si es tip_petidor 1 o 2 o 3
         sp_p_borra_peticion (v_peticion,
                           v_inter.cod_retorno,
                           v_inter.des_cadena);
         dbms_output.put_line('contador final '|| TO_CHAR(v_contador));
         IF v_inter.cod_retorno = 0 THEN
            v_inter.des_cadena := '/' || TO_CHAR(v_contador) || '/';
         END IF;
         sp_p_insert_interguias(v_inter);
      EXCEPTION
         WHEN EXCEPTION_ERROR THEN
              sp_p_insert_interguias(v_inter);
      END sp_p_genera_guias;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_filas(
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
          SELECT num_linguias INTO v_linguias
                 FROM AL_DATOS_GENERALES;
      EXCEPTION
          WHEN OTHERS THEN
               v_error := 1;
               v_mensa := '/Error Lectura Numero Lineas por Guia/';
      END sp_p_obtiene_filas;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_cabecera(
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      --
        v_direccion      GE_DIRECCIONES.cod_direccion%TYPE;
        v_region         GE_DIRECCIONES.cod_region%TYPE;
        v_provincia      GE_DIRECCIONES.cod_provincia%TYPE;
        v_ciudad         GE_DIRECCIONES.cod_ciudad%TYPE;
        v_bodega_ori     AL_BODEGAS.cod_bodega%TYPE;
        v_abonado        SP_ORDENES_REPARACION.num_abonado%TYPE;
        v_producto       SP_ORDENES_REPARACION.cod_producto%TYPE;
        v_responsable    SP_TALLERES.nom_contacto%TYPE;
        v_taller         SP_ORDENES_REPARACION.cod_taller%TYPE;
      BEGIN
         v_cabguia.cod_estado      := 'NU';
         IF v_petidor = 1 THEN
         -- ENVIO A TALLER MASIVO DE O.R.
        v_cabguia.num_traspaso := NULL;
        -- no v_numpeti pues son varias o.r. (numpetidores)
        sp_p_select_envio(v_numpeti,
                           v_taller,
                           v_bodega_ori,
                           v_error,
                           v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
           sp_p_select_des_bodega (v_bodega_ori,
                                v_cabguia.des_bodega_ori,
                                v_error,
                                v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
           sp_p_select_taller(v_taller,
                           v_cabguia,
                        v_error,
                         v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
       ELSIF v_petidor = 2 THEN
       -- ENTREGA DE REEMPLAZO A UN CLIENTE PARA UNA O.R.
        v_cabguia.num_traspaso := v_numpeti;
        sp_p_select_reemplazo (v_numpeti,
                                v_abonado,
              v_producto,
                                v_bodega_ori,
                                v_error,
                                v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
           sp_p_select_des_bodega (v_bodega_ori,
                                v_cabguia.des_bodega_ori,
                                v_error,
                                v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
           sp_p_select_cliente (v_abonado,
                         v_producto,
                             v_cabguia,
                          v_error,
                           v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
        ELSE --v_petidor = 3
        -- ENTREGA DEL EQUIPO AL CLIENTE PARA UNA O.R.
        v_cabguia.num_traspaso := v_numpeti; -- si puedo ponerlo, es solo 1
        sp_p_select_entrega (v_numpeti,
                                v_abonado,
              v_producto,
                                v_bodega_ori,
                                v_error,
                                v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
           sp_p_select_des_bodega (v_bodega_ori,
                                v_cabguia.des_bodega_ori,
                                v_error,
                                v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
           sp_p_select_cliente (v_abonado,
                      v_producto,
                                v_cabguia,
                         v_error,
                             v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
        END IF;
      EXCEPTION
        WHEN EXCEPTION_ERROR THEN
             NULL;
      END sp_p_carga_cabecera;
  --
  -- Retrofitted
  PROCEDURE sp_p_genera_cabecera(
  v_cabguia IN AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
                 dbms_output.put_line('aqui');
         INSERT INTO AL_CAB_GUIAS (num_guia,
                                   num_peticion,
                                   fec_guia,
                                   des_bodega_ori,
                                   nom_destinatario,
                                   cod_estado,
                                   ind_detalle,
                                   num_ident,
                                   des_direccion,
                                   des_ciudad,
                                   num_telefono,
                                   num_fax,
                                   des_actividad,
                                   des_bodega_des,
                                   cod_cliente,
                                   num_folio,
                                   des_literal,
                                   num_venta,
                                   num_devolucion,
                                   num_traspaso)
                           VALUES (v_cabguia.num_guia,
                                   v_cabguia.num_peticion,
                                   v_cabguia.fec_guia,
                                   v_cabguia.des_bodega_ori,
                                   v_cabguia.nom_destinatario,
                                   v_cabguia.cod_estado,
                                   v_cabguia.ind_detalle,
                                   v_cabguia.num_ident,
                                   v_cabguia.des_direccion,
                                   v_cabguia.des_ciudad,
                                   v_cabguia.num_telefono,
                                   v_cabguia.num_fax,
                                   v_cabguia.des_actividad,
                                   v_cabguia.des_bodega_des,
                                   v_cabguia.cod_cliente,
                                   v_cabguia.num_folio,
                                   v_cabguia.des_literal,
                                   v_cabguia.num_venta,
                                   v_cabguia.num_devolucion,
                                   v_cabguia.num_traspaso);
      EXCEPTION
         WHEN OTHERS THEN
                         dbms_output.put_line(TO_CHAR(SQLCODE) || ' ' || SQLERRM);
              v_error := 1;
              v_mensa := TO_CHAR(SQLCODE) || ' ' || SQLERRM || '/Error al Generar Cabecera Guia/';
      END sp_p_genera_cabecera;
  --
  -- Retrofitted
  PROCEDURE sp_p_genera_linea(
  v_linguia IN AL_LIN_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         INSERT INTO AL_LIN_GUIAS (num_guia,
                                   lin_guia,
                                   cod_articulo,
                                   des_articulo,
                                   can_articulo,
                                   num_serie,
          num_telefono,
                                   cod_moneda,
                                   val_articulo,
                                   num_cargo)
                           VALUES (v_linguia.num_guia,
                                   v_linguia.lin_guia,
                                   v_linguia.cod_articulo,
                                   v_linguia.des_articulo,
                                   v_linguia.can_articulo,
                                   v_linguia.num_serie,
          v_linguia.num_telefono,
                                   v_linguia.cod_moneda,
                                   v_linguia.val_articulo,
                                   v_linguia.num_cargo);
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error al Generar Lineas Guias/';
      END sp_p_genera_linea;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_articulo(
  v_articulo IN AL_ARTICULOS.cod_articulo%TYPE ,
  v_desc IN OUT AL_ARTICULOS.des_articulo%TYPE ,
  v_seriado IN OUT AL_ARTICULOS.ind_seriado%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT des_articulo,ind_seriado
           INTO v_desc,v_seriado
           FROM AL_ARTICULOS
          WHERE cod_articulo = v_articulo;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Lectura Articulo/';
      END sp_p_select_articulo;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_des_bodega(
  v_bodega IN AL_BODEGAS.cod_bodega%TYPE ,
  v_descr IN OUT AL_BODEGAS.des_bodega%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT des_bodega
           INTO v_descr
           FROM AL_BODEGAS
          WHERE cod_bodega = v_bodega;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Descripcion Bodega/';
      END sp_p_select_des_bodega;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_numguia(
  v_guia IN OUT AL_CAB_GUIAS.num_guia%TYPE ,
  v_fecha IN OUT AL_CAB_GUIAS.fec_guia%TYPE ,
  v_conta IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
        SELECT al_seq_guias.NEXTVAL,SYSDATE
          INTO v_guia,v_fecha
          FROM AL_DATOS_GENERALES;
          v_conta := v_conta + 1;
         dbms_output.put_line('v_conta sumado 1 queda '||TO_CHAR(v_conta));
      EXCEPTION
        WHEN OTHERS THEN
             v_error := 1;
             v_mensa := '/Error Obtencion No.Guia/';
      END sp_p_select_numguia;
  --
  -- Retrofitted
  PROCEDURE sp_p_insert_interguias(
  v_inter IN AL_INTERGUIAS%ROWTYPE )
  IS
      BEGIN
          INSERT INTO AL_INTERGUIAS (num_peticion,
                                     cod_retorno,
                                     des_cadena)
                             VALUES (v_inter.num_peticion,
                                     v_inter.cod_retorno,
                                     v_inter.des_cadena);
      EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR (-20177,'Error Insert en INTERGUIAS');
      END sp_p_insert_interguias;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_peticion(
  v_peticion IN SP_PETIGUIAS.num_peticion%TYPE ,
  v_petidor IN OUT SP_PETIGUIAS.tip_petidor%TYPE ,
  v_numpeti IN OUT SP_PETIGUIAS.num_petidor%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT tip_petidor,num_petidor
           INTO v_petidor,v_numpeti
           FROM SP_PETIGUIAS
          WHERE num_peticion = v_peticion
          AND ROWNUM < 2; -- porque si tip_petidor = 1 habra mas de un registro
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Datos Peticion de Guia/';
      END sp_p_select_peticion;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_reemplazo(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_abonado IN OUT SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN OUT SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_bodega_ori IN OUT SP_ORDENES_REPARACION.cod_bodega_reem%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT num_abonado, cod_producto, cod_bodega_reem
           INTO v_abonado, v_producto, v_bodega_ori
           FROM SP_ORDENES_REPARACION
          WHERE num_orden = v_numpeti ;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Datos Reemplazo/';
      END sp_p_select_reemplazo;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_envio(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_taller IN OUT SP_ORDENES_REPARACION.cod_taller%TYPE ,
  v_bodega_ori IN OUT SP_ORDENES_REPARACION.cod_bodega%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT cod_taller, cod_bodega
           INTO v_taller, v_bodega_ori
           FROM SP_ORDENES_REPARACION
          WHERE num_orden = v_numpeti ;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Datos Envio/';
      END sp_p_select_envio;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_linea_or(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_contador IN OUT NUMBER ,
  v_ind_equiacc IN OUT AL_ARTICULOS.ind_equiacc%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
         v_ind_seriado AL_ARTICULOS.ind_seriado%TYPE;
         v_seriado      AL_ARTICULOS.ind_seriado%TYPE;
         v_serguia      AL_SER_GUIAS%ROWTYPE;
      BEGIN
         IF v_petidor = 1 THEN
       -- ENVIO A TALLER
            -- recoger datos de o.r. en curso para linea y serie guias
        -- cod_articulo, des_articulo, can_articulo, num_serie
        SELECT a.cod_articulo, b.des_articulo,
        a.num_serie, a.num_telefono, b.ind_seriado, b.ind_equiacc
         INTO v_linguia.cod_articulo, v_linguia.des_articulo,
         v_linguia.num_serie, v_linguia.num_telefono, v_ind_seriado
  , v_ind_equiacc
         FROM SP_ORDENES_REPARACION a, AL_ARTICULOS b
         WHERE a.num_orden  = v_numpeti
         AND b.cod_articulo = a.cod_articulo;
       ELSIF v_petidor = 2 THEN
       -- ENTREGA REEMPLAZO
        -- recoger datos de o.r. en curso para linea y serie guias
        -- cod_articulo, des_articulo, can_articulo, num_serie
        -- del equipo reemplazo
        SELECT a.cod_articulo_reem, b.des_articulo,
        a.num_serie_reem, a.num_telefono, b.ind_seriado, b.ind_equiacc
         INTO v_linguia.cod_articulo, v_linguia.des_articulo,
         v_linguia.num_serie,v_linguia.num_telefono, v_ind_seriado
  , v_ind_equiacc
         FROM SP_ORDENES_REPARACION a, AL_ARTICULOS b
         WHERE a.num_orden  = v_numpeti
         AND b.cod_articulo = a.cod_articulo_reem;
       ELSE -- v_petidor = 3
       -- ENTREGA EQUIPO CLIENTE
        -- recoger datos de o.r. en curso para linea y serie guias
        -- cod_articulo, des_articulo, can_articulo, num_serie
        SELECT a.cod_articulo, b.des_articulo,
        a.num_serie, a.num_telefono, b.ind_seriado, b.ind_equiacc
         INTO v_linguia.cod_articulo, v_linguia.des_articulo,
         v_linguia.num_serie, v_linguia.num_telefono, v_ind_seriado
  , v_ind_equiacc
         FROM SP_ORDENES_REPARACION a, AL_ARTICULOS b
         WHERE a.num_orden  = v_numpeti
         AND b.cod_articulo = a.cod_articulo;
       END IF;
       v_linguia.can_articulo := 1; -- por ser de la o.r.
       IF v_ind_seriado = 1 THEN
       -- SERIADO
           IF v_cabguia.ind_detalle = 0 THEN
        -- NO DETALLE
                -- no llamo a sp_p_carga_seriados(...) por ser solo uno
                ----- insert de nueva linea
         IF v_linguia.lin_guia < v_linguias THEN
                    v_linguia.lin_guia := v_linguia.lin_guia + 1;
                 ELSE
                    v_linguia.lin_guia := 1;
                    sp_p_select_numguia(v_cabguia.num_guia,
                                    v_cabguia.fec_guia,
                                    v_contador,
                                    v_error,
                                    v_mensa);
      dbms_output.put_line('lin o.r. nodetalle env v_contador '
       || TO_CHAR(v_contador));
                    IF v_error <> 0 THEN
                        RAISE EXCEPTION_ERROR;
                    END IF;
                    sp_p_genera_cabecera (v_cabguia,
                                     v_error,
                                     v_mensa);
                    IF v_error <> 0 THEN
                        RAISE EXCEPTION_ERROR;
                    END IF;
                    v_linguia.num_guia := v_cabguia.num_guia;
                 END IF;
         IF v_error <> 0 THEN
                    RAISE EXCEPTION_ERROR;
                 END IF;
         v_linguia.val_articulo := NULL;
                v_linguia.cod_moneda   := NULL;
                v_linguia.num_cargo    := NULL;
         -- ya tengo de antes v_linguia.num_serie
         sp_p_genera_linea(v_linguia,
                              v_error,
                              v_mensa);
                 IF v_error <> 0 THEN
                    RAISE EXCEPTION_ERROR;
                 END IF;
                 ----------------------------
        ELSE
        -- SI DETALLE
         -- ya tengo de antes v_linguia.num_serie
         ----- insert de nueva linea
         IF v_linguia.lin_guia < v_linguias THEN
                    v_linguia.lin_guia := v_linguia.lin_guia + 1;
                 ELSE
                    v_linguia.lin_guia := 1;
                    sp_p_select_numguia(v_cabguia.num_guia,
                                   v_cabguia.fec_guia,
                                   v_contador,
                                   v_error,
                                   v_mensa);
      dbms_output.put_line('lin o.r. sidetalle v_contador '
                            || TO_CHAR(v_contador));
          IF v_error <> 0 THEN
                        RAISE EXCEPTION_ERROR;
                    END IF;
                    sp_p_genera_cabecera (v_cabguia,
                                      v_error,
                                      v_mensa);
                    IF v_error <> 0 THEN
                        RAISE EXCEPTION_ERROR;
                    END IF;
                    v_linguia.num_guia := v_cabguia.num_guia;
                 END IF;
                 IF v_error <> 0 THEN
                    RAISE EXCEPTION_ERROR;
                 END IF;
                 v_linguia.val_articulo := NULL;
                 v_linguia.cod_moneda   := NULL;
                 v_linguia.num_cargo    := NULL;
            v_serguia.num_serie    := v_linguia.num_serie;
       v_serguia.num_telefono := v_linguia.num_telefono;
     -- para no perderlo
                 v_linguia.num_serie    := NULL; -- por ser con detalle
                 v_linguia.num_telefono := NULL; -- por ser con detalle
                 sp_p_genera_linea(v_linguia,
                    v_error,
                                v_mensa);
         IF v_error <> 0 THEN
                    RAISE EXCEPTION_ERROR;
                 END IF;
                 ----------------------------
         -- no llamo a sp_p_carga_serguia porque solo es una serie
                 v_serguia.num_guia  := v_linguia.num_guia;
                 v_serguia.lin_guia  := v_linguia.lin_guia;
         -- de antes tengo v_serguia.num_serie
                 v_serguia.num_cargo := NULL;
                 sp_p_genera_serguia(v_serguia,
                                 v_error,
                                 v_mensa);
                 IF v_error <> 0 THEN
                    RAISE EXCEPTION_ERROR;
                 END IF;
             END IF;
       ELSE
       -- NO SERIADO
        ----- insert de nueva linea
           IF v_linguia.lin_guia < v_linguias THEN
         v_linguia.lin_guia := v_linguia.lin_guia + 1;
             ELSE
              v_linguia.lin_guia := 1;
                 sp_p_select_numguia(v_cabguia.num_guia,
                                v_cabguia.fec_guia,
                                v_contador,
                                v_error,
                                      v_mensa);
      dbms_output.put_line('lin o.r. no seriado v_contador '
        || TO_CHAR(v_contador));
                 IF v_error <> 0 THEN
                  RAISE EXCEPTION_ERROR;
                 END IF;
                 sp_p_genera_cabecera (v_cabguia,
                             v_error,
                                    v_mensa);
                 IF v_error <> 0 THEN
               RAISE EXCEPTION_ERROR;
                 END IF;
                 v_linguia.num_guia := v_cabguia.num_guia;
             END IF;
             IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
             END IF;
        v_linguia.val_articulo := NULL;
             v_linguia.cod_moneda   := NULL;
             v_linguia.num_cargo    := NULL;
        v_linguia.num_serie    := NULL;
   v_linguia.num_telefono := NULL;
        sp_p_genera_linea(v_linguia,
                   v_error,
                           v_mensa);
        IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
             END IF;
        ----------------------------
       END IF;
      EXCEPTION
         WHEN EXCEPTION_ERROR THEN
              NULL;
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Lineas/';
      END sp_p_carga_linea_or;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_lineas(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_contador IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      --
         v_sentencia VARCHAR2(1024);
         v_cursor    INTEGER;
         v_filas     INTEGER;
         v_linea     NUMBER(3) := 0;
         v_seriado   AL_ARTICULOS.ind_seriado%TYPE;
      BEGIN
         v_cursor := dbms_sql.open_cursor;
         IF v_petidor = 1 THEN
       -- ENVIO A TALLER
            v_sentencia := 'SELECT COD_ARTICULO, CANTIDAD, NUM_LINEA '
                  || 'FROM SP_ACCESORIOS_ORDEN WHERE NUM_ORDEN = :var1';
         ELSIF v_petidor = 2 THEN
       -- ENTREGA REEMPLAZO
            v_sentencia := 'SELECT COD_ARTICULO_REEM, CANTIDAD, NUM_LINEA '
                  || 'FROM SP_ACCESORIOS_REEMPLAZO WHERE NUM_ORDEN = :var1 ';
         ELSE -- v_petidor = 3
       -- ENTREGA EQUIPO AL CLIENTE
            v_sentencia := 'SELECT COD_ARTICULO, CANTIDAD, NUM_LINEA '
                           || 'FROM SP_ACCESORIOS_ORDEN WHERE NUM_ORDEN = :var1
  ';
         END IF;
         dbms_sql.parse(v_cursor,v_sentencia,dbms_sql.v7);
         dbms_sql.define_column(v_cursor,1,v_linguia.cod_articulo);
         dbms_sql.define_column(v_cursor,2,v_linguia.can_articulo);
         dbms_sql.define_column(v_cursor,3,v_linea);
         dbms_sql.bind_variable(v_cursor,'var1',v_numpeti);
         v_filas := dbms_sql.EXECUTE(v_cursor);
         LOOP
            IF dbms_sql.fetch_rows(v_cursor) > 0 THEN
               dbms_sql.column_value(v_cursor,1,v_linguia.cod_articulo);
               dbms_sql.column_value(v_cursor,2,v_linguia.can_articulo);
               dbms_sql.column_value(v_cursor,3,v_linea);
               sp_p_select_articulo(v_linguia.cod_articulo,
                                 v_linguia.des_articulo,
                                 v_seriado,
                                 v_error,
                                 v_mensa);
               IF v_error <> 0 THEN
                  RAISE EXCEPTION_ERROR;
               END IF;
         IF v_seriado = 1 THEN
         -- ACCESORIO SERIADO
                  IF v_cabguia.ind_detalle = 0 THEN
          -- NO DETALLE
                     sp_p_carga_seriados(v_numpeti,
                                      v_linea,
                                      v_petidor,
                                      v_linguia,
                                      v_cabguia,
                                      v_linguias,
                                      v_contador,
                                      v_error,
                                      v_mensa);
                    IF v_error <> 0 THEN
                       RAISE EXCEPTION_ERROR;
                    END IF;
                  ELSE
        -- SI DETALLE
        ----- insert de nueva linea
         IF v_linguia.lin_guia < v_linguias THEN
                       v_linguia.lin_guia := v_linguia.lin_guia + 1;
                    ELSE
                        v_linguia.lin_guia := 1;
                        sp_p_select_numguia(v_cabguia.num_guia,
                                         v_cabguia.fec_guia,
                                         v_contador,
                                         v_error,
                                         v_mensa);
      dbms_output.put_line('linea sidetalle v_contador '
        || TO_CHAR(v_contador));
                        IF v_error <> 0 THEN
                             RAISE EXCEPTION_ERROR;
                        END IF;
                        sp_p_genera_cabecera (v_cabguia,
                                           v_error,
                                           v_mensa);
                        IF v_error <> 0 THEN
                             RAISE EXCEPTION_ERROR;
                       END IF;
                        v_linguia.num_guia := v_cabguia.num_guia;
                    END IF;
                    IF v_error <> 0 THEN
                       RAISE EXCEPTION_ERROR;
                    END IF;
                    v_linguia.val_articulo := NULL;
                    v_linguia.cod_moneda   := NULL;
                    v_linguia.num_serie    := NULL;
     v_linguia.num_telefono := NULL;
            v_linguia.num_cargo    := NULL;
                    sp_p_genera_linea(v_linguia,
                                    v_error,
                                    v_mensa);
                    IF v_error <> 0 THEN
                       RAISE EXCEPTION_ERROR;
                    END IF;
             ----------------------------
                    sp_p_carga_serguia (v_numpeti,
                                     v_linea,
                                     v_petidor,
                                     v_linguia,
                                     v_error,
                                     v_mensa);
                     IF v_error <> 0 THEN
                       RAISE EXCEPTION_ERROR;
                     END IF;
                  END IF;
                ELSE
         -- ACCESORIO NO SERIADO
                  v_linguia.val_articulo := NULL;
          -------- insert nueva linea
                  IF v_linguia.lin_guia < v_linguias THEN
                     v_linguia.lin_guia := v_linguia.lin_guia + 1;
                  ELSE
                     v_linguia.lin_guia := 1;
                     sp_p_select_numguia(v_cabguia.num_guia,
                                      v_cabguia.fec_guia,
                                      v_contador,
                                      v_error,
                                      v_mensa);
      dbms_output.put_line('lin acc. no ser v_contador '
      || TO_CHAR(v_contador));
                     IF v_error <> 0 THEN
                        RAISE EXCEPTION_ERROR;
                     END IF;
                     sp_p_genera_cabecera (v_cabguia,
                                        v_error,
                                        v_mensa);
                     IF v_error <> 0 THEN
                        RAISE EXCEPTION_ERROR;
                     END IF;
                     v_linguia.num_guia := v_cabguia.num_guia;
                  END IF;
                  IF v_error <> 0 THEN
                     RAISE EXCEPTION_ERROR;
                  END IF;
                  v_linguia.val_articulo := NULL;
                  v_linguia.cod_moneda   := NULL;
                  v_linguia.num_serie    := NULL;
        v_linguia.num_telefono := NULL;
            v_linguia.num_cargo    := NULL;
                  sp_p_genera_linea(v_linguia,
                                 v_error,
                                 v_mensa);
                  IF v_error <> 0 THEN
                     RAISE EXCEPTION_ERROR;
                  END IF;
               END IF;
            ELSE
               EXIT;
            END IF;
         END LOOP;
      EXCEPTION
         WHEN EXCEPTION_ERROR THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
         WHEN OTHERS THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
              v_error := 1;
              v_mensa := '/Error Obtencion Lineas/';
      END sp_p_carga_lineas;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_seriados(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_linea IN NUMBER ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_contador IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      -- carga los seriados de la linea que recibe
      -- para NO detalle
         v_sentencia VARCHAR2(1024);
         v_cursor    INTEGER;
         v_filas     INTEGER;
      BEGIN
         v_linguia.can_articulo := 1;
         v_cursor               := dbms_sql.open_cursor;
         IF v_petidor = 1 THEN
       -- ENVIO A TALLER
            v_sentencia := 'SELECT NUM_SERIE '
       || 'FROM SP_SERIES_ORDEN WHERE '
                           || 'NUM_ORDEN = :var1 AND '
                           || 'NUM_LINEA = :var2';
         ELSIF v_petidor = 2 THEN
       -- ENTREGA REEMPLAZO
            v_sentencia := 'SELECT NUM_SERIE FROM SP_SERIES_REEMPLAZO WHERE '
                           || 'NUM_ORDEN = :var1 AND '
                           || 'NUM_LINEA = :var2';
       ELSE -- v_petidor = 3
       -- ENTREGA EQUIPO AL CLIENTE
            v_sentencia := 'SELECT NUM_SERIE FROM SP_SERIES_ORDEN WHERE '
                           || 'NUM_ORDEN = :var1 AND '
                           || 'NUM_LINEA = :var2';
       END IF;
         dbms_sql.parse(v_cursor,v_sentencia,dbms_sql.v7);
         dbms_sql.define_column(v_cursor,1,v_linguia.num_serie,14);
         dbms_sql.bind_variable(v_cursor,'var1',v_numpeti);
         dbms_sql.bind_variable(v_cursor,'var2',v_linea);
         v_filas := dbms_sql.EXECUTE(v_cursor);
         LOOP
            IF dbms_sql.fetch_rows(v_cursor) > 0 THEN
               dbms_sql.column_value(v_cursor,1,v_linguia.num_serie);
         ----------- insert nueva linea
               IF v_linguia.lin_guia < v_linguias THEN
                  v_linguia.lin_guia := v_linguia.lin_guia + 1;
               ELSE
                  v_linguia.lin_guia := 1;
                  sp_p_select_numguia(v_cabguia.num_guia,
                                   v_cabguia.fec_guia,
                                   v_contador,
                                   v_error,
                                   v_mensa);
      dbms_output.put_line('cargaseridos, nodetalle, v_contador '
       || TO_CHAR(v_contador));
                  IF v_error <> 0 THEN
                     RAISE EXCEPTION_ERROR;
                  END IF;
                  sp_p_genera_cabecera (v_cabguia,
                                     v_error,
                                     v_mensa);
                  IF v_error <> 0 THEN
                     RAISE EXCEPTION_ERROR;
                  END IF;
                  v_linguia.num_guia := v_cabguia.num_guia;
               END IF;
               IF v_error <> 0 THEN
                  RAISE EXCEPTION_ERROR;
               END IF;
               v_linguia.val_articulo := NULL;
               v_linguia.cod_moneda   := NULL;
               -- aqui recuperado en el cursor v_linguia.num_serie
           v_linguia.num_cargo    := NULL;
               sp_p_genera_linea(v_linguia,
                              v_error,
                              v_mensa);
               IF v_error <> 0 THEN
                  RAISE EXCEPTION_ERROR;
               END IF;
         -------------------------------
            ELSE
               EXIT;
            END IF;
         END LOOP;
      EXCEPTION
         WHEN EXCEPTION_ERROR THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
         WHEN OTHERS THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
              v_error := 1;
              v_mensa := '/Error Obtencion Series/' || TO_CHAR(SQLCODE);
      END sp_p_carga_seriados;
  --
  -- Retrofitted
  PROCEDURE sp_p_borra_peticion(
  v_peticion IN SP_PETIGUIAS.num_peticion%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         DELETE SP_PETIGUIAS
                WHERE num_peticion = v_peticion;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Anulacion Peticion de Guia/';
      END sp_p_borra_peticion;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_taller(
  v_taller IN SP_ORDENES_REPARACION.cod_taller%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
       v_direccion GE_DIRECCIONES.cod_direccion%TYPE;
       v_region         GE_DIRECCIONES.cod_region%TYPE;
         v_provincia      GE_DIRECCIONES.cod_provincia%TYPE;
         v_ciudad         GE_DIRECCIONES.cod_ciudad%TYPE;
         --v_bodega_ori     al_bodegas.cod_bodega%type;
         --v_abonado        sp_ordenes_reparacion.num_abonado%type;
         --v_producto       sp_ordenes_reparacion.cod_producto%type;
         --v_responsable    sp_talleres.nom_contacto%type;
         --v_taller         sp_ordenes_reparacion.cod_taller%type;
      BEGIN
       sp_p_select_datos_taller(v_taller,
                       v_cabguia,
               v_direccion,
               v_error,
               v_mensa);
         IF v_error <> 0 THEN
           RAISE EXCEPTION_ERROR;
         END IF;
       sp_p_select_direccion (v_direccion,
                            v_cabguia.des_direccion,
                            v_region,
                            v_provincia,
                            v_ciudad,
                            v_error,
                            v_mensa);
        IF v_error <> 0 THEN
           RAISE EXCEPTION_ERROR;
        END IF;
        sp_p_select_ciudad (v_region,
                         v_provincia,
                         v_ciudad,
                         v_cabguia.des_ciudad,
                         v_error,
                         v_mensa);
       IF v_error <> 0 THEN
        RAISE EXCEPTION_ERROR;
       END IF;
      EXCEPTION
       WHEN EXCEPTION_ERROR THEN
             NULL;
      END sp_p_select_taller;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_datos_taller(
  v_taller IN SP_TALLERES.cod_taller%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_direccion IN OUT GE_DIRECCIONES.cod_direccion%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
       SELECT nom_contacto, cod_direccion, num_telef1, num_fax
        INTO v_cabguia.nom_destinatario, v_direccion,
        v_cabguia.num_telefono, v_cabguia.num_fax
        FROM SP_TALLERES
        WHERE cod_taller = v_taller;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Lectura Taller/';
      END sp_p_select_datos_taller;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_cliente(
  v_abonado IN SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
       v_tipident GE_CLIENTES.cod_tipident%TYPE;
         v_numident GE_CLIENTES.num_ident%TYPE;
         v_actividad GE_CLIENTES.cod_actividad%TYPE;
         v_tiprut         GE_CLIENTES.cod_tipident%TYPE;
         v_direccion      GE_DIRECCIONES.cod_direccion%TYPE;
         v_region         GE_DIRECCIONES.cod_region%TYPE;
         v_provincia      GE_DIRECCIONES.cod_provincia%TYPE;
         v_ciudad         GE_DIRECCIONES.cod_ciudad%TYPE;
      BEGIN
      -- relleno de cabguia: nom_destinatario = nom_cliente
      -- rut, des_direccion, des_ciudad, num_telefono,
      -- num_fax, des_actividad del cliente
       sp_p_obtiene_cliente_abonado (v_abonado,
                 v_producto,
                 v_cabguia.cod_cliente,
                 v_error,
                 v_mensa);
       IF v_error <> 0 THEN
        RAISE EXCEPTION_ERROR;
       END IF;
       sp_p_select_datos_cliente (v_cabguia.cod_cliente,
                           v_cabguia.nom_destinatario,
                              v_tipident,
                            v_numident,
                             v_actividad,
                              v_cabguia.num_telefono,
                           v_cabguia.num_fax,
                             v_error,
                             v_mensa);
        IF v_error <> 0 THEN
           RAISE EXCEPTION_ERROR;
        END IF;
        sp_p_obtiene_tiporut (v_tiprut,
                           v_error,
                           v_mensa);
        IF v_error <> 0 THEN
           RAISE EXCEPTION_ERROR;
        END IF;
        IF v_tipident = v_tiprut THEN
           v_cabguia.num_ident := v_numident;
        ELSE
           v_cabguia.num_ident := NULL;
        END IF;
        IF v_actividad IS NOT NULL THEN
           sp_p_select_giro (v_actividad,
                          v_cabguia.des_actividad,
                          v_error,
                          v_mensa);
           IF v_error <> 0 THEN
              RAISE EXCEPTION_ERROR;
           END IF;
        END IF;
        sp_p_obtiene_cliente_direccion  (v_cabguia.cod_cliente,
                          v_direccion,
                          v_error,
                           v_mensa);
       IF v_error <> 0 THEN
        RAISE EXCEPTION_ERROR;
       END IF;
        sp_p_select_direccion (v_direccion,
                            v_cabguia.des_direccion,
                            v_region,
                            v_provincia,
                            v_ciudad,
                            v_error,
                            v_mensa);
        IF v_error <> 0 THEN
           RAISE EXCEPTION_ERROR;
        END IF;
        sp_p_select_ciudad (v_region,
                         v_provincia,
                         v_ciudad,
                         v_cabguia.des_ciudad,
                         v_error,
                         v_mensa);
       IF v_error <> 0 THEN
        RAISE EXCEPTION_ERROR;
       END IF;
      EXCEPTION
        WHEN EXCEPTION_ERROR THEN
             NULL;
      END sp_p_select_cliente;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_datos_cliente(
  v_cliente IN GE_CLIENTES.cod_cliente%TYPE ,
  v_nombre IN OUT GE_CLIENTES.nom_cliente%TYPE ,
  v_tipident IN OUT GE_CLIENTES.cod_tipident%TYPE ,
  v_numident IN OUT GE_CLIENTES.num_ident%TYPE ,
  v_actividad IN OUT GE_CLIENTES.cod_actividad%TYPE ,
  v_telefono IN OUT GE_CLIENTES.tef_cliente1%TYPE ,
  v_fax IN OUT GE_CLIENTES.num_fax%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
      -- como al_cab_guias.nom_destinatario es varchar2(40),
      -- trunco a eso para evitar errores
           SELECT SUBSTR(nom_cliente ||' '|| nom_apeclien1
      ||' '|| nom_apeclien2, 1, 40),
           cod_tipident,num_ident,cod_actividad,
                tef_cliente1,num_fax
           INTO v_nombre,v_tipident,v_numident,v_actividad,
                v_telefono,v_fax
           FROM GE_CLIENTES
          WHERE cod_cliente = v_cliente;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Lectura Cliente/';
      END sp_p_select_datos_cliente;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_tiporut(
  v_tiprut IN OUT GA_DATOSGENER.cod_tipid_num_ident%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT cod_tipid_num_ident INTO v_tiprut
                FROM GA_DATOSGENER;
      EXCEPTION
        WHEN OTHERS THEN
             v_error := 1;
             v_mensa := '/Error Obtencion Tipo identificacion = RUT/';
      END sp_p_obtiene_tiporut;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_giro(
  v_actividad IN GE_ACTIVIDADES.cod_actividad%TYPE ,
  v_giro IN OUT GE_ACTIVIDADES.des_actividad%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
          SELECT des_actividad
            INTO v_giro
            FROM GE_ACTIVIDADES
           WHERE cod_actividad = v_actividad;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Giro/';
      END sp_p_select_giro;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_direccion(
  v_direccion IN GE_DIRECCIONES.cod_direccion%TYPE ,
  v_desdirec IN OUT AL_CAB_GUIAS.des_direccion%TYPE ,
  v_region IN OUT GE_DIRECCIONES.cod_region%TYPE ,
  v_provincia IN OUT GE_DIRECCIONES.cod_provincia%TYPE ,
  v_ciudad IN OUT GE_DIRECCIONES.cod_ciudad%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT nom_calle || ' ' || num_calle ||', '|| num_piso,
                cod_region,cod_provincia,cod_ciudad
           INTO v_desdirec,v_region,v_provincia,v_ciudad
           FROM GE_DIRECCIONES
          WHERE cod_direccion = v_direccion;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Lectura Direcciones/';
      END sp_p_select_direccion;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_ciudad(
  v_region IN GE_DIRECCIONES.cod_direccion%TYPE ,
  v_provincia IN GE_DIRECCIONES.cod_provincia%TYPE ,
  v_ciudad IN GE_DIRECCIONES.cod_ciudad%TYPE ,
  v_desciu IN OUT AL_CAB_GUIAS.des_ciudad%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
        SELECT des_ciudad
          INTO v_desciu
          FROM GE_CIUDADES
         WHERE cod_region = v_region
           AND cod_provincia = v_provincia
           AND cod_ciudad = v_ciudad;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Lectura Ciudades/';
      END sp_p_select_ciudad;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_cliente_direccion(
  v_cliente IN GA_DIRECCLI.cod_cliente%TYPE ,
  v_direccion IN OUT GA_DIRECCLI.cod_direccion%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
       SELECT cod_direccion INTO v_direccion
        FROM GA_DIRECCLI
        WHERE cod_cliente = v_cliente
        AND cod_tipdireccion = 2; -- direccion personal
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Direccion Cliente/';
      END sp_p_obtiene_cliente_direccion;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_cliente_abonado(
  v_abonado IN SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_cliente IN OUT GE_CLIENTES.cod_cliente%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
          v_enc NUMBER;
      BEGIN
           v_enc:=0;
      -- recupero el cod_cliente del abonado
       IF v_producto = 1 THEN
                IF v_enc = 0 THEN
                        BEGIN
                        SELECT cod_cliente INTO v_cliente
                                        FROM GA_ABOCEL
                                WHERE num_abonado = v_abonado;
                                v_enc :=1;
                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        NULL;
                                        -- nada, puede estar en mas partes
                        WHEN OTHERS THEN
                             v_error := 1;
                         v_mensa := '/Error Obtencion C-A ABOCEL/';
                             RAISE EXCEPTION_ERROR;
                        END;
                END IF;
                IF v_enc = 0 THEN
                        BEGIN
                        SELECT cod_cliente INTO v_cliente
                                        FROM GA_ABOAMIST
                                WHERE num_abonado = v_abonado;
                                v_enc:=1;
                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                        NULL;
                                        -- nada, puede estar en mas partes
                        WHEN OTHERS THEN
                             v_error := 1;
                         v_mensa := '/Error Obtencion C-A ABOAMIST/';
                             RAISE EXCEPTION_ERROR;
                        END;
                END IF;
                IF v_enc = 0 THEN
                        BEGIN
                        sp_p_obtiene_cliente_aborent (v_abonado,v_cliente,
                                                              v_error,v_mensa);
                        IF v_error <> 0 THEN
                                        RAISE EXCEPTION_ERROR;
                            END IF;
                                v_enc :=1;
                                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                NULL;
                                        -- nada, ahora vemos
                        WHEN OTHERS THEN
                             v_error := 1;
                         v_mensa := '/Error Obtencion C-A ABORENT/';
                             RAISE EXCEPTION_ERROR;
                        END;
                END IF;
                IF v_enc = 0 THEN
                RAISE EXCEPTION_ERROR;
        END IF;
           ELSIF v_producto = 2 THEN
        SELECT cod_cliente INTO v_cliente
         FROM GA_ABOBEEP
         WHERE num_abonado = v_abonado;
       ELSIF v_producto = 3 THEN
        SELECT cod_cliente INTO v_cliente
         FROM GA_ABOTRUNK
         WHERE num_abonado = v_abonado;
       ELSE
        SELECT cod_cliente INTO v_cliente
         FROM GA_ABOTREK
         WHERE num_abonado = v_abonado;
       END IF;
      EXCEPTION
       WHEN EXCEPTION_ERROR THEN
            v_error := 1;
            v_mensa := '/Error Obtencion Cliente Abonado/';
       WHEN OTHERS THEN
            v_error := 1;
              v_mensa := '/Error Obtencion Cliente Abonado/';
      END sp_p_obtiene_cliente_abonado;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_cliente_aborent(
  v_abonado IN SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_cliente IN OUT GE_CLIENTES.cod_cliente%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
       SELECT cod_cliente INTO v_cliente
        FROM GA_ABORENT
        WHERE num_abonado = v_abonado;
      EXCEPTION
       WHEN OTHERS THEN
         v_error := 1;
             v_mensa := '/Error Obtencion Cliente Abonado/';
      END sp_p_obtiene_cliente_aborent;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_serguia(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_linea IN NUMBER ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      -- carga los seriados de la linea que recibe
      -- para SI detalle
         v_sentencia VARCHAR2(1024);
         v_cursor    INTEGER;
         v_filas     INTEGER;
         v_serguia   AL_SER_GUIAS%ROWTYPE;
      BEGIN
         v_linguia.can_articulo := 1;
         v_cursor               := dbms_sql.open_cursor;
         IF v_petidor = 1 THEN
       -- ENVIO A TALLER
            v_sentencia := 'SELECT NUM_SERIE FROM SP_SERIES_ORDEN WHERE '
                           || 'NUM_ORDEN = :var1 AND '
                           || 'NUM_LINEA = :var2';
         ELSIF v_petidor = 2 THEN
       -- ENTREGA REEMPLAZO
            v_sentencia := 'SELECT NUM_SERIE FROM SP_SERIES_REEMPLAZO WHERE '
                           || 'NUM_ORDEN = :var1 AND '
                           || 'NUM_LINEA = :var2';
       ELSE --v_petidor = 3
       -- ENTREGA EQUIPO EL CLIENTE
            v_sentencia := 'SELECT NUM_SERIE FROM SP_SERIES_ORDEN WHERE '
                           || 'NUM_ORDEN = :var1 AND '
                           || 'NUM_LINEA = :var2';
       END IF;
         dbms_sql.parse(v_cursor,v_sentencia,dbms_sql.v7);
         dbms_sql.define_column(v_cursor,1,v_linguia.num_serie,14);
         dbms_sql.bind_variable(v_cursor,'var1',v_numpeti);
         dbms_sql.bind_variable(v_cursor,'var2',v_linea);
         v_filas := dbms_sql.EXECUTE(v_cursor);
         LOOP
            IF dbms_sql.fetch_rows(v_cursor) > 0 THEN
               dbms_sql.column_value(v_cursor,1,v_serguia.num_serie);
               v_serguia.num_guia  := v_linguia.num_guia;
               v_serguia.lin_guia  := v_linguia.lin_guia;
               v_serguia.num_cargo := NULL;
               sp_p_genera_serguia(v_serguia,
                                v_error,
                                v_mensa);
               IF v_error <> 0 THEN
                  RAISE EXCEPTION_ERROR;
               END IF;
               v_linguia.val_articulo := NULL;
            ELSE
               EXIT;
            END IF;
         END LOOP;
      EXCEPTION
         WHEN EXCEPTION_ERROR THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
         WHEN OTHERS THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
              v_error := 1;
              v_mensa := '/Error Obtencion Series/' || TO_CHAR(SQLCODE);
      END sp_p_carga_serguia;
  --
  -- Retrofitted
  PROCEDURE sp_p_genera_serguia(
  v_serguia IN AL_SER_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         INSERT INTO AL_SER_GUIAS (num_guia,
                                   lin_guia,
                                   num_serie,
          num_telefono,
                                   num_cargo)
                           VALUES (v_serguia.num_guia,
                                   v_serguia.lin_guia,
                                   v_serguia.num_serie,
          v_serguia.num_telefono,
                                   v_serguia.num_cargo);
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error al generar detalle anexo/';
      END sp_p_genera_serguia;
  --
  -- Retrofitted
  PROCEDURE sp_p_trata_envios(
  v_peticion IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_detalle IN AL_CAB_GUIAS.ind_detalle%TYPE ,
  v_contador IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      -- recibe los parametros iniciales v_peticion y v_detalle
      -- recorre todas las o.r. enviadas (num_petidor)
      -- para num_peticion de sp_petiguias = v_cabguia.num_peticion
         v_cabguia     AL_CAB_GUIAS%ROWTYPE;
         v_linguia     AL_LIN_GUIAS%ROWTYPE;
         v_linguias    AL_DATOS_GENERALES.num_linguias%TYPE;
         v_inter       AL_INTERGUIAS%ROWTYPE;
         v_petidor     SP_PETIGUIAS.tip_petidor%TYPE;
         v_numpeti     SP_PETIGUIAS.num_petidor%TYPE;
         v_ind_equiacc  AL_ARTICULOS.ind_equiacc%TYPE;
         v_sentencia VARCHAR2(1024);
         v_cursor    INTEGER;
         v_filas     INTEGER;
      BEGIN
         v_cabguia.num_peticion := v_peticion;
         v_cabguia.ind_detalle  := v_detalle;
         sp_p_select_peticion (v_peticion,
                            v_petidor,
                            v_numpeti,
                            v_inter.cod_retorno,
                            v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
            RAISE EXCEPTION_ERROR;
         END IF;
       -- v_numpeti tiene una o.r. enviada, de ella
       -- obtendre datos generales iguales para todas ellas
       -- cargo en v_cabgui los valores para las cabeceras
       sp_p_carga_cabecera (v_petidor,
                         v_numpeti,
                 -- aunque en este caso dentro no lo usa, sino null
                          v_cabguia,
                           v_inter.cod_retorno,
                           v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
          RAISE EXCEPTION_ERROR;
         END IF;
      dbms_output.put_line('trata env. antes de select numguia');
       sp_p_select_numguia(v_cabguia.num_guia,
                   v_cabguia.fec_guia,
                          v_contador,
                          v_inter.cod_retorno,
                          v_inter.des_cadena);
      dbms_output.put_line('cab 1 envios v_contador '|| TO_CHAR(v_contador));
         IF v_inter.cod_retorno <> 0 THEN
          RAISE EXCEPTION_ERROR;
         END IF;
       sp_p_genera_cabecera (v_cabguia,
                    v_inter.cod_retorno,
                            v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
          RAISE EXCEPTION_ERROR;
         END IF;
         sp_p_obtiene_filas (v_linguias,
                          v_inter.cod_retorno,
                          v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
          RAISE EXCEPTION_ERROR;
         END IF;
         v_linguia.num_guia := v_cabguia.num_guia;
         v_linguia.lin_guia := 0;
       -- ya tengo la primera cabecera, las demas son iguales
       -- me faltan todas las lineas y series de guias
         v_cursor    := dbms_sql.open_cursor;
         v_sentencia := 'SELECT NUM_PETIDOR FROM SP_PETIGUIAS WHERE '
                           || 'NUM_PETICION = :var1 ';
         dbms_sql.parse(v_cursor,v_sentencia,dbms_sql.v7);
         dbms_sql.define_column(v_cursor,1,v_numpeti);
         dbms_sql.bind_variable(v_cursor,'var1',v_cabguia.num_peticion);
         v_filas := dbms_sql.EXECUTE(v_cursor);
         LOOP
            IF dbms_sql.fetch_rows(v_cursor) > 0 THEN
               dbms_sql.column_value(v_cursor,1,v_numpeti);
               -- en v_petidor tengo el num_orden a tratar
         -- falta, tratamiento de esta o.r.
         -- cuyo num_orden tengo en v_numpeti
         -- para cada num_orden,
              sp_p_carga_linea_or (v_numpeti,
                                v_petidor,
                                     v_linguia,
                                v_cabguia,
                                v_linguias,
                                v_contador,
              v_ind_equiacc,
                                     v_inter.cod_retorno,
                                     v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
                  RAISE EXCEPTION_ERROR;
              END IF;
         -- solamente para EnvioTaller
         -- sea seriado con o sin detalle, o sea no seriado
         -- acabo de tratar los datos de la o.r. cabecera
         -- e insertado su linea para cabecera guia numero
         -- nuevo o el mismo que existia
         -- tengo que guardar num_guia_dev
         sp_p_pone_numguia (v_numpeti,
             v_petidor,
             v_cabguia.num_guia,
             v_inter.cod_retorno,
                          v_inter.des_cadena);
         IF v_inter.cod_retorno <> 0 THEN
               RAISE EXCEPTION_ERROR;
         END IF;
         IF v_ind_equiacc = 'E' THEN
         -- EQUIPO
         -- puede tener accesorios en sp_accesorios_orden
          sp_p_carga_lineas (v_numpeti,
                          v_petidor,
                             v_linguia,
                              v_cabguia,
                             v_linguias,
                             v_contador,
                             v_inter.cod_retorno,
                              v_inter.des_cadena);
            -- else
         -- ACCESORIO recibido del cliente, no tengo lineas a tratar
         END IF;
            ELSE
               EXIT;
            END IF;
         END LOOP;
      EXCEPTION
         WHEN EXCEPTION_ERROR THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
         WHEN OTHERS THEN
              IF dbms_sql.is_open(v_cursor) THEN
                 dbms_sql.close_cursor (v_cursor);
              END IF;
              v_error := 1;
              v_mensa := '/Error Obtencion Ordenes Enviadas/'
       || TO_CHAR(SQLCODE);
      END sp_p_trata_envios;
  --
  -- Retrofitted
  PROCEDURE sp_p_pone_numguia(
  v_numpeti IN SP_ORDENES_REPARACION.num_orden%TYPE ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_numguia IN SP_ORDENES_REPARACION.num_guia_env%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
       dbms_output.put_line ('tip_petidor ' || v_petidor);
       dbms_output.put_line ('num_orden '|| v_numpeti
        || 'num_guia '|| v_numguia);
       IF v_petidor = 1 THEN
       -- envio taller
        UPDATE SP_ORDENES_REPARACION
        SET  num_guia_env = v_numguia
        WHERE num_orden = v_numpeti;
       ELSE -- v_petidor = 2
       -- entrega reemplazo
       dbms_output.put_line('numguiareem puesto    ' || v_numguia);
       dbms_output.put_line('numorden    ' || v_numpeti);
        UPDATE SP_ORDENES_REPARACION
        SET num_guia_reem = v_numguia
        WHERE num_orden = v_numpeti;
       dbms_output.put_line('numguiareem puesto ' || v_numguia);
       dbms_output.put_line('numorden ' || v_numpeti);
       -- else -- v_petidor = 3
       -- entrega equipo al cliente, no se llama a esta funcion
       END IF;
      EXCEPTION
       WHEN OTHERS THEN
          v_error := 1;
            v_mensa := '/Error Anotacion Numero de Guia/';
      END sp_p_pone_numguia;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_entrega(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_abonado IN OUT SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN OUT SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_bodega_ori IN OUT SP_ORDENES_REPARACION.cod_bodega_reem%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
  IS
      BEGIN
         SELECT num_abonado, cod_producto, cod_bodega
           INTO v_abonado, v_producto, v_bodega_ori
           FROM SP_ORDENES_REPARACION
          WHERE num_orden = v_numpeti ;
      EXCEPTION
         WHEN OTHERS THEN
              v_error := 1;
              v_mensa := '/Error Obtencion Datos Entrega/';
      END sp_p_select_entrega;
END Sp_Pac_Guias_Stp;
/
SHOW ERRORS
