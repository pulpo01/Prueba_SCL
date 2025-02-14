CREATE OR REPLACE PACKAGE BODY        AL_PROC_ES_EXTRA
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PROC_ES_EXTRA
-- * Descripcisn        : Rutinas para procesos entrada/salida extras
-- * Fecha de creacisn  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
PROCEDURE p_trata_extra(v_cabextra IN al_cab_es_extras%ROWTYPE ) IS
        v_linextra al_lin_es_extras%ROWTYPE;
        v_seriado al_articulos.ind_seriado%TYPE;
        v_movim   al_movimientos%ROWTYPE;
        v_entsal  al_tipos_movimientos.ind_entsal%TYPE;
        CURSOR c_linextra IS
        SELECT * FROM al_lin_es_extras
        WHERE num_extra = v_cabextra.num_extra;
BEGIN
        v_movim.fec_movimiento      := SYSDATE;
        v_movim.cod_bodega          := v_cabextra.cod_bodega;
        v_movim.nom_usuarora        := USER;
        v_movim.cod_estadomov       := 'SO';
        p_select_movim(v_cabextra.cod_motivo,
                       v_movim.tip_movimiento);
        p_select_tipmovim (v_movim.tip_movimiento,
                           v_entsal);
        v_movim.cod_estado_dest  := NULL;
        v_movim.tip_stock_dest      := NULL;
        v_movim.cod_bodega_dest     := NULL;
        v_movim.cod_uso_dest        := NULL;
        v_movim.num_guia            := NULL;
        v_movim.cod_transaccion     := 5;
        v_movim.num_transaccion     := v_cabextra.num_extra;
        FOR v_linextra IN c_linextra LOOP
            v_movim.tip_stock       := v_linextra.tip_stock;
            v_movim.cod_articulo    := v_linextra.cod_articulo;
            v_movim.cod_uso         := v_linextra.cod_uso;
            v_movim.cod_estado      := v_linextra.cod_estado;
            v_movim.prc_unidad      := v_linextra.prc_unidad;

            p_obtiene_seriado (v_linextra.cod_articulo, v_seriado);
            IF v_seriado = 1 THEN
               v_movim.num_cantidad := 1;
               p_proceso_seriados (v_cabextra.num_extra,
                                   v_linextra.num_linea,
                                   v_entsal,
                                   v_linextra.cod_uso,
                                   v_movim);
            ELSE
               v_movim.num_cantidad := v_linextra.can_extra;
               v_movim.num_serie    := NULL;
               IF v_linextra.num_desde IS NULL THEN
                  v_movim.num_desde := 0;
               ELSE
                  v_movim.num_desde    := v_linextra.num_desde;
               END IF;
               v_movim.num_hasta           := v_linextra.num_hasta;
                           v_movim.cod_plaza      := v_linextra.cod_plaza; /*AARM, Agrego Cod_Plaza, Diciembre 2002*/
               v_movim.num_seriemec        := NULL;
               v_movim.num_telefono        := NULL;
               v_movim.ind_telefono        := 0;
               v_movim.cap_code            := NULL;
               v_movim.cod_producto        := NULL;
               v_movim.cod_central         := NULL;
               v_movim.cod_moneda          := NULL;
               v_movim.cod_subalm          := NULL;
               v_movim.cod_central_dest    := NULL;
               v_movim.cod_subalm_dest     := NULL;
               v_movim.num_telefono_dest   := NULL;
               v_movim.cod_cat             := NULL;
               v_movim.cod_cat_dest        := NULL;
               p_select_mvto(v_movim.num_movimiento);
               v_movim.num_sec_loca := v_linextra.num_sec_loca;
               al_pac_validaciones.p_inserta_movim (v_movim);
            END IF;
        END LOOP;
      END;
  PROCEDURE p_select_movim(
  v_motivo IN al_motivos_es_extras.cod_motivo%TYPE ,
  v_tipmov IN OUT al_tipos_movimientos.tip_movimiento%TYPE )
  IS
      BEGIN
         SELECT tip_movimiento INTO v_tipmov
                FROM al_motivos_tipmovimiento_td
                WHERE cod_motivo = v_motivo;
      EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR (-20150,'Error lectura motivo E/S Extra ' ||
                                       SQLERRM);
      END p_select_movim;


PROCEDURE p_obtiene_seriado(  v_articulo IN al_articulos.cod_articulo%TYPE ,
                              v_seriado IN OUT al_articulos.ind_seriado%TYPE )
IS
BEGIN
        SELECT ind_seriado INTO v_seriado
               FROM al_articulos
               WHERE cod_articulo = v_articulo;
EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20511,'Error lectura Articulos ' ||
                                      SQLERRM);
      END p_obtiene_seriado;

PROCEDURE p_proceso_seriados( v_numextra IN al_cab_es_extras.num_extra%TYPE,     v_linextra IN al_lin_es_extras.num_linea%TYPE,
                              v_entsal IN al_tipos_movimientos.ind_entsal%TYPE,  v_uso IN al_usos.cod_uso%TYPE,
                              v_movim IN OUT al_movimientos%ROWTYPE ) IS
        CURSOR c_serextra IS
        SELECT * FROM al_ser_es_extras
        WHERE num_extra = v_numextra AND
                  num_linea = v_linextra;
        v_serextra al_ser_es_extras%ROWTYPE;
        v_reutil   ga_celnum_reutil%ROWTYPE;
        v_terminal al_articulos.tip_terminal%TYPE;
        v_indtelefono al_series.ind_telefono%TYPE;
        v_actuacion al_datos_generales.cod_actuacion_des%TYPE;
        v_serhex al_fic_series.num_serhex%TYPE;
        v_serhex_aux al_fic_series.num_serhex%TYPE;
        v_prefijo al_usos_min.num_min%TYPE;
    v_count_serie NUMBER;
BEGIN
        FOR v_serextra IN c_serextra LOOP
                v_serhex:=NULL;
                v_movim.num_serie            := v_serextra.num_serie;
                v_movim.num_cantidad         := 1;
                v_movim.num_serie            := v_serextra.num_serie;
                v_movim.num_desde            := 0;
                v_movim.num_hasta            := NULL;
                v_movim.num_seriemec         := v_serextra.num_seriemec;
                v_movim.num_telefono         := v_serextra.num_telefono;
                IF v_serextra.num_telefono IS NULL THEN
                        v_movim.ind_telefono := 0;
                ELSE
                        v_movim.ind_telefono := 1;
                END IF;
                v_movim.cap_code             := v_serextra.cap_code;
                v_movim.cod_producto         := v_serextra.cod_producto;
                v_movim.cod_central          := v_serextra.cod_central;
                v_movim.cod_moneda           := NULL;
                v_movim.cod_subalm           := v_serextra.cod_subalm;
                v_movim.cod_central_dest     := NULL;
                v_movim.cod_subalm_dest      := NULL;
                v_movim.num_telefono_dest    := NULL;
                v_movim.cod_cat              := v_serextra.cod_cat;
                v_movim.cod_cat_dest         := NULL;
                v_movim.num_sec_loca         := v_serextra.num_sec_loca;
                v_movim.cod_hlr              := v_serextra.cod_hlr;  --MLR 26052006
                p_select_mvto(v_movim.num_movimiento);
                IF v_entsal = 'S' THEN
                     p_select_ind_telefono(v_serextra.num_serie, v_indtelefono);
                END IF;
            -- if v_entsal = 'E' and
            -- v_serextra.cod_subalm is not null and
            -- v_serextra.cod_central is not null and
            -- v_serextra.cod_cat is not null then
            -- al_pac_numeracion.p_asigna_un_numero (v_serextra.cod_subalm,
            --                                         v_serextra.cod_central,
            --                                         v_uso,
            --                                         v_serextra.cod_cat,
            --                                         v_movim.num_telefono);
            -- elsif v_entsal = 'S' and
                IF v_entsal = 'S' AND
                        v_serextra.num_telefono IS NOT NULL THEN
                        v_reutil.num_celular    := v_serextra.num_telefono;
                        v_reutil.cod_subalm     := v_serextra.cod_subalm;
                        v_reutil.cod_producto   := v_serextra.cod_producto;
                        v_reutil.cod_central    := v_serextra.cod_central;
                        v_reutil.cod_uso        := v_uso;
                        v_reutil.cod_cat        := v_serextra.cod_cat;
                        al_pac_numeracion.p_libera_numero (v_reutil);
                        IF v_indtelefono > 1 THEN
                                al_proc_ingreso.p_select_terminal (v_movim.cod_articulo, v_terminal);
                                al_proc_ingreso.p_select_actuacion(v_actuacion, v_uso, v_reutil.cod_central);
                                p_conv_serhex(v_serextra.num_serie , v_serhex );
                                --v_serhex:=v_serhex_aux;
                                --al_pac_numeracion.p_select_prefijo_baja(v_uso,v_movim.num_serie,v_prefijo);
                                  v_prefijo:=al_fn_prefijo_numero(v_reutil.num_celular);
                                al_proc_ingreso.p_desactiva_central (v_actuacion, v_prefijo, v_serextra.cod_central,
                                                                     v_serextra.num_telefono,v_serhex, v_terminal,v_serextra.num_serie );
                        END IF;
        END IF;
        -- salida de almacen, despues de la posible desactivacion
        al_pac_validaciones.p_inserta_movim (v_movim);
        IF v_serextra.a_key IS NOT NULL THEN
                SELECT COUNT(1) INTO v_count_serie
                FROM ict_akeys
                WHERE num_esn = v_serextra.num_serie;
                IF v_count_serie > 0 THEN
                   UPDATE ict_akeys
                   SET a_key_cryp = v_serextra.a_key,
                   chk_digits=v_serextra.chk_digits,
                   PRIMER_CODIGO = v_serextra.NUM_SUBLOCK            --  JLR 2002.08.22  Agrego sublock
                   WHERE num_esn = v_serextra.num_serie;
                ELSE
                    P_TRANSFORMA_HEXA(v_serextra.num_serie,v_serhex_aux);
                    INSERT INTO ICT_AKEYS(NUM_ESN,COD_CLAVE,A_KEY_CRYP,CHK_DIGITS,PRIMER_CODIGO,SEGUNDO_CODIGO,
                                ID_CARGA,FEC_ACTUALIZACION,COD_ESTADO,NUM_ESN_HEX)
                    VALUES (v_serextra.num_serie,NULL,v_serextra.a_key,v_serextra.chk_digits,v_serextra.NUM_SUBLOCK,  --  JLR 2002.08.22  Agrego sublock
                                        NULL,-1,SYSDATE,2,v_serhex_aux);
                END IF;
        END IF;
        END LOOP;
EXCEPTION
        WHEN OTHERS THEN
--      raise_application_error (-20152,'Error en series'|| to_char(SQLCODE)  );
        RAISE_APPLICATION_ERROR (-20155,'Error(P_PROCESO_SERIADOS): ' || SQLERRM);
END p_proceso_seriados;
PROCEDURE p_select_tipmovim(  v_tipmov IN al_tipos_movimientos.tip_movimiento%TYPE , v_entsal IN OUT al_tipos_movimientos.ind_entsal%TYPE )
IS
BEGIN
         SELECT ind_entsal INTO v_entsal
                FROM al_tipos_movimientos
                WHERE tip_movimiento = v_tipmov;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20153,'Error lectura tipo de movimiento ' || SQLERRM);
END p_select_tipmovim;
PROCEDURE p_select_mvto(v_mvto IN OUT al_movimientos.num_movimiento%TYPE )IS
BEGIN
        SELECT al_seq_mvto.NEXTVAL INTO v_mvto
        FROM dual;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20153,'Error Obtencion No. Movimiento '|| SQLERRM);
END p_select_mvto;
PROCEDURE p_select_ind_telefono( v_serie IN al_series.num_serie%TYPE,  v_indtelefono IN OUT al_series.ind_telefono%TYPE )IS
BEGIN
        SELECT NVL(ind_telefono,0) INTO v_indtelefono
        FROM al_series
        WHERE num_serie = v_serie;
END p_select_ind_telefono;
PROCEDURE p_conv_serhex(v_serie IN al_series.num_serie%TYPE ,v_serhex IN OUT al_fic_series.num_serhex%TYPE )IS
        v_ser8  VARCHAR2(8);
        v_ser3  CHAR(3);
        v_ind NUMBER(2);
        v_int NUMBER (8);
        v_aux VARCHAR2(8);
BEGIN
        v_ser8 := SUBSTR(LTRIM(RTRIM(v_serie)),4,8);
        v_ser3 := SUBSTR(LTRIM(RTRIM(v_serie)),1,3);
        v_int := TO_NUMBER (v_ser3);
        FOR v_ind IN 1..2 LOOP
           p_hex(MOD(v_int,16), v_aux);
           v_serhex := NVL(v_aux || v_serhex,v_aux);
           v_int := TRUNC(v_int / 16);
        END LOOP;
        v_int := TO_NUMBER (v_ser8);
        v_ser8 := NULL;
        FOR v_ind IN 1..6 LOOP
           p_hex(MOD(v_int,16), v_aux);
           v_ser8 := NVL(v_aux || v_ser8,v_aux);
           v_int := TRUNC(v_int / 16) ;
        END LOOP;
        v_serhex := v_serhex || v_ser8;
END p_conv_serhex;
PROCEDURE p_hex(v_num IN NUMBER,v_hex IN OUT VARCHAR2) IS
BEGIN
        IF v_num > 9 THEN
            v_hex := CHR(v_num - 9 + 64);
        ELSE
            v_hex := TO_CHAR(v_num);
        END IF;
END p_hex;
END AL_PROC_ES_EXTRA;
/
SHOW ERRORS
