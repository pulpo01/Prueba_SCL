CREATE OR REPLACE PROCEDURE GA_P_CATCUENTAS (
   vp_transac       IN   NUMBER,
   v_num_ident      IN   VARCHAR2,
   v_cod_catribut   IN   VARCHAR2,
   v_tipo_modulo    IN   NUMBER
)
IS
   v_error              NUMBER                                           := 0;
   v_cadena             ga_transacabo.des_cadena%TYPE                      := NULL;
   v_error_proc      	ga_transacabo.des_cadena%TYPE                      := NULL;
   v_tipo_aux           Char (1)  					   := '1';
   v_cadena_aux         ga_transacabo.des_cadena%TYPE                      := NULL;
BEGIN

   v_tipo_aux := TO_CHAR (v_tipo_modulo);
   --v_cadena_aux := v_num_ident || ',' || v_cod_catribut || ',' || v_tipo_aux;
   v_cadena_aux := '''' || v_num_ident || '''' || ',' || '''' || v_cod_catribut || ''''|| ',' || '''' || v_tipo_aux|| '''';
   v_cadena := ge_fn_ejecuta_rutina('GA', 2, v_cadena_aux);

   v_error := 0;

   v_error_proc :=  Substr(v_cadena, 1,5);

   IF v_error_proc <> 'ERROR'
   THEN
   	   INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
   	   VALUES (vp_transac, v_error, v_cadena);
   END IF;

END ga_p_catcuentas;
/
SHOW ERRORS
