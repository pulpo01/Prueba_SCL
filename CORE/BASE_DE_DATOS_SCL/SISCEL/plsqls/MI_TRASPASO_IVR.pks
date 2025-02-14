CREATE OR REPLACE PACKAGE        mi_traspaso_ivr IS
   PROCEDURE proc_main;
   PROCEDURE select_celular;
   PROCEDURE select_cartera;
   PROCEDURE select_minutos;
   PROCEDURE select_fechas;
   PROCEDURE insert_ivr;
END mi_traspaso_ivr;
/
SHOW ERRORS
