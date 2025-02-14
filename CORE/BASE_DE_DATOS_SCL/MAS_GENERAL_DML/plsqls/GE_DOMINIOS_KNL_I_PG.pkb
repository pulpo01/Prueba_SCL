CREATE OR REPLACE PACKAGE BODY GE_DOMINIOS_KNL_I_PG
IS

  FUNCTION GE_AGREGAR_FN
               (
                EV_cod_dominio ge_dominios_td.cod_dominio%TYPE
               ,EN_tipo ge_dominios_td.tipo%TYPE
               ,EV_nombre ge_dominios_td.nombre%TYPE
               ,EV_usu_creacion ge_dominios_td.usu_creacion%TYPE
               )
      RETURN NUMBER IS
	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_AGREGAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Inserta un registro en la tabla GE_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>
	<param nom="EV_cod_dominio" Tipo="STRING">Codigo de dominio</param>
	<param nom="EN_tipo" Tipo="Number">Tipo de dominio: 1=Valor</param>
	<param nom="EV_nombre" Tipo="STRING">Nombre del dominio</param>
	<param nom="ED_usu_creacion" Tipo="STRING">usuario que genera el registro</param>

	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
	  BEGIN
               INSERT INTO
               ge_dominios_td
               (
                cod_dominio
               ,tipo
               ,nombre
               ,fec_creacion
               ,usu_creacion
			   ,fec_modificacion
			   ,usu_modificacion
               )
               VALUES
               (
               EV_cod_dominio
               ,EN_tipo
               ,EV_nombre
               ,SYSDATE
               ,EV_usu_creacion
               ,SYSDATE
               ,EV_usu_creacion
			   );

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN
	      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_DOMINIOS_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_AGREGAR_FN;


 END GE_DOMINIOS_KNL_I_PG;
/
SHOW ERRORS
