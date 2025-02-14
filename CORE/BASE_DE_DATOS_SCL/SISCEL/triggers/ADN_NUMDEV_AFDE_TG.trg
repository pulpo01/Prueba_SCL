CREATE OR REPLACE TRIGGER ADN_NUMDEV_AFDE_TG
AFTER DELETE
ON ADN_CELNUM_DEVUELTOS_TO
FOR EACH ROW

DECLARE
      v_celular     adn_celnum_devueltos_to.num_celular%type;
	  v_subalm		adn_celnum_devueltos_to.cod_subalm%type;
	  v_producto	adn_celnum_devueltos_to.cod_producto%type;
	  v_central 	adn_celnum_devueltos_to.cod_central%type;
	  v_cat			adn_celnum_devueltos_to.cod_cat%type;
	  v_uso			adn_celnum_devueltos_to.cod_uso%type;
	  v_operadora	adn_celnum_devueltos_to.cod_operadora%type;
	  v_ind_origen	adn_celnum_devueltos_to.ind_origen%type;
	  v_nro_informe	adn_celnum_devueltos_to.num_informe%type;
  	  v_desde	    adn_celnum_devueltos_to.num_desde%type;
BEGIN
   v_celular:= :OLD.num_celular;
   v_subalm	:= :OLD.cod_subalm;
   v_producto	:= :OLD.cod_producto;
   v_central 	:= :OLD.cod_central;
   v_cat		:= :OLD.cod_cat;
   v_uso		:= :OLD.cod_uso;
   v_operadora	:= :OLD.cod_operadora;
   v_ind_origen	:= :OLD.ind_origen;
   v_nro_informe:= :OLD.num_informe;
   v_desde:= :OLD.num_desde;

   INSERT INTO ADN_CELNUM_DEVUELTOS_TH (num_celular, fec_baja, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, cod_operadora, ind_origen, num_informe, num_desde, nom_usuario)
   VALUES(v_celular,sysdate,v_subalm,v_producto,v_central,v_cat,v_uso,v_operadora,v_ind_origen,v_nro_informe,v_desde,user);
END ADN_NUMDEV_AFDE_TG;
/
SHOW ERRORS
