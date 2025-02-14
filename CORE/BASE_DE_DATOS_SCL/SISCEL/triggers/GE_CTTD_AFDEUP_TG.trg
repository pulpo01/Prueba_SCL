CREATE OR REPLACE TRIGGER GE_CTTD_AFDEUP_TG
AFTER DELETE OR UPDATE
OF COD_CATEGORIA, 
DES_CATEGORIA, 
IND_ASESOR, 
IND_VIGENCIA, 
FEC_IND_VIGENCIA, 
NOM_USU_INDVIGENCIA, 
FEC_ULTMOD, 
NOM_USUARIO
ON GE_CATEGORIAS  
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       GE_CTTD_AFDEUP_TG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        25-01-2010             1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     GE_CTTD_AFDEUP_TG
      Sysdate:         14-01-2010
      Date and Time:   14-01-2010, 17:01:24, and 14-01-2010 17:01:24
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:      GE_INDDEFAULT_TD (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   INSERT INTO GE_CATEGORIAS_TH
        (COD_CATEGORIA, DES_CATEGORIA, IND_ASESOR, IND_VIGENCIA, FEC_IND_VIGENCIA, NOM_USU_INDVIGENCIA, FEC_ULTMOD, NOM_USUARIO)
    VALUES (:OLD.COD_CATEGORIA, :OLD.DES_CATEGORIA, :OLD.IND_ASESOR, :OLD.IND_VIGENCIA, :OLD.FEC_IND_VIGENCIA, :OLD.NOM_USU_INDVIGENCIA, :OLD.FEC_ULTMOD, :OLD.NOM_USUARIO);

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END GE_CTTD_AFDEUP_TG;
/
SHOW ERRORS