CREATE OR REPLACE PACKAGE        mi_apli_pag IS
   PROCEDURE proc_main;
   PROCEDURE insert_co_pagosconc;
   PROCEDURE select_factura;
   PROCEDURE select_fa_histdocu;
   PROCEDURE select_mi_pagohist;
   PROCEDURE procesar_cartera;
   PROCEDURE insert_co_cartera;
END mi_apli_pag;
/
SHOW ERRORS
