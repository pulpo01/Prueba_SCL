CREATE OR REPLACE TRIGGER TRG_INSERTA_LIMCREDITO
 AFTER INSERT OR DELETE ON VE_VENDEDORES
FOR EACH ROW
/******************************************************************************
   NAME:       TRG_INSERTA_LIMCREDITO
   PURPOSE:    To perform work as each row is inserted
   REVISIONS:
   Ver        Date        Author                        Description
   ---------  ----------  ---------------               ------------------------------------
   1.0        07-01-2003  Alejandra Monteaqlegre G          Created this trigger.
   Here is the complete list of available Auto Replace Keywords:
      Object Name:     TRG_INSERTA_LIMCREDITO or TRG_INSERTA_LIMCREDITO
      Sysdate:         25-04-2003
      Date/Time:       25-04-2003 12:28:37
      Date:            25-04-2003
      Time:            12:28:37
      Username:         (set in TOAD Options, Procedure Editor)
      Trigger Options:  AFTER INSERT ON VE_VE_VENDEDORES
FOR EACH ROW
******************************************************************************/

DECLARE

VCodMoneda FA_DATOSGENER.COD_MONEFACT%TYPE;
iCant NUMBER;
eErrorException EXCEPTION;
vCodTipcomis VE_TIPCOMIS.COD_TIPCOMIS%TYPE;

BEGIN
        VCodMoneda := '';
        iCant := 0;

        IF INSERTING THEN
                vCodTipcomis := :NEW.COD_TIPCOMIS;

                SELECT COUNT(1) INTO iCant
                FROM VE_TIPCOMIS
                WHERE IND_VTA_EXTERNA = 1
                AND COD_TIPCOMIS = vCodTipcomis;

                IF iCant > 0 THEN
                        iCant := 0;

                        SELECT COD_MONEFACT INTO VCodMoneda FROM
                        FA_DATOSGENER;

                        SELECT COUNT(1) INTO iCant
                        FROM GA_DIST_LCRED_TH
                        WHERE COD_VENDEDOR = :NEW.COD_VENDEDOR
                        AND FEC_HASTA IS NULL;

                        IF iCant > 0 THEN
                           RAISE eErrorException;
                        END IF;

                        INSERT INTO GA_DIST_LCRED_TH (
                        COD_VENDEDOR,
                        COD_CLIENTE,
                        FEC_DESDE,
                        FEC_HASTA,
                        MONTO_CREDITO,
                        COD_MONEDA,
                        NOM_USUARIO)
                        VALUES
                        (:NEW.COD_VENDEDOR,
                        :NEW.COD_CLIENTE,
                        SYSDATE,
                        NULL,
                        0,
                        VCodMoneda,
                        USER);
                END IF;
        ELSE
                DELETE GA_DIST_LCRED_TH
                WHERE COD_VENDEDOR = :OLD.COD_VENDEDOR;

        END IF;

   EXCEPTION
     WHEN eErrorException THEN
       NULL;
     WHEN OTHERS THEN
       NULL;
END TRG_INSERTA_LIMCREDITO;
/
SHOW ERRORS
