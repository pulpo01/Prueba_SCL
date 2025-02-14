CREATE OR REPLACE PACKAGE BODY SISCEL.Al_Trata_Orden
IS
  Procedure p_insert_cabord(
  v_cabord IN AL_CABECERA_ORDENES%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_cabord.tip_orden = 1 THEN
          v_tabla    := 'AL_CABECERA_ORDENES1';
       ELSIF v_cabord.tip_orden = 2 THEN
             v_tabla := 'AL_CABECERA_ORDENES2';
       ELSIF v_cabord.tip_orden = 3 THEN
             v_tabla := 'AL_CABECERA_ORDENES3';
       END IF;
       v_sentencia := 'INSERT INTO ' || v_tabla;
       v_sentencia := v_sentencia || ' (NUM_ORDEN,';
      v_sentencia := v_sentencia || 'TIP_ORDEN,';
       v_sentencia := v_sentencia || 'COD_PROVEEDOR,';
       v_sentencia := v_sentencia || 'COD_BODEGA,';
       v_sentencia := v_sentencia || 'FEC_CREACION,';
       v_sentencia := v_sentencia || 'COD_SECTOR,';
       v_sentencia := v_sentencia || 'COD_TRANSP,';
       v_sentencia := v_sentencia || 'TIP_PEDIDO,';
       v_sentencia := v_sentencia || 'FEC_AUTORIZA,';
       v_sentencia := v_sentencia || 'FEC_EMBARQUE,';
       v_sentencia := v_sentencia || 'FEC_ARRIBO,';
       v_sentencia := v_sentencia || 'COD_MONEDA,';
       v_sentencia := v_sentencia || 'COD_ESTADO,';
       v_sentencia := v_sentencia || 'PCT_IVA,';
       v_sentencia := v_sentencia || 'TOT_ARANCEL_EST,';
       v_sentencia := v_sentencia || 'TOT_FLETE_EST,';
       v_sentencia := v_sentencia || 'TOT_SEGURO_EST,';
       v_sentencia := v_sentencia || 'TIP_ORDEN_REF,';
       v_sentencia := v_sentencia || 'NUM_ORDEN_REF,';
       v_sentencia := v_sentencia || 'USU_CREACION,';
       v_sentencia := v_sentencia || 'USU_AUTORIZA,';
       v_sentencia := v_sentencia || 'NUM_ORDEN_PROV,';
       v_sentencia := v_sentencia || 'TIP_NUMERACION,';
       v_sentencia := v_sentencia || 'PLAN,';
       v_sentencia := v_sentencia || 'CARGA,';
       v_sentencia := v_sentencia || 'COD_GRPCONCEPTO,';-- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
       v_sentencia := v_sentencia || 'NUM_ORDEN_SAP)';
       v_sentencia := v_sentencia || 'VALUES (:var1,';
       v_sentencia := v_sentencia || ':var2,';
       v_sentencia := v_sentencia || ':var3,';
       v_sentencia := v_sentencia || ':var4,';
       v_sentencia := v_sentencia || ':var5,';
       v_sentencia := v_sentencia || ':var6,';
       v_sentencia := v_sentencia || ':var7,';
       v_sentencia := v_sentencia || ':var8,';
       v_sentencia := v_sentencia || ':var9,';
       v_sentencia := v_sentencia || ':var10,';
       v_sentencia := v_sentencia || ':var11,';
       v_sentencia := v_sentencia || ':var12,';
       v_sentencia := v_sentencia || ':var13,';
       v_sentencia := v_sentencia || ':var14,';
       v_sentencia := v_sentencia || ':var15,';
       v_sentencia := v_sentencia || ':var16,';
       v_sentencia := v_sentencia || ':var17,';
       v_sentencia := v_sentencia || ':var18,';
       v_sentencia := v_sentencia || ':var19,';
       v_sentencia := v_sentencia || ':var20,';
       v_sentencia := v_sentencia || ':var21,';
       v_sentencia := v_sentencia || ':var22,';
       v_sentencia := v_sentencia || ':var23,';
       v_sentencia := v_sentencia || ':var24,';
       v_sentencia := v_sentencia || ':var25,';
       v_sentencia := v_sentencia || ':var26,';
       v_sentencia := v_sentencia || ':var27)';  --P-MIX-09003

       DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_cabord.num_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_cabord.tip_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_cabord.cod_proveedor);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_cabord.cod_bodega);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_cabord.fec_creacion);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_cabord.cod_sector);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_cabord.cod_transp);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_cabord.tip_pedido);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_cabord.fec_autoriza);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_cabord.fec_embarque);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var11',v_cabord.fec_arribo);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var12',v_cabord.cod_moneda);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var13',v_cabord.cod_estado);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var14',v_cabord.pct_iva);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var15',v_cabord.tot_arancel_est);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var16',v_cabord.tot_flete_est);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var17',v_cabord.tot_seguro_est);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var18',v_cabord.tip_orden_ref);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var19',v_cabord.num_orden_ref);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var20',v_cabord.usu_creacion);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var21',v_cabord.usu_autoriza);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var22',v_cabord.num_orden_prov);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var23',v_cabord.tip_numeracion);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var24',v_cabord.PLAN);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var25',v_cabord.carga);
--       dbms_sql.bind_variable(v_cursor,'var26',v_cabord.cod_grpconcepto); --  Modificado 11/08/2004 por Contabilización CDMA por Tecnología
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var26',Al_Busca_Grupo_Bodega_Fn(v_cabord.cod_bodega));-- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var27',v_cabord.num_orden_sap);

       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN OTHERS THEN

      -- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador

gSqlERRM := sqlerrm;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_insert_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,1,50);
gvError   := substr(gSqlERRM,51,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,101,50);
gvError   := substr(gSqlERRM,151,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,201,50);
gvError   := substr(gSqlERRM,251,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,301,50);
gvError   := substr(gSqlERRM,351,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,401,50);
gvError   := substr(gSqlERRM,451,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

-- GA_ERRORES

           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
            END IF;
           RAISE_APPLICATION_ERROR (-20109,
                                    '<ALMACEN> Insert Cab.ORd. '
                                    || SQLERRM);
    END p_insert_cabord;

/***********************************************************************/


  Procedure p_delete_cabord(
  v_cabord IN AL_CABECERA_ORDENES%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_cabord.tip_orden = 1 THEN
          v_tabla    := 'AL_CABECERA_ORDENES1';
       ELSIF v_cabord.tip_orden = 2 THEN
             v_tabla := 'AL_CABECERA_ORDENES2';
       ELSIF v_cabord.tip_orden = 3 THEN
             v_tabla := 'AL_CABECERA_ORDENES3';
       END IF;
       v_sentencia := 'DELETE ' || v_tabla || ' WHERE ';
       v_sentencia := v_sentencia || 'NUM_ORDEN = :var1 ';
       v_sentencia := v_sentencia || 'AND TIP_ORDEN = :var2 ';
       DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
       IF INSTR(v_sentencia,'var1 ',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_cabord.num_orden);
       END IF;
       IF INSTR(v_sentencia,'var2 ',1,1) <> 0 THEN
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_cabord.tip_orden);
       END IF;
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN OTHERS THEN

      -- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador

gSqlERRM := sqlerrm;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_delete_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,1,50);
gvError   := substr(gSqlERRM,51,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,101,50);
gvError   := substr(gSqlERRM,151,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,201,50);
gvError   := substr(gSqlERRM,251,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,301,50);
gvError   := substr(gSqlERRM,351,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,401,50);
gvError   := substr(gSqlERRM,451,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

-- GA_ERRORES
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20110,
                                    '<ALMACEN> Delete Cab.Ord.Guia '
                                    || TO_CHAR(SQLCODE));
    END p_delete_cabord;

/***********************************************************************/

  Procedure p_update_cabord(
  v_cabord IN OUT AL_CABECERA_ORDENES%ROWTYPE )
  IS
    vp_cod_proveedor AL_CABECERA_ORDENES.cod_proveedor%TYPE;
        vp_cod_bodega    AL_CABECERA_ORDENES.cod_bodega%TYPE;
        vp_tip_proveedor AL_PROVEEDORES.ind_tiproveedor%TYPE;
    BEGIN

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := 'Inicio Proceso';
gvError   := 'N/A';
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_cabord.tip_orden = 1 THEN
          v_tabla := 'AL_CABECERA_ORDENES1';
       ELSIF v_cabord.tip_orden = 2 THEN
          v_tabla := 'AL_CABECERA_ORDENES2';
       ELSIF v_cabord.tip_orden = 3 THEN
          v_tabla := 'AL_CABECERA_ORDENES3';
       END IF;
       v_sentencia := 'UPDATE ' || v_tabla;
       IF v_cabord.cod_proveedor IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_PROVEEDOR = :var1 ';
       END IF;
       IF v_cabord.cod_bodega IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_BODEGA = :var2 ';
       END IF;
       IF v_cabord.fec_creacion IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'FEC_CREACION = :var3 ';
       END IF;
       IF v_cabord.cod_sector IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_SECTOR = :var4 ';
       END IF;
       IF v_cabord.cod_transp IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_TRANSP = :var5 ';
       END IF;
       IF v_cabord.tip_pedido IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TIP_PEDIDO = :var6 ';
       END IF;
       IF v_cabord.fec_autoriza IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'FEC_AUTORIZA = :var7 ';
       END IF;
       IF v_cabord.fec_embarque IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'FEC_EMBARQUE = :var8 ';
       END IF;
       IF v_cabord.fec_arribo IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'FEC_ARRIBO = :var9 ';
       END IF;
       IF v_cabord.cod_moneda IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_MONEDA = :var10 ';
       END IF;
       IF v_cabord.cod_estado IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_ESTADO = :var11 ';
       END IF;
       IF v_cabord.pct_iva IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'PCT_IVA = :var12 ';
       END IF;
       IF v_cabord.tot_arancel_est IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TOT_ARANCEL_EST = :var13 ';
       END IF;
       IF v_cabord.tot_flete_est IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TOT_FLETE_EST = :var14 ';
       END IF;
       IF v_cabord.tot_seguro_est IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TOT_SEGURO_EST = :var15 ';
       END IF;
       IF v_cabord.tip_orden_ref IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TIP_ORDEN_REF = :var16 ';
       END IF;
       IF v_cabord.num_orden_ref IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_ORDEN_REF = :var17 ';
       END IF;
       IF v_cabord.usu_creacion IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'USU_CREACION = :var18 ';
       END IF;
       IF v_cabord.usu_autoriza IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'USU_AUTORIZA = :var19 ';
       END IF;
       IF v_cabord.num_orden_prov IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_ORDEN_PROV = :var20 ';
       END IF;
        IF v_cabord.tip_numeracion IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TIP_NUMERACION = :var24 ';
       END IF;
        IF v_cabord.PLAN IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'PLAN = :var25 ';
       END IF;
       IF v_cabord.carga IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'CARGA = :var26 ';
       END IF;
       -- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
       IF v_cabord.cod_grpconcepto IS NOT NULL OR (v_cabord.cod_estado = 'CE'  AND v_cabord.tip_orden = 2)THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_GRPCONCEPTO = :var27 ';
       END IF;
       IF v_cabord.num_orden_sap IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_ORDEN_SAP = :var28 ';
       END IF;


       v_sentencia := v_sentencia || ' WHERE NUM_ORDEN = :var22 ';
       v_sentencia := v_sentencia || ' AND TIP_ORDEN = :var23 ';
       IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
          DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
          IF INSTR(v_sentencia,'var1 ',1,1) <> 0 THEN
             IF v_cabord.cod_proveedor = -1 THEN
                v_cabord.cod_proveedor := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_cabord.cod_proveedor);
          END IF;
          IF INSTR(v_sentencia,'var2 ',1,1) <> 0 THEN
             IF v_cabord.cod_bodega = -1 THEN
                v_cabord.cod_bodega := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_cabord.cod_bodega);
          END IF;
          IF INSTR(v_sentencia,'var3 ',1,1) <> 0 THEN
             IF v_cabord.fec_creacion = TO_DATE('01011001','ddmmyyyy') THEN
                v_cabord.fec_creacion := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_cabord.fec_creacion);
          END IF;
          IF INSTR(v_sentencia,'var4 ',1,1) <> 0 THEN
             IF v_cabord.cod_sector = -1 THEN
                v_cabord.cod_sector := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_cabord.cod_sector);
          END IF;
          IF INSTR(v_sentencia,'var5 ',1,1) <> 0 THEN
             IF v_cabord.cod_transp = -1 THEN
                v_cabord.cod_transp := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_cabord.cod_transp);
          END IF;
          IF INSTR(v_sentencia,'var6 ',1,1) <> 0 THEN
             IF v_cabord.tip_pedido = -1 THEN
                v_cabord.tip_pedido := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_cabord.tip_pedido);
          END IF;
          IF INSTR(v_sentencia,'var7 ',1,1) <> 0 THEN
             IF v_cabord.fec_autoriza = TO_DATE('01011001','ddmmyyyy') THEN
                v_cabord.fec_autoriza := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_cabord.fec_autoriza);
          END IF;
          IF INSTR(v_sentencia,'var8 ',1,1) <> 0 THEN
             IF v_cabord.fec_embarque = TO_DATE('01011001','ddmmyyyy') THEN
                v_cabord.fec_embarque := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_cabord.fec_embarque);
          END IF;
          IF INSTR(v_sentencia,'var9 ',1,1) <> 0 THEN
             IF v_cabord.fec_arribo = TO_DATE('01011001','ddmmyyyy') THEN
                v_cabord.fec_arribo := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_cabord.fec_arribo);
          END IF;
          IF INSTR(v_sentencia,'var10 ',1,1) <> 0 THEN
             IF v_cabord.cod_moneda = '' THEN
                v_cabord.cod_moneda := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_cabord.cod_moneda);
          END IF;
          IF INSTR(v_sentencia,'var11 ',1,1) <> 0 THEN
             IF v_cabord.cod_estado = '' THEN
                v_cabord.cod_estado := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var11',v_cabord.cod_estado);
          END IF;
          IF INSTR(v_sentencia,'var12 ',1,1) <> 0 THEN
             IF v_cabord.pct_iva = -1 THEN
                v_cabord.pct_iva := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var12',v_cabord.pct_iva);
          END IF;
          IF INSTR(v_sentencia,'var13 ',1,1) <> 0 THEN
             IF v_cabord.tot_arancel_est = -1 THEN
                v_cabord.tot_arancel_est := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var13',v_cabord.tot_arancel_est);
          END IF;
          IF INSTR(v_sentencia,'var14 ',1,1) <> 0 THEN
             IF v_cabord.tot_flete_est = -1 THEN
                v_cabord.tot_flete_est := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var14',v_cabord.tot_flete_est);
          END IF;
          IF INSTR(v_sentencia,'var15 ',1,1) <> 0 THEN
             IF v_cabord.tot_seguro_est = -1 THEN
                v_cabord.tot_seguro_est := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var15',v_cabord.tot_seguro_est);
          END IF;
          IF INSTR(v_sentencia,'var16 ',1,1) <> 0 THEN
             IF v_cabord.tip_orden_ref = -1 THEN
                v_cabord.tip_orden_ref := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var16',v_cabord.tip_orden_ref);
          END IF;
          IF INSTR(v_sentencia,'var17 ',1,1) <> 0 THEN
             IF v_cabord.num_orden_ref = -1 THEN
                v_cabord.num_orden_ref := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var17',v_cabord.num_orden_ref);
          END IF;
          IF INSTR(v_sentencia,'var18 ',1,1) <> 0 THEN
             IF v_cabord.usu_creacion = '' THEN
                v_cabord.usu_creacion := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var18',v_cabord.usu_creacion);
          END IF;
          IF INSTR(v_sentencia,'var19 ',1,1) <> 0 THEN
             IF v_cabord.usu_autoriza = '' THEN
                v_cabord.usu_autoriza := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var19',v_cabord.usu_autoriza);
          END IF;
          IF INSTR(v_sentencia,'var20 ',1,1) <> 0 THEN
             IF v_cabord.num_orden_prov = '' THEN
                v_cabord.num_orden_prov := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var20',v_cabord.num_orden_prov);
          END IF;
          IF INSTR(v_sentencia,'var22 ',1,1) <> 0 THEN
             IF v_cabord.num_orden = -1 THEN
                v_cabord.num_orden := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var22',v_cabord.num_orden);
          END IF;
          IF INSTR(v_sentencia,'var23',1,1) <> 0 THEN
             IF v_cabord.tip_orden = -1 THEN
                v_cabord.tip_orden := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var23',v_cabord.tip_orden);
          END IF;
          IF INSTR(v_sentencia,'var24',1,1) <> 0 THEN
             IF v_cabord.tip_numeracion = -1 THEN
                v_cabord.tip_numeracion := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var24',v_cabord.tip_numeracion);
          END IF;
          IF INSTR(v_sentencia,'var25',1,1) <> 0 THEN
             IF v_cabord.PLAN = '' THEN
                v_cabord.PLAN := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var25',v_cabord.PLAN);
          END IF;
          IF INSTR(v_sentencia,'var26',1,1) <> 0 THEN
             IF v_cabord.carga = -1 THEN
                v_cabord.carga := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var26',v_cabord.carga);
          END IF;
          -- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
          IF INSTR(v_sentencia,'var27',1,1) <> 0 THEN
             IF v_cabord.cod_grpconcepto = -1 THEN
                v_cabord.cod_grpconcepto := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var27',v_cabord.cod_grpconcepto);
          END IF;
          IF INSTR(v_sentencia,'var28',1,1) <> 0 THEN
             IF v_cabord.num_orden_sap = -1 THEN
                v_cabord.num_orden_sap := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var28',v_cabord.num_orden_sap);
          END IF;

gvCodigo  := gvCodigo + 1;
gvProceso := 'Antes ejecución sentencia ';
gvTabla   := ' ';
gvError   := ' ';
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

          v_filas := DBMS_SQL.EXECUTE(v_cursor);
gvCodigo  := gvCodigo + 1;
gvProceso := 'despues ejecución sentencia ';
gvTabla   := ' ';
gvError   := ' ';
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);
       END IF;
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
                   -- Modificado Diciembre 2002 Por C.A.Z.
           IF v_cabord.cod_estado = 'PE'  AND v_cabord.tip_orden = 1 THEN
                   SELECT COD_PROVEEDOR, COD_BODEGA
                   INTO vp_cod_proveedor, vp_cod_bodega
                   FROM AL_CABECERA_ORDENES1
                   WHERE NUM_ORDEN = v_cabord.num_orden;
                   SELECT IND_TIPROVEEDOR INTO vp_tip_proveedor
                   FROM AL_PROVEEDORES
                   WHERE COD_PROVEEDOR = vp_cod_proveedor;
                        IF vp_tip_proveedor = 1 THEN

gvCodigo  := gvCodigo + 1;
gvProceso := 'Tip. Proveedor = 1 ';
gvTabla   := 'p_ingreso_notapedido';
gvError   := 'Datos ' || vp_cod_proveedor || ' ' || vp_cod_bodega || ' ' || v_cabord.num_orden;
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

                          p_ingreso_notapedido(vp_cod_proveedor,vp_cod_bodega,v_cabord.num_orden);
                        END IF;
           END IF;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := 'Proceso Final';
gvError   := 'Sin Error';
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

    EXCEPTION
      WHEN OTHERS THEN

-- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador

gSqlERRM := sqlerrm;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,1,50);
gvError   := substr(gSqlERRM,51,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,101,50);
gvError   := substr(gSqlERRM,151,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,201,50);
gvError   := substr(gSqlERRM,251,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,301,50);
gvError   := substr(gSqlERRM,351,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_cabord.num_orden;
gvTabla   := substr(gSqlERRM,401,50);
gvError   := substr(gSqlERRM,451,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'Detalle Sentencia ';
gvTabla   := substr(v_sentencia ,1,50);
gvError   := substr(v_sentencia ,100,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'Detalle Sentencia ';
gvTabla   := substr(v_sentencia ,101,50);
gvError   := substr(v_sentencia ,150,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

-- GA_ERRORES

           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           IF SQLCODE = -20135 THEN
              RAISE_APPLICATION_ERROR (-20135,'');
           ELSE
              RAISE_APPLICATION_ERROR (-20111,
                                    '<ALMACEN> Update Cab.Ord. '
                                    || TO_CHAR(SQLCODE) || ' ver tabla GA_ERRORES');
           END IF;
    END p_update_cabord;

/*******************************************************************/
  Procedure p_insert_linord(
  v_linord IN AL_LINEAS_ORDENES%ROWTYPE )
  IS
      v_documento       AL_TIPOS_ARTICULOS.tip_articulo%TYPE;
      v_tiparticulo     AL_TIPOS_ARTICULOS.tip_articulo%TYPE;
      v_sentencia       VARCHAR2(1024) := NULL;
      v_tabla           VARCHAR2(30) := NULL;
      v_filas           INTEGER;
      v_cursor          INTEGER;
      CError            PLS_INTEGER:=0;
    BEGIN
       IF v_linord.tip_orden = 2 THEN
          p_obtiene_documento(v_documento);
          p_obtiene_tiparticulo (v_linord.cod_articulo,v_tiparticulo);
          IF v_documento = v_tiparticulo THEN
             p_valida_rango (v_linord.cod_articulo,
                             v_linord.num_desde,
                             v_linord.num_hasta,
                                                         v_linord.NUM_ORDEN,   /*AARM, ENERO 2003*/
                                                     v_linord.tip_orden,   /*AARM, ENERO 2003*/
                                                         v_linord.cod_plaza ); /*AARM, ENERO 2003*/
          END IF;
       END IF;
          v_cursor := DBMS_SQL.OPEN_CURSOR;
          IF v_linord.tip_orden = 1 THEN
             v_tabla    := 'AL_LINEAS_ORDENES1';
             ELSIF v_linord.tip_orden = 2 THEN
               v_tabla := 'AL_LINEAS_ORDENES2';
             ELSIF v_linord.tip_orden = 3 THEN
               v_tabla := 'AL_LINEAS_ORDENES3';
          END IF;
          v_sentencia := 'INSERT INTO ' || v_tabla || ' (NUM_ORDEN,';
          v_sentencia := v_sentencia || 'TIP_ORDEN,';
          v_sentencia := v_sentencia || 'NUM_LINEA,';
          v_sentencia := v_sentencia || 'COD_ARTICULO,';
          v_sentencia := v_sentencia || 'CAN_ORDEN,';
          v_sentencia := v_sentencia || 'CAN_SERVIDA,';
          v_sentencia := v_sentencia || 'COD_CAUSA,';
          v_sentencia := v_sentencia || 'CAN_SERIES,';
          v_sentencia := v_sentencia || 'TIP_STOCK,';
          v_sentencia := v_sentencia || 'COD_USO,';
          v_sentencia := v_sentencia || 'COD_ESTADO,';
          v_sentencia := v_sentencia || 'PRC_UNIDAD,';
          v_sentencia := v_sentencia || 'NUM_LINEA_REF,';
          v_sentencia := v_sentencia || 'TIP_MOVIMIENTO,';
          v_sentencia := v_sentencia || 'CAN_ORDEN_ING,';
          v_sentencia := v_sentencia || 'NUM_DESDE,';
          v_sentencia := v_sentencia || 'NUM_HASTA,';
          v_sentencia := v_sentencia || 'PRC_FF,';
          v_sentencia := v_sentencia || 'PRC_ADIC,';
          v_sentencia := v_sentencia || 'NUM_SEC_LOCA,';
          v_sentencia := v_sentencia || 'COD_PLAZA,';/*AARM, Agrego el Codigo de la Plaza*/
          v_sentencia := v_sentencia || 'COD_METODO_CARGA,';-- oct 2003 Ingreso MAsivo
          v_sentencia := v_sentencia || 'COD_GRPCONCEPTO)';-- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
          v_sentencia := v_sentencia || ' VALUES (:var1,';
          v_sentencia := v_sentencia || ':var2,';
          v_sentencia := v_sentencia || ':var3,';
          v_sentencia := v_sentencia || ':var4,';
          v_sentencia := v_sentencia || ':var5,';
          v_sentencia := v_sentencia || ':var6,';
          v_sentencia := v_sentencia || ':var7,';
          v_sentencia := v_sentencia || ':var8,';
          v_sentencia := v_sentencia || ':var9,';
          v_sentencia := v_sentencia || ':var10,';
          v_sentencia := v_sentencia || ':var11,';
          v_sentencia := v_sentencia || ':var12,';
          v_sentencia := v_sentencia || ':var13,';
          v_sentencia := v_sentencia || ':var14,';
          v_sentencia := v_sentencia || ':var15,';
          v_sentencia := v_sentencia || ':var16,';
          v_sentencia := v_sentencia || ':var17,';
          v_sentencia := v_sentencia || ':var18,';
          v_sentencia := v_sentencia || ':var19,';
          v_sentencia := v_sentencia || ':var20,';
          v_sentencia := v_sentencia || ':var21,'; /*AARM, Agrego el Codigo de la Plaza ENERO 2003*/
             v_sentencia := v_sentencia || ':var22,'; -- oct 2003 Ingreso MAsivo
             v_sentencia := v_sentencia || ':var23)'; --- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
          DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_linord.num_orden);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_linord.tip_orden);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_linord.num_linea);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_linord.cod_articulo);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_linord.can_orden);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_linord.can_servida);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_linord.cod_causa);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_linord.can_series);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_linord.tip_stock);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_linord.cod_uso);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var11',v_linord.cod_estado);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var12',v_linord.prc_unidad);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var13',v_linord.num_linea_ref);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var14',v_linord.tip_movimiento);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var15',v_linord.can_orden_ing);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var16',v_linord.num_desde);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var17',v_linord.num_hasta);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var18',v_linord.prc_ff);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var19',v_linord.prc_adic);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var20',v_linord.num_sec_loca);
          DBMS_SQL.BIND_VARIABLE(v_cursor,'var21',v_linord.cod_plaza);  /*AARM, Agrego el codigo de plaza ENERO 2003*/
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var22',v_linord.cod_metodo_carga);  -- oct 2003 Ingreso MAsivo
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var23',Al_Busca_Grupo_Articulo_Fn(v_linord.cod_articulo));  -- Modificado 11/08/2004 por Contabilización CDMA por Tecnología

          v_filas := DBMS_SQL.EXECUTE(v_cursor);
          DBMS_SQL.CLOSE_CURSOR(v_cursor);
     EXCEPTION
      WHEN solapa THEN

      -- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador

gSqlERRM := sqlerrm;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_insert_linord ' || v_linord.num_orden;
gvTabla   := 'solapa '  || v_linord.num_orden;
gvError   := ' ';
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

-- GA_ERRORES

           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20126,'Error controlado en VB');
       WHEN OTHERS THEN

-- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador

gSqlERRM := sqlerrm;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_insert_linord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,1,50);
gvError   := substr(gSqlERRM,51,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,101,50);
gvError   := substr(gSqlERRM,151,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,201,50);
gvError   := substr(gSqlERRM,251,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,301,50);
gvError   := substr(gSqlERRM,351,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,401,50);
gvError   := substr(gSqlERRM,451,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

--
            IF DBMS_SQL.IS_OPEN(v_cursor) THEN
               DBMS_SQL.CLOSE_CURSOR(v_cursor);
            END IF;
            RAISE_APPLICATION_ERROR (-20112, TO_CHAR(SQLCODE));
     END p_insert_linord;

 /***********************************************************************/

   Procedure p_delete_linord(
   v_linord IN AL_LINEAS_ORDENES%ROWTYPE )
   IS
     BEGIN
        v_cursor := DBMS_SQL.OPEN_CURSOR;
        IF v_linord.tip_orden = 1 THEN
           v_tabla    := 'AL_LINEAS_ORDENES1';
        ELSIF v_linord.tip_orden = 2 THEN
              v_tabla := 'AL_LINEAS_ORDENES2';
        ELSIF v_linord.tip_orden = 3 THEN
              v_tabla := 'AL_LINEAS_ORDENES3';
        END IF;
        v_sentencia := 'DELETE ' || v_tabla || ' WHERE ';
        v_sentencia := v_sentencia || 'NUM_ORDEN = :var1 ';
        v_sentencia := v_sentencia || 'AND TIP_ORDEN = :var2 ';
        v_sentencia := v_sentencia || 'AND NUM_LINEA = :var3 ';
        DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
        DBMS_SQL.BIND_VARIABLE (v_cursor,'var1',v_linord.num_orden);
        DBMS_SQL.BIND_VARIABLE (v_cursor,'var2',v_linord.tip_orden);
        DBMS_SQL.BIND_VARIABLE (v_cursor,'var3',v_linord.num_linea);
        v_filas := DBMS_SQL.EXECUTE(v_cursor);
        DBMS_SQL.CLOSE_CURSOR (v_cursor);
    EXCEPTION
      WHEN OTHERS THEN
-- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador

gSqlERRM := sqlerrm;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_delete_linord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,1,50);
gvError   := substr(gSqlERRM,51,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,101,50);
gvError   := substr(gSqlERRM,151,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,201,50);
gvError   := substr(gSqlERRM,251,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,301,50);
gvError   := substr(gSqlERRM,351,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,401,50);
gvError   := substr(gSqlERRM,451,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

--
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20113,
                                    '<ALMACEN> Delete Lin.Ord. '
                                    || TO_CHAR(SQLCODE));
    END p_delete_linord;

/***********************************************************************/


  Procedure p_update_linord(
  v_linord IN OUT AL_LINEAS_ORDENES%ROWTYPE )
  IS
       exc_cant EXCEPTION;
       exc_cant1 EXCEPTION;
       v_error            NUMBER(1) := 0;
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_linord.tip_orden = 1 THEN
          v_tabla    := 'AL_LINEAS_ORDENES1';
       ELSIF v_linord.tip_orden = 2 THEN
             v_tabla := 'AL_LINEAS_ORDENES2';
       ELSIF v_linord.tip_orden = 3 THEN
             v_tabla := 'AL_LINEAS_ORDENES3';
       END IF;
       --if (v_linord.tip_orden = 1 or
       --    v_linord.tip_orden = 2)
       --and
       --    v_linord.can_series is not null and
       --    v_linord.can_orden_ing is not null and
       --    v_linord.can_orden_ing > v_linord.can_series and
       --    v_linord.can_series <> 0 then
       --    raise EXC_CANT;
       --end if;
       --if (v_linord.tip_orden = 1 or
       --    v_linord.tip_orden = 2)
       --and
       --   (v_linord.can_series is not null or
       --    v_linord.can_orden_ing is not null) then
      --then
          /* p_valida_can_orden (v_linord.num_orden,
                               v_linord.tip_orden,
                               v_linord.num_linea,
                               v_linord.can_series,
                               v_linord.can_orden_ing,
                               v_error);
    --22-09 anadido
           if v_error = 2 then
        raise EXC_CANT1;
       elsif v_error <> 0 then
              raise EXC_CANT;
           end if; mta*/
       --end if;
       v_sentencia := 'UPDATE ' || v_tabla;
       IF v_linord.cod_articulo IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_ARTICULO = :var1 ';
       END IF;
       IF v_linord.can_orden IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'CAN_ORDEN = :var2 ';
       END IF;
       IF v_linord.can_servida IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'CAN_SERVIDA = :var3 ';
       END IF;
       IF v_linord.cod_causa IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_CAUSA = :var4 ';
       END IF;
       IF v_linord.can_series IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'CAN_SERIES = :var5 ';
       END IF;
       IF v_linord.tip_stock IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TIP_STOCK = :var6 ';
       END IF;
       IF v_linord.cod_uso IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_USO = :var7 ';
       END IF;
       IF v_linord.cod_estado IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_ESTADO = :var8 ';
       END IF;
       IF v_linord.prc_unidad IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'PRC_UNIDAD = :var9 ';
       END IF;
       IF v_linord.num_linea_ref IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_LINEA_REF = :var10 ';
       END IF;
       IF v_linord.tip_movimiento IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'TIP_MOVIMIENTO = :var11 ';
       END IF;
       IF v_linord.can_orden_ing IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'CAN_ORDEN_ING = :var12 ';
       END IF;
       IF v_linord.num_desde IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_DESDE = :var13 ';
       END IF;
       IF v_linord.num_hasta IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_HASTA = :var14 ';
       END IF;
       IF v_linord.prc_ff IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'PRC_FF = :var19 ';
       END IF;
       IF v_linord.prc_adic IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'PRC_ADIC = :var20 ';
       END IF;
           IF v_linord.num_sec_loca IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'num_sec_loca = :var21 ';
       END IF;


           /*  AARM. Para Validar el Csdigo de Plaza Enero 2003 */
            IF v_linord.cod_plaza IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_PLAZA = :var22 ';
       END IF;

       -- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
       IF v_linord.cod_grpconcepto IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_GRPCONCEPTO = :var23 ';
       END IF;


       v_sentencia := v_sentencia || ' WHERE NUM_ORDEN = :var16 ';
       v_sentencia := v_sentencia || ' AND TIP_ORDEN = :var17 ';
       v_sentencia := v_sentencia || ' AND NUM_LINEA = :var18 ';
       IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
          DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
          IF INSTR(v_sentencia,'var1 ',1,1) <> 0 THEN
             IF v_linord.cod_articulo = -1 THEN
                v_linord.cod_articulo := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_linord.cod_articulo);
          END IF;
          IF INSTR(v_sentencia,'var2 ',1,1) <> 0 THEN
             IF v_linord.can_orden = -1 THEN
                v_linord.can_orden := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_linord.can_orden);
          END IF;
          IF INSTR(v_sentencia,'var3 ',1,1) <> 0 THEN
             IF v_linord.can_servida = -1 THEN
                v_linord.can_servida := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_linord.can_servida);
          END IF;
          IF INSTR(v_sentencia,'var4 ',1,1) <> 0 THEN
             IF v_linord.cod_causa = -1 THEN
                v_linord.cod_causa := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_linord.cod_causa);
          END IF;
          IF INSTR(v_sentencia,'var5 ',1,1) <> 0 THEN
             IF v_linord.can_series = -1 THEN
                v_linord.can_series := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_linord.can_series);
          END IF;
          IF INSTR(v_sentencia,'var6 ',1,1) <> 0 THEN
             IF v_linord.tip_stock = -1 THEN
                v_linord.tip_stock := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_linord.tip_stock);
          END IF;
          IF INSTR(v_sentencia,'var7 ',1,1) <> 0 THEN
             IF v_linord.cod_uso = -1 THEN
                v_linord.cod_uso := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_linord.cod_uso);
          END IF;
          IF INSTR(v_sentencia,'var8 ',1,1) <> 0 THEN
             IF v_linord.cod_estado = -1 THEN
                v_linord.cod_estado := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_linord.cod_estado);
          END IF;
          IF INSTR(v_sentencia,'var9 ',1,1) <> 0 THEN
             IF v_linord.prc_unidad = -1 THEN
                v_linord.prc_unidad := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_linord.prc_unidad);
          END IF;
          IF INSTR(v_sentencia,'var10',1,1) <> 0 THEN
             IF v_linord.num_linea_ref = -1 THEN
                v_linord.num_linea_ref := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_linord.num_linea_ref);
          END IF;
          IF INSTR(v_sentencia,'var11',1,1) <> 0 THEN
             IF v_linord.tip_movimiento = -1 THEN
                v_linord.tip_movimiento := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var11',v_linord.tip_movimiento);
          END IF;
          IF INSTR(v_sentencia,'var12',1,1) <> 0 THEN
             IF v_linord.can_orden_ing = -1 THEN
                v_linord.can_orden_ing := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var12',v_linord.can_orden_ing);
          END IF;
          IF INSTR(v_sentencia,'var13',1,1) <> 0 THEN
             IF v_linord.num_desde = -1 THEN
                v_linord.num_desde := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var13',v_linord.num_desde);
          END IF;
          IF INSTR(v_sentencia,'var14',1,1) <> 0 THEN
             IF v_linord.num_hasta = -1 THEN
                v_linord.num_hasta := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var14',v_linord.num_hasta);
          END IF;
          IF INSTR(v_sentencia,'var16',1,1) <> 0 THEN
             IF v_linord.num_orden = -1 THEN
                v_linord.num_orden := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var16',v_linord.num_orden);
          END IF;
          IF INSTR(v_sentencia,'var17',1,1) <> 0 THEN
             IF v_linord.tip_orden = -1 THEN
                v_linord.tip_orden := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var17',v_linord.tip_orden);
          END IF;
          IF INSTR(v_sentencia,'var18',1,1) <> 0 THEN
             IF v_linord.num_linea = -1 THEN
                v_linord.num_linea := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var18',v_linord.num_linea);
          END IF;
          IF INSTR(v_sentencia,'var19',1,1) <> 0 THEN
             IF v_linord.num_linea = -1 THEN
                v_linord.num_linea := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var19',v_linord.prc_ff);
          END IF;
          IF INSTR(v_sentencia,'var20',1,1) <> 0 THEN
             IF v_linord.num_linea = -1 THEN
                v_linord.num_linea := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var20',v_linord.prc_adic);
          END IF;

                  IF INSTR(v_sentencia,'var21',1,1) <> 0 THEN
             IF v_linord.num_sec_loca = -1 THEN
                v_linord.num_sec_loca := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var21',v_linord.num_sec_loca);
          END IF;

                  /*  AARM. Para Validar Csdigo de Plaza Enero 2003 */
                  IF INSTR(v_sentencia,'var22',1,1) <> 0 THEN
             IF v_linord.cod_plaza = '' THEN
                v_linord.cod_plaza := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var22',v_linord.cod_plaza);
          END IF;

          -- Modificado 11/08/2004 por Contabilización CDMA por Tecnología
          IF INSTR(v_sentencia,'var23',1,1) <> 0 THEN
             IF v_linord.cod_grpconcepto = -1 THEN
                v_linord.cod_grpconcepto := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var23',v_linord.cod_grpconcepto);
          END IF;

          v_filas := DBMS_SQL.EXECUTE(v_cursor);
       END IF;
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN EXC_CANT THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20151,'');
    --22-09 anadido
      WHEN EXC_CANT1 THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20152,'');
      WHEN OTHERS THEN

      -- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador

gSqlERRM := sqlerrm;

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_linord' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,1,50);
gvError   := substr(gSqlERRM,51,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,101,50);
gvError   := substr(gSqlERRM,151,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,201,50);
gvError   := substr(gSqlERRM,251,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,301,50);
gvError   := substr(gSqlERRM,351,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

gvCodigo  := gvCodigo + 1;
gvProceso := 'AL_TRATA_ORDEN.p_update_cabord ' || v_linord.num_orden;
gvTabla   := substr(gSqlERRM,401,50);
gvError   := substr(gSqlERRM,451,50);
AL_TRATA_ORDEN.AL_CREA_ERROR_PR(gvCodigo, gvProceso, gvTabla, gvError);

--
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20114,
                                    '<ALMACEN> Update Lin.Ord. '
                                    || TO_CHAR(SQLCODE));
    END p_update_linord;

/***********************************************************************/

  Procedure p_insert_serord(
  v_serord IN AL_SERIES_ORDENES%ROWTYPE )
  IS
    BEGIN
       IF v_serord.tip_orden = 2 THEN
          p_borrar_anomalias (v_serord.num_serie);
       END IF;
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_serord.tip_orden = 2 THEN
          v_tabla     := 'AL_SERIES_ORDENES2';
       ELSIF v_serord.tip_orden = 3 THEN
              v_tabla := 'AL_SERIES_ORDENES3';
       END IF;
       v_sentencia := 'INSERT INTO ' || v_tabla;
       v_sentencia := v_sentencia || ' (NUM_ORDEN,';
       v_sentencia := v_sentencia || 'TIP_ORDEN,';
       v_sentencia := v_sentencia || 'NUM_LINEA,';
       v_sentencia := v_sentencia || 'NUM_SERIE,';
       v_sentencia := v_sentencia || 'NUM_SERIEMEC,';
       v_sentencia := v_sentencia || 'COD_PRODUCTO,';
       v_sentencia := v_sentencia || 'COD_CENTRAL,';
       v_sentencia := v_sentencia || 'CAP_CODE,';
       v_sentencia := v_sentencia || 'NUM_TELEFONO,';
       v_sentencia := v_sentencia || 'COD_SUBALM,';
       v_sentencia := v_sentencia || 'COD_CAT,';
       v_sentencia := v_sentencia || 'IND_TELEFONO,';
       v_sentencia := v_sentencia || 'PLAN,';
       v_sentencia := v_sentencia || 'CARGA,';
       v_sentencia := v_sentencia || 'NUM_SEC_LOCA,';
       v_sentencia := v_sentencia || 'A_KEY,';
       v_sentencia := v_sentencia || 'chk_digits,';
       v_sentencia := v_sentencia || 'NUM_SUBLOCK, cod_hlr)';
       v_sentencia := v_sentencia || ' VALUES (';
       v_sentencia := v_sentencia || ':var1,';
       v_sentencia := v_sentencia || ':var2,';
       v_sentencia := v_sentencia || ':var3,';
       v_sentencia := v_sentencia || ':var4,';
       v_sentencia := v_sentencia || ':var5,';
       v_sentencia := v_sentencia || ':var6,';
       v_sentencia := v_sentencia || ':var7,';
       v_sentencia := v_sentencia || ':var8,';
       v_sentencia := v_sentencia || ':var9,';
       v_sentencia := v_sentencia || ':var10,';
       v_sentencia := v_sentencia || ':var75,';
       v_sentencia := v_sentencia || ':var76,';
       v_sentencia := v_sentencia || ':var77,';  --plan
       v_sentencia := v_sentencia || ':var78,';  --carga
       v_sentencia := v_sentencia || ':var79,';  --localizacion
       v_sentencia := v_sentencia || ':var80,';  --akeys
       v_sentencia := v_sentencia || ':var81,';  --sub_sidy
       v_sentencia := v_sentencia || ':var82, :var83)';  --sub_sidy

       DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_serord.num_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_serord.tip_orden);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_serord.num_linea);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_serord.num_serie);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_serord.num_seriemec);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_serord.cod_producto);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_serord.cod_central);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var8',v_serord.cap_code);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_serord.num_telefono);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_serord.cod_subalm);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var75',v_serord.cod_cat);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var76',v_serord.ind_telefono);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var77',v_serord.PLAN);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var78',v_serord.carga);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var79',v_serord.num_sec_loca);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var80',v_serord.a_key);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var81',v_serord.chk_digits);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var82',v_serord.NUM_SUBLOCK);
       DBMS_SQL.BIND_VARIABLE(v_cursor,'var83',v_serord.cod_hlr);
       v_filas := DBMS_SQL.EXECUTE(v_cursor);
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
       IF V_TABLA = 'AL_SERIES_ORDENES2' AND v_serord.a_key IS NOT NULL THEN
          P_Transforma_Hexa(v_serord.num_serie,v_serie_hex);
          INSERT INTO ICT_AKEYS(NUM_ESN,COD_CLAVE,A_KEY_CRYP,CHK_DIGITS,PRIMER_CODIGO,SEGUNDO_CODIGO,
                                ID_CARGA,FEC_ACTUALIZACION,COD_ESTADO,NUM_ESN_HEX)
                                VALUES (v_serord.num_serie,NULL,v_serord.a_key,v_serord.chk_digits,v_serord.NUM_SUBLOCK,
                                        NULL,-1,SYSDATE,2,V_SERIE_HEX);
       END IF;
    EXCEPTION
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20115,
                                    '<ALMACEN> Insert Ser.Ord. '
                                    || TO_CHAR(SQLCODE));
    END p_insert_serord;

/***********************************************************************/

  Procedure p_delete_serord(
  v_serord IN AL_SERIES_ORDENES%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_serord.tip_orden = 2 THEN
          v_tabla    := 'AL_SERIES_ORDENES2';
       ELSIF v_serord.tip_orden = 3 THEN
             v_tabla := 'AL_SERIES_ORDENES3';
       END IF;
       v_sentencia := 'DELETE ' || v_tabla || ' WHERE ';
       v_sentencia := v_sentencia || 'NUM_ORDEN = :var1 ';
       v_sentencia := v_sentencia || 'AND TIP_ORDEN = :var2 ';
       v_sentencia := v_sentencia || 'AND NUM_LINEA = :var3 ';
       v_sentencia := v_sentencia || 'AND NUM_SERIE = :var4 ';
       DBMS_SQL.PARSE (v_cursor,v_sentencia,dbms_sql.v7);
       DBMS_SQL.BIND_VARIABLE (v_cursor,'var1',v_serord.num_orden);
       DBMS_SQL.BIND_VARIABLE (v_cursor,'var2',v_serord.tip_orden);
       DBMS_SQL.BIND_VARIABLE (v_cursor,'var3',v_serord.num_linea);
       DBMS_SQL.BIND_VARIABLE (v_cursor,'var4',v_serord.num_serie);
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
    END p_delete_serord;

/***********************************************************************/

  Procedure p_update_serord(
  v_serord IN OUT AL_SERIES_ORDENES%ROWTYPE )
  IS
    BEGIN
       v_cursor := DBMS_SQL.OPEN_CURSOR;
       IF v_serord.tip_orden = 2 THEN
          v_tabla    := 'AL_SERIES_ORDENES2';
       ELSIF v_serord.tip_orden = 3 THEN
             v_tabla := 'AL_SERIES_ORDENES3';
       END IF;
       v_sentencia := 'UPDATE ' || v_tabla;
       IF v_serord.num_serie IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_SERIE = :var1 ';
       END IF;
       IF v_serord.num_seriemec IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_SERIEMEC = :var2 ';
       END IF;
       IF v_serord.cod_producto IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_PRODUCTO = :var3 ';
       END IF;
       IF v_serord.cod_central IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_CENTRAL = :var4 ';
       END IF;
       IF v_serord.cap_code IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'CAP_CODE = :var5 ';
       END IF;
       IF v_serord.num_telefono IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'NUM_TELEFONO = :var6 ';
       END IF;
       IF v_serord.cod_subalm IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_SUBALM = :var7 ';
       END IF;
       IF v_serord.cod_cat IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'COD_CAT = :var75 ';
       END IF;
       IF v_serord.ind_telefono IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'IND_TELEFONO = :var76 ';
       END IF;
       IF v_serord.PLAN IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'PLAN = :var77 ';
       END IF;
       IF v_serord.carga IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'CARGA = :var78 ';
       END IF;
           IF v_serord.num_sec_loca IS NOT NULL THEN
          IF INSTR(v_sentencia,' SET ',1,1) <> 0 THEN
             IF SUBSTR(v_sentencia,LENGTH(v_sentencia),1) <> ',' THEN
                v_sentencia := v_sentencia || ',';
             END IF;
          ELSE
             v_sentencia := v_sentencia || ' SET ';
          END IF;
          v_sentencia := v_sentencia || 'num_sec_loca = :var79 ';
       END IF;
       v_sentencia := v_sentencia || 'WHERE NUM_ORDEN = :var9 ';
       v_sentencia := v_sentencia || 'AND TIP_ORDEN = :var10 ';
       v_sentencia := v_sentencia || 'AND NUM_LINEA = :var11 ';
       v_sentencia := v_sentencia || 'AND NUM_SERIE = :var1 ';
       IF INSTR(v_sentencia,' SET ',1,1) <> 1 THEN
          DBMS_SQL.PARSE(v_cursor,v_sentencia,dbms_sql.v7);
          IF INSTR(v_sentencia,'var1 ',1,1) <> 0 THEN
             IF v_serord.num_serie = '' THEN
                v_serord.num_serie := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var1',v_serord.num_serie);
          END IF;
          IF INSTR(v_sentencia,'var2 ',1,1) <> 0 THEN
             IF v_serord.num_seriemec = '' THEN
                v_serord.num_seriemec := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var2',v_serord.num_seriemec);
          END IF;
          IF INSTR(v_sentencia,'var3 ',1,1) <> 0 THEN
             IF v_serord.cod_producto = -1 THEN
                v_serord.cod_producto := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var3',v_serord.cod_producto);
          END IF;
          IF INSTR(v_sentencia,'var4 ',1,1) <> 0 THEN
             IF v_serord.cod_central = -1 THEN
                v_serord.cod_central := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var4',v_serord.cod_central);
          END IF;
          IF INSTR(v_sentencia,'var5 ',1,1) <> 0 THEN
             IF v_serord.cap_code = -1 THEN
                v_serord.cap_code := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var5',v_serord.cap_code);
          END IF;
          IF INSTR(v_sentencia,'var6 ',1,1) <> 0 THEN
             IF v_serord.num_telefono = -1 THEN
                v_serord.num_telefono := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var6',v_serord.num_telefono);
          END IF;
          IF INSTR(v_sentencia,'var7 ',1,1) <> 0 THEN
             IF v_serord.cod_subalm = '' THEN
                v_serord.cod_subalm := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var7',v_serord.cod_subalm);
          END IF;
          IF INSTR(v_sentencia,'var75 ',1,1) <> 0 THEN
             IF v_serord.cod_cat = -1 THEN
                v_serord.cod_cat := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var75',v_serord.cod_cat);
          END IF;
          IF INSTR(v_sentencia,'var9 ',1,1) <> 0 THEN
             IF v_serord.num_orden = -1 THEN
                v_serord.num_orden := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var9',v_serord.num_orden);
          END IF;
          IF INSTR(v_sentencia,'var10 ',1,1) <> 0 THEN
             IF v_serord.tip_orden = -1 THEN
                v_serord.tip_orden := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var10',v_serord.tip_orden);
          END IF;
          IF INSTR(v_sentencia,'var11',1,1) <> 0 THEN
             IF v_serord.num_linea = -1 THEN
                v_serord.num_linea := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var11',v_serord.num_linea);
          END IF;
          IF INSTR(v_sentencia,'var76',1,1) <> 0 THEN
             IF v_serord.ind_telefono = -1 THEN
                v_serord.ind_telefono := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var76',v_serord.ind_telefono);
          END IF;
          IF INSTR(v_sentencia,'var77',1,1) <> 0 THEN
             IF v_serord.PLAN = -1 THEN
                v_serord.PLAN := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var77',v_serord.PLAN);
          END IF;
          IF INSTR(v_sentencia,'var78',1,1) <> 0 THEN
             IF v_serord.carga = -1 THEN
                v_serord.carga := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var78',v_serord.carga);
          END IF;
                  IF INSTR(v_sentencia,'var79',1,1) <> 0 THEN
             IF v_serord.num_sec_loca = -1 THEN
                v_serord.num_sec_loca := NULL;
             END IF;
             DBMS_SQL.BIND_VARIABLE(v_cursor,'var79',v_serord.num_sec_loca);
          END IF;
          v_filas := DBMS_SQL.EXECUTE(v_cursor);
       END IF;
       DBMS_SQL.CLOSE_CURSOR(v_cursor);
    EXCEPTION
      WHEN OTHERS THEN
           IF DBMS_SQL.IS_OPEN(v_cursor) THEN
              DBMS_SQL.CLOSE_CURSOR(v_cursor);
           END IF;
           RAISE_APPLICATION_ERROR (-20117,
                                    '<ALMACEN> Update Ser.Ord. '
                                    || TO_CHAR(SQLCODE));
    END p_update_serord;


/***********************************************************************/


  Procedure p_obtiene_documento(
  v_documento IN OUT AL_TIPOS_ARTICULOS.tip_articulo%TYPE )
  IS
    BEGIN
       SELECT tip_articulo_doc INTO v_documento
              FROM AL_DATOS_GENERALES;
    EXCEPTION
       WHEN OTHERS THEN
            v_documento := NULL;
    END p_obtiene_documento;
  Procedure p_obtiene_tipdocum(
  v_articulo IN AL_ARTICULOS.cod_articulo%TYPE ,
  v_tipdocum IN OUT GE_TIPDOCUMEN.cod_tipdocum%TYPE )
  IS
    BEGIN
       SELECT cod_tipdocum INTO v_tipdocum
              FROM GE_TIPDOCUMEN
              WHERE cod_articulo = v_articulo;
    EXCEPTION
       WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20127,'Documento no catalogado');
    END p_obtiene_tipdocum;
/***********************************************************************/
  Procedure p_obtiene_tiparticulo(
  v_articulo IN AL_ARTICULOS.cod_articulo%TYPE ,
  v_tiparticulo IN OUT AL_ARTICULOS.tip_articulo%TYPE )
  IS
    BEGIN
       SELECT tip_articulo INTO v_tiparticulo
              FROM AL_ARTICULOS
              WHERE cod_articulo = v_articulo;
    EXCEPTION
       WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20128,'Articulo no catalogado');
    END p_obtiene_tiparticulo;



  Procedure p_valida_rango(
  v_articulo IN AL_STOCK.cod_articulo%TYPE ,
  v_desde IN AL_STOCK.num_desde%TYPE ,
  v_hasta IN AL_STOCK.num_hasta%TYPE ,
  v_Num_Orden IN AL_LINEAS_ORDENES.Num_Orden%TYPE ,
  v_Tip_Orden IN AL_LINEAS_ORDENES.Tip_Orden%TYPE ,
  v_cod_plaza IN AL_LINEAS_ORDENES.Cod_Plaza%TYPE )

  IS
      v_existe NUMBER(1):=0;
    BEGIN
      p_valida_stock (v_articulo,v_desde,v_hasta, v_cod_plaza ,v_existe); /*AARM, se Iincluye el codigo de la plaza ENERO 2003*/
      p_valida_stock (v_articulo,v_desde,v_hasta, v_cod_plaza ,v_existe); /*AARM, se Iincluye el codigo de la plaza ENERO 2003*/
      IF v_existe = 1 THEN
         RAISE solapa;
      END IF;
      p_valida_docum (v_articulo,v_desde,v_hasta,v_Num_Orden, v_Tip_Orden, v_cod_plaza, v_existe );
      IF v_existe = 1 THEN
         RAISE solapa;
      END IF;
    END p_valida_rango;

/***********************************************************************/

  Procedure p_valida_stock(
  v_articulo IN AL_STOCK.cod_articulo%TYPE ,
  v_desde IN AL_STOCK.num_desde%TYPE ,
  v_hasta IN AL_STOCK.num_hasta%TYPE ,
  v_cod_plaza IN AL_STOCK.cod_plaza%TYPE ,
  v_existe IN OUT NUMBER )
  IS


    BEGIN
      SELECT 1 INTO v_existe
             FROM AL_STOCK
             WHERE cod_articulo = v_articulo AND
                                   cod_plaza = v_cod_plaza AND /*AARM, Para busqueda se Agrego el Csdigo de Plaza ENERO 2003*/
                  (
                   (num_desde <= v_desde AND
                    num_hasta >= v_desde AND
                    num_hasta >= v_hasta) OR
                   (num_desde >= v_desde AND
                    num_hasta <= v_hasta) OR
                   (num_desde >= v_desde AND
                    num_desde <= v_hasta AND
                    num_hasta >= v_hasta) OR
                   (num_desde <= v_desde AND
                    num_hasta >= v_desde AND
                    num_hasta <= v_hasta)
                  );
    EXCEPTION
       WHEN TOO_MANY_ROWS THEN
            v_existe := 1;
       WHEN OTHERS THEN
            v_existe := 0;
    END p_valida_stock;


/***********************************************************************/

  Procedure p_valida_docum(
  v_articulo IN AL_STOCK.cod_articulo%TYPE ,
  v_desde IN AL_STOCK.num_desde%TYPE ,
  v_hasta IN AL_STOCK.num_hasta%TYPE ,
  v_Num_Orden IN AL_LINEAS_ORDENES.Num_Orden%TYPE ,/*AARM Se recibe el parametro de Num Orden */
  v_Tip_Orden IN AL_LINEAS_ORDENES.Tip_Orden%TYPE ,/*AARM Se recibe el parametro de Tipo Orden */
  v_cod_plaza IN AL_LINEAS_ORDENES.Cod_Plaza%TYPE ,/*AARM Se recibe el parametro de Cod_Plaza */
  v_existe IN OUT NUMBER )
  IS
      v_tipdocum GE_TIPDOCUMEN.cod_tipdocum%TYPE;

            /***AARM  Declaro Variables para Almacenar datos de Prefijo de Plaza y Csdigo de Operadora*****/
          v_pref_plaza GE_OPERPLAZA_TD.pref_plaza%TYPE;
      v_cod_operadora GE_OPERADORA_SCL.cod_operadora_scl%TYPE;


    BEGIN

      p_obtiene_tipdocum (v_articulo,v_tipdocum);
          /*AARM, Agrego los campos en la funcisn para que sean retornados (Pref. Plaza y peradora)*/
--          p_obtiene_Operadora_prefijo (v_num_Orden, v_tip_Orden, v_Cod_plaza, v_Cod_Operadora, v_Pref_plaza);
          p_obtiene_Operadora_prefijo (v_num_Orden, v_tip_Orden, v_Cod_plaza, v_Cod_Operadora);
          v_pref_plaza := al_documentos_pg.al_pref_documofic_fn(v_cod_Plaza,v_tipdocum);
      SELECT 1 INTO v_existe
             FROM AL_ASIG_DOCUMENTOS
             WHERE cod_tipdocum = v_tipdocum AND
                                   /* AARM Agrego en el Where el Prefijo de Plaza y la Operadora*/
                                   Pref_plaza = v_pref_plaza AND
                                   Cod_Operadora = v_Cod_Operadora AND
                  (
                   (ran_desde <= v_desde AND
                    ran_hasta >= v_desde AND
                    ran_hasta >= v_hasta) OR
                   (ran_desde >= v_desde AND
                    ran_hasta <= v_hasta) OR
                   (ran_desde >= v_desde AND
                    ran_desde <= v_hasta AND
                    ran_hasta >= v_hasta) OR
                   (ran_desde <= v_desde AND
                    ran_hasta >= v_desde AND
                    ran_hasta <= v_hasta)
                  );
    EXCEPTION
    -- 09-12-97 G.R. a?adido para evitar error al devolver varias lineas
       WHEN TOO_MANY_ROWS THEN
            v_existe := 1;
       WHEN NO_DATA_FOUND THEN
            v_existe := 0;
    END p_valida_docum;

/***********************************************************************/


  Procedure p_borrar_anomalias(
  v_serie IN AL_SERIES.num_serie%TYPE )
  IS
    BEGIN
        DELETE AL_SERIES_ANOMALIAS
               WHERE num_serie = v_serie;
    END p_borrar_anomalias;

/***********************************************************************/

  Procedure p_valida_can_orden(
  v_orden IN AL_LINEAS_ORDENES.num_orden%TYPE ,
  v_tipo IN AL_LINEAS_ORDENES.tip_orden%TYPE ,
  v_linea IN AL_LINEAS_ORDENES.num_linea%TYPE ,
  v_canser IN AL_LINEAS_ORDENES.can_series%TYPE ,
  v_caning IN AL_LINEAS_ORDENES.can_orden_ing%TYPE ,
  v_error IN OUT NUMBER )
  IS
       v_caning_old    AL_LINEAS_ORDENES.can_orden_ing%TYPE;
       v_canser_old    AL_LINEAS_ORDENES.can_series%TYPE;
    BEGIN
       SELECT can_orden_ing, can_series
         INTO v_caning_old, v_canser_old
         FROM al_vlineas_ordenes
        WHERE num_orden = v_orden
          AND tip_orden = v_tipo
          AND num_linea = v_linea;
    DBMS_OUTPUT.PUT_LINE('canser ' || TO_CHAR(v_canser));
    DBMS_OUTPUT.PUT_LINE('caning ' || TO_CHAR(v_caning));
    DBMS_OUTPUT.PUT_LINE('caning_old ' || TO_CHAR(v_caning_old));
    DBMS_OUTPUT.PUT_LINE('canser_old ' || TO_CHAR(v_canser_old));
       IF v_canser IS NOT NULL AND
          NVL(v_canser_old,0) = 0 AND
          NVL(v_caning_old,0) > 0 AND
          v_canser > 0 THEN
             v_error := 2;
       ELSIF v_caning IS NOT NULL AND
             NVL(v_canser_old,0) > 0 AND
             NVL(v_caning,0) > NVL(v_canser_old,0) THEN
                v_error := 1;
       END IF;
    EXCEPTION
       WHEN OTHERS THEN
            v_error := 1;
    END p_valida_can_orden;
/***************************************************************************/
/*AARM, Funcion Creada Para Obtener el Prefijo de la Plaza y el Csdigo de Operadora*/
  Procedure p_obtiene_operadora_Prefijo(
  v_num_Orden IN AL_LINEAS_ORDENES.num_orden%TYPE ,
  v_tip_Orden IN AL_LINEAS_ORDENES.tip_orden%TYPE ,
  v_cod_Plaza IN AL_LINEAS_ORDENES.cod_plaza%TYPE ,
--  v_tipodocum  IN ge_tipdocumen.cod_tipdocum%type ,
  v_Operadora IN OUT GE_OPERADORA_SCL.cod_operadora_scl%TYPE)
--  v_Prefijo IN OUT ge_oficinas.cod_prefijo%type)
  IS
    BEGIN
       SELECT valor_texto into v_Operadora
       FROM ge_parametros_sistema_vw WHERE  nom_parametro = 'COD_OPERADORA_LOCAL' AND cod_modulo = 'GE';

    EXCEPTION
       WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20128,'Prefijo de Plaza y cod. Operadora no fueron Encontrados');
    END p_obtiene_operadora_Prefijo;
/***************************************************************************/
  Procedure p_ingreso_notapedido(
        vp_cod_proveedor    IN  AL_PROVEEDORES.cod_proveedor%TYPE,
        vp_cod_bodega       IN  AL_BODEGAS.cod_bodega%TYPE,
        vp_cod_orden        IN  AL_CABECERA_ORDENES.num_orden%TYPE)
  AS
         p_cod_pedido           npt_pedido.cod_pedido%TYPE;
         p_cod_mensaje          npt_mensaje.cod_mensaje%TYPE;
         v_tip_proveedor        AL_PROVEEDORES.IND_TIPROVEEDOR%TYPE;
         v_cod_cliente          npt_pedido.cod_cliente%TYPE;
         v_cod_usuario          npt_pedido.cod_usuario_cre%TYPE;
         v_cod_ejecutivo        npt_pedido.cod_usuario_cre%TYPE;
         v_cod_bodega           npt_pedido.cod_bodega%TYPE;
         v_tip_pago             npt_pedido.cod_tipo_pago%TYPE;
         v_can_total_pedido     npt_pedido.can_total_pedido%TYPE;
         v_mto_tot_pedido       npt_pedido.mto_tot_pedido%TYPE;
         v_cod_funcion          npd_funcion.cod_funcion%TYPE;
         v_tip_stock            npt_precio_articulo.tip_stock%TYPE;
         v_cod_uso              npt_precio_articulo.cod_uso%TYPE;
         v_mto_pre_articulo     npt_precio_articulo.mto_pre_articulo%TYPE;
         v_cod_operadora_scl    GE_OPERADORA_SCL.cod_operadora_scl%TYPE;
         v_canal                NUMBER(2);
         v_mto_net_det_pedido   npt_detalle_pedido.mto_net_det_pedido%TYPE;
         v_cod_tecnologia       AL_TECNOLOGIA.cod_tecnologia%TYPE;
         v_concepto_articulo    AL_ARTICULOS.cod_conceptoart%TYPE;
         v_num_proceso          NUMBER(8);
         v_tip_concepto         FA_CONCEPTOS.cod_tipconce%TYPE;
         v_cat_impositiva       GE_CATIMPCLIENTES.cod_catimpos%TYPE;
         v_cod_oficina          GE_CLIENTES.cod_oficina%TYPE;
         v_impuesto_fact        FAT_PRESUPTEMP.imp_facturable%TYPE;
         v_total_impuesto_fact  FAT_PRESUPTEMP.imp_facturable%TYPE;
         -- Modificado Por C.A.Z. 04-03-2004
         v_cod_plaza            GE_CIUDADES.cod_plaza%TYPE;
         -- Fin Modificación
         CN_tecno_default       CONSTANT NUMBER := 1;
         v_proc                 VARCHAR2(50) := ' ';
         v_tabla                VARCHAR2(50) := ' ';
         v_act                  VARCHAR2(50) := ' ';
         v_sqlcode              VARCHAR2(50) := ' ';
         v_sqlerrm              VARCHAR2(50) := ' ';
         v_error                VARCHAR2(50) := ' ';
CURSOR lineas_Orden IS
        SELECT NUM_LINEA, COD_ARTICULO, CAN_ORDEN, TIP_STOCK, COD_USO, PRC_UNIDAD
        FROM AL_LINEAS_ORDENES1
        WHERE NUM_ORDEN = vp_cod_orden;
BEGIN
           -- Busca codigo Cliente y codigo Operadora
           v_error := ' Al recuperar código cliente y código Operadora ';
           SELECT COD_CLIENTE, COD_OPERADORA_SCL
           INTO v_cod_cliente, v_cod_operadora_scl
              FROM GE_OPERADORA_SCL
           WHERE COD_BODEGANODO = vp_cod_bodega;
           -- El codigo de usuario esta asociado a un cliente
           v_error := ' Al recuperar código del Usuario ';
           SELECT COD_USUARIO INTO v_cod_usuario
           FROM NPT_USUARIO_CLIENTE
           WHERE COD_CLIENTE = v_cod_cliente;
           -- Define el tipo de pago del cliente
           v_tip_pago := 1;
           -- Bodega asociada al usuario
           v_error := ' Al recuperar código Bodega asociada al Usuario ';
           SELECT COD_BODEGA INTO v_cod_bodega
           FROM NPT_USUARIO_BODEGA
           WHERE COD_USUARIO = v_cod_usuario;
           -- Modificado Por C.A.Z. 04-03-2004
           -- Plaza asociada a bodega del usuario
           v_error := ' Al recuperar código Plaza asociada al Usuario ';
           SELECT C.COD_PLAZA  INTO v_cod_plaza
           FROM AL_BODEGAS A, GE_DIRECCIONES B, GE_CIUDADES C
           WHERE A.COD_BODEGA = v_cod_bodega
           AND A.COD_DIRECCION = B.COD_DIRECCION
           AND B.COD_CIUDAD = C.COD_CIUDAD
           AND B.COD_PROVINCIA = C.COD_PROVINCIA
           AND B.COD_REGION = C.COD_REGION;
           -- Fin Modificación
           -- Canal Asociado al cliente
           v_error := ' Al recuperar código Canal ';
           SELECT COD_TIPO_CANAL INTO v_canal
           FROM NPT_USUARIO_TIPO_CANAL
           WHERE COD_USUARIO = (SELECT COD_USUARIO FROM NPT_USUARIO_CLIENTE
           WHERE COD_CLIENTE = v_cod_cliente);
           -- Ejecutivo del canal
           v_error := ' Al recuperar código Ejecutivo ';
           SELECT COD_USUARIO INTO v_cod_ejecutivo
           FROM NPT_USUARIO_TIPO_CANAL
           WHERE COD_TIPO_CANAL= v_canal AND CAT_USUARIO = 'E';
           -- Codigo de la funcion que define el  estado
           v_error := ' Al recuperar código función que define el estado ';
           SELECT COD_FUNCION INTO v_cod_funcion
           FROM NPD_FUNCION
           WHERE URL_FUNCION = 'man_pedido.asp';
           -- Cantidad Total y Monto Total del pedido obtenido de las lineas de la orden de compra
           v_error := ' Al recuperar Cantidad Total y Monto Total del pedido obtenido de las lineas de la orden de compra ';
           SELECT SUM(CAN_ORDEN) CAN_PEDIDO, SUM(CAN_ORDEN * PRC_UNIDAD) MON_PEDIDO
           INTO v_can_total_pedido, v_mto_net_det_pedido
           FROM AL_LINEAS_ORDENES1
           WHERE NUM_ORDEN = vp_cod_orden
           GROUP BY NUM_ORDEN;
           v_total_impuesto_fact := 0;
           -- Calcula el Impuesto de la Orden
                 v_error := ' Al recuperar el Impuesto de la Orden ';
                FOR Reg IN lineas_Orden LOOP
                        v_mto_tot_pedido := Reg.PRC_UNIDAD * Reg.CAN_ORDEN;
                        SELECT COD_TECNOLOGIA
                          INTO v_cod_tecnologia
                          FROM AL_TECNOARTICULO_TD
                         WHERE COD_ARTICULO = Reg.COD_ARTICULO
                           AND IND_DEFECTO  = CN_tecno_default;
                        -- Obtiene Codigo Concepto
                        SELECT COD_CONCEPTOART
                        INTO v_concepto_articulo
                        FROM  AL_ARTICULOS
                        WHERE COD_ARTICULO = Reg.COD_ARTICULO;
                        -- Obtiene Numero Proceso
                        SELECT FAS_PRESUPTEMP.NEXTVAL
                        INTO v_num_proceso
                        FROM DUAL;
                        --Obtiene el Codigo del Tipo de Concepto
                        SELECT COD_TIPCONCE
                        INTO v_tip_concepto
                        FROM FA_CONCEPTOS WHERE COD_CONCEPTO = v_concepto_articulo;
                        --Inserta datos en tabla Paso
                        INSERT INTO FAT_PRESUPTEMP (NUM_PROCESO,COD_CONCEPTO,COLUMNA,COD_CLIENTE,FEC_EFECTIVIDAD,IMP_CONCEPTO,IMP_FACTURABLE,COD_TIPCONCE)
                        VALUES (v_num_proceso,v_concepto_articulo,1,v_cod_cliente,SYSDATE,v_mto_tot_pedido,v_mto_tot_pedido,v_tip_concepto);
                        -- Obtiene la Categoria Impositiva del cliente
                        SELECT COD_CATIMPOS
                        INTO  v_cat_impositiva
                        FROM GE_CATIMPCLIENTES WHERE COD_CLIENTE = v_cod_cliente;
                        --Obtiene el Codigo de la Oficina
                        SELECT COD_OFICINA
                        INTO  v_cod_oficina
                        FROM GE_CLIENTES WHERE COD_CLIENTE = vp_cod_proveedor;
                        --Obtiene el Impuesto Calculado
                        Fa_Proc_Imptos(v_num_proceso,v_cat_impositiva,v_cod_oficina,v_proc,v_tabla,v_act,v_sqlcode,v_sqlerrm,v_error);
                        SELECT IMP_FACTURABLE
                        INTO v_impuesto_fact
                        FROM FAT_PRESUPTEMP WHERE NUM_PROCESO = v_num_proceso AND PRC_IMPUESTO IS NOT NULL;
                        v_total_impuesto_fact := v_total_impuesto_fact + v_impuesto_fact;
                END LOOP;
                   v_mto_tot_pedido := v_mto_net_det_pedido + v_total_impuesto_fact;
                   P_INSERT_PEDIDO_ENC
                           (p_cod_pedido,
                                p_cod_mensaje,
                                v_cod_cliente,
                                v_cod_bodega,
                                v_cod_usuario,
                                v_cod_usuario,
                                v_cod_ejecutivo,
                                v_tip_pago,
                                0,-- cod_sistema_despacho
                                'Orden de Compra Interna',
                                v_can_total_pedido,
                                v_can_total_pedido,
                                v_mto_net_det_pedido,-- mto_neto_pedido
                                0,-- default vp_mto_otros_impto_pedido inc-201415 
                                0,-- mto_des_pedido
                                v_total_impuesto_fact,-- mto_iva_pedido
                                v_mto_tot_pedido,
                                v_cod_funcion,
                                vp_cod_orden,
                v_cod_plaza);
                FOR Reg IN lineas_Orden LOOP
                        v_mto_net_det_pedido := Reg.PRC_UNIDAD * Reg.CAN_ORDEN;
                        P_INSERT_PEDIDO_DET
                           (p_cod_pedido,
                                Reg.NUM_LINEA,
                                Reg.TIP_STOCK,
                                Reg.COD_ARTICULO,
                                Reg.COD_USO,
                                Reg.CAN_ORDEN,
                                Reg.PRC_UNIDAD,
                                0,-- mto_des_det_pedido
                                0,-- ptj_des_det_pedido
                                v_mto_net_det_pedido,  -- mto_net_det_pedido
                                v_cod_tecnologia);
                END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20100, 'Error ' || v_error || TO_CHAR(SQLCODE) || ': ' || SQLERRM);
  END p_ingreso_notapedido;


PROCEDURE  AL_CREA_ERROR_PR (vCodigo  IN GA_ERRORES.CODIGO%type
, vProceso  IN GA_ERRORES.NOM_PROC%type
, vTabla    IN GA_ERRORES.NOM_TABLA%type
,  vError   IN GA_ERRORES.COD_SQLERRM%type
)
IS
 LV_sql                  ge_errores_pg.vQuery;
 LV_des_error            ge_errores_pg.DesEvent;
 sn_cod_retorno          ge_errores_td.cod_msgerror%TYPE;
 sv_mens_retorno         ge_errores_td.det_msgerror%TYPE;
 sn_num_evento           ge_errores_pg.evento;
 sn_COD_SQLCODE          ga_errores.COD_SQLCODE%type;

 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

-- Inc. 186628 Fecha: 25-07-2012  ZMH Trazador
LV_sql := 'Insert into GA_ERRORES ';
LV_sql := LV_sql || 'ZJ,' || vCodigo || ',' || sysdate || '1,' || vProceso || ',' || vTabla ||'S, 0,' || vError;

Insert into GA_ERRORES
   (COD_ACTABO, CODIGO, FEC_ERROR, COD_PRODUCTO, NOM_PROC, NOM_TABLA, COD_ACT, COD_SQLCODE, COD_SQLERRM)
 Values
   ('ZJ', gvCodigo, sysdate , 1, vProceso, vTabla, 'S', '0', vError);

commit;

EXCEPTION
 WHEN OTHERS THEN
      ROLLBACK;
	  gvCodigo := gvCodigo + 1;
	  sn_COD_SQLCODE := to_char(sqlcode);

Insert into GA_ERRORES
   (COD_ACTABO, CODIGO, FEC_ERROR, COD_PRODUCTO, NOM_PROC, NOM_TABLA, COD_ACT, COD_SQLCODE, COD_SQLERRM)
 Values
   ('ZJ', gvCodigo, sysdate , 1, vProceso, vTabla, 'S', sn_COD_SQLCODE, vError);
commit;

END AL_CREA_ERROR_PR;


END Al_Trata_Orden;
/
