CREATE OR REPLACE PACKAGE BODY PR_reglas_producto_PG AS

PROCEDURE PR_valida_reglas_prod_PR(	EV_plan_orig      IN  GA_abocel.cod_plantarif%TYPE,
									EV_plan_dest      IN  GA_abocel.cod_plantarif%TYPE,
									EN_cod_cliente    IN  GA_abocel.cod_cliente%TYPE,
									EN_num_abonado    IN  GA_abocel.num_abonado%TYPE,
									SV_cadena_act     OUT NOCOPY VARCHAR2,
									SV_cadena_des     OUT NOCOPY VARCHAR2,
							        SN_cod_retorno 	  OUT NOCOPY ge_errores_pg.CodError,
							        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
							        SN_num_evento 	  OUT NOCOPY ge_errores_pg.Evento) IS

/*--
<Documentacion TipoDoc = "Procedimiento">
Elemento Nombre = "PR_valida_reglas_prod_PR"
Lenguaje="PL/SQL"
Fecha="31-07-2007"
Version="1.0.0"
Dise?ador="Ricardo Roco."
Programador="Christian Estay M."
Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
   Devuelve la cadena de servicios a desactivar por un determinado plan tarifario.
</Descripcion>
<Parametros>
<Entrada>
<param nom="EV_plan_orig  " Tipo="VARCHAR> codigo del plan origen</param>
<param nom="EV_plan_dest    Tipo="VARCHAR> codigo del plan destino</param>
<param nom="EN_cod_cliente" Tipo="NUMBER>  codigo del cliente</param>
<param nom="EN_num_abonado" Tipo="NUMBER>  numero de abonado</param>
</Entrada>
<Salida>
<param nom="SN_cod_retorno" Tipo="NUMBER"> codigo retorno </param>
<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
<param nom="SN_num_evento" Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/

LV_Sql 		 ge_errores_pg.vQuery;
LV_des_error ge_errores_pg.DesEvent;
LV_prod      PF_PRODUCTOS_OFERTADOS_TD.COD_PROD_OFERTADO%TYPE;

LV_cadena_activar      VARCHAR2(240):='';
LV_cadena_abocli_def   VARCHAR2(240):='';
LV_cadena_abocli_opc   VARCHAR2(240):='';
LV_flag                VARCHAR2(6):='TRUE';
LV_cad_prod_abo        VARCHAR2(8):='';
LV_cad_prod_act        VARCHAR2(8):='';

LN_posactf             NUMBER(8):=0;
LN_posabof             NUMBER(8):=0;
LN_posfin_abo          NUMBER(8):=0;
LN_posfin_act          NUMBER(8):=0;
LN_encontrado          NUMBER(8):=0;
LN_count               NUMBER(8):=1;

ERROR_PROCEDIMIENTOS     EXCEPTION;

BEGIN


	SN_num_evento:= 0;
	SN_cod_retorno:=0;
	SV_mens_retorno:='Proceso Exitoso';


	-- Recuperamos la Cadena de servicios a Activar
	PR_recupera_prod_activar_PR(EV_plan_dest,LV_cadena_activar,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	IF SN_cod_retorno > 0 THEN
	   RAISE ERROR_PROCEDIMIENTOS;
	END IF;
	dbms_output.put_line('LV_cadena_activar -> ' || LV_cadena_activar);

	-- Recuperamos la Cadena de servicios del Abonado x Defecto
	PR_recupera_prod_abonado_PR(EN_cod_cliente,EN_num_abonado,'D',LV_cadena_abocli_def,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	IF SN_cod_retorno > 0 THEN
	   RAISE ERROR_PROCEDIMIENTOS;
	END IF;
	dbms_output.put_line('LV_cadena_abocli_def -> ' || LV_cadena_abocli_def);

	-- Recuperamos la Cadena de servicios del Abonado x Opcionales
	PR_recupera_prod_abonado_PR(EN_cod_cliente,EN_num_abonado,'O',LV_cadena_abocli_opc,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	IF SN_cod_retorno > 0 THEN
	   RAISE ERROR_PROCEDIMIENTOS;
	END IF;
	dbms_output.put_line('LV_cadena_abocli_opc -> ' || LV_cadena_abocli_opc);

	-- Validamos la categoria de los planes  FLAG = TRUE quiere decir que debemos mantener los planes opcionales
	PR_valida_categoria_planes_PR(EV_plan_orig ,EV_plan_dest ,LV_flag ,SN_cod_retorno ,SV_mens_retorno ,SN_num_evento );
	IF SN_cod_retorno > 0 THEN
	   RAISE ERROR_PROCEDIMIENTOS;
	END IF;
	dbms_output.put_line('LV_flag -> ' || LV_flag);

	--trabajamos solo si una de las cadena trae registro

	IF (LENGTH(LV_cadena_activar) > 0) AND (LENGTH(LV_cadena_abocli_def) > 0 ) THEN
		LN_posactf := length(lv_cadena_activar) / 8;
		LN_posabof := length(lv_cadena_abocli_def) / 8;


		-- Buscamos si el producto a desactivar esta en los ha activar
	    FOR LN_count IN 1..LN_posabof LOOP

	       LV_cad_prod_abo := SUBSTR(lv_cadena_abocli_def, 1 + LN_posfin_abo, 8 + LN_posfin_abo);
	       dbms_output.put_line('Producto ABONADO -> ' || LV_cad_prod_abo || 'Vamos en la Fila ->' || LN_count);
		   LN_encontrado := 0;
		   dbms_output.put_line('Buscando en Prod a Activar');
		   FOR LN_count IN 1..LN_posactf LOOP

		       LV_cad_prod_act := SUBSTR(LV_cadena_Activar, 1 + LN_posfin_act, 8 + LN_posfin_act);
		       dbms_output.put_line('Producto Activar -> ' || LV_cad_prod_act);

			   IF LV_cad_prod_abo = LV_cad_prod_act THEN
			      --Encontrado
				  dbms_output.put_line('Lo Encontro lo Desactivamos y Activamos ->' || LV_cad_prod_act);
		   		  SV_cadena_des := SV_cadena_des || LV_cad_prod_abo;
		   		  SV_cadena_act := SV_cadena_act || LV_cad_prod_abo;
				  LN_encontrado := 1;
			   END IF;
			   LN_posfin_act := LN_posfin_act + 8;
	       END LOOP;
		   IF LN_encontrado = 0 THEN
		      dbms_output.put_line('No lo Encontro lo Desactivamos ->' || LV_cad_prod_abo);
		   	  SV_cadena_des := SV_cadena_des || LV_cad_prod_abo;
		   END IF;
		   LN_posfin_abo := LN_posfin_abo + 8;
        END LOOP;

		dbms_output.put_line('*************** Segunda vuelta **************');

	    FOR LN_count IN 1..LN_posactf LOOP

	       LV_cad_prod_act := SUBSTR(LV_cadena_Activar, 1 + LN_posfin_act, 8 + LN_posfin_act);
	       dbms_output.put_line('Producto Activar -> ' || LV_cad_prod_act);
		   LN_encontrado := 0;
		   dbms_output.put_line('Buscando en Prod del Abonado');
		   FOR LN_count IN 1..LN_posabof LOOP
		       LV_cad_prod_abo := SUBSTR(LV_cadena_abocli_def, 1 + LN_posfin_abo, 8 + LN_posfin_abo);
		       dbms_output.put_line('Producto Abonado -> ' || LV_cad_prod_abo);
			   IF LV_cad_prod_abo = LV_cad_prod_act THEN
			      --Encontrado
				  dbms_output.put_line('Lo encontro no hacemos nada');
				  LN_encontrado := 1;
			   END IF;
			   LN_posfin_abo := LN_posfin_abo + 8;
	       END LOOP;
		   IF LN_encontrado = 0 THEN
		      dbms_output.put_line('No lo Encontro lo Activamos ->' || LV_cad_prod_act);
		   	  SV_cadena_act := SV_cadena_act || LV_cad_prod_act;
		   END IF;
		   LN_posfin_act := LN_posfin_act + 8;
        END LOOP;

	ELSE
	    NULL;
	END IF;




EXCEPTION

	WHEN NO_DATA_FOUND THEN

		 SN_cod_retorno:=1;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='NO_DATA_FOUND:PR_valida_reglas_prod_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo,SV_mens_retorno, '1.0', USER,
		 'PR_valida_reglas_prod_PR(Cliente ->' || EN_cod_cliente || ' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

	WHEN ERROR_PROCEDIMIENTOS THEN
		 SN_cod_retorno:=156;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='NO_DATA_FOUND:PR_valida_reglas_prod_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo,SV_mens_retorno, '1.0', USER,
		 'PR_valida_reglas_prod_PR(Cliente ->' || EN_cod_cliente || ' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

	WHEN OTHERS THEN

		 SN_cod_retorno:=156;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='OTHERS:PR_valida_reglas_prod_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo,SV_mens_retorno, '1.0', USER,
		 'PR_valida_reglas_prod_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

END PR_valida_reglas_prod_PR;

--************************************ RECUPERA PRODUCTOS A ACTIVAR *******************************

PROCEDURE PR_recupera_prod_activar_PR(EV_plan	         IN  ta_plantarif.cod_plantarif%TYPE,
									  SV_cadena_activar  OUT NOCOPY ga_abocel.clase_servicio%TYPE,
									  SN_cod_retorno 	 OUT NOCOPY ge_errores_pg.CodError,
									  SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
									  SN_num_evento 	 OUT NOCOPY ge_errores_pg.Evento) IS

/*--

<Documentacion TipoDoc = "Procedimiento">
Elemento Nombre = "PR_recupera_productos_activar_PR"
Lenguaje="PL/SQL"
Fecha="29-07-2007"
Version="1.0.0"
Dise?ador="Ricardo Roco."
Programador="Christian Estay M."
Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
   Devuelve la cadena de servicios a activar por un determinado plan tarifario.
</Descripcion>
<Parametros>
<Entrada>
<param nom="EV_plan" Tipo="VARCHAR> plan tarifario</param>
</Entrada>
<Salida>
<param nom="SV_cadena_activar" Tipo="VARCHAR2"> cadena a activar </param>
<param nom="SN_cod_retorno" Tipo="NUMBER"> codigo retorno </param>
<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
<param nom="SN_num_evento" Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/

CV_modulo_GA	 		 VARCHAR2(30):= 'GA';
CV_error_no_clasif       VARCHAR2(30):= 'Error no Clasificado';
CV_enproceso             VARCHAR2(30):= 'En Proceso';
CV_procesoexi            VARCHAR2(30):= 'Proceso Existoso';


LV_Sql ge_errores_pg.vQuery;
LV_des_error ge_errores_pg.DesEvent;
LV_prod  PF_PRODUCTOS_OFERTADOS_TD.COD_PROD_OFERTADO%TYPE;

CURSOR cur_cad_activar IS
    SELECT B.COD_PROD_OFERTADO
      FROM TA_PLANTARIF C, PF_PAQUETE_OFERTADO_TO A, PF_PRODUCTOS_OFERTADOS_TD B
 	 WHERE C.COD_PLANTARIF = EV_plan
	   AND A.COD_PROD_PADRE = C.COD_PROD_PADRE
	   AND A.COD_PROD_HIJO = B.COD_PROD_OFERTADO
	   AND SYSDATE BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA;


BEGIN

	SN_num_evento:= 0;
	SN_cod_retorno:=0;
	SV_mens_retorno:='Proceso Exitoso';
	SV_cadena_activar:='';

	OPEN cur_cad_activar;
        LOOP
            FETCH cur_cad_activar INTO LV_prod;
			EXIT WHEN cur_cad_activar%NOTFOUND;

			SV_cadena_activar := SV_cadena_activar || '|'  ||TO_CHAR(LV_prod,'00000000');

 		END LOOP;
	CLOSE cur_cad_activar;



EXCEPTION

	WHEN NO_DATA_FOUND THEN

		 SN_cod_retorno:=1;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='NO_DATA_FOUND:PR_recupera_prod_activar_PR('|| EV_plan ||');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
		 'PR_recupera_prod_activar_PR(' || EV_plan || ')', LV_Sql, SQLCODE, LV_des_error );

	WHEN OTHERS THEN

		 SN_cod_retorno:=156;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='OTHERS:PR_recupera_prod_activar_PR('|| EV_plan ||');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
		 'PR_recupera_prod_activar_PR(' || EV_plan || ')', LV_Sql, SQLCODE, LV_des_error );

END PR_recupera_prod_activar_PR;


--*************************************** RECUPERA PRODUCTOS DEL ABONADO  *********************

PROCEDURE PR_recupera_prod_abonado_PR(EN_cod_cliente    IN  ga_abocel.cod_cliente%TYPE,
									  EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
									  EN_condicion		IN  PR_PRODUCTOS_CONTRATADOS_TO.IND_CONDICION_CONTRATACION%TYPE,
									  SV_cadena_abonado OUT NOCOPY ga_abocel.clase_servicio%TYPE,
									  SN_cod_retorno 	OUT NOCOPY ge_errores_pg.CodError,
									  SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
									  SN_num_evento 	OUT NOCOPY ge_errores_pg.Evento) IS

/*--
<Documentacion TipoDoc = "Procedimiento">
Elemento Nombre = "PR_recupera_productos_abonado_PR"
Lenguaje="PL/SQL"
Fecha="31-07-2007"
Version="1.0.0"
Dise?ador="Ricardo Roco."
Programador="Christian Estay M."
Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
   Devuelve la cadena de servicios a desactivar por un determinado plan tarifario.
</Descripcion>
<Parametros>
<Entrada>
<param nom="EN_cod_cliente" Tipo="NUMBER> codigo del cliente</param>
<param nom="EN_num_abonado" Tipo="NUMBER> numero de abonado</param>
</Entrada>
<Salida>
<param nom="SV_cadena_abonado" Tipo="VARCHAR2"> cadena a desactivar </param>
<param nom="SN_cod_retorno" Tipo="NUMBER"> codigo retorno </param>
<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
<param nom="SN_num_evento" Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/

CV_modulo_GA	 		 VARCHAR2(30):= 'GA';
CV_error_no_clasif       VARCHAR2(30):= 'Error no Clasificado';
CV_enproceso             VARCHAR2(30):= 'En Proceso';
CV_procesoexi            VARCHAR2(30):= 'Proceso Existoso';


LV_Sql 		 ge_errores_pg.vQuery;
LV_des_error ge_errores_pg.DesEvent;
LV_prod      PF_PRODUCTOS_OFERTADOS_TD.COD_PROD_OFERTADO%TYPE;

CURSOR cur_cad_abonado IS
	 SELECT A.COD_PROD_CONTRATADO
	   FROM PR_PRODUCTOS_CONTRATADOS_TO A, PF_PRODUCTOS_OFERTADOS_TD B
	  WHERE (A.COD_CLIENTE_BENEFICIARIO = EN_cod_cliente OR EN_cod_cliente = 0)
	    AND (A.NUM_ABONADO_BENEFICIARIO = EN_num_abonado OR EN_num_abonado = 0)
		AND A.COD_PROD_OFERTADO = B.COD_PROD_OFERTADO
		AND A.IND_CONDICION_CONTRATACION = EN_condicion
		AND SYSDATE BETWEEN A.FEC_INICIO_VIGENCIA AND A.FEC_TERMINO_VIGENCIA
		AND SYSDATE BETWEEN B.FEC_INICIO_VIGENCIA AND B.FEC_TERMINO_VIGENCIA;


BEGIN

	SN_num_evento:= 0;
	SN_cod_retorno:=0;
	SV_mens_retorno:='Proceso Exitoso';
	SV_cadena_abonado:='';

	OPEN cur_cad_abonado;
        LOOP
            FETCH cur_cad_abonado INTO LV_prod;
			EXIT WHEN cur_cad_abonado%NOTFOUND;

			SV_cadena_abonado := ltrim(rtrim(SV_cadena_abonado)) || TO_CHAR(LV_prod,'00000000') || '|' ;

 		END LOOP;
	CLOSE cur_cad_abonado;



EXCEPTION

	WHEN NO_DATA_FOUND THEN

		 SN_cod_retorno:=1;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='NO_DATA_FOUND:PR_recupera_prod_abonado_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
		 'PR_recupera_prod_abonado_PR(Cliente ->' || EN_cod_cliente || ' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

	WHEN OTHERS THEN

		 SN_cod_retorno:=156;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='OTHERS:PR_recupera_prod_abonado_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
		 'PR_recupera_prod_abonado_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

END PR_recupera_prod_abonado_PR;


-- ********************************** Valida las Categorias de los planes *************************************
PROCEDURE PR_valida_categoria_planes_PR(EV_plan_orig      IN  ga_abocel.cod_plantarif%TYPE,
	   	  		  										  EV_plan_dest      IN  ga_abocel.cod_plantarif%TYPE,
												          SV_flag   	    OUT NOCOPY VARCHAR2,
												          SN_cod_retorno 	OUT NOCOPY ge_errores_pg.CodError,
												          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
												          SN_num_evento 	OUT NOCOPY ge_errores_pg.Evento) IS

/*--
<Documentacion TipoDoc = "Procedimiento">
Elemento Nombre = "PR_valida_categoria_planes_PR"
Lenguaje="PL/SQL"
Fecha="31-07-2007"
Version="1.0.0"
Dise?ador="Ricardo Roco."
Programador="Christian Estay M."
Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
   Devuelve TRUE    Si la categoria origen es menor
            FALSE   Si la categoria origen es mayor
</Descripcion>
<Parametros>
<Entrada>
<param nom="EN_plan_origen" Tipo="VARCHAR> codigo del plan origen</param>
<param nom="EN_plan_destino" Tipo="VARCHAR> codigo del plan destino</param>
</Entrada>
<Salida>
<param nom="SV_flag" Tipo="VARCHAR2"> Falg con TRUE o FALSE  </param>
<param nom="SN_cod_retorno" Tipo="NUMBER"> codigo retorno </param>
<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
<param nom="SN_num_evento" Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/

CV_modulo_GA	 		 VARCHAR2(30):= 'GA';
CV_error_no_clasif       VARCHAR2(30):= 'Error no Clasificado';
CV_enproceso             VARCHAR2(30):= 'En Proceso';
CV_procesoexi            VARCHAR2(30):= 'Proceso Existoso';


LV_Sql 		 ge_errores_pg.vQuery;
LV_des_error ge_errores_pg.DesEvent;
LV_prod      PF_PRODUCTOS_OFERTADOS_TD.COD_PROD_OFERTADO%TYPE;

nImpCargo_orig      TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
nImpCargo_dest      TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;

BEGIN

	SN_num_evento:= 0;
	SN_cod_retorno:=0;
	SV_mens_retorno:='';
	SV_flag:='TRUE';

	SELECT B.IMP_CARGOBASICO
	  INTO nImpCargo_orig
	  FROM TA_PLANTARIF A, TA_CARGOSBASICO B
	 WHERE A.COD_PLANTARIF = EV_plan_orig
	   AND A.COD_CARGOBASICO = B.COD_CARGOBASICO;


	SELECT B.IMP_CARGOBASICO
	  INTO nImpCargo_dest
	  FROM TA_PLANTARIF A, TA_CARGOSBASICO B
	 WHERE A.COD_PLANTARIF = EV_plan_dest
	   AND A.COD_CARGOBASICO = B.COD_CARGOBASICO;


    if nImpCargo_orig >= nImpCargo_dest then
	   SV_flag := 'FALSE';
	end if;


EXCEPTION

	WHEN NO_DATA_FOUND THEN

		 SN_cod_retorno:=1;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='NO_DATA_FOUND:PR_valida_categoria_planes_PR(Plan O. ->'|| EV_plan_orig ||' Plan D. -> ' || EV_plan_dest || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
		 'PR_valida_categoria_planes_PR(Plan O. ->'|| EV_plan_orig ||' Plan D. -> ' || EV_plan_dest || ')', LV_Sql, SQLCODE, LV_des_error );

	WHEN OTHERS THEN

		 SN_cod_retorno:=156;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='OTHERS:PR_valida_categoria_planes_PR(Plan O. ->'|| EV_plan_orig ||' Plan D. -> ' || EV_plan_dest || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
		 'PR_valida_categoria_planes_PR(Plan O. ->'|| EV_plan_orig ||' Plan D. -> ' || EV_plan_dest || ')', LV_Sql, SQLCODE, LV_des_error );

END PR_valida_categoria_planes_PR;

-- ********************************* Inicio Vetados ***************

PROCEDURE PR_actualiza_prod_vetados_PR(EN_cod_cliente    IN  ga_abocel.cod_cliente%TYPE,
   	  		  						   EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
									   EN_condicion		 IN  PR_PRODUCTOS_CONTRATADOS_TO.IND_CONDICION_CONTRATACION%TYPE,
									   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
									   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
									   SN_num_evento 	 OUT NOCOPY ge_errores_pg.Evento) IS


/*--
<Documentacion TipoDoc = "Procedimiento">
Elemento Nombre = "PR_actualiza_prod_vetados_PR"
Lenguaje="PL/SQL"
Fecha="31-07-2007"
Version="1.0.0"
Dise?ador="Ricardo Roco."
Programador="Christian Estay M."
Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
</Descripcion>
<Parametros>
<Entrada>
<param nom="EN_cod_cliente" Tipo="NUMBER>  codigo del cliente</param>
<param nom="EN_num_abonado" Tipo="NUMBER>  numero de abonado</param>
<param nom="EN_condicion" Tipo="VARCHAR> Indica la Accion a realizar en el vetado A='ABRIR' C='CERRAR'</param>
</Entrada>
<Salida>
<param nom="SV_flag" Tipo="VARCHAR2"> Falg con TRUE o FALSE  </param>
<param nom="SN_cod_retorno" Tipo="NUMBER"> codigo retorno </param>
<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
<param nom="SN_num_evento" Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/

LV_Sql 		 ge_errores_pg.vQuery;
LV_des_error ge_errores_pg.DesEvent;

BEGIN

	SN_num_evento:= 0;
	SN_cod_retorno:=0;
	SV_mens_retorno:='Proceso Exitoso';


	-- Abrimos el Vetado
	IF (LTRIM(RTRIM(EN_condicion)) = 'A') THEN
	   UPDATE CU_VETADOS_PROD_TO SET
	          FEC_INICIO_VIGENCIA = SYSDATE,
			  FEC_TERMINO_VIGENCIA = NULL
		WHERE COD_CLIENTE = EN_cod_cliente
		  AND NUM_ABONADO = EN_num_abonado;
    ELSE
	   UPDATE CU_VETADOS_PROD_TO SET
			  FEC_TERMINO_VIGENCIA = SYSDATE
		WHERE COD_CLIENTE = EN_cod_cliente
		  AND NUM_ABONADO = EN_num_abonado;
	END IF;


EXCEPTION

	WHEN NO_DATA_FOUND THEN

		 SN_cod_retorno:=1;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='NO_DATA_FOUND:PR_actualiza_prod_vetados_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo,SV_mens_retorno, '1.0', USER,
		 'PR_actualiza_prod_vetados_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

	WHEN OTHERS THEN

		 SN_cod_retorno:=156;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='OTHERS:PR_actualiza_prod_vetados_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo,SV_mens_retorno, '1.0', USER,
		 'PR_actualiza_prod_vetados_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );


end PR_actualiza_prod_vetados_PR;

-- ************************************************************************************************************

-- ********************************* Inicio Beneficiarios ***************

PROCEDURE PR_actualiza_prod_benef_PR(EN_cod_cliente    IN  ga_abocel.cod_cliente%TYPE,
   	  		  						 EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
									 EN_condicion		 IN  PR_PRODUCTOS_CONTRATADOS_TO.IND_CONDICION_CONTRATACION%TYPE,
									 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
									 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
									 SN_num_evento 	 OUT NOCOPY ge_errores_pg.Evento) IS


/*--
<Documentacion TipoDoc = "Procedimiento">
Elemento Nombre = "PR_actualiza_prod_benef_PR"
Lenguaje="PL/SQL"
Fecha="31-07-2007"
Version="1.0.0"
Dise?ador="Ricardo Roco."
Programador="Christian Estay M."
Ambiente="BD"
<Retorno>NA</Retorno>
<Descripcion>
</Descripcion>
<Parametros>
<Entrada>
<param nom="EN_cod_cliente" Tipo="NUMBER>  codigo del cliente</param>
<param nom="EN_num_abonado" Tipo="NUMBER>  numero de abonado</param>
<param nom="EN_condicion" Tipo="VARCHAR> Indica la Accion a realizar en el Beneficiario A='ABRIR' C='CERRAR'</param>
</Entrada>
<Salida>
<param nom="SN_cod_retorno" Tipo="NUMBER"> codigo retorno </param>
<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
<param nom="SN_num_evento" Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/

LV_Sql 		 ge_errores_pg.vQuery;
LV_des_error ge_errores_pg.DesEvent;


BEGIN

	SN_num_evento:= 0;
	SN_cod_retorno:=0;
	SV_mens_retorno:='Proceso Exitoso';

	-- Abrimos el Beneficiario
	IF (LTRIM(RTRIM(EN_condicion)) = 'A') THEN
	   UPDATE CU_BENEF_PROD_TO SET
	          FEC_INICIO_VIGENCIA = SYSDATE,
			  FEC_TERMINO_VIGENCIA = NULL
		WHERE COD_CLIENTE_CONTRATANTE = EN_cod_cliente
		  AND NUM_ABONADO_CONTRATANTE = EN_num_abonado;
    ELSE
	   UPDATE CU_BENEF_PROD_TO SET
			  FEC_TERMINO_VIGENCIA = SYSDATE
		WHERE COD_CLIENTE_CONTRATANTE = EN_cod_cliente
		  AND NUM_ABONADO_CONTRATANTE = EN_num_abonado;
	END IF;



EXCEPTION

	WHEN NO_DATA_FOUND THEN

		 SN_cod_retorno:=1;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='NO_DATA_FOUND:PR_actualiza_prod_benef_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo,SV_mens_retorno, '1.0', USER,
		 'PR_actualiza_prod_benef_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );

	WHEN OTHERS THEN

		 SN_cod_retorno:=156;
		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		 	SV_mens_retorno:=CV_error_no_clasif;
		 END IF;

		 LV_des_error:='OTHERS:PR_actualiza_prod_benef_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ');- ' || SQLERRM;
		 SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, cv_cod_modulo,SV_mens_retorno, '1.0', USER,
		 'PR_actualiza_prod_benef_PR(Cliente ->'|| EN_cod_cliente ||' Abonado -> ' || EN_num_abonado || ')', LV_Sql, SQLCODE, LV_des_error );


end PR_actualiza_prod_benef_PR;

-- ************************************************************************************************************



END PR_reglas_producto_PG;
/
SHOW ERRORS
