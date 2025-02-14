CREATE OR REPLACE PACKAGE        mi_traspaso_fac IS
   PROCEDURE proc_main;
   PROCEDURE select_datos_generales;
   PROCEDURE insert_fa_histdocu;
   PROCEDURE insert_detalle;
END mi_traspaso_fac;
/
SHOW ERRORS
