CREATE OR REPLACE PROCEDURE        p_obtiene_valoracion(
  v_tipstock IN al_movimientos.tip_stock%type ,
  v_valoracion IN OUT al_tipos_stock.ind_valorar%type )
IS
BEGIN
   select ind_valorar into v_valoracion
          from al_tipos_stock
          where tip_stock = v_tipstock;
EXCEPTION
   when OTHERS then
        raise_application_error (-20131,'<ALMACEN> Tipo de Stock Incorrecto'
                                 || to_char(SQLCODE));
END p_obtiene_valoracion;
/
SHOW ERRORS
