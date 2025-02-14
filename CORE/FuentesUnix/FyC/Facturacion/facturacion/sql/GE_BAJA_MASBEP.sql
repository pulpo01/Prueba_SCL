CREATE OR REPLACE procedure GE_BAJA_MASBEP ( vp_szCodSituacion IN VARCHAR2 )IS

lhNumSecuencia		NUMBER(9);
ihRetornoPL			NUMBER(5);
lhCodCliente		GA_ABOBEEP.COD_CLIENTE%TYPE;		   
lhNumAbonado		GA_ABOBEEP.NUM_ABONADO%TYPE;		   
ihCodCentral		GA_ABOBEEP.COD_CENTRAL%TYPE;		   
szhNumSerie			GA_ABOBEEP.NUM_SERIE%TYPE;		   
szhIndProcequi		GA_ABOBEEP.IND_PROCEQUI%TYPE;		   
ihCodModVenta		GA_ABOBEEP.COD_MODVENTA%TYPE;		   
ihCodActCen			GA_ACTABO.COD_ACTCEN%TYPE;		   
lhCodArticulo		GA_EQUIPABOSER.COD_ARTICULO%TYPE; 
ihCodBodega			GA_EQUIPABOSER.COD_BODEGA%TYPE;
ihTipStock			GA_EQUIPABOSER.TIP_STOCK%TYPE; 
ihCodEstado			GA_EQUIPABOSER.COD_ESTADO%TYPE; 
ihCodUso			GA_EQUIPABOSER.COD_USO%TYPE; 
szhTipTerminal		GA_EQUIPABOSER.TIP_TERMINAL%TYPE;
ihIndCuotas			GE_MODVENTA.IND_CUOTAS%TYPE;
ihCodRetorno		GA_TRANSACABO.COD_RETORNO%TYPE;
szhDesCadena		GA_TRANSACABO.DES_CADENA%TYPE;

vp_sub_error		VARCHAR(1);
vp_gls_error		VARCHAR2(255);
vp_error			VARCHAR(1);
vp_gen_error		VARCHAR2(255);

/* ********************************************************************************************* */
/* (0) * MODULO PRINCIPAL    */
/* ********************************************************************************************* */

/* seleccionamos los abonados que aun no se dan de baja */
CURSOR CUR_ABONADOS IS
SELECT 	COD_CLIENTE,
		    NUM_ABONADO,
		    COD_CENTRAL,
		    NUM_SERIE,
		    IND_PROCEQUI,
		    NVL( COD_MODVENTA, 0 )
FROM	GA_ABOBEEP
WHERE	COD_CLIENTE > 0
AND     COD_SITUACION = vp_szCodSituacion
AND     ( FLG_CONTDIGI != '0' OR FLG_CONTDIGI IS NULL )
ORDER BY COD_CLIENTE;

ERROR_PROCESO EXCEPTION;
ERROR_SUBPROCESO EXCEPTION;

BEGIN

	vp_error := '1';
	vp_gen_error := 'SELECT COD_ACTCEN';
	SELECT COD_ACTCEN
	INTO	ihCodActCen	
	FROM	GA_ACTABO
	WHERE	COD_ACTABO = 'BA'
	AND    COD_PRODUCTO = 2;

	vp_error := '2';
	vp_gen_error := 'OPEN CUR_ABONADOS';
	OPEN CUR_ABONADOS;

	LOOP
		
		FETCH CUR_ABONADOS
		INTO  lhCodCliente, lhNumAbonado, ihCodCentral, szhNumSerie, szhIndProcequi, ihCodModVenta;
		EXIT WHEN CUR_ABONADOS%NOTFOUND;

		BEGIN	/* sub-bloque para procesar abonados */

			dbms_output.put_line ( lhCodCliente|| ' ' ||lhNumAbonado|| ' ' ||ihCodCentral|| ' ' ||szhNumSerie|| ' ' ||szhIndProcequi|| ' ' ||ihCodModVenta );
			
			vp_sub_error := '1';
			
			/* marcar el abonado BAJA ABONADO EN PROCESO */
			vp_sub_error := 'A';
			vp_gls_error := 'Cod_Situacion a BAP';
			UPDATE	GA_ABOBEEP
			SET		COD_SITUACION = 'BAP'
			WHERE	NUM_ABONADO = lhNumAbonado;
	
			vp_sub_error := 'B';
			vp_gls_error := 'DELETE FROM GA_FINCICLO';
			DELETE FROM GA_FINCICLO
			WHERE  NUM_ABONADO = lhNumAbonado;
	
			/* insertamos un movimiento de baja en la central */
			vp_sub_error := 'C';
			vp_gls_error := 'INSERT INTO ICB_MOVIMIENTO';
			INSERT INTO ICB_MOVIMIENTO	(   NUM_MOVIMIENTO,
											NUM_ABONADO,
											COD_ESTADO,
											COD_MODULO,
											COD_ACTUACION,
											COD_ACTABO,
											NOM_USUARORA,
											FEC_INGRESO,
											COD_CENTRAL,
											TS,
											ID,
											CC,
											PRO,
											VEL,
											FRE,
											COB,
											NOM,
											GM1,
											GM2,
											GM3,
											GM4,
											GM5,
											RUT,
											STA,
											MARP,
											MODP,
											NSER,
											TCUE,
											TIP_TERMINAL,
											EMP
										)	
										SELECT	ICB_SEQ_NUMMOV.NEXTVAL,
												lhNumAbonado,
												1,
												'GA',
												ihCodActCen,
												'BA',
												USER,
												SYSDATE,
												ihCodCentral,
												TS,
												ID,
												CC,
												PRO,
												VEL,
												FRE,
												COB,
												NOM,
												GM1,
												GM2,
												GM3,
												GM4,
												GM5,
												RUT,
												STA,
												MARP,
												MODP,
												NSER,
												TCUE,
												TP,
												EMPR
										FROM	GA_SUSCBEEP
										WHERE   NUM_ABONADO = lhNumAbonado;
																										
			
			/* si se debe devolver el equipo a almacen */
			IF ( szhIndProcequi = 'I' ) AND ( ihCodModVenta != 0 ) THEN 	/* si procedencia interna y modo de venta arriendo */
				
				vp_sub_error := 'D';
				vp_gls_error := 'SELECT	IND_CUOTAS';
				SELECT	IND_CUOTAS
				INTO	ihIndCuotas
				FROM	GE_MODVENTA
				WHERE	COD_MODVENTA = ihCodModVenta;
				
				IF ihIndCuotas = 2 THEN
					/* devolvemos el equipo a almacen */
					vp_sub_error := 'E';
					vp_gls_error := 'SELECT	GA_EQUIPABOSER';
					SELECT  COD_ARTICULO, 
							COD_BODEGA,
							TIP_STOCK, 
							COD_ESTADO, 
							COD_USO, 
							TIP_TERMINAL
					INTO	lhCodArticulo,
							ihCodBodega,
							ihTipStock,
							ihCodEstado,
							ihCodUso,
							szhTipTerminal
					FROM	GA_EQUIPABOSER
					WHERE	NUM_ABONADO = lhNumAbonado
					AND		IND_EQUIACC = 'E'
					AND		FEC_ALTA = (	SELECT 	MAX( FEC_ALTA ) 
											FROM	GA_EQUIPABOSER
											WHERE	NUM_ABONADO = lhNumAbonado
											AND		IND_EQUIACC = 'E' );
											
					vp_sub_error := 'F';
					vp_gls_error := 'NUM_SECUENCIA PARA P_GA_INTERAL';
					SELECT	CO_SEQ_TRANSACINT.NEXTVAL
					INTO 	lhNumSecuencia
					FROM 	DUAL;
	
					P_GA_INTERAL (	TO_CHAR(lhNumSecuencia), '7', TO_CHAR(ihTipStock), TO_CHAR(ihCodBodega), 
                                TO_CHAR(lhCodArticulo), TO_CHAR(ihCodUso), TO_CHAR(ihCodEstado),  ' ', '1', 
                                szhNumSerie, '0' );
					
					vp_sub_error := 'G';
					vp_gls_error := 'GA_TRANSACABO DE P_GA_INTERAL';
					SELECT	COD_RETORNO, DES_CADENA
					INTO 	ihRetornoPL,
							szhDesCadena
					FROM 	GA_TRANSACABO
					WHERE   NUM_TRANSACCION = lhNumSecuencia;
					
					IF ihRetornoPL != 0 THEN
						vp_sub_error := 'H';
						vp_gls_error := 'FALLO PL P_GA_INTERAL SECUENCIA ' || lhNumSecuencia;
						RAISE ERROR_SUBPROCESO;
					END IF;							
											
				END IF; /* IF ihIndCuotas = 2 */			
			
			END IF; /* IF ( szhIndProcequi = 'I' ) AND ( ihCodModVenta != 0 ) */	
			
			vp_sub_error := 'I';
			vp_gls_error := 'NUM_SECUENCIA PARA P_INTERFASES ABONADOS';
			SELECT	GA_SEQ_TRANSACABO.NEXTVAL
			INTO 	lhNumSecuencia
			FROM 	DUAL;
	
			/* llamamos a la PL, que dara de baja al abonado */
			P_INTERFASES_ABONADOS( lhNumSecuencia, 'BA', 2, lhNumAbonado, '', '', '' );
	
			vp_sub_error := 'J';
			vp_gls_error := 'GA_TRANSACABO DE P_INTERFASES ABONADOS';
			SELECT	COD_RETORNO
			INTO 	ihRetornoPL
			FROM 	GA_TRANSACABO
			WHERE   NUM_TRANSACCION = lhNumSecuencia;
			
			IF ihRetornoPL != 0 THEN
				vp_sub_error := 'K';
				vp_gls_error := 'FALLO PL P_INTERFASES ABONADOS';
				RAISE ERROR_SUBPROCESO;
			END IF;
			
			vp_sub_error := 'L';
			vp_gls_error := 'UPDATE GA_ABOBBEP FLG_CONTDIGI';
			UPDATE 	GA_ABOBEEP					/* actualizamos el error en la ga_abobeep */
			SET		FLG_CONTDIGI = '0'
			WHERE   NUM_ABONADO = lhNumAbonado;

			COMMIT;

		    EXCEPTION
		        WHEN ERROR_SUBPROCESO THEN
					ROLLBACK;
					UPDATE 	GA_ABOBEEP					/* actualizamos el error en la ga_abobeep */
					SET		FLG_CONTDIGI = vp_sub_error
					WHERE   NUM_ABONADO = lhNumAbonado;
					COMMIT;

				WHEN OTHERS THEN
					ROLLBACK;
					UPDATE 	GA_ABOBEEP					/* actualizamos el error en la ga_abobeep */
					SET		FLG_CONTDIGI = vp_sub_error
					WHERE   NUM_ABONADO = lhNumAbonado;
					COMMIT;
		
		END; /* fin sub-bloque para procesar abonados */		

	END LOOP;
	
	vp_error := '3';
	vp_gen_error := 'CLOSE CUR_ABONADOS';
	CLOSE CUR_ABONADOS;	

    EXCEPTION
        WHEN ERROR_PROCESO THEN
			ROLLBACK;
			vp_error := SQLCODE;
			vp_gen_error := vp_gen_error || SQLERRM;
--			dbms_output.put_line ( vp_gen_error || ' ' || vp_error );
        WHEN NO_DATA_FOUND THEN
			ROLLBACK;
			vp_error := SQLCODE;
			vp_gen_error := vp_gen_error || SQLERRM;
--			dbms_output.put_line ( vp_gen_error || ' ' || vp_error );
        WHEN OTHERS THEN
			ROLLBACK;
			vp_error := SQLCODE;
			vp_gen_error := vp_gen_error || SQLERRM;
--			dbms_output.put_line ( vp_gen_error || ' ' || vp_error );
END GE_BAJA_MASBEP;
