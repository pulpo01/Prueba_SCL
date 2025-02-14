CREATE OR REPLACE PROCEDURE        VE_P_LIQEJECREPR(
  vp_liquidacion IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_catcomis IN NUMBER ,
  vp_tipcomis IN VARCHAR2 ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE )
IS
v_totcomis NUMBER := 0;
v_base ve_cuadrantesliq.imp_base%TYPE;
v_limite ve_cuadrantesliq.num_limite%TYPE;
v_meta ve_metavend.num_meta%TYPE;
v_categoria ve_categorias.cod_categoria%TYPE;
v_bajas NUMBER :=0;
v_tothabilit NUMBER := 0;
v_habi_real NUMBER := 0;
v_cumplimiento NUMBER;
v_ctoliq NUMBER := TO_NUMBER(SUBSTR(TO_CHAR(vp_ctoliq), 1, 2));
v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
v_sqlcode VARCHAR2(10);
v_sqlerrm VARCHAR2(70);
v_error VARCHAR2(2);
BEGIN
   dbms_output.put_line('-----------------------------------');
   dbms_output.put_line('Producto: ' || vp_producto);
   dbms_output.put_line('Vendedor: ' || vp_vendedor);
   dbms_output.put_line('Concepto Liquidacion: ' || vp_ctoliq);
   dbms_output.put_line('-----------------------------------');
   v_error := '0';
   -- Habilitaciones y Premios
   IF (v_ctoliq >= 11 AND v_ctoliq <= 13) OR v_ctoliq = 20 THEN
      -- Total de habilitaciones
      ve_p_ventasreal(vp_vendedor,vp_catcomis,vp_producto,vp_feciniliq
,vp_fecfinliq,v_tothabilit,v_anomliq);
      ve_p_bajas(vp_producto,vp_vendedor,vp_feciniliq,vp_fecfinliq,v_bajas);
 v_habi_real  := v_tothabilit;
 v_tothabilit := v_tothabilit - v_bajas;
      dbms_output.put_line('Total habilitaciones: ' || v_tothabilit);
      IF v_tothabilit > 0 THEN
         -- Meta del vendedor
         BEGIN
            SELECT  NUM_META INTO  v_meta
            FROM  VE_METAVEND
            WHERE  COD_CTOLIQ = vp_ctoliq
            AND  COD_VENDEDOR = vp_vendedor
            AND  FEC_FINVALOR IS NULL;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                 v_sqlcode := sqlcode;
                 v_sqlerrm := sqlerrm;
                 ve_p_insanomliq (vp_liquidacion,
       'NO SE ENCUENTRA META DEFINIDA PARA EL VENDEDOR ' || vp_vendedor,
             'VE_P_LIQEJECREPR','VE_METAVEND','S', v_sqlcode,
       v_sqlerrm, v_anomliq);
                 v_cumplimiento := 0;
                 v_meta := -1;
       v_error :='-1';
                 dbms_output.put_line('Error. No se encontro ninguna meta');
         END;
         -- Control de existencia de meta
         IF v_meta <> -1 THEN
               dbms_output.put_line('Meta: ' || v_meta);
               -- Cumplimiento = total de habilitaciones frente a meta fijada
               v_cumplimiento := TRUNC(v_tothabilit / v_meta * 100, 2);
               dbms_output.put_line('Cumplimiento: ' || v_cumplimiento || '%
');
               -- *********************************************
               -- Habilitaciones
               -- *********************************************
               IF v_ctoliq >= 10 AND v_ctoliq <= 13 THEN
        ve_p_liqhabejecrepr(v_meta,v_habi_real,vp_vendedor,
vp_producto,vp_cuadrante,v_cumplimiento,vp_liquidacion,v_tothabilit,
vp_feciniliq,vp_fecfinliq,v_totcomis);
               -- ******************************************
               -- Premios
               -- ******************************************
               ELSIF v_ctoliq = 20 THEN
   ve_p_premios(vp_cuadrante,v_cumplimiento,vp_liquidacion,vp_catcomis,v_meta
,v_totcomis,v_anomliq);
               END IF;  -- Control de conceptos
         END IF;        -- Existe META
      END IF;           -- Hay habilitaciones
   END IF;
   -- ******************************************
   -- Plan Tarifario
   -- ******************************************
   IF v_ctoliq = 30 THEN
 ve_p_plantarifario(vp_vendedor,vp_producto,vp_feciniliq,vp_fecfinliq
,v_totcomis);
   END IF;
   -- ******************************************
   -- Plan Tarifario Corporativo
   -- ******************************************
   IF v_ctoliq = 31 THEN
 ve_p_plantarifario(vp_vendedor,vp_producto,vp_feciniliq,vp_fecfinliq
,v_totcomis);
   END IF;
   -- ******************************************
   -- Bono de Movilizacisn para Ejecutivos de Venta
   -- ******************************************
   IF v_ctoliq = 15  THEN
      -- Total de habilitaciones
      ve_p_ventasreal(vp_vendedor,vp_catcomis,vp_producto,vp_feciniliq
,vp_fecfinliq,v_tothabilit,v_anomliq);
      ve_p_bajas(vp_producto,vp_vendedor,vp_feciniliq,vp_fecfinliq,v_bajas);
 v_tothabilit := v_tothabilit - v_bajas;
 IF v_tothabilit > 0 THEN
  ve_p_bmovilizacion(vp_cuadrante,v_tothabilit,v_totcomis);
 ELSE
  v_totcomis :=0;
 END IF;
   END IF;
   -- ******************************************
   -- Venta de Articulos/Accesorios
   -- ******************************************
   IF v_ctoliq = 40 THEN
 ve_p_ventarriendo(vp_vendedor,vp_producto,'V
',vp_feciniliq,vp_fecfinliq,v_totcomis);
   END IF;
   -- ******************************************
   -- Arriendos / RentPhone
   -- ******************************************
   IF v_ctoliq = 41 THEN
 ve_p_ventarriendo(vp_vendedor,vp_producto,'R
',vp_feciniliq,vp_fecfinliq,v_totcomis);
   END IF;
   -- ********************************************
   -- Cambios de Equipo
   -- ********************************************
   IF v_ctoliq = 50 THEN
 ve_p_cambioequipo(vp_vendedor,vp_producto,vp_cuadrante,vp_liquidacion
,vp_feciniliq,vp_fecfinliq,v_totcomis,v_anomliq);
   END IF;
   dbms_output.put_line('Total Comision: ************* ' || v_totcomis);
   INSERT INTO VE_RESLIQUIDAC (NUM_LIQUIDACION, COD_TIPCOMIS, COD_VENDEDOR,
   COD_CTOLIQ, COD_PRODUCTO, IMP_COMISION,IND_ACEPTADO, COD_CUADRANTE,
   NUM_META,IMP_BASE, NUM_LIMITE, NUM_ANOMALIA) VALUES (vp_liquidacion,
   vp_tipcomis, vp_vendedor,vp_ctoliq, vp_producto, v_totcomis,0,
   vp_cuadrante, v_meta,v_base, v_limite, v_anomliq);
END;
/
SHOW ERRORS
