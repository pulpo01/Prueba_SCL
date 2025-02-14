CREATE OR REPLACE PROCEDURE PV_ACTUALIZA_CAMB_COMERC_PR
(
    pnCodCliente IN NUMBER,
    pnNumAbonado IN NUMBER,
    pnIndNumeracion IN NUMBER,
    pvCodActabo IN VARCHAR2,
    pdFecDesde IN DATE,
    pvErrorAplic OUT VARCHAR2,
    pvErrorGlosa OUT VARCHAR2,
    pvErrorOra OUT VARCHAR2,
    pvErrorOraGlosa OUT VARCHAR2,
    pvTrace OUT VARCHAR2)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_ACTUALIZA_CAMB_COMERC_PR
-- * Descripcion        : Informa al tazador online sobre cambios producidos en
-- *                      los planes tarifarios.
-- * Fecha de creacion  : 14-01-2003 16:23
-- * Responsable        : Area Postventa (*)
-- *************************************************************
--
    wl_cod_tiplan    TA_PLANTARIF.TIP_PLANTARIF%TYPE;
    CONT_GA_INTARCEL_ACCIONES_TO    NUMBER; --194303

BEGIN
    pvErrorAplic := 'TRUE';
    pvErrorGlosa := ' ';
    pvErrorOra := ' ';
    pvErrorOraGlosa := ' ';
    pvTrace := ' ';

    if pnNumAbonado<>0 then

        /* Inicio Modificacion incidencia TM-291020030351 - Andr?s Gangas */
        /* Rescatar tipo de plan tarifario para no insertar en GA_INTARCEL_ACCIONES_TO **
        ** en caso de la linea ser de tipo hibrido                                     */
        SELECT cod_tiplan
        INTO   wl_cod_tiplan
        FROM   ga_abocel a,
               ta_plantarif b
        WHERE  a.num_abonado = pnNumAbonado
        AND    a.cod_producto = b.cod_producto
        AND    a.cod_plantarif = b.cod_plantarif;

        IF (GE_FN_DEVVALPARAM('GA', 1, 'IND_TOL') = 'S') AND
           (GE_FN_DEVVALPARAM('GA', 1, 'TIPOHIBRIDO') <> wl_cod_tiplan)
        THEN
            
            --INI 194303
            SELECT COUNT(1) 
            INTO CONT_GA_INTARCEL_ACCIONES_TO
            FROM GA_INTARCEL_ACCIONES_TO
            WHERE COD_CLIENTE =  pnCodCliente           
            AND FEC_DESDE  =  pdFecDesde        
            AND IND_NUMERO =  pnIndNumeracion          
            AND NUM_ABONADO = pnNumAbonado;
            
            IF CONT_GA_INTARCEL_ACCIONES_TO < 1 THEN
            --fin 194303
            
                        INSERT INTO GA_INTARCEL_ACCIONES_TO
                            (
                             COD_CLIENTE,
                             NUM_ABONADO,
                             IND_NUMERO,
                             FEC_DESDE,
                             COD_ACTABO,
                             NOM_USUARORA,
                             FEC_INGRESO
                            )
                        VALUES
                            (
                             pnCodCliente,
                             pnNumAbonado,
                             pnIndNumeracion,
                             pdFecDesde,
                             pvCodActabo,
                             USER,
                             SYSDATE
                            );
                            
           END IF;  --194303
                                            
        END IF;

    end if;

EXCEPTION
    WHEN OTHERS THEN
        pvErrorAplic := 'FALSE';
        pvErrorGlosa := 'fallo insercion de GA_INTARCEL_ACCIONES_TO';
        pvErrorOra := TO_CHAR(SQLCODE);
        pvErrorOraGlosa := SQLERRM;
END;
/
SHOW ERRORS
