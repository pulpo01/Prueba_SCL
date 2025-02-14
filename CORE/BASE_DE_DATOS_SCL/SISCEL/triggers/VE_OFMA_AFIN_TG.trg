CREATE OR REPLACE TRIGGER VE_OFMA_AFIN_TG
AFTER INSERT OR DELETE
ON VE_OFIMATRIZ_TD
FOR EACH ROW
-- *********************************************************************************************************************
-- <Documentaci�n TipoDoc = "TRIGGER">
-- <Elemento Nombre = " VE_OFMA_AFIN_TG Lenguaje="PL/SQL" Fecha="10-05-2005" Versi�n="1.0" Dise�ador="Ulises Uribe" Programador="Claudia Galvez" Ambiente="BD">
-- <Retorno></Retorno>
-- <Descripci�n>Trigger que registra los movimientos de relaciones Oficinar / Matriz</Descripci�n>
-- <Par�metros>
-- <Entrada>
-- </Entrada>
-- <Salida>
-- </Salida>
-- </Par�metros>
-- </Elemento>
-- </Documentaci�n>
-- **********************************************************************************************************************
DECLARE

--Constantes
Ci_Zero   CONSTANT  PLS_INTEGER :=0;
Ci_Uno    CONSTANT  PLS_INTEGER :=1;


--Variables
LV_Glosa  VARCHAR2(200) ;

BEGIN

	 IF INSERTING   THEN
       	BEGIN

	         	 INSERT INTO VE_OFIMATRIZ_TH
	             (COD_MATRIZ, COD_OFICINA, USU_CREACION, FEC_REGISTRO, COD_ACCION)
	             VALUES
	             (:NEW.COD_MATRIZ, :NEW.COD_OFICINA, :NEW.USU_CREACION, :NEW.FEC_CREACION, Ci_Zero);
          	 	 EXCEPTION
	          		   WHEN OTHERS THEN
			 	  	   LV_Glosa := 'ERROR INSERTANDO NUEVO REGISTRO EN VE_OFIMATRIZ_TH';
	              	   RAISE_APPLICATION_ERROR(-20003, LV_Glosa||' : ' || SQLERRM);
        END;
    END IF;
--*******************************
-- Opci�n de borrado de registro.
--*******************************
  	 IF DELETING   THEN
       	BEGIN

	         	 INSERT INTO VE_OFIMATRIZ_TH
	             (COD_MATRIZ, COD_OFICINA, USU_CREACION, FEC_REGISTRO, COD_ACCION)
	             VALUES
	             (:OLD.COD_MATRIZ, :OLD.COD_OFICINA, USER, SYSDATE, Ci_Uno);
          	 	 EXCEPTION
	          		   WHEN OTHERS THEN
			 	  	   LV_Glosa := 'ERROR INSERTANDO  REGISTRO ELIMINADO EN  VE_OFIMATRIZ_TH';
	              	   RAISE_APPLICATION_ERROR(-20003, LV_Glosa||' : ' || SQLERRM);
        END;
    END IF;
END VE_OFMA_AFIN_TG;
/
SHOW ERRORS
