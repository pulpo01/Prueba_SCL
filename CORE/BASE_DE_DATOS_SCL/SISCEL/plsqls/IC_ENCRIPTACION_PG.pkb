CREATE OR REPLACE PACKAGE BODY IC_ENCRIPTACION_PG AS


FUNCTION IC_RECUPERASIMCARD_FN(EN_num_simcard IN GSM_DET_SIMCARD_TO.NUM_SIMCARD%TYPE, EV_campo IN GSM_DET_SIMCARD_TO.COD_CAMPO%TYPE) RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_RECUPERASIMCARD_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_ECU">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna el valor del campo (EV_campo) registrado para la simcard (EN_num_simcard)</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num_simcard" Tipo="VARCHAR2">simcard</param>
<param nom="EV_campo"       Tipo="VARCHAR2">nombre del campo</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_return GSM_DET_SIMCARD_TO.VAL_CAMPO%type;

BEGIN

        SELECT VAL_CAMPO INTO LV_return
        FROM   GSM_DET_SIMCARD_TO
        WHERE  NUM_SIMCARD=EN_num_simcard AND COD_CAMPO = EV_campo;

    RETURN LV_return;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
                  RETURN '0';
END IC_RECUPERASIMCARD_FN;

FUNCTION IC_ZMAE_FN(EV_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_ZMAE_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_ECU">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna la cadena requerida para la autenticación con la plataforma AUC de Nokia, en el marco del proyecto ZMAE</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="NUMBER">Número de movimiento que tiene asociada la ICC (simcard)</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_icc            VARCHAR2(100);
LV_imsi           VARCHAR2(100);
LV_imsimae    VARCHAR2(100);
LV_infomae        VARCHAR2(100);
LV_kimae          VARCHAR2(100);
LV_claveInteg VARCHAR2(100);

  BEGIN

   SELECT icc INTO LV_icc
   FROM icc_movimiento
   WHERE num_movimiento = EV_num_mov;

   LV_kimae      := IC_RECUPERASIMCARD_FN(LV_icc,'KI');

   LV_imsi       := IC_RECUPERASIMCARD_FN(LV_icc,'IMSI');

   LV_imsimae    := IC_IMSIMAE_FN(LV_imsi);

   LV_infomae    := IC_INFOMAE_FN(LV_icc);

   LV_kimae      := IC_RECUPERASIMCARD_FN(LV_icc,'KI');

   LV_claveInteg := IC_RECATA_PARAMETRO_FN('ZMAE_KEY');


  RETURN  'IMSI=' || LV_imsi || ',IMSIMAE=' || LV_imsimae || ',INFOMAE=' || LV_infomae || ',KIMAE='|| LV_kimae || ',K=' || LV_claveInteg ;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'ERROR IC_ZMAE_FN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
END;



FUNCTION IC_IMSIMAE_FN(EV_IMSI IN GSM_DET_SIMCARD_TO.VAL_CAMPO%TYPE) RETURN VARCHAR2 IS
 /*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_IMSIMAE_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_ECU">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna IMSI ofuscado</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="NUMBER">Número de movimiento que tiene asociada la ICC (simcard)</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
 LV_imsimae VARCHAR2(100);

 BEGIN

 LV_imsimae :=  EV_IMSI;

 LV_imsimae := LV_imsimae || 'F';

 LV_imsimae := IC_INVERTIR_EN_PARES_FN(LV_imsimae);

 LV_imsimae := '0F' || LV_imsimae;


  RETURN LV_imsimae;
 END;



 FUNCTION IC_INFOMAE_FN(EV_icc IN ICC_MOVIMIENTO.ICC%TYPE) RETURN VARCHAR2 IS
 /*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_INFOMAE_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_ECU">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna Información de la simcard ofuscada</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="NUMBER">ICC (simcard)</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
 LN_ind_llav_trans NUMBER;

 LV_a3            VARCHAR2(3);
 LV_a8            VARCHAR2(3);
 LV_EncKeyType    VARCHAR2(3);
 LV_IntKeyType    VARCHAR2(3);
 LV_IntKeyVersion VARCHAR2(3);
 LV_keyflag       VARCHAR2(3);
 LV_EncKeyVersion VARCHAR2(2);

 BEGIN
    LN_ind_llav_trans := TO_NUMBER(IC_RECUPERASIMCARD_FN(EV_icc,'TPORT_KEY'));

        LV_a3 := IC_RECUPERASIMCARD_FN(EV_icc,'A3/A8_ALG');
        if LV_a3  = '001' then
           LV_a3 := '04';
    end if;
        if LV_a3 = '002' then
           LV_a3 := '18';
        end if;

        LV_a8 := IC_RECUPERASIMCARD_FN(EV_icc,'A3/A8_ALG');
        if LV_a8 ='001' then
           LV_a8 := '04';
        end if;
        if LV_a8 ='002' then
           LV_a8 := '18';
        end if;
        LV_EncKeyType    := IC_RECATA_PARAMETRO_FN('ENCKEYTYPE');
        LV_IntKeyType    := IC_RECATA_PARAMETRO_FN('INTKEYTYPE');
        LV_IntKeyVersion := IC_RECATA_PARAMETRO_FN('INTKEYVERSION');
        LV_keyflag       := IC_RECATA_PARAMETRO_FN('KEYFLAG');
        LV_EncKeyVersion := IC_DEC2HEX_FN(LN_ind_llav_trans);

        IF length(LV_EncKeyVersion)=1 THEN
           LV_EncKeyVersion := '0' || LV_EncKeyVersion;
        END IF;


        RETURN LV_EncKeyType || LV_EncKeyVersion || LV_IntKeyType || LV_IntKeyVersion || LV_a3 || LV_a8 || LV_keyflag;

 END;


FUNCTION IC_RECATA_PARAMETRO_FN(EV_param IN GED_PARAMETROS.NOM_PARAMETRO%TYPE) RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_RECATA_PARAMETRO_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_ECU">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna el valor del parámetro registrado en la tabla GED_PARAMETROS</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_param" Tipo="VARCHAR2">Nombre del parámetro</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_campo GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN

 SELECT val_parametro INTO LV_campo FROM ged_parametros
 WHERE  nom_parametro = EV_param
 AND cod_producto = 1
 AND cod_modulo = 'IC';

 RETURN LV_campo;
END IC_RECATA_PARAMETRO_FN;


FUNCTION IC_INVERTIR_EN_PARES_FN(EV_cadena IN VARCHAR2) RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_INVERTIR_EN_PARES_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_ECU">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna una cadena invertida en pares</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_cadena" Tipo="VARCHAR2">cadena a invertir en pares</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_i                    NUMBER;
LV_par              VARCHAR2(2);
LV_cadena_final VARCHAR2(50);

BEGIN
LN_i:=1;
WHILE(LN_i<length(EV_cadena)) LOOP
        LV_par         := substr(EV_cadena,LN_i,2);
        LV_par         := substr(LV_par,2,1) || substr(LV_par,1,1);
        LV_cadena_final:= LV_cadena_final || LV_par;
        LN_i:=LN_i+2;
END LOOP;

RETURN LV_cadena_final;

END IC_INVERTIR_EN_PARES_FN;



FUNCTION IC_DEC2HEX_FN(EN_num IN NUMBER) RETURN VARCHAR2 IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_DEC2HEX_FN" Lenguaje="PL/SQL" Fecha="20-03-2006" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_ECU">
<Retorno>VARCHAR2</Retorno>
<Descripción>Convierte un número decimal en hexadecimal</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_num" Tipo="NUMBER">Número decimal a convertir</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LV_hexval    VARCHAR2(64);
  LN_n2        NUMBER := EN_num;
  LN_digit     NUMBER;
  LC_hexdigit  CHAR;
BEGIN

  WHILE ( LN_n2 > 0 ) LOOP
     LN_digit := mod(LN_n2, 16);
     IF LN_digit > 9 THEN
        LC_hexdigit := chr(ascii('A') + LN_digit - 10);
     ELSE
        LC_hexdigit := to_char(LN_digit);
     END IF;
     LV_hexval := LC_hexdigit || LV_hexval;
     LN_n2 := trunc( LN_n2 / 16 );
  END LOOP;
  RETURN LV_hexval;

END IC_DEC2HEX_FN;

END  IC_ENCRIPTACION_PG;
/
SHOW ERRORS
