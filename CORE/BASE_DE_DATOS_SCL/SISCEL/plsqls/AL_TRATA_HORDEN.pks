CREATE OR REPLACE PACKAGE AL_TRATA_HORDEN IS
  PROCEDURE p_insert_hcabord(
  v_hcabord IN al_hcabecera_ordenes%rowtype )
;
  PROCEDURE p_delete_hcabord(
  v_hcabord IN al_hcabecera_ordenes%rowtype )
;
  PROCEDURE p_insert_hlinord(
  v_hlinord IN al_hlineas_ordenes%rowtype )
;
  PROCEDURE p_delete_hlinord(
  v_hlinord IN al_hlineas_ordenes%rowtype )
;
  PROCEDURE p_insert_hserord(
  v_hserord IN al_hseries_ordenes%rowtype )
;
  PROCEDURE p_delete_hserord(
  v_hserord IN al_hseries_ordenes%rowtype )
;
  solapa exception;
  v_sql       varchar2(1024);
  v_tabla     varchar2(30);
  v_cursor    integer;
  v_filas     integer;
--------------
--------------
--------------
--------------
END AL_TRATA_HORDEN; 
/
SHOW ERRORS
