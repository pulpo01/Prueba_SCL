CREATE OR REPLACE PROCEDURE        VE_P2_INSERTA_CABECERA
(
 vp_cod_vendedor    IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
 vp_num_liquidacion IN VE_CABLIQUIDAC.NUM_LIQUIDACION%TYPE,
 vp_fecha           IN DATE,
 vp_fecha_inicial   IN DATE,
 vp_fecha_final     IN DATE
  )
IS
  vp_mensaje VARCHAR2(120):=' ';
  vp_procedure VARCHAR2(30):='ve_p2_inserta_cabecera';
  vp_tabla VARCHAR2(30):='ve_cabliquidac';
  vp_accion VARCHAR2(1):='I';
  vp_sqlcode VARCHAR2(10);
  vp_sqlerrm VARCHAR2(70);
BEGIN
--dbms_output.put_line('-- ');
--dbms_output.put_line('Num Liquidacion   '|| to_char( vp_num_liquidacion));
--dbms_output.put_line('Fecha             '|| to_char( vp_fecha,'dd-mm-yyyy'));
--dbms_output.put_line('Fecha inicial     '|| to_char( vp_fecha_inicial,'dd-mm-yyyy'));
--dbms_output.put_line('Fecha final       '|| to_char( vp_fecha_final,'dd-mm-yyyy'));
INSERT INTO VE_CABLIQUIDAC (
  COD_VENDEDOR,NUM_LIQUIDACION, FEC_INILIQ, FEC_FINLIQ, FEC_LIQUIDACION, NOM_USUARIO)
 VALUES (
  vp_cod_vendedor, vp_num_liquidacion, vp_fecha_inicial, vp_fecha_final,  vp_fecha, USER);
EXCEPTION WHEN NO_DATA_FOUND THEN
vp_sqlcode := sqlcode;
vp_sqlerrm := sqlerrm;
ve_p2_insanomliq(vp_num_liquidacion,vp_mensaje,vp_procedure,vp_tabla,vp_accion,vp_sqlcode,vp_sqlerrm);
END ve_p2_inserta_cabecera;
/
SHOW ERRORS
