CREATE OR REPLACE PROCEDURE        VE_P_LIQHABEJECREPR(
  v_meta IN ve_metavend.num_meta%TYPE ,
  v_habi_real IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_cuadrante IN NUMBER ,
  vp_cumplimiento IN NUMBER ,
  vp_liquidacion IN NUMBER ,
  vp_habilitaciones IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_TotHab IN OUT NUMBER )
IS
--Declaracisn de variables
v_categoria ve_categorias.cod_categoria%TYPE;
v_numhabcateg NUMBER := 0;
v_factor_habili  NUMBER := 0;
v_desde ve_cuadcomis.imp_desde%TYPE;
v_hasta ve_cuadcomis.imp_hasta%TYPE;
v_rango ve_cuadcomis.imp_rango%TYPE;
v_ajuste NUMBER;
v_totcomis NUMBER := 0;
v_factcorr NUMBER;
--Declaracisn de cursores
CURSOR c_habporcateg IS
 SELECT COD_CATARTIC, COUNT(*)
 FROM VE_VENTALIN
 WHERE COD_VENDEDOR = vp_vendedor
 AND COD_PRODUCTO = vp_producto
 AND IND_OPERACION = 'V'
 AND FEC_ACEPTVENTA BETWEEN vp_feciniliq AND vp_fecfinliq
 GROUP BY COD_CATARTIC;
CURSOR c_rangoporcateg IS
 SELECT IMP_DESDE, IMP_HASTA, IMP_RANGO
 FROM VE_CUADCOMIS
 WHERE COD_CUADRANTE = vp_cuadrante
 AND COD_CATEGORIA = v_categoria
 AND IMP_DESDE <= vp_cumplimiento
 ORDER BY  IMP_DESDE ;
--Cuerpo Principal
BEGIN
OPEN c_habporcateg;
LOOP
  FETCH c_habporcateg
  INTO v_categoria, v_numhabcateg;
  EXIT WHEN c_habporcateg%NOTFOUND;
  dbms_output.put_line('****************************');
  dbms_output.put_line('Categoria: ' || v_categoria);
  dbms_output.put_line(v_numhabcateg || ' habilitparacategoria'||v_categoria);
  v_factor_habili := TRUNC(( vp_habilitaciones/v_habi_real),2);
  dbms_output.put_line(vp_habilitaciones || ' / ' ||v_habi_real || '
--->'||v_factor_habili );
  dbms_output.put_line('Porcentaje sobre el total del ' ||vp_cumplimiento||' %
');
  OPEN c_rangoporcateg;
  LOOP
    FETCH c_rangoporcateg
    INTO v_desde, v_hasta, v_rango;
    EXIT WHEN c_rangoporcateg%NOTFOUND;
    dbms_output.put_line('+++++++++++++++++++++++');
    dbms_output.put_line('Meta: ' || v_meta);
    dbms_output.put_line('Desde: ' || v_desde);
    dbms_output.put_line('Hasta: ' || v_hasta);
    -- % de habilitaciones por categorma frente al total
   dbms_output.put_line(v_numhabcateg || ' / ' ||vp_habilitaciones );
    v_factcorr := TRUNC(v_numhabcateg / vp_habilitaciones , 2);
    dbms_output.put_line('Factor Correc.: ' || v_factcorr);
    IF v_hasta > 100 THEN
       IF v_desde <= 100 THEN
           IF vp_cumplimiento > 100 THEN
          v_ajuste := TRUNC((100 - v_desde + 0.01)/100, 2);
               v_totcomis := TRUNC(v_totcomis + (v_ajuste* v_meta* v_rango
                                          *v_factcorr*v_factor_habili),2);
          v_ajuste := 1;
          v_totcomis := TRUNC(v_totcomis+ (v_ajuste *( vp_habilitaciones -
                                      v_meta)* v_rango
                                      *v_factcorr*v_factor_habili),2);
      ELSE
              v_ajuste := TRUNC((vp_cumplimiento - v_desde+ 0.01) /100, 2);
         v_totcomis := TRUNC(v_totcomis+ (v_ajuste* v_meta* v_rango*
v_factcorr*v_factor_habili),2);
           END IF;
       ELSE
          v_ajuste := 1;
          v_totcomis := TRUNC(v_totcomis+ (v_ajuste *(vp_habilitaciones -
v_meta)* v_rango  * v_factcorr*v_factor_habili),2);
dbms_output.put_line(v_ajuste ||'*('||vp_habilitaciones ||'-'|| v_meta||')*
'|| v_rango ||
     '*'|| v_factcorr ||'*'|| v_factor_habili);
       END IF;
    ELSE
      IF vp_cumplimiento < v_hasta THEN
           v_ajuste := TRUNC((vp_cumplimiento - v_desde+ 0.01) /100, 2);
           v_totcomis := TRUNC(v_totcomis+ (v_ajuste* v_meta * v_rango*
v_factcorr*v_factor_habili),2);
  ELSE
           v_ajuste := TRUNC((v_hasta - v_desde + 0.01)/100, 2);
           v_totcomis := TRUNC(v_totcomis + (v_ajuste* v_meta* v_rango*
v_factcorr*v_factor_habili),2);
    END IF;
    END IF;
    dbms_output.put_line('Ajuste: ' || v_ajuste);
    dbms_output.put_line('Rango: ' || v_rango);
    dbms_output.put_line('Comision: ' || v_totcomis);
  END LOOP;
  CLOSE c_rangoporcateg;
END LOOP;
CLOSE c_habporcateg;
dbms_output.put_line('Tot matriz habilitaciones : *********** ' ||v_totcomis);
vp_TotHab := v_totcomis;
END;
/
SHOW ERRORS
