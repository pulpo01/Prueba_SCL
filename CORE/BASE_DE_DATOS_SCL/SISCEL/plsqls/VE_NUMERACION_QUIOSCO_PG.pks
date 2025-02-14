CREATE OR REPLACE PACKAGE ve_numeracion_quiosco_pg AS

cv_version              CONSTANT INTEGER       := 1;
cv_subversion           CONSTANT INTEGER       := 0;
cn_uno                  CONSTANT INTEGER       := 1;
cn_cero                 CONSTANT INTEGER       := 0;
cv_modulo				CONSTANT VARCHAR2 (2)  := 'GA';

----------------------------------------------------------------------------------------------------
PROCEDURE p_numeracion_manual_pr (
  		  vp_tabla 	 	  IN varchar2 ,
  		  vp_subalm  	  IN varchar2 ,
  		  vp_central 	  IN varchar2 ,
  		  vp_cat 	 	  IN varchar2 ,
  		  vp_uso 	 	  IN varchar2 ,
  		  vp_celular 	  IN varchar2 ,
		  sn_cod_retorno  OUT NOCOPY      ge_errores_pg.coderror,
      	  sv_mens_retorno OUT NOCOPY      ge_errores_pg.msgerror,
      	  sn_num_evento   OUT NOCOPY      ge_errores_pg.evento
);
----------------------------------------------------------------------------------------------------
PROCEDURE p_numeracion_automatica_pr(
		  vp_actabo 	   IN varchar2 ,
		  vp_subalm 	   IN varchar2 ,
		  vp_central 	   IN varchar2 ,
		  vp_uso 		   IN varchar2 ,
		  vp_celular	   OUT NOCOPY  ga_abocel.num_celular%TYPE,
		  vp_cat 		   OUT NOCOPY  ga_celnum_uso.cod_cat%TYPE,
		  vp_fecbaja 	   OUT NOCOPY  DATE,
		  vp_tipocelular   OUT NOCOPY  VARCHAR2,
		  sn_cod_retorno   OUT NOCOPY  ge_errores_pg.coderror,
      	  sv_mens_retorno  OUT NOCOPY  ge_errores_pg.msgerror,
      	  sn_num_evento    OUT NOCOPY  ge_errores_pg.evento
);
----------------------------------------------------------------------------------------------------
END ve_numeracion_quiosco_pg;
/

SHOW ERRORS
