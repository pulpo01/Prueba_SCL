CREATE OR REPLACE PACKAGE BODY PF_CANAL_DISTRIBUCION_D_PG
IS
  TIPO_DOMINIO_MODIFICABLE CONSTANT NUMBER(1) := 2;

  FUNCTION PF_ELIMINAR_FN
               (
                EV_valor GE_VALORES_dominios_td.valor%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "PF_ELIMINAR_FN Lenguaje="PL/SQL" Fecha="" Version"1.0.0" Diseñador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina un valor de un dominio. Se realiza la eliminación en la tabla GE_VALORES_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio a eliminar</param>
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
     LN_registros_afectados := GE_VALORES_DOMINIOS_KNL_D_PG.GE_ELIMINAR_FN( TIPO_DOMINIO_MODIFICABLE, 'CANAL_DISTRIBUCION', EV_valor );

     RETURN LN_registros_afectados;

	  EXCEPTION
	      WHEN OTHERS THEN

	       RAISE_APPLICATION_ERROR(-20100, 'Error en PF_CANAL_DISTRIBUCION_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END PF_ELIMINAR_FN;


 END PF_CANAL_DISTRIBUCION_D_PG;
/
SHOW ERRORS
