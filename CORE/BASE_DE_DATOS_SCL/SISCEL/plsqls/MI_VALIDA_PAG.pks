CREATE OR REPLACE PACKAGE        mi_valida_pag IS
   PROCEDURE proc_main;
   PROCEDURE select_cliente;
   PROCEDURE select_abocel;
   PROCEDURE select_mi_factura1;
   PROCEDURE select_mi_factura2;
   PROCEDURE actualizar_errores;
END mi_valida_pag;
/
SHOW ERRORS
