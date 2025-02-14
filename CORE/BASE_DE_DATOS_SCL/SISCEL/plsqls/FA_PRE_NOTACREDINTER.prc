CREATE OR REPLACE PROCEDURE FA_PRE_NOTACREDINTER( vp_secuencia_ga IN VARCHAR2,
 vp_ind_ordentotal IN VARCHAR2,
 vp_tipo_tabla IN VARCHAR2,
 vp_cod_cliente IN VARCHAR2,
 vp_num_proceso IN VARCHAR2,
 vp_categoria_trib IN VARCHAR2,
 vp_cod_modventa IN VARCHAR2)
IS
oficina VARCHAR2(2);
secuencia_ga NUMBER;
vendedor NUMBER(6);
snumseq NUMBER(12);
Lnumseq NUMBER(12);
lseqnue NUMBER(12);
vp_letra GE_LETRAS.LETRA%TYPE;
cantidad NUMBER(12);
cantidadNula NUMBER(12);
producto NUMBER(2);
vp_ordentotal NUMBER(12);
vp_cod_modgener VARCHAR2(3);
vp_des_cadena VARCHAR2(255);
vp_error NUMBER(2);
usuario VARCHAR2(30);
gls_error VARCHAR2(250);
fecha VARCHAR(10);
sFecInicio VARCHAR(10);
sFecFin VARCHAR(10);
VP_SQLCODE VARCHAR2(5);
VP_SQLERRM VARCHAR2(50);
cod_concepto FA_CONCEPTOS.COD_CONCEPTO%TYPE;
fec_emision VARCHAR(10);
vp_cod_catimpos GE_DATOSGENER.COD_CATIMPOS%TYPE;
vp_cod_tipdocum FA_HISTDOCU.COD_TIPDOCUM%TYPE;
cod_vendedor_agente FA_HISTDOCU.COD_VENDEDOR_AGENTE%TYPE;
sletra FA_HISTDOCU.LETRA%TYPE;
scentremi FA_HISTDOCU.COD_CENTREMI%TYPE;
ssecuenci FA_HISTDOCU.NUM_SECUENCI%TYPE;
vp_num_folio FA_HISTDOCU.NUM_FOLIO%TYPE;
vp_pref_plaza FA_HISTDOCU.PREF_PLAZA%TYPE;
vp_tip_foliacion VARCHAR2(1);
Acum_netograv FA_HISTDOCU.ACUM_NETOGRAV%TYPE;
acum_netonograv FA_HISTDOCU.ACUM_NETONOGRAV%TYPE;
acum_iva FA_HISTDOCU.ACUM_IVA%TYPE;
cod_plancom FA_HISTDOCU.COD_PLANCOM%TYPE;
vp_imp_maximo FA_CONTROLNC.imp_maximo%TYPE;
centremi NUMBER(4);
srowid VARCHAR(18);
vp_num_dias FA_CONTROLNC.num_dias%TYPE;
stotaplicado NUMBER(14,4);
stotal1 NUMBER(14,4);
ind_supertel FA_HISTDOCU.IND_SUPERTEL%TYPE;
vp_ciclo FA_HISTDOCU.COD_CICLFACT%TYPE;
vp_tabla VARCHAR2(20);
ins_ajuste VARCHAR2(2000);
cursor_name NUMBER;
rows_processed INTEGER;
abrir NUMBER;
moneda VARCHAR2(3);
cod_retorno NUMBER;
des_cadena VARCHAR2(255);
vp_entrada VARCHAR2(1);
vp_cantidad NUMBER(4);
sFormatoFecha GED_PARAMETROS.VAL_PARAMETRO%TYPE;
UsuarioValidado VARCHAR2(500);
manejo_nc_descuento NUMBER;
lv_sql VARCHAR2(1000);

ERROR_PROCESO EXCEPTION;

BEGIN
 vp_error := 0;
 moneda := FA_FN_CODMONFACT;
 abrir := 0;
 vp_cantidad :=0;
 usuario := '';
 gls_error := gls_error||'Termino Ok';

 BEGIN
 SELECT VAL_NUMERICO
 INTO manejo_nc_descuento
 FROM FAD_PARAMETROS
 WHERE COD_PARAMETRO = 209
 AND COD_MODULO = 'FA';
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error. No se encontro datos en tabla FAD_PARAMETROS para COD_PARAMETRO = 209 Msj01';
 RAISE ERROR_PROCESO;
 END;

 IF vp_ind_ordentotal IS NULL OR vp_ind_ordentotal = '' THEN
 vp_error := 1;
 gls_error := 'Error. Falta ingresar Ind.Ordentotal en parametros de entrada.';
 RAISE ERROR_PROCESO;
 END IF;
 IF vp_tipo_tabla IS NULL OR vp_tipo_tabla = '' THEN
 vp_error := 1;
 gls_error := 'Error. Falta ingresar Tipo Tabla en parametros de entrada.';
 RAISE ERROR_PROCESO;
 END IF;
 IF vp_cod_cliente IS NULL OR vp_cod_cliente = '' THEN
 vp_error := 1;
 gls_error := 'Error. Falta ingresar Cliente en parametros de entrada.';
 RAISE ERROR_PROCESO;
 END IF;
 vp_ordentotal := TO_NUMBER(vp_ind_ordentotal);
------- bGetAgenteNOT
 IF vp_tipo_tabla = 'H' THEN
 BEGIN
 SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
 COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
 ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT, PREF_PLAZA
 INTO fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente, sletra,
 scentremi, ssecuenci, vp_num_folio, acum_netograv,
 acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo, vp_pref_plaza
 FROM FA_HISTDOCU
 WHERE IND_ORDENTOTAL = vp_ordentotal;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error. No se encontro datos en tabla FA_HISTDOCU Msj1';
 RAISE ERROR_PROCESO;
 END;
 BEGIN
 SELECT FA_HISTCONC INTO vp_tabla
 FROM FA_ENLACEHIST
 WHERE COD_CICLFACT = vp_ciclo;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error. No se encontro datos en tabla FA_HISTCONC Msj2';
 RAISE ERROR_PROCESO;
 END;
 ELSE
 BEGIN
 SELECT FEC_EMISION, COD_CATIMPOS, COD_TIPDOCUM , COD_VENDEDOR_AGENTE, LETRA,
 COD_CENTREMI, NUM_SECUENCI, NUM_FOLIO, ACUM_NETOGRAV,
 ACUM_NETONOGRAV, COD_PLANCOM, ACUM_IVA, IND_SUPERTEL, COD_CICLFACT, PREF_PLAZA
 INTO fec_emision, vp_cod_catimpos, vp_cod_tipdocum, cod_vendedor_agente, sletra,
 scentremi, ssecuenci, vp_num_folio, acum_netograv,
 acum_netonograv, cod_plancom, acum_iva, ind_supertel, vp_ciclo, vp_pref_plaza
 FROM FA_FACTDOCU_NOCICLO
 WHERE IND_ORDENTOTAL = vp_ordentotal;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error. No encontro datos en tabla FA_FACTDOCU_NOCICLO Msj3';
 RAISE ERROR_PROCESO;
 END;
 END IF;
 IF vp_num_folio <= 0 THEN
 vp_error := 5;
 gls_error := 'Error. Documento no tiene asociado num.folio Msj4';
 RAISE ERROR_PROCESO;
 END IF;
 IF vp_pref_plaza = '' THEN
 vp_error := 5;
 gls_error := 'Error. Documento no tiene asociado prefijo de plaza Msj5';
 RAISE ERROR_PROCESO;
 END IF;
 SELECT COUNT(*) INTO cantidad
 FROM FA_INTERFACT
 WHERE num_foliorel = vp_num_folio AND
 pref_plazarel = vp_pref_plaza AND
 cod_tipmovimien = 25 AND
 cod_estadoc < 200;
 IF cantidad > 0 THEN
 vp_error := 5;
 gls_error := 'Error. Documento tiene pendiente la emisisn de Nota de Cridito Msj6';
 RAISE ERROR_PROCESO;
 END IF;
 IF (ind_Supertel = '1') AND (vp_cod_tipdocum = '2') THEN
 vp_error := 5;
 gls_error := 'Error. Factura Corresponde a Supertelefono, no es posible generar Nota de Credito Msj7';
 RAISE ERROR_PROCESO;
 END IF;
 IF cod_vendedor_agente IS NULL THEN
 vp_error := 5;
 gls_error := 'Error. Documento no tiene asociado un vendedor Msj8';
 RAISE ERROR_PROCESO;
 END IF;
 UsuarioValidado := FA_VAL_USUARIO_NCTOTAL_FN(vp_cod_cliente, vp_ordentotal);
 IF UsuarioValidado <> 'OK'
 THEN
 vp_error := 2;
 gls_error := UsuarioValidado;
 RAISE ERROR_PROCESO;
 END IF;
------- bValnotaCred
 SELECT COUNT(NUM_FOLIO) INTO cantidad
 FROM FA_AJUSTES
 WHERE NUM_FOLIO = vp_num_folio
 AND PREF_PLAZA = vp_pref_plaza
 AND COD_CLIENTE = vp_cod_cliente
 AND COD_TIPDOCUM = vp_cod_tipdocum
 AND ACUM_NETOGRAVNC > 0;
 IF cantidad != 0 THEN
 SELECT COUNT(1) INTO cantidadNula
 From FA_INTERFACT
 Where NUM_FOLIOREL = vp_num_folio And
 COD_TIPDOCUM = 25 AND
 COD_ESTADOC = 900 AND
 COD_ESTPROC = 3
 Union All SELECT COUNT(1)
 From FA_HISTINTERFACT
 Where NUM_FOLIOREL = vp_num_folio And
 COD_TIPDOCUM = 25 AND
 COD_ESTADOC = 900 AND
 COD_ESTPROC = 3;

 IF cantidadNula = 0 THEN
 vp_error := 5;
 gls_error := 'Error. Factura Ya tiene Notas de Crédito anteriores Msj9';
 RAISE ERROR_PROCESO;
 END If;
 END IF;
------- bValnotaCred
 SELECT COUNT(NUM_FOLIO) INTO cantidad
 FROM FA_AJUSTES
 WHERE NUM_FOLIO = vp_num_folio
 AND PREF_PLAZA = vp_pref_plaza
 AND COD_CLIENTE = vp_cod_cliente
 AND COD_TIPDOCUM = vp_cod_tipdocum;
 IF cantidad <= 0 THEN
 BEGIN
 INSERT INTO FA_AJUSTES
 (NUM_FOLIO ,
 ACUM_NETONOGRAVORIG,
 ACUM_NETONOGRAVNC ,
 ACUM_NETONOGRAVND ,
 ACUM_NETOGRAVORIG,
 ACUM_NETOGRAVNC ,
 ACUM_NETOGRAVND,
 COD_PLANCOM,
 COD_CATIMPOS,
 ACUM_IVAORIG,
 ACUM_IVANC,
 ACUM_IVAND,
 COD_CLIENTE,
 COD_TIPDOCUM,
 PREF_PLAZA )
 VALUES
 (vp_num_folio,
 acum_netonograv,
 0,
 0,
 acum_netograv,
 0,
 0,
 cod_plancom,
 vp_cod_catimpos,
 acum_iva,
 0,
 0,
 vp_cod_cliente,
 vp_cod_tipdocum,
 vp_pref_plaza);
 EXCEPTION
 WHEN DUP_VAL_ON_INDEX THEN
 vp_error := 3;
 gls_error := 'Error.No se puede insertar en tabla FA_AJUSTES por PK duplicadas Msj10';
 RAISE ERROR_PROCESO;
 WHEN OTHERS THEN
 vp_error := 3;
 gls_error := 'Error.No se puede insertar en la tabla FA_AJUSTES Msj11';
 RAISE ERROR_PROCESO;
 END;
---------------bSQLInsertConc
 IF vp_tipo_tabla = 'N' THEN
 IF manejo_nc_descuento = 1 THEN
 BEGIN
 INSERT INTO FA_AJUSTECONC
 (PREF_PLAZA, NUM_FOLIO, COD_CONCEPTO, COLUMNA,
 COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA,
 IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
 COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR,
 IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR,
 DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE,
 MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION,
 FLAG_IMPUES, FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM)
 SELECT vp_pref_plaza, vp_num_folio, a.COD_CONCEPTO,
 a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, a.IMP_CONCEPTO,moneda,
 a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA,
 a.COD_CIUDAD, b.COD_MODULO,
 a.NUM_UNIDADES, a.NUM_SERIEMEC,
 a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE,
 a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR,
 a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA,
 a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA,
 a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES,
 a.FLAG_DTO, c.COD_CLIENTE, C.COD_TIPDOCUM
 FROM FA_CONCEPTOS b,
 FA_FACTDOCU_NOCICLO c,
 FA_FACTCONC_NOCICLO a
 WHERE a.IND_ORDENTOTAL = vp_ordentotal AND
 a.COD_CONCEPTO = b.COD_CONCEPTO AND
 a.IND_ORDENTOTAL = c.IND_ORDENTOTAL AND
 a.COD_TIPCONCE <> 1;
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 3;
 gls_error := 'Error.No se puede insertar en tabla FA_AJUSTECONC Msj12';
 RAISE ERROR_PROCESO;
 END;
 ELSE
 BEGIN
 INSERT INTO FA_AJUSTECONC
 (PREF_PLAZA, NUM_FOLIO, COD_CONCEPTO, COLUMNA,
 COD_PRODUCTO, FEC_EFECTIVIDAD, IMP_CONCEPTO, COD_MONEDA,
 IMP_FACTURABLE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
 COD_MODULO, NUM_UNIDADES, NUM_SERIEMEC, COD_TIPCONCE, FEC_VALOR,
 IMP_MONTOBASE, IND_FACTUR, IND_SUPERTEL, NUM_ABONADO, COD_PORTADOR,
 DES_CONCEPTO, SEQ_CUOTAS, NUM_CUOTAS, ORD_CUOTA, NUM_SERIELE,
 MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE, NUM_VENTA, NUM_TRANSACCION,
 FLAG_IMPUES, FLAG_DTO, COD_CLIENTE, COD_TIPDOCUM)
 SELECT vp_pref_plaza, vp_num_folio, a.COD_CONCEPTO,
 a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, a.IMP_CONCEPTO,moneda,
 a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA,
 a.COD_CIUDAD, b.COD_MODULO,
 a.NUM_UNIDADES, a.NUM_SERIEMEC,
 a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE,
 a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR,
 a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA,
 a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA,
 a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES,
 a.FLAG_DTO, c.COD_CLIENTE, C.COD_TIPDOCUM
 FROM FA_CONCEPTOS b,
 FA_FACTDOCU_NOCICLO c,
 FA_FACTCONC_NOCICLO a
 WHERE a.IND_ORDENTOTAL = vp_ordentotal AND
 a.COD_CONCEPTO = b.COD_CONCEPTO AND
 a.IND_ORDENTOTAL = c.IND_ORDENTOTAL AND
 a.COD_TIPCONCE <> 1 AND
 (a.COD_TIPCONCE <> 2 OR ( a.COD_TIPCONCE = 2 AND (a.COD_CONCEREL=0 OR a.COD_CONCEREL IS NULL)));
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 3;
 gls_error := 'Error.No se puede insertar en tabla FA_AJUSTECONC Msj12';
 RAISE ERROR_PROCESO;
 END;
 END IF;

 IF manejo_nc_descuento = 0 THEN
 BEGIN
 UPDATE FA_AJUSTECONC A -- modifica los cargos insertados anteriormente
 SET IMP_FACTURABLE = ( SELECT A.IMP_FACTURABLE + B.IMP_FACTURABLE
 FROM FA_FACTCONC_NOCICLO B
 WHERE B.IND_ORDENTOTAL = vp_ordentotal
 AND B.COD_TIPCONCE = 2
 AND A.COD_CONCEPTO = B.COD_CONCEREL
 AND A.COLUMNA = B.COLUMNA_REL),
 IMP_CONCEPTO = ( SELECT A.IMP_CONCEPTO + B.IMP_CONCEPTO
 FROM FA_FACTCONC_NOCICLO B
 WHERE B.IND_ORDENTOTAL = vp_ordentotal
 AND B.COD_TIPCONCE = 2
 AND A.COD_CONCEPTO = B.COD_CONCEREL
 AND A.COLUMNA = B.COLUMNA_REL)
 WHERE A.NUM_FOLIO = vp_num_folio
 AND A.PREF_PLAZA = vp_pref_plaza
 AND A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL
 FROM FA_FACTCONC_NOCICLO B
 WHERE B.IND_ORDENTOTAL = vp_ordentotal
 AND B.COD_TIPCONCE = 2
 AND A.COD_CONCEPTO = B.COD_CONCEREL
 AND A.COLUMNA = B.COLUMNA_REL);
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 4;
 gls_error := 'Error.No se puede actualizar tabla FA_AJUSTECONC Msj13';
 RAISE ERROR_PROCESO;
 END;
 END IF;

 BEGIN
 SELECT COUNT(A.COD_CONCEPTO)
 INTO vp_cantidad
 FROM FA_AJUSTECONC A
 WHERE A.PREF_PLAZA = vp_pref_plaza AND -- Se agrega pref_plaza inc 42021 PPV 26/07/2007
 A.NUM_FOLIO = vp_num_folio AND
 A.COD_CLIENTE = vp_cod_cliente AND
 A.COD_TIPDOCUM = vp_cod_tipdocum;
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 2;
 gls_error := 'Error.No se puede obtener cantidad de registros de FA_AJUSTECONC Msj14';
 RAISE ERROR_PROCESO;
 END;
 ELSE
 BEGIN
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
 ins_ajuste := ins_ajuste || 'a.COLUMNA, a.COD_PRODUCTO, a.FEC_EFECTIVIDAD, a.IMP_CONCEPTO, :moneda, ';
 ins_ajuste := ins_ajuste || 'a.IMP_FACTURABLE, a.COD_REGION, a.COD_PROVINCIA, ';
 ins_ajuste := ins_ajuste || 'a.COD_CIUDAD, b.COD_MODULO, ';
 ins_ajuste := ins_ajuste || 'a.NUM_UNIDADES, a.NUM_SERIEMEC, ';
 ins_ajuste := ins_ajuste || 'a.COD_TIPCONCE, a.FEC_VALOR,a.IMP_MONTOBASE, ';
 ins_ajuste := ins_ajuste || 'a.IND_FACTUR, c.ind_supertel, a.NUM_ABONADO, a.COD_PORTADOR, ';
 ins_ajuste := ins_ajuste || 'a.DES_CONCEPTO, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, ';
 ins_ajuste := ins_ajuste || 'a.NUM_SERIELE, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, ';
 ins_ajuste := ins_ajuste || 'a.NUM_PAQUETE, c.NUM_VENTA, c.NUM_TRANSACCION, a.FLAG_IMPUES, ';
 ins_ajuste := ins_ajuste || 'a.FLAG_DTO, c.COD_CLIENTE, C.COD_TIPDOCUM ';
 ins_ajuste := ins_ajuste || 'FROM FA_CONCEPTOS b, ';
 ins_ajuste := ins_ajuste || ' FA_HISTDOCU c, ';
 ins_ajuste := ins_ajuste || ' ' || RTRIM(vp_tabla) || ' a ';
 ins_ajuste := ins_ajuste || 'WHERE a.IND_ORDENTOTAL = :ordentotal AND ';
 ins_ajuste := ins_ajuste || ' a.COD_CONCEPTO = b.COD_CONCEPTO AND ';
 ins_ajuste := ins_ajuste || ' a.IND_ORDENTOTAL = c.IND_ORDENTOTAL AND ';
 ins_ajuste := ins_ajuste || ' a.COD_TIPCONCE <> 1 ';
 IF manejo_nc_descuento = 0 THEN
 ins_ajuste := ins_ajuste || ' AND ( a.COD_TIPCONCE <> 2 OR ( a.COD_TIPCONCE=2 AND (COD_CONCEREL=0 OR COD_CONCEREL IS NULL)))';
 END IF;
 EXECUTE IMMEDIATE ins_ajuste USING moneda, vp_ordentotal;
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 3;
 gls_error := 'Error.No se puede actualizar tabla FA_AJUSTECONC Msj15';
 RAISE ERROR_PROCESO;
 END;
 IF manejo_nc_descuento = 0 THEN
 BEGIN
 ins_ajuste := '';
 ins_ajuste := 'UPDATE FA_AJUSTECONC A ';
 ins_ajuste := ins_ajuste || 'SET IMP_FACTURABLE = ( A.IMP_FACTURABLE + (SELECT SUM(B.IMP_FACTURABLE) ';
 ins_ajuste := ins_ajuste || ' FROM ' || RTRIM(vp_tabla) || ' B ';
 ins_ajuste := ins_ajuste || ' WHERE B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
 ins_ajuste := ins_ajuste || ' B.COD_TIPCONCE = 2 AND ';
 ins_ajuste := ins_ajuste || ' A.COD_CONCEPTO = B.COD_CONCEREL AND ';
 ins_ajuste := ins_ajuste || ' A.COLUMNA = B.COLUMNA_REL) ), ';
 ins_ajuste := ins_ajuste || ' IMP_CONCEPTO = ( A.IMP_CONCEPTO + (SELECT SUM(B.IMP_CONCEPTO) ';
 ins_ajuste := ins_ajuste || ' FROM ' || RTRIM(vp_tabla) || ' B ';
 ins_ajuste := ins_ajuste || ' WHERE B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
 ins_ajuste := ins_ajuste || ' B.COD_TIPCONCE = 2 AND ';
 ins_ajuste := ins_ajuste || ' A.COD_CONCEPTO = B.COD_CONCEREL AND ';
 ins_ajuste := ins_ajuste || ' A.COLUMNA = B.COLUMNA_REL) ) ';
 ins_ajuste := ins_ajuste || 'WHERE A.NUM_FOLIO = :numfolio AND ';
 ins_ajuste := ins_ajuste || ' A.PREF_PLAZA = :prefplaza AND ';
 ins_ajuste := ins_ajuste || ' A.COD_CONCEPTO IN (SELECT B.COD_CONCEREL ';
 ins_ajuste := ins_ajuste || ' FROM ' || RTRIM(vp_tabla) || ' B ';
 ins_ajuste := ins_ajuste || ' WHERE B.IND_ORDENTOTAL = ' || RTRIM(TO_CHAR(vp_ordentotal)) || ' AND ';
 ins_ajuste := ins_ajuste || ' B.COD_TIPCONCE = 2 AND ';
 ins_ajuste := ins_ajuste || ' A.COD_CONCEPTO = B.COD_CONCEREL AND ';
 ins_ajuste := ins_ajuste || ' A.COLUMNA = B.COLUMNA_REL) ';
 EXECUTE IMMEDIATE ins_ajuste USING vp_num_folio, vp_pref_plaza;
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 4;
 gls_error := 'Error.No se puede actualizar tabla FA_AJUSTECONC Msj16';
 RAISE ERROR_PROCESO;
 END;
 END IF;
 END IF;
 END IF;
 
-------Grabar impuestos P-CSR-12019
 BEGIN
 SELECT COUNT(1) INTO cantidad
 FROM FA_DETIMPTOSTIPO_TO
 WHERE NUM_FOLIO = vp_num_folio
 AND PREF_PLAZA = vp_pref_plaza
 AND COD_CLIENTE = vp_cod_cliente;
 
 IF cantidad = 0 THEN
 IF vp_tipo_tabla = 'N' THEN
 INSERT INTO FA_DETIMPTOSTIPO_TO (NUM_FOLIO, PREF_PLAZA, COD_CLIENTE, NUM_ABONADO, COD_TIPIMPUES, ACUM_IMPUESTO_ORIG, ACUM_NETO_ORIGEN, ACUM_NETO_AFECTO_ORIGEN)
 SELECT C.NUM_FOLIO, C.PREF_PLAZA, C.COD_CLIENTE, A.NUM_ABONADO, B.COD_TIPIMPUES, SUM(A.IMP_FACTURABLE),max(C.ACUM_NETOGRAV+c.ACUM_NETONOGRAV), SUM(IMP_MONTOBASE)
 FROM fa_factconc_nociclo a, GE_IMPUESTOS B, FA_FACTDOCU_NOCICLO C, FA_GRPSERCONC D
 WHERE c.ind_ordentotal = vp_ordentotal
 AND c.ind_ordentotal = A.ind_ordentotal
 AND A.COD_TIPCONCE = 1
 AND A.COD_CONCEPTO = b.COD_CONCGENE
 AND C.COD_CATIMPOS = B.COD_CATIMPOS
 AND C.COD_ZONAIMPO = B.COD_ZONAIMPO
 AND C.FEC_EMISION <= B.FEC_HASTA
 AND C.FEC_EMISION >= B.FEC_DESDE
 AND B.COD_GRPSERVI = D.COD_GRPSERVI
 AND D.COD_CONCEPTO = A.COD_CONCEREL
 AND C.FEC_EMISION <= D.FEC_HASTA
 AND C.FEC_EMISION >= D.FEC_DESDE
 GROUP BY C.NUM_FOLIO, C.PREF_PLAZA, C.COD_CLIENTE, A.NUM_ABONADO, B.COD_TIPIMPUES;

 ELSE
 lv_sql :='INSERT INTO FA_DETIMPTOSTIPO_TO (NUM_FOLIO, PREF_PLAZA, COD_CLIENTE, NUM_ABONADO, COD_TIPIMPUES, ACUM_IMPUESTO_ORIG, ACUM_NETO_ORIGEN, ACUM_NETO_AFECTO_ORIGEN) ';
 lv_sql := lv_sql || 'SELECT C.NUM_FOLIO, C.PREF_PLAZA, C.COD_CLIENTE, A.NUM_ABONADO, B.COD_TIPIMPUES, SUM(A.IMP_FACTURABLE), max(C.ACUM_NETOGRAV+c.ACUM_NETONOGRAV), SUM(IMP_MONTOBASE) ';
 lv_sql := lv_sql || 'FROM ' || TRIM(vp_tabla) || ' a, GE_IMPUESTOS B, FA_HISTDOCU C, FA_GRPSERCONC D ';
 lv_sql := lv_sql || 'WHERE C.IND_ORDENTOTAL =' || vp_ordentotal;
 lv_sql := lv_sql || 'AND C.IND_ORDENTOTAL = A.IND_ORDENTOTAL ';
 lv_sql := lv_sql || 'AND A.COD_TIPCONCE = 1 ' ;
 lv_sql := lv_sql || 'AND A.COD_CONCEPTO = b.COD_CONCGENE ';
 lv_sql := lv_sql || 'AND C.COD_CATIMPOS = B.COD_CATIMPOS ';
 lv_sql := lv_sql || 'AND C.COD_ZONAIMPO = B.COD_ZONAIMPO ';
 lv_sql := lv_sql || 'AND C.FEC_EMISION <= B.FEC_HASTA ';
 lv_sql := lv_sql || 'AND C.FEC_EMISION >= B.FEC_DESDE ';
 lv_sql := lv_sql || 'AND B.COD_GRPSERVI = D.COD_GRPSERVI ';
 lv_sql := lv_sql || 'AND D.COD_CONCEPTO = A.COD_CONCEREL ';
 lv_sql := lv_sql || 'AND C.FEC_EMISION <= D.FEC_HASTA ';
 lv_sql := lv_sql || 'AND C.FEC_EMISION >= D.FEC_DESDE ';
 lv_sql := lv_sql || ' GROUP BY C.NUM_FOLIO, C.PREF_PLAZA, C.COD_CLIENTE, A.NUM_ABONADO, B.COD_TIPIMPUES ';
 EXECUTE IMMEDIATE lv_sql;
 END IF;
 END IF;
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 7;
 gls_error := 'Error.No se puede actualizar tabla FA_AJUSTECONC Msj36';
 RAISE ERROR_PROCESO;
 END ;
 --FIN P-CSR-12019
 
------- sSecuenciaEmi
 SELECT FA_SEQ_CREDITO.NEXTVAL INTO snumseq
 FROM DUAL;
 snumseq := snumseq + 1;
 sFormatoFecha :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
 BEGIN
 SELECT USER, RTRIM(TO_CHAR(SYSDATE, sFormatofecha)) INTO usuario, fecha
 FROM DUAL;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error.No se puede obtener la fecha actual Msj17';
 RAISE ERROR_PROCESO;
 END;
 SELECT NVL(COD_VENDEDOR, -1), NVL(COD_OFICINA, ' ') INTO vendedor, oficina
 FROM GE_SEG_USUARIO
 WHERE NOM_USUARIO = usuario;
 IF vendedor = -1 OR oficina = ' ' THEN
 SELECT COD_AGENTESTARTEL, COD_OFICCENTRAL INTO vendedor, oficina
 FROM GE_DATOSGENER;
 IF vendedor = -1 OR oficina = ' ' THEN
 vp_error := 2;
 gls_error := 'Error.El vendedor no existe en tabla de seguridad de usuarios Msj18';
 RAISE ERROR_PROCESO;
 END IF;
 END IF;
 BEGIN
 SELECT COD_CENTREMI INTO centremi
 FROM AL_DOCUM_SUCURSAL
 WHERE COD_TIPDOCUM = 25 AND
 COD_OFICINA = oficina;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error.No se encontraron datos del codigo centro emisor Msj19';
 RAISE ERROR_PROCESO;
 END;
------- bGetLetraAG
 BEGIN
 SELECT LETRA INTO vp_letra
 FROM GE_LETRAS
 WHERE COD_CATIMPOS = vp_cod_catimpos
 AND COD_TIPDOCUM = 25;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error.No se encontraron datos de la letra de la categoria impositiva Msj20';
 RAISE ERROR_PROCESO;
 END;
 IF vp_letra = ' ' THEN
 vp_error := 5;
 gls_error := 'Error. Categorma impositiva no tiene asociada Letra en tabla GE_LETRAS Msj21';
 RAISE ERROR_PROCESO;
 END IF;
--- bInsertProceso
 BEGIN
 INSERT INTO FA_PROCESOS( NUM_PROCESO, COD_TIPDOCUM, COD_VENDEDOR_AGENTE,
 COD_CENTREMI, FEC_EFECTIVIDAD, NOM_USUARORA,
 LETRAAG, NUM_SECUAG, COD_TIPDOCNOT, COD_VENDEDOR_AGENTENOT,
 LETRANOT, COD_CENTRNOT, NUM_SECUNOT, IND_ESTADO, COD_CICLFACT, IND_NOTACREDC)
 VALUES (TO_NUMBER(vp_num_proceso), 25, vendedor,
 centremi, SYSDATE, usuario,
 vp_letra, snumseq, vp_cod_tipdocum, cod_vendedor_agente,
 sletra, scentremi, ssecuenci, NULL, NULL, 0
 );
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 3;
 gls_error := 'Error.No se pudo insertar datos en tabla FA_PROCESOS Msj22';
 RAISE ERROR_PROCESO;
 END;
------- bUpdConc_tot
 BEGIN
 UPDATE FA_AJUSTECONC
 SET IMP_CONCEPTO = IMP_FACTURABLE
 WHERE NUM_FOLIO = vp_Num_Folio AND
 PREF_PLAZA = vp_pref_plaza AND
 COD_CLIENTE = TO_NUMBER(vp_cod_cliente) AND
 COD_TIPDOCUM = vp_cod_tipdocum;
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 4;
 gls_error := 'Error.No se pudo actualizar el importe concepto en tabla FA_AJUSTECONC Msj23';
 RAISE ERROR_PROCESO;
 END;
------- bInsertPrefactura
 BEGIN
 INSERT INTO FA_PREFACTURA
 (NUM_PROCESO, COD_CLIENTE, COD_CONCEPTO, COLUMNA,
 COD_PRODUCTO, COD_MONEDA, FEC_VALOR, FEC_EFECTIVIDAD, IMP_CONCEPTO,
 IMP_FACTURABLE, IMP_MONTOBASE, COD_REGION, COD_PROVINCIA, COD_CIUDAD,
 COD_MODULO, COD_PLANCOM, IND_FACTUR, COD_CATIMPOS,COD_PORTADOR,IND_ESTADO,
 COD_TIPCONCE,NUM_UNIDADES,COD_CICLFACT,COD_CONCEREL,COLUMNA_REL,NUM_ABONADO,
 NUM_TERMINAL,CAP_CODE,NUM_SERIEMEC,NUM_SERIELE,FLAG_IMPUES,FLAG_DTO,NUM_VENTA,
 NUM_TRANSACCION,MES_GARANTIA,NUM_GUIA,IND_ALTA,IND_SUPERTEL,NUM_PAQUETE,IND_CUOTA,
 NUM_CUOTAS, ORD_CUOTA, COD_TIPDOCUM)
 SELECT TO_NUMBER(vp_num_proceso), TO_NUMBER(vp_cod_cliente), a.COD_CONCEPTO, a.COLUMNA, a.COD_PRODUCTO,
 moneda,a.FEC_VALOR, a.FEC_EFECTIVIDAD,
 a.IMP_CONCEPTO, a.IMP_FACTURABLE, 0, a.COD_REGION, a.COD_PROVINCIA, a.COD_CIUDAD,
 a.COD_MODULO, b.COD_PLANCOM, a.IND_FACTUR, b.COD_CATIMPOS, a.COD_PORTADOR,
 0, a.COD_TIPCONCE, 1, NULL, NULL, NULL, a.NUM_ABONADO, NULL, NULL,
 a.NUM_SERIEMEC, a.NUM_SERIELE, a.FLAG_IMPUES, a.FLAG_DTO, a.NUM_VENTA,
 a.NUM_TRANSACCION, a.MES_GARANTIA, a.NUM_GUIA, a.IND_ALTA, a.IND_SUPERTEL,
 a.NUM_PAQUETE, a.SEQ_CUOTAS, a.NUM_CUOTAS, a.ORD_CUOTA, B.COD_TIPDOCUM
 FROM FA_AJUSTECONC a, FA_AJUSTES b
 WHERE a.NUM_FOLIO = vp_num_folio AND
 a.PREF_PLAZA = vp_pref_plaza AND
 a.COD_CLIENTE = TO_NUMBER(vp_cod_cliente) AND
 b.COD_TIPDOCUM = vp_cod_tipdocum AND
 a.NUM_FOLIO = b.NUM_FOLIO AND
 a.PREF_PLAZA = b.PREF_PLAZA AND
 a.COD_CLIENTE = b.COD_CLIENTE AND
 a.COD_TIPDOCUM = b.COD_TIPDOCUM;

 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 3;
 gls_error := 'Error.No se pudo insertar en tabla FA_PREFACTURA Msj24';
 RAISE ERROR_PROCESO;
 END;
------- bControlPeriodo
 vp_imp_maximo := 0;
 vp_num_dias := 0;
 BEGIN
 SELECT IMP_MAXIMO, NUM_DIAS
 INTO vp_imp_maximo, vp_num_dias
 FROM FA_CONTROLNC
 WHERE NOM_USUARIO = usuario AND
 FEC_DESDE <= SYSDATE AND
 FEC_HASTA >= SYSDATE;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error. El usuario no esta creado en la tabla FA_CONTROLNC Msj25';
 RAISE ERROR_PROCESO;
 WHEN OTHERS THEN
 vp_error := 2;
 gls_error := 'Error.Existe mas de un registro en la tabla FA_CONTROLNC para asignar a imp. maximo y num. dias Msj26';
 RAISE ERROR_PROCESO;
 END;
 SELECT COUNT(*) INTO CANTIDAD
 FROM fa_aplicadonc
 WHERE NOM_USUARIO = usuario AND
 COD_CLIENTE = TO_NUMBER(vp_cod_cliente) AND
 FEC_INICIO <= SYSDATE AND
 FEC_FIN >= SYSDATE;
 IF CANTIDAD <= 0 THEN
--------------- bInsertAplicadoNC
 BEGIN
 INSERT INTO FA_APLICADONC(NOM_USUARIO, COD_CLIENTE, FEC_INICIO, FEC_FIN, TOT_APLICADO)
 VALUES ( usuario, TO_NUMBER(vp_cod_cliente),
 --TO_DATE(TO_CHAR(TRUNC(SYSDATE, 'MONTH'), 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'), /*Se quita en incidencia RA-200603080881 PPV 21/03/2006 */
 TRUNC(SYSDATE), /* Incidencia RA-200603080881 PPV 21/03/2006 */
 --TO_DATE(TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,1),'MONTH')-1/86400, 'DD-MM-YYYY HH24:MI:SS'), 'DD-MM-YYYY HH24:MI:SS'), /*Se quita en incidencia RA-200603080881 PPV 21/03/2006 */
 TO_DATE(TO_CHAR(SYSDATE + vp_num_dias ,'DD-MM-YYYY') || ' 23:59:59','DD-MM-YYYY HH24:MI:SS'), /* Incidencia RA-200603080881 PPV 21/03/2006 */
 acum_netograv
 );
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 3;
 gls_error := 'Error.No se pudo insertar datos en tabla FA_APLICADONC Msj27';
 RAISE ERROR_PROCESO;
 END;
 ELSE
 SELECT ROWID, TOT_APLICADO, TO_CHAR(FEC_INICIO, 'DD/MM/YYYY'), TO_CHAR(FEC_FIN, 'DD/MM/YYYY')
 INTO srowid, sTotAplicado, sFecInicio, sFecFin
 FROM FA_APLICADONC
 WHERE NOM_USUARIO = usuario AND
 COD_CLIENTE = TO_NUMBER(vp_cod_cliente) AND
 FEC_INICIO <= SYSDATE AND
 FEC_FIN >= SYSDATE;
 stotal1 := acum_netograv + sTotAplicado;
 IF stotal1 <= vp_imp_maximo THEN
 BEGIN
 UPDATE FA_APLICADONC
 SET TOT_APLICADO = TOT_APLICADO + acum_netograv
 WHERE ROWID = sRowid;
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 4;
 gls_error := 'Error.No se pudo actualizar el importe aplicado en tabla FA_APLICADONC Msj28';
 RAISE ERROR_PROCESO;
 END;
 ELSE
 vp_error := 2;
 gls_error := 'Error. Se ha sobrepasado el Límite Importe para el Usuario Msj29';
 RAISE ERROR_PROCESO;
 END IF;
 END IF;
 lSeqNue := sNumSeq + 1;
------- bUpdSecuencia
 BEGIN
 UPDATE GE_SECUENCIASEMI
 SET NUM_SECUENCI = lSeqNue
 WHERE COD_TIPDOCUM = 25 AND
 COD_CENTREMI = centremi AND
 LETRA = vp_letra; -- GE_LETRAS
 EXCEPTION
 WHEN OTHERS THEN
 vp_error := 4;
 gls_error := 'Error.No se pudo actualizar tabla GE_SECUENCIASEMI Msj30';
 RAISE ERROR_PROCESO;
 END;
 SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO secuencia_ga
 FROM DUAL;
 BEGIN
 SELECT tip_foliacion
 INTO vp_tip_foliacion
 FROM ge_tipdocumen
 where cod_tipdocum = vp_cod_tipdocum;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 Gls_error := 'Error.No se pudo recuperar código tipo foliacion de tabla GE_TIPDOCUMEN Msj31';
 RAISE ERROR_PROCESO;
 END;
 BEGIN
 SELECT COD_MODGENER INTO vp_cod_modgener
 FROM FA_GENCENTREMI
 WHERE COD_CENTREMI = centremi AND
 COD_TIPMOVIMIEN = 25 AND
 COD_CATRIBUT = vp_categoria_trib AND
 COD_MODVENTA = TO_NUMBER(vp_cod_modventa) AND
 TIP_FOLIACION = vp_tip_foliacion;
 vp_entrada := '0';
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
 vp_error := 2;
 gls_error := 'Error.No se pudo recuperar código modo de generacisn de tabla FA_GENCENTREMI Msj32';
 RAISE ERROR_PROCESO;
 END;
 FA_INS_INTERFACT ( TO_CHAR(secuencia_ga), vp_num_proceso, '0',
 vp_cod_modgener, '25', vp_categoria_trib, TO_CHAR(vp_num_folio), '100', '3',
 fecha, vp_entrada, vp_cod_modventa, '0', vp_pref_plaza, vp_tip_foliacion, '');
 SELECT COD_RETORNO, DES_CADENA INTO cod_retorno, des_cadena
 FROM ga_transacabo
 WHERE num_transaccion = secuencia_ga;
 IF cod_retorno != 0 THEN
 vp_error := 5;
 gls_error := 'Error. No se pudo ejecutar PL FA_INS_INTERFACT Secuencia = '||TO_CHAR(secuencia_ga)||' Msj33';
 RAISE ERROR_PROCESO;
 ELSE
 DELETE FROM ga_transacabo WHERE num_transaccion = secuencia_ga;
 END IF;
 RAISE ERROR_PROCESO;
 EXCEPTION
 WHEN ERROR_PROCESO THEN
 IF vp_error = 0 THEN
 INSERT INTO GA_TRANSACABO
 (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
 VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
 ELSE
 INSERT INTO GA_TRANSACABO
 (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
 VALUES (TO_NUMBER(vp_secuencia_ga), vp_error, gls_error);
 END IF;
 WHEN DUP_VAL_ON_INDEX THEN
 INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
 VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Duplicado');
 WHEN NO_DATA_FOUND THEN
 INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
 VALUES (TO_NUMBER(vp_secuencia_ga), 1, 'Datos No Fueron Encontrados');
 WHEN OTHERS THEN
 gls_error := gls_error || '. Problemas en PL : FA_PRE_NOTACREDINTER = ' || SQLCODE || ' ( ' || SQLERRM || ' ) ';
 INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
 VALUES (TO_NUMBER(vp_secuencia_ga), 1, gls_error);
END FA_PRE_NOTACREDINTER;
/
SHOW ERRORS


