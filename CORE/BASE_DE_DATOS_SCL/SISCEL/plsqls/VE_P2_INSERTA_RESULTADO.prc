CREATE OR REPLACE PROCEDURE        VE_P2_INSERTA_RESULTADO
(
 vp_cod_vendedor IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
 vp_num_liquidacion VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
 vp_producto IN GE_PRODUCTOS.COD_PRODUCTO%TYPE,
 vp_ctoliq IN VE_CTOLIQ.COD_CTOLIQ%TYPE,
 vp_tip_vendedor IN VE_TIPCOMIS.COD_TIPCOMIS%TYPE,
 vp_fecha_inicial IN DATE,
 vp_fecha_final   IN DATE,
 vp_imp_comision IN VE_RESLIQUIDAC.IMP_COMISION%TYPE,
 vp_cod_cuadrante IN VE_RESLIQUIDAC.COD_CUADRANTE%TYPE,
 vp_num_meta  IN VE_RESLIQUIDAC.NUM_META%TYPE,
 vp_imp_base IN VE_RESLIQUIDAC.IMP_BASE%TYPE,
 vp_num_limite IN VE_RESLIQUIDAC.NUM_LIMITE%TYPE
  )
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='ve_p2_inserta_resultado';
  vp_tabla VARCHAR2(30):='VE_RESLIQUIDAC';
  vp_accion VARCHAR2(1):='S';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
  vp_cero number(1) := 0;
BEGIN
--dbms_output.put_line('Vendedor          '|| to_char( vp_cod_vendedor));
--dbms_output.put_line('Liquidacion       '|| to_char( vp_num_liquidacion));
--dbms_output.put_line('Producto          '|| to_char( vp_producto));
--dbms_output.put_line('Concepto          '|| to_char( vp_ctoliq));
--dbms_output.put_line('Tipo Vendedor     '||  vp_tip_vendedor);
--dbms_output.put_line('Fecha inicial     '|| to_char( vp_fecha_inicial,'dd-mm-yyyy'));
--dbms_output.put_line('Fecha final       '|| to_char( vp_fecha_final,'dd-mm-yyyy'));
--dbms_output.put_line('Importe comision  '|| to_char( vp_imp_comision));
--dbms_output.put_line('Cuadrante         '|| to_char( vp_cod_cuadrante));
--dbms_output.put_line('Meta              '|| to_char( vp_num_meta));
--dbms_output.put_line('Importe base      '|| to_char( vp_imp_base));
--dbms_output.put_line('Num limite        '|| to_char( vp_num_limite));
--dbms_output.put_line('Fecha             '|| to_char( SYSDATE,'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO VE_RESLIQUIDAC (
 NUM_LIQUIDACION, COD_TIPCOMIS, COD_VENDEDOR, COD_CTOLIQ, COD_PRODUCTO,
  IMP_COMISION, IND_ACEPTADO, COD_CUADRANTE, NUM_META, IMP_BASE,
  NUM_LIMITE,  NUM_ANOMALIA )
 VALUES (
  vp_num_liquidacion, vp_tip_vendedor, vp_cod_vendedor, vp_ctoliq, vp_producto,
  vp_imp_comision,  vp_cero, vp_cod_cuadrante, vp_num_meta,  vp_imp_base,
  vp_num_limite,   vp_cero);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
ve_p2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END ve_p2_inserta_resultado;
/
SHOW ERRORS
