CREATE OR REPLACE PROCEDURE            MSG_MENSAJES_NOACTIVOS (
pr_NUM_IDENT_O        in WGED_MENSAJERIA.NUM_IDENT_O%TYPE,
pr_FECHA              varchar2
)
as
BEGIN
update WGED_MENSAJERIA
set ELIMINAR = '1'
where NUM_IDENT_O = pr_NUM_IDENT_O
and fecha = to_date(pr_FECHA, 'dd-mm-yyyy hh24:mi:ss');
END;
/
SHOW ERRORS
