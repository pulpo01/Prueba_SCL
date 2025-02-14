CREATE OR REPLACE PACKAGE BODY        fa_comp_get_presu is
  Procedure p_updatesec (v_cod_tipdocum in Fa_Procesos.cod_tipdocum%TYPE,
		         v_cod_centremi in Fa_Procesos.cod_centremi%TYPE,
			 v_letra in Fa_HistDocu.letra%TYPE,
			 v_secuencia in Fa_HistDocu.num_secuenci%TYPE) is
  Begin
    if v_secuencia = 99999999 then
       Update Ge_SecuenciasEmi set num_secuenci = 0
       Where cod_tipdocum = v_cod_tipdocum
       And cod_centremi = v_cod_centremi
       And letra = v_letra;
    else
       Update Ge_SecuenciasEmi set num_secuenci = v_secuencia
       Where cod_tipdocum = v_cod_tipdocum
       And cod_centremi = v_cod_centremi
       And letra = v_letra;
    end if;
  exception
    when no_data_found then
         raise_application_error (-20501, 'No hay dato en GE_SECUENCIASEMI');
    when others then
         raise_application_error (-20501,SQLERRM);
  End p_updatesec;
  Procedure p_getcargosme(rec_presupuesto in Fa_Presupuesto%ROWTYPE,
                          v_monefact in Fa_DatosGener.Cod_MoneFact%TYPE,
			  v_tot_cargosme in out Fa_HistDocu.tot_cargosme%TYPE)
                          is
  Begin
  -- Este procedimiento fue cambiado y existe en pres.old.Z
    Select nvl(sum(decode(cod_tipconce,3,imp_facturable*num_unidades,
                                       4,imp_facturable*num_unidades,
                                       5,imp_facturable*num_unidades,
                                       imp_facturable)),0)
    Into v_tot_cargosme
    From Fa_Presupuesto
    Where num_proceso = rec_presupuesto.num_proceso
    And   cod_cliente = rec_presupuesto.cod_cliente;
  exception
    when no_data_found then
         raise_application_error (-20502, 'No hay dato en FA_PRESUPUESTO');
    when too_many_rows then
         raise_application_error (-20502, 'Demasiadas filas FA_PRESUPUESTO');
    when others then
         raise_application_error (-20502,SQLERRM);
  End p_getcargosme;
  Procedure p_getcarabo (rec_presupuesto in Fa_Presupuesto%ROWTYPE,
	                 v_tot_abonado in out Fa_HistAboCel.tot_cargosme%TYPE,
	                 v_tot_cargo   in out Fa_HistAboCel.acum_cargo%TYPE,
	                 v_tot_dto     in out Fa_HistAboCel.acum_dto%TYPE,
	                 v_tot_iva     in out Fa_HistAboCel.acum_iva%TYPE,
                         v_monefact in out Fa_DatosGener.Cod_MoneFact%TYPE)
                         is
  Cursor Cur_Cargos is
         Select sum(imp_facturable*num_unidades),cod_tipconce
         From Fa_Presupuesto
         Where num_proceso = rec_presupuesto.num_proceso
         And cod_cliente   = rec_presupuesto.cod_cliente
         And num_abonado   = rec_presupuesto.num_abonado
         Group by cod_tipconce;
  vimp_facturable Fa_HistAbocel.Tot_Cargosme%TYPE;
  vcod_tipconce   Fa_Conceptos.Cod_TipConce%TYPE;
  Begin
    v_tot_abonado := 0;
    v_tot_cargo   := 0;
    v_tot_dto     := 0;
    v_tot_iva     := 0;
    Open Cur_Cargos;
    Loop
      Fetch Cur_Cargos Into vimp_facturable,vcod_tipconce;
      Exit When Cur_Cargos%NOTFOUND;
      if vcod_tipconce >= 3 then
         v_tot_cargo := vimp_facturable;
       -- Acumulado de cargos del abonado
      elsif vcod_tipconce = 2 then
            v_tot_dto := vimp_facturable;
       -- Acumulado de los descuentos del abonado
      elsif vcod_tipconce = 1 then
            v_tot_iva := vimp_facturable;
       -- Acumulado de los impuestos del abonado
      end if;
    End Loop;
    Close Cur_Cargos;
    -- Acumulado del consumo del abonado
    v_tot_abonado := v_tot_cargo + v_tot_dto + v_tot_iva;
  exception
    when no_data_found then
         raise_application_error (-20503, 'No hay dato en FA_PRESUPUESTO');
    when too_many_rows then
         raise_application_error (-20503, 'Demasiadas filas FA_PRESUPUESTO');
    when others then
         raise_application_error (-20503,SQLERRM);
  End p_getcarabo;
  Procedure p_getvendedor (v_num_transaccion in
                                         Ga_TransContado.Num_Transaccion%TYPE,
                           v_num_venta in Ga_Ventas.Num_Venta%TYPE,
			   v_cod_vendedor out Fa_HistDocu.cod_vendedor%TYPE) is
  Begin
    /*dbms_output.put_line('Num_Venta ='||to_char(v_num_venta));
    dbms_output.put_line('Num_Transaccion ='||to_char(v_num_transaccion));*/
    if v_num_venta > 0 then
       Select cod_vendedor Into v_cod_vendedor
       From Ga_Ventas
       Where num_venta     = v_num_venta;
    else
       Select cod_vendedor_agente Into v_cod_vendedor
       From Ga_TransContado
       Where num_transaccion = v_num_transaccion;
    end if;
  exception
    when too_many_rows then
         if v_num_venta >0 then
            raise_application_error (-20504,'Demasiadas filas GA_VENTAS');
         else
            raise_application_error (-20504,'Demasiadas filas GA_TRANSCONTADO');
         end if;
    when no_data_found then
         if v_num_venta >0 then
            raise_application_error (-20504, 'No hay dato en GA_VENTAS');
         else
            raise_application_error (-20504, 'No hay dato en GA_TRANSCONTADO');
         end if;
    when others then
         raise_application_error (-20504,SQLERRM);
  End p_getvendedor;
  Procedure p_getfechas(v_cod_ciclfact in Fa_Presupuesto.cod_ciclfact%TYPE,
			v_fec_emision out Fa_HistDocu.fec_emision%TYPE,
			v_fec_vencimie out Fa_HistDocu.fec_vencimie%TYPE,
			v_fec_caducida out Fa_HistDocu.fec_caducida%TYPE,
			v_fec_proxvenc out Fa_HistDocu.fec_proxvenc%TYPE) is
  Begin
    Select fec_emision,fec_vencimie,fec_caducida,fec_proxvenc
    Into v_fec_emision,v_fec_vencimie,v_fec_caducida,v_fec_proxvenc
    From Fa_CiclFact
    Where cod_ciclfact = v_cod_ciclfact;
  exception
    when too_many_rows then
         raise_application_error (-20505, 'Demasiadas filas FA_CICLFACT');
    when no_data_found then
         raise_application_error (-20505, 'No hay dato en FA_CICLFACT');
    when others then
         raise_application_error (-20505,SQLERRM);
  End p_getfechas;
  Procedure p_getfeccambiomo (v_fec_valor in Fa_Presupuesto.fec_valor%TYPE,
		              v_fec_cambiomo out Fa_HistDocu.fec_cambiomo%TYPE)
                              is
  Begin
    Select fec_desde Into v_fec_cambiomo
    From Ge_Conversion
    Where fec_desde <= v_fec_valor
    And   fec_hasta >= v_fec_valor
    And cod_moneda = (Select cod_peso From Fa_DatosGener);
  exception
    when too_many_rows then
         raise_application_error (-20506, 'Demasiadas filas GE_CONVERSION');
    when no_data_found then
         v_fec_cambiomo:=  sysdate;
         raise_application_error (-20506, 'No hay dato en GE_CONVERSION');
    when others then
         raise_application_error (-20506,SQLERRM);
  End p_getfeccambiomo;
  Procedure p_getacum (v_num_proceso in Fa_Procesos.num_proceso%TYPE,
		       v_rec_fa_histdocu in out Fa_HistDocu%ROWTYPE,
		       v_monefact in out Fa_DatosGener.Cod_MoneFact%TYPE) is
  Begin
  -- Suma sobre concepto distintos a Impuestos y que se les halla
  -- aplicado Impuesto.
    v_rec_fa_histdocu.acum_netograv := 0;
    Select nvl(sum(decode(cod_tipconce,3,imp_facturable*num_unidades,
                                       4,imp_facturable*num_unidades,
                                       5,imp_facturable*num_unidades,
                                       imp_facturable)),0)
    Into v_rec_fa_histdocu.acum_netograv
    From Fa_Presupuesto
    Where num_proceso = v_num_proceso
    And cod_cliente = v_rec_fa_histdocu.cod_cliente
    And flag_impues = 1
    And cod_tipconce != 1;
  -- Suma sobre concepto distintos a Impuestos y que no se les halla
  -- aplicado Impuesto.
    v_rec_fa_histdocu.acum_netonograv := 0;
    Select nvl(sum(decode(cod_tipconce,3,imp_facturable*num_unidades,
                                       4,imp_facturable*num_unidades,
                                       5,imp_facturable*num_unidades,
                                       imp_facturable)),0)
    Into v_rec_fa_histdocu.acum_netonograv
    From Fa_Presupuesto
    Where num_proceso = v_num_proceso
    And cod_cliente = v_rec_fa_histdocu.cod_cliente
    And flag_impues = 0
    And cod_tipconce != 1;
  -- Suma sobre concepto del tipo Impuestos.
    v_rec_fa_histdocu.acum_iva := 0;
    Select nvl(sum(decode(num_unidades,0,imp_facturable,
                                       imp_facturable*num_unidades)),0)
    Into v_rec_fa_histdocu.acum_iva
    From Fa_Presupuesto
    Where num_proceso = v_num_proceso
    And cod_cliente   = v_rec_fa_histdocu.cod_cliente
    And cod_tipconce  = 1;
  exception
    when too_many_rows then
         raise_application_error (-20507, 'Demasiadas filas FA_PRESUPUESTO');
    when no_data_found then
         raise_application_error (-20507, 'No hay dato en FA_PRESUPUESTO');
    when others then
         raise_application_error (-20507,SQLERRM);
  End p_getacum;
  Procedure p_getlimcredito(v_cod_cliente in Fa_Presupuesto.cod_Cliente%TYPE,
			    v_lim_credito out Fa_HistAboCel.lim_credito%TYPE) is
  Begin
    Select imp_morosidad Into v_lim_credito
    From Co_LimCreditos
    Where cod_credmor = (Select cod_credmor From Ge_Clientes
		         Where cod_cliente = v_cod_cliente);
  exception
    when too_many_rows then
         raise_application_error (-20508, 'Demasiadas filas CO_LIMCREDITOS');
    when no_data_found then
         raise_application_error (-20508, 'No hay dato en CO_LIMCREDITOS');
    when others then
         raise_application_error (-20508,SQLERRM);
  End p_getlimcredito;
  Procedure p_getdesabocelu(v_cod_cliente in Fa_HistDocu.Cod_Cliente%TYPE,
                           v_num_abonado in Fa_Presupuesto.Num_Abonado%TYPE,
                           v_prod_celular in Ge_DatosGener.Prod_Celular%TYPE,
                           v_nom_usuario out Fa_HistAboCel.nom_usuario%TYPE,
                         v_nom_apellido1 out Fa_HistAboCel.nom_apellido1%TYPE,
                         v_nom_apellido2 out Fa_HistAboCel.nom_apellido2%TYPE,
                           v_num_telefija out Fa_HistAboCel.num_telefija%TYPE,
                           v_cod_credmor out Fa_HistAboCel.cod_credmor%TYPE,
                         v_fec_fincontra out Fa_HistAboCel.fec_fincontra%TYPE)
                         is
  Begin
    /*dbms_output.put_line('Abonado ='||to_char(v_num_abonado));
    dbms_output.put_line('ProdCelular ='||to_char(v_prod_celular));
    dbms_output.put_line('Cliente ='||to_char(v_cod_cliente));*/
    Select a.num_telefija,a.cod_credmor,a.fec_fincontra,
           b.nom_usuario,b.nom_apellido1,b.nom_apellido2
    Into   v_num_telefija,v_cod_credmor,v_fec_fincontra,
           v_nom_usuario,v_nom_apellido1,v_nom_apellido2
    From Ga_Abocel a, Ga_Usuarios b
    Where a.num_abonado = v_num_abonado
    And   a.cod_producto = v_prod_celular
    And   a.cod_cliente  = v_cod_cliente
    And   a.cod_usuario  = b.cod_usuario;
    /*Comentar con Juanfe para sacar un registro*/
  exception
    when too_many_rows then
         raise_application_error (-20509,'Demasiadas filas GETDESABOCELU');
    when no_data_found then
         raise_application_error
                         (-20509,'No hay dato en GA_ABOCEL o GA_USUARIOS');
    when others then
         raise_application_error (-20509,SQLERRM);
  End p_getdesabocelu;
  Procedure p_getdesabobeep(v_cod_cliente in Fa_HistDocu.Cod_Cliente%TYPE,
                        v_num_abonado in Fa_Presupuesto.Num_Abonado%TYPE,
                        v_prod_beeper in Ge_DatosGener.Prod_Beeper%TYPE,
                        v_nom_usuario out Fa_HistAboBeep.nom_usuario%TYPE,
                        v_nom_apellido1 out Fa_HistAboBeep.nom_apellido1%TYPE,
                        v_nom_apellido2 out Fa_HistAboBeep.nom_apellido2%TYPE,
                        v_cod_credmor out Fa_HistAboBeep.cod_credmor%TYPE,
                        v_fec_fincontra out Fa_HistAboBeep.fec_fincontra%TYPE)
                        is
  Begin
    /*dbms_output.put_line('Abonado ='||to_char(v_num_abonado));
    dbms_output.put_line('ProdBeeper ='||to_char(v_prod_beeper));
    dbms_output.put_line('Cliente ='||to_char(v_cod_cliente));*/
    Select a.cod_credmor,a.fec_fincontra,b.nom_usuario,
           b.nom_apellido1,b.nom_apellido2
    Into   v_cod_credmor,v_fec_fincontra,v_nom_usuario,
           v_nom_apellido1,v_nom_apellido2
    From Ga_AboBeep a, Ga_Usuarios b
    Where a.num_abonado = v_num_abonado
    And   a.cod_producto = v_prod_beeper
    And   a.cod_cliente  = v_cod_cliente
    And   a.cod_usuario  = b.cod_usuario;
  exception
    when too_many_rows then
         raise_application_error (-20510, 'Demasiadas filas GETDESABOBEEP');
    when no_data_found then
         raise_application_error
                         (-20510, 'No hay dato en GA_USUARIOS o GA_ABOBEEP');
    when others then
         raise_application_error (-20510,SQLERRM);
  End p_getdesabobeep;
  Procedure p_getdesabotrek(v_cod_cliente in Fa_HistDocu.Cod_Cliente%TYPE,
                        v_num_abonado in Fa_Presupuesto.Num_Abonado%TYPE,
                        v_prod_trek in Ge_DatosGener.Prod_Trek%TYPE,
                        v_nom_usuario out Fa_HistAboTrek.nom_usuario%TYPE,
                        v_nom_apellido1 out Fa_HistAboTrek.nom_apellido1%TYPE,
                        v_nom_apellido2 out Fa_HistAboTrek.nom_apellido2%TYPE,
                        v_cod_credmor out Fa_HistAboTrek.cod_credmor%TYPE,
                        v_fec_fincontra out Fa_HistAboTrek.fec_fincontra%TYPE)
                        is
  Begin
    /*dbms_output.put_line('Abonado ='||to_char(v_num_abonado));
    dbms_output.put_line('ProdTrek ='||to_char(v_prod_trek));
    dbms_output.put_line('Cliente ='||to_char(v_cod_cliente));*/
    Select a.cod_credmor,a.fec_fincontra,b.nom_usuario,
           b.nom_apellido1,b.nom_apellido2
    Into   v_cod_credmor,v_fec_fincontra,v_nom_usuario,
           v_nom_apellido1,v_nom_apellido2
    From Ga_AboTrek a, Ga_Usuarios b
    Where a.num_abonado  = v_num_abonado
    And   a.cod_producto = v_prod_trek
    And   a.cod_cliente  = v_cod_cliente
    And   a.cod_usuario  = b.cod_usuario;
  exception
    when too_many_rows then
         raise_application_error (-20511,'Demasiadas filas GETDESABOTREK');
    when no_data_found then
         raise_application_error
                        (-20511,'No hay dato en GA_ABOTREK o GA_USUARIOS');
    when others then
         raise_application_error (-20511,SQLERRM);
  End p_getdesabotrek;
/*
  Procedure p_getdesabotrunk(v_cod_cliente in Fa_Presupuesto.cod_cliente%TYPE,
			    v_cod_usuario in Fa_Presupuesto.cod_usuario%TYPE,
                            v_cod_ciclfact in Fa_Presupuesto.cod_ciclfact%TYPE,
		      v_fec_desdecfijos in out Fa_CiclFact.fec_desdecfijos%TYPE,
			    v_des_abonado out Fa_HistAboTrunk.des_Abonado%TYPE,
			 v_nom_apellido1 out Fa_HistAboTrunk.nom_apellido1%TYPE,
			 v_nom_apellido2 out Fa_HistAboTrunk.nom_apellido2%TYPE,
		      v_fec_fincontra out Fa_HistAboTrunk.fec_fincontra%TYPE,
			    v_cod_detfact out Fa_HistAboTrunk.cod_detfact%TYPE,
			    v_ind_factur out Fa_HistAboTrunk.ind_factur%TYPE) is
  Begin
    Select nom_usuario,nom_apellido1,nom_apellido2
    Into v_des_abonado,v_nom_apellido1,v_nom_apellido2
    From Ga_Usuarios
    Where cod_usuario = v_cod_usuario;
    if v_cod_ciclfact is null then
       Select fec_fincontra,ind_detalle,ind_factur
       Into   v_fec_fincontra,v_cod_detfact,v_ind_factur
       From Ga_Interfact
       Where cod_usuario = v_cod_usuario
       And fec_desde < SYSDATE
       And fec_hasta > SYSDATE;
    else
       Select fec_desdecfijos
       Into v_fec_desdecfijos
       From Fa_CiclFact
       Where cod_ciclfact = v_cod_ciclfact;
       Select fec_fincontra,ind_detalle,ind_factur
       Into   v_fec_fincontra,v_cod_detfact,v_ind_factur
       From Ga_Interfact
       Where cod_usuario = v_cod_usuario
       And cod_cliente = v_cod_cliente
       And fec_desde = (select max(fec_desde) from Ga_Interfact
			Where cod_cliente = v_cod_cliente
			And cod_usuario = v_cod_usuario
			And fec_desde < v_fec_desdecfijos);
    end if;
  exception
    when too_many_rows then
         raise_application_error (-20512, 'Demasiadas filas GETDESABOTRUNK');
    when no_data_found then
         raise_application_error (-20512, 'No hay dato en GA_INTERFACT');
    when others then
         raise_application_error (-20512,SQLERRM);
  End p_getdesabotrunk;
*/
  Procedure p_getdatoclie (rec_histclie in out Fa_HistClie%ROWTYPE,
                           v_cliente in Fa_HistClie.Cod_Cliente%TYPE) is
  v_comuna Ge_Comunas.cod_comuna%TYPE;
  v_ciudad Ge_Ciudades.cod_ciudad%TYPE;
  v_region Ge_Regiones.cod_region%TYPE;
  v_provin Ge_Provincias.cod_provincia%TYPE;
  v_actividad Ge_Actividades.cod_actividad%TYPE;
  Begin
    /*dbms_output.put_line('Antes del Select en DATOCLIE');
    dbms_output.put_line('Cliente ='||to_char(rec_histclie.cod_cliente));*/
    Select b.nom_calle,b.num_calle,b.num_piso,b.cod_region,b.cod_provincia,
           b.cod_ciudad,b.cod_comuna,c.cod_actividad,c.nom_cliente,
           c.cod_pais,c.tef_cliente1,c.tef_cliente2,c.ind_debito,
           c.nom_apeclien1,c.nom_apeclien2,c.imp_stopdebit,c.cod_banco,
           c.cod_sucursal,c.ind_tipcuenta,c.cod_tiptarjeta,c.num_ctacorr,
           c.num_tarjeta,c.fec_vencitarj,c.cod_bancotarj,c.cod_tipidtrib,
           c.num_identtrib,c.num_fax
    Into   rec_histclie.nom_calle,rec_histclie.num_calle,rec_histclie.num_piso,
           v_region,v_provin,v_ciudad,v_comuna,v_actividad,
           rec_histclie.nom_cliente,rec_histclie.cod_pais,
	   rec_histclie.tef_cliente1,rec_histclie.tef_cliente2,
	   rec_histclie.ind_debito,rec_histclie.nom_apeclien1,
	   rec_histclie.nom_apeclien2,
	   rec_histclie.imp_stopdebit,rec_histclie.cod_banco,
	   rec_histclie.cod_sucursal,rec_histclie.ind_tipcuenta,
	   rec_histclie.cod_tiptarjeta,rec_histclie.num_ctacorr,
	   rec_histclie.num_tarjeta,rec_histclie.fec_vencitarj,
	   rec_histclie.cod_bancotarj,rec_histclie.cod_tipidtrib,
	   rec_histclie.num_identtrib,rec_histclie.num_fax
    From  Ga_Direccli a,Ge_Direcciones b,Ge_Clientes c
    Where a.cod_cliente      = rec_histclie.cod_cliente
    And   c.cod_cliente      = rec_histclie.cod_cliente
    And   a.cod_tipdireccion = 1
    And   a.cod_direccion    = b.cod_direccion;
    /*dbms_output.put_line('Despues del Select en DATOCLIE');
    dbms_output.put_line('Cliente ='||to_char(rec_histclie.cod_cliente));
    dbms_output.put_line('FIN DATOCLIE');*/
    if v_actividad is not null then
       fa_comp_get_presu.p_getdesactividad(v_actividad,
                                           rec_histclie.des_actividad);
    end if;
    fa_comp_get_presu.p_getdescomuna(v_region,v_provin,v_comuna,
                                     rec_histclie.des_comuna);
    fa_comp_get_presu.p_getdesciudad(v_region,v_provin,v_ciudad,
                                     rec_histclie.des_ciudad);
  exception
    when no_data_found then
         raise_application_error (-20513,'No hay dato en GE_CLIENTES');
    when too_many_rows then
         raise_application_error (-20513,'Demasiados datos en GE_CLIENTES');
    when others then
         raise_application_error (-20513,SQLERRM);
  End p_getdatoclie;
  Procedure p_getdatoproc (v_rec_proceso in out Fa_Procesos%ROWTYPE) is
  Begin
    Select /*+ index (FA_PROCESOS PK_FA_PROCESOS) */
           * Into  v_rec_proceso
    From Fa_Procesos
    Where num_proceso = v_rec_proceso.num_proceso;
  exception
    when too_many_rows then
         raise_application_error (-20514, 'Demasiadas filas GETDATOPROC');
    when no_data_found then
         raise_application_error (-20514,
              'No hay datos en Fa_Procesos para el proceso = '
         || to_char(v_rec_proceso.num_proceso));
    when others then
         raise_application_error (-20514,SQLERRM);
  End p_getdatoproc;
  Procedure p_getfadatosgener (v_fa_datosgener out Fa_DatosGener%ROWTYPE) is
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
  Procedure p_updateproc (v_num_proceso in Fa_Procesos.num_proceso%TYPE,
		          v_letra in Fa_HistDocu.letra%TYPE,
	                  v_num_secuenci in Fa_HistDocu.num_secuenci%TYPE) is
  Begin
    Update Fa_Procesos set letraag    = v_letra,
  	                   num_secuag = v_num_secuenci
    Where num_proceso = v_num_proceso;
  exception
    when others then
         raise_application_error (-20516,SQLERRM);
  End p_updateproc;
  Procedure p_getfecemision (v_cod_ciclfact in Fa_HistDocu.cod_ciclfact%TYPE,
			     v_fec_emision out Fa_CiclFact.fec_emision%TYPE) is
  Begin
    Select fec_emision into v_fec_emision
    From Fa_CiclFact
    Where cod_ciclfact = v_cod_ciclfact;
  exception
    when others then
         raise_application_error (-20517,SQLERRM);
  End p_getfecemision;
  Procedure p_getgedatosgener (v_ge_datosgener out Ge_DatosGener%ROWTYPE) is
  Begin
    Select *
    Into   v_ge_datosgener
    From Ge_DatosGener;
  exception
    when no_data_found then
         raise_application_error (-20518,'no existen datos en GE_DATOSGENER');
    when too_many_rows then
         raise_application_error (-20518, 'Demasiadas filas en GE_DATOSGENER');
    when others then
         raise_application_error (-20518,SQLERRM);
  End p_getgedatosgener;
  Procedure p_getordentotal(
                    v_ind_ordentotal in out Fa_HistDocu.ind_ordentotal%TYPE) is
  Begin
    Select fa_seq_ind_ordentotal.nextval Into v_ind_ordentotal
    From Dual;
  exception
    when others then
         raise_application_error (-20519,SQLERRM);
  End p_getordentotal;
  Procedure p_getimpsaldoant (v_cod_cliente in Fa_HistDocu.cod_cliente%TYPE,
			   v_imp_saldoant out Fa_HistDocu.imp_saldoant%TYPE) is
  Begin
    Select nvl(sum(importe_debe - importe_haber),0)
    Into v_imp_saldoant
    From Co_Cartera
    Where cod_cliente = v_cod_cliente;
  exception
     when others then
          raise_application_error (-20520,'P_IMPSALDOANT '||SQLERRM);
  End p_getimpsaldoant;
  Procedure p_getcambio (v_fec_valor in Fa_HistConcCelu.fec_valor%TYPE,
                         v_cod_monedaorig in Fa_HistConcCelu.Cod_Moneda%TYPE,
                         v_cod_monedadest in Fa_DatosGener.Cod_MoneFact%TYPE,
                         v_imp_concepto in Fa_HistConcCelu.Imp_Concepto%TYPE,
                         v_num_unidades in Fa_HistConcCelu.Num_Unidades%TYPE,
                     v_imp_facturable out Fa_HistConcCelu.Imp_Facturable%TYPE)
                         is
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
                          (round(v_imp_concepto,2) * (v_cambiorig/v_cambiodes));
    else
       v_imp_facturable := round(v_imp_concepto,2) * (v_cambiorig/v_cambiodes);
    end if;
  exception
    when no_data_found then
         raise_application_error (-20521,'no existen datos en GE_CONVERSION');
    when too_many_rows then
         raise_application_error (-20521, 'Demasiadas filas en GE_CONVERSION');
    when others then
         raise_application_error (-20521,SQLERRM);
  End p_getcambio;
  Procedure p_getdatoclie2 (rec_histclie in out Fa_HistClie%ROWTYPE,
                            v_cliente in Fa_HistClie.Cod_Cliente%TYPE) is
  v_comuna Ge_Comunas.cod_comuna%TYPE;
  v_ciudad Ge_Ciudades.cod_ciudad%TYPE;
  v_region Ge_Regiones.cod_region%TYPE;
  v_provin Ge_Provincias.cod_provincia%TYPE;
  v_actividad Ge_Actividades.cod_actividad%TYPE;
  Begin
    Select b.nom_calle,b.num_calle,b.num_piso,b.cod_region,b.cod_provincia,
           b.cod_ciudad,b.cod_comuna,c.cod_actividad
    Into   rec_histclie.nom_calle,rec_histclie.num_calle,rec_histclie.num_piso,
           v_region,v_provin,v_ciudad,v_comuna,v_actividad
    From   Ga_Direccli a,Ge_Direcciones b,Ge_Clientes c
    Where a.cod_cliente      = rec_histclie.cod_cliente
    And   c.cod_cliente      = rec_histclie.cod_cliente
    And   a.cod_tipdireccion = 1
    And   a.cod_direccion    = b.cod_direccion;
    if v_actividad is not null then
       fa_comp_get_presu.p_getdesactividad(v_actividad,rec_histclie.des_actividad);
    end if;
    fa_comp_get_presu.p_getdescomuna(v_region,v_provin,v_comuna,rec_histclie.des_comuna);
    fa_comp_get_presu.p_getdesciudad(v_region,v_provin,v_ciudad,rec_histclie.des_ciudad);
  exception
    when no_data_found then
         raise_application_error (-20522,
                           'No hay dato en GA_DIRECCLI o GE_DIRECCIONES');
    when too_many_rows then
         raise_application_error (-20522,
                'Demasiados datos en GA_DIRECCLI o GE_DIRECCIONES');
    when others then
         raise_application_error (-20522,SQLERRM);
  End p_getdatoclie2;
  Procedure p_getdesactividad(v_actividad in Ge_Actividades.cod_actividad%TYPE,
                            v_des_actividad out Fa_HistClie.Des_Actividad%TYPE)
                            is
  Begin
    Select des_actividad Into v_des_actividad
    From Ge_Actividades
    Where cod_actividad = v_actividad;
  exception
    when no_data_found then
         raise_application_error (-20523,'No hay dato en GE_ACTIVIDADES');
    when too_many_rows then
         raise_application_error (-20523,'Demasiados datos en GE_ACTIVIDADES');
    when others then
         raise_application_error (-20523,SQLERRM);
  End p_getdesactividad;
  Procedure p_getdescomuna(v_region in Ge_Regiones.cod_region%TYPE,
                           v_provin in Ge_Provincias.cod_provincia%TYPE,
                           v_comuna in Ge_Comunas.cod_comuna%TYPE,
                           v_des_comuna out Fa_HistClie.des_comuna%TYPE) is
  Begin
    Select des_comuna Into v_des_comuna
    From Ge_Comunas
    Where cod_region    = v_region
    And   cod_provincia = v_provin
    And   cod_comuna    = v_comuna;
  exception
    when no_data_found then
         raise_application_error (-20524,'No hay dato en GE_COMUNAS');
    when too_many_rows then
         raise_application_error (-20524,'Demasiados datos en GE_COMUNAS');
    when others then
         raise_application_error (-20524,SQLERRM);
  End p_getdescomuna;
  Procedure p_getdesciudad(v_region in Ge_Regiones.cod_region%TYPE,
                           v_provin in Ge_Provincias.cod_provincia%TYPE,
                           v_ciudad in Ge_Ciudades.cod_ciudad%TYPE,
                           v_des_ciudad out Fa_HistClie.des_ciudad%TYPE) is
  Begin
    Select des_ciudad Into v_des_ciudad
    From Ge_Ciudades
    Where cod_region    = v_region
    And   cod_provincia = v_provin
    And   cod_ciudad    = v_ciudad;
  exception
    when no_data_found then
         raise_application_error (-20525,'No hay dato en GE_CIUDADES');
    when too_many_rows then
         raise_application_error (-20525,'Demasiados datos en GE_CIUDADES');
    when others then
         raise_application_error (-20525,SQLERRM);
  End p_getdesciudad;
  Procedure p_updventa (v_tot_cargosme in Fa_HistDocu.Tot_CargosMe%TYPE,
                        v_num_venta in Ga_Ventas.Num_Venta%TYPE,
                        v_num_transaccion in Ga_Ventas.Num_Transaccion%TYPE,
                        v_monefact in Fa_DatosGener.Cod_MoneFact%TYPE) is
  Begin
    if v_num_venta is not null and v_num_venta != 0 then
       Update Ga_Ventas set imp_venta  = v_tot_cargosme,
                            cod_moneda = v_monefact
       Where  num_venta       = v_num_venta
       And    num_transaccion = v_num_transaccion;
    else
       Update Ga_TransContado set imp_venta  = v_tot_cargosme,
                                  cod_moneda = v_monefact
       Where  num_transaccion = v_num_transaccion;
    end if;
  exception
    when no_data_found then
         raise_application_error (-20526,'No hay dato en GA_VENTAS');
    when others then
         raise_application_error (-20526,SQLERRM);
  End p_updventa;
  Procedure p_getdesconcepto (v_cod_concepto in Fa_Conceptos.Cod_Concepto%TYPE,
			     v_des_concepto out Fa_Conceptos.Des_Concepto%TYPE)
                             is
  Begin
    Select des_concepto into v_des_concepto
    From Fa_Conceptos
    Where cod_concepto = v_cod_concepto;
  End p_getdesconcepto;
  Procedure p_getdeletecargos (v_num_proceso in Fa_Procesos.Num_Proceso%TYPE)
                              is
  Begin
    Delete Ge_Cargos
    where num_factura = v_num_proceso;
    Delete Fa_Presupuesto
    Where num_proceso = v_num_proceso;
    /*Delete Fa_Procesos
    Where num_proceso = v_num_proceso;*/
  End p_getdeletecargos;
  Procedure p_getmuevecargos (v_num_proceso in Fa_Procesos.Num_Proceso%TYPE) is
  Begin
    Insert into Fa_HistCargos
          (num_cargo,cod_cliente,cod_concepto,cod_producto,fec_alta,
           imp_cargo,cod_moneda,cod_plancom,num_unidades,ind_factur,
           num_transaccion,num_proceso,num_venta,cod_ciclfact,num_abonado,
           num_seriemec,num_serie,cap_code,mes_garantia,num_preguia,
           num_guia,cod_concepto_dto,val_dto,tip_dto,ind_cuota,ind_supertel,
           num_paquete,num_terminal)
    Select num_cargo,cod_cliente,cod_concepto,cod_producto,fec_alta,
           imp_cargo,cod_moneda,cod_plancom,num_unidades,ind_factur,
           num_transaccion,num_factura,num_venta,cod_ciclfact,num_abonado,
           num_seriemec,num_serie,cap_code,mes_garantia,num_preguia,
           num_guia,cod_concepto_dto,val_dto,tip_dto,ind_cuota,ind_supertel,
           num_paquete,num_terminal
    From Ge_Cargos
    Where num_factura = v_num_proceso;
  End p_getmuevecargos;
  Procedure p_getacumulado (vind_ordentotal in out
                                            Fa_HistDocu.Ind_OrdenTotal%TYPE,
                            vrec_ge_datosgener in out Ge_DatosGener%ROWTYPE,
                            v_proceso in out Fa_Procesos.Num_Proceso%TYPE,
                            v_cliente in out Ge_Clientes.Cod_Cliente%TYPE) is
  rec_acumuloprod  Fa_AcumuloProd%ROWTYPE;
  rec_acumulocelu  Fa_AcumuloProd%ROWTYPE;
  rec_acumulobeep  Fa_AcumuloProd%ROWTYPE;
  rec_acumulotrek  Fa_AcumuloProd%ROWTYPE;
  rec_acumulotrun  Fa_AcumuloProd%ROWTYPE;
  rec_acumulogene  Fa_AcumuloProd%ROWTYPE;
  vimp_facturable  Fa_Presupuesto.Imp_Facturable%TYPE;
  vcod_tipconce    Fa_Presupuesto.Cod_Tipconce%TYPE;
  vcod_producto    Fa_Presupuesto.Cod_Producto%TYPE;
  vnum_unidades    Fa_Presupuesto.Num_Unidades%TYPE;
  Cursor Cur_Acumulado is
         Select sum(imp_facturable*num_unidades),cod_tipconce,cod_producto
         From Fa_Presupuesto
         Where num_proceso = v_proceso
         And   cod_cliente = v_cliente
         Group by cod_tipconce,cod_producto;
  Begin
    rec_acumulocelu.tot_producto := 0; rec_acumulocelu.acum_cargo := 0;
    rec_acumulocelu.acum_dto     := 0; rec_acumulocelu.acum_iva   := 0;
    rec_acumulobeep.tot_producto := 0; rec_acumulobeep.acum_cargo := 0;
    rec_acumulobeep.acum_dto     := 0; rec_acumulobeep.acum_iva   := 0;
    rec_acumulotrek.tot_producto := 0; rec_acumulotrek.acum_cargo := 0;
    rec_acumulotrek.acum_dto     := 0; rec_acumulotrek.acum_iva   := 0;
    rec_acumulotrun.tot_producto := 0; rec_acumulotrun.acum_cargo := 0;
    rec_acumulotrun.acum_dto     := 0; rec_acumulotrun.acum_iva   := 0;
    rec_acumulogene.tot_producto := 0; rec_acumulogene.acum_cargo := 0;
    rec_acumulogene.acum_dto     := 0; rec_acumulogene.acum_iva   := 0;
    Open Cur_Acumulado;
    Loop
      Fetch Cur_Acumulado
      Into vimp_facturable,vcod_tipconce,vcod_producto;
      Exit When Cur_Acumulado%NOTFOUND;
      if vcod_producto = vrec_ge_datosgener.prod_celular then
         if vcod_tipconce >= 3 then
            rec_acumulocelu.acum_cargo  := rec_acumulocelu.acum_cargo +
                                           vimp_facturable;
         elsif vcod_tipconce = 2 then
               rec_acumulocelu.acum_dto := rec_acumulocelu.acum_dto +
                                           vimp_facturable;
         elsif vcod_tipconce = 1 then
               rec_acumulocelu.acum_iva := rec_acumulocelu.acum_iva +
                                           vimp_facturable;
         end if;
         rec_acumulocelu.tot_producto   := rec_acumulocelu.tot_producto +
                                           vimp_facturable;
      elsif vcod_producto = vrec_ge_datosgener.prod_beeper then
            if vcod_tipconce >= 3 then
               rec_acumulobeep.acum_cargo  := rec_acumulobeep.acum_cargo +
                                             vimp_facturable;
            elsif vcod_tipconce = 2 then
                  rec_acumulobeep.acum_dto := rec_acumulobeep.acum_dto +
                                              vimp_facturable;
            elsif vcod_tipconce = 1 then
                  rec_acumulobeep.acum_iva := rec_acumulobeep.acum_iva +
                                              vimp_facturable;
            end if;
            rec_acumulobeep.tot_producto   := rec_acumulobeep.tot_producto +
                                              vimp_facturable;
      elsif vcod_producto = vrec_ge_datosgener.prod_trek then
            if vcod_tipconce >= 3 then
               rec_acumulotrek.acum_cargo  := rec_acumulotrek.acum_cargo +
                                              vimp_facturable;
            elsif vcod_tipconce = 2 then
                  rec_acumulotrek.acum_dto := rec_acumulotrek.acum_dto +
                                              vimp_facturable;
            elsif vcod_tipconce = 1 then
                  rec_acumulotrek.acum_iva := rec_acumulotrek.acum_iva +
                                              vimp_facturable;
            end if;
            rec_acumulotrek.tot_producto   := rec_acumulotrek.tot_producto +
                                              vimp_facturable;
      elsif vcod_producto = vrec_ge_datosgener.prod_trunk then
            if vcod_tipconce >= 3 then
               rec_acumulotrun.acum_cargo  := rec_acumulotrun.acum_cargo +
                                              vimp_facturable;
            elsif vcod_tipconce = 2 then
                  rec_acumulotrun.acum_dto := rec_acumulotrun.acum_dto +
                                              vimp_facturable;
            elsif vcod_tipconce = 1 then
                  rec_acumulotrun.acum_iva := rec_acumulotrun.acum_iva +
                                              vimp_facturable;
            end if;
            rec_acumulotrun.tot_producto   := rec_acumulotrun.tot_producto +
                                              vimp_facturable;
      elsif vcod_producto = vrec_ge_datosgener.prod_general then
            if vcod_tipconce >= 3 then
               rec_acumulogene.acum_cargo  := rec_acumulogene.acum_cargo +
                                              vimp_facturable;
            elsif vcod_tipconce = 2 then
                  rec_acumulogene.acum_dto := rec_acumulogene.acum_dto +
                                              vimp_facturable;
            elsif vcod_tipconce = 1 then
                  rec_acumulogene.acum_iva := rec_acumulogene.acum_iva +
                                              vimp_facturable;
            end if;
            rec_acumulogene.tot_producto   := rec_acumulogene.tot_producto +
                                              vimp_facturable;
      end if;
    End Loop;
    Close Cur_Acumulado;
    if rec_acumulocelu.tot_producto > 0 then
       Select /*+ FULL (FA_DESACUMULADO) */
            des_totalprod,des_acumcargo,des_acumdto,des_acumiva
       into rec_acumulocelu.des_totalprod,rec_acumulocelu.des_acumcargo,
            rec_acumulocelu.des_acumdto,rec_acumulocelu.des_acumiva
       From Fa_DesAcumulado
       Where cod_producto = vrec_ge_datosgener.prod_celular;
       rec_acumulocelu.cod_producto := vrec_ge_datosgener.prod_celular;
       rec_acumulocelu.ind_ordentotal := vind_ordentotal;
       fa_comp_get_presu.p_getinsertacum(rec_acumulocelu);
    end if;
    if rec_acumulobeep.tot_producto > 0 then
       Select /*+ FULL (FA_DESACUMULADO) */
            des_totalprod,des_acumcargo,des_acumdto,des_acumiva
       into rec_acumulobeep.des_totalprod,rec_acumulobeep.des_acumcargo,
            rec_acumulobeep.des_acumdto,rec_acumulobeep.des_acumiva
       From Fa_DesAcumulado
       Where cod_producto = vrec_ge_datosgener.prod_beeper;
       rec_acumulobeep.cod_producto := vrec_ge_datosgener.prod_beeper;
       rec_acumulobeep.ind_ordentotal := vind_ordentotal;
       fa_comp_get_presu.p_getinsertacum(rec_acumulobeep);
    end if;
    if rec_acumulotrek.tot_producto > 0 then
       Select /*+ FULL (FA_DESACUMULADO) */
              des_totalprod,des_acumcargo,des_acumdto,des_acumiva
       into rec_acumulotrek.des_totalprod,rec_acumulotrek.des_acumcargo,
            rec_acumulotrek.des_acumdto,rec_acumulotrek.des_acumiva
       From Fa_DesAcumulado
       Where cod_producto = vrec_ge_datosgener.prod_trek;
       rec_acumulotrek.cod_producto := vrec_ge_datosgener.prod_trek;
       rec_acumulotrek.ind_ordentotal := vind_ordentotal;
       fa_comp_get_presu.p_getinsertacum(rec_acumulotrek);
    end if;
    if rec_acumulotrun.tot_producto > 0 then
       Select /*+ FULL (FA_DESACUMULADO) */
              des_totalprod,des_acumcargo,des_acumdto,des_acumiva
       into rec_acumulotrun.des_totalprod,rec_acumulotrun.des_acumcargo,
            rec_acumulotrun.des_acumdto,rec_acumulotrun.des_acumiva
       From Fa_DesAcumulado
       Where cod_producto = vrec_ge_datosgener.prod_trunk;
       rec_acumulotrun.cod_producto := vrec_ge_datosgener.prod_trunk;
       rec_acumulotrun.ind_ordentotal := vind_ordentotal;
       fa_comp_get_presu.p_getinsertacum(rec_acumulotrun);
    end if;
    if rec_acumulogene.tot_producto > 0 then
       Select /*+ FULL (FA_DESACUMULADO) */
              des_totalprod,des_acumcargo,des_acumdto,des_acumiva
       into rec_acumulogene.des_totalprod,rec_acumulogene.des_acumcargo,
            rec_acumulogene.des_acumdto,rec_acumulogene.des_acumiva
       From Fa_DesAcumulado
       Where cod_producto = vrec_ge_datosgener.prod_general;
       rec_acumulogene.cod_producto := vrec_ge_datosgener.prod_general;
       rec_acumulogene.ind_ordentotal := vind_ordentotal;
       fa_comp_get_presu.p_getinsertacum(rec_acumulogene);
    end if;
  End p_getacumulado;
  Procedure p_getinsertacum(rec_acumuloprod in Fa_AcumuloProd%ROWTYPE) is
  Begin
    Insert into Fa_AcumuloProd
          (cod_producto,ind_ordentotal,tot_producto,des_totalprod,acum_cargo,
           des_acumcargo,acum_dto,des_acumdto,acum_iva,des_acumiva)
    Values (rec_acumuloprod.cod_producto,rec_acumuloprod.ind_ordentotal,
            rec_acumuloprod.tot_producto,rec_acumuloprod.des_totalprod,
            rec_acumuloprod.acum_cargo,rec_acumuloprod.des_acumcargo,
            rec_acumuloprod.acum_dto,rec_acumuloprod.des_acumdto,
            rec_acumuloprod.acum_iva,rec_acumuloprod.des_acumiva);
  End p_getinsertacum;
end fa_comp_get_presu;
/
SHOW ERRORS
