CREATE OR REPLACE PROCEDURE        p_genera_docventa(
  v_docventa IN ga_docventa%rowtype )
IS
BEGIN
   insert into ga_docventa (num_venta,
                            cod_tipdocum,
                            num_folio)
                    values (v_docventa.num_venta,
                            v_docventa.cod_tipdocum,
                            v_docventa.num_folio);
EXCEPTION
   when OTHERS then
        raise_application_error (-20177,'Error Generacion Documento - Venta '
                                 || to_char(SQLCODE));
END p_genera_docventa;
/
SHOW ERRORS
