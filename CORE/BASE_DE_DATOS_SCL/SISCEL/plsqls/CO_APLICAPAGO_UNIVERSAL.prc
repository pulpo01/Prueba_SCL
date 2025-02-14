CREATE OR REPLACE PROCEDURE CO_APLICAPAGO_UNIVERSAL
(
vp_Modulo_Usado			IN VARCHAR2             ,	                            --ALL
vp_Cod_cliente			IN NUMBER               ,	                            --ALL
vp_Imp_pago				IN NUMBER               ,	                            --ALL
vp_Fecha_efec			IN VARCHAR2             ,	                            --ALL
vp_Cod_banco			IN VARCHAR2             ,	                            --PNT PEX TEC PAC CAJ
vp_OriPago				IN NUMBER               ,	                            --TEC COV REB RED REA PAC CAJ
vp_CauPago				IN NUMBER               ,	                            --TEC COV REB RED REA PAC CAJ
vp_Emp_recauda			IN VARCHAR2             ,	                            --PNT PEX TEC COV PAC CAJ
vp_Oficina				IN VARCHAR2             ,	                            --TEC PAC CAJ
vp_Cod_servicio			IN NUMBER               ,	                            --PNT PEX
vp_Num_celular			IN NUMBER               ,	                            --PNT PEX
vp_CtaCte				IN VARCHAR2             ,	                            --PNT PEX CAJ
vp_Num_transac			IN NUMBER               ,	                            --PEX TEC COV REB RED REA CAJ
vp_Cod_Recext			IN NUMBER               ,	                            --PEX TEC
vp_folioCTC				IN VARCHAR2             ,	                            --PNT TEC
vp_num_ejer				IN VARCHAR2             ,	                            --PNT CAJ
vp_tip_valor			IN NUMBER               ,	                            --PNT
vp_num_docum			IN NUMBER               ,	                            --PNT CAJ
vp_caja					IN NUMBER               ,	                            --PNT RED CAJ
vp_transaccion			IN NUMBER               ,	                            --PNT REB RED REA COV
vp_num_tarjeta			IN VARCHAR2             ,	                            --PNT CAJ
vp_num_folio			IN VARCHAR2             ,	                            --TEC COV REB RED REA CAJ
vp_sw_doc				IN VARCHAR2             ,	                            --ALL
vp_fec_diferido			IN VARCHAR2             ,	                            --CAJ
vp_sw_copago			IN VARCHAR2             ,	                            --ALL
vp_sw_tpago             IN VARCHAR2             ,	                            --COV RED
vp_num_secuenci_ca      IN VARCHAR2             ,	                            --COV REB RED REA CAJ
vp_cod_tipdocum_ca      IN VARCHAR2             ,	                            --COV REB RED REA
vp_cod_vend_agente_ca   IN VARCHAR2             ,	                            --COV RED
vp_letra_ca             IN VARCHAR2             ,	                            --COV RED
vp_sec_cuota_ca         IN VARCHAR2             ,	                            --COV RED CAJ
vp_importe_ca           IN VARCHAR2             ,	                            --COV REB RED REA CAJ
vp_Secu_Compago			OUT NOCOPY     NUMBER   ,  	                            --ALL
vp_Pref_Plaza			IN  OUT NOCOPY VARCHAR2 ,  	                            --ALL (COV,RED,CAJ -> IN)
vp_OutGlosa				OUT NOCOPY     VARCHAR2 , 	                            --ALL
vp_OutRetorno			OUT NOCOPY     NUMBER   ,	                            --ALL
vp_codtiptarjeta		IN CO_MOVIMIENTOSCAJA.COD_TIPTARJETA%TYPE   DEFAULT NULL, --PNT
vp_codautoriza          IN CO_INTERFAZ_PAGOS.COD_AUTORIZA%TYPE      DEFAULT NULL, --PNT
vp_num_folio_doc        IN CO_INTERFAZ_EXTERNA.NUM_FOLIO_DOC%TYPE   DEFAULT 0,    --PEX MIX-09003 17.02.2010  
vp_pref_plaza_doc       IN CO_INTERFAZ_EXTERNA.PREF_PLAZA_DOC%TYPE  DEFAULT NULL, --PEX MIX-09003 17.02.2010  
vp_fecha_pago           IN VARCHAR2                                 DEFAULT NULL  --PEX Incidencia 129515 09.04.2010 
) IS

/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "Co_Aplicapago_Universal" Lenguaje="PL/SQL" Fecha="dd-mm-yyyy" Versión="1.0.1" Diseñador="THALES" Programador="THALES" Ambiente="BD NN">
<Modificación = 18.02.2010 Nueva Versión="2.0" INC="MIX-09003 MQG">
<Modificación = 09.04.2010 Nueva Versión="2.1" INC="129515 MQG">

<Retorno>NA</Retorno>
<Descripción>Proceso que realiza pagos provenientes de distintos modulos</Descripción>
<Parámetros>
<Entrada>
<param nom="vp_Modulo_Usado"    	Tipo="STRING"> Codigo de modulo procedencia del pago </param>
<param nom="vp_Cod_cliente"     	Tipo="INTEGER">Codigo del cliente </param>
<param nom="vp_Imp_pago"     		Tipo="INTEGER">Importe del pago </param>
<param nom="vp_Fecha_efec"     		Tipo="STRING"> Fecha de Efectividad </param>
<param nom="vp_Cod_banco"     		Tipo="STRING"> Codigo del Banco </param>
<param nom="vp_OriPago"     		Tipo="INTEGER">Origen del pago </param>
<param nom="vp_CauPago"     		Tipo="INTEGER">Causa del pago </param>
<param nom="vp_Emp_recauda"    		Tipo="STRING"> Empresa recaudadora </param>
<param nom="vp_Oficina"    			Tipo="STRING"> Codigo de Oficina </param>
<param nom="vp_Cod_servicio"		Tipo="INTEGER">Codigo de Servicio </param>
<param nom="vp_Num_celular"			Tipo="INTEGER">Numero de celular </param>
<param nom="vp_CtaCte"				Tipo="STRING"> Numero de cuenta corriente </param>
<param nom="vp_Num_transac"			Tipo="INTEGER">Numero de transaccion </param>
<param nom="vp_Cod_Recext"			Tipo="INTEGER">Codigo de empresa de recaudacion externa </param>
<param nom="vp_folioCTC"			Tipo="STRING"> Numero de folio </param>
<param nom="vp_num_ejer"			Tipo="STRING"> Numero de ejercicio </param>
<param nom="vp_tip_valor"			Tipo="INTEGER">Tipo de valor </param>
<param nom="vp_num_docum"			Tipo="INTEGER">Numero de documento </param>
<param nom="vp_caja"				Tipo="INTEGER">Codigo de caja </param>
<param nom="vp_transaccion"			Tipo="INTEGER">Numero de transaccion </param>
<param nom="vp_num_tarjeta"			Tipo="STRING"> Numero de tarjeta </param>
<param nom="vp_num_folio"			Tipo="STRING"> Numero de folio </param>
<param nom="vp_sw_doc"				Tipo="STRING"> Flag de documento </param>
<param nom="vp_fec_diferido"		Tipo="STRING"> Fecha de pago diferido </param>
<param nom="vp_sw_copago"			Tipo="STRING"> Flag de pago </param>
<param nom="vp_sw_tpago"			Tipo="STRING"> Flag de tipo de pago </param>
<param nom="vp_num_secuenci_ca" 	Tipo="STRING"> Numero de secuencia de cartera</param>
<param nom="vp_cod_tipdocum_ca" 	Tipo="STRING"> Codigo del documento de cartera</param>
<param nom="vp_cod_vend_agente_ca" 	Tipo="STRING">Codigo de vendedor de cartera</param>
<param nom="vp_letra_ca" 			Tipo="STRING"> Codigo de letra de cartera</param>
<param nom="vp_sec_cuota_ca" 		Tipo="STRING"> Secuencia de cuota de cartera</param>
<param nom="vp_num_folio_doc" 		Tipo="NUMBER"> Numero del documento a cancelar</param>
<param nom="vp_pref_plaza_doc" 	    Tipo="STRING"> Prefijo plaza del documento a cancelar</param>
<param nom="vp_fecha_pago"   	    Tipo="STRING"> Fecha de pago</param>
<Entrada>
<Salida>
<param nom="vp_Secu_Compago" 		Tipo="NUMBER"> Numero de comprobante de pago</param>
<param nom="vp_Pref_Plaza" 			Tipo="STRING"> Prefijo de plaza</param>
<param nom="vp_OutGlosa" 			Tipo="STRING"> Glosa de retorno</param>
<param nom="vp_OutRetorno" 	  		Tipo="NUMBER"> Valor de retorno</param>
</Entrada>
<Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

sDesc_empresa			CED_EMPRESAS.DES_EMPRESA%TYPE;
sNomCajero              CO_ACCECLI.NOM_USUARORA%TYPE;
sNom_User               CO_CAJEROS.NOM_USUARORA%TYPE;
dNumColumna             CO_CARTERA.COLUMNA%TYPE;
dNumAuxColumna          CO_CARTERA.COLUMNA%TYPE;
lPref_Plaza             CO_CARTERA.PREF_PLAZA%TYPE;
lNum_Folio              CO_CARTERA.NUM_FOLIO%TYPE;
lPref_Plaza2            CO_CARTERA.PREF_PLAZA%TYPE;
iInd_facturado          CO_CARTERA.IND_FACTURADO%TYPE;
iCod_Tipdocum           CO_CARTERA.COD_TIPDOCUM%TYPE;
iTipDocAnt              CO_CARTERA.COD_TIPDOCUM%TYPE;
iVendAgenAnt            CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE;
sLetraAnt               CO_CARTERA.LETRA%TYPE;
iCodCentAnt             CO_CARTERA.COD_CENTREMI%TYPE;
lNumSecAnt              CO_CARTERA.NUM_SECUENCI%TYPE;
lNumFolioAnt            CO_CARTERA.NUM_FOLIO%TYPE;
lNumPrefijo_PlazaAnt    CO_CARTERA.PREF_PLAZA%TYPE;
iSecCuotAnt             CO_CARTERA.SEC_CUOTA%TYPE;
iCodConcepto            CO_CARTERA.COD_CONCEPTO%TYPE;
iCod_DocumPL            CO_CARTERA.COD_TIPDOCUM%TYPE;
lNumSecuenPL            CO_CARTERA.NUM_SECUENCI%TYPE;
lNumFolioPL             CO_CARTERA.NUM_FOLIO%TYPE;
lNumPrefijo_PlazaPL     CO_CARTERA.PREF_PLAZA%TYPE;
dMonto_PL              	CO_CARTERA.IMPORTE_DEBE%TYPE;
iSec_CuotaPL            CO_CARTERA.SEC_CUOTA%TYPE;
dMon_deuda              CO_CARTERA.IMPORTE_DEBE%TYPE;
dMonto_carrier          CO_CARTERA.IMPORTE_DEBE%TYPE;
dMontoInteresAcum       CO_CARTERA.IMPORTE_DEBE%TYPE;
dSaldoAux               CO_CARTERA.IMPORTE_DEBE%TYPE;
sCod_OperadorAbono      CO_CARTERA.COD_OPERADORA_SCL%TYPE;
sCod_PlazaAbono         CO_CARTERA.COD_PLAZA%TYPE;
hCodCentremi			CO_CARTERA.COD_CENTREMI%TYPE;
idoc_pago_aux			CO_CARTERA.COD_TIPDOCUM%TYPE;
v_folio_ctc             CO_CARTERA.NUM_FOLIOCTC%TYPE;
sNumSecuenciaDet        CO_DET_DOCUMENTOS.NUM_SECUENCI%TYPE;
sNumSecueChe            CO_DOCUMENTOS.NUM_SECUENCI%TYPE;
lCliente_exento         CO_CLIESINTER.COD_CLIENTE%TYPE;
sCod_Entidad            CO_COBEXTERNA.COD_ENTIDAD%TYPE;
lCliente_CobExterna     CO_COBEXTERNADOC.COD_CLIENTE%TYPE;
sIdentExterna           CO_COBEXTERNADOC.NUM_IDENT%TYPE;
sCodTipIdent            CO_COBEXTERNADOC.COD_TIPIDENT%TYPE;
iDocumPago              CO_DATGEN.DOC_COMPAGO%TYPE;
iDoc_Pago               CO_DATGEN.DOC_PAGO%TYPE;
iDoc_Factcontado        CO_DATGEN.DOC_FACTCONTADO%TYPE;
iConcep_Pag             CO_DATGEN.CONCEP_PAG%TYPE;
iAgenteInterno          CO_DATGEN.AGENTE_INTERNO%TYPE;
sLetraCobros            CO_DATGEN.LETRA_COBROS%TYPE;
sCod_Oficina            CO_EMPRESAS_REX.COD_OFICINA%TYPE;
vp_Cod_Oficina          CO_EMPRESAS_REX.COD_OFICINA%TYPE;
sCod_Operadora			CO_EMPRESAS_REX.COD_OPERADORA_SCL%TYPE;
lCliente_inmune         CO_INMUNIDAD.COD_CLIENTE%TYPE;
dFactor_int             CO_INTERESES.FACTOR_INT%TYPE;
iFactor_dia             CO_INTERESES.FACTOR_DIA%TYPE;
sInd_fec                CO_INTERESES.IND_FEC_COBRO%TYPE;
iDias_aplica            CO_INTERESES.DIAS_APLICACION%TYPE;
dImp_Cargo              CO_INTERESAPLI.IMP_CARGO%TYPE;
idiasint                CO_INTERESAPLI.NUM_DIAS%TYPE;
dFac_cobro              CO_INTERESAPLI.FACTOR_COBRO%TYPE;
iCod_Vendedor_Agente	CO_INTERESAPLI.COD_VENDEDOR_AGENTE%TYPE;
nSecuencia              CO_MOVIMIENTOSCAJA.NUM_SECUMOV%TYPE;
lSecCompago				CO_PAGOS.NUM_COMPAGO%TYPE;
lSec_Pago               CO_PAGOS.NUM_SECUENCI%TYPE;
iCodTipDocum            CO_PAGOS.COD_TIPDOCUM%TYPE;
iCodCentremi            CO_PAGOS.COD_CENTREMI%TYPE;
iNumSecuenci           	CO_PAGOS.NUM_SECUENCI%TYPE;
iCodVendedorAgente      CO_PAGOS.COD_VENDEDOR_AGENTE%TYPE;
sLetra                  CO_PAGOS.LETRA%TYPE;
hNumRegularizacion		CO_PAGO_DOC_REGULARIZA.NUM_REGULARIZA%TYPE;
lNumSecuenciCon         CO_SECARTERA.NUM_SECUENCI%TYPE;
iNumColumna             CO_SECARTERA.COLUMNA%TYPE;
sCod_Moneda             CO_TIPVALOR.COD_MONEDA%TYPE;
lSecuTransac1           CO_TRANSACINT.NUM_TRANSACCION%TYPE;
lSecuTransac2           CO_TRANSACINTER.NUM_TRANSACCION%TYPE;
iRetorno                CO_TRANSACINTER.COD_RETORNO%TYPE;
dMto_interes            CO_TRANSACINTER.MTO_INTERES%TYPE;
sNom_proceso            CO_TRANSAC_ERROR.NOM_PROCESO%TYPE;
lCod_cliente            GA_ABOCEL.COD_CLIENTE%TYPE;
sNumIdent				GE_CLIENTES.NUM_IDENT%TYPE;
sCod_tipident           GE_CLIENTES.COD_TIPIDENT%TYPE;
lSecCargo               GE_CARGOS.NUM_CARGO%TYPE;
iCiclo_Fact             GE_CARGOS.COD_CICLFACT%TYPE;
sCodProducto            GE_DATOSGENER.PROD_GENERAL%TYPE;
sConcepto_Mora          GED_PARAMETROS.VAL_PARAMETRO%TYPE;
sConcepto_Cobranza		GED_PARAMETROS.VAL_PARAMETRO%TYPE;
szVal_Param             GED_PARAMETROS.VAL_PARAMETRO%TYPE;
lNum_Transaccion        GA_TRANSACABO.NUM_TRANSACCION%TYPE; /* MIX-09003 25.02.2010 */

CLIENTE_BLOQUEADO       EXCEPTION;
ERROR_PROCESO			EXCEPTION;
ERROR_CALC_COMISIONES   EXCEPTION;

/* VARIABLES AUXILIARES */
fec_pnt         		 DATE;
vp_num_docum_pnt		 NUMBER;
vp_imp_pago_aux			 NUMBER;
vind_pago				 NUMBER(1);
vaux_num_cuota			 NUMBER(8);
vaux_sec_cuota			 NUMBER(3);
vaux_num_venta			 NUMBER(8);
vp_retorno				 NUMBER;
sRow                     NUMBER(4);
iDecimal                 NUMBER(2);
bValidaCliente			 NUMBER(1);
noEncontro               NUMBER(1);
vRetorno                 NUMBER(10);
dTotal_pago              NUMBER(14,4);
dSaldo                 	 NUMBER(14,4);
iDifFecha                NUMBER(8);
iPos1                    NUMBER(5);
iPos2                    NUMBER(5);
iPos3                    NUMBER(5);
iPos4                    NUMBER(5);
iPos5                    NUMBER(5);
vp_oripago_aux           NUMBER;
vp_caupago_aux           NUMBER;
sFormatoFecha			 VARCHAR2(20);
iCod_caja                VARCHAR2(4);
vp_num_tarjeta_aux_pnt   VARCHAR2(20);
vp_codtiptarjeta_aux_pnt CO_MOVIMIENTOSCAJA.COD_TIPTARJETA%TYPE;
vp_codautoriza_aux_pnt   co_interfaz_pagos.cod_autoriza%TYPE;
vp_ctecorriente_aux_pnt  VARCHAR2(18);
vp_cod_banco_pnt		 CO_MOVIMIENTOSCAJA.cod_banco%TYPE;
v_Fecha_efec_aux_trunc	 VARCHAR2(10);
DATOS_SQL				 VARCHAR2(2500);
v_sqlcode                VARCHAR2(10);
v_sqlerrm                VARCHAR2(255);
vp_Gls_Error             VARCHAR2(255);
sNombre_PL               VARCHAR2(100);
sEjecuta_PL              VARCHAR2(750);
sFechaVencExter          VARCHAR2(10);
sPasoFolio             	 VARCHAR2(150);
sPasoFolio2              VARCHAR2(150);
vp_emp_recauda_aux       VARCHAR2(40);
vp_emp_recauda_aux_tec   VARCHAR2(40);
vp_num_tarjeta_aux       VARCHAR2(20);
vp_ctecorriente_aux      VARCHAR2(18);
vp_tip_tarjeta_aux		 VARCHAR2(3);
Fecha_Pago               VARCHAR2(20);
pref_plaza				 CO_CARTERA.PREF_PLAZA%TYPE;
tec_letra				 VARCHAR2(1);
v_Fecha_efec_aux         VARCHAR2(20); 
vp_Glosa                 VARCHAR2(500); /* MIX-09003 25.02.2010  */
iCarrier                 NUMBER := 0;   /* MIX-09003 25.02.2010  */ 

/* VARIABLES AUXILIARES */
/**********************************************************************************************************************/
/*************************************************************************************(I) DECLARACION VARIABLES DURAS */
/**********************************************************************************************************************/
-- GLOBALES
p_nop_consumo			NUMBER;
vp_uso					NUMBER;
vcod_centremi       	NUMBER;
vcod_forpago        	NUMBER;
vcod_sispago        	NUMBER;
vcod_producto       	NUMBER;
vind_contado        	NUMBER;
vind_facturado      	NUMBER;
vnum_abonado        	NUMBER;
vcod_centrrel       	NUMBER;
vcod_ciclfact       	NUMBER;
vnum_cargo				NUMBER;
vcod_moneda				CHAR(3);
-- PNT
vtip_movcaja        	NUMBER;
vind_deposito       	NUMBER;
vind_erroneo        	NUMBER;
vind_cierre				NUMBER;
vefec_egreso        	NUMBER;
vcod_tipdocum       	NUMBER;
vnum_sec_cuota      	NUMBER;
vind_titular        	CHAR(1);
vcod_estado				CHAR(1);
vcod_ubicacion      	CHAR(1);
vnum_cuota				NUMBER;
vsec_cuota				NUMBER;
vimporte_haber      	NUMBER;
vcod_concepto       	CHAR(4);

/* Declaracion bajo nuevas normativas del mod_rek */
LN_Imp_concepto     	CO_CARTERA.COD_CONCEPTO%TYPE;
LN_Columna 				CO_CARTERA.COLUMNA%TYPE; 
GV_fecha_actual     	VARCHAR2(19);
CV_formato_fecha    	VARCHAR2(21):='DD-MM-YYYY HH24:MI:SS';
CV_modulo_re        	VARCHAR2(2) :='RE';
CV_modulo_ge        	VARCHAR2(2) :='GE';
CV_concepto_mora    	VARCHAR2(13):='CONCEPTO_MORA';
CV_concepto_cob     	VARCHAR2(17):='CONCEPTO_COBRANZA';
CV_formato_sel2     	VARCHAR2(12):='FORMATO_SEL2';
CV_num_decimal      	VARCHAR2(11):='num_decimal';
CN_numero_uno       	NUMBER      := 1;

TN_codcliclo 			GE_CLIENTES.COD_CICLO%TYPE;
TN_codciclofact 		FA_CICLFACT.COD_CICLFACT%TYPE;
TN_codproceso 			FA_TRAZAPROC.COD_PROCESO%TYPE  := 2200;
TN_codestaproc 			FA_TRAZAPROC.COD_ESTAPROC%TYPE := 3;
TN_parvalciclo 			GED_PARAMETROS.VAL_PARAMETRO%TYPE;
TN_nomparvalciclo 		GED_PARAMETROS.NOM_PARAMETRO%TYPE := 'VALIDA_CICLO_GM_REX';
LN_contador 			NUMBER(9);

/**********************************************************************************************************************/
/*************************************************************************************(F) DECLARACION VARIABLES DURAS */
/**********************************************************************************************************************/

/**********************************************************************************************************************/
/*********************************************************************************************(I) DEFINICION CURSORES */
/**********************************************************************************************************************/
i BINARY_INTEGER  := 0;
im BINARY_INTEGER := 0; 
TYPE TipRegCartera IS RECORD (
	DES_ABREVIADA       GE_TIPDOCUMEN.DES_TIPDOCUM%TYPE,
	COD_TIPDOCUM		CO_CARTERA.COD_TIPDOCUM%TYPE    ,
	COD_VENDEDOR_AGENTE	CO_CARTERA.COD_VENDEDOR_AGENTE%TYPE,
	LETRA				CO_CARTERA.LETRA%TYPE,
	COD_CENTREMI		CO_CARTERA.COD_CENTREMI%TYPE,
	NUM_SECUENCI		CO_CARTERA.NUM_SECUENCI%TYPE,
	NUM_FOLIO			CO_CARTERA.NUM_FOLIO%TYPE,
	PREF_PLAZA			CO_CARTERA.PREF_PLAZA%TYPE,
	FEC_EFECTIVIDAD		VARCHAR2(10),
	FEC_VENCIMIE		VARCHAR2(10),
	NUM_VENTA			CO_CARTERA.NUM_VENTA%TYPE,
	IND_CONTADO			CO_CARTERA.IND_CONTADO%TYPE,
	SEC_CUOTA			CO_CARTERA.SEC_CUOTA%TYPE,
	IND_FACTURADO		CO_CARTERA.IND_FACTURADO%TYPE,
	NUM_CUOTA			CO_CARTERA.NUM_CUOTA%TYPE,
	SW					VARCHAR2(2),
	MONTO				NUMBER(18,4),
	COD_OPERADORA		CO_CARTERA.COD_OPERADORA_SCL%TYPE,
	COD_PLAZA			CO_CARTERA.COD_PLAZA%TYPE,
	COD_CONCEPTO		CO_CARTERA.COD_CONCEPTO%TYPE);

TYPE TipTab_CO_CARTERA	IS TABLE  OF  TipRegCartera INDEX BY  BINARY_INTEGER;
Tab_CARGA_CARTERA		TipTab_CO_CARTERA;

TYPE InteresesMora IS RECORD (
     NUM_TRANSACCION   	CO_TRANSACINTER.NUM_TRANSACCION%TYPE );
TYPE TipTab_CO_TRANSACINT IS TABLE  OF  InteresesMora INDEX BY  BINARY_INTEGER;
Intereses_Mora 	  TipTab_CO_TRANSACINT;

CURSOR TRANSCINTER IS
	SELECT NVL(POR_TRAMO,0)   POR_TRAMO,
	       NVL(MTO_PAGO,0)    MTO_PAGO,
	       NVL(MTO_INTERES,0) MTO_INTERES
	FROM   CO_TRANSACINTER
	WHERE  NUM_TRANSACCION = lSecuTransac2
	AND    POR_TRAMO > 0;

TYPE   DYNAMIC_CURSOR    IS REF CURSOR;
CO_CARTERA03   DYNAMIC_CURSOR;

CURSOR TipoCursor IS
	SELECT  B.DES_ABREVIADA                         DES_ABREVIADA,
			A.COD_TIPDOCUM                          COD_TIPDOCUM,
			A.COD_VENDEDOR_AGENTE                   COD_VENDEDOR_AGENTE,
			A.LETRA                                 LETRA,
			A.COD_CENTREMI                          COD_CENTREMI,
			A.NUM_SECUENCI                          NUM_SECUENCI,
			A.NUM_FOLIO                             NUM_FOLIO,
			A.PREF_PLAZA                            PREF_PLAZA,
			TO_CHAR(A.FEC_EFECTIVIDAD,'DD-MM-YYYY') FEC_EFECTIVIDAD,
			TO_CHAR(A.FEC_VENCIMIE,'DD-MM-YYYY')    FEC_VENCIMIE,
			NVL(A.NUM_VENTA,-1)                     NUM_VENTA,
			A.IND_CONTADO                           IND_CONTADO,
			NVL(A.SEC_CUOTA,-1)                     SEC_CUOTA,
			A.IND_FACTURADO                         IND_FACTURADO,
			NVL(A.NUM_CUOTA,-1)                     NUM_CUOTA,
			''                                      SW,
			0                                       MONTO,
			A.COD_OPERADORA_SCL                     COD_OPERADORA,
			A.COD_PLAZA                             COD_PLAZA,
			A.COD_CONCEPTO                          COD_CONCEPTO
	FROM    CO_CARTERA A, GE_TIPDOCUMEN B
	WHERE   A.COD_TIPDOCUM = B.COD_TIPDOCUM
	AND     A.NUM_SECUENCI > 0
	AND     COD_CLIENTE =0;

rReg    TipoCursor%ROWTYPE;

CURSOR cur_intereses(EN_numtransaccion NUMBER) IS
   SELECT  NVL(tra.mto_intereses,0) AS intereses,
		   NVL(tra.fac_cobro,0)     AS factor_cobro,
		   NVL(tra.num_dias,0)      AS dias,
		   tra.cod_concfact,
		   tra.imp_cargo
   FROM    CO_TRANSACINT tra
   WHERE   tra.num_transaccion = EN_numtransaccion;


CURSOR Curs_pagosconc (LV_fecha_actual VARCHAR2,
                       LN_cod_tipdocum NUMBER  ,
					   LN_num_secuenci NUMBER  ,
					   LN_num_folio    NUMBER  ,
					   LV_cod_agente   VARCHAR2,
					   LV_letra        VARCHAR2,
					   LN_cod_centremi NUMBER)IS
	SELECT A.IMP_CONCEPTO AS IMP_CONCEPTO,
	       A.COD_CONCEPTO AS COD_CONCEPTO,
		   A.COLUMNA      AS COLUMNA       
	FROM   CO_PAGOSCONC A
	WHERE  A.COD_TIPDOCREL = LN_cod_tipdocum
	AND    A.NUM_SECUREL   = LN_num_secuenci
	AND    A.NUM_FOLIO     = LN_num_folio
	AND    A.COD_AGENTEREL = LV_cod_agente
	AND    A.LETRA_REL     = LV_letra
	AND    A.COD_CENTRREL  = LN_cod_centremi
	AND    A.FEC_CANCELACION >= TO_DATE(LV_fecha_actual,CV_formato_fecha);

/**********************************************************************************************************************/
/*********************************************************************************************(F) DEFINICION CURSORES */
/**********************************************************************************************************************/

BEGIN
	vp_Gls_Error           := '';
	vp_emp_recauda_aux     := vp_emp_recauda;
	vp_oripago_aux         := vp_OriPago;
	vp_caupago_aux         := vp_CauPago;
	vp_num_tarjeta_aux     := vp_num_tarjeta;
	vp_ctecorriente_aux    := vp_CtaCte;
    vp_tip_tarjeta_aux     := vp_codtiptarjeta;
    vp_codautoriza_aux_pnt := vp_codautoriza;
    
	sNom_proceso :='PROC. CO_APLICAPAGO_UNIVERSAL. Cliente : '||vp_Cod_cliente;

	vp_OutGlosa      := 'GV_fecha_actual';
	vp_OutRetorno    := 1;
	GV_fecha_actual  := TO_CHAR(SYSDATE,CV_formato_fecha);
	v_Fecha_efec_aux := vp_Fecha_efec;   
	/**********************************************************************************************************************/
	/**********************************************************************************(I) INICIALIZACION VARIABLES DURAS */
	/**********************************************************************************************************************/
	sNumSecuenciaDet:=0;
	p_nop_consumo   :=1;
	vp_uso          :=0;
	vcod_centremi   :=1;
	vcod_forpago    :=0;
	vcod_sispago    :=1;
	vcod_producto   :=5;
	vind_contado    :=0;
	vind_facturado  :=1;
	vnum_abonado    :=0;
	vcod_centrrel   :=1;
	vcod_ciclfact   :=0;
	vnum_cargo      :=0;
	vcod_moneda     :='001';
	
	IF (vp_Modulo_Usado='PAC') THEN
		vcod_sispago:=3;
	END IF;
	
	IF (vp_Modulo_Usado='PNT') THEN
		vp_oripago_aux:=11;
		vp_caupago_aux:=1;
		vtip_movcaja  :=6;
		vind_deposito :=0;
		vind_erroneo  :=0;
		vind_cierre   :=0;
		vefec_egreso  :=0;
		vcod_tipdocum :=59;
		vnum_sec_cuota:=1;
		vind_titular  :='1';
		vcod_estado   :='1';
		vcod_ubicacion:='1';
		vnum_cuota    :=1;
		vsec_cuota    :=1;
		vimporte_haber:=0;
		vcod_concepto:='5876';
	END IF;
	
	IF (vp_Modulo_Usado='TEC') THEN
		vcod_tipdocum:=33;
		vcod_concepto:='5876';
		vp_emp_recauda_aux_tec:='PAGO RECAUDACION EXTERNA TECA';
		IF (vp_emp_recauda='CTC') THEN
			vp_emp_recauda_aux_tec:='Pago Efectuado por CTC';
		END IF;
		IF (vp_emp_recauda='GLOBAL') THEN
			vp_emp_recauda_aux_tec:='GLOBAL COMUNICACIONES';
		END IF;
		IF (vp_emp_recauda='ORSAN') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN ORSAN';
		END IF;
		IF (vp_emp_recauda='ASERFIN') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN ASERFIN';
		END IF;
		IF (vp_emp_recauda='PROPAGO') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN PROPAGO';
		END IF;
		IF (vp_emp_recauda='PTT') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN PTT';
		END IF;
		IF (vp_emp_recauda='REDEL') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN REDEL';
		END IF;
		IF (vp_emp_recauda='CPS') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN CPS';
		END IF;
		IF (vp_emp_recauda='OFA') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN ORACLE FINANTIALS';
		END IF;
		IF (vp_emp_recauda='SERVINCO') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN SERVINCO';
		END IF;
		IF (vp_emp_recauda='ORSAN2') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN ORSAN 2';
		END IF;
		IF (vp_emp_recauda='RECAU') THEN
			vp_emp_recauda_aux_tec:='PAGO REALIZADO EN RECAU';
		END IF;
	END IF;

	IF (vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REB' OR vp_Modulo_Usado='REA') THEN
		hNumRegularizacion    := vp_transaccion;
		vp_emp_recauda_aux_tec:= 'PAGO POR REGULARIZACION';
		vcod_sispago          := 5;
	ELSE
		hNumRegularizacion    := NULL;
	END IF;
	
	/**********************************************************************************************************************/
	/**********************************************************************(I) ASIGNACION DE VARIABLES POR MODULO PARTE 1 */
	/**********************************************************************************************************************/
	vp_OutGlosa   := 'Cliente NULO';
	vp_OutRetorno := -2;
	
	IF (vp_Modulo_Usado='TEC' AND vp_num_folio='0' AND vp_folioCTC='0' AND vp_Cod_cliente IS NULL) THEN
		BEGIN
			RAISE ERROR_PROCESO;
		END;
	END IF;

	IF vp_Modulo_Usado='PNT' THEN
		dMontoInteresAcum:=0;
	END IF;

	IF (vp_Modulo_Usado='PEX') THEN
		BEGIN
			vp_Secu_Compago:= 0;
			vp_Pref_Plaza  := ' '; 
			vp_retorno     := 0;
			IF (vp_Cod_servicio!=2 AND vp_Cod_servicio!=3) THEN
				vp_Gls_Error := 'Servicio es Distinto de 2 o 3';
				RAISE ERROR_PROCESO;
			END IF;
		END;
	END IF;

	IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='PNT') THEN
	    BEGIN
			vp_OutGlosa  := 'Select CO_EMPRESAS_REX';
			vp_OutRetorno:= -3;
			
			SELECT A.COD_OFICINA, A.COD_CAJA, B.NOM_USUARORA, A.COD_OPERADORA_SCL
			INTO   sCod_Oficina , iCod_caja , sNom_User     , sCod_Operadora
			FROM   CO_EMPRESAS_REX A, CO_CAJEROS B
			WHERE  A.EMP_RECAUDADORA= vp_emp_recauda_aux
			AND    A.COD_OFICINA    = B.COD_OFICINA
			AND    A.COD_CAJA       = B.COD_CAJA;
			
			vp_Cod_Oficina:=sCod_Oficina;
	    END;
	END IF;

	vp_OutGlosa  := 'SELECT GE_PAC_DECIMALES.PARAM_GENERAL';
	vp_OutRetorno:= -3;
	iDecimal     := GE_PAC_GENERAL.PARAM_GENERAL(CV_num_decimal);
	vp_OutGlosa  := 'SELECT CO_DATGEN';
	vp_OutRetorno:= -4;
	vp_Gls_Error := 'Select CO_DATGEN.';
	
	SELECT DOC_PAGO  , DOC_COMPAGO, DOC_FACTCONTADO , CONCEP_PAG , AGENTE_INTERNO, LETRA_COBROS
	INTO   iDoc_Pago , iDocumPago , iDoc_Factcontado, iConcep_Pag, iAgenteInterno, sLetraCobros
	FROM   CO_DATGEN;

	IF (vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REB' OR vp_Modulo_Usado='REA') THEN
		idoc_pago_aux:=83;
	ELSE
		IF (vp_Modulo_Usado='TEC') THEN
			iDoc_Pago:=33;
		END IF;
		idoc_pago_aux:= iDoc_Pago;
		hCodCentremi := 1;
	END IF;

	vp_Gls_Error := 'SELECT PROD_GENERAL FROM GE_DATOSGENER.';
	vp_OutGlosa  := 'SELECT PROD_GENERAL';
	vp_OutRetorno:= -5;
	
	SELECT PROD_GENERAL
	INTO   sCodProducto
	FROM   GE_DATOSGENER;

	vp_Gls_Error := 'SELECT CONCEPTO_MORA (INTERESAPLI) FROM GED_PARAMETROS.';
	vp_OutGlosa  := 'VAL_PARAMETRO CV_concepto_mora';
	vp_OutRetorno:= -6;
	
	SELECT VAL_PARAMETRO
	INTO   sConcepto_Mora
	FROM   GED_PARAMETROS
	WHERE  COD_MODULO    = CV_modulo_re
	AND    NOM_PARAMETRO = CV_concepto_mora;

	vp_OutGlosa  := 'VAL_PARAMETRO CV_concepto_cob';
	vp_OutRetorno:= -7;
	vp_Gls_Error := 'SELECT CONCEPTO_MORA (INTERCOBAPLI) FROM GED_PARAMETROS.';
	
	SELECT VAL_PARAMETRO
	INTO   sConcepto_Cobranza
	FROM   GED_PARAMETROS
	WHERE  COD_MODULO    = CV_modulo_re
	AND    NOM_PARAMETRO = CV_concepto_cob;

	vp_OutGlosa  := 'VAL_PARAMETRO CV_formato_sel2';
	vp_OutRetorno:= -8;
	vp_Gls_Error := 'SELECT FORMATO_SEL2 FROM GED_PARAMETROS.';
	
	SELECT VAL_PARAMETRO
	INTO   sFormatoFecha
	FROM   GED_PARAMETROS
	WHERE  COD_MODULO   = CV_modulo_ge
	AND    COD_PRODUCTO = CN_numero_uno
	AND    NOM_PARAMETRO= CV_formato_sel2;

	IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='PNT') THEN
		IF (vp_Cod_servicio=3) THEN
		    BEGIN
			   vp_Gls_Error := 'Select COD_CLIENTE Ga_abocel. Cliente : '||vp_Cod_cliente;
			   vp_OutGlosa  := 'SELECT GA_ABOCEL';
			   vp_OutRetorno:= -9;
			   
			   SELECT COD_CLIENTE
			   INTO  lCod_cliente
			   FROM  GA_ABOCEL
			   WHERE NUM_CELULAR = vp_Num_celular;
               
			   EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			   	  BEGIN
			   		IF vp_Modulo_Usado='PNT' THEN
			   			vp_gls_error := 'Select Ga_intarcel. Cliente.';
			   			vp_OutGlosa  := 'SELECT GA_INTARCEL';
			   			vp_OutRetorno:= -10;
			   			
			   			SELECT COD_CLIENTE
			   			  INTO lCod_cliente
			   			  FROM GA_INTARCEL
			   			 WHERE NUM_CELULAR =  vp_num_celular
			   			   AND TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS') BETWEEN FEC_DESDE AND FEC_HASTA;
			   		ELSE
			   			lCod_cliente:=vp_Cod_cliente;
			   		END IF;
			     END;
		    END;
		ELSE
			
			vp_OutGlosa  := 'SELECT unique GE_CLIENTES';
			vp_OutRetorno:= -11;
			
			SELECT UNIQUE COD_CLIENTE
			  INTO lCod_cliente
			  FROM GE_CLIENTES
			 WHERE COD_CLIENTE  =  vp_Cod_cliente;
			 
		END IF;
	ELSE
		lCod_cliente:=vp_Cod_cliente;
	END IF;

	IF (vp_Modulo_Usado!='TEC' AND lCod_Cliente IS NULL) THEN
		BEGIN
			vp_retorno   := -2;
			vp_Gls_Error := 'Cliente NULO';
			RAISE ERROR_PROCESO;
		END;
	END IF;

	vp_OutGlosa  := 'SELECT ged_parametros par';
	vp_Gls_Error := 'SELECT ged_parametros par';
	vp_OutRetorno:= -30;

	SELECT par.val_parametro
	INTO   TN_parvalciclo
	FROM   ged_parametros par
	WHERE  par.nom_parametro = TN_nomparvalciclo
	AND    par.cod_modulo    = CV_modulo_re
	AND    par.cod_producto  = CN_numero_uno;

	IF TN_parvalciclo = 'S' THEN
		IF vp_Modulo_Usado='PEX' THEN
			vp_OutGlosa  := 'SELECT ge_clientes cli';
			vp_Gls_Error := 'SELECT ge_clientes cli';
			vp_OutRetorno:=-31;

			SELECT cli.cod_ciclo
			INTO   TN_codcliclo
			FROM   ge_clientes cli
			WHERE  cli.cod_cliente = lCod_cliente;

			vp_OutGlosa  := 'SELECT fa_ciclfact cic';
			vp_Gls_Error := 'SELECT fa_ciclfact cic';
			vp_OutRetorno:= -32;

			SELECT cic.cod_ciclfact
			INTO   TN_codciclofact
			FROM   fa_ciclfact cic
			WHERE  cic.cod_ciclo = TN_codcliclo
			AND    TO_DATE(v_Fecha_efec_aux, sFormatoFecha||' HH24:MI:SS') BETWEEN cic.fec_desdellam AND cic.fec_hastallam;

			vp_OutGlosa  := 'SELECT fa_trazaproc tra';
			vp_Gls_Error := 'SELECT fa_trazaproc tra';
			vp_OutRetorno:= -33;
			
			SELECT COUNT(1)
			INTO   LN_contador
			FROM   fa_trazaproc tra
			WHERE  tra.cod_ciclfact = TN_codciclofact
			AND    tra.cod_proceso  = TN_codproceso
			AND    tra.fec_inicio BETWEEN TO_DATE(v_Fecha_efec_aux, sFormatoFecha||' HH24:MI:SS') AND SYSDATE
			AND    tra.cod_estaproc = TN_codestaproc;

			IF LN_contador > 0 THEN
				v_Fecha_efec_aux := TO_CHAR(SYSDATE, sFormatoFecha||' HH24:MI:SS');
			END IF;

		END IF;
	END  IF;

    /* Inicio 129515 - 09.04.2010 */
	IF (vp_fec_diferido IS NULL) THEN
		IF (vp_Modulo_Usado='PEX') THEN
		   Fecha_Pago:=vp_fecha_pago;		
		ELSE
		   Fecha_Pago:=v_Fecha_efec_aux;
		END IF;
	ELSE
		Fecha_Pago:=vp_fec_diferido;
	END IF;
    /* Fin 129515 - 09.04.2010 */

	/**********************************************************************************************************************/
	/***************************************************************************(I) COMPOSICION CURSOR DINAMICO PRINCIPAL */
	/**********************************************************************************************************************/
	vp_OutGlosa  := 'Generando DATOS_SQL';
	vp_Gls_Error := 'Generando DATOS_SQL';
	vp_OutRetorno:= -34;
	DATOS_SQL    := '';
	
	IF (vp_folioCTC!='00000000000' AND vp_folioCTC!='0' AND vp_Modulo_Usado='TEC') THEN
		DATOS_SQL:=DATOS_SQL||'SELECT * FROM (';
	END IF;

	DATOS_SQL:=DATOS_SQL||'SELECT /*+ INDEX (CO_CARTERA AK_CO_CARTERA_GE_CLIENTES) */';
	DATOS_SQL:=DATOS_SQL||' NULL DES_ABREVIADA,';
	DATOS_SQL:=DATOS_SQL||' A.COD_TIPDOCUM COD_TIPDOCUM,';
	DATOS_SQL:=DATOS_SQL||' A.COD_VENDEDOR_AGENTE COD_VENDEDOR_AGENTE,';
	DATOS_SQL:=DATOS_SQL||' A.LETRA LETRA,';
	DATOS_SQL:=DATOS_SQL||' A.COD_CENTREMI COD_CENTREMI,';
	DATOS_SQL:=DATOS_SQL||' A.NUM_SECUENCI NUM_SECUENCI,';
	DATOS_SQL:=DATOS_SQL||' A.NUM_FOLIO NUM_FOLIO,';
	DATOS_SQL:=DATOS_SQL||' A.PREF_PLAZA PREF_PLAZA,';
	DATOS_SQL:=DATOS_SQL||' TO_CHAR(A.FEC_EFECTIVIDAD,'''||sFormatoFecha||''') FEC_EFECTIVIDAD,';
	DATOS_SQL:=DATOS_SQL||' TO_CHAR(A.FEC_VENCIMIE,'''||sFormatoFecha||''') FEC_VENCIMIE,';

	IF (vp_Modulo_Usado='PNT' OR vp_Modulo_Usado='REB' OR vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REA') THEN
		DATOS_SQL:=DATOS_SQL||' A.NUM_VENTA NUM_VENTA,';
	ELSE
		DATOS_SQL:=DATOS_SQL||' NVL(A.NUM_VENTA,-1) NUM_VENTA,';
	END IF;

	DATOS_SQL:=DATOS_SQL||' A.IND_CONTADO IND_CONTADO,';
	IF (vp_Modulo_Usado='PNT' OR vp_Modulo_Usado='REB' OR vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REA') THEN
		DATOS_SQL:=DATOS_SQL||' A.SEC_CUOTA SEC_CUOTA,';
	ELSE
		DATOS_SQL:=DATOS_SQL||' NVL(A.SEC_CUOTA,-1) SEC_CUOTA,';
	END IF;

	DATOS_SQL:=DATOS_SQL||' A.IND_FACTURADO IND_FACTURADO,';
	IF (vp_Modulo_Usado='PNT' OR vp_Modulo_Usado='REB' OR vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REA') THEN
		DATOS_SQL:=DATOS_SQL||' A.NUM_CUOTA NUM_CUOTA,';
	ELSE
		DATOS_SQL:=DATOS_SQL||' NVL(A.NUM_CUOTA,-1) NUM_CUOTA,';
	END IF;

	DATOS_SQL:=DATOS_SQL||' '''' SW,';
	DATOS_SQL:=DATOS_SQL||' 0 MONTO,';
	DATOS_SQL:=DATOS_SQL||' A.COD_OPERADORA_SCL COD_OPERADORA,';
	DATOS_SQL:=DATOS_SQL||' A.COD_PLAZA COD_PLAZA,';
	DATOS_SQL:=DATOS_SQL||' A.COD_CONCEPTO COD_CONCEPTO ';
	DATOS_SQL:=DATOS_SQL||' FROM ';
	DATOS_SQL:=DATOS_SQL||' CO_CARTERA A, CO_CONCEPTOS C';
	DATOS_SQL:=DATOS_SQL||' WHERE ';
	DATOS_SQL:=DATOS_SQL||' A.COD_CONCEPTO = C.COD_CONCEPTO ';
	DATOS_SQL:=DATOS_SQL||' AND ';
	DATOS_SQL:=DATOS_SQL||' A.COD_TIPDOCUM NOT IN ';
	DATOS_SQL:=DATOS_SQL||' (SELECT TO_NUMBER(COD_VALOR) ';
	DATOS_SQL:=DATOS_SQL||' FROM CO_CODIGOS ';
	DATOS_SQL:=DATOS_SQL||' WHERE ';
	DATOS_SQL:=DATOS_SQL||' NOM_TABLA = ''CO_CARTERA'' AND ';
	DATOS_SQL:=DATOS_SQL||' NOM_COLUMNA = ''COD_TIPDOCUM'') ';
	IF (vp_Modulo_Usado!='CAJ') THEN
		 IF (vp_Modulo_Usado!='PNT') THEN --197775
              DATOS_SQL:=DATOS_SQL||' AND (A.IND_FACTURADO=1) '; 
         end if;
	END IF;

	DATOS_SQL:=DATOS_SQL||' AND A.COD_CONCEPTO NOT IN (2,6) AND ';
	IF (vp_Modulo_Usado='TEC') THEN
		IF (vp_num_folio!='0' AND vp_folioCTC='0') THEN
			DATOS_SQL:=DATOS_SQL||' A.NUM_FOLIO='||vp_num_folio||' ';
		ELSE
			IF (vp_folioCTC!='00000000000' AND vp_folioCTC!='0') THEN
				DATOS_SQL:=DATOS_SQL||' A.NUM_FOLIOCTC='''||vp_folioCTC||''' ';
			ELSE
				DATOS_SQL:=DATOS_SQL||' A.COD_CLIENTE='||lCod_cliente||' ';
			END IF;
		END IF;
	ELSE
		DATOS_SQL:=DATOS_SQL||' A.COD_CLIENTE='||lCod_cliente||' ';
		IF (vp_sw_doc!='0') THEN
			DATOS_SQL:=DATOS_SQL||' AND A.NUM_FOLIO='||vp_num_folio||' ';
			IF (vp_Modulo_Usado='CAJ') THEN
				DATOS_SQL:=DATOS_SQL||' AND A.SEC_CUOTA = ' ||vp_sec_cuota_ca ||' ';
			END IF;
		ELSE
			IF (vp_Modulo_Usado='CAJ') THEN
				DATOS_SQL:=DATOS_SQL||' AND (A.IND_FACTURADO=1 OR (A.SEC_CUOTA!=0 AND A.SEC_CUOTA IS NOT NULL AND A.COD_TIPDOCUM>47 AND A.COD_TIPDOCUM<57 AND A.IND_FACTURADO=0 AND A.FEC_VENCIMIE<SYSDATE)) ';
			END IF;
		END IF;
	END IF;

    /* Inicio MIX-09003 17.02.2010 */
	IF (vp_Modulo_Usado='PEX') THEN
		DATOS_SQL:=DATOS_SQL||' AND A.NUM_FOLIO = '||vp_num_folio_doc ||' ';
		DATOS_SQL:=DATOS_SQL||' AND A.PREF_PLAZA = '''||vp_pref_plaza_doc ||''' ';
	END IF;
    /* Fin MIX-09003 17.02.2010 */
	
	/**********************************************************************************************************************/
	/***************************************************************************(I) COMPOSICION CURSOR DINAMICO ANEXO     */
	/**********************************************************************************************************************/
	IF (vp_folioCTC!='00000000000' AND vp_folioCTC!='0' AND vp_Modulo_Usado='TEC') THEN
		DATOS_SQL:=DATOS_SQL||' ORDER BY  A.FEC_VENCIMIE ASC, A.NUM_FOLIO ASC, A.SEC_CUOTA ASC, C.ORDEN_CAN, A.COD_CONCEPTO ';
		DATOS_SQL:=DATOS_SQL||') ';
		DATOS_SQL:=DATOS_SQL||' UNION ';
		DATOS_SQL:=DATOS_SQL||'SELECT * FROM (';
		DATOS_SQL:=DATOS_SQL||'SELECT /*+ INDEX (CO_CARTERA AK_CO_CARTERA_GE_CLIENTES) */';
		DATOS_SQL:=DATOS_SQL||' NULL DES_ABREVIADA,';
		DATOS_SQL:=DATOS_SQL||' A.COD_TIPDOCUM COD_TIPDOCUM,';
		DATOS_SQL:=DATOS_SQL||' A.COD_VENDEDOR_AGENTE COD_VENDEDOR_AGENTE,';
		DATOS_SQL:=DATOS_SQL||' A.LETRA LETRA,';
		DATOS_SQL:=DATOS_SQL||' A.COD_CENTREMI COD_CENTREMI,';
		DATOS_SQL:=DATOS_SQL||' A.NUM_SECUENCI NUM_SECUENCI,';
		DATOS_SQL:=DATOS_SQL||' A.NUM_FOLIO NUM_FOLIO,';
		DATOS_SQL:=DATOS_SQL||' A.PREF_PLAZA PREF_PLAZA,';
		DATOS_SQL:=DATOS_SQL||' TO_CHAR(A.FEC_EFECTIVIDAD,'''||sFormatoFecha||''') FEC_EFECTIVIDAD,';
		DATOS_SQL:=DATOS_SQL||' TO_CHAR(A.FEC_VENCIMIE,'''||sFormatoFecha||''') FEC_VENCIMIE,';
		DATOS_SQL:=DATOS_SQL||' NVL(A.NUM_VENTA,-1) NUM_VENTA,';
		DATOS_SQL:=DATOS_SQL||' A.IND_CONTADO IND_CONTADO,';
		DATOS_SQL:=DATOS_SQL||' NVL(A.SEC_CUOTA,-1) SEC_CUOTA,';
		DATOS_SQL:=DATOS_SQL||' A.IND_FACTURADO IND_FACTURADO,';
		DATOS_SQL:=DATOS_SQL||' NVL(A.NUM_CUOTA,-1) NUM_CUOTA,';
		DATOS_SQL:=DATOS_SQL||' '''' SW,';
		DATOS_SQL:=DATOS_SQL||' 0 MONTO,';
		DATOS_SQL:=DATOS_SQL||' A.COD_OPERADORA_SCL COD_OPERADORA,';
		DATOS_SQL:=DATOS_SQL||' A.COD_PLAZA COD_PLAZA,';
		DATOS_SQL:=DATOS_SQL||' A.COD_CONCEPTO COD_CONCEPTO ';
		DATOS_SQL:=DATOS_SQL||' FROM ';
		DATOS_SQL:=DATOS_SQL||' CO_CARTERA A, CO_CONCEPTOS C';
		DATOS_SQL:=DATOS_SQL||' WHERE ';
		DATOS_SQL:=DATOS_SQL||' A.COD_CONCEPTO = C.COD_CONCEPTO ';
		DATOS_SQL:=DATOS_SQL||' AND ';
		DATOS_SQL:=DATOS_SQL||' A.COD_TIPDOCUM NOT IN ';
		DATOS_SQL:=DATOS_SQL||' (SELECT TO_NUMBER(COD_VALOR) ';
		DATOS_SQL:=DATOS_SQL||' FROM CO_CODIGOS ';
		DATOS_SQL:=DATOS_SQL||' WHERE ';
		DATOS_SQL:=DATOS_SQL||' NOM_TABLA = ''CO_CARTERA'' AND ';
		DATOS_SQL:=DATOS_SQL||' NOM_COLUMNA = ''COD_TIPDOCUM'') ';
		DATOS_SQL:=DATOS_SQL||' AND ((A.IND_FACTURADO=1) OR (A.IND_FACTURADO=0 AND A.FEC_VENCIMIE<SYSDATE)) ';
		DATOS_SQL:=DATOS_SQL||' AND A.COD_CONCEPTO NOT IN (2,6) AND ';
		DATOS_SQL:=DATOS_SQL||' A.COD_CLIENTE='||lCod_cliente||' AND ';
		DATOS_SQL:=DATOS_SQL||' A.NUM_FOLIOCTC!='''||vp_folioCTC||''' ';
		DATOS_SQL:=DATOS_SQL||' ORDER BY  A.IND_FACTURADO desc ,A.FEC_VENCIMIE ASC, A.NUM_FOLIO ASC, A.SEC_CUOTA ASC, C.ORDEN_CAN, A.COD_CONCEPTO ';
		DATOS_SQL:=DATOS_SQL||') ';
	ELSE
		DATOS_SQL:=DATOS_SQL||' ORDER BY  A.IND_FACTURADO desc ,A.FEC_VENCIMIE ASC, A.NUM_FOLIO ASC, A.SEC_CUOTA ASC, C.ORDEN_CAN, A.COD_CONCEPTO ';
	END IF;
--MIG

	/**********************************************************************************************************************/
	/**********************************************************************(I) ASIGNACION DE VARIABLES POR MODULO PARTE 2 */
	/**********************************************************************************************************************/
	IF (vp_Modulo_Usado='PNT' OR vp_Modulo_Usado='CAJ') THEN
	BEGIN
	  	IF vp_Modulo_Usado='PNT' THEN  
			vp_OutGlosa  := 'SELECT NOM_USUARORA CO_ACCECLI(1)';
			vp_OutRetorno:= -12;
			
			SELECT NOM_USUARORA
			INTO   sNomCajero
			FROM   CO_ACCECLI
			WHERE  COD_CLIENTE = lCod_Cliente
			AND    FEC_INICIO  > SYSDATE-1;
			
		ELSE  -- SI ES CAJ
  	   		vp_OutGlosa  := 'SELECT NOM_USUARORA CO_ACCECLI(2)';
			vp_OutRetorno:= -36;
			
			SELECT NOM_USUARORA
			INTO   sNomCajero
			FROM   CO_ACCECLI
			WHERE  COD_CLIENTE = lCod_Cliente
			AND    NOM_USUARORA <> USER
			AND    FEC_INICIO > SYSDATE-1;
			
		END IF;

		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			sNomCajero := NULL;
	END;
	BEGIN
		IF sNomCajero IS NOT NULL THEN /* Cliente bloqueado, no debe realizarce el pago */
			vp_OutGlosa  := 'Linea : RAISE CLIENTE_BLOQUEADO;';
			vp_OutRetorno:= -13;
			RAISE CLIENTE_BLOQUEADO;
		END IF;
	END;
	END IF;

	IF (vp_Modulo_Usado='PNT') THEN
		vp_gls_error := 'Select NUM_SECUMOV FROM COT_CAJAS_NT.';
		vp_OutGlosa  := 'Linea : SELECT COS_SEQ_MOVCAJA';
		vp_OutRetorno:= -14;
		
		SELECT COS_SEQ_MOVCAJA.NEXTVAL INTO nSecuencia  FROM DUAL ;
	END IF;

	vp_Gls_Error := 'SELECT COD_OPERADORA.';
	vp_OutGlosa  := 'Linea : SELECT COD_OPERADORA GE_CLIENTES';
	vp_OutRetorno:= -15;
	
	SELECT COD_OPERADORA
	INTO   sCod_OperadorAbono
	FROM   GE_CLIENTES
	WHERE  COD_CLIENTE = lCod_cliente;

	IF (vp_Modulo_Usado='CAJ') THEN
		vp_OutGlosa  := 'Linea : SELECT COD_OPERADORA_SCL CO_CAJAS ';
		vp_OutRetorno:= -16;
		
		SELECT COD_OPERADORA_SCL INTO sCod_OperadorAbono
		FROM   CO_CAJAS
		WHERE  COD_OFICINA=vp_Oficina AND COD_CAJA=vp_caja;
		
	END IF;

	IF (vp_Modulo_Usado='TEC') THEN
		iCod_caja     := '1A';
		sNom_User     := USER;
		sCod_Oficina  := vp_Oficina;
		sCod_Operadora:= sCod_OperadorAbono;
	END IF;

	vp_Gls_Error := 'Select CO_SEQ_PAGO.NEXTVAL(1).';
	IF ((vp_Modulo_Usado='CAJ') OR vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REB' OR vp_Modulo_Usado='REA') THEN
		lSec_Pago:=TO_NUMBER(vp_num_secuenci_ca);
	ELSE
		IF (vp_Modulo_Usado='COV') THEN
			lSec_Pago:=TO_NUMBER(vp_transaccion);
		ELSE
			vp_OutGlosa  := 'Linea : SELECT CO_SEQ_PAGO.NEXTVAL';
			vp_OutRetorno:= -17;
			SELECT CO_SEQ_PAGO.NEXTVAL  INTO lSec_Pago  FROM DUAL;
		END IF;
	END IF;

	vp_Gls_Error := 'SELECT VAL_PARAMETRO.';
	vp_OutGlosa  := 'Linea : SELECT VAL_PARAMETRO OFICINA_FOLIO';
	vp_OutRetorno:= -18;
	
	SELECT VAL_PARAMETRO
	INTO   szVal_Param
	FROM   GED_PARAMETROS
	WHERE  NOM_PARAMETRO = 'OFICINA_FOLIO'	
	AND   ((vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC')  OR
		  ((vp_Modulo_Usado='PEX'  OR  vp_Modulo_Usado='PNT'  OR  vp_Modulo_Usado ='TEC')  AND COD_MODULO='RE'));

	vp_Gls_Error :='IF szVal_Param != "0" THEN';
	IF (szVal_Param != '0') THEN
		sCod_Oficina:=szVal_Param;
	ELSE
		IF (vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='PEX') THEN
			sCod_Oficina:=vp_Oficina;
		END IF;
	END IF;

	IF (vp_Modulo_Usado='PNT') THEN
       IF sCod_Oficina = 'NT' THEN
		  vp_OutGlosa  := 'Linea : SELECT DES_EMPRESA CED_EMPRESAS';
		  vp_OutRetorno:= -19;

	      SELECT DES_EMPRESA
	      INTO   sDesc_empresa
	      FROM   CED_EMPRESAS
	      WHERE  COD_EMPRESA = vp_emp_recauda_aux;

		  vp_emp_recauda_aux:= sDesc_empresa;

	   END IF;
	END IF;

	vp_Gls_Error   := 'Fn_Obtiene_PlazaCliente(lCod_cliente)';
	sCod_PlazaAbono:= Fn_Obtiene_PlazaCliente(lCod_cliente);

	IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='PNT' OR (vp_Modulo_Usado='TEC' AND iDoc_Pago!=33)) THEN
		vp_OutGlosa  := 'Linea : FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN sCod_Operadora';
		vp_OutRetorno:= -20;
		vp_Gls_Error := 'FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN';
		
		sPasoFolio:=FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(iDoc_Pago,NULL,sCod_oficina,sCod_Operadora,NULL,NULL,NULL,SYSDATE,p_nop_consumo);

	ELSE
		IF (vp_Modulo_Usado!='CAJ' AND vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='REB' AND vp_Modulo_Usado!='REA' AND vp_Modulo_Usado!='TEC') THEN
			vp_OutGlosa  := 'Linea : FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN sCod_OperadorAbono';
			vp_OutRetorno:=-21;
			vp_Gls_Error := 'SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_CICLO_FN';
			
			sPasoFolio:=FA_FOLIACION_PG.FA_CONSUME_FOLIO_CICLO_FN(iDoc_Pago,NULL,sCod_Oficina, sCod_OperadorAbono,NULL,NULL,NULL,SYSDATE,p_nop_consumo);

		END IF;
	END IF;

	iPos1             := INSTR(sPasoFolio,';',1);
	iPos2             := LENGTH(sPasoFolio) - iPos1;
	sPasoFolio2       := SUBSTR(sPasoFolio,iPos1 + 1, iPos2);
    iPos3             := INSTR(sPasoFolio2,';',1);
	iPos4             := INSTR(sPasoFolio2,';',1,2) - iPos3-1;
	
    IF iPos4 <= 0 THEN
        iPos4 := LENGTH(sPasoFolio2)- iPos3;
    END IF;

	IF (vp_Modulo_Usado!='CAJ' AND vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='REB' AND vp_Modulo_Usado!='REA' AND vp_Modulo_Usado!='COV') THEN
		IF (vp_Modulo_Usado='TEC' AND iDoc_Pago=33) THEN
			lSecCompago := vp_Num_transac;
		ELSE
			lSecCompago := SUBSTR(sPasoFolio2,iPos3 +1,iPos4);
		END IF;
	ELSE
		lSecCompago := vp_Num_transac;
	END IF;

	IF (vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='REB' AND vp_Modulo_Usado!='REA') THEN
		IF (vp_Modulo_Usado='CAJ') THEN 
			lPref_Plaza := vp_Pref_Plaza;
		ELSE
			IF (vp_Modulo_Usado='TEC' AND iDoc_Pago=33) THEN
				lPref_Plaza := '000';
			ELSE
				lPref_Plaza := SUBSTR(sPasoFolio2,1,iPos3 - 1);
			END IF;
		END IF;
	ELSE
		lPref_Plaza := '000';
	END IF;

	vp_OutGlosa  := 'Linea : GE_PAC_GENERAL.REDONDEA';
	vp_OutRetorno:= -22;
	dTotal_pago  := GE_PAC_GENERAL.REDONDEA(vp_Imp_pago, iDecimal, vp_uso);

	IF (vp_Modulo_Usado='PNT') THEN
		vp_gls_error := 'UPDATE COT_CAJAS_NT.';
		vp_OutGlosa := 'Linea : UPDATE COT_CAJAS_NT SET ';
		vp_OutRetorno:=-23;
		UPDATE COT_CAJAS_NT SET
		       NUM_SECUMOV = nSecuencia
		 WHERE COD_OFICINA   = vp_Cod_Oficina
		 AND   COD_CAJA      = iCod_caja
		 AND   NUM_EJERCICIO = vp_num_ejer;

		vp_gls_error := 'SELECT COD_MONEDA FROM CO_TIPVALOR';
		vp_OutGlosa  := 'Linea : SELECT COD_MONEDA';
		vp_OutRetorno:= -24;
		
		SELECT COD_MONEDA
		INTO   sCod_Moneda
		FROM   CO_TIPVALOR
		WHERE  TIP_VALOR = vp_tip_valor;

		IF (vp_tip_valor=1 OR vp_tip_valor=12 OR vp_tip_valor = 3) THEN
			fec_pnt:=NULL;
            IF vp_tip_valor = 12 THEN
                vp_cod_banco_pnt:= vp_Cod_banco;
            ELSE
			    vp_cod_banco_pnt:=NULL;
            END IF;
			vp_ctecorriente_aux_pnt  := NULL;
			vp_num_tarjeta_aux_pnt   := vp_num_tarjeta_aux;
			vp_num_docum_pnt         := NULL;
            vp_codtiptarjeta_aux_pnt := vp_tip_tarjeta_aux;
            vp_codautoriza_aux_pnt   := vp_codautoriza;
		ELSE
			IF (vp_tip_valor=4) THEN
				fec_pnt                  := SYSDATE;
				vp_cod_banco_pnt         := vp_cod_banco;
				vp_ctecorriente_aux_pnt  := vp_ctecorriente_aux;
				vp_num_tarjeta_aux_pnt   := NULL;
				vp_num_docum_pnt         := vp_num_docum;
                vp_codtiptarjeta_aux_pnt := NULL;
                vp_codautoriza_aux_pnt   := NULL;
			END IF;
		END IF;

		IF (vp_tip_valor=1 OR vp_tip_valor=4 OR vp_tip_valor=12 OR vp_tip_valor = 3) THEN
		
			vp_OutGlosa  := 'Linea : INSERT INTO CO_MOVIMIENTOSCAJA';
			vp_OutRetorno:= -25;
			vp_gls_error := 'INSERT INTO CO_MOVIMIENTOSCAJA (1-12). Cliente : '||lCod_cliente;
			
			INSERT INTO CO_MOVIMIENTOSCAJA (
			  COD_OFICINA     , COD_CAJA           , NUM_SECUMOV   ,
			  NUM_EJERCICIO   , 
			  FEC_EFECTIVIDAD , 
			  NOM_USUARORA    , TIP_MOVCAJA        , IND_DEPOSITO  ,
			  IMPORTE         ,
			  IND_ERRONEO     , TIP_VALOR          , IND_CIERRE    ,
			  COD_CLIENTE     , NUM_ABONADO        , COD_PRODUCTO  ,
			  TIP_DOCUMENT    , COD_VENDEDOR_AGENTE, LETRA         ,
			  COD_CENTREMI    , NUM_SECUENCI       , LETRAC        ,
			  COD_CENTRC      , NUM_SECUC          , COD_BANCO     ,
			  COD_SUCURSAL    , CTA_CORRIENTE      , NUM_CHEQUE    ,
			  TIP_CLEARING    , FEC_CHEQUE         , COD_TIPTARJETA,
			  NUM_TARJETA     , COD_AUTORIZA       , NUM_CUPON     ,
			  NUM_CUOTAS      , FEC_CUPON          , COD_MOVILI    ,
			  DES_MOVILI      , COD_RECOMPE        , NOM_CUSTODIA  ,
			  NUM_IDENT       , NUM_ORDEN          , FEC_EMISION   ,
			  FEC_VENCIMIENTO , COD_COBRADOR       , NUM_INGMANUAL ,
			  NUM_RESPINGR    , COD_MONEDA         , NUM_COMPAGO   ,
			  PREF_PLAZA      , COD_OPERADORA_SCL  ,  COD_PLAZA	)
			VALUES	(
			  vp_Cod_Oficina        , iCod_caja              , nSecuencia              , 
			  vp_num_ejer           ,
			  TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'), 
			  sNom_User             , vtip_movcaja           , vind_deposito           ,
			  GE_PAC_GENERAL.REDONDEA(vp_imp_pago, iDecimal, vp_uso),
			  vind_erroneo          , vp_tip_valor           , vind_cierre             ,
			  lCod_cliente          , NULL                   , NULL                    ,
			  iDoc_Pago             , iAgenteInterno         , sLetraCobros            ,
			  vcod_centremi         , lSec_Pago              , NULL                    ,
			  NULL                  , NULL                   , vp_Cod_banco_pnt        ,
			  NULL                  , vp_ctecorriente_aux_pnt, vp_num_docum_pnt        ,
			  NULL                  , fec_pnt                , vp_codtiptarjeta_aux_pnt,
			  vp_num_tarjeta_aux_pnt, vp_codautoriza_aux_pnt , NULL                    ,
			  NULL                  , NULL                   , NULL                    ,
			  NULL                  , NULL                   , NULL                    ,
			  NULL                  , NULL                   , NULL                    ,
			  NULL                  , NULL                   , NULL                    ,
			  NULL                  , sCod_Moneda            , lSecCompago             ,
			  lPref_Plaza           , sCod_OperadorAbono     , sCod_PlazaAbono	);
		END IF;

		IF (vp_tip_valor=1) THEN
			vp_OutGlosa  := 'Linea : SELECT FROM CO_EFECTIVO_CAJAS';
			vp_OutRetorno:= -26;
			vp_gls_error := 'SELECT FROM CO_EFECTIVO_CAJAS.';
			
			SELECT NVL(COUNT (1),0)
			INTO   sRow
			FROM   CO_EFECTIVO_CAJAS
			WHERE  COD_OFICINA      = vp_Cod_Oficina
			AND    COD_CAJA         = iCod_caja
			AND    NUM_EJERCICIO    = vp_num_ejer
			AND    COD_MONEDA       = sCod_Moneda
			AND    COD_OPERADORA_SCL= sCod_OperadorAbono
			AND    COD_PLAZA        = sCod_PlazaAbono ;

			IF (sRow > 0) THEN
				vp_gls_error := 'UPDATE CO_EFECTIVO_CAJAS.';
				vp_OutGlosa  := 'Linea : UPDATE CO_EFECTIVO_CAJAS';
				vp_OutRetorno:= -27;
				
				UPDATE CO_EFECTIVO_CAJAS
				SET    EFEC_CAMBIO  = EFEC_CAMBIO + GE_PAC_GENERAL.REDONDEA(vp_imp_pago, iDecimal, vp_uso)
				WHERE  COD_OFICINA      = vp_Cod_Oficina
				AND    COD_CAJA         = iCod_caja
				AND    NUM_EJERCICIO    = vp_num_ejer
				AND    COD_MONEDA       = sCod_Moneda
				AND    COD_OPERADORA_SCL= sCod_OperadorAbono
				AND    COD_PLAZA        = sCod_PlazaAbono;
				
			ELSE
				vp_gls_error := 'INSERT INTO CO_EFECTIVO_CAJAS.';
				vp_OutGlosa  := 'Linea : INSERT INTO CO_EFECTIVO_CAJAS';
				vp_OutRetorno:= -28;
				
				INSERT INTO CO_EFECTIVO_CAJAS (
				  COD_OFICINA      , COD_CAJA   , NUM_EJERCICIO,
				  COD_MONEDA       , EFEC_CAMBIO, EFEC_EGRESO,
				  COD_OPERADORA_SCL, COD_PLAZA		)
				VALUES	(
				  vp_Cod_Oficina    , iCod_caja,      vp_num_ejer,
				  sCod_Moneda       , GE_PAC_GENERAL.REDONDEA(vp_imp_pago, iDecimal, vp_uso), vefec_egreso,
				  sCod_OperadorAbono, sCod_PlazaAbono		);
				  
				
			END IF;
		END IF;
	END IF;

	IF (vp_Modulo_Usado!='PNT') THEN
		sCod_Moneda:=vcod_moneda;
	END IF;

	/**********************************************************************************************************************/
	/**********************************************************************************************(I) APLICACION DE PAGO */
	/**********************************************************************************************************************/
	IF ((dTotal_pago>0 AND vp_Modulo_Usado!='PNT') OR (vp_Modulo_Usado='PNT')) THEN
		IF (vp_Modulo_Usado='PEX') THEN
			vp_oripago_aux      :=2;
			vp_caupago_aux      :=1;
			vp_num_tarjeta_aux  :=NULL;
			vp_tip_tarjeta_aux  :=NULL;
		END IF;

		IF (vp_Modulo_Usado='TEC') THEN
			vp_num_tarjeta_aux  := NULL;
			vp_tip_tarjeta_aux  := NULL;
			sNom_User			:= USER;
		END IF;

		IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
			vp_OutRetorno	:= 100;
			iCod_caja       :=NULL;
			sNom_User       :=USER;
			IF (vp_Modulo_Usado!='CAJ') THEN
				vp_num_tarjeta_aux  :=NULL;
				vp_ctecorriente_aux :=NULL;
				vp_tip_tarjeta_aux  :=NULL;
			END IF;
			IF (vp_Modulo_Usado='CAJ') THEN
				vp_tip_tarjeta_aux  := vp_num_ejer;
			END IF;
		END IF;

		IF (vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REB' OR vp_Modulo_Usado='REA') THEN
			IF (vp_Modulo_Usado='RED') THEN
				vp_OutGlosa  := 'Select CO_PAGO_DOC_REGULARIZA';
				vp_Gls_Error := 'Select CO_PAGO_DOC_REGULARIZA';
				vp_OutRetorno:= -35;
				
				SELECT DISTINCT COD_CENTREMI
				INTO   hCodCentremi
				FROM   CO_PAGO_DOC_REGULARIZA
				WHERE  NUM_REGULARIZA   = hNumRegularizacion
				AND    COD_CLIENTE      = lCod_cliente
				AND    IMPORTE_CONCEPTO > 0;
				
			END IF;
			iCod_caja:='REG';
			
		END IF;

		IF (((vp_sw_doc=0) OR (vp_sw_copago=0))) THEN
			IF (vp_Modulo_Usado!='TEC' AND vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='REB' AND vp_Modulo_Usado!='REA') THEN
				IF (vp_Modulo_Usado='CAJ' AND vp_sec_cuota_ca='-1') THEN
					vp_emp_recauda_aux_tec:='Pago Recaudación Externa Teca Día';
				ELSE
					IF (vp_fec_diferido IS NOT NULL) THEN
						vp_emp_recauda_aux_tec:='Pago Dif. Efectuado por Caja';
					ELSE
						vp_emp_recauda_aux_tec:='Pago Efectuado por '||vp_emp_recauda_aux;
					END IF;
				END IF;
			END IF;

			IF (vp_Modulo_Usado='CAJ') THEN
				vp_imp_pago_aux:= TO_NUMBER(vp_importe_ca);
			ELSE
				vp_imp_pago_aux:= vp_Imp_pago;
			END IF;

			vp_Gls_Error := 'INSERT INTO CO_PAGOS.';
			INSERT INTO CO_PAGOS
			(
			COD_TIPDOCUM   , COD_VENDEDOR_AGENTE, LETRA         ,
			COD_CENTREMI   , NUM_SECUENCI       , COD_CLIENTE   ,
			IMP_PAGO       , 
			FEC_EFECTIVIDAD, COD_CAJA           ,
			FEC_VALOR      , 
			NOM_USUARORA   , COD_FORPAGO        ,
			COD_SISPAGO    , COD_ORIPAGO        , COD_CAUPAGO   ,
			COD_BANCO      , COD_TIPTARJETA     , COD_SUCURSAL  ,
			CTA_CORRIENTE  , NUM_TARJETA        , DES_PAGO      ,
			NUM_COMPAGO    , PREF_PLAZA         , IND_REGULARIZA
			)
			VALUES
			(
			idoc_pago_aux      ,  iAgenteInterno    , sLetraCobros          ,
			vcod_centremi      ,  lSec_Pago         , lCod_cliente          ,
			GE_PAC_GENERAL.REDONDEA(vp_imp_pago_aux, iDecimal, vp_uso),
			SYSDATE            ,  iCod_caja         ,
			TO_DATE(Fecha_Pago,sFormatoFecha||' HH24:MI:SS'),   
			sNom_User          ,  vcod_forpago      ,
			vcod_sispago       ,  vp_oripago_aux    , vp_caupago_aux        ,
			vp_Cod_banco       ,  vp_tip_tarjeta_aux, NULL                  ,
			vp_ctecorriente_aux,  vp_num_tarjeta_aux, vp_emp_recauda_aux_tec,
			lSecCompago        ,  lPref_Plaza       , hNumRegularizacion
			);
		END IF;

		IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='TEC') THEN
			vp_retorno:=1;
		END IF;

		IF (vp_Modulo_Usado!='COV') THEN

			IF ((vp_Modulo_Usado !='REA' AND vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='PNT') OR (vp_Modulo_Usado='PNT' AND (vp_cod_servicio=2 OR vp_cod_servicio=3)))  THEN

				i           := 0;
				iTipDocAnt  := 0;
				iVendAgenAnt:= 0;
				sLetraAnt   := '';
				iCodCentAnt := 0;
				lNumSecAnt  := 0;
				lNumFolioAnt:= 0;
				lNumPrefijo_PlazaAnt:= 0;
				iSecCuotAnt := 0;
				iCodConcepto:= 0;
				dSaldoAux   := 0;
				
				IF (vp_Modulo_Usado='PNT' AND dTotal_pago<=0) THEN
					vp_Gls_Error := 'dTotal es menor o igual a 0.';
				ELSE
					vp_Gls_Error := 'Recorre Cursor Co_Cartera03.';
					BEGIN
						OPEN CO_CARTERA03 FOR DATOS_SQL;
						LOOP
							FETCH CO_CARTERA03 INTO rReg;
							EXIT WHEN CO_CARTERA03%NOTFOUND;

							SELECT DES_ABREVIADA INTO rReg.DES_ABREVIADA
							FROM GE_TIPDOCUMEN
							WHERE COD_TIPDOCUM = rReg.COD_TIPDOCUM;

							IF (vp_Modulo_Usado!='PNT') THEN
								IF rReg.SEC_CUOTA < 0 THEN rReg.SEC_CUOTA:=NULL; END IF;
								IF rReg.NUM_VENTA < 0 THEN rReg.NUM_VENTA:=NULL; END IF;
								IF rReg.NUM_CUOTA < 0 THEN rReg.NUM_CUOTA:=NULL; END IF;
							END IF;

							IF (rReg.COD_TIPDOCUM = iTipDocAnt             AND rReg.COD_VENDEDOR_AGENTE = iVendAgenAnt
							    AND rReg.LETRA    = sLetraAnt              AND rReg.COD_CENTREMI = iCodCentAnt
								AND rReg.NUM_SECUENCI = lNumSecAnt         AND rReg.NUM_FOLIO = lNumFolioAnt

								AND rReg.PREF_PLAZA = lNumPrefijo_PlazaAnt AND rReg.SEC_CUOTA = iSecCuotAnt ) THEN

								BEGIN
									vp_Gls_Error := 'No Hace Nada.';
								END;
							ELSE
								BEGIN
									iTipDocAnt  := rReg.COD_TIPDOCUM;
									iVendAgenAnt:= rReg.COD_VENDEDOR_AGENTE;
									sLetraAnt   := rReg.LETRA;
									iCodCentAnt := rReg.COD_CENTREMI;
									lNumSecAnt  := rReg.NUM_SECUENCI;
									lNumFolioAnt:= rReg.NUM_FOLIO;
									lNumPrefijo_PlazaAnt:= rReg.PREF_PLAZA;
									iSecCuotAnt := rReg.SEC_CUOTA;


									BEGIN
										vp_Gls_Error := 'SELECT SUM(IMPORTE_DEBE - IMPORTE_HABER) FROM CO_CARTERA(1). Cliente : '||lCod_cliente;
										SELECT  NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
										INTO 	dSaldo
										FROM    CO_CARTERA
										WHERE   COD_CLIENTE         = lCod_cliente
										AND     COD_TIPDOCUM        = iTipDocAnt
										AND     COD_CENTREMI        = iCodCentAnt
										AND     NUM_SECUENCI        = lNumSecAnt
										AND     COD_VENDEDOR_AGENTE = iVendAgenAnt
										AND     LETRA               = sLetraAnt
										AND     NUM_FOLIO           = lNumFolioAnt
										AND     PREF_PLAZA          = lNumPrefijo_PlazaAnt

										AND     (SEC_CUOTA          = iSecCuotAnt OR SEC_CUOTA IS NULL) ;
									END;

									IF (((dSaldo>0) AND (dTotal_pago>0) AND vp_Modulo_Usado!='PNT') OR (dSaldo>0 AND vp_Modulo_Usado='PNT')) THEN
										BEGIN
											i := i + 1 ;
											Tab_CARGA_CARTERA(i).DES_ABREVIADA        := rReg.DES_ABREVIADA ;
											Tab_CARGA_CARTERA(i).COD_TIPDOCUM         := rReg.COD_TIPDOCUM ;
											Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE  := rReg.COD_VENDEDOR_AGENTE ;
											Tab_CARGA_CARTERA(i).LETRA                := rReg.LETRA ;
											Tab_CARGA_CARTERA(i).COD_CENTREMI         := rReg.COD_CENTREMI ;
											Tab_CARGA_CARTERA(i).NUM_SECUENCI         := rReg.NUM_SECUENCI ;
											Tab_CARGA_CARTERA(i).NUM_FOLIO            := rReg.NUM_FOLIO ;
											Tab_CARGA_CARTERA(i).PREF_PLAZA           := rReg.PREF_PLAZA ;
											Tab_CARGA_CARTERA(i).FEC_EFECTIVIDAD      := rReg.FEC_EFECTIVIDAD ;
											Tab_CARGA_CARTERA(i).FEC_VENCIMIE         := rReg.FEC_VENCIMIE ;
											Tab_CARGA_CARTERA(i).NUM_VENTA            := rReg.NUM_VENTA;
											Tab_CARGA_CARTERA(i).IND_CONTADO          := rReg.IND_CONTADO;
											Tab_CARGA_CARTERA(i).SEC_CUOTA            := rReg.SEC_CUOTA;
											Tab_CARGA_CARTERA(i).IND_FACTURADO        := rReg.IND_FACTURADO;
											Tab_CARGA_CARTERA(i).NUM_CUOTA            := rReg.NUM_CUOTA;
											Tab_CARGA_CARTERA(i).COD_OPERADORA        := rReg.COD_OPERADORA;
											Tab_CARGA_CARTERA(i).COD_PLAZA            := rReg.COD_PLAZA;

											IF dTotal_pago >= dSaldo THEN
												Tab_CARGA_CARTERA(i).MONTO   := dSaldo;
												Tab_CARGA_CARTERA(i).SW      :='SI';
												dTotal_pago:= dTotal_pago - dSaldo;
												dSaldoAux:=dSaldoAux + dSaldo;
											ELSE
												Tab_CARGA_CARTERA(i).MONTO   := dTotal_pago;
												Tab_CARGA_CARTERA(i).SW      :='NO';
												dTotal_pago:= dTotal_pago - dSaldo;
												EXIT;
											END IF;
										END;
									END IF;
								END;
							END IF;
						END LOOP;
						CLOSE CO_CARTERA03;
					END;
				END IF;
			ELSE
				i:=1;
				Tab_CARGA_CARTERA(i).NUM_SECUENCI       := vp_caja;
				Tab_CARGA_CARTERA(i).COD_TIPDOCUM       := vp_cod_tipdocum_ca;
				Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE:= vp_cod_vend_agente_ca;
				Tab_CARGA_CARTERA(i).LETRA              := vp_letra_ca;
				Tab_CARGA_CARTERA(i).SEC_CUOTA          := vp_sec_cuota_ca;
				Tab_CARGA_CARTERA(i).MONTO              := vp_importe_ca;
				Tab_CARGA_CARTERA(i).NUM_FOLIO          := vp_num_folio;
				Tab_CARGA_CARTERA(i).PREF_PLAZA         := vp_Pref_Plaza;
				
				IF (vp_sw_tpago='Total') THEN
					Tab_CARGA_CARTERA(i).SW:='SI';
				ELSE
					Tab_CARGA_CARTERA(i).SW:='NO';
				END IF;
				
			END IF;
		END IF;
	END IF;

	/**********************************************************************************************************************/
	/************************************************************************************************(I) GENERACION ABONO */
	/**********************************************************************************************************************/
	IF (vp_Modulo_Usado!='COV') THEN

	    IF ((dTotal_pago>0 AND vp_sw_doc=0) OR (vp_Modulo_Usado='REA')) THEN

			BEGIN
				vp_gls_error := 'Select CO_SEQ_PAGO.NEXTVAL FROM DUAL(2).';
				SELECT CO_SEQ_PAGO.NEXTVAL  INTO lNumSecuenciCon  FROM DUAL;

				IF (vp_Modulo_Usado='PNT' OR vp_Modulo_Usado='REB') THEN
					BEGIN
						vp_gls_error := 'SELECT  COLUMNA FROM CO_SECARTERA (1).';
						SELECT  COLUMNA
						INTO    dNumColumna
						FROM 	CO_SECARTERA
						WHERE   COD_TIPDOCUM        = iDoc_Pago
						AND     COD_VENDEDOR_AGENTE = iAgenteInterno
						AND     LETRA               = sLetraCobros
						AND     COD_CENTREMI        = vcod_centremi
						AND     NUM_SECUENCI        = lNumSecuenciCon
						AND     COD_CONCEPTO        = iConcep_Pag
						FOR UPDATE;
						
						EXCEPTION
							WHEN NO_DATA_FOUND THEN
								dNumColumna:=0;
					END;
					dNumAuxColumna:=dNumColumna;
					
				ELSE
					dNumAuxColumna:=0;
				END IF;

				IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='PNT') THEN
					vp_Gls_Error := 'FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN';
					BEGIN
						sPasoFolio:=FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(iDoc_Pago,NULL,sCod_oficina,sCod_Operadora,NULL,NULL,NULL,SYSDATE,p_nop_consumo);
						EXCEPTION
							WHEN OTHERS THEN
								RAISE ERROR_PROCESO;
					END;
				ELSE
					IF (vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='REA' AND vp_Modulo_Usado!='REB' AND vp_Modulo_Usado!='TEC') THEN
					
						vp_Gls_Error := 'SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_CICLO_FN';
						sPasoFolio:=FA_FOLIACION_PG.FA_CONSUME_FOLIO_CICLO_FN(iDoc_Pago,NULL,sCod_Oficina, sCod_OperadorAbono,NULL,NULL,NULL,SYSDATE,p_nop_consumo);

					END IF;
				END IF;

				IF (vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='REA' AND vp_Modulo_Usado!='REB' AND vp_Modulo_Usado!='TEC') THEN

                    iPos1             := INSTR(sPasoFolio,';',1);
                    iPos2             := LENGTH(sPasoFolio) - iPos1;
                    sPasoFolio2       := SUBSTR(sPasoFolio,iPos1 + 1, iPos2);
                    iPos3             := INSTR(sPasoFolio2,';',1);
                    iPos4             := INSTR(sPasoFolio2,';',1,2) - iPos3-1;
                    
                    IF iPos4 <= 0 THEN
                        iPos4 := LENGTH(sPasoFolio2)- iPos3;
                    END IF;

					lNum_Folio      := SUBSTR(sPasoFolio2,iPos3 +1,iPos4);
					lPref_Plaza2    := SUBSTR(sPasoFolio2,1,iPos3 - 1);
				ELSE
					IF (vp_Modulo_Usado='TEC') THEN
						lNum_Folio      := vp_Num_transac;
						lPref_Plaza2    := '000';
					ELSE
						lNum_Folio      := 1;
						lPref_Plaza2    := '000';
					END IF;
				END IF;

				IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
					vp_OutRetorno := 100;
				END IF;


				IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='CAJ' OR vp_Modulo_Usado='TEC' OR vp_Modulo_Usado='PAC' OR ((vp_Modulo_Usado='PNT' OR vp_Modulo_Usado='REB') AND dNumAuxColumna=0)) THEN

					vp_Gls_Error := 'INSERT INTO CO_SECARTERA(1).';
					BEGIN
						INSERT INTO CO_SECARTERA (
						   COD_TIPDOCUM,   COD_VENDEDOR_AGENTE,	LETRA,
						   COD_CENTREMI,	NUM_SECUENCI,           COD_CONCEPTO,
						   COLUMNA 	)
						VALUES (
						   idoc_pago_aux,	iAgenteInterno,         sLetraCobros,
						   vcod_centremi,	lNumSecuenciCon,        iConcep_Pag,
						   (dNumAuxColumna+1)	);
						   
						EXCEPTION
							WHEN OTHERS THEN
								RAISE ERROR_PROCESO;
					END;
				ELSE
					IF (dNumAuxColumna=9999) THEN
						dNumAuxColumna:=1;
					ELSE
						dNumAuxColumna:=dNumAuxColumna+1;
					END IF;
					
					vp_Gls_Error := 'UPDATE CO_SECARTERA(1).';
					UPDATE CO_SECARTERA SET
					       COLUMNA=dNumAuxColumna
					WHERE  COD_TIPDOCUM=iDoc_Pago
					AND    COD_VENDEDOR_AGENTE=iAgenteInterno
					AND    LETRA       =sLetraCobros
					AND    COD_CENTREMI=vcod_centremi
					AND    NUM_SECUENCI=lNumSecuenciCon
					AND    COD_CONCEPTO=iConcep_Pag;
					
				END IF;

				IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='TEC') THEN
					vp_retorno:=1;
				ELSE
					IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
						vp_OutRetorno := 100;
					END IF;
				END IF;

				IF (vp_Modulo_Usado!='PNT') THEN
					dNumAuxColumna:=1;
				END IF;

				IF (vp_Modulo_Usado!='TEC' AND vp_Modulo_Usado!='PEX') THEN
					v_folio_ctc:=NULL;
					vaux_num_cuota:=NULL;
					vaux_sec_cuota:=NULL;
					vaux_num_venta:=NULL;
				ELSE
					IF (vp_Modulo_Usado='PEX') THEN
						v_folio_ctc   :='0';
						vaux_num_cuota:=0;
						vaux_sec_cuota:=0;
						vaux_num_venta:=0;
					END IF;
					IF (vp_Modulo_Usado='TEC') THEN
						v_folio_ctc:=vp_folioCTC;
						vaux_num_cuota:=0;
						vaux_sec_cuota:=0;
						vaux_num_venta:=0;
					END IF;
				END IF;

				IF (vp_Modulo_Usado='REA') THEN
					dSaldoAux:=dTotal_pago;
				END IF;

				IF (vp_Modulo_Usado='CAJ' AND vp_cod_servicio=-1) THEN
					dSaldoAux := TO_NUMBER(dTotal_pago-vp_Imp_pago);
				END IF;

				vp_Gls_Error := 'INSERTA ABONO EN CO_CARTERA. Cliente : '||lCod_cliente;
				BEGIN
					INSERT INTO CO_CARTERA
					(
					COD_CLIENTE   , COD_TIPDOCUM       , COD_CENTREMI     ,
					NUM_SECUENCI  , COD_VENDEDOR_AGENTE, LETRA            ,
					COD_CONCEPTO  , COLUMNA            , COD_PRODUCTO     ,
					IMPORTE_DEBE  , 
					IMPORTE_HABER , 
					IND_CONTADO   , IND_FACTURADO      , FEC_EFECTIVIDAD  , 
					FEC_VENCIMIE  ,
					FEC_CADUCIDA  , 
					FEC_ANTIGUEDAD,
					FEC_PAGO      , 
					NUM_ABONADO   , NUM_FOLIO          , PREF_PLAZA       , 
					NUM_CUOTA     , SEC_CUOTA          , NUM_FOLIOCTC     , 
					NUM_VENTA     , COD_OPERADORA_SCL  , COD_PLAZA
					)
					VALUES (
					lCod_cliente   ,  idoc_pago_aux    , vcod_centremi    ,
					lNumSecuenciCon,  iAgenteInterno   , sLetraCobros     ,
					iConcep_Pag    ,  dNumAuxColumna   , vcod_producto    ,
					GE_PAC_GENERAL.REDONDEA(dSaldoAux  , iDecimal, vp_uso),   
					GE_PAC_GENERAL.REDONDEA(vp_Imp_pago, iDecimal, vp_uso), 
					vind_contado   ,  vind_facturado   , SYSDATE          ,
					TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'),
					TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'),    
					TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'), 
					TO_DATE(Fecha_Pago,sFormatoFecha||' HH24:MI:SS'),   
					vnum_abonado   , lNum_Folio        , lPref_Plaza2     , 
					vaux_num_cuota , vaux_sec_cuota    , v_folio_ctc      , 
					vaux_num_venta , sCod_OperadorAbono, sCod_PlazaAbono
					);
					
					EXCEPTION
						WHEN OTHERS THEN
							RAISE ERROR_PROCESO;
				END;

				IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
					vp_OutRetorno := 100;
				END IF;

				IF (vp_Modulo_Usado='CAJ' AND vp_cod_servicio=-1) THEN
					dSaldoAux := TO_NUMBER(dTotal_pago);
				ELSE
					dSaldoAux := TO_NUMBER(dTotal_pago);
				END IF;

				vp_Gls_Error := 'INSERT ABONO EN CO_PAGOSCONC.';
				BEGIN
					INSERT INTO CO_PAGOSCONC (
					   COD_TIPDOCUM       , COD_CENTREMI , NUM_SECUENCI ,
					   COD_VENDEDOR_AGENTE, LETRA        , IMP_CONCEPTO ,
					   COD_PRODUCTO       , COD_TIPDOCREL, COD_AGENTEREL,
					   LETRA_REL          , COD_CENTRREL , NUM_SECUREL  ,
					   COD_CONCEPTO       , COLUMNA      , NUM_ABONADO  ,
					   NUM_FOLIO          , PREF_PLAZA   , NUM_CUOTA    ,
					   SEC_CUOTA          , NUM_FOLIOCTC , NUM_VENTA    ,
					   COD_OPERADORA_SCL  , COD_PLAZA 	)
					VALUES (
					   idoc_pago_aux     , vcod_centremi  , lSec_Pago      ,
					   iAgenteInterno    , sLetraCobros   , GE_PAC_GENERAL.REDONDEA(dSaldoAux, iDecimal, vp_uso),
					   sCodProducto      , idoc_pago_aux  , iAgenteInterno ,
					   sLetraCobros      , vcod_centrrel  , lNumSecuenciCon,
					   iConcep_Pag       , dNumAuxColumna , vnum_abonado   ,
					   lNum_Folio        , lPref_Plaza2   , vaux_num_cuota ,
					   vaux_sec_cuota    , v_folio_ctc    , vaux_num_venta ,
					   sCod_OperadorAbono, sCod_PlazaAbono		);
					EXCEPTION
						WHEN OTHERS THEN
							RAISE ERROR_PROCESO;
				END;

				IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='TEC') THEN
					vp_Gls_Error := 'INSERT INTO CO_RECEXT_PLAZA (Abono).';
					BEGIN
						INSERT INTO CO_RECEXT_PLAZA
						   (COD_RECEXT   , IMP_VALOR, 
						    COD_OPERADORA, COD_PLAZA )
						VALUES
						   (vp_Cod_Recext     , GE_PAC_GENERAL.REDONDEA(dTotal_pago, iDecimal, vp_uso), 
						    sCod_OperadorAbono, sCod_PlazaAbono );
						EXCEPTION
							WHEN OTHERS THEN
								RAISE ERROR_PROCESO;
					END;
				END IF;
			END;
		END IF;
	END IF;

	IF (vp_Modulo_Usado='COV') THEN
		i:=1;
		Tab_CARGA_CARTERA(i).NUM_SECUENCI       := vp_num_secuenci_ca;
		Tab_CARGA_CARTERA(i).COD_TIPDOCUM       := vp_cod_tipdocum_ca;
		Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE:= vp_cod_vend_agente_ca;
		Tab_CARGA_CARTERA(i).LETRA              := vp_letra_ca;
		Tab_CARGA_CARTERA(i).SEC_CUOTA          := vp_sec_cuota_ca;
		Tab_CARGA_CARTERA(i).MONTO              := vp_importe_ca;
		Tab_CARGA_CARTERA(i).NUM_FOLIO          := vp_num_folio;
		Tab_CARGA_CARTERA(i).PREF_PLAZA         := vp_Pref_Plaza;

		IF vp_sw_tpago = 'Total' THEN
			Tab_CARGA_CARTERA(i).SW:='SI';
		ELSE
			Tab_CARGA_CARTERA(i).SW:='NO';
		END IF;
	END IF;

	i:=Tab_CARGA_CARTERA.LAST;
	IF i > 0 THEN
		i:=1;
		FOR i IN Tab_CARGA_CARTERA.FIRST .. Tab_CARGA_CARTERA.LAST LOOP

	    /**********************************************************************************************************************/
	    /*******************************************************************************************(I) PAGO ENTERO / PARCIAL */
	    /**********************************************************************************************************************/
			IF (vp_Modulo_Usado='REB') THEN
				hCodCentremi:=1;
			END IF;

			IF (vp_Modulo_Usado!='REA') THEN

				IF Tab_CARGA_CARTERA(i).SW='SI' THEN
					BEGIN
						vp_Gls_Error := 'LLAMADA A PL CO_P_PAGO_ENTERO. Cliente : '||lCod_cliente;

						CO_P_PAGO_ENTERO(lCod_cliente,Tab_CARGA_CARTERA(i).NUM_SECUENCI,Tab_CARGA_CARTERA(i).COD_TIPDOCUM,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,Tab_CARGA_CARTERA(i).LETRA,hCodCentremi,lSec_Pago,idoc_pago_aux,iAgenteInterno,sLetraCobros,'1',Tab_CARGA_CARTERA(i).SEC_CUOTA, Fecha_Pago);

						vp_Gls_Error := 'LLAMADA A PL CO_CASTIGOS_EXTERNOS (Ent).';
						IF (vp_Modulo_Usado='RED' OR vp_Modulo_Usado='REB') THEN
							vind_pago:=1;
						ELSE
							vind_pago:=0;
						END IF;
						CO_CASTIGOS_EXTERNOS(lCod_cliente, Tab_CARGA_CARTERA(i).NUM_FOLIO, Tab_CARGA_CARTERA(i).PREF_PLAZA, Fecha_Pago, Tab_CARGA_CARTERA(i).MONTO, vind_pago, Tab_CARGA_CARTERA(i).SEC_CUOTA, vRetorno );
						IF vRetorno !=0 THEN
							RAISE ERROR_PROCESO;
						END IF;
					END;
				ELSE
					BEGIN
						vp_Gls_Error := 'LLAMADA A PL CO_P_PAGO_PARCIALES_FACTURA. Cliente : '||lCod_cliente;

						Co_P_Pago_Parciales_Factura(lCod_cliente,Tab_CARGA_CARTERA(i).NUM_SECUENCI,Tab_CARGA_CARTERA(i).COD_TIPDOCUM,Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,Tab_CARGA_CARTERA(i).LETRA,hCodCentremi,lSec_Pago,idoc_pago_aux,iAgenteInterno,sLetraCobros,'1',Tab_CARGA_CARTERA(i).MONTO,Tab_CARGA_CARTERA(i).SEC_CUOTA , Fecha_Pago);

						vp_Gls_Error := 'LLAMADA A PL CO_CASTIGOS_EXTERNOS (Parc).'||lCod_cliente;
						CO_CASTIGOS_EXTERNOS(lCod_cliente, Tab_CARGA_CARTERA(i).NUM_FOLIO, Tab_CARGA_CARTERA(i).PREF_PLAZA, Fecha_Pago, Tab_CARGA_CARTERA(i).MONTO, 1, Tab_CARGA_CARTERA(i).SEC_CUOTA, vRetorno );
						IF vRetorno !=0 THEN
							RAISE ERROR_PROCESO;
						END IF;
					END;
				END IF;
			END IF;

	   /**********************************************************************************************************************/
	   /**************************************************************(I) VERIFICACION CLIENTE EXENTO E/O INMUNE A INTERESES */
	   /**********************************************************************************************************************/
			IF (vp_Modulo_Usado!='COV' AND vp_Modulo_Usado!='REB' AND vp_Modulo_Usado!='RED' AND vp_Modulo_Usado!='REA') THEN
				IF (vp_Modulo_Usado='TEC' AND vp_Emp_recauda!='CTC') THEN
					vp_Gls_Error := 'TECA - EMPRESA DISTINTA DE CTC, NO APLICA INTERES';
				ELSE
					BEGIN
						IF (vp_Modulo_Usado='PNT') THEN
							lCliente_exento:=1;
						END IF;

						vp_Gls_Error := 'SELECT COD_CLIENTE FROM CO_CLIESINTER Cliente : '||lCod_cliente;
						SELECT COD_CLIENTE
						INTO   lCliente_exento
						FROM   CO_CLIESINTER
						WHERE  COD_CLIENTE = lCod_cliente
						AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
						AND    COD_EXENCION = 'SINTE';
						EXCEPTION
							WHEN NO_DATA_FOUND THEN
								lCliente_exento:=0;
					END;

					IF (vp_Modulo_Usado!='A') THEN
						BEGIN
							vp_Gls_Error := 'SELECT COD_CLIENTE FROM CO_INMUNIDAD (1). Cliente : '||lCod_cliente;
							SELECT /*+ INDEX (CO_INMUNIDAD AK_CO_INMUNIDAD_GE_CLIENTES) */
							       distinct (COD_CLIENTE) COD_CLIENTE		
							INTO	lCliente_inmune
							FROM	CO_INMUNIDAD
							WHERE	COD_CLIENTE= lCod_cliente
							AND		SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
							EXCEPTION
								WHEN NO_DATA_FOUND THEN
									lCliente_inmune:=0;
						END;
	/**********************************************************************************************************************/
	/**************************************************************(F) VERIFICACION CLIENTE EXENTO E/O INMUNE A INTERESES */
	/**********************************************************************************************************************/
						IF (lCliente_inmune=0) THEN
							im:=0; 
							Intereses_Mora.DELETE;	
							FOR rPgsconc IN Curs_pagosconc (GV_fecha_actual,
							                                Tab_CARGA_CARTERA(i).COD_TIPDOCUM,
							                                Tab_CARGA_CARTERA(i).NUM_SECUENCI,
															Tab_CARGA_CARTERA(i).NUM_FOLIO   ,
															Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE,
															Tab_CARGA_CARTERA(i).LETRA,
															Tab_CARGA_CARTERA(i).COD_CENTREMI ) LOOP

								IF (vp_Modulo_Usado!='A' AND lCliente_exento=0) THEN
									vp_Gls_Error := 'SELECT CO_SEQ_TRANSACINT.NEXTVAL FROM DUAL (1) .';
									SELECT CO_SEQ_TRANSACINT.NEXTVAL  INTO lSecuTransac1  FROM DUAL;

									lNumFolioPL := Tab_CARGA_CARTERA(i).NUM_FOLIO;
									lNumPrefijo_PlazaPL := Tab_CARGA_CARTERA(i).PREF_PLAZA;
									lNumSecuenPL:= Tab_CARGA_CARTERA(i).NUM_SECUENCI;
									iCod_DocumPL:= Tab_CARGA_CARTERA(i).COD_TIPDOCUM;
									
									dMonto_PL   := rPgsconc.IMP_CONCEPTO;
									iSec_CuotaPL:= Tab_CARGA_CARTERA(i).SEC_CUOTA;
									LN_Imp_concepto:= rPgsconc.COD_CONCEPTO;
									LN_Columna:= rPgsconc.COLUMNA;	

									IF (vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='TEC') THEN
										v_Fecha_efec_aux_trunc:=SUBSTR(Fecha_Pago,1,10);
									ELSE
										v_Fecha_efec_aux_trunc:=SUBSTR(v_Fecha_efec_aux,1,10);
									END IF;


									vp_Gls_Error := 'LLAMADA A PL Co_Interesmora_Pg.CO_CALCULO_PR (1). Cliente : ' || lCod_cliente;
									Co_Interesmora_Pg.Co_Calculo_Pr(lSecuTransac1,lCod_cliente,lNumFolioPL,lNumPrefijo_PlazaPL,lNumSecuenPL,iCod_DocumPL,dMonto_PL,iSec_CuotaPL,v_Fecha_efec_aux_trunc,LN_Imp_concepto,LN_Columna);

									SELECT NVL(SUM(MTO_INTERESES),0), NVL(SUM(FAC_COBRO),0), NVL(SUM(NUM_DIAS),0)
									INTO   dImp_Cargo, dFac_cobro, idiasint
									FROM   CO_TRANSACINT
									WHERE  NUM_TRANSACCION = lSecuTransac1;
									
									im:= im + 1;
									Intereses_Mora(im).num_transaccion:=lSecuTransac1;
								END IF;

		/**********************************************************************************************************************/
		/********************************************************************************************(I) APLICACION INTERESES */
		/**********************************************************************************************************************/
								IF ((vp_Modulo_Usado!='PNT') OR (vp_Modulo_Usado='PNT' AND (vp_cod_servicio=2) OR (vp_cod_servicio=3))) THEN

		/**********************************************************************************************************************/
		/************************************************************************************************(I) COBRANZA EXTERNA */
		/**********************************************************************************************************************/
									bValidaCliente := 0;
									IF  Tab_CARGA_CARTERA(i).DES_ABREVIADA = 'CDO' OR   Tab_CARGA_CARTERA(i).DES_ABREVIADA = 'CPA' OR
										Tab_CARGA_CARTERA(i).DES_ABREVIADA = 'SCE' OR   Tab_CARGA_CARTERA(i).DES_ABREVIADA = 'SCP' OR
										Tab_CARGA_CARTERA(i).DES_ABREVIADA = 'SPR' OR   Tab_CARGA_CARTERA(i).DES_ABREVIADA = 'SCA' THEN
										bValidaCliente := 1;
									END IF;

									IF (bValidaCliente=0) THEN
										iCod_Tipdocum:=Tab_CARGA_CARTERA(i).COD_TIPDOCUM;
										iInd_facturado:=Tab_CARGA_CARTERA(i).IND_FACTURADO;
										BEGIN
											vp_Gls_Error := 'SELECT COD_CLIENTE FROM CO_COBEXTERNADOC (2). Cliente : '||lCod_cliente;
											IF Tab_CARGA_CARTERA(i).NUM_CUOTA IS NULL OR Tab_CARGA_CARTERA(i).SEC_CUOTA IS NULL THEN
												BEGIN
													SELECT /*+ INDEX (CO_COBEXTERNADOC AK_COCOBEXTERNADOC_CLIFOLTDOC) */
													UNIQUE COD_CLIENTE  ,   NUM_IDENT    ,  TO_CHAR(FEC_VENCIMIE,sFormatoFecha), COD_TIPIDENT
													INTO    lCliente_CobExterna ,   sIdentExterna,  sFechaVencExter, sCodTipIdent
													FROM    CO_COBEXTERNADOC
													WHERE   COD_CLIENTE  =  lCod_cliente
													AND     NUM_FOLIO    =  Tab_CARGA_CARTERA(i).NUM_FOLIO
													AND     PREF_PLAZA   =  Tab_CARGA_CARTERA(i).PREF_PLAZA
													AND     COD_TIPDOCUM =  Tab_CARGA_CARTERA(i).COD_TIPDOCUM
													AND     IND_INFORMADO = 'S';
													EXCEPTION
														WHEN NO_DATA_FOUND THEN
															lCliente_CobExterna:=0;
												END;
											ELSE
												BEGIN
													SELECT /*+ INDEX (CO_COBEXTERNADOC AK_COCOBEXTERNADOC_CLIFOLTDOC) */
													UNIQUE COD_CLIENTE   ,   NUM_IDENT    ,   TO_CHAR(FEC_VENCIMIE,sFormatoFecha), COD_TIPIDENT
													INTO   lCliente_CobExterna  ,   sIdentExterna,   sFechaVencExter, sCodTipIdent
													FROM   CO_COBEXTERNADOC
													WHERE  COD_CLIENTE  = lCod_cliente
													AND    NUM_FOLIO    = Tab_CARGA_CARTERA(i).NUM_FOLIO
													AND    PREF_PLAZA   = Tab_CARGA_CARTERA(i).PREF_PLAZA
													AND    COD_TIPDOCUM = Tab_CARGA_CARTERA(i).COD_TIPDOCUM
													AND    NUM_CUOTAS   = Tab_CARGA_CARTERA(i).NUM_CUOTA
													AND    SEC_CUOTA    = Tab_CARGA_CARTERA(i).SEC_CUOTA
													AND    IND_INFORMADO = 'S';
													EXCEPTION
														WHEN NO_DATA_FOUND THEN
															lCliente_CobExterna:=0;
												END;
											END IF;
										END;

										IF lCliente_CobExterna > 0 THEN
											bValidaCliente := 1;
											IF (iCod_Tipdocum > 47 AND iCod_Tipdocum < 57) THEN
												IF (iInd_facturado=1 OR (iInd_facturado=0 AND TO_DATE(Tab_CARGA_CARTERA(i).FEC_VENCIMIE,sFormatoFecha)<SYSDATE)) THEN
													bValidaCliente := 0;
												END IF;
											ELSE
												IF iCod_Tipdocum != 5 THEN
													bValidaCliente := 0;
												END IF;
											END IF;

											IF (bValidaCliente=0) THEN
												vp_Gls_Error := 'SELECT FECHA FROM DUAL (2).';
												iDifFecha:=TRUNC(SYSDATE - TO_DATE(Tab_CARGA_CARTERA(i).FEC_VENCIMIE,sFormatoFecha));

												IF iDifFecha >= 15 THEN
													noEncontro:=1;
													BEGIN
														vp_Gls_Error := 'SELECT FACTOR_INT FROM CO_INTERESES';
														BEGIN
															SELECT CIN.dias_aplicacion
															INTO   iDias_aplica
															FROM   ge_clientes cli,
															       CO_CATEGORIAS_TD cat,
																   CO_INTERESES CIN,
																   CO_CATCOBCLIE_TD catcli
															WHERE ((( vp_Modulo_Usado != 'PNT' AND vp_Modulo_Usado != 'PEX' AND vp_Modulo_Usado != 'TEC' )
																   AND NUM_SECUENCIA > 0)
																   OR ((vp_Modulo_Usado = 'PNT' OR vp_Modulo_Usado = 'PEX' OR vp_Modulo_Usado = 'TEC' )))
													          AND  cli.cod_cliente = lCod_cliente
															  AND  cli.cod_categoria = catcli.cod_catecli
															  AND  cat.cod_categoria = catcli.cod_catecob
															  AND  cat.cod_tasa = CIN.cod_tasa
															  AND  TRUNC(SYSDATE) BETWEEN TRUNC(fec_vigencia_dd_dh) AND TRUNC(fec_vigencia_hh_dh);

															EXCEPTION
																WHEN NO_DATA_FOUND THEN
																	iDias_aplica:=0;
														END;
													END;

													BEGIN
														vp_Gls_Error := 'SELECT (trunc(SYSDATE) - (trunc(FEC_VENCIMIE) + iDias_aplica)) FROM CO_CARTERA. Cliente : '||lCod_cliente;
														SELECT (TRUNC(SYSDATE) - (TRUNC(FEC_VENCIMIE) + iDias_aplica)),
															   NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0),
															   IND_FACTURADO   ,
															   COD_TIPDOCUM
														  INTO idiasint, dMon_deuda, iInd_facturado, iCod_Tipdocum
														  FROM CO_CARTERA
														 WHERE COD_CLIENTE  = lCod_cliente
														   AND COD_TIPDOCUM = Tab_CARGA_CARTERA(i).COD_TIPDOCUM
														   AND NUM_SECUENCI = Tab_CARGA_CARTERA(i).NUM_SECUENCI
														   AND NUM_FOLIO    = Tab_CARGA_CARTERA(i).NUM_FOLIO
														   AND PREF_PLAZA   =  Tab_CARGA_CARTERA(i).PREF_PLAZA
														   AND (SEC_CUOTA    = Tab_CARGA_CARTERA(i).SEC_CUOTA OR SEC_CUOTA IS NULL)
														GROUP BY FEC_VENCIMIE, COD_TIPDOCUM, IND_FACTURADO;
														EXCEPTION
															WHEN NO_DATA_FOUND THEN
																noEncontro:=0;
													END;

													IF (Tab_CARGA_CARTERA(i).SW='NO') THEN
														dMon_deuda:=Tab_CARGA_CARTERA(i).MONTO;
													END IF;

													BEGIN
														vp_Gls_Error := 'SELECT SUM(A.IMPORTE_DEBE - A.IMPORTE_HABER) FROM CO_CARTERA A, CO_CONCEPTOS B (3). Cliente : '||lCod_cliente;
														SELECT NVL(SUM(A.IMPORTE_DEBE - A.IMPORTE_HABER),0)
														INTO   dMonto_carrier
														FROM   CO_CARTERA A, CO_CONCEPTOS B
														WHERE  A.COD_CLIENTE  = lCod_cliente
														AND    A.NUM_FOLIO    = TAB_CARGA_CARTERA(I).NUM_FOLIO
														AND    A.PREF_PLAZA   =  Tab_CARGA_CARTERA(I).PREF_PLAZA
														AND    A.NUM_SECUENCI = TAB_CARGA_CARTERA(I).NUM_SECUENCI
														AND    A.COD_CONCEPTO = B.COD_CONCEPTO
														AND    B.COD_TIPCONCE = 4 ;
														EXCEPTION
															WHEN NO_DATA_FOUND THEN
																dMonto_carrier:=0;
													END;

													IF dMonto_carrier > 0 THEN
														dMon_deuda := dMon_deuda - dMonto_carrier;
													END IF;

													IF noEncontro = 1 THEN
														vp_Gls_Error := 'SELECT CO_SEQ_TRANSACINT.NEXTVAL FROM DUAL (2) .';
														SELECT CO_SEQ_TRANSACINT.NEXTVAL  INTO  lSecuTransac2  FROM DUAL;

														vp_Gls_Error := 'LLAMADA A PL CO_P_CALC_COMISIONES (2) . Cliente : '||lCod_cliente;

														Co_P_Calc_Comisiones(lSecuTransac2, dMon_deuda, lCod_cliente, vp_oripago_aux, Tab_CARGA_CARTERA(i).NUM_SECUENCI, Tab_CARGA_CARTERA(i).COD_TIPDOCUM, lSecCompago,vRetorno);

														IF (vRetorno>0) THEN
															vp_Gls_Error:=vp_Gls_Error||' - Error Co_P_Calc_Comisiones. Secuencia : '||lSecuTransac2;
															RAISE ERROR_CALC_COMISIONES;
														ELSE
															vp_Gls_Error := 'SELECT COD_RETORNO FROM CO_TRANSACINTER (2) .';
															SELECT SUM(MTO_INTERES)
															INTO   dMto_interes
															FROM   CO_TRANSACINTER
															WHERE  NUM_TRANSACCION = lSecuTransac2;

															IF dMto_interes > 0 THEN
																BEGIN
																	vp_Gls_Error := 'SELECT COD_ENTIDAD FROM CO_COBEXTERNA (2) .';
																	SELECT
																	RTRIM(COD_ENTIDAD)
																	INTO
																	sCod_Entidad
																	FROM
																	CO_COBEXTERNA
																	WHERE
																	NUM_IDENT  = sIdentExterna
																	AND COD_TIPIDENT = sCodTipIdent
																	AND COD_MOVIMIENTO NOT IN( 'B','R')
																	AND COD_ENVIO NOT IN ( 'B', 'R');
																	EXCEPTION
																		WHEN NO_DATA_FOUND THEN
																			sCod_Entidad :='NULL';
																END;

																IF sCod_Entidad IS NOT NULL THEN
																	BEGIN
																		vp_Gls_Error := 'SELECT COD_TIPDOCUM,COD_CENTREMI FROM CO_PAGOS.';
																		SELECT /*+ INDEX (CO_PAGOS AK_CO_PAGOS_CLIENTE) */
																		COD_TIPDOCUM ,   COD_CENTREMI,
																		NUM_SECUENCI ,   COD_VENDEDOR_AGENTE , LETRA
																		INTO    iCodTipDocum ,   iCodCentremi,
																		iNumSecuenci ,   iCodVendedorAgente  , sLetra
																		FROM   CO_PAGOS
																		WHERE   COD_CLIENTE = lCod_cliente
																		AND    NUM_COMPAGO = lSecCompago
																		AND    PREF_PLAZA  = lPref_Plaza;

																		IF (vp_Modulo_Usado!='PNT') THEN
																			dMontoInteresAcum:=0;
																		END IF;

																		FOR rTramo IN TRANSCINTER LOOP
																			IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
																				vp_OutRetorno := 100;
																			END IF;

																			dMontoInteresAcum:= dMontoInteresAcum + rTramo.MTO_INTERES;
																			vp_Gls_Error := 'INSERT INTO CO_INTERCOBAPLI. Cliente : '||lCod_cliente;
																			IF (vp_Modulo_Usado='TEC') THEN
																				pref_plaza:=NULL;
																				tec_letra:=Tab_CARGA_CARTERA(i).LETRA;
																			ELSE
																				tec_letra:='I';
																				pref_plaza:=Tab_CARGA_CARTERA(i).PREF_PLAZA;
																			END IF;

																			INSERT  INTO CO_INTERCOBAPLI
																			(
																				NUM_SECUENCI,	COD_TIPDOCUM,   COD_VENDEDOR_AGENTE,
																				LETRA,			COD_CENTREMI,   NUM_SECUREL,
																				COD_TIPDOCREL,  COD_AGENTEREL,  LETRA_REL,
																				COD_CENTRREL,   NUM_CARGO,  	NUM_FOLIO,
																				PREF_PLAZA, 	IMP_PAGO,   	IMP_CARGO,
																				FACTOR_COBRO,   FEC_PAGO,   	COD_CLIENTE,
																				COD_CICLFACT,   IND_FACTURADO,  NUM_CUOTA,
																				SEC_CUOTA,  	NUM_IDENT,  	FEC_VENCIMIE,
																				COD_ENTIDAD,    IMP_TRAMO
																			)
																			VALUES (
																				iNumSecuenci,   iCodTipDocum,   iCodVendedorAgente,
																				sLetra,     iCodCentremi,   Tab_CARGA_CARTERA(i).NUM_SECUENCI,
																				iCodTipDocum,   iCodVendedorAgente, tec_letra,
																				iCodCentremi,   vnum_cargo, Tab_CARGA_CARTERA(i).NUM_FOLIO,
																				RTRIM(pref_plaza), GE_PAC_GENERAL.REDONDEA(rTramo.MTO_PAGO, iDecimal, vp_uso), GE_PAC_GENERAL.REDONDEA(rTramo.MTO_INTERES, iDecimal, vp_uso),
																				rTramo.POR_TRAMO, TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'), lCod_cliente,
																				vcod_ciclfact,  'N',        Tab_CARGA_CARTERA(i).NUM_CUOTA,
																				Tab_CARGA_CARTERA(i).SEC_CUOTA, sIdentExterna, TO_DATE(sFechaVencExter,sFormatoFecha),
																				sCod_Entidad,   GE_PAC_GENERAL.REDONDEA(dMon_deuda, iDecimal, vp_uso)
																			);
																		END LOOP;
																	END;
																END IF;
															END IF;
														END IF;
													END IF;
												END IF;
											END IF;
										END IF;

										IF ((dMontoInteresAcum > 0 AND vp_Modulo_Usado!='PNT') OR (vp_Modulo_Usado='PNT' AND dMontoInteresAcum>0 AND i=Tab_CARGA_CARTERA.LAST)) THEN
											BEGIN
												vp_Gls_Error := 'SELECT GE_SEQ_CARGOS.NEXTVAL FROM DUAL (2).'   ;
												SELECT GE_SEQ_CARGOS.NEXTVAL  INTO lSecCargo FROM DUAL;

												vp_Gls_Error := 'LLAMADA A PL CO_GEN_CARGO (2). Cliente : '||lCod_cliente;
												Co_Gen_Cargo(lCod_cliente, vnum_abonado, sConcepto_Cobranza, dMontoInteresAcum, sCod_Moneda, vcod_producto, lSecCargo);

												vp_Gls_Error := 'SELECT COD_CICLFACT FROM GE_CARGOS (2).';
												SELECT COD_CICLFACT
												INTO iCiclo_Fact
												FROM   GE_CARGOS
												WHERE  NUM_CARGO = lSecCargo;

												IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
													vp_OutRetorno := 100;
												END IF;

												vp_Gls_Error := 'UPDATE CO_INTERCOBAPLI. Cliente : '||lCod_cliente;

												BEGIN
													UPDATE /*+ INDEX (CO_INTERCOBAPLI AK_CO_INTERCOBAPLI_NUM_SEC)*/ CO_INTERCOBAPLI SET
													IND_FACTURADO = 'S',
													NUM_CARGO     = lSecCargo,
													COD_CICLFACT  = iCiclo_Fact
													WHERE ((COD_TIPDOCUM=iCodTipDocum AND (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='PNT' OR vp_Modulo_Usado='TEC'))
													      OR (((vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='TEC' AND vp_Modulo_Usado!='PNT')
													AND    NUM_SECUENCI  = iNumSecuenci
													AND    COD_TIPDOCUM  = iCodTipDocum
													AND    COD_VENDEDOR_AGENTE = iCodVendedorAgente
													AND    LETRA         = sLetra
													AND    COD_CENTREMI  = iCodCentremi )))
													AND    IND_FACTURADO = 'N'
													AND    COD_CLIENTE   = lCod_cliente;
												END;
											END;
										END IF;
									END IF;
								END IF;
							END LOOP;
		/**********************************************************************************************************************/
		/********************************************************************************************(I) APLICACION INTERESES */
		/**********************************************************************************************************************/
							IF ((vp_Modulo_Usado!='PNT') OR (vp_Modulo_Usado='PNT' AND (vp_cod_servicio=2) OR (vp_cod_servicio=3))) THEN
								--IF (dImp_Cargo>0 AND vp_Modulo_Usado!='A' AND lCliente_exento=0) THEN
								IF (vp_Modulo_Usado!='A' AND lCliente_exento=0) THEN
									BEGIN
										im:=1;
										IF Intereses_Mora.COUNT > 0 then   -- Requerimiento de Soporte 71209 mgg 02-10-2008
											FOR im IN Intereses_Mora.FIRST .. Intereses_Mora.LAST LOOP
												FOR rRegintereses IN cur_intereses(Intereses_Mora(im).NUM_TRANSACCION) LOOP
													dImp_Cargo := rRegintereses.intereses;
													IF dImp_Cargo > 0 THEN
														dFac_cobro := rRegintereses.factor_cobro;
														idiasint := rRegintereses.dias;
														sConcepto_Mora := rRegintereses.cod_concfact;
														vp_Gls_Error := 'SELECT GE_SEQ_CARGOS.NEXTVAL FROM DUAL (1)';
														SELECT	GE_SEQ_CARGOS.NEXTVAL  INTO	lSecCargo  FROM	DUAL;

														vp_Gls_Error := 'LLAMADA A PL CO_GEN_CARGO (1). Cliente : '||lCod_cliente;
														Co_Gen_Cargo(lCod_cliente, vnum_abonado, sConcepto_Mora , dImp_Cargo, sCod_Moneda, vcod_producto, lSecCargo);

														vp_Gls_Error := 'SELECT COD_CICLFACT FROM GE_CARGOS (1)';
														SELECT COD_CICLFACT
														  INTO iCiclo_Fact
														  FROM GE_CARGOS
														 WHERE NUM_CARGO = lSecCargo;

														IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
															vp_OutRetorno := 100;
														END IF;

														vp_Gls_Error := 'INSERT INTO CO_INTERESAPLI. Cliente : '||lCod_cliente;

														BEGIN

															iCod_Vendedor_Agente := iAgenteInterno;
															INSERT INTO CO_INTERESAPLI
															(
																NUM_SECUENCI,            COD_TIPDOCUM,        COD_VENDEDOR_AGENTE,
																LETRA,                   COD_CENTREMI,        NUM_SECUREL,
																COD_TIPDOCREL,           COD_AGENTEREL,       LETRA_REL,
																COD_CENTRREL,            NUM_CARGO,           NUM_FOLIO,
																PREF_PLAZA,              SEC_CUOTA,           NUM_CUOTA,
																IMP_DEUDA,               IMP_CARGO,           FACTOR_COBRO,
																NUM_DIAS,                COD_CLIENTE,         COD_CICLFACT,
																IND_FACTURADO,           FEC_CALCULO,         COD_MODULO
															)
															VALUES
															(
																lSec_Pago,               iDoc_Pago,           iCod_Vendedor_Agente,
																sLetraCobros,            vcod_centremi,       Tab_CARGA_CARTERA(i).NUM_SECUENCI,
																Tab_CARGA_CARTERA(i).COD_TIPDOCUM, Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE, Tab_CARGA_CARTERA(i).LETRA,
																vcod_centrrel,           lSecCargo,           Tab_CARGA_CARTERA(i).NUM_FOLIO,
																Tab_CARGA_CARTERA(i).PREF_PLAZA, Tab_CARGA_CARTERA(i).SEC_CUOTA, Tab_CARGA_CARTERA(i).NUM_CUOTA,
																GE_PAC_GENERAL.REDONDEA(rRegintereses.imp_cargo, iDecimal, vp_uso), GE_PAC_GENERAL.REDONDEA(dImp_Cargo, iDecimal, vp_uso), dFac_cobro,
																idiasint,     lCod_cliente,       iCiclo_Fact,
																NULL, SYSDATE, vp_Modulo_Usado
															);
															EXCEPTION
																WHEN OTHERS THEN
																	vp_Gls_Error:=SQLERRM;
																	RAISE ERROR_PROCESO;
														END;
													END IF; --IF de Monto Interes > 0
												END LOOP; --Cursor de Interes por Mora
											END LOOP;
										END IF; -- IF Intereses_Mora.COUNT > 0 then
									END;
								END IF;
							END IF;
		/**********************************************************************************************************************/
		/********************************************************************************************(F) APLICACION INTERESES */
		/**********************************************************************************************************************/
						END IF;
					END IF;
				END IF;
			END IF;
	/**********************************************************************************************************************/
	/************************************************************************************************(F) COBRANZA EXTERNA */
	/**********************************************************************************************************************/
			IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='TEC') THEN
				BEGIN
					vp_Gls_Error := 'INSERT INTO CO_RECEXT_PLAZA.';
					INSERT INTO CO_RECEXT_PLAZA
					    (COD_RECEXT        , IMP_VALOR ,
					     COD_OPERADORA     , COD_PLAZA )
					VALUES 
					    (vp_Cod_Recext     , GE_PAC_GENERAL.REDONDEA(Tab_CARGA_CARTERA(i).MONTO, iDecimal, vp_uso),
					     sCod_OperadorAbono, sCod_PlazaAbono ) ;
				END;
			END IF;
		END LOOP;
	END IF;

	/**********************************************************************************************************************/
	/******************************************************************************************(I) REGISTRO DE DOCUMENTOS */
	/**********************************************************************************************************************/
	IF (vp_tip_valor=4 AND vp_Modulo_Usado='PNT') THEN
		BEGIN
			vp_gls_error := 'SELECT A.NUM_IDENT FROM GE_CLIENTES A, GE_TIPIDENT B. Cliente :'||lCod_cliente;
			SELECT A.NUM_IDENT,A.COD_TIPIDENT
			  INTO sNumIdent,sCod_tipident
			  FROM GE_CLIENTES A, GE_TIPIDENT B
			 WHERE A.COD_CLIENTE  = lCod_cliente
			   AND A.COD_TIPIDENT = B.COD_TIPIDENT;

			vp_gls_error := 'SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL FROM DUAL.';
			SELECT CO_SEQ_PAGOCHEQUE.NEXTVAL INTO sNumSecueChe FROM DUAL;

			vp_gls_error := 'INSERT INTO CO_DOCUMENTOS. Secuenci cheque : '||sNumSecueChe;
			INSERT INTO CO_DOCUMENTOS (
				NUM_SECUENCI      , COD_TIPDOCUM    , NUM_SEC_CUOTA     ,
				COD_TIPVALOR      , NUM_CONVENIO    , NUM_DOCUMENTO     ,
				COD_OFICINA       , COD_CAJA        , NUM_SECUMOV       ,
				COD_BANCO         , COD_SUCURSAL    , COD_PLAZA         ,
				CTA_CORRIENTE     , COD_AUTORIZACION, IND_TITULAR       ,
				NUM_IDENT         , 
				IMPORTE_DOCUM     , 
				FECHA_VENCTO      ,
				FECHA_DEPOSITO    , NUN_DEPOSITO    , COD_BANCO_DEPO    ,
				COD_SUCURSAL_DEPO , COD_PLAZA_DEPO  , CTA_CORRIENTE_DEPO,
				COD_ESTADO        , COD_PROTESTO    , COD_UBICACION     ,
				FEC_ULT_MOVIMIENTO, NOM_USUARIO     , COD_OPERADORA_SCL , 
				COD_PLAZA_OP      , COD_TIPIDENT
			) VALUES (
				sNumSecueChe       , vcod_tipdocum , vnum_sec_cuota    ,
				vp_tip_valor       , NULL          , vp_num_docum      ,
				vp_Cod_Oficina     , icod_caja     , nSecuencia        ,
				vp_Cod_banco       , NULL          , NULL              ,
				vp_ctecorriente_aux, NULL          , vind_titular      ,
				sNumIdent          , 
				GE_PAC_GENERAL.REDONDEA(vp_imp_pago, iDecimal, vp_uso),  
				TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'),
				NULL               , NULL          , NULL              ,
				NULL               , NULL          , NULL              ,
				vcod_estado        , NULL          , vcod_ubicacion    ,
				SYSDATE            , sNom_User     , sCod_OperadorAbono,
				sCod_PlazaAbono    , sCod_tipident
			);

			i:=Tab_CARGA_CARTERA.LAST;
			IF i>0 THEN
				i:=1;
				FOR i IN Tab_CARGA_CARTERA.FIRST .. Tab_CARGA_CARTERA.LAST LOOP
					sNumSecuenciaDet:=sNumSecuenciaDet + 1;
					vp_gls_error := 'INSERT INTO CO_DET_DOCUMENTOS (2). Cliente :'||lCod_cliente;
					INSERT INTO CO_DET_DOCUMENTOS
					   (NUM_SECUENCI      , NUM_DOCUMENTO    , NUM_SECUENCI_DOC,
					    COD_CLIENTE       , NUM_SECUENCI_PAGO, NUM_SECUENCI_CA ,
					    COD_TIPDOCUM_CA   ,    
					    COD_VEND_AGENTE_CA,
					    LETRA_CA          ,
					    NUM_FOLIO_CA      ,
					    PREF_PLAZA        ,
					    NUM_CUOTA_CA      ,
					    SEC_CUOTA_CA      ,
					    IMPORTE_CA)
					VALUES (
					    sNumSecuenciaDet, vp_num_docum, sNumSecueChe,
					    lCod_cliente    , lSec_Pago   , Tab_CARGA_CARTERA(i).NUM_SECUENCI,
					    Tab_CARGA_CARTERA(i).COD_TIPDOCUM       , 
					    Tab_CARGA_CARTERA(i).COD_VENDEDOR_AGENTE, 
					    Tab_CARGA_CARTERA(i).LETRA              ,
					    Tab_CARGA_CARTERA(i).NUM_FOLIO          , 
					    Tab_CARGA_CARTERA(i).PREF_PLAZA         , 
					    Tab_CARGA_CARTERA(i).NUM_CUOTA          ,
					    Tab_CARGA_CARTERA(i).SEC_CUOTA          , 
					    Tab_CARGA_CARTERA(i).MONTO);
				END LOOP;
			END IF;

			BEGIN
				vp_gls_error := 'SELECT  COLUMNA FROM CO_SECARTERA (2).';
				
				SELECT COLUMNA
				INTO   dNumColumna
				FROM   CO_SECARTERA
				WHERE  COD_TIPDOCUM   = vcod_tipdocum
				AND    COD_VENDEDOR_AGENTE  = iAgenteInterno
				AND    LETRA          = sLetraCobros
				AND    COD_CENTREMI   = vcod_centremi
				AND    NUM_SECUENCI   = sNumSecueChe
				AND    COD_CONCEPTO   = iConcep_Pag
				FOR UPDATE;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
						dNumColumna:=0;
			END;

			IF dNumColumna = 9999 THEN
				dNumAuxColumna := 1;
			ELSE
				dNumAuxColumna := dNumColumna + 1;
			END IF;

			IF (dNumColumna>0) THEN
				BEGIN
					vp_gls_error := 'UPDATE CO_SECARTERA (2).';
					UPDATE
					CO_SECARTERA SET
					COLUMNA = dNumAuxColumna
					WHERE  COD_TIPDOCUM     = vcod_tipdocum
					AND    COD_VENDEDOR_AGENTE  = iAgenteInterno
					AND    LETRA            = sLetraCobros
					AND    COD_CENTREMI     = vcod_centremi
					AND    NUM_SECUENCI     = sNumSecueChe
					AND    COD_CONCEPTO     = iConcep_Pag;
				END;
			ELSE
				BEGIN
					vp_gls_error := 'INSERT INTO CO_SECARTERA(2).';
					INSERT INTO CO_SECARTERA
					   (COD_TIPDOCUM, COD_VENDEDOR_AGENTE, LETRA       ,
					    COD_CENTREMI, NUM_SECUENCI       , COD_CONCEPTO,
					    COLUMNA)
					VALUES  
					   (vcod_tipdocum, iAgenteInterno, SLetraCobros,
					    vcod_centremi, SNumSecueChe  , iConcep_Pag ,
					    dNumColumna+1);
				END;
			END IF;

			vp_gls_error := 'INSERT CHEQUE INTO CO_CARTERA (2). Cliente :'||lCod_cliente;
			INSERT INTO CO_CARTERA (
				COD_CLIENTE    , COD_TIPDOCUM       , COD_CENTREMI ,
				NUM_SECUENCI   , COD_VENDEDOR_AGENTE, LETRA        ,
				COD_CONCEPTO   , COLUMNA            , COD_PRODUCTO ,
				IMPORTE_DEBE   , 
				IMPORTE_HABER  , IND_CONTADO        , IND_FACTURADO, 
				FEC_EFECTIVIDAD, 
				FEC_VENCIMIE   ,
				FEC_CADUCIDA   ,
				FEC_ANTIGUEDAD ,
				FEC_PAGO       ,
				NUM_ABONADO    , NUM_FOLIO          , PREF_PLAZA   ,
				NUM_CUOTA      , SEC_CUOTA          , NUM_FOLIOCTC ,
				NUM_VENTA      , COD_OPERADORA_SCL  , COD_PLAZA
			) VALUES (
				lCod_cliente  , vcod_tipdocum     , vcod_centremi,
				sNumSecueChe  , iAgenteInterno    , sLetraCobros ,
				iConcep_Pag   , dNumColumna       , sCodProducto ,
				GE_PAC_GENERAL.REDONDEA(vp_imp_pago, iDecimal, vp_uso), 
				vimporte_haber, vind_contado      , vind_facturado, 
				TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'), 
				TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'),
				TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'),
				TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'),
				TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS'),
				vnum_abonado  , vp_num_docum      , NULL         ,
				vnum_cuota    , vsec_cuota        , NULL         ,
				NULL          , sCod_OperadorAbono, sCod_PlazaAbono
			);
		END;
	END IF;

	IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='TEC') THEN
	    BEGIN
	        vRetorno:=0;
	        IF (vp_Modulo_Usado='PEX') THEN
	            vp_Gls_Error := 'INSERT A CO_TRANSAC_EXTERNA.';
	            INSERT INTO CO_TRANSAC_EXTERNA
	                (EMP_RECAUDADORA, FEC_EFECTIVIDAD, NUM_TRANSACCION,
	                 NUM_COMPAGO    , PREF_PLAZA     , COD_RETORNO    ,
	                 GLOSA_RETORNO)
	            VALUES 
	                (vp_emp_recauda_aux , TO_DATE(vp_Fecha_efec,sFormatoFecha||' HH24:MI:SS'), vp_Num_transac ,
	                 lSecCompago        , lPref_Plaza                                        , vRetorno       ,
	                 'OK');
	        END IF;

	        vp_Secu_Compago:=lSecCompago;
	        vp_Pref_Plaza  :=lPref_Plaza;
	    END;
	END IF;

	IF (vp_Modulo_Usado='PNT') THEN
	    vp_gls_error := 'UPDATE CO_INTERFAZ_PAGOS. Num_transaccion :'||vp_transaccion;
	        UPDATE
	        CO_INTERFAZ_PAGOS SET
	                NUM_COMPAGO= lSecCompago,
	                PREF_PLAZA = lPref_Plaza,
	                COD_ESTADO = 'PRO'
	        WHERE  EMP_RECAUDADORA  = vp_emp_recauda
	          AND  COD_CAJA_RECAUDA = vp_caja
	          AND  FEC_EFECTIVIDAD  = TO_DATE(v_Fecha_efec_aux,sFormatoFecha||' HH24:MI:SS')
	          AND  NUM_TRANSACCION  = vp_transaccion
	          AND  TIP_TRANSACCION  = 'K';
	END IF;

    /* Inicio MIX-09003 25.02.2010  MQG */
	IF (vp_Modulo_Usado='PEX') THEN
	    vp_OutRetorno:=1;
	
	    vp_Gls_Error := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL FROM DUAL.';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO lNum_Transaccion FROM DUAL;
	
	    vp_Gls_Error := 'LLAMADA A PL CO_CANCELACION_PG. Cliente : '||lCod_cliente;
		CO_CANCELACION_PG.CO_CANCELACREDITOS_PR(lCod_cliente, TO_DATE(vp_Fecha_efec,sFormatoFecha||' HH24:MI:SS'), lNum_Transaccion , iCarrier , NULL , NULL , NULL, vp_retorno , vp_Glosa );

		IF vp_retorno !=0 THEN
		    vp_Gls_Error := vp_Glosa;
			RAISE ERROR_PROCESO;
		END IF;
		
	END IF;
    /* Fin MIX-09003 25.02.2010  MQG */

	IF (vp_Modulo_Usado='PNT') THEN
	    vp_OutRetorno:=1;
	ELSE
	    vp_OutRetorno:=0;
	END IF;


	vp_OutGlosa  :='OK';

	EXCEPTION
	WHEN ERROR_PROCESO THEN
	    IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='TEC') THEN
	        BEGIN
	           IF (vp_retorno!=0) THEN
	               ROLLBACK;
	           END IF;
	        END;
	    ELSE
	        ROLLBACK;
	    END IF;
	    
	    IF (vp_Modulo_Usado='PNT') THEN
	        vp_OutRetorno := -1;
	    ELSE
	        vp_OutRetorno := 1;
	    END IF;
	    
	    IF (vp_Modulo_Usado='PAC') THEN
	        vp_OutGlosa  := 'Error Sql -> CLIENTE: '||lCod_cliente||' -> '||SQLERRM;
	    ELSE
	        vp_OutGlosa  := 'Error de Proceso : '||v_sqlerrm;
	    END IF;
	    
	    v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - ';
	    v_sqlcode := SQLCODE;
		
	    INSERT INTO CO_TRANSAC_ERROR 
	        (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,
	         DESC_SQL   , DESC_CADENA, NUM_TRANSACCION)
	    VALUES 
	        (sNom_proceso, v_sqlcode, SYSDATE,
	         vp_Gls_Error, v_sqlerrm, DECODE(lSecCompago,NULL,vp_Num_transac, lSecCompago) );
	         
	    COMMIT;
	    
	WHEN NO_DATA_FOUND THEN
	    IF (vp_Modulo_Usado!='PEX' AND vp_Modulo_Usado!='PNT' AND vp_Modulo_Usado!='TEC') THEN
	        IF vp_OutRetorno > 1 THEN
	                ROLLBACK;
	        END IF;
	        IF (vp_Modulo_Usado='PAC') THEN
                vp_OutGlosa  := 'Error Sql -> CLIENTE: '||vp_Cod_cliente||' -> '||SQLERRM;
	        ELSE
	            vp_OutGlosa  := 'Error Sql : '||SQLERRM;
	        END IF;

			v_sqlerrm := 'CLIENTE : '||vp_Cod_cliente||' - Otros Errores - ' || SQLERRM;
            v_sqlcode := SQLCODE;
			INSERT INTO CO_TRANSAC_ERROR 
			    (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,
			     DESC_SQL   , DESC_CADENA, NUM_TRANSACCION)
	        VALUES 
	            (sNom_proceso, v_sqlcode, SYSDATE,
	             vp_Gls_Error, v_sqlerrm, DECODE(lSecCompago,NULL,vp_Num_transac, lSecCompago));

	        COMMIT;
	    END IF;
	    
	WHEN CLIENTE_BLOQUEADO THEN
		ROLLBACK;	
	    vp_OutRetorno:= 0;
	    vp_OutGlosa  := 'Cliente Pendiente por bloqueo';
	    v_sqlerrm    := 'CLIENTE : '||lCod_Cliente|| ' Bloquedo por Cajero '|| sNomCajero;
	    
    	INSERT INTO CO_TRANSAC_ERROR 
    	    (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,
    	     DESC_SQL   , DESC_CADENA, NUM_TRANSACCION)
		VALUES 
		    (sNom_proceso, vp_OutRetorno, SYSDATE,
		     vp_OutGlosa , v_sqlerrm    , DECODE(lSecCompago,NULL,vp_Num_transac, lSecCompago) );

	    COMMIT;

	WHEN ERROR_CALC_COMISIONES THEN
	    vp_OutRetorno := -1;
	    IF (vp_Modulo_Usado='PAC') THEN
	        vp_OutGlosa  := 'Error Calculo de Comisiones -> CLIENTE: '||lCod_cliente||' -> '||SQLERRM;
	    ELSE
	        vp_OutGlosa  := 'Error de Calculo de comisiones : '||vp_Gls_Error;
	    END IF;
	    v_sqlerrm := 'CLIENTE : '||lCod_Cliente||' - ';
	    v_sqlcode := SQLCODE;
	    
    	INSERT INTO CO_TRANSAC_ERROR 
    	    (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,
    	     DESC_SQL   , DESC_CADENA, NUM_TRANSACCION)
		VALUES 
		    (sNom_proceso, v_sqlcode, SYSDATE,
		     vp_gls_error, v_sqlerrm, DECODE(lSecCompago,NULL,vp_Num_transac, lSecCompago) );

	    COMMIT;

	WHEN OTHERS THEN
	    IF (vp_Modulo_Usado='PEX' OR vp_Modulo_Usado='TEC') THEN
	        BEGIN
	            IF vp_retorno != 0 THEN
	               ROLLBACK;
	            END IF;
	        END;
	    ELSE
	        ROLLBACK;
	    END IF;
	    
	    IF (vp_Modulo_Usado='PNT') THEN
	        vp_OutRetorno := -1;
	    ELSE
	        vp_OutRetorno := 1;
	    END IF;
	    
	    IF (vp_Modulo_Usado='PAC') THEN
	        vp_OutGlosa  := 'Error Sql -> CLIENTE: '||lCod_cliente||' -> '||SQLERRM;
	    ELSE
	        vp_OutGlosa  := 'Error Sql : '||SQLERRM;
	    END IF;
	    
	    v_sqlerrm := 'CLIENTE : '||lCod_cliente||' - Otros Errores - ' || SQLERRM;
	    v_sqlcode := SQLCODE;

		INSERT INTO CO_TRANSAC_ERROR 
		    (NOM_PROCESO, COD_RETORNO, FEC_PROCESO,
		     DESC_SQL   , DESC_CADENA, NUM_TRANSACCION)
	    VALUES 
	        (sNom_proceso, v_sqlcode, SYSDATE,
	         vp_Gls_Error, v_sqlerrm, DECODE(lSecCompago,NULL,vp_Num_transac, lSecCompago) );
	         
	    COMMIT;
END CO_APLICAPAGO_UNIVERSAL;
/