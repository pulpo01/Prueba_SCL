CREATE OR REPLACE PACKAGE BODY GE_DOMINIOS_KNL_D_PG
IS

  FUNCTION GE_ELIMINAR_FN
               (
               EV_cod_dominio ge_dominios_td.cod_dominio%TYPE
               )
      RETURN NUMBER  IS
	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ELIMINAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina un registro en la tabla GE_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio a eliminar</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
	  BEGIN
               DELETE
               ge_dominios_td
               WHERE
               cod_dominio = EV_cod_dominio
               ;

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN

	      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_DOMINIOS_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ELIMINAR_FN;


 END GE_DOMINIOS_KNL_D_PG;
/
SHOW ERRORS
