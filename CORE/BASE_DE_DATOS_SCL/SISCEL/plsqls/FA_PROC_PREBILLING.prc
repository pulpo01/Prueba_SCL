CREATE OR REPLACE PROCEDURE        FA_PROC_PREBILLING
 ( lhCodCliente_EXT
IN NUMBER   ,
                                                 lhNumVenta_EXT
IN NUMBER   ,
                                                 lhNumTransaccion_EXT
IN NUMBER   ,
                                                 lhNumProceso_EXT
IN NUMBER   ,
                                                 VP_PROC                IN OUT VARCHAR2,        /*En que parte del proceso estoy*/
                                                 VP_TABLA                IN OUT VARCHAR2,
/*En que tabla estoy trabajando*/
                                                 VP_ACT                        IN OUT VARCHAR2,        /*Que accion estoy ejecutando*/
                                                 VP_SQLCODE                IN OUT VARCHAR2,        /*sqlcode*/
                                                 VP_SQLERRM                IN OUT VARCHAR2,        /*sqlerrm*/
                                                 VP_ERROR                IN OUT VARCHAR2,        /*Error enviando por nosotros u otro.*/
 DebugPantalla                IN BOOLEAN  := FALSE    /* TRUE INDICA ERROR A PANTALLA */
) IS
        /* FLUJO DEL PROGRAMA */
        fallo                        BOOLEAN := FALSE;
        ProcesoCreado                BOOLEAN := FALSE;
        szError                        VARCHAR2(2) := '?';
        VP_DESCERR                VARCHAR2(100) := NULL;
        szhUser                        GE_CARGOS.NOM_USUARORA%TYPE;
        /* #DEFINE's */
        PROC_EJEC                NUMBER(1) := 0;
        PROC_OK                        NUMBER(1) := 1;
        PROC_ERR                NUMBER(1) := 2;
        /* EXCEPCION */
        FALLO_ACCESO_A_LA_BASE         EXCEPTION;
        /* (B) */
        szhCodDollar                 FA_DATOSGENER.COD_DOLLAR%TYPE;
        szhCodUF                 FA_DATOSGENER.COD_UF%TYPE;
        szhCodPeso                 FA_DATOSGENER.COD_PESO%TYPE;
        ihCodIva                 FA_DATOSGENER.COD_IVA%TYPE;
        fhPctIva                 FA_DATOSGENER.PCT_IVA%TYPE;
        szhCodMoneFact                 FA_DATOSGENER.COD_MONEFACT%TYPE;
        lhCodAbonoCel                 FA_DATOSGENER.COD_ABONOCEL%TYPE;
        lhCodAbonoBeep                 FA_DATOSGENER.COD_ABONOBEEP%TYPE;
        lhCodAbonoFinCel         FA_DATOSGENER.COD_ABONOFINCEL%TYPE;
        lhCodAbonoFinBeep         FA_DATOSGENER.COD_ABONOFINBEEP%TYPE;
        lhCodRecargo                 FA_DATOSGENER.COD_RECARGO%TYPE;
        ihCodContado                 FA_DATOSGENER.COD_CONTADO%TYPE;
        ihCodFactura                 FA_DATOSGENER.COD_FACTURA%TYPE;
        lhCodConcIva                 FA_DATOSGENER.COD_CONCIVA%TYPE;
        ihCodPLanTarif                 FA_DATOSGENER.COD_PLANTARIF%TYPE;
        /* (C) */
        Reg_GA_Ventas                GA_VENTAS%ROWTYPE;
        /* (D) */
        lhNumSecuenci           NUMBER := 0;
        /* (E) */
        ihCodCatImpos                GE_DATOSGENER.COD_CATIMPOS%TYPE;
        ihCodZonaImpo                GE_ZONACIUDAD.COD_ZONAIMPO%TYPE;
        /* (F) */
        szhLetra                GE_LETRAS.LETRA%TYPE ;
        /* (G) */
        ihCodCentrEmi                AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE;
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
                                                CodModuloFC
  FA_CONCEPTOS.COD_MODULO%TYPE,
                                                CodMonedaFC
  FA_CONCEPTOS.COD_MONEDA%TYPE,
                                                CodTipConceFC
  FA_CONCEPTOS.COD_TIPCONCE%TYPE,
                                                IndActivoFC
  FA_CONCEPTOS.IND_ACTIVO%TYPE,
                                                CodProductoFC
  FA_CONCEPTOS.COD_PRODUCTO%TYPE,
                                                CodTipDescFC          FA_CONCEPTOS.COD_TIPDESCU%TYPE,
                                                Mi_RowID          ROWID
                                                );
        TYPE TipTab_GE_CARGOS   IS TABLE  OF  TipRegCargosConceptos INDEX BY  BINARY_INTEGER;
        Tab_CARGA_CARGOS        TipTab_GE_CARGOS;
        /* (I) */
        TYPE TipTab_FA_PRESUPUESTO IS TABLE  OF  FA_PRESUPUESTO%ROWTYPE        INDEX BY  BINARY_INTEGER;
        Tab_FA_PRESUPUESTO  TipTab_FA_PRESUPUESTO;
        /* (J) */
        szhCodModulo                FA_CONCEPTOS.COD_MODULO%TYPE        ;
        szhCodMoneda                FA_CONCEPTOS.COD_MONEDA%TYPE        ;
        ihCodTipConce                FA_CONCEPTOS.COD_TIPCONCE%TYPE        ;
        ihIndActivo                FA_CONCEPTOS.IND_ACTIVO%TYPE        ;
        ihCodProducto                FA_CONCEPTOS.COD_PRODUCTO%TYPE        ;
        szhCodDescu                FA_CONCEPTOS.COD_TIPDESCU%TYPE        ;
        /* (K) */
        dhCambioOrigen                 GE_CONVERSION.CAMBIO%TYPE         ;
        dhCambioDestino                GE_CONVERSION.CAMBIO%TYPE         ;
        dhImporte                 GE_CONVERSION.CAMBIO%TYPE         ;
        dhFCambio                GE_CONVERSION.CAMBIO%TYPE := 1  ;
        /* (L) */
        TYPE TipReg_Columnas IS RECORD (ihCodConcepto_COL GE_CARGOS.COD_CONCEPTO%TYPE, ihNumOcurrencias_COL NUMBER(6));
        TYPE TipTab_Columnas IS TABLE OF  TipReg_Columnas INDEX BY  BINARY_INTEGER;
        Tab_Columnas  TipTab_Columnas;
        /* (M) */
        TYPE TipTab_VENTADTO IS TABLE OF  VE_VENTADTOS%ROWTYPE INDEX BY  BINARY_INTEGER;
        Tab_VENTADTO  TipTab_VENTADTO;
        /* (N) */
        ihCodGrpServi        FA_GRPSERCONC.COD_GRPSERVI%TYPE;
        /* (O) */
        fhPorcImpuesto         GE_IMPUESTOS.PRC_IMPUESTO%TYPE;
        FIN_CARGO BINARY_INTEGER := 0;
        FIN_DSCTO BINARY_INTEGER := 0;
        /* (P) */
        szhPathDir           VARCHAR2 (128) := '/samba/ready';
         /* reemplazar por $VAR_AMBIENTE ??? */
        szhNombArchLog         VARCHAR2 (128) := 'Prebilling_Contado_' || to_char(lhNumVenta_EXT) || '_' || to_char(lhCodCliente_EXT) || '.log' ;
        szhModoOpen        VARCHAR2 (1)   := 'w';
                                /* escritura */
        fh  utl_file.FILE_TYPE ;
        /* (Q) */
        Raya1                VARCHAR2(50) := '--------------------------------------------';
        Raya2                VARCHAR2(50) := '=================================================';
        Asteriscos      VARCHAR2(50) := '***********************';
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (-2) * SETEA EL CODIGO DE ERROR EN LAS VARIABLES DE RETORNO
                                 */
/* ********************************************************************************************* */
PROCEDURE SET_ERROR(DESCRIPCION IN VARCHAR2) IS
BEGIN
        IF VP_DESCERR IS NULL THEN
                VP_SQLCODE := TO_CHAR(SQLCODE);
                VP_SQLERRM := SUBSTR(SQLERRM,1,50);
                VP_DESCERR := DESCRIPCION;
                VP_ERROR   := '1';
        END IF;
        fallo := TRUE ;
END SET_ERROR;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (-1) * DEBUGGER EN TIEMPO DE EJECUCION DEL PROGRAMA
                                 */
/* ********************************************************************************************* */
PROCEDURE DEBUG IS
BEGIN
        utl_file.put_line (fh,Raya2);
        utl_file.put_line (fh,Asteriscos || ' ' || VP_PROC || '*');
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
END DEBUG;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (0) * VALIDACION DE LOS PARAMETROS DE ENTRADA
                                 */
/* ********************************************************************************************* */
PROCEDURE ValidacionPrevia IS
PARAMETRO_NULO EXCEPTION;
BEGIN
        VP_PROC         := 'ValidacionPrevia        '        ;
        VP_TABLA         := 'GA_VENTAS'                        ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        utl_file.put_line (fh,'>> Cliente                : [' || lhCodCliente_EXT     || ']' );
        utl_file.put_line (fh,'>> Transaccion            : [' || lhNumTransaccion_EXT || ']' );
        utl_file.put_line (fh,'>> Venta                  : [' || lhNumVenta_EXT       || ']' );
        utl_file.put_line (fh,'>> Proceso                : [' || lhNumProceso_EXT     || ']' );
        IF ( lhCodCliente_EXT IS NULL OR lhNumTransaccion_EXT IS NULL OR
             lhNumVenta_EXT IS NULL   OR lhNumProceso_EXT IS NULL ) THEN
                RAISE PARAMETRO_NULO;
        END IF;
        SELECT NOM_USUAR_VTA
          INTO szhUser
          FROM GA_VENTAS
         WHERE NUM_VENTA = lhNumVenta_EXT;
        utl_file.put_line (fh,'>> Usuario                : [' || szhUser || ']' );
EXCEPTION
        WHEN PARAMETRO_NULO THEN
                SET_ERROR('>> SE INGRESO PARAMETRO NULO (0)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND : szhUser from GA_VENTAS (0)');
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (0)');
END ValidacionPrevia;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (1) * OBTIENE VARIABLES GLOBALES DESDE FA_DATOSGENER
                                 */
/* ********************************************************************************************* */
PROCEDURE GetVariablesGlobales IS
BEGIN
        VP_PROC         := 'GetVariablesGlobales    '        ;
        VP_TABLA         := 'FA_DATOSGENER'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT        COD_DOLLAR                ,
                COD_UF                        ,
                COD_PESO                ,
                COD_IVA                        ,
                PCT_IVA                        ,
                COD_MONEFACT                ,
                COD_ABONOCEL                ,
                COD_ABONOBEEP                ,
                COD_ABONOFINCEL                ,
                COD_ABONOFINBEEP        ,
                COD_RECARGO                ,
                COD_CONTADO                ,
                COD_FACTURA                ,
                COD_CONCIVA                ,
                COD_PLANTARIF
          INTO        szhCodDollar
        ,
                szhCodUf
        ,
                szhCodPeso
        ,
                ihCodIVA
        ,
                fhPctIva
        ,
                szhCodMoneFact
        ,
                lhCodAbonoCel
        ,
                lhCodAbonoBeep
        ,
                lhCodAbonoFinCel
,
                lhCodAbonoFinBeep
,
                lhCodRecargo
        ,
                ihCodContado
        ,
                ihCodFactura
        ,
                lhCodConcIva
        ,
                ihCodPlantarif
          FROM        FA_DATOSGENER                ;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (1)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (1)');
END GetVariablesGlobales;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (2) * OBTIENE LA CATEGORIA IMPOSITIVA DEL CLIENTE DADO // fx(lhCOD_CLIENTE)--> iCOD_CATIMPOS  */
/* ********************************************************************************************* */
PROCEDURE GetCatImposCli IS
BEGIN
        VP_PROC         := 'GetCatImposCli          '        ;
        VP_TABLA         := 'GE_CATIMPCLIENTES'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT COD_CATIMPOS
          INTO ihCodCatimpos
          FROM GE_CATIMPCLIENTES
         WHERE COD_CLIENTE = lhCodCliente_EXT
           AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA ;
        utl_file.put_line (fh,'>> Cat.Imp.Cliente        : [' || ihCodCatimpos || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (2)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (2)');
END GetCatImposCli;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (3) * RECUPERA TODA LA INFORMACION DE GA_VENTAS  // fx(lhNroVenta)--> (*)
                 */
/* ********************************************************************************************* */
PROCEDURE GetRegVentas IS
BEGIN
        VP_PROC         := 'GetRegVentas            '        ;
        VP_TABLA         := 'GA_VENTAS'                        ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT  *
          INTO Reg_GA_Ventas
          FROM  GA_VENTAS
         WHERE  NUM_VENTA = lhNumVenta_EXT        ;
        utl_file.put_line (fh,'>> Num Venta              : [' || Reg_GA_Ventas.Num_Venta       || ']' );
        utl_file.put_line (fh,'>> Cod Producto           : [' || Reg_GA_Ventas.Cod_Producto    || ']' );
        utl_file.put_line (fh,'>> Cod Oficina            : [' || Reg_GA_Ventas.Cod_Oficina     || ']' );
        utl_file.put_line (fh,'>> Fec Venta              : [' || Reg_GA_Ventas.Fec_Venta       || ']' );
        utl_file.put_line (fh,'>> Cod Ciudad             : [' || Reg_GA_Ventas.Cod_Ciudad      || ']' );
        utl_file.put_line (fh,'>> Cod Provincia          : [' || Reg_GA_Ventas.Cod_Provincia   || ']' );
        utl_file.put_line (fh,'>> Cod Region             : [' || Reg_GA_Ventas.Cod_Region      || ']' );
        utl_file.put_line (fh,'>> Cod TipContrato        : [' || Reg_GA_Ventas.Cod_TipContrato || ']' );
        utl_file.put_line (fh,'>> Num Contrato           : [' || Reg_GA_Ventas.Num_Contrato    || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (3)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (3)');
END GetRegVentas;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (4) * OBTIENE LETRA FROM GE_LETRAS // fx(ihCOD_CATIMPOS,ihCOD_TIPDOCUM)--> szhLETRA
 */
/* ********************************************************************************************* */
PROCEDURE GetLetra IS
BEGIN
        VP_PROC         := 'GetLetra                '        ;
        VP_TABLA         := 'GE_LETRAS'                        ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT LETRA
          INTO szhLetra
          FROM GE_LETRAS
         WHERE COD_TIPDOCUM = ihCodContado
           AND COD_CATIMPOS = ihCodCatImpos;
        utl_file.put_line (fh,'>> LETRA                  : [' || szhLetra || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (4)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (4)');
END GetLetra;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (5) * OBTIENE CENTRO EMISOR //  fx(szhCOD_OFICINA,ihCOD_TIPDOCUM)--> ihCOD_CENTREMI
 */
/* ********************************************************************************************* */
PROCEDURE GetCentroEmisor IS
BEGIN
        VP_PROC         := 'GetCentroEmisor         '        ;
        VP_TABLA         := 'AL_DOCUM_SUCURSAL'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT COD_CENTREMI
          INTO ihCodCentrEmi
          FROM AL_DOCUM_SUCURSAL
         WHERE COD_OFICINA = Reg_GA_Ventas.COD_OFICINA
           AND COD_TIPDOCUM = ihCodContado;
        utl_file.put_line (fh,'>> COD_CENTREMI           : [' || ihCodCentrEmi || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (5)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (5)');
END GetCentroEmisor;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (6)* OBTENCION DE LA ZONA IMPOSITIVA                                                         */
/* ********************************************************************************************* */
PROCEDURE GetZonaImpositiva IS
BEGIN
        VP_PROC         := 'GetZonaImpositiva       '        ;
        VP_TABLA         := 'GE_ZONACIUDAD'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT COD_ZONAIMPO
          INTO ihCodZonaImpo
          FROM GE_ZONACIUDAD
         WHERE COD_REGION    = Reg_GA_Ventas.COD_REGION
           AND COD_PROVINCIA = Reg_GA_Ventas.COD_PROVINCIA
           AND COD_CIUDAD    = Reg_GA_Ventas.COD_CIUDAD
           AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
        utl_file.put_line (fh,'>> COD_ZONAIMPO           : [' || ihCodZonaImpo || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (6)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (6)');
END GetZonaImpositiva;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (7) * OBTIENE INFORMACION DESDE EL DUAL
                                                 */
/* ********************************************************************************************* */
PROCEDURE GetNumSecuencia IS
BEGIN
        VP_PROC         := 'GetNumSecuencia         '        ;
        VP_TABLA         := 'DUAL'                        ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT FA_SEQ_CONTADO.NEXTVAL
          INTO lhNumSecuenci
          FROM DUAL;
        utl_file.put_line (fh,'>> NUM_SECUENCIA          : [' || lhNumSecuenci || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (7)');
END GetNumSecuencia;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (8)* INSERTA UN NUEVO REGISTRO EN LA FA_PROCESOS                                                 */
/* ********************************************************************************************* */
PROCEDURE InsertaRegFaProcesos IS
BEGIN
        VP_PROC         := 'InsertaRegFaProcesos    '        ;
        VP_TABLA         := 'FA_PROCESOS'                ;
        VP_ACT                := 'I'                                ;
        DEBUG;
        INSERT INTO FA_PROCESOS
                    (
                        NUM_PROCESO                ,
                        COD_TIPDOCUM                ,
                        COD_VENDEDOR_AGENTE        ,
                        COD_CENTREMI                ,
                        FEC_EFECTIVIDAD                ,
                        NOM_USUARORA                ,
                        LETRAAG                        ,
                        NUM_SECUAG                ,
                        COD_TIPDOCNOT                ,
                        COD_VENDEDOR_AGENTENOT        ,
                        LETRANOT                ,
                        COD_CENTRNOT                ,
                        NUM_SECUNOT                ,
                        IND_ESTADO                ,
                        COD_CICLFACT
                    )
        VALUES
                    (
                        lhNumProceso_EXT                        ,
                        ihCodContado                                ,
                        Reg_GA_Ventas.COD_VENDEDOR_AGENTE        ,
                        ihCodCentremi                                ,
                        SYSDATE                                        ,
                        szhUser                                        ,
                        szhLetra                                ,
                        lhNumSecuenci                                ,
                        0                                        ,
                        0                                        ,
                        NULL                                        ,
                        0                                        ,
                        0                                        ,
                        PROC_EJEC                                ,
                        NULL
                    );
        COMMIT;
        ProcesoCreado := TRUE;
 /*Se cres proceso en ejecucisn */
        utl_file.put_line (fh,'>> NUM_PROCESO            : [' || lhNumProceso_EXT                   || ']' );
        utl_file.put_line (fh,'>> COD_TIPDOCUM           : [' || ihCodContado                           || ']' );
        utl_file.put_line (fh,'>> COD_VENDEDOR_AGENTE    : [' || Reg_GA_Ventas.COD_VENDEDOR_AGENTE || ']' );
        utl_file.put_line (fh,'>> COD_CENTREMI           : [' || ihCodCentremi                           || ']' );
        utl_file.put_line (fh,'>> FEC_EFECTIVIDAD        : [' || SYSDATE                           || ']' );
        utl_file.put_line (fh,'>> NOM_USUARORA           : [' || szhUser                           || ']' );
        utl_file.put_line (fh,'>> LETRAAG                : [' || szhLetra                           || ']' );
        utl_file.put_line (fh,'>> NUM_SECUAG             : [' || lhNumSecuenci                           || ']' );
        utl_file.put_line (fh,'>> COD_TIPDOCNOT          : [' || 0                                   || ']' );
        utl_file.put_line (fh,'>> COD_VENDEDOR_AGENTENOT : [' || 0                                   || ']' );
        utl_file.put_line (fh,'>> LETRANOT               : [' || NULL                                   || ']' );
        utl_file.put_line (fh,'>> COD_CENTRNOT           : [' || 0                                   || ']' );
        utl_file.put_line (fh,'>> NUM_SECUNOT            : [' || 0                                   || ']' );
        utl_file.put_line (fh,'>> IND_ESTADO             : [' || PROC_EJEC                           || ']' );
        utl_file.put_line (fh,'>> COD_CICLFACT           : [' || NULL                                   || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN DUP_VAL_ON_INDEX THEN
                SET_ERROR('>> INDICE DUPLICADO (8)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (8)');
END InsertaRegFaProcesos;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (9-A)* RECUPERA DATOS DE LA FA_CONCEPTOS
                         */
/* ********************************************************************************************* */
FUNCTION fbGetFaConceptos(ihCodConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE ) RETURN BOOLEAN IS
ERROR_IND_ACTIVO  EXCEPTION ;
BEGIN
        VP_PROC         := 'fbGetFaConceptos        '        ;
        VP_TABLA         := 'FA_CONCEPTOS'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT COD_MODULO, COD_MONEDA, COD_TIPCONCE, IND_ACTIVO, COD_PRODUCTO, COD_TIPDESCU
          INTO szhCodModulo,szhCodMoneda,ihCodTipConce,ihIndActivo, ihCodProducto, szhCodDescu
          FROM FA_CONCEPTOS
         WHERE COD_CONCEPTO = ihCodConcepto;
        IF ihIndActivo = 0 THEN
                RAISE ERROR_IND_ACTIVO;
        ELSE
                RETURN TRUE;
        END IF;
        utl_file.put_line (fh,'>> COD_MODULO             : [' || szhCodModulo  || ']' );
        utl_file.put_line (fh,'>> COD_MONEDA             : [' || szhCodMoneda  || ']' );
        utl_file.put_line (fh,'>> COD_TIPCONCE           : [' || ihCodTipConce || ']' );
        utl_file.put_line (fh,'>> IND_ACTIVO             : [' || ihIndActivo   || ']' );
        utl_file.put_line (fh,'>> COD_PRODUCTO           : [' || ihCodProducto || ']' );
        utl_file.put_line (fh,'>> COD_TIPDESCU           : [' || szhCodDescu   || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
        BEGIN
                SET_ERROR('Error de Escritura (F)');
                RETURN FALSE;
        END;
        WHEN UTL_FILE.INTERNAL_ERROR THEN
        BEGIN
                SET_ERROR('Error Interno (?) (G)');
                RETURN FALSE;
        END;
        WHEN NO_DATA_FOUND THEN
        BEGIN
                szError := 'A';
                SET_ERROR('>> NO DATA FOUND (A) (9a)');
                RETURN FALSE;
        END;
        WHEN ERROR_IND_ACTIVO  THEN
        BEGIN
                SET_ERROR('>> ERROR IND ACTIVO = 0 (9a)');
                szError := 'B';
                RETURN FALSE;
        END;
        WHEN OTHERS THEN
        BEGIN
                SET_ERROR('>> ERROR INESPERADO (9a)');
                szError := '?';
                RETURN FALSE;
        END;
END fbGetFaConceptos;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (9)* CARGA CARGOS DEL CLIENTE
                         */
/* ********************************************************************************************* */
PROCEDURE CargaCargos IS
        STATUS                  BOOLEAN := TRUE ;
        CONCEPTO_NO_ENCONTRADO        EXCEPTION;
        CONCEPTO_ES_IMPUESTO        EXCEPTION;
        CONCEPTO_ES_DESCUENTO        EXCEPTION;
        NO_EXISTEN_CARGOS        EXCEPTION;
        NUM_ELEMENTOS                NUMBER(10):=0;
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
                ROWID
          FROM GE_CARGOS
         WHERE NUM_VENTA = lhNumVenta_EXT
           AND NUM_TRANSACCION = lhNumTransaccion_EXT
           AND NUM_FACTURA = 0
      ORDER BY NUM_CARGO;
i BINARY_INTEGER := 0;
BEGIN
        VP_PROC         := 'CargaCargos             '        ;
        VP_TABLA         := 'GE_CARGOS'                        ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        /* VALIDA SI TIENE AL MENOS UN CARGO RECUPERADO */
        SELECT COUNT(*)
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
                        Tab_CARGA_CARGOS(i).CodModuloFC       := szhCodModulo ;
                /* Variables globales que vienen de fbGetFaConceptos */
                        Tab_CARGA_CARGOS(i).CodMonedaFC       := szhCodMoneda ;
                        Tab_CARGA_CARGOS(i).CodTipConceFC     := ihCodTipConce ;
                        Tab_CARGA_CARGOS(i).IndActivoFC       := ihIndActivo ;
                        Tab_CARGA_CARGOS(i).CodProductoFC     := ihCodProducto ;
                        Tab_CARGA_CARGOS(i).CodTipDescFC      := szhCodDescu ;
                        Tab_CARGA_CARGOS(i).Mi_RowID          := rRegCargo.ROWID ;
                        utl_file.put_line (fh,'>> NUM_CARGO              : [' || Tab_CARGA_CARGOS(i).NUM_CARGO          || ']' );
                        utl_file.put_line (fh,'>> COD_PRODUCTO           : [' || Tab_CARGA_CARGOS(i).COD_PRODUCTO       || ']' );
                        utl_file.put_line (fh,'>> COD_CONCEPTO           : [' || Tab_CARGA_CARGOS(i).COD_CONCEPTO       || ']' );
                        utl_file.put_line (fh,'>> FEC_ALTA               : [' || Tab_CARGA_CARGOS(i).FEC_ALTA           || ']' );
                        utl_file.put_line (fh,'>> IMP_CARGO              : [' || Tab_CARGA_CARGOS(i).IMP_CARGO          || ']' );
                        utl_file.put_line (fh,'>> COD_MONEDA             : [' || Tab_CARGA_CARGOS(i).COD_MONEDA         || ']' );
                        utl_file.put_line (fh,'>> NUM_UNIDADES           : [' || Tab_CARGA_CARGOS(i).NUM_UNIDADES       || ']' );
                        utl_file.put_line (fh,'>> IND_FACTUR             : [' || Tab_CARGA_CARGOS(i).IND_FACTUR         || ']' );
                        utl_file.put_line (fh,'>> NUM_ABONADO            : [' || Tab_CARGA_CARGOS(i).NUM_ABONADO        || ']' );
                        utl_file.put_line (fh,'>> NUM_TERMINAL           : [' || Tab_CARGA_CARGOS(i).NUM_TERMINAL       || ']' );
                        utl_file.put_line (fh,'>> COD_CONCEPTO_DTO       : [' || Tab_CARGA_CARGOS(i).COD_CONCEPTO_DTO   || ']' );
                        utl_file.put_line (fh,'>> VAL_DTO                : [' || Tab_CARGA_CARGOS(i).VAL_DTO            || ']' );
                        utl_file.put_line (fh,'>> TIP_DTO                : [' || Tab_CARGA_CARGOS(i).TIP_DTO            || ']' );
                        utl_file.put_line (fh,'>> IND_SUPERTEL           : [' || Tab_CARGA_CARGOS(i).IND_SUPERTEL       || ']' );
                END IF;
        END LOOP;
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN NO_EXISTEN_CARGOS THEN
                SET_ERROR('>> NO EXISTEN CARGOS (9)');
        WHEN CONCEPTO_NO_ENCONTRADO THEN
                SET_ERROR('>> CONCEPTO NO ENCONTRADO (9)');
        WHEN CONCEPTO_ES_IMPUESTO THEN
                SET_ERROR('>> CONCEPTO ES IMPUESTO (9)');
        WHEN CONCEPTO_ES_DESCUENTO THEN
                SET_ERROR('>> CONCEPTO ES DESCUENTO (9)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (9)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (9)');
END CargaCargos;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10-A-1)* CONVERSION DE MONEDAS SEGUN GENFA
                         */
/* ********************************************************************************************* */
FUNCTION fbConvierteMonedas(
                                szhFecha IN GE_CONVERSION.FEC_DESDE%TYPE ,
                                szhCodMonedaO IN  GE_CONVERSION.COD_MONEDA%TYPE ,
                                szhCodMonedaD IN  GE_CONVERSION.COD_MONEDA%TYPE
                            ) RETURN BOOLEAN IS
BEGIN
        VP_PROC         := 'fbConvierteMonedas      '        ;
        VP_TABLA         := 'GE_CONVERSION'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        dhCambioDestino := 0.0;
        dhCambioOrigen  := 0.0;
         SELECT  CAMBIO
           INTO  dhCambioOrigen
           FROM  GE_CONVERSION
          WHERE  COD_MONEDA = szhCodMonedaO
            AND  szhFecha BETWEEN FEC_DESDE AND FEC_HASTA;
         SELECT  CAMBIO
           INTO  dhCambioDestino
           FROM  GE_CONVERSION
          WHERE  COD_MONEDA = szhCodMonedaD
            AND  szhFecha BETWEEN FEC_DESDE AND FEC_HASTA;
        dhFCambio :=(dhCambioOrigen / dhCambioDestino);
   /*Global*/
        RETURN TRUE;
EXCEPTION
        WHEN ZERO_DIVIDE THEN
        BEGIN
                SET_ERROR('>> DIVISION POR CERO (10a1)');
                szError := '0' ;
                RETURN FALSE;
        END;
        WHEN NO_DATA_FOUND THEN
        BEGIN
                SET_ERROR('>> NO DATA FOUND (10a1)');
                szError := 'A' ;
                RETURN FALSE;
        END;
        WHEN OTHERS THEN
        BEGIN
                SET_ERROR('>> ERROR INESPERADO (10a1)');
                szError := '?' ;
                RETURN FALSE;
        END;
END fbConvierteMonedas;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10-A)* CALCULO DEL IMPORTE FACTURABLE                                                                 */
/* ********************************************************************************************* */
FUNCTION fdCalcImporteFact( UNIDADES IN NUMBER , MONEDA IN VARCHAR2, CONCEPTO IN FA_PRESUPUESTO.IMP_CONCEPTO%TYPE ) RETURN NUMBER IS
dhImpFacturable         FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;
status BOOLEAN := TRUE;
ERROR_CONVERSION_MONEDA EXCEPTION;
BEGIN
        VP_PROC         := 'fdCalcImporteFact       '        ;
        VP_TABLA         := '-ninguna-'                        ;
        VP_ACT                := 'N'                                ;
        DEBUG;
        dhFCambio := 1;
        IF  MONEDA != szhCodMoneFact THEN
                status := fbConvierteMonedas ( SYSDATE, MONEDA, szhCodMoneFact );
 /* dhFCambio != 1 */
                IF status = FALSE THEN
                   RAISE ERROR_CONVERSION_MONEDA ;
                END IF;
        END IF;
        dhImpFacturable := ROUND (CONCEPTO * UNIDADES * dhFCambio);
        RETURN dhImpFacturable;
EXCEPTION
        WHEN ERROR_CONVERSION_MONEDA THEN
                SET_ERROR('>> ERROR CONVERSION MONEDA (10a)');
                RETURN -1;
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (10a)');
                RETURN -1;
END fdCalcImporteFact;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10-B)* OBTIENE LA COLUMNA CORRESPONDIENTE AL CONCEPTO BUSCADO                                         */
/* ********************************************************************************************* */
FUNCTION fGetColumna (ihConceptoBuscado IN GE_CARGOS.COD_CONCEPTO%TYPE) RETURN NUMBER IS
i BINARY_INTEGER := 1 ;
ENCONTRADO BOOLEAN := FALSE ;
Columna NUMBER := 1;
BEGIN
        VP_PROC         := 'fGetColumna             '        ;
        VP_TABLA         := 'Tab_Columnas'                ;
        VP_ACT                := 'U'                                ;
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
                SET_ERROR('>> ERROR INESPERADO (10b)');
                RETURN -1;
END fGetColumna;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10)* CARGA LOS CARGOS EXISTENTES EN LA PREFACTURA (TAB_FA_PRESUPUESTO)                         */
/* ********************************************************************************************* */
PROCEDURE CargaCargosPrefactura IS
i BINARY_INTEGER;
ERROR_CALC_IMPORTE_FACT EXCEPTION;
ERROR_GET_COLUMNA EXCEPTION;
BEGIN
        VP_PROC         := 'CargaCargosPrefactura   '        ;
        VP_TABLA         := 'Tab_FA_PRESUPUESTO'                ;
        VP_ACT                := 'I'                                ;
        DEBUG;
        FOR i IN Tab_CARGA_CARGOS.FIRST .. Tab_CARGA_CARGOS.LAST LOOP
                /* Valores Externos (Recibidos por parametros desde Visual Basic )*/
                Tab_FA_PRESUPUESTO(i).NUM_PROCESO        := lhNumProceso_EXT        ;
                Tab_FA_PRESUPUESTO(i).COD_CLIENTE        := lhCodCliente_EXT        ;
                Tab_FA_PRESUPUESTO(i).NUM_VENTA                := lhNumVenta_EXT        ;
                Tab_FA_PRESUPUESTO(i).NUM_TRANSACCION        := lhNumTransaccion_EXT        ;
                /* Valores Constantes */
                Tab_FA_PRESUPUESTO(i).IND_ALTA                := 1                        ;
                Tab_FA_PRESUPUESTO(i).IND_CUOTA                := 0                        ;
                Tab_FA_PRESUPUESTO(i).NUM_CUOTAS        := 0                        ;
                Tab_FA_PRESUPUESTO(i).ORD_CUOTA                := 0                        ;
                Tab_FA_PRESUPUESTO(i).COD_PORTADOR        := 0                        ;
                Tab_FA_PRESUPUESTO(i).COD_CICLFACT        := NULL                        ;
                /* Valores Variables Independientes del FLAG */
                Tab_FA_PRESUPUESTO(i).FEC_EFECTIVIDAD        := SYSDATE                 ;
                Tab_FA_PRESUPUESTO(i).FEC_VENTA                := SYSDATE                 ;
                /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
                Tab_FA_PRESUPUESTO(i).COD_PRODUCTO        := Tab_CARGA_CARGOS(i).CodProductoFC        ;
                Tab_FA_PRESUPUESTO(i).COD_MONEDA        := Tab_CARGA_CARGOS(i).COD_MONEDA        ;
                Tab_FA_PRESUPUESTO(i).FEC_VALOR                := Tab_CARGA_CARGOS(i).FEC_ALTA                ;
                Tab_FA_PRESUPUESTO(i).COD_PLANCOM        := Tab_CARGA_CARGOS(i).COD_PLANCOM        ;
                Tab_FA_PRESUPUESTO(i).NUM_GUIA                := Tab_CARGA_CARGOS(i).NUM_GUIA                ;
                Tab_FA_PRESUPUESTO(i).VAL_DTO                := Tab_CARGA_CARGOS(i).VAL_DTO                ;
                Tab_FA_PRESUPUESTO(i).TIP_DTO                := Tab_CARGA_CARGOS(i).TIP_DTO                ;
                Tab_FA_PRESUPUESTO(i).MES_GARANTIA        := Tab_CARGA_CARGOS(i).MES_GARANTIA        ;
                Tab_FA_PRESUPUESTO(i).IND_SUPERTEL        := Tab_CARGA_CARGOS(i).IND_SUPERTEL        ;
                Tab_FA_PRESUPUESTO(i).NUM_PAQUETE        := Tab_CARGA_CARGOS(i).NUM_PAQUETE        ;
                Tab_FA_PRESUPUESTO(i).NUM_UNIDADES        := Tab_CARGA_CARGOS(i).NUM_UNIDADES        ;
                Tab_FA_PRESUPUESTO(i).IND_FACTUR        := Tab_CARGA_CARGOS(i).IND_FACTUR         ;
                Tab_FA_PRESUPUESTO(i).NUM_ABONADO        := Tab_CARGA_CARGOS(i).NUM_ABONADO        ;
                Tab_FA_PRESUPUESTO(i).NUM_TERMINAL        := Tab_CARGA_CARGOS(i).NUM_TERMINAL        ;
                Tab_FA_PRESUPUESTO(i).CAP_CODE                := Tab_CARGA_CARGOS(i).CAP_CODE                ;
                Tab_FA_PRESUPUESTO(i).NUM_SERIEMEC        := Tab_CARGA_CARGOS(i).NUM_SERIEMEC        ;
                Tab_FA_PRESUPUESTO(i).NUM_SERIELE        := Tab_CARGA_CARGOS(i).NUM_SERIE        ;
                /* Valores Variables Independientes del FLAG y Dependientes de la Tabla de Ventas */
                Tab_FA_PRESUPUESTO(i).COD_REGION        := Reg_GA_Ventas.COD_REGION                ;
                Tab_FA_PRESUPUESTO(i).COD_PROVINCIA        := Reg_GA_Ventas.COD_PROVINCIA                ;
                Tab_FA_PRESUPUESTO(i).COD_CIUDAD        := Reg_GA_Ventas.COD_CIUDAD                ;
                /* Valores Variables Independientes del FLAG y GLOBALES */
                Tab_FA_PRESUPUESTO(i).COD_MODULO        := Tab_CARGA_CARGOS(i).CodModuloFC        ;
                Tab_FA_PRESUPUESTO(i).COD_CATIMPOS        := ihCodCatImpos                        ;
                /* Valores Variables Dependientes del FLAG */
                Tab_FA_PRESUPUESTO(i).COD_CONCEPTO        := Tab_CARGA_CARGOS(i).COD_CONCEPTO        ;
                Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO        := Tab_CARGA_CARGOS(i).IMP_CARGO         ;
                Tab_FA_PRESUPUESTO(i).IMP_MONTOBASE        := 0                                        ;
                Tab_FA_PRESUPUESTO(i).IND_ESTADO        := 2                                        ;
                Tab_FA_PRESUPUESTO(i).COD_TIPCONCE        := 3                                        ;
                Tab_FA_PRESUPUESTO(i).COD_CONCEREL        := 0                                        ;
                Tab_FA_PRESUPUESTO(i).COLUMNA_REL        := 0                                        ;
                Tab_FA_PRESUPUESTO(i).PRC_IMPUESTO        := NULL                                        ;
                IF ihCodCatImpos = 1 THEN
                        Tab_FA_PRESUPUESTO(i).FLAG_IMPUES        := 1 ;
 /* COMO CLIENTE ESTA AFECTO A IMPUESTO */
                ELSE
                        Tab_FA_PRESUPUESTO(i).FLAG_IMPUES        := 0 ;
 /* COMO CLIENTE ESTA EXENTO DE IMPUESTO */
                END IF;
                IF (Tab_CARGA_CARGOS(i).COD_CONCEPTO_DTO IS NULL OR Tab_CARGA_CARGOS(i).VAL_DTO IS NULL
                   OR Tab_CARGA_CARGOS(i).TIP_DTO IS NULL)  THEN
                        Tab_FA_PRESUPUESTO(i).FLAG_DTO        := 0                                         ;
                ELSE
                        Tab_FA_PRESUPUESTO(i).FLAG_DTO        := 1                                         ;
                END IF;
                Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE := fdCalcImporteFact(Tab_FA_PRESUPUESTO(i).NUM_UNIDADES,
                                                                          Tab_FA_PRESUPUESTO(i).COD_MONEDA,
                                                                          Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO);
                IF Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE = -1 THEN /* funcion anterior salio con error*/
                        RAISE ERROR_CALC_IMPORTE_FACT;
                END IF;
                Tab_FA_PRESUPUESTO(i).COLUMNA        := fGetColumna(Tab_FA_PRESUPUESTO(i).COD_CONCEPTO);
                IF Tab_FA_PRESUPUESTO(i).COLUMNA = -1  THEN
                        RAISE ERROR_GET_COLUMNA;
                END IF;
                utl_file.put_line (fh,'>> COD_MONEDA             : [' || Tab_FA_PRESUPUESTO(i).COD_MONEDA     || ']' );
                utl_file.put_line (fh,'>> COD_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(i).COD_CONCEPTO   || ']' );
                utl_file.put_line (fh,'>> IMP_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO   || ']' );
                utl_file.put_line (fh,'>> COLUMNA                : [' || Tab_FA_PRESUPUESTO(i).COLUMNA              || ']' );
                utl_file.put_line (fh,'>> IMP_FACTURABLE         : [' || Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE || ']' );
                utl_file.put_line (fh,'>> COD_PRODUCTO           : [' || Tab_FA_PRESUPUESTO(i).COD_PRODUCTO   || ']' );
                utl_file.put_line (fh,'>> COLUMNA_REL            : [' || Tab_FA_PRESUPUESTO(i).COLUMNA_REL    || ']' );
                utl_file.put_line (fh,'>> COD_DESCUENTO          : [' || szhCodDescu || ']' );
                utl_file.put_line (fh,'>> PRC_IMPUESTO           : [' || Tab_FA_PRESUPUESTO(i).PRC_IMPUESTO   || ']' );
        END LOOP;
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN ERROR_CALC_IMPORTE_FACT THEN
                SET_ERROR('>> ERROR CALCULO IMPORTE FACTURABLE (10)');
        WHEN ERROR_GET_COLUMNA THEN
                SET_ERROR('>> ERROR AL OBTENER COLUMNA (10)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (10)');
END CargaCargosPrefactura;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (11-A)* INSERTA DATOS DESDE EL ARREGLO A LA TABLA DE VENTAS DTO                                 */
/* ********************************************************************************************* */
PROCEDURE InsertaVentaDtos IS
i BINARY_INTEGER := 0;
BEGIN
        VP_PROC         := 'InsertaVentaDtos        '        ;
        VP_TABLA         := 'VE_VENTADTOS'                ;
        VP_ACT                := 'I'                                ;
        DEBUG;
        FOR i IN Tab_VENTADTO.FIRST .. Tab_VENTADTO.LAST LOOP
                INSERT INTO VE_VENTADTOS
                                (
                                        NUM_VENTA     ,
                                        NUM_ITEM      ,
                                        COD_PRODUCTO  ,
                                        IMP_VENTA     ,
                                        IND_DTO       ,
                                        VAL_DTO       ,
                                        NUM_UNIDADES  ,
                                        IND_ACEPTA    ,
                                        COD_CTODTO    ,
                                        COD_ARTICULO
                                )
                VALUES
                                (
                                        Tab_VENTADTO(i).NUM_VENTA     ,
                                        Tab_VENTADTO(i).NUM_ITEM      ,
                                        Tab_VENTADTO(i).COD_PRODUCTO  ,
                                        Tab_VENTADTO(i).IMP_VENTA     ,
                                        Tab_VENTADTO(i).IND_DTO       ,
                                        Tab_VENTADTO(i).VAL_DTO       ,
                                        Tab_VENTADTO(i).NUM_UNIDADES  ,
                                        Tab_VENTADTO(i).IND_ACEPTA    ,
                                        Tab_VENTADTO(i).COD_CTODTO    ,
                                        Tab_VENTADTO(i).COD_ARTICULO
                                );
                utl_file.put_line (fh,'>> NUM_VENTA              : [' || Tab_VENTADTO(i).NUM_VENTA    || ']' );
                utl_file.put_line (fh,'>> NUM_ITEM               : [' || Tab_VENTADTO(i).NUM_ITEM     || ']' );
                utl_file.put_line (fh,'>> COD_PRODUCTO           : [' || Tab_VENTADTO(i).COD_PRODUCTO || ']' );
                utl_file.put_line (fh,'>> IMP_VENTA              : [' || Tab_VENTADTO(i).IMP_VENTA    || ']' );
                utl_file.put_line (fh,'>> IND_DTO                : [' || Tab_VENTADTO(i).IND_DTO      || ']' );
                utl_file.put_line (fh,'>> VAL_DTO                : [' || Tab_VENTADTO(i).VAL_DTO      || ']' );
                utl_file.put_line (fh,'>> NUM_UNIDADES           : [' || Tab_VENTADTO(i).NUM_UNIDADES || ']' );
                utl_file.put_line (fh,'>> IND_ACEPTA             : [' || Tab_VENTADTO(i).IND_ACEPTA   || ']' );
                utl_file.put_line (fh,'>> COD_CTODTO             : [' || Tab_VENTADTO(i).COD_CTODTO   || ']' );
                utl_file.put_line (fh,'>> COD_ARTICULO           : [' || Tab_VENTADTO(i).COD_ARTICULO || ']' );
        END LOOP;
        /* COMMIT;
 */
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND ??? (11a)');
        WHEN DUP_VAL_ON_INDEX THEN
                SET_ERROR('>> INDICE DUPLICADO (11a)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (11a)');
END InsertaVentaDtos;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (11)* CARGA LOS DESCUENTOS EXISTENTES EN LA PREFACTURA (TAB_FA_PRESUPUESTO)                         */
/* ********************************************************************************************* */
PROCEDURE CargaDesctosPrefactura IS
i BINARY_INTEGER;
j BINARY_INTEGER;
l BINARY_INTEGER;
status BOOLEAN := TRUE;
FIN_CARGO BINARY_INTEGER := Tab_FA_PRESUPUESTO.LAST;
ERROR_CALC_IMPORTE_FACT EXCEPTION;
ERROR_GET_FA_CONCEPTO EXCEPTION;
ERROR_GET_COLUMNA EXCEPTION;
BEGIN
        VP_PROC         := 'CargaDesctosPrefactura  '        ;
        VP_TABLA         := 'Tab_FA_PRESUPUESTO'                ;
        VP_ACT                := 'I'                                ;
        DEBUG;
        FOR i IN Tab_FA_PRESUPUESTO.FIRST .. FIN_CARGO LOOP
                IF Tab_FA_PRESUPUESTO(i).FLAG_DTO = 1 THEN
                        j := Tab_FA_PRESUPUESTO.LAST + 1;
  /* Agrego al final de la Tab_FA_PRESUPUESTO */
                        /* Valores Externos (Recibidos por parametros desde Visual Basic )*/
                        Tab_FA_PRESUPUESTO(j).NUM_PROCESO        := lhNumProceso_EXT        ;
                        Tab_FA_PRESUPUESTO(j).COD_CLIENTE        := lhCodCliente_EXT        ;
                        Tab_FA_PRESUPUESTO(j).NUM_VENTA                := lhNumVenta_EXT        ;
                        Tab_FA_PRESUPUESTO(j).NUM_TRANSACCION        := lhNumTransaccion_EXT        ;
                        /* Valores Constantes */
                        Tab_FA_PRESUPUESTO(j).IND_ALTA                := 1                        ;
                        Tab_FA_PRESUPUESTO(j).IND_CUOTA                := 0                        ;
                        Tab_FA_PRESUPUESTO(j).NUM_CUOTAS        := 0                        ;
                        Tab_FA_PRESUPUESTO(j).ORD_CUOTA                := 0                        ;
                        Tab_FA_PRESUPUESTO(j).COD_PORTADOR        := 0                        ;
                        Tab_FA_PRESUPUESTO(j).COD_CICLFACT        := NULL                        ;
                        /* Valores Variables Independientes del FLAG */
                        Tab_FA_PRESUPUESTO(j).FEC_EFECTIVIDAD        := SYSDATE                 ;
                        Tab_FA_PRESUPUESTO(j).FEC_VENTA                := SYSDATE                 ;
                        /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
                        Tab_FA_PRESUPUESTO(j).COD_MONEDA        := Tab_FA_PRESUPUESTO(i).COD_MONEDA        ;
                        Tab_FA_PRESUPUESTO(j).FEC_VALOR                := Tab_FA_PRESUPUESTO(i).FEC_VALOR        ;
                        Tab_FA_PRESUPUESTO(j).COD_PLANCOM        := Tab_FA_PRESUPUESTO(i).COD_PLANCOM        ;
                        Tab_FA_PRESUPUESTO(j).NUM_GUIA                := Tab_FA_PRESUPUESTO(i).NUM_GUIA        ;
                        Tab_FA_PRESUPUESTO(j).VAL_DTO                := 0                                        ;
                        Tab_FA_PRESUPUESTO(j).TIP_DTO                := 0                                        ;
                        Tab_FA_PRESUPUESTO(j).MES_GARANTIA        := Tab_FA_PRESUPUESTO(i).MES_GARANTIA        ;
                        Tab_FA_PRESUPUESTO(j).IND_SUPERTEL        := Tab_FA_PRESUPUESTO(i).IND_SUPERTEL        ;
                        Tab_FA_PRESUPUESTO(j).NUM_PAQUETE        := Tab_FA_PRESUPUESTO(i).NUM_PAQUETE        ;
                        Tab_FA_PRESUPUESTO(j).NUM_UNIDADES        := Tab_FA_PRESUPUESTO(i).NUM_UNIDADES        ;
                        Tab_FA_PRESUPUESTO(j).IND_FACTUR        := Tab_FA_PRESUPUESTO(i).IND_FACTUR         ;
                        Tab_FA_PRESUPUESTO(j).NUM_ABONADO        := Tab_FA_PRESUPUESTO(i).NUM_ABONADO        ;
                        Tab_FA_PRESUPUESTO(j).NUM_TERMINAL        := Tab_FA_PRESUPUESTO(i).NUM_TERMINAL        ;
                        Tab_FA_PRESUPUESTO(j).CAP_CODE                := Tab_FA_PRESUPUESTO(i).CAP_CODE        ;
                        Tab_FA_PRESUPUESTO(j).NUM_SERIEMEC        := Tab_FA_PRESUPUESTO(i).NUM_SERIEMEC        ;
                        Tab_FA_PRESUPUESTO(j).NUM_SERIELE        := Tab_FA_PRESUPUESTO(i).NUM_SERIELE        ;
                        /* Valores Variables Independientes del FLAG y Dependientes de la Tabla de Ventas */
                        Tab_FA_PRESUPUESTO(j).COD_REGION        := Reg_GA_Ventas.COD_REGION                ;
                        Tab_FA_PRESUPUESTO(j).COD_PROVINCIA        := Reg_GA_Ventas.COD_PROVINCIA                ;
                        Tab_FA_PRESUPUESTO(j).COD_CIUDAD        := Reg_GA_Ventas.COD_CIUDAD                ;
                        /* Valores Variables Independientes del FLAG y GLOBALES */
                        Tab_FA_PRESUPUESTO(j).COD_CATIMPOS        := ihCodCatImpos                        ;
                        /* Valores Variables Dependientes del FLAG */
                        Tab_FA_PRESUPUESTO(j).COD_CONCEPTO         := Tab_CARGA_CARGOS(i).COD_CONCEPTO_DTO        ;
                        Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE         := Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE        ;
                        Tab_FA_PRESUPUESTO(j).IND_ESTADO        := 2                                        ;
                        Tab_FA_PRESUPUESTO(j).COD_TIPCONCE      := 2                                        ;
                        Tab_FA_PRESUPUESTO(j).COD_CONCEREL        := Tab_FA_PRESUPUESTO(i).COD_CONCEPTO        ;
                        Tab_FA_PRESUPUESTO(j).COLUMNA_REL       := Tab_FA_PRESUPUESTO(i).COLUMNA        ;
                        Tab_FA_PRESUPUESTO(j).FLAG_IMPUES       := 1                                        ;
                        Tab_FA_PRESUPUESTO(j).FLAG_DTO               := 0                                        ;
                        Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO      := NULL                                        ;
                        IF Tab_FA_PRESUPUESTO(i).TIP_DTO = 0 THEN
                                Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO  := Tab_FA_PRESUPUESTO(i).VAL_DTO * -1 ;
                        ELSE
                                Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO  :=  (Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO *
                                                                        (Tab_CARGA_CARGOS(i).VAL_DTO/100)) * -1 ;
                        END IF;
                        Tab_FA_PRESUPUESTO(j).COLUMNA        := fGetColumna(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
                        IF Tab_FA_PRESUPUESTO(j).COLUMNA = -1  THEN
                                RAISE ERROR_GET_COLUMNA;
                        END IF;
                        Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE := fdCalcImporteFact(
                                                                        Tab_FA_PRESUPUESTO(j).NUM_UNIDADES,
                                                                        Tab_FA_PRESUPUESTO(j).COD_MONEDA,
                                                                        Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO );
                        IF (Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE = -1) THEN
                                RAISE ERROR_CALC_IMPORTE_FACT ;
                        END IF;
                        status := fbGetFaConceptos(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
                        IF status = FALSE THEN
                                RAISE ERROR_GET_FA_CONCEPTO;
                        END IF;
                        IF ((status = TRUE) AND (szhCodDescu = 'A')) THEN
                                IF Tab_VENTADTO.COUNT = 0 THEN
                                        l := 1;
                                ELSE
                                        l := Tab_VENTADTO.LAST + 1 ;
                                END IF;
                                Tab_VENTADTO(l).NUM_VENTA        := lhNumVenta_EXT                         ;
                                Tab_VENTADTO(l).NUM_ITEM        := Tab_CARGA_CARGOS(i).NUM_CARGO         ;
                                Tab_VENTADTO(l).COD_PRODUCTO        := ihCodProducto                         ;
                                Tab_VENTADTO(l).IMP_VENTA        := Tab_CARGA_CARGOS(i).IMP_CARGO         ;
                                Tab_VENTADTO(l).IND_DTO                := Tab_CARGA_CARGOS(i).TIP_DTO                 ;
                                Tab_VENTADTO(l).VAL_DTO                := Tab_CARGA_CARGOS(i).VAL_DTO                 ;
                                Tab_VENTADTO(l).NUM_UNIDADES        := Tab_FA_PRESUPUESTO(j).NUM_UNIDADES        ;
                                Tab_VENTADTO(l).IND_ACEPTA        := 0                                         ;
                                Tab_VENTADTO(l).COD_CTODTO        := Tab_FA_PRESUPUESTO(j).COD_CONCEPTO         ;
                                Tab_VENTADTO(l).COD_ARTICULO        := NULL                                 ;
                        END IF;
                        Tab_FA_PRESUPUESTO(j).COD_PRODUCTO        := ihCodProducto                        ;
                        Tab_FA_PRESUPUESTO(j).COD_MODULO        := szhCodModulo                                ;
                        utl_file.put_line (fh,'>> COD_MONEDA             : [' || Tab_FA_PRESUPUESTO(i).COD_MONEDA     || ']' );
                        utl_file.put_line (fh,'>> COD_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(j).COD_CONCEPTO   || ']' );
                        utl_file.put_line (fh,'>> IMP_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO   || ']' );
                        utl_file.put_line (fh,'>> COLUMNA                : [' || Tab_FA_PRESUPUESTO(j).COLUMNA              || ']' );
                        utl_file.put_line (fh,'>> IMP_FACTURABLE         : [' || Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE || ']' );
                        utl_file.put_line (fh,'>> COD_PRODUCTO           : [' || Tab_FA_PRESUPUESTO(j).COD_PRODUCTO   || ']' );
                        utl_file.put_line (fh,'>> COLUMNA_REL            : [' || Tab_FA_PRESUPUESTO(j).COLUMNA_REL    || ']' );
                        utl_file.put_line (fh,'>> COD_DESCUENTO          : [' || szhCodDescu || ']' );
                        utl_file.put_line (fh,'>> PRC_IMPUESTO           : [' || Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO   || ']' );
                END IF;
        END LOOP;
        FIN_DSCTO := Tab_FA_PRESUPUESTO.LAST;
        IF Tab_VENTADTO.COUNT > 0 THEN        /*Si hay Datos en el arreglo los ingresa a la tabla correspondiente */
                InsertaVentaDtos;
        END IF;
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN ERROR_CALC_IMPORTE_FACT THEN
                SET_ERROR('>> ERROR CALCULO IMPORTE FACTURABLE (11)');
        WHEN ERROR_GET_FA_CONCEPTO THEN
                SET_ERROR('>> ERROR AL OBTENER CONCEPTOS (11)');
        WHEN ERROR_GET_COLUMNA THEN
                SET_ERROR('>> ERROR AL OBTENER COLUMNA (11)');
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO_DATA_FOUND ??? (11)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (11)');
END CargaDesctosPrefactura;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (12-A-1)* OBTENCION DEL CODIGO DE GRUPO DE SERVICIO                                                 */
/* ********************************************************************************************* */
FUNCTION fbGetCodGrpServicios (CodConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE ) RETURN BOOLEAN IS
BEGIN
        VP_PROC         := 'fbGetCodGrpServicios    '        ;
        VP_TABLA         := 'FA_GRPSERCONC'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT COD_GRPSERVI
          INTO ihCodGrpServi  /* Global */
          FROM FA_GRPSERCONC
         WHERE COD_CONCEPTO  = CodConcepto
           AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
        RETURN TRUE ;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (12a1)');
                RETURN FALSE ;
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (12a1)');
                RETURN FALSE ;
END fbGetCodGrpServicios;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (12-A-2)* RECUPERA PROCENTAJES DE IMPUESTO A APLICAR                                                 */
/* ********************************************************************************************* */
FUNCTION fbGetPrcImpuesto RETURN BOOLEAN IS
BEGIN
        VP_PROC         := 'fbGetPrcImpuesto        '        ;
        VP_TABLA         := 'GE_IMPUESTOS'                ;
        VP_ACT                := 'S'                                ;
        DEBUG;
        SELECT PRC_IMPUESTO
          INTO fhPorcImpuesto  /* Global */
          FROM GE_IMPUESTOS
         WHERE COD_CATIMPOS  = ihCodCatImpos
           AND COD_ZONAIMPO  = ihCodZonaImpo
           AND COD_TIPIMPUES = ihCodIva                        /* ihCodTipImpues */
           AND COD_GRPSERVI  = ihCodGrpServi                /* global */
           AND COD_CONCGENE  = lhCodConcIva                /* ihCodConcGene */
           AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
        RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND (12a2)');
                RETURN FALSE;
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (12a2)');
                RETURN FALSE;
END fbGetPrcImpuesto;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (12-A)* MODULO DE CALCULO DE IMPUESTOS                                                                 */
/* ********************************************************************************************* */
FUNCTION fdCalcImptos ( NUM_UNIDADES IN NUMBER, COD_MONEDA IN VARCHAR2,
                        IMP_CONCEPTO IN FA_PRESUPUESTO.IMP_CONCEPTO%TYPE,
                        COD_CONCEPTO IN FA_CONCEPTOS.COD_CONCEPTO%TYPE ) RETURN NUMBER IS
dhImpFacturable         FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;
status BOOLEAN := TRUE;
ERROR_CONVERSION_MONEDA EXCEPTION;
ERROR_GET_COD_GRP_SERVI EXCEPTION;
ERROR_GET_PRC_IMPUESTO  EXCEPTION;
BEGIN
        VP_PROC         := 'fdCalcImptos            '        ;
        VP_TABLA         := '-ninguna-'                        ;
        VP_ACT                := 'N'                                ;
        DEBUG;
        status := fbGetCodGrpServicios (COD_CONCEPTO);
 /* DEL IMPUESTO */
        IF status = FALSE THEN
                RAISE ERROR_GET_COD_GRP_SERVI;
        ELSE
                status := fbGetPrcImpuesto ;
         /* AFECTO O EXENTO */
                IF status = FALSE THEN
                        RAISE ERROR_GET_PRC_IMPUESTO;
                ELSE
                        dhFCambio := 1;
                        IF COD_MONEDA != szhCodMoneFact THEN
                                status := fbConvierteMonedas ( SYSDATE,COD_MONEDA, szhCodMoneFact );
 /* dhFCambio != 1 */
                                IF status = FALSE THEN
                                        RAISE ERROR_CONVERSION_MONEDA ;
                                END IF;
                        END IF;
                        dhImpFacturable := ROUND (IMP_CONCEPTO * NUM_UNIDADES * dhFCambio * (fhPorcImpuesto/100));
                END IF;
        END IF;
        RETURN dhImpFacturable;
EXCEPTION
        WHEN ERROR_CONVERSION_MONEDA THEN
                SET_ERROR('>> ERROR CONVERSION MONEDA (12a)');
                RETURN -1;
        WHEN ERROR_GET_COD_GRP_SERVI THEN
                SET_ERROR('>> ERROR AL OBTENER CODIGO GRUPO SERVICIO (12a)');
                RETURN -1;
        WHEN ERROR_GET_PRC_IMPUESTO THEN
                SET_ERROR('>> ERROR AL OBTENER EL PORCENTAJE DE IMPUESTO (12a)');
                RETURN -1;
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (12a)');
                RETURN -1;
END fdCalcImptos;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (12)* CARGA LOS IMPUESTOS EXISTENTES EN LA PREFACTURA (TAB_FA_PRESUPUESTO)                         */
/* ********************************************************************************************* */
PROCEDURE CargaImptosPrefactura IS
i BINARY_INTEGER;
j BINARY_INTEGER;
ERROR_CALC_IMPTOS EXCEPTION;
ERROR_GET_COLUMNA EXCEPTION;
BEGIN
        VP_PROC         := 'CargaImptosPrefactura   '        ;
        VP_TABLA         := 'Tab_FA_PRESUPUESTO'                ;
        VP_ACT                := 'I'                                ;
        DEBUG;
        FOR i IN Tab_FA_PRESUPUESTO.FIRST .. FIN_DSCTO LOOP
                j := Tab_FA_PRESUPUESTO.LAST + 1;
  /* Agrego al final de la Tab_FA_PRESUPUESTO */
                /* Valores Externos (Recibidos por parametros desde Visual Basic )*/
                Tab_FA_PRESUPUESTO(j).NUM_PROCESO        := lhNumProceso_EXT                        ;
                Tab_FA_PRESUPUESTO(j).COD_CLIENTE        := lhCodCliente_EXT                        ;
                Tab_FA_PRESUPUESTO(j).NUM_VENTA                := lhNumVenta_EXT                        ;
                Tab_FA_PRESUPUESTO(j).NUM_TRANSACCION        := lhNumTransaccion_EXT                        ;
                /* Valores Constantes */
                Tab_FA_PRESUPUESTO(j).IND_ALTA                := 1                                        ;
                Tab_FA_PRESUPUESTO(j).IND_CUOTA                := 0                                        ;
                Tab_FA_PRESUPUESTO(j).NUM_CUOTAS        := 0                                        ;
                Tab_FA_PRESUPUESTO(j).ORD_CUOTA                := 0                                        ;
                Tab_FA_PRESUPUESTO(j).COD_PORTADOR        := 0                                        ;
                Tab_FA_PRESUPUESTO(j).COD_CICLFACT        := NULL                                        ;
                /* Valores Variables Independientes del FLAG */
                Tab_FA_PRESUPUESTO(j).FEC_EFECTIVIDAD        := SYSDATE                                 ;
                Tab_FA_PRESUPUESTO(j).FEC_VENTA                := SYSDATE                                 ;
                Tab_FA_PRESUPUESTO(j).COD_PRODUCTO        := Tab_FA_PRESUPUESTO(i).COD_PRODUCTO        ;
                /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
                Tab_FA_PRESUPUESTO(j).COD_MONEDA        := Tab_FA_PRESUPUESTO(i).COD_MONEDA        ;
                Tab_FA_PRESUPUESTO(j).FEC_VALOR                := Tab_FA_PRESUPUESTO(i).FEC_VALOR        ;
                Tab_FA_PRESUPUESTO(j).COD_PLANCOM        := Tab_FA_PRESUPUESTO(i).COD_PLANCOM        ;
                Tab_FA_PRESUPUESTO(j).NUM_GUIA                := Tab_FA_PRESUPUESTO(i).NUM_GUIA        ;
                Tab_FA_PRESUPUESTO(j).VAL_DTO                := NULL                                        ;
                Tab_FA_PRESUPUESTO(j).TIP_DTO                := NULL                                        ;
                Tab_FA_PRESUPUESTO(j).MES_GARANTIA        := Tab_FA_PRESUPUESTO(i).MES_GARANTIA        ;
                Tab_FA_PRESUPUESTO(j).IND_SUPERTEL        := Tab_FA_PRESUPUESTO(i).IND_SUPERTEL        ;
                Tab_FA_PRESUPUESTO(j).NUM_PAQUETE        := Tab_FA_PRESUPUESTO(i).NUM_PAQUETE        ;
                Tab_FA_PRESUPUESTO(j).NUM_UNIDADES        := Tab_FA_PRESUPUESTO(i).NUM_UNIDADES        ;
                Tab_FA_PRESUPUESTO(j).IND_FACTUR        := Tab_FA_PRESUPUESTO(i).IND_FACTUR         ;
                Tab_FA_PRESUPUESTO(j).NUM_ABONADO        := Tab_FA_PRESUPUESTO(i).NUM_ABONADO        ;
                Tab_FA_PRESUPUESTO(j).NUM_TERMINAL        := Tab_FA_PRESUPUESTO(i).NUM_TERMINAL        ;
                Tab_FA_PRESUPUESTO(j).CAP_CODE                := Tab_FA_PRESUPUESTO(i).CAP_CODE        ;
                Tab_FA_PRESUPUESTO(j).NUM_SERIEMEC        := Tab_FA_PRESUPUESTO(i).NUM_SERIEMEC        ;
                Tab_FA_PRESUPUESTO(j).NUM_SERIELE        := Tab_FA_PRESUPUESTO(i).NUM_SERIELE        ;
                /* Valores Variables Independientes del FLAG y Dependientes de la Tabla de Ventas */
                Tab_FA_PRESUPUESTO(j).COD_REGION        := Reg_GA_Ventas.COD_REGION                ;
                Tab_FA_PRESUPUESTO(j).COD_PROVINCIA        := Reg_GA_Ventas.COD_PROVINCIA                ;
                Tab_FA_PRESUPUESTO(j).COD_CIUDAD        := Reg_GA_Ventas.COD_CIUDAD                ;
                /* Valores Variables Independientes del FLAG y GLOBALES */
                Tab_FA_PRESUPUESTO(j).COD_MODULO        := Tab_FA_PRESUPUESTO(i).COD_MODULO        ;
                Tab_FA_PRESUPUESTO(j).COD_CATIMPOS        := ihCodCatImpos                        ;
                /* Valores Variables Dependientes del FLAG */
                Tab_FA_PRESUPUESTO(j).COD_CONCEPTO         := lhCodConcIva                                        ;
                Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE         := Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE                ;
                Tab_FA_PRESUPUESTO(j).IND_ESTADO        := 0                                                ;
                Tab_FA_PRESUPUESTO(j).COD_TIPCONCE      := 1                                                ;
                Tab_FA_PRESUPUESTO(j).COD_CONCEREL        := Tab_FA_PRESUPUESTO(i).COD_CONCEPTO                ;
                Tab_FA_PRESUPUESTO(j).COLUMNA_REL       := Tab_FA_PRESUPUESTO(i).COLUMNA                ;
                Tab_FA_PRESUPUESTO(j).FLAG_IMPUES       := 0                                                ;
                Tab_FA_PRESUPUESTO(j).FLAG_DTO               := 0                                                ;
                Tab_FA_PRESUPUESTO(j).COLUMNA                := fGetColumna(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
                IF Tab_FA_PRESUPUESTO(j).COLUMNA = -1  THEN
                        RAISE ERROR_GET_COLUMNA;
                END IF;
                Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE        := fdCalcImptos(Tab_FA_PRESUPUESTO(i).NUM_UNIDADES,
                                                                        Tab_FA_PRESUPUESTO(i).COD_MONEDA,
                                                                        Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO,
                                                                        Tab_FA_PRESUPUESTO(J).COD_CONCEPTO);
                IF Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE = -1 THEN
                        RAISE ERROR_CALC_IMPTOS;
                END IF;
                Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO := fhPorcImpuesto;
                Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO := ROUND ((fhPorcImpuesto/100) * Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO);
                IF  Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO = 0 THEN
                        Tab_FA_PRESUPUESTO(i).FLAG_IMPUES  := 0        ;
 /* EL CONCEPTO (RELACIONADO) ESTA EXENTO  */
                ELSE
                        Tab_FA_PRESUPUESTO(i).FLAG_IMPUES  := 1        ;
 /* EL CONCEPTO (RELACIONADO) ESTA AFECTO  */
                END IF;
                utl_file.put_line (fh,'>> COD_MONEDA             : [' || Tab_FA_PRESUPUESTO(j).COD_MONEDA     || ']' );
                utl_file.put_line (fh,'>> COD_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(j).COD_CONCEPTO   || ']' );
                utl_file.put_line (fh,'>> IMP_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO   || ']' );
                utl_file.put_line (fh,'>> COLUMNA                : [' || Tab_FA_PRESUPUESTO(j).COLUMNA              || ']' );
                utl_file.put_line (fh,'>> IMP_FACTURABLE         : [' || Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE || ']' );
                utl_file.put_line (fh,'>> COD_PRODUCTO           : [' || Tab_FA_PRESUPUESTO(j).COD_PRODUCTO   || ']' );
                utl_file.put_line (fh,'>> COLUMNA_REL            : [' || Tab_FA_PRESUPUESTO(j).COLUMNA_REL    || ']' );
                utl_file.put_line (fh,'>> COD_DESCUENTO          : [' || szhCodDescu || ']' );
                utl_file.put_line (fh,'>> PRC_IMPUESTO           : [' || Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO   || ']' );
        END LOOP;
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN ERROR_CALC_IMPTOS THEN
                SET_ERROR('>> ERROR AL CALCULAR EL IMPUESTO (12)');
        WHEN ERROR_GET_COLUMNA THEN
                SET_ERROR('>> ERROR AL OBTENER LA COLUMNA (12)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (12)');
END CargaImptosPrefactura;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (13)* INSERTA UN GRUPO DE NUEVOS REGISTROS EN LA FA_PRESUPUESTO
                         */
/* ********************************************************************************************* */
PROCEDURE InsertaRegFaPresupuesto IS
i                          BINARY_INTEGER;
Separador         VARCHAR2(60);
BEGIN
        VP_PROC         := 'InsertaRegFaPresupuesto '        ;
        VP_TABLA         := 'FA_PRESUPUESTO'                ;
        VP_ACT                := 'I'                                ;
        DEBUG;
        FOR i IN Tab_FA_PRESUPUESTO.FIRST .. Tab_FA_PRESUPUESTO.LAST LOOP
            Separador := '(' || i || ')' || Raya1;
                utl_file.put_line (fh,separador);
                utl_file.put_line (fh,'>> COD_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(i).COD_CONCEPTO    || ']' );
                utl_file.put_line (fh,'>> COLUMNA                : [' || Tab_FA_PRESUPUESTO(i).COLUMNA         || ']' );
                utl_file.put_line (fh,'>> COD_PRODUCTO           : [' || Tab_FA_PRESUPUESTO(i).COD_PRODUCTO    || ']' );
                utl_file.put_line (fh,'>> COD_MONEDA             : [' || Tab_FA_PRESUPUESTO(i).COD_MONEDA      || ']' );
                utl_file.put_line (fh,'>> FEC_VALOR              : [' || Tab_FA_PRESUPUESTO(i).FEC_VALOR       || ']' );
                utl_file.put_line (fh,'>> FEC_EFECTIVIDAD        : [' || Tab_FA_PRESUPUESTO(i).FEC_EFECTIVIDAD || ']' );
                utl_file.put_line (fh,'>> IMP_CONCEPTO           : [' || Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO    || ']' );
                utl_file.put_line (fh,'>> IMP_FACTURABLE         : [' || Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE  || ']' );
                utl_file.put_line (fh,'>> COD_MODULO             : [' || Tab_FA_PRESUPUESTO(i).COD_MODULO      || ']' );
                utl_file.put_line (fh,'>> FEC_VENTA              : [' || Tab_FA_PRESUPUESTO(i).FEC_VENTA       || ']' );
                utl_file.put_line (fh,'>> COD_TIPCONCE           : [' || Tab_FA_PRESUPUESTO(i).COD_TIPCONCE    || ']' );
                utl_file.put_line (fh,'>> NUM_UNIDADES           : [' || Tab_FA_PRESUPUESTO(i).NUM_UNIDADES    || ']' );
                utl_file.put_line (fh,'>> COD_CONCEREL           : [' || Tab_FA_PRESUPUESTO(i).COD_CONCEREL    || ']' );
                utl_file.put_line (fh,'>> COLUMNA_REL            : [' || Tab_FA_PRESUPUESTO(i).COLUMNA_REL     || ']' );
                utl_file.put_line (fh,'>> NUM_ABONADO            : [' || Tab_FA_PRESUPUESTO(i).NUM_ABONADO     || ']' );
                utl_file.put_line (fh,'>> FLAG_IMPUES            : [' || Tab_FA_PRESUPUESTO(i).FLAG_IMPUES     || ']' );
                utl_file.put_line (fh,'>> FLAG_DTO               : [' || Tab_FA_PRESUPUESTO(i).FLAG_DTO        || ']' );
                utl_file.put_line (fh,'>> VAL_DTO                : [' || Tab_FA_PRESUPUESTO(i).VAL_DTO         || ']' );
                utl_file.put_line (fh,'>> TIP_DTO                : [' || Tab_FA_PRESUPUESTO(i).TIP_DTO         || ']' );
                INSERT INTO FA_PRESUPUESTO
                            (
                                 NUM_PROCESO        ,        COD_CLIENTE        ,
                                 COD_CONCEPTO       ,        COLUMNA            ,
                                 COD_PRODUCTO       ,        COD_MONEDA         ,
                                 FEC_VALOR          ,        FEC_EFECTIVIDAD    ,
                                 IMP_CONCEPTO       ,        IMP_FACTURABLE     ,
                                 IMP_MONTOBASE      ,        COD_REGION         ,
                                 COD_PROVINCIA      ,        COD_CIUDAD         ,
                                 COD_MODULO         ,        COD_PLANCOM        ,
                                 IND_FACTUR         ,        FEC_VENTA          ,
                                 NUM_UNIDADES       ,        COD_CATIMPOS       ,
                                 IND_ESTADO         ,        COD_PORTADOR       ,
                                 COD_TIPCONCE       ,        COD_CICLFACT       ,
                                 COD_CONCEREL       ,        COLUMNA_REL        ,
                                 NUM_ABONADO        ,        NUM_TERMINAL       ,
                                 CAP_CODE           ,        NUM_SERIEMEC       ,
                                 NUM_SERIELE        ,        FLAG_IMPUES        ,
                                 FLAG_DTO           ,        PRC_IMPUESTO       ,
                                 VAL_DTO            ,        TIP_DTO            ,
                                 NUM_VENTA          ,        MES_GARANTIA       ,
                                 IND_ALTA           ,        IND_SUPERTEL       ,
                                 NUM_PAQUETE        ,        NUM_TRANSACCION    ,
                                 IND_CUOTA          ,        NUM_GUIA           ,
                                 NUM_CUOTAS         ,        ORD_CUOTA
                            )
                     VALUES
                            (
                                Tab_FA_PRESUPUESTO(i).NUM_PROCESO   ,        Tab_FA_PRESUPUESTO(i).COD_CLIENTE     ,
                                Tab_FA_PRESUPUESTO(i).COD_CONCEPTO  ,        Tab_FA_PRESUPUESTO(i).COLUMNA         ,
                                Tab_FA_PRESUPUESTO(i).COD_PRODUCTO  ,        Tab_FA_PRESUPUESTO(i).COD_MONEDA      ,
                                Tab_FA_PRESUPUESTO(i).FEC_VALOR     ,        Tab_FA_PRESUPUESTO(i).FEC_EFECTIVIDAD ,
                                Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO  ,        Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE  ,
                                Tab_FA_PRESUPUESTO(i).IMP_MONTOBASE ,        Tab_FA_PRESUPUESTO(i).COD_REGION      ,
                                Tab_FA_PRESUPUESTO(i).COD_PROVINCIA ,        Tab_FA_PRESUPUESTO(i).COD_CIUDAD      ,
                                Tab_FA_PRESUPUESTO(i).COD_MODULO    ,        Tab_FA_PRESUPUESTO(i).COD_PLANCOM     ,
                                Tab_FA_PRESUPUESTO(i).IND_FACTUR    ,        Tab_FA_PRESUPUESTO(i).FEC_VENTA       ,
                                Tab_FA_PRESUPUESTO(i).NUM_UNIDADES  ,        Tab_FA_PRESUPUESTO(i).COD_CATIMPOS    ,
                                Tab_FA_PRESUPUESTO(i).IND_ESTADO    ,        Tab_FA_PRESUPUESTO(i).COD_PORTADOR    ,
                                Tab_FA_PRESUPUESTO(i).COD_TIPCONCE  ,        Tab_FA_PRESUPUESTO(i).COD_CICLFACT    ,
                                Tab_FA_PRESUPUESTO(i).COD_CONCEREL  ,        Tab_FA_PRESUPUESTO(i).COLUMNA_REL     ,
                                Tab_FA_PRESUPUESTO(i).NUM_ABONADO   ,        Tab_FA_PRESUPUESTO(i).NUM_TERMINAL    ,
                                Tab_FA_PRESUPUESTO(i).CAP_CODE      ,        Tab_FA_PRESUPUESTO(i).NUM_SERIEMEC    ,
                                Tab_FA_PRESUPUESTO(i).NUM_SERIELE   ,        Tab_FA_PRESUPUESTO(i).FLAG_IMPUES     ,
                                Tab_FA_PRESUPUESTO(i).FLAG_DTO      ,        Tab_FA_PRESUPUESTO(i).PRC_IMPUESTO    ,
                                Tab_FA_PRESUPUESTO(i).VAL_DTO       ,        Tab_FA_PRESUPUESTO(i).TIP_DTO         ,
                                Tab_FA_PRESUPUESTO(i).NUM_VENTA     ,        Tab_FA_PRESUPUESTO(i).MES_GARANTIA    ,
                                Tab_FA_PRESUPUESTO(i).IND_ALTA      ,        Tab_FA_PRESUPUESTO(i).IND_SUPERTEL    ,
                                Tab_FA_PRESUPUESTO(i).NUM_PAQUETE   ,        Tab_FA_PRESUPUESTO(i).NUM_TRANSACCION ,
                                Tab_FA_PRESUPUESTO(i).IND_CUOTA     ,        Tab_FA_PRESUPUESTO(i).NUM_GUIA        ,
                                Tab_FA_PRESUPUESTO(i).NUM_CUOTAS    ,        Tab_FA_PRESUPUESTO(i).ORD_CUOTA
                             );
        END LOOP;
        /* COMMIT;
 */
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN DUP_VAL_ON_INDEX THEN
                SET_ERROR('>> INDICE DUPLICADO (NUM_PROCESO) (13)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (13)');
END InsertaRegFaPresupuesto;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (14)* ACTUALIZA LA TABLA GE_CARGOS                                                                 */
/* ********************************************************************************************* */
PROCEDURE UpdateCargos IS
i BINARY_INTEGER := 0;
BEGIN
        VP_PROC         := 'UpdateCargos            '        ;
        VP_TABLA         := 'GE_CARGOS'                        ;
        VP_ACT                := 'U'                                ;
        DEBUG;
        FOR i IN Tab_CARGA_CARGOS.FIRST .. Tab_CARGA_CARGOS.LAST LOOP
                UPDATE GE_CARGOS
                SET NUM_FACTURA = lhNumProceso_EXT
                WHERE ROWID = Tab_CARGA_CARGOS(i).Mi_RowID;
 /* Rowid recuperado antes */
        END LOOP;
        /* COMMIT;
 */
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO_DATA_FOUND : ROWID = Tab_CARGA_CARGOS(i).Mi_RowID(14)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (14)');
END UpdateCargos;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (15)* CAMBIA EL ESTADO DEL PROCESO EN EJECUCION                                                 */
/* ********************************************************************************************* */
PROCEDURE CambiaEstadoProceso (ihIndEstado IN NUMBER) IS
BEGIN
        IF ihIndEstado != PROC_ERR THEN
                VP_PROC         := 'CambiaEstadoProceso     '        ;
                VP_TABLA         := 'FA_PROCESOS'                ;
                VP_ACT                := 'U'                                ;
        END IF;
        DEBUG;
        UPDATE FA_PROCESOS
        SET IND_ESTADO = ihIndEstado
        WHERE NUM_PROCESO = lhNumProceso_EXT;
        COMMIT;
        IF ihIndEstado = PROC_OK THEN
                VP_SQLCODE := '0';
                VP_SQLERRM := 'NO ERROR';
                VP_ERROR   := '0';
                VP_DESCERR := '********** TERMINO EXITOSO DEL PROCESO **********';
                utl_file.put_line(fh,Raya2);
                utl_file.put_line (fh,VP_DESCERR);
                utl_file.put_line(fh,Raya2);
                utl_file.fclose(fh);
        END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SET_ERROR('>> NO DATA FOUND : NUM_PROCESO = lhNumProceso_EXT (15)');
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (15)');
END CambiaEstadoProceso;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (16)* INSERTA DATOS EN LA INTERFACE DE VENTAS CON EL SCHEDULER                                 */
/* ********************************************************************************************* */
PROCEDURE InsertaFaInterventa IS
BEGIN
        VP_PROC         := 'InsertaFaInterventa     '        ;
        VP_TABLA         := 'FA_INTERVENTA'                ;
        VP_ACT                := 'I'                                ;
        DEBUG;
        /*INSERT INTO SISCEL.FA_INTERVENTA*/
        INSERT INTO FA_INTERVENTA
                (
                        NUM_PROCESO                ,
                        NUM_VENTA                ,
                        COD_ESTADO                ,
                        COD_ESTPROC                ,
                        COD_TIPDOCUM                ,
                        NUM_FOLIO                ,
                        IND_GENERACION                ,
                        IND_IMPRESION                ,
                        IND_EJECUCION                ,
                        FEC_PROCESO                ,
                        FEC_ESTADO                ,
                        NOM_USUARIO
                )
        VALUES
                (
                        lhNumProceso_EXT        ,
                        lhNumVenta_EXT                ,
                        0                        ,
                        0                        ,
                        ihCodContado                ,
                        0                        ,
                        1                        ,
                        1                        ,
                        0                        ,
                        SYSDATE                        ,
                        SYSDATE                        ,
                        szhUser
                );
        utl_file.put_line (fh,'>> NUM_PROCESO            : [' || lhNumProceso_EXT || ']' );
        utl_file.put_line (fh,'>> NUM_VENTA              : [' || lhNumVenta_EXT   || ']' );
        utl_file.put_line (fh,'>> COD_ESTADO             : [' || 0                  || ']' );
        utl_file.put_line (fh,'>> COD_ESTPROC            : [' || 0                  || ']' );
        utl_file.put_line (fh,'>> COD_TIPDOCUM           : [' || ihCodContado          || ']' );
        utl_file.put_line (fh,'>> NUM_FOLIO              : [' || 0                  || ']' );
        utl_file.put_line (fh,'>> IND_GENERACION         : [' || 1                  || ']' );
        utl_file.put_line (fh,'>> IND_IMPRESION          : [' || 1                  || ']' );
        utl_file.put_line (fh,'>> IND_EJECUCION          : [' || 0                  || ']' );
        utl_file.put_line (fh,'>> FEC_PROCESO            : [' || SYSDATE          || ']' );
        utl_file.put_line (fh,'>> FEC_ESTADO             : [' || SYSDATE          || ']' );
        utl_file.put_line (fh,'>> NOM_USUARIO            : [' || szhUser          || ']' );
EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR THEN
                SET_ERROR('Error de Escritura (F)');
        WHEN UTL_FILE.INTERNAL_ERROR THEN
                SET_ERROR('Error Interno (?) (G)');
        WHEN DUP_VAL_ON_INDEX THEN
                SET_ERROR('>> INDICE DUPLICADO (NUM_PROCESO) (16)');
        WHEN OTHERS THEN
                SET_ERROR('>> ERROR INESPERADO (16)');
END InsertaFaInterventa;
/*  *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
BEGIN
        VP_PROC         := 'FA_PROC_PREBILLING_main '        ;
        VP_TABLA         := '-ninguna-'                        ;
        VP_ACT                := 'N'                                ;
        VP_SQLCODE        :=  '-1'                        ;
        VP_SQLERRM        := 'ERROR AL INICIO'                ;
        VP_ERROR        :=  '1'                                ;
        fallo                 := FALSE;
        ProcesoCreado         := FALSE;
/* *********************** SELECCION DE PARAMETROS GENERALES Y DEL CLIENTE ****************** */
        fh := utl_file.fopen(szhPathDir,szhNombArchLog,szhModoOpen);
        DEBUG;
/* *********************** SELECCION DE PARAMETROS GENERALES Y DEL CLIENTE ******************/
        ValidacionPrevia;
        /* PARAMETROS DE ENTRADA ('*_EXT') */
        IF (fallo = FALSE) THEN                /* FA_DATOSGENER */
        GetVariablesGlobales;
                IF (fallo = FALSE) THEN                /* GE_CATIMPCLIENTES */
                        GetCatImposCli;
/* ***************************** SELECCION DE CARACTERISTICAS DE LA VENTA ***********************/
                        IF (fallo = FALSE) THEN                /* GA_VENTAS */
                                GetRegVentas;
                                IF (fallo = FALSE) THEN                /* GE_LETRAS */
                                        GetLetra;
                                        IF (fallo = FALSE) THEN                /* AL_DOCUM_SUCURSAL */
                                                GetCentroEmisor;
                                                IF (fallo = FALSE) THEN                /* GE_ZONACIUDAD */
                                                        GetZonaImpositiva;
/* **************************** MANEJO DE LAS CARACTERISTICAS DEL PROCESO *********************/
                                                        IF (fallo = FALSE) THEN                /* DUAL */
                                                                GetNumSecuencia;
                                                                IF (fallo = FALSE) THEN                /* FA_PROCESOS  PROC_EJEC */
                                                                        InsertaRegFaProcesos;
/* ***************************** SELECCION DE LOS CARGOS A FACTURAR ****************************/
                                                                        IF (fallo = FALSE) THEN                /* GE_CARGOS --> ArregloCargos */
                                                                                CargaCargos;
                                                                                IF (fallo = FALSE) THEN                /* ArregloCargos --> ArregloPrefactura <n>*/
                                                                                        CargaCargosPrefactura;
/******************************* SELECCION DE LOS DESCUENTOS A APLICAR ************************/
                                                                                        IF (fallo = FALSE) THEN                /* ArregloCargos,ArregloPrefactura <n>  --> ArregloPrefactura <n+m>, ArregloVentaDtos */
                                                                                                CargaDesctosPrefactura;
/******************************* SELECCION DE LOS IMPUESTOS A APLICAR ************************/
                                                                                                IF (fallo = FALSE) THEN                /* ArregloPrefactura <n+m> --> ArregloPrefactura <2(n+m)> */
                                                                                                        CargaImptosPrefactura;
                                                                                                        IF (fallo = FALSE) THEN                /* ArregloPrefactura <2(n+m)>  --> FA_PRESUPUESTO */
                                                                                                                InsertaRegFaPresupuesto;
                                                                                                                IF (fallo = FALSE) THEN                /* --> GE_CARGOS.NUM_FACTURA */
                                                                                                                        UpdateCargos;
                                                                                                                        IF (fallo = FALSE) THEN                /* --> FA_INTARVENTA */
                                                                                                                                InsertaFaInterventa;
                                                                                                                                IF (fallo = FALSE) THEN                /* FA_PROCESOS  PROC_OK */
                                                                                                                                        CambiaEstadoProceso(PROC_OK);
         /* COMMIT INTERNO */
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
EXCEPTION
        WHEN FALLO_ACCESO_A_LA_BASE THEN
        BEGIN
                ROLLBACK;
 /* Deshacer todas las acciones sobre la base*/
                IF (ProcesoCreado = TRUE) THEN
                        CambiaEstadoProceso(PROC_ERR);
  /* COMMIT INTERNO */
                END IF;
                utl_file.put_line(fh,' Fallo en el proceso       : ' || VP_PROC    );
                utl_file.put_line(fh,' Realizando la accion      : ' || VP_ACT     );
                utl_file.put_line(fh,' Sobre la Tabla            : ' || VP_TABLA   );
                utl_file.put_line(fh,' SQLCODE                   : ' || VP_SQLCODE );
                utl_file.put_line(fh,' SQLERRM                   : ' || VP_SQLERRM );
                utl_file.put_line(fh,' ERROR                     : ' || VP_ERROR   );
                utl_file.put_line(fh,' DETALLE ERROR             : ' || VP_DESCERR );
                utl_file.put_line(fh,Raya2);
                utl_file.put_line(fh,'* Termino Controlado del Proceso Por Excepcion **');
                utl_file.put_line(fh,Raya2);
                utl_file.fclose(fh);
        END;
        WHEN UTL_FILE.INVALID_PATH THEN
        BEGIN
                VP_SQLERRM := 'Path Invalida (A)';
                VP_SQLCODE        :=  TO_CHAR(SQLCODE);
                VP_ERROR        :=  '1' ;
        END;
        WHEN UTL_FILE.INVALID_MODE THEN
        BEGIN
                VP_SQLERRM := 'Modo Invalido (B)';
                VP_SQLCODE        :=  TO_CHAR(SQLCODE);
                VP_ERROR        :=  '1' ;
        END;
        WHEN UTL_FILE.INVALID_OPERATION THEN
        BEGIN
                VP_SQLERRM := 'Operacion Invalida (C)';
                VP_SQLCODE        :=  TO_CHAR(SQLCODE);
                VP_ERROR        :=  '1' ;
        END;
        WHEN UTL_FILE.INVALID_FILEHANDLE THEN
        BEGIN
                VP_SQLERRM := 'FileHandle Invalido (D)';
                VP_SQLCODE        :=  TO_CHAR(SQLCODE);
                VP_ERROR        :=  '1' ;
        END;
        WHEN UTL_FILE.READ_ERROR THEN
        BEGIN
                VP_SQLERRM := 'Error de Lectura (E)';
                VP_SQLCODE        :=  TO_CHAR(SQLCODE);
                VP_ERROR        :=  '1' ;
        END;
        WHEN UTL_FILE.WRITE_ERROR THEN
        BEGIN
                VP_SQLERRM := 'Error de Escritura (F)';
                VP_SQLCODE        :=  TO_CHAR(SQLCODE);
                VP_ERROR        :=  '1' ;
        END;
        WHEN UTL_FILE.INTERNAL_ERROR THEN
        BEGIN
                VP_SQLERRM := 'Error Interno (?) (G)';
                VP_SQLCODE        :=  TO_CHAR(SQLCODE);
                VP_ERROR        :=  '1' ;
        END;
        WHEN OTHERS THEN
        BEGIN
                ROLLBACK;
                VP_SQLERRM := SUBSTR(SQLERRM,1,50);
                utl_file.put_line (fh,Raya2);
                utl_file.put_line (fh,' Se produjo un error inesperado  : ' || TO_CHAR(SQLCODE) );
                utl_file.put_line (fh,VP_SQLERRM);
                utl_file.put_line (fh,Raya2);
                utl_file.fclose(fh);
        END;
END FA_PROC_PREBILLING;
/
SHOW ERRORS
