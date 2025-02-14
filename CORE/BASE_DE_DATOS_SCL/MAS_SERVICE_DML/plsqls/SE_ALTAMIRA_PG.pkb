CREATE OR REPLACE PACKAGE BODY SE_ALTAMIRA_PG
AS

  PROCEDURE SE_SERVICIO_S_PR(EO_PLANES_AA	  IN  		SE_PLANES_ALTAMIRA_TD_LST_QT,
						  SO_PLANES_AA_CUR  OUT NOCOPY	refCursor,
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

			IF EO_PLANES_AA IS NULL THEN
			 RAISE ERROR_PARAMETROS;
			ELSE
				LV_sSql := ' SELECT a.COD_PLAN_ALTAMIRA, ';
				LV_sSql := LV_sSql || ' a.DES_PLAN_ALTAMIRA, ';
				LV_sSql := LV_sSql || ' a.TIPO_PLATAFORMA, ';
				LV_sSql := LV_sSql || ' a.FEC_INICIO_VIGENCIA, ';
				LV_sSql := LV_sSql || ' a.FEC_TERMINO_VIGENCIA, ';
				LV_sSql := LV_sSql || ' a.TIPO_PLAN_ALTAMIRA, ';
				LV_sSql := LV_sSql || ' a.COD_LISTA_ALTAMIRA, ';
				LV_sSql := LV_sSql || ' a.CAN_BONIFICAR, ';
				LV_sSql := LV_sSql || ' a.TIPO_UNIDAD_BONIFICAR ';
				LV_sSql := LV_sSql || ' FROM SE_PLANES_ALTAMIRA_TD a ';
				LV_sSql := LV_sSql || ' WHERE a.COD_PLAN_ALTAMIRA IN (SELECT b.COD_PLAN_AA FROM TABLE(EO_PLANES_AA) b)';

                OPEN SO_PLANES_AA_CUR FOR
				SELECT a.COD_PLAN_ALTAMIRA,
					   a.DES_PLAN_ALTAMIRA,
					   a.TIPO_PLATAFORMA,
					   a.FEC_INICIO_VIGENCIA,
					   a.FEC_TERMINO_VIGENCIA,
					   a.TIPO_PLAN_ALTAMIRA,
					   a.COD_LISTA_ALTAMIRA,
					   a.CAN_BONIFICAR,
					   a.TIPO_UNIDAD_BONIFICAR
            	FROM SE_PLANES_ALTAMIRA_TD a
				WHERE a.COD_PLAN_ALTAMIRA IN (SELECT b.COD_PLAN_AA FROM TABLE(EO_PLANES_AA) b);

			END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_SERVICIO_S_PR(Lista Planes); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_ALTAMIRA_PG.SE_SERVICIO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1404;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_SERVICIO_S_PR(Lista Planes); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_ALTAMIRA_PG.SE_SERVICIO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_SERVICIO_S_PR(Lista Planes); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_ALTAMIRA_PG.SE_SERVICIO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END SE_SERVICIO_S_PR;

END SE_ALTAMIRA_PG;
/
SHOW ERRORS
