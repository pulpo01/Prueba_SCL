CREATE OR REPLACE FUNCTION AL_CONV_SERHEX_FN(v_serie IN al_series.num_serie%type  ) RETURN al_ser_numeracion.num_serhex%type
IS

v_ser8   al_ser_numeracion.num_serhex%type;
v_ser3   al_ser_numeracion.num_serhex%type;
v_ind    PLS_INTEGER;
v_int    NUMBER(8);
v_aux    al_ser_numeracion.num_serhex%type;
v_serhex al_ser_numeracion.num_serhex%type;

FUNCTION AL_HEX_FN(v_num IN NUMBER) RETURN al_ser_numeracion.num_serhex%type
IS
BEGIN
        IF v_num > 9 THEN
            RETURN chr(v_num - 9 + 64);
        ELSE
            RETURN to_char(v_num);
        END IF;
END AL_HEX_FN;

BEGIN
        v_ser8 := substr(ltrim(rtrim(v_serie)),4,8);
        v_ser3 := substr(ltrim(rtrim(v_serie)),1,3);
        v_int := to_number (v_ser3);
        for v_ind in 1..2 loop
           v_aux:=AL_HEX_FN(mod(v_int,16));
           v_serhex := nvl(v_aux || v_serhex,v_aux);
           v_int := trunc(v_int / 16);
        end loop;
        v_int := to_number (v_ser8);
        v_ser8 := null;
        for v_ind in 1..6 loop
           v_aux:=AL_HEX_FN(mod(v_int,16));
           v_ser8 := nvl(v_aux || v_ser8,v_aux);
           v_int := trunc(v_int / 16) ;
        end loop;
        v_serhex := v_serhex || v_ser8;

RETURN v_serhex;
END AL_CONV_SERHEX_FN;
/
SHOW ERRORS
