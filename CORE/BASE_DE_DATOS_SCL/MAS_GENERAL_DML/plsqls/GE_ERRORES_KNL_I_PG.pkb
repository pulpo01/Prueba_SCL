CREATE OR REPLACE PACKAGE BODY GE_ERRORES_KNL_I_PG
IS

  FUNCTION GE_AGREGAR_FN
               (
               EN_cod_mensaje ge_errores_td.cod_msgerror%TYPE
               ,EV_des_mensaje ge_errores_td.det_msgerror%TYPE
	       ,EN_grupo ge_errores_td.cod_grupo%TYPE
	       ,EN_cod_msgcliente ge_errores_td.cod_msgcliente%TYPE
               )
      RETURN NUMBER
  	/*<Documentacion TipoDoc = "Funci¢n">
	<Elemento Nombre = "GE_AGREGAR_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise¤ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
	<Retorno>NUMBER</Retorno>
	<Descripcion>Agrega errores de negocio</Descripci¢n>
	<Parametros>
	<Entrada>
            <param nom="EN_cod_mensaje" Tipo="NUMBER">Codigo del error</param>
            <param nom="EV_des_mensaje" Tipo="STRING">Descripción del error</param>
            <param nom="EN_grupo" Tipo="NUMBER">grupo asociado</param>
            <param nom="EN_cod_msgcliente" Tipo="NUMBER">Codigo de Error del Cliente</param>
	</Entrada>
	<Salida>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentaci¢n>
	*/
  IS
	  BEGIN
              INSERT INTO GE_ERRORES_TD (
                   COD_MSGERROR,
				   DET_MSGERROR,
				   COD_GRUPO,
				   COD_MSGCLIENTE)
              VALUES (
			    EN_cod_mensaje,
				EV_des_mensaje,
				EN_grupo ,
				EN_cod_msgcliente);

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN

	      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_ERRORES_KNL_I_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_AGREGAR_FN;


END GE_ERRORES_KNL_I_PG;
/
SHOW ERRORS
