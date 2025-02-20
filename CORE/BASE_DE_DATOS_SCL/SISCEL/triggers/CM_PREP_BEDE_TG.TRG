CREATE OR REPLACE TRIGGER CM_PREP_BEDE_TG
 BEFORE DELETE ON CM_METASPREPAGO_TD
 FOR EACH ROW

DECLARE

        iExiste          NUMBER(1);
        szEstado         CM_CICLCOMIS_TD.COD_ESTADO%TYPE;
        iCodConcepto	 CMD_CONCEPTOS.COD_CONCEPTO%TYPE;
        iCodCiclcomis    CM_CICLCOMIS_TD.COD_CICLCOMIS%TYPE;
		sTipCiclComis	 CM_CICLCOMIS_TD.TIP_CICLCOMIS%TYPE;
        sFecha           DATE;

BEGIN
	iCodConcepto := :OLD.COD_CONCEPTO;
    BEGIN
		SELECT TIP_CICLCOMIS
		INTO sTipCiclComis
		FROM CMD_CONCEPTOS
		WHERE COD_CONCEPTO = iCodConcepto;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20999,'ERROR COMPROBANDO ESTADO DE CICLOS NUEVOS DE COMISIONES.');
            NULL;
	END;
	iCodCiclcomis := :OLD.COD_CICLCOMIS_INI;
	IF LENGTH(iCodCiclcomis)<> 8 THEN
		RAISE_APPLICATION_ERROR(-20999,'EL CICLO INICIO ANTIGUO DE COMISIONES ES INVALIDO.');
		NULL;
	END IF;

	SELECT CM_VALIDA_CICLCOMIS_PG.EXISTECICLCOMIS(iCodCiclcomis)
	INTO iExiste FROM DUAL;
    IF iExiste = 0 THEN
		IF sTipCiclComis = 'P' THEN
            BEGIN
                 CM_VALIDA_CICLCOMIS_PG.CREACICLCOMIS(iCodCiclcomis);
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20999,'NO PUDO CREAR CICLO INICIO ANTIGUO DE COMISIONES.');
                    NULL;
            END;
		ELSE
            RAISE_APPLICATION_ERROR(-20999,'EL CICLO DE COMISIONES INICIO ANTIGUO NO EXISTE.');
            NULL;
        END IF;
    ELSE
    	SELECT CM_VALIDA_CICLCOMIS_PG.GETESTADOCICLCOMIS(iCodCiclcomis)
    	INTO szEstado FROM DUAL;
        IF szEstado != 'INI' THEN
        	RAISE_APPLICATION_ERROR(-20999,'CICLO INICIO ANTIGUO EN ESTADO DISTINTO DE INI. NO ADMITE CAMBIOS.');
        END IF;
    END IF;


    iCodCiclcomis := :OLD.COD_CICLCOMIS_FIN;
	IF LENGTH(iCodCiclcomis)<> 8 THEN
		RAISE_APPLICATION_ERROR(-20999,'EL CICLO DE TERMINO ANTIGUO DE COMISIONES ES INVALIDO.');
		NULL;
	END IF;

	SELECT CM_VALIDA_CICLCOMIS_PG.EXISTECICLCOMIS(iCodCiclcomis)
	INTO iExiste FROM DUAL;
    IF iExiste = 0 THEN
		IF sTipCiclComis = 'P' THEN
            BEGIN
                 CM_VALIDA_CICLCOMIS_PG.CREACICLCOMIS(iCodCiclcomis);
            EXCEPTION
                WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20999,'NO PUDO CREAR CICLO TERMINO ANTIGUO DE COMISIONES.');
                    NULL;
            END;
		ELSE
            RAISE_APPLICATION_ERROR(-20999,'EL CICLO DE COMISIONES TERMINO ANTIGUO NO EXISTE.');
            NULL;
        END IF;
    ELSE
    	SELECT CM_VALIDA_CICLCOMIS_PG.GETESTADOCICLCOMIS(iCodCiclcomis)
    	INTO szEstado FROM DUAL;
        IF szEstado != 'INI' THEN
        	RAISE_APPLICATION_ERROR(-20999,'CICLO TERMINO ANTIGUO EN ESTADO DISTINTO DE INI. NO ADMITE CAMBIOS.');
        END IF;
    END IF;

EXCEPTION
        WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20999,'REGISTRO INVALIDO: '||SQLERRM);
                NULL;
END  CM_PREP_BEDE_TG;
/
SHOW ERRORS
