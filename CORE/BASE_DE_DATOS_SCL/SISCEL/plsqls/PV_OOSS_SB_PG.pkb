CREATE OR REPLACE PACKAGE BODY PV_OOSS_SB_PG AS

PROCEDURE pv_inscribir_ooss_pr(
            so_orserv         	     IN OUT NOCOPY	pv_ci_orserv_qt,
      	 	sn_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
      	 	sv_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
      	 	sn_num_evento            OUT NOCOPY		ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "pv_inscribir_ooss_pr
	      Lenguaje="PL/SQL"
	      Fecha="24-08-2006"
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

	lv_des_error	   ge_errores_pg.DesEvent;
	lv_ssql			   ge_errores_pg.vQuery;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;
        
        
		LV_sSql := 'INSERT into ci_orserv ( ';
		LV_sSql := LV_sSql || 'num_os,cod_os,';
		lv_ssql := lv_ssql || 'producto,';
		lv_ssql := lv_ssql || 'tip_inter,';
		lv_ssql := lv_ssql || 'cod_inter,';
		lv_ssql := lv_ssql || 'usuario,';
		LV_sSql := LV_sSql || 'fecha,';
		lv_ssql := lv_ssql || 'comentario,';
		lv_ssql := lv_ssql || 'num_cargo,';
		lv_ssql := lv_ssql || 'cod_modulo,';
		lv_ssql := lv_ssql || 'id_gestor,';
		LV_sSql := LV_sSql || 'num_movimiento,';
		lv_ssql := lv_ssql || 'cod_estado) ';
		LV_sSql := LV_sSql || 'VALUES (';
		lv_ssql := lv_ssql || so_orserv.num_os||',';
		lv_ssql := lv_ssql || so_orserv.cod_os||',';
		lv_ssql := lv_ssql || '1,';
		lv_ssql := lv_ssql || so_orserv.tip_inter||',';
		lv_ssql := lv_ssql || so_orserv.cod_inter||',';
		lv_ssql := lv_ssql || so_orserv.usuario ||',';
		LV_sSql := LV_sSql || sysdate||',';
		lv_ssql := lv_ssql || so_orserv.comentario||',';
		lv_ssql := lv_ssql || so_orserv.num_cargo||',';
		lv_ssql := lv_ssql || so_orserv.cod_modulo||',';
		lv_ssql := lv_ssql || so_orserv.id_gestor||',';
		lv_ssql := lv_ssql || so_orserv.num_movimiento||',';
		lv_ssql := lv_ssql || so_orserv.cod_estado||')';


		INSERT into ci_orserv (
			   		num_os,
					cod_os,
					producto,
					tip_inter,
					cod_inter,
					usuario,
			  		fecha,
					comentario,
					num_cargo,
					cod_modulo,
					id_gestor,
			  		num_movimiento,
					cod_estado)
		VALUES (
			   		so_orserv.num_os,
					so_orserv.cod_os,
					1,
					so_orserv.tip_inter,
					so_orserv.cod_inter,
					so_orserv.usuario,
			   		sysdate,
					so_orserv.comentario,
					so_orserv.num_cargo,
       				so_orserv.cod_modulo,
       				so_orserv.id_gestor,
       				so_orserv.num_movimiento,
       				so_orserv.cod_estado);


	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 915;
	      IF NOT ge_errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
	         sv_mens_retorno := cv_error_no_clasif;
	      END IF;
		  lv_des_error   := ' pv_inscribir_ooss_pr ('||so_orserv.num_os||','|| so_orserv.cod_os||','|| so_orserv.cod_inter||','|| so_orserv.comentario||'); - ' || SQLERRM;
	      sn_num_evento  := ge_errores_pg.grabarpl( sn_num_evento, cv_cod_modulo, sv_mens_retorno, CV_version, USER, 'PV_OOSS_SB_PG.pv_inscribir_ooss_pr', lv_ssql, sn_cod_retorno, lv_des_error );

END pv_inscribir_ooss_pr;

END PV_OOSS_SB_PG;
/
SHOW ERRORS