CREATE OR REPLACE FUNCTION        ge_fn_formatea_identclie_tmm (v_num_ident IN VARCHAR2, v_tip_ident IN VARCHAR2, v_bd_client NUMBER, v_ind_format IN NUMBER)
RETURN VARCHAR2 IS
BEGIN
-- MIGRACION 20020227 Se crea esta funcion para que funcione SCL, ya que no existia
-- retorna el mismo identificador que se le pasa como parametro
	RETURN v_num_ident;
END;
/
SHOW ERRORS
