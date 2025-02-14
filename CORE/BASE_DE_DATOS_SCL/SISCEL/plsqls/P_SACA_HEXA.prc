CREATE OR REPLACE procedure P_SACA_HEXA
(V_VALOR IN VARCHAR2,
V_HEXA OUT VARCHAR2) IS
--
-- *************************************************************
-- * procedimiento      : P_SACA_HEXA
-- * Descripcion        : Obtiene hexadecimal de la serie
-- * Fecha de creacion  :
-- * Responsable        : Logistica
-- *************************************************************
--
v_serie_aux AL_SERIES.NUM_SERIE%TYPE;
v_valor_ant number(9);
resto_aux varchar2(9);
v_resto_final  varchar2(9);
BEGIN
  v_serie_aux:=to_number(v_valor);
  v_valor_ant:=v_serie_aux;
  WHILE v_serie_aux > 0 LOOP
     v_serie_aux:=floor(v_valor_ant/16);
        --cuociente
     resto_aux:= to_char(mod(v_valor_ant,16));
  --resto
     if resto_aux ='10' then
       resto_aux:='A';
     elsif resto_aux ='11' then
       resto_aux:='B';
     elsif resto_aux ='12' then
       resto_aux:='C';
     elsif resto_aux ='13' then
       resto_aux:='D';
     elsif resto_aux ='14' then
       resto_aux:='E';
     elsif resto_aux ='15' then
       resto_aux:='F';
     end if;
     v_resto_final:=resto_aux||v_resto_final;
     v_valor_ant:=v_serie_aux;
  END LOOP;
  v_hexa:=ltrim(rtrim(v_resto_final));
END;
/
SHOW ERRORS
