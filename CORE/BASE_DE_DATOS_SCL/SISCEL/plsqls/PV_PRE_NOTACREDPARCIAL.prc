CREATE OR REPLACE PROCEDURE        PV_Pre_Notacredparcial(
 vp_secuencia_ga    IN VARCHAR2,
 vp_secuencia       IN VARCHAR2
 ) IS
oficina             VARCHAR2(2);
secuencia_ga        NUMBER;
vendedor	        NUMBER(6);
snumseq		        NUMBER(12);
sTabla		        VARCHAR2(25);
Lnumseq		        NUMBER(12);
lseqnue		        NUMBER(12);
vp_letra	        GE_LETRAS.LETRA%TYPE;
vp_tipo_tabla       VARCHAR2(1);
vp_cod_cliente      NUMBER(8);
vp_num_proceso      NUMBER(12);
vp_categoria_trib   VARCHAR2(1);
vp_ind_restnc       NUMBER(1);
--vp_secuencia_ga	    NUMBER(12);
cantidad            NUMBER(12);
producto            NUMBER(2);
vp_ordentotal       NUMBER(12);
vp_cod_modgener     VARCHAR2(3);
vp_des_cadena       VARCHAR2(255);
vp_error            NUMBER(2);
usuario	            VARCHAR2(30);
gls_error           VARCHAR2(100);
fecha               VARCHAR(10);
sFecInicio          VARCHAR(10);
sFecFin             VARCHAR(10);
VP_SQLCODE          VARCHAR2(5);
VP_SQLERRM          VARCHAR2(50);
cod_concepto        FA_CONCEPTOS.COD_CONCEPTO%TYPE;
fec_emision         VARCHAR(10);
vp_cod_catimpos        GE_DATOSGENER.COD_CATIMPOS%TYPE; --GE_LETRAS.COD_CATIMPOS%TYPE;
vp_cod_tipdocum        FA_HISTDOCU.COD_TIPDOCUM%TYPE;
cod_vendedor_agente FA_HISTDOCU.COD_VENDEDOR_AGENTE%TYPE;
sletra              FA_HISTDOCU.LETRA%TYPE;
vp_cod_modventa     FA_HISTDOCU.COD_MODVENTA%TYPE;
scentremi           FA_HISTDOCU.COD_CENTREMI%TYPE;
ssecuenci           FA_HISTDOCU.NUM_SECUENCI%TYPE;
vp_num_folio        FA_HISTDOCU.NUM_FOLIO%TYPE;
Acum_netograv       FA_HISTDOCU.ACUM_NETOGRAV%TYPE;
acum_netonograv     FA_HISTDOCU.ACUM_NETONOGRAV%TYPE;
acum_iva	    FA_HISTDOCU.ACUM_IVA%TYPE;
cod_plancom         FA_HISTDOCU.COD_PLANCOM%TYPE;
vp_totparcial       FA_APLICADONC.TOT_APLICADO%TYPE;
vp_imp_maximo	    FA_CONTROLNC.imp_maximo%TYPE;
centremi            NUMBER(4);
srowid		    VARCHAR(18);
vp_num_dias	    FA_CONTROLNC.num_dias%TYPE;
stotaplicado        NUMBER(14,4);
stotal1             NUMBER(14,4);
ind_supertel	    FA_HISTDOCU.IND_SUPERTEL%TYPE;
vp_ciclo	    FA_HISTDOCU.COD_CICLFACT%TYPE;
vp_tabla            VARCHAR2(20);
ins_ajuste          VARCHAR2(2000);
cursor_name         NUMBER;
rows_processed      INTEGER;
abrir		    NUMBER;
moneda              VARCHAR2(3);
cod_retorno         NUMBER;
des_cadena          VARCHAR2(255);
vp_entrada          VARCHAR2(1);
vp_fecha	    DATE;
vp_total            NUMBER(12);
ERROR_PROCESO EXCEPTION;
BEGIN
	sTabla := '';
  	vp_error := 0;
  	moneda := '001';
  	abrir := 0;
  	usuario := '';
  	gls_error := '';
        SELECT SYSDATE INTO vp_fecha
        FROM   DUAL;
        SELECT FA_SEQ_NUMPRO.NEXTVAL INTO vp_num_proceso
        FROM   DUAL;
        IF vp_secuencia IS NULL OR vp_secuencia = '' THEN
        	vp_error := 1;
                gls_error := 'Error. Falta indentificar Secuencia N.C.Parcial en parametros de entrada.';
                RAISE ERROR_PROCESO;
        END IF;
        IF vp_secuencia_ga IS NULL OR vp_secuencia_ga = '' THEN
        	vp_error := 2;
                gls_error := 'Error. Falta indentificar Secuencia GA.Abonados en parametros de entrada.';
                RAISE ERROR_PROCESO;
        END IF;
	sTabla :='FA_NCPARCIAL';
        SELECT DISTINCT COD_CLIENTE, IND_ORDENTOTAL
        INTO   vp_cod_cliente, vp_ordentotal
        FROM   FA_NCPARCIAL
        WHERE  NUM_SECUENCIA = vp_secuencia;
        SELECT SUM(IMP_CONCEPTO)
        INTO   vp_totparcial
        FROM   FA_NCPARCIAL
        WHERE  NUM_SECUENCIA = vp_secuencia;
	sTabla :='GA_CATRIBUTCLIE';
        SELECT COD_CATRIBUT
        INTO   vp_categoria_trib
        FROM   GA_CATRIBUTCLIE
        WHERE  COD_CLIENTE = vp_cod_cliente
        AND    FEC_DESDE <= vp_fecha
        AND    FEC_HASTA >= vp_fecha;
	sTabla :='FA_HISTDOCU/NOCICLO';
        SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
               COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
               ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT, TIPO_TABLA,
               COD_MODVENTA
        INTO   fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente, sletra,
               scentremi, ssecuenci, vp_num_folio, acum_netograv,
               acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo, vp_tipo_tabla,
               vp_cod_modventa
        FROM  (SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                      COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                      ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT, 'H' TIPO_TABLA,
                      COD_MODVENTA
               FROM   FA_HISTDOCU
               WHERE  IND_ORDENTOTAL = vp_ordentotal
               UNION ALL
               SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                      COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
                      ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT, 'N' TIPO_TABLA,
                      COD_MODVENTA
               FROM   FA_FACTDOCU_NOCICLO
               WHERE  IND_ORDENTOTAL = vp_ordentotal);
        IF vp_num_folio <= 0  THEN
             	vp_error := 3;
                gls_error := 'Error. Documento no tiene asociado num.folio.';
                RAISE ERROR_PROCESO;
        END IF;
        IF vp_tipo_tabla = 'H' THEN
        	sTabla :='FA_ENLACEHIST';
                SELECT FA_HISTCONC INTO vp_tabla
                FROM   FA_ENLACEHIST
                WHERE  COD_CICLFACT = vp_ciclo;
        END IF;
------- bValnotaCred
        SELECT  COUNT(*) INTO cantidad
        FROM    FA_INTERFACT
        WHERE   num_foliorel = vp_num_folio AND
        	cod_tipmovimien = 25        AND
                cod_estadoc < 200;
        IF cantidad > 0 THEN
             	vp_error := 4;
                gls_error := 'Error. Documento tiene pendiente la emision de Nota de Credito.';
                RAISE ERROR_PROCESO;
        END IF;
        IF (ind_Supertel = '1') AND (vp_cod_tipdocum = '2') THEN
             	vp_error := 4;
                gls_error := 'Error. Factura Corresponde a Supertelefono, No es posible generar Nota de Credito';
                RAISE ERROR_PROCESO;
        END IF;
        IF cod_vendedor_agente IS NULL THEN
             	vp_error := 4;
                gls_error := 'Error. Documento no tiene asociado un vendedor.';
                RAISE ERROR_PROCESO;
        END IF;
        IF vp_cod_modventa = 5 THEN
             	vp_error := 4;
                gls_error := 'Error. Factura de Venta Regalo. Tiene Restriccion para realizar solo N.C. Correctivas';
                RAISE ERROR_PROCESO;
        END IF;
------- bSQLInsertAjuste
        SELECT COUNT(*) INTO cantidad
        FROM   FA_AJUSTES
        WHERE  NUM_FOLIO = vp_num_folio
        AND    COD_CLIENTE = vp_cod_cliente
        AND    COD_TIPDOCUM = vp_cod_tipdocum;
        IF cantidad <= 0 THEN
        	INSERT INTO FA_AJUSTES
                (NUM_FOLIO         ,
                ACUM_NETONOGRAVORIG,
 	        ACUM_NETONOGRAVNC  ,
 	        ACUM_NETONOGRAVND ,
 	        ACUM_NETOGRAVORIG,
                ACUM_NETOGRAVNC  ,
 	        ACUM_NETOGRAVND  ,
 	        COD_PLANCOM      ,
 	        COD_CATIMPOS     ,
 	        ACUM_IVAORIG     ,
 	        ACUM_IVANC       ,
 	        ACUM_IVAND       ,
 	        COD_CLIENTE      ,
 	        COD_TIPDOCUM  )
                VALUES
                (vp_num_folio,
                 acum_netograv,
                 0,
                 0,
                 acum_netonograv,
                 0,
                 0,
                 cod_plancom,
                 vp_cod_catimpos,
 	         acum_iva,
 	         0,
 	         0,
 	         vp_cod_cliente,
 	         vp_cod_tipdocum);
--------------- bSQLInsertConc
                IF vp_tipo_tabla = 'N' THEN
			sTabla :='CONCEPTOS NOCICLO';
                        INSERT INTO FA_AJUSTECONC
                        (NUM_FOLIO, COD_CONCEPTO, COLUMNA,
                        COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA,
                        IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
                        COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR,
                        IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR,
                        DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE,
                        MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION,
                        FLAG_IMPUES, FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM)
                        SELECT vp_num_folio, a.COD_CONCEPTO,
                        a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, 0,'001',
                        a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA,
                        a.COD_CIUDAD, b.COD_MODULO,
                        a.NUM_UNIDADES, a.NUM_SERIEMEC,
                        a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE,
                        a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR,
                        a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA,
                        a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA,
                        a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES,
                        a.FLAG_DTO, c.COD_CLIENTE, C.COD_TIPDOCUM
                        FROM  FA_CONCEPTOS              b,
                              FA_FACTDOCU_NOCICLO       c,
                              FA_FACTCONC_NOCICLO       a
                        WHERE a.IND_ORDENTOTAL =  vp_ordentotal    AND
                              a.COD_CONCEPTO   =  b.COD_CONCEPTO   AND
                              a.IND_ORDENTOTAL =  c.IND_ORDENTOTAL AND
                              a.COD_TIPCONCE   <> 1                AND
                              a.COD_TIPCONCE   <> 2;
                        UPDATE FA_AJUSTECONC A
                        SET    IMP_FACTURABLE = (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE
                                                 FROM   FA_FACTCONC_NOCICLO B
                                                 WHERE  B.IND_ORDENTOTAL = vp_ordentotal     AND
                                                        B.COD_TIPCONCE = 2         	     AND
                                                        A.COD_CONCEPTO = B.COD_CONCEREL      AND
                                                        A.COLUMNA = B.COLUMNA_REL)
                        WHERE  A.NUM_FOLIO = vp_num_folio AND
                               A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL
                                                  FROM   FA_FACTCONC_NOCICLO B
                                                  WHERE  B.IND_ORDENTOTAL = vp_ordentotal    AND
                                                         B.COD_TIPCONCE = 2         	     AND
                                                         A.COD_CONCEPTO = B.COD_CONCEREL     AND
                                                         A.COLUMNA = B.COLUMNA_REL);
                ELSE
                        sTabla :='CONCEPTOS HIST';
	        	ins_ajuste := 'INSERT INTO FA_AJUSTECONC ';
                        ins_ajuste := ins_ajuste || '(NUM_FOLIO, COD_CONCEPTO, COLUMNA, ';
                        ins_ajuste := ins_ajuste || 'COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA, ';
                        ins_ajuste := ins_ajuste || 'IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD, ';
                        ins_ajuste := ins_ajuste || 'COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR, ';
                        ins_ajuste := ins_ajuste || 'IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR, ';
                        ins_ajuste := ins_ajuste || 'DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE, ';
                        ins_ajuste := ins_ajuste || 'MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION, ';
                        ins_ajuste := ins_ajuste || 'FLAG_IMPUES, FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM) ';
                        ins_ajuste := ins_ajuste || 'SELECT c.num_folio, a.COD_CONCEPTO, ';
                        ins_ajuste := ins_ajuste || 'a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, 0, ' || RTRIM(moneda) || ', ';
                        ins_ajuste := ins_ajuste || 'a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA, ';
                        ins_ajuste := ins_ajuste || 'a.COD_CIUDAD, b.COD_MODULO, ';
                        ins_ajuste := ins_ajuste || 'a.NUM_UNIDADES, a.NUM_SERIEMEC, ';
                        ins_ajuste := ins_ajuste || 'a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE, ';
                        ins_ajuste := ins_ajuste || 'a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR, ';
                        ins_ajuste := ins_ajuste || 'a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, ';
                        ins_ajuste := ins_ajuste || 'a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, ';
                        ins_ajuste := ins_ajuste || 'a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES, ';
                        ins_ajuste := ins_ajuste || 'a.FLAG_DTO, c.COD_CLIENTE, C.COD_TIPDOCUM ';
                        ins_ajuste := ins_ajuste || 'FROM  FA_CONCEPTOS         b, ';
                        ins_ajuste := ins_ajuste || '      FA_HISTDOCU          c, ';
                        ins_ajuste := ins_ajuste || '     ' || RTRIM(vp_tabla) || ' a  ';
                        ins_ajuste := ins_ajuste || 'WHERE a.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
                        ins_ajuste := ins_ajuste || '      a.COD_CONCEPTO   =  b.COD_CONCEPTO     AND ';
                        ins_ajuste := ins_ajuste || '      a.IND_ORDENTOTAL =  c.IND_ORDENTOTAL   AND ';
                        ins_ajuste := ins_ajuste || '      a.COD_TIPCONCE   <> 1                  AND ';
                        ins_ajuste := ins_ajuste || '      a.COD_TIPCONCE   <> 2                      ';
	        	cursor_name := dbms_sql.open_cursor;
	        	dbms_sql.parse(cursor_name, ins_ajuste, dbms_sql.v7);
	        	rows_processed := dbms_sql.EXECUTE(cursor_name);
	        	dbms_sql.close_cursor(cursor_name);
	        	ins_ajuste := '';
	        	ins_ajuste := 'UPDATE FA_AJUSTECONC A ';
			ins_ajuste := ins_ajuste || 'SET    IMP_FACTURABLE =  (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE ';
			ins_ajuste := ins_ajuste || '                          FROM   ' || RTRIM(vp_tabla) || ' B ';
			ins_ajuste := ins_ajuste || '                          WHERE  B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
			ins_ajuste := ins_ajuste || '                                 B.COD_TIPCONCE = 2         	  AND ';
			ins_ajuste := ins_ajuste || '                                 A.COD_CONCEPTO = B.COD_CONCEREL     AND ';
			ins_ajuste := ins_ajuste || '                                 A.COLUMNA = B.COLUMNA_REL) ';
			ins_ajuste := ins_ajuste || 'WHERE  A.NUM_FOLIO = ' || RTRIM(TO_CHAR(vp_num_folio)) || ' AND ';
			ins_ajuste := ins_ajuste || '       A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL ';
			ins_ajuste := ins_ajuste || '                          FROM   ' || RTRIM(vp_tabla) || ' B ';
			ins_ajuste := ins_ajuste || '                          WHERE  B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
			ins_ajuste := ins_ajuste || '                                 B.COD_TIPCONCE = 2         	  AND ';
			ins_ajuste := ins_ajuste || '                                 A.COD_CONCEPTO = B.COD_CONCEREL     AND ';
			ins_ajuste := ins_ajuste || '                                 A.COLUMNA = B.COLUMNA_REL) ';
	        	cursor_name := dbms_sql.open_cursor;
	        	dbms_sql.parse(cursor_name, ins_ajuste, dbms_sql.v7);
	        	rows_processed := dbms_sql.EXECUTE(cursor_name);
	        	dbms_sql.close_cursor(cursor_name);
                END IF;
        END IF;
        SELECT  COUNT(*) INTO vp_total
        FROM   (
        	SELECT  a.COD_CONCEPTO, a.COLUMNA, (a.IMP_FACTURABLE - a.IMP_CONCEPTO) IMP_CONNC,
        	        c.IMP_CONCEPTO
                FROM    FA_AJUSTECONC a,
                        FA_AJUSTES    b,
                        FA_NCPARCIAL  c
                WHERE   a.NUM_FOLIO    = TO_NUMBER(vp_num_folio)    AND
                        a.COD_CLIENTE  = TO_NUMBER(vp_cod_cliente)  AND
                        a.COD_TIPDOCUM = TO_NUMBER(vp_cod_tipdocum) AND
                        c.num_secuencia= TO_NUMBER(vp_secuencia)    AND
                        a.cod_concepto = c.cod_concepto             AND
                        a.columna      = c.columna                  AND
          		a.NUM_FOLIO = b.NUM_FOLIO                   AND
        	        a.COD_CLIENTE = b.COD_CLIENTE               AND
        	        a.COD_TIPDOCUM = b.COD_TIPDOCUM)
        WHERE IMP_CONCEPTO > IMP_CONNC;
        IF vp_total > 0 THEN
             	vp_error := 5;
                gls_error := 'Error. Existen conceptos cuyo monto N.C. excede al permitido ( ' || vp_total || ' ).';
                RAISE ERROR_PROCESO;
        END IF;
	sTabla :='FA_TIPDOCUMEN';
        SELECT IND_RESTNC
        INTO   vp_ind_restnc
        FROM   FA_TIPDOCUMEN
        WHERE  COD_TIPDOCUMMOV = vp_cod_tipdocum;
        IF vp_ind_restnc = 1 OR vp_ind_restnc = 3 THEN --por el total - restriccion total
             	vp_error := 5;
                gls_error := 'Error. Existen conceptos cuyo monto N.C. excede al permitido ( ' || vp_total || ' ).';
                RAISE ERROR_PROCESO;
        END IF;
------- sSecuenciaEmi
        SELECT FA_SEQ_CREDITO.NEXTVAL INTO snumseq
        FROM   DUAL;
        snumseq := snumseq + 1;
        SELECT USER, RTRIM(TO_CHAR(SYSDATE, 'dd-mm-yyyy')) INTO usuario, fecha
        FROM   DUAL;
	sTabla :='GA_SEG_USUARIO';
        SELECT NVL(COD_VENDEDOR, -1), NVL(COD_OFICINA, ' ') INTO vendedor, oficina
        FROM   GE_SEG_USUARIO
        WHERE  NOM_USUARIO = usuario;
        IF vendedor = -1 OR oficina = ' ' THEN
	       sTabla :='GE_DATOSGENER';
               SELECT COD_AGENTESTARTEL, COD_OFICCENTRAL INTO vendedor, oficina
               FROM   GE_DATOSGENER;
               IF vendedor = ' ' OR oficina = ' ' THEN
            	        vp_error := 6;
                        gls_error := 'Error. No existe vendedor.';
                        RAISE ERROR_PROCESO;
               END IF;
        END IF;
	sTabla :='AL_DOCUM_SUCURSAL';
        SELECT COD_CENTREMI INTO centremi
        FROM   AL_DOCUM_SUCURSAL
        WHERE  COD_TIPDOCUM = 25 AND
               COD_OFICINA = oficina;
------- bGetLetraAG
        sTabla :='GE_LETRAS';
        SELECT LETRA INTO vp_letra
        FROM   GE_LETRAS
        WHERE  COD_CATIMPOS = vp_cod_catimpos
        AND    COD_TIPDOCUM = 25;
        IF vp_letra = ' ' THEN
             	vp_error := 7;
                gls_error := 'Error. Categoria impositiva no tiene asociada Letra (GE_LETRAS).';
                RAISE ERROR_PROCESO;
        END IF;
--- bInsertProceso
        INSERT INTO FA_PROCESOS(NUM_PROCESO, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
                                COD_CENTREMI, FEC_EFECTIVIDAD, NOM_USUARORA,
				LETRAAG, NUM_SECUAG, COD_TIPDOCNOT, COD_VENDEDOR_AGENTENOT,
				LETRANOT, COD_CENTRNOT, NUM_SECUNOT, IND_ESTADO, COD_CICLFACT, IND_NOTACREDC)
        VALUES (vp_num_proceso, 25, vendedor,
--      	centremi, fec_emision, usuario,
      		centremi, SYSDATE, usuario,
        	vp_letra, snumseq, vp_cod_tipdocum, cod_vendedor_agente,
        	sletra, scentremi, ssecuenci, NULL, NULL, 0
        	);
------- bInsertPrefactura
        INSERT INTO FA_PREFACTURA
        (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO, COLUMNA,
        COD_PRODUCTO, COD_MONEDA, FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
        IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
        COD_MODULO, COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,COD_PORTADOR,IND_ESTADO,
        COD_TIPCONCE,NUM_UNIDADES,COD_CICLFACT,COD_CONCEREL,COLUMNA_REL,NUM_ABONADO,
        NUM_TERMINAL,CAP_CODE,NUM_SERIEMEC,NUM_SERIELE,FLAG_IMPUES,FLAG_DTO,NUM_VENTA,
        NUM_TRANSACCION,MES_GARANTIA,NUM_GUIA,IND_ALTA,IND_SUPERTEL,NUM_PAQUETE,IND_CUOTA,
        NUM_CUOTAS, ORD_CUOTA, COD_TIPDOCUM)
        SELECT vp_num_proceso,  a.COD_CLIENTE, a.COD_CONCEPTO, a.COLUMNA, a.COD_PRODUCTO,
 	       '001',a.FEC_VALOR, a.FEC_EFECTIVIDAD,
 		c.IMP_CONCEPTO, c.IMP_CONCEPTO,-- Parcial
 		0, a.COD_REGION, a.COD_PROVINCIA, a.COD_CIUDAD,
 		a.COD_MODULO, b.COD_PLANCOM, a.IND_FACTUR, b.COD_CATIMPOS, a.COD_PORTADOR,
 		0, a.COD_TIPCONCE, 1, NULL, NULL, NULL, a.NUM_ABONADO, NULL, NULL,
 		a.NUM_SERIEMEC, a.NUM_SERIELE, a.FLAG_IMPUES, a.FLAG_DTO, a.NUM_VENTA,
 		a.NUM_TRANSACCION, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, a.IND_SUPERTEL,
                a.NUM_PAQUETE, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, B.COD_TIPDOCUM
        FROM    FA_AJUSTECONC a,
                FA_AJUSTES    b,
                FA_NCPARCIAL  c
        WHERE   a.NUM_FOLIO    = TO_NUMBER(vp_num_folio)    AND
                a.COD_CLIENTE  = TO_NUMBER(vp_cod_cliente)  AND
                a.COD_TIPDOCUM = TO_NUMBER(vp_cod_tipdocum) AND
                c.num_secuencia= TO_NUMBER(vp_secuencia)    AND
                a.cod_concepto = c.cod_concepto             AND
                a.columna      = c.columna                  AND
  		a.NUM_FOLIO = b.NUM_FOLIO                   AND
	        a.COD_CLIENTE = b.COD_CLIENTE               AND
	        a.COD_TIPDOCUM = b.COD_TIPDOCUM;
------- bControlPeriodo
	vp_imp_maximo := 0;
	vp_num_dias := 0;
	sTabla :='FA_CONTROLNC';
        SELECT  IMP_MAXIMO, NUM_DIAS
                INTO vp_imp_maximo, vp_num_dias
        FROM    FA_CONTROLNC
        WHERE   NOM_USUARIO = usuario AND
                FEC_DESDE <= SYSDATE  AND
                FEC_HASTA >= SYSDATE;
        SELECT COUNT(*) INTO CANTIDAD
        FROM    fa_aplicadonc
        WHERE   NOM_USUARIO = usuario  AND
                COD_CLIENTE = TO_NUMBER(vp_cod_cliente)  AND
                FEC_INICIO <= SYSDATE      AND
                FEC_FIN >= SYSDATE;
        IF CANTIDAD <= 0 THEN
--------------- bInsertAplicadoNC
	        INSERT INTO FA_APLICADONC(NOM_USUARIO, COD_CLIENTE, FEC_INICIO, FEC_FIN, TOT_APLICADO)
                VALUES ( usuario, TO_NUMBER(vp_cod_cliente),
                         TO_DATE(TO_CHAR(TRUNC(SYSDATE, 'MONTH'), 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                         TO_DATE(TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,1),'MONTH')-1/86400, 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                         vp_totparcial
                        );
        ELSE
                SELECT  ROWID, TOT_APLICADO, TO_CHAR(FEC_INICIO, 'DD/MM/YYYY'), TO_CHAR(FEC_FIN, 'DD/MM/YYYY')
                        INTO srowid, sTotAplicado, sFecInicio, sFecFin
                FROM    FA_APLICADONC
                WHERE   NOM_USUARIO = usuario  AND
                        COD_CLIENTE = TO_NUMBER(vp_cod_cliente)  AND
                        FEC_INICIO <= SYSDATE      AND
                        FEC_FIN >= SYSDATE;
        	stotal1 := vp_totparcial + sTotAplicado;
                IF stotal1 <= vp_imp_maximo THEN
	                UPDATE FA_APLICADONC
	                SET    TOT_APLICADO = TOT_APLICADO + vp_totparcial
		        WHERE  ROWID = sRowid;
                ELSE
            	        vp_error := 8;
                        gls_error := 'Error. Se ha sobrepasado el Limite Importe para el Usuario.';
                        RAISE ERROR_PROCESO;
                END IF;
        END IF;
------- bUpdConc_tot
        UPDATE  FA_AJUSTECONC A
        SET     IMP_CONCEPTO = (SELECT A.IMP_CONCEPTO + B.IMP_CONCEPTO
        		        FROM   FA_NCPARCIAL B
        		        WHERE  B.NUM_SECUENCIA = vp_secuencia   AND
        		               A.COD_CONCEPTO  = B.COD_CONCEPTO AND
        		               A.COLUMNA = B.COLUMNA)
        WHERE   A.NUM_FOLIO    = TO_NUMBER(vp_num_Folio)   AND
        	A.COD_CLIENTE  = TO_NUMBER(vp_cod_cliente) AND
        	A.COD_TIPDOCUM = vp_cod_tipdocum           AND
        	A.COD_CONCEPTO IN (SELECT B.COD_CONCEPTO
        	                   FROM   FA_NCPARCIAL B
        		           WHERE  B.NUM_SECUENCIA = vp_secuencia   AND
        		                  A.COD_CONCEPTO  = B.COD_CONCEPTO AND
        		                  A.COLUMNA = B.COLUMNA);
        lSeqNue := sNumSeq + 1;
------- bUpdSecuencia
        UPDATE  GE_SECUENCIASEMI
        SET     NUM_SECUENCI = lSeqNue
        WHERE   COD_TIPDOCUM = 25       AND
                COD_CENTREMI = centremi AND
                LETRA = vp_letra; -- GE_LETRAS
        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO secuencia_ga
        FROM   DUAL;
	sTabla :='FA_GENCENTREMI';
        SELECT 	COD_MODGENER INTO vp_cod_modgener
        FROM 	FA_GENCENTREMI
        WHERE 	COD_CENTREMI = centremi AND
        	COD_TIPMOVIMIEN = 25    AND
        	COD_CATRIBUT = vp_categoria_trib AND
			COD_MODVENTA = vp_cod_modventa;
  	vp_entrada := '0';
        Pv_Ins_Interfact( TO_CHAR(secuencia_ga), vp_num_proceso, '0',
 			  vp_cod_modgener, '25', vp_categoria_trib, TO_CHAR(vp_num_folio), '100', '3', fecha, vp_entrada, '1', '0');
	sTabla :='GA_TRANSACABO';
	SELECT COD_RETORNO, DES_CADENA INTO cod_retorno, des_cadena
	FROM   ga_transacabo
	WHERE  num_transaccion = secuencia_ga;
	IF cod_retorno != 0 THEN
		vp_error := 9;
	        RAISE ERROR_PROCESO;
	ELSE
	       DELETE FROM ga_transacabo WHERE num_transaccion = secuencia_ga;
	END IF;
        UPDATE FA_NCPARCIAL
        SET    FLG_EMINC = 1, NUM_PROCESO = vp_num_proceso
        WHERE  NUM_SECUENCIA = vp_secuencia;
        RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           /*IF vp_error != 0 THEN
                ROLLBACK;
           END IF;*/
	   IF vp_error = 0 THEN
           	  INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           	  VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, TO_CHAR(vp_num_proceso));
	   ELSE
           	  INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           	  VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
	   END IF;
      WHEN DUP_VAL_ON_INDEX THEN
           --ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Duplicado');
      WHEN NO_DATA_FOUND THEN
           --ROLLBACK;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Datos No Fueron Encontrados ' || sTabla);
      WHEN OTHERS THEN
           --ROLLBACK;
      	   INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Otros Errores No Esperados');
END PV_Pre_Notacredparcial;
/
SHOW ERRORS
