CREATE OR REPLACE PROCEDURE        VE_P_GETARTCTODTO(
  vp_operacion IN VARCHAR2 ,
  vp_proc IN OUT VARCHAR2 ,
  vp_tabla IN OUT VARCHAR2 ,
  vp_action IN OUT VARCHAR2 ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 ,
  vp_error IN OUT VARCHAR2 ,
  vp_venta IN OUT NUMBER )
IS
v_ctodto ve_ventadtos.cod_ctodto%TYPE;
v_item ve_ventadtos.num_item%TYPE;
v_articulo al_articulos.cod_articulo%TYPE;
CURSOR c_ventadtos IS
   SELECT  COD_CTODTO,  NUM_ITEM
     FROM  VE_VENTADTOS
    WHERE   NUM_VENTA=vp_venta and COD_ARTICULO IS NULL;
BEGIN
   vp_proc := 've_p_getartctodto';
   vp_error := '0';
   OPEN c_ventadtos;
   LOOP
      FETCH  c_ventadtos
       INTO  v_ctodto, v_item;
      EXIT WHEN c_ventadtos%NOTFOUND;
      dbms_output.put_line('Concepto: ' || v_ctodto);
      dbms_output.put_line('Item: ' || v_item);
      BEGIN
         vp_tabla := 'AL_ARTICULOS';
         vp_action := 'S';
  IF vp_operacion = 'V' THEN
            SELECT  COD_ARTICULO
              INTO  v_articulo
              FROM  AL_ARTICULOS
             WHERE  COD_CONCEPTODTO = v_ctodto;
         ELSIF vp_operacion = 'R' THEN
            SELECT  COD_ARTICULO
              INTO  v_articulo
              FROM  AL_ARTICULOS
             WHERE  COD_CONCEPTODTOALQ = v_ctodto;
  END IF;
  dbms_output.put_line('Articulo: ' || v_articulo);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
       dbms_output.put_line('No se encontraron datos');
       vp_error := '2';
       -- vp_sqlcode := sqlcode;
       -- vp_sqlerrm := sqlerrm;
       DELETE  VE_VENTADTOS
        WHERE  NUM_VENTA = vp_venta
       AND  NUM_ITEM = v_item;
      END;
      IF vp_error = '0' THEN
         BEGIN
     vp_tabla := 'VE_VENTADTOS';
     vp_action := 'U';
  UPDATE  VE_VENTADTOS
        SET  COD_ARTICULO = v_articulo
             WHERE  COD_CTODTO = v_ctodto  AND   NUM_VENTA=vp_venta  AND
                            NUM_ITEM =v_item;
         EXCEPTION
     WHEN OTHERS THEN
          vp_error := '4';
          vp_sqlcode := sqlcode;
          vp_sqlerrm := sqlerrm;
         END;
      END IF;
   END LOOP;
   CLOSE c_ventadtos;
   IF vp_error = '2' THEN
      vp_error := '0';
   END IF;
END;
/
SHOW ERRORS
