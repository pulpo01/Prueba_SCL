CREATE OR REPLACE PACKAGE        CO_PAC_DOCTOSCLIENTE
       as
type tcod_Cliente        is table  of co_cartera.cod_cliente%type INDEX BY BINARY_INTEGER;
type tcod_tipdocum       is table  of co_cartera.cod_tipdocum%type INDEX BY BINARY_INTEGER;
type tcod_tipmovimien is table of fa_tipmovimien.cod_tipmovimien%type INDEX BY BINARY_INTEGER;
type tnum_folio          is table  of co_cartera.num_folio%type INDEX BY BINARY_INTEGER;
type ttot_factura        is table  of fa_histdocu.tot_factura%type INDEX BY BINARY_INTEGER;
type timporte_debe       is table  of co_cartera.importe_debe%type INDEX BY BINARY_INTEGER;
type tdes_estado         is table  of varchar2(15) INDEX BY BINARY_INTEGER;
type tnum_mes            is table  of number(2) INDEX BY BINARY_INTEGER;
type tfec_vencimie       is table  of fa_histdocu.fec_vencimie%type INDEX BY BINARY_INTEGER;
PROCEDURE    CO_S_DOCTOSCLIENTE (CodCliente         in number,
                                 CodTipDocum        in number,
                                 NumTipDocum        in number,
                                 cod_Cliente        out tcod_Cliente,
                                 cod_tipdocum       out tcod_tipdocum,
                                 cod_tipmovimien    out tcod_tipmovimien,
                                 num_folio          out tnum_folio,
                                 tot_factura        out ttot_factura,
                                 importe_debe       out timporte_debe,
                                 des_estado         out tdes_estado,
                                 num_mes            out tnum_mes,
                                 fec_vencimie       out tfec_vencimie
);
END CO_PAC_DOCTOSCLIENTE ;
/
SHOW ERRORS
