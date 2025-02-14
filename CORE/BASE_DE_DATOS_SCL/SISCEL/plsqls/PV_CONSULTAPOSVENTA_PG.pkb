CREATE OR REPLACE PACKAGE BODY PV_CONSULTAPOSVENTA_PG
AS
PROCEDURE PV_AFCAMBIOPLAN_PR(v_nnum_abonado IN NUMBER,
		  					 v_dfec_desdellam OUT GA_INTARCEL.FEC_DESDE%TYPE,
							 v_vcod_plantarif OUT GA_INTARCEL.COD_PLANTARIF%TYPE,
							 v_dfec_cumplan OUT GA_ABOCEL.FEC_CUMPLAN%TYPE,
							 v_nimp_cargobasico OUT TA_CARGOSBASICO.COD_CARGOBASICO%TYPE,
							 v_nCodCliente IN GE_CLIENTES.COD_CLIENTE%TYPE)
IS
ERROR3        EXCEPTION;
ERROR1        EXCEPTION;
ERROR2        EXCEPTION;
flag          NUMBER;
CodProducto   GA_ABOCEL.COD_PRODUCTO%TYPE;

	BEGIN
    	  flag :=0;
          BEGIN
            BEGIN
              SELECT COD_PRODUCTO
              INTO CodProducto
              FROM GA_ABOCEL
              WHERE NUM_ABONADO = v_nnum_abonado;
          EXCEPTION WHEN NO_DATA_FOUND THEN
              flag :=3;
            END;
          IF flag != 0 THEN
             RAISE ERROR3;
          END IF;

            SELECT A.COD_PLANTARIF , A.FEC_DESDE, B.IMP_CARGOBASICO
            INTO   v_vcod_plantarif,v_dfec_desdellam,v_nimp_cargobasico
            FROM   GA_INTARCEL A, TA_CARGOSBASICO B
            WHERE  A.NUM_ABONADO = v_nnum_abonado
            AND    A.COD_CLIENTE = v_nCodCliente
            AND    B.COD_PRODUCTO = CodProducto
            AND    B.COD_CARGOBASICO = A.COD_CARGOBASICO
            AND    A.FEC_DESDE   = ( SELECT MAX(C.FEC_DESDE)
                                     FROM   GA_INTARCEL C
                                     WHERE  C.NUM_ABONADO = v_nnum_abonado
                         			 AND    C.COD_CLIENTE = v_nCodCliente )
            AND    SYSDATE <= NVL(B.FEC_HASTA,SYSDATE);

--          DBMS_OUTPUT.PUT_LINE('v_vcod_plantarif,v_dfec_desdellam,v_nimp_cargobasico :'||v_vcod_plantarif||','||v_dfec_desdellam||','||v_nimp_cargobasico);
          EXCEPTION WHEN NO_DATA_FOUND THEN
                flag :=1;
          END;
          IF flag != 0 THEN
--   	         DBMS_OUTPUT.PUT_LINE('flag :'||flag);
             RAISE ERROR1;
          END IF;


         BEGIN
             SELECT fec_cumplan
             INTO   v_dfec_cumplan
             FROM   ga_abocel
             WHERE  num_abonado  = v_nnum_abonado;
         EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                 SELECT fec_cumplan
                 INTO   v_dfec_cumplan
                 FROM   ga_aboamist
                 WHERE  num_abonado  = v_nnum_abonado;
             EXCEPTION WHEN NO_DATA_FOUND THEN
    	         flag :=2;
             END;
         END;
		 IF flag != 0 THEN
--   	        DBMS_OUTPUT.PUT_LINE('flag :'||flag);
		    RAISE ERROR2;
		 END IF;
         DBMS_OUTPUT.PUT_LINE('v_dfec_cumplan :'||v_dfec_cumplan);
	 EXCEPTION
           	WHEN ERROR1 THEN
           		 RAISE_APPLICATION_ERROR(-30100,'GR_DETOFERTAFICHA_PR1('||TO_CHAR(v_nnum_abonado)||', '||v_dfec_desdellam||', '||v_vcod_plantarif||', '||v_dfec_cumplan||', '||v_nimp_cargobasico||') - '||SQLERRM);
	       	WHEN ERROR2 THEN
           		 RAISE_APPLICATION_ERROR(-30101,'GR_DETOFERTAFICHA_PR1('||TO_CHAR(v_nnum_abonado)||', '||v_dfec_desdellam||', '||v_vcod_plantarif||', '||v_dfec_cumplan||', '||v_nimp_cargobasico||') - '||SQLERRM);
	       	WHEN ERROR3 THEN
           		 RAISE_APPLICATION_ERROR(-30102,'GR_DETOFERTAFICHA_PR1('||TO_CHAR(v_nnum_abonado)||', '||v_dfec_desdellam||', '||v_vcod_plantarif||', '||v_dfec_cumplan||', '||v_nimp_cargobasico||') - '||SQLERRM);
	       	WHEN OTHERS THEN
           		 RAISE_APPLICATION_ERROR(-30103,'GR_DETOFERTAFICHA_PR1('||TO_CHAR(v_nnum_abonado)||', '||v_dfec_desdellam||', '||v_vcod_plantarif||', '||v_dfec_cumplan||', '||v_nimp_cargobasico||') - '||SQLERRM);

END PV_AFCAMBIOPLAN_PR;

PROCEDURE PV_AFCAMBIOSERIE_PR(v_nnum_abonado IN NUMBER,
		  					 v_vdes_articulo OUT AL_ARTICULOS.DES_ARTICULO%TYPE,
							 v_vcod_tecnologia OUT GA_ABOCEL.COD_TECNOLOGIA%TYPE,
							 v_nimp_cargo_s OUT GE_CARGOS.IMP_CARGO%TYPE)
IS
v_nTipCliente NUMBER;
flag          NUMBER; -- 0 = No Error != 0 Errror
ERROR1        EXCEPTION;
ERROR2        EXCEPTION;
    BEGIN
	      flag:= 0;
	      SELECT TECN,TIPCLIE
		  INTO v_vcod_tecnologia,v_nTipCliente
		  FROM(
		 	  SELECT COD_TECNOLOGIA TECN,1 TIPCLIE
			  FROM GA_ABOCEL
			  WHERE NUM_ABONADO = v_nnum_abonado
	          UNION
			  SELECT COD_TECNOLOGIA TECN,2 TIPCLIE
			  FROM GA_ABOAMIST
			  WHERE NUM_ABONADO = v_nnum_abonado);

   --     DBMS_OUTPUT.PUT_LINE('TECN,TIPCLIE :'||v_vcod_tecnologia||','||v_nTipCliente);

		 IF v_vcod_tecnologia = 'GSM' THEN
		    BEGIN
			     IF v_nTipCliente = 1 THEN
				     SELECT d.imp_cargo,c.des_articulo
		             INTO   v_nimp_cargo_s,v_vdes_articulo
		             FROM   ga_abocel a, ga_equipaboser b, al_articulos c, ge_cargos d
		             WHERE  a.num_abonado     = b.num_abonado
		             AND    a.num_imei        = b.num_serie
		             AND    b.cod_articulo    = c.cod_articulo
		             AND    c.cod_producto    = 1
		             AND    c.cod_conceptoart = d.cod_concepto
		             AND    a.cod_cliente     = d.cod_cliente
		             AND    a.num_abonado     = d.num_abonado
		             AND    TRUNC(b.fec_alta) = TRUNC(d.fec_alta)
		             AND    a.num_abonado     = v_nnum_abonado;
				 ELSE
	 			     SELECT d.imp_cargo,c.des_articulo
		             INTO   v_nimp_cargo_s,v_vdes_articulo
		             FROM   ga_aboamist a, ga_equipaboser b, al_articulos c, ge_cargos d
		             WHERE  a.num_abonado     = b.num_abonado
		             AND    a.num_imei        = b.num_serie
		             AND    b.cod_articulo    = c.cod_articulo
		             AND    c.cod_producto    = 1
		             AND    c.cod_conceptoart = d.cod_concepto
		             AND    a.cod_cliente     = d.cod_cliente
		             AND    a.num_abonado     = d.num_abonado
		             AND    TRUNC(b.fec_alta) = TRUNC(d.fec_alta)
		             AND    a.num_abonado     = v_nnum_abonado;
				 END IF;
     		EXCEPTION WHEN NO_DATA_FOUND THEN
				flag :=1;
			END;
			IF flag != 0 THEN
		--	DBMS_OUTPUT.PUT_LINE('flag :'||flag);
			   RAISE ERROR1;
			END IF;
		--	DBMS_OUTPUT.PUT_LINE('v_nimp_cargo_s,v_vdes_articulo GSM:'||v_nimp_cargo_s||','||v_vdes_articulo);
		 ELSE
		    BEGIN
			     IF v_nTipCliente = 1 THEN
	                 SELECT d.imp_cargo,c.des_articulo
	                 INTO   v_nimp_cargo_s,v_vcod_tecnologia
	                 FROM   ga_abocel a, ga_equipaboser b, al_articulos c, ge_cargos d
	                 WHERE  a.num_abonado     = b.num_abonado
	                 AND    a.num_serie       = b.num_serie
	                 AND    b.cod_articulo    = c.cod_articulo
		             AND    c.cod_producto    = 1
	                 AND    c.cod_conceptoart = d.cod_concepto
	                 AND    a.cod_cliente     = d.cod_cliente
	                 AND    a.num_abonado     = d.num_abonado
	                 AND    TRUNC(b.fec_alta) = TRUNC(d.fec_alta)
	                 AND    a.num_abonado     = v_nnum_abonado;
				 ELSE
	                 SELECT d.imp_cargo,c.des_articulo
	                 INTO   v_nimp_cargo_s,v_vcod_tecnologia
	                 FROM   ga_aboamist a, ga_equipaboser b, al_articulos c, ge_cargos d
	                 WHERE  a.num_abonado     = b.num_abonado
	                 AND    a.num_serie       = b.num_serie
	                 AND    b.cod_articulo    = c.cod_articulo
		             AND    c.cod_producto    = 1
	                 AND    c.cod_conceptoart = d.cod_concepto
	                 AND    a.cod_cliente     = d.cod_cliente
	                 AND    a.num_abonado     = d.num_abonado
	                 AND    TRUNC(b.fec_alta) = TRUNC(d.fec_alta)
	                 AND    a.num_abonado     = v_nnum_abonado;
				 END IF;
     		EXCEPTION WHEN NO_DATA_FOUND THEN
				flag:= 2;
			END;
			IF flag != 0 THEN
		--	DBMS_OUTPUT.PUT_LINE('flag :'||flag);
			   RAISE ERROR2;
			END IF;
		--	DBMS_OUTPUT.PUT_LINE('v_nimp_cargo_s,v_vdes_articulo <> GSM:'||v_nimp_cargo_s||','||v_vdes_articulo);
		 END IF;
	EXCEPTION
			WHEN ERROR1 THEN
				 RAISE_APPLICATION_ERROR(-30104,'GR_DETOFERTAFICHA_PR2('||TO_CHAR(v_nnum_abonado)||', '||v_vdes_articulo||', '||v_vcod_tecnologia||', '||v_nimp_cargo_s||') - '||SQLERRM);
			WHEN ERROR2 THEN
				 RAISE_APPLICATION_ERROR(-30105,'GR_DETOFERTAFICHA_PR2('||TO_CHAR(v_nnum_abonado)||', '||v_vdes_articulo||', '||v_vcod_tecnologia||', '||v_nimp_cargo_s||') - '||SQLERRM);
           	WHEN OTHERS THEN
           		 RAISE_APPLICATION_ERROR(-30106,'GR_DETOFERTAFICHA_PR2('||TO_CHAR(v_nnum_abonado)||', '||v_vdes_articulo||', '||v_vcod_tecnologia||', '||v_nimp_cargo_s||') - '||SQLERRM);

END PV_AFCAMBIOSERIE_PR;


PROCEDURE PV_NAMIGARCIONPREPAGO_PR(v_nnum_abonado IN NUMBER,
		  						   v_dfec_baja OUT GA_ABOCEL.FEC_BAJA%TYPE,
								   v_nnum_abonado_c OUT GA_ABOCEL.NUM_ABONADO%TYPE,
								   v_dfec_bajacen_c OUT GA_ABOCEL.FEC_BAJACEN%TYPE,
								   v_dfec_alta_c OUT GE_CARGOS.FEC_ALTA%TYPE,
								   v_nimp_cargo_c OUT GE_CARGOS.IMP_CARGO%TYPE)
IS
flag          NUMBER; -- 0 = No Error != 0 Errror
ERROR1        EXCEPTION;
ERROR2        EXCEPTION;
BEGIN
	 	 flag := 0;
         BEGIN
             SELECT fec_baja
             INTO   v_dfec_baja
             FROM   ga_abocel
             WHERE  num_abonado = v_nnum_abonado;
         EXCEPTION WHEN NO_DATA_FOUND THEN
             BEGIN
                 SELECT fec_baja
                 INTO   v_dfec_baja
                 FROM   ga_aboamist
                 WHERE  num_abonado = v_nnum_abonado;
             EXCEPTION WHEN NO_DATA_FOUND THEN
				flag:= 1;
			 END;
         END;
    	 IF flag != 0 THEN
    	--	DBMS_OUTPUT.PUT_LINE('flag :'||flag);
		    RAISE ERROR1;
		 END IF;
	--	 DBMS_OUTPUT.PUT_LINE('v_dfec_baja :'||v_dfec_baja);
         BEGIN
			SELECT A.NUM_ABONADO, A.FEC_BAJACEN, D.FEC_ALTA, D.IMP_CARGO
            INTO   v_nnum_abonado_c,v_dfec_bajacen_c, v_dfec_alta_c, v_nimp_cargo_c
			FROM   GA_ABOCEL A, GED_PARAMETROS B, GA_ACTUASERV C, GE_CARGOS D
			WHERE  A.NUM_ABONADO     = v_nnum_abonado
			AND    B.NOM_PARAMETRO   = 'COD_CONCEPTO_INDEM'
			AND    B.COD_PRODUCTO    = 1 --(PRODUCTO CELULAR)
			AND    B.COD_MODULO      = 'GA'
			AND    C.COD_SERVICIO    = B.VAL_PARAMETRO
			AND    C.COD_PRODUCTO    = 1 --(PRODUCTO CELULAR)
			AND    D.NUM_ABONADO     = A.NUM_ABONADO
			AND    D.COD_CLIENTE     = A.COD_CLIENTE
			AND    D.COD_CONCEPTO    = C.COD_CONCEPTO
			AND    C.COD_ACTABO      = 'BA'
			AND    TRUNC(A.FEC_BAJA) = TRUNC(D.FEC_ALTA);
            EXCEPTION WHEN NO_DATA_FOUND THEN
	    		flag:= 2;
		    END;
			IF flag != 0 THEN
    --		   DBMS_OUTPUT.PUT_LINE('v_nnum_abonado_c,v_dfec_bajacen_c, v_dfec_alta_c, v_nimp_cargo_c :'||v_nnum_abonado_c||','||v_dfec_bajacen_c||','|| v_dfec_alta_c||','|| v_nimp_cargo_c);
			   RAISE ERROR2;
			END IF;
		--	DBMS_OUTPUT.PUT_LINE('v_nnum_abonado_c,v_dfec_bajacen_c, v_dfec_alta_c, v_nimp_cargo_c :'||v_nnum_abonado_c||','||v_dfec_bajacen_c||','|| v_dfec_alta_c||','|| v_nimp_cargo_c);
	 EXCEPTION
	 		WHEN ERROR1 THEN
           		 RAISE_APPLICATION_ERROR(-30107,'GR_DETOFERTAFICHA_PR3('||TO_CHAR(v_nnum_abonado)||', '||v_dfec_baja||', '||v_nnum_abonado_c||', '||v_dfec_bajacen_c||', '||v_dfec_alta_c||', '||v_nimp_cargo_c||') - '||SQLERRM);
			WHEN ERROR2 THEN
           		 RAISE_APPLICATION_ERROR(-30108,'GR_DETOFERTAFICHA_PR3('||TO_CHAR(v_nnum_abonado)||', '||v_dfec_baja||', '||v_nnum_abonado_c||', '||v_dfec_bajacen_c||', '||v_dfec_alta_c||', '||v_nimp_cargo_c||') - '||SQLERRM);
           	WHEN OTHERS THEN
           		 RAISE_APPLICATION_ERROR(-30109,'GR_DETOFERTAFICHA_PR3('||TO_CHAR(v_nnum_abonado)||', '||v_dfec_baja||', '||v_nnum_abonado_c||', '||v_dfec_bajacen_c||', '||v_dfec_alta_c||', '||v_nimp_cargo_c||') - '||SQLERRM);

END PV_NAMIGARCIONPREPAGO_PR;

END PV_CONSULTAPOSVENTA_PG;
/
SHOW ERRORS
