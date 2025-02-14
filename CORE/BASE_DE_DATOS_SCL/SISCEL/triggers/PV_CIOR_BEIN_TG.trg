CREATE OR REPLACE TRIGGER PV_CIOR_BEIN_TG
BEFORE INSERT ON CI_ORSERV
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE


  v_proceso        VARCHAR2(25);
  s_tabla		   VARCHAR2(15);

  nCant			   NUMBER(2);
  nError		   NUMBER(2);
  nTraza		   NUMBER(2);
  nSecuencia	   NUMBER(9);
  sMsgTraza		   VARCHAR2(100);
  sDiasForma	   VARCHAR2(20);

--	 Autor     : Christian Estay M. (Posventa)
--   Fecha     : 10/11/2003
--	 Comentario; Realiza la Inscripcion en la lista Negra de la Serie Informada por
--	 			 Otras Operadoras(EXTERNAS).

BEGIN

	 nTraza := 0;

	 BEGIN

	  IF :NEW.COD_MODULO IS NOT NULL OR ltrim(rtrim(:NEW.COD_MODULO)) <> '' THEN

	  	  PV_INFORMAR_ESTADO_TAFI_PR(:NEW.COD_MODULO,:NEW.ID_GESTOR,:NEW.COD_INTER,NULL,'CERRADA','CERRADA');

	  END IF;


     EXCEPTION
	     WHEN OTHERS THEN
		      RAISE_APPLICATION_ERROR  (-20002,'ERROR AL INSETAR EN PV_SERIELN_INT_TO : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);

	 END;



EXCEPTION
    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);

END PV_CIOR_BEIN_TG;
/
SHOW ERRORS
