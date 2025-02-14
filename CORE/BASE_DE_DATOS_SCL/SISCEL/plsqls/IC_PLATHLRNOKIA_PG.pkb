CREATE OR REPLACE PACKAGE BODY IC_PLATHLRNOKIA_PG AS
/*
<Documentación TipoDoc = "CUERPO">
  <Elemento Nombre = "IC_PLATHLRNOKIA_PG" Lenguaje = "PL/SQL" Fecha = "29-07-2005"
    Versión = "1.1.0" Diseñador = "Carlos Sellao" Programador = "Carlos Sellao" Ambiente = "Oracle 8i">
    <Descripción> Funciones paramétricas orientadas a la plataforma de Infranet </Descripción>
    <Propietarios>
      <Prop>Interfaz con Centrales</Prop>
    </Propietarios>
  </Elemento>
</Documentación>
*/


FUNCTION IC_SERIALNUMBER_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_SERIALNUMBER_FN" Lenguaje="PL/SQL" Fecha="28-07-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Carlos Sellao H." Ambiente="Oracle 8i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener el serial number, compuesto por los 5 ultimos digitos del imei</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
<param nom="LV_serialnum" Tipo="STRING">Serial number. 5 ultimos digitos del imei.</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

RETURN STRING IS
--

    LV_num_imei       ga_abocel.num_imei%TYPE;
    LV_num_abonado    ga_abocel.num_abonado%TYPE;
    LV_serialnum      ga_abocel.num_imei%TYPE;
    error_proceso     EXCEPTION;
--
BEGIN

       SELECT
	           icc.num_abonado
	   INTO
	           LV_num_abonado
       FROM
	           icc_movimiento icc
       WHERE
	           icc.num_movimiento = EN_NUM_MOV;


       BEGIN
          SELECT
		        abo.num_imei
          INTO
		        LV_num_imei
          FROM
		        ga_abocel abo
          WHERE
		        abo.num_abonado = LV_num_abonado;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

  	      BEGIN
               SELECT
			          abo.num_imei
               INTO
			          LV_num_imei
               FROM
			          ga_aboamist abo
               WHERE
			          abo.num_abonado = LV_num_abonado;
  	      EXCEPTION
	  	     WHEN NO_DATA_FOUND THEN
		   		  RETURN 'ERROR '|| ' ABONADO NO EXISTE EN TABLAS DE POSTPAGO NI PREPAGO';
		     WHEN OTHERS THEN
			      RETURN 'ERROR '||SQLERRM;
          END;

	 	WHEN OTHERS THEN
			RETURN 'ERROR '||SQLERRM;
        END;

        LV_serialnum := NVL(SUBSTR(LV_num_imei,LENGTH(LV_num_imei)-4,5), CHR(0));

       RETURN LV_serialnum;

EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR IC_SERIALNUMBER_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR IC_SERIALNUMBER_FN, SQLCODE:' || TO_CHAR(SQLCODE) || ' SLQERRM:' || SQLERRM;
END;




FUNCTION IC_MSISDN_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE)
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_MSISDN_FN" Lenguaje="PL/SQL" Fecha="01-08-2005" Versión"1.0.0" Diseñador"Carlos Sellao H." Programador="Juan Gonzalez C." Ambiente="Oracle 9i">
<Retorno>NA</Retorno>
<Descripción>Funcion para obtener msisdn</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE">Numero de movimiento</param>
</Entrada>
<Salida>
</Salida>NA</Parámetros>
</Elemento>
</Documentación>
*/
RETURN STRING IS

    v_out STRING(512);
    v_num_cel VARCHAR2(512);
    v_num_cel_nue VARCHAR2(512);
    error_proceso EXCEPTION;
  BEGIN

    SELECT NVL(TO_CHAR(num_celular), ''), NVL(TO_CHAR(num_celular_nue),CHR(0))
        INTO v_num_cel, v_num_cel_nue
        FROM ICC_MOVIMIENTO
        WHERE num_movimiento = EN_NUM_MOV;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF v_num_cel_nue = CHR(0) THEN
      v_out := '57'||v_num_cel || '|' || '57'||v_num_cel;
        ELSE
          v_out := '57'||v_num_cel || '|' || '57'||v_num_cel_nue;
        END IF;

    RETURN v_out;

  EXCEPTION
    WHEN error_proceso THEN
      RETURN 'ERROR FN_COL_MSISDN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
    WHEN OTHERS THEN
      RETURN 'ERROR FN_COL_MSISDN, SQLCODE:' || TO_CHAR(SQLCODE) || 'SLQERRM:' || SQLERRM;
END;


END IC_PLATHLRNOKIA_PG;
/
SHOW ERRORS
