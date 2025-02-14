CREATE OR REPLACE PACKAGE BODY GE_ERRORES_KNL_D_PG
IS

  FUNCTION GE_ELIMINAR_FN
               (
               EN_cod_mensaje ge_errores_td.cod_msgerror%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ELIMINAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina errores de negocio</Descripci¢n>
	<Parametros>
	<Entrada>
        <param nom="EN_cod_mensaje" Tipo="NUMBER">Codigo del error</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN
              DELETE GE_ERRORES_TD
               WHERE
			       COD_MSGERROR =EN_cod_mensaje;

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN

	      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_ERRORES_KNL_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ELIMINAR_FN;


 END GE_ERRORES_KNL_D_PG;
/
SHOW ERRORS
