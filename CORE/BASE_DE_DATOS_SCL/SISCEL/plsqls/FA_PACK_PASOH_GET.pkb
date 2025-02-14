CREATE OR REPLACE PACKAGE BODY        fa_pack_pasoh_get IS
  --
  -- Retrofitted
  PROCEDURE p_insdociclo(
  v_num_proceso IN Fa_HistDocu.Num_Proceso%TYPE )
  IS
    Begin
      dbms_output.put_line('Fa_HistDocu');
      dbms_output.put_line('N.Proceso ='||to_char(v_num_proceso));
      Insert Into Fa_HistDocu
            (num_secuenci,cod_tipdocum,cod_vendedor_agente,letra,cod_centremi ,
             tot_pagar,tot_cargosme,cod_vendedor,cod_cliente,fec_emision,
             fec_cambiomo,nom_usuarora,acum_netograv,acum_netonograv,acum_iva,
             ind_ordentotal,ind_visada,ind_libroiva,ind_pasocobro,
             ind_supertel,ind_anulada,num_proceso,num_folio,cod_plancom,
             cod_catimpos,fec_vencimie,fec_caducida,fec_proxvenc,cod_ciclfact,
             num_securel,letrarel,cod_tipdocumrel,cod_vendedor_agenterel,
             cod_centrrel,num_venta,num_transaccion,imp_saldoant,ind_impresa)
      Select /*+ index (FA_FACTDOCU NUK_FA_FACTDOCU_PROCESO) */
             num_secuenci,cod_tipdocum,cod_vendedor_agente,letra,cod_centremi ,
             tot_pagar,tot_cargosme,cod_vendedor,cod_cliente,fec_emision,
             fec_cambiomo,nom_usuarora,acum_netograv,acum_netonograv,acum_iva,
             ind_ordentotal,ind_visada,ind_libroiva,ind_pasocobro,
             ind_supertel,ind_anulada,num_proceso,num_folio,cod_plancom,
             cod_catimpos,fec_vencimie,fec_caducida,fec_proxvenc,cod_ciclfact,
             num_securel,letrarel,cod_tipdocumrel,cod_vendedor_agenterel,
             cod_centrrel,num_venta,num_transaccion,imp_saldoant,ind_impresa
      From Fa_FactDocu
      Where num_proceso= v_num_proceso;
    End p_insdociclo;
  --
  -- Retrofitted
  PROCEDURE p_inscliciclo(
  v_ind_ordentotal IN Fa_HistDocu.Ind_OrdenTotal%TYPE )
  IS
    Begin
      dbms_output.put_line('Fa_HistClie');
      dbms_output.put_line('Ordentotal ='||to_char(v_ind_ordentotal));
      Insert into Fa_HistClie
            (ind_ordentotal,cod_cliente,nom_cliente,cod_plancom,nom_apeclien1,
             nom_apeclien2,tef_cliente1,tef_cliente2,des_actividad,nom_calle,
             num_calle,num_piso,des_comuna,des_ciudad,cod_pais,ind_debito,
             imp_stopdebit,cod_banco,cod_sucursal,ind_tipcuenta,cod_tiptarjeta,
             num_ctacorr,num_tarjeta,fec_vencitarj,cod_bancotarj,cod_tipidtrib,
             num_identtrib,num_fax)
      Select ind_ordentotal,cod_cliente,nom_cliente,cod_plancom,nom_apeclien1,
             nom_apeclien2,tef_cliente1,tef_cliente2,des_actividad,nom_calle,
             num_calle,num_piso,des_comuna,des_ciudad,cod_pais,ind_debito,
             imp_stopdebit,cod_banco,cod_sucursal,ind_tipcuenta,cod_tiptarjeta,
             num_ctacorr,num_tarjeta,fec_vencitarj,cod_bancotarj,cod_tipidtrib,
             num_identtrib,num_fax
      From Fa_FactClie
      Where ind_ordentotal = v_ind_ordentotal;
    End p_inscliciclo;
  --
  -- Retrofitted
  PROCEDURE p_insabociclo(
  v_ind_ordentotal IN Fa_HistDocu.Ind_OrdenTotal%TYPE )
  IS
    Cursor Cur_AcumCiclo is
           Select distinct cod_producto
           From Fa_AcumuloProd
           Where ind_ordentotal = v_ind_ordentotal;
    vcod_producto     Ge_Productos.Cod_Producto%TYPE;
    rec_ge_datosgener Ge_DAtosGener%ROWTYPE;
    Begin
      dbms_output.put_line('InsAboCiclo');
      dbms_output.put_line('OrdenTotal ='||to_char(v_ind_ordentotal));
      fa_pack_pasoh_get.p_getgedatosgener(rec_ge_datosgener);
      Open Cur_AcumCiclo;
      Loop
        Fetch Cur_AcumCiclo Into vcod_producto;
        Exit when Cur_AcumCiclo%NOTFOUND;
        if vcod_producto = rec_ge_datosgener.prod_celular then
           dbms_output.put_line('HistAboCel');
           Insert Into Fa_HistAbocel
                 (ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,acum_cargo
  ,
                  acum_dto,acum_iva,num_celular,cod_detfact,fec_fincontra,
                  ind_factur,cod_credmor,nom_usuario,nom_apellido1,nom_apellido2
  ,
                  lim_credito,ind_supertel,num_telefija)
           Select ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,acum_cargo
  ,
                  acum_dto,acum_iva,num_celular,cod_detfact,fec_fincontra,
                  ind_factur,cod_credmor,nom_usuario,nom_apellido1,nom_apellido2
  ,
                  lim_credito,ind_supertel,num_telefija
           From Fa_FactAboCelu
           Where ind_ordentotal = v_ind_ordentotal;
           dbms_output.put_line('HistConcCelu');
           Insert Into Fa_HistConcCelu
                 (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto,
                  cod_tipconce,fec_valor,fec_efectividad,imp_concepto,cod_region
  ,
                  cod_provincia,cod_ciudad,imp_montobase,ind_factur,
                  imp_facturable,ind_supertel,num_abonado,cod_portador,
                  des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec,
                  num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,num_guia
  ,
                  ind_alta,num_paquete,flag_impues,flag_dto,cod_concerel,
                  columna_rel,seq_cuotas)
           Select ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto,
                  cod_tipconce,fec_valor,fec_efectividad,imp_concepto,cod_region
  ,
                  cod_provincia,cod_ciudad,imp_montobase,ind_factur,
                  imp_facturable,ind_supertel,num_abonado,cod_portador,
                  des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec,
                  num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,num_guia
  ,
                  ind_alta,num_paquete,flag_impues,flag_dto,cod_concerel,
                  columna_rel,seq_cuotas
           From Fa_VFactCelu
           Where ind_ordentotal = v_ind_ordentotal;
        elsif vcod_producto = rec_ge_datosgener.prod_beeper then
              dbms_output.put_line('HistAboBeep');
              Insert Into Fa_HistAboBeep
                    (ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,
                     acum_cargo,acum_dto,acum_iva,num_beeper,cap_code,
                     cod_detfact,fec_fincontra,ind_factur,cod_credmor,
                     nom_usuario,nom_apellido1,nom_apellido2,lim_credito)
              Select ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,
                     acum_cargo,acum_dto,acum_iva,num_beeper,cap_code,
                     cod_detfact,fec_fincontra,ind_factur,cod_credmor,
                     nom_usuario,nom_apellido1,nom_apellido2,lim_credito
              From Fa_FactAboBeep
              Where ind_ordentotal = v_ind_ordentotal;
              dbms_output.put_line('HistConcBeep');
              Insert Into Fa_HistConcBeep
                    (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas)
              Select ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas
              From Fa_VFactBeep
              Where ind_ordentotal = v_ind_ordentotal;
        elsif vcod_producto = rec_ge_datosgener.prod_trek then
              dbms_output.put_line('HistAboTrek');
              Insert Into Fa_HistAboTrek
                    (ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,
                     acum_cargo,acum_dto,acum_iva,num_man,cod_detfact,
                     fec_fincontra,ind_factur,cod_credmor,nom_usuario,
                     nom_apellido1,nom_apellido2,lim_credito)
              Select ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,
                     acum_cargo,acum_dto,acum_iva,num_man,cod_detfact,
                     fec_fincontra,ind_factur,cod_credmor,nom_usuario,
                     nom_apellido1,nom_apellido2,lim_credito
              From Fa_FactAboTrek
              Where ind_ordentotal = v_ind_ordentotal;
              dbms_output.put_line('HistConcTrek');
              Insert Into Fa_HistConcTrek
                    (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas)
              Select ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas
              From Fa_FactTrek
              Where ind_ordentotal = v_ind_ordentotal;
        elsif vcod_producto = rec_ge_datosgener.prod_trunk then
              dbms_output.put_line('HistAboTrunk');
              Insert Into Fa_HistAboTrunk
                    (ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,
                     acum_cargo,acum_dto,acum_iva,num_radio,cod_flota,
                     cod_subflota,cod_detfact,fec_fincontra,ind_factur,
                     cod_credmor,nom_usuario,nom_apellido1,nom_apellido2,
                     lim_credito)
              Select ind_ordentotal,num_abonado,cod_cliente,tot_cargosme,
                     acum_cargo,acum_dto,acum_iva,num_radio,cod_flota,
                     cod_subflota,cod_detfact,fec_fincontra,ind_factur,
                     cod_credmor,nom_usuario,nom_apellido1,nom_apellido2,
                     lim_credito
              From Fa_FactAboTrunk
              Where ind_ordentotal = v_ind_ordentotal;
              dbms_output.put_line('HistConcTrunk');
              Insert Into Fa_HistConcTrunk
                    (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas)
              Select ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas
              From Fa_FactTrunk
              where ind_ordentotal = v_ind_ordentotal;
        elsif vcod_producto = rec_ge_datosgener.prod_general then
              dbms_output.put_line('HistConcGene');
              Insert Into Fa_HistConcGene
                    (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas)
              Select ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto
  ,
                     cod_tipconce,fec_valor,fec_efectividad,imp_concepto,
                     cod_region,cod_provincia,cod_ciudad,imp_montobase,ind_factur
  ,
                     imp_facturable,ind_supertel,num_abonado,cod_portador,
                     des_concepto,num_cuotas,ord_cuota,num_unidades,num_seriemec
  ,
                     num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
                     num_guia,ind_alta,num_paquete,flag_impues,flag_dto,
                     cod_concerel,columna_rel,seq_cuotas
              From Fa_FactGene
              where ind_ordentotal = v_ind_ordentotal;
        end if;
      End Loop;
     Close Cur_AcumCiclo;
    End p_insabociclo;
  --
  -- Retrofitted
  PROCEDURE p_getgedatosgener(
  v_ge_datosgener OUT Ge_DatosGener%ROWTYPE )
  IS
    Begin
      Select *
      Into   v_ge_datosgener
      From Ge_DatosGener;
    exception
      when no_data_found then
           raise_application_error (-20518,'no existen datos en GE_DATOSGENER');
      when too_many_rows then
           raise_application_error (-20518, 'Demasiadas filas en GE_DATOSGENER
  ');
      when others then
           raise_application_error (-20518,SQLERRM);
    End p_getgedatosgener;
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
END fa_pack_pasoh_get;
/
SHOW ERRORS
