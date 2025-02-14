CREATE OR REPLACE PACKAGE BODY        CO_PAC_DOCTOSCLIENTE as
procedure CO_S_DOCTOSCLIENTE (CodCliente        in number,
                              CodTipDocum       in number,
                              NumTipDocum       in number,
                              cod_Cliente       out tcod_Cliente,
                              cod_tipdocum      out tcod_tipdocum,
                              cod_tipmovimien   out tcod_tipmovimien,
                              num_folio         out tnum_folio,
                              tot_factura       out ttot_factura,
                              importe_debe      out timporte_debe,
                              des_estado        out tdes_estado,
                              num_mes           out tnum_mes,
                              fec_vencimie      out tfec_vencimie
) is
I NUMBER:=0;
num_documentos number:=NumTipDocum;
cursor c1 is
select a.*,tot_factura,decode(b.num_cuotas,0,fec_vencimie,
                                           1,fec_vencimie,NULL) fec_vencimie,
           fec_emision,lpad(to_char(b.fec_vencimie,'MM'),2) num_mes,b.num_cuotas,
           c.cod_tipmovimien
from (select unique cod_tipmovimien,cod_tipdocum,cod_modventa from fa_tipmovimien) c,
     fa_histdocu b,(
select cod_cliente,cod_tipdocum,num_folio,sum(importe_debe) importe_debe from (
        select cod_cliente,
                   cod_tipdocum,
                           num_folio,
                   importe_debe-importe_haber importe_debe
        from co_cartera
        union all
        select cod_cliente,
                   cod_tipdocum,
                           num_folio,
                   importe_debe-importe_haber importe_debe
        from co_cancelados
                )
group by cod_cliente,cod_tipdocum,num_folio
) a
where a.cod_cliente = CodCliente --1473979
and       a.cod_cliente=b.cod_cliente
and       a.num_folio=b.num_folio
and   a.cod_tipdocum=b.cod_tipdocum
and   a.cod_tipdocum=c.cod_tipdocum
and       c.cod_tipmovimien in (1,2,25,18)
and   nvl(b.cod_modventa,1)=c.cod_modventa
and   rownum < num_documentos+1
order by fec_emision desc;
--
cursor c2 is
select a.*,tot_factura,decode(b.num_cuotas,0,fec_vencimie,
                                           1,fec_vencimie,NULL) fec_vencimie,
           fec_emision,lpad(to_char(b.fec_vencimie,'MM'),2) num_mes,b.num_cuotas,
           c.cod_tipmovimien
from (select unique cod_tipmovimien,cod_tipdocum,cod_modventa from fa_tipmovimien) c,
      fa_histdocu b,(
select cod_cliente,cod_tipdocum,num_folio,sum(importe_debe) importe_debe from (
        select cod_cliente,
                   cod_tipdocum,
                           num_folio,
                   importe_debe-importe_haber importe_debe
        from co_cartera
        union all
        select cod_cliente,
                   cod_tipdocum,
                           num_folio,
                   importe_debe-importe_haber importe_debe
        from co_cancelados
                )
group by cod_cliente,cod_tipdocum,num_folio
) a
where a.cod_cliente = CodCliente --1473979
and       a.cod_cliente=b.cod_cliente
and       a.num_folio=b.num_folio
and   a.cod_tipdocum=b.cod_tipdocum
and   a.cod_tipdocum=c.cod_tipdocum
and       c.cod_tipmovimien = CodTipDocum
and   nvl(b.cod_modventa,1)=c.cod_modventa
and   rownum < num_documentos+1
order by fec_emision desc;
BEGIN
         if NumTipDocum= 0 then
            num_documentos:=999999;
         end if;
     if CodTipDocum = 0 or NULL then
     FOR L in  C1 loop
             I:=I+1;
                 num_mes                (I)           :=L.num_mes;
                 cod_cliente    (I)               :=L.cod_cliente;
                 cod_tipdocum   (I)               :=L.cod_tipdocum;
                 cod_tipmovimien(I)               :=L.cod_tipmovimien;
                 num_folio              (I)               :=L.num_folio;
                 tot_factura    (I)               :=L.tot_factura;
                 importe_debe   (I)               :=L.importe_debe;
                 fec_vencimie   (I)               :=L.fec_vencimie;
                 if L.importe_debe = 0
                 then
                    des_estado  (I)               :='cancelada';
                 else
                 if L.fec_vencimie > sysdate or null
                 then
                    des_estado  (I)               :='vigente';
                 else
                    des_estado  (I)               :='morosa';
                 end if;
                 end if;
         END LOOP;
  else
     FOR L in  C2 loop
             I:=I+1;
                 num_mes                (I)           :=L.num_mes;
                 cod_cliente    (I)               :=L.cod_cliente;
                 cod_tipdocum   (I)               :=L.cod_tipdocum;
                 cod_tipmovimien(I)               :=L.cod_tipmovimien;
                 tot_factura    (I)               :=L.tot_factura;
                 importe_debe   (I)               :=L.importe_debe;
                 fec_vencimie   (I)               :=L.fec_vencimie;
                 if L.importe_debe = 0
                 then
                    des_estado  (I)               :='cancelada';
                 else
                 if L.fec_vencimie > sysdate or null
                 then
                    des_estado  (I)               :='vigente';
                 else
                    des_estado  (I)               :='morosa';
                 end if;
                 end if;
         END LOOP;
  end if;
  END;
end;
/
SHOW ERRORS
