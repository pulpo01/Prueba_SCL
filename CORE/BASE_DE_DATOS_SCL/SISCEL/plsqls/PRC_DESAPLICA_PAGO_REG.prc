CREATE OR REPLACE PROCEDURE PRC_DESAPLICA_PAGO_REG
(
        hNumRegularizacion         IN NUMBER           -- Numero de la Regularizacion
)
IS
---------------------------------------------------------------------------------------------
-- Version 2 : Propuesta de Cambio en Algoritmo de Desaplicacion de Pagos
-- Autor     : Roy Barrera Richards 06-Ene-2003
---------------------------------------------------------------------------------------------
-- declaracion de excepciones
---------------------------------------------------------------------------------------------
        ERROR_PROCESO  EXCEPTION ;
---------------------------------------------------------------------------------------------
-- Defincion de pseudo constantes para legibilidad del programa
---------------------------------------------------------------------------------------------
        COD_CAU_PAGO_REG           PLS_INTEGER   :=  50 ;                -- DES_CAU_PAGO_REG          VARCHAR2(40) := 'REGULARIZACION DE PAGOS' ;  -- cambiar tipo
        REG_PAGO_NO_APLICADO       PLS_INTEGER    :=  65 ;                -- ORI_NO_APLI               VARCHAR2(40) := 'REGULARIZACION PAGO NO APLICADO' ;
        REG_PAGO_DUPLICADO         PLS_INTEGER    :=  66 ;                -- ORI_DUPLI                 VARCHAR2(40) := 'REGULARIZACION PAGO DUPLICADO' ;
        REG_PAGO_MAL_APLICADO      PLS_INTEGER    :=  67 ;                -- ORI_MAL_APLI              VARCHAR2(40) := 'REGULARIZACION PAGO MAL APLICADO' ;
        REG_PAGO_MAYOR_VALOR       PLS_INTEGER    :=  68 ;                -- ORI_MAYOR_VAL             VARCHAR2(40) := 'REGULARIZACION PAGO MAYOR VALOR' ;
        DOC_DESAPLICA_PAGO_X_REG   PLS_INTEGER    :=  84 ;                --DOC_APLICA_PAGO_X_REG      NUMBER(2)    :=  83 ;
        DES_DESAPLICA_PAGO_X_REG   VARCHAR2(40) := 'REVERSA PAGO POR REGULARIZACION' ;  --DES_APLICA_PAGO_X_REG      VARCHAR2(40) := 'PAGO POR REGULARIZACION' ;
        CAJA_REGULARIZA            VARCHAR2(3)  := 'REG' ;              -- nuevo pago
        ES_ABONO                   PLS_INTEGER       := 2;
-- select cod_concepto into ES_ABONO from co_conceptos where cod_tipconce in ( select cod_tipconce from co_tipconcep where ind_abono = 1 )
---------------------------------------------------------------------------------------------
-- definicion de variables
---------------------------------------------------------------------------------------------
        I BINARY_INTEGER;
        hDescError VARCHAR2 (256);
        hCuenta NUMBER;
        hFecEfectividadOri      CO_PAGOS.FEC_EFECTIVIDAD%TYPE;
        hCodForPagoOri          CO_PAGOS.COD_FORPAGO%TYPE;
        hCodSisPagoOri          CO_PAGOS.COD_SISPAGO%TYPE;
        hNumComPago             CO_PAGOS.NUM_COMPAGO%TYPE;
        sCod_Plaza              CO_CARTERA.COD_PLAZA%TYPE;
        sPref_Plaza             CO_PAGOS.PREF_PLAZA%TYPE;
        hTipoRegulariza         CO_HIST_REGULARIZA.TIPO_REGULARIZA%TYPE;
        hFecRegulariza          CO_HIST_REGULARIZA.FEC_REGULARIZA%TYPE;
        hStsRegulariza          CO_HIST_REGULARIZA.STS_REGULARIZA%TYPE;
        hMontoRegulariza        CO_HIST_REGULARIZA.MONTO_REGULARIZA%TYPE;
        hNumDocRespaldo         CO_HIST_REGULARIZA.NUM_DOC_RESPALDO%TYPE;
        hCodClienteOri          CO_HIST_REGULARIZA.COD_CLIENTE_ORIGEN%TYPE;
        hNumSecuenciOri         CO_HIST_REGULARIZA.NUM_SECUENCI_ORIGEN%TYPE;
        hCodTipDocumOri         CO_HIST_REGULARIZA.COD_TIPDOCUM_ORIGEN%TYPE;
        hCodVendedorAgenteOri   CO_HIST_REGULARIZA.COD_VENDEDOR_AGENTE_ORIGEN%TYPE;
        hLetraOri               CO_HIST_REGULARIZA.COD_LETRA_ORIGEN%TYPE;
        hCodCentremiOri         CO_HIST_REGULARIZA.COD_CENTREMI_ORIGEN%TYPE;
        hFecPagoOri             CO_HIST_REGULARIZA.FEC_PAGO_ORIGEN%TYPE;
        hImportePagoOri         CO_HIST_REGULARIZA.IMPORTE_PAGO_ORIGEN%TYPE;
        hOperadoraOrigen        CO_HIST_REGULARIZA.COD_OPERADORA_SCL_ORI%TYPE;
        hPlazaOrigen            CO_HIST_REGULARIZA.COD_PLAZA_ORI%TYPE;
        hOperadoraDestino       CO_HIST_REGULARIZA.COD_OPERADORA_SCL_DEST%TYPE;
        hPlazaDestino           CO_HIST_REGULARIZA.COD_PLAZA_DEST%TYPE;
---------------------------------------------------------------------------------------------
        H_COD_TIPDOCREL         CO_PAGOSCONC.COD_TIPDOCREL%TYPE;
        H_NUM_SECUREL           CO_PAGOSCONC.NUM_SECUREL%TYPE;
        H_LETRA_REL             CO_PAGOSCONC.LETRA_REL%TYPE;
        H_COD_CONCEPTO          CO_PAGOSCONC.COD_CONCEPTO%TYPE;
        H_IMPORTE_DEBE          CO_CARTERA.IMPORTE_DEBE%TYPE;
        H_IMPORTE_HABER         CO_CARTERA.IMPORTE_HABER%TYPE;

		TN_numtransaccion		GA_TRANSACABO.NUM_TRANSACCION%TYPE;
		GN_indcarrier			PLS_INTEGER := 0;
		TN_retorno 				GA_TRANSACABO.COD_RETORNO%TYPE;
		TV_glosa				GA_TRANSACABO.DES_CADENA%TYPE;
---------------------------------------------------------------------------------------------
-- Definicion de Tabla (Matriz) de Trabajo Temporal para desaplicar un pago y todos sus documentos asociados
---------------------------------------------------------------------------------------------
        TYPE TipoRegistroRegulariza IS RECORD
        (
                COD_TIPDOCUM         CO_PAGOSCONC.COD_TIPDOCUM%TYPE,            -- NUMBER (2), NOT NULL
                NUM_SECUENCI         CO_PAGOSCONC.NUM_SECUENCI%TYPE,            -- NUMBER (8), NOT NULL
                COD_VENDEDOR_AGENTE  CO_PAGOSCONC.COD_VENDEDOR_AGENTE%TYPE,     -- NUMBER (6), NOT NULL
                LETRA                CO_PAGOSCONC.LETRA%TYPE,                   -- VARCHAR2 (1), NOT NULL
                COD_CENTREMI         CO_PAGOSCONC.COD_CENTREMI%TYPE,            -- NUMBER (4)
                COD_TIPDOCREL        CO_PAGOSCONC.COD_TIPDOCREL%TYPE,           -- NUMBER (2)
                NUM_SECUREL          CO_PAGOSCONC.NUM_SECUREL%TYPE,             -- NUMBER (8)
                COD_AGENTEREL        CO_PAGOSCONC.COD_AGENTEREL%TYPE,           -- NUMBER (6)
                LETRA_REL            CO_PAGOSCONC.LETRA_REL%TYPE,               -- VARCHAR2 (1)
                COD_CENTRREL         CO_PAGOSCONC.COD_CENTRREL%TYPE,            -- NUMBER (4)
                COD_CONCEPTO         CO_PAGOSCONC.COD_CONCEPTO%TYPE,            -- NUMBER (4)
                IMP_CONCEPTO         CO_PAGOSCONC.IMP_CONCEPTO%TYPE,            -- NUMBER (14,4), NOT NULL
                COLUMNA              CO_PAGOSCONC.COLUMNA%TYPE,                 -- NUMBER (4)
                NUM_ABONADO          CO_PAGOSCONC.NUM_ABONADO%TYPE,             -- NUMBER (8)
                COD_PRODUCTO         CO_PAGOSCONC.COD_PRODUCTO%TYPE,            -- NUMBER (1), NOT NULL
                FEC_CANCELACION      CO_PAGOSCONC.FEC_CANCELACION%TYPE,         -- DATE, DEFAULT SYSDATE
                UBICACION            VARCHAR2 (20),
                ORDEN                NUMBER (4), --Incidencia 205956 Soporte RyC 11-03-2015
                NUM_CUOTA            CO_PAGOSCONC.NUM_CUOTA%TYPE,               -- NUMBER (8)
                SEC_CUOTA            CO_PAGOSCONC.SEC_CUOTA%TYPE,               -- NUMBER (3)
                NUM_FOLIO            CO_PAGOSCONC.NUM_FOLIO%TYPE,               -- NUMBER (9)
                PREF_PLAZA                       CO_PAGOSCONC.PREF_PLAZA%TYPE,          -- VARCHAR(3)
                NUM_VENTA            CO_PAGOSCONC.NUM_VENTA%TYPE,               -- NUMBER (8)
                NUM_FOLIOCTC         CO_PAGOSCONC.NUM_FOLIOCTC%TYPE,            -- VARCHAR2 (11),  DEFAULT '0'
                NUM_TRANSACCION      CO_PAGOSCONC.NUM_TRANSACCION%TYPE,                 -- NUMBER (9)
                COD_OPERADORA_SCL    CO_PAGOSCONC.COD_OPERADORA_SCL%TYPE,               -- VARCHAR2(5)
                COD_PLAZA            CO_PAGOSCONC.COD_PLAZA%TYPE                        -- VARCHAR2(5)
        );
--
        TYPE TipoTablaAuxiliar   IS TABLE  OF  TipoRegistroRegulariza INDEX BY  BINARY_INTEGER;
--
        TABLA_DE_TRABAJO        TipoTablaAuxiliar;
---------------------------------------------------------------------------------------------
-- CURSOR : Todos los Documentos asociados al pago (Co_pagosconc, del mas viejo al mas nuevo)
---------------------------------------------------------------------------------------------
        CURSOR DOCS_ASOC_PAGO IS                                                -- parametros
        select * from
        (
                select
                        a.cod_tipdocum, a.num_secuenci, a.cod_vendedor_agente, a.letra, a.cod_centremi,
                        a.cod_tipdocrel, a.num_securel, a.cod_agenterel, a.letra_rel, a.cod_centrrel,
                        a.columna, a.cod_concepto, a.imp_concepto,
                        a.cod_producto, a.num_abonado, a.fec_cancelacion,
                        a.num_folio, a.pref_plaza, a.num_folioctc,  a.num_venta, a.num_transaccion,
                        a.num_cuota, a.sec_cuota, 'CO_CARTERA' as ubic, c.fec_efectividad,c.fec_vencimie,
                        a.cod_operadora_scl, a.cod_plaza
                        -- MARCA-- OPERADORA, PLAZA
                from
                        co_pagosconc a, co_pagos b,co_cartera c
                where
                        b.num_secuenci = hNumSecuenciOri --  Secuencia Pago a Desaplicar
                        and b.cod_tipdocum  = hCodTipDocumOri
                        and b.cod_vendedor_agente = hCodVendedorAgenteOri
                        and b.letra = hLetraOri
                        and b.cod_centremi = hCodCentremiOri
                        and b.cod_cliente = hCodClienteOri  --  Cod Cliente a Desaplicar
                        and a.num_secuenci=b.num_secuenci
                        and a.cod_tipdocum=b.cod_tipdocum
                        and a.cod_vendedor_agente = b.cod_vendedor_agente
                        and a.letra = b.letra
                        and a.cod_centremi = b.cod_centremi
                        and c.num_secuenci=a.num_securel
                        and c.cod_tipdocum=a.cod_tipdocrel
                        and c.cod_vendedor_agente = a.cod_agenterel
                        and c.letra = a.letra_rel
                        and c.cod_centremi = a.cod_centrrel
                        and c.cod_concepto = a.cod_concepto
                        and c.columna = a.columna
                UNION
                select
                        a.cod_tipdocum, a.num_secuenci, a.cod_vendedor_agente, a.letra, a.cod_centremi,
                        a.cod_tipdocrel, a.num_securel, a.cod_agenterel, a.letra_rel, a.cod_centrrel,
                        a.columna, a.cod_concepto, a.imp_concepto,
                        a.cod_producto, a.num_abonado, a.fec_cancelacion,
                        a.num_folio, a.pref_plaza, a.num_folioctc, a.num_venta, a.num_transaccion,
                        a.num_cuota, a.sec_cuota, 'CO_CANCELADOS' as ubic, c.fec_efectividad,c.fec_vencimie,
                        a.cod_operadora_scl, a.cod_plaza
                -- MARCA-- OPERADORA, PLAZA
                from
                        co_pagosconc a, co_pagos b,co_cancelados c
                where
                        b.num_secuenci = hNumSecuenciOri --  Secuencia Pago a Desaplicar
                        and b.cod_tipdocum  = hCodTipDocumOri
                        and b.cod_vendedor_agente = hCodVendedorAgenteOri
                        and b.letra = hLetraOri
                        and b.cod_centremi = hCodCentremiOri
                        and b.cod_cliente = hCodClienteOri  --  Cod Cliente a Desaplicar
                        and a.num_secuenci=b.num_secuenci
                        and a.cod_tipdocum=b.cod_tipdocum
                        and a.cod_vendedor_agente = b.cod_vendedor_agente
                        and a.letra = b.letra
                        and a.cod_centremi = b.cod_centremi
                        and c.num_secuenci=a.num_securel
                        and c.cod_tipdocum=a.cod_tipdocrel
                        and c.cod_vendedor_agente = a.cod_agenterel
                        and c.letra = a.letra_rel
                        and c.cod_centremi = a.cod_centrrel
                        and c.cod_concepto = a.cod_concepto
                        and c.columna = a.columna
        )
        order by fec_efectividad asc, fec_vencimie asc;
---------------------------------------------------------------------------------------------
-- CURSOR : Todos los Documentos asociados al ABONO (Co_pagosconc)
---------------------------------------------------------------------------------------------
        CURSOR DOCS_ASOC_ABONO IS                                               -- paramaetros
        SELECT
                COD_TIPDOCUM,    NUM_SECUENCI,   COD_VENDEDOR_AGENTE,   LETRA,          COD_CENTREMI,
                COD_TIPDOCREL,   NUM_SECUREL,    COD_AGENTEREL,         LETRA_REL,      COD_CENTRREL,
                COD_CONCEPTO,    IMP_CONCEPTO,   COLUMNA,
                NUM_ABONADO,     COD_PRODUCTO,   FEC_CANCELACION, COD_OPERADORA_SCL, COD_PLAZA,
                NUM_FOLIO,		 PREF_PLAZA,	 NUM_FOLIOCTC,	 		NUM_VENTA,		NUM_TRANSACCION,
                NUM_CUOTA,		 SEC_CUOTA
        FROM    CO_PAGOSCONC
        WHERE   COD_TIPDOCUM        = H_COD_TIPDOCREL
        AND     NUM_SECUENCI        = H_NUM_SECUREL
        AND     LETRA               = H_LETRA_REL ;
---------------------------------------------------------------------------------------------
-- SUBRUTINAS :
---------------------------------------------------------------------------------------------
        PROCEDURE  PRC_ESTADO_REGULARIZACION ( status IN char ) IS
        BEGIN
                UPDATE CO_HIST_REGULARIZA
                SET STS_REGULARIZA = status
                WHERE NUM_REGULARIZA = hNumRegularizacion;
                --COMMIT;
        EXCEPTION
                WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR (-20101,'Imposible cambiar estado de regularizacion n0 ' || hNumRegularizacion);
        END PRC_ESTADO_REGULARIZACION;
---------------------------------------------------------------------------------------------
-- PROGRAMA PRINCIPAL
---------------------------------------------------------------------------------------------
BEGIN
---------------------------------------------------------------------------------------------
-- Verificacisn de parametros
-- DBMS_OUTPUT.PUT_LINE('Numero regularizacion : '||to_char(hNumRegularizacion));
---------------------------------------------------------------------------------------------
        IF (  hNumRegularizacion  IS NULL )  THEN
                RAISE_APPLICATION_ERROR(-20101, 'No se especifics el nzmero de regularizacisn');
        END IF;
---------------------------------------------------------------------------------------------
-- Recupera datos de la regularizacion actual
---------------------------------------------------------------------------------------------
        SELECT
                TIPO_REGULARIZA,     FEC_REGULARIZA,      STS_REGULARIZA,      MONTO_REGULARIZA,  NUM_DOC_RESPALDO,       --datos regularizacisn
                COD_CLIENTE_ORIGEN,
                NUM_SECUENCI_ORIGEN, COD_TIPDOCUM_ORIGEN, COD_VENDEDOR_AGENTE_ORIGEN, COD_LETRA_ORIGEN, COD_CENTREMI_ORIGEN,       -- datos pago a desaplicar
                FEC_PAGO_ORIGEN, IMPORTE_PAGO_ORIGEN, COD_OPERADORA_SCL_ORI, COD_PLAZA_ORI
                -- MARCA-- OPERADORA_ORIGEN, PLAZA_ORIGEN
        INTO
                hTipoRegulariza , hFecRegulariza, hStsRegulariza , hMontoRegulariza , hNumDocRespaldo,
                hCodClienteOri,
                hNumSecuenciOri, hCodTipDocumOri, hCodVendedorAgenteOri, hLetraOri, hCodCentremiOri,
                hFecPagoOri,     hImportePagoOri, hOperadoraOrigen, hPlazaOrigen
        FROM CO_HIST_REGULARIZA
        WHERE NUM_REGULARIZA = hNumRegularizacion;
---------------------------------------------------------------------------------------------
-- Validacion de valores no nulables.
-- DBMS_OUTPUT.PUT_LINE('Tipo regularizacion : '||to_char(hTipoRegulariza));
-- DBMS_OUTPUT.PUT_LINE('Monto regularizacion : '||to_char(hMontoRegulariza));
-- DBMS_OUTPUT.PUT_LINE('Cliente : '||to_char(hCodClienteOri));
-- DBMS_OUTPUT.PUT_LINE('Secuencia Pago : '||to_char(hNumSecuenciOri));
-- DBMS_OUTPUT.PUT_LINE('Importe : '||to_char(hImportePagoOri));
-- DBMS_OUTPUT.PUT_LINE('Fecha : '||to_char(hFecPagoOri));
---------------------------------------------------------------------------------------------
        IF (hCodClienteOri    IS NULL OR           hNumSecuenciOri       IS NULL OR
                hCodTipDocumOri   IS NULL OR           hCodVendedorAgenteOri IS NULL OR
                hLetraOri         IS NULL OR           hCodCentremiOri       IS NULL OR
                hFecPagoOri       IS NULL OR           hImportePagoOri       IS NULL OR
                hOperadoraOrigen  IS NULL OR           hPlazaOrigen          IS NULL )
                -- MARCA-- OPERADORA_ORIGEN, PLAZA_ORIGEN
        THEN
                hDescError := 'Alguno de los parametros requeridos para desaplicar el pago es nulo.';
                RAISE ERROR_PROCESO ;
        END IF;
---------------------------------------------------------------------------------------------
        IF ( hTipoRegulariza = REG_PAGO_NO_APLICADO ) THEN
                hDescError := 'Tipo de regularizacisn no corresponde a la accisn de desaplicacisn ';
                RAISE ERROR_PROCESO ;
        ELSIF ( ( hTipoRegulariza = REG_PAGO_DUPLICADO ) OR
                ( hTipoRegulariza = REG_PAGO_MAYOR_VALOR ) OR
                ( hTipoRegulariza = REG_PAGO_MAL_APLICADO ) )
        THEN
                IF (hStsRegulariza = 'I' ) THEN
                        PRC_ESTADO_REGULARIZACION('P'); /* en proceso */
                ELSE
                        hDescError := 'Regularizacisn no esta en estado Inicial, lista para desaplicarse';
                        RAISE ERROR_PROCESO ;
                END IF;
        ELSE
                hDescError := 'TIPO DE REGULARIZACION DESCONOCIDA ';
                RAISE ERROR_PROCESO ;
        END IF;
---------------------------------------------------------------------------------------------
-- Verificar los documentos relacionados con el pago
-- DBMS_OUTPUT.PUT_LINE('OK... Procesando...');
---------------------------------------------------------------------------------------------
        I:= 1;
--
        FOR DOC IN DOCS_ASOC_PAGO LOOP
---------------------------------------------------------------------------------------------
                -- DBMS_OUTPUT.PUT_LINE('ITERACION I : '||I);
                -- DBMS_OUTPUT.PUT_LINE('TIPDOCUM-SECUENCI-TIPDOCREL-SECUREL-MONTO : '||DOC.COD_TIPDOCUM||'-'||DOC.NUM_SECUENCI||'-'||DOC.COD_TIPDOCREL||'-'||DOC.NUM_SECUREL||'-'||DOC.IMP_CONCEPTO);
---------------------------------------------------------------------------------------------
                -- Independiente si el documento relacionado es un abono,guarda las entradas en la tabla de trabajo
                ---------------------------------------------------------------------------- pago
                TABLA_DE_TRABAJO(I).COD_TIPDOCUM         :=   DOC.COD_TIPDOCUM;
                TABLA_DE_TRABAJO(I).NUM_SECUENCI         :=   DOC.NUM_SECUENCI;
                TABLA_DE_TRABAJO(I).COD_VENDEDOR_AGENTE  :=   DOC.COD_VENDEDOR_AGENTE;
                TABLA_DE_TRABAJO(I).LETRA                :=   DOC.LETRA;
                TABLA_DE_TRABAJO(I).COD_CENTREMI         :=   DOC.COD_CENTREMI;
                ---------------------------------------------------------------------------- documento que pago o abono que genero
                TABLA_DE_TRABAJO(I).COD_TIPDOCREL        :=   DOC.COD_TIPDOCREL;
                TABLA_DE_TRABAJO(I).NUM_SECUREL          :=   DOC.NUM_SECUREL;
                TABLA_DE_TRABAJO(I).COD_AGENTEREL        :=   DOC.COD_AGENTEREL;
                TABLA_DE_TRABAJO(I).LETRA_REL            :=   DOC.LETRA_REL;
                TABLA_DE_TRABAJO(I).COD_CENTRREL         :=   DOC.COD_CENTRREL;
                ---------------------------------------------------------------------------- datos del documento
                TABLA_DE_TRABAJO(I).COD_CONCEPTO         :=   DOC.COD_CONCEPTO;
                TABLA_DE_TRABAJO(I).IMP_CONCEPTO         :=   DOC.IMP_CONCEPTO;
                TABLA_DE_TRABAJO(I).COLUMNA              :=   DOC.COLUMNA;
                TABLA_DE_TRABAJO(I).NUM_ABONADO          :=   DOC.NUM_ABONADO;
                TABLA_DE_TRABAJO(I).COD_PRODUCTO         :=   DOC.COD_PRODUCTO;
                TABLA_DE_TRABAJO(I).FEC_CANCELACION      :=   DOC.FEC_CANCELACION;
                ---------------------------------------------------------------------------- informa ubicacion actual del documento
                TABLA_DE_TRABAJO(I).UBICACION            :=   DOC.UBIC;
                TABLA_DE_TRABAJO(I).ORDEN                :=   I;
                ---------------------------------------------------------------------------- datos complementarios del documento
                TABLA_DE_TRABAJO(I).NUM_CUOTA            :=   DOC.NUM_CUOTA;
                TABLA_DE_TRABAJO(I).SEC_CUOTA            :=   DOC.SEC_CUOTA;
                TABLA_DE_TRABAJO(I).NUM_FOLIO            :=   DOC.NUM_FOLIO;
                TABLA_DE_TRABAJO(I).PREF_PLAZA                   :=   DOC.PREF_PLAZA;
                TABLA_DE_TRABAJO(I).NUM_VENTA            :=   DOC.NUM_VENTA;
                TABLA_DE_TRABAJO(I).NUM_FOLIOCTC         :=   DOC.NUM_FOLIOCTC;
                TABLA_DE_TRABAJO(I).NUM_TRANSACCION      :=   DOC.NUM_TRANSACCION;
                TABLA_DE_TRABAJO(I).COD_OPERADORA_SCL    :=   DOC.COD_OPERADORA_SCL;
                TABLA_DE_TRABAJO(I).COD_PLAZA            :=   DOC.COD_PLAZA;

                -- MARCA--              TABLA_DE_TRABAJO(I).OPERADORA := DOC.OPERADORA
                --              TABLA_DE_TRABAJO(I).PLAZA := DOC.PLAZA

                ---------------------------------------------------------------------------- aumenta el indice de la tabla
                I := I + 1 ;
------------------------------------------------------------------------------------------
                -- verifica si el documento es un nuevo abono y lo inserta en la tabla
------------------------------------------------------------------------------------------
                --Modificado por homologacion Incidencia MAS180-001
                --IF (  DOC.NUM_SECUREL = DOC.NUM_SECUENCI + 1 ) THEN
				IF ( DOC.COD_CONCEPTO = ES_ABONO ) AND ( DOC.NUM_SECUREL <> DOC.NUM_SECUENCI ) THEN
---------------------------------------------------------------------------------------------
                        -- DBMS_OUTPUT.PUT_LINE('DOCUMENTO ASOCIADO ES UN ABONO...'||DOC.COD_TIPDOCREL||'-'||DOC.NUM_SECUREL||'-'||DOC.LETRA_REL);
---------------------------------------------------------------------------------------------
/*                        SELECT COUNT(*)
                        INTO hCuenta
                        FROM    CO_PAGOSCONC
                        WHERE   COD_TIPDOCUM        = DOC.COD_TIPDOCREL
                        AND     NUM_SECUENCI        = DOC.NUM_SECUREL
                        AND     LETRA               = DOC.LETRA_REL ;
*/
                        SELECT COUNT(1)
INTO hCuenta
FROM (
        SELECT 1
        FROM CO_PAGOSCONC
                                        WHERE   COD_TIPDOCUM        = DOC.COD_TIPDOCREL
                                        AND     NUM_SECUENCI        = DOC.NUM_SECUREL
AND     LETRA               = DOC.LETRA_REL
AND     rownum = 1 );

---------------------------------------------------------------------------------------------
IF (hCuenta > 0) THEN

/* Validacisn no necesaria en este momento, ya que no se realiza ninguna accisn.
      IF (hCuenta = 1) THEN
                                        -- DBMS_OUTPUT.PUT_LINE('EL ABONO SE APLICO SOBRE UN SOLO DOCUMENTO ');
                                        I := I + 0 ; -- instruccion nula                                                -- null
                                ELSE
                                        -- DBMS_OUTPUT.PUT_LINE('EL ABONO SE APLICO SOBRE MAS DE UN DOCUMENTO ');
                                        I := I + 0 ; -- instruccion nula                                                -- null
                                END IF;
*/
---------------------------------------------------------------------------------------------
                                H_COD_TIPDOCREL := DOC.COD_TIPDOCREL ;
                                H_NUM_SECUREL   := DOC.NUM_SECUREL ;
                                H_LETRA_REL     := DOC.LETRA_REL ;
---------------------------------------------------------------------------------------------
                                FOR ABO IN DOCS_ASOC_ABONO LOOP
---------------------------------------------------------------------------------------------
                                        -- DBMS_OUTPUT.PUT_LINE('TIPDOCUM-SECUENCI-TIPDOCREL-SECUREL-MONTO : '||ABO.COD_TIPDOCUM||'-'||ABO.NUM_SECUENCI||'-'||ABO.COD_TIPDOCREL||'-'||ABO.NUM_SECUREL||'-'||ABO.IMP_CONCEPTO);
                                        ------------------------------------------------------------------------------------------
                                        TABLA_DE_TRABAJO(I).COD_TIPDOCUM         :=   ABO.COD_TIPDOCUM;
                                        TABLA_DE_TRABAJO(I).NUM_SECUENCI         :=   ABO.NUM_SECUENCI;
                                        TABLA_DE_TRABAJO(I).COD_VENDEDOR_AGENTE  :=   ABO.COD_VENDEDOR_AGENTE;
                                        TABLA_DE_TRABAJO(I).LETRA                :=   ABO.LETRA;
                                        TABLA_DE_TRABAJO(I).COD_CENTREMI         :=   ABO.COD_CENTREMI;
                                        ------------------------------------------------------------------------------------------
                                        TABLA_DE_TRABAJO(I).COD_TIPDOCREL        :=   ABO.COD_TIPDOCREL;
                                        TABLA_DE_TRABAJO(I).NUM_SECUREL          :=   ABO.NUM_SECUREL;
                                        TABLA_DE_TRABAJO(I).COD_AGENTEREL        :=   ABO.COD_AGENTEREL;
                                        TABLA_DE_TRABAJO(I).LETRA_REL            :=   ABO.LETRA_REL;
                                        TABLA_DE_TRABAJO(I).COD_CENTRREL         :=   ABO.COD_CENTRREL;
                                        ------------------------------------------------------------------------------------------
                                        TABLA_DE_TRABAJO(I).COD_CONCEPTO         :=   ABO.COD_CONCEPTO;
                                        TABLA_DE_TRABAJO(I).IMP_CONCEPTO         :=   ABO.IMP_CONCEPTO;
                                        TABLA_DE_TRABAJO(I).COLUMNA              :=   ABO.COLUMNA;
                                        TABLA_DE_TRABAJO(I).NUM_ABONADO          :=   ABO.NUM_ABONADO;
                                        TABLA_DE_TRABAJO(I).COD_PRODUCTO         :=   ABO.COD_PRODUCTO;
                                        TABLA_DE_TRABAJO(I).FEC_CANCELACION      :=   ABO.FEC_CANCELACION;
                                        ------------------------------------------------------------------------------------------
                                        TABLA_DE_TRABAJO(I).UBICACION            :=   'CO_CARTERA';
                                        TABLA_DE_TRABAJO(I).ORDEN                :=   I;
                                        -- Homologado 01-12-2003 SOP RyC R.V.R. (HB-226)
                                        TABLA_DE_TRABAJO(I).NUM_CUOTA            :=   ABO.NUM_CUOTA;
                                        TABLA_DE_TRABAJO(I).SEC_CUOTA            :=   ABO.SEC_CUOTA;
                                        TABLA_DE_TRABAJO(I).NUM_FOLIO            :=   ABO.NUM_FOLIO;
                                        TABLA_DE_TRABAJO(I).PREF_PLAZA           :=   ABO.PREF_PLAZA;
                                        TABLA_DE_TRABAJO(I).NUM_VENTA            :=   ABO.NUM_VENTA;
                                        TABLA_DE_TRABAJO(I).NUM_FOLIOCTC         :=   ABO.NUM_FOLIOCTC;
                                        TABLA_DE_TRABAJO(I).NUM_TRANSACCION      :=   ABO.NUM_TRANSACCION;
                                        TABLA_DE_TRABAJO(I).COD_OPERADORA_SCL    :=   ABO.COD_OPERADORA_SCL;
                            TABLA_DE_TRABAJO(I).COD_PLAZA            :=   ABO.COD_PLAZA;
                -- MARCA--              TABLA_DE_TRABAJO(I).OPERADORA := ABO.OPERADORA
                --              TABLA_DE_TRABAJO(I).PLAZA := ABO.PLAZA
                                        ------------------------------------------------------------------------------------------
                                        -- Verifica ubicacion del documento (cartera o cancelados)
                                        ------------------------------------------------------------------------------------------
/*                                        SELECT COUNT(*)                                                       -- cursor
                                        INTO  hCuenta
                                        FROM CO_CARTERA A
                                        WHERE A.COD_TIPDOCUM        = ABO.COD_TIPDOCREL
                                        AND   A.NUM_SECUENCI        = ABO.NUM_SECUREL
                                        AND   A.COD_VENDEDOR_AGENTE = ABO.COD_AGENTEREL
                                        AND   A.LETRA               = ABO.LETRA_REL
                                        AND   A.COD_CENTREMI        = ABO.COD_CENTRREL ;
*/
        SELECT COUNT(1)
INTO hCuenta
FROM (
SELECT 1
FROM CO_CARTERA A
WHERE A.COD_TIPDOCUM        = ABO.COD_TIPDOCREL
AND   A.NUM_SECUENCI        = ABO.NUM_SECUREL
AND   A.COD_VENDEDOR_AGENTE = ABO.COD_AGENTEREL
AND   A.LETRA               = ABO.LETRA_REL
AND   A.COD_CENTREMI        = ABO.COD_CENTRREL
AND   A.COD_CONCEPTO	    = ABO.COD_CONCEPTO
AND   A.COLUMNA		    = ABO.COLUMNA                                                    -- ** Homologado 01-12-2003 SOP RyC R.V.R. (HB-226)
And   rownum = 1 );
                                        ------------------------------------------------------------------------------------------
                                        IF ( hCuenta = 0 ) THEN
                                                TABLA_DE_TRABAJO(I).UBICACION :=   'CO_CANCELADOS';
                                        END IF;
                                        ------------------------------------------------------------------------------------------
                                        I := I + 1 ;
---------------------------------------------------------------------------------------------
                                END LOOP;
---------------------------------------------------------------------------------------------
                                -- DBMS_OUTPUT.PUT_LINE('I VA EN : '||I);
---------------------------------------------------------------------------------------------
/* no es necesario, por lo que  se desecha
                        ELSE                                                                                    -- ifs/ else sin nada-> fuera!!!!
---------------------------------------------------------------------------------------------
                                -- DBMS_OUTPUT.PUT_LINE('EL ABONO NO SE APLICADO SOBRE NINGUN DOCUMENTO TODAVIA ');
                                I := I + 0 ; -- Instruccion puesta por compatibilidad                           -- null
---------------------------------------------------------------------------------------------
*/
                        END IF;
---------------------------------------------------------------------------------------------
                END IF;
---------------------------------------------------------------------------------------------
        END LOOP;
---------------------------------------------------------------------------------------------
-- DBMS_OUTPUT.PUT_LINE('RECUPERADOS TODOS LOS DOCUMENTOS ASOCIADOS AL PAGO....');
---------------------------------------------------------------------------------------------
-- En este punto se tomo el pago y se registrs todos los documentos que pags en el orden que los pags
-- ademas siguis todos los abonos generados Y SI SE PAGARON DOCUMENTOS CON ESE ABONO.
-- Ahora es posible desaplicar ordenandamente cada documento.
-- La variable I esta en la posicion N+1 de la tabla, es decir, en la siguiente entrada libre de la misma,
-- Por lo tanto se rebaja en 1 para que apunte a la ultima posicion con datos (N)
---------------------------------------------------------------------------------------------
-- DBMS_OUTPUT.PUT_LINE('SEGUNDA PARTE DEL ALGORITMO ...');
---------------------------------------------------------------------------------------------
-- primero : obtiene los datos que le faltan del pago
---------------------------------------------------------------------------------------------
        SELECT FEC_EFECTIVIDAD, COD_FORPAGO, COD_SISPAGO, NUM_COMPAGO, PREF_PLAZA   /* CodSisPagoOri => 5 Pago ficiticio por regularizacion Nota: ingresar en GE_SISPAGO */
        INTO   hFecEfectividadOri, hCodForPagoOri, hCodSisPagoOri, hNumCompago, sPref_Plaza
        FROM   CO_PAGOS
        WHERE  COD_TIPDOCUM = hCodTipDocumOri
        AND    NUM_SECUENCI = hNumSecuenciOri
        AND    COD_VENDEDOR_AGENTE = hCodVendedorAgenteOri
        AND    LETRA = hLetraOri
        AND    COD_CENTREMI = hCodCentremiOri
        AND    COD_CLIENTE = hCodClienteOri ;
---------------------------------------------------------------------------------------------
-- DBMS_OUTPUT.PUT_LINE('DATOS DEL PAGO OK...');
---------------------------------------------------------------------------------------------
-- segundo : marca al pago como parte de una regularizacisn
---------------------------------------------------------------------------------------------
        UPDATE CO_PAGOS
        SET    IND_REGULARIZA = hNumRegularizacion
        WHERE  COD_TIPDOCUM = hCodTipDocumOri
        AND    NUM_SECUENCI = hNumSecuenciOri
        AND    COD_VENDEDOR_AGENTE = hCodVendedorAgenteOri
        AND    LETRA = hLetraOri
        AND    COD_CENTREMI = hCodCentremiOri
        AND    COD_CLIENTE = hCodClienteOri ;
---------------------------------------------------------------------------------------------
-- DBMS_OUTPUT.PUT_LINE('PAGO MARCADO COMO PARTE DE UNA REGULARIZACION ...');
---------------------------------------------------------------------------------------------
-- tercero : inserta un nuevo pago relacionado, cuyo documento indica que es un pago por regularizacion
---------------------------------------------------------------------------------------------

        INSERT INTO CO_PAGOS
        (
                COD_TIPDOCUM,
                NUM_SECUENCI,       COD_VENDEDOR_AGENTE,    LETRA,              COD_CENTREMI,
                COD_CLIENTE,        IMP_PAGO,
                FEC_EFECTIVIDAD,    COD_CAJA,               FEC_VALOR,          NOM_USUARORA,
                COD_FORPAGO,        COD_SISPAGO,            COD_BANCO,          COD_TIPTARJETA,
                COD_SUCURSAL,       CTA_CORRIENTE,          NUM_TARJETA,        NUM_COMPAGO,
                PREF_PLAZA,         COD_ORIPAGO,            COD_CAUPAGO,        IND_REGULARIZA,
                DES_PAGO
                -- MARCA --OPERADORA_ORIGEN, PLAZA_ORIGEN  (NO VA)
        )
        VALUES
        (
                DOC_DESAPLICA_PAGO_X_REG,
                hNumSecuenciOri,    hCodVendedorAgenteOri,  hLetraOri,          hCodCentremiOri,
                hCodClienteOri,     hImportePagoOri,
                SYSDATE, 			CAJA_REGULARIZA,        hFecEfectividadOri,	USER,
                hCodForPagoOri,     hCodSisPagoOri,         NULL,               NULL,
                NULL,               NULL,                   NULL,                 hNumComPago,
                sPref_Plaza,        hTipoRegulariza,        COD_CAU_PAGO_REG,     hNumRegularizacion,
                DES_DESAPLICA_PAGO_X_REG
        );

---------------------------------------------------------------------------------------------
-- DBMS_OUTPUT.PUT_LINE('PAGO 84 INSERTADO EN CO_PAGOS ...');
---------------------------------------------------------------------------------------------
-- cuarto : REVISION DE LOS DOCUMENTOS RELACIONADOS CON EL PAGO, DESDE EL ULTIMO MOVIMIENTO HASTA EL PRIMERO
---------------------------------------------------------------------------------------------
        IF TABLA_DE_TRABAJO.COUNT = 0 THEN
---------------------------------------------------------------------------------------------
                -- DBMS_OUTPUT.PUT_LINE('NO HAY NADA ASOCIADO AL PAGO ...');
---------------------------------------------------------------------------------------------
                hDescError:='No se encontrs nada relacionado con el pago';      -- Super raro serma en este punto del programa.
                RAISE ERROR_PROCESO;
        ELSE
---------------------------------------------------------------------------------------------
                -- DBMS_OUTPUT.PUT_LINE('SE REVISA LA TABLA DE TRABAJO EN ORDEN INVERSO...');
                -- DBMS_OUTPUT.PUT_LINE('ULTIMO : '||TABLA_DE_TRABAJO.LAST);
                -- DBMS_OUTPUT.PUT_LINE('PRIMERO : '||TABLA_DE_TRABAJO.FIRST);
---------------------------------------------------------------------------------------------
                I := TABLA_DE_TRABAJO.LAST ;
                WHILE I IS NOT NULL LOOP
---------------------------------------------------------------------------------------------
                        -- DBMS_OUTPUT.PUT_LINE('REGISTRO I-esima : ' || I);
                        -- DBMS_OUTPUT.PUT_LINE('TIP_DOC-SECUENCIA '|| tabla_de_trabajo(I).COD_TIPDOCrel ||'-'|| tabla_de_trabajo(I).num_securel );
---------------------------------------------------------------------------------------------
                        IF ( TABLA_DE_TRABAJO(I).UBICACION = 'CO_CANCELADOS' ) THEN
---------------------------------------------------------------------------------------------
                                -- DBMS_OUTPUT.PUT_LINE('ESTABA CANCELADO... ' );
                                -- verifica si en una iteracion anterior se movis el documento a la co_cartera
---------------------------------------------------------------------------------------------
/*                                SELECT COUNT(*)
                                INTO hCuenta
                                FROM CO_CARTERA
                                WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                                AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                                AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                                AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                                AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I). COD_CENTRREL
                                AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                                AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
*/
SELECT COUNT(1)
                                        INTO hCuenta
                                FROM (
SELECT 1
FROM CO_CARTERA
WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I). COD_CENTRREL
AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA
And rownum = 1  );
---------------------------------------------------------------------------------------------
                                IF ( hCuenta = 0 ) THEN   -- el documento no esta previamente en la cartera
---------------------------------------------------------------------------------------------
                                        -- DBMS_OUTPUT.PUT_LINE('SE MUEVE A CO_CARTERA ... ' );
---------------------------------------------------------------------------------------------
                                        INSERT INTO CO_CARTERA   -- entonces, lo inserta en co_cartera
                                        (
                                                COD_CLIENTE,          NUM_SECUENCI,        COD_TIPDOCUM,
                                                COD_VENDEDOR_AGENTE,  LETRA,               COD_CENTREMI,
                                                COD_CONCEPTO,         COLUMNA,             COD_PRODUCTO,
                                                IMPORTE_DEBE,         IMPORTE_HABER,
                                                IND_CONTADO,          IND_FACTURADO,
                                                FEC_EFECTIVIDAD,      FEC_VENCIMIE,        FEC_CADUCIDA,
                                                FEC_ANTIGUEDAD,       NUM_ABONADO,         NUM_FOLIO,
                                                PREF_PLAZA,                       NUM_FOLIOCTC,            FEC_PAGO,
                                                NUM_CUOTA,                        SEC_CUOTA,               NUM_TRANSACCION,
                                                NUM_VENTA,                        COD_OPERADORA_SCL,   COD_PLAZA
                -- MARCA OPERADORA, PLAZA
                                        )
                                        SELECT
                                                COD_CLIENTE,          NUM_SECUENCI,        COD_TIPDOCUM,
                                                COD_VENDEDOR_AGENTE,  LETRA,               COD_CENTREMI,
                                                COD_CONCEPTO,         COLUMNA,             COD_PRODUCTO,
                                                IMPORTE_DEBE,         IMPORTE_HABER, ----------------------------------- MUEVE LOS MISMOS MONTOS DE CO_CANCELADOS
                                                IND_CONTADO,          IND_FACTURADO,
                                                FEC_EFECTIVIDAD,      FEC_VENCIMIE,        FEC_CADUCIDA,
                                                FEC_ANTIGUEDAD,       NUM_ABONADO,         NUM_FOLIO,
                                                PREF_PLAZA,                       NUM_FOLIOCTC,            FEC_PAGO,
                                                NUM_CUOTA,                        SEC_CUOTA,               NUM_TRANSACCION,
                                                NUM_VENTA,                        COD_OPERADORA_SCL,   COD_PLAZA
                -- MARCA OPERADORA, PLAZA
                                                FROM CO_CANCELADOS
                                                WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                                                AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                                                AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                                                AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                                                AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I).COD_CENTRREL
                                                AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                                                AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
---------------------------------------------------------------------------------------------
                                        -- DBMS_OUTPUT.PUT_LINE(' Y SE ELIMINA DE CO_CANCELADOS ... ' );
---------------------------------------------------------------------------------------------
                                        DELETE CO_CANCELADOS
                                        WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                                        AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                                        AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                                        AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                                        AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I). COD_CENTRREL
                                        AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                                        AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
---------------------------------------------------------------------------------------------
                                END IF;
---------------------------------------------------------------------------------------------
                        END IF;
---------------------------------------------------------------------------------------------
                        IF ( TABLA_DE_TRABAJO(I).COD_CONCEPTO = ES_ABONO ) THEN
---------------------------------------------------------------------------------------------
                                -- DBMS_OUTPUT.PUT_LINE(' SI ES ABONO SE REBAJA EL DEBE ... ' );
---------------------------------------------------------------------------------------------
                                UPDATE CO_CARTERA   -------------------------------------------------- rebaja el DEBE del documento
                                SET IMPORTE_DEBE          = IMPORTE_DEBE - TABLA_DE_TRABAJO(I).IMP_CONCEPTO
                                WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                                AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                                AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                                AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                                AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I).COD_CENTRREL
                                AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                                AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
---------------------------------------------------------------------------------------------
                        ELSE
---------------------------------------------------------------------------------------------
                                -- DBMS_OUTPUT.PUT_LINE(' SI NO ES ABONO SE REBAJA EL HABER  ... ' );
---------------------------------------------------------------------------------------------
                                UPDATE CO_CARTERA   -------------------------------------------------- rebaja el HABER del documento
                                SET IMPORTE_HABER         = IMPORTE_HABER - TABLA_DE_TRABAJO(I).IMP_CONCEPTO
                                WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                                AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                                AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                                AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                                AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I).COD_CENTRREL
                                AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                                AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
---------------------------------------------------------------------------------------------
                        END IF;
---------------------------------------------------------------------------------------------
                        -- DBMS_OUTPUT.PUT_LINE(' SE INSERTA REGISTRO RELACIONADO EN CO_PAGOSCONC  ... ' );
---------------------------------------------------------------------------------------------
                        INSERT INTO CO_PAGOSCONC  ---------------------------------- registra el movimiento siempre por el total de la plata
                        (
                                COD_TIPDOCUM         ,
                                NUM_SECUENCI         ,  COD_VENDEDOR_AGENTE  ,  LETRA                ,
                                COD_CENTREMI         ,  COD_TIPDOCREL        ,  NUM_SECUREL          ,
                                COD_AGENTEREL        ,  LETRA_REL            ,  COD_CENTRREL         ,
                                COD_CONCEPTO         ,  COLUMNA              ,  IMP_CONCEPTO         ,
                                COD_PRODUCTO         ,  NUM_ABONADO          ,  NUM_TRANSACCION      ,
                                NUM_FOLIO            ,  PREF_PLAZA                       ,      NUM_CUOTA            ,
                                SEC_CUOTA            ,  NUM_VENTA            ,  NUM_FOLIOCTC         ,
                                FEC_CANCELACION          ,      COD_OPERADORA_SCL    ,  COD_PLAZA
              -- OPERADORA_ORIGEN, PLAZA_ORIGEN
                        )
                        VALUES
                        (
                                DOC_DESAPLICA_PAGO_X_REG,
                                TABLA_DE_TRABAJO(I).NUM_SECUENCI      ,  hCodVendedorAgenteOri                ,  hLetraOri,
                                hCodCentremiOri                       ,  TABLA_DE_TRABAJO(I).COD_TIPDOCREL    ,  TABLA_DE_TRABAJO(I).NUM_SECUREL      ,
                                TABLA_DE_TRABAJO(I).COD_AGENTEREL     ,  TABLA_DE_TRABAJO(I).LETRA_REL        ,  TABLA_DE_TRABAJO(I).COD_CENTRREL     ,
                                TABLA_DE_TRABAJO(I).COD_CONCEPTO      ,  TABLA_DE_TRABAJO(I).COLUMNA          ,  TABLA_DE_TRABAJO(I).IMP_CONCEPTO     ,
                                TABLA_DE_TRABAJO(I).COD_PRODUCTO      ,  TABLA_DE_TRABAJO(I).NUM_ABONADO      ,  TABLA_DE_TRABAJO(I).NUM_TRANSACCION  ,
                                TABLA_DE_TRABAJO(I).NUM_FOLIO         ,  TABLA_DE_TRABAJO(I).PREF_PLAZA           ,      TABLA_DE_TRABAJO(I).NUM_CUOTA        ,
                                TABLA_DE_TRABAJO(I).SEC_CUOTA         ,  TABLA_DE_TRABAJO(I).NUM_VENTA            ,  TABLA_DE_TRABAJO(I).NUM_FOLIOCTC     ,
                                SYSDATE                                                           ,      TABLA_DE_TRABAJO(I).COD_OPERADORA_SCL ,  TABLA_DE_TRABAJO(I).COD_PLAZA

                                --MARCA --TABLA_DE_TRABAJO(I).OPERADORA        ,  TABLA_DE_TRABAJO(I).PLAZA
                        );
---------------------------------------------------------------------------------------------
                        -- DBMS_OUTPUT.PUT_LINE(' SE VERIFICA SI LA CO_CARTERA ESTA CONSISTENTE  ... ' );
---------------------------------------------------------------------------------------------
                        SELECT IMPORTE_DEBE, IMPORTE_HABER, COD_CONCEPTO
                        INTO H_IMPORTE_DEBE, H_IMPORTE_HABER, H_COD_CONCEPTO
                        FROM CO_CARTERA
                        WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                        AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                        AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                        AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                        AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I).COD_CENTRREL
                        AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                        AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
---------------------------------------------------------------------------------------------
                        IF ( ( H_IMPORTE_DEBE = H_IMPORTE_HABER ) AND ( H_IMPORTE_HABER <> 0 ) ) THEN
---------------------------------------------------------------------------------------------
                                -- DBMS_OUTPUT.PUT_LINE(' HABER = DEBE <> 0 ' );
                                -- DBMS_OUTPUT.PUT_LINE(' VUELVE A LA CO_CANCELADOS ' );
---------------------------------------------------------------------------------------------
                                INSERT INTO CO_CANCELADOS
                                (
                                        COD_CLIENTE,          NUM_SECUENCI,        COD_TIPDOCUM,
                                        COD_VENDEDOR_AGENTE,  LETRA,               COD_CENTREMI,
                                        COD_CONCEPTO,         COLUMNA,             COD_PRODUCTO,
                                        IMPORTE_DEBE,         IMPORTE_HABER,
                                        IND_CONTADO,          IND_FACTURADO,
                                        FEC_EFECTIVIDAD,      FEC_VENCIMIE,        FEC_CADUCIDA,
                                        FEC_ANTIGUEDAD,       NUM_ABONADO,         NUM_FOLIO,
                                        PREF_PLAZA,                       NUM_FOLIOCTC,            FEC_PAGO,
                                        NUM_CUOTA,                        SEC_CUOTA,               NUM_TRANSACCION,
                                        NUM_VENTA,                        FEC_CANCELACION,         IND_PORTADOR,
                                        COD_OPERADORA_SCL,        COD_PLAZA
                                -- MARCA-- OPERADORA,PLAZA
                                )
                                SELECT
                                        COD_CLIENTE,          NUM_SECUENCI,        COD_TIPDOCUM,
                                        COD_VENDEDOR_AGENTE,  LETRA,               COD_CENTREMI,
                                        COD_CONCEPTO,         COLUMNA,             COD_PRODUCTO,
                                        IMPORTE_DEBE,         IMPORTE_DEBE,
                                        IND_CONTADO,          IND_FACTURADO,
                                        FEC_EFECTIVIDAD,      FEC_VENCIMIE,        FEC_CADUCIDA,
                                        FEC_ANTIGUEDAD,       NUM_ABONADO,         NUM_FOLIO,
                                        PREF_PLAZA,                       NUM_FOLIOCTC,            SYSDATE,
                                        NUM_CUOTA,                        SEC_CUOTA,               NUM_TRANSACCION,
                                        NUM_VENTA,                        SYSDATE,             0,
                                        COD_OPERADORA_SCL, COD_PLAZA
                                -- MARCA-- OPERADORA,PLAZA
                                FROM   CO_CARTERA
                                WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                                AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                                AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                                AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                                AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I).COD_CENTRREL
                                AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                                AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
---------------------------------------------------------------------------------------------
                        END IF;
---------------------------------------------------------------------------------------------
                        --Modificado por homologacion Incidencia MAS180-001
						--IF    ( ( ( H_COD_CONCEPTO = ES_ABONO ) AND ( TABLA_DE_TRABAJO(I).NUM_SECUREL = TABLA_DE_TRABAJO(I).NUM_SECUENCI + 1 OR TABLA_DE_TRABAJO(I).NUM_SECUREL = TABLA_DE_TRABAJO(I).NUM_SECUENCI  ) )
                        --      OR ( H_IMPORTE_DEBE = H_IMPORTE_HABER ) )
						IF    ( ( H_COD_CONCEPTO = ES_ABONO ) OR  (H_IMPORTE_DEBE = H_IMPORTE_HABER ) )
                        THEN
---------------------------------------------------------------------------------------------
                                -- DBMS_OUTPUT.PUT_LINE('( ES ABONO Y (SECUREL = SECUENCIA O SECUREL =SECUENCI+1) ) O (HABER = DEBE)' );
                                -- DBMS_OUTPUT.PUT_LINE(' SE ELIMINA DE LA CO_CARTERA ' );
---------------------------------------------------------------------------------------------
                                DELETE CO_CARTERA
                                WHERE NUM_SECUENCI        = TABLA_DE_TRABAJO(I).NUM_SECUREL
                                AND   COD_TIPDOCUM        = TABLA_DE_TRABAJO(I).COD_TIPDOCREL
                                AND   COD_VENDEDOR_AGENTE = TABLA_DE_TRABAJO(I).COD_AGENTEREL
                                AND   LETRA               = TABLA_DE_TRABAJO(I).LETRA_REL
                                AND   COD_CENTREMI        = TABLA_DE_TRABAJO(I).COD_CENTRREL
                                AND   COD_CONCEPTO        = TABLA_DE_TRABAJO(I).COD_CONCEPTO
                                AND   COLUMNA             = TABLA_DE_TRABAJO(I).COLUMNA;
---------------------------------------------------------------------------------------------
                        END IF;
---------------------------------------------------------------------------------------------
                I := TABLA_DE_TRABAJO.PRIOR(I);
                END LOOP;
---------------------------------------------------------------------------------------------
                -- DBMS_OUTPUT.PUT_LINE(' TERMINO EL CICLO ' );
---------------------------------------------------------------------------------------------
        END IF;

---------------------------------------------------------------------------------------------
        PRC_ESTADO_REGULARIZACION('D'); -- proceso termino OK, se ha Desaplicado
---------------------------------------------------------------------------------------------
        -- DBMS_OUTPUT.PUT_LINE(' MARCA PROCESO EXITOSO ' );
---------------------------------------------------------------------------------------------


	/*Modificacion para Cancelacion de Creditos. Se inserta aca para que se ejecute despues del COMMIT */
	    --Obtiene Numero de Secuencia
		hDescError := 'Error en Obtencion de Secuencia de Cancelacion de Creditos. ';
		SELECT
		        ga_seq_transacabo.NEXTVAL
		INTO
		        TN_numtransaccion
		FROM
		        dual;

		--Ejecuta Pl de Cancelacion de Creditos
		hDescError := 'Error en llamada a Pl CO_CANCELACREDITOS_PR. ';
	    CO_CANCELACION_PG.CO_CANCELACREDITOS_PR(hCodClienteOri, SYSDATE, TN_numtransaccion, GN_indcarrier, NULL, NULL, NULL, TN_retorno, TV_glosa);

		--Verifica si se produjo error en Cancelacion de Credito
		IF TN_retorno <> 0 THEN
		   --hDescError := 'Error inesperado, Codigo:'||sqlcode||'  Descripcion:'||sqlerrm || ' --- ' || TN_retorno || TV_glosa;--TV_glosa;
		   hDescError := TV_glosa;
		   RAISE ERROR_PROCESO;
		END IF;
	/*Fin Modificacion para Cancelacion de Creditos */

EXCEPTION
---------------------------------------------------------------------------------------------
        WHEN ERROR_PROCESO THEN
                --ROLLBACK;
---------------------------------------------------------------------------------------------
                -- DBMS_OUTPUT.PUT_LINE('ERROR CONTROLADO : '|| hDescError);
---------------------------------------------------------------------------------------------
                PRC_ESTADO_REGULARIZACION('E'); -- proceshDesErroro termino con error
                RAISE_APPLICATION_ERROR(-20103, hDescError);
---------------------------------------------------------------------------------------------
        WHEN OTHERS THEN
                --ROLLBACK;
---------------------------------------------------------------------------------------------
                -- DBMS_OUTPUT.PUT_LINE('Error inesperado, Codigo:'||sqlcode||'  Descripcion:'||sqlerrm);
---------------------------------------------------------------------------------------------
                PRC_ESTADO_REGULARIZACION('E'); -- proceso termino con error
                RAISE_APPLICATION_ERROR(-20104,'Error inesperado, Codigo:'||sqlcode||'  Descripcion:'||sqlerrm);
---------------------------------------------------------------------------------------------
END PRC_DESAPLICA_PAGO_REG;
/
SHOW ERRORS
