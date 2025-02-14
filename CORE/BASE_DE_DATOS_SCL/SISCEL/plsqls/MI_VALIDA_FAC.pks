CREATE OR REPLACE PACKAGE        mi_valida_fac IS
   PROCEDURE proc_main;
   PROCEDURE select_cliente;
   PROCEDURE select_detalle;
   PROCEDURE actualizar_errores;
END mi_valida_fac;
/
SHOW ERRORS
