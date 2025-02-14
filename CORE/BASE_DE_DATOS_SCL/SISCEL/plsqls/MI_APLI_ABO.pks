CREATE OR REPLACE PACKAGE        mi_apli_abo IS
   PROCEDURE proc_main;
   PROCEDURE insert_co_pagosconc;
   PROCEDURE select_mi_abonhist;
   PROCEDURE procesar_cartera;
   PROCEDURE insert_co_cartera;
END mi_apli_abo;
/
SHOW ERRORS
