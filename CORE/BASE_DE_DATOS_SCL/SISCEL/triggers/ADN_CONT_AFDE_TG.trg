CREATE OR REPLACE TRIGGER ADN_CONT_AFDE_TG
AFTER DELETE
ON ADN_CONTAMINADOS_TD
FOR EACH ROW

DECLARE
 v_celular   adn_contaminados_td.num_celular%type;
 v_subalm    adn_contaminados_td.cod_subalm%type;
 v_producto  adn_contaminados_td.cod_producto%type;
 v_central   adn_contaminados_td.cod_central%type;
 v_cat       adn_contaminados_td.cod_cat%type;
 v_uso       adn_contaminados_td.cod_uso%type;
 v_operadora adn_contaminados_td.cod_operadora%type;
BEGIN
   v_celular    := :OLD.num_celular;
   v_subalm	    := :OLD.cod_subalm;
   v_producto	:= :OLD.cod_producto;
   v_central 	:= :OLD.cod_central;
   v_cat		:= :OLD.cod_cat;
   v_uso		:= :OLD.cod_uso;
   v_operadora	:= :OLD.cod_operadora;

   INSERT INTO ADN_CONTAMINADOS_TH(num_celular, fec_baja, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, cod_operadora, nom_usuario)
   VALUES( v_celular,sysdate,v_subalm,v_producto,v_central,v_cat,v_uso,v_operadora,user)
   ;
END ADN_CONT_AFDE_TG;
/
SHOW ERRORS
