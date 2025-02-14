CREATE OR REPLACE PACKAGE BODY Al_Pac_Cor_Mone IS
PROCEDURE P_AL_CON_ORDENES(
v_num_corre    IN   AL_CAB_COR_MONE.num_corre%TYPE,
v_fec_corre    IN   AL_CAB_COR_MONE.fec_corre%TYPE,
v_ind_proc     IN   AL_ARTICULOS.ind_proc%TYPE,
v_cod_arti     IN   AL_ARTICULOS.cod_articulo%TYPE,
v_tip_arti     IN   AL_ARTICULOS.tip_articulo%TYPE,
v_año          IN   AL_ARTICULOS.des_articulo%TYPE) IS
v_exisC_sem1      NUMBER;
v_stock_hist      NUMBER;
v_pmp_hist        NUMBER;
v_exisC_hist      NUMBER;
v_dolar           NUMBER;
dolar1            NUMBER;
dolar2            NUMBER;
CE       	  NUMBER;
TE       	  NUMBER;
VEC               NUMBER;
VE                NUMBER;
CM                NUMBER;
v_stock           NUMBER;
v_error           NUMBER;
BEGIN
v_error:=0;
IF v_ind_proc = 'N' THEN
		SELECT  MAX(a.prc_unidad)                    		   			    Costo_de_reposicion_CE,
	   	SUM(a.can_orden)					     	    			Saldo_Existencias_TE,
		(MAX(a.prc_unidad) * SUM(a.can_orden))   					Valor_de_existencias_VE
		INTO    CE, TE, VE
		FROM    AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
		WHERE   a.cod_articulo = v_cod_arti
		AND     a.num_orden = b.num_orden
		AND     b.fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
		AND     v_fec_corre;
	ELSE
	        SELECT  (MAX(a.prc_unidad)*  c.cambio)     	Costo_de_reposicion_CE_Nac,
		        c.cambio                                Valor_del_dolar
		INTO    CE , v_dolar
		FROM    AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b, ge_conversion c
		WHERE   a.cod_articulo = v_cod_arti
		AND     a.num_orden = b.num_orden
		AND     c.cod_moneda = 002
		AND     c.fec_desde = b.fec_creacion
		AND     b.fec_creacion =(SELECT  MAX(fec_creacion)
				   	 FROM 	 AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
					 WHERE   a.cod_articulo = v_cod_arti
					 AND     a.num_orden = b.num_orden
					 AND     b.fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
					 AND     v_fec_corre)
                GROUP BY c.cambio, a.prc_unidad;

                SELECT SUM(can_orden)
		INTO   TE
		FROM    AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
		WHERE   a.cod_articulo = v_cod_arti
		AND     a.num_orden = b.num_orden
		AND     b.fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
		AND     v_fec_corre;
END IF;
IF v_dolar = 0 AND v_ind_proc = 'I' THEN
    v_error:=1;
END IF;
SELECT  can_stock  		   			   Existencias_Historicas,
prec_pmp					    	           Precio_Medio_ponderado_Hist,
(can_stock* prec_pmp) 		                           Exis_PeriodoP
INTO    v_stock_hist,v_pmp_hist,v_exisC_hist
FROM    AL_PMP_ARTICULO
WHERE   cod_articulo = v_cod_arti
AND     fec_periodo = TO_DATE('01-01-'||(v_año -1),'dd-mm-yyyy');

TE:=TE + v_stock_hist;

SELECT SUM(prc_unidad * can_orden)      existencias_periodo_real
INTO    v_exisC_sem1
FROM   AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
WHERE  a.cod_articulo = v_cod_arti
AND    a.num_orden = b.num_orden
AND    fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
AND    v_fec_corre;

IF v_ind_proc = 'I' THEN
	v_exisC_sem1:=v_exisC_sem1* v_dolar;
END IF;

VE  := CE*TE;
VEC := v_exisC_sem1 +  v_exisC_hist;
CM  := VE - VEC;

SELECT SUM(can_stock)
INTO v_stock
FROM AL_STOCK WHERE cod_articulo = v_cod_arti
AND fec_creacion < v_fec_corre;
INSERT INTO AL_LIN_COR_MONE(NUM_CORRE, COD_ARTICULO, TIP_ARTICULO,
  		 	  				   CAN_STOCK, PMP_HIST, MTO_CORRE, FEC_IMPUTACION)
VALUES      (v_num_corre, v_cod_arti, v_tip_arti,v_stock, v_pmp_hist, CM,NULL);
IF v_error  = 0 THEN
	UPDATE AL_CAB_COR_MONE SET cod_esta = 1
	WHERE num_corre = v_num_corre;
	COMMIT;
ELSE
	UPDATE AL_CAB_COR_MONE SET cod_esta = 2
	WHERE num_corre = v_num_corre;
	ROLLBACK;
END IF;
END P_AL_CON_ORDENES;
--
PROCEDURE P_AL_SIN_ORDENES(
v_num_corre    IN   AL_CAB_COR_MONE.num_corre%TYPE,
v_fec_corre    IN   AL_CAB_COR_MONE.fec_corre%TYPE,
v_ind_proc     IN   AL_ARTICULOS.ind_proc%TYPE,
v_cod_arti     IN   AL_ARTICULOS.cod_articulo%TYPE,
v_tip_arti     IN   AL_ARTICULOS.tip_articulo%TYPE,
v_año          IN   AL_ARTICULOS.des_articulo%TYPE) IS
v_stock_hist       AL_STOCK.can_stock%TYPE;
v_pmp_hist          NUMBER(38,2);
v_exisC_hist        NUMBER(38,2);
dolar1	  	    NUMBER(38,4);
dolar2	            NUMBER(38,4);
v_dolar             NUMBER(38,4);
IPC                 NUMBER(38,4);
CE       	    NUMBER(38,4);
TE       	    NUMBER(38,4);
VEC                 NUMBER(38,2);
VE                  NUMBER(38,2);
CM                  NUMBER(38,2);
v_stock             AL_STOCK.can_stock%TYPE;
v_error             NUMBER;
BEGIN
v_error:=0;
    dbms_output.put_line('entro a sin ordenes');
    dbms_output.put_line('Procedencia'||v_ind_proc);
    dbms_output.put_line('Cod Articulo'||v_cod_arti);
    dbms_output.put_line('Tipo Articulo'||v_tip_arti);
    dbms_output.put_line('Año'||v_año);
    SELECT  can_stock  		   			   Existencias_Históricas,
    prec_pmp						   Precio_Medio_ponderado_Hist,
    (can_stock* prec_pmp) 		   	           Exis_PeriodoP
    INTO    v_stock_hist,v_pmp_hist,v_exisC_hist
    FROM    AL_PMP_ARTICULO
    WHERE   cod_articulo = v_cod_arti
    AND     fec_periodo = TO_DATE('01-01-'||(v_año -1),'dd-mm-yyyy');
    IF v_ind_proc = 'N' THEN
	IF TO_CHAR(v_fec_corre,'dd-mm') = '31-12' THEN
		SELECT SUM(pct_ipc)
		INTO IPC
		FROM ge_ipc
		WHERE mes_ipc BETWEEN ADD_MONTHS(TRUNC(v_fec_corre,'month'),-12)
		AND	ADD_MONTHS(TRUNC(v_fec_corre,'month'),-1);
	ELSE
		IF TO_CHAR(v_fec_corre,'dd-mm')  = '30-06' THEN
			SELECT SUM(pct_ipc)
			INTO IPC
			FROM ge_ipc
			WHERE mes_ipc BETWEEN ADD_MONTHS(TRUNC(v_fec_corre,'month'),-6)
			AND	ADD_MONTHS(TRUNC(v_fec_corre,'month'),-1);
		ELSE
			SELECT SUM(pct_ipc)
			INTO IPC
			FROM ge_ipc
			WHERE mes_ipc BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
			AND	ADD_MONTHS(TRUNC(v_fec_corre,'month'),-1);
		END IF;
	END IF;
    ELSE
    	    SELECT cambio
    	    INTO   dolar1
    	    FROM   ge_conversion
    	    WHERE  fec_desde = TO_DATE('01-01-'||v_año,'dd-mm-yyyy');
    	    SELECT cambio
    	    INTO   dolar2
    	    FROM   ge_conversion
    	    WHERE  cod_moneda = 002
    	    AND    fec_desde = v_fec_corre;
    	    --factor de variacion del dolar en el periodo
            v_dolar := 1 + ((((dolar2 - dolar1)*100)/dolar1)/100);
    END IF;
    IF v_dolar = 0 AND v_ind_proc = 'I' THEN
   	v_error:=1;
    END IF;
    TE := v_stock_hist;
    IF v_ind_proc = 'I' THEN
    	CE := v_pmp_hist* v_dolar;
    ELSE
    	CE := v_pmp_hist * IPC;
    END IF ;
    VEC:= CE*TE;
    VE := v_exisC_hist;
    CM := VE - VEC;
    SELECT NVL(SUM(can_stock),0)
    INTO   v_stock
    FROM   AL_STOCK WHERE cod_articulo = v_cod_arti;
    dbms_output.put_line(v_num_corre);
    dbms_output.put_line(v_cod_arti);
    dbms_output.put_line(v_tip_arti);
    dbms_output.put_line(v_stock);
    dbms_output.put_line(v_pmp_hist);
    dbms_output.put_line(cm);
    INSERT INTO AL_LIN_COR_MONE(NUM_CORRE, COD_ARTICULO, TIP_ARTICULO,
 		 CAN_STOCK, PMP_HIST, MTO_CORRE, FEC_IMPUTACION)
    VALUES      (v_num_corre, v_cod_arti, v_tip_arti,v_stock, v_pmp_hist, CM,NULL);
    IF v_error  = 0 THEN
	UPDATE AL_CAB_COR_MONE SET cod_esta = 1
	WHERE num_corre = v_num_corre;
	COMMIT;
    ELSE
	UPDATE AL_CAB_COR_MONE SET cod_esta = 2
	WHERE num_corre = v_num_corre;
	ROLLBACK;
    END IF;
END P_AL_SIN_ORDENES;
--
PROCEDURE P_SEMESTRE2_CON_ORDENES1(
v_num_corre    IN   AL_CAB_COR_MONE.num_corre%TYPE,
v_fec_corre    IN   AL_CAB_COR_MONE.fec_corre%TYPE,
v_ind_proc     IN   AL_ARTICULOS.ind_proc%TYPE,
v_cod_arti     IN   AL_ARTICULOS.cod_articulo%TYPE,
v_tip_arti     IN   AL_ARTICULOS.tip_articulo%TYPE,
v_año          IN   AL_ARTICULOS.des_articulo%TYPE) IS
v_exisC_sem1        NUMBER;
v_stock_hist        NUMBER;
v_pmp_hist          NUMBER;
v_exisC_hist        NUMBER;
v_dolar             NUMBER;
dolar1              NUMBER;
dolar2              NUMBER;
CE       	    NUMBER;
TE       	  NUMBER;
VEC               NUMBER;
VE                NUMBER;
CM                NUMBER;
IPC               NUMBER;
v_stock           NUMBER;
v_error           NUMBER;
BEGIN
v_error:=0;
IF v_ind_proc = 'N' THEN
	SELECT  MAX(a.prc_unidad)                    		   			    Costo_de_reposicion_CE,
		SUM(a.can_orden)					     	    	    Saldo_Existencias_TE,
		(MAX(a.prc_unidad) * SUM(a.can_orden))   				    Valor_de_existencias_VE
	INTO     CE, TE, VE
	FROM    AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
	WHERE   a.cod_articulo = v_cod_Arti
	AND     a.num_orden = b.num_orden
	AND     b.fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
	AND     v_fec_corre;

	SELECT SUM(pct_ipc)
	INTO IPC
	FROM ge_ipc
	WHERE mes_ipc BETWEEN TO_DATE('01-07-'||v_año,'dd-mm-yyyy')
	AND	ADD_MONTHS(TRUNC(v_fec_corre,'month'),-1);

ELSE
	SELECT  (MAX(a.prc_unidad)*  c.cambio)     	Costo_de_reposicion_CE_Nac,
	        c.cambio                            Valor_del_dolar
	INTO    CE , v_dolar
	FROM    AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b, ge_conversion c
	WHERE   a.cod_articulo = v_cod_arti
	AND     a.num_orden = b.num_orden
	AND     c.cod_moneda = 002
	AND     c.fec_desde = b.fec_creacion
	AND     b.fec_creacion =(SELECT  MAX(fec_creacion)
				   	 FROM 	 AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
					 WHERE   a.cod_articulo = v_cod_arti
					 AND     a.num_orden = b.num_orden
					 AND     b.fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
					 AND     v_fec_corre)
        GROUP BY c.cambio, a.prc_unidad;

        SELECT SUM(can_orden)
	INTO   TE
	FROM    AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
	WHERE   a.cod_articulo = v_cod_arti
	AND     a.num_orden = b.num_orden
	AND     b.fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
	AND     v_fec_corre;

	IF TO_CHAR(v_fec_corre,'dd-mm') = '31-12' THEN
		SELECT cambio
	        INTO   dolar1
	        FROM   ge_conversion
	        WHERE  fec_desde = TO_DATE('01-01-'||v_año,'dd-mm-yyyy');
	        SELECT cambio
	        INTO   dolar2
	        FROM   ge_conversion
	        WHERE  cod_moneda = 002
	        AND    fec_desde = v_fec_corre;
	ELSE
	        SELECT cambio
	        INTO   dolar1
	        FROM   ge_conversion
	        WHERE  fec_desde = TO_DATE('01-07-'||v_año,'dd-mm-yyyy');
	        SELECT cambio
	        INTO   dolar2
	        FROM   ge_conversion
	        WHERE  cod_moneda = 002
	        AND    fec_desde = v_fec_corre;
	END IF;
        --factor de variacion del dolar en el periodo
        v_dolar := 1 + ((((dolar2 - dolar1)*100)/dolar1)/100);
END IF;
IF v_dolar = 0 AND v_ind_proc = 'I' THEN
   v_error:=1;
END IF;
SELECT  can_stock  		   			   Existencias_Historicas,
	prec_pmp						   Precio_Medio_ponderado_Hist,
       (can_stock* prec_pmp) 		   		   Exis_PeriodoP
INTO    v_stock_hist,v_pmp_hist,v_exisC_hist
FROM    AL_PMP_ARTICULO
WHERE   cod_articulo = v_cod_arti
AND     fec_periodo = TO_DATE('01-01-'||(v_año -1),'dd-mm-yyyy');

TE:=TE + v_stock_hist;

SELECT SUM(prc_unidad * can_orden)      existencias_periodo_real
INTO    v_exisC_sem1
FROM   AL_LINEAS_ORDENES1 a , AL_CABECERA_ORDENES1 b
WHERE  a.cod_articulo = v_cod_arti
AND    a.num_orden = b.num_orden
AND    fec_creacion BETWEEN TO_DATE('01-01-'||v_año,'dd-mm-yyyy')
AND    v_fec_corre;
 --	and    to_date('31-12-2002','dd-mm-yyyy');

IF v_ind_proc  = 'N' THEN
 	CE  := CE * IPC;
ELSE
	CE  := CE * v_dolar;
END IF;
VE  := CE * TE;
VEC := v_exisC_sem1 +  v_exisC_hist;
IF v_ind_proc  = 'N' THEN
	VEC := VEC * ipc;
ELSE
  	VEC := VEC * v_dolar;
END IF;
CM  := VE - VEC;
SELECT SUM(can_stock)
INTO v_stock
FROM AL_STOCK WHERE cod_articulo = v_cod_arti;
INSERT INTO AL_LIN_COR_MONE(NUM_CORRE, COD_ARTICULO, TIP_ARTICULO,
 	      CAN_STOCK, PMP_HIST, MTO_CORRE, FEC_IMPUTACION)
VALUES      (v_num_corre, v_cod_arti, v_tip_arti,v_stock, v_pmp_hist, CM,NULL);
IF v_error  = 0 THEN
	UPDATE AL_CAB_COR_MONE SET cod_esta = 1
	WHERE num_corre = v_num_corre;
	COMMIT;
ELSE
	UPDATE AL_CAB_COR_MONE SET cod_esta = 2
	WHERE num_corre = v_num_corre;
	ROLLBACK;
END IF;
END P_SEMESTRE2_CON_ORDENES1;
END Al_Pac_Cor_Mone;
/
SHOW ERRORS
