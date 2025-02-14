CREATE OR REPLACE PACKAGE        mi_valida_aju IS
   PROCEDURE proc_main;
   PROCEDURE select_cliente;
   PROCEDURE select_detalle;
   PROCEDURE select_abocel;
   PROCEDURE select_mi_factura;
   PROCEDURE actualizar_errores;
   PROCEDURE actualizar_detalle;
END mi_valida_aju;
/
SHOW ERRORS
