CREATE OR REPLACE PACKAGE        mi_suma IS
   PROCEDURE proc_main;
   PROCEDURE sumar_factura;
   PROCEDURE sumar_pagos;
   PROCEDURE sumar_pagosconc;
   PROCEDURE sumar_ajuste_nc;
   PROCEDURE sumar_ajuste_nd;
   PROCEDURE sumar_cartera;
END mi_suma;
/
SHOW ERRORS
