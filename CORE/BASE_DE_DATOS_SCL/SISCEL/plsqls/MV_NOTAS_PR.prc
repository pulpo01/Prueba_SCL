CREATE OR REPLACE PROCEDURE        mv_notas_pr(sNumTrans in varchar2, TipAccion in char, fecha in varchar2,
                                                        categoria in varchar2, tramo in char, corte in varchar2, val_corte in varchar2,
                                                        mto_vcamintramo in number, mto_vcamaxtramo in number,
                                                        dind_nota in varchar2, num_ctasubtramo in varchar2, val_porcctas in varchar2,
                                                        tramo1 in number, tramo2 in number)
is

var1  varchar2 (50);
var2  varchar2 (50);
var3  char(1);
var4 varchar2 (50);
begin
         if TipAccion = 'G' then

             delete mvt_notas where mvt_notas.fec_proceso = TO_DATE(fecha,'dd-mm-yyyy') and mvt_notas.cod_categoria = categoria and mvt_notas.ID_TRAMO = tramo AND mvt_notas.num_corte = corte ;

         insert into mvt_notas
                 values (to_date(fecha, 'dd-mm-yyyy'), categoria, tramo, corte, val_corte, mto_vcamintramo,
                                 mto_vcamaxtramo, dind_nota, num_ctasubtramo, val_porcctas);

                update mvt_cuentas
                set mvt_cuentas.ind_nota = dind_nota where mvt_cuentas.cod_categoria = categoria
                and mvt_cuentas.VAL_VCA between tramo1 and tramo2;


         end if;

         commit;


end;
/
SHOW ERRORS
