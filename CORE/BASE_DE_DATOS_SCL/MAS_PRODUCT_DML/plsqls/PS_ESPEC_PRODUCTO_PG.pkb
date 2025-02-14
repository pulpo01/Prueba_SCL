CREATE OR REPLACE PACKAGE BODY PS_ESPEC_PRODUCTO_PG
AS

  PROCEDURE PS_PRODUCTO_S_PR(EO_Espe_productos	  IN  		PF_ESPEC_PRODUCTO_QT,
						  SO_Lista_Espe_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentaci�n
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_PRODUCTO_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versi�n="La del package"
	      Dise�ador="Andr�s Osorio"
	      Programador="Hilda Quezada"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripci�n></Descripci�n>>
	      <Par�metros>
	         <Entrada>
	            <param nom="EO_prod_padre" Tipo="estructura">C�digo de Producto Padre</param>>
	         </Entrada>
	         <Salida>
	            <param nom="SO_Lista_Productos" Tipo="Cursor">Lista de Productos</param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Par�metros>
	   </Elemento>
	</Documentaci�n>
	*/

	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	v_contador		   number(9);
	ERROR_PARAMETROS EXCEPTION;

		BEGIN
	        SN_cod_retorno 	:= 0;
        	SV_mens_retorno := ' ';
        	SN_num_evento 	:= 0;

			IF EO_Espe_productos IS NULL THEN
			RAISE ERROR_PARAMETROS;

			ELSE
				LV_sSql := ' SELECT A.COD_ESPEC_PROD, ';
				LV_sSql := LV_sSql || ' A.ID_ESPEC_PROD, ';
				LV_sSql := LV_sSql || ' A.DES_ESPEC_PROD, ';
				LV_sSql := LV_sSql || ' A.FEC_INICIO_VIGENCIA, ';
				LV_sSql := LV_sSql || ' A.FEC_TERMINO_VIGENCIA, ';
				LV_sSql := LV_sSql || ' A.TIPO_PLATAFORMA, ';
				LV_sSql := LV_sSql || ' A.TIPO_COMPORTAMIENTO ';
				LV_sSql := LV_sSql || ' FROM PS_ESPECIFICACIONES_PROD_TD a ';
				LV_sSql := LV_sSql || ' WHERE a.COD_ESPEC_PROD = ' ||EO_Espe_productos.COD_ESP_PROD;

                OPEN SO_Lista_Espe_Productos FOR
				SELECT A.COD_ESPEC_PROD,
					   A.ID_ESPEC_PROD,
					   A.DES_ESPEC_PROD,
					   A.FEC_INICIO_VIGENCIA,
					   A.FEC_TERMINO_VIGENCIA,
					   A.TIPO_PLATAFORMA,
					   A.TIPO_COMPORTAMIENTO
				FROM PS_ESPECIFICACIONES_PROD_TD a
				WHERE a.COD_ESPEC_PROD = EO_Espe_productos.COD_ESP_PROD;

			END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PS_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PS_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1402;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno :='No se encontro Lista de Espec Productos' ;
	      END IF;
		  LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_PRODUCTO_S_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PS_PRODUCTO_S_PR;

END PS_ESPEC_PRODUCTO_PG;
/
SHOW ERRORS
