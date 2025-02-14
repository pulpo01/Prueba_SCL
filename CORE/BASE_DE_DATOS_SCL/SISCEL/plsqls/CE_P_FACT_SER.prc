CREATE OR REPLACE PROCEDURE        CE_P_FACT_SER(
  servicio IN VARCHAR2 ,
  periodo IN VARCHAR2 ,
  nventa IN VARCHAR2,
  resp IN OUT VARCHAR2,
  empresa IN VARCHAR2)
IS
	num_pro        NUMBER(8);
	cliente        CED_PARAMETROS.VAL_NUMERICO%TYPE;
    marca          VARCHAR2(12);
	mto_total	   NUMBER(20);
	num_reg		   NUMBER(20);
	cod_concepto   FA_PREFACTURA.COD_CONCEPTO%TYPE;
	pnum_serie	   CET_TRANSACCION.NUM_SERIE%TYPE;
	pnum_venta	   CET_TRANSACCION.NUM_VENTA%TYPE;
	pfec_movimiento CET_TRANSACCION.FEC_MOVIMIENTO%TYPE;
	pfec_contab		CET_TRANSACCION.FEC_CONTABLE%TYPE;
	pcod_empserv	CET_TRANSACCION.COD_EMPRSERV%TYPE;
	pmto_servicio  FA_PREFACTURA.IMP_CONCEPTO%TYPE;
	pcod_catribut   GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE;
	cod_catimpo    GE_CATIMPCLIENTES.COD_CATIMPOS%TYPE;
	pnventa		   FA_PREFACTURA.NUM_VENTA%TYPE;
	pcod_plancom   GA_CLIENTE_PCOM.COD_PLANCOM%TYPE;
	pcod_vendedor_agente CED_PARAMETROS.VAL_NUMERICO%TYPE;
	pcod_centremi  CED_PARAMETROS.VAL_NUMERICO%TYPE;
	pCodModGener   FA_GENCENTREMI.COD_MODGENER%TYPE;
	usuario		   VARCHAR2(12);
	psecuencia	   NUMBER(10);
	CURSOR DATOS(elnumpro number) IS
	SELECT cod_emprserv, num_serie, num_venta, mto_servicio, fec_movimiento, fec_contable FROM CET_TRANSACCION
	WHERE NUM_PROCFACT=elnumpro;
    ERROR_PROCESO EXCEPTION;
  BEGIN
  resp:='OK';
    --numero de proceso
	marca:='36';
    SELECT FA_SEQ_NUMPRO.NEXTVAL INTO num_pro FROM DUAL;
	-- secuencia
	marca:='38';
    SELECT FA_SEQ_MISCELANEA.NEXTVAL INTO psecuencia FROM DUAL;
	--usuario
	marca:='42';
	SELECT USER INTO usuario FROM DUAL;
	--cliente electronico
	marca:='45';
	SELECT COD_CLIENTE INTO cliente FROM CED_EMPRESAS
	WHERE COD_EMPRESA=ltrim(rtrim(empresa));
	marca:='48';
	SELECT VAL_NUMERICO INTO pcod_vendedor_agente FROM CED_PARAMETROS
	WHERE COD_PARAMETRO=7;
	marca:='51';
	SELECT VAL_NUMERICO INTO pcod_centremi FROM CED_PARAMETROS
	WHERE COD_PARAMETRO=8;
	--pcod_plancom
	marca:='56';
	SELECT COD_PLANCOM INTO pcod_plancom FROM GA_CLIENTE_PCOM
	WHERE
	COD_CLIENTE=cliente AND
	SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

	-- para insert en fa_interfact
	marca:='67';
	SELECT COD_CATRIBUT INTO pcod_catribut FROM GA_CATRIBUTCLIE
	WHERE COD_CLIENTE=cliente
	AND sysdate BETWEEN FEC_DESDE AND FEC_HASTA;
	marca:='71';
	SELECT COD_CATIMPOS INTO cod_catimpo FROM GE_CATIMPCLIENTES
	WHERE COD_CLIENTE=cliente
	AND sysdate BETWEEN FEC_DESDE AND FEC_HASTA;
	SELECT COD_MODGENER INTO pCodModGener FROM FA_GENCENTREMI
	WHERE COD_CENTREMI=pcod_centremi
	AND COD_CATRIBUT=pcod_catribut
	AND COD_TIPMOVIMIEN=18
	AND COD_MODVENTA=13;
  marca :=1;
  IF periodo='0' THEN
  	marca:='77';
    UPDATE CET_TRANSACCION SET
	NUM_PROCFACT=num_pro,
	IND_FACTURACION='1'
	WHERE
  	IND_FACTURACION='0'
  	AND NUM_PROCFACT='0'
  	AND COD_SERVICIO=servicio
	AND NUM_VENTA=nventa
	AND COD_EMPRSERV=ltrim(rtrim(empresa))
	AND COD_ESTADO='V';
  ELSE
	marca:='87';
    UPDATE CET_TRANSACCION SET
	NUM_PROCFACT=num_pro,
	IND_FACTURACION='1'
	WHERE
  	IND_FACTURACION='0'
  	AND NUM_PROCFACT='0'
  	AND COD_SERVICIO=servicio
	AND COD_EMPRSERV=ltrim(rtrim(empresa))
	AND COD_ESTADO='V'
	AND TO_CHAR(FEC_CONTABLE,'DDMMYY')=ltrim(rtrim(periodo));

	pnum_venta:=0;
  END IF;
  marca:='98';
  OPEN DATOS(num_pro);
  mto_total:=0;
  num_reg:=0;
  LOOP
  --	           cod_emprserv, num_serie,  num_venta,  mto_servicio,  fec_movimiento FROM CET_TRANSACCION
  marca:='102';
  FETCH DATOS INTO pcod_empserv, pnum_serie, pnum_venta, pmto_servicio, pfec_movimiento, pfec_contab;
	-- cod_concepto
	marca:='107';
	SELECT COD_CONCEPTO INTO cod_concepto FROM CED_SERVEMPRE
	WHERE COD_SERVICIO=servicio
	AND COD_EMPRESA=pcod_empserv;
 EXIT WHEN DATOS%NOTFOUND;
  mto_total:=mto_total + pmto_servicio;
  num_reg:=num_reg + 1;
  marca:='115';
  END LOOP;
  CLOSE DATOS;
  IF cod_catimpo=1 THEN
     mto_total:=mto_total*100/118;
  END IF;
  pnventa:=nventa;
  INSERT INTO FA_PREFACTURA
  (NUM_PROCESO,
  COD_CLIENTE,
  COD_CONCEPTO,
  COLUMNA,
  COD_PRODUCTO,
  COD_MONEDA,
  FEC_VALOR,
  FEC_EFECTIVIDAD,
  IMP_CONCEPTO,
  IMP_FACTURABLE,
  IMP_MONTOBASE,
  COD_REGION,
  COD_PROVINCIA,
  COD_CIUDAD,
  COD_MODULO,
  IND_FACTUR,
  NUM_UNIDADES,
  COD_CATIMPOS,
  IND_ESTADO,
  COD_PORTADOR,
  COD_TIPCONCE,
  NUM_SERIEMEC,
  FLAG_IMPUES,
  NUM_VENTA,
  IND_SUPERTEL,
  NUM_PAQUETE,
  COD_TIPDOCUM,
  COD_PLANCOM
)
  VALUES
  (
  num_pro,		   	    --NUM_PROCESO	  NUMBER	8
  cliente,              --COD_CLIENTE     NUMBER	8
  cod_concepto,         --COD_CONCEPTO    NUMBER	4
  1,  			--correlativo,    COLUMNA	NUMBER 6
  1,					--COD_PRODUCTO    NUMBER	1
  '001',                --COD_MONEDA	  VARCHAR2  3
  pfec_movimiento,      --FEC_VALOR	      DATE
  pfec_contab,      --FEC_EFECTIVIDAD DATE
  mto_total,        --IMP_CONCEPTO    NUMBER	18
  mto_total,        --IMP_FACTURABLE  NUMBER	18
  mto_total,        --IMP_MONTOBASE	  NUMBER	18
  '13',                 --COD_REGION	  VARCHAR2  3
  '131',                --COD_PROVINCIA	  VARCHAR2  5
  '1312',               --COD_CIUDAD	  VARCHAR2  5
  'FA',                 --COD_MODULO	  VARCHAR2  2
  1,                    --IND_FACTUR	  NUMBER	1
  1,                    --NUM_UNIDADES	  NUMBER	4
  cod_catimpo,          --COD_CATIMPOS	  NUMBER	2
  0,                    --IND_ESTADO	  NUMBER	1
  0,                    --COD_PORTADOR	  NUMBER	5
  3,                    --COD_TIPCONCE	  NUMBER	2
  pnum_serie,           --NUM_SERIEMEC	  VARCHAR2  20
  1,                    --FLAG_IMPUES	  NUMBER	1
  pnventa,           --NUM_VENTA		  NUMBER	8
  0,                    --IND_SUPERTEL	  NUMBER	1
  0,                    --NUM_PAQUETE	  NUMBER	3
  18,                   --COD_TIPDOCUM	  NUMBER	2
 pcod_plancom			--NUMBER(5)
      );
  marca:='180';
  INSERT INTO CEH_FACTURA
  (COD_EMPRESA,
  COD_SERVICIO,
  FEC_EMISION,
  NUM_FOLIO,
  NUM_PROCESO,
  MTO_TOTAL,
  NUM_UNIDADES,
  IND_PASOCOBRO,
  COD_TIPDOCUM,
  IND_ORDENTOTAL,
  COD_CLIENTE,
  COD_PERFACT,
  FEC_VENCIMIE,
  NUM_VENTA)
  VALUES
  (pcod_empserv, --TRANSACCION,  --COD_EMPRESA	N  VARCHAR2	5
  servicio,      --COD_SERVICIO	N  VARCHAR2	5
  sysdate,       --FEC_EMISION	N  DATE
  0,    		 --NUM_FOLIO	Y  NUMBER	9
  num_pro,       --NUM_PROCESO	N  NUMBER	8
  mto_total,     --MTO_TOTAL	N  NUMBER	18 --Acumulacion de servicios facturados
  num_reg,    	 --NUM_UNIDADES	N  NUMBER	8  --Acumulacion de servicios facturados
  '0',           --IND_PASOCOBRO	N  VARCHAR2	1
  0,             --COD_TIPDOCUM	Y  NUMBER	2
  0,             --IND_ORDENTOTAL	Y  NUMBER	8
  cliente,	 	 --COD_CLIENTE	Y  NUMBER	8  --rescatado desde ced_parametros
  periodo,	 	 --COD_PERFACT	Y  VARCHAR2	6  --codigo de periodo cerrado
  sysdate,       --FEC_VENCIMIE	Y  DATE
  pnventa);       --NUM_VENTA	Y  NUMBER	8
  marca:='211';
  INSERT INTO FA_INTERFACT
  (NUM_PROCESO,
  NUM_VENTA,
  COD_MODGENER,
  COD_ESTADOC,
  COD_ESTPROC,
  COD_TIPMOVIMIEN,
  COD_CATRIBUT,
  COD_CATIMPOSITIVA,
  COD_TIPDOCUM,
  NUM_FOLIO,
  NUM_FOLIOREL,
  FEC_INGRESO,
  NUM_CUOTAS,
  COD_MODVENTA)
  VALUES
 (
 num_pro,      --NUM_PROCESO		NUMBER	  8
 pnventa,      --NUM_VENTA	        NUMBER	  8
 pCodModGener, --COD_MODGENER		VARCHAR2  3
 100,          --COD_ESTADOC	    NUMBER	  3
 3,            --COD_ESTPROC	    NUMBER	  1
 18,           --COD_TIPMOVIMIEN	NUMBER	  2
 pcod_catribut, --COD_CATRIBUT	    CHAR	  1
 cod_catimpo,  --COD_CATIMPOSITIVA	NUMBER    1
 0,            --COD_TIPDOCUM		NUMBER    2
 0,            --NUM_FOLIO	        NUMBER    9
 0,            --NUM_FOLIOREL	    NUMBER    9
 pfec_contab,  --FEC_INGRESO	    DATE	  7
 0,            --NUM_CUOTAS			NUMBER	  3
 13);          --COD_MODVENTA	    NUMBER    2
 marca:='243';
 INSERT INTO FA_PROCESOS
 (NUM_PROCESO, 					--Numero de proceso
 COD_TIPDOCUM, 					--18
 COD_VENDEDOR_AGENTE,           --ced_parametros
 COD_CENTREMI, 					--ced_parametros
 FEC_EFECTIVIDAD, 				--sysdate
 NOM_USUARORA,					--usuario session
 LETRAAG, 						--NULL
 NUM_SECUAG, 					--NULL
 COD_TIPDOCNOT, 				--NULL
 COD_VENDEDOR_AGENTENOT,		--NULL
 LETRANOT, 						--NULL
 COD_CENTRNOT, 					--NULL
 NUM_SECUNOT, 					--NULL
 IND_ESTADO, 					--NULL
 COD_CICLFACT, 					--NULL
 IND_NOTACREDC)					--0
 VALUES
 (
 num_pro,
 18,
 pcod_vendedor_agente,
 pcod_centremi,
 SYSDATE,
 usuario,
 'I',
 psecuencia,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 0);
--	marca :=0;
    EXCEPTION
	      WHEN ERROR_PROCESO THEN
          if marca != 0 then
				resp:=(SQLERRM ||'- en la linea N?: <'|| marca||'>');
				ROLLBACK;
           end if;
	      when OTHERS then
    		  resp:=(SQLERRM ||'- en la linea N?: <'|| marca||'>');
			  ROLLBACK;
 END CE_P_FACT_SER;
/
SHOW ERRORS
