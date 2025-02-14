CREATE OR REPLACE PACKAGE BODY GE_DOMINIOS_KNL_U_PG
IS

  FUNCTION GE_MODIFICAR_FN
               (
               EV_cod_dominio ge_dominios_td.cod_dominio%TYPE
               ,EN_tipo ge_dominios_td.tipo%TYPE
               ,EV_nombre ge_dominios_td.nombre%TYPE
			   ,ED_usu_modificacion ge_dominios_td.usu_modificacion%TYPE
               )
      RETURN NUMBER
  IS
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_MODIFICAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Modifica un registro en la tabla GE_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio a eliminar</param>
	<param nom="EV_tipo" Tipo="STRING">Codigo de dominio a modificar</param>
	<param nom="EV_nombre" Tipo="STRING">Nuevo nombre de dominio</param>
	<param nom="EV_usu_modificacion" Tipo="STRING>Usu de modificaci¢n</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
	  BEGIN
               UPDATE
               ge_dominios_td
               SET
               tipo = EN_tipo
               ,nombre = EV_nombre
			   ,fec_modificacion = SYSDATE
			   ,usu_modificacion = ED_usu_modificacion
               WHERE
               cod_dominio = EV_cod_dominio
               ;

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN

	      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_DOMINIOS_U_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_MODIFICAR_FN;


 END GE_DOMINIOS_KNL_U_PG;
/
SHOW ERRORS
