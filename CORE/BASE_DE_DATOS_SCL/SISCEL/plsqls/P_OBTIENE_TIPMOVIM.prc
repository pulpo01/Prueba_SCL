CREATE OR REPLACE PROCEDURE        p_obtiene_tipmovim(
  v_tipmovim IN al_movimientos.tip_movimiento%type ,
  v_entsal IN OUT al_tipos_movimientos.ind_entsal%type )
IS
BEGIN
   select ind_entsal into v_entsal
          from al_tipos_movimientos
          where tip_movimiento  = v_tipmovim;
EXCEPTION
   when OTHERS then
    raise_application_error (-20130,'<ALMACEN> Tipo movimiento Incorrecto '
                                 || to_char(SQLCODE));
END p_obtiene_tipmovim;
/
SHOW ERRORS
