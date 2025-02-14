CREATE OR REPLACE PROCEDURE AL_PROC_EXTERNO_PR (p_id NUMBER, p_nom_login varchar2,p_id_destino number,p_nom_archivo varchar2)
IS
v_num_reg   NUMBER(10);
v_query     VARCHAR2(30);
BEGIN

   INSERT INTO AL_INGRESO_EXTERNO (ID,NOM_ARCHIVO,CODIGO_ESTADO,NOM_USUARIO,FEC_ESTADO)
   VALUES (p_id,p_nom_archivo,0,USER,sysdate);

commit;
exception
  when others then
    null;
END;
/
SHOW ERRORS
