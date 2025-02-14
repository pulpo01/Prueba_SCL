CREATE OR REPLACE PACKAGE BODY PS_TIPO_COMPORTAMIENTO_U_PG
IS
  TIPO_DOMINIO_MODIFICABLE CONSTANT NUMBER(1) := 2;

  FUNCTION PS_MODIFICAR_FN
               (
               EV_valor GE_VALORES_dominios_td.valor%TYPE
			   ,EV_estado GE_VALORES_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor GE_VALORES_dominios_td.descripcion_valor%TYPE
	           ,EV_usu_modificacion GE_VALORES_dominios_td.usu_modificacion%TYPE
               )
      RETURN NUMBER
/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "PS_AGREGAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega un valor para un dominio. Se realiza la inserci¢n en la tabla GE_VALORES_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio a insertar</param>>
	<param nom="EV_valor" Tipo="STRING">Nuevo valor de domnio</param>>
	<param nom="EV_estado" Tipo="STRING">Estado del valor de dominio</param>
	<param nom="EV_descripcion_valor" Tipo="STRING">Descripci¢n del valor a insertar</param>
	<param nom="EV_usu_modificacion" Tipo="STRING>Usuario de modificacion del registro</param>>
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
     LN_registros_afectados := GE_VALORES_DOMINIOS_KNL_U_PG.GE_MODIFICAR_FN( TIPO_DOMINIO_MODIFICABLE, 'TIPO_COMPORTAMIENTO', EV_valor, EV_estado, EV_descripcion_valor, EV_usu_modificacion );

     RETURN LN_registros_afectados;

	  EXCEPTION
	      WHEN OTHERS THEN

	       RAISE_APPLICATION_ERROR(-20100, 'Error en PS_TIPO_COMPORTAMIENTO_U_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END PS_MODIFICAR_FN;


 END PS_TIPO_COMPORTAMIENTO_U_PG;
/
SHOW ERRORS
