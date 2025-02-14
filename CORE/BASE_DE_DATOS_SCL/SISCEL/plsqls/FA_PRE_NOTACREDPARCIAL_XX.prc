CREATE OR REPLACE PROCEDURE        Fa_Pre_Notacredparcial_xx( vp_secuencia_ga    IN VARCHAR2,
                                                    vp_secuencia       IN VARCHAR2)
IS
  TYPE AjusteCurTyp IS REF CURSOR;  -- define REF CURSOR type
Ajuste_cv   		AjusteCurTyp;  -- declara cursor variable
Ajuste_sql 		    varchar2(1000);
vCodConcepto    	FA_AJUSTECONC.cod_concepto%TYPE;
vcolumna        	FA_AJUSTECONC.columna%TYPE;
oficina             VARCHAR2(2);
secuencia_ga        NUMBER;
vendedor            NUMBER(6);
snumseq             NUMBER(12);
sTabla              VARCHAR2(50);
Lnumseq             NUMBER(12);
lseqnue             NUMBER(12);
vp_letra            GE_LETRAS.LETRA%TYPE;
vp_tipo_tabla       VARCHAR2(1);
vp_cod_cliente      NUMBER(8);
vp_num_proceso      NUMBER(12);
vp_categoria_trib   VARCHAR2(1);
vp_ind_restnc       NUMBER(1);
cantidad            NUMBER(12);
producto            NUMBER(2);
vp_ordentotal       NUMBER(12);
vp_cod_modgener     VARCHAR2(3);
vp_des_cadena       VARCHAR2(255);
vp_error            NUMBER(2);
usuario             VARCHAR2(30);
gls_error           VARCHAR2(100);
fecha               VARCHAR(10);
sFecInicio          VARCHAR(10);
sFecFin             VARCHAR(10);
VP_SQLCODE          VARCHAR2(5);
VP_SQLERRM          VARCHAR2(50);
cod_concepto        FA_CONCEPTOS.COD_CONCEPTO%TYPE;
fec_emision         VARCHAR(10);
vp_cod_catimpos     GE_DATOSGENER.COD_CATIMPOS%TYPE; --GE_LETRAS.COD_CATIMPOS%TYPE;
vp_cod_tipdocum     FA_HISTDOCU.COD_TIPDOCUM%TYPE;
cod_vendedor_agente FA_HISTDOCU.COD_VENDEDOR_AGENTE%TYPE;
sletra              FA_HISTDOCU.LETRA%TYPE;
vp_cod_modventa     FA_HISTDOCU.COD_MODVENTA%TYPE;
scentremi           FA_HISTDOCU.COD_CENTREMI%TYPE;
ssecuenci           FA_HISTDOCU.NUM_SECUENCI%TYPE;
vp_num_folio        FA_HISTDOCU.NUM_FOLIO%TYPE;
vp_pref_plaza       FA_HISTDOCU.PREF_PLAZA%TYPE;
vp_tip_foliacion	VARCHAR2(1);
Acum_netograv       FA_HISTDOCU.ACUM_NETOGRAV%TYPE;
acum_netonograv     FA_HISTDOCU.ACUM_NETONOGRAV%TYPE;
acum_iva            FA_HISTDOCU.ACUM_IVA%TYPE;
cod_plancom         FA_HISTDOCU.COD_PLANCOM%TYPE;
vp_totparcial       FA_APLICADONC.TOT_APLICADO%TYPE;
vp_imp_maximo       FA_CONTROLNC.imp_maximo%TYPE;
centremi            NUMBER(4);
srowid              VARCHAR(18);
vp_num_dias         FA_CONTROLNC.num_dias%TYPE;
stotaplicado        NUMBER(14,4);
stotal1             NUMBER(14,4);
ind_supertel        FA_HISTDOCU.IND_SUPERTEL%TYPE;
vp_ciclo            FA_HISTDOCU.COD_CICLFACT%TYPE;
vp_tabla            VARCHAR2(20);
ins_ajuste          VARCHAR2(5000);
cursor_name         NUMBER;
rows_processed      INTEGER;
abrir               NUMBER;
moneda              VARCHAR2(3);
cod_retorno         NUMBER;
des_cadena          VARCHAR2(255);
vp_entrada          VARCHAR2(1);
vp_fecha            DATE;
vp_total            NUMBER(12);
sFormatoFecha       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
ERROR_PROCESO EXCEPTION;
-- errores de variables IN vp_error := 1;
-- errores de select vp_error := 2;
-- errores de insert vp_error := 3;
-- errores de update vp_error := 4;
-- el ultimo fue Msj42,
BEGIN
    sTabla := '';
    vp_error := 0;
    moneda := FA_FN_CODMONFACT;
    abrir := 0;
    usuario := '';
    gls_error := '';
    vp_fecha:= SYSDATE;

	--vp_num_proceso := to_number(vp_numproc);
    --SELECT FA_SEQ_NUMPRO.NEXTVAL INTO vp_num_proceso FROM DUAL; ''se pasa por parametro este valor 12052003

    IF vp_secuencia IS NULL OR vp_secuencia = '' THEN
        vp_error := 1;
        gls_error := 'Error. Falta indentificar Secuencia N.C.Parcial en parámetros de entrada. Msj1';
        RAISE ERROR_PROCESO;
    END IF;

    IF vp_secuencia_ga IS NULL OR vp_secuencia_ga = '' THEN
        vp_error := 1;
        gls_error := 'Error. Falta indentificar Secuencia GA.Abonados en parámetros de entrada. Msj2';
        RAISE ERROR_PROCESO;
    END IF;

    sTabla :='FA_NCPARCIAL' || vp_secuencia_ga;

	BEGIN
    	 SELECT DISTINCT COD_CLIENTE, IND_ORDENTOTAL, NUM_PROCESO
    	 INTO  vp_cod_cliente, vp_ordentotal, vp_num_proceso
    	 FROM  FA_NCPARCIAL
    	 WHERE NUM_SECUENCIA = vp_secuencia;
	EXCEPTION
             WHEN NO_DATA_FOUND THEN
          	 	  vp_error := 2;
                  gls_error := 'Error. No se encontro datos en tabla FA_NCPARCIAL. Msj3';
                  RAISE ERROR_PROCESO;
	END;
	BEGIN
    	 SELECT SUM(IMP_CONCEPTO)
		 INTO   vp_totparcial
		 FROM   FA_NCPARCIAL
		 WHERE  NUM_SECUENCIA = vp_secuencia;
	EXCEPTION
             WHEN NO_DATA_FOUND THEN
          	 	  vp_error := 2;
                  gls_error := 'Error. No se encontro el total importe en tabla FA_NCPARCIAL. Msj4';
                  RAISE ERROR_PROCESO;
	END;

    sTabla :='GA_CATRIBUTCLIE';

------- Extrae la Categoria Tributaria del cliente
	BEGIN
    	 SELECT COD_CATRIBUT
    	 INTO   vp_categoria_trib
    	 FROM   GA_CATRIBUTCLIE
    	 WHERE  COD_CLIENTE = vp_cod_cliente
    	 AND    FEC_DESDE <= vp_fecha
    	 AND    FEC_HASTA >= vp_fecha;
	EXCEPTION
             WHEN NO_DATA_FOUND THEN
          	 	  vp_error := 2;
                  gls_error := 'Error. No se encontro datos en tabla GA_CATRIBUTCLIE. Msj5';
                  RAISE ERROR_PROCESO;
	END;

------- Extrae los datos del documentos a la cual se esta realizando la Nota de Crédito
------  Si es Historico ciclico lo marca con H de lo contrario N

    sTabla :='FA_HISTDOCU/NOCICLO';
	BEGIN
		 SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
		   		LETRA, COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
		   		ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT,
		   		TIPO_TABLA, COD_MODVENTA, PREF_PLAZA
    	 INTO   fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente,
		   		sletra, scentremi, ssecuenci, vp_num_folio, acum_netograv,
		   		acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo,
		   		vp_tipo_tabla, vp_cod_modventa, vp_pref_plaza
    	 FROM ( SELECT FEC_EMISION , COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
         	  		   COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO    , ACUM_NETOGRAV, ACUM_NETONOGRAV,
                 	   COD_PLANCOM , ACUM_IVA    , IND_SUPERTEL , COD_CICLFACT , 'H' TIPO_TABLA,
				 	   COD_MODVENTA, PREF_PLAZA
          			   FROM   FA_HISTDOCU
          			   WHERE  IND_ORDENTOTAL = vp_ordentotal
          		UNION ALL
          		SELECT FEC_EMISION , COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
                	   COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO    , ACUM_NETOGRAV, ACUM_NETONOGRAV,
                 	   COD_PLANCOM , ACUM_IVA    , IND_SUPERTEL , COD_CICLFACT , 'N' TIPO_TABLA ,
				 	   COD_MODVENTA, PREF_PLAZA
          			   FROM   FA_FACTDOCU_NOCICLO
          			   WHERE  IND_ORDENTOTAL = vp_ordentotal);
	EXCEPTION
             WHEN NO_DATA_FOUND THEN
          	 	  vp_error := 2;
                  gls_error := 'Error. No se encontro datos de la factura. Msj6';
                  RAISE ERROR_PROCESO;
	END;

    IF vp_num_folio <= 0  THEN
        vp_error := 5;
        gls_error := 'Error. Documento no tiene asociado núm.folio. Msj7';
        RAISE ERROR_PROCESO;
    END IF;
	IF vp_pref_plaza = ''  THEN
      	vp_error := 5;
        gls_error := 'Error. Documento no tiene asociado prefijo de plaza. Msj8';
        RAISE ERROR_PROCESO;
    END IF;
    IF vp_tipo_tabla = 'H' THEN
        sTabla :='FA_ENLACEHIST';
		BEGIN
        	 SELECT FA_HISTCONC INTO vp_tabla
          	 FROM   FA_ENLACEHIST
         	 WHERE  COD_CICLFACT = vp_ciclo;
		EXCEPTION
             WHEN NO_DATA_FOUND THEN
          	 	  vp_error := 2;
                  gls_error := 'Error. No se encontro tabla de enlace histórico. Msj9';
                  RAISE ERROR_PROCESO;
		END;
    END IF;
------- bValnotaCred

------- Verifica si tiene pendiente alguna nota de credito para ese documento
    sTabla :='FA_INTERFACT';

	SELECT COUNT(1) INTO cantidad
   	FROM   FA_INTERFACT
   	WHERE  num_foliorel = vp_num_folio
	AND    pref_plazarel = vp_pref_plaza
   	AND    cod_tipmovimien = 25
   	AND    cod_estadoc < 200;
    IF cantidad > 0 THEN
            vp_error := 5;
            gls_error := 'Error. Documento tiene pendiente la emisión de Nota de Crédito. Msj10';
            RAISE ERROR_PROCESO;
    END IF;
    IF (ind_Supertel = '1') AND (vp_cod_tipdocum = '2') THEN
            vp_error := 5;
            gls_error := 'Error. Factura Corresponde a Supertelefono, No es posible generar Nota de Credito. Msj11';
            RAISE ERROR_PROCESO;
    END IF;

    IF cod_vendedor_agente IS NULL THEN
            vp_error := 5;
            gls_error := 'Error. Documento no tiene asociado un vendedor. Msj12';
            RAISE ERROR_PROCESO;
    END IF;

    IF vp_cod_modventa = 5 THEN
            vp_error := 5;
            gls_error := 'Error. Factura de Venta Regalo. Tiene Restricción para realizar sólo NC Correctivas. Msj13';
            RAISE ERROR_PROCESO;
    END IF;

------- bSQLInsertAjuste
------- Verifica si el documento seleccionado ya tiene Nota de Crédito. En caso de tener no Inserta el nuevo registro, de lo contrario
------- Insertará en la Fa_ajuste y el detalle del Documento en la Fa_ajusteconc


    SELECT  COUNT(1) INTO cantidad
    FROM  FA_AJUSTES
    WHERE  NUM_FOLIO = vp_num_folio
	AND  PREF_PLAZA  = vp_pref_plaza
    AND  COD_CLIENTE = vp_cod_cliente
    AND  COD_TIPDOCUM = vp_cod_tipdocum;

    IF cantidad <= 0 THEN
	    sTabla :='FA_AJUSTES';
		BEGIN
        	 INSERT INTO FA_AJUSTES
             		(NUM_FOLIO, ACUM_NETONOGRAVORIG , ACUM_NETONOGRAVNC,
                    ACUM_NETONOGRAVND, ACUM_NETOGRAVORIG, ACUM_NETOGRAVNC,
                    ACUM_NETOGRAVND, COD_PLANCOM, COD_CATIMPOS,
                    ACUM_IVAORIG, ACUM_IVANC, ACUM_IVAND,
                    COD_CLIENTE, COD_TIPDOCUM, PREF_PLAZA)
             VALUES (vp_num_folio, acum_netonograv, 0,
                    0, acum_netograv, 0,
                    0, cod_plancom, vp_cod_catimpos,
                    acum_iva, 0, 0,
                    vp_cod_cliente, vp_cod_tipdocum, vp_pref_plaza);
		EXCEPTION
				 WHEN DUP_VAL_ON_INDEX THEN
				 	  vp_error := 3;
                   	  gls_error := 'Error. No se pudo insertar en tabla FA_AJUSTES por PK duplicadas. Msj14';
                   	  RAISE ERROR_PROCESO;
				 WHEN OTHERS THEN
                      vp_error := 3;
                      gls_error := 'Error. No se pudo insertar en la tabla FA_AJUSTES. Msj15';
                      RAISE ERROR_PROCESO;
		END;

--------------- bSQLInsertConc
--------------- Selecciona los Datos de tablas Nociclicas

        IF vp_tipo_tabla = 'N' THEN

            sTabla :='CONCEPTOS NOCICLO';
			BEGIN
            	 INSERT INTO FA_AJUSTECONC
                        (PREF_PLAZA, NUM_FOLIO, COD_CONCEPTO, COLUMNA,
                        COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO,
						COD_MONEDA, IMP_FACTURABLE, COD_REGION,
						COD_PROVINCIA, COD_CIUDAD, COD_MODULO,
						NUM_UNIDADES, NUM_SERIEMEC,	COD_TIPCONCE,
						FEC_VALOR, IMP_MONTOBASE, IND_FACTUR,
						IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR,
                        DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS,
						ORD_CUOTA, NUM_SERIELE, MES_GARANTIA,
						NUM_GUIA, IND_ALTA, NUM_PAQUETE,
						NUM_VENTA, NUM_TRANSACCION, FLAG_IMPUES,
						FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM)
                 	SELECT vp_pref_plaza, vp_num_folio, a.COD_CONCEPTO, a.COLUMNA,
                           a.COD_PRODUCTO,	a.FEC_EFECTIVIDAD, decode(a.COD_TIPCONCE,2,a.imp_concepto,0),-- Importe en Cero Dado que esta ingresando un Nuevo Valor, esto cambiara despues de Validar.
						   moneda, a.IMP_FACTURABLE, a.COD_REGION,                   --pero el descuento si se carga queda por el total...el que no se borra
						   a.COD_PROVINCIA, a.COD_CIUDAD, b.COD_MODULO,
						   a.NUM_UNIDADES,	a.NUM_SERIEMEC,	a.COD_TIPCONCE,
						   a.FEC_VALOR, a.IMP_MONTOBASE, a.IND_FACTUR,
						   c.ind_supertel,	a.NUM_ABONADO, a.COD_PORTADOR,
                           a.DES_CONCEPTO,	a.SEQ_CUOTAS, a.NUM_CUOTAS,
						   a.ORD_CUOTA, a.NUM_SERIELE, a.MES_GARANTIA,
						   a.NUM_GUIA,	a.IND_ALTA,	a.NUM_PAQUETE,
						   c.NUM_VENTA, c.NUM_TRANSACCION,	a.FLAG_IMPUES,
						   a.FLAG_DTO,	c.COD_CLIENTE, C.COD_TIPDOCUM
                 	FROM FA_CONCEPTOS              b,
                    	 FA_FACTDOCU_NOCICLO       c,
                         FA_FACTCONC_NOCICLO       a
                 	WHERE a.IND_ORDENTOTAL =  vp_ordentotal
                 	AND a.COD_CONCEPTO     =  b.COD_CONCEPTO
                 	AND a.IND_ORDENTOTAL   =  c.IND_ORDENTOTAL
                 	AND a.COD_TIPCONCE     <> 1;
                 	--AND a.COD_TIPCONCE     <> 2; PGG, RAO, LOD , FAR, JPO 12/08/2005
			EXCEPTION
				 WHEN DUP_VAL_ON_INDEX THEN
				 	  vp_error := 3;
                   	  gls_error := 'Error. No se pudo insertar en tabla FA_AJUSTECONC por PK duplicadas. Msj16';
                   	  RAISE ERROR_PROCESO;
				 WHEN OTHERS THEN
                      vp_error := 3;
                      gls_error := 'Error. No se pudo insertar en la tabla FA_AJUSTECONC. Msj17';
                      RAISE ERROR_PROCESO;
			END;

			--Actualiza el valor si tiene un descuento asociado, dejando el valor Real
			sTabla :='UPDATE CONCEPTOS NOCICLO';

		--Inicio PGG, RAO, LOD , FAR, JPO 12/08/2005
				DECLARE CURSOR C1 IS SELECT COD_CONCEPTO,COLUMNA
		             FROM FA_AJUSTECONC A
		             WHERE A.NUM_FOLIO = vp_num_folio
				 AND   A.PREF_PLAZA = vp_pref_plaza
				 AND   A.COD_TIPCONCE   <> 2
                 AND   A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL
                                          FROM  FA_FACTCONC_NOCICLO B,FA_NCPARCIAL  C
                                          WHERE B.IND_ORDENTOTAL = vp_ordentotal
                                          AND   B.COD_TIPCONCE   = 2
                                          AND   A.COD_CONCEPTO   = B.COD_CONCEREL
                                          AND   A.COLUMNA        = B.COLUMNA_REL
                                          AND c.num_secuencia  = TO_NUMBER(vp_secuencia)
			          	  AND a.cod_concepto   = c.cod_concepto
			          	  AND a.columna        = c.columna
			          	  AND c.IMP_CONCEPTO <(A.IMP_FACTURABLE + B.IMP_FACTURABLE));
			BEGIN

			/*se incrementa el importe del concepto de cargo en una cantidad equivalente al descuento*/
			/*cuando la ncr supera el monto de importe facturado real(cargo+descuento)del concepto de cargo */
                 UPDATE FA_AJUSTECONC A
                 SET IMP_CONCEPTO = (SELECT -1* B.IMP_FACTURABLE
                 	 				  FROM   FA_FACTCONC_NOCICLO B
                                      WHERE  B.IND_ORDENTOTAL = vp_ordentotal
                                      AND    B.COD_TIPCONCE   = 2
                                      AND    A.COD_CONCEPTO   = B.COD_CONCEREL
                                      AND    A.COLUMNA        = B.COLUMNA_REL)
            	 WHERE A.NUM_FOLIO = vp_num_folio
				 AND   A.PREF_PLAZA = vp_pref_plaza
				 AND   A.COD_TIPCONCE   <> 2
                 AND   (A.COD_CONCEPTO,A.COLUMNA) IN (SELECT B.COD_CONCEREL,B.COLUMNA_REL
                                          FROM  FA_FACTCONC_NOCICLO B,FA_NCPARCIAL  C
                                          WHERE B.IND_ORDENTOTAL = vp_ordentotal
                                          AND   B.COD_TIPCONCE   = 2
                                          AND   A.COD_CONCEPTO   = B.COD_CONCEREL
                                          AND   A.COLUMNA        = B.COLUMNA_REL
                                          AND c.num_secuencia  = TO_NUMBER(vp_secuencia)
			          	  AND a.cod_concepto   = c.cod_concepto
			          	  AND a.columna        = c.columna
			          	  AND c.IMP_CONCEPTO >=(A.IMP_FACTURABLE + B.IMP_FACTURABLE));



/*     se incluye el monto del descuento en el cargo cuando la ncr es menor que el importe real del cargo*/
                 UPDATE FA_AJUSTECONC A
                 SET IMP_FACTURABLE = (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE
                 	 				  FROM   FA_FACTCONC_NOCICLO B
                                      WHERE  B.IND_ORDENTOTAL = vp_ordentotal
                                      AND    B.COD_TIPCONCE   = 2
                                      AND    A.COD_CONCEPTO   = B.COD_CONCEREL
                                      AND    A.COLUMNA        = B.COLUMNA_REL)
            	 WHERE A.NUM_FOLIO = vp_num_folio
				 AND   A.PREF_PLAZA = vp_pref_plaza
				 AND   A.COD_TIPCONCE   <> 2
                 AND   (A.COD_CONCEPTO,A.COLUMNA)  IN (SELECT B.COD_CONCEREL,B.COLUMNA_REL
                                          FROM  FA_FACTCONC_NOCICLO B,FA_NCPARCIAL  C
                                          WHERE B.IND_ORDENTOTAL = vp_ordentotal
                                          AND   B.COD_TIPCONCE   = 2
                                          AND   A.COD_CONCEPTO   = B.COD_CONCEREL
                                          AND   A.COLUMNA        = B.COLUMNA_REL
                                          AND c.num_secuencia  = TO_NUMBER(vp_secuencia)
			          	  AND a.cod_concepto   = c.cod_concepto
			          	  AND a.columna        = c.columna
			          	  AND c.IMP_CONCEPTO <(A.IMP_FACTURABLE + B.IMP_FACTURABLE));

/*     se elimina descuento cuando la ncr es menor que el importe real del cargo y el monto del mismo ya lo incluye*/
               FOR REG IN C1 LOOP
		         DELETE 	FA_AJUSTECONC A
            	 WHERE A.NUM_FOLIO = vp_num_folio
				 AND   A.PREF_PLAZA = vp_pref_plaza
				 AND   A.COD_TIPCONCE   = 2
                 AND   (A.COD_CONCEPTO,A.COLUMNA) IN (
                                          SELECT B.COD_CONCEPTO,B.COLUMNA
                                          FROM  FA_FACTCONC_NOCICLO B,FA_NCPARCIAL  C
                                          WHERE B.IND_ORDENTOTAL = vp_ordentotal
                                          AND   B.COD_TIPCONCE   = 2
                                          AND   B.COD_CONCEREL   = Reg.COD_CONCEPTO
                                          AND   B.COLUMNA_REL    = REG.COLUMNA
                                          AND   C.COD_CONCEPTO   = B.COD_CONCEREL
                                          AND   C.COLUMNA        = B.COLUMNA_REL
                                          AND   c.num_secuencia  = TO_NUMBER(vp_secuencia));
		       END LOOP;

			EXCEPTION
				 WHEN OTHERS THEN
                      vp_error := 4;
                      gls_error := 'Error. No se pudo actualizar en la tabla FA_AJUSTECONC el importe facturable. Msj18';
                      RAISE ERROR_PROCESO;
			END;
		--Fin PGG, RAO, LOD , FAR, JPO 12/08/2005
        ELSE
		    --- Esto es lo mismo que lo anterior pero dinamico considerando el ciclo de busqueda
            sTabla :='CONCEPTOS HIST';
            ins_ajuste := 'INSERT INTO FA_AJUSTECONC ';
            ins_ajuste := ins_ajuste || '(PREF_PLAZA, NUM_FOLIO, COD_CONCEPTO, COLUMNA, ';
            ins_ajuste := ins_ajuste || 'COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA, ';
            ins_ajuste := ins_ajuste || 'IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD, ';
            ins_ajuste := ins_ajuste || 'COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR, ';
            ins_ajuste := ins_ajuste || 'IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR, ';
            ins_ajuste := ins_ajuste || 'DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE, ';
            ins_ajuste := ins_ajuste || 'MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION, ';
            ins_ajuste := ins_ajuste || 'FLAG_IMPUES, FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM) ';
            ins_ajuste := ins_ajuste || 'SELECT c.pref_plaza, c.num_folio, a.COD_CONCEPTO, ';
	    ins_ajuste := ins_ajuste || 'a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD,';
	    ins_ajuste := ins_ajuste || 'decode(a.COD_TIPCONCE,2,a.imp_concepto,0), :moneda,';
            ins_ajuste := ins_ajuste || 'a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA, a.COD_CIUDAD, ';
            ins_ajuste := ins_ajuste || 'b.COD_MODULO, a.NUM_UNIDADES, a.NUM_SERIEMEC, a.COD_TIPCONCE, a.FEC_VALOR, ';
            ins_ajuste := ins_ajuste || 'a.IMP_MONTOBASE, a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR, ';
            ins_ajuste := ins_ajuste || 'a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, a.NUM_SERIELE, ';
            ins_ajuste := ins_ajuste || 'a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, ';
            ins_ajuste := ins_ajuste || 'a.FLAG_IMPUES, a.FLAG_DTO, c.COD_CLIENTE, c.COD_TIPDOCUM  ';
            ins_ajuste := ins_ajuste || 'FROM  FA_CONCEPTOS b,FA_HISTDOCU c,' || RTRIM(vp_tabla) || ' a  ';
            ins_ajuste := ins_ajuste || 'WHERE a.IND_ORDENTOTAL = :ordentotal      AND ';
            ins_ajuste := ins_ajuste || '      a.COD_CONCEPTO   =  b.COD_CONCEPTO     AND ';
            ins_ajuste := ins_ajuste || '      a.IND_ORDENTOTAL =  c.IND_ORDENTOTAL   AND ';
            ins_ajuste := ins_ajuste || '      a.COD_TIPCONCE   <> 1                   ';
            --ins_ajuste := ins_ajuste || '      a.COD_TIPCONCE   <> 2                      ';--PGG, RAO, LOD , FAR, JPO 12/08/2005

			BEGIN
		 		 EXECUTE IMMEDIATE ins_ajuste USING moneda, vp_ordentotal;
			EXCEPTION
				 WHEN DUP_VAL_ON_INDEX THEN
				 	  vp_error := 3;
                   	  gls_error := 'Error. No se pudo insertar en tabla FA_AJUSTECONC por PK duplicadas. Msj19';
                   	  RAISE ERROR_PROCESO;
				 WHEN OTHERS THEN
                      vp_error := 3;
                      gls_error := 'Error. No se pudo insertar en la tabla FA_AJUSTECONC. Msj20';
                      RAISE ERROR_PROCESO;
			END;

--			--Actualiza el valor si tiene un descuento asociado, dejando el valor Real Historico
   		    sTabla :='UPDATE CONCEPTOS HISTORICOS';

			/*se incrementa el importe del concepto de cargo en una cantidad equivalente al descuento*/
			/*cuando la ncr supera el monto de importe facturado real(cargo+descuento)del concepto de cargo */
         ins_ajuste :='UPDATE FA_AJUSTECONC A';
         ins_ajuste := ins_ajuste || ' SET IMP_CONCEPTO = (SELECT -1* B.IMP_FACTURABLE';
         ins_ajuste := ins_ajuste || '	 				  FROM   ' || RTRIM(vp_tabla) || ' B';
         ins_ajuste := ins_ajuste || '                     WHERE  B.IND_ORDENTOTAL = :vp_ordentotal';
         ins_ajuste := ins_ajuste || '                     AND    B.COD_TIPCONCE   = 2';
         ins_ajuste := ins_ajuste || '                     AND    A.COD_CONCEPTO   = B.COD_CONCEREL';
         ins_ajuste := ins_ajuste || '                     AND    A.COLUMNA        = B.COLUMNA_REL)';
         ins_ajuste := ins_ajuste || ' WHERE A.NUM_FOLIO = :vp_num_folio';
	 ins_ajuste := ins_ajuste || '		 AND   A.PREF_PLAZA = :vp_pref_plaza';
	 ins_ajuste := ins_ajuste || '		 AND   A.COD_TIPCONCE   <> 2';
         ins_ajuste := ins_ajuste || ' AND   (A.COD_CONCEPTO,A.COLUMNA) IN (SELECT B.COD_CONCEREL,B.COLUMNA_REL';
         ins_ajuste := ins_ajuste || '                         FROM  ' || RTRIM(vp_tabla) || ' B,FA_NCPARCIAL  C';
         ins_ajuste := ins_ajuste || '                         WHERE B.IND_ORDENTOTAL = :vp_ordentotal';
         ins_ajuste := ins_ajuste || '                         AND   B.COD_TIPCONCE   = 2';
         ins_ajuste := ins_ajuste || '                         AND   A.COD_CONCEPTO   = B.COD_CONCEREL';
         ins_ajuste := ins_ajuste || '                         AND   A.COLUMNA        = B.COLUMNA_REL';
         ins_ajuste := ins_ajuste || '                         AND c.num_secuencia  = TO_NUMBER(:vp_secuencia)';
	 ins_ajuste := ins_ajuste || '	          	  AND a.cod_concepto   = c.cod_concepto';
	 ins_ajuste := ins_ajuste || '	          	  AND a.columna        = c.columna';
	 ins_ajuste := ins_ajuste || '	          	  AND c.IMP_CONCEPTO >=(A.IMP_FACTURABLE + B.IMP_FACTURABLE))';

         BEGIN
		 EXECUTE IMMEDIATE ins_ajuste USING vp_ordentotal,vp_num_folio, vp_pref_plaza,vp_ordentotal,vp_secuencia;
	EXCEPTION
		 WHEN OTHERS THEN
                      vp_error := 4;
                      gls_error := 'Error. No se pudo actualizar en la tabla FA_AJUSTECONC el importe facturable. Msj21';
                      RAISE ERROR_PROCESO;
	END;

/*     se incluye el monto del descuento en el cargo cuando la ncr es menor que el importe real del cargo*/
          ins_ajuste := ' UPDATE FA_AJUSTECONC A';
          ins_ajuste := ins_ajuste || ' SET IMP_FACTURABLE = (SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE';
          ins_ajuste := ins_ajuste || ' 	 	     FROM ' || RTRIM(vp_tabla) || ' B';
          ins_ajuste := ins_ajuste || '                      WHERE  B.IND_ORDENTOTAL = :vp_ordentotal';
          ins_ajuste := ins_ajuste || '                      AND    B.COD_TIPCONCE   = 2';
          ins_ajuste := ins_ajuste || '                      AND    A.COD_CONCEPTO   = B.COD_CONCEREL';
          ins_ajuste := ins_ajuste || '                      AND    A.COLUMNA        = B.COLUMNA_REL)';
          ins_ajuste := ins_ajuste || ' WHERE A.NUM_FOLIO = :vp_num_folio';
	  ins_ajuste := ins_ajuste || '		 AND   A.PREF_PLAZA = :vp_pref_plaza';
	  ins_ajuste := ins_ajuste || '		 AND   A.COD_TIPCONCE   <> 2';
          ins_ajuste := ins_ajuste || ' AND   (A.COD_CONCEPTO,A.COLUMNA)  IN (SELECT B.COD_CONCEREL,B.COLUMNA_REL';
          ins_ajuste := ins_ajuste || '                          FROM ' || RTRIM(vp_tabla) || ' B,FA_NCPARCIAL  C';
          ins_ajuste := ins_ajuste || '                          WHERE B.IND_ORDENTOTAL = :vp_ordentotal';
          ins_ajuste := ins_ajuste || '                          AND   B.COD_TIPCONCE   = 2';
          ins_ajuste := ins_ajuste || '                          AND   A.COD_CONCEPTO   = B.COD_CONCEREL';
          ins_ajuste := ins_ajuste || '                          AND   A.COLUMNA        = B.COLUMNA_REL';
          ins_ajuste := ins_ajuste || '                          AND c.num_secuencia  = TO_NUMBER(:vp_secuencia)';
	  ins_ajuste := ins_ajuste || '	          	  AND a.cod_concepto   = c.cod_concepto';
	  ins_ajuste := ins_ajuste || '	          	  AND a.columna        = c.columna';
	  ins_ajuste := ins_ajuste || '	          	  AND c.IMP_CONCEPTO <(A.IMP_FACTURABLE + B.IMP_FACTURABLE))';
         BEGIN
		 EXECUTE IMMEDIATE ins_ajuste USING vp_ordentotal,vp_num_folio, vp_pref_plaza,vp_ordentotal,vp_secuencia;
	EXCEPTION
		 WHEN OTHERS THEN
                      vp_error := 4;
                      gls_error := 'Error. No se pudo actualizar en la tabla FA_AJUSTECONC el importe facturable. Msj21.1';
                      RAISE ERROR_PROCESO;
	END;

           Ajuste_sql:= 'SELECT COD_CONCEPTO,COLUMNA';
	   Ajuste_sql:=Ajuste_sql || '	 FROM FA_AJUSTECONC A	';
	   Ajuste_sql:=Ajuste_sql || '	          WHERE A.NUM_FOLIO = :vp_num_folio';
	   Ajuste_sql:=Ajuste_sql || '	 AND   A.PREF_PLAZA = :vp_pref_plaza';
	   Ajuste_sql:=Ajuste_sql || '	 AND   A.COD_TIPCONCE   <> 2';
           Ajuste_sql:=Ajuste_sql || '   AND   A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL';
           Ajuste_sql:=Ajuste_sql || '               FROM  ' || RTRIM(vp_tabla) || ' B,FA_NCPARCIAL  C';
           Ajuste_sql:=Ajuste_sql || '               WHERE B.IND_ORDENTOTAL = :vp_ordentotal';
           Ajuste_sql:=Ajuste_sql || '                 AND   B.COD_TIPCONCE   = 2';
           Ajuste_sql:=Ajuste_sql || '                 AND   A.COD_CONCEPTO   = B.COD_CONCEREL';
           Ajuste_sql:=Ajuste_sql || '                 AND   A.COLUMNA        = B.COLUMNA_REL';
           Ajuste_sql:=Ajuste_sql || '                 AND c.num_secuencia  = TO_NUMBER(:vp_secuencia)';
	   Ajuste_sql:=Ajuste_sql || '   AND a.cod_concepto   = c.cod_concepto';
	   Ajuste_sql:=Ajuste_sql || '   AND a.columna        = c.columna';
	   Ajuste_sql:=Ajuste_sql || '   AND c.IMP_CONCEPTO <(A.IMP_FACTURABLE + B.IMP_FACTURABLE))';
	OPEN Ajuste_cv FOR Ajuste_sql -- open cursor variable
	USING vp_num_folio,vp_pref_plaza,vp_ordentotal, vp_secuencia;

	LOOP
   		FETCH Ajuste_cv INTO vCodConcepto, vColumna;
   		EXIT WHEN Ajuste_cv%NOTFOUND;
   		BEGIN
      /*se elimina descuento cuando la ncr es menor que el importe real del cargo y el monto del mismo ya lo incluye*/
		    ins_ajuste := 'DELETE 	FA_AJUSTECONC A';
            	    ins_ajuste := ins_ajuste ||' WHERE A.NUM_FOLIO = :vp_num_folio';
		    ins_ajuste := ins_ajuste ||'		 AND   A.PREF_PLAZA = :vp_pref_plaza';
		    ins_ajuste := ins_ajuste ||'		 AND   A.COD_TIPCONCE   = 2';
                    ins_ajuste := ins_ajuste ||' AND   (A.COD_CONCEPTO,A.COLUMNA) IN (';
                    ins_ajuste := ins_ajuste ||'                       SELECT B.COD_CONCEPTO,B.COLUMNA';
                    ins_ajuste := ins_ajuste ||'                      FROM ' || RTRIM(vp_tabla) || ' B,FA_NCPARCIAL  C';
                    ins_ajuste := ins_ajuste ||'                       WHERE B.IND_ORDENTOTAL = :vp_ordentotal';
                    ins_ajuste := ins_ajuste ||'                       AND   B.COD_TIPCONCE   = 2';
                    ins_ajuste := ins_ajuste ||'                       AND   B.COD_CONCEREL   = :vCODCONCEPTO';
                    ins_ajuste := ins_ajuste ||'                       AND   B.COLUMNA_REL    = :vCOLUMNA';
                    ins_ajuste := ins_ajuste ||'                      AND   C.COD_CONCEPTO   = B.COD_CONCEREL';
                    ins_ajuste := ins_ajuste ||'                      AND   C.COLUMNA        = B.COLUMNA_REL';
                    ins_ajuste := ins_ajuste ||'                      AND   c.num_secuencia  = TO_NUMBER(:vp_secuencia))';
		 EXECUTE IMMEDIATE ins_ajuste USING vp_num_folio, vp_pref_plaza,vp_ordentotal,vCODCONCEPTO,vCOLUMNA,vp_secuencia;
		 EXCEPTION
		   WHEN OTHERS THEN
                      vp_error := 4;
                      gls_error := 'Error. No se pudo eliminar descuentos en la tabla FA_AJUSTECONC . Msj21.2';
                      RAISE ERROR_PROCESO;
		END;
	END LOOP;
	CLOSE Ajuste_cv;
		--Fin PGG, RAO, LOD , FAR, JPO 12/08/2005
        END IF;
    END IF;

	--Valida si el Monto solicitado (NC) para realizar la Nota de Crédito es superior al Monto permitido (Documento Original).
    BEGIN
      IF vp_tipo_tabla = 'N' THEN
    	  SELECT COUNT(1) INTO vp_total
              FROM  FA_AJUSTECONC a,
              FA_AJUSTES    b,
              FA_NCPARCIAL  c
          WHERE a.NUM_FOLIO    = TO_NUMBER(vp_num_folio)
		  AND a.PREF_PLAZA	   = vp_pref_plaza
          	  AND a.COD_CLIENTE    = TO_NUMBER(vp_cod_cliente)
          	  AND a.COD_TIPDOCUM   = TO_NUMBER(vp_cod_tipdocum)
          	  AND c.num_secuencia  = TO_NUMBER(vp_secuencia)
          	  AND a.cod_concepto   = c.cod_concepto
          	  AND a.columna        = c.columna
          	  AND a.NUM_FOLIO      = b.NUM_FOLIO
		  AND a.PREF_PLAZA	= b.PREF_PLAZA
          	  AND a.COD_CLIENTE    = b.COD_CLIENTE
          	  AND a.COD_TIPDOCUM   = b.COD_TIPDOCUM
          	  AND a.COD_TIPCONCE   <> 2
          	  AND c.IMP_CONCEPTO>(a.IMP_FACTURABLE - a.IMP_CONCEPTO);

      ELSE
    	Ajuste_sql:=' SELECT COUNT(1)';
        Ajuste_sql:=Ajuste_sql || ' 	 FROM  FA_AJUSTECONC a,';
        Ajuste_sql:=Ajuste_sql || '      FA_AJUSTES    b,';
        Ajuste_sql:=Ajuste_sql || '      FA_NCPARCIAL  c';
        Ajuste_sql:=Ajuste_sql || '  	  WHERE a.NUM_FOLIO    = TO_NUMBER(:vp_num_folio)';
	Ajuste_sql:=Ajuste_sql || '	  AND a.PREF_PLAZA	   = :vp_pref_plaza';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.COD_CLIENTE    = TO_NUMBER(:vp_cod_cliente)';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.COD_TIPDOCUM   = TO_NUMBER(:vp_cod_tipdocum)';
        Ajuste_sql:=Ajuste_sql || '  	  AND c.num_secuencia  = TO_NUMBER(:vp_secuencia)';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.cod_concepto   = c.cod_concepto';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.columna        = c.columna';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.NUM_FOLIO      = b.NUM_FOLIO';
	Ajuste_sql:=Ajuste_sql || '	  AND a.PREF_PLAZA	= b.PREF_PLAZA';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.COD_CLIENTE    = b.COD_CLIENTE';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.COD_TIPDOCUM   = b.COD_TIPDOCUM';
        Ajuste_sql:=Ajuste_sql || '  	  AND a.COD_TIPCONCE   <> 2';
        Ajuste_sql:=Ajuste_sql || '  	  AND c.IMP_CONCEPTO>(a.IMP_FACTURABLE - a.IMP_CONCEPTO)';
	 EXECUTE IMMEDIATE ins_ajuste INTO vp_total USING vp_num_folio, vp_pref_plaza,vp_cod_cliente,vp_cod_tipdocum,vp_secuencia;
      END IF;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
             	  vp_error := 2;
                  gls_error := 'Error. No se pudo recuperar el importe total de la factura original. Msj22';
                  RAISE ERROR_PROCESO;
		 WHEN OTHERS THEN
                      vp_error := 4;
                      gls_error := 'Error. No se pudo recuperar el importe total de la factura original. Msj22.1';
                      RAISE ERROR_PROCESO;
	END;

    IF vp_total > 0 THEN
            vp_error := 5;
            gls_error := 'Error. Existen conceptos cuyo monto N.C. excede al permitido: ( ' || vp_total || ' ). Msj23';
            RAISE ERROR_PROCESO;
    END IF;

    sTabla :='FA_TIPDOCUMEN';
	BEGIN
    	 SELECT IND_RESTNC
    	 INTO vp_ind_restnc
    	 FROM FA_TIPDOCUMEN
    	 WHERE COD_TIPDOCUMMOV = vp_cod_tipdocum;
	EXCEPTION
			 WHEN NO_DATA_FOUND THEN
             	  vp_error := 2;
                  gls_error := 'Error. No se pudo recuperar el indicador de restricción de NC de la tabla FA_TIPDOCUMEN. Msj24';
                  RAISE ERROR_PROCESO;
	END;

    IF vp_ind_restnc = 1 OR vp_ind_restnc = 3 THEN --por el total - restriccion total
       vp_error := 5;
       gls_error := 'Error. El documento tiene restricción para realizar NC. Msj25';
       RAISE ERROR_PROCESO;
    END IF;
------- sSecuenciaEmi
    SELECT FA_SEQ_CREDITO.NEXTVAL
    INTO snumseq
    FROM DUAL;

    snumseq := snumseq + 1;
    sFormatoFecha :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');

    usuario:=USER;
    fecha:=RTRIM(TO_CHAR(SYSDATE, sFormatoFecha));

    sTabla :='GA_SEG_USUARIO';
    SELECT NVL(COD_VENDEDOR, -1), NVL(COD_OFICINA, ' ') INTO vendedor, oficina FROM GE_SEG_USUARIO WHERE NOM_USUARIO = usuario;
	IF vendedor = -1 OR oficina = ' ' THEN
        sTabla :='GE_DATOSGENER';
        SELECT COD_AGENTESTARTEL, COD_OFICCENTRAL INTO vendedor, oficina FROM GE_DATOSGENER;
        IF vendedor < 0 OR oficina = ' ' THEN
                vp_error := 5;
                gls_error := 'Error. No existe vendedor. Msj26';
                RAISE ERROR_PROCESO;
        END IF;
    END IF;

    sTabla :='AL_DOCUM_SUCURSAL';
    SELECT COD_CENTREMI INTO centremi
    FROM   AL_DOCUM_SUCURSAL
    WHERE  COD_TIPDOCUM = 25
    AND    COD_OFICINA = oficina;
------- bGetLetraAG
    sTabla :='GE_LETRAS';
    SELECT LETRA INTO vp_letra
    FROM   GE_LETRAS
    WHERE  COD_CATIMPOS = vp_cod_catimpos
    AND    COD_TIPDOCUM = 25;

    IF vp_letra = ' ' THEN
            vp_error := 7;
            gls_error := 'Error. Categoría impositiva no tiene asociada Letra (GE_LETRAS). Msj27';
            RAISE ERROR_PROCESO;
    END IF;
--- bInsertProceso
    sTabla :='FA_PROCESOS';
	BEGIN
    	 INSERT INTO FA_PROCESOS
         		(NUM_PROCESO		 		   ,
			   	COD_TIPDOCUM	  		   ,
				COD_VENDEDOR_AGENTE		   ,
                COD_CENTREMI			   ,
				FEC_EFECTIVIDAD			   ,
				NOM_USUARORA			   ,
                LETRAAG					   ,
				NUM_SECUAG				   ,
				COD_TIPDOCNOT			   ,
				COD_VENDEDOR_AGENTENOT	   ,
                LETRANOT				   ,
				COD_CENTRNOT			   ,
				NUM_SECUNOT				   ,
				IND_ESTADO				   ,
				COD_CICLFACT			   ,
				IND_NOTACREDC			   )
         VALUES (vp_num_proceso			   ,
			    25						   ,
				vendedor				   ,
                centremi				   ,
				SYSDATE					   ,
				usuario					   ,
                vp_letra				   ,
				snumseq					   ,
				vp_cod_tipdocum			   ,
				cod_vendedor_agente		   ,
                sletra					   ,
				scentremi				   ,
				ssecuenci				   ,
				NULL					   ,
				NULL					   ,
				0						   );

    EXCEPTION
			 WHEN DUP_VAL_ON_INDEX THEN
			 	  vp_error := 3;
                  gls_error := 'Error. No se pudo insertar en tabla FA_PROCESOS por PK duplicadas. Msj28';
                  RAISE ERROR_PROCESO;
			 WHEN OTHERS THEN
             	  vp_error := 3;
                  gls_error := 'Error. No se pudo insertar en la tabla FA_PROCESOS. Msj29';
                  RAISE ERROR_PROCESO;
	END;
    sTabla :='UPDATE FA_AJUSTECONC 001';
---- bUpdConc_tot
	BEGIN
    	 UPDATE FA_AJUSTECONC A
    	 SET IMP_CONCEPTO = (SELECT A.IMP_CONCEPTO + B.IMP_CONCEPTO
         	 			  FROM FA_NCPARCIAL B
                          WHERE B.NUM_SECUENCIA = vp_secuencia
                          AND   A.COD_CONCEPTO  = B.COD_CONCEPTO
                          AND   A.COLUMNA       = B.COLUMNA)
     	 WHERE A.NUM_FOLIO    = TO_NUMBER(vp_num_Folio)
	 AND   PREF_PLAZA     = vp_pref_plaza
     	 AND   A.COD_CLIENTE  = TO_NUMBER(vp_cod_cliente)
     	 AND   A.COD_TIPDOCUM = vp_cod_tipdocum
     	 AND   A.COD_CONCEPTO IN (SELECT B.COD_CONCEPTO
         	   			FROM FA_NCPARCIAL B
                              	 WHERE B.NUM_SECUENCIA = vp_secuencia
                              	 AND A.COD_CONCEPTO    = B.COD_CONCEPTO
                              	 AND A.COLUMNA         = B.COLUMNA);
	EXCEPTION
			 WHEN OTHERS THEN
             	  vp_error := 4;
                  gls_error := 'Error. No se pudo actualizar la tabla FA_AJUSTECONC el importe concepto. Msj30';
                  RAISE ERROR_PROCESO;
	END;
------- bInsertPrefactura
    sTabla :='FA_PREFACTURA 001';
	BEGIN
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
				COD_PLANCOM,
                IND_FACTUR,
				COD_CATIMPOS,
				COD_PORTADOR,
				IND_ESTADO,
				COD_TIPCONCE,
				NUM_UNIDADES,
                COD_CICLFACT,
				COD_CONCEREL,
				COLUMNA_REL,
				NUM_ABONADO,
				NUM_TERMINAL,
				CAP_CODE	 	 ,
                NUM_SERIEMEC   	,
				NUM_SERIELE	   	,
				FLAG_IMPUES	   	,
				FLAG_DTO	   	,
				NUM_VENTA	   	,
				NUM_TRANSACCION	,
                MES_GARANTIA	,
				NUM_GUIA	 	,
				IND_ALTA 	 	,
				IND_SUPERTEL 	,
				NUM_PAQUETE	 	,
				IND_CUOTA	 	,
                NUM_CUOTAS	 	,
				ORD_CUOTA  	 	,
				COD_TIPDOCUM)
         SELECT vp_num_proceso,
		 		a.COD_CLIENTE,
				a.COD_CONCEPTO,
				a.COLUMNA,
				a.COD_PRODUCTO,
                moneda,
				a.FEC_VALOR,
				a.FEC_EFECTIVIDAD,
				c.IMP_CONCEPTO,
				c.IMP_CONCEPTO,-- Parcial
                0, a.COD_REGION,
				a.COD_PROVINCIA,
				a.COD_CIUDAD,
				a.COD_MODULO,
				b.COD_PLANCOM,
                a.IND_FACTUR,
				b.COD_CATIMPOS,
				a.COD_PORTADOR,
				0,
				a.COD_TIPCONCE,
				1,
                NULL,
				NULL,
				NULL,
				a.NUM_ABONADO,
				NULL,
				NULL,
                a.NUM_SERIEMEC,
				a.NUM_SERIELE,
				a.FLAG_IMPUES,
				a.FLAG_DTO,
				a.NUM_VENTA,
				a.NUM_TRANSACCION,
                a.MES_GARANTIA,
				a.NUM_GUIA,
				a.IND_ALTA,
				a.IND_SUPERTEL,
				a.NUM_PAQUETE,
				a.SEQ_CUOTAS,
                a.NUM_CUOTAS,
				a.ORD_CUOTA,
				B.COD_TIPDOCUM
           FROM FA_AJUSTECONC a,
                FA_AJUSTES    b,
                FA_NCPARCIAL  c
          WHERE a.NUM_FOLIO    = TO_NUMBER(vp_num_folio)
		  	AND a.PREF_PLAZA   = vp_pref_plaza
            AND a.COD_CLIENTE  = TO_NUMBER(vp_cod_cliente)
            AND a.COD_TIPDOCUM = TO_NUMBER(vp_cod_tipdocum)
            AND c.num_secuencia= TO_NUMBER(vp_secuencia)
            AND a.cod_concepto = c.cod_concepto
            AND a.columna      = c.columna
            AND a.NUM_FOLIO    = b.NUM_FOLIO
			AND a.PREF_PLAZA   = b.PREF_PLAZA
            AND a.COD_CLIENTE  = b.COD_CLIENTE
            AND a.COD_TIPDOCUM = b.COD_TIPDOCUM;
	EXCEPTION
			 WHEN DUP_VAL_ON_INDEX THEN
			 	  vp_error := 3;
                  gls_error := 'Error. No se pudo insertar en tabla FA_PREFACTURA por PK duplicadas. Msj31';
                  RAISE ERROR_PROCESO;
			 WHEN OTHERS THEN
             	  vp_error := 3;
                  gls_error := 'Error. No se pudo insertar en la tabla FA_PREFACTURA. Msj32';
                  RAISE ERROR_PROCESO;
	END;
------- bControlPeriodo
    vp_imp_maximo := 0;
    vp_num_dias   := 0;
    sTabla :='FA_CONTROLNC';
	BEGIN
    	 SELECT IMP_MAXIMO,
	     		NUM_DIAS
    	 INTO   vp_imp_maximo,
	     		vp_num_dias
    	 FROM   FA_CONTROLNC
         WHERE  NOM_USUARIO = usuario
         AND    FEC_DESDE  <= SYSDATE
         AND    FEC_HASTA  >= SYSDATE;
	EXCEPTION
		 	 WHEN NO_DATA_FOUND THEN
			 	  vp_error := 2;
                  gls_error := 'Error. No se pudo recuperar importe máximo por usuario. Msj33';
                  RAISE ERROR_PROCESO;
	END;

    SELECT COUNT(1)
	INTO   CANTIDAD
    FROM   fa_aplicadonc
    WHERE  NOM_USUARIO = usuario
    AND    COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
    AND    FEC_INICIO <= SYSDATE
    AND    FEC_FIN    >= SYSDATE;
    IF CANTIDAD <= 0 THEN
--------------- bInsertAplicadoNC
        sTabla :='FA_APLICADONC';
		BEGIN
        	 INSERT INTO FA_APLICADONC
             		(NOM_USUARIO,
				    COD_CLIENTE,
					FEC_INICIO,
					FEC_FIN,
				    TOT_APLICADO)
        	 VALUES (	usuario,
			   		TO_NUMBER(vp_cod_cliente),
                    TO_DATE(TO_CHAR(TRUNC(SYSDATE, 'MONTH'), 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                    TO_DATE(TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,1),'MONTH')-1/86400, 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'),
                    vp_totparcial);
		EXCEPTION
				 WHEN DUP_VAL_ON_INDEX THEN
			 	 	  vp_error := 3;
                  	  gls_error := 'Error. No se pudo insertar en tabla FA_APLICADONC por PK duplicadas. Msj34';
                  	  RAISE ERROR_PROCESO;
			 	 WHEN OTHERS THEN
             	 	  vp_error := 3;
                  	  gls_error := 'Error. No se pudo insertar en la tabla FA_APLICADONC. Msj35';
                  	  RAISE ERROR_PROCESO;
		END;

    ELSE
		BEGIN
        	 SELECT ROWID			 ,
		       		TOT_APLICADO		 ,
			   		TO_CHAR(FEC_INICIO, 'DD/MM/YYYY'), TO_CHAR(FEC_FIN, 'DD/MM/YYYY')
        	 INTO   srowid			 ,
			 		sTotAplicado		 ,
			   		sFecInicio	   	 ,
			   		sFecFin
        	 FROM   FA_APLICADONC
             WHERE  NOM_USUARIO = usuario
             AND    COD_CLIENTE = TO_NUMBER(vp_cod_cliente)
             AND    FEC_INICIO <= SYSDATE
             AND    FEC_FIN    >= SYSDATE;
		EXCEPTION
			 	 WHEN NO_DATA_FOUND THEN
			 	  	  vp_error := 2;
                  	  gls_error := 'Error. No se pudo recuperar el total aplicado por el usuario. Msj36';
                  	  RAISE ERROR_PROCESO;
		END;

        stotal1 := vp_totparcial + sTotAplicado;

        IF stotal1 <= vp_imp_maximo THEN

		   sTabla :='UPDATE FA_APLICADONC';
		   BEGIN
           		UPDATE FA_APLICADONC
           		SET TOT_APLICADO = TOT_APLICADO + vp_totparcial
           		WHERE ROWID = sRowid;
		   EXCEPTION
					WHEN OTHERS THEN
			 	  		 vp_error := 4;
                  		 gls_error := 'Error. No se pudo actualizar el total aplicado por el usuario. Msj37';
                  		 RAISE ERROR_PROCESO;
		   END;

        ELSE
        	vp_error := 8;
            gls_error := 'Error. Se ha sobrepasado el Límite Importe para el Usuario. Msj38';
            RAISE ERROR_PROCESO;
        END IF;
    END IF;

    lSeqNue := sNumSeq + 1;
------- bUpdSecuencia

    sTabla :='GE_SECUENCIASEMI';
	BEGIN
    	 UPDATE GE_SECUENCIASEMI
    	 SET    NUM_SECUENCI = lSeqNue
    	 WHERE  COD_TIPDOCUM = 25
    	 AND    COD_CENTREMI = centremi
    	 AND    LETRA        = vp_letra; -- GE_LETRAS
	EXCEPTION
			 WHEN OTHERS THEN
			 	  vp_error := 4;
                  gls_error := 'Error. No se pudo actualizar la secuencia de emisión. Msj39';
                  RAISE ERROR_PROCESO;
	END;

    SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO secuencia_ga FROM DUAL;

	sTabla :='GE_TIPDOCUMEN';
	BEGIN
		 SELECT tip_foliacion
		 INTO vp_tip_foliacion
		 FROM ge_tipdocumen
		 WHERE cod_tipdocum = vp_cod_tipdocum;
	EXCEPTION
			   	 WHEN NO_DATA_FOUND THEN
               	 	  vp_error := 2;
				 	  Gls_error := 'Error.No se pudo recuperar código tipo foliacion de tabla GE_TIPDOCUMEN Msj40';
                 	  RAISE ERROR_PROCESO;
	END;

	sTabla :='FA_GENCENTREMI';
	BEGIN
    	 SELECT COD_MODGENER INTO vp_cod_modgener FROM FA_GENCENTREMI
    	 WHERE COD_CENTREMI  = centremi
    	 AND COD_TIPMOVIMIEN = 25
    	 AND COD_CATRIBUT    = vp_categoria_trib
    	 AND COD_MODVENTA    = vp_cod_modventa
		 AND TIP_FOLIACION	 = vp_tip_foliacion;
	EXCEPTION
			 WHEN NO_DATA_FOUND THEN
			 	  vp_error := 2;
                  gls_error := 'Error. No se pudo recuperar código modo de generación. Msj41';
                  RAISE ERROR_PROCESO;
	END;

    vp_entrada := '0';
	sTabla :='FA_INTERFACT';
    Fa_Ins_Interfact( TO_CHAR(secuencia_ga) , vp_num_proceso
                    , '0'                   , vp_cod_modgener
                    , '25'                  , vp_categoria_trib
                    , TO_CHAR(vp_num_folio) , '100'
                    , '3'                   , fecha
                    , vp_entrada            , '1'
                    , '0'					, vp_pref_plaza,vp_tip_foliacion,'');

    sTabla :='GA_TRANSACABO';
    SELECT COD_RETORNO, DES_CADENA INTO cod_retorno, des_cadena
    FROM ga_transacabo
    WHERE num_transaccion = secuencia_ga;

    IF cod_retorno != 0 THEN
        vp_error := 9;
        RAISE ERROR_PROCESO;
    ELSE
       DELETE FROM ga_transacabo WHERE num_transaccion = secuencia_ga;
    END IF;
	sTabla :='FA_NCPARCIAL';
	BEGIN
    	 UPDATE FA_NCPARCIAL
    	 SET FLG_EMINC = 1, NUM_PROCESO = vp_num_proceso
    	 WHERE NUM_SECUENCIA = vp_secuencia;
	EXCEPTION
			 WHEN OTHERS THEN
	  		 	  vp_error := 4;
                  gls_error := 'Error. No se pudo actualizar flag de emisión de NC en tabla FA_NCPARCIAL. Msj42';
                  RAISE ERROR_PROCESO;
	END;

	RAISE ERROR_PROCESO;
    EXCEPTION
      WHEN ERROR_PROCESO THEN
           IF vp_error = 0 THEN
                INSERT INTO GA_TRANSACABO
                           (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                    VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, TO_CHAR(vp_num_proceso));
            ELSE
                INSERT INTO GA_TRANSACABO
                           (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                    VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error || vp_secuencia_ga);
       END IF;
      WHEN DUP_VAL_ON_INDEX THEN
           INSERT INTO GA_TRANSACABO
                      (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
               VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Duplicado'|| sTabla);
      WHEN NO_DATA_FOUND THEN
           INSERT INTO GA_TRANSACABO
                      (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
               VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Datos No Fueron Encontrados ' || sTabla);
     WHEN OTHERS THEN
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Error desconocido ' || sTabla );

END ;
/
SHOW ERRORS
