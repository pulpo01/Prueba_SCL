CREATE OR REPLACE TRIGGER GE_INTD_AFDEUP_TG
AFTER DELETE OR UPDATE
OF NOM_TABLA
  ,DES_TABLA
  ,NOM_COLUMNA
  ,COD_DEFAULT
  ,FEC_CREACION
  ,NOM_USUARIO
ON GE_INDDEFAULT_TD 
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       GE_INTD_AFDEUP_TG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14-01-2010             1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     GE_INTD_AFDEUP_TG
      Sysdate:         14-01-2010
      Date and Time:   14-01-2010, 17:01:24, and 14-01-2010 17:01:24
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:      GE_INDDEFAULT_TD (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   INSERT INTO GE_INDDEFAULT_TH
        ( NOM_TABLA, DES_TABLA, NOM_COLUMNA, COD_DEFAULT, FEC_CREACION, NOM_USUARIO)
    VALUES (:OLD.NOM_TABLA, :OLD.DES_TABLA, :OLD.NOM_COLUMNA, :OLD.COD_DEFAULT, :OLD.FEC_CREACION, :OLD.NOM_USUARIO);

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END GE_INTD_AFDEUP_TG;
/
SHOW ERRORS