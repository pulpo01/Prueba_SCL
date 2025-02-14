CREATE OR REPLACE PROCEDURE        CE_P_CIERRE_RECARGA(
num_atm	  	 IN NUMBER,
num_oper   	 IN NUMBER,
monto 	 	 IN NUMBER,
ci_numreci   IN NUMBER,
ci_fecontab  IN VARCHAR2,
pnumVigencia IN VARCHAR2,
resul 	  	 IN OUT VARCHAR2,
empresa  	 IN VARCHAR2,
cod_autoriz  IN VARCHAR2,
serie 		 IN VARCHAR2,
pnum_celular IN OUT VARCHAR2,
mot_rechazo  IN VARCHAR2, --
cod_trans 	 IN VARCHAR2,
empresa_fin  IN VARCHAR2,
codtipvalor  IN VARCHAR2,
nu_valor 	 IN VARCHAR2, --
servicio 	 IN VARCHAR2,
mto_promo 	 IN NUMBER,
pnumCuotas	 IN NUMBER,
pCodCuenta	 IN VARCHAR2,
pLocal		 IN NUMBER,
pOperador	 IN VARCHAR2,
pCanalIvr	 IN NUMBER
	) IS
	ci_numventa   NUMBER(8);
	pexpi         VARCHAR2(11);
	ind_promocion CET_TRANSACCION.IND_PROMOCION%TYPE;
	BEGIN
	IF mto_promo = 0 THEN
	   ind_promocion := 0;
	END IF;
  IF cod_trans='NK' THEN
	   UPDATE CET_TRANSACCION
	   SET COD_ESTADO   = 'B'
	   WHERE
		  NUM_TERMINAL    = num_atm
	   AND NUM_TRANSACCION = num_oper
	   AND FEC_CONTABLE    = to_date(ci_fecontab,'dd/mm/yyyy');
	   resul:='CEH_TRANSACCION';
	   INSERT INTO CEH_TRANSACCION
	   (COD_CLIENTE    , /*  NUMBER(8), */
        NUM_CELULAR       , /* VARCHAR2(8), */
        FEC_MOVIMIENTO    , /* DATE          NOT NULL, */
        COD_SERVICIO      , /* VARCHAR2(5)   NOT NULL, */
        MTO_SERVICIO      , /* NUMBER(10)    NOT NULL, */
        NUM_CLAVE         , /* VARCHAR2(16)  NOT NULL, */
        NUM_SERIE         , /* VARCHAR2(16)  NOT NULL, */
        NUM_VENTA         , /* NUMBER(8)     NOT NULL, */
        FEC_EXPIRACION    , /* DATE          NOT NULL, */
        NUM_TERMINAL      , /* NUMBER(5)     NOT NULL, */
        NUM_RECIBO        , /* NUMBER(5)     NOT NULL, */
        NUM_TRANSACCION   , /* NUMBER(6)     NOT NULL, */
        COD_ESTADO        , /* VARCHAR2(2),  */
        FEC_VALIDA        , /* DATE,         */
        NUM_CTACTE        , /* VARCHAR2(20), */
        NUM_TARJETA       , /* VARCHAR2(20), */
        COD_TIPTARJETA    , /* VARCHAR2(2), */
        COD_AUTORIZACION  , /* VARCHAR2(15), */
        COD_EMPRFIN       , /* VARCHAR2(5), */
        COD_EMPRSERV      , /* VARCHAR2(5), */
        FEC_CONTABLE      , /*DATE          NOT NULL, */
        IND_FACTURACION   ,
        NUM_PROCFACT      ,
        IND_COMISION      ,
        IND_CONCILIACION  ,
        IND_PAGO,
        IND_PROMOCION,
        MTO_PROMOCION,
		NUM_CUOTAS,
		LOCAL,
		OPERADOR,
		COD_CUENTA,
		COD_CANAL_IVR
		)
    	VALUES(
    	0,
    	pnum_celular,
    	sysdate,
    	servicio,
    	monto,
		'0',
		CES_SEQ_NUMRECARGA.NEXTVAL,
		CES_NUMVENTA.NEXTVAL,
    	NULL,
        num_atm,
    	ci_numreci,
    	num_oper,
    	'B',
    	NULL,
    	NULL,
    	NULL,
    	NULL,
    	cod_autoriz,
    	empresa_fin,
    	empresa,
    	to_date(ci_fecontab,'dd/mm/yyyy'),
    	'0',
    	 0,
    	'0',
    	'0',
    	'0',
    	codtipvalor,
    	mto_promo,
		pnumCuotas,
		pLocal,
		pOperador,
		pCodCuenta,
		pCanalIvr);
  END IF;
IF cod_trans='OK' THEN
	IF pnum_celular IS NULL OR pnum_celular='' THEN
	   pnum_celular:='0';
	END IF;
	--Cuando transaccisn es correcta...
	resul:='CET_TRANSACCION';
	INSERT INTO CET_TRANSACCION
	(COD_CLIENTE,
	NUM_CELULAR,
	FEC_MOVIMIENTO,
	COD_SERVICIO,
	MTO_SERVICIO,
	NUM_CLAVE,
	NUM_SERIE,
	NUM_VENTA,
	FEC_EXPIRACION,
	NUM_TERMINAL,
	NUM_RECIBO,
	NUM_TRANSACCION,
	COD_ESTADO,
	FEC_VALIDA,
	NUM_CTACTE,
	NUM_TARJETA,
	COD_TIPTARJETA,
	COD_AUTORIZACION,
	NUM_PROCVAL,
	NUM_PROCONC,
	COD_EMPRFIN,
	COD_EMPRSERV,
	FEC_CONTABLE,
	IND_FACTURACION,
	NUM_PROCFACT,
	IND_COMISION,
	IND_CONCILIACION,
	IND_PAGO,
    IND_PROMOCION,
    MTO_PROMOCION,
	NUM_CUOTAS,
	LOCAL,
	OPERADOR,
	COD_CUENTA,
	COD_CANAL_IVR)
	VALUES(
	0,
	pnum_celular,
	sysdate,
	servicio,
	monto,
	'0',
	CES_SEQ_NUMRECARGA.NEXTVAL,
	CES_NUMVENTA.NEXTVAL,
	SYSDATE, --to_date(pexpi,'dd-mm-yyyy'),
    num_atm,
	ci_numreci,
	num_oper,
	'VP',
	NULL,
	NULL,
	NULL,
	NULL,
	cod_autoriz,
	0,
	0,
	empresa_fin,
	empresa,
	to_date(ci_fecontab,'dd/mm/yyyy'),
	'0',
	 0,
	'0',
	'0',
	'0',
   	codtipvalor,
   	mto_promo,
	pnumCuotas,
	pLocal,
	pOperador,
	pCodCuenta,
	pCanalIvr);
END IF;
resul:='OK';
	EXCEPTION
	WHEN OTHERS THEN
   	    resul := SQLERRM ||': ' || resul;
END CE_P_CIERRE_RECARGA;
/
SHOW ERRORS
