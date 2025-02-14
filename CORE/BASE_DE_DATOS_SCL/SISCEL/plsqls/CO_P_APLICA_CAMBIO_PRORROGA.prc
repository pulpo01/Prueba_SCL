CREATE OR REPLACE PROCEDURE CO_P_APLICA_CAMBIO_PRORROGA(
vp_Secuencia_Co IN VARCHAR2,
vp_Num_Interfaz IN VARCHAR2,
OFICINA IN VARCHAR2,
CAJA IN NUMBER,
--------------rrrrrrrrrrrrrrrrr
vp_NumEjercicio IN VARCHAR2,
vp_Secuenci_pag  IN VARCHAR2,
vp_Tipdocum_pag  IN VARCHAR2,
vp_Agente_pag  IN VARCHAR2,
vp_Letra_pag  IN VARCHAR2,
vp_Centremi_pag  IN VARCHAR2
)
IS
/*  Parametros de entrada:
			    vp_Secuencia_Co     ->Nzmero de Secuencia del Documento
			    vp_Num_Solicitud    ->Numero de la solicitud
			    vp_Tipo_Movimiento   ->Tipo de Movimiento
			    OFICINA             ->
			    CAJA                ->
			    NUMSECUMOV          ->
			    INDTITULAR          ->
*/
CURSOR DETALLE_SOLICITUD (N_SOLICITUD NUMBER) IS
		   SELECT NUM_SOLICITUD,
      			  NUM_SECUENCI,
      			  TIPO_SOLICITUD,
      			  NUM_SECUENCI_DOC,
      			  NUM_DOCUMENTO,
			      FECHA_VENCIMIENTO,
      			  FECHA_PRORROGA,
      			  IMPORTE,
      			  MONTO_INTERESES,
      			  CONCEPTO_PRORRO,
      			  NUM_IDENT,
      			  COD_BANCO,
      			  NUM_CTACTE,
      			  COD_SUCURSAL,
      			  COD_PLAZA,
      			  NUM_IDENT_N,
      			  IND_TITULAR_N,
      			  NUM_DOCUMEN_N,
      			  COD_BANCO_N,
      			  NUM_CTACTE_N,
      			  COD_SUCURSAL_N,
      			  COD_PLAZA_N,
      			  COD_TIPIDENT,
      			  COD_TIPIDENT_N
		   FROM CO_DET_SOLICITUD
		   WHERE
                        NUM_SOLICITUD  = N_SOLICITUD;
CURSOR CO_DET_DOCS (N_DOC VARCHAR2,N_SEC_DOC NUMBER) IS
       SELECT		NUM_SECUENCI,
			NUM_DOCUMENTO,
			NUM_SECUENCI_DOC,
			COD_CLIENTE,
			NUM_SECUENCI_PAGO,
			NUM_SECUENCI_CA,
			COD_TIPDOCUM_CA,
			COD_VEND_AGENTE_CA,
			LETRA_CA,
			NUM_FOLIO_CA,
			NUM_CUOTA_CA,
			SEC_CUOTA_CA,
			IMPORTE_CA,
			PREF_PLAZA
		FROM CO_DET_DOCUMENTOS
		WHERE
		     NUM_SECUENCI_DOC= N_SEC_DOC AND
		     NUM_DOCUMENTO= N_DOC;
usuario	            VARCHAR2(30);
fecha               VARCHAR2(10);
vp_error            NUMBER(2);
vp_ruteo            NUMBER(2);
vp_cantidad         NUMBER(3);
vp_gls_error        VARCHAR2(255);
codetsolicitud      CO_DET_SOLICITUD%ROWTYPE;
CODOCUMENTOS        CO_DOCUMENTOS%ROWTYPE;
CODCLIENTE          CO_CONVENIOS.CLIENTE_ASOCIADO%TYPE;
CODETDOCUMENTOS     CO_DET_DOCUMENTOS%ROWTYPE;
COCARTERA           CO_CARTERA%ROWTYPE;
secuenxia           NUMBER(3);
vp_tipo_movimiento   CO_INTERFAZ_CAJA.TIP_MOVIMIENTO%TYPE;
vp_num_Solicitud     CO_INTERFAZ_CAJA.NUM_MOVIMIENTO%TYPE;
vp_cod_cliente	     CO_INTERFAZ_CAJA.COD_CLIENTE%TYPE;
vp_SecuMov          NUMBER(5);
cart_secuencia      co_cartera.num_secuenci%TYPE;
docs_secuencia      co_documentos.num_secuenci%TYPE;
vp_columna              CO_SECARTERA.COLUMNA%TYPE;
vp_existe               NUMBER(12);
sCod_Operadora		CO_CARTERA.COD_OPERADORA_SCL%TYPE;
sCod_Plaza			CO_CARTERA.COD_PLAZA%TYPE;

ERROR_PROCESO EXCEPTION;
BEGIN
                                                            /* Andris Enrich 07/AGO/2000 */
	usuario := '';
	SELECT USER INTO usuario FROM DUAL;
        LOCK TABLE CO_SOLICITUD IN EXCLUSIVE MODE;
        LOCK TABLE CO_DET_SOLICITUD IN EXCLUSIVE MODE;
        LOCK TABLE CO_DOCUMENTOS IN EXCLUSIVE MODE;
        LOCK TABLE CO_DET_DOCUMENTOS IN EXCLUSIVE MODE;
        LOCK TABLE CO_CARTERA IN EXCLUSIVE MODE;
        LOCK TABLE CO_CANCELADOS IN EXCLUSIVE MODE;
	    vp_error := 17;
	    vp_gls_error := 'Select Co_interfaz_caja';
        SELECT TIP_MOVIMIENTO, NUM_MOVIMIENTO, COD_CLIENTE
        INTO   vp_tipo_movimiento, vp_Num_Solicitud, vp_cod_cliente
        FROM   CO_INTERFAZ_CAJA
        WHERE  NUM_INTERFAZ = to_number(vp_num_interfaz);

		--Obtiene Operadora del Cliente
		vp_gls_error := 'SELECT COD_OPERADORA.';
		SELECT COD_OPERADORA
		INTO   sCod_Operadora
		FROM   GE_CLIENTES
		WHERE  COD_CLIENTE = vp_cod_cliente;

		--Obtiene Plaza del Cliente
		vp_gls_error := 'SELECT Fn_Obtiene_PlazaCliente';
		SELECT Fn_Obtiene_PlazaCliente(vp_cod_cliente)
		INTO   sCod_Plaza
		FROM   DUAL;

        IF ltrim(vp_Tipo_Movimiento)='SCP' THEN
			vp_ruteo := 16;
			vp_gls_error := 'Toma CO_CAJAS Update.';
		        UPDATE CO_CAJAS
		        SET    NUM_SECUMOV = NUM_SECUMOV
		        WHERE  COD_OFICINA = OFICINA AND
                               COD_CAJA = CAJA;
			vp_ruteo := 18;
			vp_gls_error := 'Select CO_CAJAS Secuencia.';
		        SELECT NUM_SECUMOV
		        INTO   vp_secumov
		        FROM   CO_CAJAS
		        WHERE  COD_OFICINA = OFICINA AND
                               COD_CAJA = CAJA;
			vp_ruteo := 1;
			vp_gls_error := 'Abriendo Tabla Co_det_Solicitud';
			OPEN DETALLE_SOLICITUD(TO_NUMBER(vp_Num_Solicitud));
			LOOP
			    FETCH DETALLE_SOLICITUD INTO codetsolicitud;
			    EXIT WHEN DETALLE_SOLICITUD%NOTFOUND;
    			vp_ruteo := 1;
    			vp_gls_error := 'Abriendo Tabla Co_DOCUMENTOS';
			    SELECT * INTO CODOCUMENTOS FROM CO_DOCUMENTOS
			    WHERE
			         NUM_DOCUMENTO = CODETSOLICITUD.NUM_DOCUMENTO;
    		   /**** RRI  23/01/2002
			   vp_ruteo := 1;
    		   vp_gls_error := 'Abriendo Tabla CO_CONVENIOS';
	           SELECT CLIENTE_ASOCIADO INTO CODCLIENTE FROM CO_CONVENIOS
	           WHERE NUM_CONVENIO=CODOCUMENTOS.NUM_CONVENIO;   **/
			   vp_secumov := vp_secumov + 1;
			   secuenxia := 1;
			   vp_ruteo := 5;
			   vp_gls_error:='Obtencion de secuencia para la co_cartera';
			   SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL INTO cart_secuencia FROM DUAL;
			       vp_ruteo := 3;
			       vp_gls_error:='Insercisn en la tabla co_cancelados';
			       INSERT INTO CO_CANCELADOS (COD_CLIENTE,
					  NUM_SECUENCI,
					  COD_TIPDOCUM,
					  COD_VENDEDOR_AGENTE,
					  LETRA,
					  COD_CENTREMI,
					  COD_CONCEPTO,
					  COLUMNA,
					  COD_PRODUCTO,
					  IMPORTE_DEBE,
					  IMPORTE_HABER,
					  IND_CONTADO,
					  IND_FACTURADO,
					  IND_PORTADOR,
					  FEC_EFECTIVIDAD,
					  FEC_VENCIMIE,
					  FEC_CADUCIDA,
					  FEC_ANTIGUEDAD,
					  FEC_CANCELACION,
					  NUM_ABONADO,
					  NUM_FOLIO,
					  FEC_PAGO,
					  PREF_PLAZA,
					  NUM_CUOTA,
					  SEC_CUOTA,
					  NUM_TRANSACCION,
					  NUM_VENTA,
					  NUM_FOLIOCTC,
					  COD_OPERADORA_SCL,
					  COD_PLAZA
					   )
				   SELECT COD_CLIENTE,
					  NUM_SECUENCI,
					  COD_TIPDOCUM,
					  COD_VENDEDOR_AGENTE,
					  LETRA,
					  COD_CENTREMI,
					  COD_CONCEPTO,
					  COLUMNA,
					  COD_PRODUCTO,
					  IMPORTE_DEBE,
					  IMPORTE_DEBE,
					  IND_CONTADO,
					  IND_FACTURADO,
					  0,
					  FEC_EFECTIVIDAD,
					  FEC_VENCIMIE,
					  FEC_CADUCIDA,
					  FEC_ANTIGUEDAD,
					  TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
					  NUM_ABONADO,
					  NUM_FOLIO,
					  PREF_PLAZA,
					  TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
					  NUM_CUOTA,
					  SEC_CUOTA,
					  0,
					  NUM_VENTA,
					  NUM_FOLIOCTC,
					  COD_OPERADORA_SCL,
					  COD_PLAZA
				   FROM
					  CO_CARTERA
				   WHERE
					 NUM_SECUENCI        = CODOCUMENTOS.NUM_SECUENCI AND
					 COD_TIPDOCUM        = 59 AND
					 COD_VENDEDOR_AGENTE = 100001 AND
					 NUM_FOLIO           = CODOCUMENTOS.NUM_DOCUMENTO AND
					 /**** RRI 23/01/2002
					 COD_CLIENTE         = CODCLIENTE AND   **/
                     SEC_CUOTA           = CODOCUMENTOS.NUM_SEC_CUOTA;
				   vp_ruteo := 4;
				   vp_gls_error:='select en reg. de la tabla co_cartera';
				   SELECT * INTO COCARTERA FROM CO_CARTERA
					  WHERE
    					 NUM_SECUENCI        = CODOCUMENTOS.NUM_SECUENCI AND
    					 COD_TIPDOCUM        = 59 AND
    					 COD_VENDEDOR_AGENTE = 100001 AND
				         NUM_FOLIO           = CODOCUMENTOS.NUM_DOCUMENTO AND
					     /**   RRI  23/01/2002
						 COD_CLIENTE         = CODCLIENTE AND   **/
						 COD_CLIENTE         = vp_cod_cliente AND
					     SEC_CUOTA           = CODOCUMENTOS.NUM_SEC_CUOTA;
				   vp_ruteo := 4;
				   vp_gls_error:='Borrado de la tabla co_cartera';
				   DELETE FROM CO_CARTERA
					  WHERE
    					 NUM_SECUENCI        = CODOCUMENTOS.NUM_SECUENCI AND
    					 COD_TIPDOCUM        = 59 AND
    					 COD_VENDEDOR_AGENTE = 100001 AND
				         NUM_FOLIO           = CODOCUMENTOS.NUM_DOCUMENTO AND
					     /**  RRI   23/01/2002
						 COD_CLIENTE         = CODCLIENTE AND   ***/
					     SEC_CUOTA           = CODOCUMENTOS.NUM_SEC_CUOTA;
	       			vp_ruteo := 25;
	       			vp_gls_error:='Insercisn en la tabla CO_PAGOSCONC';
	       		    INSERT INTO CO_PAGOSCONC (
		  	  		COD_TIPDOCUM,
		  	  		COD_CENTREMI,
		  	  		NUM_SECUENCI,
			  		COD_VENDEDOR_AGENTE,
			  		NUM_SECUREL,
			  		LETRA,
			  		IMP_CONCEPTO,
			  		COD_PRODUCTO,
			  		COD_TIPDOCREL,
			  		COD_AGENTEREL,
			  		NUM_TRANSACCION,
			  		LETRA_REL,
			  		COD_CENTRREL,
			  		COD_CONCEPTO,
			  		COLUMNA,
			  		NUM_ABONADO,
			  		NUM_FOLIO,
					PREF_PLAZA,
			  		NUM_CUOTA,
			  		SEC_CUOTA,
			  		NUM_VENTA,
			  		NUM_FOLIOCTC,
					COD_OPERADORA_SCL,
					COD_PLAZA)
		   	       SELECT
		   	  		vp_tipdocum_pag,
		   	  		vp_centremi_pag,
		   	  		vp_secuenci_pag,
		   	  		vp_agente_pag,
			  		NUM_SECUENCI,
		   	  		vp_letra_pag,
		   	  		IMPORTE_DEBE - IMPORTE_HABER,
		   	  		COD_PRODUCTO,
		   	  		COD_TIPDOCUM,
		   	  		COD_VENDEDOR_AGENTE,
		   	  		NUM_TRANSACCION,
		   	  		LETRA,
		   	  		COD_CENTREMI,
		   	  		COD_CONCEPTO,
		   	  		COLUMNA,
		   	  		NUM_ABONADO,
		   	  		NUM_FOLIO,
					PREF_PLAZA,
		   	  		NUM_CUOTA,
		   	  		SEC_CUOTA,
		   	  		NUM_VENTA,
		   	  		NUM_FOLIOCTC,
					COD_OPERADORA_SCL,
					COD_PLAZA
		   	      FROM
			  		CO_CARTERA
		   	      WHERE
			 		NUM_SECUENCI        = CODOCUMENTOS.NUM_SECUENCI AND
			 		COD_TIPDOCUM        = 59 AND
			 		COD_VENDEDOR_AGENTE = 100001 AND
			 		NUM_FOLIO           = CODOCUMENTOS.NUM_DOCUMENTO AND
			 		/****   RRI   23/01/2002
					COD_CLIENTE         = CODCLIENTE   AND   **/
			 		SEC_CUOTA           = CODOCUMENTOS.NUM_SEC_CUOTA;
/**************************************************************************/
                    SELECT  COUNT(*)
                    INTO    vp_existe
                    FROM     CO_SECARTERA
                    WHERE     COD_TIPDOCUM = 59
                    AND     COD_VENDEDOR_AGENTE = 100001
                    AND     LETRA = 'X'
                    AND     COD_CENTREMI = 1
                    AND     NUM_SECUENCI = cart_secuencia
                    AND     COD_CONCEPTO = 2;
                    IF vp_existe > 0 THEN
                        vp_ruteo := 38;
                        vp_gls_error := 'Select Co_Secartera';
                        SELECT COLUMNA
                        INTO   vp_columna
                        FROM   CO_SECARTERA
                        WHERE  COD_TIPDOCUM = 59
                        AND       COD_VENDEDOR_AGENTE = 100001
                        AND       LETRA = 'X'
                        AND       COD_CENTREMI = 1
                        AND       NUM_SECUENCI = cart_secuencia
                        AND       COD_CONCEPTO = 2;
                        IF vp_columna = 9999 THEN
                            vp_columna := 1;
                        ELSE
                            vp_columna := vp_columna + 1;
                        END IF;
                        vp_ruteo := 39;
                        vp_gls_error := 'Update Co_Secartera';
                        /*utl_file.put_line(fh,vp_gls_error||'('|| to_char(vp_ruteo)||')' );*/
                        UPDATE CO_SECARTERA
                        SET    COLUMNA = vp_columna
                        WHERE  COD_TIPDOCUM = 59
                        AND       COD_VENDEDOR_AGENTE = 100001
                        AND       LETRA = 'X'
                        AND       COD_CENTREMI = 1
                        AND       NUM_SECUENCI = cart_secuencia
                        AND       COD_CONCEPTO = 2;
                    ELSE
                        vp_columna := 1;
                        vp_ruteo := 40;
                        vp_gls_error := 'Insert Co_Secartera';
                        INSERT INTO CO_SECARTERA
                                   (COD_TIPDOCUM,
                                    COD_VENDEDOR_AGENTE,
                                    LETRA,
                                    COD_CENTREMI,
                                    NUM_SECUENCI,
                                    COD_CONCEPTO,
                                    COLUMNA)
                        VALUES     (
                                    59,
                                    100001,
                                    'X',
                                    1,
                                    cart_secuencia,
                                    2,
                                    vp_columna
                                   );
                    END IF;
/**************************************************************************/
				    vp_ruteo := 7;
				    vp_gls_error:='insercisn en la tabla co_cartera';
				    INSERT INTO CO_CARTERA(
								COD_CLIENTE,
								NUM_SECUENCI,
								COD_TIPDOCUM,
								COD_VENDEDOR_AGENTE,
								LETRA,
								COD_CENTREMI,
								COD_CONCEPTO,
								COLUMNA,
								COD_PRODUCTO,
								IMPORTE_DEBE,
								IMPORTE_HABER,
								IND_CONTADO,
								IND_FACTURADO,
								FEC_EFECTIVIDAD,
								FEC_VENCIMIE,
								FEC_CADUCIDA,
								FEC_ANTIGUEDAD,
								NUM_ABONADO,
								NUM_FOLIO,
								PREF_PLAZA,
								NUM_CUOTA,
								SEC_CUOTA,
								COD_OPERADORA_SCL,
								COD_PLAZA)
							VALUES (
							    /**   RRI  23/01/2002
								CODCLIENTE,  **/
								vp_cod_cliente,
								cart_secuencia,
								59,
								100001,
								'X',
								1,
								2,
								0,
								5,
								codetsolicitud.importe,
								0,
								COCARTERA.IND_CONTADO,
								COCARTERA.IND_FACTURADO,
								codetsolicitud.fecha_prorroga,
								codetsolicitud.fecha_prorroga,
								SYSDATE,
								SYSDATE,
								0,
								codetsolicitud.num_documen_n,
								NULL,
								COCARTERA.NUM_CUOTA,
								COCARTERA.SEC_CUOTA,
								sCod_Operadora,
								sCod_Plaza);
			    vp_ruteo := 8;
			    vp_gls_error:='actualizacisn de la tabla co_documentos';
			    UPDATE CO_DOCUMENTOS
			    SET COD_ESTADO='8'                               /* CAMBIADO Y PRORROGADO */
			    WHERE
				 NUM_SECUENCI  = codetsolicitud.num_secuenci_doc AND
				 NUM_DOCUMENTO = codetsolicitud.num_documento;
			    vp_ruteo := 10;
			    vp_gls_error:='Insercisn en la tabla co_documentos';
			    INSERT INTO CO_DOCUMENTOS (
							    NUM_SECUENCI,
							    COD_TIPDOCUM,
							    NUM_SEC_CUOTA,
							    COD_TIPVALOR,
							    NUM_CONVENIO,
							    NUM_DOCUMENTO,
							    COD_OFICINA,
							    COD_CAJA,
							    NUM_SECUMOV,
							    COD_BANCO,
							    COD_SUCURSAL,
							    COD_PLAZA,
							    CTA_CORRIENTE,
							    IND_TITULAR,
							    NUM_IDENT,
							    IMPORTE_DOCUM,
							    FECHA_VENCTO,
							    COD_ESTADO,
							    COD_UBICACION,
							    FEC_ULT_MOVIMIENTO,
							    NOM_USUARIO,
								COD_OPERADORA_SCL,
								COD_PLAZA_OP )
						 VALUES (   cart_secuencia,
							    59,
							    CODOCUMENTOS.NUM_SEC_CUOTA,
							    CODOCUMENTOS.COD_TIPVALOR,
							    CODOCUMENTOS.NUM_CONVENIO,
							    codetsolicitud.NUM_DOCUMEN_N,
							    OFICINA,
							    CAJA,
							    vp_secumov,
							    codetsolicitud.COD_BANCO_N,
							    codetsolicitud.COD_SUCURSAL_N,
							    codetsolicitud.COD_PLAZA_N,
							    codetsolicitud.NUM_CTACTE_N,
							    codetsolicitud.IND_TITULAR_N,
							    codetsolicitud.NUM_IDENT_N,
							    codetsolicitud.IMPORTE,
							    codetsolicitud.FECHA_VENCIMIENTO,
							    '0',
							    '1',
							    sysdate,
							    CODOCUMENTOS.NOM_USUARIO,
								sCod_Operadora,
								sCod_Plaza);
    			   vp_ruteo := 2;
    			   vp_gls_error := 'Abriendo Tabla co_det_documentos';
    			   OPEN CO_DET_DOCS(codetsolicitud.num_documento,codetsolicitud.num_secuenci_doc);
			       LOOP
			          FETCH CO_DET_DOCS INTO CODETDOCUMENTOS;
			          EXIT WHEN CO_DET_DOCS%NOTFOUND;
    				  vp_ruteo := 12;
    				  vp_gls_error:='Insercisn en la tabla co_det_documentos';
    				  INSERT INTO CO_DET_DOCUMENTOS (
    								    NUM_SECUENCI,
    								    NUM_DOCUMENTO,
    								    NUM_SECUENCI_DOC,
    								    COD_CLIENTE,
    								    NUM_SECUENCI_PAGO,
    								    NUM_SECUENCI_CA,
    								    COD_TIPDOCUM_CA,
    								    COD_VEND_AGENTE_CA,
    								    LETRA_CA,
    								    NUM_FOLIO_CA,
										PREF_PLAZA,
    								    IMPORTE_CA)
    							VALUES (
    								    secuenxia,
    								    codetsolicitud.NUM_DOCUMEN_N,
    								    cart_secuencia,
    								    CODETDOCUMENTOS.COD_CLIENTE,
    								    CODETDOCUMENTOS.NUM_SECUENCI_PAGO,
    								    CODETDOCUMENTOS.NUM_SECUENCI_CA,
    								    CODETDOCUMENTOS.COD_TIPDOCUM_CA,
    								    CODETDOCUMENTOS.COD_VEND_AGENTE_CA,
    								    CODETDOCUMENTOS.LETRA_CA,
    								    CODETDOCUMENTOS.NUM_FOLIO_CA,
										CODETDOCUMENTOS.PREF_PLAZA,
    								    CODETDOCUMENTOS.IMPORTE_CA);
                             secuenxia := secuenxia + 1;
                    END LOOP;

		            INSERT INTO CO_MOVIMIENTOSCAJA
		            (COD_OFICINA, COD_CAJA, NUM_SECUMOV, NUM_EJERCICIO,
		             FEC_EFECTIVIDAD, NOM_USUARORA, TIP_MOVCAJA, IND_DEPOSITO,
                             IMPORTE, IND_ERRONEO, TIP_VALOR, IND_CIERRE, COD_CLIENTE,
                             TIP_DOCUMENT, COD_VENDEDOR_AGENTE, LETRA, COD_CENTREMI,
                             COD_BANCO, CTA_CORRIENTE, NUM_CHEQUE, FEC_VENCIMIENTO,
							 COD_OPERADORA_SCL, COD_PLAZA)
                            VALUES
		            (OFICINA, CAJA, vp_secumov, vp_NumEjercicio,
		             SYSDATE, usuario, 6, 0,
		             codetsolicitud.IMPORTE, 0, 2, 0, vp_cod_cliente,
		             8, 100001, 'X', 1,
		             codetsolicitud.COD_BANCO_N,
		             codetsolicitud.NUM_CTACTE_N,
		             codetsolicitud.NUM_DOCUMEN_N,
		             codetsolicitud.FECHA_VENCIMIENTO,
					 sCod_Operadora,
					 sCod_Plaza
	                    );
			END LOOP;    /*  ciclo principal    */
			vp_ruteo := 19;
			vp_gls_error := 'Update CO_CAJAS Secuencia final.';
		        UPDATE CO_CAJAS
		        SET    NUM_SECUMOV = vp_secumov + 1
		        WHERE  COD_OFICINA = OFICINA AND
                               COD_CAJA = CAJA;
			vp_ruteo := 13;
			vp_gls_error:='Actualizacisn de tabla co_solicitud';
			UPDATE CO_SOLICITUD
			       SET   ESTADO_SOLICITUD = 5
			       WHERE
				     NUM_SOLICITUD  = TO_NUMBER(vp_Num_Solicitud);
			vp_ruteo := 14;
			vp_gls_error := 'Cierre de cursor:DETALLE_SOLICITUD';
			close DETALLE_SOLICITUD;
		END IF;
        vp_ruteo := 30;
    	vp_gls_error:='Actualizacisn tabla co_interfaz_caja a procesado';
        UPDATE CO_INTERFAZ_CAJA
        SET    IND_PROCESADO = 1
        WHERE  NUM_INTERFAZ = to_number(vp_Num_Interfaz);
			vp_ruteo := 0;
			vp_gls_error := 'OK';
        RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           if vp_ruteo != 0 then
                ROLLBACK;
           end if;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
      WHEN DUP_VAL_ON_INDEX THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
      WHEN OTHERS THEN
           ROLLBACK;
      	   INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (TO_NUMBER(vp_secuencia_co), vp_ruteo, vp_gls_error, 0);
END CO_P_APLICA_CAMBIO_PRORROGA;
/
SHOW ERRORS
