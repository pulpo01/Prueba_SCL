CREATE OR REPLACE PACKAGE BODY PF_PAQUETE_OFERTADO_PG
AS

  PROCEDURE PF_PAQUETE_S_PR(EO_prod_padre	  IN  			PF_PAQUETE_OFERTADO_TO_QT,
						  SO_Lista_Productos  OUT NOCOPY	refCursor,
						  SN_cod_retorno      OUT NOCOPY    ge_errores_pg.coderror,
						  SV_mens_retorno     OUT NOCOPY    ge_errores_pg.msgerror,
						  SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PF_PAQUETE_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="19-07-2007"
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

				IF EO_prod_padre IS NULL THEN
			   RAISE ERROR_PARAMETROS;
			ELSE
				LV_sSql := ' SELECT a.cod_prod_hijo, a.num_veces_hijo ';
				LV_sSql := LV_sSql || ' FROM pf_paquete_ofertado_to a ';
				LV_sSql := LV_sSql || ' WHERE a.cod_prod_padre = ' ||EO_prod_padre.cod_prod_padre;

				OPEN SO_Lista_Productos FOR
				SELECT a.cod_prod_hijo, a.num_veces_hijo
				FROM pf_paquete_ofertado_to a
				WHERE a.cod_prod_padre = EO_prod_padre.cod_prod_padre;
			end if;

EXCEPTION
    WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
          LV_des_error   := 'PF_PAQUETE_S_PR('||EO_prod_padre.cod_prod_padre ||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PAQUETE_OFERTADO_PG.PF_PAQUETE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1399;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_PAQUETE_S_PR('||EO_prod_padre.cod_prod_padre ||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PAQUETE_OFERTADO_PG.PF_PAQUETE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PF_PAQUETE_S_PR('||EO_prod_padre.cod_prod_padre ||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PF_PAQUETE_OFERTADO_PG.PF_PAQUETE_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PF_PAQUETE_S_PR;

END PF_PAQUETE_OFERTADO_PG;
/
SHOW ERRORS
