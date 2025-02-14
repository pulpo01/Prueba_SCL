CREATE OR REPLACE PACKAGE PF_CARGOS_PRODUCTOS_PG


IS

  TYPE refCursor IS REF CURSOR;
  CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
  CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'PF';
  CV_version              CONSTANT VARCHAR2 (2)  := '1';
  CN_LISTA_NULA constant number:=1;


    PROCEDURE PF_CARGO_S_PR(EO_CARG_PROD	  IN  		PF_CARGOS_PROD_TD_LISTA_QT,
						  SO_CARG_PROD        OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);
                          
                          
    PROCEDURE PF_CARGO_PRODUCTO_S_PR(EV_COD_PROD_OFERTADO   IN pf_catalogo_ofertado_td.cod_prod_ofertado%type,
                                        EV_COD_CANAL        IN pf_catalogo_ofertado_td.cod_canal%type, 
                					    SO_CARGOS_PROD      OUT NOCOPY	refCursor,
						                SN_cod_retorno      OUT NOCOPY  ge_errores_pg.coderror,
						                SV_mens_retorno     OUT NOCOPY  ge_errores_pg.msgerror,
						                SN_num_evento       OUT NOCOPY	ge_errores_pg.evento);
                                                                  
END PF_CARGOS_PRODUCTOS_PG;
/
SHOW ERRORS