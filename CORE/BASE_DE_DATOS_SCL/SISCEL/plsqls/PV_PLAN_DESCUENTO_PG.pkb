CREATE OR REPLACE PACKAGE BODY PV_PLAN_DESCUENTO_PG AS

----------------------------------------------------------------------------------------------------------
--1.- Metodo : crearSolicitud
PROCEDURE PV_CREAR_SOLICITUD_PR (EO_SOLICITUD	    IN 	 		 PV_SOLICITUD_QT,
								SN_cod_retorno   	OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								SV_mens_retorno  	OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								SN_num_evento       OUT NOCOPY	 ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_CREAR_SOLICITUD_PR"
	      Lenguaje="PL/SQL"
	      Fecha="12-07-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Crea una solicitud de aprobacion de descuento</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_SOLICITUD Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
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

		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		LV_sSql:= 'VE_servicios_venta_PG.VE_ins_sol_autorizacion_PR( '||EO_SOLICITUD.NUM_VENTA||','||EO_SOLICITUD.LIN_AUTORIZA||')';
		LV_sSql:= LV_sSql|| EO_SOLICITUD.COD_OFICINA||','||EO_SOLICITUD.COD_ESTADO||',';
		LV_sSql:= LV_sSql|| EO_SOLICITUD.NUM_AUTORIZACION||','||EO_SOLICITUD.COD_VENDEDOR||',';
		LV_sSql:= LV_sSql|| EO_SOLICITUD.NUM_UNIDADES||','||EO_SOLICITUD.PRECIO_ORIGEN||',';
        LV_sSql:= LV_sSql|| EO_SOLICITUD.IND_TIPO_VENTA||','||EO_SOLICITUD.COD_CLIENTE||',';
        LV_sSql:= LV_sSql|| EO_SOLICITUD.COD_MOD_VENTA||','||EO_SOLICITUD.NOM_USUARIO_VENTA||',';
        LV_sSql:= LV_sSql|| EO_SOLICITUD.COD_CONCEPTO||','||EO_SOLICITUD.IMP_CARGO||',';
        LV_sSql:= LV_sSql|| EO_SOLICITUD.COD_MONEDA||','||EO_SOLICITUD.NUM_ABONADO||',';
        LV_sSql:= LV_sSql|| EO_SOLICITUD.NUM_SERIE||','||EO_SOLICITUD.COD_CONCEPTO_DESC||',';
        LV_sSql:= LV_sSql|| EO_SOLICITUD.VAL_DESCUENTO||','||EO_SOLICITUD.TIP_DESCUENTO||',';
        LV_sSql:= LV_sSql|| EO_SOLICITUD.IND_MODIFICACION||','||EO_SOLICITUD.COD_ORIGEN||',';

		VE_servicios_venta_PG.VE_ins_sol_autorizacion_PR( EO_SOLICITUD.NUM_VENTA
		                                 			     ,EO_SOLICITUD.LIN_AUTORIZA
			                             				 ,EO_SOLICITUD.COD_OFICINA
                                 		 				 ,EO_SOLICITUD.COD_ESTADO
			                             				 ,EO_SOLICITUD.NUM_AUTORIZACION
			                             				 ,EO_SOLICITUD.COD_VENDEDOR
			                             				 ,EO_SOLICITUD.NUM_UNIDADES
                                         				 ,EO_SOLICITUD.PRECIO_ORIGEN
                                         				 ,EO_SOLICITUD.IND_TIPO_VENTA
                                         				 ,EO_SOLICITUD.COD_CLIENTE
                                         				 ,EO_SOLICITUD.COD_MOD_VENTA
                                         				 ,EO_SOLICITUD.NOM_USUARIO_VENTA
                                         				 ,EO_SOLICITUD.COD_CONCEPTO
                                         				 ,EO_SOLICITUD.IMP_CARGO
                                        				 ,EO_SOLICITUD.COD_MONEDA
                                         				 ,EO_SOLICITUD.NUM_ABONADO
                                         				 ,EO_SOLICITUD.NUM_SERIE
                                         				 ,EO_SOLICITUD.COD_CONCEPTO_DESC
                                         				 ,EO_SOLICITUD.VAL_DESCUENTO
                                         				 ,EO_SOLICITUD.TIP_DESCUENTO
                                         				 ,EO_SOLICITUD.IND_MODIFICACION
                                         				 ,EO_SOLICITUD.COD_ORIGEN
                                         				 ,SN_cod_retorno
                                         				 ,SV_mens_retorno
                                         				 ,SN_num_evento );




	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_CREAR_SOLICITUD_PR('||EO_SOLICITUD.NUM_VENTA||','||EO_SOLICITUD.LIN_AUTORIZA||','||EO_SOLICITUD.COD_ESTADO||','||EO_SOLICITUD.NUM_AUTORIZACION||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_DESCUENTO_PG.PV_CREAR_SOLICITUD_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CREAR_SOLICITUD_PR;

----------------------------------------------------------------------------------------------------------
--1.- Metodo : consultarEstadoSolicitud
PROCEDURE PV_CONSULTAR_EST_SOLICITUD_PR (EO_SOLICITUD	    IN OUT	 		 PV_SOLICITUD_QT,
										SN_cod_retorno   	OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
										SV_mens_retorno  	OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
										SN_num_evento       OUT NOCOPY	 ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_CONSULTAR_EST_SOLICITUD_PR
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="Elizabeth Vera"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene estado de la solicitud</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_SOLICITUD Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
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

		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

		LV_sSql:= 'VE_servicios_venta_PG.VE_con_sol_autorizacion_PR( '||EO_SOLICITUD.NUM_AUTORIZACION||','||EO_SOLICITUD.COD_ESTADO||')';
		VE_servicios_venta_PG.VE_con_sol_autorizacion_PR( EO_SOLICITUD.NUM_AUTORIZACION
                                 		 				 ,EO_SOLICITUD.COD_ESTADO
                                         				 ,SN_cod_retorno
                                         				 ,SV_mens_retorno
                                         				 ,SN_num_evento );

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_CONSULTAR_EST_SOLICITUD_PR('||EO_SOLICITUD.NUM_AUTORIZACION||','||EO_SOLICITUD.COD_ESTADO||');'||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_DESCUENTO_PG.PV_CONSULTAR_EST_SOLICITUD_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CONSULTAR_EST_SOLICITUD_PR;

----------------------------------------------------------------------------------------------------------
--1.- Metodo : eliminarSolicitud
PROCEDURE PV_ELIMINAR_SOLICITUD_PR (EO_SOLICITUD	    IN 		     PV_SOLICITUD_QT,
									SN_cod_retorno   	OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									SV_mens_retorno  	OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									SN_num_evento       OUT NOCOPY	 ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_CONSULTAR_EST_SOLICITUD_PR
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2007"
	      Versión="La del package"
	      Diseñador=
	      Programador="MAricel Avalos"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción>Obtiene estado de la solicitud</Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_SOLICITUD Tipo="estructura"></param>>
	         </Entrada>
	         <Salida>
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

		SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;


		LV_sSql:= 'DELETE ga_autoriza  ';
		LV_sSql:= LV_sSql||' WHERE num_venta = '||EO_SOLICITUD.NUM_VENTA;
		LV_sSql:= LV_sSql||' AND num_autoriza = '||EO_SOLICITUD.NUM_AUTORIZACION;
		LV_sSql:= LV_sSql||' AND cod_estado = ''PD''';

		DELETE ga_autoriza
		WHERE num_venta = EO_SOLICITUD.NUM_VENTA
  			  AND num_autoriza = EO_SOLICITUD.NUM_AUTORIZACION
			  AND cod_estado = 'PD';


EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_ELIMINAR_SOLICITUD_PR('||EO_SOLICITUD.NUM_VENTA||','||EO_SOLICITUD.LIN_AUTORIZA||','||EO_SOLICITUD.NUM_AUTORIZACION||');'||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_DESCUENTO_PG.PV_ELIMINAR_SOLICITUD_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ELIMINAR_SOLICITUD_PR;

END PV_PLAN_DESCUENTO_PG;
/
SHOW ERRORS
