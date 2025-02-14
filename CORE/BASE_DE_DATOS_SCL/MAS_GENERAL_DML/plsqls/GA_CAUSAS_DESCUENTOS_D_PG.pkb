CREATE OR REPLACE PACKAGE BODY GA_CAUSAS_DESCUENTOS_D_PG
IS
  TIPO_DOMINIO_MODIFICABLE CONSTANT NUMBER(1) := 2;

  FUNCTION GA_ELIMINAR_FN
               (
                EV_valor ge_valores_dominios_td.valor%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GA_ELIMINAR_FN Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina un valor de un dominio. Se realiza la eliminaci¢n en la tabla GE_VALORES_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_valor" Tipo="STRING">Nuevo valor de domnio</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
     LN_registros_afectados NUMBER;
  BEGIN
     LN_registros_afectados := GE_VALORES_DOMINIOS_KNL_D_PG.GE_ELIMINAR_FN( TIPO_DOMINIO_MODIFICABLE, 'CAUSAS_DESCUENTOS', EV_valor );

     RETURN LN_registros_afectados;

	  EXCEPTION
	      WHEN OTHERS THEN

	       RAISE_APPLICATION_ERROR(-20100, 'Error en GA_CAUSAS_DESCUENTOS_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GA_ELIMINAR_FN;


 END GA_CAUSAS_DESCUENTOS_D_PG;
/
SHOW ERRORS
