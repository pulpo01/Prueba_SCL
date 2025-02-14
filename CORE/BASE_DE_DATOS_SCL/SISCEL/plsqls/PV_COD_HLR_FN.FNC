CREATE OR REPLACE FUNCTION PV_COD_HLR_FN(SSERIE IN VARCHAR2) RETURN VARCHAR2
IS
        SCODIGO_HLR   VARCHAR(10); --GSM_SIMCARD_TO.CODIGO_HLR%TYPE;
        SCODIGO_central ICG_CENTRAL.COD_central%TYPE;
        VARIABLE       VARCHAR2(50);
BEGIN


        BEGIN
                SELECT COD_HLR
                  INTO SCODIGO_HLR
                  FROM GSM_SIMCARD_TO
                 WHERE NUM_SIMCARD = SSERIE;


        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN 'FALSE'||'SERIE  NO EXISTE';
                WHEN OTHERS THEN
                        RETURN 'FALSE|'||SQLERRM;
        END;

        BEGIN
                SELECT COD_central
                  INTO SCODIGO_central
                  FROM ICG_CENTRAL
                 WHERE COD_HLR      = SCODIGO_HLR AND
                       COD_PRODUCTO =  1;


        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN 'FALSE'||'CODIGO NO EXISTE';
                WHEN OTHERS THEN
                        RETURN 'FALSE|'||SQLERRM;
        END;

        VARIABLE :=PV_HOMOLACION_ALTAMIRA_FN('10002',SCODIGO_central);

        RETURN VARIABLE;

END PV_COD_HLR_FN;
/
SHOW ERRORS
