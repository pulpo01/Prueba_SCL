CREATE OR REPLACE PACKAGE BODY        mi_suma IS
total_cartera         NUMBER(16);
total_factura         NUMBER(16);
total_pago            NUMBER(16);
total_pagosconc       NUMBER(16);
total_general         NUMBER(16);
total_ajuste_nc       NUMBER(16);
total_ajuste_nd       NUMBER(16);
total_dif             NUMBER(16);
dif_pago              NUMBER(16);
  /*----- PROCEDURE PRINCIPAL PROC_MAIN -----*/
  PROCEDURE proc_main IS
    BEGIN
      mi_suma.sumar_factura;
      dbms_output.put_line('TOTAL FACTURA    :'|| total_factura);
      mi_suma.sumar_ajuste_nc;
      dbms_output.put_line('TOTAL AJUSTE NC  :'|| total_ajuste_nc);
      mi_suma.sumar_ajuste_nd;
      dbms_output.put_line('TOTAL AJUSTE ND  :'|| total_ajuste_nd);
      mi_suma.sumar_pagos;
      dbms_output.put_line('TOTAL PAGOS SIN  :'|| total_pago);
      mi_suma.sumar_pagosconc;
      dif_pago:= total_pago-total_pagosconc;
      dbms_output.put_line('TOTAL PAGOSCONC  :'|| total_pagosconc);
      dbms_output.put_line('DIFERENCIA PAGO  :'|| dif_pago);
      total_pago := total_pago - total_ajuste_nc - total_ajuste_nd;
      dbms_output.put_line('TOTAL PAGOS      :'|| total_pago);
      total_general := total_factura              -
		       total_pago                 -
		       total_ajuste_nc            +
		       total_ajuste_nd;
      dbms_output.put_line('TOTAL SUMADO     :'|| total_general);
      mi_suma.sumar_cartera;
      dbms_output.put_line('TOTAL CO_CARTERA :'|| total_cartera);
      total_dif := total_general - total_cartera;
      dbms_output.put_line('DIFERENCIA       :'|| total_dif);
  END proc_main;
  /*----- FIN PROCEDURE PRINCIPAL PROC_MAIN -----*/
  PROCEDURE sumar_cartera IS
    BEGIN
       SELECT SUM(importe_debe-importe_haber)
	 INTO total_cartera
	 FROM co_cartera;
  END sumar_cartera;
  PROCEDURE sumar_factura IS
    BEGIN
       SELECT SUM(tot_pagar)
	 INTO total_factura
	 FROM fa_histdocu;
  END sumar_factura;
  PROCEDURE sumar_pagos IS
    BEGIN
       SELECT SUM(imp_pago)
	 INTO total_pago
	 FROM co_pagos;
  END sumar_pagos;
  PROCEDURE sumar_pagosconc IS
    BEGIN
       SELECT SUM(imp_concepto)
	 INTO total_pagosconc
	 FROM co_pagosconc;
  END sumar_pagosconc;
  PROCEDURE sumar_ajuste_nc IS
    BEGIN
       SELECT SUM(importe_debe)
	 INTO total_ajuste_nc
	 FROM co_ajustes
	 WHERE cod_tipdocum = 9;
  END sumar_ajuste_nc;
  PROCEDURE sumar_ajuste_nd IS
    BEGIN
       SELECT SUM(importe_debe)
	 INTO total_ajuste_nd
	 FROM co_ajustes
	 WHERE cod_tipdocum = 10;
  END sumar_ajuste_nd;
END mi_suma;
/
SHOW ERRORS
