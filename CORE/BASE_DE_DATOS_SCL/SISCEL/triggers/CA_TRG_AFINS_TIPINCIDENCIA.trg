CREATE OR REPLACE TRIGGER CA_TRG_AFINS_TIPINCIDENCIA
 AFTER INSERT ON CA_TIPINCIDENCIAS
FOR EACH ROW

DECLARE
pTipIncidencia CA_TIPINCIDENCIAS.TIP_INCIDENCIA%TYPE;
pDesIncidencia CA_TIPINCIDENCIAS.DES_INCIDENCIA%TYPE;
-- Trigger desde CA_TIPINCIDENCIAS que llama un prodecimiento para asegurar
-- consistencia entre esta tabla y ge_multiidioma
-- Creacion : 30 de mayo de 2002
-- Autor : Alejandra Montealegre
BEGIN
        pTipIncidencia:=:NEW.TIP_INCIDENCIA;
        pDesIncidencia:=:NEW.DES_INCIDENCIA;
        BEGIN
                 CA_PR_MUL_IDIOMA_TIPINCIDENCIA (pTipIncidencia,pDesIncidencia);
        END;
   EXCEPTION
     WHEN OTHERS THEN
       Null;
END CA_TRG_AFINS_TIPINCIDENCIA;
/
SHOW ERRORS
