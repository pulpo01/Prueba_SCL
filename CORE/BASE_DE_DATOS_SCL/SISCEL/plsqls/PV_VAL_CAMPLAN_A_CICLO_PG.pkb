CREATE OR REPLACE PACKAGE BODY PV_VAL_CAMPLAN_A_CICLO_PG AS
--PV_VAL_CAMPLAN_A_CICLO_PG  V.1.1  COL-72030|27-10-2008|DVG

PROCEDURE PV_VAL_CAMPLAN_A_CICLO_PR(
          EV_cod_cliente           IN               ge_clientes.cod_cliente%TYPE,
      	  EV_num_abonado           IN               ga_abocel.num_abonado%TYPE,
          EV_cod_OOSS              IN               ci_orserv.cod_os%TYPE,
          EV_cod_plantarif         IN               ta_plantarif.cod_plantarif%TYPE,
          SV_cod_retorno           OUT              VARCHAR2,--1 tiene 0 no tiene 4 error
      	  SV_glosa_retorno         OUT              VARCHAR2,
          SV_plan_NUEVO            OUT              ta_plantarif.cod_plantarif%TYPE,
          SV_NUM_OOSS              OUT              pv_camcom.num_os%TYPE,
          SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      	  SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      	  SN_num_evento            OUT NOCOPY               ge_errores_pg.evento
          )
        IS

--Declaracion de Cursores
--Declaracion de Variables
        LV_des_error        ge_errores_pg.DesEvent;
        LV_sSql                     ge_errores_pg.vQuery;
        V_ESTADO            PV_IORSERV.cod_estado%TYPE;
        ERROR_NO_DATOS_PLAN EXCEPTION;
        TODO_OK             EXCEPTION;
        V_PLANTARIF         ta_plantarif.cod_plantarif%TYPE;
        V_INTENTO_MAX       VARCHAR2(3);

        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_VAL_CAMPLAN_A_CICLO_PG"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador= " Orlando Cabezas"
              Programador="Nicolás Contreras"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Verifica si existen OOSS de Cambio de plan pendientes ya sea por el metodo antiguo pv_Camcom pv_errecorido</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EV_cod_cliente" Tipo="STRING"></param>>
                                <param nom="EV_num_abonado" Tipo="STRING"></param>>
                                <param nom="EV_cod_OOSS" Tipo="STRING"></param>>
                                <param nom="EV_cod_plantarif" Tipo="STRING"></param>>
                     </Entrada>
                 <Salida>
                                <param nom="SV_cod_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SV_glosa_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SV_plan_NUEVO" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SV_NUM_OOSS" Tipo="CARACTER">Mensaje de Retorno</param>>
                                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

BEGIN
SV_glosa_retorno:='OK';
SV_cod_retorno:='0';
SV_plan_NUEVO:='-';
SV_NUM_OOSS:=0;
SN_cod_retorno  := 0;
SV_mens_retorno := NULL;
SN_num_evento   := 0;
SN_cod_retorno:='0';
SV_mens_retorno:='NO HAY';
SN_num_evento:=0;

BEGIN

    SELECT VAL_PARAMETRO
    INTO V_INTENTO_MAX
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO = 'MAX_INTENTOS'
    AND COD_MODULO      = 'GA'
    AND COD_PRODUCTO    = 1;

	--INI|COL-72030|24-10-2008|DVG
    /*SELECT  NUM_OS,COD_ESTADO
    INTO SV_NUM_OOSS,V_ESTADO
    FROM PV_IORSERV
    WHERE COD_OS IN (10020,10022,10029,10233,10530,10539)
        AND NUM_OSF_ERR <> 1
        AND TRUNC(FH_EJECUCION) >= TRUNC(SYSDATE)
    AND NUM_OS IN (SELECT  NUM_OS FROM PV_CAMCOM
                       WHERE   COD_CLIENTE = ev_cod_cliente AND
                               NUM_ABONADO = ev_num_abonado AND
                               TRUNC(FEC_VENCIMIENTO) >= TRUNC(SYSDATE));*/

    SELECT A.NUM_OS, A.COD_ESTADO
    INTO   SV_NUM_OOSS,V_ESTADO
	FROM   PV_IORSERV A, PV_ERECORRIDO B
	WHERE  A.COD_OS IN ('10020','10022','10029','10233','10530','10539')
	AND    A.NUM_OS IN (SELECT NUM_OS FROM PV_CAMCOM
		   			    WHERE COD_CLIENTE = ev_cod_cliente
						AND   NUM_ABONADO = ev_num_abonado)
	AND    A.NUM_OS=B.NUM_OS
	AND    A.COD_ESTADO=B.COD_ESTADO
	AND    B.TIP_ESTADO=3
	AND    ROWNUM <= 1;
	--FIN|COL-72030|24-10-2008|DVG

	EXCEPTION
          WHEN NO_DATA_FOUND THEN
               --INI|COL-72030|24-10-2008|DVG
			   --NULL;
			   BEGIN
				   SELECT A.NUM_OS, A.COD_ESTADO
				   INTO   SV_NUM_OOSS,V_ESTADO
                   FROM   PV_IORSERV A, PV_ERECORRIDO B
                   WHERE  A.COD_OS IN ('10020','10022','10029','10233','10530','10539')
                   AND    A.NUM_OS IN (SELECT NUM_OS FROM PV_CAMCOM
				   		  		   	   WHERE COD_CLIENTE = ev_cod_cliente
									   AND   NUM_ABONADO = ev_num_abonado)
                   AND    A.NUM_OS = B.NUM_OS
                   AND    A.COD_ESTADO = B.COD_ESTADO
                   AND    B.TIP_ESTADO = 4
                   AND	  A.NUM_INTENTOS < V_INTENTO_MAX
                   AND ROWNUM <= 1;

			   EXCEPTION
          	   			WHEN NO_DATA_FOUND THEN
               				 NULL;
			   END;
			   --FIN|COL-72030|24-10-2008|DVG
END;

IF SV_NUM_OOSS IS NULL OR SV_NUM_OOSS=0 THEN
       V_PLANTARIF :='';

           BEGIN

           LV_sSql:=' SELECT COD_PLANTARIF FROM  GA_FINCICLO';
           LV_sSql:= LV_sSql||' WHERE COD_CLIENTE = '||EV_cod_cliente||' AND';
           LV_sSql:= LV_sSql||' NUM_ABONADO = '||EV_num_abonado||' and';
           LV_sSql:= LV_sSql||' COD_PLANTARIF <> '||EV_cod_plantarif;

           SELECT COD_PLANTARIF
           INTO V_PLANTARIF
           FROM  GA_FINCICLO
       WHERE COD_CLIENTE = EV_cod_cliente AND
       NUM_ABONADO = EV_num_abonado and
       COD_PLANTARIF <> EV_cod_plantarif;

           EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                         NULL;
           END;

           IF V_PLANTARIF IS NULL THEN
          SV_cod_retorno :='0';
          SV_glosa_retorno:='NO EXISTEN OOSS PENDIENTES DE CAMBIO DE PLAN';
                  RAISE TODO_OK;
           ELSE
              SV_cod_retorno :='1';
          SV_glosa_retorno:='Existen OOSS pendientes de Cambio de Plan, si continúa se anulará la programación';
                  RAISE TODO_OK;
       END IF;
ELSE
   IF V_ESTADO < 210 THEN

      BEGIN

           LV_sSql:='SELECT COD_PLANTARIF_NUE INTO SV_plan_NUEVO FROM PV_PARAM_ABOCEL';
           LV_sSql:= LV_sSql||' WHERE NUM_OS='||SV_NUM_OOSS||' AND COD_TIPMODI IN (''SS'',''BA'')';
           LV_sSql:= LV_sSql||'  AND COD_PLANTARIF_NUE IS NOT NULL';
           LV_sSql:= LV_sSql||'  AND COD_PLANTARIF <>'||''''||EV_COD_PLANTARIF||'''';

           SELECT NVL(COD_PLANTARIF_NUE,' ')
		   INTO   SV_plan_NUEVO
		   FROM   PV_PARAM_ABOCEL
		   WHERE  NUM_OS=SV_NUM_OOSS
		   AND 	  COD_TIPMODI IN ('SS','BA')
		   AND 	  COD_PLANTARIF IS NOT NULL
		   AND 	  NVL(COD_PLANTARIF_NUE,'-') <> EV_COD_PLANTARIF;

		   if SV_plan_NUEVO = ' ' then
		   	RAISE TODO_OK;						-- Requerimiento de Soporte 77756
		   end if;

           SV_cod_retorno:=1;
           SV_glosa_retorno:='Existen OOSS pendientes de Cambio de Plan, si continúa se anulará la programación';
           RAISE TODO_OK;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN
               RAISE ERROR_NO_DATOS_PLAN;
          END;
   ELSE
      SV_cod_retorno :='0';
      SV_glosa_retorno:='NO EXISTEN OOSS PENDIENTES DE CAMBIO DE PLAN';
          RAISE TODO_OK;
   END IF;
END IF;


EXCEPTION
          WHEN TODO_OK THEN
               SV_NUM_OOSS :=0;
                   NULL;
          WHEN ERROR_NO_DATOS_PLAN THEN
              SN_cod_retorno := 1;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' NO EXISTEN DATOS EN QUERY DE BUSQUEDA DE PLANES EN PV_PARAM_ABOCEL ('||SV_NUM_OOSS||','||EV_COD_PLANTARIF||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_VAL_CAMPLAN_A_CICLO_PG', LV_sSQL, SN_cod_retorno, LV_des_error );
                  SV_cod_retorno:=4;
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' PV_VAL_CAMPLAN_A_CICLO_PR ('||EV_cod_cliente||','||EV_num_abonado||','||EV_cod_OOSS||','||EV_cod_plantarif||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_VAL_CAMPLAN_A_CICLO_PG', LV_sSQL, SN_cod_retorno, LV_des_error );
          SV_cod_retorno :=4;
END PV_VAL_CAMPLAN_A_CICLO_PR;

FUNCTION PV_GET_OOSS_FN  ( EV_COD_CLIENTE GE_CLIENTES.Cod_CLIENTE%TYPE, EV_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE)
RETURN PV_IORSERV.NUM_OS%TYPE
IS
/*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_GET_OOSS_FN"
              Lenguaje="PL/SQL"
              Fecha="14-06-2007"
              Versión="La del package"
              Diseñador= " Orlando Cabezas"
              Programador="Nicolás Contreras"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Verifica si existen OOSS de Cambio de plan pendientes ya sea por el metodo antiguo pv_Camcom pv_errecorido</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EV_cod_cliente" Tipo="STRING"></param>>
                                <param nom="EV_num_abonado" Tipo="STRING"></param>>
                     </Entrada>
                 <Salida>
                                <param nom="SV_NUM_OOSS" Tipo="CARACTER">Numero de OOSS</param>>
                     </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

V_NUM_OS PV_IORSERV.NUM_OS%TYPE;

BEGIN
     SELECT  NUM_OS
     INTO V_NUM_OS
     FROM PV_IORSERV
     --WHERE COD_OS IN (10020,10022,10029,10233,10530,10539)
	 WHERE COD_OS IN ('10020','10022','10029','10233','10530','10539')  --COL-72030|24-10-2008|DVG
     AND NUM_OSF_ERR <> 1
     AND COD_ESTADO < 210
     AND TRUNC(FH_EJECUCION) >= TRUNC(SYSDATE)
     AND NUM_OS IN (SELECT  NUM_OS FROM PV_CAMCOM
                    WHERE   COD_CLIENTE = EV_COD_CLIENTE AND
                   NUM_ABONADO = EV_NUM_ABONADO AND
                           TRUNC(FEC_VENCIMIENTO) >= TRUNC(SYSDATE))
         AND ROWNUM=1;

     RETURN V_NUM_OS;

         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                     RETURN 0;



END PV_GET_OOSS_FN;


END PV_VAL_CAMPLAN_A_CICLO_PG;
/
SHOW ERRORS
