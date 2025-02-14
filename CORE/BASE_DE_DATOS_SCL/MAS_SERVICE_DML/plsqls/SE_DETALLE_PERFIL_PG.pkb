CREATE OR REPLACE PACKAGE BODY SE_DETALLE_PERFIL_PG

AS

  PROCEDURE SE_PERFIL_S_PR(EO_DET_PERFIL	  IN  		SE_DETALLE_PERFIL_TD_QT,
						  SO_DET_PERFIL_CUR  OUT NOCOPY	refCursor,
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

			IF EO_DET_PERFIL IS NULL THEN
			    RAISE ERROR_PARAMETROS;
			ELSE
	    		LV_sSql := 'SELECT COD_PERFIL_LISTA, COD_CATEGORIA_DESTINO, NUM_MAXIMO ';
				LV_sSql := LV_sSql || ' FROM SE_DETALLE_PERFIL_TD ';
 				LV_sSql := LV_sSql || ' WHERE COD_PERFIL_LISTA =' ||EO_DET_PERFIL.COD_PERFIL_LISTA;
                OPEN SO_DET_PERFIL_CUR FOR

				SELECT COD_PERFIL_LISTA, COD_CATEGORIA_DESTINO, NUM_MAXIMO
            	FROM SE_DETALLE_PERFIL_TD
				WHERE COD_PERFIL_LISTA =  EO_DET_PERFIL.COD_PERFIL_LISTA;

			END IF;

EXCEPTION
   WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PS_ESPEC_S_PR(Lista Productos); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PS_DET_ESPEC_PROD_PG.PS_ESPEC_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1406;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_PERFIL_S_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_DETALLE_PERFIL_PG.SE_PERFIL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_PERFIL_S_PR(Lista Perfil); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_DETALLE_PERFIL_PG.SE_PERFIL_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END SE_PERFIL_S_PR;

END SE_DETALLE_PERFIL_PG;
/
SHOW ERRORS
