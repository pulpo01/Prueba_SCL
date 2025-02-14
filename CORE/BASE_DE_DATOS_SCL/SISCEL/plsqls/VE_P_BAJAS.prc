CREATE OR REPLACE PROCEDURE        VE_P_BAJAS(
  vp_producto IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_bajas OUT NUMBER )
IS
v_bajaspenal NUMBER := 0;
v_cliente ga_abocel.cod_cliente%TYPE;
CURSOR c_bajascel IS
 SELECT COD_CLIENTE
 FROM  VE_RENUNCIAS
 WHERE  COD_VENDEDOR = vp_vendedor
 AND  COD_PRODUCTO = vp_producto
 AND  to_date(FEC_RENUNCIA,'DD-MON-YY') BETWEEN vp_feciniliq AND vp_fecfinliq
 AND  MONTHS_BETWEEN ( fec_renuncia, fec_alta) < 6
 UNION
 SELECT DISTINCT C.COD_CLIENTE
 FROM  CO_CARTERA C, GA_ABOCEL A
 WHERE  C.COD_CLIENTE = A.COD_CLIENTE
 AND  A.COD_VENDEDOR = vp_vendedor
 AND (  C.COD_PRODUCTO = vp_producto OR
   C.COD_PRODUCTO = ( SELECT prod_general FROM ge_datosgener ) )
 AND  IMPORTE_DEBE > IMPORTE_HABER
 AND  FEC_EFECTIVIDAD < ( vp_feciniliq - 60);
CURSOR c_bajasbeep IS
 SELECT COD_CLIENTE
 FROM  VE_RENUNCIAS
 WHERE  COD_VENDEDOR = vp_vendedor
 AND  COD_PRODUCTO = vp_producto
 AND  to_date(FEC_RENUNCIA,'DD-MON-YY') BETWEEN vp_feciniliq AND vp_fecfinliq
 AND  MONTHS_BETWEEN ( fec_renuncia, fec_alta) < 6
 UNION
 SELECT DISTINCT C.COD_CLIENTE
 FROM  CO_CARTERA C, GA_ABOBEEP A
 WHERE  C.COD_CLIENTE = A.COD_CLIENTE
 AND  A.COD_VENDEDOR = vp_vendedor
 AND (  C.COD_PRODUCTO = vp_producto OR
   C.COD_PRODUCTO = ( SELECT prod_general FROM ge_datosgener ) )
 AND  IMPORTE_DEBE > IMPORTE_HABER
 AND  FEC_EFECTIVIDAD < ( vp_feciniliq - 60);
CURSOR c_bajastrunk IS
 SELECT COD_CLIENTE
 FROM  VE_RENUNCIAS
 WHERE  COD_VENDEDOR = vp_vendedor
 AND  COD_PRODUCTO = vp_producto
 AND  to_date(FEC_RENUNCIA,'DD-MON-YY') BETWEEN vp_feciniliq AND vp_fecfinliq
 AND  MONTHS_BETWEEN ( fec_renuncia, fec_alta) < 6
 UNION
 SELECT DISTINCT C.COD_CLIENTE
 FROM  CO_CARTERA C, GA_ABOTRUNK A
 WHERE  C.COD_CLIENTE = A.COD_CLIENTE
 AND  A.COD_VENDEDOR = vp_vendedor
 AND (  C.COD_PRODUCTO = vp_producto OR
   C.COD_PRODUCTO = ( SELECT prod_general FROM ge_datosgener ) )
 AND  IMPORTE_DEBE > IMPORTE_HABER
 AND  FEC_EFECTIVIDAD < ( vp_feciniliq - 60);
CURSOR c_bajastrek IS
 SELECT COD_CLIENTE
 FROM  VE_RENUNCIAS
 WHERE  COD_VENDEDOR = vp_vendedor
 AND  COD_PRODUCTO = vp_producto
 AND  to_date(FEC_RENUNCIA,'DD-MON-YY') BETWEEN vp_feciniliq AND vp_fecfinliq
 AND  MONTHS_BETWEEN ( fec_renuncia, fec_alta) < 6
 UNION
 SELECT DISTINCT C.COD_CLIENTE
 FROM  CO_CARTERA C, GA_ABOTREK A
 WHERE  C.COD_CLIENTE = A.COD_CLIENTE
 AND  A.COD_VENDEDOR = vp_vendedor
 AND (  C.COD_PRODUCTO = vp_producto OR
   C.COD_PRODUCTO = ( SELECT prod_general FROM ge_datosgener ) )
 AND  IMPORTE_DEBE > IMPORTE_HABER
 AND  FEC_EFECTIVIDAD < ( vp_feciniliq - 60);
BEGIN
IF vp_producto = 1 THEN
 OPEN c_bajascel;
 LOOP
  FETCH c_bajascel INTO v_cliente;
  EXIT WHEN c_bajascel%NOTFOUND;
 END LOOP;
 v_bajaspenal := c_bajascel%ROWCOUNT;
 CLOSE c_bajascel;
ELSIF vp_producto = 2 THEN
 OPEN c_bajasbeep;
 LOOP
  FETCH c_bajasbeep INTO v_cliente;
  EXIT WHEN c_bajasbeep%NOTFOUND;
 END LOOP;
 v_bajaspenal := c_bajasbeep%ROWCOUNT;
 CLOSE c_bajasbeep;
ELSIF vp_producto = 3 THEN
 OPEN c_bajastrunk;
 LOOP
  FETCH c_bajastrunk INTO v_cliente;
  EXIT WHEN c_bajastrunk%NOTFOUND;
 END LOOP;
 v_bajaspenal := c_bajastrunk%ROWCOUNT;
 CLOSE c_bajastrunk;
ELSIF vp_producto = 4 THEN
 OPEN c_bajastrek;
 LOOP
  FETCH c_bajastrek INTO v_cliente;
  EXIT WHEN c_bajastrek%NOTFOUND;
 END LOOP;
 v_bajaspenal := c_bajastrek%ROWCOUNT;
 CLOSE c_bajastrek;
END IF;
vp_bajas := v_bajaspenal;
END;
/
SHOW ERRORS
