CREATE OR REPLACE PACKAGE BODY GE_OPERADORAS_KNL_I_PG
IS

  FUNCTION GE_AGREGAR_FN
               (
               EV_cod_operadora ge_operadoras_td.cod_operadora%TYPE
               ,EV_des_operadora ge_operadoras_td.des_operadora%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_AGREGAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega una operadora</Descripci¢n>
	<Parametros>
	<Entrada>
        <param nom="EV_cod_operadora" Tipo="STRING">Codigo de la operadora a eliminar</param>
	<param nom="EV_des_operadora" Tipo="STRING">Nuevo nombre de operadora</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN
               INSERT INTO
               ge_operadoras_td
               (
               cod_operadora
               ,des_operadora
               )
               VALUES
               (
               EV_cod_operadora
               ,EV_des_operadora
               );

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN

	      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_OPERADORAS_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_AGREGAR_FN;


 END GE_OPERADORAS_KNL_I_PG;
/
SHOW ERRORS
