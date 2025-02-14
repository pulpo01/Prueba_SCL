CREATE OR REPLACE PROCEDURE        P_AL_TRASPASO_GRUPO_KARDEX_S
(v_error     IN OUT NUMBER)  IS
vp_mov_kar               AL_PDTE_KARDEX%ROWTYPE;
v_secuencia              NUMBER;
v_user                   VARCHAR2(70);
-- campo IND_AGRU = 1 indica que proceso de traspaso kardex se realiza por grupo, es decir por esta pl
--Extraemos el MINIMO valor de cant saldo entre todos los registros
-- para obtener la cantidad real despues de las ENTRADAS
CURSOR PDTE_KARDEX_SALIDA  IS
	SELECT     a.cod_articulo, a.corr_apli, a.tip_movimiento,
			   a.cod_uso, SUM(NVL(a.prc_unitario,0)),SUM(NVL(a.cant_salida,0)),
			   TRUNC(a.fec_movimiento) ,TRUNC(a.fec_periodo),a.cod_bodega, a.ind_entsal,
			   a.tip_stock,MIN(a.num_movkardex), MIN(a.cant_saldo),a.cod_orig, a.ind_proce,
			   MAX(a.prc_pmp), a.cod_usua
	FROM       AL_PDTE_KARDEX a , AL_ARTICULOS b
	WHERE      a.cod_articulo = b.cod_articulo
	AND        b.ind_agru = 1
	AND        a.ind_entsal = 'S'
	GROUP BY   a.cod_articulo,a.corr_apli,a.tip_movimiento,
			   a.cod_bodega,a.ind_proce,a.cod_uso,
			   TRUNC(a.fec_movimiento),TRUNC(a.fec_periodo),a.cod_bodega, a.ind_entsal,
			   a.tip_stock, a.cod_orig,a.cod_usua;
BEGIN
--inicializamos el error en incorrecto (1) , si hace commit cambiamos a correcto (0)
v_error := 1;
-- El Control de errores se acota a WHEN OTHERS ya que no existen llamadas a otros procesos
   OPEN PDTE_KARDEX_SALIDA;
       LOOP
	   		  FETCH PDTE_KARDEX_SALIDA INTO vp_mov_kar.cod_articulo,vp_mov_kar.corr_apli,vp_mov_kar.tip_movimiento,
				 	vp_mov_kar.cod_uso, vp_mov_kar.prc_unitario,vp_mov_kar.cant_salida,
					vp_mov_kar.fec_movimiento,vp_mov_kar.fec_periodo,vp_mov_kar.cod_bodega,
					vp_mov_kar.ind_entsal,vp_mov_kar.tip_stock, vp_mov_kar.num_movkardex,
					vp_mov_kar.cant_saldo, vp_mov_kar.cod_orig, vp_mov_kar.ind_proce,vp_mov_kar.prc_pmp,
					vp_mov_kar.cod_usua;
              EXIT WHEN PDTE_KARDEX_SALIDA %NOTFOUND;
		 --Insercion del Grupo de kardex va con numero de movimiento 0 ya que este concepto no es agrupable
		 -- El numero de Movimiento de KArdex corresponde al manimo del grupo de al_pdte_kardex
		 -- numero de movimiento kardex  = al_seq_kardex.nextval
		 --corr aplli = cod_orig = num_transaccion
		 --cod_estado = 1 (nuevo)
		 INSERT INTO AL_KARDEX(num_movkardex,cod_articulo, corr_apli,tip_movimiento,
		 			cod_uso, prc_unitario,cant_entrada, cant_salida, fec_movimiento,
					fec_periodo, fec_traspaso,cod_usua,num_movimiento,
					cod_bodega,ind_entsal,tip_stock,cod_estado,cod_orig, cant_saldo,
					ind_proce,prc_pmp
					)
				VALUES(vp_mov_kar.num_movkardex,vp_mov_kar.cod_articulo,vp_mov_kar.corr_apli,vp_mov_kar.tip_movimiento,
		 	   	       vp_mov_kar.cod_uso, vp_mov_kar.prc_unitario,0,vp_mov_kar.cant_salida,
					vp_mov_kar.fec_movimiento,vp_mov_kar.fec_periodo,SYSDATE,
					vp_mov_kar.cod_usua,0,vp_mov_kar.cod_bodega,vp_mov_kar.ind_entsal,vp_mov_kar.tip_stock,1,
					vp_mov_kar.cod_orig,vp_mov_kar.cant_saldo, vp_mov_kar.ind_proce,vp_mov_kar.prc_pmp);
		 --Borramos al_pdte_kardex segun el Flag de Articulos agrupables y  la condicion de entrada
		 --ocupamos la_PK num_movkardex para agilizar el proceso
  		 DELETE AL_PDTE_KARDEX
		 WHERE num_movkardex > 0
		 AND   ind_entsal = 'S'
		 AND   cod_articulo IN (SELECT cod_articulo FROM AL_ARTICULOS WHERE ind_agru = 1);

END LOOP;
CLOSE PDTE_KARDEX_SALIDA;
COMMIT;
v_error:=0;
EXCEPTION
          WHEN OTHERS THEN
               ROLLBACK;
 	       RAISE_APPLICATION_ERROR (-20002,'TMError:' || TO_CHAR(SQLCODE) || SQLERRM || ' ERROR GENERICO.');
END P_AL_TRASPASO_GRUPO_KARDEX_S;
/
SHOW ERRORS
