CREATE OR REPLACE PACKAGE            EBZ_PAC_FA_SISCEL
 AS
/* tipos usados en procedure FA_SALDO_CTA */
--type t_fecha_docto    is table  of co_cartera.fec_efectividad%type INDEX BY BINARY_INTEGER;
type t_fecha_docto      is table  of varchar2(10) INDEX BY BINARY_INTEGER;
type t_descrip_docto    is table  of ge_tipdocumen.DES_TIPDOCUM%type INDEX BY BINARY_INTEGER;
type t_folio_docto      is table  of co_cartera.num_folio%type INDEX BY BINARY_INTEGER;
type t_debe             is table  of co_cartera.importe_debe%type INDEX BY BINARY_INTEGER;
type t_haber            is table  of co_cartera.importe_haber%type INDEX BY BINARY_INTEGER;
type t_saldo            is table  of co_cartera.importe_debe%type INDEX BY BINARY_INTEGER;
type t_num_cuotas       is table  of co_cartera.num_cuota%type INDEX BY BINARY_INTEGER;
type t_cod_cliente      is table  of co_cartera.cod_cliente%type INDEX BY BINARY_INTEGER;
type t_estado           is table  of varchar2(10) INDEX BY BINARY_INTEGER;
--type t_ordentotal     is table of ge_tipdocumen.DES_TIPDOCUM%type INDEX BY BINARY_INTEGER;
type t_ordentotal     is table of fa_histdocu.IND_ORDENTOTAL%type INDEX BY BINARY_INTEGER;
type t_nom_user       is table of fa_histdocu.nom_usuarora%type INDEX BY BINARY_INTEGER;
type t_num_securel    is table of fa_histdocu.num_securel%type INDEX BY BINARY_INTEGER;
type t_letra_rel      is table of fa_histdocu.letrarel%type INDEX BY BINARY_INTEGER;
type t_cod_tipdocrel  is table of fa_histdocu.cod_tipdocumrel%type INDEX BY BINARY_INTEGER;
type t_cod_vendedor   is table of fa_histdocu.cod_vendedor_agenterel%type INDEX BY BINARY_INTEGER;
type t_cod_central    is table of fa_histdocu.cod_centrrel%type INDEX BY BINARY_INTEGER;
type t_p_num_ctc      is table of fa_histdocu.num_ctc%type INDEX BY BINARY_INTEGER;
type t_desc_despacho  is table of fa_codespacho.DESC_DESPACHO%type INDEX BY BINARY_INTEGER;
/* tipos usados en procedure FA_MINUTOS */
type t_minutos        is table of ta_plantarif.NUM_UNIDADES%type INDEX BY BINARY_INTEGER;
type t_minutos_f      is table of varchar2(8) INDEX BY BINARY_INTEGER;
type t_tip_plan_tarif is table of varchar2(11) INDEX BY BINARY_INTEGER;
type t_plan_tarif     is table of ta_plantarif.DES_PLANTARIF%type INDEX BY BINARY_INTEGER;
type t_celular        is table  of ga_abocel.NUM_CELULAR%type INDEX BY BINARY_INTEGER;
/*tipos usados en procedure FA_DOCTO_CLI */
type t_num_folio      is table of number(9) INDEX BY BINARY_INTEGER;
type t_valor_pesos    is table of number(14,4) INDEX BY BINARY_INTEGER;
type t_cod_ciclo_fact is table of number(8) INDEX BY BINARY_INTEGER;
type t_cod_tipdocum   is table of number(2) INDEX BY BINARY_INTEGER;
type t_des_tipdocum   is table of ge_tipdocumen.DES_TIPDOCUM%type INDEX BY BINARY_INTEGER;
type t_movimiento     is table of varchar2(40) INDEX BY BINARY_INTEGER;
type t_num_proceso    is table of fa_histdocu.num_proceso%type INDEX BY BINARY_INTEGER;
/*tipos de uso en FA_DET_LLAM*/
type t_hora           is table of varchar2(8) INDEX BY BINARY_INTEGER;
 /*hh:mm:ss*/
type t_tipo_llamada   is table of varchar2(8) INDEX BY BINARY_INTEGER;
 /*E= Entrada S= Saliente*/
type t_clasif_llamada is table of varchar2(15) INDEX BY BINARY_INTEGER;
--type t_dur_llamada    is table of number(15) INDEX BY BINARY_INTEGER;
type t_dur_llamada    is table of varchar2(10) INDEX BY BINARY_INTEGER;
type t_num_origen     is table of varchar2(20) INDEX BY BINARY_INTEGER;
type t_num_destino    is table of varchar2(20) INDEX BY BINARY_INTEGER;
type t_horario        is table of varchar2(10) INDEX BY BINARY_INTEGER;
 /*normal alto medio*/
type t_valor          is table of number(14,4) INDEX BY BINARY_INTEGER;
type t_destino        is table of varchar2(30) INDEX BY BINARY_INTEGER;
/* tipos usados en procedure CO_MINUTOS */
/*tipos de uso general*/
type t_cod_cliente_   is table of ge_clientes.cod_cliente%type   INDEX BY BINARY_INTEGER;
type t_nom_cliente_   is table of ge_clientes.nom_cliente%type   INDEX BY BINARY_INTEGER;
type t_error          is table of varchar2(1000)  INDEX BY BINARY_INTEGER;
procedure FA_SALDO_CTA(
                        identificacion in varchar2,
            tip_identifica in varchar2,
            tip_saldo      in varchar2,
            fecha_docto    out t_fecha_docto,
            descrip_docto  out t_descrip_docto,
            folio_docto    out t_folio_docto,
            debe           out t_debe,
            haber          out t_haber,
            saldo          out t_saldo,
            num_cuotas     out t_num_cuotas,
            cod_cliente    out t_cod_cliente,
            estado         out t_estado,
            error          out t_error
            );
procedure FA_MINUTOS(
                    identificacion in varchar2,
                    tip_identifica in varchar2,
                    cod_cicloa     in varchar2,
                    cod_cliente    out t_cod_cliente,
                    celular        out t_celular,
                    mi_contratados out t_minutos,
	                mi_usadosf      out t_minutos_f,
                    mi_disponibles out t_minutos,
                    mi_promo       out t_minutos,
	                mi_promo_usadof out t_minutos_f,
                    mi_promo_dispo out t_minutos,
                    plan_tarif     out t_plan_tarif,
                    tip_plan_tarif out t_tip_plan_tarif,
                    mi_usados      out t_minutos,
                    mi_promo_usado out t_minutos,
                    error          out t_error
                );

FUNCTION GE_F_TIPALMAC ( Par_CiclFact in varchar2, Par_NomCam in varchar2 ) RETURN varchar2;


    PROCEDURE FA_DOCTO_CLI (
                cod_cliente   in number,
                num_doctos    in number,
                tip_docto     in number,
                f_emision     out t_fecha_docto,
                f_vcto      out t_fecha_docto,
                num_docto     out t_num_folio,
                iva       out t_valor_pesos,
                tot_factura   out t_valor_pesos,
                tot_pagar   out t_valor_pesos,
                mes           out t_cod_tipdocum,
                estado        out t_estado,
                cod_ciclfact  out t_cod_ciclo_fact,
                cod_tipdocum  out t_cod_tipdocum,
                des_tipdocum  out t_des_tipdocum,
                tip_mov       out t_movimiento,
                num_proceso   out t_num_proceso,
                error         out t_error
                 );
    PROCEDURE FA_DOCTO_CLI_SAC (
                cod_cliente   in number,
                num_doctos    in number,
                tip_docto     in number,
                f_emision     out t_fecha_docto,
                f_vcto      out t_fecha_docto,
                num_docto     out t_num_folio,
                iva       out t_valor_pesos,
                tot_factura   out t_valor_pesos,
                tot_pagar   out t_valor_pesos,
                mes           out t_cod_tipdocum,
                estado        out t_estado,
                cod_ciclfact  out t_cod_ciclo_fact,
                cod_tipdocum  out t_cod_tipdocum,
                des_tipdocum  out t_des_tipdocum,
                tip_mov       out t_movimiento,
                num_proceso   out t_num_proceso,
                ordentotal    out t_ordentotal,
                neto      out t_valor_pesos,
                saldo_ant   out t_valor_pesos,
                nom_user    out t_nom_user,
                num_securel   out t_num_securel,
                letra_rel   out t_letra_rel,
                cod_tipdocrel out t_cod_tipdocrel,
                cod_vendedor  out t_cod_vendedor,
                cod_central   out t_cod_central,
                p_num_ctc   out t_p_num_ctc,
                desc_despacho out t_desc_despacho,
                error         out t_error
                 );
    PROCEDURE FA_DET_LLAM (
                 identificacion in varchar2,
                 tip_identifica in varchar2,
                 tip_llamada    in varchar2,
                 t_facturacion  in varchar2,
                 cod_cicl_fact  in number,
                 tipo_documento in number,
                 num_proceso    in number,
                 f_llamada    out t_fecha_docto,
                 h_llamada    out t_hora,
                 tipo_llamada   out t_tipo_llamada,
                 clasif_llamada out t_clasif_llamada,
                 dur_llamada    out t_dur_llamada,
                 num_origen   out t_num_origen,
                 num_destino    out t_num_destino,
                 horario      out t_horario,
                 destino      out t_destino,
                 valor      out t_valor,
                 error      out t_error,
				 depura		out t_error
                  );
    PROCEDURE FC_locales (
                  cod_clientes   in varchar2,
                  tip_identifica in varchar2,
                  cod_cicl_fact  in number,
                  tip_llamada    in varchar2,
                  tipo_documento in number,
                  facturable     in varchar2,
                  f_llamada    out t_fecha_docto,
                  h_llamada    out t_hora,
                  tipo_llamada   out t_tipo_llamada,
                  clasif_llamada out t_clasif_llamada,
                  dur_llamada    out t_dur_llamada,
                  num_origen     out t_num_origen,
                  num_destino    out t_num_destino,
                  horario      out t_horario,
                  valor      out t_valor,
                  destino      out t_destino,
                  max_reg      out integer,
				  error		   out t_error
                   );
    PROCEDURE FTR (
              cod_clientes    in varchar2,
              tip_identifica in varchar2,
              cod_cicl_fact  in number,
              tip_llamada    in varchar2,
              num_proceso     in number,
              f_llamada    out t_fecha_docto,
              h_llamada    out t_hora,
              tipo_llamada   out t_tipo_llamada,
              clasif_llamada out t_clasif_llamada,
              dur_llamada    out t_dur_llamada,
              num_origen     out t_num_origen,
              num_destino    out t_num_destino,
              horario      out t_horario,
              valor      out t_valor,
              destino      out t_destino,
              max_reg      out integer
          );
    PROCEDURE FA_MINUTOS_RUT (
                 identificacion in varchar2,
                 cod_clientes   out t_cod_cliente_,
                 nombre     out t_nom_cliente_,
                 min_contratados out t_minutos,
                 min_utilizados  out t_minutos,
                 min_promo     out t_minutos,
                 min_promo_utili out t_minutos,
                 tipo_plan_tarif out t_tip_plan_tarif,
                 plan_tarif    out t_plan_tarif,
				 error		   out t_error
                  );
end EBZ_PAC_FA_SISCEL;
/
SHOW ERRORS
