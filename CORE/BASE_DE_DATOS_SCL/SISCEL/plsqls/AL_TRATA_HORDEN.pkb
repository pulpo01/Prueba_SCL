CREATE OR REPLACE PACKAGE BODY AL_TRATA_HORDEN
IS
  PROCEDURE p_insert_hcabord(
  v_hcabord IN al_hcabecera_ordenes%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_hcabord.tip_orden = 1 THEN
          v_tabla := 'AL_HCABECERA_ORDENES1';
       ELSIF v_hcabord.tip_orden = 2 THEN
             v_tabla := 'AL_HCABECERA_ORDENES2';
       ELSIF v_hcabord.tip_orden = 3 THEN
             v_tabla := 'AL_HCABECERA_ORDENES3';
       END IF;
       v_sql := 'INSERT INTO ' || v_tabla;
       v_sql := v_sql || ' (NUM_ORDEN,';
       v_sql := v_sql || 'TIP_ORDEN,';
       v_sql := v_sql || 'COD_PROVEEDOR,';
       v_sql := v_sql || 'COD_BODEGA,';
       v_sql := v_sql || 'FEC_CREACION,';
       v_sql := v_sql || 'COD_SECTOR,';
       v_sql := v_sql || 'COD_TRANSP,';
       v_sql := v_sql || 'TIP_PEDIDO,';
       v_sql := v_sql || 'FEC_AUTORIZA,';
       v_sql := v_sql || 'FEC_EMBARQUE,';
       v_sql := v_sql || 'FEC_ARRIBO,';
       v_sql := v_sql || 'COD_MONEDA,';
       v_sql := v_sql || 'COD_ESTADO,';
       v_sql := v_sql || 'PCT_IVA,';
       v_sql := v_sql || 'TOT_ARANCEL_EST,';
       v_sql := v_sql || 'TOT_FLETE_EST,';
       v_sql := v_sql || 'TOT_SEGURO_EST,';
       v_sql := v_sql || 'TIP_ORDEN_REF,';
       v_sql := v_sql || 'NUM_ORDEN_REF,';
       v_sql := v_sql || 'USU_CREACION,';
       v_sql := v_sql || 'USU_AUTORIZA,';
       v_sql := v_sql || 'NUM_ORDEN_PROV,';
       v_sql := v_sql || 'FEC_HISTORICO,';
       v_sql := v_sql || 'TIP_NUMERACION,';
       v_sql := v_sql || 'PLAN,';
       v_sql := v_sql || 'CARGA,';
       v_sql := v_sql || 'COD_GRPCONCEPTO,NUM_ORDEN_SAP)';
       v_sql := v_sql || 'VALUES (:var1,';
       v_sql := v_sql || ':var2,';
       v_sql := v_sql || ':var3,';
       v_sql := v_sql || ':var4,';
       v_sql := v_sql || ':var5,';
       v_sql := v_sql || ':var6,';
       v_sql := v_sql || ':var7,';
       v_sql := v_sql || ':var8,';
       v_sql := v_sql || ':var9,';
       v_sql := v_sql || ':var10,';
       v_sql := v_sql || ':var11,';
       v_sql := v_sql || ':var12,';
       v_sql := v_sql || ':var13,';
       v_sql := v_sql || ':var14,';
       v_sql := v_sql || ':var15,';
       v_sql := v_sql || ':var16,';
       v_sql := v_sql || ':var17,';
       v_sql := v_sql || ':var18,';
       v_sql := v_sql || ':var19,';
       v_sql := v_sql || ':var20,';
       v_sql := v_sql || ':var21,';
       v_sql := v_sql || ':var22,';
       v_sql := v_sql || ':var77,';
       v_sql := v_sql || ':var78,';
       v_sql := v_sql || ':var79,';
       v_sql := v_sql || ':var80,';
       v_sql := v_sql || ':var81,:var82)';
       DBMS_SQL.PARSE(v_cursor,v_sql,dbms_sql.v7);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_hcabord.num_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_hcabord.tip_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_hcabord.cod_proveedor);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_hcabord.cod_bodega);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_hcabord.fec_creacion);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_hcabord.cod_sector);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_hcabord.cod_transp);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_hcabord.tip_pedido);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_hcabord.fec_autoriza);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_hcabord.fec_embarque);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var11',v_hcabord.fec_arribo);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var12',v_hcabord.cod_moneda);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var13',v_hcabord.cod_estado);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var14',v_hcabord.pct_iva);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var15',v_hcabord.tot_arancel_est);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var16',v_hcabord.tot_flete_est);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var17',v_hcabord.tot_seguro_est);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var18',v_hcabord.tip_orden_ref);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var19',v_hcabord.num_orden_ref);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var20',v_hcabord.usu_creacion);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var21',v_hcabord.usu_autoriza);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var22',v_hcabord.num_orden_prov);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var77',v_hcabord.fec_historico);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var78',v_hcabord.tip_numeracion);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var79',v_hcabord.PLAN);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var80',v_hcabord.carga);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var81',v_hcabord.cod_grpconcepto);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var82',v_hcabord.num_orden_sap);
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20109,
                                    '<ALMACEN> Insert H.Cab.ORd. '
                                    || TO_CHAR(SQLCODE));
    END p_insert_hcabord;
  PROCEDURE p_delete_hcabord(
  v_hcabord IN al_hcabecera_ordenes%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_hcabord.tip_orden = 1 THEN
          v_tabla := 'AL_HCABECERA_ORDENES1';
       ELSIF v_hcabord.tip_orden = 2 THEN
             v_tabla := 'AL_HCABECERA_ORDENES2';
       ELSIF v_hcabord.tip_orden = 3 THEN
             v_tabla := 'AL_HCABECERA_ORDENES3';
       END IF;
       v_sql := 'DELETE ' || v_tabla || ' WHERE ';
       v_sql := v_sql || 'NUM_ORDEN = :var1 ';
       v_sql := v_sql || 'AND TIP_ORDEN = :var2 ';
       DBMS_SQL.PARSE(v_cursor,v_sql,dbms_sql.v7);
       IF INSTR(v_sql,'var1 ',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_hcabord.num_orden);
       END IF;
       IF INSTR(v_sql,'var2 ',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_hcabord.tip_orden);
       END IF;
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20110,
                                    '<ALMACEN> Delete H.Cab.Ord.Guia '
                                    || TO_CHAR(SQLCODE));
    END p_delete_hcabord;
  PROCEDURE p_insert_hlinord(
  v_hlinord IN al_hlineas_ordenes%ROWTYPE )
  IS
      v_documento al_tipos_articulos.tip_articulo%TYPE;
      v_tiparticulo al_tipos_articulos.tip_articulo%TYPE;
      v_sql       VARCHAR2(1024) := NULL;
      v_tabla           VARCHAR2(30) := NULL;
      v_filas           INTEGER;
      v_cursor          INTEGER;
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_hlinord.tip_orden = 1 THEN
          v_tabla := 'AL_HLINEAS_ORDENES1';
       ELSIF v_hlinord.tip_orden = 2 THEN
             v_tabla := 'AL_HLINEAS_ORDENES2';
       ELSIF v_hlinord.tip_orden = 3 THEN
             v_tabla := 'AL_HLINEAS_ORDENES3';
       END IF;
       DBMS_OUTPUT.PUT_LINE('cod_causa ' || TO_CHAR(v_hlinord.cod_causa));
       v_sql := 'INSERT INTO ' || v_tabla || ' (NUM_ORDEN,';
       v_sql := v_sql || 'TIP_ORDEN,';
       v_sql := v_sql || 'NUM_LINEA,';
       v_sql := v_sql || 'COD_ARTICULO,';
       v_sql := v_sql || 'CAN_ORDEN,';
       v_sql := v_sql || 'CAN_SERVIDA,';
       v_sql := v_sql || 'COD_CAUSA,';
       v_sql := v_sql || 'CAN_SERIES,';
       v_sql := v_sql || 'TIP_STOCK,';
       v_sql := v_sql || 'COD_USO,';
       v_sql := v_sql || 'COD_ESTADO,';
       v_sql := v_sql || 'PRC_UNIDAD,';
       v_sql := v_sql || 'NUM_LINEA_REF,';
       v_sql := v_sql || 'TIP_MOVIMIENTO,';
       v_sql := v_sql || 'CAN_ORDEN_ING,';
       v_sql := v_sql || 'NUM_DESDE,';
       v_sql := v_sql || 'NUM_HASTA,';
       v_sql := v_sql || 'FEC_HISTORICO,';
       v_sql := v_sql || 'PRC_FF,';
       v_sql := v_sql || 'PRC_ADIC,';
       v_sql := v_sql || 'COD_PLAZA,';
       v_sql := v_sql || 'COD_METODO_CARGA,';
       v_sql := v_sql || 'COD_GRPCONCEPTO)';
       v_sql := v_sql || ' VALUES (:var1,';
       v_sql := v_sql || ':var2,';
       v_sql := v_sql || ':var3,';
       v_sql := v_sql || ':var4,';
       v_sql := v_sql || ':var5,';
       v_sql := v_sql || ':var6,';
       v_sql := v_sql || ':var7,';
       v_sql := v_sql || ':var8,';
       v_sql := v_sql || ':var9,';
       v_sql := v_sql || ':var10,';
       v_sql := v_sql || ':var11,';
       v_sql := v_sql || ':var12,';
       v_sql := v_sql || ':var13,';
       v_sql := v_sql || ':var14,';
       v_sql := v_sql || ':var15,';
       v_sql := v_sql || ':var16,';
       v_sql := v_sql || ':var17,';
       v_sql := v_sql || ':var77,';
       v_sql := v_sql || ':var78,';
       v_sql := v_sql || ':var79,';
       v_sql := v_sql || ':var80,';
       v_sql := v_sql || ':var81,';
       v_sql := v_sql || ':var82)';
       DBMS_SQL.PARSE(v_cursor,v_sql,dbms_sql.v7);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_hlinord.num_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_hlinord.tip_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_hlinord.num_linea);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_hlinord.cod_articulo);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_hlinord.can_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_hlinord.can_servida);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_hlinord.cod_causa);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_hlinord.can_series);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_hlinord.tip_stock);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_hlinord.cod_uso);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var11',v_hlinord.cod_estado);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var12',v_hlinord.prc_unidad);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var13',v_hlinord.num_linea_ref);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var14',v_hlinord.tip_movimiento);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var15',v_hlinord.can_orden_ing);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var16',v_hlinord.num_desde);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var17',v_hlinord.num_hasta);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var77',v_hlinord.fec_historico);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var78',v_hlinord.prc_ff);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var79',v_hlinord.prc_adic);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var80',v_hlinord.COD_PLAZA);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var81',v_hlinord.COD_METODO_CARGA);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var82',v_hlinord.cod_grpconcepto);
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN solapa THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20126,'Error controlado en VB');
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20112,'<ALMACEN> Error insert Lineas Ordenes
  '
                                    || TO_CHAR(SQLCODE));
    END p_insert_hlinord;
  PROCEDURE p_delete_hlinord(
  v_hlinord IN al_hlineas_ordenes%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_hlinord.tip_orden = 1 THEN
          v_tabla := 'AL_HLINEAS_ORDENES1';
       ELSIF v_hlinord.tip_orden = 2 THEN
             v_tabla := 'AL_HLINEAS_ORDENES2';
       ELSIF v_hlinord.tip_orden = 3 THEN
             v_tabla := 'AL_HLINEAS_ORDENES3';
       END IF;
       v_sql := 'DELETE ' || v_tabla || ' WHERE ';
       v_sql := v_sql || 'NUM_ORDEN = :var1 ';
       v_sql := v_sql || 'AND TIP_ORDEN = :var2 ';
       v_sql := v_sql || 'AND NUM_LINEA = :var3 ';
       DBMS_SQL.PARSE(v_cursor,v_sql,dbms_sql.v7);
       IF INSTR(v_sql,'var1 ',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE (v_cursor,'var1',v_hlinord.num_orden);
       END IF;
       IF INSTR(v_sql,'var2 ',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE (v_cursor,'var2',v_hlinord.tip_orden);
       END IF;
       IF INSTR(v_sql,'var3 ',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE (v_cursor,'var3',v_hlinord.num_linea);
       END IF;
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR (v_cursor);
    EXCEPTION
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20113,
                                    '<ALMACEN> Delete Lin.Ord. '
                                    || TO_CHAR(SQLCODE));
    END p_delete_hlinord;
  PROCEDURE p_insert_hserord(
  v_hserord IN al_hseries_ordenes%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_hserord.tip_orden = 2 THEN
          v_tabla := 'AL_HSERIES_ORDENES2';
       ELSIF v_hserord.tip_orden = 3 THEN
              v_tabla := 'AL_HSERIES_ORDENES3';
       END IF;
       v_sql := 'INSERT INTO ' || v_tabla || ' (NUM_ORDEN,TIP_ORDEN,';
       v_sql := v_sql || 'NUM_LINEA,NUM_SERIE,NUM_SERIEMEC,';
       v_sql := v_sql || 'COD_PRODUCTO,COD_CENTRAL,CAP_CODE,';
       v_sql := v_sql || 'NUM_TELEFONO,COD_SUBALM,FEC_HISTORICO,COD_CAT,IND_TELEFONO,PLAN,CARGA)';
       v_sql := v_sql || ' VALUES (:var1,';
       v_sql := v_sql || ':var2,:var3,:var4,:var5,:var6,:var7,';
       v_sql := v_sql || ':var8,:var9,:var10,:var77,:var75,:var78,:var79,:var80)';
       DBMS_SQL.PARSE(v_cursor,v_sql,dbms_sql.v7);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_hserord.num_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_hserord.tip_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_hserord.num_linea);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_hserord.num_serie);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_hserord.num_seriemec);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_hserord.cod_producto);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_hserord.cod_central);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_hserord.cap_code);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_hserord.num_telefono);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_hserord.cod_subalm);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var77',v_hserord.fec_historico);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var75',v_hserord.cod_cat);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var78',v_hserord.ind_telefono);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var79',v_hserord.PLAN);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var80',v_hserord.carga);
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20115,
                                    '<ALMACEN> Insert Ser.Ord. '
                                    || TO_CHAR(SQLCODE));
    END p_insert_hserord;
  PROCEDURE p_delete_hserord(
  v_hserord IN al_hseries_ordenes%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_hserord.tip_orden = 2 THEN
          v_tabla := 'AL_HSERIES_ORDENES2';
       ELSIF v_hserord.tip_orden = 3 THEN
             v_tabla := 'AL_HSERIES_ORDENES3';
       END IF;
       v_sql := 'DELETE ' || v_tabla || ' WHERE ';
       v_sql := v_sql || 'NUM_ORDEN = :var1 ';
       v_sql := v_sql || 'AND TIP_ORDEN = :var2 ';
       v_sql := v_sql || 'AND NUM_LINEA = :var3 ';
       v_sql := v_sql || 'AND NUM_SERIE = :var4 ';
       DBMS_SQL.PARSE (v_cursor,v_sql,dbms_sql.v7);
       IF INSTR(v_sql,'var1',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE (v_cursor,'var1',v_hserord.num_orden);
          DBMS_SQL.BIND_VARIABLE (v_cursor,'var2',v_hserord.tip_orden);
          DBMS_SQL.BIND_VARIABLE (v_cursor,'var3',v_hserord.num_linea);
          DBMS_SQL.BIND_VARIABLE (v_cursor,'var4',v_hserord.num_serie);
       END IF;
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20116,
                                    '<ALMACEN> Delete Ser.Ord. '
                                    || TO_CHAR(SQLCODE));
    END p_delete_hserord ;
END AL_TRATA_HORDEN; 
/
SHOW ERRORS
