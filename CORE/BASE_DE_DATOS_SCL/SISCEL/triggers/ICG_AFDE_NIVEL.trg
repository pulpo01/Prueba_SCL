CREATE OR REPLACE TRIGGER icg_afde_nivel
AFTER DELETE
ON ICG_NIVELSERVICIO
FOR EACH ROW

DECLARE
   V_TABLA VARCHAR2(35):=NULL;
  BEGIN
  BEGIN
  V_TABLA := 'ICG_SERVICIO';
  UPDATE ICG_SERVICIO SET NUM_NIVELES = NUM_NIVELES - 1
   WHERE COD_SERVICIO = :OLD.COD_SERVICIO
     AND COD_PRODUCTO = :OLD.COD_PRODUCTO;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR
   (-20010,'ERROR TRIGGER ICG_AFDE_NIVEL: '||
    V_TABLA||' ORA'||TO_CHAR(SQLCODE),TRUE);
  END;
END;
/
SHOW ERRORS
