CREATE OR REPLACE PACKAGE        mi_valida_abo IS
   PROCEDURE proc_main;
   PROCEDURE select_cliente;
   PROCEDURE actualizar_errores;
END mi_valida_abo;
/
SHOW ERRORS
