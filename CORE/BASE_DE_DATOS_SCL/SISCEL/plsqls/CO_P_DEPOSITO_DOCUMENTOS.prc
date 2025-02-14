CREATE OR REPLACE PROCEDURE        CO_P_DEPOSITO_DOCUMENTOS (FECHA IN VARCHAR2,
                                                 sNumDeposito VARCHAR2,
                                                 sCodBancoAux VARCHAR2,
                                                 sCtaBcoAux   VARCHAR2
                                                 ) IS
CURSOR DOCS (FECHA DATE) IS
			   SELECT NUM_DOCUMENTO,NUM_SECUENCI,NUM_SECUMOV
			   FROM CO_DOCUMENTOS
			   WHERE TO_DATE(TO_CHAR(FECHA_VENCTO,'DD-MM-YYYY'),'DD-MM-YYYY')<=FECHA AND
				 COD_ESTADO IN ('0','1');
FOLIO         CO_DOCUMENTOS.NUM_DOCUMENTO%TYPE;
SECUENCIA     CO_DOCUMENTOS.NUM_SECUENCI%TYPE;
SECUMOV       CO_DOCUMENTOS.NUM_SECUMOV%TYPE;
DIAHORA       VARCHAR2(20);
ERROR_PROCESO EXCEPTION;
vp_error            NUMBER(2);
vp_ruteo            NUMBER(2);
vp_cantidad         NUMBER(3);
vp_gls_error        VARCHAR2(255);
vp_Secuencia_Co     CO_DOCUMENTOS.NUM_SECUENCI%TYPE;
BEGIN
    LOCK TABLE CO_DOCUMENTOS IN EXCLUSIVE MODE;
    LOCK TABLE CO_CANCELADOS IN EXCLUSIVE MODE;
    LOCK TABLE CO_CARTERA IN EXCLUSIVE MODE;
    SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') INTO DIAHORA FROM DUAL;
    vp_ruteo := 1;
	vp_gls_error := 'OPEN CURSOR DOCS A LA CO_DOCUMENTOS->' || DIAHORA;
	vp_Secuencia_Co:=0;
    OPEN DOCS(TO_DATE(FECHA,'DD-MM-YYYY'));
    LOOP
       vp_ruteo := 1;
	   vp_gls_error := 'FETCH CURSOR DOCS A LA CO_DOCUMENTOS->' || DIAHORA;
       FETCH DOCS INTO FOLIO,SECUENCIA,SECUMOV;
       EXIT WHEN DOCS%NOTFOUND;
       vp_ruteo := 2;
       vp_gls_error := 'INSERT A LA CO_CANCELADOS->' || DIAHORA;
       vp_Secuencia_Co := SECUENCIA;
       INSERT INTO CO_CANCELADOS (
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
			     	  IND_PORTADOR,
			     	  FEC_EFECTIVIDAD,
			     	  FEC_VENCIMIE,
			     	  FEC_CADUCIDA,
			     	  FEC_ANTIGUEDAD,
			     	  FEC_CANCELACION,
			     	  NUM_ABONADO,
			     	  NUM_FOLIO,
			     	  FEC_PAGO,
			     	  NUM_CUOTA,
			     	  SEC_CUOTA,
			     	  NUM_TRANSACCION,
			     	  NUM_VENTA,
			     	  NUM_FOLIOCTC)
			   SELECT
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
				  TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
				  NUM_CUOTA,
				  SEC_CUOTA,
				  0,
				  NUM_VENTA,
				  NUM_FOLIOCTC
			   FROM
				  CO_CARTERA
			   WHERE
				 COD_TIPDOCUM=59 AND
				 NUM_FOLIO=FOLIO AND
				 NUM_SECUENCI=SECUENCIA;
               vp_ruteo := 3;
               vp_gls_error := 'DELETE A LA CO_CARTERA->' || DIAHORA;
        	   DELETE FROM CO_CARTERA
        		  WHERE
        		       COD_TIPDOCUM=59 AND
        		       NUM_FOLIO=FOLIO AND
        		       NUM_SECUENCI=SECUENCIA;
                vp_ruteo := 4;
            	vp_gls_error := 'UPDATE  A LA CO_DOCUMENTOS->' || DIAHORA;
                UPDATE CO_DOCUMENTOS SET
                                        COD_ESTADO        = '2',
                                        FECHA_DEPOSITO    = TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
                                        COD_BANCO_DEPO    = sCodBancoAux,
                                        CTA_CORRIENTE_DEPO= sCtaBcoAux ,
                                        NUN_DEPOSITO      = sNumDeposito
                WHERE
                                        NUM_DOCUMENTO  = FOLIO
                                    AND NUM_SECUMOV= SECUMOV
                                    AND TO_DATE(TO_CHAR(FECHA_VENCTO,'DD-MM-YYYY'),'DD-MM-YYYY') <= TO_DATE(FECHA,'DD-MM-YYYY')
                                    AND COD_ESTADO IN ('0','1');
      END LOOP;
		vp_ruteo := 0;
		vp_gls_error := 'OK';
        RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           if vp_ruteo != 0 then
                ROLLBACK;
           end if;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (vp_secuencia_co, vp_ruteo, vp_gls_error, 0);
      WHEN DUP_VAL_ON_INDEX THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (vp_secuencia_co, vp_ruteo, vp_gls_error, 0);
      WHEN NO_DATA_FOUND THEN
           ROLLBACK;
           INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (vp_secuencia_co, vp_ruteo, vp_gls_error, 0);
      WHEN OTHERS THEN
           ROLLBACK;
      	   INSERT INTO CO_TRANSACINT (NUM_TRANSACCION, COD_RETORNO, DES_CADENA, MTO_INTERESES)
           VALUES (vp_secuencia_co, vp_ruteo, vp_gls_error, 0);
END CO_P_DEPOSITO_DOCUMENTOS;
/
SHOW ERRORS
