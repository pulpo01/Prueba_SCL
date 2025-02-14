CREATE OR REPLACE PROCEDURE        VE_P_GETINFOABO(
  vp_producto IN NUMBER ,
  vp_abonado IN NUMBER ,
  vp_indrenta IN NUMBER ,
  vp_cliente OUT NUMBER ,
  vp_tipventa OUT NUMBER ,
  vp_vendedor OUT NUMBER ,
  vp_venderaiz OUT NUMBER ,
  vp_plantarif OUT VARCHAR2 ,
  vp_venta OUT NUMBER ,
  vp_proc IN OUT VARCHAR2 ,
  vp_tabla IN OUT VARCHAR2 ,
  vp_action IN OUT VARCHAR2 ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 ,
  vp_error IN OUT VARCHAR2 )
IS
v_tipventa varchar2(1);
BEGIN
   vp_proc := 've_p_getinfoabo';
   vp_error := '0';
   IF vp_producto = 1 THEN
      IF vp_indrenta = 1 THEN
  vp_tabla := 'GA_ABORENT';
  vp_action := 'S';
         SELECT  COD_CLIENTE, IND_PROCALTA,
                 COD_VENDEDOR, COD_VENDEDOR_AGENTE,
                 COD_PLANTARIF, NUM_VENTA
           INTO  vp_cliente, vp_tipventa,
                 vp_vendedor, vp_venderaiz,
                 vp_plantarif, vp_venta
           FROM  GA_ABORENT
          WHERE  NUM_ABONADO = vp_abonado;
      ELSE
  	  	  vp_tabla := 'GA_ABOCEL';
  		  vp_action := 'S';
		  BEGIN
         	   SELECT  COD_CLIENTE, IND_PROCALTA,
                 COD_VENDEDOR, COD_VENDEDOR_AGENTE,
                 COD_PLANTARIF, NUM_VENTA
           	   INTO  vp_cliente, vp_tipventa,
                 vp_vendedor, vp_venderaiz,
                 vp_plantarif, vp_venta
               FROM  GA_ABOCEL
               WHERE  NUM_ABONADO = vp_abonado;
		  EXCEPTION
		  	   WHEN NO_DATA_FOUND THEN
			   BEGIN
           	   		SELECT  COD_CLIENTE, IND_PROCALTA,
                 			COD_VENDEDOR, COD_VENDEDOR_AGENTE,
                 			COD_PLANTARIF, NUM_VENTA
           	   		INTO  vp_cliente, v_tipventa,
                 		  vp_vendedor, vp_venderaiz,
                 		  vp_plantarif, vp_venta
               		FROM  GA_ABOAMIST
               		WHERE  NUM_ABONADO = vp_abonado;
				   vp_tipventa:=to_number(v_tipventa);
				EXCEPTION
					WHEN OTHERS THEN
						vp_error := '4';
						vp_sqlcode := sqlcode;
					    vp_sqlerrm := sqlerrm;
				END;
		  END;
      END IF;
   ELSIF vp_producto = 2 THEN
      vp_tabla := 'GA_ABOBEEP';
      vp_action := 'S';
      			SELECT  COD_CLIENTE, IND_PROCALTA,
              			COD_VENDEDOR, COD_VENDEDOR_AGENTE,
              			COD_PLANTARIF, NUM_VENTA
        		INTO  vp_cliente, vp_tipventa,
              		  vp_vendedor, vp_venderaiz,
              		  vp_plantarif, vp_venta
        FROM  GA_ABOBEEP
       WHERE  NUM_ABONADO = vp_abonado;
   ELSIF vp_producto = 3 THEN
      vp_tabla := 'GA_ABOTRUNK';
      vp_action := 'S';
      SELECT  COD_CLIENTE, IND_PROCALTA,
              COD_VENDEDOR, COD_VENDEDOR_AGENTE,
              COD_PLANTARIF, NUM_VENTA
        INTO  vp_cliente, vp_tipventa,
              vp_vendedor, vp_venderaiz,
              vp_plantarif, vp_venta
        FROM  GA_ABOTRUNK
       WHERE  NUM_ABONADO = vp_abonado;
   ELSIF vp_producto = 4 THEN
      vp_tabla := 'GA_ABOTREK';
      vp_action := 'S';
      SELECT  COD_CLIENTE, IND_PROCALTA,
              COD_VENDEDOR, COD_VENDEDOR_AGENTE,
              COD_PLANTARIF, NUM_VENTA
        INTO  vp_cliente, vp_tipventa,
              vp_vendedor, vp_venderaiz,
              vp_plantarif, vp_venta
        FROM  GA_ABOTREK
       WHERE  NUM_ABONADO = vp_abonado;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
 vp_error := '4';
 vp_sqlcode := sqlcode;
 vp_sqlerrm := sqlerrm;
END;
/
SHOW ERRORS
