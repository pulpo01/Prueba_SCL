CREATE OR REPLACE PACKAGE BODY GE_ERRORES_KNL_U_PG
IS

  FUNCTION GE_MODIFICAR_FN
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
              UPDATE GE_ERRORES_TD
		 SET
                   DET_MSGERROR = EV_des_mensaje,
		   COD_GRUPO = EN_grupo,
		   COD_MSGCLIENTE = EN_cod_msgcliente
                WHERE COD_MSGERROR =EN_cod_mensaje;

               RETURN SQL%ROWCOUNT;

	  EXCEPTION
	      WHEN OTHERS THEN

	      RAISE_APPLICATION_ERROR(-20100, 'Error en GE_ERRORES_KNL_U_PG ' || to_char(SQLCODE) || ': ' || SQLERRM);
  END GE_MODIFICAR_FN;


END GE_ERRORES_KNL_U_PG;
/
SHOW ERRORS
