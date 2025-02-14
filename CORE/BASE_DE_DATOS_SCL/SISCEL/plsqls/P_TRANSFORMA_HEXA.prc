CREATE OR REPLACE PROCEDURE        P_TRANSFORMA_HEXA
 (V_SERIE_ANT IN GA_ABOCEL.NUM_SERIE%TYPE,
V_SERIE_HEXA OUT GA_ABOCEL.NUM_SERIE%TYPE) IS
v_prefijo varchar2(3);
v_cuerpo varchar2(8);
v_hexa varchar2(8);
v_hexa_aux varchar2(8);
largo number(2);
BEGIN
  v_prefijo:=substr(v_serie_ant,1,3);
  v_cuerpo:=substr(v_serie_ant,4,8);
  P_SACA_HEXA(v_prefijo,v_hexa);
  v_serie_hexa:=v_hexa;
  P_SACA_HEXA(v_cuerpo,v_hexa);
  v_hexa_aux:=lpad(v_hexa,6,'0');
  v_serie_hexa:=ltrim(rtrim(v_serie_hexa)) || ltrim(rtrim(v_hexa_aux));
END;
/
SHOW ERRORS
