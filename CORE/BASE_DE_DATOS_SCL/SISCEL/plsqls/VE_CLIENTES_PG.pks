CREATE OR REPLACE PACKAGE ve_clientes_pg AS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cn_tip_direccion 	  CONSTANT NUMBER := 1;
cv_modulove			  CONSTANT VARCHAR2(5):= 'VE';
cv_version            CONSTANT VARCHAR2(5):= '1.0';
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_rec_datos_cliente_pr(
                                  en_num_celular    IN ga_aboamist.num_celular%TYPE,
                                  sv_cod_tipident   OUT NOCOPY ge_clientes.cod_tipident%TYPE,
                                  sv_des_identifi   OUT NOCOPY ge_tipident.des_tipident%TYPE,
                                  sv_num_ident      OUT NOCOPY ge_clientes.num_ident%TYPE,
                                  sv_nom_cliente    OUT NOCOPY ge_clientes.nom_cliente%TYPE,
                                  sv_nom_apeclien1  OUT NOCOPY ge_clientes.nom_apeclien1%TYPE,
                                  sv_nom_apeclien2  OUT NOCOPY ge_clientes.nom_apeclien2%TYPE,
                                  sn_cod_categoria  OUT NOCOPY ge_clientes.cod_categoria%TYPE,
                                  sv_des_categoria  OUT NOCOPY ge_categorias.des_categoria%TYPE,
                                  sv_cod_region     OUT NOCOPY ge_direcciones.cod_region%TYPE,
                                  --sv_des_region     OUT NOCOPY ge_regiones.des_region%TYPE, CSR-11002
                                  sv_cod_provincia  OUT NOCOPY ge_direcciones.cod_provincia%TYPE,
                                  --sv_des_provincia  OUT NOCOPY ge_provincias.des_provincia%TYPE, CSR-11002
                                  sv_cod_ciudad     OUT NOCOPY ge_direcciones.cod_ciudad%TYPE,
                                  --sv_des_ciudad     OUT NOCOPY ge_ciudades.des_ciudad%TYPE, CSR-11002
                                  sv_cod_comuna     OUT NOCOPY ge_direcciones.cod_comuna%TYPE,
                                  --sv_des_comuna     OUT NOCOPY ge_ciudades.des_ciudad%TYPE, CSR-11002
                                  sv_nom_calle      OUT NOCOPY ge_direcciones.nom_calle%TYPE,
                                  sv_num_calle      OUT NOCOPY ge_direcciones.num_calle%TYPE,
                                  sv_num_piso       OUT NOCOPY ge_direcciones.num_piso%TYPE, --INICIO CSR-11002
                                  sv_num_casilla    OUT NOCOPY ge_direcciones.num_casilla%TYPE,
                                  sv_obs_direccion  OUT NOCOPY ge_direcciones.obs_direccion%TYPE,
                                  sv_des_direc1     OUT NOCOPY ge_direcciones.des_direc1%TYPE,
                                  sv_des_direc2     OUT NOCOPY ge_direcciones.des_direc2%TYPE,
                                  sv_cod_pueblo     OUT NOCOPY ge_direcciones.cod_pueblo%TYPE,
                                  sv_cod_estado     OUT NOCOPY ge_direcciones.cod_estado%TYPE,
                                  sv_cod_tipocalle  OUT NOCOPY ge_direcciones.cod_tipocalle%TYPE, --FIN CSR-11002
                                  sv_zip            OUT NOCOPY ge_direcciones.zip%TYPE,
                                  sn_cod_cliente    OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                  sn_cod_cuenta     OUT NOCOPY ge_clientes.cod_cuenta%TYPE,
                                  sn_cod_categocam  OUT NOCOPY fa_tasa_cambio_td.cod_categoria_cambio%TYPE,
                                  sv_des_categocam  OUT NOCOPY fa_tasa_cambio_td.des_categoria_cambio%TYPE,
                                  SV_COD_CREDITICIA OUT NOCOPY ge_clientes.COD_CREDITICIA%TYPE,
                                  SV_DES_CREDITICIA OUT NOCOPY GE_CREDITICIA_TD.DES_CREDITICIA%TYPE,
                                  sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	      				          sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	   						      sn_num_evento     OUT NOCOPY ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_clientes_pg; 
/
SHOW ERRORS
