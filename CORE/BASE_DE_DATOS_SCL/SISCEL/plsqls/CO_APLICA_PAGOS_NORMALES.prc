CREATE OR REPLACE PROCEDURE          "CO_APLICA_PAGOS_NORMALES" (vp_cod_entidad IN  VARCHAR2,  vp_num_transac  IN  NUMBER ,
	   	  		  				                     vp_Ind_Retorno OUT NUMBER  ,  vp_Glosa_Error  OUT VARCHAR2) IS

vp_gls_error        CO_TRANSAC_ERROR.DESC_SQL%TYPE;
sNom_User           CO_CAJEROS.NOM_USUARORA%TYPE;
sNUM_IDENT 			COT_EXT_RECAUDACION.NUM_IDENT%TYPE;
sIMP_TOTAL 			COT_EXT_RECAUDACION.IMP_TOTAL%TYPE;
sNUM_EJERCICIO 		COT_EXT_RECAUDACION.NUM_EJERCICIO%TYPE;
sIND_RECHAZO 		COT_EXT_RECAUDACION.NUM_EJERCICIO%TYPE;
sIND_PROCESADO 		COT_EXT_RECAUDACION.IND_PROCESADO%TYPE;
sSecuencia			CO_CARTERA.NUM_SECUENCI%TYPE;
sLetra  			CO_CARTERA.LETRA%TYPE;
vp_cliente_inmune	CO_INMUNIDAD.COD_CLIENTE%TYPE;
vCodCliente         CO_CARTERA.COD_CLIENTE%TYPE;

sCod_OperadorAbono  CO_CARTERA.COD_OPERADORA_SCL%TYPE;
sCod_PlazaAbono     CO_CARTERA.COD_PLAZA%TYPE;
sNum_Folio			CO_CARTERA.NUM_FOLIO%TYPE;
sPref_Plaza		    CO_PAGOS.PREF_PLAZA%TYPE;

sPasoFolio			VARCHAR2(20);
sPasoFolio2			VARCHAR2(20);
iPos1				NUMBER(5);
iPos2				NUMBER(5);
iPos3				NUMBER(5);
iPos4				NUMBER(5);
iDecimal            NUMBER(2);

sFEC_PAGO           VARCHAR2(20);
vp_cod_oficina      VARCHAR2(2);
vp_cod_caja         NUMBER(4);
vp_SecCompago       NUMBER(12);
vp_SecPago          NUMBER(12);
sDocumPago          NUMBER(12);
sTipDocumPag        NUMBER(2);
nSecuencia          NUMBER(12);
nSecuenciaAux       NUMBER(12);
dNumMovto           NUMBER(9);
sRow                NUMBER(4);
vp_ruteo            NUMBER(2);
sdiasint            NUMBER(5);
dfac_cobro          NUMBER(8,5);
sSecCargo           NUMBER(12);
vp_cliente_exento   VARCHAR(8);
sCiclo              NUMBER(6);
v_sqlcode           VARCHAR2(10);
nImporte            NUMBER(18);
sDocFacturaCon      NUMBER(2);
nTotal              NUMBER(18);
sNumSecueChe        NUMBER(12);
sNumSecuenciaDet    NUMBER(2);
sNom_proceso        VARCHAR2(40);
dNumColumna         NUMBER(5);
sCodConcepto        NUMBER(1);
sCodProducto        NUMBER(1);
dNumAuxColumna      NUMBER(9);
v_sqlerrm           VARCHAR2(255);
iTotalImp           NUMBER(15,4):=0;
x                   NUMBER(4);
SW                  NUMBER(1);
iAcumula            NUMBER(15,4);
iFaltante           NUMBER(15,4);
iSaldo              NUMBER(15,4);
iCheque             NUMBER(15,4);
iDocum              NUMBER(15,4);
sFec_Actual         VARCHAR2(10);

/* ********************************************************************************************* */
/*                          ARREGLO PARA COT_EXT_DOCUMENTOS                                          */
/* ********************************************************************************************* */
i BINARY_INTEGER := 0;
TYPE TipRegDocumentos IS RECORD (
        SEC_DOCUM			COT_EXT_DOCUMENTOS.SEC_DOCUM%TYPE,
        COD_CLIENTE			COT_EXT_DOCUMENTOS.COD_CLIENTE%TYPE,
        COD_TIPDOCUM		COT_EXT_DOCUMENTOS.COD_TIPDOCUM%TYPE,
        NUM_DOCUMENTO		COT_EXT_DOCUMENTOS.NUM_FOLIO%TYPE,
        SEC_CUOTA			COT_EXT_DOCUMENTOS.SEC_CUOTA%TYPE,
        IMP_DOCUMENTO		COT_EXT_DOCUMENTOS.IMP_DOCUMENTO%TYPE,
        IMP_INTER_MORA		COT_EXT_DOCUMENTOS.IMP_INTER_MORA%TYPE,
        SW					VARCHAR2(2));
TYPE TipTab_COT_EXT_DOCUM   IS TABLE  OF  TipRegDocumentos INDEX BY  BINARY_INTEGER;
Tab_CARGA_DOCUM        TipTab_COT_EXT_DOCUM;

/* ********************************************************************************************* */
/*                          ARREGLO PARA COT_EXT_FORMAS_PAGO                                         */
/* ********************************************************************************************* */
j BINARY_INTEGER := 0;
TYPE TipRegFormasPago IS RECORD (
        SEC_PAGO			COT_EXT_FORMAS_PAGO.SEC_PAGO%TYPE,
        TIP_VALOR			COT_EXT_FORMAS_PAGO.TIP_VALOR%TYPE,
        IMP_PAGO			COT_EXT_FORMAS_PAGO.IMP_PAGO%TYPE,
        NUM_DOCUMENTO		COT_EXT_FORMAS_PAGO.NUM_DOCUMENTO%TYPE,
        NUM_IDENT			COT_EXT_FORMAS_PAGO.NUM_IDENT%TYPE,
        IND_TITULAR			COT_EXT_FORMAS_PAGO.IND_TITULAR%TYPE,
        NUM_CTACTE			COT_EXT_FORMAS_PAGO.NUM_CTACTE%TYPE,
        COD_BANCO			COT_EXT_FORMAS_PAGO.COD_BANCO%TYPE,
        FEC_VENCIMIE		VARCHAR2(20),
        NUM_TARJETA			COT_EXT_FORMAS_PAGO.NUM_TARJETA%TYPE,
        COD_TARJETA			COT_EXT_FORMAS_PAGO.COD_TARJETA%TYPE,
        COD_AUTORIZACION	COT_EXT_FORMAS_PAGO.COD_AUTORIZA%TYPE);
TYPE TipTab_COT_EXT_FORMAS_PAGO   IS TABLE  OF  TipRegFormasPago INDEX BY  BINARY_INTEGER;
Tab_CARGA_FORMAS_PAGO        TipTab_COT_EXT_FORMAS_PAGO;

/* ********************************************************************************************* */
/*                          CURSOR PARA COT_EXT_RECAUDACION                                          */
/* ********************************************************************************************* */
CURSOR c_Recaudacion IS
SELECT  NUM_IDENT     , IMP_TOTAL   , TO_CHAR(FEC_PAGO,'DD-MM-YYYY HH24:MI:SS') AS FEC_PAGO,
		NUM_EJERCICIO , IND_RECHAZO , IND_PROCESADO
FROM    COT_EXT_RECAUDACION
WHERE   COD_ENTIDAD 	= vp_cod_entidad
AND     NUM_TRANSACCION = vp_num_transac
ORDER BY FEC_PAGO asc;

/* ********************************************************************************************* */
/*                          CURSOR PARA DOCUMENTOS                                               */
/* ********************************************************************************************* */
CURSOR c_Documentos IS
SELECT SEC_DOCUM , COD_CLIENTE   , COD_TIPDOCUM   , NUM_FOLIO,
	   SEC_CUOTA , IMP_DOCUMENTO , IMP_INTER_MORA , '' SW
FROM   COT_EXT_DOCUMENTOS
WHERE  COD_ENTIDAD     = vp_cod_entidad
AND    NUM_TRANSACCION = vp_num_transac
ORDER BY COD_TIPDOCUM, NUM_FOLIO, SEC_CUOTA asc;
/* ********************************************************************************************* */
/*                          CURSOR PARA COT_EXT_FORMAS_PAGO                                          */
/* ********************************************************************************************* */
CURSOR c_FormasPago IS
SELECT SEC_PAGO   ,  TIP_VALOR   , IMP_PAGO     , NUM_DOCUMENTO  , NUM_IDENT  , IND_TITULAR      ,
	   NUM_CTACTE ,  COD_BANCO   ,  TO_CHAR(FEC_VENCIMIE,'DD-MM-YYYY HH24:MI:SS') AS FEC_VENCIMIE,
	   NUM_TARJETA,  DECODE(COD_TARJETA,' ',NULL) AS COD_TARJETA, COD_AUTORIZA
FROM   COT_EXT_FORMAS_PAGO
WHERE  COD_ENTIDAD 	   = vp_cod_entidad
AND    NUM_TRANSACCION = vp_num_transac
ORDER BY NUM_DOCUMENTO, FEC_VENCIMIE asc;

ERROR_PROCESO EXCEPTION;
/* ********************************************************************************************* */
/*                               INICIO PROCESO                                                  */
/* ********************************************************************************************* */
BEGIN
 vp_gls_error := '';
 sNom_proceso :='CO_APLICA_PAGOS_NORMALES';
 /* ********************************************************************************************* */
 /*                          LEER TABLA CO_EMPRESA_REX                                            */
 /* ********************************************************************************************* */
 vp_gls_error := 'Select CO_EMPRESA_REX';
 SELECT A.COD_OFICINA, A.COD_CAJA, B.NOM_USUARORA
 INTO   vp_cod_oficina, vp_cod_caja , sNom_User
 FROM   CO_EMPRESAS_REX A, CO_CAJEROS B
 WHERE  A.EMP_RECAUDADORA = vp_cod_entidad
 AND    A.COD_OFICINA     = B.COD_OFICINA
 AND    A.COD_CAJA        = B.COD_CAJA;


 /* ********************************************************************************************* */
 /*                          LEER TABLA DE DATOS GENERALES                                        */
 /* ********************************************************************************************* */
 vp_gls_error := 'Select CO_DATGEN - GE_DATOSGENER.';
 SELECT A.DOC_PAGO	, A.DOC_COMPAGO , A.DOC_FACTCONTADO , A.CONCEP_PAG  , B.PROD_GENERAL
 INTO   sTipDocumPag , sDocumPago    , sDocFacturaCon    , sCodConcepto  , sCodProducto
 FROM   CO_DATGEN A  , GE_DATOSGENER B;

 /* ********************************************************************************************* */
 /*                          SECUENCIA DE PAGO Y COMPAGO                                          */
 /* ********************************************************************************************* */
 vp_gls_error := 'Select CO_SEQ_PAGO.NEXTVAL FROM DUAL.';
 SELECT CO_SEQ_PAGO.NEXTVAL
 INTO   vp_SecPago
 FROM   DUAL;

 vp_gls_error := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';
 SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal') ,
        Fn_Obtiene_PlazaCliente(vCodCliente)    ,
        TO_CHAR(SYSDATE,'DD-MM-YYYY')
 INTO   iDecimal									,
        sCod_PlazaAbono                            ,
        sFec_Actual
 FROM   DUAL;

 vp_gls_Error := 'SELECT COD_OPERADORA.';
 SELECT COD_OPERADORA
 INTO   sCod_OperadorAbono
 FROM   GE_CLIENTES
 WHERE  COD_CLIENTE = vCodCliente;


 vp_Gls_Error := 'SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN';
 SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(sTipDocumPag,NULL,vp_cod_oficina,sCod_OperadorAbono,NULL,NULL,NULL,SYSDATE,1)
 INTO   sPasoFolio
 FROM   DUAL;

 --Separa Datos entregados por la funcion anterior
 iPos1	 	      := INSTR(sPasoFolio,';',1);
 iPos2	 	   	  := LENGTH(sPasoFolio) - iPos1;
 sPasoFolio2	  := SUBSTR(sPasoFolio,iPos1 + 1, iPos2);
 iPos3			  := INSTR(sPasoFolio2,';',1);
 iPos4	 	   	  := LENGTH(sPasoFolio2)- iPos3;
 vp_SecCompago	  := SUBSTR(sPasoFolio2,iPos3 +1,iPos4);
 sPref_Plaza      := SUBSTR(sPasoFolio2,1,iPos3 - 1);


 /* ********************************************************************************************* */
 /*                          OBTENGO SECUENCIA                                                    */
 /* ********************************************************************************************* */
 vp_gls_error := 'Select COS_SEQ_MOVCAJA From Dual.';
 SELECT COS_SEQ_MOVCAJA.NEXTVAL
 INTO   nSecuencia
 FROM   DUAL ;

 FOR rReg IN c_Recaudacion LOOP
     sNUM_IDENT 		:= rReg.NUM_IDENT ;
 	 sIMP_TOTAL 		:= rReg.IMP_TOTAL ;
 	 sFEC_PAGO 			:= rReg.FEC_PAGO;
 	 sNUM_EJERCICIO 	:= rReg.NUM_EJERCICIO ;
 	 sIND_RECHAZO 		:= rReg.IND_RECHAZO ;
 	 sIND_PROCESADO 	:= rReg.IND_PROCESADO ;
 END LOOP;

 i:= 0;
 vp_gls_error := 'SELECT SUM(IMPORTE_DEBE) FROM CO_CARTERA';

 FOR rReg IN c_Documentos LOOP
     i:=i+1;

    SELECT SUM(IMPORTE_DEBE)-SUM(IMPORTE_HABER)
    INTO   nTotal
    FROM   CO_CARTERA
    WHERE  NUM_FOLIO     = rReg.NUM_FOLIO
    AND    COD_CLIENTE   = rReg.COD_CLIENTE
    AND    COD_TIPDOCUM  = rReg.COD_TIPDOCUM;

     IF  rReg.IMP_DOCUMENTO = nTotal THEN
         nTotal:=nTotal - rReg.IMP_DOCUMENTO ;
         Tab_CARGA_DOCUM(i).COD_CLIENTE		:= rReg.COD_CLIENTE;
         Tab_CARGA_DOCUM(i).COD_TIPDOCUM	:= rReg.COD_TIPDOCUM;
         Tab_CARGA_DOCUM(i).NUM_DOCUMENTO	:= rReg.NUM_FOLIO;
         Tab_CARGA_DOCUM(i).SEC_CUOTA		:= rReg.SEC_CUOTA;
         Tab_CARGA_DOCUM(i).IMP_DOCUMENTO	:= rReg.IMP_DOCUMENTO;
         Tab_CARGA_DOCUM(i).IMP_INTER_MORA	:= rReg.IMP_INTER_MORA;
         Tab_CARGA_DOCUM(i).SW				:='SI';
     ELSE
         IF rReg.IMP_DOCUMENTO < nTotal THEN
            Tab_CARGA_DOCUM(i).COD_CLIENTE		:= rReg.COD_CLIENTE;
            Tab_CARGA_DOCUM(i).COD_TIPDOCUM	:= rReg.COD_TIPDOCUM;
            Tab_CARGA_DOCUM(i).NUM_DOCUMENTO	:= rReg.NUM_FOLIO;
            Tab_CARGA_DOCUM(i).SEC_CUOTA		:= rReg.SEC_CUOTA;
            Tab_CARGA_DOCUM(i).IMP_INTER_MORA	:= rReg.IMP_INTER_MORA;
            Tab_CARGA_DOCUM(i).IMP_DOCUMENTO	:= rReg.IMP_DOCUMENTO;
            Tab_CARGA_DOCUM(i).SW				:='NO';
        ELSE
            v_sqlerrm:='Monto a Cancelar es menor que la Deuda. Folio :'||rReg.NUM_FOLIO||' Cliente : '||rReg.COD_CLIENTE||' '||vp_cod_entidad;
            RAISE ERROR_PROCESO;
        END IF;
     END IF;
 END LOOP;

 j:=0;
 iTotalImp:=0;
 FOR rReg IN c_FormasPago LOOP
     j:=j+1;
 	Tab_CARGA_FORMAS_PAGO(j).SEC_PAGO 			:= rReg.SEC_PAGO;
 	Tab_CARGA_FORMAS_PAGO(j).TIP_VALOR 			:= rReg.TIP_VALOR;
 	Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO 			:= rReg.IMP_PAGO;
 	Tab_CARGA_FORMAS_PAGO(j).NUM_DOCUMENTO 		:= rReg.NUM_DOCUMENTO;
 	Tab_CARGA_FORMAS_PAGO(j).NUM_IDENT 			:= rReg.NUM_IDENT;
 	Tab_CARGA_FORMAS_PAGO(j).IND_TITULAR 		:= rReg.IND_TITULAR;
 	Tab_CARGA_FORMAS_PAGO(j).NUM_CTACTE 		:= rReg.NUM_CTACTE;
 	Tab_CARGA_FORMAS_PAGO(j).COD_BANCO 			:= rReg.COD_BANCO;
 	Tab_CARGA_FORMAS_PAGO(j).FEC_VENCIMIE 		:= rReg.FEC_VENCIMIE;
 	Tab_CARGA_FORMAS_PAGO(j).NUM_TARJETA 		:= rReg.NUM_TARJETA;
 	Tab_CARGA_FORMAS_PAGO(j).COD_TARJETA 		:= rReg.COD_TARJETA;
 	Tab_CARGA_FORMAS_PAGO(j).COD_AUTORIZACION 	:= rReg.COD_AUTORIZA;
 	iTotalImp:=iTotalImp + Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO;
 END LOOP;

 vp_ruteo := 8;

 j:=Tab_CARGA_FORMAS_PAGO.LAST;
 IF j > 0 THEN

     FOR j IN Tab_CARGA_FORMAS_PAGO.FIRST .. Tab_CARGA_FORMAS_PAGO.LAST LOOP

        nSecuenciaAux := nSecuencia;
	    nSecuencia    := nSecuencia + 1;
 	    vp_gls_error := 'INSERT INTO CO_MOVIMIENTOSCAJA con Num_secumov : '||nSecuenciaAux||' Usuario : '||sNom_User||' Oficina : '||vp_cod_oficina||' Caja :'||vp_cod_caja;
 	    INSERT INTO CO_MOVIMIENTOSCAJA (
 	           COD_OFICINA    , COD_CAJA     , NUM_SECUMOV  , NUM_EJERCICIO  , FEC_EFECTIVIDAD    , NOM_USUARORA  ,
 	           TIP_MOVCAJA    , IND_DEPOSITO , IMPORTE      , IND_ERRONEO    , TIP_VALOR          , IND_CIERRE    ,
 	           COD_CLIENTE    , NUM_ABONADO  , COD_PRODUCTO , TIP_DOCUMENT   , COD_VENDEDOR_AGENTE, LETRA         ,
 	           COD_CENTREMI   , NUM_SECUENCI , LETRAC       , COD_CENTRC     , NUM_SECUC          , COD_BANCO     ,
 	           COD_SUCURSAL   , CTA_CORRIENTE, NUM_CHEQUE   , TIP_CLEARING   , FEC_CHEQUE         , COD_TIPTARJETA,
 	           NUM_TARJETA    , COD_AUTORIZA , NUM_CUPON    , NUM_CUOTAS     , FEC_CUPON          , COD_MOVILI    ,
 	           DES_MOVILI     , COD_RECOMPE  , NOM_CUSTODIA , NUM_IDENT      , NUM_ORDEN          , FEC_EMISION   ,
 	           FEC_VENCIMIENTO, COD_COBRADOR , NUM_INGMANUAL, NUM_RESPINGR   , NUM_COMPAGO        ,
 	           PREF_PLAZA     , COD_OPERADORA_SCL , COD_PLAZA )
 	    VALUES (vp_cod_oficina, vp_cod_caja  , nSecuenciaAux   , sNUM_EJERCICIO , TO_DATE(sFEC_PAGO,'DD-MM-YYYY HH24:MI:SS'),
 	           sNom_User , 6 , 0 , Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO, 0 ,  Tab_CARGA_FORMAS_PAGO(j).TIP_VALOR , 0 ,
 			   Tab_CARGA_DOCUM(1).COD_CLIENTE, NULL , NULL , sTipDocumPag , '100001', 'X', 1 , vp_SecPago, NULL , NULL , NULL ,
 			   Tab_CARGA_FORMAS_PAGO(j).COD_BANCO, NULL , Tab_CARGA_FORMAS_PAGO(j).NUM_CTACTE ,  Tab_CARGA_FORMAS_PAGO(j).NUM_DOCUMENTO ,
 			   NULL , SYSDATE , Tab_CARGA_FORMAS_PAGO(j).COD_TARJETA , Tab_CARGA_FORMAS_PAGO(j).NUM_TARJETA ,
 			   Tab_CARGA_FORMAS_PAGO(j).COD_AUTORIZACION , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL , NULL ,
 			   NULL , NULL , NULL , NULL, vp_SecCompago, sPref_Plaza,sCod_OperadorAbono,sCod_PlazaAbono);
     END LOOP;
 END IF;

 j:=Tab_CARGA_FORMAS_PAGO.LAST;
 IF j > 0 THEN
     FOR j IN Tab_CARGA_FORMAS_PAGO.FIRST .. Tab_CARGA_FORMAS_PAGO.LAST LOOP

         IF  Tab_CARGA_FORMAS_PAGO(j).TIP_VALOR=1 THEN    /* si es pesos*/

             vp_ruteo := 10;
             vp_gls_error := 'SELECT FROM CO_EFECCAJAS.';
             SELECT NVL(COUNT (*),0)
             INTO   sRow
             FROM   CO_EFECTIVO_CAJAS
             WHERE  COD_OFICINA = vp_cod_oficina
             AND    COD_CAJA    = vp_cod_caja
             AND    NUM_EJERCICIO = sNUM_EJERCICIO
             AND    COD_MONEDA  = '001';

             IF sRow > 0 THEN   /* si existe fila tenemos que actualizar*/
                 vp_ruteo := 11;
                 vp_gls_error := 'UPDATE CO_EFECTIVO_CAJAS.';
                 UPDATE CO_EFECTIVO_CAJAS SET
                        EFEC_CAMBIO = EFEC_CAMBIO + Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO
                 WHERE  COD_OFICINA = vp_cod_oficina
                 AND    COD_CAJA    = vp_cod_caja
                 AND    NUM_EJERCICIO = sNUM_EJERCICIO
                 AND    COD_MONEDA  = '001';
             ELSE    /* tenemos que insertar*/
                 vp_ruteo := 12;
                 vp_gls_error := 'INSERT INTO CO_EFECTIVO_CAJAS.';
                 INSERT INTO CO_EFECTIVO_CAJAS
                       (COD_OFICINA, COD_CAJA , NUM_EJERCICIO,COD_MONEDA,EFEC_EGRESO,EFEC_CAMBIO)
                 VALUES (vp_cod_oficina, vp_cod_caja, sNUM_EJERCICIO,'001',Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO,0);

             END IF;
         END IF;  -- si es pesos
     END LOOP;
 END IF;
 /* ********************************************************************************************* */
 /*                          INSERTAR EN CO_PAGOS                                                 */
 /* ********************************************************************************************* */

 vp_ruteo := 13;
 vp_gls_error := 'INSERT INTO CO_PAGOS.';
 INSERT INTO CO_PAGOS (
        COD_TIPDOCUM  , COD_VENDEDOR_AGENTE  , LETRA       , COD_CENTREMI  , NUM_SECUENCI   , COD_CLIENTE,
        IMP_PAGO      , FEC_EFECTIVIDAD      , COD_CAJA    , FEC_VALOR     , NOM_USUARORA   , COD_FORPAGO,
        COD_SISPAGO   , COD_ORIPAGO          , COD_CAUPAGO , COD_BANCO     , COD_TIPTARJETA , COD_SUCURSAL,
        CTA_CORRIENTE , NUM_TARJETA          , DES_PAGO    , NUM_COMPAGO   , PREF_PLAZA)
 VALUES (sTipDocumPag , 100001, 'X' , 1 , vp_SecPago , Tab_CARGA_DOCUM(1).COD_CLIENTE , iTotalImp ,
         SYSDATE , vp_cod_caja , TO_DATE(sFEC_PAGO,'DD-MM-YYYY HH24:MI:SS'),
         sNom_User , 0 , 3 , 1 , 1 , NULL , NULL , NULL , NULL , NULL , 'Pago Efectuado por Recaudadora : '||vp_cod_entidad,
         vp_SecCompago, sPref_Plaza);

 /* ********************************************************************************************* */
 /*                                   COMIENZA A PROCESAR                                         */
 /* ********************************************************************************************* */
 vp_cliente_exento:=0;
 vp_cliente_inmune:=0;

 i:=Tab_CARGA_DOCUM.LAST;
 IF i > 0 THEN --0
     FOR i IN Tab_CARGA_DOCUM.FIRST .. Tab_CARGA_DOCUM.LAST LOOP

         /* SACA LA SECUENCIA PARA POSTERIORMENTE LLAMAR A LAS PL CO_APLICA_PAGO_ENTERO O PARCIAL */
         vp_gls_error := 'BUSCA SECUENCIA EN CO CARTERA';

 		 vp_cliente_inmune:= Tab_CARGA_DOCUM(i).COD_CLIENTE;
 		 vp_cliente_inmune:= Tab_CARGA_DOCUM(i).COD_TIPDOCUM;
 		 vp_cliente_inmune:= Tab_CARGA_DOCUM(i).NUM_DOCUMENTO;

     	 SELECT UNIQUE NUM_SECUENCI , LETRA
         INTO   sSecuencia , sLetra
         FROM   CO_CARTERA
         WHERE  COD_CLIENTE  = Tab_CARGA_DOCUM(i).COD_CLIENTE
         AND    COD_TIPDOCUM = Tab_CARGA_DOCUM(i).COD_TIPDOCUM
         AND    NUM_FOLIO	 = Tab_CARGA_DOCUM(i).NUM_DOCUMENTO;

         Tab_CARGA_DOCUM(i).SEC_DOCUM := sSecuencia;

         vp_ruteo := 14;
         /*************** BUSCA CLIENTE EXENTO**************************/
         BEGIN
             vp_gls_error := 'Select COD_CLIENTE FROM CO_CLIESINTER.';
             vp_cliente_exento:=1;
             SELECT COD_CLIENTE
             INTO   vp_cliente_exento
             FROM   CO_CLIESINTER
             WHERE  COD_CLIENTE = Tab_CARGA_DOCUM(i).COD_CLIENTE
             AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
             AND    COD_EXENCION = 'SINTE';

             EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  vp_cliente_exento:=0;
         END;
         IF vp_cliente_exento = 0 then --1
             BEGIN
                 vp_ruteo := 15;
                 vp_cliente_inmune:=1;

                 vp_gls_error := 'SELECT COD_CLIENTE FROM CO_INMUNIDAD (1).';
                 SELECT COD_CLIENTE
                 INTO   vp_cliente_inmune
                 FROM   CO_INMUNIDAD
                 WHERE  COD_CLIENTE= Tab_CARGA_DOCUM(i).COD_CLIENTE
                 AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

                 EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      vp_cliente_inmune:=0;
             END;	/*cliente inmune sigue con el proximo*/

             IF vp_cliente_inmune = 0 THEN --2
                 IF Tab_CARGA_DOCUM(i).IMP_INTER_MORA > 0 THEN --3
                     BEGIN
                         vp_gls_error := 'SELECT GE_SEQ_CARGOS.NEXTVAL FROM DUAL.';
                         SELECT GE_SEQ_CARGOS.NEXTVAL
                         INTO   sSecCargo
                         FROM   DUAL;

                         vp_ruteo := 24;
                         vp_gls_error := 'LLAMADA A PL CO_GEN_CARGO.';
                         CO_GEN_CARGO(Tab_CARGA_DOCUM(i).COD_CLIENTE,'0','5678',Tab_CARGA_DOCUM(i).IMP_INTER_MORA,'001','5',sSecCargo);
                         vp_ruteo := 25;

                         vp_gls_error := 'SELECT cod_ciclfact FROM GE_CARGOS.';
                         SELECT cod_ciclfact
                         INTO   sCiclo
                         FROM   GE_CARGOS
                         WHERE  NUM_CARGO = sSecCargo;

                         vp_gls_error := 'INSERT INTO CO_INTERESAPLI';
                         INSERT INTO CO_INTERESAPLI (
                                NUM_SECUENCI , COD_TIPDOCUM  , COD_VENDEDOR_AGENTE , LETRA       , COD_CENTREMI ,
                                NUM_SECUREL  , COD_TIPDOCREL , COD_AGENTEREL       , LETRA_REL   , COD_CENTRREL ,
                                NUM_CARGO    , NUM_FOLIO     , SEC_CUOTA           , NUM_CUOTA   , IMP_DEUDA    ,
                                IMP_CARGO    , FACTOR_COBRO  , NUM_DIAS            , COD_CLIENTE ,
                                COD_CICLFACT , IND_FACTURADO)
                         VALUES (vp_SecPago , sTipDocumPag , '100001', 'X' , 1 , Tab_CARGA_DOCUM(i).SEC_DOCUM ,
                                 Tab_CARGA_DOCUM(i).COD_TIPDOCUM , '100001', 'X' , 1 , sSecCargo , Tab_CARGA_DOCUM(i).NUM_DOCUMENTO,
                                 1 , 1 ,  Tab_CARGA_DOCUM(i).IMP_DOCUMENTO , Tab_CARGA_DOCUM(i).IMP_INTER_MORA , 1 , 1 ,
                                 Tab_CARGA_DOCUM(i).COD_CLIENTE , sCiclo , NULL);
                     END;
                 END IF;--3
         		 vp_ruteo := 26;

                 IF Tab_CARGA_DOCUM(i).SW='SI' THEN /* PAGO ENTERO*/
         		   BEGIN
         		        vp_gls_error := 'LLAMADA A PL CO_P_PAGO_ENTERO (1).';
         		        CO_P_PAGO_ENTERO(Tab_CARGA_DOCUM(i).COD_CLIENTE , sSecuencia, Tab_CARGA_DOCUM(i).COD_TIPDOCUM,
         		                       '100001' , sLetra ,'1' , vp_SecPago , sTipDocumPag , '100001' , 'X' ,'1' , 0 , sFEC_PAGO);
         		   END;
                 ELSE
         		   BEGIN
         		       vp_gls_error := 'LLAMADA A PL CO_P_PAGO_PARCIALES_FACTURA (1).';
         		       CO_P_PAGO_PARCIALES_FACTURA( Tab_CARGA_DOCUM(i).COD_CLIENTE , sSecuencia, Tab_CARGA_DOCUM(i).COD_TIPDOCUM ,
         			                                '100001' , sLetra , '1' , vp_SecPago , sTipDocumPag , '100001' , 'X' , '1' ,
         			                                Tab_CARGA_DOCUM(i).IMP_DOCUMENTO , 0 ,sFEC_PAGO);
         		   END;
                 END IF;

             ELSE  /* si no encuentra inmune igual se va al pago entero*/
                 vp_ruteo := 59;
                 IF Tab_CARGA_DOCUM(i).SW='SI' THEN /* pago entero*/
             	   BEGIN
                 	  vp_gls_error := 'LLAMADA A PL CO_P_PAGO_ENTERO(2).';
                      CO_P_PAGO_ENTERO( Tab_CARGA_DOCUM(i).COD_CLIENTE , sSecuencia , Tab_CARGA_DOCUM(i).COD_TIPDOCUM ,
                 	                    '100001' , sLetra , '1' , vp_SecPago , sTipDocumPag , '100001' , 'X' , '1' , 0, sFEC_PAGO);
             	   END;
                 ELSE
             	   BEGIN
                        vp_gls_error := 'LLAMADA A PL CO_P_PAGO_PARCIALES_FACTURA(2).';
                        CO_P_PAGO_PARCIALES_FACTURA( Tab_CARGA_DOCUM(i).COD_CLIENTE , sSecuencia , Tab_CARGA_DOCUM(i).COD_TIPDOCUM ,
                 	                                '100001' , sLetra , '1' , vp_SecPago , sTipDocumPag , '100001' , 'X' , '1' ,
                 	                                Tab_CARGA_DOCUM(i).IMP_DOCUMENTO , 0 , sFEC_PAGO);
             	   END;
                 END IF;
             END IF;	--2
         END IF;	--1
     END LOOP;
 END IF;

 /* ********************************************************************************************* */
 /*                          REGISTRAR CHEQUE                                                     */
 /* ********************************************************************************************* */
 j:=Tab_CARGA_FORMAS_PAGO.LAST;
 x:=1;
 SW:=1;
 iAcumula:=0;
 iFaltante:=0;
 iSaldo:=0;
 IF j > 0 THEN --5
     FOR j IN Tab_CARGA_FORMAS_PAGO.FIRST .. Tab_CARGA_FORMAS_PAGO.LAST LOOP
         IF Tab_CARGA_FORMAS_PAGO(j).TIP_VALOR =4 OR Tab_CARGA_FORMAS_PAGO(j).TIP_VALOR =2 THEN --6
             BEGIN
               	 vp_gls_error := 'SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL FROM DUAL.';
                 SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL
                 INTO   sNumSecueChe
                 FROM   DUAL;

                 vp_gls_error := 'INSERT INTO CO_DOCUMENTOS.';
                 INSERT INTO CO_DOCUMENTOS (
                        NUM_SECUENCI   , COD_TIPDOCUM     , NUM_SEC_CUOTA     , COD_TIPVALOR      , NUM_CONVENIO  ,
                        NUM_DOCUMENTO  , COD_OFICINA      , COD_CAJA          , NUM_SECUMOV       , COD_BANCO     ,
                        COD_SUCURSAL   , COD_PLAZA        , CTA_CORRIENTE     , COD_AUTORIZACION  , IND_TITULAR   ,
                        NUM_IDENT      , IMPORTE_DOCUM    , FECHA_VENCTO      , FECHA_DEPOSITO    , NUN_DEPOSITO	 ,
                        COD_BANCO_DEPO , COD_SUCURSAL_DEPO, COD_PLAZA_DEPO    , CTA_CORRIENTE_DEPO, COD_ESTADO    ,
                        COD_PROTESTO   , COD_UBICACION    , FEC_ULT_MOVIMIENTO, NOM_USUARIO,COD_OPERADORA_SCL,COD_PLAZA_OP )
                 VALUES (sNumSecueChe, 59 , 1 , Tab_CARGA_FORMAS_PAGO(j).TIP_VALOR , NULL ,
                        Tab_CARGA_FORMAS_PAGO(j).NUM_DOCUMENTO , vp_cod_oficina , vp_cod_caja   , nSecuencia ,
                        Tab_CARGA_FORMAS_PAGO(j).COD_BANCO , NULL , NULL , Tab_CARGA_FORMAS_PAGO(j).NUM_CTACTE	,
                        NULL, '1' , sNUM_IDENT , Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO , SYSDATE , NULL , NULL , NULL ,
                        NULL , NULL , NULL , '1' , NULL , '1' , SYSDATE , sNom_User,sCod_OperadorAbono,sCod_PlazaAbono);

                 i:=	Tab_CARGA_DOCUM.LAST;
                 IF i>0 THEN
                     i:=x;
 					 iCheque:=Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO;
                     sNumSecuenciaDet:= 0;

                     LOOP
                         EXIT WHEN i > Tab_CARGA_DOCUM.LAST;

                     	 iDocum:=Tab_CARGA_DOCUM(i).IMP_DOCUMENTO;
                         sNumSecuenciaDet:= sNumSecuenciaDet + 1;

                         IF ((iAcumula+iDocum) < iCheque) AND (SW=1) THEN
                            BEGIN
                                INSERT INTO CO_DET_DOCUMENTOS (
                                       NUM_SECUENCI , NUM_DOCUMENTO , NUM_SECUENCI_DOC , COD_CLIENTE , NUM_SECUENCI_PAGO ,
                                       NUM_SECUENCI_CA , COD_TIPDOCUM_CA , COD_VEND_AGENTE_CA , LETRA_CA , NUM_FOLIO_CA  ,
                                       NUM_CUOTA_CA	  , SEC_CUOTA_CA    , IMPORTE_CA, PREF_PLAZA)
                                VALUES (sNumSecuenciaDet , Tab_CARGA_FORMAS_PAGO(j).NUM_DOCUMENTO , sNumSecueChe  ,
                                       Tab_CARGA_DOCUM(i).COD_CLIENTE , vp_SecPago , Tab_CARGA_DOCUM(i).SEC_DOCUM ,
                                       Tab_CARGA_DOCUM(i).COD_TIPDOCUM , '100001',  'X'  ,
                                       Tab_CARGA_DOCUM(i).NUM_DOCUMENTO , 0 , 0 , iDocum, sPref_Plaza);

                                iAcumula:=iAcumula+iDocum;
 						    END;
                         ELSIF SW != 3 THEN
                               SW:=2;
                         END IF;

                         IF SW=2 THEN
                            BEGIN
 						   iFaltante:= iCheque - iAcumula;
                            INSERT INTO CO_DET_DOCUMENTOS (
                                   NUM_SECUENCI , NUM_DOCUMENTO , NUM_SECUENCI_DOC , COD_CLIENTE , NUM_SECUENCI_PAGO ,
                                   NUM_SECUENCI_CA , COD_TIPDOCUM_CA , COD_VEND_AGENTE_CA , LETRA_CA  , NUM_FOLIO_CA ,
                                   NUM_CUOTA_CA	  , SEC_CUOTA_CA    , IMPORTE_CA, PREF_PLAZA)
                            VALUES (sNumSecuenciaDet , Tab_CARGA_FORMAS_PAGO(j).NUM_DOCUMENTO , sNumSecueChe ,
                                   Tab_CARGA_DOCUM(i).COD_CLIENTE , vp_SecPago , Tab_CARGA_DOCUM(i).SEC_DOCUM ,
                                   Tab_CARGA_DOCUM(i).COD_TIPDOCUM , '100001',  'X',
                                   Tab_CARGA_DOCUM(i).NUM_DOCUMENTO , 0 , 0 , iFaltante, sPref_Plaza);

                            iAcumula:=iAcumula + iFaltante;
                            iSaldo:= iDocum - iFaltante;
                            SW:=3; x:=i;
                            EXIT;
 						   END;
                         ELSIF SW=3 THEN
                            BEGIN
                                IF (iSaldo > 0) THEN
                                    BEGIN
     							   INSERT INTO CO_DET_DOCUMENTOS (
                                           NUM_SECUENCI , NUM_DOCUMENTO , NUM_SECUENCI_DOC , COD_CLIENTE , NUM_SECUENCI_PAGO ,
                                           NUM_SECUENCI_CA , COD_TIPDOCUM_CA , COD_VEND_AGENTE_CA , LETRA_CA , NUM_FOLIO_CA  ,
                                           NUM_CUOTA_CA	  , SEC_CUOTA_CA    , IMPORTE_CA, PREf_PLAZA)
                                    VALUES (sNumSecuenciaDet , Tab_CARGA_FORMAS_PAGO(j).NUM_DOCUMENTO , sNumSecueChe  ,
                                           Tab_CARGA_DOCUM(i).COD_CLIENTE , vp_SecPago , Tab_CARGA_DOCUM(i).SEC_DOCUM ,
                                           Tab_CARGA_DOCUM(i).COD_TIPDOCUM , '100001',  'X'  ,
                                           Tab_CARGA_DOCUM(i).NUM_DOCUMENTO , 0 , 0 , iSaldo, sPref_Plaza);
                                    END;
                                END IF;
                                iAcumula:=0; iFaltante:=0; iSaldo:=0; SW:=1;
 						   END;
                         END IF;

                         i:=i+1;
                	    END LOOP;
                 END IF;
                 /***********************CO_SECARTERA****************************/
                 BEGIN
                     vp_gls_error := 'SELECT  COLUMNA FROM CO_SECARTERA.'   	;
                     SELECT COLUMNA
                     INTO   dNumColumna
                     FROM   CO_SECARTERA
                     WHERE  COD_TIPDOCUM= '59'
                     AND    COD_VENDEDOR_AGENTE = '100001'
                     AND    LETRA = 'X'
                     AND    COD_CENTREMI = '1'
                     AND    NUM_SECUENCI = sNumSecueChe
                     AND    COD_CONCEPTO = sCodConcepto;
                 EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                     dNumColumna:=0;
                 END;

                 IF dNumColumna = 9999 Then
                    dNumAuxColumna := 1;
                 ELSE
                    dNumAuxColumna := dNumColumna + 1;
                 END IF;

                 IF (dNumColumna>0) THEN
                     BEGIN
                         vp_gls_error := 'UPDATE CO_	SECARTERA.';
                         UPDATE CO_SECARTERA SET
                                COLUMNA = dNumAuxColumna
                         WHERE  COD_TIPDOCUM = '59'
                         AND    COD_VENDEDOR_AGENTE = '100001'
                         AND    LETRA        = 'X'
                         AND    COD_CENTREMI = 1
                         AND    NUM_SECUENCI = sNumSecueChe
                         AND    COD_CONCEPTO = sCodConcepto;
                     END;
                 ELSE
                     BEGIN
                         vp_gls_error := 'INSERT INTO CO_SECARTERA.';
                         INSERT INTO CO_SECARTERA (
                                COD_TIPDOCUM , COD_VENDEDOR_AGENTE ,  LETRA , COD_CENTREMI , NUM_SECUENCI , COD_CONCEPTO , COLUMNA)
                         VALUES('59' , '100001' , 'X' , 1 , sNumSecueChe , sCodConcepto , 1 );
                     END;
                 END IF;

              	vp_gls_error := 'INSERT INTO CO_CARTERA.';
                 INSERT INTO CO_CARTERA (
                         COD_CLIENTE    , COD_TIPDOCUM  , COD_CENTREMI , NUM_SECUENCI   , COD_VENDEDOR_AGENTE ,
                         LETRA          , COD_CONCEPTO  , COLUMNA      , COD_PRODUCTO   , IMPORTE_DEBE        ,
                         IMPORTE_HABER  , IND_CONTADO   , IND_FACTURADO, FEC_EFECTIVIDAD, FEC_VENCIMIE        ,
                         FEC_CADUCIDA   , FEC_ANTIGUEDAD, FEC_PAGO     , NUM_ABONADO    , NUM_FOLIO           ,
                         NUM_CUOTA      , SEC_CUOTA     , NUM_FOLIOCTC , NUM_VENTA      ,
                         PREF_PLAZA     , COD_OPERADORA_SCL, COD_PLAZA )
                 VALUES (Tab_CARGA_DOCUM(1).COD_CLIENTE , 59 , 1 , sNumSecueChe , '100001' , 'X' , sCodConcepto ,
                         dNumColumna  , sCodProducto ,  Tab_CARGA_FORMAS_PAGO(j).IMP_PAGO , 0 , 0 , 1 , SYSDATE ,
                         TO_DATE(Tab_CARGA_FORMAS_PAGO(j).FEC_VENCIMIE,'DD-MM-YYYY HH24:MI:SS') , SYSDATE ,
 						 SYSDATE , SYSDATE , 0 , Tab_CARGA_FORMAS_PAGO(j).NUM_DOCUMENTO , 1 , 1 , NULL , NULL,
 						 sPref_Plaza,sCod_OperadorAbono,sCod_PlazaAbono);
             END;
         END IF;--6
     END LOOP;
 END IF; --5

 vp_Ind_Retorno := 0 ;
 vp_Glosa_Error := 'OK';
 COMMIT;

EXCEPTION
    WHEN ERROR_PROCESO THEN
        ROLLBACK;
        v_sqlcode := SQLCODE;
        vp_Ind_Retorno := 100;
        vp_Glosa_Error := 'Error en : ' || vp_gls_error;
        INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
        VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_gls_error, v_sqlerrm);
        COMMIT;
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        v_sqlerrm := 'No Existen Datos - ' || sqlerrm;
        v_sqlcode := SQLCODE;
        vp_Ind_Retorno := 100;
        vp_Glosa_Error := 'Error en : ' || vp_gls_error;
        INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
        VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_gls_error, v_sqlerrm);
        COMMIT;
    WHEN OTHERS THEN
        ROLLBACK;
        v_sqlerrm := 'Otros Errores - ' || sqlerrm;
        v_sqlcode := SQLCODE;
        vp_Ind_Retorno := 1;
        vp_Glosa_Error := 'Error en : ' || vp_gls_error;
        INSERT INTO CO_TRANSAC_ERROR (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,DESC_SQL,DESC_CADENA)
        VALUES (sNom_proceso, v_sqlcode, SYSDATE,vp_gls_error, v_sqlerrm);
        COMMIT;
END CO_APLICA_PAGOS_NORMALES;
/
SHOW ERRORS
