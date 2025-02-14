CREATE OR REPLACE PACKAGE        mi_traspaso_pag IS
   PROCEDURE proc_main;
   PROCEDURE select_datos_generales;
   PROCEDURE insert_co_pagos;
   PROCEDURE select_mi_factura;
END mi_traspaso_pag;
/
SHOW ERRORS
