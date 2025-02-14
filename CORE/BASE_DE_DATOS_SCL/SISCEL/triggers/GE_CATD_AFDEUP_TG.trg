CREATE OR REPLACE TRIGGER GE_CATD_AFDEUP_TG
AFTER DELETE OR UPDATE
OF COD_CALIFICACION
  ,DES_CALIFICACION
  ,IND_VIGENCIA
  ,FEC_CREACION
  ,NOM_USUARIO
ON GE_CALIFICACION_TD 
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       GE_CATD_AFDEUP_TG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14-01-2010             1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     GE_CATD_AFDEUP_TG
      Sysdate:         14-01-2010
      Date and Time:   14-01-2010, 16:59:47, and 14-01-2010 16:59:47
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:      GE_CALIFICACION_TD (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   INSERT INTO GE_CALIFICACION_TH
        ( COD_CALIFICACION, DES_CALIFICACION ,IND_VIGENCIA ,FEC_CREACION, NOM_USUARIO)
    VALUES (:OLD.COD_CALIFICACION, :OLD.DES_CALIFICACION, :OLD.IND_VIGENCIA ,:OLD.FEC_CREACION, :OLD.NOM_USUARIO);

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END GE_CATD_AFDEUP_TG;
/
SHOW ERRORS
