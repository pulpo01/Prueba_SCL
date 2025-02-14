CREATE OR REPLACE PACKAGE BODY Pv_Pck_Proc_Factur AS
/******************************************************************************
   NAME:      PV_ACT_PROC_FACTUR
   PURPOSE:   ACTIVAR EL PROCESO DE FACTURACION SOBRE AQUELLAS OOSS, QUE CUMPLAN
              CON LA CONDICION DE ESTADO Y MODO DE GENERACION

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   2.0        03-12-2001  EDUARD CARRIEL   VERSION ORIGINAL

   PARAMETERS:
   INPUT:     MOD_GENER      : MODO DE GENERACION DEL PROCESO
              FLG_COMM       : INDICA SI SE EFECTUARA COMMIT AL FINAL DEL PROCESO

   OUTPUT:    STATUS         : DESCRIPCION DEL ESTADO EN QUE TERMINO EL PROCESO
              ERROR          : RETORNA EL ESTADO DE ERROR (SI HUBO O NO ERROR)

   RETURNED VALUE:
   CALLED BY:
   CALLS:
   EXAMPLE USE:

   ASSUMPTIONS:
   LIMITATIONS:
   ALGORITHM:
   NOTES:

   Here is the complete list of available Auto Replace Keywords:
      Object Name:
      Sysdate:
      Date/Time:
      Date:
      Time:
      Username:
      Trigger Options:
******************************************************************************/
    PROCEDURE pv_act_proc_factur( mod_gener      IN  VARCHAR2,
                                  flg_comm       IN  VARCHAR2,
                                  flg_prioridad  IN  NUMBER,
                                  prioridad      IN  NUMBER,
                                  status         OUT VARCHAR2,
                                  error          OUT VARCHAR2,
                                  d_est_fina     OUT NUMBER) IS

    ex_sql_erro   EXCEPTION;                           /* ZONA DE ERROR                         */
    d_err_proc    NUMBER(1);                           /* CONTROL DE ERROR DE LA FUNCION DE ACT.*/
    b_flg_enco    BOOLEAN;                             /* VERIFICACION DE EXISTENCIA DE REG.    */
    d_est_inic    fa_intqueueproc.cod_estadoc_ent%TYPE;/* ESTADO DE LAS OOSS PARA SER PROCESADAS*/
    --d_est_fina   fa_intqueueproc.cod_estadoc_ent%TYPE;/* ESTADO EN QUE DEBEN QUEDAR LAS OOSS   */
    s_nom_usua    PV_IORSERV.usuario%TYPE;             /* USUARIO RESPONSABLE                   */
    d_ord_serv    PV_IORSERV.num_os%TYPE;              /* OOSS INICIAL A PROCESAR               */
    d_num_proc    PV_CAMCOM.num_proceso%TYPE;          /* NUMERO DE PROCESO                     */
    d_num_vent    PV_CAMCOM.num_venta%TYPE;            /* NUMERO DE VENTA                       */
    s_cod_esta    PV_CAMCOM.cod_estadoc%TYPE;          /* CODIGO DE ESTADO                      */
    d_num_foli    PV_CAMCOM.num_folio%TYPE;            /* NUMERO DE FOLIO                       */
    s_cat_trib    PV_CAMCOM.cat_tribut%TYPE;           /* CATEGORIA TRIBUTARIA                  */
    dt_fec_venc   PV_CAMCOM.fec_vencimiento%TYPE;      /* FECHA VENCIMIENTO                     */
    s_cod_caus    PV_CAMCOM.cod_causaelim%TYPE;        /* CODIGO DE CAUSA DE ELIMINACION        */
    s_pref_plaza  PV_CAMCOM.pref_plaza%TYPE;            /* PREFIJO PLAZA                         */
    TipFoliacion  GA_VENTAS.TIP_FOLIACION%TYPE;         /* TIPO DE FOLIACION DEL DOCUMENTO       */

    /* TM-200501041183: German Espinoza Z; 06/01/2005*/
    state PV_ERECORRIDO.TIP_ESTADO%TYPE;
    sDescripcion PV_ERECORRIDO.descripcion%TYPE;
    sMsgError    PV_ERECORRIDO.MSG_ERROR%TYPE;
    nNum_OsAux   PV_ERECORRIDO.NUM_OS%TYPE;
    /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

    /*
        flg_prioridad = 0 Sin prioridad
        flg_prioridad = 1 Con prioridad
    */

    /* BUSQUEDA DE LAS OOSS LISTAS PARA SER PROCESADAS */

    /*TM-200501041183: German Espinoza Z; 06/01/2005*/

    /*  CURSOR cr_ord_proc IS
        SELECT A.num_os, A.usuario
          FROM PV_IORSERV A, PV_ERECORRIDO B
         WHERE A.cod_modgener = mod_gener
           AND A.COD_ESTADO = B.COD_ESTADO
           AND B.cod_estado   = d_est_inic
           AND B.TIP_ESTADO = 3
           AND (A.num_ospadre IS NOT NULL OR A.num_os = A.num_ospadre)
                   AND A.NUM_OS = B.NUM_OS;

      CURSOR cr_ord_proc_prio IS
        SELECT A.num_os, A.usuario
          FROM PV_IORSERV A, PV_ERECORRIDO B
         WHERE A.cod_modgener = mod_gener
           AND A.COD_ESTADO = B.COD_ESTADO
           AND B.cod_estado   = d_est_inic
           AND B.TIP_ESTADO = 3
           AND (A.num_ospadre IS NOT NULL OR A.num_os = A.num_ospadre)
           AND A.prioridad = prioridad
           AND A.NUM_OS = B.NUM_OS
            ORDER BY A.prioridad ;*/

    CURSOR cr_ord_proc IS
    SELECT A.num_os, A.usuario
	FROM PV_ERECORRIDO B, PV_IORSERV A
	WHERE b.num_os = a.num_os
	AND b.cod_estado   = a.cod_estado
	AND (a.num_ospadre IS NOT NULL OR a.num_os = a.num_ospadre)
	AND NVL(B.TIP_ESTADO, 0) = 3
	AND A.cod_modgener = mod_gener
	AND A.cod_estado   = d_est_inic
	;

    CURSOR cr_ord_proc_prio IS
    SELECT A.num_os, A.usuario
	FROM PV_ERECORRIDO B, PV_IORSERV A
	WHERE b.num_os = a.num_os
	AND   b.cod_estado   = a.cod_estado
	AND   (a.num_ospadre IS NOT NULL OR a.num_os = a.num_ospadre)
	AND   NVL(B.TIP_ESTADO, 0) = 3
	AND   A.cod_modgener = mod_gener
	AND   A.cod_estado   = d_est_inic
	AND   A.prioridad = prioridad
	ORDER BY A.prioridad ;

    /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

    BEGIN
    	status  := 'EN PROCESO';
    	error   := 'NO';

        /* OBTENIENDO ESTADO INICIAL Y FINAL DEL PROCESO */

        if flg_prioridad = 0 THEN   --Sin Prioridad
        	BEGIN
                    SELECT cod_estadoc_ent, cod_estadoc_sal
                    INTO   d_est_inic     , d_est_fina
                    FROM   fa_intqueueproc
                    WHERE  cod_modgener = mod_gener
                    AND    cod_proceso  = 320
                    AND    cod_aplic    = 'PVA';

                EXCEPTION
                	WHEN NO_DATA_FOUND THEN
                		error  := 'SI';
                                status := 'MODO DE GENERACION NO ENCONTRADA';
                        WHEN TOO_MANY_ROWS THEN
                        	error  := 'SI';
                                status := 'INCONSISTENCIA EN EL MODO DE GENERACION';
                        WHEN OTHERS THEN
                        	error  := 'SI';
                                status := 'ERROR EN EL MODO DE GENERACION';
                END;
        ELSIF flg_prioridad = 1 THEN -- Con prioridad

                BEGIN
                     SELECT est_inicial , est_final
                       INTO d_est_inic  , d_est_fina
                       FROM PV_ARCOS
                      WHERE cod_aplic = 'PVA'
                        AND cod_modgener = mod_gener
                        AND cod_proceso  = 320;

                EXCEPTION
                	WHEN NO_DATA_FOUND THEN
                		error  := 'SI';
                                status := 'MODO DE GENERACION NO ENCONTRADA';
                        WHEN TOO_MANY_ROWS THEN
                        	error  := 'SI';
                                status := 'INCONSISTENCIA EN EL MODO DE GENERACION';
                        WHEN OTHERS THEN
                        	error  := 'SI';
                                status := 'ERROR EN EL MODO DE GENERACION';
                END;

        END IF;

        IF error = 'SI' THEN
            RAISE ex_sql_erro;
        END IF;

        /* OBTENIENDO LAS OOSS INICIALES QUE CUMPLEN CON LAS CONDICIONES DEL PROCESO */

        if flg_prioridad = 0 THEN
           OPEN cr_ord_proc;
        ELSIF flg_prioridad = 1 THEN
           OPEN cr_ord_proc_prio;
        END IF;

        /* ACTIVACION DE LAS OOSS */
        b_flg_enco := FALSE;
        LOOP
            BEGIN

            	/* TM-200501041183: German Espinoza Z; 06/01/2005*/
		state := 3;
		sDescripcion :='Proceso Exitoso';
    		sMsgError :='NO HAY ERROR';
    		error := 'NO';
		/*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                if flg_prioridad = 0 THEN
                	FETCH cr_ord_proc INTO d_ord_serv, s_nom_usua;

                    	IF cr_ord_proc%NOTFOUND THEN
                            IF NOT b_flg_enco THEN
                                error  := 'SI';
                                status := 'NO FUERON ENCONTRADAS OOSS';
                            END IF;

                            EXIT;
                        END IF;
                else
                	FETCH cr_ord_proc_prio INTO d_ord_serv, s_nom_usua;

                    	IF cr_ord_proc_prio%NOTFOUND THEN
                            IF NOT b_flg_enco THEN
                                error  := 'SI';
                                status := 'NO FUERON ENCONTRADAS OOSS CON PRIORIDAD';
                            END IF;

                            EXIT;
                        END IF;

                END IF;

		b_flg_enco := TRUE;

		/* TM-200501041183: German Espinoza Z; 06/01/2005*/

		UPDATE PV_IORSERV
                SET    cod_estado = d_est_fina
                WHERE  num_os = d_ord_serv;

                IF SQL%ROWCOUNT <> 1 THEN
                    error  := 'SI';
                    status := 'ERROR AL MARCAR OOSS COMO PROCESADA';
                    state := 4; /* Agregado por Alejandro Hott 30/12/2004 Soporte - TM-200501041183 */

                    sDescripcion :='Proceso con Errores';
                    sMsgError :='Varias o Ninguna OOSS a Marcar';

                END IF;

                INSERT INTO PV_ERECORRIDO(num_os,
                                          cod_estado,
                                          fec_ingestado,
                                          descripcion,
                                          tip_estado,
                                          msg_error)
                VALUES                   (d_ord_serv,
                                          d_est_fina,
                                          SYSDATE,
                                          sDescripcion,
                                          state,
                                          sMsgError);

                if flg_comm = 1 THEN
                    COMMIT;
                END IF;

                if error<>'SI' then

		/*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

	                /* OBTENIENDO NUMERO DE VENTA  Y DE PROCESO DE LA OOSS */

	                SELECT num_proceso, num_venta      , cod_estadoc  , num_folio,
	                       cat_tribut , fec_vencimiento, cod_causaelim, pref_plaza
	                INTO   d_num_proc , d_num_vent     , s_cod_esta   , d_num_foli,
	                       s_cat_trib , dt_fec_venc    , s_cod_caus,  s_pref_plaza
	                FROM PV_CAMCOM
	                WHERE num_os = d_ord_serv;

	                /* OBTENIENDO TIPO DE FOLIACION DEL DOCUMENTO DE LA VENTA */

	                IF d_num_vent <> 0 AND d_num_vent IS NOT NULL THEN
	                   SELECT TIP_FOLIACION
	                   INTO TipFoliacion
	                   FROM GA_VENTAS WHERE NUM_VENTA = d_num_vent;
	                END IF;

	                /* ACTIVA LA OOSS */
	                d_err_proc := pv_act_ord_serv(  d_num_proc ,
	                                                d_num_vent ,
	                                                s_cod_esta ,
	                                                d_num_foli ,
	                                                s_pref_plaza,
	                                                s_cat_trib ,
	                                                dt_fec_venc,
	                                                s_nom_usua ,
	                                                s_cod_caus ,
	                                                TipFoliacion );

	                IF d_err_proc <> 0 THEN
	                    error  := 'SI';
	                    status := 'ERROR AL ACTUALIZAR INTERFAZ FACTURACION';

	                    /* TM-200501041183: German Espinoza Z; 06/01/2005*/

	                    /*EXIT;*/

	                    state := 4;
	                    sDescripcion :='Proceso con Errores';
	                    sMsgError :='Error en UP FA_INTERFACT ('||d_err_proc||')';

	    		    UPDATE PV_ERECORRIDO SET
		            TIP_ESTADO  = state,
			    DESCRIPCION = sDescripcion,
			    msg_error   =sMsgError
			    WHERE NUM_OS = d_ord_serv
			    AND   cod_estado=d_est_fina;

	                    /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

	                END IF;

		/*TM-200501041183: German Espinoza Z; 06/01/2005*/
		END IF;

                /* MARCA OOOSS COMO PROCESADA */
                /*
                UPDATE PV_IORSERV
                SET    cod_estado = d_est_fina
                WHERE  num_os = d_ord_serv;

                IF SQL%ROWCOUNT <> 1 THEN
                    error  := 'SI';
                    status := 'ERROR AL MARCAR OOSS COMO PROCESADA';
                    EXIT;
                END IF;


                --MARCA COMO REALIZADA LA ACTIVACION DE LA OOSS PARA FACTURACION
                INSERT INTO PV_ERECORRIDO(num_os,
                                          cod_estado,
                                          fec_ingestado,
                                          descripcion,
                                          tip_estado,
                                          msg_error)
                VALUES                   (d_ord_serv,
                                          d_est_fina,
                                          SYSDATE,
                                          'Proceso Exitoso',
                                          3,
                                          'NO HAY ERROR');*/

		/*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                /* CONFIRMACION DEL PROCESO */
                IF flg_comm = 1 THEN
                    COMMIT;
                END IF;

            EXCEPTION
            	WHEN NO_DATA_FOUND THEN
            		error  := 'SI';
                        status := 'DATOS DE OOSS NO ENCONTRADOS';

                        /*TM-200501041183: German Espinoza Z; 06/01/2005*/
                        /*EXIT;*/

                        ROLLBACK;

		  	error  := 'SI';
                  	status := 'DATOS DE OOSS NO ENCONTRADOS';
                  	state := 4;

	  	  	UPDATE PV_ERECORRIDO SET
	  	  	TIP_ESTADO = 4,
		  	DESCRIPCION = 'Proceso con Errores',
		  	msg_error='DATOS DE OOSS NO ENCONTRADOS'
		  	WHERE NUM_OS = d_ord_serv
		  	AND cod_estado=d_est_fina;

  		  	IF flg_comm = 1 THEN
 	 			COMMIT;
  		  	END IF;

                        /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                WHEN TOO_MANY_ROWS THEN
                	error  := 'SI';
                        status := 'INCONSISTENCIA EN OOSS';

                        /*TM-200501041183: German Espinoza Z; 06/01/2005*/
                        /*EXIT;*/

                        ROLLBACK;

                        error  := 'SI';
                        status := 'INCONSISTENCIA EN OOSS';

                        UPDATE PV_ERECORRIDO SET
	                TIP_ESTADO = 4,
			DESCRIPCION = 'Proceso con Errores',
			msg_error='INCONSISTENCIA EN OOSS'
			WHERE NUM_OS = d_ord_serv
			AND cod_estado=d_est_fina;

                	IF flg_comm = 1 THEN
                    		COMMIT;
                	END IF;

                        /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                WHEN OTHERS THEN
                	error  := 'SI';
                        status := 'ERROR AL ACTIVAR OOSS';

                        /*TM-200501041183: German Espinoza Z; 06/01/2005*/
                        /*EXIT;*/

                        ROLLBACK;

                        error  := 'SI';
                        status := 'ERROR AL ACTIVAR OOSS';

	                UPDATE PV_ERECORRIDO SET
	                TIP_ESTADO = 4,
			DESCRIPCION = 'Proceso con Errores',
			msg_error='ERROR AL ACTIVAR OOSS'
			WHERE NUM_OS = d_ord_serv
			AND cod_estado=d_est_fina;

			if flg_comm = 1 THEN
                    		COMMIT;
                	END IF;
                        /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

            END;
        END LOOP;

        if flg_prioridad = 0 THEN
           CLOSE cr_ord_proc;
        else
           CLOSE cr_ord_proc_prio;
        END IF;

        IF error = 'SI' THEN
            ROLLBACK;
            RAISE ex_sql_erro;
        END IF;

        /* PROCESO TERMINADO CORRECTAMENTE */

        error  := 'NO';
        status := 'TERMINADO';

        /* SALE DEL PROCEDIMIENTO EN CASO DE ERROR */

        EXCEPTION WHEN ex_sql_erro THEN NULL;

    END pv_act_proc_factur;



/******************************************************************************
   NAME:      PV_ACT_ORD_SERV
   PURPOSE:   ACTIVAR LA ORDEN DE SERVICIO PARA FACTURACION

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   2.0        03-12-2001  EDUARD CARRIEL   VERSION ORIGINAL

   PARAMETERS:
   INPUT:     NUM_PROC : NUMERO DEL PROCESO DE ACTUALIZACION (200)
              NUM_VENT : NUMERO DE VENTA GENERADO EN POST-VENTA
              COD_ESTA : ESTADO CON QUE SE DEBE DEJAR LA ORDEN
              NUM_FOLI : NUMERO DE FOLIO DE LA SOLICITUD
              IND_DOCU : INDICADOR DE ACTUALIZACION DEL FOLIO
              FEC_VENC : FECHA VENCIMIENTO DEL CARGO A FACTURAR
              NOM_USUA : USUARIO RESPONSABLE DE LA ELIMINACION
              COD_CAUS : CAUSA DE ELIMINACION DEL CARGO SI CORRESPONDE

   RETURNED VALUE: 0 EN CASO DE TERMINO CORRECTO Y -1 EN CASO DE TERMINO CON ERROR
   CALLED BY:
   CALLS:
   EXAMPLE USE:

   ASSUMPTIONS:
   LIMITATIONS:
   ALGORITHM:
   NOTES:

   Here is the complete list of available Auto Replace Keywords:
      Object Name:
      Sysdate:
      Date/Time:
      Date:
      Time:
      Username:
      Trigger Options:
******************************************************************************/

    FUNCTION pv_act_ord_serv( num_proc IN NUMBER,
                              num_vent IN NUMBER,
                              cod_esta IN VARCHAR2,
                              num_foli IN NUMBER,
                              pref_plaza IN VARCHAR2,
                              ind_docu IN VARCHAR2,
                              fec_venc IN DATE,
                              nom_usua IN VARCHAR2,
                              cod_caus IN VARCHAR2,
                              tip_foliacion IN VARCHAR2 ) RETURN NUMBER IS

    error       VARCHAR2(2);

    BEGIN
        error := 'NO';

        BEGIN
            /* ACTUALIZA FACTURACION INDICANDO QUE LA OOSS ESTA DISPONIBLE PARA PROCESAR */

            /* TM-200501041183: German Espinoza Z; 06/01/2005*/
            --if cod_esta < 100 THEN
            if cod_esta = 100 AND num_proc IS NOT NULL AND num_proc>0 THEN
            /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

            	UPDATE fa_interfact
                SET cod_estadoc = cod_esta,
                cod_estproc = 3
                WHERE num_proceso = num_proc
                AND   num_venta   = num_vent
                AND       NUM_VENTA   > 0;

            /*TM-200501041183: German Espinoza Z; 06/01/2005*/
            --END IF;
            /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

	        if SQL%ROWCOUNT <> 1 THEN
	        	/*TM-200501041183: German Espinoza Z; 06/01/2005*/
	        	--dbms_output.put_line('Error 1');
	        	--RETURN 0;

	                RETURN -1;
	                /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/
	        END IF;

	    /*TM-200501041183: German Espinoza Z; 06/01/2005*/
            END IF;
            /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

            /* TM-200501041183: German Espinoza Z; 06/01/2005*/
            --IF ind_docu = 'B' AND tip_foliacion = 'P' AND num_foli IS NOT NULL THEN
            IF ind_docu = 'B' AND tip_foliacion = 'P' AND num_foli IS NOT NULL AND num_proc IS NOT NULL AND num_proc>0 THEN
            /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                UPDATE fa_interfact
                SET num_folio = num_foli,
                                    pref_plaza = pref_plaza
                WHERE num_proceso = num_proc
                AND   num_venta   = num_vent
                                AND NUM_VENTA > 0;

                IF SQL%ROWCOUNT <> 1 THEN
                    /* TM-200501041183: German Espinoza Z; 06/01/2005*/
                    --dbms_output.put_line('Error 2');
                    --RETURN -1;

                    RETURN -2;
                    /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/
                END IF;
            END IF;

	    /* TM-200501041183: German Espinoza Z; 06/01/2005*/
            --IF fec_venc IS NOT NULL and num_vent > 0 and num_vent is not null THEN
            IF fec_venc IS NOT NULL and num_vent > 0 and num_vent is not null AND num_proc IS NOT NULL AND num_proc>0 THEN
            /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                UPDATE fa_interfact
                   SET fec_vencimiento = fec_venc
                 WHERE num_proceso = num_proc
                   AND num_venta   = num_vent
                   AND NUM_VENTA > 0;

                IF SQL%ROWCOUNT <> 1 THEN
                    /* TM-200501041183: German Espinoza Z; 06/01/2005*/
                    --dbms_output.put_line('Error 3');
                    --RETURN -1;

                    RETURN -3;
                    /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                END IF;
            END IF;

	    /* TM-200501041183: German Espinoza Z; 06/01/2005*/
            --IF cod_caus IS NOT NULL THEN
            IF cod_caus IS NOT NULL AND num_proc IS NOT NULL AND num_proc>0 THEN
            /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/

                UPDATE fa_interfact
                SET nom_usuaelim  = nom_usua,
                    cod_causaelim = cod_caus
                WHERE num_proceso = num_proc
                AND   num_venta   = num_vent;

                IF SQL%ROWCOUNT <> 1 THEN

                    /* TM-200501041183: German Espinoza Z; 06/01/2005*/
                    --dbms_output.put_line('Error 4');
                    --RETURN -1;

                    RETURN -4;
                    /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/
                END IF;
            END IF;

            EXCEPTION
            	WHEN NO_DATA_FOUND THEN error := 'SI';
                WHEN TOO_MANY_ROWS THEN error := 'SI';
                WHEN OTHERS        THEN error := 'SI';
        END;

        IF error = 'SI' THEN /* SALE CON ERROR */

            /* TM-200501041183: German Espinoza Z; 06/01/2005*/
            --dbms_output.put_line('Error 5');
            --RETURN -1;

            RETURN -5;
            /*FIN - TM-200501041183: German Espinoza Z; 06/01/2005*/
        END IF;

        /* FUNCION TERMINADA CORRECTAMENTE */
        dbms_output.put_line('Termino OK');
        RETURN 0;

    END;
END Pv_Pck_Proc_Factur;
/
SHOW ERRORS
