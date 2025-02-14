CREATE OR REPLACE PACKAGE BODY            EBZ_SERVSUPL AS




		--DESARROLLADOR: Fernando Garcia Escudero
		procedure CO_SERV_SUPLEMENTARIO_V2(
				                        identificacion in varchar2,
										tip_identifica in varchar2,
										aplicacion     in varchar2,
										cod_cliente    out t_cod_cliente_,
										celular        out t_celular,
										cod_serv       out t_cod_serv,
										descrip_serv   out t_descrip_serv,
										estado_serv    out t_estado_serv,
										error          out t_error
										)IS

    	   error_param    Exception;
		   n_error        integer;
     	   cod_cliente1   number(8);
		   ssql           varchar2(1024);
		   ssql1          varchar2(1024);
		   cur_datos      integer;
		   cur_datos1     integer;
		   cur_datos2     integer;
		   resp_cur_datos integer;
		   c              varchar2(1);
		   c1             varchar2(1);
		   aceptado       integer;   /* 1 = true 0= false */
		   i              integer;
		   j              integer;
           i1             integer;
		   j1             integer;
		   largo          integer;
		   L              integer;

  		   /* variables para traspaso de datos */
           col1           varchar2(2);
		   col2           varchar2(40);
		   col3           varchar2(10);
		   col4           varchar2(10);
           col5           varchar2(180);
		   col6			  number(1);

		   col_ncel       number(8);
		   col_abonado    number(8);

		   cod_clienteA   number(8);

		BEGIN
		   i:=1;
		   c:= chr(39);
				if tip_identifica <> 'C' and tip_identifica <> 'R' and tip_identifica <> 'A' then
				   error (n_error):= 'Tipo de identificacion puede ser C o R o A';
				   n_error:= n_error +1;
				   raise error_param;
				end if;

	           if tip_identifica = 'R' or tip_identifica = 'C' or tip_identifica = 'A' then
			      if tip_identifica = 'R' then
                       /* obtener la cuenta del cliente */
 		                ssql1:= 'SELECT b.cod_cliente ' ||
					            'FROM ga_cuentas a, ge_clientes b '   ||
						        'WHERE a.num_ident = '  || c || ltrim(rtrim(identificacion)) || c || ' ' ||
								'and a.cod_tipident = ' || c || '01' || c || ' ' ||
						        'and a.cod_cuenta = b.cod_cuenta';

					    cur_datos2 := dbms_sql.open_cursor;
			    	    dbms_sql.parse(cur_datos2,ssql1, DBMS_SQL.V7);
						--error_sql:= dbms_sql.last_error_position;

					    dbms_sql.define_column(cur_datos2, 1, cod_clienteA );
						resp_cur_datos:= dbms_sql.execute (cur_datos2);
						j1:=dbms_sql.fetch_rows(cur_datos2);
						if j1 = 0 then
						   cod_cliente1:= 0;
						else
						   dbms_sql.column_value (cur_datos2,1,cod_clienteA);
						   cod_cliente1:= cod_clienteA;
						end if;
				  elsif tip_identifica = 'A' then
	     			   ssql1:= 'SELECT  g1.cod_cliente cod_cliente ' ||
					           'FROM ga_abocel  g1, ga_usuarios g2 ' ||
							   'WHERE g1.num_celular = ' || Rtrim(Ltrim(identificacion)) || ' ' ||
							   'AND g1.cod_usuario = g2.cod_usuario ' ||
							   'AND g1.cod_situacion <> ' || c || 'BAA' || c || ' ' ||
							   'UNION ALL ' ||
							   'SELECT g1.cod_cliente cod_cliente ' ||
					           'FROM ga_aboamist g1, ga_usuamist g2 ' ||
							   'WHERE g1.num_celular = ' || Rtrim(Ltrim(identificacion)) || ' ' ||
							   'AND g1.cod_usuario = g2.cod_usuario ' ||
							   'AND g1.cod_situacion <> ' || c || 'BAA' || c || ' ';
				        cur_datos1 := dbms_sql.open_cursor;
	    				dbms_sql.parse(cur_datos1,ssql1, DBMS_SQL.V7);
						dbms_sql.define_column(cur_datos1, 1, cod_clienteA );
						resp_cur_datos:= dbms_sql.execute (cur_datos1);
						j1:=dbms_sql.fetch_rows(cur_datos1);
						if j1 = 0 then
						   cod_cliente1:= 0;
						else
						   dbms_sql.column_value (cur_datos1,1,cod_clienteA);
						   cod_cliente1:= cod_clienteA;
						end if;
				        dbms_sql.close_cursor (cur_datos1);
				  else
				      cod_cliente1 := identificacion;
				  end if;


				  loop


		                  if cod_cliente1 > 0 then
						       /* los abonados del cliente */
			     			   ssql1:= 'SELECT g1.num_celular celular, g1.num_abonado num_abonado, g1.cod_cliente cod_cliente ' ||
							           'FROM ga_abocel  g1, ga_usuarios g2 ' ||
									   'WHERE g1.cod_cliente = ' || Rtrim(Ltrim(cod_cliente1)) || ' ' ||
									   'AND g1.cod_usuario = g2.cod_usuario ' ;
									   --'AND g1.cod_situacion <> ' || c || 'BAA' || c || ' ' ||
									   if tip_identifica = 'A' then
	    								 ssql1:= ssql1 || 'AND g1.num_celular = ' ||   Rtrim(Ltrim(identificacion)) || ' ' ||
										         'AND g1.cod_situacion <> ' || c || 'BAA' || c || ' ';
									   else
									     ssql1:= ssql1 || 'AND g1.cod_situacion <> ' || c || 'BAA' || c || ' ';
									   end if;

							   ssql1:= ssql1 || 'UNION ALL ' ||
									   'SELECT g1.num_celular celular, g1.num_abonado num_abonado, g1.cod_cliente cod_cliente ' ||
							           'FROM ga_aboamist g1, ga_usuamist g2 ' ||
									   'WHERE g1.cod_cliente = ' || Rtrim(Ltrim(cod_cliente1)) || ' ' ||
									   'AND g1.cod_usuario = g2.cod_usuario ' ;
									   --'AND g1.cod_situacion <> ' || c || 'BAA' || c || ' ';
									   if tip_identifica = 'A' then
	    								 ssql1:= ssql1 || 'AND g1.num_celular = ' ||   Rtrim(Ltrim(identificacion)) || ' ' ||
										         'AND g1.cod_situacion <> ' || c || 'BAA' || c;
									   else
									     ssql1:= ssql1 || 'AND g1.cod_situacion <> ' || c || 'BAA' || c || ' ';
									   end if;

								        cur_datos1 := dbms_sql.open_cursor;
										dbms_sql.parse(cur_datos1,ssql1, DBMS_SQL.V7);
										dbms_sql.define_column(cur_datos1, 1, col_ncel );
										dbms_sql.define_column(cur_datos1, 2, col_abonado );
		                                resp_cur_datos:= dbms_sql.execute(cur_datos1);
										i1:=1;
									    loop
										  j1:=dbms_sql.fetch_rows(cur_datos1);
										  if j1 = 0 then
										     exit;
										  end if;
			    				          dbms_sql.column_value (cur_datos1,1,col_ncel);
										  dbms_sql.column_value (cur_datos1,2,col_abonado);

										  -- modificar select para que traiga g2.ind_comerc pero no sea restriccion en el where
										  -- abajo tomamos la desicion de considerarlo si es candidato a NO HABILITADO de lo contrario
										  -- se ignora esta condicion
										  if aplicacion <> 'W' then
											  ssql:= 'SELECT g1.cod_servsupl, g2.des_servicio,  TO_CHAR(g1.fec_bajabd, ' || c || 'DD-MM-YYYY' || c || '), TO_CHAR(g1.fec_bajacen, ' || c || 'DD-MM-YYYY' || c || '), g2.cod_aplic, g2.ind_comerc '  ||
													 'FROM ga_servsupl g2, ga_servsuplabo g1 ' ||
													 'WHERE g1.num_abonado  = ' || col_abonado || ' ' ||
													 'AND g1.cod_producto = g2.cod_producto ' ||
													 --'AND g2.IND_COMERC = 1 ' ||
													 'AND g1.cod_servicio = g2.cod_servicio ';
		                                  elsif aplicacion = 'W' then
											  ssql:= 'SELECT g1.cod_servsupl, substr(g2.des_servicio_web, 1,40),  TO_CHAR(g1.fec_bajabd, ' || c || 'DD-MM-YYYY' || c || '), TO_CHAR(g1.fec_bajacen, ' || c || 'DD-MM-YYYY' || c || '), g2.cod_aplic, g2.ind_comerc '  ||
													 'FROM ga_servsupl g2, ga_servsuplabo g1 ' ||
													 'WHERE g1.num_abonado  = ' || col_abonado || ' ' ||
													 'AND g1.cod_producto = g2.cod_producto ' ||
													 --'AND g2.IND_COMERC = 1 ' ||
													 'AND g1.cod_servicio = g2.cod_servicio ';
										  end if;
								          cur_datos := dbms_sql.open_cursor;
										  dbms_sql.parse(cur_datos,ssql, DBMS_SQL.V7);
										  dbms_sql.define_column_char(cur_datos, 1, col1,2 );
										  dbms_sql.define_column_char(cur_datos, 2, col2,40 );
										  dbms_sql.define_column_char(cur_datos, 3, col3 ,10);
										  dbms_sql.define_column_char(cur_datos, 4, col4 ,10);
										  dbms_sql.define_column_char(cur_datos, 5, col5 ,180);
										  dbms_sql.define_column(cur_datos, 6, col6);

		                                  resp_cur_datos:=dbms_sql.execute(cur_datos);
										  i:= 1;
										  loop
											  j:=dbms_sql.fetch_rows(cur_datos);
											  if j = 0 then
											     exit;
											  end if;
											  dbms_sql.column_value_char (cur_datos,1,col1);
										      dbms_sql.column_value_char (cur_datos,2,col2);
										      dbms_sql.column_value_char (cur_datos,3,col3);
											  dbms_sql.column_value_char (cur_datos,4,col4);
											  dbms_sql.column_value_char (cur_datos,5,col5);
											  dbms_sql.column_value (cur_datos,6,col6);

											  if NOT (col5 IS NULL) then
											     largo:= length(rtrim(col5));
												 L:= 1;
												 aceptado := 0;
												 loop
												    if L > largo then
													   exit;
													end if;
												    c1 := substr(col5,L,1);
													if c1 = substr(aplicacion,1,1) then
													   aceptado:= 1;
													   exit;
													end if;
													L:= L +1;
												 end loop;
												 if aceptado = 1 then
													  if col3 IS NULL and col4 IS NULL then
													     estado_serv(i):= 'HABILITADO';
													  else
													     if col6 = 1 then
													        estado_serv(i):= 'DESHABILITADO';
														 end if;
													  end if;
													  if NOT estado_serv(i) IS NULL then
													      if estado_serv(i) = 'HABILITADO' or (estado_serv(i) = 'DESHABILITADO' and col6 = 1) then
															  cod_cliente(i):= cod_cliente1;
															  celular(i):= col_ncel;
															  cod_serv(i):= col1;
															  descrip_serv(i):= col2;
														  end if;
													  end if;


													  i := i + 1;
												 end if;
											  end if;
										  end loop;
										  i1 := i1 +1;
									      dbms_sql.close_cursor(cur_datos);
										end loop;
										dbms_sql.close_cursor(cur_datos1);
						  end if;
						  if cod_cliente1 = 0 then
						     exit;
						  end if;
						  if tip_identifica = 'C' or tip_identifica = 'A' then
						     exit;
						  elsif tip_identifica = 'R' then
								j1:=dbms_sql.fetch_rows(cur_datos2);
								if j1 = 0 then
								   exit;
								else
								   dbms_sql.column_value (cur_datos2,1,cod_clienteA);
								   cod_cliente1:= cod_clienteA;
								end if;
						  end if;

				  end loop;
               end if;

        EXCEPTION
		        WHEN error_param THEN
				     error(n_error):= 'imposible continuar';
                WHEN OTHERS THEN

				     error(n_error):= TO_CHAR(SQLCODE);
					 error(n_error+1):= sqlerrm;

				     --dbms_output.put_line(TO_CHAR(SQLCODE) || ' ' || sqlerrm);
					 --dbms_sql.close_cursor(cur_datos);


		END;

		procedure CO_SERV_SUPLEMENTARIO_V2_RUT(
				                        identificacion in varchar2,
										--tip_identifica in varchar2,
										--aplicacion   in varchar2,
										cod_cliente    out t_cod_cliente_,
										--celular      out t_celular,
										cod_serv       out t_cod_serv,
										descrip_serv   out t_descrip_serv,
										estado_serv    out t_estado_serv,
										error          out t_error
										)IS

    	   error_param    Exception;
		   n_error        integer;
		   i 			  number(8);

		   cursor c1 is
		   		  	   	  	SELECT DISTINCT c.cod_cliente cod_cliente, b.cod_servicio cod_servicio, a.des_servicio des_servicio, a.cod_producto cod_producto, 'HABILITADO' Estado
							FROM ga_servsupl a, ga_servsuplabo b,
								 			 				   	 (
																	select b.cod_cliente cod_cliente, c.num_abonado num_abonado
																	from ga_cuentas a, ge_clientes b, ga_abocel c
																	where a.num_ident = identificacion
																	and b.cod_tipident = a.cod_tipident
																	and a.cod_tipident in ( '01', '02')
																	and a.cod_cuenta = b.cod_cuenta
																	and c.cod_cliente = b.cod_cliente
																	and c.cod_situacion <> 'BAA'
																 ) c
							WHERE b.fec_bajabd is null
							and b.fec_altabd is not null
							and b.num_abonado  =  c.num_abonado
							AND b.cod_producto = a.cod_producto
							AND b.cod_servicio = a.cod_servicio
							UNION ALL
							select distinct c.cod_cliente cod_cliente, a.cod_servicio cod_servicio, a.des_servicio des_servicio, a.cod_producto cod_producto, 'NO HABILITADO' Estado
							from ga_servsupl a, (
							SELECT DISTINCT c.cod_cliente cod_cliente, b.cod_servicio cod_servicio
							FROM ga_servsupl a, ga_servsuplabo b,
								 			 				   	 (
																	select b.cod_cliente cod_cliente, c.num_abonado num_abonado
																	from ga_cuentas a, ge_clientes b, ga_abocel c
																	where a.num_ident = identificacion
																	and b.cod_tipident = a.cod_tipident
																	and a.cod_tipident in ( '01', '02')
																	and a.cod_cuenta = b.cod_cuenta
																	and c.cod_cliente = b.cod_cliente
																	and c.cod_situacion <> 'BAA'
																 ) c
							WHERE b.fec_bajabd is null
							and b.fec_altabd is not null
							and b.num_abonado  =  c.num_abonado
							AND b.cod_producto = a.cod_producto
							AND b.cod_servicio = a.cod_servicio
							) c
							where a.ind_comerc = 1
							and a.cod_servicio <> c.cod_servicio
							and a.cod_producto = 1;

		BEGIN
		        i:= 1;
				/*if tip_identifica <> 'R' then
				   error (n_error):= 'Tipo de identificacion puede ser R ';
				   n_error:= n_error +1;
				   raise error_param;
				end if;*/
				FOR L in c1 LOOP
				    if L.cod_producto = 1 then
						cod_cliente(i):= L.cod_cliente;
						cod_serv(i):= L.cod_servicio;
						descrip_serv(i):= L.des_servicio;
						estado_serv(i):= L.estado;
						i:= i +1;
					end if;
				END LOOP;


        EXCEPTION
		        WHEN error_param THEN
				     error(n_error):= 'imposible continuar';
                WHEN OTHERS THEN

				     error(n_error):= TO_CHAR(SQLCODE);
					 error(n_error+1):= sqlerrm;

		END;


		--Desarrollado por Fernando Garcia E.
		PROCEDURE CO_HDSS
				  (
				   identificacion 	 in varchar2,
				   t_identifica		 in varchar2,
				   cod_serv			 in varchar2,
				   accion			 in varchar2,
				   des_diaesp		 in varchar2,
				   dia				 in varchar2,
				   f_family			 in varchar2,
				   cliente			 out t_cod_cliente_,
				   abonado 			 out t_abonado_,
				   observacion		 out t_observ,
				   error			 out t_error
				  )
				  IS

		  cursor clientes is
		     select num_abonado
			 from ga_abocel
			 where cod_cliente = to_number(identificacion,'999999')
			 and cod_producto = 1
			 and cod_situacion <> 'BAA';

		  cursor cuentas is
		    select a.num_abonado, a.cod_cliente
			from ga_abocel a, ge_clientes b, ga_cuentas c
			where a.COD_CLIENTE= b.cod_cliente
			and a.cod_situacion <> 'BAA'
			and cod_producto = 1
			and b.cod_cuenta = c.cod_cuenta
			and c.num_ident = identificacion
			order by a.cod_cliente, a.num_abonado;

		  error_param    Exception;
		  n_error 	     integer;
		  i				 integer;
		  c_filas		 integer;
		BEGIN

		  i:= 1;
		  if not t_identifica in ('C','R','A') then
			 error (n_error):= 'Parametro T_identifica debe ser  R,C o A';
			 n_error:= n_error +1;
			 raise error_param;
		  end if;

		  if not accion in ('A','D') then
			 error (n_error):= 'Parametro accion debe ser  A o D';
			 n_error:= n_error +1;
			 raise error_param;
		  end if;

		  if t_identifica = 'A' then
		  	 CO_MOD_SERV_SUPLEM (identificacion,t_identifica,cod_serv,accion,des_diaesp,dia,f_family,c_filas,error);
			 abonado(i):= identificacion;
			 observacion(i):= '[Procesado]';
		  elsif t_identifica = 'C' then
		  	 for L in clientes loop
			     CO_MOD_SERV_SUPLEM (L.num_abonado,'A',cod_serv,accion,des_diaesp,dia,f_family,c_filas,error);
				 cliente(i):= identificacion;
				 abonado(i):= L.num_abonado;
				 observacion(i):= '[Procesado]';
				 i:= i +1;
			 end loop;

		  elsif t_identifica = 'R' then
		  	 for L in cuentas loop
			     CO_MOD_SERV_SUPLEM (L.num_abonado,'A',cod_serv,accion,des_diaesp,dia,f_family,c_filas,error);
				 cliente(i):= L.cod_cliente;
				 abonado(i):= L.num_abonado;
				 observacion(i):= '[Procesado]';
 				 i:= i +1;
			 end loop;

		  end if;

		EXCEPTION
		        WHEN error_param THEN
				     error(n_error):= 'imposible continuar';
		        WHEN OTHERS THEN

				     error(n_error):= TO_CHAR(SQLCODE);
					 error(n_error+1):= sqlerrm;

		END	CO_HDSS;

		--Desarrollado por Fernando Garcia E.
		PROCEDURE CO_MOD_SERV_SUPLEM
				  (
				   identificacion 	 in varchar2,
				   t_identifica		 in varchar2,
				   cod_serv			 in varchar2,
				   accion			 in varchar2,
				   des_diaesp		 in varchar2,
				   dia				 in varchar2,
				   f_family			 in varchar2,
   				   n_filas			 out integer,
				   error			 out t_error
				  )
				  IS

		/*
		1 = Dias Especiales
		2 = Codigo Friend
		3 = Numero maximo de dias especiales por abonado
		4 = Numero maximo de numeros especiles por abonado
		5=  Codigo de tipo de dia para dias especiales celular
		6=  Codigo de servicio de cargo de conexion celular
		7=  Codigo de servicio detalle llamadas celular
		*/
		/*             1               2           3            4              5              6            7         */

		--cursor c1 IS
		--	SELECT COD_DIASESPCEL, COD_FYFCEL, NUM_DIASESP, NUM_TELESP, COD_TIPDIACEL, COD_SERCONEXCEL, COD_DETCEL
		--	FROM GA_DATOSGENER;

		type  DescDiasEspec_   is table of varchar2(100) INDEX BY BINARY_INTEGER;
		type  DiasEspec_ 	   is table of varchar2(20) INDEX BY BINARY_INTEGER;
		type  Friend_Family_  is table of varchar2(15) INDEX BY BINARY_INTEGER;

		largo	 	   integer;
		num_datos	   integer;
		i		  	   integer;
		i_max 		   integer;
		old_i		   integer;
		next_dato	   integer;
		piv_char	   varchar2(1);
		DescDiasEspec  DescDiasEspec_;
		DiasEspec	   DiasEspec_;
		Friend_Family  Friend_Family_;

   	    error_param    Exception;
		n_error 	   integer;
		n_servicios	   integer;
		cod_serv_icc   number(2);
		cod_nivel1	   number(4);
		f_altabd	   date;

		cod_serv_icc_A number(2);
		cod_nivel_A	   number(4);


		estado 		   varchar2(15);
		ssql_lleno	   varchar2(1400);
		ssql_vacio     varchar2(1400);
		ssql_valida	   varchar2(1400);

		cod_1		   varchar2(3);
		cod_2		   varchar2(3);
		cod_3		   number(2);
		cod_4		   number(2);
		cod_5		   varchar2(2);
		cod_6		   varchar2(3);
		cod_7		   varchar2(3);

		concepto_fa	   number(4);

		celular		   ga_abocel.NUM_CELULAR%type;
		cod_central1   ga_abocel.COD_CENTRAL%type;
		NumSerieHex1   ga_abocel.NUM_SERIEHEX%type;
		TipTerminal1   ga_abocel.TIP_TERMINAL%type;
		nummin1		   ga_abocel.NUM_MIN%type;
		CodCliente1	   ga_abocel.COD_CLIENTE%type;
		v_numdiasnum   ga_servsuplabo.NUM_DIASNUM%type;
		CodPlanCom1	   ga_cliente_pcom.COD_PLANCOM%TYPE;

		validador	   number;
		cod_serv_old   ga_servsuplabo.COD_SERVICIO%type;

		cur_din_1	   integer;
		rows_return	   integer;
		c			   varchar2(1);
		cadena_cambio  varchar2(1400);
		cadena_total   varchar2(1400);

		v_cod_actcen   number;
		cod_movimiento number;

		c_filas		   integer;

		vcod_retorno   number(1);
		vdes_cadena    varchar2(255);

		/*  Determinar si el servicio consiste en activar un detalle en la cuenta */
		--CURSOR c2 is
		--	SELECT COD_SERVICIO
		--	FROM GA_GRUPOS_SERVSUP
		--	WHERE COD_GRUPO =  'DETLLAM'
		--	AND COD_SERVICIO = cod_serv
		--	AND (   (SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA) OR (FEC_HASTA IS NULL AND FEC_DESDE < SYSDATE) );


		CURSOR C3 IS
			SELECT GA_SEQ_NUMDIASNUM .NEXTVAL FROM DUAL;


		CURSOR C4 IS
			SELECT ICC_SEQ_NUMMOV .NEXTVAL FROM DUAL;

		BEGIN
            vcod_retorno:= 1;
			n_error:= 1;
		    c:= chr(39);
		    --validar parametros de entrada al PL
			if not (t_identifica in ('R', 'C', 'A')) then
			   error (n_error):= 'Tipo de identificacion puede ser R, C o A';
			   n_error:= n_error +1;
			   raise error_param;
			   c_filas:= c_filas +1;
			end if;
			if not (accion in ('A', 'D')) then
			   error (n_error):= 'Accion no permitida, usar A = activar, D= Desactivar';
			   n_error:= n_error +1;
			   raise error_param;
			   c_filas:= c_filas +1;
			end if;

			if length (cod_serv) > 3 then
			   error (n_error):= 'Maximo 3 digitos';
			   n_error:= n_error +1;
			   raise error_param;
			   c_filas:= c_filas +1;
			end if;


			--verificar que el codigo de servicio suplementario es valido
			if accion = 'A' then
			   select count(*) into n_servicios from ga_servsupl where cod_servicio = cod_serv and ind_comerc = 1 and cod_producto = 1;
			elsif accion = 'D' then
			   select count(*) into n_servicios from ga_servsupl where cod_servicio = cod_serv and cod_producto = 1;
			end if;

			if n_servicios is null then
			   error (n_error):= 'El servicio no existe o no es comercializable';
			   n_error:= n_error +1;
			   c_filas:= c_filas +1;
			   raise error_param;
			end if;

			if n_servicios = 0 then
			   error (n_error):= 'El servicio no existe o no es comercializable';
			   n_error:= n_error +1;
			   c_filas:= c_filas +1;
			   raise error_param;
			end if;

		    -- Rescatar codigos para servicios especiales
   		    SELECT COD_DIASESPCEL, COD_FYFCEL, NUM_DIASESP, NUM_TELESP, COD_TIPDIACEL, COD_SERCONEXCEL, COD_DETCEL
		    INTO   cod_1,          cod_2,      cod_3,       cod_4,      cod_5,         cod_6,           cod_7
		    FROM GA_DATOSGENER;

			--Verificar si el servicio debe ser facturado

			BEGIN --B2
				SELECT COD_CONCEPTO
				INTO concepto_fa
				FROM GA_ACTUASERV
				WHERE COD_SERVICIO = cod_serv
				AND COD_PRODUCTO = 1
				AND COD_ACTABO = 'FA';
			EXCEPTION
			    WHEN OTHERS THEN
				concepto_fa:= null;
				error(n_error):= '[ERROR B2]';
				n_error:= n_error+1;
				c_filas:= c_filas +1;
			END; --B2

			--Rescatar valores del servicio en icc en caso de activacion
			BEGIN --B3
				SELECT cod_servsupl, cod_nivel
				INTO cod_serv_icc_A, cod_nivel_A
				FROM GA_SERVSUPL
				WHERE IND_COMERC = 1
				AND cod_servicio = cod_serv
				AND cod_producto = 1;
			EXCEPTION
			    WHEN NO_DATA_FOUND  THEN
					cod_serv_icc_A:= null;
					cod_nivel_A:= null;
					error(n_error):= '[ERROR B3]';
					n_error:= n_error+1;
					c_filas:= c_filas +1;

			    WHEN OTHERS THEN
				error(n_error):= '[ERROR B3]';
				n_error:= n_error+1;
				c_filas:= c_filas +1;
				raise error_param;
			END; --B3
			error(n_error):= '[cod_serv_icc_A = ' || to_char(cod_serv_icc_A,'99') || ']';
			n_error:= n_error+1;
			c_filas:= c_filas +1;
			--verificar si el servicio a sido asignado


			--VERSION3
  			BEGIN -- B1

				select g1.FEC_ALTABD fecha, g1.COD_SERVSUPL, g1.COD_NIVEL, g1.COD_SERVICIO
				INTO f_altabd,cod_serv_icc, cod_nivel1, cod_serv_old
				from ga_servsupl g2, ga_servsuplabo g1
				where g1.num_abonado = identificacion
				and g1.cod_producto = g2.cod_producto
				and g1.cod_servicio = g2.cod_servicio
				and g1.cod_servsupl= cod_serv_icc_A
				and g1.fec_bajabd is null;

			EXCEPTION
			    WHEN NO_DATA_FOUND  THEN
				  f_altabd := NULL;
				  cod_serv_icc:= NULL;
				  cod_nivel1:= NULL;
				  cod_serv_old:= NULL;
				  error (n_error):= '[ERROR B1]';
				  n_error:= n_error +1;
				  c_filas:= c_filas +1;

			    WHEN OTHERS THEN
				  error (n_error):= '[ERROR B1]';
				  raise error_param;
				  n_error:= n_error +1;
				  c_filas:= c_filas +1;
			END; --B1
			error (n_error):= '[cod_serv_old=' || cod_serv_old || ']';
		    n_error:= n_error +1;
			c_filas:= c_filas +1;

			--Obtener datos del abonado
			SELECT a.NUM_CELULAR, a.COD_CENTRAL, a.NUM_SERIEHEX, a.TIP_TERMINAL,a.NUM_MIN,a.COD_CLIENTE, a.CLASE_SERVICIO
			INTO celular, cod_central1, NumSerieHex1, TipTerminal1, nummin1,CodCliente1, cadena_total
			FROM GA_ABOCEL a
			WHERE a.NUM_ABONADO = identificacion;

			--Obtener el codigo del plan comercial contratado por el cliente de este abonado
			SELECT COD_PLANCOM
			INTO CodPlanCom1
			FROM GA_CLIENTE_PCOM
			WHERE COD_CLIENTE = CodCliente1
			AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE);

			validador:= Null;
			if cod_serv_icc is null and cod_nivel1 is null then
			   /*servicio no se encuentra asigando ni otro en el mismo grupo de la central*/
			   estado := 'VACIO';
			else
			   estado:= 'LLENO';
			   if cod_nivel1 = 0 then
			      estado:= 'DESACTIVADO';
			   end if;
			end if;

			set transaction read write;
			error (n_error):= '[set transaccion read write] [estado =' || estado || ']';
			n_error:= n_error +1;
			c_filas:= c_filas +1;

			if not cod_serv_old is null then
			   if cod_serv_old = cod_serv and accion = 'A' then
			      error (n_error):= 'Servicio ya esta activado';
				  n_error:= n_error +1;
				  raise error_param;
				  c_filas:= c_filas +1;
			   end if;

			end if;

			if accion = 'A' then


				if estado = 'VACIO' then

				   /*                                            1              2           3            4            5           6              7           8                  9    */
	               sSql_vacio := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';


				   If  cod_serv = cod_1 Or cod_serv = cod_2 Then
				                                     /*    10   */
	                    sSql_vacio := sSql_vacio || ', NUM_DIASNUM ';
	               End If;

	               If not concepto_fa is null Then
				                                      /*    11     */
	                   sSql_vacio := sSql_vacio || ', COD_CONCEPTO';
	               End If;


	               sSql_vacio := sSql_vacio || ')  VALUES (' ||
				   /*                     1                        2                 3              4                          5                    6            7        8                9       */
	                             identificacion || ',' || c || cod_serv || c || ', sysdate, ' || cod_serv_icc_A || ', ' || cod_nivel_A || ', ' || celular || ',  1,       1,' || c || 'INTERNET' || c;
				   if cod_serv in (cod_1, cod_2) then
				   	  --capturo el correlativo numdiasnum
					  IF NOT C3%ISOPEN THEN
					     open c3;
					  END IF;
					  fetch c3 into v_numdiasnum;
					  if c3%FOUND then
					                                      /*      10     */
					     sSql_vacio := sSql_vacio || ', ' || v_numdiasnum;
					  end if;
				   end if;
	               If not concepto_fa is null Then
					                                      /*    11   */
	                   sSql_vacio := sSql_vacio || ',' || concepto_fa;
	               End If;
				   sSql_vacio := sSql_vacio || ')';
					error (n_error):= '[sSql_vacio = ]';
					n_error:= n_error +1;
					c_filas:= c_filas +1;
					error (n_error):= substr(sSql_vacio,1,10) ;
					n_error:= n_error +1;
					c_filas:= c_filas +1;

					cur_din_1:= dbms_sql.OPEN_CURSOR;
					dbms_sql.PARSE(cur_din_1,sSql_vacio,dbms_sql.v7);
					rows_return:= dbms_sql.EXECUTE(cur_din_1);
					dbms_sql.CLOSE_CURSOR(cur_din_1);

					error (n_error):= '[fin vacio]';
					n_error:= n_error +1;
					c_filas:= c_filas +1;

				end if;


				if estado = 'LLENO' then

					error (n_error):= '[IF LLENO]';
					n_error:= n_error +1;
					c_filas:= c_filas +1;

				   --como el servicio existe en la central se debe de dar de baja en siscel primero
	               sSql_lleno := 'UPDATE GA_SERVSUPLABO SET ' ||
	                      	  	 'FEC_BAJABD = SYSDATE, IND_ESTADO = 3 ' ||
								 'WHERE NUM_ABONADO = ' || identificacion || ' ' ||
	                       		 'AND COD_SERVSUPL = ' || to_char(cod_serv_icc,'99') || ' ' ||
	                       		 'AND FEC_BAJABD IS NULL ';


					error (n_error):= '[DEFINIDO sSql_lleno]';
					n_error:= n_error +1;
					c_filas:= c_filas +1;


					error (n_error):= substr(sSql_lleno,1,20);
					n_error:= n_error +1;
					c_filas:= c_filas +1;

				   /*                                             1              2           3            4            5           6              7           8            9*/
	               sSql_vacio := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO , NOM_USUARORA';
				   If  cod_serv = cod_1 Or cod_serv = cod_2 Then
				                                     /*    10   */
	                    sSql_vacio := sSql_vacio || ', NUM_DIASNUM ';
	               End If;
	               If not concepto_fa is null Then
				                                      /*    11     */
	                   sSql_vacio := sSql_vacio || ', COD_CONCEPTO';
	               End If;
	               sSql_vacio := sSql_vacio || ')  VALUES (' ||
				   /*                     1                       2                  3              4                          5                    6            7        8              9      */
	                             identificacion || ',' || c || cod_serv || c || ', sysdate, ' || cod_serv_icc_A || ', ' || cod_nivel_A || ', ' || celular || ',  1,       1,' || c || 'INTERNET' || c;
				   if cod_serv in (cod_1, cod_2) then

				   	  --capturo el correlativo numdiasnum
					  IF NOT C3%ISOPEN THEN
					     open c3;
					  END IF;
					  fetch c3 into v_numdiasnum;
					  if c3%FOUND then
					     sSql_vacio := sSql_vacio || ', ' || v_numdiasnum;
					  end if;
				   end if;
	               If not concepto_fa is null Then
	                   sSql_vacio := sSql_vacio || ',' || concepto_fa;
	               End If;
				   sSql_vacio := sSql_vacio || ')';

					error (n_error):= '[DEFINIDO sSql_vacio]';
					n_error:= n_error +1;
					c_filas:= c_filas +1;

					error (n_error):= substr(sSql_vacio,1,20);
					n_error:= n_error +1;
					c_filas:= c_filas +1;

					cur_din_1:= dbms_sql.OPEN_CURSOR;
					dbms_sql.PARSE(cur_din_1,sSql_lleno,dbms_sql.v7);
					rows_return:= dbms_sql.EXECUTE(cur_din_1);
					dbms_sql.CLOSE_CURSOR(cur_din_1);
					error (n_error):= '[sSql_lleno = ' || substr(sSql_lleno,1,20) || '][ejecutado]';
					n_error:= n_error +1;
					c_filas:= c_filas +1;

					cur_din_1:= dbms_sql.OPEN_CURSOR;
					dbms_sql.PARSE(cur_din_1,sSql_vacio,dbms_sql.v7);
					rows_return:= dbms_sql.EXECUTE(cur_din_1);
					dbms_sql.CLOSE_CURSOR(cur_din_1);
					error (n_error):= '[sSql_vacio = ' || substr(sSql_vacio,1,20) || '][ejecutado]';
					n_error:= n_error +1;
					c_filas:= c_filas +1;

				end if;

				if estado = 'DESACTIVADO' then
				   /*                                             1              2           3            4            5           6              7           8              9*/
	               sSql_vacio := 'INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO, FEC_ALTABD, COD_SERVSUPL, COD_NIVEL, NUM_TERMINAL, COD_PRODUCTO,  IND_ESTADO, NOM_USUARORA ';


				   If  cod_serv = cod_1 Or cod_serv = cod_2 Then
				                                     /*    10   */
	                    sSql_vacio := sSql_vacio || ', NUM_DIASNUM ';
	               End If;

	               If not concepto_fa is null Then
				                                      /*    11     */
	                   sSql_vacio := sSql_vacio || ', COD_CONCEPTO';
	               End If;


	               sSql_vacio := sSql_vacio || ')  VALUES (' ||
				   /*                     1                        2                 3              4                          5                    6            7        8               9        */
	                             identificacion || ',' || c || cod_serv || c || ', sysdate, ' || cod_serv_icc_A || ', ' || cod_nivel_A || ', ' || celular || ',  1,       1,' || c || 'INTERNET' || c;
				   if cod_serv in (cod_1, cod_2) then
				   	  --capturo el correlativo numdiasnum
					  IF NOT C3%ISOPEN THEN
					     open c3;
					  END IF;
					  fetch c3 into v_numdiasnum;
					  if c3%FOUND then
					     sSql_vacio := sSql_vacio || ', ' || v_numdiasnum;
					  end if;

				   end if;
	               If not concepto_fa is null Then
	                   sSql_vacio := sSql_vacio || ',' || concepto_fa;
	               End If;
				   sSql_vacio := sSql_vacio || ');';
				   cur_din_1:= dbms_sql.OPEN_CURSOR;
				   dbms_sql.PARSE(cur_din_1,sSql_vacio,dbms_sql.v7);
				   rows_return:= dbms_sql.EXECUTE(cur_din_1);
				   dbms_sql.CLOSE_CURSOR(cur_din_1);
				   error (n_error):= '[sSql_vacio = ' || substr(sSql_vacio,1,20) || '][ejecutado]';
				   n_error:= n_error +1;
				   c_filas:= c_filas +1;
				 end if;--ojo

					/* validar dias especiales */

	  			   if cod_serv = cod_1 then
				   	   next_dato:= 1;
					   largo := length(des_diaesp);
					   num_datos:= 0;
					   i:= 1;
					   old_i:= 0;
					   loop
					     if i > largo then
						    num_datos:= num_datos +1;
							if old_i = 0 then
							   DescDiasEspec(next_dato):= substr(des_diaesp,1,i-1);
							else
							   DescDiasEspec(next_dato):= substr(des_diaesp,old_i+1,i-old_i-1);
							end if;
						    exit;
						 end if;
					     piv_char:=substr(des_diaesp,i,1);
					     if piv_char = ',' then
						    num_datos:= num_datos +1;
							if old_i = 0 then
							   DescDiasEspec(next_dato):= substr(des_diaesp,1,i-1);
							else
							   DescDiasEspec(next_dato):= substr(des_diaesp,old_i+1,i-old_i-1);
							end if;
							next_dato:= next_dato +1;
							old_i := i;
						 end if;
					     i:= i +1;
					   end loop;

				   	   next_dato:= 1;
					   largo := length(dia);
					   i:= 1;
					   old_i:= 0;
					   loop
					     if i > largo then
						    num_datos:= num_datos +1;
							if old_i = 0 then
							   DiasEspec(next_dato):= substr(dia,1,i-1);
							else
							   DiasEspec(next_dato):= substr(dia,old_i+1,i-old_i-1);
							end if;
						    exit;
						 end if;
					     piv_char:=substr(dia,i,1);
					     if piv_char = ',' then
							if old_i = 0 then
							   DiasEspec(next_dato):= substr(dia,1,i-1);
							else
							   DiasEspec(next_dato):= substr(dia,old_i+1,i-old_i-1);
							end if;
							next_dato:= next_dato +1;
							old_i := i;
						 end if;
					     i:= i +1;
					   end loop;

					   i:= 1;
					   loop
					   	if i = num_datos then
						   exit;
						end if;
						ssql_valida := 'INSERT INTO GA_DIASABO ' ||
									  /*     1             2           3           4           5            6       */
	          						  '(NUM_ABONADO, COD_PRODUCTO, COD_TIPDIA, DES_DIAESP, FEC_DIAESP, NUM_DIASNUM ' ||
									  ' ) VALUES ( ' ||
									   /*     1               2                  3                                4                                                  5                                                             6          */
								   identificacion || ', ' || 1 || ', ' || c || cod_serv || c || ', ' || c || DescDiasEspec(i) || c || ', ' || 'TO_DATE(' || c || DiasEspec(i) || c || ' , ' ||  c || 'DD-MM-YYYY' || c || '), ' || v_numdiasnum  || ') ';

						error(n_error):= ssql_valida;
						n_error:= n_error+1;

						error(n_error):= DescDiasEspec(i);
						n_error:= n_error+1;

						/* Ejecutar query */
						cur_din_1:= dbms_sql.OPEN_CURSOR;
						dbms_sql.PARSE(cur_din_1,ssql_valida,dbms_sql.v7);
						rows_return:= dbms_sql.EXECUTE(cur_din_1);
						dbms_sql.CLOSE_CURSOR(cur_din_1);
						i:=i+1;
					   end loop;
					end if;
					--capturo el correlativo validador
					IF NOT C3%ISOPEN THEN
					   open c3;
					END IF;
					fetch c3 into validador;
					if c3%FOUND then
					   p_interfases_abonados(TO_CHAR(validador),'SS','1',identificacion,'2','1','');
					   begin --c1
					     select cod_retorno, des_cadena
						 into vcod_retorno, vdes_cadena
						 from ga_transacabo
						 where num_transaccion = validador;

						 delete ga_transacabo where num_transaccion = validador;
					   EXCEPTION
					   when others then
					     vcod_retorno:= null;
						 vdes_cadena:= null;
						 error(n_error):= 'falla interface abonado';
						 n_error:= n_error+1;
						 raise error_param;
					   end; --c1

					end if;
					/* fin validar dias especiales */


					/* validar friend  */
					if cod_serv = cod_2 then
				   	   next_dato:= 1;
					   num_datos:= 0;
					   largo := length(f_family);
					   i:= 1;
					   old_i:= 0;
					   loop
					     if i > largo then
						    num_datos:= num_datos +1;
							if old_i = 0 then
							   friend_family(next_dato):= substr(f_family,1,i-1);
							else
							   friend_family(next_dato):= substr(dia,old_i+1,i-old_i-1);
							end if;
						    exit;
						 end if;
					     piv_char:=substr(dia,i,1);
					     if piv_char = ',' then
							if old_i = 0 then
							   friend_family(next_dato):= substr(f_family,1,i-1);
							else
							   friend_family(next_dato):= substr(f_family,old_i+1,i-old_i-1);
							end if;
							next_dato:= next_dato +1;
							old_i := i;
						 end if;
					     i:= i +1;
					   end loop;

					   i:= 1;
					   loop
					     if i = num_datos then
						    exit;
						 end if;
				         ssql_valida:= 'INSERT INTO GA_NUMESPABO ' ||
						 			   /*      1           2             3         */
						               '(NUM_ABONADO, NUM_TELEFESP, NUM_DIASNUM ' ||
				         			  	' ) VALUES ( ' ||
										/*     1                     2                              3          */
										identificacion || ', ' || c || friend_family(i) || c || ', ' ||  v_numdiasnum || ') ';
						 /* Ejecutar query */
						 cur_din_1:= dbms_sql.OPEN_CURSOR;
						 dbms_sql.PARSE(cur_din_1,ssql_valida,dbms_sql.v7);
						 rows_return:= dbms_sql.EXECUTE(cur_din_1);
						 dbms_sql.CLOSE_CURSOR(cur_din_1);
					   end loop;
		 			end if;

					IF NOT C3%ISOPEN THEN
					   open c3;
					END IF;
					fetch c3 into validador;
					if c3%FOUND then
					   p_interfases_abonados(TO_CHAR(validador),'SS','1',identificacion,'2','1','');
					   begin --c1
					     select cod_retorno, des_cadena
						 into vcod_retorno, vdes_cadena
						 from ga_transacabo
						 where num_transaccion = validador;

						 delete ga_transacabo where num_transaccion = validador;
					   EXCEPTION
					   when others then
					     vcod_retorno:= null;
						 vdes_cadena:= null;
						 error(n_error):= 'falla interface abonado';
						 n_error:= n_error+1;
						 raise error_param;
					   end; --c1

					end if;


					/* fin validar friend  */

					/* validar DETALLE DE LLAMADOS */

					if cod_serv = cod_7 then
						IF NOT C3%ISOPEN THEN
						   open c3;
						END IF;
						fetch c3 into validador;
						if c3%FOUND then
						   p_interfases_abonados(TO_CHAR(validador),'SS','1',identificacion,'3','1','');
						   begin --c1
						     select cod_retorno, des_cadena
							 into vcod_retorno, vdes_cadena
							 from ga_transacabo
							 where num_transaccion = validador;

							 delete ga_transacabo where num_transaccion = validador;
						   EXCEPTION
						   when others then
						     vcod_retorno:= null;
							 vdes_cadena:= null;
							 error(n_error):= 'falla interface abonado';
							 n_error:= n_error+1;
							 raise error_param;
						   end; --c1

						end if;
					end if;

					/* fin validar DETALLE DE LLAMADOS */

				--end if;

			elsif accion = 'D' then
			    if estado = 'LLENO' or estado = 'DESACTIVADO' then
	               sSql_lleno := 'UPDATE GA_SERVSUPLABO SET ' ||
	                      	  	 'FEC_BAJABD = SYSDATE, IND_ESTADO = 3 ' ||
								 'WHERE NUM_ABONADO = ' || identificacion || ' ' ||
	                       		 'AND COD_SERVSUPL = ' || to_char(cod_serv_icc,'99') || ' ' ||
						   		 --'AND FEC_ALTABD = ' || f_altabd || ' ' ||
	                       		 'AND FEC_BAJABD IS NULL ';

					cur_din_1:= dbms_sql.OPEN_CURSOR;
					dbms_sql.PARSE(cur_din_1,sSql_lleno,dbms_sql.v7);
					rows_return:= dbms_sql.EXECUTE(cur_din_1);
					dbms_sql.CLOSE_CURSOR(cur_din_1);
				end if;

				/* validar dias especiales*/
				if cod_serv = cod_1 then
				   IF NOT C3%ISOPEN THEN
					   open c3;
					END IF;
					fetch c3 into validador;
					if c3%FOUND then
					   p_interfases_abonados(TO_CHAR(validador),'SS','1',identificacion,'2','0','');
					   begin --c1
					     select cod_retorno, des_cadena
						 into vcod_retorno, vdes_cadena
						 from ga_transacabo
						 where num_transaccion = validador;

						 delete ga_transacabo where num_transaccion = validador;
					   EXCEPTION
					   when others then
					     vcod_retorno:= null;
						 vdes_cadena:= null;
						 error(n_error):= 'falla interface abonado';
						 n_error:= n_error+1;
						 raise error_param;
					   end; --c1

					   DELETE GA_DIASABO WHERE NUM_ABONADO = identificacion;
					end if;
				end if;
				/* fin validar dias especiales*/

				/*validar friend */
				if cod_serv = cod_2 then
				   IF NOT C3%ISOPEN THEN
					   open c3;
					END IF;
					fetch c3 into validador;
					if c3%FOUND then
					   DELETE GA_NUMESPABO WHERE NUM_ABONADO = identificacion;
					   p_interfases_abonados(TO_CHAR(validador),'SS','1',identificacion,'1','0','');
					   begin --c1
					     select cod_retorno, des_cadena
						 into vcod_retorno, vdes_cadena
						 from ga_transacabo
						 where num_transaccion = validador;

						 delete ga_transacabo where num_transaccion = validador;
					   EXCEPTION
					   when others then
					     vcod_retorno:= null;
						 vdes_cadena:= null;
						 error(n_error):= 'falla interface abonado';
						 n_error:= n_error+1;
						 raise error_param;
					   end; --c1

					end if;
				end if;
				/*fin validar friend */

				/*validar detalle de llamadas*/
				if cod_serv = cod_7 then
				   IF NOT C3%ISOPEN THEN
					   open c3;
					END IF;
					fetch c3 into validador;
					if c3%FOUND then
				   	   p_interfases_abonados(TO_CHAR(validador),'SS','1',identificacion,'3','0','');
					   begin --c1
					     select cod_retorno, des_cadena
						 into vcod_retorno, vdes_cadena
						 from ga_transacabo
						 where num_transaccion = validador;

						 delete ga_transacabo where num_transaccion = validador;
					   EXCEPTION
					   when others then
					     vcod_retorno:= null;
						 vdes_cadena:= null;
						 error(n_error):= 'falla interface abonado';
						 n_error:= n_error+1;
						 raise error_param;
					   end; --c1
					end if;
				end if;
				/*fin detalle de llamadas*/



			end if;

			--crear cadena con todos los servivios del abonado y actualizar ga_abocel
			if not cod_serv_icc is null and not cod_nivel1 is null then
 			   cadena_cambio:= substr('00' || cod_serv_icc,length('00' || cod_serv_icc)-2,2) || substr('0000' || cod_nivel1,length('0000' || cod_nivel1)-4,2);
			   i:= 0;
			   i_max:= length(cadena_total)/6;
			   loop
			        if i> i_max then
					   exit;
					end if;
			   	   	if substr(cadena_total,6*i+1,6*(i+1)) = cadena_cambio then
					   if i= 0 then
					   	  cadena_total:= substr(cadena_total,1*6+1,length(cadena_total)-6);
					   elsif i = i_max then
					   	  cadena_total:= substr(cadena_total,1,length(cadena_total)-6);
					   else
					   	  cadena_total:= substr(cadena_total,1,6*(i-1+1)) || substr(cadena_total,6*(i+1)+1,6*(i_max+1));
					   end if;
					end if;
					i:= i +1;
			   end loop;
			end if;
			/*Insertar los movimientos en la central*/
			cadena_cambio:= substr('00' || cod_serv_icc_A,length('00' || cod_serv_icc_A)-2,2) || substr('0000' || cod_nivel_A,length('0000' || cod_nivel_A)-4,2);
			cadena_total:= cadena_total || cadena_cambio;
			update ga_abocel set clase_servicio = cadena_total where num_abonado = identificacion;
			if not c4%ISOPEN then
			   OPEN c4;
			end if;
			FETCH C4 INTO cod_movimiento;
			if c4%FOUND then
			   error (n_error):= '[ejecuto cursor c4]';
			   n_error:= n_error +1;
			   c_filas:= c_filas +1;
			   SELECT COD_ACTCEN INTO v_cod_actcen FROM GA_ACTABO WHERE COD_ACTABO = 'SS' AND COD_PRODUCTO = 1;
			    ssql_valida:= 'INSERT INTO ICC_MOVIMIENTO (' ||
				              /*     1             2            3           4           5           6              7             8            9            10         11             12          13          14            15          16    */
							  'NUM_MOVIMIENTO, NUM_ABONADO, NUM_CELULAR, COD_ESTADO, COD_MODULO, COD_ACTUACION, NOM_USUARORA, FEC_INGRESO, COD_CENTRAL, NUM_SERIE, COD_SERVICIOS, NUM_MOVANT, NUM_MOVPOS, TIP_TERMINAL, COD_ACTABO, NUM_MIN' ||
			     			  ') VALUES (' ||
							  /*     1                         2                         3           4             5                      6                            7                    8              9                             10                                 11                      12    13                   14                             15                         16   */
			                     Cod_Movimiento || ', ' || identificacion  || ', ' || celular || ',  1,' || c ||  'GA' || c || ',' || v_cod_actcen || ', ' || c || 'INTERNET' || c || ' , SYSDATE, ' ||  cod_Central1 || ', ' || c || NumSeriehex1 || c || ', ' || c ||  cadena_cambio || c || ',  NULL, NULL, ' || c || TipTerminal1 || c || ' , ' ||  c || 'SS' || c || ', ' ||  c || nummin1 || c ||
			   				  ')';
				cur_din_1:= dbms_sql.OPEN_CURSOR;
				dbms_sql.PARSE(cur_din_1,sSql_valida,dbms_sql.v7);
				rows_return:= dbms_sql.EXECUTE(cur_din_1);
				dbms_sql.CLOSE_CURSOR(cur_din_1);
			    error (n_error):= '[ejecuto insert icc]';
			    n_error:= n_error +1;
				c_filas:= c_filas +1;

			end if;
			/* en oracle 8 es posible mandar a ejcutar los movimientos  a la icc invocar ICSERVD MOV:N?mov:1(cod-producto)*/
			error (n_error):= '[antes de commit]';
			n_error:= n_error +1;
			c_filas:= c_filas +1;
			n_filas:= c_filas;

			commit;

		EXCEPTION
		        WHEN error_param THEN
				     error(n_error):= 'imposible continuar';
					 if vcod_retorno is null then
					    rollback;
					 end if;
		        WHEN OTHERS THEN

				     error(n_error):= TO_CHAR(SQLCODE);
					 error(n_error+1):= sqlerrm;
					 rollback;


		END CO_MOD_SERV_SUPLEM;

end;
/
SHOW ERRORS
