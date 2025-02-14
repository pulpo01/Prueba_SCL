CREATE OR REPLACE PACKAGE BODY FA_NIVEL_IMPRESION_I_PG
IS
  TIPO_DOMINIO_MODIFICABLE CONSTANT NUMBER(1) := 2;

  FUNCTION FA_AGREGAR_FN
               (
               EV_valor ge_valores_dominios_td.valor%TYPE
			   ,EV_estado ge_valores_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor ge_valores_dominios_td.descripcion_valor%TYPE
	           ,EV_usu_creacion ge_valores_dominios_td.usu_creacion%TYPE
               )
      RETURN NUMBER
/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_AGREGAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise?ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega un valor para un dominio. Se realiza la inserci¢n en la tabla GE_VALORES_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio a insertar</param>>
	<param nom="EV_valor" Tipo="STRING">Nuevo valor de domnio</param>>
	<param nom="EV_estado" Tipo="STRING">Estado del valor de dominio</param>
	<param nom="EV_descripcion_valor" Tipo="STRING">Descripci¢n del valor a insertar</param>
	<param nom="EV_usu_creacion" Tipo="STRING>Usuario de creacion del registro</param>>
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
     LN_registros_afectados := GE_VALORES_DOMINIOS_KNL_I_PG.GE_AGREGAR_FN( TIPO_DOMINIO_MODIFICABLE, 'NIVEL_IMPRESION', EV_valor, EV_estado, EV_descripcion_valor, EV_usu_creacion );

     RETURN LN_registros_afectados;

	  EXCEPTION
	      WHEN OTHERS THEN

	       RAISE_APPLICATION_ERROR(-20100, 'Error en FA_NIVEL_IMPRESION_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END FA_AGREGAR_FN;


 END FA_NIVEL_IMPRESION_I_PG;
/
SHOW ERRORS
