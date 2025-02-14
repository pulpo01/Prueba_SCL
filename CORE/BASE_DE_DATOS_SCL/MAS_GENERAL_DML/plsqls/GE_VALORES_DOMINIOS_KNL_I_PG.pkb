CREATE OR REPLACE PACKAGE BODY GE_VALORES_DOMINIOS_KNL_I_PG
IS
    TIPO_DOMINIO_MODIFICABLE CONSTANT NUMBER(1) := 2;
    TIPO_DOMINIO_NO_VALIDO EXCEPTION;
  FUNCTION GE_AGREGAR_FN
               (
               EN_tipo_ingreso ge_dominios_td.tipo%TYPE
               ,EV_cod_dominio ge_valores_dominios_td.cod_dominio%TYPE
               ,EV_valor ge_valores_dominios_td.valor%TYPE
			   ,EV_estado ge_valores_dominios_td.ind_estado%TYPE
               ,EV_descripcion_valor ge_valores_dominios_td.descripcion_valor%TYPE
	       ,EV_usu_creacion ge_valores_dominios_td.usu_creacion%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_AGREGAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega un valor para un dominio. Se realiza la inserci¢n en la tabla GE_VALORES_DOMINIOS_TD</Descripci¢n>
	<Parametros>
	<Entrada>

	<param nom="EN_tipo_ingreso" Tipo="Number">Valor que determina si se ingresa dominio sistema (1) o modificable (2)</param>>
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
    LN_tipo ge_dominios_td.tipo%TYPE;

	  BEGIN
	       SELECT tipo
	       INTO LN_tipo
	       FROM
	       ge_dominios_td
	       WHERE cod_dominio = EV_cod_dominio;

	       IF LN_tipo != EN_tipo_ingreso THEN
	          RAISE TIPO_DOMINIO_NO_VALIDO;
	       END IF;

               INSERT INTO
               ge_valores_dominios_td
               (
               cod_dominio
               ,valor
			   ,ind_estado
               ,descripcion_valor
	       ,fec_creacion
	       ,usu_creacion
	       ,fec_modificacion
	       ,usu_modificacion
               )
               VALUES
               (
               EV_cod_dominio
               ,EV_valor
			   ,EV_estado
               ,EV_descripcion_valor
	       ,SYSDATE
	       ,EV_usu_creacion
	       ,SYSDATE
	       ,EV_usu_creacion
               );

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN TIPO_DOMINIO_NO_VALIDO THEN
	      	RAISE_APPLICATION_ERROR(-20102, 'Error en GE_VALORES_DOMINIOS_KNL_I_PG ' || 'Tipo de dominio no es valido para agregar');
	      WHEN NO_DATA_FOUND THEN
	      	RAISE_APPLICATION_ERROR(-20101, 'Error en GE_VALORES_DOMINIOS_KNL_I_PG ' || 'Dominio no existe.');
	      WHEN OTHERS THEN
	       RAISE_APPLICATION_ERROR(-20100, 'Error en GE_VALORES_DOMINIOS_KNL_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);

  END GE_AGREGAR_FN;


 END GE_VALORES_DOMINIOS_KNL_I_PG;
/
SHOW ERRORS
