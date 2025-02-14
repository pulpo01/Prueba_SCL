CREATE OR REPLACE PACKAGE BODY FA_PAC_IMPTOS   AS
/* ********************************************************************************************* */
/*                              Items privados                                                                                                   */
/* ********************************************************************************************* */
     fallo          BOOLEAN              ;
     szError        VARCHAR2(2)  ;
     Raya1          VARCHAR2(50) ;
     Raya2          VARCHAR2(50) ;
     Asteriscos     VARCHAR2(50) ;
     V_DesErr       VARCHAR2(100);
     V_NomProc      VARCHAR2(50) ;
     V_NomTabl      VARCHAR2(50) ;
     V_TipAct       VARCHAR2(50) ;

     CPORCENTUAL    PLS_INTEGER := 0; --CODIFICADO EN EL DOMINIO DE GE_TIPIMPUES.TIP_MONTO PARA VALOR PORCENTUAL
     ihCodGrpServi  FA_GRPSERCONC.COD_GRPSERVI%TYPE;
     iNumDecimales  GED_PARAMETROS.VAL_PARAMETRO%TYPE;

     /* tabla para almacenar los numeros de columna de cada concepto */
     TYPE TipReg_Columnas IS RECORD (ihCodConcepto_COL GE_CARGOS.COD_CONCEPTO%TYPE := null , ihNumOcurrencias_COL PLS_INTEGER:= null);
     TYPE TipTab_Columnas IS TABLE OF  TipReg_Columnas INDEX BY PLS_INTEGER;
     Tab_Columnas   TipTab_Columnas;
     Tab_Impuestos  TipTab_Impuestos;

     /*P-CSR-12019*/
     TYPE TipReg_Conceptos_Agrup IS RECORD (num_abonado  GA_ABOCEL.NUM_ABONADO%TYPE := 0, imp_total NUMBER);
     TYPE TipTab_CONCEPTOS_AGRUP_ABON IS TABLE OF TipReg_Conceptos_Agrup INDEX BY PLS_INTEGER;
     
     TYPE TipReg_Impuesto_Acum IS RECORD (num_abonado  GA_ABOCEL.NUM_ABONADO%TYPE := 0, imp_total NUMBER, cod_concepto FA_PRESUPUESTO.COD_CONCEPTO%TYPE);
     TYPE TipTab_IMPUESTO_ACUM IS TABLE OF TipReg_Impuesto_Acum INDEX BY VARCHAR2(100);
     
     /*FIN P-CSR-12019*/
     
     TYPE TipRegTotImptoAjustes IS RECORD (
                                        COD_CONCIMPTO     FA_PRESUPUESTO.COD_CONCEPTO%TYPE,
                                        PRC_IMPUESTO      FA_PRESUPUESTO.PRC_IMPUESTO%TYPE,
                                        TOT_IMPTO         FA_PRESUPUESTO.IMP_FACTURABLE%TYPE,
                                        TOT_MTOBASE       FA_PRESUPUESTO.IMP_FACTURABLE%TYPE,
                                        TIP_MONTO         GE_TIPIMPUES.TIP_MONTO%TYPE);

     TYPE TipTab_TotImptoAjustes IS TABLE  OF  TipRegTotImptoAjustes INDEX BY  PLS_INTEGER;
     Tab_TotImptoAjustes  TipTab_TotImptoAjustes;

     /********* Impuestos a Dctos *********/
     TYPE TipRegGrpServi IS RECORD (    COD_ZONACARGO    FA_IMPTODCTOS_TD.COD_ZONACARGO%TYPE,
                                        TIP_ZONACARGO    FA_IMPTODCTOS_TD.TIP_ZONACARGO%TYPE,
                                        TIP_EVALUACION   FA_IMPTODCTOS_TD.TIP_EVALUACION%TYPE,
                                        COD_REGION       FA_IMPTODCTOS_TD.COD_REGION%TYPE,
                                        COD_PROVINCIA    FA_IMPTODCTOS_TD.COD_PROVINCIA%TYPE,
                                        COD_GRPSERVI     FA_IMPTODCTOS_TD.COD_GRPSERVI%TYPE);
     TYPE TipTabGrpServi IS TABLE OF TipRegGrpServi INDEX BY  PLS_INTEGER;

     /* XO-200607241178 FAAR 20060725  SE AGREGA EL COD_CATIMPOS A LA ESTRUCTURA */
     TYPE TipRegImptosDctos IS RECORD ( COD_CONCEPTO     FA_IMPTODCTOS_TD.COD_CONCEPTO%TYPE,
                                        COD_MONEDA       FA_DATOSGENER.COD_MONEFACT%TYPE,
                                        TIP_VALOR        FA_IMPTODCTOS_TD.TIP_VALOR%TYPE,
                                        IMP_FACTURABLE   FA_IMPTODCTOS_TD.IMP_FACTURABLE%TYPE,
                                        COD_CATIMPOS     FA_IMPTODCTOS_TD.COD_CATIMPOS%TYPE,
                                        GruposServ       TipTabGrpServi ,
                                        IndEval1         BOOLEAN := FALSE,
                                        IndEval2         BOOLEAN := FALSE,
                                        IndEval3         BOOLEAN := FALSE,
                                        IndAplic         BOOLEAN := FALSE
                                        );

     TYPE TipTabImptosDctos IS TABLE  OF  TipRegImptosDctos INDEX BY  PLS_INTEGER;
     TabImptosDctos  TipTabImptosDctos;

     /********* Impuestos a Dctos *********/

/* *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/* (-1) * -- DEBUGGER EN TIEMPO DE EJECUCION DEL PROGRAMA                                           */
/* ********************************************************************************************* */
-- PROCEDURE -- DEBUG IS
-- BEGIN
--        ---- dbms_output.PUT_LINEa2);
--       -- dbms_output.Put_Line(Asteriscos || ' ' || V_NomProc || '*');
-- EXCEPTION
--         WHEN UTL_FILE.WRITE_ERROR THEN
--                 V_DesErr := 'Error de Escritura (F)';
--         WHEN UTL_FILE.INTERNAL_ERROR THEN
--                 V_DesErr := 'Error Interno (?) (G)';
-- END -- DEBUG;
/* *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

FUNCTION fbInicializa RETURN BOOLEAN IS

BEGIN
     V_NomProc  := 'fbInicializa    ';
     V_NomTabl  := '-Ninguna-'       ;
     V_TipAct   := '-'               ;

     -- DEBUG;

     iNumDecimales  := 0;
     ihCodGrpServi  := 0;
     iNumDecimales  := GE_PAC_GENERAL.PARAM_GENERAL('NUM_DECIMAL_FACT');

     -- dbms_output.put_line ('Tab_Columnas.COUNT'||Tab_Columnas.COUNT);
     Tab_Columnas.DELETE;
     Tab_Impuestos.DELETE;
     Tab_TotImptoAjustes.DELETE;
     TabImptosDctos.DELETE;

     RETURN TRUE;

END fbInicializa;

/* ********************************************************************************************* */
/* (12-A-1)* OBTENCION DEL CODIGO DE GRUPO DE SERVICIO                                           */
/* ********************************************************************************************* */
FUNCTION fbGetCodGrpServicios (CodConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE ) RETURN BOOLEAN IS
BEGIN
        V_NomProc  := 'fbGetCodGrpServicios    ';
        V_NomTabl  := 'FA_GRPSERCONC'           ;
        V_TipAct   := 'S'                       ;
        -- DEBUG;
                -- dbms_output.put_line('CodConcepto :'|| CodConcepto);
        SELECT COD_GRPSERVI
          INTO ihCodGrpServi  /* Global */
          FROM FA_GRPSERCONC
         WHERE COD_CONCEPTO  = CodConcepto
           AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
                -- dbms_output.put_line('ihCodGrpServi :'|| ihCodGrpServi);
        RETURN TRUE ;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                V_DesErr := '>> NO DATA FOUND (12a1)';
                RETURN FALSE ;
        WHEN OTHERS THEN
                V_DesErr := '>> ERROR INESPERADO (12a1)';
                RETURN FALSE ;
END fbGetCodGrpServicios;
/* . *//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (12-A)* MODULO DE CALCULO DE IMPUESTOS                                                        */
/* ********************************************************************************************* */
FUNCTION fdCalcImptos ( IMP_CONCEPTO IN FA_PRESUPUESTO.IMP_CONCEPTO%TYPE,
                        PRC_IMPUESTO IN FA_PRESUPUESTO.PRC_IMPUESTO%TYPE,
                        TIP_MONTO    IN GE_TIPIMPUES.TIP_MONTO%TYPE ) RETURN NUMBER IS
dhImpFacturable  FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;

BEGIN
        V_NomProc    := 'fdCalcImptos            ';
        V_NomTabl    := '-ninguna-'               ;
        V_TipAct     := 'N'                       ;
        -- DEBUG;

        IF TIP_MONTO = CPORCENTUAL THEN --PORCENTAJE
           dhImpFacturable := IMP_CONCEPTO * (PRC_IMPUESTO/100);
        ELSE
           dhImpFacturable := PRC_IMPUESTO;
        END IF;

        RETURN dhImpFacturable;
EXCEPTION
        WHEN OTHERS THEN
                V_DesErr :='>> ERROR INESPERADO (12a)';
                RETURN -1;
END fdCalcImptos;
FUNCTION fdCalcImptosUmbral (EN_COD_CONCEPTO IN   FA_PRESUPUESTO.COD_CONCEPTO%TYPE,
                        IMP_CONCEPTO IN FA_PRESUPUESTO.IMP_CONCEPTO%TYPE,
                        PRC_IMPUESTO IN FA_PRESUPUESTO.PRC_IMPUESTO%TYPE,
                        TIP_MONTO    IN GE_TIPIMPUES.TIP_MONTO%TYPE ,
                        EN_NUM_ABONADO IN GA_ABOCEL.NUM_ABONADO%TYPE,
                        EN_MONTO_MAXIMO IN NUMBER,
                        EN_UMBRAL IN NUMBER,
                        ST_CONCEPTOS_AGRUP_ABON  IN OUT NOCOPY TipTab_CONCEPTOS_AGRUP_ABON,
                        ST_IMPUESTO_ACUM IN OUT NOCOPY TipTab_IMPUESTO_ACUM,
                        SN_MONTO_BASE OUT  NOCOPY NUMBER ) RETURN NUMBER IS
dhImpFacturable  FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;
 ln_impto_por_completar NUMBER;
 ln_num_abonado  GA_ABOCEL.NUM_ABONADO%TYPE;
 ln_indice VARCHAR2(100);
BEGIN
        V_NomProc    := 'fdCalcImptosUmbral     ';
        V_NomTabl    := '-ninguna-'               ;
        V_TipAct     := 'N'                       ;
       sn_monto_base := 0;
       LN_NUM_ABONADO := NVL(EN_NUM_ABONADO,0);
       ln_indice := LN_NUM_ABONADO || '*' || EN_COD_CONCEPTO;
       IF NOT  ST_IMPUESTO_ACUM.EXISTS(ln_indice) THEN
            ST_IMPUESTO_ACUM(ln_indice).imp_total := 0;
       END IF;
 
       IF EN_MONTO_MAXIMO > 0 THEN
          ln_impto_por_completar := EN_MONTO_MAXIMO -  ST_IMPUESTO_ACUM(ln_indice).IMP_TOTAL;
       ELSE
          ln_impto_por_completar:= 9999999999;
       END IF;
       
 
       dhImpFacturable:= 0;
       
       if ln_impto_por_completar>0 then 
           IF ST_CONCEPTOS_AGRUP_ABON.EXISTS(LN_NUM_ABONADO) THEN
 
                IF  ST_CONCEPTOS_AGRUP_ABON(LN_NUM_ABONADO).imp_total  >= EN_UMBRAL THEN
                
                     IF TIP_MONTO = CPORCENTUAL THEN --PORCENTAJE
                         dhImpFacturable := IMP_CONCEPTO * (PRC_IMPUESTO/100);
                     ELSE
                         dhImpFacturable := PRC_IMPUESTO;
                    END IF;
                    sn_monto_base := IMP_CONCEPTO;
                    IF dhimpfacturable >  ln_impto_por_completar THEN
                        sn_monto_base := (IMP_CONCEPTO *  ln_impto_por_completar) / dhimpfacturable;
                        dhimpfacturable := ln_impto_por_completar;
                    END IF;
                     
                END IF;  
                ST_IMPUESTO_ACUM(ln_indice).IMP_TOTAL := ST_IMPUESTO_ACUM(ln_indice).IMP_TOTAL +  dhimpfacturable;
 
           ELSE
                   V_DesErr :='>> ERROR EN CALCULO IMPUESTO POR UMBRAL- ABONADO NO TOTALIZADO)';
                 RETURN -1   ;
           END IF;
       END IF;
       


        RETURN dhImpFacturable;
EXCEPTION
        WHEN OTHERS THEN
                V_DesErr :='>> ERROR INESPERADO Calculo Impuesto con Umbral';
                RETURN -1;
END fdCalcImptosUmbral;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (18)* ACUMULA LOS MONTOS DE LOS CONCEPTOS DE IMPUESTO PARA REALIZAR LOS AJUSTES               */
/* ********************************************************************************************* */
FUNCTION fbAcumTotImptos(COD_CONCBASE  IN FA_PRESUPUESTO.COD_CONCEPTO%TYPE,
                         COD_CONCIMPTO IN FA_PRESUPUESTO.COD_CONCEPTO%TYPE,
                         PRC_IMPUESTO  IN FA_PRESUPUESTO.PRC_IMPUESTO%TYPE,
                         TOT_IMPTO     IN FA_PRESUPUESTO.IMP_CONCEPTO%TYPE,
                         TOT_MTOBASE   IN FA_PRESUPUESTO.IMP_CONCEPTO%TYPE,
                         TIP_MONTO     IN GE_TIPIMPUES.TIP_MONTO%TYPE,
                         NUM_UNIDADES            NUMBER) RETURN BOOLEAN IS
nhConcCarrier  PLS_INTEGER;
i              PLS_INTEGER;
bExiste        BOOLEAN := FALSE;
BEGIN
        V_NomProc   := 'fbAcumTotImptos         '   ;
        V_NomTabl   := '-ninguna-'                  ;
        V_TipAct    := 'N'                          ;
        -- DEBUG;

       -- dbms_output.put_line('>> COD_CONCBASE        : [' || COD_CONCBASE   || ']' );
       -- dbms_output.put_line('>> COD_CONCIMPTO       : [' || COD_CONCIMPTO   || ']' );
       -- dbms_output.put_line('>> PRC_IMPUESTO        : [' || PRC_IMPUESTO   || ']' );
       -- dbms_output.put_line('>> TOT_IMPTO           : [' || TOT_IMPTO   || ']' );
       -- dbms_output.put_line('>> TOT_MTOBASE         : [' || TOT_MTOBASE   || ']' );

        BEGIN
                 SELECT COUNT(1)
                   INTO nhConcCarrier
                   FROM FA_FACTCARRIERS
                  WHERE COD_CONCFACT=COD_CONCBASE;
        EXCEPTION
                 WHEN OTHERS THEN
                                 RETURN FALSE;
        END;
        IF nhConcCarrier = 0 THEN
            IF Tab_TotImptoAjustes.COUNT = 0 THEN
                i := 1 ;
                Tab_TotImptoAjustes(i).COD_CONCIMPTO := COD_CONCIMPTO;
                Tab_TotImptoAjustes(i).PRC_IMPUESTO  := PRC_IMPUESTO ;
                Tab_TotImptoAjustes(i).TOT_IMPTO     := TOT_IMPTO;
                Tab_TotImptoAjustes(i).TOT_MTOBASE   := (TOT_MTOBASE );
                Tab_TotImptoAjustes(i).TIP_MONTO     := TIP_MONTO;
            ELSE
                FOR i IN Tab_TotImptoAjustes.FIRST .. Tab_TotImptoAjustes.LAST LOOP
                    IF Tab_TotImptoAjustes(i).COD_CONCIMPTO = COD_CONCIMPTO THEN
                        Tab_TotImptoAjustes(i).TOT_IMPTO   := Tab_TotImptoAjustes(i).TOT_IMPTO + (TOT_IMPTO );
                        Tab_TotImptoAjustes(i).TOT_MTOBASE := Tab_TotImptoAjustes(i).TOT_MTOBASE + (TOT_MTOBASE );
                        bExiste := TRUE;
                    END IF;
                END LOOP;
                IF NOT bExiste THEN
                    i := Tab_TotImptoAjustes.LAST ;
                    i := i + 1;
                    Tab_TotImptoAjustes(i).COD_CONCIMPTO := COD_CONCIMPTO;
                    Tab_TotImptoAjustes(i).PRC_IMPUESTO  := PRC_IMPUESTO ;
                    Tab_TotImptoAjustes(i).TOT_IMPTO     := TOT_IMPTO;
                    Tab_TotImptoAjustes(i).TOT_MTOBASE   := (TOT_MTOBASE );
                    Tab_TotImptoAjustes(i).TIP_MONTO     := TIP_MONTO;
                END IF;
            END IF;

        END IF;
        RETURN TRUE;
EXCEPTION
        WHEN OTHERS THEN
                BEGIN
                V_DesErr := '>> ERROR INESPERADO (18)';
                RETURN FALSE;
                END;
END fbAcumTotImptos;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/* (18)* OBTIENE LOS IMPUESTOS Y SUS PORCENTAJES POR CONCEPTO                                  * */
/* ********************************************************************************************* */
FUNCTION fbGetImpuestos ( ihCodCatImpos  IN GE_DATOSGENER.COD_CATIMPOS%TYPE
                        , ihCodZonaImpo  IN GE_ZONACIUDAD.COD_ZONAIMPO%TYPE
                        , ihCodZonaAbon  IN GE_ZONACIUDAD.COD_ZONAIMPO%TYPE
                        , pTab_Impuestos OUT NOCOPY TipTab_Impuestos
                        ) RETURN BOOLEAN IS
i   PLS_INTEGER:= 0;
CURSOR cIMPUESTOS IS
       SELECT DISTINCT I.COD_CONCGENE, I.PRC_IMPUESTO, T.TIP_MONTO, 
      NVL( IMP_UMBRAL,0) IMP_UMBRAL, NVL(IMP_MAXIMO,0) IMP_MAXIMO/*P-CSR-12019*/
         FROM GE_IMPUESTOS I,GE_TIPIMPUES T
        WHERE I.COD_CATIMPOS  = ihCodCatImpos
          AND I.COD_ZONAIMPO  = decode(I.COD_ZONAIMPO,0,0,ihCodZonaImpo)
          AND I.COD_ZONAABON  = decode(I.COD_ZONAABON,0,0,ihCodZonaAbon)
          AND I.COD_GRPSERVI  = ihCodGrpServi            /* global */
          AND I.COD_TIPIMPUES =T.COD_TIPIMPUE
          AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

BEGIN
        V_NomProc   := 'fbGetImpuestos          '   ;
        V_NomTabl   := 'GE_IMPUESTOS'               ;
        V_TipAct    := 'S'                          ;
        -- DEBUG;

     --   dbms_output.put_line('>>  ihCodCatImpos           : [' || ihCodCatImpos   || ']' );
    --    dbms_output.put_line('>>  ihCodZonaImpo           : [' || ihCodZonaImpo   || ']' );
    --    dbms_output.put_line('>>   ihCodGrpServi           : [' || ihCodGrpServi   || ']' );
     --    dbms_output.put_line('>>   ihCodZonaAbon           : [' ||ihCodZonaAbon || ']' );

        FOR rRegImpto IN cIMPUESTOS LOOP
            i:= i + 1;
            pTab_Impuestos(i).COD_CONCIMPTO := rRegImpto.COD_CONCGENE;
            pTab_Impuestos(i).PRC_IMPUESTO  := rRegImpto.PRC_IMPUESTO ;
            pTab_Impuestos(i).TIP_MONTO  := rRegImpto.TIP_MONTO ;
            pTab_Impuestos(i).IMP_UMBRAL  := rRegImpto.IMP_UMBRAL; /*P-CSR-12019*/
             pTab_Impuestos(i).IMP_MAXIMO  := rRegImpto.IMP_MAXIMO;/*P-CSR-12019*/
        END LOOP;
        RETURN TRUE;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                -- dbms_output.put_line('fbGetImpuestos:NO_DATA_FOUND');
                V_DesErr := '>> NO DATA FOUND (12a2)';
                RETURN TRUE;
        WHEN OTHERS THEN
                -- dbms_output.put_line('fbGetImpuestos:OTHERS');
                V_DesErr := '>> ERROR INESPERADO (12a2)';
                RETURN FALSE;
END fbGetImpuestos;

/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/* ********************************************************************************************* */
/* (10-B)* OBTIENE LA COLUMNA CORRESPONDIENTE AL CONCEPTO BUSCADO                                */
/* ********************************************************************************************* */
FUNCTION fGetColumna (ihConceptoBuscado IN GE_CARGOS.COD_CONCEPTO%TYPE) RETURN NUMBER IS
i                  PLS_INTEGER := 1 ;
ENCONTRADO BOOLEAN         := FALSE ;
Columna    PLS_INTEGER     := 1;
BEGIN
        V_NomProc   := 'fGetColumna             '   ;
        V_NomTabl   := 'Tab_Columnas'               ;
        V_TipAct    := 'U'                          ;
        -- DEBUG;
        IF Tab_Columnas.COUNT = 0 THEN
            i := 1 ;
            Tab_Columnas(i).ihCodConcepto_COL := ihConceptoBuscado;
            Tab_Columnas(i).ihNumOcurrencias_COL := 1 ;
        ELSE
            FOR i IN Tab_Columnas.FIRST .. Tab_Columnas.LAST LOOP
                IF Tab_Columnas(i).ihCodConcepto_COL  = ihConceptoBuscado THEN
                    Tab_Columnas(i).ihNumOcurrencias_COL := Tab_Columnas(i).ihNumOcurrencias_COL + 1;
                    Columna                              := Tab_Columnas(i).ihNumOcurrencias_COL;
                    ENCONTRADO                           := TRUE;
                END IF;
            END LOOP;
            i := Tab_Columnas.LAST ;
            IF NOT ENCONTRADO THEN
                i := i + 1;
                Tab_Columnas(i).ihCodConcepto_COL           := ihConceptoBuscado;
                Tab_Columnas(i).ihNumOcurrencias_COL  := 1 ;
            END IF;
        END IF;
        RETURN Columna ;
EXCEPTION
        WHEN OTHERS THEN
                V_DesErr := '>> ERROR INESPERADO (10b)';
                RETURN -1;
END fGetColumna;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/* (-2) * SETEA EL CODIGO DE ERROR EN LAS VARIABLES DE RETORNO                                 * */
/* ********************************************************************************************* */

PROCEDURE SET_ERROR(DESCRIPCION  IN  VARCHAR2
                   ,pVP_PROC     OUT NOCOPY VARCHAR2    /* En que parte del proceso estoy*/
                   ,pVP_TABLA    OUT NOCOPY VARCHAR2    /* En que tabla estoy trabajando*/
                   ,pVP_ACT      OUT NOCOPY VARCHAR2    /* Que accion estoy ejecutando*/
                   ,pVP_SQLCODE  OUT NOCOPY VARCHAR2    /* sqlcode*/
                   ,pVP_SQLERRM  OUT NOCOPY VARCHAR2    /* sqlerrm*/
                   ,pVP_ERROR    OUT NOCOPY VARCHAR2
                   ,pVP_DESCERR  OUT NOCOPY VARCHAR2) IS
BEGIN
        IF V_DesErr IS NULL THEN
                pVP_SQLCODE := TO_CHAR(SQLCODE);
                pVP_SQLERRM := SUBSTR(SQLERRM,1,50);
                pVP_DESCERR := DESCRIPCION;
                pVP_ERROR   := '1';
        END IF;
                pVP_PROC  := V_NomProc;
                pVP_TABLA := V_NomTabl;
                pVP_ACT   := V_TipAct ;
        fallo := TRUE ;
END SET_ERROR;
/* *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/* (  ) * OBTIENE EL PARAMETRO DE MINIMO AJUSTABLE                                             * */
/* ********************************************************************************************* */
FUNCTION fbGetParMinAjuste (iMinAjuste OUT NOCOPY NUMBER) RETURN BOOLEAN IS
        ihMinAjuste PLS_INTEGER := 0;

BEGIN

        V_NomProc  := 'fbGetParMinAjuste    ';
        V_NomTabl  := 'GED_PARAMETROS'       ;
        V_TipAct   := 'S'                    ;

        -- dbms_output.put_line('viene query'||ihMinAjuste);
        SELECT TO_NUMBER(VAL_PARAMETRO)
          INTO ihMinAjuste
          FROM GED_PARAMETROS
         WHERE NOM_PARAMETRO = '4'
           AND COD_MODULO    = 'FA'
           AND COD_PRODUCTO  = 1;
        -- dbms_output.put_line('viene query'||ihMinAjuste);
        iMinAjuste := ihMinAjuste ;
        -- dbms_output.put_line('viene query'||iMinAjuste   );
        RETURN TRUE ;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- dbms_output.put_line('NO_DATA_FOUND');
                V_DesErr := '>> NO DATA FOUND (12a1)';
                RETURN FALSE ;
        WHEN OTHERS THEN
            -- dbms_output.put_line('OTHERS');
                V_DesErr := '>> ERROR INESPERADO (12a1)';
                RETURN FALSE ;
END fbGetParMinAjuste;
/* *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/*  Obtiene el valor del parametro entregado                                                   * */
/* ********************************************************************************************* */
FUNCTION fbGetFadParametro (iParametro IN NUMBER, iValor OUT NOCOPY NUMBER) RETURN BOOLEAN IS
        ihValor FAD_PARAMETROS.VAL_NUMERICO%TYPE := 0;

BEGIN
        V_NomProc  := 'fbGetFadParametro    ';
        V_NomTabl  := 'FAD_PARAMETROS'||to_char(iParametro);
        V_TipAct   := 'S'                    ;

        SELECT VAL_NUMERICO
          INTO ihValor
          FROM FAD_PARAMETROS
         WHERE COD_MODULO    = 'FA'
           AND COD_PARAMETRO = IParametro;

        iValor := ihValor ;
        RETURN TRUE ;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                iValor := 0;
                RETURN TRUE ;
        WHEN OTHERS THEN
                V_DesErr := '>> ERROR INESPERADO (12a1)';
                RETURN FALSE ;
END fbGetFadParametro;
/* *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/


/* ********************************************************************************************* */
/*  Determina si es abonado prepago                  col-50001 Indra-jpena 23/06/05* */
/* ********************************************************************************************* */
FUNCTION FA_ES_ABONADO_PREPAGO_FN (EN_NumAbonado  IN  FA_PRESUPUESTO.NUM_ABONADO%TYPE) RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "FA_ES_ABONADO_PREPAGO_FN"
      Lenguaje="PL/SQL"
      Fecha="24-06-2005"
      Versión="1.0"
      Diseñador="Jaime Peña"
      Programador="Jaime Peña Olmos"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Determina si es Abonado Prepago </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NumAbonado" Tipo="NUMERICO">Numero de Celular(Abonado)</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
iIndicador PLS_INTEGER := 0;

BEGIN
        V_NomProc  := 'FA_ES_ABONADO_PREPAGO_FN';
        V_NomTabl  := 'GA_ABOAMIST'       ;
        V_TipAct   := 'S'                   ;

        SELECT CAMPO
          INTO iIndicador
        FROM (
            SELECT 0 CAMPO FROM GA_ABOCEL WHERE NUM_ABONADO=EN_NumAbonado
            UNION
            SELECT 1 CAMPO FROM GA_ABOAMIST WHERE NUM_ABONADO=EN_NumAbonado
            );
        IF iIndicador = 1 THEN
            RETURN TRUE ;
        ELSE
            RETURN FALSE ;
        END IF;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                iIndicador := 1;
                RETURN TRUE ;
        WHEN OTHERS THEN
                V_DesErr := '>> ERROR INESPERADO ( ?.)';
                RETURN FALSE ;
END FA_ES_ABONADO_PREPAGO_FN;
/* ********************************************************************************************* */
/* (21)* VALIDA LAS ZONAS DE EVALUACION DE LOS IMPUESTO A LOS DOCUMENTOS                       * */
/* ********************************************************************************************* */
FUNCTION fbValidaZonaEval (EV_Cod_ZonaEval  IN VARCHAR2,
                           EC_Ind_TipZona   IN VARCHAR2 ,
                           EB_Ind_TipEval   IN BOOLEAN,
                           EV_Cod_Region    IN VARCHAR2,
                           EV_Cod_Provincia IN VARCHAR2 )
    RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fbValidaZonaEval"
      Lenguaje="PL/SQL"
      Fecha="09-03-2006"
      Versión="1.0"
      Diseñador="Rodrigo Arzola O."
      Programador="Rodrigo Arzola O."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida las zonas de evaluacion de los impuestos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_Cod_ZonaEval" Tipo="STRING">Codigo de la zona a evaluar</param>
            <param nom="EC_Ind_TipZona" Tipo="STRING">Tipo de zona de cargo  </param>
            <param nom="EB_Ind_TipEval" Tipo="STRING">Tipo de zona false= cliente; true = abonado </param>
            <param nom="EV_Cod_Region" Tipo="STRING">El codigo de la region de la zona de cargo </param>
            <param nom="EV_Cod_Provincia" Tipo="STRING">El codigo de la provincia de la zona de cargo  </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

i       PLS_INTEGER:= 0;
bRes    BOOLEAN  := FALSE;
BEGIN

    FOR i IN TabImptosDctos.FIRST .. TabImptosDctos.LAST LOOP
        IF  (NOT TabImptosDctos(i).IndAplic) THEN /* no se ha completado validacion del impto */
            FOR j IN TabImptosDctos(i).GruposServ.FIRST .. TabImptosDctos(i).GruposServ.LAST LOOP
                IF  (TabImptosDctos(i).GruposServ(j).TIP_ZONACARGO = EC_Ind_TipZona )
                AND (TabImptosDctos(i).GruposServ(j).COD_ZONACARGO = EV_Cod_ZonaEval)
                AND (  (TabImptosDctos(i).GruposServ(j).TIP_ZONACARGO  = 0)          /* zona impositiva */
                    OR (TabImptosDctos(i).GruposServ(j).TIP_ZONACARGO  = 1           /* provincia */
                        AND TabImptosDctos(i).GruposServ(j).COD_REGION    = EV_Cod_Region)
                    OR (TabImptosDctos(i).GruposServ(j).TIP_ZONACARGO  = 2 )         /* region  */
                    OR (TabImptosDctos(i).GruposServ(j).TIP_ZONACARGO  = 3           /* ciudad  */
                       AND TabImptosDctos(i).GruposServ(j).COD_REGION     = EV_Cod_Region
                       AND TabImptosDctos(i).GruposServ(j).COD_PROVINCIA  = EV_Cod_Provincia)
                    OR (TabImptosDctos(i).GruposServ(j).TIP_ZONACARGO  = 4           /* comuna  */
                       AND TabImptosDctos(i).GruposServ(j).COD_REGION     = EV_Cod_Region
                       AND TabImptosDctos(i).GruposServ(j).COD_PROVINCIA  = EV_Cod_Provincia)) THEN

                        IF EB_Ind_TipEval THEN
                           TabImptosDctos(i).IndEval3 := TRUE; /* abonados */
                        ELSE
                           TabImptosDctos(i).IndEval2 := TRUE; /* cliente  */
                        END IF;
                END IF;
              END LOOP;
        ELSE
            bRes := TRUE;
        END IF;
    END LOOP;

    FOR i IN TabImptosDctos.FIRST .. TabImptosDctos.LAST LOOP
        IF  (NOT TabImptosDctos(i).IndAplic) THEN /* no se ha completado validacion del impto */
            FOR j IN TabImptosDctos(i).GruposServ.FIRST .. TabImptosDctos(i).GruposServ.LAST LOOP
                IF (TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 0 AND  /* cliente spool off */
                    TabImptosDctos(i).IndEval1 = TRUE    AND
                    TabImptosDctos(i).IndEval2 = TRUE    AND
                    TabImptosDctos(i).IndEval3 = TRUE    )
                OR (TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 1 AND /* cliente */
                    TabImptosDctos(i).IndEval1 = TRUE    AND
                    TabImptosDctos(i).IndEval2 = TRUE    )
                OR (TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 2 AND  /* abonado */
                    TabImptosDctos(i).IndEval1 = TRUE    AND
                    TabImptosDctos(i).IndEval3 = TRUE    )
                OR (TabImptosDctos(i).IndEval1 = TRUE AND
                    TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 4) THEN /* ninguna */
                        TabImptosDctos(i).IndAplic := TRUE;
                        bRes := TRUE;
                END IF;
               END LOOP;
        END IF;
    END LOOP;

    RETURN bRes;

EXCEPTION
        WHEN OTHERS THEN
                V_DesErr := '>> ERROR INESPERADO (19a2)';
                RETURN FALSE;
END fbValidaZonaEval;

/* ********************************************************************************************* */
/* (22)* APLICA LOS IMPUESTO A LOS DOCUMENTOS                       * */
/* ********************************************************************************************* */
FUNCTION fAplicaImptosDctos (Tab_FA_PRESUPUESTO IN OUT NOCOPY  TipTab_FA_PRESUPUESTO,
                             CODCATIMPOS        IN             GE_DATOSGENER.COD_CATIMPOS%TYPE)
    RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fAplicaImptosDctos"
      Lenguaje="PL/SQL"
      Fecha="09-03-2006"
      Versión="1.0"
      Diseñador="Rodrigo Arzola O."
      Programador="Rodrigo Arzola O."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Aplica impuestos a documentos validados </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="Tab_FA_PRESUPUESTO" Tipo="TipTab_FA_PRESUPUESTO">Arreglo con los conceptos del dcto</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
ERROR_GET_COLUMNA       EXCEPTION;

i       PLS_INTEGER:= 0;
J       PLS_INTEGER:= 0;
x       PLS_INTEGER:= 0;
dTotalNeto FA_PRESUPUESTO.IMP_FACTURABLE%TYPE := 0;
BEGIN
    -- dbms_output.put_line('>> rao    0001   '||TabImptosDctos.COUNT );
    IF (TabImptosDctos.COUNT > 0) THEN

        FOR i IN TabImptosDctos.FIRST .. TabImptosDctos.LAST LOOP
            /* XO-200607241178 FAAR 20060725 SE AGREGA CONDICION DE COMPARACION DE CATIMPOS*/
            IF  (NOT TabImptosDctos(i).IndAplic) AND (TabImptosDctos(i).COD_CATIMPOS = CODCATIMPOS ) THEN /* no se ha completado validacion del impto */
                FOR j IN TabImptosDctos(i).GruposServ.FIRST .. TabImptosDctos(i).GruposServ.LAST LOOP
                    IF (TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 0 AND  /* cliente  */
                        TabImptosDctos(i).IndEval1 = TRUE    AND
                        TabImptosDctos(i).IndEval2 = TRUE    AND
                        TabImptosDctos(i).IndEval3 = TRUE    )
                    OR (TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 1 AND /* cliente */
                        TabImptosDctos(i).IndEval1 = TRUE    AND
                        TabImptosDctos(i).IndEval2 = TRUE    )
                    OR (TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 2 AND  /* abonado */
                        TabImptosDctos(i).IndEval1 = TRUE    AND
                        TabImptosDctos(i).IndEval3 = TRUE    )
                    OR  (TabImptosDctos(i).IndEval1 = TRUE AND
                         TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 4) THEN /* ninguna */
                            TabImptosDctos(i).IndAplic := TRUE;
                    END IF;
                  END LOOP;
            END IF;
        END LOOP;
        -- dbms_output.put_line('>> rao    0002   ' );


        FOR i IN TabImptosDctos.FIRST .. TabImptosDctos.LAST LOOP
            IF  (TabImptosDctos(i).IndAplic) THEN /* Aplicable */
                j := Tab_FA_PRESUPUESTO.LAST + 1;  /* Agrego al final de la Tab_FA_PRESUPUESTO */
        -- dbms_output.put_line('>> rao    0003   ' );

                IF TabImptosDctos(i).TIP_VALOR = 'P' THEN  /* si el impuesto es porcentual */
                    FOR x IN Tab_FA_PRESUPUESTO.FIRST .. Tab_FA_PRESUPUESTO.LAST LOOP /* recorre factura + netos */
                        IF Tab_FA_PRESUPUESTO(x).COD_TIPCONCE IN (2,3) THEN  /* cargos + descuentos */
                            dTotalNeto := dTotalNeto + Tab_FA_PRESUPUESTO(x).IMP_FACTURABLE;
                        END IF;
                    END LOOP;
                    dTotalNeto  := (dTotalNeto * TabImptosDctos(i).IMP_FACTURABLE) / 100;
                    Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO  := TabImptosDctos(i).IMP_FACTURABLE;
                ELSE
                    dTotalNeto  := TabImptosDctos(i).IMP_FACTURABLE;
                    Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO  := 0;
                END IF;
                Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO  := dTotalNeto;
    -- dbms_output.put_line('>> rao    0004   ' );

                Tab_FA_PRESUPUESTO(j).COD_CONCEPTO      := TabImptosDctos(i).COD_CONCEPTO;
                Tab_FA_PRESUPUESTO(j).COLUMNA           := fGetColumna(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
    -- dbms_output.put_line('>> rao       '||Tab_FA_PRESUPUESTO(j).COD_CONCEPTO );
                IF Tab_FA_PRESUPUESTO(j).COLUMNA = -1  THEN
                   RAISE ERROR_GET_COLUMNA;
                END IF;

                Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE    := GE_PAC_GENERAL.REDONDEA( Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO, iNumDecimales, 0);
                Tab_FA_PRESUPUESTO(j).COD_MONEDA        := TabImptosDctos(i).COD_MONEDA;

    -- dbms_output.put_line('>> rao 0       ' );
                /* Valores comunes a todos los conceptos */
                Tab_FA_PRESUPUESTO(j).NUM_PROCESO       := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).NUM_PROCESO;
                Tab_FA_PRESUPUESTO(j).COD_CLIENTE       := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_CLIENTE;
                Tab_FA_PRESUPUESTO(j).NUM_VENTA         := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).NUM_VENTA;
                Tab_FA_PRESUPUESTO(j).NUM_TRANSACCION   := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).NUM_TRANSACCION;
                Tab_FA_PRESUPUESTO(j).COD_CATIMPOS      := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_CATIMPOS;
                Tab_FA_PRESUPUESTO(j).COD_PROVINCIA     := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_PROVINCIA;
                Tab_FA_PRESUPUESTO(j).COD_REGION        := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_REGION;
                Tab_FA_PRESUPUESTO(j).COD_CIUDAD        := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_CIUDAD;
                Tab_FA_PRESUPUESTO(j).COD_PRODUCTO      := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_PRODUCTO;
                Tab_FA_PRESUPUESTO(j).COD_MODULO        := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_MODULO;
                Tab_FA_PRESUPUESTO(j).COD_PLANCOM       := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_PLANCOM;
    -- dbms_output.put_line('>> rao 1       ' );
                /* Valores Constantes */
                Tab_FA_PRESUPUESTO(j).FEC_VALOR         := SYSDATE     ;
                Tab_FA_PRESUPUESTO(j).NUM_UNIDADES      := 1           ;
                Tab_FA_PRESUPUESTO(j).IND_ALTA          := 1           ;
                Tab_FA_PRESUPUESTO(j).IND_CUOTA         := 0           ;
                Tab_FA_PRESUPUESTO(j).NUM_CUOTAS        := 0           ;
                Tab_FA_PRESUPUESTO(j).ORD_CUOTA         := 0           ;
                Tab_FA_PRESUPUESTO(j).COD_PORTADOR      := 0           ;
                Tab_FA_PRESUPUESTO(j).COD_CICLFACT      := NULL        ;
                Tab_FA_PRESUPUESTO(j).FEC_EFECTIVIDAD   := SYSDATE     ;
                Tab_FA_PRESUPUESTO(j).FEC_VENTA         := SYSDATE     ;
                Tab_FA_PRESUPUESTO(j).VAL_DTO           := NULL        ;
                Tab_FA_PRESUPUESTO(j).TIP_DTO           := NULL        ;
                Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE     := 0       ;
                Tab_FA_PRESUPUESTO(j).IND_ESTADO        := 0           ;
                Tab_FA_PRESUPUESTO(j).COD_TIPCONCE      := 1           ;
                Tab_FA_PRESUPUESTO(j).COD_CONCEREL      := 0           ;
                Tab_FA_PRESUPUESTO(j).COLUMNA_REL       := 0           ;
                Tab_FA_PRESUPUESTO(j).FLAG_IMPUES       := 0           ;
                Tab_FA_PRESUPUESTO(j).FLAG_DTO          := 0           ;
                Tab_FA_PRESUPUESTO(j).IND_FACTUR        := 1           ;
    -- dbms_output.put_line('>> rao 1       ' );
            END IF;

        END LOOP;
    END IF;

    RETURN TRUE;

EXCEPTION
    WHEN ERROR_GET_COLUMNA       THEN
        V_DesErr := '>> ERROR AL OBTENER LA COLUMNA ';
        RETURN FALSE;

    WHEN OTHERS THEN
        V_DesErr := '>> ERROR INESPERADO (22a2)';
        RETURN FALSE;

END fAplicaImptosDctos;



/* ********************************************************************************************* */
/*  Obtiene la zona impositiva del abonado                       col-50001 Indra-jpena 20/05/05* */
/* ********************************************************************************************* */
FUNCTION fbGetCodZonaAbon (iNumAbonado  IN  FA_PRESUPUESTO.NUM_ABONADO%TYPE,
                           iCodZonaAbon OUT NOCOPY GE_ZONACIUDAD.COD_ZONAIMPO%TYPE,
                           EB_ApliImptoDcto OUT NOCOPY BOOLEAN  ) RETURN BOOLEAN IS
    ihCodZonaAbon   GE_ZONACIUDAD.COD_ZONAIMPO%TYPE := 0;
    vhCodRegion     GE_DIRECCIONES.COD_REGION%TYPE;
    vhCodCiudad     GE_DIRECCIONES.COD_CIUDAD%TYPE;
    vhCodProvincia  GE_DIRECCIONES.COD_PROVINCIA%TYPE;
    vhCodComuna     GE_DIRECCIONES.COD_COMUNA%TYPE;
    vhCodTipDirec   GA_DIRECUSUAR.COD_TIPDIRECCION%TYPE;
BEGIN
        V_NomProc  := 'fbGetCodZonaAbon    ';
        V_NomTabl  := 'GE_ZONACIUDAD'       ;
        V_TipAct   := '?'                   ;

        vhCodTipDirec := '2';

        SELECT A.COD_ZONAIMPO, B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD, B.COD_COMUNA
          INTO ihCodZonaAbon, vhCodRegion, vhCodProvincia, vhCodCiudad, vhCodComuna
        FROM GE_ZONACIUDAD A, GE_DIRECCIONES B,
             GA_DIRECUSUAR C, GA_ABOCEL D
        WHERE D.NUM_ABONADO      = iNumAbonado
          AND C.COD_USUARIO      = D.COD_USUARIO
          AND C.COD_TIPDIRECCION = vhCodTipDirec
          AND C.COD_DIRECCION    = B.COD_DIRECCION
          AND A.COD_REGION       = B.COD_REGION
          AND A.COD_PROVINCIA    = B.COD_PROVINCIA
          AND A.COD_CIUDAD       = B.COD_CIUDAD
          AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA;

        iCodZonaAbon := ihCodZonaAbon ;

        EB_ApliImptoDcto := fbValidaZonaEval (TO_CHAR(iCodZonaAbon), 0, TRUE, vhCodRegion, vhCodProvincia);
        EB_ApliImptoDcto := fbValidaZonaEval (vhCodProvincia, 1, TRUE, vhCodRegion, vhCodProvincia);
        EB_ApliImptoDcto := fbValidaZonaEval (vhCodRegion, 2, TRUE, vhCodRegion, vhCodProvincia);
        EB_ApliImptoDcto := fbValidaZonaEval (vhCodCiudad, 3, TRUE, vhCodRegion, vhCodProvincia);
        EB_ApliImptoDcto := fbValidaZonaEval (vhCodComuna, 4, TRUE, vhCodRegion, vhCodProvincia);

        RETURN TRUE ;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                iCodZonaAbon := 0;
                RETURN TRUE ;
        WHEN OTHERS THEN
                -- dbms_output.put_line('fbGetCodZonaAbon:OTHERS');
                V_DesErr := '>> ERROR INESPERADO ( ?.)';
                RETURN FALSE ;
END fbGetCodZonaAbon;
/* *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/

/* ********************************************************************************************* */
/* (19)* OBTIENE LOS IMPUESTOS A LOS DOCUMENTOS                                                * */
/* ********************************************************************************************* */
PROCEDURE fbGetImptosDctos IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fbGetImptosDctos"
      Lenguaje="PL/SQL"
      Fecha="09-03-2006"
      Versión="1.0"
      Diseñador="Rodrigo Arzola O."
      Programador="Rodrigo Arzola O."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtinene la configuracion de los impuestos a documentos </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
i  PLS_INTEGER:= 0;
J  PLS_INTEGER:= 0;
/* XO-200607241178 FAAR 20060725  SE AGREGA EL COD_CATIMPOS AL SELECT */
CURSOR cIMPTOSDCTOS IS
       SELECT A.COD_CONCEPTO, A.COD_ZONACARGO, A.TIP_ZONACARGO, A.TIP_EVALUACION, A.IMP_FACTURABLE,
              A.TIP_VALOR, A.COD_GRPSERVI, B.COD_MONEFACT, A.COD_REGION, A.COD_PROVINCIA, A.COD_CATIMPOS
         FROM FA_IMPTODCTOS_TD A , FA_DATOSGENER B
        WHERE SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
        ORDER BY A.COD_CONCEPTO, A.COD_ZONACARGO, A.TIP_ZONACARGO, A.TIP_EVALUACION, A.IMP_FACTURABLE,
              A.TIP_VALOR;

BEGIN
        V_NomProc   := 'fbGetImptosDctos          ';
        V_NomTabl   := 'FA_IMPTODCTOS_TD'        ;
        V_TipAct    := 'S'                       ;

        i := 0;
        j := 0;
        -- dbms_output.put_line('>> rao   ---1   ' );

        FOR rRegImptoDcto IN cIMPTOSDCTOS LOOP
        -- dbms_output.put_line('>> rao   ---2   '|| rRegImptoDcto.COD_CONCEPTO ||'|'||TabImptosDctos(i).COD_CONCEPTO);
           if i = 0 THEN
                i := 1;
                TabImptosDctos(i).COD_CONCEPTO    := rRegImptoDcto.COD_CONCEPTO;
                TabImptosDctos(i).COD_MONEDA      := rRegImptoDcto.COD_MONEFACT;
                TabImptosDctos(i).TIP_VALOR       := rRegImptoDcto.TIP_VALOR;
                TabImptosDctos(i).IMP_FACTURABLE  := rRegImptoDcto.IMP_FACTURABLE;
                /* XO-200607241178 FAAR 20060725 SE AGREGA EL DATO EN LA ESTRUCTURA */
                TabImptosDctos(i).COD_CATIMPOS    := rRegImptoDcto.COD_CATIMPOS;
                j := 0;
            end if;

            if TabImptosDctos(i).COD_CONCEPTO != rRegImptoDcto.COD_CONCEPTO then
                i := i +1;
                TabImptosDctos(i).COD_CONCEPTO    := rRegImptoDcto.COD_CONCEPTO;
                TabImptosDctos(i).COD_MONEDA      := rRegImptoDcto.COD_MONEFACT;
                TabImptosDctos(i).TIP_VALOR       := rRegImptoDcto.TIP_VALOR;
                TabImptosDctos(i).IMP_FACTURABLE  := rRegImptoDcto.IMP_FACTURABLE;
                /* XO-200607241178 FAAR 20060725 SE AGREGA EL DATO EN LA ESTRUCTURA */
                TabImptosDctos(i).COD_CATIMPOS    := rRegImptoDcto.COD_CATIMPOS;
                j := 0;
            END IF ;

            j:= j + 1;

            TabImptosDctos(i).GruposServ(j).COD_ZONACARGO   := rRegImptoDcto.COD_ZONACARGO;
            TabImptosDctos(i).GruposServ(j).TIP_ZONACARGO   := rRegImptoDcto.TIP_ZONACARGO;
            TabImptosDctos(i).GruposServ(j).TIP_EVALUACION  := rRegImptoDcto.TIP_EVALUACION;
            TabImptosDctos(i).GruposServ(j).COD_REGION      := rRegImptoDcto.COD_REGION;
            TabImptosDctos(i).GruposServ(j).COD_PROVINCIA   := rRegImptoDcto.COD_PROVINCIA;
            TabImptosDctos(i).GruposServ(j).COD_GRPSERVI     := rRegImptoDcto.COD_GRPSERVI;
        END LOOP;


EXCEPTION
        WHEN NO_DATA_FOUND THEN
                -- dbms_output.put_line('>> NO DATA FOUND ' );
                V_DesErr := '>> NO DATA FOUND (19a2)';
        WHEN OTHERS THEN
                V_DesErr := '>> ERROR INESPERADO (19a2)';
END fbGetImptosDctos;


/* ********************************************************************************************* */
/* (20)* VALIDA LOS GRUPOS DE SERVICIO DE LOS IMPUESTOS A LOS DOCUMENTOS                       * */
/* ********************************************************************************************* */
FUNCTION fbValidaGrpServ (EV_cod_GrpServi IN FA_IMPTODCTOS_TD.COD_GRPSERVI%TYPE)
    RETURN BOOLEAN IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fbValidaGrpServ"
      Lenguaje="PL/SQL"
      Fecha="09-03-2006"
      Versión="1.0"
      Diseñador="Rodrigo Arzola O."
      Programador="Rodrigo Arzola O."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtinene la configuracion de los impuestos a documentos </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_GrpServi" Tipo="STRING">Codigo del grupo de servicio</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

i  PLS_INTEGER:= 0;
J  PLS_INTEGER:= 0;
bRes BOOLEAN := FALSE;

BEGIN
    FOR i IN TabImptosDctos.FIRST .. TabImptosDctos.LAST LOOP
        IF  (NOT TabImptosDctos(i).IndAplic) THEN /* no se ha completado validacion del impto */
            FOR j IN TabImptosDctos(i).GruposServ.FIRST .. TabImptosDctos(i).GruposServ.LAST LOOP
                IF TabImptosDctos(i).GruposServ(j).COD_GRPSERVI = EV_cod_GrpServi THEN
                    TabImptosDctos(i).IndEval1 := TRUE;
                    IF TabImptosDctos(i).GruposServ(j).TIP_EVALUACION = 4 THEN/* no se evaluan zonas */
                        TabImptosDctos(i).IndAplic := TRUE;
                    END IF;
                    bRes := TRUE;
                END IF;
            END LOOP;
         END IF;
    END LOOP;

    RETURN bRes;

EXCEPTION
        WHEN OTHERS THEN
                V_DesErr := '>> ERROR INESPERADO (19a2)';
                RETURN FALSE;
END fbValidaGrpServ;
/* ********************************************************************************************* */
/* (12)* CARGA LOS IMPUESTOS EXISTENTES EN LA PREFACTURA (TAB_FA_PRESUPUESTO)                    */
/* ********************************************************************************************* */
PROCEDURE ObtieneImporteDscto( EN_ULT_REG IN PLS_INTEGER,  TAB_FA_PRESUPUESTO IN    TipTab_FA_PRESUPUESTO,
                                                     en_num_abonado IN FA_PRESUPUESTO.NUM_ABONADO%TYPE, 
                                                         en_cod_concepto IN FA_PRESUPUESTO.COD_CONCEPTO%TYPE,
                                                          en_columna IN FA_PRESUPUESTO.COLUMNA%TYPE,
                                                           sn_monto_descuento OUT NOCOPY NUMBER) IS
BEGIN
    sn_monto_descuento:= 0;
 
    FOR x IN Tab_FA_PRESUPUESTO.first..EN_ULT_REG
    LOOP
         if (NVL(tab_fa_presupuesto(x).num_abonado,0) = NVL(en_num_abonado,0) AND
             tab_fa_presupuesto(x).cod_concerel = en_cod_concepto AND
             tab_fa_presupuesto(x).columna_rel = en_columna AND
             tab_fa_presupuesto(x).cod_tipconce = 2 ) THEN
                sn_monto_descuento := sn_monto_descuento + tab_fa_presupuesto(x).imp_concepto;
                --  exit;
         END IF;
                                
    END LOOP;
END;
FUNCTION TotalizaConceptosXAbonado(LN_ULT_REG IN PLS_INTEGER,ln_indice IN NUMBER, TAB_FA_PRESUPUESTO IN   TipTab_FA_PRESUPUESTO, ST_CONCEPTOS_AGRUP_ABON  IN OUT NOCOPY TipTab_CONCEPTOS_AGRUP_ABON) RETURN BOOLEAN
AS
LN_num_abonado GA_ABOCEL.NUM_ABONADO%TYPE;
ln_importe number;
BEGIN
 
  --  for i IN TAB_FA_PRESUPUESTO.FIRST..TAB_FA_PRESUPUESTO.LAST
   -- LOOP
 
        LN_num_abonado := NVL(TAB_FA_PRESUPUESTO(ln_indice).NUM_ABONADO,0);
 
         IF ST_CONCEPTOS_AGRUP_ABON.EXISTS(LN_num_abonado) THEN
 
             ST_CONCEPTOS_AGRUP_ABON(LN_num_abonado).imp_total :=ST_CONCEPTOS_AGRUP_ABON(LN_num_abonado).imp_total +  TAB_FA_PRESUPUESTO(ln_indice).imp_concepto;
         ELSE
 
             ST_CONCEPTOS_AGRUP_ABON(LN_num_abonado).imp_total := TAB_FA_PRESUPUESTO(ln_indice).imp_concepto;
         END IF;
 --   END LOOP;
       ObtieneImporteDscto(LN_ULT_REG,   TAB_FA_PRESUPUESTO, LN_num_abonado,  TAB_FA_PRESUPUESTO(ln_indice).cod_concepto,
                                                         TAB_FA_PRESUPUESTO(ln_indice).columna,
                                                         ln_importe) ;

         ST_CONCEPTOS_AGRUP_ABON(LN_num_abonado).imp_total :=  ST_CONCEPTOS_AGRUP_ABON(LN_num_abonado).imp_total + ln_importe;                                                 
    RETURN TRUE;
EXCEPTION
        WHEN OTHERS THEN
                 V_DesErr := '>> ERROR INESPERADO TOTALIZANDO CONCEPTOS';
                RETURN FALSE;
END;


PROCEDURE CargaImptos (TAB_FA_PRESUPUESTO IN OUT NOCOPY  TipTab_FA_PRESUPUESTO
                      ,CODZONAIMPO        IN GE_ZONACIUDAD.COD_ZONAIMPO%TYPE
                      ,CODCATIMPOS        IN GE_DATOSGENER.COD_CATIMPOS%TYPE
                      ,VP_PROC            IN OUT NOCOPY VARCHAR2    /* En que parte del proceso estoy*/
                      ,VP_TABLA           IN OUT NOCOPY VARCHAR2    /* En que tabla estoy trabajando*/
                      ,VP_ACT             IN OUT NOCOPY VARCHAR2    /* Que accion estoy ejecutando*/
                      ,VP_SQLCODE         IN OUT NOCOPY VARCHAR2    /* sqlcode*/
                      ,VP_SQLERRM         IN OUT NOCOPY VARCHAR2    /* sqlerrm*/
                      ,VP_ERROR           IN OUT NOCOPY VARCHAR2    /* Error enviando por nosotros u otro.*/
) IS
i                       PLS_INTEGER;
j                       PLS_INTEGER;
k                       PLS_INTEGER;
ihPrimerRegIva          PLS_INTEGER;
dhAcumIva               FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;
dhSumIva                FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;
dhDifIva                FA_PRESUPUESTO.IMP_FACTURABLE%TYPE ;
ihCodZonaAbon           GE_ZONACIUDAD.COD_ZONAIMPO%TYPE;
Fin_Cpto                PLS_INTEGER := 0;
VP_DESCERR              VARCHAR2(80) := NULL;
iMinAjuste              NUMBER       :=0;
GV_CodProvincia    GE_DIRECCIONES.COD_PROVINCIA%TYPE;
GV_CodRegion       GE_DIRECCIONES.COD_REGION%TYPE;
GV_CodCiudad       GE_DIRECCIONES.COD_CIUDAD%TYPE;
GV_CodComuna       GE_DIRECCIONES.COD_COMUNA%TYPE;

ERROR_INICIALIZA        EXCEPTION;
ERROR_CALC_IMPTOS       EXCEPTION;
ERROR_GET_COLUMNA       EXCEPTION;
ERROR_GET_COD_GRP_SERVI EXCEPTION;
ERROR_GET_PRC_IMPUESTO  EXCEPTION;
ERROR_MINAJUSTE         EXCEPTION;
ERROR_DESCIEPS          EXCEPTION;
ERROR_IEPS              EXCEPTION;
ERROR_GET_ZONAIMP_ABON  EXCEPTION;
ERROR_ZONAIMP_NO_EXISTE EXCEPTION;

ERROR_APLI_IMPTOSDCTOS  EXCEPTION;
ERROR_GET_IMPTOSDCTOS   EXCEPTION;

ERROR_TOTALIZA_CONCEP EXCEPTION;  /*P-CSR-12019*/

status                  BOOLEAN;

iConcDescIEPS           PLS_INTEGER;
iConcIEPS               PLS_INTEGER;
bApliImptoDcto          BOOLEAN := FALSE;

lhCodCliente             GA_DIRECCLI.COD_CLIENTE%TYPE;
vhCodTipDirec             GA_DIRECCLI.COD_TIPDIRECCION%TYPE;

LT_CONCEPTOS_AGRUP_ABON   TipTab_CONCEPTOS_AGRUP_ABON;  /*P-CSR-12019*/
LT_IMPUESTO_ACUM                 TipTab_IMPUESTO_ACUM;  /*P-CSR-12019*/
LT_CONCEPTOS_APLICA_IMPTO_CR  TipTab_FA_PRESUPUESTO; /*P-CSR-12019*/
LT_imtos_CR                   TipTab_Impuestos; /*P-CSR-12019*/
ln_monto_descuento   number; /*P-CSR-12019*/
ln_importe_neto        number; /*P-CSR-12019*/
ln_monto_base          number := 0;
vpAbonadoAnt            NUMBER :=-1;
ind NUMBER := 0;
ln_importe_conc number;
BEGIN
    V_NomProc   := 'CargaImptos             ';
    V_NomTabl   := 'Tab_FA_PRESUPUESTO'     ;
    VP_ACT      := 'I'                      ;
    dhACumIva   := 0;
    dhSumIva    := 0;
    dhDifIva    := 0;
    iConcDescIEPS:= 0;
    iConcIEPS    := 0;
    VP_ERROR := 0;
    -- DEBUG;
    ihPrimerRegIva := Tab_FA_PRESUPUESTO.LAST + 1;
    Fin_Cpto       := Tab_FA_PRESUPUESTO.LAST;
    
    -- dbms_output.put_line('>> NRO. DE CONCEPTOS      : [' || Fin_Cpto     || ']' );
    -- dbms_output.put_line('>> ZONA IMPOSITIVA        : [' || CODZONAIMPO  || ']' );
    -- dbms_output.put_line('>> CATEGORIA IMPOSITIVA   : [' || CODCATIMPOS  || ']' );
    
    
    IF NOT fbInicializa THEN
        RAISE ERROR_INICIALIZA ;
    END IF;

    fbGetImptosDctos ;

--    IF NOT fbGetImptosDctos THEN
--      RAISE ERROR_GET_IMPTOSDCTOS;
--    END IF;

    /* Evalua zonas de cargo Imptos. Dctos para el cliente*/

    lhCodCliente := Tab_FA_PRESUPUESTO(Tab_FA_PRESUPUESTO.FIRST).COD_CLIENTE;
    vhCodTipDirec := '1';
 
    SELECT B.COD_PROVINCIA, B.COD_REGION, B.COD_CIUDAD, B.COD_COMUNA
      INTO GV_CodProvincia, GV_CodRegion, GV_CodCiudad, GV_CodComuna
    FROM GE_DIRECCIONES B, GA_DIRECCLI C
    WHERE C.COD_CLIENTE      = lhCodCliente
      AND C.COD_TIPDIRECCION = vhCodTipDirec
      AND C.COD_DIRECCION    = B.COD_DIRECCION;
 
    bApliImptoDcto := fbValidaZonaEval (TO_CHAR(CODZONAIMPO), 0, FALSE, GV_CodRegion, GV_CodProvincia);
    bApliImptoDcto := fbValidaZonaEval (GV_CodProvincia, 1, FALSE, GV_CodRegion, GV_CodProvincia);
    bApliImptoDcto := fbValidaZonaEval (GV_CodRegion, 2, FALSE, GV_CodRegion, GV_CodProvincia);
    bApliImptoDcto := fbValidaZonaEval (GV_CodCiudad, 3, FALSE, GV_CodRegion, GV_CodProvincia);
    bApliImptoDcto := fbValidaZonaEval (GV_CodComuna, 4, FALSE, GV_CodRegion, GV_CodProvincia);
    /* *********************************** */
 
  /*P-CSR-12019*/
    LT_CONCEPTOS_AGRUP_ABON.DELETE;
 
    LT_IMPUESTO_ACUM.DELETE;
 

   /*FIN P-CSR-12019*/
 
    FOR i IN Tab_FA_PRESUPUESTO.FIRST .. Fin_Cpto LOOP
        IF NOT fbGetCodGrpServicios (Tab_FA_PRESUPUESTO(i).COD_CONCEPTO) THEN
            -- dbms_output.put_line('error');
            RAISE ERROR_GET_COD_GRP_SERVI;
        ELSE
            Tab_Impuestos.DELETE;
            IF vpAbonadoAnt != NVL(Tab_FA_PRESUPUESTO(i).NUM_ABONADO,-2) THEN -- SAAM-20061204, se incluye NVL, XO-200611281268
                IF NVL(Tab_FA_PRESUPUESTO(i).NUM_ABONADO,0) = 0 or FA_ES_ABONADO_PREPAGO_FN (Tab_FA_PRESUPUESTO(i).NUM_ABONADO) THEN
                    ihCodZonaAbon:=CODZONAIMPO; --Abonado 0 asume la zona impositiva del cliente IGUAL QUE PREPAGO
                ELSE
       
                    IF NOT fbGetCodZonaAbon (Tab_FA_PRESUPUESTO(i).NUM_ABONADO,ihCodZonaAbon, bApliImptoDcto) THEN
                        RAISE ERROR_GET_ZONAIMP_ABON;
                    ELSE
                        IF ihCodZonaAbon = 0 THEN
                           RAISE ERROR_ZONAIMP_NO_EXISTE;
                        END IF;
                    END IF;
                END IF;
                vpAbonadoAnt := NVL(Tab_FA_PRESUPUESTO(i).NUM_ABONADO,-1); -- SAAM-20061204, se incluye NVL, XO-200611281268
            END IF;

            bApliImptoDcto := fbValidaGrpServ (ihCodGrpServi);
 
            IF NOT fbGetImpuestos(CODCATIMPOS, CODZONAIMPO, ihCodZonaAbon, Tab_Impuestos) THEN
    
                RAISE ERROR_GET_PRC_IMPUESTO;
            ELSE

                IF Tab_Impuestos.COUNT > 0 THEN
                    FOR k IN Tab_Impuestos.FIRST .. Tab_Impuestos.LAST LOOP
                        
                        --if  (not ( Tab_FA_PRESUPUESTO(i).cod_tipconce = 2 and (Tab_Impuestos(k).imp_umbral >0 or Tab_Impuestos(k).imp_maximo > 0)) )then
                          
                          IF  Tab_Impuestos(k).imp_umbral =0 or Tab_Impuestos(k).imp_maximo = 0 then
                           
                              j := Tab_FA_PRESUPUESTO.LAST + 1;  /* Agrego al final de la Tab_FA_PRESUPUESTO */
                            /* Se copian todos los campos desde el origen  */
                            Tab_FA_PRESUPUESTO(j) := Tab_FA_PRESUPUESTO(i);
                            /**********************************************/
                            /* Valores Constantes */
                            Tab_FA_PRESUPUESTO(j).IND_ALTA          := 1                                    ;
                            Tab_FA_PRESUPUESTO(j).IND_CUOTA         := 0                                    ;
                            Tab_FA_PRESUPUESTO(j).NUM_CUOTAS        := 0                                    ;
                            Tab_FA_PRESUPUESTO(j).ORD_CUOTA         := 0                                    ;
                            Tab_FA_PRESUPUESTO(j).COD_PORTADOR      := 0                                    ;
                            Tab_FA_PRESUPUESTO(j).COD_CICLFACT      := NULL                                 ;
                            /* Valores Variables Independientes del FLAG */
                            Tab_FA_PRESUPUESTO(j).FEC_EFECTIVIDAD   := SYSDATE                              ;
                            Tab_FA_PRESUPUESTO(j).FEC_VENTA         := SYSDATE                              ;
                            /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
                            Tab_FA_PRESUPUESTO(j).VAL_DTO           := NULL                                 ;
                            Tab_FA_PRESUPUESTO(j).TIP_DTO           := NULL                                 ;
                            /* Valores Variables Independientes del FLAG y Dependientes de la Tabla de Ventas */
                            /* Valores Variables Independientes del FLAG y GLOBALES */
                            Tab_FA_PRESUPUESTO(j).COD_CATIMPOS      := CODCATIMPOS                        ;
                            /* Valores Variables Dependientes del FLAG */
                            Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE     := Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO   ;
                            Tab_FA_PRESUPUESTO(j).IND_ESTADO        := 0                                    ;
                            Tab_FA_PRESUPUESTO(j).COD_TIPCONCE      := 1                                    ;
                            Tab_FA_PRESUPUESTO(j).COD_CONCEREL      := Tab_FA_PRESUPUESTO(i).COD_CONCEPTO   ;
                            Tab_FA_PRESUPUESTO(j).COLUMNA_REL       := Tab_FA_PRESUPUESTO(i).COLUMNA        ;
                            Tab_FA_PRESUPUESTO(j).FLAG_IMPUES       := 0                                    ;
                            Tab_FA_PRESUPUESTO(j).FLAG_DTO          := 0                                    ;
                             Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO      := fdCalcImptos(Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE, Tab_Impuestos(k).PRC_IMPUESTO,Tab_Impuestos(k).TIP_MONTO);
                             
                             --=======================
                             Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE    := GE_PAC_GENERAL.REDONDEA( Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO, iNumDecimales, 0);

                            Tab_FA_PRESUPUESTO(j).COD_CONCEPTO      := Tab_Impuestos(k).COD_CONCIMPTO;
                            Tab_FA_PRESUPUESTO(j).COLUMNA           := fGetColumna(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
                            IF Tab_FA_PRESUPUESTO(j).COLUMNA = -1  THEN
                                RAISE ERROR_GET_COLUMNA;
                            END IF;

                            Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO := Tab_Impuestos(k).PRC_IMPUESTO;

                            IF  Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO > 0 THEN

                                Tab_FA_PRESUPUESTO(i).FLAG_IMPUES  := 1 ; /* EL CONCEPTO (RELACIONADO) ESTA AFECTO  */
                                dhSumIva := dhSumIva + Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE;

                                /* RAO100402: SE ACUMULAN LOS TOTALES POR IMPUESTO */
                                status := fbAcumTotImptos(Tab_FA_PRESUPUESTO(i).COD_CONCEPTO,
                                                          Tab_FA_PRESUPUESTO(j).COD_CONCEPTO,
                                                          Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO,
                                                          Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE,
                                                          Tab_FA_PRESUPUESTO(i).IMP_FACTURABLE,
                                                          Tab_Impuestos(k).TIP_MONTO,
                                                          Tab_FA_PRESUPUESTO(i).NUM_UNIDADES);
                                IF NOT status THEN
                                    V_DesErr := 'Error en la acumulacion de Imptos. ';
                                END IF;
                            END IF;
                            ELSE 
                               IF Tab_FA_PRESUPUESTO(i).cod_tipconce = 3 THEN
                                  ind := ind +1;
                                  LT_CONCEPTOS_APLICA_IMPTO_CR(ind) := Tab_FA_PRESUPUESTO(i);
                                  LT_imtos_CR(ind) := Tab_Impuestos(k);
                                  LT_CONCEPTOS_APLICA_IMPTO_CR(ind).COD_CATIMPOS      := CODCATIMPOS ;
                                  IF NOT TotalizaConceptosXAbonado(FIN_cpto,i,TAB_FA_PRESUPUESTO, LT_CONCEPTOS_AGRUP_ABON) THEN
                                      RAISE ERROR_TOTALIZA_CONCEP;
                                 END IF;
							   END IF;
                                /*ObtieneImporteDscto(Tab_FA_PRESUPUESTO, Tab_FA_PRESUPUESTO(i).num_abonado ,
                                                                 Tab_FA_PRESUPUESTO(i).cod_concepto,
                                                                 Tab_FA_PRESUPUESTO(i).columna,
                                                                  ln_monto_descuento);
                              ln_importe_neto :=Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO +  ln_monto_descuento;
 
                                  
                                  Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO      :=  fdCalcImptosUmbral(Tab_Impuestos(k).COD_CONCIMPTO, ln_importe_neto, Tab_Impuestos(k).PRC_IMPUESTO,Tab_Impuestos(k).TIP_MONTO,
                                                                                                           Tab_FA_PRESUPUESTO(j).NUM_ABONADO, Tab_Impuestos(k).imp_maximo, Tab_Impuestos(k).imp_umbral,
                                                                                                           LT_CONCEPTOS_AGRUP_ABON, LT_IMPUESTO_ACUM, ln_monto_base);
                                   IF Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO = -1 THEN
                                        RAISE ERROR_CALC_IMPTOS;
                                   END IF;
                                     Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE     := ln_monto_base;
                                     */
                            END IF;
                            /* PPV 12/12/2006 inc HO-200612110248 Se homologa incidencia 35905*/
                            /*IF Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO = -1 THEN
                                RAISE ERROR_CALC_IMPTOS;
                            END IF;*/

                            
                     --   END IF;
                    END LOOP;
                END IF ;
            END IF;
        END IF;
        
    END LOOP;
  
    IF LT_CONCEPTOS_APLICA_IMPTO_CR.COUNT > 0 THEN
            FOR i IN LT_CONCEPTOS_APLICA_IMPTO_CR.FIRST .. LT_CONCEPTOS_APLICA_IMPTO_CR.LAST LOOP
                  ObtieneImporteDscto(Fin_Cpto,Tab_FA_PRESUPUESTO, LT_CONCEPTOS_APLICA_IMPTO_CR(i).num_abonado ,
                                                 LT_CONCEPTOS_APLICA_IMPTO_CR(i).cod_concepto,
                                                 LT_CONCEPTOS_APLICA_IMPTO_CR(i).columna,
                                                  ln_monto_descuento);
                ln_importe_neto :=LT_CONCEPTOS_APLICA_IMPTO_CR(i).IMP_CONCEPTO +  ln_monto_descuento;
               
                ln_importe_conc      :=  fdCalcImptosUmbral(LT_imtos_CR(i).COD_CONCIMPTO, ln_importe_neto, LT_imtos_CR(i).PRC_IMPUESTO,LT_imtos_CR(i).TIP_MONTO,
                                                                              LT_CONCEPTOS_APLICA_IMPTO_CR(i).NUM_ABONADO, LT_imtos_CR(i).imp_maximo, LT_imtos_CR(i).imp_umbral,
                                                                             LT_CONCEPTOS_AGRUP_ABON, LT_IMPUESTO_ACUM, ln_monto_base);
                         IF ln_importe_conc = -1 THEN
                            RAISE ERROR_CALC_IMPTOS;
                        END IF;
                if ln_importe_conc > 0 then                   
                j := Tab_FA_PRESUPUESTO.LAST + 1;  /* Agrego al final de la Tab_FA_PRESUPUESTO */
                /* Se copian todos los campos desde el origen  */
                Tab_FA_PRESUPUESTO(j) := LT_CONCEPTOS_APLICA_IMPTO_CR(i);
                        Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO := ln_importe_conc;
                /**********************************************/
                /* Valores Constantes */
                Tab_FA_PRESUPUESTO(j).IND_ALTA          := 1                                    ;
                Tab_FA_PRESUPUESTO(j).IND_CUOTA         := 0                                    ;
                Tab_FA_PRESUPUESTO(j).NUM_CUOTAS        := 0                                    ;
                Tab_FA_PRESUPUESTO(j).ORD_CUOTA         := 0                                    ;
                Tab_FA_PRESUPUESTO(j).COD_PORTADOR      := 0                                    ;
                Tab_FA_PRESUPUESTO(j).COD_CICLFACT      := NULL                                 ;
                /* Valores Variables Independientes del FLAG */
                Tab_FA_PRESUPUESTO(j).FEC_EFECTIVIDAD   := SYSDATE                              ;
                Tab_FA_PRESUPUESTO(j).FEC_VENTA         := SYSDATE                              ;
                /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
                Tab_FA_PRESUPUESTO(j).VAL_DTO           := NULL                                 ;
                Tab_FA_PRESUPUESTO(j).TIP_DTO           := NULL                                 ;
                /* Valores Variables Independientes del FLAG y Dependientes de la Tabla de Ventas */
                /* Valores Variables Independientes del FLAG y GLOBALES */
                        Tab_FA_PRESUPUESTO(j).COD_CATIMPOS      := LT_CONCEPTOS_APLICA_IMPTO_CR(i).COD_CATIMPOS  ;                      
                /* Valores Variables Dependientes del FLAG */
                Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE     := LT_CONCEPTOS_APLICA_IMPTO_CR(i).IMP_CONCEPTO   ;
                Tab_FA_PRESUPUESTO(j).IND_ESTADO        := 0                                    ;
                Tab_FA_PRESUPUESTO(j).COD_TIPCONCE      := 1                                    ;
                Tab_FA_PRESUPUESTO(j).COD_CONCEREL      := LT_CONCEPTOS_APLICA_IMPTO_CR(i).COD_CONCEPTO   ;
                Tab_FA_PRESUPUESTO(j).COLUMNA_REL       := LT_CONCEPTOS_APLICA_IMPTO_CR(i).COLUMNA        ;
                Tab_FA_PRESUPUESTO(j).FLAG_IMPUES       := 0                                    ;
                Tab_FA_PRESUPUESTO(j).FLAG_DTO          := 0                                    ;
                                     
                

                Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE     := ln_monto_base;
                Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE    := GE_PAC_GENERAL.REDONDEA( Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO, iNumDecimales, 0);
                Tab_FA_PRESUPUESTO(j).COD_CONCEPTO      := LT_imtos_CR(i).COD_CONCIMPTO;
                Tab_FA_PRESUPUESTO(j).COLUMNA           := fGetColumna(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
                IF Tab_FA_PRESUPUESTO(j).COLUMNA = -1  THEN
                    RAISE ERROR_GET_COLUMNA;
                END IF;

                Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO := LT_imtos_CR(i).PRC_IMPUESTO;

                IF  Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO > 0 THEN

                    Tab_FA_PRESUPUESTO(i).FLAG_IMPUES  := 1 ; /* EL CONCEPTO (RELACIONADO) ESTA AFECTO  */
                    dhSumIva := dhSumIva + Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE;

                    /* RAO100402: SE ACUMULAN LOS TOTALES POR IMPUESTO */
                    status := fbAcumTotImptos(LT_CONCEPTOS_APLICA_IMPTO_CR(i).COD_CONCEPTO,
                                              Tab_FA_PRESUPUESTO(j).COD_CONCEPTO,
                                              Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO,
                                              Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE,
                                              LT_CONCEPTOS_APLICA_IMPTO_CR(i).IMP_FACTURABLE,
                                              LT_imtos_CR(i).TIP_MONTO,
                                              LT_CONCEPTOS_APLICA_IMPTO_CR(i).NUM_UNIDADES);
                    IF NOT status THEN
                        V_DesErr := 'Error en la acumulacion de Imptos. ';
                    END IF;
                END IF;
                 end if;           
            END LOOP;
     END IF;

/*
    IF Tab_Impuestos.COUNT > 0 THEN
        IF NOT fbGetParMinAjuste (iMinAjuste) THEN
            RAISE ERROR_MINAJUSTE ;
        END IF;

        IF Tab_TotImptoAjustes.COUNT > 0 THEN

            FOR i IN nvl(Tab_TotImptoAjustes.FIRST,0) .. nvl(Tab_TotImptoAjustes.LAST,0) LOOP
                -- dbms_output.put_line('viene for:dentro');
                IF Tab_TotImptoAjustes(i).TOT_IMPTO > 0.0 then
                    IF Tab_TotImptoAjustes(i).TIP_MONTO = CPORCENTUAL THEN --PORCENTAJE
                        dhAcumIva := Tab_TotImptoAjustes(i).TOT_MTOBASE * (Tab_TotImptoAjustes(i).PRC_IMPUESTO / 100);
                    ELSE
                        dhAcumIva:= Tab_TotImptoAjustes(i).TOT_IMPTO;
                    END IF;
                END IF;
                dhAcumIva := GE_PAC_GENERAL.REDONDEA(dhAcumIva, iNumDecimales, 0);
                dhDifIva  := dhAcumIva - Tab_TotImptoAjustes(i).TOT_IMPTO;
                -- dbms_output.put_line('viene if');
                IF  dhDifIva != 0.0 AND ABS(dhDifIva) >= iMinAjuste THEN
                    FOR j IN ihPrimerRegIva .. Tab_FA_PRESUPUESTO.LAST LOOP
                        IF (Tab_FA_PRESUPUESTO(j).COD_CONCEPTO = Tab_TotImptoAjustes(i).COD_CONCIMPTO AND
                           Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO = Tab_TotImptoAjustes(i).PRC_IMPUESTO   AND
                           Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO != 0                                  ) AND
                          ((Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO > 0 AND dhDifIva < 0 AND (Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO + dhDifIva) >= 0) OR
                           (Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO < 0 AND dhDifIva > 0 AND (Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO + dhDifIva) <= 0) OR
                           (Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO > 0 AND dhDifIva > 0) OR
                           (Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO < 0 AND dhDifIva < 0))
                        THEN
                            Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO   := Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO + dhDifIva;
                            Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE := GE_PAC_GENERAL.REDONDEA((Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO), iNumDecimales, 0);
                            EXIT;
                        END IF;
                    END LOOP;
                END IF;
            END LOOP;
        END IF;
        -- dbms_output.put_line('fin de for');
       ---- dbms_output.PUT_LINEa2);
*/
       /***************************************/
       /*  Procesa Descuento Impuestos IEPS   */
       /***************************************/
--    -- dbms_output.put_line('viene fbGetFadParametro');
--       IF NOT fbGetFadParametro (103, iConcDescIEPS) THEN
--            -- dbms_output.put_line('marca raise eror para fadparametor 103,iConcDescIEPS('||iConcDescIEPS||')');
--          RAISE ERROR_DESCIEPS;
--       END IF;
--       -- dbms_output.put_line('viene iConcDescIEPS>0,iConcDescIEPS('||iConcDescIEPS||')');
--       IF iConcDescIEPS > 0 THEN
--        -- dbms_output.put_line('viene fbGetFadParametro');
--           IF NOT fbGetFadParametro (102, iConcIEPS) THEN
--                -- dbms_output.put_line('marca raise eror para fadparametor 102,iConcDescIEPS('||iConcDescIEPS||')');
--              RAISE ERROR_IEPS;
--           END IF;
--           -- dbms_output.put_line('viene for 3');
--           FOR i IN Tab_FA_PRESUPUESTO.FIRST .. Tab_FA_PRESUPUESTO.LAST LOOP
--               IF Tab_FA_PRESUPUESTO(i).COD_CONCEPTO =  iConcIEPS THEN
--                  j := Tab_FA_PRESUPUESTO.LAST + 1;  /* Agrego al final de la Tab_FA_PRESUPUESTO */
--                  /* Se copian todos los campos desde el origen  */
--                  Tab_FA_PRESUPUESTO(j) := Tab_FA_PRESUPUESTO(i);
--                  /**********************************************/
--                  /* Valores Constantes */
--                  Tab_FA_PRESUPUESTO(j).IND_ALTA          := 1                                    ;
--                  Tab_FA_PRESUPUESTO(j).IND_CUOTA         := 0                                    ;
--                  Tab_FA_PRESUPUESTO(j).NUM_CUOTAS        := 0                                    ;
--                  Tab_FA_PRESUPUESTO(j).ORD_CUOTA         := 0                                    ;
--                  Tab_FA_PRESUPUESTO(j).COD_PORTADOR      := 0                                    ;
--                  Tab_FA_PRESUPUESTO(j).COD_CICLFACT      := NULL                                 ;
--                  /* Valores Variables Independientes del FLAG */
--                  Tab_FA_PRESUPUESTO(j).FEC_EFECTIVIDAD   := SYSDATE                              ;
--                  Tab_FA_PRESUPUESTO(j).FEC_VENTA         := SYSDATE                              ;
--                  /* Valores Variables Independientes del FLAG y Dependientes de Tabla de Cargos */
--                  Tab_FA_PRESUPUESTO(j).VAL_DTO           := NULL                                 ;
--                  Tab_FA_PRESUPUESTO(j).TIP_DTO           := NULL                                 ;
--                  Tab_FA_PRESUPUESTO(j).COD_CATIMPOS      := CODCATIMPOS                        ;
--                  /* Valores Variables Dependientes del FLAG */
--                  Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE     := Tab_FA_PRESUPUESTO(i).IMP_CONCEPTO   ;
--                  Tab_FA_PRESUPUESTO(j).IND_ESTADO        := 0                                    ;
--                  Tab_FA_PRESUPUESTO(j).COD_TIPCONCE      := 2                                    ;
--                  Tab_FA_PRESUPUESTO(j).COD_CONCEREL      := Tab_FA_PRESUPUESTO(i).COD_CONCEPTO   ;
--                  Tab_FA_PRESUPUESTO(j).COLUMNA_REL       := Tab_FA_PRESUPUESTO(i).COLUMNA        ;
--                  Tab_FA_PRESUPUESTO(j).FLAG_IMPUES       := 0                                    ;
--                  Tab_FA_PRESUPUESTO(j).FLAG_DTO          := 0                                    ;
--
--                  Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO      := fdCalcImptos(Tab_FA_PRESUPUESTO(j).IMP_MONTOBASE,100,CPORCENTUAL);--ES POR EL TOTAL
--                  Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO      := Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO * -1;
--                  Tab_FA_PRESUPUESTO(j).IMP_FACTURABLE    := GE_PAC_GENERAL.REDONDEA( Tab_FA_PRESUPUESTO(j).IMP_CONCEPTO, iNumDecimales, 0);
--
--                  Tab_FA_PRESUPUESTO(j).COD_CONCEPTO      := iConcDescIEPS;
--                  Tab_FA_PRESUPUESTO(j).COLUMNA           := fGetColumna(Tab_FA_PRESUPUESTO(j).COD_CONCEPTO);
--                  Tab_FA_PRESUPUESTO(j).PRC_IMPUESTO      := 0;
--                  IF Tab_FA_PRESUPUESTO( j).COLUMNA = -1  THEN
--                     RAISE ERROR_GET_COLUMNA;
--                  END IF;
--               END IF;
--           END LOOP;
--       END IF;
--
--    END IF;

    IF NOT fAplicaImptosDctos (Tab_FA_PRESUPUESTO, CODCATIMPOS) THEN
        RAISE ERROR_APLI_IMPTOSDCTOS;
    END IF;


EXCEPTION
        WHEN UTL_FILE.WRITE_ERROR    THEN
             --dbms_output.put_line('error 1');
             SET_ERROR('Error de Escritura (F)',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN UTL_FILE.INTERNAL_ERROR THEN
            -- dbms_output.put_line('error 2');
             SET_ERROR('Error Interno (?) (G)',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_TOTALIZA_CONCEP    THEN
        -- dbms_output.put_line('error 2');
             SET_ERROR('>> ERROR AL INICIALIZAR ESTRUCTURAS',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_INICIALIZA        THEN
        -- dbms_output.put_line('error 2');
             SET_ERROR('>> ERROR AL INICIALIZAR ESTRUCTURAS',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_CALC_IMPTOS       THEN
          --    dbms_output.put_line('error 3');
             SET_ERROR('>> ERROR AL CALCULAR EL IMPUESTO ',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_GET_COLUMNA       THEN
         --     dbms_output.put_line('error 4');
             SET_ERROR('>> ERROR AL OBTENER LA COLUMNA ',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_GET_COD_GRP_SERVI THEN
           --   dbms_output.put_line('error 5');
             SET_ERROR('>> ERROR AL OBTENER CODIGO GRUPO SERVICIO ',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_GET_PRC_IMPUESTO  THEN
           --   dbms_output.put_line('error 6');
             SET_ERROR('>> ERROR AL OBTENER PARAMETROS DE IMPUESTO',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_MINAJUSTE         THEN
            --  dbms_output.put_line('error 7');
             SET_ERROR('>> ERROR AL OBTENER PARAMETRO MINIMO AJUSTE',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_DESCIEPS          THEN
           --   dbms_output.put_line('error 8');
             SET_ERROR('>> ERROR AL OBTENER PARAMETRO DESCUENTO IEPS',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_IEPS              THEN
          --    dbms_output.put_line('error 9');
             SET_ERROR('>> ERROR AL OBTENER PARAMETRO DESCUENTO IEPS',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_GET_ZONAIMP_ABON  THEN
           --  dbms_output.put_line('error 10');
             SET_ERROR('>> ERROR AL OBTENER ZONA IMPOSITIVA DE ABONADO',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_ZONAIMP_NO_EXISTE THEN
            -- dbms_output.put_line('error 11');
             SET_ERROR('>> ERROR , NO EXISTE ZONA IMPOSITIVA DE ABONADO',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_GET_IMPTOSDCTOS THEN
           --  dbms_output.put_line('error 12');
             SET_ERROR('>> ERROR AL OBTENER IMPUESTOS A DOCUMENTOS',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
        WHEN ERROR_APLI_IMPTOSDCTOS THEN
            --  dbms_output.put_line('error 13');
             SET_ERROR('>> ERROR AL APLICAR IMPUESTOS A DOCUMENTOS',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);

        WHEN OTHERS                  THEN
            --  dbms_output.put_line('error 14');
           --   dbms_output.put_line('SQL ERRO ' || SQLCODE);
           --   DBMS_OUTPUT.PUT_LINE('DES ERROR '|| SQLERRM);
             SET_ERROR('>> ERROR INESPERADO',VP_PROC ,VP_TABLA,VP_ACT,VP_SQLCODE
                                                 ,VP_SQLERRM,VP_ERROR,VP_DESCERR);
END CargaImptos;
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
/*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*/
BEGIN
     fallo          := FALSE;
     szError        := '?';
     Raya1          := '--------------------------------------------';
     Raya2          := '=================================================';
     Asteriscos     := '***********************';
END FA_PAC_IMPTOS ;
/
SHOW ERRORS
