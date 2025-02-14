CREATE OR REPLACE PACKAGE BODY GE_OPERADORAS_KNL_D_PG
IS

  FUNCTION GE_ELIMINAR_FN
               (
               EV_cod_operadora ge_operadoras_td.cod_operadora%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_ELIMINAR_FN Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Elimina una operadora</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_operadora" Tipo="STRING">Codigo de operadora</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN
               DELETE
               ge_operadoras_vw
               WHERE
               cod_operadora = EV_cod_operadora
               ;

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN

	       RAISE_APPLICATION_ERROR(-20100, 'Error en GE_OPERADORAS_D_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_ELIMINAR_FN;


 END GE_OPERADORAS_KNL_D_PG;
/
SHOW ERRORS
