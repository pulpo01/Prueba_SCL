CREATE OR REPLACE PROCEDURE        VE_P_META(
  vp_liquidacion IN NUMBER ,
  vp_ctoliq IN NUMBER ,
  vp_vendedor IN NUMBER ,
  vp_producto IN NUMBER ,
  vp_feciniliq IN DATE ,
  vp_fecfinliq IN DATE ,
  vp_archivo IN VARCHAR2 ,
  vp_meta OUT NUMBER )
IS
/* Se declara este cursor porque, si la asignacisn de la meta se hace el mismo
dma que la
 liquidacisn, la 'SELECT' puede devolver varias filas; aunque solo se debe
coger la meta
 que metis mas recientement, es decir, aquella cuyo fec_finvalor es <null>.
*/
CURSOR c_metas IS
 SELECT num_meta
 FROM  ve_metavend
 WHERE  cod_ctoliq =  vp_ctoliq
 AND  cod_vendedor =  vp_vendedor
 AND  cod_producto =  vp_producto
 AND TO_DATE(fec_valor,'DD-MON-YY')<=vp_fecfinliq
 AND  NVL ( fec_finvalor, SYSDATE)>=vp_fecfinliq
 ORDER BY fec_finvalor DESC;
/* Si se pretende liquidar un periodo que azn no ha finalizado, es decir, con
fecha de fin  posterior a la fecha del dma (cosa sin sentido), la 'SELECT' no
devolvera nada. */
v_meta VE_METAVEND.NUM_META%TYPE := 0;
v_anomliq VE_ANOMLIQ.NUM_ANOMALIA%TYPE := NULL;
v_sqlcode VARCHAR2(10);
v_sqlerrm VARCHAR2(70);
BEGIN
dbms_output.put_line('---	M E T A	---');
dbms_output.put_line('Producto:	' || vp_producto);
dbms_output.put_line('Vendedor:	' || vp_vendedor);
dbms_output.put_line('Ctoliq:		' || vp_ctoliq);
OPEN c_metas;
LOOP
 FETCH c_metas INTO v_meta; -- Recupera la primera meta del cursor.
 EXIT;     -- Como solo nos interesa la primera de las metas,
END LOOP;     -- nos salimos.
if c_metas%ROWCOUNT = 0 then  -- Si el cursor no contenma ninguna meta,
 v_sqlcode:= sqlcode;  -- insertamos la anomalia.
 v_sqlerrm:= sqlerrm;
 v_meta := -1;
 ve_p_insanomliq ( vp_liquidacion,'NO HAY META PARA EL VENDEDOR'||vp_vendedor,
    vp_Archivo,'VE_METAVEND','S', v_sqlcode, v_sqlerrm, v_anomliq);
end if;
CLOSE c_metas;
vp_meta := v_meta;
dbms_output.put_line('Meta:		' || v_meta);
dbms_output.put_line('------------------------');
END;
/
SHOW ERRORS
