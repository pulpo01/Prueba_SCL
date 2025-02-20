CREATE OR REPLACE FUNCTION PV_HOMOLACION_ALTAMIRA_FN(STIP_CODIGO IN VARCHAR2,SCOD_INTERNO IN VARCHAR2) RETURN VARCHAR2
IS
        SCODIGO_EXTERNO   VARCHAR2(20); --SISCEL.AL_CODIGO_EXTERNO.CODIGO_EXTERNO%TYPE;
BEGIN


        BEGIN
                SELECT CODIGO_EXTERNO
                  INTO SCODIGO_EXTERNO
                  FROM AL_CODIGO_EXTERNO
                 WHERE COD_PLATAFORMA = 'ALTAMIRA'
                 AND TIP_CODIGO  =  STIP_CODIGO
                 AND CODIGO_INTERNO =SCOD_INTERNO;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RETURN 'FALSE'||'CODIGO  NO EXISTE';
                WHEN OTHERS THEN
                        RETURN 'FALSE|'||SQLERRM;
        END;

        RETURN SCODIGO_EXTERNO;

END PV_HOMOLACION_ALTAMIRA_FN;
/
SHOW ERRORS
