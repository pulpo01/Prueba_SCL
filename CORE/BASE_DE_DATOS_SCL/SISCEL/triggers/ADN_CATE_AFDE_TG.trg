CREATE OR REPLACE TRIGGER ADN_CATE_AFDE_TG
AFTER DELETE
ON ADN_CATEGORIA_TD
FOR EACH ROW

DECLARE
   v_cod_plantarif        adn_categoria_td.cod_plantarif%type;
   v_tip_administrativo adn_categoria_td.tip_administrativo%type;
BEGIN
   v_cod_plantarif         := :OLD.cod_plantarif;
   v_tip_administrativo  := :OLD.tip_administrativo;
   INSERT INTO ADN_HCATEGORIA_TD (cod_plantarif,fec_baja,tip_administrativo,nom_usuario)
   VALUES(v_cod_plantarif ,SYSDATE,v_tip_administrativo,USER);
END ADN_CATE_AFDE_TG;
/
SHOW ERRORS
