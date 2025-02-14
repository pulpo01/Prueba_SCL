CREATE OR REPLACE PROCEDURE p_revalorizarticulo_pr(
v_articulo al_articulos.cod_articulo%TYPE,
v_precio   al_series.prc_compra%TYPE ) IS
/* ACTUALIZA PRECIO DE INVENTARIO PARA EL ARTICULO
INDICADO EN PARAMETRO V_ARTICULO  Y PRECIO EN V_PRECIO
*/

Error_proceso EXCEPTION;
BEGIN
if v_precio > 0 then
	-- MODIFICO INVENTARIO
	UPDATE al_series
	SET prc_compra = v_precio
	WHERE cod_articulo = v_articulo;
	-- MODIFICO PMP
	UPDATE al_pmp_mercaderia
	SET prc_pmp = v_precio
	WHERE cod_articulo = v_articulo
        AND   fec_ejercicio = to_date('01-01-2004','dd-mm-yyyy');
	-- MODIFICO AL_MOVIMIENTOS
	UPDATE al_movimientos a
	SET a.prc_unidad = v_precio
	WHERE a.num_movimiento > -1
	AND a.cod_articulo = v_Articulo
	AND a.fec_movimiento > to_date('31-12-2003 23:59:59','dd-mm-yyyy hh24:mi:ss')
	AND EXISTS (SELECT 1 FROM al_tipos_movimientos b
			    WHERE b.ind_entsal = 'E'
				AND   a.tip_movimiento = b.tip_movimiento);
	--MODIFICO KARDEX
	UPDATE al_kardex a
	SET a.prc_unitario = v_precio
	WHERE a.num_movkardex > -1
	AND a.cod_articulo = v_articulo
	AND ind_entsal ='E'
	AND a.fec_movimiento > to_date('31-12-2003 23:59:59','dd-mm-yyyy hh24:mi:ss');
	--MODIFICO PDTE KARDEX
	UPDATE al_pdte_kardex a
	SET a.prc_unitario = v_precio
	WHERE a.num_movkardex > -1
	AND a.cod_articulo = v_articulo
	AND ind_entsal ='E'
	AND a.fec_movimiento > to_date('31-12-2003 23:59:59','dd-mm-yyyy hh24:mi:ss');
	--MODIFICO PMP ARTICULO
	UPDATE al_pmp_articulo
	SET    prec_pmp = v_precio
	WHERE  cod_articulo =v_articulo
	AND    fec_periodo >  to_date('31-12-2003 23:59:59','dd-mm-yyyy hh24:mi:ss');
	-- MODIFICO PDTE CALCULO
	UPDATE al_pdte_calculo
	SET prc_unidad = v_precio
	WHERE cod_articulo = v_Articulo;
else
	raise Error_proceso;
end if;
	--FIN;
EXCEPTION
		 WHEN ERROR_PROCESO then
--		 	  RAISE_APPLICATION_ERROR('2001','Error numero negativo');
			  		 RAISE_APPLICATION_ERROR(SQLCODE||SQLERRM,'Error valor numerico no valido');
		 WHEN OTHERS THEN
		 		 rollback;
		 		 RAISE_APPLICATION_ERROR(SQLCODE||SQLERRM,'Error Inesperado Actualizando precio');
END;

/
SHOW ERRORS
