CREATE OR REPLACE TRIGGER GE_COTD_AFDEUP_TG
AFTER DELETE OR UPDATE
OF COD_COLOR
  ,DES_COLOR
  ,IND_VIGENCIA
  ,FEC_CREACION
  ,NOM_USUARIO
ON GE_COLOR_TD 
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14-01-2010             1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         14-01-2010
      Date and Time:   14-01-2010, 16:57:20, and 14-01-2010 16:57:20
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:      GE_COLOR_TD (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN

    INSERT INTO GE_COLOR_TH
        ( COD_COLOR, DES_COLOR, IND_VIGENCIA, FEC_CREACION, NOM_USUARIO)
    VALUES (:OLD.COD_COLOR, :OLD.DES_COLOR, :OLd.IND_VIGENCIA, :OLD.FEC_CREACION, :OLD.NOM_USUARIO);

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/
SHOW ERRORS