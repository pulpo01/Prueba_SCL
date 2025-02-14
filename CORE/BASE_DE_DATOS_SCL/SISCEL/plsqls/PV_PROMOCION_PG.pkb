CREATE OR REPLACE PACKAGE BODY PV_PROMOCION_PG AS
--1.- Metodo eliminarPromocion
--	  		 PV_PROMOCION_PG.PV_ELIMINAR_PROMOCION_PR	(PL Nueva)
--		1.1	 PV_PROMOCION_PG.PV_DEL_GA_ABOAMI_PROM_PR 	(PL Nueva)
--		1.2	 PV_PROMOCION_PG.PV_SEL_GA_ABOAMI_PROM_PR 	(PL Nueva)
------------------------------------------------------------------------------------------------------
--	1.1
    PROCEDURE PV_DEL_GA_ABOAMI_PROM_PR (Reg_ga_aboami_prom   IN 			   PV_TIPOS_PG.R_GA_ABOAMI_PROM,
								        SN_cod_retorno   	 OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
								        SV_mens_retorno  	 OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
								        SN_num_evento    	 OUT NOCOPY		   ge_errores_pg.evento)
    IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_DEL_GA_ABOAMI_PROM_PR"
	      Lenguaje="PL/SQL"
	      Fecha="11-07-2007"
	      Versión="La del package"
	      Diseñador=""
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="Reg_ga_aboami_prom" Tipo="estructura">estructura de los datos </param>>
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

		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

			FOR i IN Reg_ga_aboami_prom.FIRST .. Reg_ga_aboami_prom.LAST LOOP

				LV_sSql:='';
				LV_sSql:=LV_sSql||'DELETE ga_aboami_prom ';
				LV_sSql:=LV_sSql||'WHERE ';
				LV_sSql:=LV_sSql||'NUM_ABONADO = '||Reg_ga_aboami_prom(i).NUM_ABONADO||';';


			DELETE ga_aboami_prom
			WHERE
				   NUM_ABONADO = Reg_ga_aboami_prom(i).NUM_ABONADO;
          END LOOP;

	EXCEPTION
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_DEL_GA_ABOAMI_PROM_PR('||to_char(Reg_ga_aboami_prom(1).NUM_ABONADO)||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PROMOCION_PG.PV_DEL_GA_ABOAMI_PROM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_DEL_GA_ABOAMI_PROM_PR;

------------------------------------------------------------------------------------------------------
--	1.2
    PROCEDURE PV_SEL_GA_ABOAMI_PROM_PR (Reg_ga_aboami_prom   IN OUT NOCOPY	   PV_TIPOS_PG.R_GA_ABOAMI_PROM,
								        SN_cod_retorno   	 OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
								        SV_mens_retorno  	 OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
								        SN_num_evento    	 OUT NOCOPY		   ge_errores_pg.evento)
    IS
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;

    BEGIN
		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

			FOR i IN Reg_ga_aboami_prom.FIRST .. Reg_ga_aboami_prom.LAST LOOP
			SELECT a.num_abonado
 			INTO  Reg_ga_aboami_prom(i).NUM_ABONADO
			FROM GA_PROMOC_AMISTAR b, GA_ABOAMI_PROM a
        	WHERE
					a.num_abonado   = Reg_ga_aboami_prom(i).NUM_ABONADO
        	AND 	a.cod_promocion = b.cod_promocion
        	AND 	a.num_periodos  < b.num_periodos;

           END LOOP;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		 Reg_ga_aboami_prom(1).NUM_ABONADO:=null;
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
--		  LV_des_error   := ' PV_SEL_GA_ABOAMI_PROM_PR('||to_char(Reg_ga_aboami_prom(1).NUM_ABONADO)||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PROMOCION_PG.PV_SEL_GA_ABOAMI_PROM_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_SEL_GA_ABOAMI_PROM_PR;
------------------------------------------------------------------------------------------------------
--1.- Metodo eliminarPromocion    (Este metodo esta asociado a la eliminacion de la promocion )
	PROCEDURE PV_ELIMINAR_PROMOCION_PR(EO_GA_PROMOC		   IN OUT NOCOPY	PV_GA_PROMOC_QT,
								       SN_cod_retorno         OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
								       SV_mens_retorno        OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
								       SN_num_evento          OUT NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_ELIMINAR_PROMOCION_PR"
	      Lenguaje="PL/SQL"
	      Fecha="13-06-2007"
	      Versión="La del package"
	      Diseñador=""
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="EO_GA_PROMOC" Tipo="estructura">estructura de los datos de un abonado</param>>
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
		LV_des_error	   			ge_errores_pg.DesEvent;
		LV_sSql			   			ge_errores_pg.vQuery;
		ERROR_EJECUCION       		EXCEPTION;
		Reg_ga_aboami_prom 			PV_TIPOS_PG.R_GA_ABOAMI_PROM;

	BEGIN
		sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		IF EO_GA_PROMOC.SV_COMBINATORIA = CV_Comb_Pospos THEN
			   BEGIN
					Reg_ga_aboami_prom(1).NUM_ABONADO:= EO_GA_PROMOC.NUM_ABONADO;
					PV_PROMOCION_PG.PV_DEL_GA_ABOAMI_PROM_PR (Reg_ga_aboami_prom,
															 SN_cod_retorno,
															 SV_mens_retorno,
															 SN_num_evento);
				EXCEPTION
				  WHEN OTHERS THEN
		   		   		RAISE ERROR_EJECUCION;
				END;
		ELSE
		IF   EO_GA_PROMOC.SV_COMBINATORIA = CV_Comb_Pospre THEN
			   --   Rescata Numero del Abonado     entidad    ga_aboami_prom
					Reg_ga_aboami_prom(1).NUM_ABONADO:=EO_GA_PROMOC.NUM_ABONADO;
					PV_PROMOCION_PG.PV_SEL_GA_ABOAMI_PROM_PR (Reg_ga_aboami_prom,
															  SN_cod_retorno,
															  SV_mens_retorno,
															  SN_num_evento);
					IF SN_cod_retorno>0 THEN
					  		RAISE ERROR_EJECUCION;
					END IF;
				IF (Reg_ga_aboami_prom(1).NUM_ABONADO IS NOT NULL) AND EO_GA_PROMOC.SN_APLICA = CN_Aplica THEN
							Reg_ga_aboami_prom(1).NUM_ABONADO:=EO_GA_PROMOC.NUM_ABONADO;
							PV_PROMOCION_PG.PV_DEL_GA_ABOAMI_PROM_PR (Reg_ga_aboami_prom,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
							IF SN_cod_retorno>0 THEN
					  		   RAISE ERROR_EJECUCION;
							END IF;
				ELSE
					IF (Reg_ga_aboami_prom(1).NUM_ABONADO IS NOT NULL) AND NOT(EO_GA_PROMOC.SN_APLICA = CN_Aplica) THEN
				        EO_GA_PROMOC.SV_MSG:= 'Abonado Tiene una Promocion Activa...' || Chr(13);
				        EO_GA_PROMOC.SV_MSG:= EO_GA_PROMOC.SV_MSG || 'Si Acepta, esta sera ELIMINADA y no podra ser Recuperada..' || Chr(13);
				        EO_GA_PROMOC.SV_MSG:= EO_GA_PROMOC.SV_MSG || 'Si NO Acepta, se CANCELARA la Baja del Abonado....';
					END IF;
				END IF;
		END IF;
		END IF;

	EXCEPTION
 	WHEN ERROR_EJECUCION THEN
 		  LV_des_error   := 'PV_ELIMINAR_PROMOCION_PR('||to_char(EO_GA_PROMOC.NUM_ABONADO)||'); '||SQLERRM;
 	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PROMOCION_PG.PV_ELIMINAR_PROMOCION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
    WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_ELIMINAR_PROMOCION_PR('||to_char(EO_GA_PROMOC.NUM_ABONADO)||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PROMOCION_PG.PV_ELIMINAR_PROMOCION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PV_ELIMINAR_PROMOCION_PR;

END PV_PROMOCION_PG;
/
SHOW ERRORS
