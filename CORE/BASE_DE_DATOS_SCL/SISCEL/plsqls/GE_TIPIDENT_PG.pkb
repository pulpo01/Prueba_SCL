CREATE OR REPLACE PACKAGE BODY GE_TIPIDENT_PG AS

PROCEDURE GE_OBTENER_S_PR(SO_GE_TIPIDENT_CUR  OUT NOCOPY	refCursor,
											   SN_cod_retorno      OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
											     SV_mens_retorno     OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
												   SN_num_evento       OUT NOCOPY	ge_errores_pg.evento)
IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "GE_OBTENER_S_PR"
	      Lenguaje="PL/SQL"
	      Fecha="20-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio"
	      Programador="Alejandro Diaz"
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



                OPEN SO_GE_TIPIDENT_CUR FOR

				SELECT COD_TIPIDENT, DES_TIPIDENT
            	FROM GE_TIPIDENT
				ORDER BY ORDEN_DISPLAY;



EXCEPTION

	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1405;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_SERVICIO_S_PR(Lista Planes); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_ATLANTIDA_PG.SE_SERVICIO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'SE_SERVICIO_S_PR(Lista Planes); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'SE_ATLANTIDA_PG.SE_SERVICIO_S_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END GE_OBTENER_S_PR;

END GE_TIPIDENT_PG;
/
SHOW ERRORS
