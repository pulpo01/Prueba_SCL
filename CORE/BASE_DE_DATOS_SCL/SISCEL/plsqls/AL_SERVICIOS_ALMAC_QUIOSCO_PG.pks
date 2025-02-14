CREATE OR REPLACE PACKAGE al_servicios_almac_quiosco_pg IS
   cv_error_no_clasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cv_modulo_ga         CONSTANT VARCHAR2 (2)  := 'GA';

-------------------------------------------------------------------------------------------------------------
   PROCEDURE al_consulta_articulo_pr (
      en_cod_articulo       IN              al_articulos.cod_articulo%TYPE,
      sn_tip_articulo       OUT NOCOPY      al_articulos.tip_articulo%TYPE,
      sv_des_articulo       OUT NOCOPY      al_articulos.des_articulo%TYPE,
      sn_cod_conceptoart    OUT NOCOPY      al_articulos.cod_conceptoart%TYPE,
      sv_codconceptodscto   OUT NOCOPY      VARCHAR2,
	  sv_tip_terminal       OUT NOCOPY      al_articulos.tip_terminal%TYPE,	  
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------------
END al_servicios_almac_quiosco_pg;
/
SHOW ERRORS
