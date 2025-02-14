CREATE OR REPLACE PACKAGE        mi_apli_nc IS
   PROCEDURE proc_main;
   PROCEDURE insert_co_pagosconc;
   PROCEDURE select_factura;
   PROCEDURE select_fa_histdocu;
   PROCEDURE select_mi_ajushist;
   PROCEDURE procesar_cartera;
   PROCEDURE insert_co_cartera;
   PROCEDURE sumar;
END mi_apli_nc;
/
SHOW ERRORS
