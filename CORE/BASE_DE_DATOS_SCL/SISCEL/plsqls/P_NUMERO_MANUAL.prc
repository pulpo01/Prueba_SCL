CREATE OR REPLACE PROCEDURE        p_numero_manual(
  v_subalm IN ge_subalms.cod_subalm%type ,
  v_central IN icg_central.cod_central%type ,
  v_celular IN al_series.num_telefono%type ,
  v_producto IN al_series.cod_producto%type ,
  v_uso IN al_usos.cod_uso%type ,
  v_cat IN al_series.cod_cat%type )
IS
v_dias ga_datosgener.num_resnum%type;
v_error NUMBER(1) := 0;
BEGIN
   p_select_dias(v_dias,
      v_error);
   IF v_error = 0 THEN
      p_manual_reutil(v_subalm,
         v_central,
         v_celular,
         v_producto,
         v_cat,
         v_uso,
         v_dias,
         v_error);
      IF v_error = 1 THEN
         v_error := 0;
         p_manual_uso(v_subalm,
            v_central,
            v_celular,
            v_producto,
            v_cat,
            v_uso,
            v_error);
         IF v_error = 1 THEN
            raise_application_error(-20177, '');
         ELSIF
            v_error = 2 THEN
            raise_application_error(-20123, '');
         END IF;
      ELSIF
         v_error = 2 THEN
         raise_application_error(-20123, '');
      END IF;
   END IF;
END p_numero_manual;
/
SHOW ERRORS
