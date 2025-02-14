CREATE OR REPLACE PROCEDURE        VE_P_INSVENTASERV(
  vp_servicio IN VARCHAR2 ,
  vp_abonado IN NUMBER ,
  vp_fecventa IN DATE ,
  vp_producto IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_nivel IN NUMBER ,
  vp_proc IN OUT VARCHAR2 ,
  vp_tabla IN OUT VARCHAR2 ,
  vp_action IN OUT VARCHAR2 ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 ,
  vp_error IN OUT VARCHAR2 )
IS
v_tipcomis ve_tipcomis.cod_tipcomis%TYPE;
v_comision ve_cuadservicios.imp_comision%TYPE := 0;
BEGIN
   vp_proc := 've_p_insventaserv';
   vp_error := '0';
   vp_tabla := 'VE_VENDEDORES';
   vp_action := 'S';
   SELECT  COD_TIPCOMIS
     INTO  v_tipcomis
     FROM  VE_VENDEDORES
    WHERE  COD_VENDEDOR = vp_vendedor;
   BEGIN
      SELECT  IMP_COMISION
        INTO  v_comision
        FROM  VE_CUADSERVICIOS
       WHERE  COD_PRODUCTO = vp_producto
         AND  COD_SERVICIO = vp_servicio
         AND  COD_TIPCOMIS = v_tipcomis
         AND  FEC_FINEFECTIVIDAD IS NULL;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
    v_comision := 0;
   END;
   vp_tabla := 'VE_VENTASERV';
   vp_action := 'I';
   INSERT INTO
  VE_VENTASERV  (COD_SERVICIO, NUM_ABONADO, FEC_ACEPTVENTA,
  COD_PRODUCTO, COD_TIPCOMIS, COD_VENDEDOR,
  COD_NIVEL, IMP_COMISION)
        VALUES  (vp_servicio, vp_abonado, vp_fecventa,
  vp_producto, v_tipcomis, vp_vendedor,
  vp_nivel, v_comision);
EXCEPTION
   WHEN OTHERS THEN
 vp_error := '4';
        vp_sqlcode := sqlcode;
 vp_sqlerrm := sqlerrm;
END;
/
SHOW ERRORS
