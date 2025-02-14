CREATE OR REPLACE TRIGGER GED_PARAMETROS_AF_DLINUP_TG
BEFORE DELETE OR INSERT OR UPDATE
ON GED_PARAMETROS
FOR EACH ROW
DECLARE
BEGIN


  IF (:new.nom_parametro = 'DIAS_MAX_SUSPROG' OR :new.nom_parametro = 'POR_COBRO_RECONPROG' OR :old.nom_parametro = 'DIAS_MAX_SUSPROG' OR :old.nom_parametro = 'POR_COBRO_RECONPROG') THEN

    IF INSERTING THEN
       INSERT INTO GED_PARAMETROS_TD
                   (nom_parametro,cod_modulo,cod_producto,val_parametro,des_parametro,nom_usuario,fec_alta,fec_auditoria)
            VALUES (:new.nom_parametro,:new.cod_modulo,:new.cod_producto,:new.val_parametro,:new.des_parametro,:new.nom_usuario,:new.fec_alta,SYSDATE);
    ELSIF UPDATING THEN
       INSERT INTO GED_PARAMETROS_TD
                   (nom_parametro,cod_modulo,cod_producto,val_parametro,des_parametro,nom_usuario,fec_alta,fec_auditoria)
            VALUES (:new.nom_parametro,:new.cod_modulo,:new.cod_producto,:new.val_parametro,:new.des_parametro,:new.nom_usuario,:new.fec_alta,SYSDATE);
    ELSIF DELETING THEN
       INSERT INTO GED_PARAMETROS_TD
                   (nom_parametro,cod_modulo,cod_producto,val_parametro,des_parametro,nom_usuario,fec_alta,fec_auditoria)
            VALUES (:old.nom_parametro,:old.cod_modulo,:old.cod_producto,:old.val_parametro,:old.des_parametro,:old.nom_usuario,:old.fec_alta,SYSDATE);
    END IF;

  END IF;

   EXCEPTION
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20098,'Se produjo un error al registrar histórico. - ['||SQLCODE||'] -- ['||SQLERRM||']');

END PV_DT_SUSPVP_TO_AF_DLINUP_TG;
/
SHOW ERRORS
