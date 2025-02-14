CREATE OR REPLACE PACKAGE BODY VE_PACK_LIQMASTER IS
--------------------------------------------------------
---------------------------------------------------------------
--------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
  --
  -- Retrofitted
  PROCEDURE ve_p_liqmaster_ppal(
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
  --Declaracisn de variables
  v_totcomis NUMBER := 0;
  v_base ve_cuadrantesliq.imp_base%TYPE;
  v_desde ve_cuadcomis.imp_desde%TYPE;
  v_hasta ve_cuadcomis.imp_hasta%TYPE;
  v_rango ve_cuadcomis.imp_rango%TYPE;
  v_meta ve_metavend.num_meta%TYPE;
  v_totsubsid NUMBER;
  v_totcateg NUMBER;
  v_totcatplan NUMBER;
  v_tothabilit NUMBER := 0;
  v_totrenunc NUMBER;
  v_ctoliq NUMBER := TO_NUMBER(SUBSTR(TO_CHAR(vp_ctoliq), 1, 2));
  v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
  v_cumplimiento NUMBER;
  v_sqlcode VARCHAR2(10);
  v_sqlerrm VARCHAR2(70);
  v_mensaje VARCHAR2(255);
  v_totbajas NUMBER :=0;
  --Cuerpo Principal
  BEGIN
   dbms_output.put_line('--------------------------');
   dbms_output.put_line('Producto: ' || vp_producto);
   dbms_output.put_line('Vendedor: ' || vp_vendedor);
   dbms_output.put_line('--------------------------');
   -- Obtenemos el numero de habilitaciones
   if v_ctoliq <> 70 THEN
    ve_p_getnumhab ( vp_vendedor,vp_producto,vp_feciniliq,vp_fecfinliq,
    v_tothabilit,v_sqlcode,v_sqlerrm);
    ve_p_getnumbajhab(vp_vendedor,vp_producto,vp_feciniliq,vp_fecfinliq
  ,v_totbajas);
    v_tothabilit := v_tothabilit - v_totbajas;
    dbms_output.put_line('Habilitaciones: ' || v_tothabilit);
    if v_tothabilit > 0 then
     if v_ctoliq>= 10 and v_ctoliq<=13 then --Habilitaciones
      ve_p_getmonhab(vp_liquidacion,vp_cuadrante,v_tothabilit,
      v_rango,v_sqlcode,v_sqlerrm);
      v_totcomis := v_tothabilit * v_rango;
      dbms_output.put_line('Total Comision Habilitaciones.: ***' || v_totcomis);
     elsif v_ctoliq = 20 then --Premios
      ve_p_getmetaven(vp_liquidacion,vp_ctoliq,vp_vendedor,vp_producto,
      vp_fecfinliq,v_meta,v_sqlcode,v_sqlerrm);
      v_cumplimiento := (v_tothabilit / v_meta) * 100;
      ve_p_getpremios(vp_liquidacion,vp_cuadrante,v_cumplimiento,v_rango);
      v_totcomis := v_tothabilit * v_rango;
      dbms_output.put_line('Total Comision Premios.: ***' || v_totcomis);
     elsif v_ctoliq = 30 then --Plan tarifario
      ve_p_getplantarif(vp_vendedor,vp_producto,vp_feciniliq,vp_fecfinliq
  ,v_totcomis);
      dbms_output.put_line('Total Comision Plan Tarifario.: ***' || v_totcomis);
     elsif v_ctoliq = 31 then --Plan tarifario corporativo
      ve_p_bholding(vp_vendedor,vp_producto,vp_cuadrante,
      vp_feciniliq,vp_fecfinliq,v_totcomis);
      dbms_output.put_line('Total Comision Bono Holding-Empresas:***
  '||v_totcomis);
     elsif v_ctoliq = 35 then --Cambios Plan tarifario
      ve_p_getcambiosplan(vp_vendedor,vp_producto,vp_ctoliq,v_totcomis);
      dbms_output.put_line('Total Comision Cambios Plan Tarif.: ***
  '||v_totcomis);
     elsif v_ctoliq = 60 then --Bono por volumen
      ve_p_getbonovol(vp_liquidacion,v_tothabilit,vp_cuadrante,v_rango);
      v_totcomis := v_tothabilit * v_rango;
      dbms_output.put_line('Total Comision por Bono Volumen.: ***
  ' || v_totcomis);
     elsif v_ctoliq = 80 then --Subsidios
      ve_p_getsubsidios(vp_vendedor,vp_producto,vp_cuadrante,
      vp_feciniliq,vp_fecfinliq,v_totcomis);
      dbms_output.put_line('Total Comision por Bono Volumen.: ***
  ' || v_totcomis);
     elsif v_ctoliq = 81 then --Castigo por renuncias
      ve_p_getrenuncias(vp_vendedor,vp_producto,vp_ctoliq,
      vp_tipcomis,vp_feciniliq,vp_fecfinliq,v_totcomis);
      dbms_output.put_line('Total Comision por Renuncias.: ***' || v_totcomis);
     end if;
    end if;
   else
    --Trafico o Bono Residual
    ve_p_bresidual(vp_liquidacion,vp_vendedor,vp_cuadrante,vp_feciniliq,
    vp_fecfinliq,vp_producto,v_totcomis,v_sqlcode,v_sqlerrm);
    dbms_output.put_line('Total Comision por Bono Residual.: ***
  ' || v_totcomis);
   end if;
   INSERT INTO VE_RESLIQUIDAC (NUM_LIQUIDACION, COD_TIPCOMIS, COD_VENDEDOR,
   COD_CTOLIQ, COD_PRODUCTO,IMP_COMISION,IND_ACEPTADO,COD_CUADRANTE,
   NUM_META,IMP_BASE, NUM_LIMITE, NUM_ANOMALIA)
   VALUES (vp_liquidacion, vp_tipcomis,vp_vendedor,vp_ctoliq, vp_producto,
   v_totcomis,0,vp_cuadrante, null,v_base, null, null);
  EXCEPTION
   WHEN EXCEPTION_ERROR THEN
           dbms_output.put_line('Error:' || v_sqlcode);
      dbms_output.put_line('Descripcisn:' || v_sqlerrm);
      dbms_output.put_line('Mensaje:' || v_mensaje);
   WHEN OTHERS THEN
           dbms_output.put_line('Error:' || v_sqlcode);
      dbms_output.put_line('Descripcisn:' || v_sqlerrm);
  END ve_p_liqmaster_ppal;
  --
  -- Retrofitted
  PROCEDURE ve_p_getmonhab(
  vp_liquidacion IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_tothabilit IN NUMBER ,
  vp_rango IN OUT NUMBER ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
  IS
  --Declaracion de variables
  v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
  BEGIN
   SELECT IMP_RANGO INTO vp_rango
   FROM VE_CUADCOMIS
   WHERE COD_CUADRANTE = vp_cuadrante
   AND vp_tothabilit BETWEEN IMP_DESDE AND IMP_HASTA;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
   vp_sqlcode := sqlcode;
   vp_sqlerrm := sqlerrm;
   vp_rango:=0;
   ve_p_insanomliq (vp_liquidacion,
  'NO EXISTE IMPORTE RANGO PARA EL NUMERO HABILITACIONES ' || vp_tothabilit,
   'VE_PACK_LIQMASTER','VE_CUADCOMIS','S', vp_sqlcode, vp_sqlerrm,v_anomliq);
   WHEN OTHERS THEN
   vp_sqlcode := sqlcode;
   vp_sqlerrm := sqlerrm;
  END ve_p_getmonhab;
  --
  -- Retrofitted
  PROCEDURE ve_p_getnumhab(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_numtothab IN OUT NUMBER ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
  IS
  BEGIN
   SELECT COUNT(*) INTO  vp_numtothab
   FROM VE_VENTALIN
   WHERE COD_VENDE_RAIZ = vp_vendedor
   AND COD_PRODUCTO = vp_producto
   AND IND_OPERACION = 'V'
   AND to_date(FEC_ACEPTVENTA,'dd-mon-yy
  ') BETWEEN vp_feciniliq AND vp_fecfinliq;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
   vp_sqlcode := sqlcode;
   vp_sqlerrm := sqlerrm;
   WHEN OTHERS THEN
   vp_sqlcode := sqlcode;
   vp_sqlerrm := sqlerrm;
  END ve_p_getnumhab;
  --
  -- Retrofitted
  PROCEDURE ve_p_getnumbajhab(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totbajas IN OUT NUMBER )
  IS
  --Declaracion de variables
  v_bajas NUMBER :=0;
  BEGIN
   ve_p_bajas(vp_producto,vp_vendedor,vp_feciniliq,vp_fecfinliq,v_bajas);
   vp_totbajas := v_bajas;
  END ve_p_getnumbajhab;
  --
  -- Retrofitted
  PROCEDURE ve_p_getplantarif(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_TotPlan OUT NUMBER )
  IS
  --Declaracisn de variables.
  v_Total NUMBER := 0;
  v_ImpCat NUMBER := 0;
  v_Abonado ve_renuncias.num_abonado%TYPE := NULL;
  --Declaracisn de cursores.
  CURSOR c_renun_pt IS
   SELECT num_abonado
   FROM  ve_renuncias
   WHERE  cod_vendedor = vp_vendedor
   AND  cod_producto = vp_producto
   AND  TO_DATE(fec_renuncia) BETWEEN vp_feciniliq AND vp_fecfinliq;
  --Cuerpo Principal
  BEGIN
  SELECT NVL(SUM(IMP_CATPLAN),0)
  INTO v_Total
  FROM VE_VENTALIN
  WHERE COD_VENDEDOR = vp_vendedor
  AND COD_PRODUCTO = vp_producto
  AND IND_OPERACION = 'V'
  AND to_date(FEC_ACEPTVENTA,'DD-MON-YY') BETWEEN vp_feciniliq AND vp_fecfinliq;
  --dbms_output.put_line ( 'SubTotal del Plan Tarifario:' || v_Total);
  OPEN c_renun_pt;
  LOOP
   FETCH c_renun_pt INTO v_Abonado;
   EXIT WHEN c_renun_pt%NOTFOUND;
   v_ImpCat := 0;
   SELECT NVL(SUM(imp_catplan),0)
   INTO  v_ImpCat
   FROM  ve_ventalin
   WHERE  cod_vendedor = vp_Vendedor
   AND  cod_producto = vp_Producto
   AND  ind_operacion = 'V'
   AND  num_abonado = v_Abonado;
   --dbms_output.put_line ( 'Restar renuncia:' || v_ImpCat);
   v_Total := v_Total - v_ImpCat;
  END LOOP;
  CLOSE c_renun_pt;
  dbms_output.put_line ( 'Total del Plan Tarifario:' || v_Total);
  vp_TotPlan := v_Total;
  END ve_p_getplantarif;
  --
  -- Retrofitted
  PROCEDURE ve_p_getbonovol(
  vp_liquidacion IN NUMBER ,
  vp_ventasnetas IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_rango IN OUT NUMBER )
  IS
  --Declaracisn de variables.
  v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
  --Cuerpo Principal
  BEGIN
  -- Selecciono el IMPORTE del RANGO
   SELECT IMP_RANGO INTO vp_rango
   FROM VE_CUADCOMIS
   WHERE COD_CUADRANTE = vp_cuadrante
   AND vp_ventasnetas BETWEEN IMP_DESDE AND IMP_HASTA;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
   vp_rango := 0;
   ve_p_insanomliq (vp_liquidacion,'NO SE ENCUENTRA IMPORTE RANGO DEL CUADRANTE
  ' ||
    vp_cuadrante || ' PARA CALCULAR BONO VOLUMEN' ,
    'VE_PACK_LIQMASTER','VE_CUADCOMIS','S', sqlcode, sqlerrm, v_anomliq);
  END ve_p_getbonovol;
  --
  -- Retrofitted
  PROCEDURE ve_p_getpremios(
  vp_liquidacion IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_cumplimiento IN NUMBER ,
  vp_rango IN OUT NUMBER )
  IS
  --Declaracisn de variables.
  v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
  --Cuerpo Principal
  BEGIN
   SELECT IMP_RANGO INTO vp_rango
   FROM VE_CUADCOMIS
   WHERE COD_CUADRANTE = vp_cuadrante
   AND vp_cumplimiento BETWEEN IMP_DESDE AND IMP_HASTA;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
   vp_rango:=0;
   ve_p_insanomliq (vp_liquidacion,'NO SE ENCUENTRA IMPORTE RANGO DEL CUADRANTE
  ' || vp_cuadrante || ' PARA CALCULAR PREMIOS ',
   'VE_PACK_LIQPREMIOS','VE_CUADCOMIS','S', sqlcode, sqlerrm, v_anomliq);
  END ve_p_getpremios;
  --
  -- Retrofitted
  PROCEDURE ve_p_getmetaven(
  vp_liquidacion IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_fecfinliq IN DATE ,
  vp_meta IN OUT VE_METAVEND.NUM_META%TYPE ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
  IS
  --Declaracion de variables
  v_anomliq VE_ANOMLIQ.NUM_ANOMALIA%TYPE := NULL;
  -- Declaracisn de cursores
  CURSOR c_metas IS
   SELECT num_meta
   FROM ve_metavend
   WHERE cod_ctoliq = vp_ctoliq
   AND cod_vendedor = vp_vendedor
   AND cod_producto = vp_producto
   AND TO_DATE(fec_valor,'DD-MON-YY')<=vp_fecfinliq
   AND NVL(fec_finvalor, SYSDATE)>=vp_fecfinliq
   ORDER BY fec_finvalor DESC;
  BEGIN
  OPEN c_metas;
  LOOP
   FETCH c_metas INTO vp_meta; -- Recupera la primera meta del cursor.
   EXIT;     -- Como solo nos interesa una meta, nos salimos.
  END LOOP;
  if c_metas%ROWCOUNT = 0 then  -- Si el cursor no contenma ninguna meta,
   vp_sqlcode := sqlcode;      -- insertamos la anomalia.
   vp_sqlerrm := sqlerrm;
   vp_meta := 0;
   ve_p_insanomliq (vp_liquidacion,'NO HAY META PARA EL VENDEDOR
  ' || vp_vendedor,
   'VE_PACK_LIQMASTER','VE_METAVEND','S', vp_sqlcode, vp_sqlerrm,v_anomliq);
  end if;
  CLOSE c_metas;
  END ve_p_getmetaven;
  --
  -- Retrofitted
  PROCEDURE ve_p_getsubsidios(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totsubsidio IN OUT NUMBER )
  IS
  --Declaracisn de variables.
  v_total NUMBER :=0;
  v_totcat NUMBER;
  v_numcat NUMBER;
  v_impcat NUMBER;
  v_codcat NUMBER;
  --Declaracisn de cursores
  CURSOR c_subsidio IS
   SELECT COUNT(*),COD_CATARTIC
   FROM VE_VENTALIN
   WHERE COD_VENDEDOR = vp_vendedor
   AND COD_PRODUCTO = vp_producto
   AND to_date(FEC_ACEPTVENTA,'dd-mon-yy') BETWEEN vp_feciniliq AND vp_fecfinliq
   GROUP BY COD_CATARTIC;
  --Cuerpo Principal
  BEGIN
   dbms_output.put_line('Calculando subsidios....');
   vp_totsubsidio :=0;
   OPEN c_subsidio;
   LOOP
    -- Calculamos el numero de habilitaciones por categorma.
    FETCH c_subsidio INTO v_numcat,v_codcat;
    EXIT WHEN c_subsidio%NOTFOUND;
    -- Calculamos el bono que pertenece
    -- a la categoria seleccionada
    SELECT IMP_CATEGORIA INTO v_impcat
    FROM VE_CUADCATEG
    WHERE COD_CUADRANTE = vp_cuadrante
    AND IND_ARTICPLAN = 0
    AND COD_CATEGORIA = v_codcat;
  --  dbms_output.put_line( 'Categorma         ' || v_codcat);
  --  dbms_output.put_line( 'N: habilitaciones ' || v_numcat);
  --  dbms_output.put_line( 'Importe bono      ' || v_impcat);
    v_totcat := v_impcat * v_numcat;
  --  dbms_output.put_line( 'Total categoria.: ' || v_totcat);
    v_total := v_total + v_totcat;
   END LOOP;
   CLOSE c_subsidio;
   vp_totsubsidio := v_total;
  END ve_p_getsubsidios;
  --
  -- Retrofitted
  PROCEDURE ve_p_getcambiosplan(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_impcom IN OUT NUMBER )
  IS
  BEGIN
   vp_impcom := 0;
   SELECT SUM(IMP_CAMBIO) INTO vp_impcom
   FROM VE_CAMPLAN
   WHERE COD_VENDEDOR = vp_vendedor
   AND COD_CTOLIQ = vp_ctoliq
   AND COD_PRODUCTO = vp_producto;
  END ve_p_getcambiosplan;
  --
  -- Retrofitted
  PROCEDURE ve_p_getrenuncias(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_tipcomis IN VARCHAR2 ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totrenuncias IN OUT NUMBER )
  IS
  --Declaracisn de variables.
  v_total NUMBER :=0;
  v_impcat NUMBER;
  v_numabonado NUMBER;
  v_cliente NUMBER;
  v_plantarif VARCHAR2(3);
  v_numcat NUMBER;
  v_codcat NUMBER;
  v_totcat NUMBER;
  v_cuadrante NUMBER;
  v_fecalta DATE;
  --Declaracisn de cursores
  CURSOR c_abocel IS
   SELECT NUM_ABONADO,COD_CLIENTE,COD_PLANTARIF,FEC_ALTA
   FROM GA_ABOCEL
   WHERE MONTHS_BETWEEN(FEC_BAJA,FEC_ALTA) < 6
   AND TO_DATE(FEC_BAJA) BETWEEN ADD_MONTHS(vp_fecfinliq
  ,-2) AND ADD_MONTHS(vp_fecfinliq,-1);
  CURSOR c_abobeep IS
   SELECT NUM_ABONADO,COD_CLIENTE,COD_PLANTARIF,FEC_ALTA
   FROM GA_ABOBEEP
   WHERE MONTHS_BETWEEN(FEC_BAJA,FEC_ALTA) < 6
   AND TO_DATE(FEC_BAJA) BETWEEN ADD_MONTHS(vp_fecfinliq
  ,-2) AND ADD_MONTHS(vp_fecfinliq,-1);
  CURSOR c_abotrunk IS
   SELECT NUM_ABONADO,COD_CLIENTE,COD_PLANTARIF,FEC_ALTA
   FROM GA_ABOTRUNK
   WHERE MONTHS_BETWEEN(FEC_BAJA,FEC_ALTA) < 6
   AND TO_DATE(FEC_BAJA) BETWEEN ADD_MONTHS(vp_fecfinliq
  ,-2) AND ADD_MONTHS(vp_fecfinliq,-1);
  CURSOR c_abotrek IS
   SELECT NUM_ABONADO,COD_CLIENTE,COD_PLANTARIF,FEC_ALTA
   FROM GA_ABOTREK
   WHERE MONTHS_BETWEEN(FEC_BAJA,FEC_ALTA) < 6
   AND TO_DATE(FEC_BAJA) BETWEEN ADD_MONTHS(vp_fecfinliq
  ,-2) AND ADD_MONTHS(vp_fecfinliq,-1);
  CURSOR c_subsidio IS
   SELECT COUNT(*),COD_CATARTIC
   FROM VE_VENTALIN
   WHERE NUM_ABONADO = v_numabonado
   AND COD_CLIENTE = v_cliente
   AND COD_PLANTARIF = v_plantarif
   GROUP BY COD_CATARTIC;
  --Cuerpo Principal
  BEGIN
  -- dbms_output.put_line('Calculando renuncias....');
   vp_totrenuncias :=0;
   v_total :=0;
   If vp_producto = 1 THEN
    OPEN c_abocel;
    LOOP
     FETCH c_abocel INTO v_numabonado,v_cliente,v_plantarif,v_fecalta;
     EXIT WHEN c_abocel%NOTFOUND;
     OPEN c_subsidio;
     LOOP
      -- Calculamos el numero de habilitaciones por categorma.
      FETCH c_subsidio INTO v_numcat,v_codcat;
      EXIT WHEN c_subsidio%NOTFOUND;
      -- Seleccionamos el cuadrante que pertenicia
      -- al periodo anterior
      BEGIN
       SELECT COD_CUADRANTE INTO v_cuadrante
       FROM VE_CUADRANTESLIQ
       WHERE COD_CTOLIQ = vp_ctoliq
       AND COD_TIPCOMIS = vp_tipcomis
       AND COD_PRODUCTO = vp_producto
       AND TO_DATE(FEC_EFECTIVIDAD)<= v_fecalta
       AND NVL(FEC_FINEFECTIVIDAD, SYSDATE)> v_fecalta;
       BEGIN
        -- Calculamos el bono que pertenece
        -- a la categoria seleccionada
        SELECT IMP_CATEGORIA INTO v_impcat
        FROM VE_CUADCATEG
        WHERE COD_CUADRANTE = v_cuadrante
        AND IND_ARTICPLAN = 0
        AND COD_CATEGORIA = v_codcat;
        v_totcat := v_impcat * v_numcat;
        v_total := v_total + v_totcat;
       EXCEPTION
        WHEN OTHERS THEN
        NULL;
       END;
      EXCEPTION
       WHEN OTHERS THEN
       NULL;
      END;
     END LOOP;
     CLOSE c_subsidio;
    END LOOP;
    CLOSE c_abocel;
   ELSIF vp_producto = 2 THEN
    OPEN c_abobeep;
    LOOP
     FETCH c_abobeep INTO v_numabonado,v_cliente,v_plantarif,v_fecalta;
     EXIT WHEN c_abobeep%NOTFOUND;
     OPEN c_subsidio;
     LOOP
      -- Calculamos el numero de habilitaciones por categorma.
      FETCH c_subsidio INTO v_numcat,v_codcat;
      EXIT WHEN c_subsidio%NOTFOUND;
      -- Seleccionamos el cuadrante que pertenicia
      -- al periodo anterior
      BEGIN
       SELECT COD_CUADRANTE INTO v_cuadrante
       FROM VE_CUADRANTESLIQ
       WHERE COD_CTOLIQ = vp_ctoliq
       AND COD_TIPCOMIS = vp_tipcomis
       AND COD_PRODUCTO = vp_producto
       AND TO_DATE(FEC_EFECTIVIDAD)<= v_fecalta
       AND NVL(FEC_FINEFECTIVIDAD, SYSDATE)> v_fecalta;
       BEGIN
        -- Calculamos el bono que pertenece
        -- a la categoria seleccionada
        SELECT IMP_CATEGORIA INTO v_impcat
        FROM VE_CUADCATEG
        WHERE COD_CUADRANTE = v_cuadrante
        AND IND_ARTICPLAN = 0
        AND COD_CATEGORIA = v_codcat;
        v_totcat := v_impcat * v_numcat;
        v_total := v_total + v_totcat;
       EXCEPTION
        WHEN OTHERS THEN
        NULL;
       END;
      EXCEPTION
       WHEN OTHERS THEN
       NULL;
      END;
     END LOOP;
     CLOSE c_subsidio;
    END LOOP;
    CLOSE c_abobeep;
   ELSIF vp_producto = 3 THEN
    OPEN c_abotrunk;
    LOOP
     FETCH c_abotrunk INTO v_numabonado,v_cliente,v_plantarif,v_fecalta;
     EXIT WHEN c_abotrunk%NOTFOUND;
     OPEN c_subsidio;
     LOOP
      -- Calculamos el numero de habilitaciones por categorma.
      FETCH c_subsidio INTO v_numcat,v_codcat;
      EXIT WHEN c_subsidio%NOTFOUND;
      -- Seleccionamos el cuadrante que pertenicia
      -- al periodo anterior
      BEGIN
       SELECT COD_CUADRANTE INTO v_cuadrante
       FROM VE_CUADRANTESLIQ
       WHERE COD_CTOLIQ = vp_ctoliq
       AND COD_TIPCOMIS = vp_tipcomis
       AND COD_PRODUCTO = vp_producto
       AND TO_DATE(FEC_EFECTIVIDAD)<= v_fecalta
       AND NVL(FEC_FINEFECTIVIDAD, SYSDATE)> v_fecalta;
       BEGIN
        -- Calculamos el bono que pertenece
        -- a la categoria seleccionada
        SELECT IMP_CATEGORIA INTO v_impcat
        FROM VE_CUADCATEG
        WHERE COD_CUADRANTE = v_cuadrante
        AND IND_ARTICPLAN = 0
        AND COD_CATEGORIA = v_codcat;
        v_totcat := v_impcat * v_numcat;
        v_total := v_total + v_totcat;
       EXCEPTION
        WHEN OTHERS THEN
        NULL;
       END;
      EXCEPTION
       WHEN OTHERS THEN
       NULL;
      END;
     END LOOP;
     CLOSE c_subsidio;
    END LOOP;
    CLOSE c_abotrunk;
   ELSIF vp_producto = 4 THEN
    OPEN c_abotrek;
    LOOP
     FETCH c_abotrek INTO v_numabonado,v_cliente,v_plantarif,v_fecalta;
     EXIT WHEN c_abotrunk%NOTFOUND;
     OPEN c_subsidio;
     LOOP
      -- Calculamos el numero de habilitaciones por categorma.
      FETCH c_subsidio INTO v_numcat,v_codcat;
      EXIT WHEN c_subsidio%NOTFOUND;
      -- Seleccionamos el cuadrante que pertenicia
      -- al periodo anterior
      BEGIN
       SELECT COD_CUADRANTE INTO v_cuadrante
       FROM VE_CUADRANTESLIQ
       WHERE COD_CTOLIQ = vp_ctoliq
       AND COD_TIPCOMIS = vp_tipcomis
       AND COD_PRODUCTO = vp_producto
       AND TO_DATE(FEC_EFECTIVIDAD)<= v_fecalta
       AND NVL(FEC_FINEFECTIVIDAD, SYSDATE)> v_fecalta;
       BEGIN
        -- Calculamos el bono que pertenece
        -- a la categoria seleccionada
        SELECT IMP_CATEGORIA INTO v_impcat
        FROM VE_CUADCATEG
        WHERE COD_CUADRANTE = v_cuadrante
        AND IND_ARTICPLAN = 0
        AND COD_CATEGORIA = v_codcat;
        v_totcat := v_impcat * v_numcat;
        v_total := v_total + v_totcat;
       EXCEPTION
        WHEN OTHERS THEN
        NULL;
       END;
      EXCEPTION
       WHEN OTHERS THEN
       NULL;
      END;
     END LOOP;
     CLOSE c_subsidio;
    END LOOP;
    CLOSE c_abotrek;
   END IF;
   vp_totrenuncias := v_total * (-1);
  END ve_p_getrenuncias;
  --
  -- Retrofitted
  PROCEDURE ve_p_bholding(
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_totbono IN OUT NUMBER )
  IS
  --Declaracisn de variables.
  v_total NUMBER :=0;
  v_implan NUMBER :=0;
  v_tiplan VARCHAR2(1);
  v_impbono NUMBER :=0;
  v_bono NUMBER :=0;
  v_cliente NUMBER;
  v_plantarif VARCHAR2(3);
  v_found NUMBER;
  -- Declaracion cursores
  CURSOR c_cliente IS
   SELECT COD_CLIENTE,COD_PLANTARIF,IMP_CATPLAN
   FROM VE_VENTALIN
   WHERE COD_VENDEDOR = vp_vendedor
   AND COD_PRODUCTO = vp_producto
   AND FEC_ACEPTVENTA BETWEEN
   vp_feciniliq AND vp_fecfinliq;
  --Cuerpo Principal
  BEGIN
   v_total :=0;
   OPEN c_cliente;
   LOOP
    FETCH c_cliente INTO v_cliente,v_plantarif,v_implan;
    EXIT WHEN c_cliente%NOTFOUND;
    -- Buscamos si el plan tarifario
    -- pertenece a Holding o empresa
    SELECT TIP_PLANTARIF INTO v_tiplan
    FROM TA_PLANTARIF
    WHERE COD_PLANTARIF = v_plantarif
    AND TO_DATE(FEC_DESDE) <= vp_fecfinliq
    AND NVL(FEC_HASTA,SYSDATE) > vp_fecfinliq;
    IF v_tiplan = 'H' or v_tiplan = 'E' THEN
     SELECT COUNT(*)INTO v_found
     FROM VE_VENTALIN
     WHERE COD_CLIENTE = v_cliente
     AND FEC_ACEPTVENTA < vp_feciniliq
     AND ROWNUM <=1;
     If v_found = 0 THEN
      v_total:= v_total + v_implan;
     END IF;
    END IF;
   END LOOP;
   CLOSE c_cliente;
   BEGIN
    SELECT IMP_RANGO INTO v_impbono
    FROM VE_CUADCOMIS
    WHERE COD_CUADRANTE = vp_cuadrante
    AND v_total BETWEEN IMP_DESDE and IMP_HASTA;
   EXCEPTION
    WHEN OTHERS THEN
    vp_totbono :=0;
   END;
   vp_totbono := v_impbono;
  END ve_p_bholding;
  --
  -- Retrofitted
  PROCEDURE ve_p_bresidual(
  vp_liquidacion IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_producto IN NUMBER ,
  vp_totbon IN OUT NUMBER ,
  vp_sqlcode IN OUT VARCHAR2 ,
  vp_sqlerrm IN OUT VARCHAR2 )
  IS
  --Declaracisn de variables.
  v_feciniliq DATE := TO_DATE(vp_feciniliq,'DD-MON-YY');
  v_fecfinliq DATE := TO_DATE(vp_fecfinliq,'DD-MON-YY');
  v_anomliq ve_anomliq.num_anomalia%TYPE := NULL;
  v_abonado NUMBER;
  v_cliente NUMBER;
  v_vendedor NUMBER;
  v_tipdoc NUMBER;
  v_notacredito NUMBER;
  v_indord NUMBER;
  v_debe NUMBER;
  v_haber NUMBER;
  v_impcto NUMBER;
  v_codcto NUMBER;
  v_found NUMBER;
  v_total NUMBER :=0;
  v_pct NUMBER;
  v_mescorr NUMBER;
  -- Definicion de cursores
  CURSOR c_abocel IS
   SELECT NUM_ABONADO,COD_CLIENTE
   FROM GA_ABOCEL
   WHERE COD_VENDEDOR_AGENTE = vp_vendedor
   AND MONTHS_BETWEEN (FEC_BAJA,FEC_ALTA) <= v_mescorr;
  CURSOR c_abobeep IS
   SELECT NUM_ABONADO,COD_CLIENTE
   FROM GA_ABOBEEP
   WHERE COD_VENDEDOR_AGENTE = vp_vendedor
   AND MONTHS_BETWEEN (FEC_BAJA,FEC_ALTA) <= v_mescorr;
  CURSOR c_abotrek IS
   SELECT NUM_ABONADO,COD_CLIENTE
   FROM GA_ABOTREK
   WHERE COD_VENDEDOR_AGENTE = vp_vendedor
   AND MONTHS_BETWEEN (FEC_BAJA,FEC_ALTA) <= v_mescorr;
  CURSOR c_abotrunk IS
   SELECT NUM_ABONADO,COD_CLIENTE
   FROM GA_ABOTRUNK
   WHERE COD_VENDEDOR_AGENTE = vp_vendedor
   AND MONTHS_BETWEEN (FEC_BAJA,FEC_ALTA) <= v_mescorr;
  CURSOR c_documento IS
   SELECT COD_TIPDOCUM,IND_ORDENTOTAL
   FROM FA_HISTDOCU
   WHERE COD_CLIENTE = v_cliente
   AND FEC_EMISION
   BETWEEN v_feciniliq and v_fecfinliq;
  CURSOR c_concepto IS
   SELECT COD_CONCEPTO,IMP_FACTURABLE
   FROM FA_HISTCONC
   WHERE IND_ORDENTOTAL = v_indord
   AND COD_PRODUCTO = vp_producto
   AND NUM_ABONADO = v_abonado;
  --Cuerpo Principal
  BEGIN
  ---------------------------------------------
  -- Buscamos el porcentaje parametrico y meses
  -- correlativos por tipo comisionista.
  ---------------------------------------------
  BEGIN
  SELECT IMP_BASE, NUM_LIMITE INTO v_pct, v_mescorr
  FROM VE_CUADRANTESLIQ
  WHERE COD_CUADRANTE = vp_cuadrante
  AND TO_DATE(FEC_EFECTIVIDAD,'DD-MON-YY') <= v_fecfinliq
  AND NVL(FEC_FINEFECTIVIDAD,SYSDATE)> v_fecfinliq;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
   v_pct := 0;
   v_mescorr :=0;
   ve_p_insanomliq (vp_liquidacion,
  'NO SE ENCUENTRA PORCENTAJE Y MESES DEL CUADRANTE'
   || vp_cuadrante || ' PARA CALCULAR BONO RESIDUAL' ,'VE_PACK_LIQMASTER',
   'VE_CUADRANTESLIQ','S', sqlcode, sqlerrm, v_anomliq);
  END;
  dbms_output.put_line('Porcentaje:' || v_pct);
  dbms_output.put_line('Meses correlativos:' || v_mescorr);
  ---------------------------------------------
  -- Buscamos el csdigo de nota de cridito
  ---------------------------------------------
  SELECT COD_NOTACRE INTO v_notacredito
  FROM FA_DATOSGENER;
  dbms_output.put_line('Nota credito:' || v_notacredito);
  -----------------------------------
  -- Calculo del importe total
  -----------------------------------
  v_debe :=0;
  v_haber :=0;
  v_total :=0;
  IF vp_producto = 1 THEN
  --CELULARES
  OPEN c_abocel;
  LOOP
   FETCH c_abocel INTO v_abonado,v_cliente;
   EXIT WHEN c_abocel%NOTFOUND;
   -- Comprobamos que tenga los meses
   -- correlativos. Si aparece en
   -- en renuncias no se cumple condicion
   -- de meses correlativos.
   SELECT COUNT(*) INTO v_found
   FROM VE_RENUNCIAS
   WHERE NUM_ABONADO = v_abonado
   AND ROWNUM<=1;
   if v_found = 0 Then
    dbms_output.put_line('El abonado ' || v_abonado || ' cliente
  ' || v_cliente || ' tiene meses correlativos. ');
    OPEN c_documento;
    LOOP
     FETCH c_documento INTO v_tipdoc,v_indord;
     EXIT WHEN c_documento%NOTFOUND;
     dbms_output.put_line('Documento:' || v_tipdoc);
     OPEN c_concepto;
     LOOP
      FETCH c_concepto INTO v_codcto,v_impcto;
      EXIT WHEN c_concepto%NOTFOUND;
      dbms_output.put_line('Concepto:' || v_codcto);
      dbms_output.put_line('Importe:' || v_impcto);
      SELECT COUNT(*) INTO v_found
      FROM VE_FACCTO
      WHERE COD_CONCEPTO = v_codcto
      AND ROWNUM<=1;
      IF v_found > 0 THEN
       If v_tipdoc = v_notacredito THEN
        v_haber := v_haber + v_impcto;
       ELSE
        v_debe := v_debe + v_impcto;
       END IF;
      END IF;
     END LOOP;
     CLOSE c_concepto;
    END LOOP;
    CLOSE c_documento;
   END IF;
  END LOOP;
  CLOSE c_abocel;
  v_total := (v_debe - v_haber) * (v_pct /100);
  END IF;
  IF vp_producto = 2 THEN
  -- BEEPER
  OPEN c_abobeep;
  LOOP
   FETCH c_abobeep INTO v_abonado,v_cliente;
   EXIT WHEN c_abobeep%NOTFOUND;
   -- Comprobamos que tenga los meses
   -- correlativos. Si aparece en
   -- en renuncias no se cumple condicion
   -- de meses correlativos.
   SELECT COUNT(*) INTO v_found
   FROM VE_RENUNCIAS
   WHERE NUM_ABONADO = v_abonado
   AND ROWNUM<=1;
   if v_found = 0 Then
    dbms_output.put_line('El abonado ' || v_abonado || ' cliente
  ' || v_cliente || ' tiene meses correlativos. ');
    OPEN c_documento;
    LOOP
     FETCH c_documento INTO v_tipdoc,v_indord;
     EXIT WHEN c_documento%NOTFOUND;
     dbms_output.put_line('Documento:' || v_tipdoc);
     OPEN c_concepto;
     LOOP
      FETCH c_concepto INTO v_codcto,v_impcto;
      EXIT WHEN c_concepto%NOTFOUND;
      dbms_output.put_line('Concepto:' || v_codcto);
      dbms_output.put_line('Importe:' || v_impcto);
      SELECT COUNT(*) INTO v_found
      FROM VE_FACCTO
      WHERE COD_CONCEPTO = v_codcto
      AND ROWNUM<=1;
      IF v_found > 0 THEN
       If v_tipdoc = v_notacredito THEN
        v_haber := v_haber + v_impcto;
       ELSE
        v_debe := v_debe + v_impcto;
       END IF;
      END IF;
     END LOOP;
     CLOSE c_concepto;
    END LOOP;
    CLOSE c_documento;
   END IF;
  END LOOP;
  CLOSE c_abobeep;
  v_total := (v_debe - v_haber) * (v_pct /100);
  END IF;
  IF vp_producto = 3 THEN
  -- TRUNKING
  OPEN c_abotrunk;
  LOOP
   FETCH c_abotrunk INTO v_abonado,v_cliente;
   EXIT WHEN c_abotrunk%NOTFOUND;
   -- Comprobamos que tenga los meses
   -- correlativos. Si aparece en
   -- en renuncias no se cumple condicion
   -- de meses correlativos.
   SELECT COUNT(*) INTO v_found
   FROM VE_RENUNCIAS
   WHERE NUM_ABONADO = v_abonado
   AND ROWNUM<=1;
   if v_found = 0 Then
    dbms_output.put_line('El abonado ' || v_abonado || ' cliente
  ' || v_cliente || ' tiene meses correlativos. ');
    OPEN c_documento;
    LOOP
     FETCH c_documento INTO v_tipdoc,v_indord;
     EXIT WHEN c_documento%NOTFOUND;
     dbms_output.put_line('Documento:' || v_tipdoc);
     OPEN c_concepto;
     LOOP
      FETCH c_concepto INTO v_codcto,v_impcto;
      EXIT WHEN c_concepto%NOTFOUND;
      dbms_output.put_line('Concepto:' || v_codcto);
      dbms_output.put_line('Importe:' || v_impcto);
      SELECT COUNT(*) INTO v_found
      FROM VE_FACCTO
      WHERE COD_CONCEPTO = v_codcto
      AND ROWNUM<=1;
      IF v_found > 0 THEN
       If v_tipdoc = v_notacredito THEN
        v_haber := v_haber + v_impcto;
       ELSE
        v_debe := v_debe + v_impcto;
       END IF;
      END IF;
     END LOOP;
     CLOSE c_concepto;
    END LOOP;
    CLOSE c_documento;
   END IF;
  END LOOP;
  CLOSE c_abotrunk;
  v_total := (v_debe - v_haber) * (v_pct /100);
  END IF;
  IF vp_producto = 4 THEN
  OPEN c_abotrek;
  LOOP
   FETCH c_abotrek INTO v_abonado,v_cliente;
   EXIT WHEN c_abotrek%NOTFOUND;
   -- Comprobamos que tenga los meses
   -- correlativos. Si aparece en
   -- en renuncias no se cumple condicion
   -- de meses correlativos.
   SELECT COUNT(*) INTO v_found
   FROM VE_RENUNCIAS
   WHERE NUM_ABONADO = v_abonado
   AND ROWNUM<=1;
   if v_found = 0 Then
    dbms_output.put_line('El abonado ' || v_abonado || ' cliente
  ' || v_cliente || ' tiene meses correlativos. ');
    OPEN c_documento;
    LOOP
     FETCH c_documento INTO v_tipdoc,v_indord;
     EXIT WHEN c_documento%NOTFOUND;
     dbms_output.put_line('Documento:' || v_tipdoc);
     OPEN c_concepto;
     LOOP
      FETCH c_concepto INTO v_codcto,v_impcto;
      EXIT WHEN c_concepto%NOTFOUND;
      dbms_output.put_line('Concepto:' || v_codcto);
      dbms_output.put_line('Importe:' || v_impcto);
      SELECT COUNT(*) INTO v_found
      FROM VE_FACCTO
      WHERE COD_CONCEPTO = v_codcto
      AND ROWNUM<=1;
      IF v_found > 0 THEN
       If v_tipdoc = v_notacredito THEN
        v_haber := v_haber + v_impcto;
       ELSE
        v_debe := v_debe + v_impcto;
       END IF;
      END IF;
     END LOOP;
     CLOSE c_concepto;
    END LOOP;
    CLOSE c_documento;
   END IF;
  END LOOP;
  CLOSE c_abotrek;
  v_total := (v_debe - v_haber) * (v_pct /100);
  END IF;
  vp_totbon := v_total;
  END ve_p_bresidual;
END VE_PACK_LIQMASTER;
/
SHOW ERRORS
