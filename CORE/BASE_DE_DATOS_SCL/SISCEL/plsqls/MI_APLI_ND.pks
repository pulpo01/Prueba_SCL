CREATE OR REPLACE PACKAGE        mi_apli_nd IS
   PROCEDURE proc_main;
   PROCEDURE insert_co_pagosconc;
   PROCEDURE select_factura;
   PROCEDURE select_fa_histdocu;
   PROCEDURE select_mi_ajushist;
   PROCEDURE insert_co_cartera;
END mi_apli_nd;
/
SHOW ERRORS
