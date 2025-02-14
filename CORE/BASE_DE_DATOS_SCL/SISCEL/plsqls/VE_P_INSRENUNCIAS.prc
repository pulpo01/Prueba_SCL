CREATE OR REPLACE PROCEDURE        VE_P_INSRENUNCIAS(
  vp_abonado IN NUMBER ,
  vp_venta IN NUMBER ,
  vp_indbaja IN NUMBER ,
  vp_proc IN OUT VARCHAR2 ,
  vp_tabla IN OUT VARCHAR2 ,
  vp_action IN OUT VARCHAR2 ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 ,
  vp_error IN OUT VARCHAR2 )
IS
v_renuncia ve_renuncias.cod_renuncia%TYPE;
v_diasrenunc ve_liqdatgral.num_diasrenunc%TYPE;
v_vendedor ve_vendedores.cod_vendedor%TYPE;
v_tipcomis ve_tipcomis.cod_tipcomis%TYPE;
v_cliente ge_clientes.cod_cliente%TYPE;
v_producto ge_productos.cod_producto%TYPE;
v_oficina ge_oficinas.cod_oficina%TYPE;
v_fecalta DATE;
BEGIN
   vp_proc := 've_p_insrenuncias';
   vp_tabla := 'VE_LIQDATGRAL';
   vp_action := 'S';
   SELECT  NUM_DIASRENUNC
     INTO  v_diasrenunc
     FROM  VE_LIQDATGRAL;
   vp_tabla := 'GA_VENTAS';
   vp_action := 'S';
   SELECT  COD_VENDEDOR, COD_CLIENTE, COD_PRODUCTO,
    COD_OFICINA, FEC_VENTA
     INTO  v_vendedor, v_cliente, v_producto,
    v_oficina, v_fecalta
     FROM  GA_VENTAS
    WHERE  NUM_VENTA = vp_venta;
   IF (v_fecalta + v_diasrenunc) < SYSDATE THEN
      vp_tabla := 'VE_VENDEDORES';
      vp_action := 'S';
      SELECT  COD_TIPCOMIS
        INTO  v_tipcomis
        FROM  VE_VENDEDORES
       WHERE  COD_VENDEDOR = v_vendedor;
      vp_tabla := 'VE_SEQ_RENUNCIAS';
      vp_action := 'S';
      SELECT  VE_SEQ_RENUNCIAS.NEXTVAL
 INTO  v_renuncia
 FROM  DUAL;
      vp_tabla := 'VE_RENUNCIAS';
      vp_action := 'I';
      INSERT INTO VE_RENUNCIAS(COD_RENUNCIA, COD_TIPCOMIS, COD_VENDEDOR,
      COD_CLIENTE, NUM_ABONADO, COD_PRODUCTO,COD_OFICINA, FEC_ALTA
, FEC_RENUNCIA)
      VALUES (v_renuncia, v_tipcomis, v_vendedor,v_cliente, vp_abonado,
      v_producto,v_oficina, v_fecalta, sysdate);
   END IF;
EXCEPTION
   WHEN OTHERS THEN
 vp_error := '4';
 vp_sqlcode := sqlcode;
 vp_sqlerrm := sqlerrm;
END;
/
SHOW ERRORS
