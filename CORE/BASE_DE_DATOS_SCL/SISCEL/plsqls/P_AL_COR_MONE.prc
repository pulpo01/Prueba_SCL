CREATE OR REPLACE PROCEDURE P_AL_COR_MONE
(
v_num_transaccion				IN		VARCHAR2,
v_num_corre_x			IN		VARCHAR2) IS
v_glosa_error					VARCHAR2(70);
v_cor_mone						AL_CAB_COR_MONE%ROWTYPE;
v_ind_proc						AL_ARTICULOS.des_articulo%TYPE;
v_num_corre						AL_CAB_COR_MONE.num_corre%TYPE;
v_ao_prov						AL_ARTICULOS.des_articulo%TYPE;
v_ao_sysdate					AL_ARTICULOS.des_articulo%TYPE;
v_count_lineas		   			NUMBER;
v_fecha_prov					AL_ARTICULOS.des_articulo%TYPE;
v_proced						VARCHAR2(70);
ERROR_PROCESO_GENERAL   		EXCEPTION;
CURSOR articulos IS
		   SELECT DISTINCT
		          a.cod_articulo,
		          a.ind_proc,
		          a.tip_articulo
		          FROM AL_PMP_ARTICULO b , AL_ARTICULOS a
		   WHERE a.cod_articulo = b.cod_Articulo;
BEGIN
INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
VALUES (TO_NUMBER(v_num_transaccion), 0, 'error correccion');
V_PROCED:='P_AL_COR_MONE';
v_cor_mone.num_corre := TO_NUMBER(v_num_corre_X);
--*******************************************************************************************
--SELECCION DE LOS DATOS DE LA CABECERA DE LA CORRECCION SEGUN EL CORRELATIVO  IN V_NUM_CORRE
--*******************************************************************************************
SELECT fec_corre, fec_soli,
	   tip_corre, ind_impu, cod_usua, cod_esta
INTO    v_cor_mone.fec_corre, v_cor_mone.fec_soli,
   	   	   v_cor_mone.tip_corre, v_cor_mone.ind_impu , v_cor_mone.cod_usua, v_cor_mone.cod_esta
FROM   AL_CAB_COR_MONE
WHERE num_corre =v_cor_mone.num_corre;
dbms_output.put_line(v_cor_mone.fec_corre);
--Guardo el ao que se har la correccin cuando es provisoria, puede ser cualquier ao antes de sysdate
SELECT TO_CHAR(v_cor_mone.fec_corre,'yyyy')
INTO v_ao_prov
FROM dual;
--Guardo el ao que se har la correccin cuando es provisoria, puede ser cualquier ao antes de sysdate
SELECT TO_CHAR(v_cor_mone.fec_corre,'dd-mm')
INTO v_fecha_prov
FROM dual;
dbms_output.put_line('dia y mes para correccin provisoria es '||v_fecha_prov);
--Guardo el ao que se har la correccin REAL.... es al ao inmediato pasado al sysdate
SELECT TO_CHAR(SYSDATE,'yyyy')-1
INTO v_ao_sysdate
FROM dual;
dbms_output.put_line('ao para correccin real es  '||v_ao_sysdate);
--***************************************************************
--CURSOR CON LOS ARTICULOS Y PROCEDENCIA DE AL_PMP_MERCADERIA
--***************************************************************
--v_ao_prov := '1999';
FOR CC IN articulos LOOP
IF v_cor_mone.fec_corre < TO_DATE('30-06-'||v_ao_prov,'dd-mm-yyyy') THEN
--***************************************************************
-- ENTRO PRIMER SEMESTRE
--***************************************************************
				SELECT COUNT(a.cod_articulo) INTO v_count_lineas
				FROM AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
				WHERE a.cod_articulo = CC.cod_articulo
				AND   a.num_orden = b.num_orden
				AND   fec_creacion BETWEEN TO_DATE('01-01-'||v_ao_prov,'dd-mm-yyyy')
				AND    v_cor_mone.fec_corre;
		--		and   to_date(v_fecha_prov||'-'||v_ao_prov,'dd-mm-yyyy');
				IF v_count_lineas > 0 THEN
					   	   Al_Pac_Cor_Mone.P_AL_CON_ORDENES(v_cor_mone.num_corre,v_cor_mone.fec_corre,CC.ind_proc,CC.cod_articulo,CC.tip_articulo,v_ao_prov);
				ELSE
				-- Caso 2  7 segun procedencia del artculo
				       Al_Pac_Cor_Mone.P_AL_SIN_ORDENES(v_cor_mone.num_corre,v_cor_mone.fec_corre,CC.ind_proc,CC.cod_articulo,CC.tip_articulo,v_ao_prov);
				END IF;
ELSE
--***************************************************************
-- ENTRO SEGUNDO SEMESTRE
--***************************************************************
				SELECT COUNT(a.cod_articulo) INTO v_count_lineas
				FROM AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
				WHERE a.cod_articulo = CC.cod_articulo
				AND   a.num_orden = b.num_orden
				AND   fec_creacion BETWEEN TO_DATE('01-01-'||v_ao_prov,'dd-mm-yyyy')
			    AND   v_cor_mone.fec_corre;
		--		and   to_date(v_fecha_prov||'-'||v_ao_prov,'dd-mm-yyyy');
				IF v_count_lineas > 0 THEN
						   SELECT COUNT(a.cod_articulo) INTO v_count_lineas
						   FROM AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
						   WHERE a.cod_articulo = CC.cod_articulo
						   AND   a.num_orden = b.num_orden
						   AND   fec_creacion BETWEEN TO_DATE('01-07-'||v_ao_prov,'dd-mm-yyyy')
			    AND   v_cor_mone.fec_corre;
					    --   and   to_date(v_fecha_prov||'-'||v_ao_prov,'dd-mm-yyyy');
						   IF v_count_lineas > 0 THEN
								   	  Al_Pac_Cor_Mone.P_AL_CON_ORDENES(v_cor_mone.num_corre,v_cor_mone.fec_corre,CC.ind_proc,CC.cod_articulo,CC.tip_articulo,v_ao_prov);
						   --Caso 4  9 segun procedencia
						   ELSE
						   	   	   Al_Pac_Cor_Mone.P_SEMESTRE2_CON_ORDENES1(v_cor_mone.num_corre,v_cor_mone.fec_corre,CC.ind_proc,CC.cod_articulo,CC.tip_articulo,v_ao_prov);
						   -- Caso 3 u 8 segun procedencia
						   	  	   NULL;
						   END IF;
				ELSE
	        			Al_Pac_Cor_Mone.P_AL_SIN_ORDENES(v_cor_mone.num_corre,v_cor_mone.fec_corre,CC.ind_proc,CC.cod_articulo,CC.tip_articulo,v_ao_prov);
	    --Caso 5  10 segun procedencia
			   	END IF;
END IF;
END LOOP;
EXCEPTION
		WHEN  ERROR_PROCESO_GENERAL  THEN
		        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
		VALUES (TO_NUMBER(v_num_transaccion), 1, 'error correccion');
			   	RAISE_APPLICATION_ERROR (-20205,v_proced||' '||SQLERRM || ' ' || SQLCODE ||'ERROR CORRECCION MONETARIA');
		WHEN OTHERS THEN
		INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
		VALUES (TO_NUMBER(v_num_transaccion), 2, 'error correccion');
	   		   	RAISE_APPLICATION_ERROR (-20204,v_proced||' '||SQLERRM || ' ' || SQLCODE);
END P_AL_COR_MONE;
/
SHOW ERRORS
