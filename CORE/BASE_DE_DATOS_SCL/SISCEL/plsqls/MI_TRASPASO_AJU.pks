CREATE OR REPLACE PACKAGE        mi_traspaso_aju IS
   PROCEDURE proc_main;
   PROCEDURE select_datos_generales;
   PROCEDURE select_datos_gene_pago;
   PROCEDURE insert_co_ajuste;
   PROCEDURE insert_detalle;
   PROCEDURE insert_co_pagos;
END mi_traspaso_aju;
/
SHOW ERRORS
