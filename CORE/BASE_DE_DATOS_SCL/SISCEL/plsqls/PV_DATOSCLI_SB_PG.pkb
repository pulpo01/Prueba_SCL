CREATE OR REPLACE PACKAGE BODY PV_DATOSCLI_SB_PG AS

PROCEDURE PV_OBTIENE_DATOS_CLIE_PR (
      SO_Servsupl         	   IN OUT NOCOPY	PV_Servsupl_QT,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY		ge_errores_pg.evento)

	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_DATOSCLI_SB_PG
	      Lenguaje="PL/SQL"
	      Fecha="23-08-2006"
	      Versión="La del package"
	      Diseñador="Oscar Jorquera"
	      Programador="Oscar Jorquera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_Servsupl" Tipo="estructura">estructura de cliente</param>>
	         </Entrada>
	         <Salida>
	            <param nom="" Tipo=""></param>>
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
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


		LV_sSql := 'SELECT DISTINCT a.nom_cliente||'' ''||a.nom_apeclien1||'' ''||a.nom_apeclien2 as nom_cliente,';
		LV_sSql := LV_sSql || 'FROM   ge_clientes A';
		LV_sSql := LV_sSql || 'WHERE a.cod_cliente   = ' || SO_Servsupl.cod_cliente;



		SELECT DISTINCT 
		substr(a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2,1,50) as nom_cliente
		INTO SO_Servsupl.nom_cliente
		FROM ge_clientes a
		WHERE
	    a.cod_cliente   = SO_Servsupl.cod_cliente;


	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		  SO_Servsupl.nom_cliente := '';
		  SO_Servsupl.cod_plantarif := '';
		  SO_Servsupl.des_plantarif := '';
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_DATOS_CLIE_PR('||SO_Servsupl.cod_cliente||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_DATOSCLI_SB_PG.PV_OBTIENE_DATOS_CLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
end PV_OBTIENE_DATOS_CLIE_PR;

END PV_DATOSCLI_SB_PG;
/
SHOW ERRORS