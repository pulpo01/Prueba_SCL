CREATE OR REPLACE PACKAGE BODY ve_ctrl_lineas_prepago_pg
IS

CV_codmodulo			CONSTANT VARCHAR2(2):='GA';
CV_error_no_clasif		CONSTANT VARCHAR2(60):='Error no clasificado';

	FUNCTION ve_busca_rol_fn(EV_nom_usuario VARCHAR2)
	/*
	<Documentacion TipoDoc = "Funcion>
		<Elemento
		Nombre = "VE_BUSCA_ROL_FN"
		Lenguaje="PL/SQL"
		Fecha creaci¢n="02-10-2007"
		Creado por="Vladimir Maureira"
		Fecha modificacion=""
		Modificado por=""
		Ambiente Desarrollo="SQAPRECOL">
		<Retorno>true:Tien ROL, false:No tiene ROL</Retorno>
		<Descripci¢n>Retorna si el usuario tiene ROL para aceptar mas ventas permitidas</Descripci¢n>
			<Parametros>
			<Entrada>
				<param nom="EV_nom_usuario" Tipo="VARCHAR2">Nombre usuario</param>
			</Entrada>
			</Parametros>
		</Elemento>
	</Documentaci¢n>
	*/
	RETURN NUMBER
		IS
			LE_error_parametros		EXCEPTION;
			LN_retorna				number(1):=0;
			LV_val_parametro		ged_parametros.val_parametro%TYPE;
			LN_count				number;
	BEGIN

		IF EV_nom_usuario IS  NULL THEN
		raise LE_error_parametros;
		END IF;

				BEGIN
					 SELECT count(1)
					   INTO LN_count
					   FROM GE_SEG_PERFILES a, ge_seg_grpusuario b
					  WHERE a.cod_grupo = b.cod_grupo
					    AND b.nom_usuario = EV_nom_usuario
					    AND a.cod_programa = 'GAA'
					    AND a.num_version in ( SELECT Max(num_version) FROM GE_PROGRAMAS WHERE COD_MODULO = 'GA' AND COD_PROGRAMA = 'GAA')
					    AND a.cod_proceso = 'GAA101Y'
					    AND ROWNUM = 1;
				END;


/*				BEGIN
					SELECT ged.val_parametro INC. 69504
					INTO   LV_val_parametro
					FROM ged_parametros ged
					WHERE ged.nom_parametro = 'COD_EXCEPCION'
					AND   ged.cod_modulo = 'GA'
					AND   ged.cod_producto = 1;

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							LV_val_parametro := null;
				END;

				BEGIN
					SELECT COUNT(1)
					INTO   LN_count
					FROM GE_SEG_GRPUSUARIO
					WHERE NOM_USUARIO = EV_nom_usuario
					AND COD_GRUPO     = LV_val_parametro
					AND ROWNUM <= 1;

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							LN_count := 0;
				END;*/

				IF LN_count > 0 THEN
					LN_retorna := 1;
				END IF;

				RETURN LN_retorna;
			EXCEPTION
				WHEN OTHERS THEN
					RETURN LN_retorna;
	END ve_busca_rol_fn;


	FUNCTION ve_supera_limite_fn(EN_cod_cliente NUMBER,EV_cod_tipident VARCHAR2,EV_num_ident VARCHAR2,EN_cod_cuenta NUMBER)
	/*
		<Documentaci¢n
		TipoDoc = "Funcion>
		<Elemento
		Nombre = "VE_SUPERA_LIMITE_FN"
		Lenguaje="PL/SQL"
		Fecha creaci¢n="22-03-2007"
		Creado por="Tito Donoso Vera"
		Fecha modificacion="02-10-2007"
		Modificado por="Vladimir Maureira"
		Ambiente Desarrollo="SQAPRECOL">
		<Retorno>1:Supera limite, 0:No supera limite</Retorno>
			<Descripci¢n>Valida numero de lineas permitidas por Cuenta y por Cliente</Descripci¢n>
		<Parametros>
			<Entrada>
				<param nom="EN_cod_cliente" Tipo="NUMBER">Codigo del cliente</param>
				<param nom="EV_cod_tipident" Tipo="VARCHAR2">Codigo Tipo Identificación</param>
				<param nom="EV_num_ident" Tipo="VARCHAR2">Numero de Identificación</param>
				<param nom="EN_cod_cuenta" Tipo="NUMBER">Codigo de la Cuenta</param>
			</Entrada>
		</Parametros>
		</Elemento>
		</Documentaci¢n>
	*/
	RETURN VARCHAR2
		IS
			LN_cantline				NUMBER(6):=0;--numero de lineas del cliente
			LN_limite				NUMBER(6):=0;--lineas permitidas
			LE_error_parametros		EXCEPTION;
			LV_cadena				VARCHAR2(31):='1';
			LV_sql					VARCHAR(2000):='';
			LV_des_error			VARCHAR(2000):='';
			LN_cod_retorno			ge_errores_pg.CodError;
			LV_mens_retorno			VARCHAR2(60):='';
			LN_num_evento			ge_errores_pg.Evento;
			LN_flag					number(1):=0;
		BEGIN

			/* IF NVL(EN_cod_cliente, -1) < 0 THEN
			RAISE LE_error_parametros;
			END IF;*/

			IF EV_cod_tipident IS NOT NULL AND EV_num_ident IS NOT NULL THEN
				LN_flag := 1;
				LV_sql := 'SELECT count(1)';
				LV_sql := LV_sql || ' FROM  GA_ABOAMIST ABO, GE_CLIENTES cli';
				LV_sql := LV_sql || ' WHERE CLI.cod_tipident = ' || EV_cod_tipident;
				LV_sql := LV_sql || ' AND CLI.num_ident = ' || EV_num_ident;
				LV_sql := LV_sql || ' AND ABO.cod_cliente = CLI.cod_cliente';
				LV_sql := LV_sql || ' AND ABO.cod_situacion NOT IN (BAA,BAP);';
				BEGIN
					SELECT count(1)
					INTO  LN_cantline
					FROM  GA_ABOAMIST ABO, GE_CLIENTES cli
					WHERE CLI.cod_tipident = EV_cod_tipident
					AND CLI.num_ident = EV_num_ident
					AND ABO.cod_cliente = CLI.cod_cliente
					AND ABO.cod_situacion NOT IN ('BAA','BAP');
				EXCEPTION
						WHEN NO_DATA_FOUND THEN
							LN_cantline := 0;
				END;
			ELSE
				IF EN_cod_cuenta IS NOT NULL THEN
					--SI INGRESA EL CàDIGO DE CUENTA:
					LN_flag := 2;
					LV_sql := 'SELECT count(1)';
					LV_sql := LV_sql || ' FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI, GA_CUENTAS CUE';
					LV_sql := LV_sql || ' WHERE CUE.COD_CUENTA = ' || EN_cod_cuenta;
					LV_sql := LV_sql || ' AND CLI.COD_TIPIDENT = CUE.COD_TIPIDENT';
					LV_sql := LV_sql || ' AND CLI.NUM_IDENT = CUE.NUM_IDENT';
					LV_sql := LV_sql || ' AND ABO.COD_CLIENTE = CLI.COD_CLIENTE';
					LV_sql := LV_sql || ' AND ABO.cod_situacion NOT IN (BAA,BAP);';

					BEGIN
						SELECT count(1)
						INTO  LN_cantline
						FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI, GA_CUENTAS CUE
						WHERE CUE.COD_CUENTA = EN_cod_cuenta
						AND CLI.COD_TIPIDENT = CUE.COD_TIPIDENT
						AND CLI.NUM_IDENT = CUE.NUM_IDENT
						AND ABO.COD_CLIENTE = CLI.COD_CLIENTE
						AND ABO.cod_situacion NOT IN ('BAA','BAP');

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							LN_cantline := 0;
					END;
				ELSE
					IF EN_cod_cliente IS NOT NULL THEN
						--SI INGRESA EL CÓDIGO DEL CLIENTE:
						LN_flag := 3;
						LV_sql := 'SELECT count(1)';
						LV_sql := LV_sql || ' FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI';
						LV_sql := LV_sql || ' WHERE CLI.COD_CLIENTE = ' || EN_cod_cliente;
						LV_sql := LV_sql || ' AND ABO.COD_CLIENTE = CLI.COD_CLIENTE';
						LV_sql := LV_sql || ' AND ABO.cod_situacion NOT IN (BAA,BAP);';

						BEGIN
							SELECT count(1)
							INTO  LN_cantline
							FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI
							WHERE CLI.COD_CLIENTE = EN_cod_cliente
							AND ABO.COD_CLIENTE = CLI.COD_CLIENTE
							AND ABO.cod_situacion NOT IN ('BAA','BAP');

						EXCEPTION
							WHEN NO_DATA_FOUND THEN
								LN_cantline := 0;
						END;
					END IF;
				END IF;
			END IF;

			BEGIN
				IF LN_flag = 1 THEN

					--Cuenta numero maximo de lineas perimitidas segun calidad
					LV_sql := 'SELECT lp.valor_limite';
					LV_sql := LV_sql || ' FROM ve_limite_prepago_td lp';
					LV_sql := LV_sql || ' WHERE lp.cod_valor = '|| EV_cod_tipident;
					LV_sql := LV_sql || ' AND lp.cod_relacion = 2';
					LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';

					SELECT lp.valor_limite
					INTO LN_limite
					FROM ve_limite_prepago_td lp
					WHERE lp.cod_valor = EV_cod_tipident
					AND lp.cod_relacion = 2
					AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);
				ELSE
					IF LN_flag = 2 THEN
						LV_sql := 'SELECT lp.valor_limite';
						LV_sql := LV_sql || ' FROM ve_limite_prepago_td lp, ga_cuentas cue';
						LV_sql := LV_sql || ' WHERE CUE.COD_CUENTA = '|| EN_cod_cuenta;
						LV_sql := LV_sql || ' AND lp.cod_valor = CUE.COD_TIPIDENT';
						LV_sql := LV_sql || ' AND lp.cod_relacion = 2';
						LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';

						SELECT lp.valor_limite
						INTO LN_limite
						FROM ve_limite_prepago_td lp, ga_cuentas cue
						WHERE CUE.COD_CUENTA = EN_cod_cuenta
						AND lp.cod_valor = CUE.COD_TIPIDENT
						AND lp.cod_relacion = 2
						AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);
					ELSE
						IF LN_flag = 3 THEN
							IF EN_cod_cliente IS NOT NULL THEN
							   	BEGIN
									LV_sql := 'SELECT lp.valor_limite';
									LV_sql := LV_sql || ' FROM ga_valor_cli vc,';
									LV_sql := LV_sql || '      ve_limite_prepago_td lp';
									LV_sql := LV_sql || ' WHERE vc.cod_cliente = ' || EN_cod_cliente;
									LV_sql := LV_sql || ' AND lp.cod_relacion = 1';
									LV_sql := LV_sql || ' AND lp.cod_valor = vc.cod_valor';
									LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';

									SELECT lp.valor_limite
									INTO LN_limite
									FROM ga_valor_cli vc,
									ve_limite_prepago_td lp
									WHERE vc.cod_cliente = EN_cod_cliente
									AND lp.cod_relacion = 1
									AND lp.cod_valor = vc.cod_valor
									AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);

								EXCEPTION
									WHEN NO_DATA_FOUND THEN
										LN_limite := 0;
								END;
							END IF;
						END IF;
					END IF;
				END IF;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					BEGIN
						--cuenta maximo por defecto
						LV_sql := 'SELECT lp.valor_limite';
						LV_sql := LV_sql || ' FROM ve_limite_prepago_td lp';
						LV_sql := LV_sql || ' WHERE lp.cod_relacion = 3';
						LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';

						SELECT lp.valor_limite
						INTO LN_limite
						FROM ve_limite_prepago_td lp
						WHERE lp.cod_relacion = 3
						AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							LN_limite := 0;
					END;
			END;
			IF LN_cantline < LN_limite THEN
				--puede agregar nueva l¡nea
				LV_cadena := '0' || '|' || LN_cantline || '|' || LN_limite;
			ELSE
				LV_cadena := '1' || '|' || LN_cantline || '|' || LN_limite;
			END IF;
			RETURN LV_cadena;
		EXCEPTION
			WHEN OTHERS Then
				LN_cod_retorno:=156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
					LV_mens_retorno:=CV_error_no_clasif;
				END IF;
				LV_des_error:='Others:ve_ctrl_lineas_prepago_pg.ve_supera_limite_fn('||EN_cod_cliente || ',' || EV_cod_tipident ||','|| EV_num_ident ||',' || EN_cod_cuenta || ');- ' || SQLERRM;
				LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_codmodulo,LV_mens_retorno, '1.0', USER,'ve_ctrl_lineas_prepago_pg.ve_supera_limite_fn', LV_sql, SQLCODE, LV_des_error );

				LV_cadena := '4' || LN_num_evento;
			RETURN LV_cadena;
		END VE_SUPERA_LIMITE_FN;


               FUNCTION ve_limite_1_fn(EV_cod_tipident  VARCHAR2)
	       /*
		<Documentaci¢n
		TipoDoc = "Funcion>
		<Elemento
		Nombre = "ve_limite_1_fn"
		Lenguaje="PL/SQL"
		Fecha creaci¢n="22-03-2007"
		Creado por="Tito Donoso Vera"
		Fecha modificacion="10-01-2008"
		Modificado por="Vladimir Maureira"
		Ambiente Desarrollo="SQAPRECOL">
		<Retorno>1:Supera limite, 0:No supera limite</Retorno>
			<Descripci¢n>Valida numero de lineas permitidas por Cuenta y por Cliente</Descripci¢n>
		<Parametros>
			<Entrada>
				<param nom="EV_cod_tipident" Tipo="VARCHAR2">Codigo Tipo Identificación</param>
			</Entrada>
		</Parametros>
		</Elemento>
		</Documentaci¢n>
                */
                RETURN NUMBER
		IS
			LN_limite			NUMBER(6):=0;--lineas permitidas
			LV_sql				VARCHAR(2000):='';
		BEGIN

                                        LV_sql := 'SELECT lp.valor_limite';
					LV_sql := LV_sql || ' FROM ve_limite_prepago_td lp';
					LV_sql := LV_sql || ' WHERE lp.cod_valor = '|| EV_cod_tipident;
					LV_sql := LV_sql || ' AND lp.cod_relacion = 2';
					LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';
                                     BEGIN
					SELECT lp.valor_limite
					INTO LN_limite
					FROM ve_limite_prepago_td lp
					WHERE lp.cod_valor = EV_cod_tipident
					AND lp.cod_relacion = 2
					AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);

					EXCEPTION
				          WHEN NO_DATA_FOUND THEN
                                               LN_limite := 0;
                                     END;

                                     RETURN LN_limite;
               END;

               FUNCTION ve_limite_2_fn(EN_cod_cuenta NUMBER)
	       /*
		<Documentaci¢n
		TipoDoc = "Funcion>
		<Elemento
		Nombre = "ve_limite_2_fn"
		Lenguaje="PL/SQL"
		Fecha creaci¢n="22-03-2007"
		Creado por="Tito Donoso Vera"
		Fecha modificacion="10-01-2008"
		Modificado por="Vladimir Maureira"
		Ambiente Desarrollo="SQAPRECOL">
		<Retorno>1:Supera limite, 0:No supera limite</Retorno>
			<Descripci¢n>Valida numero de lineas permitidas por Cuenta y por Cliente</Descripci¢n>
		<Parametros>
			<Entrada>
				<param nom="EV_cod_tipident" Tipo="VARCHAR2">Codigo Tipo Identificación</param>
			</Entrada>
		</Parametros>
		</Elemento>
		</Documentaci¢n>
              */
               RETURN NUMBER
		IS
			LN_limite			NUMBER(6):=0;--lineas permitidas
			LV_sql				VARCHAR(2000):='';
		BEGIN

		                        LV_sql := 'SELECT lp.valor_limite';
					LV_sql := LV_sql || ' FROM ve_limite_prepago_td lp, ga_cuentas cue';
					LV_sql := LV_sql || ' WHERE CUE.COD_CUENTA = '|| EN_cod_cuenta;
					LV_sql := LV_sql || ' AND lp.cod_valor = CUE.COD_TIPIDENT';
					LV_sql := LV_sql || ' AND lp.cod_relacion = 2';
					LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';

                                        BEGIN
						SELECT lp.valor_limite
						INTO LN_limite
						FROM ve_limite_prepago_td lp, ga_cuentas cue
						WHERE CUE.COD_CUENTA = EN_cod_cuenta
						AND lp.cod_valor = CUE.COD_TIPIDENT
						AND lp.cod_relacion = 2
						AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);

	                                EXCEPTION
				        WHEN NO_DATA_FOUND THEN
                                               LN_limite := 0;
                                        END;


                                     RETURN LN_limite;
               END;



               FUNCTION ve_supera_limite2_fn(EN_cod_cliente NUMBER,EV_cod_tipident VARCHAR2,EV_num_ident VARCHAR2,EN_cod_cuenta NUMBER)
	       /*
		<Documentaci¢n
		TipoDoc = "Funcion>
		<Elemento
		Nombre = "VE_SUPERA_LIMITE2_FN"
		Lenguaje="PL/SQL"
		Fecha creaci¢n="22-03-2007"
		Creado por="Tito Donoso Vera"
		Fecha modificacion="10-01-2008"
		Modificado por="Vladimir Maureira"
		Ambiente Desarrollo="SQAPRECOL">
		<Retorno>1:Supera limite, 0:No supera limite</Retorno>
			<Descripci¢n>Valida numero de lineas permitidas por Cuenta y por Cliente</Descripci¢n>
		<Parametros>
			<Entrada>
				<param nom="EN_cod_cliente" Tipo="NUMBER">Codigo del cliente</param>
				<param nom="EV_cod_tipident" Tipo="VARCHAR2">Codigo Tipo Identificación</param>
				<param nom="EV_num_ident" Tipo="VARCHAR2">Numero de Identificación</param>
				<param nom="EN_cod_cuenta" Tipo="NUMBER">Codigo de la Cuenta</param>
			</Entrada>
		</Parametros>
		</Elemento>
		</Documentaci¢n>
              */
               RETURN VARCHAR2
		IS
			LN_cantline			NUMBER(6):=0;--numero de lineas del cliente
			LN_limite			NUMBER(6):=0;--lineas permitidas
			LE_error_parametros		EXCEPTION;
			LV_cadena			VARCHAR2(31):='1';
			LV_sql				VARCHAR(2000):='';
			LV_des_error			VARCHAR(2000):='';
			LN_cod_retorno			ge_errores_pg.CodError;
			LV_mens_retorno			VARCHAR2(60):='';
			LN_num_evento			ge_errores_pg.Evento;
			LN_flag	                        number(1):=0;
			LN_General                      number(1):=0;
			LN_cantline_clie                NUMBER(6):=0;
			LN_cantline_num_ident           NUMBER(6):=0;
			LN_cantline_cuenta              NUMBER(6):=0;

		BEGIN
                        IF EN_cod_cliente IS NOT NULL THEN
			--SI INGRESA EL CÓDIGO DEL CLIENTE:
                              LV_sql := 'SELECT count(1)';
                              LV_sql := LV_sql || ' FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI';
                              LV_sql := LV_sql || ' WHERE CLI.COD_CLIENTE = ' || EN_cod_cliente;
                              LV_sql := LV_sql || ' AND ABO.COD_CLIENTE = CLI.COD_CLIENTE';
                              LV_sql := LV_sql || ' AND ABO.cod_situacion NOT IN (BAA,BAP);';

                              BEGIN
	                        SELECT count(1)
	                         INTO  LN_cantline_clie
	                        FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI
	                        WHERE CLI.COD_CLIENTE = EN_cod_cliente
	                        AND ABO.COD_CLIENTE = CLI.COD_CLIENTE
	                        AND ABO.cod_situacion NOT IN ('BAA','BAP');

                               EXCEPTION
	                          WHEN NO_DATA_FOUND THEN
                                       LN_cantline := 0;
                              END;
                        END IF;

                        IF EV_cod_tipident IS NOT NULL AND EV_num_ident IS NOT NULL THEN
				LV_sql := 'SELECT count(1)';
				LV_sql := LV_sql || ' FROM  GA_ABOAMIST ABO, GE_CLIENTES cli';
				LV_sql := LV_sql || ' WHERE CLI.cod_tipident = ' || EV_cod_tipident;
				LV_sql := LV_sql || ' AND CLI.num_ident = ' || EV_num_ident;
				LV_sql := LV_sql || ' AND ABO.cod_cliente = CLI.cod_cliente';
				LV_sql := LV_sql || ' AND ABO.cod_situacion NOT IN (BAA,BAP);';
				BEGIN
					SELECT count(1)
					INTO  LN_cantline_num_ident
					FROM  GA_ABOAMIST ABO, GE_CLIENTES cli
					WHERE CLI.cod_tipident = EV_cod_tipident
					AND CLI.num_ident = EV_num_ident
					AND ABO.cod_cliente = CLI.cod_cliente
					AND ABO.cod_situacion NOT IN ('BAA','BAP');
				  EXCEPTION
					WHEN NO_DATA_FOUND THEN
					    LN_cantline := 0;
				END;
			END IF;

			IF EN_cod_cuenta IS NOT NULL THEN
					--SI INGRESA EL CODIGO DE CUENTA:
					LV_sql := 'SELECT count(1)';
					LV_sql := LV_sql || ' FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI, GA_CUENTAS CUE';
					LV_sql := LV_sql || ' WHERE CUE.COD_CUENTA = ' || EN_cod_cuenta;
					LV_sql := LV_sql || ' AND CLI.COD_TIPIDENT = CUE.COD_TIPIDENT';
					LV_sql := LV_sql || ' AND CLI.NUM_IDENT = CUE.NUM_IDENT';
					LV_sql := LV_sql || ' AND ABO.COD_CLIENTE = CLI.COD_CLIENTE';
					LV_sql := LV_sql || ' AND ABO.cod_situacion NOT IN (BAA,BAP);';

					BEGIN
						SELECT count(1)
						INTO  LN_cantline_cuenta
						FROM  GA_ABOAMIST ABO, GE_CLIENTES CLI, GA_CUENTAS CUE
						WHERE CUE.COD_CUENTA = EN_cod_cuenta
						AND CLI.COD_TIPIDENT = CUE.COD_TIPIDENT
						AND CLI.NUM_IDENT = CUE.NUM_IDENT
						AND ABO.COD_CLIENTE = CLI.COD_CLIENTE
						AND ABO.cod_situacion NOT IN ('BAA','BAP');

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
						     LN_cantline := 0;
					END;
			END IF;

                           IF EN_cod_cliente IS NOT NULL THEN
                                        LN_cantline:= LN_cantline_clie;
                                        LN_flag := 3;
					LV_sql := 'SELECT lp.valor_limite';
					LV_sql := LV_sql || ' FROM ga_valor_cli vc,';
					LV_sql := LV_sql || '      ve_limite_prepago_td lp';
					LV_sql := LV_sql || ' WHERE vc.cod_cliente = ' || EN_cod_cliente;
					LV_sql := LV_sql || ' AND lp.cod_relacion = 1';
					LV_sql := LV_sql || ' AND lp.cod_valor = vc.cod_valor';
					LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';

			             BEGIN
					SELECT lp.valor_limite
					INTO LN_limite
					FROM ga_valor_cli vc,
					ve_limite_prepago_td lp
					WHERE vc.cod_cliente = EN_cod_cliente
					AND lp.cod_relacion = 1
					AND lp.cod_valor = vc.cod_valor
					AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);

				        EXCEPTION
				     	  WHEN NO_DATA_FOUND THEN
				               LN_limite := 0;

				               IF EV_cod_tipident IS NOT NULL AND EV_num_ident IS NOT NULL THEN
				                     LN_flag   := 1;
				               ELSIF EN_cod_cuenta IS NOT NULL THEN
				                     LN_flag   := 2;
				               ELSE
				                     LN_General:= 1;
				               END IF;
				     END;
			   END IF;

			  IF LN_flag = 1 THEN
			     LN_cantline:=LN_cantline_num_ident;
			     LN_limite:=ve_limite_1_fn(EV_cod_tipident);
			  ELSIF LN_flag = 2 THEN
			     LN_cantline:=LN_cantline_cuenta;
			     LN_limite:=ve_limite_2_fn(EN_cod_cuenta);
			  ELSIF EV_cod_tipident IS NOT NULL AND EV_num_ident IS NOT NULL AND LN_flag = 0 AND LN_General = 0  THEN
			     LN_cantline:=LN_cantline_num_ident;
			     LN_limite:=ve_limite_1_fn(EV_cod_tipident);
			  ELSIF EN_cod_cuenta IS NOT NULL AND LN_flag = 0 AND LN_General = 0 THEN
			     LN_cantline:=LN_cantline_cuenta;
			     LN_limite:=ve_limite_2_fn(EN_cod_cuenta);
			  END IF;

			  IF LN_limite= 0 THEN
			     LN_General:= 1;
			  END IF;

                          IF LN_General = 1 THEN
                                        BEGIN
						--cuenta maximo por defecto
						LV_sql := 'SELECT lp.valor_limite';
						LV_sql := LV_sql || ' FROM ve_limite_prepago_td lp';
						LV_sql := LV_sql || ' WHERE lp.cod_relacion = 3';
						LV_sql := LV_sql || ' AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);';

						SELECT lp.valor_limite
						INTO LN_limite
						FROM ve_limite_prepago_td lp
						WHERE lp.cod_relacion = 3
						AND SYSDATE BETWEEN lp.fecha_vigencia_desde AND NVL(lp.fecha_vigencia_hasta, SYSDATE);

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
                                                     LN_limite := 0;
					END;
                           END IF;


			IF LN_cantline < LN_limite THEN
			--puede agregar nueva linea
				LV_cadena := '0' || '|' || LN_cantline || '|' || LN_limite;
			ELSE
				LV_cadena := '1' || '|' || LN_cantline || '|' || LN_limite;
			END IF;

			RETURN LV_cadena;


		EXCEPTION
			WHEN OTHERS Then
				LN_cod_retorno:=156;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
					LV_mens_retorno:=CV_error_no_clasif;
				END IF;
				LV_des_error:='Others:ve_ctrl_lineas_prepago_pg.ve_supera_limite2_fn('||EN_cod_cliente || ',' || EV_cod_tipident ||','|| EV_num_ident ||',' || EN_cod_cuenta || ');- ' || SQLERRM;
				LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_codmodulo,LV_mens_retorno, '1.0', USER,'ve_ctrl_lineas_prepago_pg.ve_supera_limite2_fn', LV_sql, SQLCODE, LV_des_error );

				LV_cadena := '4' || LN_num_evento;
			RETURN LV_cadena;
		END VE_SUPERA_LIMITE2_FN;
-----------------------------------------------------------------------------------------------
--/////////////////////////////////////////////////////////////////////////////////////////////
-----------------------------------------------------------------------------------------------

	PROCEDURE ve_registra_excepcion_vta_pr
				(EN_numtransa		IN NUMBER
				,EN_num_venta		IN NUMBER
				,EN_cod_causa		IN NUMBER)

	/*
	<Documentaci¢n
	TipoDoc = "Procedimiento">
		<Elemento
		Nombre = "VE_REGISTRA_EXCEPCION_VTA_PR"
		Lenguaje="PL/SQL"
		Fecha creaci¢n="22-03-2007"
		Creado por="Tito Donoso Vera"
		Fecha modificacion=""
		Modificado por=""
		Ambiente Desarrollo="BD">
		<Retorno>Valida existencia de abonados activos del cliente</Retorno>
		<Descripci¢n>Registra venta excepcionada</Descripci¢n>
			<Par?metros>
				<Entrada>
					<param nom="en_numtransa" Tipo="NUMBER">Numero de transaccion</param>
					<param nom="en_num_venta" Tipo="NUMBER">Numero de la venta</param>
					<param nom="en_cod_causa" Tipo="NUMBER">Codigo causa excepcion</param>
				</Entrada>
			</Par?metros>
		</Elemento>
	</Documentaci¢n>
	*/

	IS
		n_num_celular		ga_aboamist.num_celular%TYPE;
		n_cod_plantarif		ga_aboamist.cod_plantarif%TYPE;
		n_abonado			ga_aboamist.num_abonado%TYPE;
		n_cliente			ga_aboamist.cod_cliente%TYPE;

		ERROR_PROCESO 		EXCEPTION;
		S_ERROR				VARCHAR2(50);
		N_ERROR				NUMBER;

	BEGIN

				S_ERROR := 'Error al buscar usuario en venta excepcionada';
				N_ERROR := 1;
				SELECT aa.cod_cliente,
                                        aa.num_abonado,
                                        aa.cod_plantarif
                                INTO     n_cliente,
                                        n_abonado,
                                        n_cod_plantarif
                                FROM ga_aboamist aa
                                WHERE aa.num_venta = EN_num_venta
                                and aa.cod_situacion not in ('BAA', 'BAP')
                                and ((aa.cod_cliente,aa.num_abonado) not in(
				select a.cod_cliente,a.num_abonado from ve_excepcion_vta_prepago_to a
				where a.num_venta = EN_num_venta))
                                AND ROWNUM <= 1;


				S_ERROR := 'Error al insertar venta excepcionada';
				N_ERROR := 2;
				INSERT INTO ve_excepcion_vta_prepago_to
							(cod_excepcion_vta,num_venta,cod_cliente,num_abonado,
							cod_causa,fecha_venta, nom_usuario,
							cod_plantarif)
				VALUES
					(ve_venta_excepcionada_sq.NEXTVAL,EN_num_venta, n_cliente,n_abonado,
					EN_cod_causa,SYSDATE,USER,
					n_cod_plantarif);
				S_ERROR := 'Nada';
				N_ERROR := 0;
	EXCEPTION
		WHEN OTHERS THEN

		INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
									COD_RETORNO,
									DES_CADENA)
							VALUES (EN_numtransa,
									N_ERROR,
									S_ERROR);

	END VE_REGISTRA_EXCEPCION_VTA_PR;
END VE_CTRL_LINEAS_PREPAGO_PG;
/
SHOW ERRORS
