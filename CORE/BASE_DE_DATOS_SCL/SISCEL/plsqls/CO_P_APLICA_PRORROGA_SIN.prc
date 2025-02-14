CREATE OR REPLACE PROCEDURE CO_P_APLICA_PRORROGA_SIN
(vp_Secuencia_Co IN VARCHAR2,
 vp_Num_Solicitud IN VARCHAR2) IS
--(vp_Secuencia_Co IN VARCHAR2,
-- vp_Num_Solicitud IN VARCHAR2) IS
--------------rrrrrrrrrrrrrrrrrrrrrrrr
/*
Parametros de entrada:
			    vp_Secuencia_Co     ->Nzmero de Secuencia del Documento
			    vp_Num_Solicitud    ->Numero de la solicitud
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
		   FROM   CO_DET_SOLICITUD
		   WHERE  NUM_SOLICITUD  = N_SOLICITUD;
vp_error            NUMBER(2);
vp_ruteo            NUMBER(2);
vp_gls_error        VARCHAR2(255);
codetsolicitud      CO_DET_SOLICITUD%ROWTYPE;
CODOCUMENTOS        CO_DOCUMENTOS%ROWTYPE;
CODCLIENTE          CO_CONVENIOS.CLIENTE_ASOCIADO%TYPE;
/* vp_num_Solicitud    CO_INTERFAZ_CAJA.NUM_MOVIMIENTO%TYPE; */
ERROR_PROCESO EXCEPTION;
BEGIN
                                                            /* Andris Enrich 08/AGO/2000 */
        LOCK TABLE CO_SOLICITUD IN EXCLUSIVE MODE;
        LOCK TABLE CO_DET_SOLICITUD IN EXCLUSIVE MODE;
        LOCK TABLE CO_DOCUMENTOS IN EXCLUSIVE MODE;
        LOCK TABLE CO_DET_DOCUMENTOS IN EXCLUSIVE MODE;
        LOCK TABLE CO_CARTERA IN EXCLUSIVE MODE;
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
    		  /* vp_ruteo := 1;                                   */
    		  /* vp_gls_error := 'Abriendo Tabla CO_CONVENIOS';   */
	          /* SELECT CLIENTE_ASOCIADO INTO CODCLIENTE FROM CO_CONVENIOS   */
	          /* WHERE NUM_CONVENIO=CODOCUMENTOS.NUM_CONVENIO;		 */
	       vp_ruteo := 3;
	       vp_gls_error:='Actualizacisn la tabla co_cartera';
	       UPDATE CO_CARTERA
			  SET FEC_CADUCIDA= codetsolicitud.fecha_vencimiento,
			      FEC_VENCIMIE= codetsolicitud.fecha_prorroga
	       WHERE
				 NUM_SECUENCI        = CODOCUMENTOS.NUM_SECUENCI AND
				 COD_TIPDOCUM        = 59 AND
				 NUM_FOLIO           = CODOCUMENTOS.NUM_DOCUMENTO AND
			        /* COD_CLIENTE         = CODCLIENTE AND   */
			         SEC_CUOTA           = CODOCUMENTOS.NUM_SEC_CUOTA;
	    vp_ruteo := 4;
	    vp_gls_error:='actualizacisn de la tabla co_documentos';
	    UPDATE CO_DOCUMENTOS
	    SET COD_ESTADO='3',
	        FECHA_VENCTO= codetsolicitud.fecha_prorroga
	    WHERE
		 NUM_SECUENCI  = codetsolicitud.num_secuenci_doc AND
		 NUM_DOCUMENTO = codetsolicitud.num_documento;
	END LOOP;    /*  ciclo principal    */
	vp_ruteo := 5;
	vp_gls_error:='Actualizacisn de tabla co_solicitud';
        UPDATE CO_SOLICITUD
        SET    ESTADO_SOLICITUD = 5
        WHERE  NUM_SOLICITUD = TO_NUMBER(vp_Num_Solicitud);
	vp_ruteo := 6;
	vp_gls_error := 'Cierre de cursor:DETALLE_SOLICITUD';
	close DETALLE_SOLICITUD;
        vp_ruteo := 30;
	vp_gls_error:='Actualizacisn tabla co_interfaz_caja a procesado';
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
END CO_P_APLICA_PRORROGA_SIN;
/
SHOW ERRORS
