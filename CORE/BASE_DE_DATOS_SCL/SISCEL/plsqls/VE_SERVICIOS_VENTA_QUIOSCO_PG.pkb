CREATE OR REPLACE PACKAGE BODY VE_SERVICIOS_VENTA_QUIOSCO_PG IS




   PROCEDURE ve_obtiene_abonados_venta_pr (
      en_numventa       IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_abonados_venta_PR"
         Lenguaje="PL/SQL"
         Fecha="26-03-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Recupera abonados para el numero de venta ingresado
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
      </Entrada>
      <Salida>
         <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      error_venta            EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
      postpago               NUMBER;
      prepago                NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT a.num_abonado' || ',a.cod_plantarif' || ',a.cod_cargobasico' || ',a.cod_planserv' || ',a.num_serie' || ',a.num_imei' || ',a.cod_cliente' || ',a.cod_vendedor' || ',a.cod_tipcontrato' || ',a.cod_causa_venta' || ',a.cod_modventa'
         || ',a.tip_plantarif' || ',a.num_contrato' || ',a.cod_uso' || ',a.cod_cuenta' || ' FROM  ga_abocel a' || '  WHERE a.num_venta =' || en_numventa;
      ln_contador := 0;


      SELECT COUNT (1) AS cant
        INTO postpago
        FROM ga_abocel a
       WHERE a.num_venta = en_numventa;

      SELECT COUNT (1) AS cant
        INTO prepago
        FROM ga_aboamist b
       WHERE b.num_venta = en_numventa;


      IF (prepago > 0 AND postpago > 0) THEN
         RAISE error_venta;
      END IF;

      IF (postpago > 0) THEN
         OPEN sc_cursordatos FOR
            SELECT a.num_abonado, a.cod_plantarif, a.cod_cargobasico, a.cod_planserv, a.num_serie,
                   a.num_imei, a.cod_cliente, a.cod_vendedor, a.cod_tipcontrato, a.cod_causa_venta,
                   a.cod_modventa, a.tip_plantarif, a.num_contrato, a.cod_uso, a.num_min, a.cod_central,
                   a.num_celular, a.cod_cuenta, a.cod_ciclo, a.cod_vendealer, a.cod_tecnologia, a.cod_celda,
                   a.tip_terminal, a.num_seriehex, a.ind_procequi
              FROM ga_abocel a
             WHERE a.num_venta = en_numventa;

      ELSIF(prepago > 0) THEN

         OPEN sc_cursordatos FOR
            SELECT b.num_abonado, b.cod_plantarif, b.cod_cargobasico, b.cod_planserv, b.num_serie,
                   b.num_imei, b.cod_cliente, b.cod_vendedor, b.cod_tipcontrato, b.cod_causa_venta,
                   b.cod_modventa, b.tip_plantarif, b.num_contrato, b.cod_uso, b.num_min, b.cod_central,
                   b.num_celular, b.cod_cuenta, b.cod_ciclo, b.cod_vendealer, b.cod_tecnologia, b.cod_celda,
                   b.tip_terminal, b.num_seriehex, b.ind_procequi
             FROM ga_aboamist b
             WHERE b.num_venta = en_numventa;

      ELSE
          lv_ssql := 'prepago ='||prepago ||' AND postpago ='||postpago;
          RAISE error_venta;
      END IF;

   EXCEPTION
      WHEN error_venta THEN
         sn_cod_retorno  := 100761;
         sv_mens_retorno :='Error la venta tiene abonados prepago y postpago';
         lv_des_error    := SUBSTR ('error_venta:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10761;
         sv_mens_retorno :='Error al obtener abonados venta';
         lv_des_error    := SUBSTR ('no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10762;
         sv_mens_retorno := 'Problemas al Obtener datos de Abonados Venta';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_venta_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_venta_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_abonados_venta_pr;

   PROCEDURE ve_obtiene_abonados_ventaam_pr (
      en_numventa       IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_abonados_venta_PR"
         Lenguaje="PL/SQL"
         Fecha="26-03-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Recupera abonados para el numero de venta ingresado
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
      </Entrada>
      <Salida>
         <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT a.num_abonado' || ',a.cod_plantarif' || ',a.cod_cargobasico' || ',a.cod_planserv' || ',a.num_serie' || ',a.num_imei' || ',a.cod_cliente' || ',a.cod_vendedor' || ',a.cod_tipcontrato' || ',a.cod_causa_venta' || ',a.cod_modventa'
         || ',a.tip_plantarif' || ',a.num_contrato' || ',a.cod_uso' || ',a.cod_cuenta' || ' FROM  ga_aboamist a' || '  WHERE a.num_venta =' || en_numventa;
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_aboamist a
       WHERE a.num_venta = en_numventa AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT a.num_abonado, a.cod_plantarif, a.cod_cargobasico, a.cod_planserv, a.num_serie, a.num_imei, a.cod_cliente, a.cod_vendedor, a.cod_tipcontrato, a.cod_causa_venta, a.cod_modventa, a.tip_plantarif, a.num_contrato, a.cod_uso, a.num_min,
                a.cod_central, a.num_celular, a.cod_cuenta
           FROM ga_aboamist a
          WHERE a.num_venta = en_numventa;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10763;
         sv_mens_retorno := 'Error al Recuperar Abonados para el Numero de Venta Ingresado';
         lv_des_error    := SUBSTR ('no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_ventaAm_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_ventaAm_PR', lv_ssql, sn_cod_retorno, lv_des_error);

     WHEN OTHERS THEN
         sn_cod_retorno  := 10764;
         sv_mens_retorno := 'Error Al Consultar Abonados De La Venta';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_ventaAm_PR(' || en_numventa || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_abonados_ventaAm_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_abonados_ventaam_pr;

   PROCEDURE ve_inserta_cargo_pr (
      ev_num_cargo          IN              VARCHAR2,
      ev_cod_cliente        IN              VARCHAR2,
      ev_cod_producto       IN              VARCHAR2,
      ev_cod_concepto       IN              VARCHAR2,
      ev_imp_cargo          IN              VARCHAR2,
      ev_cod_moneda         IN              VARCHAR2,
      ev_cod_plancom        IN              VARCHAR2,
      ev_num_unidades       IN              VARCHAR2,
      ev_ind_factur         IN              VARCHAR2,
      ev_num_transaccion    IN              VARCHAR2,
      ev_num_venta          IN              VARCHAR2,
      ev_num_paquete        IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_num_abonado        IN              VARCHAR2,
      ev_num_terminal       IN              VARCHAR2,
      ev_cod_ciclfact       IN              VARCHAR2,
      ev_num_serie          IN              VARCHAR2,
      ev_num_seriemec       IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_cap_code           IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_mes_garantia       IN              VARCHAR2,
      ev_num_preguia        IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_num_guia           IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_num_factura        IN              VARCHAR2,
      ev_cod_concepto_dto   IN              VARCHAR2,
      ev_val_dto            IN              VARCHAR2,
      ev_tip_dto            IN              VARCHAR2,
      ev_ind_cuota          IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_ind_supertel       IN              VARCHAR2,
      ev_ind_manual         IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_pref_plaza         IN              VARCHAR2                                                                                                                                                                                                    -- NULL
                                                    ,
      ev_cod_tecnologia     IN              VARCHAR2                                                                                                                                                                                                     -- GSM
                                                    ,
      ev_usuario            IN              VARCHAR2,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_inserta_cargo_PR"
         Lenguaje="PL/SQL"
         Fecha="26-03-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta los cargos del abonado
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
         ...
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      cont_dscto     NUMBER;
      lv_val_dcto    VARCHAR2(20);
      lv_imp_cargo   VARCHAR (20);
      lv_num_unidades VARCHAR(20);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_val_dcto := ev_val_dto;
      lv_imp_cargo:=ev_imp_cargo;
      lv_num_unidades := ev_num_unidades;


        Select count(8)
        into cont_dscto
        from fa_grpserconc a, GE_GRPSERVICIOS  b
        Where a.cod_concepto = ev_cod_concepto
        And a.fec_hasta > sysdate
        and a.COD_GRPSERVI = b.COD_GRPSERVI
        and b.DES_GRPSERVI like '%ISC%';

        if (cont_dscto <> 1) then
            --lv_val_dcto := '';
            --170452
            lv_val_dcto :=  ev_val_dto;
        else
            lv_val_dcto := round((lv_imp_cargo * lv_num_unidades)* (0.0446) ,4);
           -- sn_des_art  := round(sn_prc_venta * (0.0446) ,4);
        end if;

      lv_ssql :=
         'INSERT INTO ge_cargos (' || 'NUM_CARGO' || ',COD_CLIENTE' || ',COD_PRODUCTO' || ',COD_CONCEPTO' || ',FEC_ALTA' || ',IMP_CARGO' || ',COD_MONEDA' || ',COD_PLANCOM' || ',NUM_UNIDADES' || ',IND_FACTUR' || ',NUM_TRANSACCION' || ',NUM_VENTA'
         || ',NUM_PAQUETE' || ',NUM_ABONADO' || ',NUM_TERMINAL' || ',COD_CICLFACT' || ',NUM_SERIE' || ',NUM_SERIEMEC' || ',CAP_CODE' || ',MES_GARANTIA' || ',NUM_PREGUIA' || ',NUM_GUIA' || ',NUM_FACTURA' || ',COD_CONCEPTO_DTO' || ',VAL_DTO' || ',TIP_DTO'
         || ',IND_CUOTA' || ',IND_SUPERTEL' || ',IND_MANUAL' || ',NOM_USUARORA' || ',PREF_PLAZA' || ',COD_TECNOLOGIA)' || 'VALUES (' || ev_num_cargo || ',' || ev_cod_cliente || ',' || ev_cod_producto || ',' || ev_cod_concepto || ',SYSDATE' || ','
         || ev_imp_cargo || ',' || ev_cod_moneda || ',' || ev_cod_plancom || ',' || ev_num_unidades || ',' || ev_ind_factur || ',' || ev_num_transaccion || ',' || ev_num_venta || ',' || ev_num_paquete || ',' || ev_num_abonado || ',' || ev_num_terminal
         || ',' || ev_cod_ciclfact || ',' || ev_num_serie || ',' || ev_num_seriemec || ',' || ev_cap_code || ',' || ev_mes_garantia || ',' || ev_num_preguia || ',' || ev_num_guia || ',' || ev_num_factura || ',' || ev_cod_concepto_dto || ',' || ev_val_dto
         || ',' || ev_tip_dto || ',' || ev_ind_cuota || ',' || ev_ind_supertel || ',' || ev_ind_manual || ',' || ev_usuario || ',' || ev_pref_plaza || ',' || ev_cod_tecnologia || ')';

      INSERT INTO ge_cargos
                  (num_cargo, cod_cliente, cod_producto, cod_concepto, fec_alta, imp_cargo, cod_moneda, cod_plancom, num_unidades, ind_factur, num_transaccion, num_venta, num_paquete, num_abonado, num_terminal,
                   cod_ciclfact, num_serie, num_seriemec, cap_code, mes_garantia, num_preguia, num_guia, num_factura, cod_concepto_dto, val_dto, tip_dto, ind_cuota, ind_supertel, ind_manual, nom_usuarora,
                   pref_plaza, cod_tecnologia)
      VALUES      (ev_num_cargo, ev_cod_cliente, ev_cod_producto, ev_cod_concepto, SYSDATE, ev_imp_cargo, ev_cod_moneda, ev_cod_plancom, ev_num_unidades, ev_ind_factur, ev_num_transaccion, ev_num_venta, ev_num_paquete, ev_num_abonado, ev_num_terminal,
                   ev_cod_ciclfact, ev_num_serie, ev_num_seriemec, ev_cap_code, ev_mes_garantia, ev_num_preguia, ev_num_guia, ev_num_factura, ev_cod_concepto_dto, lv_val_dcto, ev_tip_dto, ev_ind_cuota, ev_ind_supertel, ev_ind_manual, ev_usuario,
                   ev_pref_plaza, ev_cod_tecnologia);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10765;
         sv_mens_retorno :='Error al Ingresar los Cargos del Abonado';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_cargo_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_cargo_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_inserta_cargo_pr;

   PROCEDURE ve_consulta_cliente_pr (
      ev_codcliente     IN              ge_clientes.cod_cliente%TYPE,
      sv_numident       OUT NOCOPY      ge_clientes.num_ident%TYPE,
      sv_tipident       OUT NOCOPY      ge_clientes.cod_tipident%TYPE,
      sv_nomcliente     OUT NOCOPY      ge_clientes.nom_cliente%TYPE,
      sn_codcuenta      OUT NOCOPY      ge_clientes.cod_cuenta%TYPE,
      sv_nomapellido1   OUT NOCOPY      ge_clientes.nom_apeclien1%TYPE,
      sv_nomapellido2   OUT NOCOPY      ge_clientes.nom_apeclien2%TYPE,
      sv_fecnaciomien   OUT NOCOPY      ge_clientes.fec_nacimien%TYPE,
      sv_indestcivil    OUT NOCOPY      ge_clientes.ind_estcivil%TYPE,
      sv_indsexo        OUT NOCOPY      ge_clientes.ind_sexo%TYPE,
      sn_codactividad   OUT NOCOPY      ge_clientes.cod_actividad%TYPE,
      sv_codregion      OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_codciudad      OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_codprovincia   OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_codcelda       OUT NOCOPY      ge_ciudades.cod_celda%TYPE,
      sv_codcalclien    OUT NOCOPY      ge_clientes.cod_calclien%TYPE,
      sn_indfactur      OUT NOCOPY      ge_clientes.ind_factur%TYPE,
      sn_codciclo       OUT NOCOPY      ge_clientes.cod_ciclo%TYPE,
      sn_codempresa     OUT NOCOPY      ga_empresa.cod_empresa%TYPE,
      sv_coddireccion   OUT NOCOPY      VARCHAR2,
      sv_codplantarif   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_cliente_PR"
         Lenguaje="PL/SQL"
         Fecha="29-03-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta datos del cliente
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_codcliente"     Tipo="NUMBER> codigo cliente</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT a.num_ident, a.cod_tipident, a.nom_cliente, ' || 'a.cod_cuenta,' || 'a.nom_apeclien1,' || 'a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil,' || 'a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad,'
         || 'c.cod_provincia, e.cod_celda, a.cod_calclien,' || 'a.ind_factur, a.cod_ciclo,NVL(b.cod_empresa,0),' || 'd.cod_direccion, b.cod_plantarif' || 'FROM     ge_clientes a, ga_empresa b,' || 'ge_direcciones c, ga_direccli d,' || 'ge_ciudades e'
         || 'WHERE    a.cod_cliente = ' || ev_codcliente || 'AND a.cod_cliente = b.cod_cliente(+)' || 'AND d.cod_cliente = a.cod_cliente' || 'AND d.cod_tipdireccion = ' || cv_tipodireccion || 'AND c.cod_direccion = d.cod_direccion'
         || 'AND e.cod_ciudad = c.cod_ciudad' || 'AND e.cod_provincia = c.cod_provincia' || 'AND e.cod_region = c.cod_region';

      SELECT a.num_ident, a.cod_tipident, a.nom_cliente, a.cod_cuenta, a.nom_apeclien1, a.nom_apeclien2, a.fec_nacimien, a.ind_estcivil, a.ind_sexo, a.cod_actividad, c.cod_region, c.cod_ciudad, c.cod_provincia, e.cod_celda, a.cod_calclien, a.ind_factur,
             a.cod_ciclo, NVL (b.cod_empresa, 0), d.cod_direccion, b.cod_plantarif
        INTO sv_numident, sv_tipident, sv_nomcliente, sn_codcuenta, sv_nomapellido1, sv_nomapellido2, sv_fecnaciomien, sv_indestcivil, sv_indsexo, sn_codactividad, sv_codregion, sv_codciudad, sv_codprovincia, sv_codcelda, sv_codcalclien, sn_indfactur,
             sn_codciclo, sn_codempresa, sv_coddireccion, sv_codplantarif
        FROM ge_clientes a, ga_empresa b, ge_direcciones c, ga_direccli d, ge_ciudades e
       WHERE a.cod_cliente = ev_codcliente AND a.cod_cliente = b.cod_cliente(+) AND d.cod_cliente = a.cod_cliente AND d.cod_tipdireccion = cv_tipodireccion AND c.cod_direccion = d.cod_direccion AND e.cod_ciudad = c.cod_ciudad
             AND e.cod_provincia = c.cod_provincia AND e.cod_region = c.cod_region;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10766;
         sv_mens_retorno :='Error al Consultar datos del cliente';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_cliente_PR(' || ev_codcliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_cliente_PR(' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11103;
         sv_mens_retorno := 'Error Al Consultar Datos Del Cliente';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_cliente_PR(' || ev_codcliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_cliente_PR(' || ev_codcliente || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_cliente_pr;

   PROCEDURE VE_consulta_serieTerminal_PR (
      ev_serie          IN              al_series.num_serie%TYPE,
      sv_codbodega      OUT NOCOPY      al_series.cod_bodega%TYPE,
      sv_estadoserie    OUT NOCOPY      al_series.cod_estado%TYPE,
      sv_indtelefono    OUT NOCOPY      al_series.ind_telefono%TYPE,
      sv_numcelular     OUT NOCOPY      al_series.num_telefono%TYPE,
      sv_uso            OUT NOCOPY      al_series.cod_uso%TYPE,
      sv_tipostock      OUT NOCOPY      al_series.tip_stock%TYPE,
      sv_codcentral     OUT NOCOPY      al_series.cod_central%TYPE,
      sn_codarticulo    OUT NOCOPY      al_series.cod_articulo%TYPE,
      sn_capcode        OUT NOCOPY      al_series.cap_code%TYPE,
      sn_tiparticulo    OUT NOCOPY      al_articulos.tip_articulo%TYPE,
      sv_desarticulo    OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sv_codsubalm      OUT NOCOPY      al_series.cod_subalm%TYPE,
      sn_indvalorar     OUT NOCOPY      al_tipos_stock.ind_valorar%TYPE,
      sv_carga          OUT NOCOPY      VARCHAR2,
      sn_cod_cat        OUT NOCOPY      al_series.cod_cat%TYPE ,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_serie_PR
         Lenguaje="PL/SQL"
         Fecha="30-03-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta datos de una serie especifica
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_serie"          Tipo="NUMBER> numero serie a consultar</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT s.cod_bodega, s.cod_estado, s.ind_telefono,' || ' s.num_telefono, s.cod_uso, s.tip_stock,' || ' s.cod_central, s.cap_code, s.cod_articulo,' || ' a.tip_articulo, a.des_articulo, s.cod_subalm,' || ' t.ind_valorar' || ' ,s.carga '
         || ' FROM   al_series s, al_articulos a' || ' WHERE s.num_serie =' || ev_serie || ' AND s.cod_articulo = a.cod_articulo, al_tipos_stock t' || ' AND s.tip_stock = t.tip_stock';

      SELECT s.cod_bodega, s.cod_estado, s.ind_telefono, s.num_telefono, s.cod_uso, s.tip_stock, s.cod_central, s.cap_code, s.cod_articulo, a.tip_articulo, a.des_articulo, s.cod_subalm, t.ind_valorar, s.carga, s.cod_cat
        INTO sv_codbodega, sv_estadoserie, sv_indtelefono, sv_numcelular, sv_uso, sv_tipostock, sv_codcentral, sn_capcode, sn_codarticulo, sn_tiparticulo, sv_desarticulo, sv_codsubalm, sn_indvalorar, sv_carga, sn_cod_cat
        FROM al_series s, al_articulos a, al_tipos_stock t
       WHERE s.num_serie = ev_serie
         AND s.cod_articulo = a.cod_articulo
         AND s.tip_stock = t.tip_stock;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10767;
         sv_mens_retorno := 'Error al consultar Serie';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11104;
         sv_mens_retorno := 'Error Al Consultar Datos De La Serie';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);
   END VE_consulta_serieTerminal_PR;

   PROCEDURE ve_consulta_plan_tarifario_pr (
      ev_plantarif           IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto         IN              ga_modvent_aplic.cod_producto%TYPE,
      ev_tecnologia          IN              al_tecnologia.cod_tecnologia%TYPE,
      sv_desplantarif        OUT NOCOPY      ta_plantarif.des_plantarif%TYPE,
      sv_tipplantarif        OUT NOCOPY      ta_plantarif.tip_plantarif%TYPE,
      sv_codlimconsumo       OUT NOCOPY      tol_limite_td.cod_limcons%TYPE,
      sn_numdias             OUT NOCOPY      ta_plantarif.num_dias%TYPE,
      sv_codplanserv         OUT NOCOPY      ga_planserv.cod_planserv%TYPE,
      sn_ind_cargo_habil     OUT NOCOPY      ta_plantarif.ind_cargo_habil%TYPE,
      sv_codcargobasico      OUT NOCOPY      ta_plantarif.cod_cargobasico%TYPE,
      sv_descargobasico      OUT NOCOPY      ta_cargosbasico.des_cargobasico%TYPE,
      sn_importecargo        OUT NOCOPY      ta_cargosbasico.imp_cargobasico%TYPE,
      sv_monedacargobasico   OUT NOCOPY      ta_cargosbasico.cod_moneda%TYPE,
      sv_codtiplan           OUT NOCOPY      ta_plantarif.cod_tiplan%TYPE,
      sn_ind_familiar        OUT NOCOPY      ta_plantarif.ind_familiar%TYPE,
      sn_num_abonados        OUT NOCOPY      ta_plantarif.num_abonados%TYPE,
      sv_cod_plan_comverse   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_plan_tarifario_PR
         Lenguaje="PL/SQL"
         Fecha="30-03-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta datos de una serie especifica
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_plantarif"          Tipo="STRING"> codigo plan tarifario a consultar</param>
         <param nom="EN_codproducto"        Tipo="NUMBER"> codigo producto</param>
         <param nom="EV_tecnologia"         Tipo="STRING"> codigo tecnologia</param>
      </Entrada>
      <Salida>
            <param nom="SV_desplantarif"      Tipo="STRING"> descripcion plan tarifario </param>
            <param nom="SV_tipplantarif"      Tipo="STRING"> codigo limite de consumo</param>
            <param nom="SV_codlimconsumo"     Tipo="STRING"> codigo limite de consumo</param>
            <param nom="SN_numdias"           Tipo="NUMBER"> numero de dias</param>
            <param nom="SV_codplanserv"       Tipo="STRING"> codigo plan de servicio</param>
         <param nom="SN_ind_cargo_habil"   Tipo="NUMBER"> indicador de cobro de habilitación</param>
            <param nom="SV_codcargobasico"    Tipo="STRING"> codigo cargo basico</param>
            <param nom="SV_descargobasico"    Tipo="STRING"> desccripción cargo basico</param>
            <param nom="SN_importecargo"      Tipo="NUMBER"> importe cargo basico</param>
            <param nom="SV_monedacargobasico" Tipo="STRING"> código moneda utilizada en cargo basico</param>
         <param nom="SV_codtiplan"         Tipo="STRING"> código tipo plan en GED_CODIGOS</param>
         <param nom="SN_ind_familiar"      Tipo="NUMBER"> indica si es plan familiar</param>
         <param nom="SN_numAbonados"       Tipo="NUMBER"> numero de abonados </param>
         <param nom="SV_cod_plan_comverse" Tipo="STRING"> codigo de plan converse </param>
         <param nom="SN_cod_retorno"       Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno"      Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"        Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT plantarifario.tip_plantarif, d.cod_limcons,' || ' plantarifario.num_dias, plantarifario.ind_cargo_habil,' || ' relserviciotecnoplantarif.cod_planserv,' || ' plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico,'
         || ' cargosbasicos.imp_cargobasico, cargosbasicos.cod_moneda,' || ' plantarifario.cod_tiplan, plantarifario.ind_familiar,' || ' plantarifario.des_plantarif, plantarifario.num_abonados,' || ' plantarifario.cod_plan_comverse'
         || ' FROM   ta_plantarif plantarifario, ta_cargosbasico cargosbasicos,' || ' ga_plantecplserv relserviciotecnoplantarif,tol_limite_td d,' || ' tol_limite_plan_td e' || ' WHERE plantarifario.cod_plantarif= ' || ev_plantarif
         || ' AND SYSDATE BETWEEN plantarifario.fec_desde ' || ' AND NVL(plantarifario.fec_hasta, SYSDATE)' || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico ' || ' AND plantarifario.cod_producto =' || en_codproducto
         || ' AND SYSDATE BETWEEN cargosbasicos.fec_desde ' || ' AND NVL(cargosbasicos.fec_hasta, SYSDATE)' || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)'
         || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)' || ' AND relserviciotecnoplantarif.cod_tecnologia =' || ev_tecnologia || ' AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde'
         || ' AND NVL(relserviciotecnoplantarif.fec_hasta, SYSDATE)' || ' AND SYSDATE BETWEEN e.FEC_DESDE AND NVL(e.FEC_HASTA, SYSDATE)' || ' AND e.COD_PLANTARIF = plantarifario.cod_plantarif' || ' AND d.cod_limcons = e.cod_limcons' || ' AND ROWNUM<=1';

  /*    SELECT plantarifario.tip_plantarif, d.cod_limcons, plantarifario.num_dias, plantarifario.ind_cargo_habil, relserviciotecnoplantarif.cod_planserv, plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico, cargosbasicos.imp_cargobasico,
             cargosbasicos.cod_moneda, plantarifario.cod_tiplan, plantarifario.ind_familiar, plantarifario.des_plantarif, plantarifario.num_abonados, plantarifario.cod_plan_comverse
        INTO sv_tipplantarif, sv_codlimconsumo, sn_numdias, sn_ind_cargo_habil, sv_codplanserv, sv_codcargobasico, sv_descargobasico, sn_importecargo,
             sv_monedacargobasico, sv_codtiplan, sn_ind_familiar, sv_desplantarif, sn_num_abonados, sv_cod_plan_comverse
        FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif, tol_limite_td d, tol_limite_plan_td e
       WHERE plantarifario.cod_plantarif = ev_plantarif AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE) AND plantarifario.cod_cargobasico = cargosbasicos.cod_cargobasico
             AND plantarifario.cod_producto = en_codproducto AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE) AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
             AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+) AND relserviciotecnoplantarif.cod_tecnologia = ev_tecnologia
             AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde AND NVL (relserviciotecnoplantarif.fec_hasta, SYSDATE) AND SYSDATE BETWEEN e.fec_desde AND NVL (e.fec_hasta, SYSDATE) AND e.cod_plantarif = plantarifario.cod_plantarif
             AND d.cod_limcons = e.cod_limcons AND plantarifario.cod_tiplan IN (2, 3) AND ROWNUM <= 1
             AND plantarifario.CLA_PLANTARIF <> 'SRV'
      UNION
      SELECT plantarifario.tip_plantarif, limconsumo.cod_limconsumo, plantarifario.num_dias, plantarifario.ind_cargo_habil, relserviciotecnoplantarif.cod_planserv, plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico,
             cargosbasicos.imp_cargobasico, cargosbasicos.cod_moneda, plantarifario.cod_tiplan, plantarifario.ind_familiar, plantarifario.des_plantarif, plantarifario.num_abonados, plantarifario.cod_plan_comverse
        FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif, ta_limconsumo limconsumo
       WHERE plantarifario.cod_plantarif = ev_plantarif AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE) AND plantarifario.cod_cargobasico = cargosbasicos.cod_cargobasico
             AND plantarifario.cod_producto = en_codproducto AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE) AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
             AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+) AND relserviciotecnoplantarif.cod_tecnologia = ev_tecnologia
             AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde AND NVL (relserviciotecnoplantarif.fec_hasta, SYSDATE) AND limconsumo.cod_limconsumo = plantarifario.cod_limconsumo AND plantarifario.cod_tiplan = 1
             AND plantarifario.CLA_PLANTARIF <> 'SRV';*/

    /*SELECT plantarifario.tip_plantarif, decode(plantarifario.cod_tiplan, 2, d.cod_limcons, 3, -1, NULL), plantarifario.num_dias, plantarifario.ind_cargo_habil, relserviciotecnoplantarif.cod_planserv, plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico, cargosbasicos.imp_cargobasico,
             cargosbasicos.cod_moneda, plantarifario.cod_tiplan, plantarifario.ind_familiar, plantarifario.des_plantarif, plantarifario.num_abonados, plantarifario.cod_plan_comverse
        INTO sv_tipplantarif, sv_codlimconsumo, sn_numdias, sn_ind_cargo_habil, sv_codplanserv, sv_codcargobasico, sv_descargobasico, sn_importecargo,
            sv_monedacargobasico, sv_codtiplan, sn_ind_familiar, sv_desplantarif, sn_num_abonados, sv_cod_plan_comverse
        FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif, tol_limite_td d, tol_limite_plan_td e
       WHERE plantarifario.cod_producto = en_codproducto
       AND plantarifario.cod_plantarif = ev_plantarif
       AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE)
       AND plantarifario.CLA_PLANTARIF <> 'SRV'
       AND cargosbasicos.cod_producto = plantarifario.cod_producto
       AND cargosbasicos.cod_cargobasico = plantarifario.cod_cargobasico
      AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE)
      AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)
      AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
      AND relserviciotecnoplantarif.cod_tecnologia = ev_tecnologia
      AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde AND NVL (relserviciotecnoplantarif.fec_hasta, SYSDATE)
      AND e.cod_plantarif = plantarifario.cod_plantarif
      AND e.ind_default = 'S'
      AND SYSDATE BETWEEN e.fec_desde AND NVL (e.fec_hasta, SYSDATE)
      AND D.cod_limcons = E.cod_limcons;*/

      SELECT plantarifario.tip_plantarif, d.cod_limcons, plantarifario.num_dias, plantarifario.ind_cargo_habil, relserviciotecnoplantarif.cod_planserv, plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico, cargosbasicos.imp_cargobasico,
             cargosbasicos.cod_moneda, plantarifario.cod_tiplan, plantarifario.ind_familiar, plantarifario.des_plantarif, plantarifario.num_abonados, plantarifario.cod_plan_comverse
        INTO sv_tipplantarif, sv_codlimconsumo, sn_numdias, sn_ind_cargo_habil, sv_codplanserv, sv_codcargobasico, sv_descargobasico, sn_importecargo,
            sv_monedacargobasico, sv_codtiplan, sn_ind_familiar, sv_desplantarif, sn_num_abonados, sv_cod_plan_comverse
        FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif, tol_limite_td d, tol_limite_plan_td e
       WHERE plantarifario.cod_producto = en_codproducto
       AND plantarifario.cod_plantarif = ev_plantarif
       AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE)
       AND plantarifario.CLA_PLANTARIF <> 'SRV'
       AND plantarifario.cod_tiplan = 2
       AND cargosbasicos.cod_producto = plantarifario.cod_producto
       AND cargosbasicos.cod_cargobasico = plantarifario.cod_cargobasico
      AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE)
      AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)
      AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
      AND relserviciotecnoplantarif.cod_tecnologia = ev_tecnologia
      AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde AND NVL (relserviciotecnoplantarif.fec_hasta, SYSDATE)
      AND e.cod_plantarif = plantarifario.cod_plantarif
      AND e.ind_default = 'S'
      AND SYSDATE BETWEEN e.fec_desde AND NVL (e.fec_hasta, SYSDATE)
      AND D.cod_limcons = E.cod_limcons
      UNION
      SELECT plantarifario.tip_plantarif, decode(plantarifario.cod_tiplan, 3, '-1', 1, NULL), plantarifario.num_dias, plantarifario.ind_cargo_habil, relserviciotecnoplantarif.cod_planserv, plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico, cargosbasicos.imp_cargobasico,
             cargosbasicos.cod_moneda, plantarifario.cod_tiplan, plantarifario.ind_familiar, plantarifario.des_plantarif, plantarifario.num_abonados, plantarifario.cod_plan_comverse
       FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif
       WHERE plantarifario.cod_producto = en_codproducto
       AND plantarifario.cod_plantarif = ev_plantarif
       AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE)
       AND plantarifario.CLA_PLANTARIF <> 'SRV'
       AND plantarifario.cod_tiplan in (1,3)
       AND cargosbasicos.cod_producto = plantarifario.cod_producto
       AND cargosbasicos.cod_cargobasico = plantarifario.cod_cargobasico
      AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE)
      AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)
      AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
      AND relserviciotecnoplantarif.cod_tecnologia = ev_tecnologia
      AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde AND NVL (relserviciotecnoplantarif.fec_hasta, SYSDATE);


   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10768;
         sv_mens_retorno := 'Error al consultar Plan Tarifario';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ',' || en_codproducto || ',' || ev_tecnologia || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11105;
         sv_mens_retorno := 'Error Al Consultar Plan Tarifario';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ',' || en_codproducto || ',' || ev_tecnologia || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_plan_tarifario_pr;

   PROCEDURE ve_precio_cargo_basico_pr (
      ev_codproducto    IN              VARCHAR2,
      ev_codcargo       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_busca_precio_cargo_basico_PR"
         Lenguaje="PL/SQL"
         Fecha="09-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta datos de una serie especifica
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
         <param nom="EV_codcargo"    Tipo="VARCHAR2"> codigo del cargo</param>
      </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_sql                 ge_errores_pg.vquery;
      lv_des_error           ge_errores_pg.desevent;
      lv_concepto            VARCHAR2 (4);
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      SELECT a.cod_abonocel
        INTO lv_concepto
        FROM fa_datosgener a;

      lv_sql :=
         'SELECT ' || ' a.cod_concepto ' || ',a.des_concepto ' || ',b.imp_cargobasico ' || ',a.cod_moneda ' || ',c.des_moneda ' || ',''A'' ' || ',''1'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' '
         || ' FROM fa_conceptos a, ta_cargosbasico b, ge_monedas c' || ' WHERE a.cod_concepto = ' || lv_concepto || ' AND a.cod_producto = = ' || ev_codproducto || ' AND b.cod_producto = a.cod_producto ' || ' AND b.cod_cargobasico = ' || ev_codcargo
         || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)' || ' AND a.cod_moneda = c.cod_moneda';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM fa_conceptos a, ta_cargosbasico b, ge_monedas c
       WHERE a.cod_concepto = lv_concepto AND a.cod_producto = ev_codproducto AND b.cod_producto = a.cod_producto AND b.cod_cargobasico = ev_codcargo AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND a.cod_moneda = c.cod_moneda
             AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT a.cod_concepto, a.des_concepto, b.imp_cargobasico, a.cod_moneda, c.des_moneda, 'A'                                                                                                                        -- tipo cargo [ Automatico o Manual ]
                                                                                                  ,
                '1'                                                                                                                                                                                                                          -- numero unidades
                   ,
                '0'                                                                                                                                                                                                                              -- ind. equipo
                   ,
                '0'                                                                                                                                                                                                                             -- ind. paquete
                   ,
                '0'                                                                                                                                                                                                                             -- mes garantia
                   ,
                '0'                                                                                                                                                                                                                           -- ind. accesorio
                   ,
                '0'                                                                                                                                                                                                                            -- cod. articulo
                   ,
                '0'                                                                                                                                                                                                                               -- cod. stock
                   ,
                '0'                                                                                                                                                                                                                              -- cod. estado
           FROM fa_conceptos a, ta_cargosbasico b, ge_monedas c
          WHERE a.cod_concepto = lv_concepto AND a.cod_producto = ev_codproducto AND b.cod_producto = a.cod_producto AND b.cod_cargobasico = ev_codcargo AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND a.cod_moneda = c.cod_moneda;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10769;
         sv_mens_retorno := 'Error al obtener Precios de cargo de la Simcard';
         lv_des_error    := 'no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_basico_PR(' || ev_codproducto || ',' || ev_codcargo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_basico_PR(' || ev_codcargo || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11106;
         sv_mens_retorno := 'Error Al Consultar Precios De Cargos Simcard';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_basico_PR(' || ev_codproducto || ',' || ev_codcargo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_basico_PR(' || ev_codcargo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_precio_cargo_basico_pr;

   PROCEDURE ve_preccargosimcard_prelis_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
      en_indrecambio    IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria   IN              al_precios_venta.cod_categoria%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_PrecCargoSimcard_PreLis_PR"
         Lenguaje="PL/SQL"
         Fecha="17-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 Obtiene precio cargo de una simcard. Precio de Lista.
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
      </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT  a.cod_conceptoart' || ',a.des_articulo' || ',t.prc_venta' || ',t.cod_moneda' || ',m.des_moneda' || ',NVL(t.val_minimo,0)' || ',NVL(t.val_maximo,0)' || ',''A'' ' || ',''1'' ' || ',''1'' ' || ',''0'' ' || ',a.MES_GARANTIA' || ',''0'' '
         || ',''0'' ' || ',''0'' ' || ',''0'' ' || ' FROM al_precios_venta t, al_articulos a, ge_monedas m' || ' WHERE t.tip_stock = ' || en_tipstock || ' AND t.cod_articulo =' || en_codarticulo || ' AND t.cod_categoria = ' || ev_codcategoria
         || ' AND t.cod_uso = ' || en_codusoventa || ' AND t.cod_estado = ' || en_codestado || ' AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)' || ' AND a.cod_articulo = t.cod_articulo' || ' AND m.cod_moneda = t.cod_moneda'
         || ' AND t.ind_recambio = ' || en_indrecambio || ' AND t.cod_calificacion = ' || cv_cod_calificacion || ' AND t.cod_promedio = 0 ';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM al_precios_venta t, al_articulos a, ge_monedas m
       WHERE t.tip_stock = en_tipstock AND t.cod_articulo = en_codarticulo AND UPPER(t.cod_categoria) = UPPER(ev_codcategoria)                                                                                                                             -- constante (ZZZ)
             AND t.cod_uso = en_codusoventa AND t.cod_estado = en_codestado AND SYSDATE BETWEEN t.fec_desde AND NVL (t.fec_hasta, SYSDATE) AND a.cod_articulo = t.cod_articulo AND m.cod_moneda = t.cod_moneda
             AND t.ind_recambio = en_indrecambio                                                                                                                                                                                                  -- constante (9)
             AND t.cod_calificacion = cv_cod_calificacion AND t.cod_promedio = 0 -- CSR-11002
             AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT a.cod_conceptoart, a.des_articulo, t.prc_venta, t.cod_moneda, m.des_moneda, NVL (t.val_minimo, 0), NVL (t.val_maximo, 0), 'A'                                                                             -- tipo cargo [ Automatico o Manual ]
                                                                                                                                             ,
                '1'                                                                                                                                                                                                                          -- numero unidades
                   ,
                '1'                                                                                                                                                                                                                              -- ind. equipo
                   ,
                '0'                                                                                                                                                                                                                             -- ind. paquete
                   ,
                a.mes_garantia, '0'                                                                                                                                                                                                           -- ind. accesorio
                                   ,
                '0'                                                                                                                                                                                                                            -- cod. articulo
                   ,
                '0'                                                                                                                                                                                                                               -- cod. stock
                   ,
                '0'                                                                                                                                                                                                                              -- cod. estado
           FROM al_precios_venta t, al_articulos a, ge_monedas m
          WHERE t.tip_stock = en_tipstock AND t.cod_articulo = en_codarticulo AND  UPPER(t.cod_categoria) = UPPER(ev_codcategoria)                                                                                                                        -- constante (ZZZ)
                AND t.cod_uso = en_codusoventa AND t.cod_estado = en_codestado AND SYSDATE BETWEEN t.fec_desde AND NVL (t.fec_hasta, SYSDATE) AND a.cod_articulo = t.cod_articulo AND m.cod_moneda = t.cod_moneda AND t.ind_recambio = en_indrecambio
                AND t.cod_calificacion = cv_cod_calificacion AND t.cod_promedio = 0; -- CSR-11002
                                                                                                                                                                                                                                               -- constante (9)

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10770;
         sv_mens_retorno := 'Error al consultar el Precio de Cargo de la Simcard';
         lv_des_error    :='no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoSimcard_PreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_indrecambio || ',' || ev_codcategoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoSimcard_PreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11107;
         sv_mens_retorno := 'error al consultar precio cargo de simcard(precio lista)';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoSimcard_PreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_indrecambio || ',' || ev_codcategoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoSimcard_PreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_preccargosimcard_prelis_pr;

   PROCEDURE ve_preccargoterminal_prelis_pr (
      en_codarticulo    IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock       IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa    IN              al_precios_venta.cod_uso%TYPE,
      en_codestado      IN              al_precios_venta.cod_estado%TYPE,
      en_indrecambio    IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria   IN              al_precios_venta.cod_categoria%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_PrecCargoTerminal_PreLis_PR"
         Lenguaje="PL/SQL"
         Fecha="17-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 Obtiene precio cargo de un terminal o equipo. Precio de Lista.
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo</param>
         ...
      </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT  a.cod_conceptoart' || ',a.des_articulo' || ',t.prc_venta' || ',t.cod_moneda' || ',m.des_moneda' || ',NVL(t.val_minimo,0)' || ',NVL(t.val_maximo,0)' || ',''A'' ' || ',''1'' ' || ',''1'' ' || ',''0'' ' || ',a.MES_GARANTIA' || ',''0'' '
         || ',''0'' ' || ',''0'' ' || ',''0'' ' || ' FROM al_precios_venta t, al_articulos a, ge_monedas m' || ' WHERE t.tip_stock = ' || en_tipstock || ' AND t.cod_articulo =' || en_codarticulo || ' AND t.cod_categoria = ' || ev_codcategoria
         || ' AND t.cod_uso = ' || en_codusoventa || ' AND t.cod_estado = ' || en_codestado || ' AND SYSDATE BETWEEN t.fec_desde AND NVL(t.fec_hasta, SYSDATE)' || ' AND a.cod_articulo = t.cod_articulo' || ' AND m.cod_moneda = t.cod_moneda'
         || ' AND t.ind_recambio = ' || en_indrecambio || ' AND t.cod_calificacion = ' || cv_cod_calificacion || ' AND t.cod_promedio = 0';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM al_precios_venta t, al_articulos a, ge_monedas m
       WHERE t.tip_stock = en_tipstock AND t.cod_articulo = en_codarticulo AND t.cod_categoria = ev_codcategoria                                                                                                                             -- constante (ZZZ)
             AND t.cod_uso = en_codusoventa AND t.cod_estado = en_codestado AND SYSDATE BETWEEN t.fec_desde AND NVL (t.fec_hasta, SYSDATE) AND a.cod_articulo = t.cod_articulo AND m.cod_moneda = t.cod_moneda
             AND t.ind_recambio = en_indrecambio                                                                                                                                                                                               -- constante (9)
             AND t.cod_calificacion = cv_cod_calificacion AND t.cod_promedio = 0 --CSR-11002
             AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT a.cod_conceptoart, a.des_articulo, t.prc_venta, t.cod_moneda, m.des_moneda, NVL (t.val_minimo, 0), NVL (t.val_maximo, 0), 'A'                                                                             -- tipo cargo [ Automatico o Manual ]
                                                                                                                                             ,
                '1'                                                                                                                                                                                                                          -- numero unidades
                   ,
                '1'                                                                                                                                                                                                                              -- ind. equipo
                   ,
                '0'                                                                                                                                                                                                                             -- ind. paquete
                   ,
                a.mes_garantia, '0'                                                                                                                                                                                                           -- ind. accesorio
                                   ,
                '0'                                                                                                                                                                                                                            -- cod. articulo
                   ,
                '0'                                                                                                                                                                                                                               -- cod. stock
                   ,
                '0'                                                                                                                                                                                                                              -- cod. estado
           FROM al_precios_venta t, al_articulos a, ge_monedas m
          WHERE t.tip_stock = en_tipstock AND t.cod_articulo = en_codarticulo AND t.cod_categoria = ev_codcategoria                                                                                                                          -- constante (ZZZ)
                AND t.cod_uso = en_codusoventa AND t.cod_estado = en_codestado AND SYSDATE BETWEEN t.fec_desde AND NVL (t.fec_hasta, SYSDATE) AND a.cod_articulo = t.cod_articulo AND m.cod_moneda = t.cod_moneda AND t.ind_recambio = en_indrecambio
                AND t.cod_calificacion = cv_cod_calificacion AND t.cod_promedio = 0; --CSR-11002
                                                                                                                                                                                                                                               -- constante (9)

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10771;
         sv_mens_retorno := 'Error Obtener Precio Cargo de un Terminal o Equipo. Precio de Lista.';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoTerminal_PreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_indrecambio || ',' || ev_codcategoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoTerminal_PreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11108;
         sv_mens_retorno := 'Error Al Consultar Precio Cargo De Un Terminal O Equipo(Precio Lista)';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoTerminal_PreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_indrecambio || ',' || ev_codcategoria || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PrecCargoTerminal_PreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_preccargoterminal_prelis_pr;

   PROCEDURE ve_precarsimcard_noprelis_pr (
      en_codarticulo     IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock        IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa     IN              al_precios_venta.cod_uso%TYPE,
      en_codestado       IN              al_precios_venta.cod_estado%TYPE,
      en_modventa        IN              al_precios_venta.cod_modventa%TYPE,
      ev_tipocontrato    IN              ga_percontrato.cod_tipcontrato%TYPE,
      ev_plantarif       IN              ve_catplantarif.cod_plantarif%TYPE,
      en_indrecambio     IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria    IN              al_precios_venta.cod_categoria%TYPE,
      en_codusoprepago   IN              al_precios_venta.cod_uso%TYPE,
      ev_indequipo       IN              al_articulos.ind_equiacc%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_PreCarSimcard_NoPreLis_PR"
         Lenguaje="PL/SQL"
         Fecha="05-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 Obtiene precio cargo de simcard. No Precio de Lista.
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo </param>
         ...
      </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT  b.cod_conceptoart' || ',b.des_articulo' || ',a.prc_venta' || ',a.cod_moneda' || ',c.des_moneda' || ',NVL(a.val_minimo,0)' || ',NVL(a.val_maximo,0)' || ',''A'' ' || ',''1'' ' || ',''1'' ' || ',''0'' ' || ',a.mes_garantia' || ',''0'' '
         || ',''0'' ' || ',''0'' ' || ',''0'' ' || 'FROM al_precios_venta a' || ',al_articulos b' || ',ge_monedas c' || ',(SELECT w.cod_categoria categoria' || 'FROM ve_catplantarif v, ve_categorias w' || 'WHERE v.cod_plantarif =' || ev_plantarif
         || 'AND v.cod_categoria = w.cod_categoria) z' || ',(SELECT p.num_meses meses ' || 'FROM ga_percontrato p' || 'WHERE p.cod_producto > 0' || 'AND p.cod_tipcontrato = ' || ev_tipocontrato || ') xy' || 'WHERE A.tip_stock = ' || en_tipstock
         || 'AND a.cod_articulo = ' || en_codarticulo || 'AND a.cod_uso = ' || en_codusoventa || 'AND a.cod_estado = ' || en_codestado || 'AND a.cod_modventa = ' || en_modventa || 'AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)'
         || 'AND b.cod_articulo = a.cod_articulo' || 'AND c.cod_moneda = a.cod_moneda' || 'AND a.ind_recambio = ' || en_indrecambio || 'AND a.num_meses = xy.meses' || 'AND a.cod_categoria = z.categoria' || 'AND a.cod_uso <> ' || en_codusoprepago
         || 'AND b.ind_equiacc = ' || ev_indequipo
         || 'AND t.cod_calificacion = ' || cv_cod_calificacion || ' AND t.cod_promedio = 0';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM al_precios_venta a, al_articulos b, ge_monedas c, (SELECT w.cod_categoria categoria
                                                                  FROM ve_catplantarif v, ve_categorias w
                                                                 WHERE v.cod_plantarif = ev_plantarif AND v.cod_categoria = w.cod_categoria) z, (SELECT p.num_meses meses
                                                                                                                                                   FROM ga_percontrato p
                                                                                                                                                  WHERE p.cod_producto > 0 AND p.cod_tipcontrato = ev_tipocontrato) xy
       WHERE a.tip_stock = en_tipstock AND a.cod_articulo = en_codarticulo AND a.cod_uso = en_codusoventa AND a.cod_estado = en_codestado AND a.cod_modventa = en_modventa AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
             AND b.cod_articulo = a.cod_articulo AND c.cod_moneda = a.cod_moneda AND a.ind_recambio = en_indrecambio                                                                                                                           -- constante (0)
             AND a.num_meses = xy.meses AND a.cod_categoria = z.categoria --AND a.cod_uso <> en_codusoprepago                                                                                                                                    -- constante (3)
             AND b.ind_equiacc = ev_indequipo                                                                                                                                                                                                  -- cisntante (E)
             AND a.cod_calificacion = cv_cod_calificacion AND a.cod_promedio = 0 --CSR-11002
             AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT b.cod_conceptoart, b.des_articulo, a.prc_venta, a.cod_moneda, c.des_moneda, NVL (a.val_minimo, 0), NVL (a.val_maximo, 0), 'A'                                                                             -- tipo cargo [ Automatico o Manual ]
                                                                                                                                             ,
                '1'                                                                                                                                                                                                                          -- numero unidades
                   ,
                '1'                                                                                                                                                                                                                              -- ind. equipo
                   ,
                '0'                                                                                                                                                                                                                             -- ind. paquete
                   ,
                b.mes_garantia, '0'                                                                                                                                                                                                           -- ind. accesorio
                                   ,
                '0'                                                                                                                                                                                                                            -- cod. articulo
                   ,
                '0'                                                                                                                                                                                                                               -- cod. stock
                   ,
                '0'                                                                                                                                                                                                                              -- cod. estado
           FROM al_precios_venta a, al_articulos b, ge_monedas c, (SELECT w.cod_categoria categoria
                                                                     FROM ve_catplantarif v, ve_categorias w
                                                                    WHERE v.cod_plantarif = ev_plantarif AND v.cod_categoria = w.cod_categoria) z, (SELECT p.num_meses meses
                                                                                                                                                      FROM ga_percontrato p
                                                                                                                                                     WHERE p.cod_producto > 0 AND p.cod_tipcontrato = ev_tipocontrato) xy
          WHERE a.tip_stock = en_tipstock AND a.cod_articulo = en_codarticulo AND a.cod_uso = en_codusoventa AND a.cod_estado = en_codestado AND a.cod_modventa = en_modventa AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
                AND b.cod_articulo = a.cod_articulo AND c.cod_moneda = a.cod_moneda AND a.ind_recambio = en_indrecambio                                                                                                                        -- constante (0)
                AND a.num_meses = xy.meses AND a.cod_categoria = z.categoria --AND a.cod_uso <> en_codusoprepago                                                                                                                                 -- constante (3)
                AND b.ind_equiacc = ev_indequipo
                AND a.cod_calificacion = cv_cod_calificacion AND a.cod_promedio = 0; --CSR-11002                                                                                                                                                                                             -- cisntante (E)

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10772;                                                                                                                                                                                                                      --SQLCODE;
         sv_mens_retorno := 'Error al Obtener Precio Cargo de Simcard. No Precio de Lista.';
         lv_des_error    :='no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarSimcard_NoPreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_modventa || ',' || ev_tipocontrato || ',' || ev_plantarif || ','
            || en_indrecambio || ',' || ev_codcategoria || ',' || en_codusoprepago || ',' || ev_indequipo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarSimcard_NoPreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11109;
         sv_mens_retorno := 'error al consultar precio cargo de simcard(No Precio de Lista)';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarSimcard_NoPreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_modventa || ',' || ev_tipocontrato || ',' || ev_plantarif || ','
            || en_indrecambio || ',' || ev_codcategoria || ',' || en_codusoprepago || ',' || ev_indequipo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarSimcard_NoPreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_precarsimcard_noprelis_pr;

   PROCEDURE ve_precarterminal_noprelis_pr (
      en_codarticulo     IN              al_precios_venta.cod_articulo%TYPE,
      en_tipstock        IN              al_precios_venta.tip_stock%TYPE,
      en_codusoventa     IN              al_precios_venta.cod_uso%TYPE,
      en_codestado       IN              al_precios_venta.cod_estado%TYPE,
      en_modventa        IN              al_precios_venta.cod_modventa%TYPE,
      ev_tipocontrato    IN              ga_percontrato.cod_tipcontrato%TYPE,
      ev_plantarif       IN              ve_catplantarif.cod_plantarif%TYPE,
      en_indrecambio     IN              al_precios_venta.ind_recambio%TYPE,
      ev_codcategoria    IN              al_precios_venta.cod_categoria%TYPE,
      en_codusoprepago   IN              al_precios_venta.cod_uso%TYPE,
      ev_indequipo       IN              al_articulos.ind_equiacc%TYPE,
      sc_cursordatos     OUT NOCOPY      refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_PreCarTerminal_NoPreLis_PR"
         Lenguaje="PL/SQL"
         Fecha="05-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
          <Descripcion>
                     OBTIENE PRECIO CARGO DE TERMINAL. NO PRECIO DE LISTA.
          </Descripcion>
      <Parametros>
        <Entrada>
              <param nom="EN_codarticulo"   Tipo="NUMBER"> codigo articulo </param>
        </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
             <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
             <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
             <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT  b.cod_conceptoart' || ',b.des_articulo' || ',a.prc_venta' || ',a.cod_moneda' || ',c.des_moneda' || ',NVL(a.val_minimo,0)' || ',NVL(a.val_maximo,0)' || ',''A'' ' || ',''1'' ' || ',''1'' ' || ',''0'' ' || ',b.mes_garantia' || ',''0'' '
         || ',''0'' ' || ',''0'' ' || ',''0'' ' || 'FROM al_precios_venta a' || ',al_articulos b' || ',ge_monedas c' || ',(SELECT w.cod_categoria categoria' || 'FROM ve_catplantarif v, ve_categorias w' || 'WHERE v.cod_plantarif =' || ev_plantarif
         || 'AND v.cod_categoria = w.cod_categoria) z' || ',(SELECT p.num_meses meses ' || 'FROM ga_percontrato p' || 'WHERE p.cod_producto > 0' || 'AND p.cod_tipcontrato = ' || ev_tipocontrato || ') xy' || 'WHERE A.tip_stock = ' || en_tipstock
         || 'AND a.cod_articulo = ' || en_codarticulo || 'AND a.cod_uso = ' || en_codusoventa || 'AND a.cod_estado = ' || en_codestado || 'AND a.cod_modventa = ' || en_modventa || 'AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE)'
         || 'AND b.cod_articulo = a.cod_articulo' || 'AND c.cod_moneda = a.cod_moneda' || 'AND a.ind_recambio = ' || en_indrecambio || 'AND a.num_meses = xy.meses' || 'AND a.cod_categoria = z.categoria' || 'AND a.cod_uso <> ' || en_codusoprepago
         || 'AND b.ind_equiacc = ' || ev_indequipo || ' AND t.cod_calificacion = ' || cv_cod_calificacion || ' AND t.cod_promedio = 0 ';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM al_precios_venta a, al_articulos b, ge_monedas c, (SELECT w.cod_categoria categoria
                                                                  FROM ve_catplantarif v, ve_categorias w
                                                                 WHERE v.cod_plantarif = ev_plantarif AND v.cod_categoria = w.cod_categoria) z, (SELECT p.num_meses meses
                                                                                                                                                   FROM ga_percontrato p
                                                                                                                                                  WHERE p.cod_producto > 0 AND p.cod_tipcontrato = ev_tipocontrato) xy
       WHERE a.tip_stock = en_tipstock AND a.cod_articulo = en_codarticulo AND a.cod_uso = en_codusoventa AND a.cod_estado = en_codestado AND a.cod_modventa = en_modventa AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
             AND b.cod_articulo = a.cod_articulo AND c.cod_moneda = a.cod_moneda AND a.ind_recambio = en_indrecambio                                                                                                                           -- constante (0)
             AND a.num_meses = xy.meses AND a.cod_categoria = z.categoria AND a.cod_uso <> en_codusoprepago                                                                                                                                    -- constante (3)
             AND b.ind_equiacc = ev_indequipo                                                                                                                                                                                                  -- cisntante (E)
             AND a.cod_calificacion = cv_cod_calificacion AND a.cod_promedio = 0--CSR-11002
             AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT b.cod_conceptoart, b.des_articulo, a.prc_venta, a.cod_moneda, c.des_moneda, NVL (a.val_minimo, 0), NVL (a.val_maximo, 0), 'A'                                                                             -- tipo cargo [ Automatico o Manual ]
                                                                                                                                             ,
                '1'                                                                                                                                                                                                                          -- numero unidades
                   ,
                '1'                                                                                                                                                                                                                              -- ind. equipo
                   ,
                '0'                                                                                                                                                                                                                             -- ind. paquete
                   ,
                b.mes_garantia, '0'                                                                                                                                                                                                           -- ind. accesorio
                                   ,
                '0'                                                                                                                                                                                                                            -- cod. articulo
                   ,
                '0'                                                                                                                                                                                                                               -- cod. stock
                   ,
                '0'                                                                                                                                                                                                                              -- cod. estado
           FROM al_precios_venta a, al_articulos b, ge_monedas c, (SELECT w.cod_categoria categoria
                                                                     FROM ve_catplantarif v, ve_categorias w
                                                                    WHERE v.cod_plantarif = ev_plantarif AND v.cod_categoria = w.cod_categoria) z, (SELECT p.num_meses meses
                                                                                                                                                      FROM ga_percontrato p
                                                                                                                                                     WHERE p.cod_producto > 0 AND p.cod_tipcontrato = ev_tipocontrato) xy
          WHERE a.tip_stock = en_tipstock AND a.cod_articulo = en_codarticulo AND a.cod_uso = en_codusoventa AND a.cod_estado = en_codestado AND a.cod_modventa = en_modventa AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE)
                AND b.cod_articulo = a.cod_articulo AND c.cod_moneda = a.cod_moneda AND a.ind_recambio = en_indrecambio                                                                                                                        -- constante (0)
                AND a.num_meses = xy.meses AND a.cod_categoria = z.categoria AND a.cod_uso <> en_codusoprepago                                                                                                                                 -- constante (3)
                AND b.ind_equiacc = ev_indequipo
                AND a.cod_calificacion = cv_cod_calificacion AND a.cod_promedio = 0; --CSR-11002                                                                                                                                                                                              -- cisntante (E)

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10773;                                                                                                                                                                                                                      --SQLCODE;
         sv_mens_retorno := 'Error al Obtener Precio Cargo de Terminal. No Precio De Lista.';
         lv_des_error    :=  'no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarTerminal_NoPreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_modventa || ',' || ev_tipocontrato || ',' || ev_plantarif || ','
            || en_indrecambio || ',' || ev_codcategoria || ',' || en_codusoprepago || ',' || ev_indequipo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarTerminal_NoPreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := 11110;
         sv_mens_retorno := 'error al consultar precio cargo de terminal(No Precio de Lista)';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarTerminal_NoPreLis_PR(' || en_codarticulo || ',' || en_tipstock || ',' || en_codusoventa || ',' || en_codestado || ',' || en_modventa || ',' || ev_tipocontrato || ',' || ev_plantarif || ','
            || en_indrecambio || ',' || ev_codcategoria || ',' || en_codusoprepago || ',' || ev_indequipo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_PreCarTerminal_NoPreLis_PR(' || en_codarticulo || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_precarterminal_noprelis_pr;

   PROCEDURE ve_precio_cargo_servsupl_pr (
      ev_codproducto    IN              VARCHAR2,
      ev_codservicio    IN              VARCHAR2,
      ev_codplanserv    IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_busca_precio_cargo_servsupl_PR"
         Lenguaje="PL/SQL"
         Fecha="09-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                     CONSULTAR PRECIOS CARGOS SERVICIOS SUPLEMETARIOS
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
         <param nom="EV_codcargo"    Tipo="VARCHAR2"> codigo del cargo</param>
      </Entrada>
      <Salida>
         <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT ' || ' a.cod_concepto' || ' ,c.des_servicio' || ' ,b.imp_tarifa' || ' ,b.cod_moneda' || ' ,d.des_moneda' || ' ,c.ind_autman' || ',''1'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' '
         || ' FROM ga_actuaserv a, ga_tarifas b, ga_servsupl c, ge_monedas d' || ' WHERE a.cod_producto = ' || ev_codproducto || ' AND a.cod_actabo = ' || ev_codactuacion || ' AND a.cod_tipserv = ' || cv_servsuplementario                             -- 2
         || ' AND a.cod_servicio = ' || ev_codservicio || ' AND b.cod_producto = a.cod_producto' || ' AND b.cod_actabo = a.cod_actabo' || ' AND b.cod_tipserv = a.cod_tipserv' || ' AND b.cod_servicio = a.cod_servicio' || ' AND b.cod_planserv = '
         || ev_codplanserv || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)' || ' AND d.cod_moneda = b.cod_moneda' || ' AND c.cod_producto = a.cod_producto' || ' AND c.cod_servicio = a.cod_servicio';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_actuaserv a, ga_tarifas b, ga_servsupl c, ge_monedas d
       WHERE a.cod_producto = ev_codproducto AND a.cod_actabo = ev_codactuacion AND a.cod_tipserv = cv_servsuplementario AND a.cod_servicio = ev_codservicio AND b.cod_producto = a.cod_producto AND b.cod_actabo = a.cod_actabo
             AND b.cod_tipserv = a.cod_tipserv AND b.cod_servicio = a.cod_servicio AND b.cod_planserv = ev_codplanserv AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND d.cod_moneda = b.cod_moneda AND c.cod_producto = a.cod_producto
             AND c.cod_servicio = a.cod_servicio AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT a.cod_concepto, c.des_servicio, b.imp_tarifa, b.cod_moneda, d.des_moneda, c.ind_autman                                                                                                                    -- tipo cargo [ Automatico o Manual ]
                                                                                                      ,
                '1'                                                                                                                                                                                                                          -- numero unidades
                   ,
                '0'                                                                                                                                                                                                                              -- ind. equipo
                   ,
                '0'                                                                                                                                                                                                                             -- ind. paquete
                   ,
                '0'                                                                                                                                                                                                                             -- mes garantia
                   ,
                '0'                                                                                                                                                                                                                           -- ind. accesorio
                   ,
                '0'                                                                                                                                                                                                                            -- cod. articulo
                   ,
                '0'                                                                                                                                                                                                                               -- cod. stock
                   ,
                '0'                                                                                                                                                                                                                              -- cod. estado
           FROM ga_actuaserv a, ga_tarifas b, ga_servsupl c, ge_monedas d
          WHERE a.cod_producto = ev_codproducto AND a.cod_actabo = ev_codactuacion AND a.cod_tipserv = cv_servsuplementario                                                                                                                                -- 2
                AND a.cod_servicio = ev_codservicio AND b.cod_producto = a.cod_producto AND b.cod_actabo = a.cod_actabo AND b.cod_tipserv = a.cod_tipserv AND b.cod_servicio = a.cod_servicio AND b.cod_planserv = ev_codplanserv
                AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND d.cod_moneda = b.cod_moneda AND c.cod_producto = a.cod_producto AND c.cod_servicio = a.cod_servicio;

       IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;


   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'Error Al Consultar Precios Cargos Servicios Suplemetarios';
         lv_des_error    := 'DATA:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servsupl_PR(' || ev_codservicio || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servsupl_PR(' || ev_codservicio || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno := 11112;
         sv_mens_retorno := 'Error Al Consultar Precios Cargos Servicios Suplemetarios';
         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servsupl_PR(' || ev_codservicio || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servsupl_PR(' || ev_codservicio || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_precio_cargo_servsupl_pr;

   PROCEDURE ve_consulta_categ_ptarif_pr (
      ev_plantarif      IN              ta_plantarif.cod_plantarif%TYPE,
      sv_codcategoria   OUT NOCOPY      ve_catplantarif.cod_categoria%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VVE_consulta_categ_ptarif_PR
         Lenguaje="PL/SQL"
         Fecha="30-03-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                     CONSULTA CATEGORIA DE UN PLAN TARIFARIO.
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_plantarif"    Tipo="VARCHAR2"> codigo plan tarifario a consultar</param>
      </Entrada>
      <Salida>
         <param nom="SV_codcategoria" Tipo="VARCHAR2"> codigo categoria plan tarifario </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT catplan.cod_categoria' || ' FROM   ve_catplantarif catplan' || ' WHERE    catplan.cod_plantarif=' || ev_plantarif;

      SELECT catplan.cod_categoria
        INTO sv_codcategoria
        FROM ve_catplantarif catplan
       WHERE catplan.cod_plantarif = ev_plantarif;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11112;
         sv_mens_retorno := 'error al consultar categoria del plan tarifario';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG. VE_consulta_categ_ptarif_PR(' || ev_plantarif || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG. VE_consulta_categ_ptarif_PR(' || ev_plantarif || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11112;
         sv_mens_retorno := 'error al consultar categoria del plan tarifario';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG. VE_consulta_categ_ptarif_PR(' || ev_plantarif || ');- ' || SQLERRM;
         sn_num_evento    := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG. VE_consulta_categ_ptarif_PR(' || ev_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_categ_ptarif_pr;

   PROCEDURE ve_obtiene_parametro_fact_pr (
      ev_nomparametro   IN              ged_parametros.nom_parametro%TYPE,
      sv_valparametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_parametro_fact_PR"
         Lenguaje="PL/SQL"
         Fecha="11-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna el valor del parametro
      </Descripcion>
      <Parametros>
      <Entrada> NA </Entrada>
      <Salida> NA </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT parametros.' || ev_nomparametro || ' FROM    fa_datosgener parametros';

      EXECUTE IMMEDIATE lv_sql
                   INTO sv_valparametro;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11113;
         sv_mens_retorno := 'error al consultar parametro';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_parametro_fact_PR(' || ev_nomparametro || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_parametro_fact_PR(' || ev_nomparametro || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11113;
         sv_mens_retorno := 'error al consultar parametro';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_parametro_fact_PR(' || ev_nomparametro || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_parametro_fact_PR(' || ev_nomparametro || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_parametro_fact_pr;

   PROCEDURE ve_obtiene_codpromedio_fact_pr (
      en_valpromfact    IN              al_promfact.fact_desde%TYPE,
      sn_codpromedio    OUT NOCOPY      al_promfact.cod_promedio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_codpromedio_fact_PR"
         Lenguaje="PL/SQL"
         Fecha="11-04-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna el valor del parametro
      </Descripcion>
      <Parametros>
      <Entrada> NA </Entrada>
      <Salida> NA </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT promfact.cod_promedio' || ' FROM al_promfact promfact' || ' WHERE ' || en_valpromfact || ' BETWEEN promfact.fact_desde AND promfact.fact_hasta';

      SELECT promfact.cod_promedio
        INTO sn_codpromedio
        FROM al_promfact promfact
       WHERE en_valpromfact BETWEEN promfact.fact_desde AND promfact.fact_hasta;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11114;
         sv_mens_retorno := 'Error Al Consultar Codigo Promedio';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codpromedio_fact_PR(' || en_valpromfact || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codpromedio_fact_PR(' || en_valpromfact || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11114;
         sv_mens_retorno := 'Error Al Consultar Codigo Promedio';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codpromedio_fact_PR(' || en_valpromfact || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codpromedio_fact_PR(' || en_valpromfact || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_codpromedio_fact_pr;

   PROCEDURE ve_promfacturadocliente_pr (
      en_indciclo         IN              fa_tipdocumen.ind_ciclo%TYPE,
      en_numeromeses      IN              NUMBER,
      en_codcliente       IN              fa_histdocu.cod_cliente%TYPE,
      sn_totalfacturado   OUT NOCOPY      NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
         /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_promfacturadocliente_PR
         Lenguaje="PL/SQL"
         Fecha="11-04-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna promedio de lo facturado por cliente
      </Descripcion>
      <Parametros>
      <Entrada> NA </Entrada>
      <Salida> NA </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT ROUND(SUM(tot_factura)/DECODE(COUNT(*),0,1,COUNT(*)))' || ' FROM fa_histdocu' || ' WHERE cod_tipdocum IN' || ' (SELECT cod_tipdocummov FROM fa_tipdocumen WHERE ind_ciclo =' || en_indciclo || ') AND' || ' fec_emision BETWEEN SYSDATE - ('
         || en_numeromeses || ' * 30) AND SYSDATE AND' || ' cod_cliente = ' || en_codcliente;

      SELECT ROUND (SUM (tot_factura) / DECODE (COUNT (*), 0, 1, COUNT (*)))
        INTO sn_totalfacturado
        FROM fa_histdocu
       WHERE cod_tipdocum IN (SELECT cod_tipdocummov
                                FROM fa_tipdocumen
                               WHERE ind_ciclo = en_indciclo) AND fec_emision BETWEEN SYSDATE - (en_numeromeses * 30) AND SYSDATE AND cod_cliente = en_codcliente;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11115;
         sv_mens_retorno := 'Error Al Consultar Promedio De Lo Facturado Por Cliente';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_promfacturadocliente_PR(' || en_indciclo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_promfacturadocliente_PR(' || en_indciclo || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := 11115;
         sv_mens_retorno := 'Error Al Consultar Promedio De Lo Facturado Por Cliente';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_promfacturadocliente_PR(' || en_indciclo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_promfacturadocliente_PR(' || en_indciclo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_promfacturadocliente_pr;

   PROCEDURE ve_valida_codigo_vendedor_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_valida_codigo_vendedor_PR"
         Lenguaje="PL/SQL"
         Fecha="10-04-2007"
         Version="1.0.0"
         Dise?ador="Mario Tigua"
         Programador="Mario Tigua"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna 1 si el vendedor asociado al codigo de vendedor existe en el sistema, 0 de lo contrario
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EN_cod_vendedor" Tipo="NUMBER"> codigo vendedor/param>
      </Entrada>
      <Salida>
                <param nom="SB_RESULTADO" Tipo="PLS_INTEGER">resultado de la consulta</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>

         */
      lv_resultado   VARCHAR2 (1);
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ln_contador    NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT 1'                                                                                                                                                                                                       --'SELECT ''' || '1' || ''''
                 || 'FROM   VE_VENDEDORES' || 'WHERE COD_VENDEDOR = ' || en_cod_vendedor || 'AND VE_INDBLOQUEO !=' || cn_indbloqueo || 'AND COD_ESTADO =' || cn_estado;

      SELECT '1'
        INTO lv_resultado
        FROM ve_vendedores
       WHERE cod_vendedor = en_cod_vendedor;

      --AND VE_INDBLOQUEO != CN_INDBLOQUEO
      --AND COD_ESTADO = CN_ESTADO;
      sn_resultado := 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_resultado    := 0;
         sn_cod_retorno  := 10774;
         sv_mens_retorno := 'Error al Consultar por Codigo de Vendedor';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.SE_valida_codigo_vendedor_PR(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.SE_valida_codigo_vendedor_PR(' || en_cod_vendedor || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_resultado    := 0;
         sn_cod_retorno  := 11116;
         sv_mens_retorno := 'Error Al Validar El Codigo De Vendedor';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.SE_valida_codigo_vendedor_PR(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.SE_valida_codigo_vendedor_PR(' || en_cod_vendedor || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_valida_codigo_vendedor_pr;

   PROCEDURE ve_consulta_ciclo_fact_pr (
      en_cod_ciclo      IN              ge_clientes.cod_ciclo%TYPE,
      sn_cod_ciclfact   OUT NOCOPY      fa_ciclfact.cod_ciclfact%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_ciclo_fact_PR
         Lenguaje="PL/SQL"
         Fecha="19-04-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna ciclo facturacion, segun ciclo asociado al cliente
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EN_cod_ciclo"    Tipo="NUMBER"> codigo ciclo asociado a cliente/param>
      </Entrada>
      <Salida>
                <param nom="SN_cod_ciclfact" Tipo="NUMBER"> codigo ciclo facturacion encontrado </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT ciclofact.cod_ciclfact' || ' FROM fa_ciclfact ciclofact' || ' WHERE ciclofact.cod_ciclo =' || en_cod_ciclo || ' AND SYSDATE BETWEEN ciclofact.fec_desdeocargos AND NVL(ciclofact.fec_hastaocargos, SYSDATE)';

      SELECT ciclofact.cod_ciclfact
        INTO sn_cod_ciclfact
        FROM fa_ciclfact ciclofact
       WHERE ciclofact.cod_ciclo = en_cod_ciclo AND SYSDATE BETWEEN ciclofact.fec_desdeocargos AND NVL (ciclofact.fec_hastaocargos, SYSDATE);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11117;
         sv_mens_retorno := 'Error Al Consultar Ciclo De Facturacion';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_ciclo_fact_PR(' || en_cod_ciclo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_ciclo_fact_PR(' || en_cod_ciclo || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11117;
         sv_mens_retorno := 'Error Al Consultar Ciclo De Facturacion';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_ciclo_fact_PR(' || en_cod_ciclo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_ciclo_fact_PR(' || en_cod_ciclo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ciclo_fact_pr;

   PROCEDURE ve_obtiene_formas_pago_pr (
      ev_cod_orden        IN              ged_parametros.cod_producto%TYPE,
      ev_planfreedom      IN              VARCHAR,
      ev_cattribcliente   IN              VARCHAR,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_formas_pago_PR"
         Lenguaje="PL/SQL"
         Fecha="25-04-2007"
         Version="1.0.0"
         Dise?ador="Mario Tigua"
         Programador="Mario Tigua"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Recupera formas de pago para la venta
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EV_cod_orden"    Tipo="NUMBER"> codigo ciclo asociado a cliente/param>
         <param nom="EV_planfreedom"    Tipo="VARCHAR">valor que indica si la venta tiene planes freedom /param>
         <param nom="EV_cattribcliente"    Tipo="VARCHAR">categoria tributaria del cliente/param>
      </Entrada>
      <Salida>
         <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con formas de pago seleccionados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_sql                 ge_errores_pg.vquery;
      lv_des_error           ge_errores_pg.desevent;
      lv_modulo              VARCHAR (20);
      lv_nomtabla            VARCHAR (20);
      lv_nomcolumna          VARCHAR (20);
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_modulo := 'GA';
      lv_nomtabla := 'CO_TIPVALOR_FREED';
      lv_nomcolumna := 'TIP_VALOR';
      ln_contador := 0;
      lv_sql := 'SELECT a.tip_valor, a.des_tipvalor ';

      IF (ev_planfreedom = 'TRUE') THEN
         lv_sql := lv_sql || ' FROM co_tipvalor a, ged_codigos b ';
         lv_sql := lv_sql || ' WHERE b.cod_modulo = ''' || lv_modulo || '''';
         lv_sql := lv_sql || ' AND b.nom_tabla = ''' || lv_nomtabla || '''';
         lv_sql := lv_sql || ' AND b.nom_columna = ''' || lv_nomcolumna || '''';

         IF (ev_cattribcliente = 'BOLETA' AND ev_cod_orden IS NOT NULL) THEN
            lv_sql := lv_sql || ' AND a.tip_valor = ' || ev_cod_orden;

            SELECT COUNT (1)
              INTO ln_contador
              FROM co_tipvalor a, ged_codigos b
             WHERE b.cod_modulo = lv_modulo AND b.nom_tabla = lv_nomtabla AND b.nom_columna = lv_nomcolumna AND a.tip_valor = ev_cod_orden AND ROWNUM <= 1;                                                                       --reduce costo de la consulta
         ELSE
            SELECT COUNT (1)
              INTO ln_contador
              FROM co_tipvalor a, ged_codigos b
             WHERE b.cod_modulo = lv_modulo AND b.nom_tabla = lv_nomtabla AND b.nom_columna = lv_nomcolumna AND ROWNUM <= 1;                                                                                                      --reduce costo de la consulta
         END IF;
      ELSE
         lv_sql := lv_sql || ' FROM co_tipvalor a ';

         IF (ev_cattribcliente = 'BOLETA' AND ev_cod_orden IS NOT NULL) THEN
            lv_sql := lv_sql || ' WHERE a.tip_valor = ' || ev_cod_orden;

            SELECT COUNT (1)
              INTO ln_contador
              FROM co_tipvalor a
             WHERE a.tip_valor = ev_cod_orden AND ROWNUM <= 1;
         ELSE
            SELECT COUNT (1)
              INTO ln_contador
              FROM co_tipvalor a
             WHERE ROWNUM <= 1;
         END IF;
      END IF;

      OPEN sc_cursordatos FOR lv_sql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 10775;
         sv_mens_retorno :='Error Al Intentar Obtener Formas De Pago';
         lv_des_error    := 'no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_formas_pago_PR(' || ev_cod_orden || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_formas_pago_PR(' || ev_cod_orden || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11118;
         sv_mens_retorno := 'Error Al Consultar Formas De Pago';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_formas_pago_PR(' || ev_cod_orden || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_formas_pago_PR(' || ev_cod_orden || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_formas_pago_pr;

   PROCEDURE ve_obtiene_descuento_art_pr (
      ev_cod_operacion      IN              gad_descuentos.cod_operacion%TYPE,
      ev_tip_contactual     IN              gad_descuentos.tip_contrato_actual%TYPE,
      en_num_mesesactual    IN              gad_descuentos.num_meses_actual%TYPE,
      ev_cod_antiguedad     IN              gad_descuentos.cod_antiguedad%TYPE,
      en_cod_promediofact   IN              gad_descuentos.cod_promfact%TYPE,
      ev_cod_estadodev      IN              gad_descuentos.cod_estado_dev%TYPE,
      ev_cod_tipcontnuevo   IN              gad_descuentos.cod_tipcontrato_nuevo%TYPE,
      en_num_mesesnuevo     IN              gad_descuentos.num_meses_nuevo%TYPE,
      en_cod_articulo       IN              gad_descuentos.cod_articulo%TYPE,
      ev_clase_descuento    IN              gad_descuentos.clase_descuento%TYPE,
      sc_cursordatos        OUT NOCOPY      refcursor,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_descuento_art_PR
         Lenguaje="PL/SQL"
         Fecha="24-04-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta descuentos tipo articulo asociado a los cargos de la venta
         de tipo Articulo (ART segun VB)
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EV_cod_operacion" Tipo="VARCHAR2"> codigo operacion, cambio serie, restitucion, anulacion.</param>
         <param nom="EV_tip_contactual"    Tipo="VARCHAR2"> tipo de contrato</param>
         <param nom="EN_num_mesesactual"    Tipo="NUMBER"> numero de meses actuales</param>
         <param nom="EV_cod_antiguedad    Tipo="VARCHAR2"> codigo de antiguedad/param>
         <param nom="EN_cod_promediofact"    Tipo="NUMBER"> promedio de facturacion</param>
         <param nom="EV_cod_estadodev"    Tipo="VARCHAR2"> estado de devolucion</param>
         <param nom="EV_cod_tipcontnuevo"    Tipo="VARCHAR2"> contrato nuevo</param>
         <param nom="EN_num_mesesnuevo"    Tipo="NUMBER"> numero de meses nuevos</param>
         <param nom="EN_cod_articulo"    Tipo="NUMBER"> codigo articulo</param>
         <param nom="EV_clase_descuento"    Tipo="VARCHAR2"> Clasificacion del registro: Dscto por articulo o dscto por concepto facturable</param>

      </Entrada>
      <Salida>
         <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con descuentos de cargos basicos encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_sql                 ge_errores_pg.vquery;
      lv_des_error           ge_errores_pg.desevent;
      lv_concepto            VARCHAR2 (4);
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT descuentos.tip_descuento, descuentos.cod_moneda,'
             || ' descuentos.val_descuento'
             || ' FROM   gad_descuentos descuentos'
             || ' WHERE  descuentos.cod_operacion = ''' || ev_cod_operacion || ''''
             || ' AND    descuentos.tip_contrato_actual = ''' || ev_tip_contactual || ''''
             || ' AND    descuentos.num_meses_actual = ' || en_num_mesesactual
             || ' AND    descuentos.cod_antiguedad = ''' || ev_cod_antiguedad || ''''
             || ' AND    descuentos.cod_promfact = ' || en_cod_promediofact
             || ' AND    descuentos.cod_estado_dev = ''' || ev_cod_estadodev || ''''
             || ' AND    descuentos.cod_tipcontrato_nuevo = ''' || ev_cod_tipcontnuevo || ''''
             || ' AND    descuentos.num_meses_nuevo = ' || en_num_mesesnuevo;

      IF (en_cod_articulo IS NULL) THEN
         lv_sql := lv_sql || ' AND descuentos.cod_articulo IS NULL';

         SELECT COUNT (1)
           INTO ln_contador
           FROM gad_descuentos descuentos
          WHERE descuentos.cod_operacion = ev_cod_operacion AND descuentos.tip_contrato_actual = ev_tip_contactual AND descuentos.num_meses_actual = en_num_mesesactual AND descuentos.cod_antiguedad = ev_cod_antiguedad
                AND descuentos.cod_promfact = en_cod_promediofact AND descuentos.cod_estado_dev = ev_cod_estadodev AND descuentos.cod_tipcontrato_nuevo = ev_cod_tipcontnuevo AND descuentos.num_meses_nuevo = en_num_mesesnuevo
                AND descuentos.cod_articulo IS NULL AND SYSDATE BETWEEN descuentos.fec_desde AND NVL (descuentos.fec_hasta, SYSDATE) AND descuentos.clase_descuento = ev_clase_descuento AND ROWNUM <= 1;
      ELSE
         lv_sql := lv_sql || ' AND descuentos.cod_articulo = ' || en_cod_articulo;

         SELECT COUNT (1)
           INTO ln_contador
           FROM gad_descuentos descuentos
          WHERE descuentos.cod_operacion = ev_cod_operacion AND descuentos.tip_contrato_actual = ev_tip_contactual AND descuentos.num_meses_actual = en_num_mesesactual AND descuentos.cod_antiguedad = ev_cod_antiguedad
                AND descuentos.cod_promfact = en_cod_promediofact AND descuentos.cod_estado_dev = ev_cod_estadodev AND descuentos.cod_tipcontrato_nuevo = ev_cod_tipcontnuevo AND descuentos.num_meses_nuevo = en_num_mesesnuevo
                AND descuentos.cod_articulo = en_cod_articulo AND SYSDATE BETWEEN descuentos.fec_desde AND NVL (descuentos.fec_hasta, SYSDATE) AND descuentos.clase_descuento = ev_clase_descuento AND ROWNUM <= 1;
      END IF;

      lv_sql := lv_sql || ' AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)' || ' AND descuentos.clase_descuento = ''' || ev_clase_descuento || '''';

      OPEN sc_cursordatos FOR lv_sql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 11119;
         sv_mens_retorno := 'Error Al Consultar Descuento De Articulo';
         lv_des_error    := 'no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_art_PR(' || ev_cod_operacion || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_art_PR(' || ev_cod_operacion || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11119;
         sv_mens_retorno := 'Error Al Consultar Descuento De Articulo';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_art_PR(' || ev_cod_operacion || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_art_PR(' || ev_cod_operacion || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_descuento_art_pr;

   PROCEDURE ve_obtiene_descuento_con_pr (
      ev_cod_operacion      IN              gad_descuentos.cod_operacion%TYPE,
      ev_cod_antiguedad     IN              gad_descuentos.cod_antiguedad%TYPE,
      ev_cod_tipcontnuevo   IN              gad_descuentos.cod_tipcontrato_nuevo%TYPE,
      en_num_mesesnuevo     IN              gad_descuentos.num_meses_nuevo%TYPE,
      en_ind_vtaexterna     IN              gad_descuentos.ind_vta_externa%TYPE,
      en_cod_vendealer      IN              gad_descuentos.cod_vendealer%TYPE,
      ev_cod_causadscto     IN              VARCHAR2,
      ev_cod_categoria      IN              VARCHAR2,
      en_cod_modventa       IN              VARCHAR2,
      en_tip_producto       IN              VARCHAR2,
      en_cod_concepto       IN              VARCHAR2,
      ev_clase_descuento    IN              gad_descuentos.clase_descuento%TYPE,
      sc_cursordatos        OUT NOCOPY      refcursor,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_descuento_con_PR"
         Lenguaje="PL/SQL"
         Fecha="24-04-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 CONSULTA DESCUENTOS TIPO CONCEPTO DE TIPO CONCEPTO
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EV_cod_operacion"     Tipo="VARCHAR2"> codigo operacion, cambio serie, restitucion, anulacion.</param>
         <param nom="EV_cod_antiguedad"    Tipo="VARCHAR2"> codigo de antiguedad/param>
         <param nom="EV_cod_tipcontnuevo"  Tipo="VARCHAR2"> tipo de contrato</param>
         <param nom="EN_num_mesesnuevo"    Tipo="NUMBER"> numero de meses nuevo</param>
         <param nom="EN_ind_vtaexterna"    Tipo="NUMBER"> indicador de vendedor interno o externo/param>
         <param nom="EN_cod_vendealer"     Tipo="NUMBER"> digo de vendedor externo</param>
         <param nom="EV_cod_causadscto"    Tipo="VARCHAR2"> otivo de descuento</param>
         <param nom="EV_cod_categoria      Tipo="VARCHAR2"> categoria del plan</param>
         <param nom="EN_cod_modventa"      Tipo="NUMBER"> Codigo de modalidad de venta</param>
         <param nom="EN_tip_producto"      Tipo="NUMBER"> Tipo de producto asociado al concepto de descuento: Prepago, Pospago, Hibrido/param>
         <param nom="EN_cod_concepto"      Tipo="NUMBER"> Codigo de concepto facturable de tipo cargos</param>
         <param nom="EV_clase_descuento"   Tipo="VARCHAR2"> Clasificacion del registro: Dscto por articulo o dscto por concepto facturable</param>

      </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con descuentos de cargos basicos encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_sql                 ge_errores_pg.vquery;
      lv_des_error           ge_errores_pg.desevent;
      lv_concepto            VARCHAR2 (4);
      lv_tipdescuento        gad_descuentos.tip_descuento%TYPE;
      lv_codmoneda           gad_descuentos.cod_moneda%TYPE;
      ln_valdescuento        gad_descuentos.val_descuento%TYPE;
--      ln_codconcepto         gad_descuentos.cod_concepto_dscto%TYPE;
      ln_contador            NUMBER;
      tip_desc               gad_descuentos.tip_descuento%TYPE;
      val_moneda             gad_descuentos.cod_moneda%TYPE;
      val_desc               gad_descuentos.val_descuento%TYPE;
--      val_concepto           gad_descuentos.cod_concepto_dscto%TYPE;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT descuentos.tip_descuento, descuentos.cod_moneda,'
             || ' descuentos.val_descuento'
             || ' FROM   gad_descuentos descuentos'
             || ' WHERE  descuentos.cod_operacion = ''' || ev_cod_operacion || ''''
             || ' AND descuentos.cod_antiguedad = ''' || ev_cod_antiguedad || ''''
             || ' AND descuentos.cod_tipcontrato_nuevo = ''' || ev_cod_tipcontnuevo || ''''
             || ' AND descuentos.num_meses_nuevo = ' || en_num_mesesnuevo
             || ' AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, sysdate)'
             || ' AND descuentos.ind_vta_externa       = ' || en_ind_vtaexterna;

      IF (en_ind_vtaexterna = 1) THEN
         lv_sql := lv_sql || ' AND descuentos.cod_vendealer = ' || en_cod_vendealer;
      END IF;

      lv_sql := lv_sql || ' AND descuentos.clase_descuento       = ''' || ev_clase_descuento || '''';

      OPEN sc_cursordatos FOR lv_sql;

      FETCH sc_cursordatos
       INTO tip_desc, val_moneda, val_desc;

      IF sc_cursordatos%NOTFOUND THEN
         lv_sql := 'SELECT descuentos.tip_descuento, descuentos.cod_moneda,'
                || ' descuentos.val_descuento'
                || ' FROM   gad_descuentos descuentos'
                || ' WHERE  descuentos.cod_operacion = ''' || ev_cod_operacion || ''''
                || ' AND descuentos.cod_antiguedad = ''' || ev_cod_antiguedad || ''''
                || ' AND descuentos.cod_tipcontrato_nuevo = ''' || ev_cod_tipcontnuevo || ''''
                || ' AND descuentos.num_meses_nuevo = ' || en_num_mesesnuevo
                || ' AND SYSDATE BETWEEN descuentos.fec_desde AND NVL(descuentos.fec_hasta, SYSDATE)'
                || ' AND descuentos.ind_vta_externa       = ' || en_ind_vtaexterna;

         IF (en_ind_vtaexterna = 1) THEN
            lv_sql := lv_sql || ' AND    descuentos.cod_vendealer is  null';
         END IF;

         lv_sql := lv_sql || ' AND descuentos.clase_descuento       = ''' || ev_clase_descuento || '''';

         IF (en_ind_vtaexterna = 1) THEN
            SELECT COUNT (1)
              INTO ln_contador
              FROM gad_descuentos descuentos
             WHERE descuentos.cod_operacion = ev_cod_operacion AND descuentos.cod_antiguedad = ev_cod_antiguedad AND descuentos.cod_tipcontrato_nuevo = ev_cod_tipcontnuevo AND descuentos.num_meses_nuevo = en_num_mesesnuevo
                   AND SYSDATE BETWEEN descuentos.fec_desde AND NVL (descuentos.fec_hasta, SYSDATE) AND descuentos.ind_vta_externa = en_ind_vtaexterna AND descuentos.cod_vendealer IS NULL
                   AND descuentos.clase_descuento = ev_clase_descuento AND ROWNUM <= 1;
         ELSE
            SELECT COUNT (1)
              INTO ln_contador
              FROM gad_descuentos descuentos
             WHERE descuentos.cod_operacion = ev_cod_operacion AND descuentos.cod_antiguedad = ev_cod_antiguedad AND descuentos.cod_tipcontrato_nuevo = ev_cod_tipcontnuevo AND descuentos.num_meses_nuevo = en_num_mesesnuevo
                   AND SYSDATE BETWEEN descuentos.fec_desde AND NVL (descuentos.fec_hasta, SYSDATE) AND descuentos.ind_vta_externa = en_ind_vtaexterna AND descuentos.clase_descuento = ev_clase_descuento AND ROWNUM <= 1;
         END IF;

         OPEN sc_cursordatos FOR lv_sql;

         IF (ln_contador = 0) THEN
            RAISE no_data_found_cursor;
         END IF;
      ELSE
         OPEN sc_cursordatos FOR lv_sql;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 0;
         sv_mens_retorno := 'No Existen Descuentos Configurados';
         lv_des_error    := 'no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_con_PR(' || ev_cod_operacion || ',' || ev_cod_antiguedad || ',' || ev_cod_tipcontnuevo || ',' || en_num_mesesnuevo || ',' || en_ind_vtaexterna || ',' || en_cod_vendealer || ','
            || ev_clase_descuento || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_con_PR(' || ev_cod_operacion || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11120;
         sv_mens_retorno := 'Error Al Consultar Descuento De Tipo Concepto';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_con_PR(' || ev_cod_operacion || ',' || ev_cod_antiguedad || ',' || ev_cod_tipcontnuevo || ',' || en_num_mesesnuevo || ',' || en_ind_vtaexterna || ',' || en_cod_vendealer || ','
            || ev_clase_descuento || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_descuento_con_PR(' || ev_cod_operacion || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_descuento_con_pr;

   PROCEDURE ve_precio_cargo_servocac_pr (
      ev_codproducto    IN              VARCHAR2,
      ev_codarticulo    IN              VARCHAR2,
      ev_codplantarif   IN              VARCHAR2,
      ev_codusolinea    IN              VARCHAR2,
      ev_codmodventa    IN              VARCHAR2,
      ev_nummeses       IN              VARCHAR2,
      ev_tipstock       IN              VARCHAR2,
      ev_indcomodato    IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_busca_precio_cargo_servocac_PR"
         Lenguaje="PL/SQL"
         Fecha="09-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 OBTIENE EL PRECIO DE LOS SERVICIOS OCACIONALES
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_codproducto" Tipo="VARCHAR2"> codigo producto</param>
      </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con precios de cargos simcard encontrados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_codesql             ga_errores.cod_sqlcode%TYPE;
      lv_errmsql             ga_errores.cod_sqlerrm%TYPE;
      ln_numevento           NUMBER;
      lv_sql                 ge_errores_pg.vquery;
      lv_des_error           ge_errores_pg.desevent;
      lv_codmoneda           VARCHAR2 (20);
      lv_codservhab          VARCHAR2 (20);
      no_data_found_cursor   EXCEPTION;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      --  OBTENEMOS EL VALOR PARA CODIOGO MONEDA PESO
     -- ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_monedapeso, cv_modulo_ga, cv_producto, lv_codmoneda, lv_codesql, lv_errmsql, ln_numevento);
      --  OBTENEMOS EL VALOR PARA SERVICIO HABILITACION
    --  ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_servhabili, cv_modulo_ga, cv_producto, lv_codservhab, lv_codesql, lv_errmsql, ln_numevento);
      lv_sql :=
         'SELECT ' || 'a.cod_concepto' || ',c.des_servicio' || ',b.prc_cargo' || ',d.cod_moneda' || ',d.des_moneda' || ',NVL(b.val_minimo,0)' || ',NVL(b.val_maximo,0)' || ',c.ind_autman' || ',''1'' ' || ',''0'' ' || ',''0'' ' || ',''0'' ' || ',''0'' '
         || ',b.ind_venta' || 'FROM ga_actuaserv a, ga_cargos_habilitacion b, ga_servicios c, ge_monedas d' || 'WHERE a.cod_producto = ' || ev_codproducto || ' AND a.cod_actabo = ' || ev_codactuacion || ' AND a.cod_tipserv = '
         || cv_servocasional                                                                                                                                                                                                                  -- constante (1)
         || ' AND a.cod_servicio = ' || lv_codservhab || ' AND b.cod_producto = a.cod_producto' || ' AND b.cod_modventa = ' || ev_codmodventa || ' AND b.cod_uso = ' || ev_codusolinea || ' AND b.tip_stock = ' || ev_tipstock || ' AND b.cod_articulo = '
         || ev_codarticulo || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)' || ' AND b.cod_categoria IN (SELECT s.cod_categoria' || '                         FROM ve_catplantarif s' || '                           WHERE s.cod_producto = '
         || ev_codproducto || '                         AND s.cod_plantarif = ' || ev_codplantarif || ')' || ' AND b.num_meses = ' || ev_nummeses
                                                                                                                                           -- If DatVenta.Ind_Comodato = "1" Then
                                                                                                                                           --     sSql = sSql & " AND B.IND_VENTA = [1]"
                                                                                                                                           -- End If
         || ' AND c.cod_producto = a.cod_producto' || ' AND c.cod_servicio = a.cod_servicio' || ' AND d.cod_moneda = ' || lv_codmoneda;
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_actuaserv a, ga_cargos_habilitacion b, ga_servicios c, ge_monedas d
       WHERE a.cod_producto = ev_codproducto AND a.cod_actabo = ev_codactuacion AND a.cod_tipserv = cv_servocasional                                                                                                                           -- constante (1)
             AND a.cod_servicio = lv_codservhab AND b.cod_producto = a.cod_producto AND b.cod_modventa = ev_codmodventa AND b.cod_uso = ev_codusolinea AND b.tip_stock = ev_tipstock AND b.cod_articulo = ev_codarticulo
             AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND b.cod_categoria IN (SELECT s.cod_categoria
                                                                                                      FROM ve_catplantarif s
                                                                                                     WHERE s.cod_producto = ev_codproducto AND s.cod_plantarif = ev_codplantarif) AND b.num_meses = ev_nummeses
                                                                                                                                                                                                               -- If DatVenta.Ind_Comodato = "1" Then
                                                                                                                                                                                                               --     sSql = sSql & " AND B.IND_VENTA = [1]"
                                                                                                                                                                                                               -- End If
             AND c.cod_producto = a.cod_producto AND c.cod_servicio = a.cod_servicio AND d.cod_moneda = lv_codmoneda AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT a.cod_concepto, c.des_servicio, b.prc_cargo, d.cod_moneda, d.des_moneda, NVL (b.val_minimo, 0), NVL (b.val_maximo, 0), c.ind_autman                                                                       -- tipo cargo [ Automatico o Manual ]
                                                                                                                                                   ,
                '1'                                                                                                                                                                                                                          -- numero unidades
                   ,
                '0'                                                                                                                                                                                                                              -- ind. equipo
                   ,
                '0'                                                                                                                                                                                                                             -- ind. paquete
                   ,
                '0'                                                                                                                                                                                                                             -- mes garantia
                   ,
                '0'                                                                                                                                                                                                                           -- ind. accesorio
                   ,
                b.ind_venta
           FROM ga_actuaserv a, ga_cargos_habilitacion b, ga_servicios c, ge_monedas d
          WHERE a.cod_producto = ev_codproducto AND a.cod_actabo = ev_codactuacion AND a.cod_tipserv = cv_servocasional                                                                                                                        -- constante (1)
                AND a.cod_servicio = lv_codservhab AND b.cod_producto = a.cod_producto AND b.cod_modventa = ev_codmodventa AND b.cod_uso = ev_codusolinea AND b.tip_stock = ev_tipstock AND b.cod_articulo = ev_codarticulo
                AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND b.cod_categoria IN (SELECT s.cod_categoria
                                                                                                         FROM ve_catplantarif s
                                                                                                        WHERE s.cod_producto = ev_codproducto AND s.cod_plantarif = ev_codplantarif) AND b.num_meses = ev_nummeses AND c.cod_producto = a.cod_producto
                AND c.cod_servicio = a.cod_servicio AND d.cod_moneda = lv_codmoneda;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 11121;
         sv_mens_retorno := 'Error Al Obtener Precio De Los Servicios Ocacionales';
         lv_des_error    := 'no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servocac_PR(' || ev_codarticulo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servocac_PR(' || ev_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11121;
         sv_mens_retorno := 'Error Al Obtener Precio De Los Servicios Ocacionales';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servocac_PR(' || ev_codarticulo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_precio_cargo_servocac_PR(' || ev_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_precio_cargo_servocac_pr;

   PROCEDURE ve_obtiene_cat_trib_cliente_pr (
      en_cod_cliente        IN              ga_catributclie.cod_cliente%TYPE,
      sv_cat_trib_cliente   OUT NOCOPY      VARCHAR,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = VE_obtiene_cat_trib_cliente_PR"
         Lenguaje="PL/SQL"
         Fecha="25-04-2007"
         Version="1.0.0"
         Dise?ador="Mario Tigua"
         Programador="Mario Tigua"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna la categoria tributaria del cliente
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMBER">Codigo del cliente>
      </Entrada>
      <Salida>
                <param nom="SV_cat_trib_cliente" Tipo="VARCHAR">categoria tributaria del cliente</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
         */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT a.cod_catribut' || 'INTO SV_cat_trib_cliente' || 'FROM ga_catributclie a' || 'WHERE a.cod_cliente = ' || en_cod_cliente || 'AND SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';

      SELECT a.cod_catribut
        INTO sv_cat_trib_cliente
        FROM ga_catributclie a
       WHERE a.cod_cliente = en_cod_cliente AND SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE);

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sv_cat_trib_cliente := NULL;
         sn_cod_retorno  := 10776;
         sv_mens_retorno := 'Error al obtener Categoria Tributaria del Cliente';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_cat_trib_cliente_PR(' || en_cod_cliente || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_cat_trib_cliente_PR(' || en_cod_cliente || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sv_cat_trib_cliente := NULL;
         sn_cod_retorno      := 11122;
         sv_mens_retorno     := 'Error Al Consultar La Categoria Tributaria Del Cliente';
         lv_des_error        := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_cat_trib_cliente_PR(' || en_cod_cliente || ');- ' || SQLERRM;
         sn_num_evento       := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_cat_trib_cliente_PR(' || en_cod_cliente || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_obtiene_cat_trib_cliente_pr;

   PROCEDURE ve_hay_pfreedom_en_venta_pr (
      ev_ind_proporvta   IN              VARCHAR,
      en_num_venta       IN              NUMBER,
      en_ind_proporc1    IN              NUMBER,
      en_ind_proporc2    IN              NUMBER,
      sn_resultado       OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = VE_hay_pfreedom_en_venta_PR"
         Lenguaje="PL/SQL"
         Fecha="25-04-2007"
         Version="1.0.0"
         Dise?ador="Mario Tigua"
         Programador="Mario Tigua"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
                 RETORNA 1 SI LA VENTA ACTUAL TIENE PLANES FREEDOM, 0 DE LO CONTRARIO
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EV_ind_proporvta" Tipo="VARCHAR">Indicador de proporcionalidad de venta/param>
            <param nom="EN_num_venta" Tipo="NUMBER">Numero de la ventaparam>
            <param nom="EN_ind_proporc1" Tipo="NUMBER">Indicador 1 de proporcionalidad/param>
            <param nom="EN_ind_proporc2" Tipo="NUMBER">Indicador 2 de proporcionalidad/param>
      </Entrada>
      <Salida>
            <param nom="SN_resultado     Tipo="PLS_INTEGER"> Resultado de la consulta </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
         */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT 1' || ' FROM ga_abocel a, ta_plantarif b' || ' WHERE a.num_venta = ' || en_num_venta || ' AND a.cod_plantarif = b.cod_plantarif' || ' AND b.ind_proporcs IN (' || en_ind_proporc1 || ',' || en_ind_proporc2 || ')';

      IF (ev_ind_proporvta = 'TRUE') THEN
         SELECT 1
           INTO sn_resultado
           FROM ga_abocel a, ta_plantarif b
          WHERE a.num_venta = en_num_venta AND a.cod_plantarif = b.cod_plantarif AND b.ind_proporcs IN (en_ind_proporc1, en_ind_proporc2);
      ELSE
         sn_resultado := 0;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_resultado    := 0;
         sn_cod_retorno  := 11122;
         sv_mens_retorno := 'Error Al Consultar Si La Venta Actual Tiene Planes Freedom';    lv_des_error  := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_hay_pfreedom_en_venta_PR(' || ev_ind_proporvta || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_hay_pfreedom_en_venta_PR(' || ev_ind_proporvta || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_resultado    := 0;
         sn_cod_retorno  := 11122;
         sv_mens_retorno := 'Error Al Consultar Si La Venta Actual Tiene Planes Freedom';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_hay_pfreedom_en_venta_PR(' || ev_ind_proporvta || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_hay_pfreedom_en_venta_PR(' || ev_ind_proporvta || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_hay_pfreedom_en_venta_pr;

   PROCEDURE ve_consulta_cod_desc_manual_pr (
      en_cod_conceptocargo   IN              fa_conceptos.cod_concorig%TYPE,
      en_cod_tipconce        IN              fa_conceptos.cod_tipconce%TYPE,
      sn_cod_conceptodcto    OUT NOCOPY      fa_conceptos.cod_concepto%TYPE,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_cod_desc_manual_PR
         Lenguaje="PL/SQL"
         Fecha="27-04-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna codigo concepto facturable del descuento manual asociado al cargo
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EN_cod_conceptocargo"   Tipo="NUMBER"> codigo concepto facturable del cargo</param>
            <param nom="EN_cod_tipconce"   Tipo="NUMBER"> codigo tipo concepto buscado, en este caso el descuento/param>
      </Entrada>
      <Salida>
                <param nom="SN_cod_conceptodcto" Tipo="NUMBER"> codigo concepto facturable del descuento</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT conceptofacturable.cod_concepto' || ' FROM fa_conceptos conceptofacturable' || ' WHERE conceptofacturable.cod_concorig =' || en_cod_conceptocargo || ' AND conceptofacturable.cod_tipconce' || en_cod_tipconce || ' AND ROWNUM = 1';

      SELECT conceptofacturable.cod_concepto
        INTO sn_cod_conceptodcto
        FROM fa_conceptos conceptofacturable
       WHERE conceptofacturable.cod_concorig = en_cod_conceptocargo AND conceptofacturable.cod_tipconce = en_cod_tipconce AND ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10777;
         sv_mens_retorno := 'Problemas al intentar obtener codigo Concepto Facturable';

      WHEN OTHERS THEN
         sn_cod_retorno  := 11123;
         sv_mens_retorno := 'Error Al Consultar Codigo Concepto Facturable';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_cod_desc_manual_PR(' || en_cod_conceptocargo || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_cod_desc_manual_PR(' || en_cod_conceptocargo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_cod_desc_manual_pr;

   PROCEDURE ve_es_vendedor_externo_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sn_resultado      OUT NOCOPY      PLS_INTEGER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_es_vendedor_externo_PR"
         Lenguaje="PL/SQL"
         Fecha="01-05-2007"
         Version="1.0.0"
         Dise?ador=" Mario Tigua"
         Programador=" Mario Tigua"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
          Restorna 1 si el vendedor es externo (dealer), 0 de lo contrario
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EN_cod_vendedor" Tipo="NUMBER"> Codigo del vendedor </param>
      </Entrada>
      <Salida>
            <param nom="SN_resultado Tipo="NUMBER"> Resultado de la validacion </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_ssql        ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
/*mwn70220      lv_ssql := 'SELECT 1' || ' FROM ve_vendedores a,ve_tipcomis b' || ' WHERE a.cod_tipcomis = b.cod_tipcomis' || ' AND a.cod_vendedor = ' || en_cod_vendedor || ' AND b.ind_vta_externa =' || cv_ind_venta_externa;*/

     lv_ssql := 'SELECT 1' || ' FROM ve_vendedores a,ve_tipcomis b' || ' WHERE a.cod_tipcomis = b.cod_tipcomis' || ' AND a.cod_vendedor = ' || en_cod_vendedor ;

      SELECT 1
        INTO sn_resultado
        FROM ve_vendedores a, ve_tipcomis b
       WHERE a.cod_tipcomis = b.cod_tipcomis AND a.cod_vendedor = en_cod_vendedor ;
  
  /*     WHERE a.cod_tipcomis = b.cod_tipcomis AND a.cod_vendedor = en_cod_vendedor AND b.ind_vta_externa = cv_ind_venta_externa;*/
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_resultado    := 0;
         sn_cod_retorno  := 11124;
         sv_mens_retorno := 'Error Al Consultar Si Vendedor Es Externo';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_es_vendedor_externo_PR(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_es_vendedor_externo_PR(' || en_cod_vendedor || ')', lv_ssql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_resultado := 0;
         sn_cod_retorno := 11124;
         sv_mens_retorno := 'Error Al Consultar Si Vendedor Es Externo';
         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_es_vendedor_externo_PR(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_es_vendedor_externo_PR(' || en_cod_vendedor || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_es_vendedor_externo_pr;

   PROCEDURE ve_obtiene_modo_gener_fact_pr (
      ev_cod_oficina      IN              al_docum_sucursal.cod_oficina%TYPE,
      ev_cod_tip_docum    IN              al_docum_sucursal.cod_tipdocum%TYPE,
      ev_factura_global   IN              VARCHAR2,
      en_documento_guia   IN              ge_tipdocumen.cod_tipdocum%TYPE,
      ev_tip_foliacion    IN              ge_tipdocumen.tip_foliacion%TYPE,
      en_cod_tipmovimen   IN              fa_gencentremi.cod_tipmovimien%TYPE,
      ev_cod_cattribut    IN              fa_gencentremi.cod_catribut%TYPE,
      ev_flagcentremi     IN              VARCHAR2,
      en_cod_modventa     IN              fa_gencentremi.cod_modventa%TYPE,
      sv_cod_modgener     OUT NOCOPY      fa_gencentremi.cod_modgener%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_modo_gener_fact_PR
         Lenguaje="PL/SQL"
         Fecha="02-05-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna modo generacion de la facturacion, utilizado para ejecutar el Prebilling
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EV_cod_oficina" Tipo="VARCHAR2"> Codigo oficina de la venta </param>
          <param nom="EV_cod_tip_docum" Tipo="VARCHAR2"> Codigo tipo documento de la venta </param>
          <param nom="EV_factura_global" Tipo="VARCHAR2"> Valor parametro base FACTURA_GLOBAL </param>
          <param nom="EN_documento_guia" Tipo="NUMBER"> Valor parametro base COD_DOCGUIA</param>
          <param nom="EV_tip_foliacion" Tipo="VARCHAR2"> Tipo foliacion documento de la venta </param>
         <param nom="EN_cod_tipmovimen" Tipo="NUMBER"> Tipo Movimiento</param>
         <param nom="EV_cod_cattribut" Tipo="VARCHAR2"> Codigo categoria tributaria documento </param>
          <param nom="EV_flagcentremi" Tipo="VARCHAR2"> Valor parametro FLAG_CENTREMI_FA</param>
         <param nom="EN_cod_modventa" Tipo="NUMBER"> Codigo modalidad de la venta </param>

      </Entrada>
      <Salida>
          <param nom="SV_cod_modgener" Tipo="VARCHAR2"> Codigo modo generacion </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql            ge_errores_pg.vquery;
      lv_des_error      ge_errores_pg.desevent;
      lv_sqlaux         ge_errores_pg.vquery;
      lv_sqlejecutarc   ge_errores_pg.vquery;
      lv_tip_fol        ge_tipdocumen.tip_foliacion%TYPE;
      lv_tip_doc        ge_tipdocumen.cod_tipdocum%TYPE;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
          'SELECT centroemision.cod_modgener FROM fa_gencentremi centroemision' || ' WHERE centroemision.cod_centremi =' || ' (SELECT sucursaldocto.cod_centremi FROM al_docum_sucursal sucursaldocto' || ' WHERE sucursaldocto.cod_oficina =: EV_cod_oficina';

      IF (ev_cod_tip_docum = ev_factura_global) THEN
         lv_sqlaux := 'SELECT tipodocumento.tip_foliacion' || ' FROM  ge_tipdocumen tipodocumento' || ' WHERE tipodocumento.cod_tipdocum = ' || en_documento_guia;

         SELECT tipodocumento.tip_foliacion
           INTO lv_tip_fol
           FROM ge_tipdocumen tipodocumento
          WHERE tipodocumento.cod_tipdocum = en_documento_guia;

         lv_tip_doc := en_documento_guia;
      ELSE
         lv_tip_doc := ev_cod_tip_docum;
         lv_tip_fol := ev_tip_foliacion;
      END IF;

      lv_sql := lv_sql || ' AND sucursaldocto.cod_tipdocum =:LV_tip_doc)' || ' AND centroemision.tip_foliacion =:  LV_tip_fol' || ' AND centroemision.cod_tipmovimien =: EN_cod_tipmovimen' || ' AND centroemision.cod_catribut =: EV_cod_cattribut';
      lv_sqlejecutarc := lv_sql;

      /*loop
          exit when LV_SqlEjecutarc is null;
          dbms_output.put_line( substr( LV_SqlEjecutarc, 1, 250 ) );
          LV_SqlEjecutarc := substr( LV_SqlEjecutarc, 251 );
        end loop;*/
      IF (ev_flagcentremi = '1') THEN
         lv_sql := lv_sql || ' AND centroemision.cod_modventa =: EN_cod_modventa';

         EXECUTE IMMEDIATE lv_sql
                      INTO sv_cod_modgener
                     USING IN ev_cod_oficina, lv_tip_doc, lv_tip_fol, en_cod_tipmovimen, ev_cod_cattribut, en_cod_modventa;
      ELSE
         EXECUTE IMMEDIATE lv_sql
                      INTO sv_cod_modgener
                     USING IN ev_cod_oficina, lv_tip_doc, lv_tip_fol, en_cod_tipmovimen, ev_cod_cattribut;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11125;
         sv_mens_retorno := 'Error Al Consultar Modo Generacion De La Facturacion';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_modo_gener_fact_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_modo_gener_fact_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11125;
         sv_mens_retorno := 'Error Al Consultar Modo Generacion De La Facturacion';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_modo_gener_fact_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_modo_gener_fact_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_modo_gener_fact_pr;

   PROCEDURE ve_in_ga_preliquidacion_pr (
      ev_numventa       IN              ga_preliquidacion.num_venta%TYPE,
      ev_codvendealer   IN              ga_preliquidacion.cod_dealer%TYPE,
      ev_codmaster      IN              ga_preliquidacion.cod_master_dealer%TYPE,
      ev_codcliente     IN              ga_preliquidacion.cod_cliente%TYPE,
      ev_codmodvta      IN              ga_preliquidacion.cod_modventa%TYPE,
      ev_cod_programa   IN              ge_programas.cod_programa%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_modo_gener_fact_PR
         Lenguaje="PL/SQL"
         Fecha="02-05-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna modo generacion de la facturacion, utilizado para ejecutar el Prebilling
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EV_cod_oficina" Tipo="VARCHAR2"> Codigo oficina de la venta </param>
          <param nom="EV_cod_tip_docum" Tipo="VARCHAR2"> Codigo tipo documento de la venta </param>
          <param nom="EV_factura_global" Tipo="VARCHAR2"> Valor parametro base FACTURA_GLOBAL </param>
          <param nom="EN_documento_guia" Tipo="NUMBER"> Valor parametro base COD_DOCGUIA</param>
          <param nom="EV_tip_foliacion" Tipo="VARCHAR2"> Tipo foliacion documento de la venta </param>
         <param nom="EN_cod_tipmovimen" Tipo="NUMBER"> Tipo Movimiento</param>
         <param nom="EV_cod_cattribut" Tipo="VARCHAR2"> Codigo categoria tributaria documento </param>
          <param nom="EV_flagcentremi" Tipo="VARCHAR2"> Valor parametro FLAG_CENTREMI_FA</param>
         <param nom="EN_cod_modventa" Tipo="NUMBER"> Codigo modalidad de la venta </param>

      </Entrada>
      <Salida>
          <param nom="SV_cod_modgener" Tipo="VARCHAR2"> Codigo modo generacion </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_unidades           ga_preliquidacion.num_unidades%TYPE   := 0;
      lv_importe            ga_preliquidacion.imp_venta%TYPE      := 0;
      lv_dias_venc_consig   ged_parametros.val_parametro%TYPE;
      lv_so_matrizestados   ve_tipos_pg.tip_ve_matrizestados_td;
      lv_indestvta          ga_preliquidacion.ind_estventa%TYPE   := NULL;
      lv_fecha_venta        ga_ventas.fec_venta%TYPE;
      lv_des_error          ge_errores_pg.desevent;
      lv_ssql               ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT fec_venta' || ' FROM ga_ventas ' || ' WHERE num_venta = ' || ev_numventa;

      SELECT fec_venta
        INTO lv_fecha_venta
        FROM ga_ventas
       WHERE num_venta = ev_numventa;

      lv_so_matrizestados (1).cod_programa := ev_cod_programa;
      lv_so_matrizestados (1).ind_ofiter := cv_tip_venta_oficina;
      lv_so_matrizestados (1).formulario := cv_form_presu_vta;
      --ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr ('DIAS_VENC_CONSIG', cv_modulo_ga, cv_producto, lv_dias_venc_consig, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      --ve_cierreventa_sb_pg.ve_codigo_procs_venta_pr (lv_so_matrizestados, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
     -- ve_cierreventa_sb_pg.ve_codigo_estfinal_venta_pr (lv_so_matrizestados, lv_fecha_venta, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      lv_indestvta := lv_so_matrizestados (1).cod_estadodestino;
      lv_ssql :=
         'INSERT INTO ga_preliquidacion ( num_venta, cod_dealer,cod_master_dealer,cod_cliente,ind_estventa,' || 'cod_modventa, num_unidades,imp_venta,fec_venta,ind_venta)' || 'VALUES (' || ev_numventa || ',' || ev_codvendealer || ',' || ev_codmaster
         || ',' || ev_codcliente || ',' || lv_indestvta || ',' || ev_codmodvta || ',' || lv_unidades || ',' || lv_importe || ',' || SYSDATE || '+' || lv_dias_venc_consig || ',' || cv_ind_tipo_venta || ')';

      INSERT INTO ga_preliquidacion
                  (num_venta, cod_dealer, cod_master_dealer, cod_cliente, ind_estventa, cod_modventa, num_unidades, imp_venta, fec_venta, ind_venta)
      VALUES      (ev_numventa, ev_codvendealer, ev_codmaster, ev_codcliente, lv_indestvta, ev_codmodvta, lv_unidades, lv_importe, SYSDATE + lv_dias_venc_consig, cv_ind_tipo_venta);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11126;
         sv_mens_retorno := 'Error Al Ingresar Preliquidacion';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_in_ga_preliquidacion_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_in_ga_preliquidacion_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_in_ga_preliquidacion_pr;

   PROCEDURE ve_in_ga_det_preliq_pr (
      en_numventa        IN              ga_preliquidacion.num_venta%TYPE,
      en_numitem         IN              ga_det_preliq.num_item%TYPE,
      en_numabonado      IN              ga_det_preliq.num_abonado%TYPE,
      en_numcelular      IN              ga_det_preliq.num_celular%TYPE,
      ev_numserie        IN              ga_det_preliq.num_serie_orig%TYPE,
      en_impcargo        IN              ga_det_preliq.imp_cargo%TYPE,
      en_impcargofinal   IN              ga_det_preliq.imp_cargo_final%TYPE,
      en_codarticulo     IN              ga_det_preliq.cod_articulo%TYPE,
      en_tipdcto         IN              ga_det_preliq.tip_dto%TYPE,
      en_valdcto         IN              ga_det_preliq.val_dto%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_modo_gener_fact_PR
         Lenguaje="PL/SQL"
         Fecha="02-05-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno> NA </Retorno>
      <Descripcion>
         Retorna modo generacion de la facturacion, utilizado para ejecutar el Prebilling
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EV_cod_oficina" Tipo="VARCHAR2"> Codigo oficina de la venta </param>
          <param nom="EV_cod_tip_docum" Tipo="VARCHAR2"> Codigo tipo documento de la venta </param>
          <param nom="EV_factura_global" Tipo="VARCHAR2"> Valor parametro base FACTURA_GLOBAL </param>
          <param nom="EN_documento_guia" Tipo="NUMBER"> Valor parametro base COD_DOCGUIA</param>
          <param nom="EV_tip_foliacion" Tipo="VARCHAR2"> Tipo foliacion documento de la venta </param>
         <param nom="EN_cod_tipmovimen" Tipo="NUMBER"> Tipo Movimiento</param>
         <param nom="EV_cod_cattribut" Tipo="VARCHAR2"> Codigo categoria tributaria documento </param>
          <param nom="EV_flagcentremi" Tipo="VARCHAR2"> Valor parametro FLAG_CENTREMI_FA</param>
         <param nom="EN_cod_modventa" Tipo="NUMBER"> Codigo modalidad de la venta </param>

      </Entrada>
      <Salida>
          <param nom="SV_cod_modgener" Tipo="VARCHAR2"> Codigo modo generacion </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'INSERT INTO ga_det_preliq  ( num_venta, num_item, num_abonado, num_celular, num_serie_orig,' || 'imp_cargo, imp_cargo_final, cod_articulo,tip_dto,val_dto)' || ' VALUES (' || en_numventa || ',' || en_numitem || ',' || en_numabonado || ','
         || en_numcelular || ',' || ev_numserie || ',' || en_impcargo || ',' || en_impcargofinal || ',' || en_codarticulo || ',' || en_tipdcto || ',' || en_valdcto || ')';

      INSERT INTO ga_det_preliq
                  (num_venta, num_item, num_abonado, num_celular, num_serie_orig, imp_cargo, imp_cargo_final, cod_articulo, tip_dto, val_dto)
      VALUES      (en_numventa, en_numitem, en_numabonado, en_numcelular, ev_numserie, en_impcargo, en_impcargofinal, en_codarticulo, en_tipdcto, en_valdcto);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11127;
         sv_mens_retorno := 'Error al Ingresar Detalle de Preliquidacion';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_in_ga_det_preliq_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_in_ga_det_preliq_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_in_ga_det_preliq_pr;

   PROCEDURE ve_actualiza_facturacion_pr (
      ev_cod_estadoc       IN              VARCHAR2,
      ev_cod_estproc       IN              VARCHAR2,
      ev_cod_catribdoc     IN              VARCHAR2,
      ev_num_folio         IN              VARCHAR2,
      ev_pref_plaza        IN              VARCHAR2,
      ev_fec_vencimiento   IN              VARCHAR2,
      ev_nom_usuaelim      IN              VARCHAR2,
      ev_cod_causaelim     IN              VARCHAR2,
      ev_num_proceso       IN              VARCHAR2,
      ev_num_venta         IN              VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_actualiza_facturacion_PR"
         Lenguaje="PL/SQL"
         Fecha="05-05-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Actualiza tabla Facturacion....
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_cod_estadoc"     Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_cod_estproc"     Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_cod_catribdoc"   Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_num_folio"       Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_pref_plaza"      Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_fec_vencimiento" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_nom_usuaelim"    Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_cod_causaelim"   Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_num_proceso"     Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="EV_num_venta"       Tipo="VARCHAR2"> glosa mensaje error </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql            ge_errores_pg.vquery;
      lv_des_error      ge_errores_pg.desevent;
      lv_sqlejecutarc   ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'UPDATE  FA_INTERFACT';

      IF (ev_cod_estadoc IS NULL) THEN
         lv_sql := lv_sql || ' SET FEC_VENCIMIENTO = TO_DATE(''' || ev_fec_vencimiento || ''', ''' || 'DD-MM-YYYY HH24:MI:SS' || ''' )';
      ELSE
         lv_sql := lv_sql || ' SET COD_ESTADOC =''' || ev_cod_estadoc || '''' || ' ,COD_ESTPROC =''' || ev_cod_estproc || '''';

         IF ev_cod_catribdoc = 'B' AND ev_num_folio IS NOT NULL THEN
            lv_sql := lv_sql || ' ,NUM_FOLIO =''' || ev_num_folio || '''' || ' ,PREF_PLAZA =''' || ev_pref_plaza || '''';
         END IF;

         IF ev_fec_vencimiento IS NOT NULL THEN
            lv_sql := lv_sql || ' ,FEC_VENCIMIENTO = TO_DATE(''' || ev_fec_vencimiento || ''', ''' || 'DD-MM-YYYY HH24:MI:SS' || ''' )';
         END IF;

         IF ev_cod_causaelim IS NOT NULL THEN
            lv_sql := lv_sql || ' ,NOM_USUAELIM =''' || ev_nom_usuaelim || '''' || ' ,COD_CAUSAELIM =''' || ev_cod_causaelim || '''';
         END IF;
      END IF;

      lv_sql := lv_sql || ' WHERE num_venta = ''' || ev_num_venta || '''';
      lv_sqlejecutarc := lv_sql;

      LOOP
         EXIT WHEN lv_sqlejecutarc IS NULL;
         lv_sqlejecutarc := SUBSTR (lv_sqlejecutarc, 251);
      END LOOP;

      EXECUTE IMMEDIATE lv_sql;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11128;
         sv_mens_retorno := 'Error al Actualizar Tabla de Facturacion';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_facturacion_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_facturacion_PR', lv_sql, sn_cod_retorno, lv_des_error);
   END ve_actualiza_facturacion_pr;

   PROCEDURE ve_obtiene_articulos_consig_pr (
      en_num_venta      IN              ga_abocel.num_venta%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_valparametro        ged_parametros.val_parametro%TYPE;
      no_data_found_cursor   EXCEPTION;
      ln_contador            NUMBER;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
     -- ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr ('STOCK_CONSIGNACION', cv_modulo_al, cv_producto, lv_valparametro, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      lv_ssql :=
         'SELECT a.num_venta,' || 'a.num_abonado,' || 'a.num_celular,' || 'a.num_serie,' || 'b.cod_articulo,' || 'S' || ' FROM ga_abocel a, al_series b' || ' WHERE a.num_venta = ' || en_num_venta || ' AND a.num_serie = b.num_serie' || ' UNION'
         || ' SELECT a.num_venta,' || 'a.num_abonado,' || 'a.num_celular,' || 'a.num_imei,' || 'b.cod_articulo,' || 'T' || ' FROM ga_abocel a, al_series b' || ' WHERE a.num_venta = ' || en_num_venta || ' AND a.num_imei = b.num_serie'
         || ' AND    b.tip_stock = ' || lv_valparametro;
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_abocel a, al_series b
       WHERE a.num_venta = en_num_venta AND a.num_serie = b.num_serie AND ROWNUM <= 1;

      IF (ln_contador = 0) THEN
         SELECT COUNT (1)
           INTO ln_contador
           FROM ga_abocel a, al_series b
          WHERE a.num_venta = en_num_venta AND a.num_imei = b.num_serie AND ROWNUM <= 1;
      END IF;

      OPEN sc_cursordatos FOR
         SELECT a.num_venta, a.num_abonado, a.num_celular, a.num_serie, b.cod_articulo, 'S'
           FROM ga_abocel a, al_series b
          WHERE a.num_venta = en_num_venta AND a.num_serie = b.num_serie
         UNION
         SELECT a.num_venta, a.num_abonado, a.num_celular, a.num_imei, b.cod_articulo, 'T'
           FROM ga_abocel a, al_series b
          WHERE a.num_venta = en_num_venta AND a.num_imei = b.num_serie AND b.tip_stock = lv_valparametro;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 11129;
         sv_mens_retorno := 'Error Al Consultar Articulos';
         lv_des_error    := SUBSTR ('no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_articulos_consig_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_articulos_consig_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11129;
         sv_mens_retorno := 'Error Al Consultar Articulos';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_articulos_consig_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_articulos_consig_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_articulos_consig_pr;

   PROCEDURE ve_crea_movimiento_central_pr (
      en_num_movimiento   IN              icc_movimiento.num_movimiento%TYPE,
      en_num_abonado      IN              icc_movimiento.num_abonado%TYPE,
      en_cod_estado       IN              icc_movimiento.cod_estado%TYPE,
      ev_cod_actabo       IN              icc_movimiento.cod_actabo%TYPE,
      ev_cod_modulo       IN              icc_movimiento.cod_modulo%TYPE,
      en_cod_actuacion    IN              icc_movimiento.cod_actuacion%TYPE,
      en_nom_usuarora     IN              icc_movimiento.nom_usuarora%TYPE,
      ev_fec_ingreso      IN              VARCHAR2,
      ev_tip_terminal     IN              icc_movimiento.tip_terminal%TYPE,
      en_cod_central      IN              icc_movimiento.cod_central%TYPE,
      en_num_celular      IN              icc_movimiento.num_celular%TYPE,
      ev_num_serie        IN              icc_movimiento.num_serie%TYPE,
      ev_cod_servicios    IN              icc_movimiento.cod_servicios%TYPE,
      ev_num_min          IN              icc_movimiento.num_min%TYPE,
      ev_tip_tecnologia   IN              icc_movimiento.tip_tecnologia%TYPE,
      ev_imsi             IN              icc_movimiento.imsi%TYPE,
      ev_imei             IN              icc_movimiento.imei%TYPE,
      ev_icc              IN              icc_movimiento.icc%TYPE,
      en_num_movtoant     IN              icc_movimiento.num_movimiento%TYPE,
      ev_plan             IN              VARCHAR2,
      ev_valorplan        IN              VARCHAR2,
      ev_carga            IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'INSERT INTO icc_movimiento (num_movimiento, num_abonado, cod_estado, cod_actabo, ' || 'cod_modulo, cod_actuacion, nom_usuarora, fec_ingreso,' || 'tip_terminal, cod_central, num_celular, num_serie,'
         || ' cod_servicios, num_min, tip_tecnologia, imsi,' || ' imei, icc, num_movant, plan, valor_plan, carga)' || 'VALUES (' || en_num_movimiento || ',' || en_num_abonado || ',' || en_cod_estado || ',''' || ev_cod_actabo || ''',''' || ev_cod_modulo
         || ''',' || en_cod_actuacion || ',' || en_nom_usuarora || ', TO_DATE(''' || ev_fec_ingreso || ''',' || 'DD-MM-YYYY HH24:MI:SS' || ') ,''' || ev_tip_terminal || ',' || en_cod_central || ',' || en_num_celular || ',''' || ev_num_serie || ''','''
         || ev_cod_servicios || ''',''' || ev_num_min || ''',''' || ev_tip_tecnologia || ''',''' || ev_imsi || ''',''' || ev_imei || ''',''' || ev_icc || '''' || en_num_movtoant || ',''' || ev_plan || ''',' || ev_valorplan || ',' || ev_carga || ')';

      INSERT INTO icc_movimiento
                  (num_movimiento, num_abonado, cod_estado, cod_actabo, cod_modulo, cod_actuacion, nom_usuarora, fec_ingreso, tip_terminal, cod_central, num_celular, num_serie,
                   cod_servicios, num_min, tip_tecnologia, imsi, imei, icc, num_movant, PLAN, valor_plan, carga)
      VALUES      (en_num_movimiento, en_num_abonado, en_cod_estado, ev_cod_actabo, ev_cod_modulo, en_cod_actuacion, en_nom_usuarora, TO_DATE (ev_fec_ingreso, 'DD-MM-YYYY HH24:MI:SS'), ev_tip_terminal, en_cod_central, en_num_celular, ev_num_serie,
                   ev_cod_servicios, ev_num_min, ev_tip_tecnologia, ev_imsi, ev_imei, ev_icc, en_num_movtoant, ev_plan, ev_valorplan, ev_carga);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11130;
         sv_mens_retorno := 'Error Al Insertar Movimiento Central';
         lv_des_error    := SUBSTR ('NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_crea_movimiento_central_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_crea_movimiento_central_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := 11130;
         sv_mens_retorno := 'Error Al Insertar Movimiento Central';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_crea_movimiento_central_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_crea_movimiento_central_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_crea_movimiento_central_pr;

   PROCEDURE ve_obtiene_ind_telefono_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      ev_parametro      OUT NOCOPY      VARCHAR2,
      sn_indtelefono    OUT NOCOPY      al_series.ind_telefono%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_ind_telefono_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene el indicador de telefono para una serie dada.
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_serie"        Tipo="VARCHAR2> numero serie a consultar</param>
         <param nom="EN_parametro"    Tipo="NUMBER> indicador de telefono a descartar</param>
      </Entrada>
      <Salida>
         <param nom="SN_indtelefono"  Tipo="NUMBER"> indicador de telefono</param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_indtelefono := 0;
      
      SELECT a.val_parametro
        INTO ev_parametro
        FROM ged_parametros a
       WHERE a.nom_parametro = 'IND_TEL_OUT' AND a.cod_modulo = 'GE' AND a.cod_producto = 1;
      
      lv_ssql := 'SELECT a.ind_telefono' || ' FROM al_series a' || ' WHERE a.num_serie =' || ev_serie || ' AND a.num_telefono IS NOT NULL' || ' AND a.ind_telefono > 0' || ' AND a.ind_telefono <> ' || ev_parametro;

      SELECT a.ind_telefono
        INTO sn_indtelefono
        FROM al_series a
       WHERE a.num_serie = ev_serie AND a.num_telefono IS NOT NULL AND a.ind_telefono > 0 AND a.ind_telefono <> ev_parametro;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11131;
         sv_mens_retorno := 'Error Al Consultar Indicador De Telefono';   lv_des_error := SUBSTR ('NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_ind_telefono_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_ind_telefono_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11131;
         sv_mens_retorno := 'Error Al Consultar Indicador De Telefono';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_ind_telefono_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_ind_telefono_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_ind_telefono_pr;

   PROCEDURE ve_obtiene_actua_central_pr (
      ev_codactabo       IN              ga_actabo.cod_actabo%TYPE,
      en_codproducto     IN              ga_actabo.cod_producto%TYPE,
      ev_codtecnologia   IN              ga_actabo.cod_actabo%TYPE,
      sv_codactcen       OUT NOCOPY      ga_actabo.cod_actcen%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_actua_central_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene codigo actuacion central
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_codactabo"     Tipo="VARCHAR2"> codigo actuacion abonado</param>
         <param nom="EN_codproducto"   Tipo="NUMBER"> codigo producto</param>
         <param nom="EV_codtecnologia" Tipo="VARCHAR2"> codigo tecnologia</param>
      </Entrada>
      <Salida>
         <param nom="SV_codactcen"     Tipo="VARCHAR2"> codigo de actuacion central</param>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="VARCHAR2"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sv_codactcen := '';
      lv_ssql := 'SELECT a.cod_actcen' || ' FROM ga_actabo a' || ' WHERE a.cod_actabo = ' || ev_codactabo || ' AND a.cod_producto = ' || en_codproducto || ' AND a.cod_tecnologia = ' || ev_codtecnologia;

      SELECT a.cod_actcen
        INTO sv_codactcen
        FROM ga_actabo a
       WHERE a.cod_actabo = ev_codactabo AND a.cod_producto = en_codproducto AND a.cod_tecnologia = ev_codtecnologia;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11132;
         sv_mens_retorno := 'Error Al Consultar Codigo Actuacion Central';
         lv_des_error    := SUBSTR ('NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_actua_central_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_actua_central_PR', lv_ssql, sn_cod_retorno, lv_des_error);

     WHEN OTHERS THEN
         sn_cod_retorno  := 11132;
         sv_mens_retorno := 'Error Al Consultar Codigo Actuacion Central';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_actua_central_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_actua_central_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_actua_central_pr;

   PROCEDURE ve_obtiene_codigo_sistema_pr (
      en_codproducto    IN              icg_central.cod_producto%TYPE,
      en_codcentral     IN              icg_central.cod_central%TYPE,
      sn_codsistema     OUT NOCOPY      icg_central.cod_sistema%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_codigo_sistema_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene Codigo de sistema, correspondiente al asociado a la central de la linea
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codproducto"   Tipo="NUMBER> codigo producto</param>
         <param nom="EV_codcentral"    Tipo="NUMBER> codigo central</param>
      </Entrada>
      <Salida>
         <param nom="SN_codsistema     Tipo="NUMBER"> codigo sistema</param>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="VARCHAR2"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_codsistema := '';
      lv_ssql := 'SELECT a.cod_sistema' || ' FROM icg_central a' || ' WHERE a.cod_producto =' || en_codproducto || ' AND a.cod_central = ' || en_codcentral;

      SELECT a.cod_sistema
        INTO sn_codsistema
        FROM icg_central a
       WHERE a.cod_producto = en_codproducto AND a.cod_central = en_codcentral;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11133;
         sv_mens_retorno := 'error al consultar codigo de sistema';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codigo_sistema_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codigo_sistema_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11133;
         sv_mens_retorno := 'error al consultar codigo de sistema';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codigo_sistema_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_codigo_sistema_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_codigo_sistema_pr;

   PROCEDURE ve_obtiene_central_pr (
      en_codproducto     IN              icg_central.cod_producto%TYPE,
      en_codcentral      IN              icg_central.cod_central%TYPE,
      sv_codtecnologia   OUT NOCOPY      icg_central.cod_tecnologia%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_central_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene dtos de la central
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codproducto"    Tipo="NUMBER> codigo producto</param>
         <param nom="EV_codcentral"     Tipo="NUMBER> codigo central</param>
      </Entrada>
      <Salida>
         <param nom="SV_codtecnologia"  Tipo="NUMBER"> codigo tecnologia</param>
         <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"   Tipo="VARCHAR2"> glosa mensaje error</param>
         <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sv_codtecnologia := '';
      lv_ssql := 'SELECT a.cod_tecnologia' || ' FROM icg_central a' || ' WHERE a.cod_producto = ' || en_codproducto || ' AND a.cod_central = ' || en_codcentral;

      SELECT a.cod_tecnologia
        INTO sv_codtecnologia
        FROM icg_central a
       WHERE a.cod_producto = en_codproducto AND a.cod_central = en_codcentral;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11134;
         sv_mens_retorno := 'Error Al Consultar Datos De La Central';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_central_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_central_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11134;
         sv_mens_retorno := 'Error Al Consultar Datos De La Central';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_central_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_central_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_central_pr;

   PROCEDURE ve_up_ga_preliquidacion_pr (
      ev_numventa       IN              ga_preliquidacion.num_venta%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_unidades    ga_preliquidacion.num_unidades%TYPE   := 0;
      lv_importe     ga_preliquidacion.imp_venta%TYPE      := 0.0;
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      SELECT COUNT (*), SUM (imp_cargo_final)
        INTO lv_unidades, lv_importe
        FROM ga_det_preliq
       WHERE num_venta = ev_numventa;

      lv_ssql := 'UPDATE ga_preliquidacion ' || ' SET num_unidades = ' || lv_unidades || ' ,imp_venta = ' || lv_importe || ' WHERE  num_venta = ' || ev_numventa;

      UPDATE ga_preliquidacion
         SET num_unidades = lv_unidades,
             imp_venta = lv_importe
       WHERE num_venta = ev_numventa;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11135;
         sv_mens_retorno := 'Error Al Actualizar Preliquidacion';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_up_ga_preliquidacion_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_up_ga_preliquidacion_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_up_ga_preliquidacion_pr;

   PROCEDURE ve_actualiza_equipaboser_pr (
      ev_nummovimiento   IN              VARCHAR2,
      ev_tipstock        IN              VARCHAR2,
      ev_bodegaact       IN              VARCHAR2,
      ev_tipstockorig    IN              VARCHAR2,
      ev_codbodega       IN              VARCHAR2,
      ev_codarticulo     IN              VARCHAR2,
      ev_coduso          IN              VARCHAR2,
      ev_codestado       IN              VARCHAR2,
      ev_numserie        IN              VARCHAR2,
      ev_numabonado      IN              VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación
        TipoDoc = "Procedimiento">
         <Elemento
            Nombre = "VE_actualiza_equipaboser_PR"
            Lenguaje="PL/SQL"
            Fecha="15-05-2006"
            Versión="1.0"
            Diseñador="wjrc"
           Programador="wjrc
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripción>
                     Actualiza tabla GA_EQUIPABOSER
           </Descripción>
            <Parámetros>
               <Entrada>
               <param nom="EV_NumMovimiento" Tipo="VARCHAR2">Numero de movimeinto</param>
               <param nom="EV_TipStock"      Tipo="VARCHAR2">Tipo de strock</param>
               <param nom="EV_BodegaAct"     Tipo="VARCHAR2">Bodega actual</param>
               <param nom="EV_TipStockOrig"  Tipo="VARCHAR2">Tipo stock origen</param>
               <param nom="EV_CodBodega"     Tipo="VARCHAR2">Codigo bodega</param>
               <param nom="EV_CodArticulo"   Tipo="VARCHAR2">Codigo articulo</param>
               <param nom="EV_CodUso"        Tipo="VARCHAR2">Codigo uso</param>
               <param nom="EV_CodEstado"     Tipo="VARCHAR2">Codigo estado</param>
               <param nom="EV_Numserie"      Tipo="VARCHAR2">Numero de serie</param>
               <param nom="EN_NumAbonado"    Tipo="VARCHAR2">Nro del abonado</param>
              </Entrada>
              <Salida>
                  <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo de Retorno</param>
                  <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>
                  <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
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
      lv_ssql :=
         'UPDATE ga_equipaboser' || ' SET num_movimiento = ' || ev_nummovimiento || '    ,tip_stock = ' || ev_tipstock || '    ,cod_bodega = ' || ev_bodegaact || ' WHERE tip_stock = ' || ev_tipstockorig || '   AND cod_bodega = ' || ev_codbodega
         || '   AND cod_articulo = ' || ev_codarticulo || '   AND cod_uso = ' || ev_coduso || '   AND cod_estado = ' || ev_codestado || '   AND num_serie = ' || ev_numserie || '   AND num_abonado = ' || ev_numabonado;

      UPDATE ga_equipaboser
         SET num_movimiento = ev_nummovimiento,
             tip_stock = ev_tipstock,
             cod_bodega = ev_bodegaact
       WHERE tip_stock = ev_tipstockorig AND cod_bodega = ev_codbodega AND cod_articulo = ev_codarticulo AND cod_uso = ev_coduso AND cod_estado = ev_codestado AND num_serie = ev_numserie AND num_abonado = ev_numabonado;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11136;
         sv_mens_retorno := 'Error Al Actualizar Equipaboser';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_equipaboser_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_equipaboser_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_actualiza_equipaboser_pr;

   PROCEDURE ve_obtiene_equipos_seriados_pr (
      ev_numabonado       IN              VARCHAR2,
      ev_indprocedencia   IN              VARCHAR2,
      sc_cursordatos      OUT NOCOPY      refcursor,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_equipos_seriados_PR
         Lenguaje="PL/SQL"
         Fecha="15-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta EQUIPOS SERIADOS
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_numAbonado"      Tipo="VARCHAR2> código articulo</param>
         <param nom="EV_indProcedencia"  Tipo="VARCHAR2> código articulo</param>
      </Entrada>
      <Salida>
             <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor equipos seriados </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql                 ge_errores_pg.vquery;
      lv_des_error           ge_errores_pg.desevent;
      no_data_found_cursor   EXCEPTION;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT a.tip_stock,a.cod_bodega,a.cod_articulo,a.cod_uso,a.cod_estado,a.num_serie,a.ind_equiacc,a.tip_terminal' || ' FROM ga_equipaboser a' || ' WHERE a.num_abonado = ' || ev_numabonado || '   AND a.ind_procequi = ' || ev_indprocedencia;

      OPEN sc_cursordatos FOR
         SELECT a.tip_stock, a.cod_bodega, a.cod_articulo, a.cod_uso, a.cod_estado, a.num_serie, a.ind_equiacc, a.tip_terminal
           FROM ga_equipaboser a
          WHERE a.num_abonado = ev_numabonado AND a.ind_procequi = ev_indprocedencia;                                                                                                                                                           -- I : interna

      ln_contador := 0;


   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 11137;
         sv_mens_retorno := 'Error Al Consultar Equipos Seriados';
         lv_des_error    := 'no_data_found_cursor:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_equipos_seriados_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_equipos_seriados_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11137;
         sv_mens_retorno := 'Error Al Consultar Equipos Seriados';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_equipos_seriados_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_equipos_seriados_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_equipos_seriados_pr;

   PROCEDURE ve_ins_abo_garantia_pr (
      en_num_venta      IN              ga_abonado_garantia.num_venta%TYPE,
      en_cod_cliente    IN              ga_abonado_garantia.cod_cliente%TYPE,
      en_num_abonado    IN              ga_abonado_garantia.num_abonado%TYPE,
      en_mto_garantia   IN              ga_abonado_garantia.mto_garantia%TYPE,
      en_ind_pago       IN              ga_abonado_garantia.ind_pago%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ins_abo_garantia_PR"
         Lenguaje="PL/SQL"
         Fecha="15-05-2007"
         Version="1.0.0"
         Dise?ador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                     INSERTA LA GARANTIA DEL ABONADO
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numventa"     Tipo="NUMBER> numero de venta </param>
         <param nom="EN_cod_cliente"  Tipo="NUMBER> código del cliente</param>
         <param nom="EN_num_abonado"  Tipo="NUMBER> numero de abonado </param>
         <param nom="EN_mto_garantia" Tipo="NUMBER> monto de garantia </param>
         <param nom="EN_ind_pago"     Tipo="NUMBER> indica pago garantia </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
            'INSERT INTO ga_abonado_garantia ' || '(num_venta, cod_cliente, num_abonado,' || ' mto_garantia, ind_pago)' || 'VALUES (' || en_num_venta || ',' || en_cod_cliente || ',' || en_num_abonado || ',' || en_mto_garantia || ',' || en_ind_pago || ')';

      INSERT INTO ga_abonado_garantia
                  (num_venta, cod_cliente, num_abonado, mto_garantia, ind_pago)
      VALUES      (en_num_venta, en_cod_cliente, en_num_abonado, en_mto_garantia, en_ind_pago);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11138;
         sv_mens_retorno := 'Error Al Insertar Garantia Del Abonado';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ins_abo_garantia_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ins_abo_garantia_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_ins_abo_garantia_pr;

   PROCEDURE ve_consulta_estant_serie_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sn_codestado      OUT NOCOPY      al_series.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_estant_serie_PR
         Lenguaje="PL/SQL"
         Fecha="15-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene estado anterior de la serie
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_serie"          Tipo="NUMBER> numero serie a consultar</param>
      </Entrada>
      <Salida>
         <param nom="SN_SN_codestado" Tipo="NUMBER"> codigo estado anterior </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_codesql     ga_errores.cod_sqlcode%TYPE;
      lv_errmsql     ga_errores.cod_sqlerrm%TYPE;
      ln_numevento   NUMBER;
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_indtelout   VARCHAR2 (20);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      --  OBTENEMOS EL VALOR PARA INDICADOR TELEFONO OUT
      lv_indtelout := '';
      --ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_indtelout, cv_modulo_ge, cv_producto, lv_indtelout, lv_codesql, lv_errmsql, ln_numevento);
      lv_sql := 'SELECT a.cod_estado' || ' FROM   al_series a' || ' WHERE a.num_serie =' || ev_serie || ' AND a.ind_telefono <>' || lv_indtelout;
      sn_codestado := 0;

      SELECT a.cod_estado
        INTO sn_codestado
        FROM al_series a
       WHERE a.num_serie = ev_serie AND a.ind_telefono <> lv_indtelout;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11139;
         sv_mens_retorno := 'Error Al Consultar Estado Anterior De La Serie';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_estant_serie_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_estant_serie_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11139;
         sv_mens_retorno := 'Error Al Consultar Estado Anterior De La Serie';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_estant_serie_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_estant_serie_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_estant_serie_pr;

   PROCEDURE ve_inserta_contrato_pr (
      en_cod_cuenta        IN              ga_contcta.cod_cuenta%TYPE,
      en_cod_producto      IN              ga_contcta.cod_producto%TYPE,
      ev_cod_tipcontrato   IN              ga_contcta.cod_tipcontrato%TYPE,
      ev_num_contrato      IN              ga_contcta.num_contrato%TYPE,
      ev_num_anexo         IN              ga_contcta.num_anexo%TYPE,
      en_num_meses         IN              ga_contcta.num_meses%TYPE,
      en_num_venta         IN              ga_contcta.num_venta%TYPE,
      en_num_abonados      IN              ga_contcta.num_abonados%TYPE,
      en_num_abonado       IN              ga_abocel.num_abonado%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_inserta_contrato_PR"
         Lenguaje="PL/SQL"
         Fecha="18-05-2007"
         Version="1.0.0"
         Dise?ador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta contrato y anexos de la venta
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_cod_cuenta"      Tipo="NUMBER> código cuenta cliente </param>
           <param nom="EN_cod_producto"    Tipo="NUMBER> código producto</param>
         <param nom="EV_cod_tipcontrato" Tipo="VARCHAR2"> código tipo contrato </param>
         <param nom="EV_num_contrato"    Tipo="VARCHAR2"> numero contrato de la venta </param>
         <param nom="EV_num_anexo"       Tipo="VARCHAR2"> numero anexo </param>
         <param nom="EN_num_meses"       Tipo="NUMBER"> numero de meses </param>
         <param nom="EN_num_venta"       Tipo="NUMBER"> numero de la venta </param>
         <param nom="EN_num_abonados"    Tipo="NUMBER"> numero de abonados </param>
         <param nom="EN_num_abonado"    Tipo="NUMBER"> codigo abonado </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'INSERT INTO ga_contcta' || '(cod_cuenta, cod_producto, cod_tipcontrato, num_contrato,' || ' num_anexo, num_meses, num_venta, fec_contrato,' || ' num_abonados)' || 'VALUES (' || en_cod_cuenta || ',' || en_cod_producto || ','
         || ev_cod_tipcontrato || ',' || ev_num_contrato || ',' || ev_num_anexo || ',' || en_num_meses || ',' || en_num_venta || ',' || SYSDATE || ',' || en_num_abonados || ')';

      INSERT INTO ga_contcta
                  (cod_cuenta, cod_producto, cod_tipcontrato, num_contrato, num_anexo, num_meses, num_venta, fec_contrato, num_abonados)
      VALUES      (en_cod_cuenta, en_cod_producto, ev_cod_tipcontrato, ev_num_contrato, ev_num_anexo, en_num_meses, en_num_venta, SYSDATE, en_num_abonados);

      lv_ssql := 'UPDATE ga_abocel' || ' SET num_anexo = ''' || ev_num_anexo || '''' || ' WHERE num_abonado = = ' || en_num_abonado;

      UPDATE ga_abocel
         SET num_anexo = ev_num_anexo
       WHERE num_abonado = en_num_abonado;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11140;
         sv_mens_retorno := 'Error Al Insertar Contrato Y Anexos De La Venta';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_contrato_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_contrato_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_inserta_contrato_pr;

   PROCEDURE     VE_con_max_anexo_contrato_PR (
      en_cod_cuenta        IN              ga_contcta.cod_cuenta%TYPE,
      en_cod_producto      IN              ga_contcta.cod_producto%TYPE,
      ev_cod_tipcontrato   IN              ga_contcta.cod_tipcontrato%TYPE,
      ev_num_contrato      IN              ga_contcta.num_contrato%TYPE,
      sn_max_anexo         OUT             NUMBER,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_con_max_anexo_contrato_PR"
         Lenguaje="PL/SQL"
         Fecha="18-05-2007"
         Version="1.0.0"
         Dise?ador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene numero maximo de anexo de contrato de la venta
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_cod_cuenta"      Tipo="NUMBER"> código cuenta cliente</param>
         <param nom="EN_cod_producto"    Tipo="NUMBER"> código producto</param>
         <param nom="EV_cod_tipcontrato" Tipo="VARCHAR2"> código tipo contrato</param>
         <param nom="EV_num_contrato"    Tipo="VARCHAR2"> número contrato</param>
      </Entrada>
      <Salida>
         <param nom="SN_max_anexo"    Tipo="NUMBER"> máximo numero anexo contrato </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_codesql     ga_errores.cod_sqlcode%TYPE;
      lv_errmsql     ga_errores.cod_sqlerrm%TYPE;
      ln_numevento   NUMBER;
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_indtelout   VARCHAR2 (20);

   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT /*+ index(contrato PK_GA_CONTCTA) */ MAX(TO_NUMBER(SUBSTR(contrato.num_anexo, 17, 5)))' || ' FROM ga_contcta contrato' || ' WHERE contrato.cod_cuenta =' || en_cod_cuenta || ' AND contrato.cod_producto = ' || en_cod_producto || ' AND contrato.cod_tipcontrato = '
         || ev_cod_tipcontrato || ' AND contrato.num_contrato = ' || ev_num_contrato;
            --Inicio INC148452 [JST Soporte Ventas 17-11-2010]
            --SELECT MAX (TO_NUMBER (SUBSTR (contrato.num_anexo, 17, 5)))
      SELECT /*+ index(contrato PK_GA_CONTCTA) */ MAX (TO_NUMBER (SUBSTR (contrato.num_anexo, 17, 5)))
      --Fin INC148452 [JST Soporte Ventas 17-11-2010]
        INTO sn_max_anexo
        FROM ga_contcta contrato
       WHERE contrato.cod_cuenta = en_cod_cuenta AND contrato.cod_producto = en_cod_producto AND contrato.cod_tipcontrato = ev_cod_tipcontrato AND contrato.num_contrato = ev_num_contrato;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11141;
         sv_mens_retorno := 'Error Al Consultar Numero Maximo De Anexo De Contrato';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_max_anexo_contrato_PR(' || en_cod_cuenta || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_max_anexo_contrato_PR(' || en_cod_cuenta || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11141;
         sv_mens_retorno := 'Error Al Consultar Numero Maximo De Anexo De Contrato';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_max_anexo_contrato_PR(' || en_cod_cuenta || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_max_anexo_contrato_PR(' || en_cod_cuenta || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_con_max_anexo_contrato_pr;

   PROCEDURE ve_con_rango_descto_vend_pr (
      en_cod_vendedor   IN              ve_vendperfil.cod_vendedor%TYPE,
      sn_pnt_dto_inf    OUT NOCOPY      ga_perfilcargos.pnt_dto_inf%TYPE,
      sn_pnt_dto_sup    OUT NOCOPY      ga_perfilcargos.pnt_dto_sup%TYPE,
      sn_prc_dto_inf    OUT NOCOPY      ga_perfilcargos.prc_dto_inf%TYPE,
      sn_prc_dto_sup    OUT NOCOPY      ga_perfilcargos.prc_dto_sup%TYPE,
      sn_ind_moddtos    OUT NOCOPY      ga_perfilcargos.ind_moddtos%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_con_rango_descto_vend_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Version="1.0.0"
         Dise?ador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene rangos e descuentos asociados al vendedor
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_cod_vendedor"    Tipo="NUMBER"> código vendedor</param>
      </Entrada>
      <Salida>
          <param nom="SN_pnt_dto_inf"  Tipo="NUMBER"> rango inferior puntos de posibilidad dcto.</param>
          <param nom="SN_pnt_dto_sup"  Tipo="NUMBER"> rango superior puntos de posibilidad dcto.</param>
          <param nom="SN_prc_dto_inf"  Tipo="NUMBER"> rango inferior porcentaje de dcto. </param>
         <param nom="SN_prc_dto_sup"  Tipo="NUMBER"> rango superior porcentaje de dcto. </param>
         <param nom="SN_prc_dto_sup"  Tipo="NUMBER"> indica si vendedor puede o no modificar descuentos </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_codesql     ga_errores.cod_sqlcode%TYPE;
      lv_errmsql     ga_errores.cod_sqlerrm%TYPE;
      ln_numevento   NUMBER;
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_indtelout   VARCHAR2 (20);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT perfilcargos.pnt_dto_inf, perfilcargos.pnt_dto_sup, perfilcargos.prc_dto_inf,' || ' perfilcargos.prc_dto_sup,perfilcargos.ind_moddtos' || ' FROM ve_vendperfil perfilvendedor, ga_perfilcargos perfilcargos'
         || ' WHERE perfilvendedor.cod_vendedor = ' || en_cod_vendedor || ' AND perfilcargos.cod_perfil = perfilvendedor.cod_perfil' || ' AND SYSDATE BETWEEN perfilvendedor.fec_asignacion AND NVL(perfilvendedor.fec_desasignac,' || SYSDATE || ')';

      SELECT perfilcargos.pnt_dto_inf, perfilcargos.pnt_dto_sup, perfilcargos.prc_dto_inf, perfilcargos.prc_dto_sup, perfilcargos.ind_moddtos
        INTO sn_pnt_dto_inf, sn_pnt_dto_sup, sn_prc_dto_inf, sn_prc_dto_sup, sn_ind_moddtos
        FROM ve_vendperfil perfilvendedor, ga_perfilcargos perfilcargos
       WHERE perfilvendedor.cod_vendedor = en_cod_vendedor AND perfilcargos.cod_perfil = perfilvendedor.cod_perfil AND SYSDATE BETWEEN perfilvendedor.fec_asignacion AND NVL (perfilvendedor.fec_desasignac, SYSDATE);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11142;
         sv_mens_retorno := 'Error Al Consultar Rangos De Descuentos';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_rango_descto_vend_PR(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_rango_descto_vend_PR(' || en_cod_vendedor || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11142;
         sv_mens_retorno := 'Error Al Consultar Rangos De Descuentos';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_rango_descto_vend_PR(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_rango_descto_vend_PR(' || en_cod_vendedor || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_con_rango_descto_vend_pr;

   PROCEDURE ve_ins_sol_autorizacion_pr (
      en_num_venta          IN              ga_autoriza.num_venta%TYPE,
      en_lin_autoriza       IN              ga_autoriza.lin_autoriza%TYPE,
      ev_cod_oficina        IN              ga_autoriza.cod_oficina%TYPE,
      ev_cod_estado         IN              ga_autoriza.cod_estado%TYPE,
      en_num_autoriza       IN              ga_autoriza.num_autoriza%TYPE,
      en_cod_vendedor       IN              ga_autoriza.cod_vendedor%TYPE,
      en_num_unidades       IN              ga_autoriza.num_unidades%TYPE,
      en_prc_origin         IN              ga_autoriza.prc_origin%TYPE,
      en_ind_tipventa       IN              ga_autoriza.ind_tipventa%TYPE,
      en_cod_cliente        IN              ga_autoriza.cod_cliente%TYPE,
      en_cod_modventa       IN              ga_autoriza.cod_modventa%TYPE,
      ev_nom_usuar_vta      IN              ga_autoriza.nom_usuar_vta%TYPE,
      en_cod_concepto       IN              ga_autoriza.cod_concepto%TYPE,
      en_imp_cargo          IN              ga_autoriza.imp_cargo%TYPE,
      ev_cod_moneda         IN              ga_autoriza.cod_moneda%TYPE,
      en_num_abonado        IN              ga_autoriza.num_abonado%TYPE,
      ev_num_serie          IN              ga_autoriza.num_serie%TYPE,
      en_cod_concepto_dto   IN              ga_autoriza.cod_concepto_dto%TYPE,
      en_val_dto            IN              ga_autoriza.val_dto%TYPE,
      en_tip_dto            IN              ga_autoriza.tip_dto%TYPE,
      en_ind_modifi         IN              ga_autoriza.ind_modifi%TYPE,
      ev_origen             IN              ga_autoriza.origen%TYPE,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ins_sol_autorizacion_PR"
         Lenguaje="PL/SQL"
         Fecha="31-05-2007"
         Version="1.0.0"
         Dise?ador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Ingresa solicitud de aprobación de descuentos
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_num_venta"         Tipo="NUMBER"> numero de la venta</param>
         <param nom="EN_lin_autorixa"      Tipo="NUMBER"> correlativo que idenitifica a cada cargo</param>
         <param nom="EV_cod_oficina"       Tipo="STRING"> código oficina del vendedor</param>
         <param nom="EV_cod_estado"        Tipo="STRING"> código estado de la autorización</param>
         <param nom="EN_num_autoriza"      Tipo="NUMBER"> número correlativo de la solicitud de autorización</param>
         <param nom="EN_cod_vendedor"      Tipo="NUMBER"> código vendedor</param>
         <param nom="EN_num_unidades"      Tipo="NUMBER"> cantidad de cargos</param>
         <param nom="EN_prc_origin"        Tipo="NUMBER"> precio origen</param>
         <param nom="EN_ind_tipventa"      Tipo="NUMBER"> indicador tipo de venta</param>
         <param nom="EN_cod_cliente"       Tipo="NUMBER"> código cliente</param>
         <param nom="EN_cod_modventa"      Tipo="NUMBER"> código modlaidad de la venta</param>
         <param nom="EV_nom_usuar_vta"     Tipo="STRING"> nombre usuario de la venta</param>
         <param nom="EN_cod_concepto"      Tipo="NUMBER"> código concepto del cargo</param>
         <param nom="EN_imp_cargo"         Tipo="NUMBER"> importe del cargo </param>
         <param nom="EV_cod_moneda"        Tipo="STRING"> código moneda</param>
         <param nom="EN_num_abonado"       Tipo="NUMBER"> número de abonado</param>
         <param nom="EV_num_serie"         Tipo="STRING"> número de la serie</param>
         <param nom="EN_cod_concepto_dto"  Tipo="NUMBER"> código concepto de descuento</param>
         <param nom="EN_val_dto"           Tipo="NUMBER"> valor de descuento</param>
         <param nom="EN_tip_dto"           Tipo="NUMBER"> tipo de descuento</param>
         <param nom="EN_ind_modifi"        Tipo="NUMBER"> indicador precio limite perfil</param>
            <param nom="EV_origen"            Tipo="STRING"> origen autorización</param>
      </Entrada>
      <Salida>
          <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_codesql     ga_errores.cod_sqlcode%TYPE;
      lv_errmsql     ga_errores.cod_sqlerrm%TYPE;
      ln_numevento   NUMBER;
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_indtelout   VARCHAR2 (20);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'INSERT INTO ga_autoriza (num_venta, lin_autoriza, cod_oficina,' || ' cod_estado, num_autoriza, cod_vendedor,' || ' num_unidades, fec_venta,prc_origin,' || ' ind_tipventa, cod_cliente, cod_modventa,' || ' nom_usuar_vta, cod_concepto, imp_cargo,'
         || ' cod_moneda, num_abonado, num_serie,' || ' cod_concepto_dto, val_dto, tip_dto,' || ' ind_modifi, origen)' || ' VALUES (' || en_num_venta || ',' || en_lin_autoriza || ',''' || ev_cod_oficina || ''',' || ev_cod_estado || ''','
         || en_num_autoriza || ',' || en_cod_vendedor || ',' || en_num_unidades || ',' || SYSDATE || ',' || en_prc_origin || ',' || en_ind_tipventa || ',' || en_cod_cliente || ',' || en_cod_modventa || ',''' || ev_nom_usuar_vta || ''','
         || en_cod_concepto || ',' || en_imp_cargo || ',''' || ev_cod_moneda || ''',' || en_num_abonado || ',''' || ev_num_serie || ''',' || en_cod_concepto_dto || ',' || en_val_dto || ',' || en_tip_dto || ',' || en_ind_modifi || ',''' || ev_origen
         || '''';

      INSERT INTO ga_autoriza
                  (num_venta, lin_autoriza, cod_oficina, cod_estado, num_autoriza, cod_vendedor, num_unidades, fec_venta, prc_origin, ind_tipventa, cod_cliente, cod_modventa, nom_usuar_vta, cod_concepto,
                   imp_cargo, cod_moneda, num_abonado, num_serie, cod_concepto_dto, val_dto, tip_dto, ind_modifi, origen)
      VALUES      (en_num_venta, en_lin_autoriza, ev_cod_oficina, ev_cod_estado, en_num_autoriza, en_cod_vendedor, en_num_unidades, SYSDATE, en_prc_origin, en_ind_tipventa, en_cod_cliente, en_cod_modventa, ev_nom_usuar_vta, en_cod_concepto,
                   en_imp_cargo, ev_cod_moneda, en_num_abonado, ev_num_serie, en_cod_concepto_dto, en_val_dto, en_tip_dto, en_ind_modifi, ev_origen);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11143;
         sv_mens_retorno := 'Error Al Insertar Solicitud De Aprobación De Descuentos';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ins_sol_autorizacion_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ins_sol_autorizacion_PR', lv_sql, sn_cod_retorno, lv_des_error);
   END ve_ins_sol_autorizacion_pr;

   PROCEDURE ve_con_sol_autorizacion_pr (
      en_num_autoriza   IN              ga_autoriza.num_autoriza%TYPE,
      sv_cod_estado     OUT NOCOPY      ga_autoriza.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
        <Documentacion TipoDoc = "Procedimiento">
           Elemento Nombre = "VE_con_sol_autorizacion_PR"
           Lenguaje="PL/SQL"
           Fecha="01-06-2007"
           Version="1.0.0"
           Dise?ador="Héctor Hermosilla"
           Programador="Héctor Hermosilla"
           Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
           Consulta estado de la solicitud de autorización de aumentar el rango de descuento asociado al vendedor
        </Descripcion>
        <Parametros>
        <Entrada>
           <param nom="EN_num_autoriza"      Tipo="NUMBER"> número correlativo de la solicitud de autorización</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
           <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
           <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
      lv_codesql     ga_errores.cod_sqlcode%TYPE;
      lv_errmsql     ga_errores.cod_sqlerrm%TYPE;
      ln_numevento   NUMBER;
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_indtelout   VARCHAR2 (20);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql := 'SELECT autorizaDescuento.cod_estado' || ' FROM ga_autoriza autorizaDescuento' || ' WHERE autorizaDescuento.num_autoriza = ' || en_num_autoriza || ' AND ROWNUM <2';

      SELECT autorizadescuento.cod_estado
        INTO sv_cod_estado
        FROM ga_autoriza autorizadescuento
       WHERE autorizadescuento.num_autoriza = en_num_autoriza AND ROWNUM < 2;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11144;
         sv_mens_retorno := 'Error Al Consultar Estado De La Solicitud De Autorización';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_sol_autorizacion_PR(' || en_num_autoriza || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_sol_autorizacion_PR(' || en_num_autoriza || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11144;
         sv_mens_retorno := 'Error Al Consultar Estado De La Solicitud De Autorización';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_sol_autorizacion_PR(' || en_num_autoriza || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_sol_autorizacion_PR(' || en_num_autoriza || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_con_sol_autorizacion_pr;

   PROCEDURE ve_con_modalidadpago_pr (
      en_cod_modventa   IN              ge_modventa.cod_modventa%TYPE,
      sv_des_modventa   OUT             ge_modventa.des_modventa%TYPE,
      sn_indcuotas      OUT NOCOPY      ge_modventa.ind_cuotas%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
     /*--
     <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_con_modalidadpago_PR"
        Lenguaje="PL/SQL"
        Fecha="07-06-2007"
        Versión="1.0.0"
        Diseñador="Héctor Hermosilla"
        Programador="Héctor Hermosilla"
        Ambiente="BD"
     <Retorno>Modalidad de Pago </Retorno>
     <Descripción>
        Modalidad de Pago
     </Descripción>
     <Parametros>
     <Entrada>
          <param nom="EN_cod_modventa"  Tipo="VARCHAR2">codigo de tipo de contrato</param>
     </Entrada>
     <Salida>
          <param nom="SV_des_modventa"  Tipo="STRING">descripción modalidad de pago</param>
          <param nom="SN_indcuotas"    Tipo="NUMBER">indicador cuotas</param>
          <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
          <param nom="SV_mens_retorno" Tipo="STRING">Mensaje error de negocio Retornado</param>
          <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
     </Salida>
     </Parametros>
     </Elemento>
     </Documentación>
     */
   IS
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      ln_cod_retorno    ge_errores_pg.coderror;
      lv_mens_retorno   ge_errores_pg.msgerror;
      ln_num_evento     ge_errores_pg.evento;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT mod_venta.des_modventa, mod_venta.ind_cuotas' || ' SELECT mod_venta.des_modventa, mod_venta.ind_cuotas' || ' WHERE mod_venta.cod_modventa = ' || en_cod_modventa;

      SELECT mod_venta.des_modventa, mod_venta.ind_cuotas
        INTO sv_des_modventa, sn_indcuotas
        FROM ge_modventa mod_venta
       WHERE mod_venta.cod_modventa = en_cod_modventa;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10778;
         sv_mens_retorno := 'Error No se pudo recuperar datos Modalidad de Pago';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_modalidadpago_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_modalidadpago_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11145;
         sv_mens_retorno := 'Error Al Consultar Modalidad De Pago';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_modalidadpago_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_modalidadpago_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_con_modalidadpago_pr;

   PROCEDURE ve_con_tipocontrato_pr (
      en_cod_producto      IN              NUMBER,
      ev_cod_tipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      sv_des_tipcontrato   OUT NOCOPY      ga_tipcontrato.des_tipcontrato%TYPE,
      sn_ind_comodato      OUT NOCOPY      ga_tipcontrato.ind_comodato%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento)
    /*--
    <Documentación TipoDoc = "Procedimiento">
       Elemento Nombre = "VE_con_tipocontrato_PR"
       Lenguaje="PL/SQL"
       Fecha="07-06-2007"
       Versión="1.0.0"
       Diseñador="Héctor Hermosilla"
       Programador="Héctor Hermosilla"
       Ambiente="BD"
    <Retorno>Tipo Contrato</Retorno>
    <Descripción>
       Consulta tipo contrato
    </Descripción>
    <Parametros>
    <Entrada>
         <param nom="EN_cod_producto"    Tipo="NUMBER">codigo producto</param>
         <param nom="EV_cod_tipcontrato" Tipo="STRING">codigo tipo contrato</param>
    </Entrada>
    <Salida>
         <param nom="SV_des_tipcontrato" Tipo="STRING">descripción tipo contrato</param>
         <param nom="SN_ind_comodato"    Tipo="NUMBER">indicador comodato</param>
         <param nom="SN_cod_retorno"     Tipo="NUMBER">Codigo error de negocio Retornado</param>
         <param nom="SV_mens_retorno"    Tipo="STRING">Mensaje error de negocio Retornado</param>
         <param nom="SN_num_evento"      Tipo="NUMBER">Nro de evento</param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentación>
    */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql :=
         'SELECT tipocontrato.des_tipcontrato, tipocontrato.ind_comodato' || ' INTO SN_indcomodato' || ' FROM ga_tipcontrato tipocontrato' || ' WHERE tipocontrato.cod_producto = ' || en_cod_producto || ' AND tipocontrato.cod_tipcontrato = '''
         || ev_cod_tipcontrato || '''';

      SELECT tipocontrato.des_tipcontrato, tipocontrato.ind_comodato
        INTO sv_des_tipcontrato, sn_ind_comodato
        FROM ga_tipcontrato tipocontrato
       WHERE tipocontrato.cod_producto = en_cod_producto AND tipocontrato.cod_tipcontrato = ev_cod_tipcontrato;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11146;
         sv_mens_retorno := 'Error Al Consultar Tipo De Contrato';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_tipocontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_tipocontrato_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11146;
         sv_mens_retorno := 'Error Al Consultar Tipo De Contrato';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_tipocontrato_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_tipocontrato_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_con_tipocontrato_pr;

   PROCEDURE ve_con_producto_pr (
      en_cod_producto   IN              ge_productos.cod_producto%TYPE,
      sv_des_producto   OUT NOCOPY      ge_productos.des_producto%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
     /*--
     <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_con_producto_PR"
        Lenguaje="PL/SQL"
        Fecha="07-06-2007"
        Versión="1.0.0"
        Diseñador="Héctor Hermosilla"
        Programador="Héctor Hermosilla"
        Ambiente="BD"
     <Retorno>Producto</Retorno>
     <Descripción>
        Consulta producto
     </Descripción>
     <Parametros>
     <Entrada>
          <param nom="EN_cod_producto"    Tipo="NUMBER">codigo producto</param>
     </Entrada>
     <Salida>
          <param nom="SV_des_producto" Tipo="STRING">descripción producto</param>
          <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
          <param nom="SV_mens_retorno" Tipo="STRING">Mensaje error de negocio Retornado</param>
          <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
     </Salida>
     </Parametros>
     </Elemento>
     </Documentación>
     */
   IS
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT productos.des_producto' || ' FROM   ge_productos productos' || ' FROM ga_tipcontrato tipocontrato' || ' WHERE  productos.cod_producto = ' || en_cod_producto;

      SELECT productos.des_producto
        INTO sv_des_producto
        FROM ge_productos productos
       WHERE productos.cod_producto = en_cod_producto;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11147;
         sv_mens_retorno := 'Error Al Consultar Producto';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_producto_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_producto_PR()', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11147;
         sv_mens_retorno := 'Error Al Consultar Producto';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_producto_PR();- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_con_producto_PR()', lv_sql, SQLCODE, lv_des_error);
   END ve_con_producto_pr;

   PROCEDURE ve_updabocelclaseserv_pr (
      en_numabonado     IN              ga_abocel.num_abonado%TYPE,
      ev_claseserv      IN              ga_abocel.clase_servicio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updAbocelClaseServ_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                     ACTUALIZA CLASE SERVICIO DEL ABONADO
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numAbonado"    Tipo="NUMBER"> numero abonado </param>
         <param nom="EV_claseServ"     Tipo="STRING"> clase servicio </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'UPDATE ga_abocel' || ' SET clase_servicio = ' || ev_claseserv || ' WHERE num_abonado = ' || en_numabonado;

      UPDATE ga_abocel
         SET clase_servicio = ev_claseserv
       WHERE num_abonado = en_numabonado;

      lv_ssql := 'UPDATE ga_aboamist' || ' SET clase_servicio = ' || ev_claseserv || ' WHERE num_abonado = ' || en_numabonado;

      UPDATE ga_aboamist
         SET clase_servicio = ev_claseserv
       WHERE num_abonado = en_numabonado;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11148;
         sv_mens_retorno := 'Error Al Actualizar Clase Servicio Del Abonado';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updAbocelClaseServ_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updAbocelClaseServ_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_updabocelclaseserv_pr;

   PROCEDURE ve_updequipaboser_pr (
      ev_numabonado     IN              VARCHAR2,
      ev_numserie       IN              VARCHAR2,
      ev_fecalta        IN              VARCHAR2,
      ev_nummovto       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updEquipAboser_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 Actualiza equipaboser : numero de movimiento
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_numAbonado"    Tipo="STRING"> numero abonado </param>
         <param nom="EV_numSerie"      Tipo="STRING"> numero serie </param>
         <param nom="EV_numMovto"      Tipo="STRING"> numero movimiento </param>
         <param nom="EV_fecAlta"       Tipo="STRING"> fecha alta </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      error_sql         EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      lv_formatofecha   VARCHAR2 (20);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      --  OBTENEMOS EL VALOR PARA FORMATO FECHA SEL2
      --ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_formato_fecha, cv_modulo_ge, cv_producto, lv_formatofecha, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         RAISE error_sql;
      END IF;

      lv_ssql := 'UPDATE ga_equipaboser' || ' SET num_movimiento = ' || ev_nummovto || ' WHERE num_abonado = ' || ev_numabonado || ' AND num_serie = ' || ev_numserie || ' AND fec_alta = TO_DATE(' || ev_fecalta || ',' || lv_formatofecha || ')';

      UPDATE ga_equipaboser
         SET num_movimiento = ev_nummovto
       WHERE num_abonado = ev_numabonado AND num_serie = ev_numserie AND fec_alta = TO_DATE (ev_fecalta, lv_formatofecha);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11149;
         sv_mens_retorno := 'Error Al Actualizar Numero De Movimiento';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updEquipAboser_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updEquipAboser_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_updequipaboser_pr;

   PROCEDURE ve_insreservaarticulo_pr (
      ev_num_linea      IN              VARCHAR2,
      ev_num_orden      IN              VARCHAR2,
      ev_cod_articulo   IN              VARCHAR2,
      ev_cod_producto   IN              VARCHAR2,
      ev_cod_bodega     IN              VARCHAR2,
      ev_tip_stock      IN              VARCHAR2,
      ev_cod_uso        IN              VARCHAR2,
      ev_cod_estado     IN              VARCHAR2,
      ev_nom_usuario    IN              VARCHAR2,
      ev_num_serie      IN              VARCHAR2,
      ev_num_transacc   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insReservaArticulo_PR
         Lenguaje="PL/SQL"
         Fecha="19-06-2007"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta reserva del articulo
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_num_linea"    Tipo="STRING"> numero linea </param>
         <param nom="EV_num_orden"    Tipo="STRING"> numero orden </param>
         <param nom="EV_cod_articulo" Tipo="STRING"> codigo articulo </param>
         <param nom="EV_cod_producto" Tipo="STRING"> codigo producto </param>
         <param nom="EV_cod_bodega"   Tipo="STRING"> codigo bodega </param>
         <param nom="EV_tip_stock"    Tipo="STRING"> tipo stock </param>
         <param nom="EV_cod_uso"      Tipo="STRING"> codigo uso </param>
         <param nom="EV_cod_estado"   Tipo="STRING"> codigo estado </param>
         <param nom="EV_nom_usuario"  Tipo="STRING"> nombre usuario </param>
         <param nom="EV_num_serie"    Tipo="STRING"> numero serie </param>
         <param nom="EV_num_transacc" Tipo="STRING"> numero transaccion</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      PRAGMA AUTONOMOUS_TRANSACTION;
      le_exception_fin     EXCEPTION;
      lv_des_error         ge_errores_pg.desevent;
      lv_ssql              ge_errores_pg.vquery;
      ln_num_transaccion   NUMBER;
      ln_contador          NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_reservart a
       WHERE a.num_serie = ev_num_serie;

      IF (ln_contador > 0) THEN
         RAISE le_exception_fin;
      END IF;

      lv_ssql :=
         'INSERT INTO ga_reservart (num_transaccion,' || 'num_linea, num_orden, cod_articulo, cod_producto, ' || 'fec_reserva, cod_bodega, tip_stock, cod_uso, cod_estado, ' || 'num_unidades, nom_usuario, num_serie) ' || 'VALUES (' || ev_num_transacc
         || ',' || ev_num_linea || ',' || ev_num_orden || ',' || ev_cod_articulo || ',' || ev_cod_producto || ',SYSDATE' || ',' || ev_cod_bodega || ',' || ev_tip_stock || ',' || ev_cod_uso || ',' || ev_cod_estado || ',1' || ',' || ev_nom_usuario || ','
         || ev_num_serie || ')';

      INSERT INTO ga_reservart
                  (num_transaccion, num_linea, num_orden, cod_articulo, cod_producto, fec_reserva, cod_bodega, tip_stock, cod_uso, cod_estado, num_unidades, nom_usuario, num_serie)
      VALUES      (ev_num_transacc, ev_num_linea, ev_num_orden, ev_cod_articulo, ev_cod_producto, SYSDATE, ev_cod_bodega, ev_tip_stock, ev_cod_uso, ev_cod_estado, 1, ev_nom_usuario, ev_num_serie);

      COMMIT;
   EXCEPTION
      WHEN le_exception_fin THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         lv_des_error := 'LE_exception_fin:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_insReservaArticulo_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_insReservaArticulo_PR', lv_ssql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         sn_cod_retorno  := 11150;
         sv_mens_retorno := 'Error Al Insertar Reserva Del Articulo';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_insReservaArticulo_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_insReservaArticulo_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_insreservaarticulo_pr;

   PROCEDURE ve_actualizastock_pr (
      ev_tipmov         IN              VARCHAR2,
      ev_tipstock       IN              VARCHAR2,
      ev_codbodega      IN              VARCHAR2,
      ev_codarticulo    IN              VARCHAR2,
      ev_coduso         IN              VARCHAR2,
      ev_codestado      IN              VARCHAR2,
      ev_numventa       IN              VARCHAR2,
      ev_numserie       IN              VARCHAR2,
      sv_nummovto       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
      <Elemento Nombre = "VE_ActualizaStock_PR"
      Lenguaje="PL/SQL"
      Fecha="19-06-2007"
      Versión="1.0.0"
      Diseñador="wjrc"
      Programador="wjrc"
      Ambiente="BD">
      <Retorno>
              Numero de movimiento
      </Retorno>
      <Descripción>
                 Actualiza stock del articulo
       </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_TipMov"      Tipo="STRING"> tipo movimiento </param>
            <param nom="EV_TipStock"    Tipo="STRING"> tipo stock </param>
            <param nom="EV_CodBodega"   Tipo="STRING"> codigo bodega </param>
            <param nom="EV_CodArticulo" Tipo="STRING"> codigo articulo </param>
            <param nom="EV_CodUso"      Tipo="STRING"> codigo uso </param>
            <param nom="EV_CodEstado"   Tipo="STRING"> codigo estado </param>
            <param nom="EV_NumVenta"    Tipo="STRING"> numero venta </param>
            <param nom="EV_Numserie"    Tipo="STRING"> numero serie </param>
         </Entrada>
         <Salida>
            <param nom="SV_numMovto"      Tipo="STRING"> numero de movimiento </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
         </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */  -- Inc. 78378 16/02/2009 JMC .
          --PRAGMA AUTONOMOUS_TRANSACTION;
      PRAGMA AUTONOMOUS_TRANSACTION;
      le_exception_fin     EXCEPTION;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      ln_ind_telefono      al_series.ind_telefono%TYPE;
    --  la_arreglo           --ve_intermediario_quiosco_pg.tipoarray := ve_intermediario_quiosco_pg.tipoarray ();
      -- (1) numero movimiento
      ln_num_transaccion   NUMBER;
      lv_cadena            ge_errores_pg.msgerror;                                                                                                                                                                      --VARCHAR2(100); Inc. 89593 14-05-2009
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      -- obtener numero de transaccion
      lv_sql := 'VE_intermediario_quiosco_PG.VE_obtiene_secuencia_PR(' || '''GA_SEQ_TRANSACABO''' || ',' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      --ve_intermediario_quiosco_pg.ve_obtiene_secuencia_pr ('GA_SEQ_TRANSACABO', ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

      --Obtiene ind_telefono
      lv_sql := 'SELECT S.IND_TELEFONO FROM al_series s WHERE num_serie =' || ev_numserie;

      SELECT s.ind_telefono
        INTO ln_ind_telefono
        FROM al_series s
       WHERE num_serie = ev_numserie;

      -- llamar procedimiento de p_ga_interal
      lv_sql :=
         'P_GA_INTERAL(' || ln_num_transaccion || ',' || ev_tipmov || ',' || ev_tipstock || ',' || ev_codbodega || ',' || ev_codarticulo || ',' || ev_coduso || ',' || ev_codestado || ',' || ev_numventa || ',' || '1,' || ev_numserie || ','
         || ln_ind_telefono || ')';
      p_ga_interal (ln_num_transaccion, ev_tipmov, ev_tipstock, ev_codbodega, ev_codarticulo, ev_coduso, ev_codestado, ev_numventa, '1', ev_numserie, TO_CHAR (ln_ind_telefono));
      -- verificamos estado del llamado
      lv_sql := 'VE_intermediario_quiosco_PG.VE_obtiene_transaccion_PR(' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      --ve_intermediario_quiosco_pg.ve_obtiene_transaccion_pr (ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      lv_cadena := sv_mens_retorno;

      IF (sn_cod_retorno = 0) THEN
         --la_arreglo := ve_intermediario_quiosco_pg.ve_descompone_cadena_fn (lv_cadena, '/', sn_cod_retorno, sv_mens_retorno, sn_num_evento);

         IF (sn_cod_retorno <> 0) THEN
            RAISE le_exception_fin;
         END IF;

     --    sv_nummovto := la_arreglo (1);
      ELSE
         RAISE le_exception_fin;
      END IF;

      COMMIT;
   EXCEPTION
      WHEN le_exception_fin THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         lv_des_error  := 'LE_EXCEPTION_FIN: VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ActualizaStock_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ActualizaStock_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         sn_cod_retorno  := 11151;
         sv_mens_retorno := 'Error Al Actualizar Stock Del Articulo';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ActualizaStock_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ActualizaStock_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_actualizastock_pr;

   PROCEDURE ve_getlistplantarifario_pr (
      ev_indcomercial   IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
          /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListPlanTarifario_PR
         Lenguaje="PL/SQL"
         Fecha="21-06-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              cursor
      </Retorno>
      <Descripcion>
         Obtiene planes tarifarios : comercializables y no comercializables
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_indComercial"       Tipo="STRING"> indicador comercializable </param>
                     0 : todos
                     1 : conercializable
                  2 : no comercializable
      </Entrada>
      <Salida>
          <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor cuentas </param>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      ln_contador := 0;

      IF (ev_indcomercial = 0) THEN
         -- Planes vigentes y no vigentes
         SELECT COUNT (1)
           INTO ln_contador
           FROM ta_plantarif a;

         lv_sql := 'SELECT a.cod_plantarif, a.des_plantarif ' || ' FROM ta_plantarif a ';
      ELSIF (ev_indcomercial = 1) THEN
         -- Planes comercializable (están vigente al día de hoy)
         SELECT COUNT (1)
           INTO ln_contador
           FROM ta_plantarif a
          WHERE SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE);

         lv_sql := 'SELECT a.cod_plantarif, a.des_plantarif ' || ' FROM ta_plantarif a ' || ' WHERE SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE)';
      ELSE
         -- Plan no comercializable (no está vigente)
         SELECT COUNT (1)
           INTO ln_contador
           FROM ta_plantarif a
          WHERE NOT (SYSDATE BETWEEN a.fec_desde AND NVL (a.fec_hasta, SYSDATE));

         lv_sql := 'SELECT a.cod_plantarif, a.des_plantarif ' || ' FROM ta_plantarif a ' || ' WHERE NOT (SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta,SYSDATE))';
      END IF;

      OPEN sc_cursordatos FOR lv_sql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno  := 1;
         sv_mens_retorno :='No se pudo recuperar datos.';
         lv_deserror     := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListPlanTarifario_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListPlanTarifario_PR', lv_sql, sn_cod_retorno, lv_deserror);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11152;
         sv_mens_retorno := 'Error Al Consultar Planes Tarifarios';
         lv_deserror     := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListPlanTarifario_PR(' || ev_indcomercial || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListPlanTarifario_PR(' || ev_indcomercial || ')', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistplantarifario_pr;

   PROCEDURE ve_getempresacte_pr (
      ev_codcliente     IN              VARCHAR2,
      sv_numabonados    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getEmpresaCte_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Recupera datos de la empresa para el cliente
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_codCliente"    Tipo="STRING"> codigo cliente</param>
      </Entrada>
      <Salida>
         <param nom="SV_numAbonados"   Tipo="STRING"> numero de abonados</param>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT a.num_abonados' || ' FROM ga_empresa a ' || ' WHERE a.cod_cliente = ' || ev_codcliente;

      SELECT a.num_abonados
        INTO sv_numabonados
        FROM ga_empresa a
       WHERE a.cod_cliente = ev_codcliente;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 11153;
         sv_mens_retorno := 'Error Al Consultar Datos De La Empresa';
         lv_des_error    := SUBSTR ('NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getEmpresaCte_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getEmpresaCte_PR', lv_ssql, sn_cod_retorno, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11153;
         sv_mens_retorno := 'Error Al Consultar Datos De La Empresa';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getEmpresaCte_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getEmpresaCte_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_getempresacte_pr;

   PROCEDURE ve_updempresaabonados_pr (
      ev_codcliente     IN              VARCHAR2,
      ev_cantidad       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updEmpresaAbonados_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Actualiza cantidad de abonados de la empresa para el cliente
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_codCliente"    Tipo="STRING"> codigo cliente</param>
         <param nom="EV_cantidad"      Tipo="STRING"> cantidad clientes </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'UPDATE ga_empresa a' || ' SET a.num_abonados = a.num_abonados + ' || ev_cantidad || ' WHERE a.cod_cliente = ' || ev_codcliente;

      UPDATE ga_empresa a
         SET a.num_abonados = a.num_abonados + ev_cantidad
       WHERE a.cod_cliente = ev_codcliente;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 11154;
         sv_mens_retorno := 'Error Al Actualizar Cantidad De Abonados';
         lv_des_error    := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updEmpresaAbonados_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updEmpresaAbonados_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_updempresaabonados_pr;

   PROCEDURE ve_updabocelcodsituac_pr (
      en_numventa       IN              VARCHAR2,
      ev_codsituacion   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updAbocelCodSituac_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Actualiza codigo situacion del abonado
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numVenta"       Tipo="NUMBER"> numero venta </param>
         <param nom="EV_codSituacion"   Tipo="STRING"> codigo situacion </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'UPDATE ga_abocel' || ' SET cod_situacion = ' || ev_codsituacion || ' WHERE num_venta = ' || en_numventa;

      UPDATE ga_abocel
         SET cod_situacion = ev_codsituacion
       WHERE num_venta = en_numventa;

      lv_ssql := 'UPDATE ABOAMIST' || ' SET cod_situacion = ' || ev_codsituacion || ' WHERE num_venta = ' || en_numventa;

      UPDATE ga_aboamist
         SET cod_situacion = ev_codsituacion
       WHERE num_venta = en_numventa;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11155;
         sv_mens_retorno := 'error al actualizar codigo situacion del abonado';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updAbocelCodSituac_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_updAbocelCodSituac_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_updabocelcodsituac_pr;

   PROCEDURE ve_validahomevendcel_pr (
      en_codvendedor    IN              VARCHAR2,
      ev_numcelular     IN              VARCHAR2,
      sn_resultado      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_validaHomeVendCel_PR"
         Lenguaje="PL/SQL"
         Fecha="10-04-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
         Retorna 0 si no encuentra datos
       </Retorno>
      <Descripcion>
         Verifica si el home del celular corresponde al home del vendedor
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EV_codVendedor" Tipo="STRING"> codigo vendedor/param>
            <param nom="EV_numCelular"  Tipo="STRING"> codigo vendedor/param>
      </Entrada>
      <Salida>
             <param nom="SN_resultado"    Tipo="NUMBER"> resultado de la consulta</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
       */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_resultado := 0;
      lv_ssql :=
         'SELECT COUNT(1)' || ' FROM ga_celnum_uso a,' || ' ta_subcentral b,' || ' ge_celdas c,' || ' ge_ciudades d,' || ' ge_oficinas e,' || ' ve_vendedores f' || ' WHERE ' || ev_numcelular || ' BETWEEN a.num_desde AND a.num_hasta'
         || ' AND a.cod_central = b.cod_central' || ' AND a.cod_subalm = b.cod_subalm' || ' AND b.cod_subalm = c.cod_subalm' || ' AND c.cod_celda = d.cod_celda' || ' AND d.cod_region = e.cod_region' || ' AND d.cod_provincia = e.cod_provincia'
         || ' AND e.cod_oficina = f.cod_oficina' || ' AND f.cod_vendedor = ' || en_codvendedor;

      --Incidencia 66660 optimización de consulta [PAAA 25-09-2008, soporte]
      /*SELECT COUNT(1)
      INTO SN_resultado
      FROM ga_celnum_uso a,
           ta_subcentral b,
          ge_celdas c,
          ge_ciudades d,
          ge_oficinas e,
          ve_vendedores f
      WHERE EV_numCelular BETWEEN a.num_desde AND a.num_hasta
        AND a.cod_central = b.cod_central
        AND a.cod_subalm = b.cod_subalm
        AND b.cod_subalm = c.cod_subalm
        AND c.cod_celda = d.cod_celda
        AND d.cod_region = e.cod_region
        AND d.cod_provincia = e.cod_provincia
        AND e.cod_oficina = f.cod_oficina
        AND f.cod_vendedor = EN_codVendedor;*/
      SELECT COUNT (1)
        INTO sn_resultado
        FROM ga_celnum_uso a, (SELECT c.cod_celda, c.cod_subalm
                                 FROM ve_vendedores f, ge_oficinas e, ge_ciudades d, ge_celdas c
                                WHERE f.cod_vendedor = en_codvendedor AND e.cod_oficina = f.cod_oficina AND d.cod_region = e.cod_region AND d.cod_provincia = e.cod_provincia AND c.cod_celda = d.cod_celda AND ROWNUM = 1) b
       WHERE a.cod_subalm = b.cod_subalm AND ev_numcelular BETWEEN a.num_desde AND a.num_hasta;

      --Fin 66660
      IF (sn_resultado < 1) THEN
         lv_ssql :=
            'SELECT COUNT(1)' || ' FROM ga_celnum_reutil a,' || ' ta_subcentral b,' || ' ge_celdas c,' || ' ge_ciudades d,' || ' ge_oficinas e,' || ' ve_vendedores f' || ' WHERE a.NUM_CELULAR = ' || ev_numcelular || ' AND a.cod_central = b.cod_central'
            || ' AND a.cod_subalm = b.cod_subalm' || ' AND b.cod_subalm = c.cod_subalm' || ' AND c.cod_celda = d.cod_celda' || ' AND d.cod_region = e.cod_region' || ' AND d.cod_provincia = e.cod_provincia' || ' AND e.cod_oficina = f.cod_oficina'
            || ' AND f.cod_vendedor = ' || en_codvendedor;

         SELECT COUNT (1)
           INTO sn_resultado
           FROM ga_celnum_reutil a, ta_subcentral b, ge_celdas c, ge_ciudades d, ge_oficinas e, ve_vendedores f
          WHERE a.num_celular = ev_numcelular AND a.cod_central = b.cod_central AND a.cod_subalm = b.cod_subalm AND b.cod_subalm = c.cod_subalm AND c.cod_celda = d.cod_celda AND d.cod_region = e.cod_region AND d.cod_provincia = e.cod_provincia
                AND e.cod_oficina = f.cod_oficina AND f.cod_vendedor = en_codvendedor;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11156;
         sv_mens_retorno := 'error al validar home del celular';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_validaHomeVendCel_PR(' || en_codvendedor || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_validaHomeVendCel_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_validahomevendcel_pr;

   PROCEDURE ve_num_abonados_cliente_pr (
      ev_cod_cliente     IN              VARCHAR2,
      ev_cod_plantarif   IN              VARCHAR2,
      sn_resultado       OUT NOCOPY      NUMBER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_num_abonados_cliente_PR"
         Lenguaje="PL/SQL"
         Fecha="31-07-2007"
         Version="1.0.0"
         Dise?ador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>
         cantidad de abonados asociados al cliente
       </Retorno>
      <Descripcion>
          Devuelve cantidad de abonados asociados al cliente
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EV_cod_cliente"  Tipo="STRING"> codigo cliente</param>
             <param nom="EV_cod_plantarif" Tipo="STRING"> codigo plan tarifario</param>
      </Entrada>
      <Salida>
             <param nom="SN_resultado"    Tipo="NUMBER"> resultado de la consulta</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
       */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_resultado := 0;
      lv_ssql := 'SELECT COUNT(1)' || ' FROM ga_abocel a,' || ' WHERE cod_cliente =' || ev_cod_cliente || ' AND cod_plantarif =' || ev_cod_plantarif || ' AND cod_situacion NOT IN (' || cv_baja_abonado || ',' || cv_baja_abonadopdte || ')';

      SELECT COUNT (1)
        INTO sn_resultado
        FROM ga_abocel
       WHERE cod_cliente = ev_cod_cliente AND cod_plantarif = ev_cod_plantarif AND cod_situacion NOT IN (cv_baja_abonado, cv_baja_abonadopdte);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11157;
         sv_mens_retorno := 'error al consultar cantidad de abonados';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_num_abonados_cliente_PR(' || ev_cod_cliente || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_num_abonados_cliente_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_num_abonados_cliente_pr;

   PROCEDURE ve_cambia_modalidad_pr (
      en_num_serie             IN              al_series.num_serie%TYPE,
      en_canal                 IN              VARCHAR2,
      en_cod_modventa_origen   IN              ge_modventa.cod_modventa%TYPE,
      sn_modventa              OUT             ge_modventa.cod_modventa%TYPE,
      sn_desmodventa           OUT             ge_modventa.des_modventa%TYPE,
      sn_cod_retorno           OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno          OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_Cambia_modalidad_PR""
         Lenguaje="PL/SQL"
         Fecha="23-08-2007"
         Version="1.0.0"
         Dise?ador="NRCA"
         Programador="NRCA"
         Ambiente="BD"
      <Retorno>

       </Retorno>
      <Descripcion>
          Devuelve cantidad de abonados asociados al cliente
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EN_NUM_SERIE"  Tipo="STRING"> NÚMERO DE SERIE </param>
             <param nom="EN_CANAL" Tipo="STRING"> CODIGO CANAL DEL VENDEDOR </param>
               <param nom="EN_COD_MODVENTA_ORIGEN" Tipo="STRING"> CODIGO DE MODALIDAD DE VENTA ORIGEN </param>
      </Entrada>
      <Salida>
             <param nom="SN_MODVENTA"    Tipo="NUMBER"> CODIGO DE MODALIDAD DE VENTA NUEVA</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
       */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ev_tipstock    al_series.tip_stock%TYPE;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT TIP_STOCK' || ' FROM AL_SERIES' || ' WHERE NUM_SERIE = ' || en_num_serie;

      SELECT tip_stock
        INTO ev_tipstock
        FROM al_series
       WHERE num_serie = en_num_serie;

      BEGIN
         lv_ssql := 'SELECT COD_MODVENTA_NUE' || ' FROM GA_MODVENT_APLIC' || ' WHERE COD_PRODUCTO =1' || ' AND COD_CANAL =' || en_canal || ' AND TIP_STOCK =' || ev_tipstock || ' AND (COD_APLIC LIKE %GAC% OR COD_APLIC LIKE %GVD%)' || ' AND ROWNUM <=1';

         -- 0 INTERNO 1 EXTERNO
         SELECT cod_modventa_nue
           INTO sn_modventa
           FROM ga_modvent_aplic
          WHERE cod_producto = 1 AND cod_canal = DECODE (UPPER (en_canal), 'D', 0, 1) AND tip_stock = ev_tipstock AND cod_modventa = en_cod_modventa_origen AND (cod_aplic LIKE '%GAC%' OR cod_aplic LIKE '%GVD%') AND ROWNUM <= 1;

         IF sn_modventa IS NULL THEN
            sn_modventa := en_cod_modventa_origen;
            sn_cod_retorno := 0;
         END IF;

         lv_ssql := 'SELECT DES_MODVENTA' || ' FROM GE_MODVENTA' || ' WHERE COD_MODVENTA = ' || sn_modventa;

         SELECT des_modventa
           INTO sn_desmodventa
           FROM ge_modventa
          WHERE cod_modventa = sn_modventa;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            sn_modventa := en_cod_modventa_origen;
            sn_cod_retorno := 0;
      END;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11158;
         sv_mens_retorno := 'error al consultar cantidad de abonados asociados al cliente';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_Cambia_modalidad_PR(' || en_num_serie || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_Cambia_modalidad_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_cambia_modalidad_pr;

   PROCEDURE ve_datosvendedor_pr (
      en_codvendedor     IN              ve_vendedores.cod_vendedor%TYPE,
      en_coddealer       IN              ve_vendealer.cod_vendealer%TYPE,
      sv_nomvendedor     OUT NOCOPY      ve_vendedores.nom_vendedor%TYPE,
      sv_nomvendealer    OUT NOCOPY      ve_vendealer.nom_vendealer%TYPE,
      sn_codcliente      OUT NOCOPY      ve_vendedores.cod_cliente%TYPE,
      sn_codvende_raiz   OUT NOCOPY      ve_vendedores.cod_vende_raiz%TYPE,
      sv_codregion       OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_codprovincia    OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_codciudad       OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_codoficina      OUT NOCOPY      ve_vendedores.cod_oficina%TYPE,
      sv_codtipcomis     OUT NOCOPY      ve_tipcomis.cod_tipcomis%TYPE,
      sv_destipcomis     OUT NOCOPY      ve_tipcomis.des_tipcomis%TYPE,
      sn_indtipventa     OUT NOCOPY      ve_vendedores.ind_tipventa%TYPE,
      sn_indbloqueo      OUT NOCOPY      ve_vendedores.ve_indbloqueo%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
                                                              /*--
                                                              <Documentación TipoDoc = "Procedimiento">
                                                                 Elemento Nombre = "VE_datosvendedor_PR"
                                                                 Lenguaje="PL/SQL"
                                                                 Fecha="21-09-2007"
                                                                 Versión="1.0.0"
                                                                 Diseñador="Héctor Hermosilla"
                                                                 Programador="Héctor Hermosilla"
                                                                 Ambiente="BD"
                                                              <Retorno>Datos del vendedor</Retorno>
                                                              <Descripción>
                                                                 Datos del vendedor externo
                                                              </Descripción>
                                                              <Parametros>
                                                              <Entrada>
                                                                   <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
                                                                 <param nom="EN_coddealer"  Tipo="NUMBER">codigo de dealer</param>
                                                              </Entrada>
                                                              <Salida>
                                                                   <param nom="SV_nomvendedor"   Tipo="VARCHAR2">Nombre del vendedor</param>
                                                                 <param nom="SV_nomvendealer"  Tipo="VARCHAR2">Nombre del vendedor externo</param>
                                                                   <param nom="SN_codcliente"    Tipo="NUMBER">Codigo del cliente</param>
                                                                   <param nom="SN_codvende_raiz" Tipo="NUMBER">Codigo vendedor raiz</param>
                                                                   <param nom="SV_codregion"     Tipo="VARCHAR2">Codigo de region</param>
                                                                   <param nom="SV_codprovincia"  Tipo="VARCHAR2">Codigo de Provincia</param>
                                                                   <param nom="SV_codciudad"     Tipo="VARCHAR2">Codigo de ciudad</param>
                                                                   <param nom="SV_codoficina"    Tipo="VARCHAR2">Codigo oficina del vendedor</param>
                                                                   <param nom="SV_codtipcomis"   Tipo="VARCHAR2">Codigo tipo comisionista/param>
                                                                   <param nom="SV_destipcomis"   Tipo="VARCHAR2">descripcion tipo comisionista</param>
                                                                 <param nom="SN_indtipventa"   Tipo="NUMBER">Indicador tipo de venta</param>
                                                                 <param nom="SN_indbloqueo"    Tipo="NUMBER">Indicador de bloqueo</param>
                                                                   <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                   <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                   <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                              </Salida>
                                                              </Parametros>
                                                              </Elemento>
                                                              </Documentación>
                                                              */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_ssql                   ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF (en_coddealer = 0) THEN
         lv_ssql :=
            'SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz,'
            || ' direccion.cod_region, direccion.cod_provincia,'
            || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
            || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa, vend.ve_indbloqueo'
            || ' FROM   ve_vendedores vend, ge_direcciones direccion,'
            || ' ve_tipcomis tipo_comisionista'
            || ' WHERE  vend.cod_vendedor = ' || en_codvendedor
            || ' AND    vend.ind_interno = 1'
            || ' AND    direccion.cod_direccion = vend.cod_direccion'
            || ' AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis'
             || ' AND    tipo_comisionista.ind_vta_externa = 0';

         SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia, direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis, tipo_comisionista.des_tipcomis, vend.ind_tipventa,
                vend.ve_indbloqueo
           INTO sv_nomvendedor, sn_codcliente, sn_codvende_raiz, sv_codregion, sv_codprovincia, sv_codciudad, sv_codoficina, sv_codtipcomis, sv_destipcomis, sn_indtipventa,
                sn_indbloqueo
           FROM ve_vendedores vend, ge_direcciones direccion, ve_tipcomis tipo_comisionista
          WHERE vend.cod_vendedor = en_codvendedor
            AND vend.ind_interno = 1
            AND direccion.cod_direccion = vend.cod_direccion
            AND vend.cod_tipcomis = tipo_comisionista.cod_tipcomis
            AND tipo_comisionista.ind_vta_externa = 0;

      ELSE
         lv_ssql :=
            'SELECT vend.nom_vendedor,dealer.nom_vendealer, vend.cod_cliente,'
            || ' vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia,'
            || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
            || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa,vend.ve_indbloqueo'
            || ' FROM   ve_vendedores vend, ge_direcciones direccion,'
            || ' ve_tipcomis tipo_comisionista,ve_vendealer dealer'
            || ' WHERE  vend.cod_vendedor = ' || en_codvendedor
            || ' AND    vend.ind_interno = dealer.cod_vendedor'
            || ' AND    direccion.cod_direccion = vend.cod_direccion'
            || ' AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis'
            || ' AND    tipo_comisionista.ind_vta_externa = 1'
            || ' AND    vend.cod_vendedor = dealer.cod_vendedor'
            || ' AND    dealer.cod_vendealer = ' || en_coddealer;

         SELECT vend.nom_vendedor, dealer.nom_vendealer, vend.cod_cliente, vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia, direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis, tipo_comisionista.des_tipcomis,
                vend.ind_tipventa, vend.ve_indbloqueo
           INTO sv_nomvendedor, sv_nomvendealer, sn_codcliente, sn_codvende_raiz, sv_codregion, sv_codprovincia, sv_codciudad, sv_codoficina, sv_codtipcomis, sv_destipcomis,
                sn_indtipventa, sn_indbloqueo
           FROM ve_vendedores vend, ge_direcciones direccion, ve_tipcomis tipo_comisionista, ve_vendealer dealer
          WHERE vend.cod_vendedor = en_codvendedor
            AND vend.ind_interno = 0
            AND direccion.cod_direccion = vend.cod_direccion
            AND vend.cod_tipcomis = tipo_comisionista.cod_tipcomis
            AND tipo_comisionista.ind_vta_externa = 1
            AND vend.cod_vendedor = dealer.cod_vendedor
            AND dealer.cod_vendealer = en_coddealer;

      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 11198;
         sv_mens_retorno := 'Error al consultar datos del vendedor externo. No se retornaron registros';

         lv_des_error := SUBSTR ('NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11159;
         sv_mens_retorno := 'error al consultar datos del vendedor externo';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_datosvendedor_pr;

   PROCEDURE ve_getlistvendedores_pr (
      ev_cod_oficina    IN              VARCHAR2,
      ev_cod_tipcomis   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentacion TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_getListVendedores_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="01-10-2007"
                                                                Version="1.0.0"
                                                                Dise?ador="Héctor Hermosilla"
                                                                Programador="Héctor Hermosilla"
                                                                Ambiente="BD"
                                                             <Retorno>
                                                                 cursor
                                                             </Retorno>
                                                             <Descripcion>
                                                                Obtiene Listado vendedores
                                                             </Descripcion>
                                                             <Parametros>
                                                             <Entrada>
                                                                <param nom="EV_cod_oficina"       Tipo="STRING"> código oficina </param>
                                                                <param nom="EV_cod_tipcomis"      Tipo="STRING"> código tipo comisionista </param>
                                                             </Entrada>
                                                             <Salida>
                                                                 <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor vendedores </param>
                                                                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                                                                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                                                                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentacion>
                                                             --*/
   IS
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ve_vendedores a
       WHERE a.cod_oficina = ev_cod_oficina AND a.cod_tipcomis = ev_cod_tipcomis AND SYSDATE BETWEEN a.fec_contrato AND NVL (a.fec_fincontrato, SYSDATE);

      lv_sql :=
         'SELECT a.cod_vendedor, a.nom_vendedor ' || ' FROM ve_vendedores a ' || ' WHERE a.cod_oficina = ''' || ev_cod_oficina || '''' || ' AND a.cod_tipcomis = ''' || ev_cod_tipcomis || ''''
         || ' AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE)' || ' ORDER BY a.nom_vendedor';

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

      OPEN sc_cursordatos FOR lv_sql;
   /*LOOP
        FETCH SC_cursordatos INTO LV_codigo, LV_nombre;
        EXIT WHEN SC_cursordatos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('LV_nombre !!!' || LV_nombre);
   end loop;*/
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 11199;
         sv_mens_retorno := 'Error al consultar listado vendedores. No se retornaron registros';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendedores_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendedores_PR', lv_sql, sn_cod_retorno, lv_deserror);
      WHEN OTHERS THEN
         sn_cod_retorno := 11160;
         sv_mens_retorno := 'error al consultar listado vendedores';

         lv_deserror := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendedores_PR(' || ev_cod_oficina || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendedores_PR(' || ev_cod_oficina || ')', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistvendedores_pr;

   PROCEDURE ve_getlistvenddealer_pr (
      ev_cod_vendedor   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentacion TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_getListVendDealer_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="01-10-2007"
                                                                Version="1.0.0"
                                                                Dise?ador="Héctor Hermosilla"
                                                                Programador="Héctor Hermosilla"
                                                                Ambiente="BD"
                                                             <Retorno>
                                                                 cursor
                                                             </Retorno>
                                                             <Descripcion>
                                                                Obtiene Listado vendedores
                                                             </Descripcion>
                                                             <Parametros>
                                                             <Entrada>
                                                                <param nom="EV_cod_vendedor"       Tipo="STRING"> código vendedor </param>
                                                             </Entrada>
                                                             <Salida>
                                                                 <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor dealers </param>
                                                                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                                                                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                                                                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentacion>
                                                             --*/
   IS
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ve_vendealer a
       WHERE a.cod_vendedor = ev_cod_vendedor AND SYSDATE BETWEEN a.fec_contrato AND NVL (a.fec_fincontrato, SYSDATE);

      lv_sql := 'SELECT a.cod_vendealer, a.nom_vendealer ' || ' FROM ve_vendealer a ' || ' WHERE a.cod_vendedor = ''' || ev_cod_vendedor || '''' || ' AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE)' || ' ORDER BY a.nom_vendealer';

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

      OPEN sc_cursordatos FOR lv_sql;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 10860;
         sv_mens_retorno := 'Error al consultar listado vendealers. No se retornaron registros';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendDealer_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendDealer_PR', lv_sql, sn_cod_retorno, lv_deserror);
      WHEN OTHERS THEN
         sn_cod_retorno := 11161;
         sv_mens_retorno := 'error al consultar listado vendealers';

         lv_deserror := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendDealer_PR(' || ev_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendDealer_PR(' || ev_cod_vendedor || ')', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistvenddealer_pr;

   PROCEDURE ve_reversaventas_pr (
      en_num_venta      IN              ga_ventas.num_venta%TYPE,
      en_cod_vendedor   IN              ga_ventas.cod_vendedor%TYPE,
      ev_nom_usuario    IN              ga_ventas.nom_usuar_vta%TYPE,
      en_num_procfact   IN              fa_presupuesto.num_proceso%TYPE,
      en_num_transac    IN              ga_resnumcel.num_transaccion%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentacion TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_reversaVentas_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="10-10-2007"
                                                                Version="1.0.0"
                                                                Dise?ador="Héctor Hermosilla"
                                                                Programador="Héctor Hermosilla"
                                                                Ambiente="BD"
                                                             <Retorno>
                                                                 cursor
                                                             </Retorno>
                                                             <Descripcion>
                                                                Realiza reversa de ventas
                                                             </Descripcion>
                                                             <Parametros>
                                                             <Entrada>
                                                                <param nom="EN_cod_vendedor"       Tipo="NUMBER"> código vendedor </param>
                                                                <param nom="EN_num_venta"          Tipo="NUMBER"> numero de la venta </param>
                                                                <param nom="EV_nom_usuario"        Tipo="VARCHAR"> nombre usuario </param>
                                                                <param nom="EN_num_procfact"       Tipo="NUMBER"> numero proceso facturacion </param>
                                                             </Entrada>
                                                             <Salida>
                                                                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                                                                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                                                                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentacion>
                                                             --*/
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
      ln_cod_usuario         ga_abocel.cod_usuario%TYPE;
      lv_cod_plantarif       ga_abocel.cod_plantarif%TYPE;
      ln_cod_direccion       ge_direcciones.cod_direccion%TYPE;
      ln_cod_cliente         ga_abocel.cod_cliente%TYPE;
      lv_num_ident           ge_clientes.num_ident%TYPE;
      lv_tip_ident           ge_clientes.cod_tipident%TYPE;
      ln_num_venta           ga_ventas.num_venta%TYPE;
      ln_num_abonado         ga_abocel.num_abonado%TYPE;
      ln_num_solicitud       ert_solicitud.num_solicitud%TYPE;
      lv_ind_procequi        ga_equipaboser.ind_procequi%TYPE;
      lv_num_seriemec        ga_equipaboser.num_seriemec%TYPE;
      ln_tip_stock           ga_equipaboser.tip_stock%TYPE;
      ln_cod_bodega          ga_equipaboser.cod_bodega%TYPE;
      ln_cod_articulo        ga_equipaboser.cod_articulo%TYPE;
      ln_cod_uso             ga_equipaboser.cod_uso%TYPE;
      ln_cod_estado          ga_equipaboser.cod_estado%TYPE;
      ln_ind_telefono        ga_abocel.ind_telefono%TYPE;
      ln_num_celular         ga_abocel.num_celular%TYPE;
      lv_num_serie           ga_equipaboser.num_serie%TYPE;
      lv_nummovimiento       VARCHAR2 (20);
      lv_indsercontel        VARCHAR2 (20);

      CURSOR cursorventas IS
         SELECT   a.num_abonado, a.ind_telefono, a.num_celular, a.cod_usuario, a.cod_plantarif, a.cod_cliente
             FROM ga_abocel a
            WHERE a.num_venta = en_num_venta
         ORDER BY a.num_abonado;

      CURSOR cursordirecciones IS
         SELECT a.cod_direccion
           FROM ga_direcusuar a
          WHERE a.cod_usuario = ln_cod_usuario;

      CURSOR cursorarticulos IS
         SELECT ind_procequi, num_seriemec, tip_stock, cod_bodega, cod_articulo, cod_uso, cod_estado, num_serie
           FROM ga_equipaboser
          WHERE num_abonado = ln_num_abonado;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'UPDATE fa_interfact' || ' SET cod_estadoc = ' || cn_estado_doc || ',' || ' cod_estproc = ' || cn_estado_proc || ',' || ' nom_usuaelim =''' || ev_nom_usuario || ''',' || ' cod_causaelim =''' || cv_causa_elimin || '''' || ' WHERE num_venta ='
         || en_num_venta;

      UPDATE fa_interfact
         SET cod_estadoc = cn_estado_doc,
             cod_estproc = cn_estado_proc,
             nom_usuaelim = ev_nom_usuario,
             cod_causaelim = cv_causa_elimin
       WHERE num_venta = en_num_venta;

      lv_sql := 'DELETE' || ' FROM fa_presupuesto' || ' WHERE num_proceso =' || en_num_procfact;

      DELETE FROM fa_presupuesto
            WHERE num_proceso = en_num_procfact;

      OPEN cursorventas;

      LOOP
         FETCH cursorventas
          INTO ln_num_abonado, ln_ind_telefono, ln_num_celular, ln_cod_usuario, lv_cod_plantarif, ln_cod_cliente;

         EXIT WHEN cursorventas%NOTFOUND;
         lv_sql := 'SELECT a.num_ident, a.cod_tipident' || ' FROM ge_clientes a' || ' WHERE a.cod_cliente =' || ln_cod_cliente;

         SELECT a.num_ident, a.cod_tipident
           INTO lv_num_ident, lv_tip_ident
           FROM ge_clientes a
          WHERE a.cod_cliente = ln_cod_cliente;

         OPEN cursorarticulos;

         LOOP
            FETCH cursorarticulos
             INTO lv_ind_procequi, lv_num_seriemec, ln_tip_stock, ln_cod_bodega, ln_cod_articulo, ln_cod_uso, ln_cod_estado, lv_num_serie;

            EXIT WHEN cursorarticulos%NOTFOUND;

            IF (lv_num_serie IS NULL OR lv_num_serie = '') THEN
               lv_num_serie := lv_num_seriemec;
            END IF;

            lv_sql :=
               'VE_intermediario_quiosco_PG.VE_actualiza_stock_PR(5,' || ln_tip_stock || ',' || ln_cod_bodega || ',' || ln_cod_articulo || ',' || ln_cod_uso || ',' || '1' || ',' || en_num_venta || ',' || lv_num_serie || ',' || ln_ind_telefono || ','
               || lv_nummovimiento || ',' || lv_indsercontel || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
            -- llamar procedimiento p_GA_INTERAL para desreservar simcard
            --ve_intermediario_quiosco_pg.ve_actualiza_stock_pr ('5', ln_tip_stock, ln_cod_bodega, ln_cod_articulo, ln_cod_uso, '1', en_num_venta, lv_num_serie, ln_ind_telefono, lv_nummovimiento, lv_indsercontel, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
            -- Desreserva el articulo
            lv_sql := 'DELETE' || ' FROM ga_reservart' || ' WHERE num_transaccion = ' || en_num_transac || ' AND num_serie =''' || lv_num_serie || '''';

            DELETE FROM ga_reservart
                  WHERE num_transaccion = en_num_transac AND num_serie = lv_num_serie;
         END LOOP;

         CLOSE cursorarticulos;

         ln_contador := 0;
         lv_sql :=
            'SELECT COUNT(1)' || ' FROM ert_solicitud a, ert_solicitud_planes b' || ' WHERE a.num_ident_cliente =''' || lv_num_ident || '''' || ' AND a.cod_tipident = ''' || lv_tip_ident || '''' || ' AND a.num_solicitud = b.num_solicitud'
            || ' AND a.ind_tipo_solicitud = 1' || ' AND a.ind_evento = 0' || ' AND a.cod_estado IN(1,2)' || ' AND b.cod_plantarif =''' || lv_cod_plantarif || '''';

         SELECT COUNT (1)
           INTO ln_contador
           FROM ert_solicitud a, ert_solicitud_planes b
          WHERE a.num_ident_cliente = lv_num_ident AND a.cod_tipident = lv_tip_ident AND a.num_solicitud = b.num_solicitud AND a.ind_tipo_solicitud = 1 AND a.ind_evento = 0 AND a.cod_estado IN (1, 2) AND b.cod_plantarif = lv_cod_plantarif;

         IF (ln_contador != 0) THEN
            lv_sql :=
               'SELECT  a.num_solicitud' || ' FROM ert_solicitud a, ert_solicitud_planes b' || ' WHERE a.num_ident_cliente =''' || lv_num_ident || '''' || ' AND a.cod_tipident = ''' || lv_tip_ident || '''' || ' AND a.num_solicitud = b.num_solicitud'
               || ' AND a.ind_tipo_solicitud = 1' || ' AND a.ind_evento = 0' || ' AND a.cod_estado IN(1,2)' || ' AND b.cod_plantarif =''' || lv_cod_plantarif || '''';

            SELECT a.num_solicitud
              INTO ln_num_solicitud
              FROM ert_solicitud a, ert_solicitud_planes b
             WHERE a.num_ident_cliente = lv_num_ident AND a.cod_tipident = lv_tip_ident AND a.num_solicitud = b.num_solicitud AND a.ind_tipo_solicitud = 1 AND a.ind_evento = 0 AND a.cod_estado IN (1, 2) AND b.cod_plantarif = lv_cod_plantarif;

            lv_sql := 'UPDATE ert_solicitud_planes' || ' SET val_cant_vendidos = val_cant_vendidos - 1' || ' WHERE num_solicitud = ' || ln_num_solicitud;

            UPDATE ert_solicitud_planes
               SET val_cant_vendidos = val_cant_vendidos - 1
             WHERE num_solicitud = ln_num_solicitud;
         END IF;

         --Reversa cantidad de abonados en cliente tipo empresa
         lv_sql := 'UPDATE ga_empresa a' || ' SET a.num_abonados = a.num_abonados - 1' || ' WHERE a.cod_cliente =' || ln_cod_cliente;

         UPDATE ga_empresa a
            SET a.num_abonados = a.num_abonados - 1
          WHERE a.cod_cliente = ln_cod_cliente;

         --Elimina cargos asociado al abonado
         lv_sql := 'DELETE' || ' FROM ge_cargos' || ' WHERE num_abonado = ' || ln_num_abonado;

         DELETE FROM ge_cargos
               WHERE num_abonado = ln_num_abonado;

         --Elimina abonado asociado a la venta
         lv_sql := 'DELETE' || ' FROM ga_servsuplabo' || ' WHERE num_abonado = ' || ln_num_abonado;

         DELETE FROM ga_servsuplabo
               WHERE num_abonado = ln_num_abonado;

         lv_sql := 'DELETE' || ' FROM ga_equipaboser' || ' WHERE num_abonado = ' || ln_num_abonado;

         DELETE FROM ga_equipaboser
               WHERE num_abonado = ln_num_abonado;

         lv_sql := 'UPDATE icc_movimiento a' || ' SET a.cod_estado = 10' || ' WHERE a.num_abonado = ' || ln_num_abonado;

         UPDATE icc_movimiento a
            SET a.cod_estado = '10'
          WHERE a.num_abonado = ln_num_abonado;

         lv_sql := 'DELETE' || ' FROM ga_abocel' || ' WHERE num_abonado = ' || ln_num_abonado;

         DELETE FROM ga_abocel
               WHERE num_abonado = ln_num_abonado;

         --1.Elimina direcciones asociadas al usuario
         lv_sql := 'DELETE' || ' FROM ga_direcusuar' || ' WHERE cod_usuario =' || ln_cod_usuario;

         DELETE FROM ga_direcusuar
               WHERE cod_usuario = ln_cod_usuario;

         OPEN cursordirecciones;

         LOOP
            FETCH cursordirecciones
             INTO ln_cod_direccion;

            EXIT WHEN cursordirecciones%NOTFOUND;
            lv_sql := 'DELETE' || ' FROM ge_direcciones' || ' WHERE cod_direccion =' || ln_cod_direccion;

            DELETE FROM ge_direcciones
                  WHERE cod_direccion = ln_cod_direccion;
         END LOOP;

         CLOSE cursordirecciones;

         --Elimina usuario asociado a la linea
         lv_sql := 'DELETE' || ' FROM ga_usuarios' || ' WHERE cod_usuario =' || ln_cod_usuario;

         DELETE FROM ga_usuarios
               WHERE cod_usuario = ln_cod_usuario;

         --Elimina reserva de numero celular
         ln_contador := 0;

         SELECT COUNT (1)
           INTO ln_contador
           FROM ga_resnumcel
          WHERE num_celular = ln_num_celular;

         IF (ln_contador > 0) THEN
            lv_sql := 'VE_intermediario_quiosco_PG.VE_reponeNumeracion_PR(' || ln_num_celular || ',' || cv_repone_celular || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
            --ve_intermediario_quiosco_pg.ve_reponenumeracion_pr (ln_num_celular, cv_repone_celular, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
            lv_sql := 'VE_intermediario_quiosco_PG.VE_reponeNumeracion_PR(' || ln_num_celular || ',' || cv_repone_cel_res || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
            --ve_intermediario_quiosco_pg.ve_reponenumeracion_pr (ln_num_celular, cv_repone_cel_res, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
            lv_sql := 'DELETE' || ' FROM ga_resnumcel' || ' WHERE num_transaccion = ' || en_num_transac || ' AND num_celular =' || ln_num_celular;

            DELETE FROM ga_resnumcel
                  WHERE num_transaccion = en_num_transac AND num_celular = ln_num_celular;
         END IF;

         lv_sql := 'DELETE' || ' FROM ga_transacventa' || ' WHERE num_abonado =' || ln_num_abonado;

         DELETE FROM ga_transacventa
               WHERE num_abonado = ln_num_abonado;
      END LOOP;

      lv_sql := 'DELETE' || ' FROM ga_docventa' || ' WHERE num_venta =' || en_num_venta;

      DELETE FROM ga_docventa
            WHERE num_venta = en_num_venta;

      lv_sql := 'DELETE' || ' FROM ga_ventas' || ' WHERE num_venta =' || en_num_venta;

      DELETE FROM ga_ventas
            WHERE num_venta = en_num_venta;

      lv_sql := 'DELETE' || ' FROM ga_contcta' || ' WHERE num_venta =' || en_num_venta;

      DELETE FROM ga_contcta
            WHERE num_venta = en_num_venta;

      COMMIT;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         sn_cod_retorno := 11162;
         sv_mens_retorno := 'error al realizar reversa de ventas';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_reversaVentas_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_reversaVentas_PR', lv_sql, sn_cod_retorno, lv_deserror);
      WHEN OTHERS THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         sn_cod_retorno := 11162;
         sv_mens_retorno := 'error al realizar reversa de ventas';

         lv_deserror := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_reversaVentas_PR(' || en_num_venta || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_reversaVentas_PR(' || en_num_venta || ')', lv_sql, SQLCODE, lv_deserror);
   END ve_reversaventas_pr;

   PROCEDURE ve_eliminarescel_pr (
      en_num_venta      IN              ga_ventas.num_venta%TYPE,
      en_num_transac    IN              ga_resnumcel.num_transaccion%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentacion TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_eliminarescel_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="09-11-2007"
                                                                Version="1.0.0"
                                                                Dise?ador="Héctor Hermosilla"
                                                                Programador="Héctor Hermosilla"
                                                                Ambiente="BD"
                                                             <Retorno>
                                                                 cursor
                                                             </Retorno>
                                                             <Descripcion>
                                                                Elimina reserva temporal de numero celular
                                                             </Descripcion>
                                                             <Parametros>
                                                             <Entrada>
                                                                <param nom="EN_num_venta"     Tipo="NUMBER"> numero de la venta </param>
                                                                <param nom="EN_num_procfact"  Tipo="NUMBER"> numero transaccion</param>
                                                             </Entrada>
                                                             <Salida>
                                                                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                                                                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                                                                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentacion>
                                                             --*/
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
      ln_num_celular         ga_abocel.num_celular%TYPE;

      CURSOR cursorventas IS
         SELECT a.num_celular
           FROM ga_abocel a
          WHERE a.num_venta = en_num_venta
         UNION
         SELECT a.num_celular
           FROM ga_aboamist a
          WHERE a.num_venta = en_num_venta;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      OPEN cursorventas;

      LOOP
         FETCH cursorventas
          INTO ln_num_celular;

         EXIT WHEN cursorventas%NOTFOUND;
         --Elimina reserva de numero celular
         ln_contador := 0;

         SELECT COUNT (1)
           INTO ln_contador
           FROM ga_resnumcel
          WHERE num_celular = ln_num_celular;

         IF (ln_contador > 0) THEN
            DELETE FROM ga_resnumcel
                  WHERE num_transaccion = en_num_transac AND num_celular = ln_num_celular;
         END IF;
      END LOOP;

      COMMIT;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         sn_cod_retorno := 11163;
         sv_mens_retorno := 'error al eliminar reserva temporal de numero celular';

         lv_deserror := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_eliminarescel_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_eliminarescel_PR', lv_sql, sn_cod_retorno, lv_deserror);
      WHEN OTHERS THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         sn_cod_retorno := 11163;
         sv_mens_retorno := 'error al eliminar reserva temporal de numero celular';

         lv_deserror := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_eliminarescel_PR(' || en_num_venta || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_eliminarescel_PR(' || en_num_venta || ')', lv_sql, SQLCODE, lv_deserror);
   END ve_eliminarescel_pr;

   PROCEDURE ve_inserta_ga_docventa_pr (
      en_num_venta      IN              ga_docventa.num_venta%TYPE,
      en_cod_tipdocum   IN              ga_docventa.cod_tipdocum%TYPE,
      ev_num_folio      IN              ga_docventa.num_folio%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
         <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_inserta_ga_docventa_PR
            Lenguaje="PL/SQL"
            Fecha="18-05-2007"
            Version="1.0.0"
            Dise?ador="Raúl Lozano"
            Programador="Raúl Lozano"
            Ambiente="BD"
         <Retorno>NA</Retorno>
         <Descripcion>
            Inserta en ga_docventa
         </Descripcion>
         <Parametros>
         <Entrada>
            <param nom="EN_NUM_VENTA"     Tipo="NUMBER"> numero de venta </param>
            <param nom="EN_COD_TIPDOCUM"  Tipo="NUMBER"> código tipo de docto </param>
            <param nom="EV_NUM_FOLIO"     Tipo="VARCHAR2"> numero folio</param>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
         </Salida>
         </Parametros>
         </Elemento>
         </Documentacion>
         --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'INSERT INTO ga_docventa' || '(num_venta, cod_tipdocum, num_folio)' || 'VALUES (' || en_num_venta || ',' || en_cod_tipdocum || ',' || ev_num_folio || ')';

      INSERT INTO ga_docventa
                  (num_venta, cod_tipdocum, num_folio)
      VALUES      (en_num_venta, en_cod_tipdocum, ev_num_folio);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11164;
         sv_mens_retorno := 'error al insertar documento de venta';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_ga_docventa_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_ga_docventa_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_inserta_ga_docventa_pr;

   PROCEDURE ve_inserta_al_petigiasabo_pr (
      en_cod_articulo   IN              al_petiguias_abo.cod_articulo%TYPE,
      en_cod_bodega     IN              al_petiguias_abo.cod_bodega%TYPE,
      en_cod_cliente    IN              al_petiguias_abo.cod_cliente%TYPE,
      en_cod_concepto   IN              al_petiguias_abo.cod_concepto%TYPE,
      ev_cod_moneda     IN              al_petiguias_abo.cod_moneda%TYPE,
      ev_cod_oficina    IN              al_petiguias_abo.cod_oficina%TYPE,
      en_num_abonado    IN              al_petiguias_abo.num_abonado%TYPE,
      en_num_cantidad   IN              al_petiguias_abo.num_cantidad%TYPE,
      en_num_cargo      IN              al_petiguias_abo.num_cargo%TYPE,
      en_num_orden      IN              al_petiguias_abo.num_orden%TYPE,
      en_num_peticion   IN              al_petiguias_abo.num_peticion%TYPE,
      ev_num_serie      IN              al_petiguias_abo.num_serie%TYPE,
      en_num_telefono   IN              al_petiguias_abo.num_telefono%TYPE,
      en_num_venta      IN              al_petiguias_abo.num_venta%TYPE,
      en_val_linea      IN              al_petiguias_abo.val_linea%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
         <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_inserta_al_PetiGiasAbo_PR
            Lenguaje="PL/SQL"
            Fecha="18-05-2007"
            Version="1.0.0"
            Dise?ador="Raúl Lozano"
            Programador="Raúl Lozano"
            Ambiente="BD"
         <Retorno>NA</Retorno>
         <Descripcion>
            Inserta al_petiguias_abo
         </Descripcion>
         <Parametros>
         <Entrada>
            <param nom="SO_AlPetiguiasAbo     Tipo="TIP_AL_PETIGUIAS_ABO> Estructura de AL_PETIGUIAS_ABO</param>
         <Salida>
            <param nom="SO_AlPetiguiasAbo"  Tipo="SO_AlPetiguiasAbo"> Estructura de AL_PETIGUIAS_ABO</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
         </Salida>
         </Parametros>
         </Elemento>
         </Documentacion>
         --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'INSERT INTO al_petiguias_abo (cod_articulo, cod_bodega, cod_cliente, cod_concepto, cod_moneda, ';
      lv_ssql := lv_ssql || 'cod_oficina, num_abonado, num_cantidad, num_cargo, num_orden, ';
      lv_ssql := lv_ssql || ' num_peticion, num_serie, num_telefono, num_venta, val_linea) ';
      lv_ssql := lv_ssql || ' VALUES( ' || en_cod_articulo || ',' || en_cod_bodega || ',' || en_cod_cliente;
      lv_ssql := lv_ssql || ' ' || en_cod_concepto || ',' || ev_cod_moneda || ',' || ev_cod_oficina;
      lv_ssql := lv_ssql || ' ' || en_num_abonado || ',' || en_num_cantidad || ',' || en_num_cargo;
      lv_ssql := lv_ssql || ' ' || en_num_orden || ',' || en_num_peticion || ',' || ev_num_serie;
      lv_ssql := lv_ssql || ' ' || en_num_telefono || ',' || en_num_venta || ',' || en_val_linea;

      INSERT INTO al_petiguias_abo
                  (cod_articulo, cod_bodega, cod_cliente, cod_concepto, cod_moneda, cod_oficina, num_abonado, num_cantidad, num_cargo, num_orden, num_peticion, num_serie, num_telefono, num_venta, val_linea)
      VALUES      (en_cod_articulo, en_cod_bodega, en_cod_cliente, en_cod_concepto, ev_cod_moneda, ev_cod_oficina, en_num_abonado, en_num_cantidad, en_num_cargo, en_num_orden, en_num_peticion, ev_num_serie, en_num_telefono, en_num_venta, en_val_linea);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11165;                                                                                                                                                                     --No es posible registrar peticiones de guías de despacho
         sv_mens_retorno := 'error al insertar en al_petiguias_abo';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_al_PetiGiasAbo_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_al_PetiGiasAbo_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_inserta_al_petigiasabo_pr;

   PROCEDURE ve_inserta_ctecontrato_pr (
      en_codcliente       IN              VARCHAR2,
      ev_codplantarif     IN              VARCHAR2,
      en_coduso           IN              VARCHAR2,
      en_codproducto      IN              VARCHAR2,
      ev_codtipcontrato   IN              VARCHAR2,
      ev_nomusuario       IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_inserta_CteContrato_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta relacion cliente contrato
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
         <param nom="EV_codPlantarif"    Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="EN_codUso"          Tipo="NUMBER"> codigo uso</param>
         <param nom="EN_codProducto"     Tipo="NUMBER"> codigo producto</param>
         <param nom="EV_codTipcontrato"  Tipo="STRING"> codigo tipo contrato </param>
         <param nom="EV_nomUsuario"      Tipo="STRING"> nombre usuario </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'INSERT INTO ga_cliecontrato_to (' || ' cod_cliente,' || ' cod_plantarif,' || ' cod_uso,' || ' cod_producto,' || ' cod_tipcontrato,' || ' fec_desde,' || ' nom_usuario)' || ' VALUES (' || en_codcliente || ',' || ev_codplantarif || ','
         || en_coduso || ',' || en_codproducto || ',' || ev_codtipcontrato || ',TRUNC(SYSDATE)' || ',' || ev_nomusuario || ')';

      /*INSERT INTO ga_cliecontrato_to
                  (cod_cliente, cod_plantarif, cod_uso, cod_producto, cod_tipcontrato, fec_desde, nom_usuario)
      VALUES      (en_codcliente, ev_codplantarif, en_coduso, en_codproducto, ev_codtipcontrato, TRUNC (SYSDATE), ev_nomusuario);*/
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11166;
         sv_mens_retorno := 'error al insertar relacion cliente contrato';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_CteContrato_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_CteContrato_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_inserta_ctecontrato_pr;

   PROCEDURE ve_inserta_ctecontrato_web_pr (
      en_codcliente       IN              VARCHAR2,
      ev_codplantarif     IN              VARCHAR2,
      en_coduso           IN              VARCHAR2,
      en_codproducto      IN              VARCHAR2,
      ev_codtipcontrato   IN              VARCHAR2,
      ev_nomusuario       IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_inserta_CteContrato_WEB_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Inserta relacion cliente contrato
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
         <param nom="EV_codPlantarif"    Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="EN_codUso"          Tipo="NUMBER"> codigo uso</param>
         <param nom="EN_codProducto"     Tipo="NUMBER"> codigo producto</param>
         <param nom="EV_codTipcontrato"  Tipo="STRING"> codigo tipo contrato </param>
         <param nom="EV_nomUsuario"      Tipo="STRING"> nombre usuario </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      PRAGMA AUTONOMOUS_TRANSACTION;
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'INSERT INTO ga_cliecontrato_to (' || ' cod_cliente,' || ' cod_plantarif,' || ' cod_uso,' || ' cod_producto,' || ' cod_tipcontrato,' || ' fec_desde,' || ' nom_usuario)' || ' VALUES (' || en_codcliente || ',' || ev_codplantarif || ','
         || en_coduso || ',' || en_codproducto || ',' || ev_codtipcontrato || ',TRUNC(SYSDATE)' || ',' || ev_nomusuario || ')';

      /*INSERT INTO ga_cliecontrato_to
                  (cod_cliente, cod_plantarif, cod_uso, cod_producto, cod_tipcontrato, fec_desde, nom_usuario)
      VALUES      (en_codcliente, ev_codplantarif, en_coduso, en_codproducto, ev_codtipcontrato, TRUNC (SYSDATE), ev_nomusuario);*/

      COMMIT;
   EXCEPTION
      WHEN OTHERS THEN
         --inc. 9481822-06-2009
         ROLLBACK;
         --fin inc. 9481822-06-2009
         sn_cod_retorno := 11167;
         sv_mens_retorno := 'error al insertar relacion cliente contrato web';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_CteContrato_WEB_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_inserta_CteContrato_WEB_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_inserta_ctecontrato_web_pr;

   PROCEDURE ve_inserta_ctecontrato_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   VARCHAR2,
      ev_codplantarif     IN   VARCHAR2,
      en_coduso           IN   VARCHAR2,
      en_codproducto      IN   VARCHAR2,
      ev_codtipcontrato   IN   VARCHAR2,
      ev_nomusuario       IN   VARCHAR2) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_inserta_CteContrato_FS_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
           Por medio de la tabla GA_TRANSACABO el VB obtendra el resultado de ejecucion.
          Cada dato agregado en el campo DES_CADENA, debe ir separado por / para el VB.
      </Retorno>
      <Descripción>
         Mascara para ser llamada desde los VB
      </Descripción>
      <Parámetros>
        <Entrada>
          <param nom="EN_numTransaccion"  Tipo="NUMBER"> numero de la transaccion </param>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
         <param nom="EV_codPlantarif"    Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="EN_codUso"          Tipo="NUMBER"> codigo uso</param>
         <param nom="EN_codProducto"     Tipo="NUMBER"> codigo producto</param>
         <param nom="EV_codTipcontrato"  Tipo="STRING"> codigo tipo contrato </param>
         <param nom="EV_nomUsuario"      Tipo="STRING"> nombre usuario </param>
      </Entrada>
      <Salida> N/A </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      fin_proceso       EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      ln_cod_retorno    ge_errores_pg.coderror;
      lv_mens_retorno   ge_errores_pg.msgerror;
      ln_num_evento     ge_errores_pg.evento;
   BEGIN
      ln_cod_retorno := 0;
      lv_mens_retorno := NULL;
      ln_num_evento := 0;
      ve_inserta_ctecontrato_pr (en_codcliente, ev_codplantarif, en_coduso, en_codproducto, ev_codtipcontrato, ev_nomusuario, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF (ln_cod_retorno <> 0) THEN
         ln_cod_retorno := 4;
         lv_mens_retorno := '/ERROR' || '/' || TO_CHAR (ln_num_evento);
         RAISE fin_proceso;
      END IF;

      lv_mens_retorno := '/OK';
      RAISE fin_proceso;
   EXCEPTION
      WHEN fin_proceso THEN
         INSERT INTO ga_transacabo
                     (num_transaccion, cod_retorno, des_cadena)
         VALUES      (en_nuntransaccion, ln_cod_retorno, lv_mens_retorno);
      WHEN OTHERS THEN
         RAISE fin_proceso;
   END ve_inserta_ctecontrato_fs_pr;

   PROCEDURE ve_elimina_ctecontrato_pr (
      en_codcliente     IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_elimina_CteContrato_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Elimina relacion cliente contrato
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'DELETE FROM ga_cliecontrato_to a' || ' WHERE a.cod_cliente = ' || en_codcliente;

     /* DELETE FROM ga_cliecontrato_to a
            WHERE a.cod_cliente = en_codcliente;*/
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11168;
         sv_mens_retorno := 'error al eliminar relacion cliente contrato';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_elimina_CteContrato_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_elimina_CteContrato_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_elimina_ctecontrato_pr;

   PROCEDURE ve_elimina_ctecontrato_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   VARCHAR2) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_elimina_CteContrato_FS_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
           Por medio de la tabla GA_TRANSACABO el VB obtendra el resultado de ejecucion.
          Cada dato agregado en el campo DES_CADENA, debe ir separado por / para el VB.
      </Retorno>
      <Descripción>
         Mascara para ser llamada desde los VB
      </Descripción>
      <Parámetros>
        <Entrada>
          <param nom="EN_numTransaccion"  Tipo="NUMBER"> numero de la transaccion </param>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
      </Entrada>
      <Salida> N/A </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      fin_proceso       EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      ln_cod_retorno    ge_errores_pg.coderror;
      lv_mens_retorno   ge_errores_pg.msgerror;
      ln_num_evento     ge_errores_pg.evento;
   BEGIN
      ln_cod_retorno := 0;
      lv_mens_retorno := NULL;
      ln_num_evento := 0;
      ve_elimina_ctecontrato_pr (en_codcliente, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF (ln_cod_retorno <> 0) THEN
         ln_cod_retorno := 4;
         lv_mens_retorno := '/ERROR' || '/' || TO_CHAR (ln_num_evento);
         RAISE fin_proceso;
      END IF;

      lv_mens_retorno := '/OK';
      RAISE fin_proceso;
   EXCEPTION
      WHEN fin_proceso THEN
         INSERT INTO ga_transacabo
                     (num_transaccion, cod_retorno, des_cadena)
         VALUES      (en_nuntransaccion, ln_cod_retorno, lv_mens_retorno);
      WHEN OTHERS THEN
         RAISE fin_proceso;
   END ve_elimina_ctecontrato_fs_pr;

   PROCEDURE ve_obtiene_tipcontrato_pr (
      en_codcliente       IN              VARCHAR2,
      sv_codplantarif     OUT NOCOPY      VARCHAR2,
      sn_coduso           OUT NOCOPY      VARCHAR2,
      sn_codproducto      OUT NOCOPY      VARCHAR2,
      sv_codtipcontrato   OUT NOCOPY      VARCHAR2,
      sv_nomtipcontrato   OUT NOCOPY      ga_tipcontrato.des_tipcontrato%TYPE,
      sn_nummesestipcon   OUT NOCOPY      ga_tipcontrato.meses_minimo%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_TipContrato_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene tipo de contrato, uso, plan tarifario y producto
         para el cliente
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
      </Entrada>
      <Salida>
         <param nom="SV_codPlantarif"   Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="SN_codUso"         Tipo="NUMBER"> codigo uso</param>
         <param nom="SN_codProducto"    Tipo="NUMBER"> codigo producto</param>
         <param nom="SV_codTipcontrato" Tipo="STRING"> codigo tipo contrato </param>
         <param nom="SV_nomTipcontrato" Tipo="STRING"> nombre tipo contrato </param>
         <param nom="SN_numMesesTipcon" Tipo="NUMBER"> numero meses tipo contrato </param>
         <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sv_codtipcontrato := '';
      lv_ssql :=
         'SELECT a.cod_tipcontrato,a.cod_plantarif,a.cod_uso,a.cod_producto,' || ' b.des_tipcontrato,b.meses_minimo' || ' FROM ga_cliecontrato_to a, ga_tipcontrato b' || ' WHERE a.cod_cliente = ' || en_codcliente
         || ' AND b.cod_tipcontrato = a.cod_tipcontrato';

     /* SELECT a.cod_tipcontrato, a.cod_plantarif, a.cod_uso, a.cod_producto, b.des_tipcontrato, b.meses_minimo
        INTO sv_codtipcontrato, sv_codplantarif, sn_coduso, sn_codproducto, sv_nomtipcontrato, sn_nummesestipcon
        FROM ga_cliecontrato_to a, ga_tipcontrato b
       WHERE a.cod_cliente = en_codcliente AND b.cod_tipcontrato = a.cod_tipcontrato;*/
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10861;
         sv_mens_retorno := 'Error al consultar tipo contrato. No se retornaron registros';

      WHEN OTHERS THEN
         sn_cod_retorno := 11169;
         sv_mens_retorno := 'error al consultar tipo contrato';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_TipContrato_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_TipContrato_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_tipcontrato_pr;

   PROCEDURE ve_obtiene_tipcontrato_pr (
      en_codcliente       IN              VARCHAR2,
      sv_codplantarif     OUT NOCOPY      VARCHAR2,
      sn_coduso           OUT NOCOPY      VARCHAR2,
      sn_codproducto      OUT NOCOPY      VARCHAR2,
      sv_codtipcontrato   OUT NOCOPY      VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_TipContrato_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene tipo de contrato, uso, plan tarifario y producto
         para el cliente
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
      </Entrada>
      <Salida>
         <param nom="SV_codPlantarif"   Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="SN_codUso"         Tipo="NUMBER"> codigo uso</param>
         <param nom="SN_codProducto"    Tipo="NUMBER"> codigo producto</param>
         <param nom="SV_codTipcontrato" Tipo="STRING"> codigo tipo contrato </param>
         <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sv_codtipcontrato := '';
      lv_ssql := 'SELECT a.cod_tipcontrato,a.cod_plantarif,a.cod_uso,a.cod_producto' || ' FROM ga_cliecontrato_to a' || ' WHERE a.cod_cliente = ' || en_codcliente;

      /*SELECT a.cod_tipcontrato, a.cod_plantarif, a.cod_uso, a.cod_producto
        INTO sv_codtipcontrato, sv_codplantarif, sn_coduso, sn_codproducto
        FROM ga_cliecontrato_to a
       WHERE a.cod_cliente = en_codcliente;*/
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10862;
         sv_mens_retorno := 'Error al consultar tipo contrato. No se retornaron registros';

         lv_des_error := SUBSTR ('NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_TipContrato_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_TipContrato_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11170;
         sv_mens_retorno := 'error al consultar tipo contrato';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_TipContrato_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_TipContrato_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_tipcontrato_pr;

   PROCEDURE ve_obtiene_tipcontrato_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   VARCHAR2) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_TipContrato_FS_PR
         Lenguaje="PL/SQL"
         Fecha="04-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
           Por medio de la tabla GA_TRANSACABO el VB obtendra el resultado de ejecucion.
          Cada dato agregado en el campo DES_CADENA, debe ir separado por / para el VB.
      </Retorno>
      <Descripción>
         Mascara para ser llamada desde los VB
      </Descripción>
      <Parámetros>
        <Entrada>
          <param nom="EN_numTransaccion"  Tipo="NUMBER"> numero de la transaccion </param>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
         <param nom="EV_codPlantarif"    Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="EN_codUso"          Tipo="NUMBER"> codigo uso</param>
         <param nom="EN_codProducto"     Tipo="NUMBER"> codigo producto</param>
      </Entrada>
      <Salida> N/A </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      fin_proceso         EXCEPTION;
      lv_des_error        ge_errores_pg.desevent;
      lv_sql              ge_errores_pg.vquery;
      ln_cod_retorno      ge_errores_pg.coderror;
      lv_mens_retorno     ge_errores_pg.msgerror;
      ln_num_evento       ge_errores_pg.evento;
      lv_codtipcontrato   VARCHAR2(200);
      lv_codplantarif     VARCHAR2(200);
      ln_coduso           VARCHAR2(200);
      ln_codproducto      VARCHAR2(200);
   BEGIN
      ln_cod_retorno := 0;
      lv_mens_retorno := NULL;
      ln_num_evento := 0;
      ve_obtiene_tipcontrato_pr (en_codcliente, lv_codplantarif, ln_coduso, ln_codproducto, lv_codtipcontrato, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF (ln_cod_retorno <> 0) THEN
         IF (ln_cod_retorno = 156) THEN
            ln_cod_retorno := 4;
            lv_mens_retorno := '/ERROR' || '/' || TO_CHAR (ln_num_evento) || '/0/0';
         ELSE
            ln_cod_retorno := 0;
            lv_mens_retorno := '/NOFOUND/NOFOUND/0/0';                                                                                                                                              -- debe ser  NOFOUND ya que los VB esperan esa palabra !!!
         END IF;

         RAISE fin_proceso;
      END IF;

      lv_mens_retorno := '/' || lv_codtipcontrato || '/' || lv_codplantarif || '/' || TO_CHAR (ln_coduso) || '/' || TO_CHAR (ln_codproducto);
      RAISE fin_proceso;
   EXCEPTION
      WHEN fin_proceso THEN
         INSERT INTO ga_transacabo
                     (num_transaccion, cod_retorno, des_cadena)
         VALUES      (en_nuntransaccion, ln_cod_retorno, lv_mens_retorno);
      WHEN OTHERS THEN
         RAISE fin_proceso;
   END ve_obtiene_tipcontrato_fs_pr;

   PROCEDURE ve_obtiene_vigplanserie_pr (
      ev_codplantarif      IN              ga_planuso.cod_plantarif%TYPE,
      ev_numserie          IN              al_series.num_serie%TYPE,
      sv_flgcontratofijo   OUT NOCOPY      ga_planuso.flg_contratofijo%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_VigPlanSerie_PR
         Lenguaje="PL/SQL"
         Fecha="06-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene indicador de vigencia relacion plan - numero serie
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_codPlantarif"   Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="EV_numSerie        Tipo="STRING"> numero serie</param>
      </Entrada>
      <Salida>
         <param nom="SV_flgContratoFijo" Tipo="STRING"> indicador vigencia </param>
         <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ln_coduso      ga_planuso.cod_uso%TYPE;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      ln_coduso := 0;
      lv_ssql := 'SELECT a.cod_uso' || ' FROM al_series a' || ' WHERE a.num_serie = ' || ev_numserie;

      SELECT a.cod_uso
        INTO ln_coduso
        FROM al_series a
       WHERE a.num_serie = ev_numserie;

      sv_flgcontratofijo := 'N';
      lv_ssql := 'SELECT a.flg_contratofijo' || ' FROM ga_planuso a' || ' WHERE a.cod_plantarif = ' || ev_codplantarif || '   AND a.cod_uso = ' || ln_coduso;

      SELECT a.flg_contratofijo
        INTO sv_flgcontratofijo
        FROM ga_planuso a
       WHERE a.cod_plantarif = ev_codplantarif AND a.cod_uso = ln_coduso;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 0;
         sv_flgcontratofijo := 'N';
      WHEN OTHERS THEN
         sn_cod_retorno := 11171;
         sv_mens_retorno := 'error al consultar indicador de vigencia';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_VigPlanSerie_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_VigPlanSerie_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_vigplanserie_pr;

   PROCEDURE ve_obtiene_vigplanuso_pr (
      ev_codplantarif      IN              ga_planuso.cod_plantarif%TYPE,
      en_coduso            IN              ga_planuso.cod_uso%TYPE,
      sv_flgcontratofijo   OUT NOCOPY      ga_planuso.flg_contratofijo%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_VigPlanUso_PR
         Lenguaje="PL/SQL"
         Fecha="06-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Obtiene indicador de vigencia relacion plan uso
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_codPlantarif"   Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="EN_codUso"         Tipo="NUMBER"> codigo uso</param>
      </Entrada>
      <Salida>
         <param nom="SV_flgContratoFijo" Tipo="STRING"> indicador vigencia </param>
         <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sv_flgcontratofijo := 'N';
      lv_ssql := 'SELECT a.flg_contratofijo' || ' FROM ga_planuso a' || ' WHERE a.cod_plantarif = ' || ev_codplantarif || '   AND a.cod_uso = ' || en_coduso;

      SELECT a.flg_contratofijo
        INTO sv_flgcontratofijo
        FROM ga_planuso a
       WHERE a.cod_plantarif = ev_codplantarif AND a.cod_uso = en_coduso;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 0;
         sv_flgcontratofijo := 'N';
      WHEN OTHERS THEN
         sn_cod_retorno := 11172;
         sv_mens_retorno := 'error al consultar indicador de vigencia relacion plan uso';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_VigPlanUso_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_VigPlanUso_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_vigplanuso_pr;

   PROCEDURE ve_obtiene_vigplanuso_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      ev_codplantarif     IN   ga_planuso.cod_plantarif%TYPE,
      en_coduso           IN   ga_planuso.cod_uso%TYPE) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_VigPlanUso_FS_PR
         Lenguaje="PL/SQL"
         Fecha="06-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
           Por medio de la tabla GA_TRANSACABO el VB obtendra el resultado de ejecucion.
          Cada dato agregado en el campo DES_CADENA, debe ir separado por / para el VB.
      </Retorno>
      <Descripción>
         Mascara para ser llamada desde los VB
      </Descripción>
      <Parámetros>
        <Entrada>
          <param nom="EN_numTransaccion"  Tipo="NUMBER"> numero de la transaccion </param>
         <param nom="EV_codPlantarif"    Tipo="STRING"> codigo plan tarifaro </param>
         <param nom="EN_codUso"          Tipo="NUMBER"> codigo uso</param>
      </Entrada>
      <Salida> N/A </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      fin_proceso          EXCEPTION;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      ln_cod_retorno       ge_errores_pg.coderror;
      lv_mens_retorno      ge_errores_pg.msgerror;
      ln_num_evento        ge_errores_pg.evento;
      lv_flgcontratofijo   ga_planuso.flg_contratofijo%TYPE;
   BEGIN
      ln_cod_retorno := 0;
      lv_mens_retorno := NULL;
      ln_num_evento := 0;
      ve_obtiene_vigplanuso_pr (ev_codplantarif, en_coduso, lv_flgcontratofijo, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF (ln_cod_retorno <> 0) THEN
         ln_cod_retorno := 4;
         lv_mens_retorno := '/ERROR' || '/' || TO_CHAR (ln_num_evento);
         RAISE fin_proceso;
      END IF;

      lv_mens_retorno := '/' || lv_flgcontratofijo;
      RAISE fin_proceso;
   EXCEPTION
      WHEN fin_proceso THEN
         INSERT INTO ga_transacabo
                     (num_transaccion, cod_retorno, des_cadena)
         VALUES      (en_nuntransaccion, ln_cod_retorno, lv_mens_retorno);
      WHEN OTHERS THEN
         RAISE fin_proceso;
   END ve_obtiene_vigplanuso_fs_pr;

   PROCEDURE ve_obtiene_abosvigcliente_pr (
      ev_cod_cliente    IN              ga_abocel.cod_cliente%TYPE,
      sn_resultado      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_AbosVigCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="06-08-2008"
         Version="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
         cantidad de abonados vigentes del cliente
       </Retorno>
      <Descripcion>
          Devuelve cantidad de abonados, no dados de baja, asociados al cliente con tipo de contrato
          distinto a 0 meses de duracion (82)
      </Descripcion>
      <Parametros>
      <Entrada>
            <param nom="EV_cod_cliente"  Tipo="STRING"> codigo cliente</param>
      </Entrada>
      <Salida>
             <param nom="SN_resultado"    Tipo="NUMBER"> resultado de la consulta</param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
       */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_resultado := 0;
      lv_ssql :=
          'SELECT COUNT(1)' || ' FROM ga_abocel a,' || ' WHERE a.cod_cliente =' || ev_cod_cliente || ' AND a.cod_situacion NOT IN (' || cv_baja_abonado || ',' || cv_baja_abonadopdte || ')' || ' AND a.cod_tipcontrato <> ''' || cn_tipcontraro0meses || '''';

      SELECT COUNT (1)
        INTO sn_resultado
        FROM ga_abocel a
       WHERE a.cod_cliente = ev_cod_cliente AND a.cod_situacion NOT IN (cv_baja_abonado, cv_baja_abonadopdte) AND a.cod_tipcontrato <> cn_tipcontraro0meses;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11173;
         sv_mens_retorno := 'error al consultar cantidad de abonados vigentes del cliente';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_AbosVigCliente_PR(' || ev_cod_cliente || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_AbosVigCliente_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_abosvigcliente_pr;

   PROCEDURE ve_obtiene_abosvigclie_fs_pr (
      en_nuntransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_codcliente       IN   ga_abocel.cod_cliente%TYPE) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_AbosVigClie_FS_PR
         Lenguaje="PL/SQL"
         Fecha="06-08-2008"
         Version="1.0.0"
         Disenador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
           Por medio de la tabla GA_TRANSACABO el VB obtendra el resultado de ejecucion.
          Cada dato agregado en el campo DES_CADENA, debe ir separado por / para el VB.
      </Retorno>
      <Descripción>
         Mascara para ser llamada desde los VB
      </Descripción>
      <Parámetros>
        <Entrada>
          <param nom="EN_numTransaccion"  Tipo="NUMBER"> numero de la transaccion </param>
         <param nom="EN_codCliente"      Tipo="NUMBER"> codigo cliente</param>
      </Entrada>
      <Salida> N/A </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      fin_proceso       EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      ln_cod_retorno    ge_errores_pg.coderror;
      lv_mens_retorno   ge_errores_pg.msgerror;
      ln_num_evento     ge_errores_pg.evento;
      ln_contador       NUMBER;
   BEGIN
      ln_cod_retorno := 0;
      lv_mens_retorno := NULL;
      ln_num_evento := 0;
      ve_obtiene_abosvigcliente_pr (en_codcliente, ln_contador, ln_cod_retorno, lv_mens_retorno, ln_num_evento);

      IF (ln_cod_retorno <> 0) THEN
         ln_cod_retorno := 4;
         lv_mens_retorno := '/ERROR' || '/' || TO_CHAR (ln_num_evento);
         RAISE fin_proceso;
      END IF;

      lv_mens_retorno := '/' || TO_CHAR (ln_contador);
      RAISE fin_proceso;
   EXCEPTION
      WHEN fin_proceso THEN
         INSERT INTO ga_transacabo
                     (num_transaccion, cod_retorno, des_cadena)
         VALUES      (en_nuntransaccion, ln_cod_retorno, lv_mens_retorno);
      WHEN OTHERS THEN
         RAISE fin_proceso;
   END ve_obtiene_abosvigclie_fs_pr;

   PROCEDURE ve_obtiene_vtasvendedor_pr (
      en_codvendedor    IN              ga_ventas.cod_vendedor%TYPE,
      en_numventa       IN              ga_ventas.num_venta%TYPE,
      ev_codoficina     IN              ga_ventas.cod_oficina%TYPE,
      ev_fecdesde       IN              VARCHAR2,
      ev_fechasta       IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_VtasVendedor_PR"
         Lenguaje="PL/SQL"
         Fecha="07-08-2008"
         Version="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
          cursor
      </Retorno>
      <Descripcion>
         Obtiene Listado ventas para el vendedor
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_codVendedor"   Tipo="NUMBER"> codigo vendedor </param>
         <param nom="EN_numVenta"      Tipo="NUMBER"> numero de venta </param>
         <param nom="EV_codOficina"    Tipo="NUMBER"> codigo oficina </param>
         <param nom="EV_fecDesde"      Tipo="STRING"> fecha desde</param>
         <param nom="EV_fecHasta"      Tipo="STRING"> fecha hasta </param>
      </Entrada>
      <Salida>
          <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor ventas </param>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      lv_sql1        ge_errores_pg.vquery;
      lv_sql2        ge_errores_pg.vquery;
      lv_sql3        ge_errores_pg.vquery;
      lv_sql4        ge_errores_pg.vquery;
      lv_sql5        ge_errores_pg.vquery;
      ln_contador    NUMBER;
      lb_and         BOOLEAN;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lb_and := FALSE;
      lv_sql1 := 'SELECT';
      lv_sql2 := ' a.num_venta,TO_CHAR(a.fec_venta,''DD-MM-YYYY''),' || ' a.cod_oficina,d.des_oficina,' || ' a.cod_vendedor,c.nom_vendedor,' || ' a.num_unidades,a.imp_venta';
      lv_sql3 := ' FROM ga_ventas a, ga_abocel b, ve_vendedores c, ge_oficinas d' || ' WHERE ';

      IF (en_numventa <> 0) THEN
         lv_sql3 := lv_sql3 || ' a.num_venta = ' || en_numventa;
         lb_and := TRUE;
      END IF;

      IF (en_codvendedor <> 0) THEN
         IF (lb_and = FALSE) THEN
            lv_sql3 := lv_sql3 || ' a.cod_vendedor = ' || en_codvendedor;
            lb_and := TRUE;
         ELSE
            lv_sql3 := lv_sql3 || ' AND a.cod_vendedor = ' || en_codvendedor;
         END IF;
      END IF;

      IF (ev_codoficina <> '0') THEN
         IF (lb_and = FALSE) THEN
            lv_sql3 := lv_sql3 || ' a.cod_oficina = ''' || ev_codoficina || '''';
            lb_and := TRUE;
         ELSE
            lv_sql3 := lv_sql3 || ' AND a.cod_oficina = ''' || ev_codoficina || '''';
         END IF;
      END IF;

      IF (lb_and = FALSE) THEN
         lv_sql3 := lv_sql3 || ' b.fec_alta between TO_DATE(''' || ev_fecdesde || ''',''DD-MM-YYYY'')' || ' AND TO_DATE(''' || ev_fechasta || ' 235900' || ''',''DD-MM-YYYY HH24MISS'')';
      ELSE
         lv_sql3 := lv_sql3 || ' AND a.fec_venta between TO_DATE(''' || ev_fecdesde || ''',''DD-MM-YYYY'')' || ' AND TO_DATE(''' || ev_fechasta || ' 235900' || ''',''DD-MM-YYYY HH24MISS'')';
      END IF;

      lv_sql3 := lv_sql3 || ' AND a.num_venta = b.num_venta' || ' AND a.cod_vendedor = c.cod_vendedor' || ' AND a.cod_oficina = d.cod_oficina';
      lv_sql5 := ' GROUP BY' || ' a.num_venta,TO_CHAR(a.fec_venta,''DD-MM-YYYY''),' || ' a.cod_oficina,d.des_oficina,' || ' a.cod_vendedor,c.nom_vendedor,' || ' a.num_unidades,a.imp_venta' || ' ORDER BY a.num_venta desc';
      lv_sql := lv_sql1 || lv_sql2 || lv_sql3 || lv_sql5;

      OPEN sc_cursordatos FOR lv_sql;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11174;
         sv_mens_retorno := 'error al consultar listado ventas para el vendedor';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_VtasVendedor_PR(' || en_codvendedor || '); - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_obtiene_VtasVendedor_PR', lv_sql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_vtasvendedor_pr;

   PROCEDURE ve_getlistvendedores_pr (
      ev_cod_oficina    IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
                                                             /*--
                                                             <Documentacion TipoDoc = "Procedimiento">
                                                                Elemento Nombre = "VE_getListVendedores_PR"
                                                                Lenguaje="PL/SQL"
                                                                Fecha="11-08-2008"
                                                                Version="1.0.0"
                                                                Dise?ador="wjrc"
                                                                Programador="wjrc"
                                                                Ambiente="BD"
                                                             <Retorno>
                                                                 cursor
                                                             </Retorno>
                                                             <Descripcion>
                                                                Obtiene Listado vendedores por oficina
                                                             </Descripcion>
                                                             <Parametros>
                                                             <Entrada>
                                                                <param nom="EV_cod_oficina"       Tipo="STRING"> código oficina </param>
                                                             </Entrada>
                                                             <Salida>
                                                                 <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor vendedores </param>
                                                                <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
                                                                <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
                                                                <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
                                                             </Salida>
                                                             </Parametros>
                                                             </Elemento>
                                                             </Documentacion>
                                                             --*/
   IS
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ve_vendedores a
       WHERE a.cod_oficina = ev_cod_oficina AND SYSDATE BETWEEN a.fec_contrato AND NVL (a.fec_fincontrato, SYSDATE);

      lv_sql := 'SELECT a.cod_vendedor, a.nom_vendedor ' || ' FROM ve_vendedores a ' || ' WHERE a.cod_oficina = ''' || ev_cod_oficina || '''' || ' AND SYSDATE BETWEEN a.fec_contrato AND NVL(a.fec_fincontrato,SYSDATE)' || ' ORDER BY a.nom_vendedor';

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

      OPEN sc_cursordatos FOR lv_sql;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 10863;
         sv_mens_retorno := 'Error al consultar listado vendedores por oficina. No se retornaron registros';

      WHEN OTHERS THEN
         sn_cod_retorno := 11175;
         sv_mens_retorno := 'error al consultar listado vendedores por oficina';

         lv_deserror := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendedores_PR(' || ev_cod_oficina || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_getListVendedores_PR(' || ev_cod_oficina || ')', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistvendedores_pr;

-- P-ECU-08019 fin ------------------------------------------------------------------------------
   PROCEDURE ga_insert_venta_pr (
      so_ventas         IN OUT NOCOPY   ve_tipos_pg.tip_ga_ventas,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "GA_INSERT_VENTA_PR
            Lenguaje="PL/SQL"
            Fecha="03-05-2007"
            Versión="La del package"
            Diseñador="Raúl Lozano"
            Programador="Raúl Lozano"
            Ambiente Desarrollo="BD">
            <Retorno>SO_cuenta</Retorno>>
            <Descripción>Recupera El código del proceso de venta</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
               </Entrada>
               <Salida>
                  <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
      lv_ssql := lv_ssql || ' INSERT INTO GA_VENTAS( NUM_VENTA, COD_PRODUCTO, COD_OFICINA, COD_TIPCOMIS, COD_VENDEDOR,';
      lv_ssql := lv_ssql || '    COD_VENDEDOR_AGENTE, NUM_UNIDADES, FEC_VENTA, COD_REGION, COD_PROVINCIA,';
      lv_ssql := lv_ssql || '    COD_CIUDAD, IND_ESTVENTA, NUM_TRANSACCION, IND_PASOCOB, NOM_USUAR_VTA,';
      lv_ssql := lv_ssql || '    IND_VENTA, COD_MONEDA, COD_CAUSAREC, IMP_VENTA, COD_TIPCONTRATO, NUM_CONTRATO,';
      lv_ssql := lv_ssql || '    IND_TIPVENTA, COD_CLIENTE, COD_MODVENTA, TIP_VALOR, COD_CUOTA, COD_TIPTARJETA,';
      lv_ssql := lv_ssql || '    NUM_TARJETA, COD_AUTTARJ, FEC_VENCITARJ, COD_BANCOTARJ, NUM_CTACORR, NUM_CHEQUE,';
      lv_ssql := lv_ssql || '    COD_BANCO, COD_SUCURSAL, FEC_CUMPLIMENTA, FEC_RECDOCUM, FEC_ACEPREC, NOM_USUAR_ACEREC,';
      lv_ssql := lv_ssql || '    NOM_USUAR_RECDOC, NOM_USUAR_CUMPL, IND_OFITER, IND_CHKDICOM, NUM_CONSULTA, COD_VENDEALER,';
      lv_ssql := lv_ssql || '    NUM_FOLDEALER, COD_DOCDEALER, IND_DOCCOMP, OBS_INCUMP, COD_CAUSAREP, FEC_RECPROV,';
      lv_ssql := lv_ssql || '    NOM_USUAR_RECPROV, NUM_DIAS, OBS_RECPROV, IMP_ABONO, IND_ABONO, FEC_RECEP_ADMVTAS,';
      lv_ssql := lv_ssql || '    USU_RECEP_ADMVTAS, OBS_GRALCUMPL, IND_CONT_TELEF, FECHA_CONT_TELEF, USUARIO_CONT_TELEF,';
      lv_ssql := lv_ssql || '    MTO_GARANTIA, TIP_FOLIACION, COD_TIPDOCUM, COD_PLAZA, COD_OPERADORA, NUM_PROCESO';
      lv_ssql := lv_ssql || ')';
      lv_ssql := lv_ssql || ' VALUES(';
      lv_ssql := lv_ssql || so_ventas (1).num_venta || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_producto || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_oficina || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_tipcomis || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_vendedor || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_vendedor_agente || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_unidades || ',';
      lv_ssql := lv_ssql || so_ventas (1).fec_venta || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_region || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_provincia || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_ciudad || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_estventa || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_transaccion || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_pasocob || ',';
      lv_ssql := lv_ssql || so_ventas (1).nom_usuar_vta || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_venta || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_moneda || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_causarec || ',';
      lv_ssql := lv_ssql || so_ventas (1).imp_venta || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_tipcontrato || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_contrato || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_tipventa || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_cliente || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_modventa || ',';
      lv_ssql := lv_ssql || so_ventas (1).tip_valor || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_cuota || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_tiptarjeta || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_tarjeta || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_auttarj || ',';
      lv_ssql := lv_ssql || so_ventas (1).fec_vencitarj || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_bancotarj || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_ctacorr || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_cheque || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_banco || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_sucursal || ',';
      lv_ssql := lv_ssql || so_ventas (1).fec_cumplimenta || ',';
      lv_ssql := lv_ssql || so_ventas (1).fec_recdocum || ',';
      lv_ssql := lv_ssql || so_ventas (1).fec_aceprec || ',';
      lv_ssql := lv_ssql || so_ventas (1).nom_usuar_acerec || ',';
      lv_ssql := lv_ssql || so_ventas (1).nom_usuar_recdoc || ',';
      lv_ssql := lv_ssql || so_ventas (1).nom_usuar_cumpl || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_ofiter || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_chkdicom || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_consulta || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_vendealer || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_foldealer || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_docdealer || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_doccomp || ',';
      lv_ssql := lv_ssql || so_ventas (1).obs_incump || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_causarep || ',';
      lv_ssql := lv_ssql || so_ventas (1).fec_recprov || ',';
      lv_ssql := lv_ssql || so_ventas (1).nom_usuar_recprov || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_dias || ',';
      lv_ssql := lv_ssql || so_ventas (1).obs_recprov || ',';
      lv_ssql := lv_ssql || so_ventas (1).imp_abono || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_abono || ',';
      lv_ssql := lv_ssql || so_ventas (1).fec_recep_admvtas || ',';
      lv_ssql := lv_ssql || so_ventas (1).usu_recep_admvtas || ',';
      lv_ssql := lv_ssql || so_ventas (1).obs_gralcumpl || ',';
      lv_ssql := lv_ssql || so_ventas (1).ind_cont_telef || ',';
      lv_ssql := lv_ssql || so_ventas (1).fecha_cont_telef || ',';
      lv_ssql := lv_ssql || so_ventas (1).usuario_cont_telef || ',';
      lv_ssql := lv_ssql || so_ventas (1).mto_garantia || ',';
      lv_ssql := lv_ssql || so_ventas (1).tip_foliacion || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_tipdocum || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_plaza || ',';
      lv_ssql := lv_ssql || so_ventas (1).cod_operadora || ',';
      lv_ssql := lv_ssql || so_ventas (1).num_proceso || ')';

      INSERT INTO ga_ventas
                  (num_venta, cod_producto, cod_oficina, cod_tipcomis, cod_vendedor, cod_vendedor_agente, num_unidades, fec_venta,
                   cod_region, cod_provincia, cod_ciudad, ind_estventa, num_transaccion, ind_pasocob, nom_usuar_vta, ind_venta,
                   cod_moneda, cod_causarec, imp_venta, cod_tipcontrato, num_contrato, ind_tipventa, cod_cliente, cod_modventa,
                   tip_valor, cod_cuota, cod_tiptarjeta, num_tarjeta, cod_auttarj, fec_vencitarj, cod_bancotarj, num_ctacorr,
                   num_cheque, cod_banco, cod_sucursal, fec_cumplimenta, fec_recdocum, fec_aceprec, nom_usuar_acerec, nom_usuar_recdoc,
                   nom_usuar_cumpl, ind_ofiter, ind_chkdicom, num_consulta, cod_vendealer, num_foldealer, cod_docdealer, ind_doccomp,
                   obs_incump, cod_causarep, fec_recprov, nom_usuar_recprov, num_dias, obs_recprov, imp_abono, ind_abono,
                   fec_recep_admvtas, usu_recep_admvtas, obs_gralcumpl, ind_cont_telef, fecha_cont_telef, usuario_cont_telef, mto_garantia,
                   tip_foliacion, cod_tipdocum, cod_plaza, cod_operadora, num_proceso/* CSR-11002 , ind_portado*/)
      VALUES      (so_ventas (1).num_venta, so_ventas (1).cod_producto, so_ventas (1).cod_oficina, so_ventas (1).cod_tipcomis, so_ventas (1).cod_vendedor, so_ventas (1).cod_vendedor_agente, so_ventas (1).num_unidades, so_ventas (1).fec_venta,
                   so_ventas (1).cod_region, so_ventas (1).cod_provincia, so_ventas (1).cod_ciudad, so_ventas (1).ind_estventa, so_ventas (1).num_transaccion, so_ventas (1).ind_pasocob, so_ventas (1).nom_usuar_vta, so_ventas (1).ind_venta,
                   so_ventas (1).cod_moneda, so_ventas (1).cod_causarec, so_ventas (1).imp_venta, so_ventas (1).cod_tipcontrato, so_ventas (1).num_contrato, so_ventas (1).ind_tipventa, so_ventas (1).cod_cliente, so_ventas (1).cod_modventa,
                   so_ventas (1).tip_valor, so_ventas (1).cod_cuota, so_ventas (1).cod_tiptarjeta, so_ventas (1).num_tarjeta, so_ventas (1).cod_auttarj, so_ventas (1).fec_vencitarj, so_ventas (1).cod_bancotarj, so_ventas (1).num_ctacorr,
                   so_ventas (1).num_cheque, so_ventas (1).cod_banco, so_ventas (1).cod_sucursal, so_ventas (1).fec_cumplimenta, so_ventas (1).fec_recdocum, so_ventas (1).fec_aceprec, so_ventas (1).nom_usuar_acerec, so_ventas (1).nom_usuar_recdoc,
                   so_ventas (1).nom_usuar_cumpl, so_ventas (1).ind_ofiter, so_ventas (1).ind_chkdicom, so_ventas (1).num_consulta, so_ventas (1).cod_vendealer, so_ventas (1).num_foldealer, so_ventas (1).cod_docdealer, so_ventas (1).ind_doccomp,
                   so_ventas (1).obs_incump, so_ventas (1).cod_causarep, so_ventas (1).fec_recprov, so_ventas (1).nom_usuar_recprov, so_ventas (1).num_dias, so_ventas (1).obs_recprov, so_ventas (1).imp_abono, so_ventas (1).ind_abono,
                   so_ventas (1).fec_recep_admvtas, so_ventas (1).usu_recep_admvtas, so_ventas (1).obs_gralcumpl, so_ventas (1).ind_cont_telef, so_ventas (1).fecha_cont_telef, so_ventas (1).usuario_cont_telef, so_ventas (1).mto_garantia,
                   so_ventas (1).tip_foliacion, so_ventas (1).cod_tipdocum, so_ventas (1).cod_plaza, so_ventas (1).cod_operadora, so_ventas (1).num_proceso /* CSR-11002 , so_ventas (1).ind_portado*/);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11176;                                                                                                                                                                             --Problemas al recuperar codigo de proceso de venta
         sv_mens_retorno := 'error al insertar venta';

         lv_des_error := ' GA_INSERT_VENTA_PR  (' || '); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, 1.0, USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.GA_INSERT_VENTA_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ga_insert_venta_pr;

   PROCEDURE ve_datosvendedor_pr (
      en_codvendedor     IN              ve_vendedores.cod_vendedor%TYPE,
      en_coddealer       IN              ve_vendealer.cod_vendealer%TYPE,
      sv_nomvendedor     OUT NOCOPY      ve_vendedores.nom_vendedor%TYPE,
      sv_nomvendealer    OUT NOCOPY      ve_vendealer.nom_vendealer%TYPE,
      sn_codcliente      OUT NOCOPY      ve_vendedores.cod_cliente%TYPE,
      sn_codvende_raiz   OUT NOCOPY      ve_vendedores.cod_vende_raiz%TYPE,
      sv_codregion       OUT NOCOPY      ge_direcciones.cod_region%TYPE,
      sv_codprovincia    OUT NOCOPY      ge_direcciones.cod_provincia%TYPE,
      sv_codciudad       OUT NOCOPY      ge_direcciones.cod_ciudad%TYPE,
      sv_codoficina      OUT NOCOPY      ve_vendedores.cod_oficina%TYPE,
      sv_codtipcomis     OUT NOCOPY      ve_tipcomis.cod_tipcomis%TYPE,
      sv_destipcomis     OUT NOCOPY      ve_tipcomis.des_tipcomis%TYPE,
      sn_indtipventa     OUT NOCOPY      ve_vendedores.ind_tipventa%TYPE,
      sn_indbloqueo      OUT NOCOPY      ve_vendedores.ve_indbloqueo%TYPE,
      sv_cod_cuenta      OUT NOCOPY      ve_vendedores.cod_cuenta%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
                                                              /*--
                                                              <Documentación TipoDoc = "Procedimiento">
                                                                 Elemento Nombre = "VE_datosvendedor_PR"
                                                                 Lenguaje="PL/SQL"
                                                                 Fecha="21-09-2007"
                                                                 Versión="1.0.0"
                                                                 Diseñador="Héctor Hermosilla"
                                                                 Programador="Héctor Hermosilla"
                                                                 Ambiente="BD"
                                                              <Retorno>Datos del vendedor</Retorno>
                                                              <Descripción>
                                                                 Datos del vendedor externo
                                                              </Descripción>
                                                              <Parametros>
                                                              <Entrada>
                                                                   <param nom="EN_codvendedor"  Tipo="NUMBER">codigo de vendedor</param>
                                                                 <param nom="EN_coddealer"  Tipo="NUMBER">codigo de dealer</param>
                                                              </Entrada>
                                                              <Salida>
                                                                   <param nom="SV_nomvendedor"   Tipo="VARCHAR2">Nombre del vendedor</param>
                                                                 <param nom="SV_nomvendealer"  Tipo="VARCHAR2">Nombre del vendedor externo</param>
                                                                   <param nom="SN_codcliente"    Tipo="NUMBER">Codigo del cliente</param>
                                                                   <param nom="SN_codvende_raiz" Tipo="NUMBER">Codigo vendedor raiz</param>
                                                                   <param nom="SV_codregion"     Tipo="VARCHAR2">Codigo de region</param>
                                                                   <param nom="SV_codprovincia"  Tipo="VARCHAR2">Codigo de Provincia</param>
                                                                   <param nom="SV_codciudad"     Tipo="VARCHAR2">Codigo de ciudad</param>
                                                                   <param nom="SV_codoficina"    Tipo="VARCHAR2">Codigo oficina del vendedor</param>
                                                                   <param nom="SV_codtipcomis"   Tipo="VARCHAR2">Codigo tipo comisionista/param>
                                                                   <param nom="SV_destipcomis"   Tipo="VARCHAR2">descripcion tipo comisionista</param>
                                                                 <param nom="SN_indtipventa"   Tipo="NUMBER">Indicador tipo de venta</param>
                                                                 <param nom="SN_indbloqueo"    Tipo="NUMBER">Indicador de bloqueo</param>
                                                                   <param nom="SN_cod_retorno"   Tipo="NUMBER">Codigo error de negocio Retornado</param>
                                                                   <param nom="SV_mens_retorno"  Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                                                                   <param nom="SN_num_evento"    Tipo="NUMBER">Nro de evento</param>
                                                              </Salida>
                                                              </Parametros>
                                                              </Elemento>
                                                              </Documentación>
                                                              */
   IS
      lv_des_error              ge_errores_pg.desevent;
      lv_ssql                   ge_errores_pg.vquery;
      ln_count                  NUMBER (1);
      le_no_data_found_cursor   EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF (en_coddealer = 0) THEN
         lv_ssql :=
            'SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz,'
            || ' direccion.cod_region, direccion.cod_provincia,'
            || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
            || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa, vend.ve_indbloqueo'
            || ' FROM   ve_vendedores vend, ge_direcciones direccion,'
            || ' ve_tipcomis tipo_comisionista'
            || ' WHERE  vend.cod_vendedor = '|| en_codvendedor
            || ' AND    vend.ind_interno = 1'
            || ' AND    direccion.cod_direccion = vend.cod_direccion'
            || ' AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis'
            || ' AND    tipo_comisionista.ind_vta_externa = 0';

         SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia, direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis, tipo_comisionista.des_tipcomis, vend.ind_tipventa,
                vend.ve_indbloqueo, vend.cod_cuenta
           INTO sv_nomvendedor, sn_codcliente, sn_codvende_raiz, sv_codregion, sv_codprovincia, sv_codciudad, sv_codoficina, sv_codtipcomis, sv_destipcomis, sn_indtipventa,
                sn_indbloqueo, sv_cod_cuenta
           FROM ve_vendedores vend, ge_direcciones direccion, ve_tipcomis tipo_comisionista
          WHERE vend.cod_vendedor = en_codvendedor
          AND vend.ind_interno = 1
          AND direccion.cod_direccion = vend.cod_direccion
          AND vend.cod_tipcomis = tipo_comisionista.cod_tipcomis
          AND tipo_comisionista.ind_vta_externa = 0;

      ELSIF (en_coddealer = -1) THEN
         lv_ssql :=
            'SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz,'
            || ' direccion.cod_region, direccion.cod_provincia,'
            || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
            || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa, vend.ve_indbloqueo'
            || ' FROM   ve_vendedores vend, ge_direcciones direccion,'
            || ' ve_tipcomis tipo_comisionista'
            || ' WHERE  vend.cod_vendedor = '|| en_codvendedor
            || ' AND    direccion.cod_direccion = vend.cod_direccion'
            || ' AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis';

         SELECT vend.nom_vendedor, vend.cod_cliente, vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia, direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis, tipo_comisionista.des_tipcomis, vend.ind_tipventa,
                vend.ve_indbloqueo, vend.cod_cuenta
           INTO sv_nomvendedor, sn_codcliente, sn_codvende_raiz, sv_codregion, sv_codprovincia, sv_codciudad, sv_codoficina, sv_codtipcomis, sv_destipcomis, sn_indtipventa,
                sn_indbloqueo, sv_cod_cuenta
           FROM VE_VENDEDORES vend, GE_DIRECCIONES direccion, VE_TIPCOMIS tipo_comisionista
          WHERE vend.cod_vendedor = en_codvendedor
          AND direccion.cod_direccion = vend.cod_direccion
          AND vend.cod_tipcomis = tipo_comisionista.cod_tipcomis;

      ELSE
         lv_ssql := 'SELECT vend.nom_vendedor,dealer.nom_vendealer, vend.cod_cliente,'
                 || ' vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia,'
                 || ' direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis,'
                 || ' tipo_comisionista.des_tipcomis, vend.ind_tipventa,vend.ve_indbloqueo'
                 || ' FROM   ve_vendedores vend, ge_direcciones direccion,'
                 || ' ve_tipcomis tipo_comisionista,ve_vendealer dealer'
                    || ' WHERE  vend.cod_vendedor = '||en_codvendedor
                 || ' AND    vend.ind_interno = 0'
                 || ' AND    direccion.cod_direccion = vend.cod_direccion'
                 || ' AND    vend.cod_tipcomis =  tipo_comisionista.cod_tipcomis'
                 || ' AND    tipo_comisionista.ind_vta_externa = 1'
                 || ' AND    vend.cod_vendedor = dealer.cod_vendedor'
                 || ' AND    dealer.cod_vendealer = ' || en_coddealer;

         SELECT vend.nom_vendedor, dealer.nom_vendealer, vend.cod_cliente, vend.cod_vende_raiz, direccion.cod_region, direccion.cod_provincia, direccion.cod_ciudad, vend.cod_oficina, tipo_comisionista.cod_tipcomis, tipo_comisionista.des_tipcomis,
                vend.ind_tipventa, vend.ve_indbloqueo, vend.cod_cuenta
           INTO sv_nomvendedor, sv_nomvendealer, sn_codcliente, sn_codvende_raiz, sv_codregion, sv_codprovincia, sv_codciudad, sv_codoficina, sv_codtipcomis, sv_destipcomis,
                sn_indtipventa, sn_indbloqueo, sv_cod_cuenta
           FROM ve_vendedores vend, ge_direcciones direccion, ve_tipcomis tipo_comisionista, ve_vendealer dealer
          WHERE vend.cod_vendedor = en_codvendedor
            AND vend.ind_interno = 0
            AND direccion.cod_direccion = vend.cod_direccion
            AND vend.cod_tipcomis = tipo_comisionista.cod_tipcomis
            AND tipo_comisionista.ind_vta_externa = 1
            AND vend.cod_vendedor = dealer.cod_vendedor
            AND dealer.cod_vendealer = en_coddealer;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10864;
         sv_mens_retorno := 'Error al consultar datos del vendedor. No se retornaron registros';

         lv_des_error := SUBSTR ('NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11177;
         sv_mens_retorno := 'error al consultar datos del vendedor externo';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_datosvendedor_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_datosvendedor_pr;

   PROCEDURE ve_consulta_serie_pr (
      ev_serie          IN              al_series.num_serie%TYPE,
      sv_codbodega      OUT NOCOPY      al_series.cod_bodega%TYPE,
      sv_estadoserie    OUT NOCOPY      al_series.cod_estado%TYPE,
      sv_indtelefono    OUT NOCOPY      al_series.ind_telefono%TYPE,
      sv_numcelular     OUT NOCOPY      al_series.num_telefono%TYPE,
      sv_uso            OUT NOCOPY      al_series.cod_uso%TYPE,
      sv_tipostock      OUT NOCOPY      al_series.tip_stock%TYPE,
      sv_codcentral     OUT NOCOPY      al_series.cod_central%TYPE,
      sn_codarticulo    OUT NOCOPY      al_series.cod_articulo%TYPE,
      sn_capcode        OUT NOCOPY      al_series.cap_code%TYPE,
      sn_tiparticulo    OUT NOCOPY      al_articulos.tip_articulo%TYPE,
      sv_desarticulo    OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sv_codsubalm      OUT NOCOPY      al_series.cod_subalm%TYPE,
      sn_indvalorar     OUT NOCOPY      al_tipos_stock.ind_valorar%TYPE,
      sv_carga          OUT NOCOPY      VARCHAR2,
      sv_cod_hlr        OUT NOCOPY      al_series.cod_hlr%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_serie_PR
         Lenguaje="PL/SQL"
         Fecha="30-03-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta datos de una serie especifica
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_serie"          Tipo="NUMBER> numero serie a consultar</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      CanAlSerie     NUMBER;
      CanAlCompoKit  NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

         lv_sql := 'SELECT s.cod_bodega, s.cod_estado, s.ind_telefono,'
                || ' s.num_telefono, s.cod_uso, s.tip_stock,'
                   || ' s.cod_central, s.cap_code, s.cod_articulo,'
                   || ' a.tip_articulo, a.des_articulo, s.cod_subalm,'
                || ' t.ind_valorar, s.carga '
                || ' FROM   al_series s, al_articulos a'
                || ' WHERE s.num_serie =' || ev_serie
                || ' AND s.cod_articulo = a.cod_articulo,'
                || ' AND s.tip_stock = t.tip_stock';

          SELECT s.cod_bodega, s.cod_estado, s.ind_telefono, s.num_telefono, s.cod_uso, s.tip_stock, s.cod_central, s.cap_code, s.cod_articulo, a.tip_articulo, a.des_articulo, s.cod_subalm, t.ind_valorar, s.carga, s.cod_hlr
            INTO sv_codbodega, sv_estadoserie, sv_indtelefono, sv_numcelular, sv_uso, sv_tipostock, sv_codcentral, sn_capcode, sn_codarticulo, sn_tiparticulo, sv_desarticulo, sv_codsubalm, sn_indvalorar, sv_carga, sv_cod_hlr
            FROM al_series s, al_articulos a, al_tipos_stock t
           WHERE s.num_serie = ev_serie
             AND s.cod_articulo = a.cod_articulo
             AND s.tip_stock = t.tip_stock;


   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10865;
         sv_mens_retorno := 'Error al consultar datos de la simcard o del equipo, esta  NO se encuentra en inventario';

         lv_des_error := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11178;
         sv_mens_retorno := 'error al consultar datos de la serie';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_serie_PR(' || ev_serie || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_serie_pr;

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_consulta_seriexcodarti_pr (
      en_codarticulo    IN              al_series.cod_articulo%TYPE,
      en_codbodega      IN              al_series.cod_bodega%TYPE,
      en_codvendedor    IN              ve_vendalmac.cod_vendedor%TYPE,
      en_coduso         IN              al_series.cod_uso%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
          <Documentacion TipoDoc = "Procedimiento">
             Elemento Nombre = "VE_consulta_serie_PR
             Lenguaje="PL/SQL"
             Fecha="30-03-2007"
             Version="1.0.0"
             Dise?ador="Hector Hermosilla"
             Programador="Hector Hermosilla
             Ambiente="BD"
          <Retorno>NA</Retorno>
          <Descripcion>
             Consulta datos de una serie especifica
          </Descripcion>
          <Parametros>
          <Entrada>
             <param nom="EV_serie"          Tipo="NUMBER> numero serie a consultar</param>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
             <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
             <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
          </Salida>
          </Parametros>
          </Elemento>
          </Documentacion>
          --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT         articulos.cod_articulo, articulos.cod_conceptoart, articulos.cod_conceptodto, articulos.des_articulo, ' || '  articulos.tip_articulo,articulos.tip_terminal,tecnologia.cod_tecnologia,series.cod_bodega, '
         || '  series.cod_central,series.cod_estado,series.cod_hlr,series.cod_plaza, ' || '  series.cod_subalm,series.cod_uso,series.num_serie,series.num_telefono,' || '  series.tip_stock'
         || 'FROM al_articulos articulos, Ve_Vendalmac vendedores, al_tecnoarticulo_td tecnoarticulo, al_Tecnologia tecnologia, al_series series' || ' WHERE  articulos.cod_articulo = EN_codarticulo' || ' AND tecnologia.cod_grupo = GSM'
         || ' AND vendedores.cod_bodega = ' || en_codbodega || ' AND vendedores.cod_vendedor =' || en_codvendedor || ' AND SYSDATE BETWEEN vendedores.fec_asignacion AND NVL( vendedores.fec_desasignac,SYSDATE)'
         || ' AND tecnoarticulo.cod_tecnologia = tecnologia.cod_tecnologia' || ' AND tecnoarticulo.cod_articulo =articulos.cod_articulo ' || ' AND series.cod_articulo = articulos.cod_articulo' || ' AND series.cod_bodega = vendedores.cod_bodega'
         || ' AND series.tip_stock IN (' || ' SELECT tipstock.tip_stock' || ' FROM al_tipos_stock tipstock' || ' WHERE tipstock.cod_uso  = DECODE(' || en_coduso || ' ,1,3,2,2,3,2)' || ' )' || ' AND series.cod_producto = 1'
         || ' AND series.cod_uso =DECODE(:CodPlantarifario,1,3,2,2,3,2)' || ' AND series.cod_estado = 1';

      OPEN sc_cursordatos FOR
         SELECT articulos.cod_articulo, articulos.cod_conceptoart, articulos.cod_conceptodto, articulos.des_articulo, articulos.tip_articulo, articulos.tip_terminal, tecnologia.cod_tecnologia, series.cod_bodega, series.cod_central, series.cod_estado,
                series.cod_hlr, series.cod_plaza, series.cod_subalm, series.cod_uso, series.num_serie, series.num_telefono, series.tip_stock
           FROM al_articulos articulos, ve_vendalmac vendedores, al_tecnoarticulo_td tecnoarticulo, al_tecnologia tecnologia, al_series series
          WHERE articulos.cod_articulo = en_codarticulo AND tecnologia.cod_grupo = 'GSM' AND vendedores.cod_bodega = en_codbodega AND vendedores.cod_vendedor = en_codvendedor
                AND SYSDATE BETWEEN vendedores.fec_asignacion AND NVL (vendedores.fec_desasignac, SYSDATE) AND tecnoarticulo.cod_tecnologia = tecnologia.cod_tecnologia AND tecnoarticulo.cod_articulo = articulos.cod_articulo
                AND series.cod_articulo = articulos.cod_articulo AND series.cod_bodega = vendedores.cod_bodega AND series.tip_stock IN (SELECT tipstock.tip_stock
                                                                                                                                          FROM al_tipos_stock tipstock
                                                                                                                                         WHERE tipstock.cod_uso = DECODE (en_coduso, 1, 3, 2, 2, 3, 2)) AND series.cod_producto = 1
                AND series.cod_uso = DECODE (en_coduso, 1, 3, 2, 2, 3, 2) AND series.cod_estado = 1;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11179;
         sv_mens_retorno := 'error al consultar datos de la serie';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG. ve_consulta_seriexcodarti_pr(' || en_codarticulo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG. ve_consulta_seriexcodarti_pr(' || en_codarticulo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_seriexcodarti_pr;

/***********************************************************************************************************************************************************************/
   PROCEDURE ve_valida_coduso_pr (
      en_cod_uso        IN              al_usos.cod_uso%TYPE,
      sn_ind_restplan   OUT NOCOPY      al_usos.ind_restplan%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      ln_ind_usoventa    al_usos.ind_usoventa%TYPE;
      lv_sql             ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      err_uso_invalido   EXCEPTION;
   BEGIN
      BEGIN
         SELECT NVL (ind_usoventa, 0), ind_restplan
           INTO ln_ind_usoventa, sn_ind_restplan
           FROM al_usos
          WHERE cod_uso = en_cod_uso;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            sn_cod_retorno := 10867;
            sv_mens_retorno := 'Error al consultar codigo de uso. No se retornaron registros';
            RAISE err_uso_invalido;
      END;

      IF ln_ind_usoventa > 0 THEN
         sn_cod_retorno := 0;
      ELSE
         sn_cod_retorno := 10866;
         sv_mens_retorno := 'El código de uso es inválido';
         RAISE err_uso_invalido;
      END IF;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN err_uso_invalido THEN

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_coduso_pr(' || en_cod_uso || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_coduso_pr(' || en_cod_uso || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11180;
         sv_mens_retorno := 'error al consultar codigo de uso';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_coduso_pr(' || en_cod_uso || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_coduso_pr(' || en_cod_uso || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_valida_coduso_pr;

   PROCEDURE ve_valida_codplantarif_pr (
      ev_cod_plantarif   IN              ta_plantarif.cod_plantarif%TYPE,
      en_cod_uso         IN              al_usos.cod_uso%TYPE,
      en_ind_restplan    IN              al_usos.ind_restplan%TYPE,
      sv_tip_plantarif   OUT NOCOPY      ta_plantarif.tip_plantarif%TYPE,
      sn_cod_tiplan      OUT NOCOPY      ta_plantarif.cod_tiplan%TYPE,
      sn_ind_familiar    OUT NOCOPY      ta_plantarif.ind_familiar%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql              ge_errores_pg.vquery;
      lv_des_error        ge_errores_pg.desevent;
      err_plan_invalido   EXCEPTION;
      ld_fec_hasta        ta_plantarif.fec_hasta%TYPE;
      lv_tip_unitas       ta_plantarif.tip_unitas%TYPE;
      lv_cla_plantarif    ta_plantarif.cla_plantarif%TYPE;
      lv_val_parametro    ged_parametros.val_parametro%TYPE;
   BEGIN
      BEGIN
         SELECT fec_hasta, tip_unitas, cla_plantarif, tip_plantarif, cod_tiplan, ind_familiar
           INTO ld_fec_hasta, lv_tip_unitas, lv_cla_plantarif, sv_tip_plantarif, sn_cod_tiplan, sn_ind_familiar
           FROM ta_plantarif
          WHERE cod_producto = 1 AND cod_plantarif = ev_cod_plantarif;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            sn_cod_retorno := 10868;
            sv_mens_retorno := 'Error al validar codigo plan tarifario. No se retornaron registros';
            RAISE err_plan_invalido;
      END;

      IF ld_fec_hasta IS NOT NULL THEN
         IF ld_fec_hasta < SYSDATE THEN
            sn_cod_retorno := 11181;
            sv_mens_retorno := 'error al validar codigo plan tarifario';
            RAISE err_plan_invalido;
         END IF;
      END IF;

      SELECT val_parametro
        INTO lv_val_parametro
        FROM ged_parametros
       WHERE nom_parametro = 'UNIDAD_TASACION' AND cod_producto = 1 AND cod_modulo = cv_modulo_ga;

      IF NOT lv_val_parametro = lv_tip_unitas THEN
         sn_cod_retorno := 11181;
         sv_mens_retorno := 'error al validar codigo plan tarifario';
         RAISE err_plan_invalido;
      END IF;

      SELECT val_parametro
        INTO lv_val_parametro
        FROM ged_parametros
       WHERE nom_parametro = 'TIPO_PLAN_SERVICIO' AND cod_producto = 1 AND cod_modulo = 'TA';

      IF lv_val_parametro = lv_cla_plantarif THEN
         sn_cod_retorno := 11181;
         sv_mens_retorno := 'error al validar codigo plan tarifario';
         RAISE err_plan_invalido;
      END IF;

      IF NVL (en_ind_restplan, 0) = 1 THEN
         BEGIN
            SELECT '0'
              INTO lv_val_parametro
              FROM ga_planuso
             WHERE cod_plantarif = ev_cod_plantarif AND cod_uso = en_cod_uso AND cod_producto = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               sn_cod_retorno := 10868;
               sv_mens_retorno := 'Error al validar codigo plan tarifario. No se retornaron registros';
               RAISE err_plan_invalido;
         END;
      END IF;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN err_plan_invalido THEN

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplantarif_pr(' || ev_cod_plantarif || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplantarif_pr(' || ev_cod_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11181;
         sv_mens_retorno := 'error al validar codigo plan tarifario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplantarif_pr(' || ev_cod_plantarif || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplantarif_pr(' || ev_cod_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_valida_codplantarif_pr;

   PROCEDURE ve_valida_codplanserv_pr (
      ev_cod_planserv     IN              ga_planserv.cod_planserv%TYPE,
      ev_cod_tecnologia   IN              ga_plantecplserv.cod_tecnologia%TYPE,
      ev_cod_plantarif    IN              ga_plantecplserv.cod_plantarif%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql                  ge_errores_pg.vquery;
      lv_des_error            ge_errores_pg.desevent;
      err_planserv_invalido   EXCEPTION;
      ln_valor                PLS_INTEGER;
   BEGIN
      sn_cod_retorno := 7120;

      SELECT 1
        INTO ln_valor
        FROM ga_planserv
       WHERE cod_producto = 1 AND cod_planserv = ev_cod_planserv;

      sn_cod_retorno := 7130;

      SELECT 1
        INTO ln_valor
        FROM ga_plantecplserv
       WHERE cod_producto = 1 AND cod_tecnologia = ev_cod_tecnologia AND cod_plantarif = ev_cod_plantarif AND cod_planserv = ev_cod_planserv AND fec_desde < SYSDATE AND NVL (fec_hasta, SYSDATE) >= SYSDATE;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10869;
         sv_mens_retorno := 'Error al validar codigo plan servicio. No se retornaron registros';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplanserv_pr(' || ev_cod_planserv || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplanserv_pr(' || ev_cod_planserv || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11182;
         sv_mens_retorno := 'error al validar codigo plan servicio';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplanserv_pr(' || ev_cod_planserv || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_codplanserv_pr(' || ev_cod_planserv || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_valida_codplanserv_pr;

   PROCEDURE ve_valida_usuario_pr (
      ev_nom_usuario    IN              ge_seg_usuario.nom_usuario%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      ln_valor       PLS_INTEGER;
   BEGIN
      SELECT 1
        INTO ln_valor
        FROM ge_seg_usuario
       WHERE nom_usuario = ev_nom_usuario;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10870;
         sv_mens_retorno := 'Error al validar usuario. No se retornaron registros';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_usuario_pr(' || ev_nom_usuario || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_usuario_pr(' || ev_nom_usuario || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11183;
         sv_mens_retorno := 'error al validar usuario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_usuario_pr(' || ev_nom_usuario || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_usuario_pr(' || ev_nom_usuario || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_valida_usuario_pr;

   PROCEDURE ve_consulta_ss_opc_pr (
      ev_cod_actabo                    ga_actabo.cod_actabo%TYPE,
      ev_cod_plantarif                 ta_plantarif.cod_plantarif%TYPE,
      en_cod_tiplan                    ta_plantarif.cod_tiplan%TYPE,
      ev_cod_tecnologia                al_tecnologia.cod_tecnologia%TYPE,
      ev_cod_planserv                  ga_planserv.cod_planserv%TYPE,
      sc_ssopc            OUT NOCOPY   refcursor,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento) IS
      lv_cod_actabo   ga_actabo.cod_actabo%TYPE;
      ln_cod_actcen   ga_actabo.cod_actcen%TYPE;
      lv_sql          ge_errores_pg.vquery;
      lv_des_error    ge_errores_pg.desevent;
   BEGIN
      OPEN sc_ssopc FOR
         SELECT a.cod_servicio, a.cod_servsupl, a.cod_nivel, a.des_servicio, d.imp_tarifa AS tarifa_conexion, d.cod_moneda AS moneda_conexion, f.imp_tarifa AS tarifa_servicio, f.cod_moneda AS moneda_servicio, a.tip_servicio, h.des_valor
           FROM ga_servsupl a, gad_servsup_plan b, ga_actuaserv c, ga_tarifas d, ga_actuaserv e, ga_tarifas f, ged_codigos h
          WHERE a.cod_producto = 1 AND a.cod_aplic LIKE DECODE (en_cod_tiplan, 1, '%P%', '%C%') AND b.cod_producto = a.cod_producto AND b.cod_plantarif = ev_cod_plantarif AND b.cod_servicio = a.cod_servicio
                AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND b.tip_relacion IN (2, 4) AND h.cod_modulo = cv_modulo_ga AND h.nom_tabla = 'GA_SERVSUPL' AND h.nom_columna = 'TIP_SERVICIO' AND h.cod_valor = a.tip_servicio
                AND c.cod_producto(+) = a.cod_producto AND c.cod_actabo(+) = lv_cod_actabo AND c.cod_servicio(+) = a.cod_servicio AND d.cod_producto(+) = c.cod_producto AND d.cod_actabo(+) = c.cod_actabo AND d.cod_tipserv(+) = c.cod_tipserv
                AND d.cod_servicio(+) = c.cod_servicio AND d.cod_planserv(+) = ev_cod_planserv AND SYSDATE BETWEEN d.fec_desde(+) AND NVL (d.fec_hasta(+), SYSDATE) AND e.cod_producto(+) = a.cod_producto AND e.cod_actabo(+) = 'FA' AND e.cod_servicio(+) =
                                                                                                                                                                                                                                                a.cod_servicio
                AND f.cod_producto(+) = e.cod_producto AND f.cod_actabo(+) = e.cod_actabo AND f.cod_tipserv(+) = e.cod_tipserv AND f.cod_servicio(+) = e.cod_servicio AND f.cod_planserv(+) = ev_cod_planserv AND SYSDATE BETWEEN f.fec_desde(+) AND NVL
                                                                                                                                                                                                                                                       (f.fec_hasta(+),
                                                                                                                                                                                                                                                        SYSDATE);

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11184;
         sv_mens_retorno := 'error al consultar servicio suplementario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_opc_pr(' || en_cod_tiplan || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_opc_pr(' || en_cod_tiplan || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ss_opc_pr;

   PROCEDURE ve_consulta_ss_defecto_pr (
      ev_cod_plantarif                ta_plantarif.cod_plantarif%TYPE,
      sc_ssdefecto       OUT NOCOPY   refcursor,
      sn_cod_retorno     OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY   ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      OPEN sc_ssdefecto FOR
         SELECT a.cod_servicio, a.cod_servsupl, a.cod_nivel
           FROM ga_servsupl a, gad_servsup_plan b
          WHERE a.cod_producto = 1 AND b.cod_producto = a.cod_producto AND b.cod_plantarif = ev_cod_plantarif AND b.cod_servicio = a.cod_servicio AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND b.tip_relacion IN (1, 3);

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11185;
         sv_mens_retorno := 'error al consultar servicio suplementario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_defecto_pr(' || ev_cod_plantarif || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_defecto_pr(' || ev_cod_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ss_defecto_pr;

   PROCEDURE ve_consulta_ss_perfil_pr (
      en_cod_actuacion                 icg_actuaciontercen.cod_actuacion%TYPE,
      en_cod_sistema                   icg_actuaciontercen.cod_sistema%TYPE,
      ev_tip_tecnologia                icg_actuaciontercen.tip_tecnologia%TYPE,
      ev_tip_terminal                  icg_actuaciontercen.tip_terminal%TYPE,
      sc_servsupl         OUT NOCOPY   refcursor,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento) IS
      lv_sql             ge_errores_pg.vquery;
      lv_des_error       ge_errores_pg.desevent;
      lv_cod_servicios   icg_actuaciontercen.cod_servicios%TYPE;
      lv_gruponivel      VARCHAR2 (6);
      ln_cod_servsupl    ga_servsupl.cod_servsupl%TYPE;
      ln_cod_nivel       ga_servsupl.cod_nivel%TYPE;
      ln_pos             INTEGER                                  := 1;
      ln_index           INTEGER                                  := 1;
      lv_where           ge_errores_pg.vquery;
   BEGIN
      SELECT cod_servicios
        INTO lv_cod_servicios
        FROM icg_actuaciontercen
       WHERE cod_producto = 1 AND cod_actuacion = en_cod_actuacion AND cod_sistema = en_cod_sistema AND tip_tecnologia = ev_tip_tecnologia AND tip_terminal = ev_tip_terminal;

      lv_where := ' WHERE cod_producto = 1 AND ';

      LOOP
         lv_gruponivel := SUBSTR (lv_cod_servicios, ln_pos, 6);
         EXIT WHEN lv_gruponivel IS NULL;
         lv_where := lv_where || '(cod_servsupl=' || TO_CHAR (TO_NUMBER (SUBSTR (lv_gruponivel, 1, 2))) || ' AND cod_nivel = ' || TO_CHAR (TO_NUMBER (SUBSTR (lv_gruponivel, 3, 4))) || ') OR';
         ln_pos := ln_pos + 6;
         ln_index := ln_index + 1;
      END LOOP;

      lv_where := SUBSTR (lv_where, 1, LENGTH (lv_where) - 2);                                                                                                                                                                                   --quitar  'OR'
      lv_sql := 'SELECT cod_servicio,cod_servsupl,cod_nivel';
      lv_sql := lv_sql || ' FROM ga_servsupl';

      OPEN sc_servsupl FOR lv_sql || lv_where;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11186;
         sv_mens_retorno := 'error al consultar servicio suplementario perfil';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_perfil_pr(' || en_cod_actuacion || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_perfil_pr(' || en_cod_actuacion || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ss_perfil_pr;

   PROCEDURE ve_valida_compatibilidad_ss_pr (
      ev_cod_servicio                ga_servsup_def.cod_servicio%TYPE,
      ev_cod_servdef                 ga_servsup_def.cod_servdef%TYPE,
      sn_ind_compatib   OUT NOCOPY   PLS_INTEGER,                                                                                                                                                                                 --0:compatible,1:incompatible
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      SELECT 1
        INTO sn_ind_compatib
        FROM ga_servsup_def
       WHERE cod_producto = 1 AND cod_servicio = ev_cod_servicio AND cod_servdef = ev_cod_servdef AND tip_relacion = 3 AND SYSDATE BETWEEN fec_desde AND NVL (fec_hasta, SYSDATE);

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_ind_compatib := 0;
      WHEN OTHERS THEN
         sn_cod_retorno := 11187;
         sv_mens_retorno := 'error al validar compatibilidad';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_compatibilidad_ss_pr(' || ev_cod_servicio || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_compatibilidad_ss_pr(' || ev_cod_servicio || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_valida_compatibilidad_ss_pr;

   PROCEDURE ve_consulta_ss_pp_pr (
      ev_cod_actabo                  ga_actabo.cod_actabo%TYPE,
      ev_cod_planserv                ga_planserv.cod_planserv%TYPE,
      ev_tip_terminal                ga_aboamist.tip_terminal%TYPE,
      en_cod_sistema                 icg_serviciotercen.cod_sistema%TYPE,
      en_cod_uso                     al_usos.cod_uso%TYPE,
      sc_sspp           OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      lv_sql                ge_errores_pg.vquery;
      lv_des_error          ge_errores_pg.desevent;
      lv_cod_serllaminter   ga_datosgener.cod_serllaminter%TYPE;
      lv_cod_detcel         ga_datosgener.cod_detcel%TYPE;
   BEGIN
      SELECT cod_serllaminter, cod_detcel
        INTO lv_cod_serllaminter, lv_cod_detcel
        FROM ga_datosgener;

      OPEN sc_sspp FOR
         SELECT   a.cod_servicio, a.cod_servsupl, a.cod_nivel, a.des_servicio, c.imp_tarifa AS tarifa_conexion, c.cod_moneda AS moneda_conexion, f.imp_tarifa AS tarifa_servicio, f.cod_moneda AS moneda_servicio, a.tip_servicio, j.des_valor
             FROM ga_servsupl a, ga_actuaserv b, ga_tarifas c, ge_monedas d, ga_actuaserv e, ga_tarifas f, ge_monedas g, icg_serviciotercen h, ga_servuso i, ged_codigos j
            WHERE a.cod_producto = 1 AND a.cod_servicio NOT IN (lv_cod_serllaminter, lv_cod_detcel) AND a.cod_nivel <> 0 AND a.cod_aplic LIKE '%P%' AND a.ind_comerc = 1 AND a.cod_producto = b.cod_producto(+) AND a.cod_servicio = b.cod_servicio(+)
                  AND b.cod_actabo(+) = ev_cod_actabo AND b.cod_tipserv(+) = 2 AND b.cod_producto = c.cod_producto(+) AND b.cod_actabo = c.cod_actabo(+) AND b.cod_tipserv = c.cod_tipserv(+) AND b.cod_servicio = c.cod_servicio(+) AND c.cod_planserv(+) =
                                                                                                                                                                                                                                                ev_cod_planserv
                  AND SYSDATE BETWEEN c.fec_desde(+) AND NVL (c.fec_hasta(+), SYSDATE) AND c.cod_moneda = d.cod_moneda(+) AND a.cod_producto = e.cod_producto(+) AND a.cod_servicio = e.cod_servicio(+) AND e.cod_actabo(+) = 'FA' AND e.cod_tipserv(+) = 2
                  AND e.cod_producto = f.cod_producto(+) AND e.cod_actabo = f.cod_actabo(+) AND e.cod_tipserv = f.cod_tipserv(+) AND e.cod_servicio = f.cod_servicio(+) AND f.cod_planserv(+) = ev_cod_planserv AND SYSDATE BETWEEN f.fec_desde(+) AND NVL
                                                                                                                                                                                                                                                         (f.fec_hasta(+),
                                                                                                                                                                                                                                                          SYSDATE)
                  AND f.cod_moneda = g.cod_moneda(+) AND h.cod_producto = a.cod_producto AND h.tip_terminal = ev_tip_terminal AND h.cod_sistema = en_cod_sistema AND h.cod_servicio = a.cod_servsupl AND i.cod_producto = a.cod_producto
                  AND i.cod_servicio = a.cod_servicio AND i.cod_uso = en_cod_uso AND j.cod_modulo = cv_modulo_ga AND j.nom_tabla = 'GA_SERVSUPL' AND j.nom_columna = 'TIP_SERVICIO' AND j.cod_valor = a.tip_servicio
                  AND a.cod_servicio NOT IN (SELECT cod_servicio
                                               FROM ga_tiposeguro
                                              WHERE cod_producto = a.cod_producto) AND a.cod_servicio NOT IN (SELECT cod_serviciodes
                                                                                                                FROM ga_tiposeguro
                                                                                                               WHERE cod_producto = a.cod_producto)
         ORDER BY a.des_servicio;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11188;
         sv_mens_retorno := 'error al consultar servicio suplementario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_pp_pr(' || ev_cod_actabo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_pp_pr(' || ev_cod_actabo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ss_pp_pr;

   PROCEDURE ve_consulta_ss_disp_pr (
      ev_cod_plantarif                 ta_plantarif.cod_plantarif%TYPE,
      en_cod_tiplan                    ta_plantarif.cod_tiplan%TYPE,
      ev_cod_planserv                  ga_planserv.cod_planserv%TYPE,
      ev_cod_tecnologia                al_tecnologia.cod_tecnologia%TYPE,
      ev_tip_terminal                  ga_aboamist.tip_terminal%TYPE,
      en_cod_uso                       al_usos.cod_uso%TYPE,
      en_cod_sistema                   icg_serviciotercen.cod_sistema%TYPE,
      sc_ss               OUT NOCOPY   refcursor,
      sn_cod_actcen       OUT NOCOPY   ga_actabo.cod_actcen%TYPE,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento) IS
      lv_sql          ge_errores_pg.vquery;
      lv_des_error    ge_errores_pg.desevent;
      lv_cod_actabo   ga_actabo.cod_actabo%TYPE;
      ln_valor        NUMBER (1);
   BEGIN
      sn_cod_retorno := 7150;

      SELECT 1
        INTO ln_valor
        FROM icg_sistema
       WHERE cod_sistema = en_cod_sistema;

      SELECT DECODE (en_cod_tiplan, 1, 'AM', 2, 'VO', 3, 'HH')
        INTO lv_cod_actabo
        FROM DUAL;

      sn_cod_retorno := 7160;
      sn_cod_actcen := fn_codactcen (1, lv_cod_actabo, cv_modulo_ga, ev_cod_tecnologia);

      IF en_cod_tiplan = 1 THEN
         ve_consulta_ss_pp_pr (lv_cod_actabo, ev_cod_planserv, ev_tip_terminal, en_cod_sistema, en_cod_uso, sc_ss, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      ELSE
         ve_consulta_ss_opc_pr (lv_cod_actabo, ev_cod_plantarif, en_cod_tiplan, ev_cod_tecnologia, ev_cod_planserv, sc_ss, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      END IF;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10871;
         sv_mens_retorno := 'Error al consultar servicio suplementario. No se retornaron registros';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_disp_pr(' || ev_cod_plantarif || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_disp_pr(' || ev_cod_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11189;
         sv_mens_retorno := 'error al consultar servicio suplementario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_disp_pr(' || ev_cod_plantarif || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_disp_pr(' || ev_cod_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ss_disp_pr;

   PROCEDURE ve_consulta_ligados_pr (
      ev_cod_servicio                ga_servsup_def.cod_servicio%TYPE,
      sc_ss             OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      OPEN sc_ss FOR
         SELECT a.cod_servdef, b.cod_servsupl, b.cod_nivel
           FROM ga_servsup_def a, ga_servsupl b
          WHERE a.cod_producto = 1 AND a.cod_servicio = ev_cod_servicio AND a.cod_producto = b.cod_producto AND a.cod_servdef = b.cod_servicio AND tip_relacion = 1 AND SYSDATE BETWEEN fec_desde AND NVL (fec_hasta, SYSDATE);

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11190;
         sv_mens_retorno := 'error al consultar servicio ligado';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ligados_pr(' || ev_cod_servicio || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ligados_pr(' || ev_cod_servicio || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ligados_pr;

   PROCEDURE ve_obtener_fecha_sistema_pr (
      sd_fecha          OUT          VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento)
/*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "ve_valida_vendedor_pr"
         Lenguaje="PL/SQL"
         Fecha="27-08-2009"
         Version="1.0.0"
         Dise?ador="PCRV"
         Programador="PCRV"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 fecha de sistema formato 'dd-mm-yyyy hh24:mi:ss'
      </Descripcion>
      <Parametros>
      <Entrada>
      </Entrada>
      <Salida>
         <param nom="SD_fecha"  Tipo="VARCHAR2"> fecha de sistema </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
   IS
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      lv_formato     VARCHAR2 (22);
   BEGIN
      lv_formato := 'dd-mm-yyyy hh24:mi:ss';
      sd_fecha := TO_CHAR (SYSDATE, lv_formato);
      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11191;
         sv_mens_retorno := 'error al consultar fecha del sistema';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_obtener_fecha_sistema_pr();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_obtener_fecha_sistema_pr()', lv_sql, SQLCODE, lv_des_error);
   END ve_obtener_fecha_sistema_pr;

   PROCEDURE ve_valida_vendedor_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      en_tipo           IN              NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
/*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "ve_valida_vendedor_pr"
         Lenguaje="PL/SQL"
         Fecha="27-08-2009"
         Version="1.0.0"
         Dise?ador="PCRV"
         Programador="PCRV"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 Valida Vendedor
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_cod_vendedor"    Tipo="ve_vendedores.cod_vendedor"> Codigo de Vendedor</param>
          <param nom="EN_tipo"            Tipo="NUMBER"> Tipo</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
   IS
      lv_resultado   VARCHAR2 (1);
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ln_contador    NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT 1' || 'FROM   VE_VENDEDORES' || 'WHERE COD_VENDEDOR = ' || en_cod_vendedor || 'AND FEC_FINCONTRATO >= SYSDATE';

      IF en_tipo = 1 THEN
         --valida vendedor
         SELECT '1'
           INTO lv_resultado
           FROM ve_vendedores
          WHERE cod_vendedor = en_cod_vendedor AND (fec_fincontrato >= SYSDATE OR fec_fincontrato IS NULL);
      ELSE
         --valida dealer
         SELECT '1'
           INTO lv_resultado
           FROM ve_vendealer
          WHERE cod_vendealer = en_cod_vendedor AND (fec_fincontrato >= SYSDATE OR fec_fincontrato IS NULL);
      END IF;

      IF lv_resultado = 0 THEN
         sn_cod_retorno := 10010;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10872;
         sv_mens_retorno := 'Error al validar vendedor. No se retornaron registros';

         lv_des_error := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_vendedor_pr(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_vendedor_pr(' || en_cod_vendedor || ')', lv_ssql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11192;
         sv_mens_retorno := 'error al validar vendedor';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_vendedor_pr(' || en_cod_vendedor || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_valida_vendedor_pr(' || en_cod_vendedor || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_valida_vendedor_pr;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
   PROCEDURE ve_consulta_ss_opc_pr2 (
      ev_cod_actabo                    ga_actabo.cod_actabo%TYPE,
      ev_cod_plantarif                 ta_plantarif.cod_plantarif%TYPE,
      en_cod_tiplan                    ta_plantarif.cod_tiplan%TYPE,
      ev_cod_tecnologia                al_tecnologia.cod_tecnologia%TYPE,
      ev_cod_planserv                  ga_planserv.cod_planserv%TYPE,
      en_cod_servicio                  ga_servsupl.cod_servicio%TYPE,
      sn_cod_concepto     OUT NOCOPY   fa_conceptos.cod_concepto%TYPE,
      sn_cod_servsupl     OUT NOCOPY   ga_servsupl.cod_servsupl%TYPE,
      sn_cod_nivel        OUT NOCOPY   ga_servsupl.cod_nivel%TYPE,
      sn_cod_retorno      OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento) IS
      lv_cod_actabo   ga_actabo.cod_actabo%TYPE;
      ln_cod_actcen   ga_actabo.cod_actcen%TYPE;
      lv_sql          ge_errores_pg.vquery;
      lv_des_error    ge_errores_pg.desevent;
   BEGIN
      SELECT a.cod_servsupl, a.cod_nivel, DECODE (d.imp_tarifa, 0, 0, c.cod_concepto)
        INTO sn_cod_servsupl, sn_cod_nivel, sn_cod_concepto
        FROM ga_servsupl a, gad_servsup_plan b, ga_actuaserv c, ga_tarifas d, ga_actuaserv e, ga_tarifas f, ged_codigos h
       WHERE a.cod_producto = 1 AND a.cod_aplic LIKE DECODE (en_cod_tiplan, 1, '%P%', '%C%') AND b.cod_producto = a.cod_producto AND b.cod_plantarif = ev_cod_plantarif AND b.cod_servicio = a.cod_servicio
             AND SYSDATE BETWEEN b.fec_desde AND NVL (b.fec_hasta, SYSDATE) AND b.tip_relacion IN (2, 4) AND h.cod_modulo = cv_modulo_ga AND h.nom_tabla = 'GA_SERVSUPL' AND h.nom_columna = 'TIP_SERVICIO' AND h.cod_valor = a.tip_servicio
             AND c.cod_producto(+) = a.cod_producto AND c.cod_actabo(+) = lv_cod_actabo AND c.cod_servicio(+) = a.cod_servicio AND d.cod_producto(+) = c.cod_producto AND d.cod_actabo(+) = c.cod_actabo AND d.cod_tipserv(+) = c.cod_tipserv
             AND d.cod_servicio(+) = c.cod_servicio AND d.cod_planserv(+) = ev_cod_planserv AND SYSDATE BETWEEN d.fec_desde(+) AND NVL (d.fec_hasta(+), SYSDATE) AND e.cod_producto(+) = a.cod_producto AND e.cod_actabo(+) = 'FA' AND e.cod_servicio(+) =
                                                                                                                                                                                                                                                 a.cod_servicio
             AND f.cod_producto(+) = e.cod_producto AND f.cod_actabo(+) = e.cod_actabo AND f.cod_tipserv(+) = e.cod_tipserv AND f.cod_servicio(+) = e.cod_servicio AND f.cod_planserv(+) = ev_cod_planserv AND SYSDATE BETWEEN f.fec_desde(+) AND NVL (f.fec_hasta(+),
                                                                                                                                                                                                                                                       SYSDATE)
             AND a.cod_servicio = en_cod_servicio;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11193;
         sv_mens_retorno := 'error al consultar servicio suplementario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_opc_pr2(' || en_cod_servicio || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_opc_pr2(' || en_cod_servicio || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ss_opc_pr2;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
   PROCEDURE ve_consulta_ss_pp_pr2 (
      ev_cod_actabo                  ga_actabo.cod_actabo%TYPE,
      ev_cod_planserv                ga_planserv.cod_planserv%TYPE,
      ev_tip_terminal                ga_aboamist.tip_terminal%TYPE,
      en_cod_sistema                 icg_serviciotercen.cod_sistema%TYPE,
      en_cod_uso                     al_usos.cod_uso%TYPE,
      en_cod_servicio                ga_servsupl.cod_servicio%TYPE,
      sn_cod_concepto   OUT NOCOPY   fa_conceptos.cod_concepto%TYPE,
      sn_cod_servsupl   OUT NOCOPY   ga_servsupl.cod_servsupl%TYPE,
      sn_cod_nivel      OUT NOCOPY   ga_servsupl.cod_nivel%TYPE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      lv_sql                ge_errores_pg.vquery;
      lv_des_error          ge_errores_pg.desevent;
      lv_cod_serllaminter   ga_datosgener.cod_serllaminter%TYPE;
      lv_cod_detcel         ga_datosgener.cod_detcel%TYPE;
   BEGIN
      SELECT cod_serllaminter, cod_detcel
        INTO lv_cod_serllaminter, lv_cod_detcel
        FROM ga_datosgener;

      SELECT a.cod_servsupl, a.cod_nivel, DECODE (c.imp_tarifa, 0, 0, b.cod_concepto)
        INTO sn_cod_servsupl, sn_cod_nivel, sn_cod_concepto
        FROM ga_servsupl a, ga_actuaserv b, ga_tarifas c, ge_monedas d, ga_actuaserv e, ga_tarifas f, ge_monedas g, icg_serviciotercen h, ga_servuso i, ged_codigos j
       WHERE a.cod_producto = 1 AND a.cod_servicio NOT IN (lv_cod_serllaminter, lv_cod_detcel) AND a.cod_nivel <> 0 AND a.cod_aplic LIKE '%P%' AND a.ind_comerc = 1 AND a.cod_producto = b.cod_producto(+) AND a.cod_servicio = b.cod_servicio(+)
             AND b.cod_actabo(+) = ev_cod_actabo AND b.cod_tipserv(+) = 2 AND b.cod_producto = c.cod_producto(+) AND b.cod_actabo = c.cod_actabo(+) AND b.cod_tipserv = c.cod_tipserv(+) AND b.cod_servicio = c.cod_servicio(+) AND c.cod_planserv(+) =
                                                                                                                                                                                                                                                ev_cod_planserv
             AND SYSDATE BETWEEN c.fec_desde(+) AND NVL (c.fec_hasta(+), SYSDATE) AND c.cod_moneda = d.cod_moneda(+) AND a.cod_producto = e.cod_producto(+) AND a.cod_servicio = e.cod_servicio(+) AND e.cod_actabo(+) = 'FA' AND e.cod_tipserv(+) = 2
             AND e.cod_producto = f.cod_producto(+) AND e.cod_actabo = f.cod_actabo(+) AND e.cod_tipserv = f.cod_tipserv(+) AND e.cod_servicio = f.cod_servicio(+) AND f.cod_planserv(+) = ev_cod_planserv AND SYSDATE BETWEEN f.fec_desde(+) AND NVL (f.fec_hasta(+),
                                                                                                                                                                                                                                                       SYSDATE)
             AND f.cod_moneda = g.cod_moneda(+) AND h.cod_producto = a.cod_producto AND h.tip_terminal = ev_tip_terminal AND h.cod_sistema = en_cod_sistema AND h.cod_servicio = a.cod_servsupl AND i.cod_producto = a.cod_producto
             AND i.cod_servicio = a.cod_servicio AND i.cod_uso = en_cod_uso AND j.cod_modulo = cv_modulo_ga AND j.nom_tabla = 'GA_SERVSUPL' AND j.nom_columna = 'TIP_SERVICIO' AND j.cod_valor = a.tip_servicio
             AND a.cod_servicio NOT IN (SELECT cod_servicio
                                          FROM ga_tiposeguro
                                         WHERE cod_producto = a.cod_producto) AND a.cod_servicio NOT IN (SELECT cod_serviciodes
                                                                                                           FROM ga_tiposeguro
                                                                                                          WHERE cod_producto = a.cod_producto) AND a.cod_servicio = en_cod_servicio;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11194;
         sv_mens_retorno := 'error al consultar servicio suplementario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_pp_pr2(' || ev_cod_actabo || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_consulta_ss_pp_pr2(' || ev_cod_actabo || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_consulta_ss_pp_pr2;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtener_datos_ss_pr (
      en_numerocelular   IN              ga_abocel.num_celular%TYPE,
      ev_cod_servicio    IN              ga_servsupl.cod_servicio%TYPE,
      sn_cod_grupo       OUT NOCOPY      ga_servsupl.cod_servsupl%TYPE,
      sn_cod_nivel       OUT NOCOPY      ga_servsupl.cod_nivel%TYPE,
      sv_cod_concfact    OUT NOCOPY      ga_actuaserv.cod_concepto%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
/*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "ve_obtener_datos_ss_pr"
         Lenguaje="PL/SQL"
         Fecha="27-08-2009"
         Version="1.0.0"
         Dise?ador="PCRV"
         Programador="PCRV"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
                 Obtiene Datos de SS
      </Descripcion>
      <Parametros>
      <Entrada>
          <param nom="EN_num_celular"    Tipo="ga_abocel.num_celular%TYPE"> Numero de Celular</param>
          <param nom="EV_cod_servicio"   Tipo="ga_servsuplabo.cod_servicio%TYPE"> Codigo de Servicio</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_grupo"      Tipo="ga_servsupl.cod_servsupl"> Grupo </param>
         <param nom="SN_cod_nivel"      Tipo="ga_servsupl.cod_nivel"> Nivel </param>
         <param nom="SV_cod_concfact"   Tipo="ga_actuaserv.COD_CONCEPTO"> Concepto Facturable </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
   IS
      lv_resultado        VARCHAR2 (1);
      lv_des_error        ge_errores_pg.desevent;
      lv_ssql             ge_errores_pg.vquery;
      ln_contador         NUMBER;
      lv_cod_actabo       ga_actabo.cod_actabo%TYPE;
      lv_codtipplan       ta_plantarif.cod_tiplan%TYPE;
      ln_valor            NUMBER (1);
      ln_cod_uso          al_usos.cod_uso%TYPE;
      ln_num_abonado      ga_abocel.num_abonado%TYPE;
      lv_cod_planserv     ga_abocel.cod_planserv%TYPE;
      lv_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
      lv_tip_terminal     ga_abocel.tip_terminal%TYPE;
      lv_cod_tecnologia   ga_abocel.cod_tecnologia%TYPE;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      SELECT num_abonado, cod_planserv, cod_plantarif, tip_terminal, cod_tiplan, cod_tecnologia
        INTO ln_num_abonado, lv_cod_planserv, lv_cod_plantarif, lv_tip_terminal, lv_codtipplan, lv_cod_tecnologia
        FROM (SELECT abocel.num_abonado, abocel.cod_planserv, abocel.cod_plantarif, abocel.tip_terminal, plantarif.cod_tiplan, abocel.cod_tecnologia
                FROM ga_abocel abocel, ta_plantarif plantarif
               WHERE abocel.num_celular = en_numerocelular AND abocel.cod_situacion NOT IN ('BAA', 'BAP') AND plantarif.cod_producto = 1 AND abocel.cod_plantarif = plantarif.cod_plantarif
              UNION
              SELECT abomis.num_abonado, abomis.cod_planserv, abomis.cod_plantarif, abomis.tip_terminal, plantarif.cod_tiplan, abomis.cod_tecnologia
                FROM ga_aboamist abomis, ta_plantarif plantarif
               WHERE abomis.num_celular = en_numerocelular AND abomis.cod_situacion NOT IN ('BAA', 'BAP') AND plantarif.cod_producto = 1 AND abomis.cod_plantarif = plantarif.cod_plantarif);

      SELECT DECODE (lv_codtipplan, 1, 'AM', 2, 'VO', 3, 'HH')
        INTO lv_cod_actabo
        FROM DUAL;

      SELECT DECODE (lv_codtipplan, 1, 3, 2, 2, 3, 10)
        INTO ln_cod_uso
        FROM DUAL;

      IF lv_codtipplan = 1 THEN
         ve_consulta_ss_pp_pr2 (lv_cod_actabo, lv_cod_planserv, lv_tip_terminal, '1', ln_cod_uso, ev_cod_servicio, sv_cod_concfact, sn_cod_grupo, sn_cod_nivel, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      ELSE
         ve_consulta_ss_opc_pr2 (lv_cod_actabo, lv_cod_plantarif, lv_codtipplan, lv_cod_tecnologia, lv_cod_planserv, ev_cod_servicio, sv_cod_concfact, sn_cod_grupo, sn_cod_nivel, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      END IF;

      sn_cod_retorno := 0;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 11195;
         sv_mens_retorno := 'error al consultar datos de servicio suplementario';

         lv_des_error := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_obtener_datos_ss_pr(' || en_numerocelular || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_obtener_datos_ss_pr(' || en_numerocelular || ')', lv_ssql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 11195;
         sv_mens_retorno := 'error al consultar datos de servicio suplementario';

         lv_des_error := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_obtener_datos_ss_pr(' || en_numerocelular || ');- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_obtener_datos_ss_pr(' || en_numerocelular || ')', lv_ssql, SQLCODE, lv_des_error);
   END ve_obtener_datos_ss_pr;

   PROCEDURE ve_actualiza_claseserv_pr (
      ev_numeroabonado   IN              ga_abocel.num_abonado%TYPE,
      ev_claseservicio   IN              ga_abocel.clase_servicio%TYPE,
      ev_tipoplantarif   IN              ta_plantarif.cod_tiplan%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
                                                              /*--
                                                                 <Documentacion TipoDoc = "Procedimiento">
                                                                    Elemento Nombre = "VE_ACTUALIZA_CLASESERV_PR"
                                                                    Lenguaje="PL/SQL"
                                                                    Fecha="27-08-2009"
                                                                    Version="1.0.0"
                                                                    Dise?ador="PCRV"
                                                                    Programador="PCRV"
                                                                    Ambiente="BD"
                                                                 <Retorno>NA</Retorno>
                                                                 <Descripcion>
                                                                            ACTUALIZA LA CLASE DE SERVICIO EN LA TABLA ga_abocel o ga_aboamist
                                                                            dependiendo de el tipo plan tarifario
                                                                 </Descripcion>
                                                                 <Parametros>
                                                                 <Entrada>
                                                                     <param nom="EV_NUMEROABONADO"   Tipo="ga_abocel.num_abonado%TYPE"> Numero de Abonado</param>
                                                                     <param nom="EV_CLASESERVICIO"   Tipo="ga_abocel.clase_servicio%TYPE"> Clase de Servicio</param>
                                                                     <param nom="EV_TIPOPLANTARIF"   Tipo="ta_plantarif.cod_tiplan%TYPE"> Tipo Plan Tarifario</param>
                                                                 </Entrada>
                                                                 <Salida>
                                                                    <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                                                    <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                                                    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                                                                 </Salida>
                                                                 </Parametros>
                                                                 </Elemento>
                                                                 </Documentacion>
                                                                 --*/
   IS
      error_sql         EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      lv_formatofecha   VARCHAR2 (20);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      IF ev_tipoplantarif = 1 THEN
         UPDATE ga_abocel
            SET clase_servicio = ev_claseservicio
          WHERE num_abonado = ev_numeroabonado;
      ELSE
         UPDATE ga_aboamist
            SET clase_servicio = ev_claseservicio
          WHERE num_abonado = ev_numeroabonado;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11197;
         sv_mens_retorno := 'error al actualizar la clase de servicio';

         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_claseserv_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_claseserv_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_actualiza_claseserv_pr;



   FUNCTION ve_valida_aceptacion_venta_fn (
      ev_num_venta       IN              ga_ventas.num_venta%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
   RETURN BOOLEAN IS

      error_movimiento  EXCEPTION;
      error_sql         EXCEPTION;
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
      cant              NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';

      lv_ssql := 'SELECT SUM (c.cant) FROM (SELECT COUNT (1) AS cant FROM ga_abocel a, icc_movimiento b WHERE a.num_venta = '||ev_num_venta
              || ' AND b.num_abonado = a.num_abonado UNION SELECT COUNT (1) AS cant FROM ga_aboamist a, icc_movimiento b WHERE a.num_venta = '||ev_num_venta
              || ' AND b.num_abonado = a.num_abonado) c';

      SELECT SUM (c.cant)
        INTO cant
        FROM (SELECT COUNT (1) AS cant
                FROM ga_abocel a, icc_movimiento b
               WHERE a.num_venta = ev_num_venta
                 AND b.num_abonado = a.num_abonado
               UNION
              SELECT COUNT (1) AS cant
                FROM ga_aboamist a, icc_movimiento b
               WHERE a.num_venta = ev_num_venta
                 AND b.num_abonado = a.num_abonado) c;


      IF cant > 0 THEN
         RAISE error_movimiento;
      END IF;

   RETURN TRUE;

   EXCEPTION
      WHEN error_movimiento THEN
         sn_cod_retorno := 21197;
         sv_mens_retorno := 'error al validar movimientos pendientes de la venta - num_venta ['||ev_num_venta||']';
         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_claseserv_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_claseserv_PR', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := 31197;
         sv_mens_retorno := 'error al validar movimientos pendientes de la venta';
         lv_des_error := SUBSTR ('OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_claseserv_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_actualiza_claseserv_PR', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;

   END ve_valida_aceptacion_venta_fn;

   PROCEDURE ve_cons_plan_tarif_clie_emp_pr (
      ev_plantarif           IN              ta_plantarif.cod_plantarif%TYPE,
      en_codproducto         IN              ga_modvent_aplic.cod_producto%TYPE,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento) IS
       /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_consulta_plan_tarifario_PR
         Lenguaje="PL/SQL"
         Fecha="30-03-2007"
         Version="1.0.0"
         Dise?ador="Hector Hermosilla"
         Programador="Hector Hermosilla
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Consulta datos de una serie especifica
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EV_plantarif"          Tipo="STRING"> codigo plan tarifario a consultar</param>
         <param nom="EN_codproducto"        Tipo="NUMBER"> codigo producto</param>
         <param nom="EV_tecnologia"         Tipo="STRING"> codigo tecnologia</param>
      </Entrada>
      <Salida>
            <param nom="SV_desplantarif"      Tipo="STRING"> descripcion plan tarifario </param>
            <param nom="SV_tipplantarif"      Tipo="STRING"> codigo limite de consumo</param>
            <param nom="SV_codlimconsumo"     Tipo="STRING"> codigo limite de consumo</param>
            <param nom="SN_numdias"           Tipo="NUMBER"> numero de dias</param>
            <param nom="SV_codplanserv"       Tipo="STRING"> codigo plan de servicio</param>
         <param nom="SN_ind_cargo_habil"   Tipo="NUMBER"> indicador de cobro de habilitación</param>
            <param nom="SV_codcargobasico"    Tipo="STRING"> codigo cargo basico</param>
            <param nom="SV_descargobasico"    Tipo="STRING"> desccripción cargo basico</param>
            <param nom="SN_importecargo"      Tipo="NUMBER"> importe cargo basico</param>
            <param nom="SV_monedacargobasico" Tipo="STRING"> código moneda utilizada en cargo basico</param>
         <param nom="SV_codtiplan"         Tipo="STRING"> código tipo plan en GED_CODIGOS</param>
         <param nom="SN_ind_familiar"      Tipo="NUMBER"> indica si es plan familiar</param>
         <param nom="SN_numAbonados"       Tipo="NUMBER"> numero de abonados </param>
         <param nom="SV_cod_plan_comverse" Tipo="STRING"> codigo de plan converse </param>
         <param nom="SN_cod_retorno"       Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno"      Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"        Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
      cant           NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_sql :=
         'SELECT plantarifario.tip_plantarif, d.cod_limcons,' || ' plantarifario.num_dias, plantarifario.ind_cargo_habil,' || ' relserviciotecnoplantarif.cod_planserv,' || ' plantarifario.cod_cargobasico, cargosbasicos.des_cargobasico,'
         || ' cargosbasicos.imp_cargobasico, cargosbasicos.cod_moneda,' || ' plantarifario.cod_tiplan, plantarifario.ind_familiar,' || ' plantarifario.des_plantarif, plantarifario.num_abonados,' || ' plantarifario.cod_plan_comverse'
         || ' FROM   ta_plantarif plantarifario, ta_cargosbasico cargosbasicos,' || ' ga_plantecplserv relserviciotecnoplantarif,tol_limite_td d,' || ' tol_limite_plan_td e' || ' WHERE plantarifario.cod_plantarif= ' || ev_plantarif
         || ' AND SYSDATE BETWEEN plantarifario.fec_desde ' || ' AND NVL(plantarifario.fec_hasta, SYSDATE)' || ' AND plantarifario.cod_cargobasico= cargosbasicos.cod_cargobasico ' || ' AND plantarifario.cod_producto =' || en_codproducto
         || ' AND SYSDATE BETWEEN cargosbasicos.fec_desde ' || ' AND NVL(cargosbasicos.fec_hasta, SYSDATE)' || ' AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)'
         || ' AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)' || ' AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde'
         || ' AND NVL(relserviciotecnoplantarif.fec_hasta, SYSDATE)' || ' AND SYSDATE BETWEEN e.FEC_DESDE AND NVL(e.FEC_HASTA, SYSDATE)' || ' AND e.COD_PLANTARIF = plantarifario.cod_plantarif' || ' AND d.cod_limcons = e.cod_limcons' || ' AND ROWNUM<=1';


      SELECT SUM(cant) INTO cant
      FROM (
      SELECT COUNT(1) as cant
        FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif, tol_limite_td d, tol_limite_plan_td e
       WHERE plantarifario.cod_producto = en_codproducto
       AND plantarifario.cod_plantarif = ev_plantarif
       AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE)
       AND plantarifario.CLA_PLANTARIF <> 'SRV'
       AND plantarifario.cod_tiplan = 2
       AND cargosbasicos.cod_producto = plantarifario.cod_producto
       AND cargosbasicos.cod_cargobasico = plantarifario.cod_cargobasico
      AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE)
      AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)
      AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
      AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde AND NVL (relserviciotecnoplantarif.fec_hasta, SYSDATE)
      AND e.cod_plantarif = plantarifario.cod_plantarif
      AND e.ind_default = 'S'
      AND SYSDATE BETWEEN e.fec_desde AND NVL (e.fec_hasta, SYSDATE)
      AND D.cod_limcons = E.cod_limcons
      UNION
      SELECT count(1) as cant
       FROM ta_plantarif plantarifario, ta_cargosbasico cargosbasicos, ga_plantecplserv relserviciotecnoplantarif
       WHERE plantarifario.cod_producto = en_codproducto
       AND plantarifario.cod_plantarif = ev_plantarif
       AND SYSDATE BETWEEN plantarifario.fec_desde AND NVL (plantarifario.fec_hasta, SYSDATE)
       AND plantarifario.CLA_PLANTARIF <> 'SRV'
       AND plantarifario.cod_tiplan in (1,3)
       AND cargosbasicos.cod_producto = plantarifario.cod_producto
       AND cargosbasicos.cod_cargobasico = plantarifario.cod_cargobasico
      AND SYSDATE BETWEEN cargosbasicos.fec_desde AND NVL (cargosbasicos.fec_hasta, SYSDATE)
      AND plantarifario.cod_producto = relserviciotecnoplantarif.cod_producto(+)
      AND plantarifario.cod_plantarif = relserviciotecnoplantarif.cod_plantarif(+)
      AND SYSDATE BETWEEN relserviciotecnoplantarif.fec_desde AND NVL (relserviciotecnoplantarif.fec_hasta, SYSDATE));


      IF (cant < 1) THEN
         RAISE NO_DATA_FOUND;
      END IF;


   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10768;
         sv_mens_retorno := 'Error al consultar Plan Tarifario';
         lv_des_error    := 'NO_DATA_FOUND:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ',' || en_codproducto || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ')', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 11105;
         sv_mens_retorno := 'Error Al Consultar Plan Tarifario';
         lv_des_error    := 'OTHERS:VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ',' || en_codproducto || ');- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_consulta_plan_tarifario_PR(' || ev_plantarif || ')', lv_sql, SQLCODE, lv_des_error);
   END ve_cons_plan_tarif_clie_emp_pr;


   PROCEDURE ve_acep_venta_pr (
      so_ventas         IN OUT NOCOPY   ve_tipos_pg.tip_ga_ventas,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "GA_INSERT_VENTA_PR
            Lenguaje="PL/SQL"
            Fecha="03-05-2007"
            Versión="La del package"
            Diseñador="Raúl Lozano"
            Programador="Raúl Lozano"
            Ambiente Desarrollo="BD">
            <Retorno>SO_cuenta</Retorno>>
            <Descripción>Recupera El código del proceso de venta</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
               </Entrada>
               <Salida>
                  <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
      error_ejecucion EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF NOT (ve_valida_aceptacion_venta_fn (so_ventas (1).num_venta,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE error_ejecucion;
      END IF;

      UPDATE ga_ventas a
         SET a.ind_estventa = so_ventas (1).ind_estventa,
             a.nom_usuar_acerec = so_ventas (1).nom_usuar_acerec,
             a.fec_aceprec = SYSDATE
       WHERE num_venta = so_ventas (1).num_venta;

      UPDATE ge_clientes a
         SET a.ind_acepvent =1,
             a.fec_acepvent = sysdate
       WHERE a.cod_cliente = so_ventas (1).cod_cliente;

      UPDATE ga_abocel a
         SET a.fec_acepventa = SYSDATE
       WHERE a.num_venta = so_ventas (1).num_venta;


   EXCEPTION
      WHEN error_ejecucion THEN
         lv_des_error := 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_acep_venta_pr(' || '); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_acep_venta_pr', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10607;
         sv_mens_retorno := 'Error - Problemas al recuperar codigo de proceso de venta';

         lv_des_error := 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_acep_venta_pr(' || '); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_acep_venta_pr', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_acep_venta_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ve_list_tip_ident_pr (
      sc_tipos_ident         OUT NOCOPY      refcursor,
      sn_cod_retorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento          OUT NOCOPY      ge_errores_pg.evento) IS

      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      open sc_tipos_ident for
      select COD_TIPIDENT, DES_TIPIDENT from GE_TIPIDENT;


   EXCEPTION

      WHEN OTHERS THEN
         sn_cod_retorno := 10607;
         sv_mens_retorno := 'Error - Problemas al recuperar codigo de proceso de venta';
         lv_des_error := 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_list_tip_ident_pr(' || '); - ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_SERVICIOS_VENTA_QUIOSCO_PG.ve_list_tip_ident_pr', lv_ssql, sn_cod_retorno, lv_des_error);

   END ve_list_tip_ident_pr;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_actualiza_abovendealer_PR (
      en_numabonado       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updAbocelCodSituac_PR
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Version="1.0.0"
         Dise?ador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
         Actualiza codigo situacion del abonado
      </Descripcion>
      <Parametros>
      <Entrada>
         <param nom="EN_numVenta"       Tipo="NUMBER"> numero venta </param>
         <param nom="EV_codSituacion"   Tipo="STRING"> codigo situacion </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno"  Tipo="VARCHAR"> glosa mensaje error</param>
         <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'UPDATE ga_aboamist SET cod_vendealer = '' WHERE num_abonado = ' || en_numabonado;

      update ga_aboamist
        set   cod_vendealer = ''
        where num_abonado = en_numabonado;

        lv_ssql := 'update Ga_ventas set cod_vendealer= '' '
         || ' where num_venta in (select num_venta from ga_aboamist where num_abonado = '|| en_numabonado;

         update Ga_ventas
         set cod_vendealer= ''
         where num_venta in (select num_venta from ga_aboamist where num_abonado = en_numabonado);

   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 11155;
         sv_mens_retorno := 'error al actualizar codigo vendealer';

         lv_des_error := SUBSTR ('OTHERS:Ve_Servicios_Venta_Pg.VE_actualiza_abovendealer_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'Ve_Servicios_Venta_Pg.VE_actualiza_abovendealer_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END VE_actualiza_abovendealer_PR;

END VE_SERVICIOS_VENTA_QUIOSCO_PG;
/
SHOW ERRORS