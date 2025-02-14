CREATE OR REPLACE PROCEDURE        P_GA_RESERVA_PUNTUAL(sNumTran in varchar2, sCodCliente in varchar2, sCodVendedor in varchar2,
	   sNumCelular in varchar2, sCodUso in varchar2, sCodOrigen in varchar2, sCodVendealer in varchar2) IS

lnum_transaccion number;
lcod_cliente 	 GE_CLIENTES.COD_CLIENTE%TYPE;
lCod_Vendedor 	 VE_VENDEDORES.COD_VENDEDOR%TYPE;
lNum_Celular 	 GA_CELNUM_REUTIL.NUM_CELULAR%TYPE;
lCod_Uso		 AL_USOS.COD_USO%TYPE;
lCod_Vendealer   GA_RESERVA.COD_VENDEALER%TYPE;
RESULTADO 		 GA_TRANSACABO.DES_CADENA%TYPE;
lPaso			 number;
lNumCelBlock	 GA_CELNUM_REUTIL.NUM_CELULAR%TYPE;

BEGIN

	 lnum_transaccion := to_number(sNumTran);
	 lCod_cliente := to_number(sCodCliente);
	 lCod_Vendedor := to_number(sCodVendedor);
	 lNum_Celular := to_number(sNumCelular);
	 lCod_Uso	:= to_number(sCodUso);
     lCod_Vendealer := to_number(sCodVendealer);

	 IF sCodOrigen = 'REUTIL' THEN
	 	lPaso := 1;
 		SELECT NUM_CELULAR INTO lNum_Celular
 		FROM GA_CELNUM_REUTIL
 		WHERE NUM_CELULAR = lNum_Celular  for update nowait;

		lPaso := 2;
	 	INSERT INTO GA_RESERVA
		(COD_CLIENTE, COD_VENDEDOR, ORIGEN, FEC_RESERVA,
		 NUM_CELULAR, COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR,COD_VENDEALER)
	 	SELECT lCod_cliente, lCod_Vendedor, sCodOrigen, sysdate,
		   NUM_CELULAR, COD_SUBALM, COD_PRODUCTO, COD_CENTRAL, COD_CAT, COD_USO, FEC_BAJA,IND_EQUIPADO, USO_ANTERIOR,lCod_Vendealer
		FROM GA_CELNUM_REUTIL
		WHERE NUM_CELULAR = lNum_Celular;
	 	lPaso := 3;

		DELETE GA_CELNUM_REUTIL
		WHERE NUM_CELULAR = lNum_Celular;

	 ELSIF sCodOrigen = 'RESERVA' THEN
	 	lPaso := 1;
	 	UPDATE GA_RESERVA
		SET COD_CLIENTE = lCod_Cliente,
			COD_VENDEDOR = lCod_Vendedor,
            COD_VENDEALER = lCod_Vendealer,
			FEC_RESERVA = SYSDATE
		WHERE NUM_CELULAR = lNum_Celular;

	 ELSE
       RESULTADO := 'ORIGEN NO CONTEMPLADO EN PROCEDIMIENTO';
       INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                           VALUES (lnum_transaccion,4, resultado );
	 END IF;

    INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                           VALUES (lnum_transaccion,0, NULL );

EXCEPTION
	when others then
   	   RESULTADO := TO_CHAR(SQLCODE) || '  ' || SQLERRM;
      INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                           VALUES (lnum_transaccion,lPaso, resultado );


END P_GA_RESERVA_PUNTUAL; 
/
SHOW ERRORS
