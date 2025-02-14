CREATE OR REPLACE PACKAGE BODY GA_TRAFICO_PG
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MINUTOS_POR_PERIODO_PR (EN_cod_cliente    IN          ga_abocel.cod_cliente%TYPE,
		  							 EN_num_abonado     IN		    ga_abocel.num_abonado%TYPE,
									 EN_cod_ciclfact    IN		    fa_ciclfact.cod_ciclfact%TYPE,
									 EV_cod_plantarif   IN          ga_abocel.cod_plantarif%TYPE,
									 EC_dig			  	IN		    CHAR,
									 SC_min_hor         OUT NOCOPY  refcursor,
									 SC_min_tip_dia     OUT NOCOPY  refcursor,
                					 SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                					 SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                	 SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MINUTOS_POR_PERIODO_PR"
      Lenguaje="PL/SQL"
      Fecha="12-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta minutos consumidos según franja horaria</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Codigo del ciclo de facturacion actual</param>
            <param nom="EV_cod_plantarif" Tipo="CARACTER">Plan tarifario</param>
            <param nom="EC_dig" Tipo="CARACTER">Plan tarifario</param>
         </Entrada>
         <Salida>
            <param nom="SC_min_hor"   Tipo="CURSOR">Minutos consumidos por horario</param>
            <param nom="SC_min_tip_dia"  Tipo="CURSOR">Minutos consumidos por tipo de dia</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO">Evento Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
		sSql2                ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;
		error_ejecucion		 EXCEPTION;

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

		--Generar query a ejecutar....
        --RA-200511100082: German Espinoza Z; 10/11/2005
		--sSql:=SUBSTR('SELECT cod.gls_param AS glosa,det.cod_thor AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
		sSql:='SELECT cod.gls_param AS glosa,det.cod_thor AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
		--FIN/RA-200511100082: German Espinoza Z; 10/11/2005
              ' FROM tol_detfactura_0'||EC_dig||' det, sch_codigos cod '||
              ' WHERE det.cod_thor = cod.cod_param '||
              ' AND cod.cod_tipo = ''CODTHOR'' '||
              ' AND det.num_clie = '||EN_cod_cliente||
			  ' AND det.num_abon = '||EN_num_abonado||
              ' AND det.cod_ciclfact = '||EN_cod_ciclfact||
			  ' AND det.cod_plan = '''||EV_cod_plantarif|| '''' ;--||--RA-200511100082: German Espinoza Z; 10/11/2005

			  --RA-200511100082: German Espinoza Z; 10/11/2005
			  --' GROUP BY det.cod_thor, cod.gls_param; -'|| SQLERRM,1,CN_largoquery);
			  IF GV_ParamOpero=1 THEN
			  	 sSql:=sSql || ' AND det.cod_llam  LIKE ''AIR%''';
			  END IF;

			  sSql:=sSql || ' GROUP BY det.cod_thor, cod.gls_param; -'|| SQLERRM;
			  sSql:=SUBSTR(sSql,1,CN_largoquery);
			  --FIN/RA-200511100082: German Espinoza Z; 10/11/2005

        sSql2:='SELECT cod.gls_param AS glosa,det.cod_thor AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
              ' FROM tol_detfactura_0'||EC_dig||' det, sch_codigos cod '||
              ' WHERE det.cod_thor = cod.cod_param '||
              ' AND cod.cod_tipo = ''CODTHOR'' '||
              ' AND det.num_clie =:1 '||
			  ' AND det.num_abon =:2 '||
              ' AND det.cod_ciclfact = :3'||
			  ' AND det.cod_plan = :4';--||--RA-200511100082: German Espinoza Z; 10/11/2005

			  --RA-200511100082: German Espinoza Z; 10/11/2005
			  --' GROUP BY det.cod_thor, cod.gls_param ';

			  IF GV_ParamOpero=1 THEN
			  	 sSql2:=sSql2 || ' AND det.cod_llam  LIKE ''AIR%''';
			  END IF;

			  sSql2:=sSql2 || ' GROUP BY det.cod_thor, cod.gls_param ';
			  --FIN/RA-200511100082: German Espinoza Z; 10/11/2005


        BEGIN
           OPEN SC_min_hor FOR sSql2 USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			 NULL;
		WHEN TOO_MANY_ROWS THEN
			 NULL;
		END;

		--RA-200511100082: German Espinoza Z; 10/11/2005
		--sSql:=SUBSTR('SELECT cod.gls_param AS glosa,det.cod_tdia AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
		sSql:='SELECT cod.gls_param AS glosa,det.cod_tdia AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
		--RA-200511100082: German Espinoza Z; 10/11/2005
              ' FROM tol_detfactura_0'||EC_dig||' det '||', sch_codigos cod '||
			  ' WHERE det.cod_tdia = cod.cod_param '||
              ' AND cod.cod_tipo = ''CODTDIA'' '||
              ' AND det.num_clie ='||EN_cod_cliente||
			  ' AND det.num_abon = '||EN_num_abonado||
			  ' AND det.cod_ciclfact='''||EN_cod_ciclfact||''''||
			  ' AND det.cod_plan='''||EV_cod_plantarif||'''';--||--RA-200511100082: German Espinoza Z; 10/11/2005

			  --RA-200511100082: German Espinoza Z; 10/11/2005
			  --' GROUP BY det.cod_tdia, cod.gls_param; - '||SQLERRM,1,CN_largoquery);
			  IF GV_ParamOpero=1 THEN
			  	 sSql:=sSql || ' AND det.cod_llam  LIKE ''AIR%''';
			  END IF;

			  sSql:=sSql || ' GROUP BY det.cod_tdia, cod.gls_param; -'|| SQLERRM;
			  sSql:=SUBSTR(sSql,1,CN_largoquery);
			  --FIN/RA-200511100082: German Espinoza Z; 10/11/2005

		sSql2:='SELECT cod.gls_param AS glosa,det.cod_tdia AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
              ' FROM tol_detfactura_0'||EC_dig||' det '||', sch_codigos cod '||
			  ' WHERE det.cod_tdia = cod.cod_param '||
              ' AND cod.cod_tipo = ''CODTDIA'' '||
              ' AND det.num_clie = :1 '||
			  ' AND det.num_abon = :2 '||
			  ' AND det.cod_ciclfact = :3'||
			  ' AND det.cod_plan= :4 ';--||--RA-200511100082: German Espinoza Z; 10/11/2005

			  --RA-200511100082: German Espinoza Z; 10/11/2005

			  --' GROUP BY det.cod_tdia, cod.gls_param';
			  IF GV_ParamOpero=1 THEN
			  	 sSql2:=sSql2 || ' AND det.cod_llam  LIKE ''AIR%''';
			  END IF;

			  sSql2:=sSql2 || ' GROUP BY det.cod_tdia, cod.gls_param';
			  --FIN/RA-200511100082: German Espinoza Z; 10/11/2005

     	BEGIN
           OPEN SC_min_tip_dia FOR sSql2 USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
		     NULL;
		WHEN TOO_MANY_ROWS THEN
			 NULL;
	    WHEN OTHERS THEN
			 RAISE error_ejecucion;
		END;

EXCEPTION
WHEN error_ejecucion THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion: GA_MINUTOS_POR_PERIODO_PR('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||','||EC_dig||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MINUTOS_POR_PERIODO_PR', sSql, SQLCODE, V_des_error );

WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others: GA_MINUTOS_POR_PERIODO_PR('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||','||EC_dig||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MINUTOS_POR_PERIODO_PR', sSql, SQLCODE, V_des_error );
END GA_MINUTOS_POR_PERIODO_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MINUTOS_POR_PLAN_PR (EV_cod_plantarif   IN          ga_abocel.cod_plantarif%TYPE,
								   SN_plan_min_lib    OUT NOCOPY  NUMBER,
                				   SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                				   SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                   SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MINUTOS_POR_PLAN_PR"
      Lenguaje="PL/SQL"
      Fecha="16-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta minutos libres por plan </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_plantarif" Tipo="NUMERICO">Codigo del Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SN_plan_min_lib"   Tipo="NUMERICO">Minutos libres por plan</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO">Evento Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;

    BEGIN
        SN_cod_retorno:='0';
        SN_num_evento:=0;
		SN_plan_min_lib:=0;

		sSql:='SELECT a.cnt_bolsa FROM tol_bolsa_td a, tol_bolsa_plan_td b '||
		      ' WHERE b.cod_bolsa=a.cod_bolsa  AND b.cod_plan='''||EV_cod_plantarif||'''';

       	SELECT a.cnt_bolsa INTO SN_plan_min_lib
          FROM tol_bolsa_td a, tol_bolsa_plan_td b
         WHERE b.cod_bolsa=a.cod_bolsa
          AND b.cod_plan=EV_cod_plantarif;

EXCEPTION
WHEN NO_DATA_FOUND THEN
	 	        NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others: GA_MINUTOS_POR_PLAN_PR('||EV_cod_plantarif||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MINUTOS_POR_PLAN_PR', sSql, SQLCODE, V_des_error );
END GA_MINUTOS_POR_PLAN_PR;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MINUTOS_USADOS_PR (EN_cod_cliente     IN          ga_abocel.cod_cliente%TYPE,
		  					 	 EN_num_abonado     IN		    ga_abocel.num_abonado%TYPE,
								 EN_cod_ciclfact    IN		    fa_ciclfact.cod_ciclfact%TYPE,
								 EV_cod_plantarif   IN          ga_abocel.cod_plantarif%TYPE,
								 EC_dig			  	IN		    CHAR,
                				 SN_usado	  	    OUT NOCOPY  NUMBER,
								 SN_nousado         OUT NOCOPY  NUMBER, --RA-200511100082: German Espinoza Z; 10/11/2005
              				     SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                				 SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                 SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MINUTOS_USADOS_PR"
      Lenguaje="PL/SQL"
      Fecha="16-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta minutos utilizados </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Codigo del ciclo de facturacion actual</param>
            <param nom="EV_cod_plantarif" Tipo="CARACTER">Plan tarifario</param>
            <param nom="EC_dig" Tipo="CARACTER">Plan tarifario</param>
         </Entrada>
         <Salida>
            <param nom="SN_usado"   Tipo="NUMERICO">Minutos utilizados</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO">Evento Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        sSql2                ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;

    BEGIN
        SN_cod_retorno:='0';
        SN_num_evento:=0;
		SN_usado:=0;

   		--Generar query a ejecutar....

		--RA-200511100082: German Espinoza Z; 10/11/2005
		IF GV_ParamOpero=1 THEN
		  sSql:=SUBSTR('SELECT NVL(SUM(det.dur_real)/60,0) AS cantidad'||
		        ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
			  ' WHERE det.NUM_CLIE ='||EN_cod_cliente||
			  ' AND det.NUM_ABON='||EN_num_abonado||
              ' AND det.COD_CICLFACT='''||EN_cod_ciclfact||''''||
			  ' AND det.COD_PLAN='''||EV_cod_plantarif||'''; - '||SQLERRM,1,CN_largoquery);

		  sSql2:='SELECT NVL(SUM(det.dur_real)/60,0) AS v_durReal ,'||
		       ' NVL(SUM(det.mto_real),0) AS v_mtoReal '||
		       ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
		       ' WHERE det.NUM_CLIE = :1 '||
		       ' AND det.NUM_ABON = :2 '||
                       ' AND det.COD_CICLFACT = :3 '||
		       ' AND det.COD_PLAN = :4 ' ||
		       ' AND det.cod_llam  LIKE ''AIR%''';

		   EXECUTE IMMEDIATE sSql2
		                INTO SN_nousado,
		                     SN_usado
		   USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif;

		ELSE
		--FIN/RA-200511100082: German Espinoza Z; 10/11/2005

        	sSql:=SUBSTR('SELECT NVL(SUM(det.dur_dcto)/60,0) AS cantidad'||
		      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
			  ' WHERE det.NUM_CLIE ='||EN_cod_cliente||
			  ' AND det.NUM_ABON='||EN_num_abonado||
              ' AND det.COD_CICLFACT='''||EN_cod_ciclfact||''''||
			  ' AND det.COD_PLAN='''||EV_cod_plantarif||'''; - '||SQLERRM,1,CN_largoquery);

			sSql2:='SELECT NVL(SUM(det.dur_dcto)/60,0) AS cantidad'||
		      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
			  ' WHERE det.NUM_CLIE = :1 '||
			  ' AND det.NUM_ABON = :2 '||
              ' AND det.COD_CICLFACT = :3 '||
			  ' AND det.COD_PLAN = :4 ';

			EXECUTE IMMEDIATE sSql2 INTO SN_usado
		   	USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif;

		--RA-200511100082: German Espinoza Z; 10/11/2005

			SN_nousado:=0;
		END IF;
		--FIN/RA-200511100082: German Espinoza Z; 10/11/2005

EXCEPTION
WHEN NO_DATA_FOUND THEN
	 	        NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others: GA_MINUTOS_USADOS_PR('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||','||EV_cod_plantarif||','||EC_dig||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MINUTOS_USADOS_PR', sSql, SQLCODE, V_des_error );
END GA_MINUTOS_USADOS_PR;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MINUTOS_INTRARED_PR (EN_cod_cliente     IN          ga_abocel.cod_cliente%TYPE,
		  					 	 EN_num_abonado     IN		    ga_abocel.num_abonado%TYPE,
								 EN_cod_ciclfact    IN		    fa_ciclfact.cod_ciclfact%TYPE,
								 EV_cod_plantarif   IN          ga_abocel.cod_plantarif%TYPE,
								 EC_dig			  	IN		    CHAR,
                				 SN_Bs2bs	  	    OUT NOCOPY  NUMBER,
              				     SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                				 SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                 SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MINUTOS_INTRARED_PR"
      Lenguaje="PL/SQL"
      Fecha="16-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta minutos consumidos intrared</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Codigo del ciclo de facturacion actual</param>
            <param nom="EV_cod_plantarif" Tipo="CARACTER">Plan tarifario</param>
            <param nom="EC_dig" Tipo="CARACTER">Plan tarifario</param>
         </Entrada>
         <Salida>
            <param nom="SN_Bs2bs"   Tipo="NUMERICO">Minutos intrared utilizados</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO">Evento Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        sSql2                ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;

		v_codllam  			 varchar2(5):=''; --RA-200511100082: German Espinoza Z; 10/11/2005

    BEGIN
        SN_cod_retorno:='0';
        SN_num_evento:=0;
		SN_Bs2bs:=0;

		--Generar query a ejecutar....

		--RA-200511100082: German Espinoza Z; 10/11/2005
		IF GV_ParamOpero=1 THEN

		   	  sSql:=' SELECT        val_parametro';
   	          sSql:=sSql || ' FROM  ged_parametros ';
   	          sSql:=sSql || ' WHERE nom_parametro = :v1';
   	          sSql:=sSql || ' AND   cod_modulo    = :v2';
   	          sSql:=sSql || ' AND   cod_producto  = :v3';

			  EXECUTE IMMEDIATE sSql INTO v_codllam
			  USING 'COD_LLAM','TA','2';

   	       	  sSql:=SUBSTR('SELECT NVL(SUM(det.dur_real)/60,0) AS cantidad'||
		      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
			  ' WHERE det.NUM_CLIE ='||EN_cod_cliente||
			  ' AND det.NUM_ABON='||EN_num_abonado||
              ' AND det.COD_CICLFACT='''||EN_cod_ciclfact||''''||
			  ' AND det.cod_operA=det.cod_operB '||
			  ' AND det.COD_PLAN='''||EV_cod_plantarif||
			  ' AND det.cod_llam = '''|| v_codllam || '''; - '||SQLERRM,1,CN_largoquery);

			  sSql2:='SELECT NVL(SUM(det.dur_real)/60,0) AS cantidad '||
		      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
			  ' WHERE det.NUM_CLIE = :1 '||
			  ' AND det.NUM_ABON = :2 '||
              ' AND det.COD_CICLFACT = :3 '||
			  ' AND det.cod_operA  = det.cod_operB '||
			  ' AND det.COD_PLAN = :4 '||
    		  ' AND det.cod_llam = :5 ';


			  EXECUTE IMMEDIATE sSql2 INTO SN_Bs2bs
		   	  USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif,v_codllam;

        ELSE
		--FIN/RA-200511100082: German Espinoza Z; 10/11/2005

			sSql:=SUBSTR('SELECT NVL(SUM(det.dur_dcto)/60,0) AS cantidad'||
			      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
				  ' WHERE det.NUM_CLIE ='||EN_cod_cliente||
				  ' AND det.NUM_ABON='||EN_num_abonado||
	              ' AND det.COD_CICLFACT='''||EN_cod_ciclfact||''''||
				  ' AND det.cod_operA=det.cod_operB '||
				  ' AND det.COD_PLAN='''||EV_cod_plantarif||'''; - '||SQLERRM,1,CN_largoquery);

			sSql2:='SELECT NVL(SUM(det.dur_dcto)/60,0) AS cantidad '||
			      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
				  ' WHERE det.NUM_CLIE = :1 '||
				  ' AND det.NUM_ABON = :2 '||
	              ' AND det.COD_CICLFACT = :3 '||
				  ' AND det.cod_operA  = det.cod_operB '||
				  ' AND det.COD_PLAN = :4 ';

			EXECUTE IMMEDIATE sSql2 INTO SN_Bs2bs
			   USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif;

		--RA-200511100082: German Espinoza Z; 10/11/2005
		END IF;
		--RFA-200511100082: German Espinoza Z; 10/11/2005

EXCEPTION
WHEN NO_DATA_FOUND THEN
	 	        NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others: GA_MINUTOS_INTRARED_PR('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||','||EV_cod_plantarif||','||EC_dig||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MINUTOS_INTRARED_PR', sSql, SQLCODE, V_des_error );
END GA_MINUTOS_INTRARED_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_FECHA_ACTUALIZA_PR (EN_cod_cliente     IN          ga_abocel.cod_cliente%TYPE,
		  					 	  EN_num_abonado     IN		     ga_abocel.num_abonado%TYPE,
								  EN_cod_ciclfact    IN		     fa_ciclfact.cod_ciclfact%TYPE,
								  EC_dig			 IN		     CHAR,
                				  SD_fec_corte	     OUT NOCOPY  DATE,
              				      SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                				  SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_FECHA_ACTUALIZA_PR"
      Lenguaje="PL/SQL"
      Fecha="16-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio obtiene la fecha en que se actualizó el tráfico consultado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Codigo del ciclo de facturacion actual</param>
            <param nom="EC_dig" Tipo="CARACTER">Plan tarifario</param>
         </Entrada>
         <Salida>
            <param nom="SD_fec_corte"   Tipo="FECHA">Fecha de actualizacion</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO">Evento Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        sSql2                ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;

    BEGIN
        SN_cod_retorno:='0';
        SN_num_evento:=0;
		SD_fec_corte:=NULL;

   		--Generar query a ejecutar....
        sSql:=SUBSTR('SELECT MAX(TO_DATE(date_start_charg||time_start_charg,''yyyymmddhh24miss'')) AS fecha'||
		      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
			  ' WHERE det.NUM_CLIE = '||EN_cod_cliente||
			  ' AND det.NUM_ABON ='||EN_num_abonado||
              ' AND det.COD_CICLFACT='''||EN_cod_ciclfact||'''; - '||SQLERRM,1,CN_largoquery);

        sSql2:='SELECT MAX(TO_DATE(date_start_charg||time_start_charg,''yyyymmddhh24miss'')) AS fecha'||
		      ' FROM TOL_DETFACTURA_0'||EC_dig||' det '||
			  ' WHERE det.NUM_CLIE = :1 '||
			  ' AND det.NUM_ABON = :2 '||
              ' AND det.COD_CICLFACT = :3 ';

		EXECUTE IMMEDIATE sSql2 INTO SD_fec_corte
		   USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact;


EXCEPTION
WHEN NO_DATA_FOUND THEN
	 	        NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others: GA_FECHA_ACTUALIZA_PR('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||','||EC_dig||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_FECHA_ACTUALIZA_PR', sSql, SQLCODE, V_des_error );
END GA_FECHA_ACTUALIZA_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_INDICA_PLANESP_PR (EN_num_abonado     IN 			ga_abocel.num_abonado%TYPE,
		  						 EV_cod_plantarif   IN          ga_abocel.cod_plantarif%TYPE,
								 SN_indica		    OUT NOCOPY  NUMBER,
              				     SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                				 SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                 SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_INDICA_PLANESP_PR"
      Lenguaje="PL/SQL"
      Fecha="16-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio obtiene indicador si el plan es plan especial o no</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_plantarif" Tipo="CARACTER">Plan tarifario</param>
         </Entrada>
         <Salida>
            <param nom="SN_indica"   Tipo="NUMERICO">Indicador de plan especial</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO">Evento Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

  --German Espinoza Z; 08/11/2005
  /*
   CURSOR Ssplan_CU (EV_cod_plantarif IN GAD_SERVSUP_PLAN.cod_plantarif%TYPE,
   		  			 EV_cod_servicio  IN GAD_SERVSUP_PLAN.cod_servicio%TYPE,
					 EV_tip_relacion  IN GAD_SERVSUP_PLAN.tip_relacion%TYPE ) IS
   	 SELECT ssplan.cod_producto
       FROM GAD_SERVSUP_PLAN  ssplan
       WHERE ssplan.cod_producto = 1
       AND ssplan.cod_plantarif = EV_cod_plantarif
	   AND ssplan.cod_servicio = EV_cod_servicio
       AND ssplan.fec_desde <= SYSDATE
       AND ssplan.fec_hasta >= SYSDATE
	   AND ssplan.tip_relacion = EV_tip_relacion ;


   CURSOR Parametros_CU IS
     SELECT param.VAL_PARAMETRO AS val_param
	   FROM GED_PARAMETROS param
	  WHERE param.nom_parametro IN ('TIP_RELACION2' , 'TIP_RELACION3')
	    AND param.cod_modulo = CV_cod_modulo
        AND param.cod_producto = 1;


   CURSOR Ssabo_CU (EN_num_abonado IN GA_ABOCEL.num_abonado%TYPE) IS
   	 SELECT ssabo.cod_servicio AS cod_serv
       FROM GA_SERVSUPLABO  ssabo
       WHERE ssabo.num_abonado = EN_num_abonado
       AND ssabo.fec_bajabd IS NULL
	   AND ssabo.cod_producto=1;*/

--German Espinoza Z; 08/11/2005

		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;
		LB_existe			 BOOLEAN;
		LN_CantSS			 NUMBER(5);--German Espinoza Z; 08/11/2005

BEGIN
       SN_cod_retorno:='0';
       SN_num_evento:=0;
	   SN_indica:=0;

	/*
	   sSql:=SUBSTR('SELECT 1 '||
       		' FROM ga_servsuplabo ssabo, gad_servsup_plan ssplan, ged_parametros param '||
            ' WHERE  ssplan.tip_relacion = param.val_parametro'||
            ' AND ssabo.cod_producto = ssplan.cod_producto'||
            ' AND ssabo.cod_servicio = ssplan.cod_servicio'||
            ' AND ssabo.num_abonado = '||EN_num_abonado||
            ' AND ssabo.fec_bajabd IS NULL' ||
            ' AND ssplan.cod_producto = 1 '||
            ' AND ssplan.cod_plantarif='''||EV_cod_plantarif||''''||
            ' AND param.nom_parametro IN (''TIP_RELACION2'' , ''TIP_RELACION3'')'||
            ' AND param.cod_modulo ='''||CV_cod_modulo||''''||
            ' AND param.cod_producto = 1'||
            ' AND ssplan.fec_desde <= SYSDATE'||
            ' AND ssplan.fec_hasta >= SYSDATE',1,CN_largoquery);


	   SELECT 1 INTO SN_indica
       FROM ga_servsuplabo ssabo, gad_servsup_plan ssplan, ged_parametros param
       WHERE ssplan.tip_relacion = param.val_parametro
       AND ssabo.cod_producto = ssplan.cod_producto
       AND ssabo.cod_servicio = ssplan.cod_servicio
       AND ssabo.num_abonado = EN_num_abonado
       AND ssabo.fec_bajabd IS NULL
       AND ssplan.cod_producto = 1
       AND ssplan.cod_plantarif = EV_cod_plantarif
       AND param.nom_parametro IN ('TIP_RELACION2' , 'TIP_RELACION3')
       AND param.cod_modulo = CV_cod_modulo
       AND param.cod_producto = 1
       AND ssplan.fec_desde <= SYSDATE
       AND ssplan.fec_hasta >= SYSDATE;

	  */
	  LB_existe:=FALSE;

	  --German Espinoza Z; 08/11/2005

	  /*
	  sSql:=' SELECT ssabo.cod_servicio AS cod_serv '||
            ' FROM GA_SERVSUPLABO  ssabo '||
            ' WHERE ssabo.num_abonado ='|| EN_num_abonado||
            ' AND ssabo.fec_bajabd IS NULL' ||
	        ' AND ssabo.cod_producto=1';

	  FOR C1 IN Ssabo_CU(EN_num_abonado) LOOP
	  	  FOR C2 IN Parametros_CU LOOP
		  	  FOR C3 IN Ssplan_CU(EV_cod_plantarif,C1.cod_serv,C2.val_param) LOOP
			      LB_existe:=TRUE;
				  EXIT;
			  END LOOP;
			  IF LB_existe THEN
			  	 EXIT;
			  END IF;
		  END LOOP;
		  IF LB_existe THEN
		  	 EXIT;
		  END IF;
	  END LOOP;
	  */

	  sSql:=' select count(1)';
	  sSql:=sSql ||' from  ga_abocel a,gad_servsup_plan b ';
	  sSql:=sSql ||' where a.num_Abonado='|| EN_num_abonado;
	  sSql:=sSql ||' and   b.cod_plantarif=a.cod_plantarif';
	  sSql:=sSql ||' and   b.tip_relacion=''5'' ';
	  sSql:=sSql ||' and   b.cod_servicio='''|| EV_cod_plantarif ||''' ';
	  sSql:=sSql ||' AND   b.fec_desde <= SYSDATE';
      sSql:=sSql ||' AND   b.fec_hasta >= SYSDATE';

	  EXECUTE IMMEDIATE sSql
	  INTO LN_CantSS;
	  --German Espinoza Z; 08/11/2005

	  IF LN_CantSS>0 THEN
   	     SN_indica:=1;
	  END IF;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
	 		 	NULL;
	WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others: GA_INDICA_PLANESP_PR('||EV_cod_plantarif||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_INDICA_PLANESP_PR', sSql, SQLCODE, V_des_error );
END GA_INDICA_PLANESP_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_MINUTOS_PLANESP_PR (EN_cod_cliente     IN          ga_abocel.cod_cliente%TYPE,
		  					 	  EN_num_abonado     IN		     ga_abocel.num_abonado%TYPE,
								  EN_cod_ciclfact    IN		     fa_ciclfact.cod_ciclfact%TYPE,
								  EV_cod_plantarif   IN          ga_abocel.cod_plantarif%TYPE,
								  EC_dig			 IN		     CHAR,
                				  SC_min_planesp	 OUT NOCOPY  refcursor,
              				      SN_cod_retorno     OUT NOCOPY  ge_errores_pg.CodError,
                				  SV_mens_retorno    OUT NOCOPY  ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY  ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_MINUTOS_PLANESP_PR"
      Lenguaje="PL/SQL"
      Fecha="16-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio obtiene minutos por horario para el plan especial</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Codigo del Cliente</param>
            <param nom="EN_num_abonado" Tipo="NUMERICO">Numero del abonado</param>
            <param nom="EN_cod_ciclfact" Tipo="NUMERICO">Codigo del ciclo de facturacion actual</param>
            <param nom="EV_cod_plantarif" Tipo="CARACTER">Plan tarifario</param>
            <param nom="EC_dig" Tipo="CARACTER">Plan tarifario</param>
         </Entrada>
         <Salida>
            <param nom="SC_min_planesp"   Tipo="CURSOR">Datos de minutos del plan especial</param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO">Evento Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
        sSql2                ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;

    BEGIN
        SN_cod_retorno:='0';
        SN_num_evento:=0;

   		--Generar query a ejecutar....
		--RA-200511100082: German Espinoza Z; 10/11/2005
        --sSql:=SUBSTR('SELECT cod.gls_param AS glosa,det.cod_thor AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
		sSql:='SELECT cod.gls_param AS glosa,det.cod_thor AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
              ' FROM tol_detfactura_0'||EC_dig||' det, sch_codigos cod '||
              ' WHERE det.cod_thor = cod.cod_param '||
              ' AND cod.cod_tipo = ''CODTHOR'' '||
              ' AND det.num_clie = '||EN_cod_cliente||
			  ' AND det.num_abon = '||EN_num_abonado||
              ' AND det.cod_ciclfact = '||EN_cod_ciclfact||
			  ' AND det.cod_plan = '''||EV_cod_plantarif||'''';

			  --RA-200511100082: German Espinoza Z; 10/11/2005
			  --' GROUP BY det.cod_thor, cod.gls_param; - '||SQLERRM,1,CN_largoquery);
			  IF GV_ParamOpero=1 THEN
			  	 sSql:=sSql || ' AND det.cod_llam  LIKE ''AIR%''';
			  END IF;

              sSql:=sSql || ' GROUP BY det.cod_thor, cod.gls_param; - '||SQLERRM;
			  sSql:=SUBSTR(sSql ,1,CN_largoquery);
			  --FIN/RA-200511100082: German Espinoza Z; 10/11/2005

        sSql2:='SELECT cod.gls_param AS glosa,det.cod_thor AS horario, NVL(SUM(det.dur_fact)/60,0) AS cantidad '||
              ' FROM tol_detfactura_0'||EC_dig||' det, sch_codigos cod '||
              ' WHERE det.cod_thor = cod.cod_param '||
              ' AND cod.cod_tipo = ''CODTHOR'' '||
              ' AND det.num_clie =:1 '||
			  ' AND det.num_abon =:2 '||
              ' AND det.cod_ciclfact = :3'||
			  ' AND det.cod_plan = :4'||
			  --Inicio RA-200511100082: Marcelo Miranda W.; 11/11/2005
			  ' AND det.cod_llam <> ''AIRPP''';
			  --Fin RA-200511100082: Marcelo Miranda W.; 11/11/2005
			  --RA-200511100082: German Espinoza Z; 10/11/2005
			  --' GROUP BY det.cod_thor, cod.gls_param ';

			  IF GV_ParamOpero=1 THEN
			  	 sSql2:=sSql2 || ' AND det.cod_llam  LIKE ''AIR%''';
			  END IF;

			  sSql2:=sSql2 || ' GROUP BY det.cod_thor, cod.gls_param ';
			  --FIN/RA-200511100082: German Espinoza Z; 10/11/2005


        OPEN SC_min_planesp FOR sSql2
		     USING EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif;


EXCEPTION
WHEN NO_DATA_FOUND THEN
	 	        NULL;
WHEN TOO_MANY_ROWS THEN
	 			NULL;
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('others: GA_MINUTOS_PLANESP_PR('||EN_cod_cliente||','||EN_num_abonado||','||EN_cod_ciclfact||','||EV_cod_plantarif||','||EC_dig||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_MINUTOS_PLANESP_PR', sSql, SQLCODE, V_des_error );
END GA_MINUTOS_PLANESP_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_LDI_PR (EN_num_celular IN           ga_abocel.num_celular%TYPE,
	                       	  SN_unidades        OUT NOCOPY   NUMBER,
				  			  SD_datem   	     OUT NOCOPY   DATE,
				  			  SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                              SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                              SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DET_LLAMADA_LDI_PR"
      Lenguaje="PL/SQL"
      Fecha="10-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta minutos LDI consumidos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom=" SN_unidades" Tipo="NUMERICO">Unidades consultadas<param>
            <param nom="SD_datem" Tipo="FECHA"> Fecha xxx<param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS


        error_ejecucion      EXCEPTION;
		V_des_error		 	 ge_errores_pg.DesEvent;
        sSql             	 ge_errores_pg.vQuery;
        sSql2             	 ge_errores_pg.vQuery;
		SV_deserror 		 ge_errores_pg.DesEvent;
	  	LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_num_min          ga_abocel.num_min%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec	    ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
		SV_val_parametro    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		LV_ejec_rest	    VARCHAR2(500);
		LC_dig		        CHAR(1);
		LN_cod_ciclfact	    fa_ciclfact.cod_ciclfact%TYPE;
	    LV_cod_tiplan       ged_codigos.cod_valor%TYPE;
		LV_des_tiplan       ged_codigos.des_valor%TYPE;

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

		--Inicializar variables....
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SN_unidades:=0;
		SD_datem:=NULL;
		LC_dig:='0';
		LN_cod_ciclfact:=0;
		LV_cod_tiplan:=NULL;
		LV_des_tiplan:=NULL;


       --Validar si numero celular cumple con el largo definido...
		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||'); - '||SQLERRM,1,CN_largoquery);
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||') - '||SQLERRM,1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||'); - '||SQLERRM,1,CN_largoquery);
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 then
		   SN_cod_retorno := '314';
		   sSql:=LV_des_cadena;
		   RAISE error_ejecucion;
		END IF;

   		-- Ejecutar procedimiento que obtiene datos del abonado, entre ellos el cod_cliente
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); - '||SQLERRM,1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno <> 0 THEN
           SN_cod_retorno := '309';
    	   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
           SN_cod_retorno := '146';
    	   RAISE  error_ejecucion;
		END IF;

		--Inicio 30-06-2005 ---
		-- Ejecutar procedimiento que obtiene codigo y descripcion del tipo de producto asociado al plan del abonado....
		--Para validar si es postpago......
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR('||SV_cod_plantarif||');',1,CN_largoquery);
		GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR(SV_cod_plantarif,LV_cod_tiplan,
			   LV_des_tiplan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN  --Implica que hay error
		   RAISE  error_ejecucion;
		END IF;
		IF TRIM(LV_cod_tiplan)<>CV_prod_postpago THEN
		   SN_cod_retorno := '314';
		   RAISE error_ejecucion;
		END IF;
		--Fin 30-06-2005 ---

		--Obtiene módulo 10 del número del cliente para accesar la tabla que corresponde...
		LC_dig:=MOD(SN_cod_cliente,10);

		--Obtiene cod_ciclfact del cliente....
		sSql:=SUBSTR('GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN('||SN_cod_ciclo||'); - '||SQLERRM,1,CN_largoquery);
		IF NOT GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN(SN_cod_ciclo,LN_cod_ciclfact,
		       SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO ) THEN
               SN_cod_retorno := '310';
		       RAISE error_ejecucion;
		END IF;

		--Generar query a ejecutar....
  		sSql:=SUBSTR('SELECT NVL((SUM(det.dur_fact)+SUM(det.dur_dcto))/60,0)'||
			 ' FROM TOL_DETFACTURA_0'||LC_dig||' det '||', sch_codigos cod '||
       		 ' WH-R-E det.num_clie='||SN_cod_cliente||
			 ' AND det.num_abon='||SN_num_abonado||
			 ' AND det.cod_ciclfact='''||LN_cod_ciclfact||''''||
			 ' AND det.cod_llam=cod.cod_param'||
			 ' AND cod.cod_tipo=''CODLLAM'''||
			 ' AND (cod.cod_param LIKE ''LDI%'' OR cod.cod_param LIKE ''LDM%''); - '||SQLERRM,1,CN_largoquery);

 		sSql2:='SELECT NVL((SUM(det.dur_fact)+SUM(det.dur_dcto))/60,0)'||
			 ' FROM TOL_DETFACTURA_0'||LC_dig||' det '||', sch_codigos cod '||
       		 ' WHERE det.num_clie=:1 '||
			 ' AND det.num_abon=:2 '||
			 ' AND det.cod_ciclfact=:3 '||
			 ' AND det.cod_llam=cod.cod_param'||
			 ' AND cod.cod_tipo=''CODLLAM'''||
			 ' AND (cod.cod_param LIKE ''LDI%'' OR cod.cod_param LIKE ''LDM%'')';

		--Obtener unidades consumidas de LDI.....
   		EXECUTE IMMEDIATE sSql2 INTO SN_unidades
				USING SN_cod_cliente,SN_num_abonado,LN_cod_ciclfact;

	    --Obtener fecha de ultima actualización....
		SD_datem:=NULL;
		sSql:=SUBSTR('GA_TRAFICO_PG.GA_FECHA_ACTUALIZA_PR ('||SN_cod_cliente||
			  ','||SN_num_abonado||','||LN_cod_ciclfact||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);
	    GA_TRAFICO_PG.GA_FECHA_ACTUALIZA_PR(SN_cod_cliente, SN_num_abonado,
		   LN_cod_ciclfact,LC_dig,SD_datem,SN_cod_retorno,SV_mens_retorno, SN_num_evento);

		IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
           SN_cod_retorno := '309';
    	   RAISE  error_ejecucion;
		END IF;

EXCEPTION
WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion: GA_DET_LLAMADA_LDI_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DET_LLAMADA_LDI_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('Others: GA_DET_LLAMADA_LDI_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DET_LLAMADA_LDI_PR', sSql, SQLCODE, V_des_error );
END GA_DET_LLAMADA_LDI_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_LLAMADA_FF_PR (EN_num_celular     IN           ga_abocel.num_celular%TYPE,
	                             SN_unidades   	    OUT NOCOPY   NUMBER,
				 			     SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                 SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                 SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DET_LLAMADA_FF_PR"
      Lenguaje="PL/SQL"
      Fecha="10-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta minutos friend and family consumidos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom=" SN_unidades" Tipo="NUMERICO">Unidades consultadas<param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

   CURSOR Existe_FF_CU (EN_num_abonado IN ga_abocel.num_abonado%TYPE,
  	   				    EN_cod_grupo_ff IN ged_parametros.nom_parametro%TYPE) IS

	SELECT aboss.num_abonado
	FROM ga_servsuplabo aboss,ga_grupos_servsup grpss
	WHERE aboss.num_abonado = EN_num_abonado
	  AND aboss.cod_producto = 1
	  AND grpss.cod_grupo = EN_cod_grupo_ff
	  AND grpss.cod_producto = aboss.cod_producto
	  AND grpss.cod_servicio = aboss.cod_servicio
	  AND aboss.fec_bajabd IS NULL;


        error_ejecucion      EXCEPTION;
		V_des_error		 	 ge_errores_pg.DesEvent;
        sSql             	 ge_errores_pg.vQuery;
        sSql2             	 ge_errores_pg.vQuery;
		SV_deserror 		 ge_errores_pg.DesEvent;
  	  	LN_num_transaccion 	ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno      ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena		ga_transacabo.des_cadena%TYPE;
		SN_num_abonado      ga_abocel.num_abonado%TYPE;
		SN_cod_cliente      ga_abocel.cod_cliente%TYPE;
		SN_cod_producto     ga_abocel.cod_producto%TYPE;
		SV_cod_situacion    ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif    ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif    ga_abocel.cod_plantarif%TYPE;
		SV_num_serie        ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	    ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia       ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei         ga_abocel.num_imei%TYPE;
		SV_num_min_mdn      ga_abocel.num_min_mdn%TYPE;
		SV_cod_password     ga_abocel.cod_password%TYPE;
		SV_num_min          ga_abocel.num_min%TYPE;
		SV_tip_terminal     ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex     ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec	    ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado     VARCHAR2(10);
		SN_cod_cuenta	    ga_abocel.cod_cuenta%TYPE;
		LV_val_parametro    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		LV_ejec_rest	    VARCHAR2(500);
		LB_existe_ff	    BOOLEAN;
		LC_dig		    	CHAR(1);
		LN_cod_ciclfact     fa_ciclfact.cod_ciclfact%TYPE;
	    LV_cod_tiplan       ged_codigos.cod_valor%TYPE;
		LV_des_tiplan       ged_codigos.des_valor%TYPE;

    BEGIN
        SN_cod_retorno := '0';
        SN_num_evento  := 0;

		--Inicializar variables....
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		SN_unidades:=0;
		LC_dig:='0';
		LN_cod_ciclfact:=0;
		LV_cod_tiplan:=NULL;
		LV_des_tiplan:=NULL;

       -- Validar si numero celular cumple con el largo definido...
		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||');- '||SQLERRM,1,CN_largoquery);
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||') - '||SQLERRM,1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql:='PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||');';
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 then
		   SN_cod_retorno := '314';
		   sSql:=LV_des_cadena;
		   RAISE error_ejecucion;
		END IF;

   		-- Ejecutar procedimiento que obtiene datos del abonado, entre ellos el cod_cliente
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); - '||SQLERRM,1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN  --Implica que hay error..
           SN_cod_retorno:= '309';
    	   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
           SN_cod_retorno:='146';
		   RAISE  error_ejecucion;
		END IF;

		--Inicio 30-06-2005 ---
		-- Ejecutar procedimiento que obtiene codigo y descripcion del tipo de producto asociado al plan del abonado....
		--Para validar si es postpago......
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR('||SV_cod_plantarif||');',1,CN_largoquery);
		GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR(SV_cod_plantarif,LV_cod_tiplan,
			   LV_des_tiplan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN  --Implica que hay error
		   RAISE  error_ejecucion;
		END IF;
		IF TRIM(LV_cod_tiplan)<>CV_prod_postpago THEN
		   SN_cod_retorno := '314';
		   RAISE error_ejecucion;
		END IF;
		--Fin 30-06-2005 ---


		--Obtiene valor desde ged_parametros para el grupo de friend and family....
	    LV_val_parametro:=NULL;
        sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_grupo_ff||','||CV_cod_modulo||','||CV_cod_producto_post||'); - '||SQLERRM,1,CN_largoquery);
		IF not ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_grupo_ff,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno:= '309';
			 RAISE  error_ejecucion;
		END IF;

		IF LV_val_parametro IS NULL THEN
           SN_cod_retorno:= '309';
		   RAISE  error_ejecucion;
		END IF;

	    --Verifica si abonado posee servicio de Friend and family activo....
		sSql:=SUBSTR('SELECT aboss.num_abonado FROM ga_servsuplabo aboss,ga_grupos_servsup grpss '||
			  '	WHERE aboss.num_abonado='||SN_num_abonado||' AND aboss.cod_producto=1'||
			  ' AND grpss.cod_grupo='''||LV_val_parametro||''' AND grpss.cod_producto=aboss.cod_producto'||
	  		  ' AND grpss.cod_servicio=aboss.cod_servicio AND aboss.fec_bajabd IS NULL; - '||SQLERRM,1,CN_largoquery);

		LB_existe_ff:=FALSE;
		FOR C_ver_ff IN Existe_FF_CU(SN_num_abonado,LV_val_parametro) LOOP
			IF C_ver_ff.num_abonado IS NOT NULL THEN
			   LB_existe_ff:=TRUE;
			END IF;
			EXIT;
		END LOOP;

		IF LB_existe_ff THEN
		  --Obtiene módulo 10 del codigo del cliente para accesar la tabla que corresponde
		  LC_dig:=MOD(SN_cod_cliente,10);
		  --Obtiene cod_ciclfact del cliente....
		  sSql:=SUBSTR('GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN('||SN_cod_ciclo||'); - '||SQLERRM,1,CN_largoquery);
	 	  IF NOT GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN(SN_cod_ciclo,LN_cod_ciclfact,
		       SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO ) THEN
          	       SN_cod_retorno := '310';
		       RAISE error_ejecucion;
		  END IF;


		  --Generar query a ejecutar....
  		  sSql:=SUBSTR('SELECT NVL((SUM(det.dur_fact)+SUM(det.dur_dcto))/60,0)'||
			 ' FROM TOL_DETFACTURA_0'||LC_dig||' det '||', sch_codigos cod '||
       		 ' WHERE det.num_clie='||SN_cod_cliente||
			 ' AND det.num_abon='||SN_num_abonado||
			 ' AND det.cod_ciclfact='''||LN_cod_ciclfact||''''||
			 ' AND det.cod_llam=cod.cod_param'||
			 ' AND cod.cod_tipo=''CODTDIR'''||
			 ' AND cod.cod_param LIKE ''%R%%''; - '||SQLERRM,1,CN_largoquery);

		  sSql2:= 'SELECT NVL((SUM(det.dur_fact)+SUM(det.dur_dcto))/60,0)'||
			 ' FROM TOL_DETFACTURA_0'||LC_dig||' det '||', sch_codigos cod '||
       		 ' WHERE det. num_clie=:1 '||
			 ' AND det.num_abon=:2 '||
			 ' AND det.cod_ciclfact=:3 '||
			 ' AND det.cod_tdir=cod.cod_param '||
			 ' AND cod.cod_tipo=''CODTDIR'' '||
			 ' AND cod.cod_param LIKE ''%R%''';

 		  EXECUTE IMMEDIATE sSql2 INTO SN_unidades
				USING SN_cod_cliente,SN_num_abonado,LN_cod_ciclfact;
	    ELSE
           SN_cod_retorno:= '311';
		   RAISE  error_ejecucion;
		END IF;

EXCEPTION
WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion: GA_DET_LLAMADA_FF_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DET_LLAMADA_FF_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('Others: GA_DET_LLAMADA_FF_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DET_LLAMADA_FF_PR', sSql, SQLCODE, V_des_error );
END GA_DET_LLAMADA_FF_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_DET_FRANJA_PR    (EN_num_celular  IN           ga_abocel.num_celular%TYPE,
                				SC_min_hor	    OUT NOCOPY   refcursor,
                				SC_min_tip_dia  OUT NOCOPY   refcursor,
                				SN_plan_min_lib OUT NOCOPY   NUMBER,
                				SN_usado	  	OUT NOCOPY   NUMBER,
                				SN_nousado	  	OUT NOCOPY   NUMBER,
                				SD_fec_corte	OUT NOCOPY   DATE,
                				SN_ind_planesp	OUT NOCOPY   NUMBER,
                				SN_valor		OUT NOCOPY   NUMBER,
                				SN_Bs2bs		OUT NOCOPY   NUMBER,
                				SC_min_planesp	OUT NOCOPY   refcursor,
                				SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
                				SV_mens_retorno OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_DET_FRANJA_PR"
      Lenguaje="PL/SQL"
      Fecha="11-05-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio Consulta minutos consumidos según franja horaria</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SC_min_hor" Tipo="Cursor">Variable refcursor que retorna la cantidad de minutos consumidos en cada franja horaria configurada en el sistema y que contenga llamadas. Las columnas del parámetro son glosa, horario y cantidad</param>
            <param nom="SC_min_tip_dia" Tipo="Cursor">Variable refcursor que retorna la cantidad de minutos consumidos en cada tipo de día configurado en el sistema y que contenga llamadas. Las columnas del parámetro son glosa, horario y cantidad</param>
            <param nom="SN_plan_min_lib" Tipo="Cursor">Cantidad de minutos libres del plan tarifario del abonado</param>
            <param nom="SN_usado" Tipo="NUMERICO">Cantidad de minutos libres consumidos</param>
            <param nom="SN_nousado" Tipo="NUMERICO">Cantidad de minutos libres no consumidos</param>
            <param nom="SD_fec_corte"  Tipo="Fecha">Fecha de la última llamada que es dato de las estadísticas retornadas por el servicio</param>
            <param nom="SN_ind_planesp" Tipo="NUMERICO">Indicador que dice si el abonado posee el plan "Mi Plan", 0 indica que no posee el plan, distinto de cero indica que lo tiene</param>
            <param nom="SN_valor" Tipo="NUMERICO">Minutos libres del plan "Mi Plan", si SN_ind_planesp es distinto de cero</param>
            <param nom="SN_Bs2bs"  Tipo="NUMERICO">Cantidad de mínutos libres consumidos intrared. Se asume como operadora origen y destino Movistar</param>
            <param nom="SC_min_planesp" Tipo="Cursor">Variable refcursor que retorna la cantidad de minutos consumidos en cada franja horaria configurada en el sistema, que contenga llamadas y correspondientes al plan definido en el parámetro PLAN_ESPECIAL1. Las columnas del parámetro son glosa, horario y cantidad</param>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

        error_ejecucion      EXCEPTION;
		V_des_error	         ge_errores_pg.DesEvent;
        sSql                 ge_errores_pg.vQuery;
		SV_deserror 	     ge_errores_pg.DesEvent;
  	  	LN_num_transaccion   ga_transacabo.num_transaccion%TYPE;
		LN_cod_retorno       ga_transacabo.cod_retorno%TYPE;
		LV_des_cadena	     ga_transacabo.des_cadena%TYPE;
		SN_num_abonado       ga_abocel.num_abonado%TYPE;
		SN_cod_cliente       ga_abocel.cod_cliente%TYPE;
		SN_cod_producto      ga_abocel.cod_producto%TYPE;
		SV_cod_situacion     ga_abocel.cod_situacion%TYPE;
 		SV_tip_plantarif     ga_abocel.tip_plantarif%TYPE;
		SV_cod_plantarif     ga_abocel.cod_plantarif%TYPE;
		SV_num_serie         ga_abocel.num_serie%TYPE;
		SN_cod_ciclo	     ga_abocel.cod_ciclo%TYPE;
		SV_tecnologia        ga_abocel.cod_tecnologia%TYPE;
		SV_num_imei          ga_abocel.num_imei%TYPE;
		SV_num_min_mdn       ga_abocel.num_min_mdn%TYPE;
		SV_cod_password      ga_abocel.cod_password%TYPE;
		SV_num_min           ga_abocel.num_min%TYPE;
		SV_tip_terminal      ga_abocel.tip_terminal%TYPE;
		SV_num_seriehex      ga_abocel.num_seriehex%TYPE;
		SV_num_seriemec	     ga_abocel.num_seriemec%TYPE;
		SV_tipo_abonado      VARCHAR2(10);
		SN_cod_cuenta	     ga_abocel.cod_cuenta%TYPE;
		LV_val_parametro     GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		LV_ejec_rest	     VARCHAR2(500);
		LC_dig		         CHAR(1);
		LN_cod_ciclfact      fa_ciclfact.cod_ciclfact%TYPE;
	    LV_cod_tiplan        ged_codigos.cod_valor%TYPE;
		LV_des_tiplan        ged_codigos.des_valor%TYPE;

    BEGIN

		 --RA-200511100082: German Espinoza Z; 10/11/2005
		 sSql:=' SELECT val_parametro ';
		 sSql:=sSql || ' FROM   ged_parametros ';
		 sSql:=sSql || ' WHERE  nom_parametro=:v1';
		 sSql:=sSql || ' AND    cod_modulo=:v2 ';
		 sSql:=sSql || ' AND    cod_producto=:v3';

		 EXECUTE IMMEDIATE sSql INTO GV_ParamOpero
		 USING 'OPER_EJEC_GA_TRAFICO','GA','1';
		 --FIN/RA-200511100082: German Espinoza Z; 10/11/2005

        SN_cod_retorno := '0';
        SN_num_evento  := 0;

		--Inicializar cursores....
		sSql:='OPEN SC_min_hor FOR SELECT NULL glosa, NULL horario, NULL cantidad '||
		      ' FROM DUAL WHERE ROWNUM = 0';
	    OPEN SC_min_hor FOR
   		SELECT NULL glosa, NULL horario, NULL cantidad
		FROM DUAL
        WHERE ROWNUM = 0;

		sSql:='OPEN SC_min_tip_dia FOR SELECT NULL glosa, NULL horario, NULL cantidad '||
		      ' FROM DUAL WHERE ROWNUM = 0';
	    OPEN SC_min_tip_dia FOR
   		SELECT NULL glosa, NULL horario, NULL cantidad
		FROM DUAL
        WHERE ROWNUM = 0;


		sSql:='OPEN SC_min_planesp FOR SELECT NULL glosa, NULL horario, NULL cantidad '||
   	          ' FROM DUAL WHERE ROWNUM = 0';
   	    OPEN SC_min_planesp FOR
   		SELECT NULL glosa, NULL horario, NULL cantidad
   		FROM DUAL
       	WHERE ROWNUM = 0;

		--Inicializar variables....
 	    SN_num_abonado:=NULL;
		SN_cod_cliente:=NULL;
		SN_cod_producto:=NULL;
		SV_cod_situacion:=NULL;
 		SV_tip_plantarif:=NULL;
		SV_cod_plantarif:=NULL;
		SV_num_serie:=NULL;
		SN_cod_ciclo:=NULL;
		SV_tecnologia:=NULL;
		SV_num_imei:=NULL;
		SV_num_min_mdn:=NULL;
		SV_cod_password:=NULL;
		SV_num_min:=NULL;
		SV_tip_terminal:=NULL;
		SV_num_seriehex:=NULL;
		SV_num_seriemec:=NULL;
		SV_tipo_abonado:=NULL;
		SN_cod_cuenta:=NULL;
		LC_dig:='0';
		LN_cod_ciclfact:=0;
		LV_cod_tiplan:=NULL;
		LV_des_tiplan:=NULL;

       -- Validar si numero celular cumple con el largo definido...
		sSql:=SUBSTR('ge_validaciones_pg.ge_valida_num_celular_fn('||EN_num_celular||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||'); - '||SQLERRM,1,CN_largoquery);
        IF NOT ge_validaciones_pg.ge_valida_num_celular_fn(EN_num_celular,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
	       SN_cod_retorno := '303';
           RAISE  error_ejecucion;
        END IF;

		--Validar que suscriptor exista.....
		sSql:=SUBSTR('GA_CONS_PG.ga_valida_existeabonado_fn('||EN_num_celular||') - '||SQLERRM,1,CN_largoquery);
		IF NOT GA_CONS_PG.ga_valida_existabonado_fn(EN_num_celular,SN_num_abonado,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO,'SI') THEN
           RAISE  error_ejecucion;
        END IF;

	    --Validar restricción-
		LV_ejec_rest:=EN_num_celular||'|';
		sSql:='SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL';
		SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_num_transaccion FROM DUAL;
		sSql:=SUBSTR('PV_PR_EJECUTA_RESTRICCION('||LN_num_transaccion||','||CV_cod_modulo||',1,'||
		       CV_actuacion||',''EXECUTE'','||LV_ejec_rest||');- '||SQLERRM,1,CN_largoquery);
		PV_PR_EJECUTA_RESTRICCION(LN_num_transaccion,CV_cod_modulo,1,CV_actuacion,'EXECUTE',LV_ejec_rest);

		LN_cod_retorno:=NULL;
		LV_des_cadena:=NULL;
		sSql:='SELECT COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena '||
		      'FROM  GA_TRANSACABO '||
			  'WHERE  NUM_TRANSACCION='||LN_num_transaccion;
		SELECT  COD_RETORNO,DES_CADENA INTO LN_cod_retorno, LV_des_cadena
		  FROM  GA_TRANSACABO
		 WHERE  NUM_TRANSACCION=LN_num_transaccion;
		IF LN_cod_retorno<>0 then
		   SN_cod_retorno := '314';
		   sSql:=LV_des_cadena;
		   RAISE error_ejecucion;
		END IF;

   		-- Ejecutar procedimiento que obtiene datos del abonado, entre ellos el cod_cliente
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR('||EN_num_celular||','||SN_num_abonado||','||SN_cod_cliente||','||SN_cod_producto||','||SV_cod_situacion||','||SV_tip_plantarif||','
		      ||SV_cod_plantarif||','||SV_num_serie||','||SN_cod_ciclo||','||SV_tecnologia||','||SV_num_imei||','
			  ||SV_num_min_mdn||','||SV_num_min_mdn||','||SV_cod_password||','||SV_num_min||','
			  ||SV_tip_terminal||','||SV_num_seriehex||','||SV_num_seriemec||','||SV_tipo_abonado||','
			  ||SN_cod_cuenta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||'); - '||SQLERRM,1,CN_largoquery);
	    GA_CONSULTAS_PG.GA_CONSULTA_ABONADO_PR(EN_num_celular, SN_num_abonado,
		   SN_cod_cliente, SN_cod_producto, SV_cod_situacion,SV_tip_plantarif,
		   SV_cod_plantarif, SV_num_serie, SN_cod_ciclo,
		   SV_tecnologia, SV_num_imei, SV_num_min_mdn, SV_cod_password, SV_num_min,
		   SV_tip_terminal, SV_num_seriehex, SV_num_seriemec,SV_tipo_abonado,
		   SN_cod_cuenta,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN
           SN_cod_retorno:='309';
    	   RAISE  error_ejecucion;
		END IF;
		IF SN_cod_cliente IS NULL THEN
	       SN_cod_retorno := '146';
           RAISE  error_ejecucion;
		END IF;

		--Inicio 30-06-2005 ---
		-- Ejecutar procedimiento que obtiene codigo y descripcion del tipo de producto asociado al plan del abonado....
		--Para validar si es postpago......
		sSql:=SUBSTR('GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR('||SV_cod_plantarif||');',1,CN_largoquery);
		GA_CONSULTAS_PG.GA_CONSULTA_TIPO_PRODUCTO_PR(SV_cod_plantarif,LV_cod_tiplan,
			   LV_des_tiplan,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
		IF SN_cod_retorno<>0 THEN  --Implica que hay error
		   RAISE  error_ejecucion;
		END IF;
		IF TRIM(LV_cod_tiplan)<>CV_prod_postpago THEN
		   SN_cod_retorno := '314';
		   RAISE error_ejecucion;
		END IF;
		--Fin 30-06-2005 ---

		--Obtiene cod_ciclfact del cliente....
		sSql:=SUBSTR('GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN('||SN_cod_ciclo||');- '||SQLERRM,1,CN_largoquery);
	 	IF NOT GE_VALIDACIONES_PG.GE_OBTIENE_CICLOFACT_FN(SN_cod_ciclo,LN_cod_ciclfact,
		       SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO ) THEN
          	   SN_cod_retorno := '310';
		       RAISE error_ejecucion;
		END IF;

		--Obtiene módulo 10 del codigo del cliente para accesar la tabla que corresponde
		LC_dig:=MOD(SN_cod_cliente,10);

		--Obtiene minutos por horario y tipo de dia....
		sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_POR_PERIODO_PR ('||SN_cod_cliente||
			  ','||SN_num_abonado||','||LN_cod_ciclfact||','||SV_cod_plantarif||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);
	    GA_TRAFICO_PG.GA_MINUTOS_POR_PERIODO_PR (SN_cod_cliente, SN_num_abonado,
		   LN_cod_ciclfact,SV_cod_plantarif,LC_dig,SC_min_hor,SC_min_tip_dia,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno<>0 THEN  --Implica que hay error..
           SN_cod_retorno:='309';
    	   RAISE  error_ejecucion;
		END IF;

		--Obtiene minutos libres por plan tarifario....
		SN_plan_min_lib:=0;
		sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_POR_PLAN_PR('||SV_cod_plantarif||'); - '||SQLERRM,1,CN_largoquery);
		GA_TRAFICO_PG.GA_MINUTOS_POR_PLAN_PR(SV_cod_plantarif,SN_plan_min_lib,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
           SN_cod_retorno := '309';
    	   RAISE  error_ejecucion;
		END IF;

		--Obtiene minutos utilizados....
		SN_usado:=0;
		sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_USADOS_PR ('||SN_cod_cliente||
			  ','||SN_num_abonado||','||LN_cod_ciclfact||','||SV_cod_plantarif||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);
	    GA_TRAFICO_PG.GA_MINUTOS_USADOS_PR (SN_cod_cliente, SN_num_abonado,
		   --LN_cod_ciclfact,SV_cod_plantarif,LC_dig,SN_usado,SN_cod_retorno,SV_mens_retorno, SN_num_evento);--RA-200511100082: German Espinoza Z; 10/11/2005
		   LN_cod_ciclfact,SV_cod_plantarif,LC_dig,SN_usado,SN_nousado,SN_cod_retorno,SV_mens_retorno, SN_num_evento);--RA-200511100082: German Espinoza Z; 10/11/2005
		IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
           SN_cod_retorno := '309';
    	   RAISE  error_ejecucion;
		END IF;

		--Obtiene minutos no utilizados.....
		--SN_nousado:=SN_plan_min_lib - SN_usado;--RA-200511100082: German Espinoza Z; 10/11/2005

		--Obtiene la fecha en la cual se actualizó el tráfico tasado consultado...
		SD_fec_corte:=NULL;
		sSql:=SUBSTR('GA_TRAFICO_PG.GA_FECHA_ACTUALIZA_PR ('||SN_cod_cliente||
			  ','||SN_num_abonado||','||LN_cod_ciclfact||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);
	    GA_TRAFICO_PG.GA_FECHA_ACTUALIZA_PR(SN_cod_cliente, SN_num_abonado,
		   LN_cod_ciclfact,LC_dig,SD_fec_corte,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
           SN_cod_retorno := '309';
    	   RAISE  error_ejecucion;
		END IF;

		SN_valor:=0;
		--Obtener codigo de plan especial...
	    LV_val_parametro:=NULL;
	    sSql:=SUBSTR('ge_validaciones_pg.ge_obtiene_gedparametros_fn('||CV_plan_especial||','||CV_cod_modulo||','||CV_cod_producto_post||'); - ' || SQLERRM,1,CN_largoquery);
		IF NOT ge_validaciones_pg.ge_obtiene_gedparametros_fn(CV_plan_especial,CV_cod_modulo,
		   	   				  CV_cod_producto_post,LV_val_parametro,
		                      SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
             SN_cod_retorno:= '309';
			 RAISE  error_ejecucion;
		END IF;

		--Obtener indicador de plan especial.....
		SN_ind_planesp:=0;
		sSql:=SUBSTR('GA_TRAFICO_PG.GA_INDICA_PLANESP_PR('||LV_val_parametro||');- '||SQLERRM,1,CN_largoquery);
		GA_TRAFICO_PG.GA_INDICA_PLANESP_PR(SN_num_abonado,LV_val_parametro,SN_ind_planesp,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
           SN_cod_retorno := '309';
    	   RAISE  error_ejecucion;
		END IF;

   	    SN_valor:=0;
		SN_Bs2bs:=0;
		IF SN_ind_planesp = 1 THEN
    	   --Obtiene minutos libres para el plan tarifario especial....

		   --German Espinoza Z; 08/11/2005
		   --sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_POR_PLAN_PR('||LV_val_parametro||'); - '||SQLERRM,1,CN_largoquery);
    	   --GA_TRAFICO_PG.GA_MINUTOS_POR_PLAN_PR(LV_val_parametro,SN_valor,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		   sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_POR_PLAN_PR('||SV_cod_plantarif||'); - '||SQLERRM,1,CN_largoquery);
    	   GA_TRAFICO_PG.GA_MINUTOS_POR_PLAN_PR(SV_cod_plantarif,SN_valor,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
    	   --FIN/German Espinoza Z; 08/11/2005


		   IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
               SN_cod_retorno := '309';
        	   RAISE  error_ejecucion;
    	   END IF;

		   --Obtiene minutos consumidos intrared.....

		   --German Espinoza Z; 08/11/2005
		   --sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_INTRARED_PR ('||SN_cod_cliente||
	       --		  ','||SN_num_abonado||','||LN_cod_ciclfact||','||LV_val_parametro||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);
	       --GA_TRAFICO_PG.GA_MINUTOS_INTRARED_PR (SN_cod_cliente, SN_num_abonado,
		   --   LN_cod_ciclfact,LV_val_parametro,LC_dig,SN_Bs2bs,SN_cod_retorno,SV_mens_retorno, SN_num_evento);

		   sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_INTRARED_PR ('||SN_cod_cliente||
	    		  ','||SN_num_abonado||','||LN_cod_ciclfact||','||SV_cod_plantarif||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);

	       GA_TRAFICO_PG.GA_MINUTOS_INTRARED_PR (SN_cod_cliente, SN_num_abonado,
		      LN_cod_ciclfact,SV_cod_plantarif,LC_dig,SN_Bs2bs,SN_cod_retorno,SV_mens_retorno, SN_num_evento);

		   --FIN/German Espinoza Z; 08/11/2005

	       IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
              SN_cod_retorno := '309';
    	      RAISE  error_ejecucion;
		   END IF;

		   --Obtiene datos del plan especial...

		   --German Espinoza Z; 08/11/2005
		   --sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_PLANESP_PR('||SN_cod_cliente||
		   --	     ','||SN_num_abonado||','||LN_cod_ciclfact||','||LV_val_parametro||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);
	       --GA_TRAFICO_PG.GA_MINUTOS_PLANESP_PR(SN_cod_cliente, SN_num_abonado,
		   --   LN_cod_ciclfact,LV_val_parametro,LC_dig,SC_min_planesp,SN_cod_retorno,SV_mens_retorno, SN_num_evento);


		   sSql:=SUBSTR('GA_TRAFICO_PG.GA_MINUTOS_PLANESP_PR('||SN_cod_cliente||
			     ','||SN_num_abonado||','||LN_cod_ciclfact||','||SV_cod_plantarif||','||LC_dig||'); - '||SQLERRM,1,CN_largoquery);

	       GA_TRAFICO_PG.GA_MINUTOS_PLANESP_PR(SN_cod_cliente, SN_num_abonado,
		      LN_cod_ciclfact,SV_cod_plantarif,LC_dig,SC_min_planesp,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
		   --FIN/German Espinoza Z; 08/11/2005

	   	   IF SN_cod_retorno <> 0 THEN  --Implica que hay error..
              SN_cod_retorno := '309';
    	      RAISE  error_ejecucion;
		   END IF;
	  	END IF;

EXCEPTION
WHEN error_ejecucion THEN
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('error_ejecucion: GA_DET_FRANJA_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DET_FRANJA_PR', sSql, SQLCODE, V_des_error );
WHEN OTHERS THEN
                SN_cod_retorno := '309';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                     SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error :=SUBSTR('Others: GA_DET_FRANJA_PR('||EN_num_celular||'); - ' || SQLERRM,1,CN_largoerrtec);
 				SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_DET_FRANJA_PR', sSql, SQLCODE, V_des_error );
END GA_DET_FRANJA_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END GA_TRAFICO_PG;
/
SHOW ERRORS
