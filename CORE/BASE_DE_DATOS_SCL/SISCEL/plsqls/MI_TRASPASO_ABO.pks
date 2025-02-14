CREATE OR REPLACE PACKAGE        mi_traspaso_abo IS
   PROCEDURE proc_main;
   PROCEDURE select_datos_generales;
   PROCEDURE insert_co_pagos;
END mi_traspaso_abo;
/
SHOW ERRORS
