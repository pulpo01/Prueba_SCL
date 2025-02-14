CREATE OR REPLACE PACKAGE BODY GA_SERVICIOS_ARTPLAN_PG
IS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MOD_PLANARTI_PR (EN_num_celular       IN     ga_abocel.num_celular%TYPE,
						      SV_plan_actual      OUT    NOCOPY   ta_plantarif.cod_plantarif%TYPE,
							  SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
							  SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MOD_PLANARTI_PR"
      Lenguaje="PL/SQL"
      Fecha="22-08-2005"
      Versión="1.0"
      Diseñador=""Christian Estay M."
      Programador="Christian Estay M."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para actualizar el plan asociado al articulo XO-200508190402/Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_plan_actual"     Tipo="Caracter">Plan actualizado</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion     EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
        sSql2               ge_errores_pg.vQuery;
		SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_ant_cod_cliente  ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
        SV_num_min          ga_abocel.num_min%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec     ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_ant_cod_cuenta   ga_abocel.cod_cuenta%TYPE;
		VP_NUMTRANSABABO    VARCHAR2(50);
		LV_ejec_rest	    VARCHAR2(500);
		LV_ret_valida		VARCHAR2(200);
		LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;

    BEGIN
		--Inicializar variables...
  		sSql:=NULL;
		SN_cod_retorno:=0;
		SN_num_evento:=0;
		SV_mens_retorno:=NULL;
		SV_plan_actual:=NULL;
		LV_ret_valida:=NULL;
		LV_ejec_rest:=NULL;

        -- 0.- Validar si numero celular cumple con el largo definido...
		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||');',1,CN_largoquery);
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
           SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--1.- Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||',''SI'')',1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

        -- Restricción sólo para prepago...
	    --2.- Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql2:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''DESBLOQUEO'','||LV_ejec_rest||');',1,CN_largoquery);
        sSql:=sSql2;
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'DESBLOQUEO',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 THEN
	       SN_cod_retorno := '298';
		   sSql:=SUBSTR(sSql2||'-'||LV_des_cadena,1,CN_largoquery);
		   RAISE error_ejecucion;
		END IF;

   	   --3- Ejecutar procedimiento que obtiene datos del abonado
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||');-',1,CN_largoquery);
 	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_ant_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_ant_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);

		IF SN_cod_retorno<>0 THEN
   	      RAISE  error_ejecucion;
		END IF;
		IF SN_ant_cod_cliente IS NULL THEN
          SN_cod_retorno := '146';
   	      RAISE  error_ejecucion;
		END IF;

        --4.-Solicitar cambio de plan ...
		sSql:=SUBSTR('GA_SERVICIOS_ARTPLAN_PG.GA_MOD_PLANARTI_PR('||SN_num_abonado||','||SV_num_serie||')',1,CN_largoquery);
		GA_SERVICIOS_ARTPLAN_PG.GA_CAMBPLANARTI_PR(SN_num_abonado,SV_num_serie,SV_plan_actual,SN_cod_retorno,V_des_error,SN_num_evento);
		IF SN_cod_retorno<>0 THEN
	       RAISE error_ejecucion;
		END IF;


   EXCEPTION
    WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion:GA_MOD_PLANARTI_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ARTPLAN_PG.GA_MOD_PLANARTI_PR', sSql, SQLCODE, V_des_error );
     WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('OTHERS:GA_MOD_PLANARTI_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ARTPLAN_PG.GA_MOD_PLANARTI_PR', sSql, SQLCODE, V_des_error );
END GA_MOD_PLANARTI_PR;
-------------------------------------------------------------------------------------------------------
FUNCTION GA_OBTENER_KIT_FN (
   EV_num_serie      IN           ga_aboamist.num_serie%TYPE,
   SN_cod_kit       OUT NOCOPY    al_componente_kit.cod_kit%TYPE,
   SN_cod_retorno   OUT NOCOPY    ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY    ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY    ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_OBTENER_KIT_FN"
      Lenguaje="PL/SQL"
      Fecha="23-08-2005"
      Versión="1.0"
      Diseñador="Christian Estay"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener el kit de una serie</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_num_serie" Tipo="CARACTER">Numero de serie</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_kit"       Tipo="NUMERICO">Codigo del kit</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;

BEGIN
       SN_cod_retorno:= '0';
       SN_num_evento:= 0;

       /* Inicio modificacion by SAQL/Soporte 23/11/2005 - RA-200511170135 */
       /*sSql:='SELECT COD_KIT  INTO SN_cod_kit '||
		     'FROM AL_COMPONENTE_KIT '||
		     'WHERE NUM_SERIE='''||EV_num_serie||'''';

		SELECT COD_KIT  INTO SN_cod_kit
		  FROM AL_COMPONENTE_KIT
		 WHERE NUM_SERIE = EV_num_serie;
       */

       sSql := 'SELECT COD_KIT  INTO SN_cod_kit ' ||
               'FROM AL_COMPONENTE_KIT ' ||
               'WHERE NUM_SERIE='''||EV_num_serie||''''||
               'AND FEC_ENTRADA = (SELECT MAX(FEC_ENTRADA)'||
		                          ' FROM AL_COMPONENTE_KIT '||
		                          ' WHERE NUM_SERIE='''||EV_num_serie||''')';

		SELECT COD_KIT INTO SN_cod_kit
		FROM AL_COMPONENTE_KIT
		WHERE NUM_SERIE = EV_num_serie
		AND FEC_ENTRADA = (
		   SELECT MAX(FEC_ENTRADA)
		   FROM AL_COMPONENTE_KIT
		   WHERE NUM_SERIE = EV_num_serie);
       /* Fin modificacion by SAQL/Soporte 23/11/2005 - RA-200511170135 */
       RETURN  TRUE;

EXCEPTION

--XO-200509290766: German Espinoza Z; 29/09/2005
WHEN NO_DATA_FOUND THEN
	 SN_cod_kit:=1;
	 RETURN  TRUE;
--FIN/XO-200509290766: German Espinoza Z; 29/09/2005

WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error :=SUBSTR('others  : GA_OBTENER_KIT_FN('||EV_num_serie||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ARTPLAN_PG.GA_OBTENER_KIT_FN', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  GA_OBTENER_KIT_FN;
-------------------------------------------------------------------------------------------------------
FUNCTION GA_OBTENER_PLANACT_KIT_FN (
   EN_cod_kit        IN           al_componente_kit.cod_kit%TYPE,
   SV_plan_actual   OUT NOCOPY    PV_RELACION_ART_PLAN_TO.cod_plantarif%TYPE,
   SN_cod_retorno   OUT NOCOPY    ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY    ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY    ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_OBTENER_PLANACT_KIT_FN"
      Lenguaje="PL/SQL"
      Fecha="23-08-2005"
      Versión="1.0"
      Diseñador="Christian Estay"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtener el kit de una serie</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_kit"       Tipo="NUMERICO">Codigo del kit</param>
         </Entrada>
         <Salida>
            <param nom="SV_plan_actual"      Tipo="CARACTER">Plan actual del kit</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;

BEGIN
       SN_cod_retorno:='0';
       SN_num_evento:=0;
	   SV_plan_actual:=NULL;

       --XO-200509090632: German Espinoza Z; 10/09/2005
       /*sSql:='SELECT COD_PLANTARIF  INTO SV_plan_actual '||
		     ' FROM PV_RELACION_ART_PLAN_TO '||
		     ' WHERE COD_ARTICULO = '||EN_cod_kit ||
		     ' AND TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)'||
		     ' AND TRUNC(FEC_HASTA) <= TRUNC(SYSDATE)';
			*/
        sSql:='SELECT COD_PLANTARIF  INTO SV_plan_actual '||
		     ' FROM PV_RELACION_ART_PLAN_TO '||
		     ' WHERE COD_ARTICULO = '||EN_cod_kit ||
		     ' AND TRUNC(FEC_DESDE) <= TRUNC(SYSDATE)'||
		     ' AND TRUNC(FEC_HASTA) >= TRUNC(SYSDATE)';


  		/*SELECT COD_PLANTARIF  INTO SV_plan_actual
		  FROM PV_RELACION_ART_PLAN_TO
		 WHERE COD_ARTICULO = EN_cod_kit
		   AND TRUNC(FEC_DESDE) >= TRUNC(SYSDATE)
		   AND TRUNC(FEC_HASTA) <= TRUNC(SYSDATE);*/

		  SELECT COD_PLANTARIF  INTO SV_plan_actual
		  FROM PV_RELACION_ART_PLAN_TO
		 WHERE COD_ARTICULO = EN_cod_kit
		   AND TRUNC(FEC_DESDE) <= TRUNC(SYSDATE)
		   AND TRUNC(FEC_HASTA) >= TRUNC(SYSDATE);

		 --FIN/XO-200509090632: German Espinoza Z; 10/09/2005

       RETURN  TRUE;

EXCEPTION
WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error :=SUBSTR('others  : GA_OBTENER_PLANACT_KIT_FN('||EN_cod_kit||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ARTPLAN_PG.GA_OBTENER_PLANACT_KIT_FN', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  GA_OBTENER_PLANACT_KIT_FN;
-------------------------------------------------------------------------------------------------------
FUNCTION GA_MODIFICAR_PLANABO_FN (
   EN_num_abonado   IN          ga_aboamist.num_abonado%TYPE,
   EV_plan_actual   IN          ta_plantarif.cod_plantarif%TYPE,
   SN_cod_retorno   OUT NOCOPY  ge_errores_pg.CodError,
   SV_mens_retorno  OUT NOCOPY  ge_errores_pg.MsgError,
   SN_num_evento    OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_MODIFICAR_PLANABO_FN"
      Lenguaje="PL/SQL"
      Fecha="23-08-2005"
      Versión="1.0"
      Diseñador="Christian Estay"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Modificacion de plan del abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado"       Tipo="NUMERICO">Numero de abonado</param>
            <param nom="EV_plan_actual"      Tipo="CARACTER">Plan actual del kit</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN  BOOLEAN
AS
   V_des_error              ge_errores_pg.DesEvent;
   sSql                     ge_errores_pg.vQuery;
   LV_CargoBas				ta_plantarif.cod_cargobasico%TYPE;--XO-200509290766: German Espinoza Z; 29/09/2005

BEGIN
       SN_cod_retorno:='0';
       SN_num_evento:=0;

	   --XO-200509290766: German Espinoza Z; 29/09/2005
	   SELECT cod_cargobasico
	   INTO   LV_CargoBas
	   FROM   ta_plantarif
	   WHERE  cod_plantarif=EV_plan_actual;
	   --FIN/XO-200509290766: German Espinoza Z; 29/09/2005

	    UPDATE GA_ABOAMIST
		   SET COD_PLANTARIF = EV_plan_actual
		      ,cod_cargobasico = LV_CargoBas --XO-200509290766: German Espinoza Z; 29/09/2005
		 WHERE NUM_ABONADO =  EN_num_abonado;

       RETURN  TRUE;

EXCEPTION
WHEN  OTHERS   THEN
      SN_cod_retorno:='302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error :=SUBSTR('others  : GA_MODIFICAR_PLANABO_FN('||EN_num_abonado||','||EV_plan_actual||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ARTPLAN_PG.GA_MODIFICAR_PLANABO_FN', sSql, SQLCODE, V_des_error );
	  ROLLBACK;
      RETURN  FALSE;
END  GA_MODIFICAR_PLANABO_FN;
-------------------------------------------------------------------------------------------------------
PROCEDURE GA_CAMBPLANARTI_PR (EN_num_abonado       IN    ga_aboamist.num_abonado%TYPE,
		  					  EV_num_serie		   IN    ga_aboamist.num_serie%TYPE,
						      SV_plan_actual      OUT    NOCOPY   ta_plantarif.cod_plantarif%TYPE,
							  SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
							  SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CAMBPLANARTI_PR"
      Lenguaje="PL/SQL"
      Fecha="22-08-2005"
      Versión="1.0"
      Diseñador=""Christian Estay M."
      Programador="Christian Estay M."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para actualizar el plan asociado al articulo XO-200508190402/Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero de abonado</param>
            <param nom="EV_num_serie" Tipo="CARACTER">Numero de serie</param>

         </Entrada>
         <Salida>
            <param nom="SV_plan_actual"     Tipo="Caracter">Plan actualizado</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        error_ejecucion  	EXCEPTION ;
        V_des_error         ge_errores_pg.DesEvent;
        sSql                ge_errores_pg.vQuery;
		SN_cod_kit          al_componente_kit.cod_kit%TYPE;

    BEGIN
		--Inicializar variables...
  		sSql:=NULL;
		SN_cod_kit:=0;
		SV_plan_actual:=NULL;
		SV_mens_retorno:=NULL;
		SN_cod_retorno:=0;
		SN_num_evento:=0;

		-- Obtener kit de la serie....
        sSql:=SUBSTR('GA_OBTENER_KIT_FN('||EV_num_serie||');',1,CN_largoquery);
		IF NOT GA_OBTENER_KIT_FN(EV_num_serie,SN_cod_kit,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		   RAISE  error_ejecucion;
		END IF;

		-- Obtener plan actual del kit...
        sSql:=SUBSTR('GA_OBTENER_PLANACT_KIT_FN('||SN_cod_kit||');',1,CN_largoquery);
		IF NOT GA_OBTENER_PLANACT_KIT_FN(SN_cod_kit,SV_plan_actual,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		   RAISE  error_ejecucion;
		END IF;

		-- Modificar plan del abonado...
        sSql:=SUBSTR('GA_MODIFICAR_PLANABO_FN('||EN_num_abonado||','||SV_plan_actual||');',1,CN_largoquery);
		IF NOT GA_MODIFICAR_PLANABO_FN(EN_num_abonado,SV_plan_actual,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
		   RAISE  error_ejecucion;
		END IF;


EXCEPTION
WHEN error_ejecucion THEN
		 		SN_cod_retorno := '322';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion : GA_CAMBPLANARTI_PR('||EN_num_abonado||','||EV_num_serie||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ARTPLAN_PG.GA_CAMBPLANARTI_PR', sSql, SQLCODE, V_des_error );

WHEN OTHERS  THEN
                SN_cod_retorno := '302';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasIF;
                END IF;
                V_des_error :=SUBSTR('others : GA_CAMBPLANARTI_PR('||EN_num_abonado||','||EV_num_serie||'); - ' || SQLERRM,1,CN_largoerrtec);
				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_SERVICIOS_ARTPLAN_PG.GA_CAMBPLANARTI_PR', sSql, SQLCODE, V_des_error );
END GA_CAMBPLANARTI_PR;

-------------------------------------------------------------------------------------------------------
END GA_SERVICIOS_ARTPLAN_PG;
/
SHOW ERRORS
