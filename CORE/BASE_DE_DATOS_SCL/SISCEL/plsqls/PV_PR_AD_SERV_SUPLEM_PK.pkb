CREATE OR REPLACE package body pv_pr_ad_serv_suplem_pk as

PROCEDURE inicial(
	s_num_os  IN VARCHAR2,
	s_cs_act  IN VARCHAR2,
	s_cs_des  IN VARCHAR2,
	s_abonado IN VARCHAR2,
	s_error   OUT VARCHAR2
)
IS
	/*
	  Activacion y Desactivacion de Servicios Suplementarios
	  (Version 1.0.0 2002-09-06)
	*/

	    error_parametros    Exception;
		error_consulta      Exception;
		type arreglo is table  of varchar2(7) INDEX BY BINARY_INTEGER;
		codigo			   	arreglo;
		i 					number;
		cod_1		        varchar2(3);--1 = Dias Especiales
		cod_2		        varchar2(3);--2 = C?digo FriendFamily
		cod_3		        number(2);--3 = N?mero m?ximo de d?as especiales por abonado
		cod_4		        number(2);--4 = N?mero m?ximo de n?meros especiles por abonado
		cod_5		        varchar2(2);--5=  C?digo de tipo de d?a para d?as especiales celular
		cod_6		        varchar2(3);--6=  C?digo de servicio de cargo de conexi?n celular
		cod_7		        varchar2(3);--7=  C?digo de servicio detalle llamadas celular


	    /********************* variables para manejar servicios a activar y desactivar*********************/

		i_a    		        integer; --indice para servicios a activar
		i_d			        integer; --indice para servicios a desactivar
		i_p			        integer; --indice para servicios procesados

		l_a			        integer; --largo servicios a activar
		l_d			        integer; --largo servicios a desactivar
		l_p			        integer; --largo servicios procesardos

		s_cod_servicio_a    varchar2(2); -- servicio en activar
		s_cod_nivel_a       varchar2(4); -- nivel del servicio a activar
		s_cod_servicio_d    varchar2(2); -- servicio a desactivar
		s_cod_nivel_d       varchar2(4); -- nivel del servicio a desactivar
		s_cs_act_procesados varchar2(255); -- Servicios a activar ya procesados
		s_cs_act_pservicio  varchar2(2); -- servicio ya procesado
		s_cs_act_pnivel     varchar2(4); -- nivel del servicio ya procesado
		n_find              integer; -- servicio encontrado 1 = true 0 = false
	    s_servicios_a       varchar2(255); --  servicios que activo  en enroque
		s_servicios_d       varchar2(255); --  servicios que desactivo
		s_servicios_sa      varchar2(255); -- servicios que solo activo

		/********************* variables para desarrollar consultas din?micas *****************************/

		ssql                varchar2(1400); -- contiene consulta din?mica
		cur_din             integer; -- Var asociada a un cursor din?mico
		rows_return         integer; -- filas retornadas por ejecutar consulta en cursor din?mico

	    /******************** variables para contener datos anexos a un c?digo de servicio ****************/

		concepto_fa	        number(4); -- si es distinta de null el servicio a activar tiene asociado un concepto de facturaci?n
		cod_servicio_siscel ga_servsuplabo.COD_SERVSUPL%type; -- valor del servicio visto por SISCEL varchar2(4)
		celular		        ga_abocel.NUM_CELULAR%type; -- celular de un abonado} number(8)
		cod_central1        ga_abocel.COD_CENTRAL%type;
		NumSerieHex1        ga_abocel.NUM_SERIEHEX%type;
		TipTerminal1        ga_abocel.TIP_TERMINAL%type;
		nummin1		        ga_abocel.NUM_MIN%type;
		CodCliente1	        ga_abocel.COD_CLIENTE%type;
		v_numdiasnum        ga_servsuplabo.NUM_DIASNUM%type;
		CodPlanCom1	        ga_cliente_pcom.COD_PLANCOM%TYPE;
		Cadena_actual       ga_abocel.clase_servicio%type;
		scod_servicio       ga_servsupl.COD_SERVICIO%type;
		s_usuario           pv_iorserv.USUARIO%type;
		n_ciclo             ga_abocel.cod_ciclo%type;
		s_cod_ciclo         fa_ciclfact.COD_CICLFACT%type;
		Cadena_resp         ga_abocel.clase_servicio%type;
		/******************** variables de apoyo *********************************************************/

		c			        varchar2(1);
	    ncod_sistema        icg_serviciotercen.COD_SISTEMA%type;
		isoportable         integer;
		scode_error         ga_errores.COD_SQLCODE%TYPE;
		sdes_error          varchar2(255);
		TABLA               varchar2(100);
		n_es_detalle		GA_SERVSUPL.COD_SERVICIO%TYPE;
		n_es_fyf    		GA_SERVSUPL.COD_SERVICIO%TYPE;
		fyf_param			GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		/******************** Variables para actualizar PV_MOVMIENTOS ************************************/
		cant_mov            integer;

		/******************** CURSORES *******************************************************************/

			CURSOR DIAS_ESPECIALES IS
				SELECT GA_SEQ_NUMDIASNUM .NEXTVAL FROM DUAL;

			CURSOR DAT_DIAS_ESPECIALES IS
			    SELECT *
				FROM   GA_DIASABO
				WHERE  NUM_ABONADO = to_number(s_abonado);

			CURSOR Cod_Serv_Especiales is -- Rescata codigos Servicios Especiales
				select VAL_PARAMETRO
				from   ged_parametros
				where  nom_parametro IN('COD_DIASESPCEL','COD_FYFCEL','NUM_DIASESP','NUM_TELESP','COD_TIPDIACEL','COD_SERCONEXCEL','COD_DETCEL')
				AND	   COD_PRODUCTO = 1
				AND	   COD_MODULO 	= 'GA';

BEGIN
	-- Inicializar variables
	c  := chr(39);
	i_a:= 0;
	i_d:= 0;
	s_servicios_a:= '';
	s_servicios_d:= '';
	s_servicios_sa:= '';

	if (s_cs_act = NULL or s_cs_des = NULL or s_abonado = NULL)  then
		raise error_parametros;
	end if;

	if (s_cs_act = '*' and s_cs_des = '*') then
		raise error_consulta;
	end if;

	if s_cs_act <> '*' then
		l_a := length(s_cs_act)/6;
	elsif s_cs_act = '*' then --significa que no se solicita activar un servicio
		l_a:= 0;
	end if;

	   if s_cs_des <> '*' then --significa que no se solicita DESACTIVAR un servicio
	      l_d := length(s_cs_des)/6;
	   elsif s_cs_des = '*' then
	      l_d := 0;
	   end if;

	   -- Rescatar c?digos para servicios especiales
	   /*
	   SELECT COD_DIASESPCEL, COD_FYFCEL, NUM_DIASESP, NUM_TELESP, COD_TIPDIACEL, COD_SERCONEXCEL, COD_DETCEL
	   INTO   cod_1,          cod_2,      cod_3,       cod_4,      cod_5,         cod_6,           cod_7
	   FROM   GA_DATOSGENER;
	   */

	   -- 13/09/2002 : Lo anterior Reemplazar por esto
	   -- Rescata codigos de Servicios Especiales

	   i:=1;
	   for vp in Cod_Serv_Especiales loop
	   	   codigo(i):=vp.VAL_PARAMETRO;
		   i:= i +1;
	   end loop;
	   -------------------------


	   --Obtener datos del abonado
	   TABLA := 'GA_ABOCEL';
	   BEGIN
		   SELECT a.NUM_CELULAR, a.COD_CENTRAL, a.NUM_SERIEHEX, a.TIP_TERMINAL,a.NUM_MIN,a.COD_CLIENTE, a.CLASE_SERVICIO, a.cod_ciclo
		   INTO   celular, cod_central1, NumSerieHex1, TipTerminal1, nummin1,CodCliente1, cadena_actual, n_ciclo
		   FROM   GA_ABOCEL a
		   WHERE  a.NUM_ABONADO = to_number(s_abonado);
	   EXCEPTION
	       WHEN   NO_DATA_FOUND THEN
		   TABLA:= 'GA_ABOAMIST';
	   END;
	   IF TABLA = 'GA_ABOAMIST' THEN
		   SELECT a.NUM_CELULAR, a.COD_CENTRAL, a.NUM_SERIEHEX, a.TIP_TERMINAL,a.NUM_MIN,a.COD_CLIENTE, a.CLASE_SERVICIO, a.cod_ciclo
		   INTO   celular, cod_central1, NumSerieHex1, TipTerminal1, nummin1,CodCliente1, cadena_actual, n_ciclo
		   FROM   GA_ABOAMIST a
		   WHERE  a.NUM_ABONADO = to_number(s_abonado);
	   END IF;
	   --Obtener c?digo de sistema

	   SELECT cod_sistema
	   INTO   ncod_sistema
	   FROM   ICG_CENTRAL
	   WHERE  cod_producto = 1
	   AND 	  cod_central = cod_central1;


	   --Obtener usuario de la OOSS
	   SELECT usuario
	   into   s_usuario
	   FROM   PV_IORSERV
	   WHERE  NUM_OS = s_num_os;

	   -- Servicios a Desactivar
	   if l_d > 0 then
		   loop -- ciclo para recorrer servicios a desactivar
		      n_find := 0;
		      if i_d >= l_d then
			     exit;
			  end if;
			  s_cod_servicio_d := substr(s_cs_des,6*i_d+1,2);
			  s_cod_nivel_d := substr(s_cs_des,6*i_d+1+2,4);
			  i_a:= 0;
			  if l_a > 0 then
		         loop --ciclo para recorrer servicios a activar
			        if i_a >= l_a then
				       exit;
				    end if;
				    s_cod_servicio_a := substr(s_cs_act,6*i_a+1,2);
				    s_cod_nivel_a := substr(s_cs_act,6*i_a+1+2,4);
				    if s_cod_servicio_d = s_cod_servicio_a then
				       n_find := 1;
					   exit;
				     end if;
			         i_a:= i_a +1;
			     end loop;--ciclo para recorrer servicios a activar
			  end if;
			  if n_find = 1 then --Caso en que desactivo un servicio y activo otro del mismo grupo

	              s_servicios_a := s_servicios_a || s_cod_servicio_a || s_cod_nivel_a;

				  /********* Obtengo los datos complemnatrios del servicio a Activar **************************/
				  /*                         in              in          out      */
				  DATOS_COMPL_SERV_ACT(s_cod_servicio_a,s_cod_nivel_a,scod_servicio);

				  /********* Fin datos complemnatrios del servicio a Activar **********************************/


	             /*Verificar si el servicio es soportado por el terminal*/
				 /*                      in              in           in          out      */
				  SERV_SOPORT_TERM(s_cod_servicio_a,TipTerminal1,ncod_sistema,isoportable);

				  if isoportable > 0 then
					     /* Dar de baja servicio a desactivar*/
			             ssql := 'UPDATE GA_SERVSUPLABO SET ' ||
			               	  	 'FEC_BAJABD = SYSDATE, IND_ESTADO = 3 ' ||
							     'WHERE COD_PRODUCTO = 1 ' ||
								 'AND NUM_ABONADO = ' || s_abonado || ' ' ||
			                     'AND COD_SERVSUPL = ' || s_cod_servicio_d || ' ' ||
			                     'AND FEC_BAJABD IS NULL ';
						 cur_din:= dbms_sql.OPEN_CURSOR;
						 dbms_sql.PARSE(cur_din,ssql,dbms_sql.v7);
						 rows_return:= dbms_sql.EXECUTE(cur_din);
						 dbms_sql.CLOSE_CURSOR(cur_din);


	                     /****** si es detalle de llamadas entonces actualiz? en alta ga_infaccel *******/
						 /* Buscamos si el codigo de servicio es detalle*/
						 /*                        in           in      in     */
						 COD_SERV_SIES_DETALLE(s_abonado,s_cod_nivel_d,scod_servicio,1,TABLA);

						 /* FRIEND AND FAMILY */
						 /*                in          in     */
						 FRIEND_FAMILY(s_abonado,scod_servicio);

			           /* ********** Dar de Alta el Servicio por enroque *********** */
					   /*                                        1              2           3            4            5           6              7           8            9       */
			           ssql := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';
					   -- If  s_cod_servicio_a in (cod_1,  cod_2) Then
					   If  s_cod_servicio_a in (codigo(1),  codigo(2)) Then
					                          /*    10   */
			               ssql := ssql || ', NUM_DIASNUM ';

			           End If;



					  /********* Rescatar si existe concepto de facturaci?n asociado al servicio ******************/
					  /*                       in         out    */
					   EXISTE_CONC_FACT(scod_servicio,concepto_fa);

			           If not concepto_fa is null Then
					                         /*    11     */
			               ssql := ssql || ', COD_CONCEPTO';
			           End If;
			           ssql := ssql || ')  VALUES (' ||
					   /*             1                     2                       3              4                           5                    6           7       8                9         */
			                   s_abonado || ',' || c || scod_servicio || c || ', sysdate, ' || to_char(to_number(s_cod_servicio_a)) || ', ' || to_char(to_number(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;
					   --if s_cod_servicio_a in (cod_1, cod_2) then
					   If s_cod_servicio_a in (codigo(1),  codigo(2)) Then

					     /**********capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/
					      if NOT DIAS_ESPECIALES%ISOPEN then
					         open DIAS_ESPECIALES;
					      end if;
					      fetch DIAS_ESPECIALES into v_numdiasnum;
					      if DIAS_ESPECIALES%FOUND then
					         ssql:= ssql || ', ' || v_numdiasnum;
					      end if;
						 /********* Fin capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/

					   end if;


			            If not concepto_fa is null Then
			                sSql:= sSql || ',' || concepto_fa;
			            End If;
				        sSql := sSql || ')';

						/******************* Ejecuto consulta para dar de alta el servicio ****************************/

					    cur_din:= dbms_sql.OPEN_CURSOR;
					    dbms_sql.PARSE(cur_din,sSql,dbms_sql.v7);
					    rows_return:= dbms_sql.EXECUTE(cur_din);
					    dbms_sql.CLOSE_CURSOR(cur_din);
						s_cs_act_procesados := s_cs_act_procesados || s_cod_servicio_a || s_cod_nivel_a;

						/*********************************** servicio en alta   ***************************************/

	 				    /****** si es detalle de llamadas entonces actualiz? en alta ga_infaccel *******/
						/* Buscamos si el codigo de servicio es detalle*/
						/*                        in           in       in     */
						COD_SERV_SIES_DETALLE(s_abonado,s_cod_nivel_d,scod_servicio,2,TABLA);

						/* FRIEND AND FAMILY */
						/*                in          in     */
						FRIEND_FAMILY(s_abonado,scod_servicio);

					else
					  s_error:= s_error || scod_servicio || 'NS';
	                end if; --fin if que valida que el servicio es soportable por el terminal

			  elsif n_find = 0 then -- Caso en que solo desactivo un servicio es decir paso el servicio a nivel 0
			     --s_servicios_d := s_servicios_d || s_cod_servicio_d || s_cod_nivel_d;
				 s_servicios_d := s_servicios_d || s_cod_servicio_d ||'0000';
			     /* Dar de baja servicio a desactivar*/
	             ssql := 'UPDATE GA_SERVSUPLABO ' ||
	               	  	 'SET	 FEC_BAJABD 	= SYSDATE, IND_ESTADO = 3 ' ||
					     'WHERE  NUM_ABONADO	= ' || s_abonado || ' ' ||
	                     'AND 	 COD_SERVSUPL	= ' || s_cod_servicio_d || ' ' ||
	                     'AND 	 FEC_BAJABD 	  IS NULL ';
				 cur_din:= dbms_sql.OPEN_CURSOR;
				 dbms_sql.PARSE(cur_din,ssql,dbms_sql.v7);
				 rows_return:= dbms_sql.EXECUTE(cur_din);
				 dbms_sql.CLOSE_CURSOR(cur_din);
				 COD_SERV_SIES_DETALLE(s_abonado,s_cod_nivel_d,scod_servicio,2,TABLA);
			  end if;
			  i_d:= i_d +1;
		   end loop;-- ciclo para recorrer servicios a desactivar
	       /*  se deben procesar aquellos servicios que estan para activar pero no se encuentran en desactivar*/
		   /*  en la viariable s_cs_act_procesados estan aquellos servicios no procesados por no tener relaci?n con los*/
		   /*  que se desactivan                                                                                       */

		  -- Ver si hay servicios pendientes de ser procesados
	      if length(s_cs_act_procesados) > 0 then
	         l_p := length(s_cs_act_procesados)/6;
		  else
		     l_p:= 0;
		  end if;
	--------------------
	      i_a:=0;
	      if l_a > 0 then --if que contiene al loop valida que la cacdena de activar es largo 0
			  loop --ciclo para recorrer servicios a activar
			      n_find := 0;
			      if i_a >= l_a then
				     exit;
				  end if;
				  s_cod_servicio_a := substr(s_cs_act,6*i_a+1,2);
				  s_cod_nivel_a    := substr(s_cs_act,6*i_a+1+2,4);
				  i_p := 0;
				  if l_p > 0 then
				     loop  --ciclo para verificar que el servicio no este activado por enroque
				        if i_p >= l_p then
					       exit;
					    end if;
					    s_cs_act_pservicio := substr(s_cs_act_procesados,6*i_p+1,2);
					    s_cs_act_pnivel    := substr(s_cs_act_procesados,6*i_p+1+2,4);
					    if s_cod_servicio_a = s_cs_act_pservicio then
					       n_find := 1;
						   exit;
					    end if;
					    i_p := i_p +1;
				     end loop;
				  end if;
				  if n_find <> 1 then
				     --Hemos encontrado un servicio sin procesar que debe ser activado
					 s_servicios_sa := s_servicios_sa || s_cod_servicio_a || s_cod_nivel_a;
		             ssql := '';

					 /********* Obtengo los datos complemnatrios del servicio a Activar **************************/
					 /*                         in              in          out      */
					 DATOS_COMPL_SERV_ACT(s_cod_servicio_a,s_cod_nivel_a,scod_servicio);

		             /*Verificar si el servicio es soportado por el terminal*/
				 	 /*                      in              in           in          out      */
				  	 SERV_SOPORT_TERM(s_cod_servicio_a,TipTerminal1,ncod_sistema,isoportable);

					  if isoportable > 0 then

				           /* ********** Dar de Alta el Servicio sin  procesar *********** */
						   /*                                        1              2           3            4            5           6              7           8            9       */
				           ssql := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';
						   --If  s_cod_servicio_a in (cod_1,  cod_2) Then
						   If  s_cod_servicio_a in (codigo(1),  codigo(2)) Then
						                         /*    10   */
				               ssql := ssql || ', NUM_DIASNUM ';
				           End If;



						  /********* Rescatar si existe concepto de facturaci?n asociado al servicio ******************/
						  /*                       in         out    */
					   	  EXISTE_CONC_FACT(scod_servicio,concepto_fa);

				           If not concepto_fa is null Then
						                         /*    11     */
				               ssql := ssql || ', COD_CONCEPTO';
				           End If;
				           ssql := ssql || ')  VALUES (' ||
						   /*             1                          2                       3              4                           5                    6                                    7           8         9         */
				                   s_abonado || ',' || c || scod_servicio || c || ', sysdate, ' || to_char(to_number(s_cod_servicio_a)) || ', ' || to_char(to_number(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;
						   --if s_cod_servicio_a in (cod_1, cod_2) then
						   If  s_cod_servicio_a in (codigo(1),  codigo(2)) Then

						     /**********capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/
						      if NOT DIAS_ESPECIALES%ISOPEN then
						         open DIAS_ESPECIALES;
						      end if;
						      fetch DIAS_ESPECIALES into v_numdiasnum;
						      if DIAS_ESPECIALES%FOUND then
						         ssql:= ssql || ', ' || v_numdiasnum;
						      end if;
							 /********* Fin capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/

						   end if;


				            If not concepto_fa is null Then
				                sSql:= sSql || ',' || concepto_fa;
				            End If;
					        sSql := sSql || ')';

							/******************* Ejecuto consulta para dar de alta el servicio ****************************/

						    cur_din:= dbms_sql.OPEN_CURSOR;
						    dbms_sql.PARSE(cur_din,sSql,dbms_sql.v7);
						    rows_return:= dbms_sql.EXECUTE(cur_din);
						    dbms_sql.CLOSE_CURSOR(cur_din);
							s_cs_act_procesados := s_cs_act_procesados || s_cod_servicio_a || s_cod_nivel_a;

							/*********************************** servicio en alta   ***************************************/

							/****** si es detalle de llamadas entonces actualiz? en alta ga_infaccel *******/
							/* Buscamos si el codigo de servicio es detalle*/
							/*                        in           in       in     */
							COD_SERV_SIES_DETALLE(s_abonado,s_cod_nivel_a,scod_servicio,1,TABLA);

							/* FRIEND AND FAMILY */
							/*                in          in     */
							FRIEND_FAMILY(s_abonado,scod_servicio);


						else
						  s_error:= s_error || scod_servicio || 'NS';
		                end if; -- servicio dado de alta si es soportado por el terminal

					 -- Dado de alta servicio no procesado

				  end if;
			      i_a:= i_a +1;
			  end loop;--ciclo para recorrer servicios a activar
		  end if; -- if que contien a este loop




	-------------------
		   /*  FIN: se deben procesar aquellos servicios que estan para activar pero no se encuentran en desactivar*/
	   elsif l_d = 0 then
	      /*if length(s_cs_act_procesados) > 0 then
	         l_p := length(s_cs_act_procesados)/6;
		  else
		     l_p:= 0;
		  end if;*/
		  loop --ciclo para recorrer servicios a activar
		      n_find := 0;
		      if i_a >= l_a then
			     exit;
			  end if;
			  s_cod_servicio_a := substr(s_cs_act,6*i_a+1,2);
			  s_cod_nivel_a := substr(s_cs_act,6*i_a+1+2,4);
	/*		  i_p := 0;
			  if l_p > 0 then
			     loop  --ciclo para verificar que el servicio no este activado por enroque
			        if i_p >= l_p then
				       exit;
				    end if;
				    s_cs_act_pservicio := substr(s_cs_act_procesados,6*i_p+1,6*(i_p+1));
				    s_cs_act_pnivel := substr(s_cs_act_procesados,6*i_p+1,6*(i_p+1));
				    if s_cod_servicio_a = s_cs_act_pservicio then
				       n_find := 1;
					   exit;
				    end if;
				    i_p := i_p +1;
			     end loop;
			  end if;*/
			  --if n_find <> 1 then
			     --Hemos encontrado un servicio sin procesar que debe ser activado
				 s_servicios_sa := s_servicios_sa || s_cod_servicio_a || s_cod_nivel_a;
	             ssql := '';

				  /********* Obtengo los datos complemnatrios del servicio a Activar **************************/
				  /*                         in              in          out      */
				  DATOS_COMPL_SERV_ACT(s_cod_servicio_a,s_cod_nivel_a,scod_servicio);

	             /********** Verificar si el servicio es soportado por el terminal ****************/
				 /*                      in              in           in          out      */
				  SERV_SOPORT_TERM(s_cod_servicio_a,TipTerminal1,ncod_sistema,isoportable);

				  if isoportable > 0 then

			           /* ********** Dar de Alta el Servicio sin  procesar *********** */
					   /*                                        1              2           3            4            5           6              7           8            9       */
			           ssql := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';
					   --If  s_cod_servicio_a in (cod_1,  cod_2) Then
					   If  s_cod_servicio_a in (codigo(1),  codigo(2)) Then
					                         /*    10   */
			               ssql := ssql || ', NUM_DIASNUM ';
			           End If;



					  /********* Rescatar si existe concepto de facturaci?n asociado al servicio ******************/
					  /*                       in         out    */
					  EXISTE_CONC_FACT(scod_servicio,concepto_fa);

					  /********* FIN Rescatar si existe concepto de facturaci?n asociado al servicio ******************/

			           If not concepto_fa is null Then
					                         /*    11     */
			               ssql := ssql || ', COD_CONCEPTO';
			           End If;
			           ssql := ssql || ')  VALUES (' ||
					   /*             1                          2                       3              4                           5                    6           7       8                9         */
			                   s_abonado || ',' || c || scod_servicio || c || ', sysdate, ' || to_char(to_number(s_cod_servicio_a)) || ', ' || to_char(to_number(s_cod_nivel_a)) || ', ' || celular || ',  1,       1,' || c || LTRIM(RTRIM(s_usuario)) || c;
					   --if s_cod_servicio_a in (cod_1, cod_2) then
					   If  s_cod_servicio_a in (codigo(1),  codigo(2)) Then

					     /**********capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/
					      if NOT DIAS_ESPECIALES%ISOPEN then
					         open DIAS_ESPECIALES;
					      end if;
					      fetch DIAS_ESPECIALES into v_numdiasnum;
					      if DIAS_ESPECIALES%FOUND then
					         ssql:= ssql || ', ' || v_numdiasnum;
					      end if;
						 /********* Fin capturo el correlativo numdiasnum (para D?as Especiales o FriendFamily*******/

					   end if;


			            If not concepto_fa is null Then
			                sSql:= sSql || ',' || concepto_fa;
			            End If;
				        sSql := sSql || ')';

						/******************* Ejecuto consulta para dar de alta el servicio ****************************/

					    cur_din:= dbms_sql.OPEN_CURSOR;
					    dbms_sql.PARSE(cur_din,sSql,dbms_sql.v7);
					    rows_return:= dbms_sql.EXECUTE(cur_din);
					    dbms_sql.CLOSE_CURSOR(cur_din);
						s_cs_act_procesados := s_cs_act_procesados || s_cod_servicio_a || s_cod_nivel_a;

						/*********************************** servicio en alta   ***************************************/

						/****** si es detalle de llamadas entonces actualiz? en alta ga_infaccel *******/
						/* Buscamos si el codigo de servicio es detalle*/
						/*                        in           in       in     */
						COD_SERV_SIES_DETALLE(s_abonado,s_cod_nivel_d,scod_servicio,1,TABLA);

						/* FRIEND AND FAMILY */
						/*                in          in     */
						FRIEND_FAMILY(s_abonado,scod_servicio);

					else
					  s_error:= s_error || scod_servicio || 'NS';
	                end if; -- servicio dado de alta si es soportado por el terminal

				 -- Dado de alta servicio no procesado

			  --end if;
		      i_a:= i_a +1;
		  end loop;--ciclo para recorrer servicios a activar

	   end if;
	   /************* Actualizar clase de servicio ************************/
	   --  s_servicios_a    --  servicios que activo  en enroque
	   --  s_servicios_d    --  servicios que desactivo
	   --  s_servicios_sa   -- 	servicios que solo activo

	   s_cod_servicio_a:= '';
	   s_cod_nivel_a:= '';
	   cadena_resp:= '';
	   n_find:= 0;
	   i_a:= 0;
	   if length(cadena_actual) > 0 then
	      l_a := length(cadena_actual)/6;
	   else
	      l_a:= 0;
	   end if;

	   loop -- recorro cadena actual
		  if i_a >= l_a then
		     exit;
		  end if;
		  s_cod_servicio_a := substr(cadena_actual,6*i_a+1,2);
		  s_cod_nivel_a    := substr(cadena_actual,6*i_a+1+2,4);
		  i_d:= 0;
		  if length(s_servicios_a) > 0 then
		     l_d:= length(s_servicios_a)/6;
		  else
		     l_d:= 0;
		  end if;
	      loop --verifico si tomo en cadena_resp servicio que cambian de nivel
		     n_find:=0;
			 if i_d >= l_d then
			    exit;
			 end if;
			 s_cod_servicio_d := substr(s_servicios_a,6*i_d+1,2);
			 s_cod_nivel_d 	  := substr(s_servicios_a,6*i_d+1+2,4);
			 if s_cod_servicio_a = s_cod_servicio_d then
				n_find:=1;
				exit;
			 end if;
			 i_d:= i_d +1;
		  end loop;
		  if n_find = 1 then
		     cadena_resp:= cadena_resp || s_cod_servicio_d || s_cod_nivel_d;
		  end if;
		  i_d:= 0;
		  if length(s_servicios_d) > 0 then
		     l_d:= length(s_servicios_d)/6;
		  else
		     l_d:=0;
		  end if;
		  loop --verifico si el servicio en cadena_resp no debe ir
		     if i_d >= l_d then
		        exit;
		     end if;
		     s_cod_servicio_d := substr(s_servicios_d,6*i_d+1,2);
		     s_cod_nivel_d 	  := substr(s_servicios_d,6*i_d+1+2,4);
		     if s_cod_servicio_a = s_cod_servicio_d then
		        n_find:=2;
		        exit;
			 end if;
			 i_d:= i_d +1;
		  end loop;
		  if n_find = 2 then
		     cadena_resp:= cadena_resp; --ignoro este servicio
		  elsif n_find = 0 then -- el servicio se concerva sin cambios
		     cadena_resp:= cadena_resp || s_cod_servicio_a || s_cod_nivel_a;
		  end if;
		  i_a:= i_a+1;
	   end loop;
	   cadena_resp:= cadena_resp || s_servicios_sa; --agrego a los nuevos
	   IF TABLA = 'GA_ABOCEL' THEN
	      UPDATE GA_ABOCEL
		  SET clase_servicio = cadena_resp
		  WHERE NUM_ABONADO = s_abonado;
	   ELSIF TABLA = 'GA_ABOAMIST' THEN
	      UPDATE GA_ABOAMIST
		  SET clase_servicio = cadena_resp
		  WHERE NUM_ABONADO = s_abonado;
	   END IF;
	   /************* Actualizar GA_MODABOCEL *************************/
	   INSERT INTO GA_MODABOCEL
	   (NUM_ABONADO, NUM_OS, COD_TIPMODI, FEC_MODIFICA,NOM_USUARORA)
	   VALUES
	   (to_number(s_abonado), to_number(s_num_os), 'SS', sysdate, LTRIM(RTRIM(s_usuario)));
	   /************* Actualizar PV_MOVMIENTOS ******************/
	   --  s_servicios_a    --  servicios que activo  en enroque
	   --  s_servicios_d    --  servicios que desactivo
	   --  s_servicios_sa   -- servicios que solo activo
	   BEGIN
	       SELECT COUNT(*)
		   INTO cant_mov
		   FROM PV_MOVIMIENTOS
		   WHERE NUM_OS = TO_NUMBER(s_num_os);
	   EXCEPTION
	       WHEN OTHERS THEN
		      cant_mov:=0;
	   END;
	   if cant_mov > 0 then
	      UPDATE PV_MOVIMIENTOS
		  SET COD_SERVICIO = s_servicios_a || s_servicios_d ||  s_servicios_sa
		  WHERE num_os = to_number(s_num_os);
	   elsif cant_mov = 0 then
	      INSERT INTO PV_MOVIMIENTOS (NUM_OS, F_EJECUCION, ORD_COMANDO, COD_ACTABO, COD_SERVICIO, IND_ESTADO, FEC_EXPIRA, RESP_CENTRAL, NUM_MOVIMIENTO)
		  VALUES (TO_NUMBER(s_num_os), NULL, 1, 'SS', s_servicios_a || s_servicios_d ||  s_servicios_sa, 1, NULL, NULL, NULL);
	   end if;
	   s_error:= 'OK';

EXCEPTION
	WHEN error_parametros THEN
		   s_error:= s_error || 'Par?metros mal Ingresados';
		   scode_error:= to_char(sqlcode);
		   sdes_error:= sqlerrm;
		   if s_abonado is not null then
			   INSERT INTO GA_ERRORES
			   (COD_ACTABO,CODIGO              ,FEC_ERROR,COD_PRODUCTO,NOM_PROC          ,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
			   VALUES
			   ('SS'      ,to_number(s_abonado),sysdate  ,1           ,'PV_AD_SERV_SUPLEM',NULL     ,'P'    ,scode_error   ,sdes_error     );
		   else
		     s_error:= s_error || ':' || scode_error || ':' || sdes_error;
		   end if;
	WHEN error_consulta THEN
		/*Caso en que el error se debe a que no existen servicios a activar ni a desactivar*/
		s_error:= 'NO HAY SERVICIOS PARA A/D';
        /* jpb-20030210
        	Actualizacion de tabla pv_camcom para que no procese central
        */
        UPDATE pv_camcom
           SET ind_central_ss = 0
         WHERE num_os = TO_NUMBER(s_num_os);

	WHEN NO_DATA_FOUND THEN
		   scode_error := to_char(SQLCODE);
		   sdes_error := SQLERRM;
		   if s_abonado is not null then
			   INSERT INTO GA_ERRORES
			   (COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
			   VALUES
			   ('SS',to_number(s_abonado),sysdate  ,1           ,'PV_AD_SERV_SUPLEM',NULL,'F',scode_error,sdes_error);
			   s_error:= s_error || ':' || scode_error || ':' || sdes_error;
		   else
		       s_error:= s_error || ':' || scode_error || ':' || sdes_error;
		   end if;
	WHEN OTHERS THEN
		scode_error:= to_char(sqlcode);
		sdes_error:= sqlerrm;
		s_error:= s_error || ':' || scode_error || ':' || sdes_error;
		ROLLBACK;
END;

/***** Friend and Family ******/
	procedure friend_family(
			  				s_abonado  	  in varchar2,
							scod_servicio in varchar2
						   )IS
		CodCliente1	        ga_abocel.COD_CLIENTE%type;
		n_es_fyf    		GA_SERVSUPL.COD_SERVICIO%TYPE;
		fyf_param			GED_PARAMETROS.VAL_PARAMETRO%TYPE;
		parametro			varchar2(10);
		begin
			begin
				parametro := 'FRIEND_FAM';
				SELECT val_parametro
				INTO   fyf_param
				FROM   ged_parametros
				WHERE  nom_parametro = parametro;

				SELECT COD_SERVICIO
				INTO   n_es_fyf
				FROM   GA_GRUPOS_SERVSUP
				WHERE  COD_GRUPO 	= fyf_param
				AND    COD_SERVICIO = scod_servicio
				AND    COD_PRODUCTO = 1;
			EXCEPTION
				WHEN OTHERS THEN
					n_es_fyf := NULL;
			END;
		if n_es_fyf is not null then
		   update ga_intarcel
		   set	  ind_friends = 1
		   where  cod_cliente = CodCliente1
		   and 	  num_abonado = s_abonado
		   and 	  sysdate between fec_desde
		   and 	  nvl(fec_hasta, sysdate);
		end if;

	end;


	PROCEDURE cod_serv_sies_detalle(
			  						s_abonado 	  in varchar2,
									s_cod_nivel_d in varchar2,
									scod_servicio in varchar2,
									opcion		  in number,
									TABLA 		  in varchar2
								   )IS
		Grupo			varchar2(7);
		n_ciclo         ga_abocel.cod_ciclo%type;
		CodCliente1	    ga_abocel.COD_CLIENTE%type;
		s_cod_ciclo     fa_ciclfact.COD_CICLFACT%type;
		n_es_detalle	GA_SERVSUPL.COD_SERVICIO%TYPE;
		sTecnologia		GA_ABOCEL.COD_TECNOLOGIA%TYPE;
		sTipTerminal	GA_ABOCEL.TIP_TERMINAL%TYPE;
		sCodCentral		GA_ABOCEL.COD_CENTRAL%TYPE;
		sCodSistema		ICG_CENTRAL.COD_SISTEMA%TYPE;

		/* Buscamos si el codigo de servicio es detalle
		       Ademas  se agrego la Tecnologia GSM
		              DMZ GSM 25/11/2002 */
		BEGIN
			 IF TABLA = 'GA_ABOCEL' THEN
				   SELECT COD_TECNOLOGIA ,TIP_TERMINAL, COD_CENTRAL, COD_CICLO
				 		INTO sTecnologia, sTipTerminal, sCodCentral, n_ciclo
						FROM GA_ABOCEL
						WHERE NUM_ABONADO = s_abonado;
			 ELSIF TABLA = 'GA_ABOAMIST' THEN
			 	   SELECT COD_TECNOLOGIA ,TIP_TERMINAL, COD_CENTRAL, COD_CICLO
				 		INTO sTecnologia, sTipTerminal, sCodCentral, n_ciclo
						FROM GA_ABOAMIST
						WHERE NUM_ABONADO = s_abonado;
			 END IF;
			 SELECT COD_SISTEMA
			 		INTO sCodSistema
					FROM ICG_CENTRAL
					WHERE COD_CENTRAL = sCodCentral;
			 BEGIN
				Grupo := 'DETLLAM';
				if opcion = 1 then
					SELECT COD_SERVICIO
					INTO   n_es_detalle
					FROM   GA_GRUPOS_SERVSUP
					WHERE  COD_GRUPO	= Grupo
					  AND  COD_SERVICIO	= scod_servicio
					  AND  COD_PRODUCTO	= 1;
				elsif opcion = 2 then
					SELECT a.COD_SERVICIO
					INTO   n_es_detalle
					FROM   GA_GRUPOS_SERVSUP A, GA_SERVSUPL B, ICG_SERVICIOTERCEN C
					WHERE  a.COD_GRUPO 	    = Grupo
					  AND  a.COD_PRODUCTO   = 1
					  AND  a.cod_producto   = b.cod_producto
					  AND  B.COD_PRODUCTO   = C.COD_PRODUCTO
					  AND  a.cod_servicio   = b.cod_servicio
					  AND  b.cod_nivel      = to_number(s_cod_nivel_d)
					  AND  b.cod_servsupl   = to_number(scod_servicio)
					  AND  B.COD_SERVSUPL   = C.COD_SERVICIO
					  AND  C.COD_SISTEMA    = sCodSistema
					  AND  C.TIP_TERMINAL   = sTipTerminal
					  AND  C.TIP_TECNOLOGIA = sTecnologia;
				end if;
			EXCEPTION
				WHEN OTHERS THEN
					 n_es_detalle := NULL;
			END;

		IF TABLA = 'GA_ABOCEL' AND n_es_detalle IS NOT NULL THEN
			SELECT COD_CICLFACT
			INTO   s_cod_ciclo
			FROM   FA_CICLFACT
			WHERE  COD_CICLO = n_ciclo
			AND	   sysdate BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;
			if  s_cod_nivel_d = '0000' THEN
				UPDATE GA_INFACCEL
				SET	   IND_DETALLE  = 0
				WHERE  COD_CLIENTE  = CodCliente1
				AND	   NUM_ABONADO  = s_abonado
				AND	   COD_CICLFACT = s_cod_ciclo;
			end if;
		END IF;

	end;


	PROCEDURE existe_conc_fact(
			  				   scod_servicio in  varchar2,
							   concepto_fa 	 out number
							  )IS
		ACTABO		varchar2(2);
		producto	number(1);
		/********* Rescatar si existe concepto de facturaci?n asociado al servicio ******************/
		BEGIN
			producto:= 1;
			ACTABO:='FA';
			SELECT COD_CONCEPTO
			INTO   concepto_fa
			FROM   GA_ACTUASERV
			WHERE  COD_SERVICIO = scod_servicio
			AND    COD_PRODUCTO = producto
			AND    COD_ACTABO   = ACTABO;
		EXCEPTION
			WHEN OTHERS THEN
				concepto_fa:= null;

	end;

	PROCEDURE datos_compl_serv_act(
			  				   s_cod_servicio_a in  varchar2,
							   s_cod_nivel_a 	in  varchar2,
							   scod_servicio 	out varchar2
			  				  )IS
		producto	number(1);
		BEGIN
			 producto:= 1;
			 SELECT cod_servicio
			 INTO	scod_servicio
			 FROM	GA_SERVSUPL
			 WHERE	cod_producto = producto
			 AND	cod_nivel    = to_number(s_cod_nivel_a)
			 AND	cod_servsupl = to_number(s_cod_servicio_a);

	end;

	procedure serv_soport_term(
			  				   s_cod_servicio_a in  varchar2,
							   TipTerminal1 	in 	varchar2,
							   ncod_sistema 	in 	varchar2,
			  				   isoportable 		out integer
			  				  )IS
		producto	number(1);
		begin
			producto:= 1;
			/*Verificar si el servicio es soportado por el terminal*/
			SELECT COUNT(*)
			INTO   isoportable
			FROM   ICG_SERVICIOTERCEN
			WHERE  cod_servicio = to_number(s_cod_servicio_a)
			AND    cod_producto = producto
			AND    tip_terminal = TipTerminal1
			AND    cod_sistema 	= ncod_sistema;

	end;

end pv_pr_ad_serv_suplem_pk;
/
SHOW ERRORS
