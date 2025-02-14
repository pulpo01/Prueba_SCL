CREATE OR REPLACE PROCEDURE FA_PROC_PREBILLING_2 (lhCodCliente_EXT       IN NUMBER  ,        /* Codigo del Cliente */
                                                  lhNumVenta_EXT         IN NUMBER  ,        /* Numero de la Venta */
                                                  lhNumTransaccion_EXT   IN NUMBER  ,        /* Numero de la Transaccion */
                                                  lhNumProceso_EXT       IN NUMBER  ,        /* Numero del Proceso */
                                                  szhCodModGener_EXT     IN VARCHAR2,        /* Nuevo : Modo de Generacion ('100','101','110',etc) de la tabla FA_GENCENTREMI */
                                                  szhCodCaTribut_EXT     IN VARCHAR2,        /* Nuevo : Categoria Impositiva ('F'o 'B') de GA_CATRIBUTCLIE */
                                                  szhFecVencimiento_EXT  IN VARCHAR2,        /* Nuevo : Fecha de Vencimiento del Documento a Emitir ('DDMMYYYY') */
                                                  /* lhNumCodModVenta_EXT IN NUMBER  ,           Mod.Venta - Se obtendra desde Ga_Ventas */
                                                  /* lhNumCuanCuotas_EXT  IN NUMBER  ,           Cuantas Cuotas - Se obtiene por cod_cuota desde ga_ventas - GE_TIPCUOTAS */
                                                  VP_PROC                IN OUT NOCOPY VARCHAR2,    /* En que parte del proceso estoy*/
                                                  VP_TABLA               IN OUT NOCOPY VARCHAR2,    /* En que tabla estoy trabajando*/
                                                  VP_ACT                 IN OUT NOCOPY VARCHAR2,    /* Que accion estoy ejecutando*/
                                                  VP_SQLCODE             IN OUT NOCOPY VARCHAR2,    /* sqlcode*/
                                                  VP_SQLERRM             IN OUT NOCOPY VARCHAR2,    /* sqlerrm*/
                                                  VP_ERROR               IN OUT NOCOPY VARCHAR2,    /* Error enviando por nosotros u otro.*/
                                                  DebugPantalla          IN BOOLEAN := FALSE /* Flag que indica lanzar informacion a Pantalla, en produccion debe ser siempre  falso  */
) IS
    /* FLUJO DEL PROGRAMA */
    fallo                   BOOLEAN     := FALSE;
    ProcesoCreado           BOOLEAN     := FALSE;
    szError                 VARCHAR2(2) := '?';
    VP_DESCERR              VARCHAR2(200) := NULL;
    szhUser                 GE_CARGOS.NOM_USUARORA%TYPE;
    /* #DEFINE's */
    PROC_EJEC               NUMBER(1)   := 0;
    PROC_OK                 NUMBER(1)   := 1;
    PROC_ERR                NUMBER(1)   := 2;
    PROG_VERSION            VARCHAR2(4) := '4.00';
    /* EXCEPCION */
    FALLO_ACCESO_A_LA_BASE  EXCEPTION;
    FALLO_PATH              EXCEPTION;
    /* (B) */
    szhCodMoneFact          FA_DATOSGENER.COD_MONEFACT%TYPE;
    ihCodContado            FA_DATOSGENER.COD_CONTADO%TYPE;
    fhImpTarifa             GA_TARIFAS.IMP_TARIFA%TYPE;
            /* RAO150402: se obtiene el concepto de la tabla de impuestos */
    /* (C) */
    Reg_GA_Ventas           GA_VENTAS%ROWTYPE;
    /* (D) */
    lhNumSecuenci           NUMBER := 0;
    lhNumCuotas             NUMBER := 1;
    /* (E) */
    ihCodCatImpos           SISCEL.GE_DATOSGENER.COD_CATIMPOS%TYPE;
    ihCodZonaImpo           GE_ZONACIUDAD.COD_ZONAIMPO%TYPE;
    /* (F) */
    szhLetra                GE_LETRAS.LETRA%TYPE ;
    /* (G) */
    ihCodCentrEmi           AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE;
    /* (H) */
    TYPE TipRegCargosConceptos IS RECORD (
                                            NUM_CARGO         GE_CARGOS.NUM_CARGO%TYPE,
                                            COD_CLIENTE       GE_CARGOS.COD_CLIENTE%TYPE,
                                            COD_PRODUCTO      GE_CARGOS.COD_PRODUCTO%TYPE,
                                            COD_CONCEPTO      GE_CARGOS.COD_CONCEPTO%TYPE,
                                            FEC_ALTA          GE_CARGOS.FEC_ALTA%TYPE,
                                            IMP_CARGO         GE_CARGOS.IMP_CARGO%TYPE,
                                            COD_MONEDA        GE_CARGOS.COD_MONEDA%TYPE,
                                            COD_PLANCOM       GE_CARGOS.COD_PLANCOM%TYPE,
                                            NUM_UNIDADES      GE_CARGOS.NUM_UNIDADES%TYPE,
                                            IND_FACTUR        GE_CARGOS.IND_FACTUR%TYPE,
                                            NUM_TRANSACCION   GE_CARGOS.NUM_TRANSACCION%TYPE,
                                            NUM_VENTA         GE_CARGOS.NUM_VENTA%TYPE,
                                            NUM_PAQUETE       GE_CARGOS.NUM_PAQUETE%TYPE,
                                            NUM_ABONADO       GE_CARGOS.NUM_ABONADO%TYPE,
                                            NUM_TERMINAL      GE_CARGOS.NUM_TERMINAL%TYPE,
                                            COD_CICLFACT      GE_CARGOS.COD_CICLFACT%TYPE,
                                            NUM_SERIE         GE_CARGOS.NUM_SERIE%TYPE,
                                            NUM_SERIEMEC      GE_CARGOS.NUM_SERIEMEC%TYPE,
                                            CAP_CODE          GE_CARGOS.CAP_CODE%TYPE,
                                            MES_GARANTIA      GE_CARGOS.MES_GARANTIA%TYPE,
                                            NUM_PREGUIA       GE_CARGOS.NUM_PREGUIA%TYPE,
                                            NUM_GUIA          GE_CARGOS.NUM_GUIA%TYPE,
                                            NUM_FACTURA       GE_CARGOS.NUM_FACTURA%TYPE,
                                            COD_CONCEPTO_DTO  GE_CARGOS.COD_CONCEPTO_DTO%TYPE,
                                            VAL_DTO           GE_CARGOS.VAL_DTO%TYPE,
                                            TIP_DTO           GE_CARGOS.TIP_DTO%TYPE,
                                            IND_CUOTA         GE_CARGOS.IND_CUOTA%TYPE,
                                            IND_SUPERTEL      GE_CARGOS.IND_SUPERTEL%TYPE,
                                            IND_MANUAL        GE_CARGOS.IND_MANUAL%TYPE,
                                            NOM_USUARORA      GE_CARGOS.NOM_USUARORA%TYPE,
                                            COD_TECNOLOGIA    GE_CARGOS.COD_TECNOLOGIA%TYPE,
                                            CodModuloFC       FA_CONCEPTOS.COD_MODULO%TYPE,
                                            CodMonedaFC       FA_CONCEPTOS.COD_MONEDA%TYPE,
                                            CodTipConceFC     FA_CONCEPTOS.COD_TIPCONCE%TYPE,
                                            IndActivoFC       FA_CONCEPTOS.IND_ACTIVO%TYPE,
                                            CodProductoFC     FA_CONCEPTOS.COD_PRODUCTO%TYPE,
                                            CodTipDescFC      FA_CONCEPTOS.COD_TIPDESCU%TYPE,
                                            Mi_RowID          ROWID
                                            );
    TYPE TipTab_GE_CARGOS   IS TABLE  OF  TipRegCargosConceptos INDEX BY  BINARY_INTEGER;
    Tab_CARGA_CARGOS        TipTab_GE_CARGOS;
    /* (I)
    TYPE TipTab_FA_PRESUPUESTO IS TABLE  OF  FA_PRESUPUESTO%ROWTYPE INDEX BY  BINARY_INTEGER;
            */
    Tab_FA_PRESUPUESTO      FA_PAC_IMPTOS.TipTab_FA_PRESUPUESTO;
    /* (J) */
    szhCodModulo            FA_CONCEPTOS.COD_MODULO%TYPE    ;
    szhCodMoneda            FA_CONCEPTOS.COD_MONEDA%TYPE    ;
    ihCodTipConce           FA_CONCEPTOS.COD_TIPCONCE%TYPE  ;
    ihIndActivo             FA_CONCEPTOS.IND_ACTIVO%TYPE    ;
    ihCodProducto           FA_CONCEPTOS.COD_PRODUCTO%TYPE  ;
    szhCodDescu             FA_CONCEPTOS.COD_TIPDESCU%TYPE  ;
    /* (K) */
    dhCambioOrigen          GE_CONVERSION.CAMBIO%TYPE       ;
    dhCambioDestino         GE_CONVERSION.CAMBIO%TYPE       ;
    dhFCambio               GE_CONVERSION.CAMBIO%TYPE := 1  ;
    /* (L) */
    TYPE TipReg_Columnas IS RECORD (ihCodConcepto_COL GE_CARGOS.COD_CONCEPTO%TYPE, ihNumOcurrencias_COL NUMBER(6));
    TYPE TipTab_Columnas IS TABLE OF  TipReg_Columnas INDEX BY  BINARY_INTEGER;
    Tab_Columnas                    TipTab_Columnas;
    /* (M) */
    TYPE TipTab_VENTADTO IS TABLE OF  VE_VENTADTOS%ROWTYPE INDEX BY  BINARY_INTEGER;
    Tab_VENTADTO            TipTab_VENTADTO;
    FIN_CARGO               PLS_INTEGER    := 0;
    FIN_DSCTO               PLS_INTEGER    := 0;
    /* (P) */
    szhPathDir              FAD_PARAMETROS.VAL_CARACTER%TYPE;
    sControlPath            VARCHAR2(1);
    szhNombArchLog          VARCHAR2 (128) := 'Prebilling_Contado_' || to_char(lhNumVenta_EXT) || '_' || to_char(lhCodCliente_EXT) || '.log' ;
    szhModoOpen             VARCHAR2 (1)   := 'w';
    fh                      utl_file.FILE_TYPE ;
    /* (Q) */
    Raya1                   VARCHAR2(50)   := '--------------------------------------------';
    Raya2                   VARCHAR2(50)   := '=================================================';
    Asteriscos              VARCHAR2(50)   := '***********';
    iNumDecimales           GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    sFormatoFecha           GED_PARAMETROS.VAL_PARAMETRO%TYPE;


/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (-2) * SETEA EL CODIGO DE ERROR EN LAS VARIABLES DE RETORNO                                   */
/* ********************************************************************************************* */
PROCEDURE SET_ERROR(DESCRIPCION IN VARCHAR2, COD_ERROR IN VARCHAR2) IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    VP_SQLCODE := TO_CHAR(SQLCODE);
    VP_SQLERRM := SUBSTR(SQLERRM,1,70);
    VP_DESCERR := DESCRIPCION || ' CLI[' || TO_CHAR(lhCodCliente_EXT) || '] VTA[' || TO_CHAR(lhNumVenta_EXT) || '] TRN[' || TO_CHAR(lhNumTransaccion_EXT) || '] PRC[' || TO_CHAR(lhNumProceso_EXT)     || ']';
    IF (COD_ERROR != 'ZZ') THEN
        VP_ERROR   := '4';
        fallo := TRUE ;
    END IF;
    INSERT INTO FA_EJEC_PREBILLING_TH (
        pbl_ERROR   ,
        pbl_PROC    ,
        pbl_SQLCODE ,
        pbl_SQLERRM ,
        pbl_TABLA   ,
        PBL_DESCERR ,
        PBL_FECHA)
    VALUES (
        COD_ERROR  ,
        VP_PROC    ,
        VP_SQLCODE ,
        VP_SQLERRM ,
        VP_TABLA   ,
        VP_DESCERR ,
        SYSDATE )
    ;
    COMMIT;
EXCEPTION
    WHEN TIMEOUT_ON_RESOURCE THEN
        VP_SQLCODE := TO_CHAR(SQLCODE);
        VP_SQLERRM := SUBSTR(SQLERRM,1,70);
        VP_DESCERR:='*'||VP_DESCERR;
        INSERT INTO FA_EJEC_PREBILLING_TH
               (pbl_ERROR, pbl_PROC, pbl_SQLCODE, pbl_SQLERRM, pbl_TABLA, PBL_DESCERR, PBL_FECHA)
        VALUES ('QQ', 'SET_ERROR()', VP_SQLCODE, VP_SQLERRM, 'FA_EJEC_PREBILLING_TH', 'ERROR por TIMEOUT_ON_RESOURCE', SYSDATE);
        COMMIT;
    WHEN OTHERS THEN
        IF ( utl_file.is_open(fh) = TRUE ) THEN
            utl_file.Put_Line(fh,'ERROR ' || TO_CHAR(SQLCODE) ||' en FA_EJEC_PREBILLING_TH [' || SQLERRM || ']' );
            utl_file.Put_Line(fh,'AL RE-REGISTRAR EL ERROR : ');
            utl_file.Put_Line(fh,'VP_ERROR  =['|| VP_ERROR   || ']');
            utl_file.Put_Line(fh,'VP_PROC   =['|| VP_PROC    || ']');
            utl_file.Put_Line(fh,'VP_SQLCODE=['|| VP_SQLCODE || ']');
            utl_file.Put_Line(fh,'VP_SQLERRM=['|| VP_SQLERRM || ']');
            utl_file.Put_Line(fh,'VP_TABLA  =['|| VP_TABLA   || ']');
            utl_file.Put_Line(fh,'VP_DESCERR=['|| VP_DESCERR || ']');
            utl_file.Put_Line(fh,'COD_ERROR =['|| COD_ERROR  || ']');
            utl_file.fflush(fh);
        END IF;
        VP_SQLCODE := TO_CHAR(SQLCODE);
        VP_SQLERRM := SUBSTR(SQLERRM,1,70);
        VP_DESCERR:='*'||VP_DESCERR;
        INSERT INTO FA_EJEC_PREBILLING_TH(
            pbl_ERROR,
            pbl_PROC,
            pbl_SQLCODE,
            pbl_SQLERRM,
            pbl_TABLA,
            PBL_DESCERR,
            PBL_FECHA)
        VALUES(
            'KK',
            'SET_ERROR()',
            VP_SQLCODE,
            VP_SQLERRM,
            'FA_EJEC_PREBILLING_TH',
            'ERROR AL RE-REGISTRAR EL ERROR',
            SYSDATE);
        COMMIT;
END SET_ERROR;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (-1) * DEBUGGER EN TIEMPO DE EJECUCION DEL PROGRAMA                                           */
/* ********************************************************************************************* */
PROCEDURE DEBUG IS
BEGIN
    utl_file.Put_Line(fh,NVL(Raya2,' '));
    utl_file.Put_Line(fh,NVL(Asteriscos,' ') || ' ' || NVL(VP_PROC,' ') || '*');
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','11');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','12');
END DEBUG;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (0) * VALIDACION DE LOS PARAMETROS DE ENTRADA                                                 */
/* ********************************************************************************************* */
PROCEDURE ValidacionPrevia IS
PARAMETRO_NULO EXCEPTION;
BEGIN
    VP_PROC         := 'ValidacionPrevia        '   ;
    VP_TABLA        := 'GA_VENTAS'                  ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    utl_file.Put_Line(fh,'>> Cliente                : [' || TO_CHAR(NVL(lhCodCliente_EXT,-999))      || ']' );
    utl_file.Put_Line(fh,'>> Transaccion            : [' || TO_CHAR(NVL(lhNumTransaccion_EXT,-999))  || ']' );
    utl_file.Put_Line(fh,'>> Venta                  : [' || TO_CHAR(NVL(lhNumVenta_EXT,-999))        || ']' );
    utl_file.Put_Line(fh,'>> Proceso                : [' || TO_CHAR(NVL(lhNumProceso_EXT,-999))      || ']' );
    utl_file.Put_Line(fh,'>> Cod Modo Generacion    : [' || NVL(szhCodModGener_EXT   ,' ') || ']' );
    utl_file.Put_Line(fh,'>> Cod Categ Tributaria   : [' || NVL(szhCodCaTribut_EXT   ,' ') || ']' );
    utl_file.Put_Line(fh,'>> Fec Vencimiento Doc.   : [' || NVL(szhFecVencimiento_EXT,' ') || ']' );
    utl_file.fflush(fh);
    IF ( lhCodCliente_EXT      IS NULL OR  lhNumTransaccion_EXT  IS NULL OR
         lhNumVenta_EXT        IS NULL OR  lhNumProceso_EXT      IS NULL OR
         szhCodModGener_EXT    IS NULL OR  szhCodCaTribut_EXT    IS NULL OR
         szhFecVencimiento_EXT IS NULL  )  THEN
            RAISE PARAMETRO_NULO;
    END IF;
    szhUser:=' ';
    SELECT NOM_USUAR_VTA
      INTO szhUser
      FROM GA_VENTAS
     WHERE NUM_VENTA = lhNumVenta_EXT;
     utl_file.Put_Line(fh,'>> Usuario                : [' || NVL(szhUser,' ') || ']' );
    utl_file.fflush(fh);
EXCEPTION
    WHEN PARAMETRO_NULO THEN
        SET_ERROR('SE INGRESO PARAMETRO NULO GA_VENTAS (0)','13');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND GA_VENTAS (0)','14');
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','15');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','16');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (0)','17');
END ValidacionPrevia;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (1) * OBTIENE VARIABLES GLOBALES DESDE FA_DATOSGENER                                          */
/* ********************************************************************************************* */
PROCEDURE GetVariablesGlobales IS
BEGIN
    VP_PROC         := 'GetVariablesGlobales    '   ;
    VP_TABLA        := 'FA_DATOSGENER'              ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    szhCodMoneFact:=' ';
    SELECT COD_MONEFACT            ,
           COD_CONTADO
    INTO  szhCodMoneFact          ,
          ihCodContado
    FROM  FA_DATOSGENER           ;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND FA_DATOSGENER (1)','18');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO FA_DATOSGENER (1)','19');
END GetVariablesGlobales;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (1.5) * OBTIENE VARIABLES GLOBALES DESDE FAD_PARAMETROS                                       */
/* ********************************************************************************************* */
PROCEDURE GetPath IS
BEGIN
    VP_PROC         := 'GetPath'      ;
    VP_TABLA        := 'FAD_PARAMETROS'             ;
    VP_ACT          := 'S'                          ;
    szhPathDir:=' ';
    SELECT  VAL_CARACTER
       INTO szhPathDir
    FROM FAD_PARAMETROS
    WHERE COD_MODULO = 'FA'
      AND COD_PARAMETRO = 3;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND FAD_PARAMETROS (1.5)','20');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO FAD_PARAMETROS (1.5)','21');
END GetPath;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (2) * OBTIENE LA CATEGORIA IMPOSITIVA DEL CLIENTE DADO // fx(lhCOD_CLIENTE)--> iCOD_CATIMPOS  */
/* ********************************************************************************************* */
PROCEDURE GetCatImposCli IS
BEGIN
    VP_PROC         := 'GetCatImposCli          '   ;
    VP_TABLA        := 'GE_CATIMPCLIENTES'          ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    ihCodCatimpos := 0;
    SELECT COD_CATIMPOS
      INTO ihCodCatimpos
    FROM GE_CATIMPCLIENTES
    WHERE COD_CLIENTE = lhCodCliente_EXT
      AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','22');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','23');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND GE_CATIMPCLIENTES (2)','24');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO GE_CATIMPCLIENTES (2)','25');
END GetCatImposCli;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (3) * RECUPERA TODA LA INFORMACION DE GA_VENTAS  // fx(lhNroVenta)--> (*)                     */
/* ********************************************************************************************* */
PROCEDURE GetRegVentas IS
BEGIN
    VP_PROC         := 'GetRegVentas            '   ;
    VP_TABLA        := 'GA_VENTAS'                  ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    SELECT NUM_VENTA          ,
           COD_PRODUCTO       ,
           COD_OFICINA        ,
           COD_TIPCOMIS       ,
           COD_VENDEDOR       ,
           COD_VENDEDOR_AGENTE,
           NUM_UNIDADES       ,
           FEC_VENTA          ,
           COD_REGION         ,
           COD_PROVINCIA      ,
           COD_CIUDAD         ,
           IND_ESTVENTA       ,
           NUM_TRANSACCION    ,
           IND_PASOCOB        ,
           NOM_USUAR_VTA      ,
           IND_VENTA          ,
           COD_MONEDA         ,
           COD_CAUSAREC       ,
           IMP_VENTA          ,
           COD_TIPCONTRATO    ,
           NUM_CONTRATO       ,
           IND_TIPVENTA       ,
           COD_CLIENTE        ,
           COD_MODVENTA       ,
           TIP_VALOR          ,
           COD_CUOTA          ,
           COD_TIPTARJETA     ,
           NUM_TARJETA        ,
           COD_AUTTARJ        ,
           FEC_VENCITARJ      ,
           COD_BANCOTARJ      ,
           NUM_CTACORR        ,
           NUM_CHEQUE         ,
           COD_BANCO          ,
           COD_SUCURSAL       ,
           FEC_CUMPLIMENTA    ,
           FEC_RECDOCUM       ,
           FEC_ACEPREC        ,
           NOM_USUAR_ACEREC   ,
           NOM_USUAR_RECDOC   ,
           NOM_USUAR_CUMPL    ,
           IND_OFITER         ,
           IND_CHKDICOM       ,
           NUM_CONSULTA       ,
           COD_VENDEALER      ,
           NUM_FOLDEALER      ,
           COD_DOCDEALER      ,
           IND_DOCCOMP        ,
           OBS_INCUMP         ,
           COD_CAUSAREP       ,
           FEC_RECPROV        ,
           NOM_USUAR_RECPROV  ,
           NUM_DIAS           ,
           OBS_RECPROV        ,
           IMP_ABONO          ,
           IND_ABONO          ,
           FEC_RECEP_ADMVTAS  ,
           USU_RECEP_ADMVTAS  ,
           OBS_GRALCUMPL      ,
           IND_CONT_TELEF     ,
           FECHA_CONT_TELEF   ,
           USUARIO_CONT_TELEF ,
           MTO_GARANTIA       ,
           TIP_FOLIACION      ,
           COD_TIPDOCUM       ,
           COD_PLAZA          ,
           COD_OPERADORA      ,
           NUM_PROCESO
      INTO Reg_GA_Ventas
    FROM  GA_VENTAS
    WHERE  NUM_VENTA = lhNumVenta_EXT      ;
    IF Reg_GA_Ventas.Cod_Cuota is null or Reg_GA_Ventas.Cod_Cuota = '' THEN
        lhNumCuotas:=0;
    ELSE
        lhNumCuotas:=0;
        SELECT nvl(NUM_CUOTAS, 0)
        INTO lhNumCuotas
        FROM GE_TIPCUOTAS
        WHERE COD_CUOTA = Reg_GA_Ventas.Cod_Cuota;
    END IF;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','26');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','27');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND GA_VENTAS GA_VENTAS (3)','28');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO GA_VENTAS (3)','29');
END GetRegVentas;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (4) * OBTIENE LETRA FROM GE_LETRAS // fx(ihCOD_CATIMPOS,ihCOD_TIPDOCUM)--> szhLETRA           */
/* ********************************************************************************************* */
PROCEDURE GetLetra IS
BEGIN
    VP_PROC         := 'GetLetra                '   ;
    VP_TABLA        := 'GE_LETRAS'                  ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    szhLetra:=' ';
    SELECT LETRA
      INTO szhLetra
    FROM GE_LETRAS
    WHERE COD_TIPDOCUM = ihCodContado
      AND COD_CATIMPOS = ihCodCatImpos;
EXCEPTION
     WHEN utl_file.WRITE_ERROR THEN
         SET_ERROR('Error de Escritura LOG (F)','30');
     WHEN utl_file.INTERNAL_ERROR THEN
         SET_ERROR('Error Interno LOG (G)','31');
     WHEN NO_DATA_FOUND THEN
         SET_ERROR('NO DATA FOUND GE_LETRAS (4)','32');
     WHEN OTHERS THEN
         SET_ERROR('ERROR INESPERADO GE_LETRAS (4)','33');
END GetLetra;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (5) * OBTIENE CENTRO EMISOR //  fx(szhCOD_OFICINA,ihCOD_TIPDOCUM)--> ihCOD_CENTREMI           */
/* ********************************************************************************************* */
PROCEDURE GetCentroEmisor IS
BEGIN
    VP_PROC         := 'GetCentroEmisor         '   ;
    VP_TABLA        := 'AL_DOCUM_SUCURSAL'          ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    ihCodCentrEmi:=0;
    SELECT COD_CENTREMI
      INTO ihCodCentrEmi
    FROM AL_DOCUM_SUCURSAL
    WHERE COD_OFICINA = Reg_GA_Ventas.COD_OFICINA
      AND COD_TIPDOCUM = ihCodContado;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','34');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','35');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND AL_DOCUM_SUCURSAL (5) ['||Reg_GA_Ventas.COD_OFICINA||']['||TO_CHAR(ihCodContado)||']','36');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO AL_DOCUM_SUCURSAL (5)','37');
END GetCentroEmisor;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (6)* OBTENCION DE LA ZONA IMPOSITIVA                                                          */
/* ********************************************************************************************* */
PROCEDURE GetZonaImpositivaCliente IS
BEGIN
    VP_PROC         := 'GetZonaImpositivaCliente'   ;
    VP_TABLA        := 'GE_ZONACIUDAD'              ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    ihCodZonaImpo       :=0;
    SELECT A.COD_ZONAIMPO
      INTO ihCodZonaImpo
    FROM GE_ZONACIUDAD A ,GE_DIRECCIONES B, GA_DIRECCLI C
    WHERE C.COD_CLIENTE      = lhCodCliente_EXT
      AND C.COD_TIPDIRECCION = '1'
      AND C.COD_DIRECCION    = B.COD_DIRECCION
      AND A.COD_REGION       = B.COD_REGION
      AND A.COD_PROVINCIA    = B.COD_PROVINCIA
      AND A.COD_CIUDAD        = B.COD_CIUDAD
      AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','38');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','39');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND GE_ZONACIUDAD (6)','40');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO GE_ZONACIUDAD (6)','41');
END GetZonaImpositivaCliente;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (7) * OBTIENE INFORMACION DESDE EL DUAL                                                       */
/* ********************************************************************************************* */
PROCEDURE GetNumSecuencia IS
BEGIN
    VP_PROC         := 'GetNumSecuencia         '   ;
    VP_TABLA        := 'DUAL'                       ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    lhNumSecuenci:=0;
    SELECT FA_SEQ_CONTADO.NEXTVAL
      INTO lhNumSecuenci
    FROM DUAL;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','42');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','43');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (7)','44');
END GetNumSecuencia;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (8)* INSERTA UN NUEVO REGISTRO EN LA FA_PROCESOS                                              */
/* ********************************************************************************************* */
PROCEDURE InsertaRegFaProcesos IS
BEGIN
    VP_PROC         := 'InsertaRegFaProcesos    '   ;
    VP_TABLA        := 'FA_PROCESOS'                ;
    VP_ACT          := 'I'                          ;
    DEBUG;
    INSERT INTO FA_PROCESOS(
        NUM_PROCESO             ,
        COD_TIPDOCUM            ,
        COD_VENDEDOR_AGENTE     ,
        COD_CENTREMI            ,
        FEC_EFECTIVIDAD         ,
        NOM_USUARORA            ,
        LETRAAG                 ,
        NUM_SECUAG              ,
        COD_TIPDOCNOT           ,
        COD_VENDEDOR_AGENTENOT  ,
        LETRANOT                ,
        COD_CENTRNOT            ,
        NUM_SECUNOT             ,
        IND_ESTADO              ,
        COD_CICLFACT            )
    VALUES(
        lhNumProceso_EXT                        ,
        ihCodContado                            ,
        Reg_GA_Ventas.COD_VENDEDOR_AGENTE       ,
        ihCodCentremi                           ,
        SYSDATE                                 ,
        szhUser                                 ,
        szhLetra                                ,
        lhNumSecuenci                           ,
        0                                       ,
        0                                       ,
        NULL                                    ,
        0                                       ,
        0                                       ,
        PROC_EJEC                               ,
        NULL                                    );
    ProcesoCreado := TRUE; /*Se cres proceso en ejecucisn */
    utl_file.Put_Line(fh,'>> NUM_PROCESO            : [' || TO_CHAR(NVL(lhNumProceso_EXT,-999))  || ']' );
    utl_file.Put_Line(fh,'>> COD_TIPDOCUM           : [' || TO_CHAR(NVL(ihCodContado,-999))      || ']' );
    utl_file.Put_Line(fh,'>> COD_VENDEDOR_AGENTE    : [' || TO_CHAR(NVL(Reg_GA_Ventas.COD_VENDEDOR_AGENTE,-999)) || ']' );
    utl_file.Put_Line(fh,'>> COD_CENTREMI           : [' || TO_CHAR(NVL(ihCodCentremi,-999))     || ']' );
    utl_file.Put_Line(fh,'>> FEC_EFECTIVIDAD        : [' || TO_CHAR(SYSDATE,'DD/MON/YYYY hh24:mi:ss') || ']' );
    utl_file.Put_Line(fh,'>> NOM_USUARORA           : [' || NVL(szhUser,' ')                  || ']' );
    utl_file.Put_Line(fh,'>> LETRAAG                : [' || NVL(szhLetra,' ')                 || ']' );
    utl_file.Put_Line(fh,'>> NUM_SECUAG             : [' || TO_CHAR(NVL(lhNumSecuenci,-999))     || ']' );
    utl_file.Put_Line(fh,'>> COD_TIPDOCNOT          : [' || '0'                               || ']' );
    utl_file.Put_Line(fh,'>> COD_VENDEDOR_AGENTENOT : [' || '0'                               || ']' );
    utl_file.Put_Line(fh,'>> LETRANOT               : []');
    utl_file.Put_Line(fh,'>> COD_CENTRNOT           : [' || '0'                               || ']' );
    utl_file.Put_Line(fh,'>> NUM_SECUNOT            : [' || '0'                               || ']' );
    utl_file.Put_Line(fh,'>> IND_ESTADO             : [' || TO_CHAR(NVL(PROC_EJEC,-999))         || ']' );
    utl_file.Put_Line(fh,'>> COD_CICLFACT           : []');
    utl_file.fflush(fh);
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','45');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','46');
    WHEN DUP_VAL_ON_INDEX THEN
        SET_ERROR('INDICE DUPLICADO FA_PROCESOS (8)','47');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO FA_PROCESOS (8)','48');
END InsertaRegFaProcesos;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (9-A)* RECUPERA DATOS DE LA FA_CONCEPTOS                                                      */
/* ********************************************************************************************* */
FUNCTION fbGetFaConceptos(ihCodConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE ) RETURN BOOLEAN IS
ERROR_IND_ACTIVO  EXCEPTION ;
BEGIN
    VP_PROC         := 'fbGetFaConceptos        '   ;
    VP_TABLA        := 'FA_CONCEPTOS'               ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    szhCodModulo:=' ';
    szhCodMoneda:=' ';
    ihCodTipConce:=0;
    ihIndActivo:=0;
    ihCodProducto:=0;
    szhCodDescu:=' ';
    SELECT COD_MODULO,
           COD_MONEDA,
           COD_TIPCONCE,
           IND_ACTIVO,
           COD_PRODUCTO,
           COD_TIPDESCU
      INTO szhCodModulo,
           szhCodMoneda,
           ihCodTipConce,
           ihIndActivo,
           ihCodProducto,
           szhCodDescu
    FROM FA_CONCEPTOS
    WHERE COD_CONCEPTO = ihCodConcepto;
    IF ihIndActivo = 0 THEN
        RAISE ERROR_IND_ACTIVO;
    ELSE
        RETURN TRUE;
    END IF;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        BEGIN
            SET_ERROR('Error de Escritura LOG (F)','49');
            RETURN FALSE;
        END;
    WHEN utl_file.INTERNAL_ERROR THEN
        BEGIN
           SET_ERROR('Error Interno LOG (G)','50');
           RETURN FALSE;
        END;
    WHEN NO_DATA_FOUND THEN
        BEGIN
            szError := 'A';
            SET_ERROR('NO DATA FOUND FA_CONCEPTOS (9a)','51');
            RETURN FALSE;
        END;
    WHEN ERROR_IND_ACTIVO  THEN
        BEGIN
            SET_ERROR('ERROR IND ACTIVO = 0 (9a)','52');
            szError := 'B';
            RETURN FALSE;
        END;
    WHEN OTHERS THEN
        BEGIN
            SET_ERROR('ERROR INESPERADO FA_CONCEPTOS (9a)','53');
            szError := '?';
            RETURN FALSE;
        END;
END fbGetFaConceptos;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (9)* CARGA CARGOS DEL CLIENTE                                                                 */
/* ********************************************************************************************* */
PROCEDURE CargaCargos IS
    STATUS                  BOOLEAN := TRUE ;
    CONCEPTO_NO_ENCONTRADO  EXCEPTION;
    CONCEPTO_ES_IMPUESTO    EXCEPTION;
    CONCEPTO_ES_DESCUENTO   EXCEPTION;
    NO_EXISTEN_CARGOS       EXCEPTION;
    NUM_ELEMENTOS           NUMBER(10):=0;
    CURSOR cCARGA_CARGOS IS
        SELECT  NUM_CARGO         , COD_CLIENTE       , COD_PRODUCTO      ,
                COD_CONCEPTO      , FEC_ALTA          , IMP_CARGO         ,
                COD_MONEDA        , COD_PLANCOM       , NUM_UNIDADES      ,
                IND_FACTUR        , NUM_TRANSACCION   , NUM_VENTA         ,
                NUM_PAQUETE       , NUM_ABONADO       , NUM_TERMINAL      ,
                COD_CICLFACT      , NUM_SERIE         , NUM_SERIEMEC      ,
                CAP_CODE          , MES_GARANTIA      , NUM_PREGUIA       ,
                NUM_GUIA          , NUM_FACTURA       , COD_CONCEPTO_DTO  ,
                VAL_DTO           , TIP_DTO           , IND_CUOTA         ,
                IND_SUPERTEL      , IND_MANUAL        , NOM_USUARORA      ,
                ROWID             , COD_TECNOLOGIA
        FROM GE_CARGOS
        WHERE NUM_VENTA = lhNumVenta_EXT
          AND NUM_TRANSACCION = lhNumTransaccion_EXT
          AND NUM_FACTURA = 0
        ORDER BY NUM_CARGO;
    i                       PLS_INTEGER := 0;
BEGIN
    VP_PROC         := 'CargaCargos             '   ;
    VP_TABLA        := 'GE_CARGOS'                  ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    /* VALIDA SI TIENE AL MENOS UN CARGO RECUPERADO */
    NUM_ELEMENTOS:=0;
    SELECT COUNT(1)
      INTO NUM_ELEMENTOS
    FROM GE_CARGOS
    WHERE NUM_VENTA = lhNumVenta_EXT
      AND NUM_TRANSACCION = lhNumTransaccion_EXT
      AND NUM_FACTURA = 0
    ORDER BY NUM_CARGO;
    IF NUM_ELEMENTOS = 0 THEN
        RAISE NO_EXISTEN_CARGOS;
    END IF;
    FOR rRegCargo IN cCARGA_CARGOS LOOP
        i := i + 1 ;
        STATUS := fbGetFaConceptos(rRegCargo.COD_CONCEPTO);
        utl_file.Put_Line(fh,'>> COD_MODULO   : [' || NVL(szhCodModulo,' ')  || ']' );
        utl_file.Put_Line(fh,'>> COD_MONEDA   : [' || NVL(szhCodMoneda,' ')  || ']' );
        utl_file.Put_Line(fh,'>> COD_TIPCONCE : [' || TO_CHAR(NVL(ihCodTipConce,-999)) || ']' );
        utl_file.Put_Line(fh,'>> IND_ACTIVO   : [' || TO_CHAR(NVL(ihIndActivo,-999))   || ']' );
        utl_file.Put_Line(fh,'>> COD_PRODUCTO : [' || TO_CHAR(NVL(ihCodProducto,-999)) || ']' );
        utl_file.Put_Line(fh,'>> COD_TIPDESCU : [' || NVL(szhCodDescu,' ')   || ']' );
        IF STATUS != TRUE THEN
            RAISE CONCEPTO_NO_ENCONTRADO;
        ELSIF ihCodTipConce = 1 THEN
            RAISE CONCEPTO_ES_IMPUESTO;
        ELSIF ihCodTipConce = 2 THEN
            RAISE CONCEPTO_ES_DESCUENTO;
        ELSE
            Tab_CARGA_CARGOS(i).NUM_CARGO         := rRegCargo.NUM_CARGO ;
            Tab_CARGA_CARGOS(i).COD_CLIENTE       := rRegCargo.COD_CLIENTE ;
            Tab_CARGA_CARGOS(i).COD_PRODUCTO      := rRegCargo.COD_PRODUCTO ;
            Tab_CARGA_CARGOS(i).COD_CONCEPTO      := rRegCargo.COD_CONCEPTO ;
            Tab_CARGA_CARGOS(i).FEC_ALTA          := rRegCargo.FEC_ALTA ;
            Tab_CARGA_CARGOS(i).IMP_CARGO         := rRegCargo.IMP_CARGO ;
            Tab_CARGA_CARGOS(i).COD_MONEDA        := rRegCargo.COD_MONEDA ;
            Tab_CARGA_CARGOS(i).COD_PLANCOM       := rRegCargo.COD_PLANCOM ;
            Tab_CARGA_CARGOS(i).NUM_UNIDADES      := rRegCargo.NUM_UNIDADES ;
            Tab_CARGA_CARGOS(i).IND_FACTUR        := rRegCargo.IND_FACTUR ;
            Tab_CARGA_CARGOS(i).NUM_TRANSACCION   := rRegCargo.NUM_TRANSACCION ;
            Tab_CARGA_CARGOS(i).NUM_VENTA         := rRegCargo.NUM_VENTA ;
            Tab_CARGA_CARGOS(i).NUM_PAQUETE       := rRegCargo.NUM_PAQUETE ;
            Tab_CARGA_CARGOS(i).NUM_ABONADO       := rRegCargo.NUM_ABONADO ;
            Tab_CARGA_CARGOS(i).NUM_TERMINAL      := rRegCargo.NUM_TERMINAL ;
            Tab_CARGA_CARGOS(i).COD_CICLFACT      := rRegCargo.COD_CICLFACT ;
            Tab_CARGA_CARGOS(i).NUM_SERIE         := rRegCargo.NUM_SERIE ;
            Tab_CARGA_CARGOS(i).NUM_SERIEMEC      := rRegCargo.NUM_SERIEMEC ;
            Tab_CARGA_CARGOS(i).CAP_CODE          := rRegCargo.CAP_CODE ;
            Tab_CARGA_CARGOS(i).MES_GARANTIA      := rRegCargo.MES_GARANTIA ;
            Tab_CARGA_CARGOS(i).NUM_PREGUIA       := rRegCargo.NUM_PREGUIA ;
            Tab_CARGA_CARGOS(i).NUM_GUIA          := rRegCargo.NUM_GUIA ;
            Tab_CARGA_CARGOS(i).NUM_FACTURA       := rRegCargo.NUM_FACTURA ;
            Tab_CARGA_CARGOS(i).COD_CONCEPTO_DTO  := rRegCargo.COD_CONCEPTO_DTO ;
            Tab_CARGA_CARGOS(i).VAL_DTO           := rRegCargo.VAL_DTO ;
            Tab_CARGA_CARGOS(i).TIP_DTO           := rRegCargo.TIP_DTO ;
            Tab_CARGA_CARGOS(i).IND_CUOTA         := rRegCargo.IND_CUOTA ;
            Tab_CARGA_CARGOS(i).IND_SUPERTEL      := rRegCargo.IND_SUPERTEL ;
            Tab_CARGA_CARGOS(i).IND_MANUAL        := rRegCargo.IND_MANUAL ;
            Tab_CARGA_CARGOS(i).NOM_USUARORA      := rRegCargo.NOM_USUARORA ;
            Tab_CARGA_CARGOS(i).COD_TECNOLOGIA    := rRegCargo.COD_TECNOLOGIA ;
            Tab_CARGA_CARGOS(i).CodModuloFC       := szhCodModulo ;         /* Variables globales que vienen de fbGetFaConceptos */
            Tab_CARGA_CARGOS(i).CodMonedaFC       := szhCodMoneda ;
            Tab_CARGA_CARGOS(i).CodTipConceFC     := ihCodTipConce ;
            Tab_CARGA_CARGOS(i).IndActivoFC       := ihIndActivo ;
            Tab_CARGA_CARGOS(i).CodProductoFC     := ihCodProducto ;
            Tab_CARGA_CARGOS(i).CodTipDescFC      := szhCodDescu ;
            Tab_CARGA_CARGOS(i).Mi_RowID          := rRegCargo.ROWID ;
        END IF;
    END LOOP;

    FOR i IN Tab_CARGA_CARGOS.FIRST .. Tab_CARGA_CARGOS.LAST LOOP
            utl_file.Put_Line(fh,'>> NUM_CARGO        : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).NUM_CARGO,-999))       || ']' );
            utl_file.Put_Line(fh,'>> COD_PRODUCTO     : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).COD_PRODUCTO,-999))    || ']' );
            utl_file.Put_Line(fh,'>> COD_CONCEPTO     : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).COD_CONCEPTO,-999))    || ']' );
            utl_file.Put_Line(fh,'>> FEC_ALTA         : [' || NVL(TO_CHAR(Tab_CARGA_CARGOS(i).FEC_ALTA,'DD/MON/YYYY hh24:mi:ss'),' ') || ']' );
            utl_file.Put_Line(fh,'>> IMP_CARGO        : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).IMP_CARGO,0))          || ']' );
            utl_file.Put_Line(fh,'>> COD_MONEDA       : [' || NVL(Tab_CARGA_CARGOS(i).COD_MONEDA,' ')                || ']' );
            utl_file.Put_Line(fh,'>> NUM_UNIDADES     : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).NUM_UNIDADES,0))       || ']' );
            utl_file.Put_Line(fh,'>> IND_FACTUR       : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).IND_FACTUR,0))         || ']' );
            utl_file.Put_Line(fh,'>> NUM_ABONADO      : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).NUM_ABONADO,0))        || ']' );
            utl_file.Put_Line(fh,'>> NUM_TERMINAL     : [' || NVL(Tab_CARGA_CARGOS(i).NUM_TERMINAL,' ')              || ']' );
            utl_file.Put_Line(fh,'>> COD_CONCEPTO_DTO : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).COD_CONCEPTO_DTO,0))   || ']' );
            utl_file.Put_Line(fh,'>> VAL_DTO          : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).VAL_DTO,0))            || ']' );
            utl_file.Put_Line(fh,'>> TIP_DTO          : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).TIP_DTO,0))            || ']' );
            utl_file.Put_Line(fh,'>> IND_SUPERTEL     : [' || TO_CHAR(NVL(Tab_CARGA_CARGOS(i).IND_SUPERTEL,0))       || ']' );
    END LOOP;
    utl_file.fflush(fh);

EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','54');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','55');
    WHEN NO_EXISTEN_CARGOS THEN
        SET_ERROR('NO EXISTEN CARGOS (9)','56');
    WHEN CONCEPTO_NO_ENCONTRADO THEN
        SET_ERROR('CONCEPTO NO ENCONTRADO (9)','57');
    WHEN CONCEPTO_ES_IMPUESTO THEN
        SET_ERROR('CONCEPTO ES IMPUESTO (9)','58');
    WHEN CONCEPTO_ES_DESCUENTO THEN
        SET_ERROR('CONCEPTO ES DESCUENTO (9)','59');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND GE_CARGOS (9)','60');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO GE_CARGOS (9)','61');
END CargaCargos;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10-A-1)* CONVERSION DE MONEDAS SEGUN GENFA                                                   */
/* ********************************************************************************************* */
FUNCTION fbConvierteMonedas(szhFecha      IN GE_CONVERSION.FEC_DESDE%TYPE ,
                            szhCodMonedaO IN GE_CONVERSION.COD_MONEDA%TYPE ,
                            szhCodMonedaD IN GE_CONVERSION.COD_MONEDA%TYPE
                            ) RETURN BOOLEAN IS
BEGIN
    VP_PROC         := 'fbConvierteMonedas      '   ;
    VP_TABLA        := 'GE_CONVERSION'              ;
    VP_ACT          := 'S'                          ;
    DEBUG;
    dhCambioDestino := 0.0;
    dhCambioOrigen  := 0.0;
    SELECT CAMBIO
      INTO dhCambioOrigen
    FROM  GE_CONVERSION
    WHERE COD_MONEDA = szhCodMonedaO
      AND szhFecha BETWEEN FEC_DESDE AND FEC_HASTA;
    SELECT CAMBIO
      INTO dhCambioDestino
    FROM  GE_CONVERSION
    WHERE COD_MONEDA = szhCodMonedaD
      AND szhFecha BETWEEN FEC_DESDE AND FEC_HASTA;
    dhFCambio :=(dhCambioOrigen / dhCambioDestino);   /*Global*/
    RETURN TRUE;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        BEGIN
            SET_ERROR('DIVISION POR CERO (10a1)','62');
            szError := '0' ;
            RETURN FALSE;
        END;
    WHEN NO_DATA_FOUND THEN
        BEGIN
            SET_ERROR('NO DATA FOUND GE_CONVERSION (10a1)','63');
            szError := 'A' ;
            RETURN FALSE;
        END;
    WHEN OTHERS THEN
        BEGIN
            SET_ERROR('ERROR INESPERADO GE_CONVERSION (10a1)','64');
            szError := '?' ;
            RETURN FALSE;
        END;
END fbConvierteMonedas;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10-A)* CALCULO DEL IMPORTE FACTURABLE                                                        */
/* ********************************************************************************************* */
FUNCTION fdCalcImporteFact ( UNIDADES IN NUMBER
                           , MONEDA   IN VARCHAR2
                           , CONCEPTO IN FA_PRESUPUESTO.IMP_CONCEPTO%TYPE
                           , STATERR  OUT NOCOPY NUMBER
                           ) RETURN NUMBER IS
    dhImpFacturable  FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;
    status BOOLEAN := TRUE;
    ERROR_CONVERSION_MONEDA EXCEPTION;
BEGIN
    VP_PROC         := 'fdCalcImporteFact       '   ;
    VP_TABLA        := '-ninguna-'                  ;
    VP_ACT          := 'N'                          ;
    DEBUG;
    STATERR := 0;
    dhFCambio := 1;
    IF  MONEDA != szhCodMoneFact THEN
        status := fbConvierteMonedas ( SYSDATE, MONEDA, szhCodMoneFact ); /* dhFCambio != 1 */
        IF status = FALSE THEN
            RAISE ERROR_CONVERSION_MONEDA ;
        END IF;
    END IF;
    dhImpFacturable := CONCEPTO * UNIDADES * dhFCambio;
    RETURN dhImpFacturable;
EXCEPTION
    WHEN ERROR_CONVERSION_MONEDA THEN
        SET_ERROR('ERROR CONVERSION MONEDA (10a)','65');
        STATERR := -1;
        RETURN -1;
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (10a)','66');
        STATERR := -1;
        RETURN -1;
END fdCalcImporteFact;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10-B)* OBTIENE LA COLUMNA CORRESPONDIENTE AL CONCEPTO BUSCADO                                */
/* ********************************************************************************************* */
FUNCTION fGetColumna (ihConceptoBuscado IN GE_CARGOS.COD_CONCEPTO%TYPE) RETURN NUMBER IS
    i                  PLS_INTEGER := 1 ;
    ENCONTRADO BOOLEAN     := FALSE ;
    Columna    NUMBER      := 1;
BEGIN
    VP_PROC         := 'fGetColumna             ';
    VP_TABLA        := 'Tab_Columnas'            ;
    VP_ACT          := 'U'                       ;
    DEBUG;
    IF Tab_Columnas.COUNT = 0 THEN
        i := 1 ;
        Tab_Columnas(i).ihCodConcepto_COL := ihConceptoBuscado;
        Tab_Columnas(i).ihNumOcurrencias_COL := 1 ;
    ELSE
        FOR i IN Tab_Columnas.FIRST .. Tab_Columnas.LAST LOOP
            IF Tab_Columnas(i).ihCodConcepto_COL = ihConceptoBuscado THEN
                Tab_Columnas(i).ihNumOcurrencias_COL := Tab_Columnas(i).ihNumOcurrencias_COL + 1;
                Columna := Tab_Columnas(i).ihNumOcurrencias_COL;
                ENCONTRADO := TRUE;
            END IF;
        END LOOP;
        i := Tab_Columnas.LAST ;
        IF NOT ENCONTRADO THEN
            i := i + 1;
            Tab_Columnas(i).ihCodConcepto_COL := ihConceptoBuscado;
            Tab_Columnas(i).ihNumOcurrencias_COL := 1 ;
        END IF;
    END IF;
    RETURN Columna ;
EXCEPTION
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (10b)','67');
        RETURN -1;
END fGetColumna;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10)* CARGA LOS CARGOS EXISTENTES EN LA PREFACTURA (TAB_FA_PRESUPUESTO)                       */
/* ********************************************************************************************* */
PROCEDURE CargaCargosPrefactura IS
    i PLS_INTEGER;
    STERR INTEGER;
    ERROR_CALC_IMPORTE_FACT EXCEPTION;
    ERROR_GET_COLUMNA EXCEPTION;
BEGIN
    VP_PROC         := 'CargaCargosPrefactura   '   ;
    VP_TABLA        := 'Tab_FA_PRESUPUESTO'         ;
    VP_ACT          := 'I'                          ;
    DEBUG;
    FOR i IN Tab_CARGA_CARGOS.FIRST .. Tab_CARGA_CARGOS.LAST LOOP
        /* Valores Externos (Recibidos por parametros desde Visual Basic )*/
        Tab_FA_PRESUPUESTO(i).NUM_PROCESO       := lhNumProceso_EXT     ;
        Tab_FA_PRESUPUESTO(i).COD_CLIENTE       := lhCodCliente_EXT     ;
        Tab_FA_PRESUPUESTO(i).NUM_VENTA         := lhNumVenta_EXT       ;
        Tab_FA_PRESUPUESTO(i).NUM_TRANSACCION   := lhNumTransaccion_EXT ;
        /* Valores Constantes */
        Tab_FA_PRESUPUESTO(i).IND_ALTA          := 1                    ;
        Tab_FA_PRESUPUESTO(i).IND_CUOTA         := 0                    ;
        Tab_FA_PRESUPUESTO(i).NUM_CUOTAS        := 0                    ;
        Tab_FA_PRESUPUESTO(i).ORD_CUOTA         := 0                    ;
        Tab_FA_PRESUPUESTO(i).COD_PORTADOR      := 0                    ;
        Tab_FA_PRESUPUESTO(i).COD_CICLFACT      := NULL                 ;
        /* Valores Variables Independientes del FLAG */
        Tab_FA_PRESUPUESTO(i).FEC_EFECTIVIDAD   := SYSDATE              ;
        Tab_FA_PRESUPUESTO(i).FEC_VENTA         := SYSDATE              ;
        /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
        Tab_FA_PRESUPUESTO(i).COD_PRODUCTO      := Tab_CARGA_CARGOS(i).CodProductoFC    ;
        Tab_FA_PRESUPUESTO(i).COD_MONEDA        := Tab_CARGA_CARGOS(i).COD_MONEDA       ;
        Tab_FA_PRESUPUESTO(i).FEC_VALOR         := Tab_CARGA_CARGOS(i).FEC_ALTA         ;
        Tab_FA_PRESUPUESTO(i).COD_PLANCOM       := Tab_CARGA_CARGOS(i).COD_PLANCOM      ;
        Tab_FA_PRESUPUESTO(i).NUM_GUIA          := Tab_CARGA_CARGOS(i).NUM_GUIA         ;
        Tab_FA_PRESUPUESTO(i).VAL_DTO           := Tab_CARGA_CARGOS(i).VAL_DTO          ;
        Tab_FA_PRESUPUESTO(i).TIP_DTO           := Tab_CARGA_CARGOS(i).TIP_DTO          ;
        Tab_FA_PRESUPUESTO(i).MES_GARANTIA      := Tab_CARGA_CARGOS(i).MES_GARANTIA     ;
        Tab_FA_PRESUPUESTO(i).IND_SUPERTEL      := Tab_CARGA_CARGOS(i).IND_SUPERTEL     ;
        Tab_FA_PRESUPUESTO(i).NUM_PAQUETE       := Tab_CARGA_CARGOS(i).NUM_PAQUETE      ;
        Tab_FA_PRESUPUESTO(i).NUM_UNIDADES      := Tab_CARGA_CARGOS(i).NUM_UNIDADES     ;
        Tab_FA_PRESUPUESTO(i).IND_FACTUR        := Tab_CARGA_CARGOS(i).IND_FACTUR       ;
        Tab_FA_PRESUPUESTO(i).NUM_ABONADO       := Tab_CARGA_CARGOS(i).NUM_ABONADO      ;
        Tab_FA_PRESUPUESTO(i).NUM_TERMINAL      := Tab_CARGA_CARGOS(i).NUM_TERMINAL     ;
        Tab_FA_PRESUPUESTO(i).CAP_CODE          := Tab_CARGA_CARGOS(i).CAP_CODE         ;
        Tab_FA_PRESUPUESTO(i).NUM_SERIEMEC      := Tab_CARGA_CARGOS(i).NUM_SERIEMEC     ;
        Tab_FA_PRESUPUESTO(i).NUM_SERIELE       := Tab_CARGA_CARGOS(i).NUM_SERIE        ;
        /* Valores Variables Independientes del FLAG y Dependientes de la Tabla de Ventas */
        Tab_FA_PRESUPUESTO(i).COD_REGION        := Reg_GA_Ventas.COD_REGION             ;
        Tab_FA_PRESUPUESTO(i).COD_PROVINCIA     := Reg_GA_Ventas.COD_PROVINCIA          ;
        Tab_FA_PRESUPUESTO(i).COD_CIUDAD        := Reg_GA_Ventas.COD_CIUDAD             ;
        /* Valores Variables Independientes del FLAG y GLOBALES */
        Tab_FA_PRESUPUESTO(i).COD_MODULO        := Tab_CARGA_CARGOS(i).CodModuloFC      ;
        Tab_FA_PRESUPUESTO(i).COD_CATIMPOS      := ihCodCatImpos                        ;
        /* Valores Variables Dependientes del FLAG */
        Tab_FA_PRESUPUESTO(i).COD_CONCEPTO      := Tab_CARGA_CARGOS(i).COD_CONCEPTO     ;
        Tab_FA_PRESUPUESTO(i).IMP_MONTOBASE     := 0                                    ;
        Tab_FA_PRESUPUESTO(i).IND_ESTADO        := 2                                    ;
        Tab_FA_PRESUPUESTO(i).COD_TIPCONCE      := 3                                    ;
        Tab_FA_PRESUPUESTO(i).COD_CONCEREL      := 0                                    ;
        Tab_FA_PRESUPUESTO(i).COLUMNA_REL       := 0                                    ;
        Tab_FA_PRESUPUESTO(i).PRC_IMPUESTO      := NULL                                 ;
        IF ihCodCatImpos = 1 THEN
            Tab_FA_PRESUPUESTO(i).FLAG_IMPUES       := 1 ; /* COMO CLIENTE ESTA AFECTO A IMPUESTO */
        ELSE
            Tab_FA_PRESUPUESTO(i).FLAG_IMPUES       := 0 ; /* COMO CLIENTE ESTA EXENTO DE IMPUESTO */
        END IF;
        IF (Tab_CARGA_CARGOS(i).COD_CONCEPTO_DTO IS NULL OR Tab_CARGA_CARGOS(i).VAL_DTO IS NULL
           OR Tab_CARGA_CARGOS(i).TIP_DTO IS NULL)  THEN
            Tab_FA_PRESUPUESTO(i).FLAG_DTO  := 0                                    ;
        ELSE
            Tab_FA_PRESUPUESTO(i).FLAG_DTO  := 1                                    ;
        END IF;
        Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO   := fdCalcImporteFact(Tab_FA_PRESUPUESTO(i).NUM_UNIDADES,
                                                                  Tab_FA_PRESUPUESTO(i).COD_MONEDA,
                                                                  Tab_CARGA_CARGOS(i).IMP_CARGO  ,
                                                                  STERR);
        IF (Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO = -1 AND STERR = -1) THEN /* funcion anterior salio con error*/
            RAISE ERROR_CALC_IMPORTE_FACT;
        END IF;
        Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE :=  GE_PAC_GENERAL.REDONDEA(Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO, iNumDecimales, 0);
        Tab_FA_PRESUPUESTO(i).COLUMNA   := fGetColumna(Tab_FA_PRESUPUESTO(i).COD_CONCEPTO);
        IF Tab_FA_PRESUPUESTO(i).COLUMNA = -1  THEN
            RAISE ERROR_GET_COLUMNA;
        END IF;
        Tab_FA_PRESUPUESTO(i).COD_TECNOLOGIA    := Tab_CARGA_CARGOS(i).COD_TECNOLOGIA;
        utl_file.Put_Line(fh,'>> COD_MONEDA             : [' || NVL(Tab_FA_PRESUPUESTO(i).COD_MONEDA,' ')            || ']' );
        utl_file.Put_Line(fh,'>> COD_CONCEPTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COD_CONCEPTO,0))   || ']' );
        utl_file.Put_Line(fh,'>> IMP_CONCEPTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO,0))   || ']' );
        utl_file.Put_Line(fh,'>> COLUMNA                : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COLUMNA,0))        || ']' );
        utl_file.Put_Line(fh,'>> IMP_FACTURABLE         : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE,0)) || ']' );
        utl_file.Put_Line(fh,'>> COD_PRODUCTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COD_PRODUCTO,0))   || ']' );
        utl_file.Put_Line(fh,'>> COLUMNA_REL            : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COLUMNA_REL,0))    || ']' );
        utl_file.Put_Line(fh,'>> COD_DESCUENTO          : [' || NVL(szhCodDescu,' ') || ']' );
        utl_file.Put_Line(fh,'>> PRC_IMPUESTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).PRC_IMPUESTO,0))   || ']' );
        utl_file.Put_Line(fh,'>> COD_TECNOLOGIA         : [' || NVL(Tab_FA_PRESUPUESTO(i).COD_TECNOLOGIA,0)          || ']' );
        utl_file.fflush(fh);
    END LOOP;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','68');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','69');
    WHEN ERROR_CALC_IMPORTE_FACT THEN
        SET_ERROR('ERROR CALCULO IMPORTE FACTURABLE (10)','70');
    WHEN ERROR_GET_COLUMNA THEN
        SET_ERROR('ERROR AL OBTENER COLUMNA (10)','71');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (10)','72');
END CargaCargosPrefactura;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (11-A)* INSERTA DATOS DESDE EL ARREGLO A LA TABLA DE VENTAS DTO                               */
/* ********************************************************************************************* */
PROCEDURE InsertaVentaDtos IS
    i PLS_INTEGER := 0;
BEGIN
    VP_PROC         := 'InsertaVentaDtos        '   ;
    VP_TABLA        := 'VE_VENTADTOS'               ;
    VP_ACT          := 'I'                          ;
    DEBUG;
    FOR i IN Tab_VENTADTO.FIRST .. Tab_VENTADTO.LAST LOOP
        INSERT INTO VE_VENTADTOS(
            NUM_VENTA     ,
            NUM_ITEM      ,
            COD_PRODUCTO  ,
            IMP_VENTA     ,
            IND_DTO       ,
            VAL_DTO       ,
            NUM_UNIDADES  ,
            IND_ACEPTA    ,
            COD_CTODTO    ,
            COD_ARTICULO  )
        VALUES(
            Tab_VENTADTO(i).NUM_VENTA     ,
            Tab_VENTADTO(i).NUM_ITEM      ,
            Tab_VENTADTO(i).COD_PRODUCTO  ,
            Tab_VENTADTO(i).IMP_VENTA     ,
            Tab_VENTADTO(i).IND_DTO       ,
            Tab_VENTADTO(i).VAL_DTO       ,
            Tab_VENTADTO(i).NUM_UNIDADES  ,
            Tab_VENTADTO(i).IND_ACEPTA    ,
            Tab_VENTADTO(i).COD_CTODTO    ,
            Tab_VENTADTO(i).COD_ARTICULO  );
        utl_file.Put_Line(fh,'>> NUM_VENTA              : [' || TO_CHAR(NVL(Tab_VENTADTO(i).NUM_VENTA   ,0)) || ']' );
        utl_file.Put_Line(fh,'>> NUM_ITEM               : [' || TO_CHAR(NVL(Tab_VENTADTO(i).NUM_ITEM    ,0)) || ']' );
        utl_file.Put_Line(fh,'>> COD_PRODUCTO           : [' || TO_CHAR(NVL(Tab_VENTADTO(i).COD_PRODUCTO,0)) || ']' );
        utl_file.Put_Line(fh,'>> IMP_VENTA              : [' || TO_CHAR(NVL(Tab_VENTADTO(i).IMP_VENTA   ,0)) || ']' );
        utl_file.Put_Line(fh,'>> IND_DTO                : [' || TO_CHAR(NVL(Tab_VENTADTO(i).IND_DTO     ,0)) || ']' );
        utl_file.Put_Line(fh,'>> VAL_DTO                : [' || TO_CHAR(NVL(Tab_VENTADTO(i).VAL_DTO     ,0)) || ']' );
        utl_file.Put_Line(fh,'>> NUM_UNIDADES           : [' || TO_CHAR(NVL(Tab_VENTADTO(i).NUM_UNIDADES,0)) || ']' );
        utl_file.Put_Line(fh,'>> IND_ACEPTA             : [' || TO_CHAR(NVL(Tab_VENTADTO(i).IND_ACEPTA  ,0)) || ']' );
        utl_file.Put_Line(fh,'>> COD_CTODTO             : [' || TO_CHAR(NVL(Tab_VENTADTO(i).COD_CTODTO  ,0)) || ']' );
        utl_file.Put_Line(fh,'>> COD_ARTICULO           : [' || TO_CHAR(NVL(Tab_VENTADTO(i).COD_ARTICULO,0)) || ']' );
        utl_file.fflush(fh);
    END LOOP;
    /* COMMIT; */
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','73');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','74');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND VE_VENTADTOS (11a)','75');
    WHEN DUP_VAL_ON_INDEX THEN
        SET_ERROR('INDICE DUPLICADO VE_VENTADTOS (11a)','76');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO VE_VENTADTOS (11a)','77');
END InsertaVentaDtos;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (11)* CARGA LOS DESCUENTOS EXISTENTES EN LA PREFACTURA (TAB_FA_PRESUPUESTO)                   */
/* ********************************************************************************************* */
PROCEDURE CargaDesctosPrefactura IS
    i PLS_INTEGER;
    j PLS_INTEGER;
    l PLS_INTEGER;
    status BOOLEAN              := TRUE;
    sterr  INTEGER;
    FIN_CARGO PLS_INTEGER   := Tab_FA_PRESUPUESTO.LAST;
    ERROR_CALC_IMPORTE_FACT EXCEPTION;
    ERROR_GET_FA_CONCEPTO EXCEPTION;
    ERROR_GET_COLUMNA EXCEPTION;
BEGIN
    VP_PROC         := 'CargaDesctosPrefactura  '   ;
    VP_TABLA        := 'Tab_FA_PRESUPUESTO'         ;
    VP_ACT          := 'I'                          ;
    DEBUG;
    FOR i IN Tab_FA_PRESUPUESTO.FIRST .. FIN_CARGO LOOP
        IF Tab_FA_PRESUPUESTO(i).FLAG_DTO = 1 THEN
            j := Tab_FA_PRESUPUESTO.LAST + 1;  /* Agrego al final de la Tab_FA_PRESUPUESTO */
            /* traspasa los datos originales */
            Tab_FA_PRESUPUESTO(j)                   := Tab_FA_PRESUPUESTO(i);
            /* Valores Externos (Recibidos por parametros desde Visual Basic )*/
            Tab_FA_PRESUPUESTO(j).NUM_PROCESO       := lhNumProceso_EXT     ;
            Tab_FA_PRESUPUESTO(j).COD_CLIENTE       := lhCodCliente_EXT     ;
            Tab_FA_PRESUPUESTO(j).NUM_VENTA         := lhNumVenta_EXT       ;
            Tab_FA_PRESUPUESTO(j).NUM_TRANSACCION   := lhNumTransaccion_EXT ;
            /* Valores Constantes */
            Tab_FA_PRESUPUESTO(j).IND_ALTA          := 1                    ;
            Tab_FA_PRESUPUESTO(j).IND_CUOTA         := 0                    ;
            Tab_FA_PRESUPUESTO(j).NUM_CUOTAS        := 0                    ;
            Tab_FA_PRESUPUESTO(j).ORD_CUOTA         := 0                    ;
            Tab_FA_PRESUPUESTO(j).COD_PORTADOR      := 0                    ;
            Tab_FA_PRESUPUESTO(j).COD_CICLFACT      := NULL                 ;
            /* Valores Variables Independientes del FLAG */
            Tab_FA_PRESUPUESTO(j).FEC_EFECTIVIDAD   := SYSDATE              ;
            Tab_FA_PRESUPUESTO(j).FEC_VENTA         := SYSDATE              ;
            /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
            /* Valores Variables Independientes del FLAG y Dependientes de la Tabla de Ventas */
            Tab_FA_PRESUPUESTO(j).COD_REGION        := Reg_GA_Ventas.COD_REGION             ;
            Tab_FA_PRESUPUESTO(j).COD_PROVINCIA     := Reg_GA_Ventas.COD_PROVINCIA          ;
            Tab_FA_PRESUPUESTO(j).COD_CIUDAD        := Reg_GA_Ventas.COD_CIUDAD             ;
            /* Valores Variables Independientes del FLAG y GLOBALES */
            Tab_FA_PRESUPUESTO(j).COD_CATIMPOS      := ihCodCatImpos                        ;
            /* Valores Variables Dependientes del FLAG */
            Tab_FA_PRESUPUESTO(j).COD_CONCEPTO      := Tab_CARGA_CARGOS(i).COD_CONCEPTO_DTO ;
            Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE     := Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE ;
            Tab_FA_PRESUPUESTO(j).IND_ESTADO        := 2                                    ;
            Tab_FA_PRESUPUESTO(j).COD_TIPCONCE      := 2                                    ;
            Tab_FA_PRESUPUESTO(j).COD_CONCEREL      := Tab_FA_PRESUPUESTO(i).COD_CONCEPTO   ;
            Tab_FA_PRESUPUESTO(j).COLUMNA_REL       := Tab_FA_PRESUPUESTO(i).COLUMNA        ;
            Tab_FA_PRESUPUESTO(j).FLAG_IMPUES       := 0                                    ;
            Tab_FA_PRESUPUESTO(j).FLAG_DTO          := 0                                    ;
            Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO      := NULL                                 ;
            IF Tab_FA_PRESUPUESTO(i).TIP_DTO = 0 THEN
                Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO  := Tab_FA_PRESUPUESTO(i).VAL_DTO * -1 ;
            ELSE
                Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO  :=  (Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO *
                                                        (Tab_CARGA_CARGOS(i).VAL_DTO/100)) * -1 ;
            END IF;
            Tab_FA_PRESUPUESTO(j).COLUMNA   := fGetColumna(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
            IF Tab_FA_PRESUPUESTO(j).COLUMNA = -1  THEN
                RAISE ERROR_GET_COLUMNA;
            END IF;
            Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO  := fdCalcImporteFact(1, Tab_FA_PRESUPUESTO(j).COD_MONEDA, Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO ,STERR);
            IF (Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO = -1 AND STERR = -1) THEN
                RAISE ERROR_CALC_IMPORTE_FACT ;
            END IF;
            Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE:=   GE_PAC_GENERAL.REDONDEA(Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO, iNumDecimales, 0);
            status := fbGetFaConceptos(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
            IF (status = FALSE) THEN
                RAISE ERROR_GET_FA_CONCEPTO;
            END IF;
            IF ((status = TRUE) AND (szhCodDescu = 'A')) THEN
                IF Tab_VENTADTO.COUNT = 0 THEN
                    l := 1;
                ELSE
                    l := Tab_VENTADTO.LAST + 1 ;
                END IF;
                Tab_VENTADTO(l).NUM_VENTA       := lhNumVenta_EXT                       ;
                Tab_VENTADTO(l).NUM_ITEM        := Tab_CARGA_CARGOS(i).NUM_CARGO        ;
                Tab_VENTADTO(l).COD_PRODUCTO    := ihCodProducto                        ;
                Tab_VENTADTO(l).IMP_VENTA       := Tab_CARGA_CARGOS(i).IMP_CARGO        ;
                Tab_VENTADTO(l).IND_DTO         := Tab_CARGA_CARGOS(i).TIP_DTO          ;
                Tab_VENTADTO(l).VAL_DTO         := Tab_CARGA_CARGOS(i).VAL_DTO          ;
                Tab_VENTADTO(l).NUM_UNIDADES    := Tab_FA_PRESUPUESTO(j).NUM_UNIDADES   ;
                Tab_VENTADTO(l).IND_ACEPTA      := 0                                    ;
                Tab_VENTADTO(l).COD_CTODTO      := Tab_FA_PRESUPUESTO(j).COD_CONCEPTO   ;
                Tab_VENTADTO(l).COD_ARTICULO    := NULL                                 ;
            END IF;
            Tab_FA_PRESUPUESTO(j).COD_PRODUCTO      := ihCodProducto                        ;
            Tab_FA_PRESUPUESTO(j).COD_MODULO        := szhCodModulo                         ;
            Tab_FA_PRESUPUESTO(j).COD_TECNOLOGIA    := Tab_FA_PRESUPUESTO(i).COD_TECNOLOGIA ;
            utl_file.Put_Line(fh,'>> COD_MONEDA             : [' || NVL(Tab_FA_PRESUPUESTO(i).COD_MONEDA, ' ')           || ']' );
            utl_file.Put_Line(fh,'>> COD_CONCEPTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO,0))   || ']' );
            utl_file.Put_Line(fh,'>> IMP_CONCEPTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO,0))   || ']' );
            utl_file.Put_Line(fh,'>> COLUMNA                : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(j).COLUMNA,0))        || ']' );
            utl_file.Put_Line(fh,'>> IMP_FACTURABLE         : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE,0)) || ']' );
            utl_file.Put_Line(fh,'>> COD_PRODUCTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(j).COD_PRODUCTO,0))   || ']' );
            utl_file.Put_Line(fh,'>> COLUMNA_REL            : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(j).COLUMNA_REL,0))    || ']' );
            utl_file.Put_Line(fh,'>> COD_DESCUENTO          : [' || NVL(szhCodDescu,' ') || ']' );
            utl_file.Put_Line(fh,'>> PRC_IMPUESTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO,0))   || ']' );
            utl_file.Put_Line(fh,'>> COD_TECNOLOGIA         : [' || NVL(Tab_FA_PRESUPUESTO(j).COD_TECNOLOGIA,0)          || ']' );
            utl_file.fflush(fh);
        END IF;
    END LOOP;
    FIN_DSCTO := Tab_FA_PRESUPUESTO.LAST;
    IF Tab_VENTADTO.COUNT > 0 THEN  /*Si hay Datos en el arreglo los ingresa a la tabla correspondiente */
        InsertaVentaDtos;
    END IF;
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','78');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','79');
    WHEN ERROR_CALC_IMPORTE_FACT THEN
        SET_ERROR('ERROR CALCULO IMPORTE FACTURABLE (11)','80');
    WHEN ERROR_GET_FA_CONCEPTO THEN
        SET_ERROR('ERROR AL OBTENER CONCEPTOS (11)','81');
    WHEN ERROR_GET_COLUMNA THEN
        SET_ERROR('ERROR AL OBTENER COLUMNA (11)','82');
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO_DATA_FOUND Tab_FA_PRESUPUESTO (11)','83');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO Tab_FA_PRESUPUESTO (11)','84');
END CargaDesctosPrefactura;

/* *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (13)* INSERTA UN GRUPO DE NUEVOS REGISTROS EN LA FA_PRESUPUESTO                               */
/* ********************************************************************************************* */
PROCEDURE InsertaRegFaPresupuesto IS
    i                       PLS_INTEGER;
    Separador       VARCHAR2(60);
BEGIN
    VP_PROC         := 'InsertaRegFaPresupuesto '   ;
    VP_TABLA        := 'FA_PRESUPUESTO'             ;
    VP_ACT          := 'I'                          ;
    DEBUG;
    FOR i IN Tab_FA_PRESUPUESTO.FIRST .. Tab_FA_PRESUPUESTO.LAST LOOP
        Separador := '(' || NVL(i,0) || ')' || Raya1;
        utl_file.Put_Line(fh,nvl(separador,' '));
        utl_file.Put_Line(fh,'>> COD_CONCEPTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COD_CONCEPTO,0))   || ']' );
        utl_file.Put_Line(fh,'>> COLUMNA                : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COLUMNA,0))        || ']' );
        utl_file.Put_Line(fh,'>> COD_PRODUCTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COD_PRODUCTO,0))   || ']' );
        utl_file.Put_Line(fh,'>> COD_MONEDA             : [' || NVL(Tab_FA_PRESUPUESTO(i).COD_MONEDA,' ')            || ']' );
        utl_file.Put_Line(fh,'>> FEC_VALOR              : [' || NVL(TO_CHAR(Tab_FA_PRESUPUESTO(i).FEC_VALOR,'DD/MON/YYYY hh24:mi:ss'),' ')             || ']' );
        utl_file.Put_Line(fh,'>> FEC_EFECTIVIDAD        : [' || NVL(TO_CHAR(Tab_FA_PRESUPUESTO(i).FEC_EFECTIVIDAD,'DD/MON/YYYY hh24:mi:ss'),' ')       || ']' );
        utl_file.Put_Line(fh,'>> IMP_CONCEPTO           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO,0))   || ']' );
        utl_file.Put_Line(fh,'>> IMP_FACTURABLE         : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE,0)) || ']' );
        utl_file.Put_Line(fh,'>> COD_MODULO             : [' || NVL(Tab_FA_PRESUPUESTO(i).COD_MODULO,' ')            || ']' );
        utl_file.Put_Line(fh,'>> FEC_VENTA              : [' || NVL(TO_CHAR(Tab_FA_PRESUPUESTO(i).FEC_VENTA, 'DD/MON/YYYY hh24:mi:ss') ,' ')            || ']' );
        utl_file.Put_Line(fh,'>> COD_TIPCONCE           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COD_TIPCONCE,0))   || ']' );
        utl_file.Put_Line(fh,'>> NUM_UNIDADES           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).NUM_UNIDADES,0))            || ']' );
        utl_file.Put_Line(fh,'>> COD_CONCEREL           : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COD_CONCEREL,0))   || ']' );
        utl_file.Put_Line(fh,'>> COLUMNA_REL            : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).COLUMNA_REL,0))    || ']' );
        utl_file.Put_Line(fh,'>> NUM_ABONADO            : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).NUM_ABONADO,0))    || ']' );
        utl_file.Put_Line(fh,'>> FLAG_IMPUES            : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).FLAG_IMPUES,0))    || ']' );
        utl_file.Put_Line(fh,'>> FLAG_DTO               : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).FLAG_DTO,0))       || ']' );
        utl_file.Put_Line(fh,'>> VAL_DTO                : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).VAL_DTO,0))        || ']' );
        utl_file.Put_Line(fh,'>> TIP_DTO                : [' || TO_CHAR(NVL(Tab_FA_PRESUPUESTO(i).TIP_DTO,0))        || ']' );
    END LOOP;
    utl_file.fflush(fh);

        FORALL i IN Tab_FA_PRESUPUESTO.FIRST .. Tab_FA_PRESUPUESTO.LAST
        INSERT INTO FA_PRESUPUESTO
        VALUES Tab_FA_PRESUPUESTO(i);

EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','85');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','86');
    WHEN DUP_VAL_ON_INDEX THEN
        SET_ERROR('INDICE DUPLICADO FA_PRESUPUESTO (13)','87');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO FA_PRESUPUESTO (13)','88');
END InsertaRegFaPresupuesto;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (14)* ACTUALIZA LA TABLA GE_CARGOS                                                            */
/* ********************************************************************************************* */
PROCEDURE UpdateCargos IS
    i PLS_INTEGER := 0;
BEGIN
    VP_PROC         := 'UpdateCargos            '   ;
    VP_TABLA        := 'GE_CARGOS'                  ;
    VP_ACT          := 'U'                          ;
    DEBUG;
    FOR i IN Tab_CARGA_CARGOS.FIRST .. Tab_CARGA_CARGOS.LAST LOOP
        UPDATE GE_CARGOS
        SET NUM_FACTURA = lhNumProceso_EXT
        WHERE ROWID = Tab_CARGA_CARGOS(i).Mi_RowID; /* Rowid recuperado antes */
    END LOOP;
    /* COMMIT; */
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO_DATA_FOUND GE_CARGOS (14)','89');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (14)','90');
END UpdateCargos;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (15)* CAMBIA EL ESTADO DEL PROCESO EN EJECUCION                                               */
/* ********************************************************************************************* */
PROCEDURE CambiaEstadoProceso (ihIndEstado IN NUMBER) IS
BEGIN
    VP_PROC         := 'CambiaEstadoProceso 1';
    VP_TABLA        := 'FA_PROCESOS 1'                                ;
    IF (ihIndEstado != PROC_ERR) THEN
        VP_PROC         := 'CambiaEstadoProceso     '   ;
        VP_TABLA        := 'FA_PROCESOS'                ;
        VP_ACT          := 'U'                          ;
    END IF;
    DEBUG;
    UPDATE FA_PROCESOS
      SET IND_ESTADO = ihIndEstado
    WHERE NUM_PROCESO = lhNumProceso_EXT;
    IF (ihIndEstado = PROC_OK) THEN
        VP_SQLCODE := '0';
        VP_SQLERRM := 'NO ERROR';
        VP_ERROR   := '0';
        VP_DESCERR := '********** TERMINO EXITOSO DEL PROCESO **********';
        utl_file.Put_Line(fh,NVL(Raya2,' '));
        utl_file.Put_Line(fh,NVL(VP_DESCERR,' '));
        utl_file.Put_Line(fh,'** FECHA DE TERMINO: ' || TO_CHAR(SYSDATE, '[DD/MON/YYYY][hh24:mi:ss]') || '    *');
        utl_file.Put_Line(fh,NVL(Raya2,' '));
        utl_file.Put_Line(fh,'VP_ERROR  =['|| VP_ERROR   || '] len('||TO_CHAR(LENGTH(VP_ERROR   ))||')');
        utl_file.Put_Line(fh,'VP_PROC   =['|| VP_PROC    || '] len('||TO_CHAR(LENGTH(VP_PROC    ))||')');
        utl_file.Put_Line(fh,'VP_SQLCODE=['|| VP_SQLCODE || '] len('||TO_CHAR(LENGTH(VP_SQLCODE ))||')');
        utl_file.Put_Line(fh,'VP_SQLERRM=['|| VP_SQLERRM || '] len('||TO_CHAR(LENGTH(VP_SQLERRM ))||')');
        utl_file.Put_Line(fh,'VP_TABLA  =['|| VP_TABLA   || '] len('||TO_CHAR(LENGTH(VP_TABLA   ))||')');
        utl_file.Put_Line(fh,'VP_DESCERR=['|| VP_DESCERR || '] len('||TO_CHAR(LENGTH(VP_DESCERR ))||')');
        utl_file.fflush(fh);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SET_ERROR('NO DATA FOUND FA_PROCESOS (15)','91');
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)','92');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)','93');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (15)','94');
END CambiaEstadoProceso;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (17)* INSERTA DATOS EN LA INTERFACE UNICA CON EL SCHEDULER                            */
/* ********************************************************************************************* */
PROCEDURE InsertaRegistroInterfaz IS
    iDocumVenta             NUMBER := 1;
    iEstInicProc    NUMBER := 0;
    iEstProceso             NUMBER := 0;
    iEstadoRetorno  NUMBER := 1;
    ERROR_NUEVO_PL  EXCEPTION;
BEGIN
    VP_PROC         := 'InsertaRegistroInterfaz     ';
    VP_TABLA        := 'FA_INTERFACT'                                ;
    VP_ACT          := 'I'                                                   ;
    DEBUG;
    utl_file.Put_Line(fh,'*** INVOCACION PL FA_INS_INTERFACT ***' );
    utl_file.Put_Line(fh,'>> NUMERO DE TRANSACCION  : [' || TO_CHAR(NVL(lhNumTransaccion_EXT,0))       || ']' );
    utl_file.Put_Line(fh,'>> NUMERO DE PROCESO      : [' || TO_CHAR(NVL(lhNumProceso_EXT,0))           || ']' );
    utl_file.Put_Line(fh,'>> NUMERO DE VENTA        : [' || TO_CHAR(NVL(lhNumVenta_EXT,0))             || ']' );
    utl_file.Put_Line(fh,'>> IND. GENER. DOCUMENTOS : [' || NVL(szhCodModGener_EXT,' ')                || ']' );
    utl_file.Put_Line(fh,'>> DOCUMENTO A GENERAR    : [' || TO_CHAR(NVL(iDocumVenta,0))                || ']' );
    utl_file.Put_Line(fh,'>> CATEG. TRIBUT. CLIENTE : [' || NVL(szhCodCaTribut_EXT,' ')                || ']' );
    utl_file.Put_Line(fh,'>> FOLIO DOC. RELACIONADO : [' || 'NULL'                                     || ']' );
    utl_file.Put_Line(fh,'>> EST. INICIAL PROCESO   : [' || TO_CHAR(NVL(iEstInicProc,0))               || ']' );
    utl_file.Put_Line(fh,'>> ESTADO DEL PROCESO     : [' || TO_CHAR(NVL(iEstProceso ,0))               || ']' );
    utl_file.Put_Line(fh,'>> FEC VENCIMIENTO DOC.   : [ To_Date('||NVL(szhFecVencimiento_EXT,' ')      ||','||sFormatoFecha||')]' );
    utl_file.Put_Line(fh,'>> MOD. VENTA         .   : [' || TO_CHAR(NVL(Reg_GA_Ventas.Cod_ModVenta,0)) || ']' );
    utl_file.Put_Line(fh,'>> NUMERO DE CUOTAS   .   : [' || TO_CHAR(NVL(lhNumCuotas,0))                || ']' );
    utl_file.fflush(fh);
    FA_INS_INTERFACT( lhNumTransaccion_EXT               ,
                      lhNumProceso_EXT                   ,
                      lhNumVenta_EXT                     ,
                      szhCodModGener_EXT                 ,
                      iDocumVenta                        ,
                      szhCodCaTribut_EXT                 ,
                      NULL                               ,
                      iEstInicProc                       ,
                      iEstProceso                        ,
                      szhFecVencimiento_EXT              ,
                      iEstadoRetorno                     ,
                      TO_CHAR(Reg_GA_Ventas.Cod_ModVenta),
                      TO_CHAR(lhNumCuotas)               ,
                      NULL                               ,
                      Reg_GA_Ventas.Tip_Foliacion        ,
                      Reg_GA_Ventas.Cod_TipDocum         );
    IF (iEstadoRetorno = 0) THEN
            RAISE ERROR_NUEVO_PL;
    END IF;
    /* SE actualiza la categoria impositiva del cliente para el tipo de documento */
    UPDATE FA_INTERFACT
       SET COD_CATIMPOSITIVA = ihCodCatImpos
    WHERE NUM_PROCESO = lhNumProceso_EXT;
    /******************************************************************************/
EXCEPTION
    WHEN utl_file.WRITE_ERROR THEN
        SET_ERROR('Error de Escritura LOG (F)(17)','95');
    WHEN utl_file.INTERNAL_ERROR THEN
        SET_ERROR('Error Interno LOG (G)(17)','96');
    WHEN ERROR_NUEVO_PL THEN
        SET_ERROR('ERROR INSERCION FA_INS_INTERFACT ','97');
    WHEN OTHERS THEN
        SET_ERROR('ERROR INESPERADO (17)','98');
END InsertaRegistroInterfaz;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/


BEGIN
    VP_PROC      := 'FA_PROC_PREBILLING_2 INI'   ;
    VP_TABLA     := '-ninguna-'                  ;
    VP_ACT       := 'N'                          ;
    VP_SQLCODE   :=  '0'                         ;
    VP_SQLERRM   := 'ERROR AL INICIO'            ;
    VP_ERROR     :=  '0'                         ;
    fallo                := FALSE;
    ProcesoCreado        := FALSE;
/* *********************** SELECCION DE PARAMETROS GENERALES Y DEL CLIENTE ****************** */
    SET_ERROR('INI FA_PROC_PREBILLING_2 '||PROG_VERSION,'ZZ');
    GetPath;
    IF (fallo = FALSE) THEN
        sControlPath := '0';
        fh := utl_file.fopen(szhPathDir,szhNombArchLog,szhModoOpen);
        sControlPath := '1';
        DEBUG;
        utl_file.Put_Line(fh,NVL(Asteriscos,' ') || ' FA_PROC_PREBILLIN_2 VERSION: ' || NVL(PROG_VERSION,' ') || '           *');
        utl_file.Put_Line(fh,NVL(Raya2,' '));
        utl_file.Put_Line(fh,'** FECHA DE EJECUCION: ' || TO_CHAR(SYSDATE, '[DD/MON/YYYY][hh24:mi:ss]') || '  *');
        utl_file.Put_Line(fh,'');
        utl_file.fflush(fh);
/************************ SELECCION DE PARAMETROS GENERALES Y DEL CLIENTE ******************/
        ValidacionPrevia;       /* PARAMETROS DE ENTRADA ('*_EXT') */
        IF (fallo = FALSE) THEN         /* FA_DATOSGENER */
            GetVariablesGlobales;
            IF (fallo = FALSE) THEN      /* FAD_PARAMETROS */
                GetCatImposCli;
                utl_file.Put_Line(fh,'>> Cat.Imp.Cliente        : [' || TO_CHAR(NVL(ihCodCatimpos,0)) || ']' );
                /* Obtiene el numero d decimales par el redondeo */
                iNumDecimales :=GE_PAC_GENERAL.PARAM_GENERAL('NUM_DECIMAL_FACT');
                /* Obtiene el formato de fecha para PL */
                sFormatoFecha :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
/**************************** SELECCION DE CARACTERISTICAS DE LA VENTA ***********************/
                IF (fallo = FALSE) THEN         /* GA_VENTAS */
                    GetRegVentas;
                    utl_file.Put_Line(fh,'>> Num Venta              : [' || TO_CHAR(NVL(Reg_GA_Ventas.Num_Venta,0))                            || ']' );
                    utl_file.Put_Line(fh,'>> Cod Producto           : [' || TO_CHAR(NVL(Reg_GA_Ventas.Cod_Producto,0))                         || ']' );
                    utl_file.Put_Line(fh,'>> Cod Oficina            : [' || NVL(Reg_GA_Ventas.Cod_Oficina,' ')                                 || ']' );
                    utl_file.Put_Line(fh,'>> Fec Venta              : [' || NVL(TO_CHAR(Reg_GA_Ventas.Fec_Venta,'DD/MON/YYYY hh24:mi:ss'),' ') || ']' );
                    utl_file.Put_Line(fh,'>> Cod Ciudad             : [' || NVL(Reg_GA_Ventas.Cod_Ciudad,' ')                                  || ']' );
                    utl_file.Put_Line(fh,'>> Cod Provincia          : [' || NVL(Reg_GA_Ventas.Cod_Provincia,' ')                               || ']' );
                    utl_file.Put_Line(fh,'>> Cod Region             : [' || NVL(Reg_GA_Ventas.Cod_Region,' ')                                  || ']' );
                    utl_file.Put_Line(fh,'>> Cod TipContrato        : [' || NVL(Reg_GA_Ventas.Cod_TipContrato,' ')                             || ']' );
                    utl_file.Put_Line(fh,'>> Num Contrato           : [' || NVL(Reg_GA_Ventas.Num_Contrato,' ')                                || ']' );
                    utl_file.Put_Line(fh,'>> Mod.Venta              : [' || TO_CHAR(NVL(Reg_GA_Ventas.Cod_ModVenta,0))                         || ']' );
                    utl_file.Put_Line(fh,'>> Cod.Cuota para Nzmero  : [' || NVL(Reg_GA_Ventas.Cod_Cuota,' ')                                   || ']' );
                    utl_file.Put_Line(fh,'>> Tipo Foliacion         : [' || NVL(Reg_GA_Ventas.Tip_Foliacion,' ')                               || ']' );
                    utl_file.Put_Line(fh,'>> Num Cuotas             : [' || TO_CHAR(NVL(lhNumCuotas,0))                                        || ']' );
                    utl_file.fflush(fh);
                    IF (fallo = FALSE) THEN         /* GE_LETRAS */
                        GetLetra;
                        utl_file.Put_Line(fh,'>> LETRA                  : [' || NVL(szhLetra,' ') || ']' );
                        utl_file.fflush(fh);
                        IF (fallo = FALSE) THEN         /* AL_DOCUM_SUCURSAL */
                            GetCentroEmisor;
                            utl_file.Put_Line(fh,'>> COD_CENTREMI           : [' || TO_CHAR(NVL(ihCodCentrEmi,0)) || ']' );
                            utl_file.fflush(fh);
                            IF (fallo = FALSE) THEN         /* GE_ZONACIUDAD */
                                GetZonaImpositivacliente;
/*************************** MANEJO DE LATab_FA_PRESUPUESTOS CARACTERISTICAS DEL PROCESO *********************/
                                utl_file.Put_Line(fh,'>> COD_ZONAIMPO           : [' || TO_CHAR(NVL(ihCodZonaImpo,0)) || ']' );
                                IF (fallo = FALSE) THEN         /* DUAL */
                                    GetNumSecuencia;
                                    utl_file.Put_Line(fh,'>> NUM_SECUENCIA          : [' || TO_CHAR(NVL(lhNumSecuenci,0)) || ']' );
                                    IF (fallo = FALSE) THEN         /* FA_PROCESOS  PROC_EJEC */
                                        InsertaRegFaProcesos;
/**************************** SELECCION DE LOS CARGOS A FACTURAR ****************************/
                                        IF (fallo = FALSE) THEN         /* GE_CARGOS --> ArregloCargos */
                                            CargaCargos;
                                            IF (fallo = FALSE) THEN         /* ArregloCargos --> ArregloPrefactura <n>*/
                                                CargaCargosPrefactura;
/**************************** SELECCION DE LOS DESCUENTOS A APLICAR ************************/
                                                IF (fallo = FALSE) THEN         /* ArregloCargos,ArregloPrefactura <n>  --> ArregloPrefactura <n+m>, ArregloVentaDtos */
                                                    CargaDesctosPrefactura;
/**************************** SELECCION DE LOS IMPUESTOS A APLICAR ************************/
                                                    IF (fallo = FALSE) THEN         /* Calculo de impuestos  */
                                                        VP_PROC      := 'FA_PAC_IMPTOS.CARGAIMPTOS';
                                                        FA_PAC_IMPTOS.CARGAIMPTOS(Tab_FA_PRESUPUESTO,
                                                                                  ihCodZonaImpo,
                                                                                  ihCodCatImpos,
                                                                                  VP_PROC,
                                                                                  VP_TABLA,
                                                                                  VP_ACT,
                                                                                  VP_SQLCODE,
                                                                                  VP_SQLERRM,
                                                                                  VP_ERROR);
                                                        IF (NVL(VP_ERROR,'-1') = '0') THEN /* retorno de la funcion */
                                                            InsertaRegFaPresupuesto;
                                                            IF (fallo = FALSE) THEN         /* --> GE_CARGOS.NUM_FACTURA */
                                                                UpdateCargos;
                                                                IF (fallo = FALSE) THEN         /* --> FA_INTERFACT */
                                                                    InsertaRegistroInterfaz;
                                                                    IF (fallo = FALSE) THEN         /* FA_PROCESOS  PROC_OK */
                                                                        CambiaEstadoProceso(PROC_OK);   /* COMMIT INTERNO */
                                                                        VP_PROC      := 'FA_PROC_PREBILLING_2 OK';
                                                                        VP_TABLA     := '-ninguna-';
                                                                    ELSE
                                                                        RAISE FALLO_ACCESO_A_LA_BASE;
                                                                    END IF;
                                                                ELSE
                                                                    RAISE FALLO_ACCESO_A_LA_BASE;
                                                                END IF;
                                                            ELSE
                                                                RAISE FALLO_ACCESO_A_LA_BASE;
                                                            END IF;
                                                        ELSE
                                                            SET_ERROR('ERROR EN FA_PAC_IMPTOS.CARGAIMPTOS','E1');
                                                            RAISE FALLO_ACCESO_A_LA_BASE;
                                                        END IF;
                                                    ELSE
                                                        RAISE FALLO_ACCESO_A_LA_BASE;
                                                    END IF;
                                                ELSE
                                                    RAISE FALLO_ACCESO_A_LA_BASE;
                                                END IF;
                                            ELSE
                                                RAISE FALLO_ACCESO_A_LA_BASE;
                                            END IF;
                                        ELSE
                                            RAISE FALLO_ACCESO_A_LA_BASE;
                                        END IF;
                                    ELSE
                                        RAISE FALLO_ACCESO_A_LA_BASE;
                                    END IF;
                                ELSE
                                    RAISE FALLO_ACCESO_A_LA_BASE;
                                END IF;
                            ELSE
                                RAISE FALLO_ACCESO_A_LA_BASE;
                            END IF;
                        ELSE
                            RAISE FALLO_ACCESO_A_LA_BASE;
                        END IF;
                    ELSE
                        RAISE FALLO_ACCESO_A_LA_BASE;
                    END IF;
                ELSE
                    RAISE FALLO_ACCESO_A_LA_BASE;
                END IF;
            ELSE
                RAISE FALLO_ACCESO_A_LA_BASE;
            END IF;
        ELSE
            RAISE FALLO_ACCESO_A_LA_BASE;
        END IF;
    ELSE
        RAISE FALLO_PATH;
    END IF;
    SET_ERROR('FIN FA_PROC_PREBILLING_2 VP_ERROR=['||VP_ERROR||']','ZZ');
    utl_file.fclose(fh);
EXCEPTION
    WHEN FALLO_ACCESO_A_LA_BASE THEN
        BEGIN
            UTL_FILE.Put_Line(fh,' Fallo en el proceso       : ' || NVL(VP_PROC,' ')    );
            UTL_FILE.Put_Line(fh,' Realizando la accion      : ' || NVL(VP_ACT,' ')     );
            UTL_FILE.Put_Line(fh,' Sobre la Tabla            : ' || NVL(VP_TABLA,' ')   );
            UTL_FILE.Put_Line(fh,' SQLCODE                   : ' || NVL(VP_SQLCODE,' ') );
            UTL_FILE.Put_Line(fh,' SQLERRM                   : ' || NVL(VP_SQLERRM,' ') );
            UTL_FILE.Put_Line(fh,' ERROR                     : ' || NVL(VP_ERROR,' ')   );
            UTL_FILE.Put_Line(fh,' DETALLE ERROR             : ' || NVL(VP_DESCERR,' ') );
            UTL_FILE.Put_Line(fh,'Parametros :');
            UTL_FILE.Put_Line(fh,'CodCliente     = ['|| TO_CHAR(lhCodCliente_EXT)      ||']');
            UTL_FILE.Put_Line(fh,'NumVenta       = ['|| TO_CHAR(lhNumVenta_EXT)       ||']');
            UTL_FILE.Put_Line(fh,'NumTransaccion = ['|| TO_CHAR(lhNumTransaccion_EXT) ||']');
            UTL_FILE.Put_Line(fh,'NumProceso     = ['|| lhNumProceso_EXT               ||']');
            UTL_FILE.Put_Line(fh,'CodModGener    = ['|| szhCodModGener_EXT             ||']');
            UTL_FILE.Put_Line(fh,'CodCaTribut    = ['|| szhCodCaTribut_EXT             ||']');
            UTL_FILE.Put_Line(fh,'FecVencimiento = ['|| szhFecVencimiento_EXT          ||']');
            UTL_FILE.Put_Line(fh,NVL(Raya2,' '));
            UTL_FILE.Put_Line(fh,'* Termino Controlado del Proceso Por Excepcion **');
            UTL_FILE.put_line(fh,NVL(Raya2,' '));
            UTL_FILE.fflush(fh);
            IF (ProcesoCreado = TRUE) THEN
                CambiaEstadoProceso(PROC_ERR);  /* COMMIT INTERNO */
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    UTL_FILE.Put_Line(fh,'ERROR EXCEPTION WHEN FALLO_ACCESO_A_LA_BASE RET=['||VP_ERROR||'] SQLERR=' || TO_CHAR(SQLCODE) ||' en FA_PROC_PREBILLING_2 [' || SQLERRM || ']' );
                    UTL_FILE.fflush(fh);
                    UTL_FILE.fclose(fh);
                END;
        END;
    WHEN UTL_FILE.INVALID_PATH THEN
        BEGIN
            SET_ERROR('Path Invalida (A)','01');
            UTL_FILE.fclose(fh);
        END;
    WHEN UTL_FILE.INVALID_MODE THEN
        BEGIN
            SET_ERROR('Modo Invalido (B)','02');
            UTL_FILE.fclose(fh);
        END;
    WHEN UTL_FILE.INVALID_OPERATION THEN
        BEGIN
            IF (sControlPath = '0') THEN
                SET_ERROR('Error al tratar de abrir archivo log, path = (' || szhPathDir || ')','03');
            ELSE
                SET_ERROR('Operacion Invalida (C)','04');
            END IF;
            UTL_FILE.fclose(fh);
        END;
    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
        BEGIN
            SET_ERROR('FileHandle Invalido (D)','05');
            UTL_FILE.fclose(fh);
        END;
    WHEN UTL_FILE.READ_ERROR THEN
        BEGIN
            SET_ERROR('Error de Lectura (E)','06');
            UTL_FILE.fclose(fh);
        END;
    WHEN UTL_FILE.WRITE_ERROR THEN
        BEGIN
            SET_ERROR('Error de Escritura LOG (F)','07');
            UTL_FILE.fclose(fh);
        END;
    WHEN UTL_FILE.INTERNAL_ERROR THEN
        BEGIN
            SET_ERROR('Error Interno LOG (G)','08');
            UTL_FILE.fclose(fh);
        END;
    WHEN FALLO_PATH THEN
        BEGIN
            SET_ERROR('Error Registro en FAD_PARAMETRO (Reg.3) - Path  (S)','09');
            UTL_FILE.fclose(fh);
        END;
    WHEN OTHERS THEN
        BEGIN
            SET_ERROR('INESPERADO FA_PROC_PREBILLING_2','XX');
            VP_SQLERRM := SUBSTR(SQLERRM,1,70);
            UTL_FILE.Put_Line(fh,NVL(Raya2,' '));
            UTL_FILE.Put_Line(fh,' Se produjo un error inesperado  : ' || TO_CHAR(SQLCODE) );
            UTL_FILE.Put_Line(fh,NVL(VP_SQLERRM,' '));
            UTL_FILE.Put_Line(fh,NVL(Raya2,' '));
            UTL_FILE.fflush(fh);
        EXCEPTION
            WHEN OTHERS THEN
            BEGIN
                UTL_FILE.Put_Line(fh,'ERROR EXCEPTION WHEN OTHERS VP_ERROR=['||VP_ERROR||'] SQLERR=' || TO_CHAR(SQLCODE) ||' en FA_PROC_PREBILLING_2 [' || SQLERRM || ']' );
                UTL_FILE.fflush(fh);
                UTL_FILE.fclose(fh);
            END;
        END;
END FA_PROC_PREBILLING_2;
/
SHOW ERRORS
