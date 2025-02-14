CREATE OR REPLACE PACKAGE BODY GE_Auditoria_PG
IS
    ERRORDES VARCHAR2(512);
    ErrorNoCla VARCHAR2(50):= 'No Es Posible Recuperar Error Clasificado';
------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_AgregaAuditoria_PR(neNumTransaccion IN OUT NOCOPY  ge_auditoria_to.num_ticket%TYPE,
		                            veEstado         IN	    ge_auditoria_to.estado_solicitud%TYPE,
								    veUsuario        IN     ge_auditoria_to.usuario%TYPE,
								    neNumProceso     IN     ge_auditoria_to.num_proceso%TYPE,
								    veParametrosIn   IN     ge_auditoria_to.parametros_in%TYPE,
								    veCodPlataforma  IN     ge_auditoria_to.cod_plataforma%TYPE,
								    veCodServicio    IN     ge_auditoria_to.cod_servicio%TYPE,
								    veCodTransaccion IN     ge_auditoria_to.cod_transaccion%TYPE,
								    ERRORCOD         OUT NOCOPY     ge_errores_pg.coderror,
								    ERRORNEG         OUT NOCOPY     ge_errores_pg.msgerror,
							        NEVENTO          OUT NOCOPY     ge_errores_pg.Evento
								   )



/*
<DOC>
      <NOMBRE>GE_AgregaAuditoria_PR</NOMBRE>
      <FECHACREA>14-10-2004</FECHACREA>
      <MODULO>GE</MODULO>
      <VERSION>1.0.0</VERSION>
      <DESCRIPCION>REGISTRA EL INICIO DE UNA TRANSACCION</DESCRIPCION
      <FECHAMOD></FECHAMOD>
      <DESCMOD></DESCMOD>
      <ParamEntr>neNumTransaccion:Número de Transacción</ParamEntr>
      <ParamEntr>veEstado:Estado de la transacción</ParamEntr>
      <ParamEntr>veUsuario:Usuario que realiza la transacción</ParamEntr>
      <ParamEntr>neNumProceso:Número que retorna la O. de Num o Ingreso</ParamEntr>
      <ParamEntr>veParametrosIn:Parámetros con que es invocado la PL de negocio asociada</ParamEntr>
      <ParamEntr>veCodPlataforma:Código de la Plataforma</ParamEntr>
      <ParamEntr>veCodServicio:Servicio de Negocio Asociado a la transacción</ParamEntr>
      <ParamEntr>veCodTransaccion:Código de Transacción de los procesos de Logística</ParamEntr>
      <ParamSal>ERRORCOD:Código de Error de Negocio</ParamSal>
      <ParamSal>ERRORNEG:Descripción del Error de Negocio</ParamSal>
      <ParamSal>NEVENTO:Evento asociado a errores técnicos</ParamSal>
</DOC>
*/
    IS
	    PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

	   SELECT AL_TICKETTRANS_SQ.NEXTVAL INTO neNumTransaccion FROM DUAL;

  	    INSERT INTO ge_auditoria_to
		(num_ticket
		,estado_solicitud
		,fecha_solicitud
		,usuario
		,fecha_estado
		,num_proceso
		,parametros_in
		,cod_plataforma
		,cod_servicio
		,cod_transaccion
		,cantidad_registro)
		VALUES
		(neNumTransaccion
		,veEstado
		,sysdate
		,veUsuario
		,sysdate
		,neNumProceso
		,veParametrosIn
		,veCodPlataforma
		,veCodServicio
		,veCodTransaccion
		,0);

		COMMIT;

	    EXCEPTION

		    WHEN OTHERS THEN

				NEVENTO  := 0;
				ERRORCOD := '99';
	            IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                    ERRORNEG := ErrorNoCla;
                END IF;
				ERRORDES := 'GE_AgregaAuditoria_PR('||neNumTransaccion||' ,'||veEstado||' ,'||veUsuario||' ,'||neNumProceso||' ,'||veParametrosIn||' ,'||veCodPlataforma||' ,'||veCodServicio||' ,'||veCodTransaccion||') - ' || SQLERRM;
				NEVENTO := GE_ERRORES_PG.GRABARPL (NEVENTO, 'GE', ERRORNEG, '1.0', USER, 'GE_AgregaAuditoria_PR', sqlerrm, sqlcode, ERRORDES);



    END GE_AgregaAuditoria_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_ModificaAuditoria_PR(veEtadoSolicitud IN  ge_auditoria_to.estado_solicitud%TYPE,
	                                  neEvento         IN  ge_auditoria_to.evento%TYPE,
									  neCodMsgerror    IN  ge_auditoria_to.cod_msgerror%TYPE,
									  neNumTransaccion IN  ge_auditoria_to.num_ticket%TYPE,
									  neNumProceso     IN  ge_auditoria_to.num_proceso%TYPE,
									  neCodTransaccion IN  ge_auditoria_to.cod_transaccion%TYPE,
								      ERRORCOD         OUT NOCOPY  ge_errores_pg.coderror,
								      ERRORNEG         OUT NOCOPY  ge_errores_pg.msgerror,
							          NEVENTO          OUT NOCOPY  ge_errores_pg.Evento
	                                 )
/*
<DOC>
      <NOMBRE>GE_MODIFICAAUDITORIA_PR</NOMBRE>
      <FECHACREA>14-10-2004</FECHACREA>
      <MODULO>GE</MODULO>
      <VERSION>1.0.0</VERSION>
      <DESCRIPCION>MODIFICA EL ESTADO DE UNA TRANSACCION</DESCRIPCION
      <FECHAMOD></FECHAMOD>
      <DESCMOD></DESCMOD>
      <ParamEntr>veEtadoSolicitud:Estado de la Solicitud</ParamEntr>
      <ParamEntr>neEvento:Número de Evento Asociado</ParamEntr>
      <ParamEntr>neCodMsgerror:Código de Error de Negocio</ParamEntr>
      <ParamEntr>neNumTransaccion:Número de Transacción</ParamEntr>
      <ParamSal>ERRORCOD:Código de Error de Negocio Retornado por ejecución</ParamSal>
      <ParamSal>ERRORNEG:Descripción del Error de Negocio por ejecución</ParamSal>
      <ParamSal>NEVENTO:Número de Evento asociado por ejecución</ParamSal>
</DOC>
*/

        IS
		    PRAGMA AUTONOMOUS_TRANSACTION;

		    ERROR_PARAMETROS EXCEPTION;
			vEstado  VARCHAR2(15);
        BEGIN

	        IF veEtadoSolicitud = 'TERMI' AND neNumTransaccion IS NOT NULL THEN

			    IF neEvento > 0 THEN
				    vEstado := 'ERROR';
				ELSE
				    vEstado := veEtadoSolicitud;
				END IF;


  	            UPDATE ge_auditoria_to SET
	            estado_solicitud = vEstado,
	            fecha_estado = sysdate,
	            fecha_cierre_solicitud = sysdate,
	            evento = neEvento,
	            cod_msgerror = neCodMsgerror
	            WHERE num_ticket = neNumTransaccion;

		    ELSIF veEtadoSolicitud = 'NUMIN' OR veEtadoSolicitud = 'PENDI' OR veEtadoSolicitud = 'EJECU' OR veEtadoSolicitud = 'ORNUM' OR veEtadoSolicitud = 'SERIN' OR veEtadoSolicitud = 'SEROK' OR veEtadoSolicitud = 'CABIN' Then

			    IF neEvento > 0 THEN
				    vEstado := 'ERROR';
				ELSE
				    vEstado := veEtadoSolicitud;
				END IF;

			    UPDATE ge_auditoria_to SET
	            estado_solicitud = vEstado,
                evento = neEvento,
	            fecha_estado = sysdate
	            WHERE num_ticket = neNumTransaccion;

            ELSIF veEtadoSolicitud = 'CABOK' THEN

			    IF neEvento > 0 THEN
				    vEstado := 'ERROR';
				ELSE
				    vEstado := veEtadoSolicitud;
				END IF;

			    UPDATE ge_auditoria_to SET
	            estado_solicitud = vEstado,
	            fecha_estado = sysdate,
                evento = neEvento,
			    num_proceso = neNumProceso,
				cod_transaccion = neCodTransaccion
	            WHERE num_ticket = neNumTransaccion;

			ELSE
				RAISE ERROR_PARAMETROS;
			END IF;

			COMMIT;

	   EXCEPTION

	        WHEN ERROR_PARAMETROS THEN

   			    NEVENTO  := 0;
			    ERRORCOD := '98';
				IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                    ERRORNEG := ErrorNoCla;
                END IF;
				ERRORDES := 'GE_ModificaAuditoria_PR('|| veEtadoSolicitud || ', ' || neEvento || ', ' || neCodMsgerror || ', ' || neNumTransaccion ||'); - ' || SQLERRM;
			    NEVENTO := GE_ERRORES_PG.GRABARPL (NEVENTO, 'GE', ERRORNEG, '1.0', USER, 'GE_ModificaAuditoria_PR', sqlerrm, sqlcode, ERRORDES);


		    WHEN OTHERS THEN
                NEVENTO  := 0;
			    ERRORCOD := '100';
                IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                    ERRORNEG := ErrorNoCla;
                END IF;
				ERRORDES := 'GE_ModificaAuditoria_PR('|| veEtadoSolicitud || ', ' || neEvento || ', ' || neCodMsgerror || ', ' || neNumTransaccion ||'); - ' || SQLERRM;
			    NEVENTO := GE_ERRORES_PG.GRABARPL (NEVENTO, 'GE', ERRORNEG, '1.0', USER, 'GE_ModificaAuditoria_PR', sqlerrm, sqlcode, ERRORDES);



    END GE_ModificaAuditoria_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_ConsultaBitacora_PR(neNumTicket       IN  ge_auditoria_to.num_ticket%TYPE,
			                         vsEstadoSolicitud OUT NOCOPY  ge_auditoria_to.estado_solicitud%TYPE,
			                         dsFechaSol        OUT NOCOPY  ge_auditoria_to.fecha_solicitud%TYPE,
			                         dsFechaCierre     OUT NOCOPY  ge_auditoria_to.fecha_cierre_solicitud%TYPE,
			                         dsFechaEstado     OUT NOCOPY  ge_auditoria_to.fecha_estado%TYPE,
			                         vsDetError        OUT NOCOPY  ge_errores_pg.msgerror,
								     ERRORCOD          OUT NOCOPY  ge_errores_pg.coderror,
								     ERRORNEG          OUT NOCOPY  ge_errores_pg.msgerror,
							         NEVENTO           OUT NOCOPY  ge_errores_pg.Evento
									)
/*
<DOC>
      <NOMBRE>GE_CONSULTABITACORA_PR</NOMBRE>
      <FECHACREA>14-10-2004</FECHACREA>
      <MODULO>GE</MODULO>
      <VERSION>1.0.0</VERSION>
      <DESCRIPCION>DEVUELVE EL ESTADO ACTUAL DE UNA TRANSACCION</DESCRIPCION
      <FECHAMOD></FECHAMOD>
      <DESCMOD></DESCMOD>
      <ParamSal>vDetError:Detalle de Error registrado en la transacción</ParamSal>
      <ParamSal>ERRORCOD:Código de Error de Negocio por Ejecutar</ParamSal>
      <ParamSal>ERRORNEG:Descripción del Error de Negocio por Ejecutar</ParamSal>
      <ParamSal>NEVENTO:Evento asociado a Errores técnicos al Ejecutar</ParamSal>
      <ParamEntr>neNumTicket:Número de Transacción a Consultar</ParamEntr>
      <ParamSal>vEstadoSolicitud:Estado de la transaacción</ParamSal>
      <ParamSal>dFechaSol:Fecha de ingreso de la Transacción</ParamSal>
      <ParamSal>dFechaCierre:Fecha de Cierre de la Transacción</ParamSal>
      <ParamSal>dFechaEstado:Fecha del Estado Actual de la Transacción</ParamSal>
</DOC>
*/

        AS

		BEGIN

			 SELECT estado_solicitud
				   ,fecha_solicitud
				   ,fecha_cierre_solicitud
				   ,fecha_estado,
			        det_msgerror
			 INTO vsEstadoSolicitud
				 ,dsFechaSol
				 ,dsFechaCierre
				 ,dsFechaEstado
				 ,vsDetError
			 FROM ge_auditoria_to a, ge_errores_td b
			 WHERE a.num_ticket = neNumTicket
			 AND a.cod_msgerror = b.cod_msgerror(+);

		EXCEPTION

    	    WHEN NO_DATA_FOUND THEN

				NEVENTO  := 0;
			    ERRORCOD := '47';
				IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                    ERRORNEG := ErrorNoCla;
                END IF;
				ERRORDES := 'GE_ConsultaBitacora_PR('||neNumTicket||'); - ' || SQLERRM;
				NEVENTO := GE_ERRORES_PG.GRABARPL (NEVENTO, 'GE', ERRORNEG, '1.0', USER, 'GE_ModificaAuditoria_PR', sqlerrm, sqlcode, ERRORDES);

            WHEN OTHERS THEN

			    NEVENTO  := 0;
		        ERRORCOD := '91';
				IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                    ERRORNEG := ErrorNoCla;
                END IF;
				ERRORDES := 'GE_ConsultaBitacora_PR('||neNumTicket||'); - ' || SQLERRM;
				NEVENTO := GE_ERRORES_PG.GRABARPL (NEVENTO, 'GE', ERRORNEG, '1.0', USER, 'GE_ModificaAuditoria_PR', sqlerrm, sqlcode, ERRORDES);

        END GE_ConsultaBitacora_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE GE_ActualizarCantidadSeries_PR(neNumTicket IN  ge_auditoria_to.num_ticket%TYPE,
								             ERRORCOD    OUT NOCOPY  ge_errores_pg.coderror,
								             ERRORNEG    OUT NOCOPY  ge_errores_pg.msgerror,
                                             NEVENTO     OUT NOCOPY  ge_errores_pg.Evento
											)

/*
<DOC>
      <NOMBRE>GE_ACTUALIZARCANTIDADSERIES_PR</NOMBRE>
      <FECHACREA>14-10-2004</FECHACREA>
      <MODULO>GE</MODULO>
      <VERSION>1.0.0</VERSION>
      <DESCRIPCION>ACTUALIZA LA CANTIDA DE SERIES PROCESADAS BAJO LOS PROCESOS DENOMINADOS ORDEN DE NUMERACION Y ORDEN DE INGRESO</DESCRIPCION
      <FECHAMOD></FECHAMOD>
      <DESCMOD></DESCMOD>
      <ParamEntr>neNumTicket:Número de Transacción</ParamEntr>
      <ParamSal>ERRORCOD:Código de Error de Negocio por Ejecutar</ParamSal>
      <ParamSal>ERRORNEG:Descripción de Error de Negocio por Ejecutar</ParamSal>
      <ParamSal>NEVENTO:Número de Evento Asociado a errores técnicos por Ejecutar</ParamSal>
</DOC>
*/

        AS
		    PRAGMA AUTONOMOUS_TRANSACTION;
		BEGIN

			UPDATE ge_auditoria_to SET
			cantidad_registro = cantidad_registro + 1
			WHERE num_ticket = neNumTicket;
            COMMIT;

		EXCEPTION

            WHEN OTHERS THEN

			    NEVENTO  := 0;
		        ERRORCOD := '101';
				IF NOT GE_ERRORES_PG.MENSAJEERROR(ERRORCOD,ERRORNEG) THEN
                    ERRORNEG := ErrorNoCla;
                END IF;
				ERRORDES := 'GE_ActualizarCantidadSeries_PR('||neNumTicket||'); - ' || SQLERRM;
   				NEVENTO  := GE_ERRORES_PG.GRABARPL (NEVENTO, 'GE', ERRORNEG, '1.0', USER, 'GE_ActualizarCantidadSeries_PR', sqlerrm, sqlcode, ERRORDES);

        END GE_ActualizarCantidadSeries_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		PROCEDURE GE_ModEstadoProcEncol_PR(veNumticket IN  ge_auditoria_to.num_ticket%TYPE,
                                           veCodEstado IN  ge_auditoria_to.estado_solicitud%TYPE,
                                           vsCodEstado OUT NOCOPY  ge_auditoria_to.estado_solicitud%TYPE
                                             )
		/*
		<DOC>
		<NOMBRE>      AL_EjecutaProcesoEncolado_PR                            </NOMBRE>
		<FECHACREA>   05-10-2004                                              </FECHACREA>
		<MODULO>      LOGISTICA                                               </MODULO>
		<AUTOR>       Servicios Compartidos                                   </AUTOR>
		<VERSION>     1.0.0                                                   </VERSION>
		<DESCRIPCION> Ejecutar del scheluder el proceso de Orden de Compra    </DESCRIPCION>
		<FECHAMOD>    05-10-2004                                              </FECHAMOD>
		<DESCMOD>     Ejecutar del scheluder el proceso de Orden de Compra    </DESCMOD>
		</DOC>
		*/

		AS
            PRAGMA AUTONOMOUS_TRANSACTION;
            vEstadoSolAudi       VARCHAR2(10);
		BEGIN
		    IF veCodEstado IS NULL THEN
                SELECT estado_solicitud
                INTO vEstadoSolAudi
                FROM GE_AUDITORIA_TO
                WHERE num_ticket = veNumticket;

                IF vEstadoSolAudi <> 'ERROR' THEN
			        vsCodEstado := 'OK';
                ELSE
                    vsCodEstado := 'ER';
                END IF;

			    UPDATE GE_COLA_PETICIONES_TO SET
			        cod_estado = vsCodEstado,
			        fecha_cierre = SYSDATE
			    WHERE num_ticket = veNumticket;
            ELSE

                UPDATE GE_COLA_PETICIONES_TO SET
			        cod_estado = veCodEstado,
			        fecha_cierre = SYSDATE
			    WHERE num_ticket = veNumticket;
                vsCodEstado := veCodEstado;

            END IF;

            COMMIT;

		END GE_ModEstadoProcEncol_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		PROCEDURE GE_EjecutaProcesoEncolado_PR
		/*
		<DOC>
		<NOMBRE>      AL_EjecutaProcesoEncolado_PR                            </NOMBRE>
		<FECHACREA>   05-10-2004                                              </FECHACREA>
		<MODULO>      LOGISTICA                                               </MODULO>
		<AUTOR>       Servicios Compartidos                                   </AUTOR>
		<VERSION>     1.0.0                                                   </VERSION>
		<DESCRIPCION> Ejecutar del scheluder el proceso de Orden de Compra    </DESCRIPCION>
		<FECHAMOD>    05-10-2004                                              </FECHAMOD>
		<DESCMOD>     Ejecutar del scheluder el proceso de Orden de Compra    </DESCMOD>
		</DOC>
		*/

		AS

			CURSOR cuParametros(nNumTicket NUMBER) IS
			    SELECT a.nombre_parametro, a.valor_parametro
				FROM GE_DETALLES_PETICION_TO a
				WHERE a.NUM_TICKET = nNumTicket
				FOR UPDATE
                ORDER BY orden_parametro ASC;

			vParametros     VARCHAR2(1024);
			nIdcursor       NUMBER;
			nResp           NUMBER;
			Ejecucion		VARCHAR2(1024);
			vEstadoSolAudi  VARCHAR2(10);

            nNumTicket ntNumTicket;
            nLineaComp ntLineaComp;

		BEGIN

            SELECT a.num_ticket, linea_comando BULK COLLECT
            INTO nNumTicket, nLineaComp
			FROM GE_COLA_PETICIONES_TO a
			WHERE a.cod_estado = 'PE'
            ORDER BY a.num_ticket ASC;

            FOR rReg IN nNumTicket.FIRST .. nNumTicket.LAST LOOP

		        vParametros := '';
				FOR Parametros IN cuParametros(nNumTicket(rReg)) LOOP
				    vParametros := vParametros||':'||Parametros.nombre_parametro||', ';
				END LOOP;

				IF LENGTH(vParametros) > 0 THEN

				    vParametros := SUBSTR(vParametros,1,LENGTH(vParametros) - 2);
					nIdcursor := DBMS_SQL.OPEN_CURSOR;
 	                DBMS_SQL.PARSE(nIdcursor, 'BEGIN '||nLineaComp(rReg)||'('||vParametros||'); END;', DBMS_SQL.NATIVE);

					FOR Parametros IN cuParametros(nNumTicket(rReg)) LOOP
  				        DBMS_SQL.BIND_VARIABLE_CHAR(nIdcursor, ':'||Parametros.nombre_parametro ,Parametros.valor_parametro);
                    END LOOP;
				END IF;

				BEGIN
			        nResp := DBMS_SQL.EXECUTE(nIdcursor);

                    GE_ModEstadoProcEncol_PR(nNumTicket(rReg),NULL,vEstadoSolAudi);

                    IF vEstadoSolAudi = 'ER' THEN
                        ROLLBACK;
                    ELSE
                        COMMIT;
                    END IF;

                    EXCEPTION
                        WHEN OTHERS THEN
                            ROLLBACK;
                            GE_ModEstadoProcEncol_PR(nNumTicket(rReg),'ER',vEstadoSolAudi);
                END;
			END LOOP;

        EXCEPTION

            WHEN VALUE_ERROR THEN
                NULL;

		END GE_EjecutaProcesoEncolado_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END GE_Auditoria_PG;
/
SHOW ERRORS
