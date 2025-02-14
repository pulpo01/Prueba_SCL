CREATE OR REPLACE PROCEDURE CO_P_COB_EXT_TMM(	vp_NumProceso   IN NUMBER  , vp_CodProceso   IN VARCHAR2,
												vp_NumIdent     IN VARCHAR2, vp_CodTipIdent  IN VARCHAR2,
												vp_CodCliente   IN NUMBER  , vp_CodEntidad   IN VARCHAR2,
												vp_CodEnvio     IN VARCHAR2, vp_NomUsuario   IN VARCHAR2,
												vp_MtoEnvioAnt  IN NUMBER  )
IS
--
-- *****************************************************************************************
-- * Funcion            : CO_P_COB_EXT_TMM
-- * Salida             : Retorno error en Valor SQL.
-- * Descripcion        : Guardar en la tabla CO_DET_ARCHIVOS, los datos del cliente, que
-- *					  posteriormente seran informados a las empresas de cobranza.
-- * Fecha de creacion  : 10-04-2003
-- * Responsable        : Modesto Aranda.
-- *
-- * Modificaciones
-- * Fecha			Id( Proy/Inc)	Responsable	Descripcion del Cambio
-- *
-- * 10-04-2004		Proy TMM-03069	G.A.C.	Se reconstruye para dar cumplimiento al formato
-- *										especificado por la operadora.
-- *
-- *****************************************************************************************
--
szCod_region        GA_ABOCEL.COD_REGION%TYPE;
szCod_provincia     GA_ABOCEL.COD_PROVINCIA%TYPE;
szCod_ciudad        GA_ABOCEL.COD_CIUDAD%TYPE;
szCod_ciclfact      FA_HISTDOCU.COD_CICLFACT%TYPE;
lCod_cuenta         GA_ABOCEL.COD_CUENTA%TYPE;
szNum_contra        GA_ABOCEL.NUM_CONTRATO%TYPE;
szNum_anexo         GA_ABOCEL.NUM_ANEXO%TYPE;
szInd_eqprestado    GA_ABOCEL.IND_EQPRESTADO%TYPE;

szCodPlazaClie      VARCHAR2(5);
szPlazaClie			  GE_PLAZAS_TD.DES_PLAZA%TYPE;
szCod_operadora     GE_CLIENTES.COD_OPERADORA%TYPE;
lNumCelular         GA_ABOCEL.NUM_CELULAR%TYPE;
iCod_ciclo          GA_ABOCEL.COD_CICLO%TYPE;
szFecha_corte       VARCHAR2(2);
szCodEstado         GA_ABOCEL.COD_ESTADO%TYPE;
szEstado            CO_ESTADOS.DES_ESTADO%TYPE;
szPlanTarif         GA_ABOCEL.COD_PLANTARIF%TYPE;
iPenalizacion       NUMBER(2);
szLimconsumo        GA_LIMITE_CLIABO_TO.COD_LIMCONS%TYPE;
szCategoria         CO_MOROSOS.COD_CATEGORIA%TYPE;
szNom_cliente       VARCHAR2(100);
szDireccion         VARCHAR2(500);
szCiudad            GE_CIUDADES.DES_CIUDAD%TYPE;
szRegion            GE_REGIONES.DES_REGION%TYPE;
szCP                GE_DIRECCIONES.ZIP%TYPE;
szTef_cliente1      GE_CLIENTES.TEF_CLIENTE1%TYPE;
szTef_cliente2      GE_CLIENTES.TEF_CLIENTE2%TYPE;
iDiasVenc           NUMBER(5);
dSaldoVenc          CO_CARTERA.IMPORTE_DEBE%TYPE;
dSaldoFavor         CO_CARTERA.IMPORTE_DEBE%TYPE;
dMtoDeudaCobranza   CO_CARTERA.IMPORTE_DEBE%TYPE;
szCajon_cob         VARCHAR2(70);

dDeuda_total        NUMBER(14,4);
szStg_general       VARCHAR2(1024);
szStg_titulo        VARCHAR2(1024);
iExis_Co_arch       NUMBER(1);
szNomArchivo        CO_ARCHIVOS.NOM_ARCHIVO%TYPE;
lReg_buenos         NUMBER(8);
dMto_buenos         NUMBER(14,4);
lTotal_reg          NUMBER(14,4);
iReg_buenos         NUMBER(7);
iUnreg              NUMBER(1) := 1;
dMto_envio          CO_COBEXENV.MTO_ENVIO%TYPE;
lCntNumIdent        CO_COBEXENV.CNT_NUM_IDENT%TYPE;
szPie_Total         VARCHAR2(1024);
sFin                CHAR(1) := '#';
iDecimal            NUMBER(2);
szMens_Error        VARCHAR2(100);

/* Cambio por Variables bind */
szValorCero      VARCHAR2(1) := '0';
szValorUno       VARCHAR2(1) := '1';
szValorDos       VARCHAR2(1) := '2';
szValorTres      VARCHAR2(1) := '3';
szCod_modulo     VARCHAR2(2) := 'CO';
iNumberCero 	 NUMBER := 0;
iNumberUno		 NUMBER := 1;
iNumberDos		 NUMBER := 2;
iNumberTres      NUMBER := 3;
szLetraS         VARCHAR2(1) := 'S';
szLetrasMR       VARCHAR2(2) := 'MR';

BEGIN
	dMtoDeudaCobranza := 0;
	dDeuda_total:= 0;
	iReg_buenos := 0;
	szNomArchivo := vp_CodProceso||'_'||vp_CodEntidad||'_'||vp_NumProceso||'.'||'txt';

   szMens_Error:='SQL GE_PAC_GENERAL.PARAM_GENERAL';
	/* Obtiene la cantidad de decimales a utilizar */
   iDecimal:=GE_PAC_GENERAL.PARAM_GENERAL( 'num_decimal' );

   BEGIN
      szMens_Error:='SQL SELECT GE_CLIENTES';
      SELECT NOM_CLIENTE||' '||NOM_APECLIEN1 || ' ' || NOM_APECLIEN2,
             TEF_CLIENTE1   ,
             TEF_CLIENTE2   ,
             COD_OPERADORA
      INTO   szNom_cliente  ,
             szTef_cliente1 ,
             szTef_cliente2 ,
             szCod_operadora
      FROM   GE_CLIENTES
      WHERE  COD_CLIENTE = vp_CodCliente;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
			 szNom_cliente  := NULL;
			 szTef_cliente1 := NULL;
			 szTef_cliente2 := NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT GA_ABOCEL';
      SELECT NUM_CELULAR  , NVL(COD_CICLO,iNumberCero),
             COD_ESTADO   , COD_PLANTARIF,
             COD_REGION   , COD_PROVINCIA,
             COD_CIUDAD   , COD_CUENTA   ,
             NVL(NUM_CONTRATO,szValorCero),
             NVL(NUM_ANEXO,szValorCero)   ,
             NVL(IND_EQPRESTADO,szValorUno)
      INTO   lNumCelular  , iCod_ciclo     ,
             szCodEstado  , szPlanTarif    ,
             szCod_region , szCod_provincia,
      		 szCod_ciudad , lCod_cuenta    ,
             szNum_contra , szNum_anexo    ,
             szInd_eqprestado
      FROM   GA_ABOCEL
      WHERE  COD_CLIENTE = vp_CodCliente
      AND    ROWNUM < iNumberDos;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             lNumCelular:= iNumberCero;
             szCodEstado:= NULL;
             szPlanTarif:= NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT CO_ESTADOS';
      SELECT DES_ESTADO
      INTO   szEstado
      FROM   CO_ESTADOS
      WHERE  COD_ESTADO = DECODE(szCodEstado,szCod_modulo,szLetrasMR,szCodEstado);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             szEstado :=NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT GE_DIRECCIONES';
      SELECT ZIP
      INTO   szCP
      FROM   GE_DIRECCIONES
      WHERE  COD_REGION   = szCod_region
      AND    COD_PROVINCIA= szCod_provincia
      AND    COD_CIUDAD   = szCod_ciudad
      AND    COD_DIRECCION= (SELECT COD_DIRECCION FROM GA_DIRECCLI WHERE COD_CLIENTE = vp_CodCliente AND COD_TIPDIRECCION = iNumberTres);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         	szCP:=NULL;
   END;

   IF szInd_eqprestado=szValorUno THEN
      BEGIN
      	szMens_Error:='SQL SELECT GA_DATOSGENER';
         SELECT NVL(COD_PENALIZA_COMODATO,-iNumberUno)
         INTO   iPenalizacion
         FROM   GA_DATOSGENER;
      END;
   ELSE
      BEGIN
      	szMens_Error:='SQL SELECT GA_PERCONTRATO';
         SELECT NVL(A.COD_PENALIZA,-iNumberUno)
         INTO  iPenalizacion
         FROM  GA_PERCONTRATO A, GA_CONTCTA B
         WHERE B.COD_CUENTA  = lCod_cuenta
         AND   B.NUM_CONTRATO(+) = szNum_contra
         AND   B.NUM_ANEXO(+)    = szNum_anexo
         AND   B.COD_TIPCONTRATO = A.COD_TIPCONTRATO(+)
         AND   B.NUM_MESES    = A.NUM_MESES(+)
         AND   B.COD_PRODUCTO = A.COD_PRODUCTO(+);
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
       	      iPenalizacion:=NULL;
      END;
   END IF;

   BEGIN
      szMens_Error:='SQL SELECT GA_LIMITE_CLIABO_TO';
      SELECT UNIQUE COD_LIMCONS
      INTO   szLimconsumo
      FROM   GA_LIMITE_CLIABO_TO
      WHERE  COD_CLIENTE = vp_CodCliente
      AND    SYSDATE BETWEEN NVL(FEC_DESDE,SYSDATE) AND NVL(FEC_HASTA,SYSDATE)
      AND    ROWNUM < iNumberDos;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         	szLimconsumo:=NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT FA_CICLFACT';
      SELECT TO_CHAR(FEC_HASTALLAM,'DD')
      INTO   szFecha_corte
      FROM   FA_CICLFACT
      WHERE  COD_CICLO = iCod_ciclo
      AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
			szFecha_corte:=NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT GE_CIUDADES';
      SELECT DES_CIUDAD
      INTO  szCiudad
      FROM  GE_CIUDADES
      WHERE COD_REGION   = szCod_region
      AND   COD_PROVINCIA= szCod_provincia
      AND   COD_CIUDAD   = szCod_ciudad;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             szCiudad:= NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT GE_REGIONES';
      SELECT DES_REGION
      INTO   szRegion
      FROM   GE_REGIONES
      WHERE  COD_REGION = szCod_region;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             szRegion:= NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT GE_FN_OBTIENE_DIRCLIE';
      SELECT GE_FN_OBTIENE_DIRCLIE(vp_CodCliente,iNumberUno,iNumberTres,iNumberUno),
      		 Fn_Obtiene_PlazaCliente(vp_CodCliente)    ,
      		 CO_FN_CAJON_COBRANZA(vp_CodCliente,'',szLetraS)
      INTO   szDireccion,
      		 szCodPlazaClie,
      		 szCajon_cob
      FROM   DUAL;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             szDireccion := NULL;
             szCodPlazaClie := NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT GE_PLAZAS_TD';
      SELECT DES_PLAZA
      INTO   szPlazaClie
      FROM   GE_PLAZAS_TD
      WHERE  COD_PLAZA=szCodPlazaClie;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             szPlazaClie := NULL;
   END;

   BEGIN
      szMens_Error:='SQL SELECT CO_COBEXTERNADOC';
	   SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),iNumberCero),
	   		 NVL(SUM(IMPORTE_DEBE),iNumberCero) ,
	   		 NVL(SUM(IMPORTE_HABER),iNumberCero)
      INTO   dMtoDeudaCobranza,
      		 dSaldoVenc       ,
      		 dSaldoFavor
      FROM   CO_COBEXTERNADOC
      WHERE  NUM_IDENT    = vp_NumIdent
      AND    COD_TIPIDENT = vp_CodTipIdent
      AND    COD_CLIENTE  = vp_CodCliente
      AND    COD_ENTIDAD  = vp_CodEntidad;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             dMtoDeudaCobranza := 0;
      		 dSaldoVenc        := 0;
      		 dSaldoFavor		 := 0;
   END;

   BEGIN
      szMens_Error:='SQL SELECT CO_MOROSOS';
      SELECT NVL((ROUND(SYSDATE-FEC_DEUDVENC)-iNumberUno),iNumberCero),
      		 COD_CATEGORIA
      INTO   iDiasVenc ,
             szCategoria
      FROM   CO_MOROSOS
      WHERE  COD_CLIENTE = vp_CodCliente;
   END;

   BEGIN
      szMens_Error:='SQL UPDATE CO_COBEXTERNADOC';
      UPDATE CO_COBEXTERNADOC SET
             IND_INFORMADO = szLetraS
      WHERE  NUM_IDENT    = vp_NumIdent
      AND    COD_TIPIDENT = vp_CodTipIdent
      AND    COD_CLIENTE  = vp_CodCliente
      AND    COD_ENTIDAD  = vp_CodEntidad;
   END;

   BEGIN
		/* siempre se actualiza la tabla historica */
      szMens_Error:='SQL UPDATE CO_HCOBEXTERNADOC';
      UPDATE CO_HCOBEXTERNADOC SET
             IND_INFORMADO = szLetraS
      WHERE  NUM_IDENT    = vp_NumIdent
      AND    COD_TIPIDENT = vp_CodTipIdent
      AND    COD_CLIENTE  = vp_CodCliente
      AND    COD_ENTIDAD  = vp_CodEntidad;
   END;

	szStg_general := szPlazaClie||';'||szCod_operadora||';'||vp_CodCliente||';'||lNumCelular||';'||iCod_ciclo||';'||szFecha_corte;
	szStg_general := szStg_general||';'||szEstado||';'||szPlanTarif||';'||iPenalizacion||';'||szLimconsumo||';'||szCategoria;
	szStg_general := szStg_general||';'||szNom_cliente||';'||szDireccion||';'||szCiudad||';'||szRegion||';'||szCP||';'||szTef_cliente1;
	szStg_general := szStg_general||';'||szTef_cliente2||';'||iDiasVenc||';'||dMtoDeudaCobranza||';'||dSaldoFavor||';'||dSaldoVenc||';'||szCajon_cob;

   szMens_Error:='SQL INSERT CO_DET_ARCHIVOS 1';
   INSERT INTO CO_DET_ARCHIVOS (
     	    NUM_PROCESO  , COD_PROCESO  , COD_ENTIDAD  ,
          TIP_REGITRO  , TXT_REGISTRO )
   VALUES(vp_NumProceso, vp_CodProceso,
          vp_CodEntidad, szValorDos   , szStg_general);

	dDeuda_total:= dDeuda_total + dMtoDeudaCobranza;
	iReg_buenos := iReg_buenos + 1;

   BEGIN
      szMens_Error:='SQL SELECT CO_DET_ARCHIVOS';
      SELECT NVL(MTO_BUENOS,iNumberCero)    , NVL(REG_BUENOS,iNumberCero),
             NVL(TOT_REGISTROS,iNumberCero) , iNumberCero
      INTO   dMto_buenos   , lReg_buenos,
             lTotal_reg    , iExis_Co_arch
      FROM   CO_ARCHIVOS
      WHERE  NUM_PROCESO = vp_NumProceso
      AND    COD_PROCESO = vp_CodProceso
      AND    NOM_ARCHIVO = szNomArchivo;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
			iExis_Co_arch:= NULL;
   END;

	dMto_buenos := dDeuda_total + dMto_buenos;
	lReg_buenos := lReg_buenos + iReg_buenos;
	lTotal_reg  := lTotal_reg + iUnreg;
	szPie_Total := ';;;;;;;;;'||GE_PAC_GENERAL.REDONDEA(dMto_buenos, iDecimal, iNumberCero )||sFin;

   IF iExis_Co_arch IS NULL THEN

      szMens_Error:='SQL INSERT CO_ARCHIVOS';
      INSERT  INTO CO_ARCHIVOS (
              NUM_PROCESO  , COD_PROCESO  , FEC_PROCESO  , COD_ENTIDAD  , NOM_ARCHIVO,
              TOT_REGISTROS, REG_BUENOS   , MTO_BUENOS   , NOM_USUARIO  )
      VALUES (vp_NumProceso, vp_CodProceso, SYSDATE      , vp_CodEntidad, szNomArchivo,
              iUnreg  		, iReg_buenos  , dDeuda_total , vp_NomUsuario);

		szStg_titulo := 'PLAZA;COMPANIA;COD_CLIENTE;DN;CICLO;CORTE;EVENTO;PLAN;PENALIZACION;LIMITE;CATEGORIA;NOMBRE;DIRECCION;CD;';
		szStg_titulo := szStg_titulo||'EDO;CP;TELEFONO1;TELEFONO2;DIAS VENCIDOS;SALDO;A FAVOR;CORRIENTE;1-30;31-60;61-90;91-120;MAS 120'||sFin;

      szMens_Error:='SQL INSERT CO_DET_ARCHIVOS 2';
      INSERT  INTO CO_DET_ARCHIVOS (
              NUM_PROCESO  , COD_PROCESO  , COD_ENTIDAD  , TIP_REGITRO, TXT_REGISTRO )
      VALUES (vp_NumProceso, vp_CodProceso, vp_CodEntidad, szValorUno        , szStg_titulo );

      szMens_Error:='SQL INSERT CO_DET_ARCHIVOS 3';
      INSERT  INTO CO_DET_ARCHIVOS (
              NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO )
      VALUES (vp_NumProceso, vp_CodProceso, vp_CodEntidad, szValorTres, szPie_Total );

   ELSE

      szMens_Error:='SQL UPDATE CO_ARCHIVOS';
      UPDATE CO_ARCHIVOS SET
             MTO_BUENOS    = GE_PAC_GENERAL.REDONDEA( dMto_buenos, iDecimal, iNumberCero ),
             REG_BUENOS    = lReg_buenos,
             TOT_REGISTROS = lTotal_reg
      WHERE  NUM_PROCESO = vp_NumProceso
      AND    COD_PROCESO = vp_CodProceso
      AND    NOM_ARCHIVO = szNomArchivo;

      szMens_Error:='SQL UPDATE CO_DET_ARCHIVOS';
      UPDATE CO_DET_ARCHIVOS SET
             TXT_REGISTRO = ';;;;;;;;;'||GE_PAC_GENERAL.REDONDEA( dMto_buenos, iDecimal, iNumberCero ) || sFin
      WHERE  NUM_PROCESO = vp_NumProceso
      AND    COD_PROCESO = vp_CodProceso
      AND    COD_ENTIDAD = vp_CodEntidad
      AND    TIP_REGITRO = szValorTres;

   END IF;

   BEGIN
      szMens_Error:='SQL SELECT CO_COBEXENV';
      SELECT CNT_NUM_IDENT + iNumberCero, MTO_ENVIO
      INTO   lCntNumIdent     , dMto_envio
      FROM   CO_COBEXENV
      WHERE  NUM_PROCESO = vp_NumProceso
      AND    COD_ENTIDAD = vp_CodEntidad
      AND    COD_ENVIO   = vp_CodEnvio;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             dMto_envio := NULL;
             lCntNumIdent := 1;
   END;

   IF dMto_envio IS NULL THEN

		dMto_envio := dDeuda_total - vp_MtoEnvioAnt;
      szMens_Error:='SQL INSERT CO_COBEXENV';
      INSERT  INTO CO_COBEXENV (
              NUM_PROCESO  , COD_ENTIDAD  , COD_ENVIO  , CNT_NUM_IDENT, MTO_ENVIO  )
      VALUES (vp_NumProceso, vp_CodEntidad, vp_CodEnvio, lCntNumIdent , dMto_envio);

   ELSE
		dMto_envio := dMto_envio + ( dDeuda_total - vp_MtoEnvioAnt );
      szMens_Error:='SQL UPDATE CO_COBEXENV';
      UPDATE CO_COBEXENV SET
             CNT_NUM_IDENT = lCntNumIdent,
             MTO_ENVIO     = dMto_envio
      WHERE  NUM_PROCESO = vp_NumProceso
      AND    COD_ENTIDAD = vp_CodEntidad
      AND    COD_ENVIO   = vp_CodEnvio;

   END IF;

   szMens_Error:='SQL UPDATE CO_COBEXTERNA';
   UPDATE CO_COBEXTERNA SET
          FEC_MOVIMIENTO = SYSDATE,
          NUM_PROCESO    = vp_NumProceso,
          MTO_ENVIOANT = dDeuda_total
   WHERE  NUM_IDENT    = vp_NumIdent
   AND    COD_TIPIDENT = vp_CodTipIdent
   AND    COD_CLIENTE  = vp_CodCliente
   AND    COD_ENTIDAD  = vp_CodEntidad;

EXCEPTION
   WHEN OTHERS THEN
			 RAISE_APPLICATION_ERROR (-20100,to_char(SQLCODE)||' - '||SQLERRM||' - '||szMens_Error);
END CO_P_COB_EXT_TMM;
/
SHOW ERRORS
