CREATE OR REPLACE PACKAGE BODY        fa_comp_conc_presu is
  Procedure p_concepto(v_rec_histdocu in out Fa_HistDocu%ROWTYPE,
		       v_rec_presupuesto in out Fa_Presupuesto%ROWTYPE,
		       v_rec_histconccelu in out Fa_HistConcCelu%ROWTYPE,
                       v_rec_datosgener in Ge_DatosGener%ROWTYPE,
                       v_cod_monefact in out Fa_DatosGener.Cod_MoneFact%TYPE)
                       is
  Begin
    fa_comp_conc_presu.p_buildconc(v_rec_histdocu,v_rec_presupuesto,
                                   v_rec_histconccelu,v_cod_monefact);
    if v_rec_histconccelu.cod_producto = v_rec_datosgener.prod_celular then
       fa_comp_conc_presu.p_insertcelu(v_rec_histconccelu);
    elsif v_rec_histconccelu.cod_producto = v_rec_datosgener.prod_beeper then
          fa_comp_conc_presu.p_insertbeep(v_rec_histconccelu);
    elsif v_rec_histconccelu.cod_producto = v_rec_datosgener.prod_trek then
          fa_comp_conc_presu.p_inserttrek(v_rec_histconccelu);
    elsif v_rec_histconccelu.cod_producto = v_rec_datosgener.prod_trunk then
          fa_comp_conc_presu.p_inserttrunk(v_rec_histconccelu);
    elsif v_rec_histconccelu.cod_producto = v_rec_datosgener.prod_general then
          fa_comp_conc_presu.p_insertgene(v_rec_histconccelu);
    else
        raise_application_error (-20700,'Error en codigo de producto');
    end if;
  End p_concepto;
  Procedure p_buildconc (v_rec_histdocu in Fa_HistDocu%ROWTYPE,
			 v_rec_presupuesto in Fa_Presupuesto%ROWTYPE,
			 v_rec_histconccelu out Fa_HistConcCelu%ROWTYPE,
                         v_cod_monefact in Fa_DatosGener.Cod_MoneFact%TYPE) is
  vdes_concepto Fa_Conceptos.Des_Concepto%TYPE;
  Begin
    v_rec_histconccelu.ind_ordentotal  := v_rec_histdocu.ind_ordentotal;
    v_rec_histconccelu.cod_concepto    := v_rec_presupuesto.cod_concepto;
    fa_comp_get_presu.p_getdesconcepto (v_rec_presupuesto.cod_concepto,
                                        vdes_concepto);
    v_rec_histconccelu.des_concepto    := vdes_concepto;
    v_rec_histconccelu.cod_moneda      := v_rec_presupuesto.cod_moneda;
    v_rec_histconccelu.cod_producto    := v_rec_presupuesto.cod_producto;
    v_rec_histconccelu.cod_tipconce    := v_rec_presupuesto.cod_tipconce;
    v_rec_histconccelu.fec_valor       := v_rec_presupuesto.fec_valor;
    v_rec_histconccelu.fec_efectividad := v_rec_presupuesto.fec_efectividad;
    v_rec_histconccelu.imp_concepto    := v_rec_presupuesto.imp_concepto;
    v_rec_histconccelu.cod_region      := v_rec_presupuesto.cod_region;
    v_rec_histconccelu.cod_provincia   := v_rec_presupuesto.cod_provincia;
    v_rec_histconccelu.cod_ciudad      := v_rec_presupuesto.cod_ciudad;
    v_rec_histconccelu.imp_montobase   := v_rec_presupuesto.imp_montobase;
    v_rec_histconccelu.ind_factur      := v_rec_presupuesto.ind_factur;
    -- if v_rec_presupuesto.cod_moneda != v_cod_monefact then
    --    fa_comp_get_presu.p_getcambio(v_rec_presupuesto.fec_valor,
    --                            v_rec_presupuesto.cod_moneda,v_cod_monefact,
    --                            v_rec_presupuesto.imp_concepto,
    --                            v_rec_presupuesto.num_unidades,
    --                            v_rec_histconccelu.imp_facturable);
    --  else
    if v_rec_presupuesto.cod_tipconce >= 3 then
       v_rec_histconccelu.imp_facturable  := v_rec_presupuesto.imp_facturable
                                             * v_rec_presupuesto.num_unidades;
    else
       v_rec_histconccelu.imp_facturable  := v_rec_presupuesto.imp_facturable;
    end if;
    v_rec_histconccelu.ind_supertel    := v_rec_presupuesto.ind_supertel;
    v_rec_histconccelu.cod_portador    := nvl(v_rec_presupuesto.cod_portador,0);
    v_rec_histconccelu.num_unidades    := v_rec_presupuesto.num_unidades;
    v_rec_histconccelu.num_abonado     := nvl(v_rec_presupuesto.num_abonado,0);
    v_rec_histconccelu.num_seriemec    := v_rec_presupuesto.num_seriemec;
    v_rec_histconccelu.num_seriele     := v_rec_presupuesto.num_seriele;
    v_rec_histconccelu.prc_impuesto    := v_rec_presupuesto.prc_impuesto;
    v_rec_histconccelu.val_dto         := v_rec_presupuesto.val_dto;
    v_rec_histconccelu.tip_dto         := v_rec_presupuesto.tip_dto;
    v_rec_histconccelu.mes_garantia    := v_rec_presupuesto.mes_garantia;
    v_rec_histconccelu.num_guia        := v_rec_presupuesto.num_guia;
    v_rec_histconccelu.num_paquete     := v_rec_presupuesto.num_paquete;
    v_rec_histconccelu.ind_alta        := v_rec_presupuesto.ind_alta;
    v_rec_histconccelu.flag_impues     := v_rec_presupuesto.flag_impues;
    v_rec_histconccelu.flag_dto        := v_rec_presupuesto.flag_dto;
    v_rec_histconccelu.cod_concerel    := v_rec_presupuesto.cod_concerel;
    v_rec_histconccelu.columna_rel     := v_rec_presupuesto.columna_rel;
    v_rec_histconccelu.num_cuotas      := v_rec_presupuesto.num_cuotas;
    v_rec_histconccelu.ord_cuota       := v_rec_presupuesto.ord_cuota;
    v_rec_histconccelu.seq_cuotas      := null;
  End p_buildconc;
  Procedure p_insertcelu (v_rec_histconccelu in Fa_HistConcCelu%ROWTYPE) is
  Begin
   /* dbms_output.put_line('CONCEPTOS INSERT CELULAR');
    dbms_output.put_line('OrdenTotal ='||
                         to_char(v_rec_histconccelu.ind_ordentotal));
    dbms_output.put_line('CodConcepto ='||
                          to_char(v_rec_histconccelu.cod_concepto));
    dbms_output.put_line('Moneda ='||v_rec_histconccelu.cod_moneda);
   dbms_output.put_line('Producto ='||to_char(v_rec_histconccelu.cod_producto));
   dbms_output.put_line('TipConce ='||to_char(v_rec_histconccelu.cod_tipconce));
   dbms_output.put_line('FecValor ='||
                          to_char(v_rec_histconccelu.fec_valor,'dd-mm-yyyy'));
   dbms_output.put_line('Fec_Efectividad ='||
                      to_char(v_rec_histconccelu.fec_efectividad,'dd-mm-yyyy'));
   dbms_output.put_line('Importe ='||to_char(v_rec_histconccelu.imp_concepto));
   dbms_output.put_line('Region ='||v_rec_histconccelu.cod_region);
   dbms_output.put_line('Provincia ='||v_rec_histconccelu.cod_provincia);
   dbms_output.put_line('Ciudad ='||v_rec_histconccelu.cod_ciudad);
   dbms_output.put_line('MontoBase ='||
                     to_char(v_rec_histconccelu.imp_montobase));
   dbms_output.put_line('IndFactur ='||to_char(v_rec_histconccelu.ind_factur));
   dbms_output.put_line('Facturable ='||
                         to_char(v_rec_histconccelu.imp_facturable));
   dbms_output.put_line('IndSuperTel ='||
                         to_char(v_rec_histconccelu.ind_supertel));
   dbms_output.put_line('Portador ='||
                         to_char(v_rec_histconccelu.cod_portador));
   dbms_output.put_line('Abonado ='||to_char(v_rec_histconccelu.num_abonado));*/
    Insert Into Fa_HistConcCelu
          (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto,
           cod_tipconce,fec_valor,fec_efectividad,imp_concepto,cod_region,
           cod_provincia,cod_ciudad,imp_montobase,ind_factur,imp_facturable,
           ind_supertel,cod_portador,des_concepto,num_unidades,num_abonado,
           num_seriemec,num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
           num_guia,ind_alta,num_paquete,flag_impues,flag_dto,cod_concerel,
           columna_rel,num_cuotas,ord_cuota,seq_cuotas)
    Select v_rec_histconccelu.ind_ordentotal,v_rec_histconccelu.cod_concepto,
           nvl(max(columna+1),1),v_rec_histconccelu.cod_moneda,
           v_rec_histconccelu.cod_producto,v_rec_histconccelu.cod_tipconce,
           v_rec_histconccelu.fec_valor,v_rec_histconccelu.fec_efectividad,
           v_rec_histconccelu.imp_concepto,v_rec_histconccelu.cod_region,
           v_rec_histconccelu.cod_provincia,v_rec_histconccelu.cod_ciudad,
           v_rec_histconccelu.imp_montobase,v_rec_histconccelu.ind_factur,
           v_rec_histconccelu.imp_facturable,v_rec_histconccelu.ind_supertel,
           v_rec_histconccelu.cod_portador,v_rec_histconccelu.des_concepto,
           v_rec_histconccelu.num_unidades,v_rec_histconccelu.num_abonado,
           v_rec_histconccelu.num_seriemec,v_rec_histconccelu.num_seriele,
           v_rec_histconccelu.prc_impuesto,v_rec_histconccelu.val_dto,
           v_rec_histconccelu.tip_dto,v_rec_histconccelu.mes_garantia,
           v_rec_histconccelu.num_guia,v_rec_histconccelu.ind_alta,
           v_rec_histconccelu.num_paquete,v_rec_histconccelu.flag_impues,
           v_rec_histconccelu.flag_dto,v_rec_histconccelu.cod_concerel,
           v_rec_histconccelu.columna_rel,v_rec_histconccelu.num_cuotas,
           v_rec_histconccelu.ord_cuota,v_rec_histconccelu.seq_cuotas
    From Fa_HistConcCelu
    Where ind_ordentotal = v_rec_histconccelu.ind_ordentotal
    And cod_concepto = v_rec_histconccelu.cod_concepto;
   /* dbms_output.put_line('FIN CONCEPTOS INSERT CELULAR');*/
  exception
   when others then
        raise_application_error (-20535,SQLERRM);
  End p_insertcelu;
  Procedure p_insertbeep  (v_rec_histconcbeep in Fa_HistConcBeep%ROWTYPE) is
  Begin
   /* dbms_output.put_line('CONCEPTOS INSERT BEEPER');*/
    Insert Into Fa_HistConcBeep
          (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto,
           cod_tipconce,fec_valor,fec_efectividad,imp_concepto,cod_region,
           cod_provincia,cod_ciudad,imp_montobase,ind_factur,imp_facturable,
           ind_supertel,cod_portador,des_concepto,num_unidades,num_abonado,
           num_seriemec,num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
           num_guia,ind_alta,num_paquete,flag_impues,flag_dto,cod_concerel,
           columna_rel,num_cuotas,ord_cuota,seq_cuotas)
    Select v_rec_histconcbeep.ind_ordentotal,v_rec_histconcbeep.cod_concepto,
           nvl(max(columna+1),1),v_rec_histconcbeep.cod_moneda,
           v_rec_histconcbeep.cod_producto,v_rec_histconcbeep.cod_tipconce,
           v_rec_histconcbeep.fec_valor,v_rec_histconcbeep.fec_efectividad,
           v_rec_histconcbeep.imp_concepto,v_rec_histconcbeep.cod_region,
           v_rec_histconcbeep.cod_provincia,v_rec_histconcbeep.cod_ciudad,
           v_rec_histconcbeep.imp_montobase,v_rec_histconcbeep.ind_factur,
           v_rec_histconcbeep.imp_facturable,v_rec_histconcbeep.ind_supertel,
           v_rec_histconcbeep.cod_portador,v_rec_histconcbeep.des_concepto,
           v_rec_histconcbeep.num_unidades,v_rec_histconcbeep.num_abonado,
           v_rec_histconcbeep.num_seriemec,v_rec_histconcbeep.num_seriele,
           v_rec_histconcbeep.prc_impuesto,v_rec_histconcbeep.val_dto,
           v_rec_histconcbeep.tip_dto,v_rec_histconcbeep.mes_garantia,
           v_rec_histconcbeep.num_guia,v_rec_histconcbeep.ind_alta,
           v_rec_histconcbeep.num_paquete,v_rec_histconcbeep.flag_impues,
           v_rec_histconcbeep.flag_dto,v_rec_histconcbeep.cod_concerel,
           v_rec_histconcbeep.columna_rel,v_rec_histconcbeep.num_cuotas,
           v_rec_histconcbeep.ord_cuota,v_rec_histconcbeep.seq_cuotas
    From Fa_HistConcBeep
    Where ind_ordentotal = v_rec_histconcbeep.ind_ordentotal
    And cod_concepto = v_rec_histconcbeep.cod_concepto;
    /*dbms_output.put_line('FIN CONCEPTOS INSERT BEEPER');*/
  exception
   when others then
        raise_application_error (-20536,SQLERRM);
  End p_insertbeep;
  Procedure p_inserttrek  (v_rec_histconctrek in Fa_HistConcTrek%ROWTYPE) is
  Begin
   /* dbms_output.put_line('CONCEPTOS INSERT TREK');*/
    Insert Into Fa_HistConcTrek
          (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto,
           cod_tipconce,fec_valor,fec_efectividad,imp_concepto,cod_region,
           cod_provincia,cod_ciudad,imp_montobase,ind_factur,imp_facturable,
           ind_supertel,cod_portador,des_concepto,num_unidades,num_abonado,
           num_seriemec,num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
           num_guia,ind_alta,num_paquete,flag_impues,flag_dto,cod_concerel,
           columna_rel,num_cuotas,ord_cuota,seq_cuotas)
    Select v_rec_histconctrek.ind_ordentotal,v_rec_histconctrek.cod_concepto,
           nvl(max(columna+1),1),v_rec_histconctrek.cod_moneda,
           v_rec_histconctrek.cod_producto,v_rec_histconctrek.cod_tipconce,
           v_rec_histconctrek.fec_valor,v_rec_histconctrek.fec_efectividad,
           v_rec_histconctrek.imp_concepto,v_rec_histconctrek.cod_region,
           v_rec_histconctrek.cod_provincia,v_rec_histconctrek.cod_ciudad,
           v_rec_histconctrek.imp_montobase,v_rec_histconctrek.ind_factur,
           v_rec_histconctrek.imp_facturable,v_rec_histconctrek.ind_supertel,
           v_rec_histconctrek.cod_portador,v_rec_histconctrek.des_concepto,
           v_rec_histconctrek.num_unidades,v_rec_histconctrek.num_abonado,
           v_rec_histconctrek.num_seriemec,v_rec_histconctrek.num_seriele,
           v_rec_histconctrek.prc_impuesto,v_rec_histconctrek.val_dto,
           v_rec_histconctrek.tip_dto,v_rec_histconctrek.mes_garantia,
           v_rec_histconctrek.num_guia,v_rec_histconctrek.ind_alta,
           v_rec_histconctrek.num_paquete,v_rec_histconctrek.flag_impues,
           v_rec_histconctrek.flag_dto,v_rec_histconctrek.cod_concerel,
           v_rec_histconctrek.columna_rel,v_rec_histconctrek.num_cuotas,
           v_rec_histconctrek.ord_cuota,v_rec_histconctrek.seq_cuotas
    From Fa_HistConcTrek
    Where ind_ordentotal = v_rec_histconctrek.ind_ordentotal
    And cod_concepto = v_rec_histconctrek.cod_concepto;
    /*dbms_output.put_line('FIN CONCEPTOS INSERT TREK');*/
  exception
   when others then
        raise_application_error (-20537,SQLERRM);
  End p_inserttrek;
  Procedure p_inserttrunk (v_rec_histconctrunk in Fa_HistConcTrunk%ROWTYPE) is
  Begin
    /*dbms_output.put_line('CONCEPTOS INSERT TRUNKING');*/
    Insert Into Fa_HistConcTrunk
          (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto,
           cod_tipconce,fec_valor,fec_efectividad,imp_concepto,cod_region,
           cod_provincia,cod_ciudad,imp_montobase,ind_factur,imp_facturable,
           ind_supertel,cod_portador,des_concepto,num_unidades,num_abonado,
           num_seriemec,num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
           num_guia,ind_alta,num_paquete,flag_impues,flag_dto,cod_concerel,
           columna_rel,num_cuotas,ord_cuota,seq_cuotas)
    Select v_rec_histconctrunk.ind_ordentotal,v_rec_histconctrunk.cod_concepto,
           nvl(max(columna+1),1),v_rec_histconctrunk.cod_moneda,
           v_rec_histconctrunk.cod_producto,v_rec_histconctrunk.cod_tipconce,
           v_rec_histconctrunk.fec_valor,v_rec_histconctrunk.fec_efectividad,
           v_rec_histconctrunk.imp_concepto,v_rec_histconctrunk.cod_region,
           v_rec_histconctrunk.cod_provincia,v_rec_histconctrunk.cod_ciudad,
           v_rec_histconctrunk.imp_montobase,v_rec_histconctrunk.ind_factur,
           v_rec_histconctrunk.imp_facturable,v_rec_histconctrunk.ind_supertel,
           v_rec_histconctrunk.cod_portador,v_rec_histconctrunk.des_concepto,
           v_rec_histconctrunk.num_unidades,v_rec_histconctrunk.num_abonado,
           v_rec_histconctrunk.num_seriemec,v_rec_histconctrunk.num_seriele,
           v_rec_histconctrunk.prc_impuesto,v_rec_histconctrunk.val_dto,
           v_rec_histconctrunk.tip_dto,v_rec_histconctrunk.mes_garantia,
           v_rec_histconctrunk.num_guia,v_rec_histconctrunk.ind_alta,
           v_rec_histconctrunk.num_paquete,v_rec_histconctrunk.flag_impues,
           v_rec_histconctrunk.flag_dto,v_rec_histconctrunk.cod_concerel,
           v_rec_histconctrunk.columna_rel,v_rec_histconctrunk.num_cuotas,
           v_rec_histconctrunk.ord_cuota,v_rec_histconctrunk.seq_cuotas
    From Fa_HistConcTrunk
    Where ind_ordentotal = v_rec_histconctrunk.ind_ordentotal
    And cod_concepto = v_rec_histconctrunk.cod_concepto;
    /*dbms_output.put_line('FIN CONCEPTOS INSERT TRUNKING');*/
  exception
   when others then
        raise_application_error (-20538,SQLERRM);
  End p_inserttrunk;
  Procedure p_insertgene  (v_rec_histconcgene in Fa_HistConcGene%ROWTYPE) is
  Begin
    /*dbms_output.put_line('CONCEPTOS INSERT GENERAL');*/
    Insert Into Fa_HistConcGene
          (ind_ordentotal,cod_concepto,columna,cod_moneda,cod_producto,
           cod_tipconce,fec_valor,fec_efectividad,imp_concepto,cod_region,
           cod_provincia,cod_ciudad,imp_montobase,ind_factur,imp_facturable,
           ind_supertel,cod_portador,des_concepto,num_unidades,num_abonado,
           num_seriemec,num_seriele,prc_impuesto,val_dto,tip_dto,mes_garantia,
           num_guia,ind_alta,num_paquete,flag_impues,flag_dto,cod_concerel,
           columna_rel,num_cuotas,ord_cuota,seq_cuotas)
    Select v_rec_histconcgene.ind_ordentotal,v_rec_histconcgene.cod_concepto,
           nvl(max(columna+1),1),v_rec_histconcgene.cod_moneda,
           v_rec_histconcgene.cod_producto,v_rec_histconcgene.cod_tipconce,
           v_rec_histconcgene.fec_valor,v_rec_histconcgene.fec_efectividad,
           v_rec_histconcgene.imp_concepto,v_rec_histconcgene.cod_region,
           v_rec_histconcgene.cod_provincia,v_rec_histconcgene.cod_ciudad,
           v_rec_histconcgene.imp_montobase,v_rec_histconcgene.ind_factur,
           v_rec_histconcgene.imp_facturable,v_rec_histconcgene.ind_supertel,
           v_rec_histconcgene.cod_portador,v_rec_histconcgene.des_concepto,
           v_rec_histconcgene.num_unidades,v_rec_histconcgene.num_abonado,
           v_rec_histconcgene.num_seriemec,v_rec_histconcgene.num_seriele,
           v_rec_histconcgene.prc_impuesto,v_rec_histconcgene.val_dto,
           v_rec_histconcgene.tip_dto,v_rec_histconcgene.mes_garantia,
           v_rec_histconcgene.num_guia,v_rec_histconcgene.ind_alta,
           v_rec_histconcgene.num_paquete,v_rec_histconcgene.flag_impues,
           v_rec_histconcgene.flag_dto,v_rec_histconcgene.cod_concerel,
           v_rec_histconcgene.columna_rel,v_rec_histconcgene.num_cuotas,
           v_rec_histconcgene.ord_cuota,v_rec_histconcgene.seq_cuotas
    From Fa_HistConcGene
    Where ind_ordentotal = v_rec_histconcgene.ind_ordentotal
    And cod_concepto = v_rec_histconcgene.cod_concepto;
    /*dbms_output.put_line('FIN CONCEPTOS INSERT GENERAL');*/
  exception
   when others then
        raise_application_error (-20539,SQLERRM);
  End p_insertgene;
end fa_comp_conc_presu;
/
SHOW ERRORS
