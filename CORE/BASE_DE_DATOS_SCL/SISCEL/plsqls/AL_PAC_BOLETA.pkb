CREATE OR REPLACE package body AL_PAC_BOLETA
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PAC_BOLETA
-- * Descripcisn        : Rutinas para logistica
-- * Fecha de creacisn  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
PROCEDURE al_p_pasohis(v_numboleta IN al_cab_boleta.num_boleta%type )
is
v_fechahis  date:=sysdate;
CURSOR c_cabboleta is
      select * from al_cab_boleta
      where num_boleta = v_numboleta
        for update;
v_cabboleta al_cab_boleta%rowtype;
BEGIN
FOR v_cabboleta in c_cabboleta LOOP
  insert into al_hcab_boleta
  ( num_boleta,
   fec_historico,
   cod_bodega,
   fec_boleta,
   cod_estado,
   cod_tipcomis,
   tip_movimiento,
   cod_vendedor,
   cod_oficina,
   nom_usuario,
   des_observacion,
   num_folio,
   prc_total,
   pref_plaza,
   cod_operadora)
 values
  (v_cabboleta.num_boleta,
   v_fechahis,
   v_cabboleta.cod_bodega,
   v_cabboleta.fec_boleta,
   v_cabboleta.cod_estado,
   v_cabboleta.cod_tipcomis,
   v_cabboleta.tip_movimiento,
   v_cabboleta.cod_vendedor,
   v_cabboleta.cod_oficina,
   v_cabboleta.nom_usuario,
   v_cabboleta.des_observacion,
   v_cabboleta.num_folio,
   v_cabboleta.prc_total,
   v_cabboleta.pref_plaza,
   v_cabboleta.cod_operadora);
 al_p_pasohis_lin(v_numboleta,v_fechahis);
 delete al_cab_boleta
 where current of c_cabboleta;
end LOOP;
END al_p_pasohis;
PROCEDURE al_p_pasohis_lin(
  v_numboleta IN al_cab_boleta.num_boleta%type,
  v_fechahis  IN al_hcab_boleta.fec_historico%type)
is
CURSOR c_linboleta is
      select * from al_lin_boleta
      where num_boleta = v_numboleta
        for update;
v_linboleta al_lin_boleta%rowtype;
BEGIN
FOR v_linboleta in c_linboleta LOOP
 insert into al_hlin_boleta
 (num_boleta,
  fec_historico,
  num_linea  ,
  tip_stock  ,
  cod_articulo,
  cod_uso    ,
  cod_estado ,
  can_venta  ,
  prc_unidad,
  cod_moneda)
 values
 (v_linboleta.num_boleta,
  v_fechahis,
  v_linboleta.num_linea  ,
  v_linboleta.tip_stock  ,
  v_linboleta.cod_articulo,
  v_linboleta.cod_uso    ,
  v_linboleta.cod_estado ,
  v_linboleta.can_venta  ,
  v_linboleta.prc_unidad,
  v_linboleta.cod_moneda);
  al_p_pasohis_ser(v_numboleta,
        v_linboleta.num_linea,
        v_fechahis);
--  delete al_lin_boleta where
  --      current of c_linboleta;
end LOOP;
END al_p_pasohis_lin;
PROCEDURE al_p_pasohis_ser(
  v_numboleta IN al_cab_boleta.num_boleta%type,
  v_numlinea  IN al_lin_boleta.num_linea%type,
  v_fechahis  IN al_hcab_boleta.fec_historico%type)
is
CURSOR c_serboleta is
      select * from al_ser_boleta
      where num_boleta = v_numboleta
        and num_linea = v_numlinea
        for update;
v_serboleta al_ser_boleta%rowtype;
BEGIN
FOR v_serboleta in c_serboleta LOOP
  insert into al_hser_boleta
  (num_boleta,
  fec_historico,
  num_linea   ,
  num_serie   ,
  num_serhex  ,
  num_telefono,
  ind_telefono,
  cap_code    ,
  num_seriemec,
  cod_central ,
  cod_producto,
  cod_subalm  ,
  cod_cat     ,
  num_movimiento)
  values
  (v_serboleta.num_boleta,
    v_fechahis,
  v_serboleta.num_linea   ,
  v_serboleta.num_serie   ,
  v_serboleta.num_serhex  ,
  v_serboleta.num_telefono,
  v_serboleta.ind_telefono,
  v_serboleta.cap_code    ,
  v_serboleta.num_seriemec,
  v_serboleta.cod_central ,
  v_serboleta.cod_producto,
  v_serboleta.cod_subalm  ,
  v_serboleta.cod_cat     ,
  v_serboleta.num_movimiento);
   delete al_ser_boleta where
         current of c_serboleta;
end LOOP;
END al_p_pasohis_ser;
PROCEDURE al_p_trata_boleta(
  v_cabboleta IN al_cab_boleta%rowtype )
  IS
       v_linboleta al_lin_boleta%rowtype;
       v_seriado al_articulos.ind_seriado%type;
       v_movim   al_movimientos%rowtype;
       CURSOR c_linboleta is
              select * from al_lin_boleta
                     where num_boleta = v_cabboleta.num_boleta;
    BEGIN
      v_movim.fec_movimiento      := SYSDATE;
      v_movim.cod_bodega          := v_cabboleta.cod_bodega;
      v_movim.nom_usuarora        := USER;
      v_movim.cod_estadomov       := 'SO';
      v_movim.tip_movimiento        := v_cabboleta.tip_movimiento;
      v_movim.cod_estado_dest  := null;
      v_movim.tip_stock_dest      := null;
      v_movim.cod_bodega_dest     := null;
      v_movim.cod_uso_dest        := null;
      v_movim.num_guia            := null;
      v_movim.cod_transaccion     := 17;
      v_movim.num_transaccion     := v_cabboleta.num_boleta;
      FOR v_linboleta in c_linboleta LOOP
          v_movim.tip_stock       := v_linboleta.tip_stock;
          v_movim.cod_articulo    := v_linboleta.cod_articulo;
          v_movim.cod_uso         := v_linboleta.cod_uso;
          v_movim.cod_estado      := v_linboleta.cod_estado;
          v_movim.prc_unidad      := v_linboleta.prc_unidad;
          al_p_obtiene_seriado (v_linboleta.cod_articulo,
                             v_seriado);
          if v_seriado = 1 then
             v_movim.num_cantidad := 1;
             al_p_proceso_seriados (v_cabboleta.num_boleta,
                                 v_linboleta.num_linea,
                                 v_linboleta.cod_uso,
                                 v_movim);
          else
             v_movim.num_cantidad := v_linboleta.can_venta;
             v_movim.num_serie    := null;
             v_movim.num_desde := 0;
             v_movim.num_seriemec        := null;
             v_movim.num_telefono        := null;
             v_movim.ind_telefono        := 0;
             v_movim.cap_code            := null;
             v_movim.cod_producto        := null;
             v_movim.cod_central         := null;
             v_movim.cod_moneda          := null;
             v_movim.cod_subalm          := null;
             v_movim.cod_central_dest    := null;
             v_movim.cod_subalm_dest     := null;
             v_movim.num_telefono_dest   := null;
             v_movim.cod_cat             := null;
             v_movim.cod_cat_dest        := null;
             al_p_select_mvto(v_movim.num_movimiento);
             al_pac_validaciones.p_inserta_movim (v_movim);
          end if;
      end LOOP;
    END;
  PROCEDURE al_p_obtiene_seriado(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_seriado IN OUT al_articulos.ind_seriado%type )
  IS
    BEGIN
      select ind_seriado into v_seriado
             from al_articulos
             where cod_articulo = v_articulo;
    EXCEPTION
      when OTHERS then
           raise_application_error (-20511,'Error lectura Articulos ' ||
                                    to_char(SQLCODE));
    END al_p_obtiene_seriado;
  PROCEDURE al_p_proceso_seriados(
  v_numboleta IN al_cab_boleta.num_boleta%type ,
  v_linboleta IN al_lin_boleta.num_linea%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_movim IN OUT al_movimientos%rowtype )
  IS
  CURSOR c_serboleta IS
     SELECT * FROM al_ser_boleta
  WHERE
     num_boleta = v_numboleta
     AND num_linea = v_linboleta
        for update;
  v_serboleta al_ser_boleta%ROWtype;
  v_activas al_series_activas%rowtype;
  v_actuacion_ami icc_movimiento.cod_actuacion%type;
  v_actuacion_act icc_movimiento.cod_actuacion%type;
  v_actuacion_act_gsm icc_movimiento.cod_actuacion%type;
  v_actuacion_gsm_ami icc_movimiento.cod_actuacion%type;
  v_movimiento icc_movimiento.num_movimiento%type;
  v_error number(1);
  v_prefijo al_usos_min.num_min%type;
  v_CodSimGsm  al_tipos_terminales.tip_terminal%TYPE;
  BEGIN
     SELECT val_parametro
     INTO  v_CodSimGsm
     FROM ged_parametros
     WHERE cod_producto=1 AND
           cod_modulo='AL' AND
                   nom_parametro='COD_SIMCARD_GSM';

     FOR v_serboleta IN c_serboleta LOOP
        v_movim.num_serie := v_serboleta.num_serie;
        v_movim.num_cantidad := 1;
        v_movim.num_desde := 0;
        v_movim.num_hasta := NULL;
        v_movim.num_seriemec := v_serboleta.num_seriemec;
        v_movim.num_telefono := v_serboleta.num_telefono;
        v_movim.ind_telefono := v_serboleta.ind_telefono;
        v_movim.cap_code := v_serboleta.cap_code;
        v_movim.cod_producto := v_serboleta.cod_producto;
        v_movim.cod_central := v_serboleta.cod_central;
        v_movim.cod_moneda := NULL;
        v_movim.cod_subalm := v_serboleta.cod_subalm;
        v_movim.cod_central_dest := NULL;
        v_movim.cod_subalm_dest := NULL;
        v_movim.num_telefono_dest := NULL;
        v_movim.cod_cat := v_serboleta.cod_cat;
        v_movim.cod_cat_dest := NULL;
        al_p_select_mvto(v_movim.num_movimiento);
        al_pac_validaciones.p_inserta_movim(v_movim);
          if v_serboleta.num_telefono is not null then
                -- 090800 aqadida validacion para que no se use esto para
                -- venta de celular, por cantidad de prepago y mas...
                        raise_application_error (-20175,'Error CBOL');
                v_activas.num_telefono := v_serboleta.num_telefono;
                v_activas.cod_central := v_serboleta.cod_central;
                v_activas.cod_producto := v_serboleta.cod_producto;
                v_activas.num_serie := v_serboleta.num_serie;
                v_activas.num_serhex := v_serboleta.num_serhex;

                al_pac_numeracion.p_select_terminal(v_movim.cod_articulo,v_activas.tip_terminal);
          -- Insert en al_series_activas
                al_p_insert_activas(v_activas);
          -- Activacion en central si no lo esta para amistar
          -- Solo debe contemplar los casos de ind_telefono 1
          -- que indica con telefono desactivado
          -- o con el valor 4 que indica con telefono activo
          -- para amistar.
                SELECT al_fn_prefijo_numero(v_activas.num_telefono)
                INTO v_prefijo
                FROM dual;

                         IF v_serboleta.ind_telefono = 1 THEN
               -- al_p_select_actuacion(v_actuacion_ami,v_actuacion_act,v_actuacion_gsm_ami,v_actuacion_act_gsm);

                v_error := 0;
                            IF (v_activas.tip_terminal =v_CodSimGsm) THEN
                  al_p_activar_central(v_actuacion_act_gsm,v_prefijo,v_activas.cod_central,v_activas.num_telefono,v_activas.num_serhex,v_activas.tip_terminal,v_movimiento,v_error,v_activas.num_serie);
                  IF v_error = 7 THEN
                       raise_application_error (-20175,' ');
                  END IF;
                                ELSE
                  al_p_activar_central(v_actuacion_act,v_prefijo,v_activas.cod_central,v_activas.num_telefono,v_activas.num_serhex,v_activas.tip_terminal,v_movimiento,v_error,v_activas.num_serie);
                  IF v_error = 7 THEN
                       raise_application_error (-20175,' ');
                  END IF;
                                END IF;

                                v_error := 0;
                                IF (v_activas.tip_terminal =v_CodSimGsm) THEN
                  al_p_activar_central(v_actuacion_gsm_ami,v_prefijo,v_activas.cod_central,v_activas.num_telefono,v_activas.num_serhex,v_activas.tip_terminal,v_movimiento,v_error,v_activas.num_serie);
                  IF v_error = 7 THEN
                       raise_application_error (-20175,' ');
                  END IF;
                                ELSE
                  al_p_activar_central(v_actuacion_ami,v_prefijo,v_activas.cod_central,v_activas.num_telefono,v_activas.num_serhex,v_activas.tip_terminal,v_movimiento,v_error,v_activas.num_serie);
                  IF v_error = 7 THEN
                       raise_application_error (-20175,' ');
                  END IF;
                                END IF;

                UPDATE al_ser_boleta
                SET num_movimiento = v_movimiento
                WHERE current of c_serboleta;

            END IF;
          end if;
     END LOOP;
  EXCEPTION
     WHEN OTHERS THEN
     raise_application_error(-20152, 'Error en proceso series '|| TO_CHAR(SQLCODE));
  END al_p_proceso_seriados;
  PROCEDURE al_p_select_mvto(
  v_mvto IN OUT al_movimientos.num_movimiento%type )
  IS
    BEGIN
        select al_seq_mvto.nextval into v_mvto
               from dual;
    EXCEPTION
        when OTHERS then
             raise_application_error (-20153,'Error Obtencion No. Movimiento '
                                      || to_char(SQLCODE));
    END al_p_select_mvto;
PROCEDURE al_p_insert_activas(
  v_activas IN al_series_activas%rowtype )
is
BEGIN
insert into al_series_activas
         (num_telefono,
          num_serie,
          cod_producto,
          tip_terminal,
          cod_central,
          num_serhex,
                fec_entrada,
                nom_usuarora)
       values
         (v_activas.num_telefono,
          v_activas.num_serie,
          v_activas.cod_producto,
          v_activas.tip_terminal,
          v_activas.cod_central,
          v_activas.num_serhex,
                SYSDATE,
                USER );
    EXCEPTION
        when OTHERS then
             raise_application_error (-20154,'Error Insert Series Activas '
                                      || to_char(SQLCODE));
END al_p_insert_activas;
PROCEDURE al_p_select_actuacion
         (v_actuacion_ami in out icg_actuacion.cod_actuacion%type,
          v_actuacion_act in out icg_actuacion.cod_actuacion%type,
          v_actuacion_gsm_ami in out icg_actuacion.cod_actuacion%type,
                  v_actuacion_act_gsm in out icc_movimiento.cod_actuacion%type) is
BEGIN
--    SELECT cod_actuacion_ami, cod_actuacion_act,cod_actuacion_gsm_ami,cod_actuacion_act_gsm
--    INTO v_actuacion_ami, v_actuacion_act, v_actuacion_gsm_ami, v_actuacion_act_gsm
--    FROM al_datos_generales;

   	 SELECT cod_actcen
	 INTO   v_actuacion_ami
	 FROM   ga_actabo
	 WHERE  cod_modulo ='AL'
	 AND    cod_producto = 1
	 AND    cod_tecnologia = 'CDMA'
	 AND    cod_actabo ='MM';
	 --
	 SELECT cod_actcen
	 INTO   v_actuacion_act
	 FROM   ga_actabo
	 WHERE  cod_modulo ='AL'
 	 AND    cod_producto = 1
	 AND    cod_tecnologia = 'CDMA'
	 AND    cod_actabo ='AA';
	 --
	 SELECT cod_actcen
	 INTO   v_actuacion_gsm_ami
	 FROM   ga_actabo
	 WHERE  cod_modulo ='AL'
	 AND    cod_producto = 1
	 AND    cod_tecnologia = 'GSM'
	 AND    cod_actabo ='GA';
	 --
	 SELECT cod_actcen
	 INTO   v_actuacion_act_gsm
	 FROM   ga_actabo
	 WHERE  cod_modulo ='AL'
	 AND    cod_producto = 1
	 AND    cod_tecnologia = 'GSM'
	 AND    cod_actabo ='AG';
	 --

END al_p_select_actuacion;
PROCEDURE al_p_activar_central
            (v_actuacion in icc_movimiento.cod_actuacion%type,
                         v_prefijo al_usos_min.num_min%type,
              v_central   in icc_movimiento.cod_central%type,
                v_celular   in icc_movimiento.num_celular%type,
               v_serie     in icc_movimiento.num_serie%type,
               v_terminal  in icc_movimiento.tip_terminal%type,
               v_movimiento in out icc_movimiento.num_movimiento%type,
               v_error     in out number,
                           p_serie_dec IN al_series.num_serie%TYPE) is

        v_num_serie  al_series.num_serie%TYPE;
		v_cod_articulo al_series.cod_articulo%TYPE;
		v_tecnologia al_tecnologia.cod_tecnologia%type;
BEGIN
   SELECT icc_seq_nummov.nextval
   INTO v_movimiento
   FROM al_datos_generales;

   SELECT a.cod_tecnologia
   INTO   v_tecnologia
   FROM   icg_central a
   where  a.cod_central = v_central;

   INSERT INTO icc_movimiento (num_movimiento,
                              num_abonado,
                              cod_estado,
                              cod_modulo,
                              num_intentos,
                              des_respuesta,
                              cod_actuacion,
                              cod_actabo,
                              nom_usuarora,
                              fec_ingreso,
                              cod_central,
                              num_celular,
                              num_serie,
                              tip_terminal,
                              ind_bloqueo,
                              num_min,
                              tip_tecnologia,
                              imsi,
                              imei,
                              icc)
                      values (v_movimiento,
                              0,
                              1,
                              'AL',
                              0,
                              'PENDIENTE',
                              v_actuacion,
                              'XX',
                              USER,
                              SYSDATE,
                              v_central,
                              v_celular,
                              v_serie,
                              v_terminal,
                              0,
                              v_prefijo,
							  v_tecnologia,
                              AL_DATOS_GSM_FN('IMSI',v_terminal,p_serie_dec),
                              AL_DATOS_GSM_FN('IMEI',v_terminal,p_serie_dec),
                              AL_DATOS_GSM_FN('ICC',v_terminal,p_serie_dec));

EXCEPTION
   when OTHERS then
        v_error := 7;
END al_p_activar_central;
END AL_PAC_BOLETA;
/
SHOW ERRORS
