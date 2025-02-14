CREATE OR REPLACE PACKAGE        mi_valida_pac IS
   PROCEDURE proc_main;
   PROCEDURE select_cliente;
   PROCEDURE select_unipac;
   PROCEDURE select_cartera;
   PROCEDURE actualizar_errores;
END mi_valida_pac;
/
SHOW ERRORS
