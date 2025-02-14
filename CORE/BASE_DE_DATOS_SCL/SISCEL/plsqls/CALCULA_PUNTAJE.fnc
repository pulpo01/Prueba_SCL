CREATE OR REPLACE FUNCTION          "CALCULA_PUNTAJE" ( facturado IN number, antiguedad IN number )
  RETURN number IS
-- *************************************************************
-- * Funcion        : calcula_puntaje
-- * Salida         : puntaje correspondiente al valor facturado
-- * Descripcion    : Funcion que retorna el puntaje que correspnde
-- * al valor facturado, aplicando factor segun antiguedad y convir-
-- * tiendo a puntos
-- * Fecha de creacion  : Agosto 2000
-- * Responsable    : Thomas Armstrong (DMR Consulting)
-- *************************************************************
  factor_conv number;
  pond_ant number;
BEGIN
     -- buscar factor segun antiguedad
     if    antiguedad < to_number(obtiene_parametro('rango_ant_1')) then
       pond_ant := to_number(obtiene_parametro('pond_ant_1'));
     elsif antiguedad < to_number(obtiene_parametro('rango_ant_2')) then
       pond_ant := to_number(obtiene_parametro('pond_ant_2'));
     elsif antiguedad < to_number(obtiene_parametro('rango_ant_3')) then
       pond_ant := to_number(obtiene_parametro('pond_ant_3'));
     end if;
    factor_conv:=to_number(obtiene_parametro('factor_conv'));
     RETURN round(facturado * pond_ant * factor_conv ,0);
END;
/
SHOW ERRORS
