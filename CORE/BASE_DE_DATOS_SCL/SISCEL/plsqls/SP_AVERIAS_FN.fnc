CREATE OR REPLACE FUNCTION SP_AVERIAS_FN(p_num_orden sp_ordenes_reparacion.NUM_ORDEN%TYPE) RETURN VARCHAR
IS

v_averias      VARCHAR2(1500);
CURSOR c_averias(pc_num_orden sp_ordenes_reparacion.NUM_ORDEN%TYPE) IS
   SELECT A.DES_AVERIA DES_AVERIA
   FROM SP_AVERIAS A, SP_AVERIAS_ORDEN B
   WHERE A.COD_AVERIA = B.COD_AVERIA AND
   A.COD_PRODUCTO = 1 AND A.COD_PRODUCTO = B.COD_PRODUCTO
   AND B.NUM_ORDEN = pc_num_orden;

BEGIN
    v_averias:=' ';
    FOR vc_averias  IN c_averias(p_num_orden) LOOP
           v_averias:=v_averias ||vc_averias.des_averia|| ', ';
        END LOOP;
    v_averias:=replace(replace(substr(v_averias,1,length(v_averias) - 2),chr(10),' '),chr(13),' ');

    RETURN v_averias;
   EXCEPTION
     WHEN OTHERS THEN
            return ('ERRROR : '|| TO_CHAR(SQLCODE) ||' ' || SQLERRM);
END;
/
SHOW ERRORS
