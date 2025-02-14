CREATE OR REPLACE PACKAGE BODY VE_desbloqueaprepago_PG IS

        PROCEDURE VE_desbloqueo_PR(EV_codvendealer IN ve_vendealer.cod_vendealer%TYPE,
		                           EV_tipident IN ge_clientes.cod_tipident%TYPE,
                                   EV_numident IN ge_clientes.num_ident%TYPE,
							       EV_imsi IN ga_aboamist.num_serie%TYPE,
							       EV_apeclien1 IN ge_clientes.nom_apeclien1%TYPE,
							       EV_codplantarif IN icc_movimiento.plan%TYPE,
								   SN_codcliente OUT NOCOPY ge_clientes.cod_cliente%TYPE,
								   SN_numventa OUT NOCOPY ga_ventas.num_venta%TYPE,
							       SN_numcelular OUT NOCOPY ga_aboamist.num_celular%TYPE,
							       SD_fecalta OUT NOCOPY ga_aboamist.fec_alta%TYPE,
                                   SV_error OUT NOCOPY VARCHAR2,
							       SN_coderror OUT NOCOPY NUMBER
                                  ) IS

		/*
		<Documentación TipoDoc = "VE_desbloqueo_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="22-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción>REALIZA LOS LLAMADOS A LAS VALIDACIONES PREVIAS Y REALIZA EL DESBLOQUEO</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_codvendealer" Tipo="STRING">CODIGO DE VENDEDOR DEALER</param>
		<param nom="EV_numident" Tipo="STRING">Numero identidad del cliente</param>
		<param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente</param>
		<param nom="EV_imsi" Tipo="STRING">Numero de serie a desbloquear</param>
		<param nom="EV_apeclien1" Tipo="STRING">apellido paterno abonado</param>
		<param nom="EV_codplantarif" Tipo="STRING">Plan tarifario</param>
		</Entrada>
		<Salida>
		<param nom="SV_error" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

		exception_fin EXCEPTION;
		LE_fin EXCEPTION;
        LV_valnit VARCHAR2(50);
		LN_numtransaccion ga_transacabo.num_transaccion%TYPE;
		LN_clientesvetados PLS_INTEGER;
		LN_serieln PLS_INTEGER;
		LN_serieactiva PLS_INTEGER;
		LV_codclientedealer ge_clientes.cod_cliente%TYPE;
		LN_ventacliente PLS_INTEGER;
		LV_codcliente ge_clientes.cod_cliente%TYPE;
		LV_codcuenta ga_cuentas.cod_cuenta%TYPE;
		LV_numabonado ga_aboamist.num_abonado%TYPE;
		LV_codtecno ga_aboamist.cod_tecnologia%TYPE;
		LV_tipterminal ga_aboamist.tip_terminal%TYPE;
		LV_numseriehex ga_aboamist.num_seriehex%TYPE;
		LV_codcentral ga_aboamist.cod_central%TYPE;
		LV_numcelular ga_aboamist.num_celular%TYPE;
		LV_numventa ga_aboamist.num_venta%TYPE;
		LV_codvendedor ve_vendealer.cod_vendedor%TYPE;
		LV_coddireccion ve_vendedores.cod_direccion%TYPE;
		LV_nummin ga_aboamist.num_min%TYPE;
		LN_existeventa NUMBER(3);
		LV_coderror VARCHAR2(64);
		LN_existeplan NUMBER(3);

BEGIN
        BEGIN
		    SN_coderror:=0;

		    LV_valnit:=VE_validacion_PG.VE_validanit_FN(EV_numident, EV_tipident);

			IF SUBSTR(TRIM(LV_valnit), 1, 5)='ERROR' THEN
			   BEGIN
			     LV_coderror:='ERROR_NUM_IDENT';
			     RAISE exception_fin;
			   END;
			END IF;

			SELECT COUNT(1)
			INTO   LN_existeplan
			FROM   ta_plantarif t
			where  t.cod_plantarif=EV_codplantarif;

			IF LN_existeplan<1 THEN
			   LV_coderror:='ERROR_NO_DATA_PLANTARIF';
			   RAISE exception_fin;
			END IF;

			/*VE_validavendedor_PG.VE_valida_PR(EV_codvendealer, SN_coderror, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   RAISE exception_fin;
			END IF;

			LN_clientesvetados:=VE_validacliente_PG.VE_valida_FN(EV_tipident, EV_numident, SN_coderror, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   RAISE exception_fin;
			END IF;*/

			SELECT v.cod_cliente, v.cod_vendedor, v.cod_direccion
			INTO   LV_codclientedealer, LV_codvendedor, LV_coddireccion
            FROM   ve_vendealer d, ve_vendedores v
            WHERE  d.cod_vendealer=EV_codvendealer
                   AND v.cod_vendedor=d.cod_vendedor
	               AND d.cod_tipcomis=v.cod_tipcomis;

			IF TRIM(LV_codclientedealer) IS NULL OR TRIM(LV_codvendedor) IS NULL
			   OR TRIM(LV_coddireccion) IS NULL THEN
			   BEGIN
			      LV_coderror:='ERROR_NO_DATA_VENDEALER_1';
			      RAISE exception_fin;
			   END;
			END IF;

			SELECT COUNT(1)
			INTO   LN_existeventa
			FROM   ga_aboamist b
			WHERE  b.cod_cliente IN (SELECT d.cod_cliente
	   				 	 			 FROM   ve_vendedores d, ve_vendealer c
						 			 WHERE  c.cod_vendealer=EV_codvendealer
       					        			AND c.cod_vendedor=d.cod_vendedor)
	   			   AND b.num_serie=EV_imsi
	   			   AND b.cod_cliente=b.cod_cliente_dist
	   			   AND b.cod_situacion NOT IN ('BAA','BAP'); --XO-200509260738: German Espinoza Z; 05/10/2005

			IF LN_existeventa<1 THEN
			   BEGIN
			       LV_coderror:='ERROR_EXISTE_VENTA';
				   RAISE exception_fin;
			   END;
			END IF;

		    /*LN_ventacliente:=VE_validaequipo_PG.VE_valida_FN(EV_imsi, SN_coderror, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   RAISE exception_fin;
			END IF;*/

			VE_desbloqueaprepago_PG.VE_existecliente_PR(EV_numident, EV_tipident, LV_codcliente, LV_codcuenta, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   RAISE LE_fin;
			END IF;

			VE_desbloqueaprepago_PG.VE_obtienenumabonado_PR(LV_codclientedealer, EV_imsi, LV_numabonado, LV_codtecno,
		                                                    LV_tipterminal, LV_numseriehex, LV_codcentral,
		                                                    LV_numcelular, LV_nummin, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   IF SUBSTR(TRIM(SV_error), 1,20)='VE_DESBLOQUEAPREPAGO' THEN
			      RAISE LE_fin;
			   END IF;
			   LV_coderror:=SV_error;
			   RAISE exception_fin;
			ELSIF TRIM(LV_numabonado) IS NULL OR
			      TRIM(LV_codtecno) IS NULL OR
		          TRIM(LV_tipterminal) IS NULL OR
				  TRIM(LV_numseriehex) IS NULL OR
				  TRIM(LV_codcentral) IS NULL OR
				  TRIM(LV_nummin) IS NULL OR
				  TRIM(LV_numcelular) IS NULL THEN
				  BEGIN
			         LV_coderror:='ERROR_NO_DATA_ABONADO_1';
				     RAISE exception_fin;
				  END;
			END IF;

			-- DMZ/Soporte 28/102005 XO-200510250963.
			--IF TRIM(LV_codcliente) IS NULL OR TRIM(LV_codcuenta) IS NULL THEN
			IF TRIM(LV_codcuenta) IS NULL THEN
			   --CLIENTE NO EXISTE
			   VE_desbloqueaprepago_PG.VE_creacuenta_PR(EV_apeclien1, EV_apeclien1, EV_numident, EV_tipident,
			                                            LV_coddireccion, LV_codcuenta, SV_error);

			   IF TRIM(SV_error) IS NOT NULL THEN
				  IF SUBSTR(TRIM(SV_error), 1,20)='VE_DESBLOQUEAPREPAGO' OR
				     SUBSTR(TRIM(UPPER(SV_error)), 1,15)='GA_CUENTAS_I_PG' THEN
			         RAISE LE_fin;
			      END IF;
			      LV_coderror:=SV_error;
 			      RAISE exception_fin;
			   ELSIF TRIM(LV_codcuenta) IS NULL THEN
			      BEGIN
			         LV_coderror:='ERROR_NO_DATA_CUENTA';
			         RAISE exception_fin;
				  END;
			   END IF;
			END IF; -- DMZ/Soporte 28/102005 XO-200510250963.

			IF TRIM(LV_codcliente) IS NULL THEN -- DMZ/Soporte 28/102005 XO-200510250963.
			   VE_desbloqueaprepago_PG.VE_creacliente_PR(LV_codcuenta, EV_apeclien1, EV_numident, EV_tipident,
			                                             LV_codcliente, SV_error);

			   IF TRIM(SV_error) IS NOT NULL THEN
			      IF SUBSTR(TRIM(SV_error),1,16)='GE_CLIENTES_I_PG'
				     OR SUBSTR(TRIM(SV_error), 1,20)='VE_DESBLOQUEAPREPAGO' THEN
					 RAISE LE_fin;
				  END IF;
			      LV_coderror:=SV_error;
 			      RAISE exception_fin;
			   END IF;

			END IF;

			GA_usuamist_u_PG.GA_modificar_PR(EV_numident, EV_tipident, EV_apeclien1, LV_numabonado,
			                                 SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   RAISE LE_fin;
			END IF;

			VE_desbloqueaprepago_PG.VE_generaventacero_PR(LV_numabonado, LV_numventa, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   IF SUBSTR(TRIM(SV_error),1,14)='GA_VENTAS_I_PG' OR
			      SUBSTR(TRIM(SV_error), 1,20)='VE_DESBLOQUEAPREPAGO' THEN
				  RAISE exception_fin;
			   END IF;
			   LV_coderror:=SV_error;
 			   RAISE exception_fin;
			ELSIF TRIM(LV_numventa) IS NULL THEN
			   BEGIN
			      LV_coderror:='ERROR_DATA_NUMVENTA';
				  RAISE exception_fin;
			   END;
			END IF;
			-- Inicio modificacion by SAQL/Soporte 19/10/2005 - XO-200510150887
			UPDATE GA_VENTAS SET
			COD_VENDEDOR = EV_codvendealer,
			COD_VENDEDOR_AGENTE = LV_codvendedor,
			COD_CLIENTE = LV_codcliente,
			COD_TIPCONTRATO = 73
			WHERE NUM_VENTA = LV_numventa;
			-- Fin modificacion by SAQL/Soporte 19/10/2005 - XO-200510150887

			VE_desbloqueaprepago_PG.VE_modificaabonadoprepago_PR(LV_codcliente, LV_codcuenta, LV_codvendedor,
			                                                     LV_numventa, LV_numabonado, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   IF SUBSTR(TRIM(SV_error),1,16)='GA_ABOAMIST_U_PG' OR
			      SUBSTR(TRIM(SV_error), 1,20)='VE_DESBLOQUEAPREPAGO' THEN
				   RAISE exception_fin;
			   END IF;
			   LV_coderror:=SV_error;
 			   RAISE exception_fin;
			END IF;
			-- Inicio modificacion by SAQL/Soporte 19/10/2005 - XO-200510150887
			UPDATE GA_ABOAMIST SET
			COD_VENDEALER = EV_codvendealer
			WHERE NUM_ABONADO = LV_numabonado;
			-- Fin modificacion by SAQL/Soporte 19/10/2005 - XO-200510150887



			VE_desbloqueaprepago_PG.VE_insertamovimiento_PR(LV_numabonado, LV_codtecno, LV_tipterminal, LV_numseriehex,
			                                                LV_codcentral, LV_numcelular, EV_codplantarif, SV_error);

			IF TRIM(SV_error) IS NOT NULL THEN
			   IF SUBSTR(TRIM(SV_error),1,19)='ICC_MOVIMIENTO_I_PG' OR
			      SUBSTR(TRIM(SV_error), 1,20)='VE_DESBLOQUEAPREPAGO' THEN
				    RAISE exception_fin;
			   END IF;
			      LV_coderror:=SV_error;
 			      RAISE exception_fin;
			END IF;

			--XO-200509260738: German Espinoza Z; 02/10/2005
			--COMMIT;
			--FIN/XO-200509260738: German Espinoza Z; 02/10/2005

			SN_numcelular:=LV_numcelular;
			SN_codcliente:=LV_codcliente;
			SN_numventa:=LV_numventa;
			SD_fecalta:=SYSDATE;

			EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			      LV_coderror:='ERROR_NO_DATA_VENDEALER_3';
				  RAISE exception_fin;
			   WHEN TOO_MANY_ROWS THEN
			      LV_coderror:='ERROR_TOO_MANY_VENDEALER';
				  RAISE exception_fin;
		END;

		EXCEPTION
		   WHEN exception_fin THEN
		      IF TRIM(LV_coderror) IS NOT NULL THEN
			     SN_coderror:=VE_retornacoderror_PG.VE_RETORNACODERROR_FN(LV_coderror, SV_error);
			  END IF;
		      ROLLBACK;
		   WHEN LE_fin THEN
		      NULL;
			  ROLLBACK;
		   WHEN OTHERS THEN
              SV_error:='VE_desbloqueaprepago_PG.VE_desbloqueo_PR: ' || TO_CHAR(SQLCODE) || ' ' || SQLERRM;
			  ROLLBACK;
END VE_desbloqueo_PR;

        PROCEDURE VE_insertamovimiento_PR(EN_numabonado IN ga_aboamist.num_abonado%TYPE,
		                                  EV_codtecno IN ga_aboamist.cod_tecnologia%TYPE,
									      EV_tipterminal IN ga_aboamist.tip_terminal%TYPE,
										  EV_numseriehex IN ga_aboamist.num_seriehex%TYPE,
									      EV_codcentral IN ga_aboamist.cod_central%TYPE,
										  EV_numcelular IN ga_aboamist.num_celular%TYPE,
										  EV_codplantarif IN icc_movimiento.plan%TYPE,
									      SV_error OUT NOCOPY VARCHAR2
                                         ) IS

		/*
		<Documentación TipoDoc = "VE_insertamovimiento_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="22-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción>Obtiene los datos necesarios para realñizar un desbloqueo de prepago</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EN_numabonado" Tipo="STRING">Numero Abonado</param>
		<param nom="EV_codtecno" Tipo="STRING">Codigo Tecnologia</param>
		<param nom="EV_tipterminal" Tipo="STRING">Tipo de terminal</param>
		<param nom="EV_numseriehex" Tipo="STRING">Numero de serie en base hexadecimañ</param>
		<param nom="EV_codcentral" Tipo="STRING">Codigo de Central</param>
		<param nom="EV_numcelular" Tipo="STRING">Numero de Celular</param>
		<param nom="EV_nummin" Tipo="STRING">Numero MIN</param>
		<param nom="EV_codplantarif" Tipo="STRING">Codigo de Plan Tarifario</param>
		</Entrada>
		<Salida>
		<param nom="SV_error" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

		exception_fin EXCEPTION;
        LV_num_movimiento icc_movimiento.num_movimiento%TYPE;
		LV_nummin ga_abocel.num_min%TYPE;
		LV_codactcen ga_actabo.cod_actcen%TYPE;
		LN_coderror NUMBER(5);

		--XO-200509260738: German Espinoza Z; 02/10/2005
		LV_num_serie ga_aboamist.num_serie%TYPE;
		LV_num_imei  ga_aboamist.num_imei%TYPE;
		LV_num_imsi  icc_movimiento.imsi%TYPE;

		--CN_codactabo CONSTANT VARCHAR2(2):='VA';
		--Inicio de modificacion Incidencia RA-200511110102, PIC, 14-11-2005, Se cometare variable y se declara una nueva.
		--CN_codactabo CONSTANT VARCHAR2(2):='DQ';
		CN_codactabo  VARCHAR2(2);
		--Fin RA-200511110102.
		--FIN/XO-200509260738: German Espinoza Z; 02/10/2005

		CN_codmodulo CONSTANT VARCHAR2(2):='GA';
		CN_sta CONSTANT CHAR:='N';
		CN_desrespuesta CONSTANT VARCHAR2(10):='PENDIENTE';
		CN_codestado CONSTANT NUMBER(1):=1;

BEGIN
        BEGIN

          --Inicio incidencia RA-200511110102, PIC, 14-11-2005.
          SELECT val_parametro into CN_codactabo
		  FROM ged_parametros
		  WHERE cod_modulo=CN_codmodulo AND
	 	  nom_parametro='COD_DESBLOQUEO_PP';
	 	 --Fin RA-200511110102, PIC, 14-11-2005.
		    SELECT a.num_min
			INTO   LV_nummin
			FROM   ga_aboamist a
			WHERE  a.num_abonado=EN_numabonado;

            EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_NO_DATA_NUMMIN';
			      RAISE exception_fin;
	    END;


		BEGIN
		   SELECT icc_seq_nummov.NEXTVAL
		   INTO   LV_num_movimiento
		   FROM dual;

		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_SEQ_NUMMOV';
				  RAISE exception_fin;
		END;

		--XO-200509260738: German Espinoza Z; 02/10/2005
		BEGIN
		   SELECT num_serie,num_imei,DECODE(cod_tecnologia,'GSM',fn_recupera_imsi(num_serie),NULL)
		   INTO   LV_num_serie,LV_num_imei,LV_num_imsi
		   FROM   ga_aboamist
		   WHERE  num_abonado=EN_numabonado;

		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_SEQ_NUMMOV';
				  RAISE exception_fin;
		END;
		--FIN/XO-200509260738: German Espinoza Z; 02/10/2005

		BEGIN
			SELECT g.cod_actcen
			INTO   LV_codactcen
		    FROM   ga_actabo g
		    WHERE  g.cod_producto = (SELECT p.val_parametro
			                         FROM   ged_parametros p
									 WHERE  p.nom_parametro='PROD_CELULAR'
				   				  	        and p.cod_modulo=CN_codmodulo
									)
		           AND g.cod_modulo = CN_codmodulo
		           AND g.cod_actabo = CN_codactabo
		           AND g.cod_tecnologia = EV_codtecno;

			ICC_movimiento_i_PG.ICC_agregar_PR(LV_num_movimiento, EN_numabonado, CN_codmodulo, CN_codestado, LV_codactcen,
			                                   USER, SYSDATE, EV_codcentral, EV_numcelular, EV_numseriehex, NULL, NULL,
                                               --EV_tipterminal, CN_codactabo, LV_nummin, NULL, EV_codtecno, NULL, NULL, NULL,					--XO-200509260738: German Espinoza Z; 02/10/2005
											   EV_tipterminal, CN_codactabo, LV_nummin, NULL, EV_codtecno, LV_num_imsi,LV_num_imei,LV_num_serie,--XO-200509260738: German Espinoza Z; 02/10/2005
										       LN_coderror, SV_error);

		    EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_NO_DATA_COD_ACTCEN';
				  RAISE exception_fin;
		END;

		EXCEPTION
		   WHEN exception_fin THEN
		       NULL;
		   WHEN OTHERS THEN
		      SV_error:='VE_DESBLOQUEAPREPAGO_PG.VE_INSERTAMOVIMIENTO_PR: ' || TO_CHAR(SQLCODE) || ' ' || SQLERRM;
END VE_insertamovimiento_PR;

		PROCEDURE VE_creacliente_PR(EV_codcta IN ga_cuentas.cod_cuenta%TYPE,
                                    EV_nomcliente IN ge_clientes.nom_apeclien1%TYPE,
                                    EV_numident IN ge_clientes.num_ident%TYPE,
									EV_tipident IN ge_clientes.cod_tipident%TYPE,
									SV_codcliente OUT NOCOPY ge_clientes.cod_cliente%TYPE,
                                    SV_error OUT NOCOPY VARCHAR2
                                   ) IS

        /*
		<Documentación TipoDoc = "VE_creacliente_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="22-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción>Crea un nuevo cliente</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_codcta" Tipo="STRING">Codigo Cuenta</param>
		<param nom="EV_nomcliente" Tipo="STRING">Nombre Cliente</param>
		<param nom="EV_numident" Tipo="STRING">Numero identidad del cliente</param>
		<param nom="EV_tipident" Tipo="STRING">Tipo identidad del cliente</param>
		</Entrada>
		<Salida>
		<param nom="SV_SV_codcliente" Tipo="STRING">Codigo de cliente</param>
		<param nom="SV_ERROR" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

		exception_fin EXCEPTION;
		LN_codcliente ge_clientes.cod_cliente%TYPE;
		LV_codcalclie ge_clientes.cod_calclien%TYPE;
		LV_codabc ge_clientes.cod_abc%TYPE;
		LV_cod123 ge_clientes.cod_123%TYPE;
		LV_codoperadora ge_clientes.cod_operadora%TYPE;
		LV_codamiciclo ge_clientes.cod_ciclo%TYPE;
		CN_idioma CONSTANT VARCHAR2(5):='1';


BEGIN
        BEGIN
		   SELECT ge_seq_clientes.NEXTVAL
		   INTO LN_codcliente
		   FROM dual;

		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_SEQ_CLIENTES';
				  RAISE exception_fin;
		END;

		BEGIN
		  LV_codoperadora:=GE_FN_OPERADORA_SCL;

		  EXCEPTION
		     WHEN NO_DATA_FOUND THEN
			    SV_error:='ERROR_NO_DATA_OPERADORA';
				RAISE exception_fin;
		END;

		BEGIN
		   SELECT h.val_parametro
		   INTO   LV_codamiciclo
		   FROM   ged_parametros h
		   WHERE  h.nom_parametro ='COD_AMI_CICLO'
	   	   		  AND h.cod_modulo='GA'
	   			  AND h.cod_producto=1;

		   EXCEPTION
		     WHEN NO_DATA_FOUND THEN
			    SV_error:='ERROR_NO_DATA_CICLO';
				RAISE exception_fin;
		END;

		BEGIN
		   SELECT m.cod_calclien, m.cod_abc, m.cod_123
		   INTO   lv_codcalclie,lv_codabc, lv_cod123
		   FROM   ga_datosgener m;

		   GE_clientes_i_PG.GE_agregar_PR(LN_codcliente, EV_nomcliente, EV_tipident, EV_numident, LV_codcalclie,
		                                  'S', SYSDATE, 1,'S', 'N', SYSDATE, NULL, NULL, USER, 'V', EV_codcta, 'O',
										  LV_codabc, LV_cod123, NULL,NULL, NULL, NULL, NULL, NULL, NULL, NULL,
										  NULL, NULL, NULL, EV_nomcliente, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
										  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
										  NULL, NULL, NULL, LV_codamiciclo, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
									 	  NULL, NULL, NULL, NULL, NULL, CN_idioma, NULL, NULL, NULL, LV_codoperadora,
										  SV_error);

		   SV_codcliente:=LN_codcliente;

		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_NO_DATA_DATOSGENER';
				  RAISE exception_fin;
		END;

		EXCEPTION
		   WHEN exception_fin THEN
		       NULL;
		   WHEN OTHERS THEN
		       SV_error:='VE_DESBLOQUEAPREPAGO_PG.VE_CREACLIENTE_PR: ' || TO_CHAR(SQLCODE) || ' ' || SQLERRM;
END VE_creacliente_PR;

		PROCEDURE VE_creacuenta_PR(EV_descta IN ga_cuentas.des_cuenta%TYPE,
                                   EV_nomresp IN ga_cuentas.nom_responsable%TYPE,
								   EV_numident IN ga_cuentas.num_ident%TYPE,
								   EV_tipident IN ga_cuentas.cod_tipident%TYPE,
								   EV_coddireccion IN ga_cuentas.cod_direccion%TYPE,
								   SV_codcta OUT NOCOPY ga_cuentas.cod_cuenta%TYPE,
                                   SV_error OUT NOCOPY VARCHAR2
                                  ) IS

		/*
		<Documentación TipoDoc = "VE_CREACUENTA_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="21-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción>Crea una cuenta nueva</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_DESCTA" Tipo="STRING">Descripcion Cuenta</param>
		<param nom="EV_NOMRESP" Tipo="STRING">Nombre responsable de la cuenta</param>
		<param nom="EV_NUMIDENT" Tipo="STRING">Numero identidad del titular de la cuenta</param>
		<param nom="EV_TIPIDENT" Tipo="STRING">Tipo identidad del titular de la cuenta</param>
		<param nom="EV_CODDIRECCION" Tipo="STRING">Codigo de direccion del titular de la cuenta</param>
		</Entrada>
		<Salida>
		<param nom="SV_ERROR" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

        CN_indmuluso  CONSTANT CHAR:='N';
		CN_clienpoten CONSTANT CHAR:='N';
		LN_codcta  ga_cuentas.cod_cuenta%TYPE;

BEGIN
        BEGIN
		    SELECT ga_seq_cuentas.NEXTVAL
			INTO LN_codcta
			FROM dual;


			GA_cuentas_i_PG.GA_agregar_PR(ln_codcta, EV_descta, 'P', EV_nomresp, EV_tipident, EV_numident,
			                              EV_coddireccion, SYSDATE, 'S', NULL, NULL, NULL, NULL, NULL,
									      NULL, NULL, CN_indmuluso, CN_clienpoten, NULL, NULL, NULL, NULL,
									      NULL, SV_error
									     );
            SV_codcta:=LN_codcta;

			EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			       	SV_error:='ERROR_SEQ_CUENTA';
		END;

		EXCEPTION
		   WHEN OTHERS THEN
		       SV_error:='VE_DESBLOQUEAPREPAGO_PG.VE_CREACUENTA_PR: ' || TO_CHAR(SQLCODE) || ' ' || SQLERRM;

END VE_creacuenta_PR;

PROCEDURE VE_obtienenumabonado_PR(EV_codcliente_dist IN ga_aboamist.cod_cuenta_dist%TYPE, EV_imsi IN ga_aboamist.num_imei%TYPE,
                                  SV_numabonado OUT NOCOPY ga_aboamist.num_abonado%TYPE, SV_codtecno OUT NOCOPY ga_aboamist.cod_tecnologia%TYPE,
								  SV_tipterminal OUT NOCOPY ga_aboamist.tip_terminal%TYPE, SV_numseriehex OUT NOCOPY ga_aboamist.num_seriehex%TYPE,
								  SV_codcentral OUT NOCOPY ga_aboamist.cod_central%TYPE, SV_numcelular OUT NOCOPY ga_aboamist.num_celular%TYPE,
								  SV_nummin OUT NOCOPY ga_aboamist.num_min%TYPE, SV_error OUT NOCOPY VARCHAR2
                                 ) IS
        /*
		<Documentación TipoDoc = "VE_OBTIENENUMABONADO_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="21-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción> Retorna el numero de abonado a partir del numero de imsi asociado a un abonado</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_CODCLIENTE_DIST "Tipo="STRING">Codigo cliente distribuidor</param>
		<param nom="EV_IMSI" Tipo="STRING">Imsi asociado a abonado</param>
		</Entrada>
		<Salida>
		<param nom="SV_NUMABONADO" Tipo="STRING">Numero de abonado</param>
		<param nom="SV_CODTECNO" Tipo="STRING">tecnologia abonado</param>
		<param nom="SV_TIPTERMINAL" Tipo="STRING">tipo terminal abonado</param>
		<param nom="SV_NUMSERIEHEX" Tipo="STRING">numero de serie en base hexadecimal</param>
		<param nom="SV_CODCENTRAL" Tipo="STRING">central asociada al abonado</param>
		<param nom="SV_NUMCELULAR" Tipo="STRING">numero celular de abonado</param>
		<param nom="SV_ERROR" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

        exception_fin EXCEPTION;

BEGIN

        BEGIN
		   SELECT  a.num_abonado, a.cod_tecnologia, a.tip_terminal,
		           a.num_seriehex, a.cod_central, a.num_celular,
				   a.num_min
			INTO   SV_numabonado, SV_codtecno, SV_tipterminal,
			       SV_numseriehex, SV_codcentral, SV_numcelular,
				   SV_nummin
			FROM   ga_aboamist a
			WHERE  a.cod_cliente=EV_codcliente_dist
			       AND a.cod_cliente=a.cod_cliente_dist
				   AND a.num_serie=EV_imsi
				   AND a.cod_situacion NOT IN ('BAP','BAA'); --XO-200510200923: German Espinoza Z; 25/10/2005


			EXCEPTION
			    WHEN NO_DATA_FOUND THEN
				     SV_error:='ERROR_NO_DATA_ABONADO';
					 RAISE exception_fin;
			    WHEN TOO_MANY_ROWS THEN
					 SV_error:='ERROR_TOO_MANY_ABONADO';
					 RAISE exception_fin;

		END;

		EXCEPTION
		    WHEN exception_fin THEN
			    NULL;
			WHEN OTHERS THEN
			    SV_error:='VE_DESBLOQUEAPREPAGO_PG.VE_OBTIENENUMABONADO_PR: ' || TO_CHAR(SQLCODE) ||' ' || SQLERRM;


END VE_obtienenumabonado_PR;

PROCEDURE VE_existecliente_PR(EV_numident IN ga_cuentas.num_ident%TYPE,
                              EV_tipident IN ga_cuentas.cod_tipident%TYPE,
							  SV_codcliente OUT NOCOPY ge_clientes.cod_cliente%TYPE,
							  SV_codcuenta  OUT NOCOPY ga_cuentas.cod_cuenta%TYPE,
							  SV_error OUT NOCOPY VARCHAR2
                             ) IS
		/*
		<Documentación TipoDoc = "VE_EXISTECLIENTE_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="21-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción> Retorna el codigo de cliente y codigo de cuenta asociados a un num. ident.</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_NUMIDENT" Tipo="STRING">numero identidad</param>
		<param nom="EV_TIPIDENT" Tipo="STRING">Tipo Num. Ident.</param>
		</Entrada>
		<Salida>
		<param nom="SV_CODCLIENTE" Tipo="STRING">Codigo cliente</param>
		<param nom="SV_CODCUENTA" Tipo="STRING">Codigo cuenta</param>
		<param nom="SV_ERROR" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

		exception_fin    EXCEPTION;
		LV_codcuenta     ga_cuentas.cod_cuenta%TYPE;
		LV_codcliente    ge_clientes.cod_cliente%TYPE;

        BEGIN

		   BEGIN
			   SELECT a.cod_cuenta
			   INTO   LV_codcuenta
			   FROM   ga_cuentas a
	           WHERE  a.num_ident= EV_numident
			          AND a.cod_tipident = EV_tipident;

		   EXCEPTION
		   	  WHEN NO_DATA_FOUND THEN
				  RAISE exception_fin;
			  WHEN TOO_MANY_ROWS THEN
			      NULL;
           END;

		   BEGIN
		      SELECT f.cod_cliente
			  INTO   LV_codcliente
			  FROM   ge_clientes f
			  WHERE  f.cod_cuenta = lv_codcuenta
			         AND f.ind_agente = 'N'
			         AND f.cod_ciclo = (SELECT
					                           h.val_parametro
										FROM   ged_parametros h
										WHERE  h.nom_parametro ='COD_AMI_CICLO'
					                   )
					--XO-200510060816: German Espinoza Z; 18/10/2005
					AND f.fec_alta=(SELECT MAX(fec_alta)
								  	FROM   ge_clientes
									WHERE  cod_cuenta = f.cod_cuenta
									AND    ind_agente   = f.ind_agente
									AND    cod_ciclo    = f.cod_ciclo );
					--FIN/XO-200510060816: German Espinoza Z; 18/10/2005

			  SV_codcliente:=LV_codcliente;
			  SV_codcuenta:=LV_codcuenta;

			  EXCEPTION
			   	  WHEN NO_DATA_FOUND THEN
					  RAISE exception_fin;
				  WHEN TOO_MANY_ROWS THEN
				      NULL;
		   END;

		   EXCEPTION
		      WHEN exception_fin THEN
			      NULL;
			  WHEN OTHERS THEN
			      SV_error:='VE_DESBLOQUEAPREPAGO_PG.VE_EXISTECLIENTE_PR: ' || TO_CHAR(SQLCODE) || ' ' || SQLERRM;

END VE_existecliente_PR;

PROCEDURE VE_modificaabonadoprepago_PR(EV_codcliente IN ge_clientes.cod_cliente%TYPE,
									   EV_codcuenta IN ga_cuentas.cod_cuenta%TYPE,
									   EV_codvendedor IN ga_aboamist.cod_vendedor%TYPE,
									   EV_numventa IN ga_aboamist.num_venta%TYPE,
									   EV_numabonado IN ga_aboamist.num_abonado%TYPE,
									   SV_error OUT NOCOPY VARCHAR2
                                      ) IS

     /*
		<Documentación TipoDoc = "VE_MODIFICAABONADOPREPAGO_PR>"
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="21-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción> Modifica algunos datos del abonado prepago</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_CODCLIENTE" Tipo="STRING">Codigo Cliente</param>
		<param nom="EV_CODCUENTA" Tipo="STRING">Cod. cuenta</param>
		<param nom="EV_CODVENDEDOR" Tipo="STRING">Cod. Vendedor</param>
		<param nom="EV_NUMVENTA" Tipo="STRING">Num. Venta</param>
		<param nom="EV_NUMABONADO" Tipo="STRING">Num. Abonado</param>
		</Entrada>
		<Salida>
		<param nom="SV_ERROR" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

     exception_fin  EXCEPTION;
     LN_codusuario  ga_usuamist.cod_usuario%TYPE;

BEGIN


		BEGIN
		   SELECT f.cod_usuario
		   INTO   LN_codusuario
		   FROM   ga_usuamist f
		   WHERE  f.num_abonado=EV_numabonado;

		   GA_aboamist_u_PG.GA_modificar_PR(EV_codcliente, EV_codcuenta, EV_codvendedor, EV_numventa,
		                                    EV_numabonado, LN_codusuario, SV_error);


		   EXCEPTION
		       WHEN NO_DATA_FOUND THEN
			         SV_error:='ERROR_NO_DATA_USUARIO';
					 RAISE exception_fin;
			   WHEN TOO_MANY_ROWS THEN
					 SV_error:='ERROR_TOO_MANY_USUARIO';
					 RAISE exception_fin;
		END;


		EXCEPTION
		    WHEN exception_fin THEN
			    NULL;
			WHEN OTHERS THEN
			    SV_error:='VE_DESBLOQUEAPREPAGO_PG.VE_MODIFICAABONADOPREPAGO_PR: ' || TO_CHAR(SQLCODE) ||' ' || SQLERRM;
END VE_modificaabonadoprepago_PR;

PROCEDURE VE_generaventacero_PR (EN_numabonado IN ga_aboamist.num_abonado%TYPE,
                                 SN_numventa OUT NOCOPY ga_aboamist.num_venta%TYPE,
                                 SV_error OUT NOCOPY VARCHAR2) IS

        /*
		<Documentación TipoDoc = VE_GENERAVENTACERO_PR>
		<Elemento Nombre = "PROCEDURE" Lenguaje="PL/SQL" Fecha="21-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD>
		<Retorno>NA</Retorno>
		<Descripción>Genera una venta con monto cero</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="EV_NUMABONADO" Tipo="STRING">Num. Abonado</param>
		</Entrada>
		<Salida>
		<param nom="SN_NUMVENTA" Tipo="STRING">Numero de venta generada</param>
		<param nom="SV_ERROR" Tipo="STRING">Descripcion de un eventual error en la ejecucion del procedimiento</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/

	 exception_fin         EXCEPTION;
     LV_codproducto        ga_ventas.cod_producto%TYPE;
	 LV_codoficina         ga_ventas.cod_oficina%TYPE;
	 LV_codtipcomis        ga_ventas.cod_tipcomis%TYPE;
	 LV_codvendedor        ga_ventas.cod_vendedor%TYPE;
	 LV_codvendedoragente  ga_ventas.cod_vendedor_agente%TYPE;
	 LD_fecventa           ga_ventas.fec_venta%TYPE;
	 LV_codregion          ga_ventas.cod_region%TYPE;
	 LV_codprovincia       ga_ventas.cod_provincia%TYPE;
	 LV_codciudad          ga_ventas.cod_ciudad%TYPE;
	 LV_indestventa        ga_ventas.ind_estventa%TYPE;
	 LN_numtransaccion     ga_ventas.num_transaccion%TYPE;
	 LN_indpasocob		   ga_ventas.ind_pasocob%TYPE;
	 LV_nomusuarvta        ga_ventas.nom_usuar_vta%TYPE;
	 LV_ind_venta          ga_ventas.ind_venta%TYPE;
     LV_numventa           ga_ventas.num_venta%type;
	 LV_codOperLocal       ga_ventas.cod_operadora%type;  --XO-200510200923: German Espinoza Z; 24/10/2005

BEGIN
        BEGIN
		   SELECT v.cod_producto, v.cod_oficina, v.cod_tipcomis,
		          v.cod_vendedor, v.cod_vendedor_agente,
				  SYSDATE, v.cod_region, v.cod_provincia,
				  v.cod_ciudad, v.ind_estventa, v.num_transaccion, v.ind_pasocob,
				  v.nom_usuar_vta, v.ind_venta
		   INTO   LV_codproducto, LV_codoficina, LV_codtipcomis, LV_codvendedor,
	              LV_codvendedoragente, LD_fecventa, LV_codregion, LV_codprovincia,
	              LV_codciudad, LV_indestventa, LN_numtransaccion, LN_indpasocob,
	              LV_nomusuarvta, LV_ind_venta
		   FROM   ga_aboamist a, ga_ventas v
		   WHERE  a.num_abonado=EN_numabonado
		   		  AND a.num_venta=v.num_venta;

		   EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_NO_DATA_VENTA';
		          RAISE exception_fin;
		END;

		BEGIN

		  SELECT ga_seq_venta.NEXTVAL
		  INTO   LV_numventa
		  FROM   dual;

		  LV_codOperLocal := ge_fn_operadora_Scl;


		  GA_ventas_i_PG.GA_agregar_PR(LV_numventa, LV_codproducto, LV_codoficina, LV_codtipcomis, LV_codvendedor,
	       							   LV_codvendedoragente, 1, LD_fecventa, LV_codregion, LV_codprovincia,
									   LV_codciudad, LV_indestventa, LN_numtransaccion, LN_indpasocob,
									   LV_nomusuarvta, LV_ind_venta , NULL, NULL, 0, NULL, NULL, NULL, NULL,
									   NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
									   NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
									   NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
									   --NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SV_error); --XO-200510200923: German Espinoza Z; 24/10/2005
									   NULL, NULL, NULL, NULL, NULL, NULL, NULL, LV_codOperLocal, NULL, SV_error); --XO-200510200923: German Espinoza Z; 24/10/2005


		  SN_numventa:=LV_numventa;

		  EXCEPTION
		      WHEN NO_DATA_FOUND THEN
			      SV_error:='ERROR_SEQ_NUMVENTA';
		          RAISE exception_fin;
		END;

		EXCEPTION
		    WHEN exception_fin THEN
			     NULL;
		    WHEN OTHERS THEN
			    SV_error:='VE_DESBLOQUEAPREPAGO_PG.VE_GENERAVENTACERO_PR: ' || TO_CHAR(SQLCODE) ||' ' || SQLERRM;
END VE_generaventacero_PR;

END VE_desbloqueaprepago_PG;
/
SHOW ERRORS
