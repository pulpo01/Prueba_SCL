CREATE OR REPLACE PACKAGE BODY        fa_pack_traspaso IS
  --
  -- Retrofitted
  PROCEDURE p_updateproc(
  v_num_proceso IN Fa_Procesos.num_proceso%TYPE ,
  v_letra IN Fa_HistDocu.letra%TYPE ,
  v_num_secuenci IN Fa_HistDocu.num_secuenci%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_main(
  v_cod_cliente IN Ge_Cargos.Cod_Cliente%TYPE ,
  v_num_abonado IN Ge_Cargos.Num_Abonado%TYPE ,
  v_num_transaccion IN number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    reg_fa_datosgener Fa_DatosGener%ROWTYPE;
    contador        number(6);
    vimp_facturable number := 0;
    vimp_descuento  number := 0;
    vimp_iva        number := 0;
    vtot_cargo      number := 0;
    vtot_dtos       number := 0;
    vtot_ivas       number := 0;
    vimp_traspaso   number := 0;
    vimp_dto        number := 0;
    vflag_dto       number(1) := 0;
    vcod_moneda     Ge_Monedas.Cod_Moneda%TYPE;
    vsqlcode number := 0;
    vsqlerrm varchar2(100) := '';
    Cursor Cur_Cargos is
           Select *
    From Ge_Cargos
    Where cod_cliente = v_cod_cliente
    And   num_abonado = v_num_abonado;
    reg_ge_cargos   Ge_Cargos%ROWTYPE;
    Begin
      Select Count(*) Into contador
      From Ge_Cargos
      Where cod_cliente = v_cod_cliente
      And   num_abonado = v_num_abonado;
      dbms_output.put_line('P_MAIN ');
      dbms_output.put_line('Cliente ='||to_char(v_cod_cliente));
      dbms_output.put_line('Abonado ='||to_char(v_num_abonado));
      dbms_output.put_line('Transaccion ='||to_char(v_num_transaccion));
      if contador > 0 then
         fa_pack_traspaso.p_getfadatosgener(reg_fa_datosgener);
         Open Cur_Cargos;
         Fetch Cur_Cargos Into reg_ge_cargos;
         For i in 1..contador Loop
             if reg_ge_cargos.cod_moneda != reg_fa_datosgener.cod_monefact then
                fa_pack_traspaso.p_getcambio (reg_ge_cargos.fec_alta,
                                         reg_ge_cargos.cod_moneda,
                                         reg_fa_datosgener.cod_monefact,
                                         reg_ge_cargos.imp_cargo,
                                         reg_ge_cargos.num_unidades,
                                         vimp_facturable);
                vtot_cargo := vtot_cargo + vimp_facturable;
             dbms_output.put_line('ImpFacturable ='||to_char(vimp_facturable));
                vimp_facturable := 0;
             else
                if reg_ge_cargos.num_unidades > 0 then
                   vtot_cargo := vtot_cargo + (reg_ge_cargos.imp_cargo *
                                               reg_ge_cargos.num_unidades);
                else
                   vtot_cargo := vtot_cargo + reg_ge_cargos.imp_cargo;
                end if;
             end if;
             dbms_output.put_line('TotCargo ='||to_char(vtot_cargo));
             fa_pack_traspaso.p_aplicadto(reg_ge_cargos,vimp_descuento,
                                          reg_fa_datosgener.cod_monefact,
                                          vflag_dto,vsqlcode,vsqlerrm);
             vtot_dtos      := vtot_dtos + vimp_descuento;
             dbms_output.put_line('TotDtos ='||to_char(vtot_dtos));
             dbms_output.put_line('ImpDescuento ='||to_char(vimp_descuento));
             dbms_output.put_line('FlagDto ='||to_char(vflag_dto));
             if vflag_dto = 1 then
                vimp_dto := vimp_descuento;
                dbms_output.put_line('vimp_dto al aplicariva ='||
                                    to_char(vimp_dto));
                fa_pack_traspaso.p_aplicaiva(v_cod_cliente,
                                             reg_fa_datosgener.cod_monefact,
                                             reg_ge_cargos.cod_concepto_dto,
                                             reg_ge_cargos.num_unidades,
                                             vimp_dto,reg_ge_cargos.fec_alta,
                                             reg_fa_datosgener.cod_iva,
                                             reg_fa_datosgener.cod_monefact,
                                             vimp_iva,vsqlcode,vsqlerrm);
                dbms_output.put_line('Aplico iva a ImpIva =
  '||to_char(vimp_iva));
                vtot_ivas := vtot_ivas + vimp_iva;
                dbms_output.put_line('TotIvas ='||to_char(vtot_ivas));
                vimp_iva  := 0;
                vflag_dto := 0;
                vimp_dto  := 0;
             end if;
             vimp_descuento := 0;
             if vsqlcode = 0 then
                fa_pack_traspaso.p_aplicaiva(v_cod_cliente,
                                             reg_ge_cargos.cod_moneda,
                                             reg_ge_cargos.cod_concepto,
                                             reg_ge_cargos.num_unidades,
                                             reg_ge_cargos.imp_cargo,
                                             reg_ge_cargos.fec_alta,
                                             reg_fa_datosgener.cod_iva,
                                             reg_fa_datosgener.cod_monefact,
                                             vimp_iva,vsqlcode,vsqlerrm);
                dbms_output.put_line('Aplico iva al cargo ImpIva ='||
                                      to_char(vimp_iva));
                vtot_ivas := vtot_ivas + vimp_iva;
                dbms_output.put_line('TotIvas ='||to_char(vtot_ivas));
                vimp_iva  := 0;
             else
                exit;
             end if;
      Fetch Cur_Cargos Into reg_ge_cargos;
      Exit When Cur_Cargos%NOTFOUND;
         End Loop;
         Close Cur_Cargos;
         vimp_traspaso := round(vtot_cargo + vtot_dtos + vtot_ivas);
         vcod_moneda   := reg_fa_datosgener.cod_monefact;
         dbms_output.put_line('Imptraspaso ='||to_char(vimp_traspaso));
         dbms_output.put_line('TotCargo ='||to_char(vtot_cargo));
         dbms_output.put_line('TotDtos ='||to_char(vtot_dtos));
         dbms_output.put_line('TotIvas ='||to_char(vtot_ivas));
         dbms_output.put_line('CodMoneda ='||vcod_moneda);
         fa_pack_traspaso.p_ins_transacabo(v_num_transaccion,vimp_traspaso,
                                           vcod_moneda,vsqlcode,vsqlerrm);
      else
         v_sqlcode := -1403;
         v_sqlerrm := 'No se encontraron registros en Ge_Cargos';
      end if;
    exception
      when others then
    raise_application_error(-20545,SQLERRM);
    End p_main;
  --
  -- Retrofitted
  PROCEDURE p_aplicadto(
  v_reg_ge_cargos IN OUT Ge_Cargos%ROWTYPE ,
  v_imp_descuento OUT number ,
  v_cod_monefact IN Fa_DatosGener.Cod_MoneFact%TYPE ,
  v_flag_dto OUT number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    v_impdescuento   number := 0;
    v_imp_facturable number := 0;
    Begin
      dbms_output.put_line('Aplica DTO ');
      if v_reg_ge_cargos.cod_concepto_dto > 0 then
         if v_reg_ge_cargos.cod_moneda != v_cod_monefact then
            dbms_output.put_line('moneda Ori = '||v_reg_ge_cargos.cod_moneda);
            dbms_output.put_line('moneda Des = '||v_cod_monefact);
            if v_reg_ge_cargos.tip_dto = 1 then /* Por porcentaje */
               dbms_output.put_line('Tip_Dto % = '||
                                     to_char(v_reg_ge_cargos.tip_dto));
               dbms_output.put_line('VAL_Dto % = '||
                                     to_char(v_reg_ge_cargos.val_dto));
               dbms_output.put_line('NumUnidades = '||
                                     to_char(v_reg_ge_cargos.num_unidades));
               dbms_output.put_line('ImpCargo = '||
                                     to_char(v_reg_ge_cargos.imp_cargo));
               fa_pack_traspaso.p_getcambio(v_reg_ge_cargos.fec_alta,
                                       v_reg_ge_cargos.cod_moneda,v_cod_monefact
  ,
                                       v_reg_ge_cargos.imp_cargo,
                                       v_reg_ge_cargos.num_unidades,
                                       v_imp_facturable);
               v_impdescuento := (v_imp_facturable*v_reg_ge_cargos.val_dto/100)
                                  *-1;
               dbms_output.put_line('ImpFacturable DTO = '||
                                     to_char(v_imp_facturable));
               dbms_output.put_line('ImpDescuento  =
  '||to_char(v_impdescuento));
            elsif v_reg_ge_cargos.tip_dto = 0 then /* Por monto */
                  dbms_output.put_line('Tip_Dto $= '||
                                        to_char(v_reg_ge_cargos.tip_dto));
                  fa_pack_traspaso.p_getcambio (v_reg_ge_cargos.fec_alta,
                                           v_reg_ge_cargos.cod_moneda,
                                           v_cod_monefact,v_reg_ge_cargos.val_dto
  ,
                                           v_reg_ge_cargos.num_unidades,
                                           v_imp_facturable);
                  dbms_output.put_line('Val_Dto $= '||
                                        to_char(v_reg_ge_cargos.val_dto));
                  v_impdescuento := v_imp_facturable * -1;
                  dbms_output.put_line('ImpDescuento $= '||
                                        to_char(v_impdescuento));
                  dbms_output.put_line('ImpFacturable $= '||
                                        to_char(v_imp_facturable));
            end if;
         else
            if v_reg_ge_cargos.tip_dto = 1 then /* Por porcentaje */
               v_impdescuento := (v_reg_ge_cargos.imp_cargo *
                                  v_reg_ge_cargos.val_dto / 100)*-1;
            else /* Por monto 0 */
               v_impdescuento := v_reg_ge_cargos.val_dto * -1;
            end if;
         end if;
         v_flag_dto := 1;
      end if;
      v_imp_descuento := v_impdescuento;
      v_sqlcode := 0;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_aplicadto;
  --
  -- Retrofitted
  PROCEDURE p_getfadatosgener(
  v_fa_datosgener OUT Fa_DatosGener%ROWTYPE )
  IS
    Begin
     Select * Into v_fa_datosgener
     From Fa_DatosGener;
    exception
      when no_data_found then
           raise_application_error (-20515, 'No hay datos en Fa_DatosGener');
      when too_many_rows then
           raise_application_error (-20515, 'Demasiadas filas Fa_DatosGener');
      when others then
           raise_application_error (-20515,SQLERRM);
    End p_getfadatosgener;
  --
  -- Retrofitted
  PROCEDURE p_updateproc(
  v_num_proceso IN Fa_Procesos.num_proceso%TYPE ,
  v_letra IN Fa_HistDocu.letra%TYPE ,
  v_num_secuenci IN Fa_HistDocu.num_secuenci%TYPE )
  IS
    Begin
      Update Fa_Procesos set letraag    = v_letra,
                         num_secuag = v_num_secuenci
      Where num_proceso = v_num_proceso;
    exception
      when others then
           raise_application_error (-20516,SQLERRM);
    End p_updateproc;
  --
  -- Retrofitted
  PROCEDURE p_getcambio(
  v_fec_valor IN Fa_HistConcCelu.fec_valor%TYPE ,
  v_cod_monedaorig IN Fa_HistConcCelu.Cod_Moneda%TYPE ,
  v_cod_monedadest IN Fa_DatosGener.Cod_MoneFact%TYPE ,
  v_imp_concepto IN Fa_HistConcCelu.Imp_Concepto%TYPE ,
  v_num_unidades IN Fa_HistConcCelu.Num_Unidades%TYPE ,
  v_imp_facturable OUT Fa_HistConcCelu.Imp_Facturable%TYPE )
  IS
    v_cambiorig   Ge_Conversion.Cambio%TYPE;
    v_cambiodes   Ge_Conversion.Cambio%TYPE;
    Begin
      Select cambio Into v_cambiorig
      From Ge_Conversion
      Where fec_desde <= v_fec_valor
      And   fec_hasta >= v_fec_valor
      And   cod_moneda = v_cod_monedaorig;
      Select cambio Into v_cambiodes
      From Ge_Conversion
      Where fec_desde <= v_fec_valor
      And   fec_hasta >= v_fec_valor
      And   cod_moneda = v_cod_monedadest;
      if v_num_unidades > 0 then
         v_imp_facturable := v_num_unidades *
                            (round(v_imp_concepto
  ,2) * (v_cambiorig/v_cambiodes));
      else
         v_imp_facturable := round(v_imp_concepto
  ,2) * (v_cambiorig/v_cambiodes);
      end if;
    exception
      when no_data_found then
           raise_application_error (-20521,'no existen datos en GE_CONVERSION');
      when too_many_rows then
           raise_application_error (-20521, 'Demasiadas filas en GE_CONVERSION
  ');
      when others then
           raise_application_error (-20521,SQLERRM);
    End p_getcambio;
  --
  -- Retrofitted
  PROCEDURE p_aplicaiva(
  v_cod_cliente IN Ge_Cargos.Cod_Cliente%TYPE ,
  v_cod_moneda IN Ge_Cargos.Cod_Moneda%TYPE ,
  v_cod_concepto IN Ge_Cargos.Cod_Concepto%TYPE ,
  v_num_unidades IN Ge_Cargos.Num_Unidades%TYPE ,
  v_imp_cargo IN Ge_Cargos.Imp_Cargo%TYPE ,
  v_fec_alta IN Ge_Cargos.Fec_Alta%TYPE ,
  v_cod_iva IN Fa_DatosGener.Cod_Iva%TYPE ,
  v_cod_monefact IN Fa_DatosGener.Cod_MoneFact%TYPE ,
  v_imp_iva OUT number ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    vcod_region     Ge_Direcciones.Cod_Region%TYPE;
    vcod_provincia  Ge_Direcciones.Cod_Provincia%TYPE;
    vcod_ciudad     Ge_Direcciones.Cod_Ciudad%TYPE;
    vcatimpos       Ge_CatImpClientes.Cod_CatImpos%TYPE;
    vcod_zonaimpo   Ge_ZonaCiudad.Cod_ZonaImpo%TYPE;
    vcod_grpservi   Fa_GrpSerConc.Cod_GrpServi%TYPE;
    vcod_concgene   Ge_Impuestos.Cod_ConcGene%TYPE;
    vprc_impuesto   Ge_Impuestos.Prc_Impuesto%TYPE;
    vimp_facturable number;
    vsqlcode        number := 0;
    vsqlerrm        varchar2(100) := '';
    Begin
      fa_pack_traspaso.p_getdireccli(v_cod_cliente,vcod_region,
                                     vcod_provincia,vcod_ciudad,
                                     vsqlcode, vsqlerrm);
      if vsqlcode = 0 then
         fa_pack_traspaso.p_getcatimpos(v_cod_cliente,v_fec_alta,
                                        vcatimpos,vsqlcode,vsqlerrm);
         if vsqlcode = 0 then
            fa_pack_traspaso.p_getzonaimpo(vcod_region,vcod_provincia,vcod_ciudad
  ,
                                           v_fec_alta,vcod_zonaimpo,
                                           vsqlcode,vsqlerrm);
            if vsqlcode = 0 then
               fa_pack_traspaso.p_getgrpservi(v_cod_concepto,v_fec_alta,
                                              vcod_grpservi,vsqlcode,vsqlerrm);
               if vsqlcode = 0 then
                  fa_pack_traspaso.p_getimpuesto(vcatimpos,vcod_zonaimpo,
                                                 v_cod_iva,vcod_grpservi,
                                                 v_fec_alta,vcod_concgene,
                                                 vprc_impuesto,vsqlcode,
                                                 vsqlerrm);
               end if;
            end if;
         end if;
      end if;
      dbms_output.put_line('Aplica IVA ');
      if vsqlcode = 0 then
         if v_cod_moneda != v_cod_monefact then
            fa_pack_traspaso.p_getcambio (v_fec_alta,v_cod_moneda,v_cod_monefact
  ,
                                     v_imp_cargo,v_num_unidades,
                                     vimp_facturable);
            v_imp_iva := vimp_facturable * vprc_impuesto/100;
            dbms_output.put_line('ImpFacturable ='||to_char(vimp_facturable));
         elsif v_num_unidades > 0 then
               dbms_output.put_line('ImpCargo ='||to_char(v_imp_cargo));
               v_imp_iva := ((v_imp_cargo * v_num_unidades) * vprc_impuesto
  )/100;
         else
               dbms_output.put_line('ImpCargo ='||to_char(v_imp_cargo));
             v_imp_iva := (v_imp_cargo * vprc_impuesto)/100;
         end if;
         dbms_output.put_line('Prcimpuesto ='||to_char(vprc_impuesto));
         dbms_output.put_line('NumUnidades ='||to_char(v_num_unidades));
      end if;
      v_sqlcode := vsqlcode;
    End p_aplicaiva;
  --
  -- Retrofitted
  PROCEDURE p_getcatimpos(
  v_cod_cliente IN Ge_Cargos.Cod_Cliente%TYPE ,
  v_fec_alta IN Ge_Cargos.Fec_Alta%TYPE ,
  v_catimpos OUT Ge_CatImpClientes.Cod_CatImpos%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
     Select cod_catimpos into v_catimpos
     From Ge_CatimpClientes
     Where cod_cliente = v_cod_cliente
     And   fec_desde <= v_fec_alta
     And   fec_hasta >= v_fec_alta;
     v_sqlcode := 0;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_getcatimpos;
  --
  -- Retrofitted
  PROCEDURE p_getdireccli(
  v_cod_cliente IN Ga_DirecCli.Cod_Cliente%TYPE ,
  v_cod_region OUT Ge_Direcciones.Cod_Region%TYPE ,
  v_cod_provincia OUT Ge_Direcciones.Cod_Provincia%TYPE ,
  v_cod_ciudad OUT Ge_Direcciones.Cod_Ciudad%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Select b.cod_region,b.cod_provincia,b.cod_ciudad
      Into v_cod_region,v_cod_provincia,v_cod_ciudad
      From Ge_Direcciones b , Ga_DirecCli a
      Where a.cod_cliente      = v_cod_cliente
      And   a.cod_tipdireccion = 2 /* Direccion Personal */
      And   a.cod_direccion    = b.cod_direccion;
      v_sqlcode := 0;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_getdireccli;
  --
  -- Retrofitted
  PROCEDURE p_getzonaimpo(
  v_cod_region IN Ge_Direcciones.Cod_Region%TYPE ,
  v_cod_provincia IN Ge_Direcciones.Cod_Provincia%TYPE ,
  v_cod_ciudad IN Ge_Direcciones.Cod_Ciudad%TYPE ,
  v_fec_alta IN Ge_Cargos.Fec_Alta%TYPE ,
  v_cod_zonaimpo OUT Ge_ZonaCiudad.Cod_ZonaImpo%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Select cod_zonaimpo Into v_cod_zonaimpo
      From Ge_zonaCiudad
      Where cod_region    = v_cod_region
      And   cod_provincia = v_cod_provincia
      And   cod_ciudad    = v_cod_ciudad
      And   fec_desde    <= v_fec_alta
      And   fec_hasta    >= v_fec_alta;
      v_sqlcode := 0;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_getzonaimpo;
  --
  -- Retrofitted
  PROCEDURE p_getgrpservi(
  v_cod_concepto IN Fa_GrpSerConc.Cod_Concepto%TYPE ,
  v_fec_alta IN date ,
  v_cod_grpservi OUT Fa_GrpSerConc.Cod_GrpServi%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Select cod_grpservi Into v_cod_grpservi
      From Fa_GrpSerConc
      Where cod_concepto = v_cod_concepto
      And   fec_desde   <= v_fec_alta
      And   fec_hasta   >= v_fec_alta;
      v_sqlcode := 0;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_getgrpservi;
  --
  -- Retrofitted
  PROCEDURE p_getimpuesto(
  v_cod_catimpos IN Ge_Impuestos.Cod_Catimpos%TYPE ,
  v_cod_zonaimpo IN Ge_Impuestos.Cod_ZonaImpo%TYPE ,
  v_cod_tipimpues IN Ge_Impuestos.Cod_TipImpues%TYPE ,
  v_cod_grpservi IN Ge_Impuestos.Cod_GrpServi%TYPE ,
  v_fec_alta IN date ,
  v_cod_concgene OUT Ge_Impuestos.Cod_ConcGene%TYPE ,
  v_prc_impuesto OUT Ge_Impuestos.Prc_Impuesto%TYPE ,
  v_sqlcode OUT number ,
  v_sqlerrm OUT varchar2 )
  IS
    Begin
      Select cod_concgene,prc_impuesto Into v_cod_concgene,v_prc_impuesto
      From Ge_Impuestos
      Where cod_catimpos  = v_cod_catimpos
      And   cod_zonaimpo  = v_cod_zonaimpo
      And   cod_tipimpues = v_cod_tipimpues
      And   cod_grpservi  = v_cod_grpservi
      And   fec_desde    <= v_fec_alta
      And   fec_hasta    >= v_fec_alta;
      v_sqlcode := 0;
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_getimpuesto;
  --
  -- Retrofitted
  PROCEDURE p_ins_transacabo(
  v_num_transaccion IN number ,
  v_imp_traspaso IN number ,
  v_cod_moneda IN varchar2 ,
  v_sqlcode IN OUT number ,
  v_sqlerrm IN OUT varchar2 )
  IS
    vdes_cadena varchar2(255) := '';
    vcod_retorno number(1);
    Begin
      if v_sqlcode != 0 then
         vcod_retorno := 4;
         vdes_cadena  := '/'||v_sqlerrm||'/';
      else
         vcod_retorno := 0;
         vdes_cadena  := '/'||to_char(v_imp_traspaso)||'/'||v_cod_moneda||'/';
      end if;
      dbms_output.put_line('Insert,vcod_retrorno ='||to_char(vcod_retorno));
      dbms_output.put_line('DesCadena ='||vdes_cadena);
      dbms_output.put_line('NumTransaccion ='||to_char(v_num_transaccion));
      Insert into Ga_Transacabo
            (num_transaccion,cod_retorno,des_cadena)
      Values (v_num_transaccion,vcod_retorno,vdes_cadena);
    exception
      when others then
           v_sqlcode := sqlcode;
           v_sqlerrm := substr(sqlerrm,1,100);
    End p_ins_transacabo;
END fa_pack_traspaso;
/
SHOW ERRORS
