CREATE OR REPLACE TRIGGER GE_SETD_AFDEUP_TG
AFTER DELETE OR UPDATE
OF COD_TIPO     ,
COD_SEGMENTO ,
DES_SEGMENTO ,
FEC_CREACION ,
NOM_USUARORA 
ON GE_SEGMENTACION_CLIENTES_TD 
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       GE_SETD_AFDEUP_TG
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        25-01-2010             1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     GE_SETD_AFDEUP_TG
      Sysdate:         14-01-2010
      Date and Time:   14-01-2010, 17:01:24, and 14-01-2010 17:01:24
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:      GE_INDDEFAULT_TD (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   INSERT INTO GE_SEGMENTACION_CLIENTES_TH
        ( COD_TIPO , COD_SEGMENTO , DES_SEGMENTO , FEC_CREACION , NOM_USUARORA )
    VALUES (:OLD.COD_TIPO , :OLD.COD_SEGMENTO , :OLD.DES_SEGMENTO , :OLD.FEC_CREACION , :OLD.NOM_USUARORA );

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END GE_SETD_AFDEUP_TG;
/
SHOW ERRORS
