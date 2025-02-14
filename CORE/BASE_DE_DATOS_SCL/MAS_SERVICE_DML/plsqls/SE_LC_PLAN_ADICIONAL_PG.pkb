CREATE OR REPLACE PACKAGE BODY SE_LC_PLAN_ADICIONAL_PG
IS

   PROCEDURE SE_OBTIENE_LC_PR(
	EO_PLANES_ADIC   	IN  SE_DETALLE_ESPEC_TO_QT,
	EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
    SO_LIMITES			OUT NOCOPY	refcursor,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
    )    IS

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "SE_OBTIENE_LC_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Obtiene los posibles limites de consumo para un plan adicional</Descripción>>
       <Parámetros>
          <Entrada>
				<param nom ="EO_PLANES_ADIC" tipo="OBJETO">Estructura con el código del plan adicional</param>

          </Entrada>
          <Salida>
             <param nom="SO_LIMITES" Tipo="CURSOR">Cursor con los límites de consumo del plan adicional</param>
             <param nom="SN_cod_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SV_mens_retorno" Tipo="NUMERICO">Numero de Evento</param>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error  ge_errores_pg.DesEvent;
LV_sSql       ge_errores_pg.vQuery;
ERROR_PARAMETROS EXCEPTION;
LN_COD_CLIENTE GE_CLIENTES.COD_CLIENTE%TYPE;
LV_COLOR     GE_CLIENTES.COD_COLOR%TYPE;
LV_SEGMENTO  GE_CLIENTES.COD_SEGMENTO%TYPE;

BEGIN

	SN_Cod_retorno 	:= 0;
	SV_Mens_retorno := NULL;
	SN_Num_evento 	:= 0;


	IF (EO_PLANES_ADIC.cod_servicio_base IS NULL ) THEN
		RAISE ERROR_PARAMETROS;
	END IF;

    IF (EN_COD_CLIENTE IS NULL ) THEN
		RAISE ERROR_PARAMETROS;
	END IF;


    SELECT COD_COLOR,COD_SEGMENTO
    INTO LV_COLOR,LV_SEGMENTO
    FROM GE_CLIENTES
	WHERE COD_CLIENTE= EN_COD_CLIENTE ;



	LV_SSQL := 'SELECT a.cod_limcons, b.ind_unidades, b.imp_limite, b.descripcion,';
	LV_SSQL := LV_SSQL || ' a.cod_plantarif, a.ind_default,a.MTO_CONS,a.MTO_MIN,a.MTO_MAX';
	LV_SSQL := LV_SSQL || ' FROM tol_limite_plan_td a, tol_limite_td b';
	LV_SSQL := LV_SSQL || ' WHERE a.cod_limcons = b.cod_limcons ';
	LV_SSQL := LV_SSQL || ' AND a.cod_plantarif = '||EO_PLANES_ADIC.COD_SERVICIO_BASE;

	OPEN SO_LIMITES FOR
	SELECT a.cod_limcons, b.ind_unidades, b.imp_limite, b.descripcion,
	a.cod_plantarif, a.ind_default,a.MTO_CONS,a.MTO_MIN,a.MTO_MAX
	FROM tol_limite_plan_td a, tol_limite_td b
	WHERE a.cod_limcons = b.cod_limcons
	AND a.cod_plantarif = EO_PLANES_ADIC.COD_SERVICIO_BASE
    AND a.ID_SUBSEGMENTO= LV_SEGMENTO
    AND a.IND_PRIORIDAD>= TO_NUMBER(LV_COLOR);


EXCEPTION
   WHEN ERROR_PARAMETROS THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
      LV_des_error   := 'SE_LC_PLAN_ADICIONAL_PG.SE_OBTIENE_LC_PR('||EO_PLANES_ADIC.COD_SERVICIO_BASE||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SE', SV_mens_retorno, CV_version, USER, 'SE_LC_PLAN_ADICIONAL_PG.SE_OBTIENE_LC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	WHEN OTHERS THEN
	      SN_Cod_retorno:=156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := cv_error_no_clasif;
	      END IF;

		  LV_des_error   := 'SE_LC_PLAN_ADICIONAL_PG.SE_OBTIENE_LC_PR('||EO_PLANES_ADIC.COD_SERVICIO_BASE||'); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SE', SV_mens_retorno, CV_version, USER, 'SE_LC_PLAN_ADICIONAL_PG.SE_OBTIENE_LC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END SE_OBTIENE_LC_PR;


PROCEDURE SE_INSERTA_LC_PR(
	EO_LIMITES         IN     SE_LC_LISTA_QT,
	SN_cod_retorno     OUT NOCOPY    ge_errores_pg.coderror,
	SV_mens_retorno    OUT NOCOPY    ge_errores_pg.msgerror,
	SN_num_evento      OUT NOCOPY ge_errores_pg.evento
) IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "SE_INSERTA_LC_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Informa limites de consumo de planes adicionales</Descripción>>
       <Parámetros>
          <Entrada>
				<param nom ="EO_LIMITES" tipo="OBJETO">Estructura con el código del plan adicional</param>

          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SV_mens_retorno" Tipo="NUMERICO">Numero de Evento</param>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error  ge_errores_pg.DesEvent;
LV_sSql       ge_errores_pg.vQuery;

ln_COD_CLIENTE    ga_limite_cliabo_to.cod_cliente%TYPE;
ln_NUM_ABONADO    ga_limite_cliabo_to.num_abonado%TYPE;
lv_COD_LIMCONS    ga_limite_cliabo_to.cod_limcons%TYPE;
ld_FEC_DESDE      ga_limite_cliabo_to.fec_desde%TYPE;
ld_FEC_HASTA      ga_limite_cliabo_to.fec_hasta%TYPE;
lv_NOM_USUARORA   ga_limite_cliabo_to.nom_usuarora%TYPE;
ld_FEC_ASIGNACION ga_limite_cliabo_to.fec_asignacion%TYPE;
lv_COD_PLANTARIF  ga_limite_cliabo_to.cod_plantarif%TYPE;
LN_MTO_LIMCONS    GA_LIMITE_CLIABO_TO.MTO_CONS%TYPE;

c_limites		  refCursor;

ld_FECDESDE_ANT	  ga_limite_cliabo_to.fec_desde%TYPE;
ld_FECHASTA_ANT   ga_limite_cliabo_to.fec_hasta%TYPE;

BEGIN

	SN_Cod_retorno 	:= 0;
	SV_Mens_retorno := NULL;
	SN_Num_evento 	:= 0;

	LV_SSQL := 'SELECT COD_CLIENTE,   NUM_ABONADO, COD_LIMCONS, FEC_DESDE, ';
	LV_SSQL := LV_SSQL || ' FEC_HASTA, NOM_USUARORA, FEC_ASIGNACION, COD_PLANTARIF,MTO_LIMCONSUMO ';
	LV_SSQL := LV_SSQL || ' FROM EO_LIMITES as SE_LC_LISTA_QT)';
	--se obtiene la estructura de entrada
	OPEN c_limites FOR
	SELECT cod_cliente, num_abonado, cod_limcons, fec_desde, fec_hasta, nom_usuarora, fec_asignacion, cod_plantarif,MTO_LIMCONSUMO
	FROM TABLE(CAST(EO_LIMITES as SE_LC_LISTA_QT)) c;
	--Se recorre la lista de limites de consumo de planes adicionales a contratar
	LOOP

		FETCH c_limites INTO    ln_COD_CLIENTE,
								ln_NUM_ABONADO,
								lv_COD_LIMCONS,
								ld_FEC_DESDE,
								ld_FEC_HASTA,
								lv_NOM_USUARORA,
								ld_FEC_ASIGNACION,
								lv_COD_PLANTARIF,
                                LN_MTO_LIMCONS;

		EXIT WHEN c_limites%NOTFOUND;

		LV_SSQL := ' SELECT NVL(FEC_HASTA,TO_DATE(''31-12-3000'',''DD-MM-YYYY'')) ';
		LV_SSQL := LV_SSQL || 'FROM   ga_limite_cliabo_to ';
		LV_SSQL := LV_SSQL || 'WHERE  cod_cliente = '||ln_COD_CLIENTE;
		LV_SSQL := LV_SSQL || 'AND    num_abonado = '||ln_NUM_ABONADO;
		LV_SSQL := LV_SSQL || 'AND    cod_limcons = '||lv_COD_LIMCONS;
		LV_SSQL := LV_SSQL || 'AND    cod_plantarif = '||lv_COD_PLANTARIF;
		--Se verifica la existencia de un limite de consumo activo similar
		BEGIN
			SELECT fec_Desde, NVL(FEC_HASTA,TO_DATE('31-12-3000','DD-MM-YYYY'))
			INTO   ld_FECDESDE_ANT, ld_FECHASTA_ANT
			FROM   ga_limite_cliabo_to
			WHERE  cod_cliente = ln_COD_CLIENTE
			AND    num_abonado = ln_NUM_ABONADO
			AND    cod_limcons = lv_COD_LIMCONS
			AND    cod_plantarif = lv_COD_PLANTARIF
			AND	   SYSDATE BETWEEN fec_desde and NVL(FEC_HASTA,TO_DATE('31-12-3000','DD-MM-YYYY'));
		EXCEPTION
		WHEN NO_DATA_FOUND THEN --Si no existe ningún limite de consumo similar, se inserta el registro
			LV_SSQL := ' INSERT INTO GA_LIMITE_CLIABO_TO ';
			LV_SSQL := LV_SSQL || ' (COD_CLIENTE, NUM_ABONADO, COD_LIMCONS, FEC_DESDE, ';
			LV_SSQL := LV_SSQL || ' FEC_HASTA, NOM_USUARORA, FEC_ASIGNACION, COD_PLANTARIF,MTO_CONS) ';
			LV_SSQL := LV_SSQL || ' VALUES ( ';
			LV_SSQL := LV_SSQL || ln_COD_CLIENTE    ||', ';
			LV_SSQL := LV_SSQL || ln_NUM_ABONADO    ||', ';
			LV_SSQL := LV_SSQL || lv_COD_LIMCONS    ||', ';
			LV_SSQL := LV_SSQL || ld_FEC_DESDE      ||', ';
			LV_SSQL := LV_SSQL || ld_FEC_HASTA      ||', ';
			LV_SSQL := LV_SSQL || lv_NOM_USUARORA   ||', ';
			LV_SSQL := LV_SSQL || ld_FEC_ASIGNACION ||', ';
			LV_SSQL := LV_SSQL || lv_COD_PLANTARIF ||', ';
            LV_SSQL := LV_SSQL || LN_MTO_LIMCONS  ||')';

			INSERT INTO ga_limite_cliabo_to
				(COD_CLIENTE,
				NUM_ABONADO,
				COD_LIMCONS,
				FEC_DESDE,
				FEC_HASTA,
				NOM_USUARORA,
				FEC_ASIGNACION,
				COD_PLANTARIF,
                MTO_CONS)
			VALUES
			    (ln_COD_CLIENTE,
				ln_NUM_ABONADO,
				lv_COD_LIMCONS,
				ld_FEC_DESDE,
				ld_FEC_HASTA,
				lv_NOM_USUARORA,
				ld_FEC_ASIGNACION,
				lv_COD_PLANTARIF,
                LN_MTO_LIMCONS);
		END;
		--Si ya existe registro, se verifica que la vigencia del nuevo registro sea mayor
		IF (ld_FECHASTA_ANT < ld_FEC_HASTA) THEN
		--Si la vigencia del nuevo registro es mayor, se actualiza la fecha hasta
			LV_SSQL := 'UPDATE ga_limite_cliabo_to ';
			LV_SSQL := LV_SSQL || 'SET FEC_HASTA = '||ld_FEC_HASTA||', ';
			LV_SSQL := LV_SSQL || ' NOM_USUARORA = '||lv_NOM_USUARORA||', ';
			LV_SSQL := LV_SSQL || ' FEC_ASIGNACION = '||ld_FEC_ASIGNACION;
			LV_SSQL := LV_SSQL || ' WHERE cod_cliente = '||ln_COD_CLIENTE;
			LV_SSQL := LV_SSQL || ' AND num_abonado = '||ln_NUM_ABONADO;
			LV_SSQL := LV_SSQL || ' AND cod_limcons = '||lv_COD_LIMCONS;
			LV_SSQL := LV_SSQL || ' AND cod_plantarif = '||lv_COD_PLANTARIF;
			LV_SSQL := LV_SSQL || ' AND fec_desde = '||ld_FECDESDE_ANT;

			UPDATE ga_limite_cliabo_to
			SET    FEC_HASTA = ld_FEC_HASTA,
				   NOM_USUARORA = lv_NOM_USUARORA,
				   FEC_ASIGNACION = ld_FEC_ASIGNACION
			WHERE  cod_cliente = ln_COD_CLIENTE
			AND    num_abonado = ln_NUM_ABONADO
			AND    cod_limcons = lv_COD_LIMCONS
			AND    cod_plantarif = lv_COD_PLANTARIF
			AND	   fec_desde = ld_FECDESDE_ANT;

		END IF;

	END LOOP;



EXCEPTION

	WHEN OTHERS THEN
	      SN_Cod_retorno:=920;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := cv_error_no_clasif;
	      END IF;
          LV_des_error   := 'SE_LC_PLAN_ADICIONAL_PG.SE_INSERTA_LC_PR('||'); - ' || SQLERRM;
		  LV_SSQL := LV_SSQL || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SE', SV_mens_retorno, CV_version, USER, 'SE_LC_PLAN_ADICIONAL_PG.SE_INSERTA_LC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END SE_INSERTA_LC_PR;

PROCEDURE SE_ACTUALIZA_LC_PR(
	EO_PRODUCTOS        IN         PR_PRODUCTO_DES_LST_QT,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
) IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "SE_ACTUALIZA_LC_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Da de baja los limites de consumo de los planes adicionales</Descripción>>
       <Parámetros>
          <Entrada>
				<param nom ="EO_LIMITES" tipo="OBJETO">Estructura con el código del plan adicional</param>

          </Entrada>
          <Salida>
              <param nom="SN_cod_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SV_mens_retorno" Tipo="NUMERICO">Numero de Evento</param>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error  ge_errores_pg.DesEvent;
LV_sSql       ge_errores_pg.vQuery;

LO_limites    refcursor;
LD_FECHA_HASTA ga_limite_cliabo_to.fec_hasta%TYPE;
LN_COD_CLIENTE ga_limite_cliabo_to.cod_cliente%TYPE;
LN_NUM_ABONADO ga_limite_cliabo_to.num_abonado%TYPE;
LV_COD_LIMCONS ga_limite_cliabo_to.cod_limcons%TYPE := NULL;
LV_COD_PLANTARIF ga_limite_cliabo_to.cod_plantarif%TYPE;

LN_COD_PROD_CONTRATADO pr_productos_contratados_to.cod_prod_contratado%TYPE;
LV_NOM_USUARIO 		   ga_limite_cliabo_to.nom_usuarora%TYPE;

BEGIN

    SN_Cod_retorno 	:= 0;
	SV_Mens_retorno := NULL;
	SN_Num_evento 	:= 0;


    OPEN LO_limites FOR
    SELECT FEC_DESCONTRATA, COD_PROD_CONTRATADO, NOM_USUARIO
    FROM   TABLE(CAST(EO_PRODUCTOS as PR_PRODUCTO_DES_LST_QT));

	LOOP

		FETCH   LO_limites INTO LD_FECHA_HASTA,LN_COD_PROD_CONTRATADO, LV_NOM_USUARIO;

		EXIT WHEN LO_limites%NOTFOUND;

		BEGIN
			LV_SSQL := 'SELECT prod.cod_cliente_contratante, ';
			LV_SSQL := LV_SSQL || ' prod.num_abonado_contratante, ';
			LV_SSQL := LV_SSQL || ' prod.cod_limcons, ';
			LV_SSQL := LV_SSQL || ' serv.cod_servicio_base ';
			LV_SSQL := LV_SSQL || ' FROM   pr_productos_contratados_th prod, ';
			LV_SSQL := LV_SSQL || ' pf_productos_ofertados_td ofer, ';
			LV_SSQL := LV_SSQL || ' se_detalles_especificacion_to serv ';
			LV_SSQL := LV_SSQL || ' WHERE  prod.cod_prod_ofertado = ofer.cod_prod_ofertado ';
			LV_SSQL := LV_SSQL || ' AND    ofer.cod_espec_prod = serv.cod_espec_prod ';
			LV_SSQL := LV_SSQL || ' AND	   prod.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;

			SELECT prod.cod_cliente_contratante,
				   prod.num_abonado_contratante,
				   prod.cod_limcons,
				   serv.cod_servicio_base
			INTO   LN_COD_CLIENTE,
				   LN_NUM_ABONADO,
				   LV_COD_LIMCONS,
				   LV_COD_PLANTARIF
			FROM   pr_productos_contratados_th prod,
				   pf_productos_ofertados_td ofer,
				   se_detalles_especificacion_to serv
			WHERE  prod.cod_prod_ofertado = ofer.cod_prod_ofertado
			AND    ofer.cod_espec_prod = serv.cod_espec_prod
			AND	   prod.cod_prod_contratado = LN_COD_PROD_CONTRATADO;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				LV_COD_LIMCONS := NULL;
		END;

		IF (LV_COD_LIMCONS IS NOT NULL) THEN
			LV_SSQL := 'UPDATE GA_LIMITE_CLIABO_TO';
			LV_SSQL := LV_SSQL || ' (SET FEC_HASTA = '||LD_FECHA_HASTA||',';
			LV_SSQL := LV_SSQL || ' (NOM_USUARORA = '||LV_NOM_USUARIO;
			LV_SSQL := LV_SSQL || ' WHERE COD_CLIENTE = '||LN_COD_CLIENTE||' AND) ';
			LV_SSQL := LV_SSQL || ' NUM_ABONADO = '||LN_NUM_ABONADO||' AND) ';
			LV_SSQL := LV_SSQL || ' COD_LIMCONS = '||LV_COD_LIMCONS||' AND) ';
			LV_SSQL := LV_SSQL || ' COD_PLANTARIF = '||LV_COD_PLANTARIF||' AND) ';
			LV_SSQL := LV_SSQL || ' SYSDATE BETWEEN fec_desde AND fec_hasta';

			UPDATE ga_limite_cliabo_to
			SET    fec_hasta = LD_FECHA_HASTA,
				   nom_usuarora = LV_NOM_USUARIO
			WHERE  cod_cliente = LN_COD_CLIENTE
			AND    num_abonado = LN_NUM_ABONADO
			AND	   cod_limcons = LV_COD_LIMCONS
			AND	   cod_plantarif = LV_COD_PLANTARIF
			AND    SYSDATE BETWEEN fec_desde AND nvl(fec_hasta,sysdate);
		END IF;

	END LOOP;


   EXCEPTION

	WHEN OTHERS THEN
	      SN_Cod_retorno:=925;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := cv_error_no_clasif;
	      END IF;
          LV_des_error   := 'SE_LC_PLAN_ADICIONAL_PG.SE_ACTUALIZA_LC_PR('||'); - ' || SQLERRM;
		  LV_SSQL := LV_SSQL || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SE', SV_mens_retorno, CV_version, USER, 'SE_LC_PLAN_ADICIONAL_PG.SE_ACTUALIZA_LC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END SE_ACTUALIZA_LC_PR;

PROCEDURE SE_CAMBIO_LC_PR(
	EO_PRODUCTOS        IN         PR_PRODUCTO_DES_LST_QT,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
) IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "SE_CAMBIO_LC_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Cambia el limite de Consumo para un plan adicional/Descripción>>
       <Parámetros>
          <Entrada>
				<param nom ="EO_LIMITES" tipo="OBJETO">Estructura con el código del plan adicional</param>

          </Entrada>
          <Salida>
              <param nom="SN_cod_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SV_mens_retorno" Tipo="NUMERICO">Numero de Evento</param>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error  ge_errores_pg.DesEvent;
LV_sSql       ge_errores_pg.vQuery;

LO_limites    refcursor;
LD_FECHA_HASTA ga_limite_cliabo_to.fec_hasta%TYPE;
LN_COD_CLIENTE ga_limite_cliabo_to.cod_cliente%TYPE;
LN_NUM_ABONADO ga_limite_cliabo_to.num_abonado%TYPE;
LV_COD_LIMCONS ga_limite_cliabo_to.cod_limcons%TYPE := NULL;
LV_COD_PLANTARIF ga_limite_cliabo_to.cod_plantarif%TYPE;

LN_COD_PROD_CONTRATADO pr_productos_contratados_to.cod_prod_contratado%TYPE;
LV_NOM_USUARIO 		   ga_limite_cliabo_to.nom_usuarora%TYPE;
LV_COD_LIMCONS_NUE 	   ga_limite_cliabo_to.cod_limcons%TYPE := NULL;
LD_FECHA_DESDE 		   ga_limite_cliabo_to.fec_desde%TYPE;
LV_MTO_LIMCONS         pr_productos_contratados_to.MTO_LIMCONS%TYPE;
LV_MTO_LIMCONS_NUE     pr_productos_contratados_to.MTO_LIMCONS%TYPE;

BEGIN

    SN_Cod_retorno 	:= 0;
	SV_Mens_retorno := NULL;
	SN_Num_evento 	:= 0;


    OPEN LO_limites FOR
    SELECT FEC_DESCONTRATA, COD_PROD_CONTRATADO, NOM_USUARIO, COD_LIMCONS, (FEC_DESCONTRATA + (1/(24*60*60))),MTO_LIMCONS
    FROM   TABLE(CAST(EO_PRODUCTOS as PR_PRODUCTO_DES_LST_QT));

	LOOP

		FETCH   LO_limites INTO LD_FECHA_HASTA,LN_COD_PROD_CONTRATADO, LV_NOM_USUARIO, LV_COD_LIMCONS_NUE, LD_FECHA_DESDE,LV_MTO_LIMCONS_NUE;

		EXIT WHEN LO_limites%NOTFOUND;

		BEGIN
			LV_SSQL := 'SELECT prod.cod_cliente_contratante, ';
			LV_SSQL := LV_SSQL || ' prod.num_abonado_contratante, ';
			LV_SSQL := LV_SSQL || ' prod.cod_limcons, ';
			LV_SSQL := LV_SSQL || ' serv.cod_servicio_base ';
			LV_SSQL := LV_SSQL || ' FROM   pr_productos_contratados_to prod, ';
			LV_SSQL := LV_SSQL || ' pf_productos_ofertados_td ofer, ';
			LV_SSQL := LV_SSQL || ' se_detalles_especificacion_to serv ';
			LV_SSQL := LV_SSQL || ' WHERE  prod.cod_prod_ofertado = ofer.cod_prod_ofertado ';
			LV_SSQL := LV_SSQL || ' AND    ofer.cod_espec_prod = serv.cod_espec_prod ';
			LV_SSQL := LV_SSQL || ' AND	   prod.cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
			--Se buscan los datos del limite de consumo
			SELECT prod.cod_cliente_contratante,
				   prod.num_abonado_contratante,
				   prod.cod_limcons,
				   serv.cod_servicio_base,
                   prod.MTO_LIMCONS
			INTO   LN_COD_CLIENTE,
				   LN_NUM_ABONADO,
				   LV_COD_LIMCONS,
				   LV_COD_PLANTARIF,
                   LV_MTO_LIMCONS
			FROM   pr_productos_contratados_to prod,
				   pf_productos_ofertados_td ofer,
				   se_detalles_especificacion_to serv
			WHERE  prod.cod_prod_ofertado = ofer.cod_prod_ofertado
			AND    ofer.cod_espec_prod = serv.cod_espec_prod
			AND	   prod.cod_prod_contratado = LN_COD_PROD_CONTRATADO;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				LV_COD_LIMCONS := NULL;
		END;

		IF (LV_COD_LIMCONS IS NOT NULL) THEN
			LV_SSQL := 'UPDATE GA_LIMITE_CLIABO_TO';
			LV_SSQL := LV_SSQL || ' (SET FEC_HASTA = '||LD_FECHA_HASTA||',';
			LV_SSQL := LV_SSQL || ' (NOM_USUARORA = '||LV_NOM_USUARIO;
			LV_SSQL := LV_SSQL || ' WHERE COD_CLIENTE = '||LN_COD_CLIENTE||' AND) ';
			LV_SSQL := LV_SSQL || ' NUM_ABONADO = '||LN_NUM_ABONADO||' AND) ';
			LV_SSQL := LV_SSQL || ' COD_LIMCONS = '||LV_COD_LIMCONS||' AND) ';
			LV_SSQL := LV_SSQL || ' COD_PLANTARIF = '||LV_COD_PLANTARIF||' AND) ';
			LV_SSQL := LV_SSQL || ' MTO_CONS = '||LV_MTO_LIMCONS ||' AND) ';
            LV_SSQL := LV_SSQL || ' SYSDATE BETWEEN fec_desde AND fec_hasta';
			--Se da de baja el limite de consumo anterior
			UPDATE ga_limite_cliabo_to
			SET    fec_hasta =     LD_FECHA_HASTA,
				   nom_usuarora =  LV_NOM_USUARIO
			WHERE  cod_cliente =   LN_COD_CLIENTE
			AND    num_abonado =   LN_NUM_ABONADO
			AND	   cod_limcons =   LV_COD_LIMCONS
			AND	   cod_plantarif = LV_COD_PLANTARIF
			AND    MTO_CONS      = LV_MTO_LIMCONS
            AND    SYSDATE BETWEEN fec_desde AND fec_hasta;
		END IF;
		LV_SSQL := 'UPDATE pr_productos_contratados_to';
		LV_SSQL := LV_SSQL || ' SET	   cod_limcons = '||LV_COD_LIMCONS_NUE
		|| ', MTO_LIMCONS= ' || LV_MTO_LIMCONS_NUE;
        LV_SSQL := LV_SSQL || ' WHERE  cod_prod_contratado = '||LN_COD_PROD_CONTRATADO;
		--Se actualiza el limite de consumo en la tabla de productos contratados
		UPDATE pr_productos_contratados_to
		SET	   cod_limcons = LV_COD_LIMCONS_NUE,
        MTO_LIMCONS=LV_MTO_LIMCONS_NUE
		WHERE  cod_prod_contratado = LN_COD_PROD_CONTRATADO;

		LV_SSQL := 'INSERT INTO ga_limite_cliabo_to (COD_CLIENTE, NUM_ABONADO, COD_LIMCONS, FEC_DESDE,';
		LV_SSQL := LV_SSQL || ' FEC_HASTA, NOM_USUARORA, FEC_ASIGNACION, COD_PLANTARIF,MTO_CONS)';
		LV_SSQL := LV_SSQL || ' VALUES ('||LN_COD_CLIENTE||', '||LN_NUM_ABONADO||', '||LV_COD_LIMCONS_NUE||', '||LD_FECHA_DESDE;
		LV_SSQL := LV_SSQL || ' .'||LD_FECHA_HASTA||', '||LV_NOM_USUARIO||', '||SYSDATE||', '|| LV_COD_PLANTARIF ||', ' || LV_MTO_LIMCONS_NUE || ')';
		--Se inserta el nuevo limite de consumo
		INSERT INTO ga_limite_cliabo_to
			(COD_CLIENTE,
			NUM_ABONADO,
			COD_LIMCONS,
			FEC_DESDE,
			FEC_HASTA,
			NOM_USUARORA,
			FEC_ASIGNACION,
			COD_PLANTARIF,
            MTO_CONS)
		VALUES
			(LN_COD_CLIENTE,
			LN_NUM_ABONADO,
			LV_COD_LIMCONS_NUE,
			LD_FECHA_DESDE,
			LD_FECHA_HASTA,
			LV_NOM_USUARIO,
			SYSDATE,
			LV_COD_PLANTARIF,
            LV_MTO_LIMCONS_NUE);

	END LOOP;

   EXCEPTION

	WHEN OTHERS THEN
	      SN_Cod_retorno:=925;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := cv_error_no_clasif;
	      END IF;
          LV_des_error   := 'SE_LC_PLAN_ADICIONAL_PG.SE_CAMBIO_LC_PR('||'); - ' || SQLERRM;
		  LV_SSQL := LV_SSQL || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SE', SV_mens_retorno, CV_version, USER, 'SE_LC_PLAN_ADICIONAL_PG.SE_CAMBIO_LC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END SE_CAMBIO_LC_PR;

   PROCEDURE SE_CONSULTA_ABONO_PR(
	EN_COD_CLIENTE       IN ga_abocel.cod_cliente%TYPE,
	EN_NUM_ABONADO     	 IN ga_abocel.num_abonado%TYPE,
	SO_LIMITES			OUT NOCOPY	refcursor,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
    )    IS

 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "SE_CONSULTA_ABONO_PR"
           Lenguaje="PL/SQL"
       Fecha="20-11-2008"
       Versión="La del package"
       Diseñador="Andrés Osorio"
       Programador="Andrés Osorio"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción>Obtiene los posibles limites de consumo para un plan adicional</Descripción>>
       <Parámetros>
          <Entrada>
				<param nom ="EO_PLANES_ADIC" tipo="OBJETO">Estructura con el código del plan adicional</param>

          </Entrada>
          <Salida>
             <param nom="SO_LIMITES" Tipo="CURSOR">Cursor con los límites de consumo del plan adicional</param>
             <param nom="SN_cod_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
             <param nom="SV_mens_retorno" Tipo="NUMERICO">Numero de Evento</param>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
*/
LV_des_error  ge_errores_pg.DesEvent;
LV_sSql       ge_errores_pg.vQuery;
ERROR_PARAMETROS EXCEPTION;
paso NUMBER;
BEGIN

	SN_Cod_retorno 	:= 0;
	SV_Mens_retorno := NULL;
	SN_Num_evento 	:= 0;

	LV_sSql := ' SELECT c.cod_servicio_base, d.cod_prod_contratado, e.id_prod_ofertado,';
	LV_sSql := LV_sSql || ' e.des_prod_ofertado, a.cod_limcons, b.descripcion, b.imp_limite,';
	LV_sSql := LV_sSql || ' TOL_ABONO_LIMITE_PG.TOL_MONTO_MAX_LC_FN('||EN_COD_CLIENTE||', '||EN_NUM_ABONADO||', c.cod_servicio_base, a.cod_limcons) as maximo';
	LV_sSql := LV_sSql || ' ,d.tipo_comportamiento,d.MTO_LIMCONS';
	LV_sSql := LV_sSql || ' FROM tol_limite_plan_td a, tol_limite_td b, se_detalles_especificacion_to c,';
	LV_sSql := LV_sSql || ' pr_productos_contratados_to d, pf_productos_ofertados_td e';
	LV_sSql := LV_sSql || ' WHERE  a.cod_limcons = b.cod_limcons';
	LV_sSql := LV_sSql || ' AND  a.cod_plantarif = c.cod_servicio_base';
	LV_sSql := LV_sSql || ' AND  a.cod_limcons = d.cod_limcons';
	LV_sSql := LV_sSql || ' AND  d.cod_prod_ofertado = e.cod_prod_ofertado';
	LV_sSql := LV_sSql || ' AND c.cod_espec_prod = e.cod_espec_prod';
	LV_sSql := LV_sSql || ' AND d.cod_cliente_contratante = '||EN_COD_CLIENTE;
	LV_sSql := LV_sSql || ' AND d.num_abonado_contratante = '||EN_NUM_ABONADO;
	LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN d.fec_inicio_vigencia AND d.fec_termino_vigencia';
	LV_sSql := LV_sSql || ' ORDER BY c.cod_servicio_base, d.cod_prod_contratado';

	OPEN SO_LIMITES FOR
	SELECT c.cod_servicio_base, d.cod_prod_contratado, e.id_prod_ofertado,
		   e.des_prod_ofertado, a.cod_limcons, b.descripcion, b.imp_limite,
		   TOL_ABONO_LIMITE_PG.TOL_MONTO_MAX_LC_FN(EN_COD_CLIENTE, EN_NUM_ABONADO, c.cod_servicio_base, a.cod_limcons) as maximo,
		   d.tipo_comportamiento,d.MTO_LIMCONS
	FROM   tol_limite_plan_td a, tol_limite_td b, se_detalles_especificacion_to c,
		   pr_productos_contratados_to d, pf_productos_ofertados_td e
	WHERE  a.cod_limcons = b.cod_limcons
	AND    a.cod_plantarif = c.cod_servicio_base
	AND    a.cod_limcons = d.cod_limcons
	AND    d.cod_prod_ofertado = e.cod_prod_ofertado
	AND	   c.cod_espec_prod = e.cod_espec_prod
	AND	   d.cod_cliente_contratante = EN_COD_CLIENTE
	AND	   d.num_abonado_contratante = EN_NUM_ABONADO
	AND	   SYSDATE BETWEEN d.fec_inicio_vigencia AND d.fec_termino_vigencia
	ORDER BY c.cod_servicio_base, d.cod_prod_contratado;

	paso := SQLCODE;


EXCEPTION
	WHEN OTHERS THEN
		CASE SQLCODE
			WHEN -20001 THEN SN_Cod_retorno:=215;
			WHEN -20002 THEN SN_Cod_retorno:=215;
			WHEN -20003 THEN SN_Cod_retorno:=254;
			WHEN -20004 THEN SN_Cod_retorno:=289;
			WHEN -20005 THEN SN_Cod_retorno:=1306;
			WHEN -20006 THEN SN_Cod_retorno:=1;
			WHEN -20007 THEN SN_Cod_retorno:=1;
			ELSE SN_Cod_retorno:=156;
		END CASE;

	IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_Cod_retorno,SV_mens_retorno) THEN
		SV_mens_retorno := cv_error_no_clasif;
	END IF;

	LV_des_error   := 'SE_LC_PLAN_ADICIONAL_PG.SE_CONSULTA_ABONO_PR('||EN_COD_CLIENTE||','||EN_NUM_ABONADO||'); - ' || SQLERRM;
	SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'SE', SV_mens_retorno, CV_version, USER, 'SE_LC_PLAN_ADICIONAL_PG.SE_CONSULTA_ABONO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END SE_CONSULTA_ABONO_PR;

END SE_LC_PLAN_ADICIONAL_PG;
/
