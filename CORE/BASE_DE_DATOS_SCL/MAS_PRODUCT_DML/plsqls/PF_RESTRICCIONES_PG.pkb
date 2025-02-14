CREATE OR REPLACE PACKAGE BODY PF_RESTRICCIONES_PG
AS

  PROCEDURE PF_GENERAL_S_PR(EO_Restricciones  IN  		PF_RESTR_CONTRATA_TD_QT,
						  SO_Lista_Restricciones  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_PRODUCTO_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Hilda Quezada"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">Código de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	v_contador		   number(9);
	ERROR_PARAMETROS EXCEPTION;

		BEGIN
	        SN_cod_retorno 	:= 0;
        	SV_mens_retorno := ' ';
        	SN_num_evento 	:= 0;

			IF EO_Restricciones IS NULL THEN
			   RAISE ERROR_PARAMETROS;
			ELSE
				LV_sSql := ' SELECT A.TIPO_PLATAFORMA, a.IND_NIVEL_APLICA, a.TIPO_COMPORTAMIENTO, a.FEC_INICIO_VIGENCIA, ';
				LV_sSql := LV_sSql || ' a.MAX_CANTIDAD, a.MAX_MONTO, a.MIN_CICLOS, a.FEC_TERMINO_VIGENCIA ';
				LV_sSql := LV_sSql || ' FROM PF_RESTRICCIONES_PROD_TD a ';
				LV_sSql := LV_sSql || ' WHERE a.TIPO_PLATAFORMA = ' ||EO_Restricciones.IND_TIPO_PLATAFORMA;
				LV_sSql := LV_sSql || ' AND A.IND_NIVEL_APLICA = ' || EO_Restricciones.IND_NIVEL_APLICA;
				LV_sSql := LV_sSql || ' AND A.TIPO_COMPORTAMIENTO = ' ||EO_Restricciones.TIPO_COMPORTAMIENTO;

                OPEN SO_Lista_Restricciones FOR
				SELECT A.TIPO_PLATAFORMA, a.IND_NIVEL_APLICA, a.TIPO_COMPORTAMIENTO, a.FEC_INICIO_VIGENCIA,
					   a.MAX_CANTIDAD, a.MAX_MONTO, a.MIN_CICLOS, a.FEC_TERMINO_VIGENCIA
				FROM PF_RESTRICCIONES_PROD_TD a
				WHERE a.TIPO_PLATAFORMA = EO_Restricciones.IND_TIPO_PLATAFORMA
				AND A.IND_NIVEL_APLICA = EO_Restricciones.IND_NIVEL_APLICA
				AND A.TIPO_COMPORTAMIENTO = EO_Restricciones.TIPO_COMPORTAMIENTO;

			END IF;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_GENERAL_S_PR(Lista Restricciones); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.PF_GENERAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 0;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_GENERAL_S_PR(Lista Restricciones); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_RESTRICCIONES_TD.PF_GENERAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_GENERAL_S_PR(Lista Restricciones); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_RESTRICCIONES_TD.PF_GENERAL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PF_GENERAL_S_PR;
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


END PF_RESTRICCIONES_PG;
/
SHOW ERRORS
