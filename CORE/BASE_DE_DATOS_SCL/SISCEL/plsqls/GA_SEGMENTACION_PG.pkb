CREATE OR REPLACE PACKAGE BODY Ga_Segmentacion_Pg

AS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_cliente_fn (
         EN_cod_cliente    IN         GE_CLIENTES.cod_cliente%TYPE,
         EV_comportamiento IN         VARCHAR2 DEFAULT 'NO',
         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_CLIENTE_FN"
      Lenguaje="PL/SQL"
      Fecha="26-08-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
     <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida la existencia de un cliente.Ejecuta validaciones adicionales dependiendo del parámetro EV_comportamiento</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"     Tipo="NUMERICO">Codigo de Cliente</param>
            <param nom="EV_comportamiento"  Tipo="CARACTER">Comportamiento de la función</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   CN_tipo_abonado	   CONSTANT NUMBER(1):=3;
   error_cliente       EXCEPTION;
   error_parametro     EXCEPTION;
   error_ejecucion     EXCEPTION;
   error_sin_abonados  EXCEPTION;
   LN_cantidad		   NUMBER;
   LV_val_param		   GED_PARAMETROS.val_parametro%TYPE;
   N_cant_reg          NUMBER;
   sSql                ge_errores_pg.vQuery;
   LV_des_error         ge_errores_pg.DesEvent;

BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= NULL;
	LN_cantidad:=0;
	LV_val_param:=0;

	IF EN_cod_cliente IS NULL THEN
	   RAISE error_parametro;
	END IF;

    sSql := 'SELECT COUNT(1) INTO N_cant_reg FROM ge_clientes WHERE cod_cliente = ' || EN_cod_cliente;
    SELECT COUNT(1) INTO N_cant_reg
      FROM GE_CLIENTES clientes
     WHERE clientes.cod_cliente = EN_cod_cliente;

	IF N_cant_reg = 0 THEN
	    RAISE error_cliente;
	END IF;

	--Esto se ejecuta dependiendo de lo que significa "cliente válido"...
	IF EV_comportamiento <> 'NO' THEN
	   --Obtener parámetro (ged_parametros) para determinar si se ejecuta o no validación...NUM_ABONADOS_CLIENTE=SI...
	   sSql:='ga_recupera_parametros_fn('||CV_nom_param_valida||','||CV_cod_modulo||','||CN_cod_producto||',SI)';
	   IF NOT ga_recupera_parametros_fn(CV_nom_param_valida,CV_cod_modulo,CN_cod_producto,'SI', LV_val_param,SN_cod_retorno,SV_mens_retorno, SN_num_evento) THEN
    	  RAISE error_ejecucion;
	   END IF;
	   IF LV_val_param = CV_ejecute_validacion THEN
          sSql:='GA_CANTIDAD_ABONADOS_PR('||EN_cod_cliente||','||CN_tipo_abonado||')';
    	  GA_CANTIDAD_ABONADOS_PR(EN_cod_cliente,CN_tipo_abonado,LN_cantidad,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    	  IF SN_cod_retorno <> 0 THEN
    	 	 RAISE error_ejecucion;
    	  END IF;
    	  IF LN_cantidad = 0 THEN
    	     RAISE error_sin_abonados;
    	  END IF;
	   END IF;
    END IF;

    RETURN TRUE;

EXCEPTION
   WHEN error_parametro THEN
      SN_cod_retorno := 98;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_cliente_fn('|| EN_cod_cliente||','||EV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_cliente_fn', sSql, SQLCODE, LV_des_error );
      RETURN FALSE;
   WHEN error_cliente THEN
      SN_cod_retorno := 225;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_cliente_fn('|| EN_cod_cliente||','||EV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_cliente_fn', sSql, SQLCODE, LV_des_error );
      RETURN FALSE;
   WHEN error_ejecucion THEN
      LV_des_error := 'ga_valida_cliente_fn('|| EN_cod_cliente||','||EV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_cliente_fn', sSql, SQLCODE, LV_des_error );
      RETURN FALSE;
   WHEN error_sin_abonados THEN
      SN_cod_retorno := 478;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_cliente_fn('|| EN_cod_cliente||','||EV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_cliente_fn', sSql, SQLCODE, LV_des_error );
      RETURN FALSE;
   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_cliente_fn('|| EN_cod_cliente||','||EV_comportamiento||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SN_cod_retorno||' -- '||SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_cliente_fn', sSql, SQLCODE, LV_des_error );
      RETURN FALSE;
END ga_valida_cliente_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_codigos_fn(
         EV_cod_modulo    IN         GED_CODIGOS.cod_modulo%TYPE,
         EV_nom_tabla     IN         GED_CODIGOS.nom_tabla%TYPE,
         EV_nom_columna   IN         GED_CODIGOS.nom_columna%TYPE,
         EV_cod_valor     IN         GED_CODIGOS.cod_valor%TYPE,
         SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
         SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ga_valida_codigos_fn""
      Lenguaje="PL/SQL"
      Fecha="06-09-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Validar datos en ged_codigos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_modulo" Tipo="CARACTER">Codigo del modulo</param>
            <param nom="EV_nom_tabla" Tipo="CARACTER">Nombre de la tabla</param>
            <param nom="EV_nom_columna" Tipo="CARACTER">Nombre de la columna</param>
            <param nom="EV_cod_valor" Tipo="CARACTER">Valor de la columna</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   LV_sql              ge_errores_pg.vQuery;
   LV_des_error        ge_errores_pg.DesEvent;
   LV_cod_valor		   GED_CODIGOS.cod_valor%TYPE;
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;
		LV_cod_valor:=NULL;
    	LV_sql:=' SELECT g.cod_valor INTO LV_cod_valor'||
    	        '   FROM ged_codigos g '||
    	        '  WHERE g.cod_modulo='||EV_cod_modulo||
    	        '    AND g.nom_tabla='||EV_nom_tabla||
	            '    AND g.nom_columna='||EV_nom_columna||
				'    AND g.cod_valor='||EV_cod_valor;

    	SELECT g.cod_valor INTO LV_cod_valor
    	FROM   GED_CODIGOS g
    	WHERE  g.cod_modulo=EV_cod_modulo
    	  AND  g.nom_tabla=EV_nom_tabla
	      AND  g.nom_columna=EV_nom_columna
		  AND  g.cod_valor=EV_cod_valor;
    	RETURN TRUE ;

EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error:='ga_valida_codigos_fn('||EV_cod_modulo||','||EV_nom_tabla||','||EV_nom_columna||','||EV_cod_valor||') -' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER,'ga_valida_codigos_fn', LV_sql, SQLCODE, LV_des_error );
      RETURN FALSE;
END ga_valida_codigos_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_cantidad_abonados_pr(
        EN_cod_cliente    IN         GE_CLIENTES.cod_cliente%TYPE,
        EN_tipo_abonado   IN         NUMBER,
        SN_cantidad       OUT NOCOPY NUMBER,
        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento>
      Nombre = "ga_cantidad_abonados_PR"
      Lenguaje="PL/SQL"
      Fecha="07-09-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Obtiene la cantidad de abonados asociados a un cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"  Tipo="NUMERICO">Codigo de Cliente</param>
            <param nom="EN_tipo_abonado" Tipo="NUMERICO">Indica que tipo de abonado a consultar.1=Postpago, 2=Amistar, 3=Ambos</param>
         </Entrada>
         <Salida>
            <param nom="SN_cantidad  " Tipo="NUMERICO">Total de abonados asociados </param>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   LV_sql              ge_errores_pg.vQuery;
   LV_des_error        ge_errores_pg.DesEvent;
   LN_abo_post		   NUMBER;
   LN_abo_pre		   NUMBER;
BEGIN
   SN_cod_retorno:=0;
   SN_num_evento:=0;
   SV_mens_retorno:=NULL;
   SN_cantidad:=0;
   LN_abo_post:=0;
   LN_abo_pre:=0;

   --Contar abonados postpago. Debe ejecutarse si la consulta incluye ambos tipos...
   IF EN_tipo_abonado = 1 OR EN_tipo_abonado = 3 THEN
      LV_sql:=' SELECT COUNT(1) INTO LN_abo_post '||
              ' FROM GA_ABOCEL postpago '||
              ' WHERE postpago.cod_cliente='||EN_cod_cliente;

      SELECT COUNT(1) INTO LN_abo_post
        FROM GA_ABOCEL postpago
       WHERE postpago.cod_cliente=EN_cod_cliente;

   END IF;

   --Contar abonados prepago. Debe ejecutarse si la consulta incluye ambos tipos...
   IF EN_tipo_abonado = 2 OR EN_tipo_abonado = 3 THEN
      LV_sql:=' SELECT COUNT(1) INTO LN_abo_pre '||
              ' FROM GA_ABOAMIST prepago '||
              ' WHERE prepago.cod_cliente='||EN_cod_cliente;

      SELECT COUNT(1) INTO LN_abo_pre
        FROM GA_ABOAMIST prepago
       WHERE prepago.cod_cliente=EN_cod_cliente;

   END IF;

   LV_sql:=' CASE EN_tipo_abonado = '||EN_tipo_abonado;
   CASE EN_tipo_abonado
     WHEN 1 THEN
     	   LV_sql:='SN_cantidad:=LN_abo_post; LN_abo_post='||LN_abo_post;
          SN_cantidad:=LN_abo_post;
     WHEN 2 THEN
      	   LV_sql:='SN_cantidad:=LN_abo_pre; LN_abo_pre='||LN_abo_pre;
     	   SN_cantidad:=LN_abo_pre;
     WHEN 3 THEN
      	   LV_sql:='SN_cantidad:=LN_abo_post + LN_abo_pre; LN_abo_post='||LN_abo_post||',LN_abo_pre='||LN_abo_pre;
     	   SN_cantidad:=LN_abo_post + LN_abo_pre;
   END CASE;

EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error:='ga_cantidad_abonados_pr('||EN_cod_cliente||','||EN_tipo_abonado||',) -' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER,'ga_cantidad_abonados_pr', LV_sql, SQLCODE, LV_des_error );
END ga_cantidad_abonados_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_valor_cliente_fn (
   EN_num_abonado   IN         GA_ABOCEL.NUM_ABONADO%TYPE,
--   SV_val_cliente   OUT NOCOPY GE_VALORES_CLI.des_valor%TYPE, --34157, 14-09-2006 EFR/post-venta
   SV_val_cliente   OUT NOCOPY ga_valor_cli.cod_valor%TYPE, --34157, 14-09-2006 EFR/post-venta
   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_VALOR_CLIENTE_FN"
      Fecha modificacion=" "
      Fecha creacion="26-12-2004"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador=" "
      Ambiente Desarrollo="DEIMOS_TMC">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recupera el valor de un cliente</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="SN_num_abonado" Tipo="NUMERICO">Numero de Abonado</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_cliente"       Tipo="CARACTER">Valor del Cliente</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   LV_des_error  ge_errores_pg.DesEvent;
   LV_sSql       ge_errores_pg.vQuery;
BEGIN
   SN_cod_retorno := 0;
   SV_mens_retorno:= '';
   SN_num_evento  := 0;

--   LV_sSql := 'SELECT des_valor AS des_valorcli INTO SV_val_cliente'; --34157, 14-09-2006 EFR/post-venta
   LV_sSql := 'SELECT valcli.cod_valor AS des_valorcli INTO SV_val_cliente'; --34157, 14-09-2006 EFR/post-venta
   LV_sSql := LV_sSql || ' FROM ga_valor_cli valcli, ge_valores_cli valor, ga_abocel abo';
   LV_sSql := LV_sSql || ' WHERE valcli.cod_cliente= abo.cod_cliente';
   LV_sSql := LV_sSql || ' AND valor.cod_valor = valcli.cod_valor';
   LV_sSql := LV_sSql || ' AND abo.num_abonado = ' ||EN_num_abonado;
   LV_sSql := LV_sSql || ' UNION';
--   LV_sSql := LV_sSql || ' SELECT des_valor AS des_valorcli'; --34157, 14-09-2006 EFR/post-venta
   LV_sSql := LV_sSql || ' SELECT valcli.cod_valor AS des_valorcli'; --34157, 14-09-2006 EFR/post-venta
   LV_sSql := LV_sSql || ' FROM ga_valor_cli valcli, ge_valores_cli valor, ga_aboamist abo';
   LV_sSql := LV_sSql || ' WHERE valcli.cod_cliente= abo.cod_cliente';
   LV_sSql := LV_sSql || ' AND valor.cod_valor = valcli.cod_valor';
   LV_sSql := LV_sSql || ' AND abo.num_abonado = ' ||EN_num_abonado;


--   SELECT TRIM(valor.des_valor) AS des_valorcli INTO SV_val_cliente --34157, 14-09-2006 EFR/post-venta
   SELECT valcli.cod_valor AS des_valorcli INTO SV_val_cliente --34157, 14-09-2006 EFR/post-venta
     FROM GA_VALOR_CLI valcli,
          GE_VALORES_CLI valor,
          GA_ABOCEL abo
    WHERE valcli.cod_cliente = abo.cod_cliente
      AND valor.cod_valor = valcli.cod_valor
      AND abo.NUM_ABONADO = EN_num_abonado
    UNION
--   SELECT TRIM(valor.des_valor) AS des_valorcli --34157, 14-09-2006 EFR/post-venta
   SELECT valcli.cod_valor AS des_valorcli --34157, 14-09-2006 EFR/post-venta
     FROM GA_VALOR_CLI valcli,
          GE_VALORES_CLI valor,
          GA_ABOAMIST abo
    WHERE valcli.cod_cliente = abo.cod_cliente
      AND valor.cod_valor = valcli.cod_valor
      AND abo.NUM_ABONADO = EN_num_abonado;

      RETURN TRUE;

   EXCEPTION

      WHEN NO_DATA_FOUND THEN
         SV_val_cliente := '';
         RETURN TRUE;

      WHEN OTHERS THEN
         SN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
         END IF;
         LV_des_error := 'ga_recupera_valorcliente_fn('||EN_num_abonado||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_recupera_valorcliente_fn', LV_sSql, SN_cod_retorno, LV_des_error );
         RETURN FALSE;

END ga_recupera_valor_cliente_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_parametros_FN (
   EV_nom_parametro  IN         GED_PARAMETROS.nom_parametro%TYPE,
   EV_cod_modulo     IN         GED_PARAMETROS.cod_modulo%TYPE,
   EN_cod_producto   IN         GED_PARAMETROS.cod_producto%TYPE,
   EV_comportamiento IN         VARCHAR2,
   SV_val_parametro  OUT NOCOPY GED_PARAMETROS.val_parametro%TYPE,
   SN_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_PARAMETROS_FN"
      Versión="1.0"
      Diseñador="Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recuperar parametros de sistema</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre del Parametro</param>
            <param nom="EV_cod_modulo"    Tipo="CARACTER">Codigo de Modulo</param>
            <param nom="EN_cod_producto"  Tipo="NUMERICO">Codigo de Producto</param>
            <param nom="EV_comportamiento"  Tipo="CARACTER">Comportamiento de la función</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
			<param nom="SN_cod_retorno"   Tipo="NUMERICO">Código de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   LV_des_error  ge_errores_pg.DesEvent;
   LV_sSql       ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno := 0;
   SN_num_evento  := 0;
   SV_mens_retorno:= '';

   LV_sSql := 'SELECT param.val_parametro';
   LV_sSql := LV_sSql || ' INTO EV_val_parametro';
   LV_sSql := LV_sSql || ' FROM ged_parametros param';
   LV_sSql := LV_sSql || ' WHERE nom_parametro    = '|| EV_nom_parametro;
   LV_sSql := LV_sSql || '       AND cod_modulo   = '|| EV_cod_modulo;
   LV_sSql := LV_sSql || '       AND cod_producto = '|| EN_cod_producto;

   SELECT param.val_parametro
   INTO SV_val_parametro
   FROM GED_PARAMETROS param
   WHERE nom_parametro    = EV_nom_parametro
         AND cod_modulo   = EV_cod_modulo
   		 AND cod_producto = EN_cod_producto;

   RETURN TRUE;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
   		IF EV_comportamiento <> 'NO' THEN
           SN_cod_retorno := 156;
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;
           LV_des_error := 'ga_recupera_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_recupera_parametros_fn', LV_sSql, SN_cod_retorno, LV_des_error );
		END IF;
        RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_recupera_parametros_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_recupera_parametros_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_recupera_parametros_FN (
   EV_nom_parametro IN         GED_PARAMETROS.nom_parametro%TYPE,
   EV_cod_modulo    IN         GED_PARAMETROS.cod_modulo%TYPE,
   EN_cod_producto  IN         GED_PARAMETROS.cod_producto%TYPE,
   SV_val_parametro OUT NOCOPY GED_PARAMETROS.val_parametro%TYPE,
   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_RECUPERA_PARAMETROS_FN"
      Fecha modificacion=" "
      Fecha creacion="26-12-2004"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador=" "
      Ambiente Desarrollo="DEIMOS_TMC">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Recuperar parametros de sistema</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre del Parametro</param>
            <param nom="EV_cod_modulo"    Tipo="CARACTER">Codigo de Modulo</param>
            <param nom="EN_cod_producto"  Tipo="NUMERICO">Codigo de Producto</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro" Tipo="CARACTER">Codigo de Retorno</param>
			<param nom="SN_cod_retorno"   Tipo="NUMERICO">Código de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   LV_des_error  ge_errores_pg.DesEvent;
   LV_sSql       ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno := 0;
   SN_num_evento  := 0;
   SV_mens_retorno:= '';

   LV_sSql := 'ga_recupera_parametros_fn ('||EV_nom_parametro||','||EV_cod_modulo||','||EN_cod_producto||',NO)';

   IF NOT ga_recupera_parametros_fn (EV_nom_parametro, EV_cod_modulo, EN_cod_producto, 'NO', SV_val_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      IF SN_cod_retorno=0 THEN
         RETURN FALSE;
      END IF;
   END IF;

   RETURN TRUE;

EXCEPTION

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_recupera_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_recupera_parametros_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_recupera_parametros_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_num_celular_fn (
   EN_num_celular   IN         GA_ABOCEL.num_celular%TYPE,
   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_NUM_CELULAR_FN"
      Fecha modificacion=" "
      Fecha creacion="26-12-2004"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador=" "
      Ambiente Desarrollo="DEIMOS_TMC">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Valida Largo Numero Celular</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
RETURN BOOLEAN
AS
   error_largo             EXCEPTION;
   error_parametro_celular EXCEPTION;
   error_paramet           EXCEPTION;
   LV_des_error            ge_errores_pg.DesEvent;
   LV_sSql                 ge_errores_pg.vQuery;
   V_val_parametro         GED_PARAMETROS.val_parametro%TYPE;

BEGIN

   IF EN_num_celular IS NULL THEN
         RAISE error_parametro_celular;
   END IF;

   SN_cod_retorno := 0;
   SN_num_evento  := 0;
   SV_mens_retorno:= '';

   IF ga_recupera_parametros_fn ('LARGO_N_CELULAR', 'GE', 1, V_val_parametro, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      IF TO_NUMBER(V_val_parametro) = LENGTH(EN_num_celular) THEN
         RETURN TRUE;
      ELSE
         RAISE error_largo;
      END IF;
   ELSE
      IF NOT SN_cod_retorno <> '0' THEN
         IF 15 >= LENGTH(EN_num_celular) THEN
            RETURN TRUE;
         ELSE
            RAISE error_largo;
         END IF;
      ELSE
         RAISE error_paramet;
      END IF;
   END IF;

EXCEPTION

   WHEN error_paramet THEN
      LV_des_error := 'ga_valida_num_celular_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_num_celular_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN error_parametro_celular THEN
      SN_cod_retorno := 142;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_num_celular_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_num_celular_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN error_largo THEN
      SN_cod_retorno := 142;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_num_celular_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_num_celular_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_num_celular_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_num_celular_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_valida_num_celular_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_existabonado_fn (
   EN_num_celular   IN         GA_ABOCEL.num_celular%TYPE,
   SN_num_abonado   OUT NOCOPY GA_ABOCEL.NUM_ABONADO%TYPE,
   SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)
/*
<Documentacion
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_EXISTABONADO_FN"
      Fecha modificacion=" "
      Fecha="29-12-2004"
      Constructor="Carlos Navarro H. - Marcelo Godoy S."
      Modificador=" "
      Ambiente Desarrollo="DEIMOS_TMC">
      <Retorno>BOOLEAN</Retorno>
      <Descripcion>Validar la existencia de un Abonado y que este no este en baja</Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"     Tipo="NUMERICO">Numero de Abonado</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
   RETURN BOOLEAN
AS
   CURSOR abonados_cu (nnumcelular GA_ABOCEL.num_celular%TYPE)
   IS
      SELECT   abo.cod_situacion, abo.fec_alta, abo.NUM_ABONADO
         FROM GA_ABOAMIST abo
         WHERE num_celular = nnumcelular
      UNION
      SELECT   abo.cod_situacion, abo.fec_alta, abo.NUM_ABONADO
         FROM GA_ABOCEL abo
         WHERE num_celular = nnumcelular
      ORDER BY fec_alta DESC;


   error_abonado_baja       EXCEPTION;
   error_no_abonado         EXCEPTION;
   error_parametro_celular  EXCEPTION;
   error_val_celular        EXCEPTION;
   regaboando               BOOLEAN;
   LV_des_error              ge_errores_pg.DesEvent;
   LV_sSql                     ge_errores_pg.vQuery;
   BV_valabonado BOOLEAN; --COL-36441|28-12-2006|PBR

BEGIN

   IF EN_num_celular IS NULL THEN
         RAISE error_parametro_celular;
   END IF;

   SN_cod_retorno := 0;
   SV_mens_retorno:= '';
   SN_num_evento  := 0;

   IF ga_valida_num_celular_fn(EN_num_celular, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN

      LV_sSql := 'SELECT abo.cod_situacion, abo.fec_alta, abo.num_abonado';
      LV_sSql := LV_sSql || ' FROM ga_aboamist abo';
      LV_sSql := LV_sSql || ' WHERE num_celular = ' || EN_num_celular;
      LV_sSql := LV_sSql || ' UNION';
      LV_sSql := LV_sSql || ' SELECT   abo.cod_situacion, abo.fec_alta, abo.num_abonado';
      LV_sSql := LV_sSql || ' FROM ga_abocel abo';
      LV_sSql := LV_sSql || ' WHERE num_celular = ' || EN_num_celular;
      LV_sSql := LV_sSql || ' ORDER BY fec_alta DESC;';

      regaboando := FALSE ;
      BV_valabonado:=FALSE;
      FOR ABONADOS IN abonados_cu (EN_num_celular) LOOP
         regaboando := TRUE ;

         IF ABONADOS.cod_situacion = 'BAA' THEN
            -- INI COL-36441|28-12-2006|PBR
            -- RAISE error_abonado_baja;
            BV_valabonado:=FALSE;
            --FIN COL-36441|28-12-2006|PBR
         ELSE
            SN_num_abonado := ABONADOS.NUM_ABONADO;
            SN_cod_retorno := 0;
            BV_valabonado:=TRUE;
            RETURN TRUE ;
            EXIT;
         END IF;
      END LOOP;

      IF NOT regaboando THEN
         RAISE error_no_abonado;
      END IF;
      --INI COL-36441|28-12-2006|PBR
      IF NOT BV_valabonado THEN
      	RAISE error_abonado_baja;
      END IF;
      --FIN COL-36441|28-12-2006|PBR
   ELSE
      RAISE error_val_celular;
   END IF;

EXCEPTION

   WHEN error_val_celular THEN
      LV_des_error := 'ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_existabonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE ;

   WHEN error_parametro_celular THEN
      SN_cod_retorno := 142;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_existabonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE ;

   WHEN error_no_abonado THEN
      SN_cod_retorno := 144;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_existabonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE ;

   WHEN error_abonado_baja THEN
      SN_cod_retorno := 146;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_existabonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 145;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_valida_existabonado_fn('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_valida_existabonado_fn', LV_sSql, SN_cod_retorno, LV_des_error );
      RETURN FALSE;

END ga_valida_existabonado_fn;

----------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_reg_atencion_cliente_pr (
                                EN_num_celular      IN  GA_ABOCEL.num_celular%TYPE,
                                EN_cod_atencion     IN  CI_REG_ATENCION_CLIENTES.cod_atencion%TYPE,
                                EV_obs_atencion     IN  CI_REG_ATENCION_CLIENTES.obs_atencion%TYPE,
                                EV_nom_usuario      IN  CI_REG_ATENCION_CLIENTES.nom_usuarora%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.evento
								)
IS
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_REG_ATENCION_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador="Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Reutiliza ga_reg_atencion_cliente_pg</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="" Tipo=""></param>
         </Entrada>
         <Salida>
			<param nom=""     Tipo=""></param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
   LV_des_error 		ge_errores_pg.DesEvent;
   LV_sSql        		ge_errores_pg.vQuery;
   LV_cod_oficina       GE_SEG_USUARIO.cod_oficina%TYPE;
   error_ejecucion      EXCEPTION;

BEGIN
   SN_cod_retorno  := 0;
   SV_mens_retorno := '';
   SN_num_evento   := 0;

	LV_sSql := 'SELECT a.cod_oficina    '||
		 	'INTO   LV_cod_oficina   '||
			'FROM   ge_seg_usuario a '||
			'WHERE  a.nom_usuario =  '|| EV_nom_usuario;

	SELECT a.cod_oficina
	INTO   LV_cod_oficina
	FROM   GE_SEG_USUARIO a
	WHERE  a.nom_usuario = EV_nom_usuario;

	LV_sSql := 'Ga_Reg_Atencion_Cliente_Ng_Pg.ga_inserta_reg_atencion_pr('||EN_num_celular||', '||EN_cod_atencion||', '||EV_obs_atencion || EN_num_celular||', '||EV_nom_usuario||', '||LV_cod_oficina||', '||SN_cod_retorno||', '||SV_mens_retorno||', '||SN_num_evento||')';

    Ga_Reg_Atencion_Cliente_Ng_Pg.ga_inserta_reg_atencion_pr
   						(EN_num_celular, EN_cod_atencion, EV_obs_atencion || EN_num_celular,
						 EV_nom_usuario, LV_cod_oficina, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
	IF SN_cod_retorno <> 0 THEN
	    RAISE error_ejecucion;
	END IF;

EXCEPTION
   WHEN error_ejecucion THEN
      LV_des_error := 'ga_reg_atencion_cliente_pg('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_reg_atencion_cliente_pg', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 173;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_reg_atencion_cliente_pg('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_reg_atencion_cliente_pg', LV_sSql, SN_cod_retorno, LV_des_error );

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'ga_reg_atencion_cliente_pg('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_reg_atencion_cliente_pg', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_reg_atencion_cliente_pr;

----------------------------------------------------------------------------------------------------------------------

FUNCTION ga_origen_cliente_fn (
      en_num_celular       IN              GA_ABOCEL.num_celular%TYPE,
      sn_num_abonado       OUT NOCOPY      GA_ABOCEL.NUM_ABONADO%TYPE,
      sn_cod_cliente       OUT NOCOPY      GA_ABOCEL.cod_cliente%TYPE,
      sv_nom_abocli        OUT NOCOPY      VARCHAR2,
      sv_cod_situacion     OUT NOCOPY      GA_ABOCEL.cod_situacion%TYPE,
      sn_cod_cuenta        OUT NOCOPY      GA_ABOCEL.cod_cuenta%TYPE,
      sv_cod_clave         OUT NOCOPY      GA_ABOCEL.cod_password%TYPE,
      sv_tip_plantarif     OUT NOCOPY      GA_ABOCEL.tip_plantarif%TYPE,
      sv_cod_plantarif     OUT NOCOPY      GA_ABOCEL.cod_plantarif%TYPE,
      sv_cod_tecnología    OUT NOCOPY      GA_ABOCEL.cod_tecnologia%TYPE,
      sv_cod_perfil        OUT NOCOPY      VARCHAR2,
      sn_cod_ciclo         OUT NOCOPY      GA_ABOCEL.cod_ciclo%TYPE,
      sn_fono_contacto     OUT NOCOPY      VARCHAR2,
      sv_num_serie         OUT NOCOPY      VARCHAR2,
      sv_num_imei          OUT NOCOPY      VARCHAR2,
      sv_num_min_mdn       OUT NOCOPY      VARCHAR2,
      sv_num_min           OUT NOCOPY      VARCHAR2,
      sv_num_seriehex      OUT NOCOPY      VARCHAR2,
      sv_num_seriemec      OUT NOCOPY      VARCHAR2,
      sv_tip_terminal      OUT NOCOPY      VARCHAR2,
      sv_tip_abonado       OUT NOCOPY      VARCHAR2,
      sv_cod_estado        OUT NOCOPY      VARCHAR2,
      sn_cod_producto      OUT NOCOPY      GA_ABOCEL.cod_producto%TYPE,
      sv_nom_responsable   OUT NOCOPY      VARCHAR2,
      sv_des_plantarif     OUT NOCOPY      VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_ORIGEN_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente consultados del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"     Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="SN_cod_cliente"     Tipo="NUMERICO">Codigo del Cliente</param>
			<param nom="SV_nom_abocli"      Tipo="CARACTER>Nombre completo del cliente</param>
			<param nom="SV_cod_situacion"   Tipo="CARACTER">Codigo de situacion abonado</param>
			<param nom="SN_cod_cuenta"    	Tipo="NUMERICO">Codigo de la cuenta</param>
			<param nom="SV_cod_clave"   	Tipo="CARACTER">Clave del cliente</param>
			<param nom="SV_tip_plantarif"   Tipo="CARACTER">Tipo de plan tarifario</param>
            <param nom="SV_cod_plantarif"   Tipo="CARACTER">Codigo plan tarifario</param>
			<param nom="SV_cod_tecnología"  Tipo="CARACTER">Tecnología asociada al cliente</param>
            <param nom="SN_cod_perfil"    	Tipo="NUMERICO">Perfil del cliente</param>
            <param nom="SN_cod_ciclo"       Tipo="NUMERICO">Codigo ciclo facturacion</param>
            <param nom="SV_fono_contacto"   Tipo="CARACTER">Teléfono de contacto</param>
		    <param nom="SV_num_serie"       Tipo="CARACTER">Numero de serie decimal</param>
			<param nom="SV_num_imei"        Tipo="CARACTER">Numero de seire terminal GSM</param>
			<param nom="SV_num_min_mdn"     Tipo="CARACTER">Min asociado al nro celular</param>
			<param nom="SV_num_min"         Tipo="CARACTER">Prefijo min</param>
			<param nom="SV_num_seriehex"    Tipo="CARACTER">Numero de serie hexadecimal</param>
			<param nom="SV_num_seriemec"    Tipo="CARACTER">Numero de serie mecanico</param>
			<param nom="SV_tip_terminal"    Tipo="CARACTER">Tipo de terminal</param>
			<param nom="SV_tipo_abonado"    Tipo="CARACTER">Tipo de abonado</param>
			<param nom="SV_cod_estado"    	Tipo="CARACTER">Estado en Cartera de Cobros</param>
            <param nom="SN_cod_producto"    Tipo="NUMERICO">Codigo de producto</param>
            <param nom="SV_nom_responsable" Tipo="CARACTER">Nombre del responsable</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
IS

 LN_num_transaccion GA_TRANSACABO.num_transaccion%TYPE;
 LV_cod_grupo       AL_TECNOLOGIA.cod_grupo%TYPE;
 LV_val_grupo_gsm	AL_TECNOLOGIA.cod_grupo%TYPE;
 LV_des_error 		ge_errores_pg.DesEvent;
 LN_num_abonado		GA_ABOCEL.NUM_ABONADO%TYPE;
 LV_sSql        	ge_errores_pg.vQuery;
 LV_cod_actuacion   GA_ACTABO.cod_actabo%TYPE:='IV';
 LV_execute		    VARCHAR2(7)	 := 'EXECUTE';
 LV_param_entrada   VARCHAR2(500);

 error_ejecucion	EXCEPTION;
 error_parametros	EXCEPTION;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno:= '';
		SN_num_evento  := 0;

	 	-- Valida parametros de entrada
	    IF EN_num_celular IS NULL THEN
           RAISE error_parametros;
	    END IF;

		-- Valida largo del celular --
		LV_sSql:='ga_valida_num_celular_fn('||EN_num_celular||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');';
		IF NOT ga_valida_num_celular_fn (EN_num_celular,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           RAISE  error_ejecucion;
        END IF;

		-- Valida existencia que no sea en baja activa abonado 'BAA'
		LV_sSql:='ga_valida_existabonado_fn('||EN_num_celular||','||LN_num_abonado||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');';
        IF NOT ga_valida_existabonado_fn(EN_num_celular, LN_num_abonado, SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           RAISE  error_ejecucion;
        END IF;

		-- Ejecutar procedimiento que obtiene datos del abonado
   		LV_sSql:=SUBSTR('SELECT a.num_abonado, a.cod_cliente, a.cod_situacion, a.cod_cuenta, a.cod_password,'||
			   		 'a.tip_plantarif, a.cod_plantarif, a.cod_tecnologia, a.cod_ciclo, c.tef_cliente1,'||
			   		 'a.num_serie, a.num_imei, a.num_min_mdn, a.num_min, a.num_seriehex,'||
			   		 'a.num_seriemec, a.tip_terminal, b.cod_tiplan, a.cod_estado, a.cod_producto, d.nom_responsable,'||
					 'NVL(SUBSTR(TRIM(e.nom_usuario)'||' '||'TRIM(e.nom_apellido1)'||' '||'TRIM(e.nom_apellido2),1,CN_largo_nomcli),SUBSTR(TRIM(c.nom_cliente)'||' '||'TRIM(c.nom_apeclien1)'||' '||'TRIM(c.nom_apeclien2),1,CN_largo_nomcli)) '||
			   		 'INTO '||
					 'SN_num_abonado, SN_cod_cliente, SV_cod_situacion, SN_cod_cuenta, SV_cod_clave,'||
					 'SV_tip_plantarif, SV_cod_plantarif, SV_cod_tecnología, SN_cod_ciclo, SN_fono_contacto,'||
			   		 'SV_num_serie, SV_num_imei, SV_num_min_mdn, SV_num_min, SV_num_seriehex ,'||
			   		 'SV_num_seriemec, SV_tip_terminal, SV_tip_abonado, SV_cod_estado, SN_cod_producto, '||
					 'SV_nom_responsable, SV_nom_abocli'||
					 'FROM   ga_abocel a, ta_plantarif b, ge_clientes c, ga_cuentas d, ga_usuarios e'||
					 'WHERE a.cod_plantarif = b.cod_plantarif ' ||
					 'AND	a.cod_cliente   = c.cod_cliente ' ||
					 'AND	a.cod_cuenta	= d.cod_cuenta ' ||
					 'AND   e.cod_usuario   = a.cod_usuario ' ||
					 'AND	a.num_celular   = ' ||EN_num_celular ||
					 'AND	b.cod_producto  = ' ||CN_cod_producto ||
			   		 'AND	a.cod_situacion <> '||'BAA'||
					 'UNION'||
					 'SELECT a.num_abonado  , a.cod_cliente  , a.cod_situacion , a.cod_cuenta   , a.cod_password,'||
			   		 'a.tip_plantarif, a.cod_plantarif, a.cod_tecnologia, a.cod_ciclo    , c.tef_cliente1,'||
			   		 'a.num_serie    , a.num_imei     , a.num_min_mdn   , a.num_min	  , a.num_seriehex,'||
			   		 'a.num_seriemec, a.tip_terminal, b.cod_tiplan, a.cod_estado	  , a.cod_producto, , d.nom_responsable,'||
					 'SUBSTR(TRIM(c.nom_cliente)'||' '||'TRIM(c.nom_apeclien1)'||' '||'TRIM(c.nom_apeclien2),1,CN_largo_nomcli) '||
					 'FROM   ga_aboamist a, ta_plantarif b, ge_clientes c, ga_cuentas d, ga_usuarios e'||
					 'WHERE  a.cod_plantarif = b.cod_plantarif ' ||
			 		 'AND	   a.cod_cliente   = c.cod_cliente ' ||
					 'AND	   a.cod_cuenta	   = d.cod_cuenta ' ||
					 'AND    e.cod_usuario(+)= a.cod_usuario ' ||
					 'AND	   a.num_celular   = ' || EN_num_celular||
					 'AND	   b.cod_producto  = ' || CN_cod_producto ||
					 'AND	   a.cod_situacion <> '||'BAA'||';',1,CN_largoquery);


		SELECT a.NUM_ABONADO  , a.cod_cliente  , a.cod_situacion , a.cod_cuenta   , a.cod_password,
			   a.tip_plantarif, a.cod_plantarif, a.cod_tecnologia, a.cod_ciclo    , c.tef_cliente1,
			   a.num_serie    , a.num_imei     , a.num_min_mdn   , a.num_min	  , a.num_seriehex,
			   a.num_seriemec , a.tip_terminal , b.cod_tiplan	 , a.cod_estado	  , a.cod_producto,
			   d.nom_responsable,
               NVL(SUBSTR(TRIM(e.nom_usuario)||' '||TRIM(e.nom_apellido1)||' '||TRIM(e.nom_apellido2),1,CN_largo_nomcli),SUBSTR(TRIM(c.nom_cliente)||' '||TRIM(c.nom_apeclien1)||' '||TRIM(c.nom_apeclien2),1,CN_largo_nomcli)),
			   b.des_plantarif
			   INTO
			   SN_num_abonado  , SN_cod_cliente  , SV_cod_situacion , SN_cod_cuenta, SV_cod_clave    ,
			   SV_tip_plantarif, SV_cod_plantarif, SV_cod_tecnología, SN_cod_ciclo , SN_fono_contacto,
			   SV_num_serie	   , SV_num_imei	 , SV_num_min_mdn   , SV_num_min   , SV_num_seriehex ,
			   SV_num_seriemec , SV_tip_terminal , SV_tip_abonado	, SV_cod_estado, SN_cod_producto ,
			   SV_nom_responsable, SV_nom_abocli, SV_des_plantarif
		FROM   GA_ABOCEL a, TA_PLANTARIF b, GE_CLIENTES c, GA_CUENTAS d, GA_USUARIOS e
		WHERE  a.cod_plantarif = b.cod_plantarif
		AND	   a.cod_cliente   = c.cod_cliente
		AND	   a.cod_cuenta	   = d.cod_cuenta
		AND    e.cod_usuario   =a.cod_usuario
		AND	   a.num_celular   = EN_num_celular
		AND	   b.cod_producto  = CN_cod_producto
		AND	   a.cod_situacion <> 'BAA'
		UNION
		SELECT a.NUM_ABONADO  , a.cod_cliente  , a.cod_situacion , a.cod_cuenta   , a.cod_password,
			   a.tip_plantarif, a.cod_plantarif, a.cod_tecnologia, a.cod_ciclo    , c.tef_cliente1,
			   a.num_serie    , a.num_imei     , a.num_min_mdn   , a.num_min	  , a.num_seriehex,
			   a.num_seriemec , a.tip_terminal , b.cod_tiplan	 , a.cod_estado	  , a.cod_producto,
			   d.nom_responsable,
               SUBSTR(TRIM(c.nom_cliente)||' '||TRIM(c.nom_apeclien1)||' '||TRIM(c.nom_apeclien2),1,CN_largo_nomcli),
			   b.des_plantarif
   		FROM   GA_ABOAMIST a, TA_PLANTARIF b, GE_CLIENTES c, GA_CUENTAS d, GA_USUARIOS e
		WHERE  a.cod_plantarif = b.cod_plantarif
		AND	   a.cod_cliente   = c.cod_cliente
		AND	   a.cod_cuenta	   = d.cod_cuenta
		AND    e.cod_usuario(+)= a.cod_usuario
		AND	   a.num_celular   = EN_num_celular
		AND	   b.cod_producto  = CN_cod_producto
		AND	   a.cod_situacion <> 'BAA';

		-- INI COL|36973|23/01/2007|SAQL-GEZ
		SV_nom_abocli := REPLACE(SV_nom_abocli,'&','Y');
		SV_nom_abocli := REPLACE(SV_nom_abocli,'*',' ');
		SV_nom_abocli := REPLACE(SV_nom_abocli,'|',' ');
		SV_nom_abocli := REPLACE(SV_nom_abocli,'/',' ');
		SV_nom_abocli := REPLACE(SV_nom_abocli,'\',' ');
		-- FIN COL|36973|23/01/2007|SAQL-GEZ

		LN_num_abonado := SN_num_abonado;

		IF NOT ga_recupera_valor_cliente_fn (LN_num_abonado, SV_cod_perfil, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
		   RAISE error_ejecucion;
		END IF;

		--Ejecuta restricción
        LV_param_entrada := '||||'|| LV_cod_actuacion || '|' || SN_num_abonado ||'|';
		ga_ejecuta_restriccion_pr (CV_cod_modulo, CN_cod_producto, LV_cod_actuacion, LV_execute,
							      LV_param_entrada, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
	    IF SN_cod_retorno <> 0 THEN
		    RAISE error_ejecucion;
	    END IF;

        RETURN TRUE;

EXCEPTION
	 WHEN NO_DATA_FOUND THEN
	 	  SN_cod_retorno := 149;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_origen_cliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_origen_cliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );
          RETURN FALSE;

     WHEN error_parametros THEN
     	  SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_origen_cliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_origen_cliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );
          RETURN FALSE;

	 WHEN error_ejecucion THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_origen_cliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_origen_cliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );
          RETURN FALSE;

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_origen_cliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_origen_cliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );
          RETURN FALSE;

	 WHEN OTHERS THEN
          SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_origen_cliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_origen_cliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );
          RETURN FALSE;

END;
-----------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_obtiene_planes_fn(EN_NUM_ABONADO   IN         NUMBER
		 					  ,SV_PLANX01      OUT NOCOPY VARCHAR2
		 					  ,SV_PLANX02      OUT NOCOPY VARCHAR2
							  ,SV_PLANX03      OUT NOCOPY VARCHAR2
							  ,SV_PLANX04      OUT NOCOPY VARCHAR2
							  ,SV_PLANX05      OUT NOCOPY VARCHAR2
							  ,SV_PLANX06      OUT NOCOPY VARCHAR2
							  ,SV_PLANX07      OUT NOCOPY VARCHAR2
							  ,SV_PLANX08      OUT NOCOPY VARCHAR2
							  ,SV_PLANX09      OUT NOCOPY VARCHAR2
							  ,SV_PLANX10      OUT NOCOPY VARCHAR2
							  ,SN_COD_RETORNO  OUT NOCOPY NUMBER
							  ,SV_MENS_RETORNO OUT NOCOPY VARCHAR2
							  ,SN_NUM_EVENTO   OUT NOCOPY NUMBER
							  )
							  RETURN BOOLEAN IS
/*
<Documentación
   TipoDoc = "Funcion">
   <Elemento
   	Nombre = "GA_OBTIENE_PLANES_FN"
   	Lenguaje="PL/SQL"
   	Fecha="31-10-2005"
   	Versión="1.0"
   	Diseñador="Andrés Osorio Gallardo"
   	Programador="Andrés Osorio Gallardo"
   	Ambiente Desarrollo="BD">
   	<Retorno>BOOLEAN</Retorno>
   	<Descripción>Extrae desde la base de datos los primeros 10 planes de extratiempo contratados por el abonado</Descripción>
   	<Parámetros>
       	<Salida>
				<param nom="SV_PLANX01   	  Tipo="VARCHAR">Codigo de plan extratiempo  1</param>
				<param nom="SV_PLANX02   	  Tipo="VARCHAR">Codigo de plan extratiempo  2</param>
				<param nom="SV_PLANX03  	  Tipo="VARCHAR">Codigo de plan extratiempo  3</param>
				<param nom="SV_PLANX04   	  Tipo="VARCHAR">Codigo de plan extratiempo  4</param>
				<param nom="SV_PLANX05   	  Tipo="VARCHAR">Codigo de plan extratiempo  5</param>
				<param nom="SV_PLANX06   	  Tipo="VARCHAR">Codigo de plan extratiempo  6</param>
				<param nom="SV_PLANX07   	  Tipo="VARCHAR">Codigo de plan extratiempo  7</param>
				<param nom="SV_PLANX08   	  Tipo="VARCHAR">Codigo de plan extratiempo  8</param>
				<param nom="SV_PLANX09   	  Tipo="VARCHAR">Codigo de plan extratiempo  9</param>
				<param nom="SV_PLANX10   	  Tipo="VARCHAR">Codigo de plan extratiempo 10</param>
				<param nom="SN_COD_RETORNO"   Tipo="NUMERICO">Código de Retorno (descripción de error)</param>
       	   		<param nom="SV_MENS_RETORNO"  Tipo="VARCHAR">Mensaje de Retorno (código de error)</param>
       	   		<param nom="SN_NUM_EVENTO"    Tipo="NUMERICO">Número de Evento</param>
		</Salida>
	</Parámetros>
   </Elemento>
</Documentación>
*/
  TYPE Array_planes 	 IS VARRAY (10) OF VARCHAR2(3);
  N_codretorno           ge_errores_td.cod_msgerror%TYPE;
  V_des_error            ge_errores_pg.DesEvent;
  sSql                   ge_errores_pg.vQuery;
  V_val_parametro        ged_parametros.val_parametro%TYPE;
  V_mens_retorno         ge_errores_td.det_msgerror%TYPE;
  LV_plan				 VARCHAR2(5);
  LN_cont				 NUMBER(2);
  LV_arr_planes			 Array_planes := Array_planes('','','','','','','','','','');


  -- inicio 37309 RRG 19-03-2007 COL

  vCodCliente ga_abocel.cod_cliente%TYPE;

  CURSOR c_planesx IS
  		 SELECT   a.cod_dcto
			FROM   tol_cliedcto_to b, tol_detabondcto_td  a
			WHERE
			b.cod_cliente = vCodCliente
			AND a.cod_abonado = EN_NUM_ABONADO
			and a.tip_dcto=b.tip_dcto
			and a.cod_dcto=b.cod_dcto
			and a.cod_cliente=b.cod_cliente
			AND B.fec_ter_vig> SYSDATE
			and a.fec_ini_vig=b.fec_ini_vig
			AND SUBSTR(a.cod_dcto,1,LENGTH(LV_PREFIJOX)) = LV_PREFIJOX
			AND ROWNUM <=10
			ORDER BY a.fec_ini_vig;



  		 /*SELECT a.cod_dcto
  		 -- Inicio 34683, 14/10/2006 PBR
	 	 -- FROM   tol_cliedcto_det a
	 	 FROM   tol_cliedcto_det a,tol_cliedcto_to b
	 	 -- Fin 34683, 14/10/2006 PBR
		 WHERE  a.COD_ABONADO = EN_NUM_ABONADO
		 AND	SUBSTR(a.cod_dcto,1,LENGTH(LV_PREFIJOX)) = LV_PREFIJOX
		 -- Inicio 34683, 14/10/2006 PBR
		 AND a.tip_dcto=b.tip_dcto
		 AND a.cod_dcto=b.cod_dcto
		 AND a.cod_cliente=b.cod_cliente
		 AND B.fec_ter_vig> SYSDATE
		 AND a.fec_ini_vig=b.fec_ini_vig
		 -- Fin 34683, 14/10/2006 PBR
		 AND ROWNUM <=10
		 ORDER BY a.fec_ini_vig; */


--- fin 37309 RRG 19-03-2007 COL


BEGIN

     -- inicio 37309 RRG 19-03-2007 COL
     -- Se recupera cod_cliente para optimizar query de planes  de extratiempos

     select  cod_cliente into vCodCliente from (
     select cod_cliente  from ga_abocel where num_abonado = EN_NUM_ABONADO
     union all
     select cod_cliente  from ga_aboamist where num_abonado = EN_NUM_ABONADO )
     where rownum=1;

	 --- fin 37309 RRG 19-03-2007 COL

	 --Inicio RA-200511170139, PBR 10/01/2006
	 SN_cod_retorno  := 0;
	 SV_mens_retorno := '';
	 SN_num_evento   := 0;
	 --Fin RA-200511170139, PBR 10/01/2006
	 sSql := 'SELECT a.cod_dcto'
	 --sSql := 'SELECT a.cod_dcto'
	 -- Inicio 34683, 14/10/2006 PBR
	 	  	 -- ||' FROM   tol_cliedcto_det a'
	 	  	 ||' FROM   tol_cliedcto_det a,tol_cliedcto_to b'
			 ||' WHERE  a.COD_ABONADO = '||EN_NUM_ABONADO
			 ||' AND	 SUBSTR(a.cod_dcto,1,LENGTH('||LV_PREFIJOX||')) ='||LV_PREFIJOX
			 -- Inicio 34683, 14/10/2006 PBR
			 ||'AND a.tip_dcto=b.tip_dcto'
			 ||'AND a.cod_dcto=b.cod_dcto'
			 ||'AND a.cod_cliente=b.cod_cliente'
			 ||'AND B.fec_ter_vig> SYSDATE'
			 ||'AND a.fec_ini_vig=b.fec_ini_vig'
			 -- Fin 34683, 14/10/2006 PBR
			 ||' AND ROWNUM <=10'
			 ||' ORDER BY a.fec_ini_vig';

	OPEN c_planesx;

	FOR LN_cont IN 1..10 LOOP
		FETCH c_planesx INTO LV_plan;
		EXIT WHEN c_planesx%NOTFOUND;

  		IF LENGTH(LV_plan) > 3 THEN
			LV_arr_planes(LN_cont):= SUBSTR(LV_plan,1,3);
		ELSE
			LV_arr_planes(LN_cont):= LV_plan;
		END IF;

	END LOOP;
	CLOSE c_planesx;

	SV_PLANX01 := LV_arr_planes (1);
	SV_PLANX02 := LV_arr_planes (2);
	SV_PLANX03 := LV_arr_planes (3);
	SV_PLANX04 := LV_arr_planes (4);
	SV_PLANX05 := LV_arr_planes (5);
	SV_PLANX06 := LV_arr_planes (6);
	SV_PLANX07 := LV_arr_planes (7);
	SV_PLANX08 := LV_arr_planes (8);
	SV_PLANX09 := LV_arr_planes (9);
	SV_PLANX10 := LV_arr_planes(10);

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		 SN_cod_retorno := '526';
      	 IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	SV_mens_retorno := CV_error_no_clasIF;
      	 END  IF;
      	 V_des_error := SUBSTR('OTHERS: ga_obtiene_prefijo_fn(''); - ' || SQLERRM,1,CN_largoerrtec);
	  	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER, 'ga_extratiempo_pg.ga_valida_prefijo_fn', sSql, SQLCODE, V_des_error );
      	 RETURN  FALSE;
END ga_obtiene_planes_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_segmentacion_pr (
  								EN_num_celular		 IN NUMBER,
								SN_num_abonado		 OUT NOCOPY GA_ABOCEL.NUM_ABONADO%TYPE,
								SV_nom_abocli		 OUT NOCOPY VARCHAR2,
								SV_cod_perfil		 OUT NOCOPY VARCHAR2,
								SV_signo_saldo_cta	 OUT NOCOPY VARCHAR2,
								SV_saldo_cta		 OUT NOCOPY VARCHAR2,
								SV_saldo_30_dias 	 OUT NOCOPY VARCHAR2,
								SV_saldo_60_dias	 OUT NOCOPY VARCHAR2,
								SV_saldo_90_dias	 OUT NOCOPY VARCHAR2,
								SV_saldo_120_dias	 OUT NOCOPY VARCHAR2,
								SV_cod_suspendido	 OUT NOCOPY VARCHAR2,
								SV_valor_ult_pago	 OUT NOCOPY VARCHAR2,
								SV_fecha_ult_pago	 OUT NOCOPY DATE,
								SV_fecha_limite_pago OUT NOCOPY DATE,
								/* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
								/* SN_cod_cuenta		 OUT NOCOPY NUMBER, */
								SN_COD_CLIENTE 		OUT NOCOPY NUMBER,
								/* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
								SV_estado_servicio	 OUT NOCOPY VARCHAR2,
								SV_cod_clave		 OUT NOCOPY VARCHAR2,
								SV_cod_plantarif	 OUT NOCOPY VARCHAR2,
								SV_fecha_corte		 OUT NOCOPY DATE,
								/* Inicio modificacion by SAQL/Soporte 07/10/2006 - 34683 */
								/* SN_cont_tasación	 OUT NOCOPY NUMBER, */
								SN_cont_tasacion	 OUT NOCOPY NUMBER,
								/* Inicio modificacion by SAQL/Soporte 07/10/2006 - 34683 */
								SV_ind_servicios	 OUT NOCOPY VARCHAR2,
								SV_des_plantarif	 OUT NOCOPY VARCHAR2,
								SN_VAL_MINTOTAL	     OUT NOCOPY	NUMBER,
								SN_VAL_USADO         OUT NOCOPY NUMBER,
								SN_VAL_DISPONIBLE    OUT NOCOPY	NUMBER,
								SN_USADO_BOLSA       OUT NOCOPY	NUMBER,
								SN_DISPONIBLE_BOLSA  OUT NOCOPY NUMBER,
								SV_PLANX01      	 OUT NOCOPY VARCHAR2,
		 					  	SV_PLANX02      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX03      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX04      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX05      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX06      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX07      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX08      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX09      	 OUT NOCOPY VARCHAR2,
							  	SV_PLANX10      	 OUT NOCOPY VARCHAR2,
								SN_cod_retorno		 OUT NOCOPY NUMBER,
								SV_mens_retorno		 OUT NOCOPY VARCHAR2,
								SN_num_evento		 OUT NOCOPY NUMBER
	  						  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_SEGMENTACION_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2005"
      Versión="1.1"
      Diseñador=""Maricel Abalos"
      Programador="Rubén Dagach"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que retorna datos de segmentacuón del cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_num_abonado"       Tipo="NUMERICO">Secuencia nro del abonado</param>
            <param nom="SV_nom_abocli"        Tipo="NUMERICO">Nombre del Cliente</param>
            <param nom="SV_cod_perfil"        Tipo="NUMERICO">Codigo de perfil</param>
            <param nom="SV_signo_saldo_cta"   Tipo="CARACTER">Signo del saldo de la cuenta (+ / -) /param>
            <param nom="SV_saldo_cta"         Tipo="CARACTER">Saldo de la cuenta</param>
            <param nom="SV_saldo_30_dias"     Tipo="CARACTER">Saldo a 30 días</param>
            <param nom="SV_saldo_60_dias"     Tipo="CARACTER">Saldo a 60 días</param>
            <param nom="SV_saldo_90_dias"     Tipo="NUMERICO">Saldo a 90 días</param>
            <param nom="SV_saldo_120_dias"    Tipo="CARACTER">Saldo a 120 días</param>
            <param nom="SV_cod_suspendido"    Tipo="CARACTER">Código de suspención</param>
            <param nom="SV_valor_ult_pago"    Tipo="CARACTER">Valor último pago</param>
            <param nom="SV_fecha_ult_pago"    Tipo="CARACTER">Fecha último pago</param>
            <param nom="SV_fecha_limite_pago" Tipo="CARACTER">Fecha limite de pago</param>
            -- Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913
            -- <param nom="SN_cod_cuenta"        Tipo="CARACTER">Códgp cuenta</param>
            <PARAM NOM="SN_COD_CLIENTE" TIPO="NUMERICO">CODIGO CLIENTE</PARAM>
            -- Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913
            <param nom="SV_estado_servicio"   Tipo="CARACTER">Estado servicio</param>
            <param nom="SV_cod_clave"         Tipo="CARACTER">Código clave</param>
		    <param nom="SV_cod_plantarif"     Tipo="CARACTER">Código plan tarifario</param>
		    <param nom="SV_fecha_corte"    	  Tipo="NUMERICO">Fecha corte</param>
		    <param nom="SN_cont_tasación"     Tipo="NUMERICO">Comtador de tasación</param>
		    <param nom="SV_ind_servicios"     Tipo="NUMERICO">Indicador de servicios</param>
			<param nom="SN_VAL_MINTOTAL"  	  Tipo="NUMERICO">Cantidad de Minutos de Extratiempo contratado</param>
       	    <param nom="SN_VAL_USADO"  	      Tipo="NUMERICO">Cantidad de Minutos Usados en extratiempo</param>
       	    <param nom="SN_VAL_DISPONIBLE"    Tipo="NUMERICO">Cantidad de Minutos disponible en extratiempo</param>
       	   	<param nom="SN_USADO_BOLSA"       Tipo="NUMERICO">Cantidad de Minutos Usados en bolsa</param>
       	   	<param nom="SN_DISPONIBLE_BOLSA"  Tipo="NUMERICO">Cantidad de Minutos Disponibles en bolsa</param>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS
LV_nom_tabla    CO_CODIGOS.nom_tabla%TYPE  := 'CO_CARTERA';
LV_nom_columna  CO_CODIGOS.nom_columna%TYPE:= 'COD_TIPDOCUM';
LV_des_error 	ge_errores_pg.DesEvent;
LV_sSql        	ge_errores_pg.vQuery;
LN_dias			NUMBER(3);
LN_Deuda		CO_CARTERA.importe_debe%TYPE;
LN_cont         NUMBER(5);
LN_1		    NUMBER(1)				  := 1;
LV_plantarif	VARCHAR2(1);
LS_saldos		VARCHAR2(100);
LN_xpos			NUMBER(2);
LN_ypos			NUMBER(2);
LN_cod_atencion NUMBER(3);

error_ejecucion   EXCEPTION;
error_parametros  EXCEPTION;
error_extratiempo EXCEPTION;

LV_COD_PLAN		VARCHAR2(5);
LN_VAL_MINTOTAL		NUMBER :=0;
LN_VAL_USADO		NUMBER :=0;
LN_VAL_DISPONIBLE	NUMBER :=0;
LN_USADO_BOLSA		NUMBER :=0;
LN_DISPONIBLE_BOLSA     NUMBER :=0;

-- Inicio modificacion by SAQL/Soporte 12/01/2006 - RA-200511170139
LV_VAL_PARAMETRO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
-- Fin modificacion by SAQL/Soporte 12/01/2006 - RA-200511170139
-- Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913
SN_cod_cuenta NUMBER;
-- Fin  modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913

-- Inicio modificacion by RRG/Soporte 08/02/2007   RA-37309
CURSOR 	c_planes_extratiempos IS
			SELECT   a.cod_dcto
		 	 FROM   tol_cliedcto_to b, tol_detabondcto_td a
			WHERE b.cod_cliente = SN_COD_CLIENTE
			  AND a.cod_abonado = SN_num_abonado
			 and a.tip_dcto=b.tip_dcto
			 and a.cod_dcto=b.cod_dcto
			 and a.cod_cliente=b.cod_cliente
			 AND B.fec_ter_vig> SYSDATE
			 and a.fec_ini_vig=b.fec_ini_vig
			 AND SUBSTR(a.cod_dcto,1,LENGTH(LV_PREFIJOX)) = LV_PREFIJOX
			ORDER BY a.fec_ini_vig ASC;
-- Fin  modificacion by RRG/Soporte 08/02/2007   RA-37309

			/*SELECT   a.cod_dcto
	  		 -- Inicio 34683, 14/10/2006 PBR
		 	 -- FROM   tol_cliedcto_det a
		 	 FROM   tol_cliedcto_det a,tol_cliedcto_to b
		 	 -- Fin 34683, 14/10/2006 PBR
			WHERE    a.cod_abonado = SN_num_abonado
			AND	     SUBSTR(a.cod_dcto,1,LENGTH(LV_PREFIJOX)) = LV_PREFIJOX
			 -- Inicio 34683, 14/10/2006 PBR
			 and a.tip_dcto=b.tip_dcto
			 and a.cod_dcto=b.cod_dcto
			 and a.cod_cliente=b.cod_cliente
			 AND B.fec_ter_vig> SYSDATE
			 and a.fec_ini_vig=b.fec_ini_vig
			 -- Fin 34683, 14/10/2006 PBR
			ORDER BY a.fec_ini_vig ASC; */

BEGIN
	 SN_VAL_MINTOTAL := 0;
	 SN_VAL_USADO := 0;
	 SN_VAL_DISPONIBLE := 0;
	 SN_USADO_BOLSA := 0;
	 SN_DISPONIBLE_BOLSA := 0;

        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
		SN_num_evento   := 0;

	    -- Obtiene datos del abonado
   IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, SN_num_abonado, GN_cod_cliente, SV_nom_abocli, GV_cod_situacion  , SN_cod_cuenta, SV_cod_clave,
					                              GV_tip_plantarif, SV_cod_plantarif, GV_cod_tecnologia, SV_cod_perfil, GN_cod_ciclo, GN_fono_contacto, GV_num_serie,
                                                  GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, SV_estado_servicio,
												  GN_cod_producto, GV_nom_responsable, SV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;
   /* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
   SN_COD_CLIENTE := GN_COD_CLIENTE;
   /* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */

	LV_sSql:=' SELECT cat.nro_dgracia ' ||
 		         ' FROM   ge_clientes cli, co_categorias_td cat, co_catcobclie_td cob' ||
		         ' WHERE  cob.cod_catecli = cli.cod_categoria ' ||
				   		 'AND cat.cod_categoria = cob.cod_catecob' ||
						 'AND cod_cliente = ' || GN_cod_cliente;

		SELECT cat.nro_dgracia
		INTO  LN_dias
		FROM  GE_CLIENTES cli, CO_CATEGORIAS_TD cat, CO_CATCOBCLIE_TD cob
		WHERE cob.cod_catecli = cli.cod_categoria
		 	  AND cat.cod_categoria = cob.cod_catecob
			  AND cli.cod_cliente = GN_cod_cliente;

		-- Obtiene Deuda -
	   	LV_sSql:='SELECT NVL(SUM(a.importe_debe - a.importe_haber),0)' ||
				 'FROM   co_cartera a' ||
				 'WHERE  a.cod_cliente   = ' || GN_cod_cliente ||
				 'AND    a.ind_facturado = ' || LN_1 ||
				 'AND    a.fec_vencimie  < TRUNC(SYSDATE)' ||
				 'AND    a.fec_vencimie  + ' || LN_dias || ' < TRUNC(SYSDATE)' ||
				 'AND    NOT EXISTS (SELECT 1' ||
					                'FROM   co_codigos b'||
					                'WHERE  b.nom_tabla   		   = ' || LV_nom_tabla ||
					                'AND    b.nom_columna          = ' || LV_nom_columna ||
									'AND    TO_NUMBER(b.cod_valor) = a.cod_tipdocum)';

		/* Inicio modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */
		/* SELECT NVL(SUM(a.importe_debe - a.importe_haber),0)
		INTO   LN_Deuda
		FROM   CO_CARTERA a
		WHERE  a.cod_cliente   = GN_cod_cliente
		AND    a.ind_facturado = LN_1
		AND    a.fec_vencimie  < TRUNC(SYSDATE)
		AND    a.fec_vencimie  + LN_dias  < TRUNC(SYSDATE)
		AND    NOT EXISTS (SELECT 1
		                   FROM   CO_CODIGOS b
		                   WHERE  b.nom_tabla   		 = LV_nom_tabla
		                   AND    b.nom_columna          = LV_nom_columna
						   AND    TO_NUMBER(b.cod_valor) = a.cod_tipdocum);*/
		/* Inicio modificacion by SAQL/Soporte 31/07/2006 - CO-200605230153
		SELECT NVL(SUM(a.importe_debe - a.importe_haber),0) INTO LN_Deuda
		FROM CO_CARTERA A, GE_CLIENTES B
		WHERE  A.COD_CLIENTE   = B.COD_CLIENTE
		AND B.COD_CUENTA = SN_COD_CUENTA
		AND A.IND_FACTURADO < 2
		-- Inicio modificacion by SAQL/Soporte 25/05/2006 - CO-200605230153
		AND A.NUM_ABONADO = SN_num_abonado
		-- Fin modificacion by SAQL/Soporte 25/05/2006 - CO-200605230153
		AND NOT EXISTS (
		   SELECT 1
		   FROM CO_CODIGOS b
		   WHERE b.nom_tabla = LV_nom_tabla
		   AND b.nom_columna = LV_nom_columna
		   AND TO_NUMBER(b.cod_valor) = a.cod_tipdocum); */

		SELECT NVL(SUM(a.importe_debe - a.importe_haber),0) INTO LN_Deuda
		FROM CO_CARTERA A
		WHERE A.COD_CLIENTE = SN_COD_CLIENTE
		AND A.IND_FACTURADO = 1
		AND NOT EXISTS (
		   SELECT 1
		   FROM CO_CODIGOS b
		   WHERE b.nom_tabla = LV_nom_tabla
		   AND b.nom_columna = LV_nom_columna
		   AND TO_NUMBER(b.cod_valor) = a.cod_tipdocum);
		/* Fin modificacion by SAQL/Soporte 31/07/2006 - CO-200605230153 */

		/* Fin modificacion by SAQL/Soporte 14/03/2006 - RA-200603140913 */

        --Signo del saldo
 		IF LN_deuda < 0 THEN
		   SV_signo_saldo_cta:='-';
		ELSE
  		   SV_signo_saldo_cta:='+';
		END IF;

		if length(LN_Deuda) > 10 then --- 40470 RRG  12-05-2007
		   LN_Deuda := round(LN_Deuda);
		end if;

		SV_saldo_cta := LN_Deuda ;

		-- Saldos de cada mes
		LV_sSql:=' SELECT co_fn_cajon_cobranza(' || GN_cod_cliente || ', T, S ) FROM DUAL';

		LS_saldos:= Co_Fn_Cajon_Cobranza(GN_cod_cliente, 'T', 'S');

		-- Calculo de saldos 30-60-90-120
		LN_xpos:= INSTR(LS_saldos,';');
		IF LN_xpos > 0 THEN
		   LN_ypos:= INSTR(LS_saldos,';',LN_xpos+1);
         /* INI COL|40470|11/05/2007|SAQL */
         IF LENGTH(SUBSTR(LS_SALDOS, LN_XPOS+1, LN_YPOS-(LN_XPOS+1)))>10 THEN
            SV_saldo_30_dias := TO_CHAR(ROUND(SUBSTR(LS_saldos ,LN_xpos+1, LN_ypos-(LN_xpos+1)),0));
         ELSE
            SV_saldo_30_dias := SUBSTR(LS_saldos ,LN_xpos+1, LN_ypos-(LN_xpos+1));
         END IF;
         /* FIN COL|40470|11/05/2007|SAQL */

		   LN_xpos:= INSTR(LS_saldos,';',LN_ypos+1);

         /* INI COL|40470|11/05/2007|SAQL */
         IF LENGTH(SUBSTR(LS_saldos ,LN_ypos+1, LN_xpos-(LN_ypos+1)))>10 THEN
            SV_saldo_60_dias := TO_CHAR(ROUND(SUBSTR(LS_saldos ,LN_ypos+1, LN_xpos-(LN_ypos+1)),0));
         ELSE
		      SV_saldo_60_dias := SUBSTR(LS_saldos ,LN_ypos+1, LN_xpos-(LN_ypos+1));
         END IF;
         /* FIN COL|40470|11/05/2007|SAQL */

   		LN_ypos:= INSTR(LS_saldos,';',LN_xpos+1);

         /* INI COL|40470|11/05/2007|SAQL */
         IF LENGTH(SUBSTR(LS_saldos ,LN_xpos+1, LN_ypos-(LN_xpos+1)))>10 THEN
            SV_saldo_90_dias := TO_CHAR(ROUND(SUBSTR(LS_saldos ,LN_xpos+1, LN_ypos-(LN_xpos+1)),0));
         ELSE
		      SV_saldo_90_dias := SUBSTR(LS_saldos ,LN_xpos+1, LN_ypos-(LN_xpos+1));
         END IF;
         IF LENGTH(SUBSTR(LS_saldos ,LN_ypos+1, LENGTH(LS_saldos)-LN_ypos+1))>10 THEN
            SV_saldo_120_dias := TO_CHAR(ROUND(SUBSTR(LS_saldos ,LN_ypos+1, LENGTH(LS_saldos)-LN_ypos+1),0));
         ELSE
		      SV_saldo_120_dias := SUBSTR(LS_saldos ,LN_ypos+1, LENGTH(LS_saldos)-LN_ypos+1);
         END IF;
         /* FIN COL|40470|11/05/2007|SAQL */

		END IF;


		-- Obtiene estatus suspendido
		IF (GV_cod_situacion = 'SAA') OR (GV_cod_situacion = 'STP') THEN
			SV_cod_suspendido := 'S';
		ELSE
			SV_cod_suspendido := 'N';
		END IF;

		-- Obitene valor último pago y fecha
		BEGIN
		-- Inicio modificacion by SAQL/Soporte 07/08/2006 - CO-200607280277
		--LV_sSql:=' SELECT  pag.imp_pago, TO_DATE(pag.fec_efectividad,' || 'DD-MM-YYYY' || ') ' ||
		LV_sSql:=' SELECT  pag.imp_pago, TRUNC(PAG.FEC_EFECTIVIDAD) ' ||
		-- Fin modificacion by SAQL/Soporte 07/08/2006 - CO-200607280277
		         ' FROM co_pagos pag ' ||
		         -- Inicio modificacion by SAQL/Soporte 07/08/2006 - CO-200607280277
		         -- ' WHERE pag.fec_efectividad IN (SELECT  MAX(fec_efectividad) ' ||
		         ' WHERE pag.num_compago IN (SELECT  MAX(num_compago) ' ||
		         -- Fin modificacion by SAQL/Soporte 07/08/2006 - CO-200607280277
			     '				                  FROM co_pagos ' ||
			     '                               WHERE cod_tipdocum = '|| CN_8 ||
			     '					              AND cod_cliente = '|| GN_cod_cliente || ') ' ||
		         ' AND PAG.COD_TIPDOCUM = '|| CN_8 ||
		         ' AND PAG.COD_CLIENTE  = ' || GN_cod_cliente;


				-- Inicio modificacion by SAQL/Soporte 11/01/2006 - RA-200511170139
				-- SELECT pag.imp_pago, TO_DATE(pag.fec_efectividad, 'DD-MM-YYYY')
				SELECT PAG.IMP_PAGO, TRUNC(PAG.FEC_EFECTIVIDAD)
				-- Fin modificacion by SAQL/Soporte 11/01/2006 - RA-200511170139
				INTO   SV_valor_ult_pago, SV_fecha_ult_pago
				FROM   CO_PAGOS pag
				-- Inicio modificacion by SAQL/Soporte 07/08/2006 - CO-200607280277
				--WHERE  pag.fec_efectividad IN (SELECT MAX(fec_efectividad)
				WHERE  pag.num_compago IN (SELECT MAX(num_compago)
				-- Fin modificacion by SAQL/Soporte 07/08/2006 - CO-200607280277
					  				           FROM   CO_PAGOS
									           WHERE  cod_tipdocum = CN_8
										       AND 	  cod_cliente  = GN_cod_cliente)
				AND pag.cod_tipdocum = CN_8
			    AND pag.cod_cliente  = GN_cod_cliente;

			EXCEPTION
				WHEN NO_DATA_FOUND THEN
			      SV_valor_ult_pago:= 0;
				  SV_fecha_ult_pago :='';
		END;

		--Obtiene fecha limite de pago
		BEGIN
			LV_sSql:=' SELECT  TO_DATE(MAX(fec_vencimie), ' || 'DD-MM-YYYY' || ') ' ||
  			         ' FROM co_cartera ' ||
			         ' WHERE cod_cliente = ' || GN_cod_cliente ||
		             ' AND cod_tipdocum IN (1,2,8) ';


			-- Inicio modificacion by SAQL/Soporte 11/01/2006 - RA-200511170139
			-- SELECT  TO_DATE(MAX(co.fec_vencimie), 'DD-MM-YYYY')
			SELECT TRUNC(MAX(CO.FEC_VENCIMIE))
			-- Fin modificacion by SAQL/Soporte 11/01/2006 - RA-200511170139
			INTO 	SV_fecha_limite_pago
			FROM 	CO_CARTERA co
			WHERE 	co.cod_cliente = GN_cod_cliente
		    AND 	co.cod_tipdocum IN (CN_1, CN_2, CN_8);

			EXCEPTION
				WHEN NO_DATA_FOUND THEN
			    	SV_fecha_limite_pago :='';
		END;

		-- Obtiene situación de cobranza
		IF SV_estado_servicio IS NULL THEN
		   SV_estado_servicio := 'A';  -- No hay acciones de cobranza aplicadas
		END IF;

	  --  Obtiene fecha corte
	  	BEGIN
			LV_sSql:=' SELECT TO_DATE(cicl.fec_hastallam, ' || 'DD-MM-YYYY' || ') ' ||
				     ' FROM fa_ciclfact cicl '||
				     ' WHERE cicl.cod_ciclfact IN (SELECT MAX(cod_ciclfact) ' ||
				     '                             FROM fa_ciclfact ' ||
				     '                             WHERE cod_ciclo = '||GN_cod_ciclo || ' ) '  ||
				     ' AND cicl.cod_ciclo = ' || GN_cod_ciclo;

		    -- Inicio modificacion by SAQL/Soporte 11/01/2006 - RA-200511170139
		    -- SELECT TO_DATE(cicl.fec_hastallam, 'DD-MM-YYYY')
		    -- RA-200603090892 Inicio PBR
		    --SELECT TRUNC(CICL.FEC_HASTALLAM)
		    SELECT TO_DATE(TO_char(cicl.fec_hastallam, 'YYYYMMDD'),'YYYYMMDD')
		    --Fin PBR
		    -- Fin modificacion by SAQL/Soporte 11/01/2006 - RA-200511170139
			INTO   SV_fecha_corte
			FROM   FA_CICLFACT cicl
			-- Inicio PBR
			--WHERE  cicl.cod_ciclfact IN (SELECT MAX(cod_ciclfact)
			--	  				         FROM   FA_CICLFACT
			--					         WHERE  cod_ciclo = GN_cod_ciclo)
			WHERE SYSDATE BETWEEN fec_desdellam AND fec_hastallam
			-- RA-200603090892 Fin PBR
			AND    cicl.cod_ciclo = GN_cod_ciclo;

	  	EXCEPTION
			WHEN NO_DATA_FOUND THEN
			   	SV_fecha_corte :='';
		END;

	    -- Obtiene tasacion
	    LV_sSql:=' SELECT COUNT(1) ' ||
	             ' FROM ci_reg_atencion_clientes ' ||
	             ' WHERE ' ||
	             ' fec_inicio BETWEEN TO_DATE(SYSDATE ' || '00:00:00 ,DD-MM-YYYY HH24:MI:SS' || ' ) ' ||
	             ' AND TO_DATE(SYSDATE ' || '23:59:59 ,DD-MM-YYYY HH24:MI:SS' || ' ) ' ||
	             ' AND num_abonado  = ' || SN_num_abonado  ||
	             ' AND cod_atencion = 502';

	    SELECT COUNT(1)
	    /* Inicio modificacion by SAQL/Soporte 07/10/2006 - 34683 */
	    /* INTO SN_cont_tasación */
	    INTO SN_cont_tasacion
            /* Inicio modificacion by SAQL/Soporte 07/10/2006 - 34683 */
	    FROM CI_REG_ATENCION_CLIENTES
	    -- Inicio RA-200603090892 PBR
	    --WHERE fec_inicio BETWEEN TO_DATE(SYSDATE || ' 00:00:00','DD-MM-YYYY HH24:MI:SS')
	    --AND TO_DATE(SYSDATE ||' 23:59:59', 'DD-MM-YYYY HH24:MI:SS')
	    WHERE trunc(fec_inicio) = trunc(sysdate)
	    -- Fin RA-200603090892 PBR
	    AND NUM_ABONADO  = SN_num_abonado
	    AND cod_atencion = 502;


		-- Obtiene Indicador de servicios (1ra posicion)
		IF GV_cod_tecnologia ='CDMA' THEN
		   SV_ind_servicios :='0';
	    ELSE
			IF GV_cod_tecnologia ='TDMA' THEN
			   SV_ind_servicios :='1';
			ELSE
			   IF GV_cod_tecnologia ='GSM' THEN
			   	   SV_ind_servicios :='2';
			   END IF;
			END IF;
		END IF;

	    LV_sSql:=' SELECT COUNT(1) ' ||
		         ' FROM ga_servsupl ' ||
		         ' WHERE cod_servicio IN (SELECT cod_servicio ' ||
		         '                FROM gad_servsup_plan ' ||
			     '                WHERE tip_relacion IN (1,4) ' ||
			     '                AND cod_plantarif= ' || SV_cod_plantarif || ')';

	    -- Obtiene Indicador de servicios (2da posicion)
		SELECT COUNT(1)
		INTO LN_cont
		FROM GA_SERVSUPL
		WHERE cod_producto = GN_cod_producto and --- RRG
		cod_servicio IN (SELECT cod_servicio
		                	   FROM GAD_SERVSUP_PLAN
				               WHERE tip_relacion IN (1,4)
				      		   AND cod_plantarif= SV_cod_plantarif);

	    IF LN_cont = 0 THEN
			SV_ind_servicios :=SV_ind_servicios || '0';
		ELSE
			SV_ind_servicios :=SV_ind_servicios || '1';
		END IF;

		-- Obtiene Indicador de servicios (3ra posicion) fija
		SV_ind_servicios :=SV_ind_servicios || '0';

		-- Obtiene Indicador de servicios (4ta posicion)  - Rescate tipo de tasación Minuto o Segundo
		LV_sSql:=' SELECT tip_unitas '||
		         ' FROM ta_plantarif ' ||
		         ' WHERE cod_plantarif = ' || SV_cod_plantarif ;

		SELECT tip_unitas
		INTO LV_plantarif
		FROM TA_PLANTARIF
		WHERE cod_plantarif = SV_cod_plantarif;

		IF LV_plantarif = 'M' THEN
			 SV_ind_servicios :=SV_ind_servicios || '1';
		ELSE
			IF LV_plantarif = 'S' THEN
			    SV_ind_servicios :=SV_ind_servicios || '0';
			END IF;
		END IF;

		-- Obtiene Indicador de servicios (5ta - 10  posicion)  - fijas
		-- Inicio modificacion by SAQL/Soporte 12/01/2006 - RA-200511170139
		-- SV_ind_servicios :=SV_ind_servicios || '000000';
		SV_ind_servicios := SV_ind_servicios || '00000';
		LV_VAL_PARAMETRO := NULL;
		BEGIN
		   -- SAQL / 34683 - 07/10/2006
		   LV_sSql:=' SELECT VAL_PARAMETRO  '||
		         ' FROM GED_PARAMETROS ' ||
		         ' WHERE NOM_PARAMETRO = SRV_ALTAM_COMV '||
		         ' AND COD_MODULO = ''GA'' AND COD_PRODUCTO = 1 ' ;
		   SELECT VAL_PARAMETRO INTO LV_VAL_PARAMETRO
		   FROM GED_PARAMETROS
		   WHERE NOM_PARAMETRO = 'SRV_ALTAM_COMV'
		   AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1;
		EXCEPTION
		   WHEN NO_DATA_FOUND THEN
		      LV_VAL_PARAMETRO := '0';
		END;
		IF LV_VAL_PARAMETRO NOT IN ('0','1') OR LV_VAL_PARAMETRO IS NULL THEN
		   LV_VAL_PARAMETRO := '1';
		END IF;
		SV_ind_servicios := SV_ind_servicios || LV_VAL_PARAMETRO;
		-- Fin Modificacion by SAQL/Soporte 12/01/2006 - RA-200511170139

		-- Obtiene prefijo extratiempo
		LV_sSql := 'IF NOT ga_extra_tiempo_pg.ga_obtiene_prefijo_fn(LV_PREFIJOX,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO)'; -- SAQL / 34683 - 07-10-2006
		IF NOT ga_extra_tiempo_pg.ga_obtiene_prefijo_fn(LV_PREFIJOX,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
		   LV_sSql := 'IF NOT ga_extra_tiempo_pg.ga_obtiene_prefijo_fn(LV_PREFIJOX,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO)';
		   RAISE error_extratiempo;
		END IF;

		-- Obtiene los 10 primeros planes de extratiempo contratados por el abonado
		LV_sSql := 'IF NOT ga_obtiene_planes_fn'; -- SAQL / 34683 - 07-10-2006
		IF NOT ga_obtiene_planes_fn(SN_num_abonado,SV_PLANX01,SV_PLANX02,SV_PLANX03,SV_PLANX04,SV_PLANX05
		   	   						,SV_PLANX06,SV_PLANX07,SV_PLANX08,SV_PLANX09,SV_PLANX10
									,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO) THEN
		   LV_sSql := 'IF NOT ga_obtiene_planes_fn('||SN_num_abonado||',SV_PLANX01,SV_PLANX02,SV_PLANX03,SV_PLANX04,SV_PLANX05'
		   	   		  ||',SV_PLANX06,SV_PLANX07,SV_PLANX08,SV_PLANX09,SV_PLANX10'
					  ||',SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO)';
		   RAISE error_extratiempo;
		END IF;

		-- Obtiene planes de Extratiempo
		LV_sSql := 'OPEN c_planes_extratiempos;' ; -- SAQL / 34683 - 07-10-2006
		OPEN c_planes_extratiempos;

		LOOP
			FETCH c_planes_extratiempos INTO LV_COD_PLAN;
			EXIT WHEN c_planes_extratiempos%NOTFOUND;

			-- Obtiene valores de minutos de extratiempo y bolsa --
			LV_sSql := 'ga_extra_tiempo_pg.ga_extratiempo_consulta_pr'; -- SAQL / 34683 - 07-10-2006
			ga_extra_tiempo_pg.ga_extratiempo_consulta_pr(EN_NUM_CELULAR,
		   	   												 LV_COD_PLAN,
															 FALSE,--Indicador de registro en SAC
															 LN_VAL_MINTOTAL,
															 LN_VAL_USADO,
															 LN_VAL_DISPONIBLE,
															 LN_USADO_BOLSA,
															 LN_DISPONIBLE_BOLSA,
															 SN_COD_RETORNO,
															 SV_MENS_RETORNO,
															 SN_NUM_EVENTO
															 );

			IF SN_COD_RETORNO != 0 THEN
			   LV_sSql := 'ga_extra_tiempo_pg.ga_extratiempo_consulta_pr(EN_NUM_CELULAR,'
		   	   			||LV_COD_PLAN||','
						||'TRUE,'
						||'LN_VAL_MINTOTAL,'
						||'LN_VAL_USADO,'
						||'LN_VAL_DISPONIBLE,'
						||'LN_USADO_BOLSA,'
						||'LN_DISPONIBLE_BOLSA,'
						||'SN_COD_RETORNO,'
						||'SV_MENS_RETORNO,'
						||'SN_NUM_EVENTO)';
			   RAISE error_extratiempo;
			END IF;

			SN_VAL_MINTOTAL     := SN_VAL_MINTOTAL     + LN_VAL_MINTOTAL;
			SN_VAL_USADO        := SN_VAL_USADO        + LN_VAL_USADO;
			SN_VAL_DISPONIBLE   := SN_VAL_DISPONIBLE   + LN_VAL_DISPONIBLE;


		END LOOP;

		CLOSE c_planes_extratiempos;

		SN_USADO_BOLSA      := LN_USADO_BOLSA;
		SN_DISPONIBLE_BOLSA := LN_DISPONIBLE_BOLSA;


EXCEPTION

	    WHEN NO_DATA_FOUND THEN
	 	  SN_cod_retorno := 149;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
  	      LV_des_error := 'ga_consulta_segmentacion_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_cliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );

        WHEN error_parametros THEN
     	  SN_cod_retorno := 98;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_segmentacion_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_segmentacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

        WHEN error_ejecucion THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_segmentacion_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_segmentacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

        WHEN error_extratiempo THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_segmentacion_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_segmentacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	    WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_segmentacion_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno,CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_segmentacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_segmentacion_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_nomcliente_pr (
		  						EN_num_celular	    IN NUMBER,
								SV_nom_cliente		OUT NOCOPY VARCHAR2,
								SN_cod_retorno		OUT NOCOPY NUMBER,
								SV_mens_retorno		OUT NOCOPY VARCHAR2,
								SN_num_evento   	OUT NOCOPY NUMBER
		  					   )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_NOMCLIENTE_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar Nombre del Cliente del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_nom_cliente"     Tipo="CARACTER>Nombre completo del cliente</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion	 EXCEPTION;
LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;
LN_cod_atencion     NUMBER(3);

BEGIN
	    SN_cod_retorno  := 0;
        SV_mens_retorno := '';
		SN_num_evento   := 0;
		LN_cod_atencion := 523;
		-- Se cambia gv_cod_tecnología por gv_cod_tecnologia RA-200511170139 PBR 10/01/2006
		IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
					                                   GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                       GN_cod_producto, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			RAISE error_ejecucion;
		ELSE
		    SV_nom_cliente := GV_nom_abocli;
		END IF;

	    ga_reg_atencion_cliente_pr(EN_num_celular, LN_cod_atencion, CV_mens_atendio, CV_nom_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
		IF SN_cod_retorno <> 0 THEN
		    RAISE error_ejecucion;
		END IF;

EXCEPTION
     WHEN error_ejecucion THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_nomcliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_nomcliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_consulta_nomcliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_nomcliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error    := 'ga_consulta_nomcliente_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_nomcliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_nomcliente_pr;

----------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_consulta_fonocontacto_pr (
		  						EN_num_celular	    IN NUMBER,
								SV_fono_contacto	OUT NOCOPY VARCHAR2,
								SN_cod_retorno		OUT NOCOPY NUMBER,
								SV_mens_retorno		OUT NOCOPY VARCHAR2,
								SN_num_evento   	OUT NOCOPY NUMBER
		  					   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_FONOCONTACTO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar fono de contacto del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_fono_contacto"   Tipo="CARACTER>Teléfono de contacto</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion	 EXCEPTION;
LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;
LN_cod_atencion     NUMBER(3);

BEGIN
  		SN_cod_retorno 	:= 0;
        SV_mens_retorno := '';
		SN_num_evento 	:= 0;
		LN_cod_atencion	:= 524;
		-- Se cambia gv_cod_tecnología por gv_cod_tecnologia RA-200511170139 PBR 10/01/2006
		IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                       GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
                                                       GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			RAISE error_ejecucion;
		ELSE
		    SV_fono_contacto := GN_fono_contacto;
		END IF;

	    ga_reg_atencion_cliente_pr
	   						(EN_num_celular, LN_cod_atencion, CV_mens_atendio,
							 CV_nom_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
		IF SN_cod_retorno <> 0 THEN
		    RAISE error_ejecucion;
		END IF;

EXCEPTION
     WHEN error_ejecucion THEN
		  LV_des_error := 'GA_CONSULTA_FONOCONTACTO_PR('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_fonocontacto_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_consulta_fonocontacto_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_fonocontacto_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error    := 'ga_consulta_fonocontacto_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_fonocontacto_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_fonocontacto_pr;

----------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_consulta_numabonado_pr (
		  						EN_num_celular	    IN NUMBER,
								SN_num_abonado		OUT NOCOPY NUMBER,
								SN_cod_retorno		OUT NOCOPY NUMBER,
								SV_mens_retorno		OUT NOCOPY VARCHAR2,
								SN_num_evento   	OUT NOCOPY NUMBER
		  					   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_NUMABONADO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar número de abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SN_num_abonado"   Tipo="NUMERICO>Secuencia nro del abonado</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion	 EXCEPTION;
LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;
LN_cod_atencion     NUMBER(3);

BEGIN
  		SN_cod_retorno  := 0;
        SV_mens_retorno := '';
		SN_num_evento   := 0;
		-- Se cambia gv_cod_tecnología por gv_cod_tecnologia RA-200511170139 PBR 10/01/2006
		IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                       GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado, GN_cod_producto,
					                                   GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			RAISE error_ejecucion;
		ELSE
		    SN_num_abonado := GN_num_abonado;
		END IF;

EXCEPTION
     WHEN error_ejecucion THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'GA_CONSULTA_NUMABONADO_PR('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_numabonado_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_consulta_numabonado_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_numabonado_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_numabonado_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_numabonado_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_numabonado_pr;

----------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_consulta_tipoplan_pr (
		  						EN_num_celular	    IN NUMBER,
								SV_tip_plantarif	OUT NOCOPY VARCHAR2,
								SN_cod_retorno		OUT NOCOPY NUMBER,
								SV_mens_retorno		OUT NOCOPY VARCHAR2,
								SN_num_evento   	OUT NOCOPY NUMBER
		  					   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_TIPOPLAN_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar tipo de plan del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_tip_plantarif"   Tipo="CARACTER>Tipo de plan tarifario<</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion	 EXCEPTION;
LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;
LN_cod_atencion     NUMBER(3);

BEGIN
  		SN_cod_retorno := 0;
        SV_mens_retorno:= '';
		SN_num_evento  := 0;
		-- Se cambia gv_cod_tecnología por gv_cod_tecnologia RA-200511170139 PBR 10/01/2006
		IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
				                                      GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                      GN_cod_producto, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			RAISE error_ejecucion;
		ELSE
		    SV_tip_plantarif := GV_tip_plantarif;
		END IF;

EXCEPTION
     WHEN error_ejecucion THEN
		  LV_des_error := 'GA_CONSULTA_TIPOPLAN_PR('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_tipoplan_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_consulta_tipoplan_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_tipoplan_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_tipoplan_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_tipoplan_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_tipoplan_pr;

----------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_consulta_numcelular_pr	(
		  						EN_num_celular	    IN NUMBER,
								SN_cod_retorno		OUT NOCOPY NUMBER,
								SV_mens_retorno		OUT NOCOPY VARCHAR2,
								SN_num_evento   	OUT NOCOPY NUMBER
		  					   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_NUMCELULAR_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar validez de Numero celular del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion	 EXCEPTION;
LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;
LN_cod_atencion  NUMBER(3);

BEGIN
	    SN_cod_retorno  := 0;
        SV_mens_retorno := '';
		SN_num_evento   := 0;
		LN_cod_atencion := 521;
		-- Se cambia gv_cod_tecnología por gv_cod_tecnologia RA-200511170139 PBR 10/01/2006
		IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente,GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
					                                   GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                       GN_cod_producto, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			RAISE error_ejecucion;
		END IF;

	    ga_reg_atencion_cliente_pr(EN_num_celular, LN_cod_atencion, CV_mens_atendio, CV_nom_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
		IF SN_cod_retorno <> 0 THEN
		    RAISE error_ejecucion;
		END IF;

EXCEPTION
     WHEN error_ejecucion THEN
		  LV_des_error := 'ga_consulta_numcelular_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_numcelular_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_consulta_numcelular_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_numcelular_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_numcelular_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_numcelular_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_numcelular_pr;

----------------------------------------------------------------------------------------------------------------------

PROCEDURE ga_consulta_responsable_pr(
		  						EN_num_celular	    IN NUMBER,
								SV_responsable		OUT NOCOPY VARCHAR2,
								SN_cod_retorno		OUT NOCOPY NUMBER,
								SV_mens_retorno		OUT NOCOPY VARCHAR2,
								SN_num_evento   	OUT NOCOPY NUMBER
		  					   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_RESPONSABLE_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar responsable del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_responsable"     Tipo="CARACTER>Nombre del responsable<</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion	 EXCEPTION;
LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;
LN_cod_atencion     NUMBER(3);

BEGIN
  		SN_cod_retorno  := 0;
        SV_mens_retorno := '';
		SN_num_evento 	:= 0;
		-- Se cambia gv_cod_tecnología por gv_cod_tecnologia RA-200511170139 PBR 10/01/2006
		IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
					                                   GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                       GN_cod_producto, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			RAISE error_ejecucion;
		ELSE
		    SV_responsable := GV_nom_responsable;
		END IF;

EXCEPTION
     WHEN error_ejecucion THEN
		  LV_des_error := 'GA_CONSULTA_RESPONSABLE_PR('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_responsable_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_consulta_responsable_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_responsable_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error := 'ga_consulta_responsable_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_responsable_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_responsable_pr;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_consulta_producto_pr(
		                        EN_num_celular	    IN NUMBER,
								SV_des_producto		OUT NOCOPY VARCHAR2,
								SN_cod_retorno		OUT NOCOPY NUMBER,
								SV_mens_retorno		OUT NOCOPY VARCHAR2,
								SN_num_evento   	OUT NOCOPY NUMBER
							   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_CONSULTA_PRODUCTO_PR".
      Lenguaje="PL/SQL"
      Fecha="01-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar Descripción del producto del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
			<param nom="SV_des_producto"    Tipo="CARACTER>Descripción del Producto; Pospago - Prepago - Hibrido<</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
error_ejecucion	 EXCEPTION;
LV_des_error 	 ge_errores_pg.DesEvent;
LV_sSql        	 ge_errores_pg.vQuery;
LV_nom_tabla	 GED_CODIGOS.nom_tabla%TYPE  :='CI_TIPORSERV';
LV_nom_columna	 GED_CODIGOS.nom_columna%TYPE:='IND_ORSERV';
LN_cod_atencion     NUMBER(3);

BEGIN
  		SN_cod_retorno  := 0;
        SV_mens_retorno := '';
		SN_num_evento 	:= 0;
		LN_cod_atencion :=515;
		-- Se cambia gv_cod_tecnología por gv_cod_tecnologia RA-200511170139 PBR 10/01/2006
		IF NOT Ga_Segmentacion_Pg.ga_origen_cliente_fn(EN_num_celular, GN_num_abonado, GN_cod_cliente, GV_nom_abocli, GV_cod_situacion, GN_cod_cuenta, GV_cod_clave, GV_tip_plantarif, GV_cod_plantarif, GV_cod_tecnologia, GV_cod_perfil,
                                                       GN_cod_ciclo, GN_fono_contacto, GV_num_serie, GV_num_imei, GV_num_min_mdn, GV_num_min, GV_num_seriehex, GV_num_seriemec, GV_tip_terminal, GV_tip_abonado, GV_cod_estado,
                                                       GN_cod_producto, GV_nom_responsable, GV_des_plantarif, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
			RAISE error_ejecucion;
		END IF;

		LV_sSql := 'SELECT SUBSTR(DES_VALOR,1,20) '||
				'INTO   SV_des_producto 	   '||
				'FROM   ged_codigos   		   '||
				'WHERE  cod_modulo  = '|| CV_cod_modulo  ||' '||
				'AND    cod_valor   = '|| GV_tip_abonado ||' '||
				'AND    nom_tabla   = '|| LV_nom_tabla   ||' '||
				'AND    nom_columna = '|| LV_nom_columna;

		SELECT SUBSTR(DES_VALOR,1,20)
		INTO   SV_des_producto
		FROM   GED_CODIGOS
		WHERE  cod_modulo  = CV_cod_modulo
		AND    cod_valor   = GV_tip_abonado
		AND    nom_tabla   = LV_nom_tabla
		AND    nom_columna = LV_nom_columna;

	    ga_reg_atencion_cliente_pr
	   						(EN_num_celular, LN_cod_atencion, CV_mens_atendio,
							 CV_nom_usuario, SN_cod_retorno , SV_mens_retorno, SN_num_evento );
		IF SN_cod_retorno <> 0 THEN
		    RAISE error_ejecucion;
		END IF;

EXCEPTION
     WHEN error_ejecucion THEN
		  LV_des_error    := 'ga_consulta_producto_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_producto_pr', LV_sSql, SN_cod_retorno, LV_des_error );

	 WHEN VALUE_ERROR THEN
	 	  SN_cod_retorno := 303;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
	      LV_des_error	 :='ga_consulta_producto_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_producto_pr', LV_sSql, SN_cod_retorno, LV_des_error );

     WHEN OTHERS THEN
	 	  SN_cod_retorno := 302;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          	     SV_mens_retorno := CV_error_no_clasif;
      	  END IF;
		  LV_des_error    := 'ga_consulta_producto_pr('||EN_num_celular||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_segmentacion_pg.ga_consulta_producto_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END ga_consulta_producto_pr;
----------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_ejecuta_restriccion_pr(
									EV_cod_modulo    IN VARCHAR2,
									EN_cod_producto  IN NUMBER,
									EV_cod_actuacion IN VARCHAR2,
									EV_num_evento    IN VARCHAR2,
									EV_param_entrada IN VARCHAR2,
									SN_cod_retorno  OUT NOCOPY NUMBER,
						  			SV_mens_retorno OUT NOCOPY VARCHAR2,
						 			SN_num_evento   OUT NOCOPY NUMBER
								   )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_PR_EJECUTA_RESTRICCION"
      Lenguaje="PL/SQL"
      Fecha="02-06-2005"
      Versión="1.0"
      Diseñador=""Ricardo Roco"
      Programador="Diego Mejías Z."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción>Procedimiento que permite retornar los atributos mas comunmente consultados del abonado COL_05001_CRM</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_modulo"     Tipo="CARACTER">Cosdigo del Modulo</param>
			<param nom="EN_cod_producto"   Tipo="CARACTER">Codigo del Producto</param>
			<param nom="EV_cod_actuacion"  Tipo="CARACTER">Codigo de actuacion</param>
			<param nom="EV_num_evento"     Tipo="CARACTER">Numero de Evento</param>
			<param nom="EV_param_entrada"  Tipo="CARACTER">Parametros de Entrada</param>
         </Entrada>
         <Salida>
            ram>
            <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

     LV_num_restriccion   PV_ACTUAC_RESTRICCION.num_restriccion%TYPE;
     LV_tip_rutina        PV_RESTRICCIONES.tip_rutina%TYPE:='';
     LV_nom_rutina        PV_RESTRICCIONES.nom_rutina%TYPE:='';
	 LV_cod_operadora	  PV_ACTUAC_RESTRICCION.cod_operadora%TYPE:= Ge_Fn_Operadora_Scl();

     LV_param_salida      VARCHAR2(2000) := '';
     LV_param_entrada_cte VARCHAR2(2000) := '';
     LV_param_ok          VARCHAR(5)	 := '';
	 LN_error_205		  NUMBER(3)		 := 205;

	 LN_largodesc         CONSTANT NUMBER(3)	:= 100;
	 LV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
	 LV_des_error 		  ge_errores_pg.DesEvent;
	 LV_sSql			  ge_errores_pg.vQuery;

     error_proceso EXCEPTION;
	 salida_ok	   EXCEPTION;

     CURSOR C_ACTREST IS
     SELECT restr.num_restriccion
     FROM   PV_ACTUAC_RESTRICCION restr
     WHERE  restr.cod_operadora   = LV_cod_operadora
     AND    restr.cod_modulo      = EV_cod_modulo
     AND    restr.cod_producto    = EN_cod_producto
     AND    restr.cod_actuacion   = EV_cod_actuacion
     AND    restr.cod_evento      = EV_num_evento
     AND    restr.flg_estado      = 'TRUE'
     ORDER BY restr.ind_orden ASC;
BEGIN

  		SN_cod_retorno  := 0;
        SV_mens_retorno := '';
		SN_num_evento 	:= 0;

     OPEN C_ACTREST;
     LOOP
         FETCH C_ACTREST INTO LV_num_restriccion;
         EXIT WHEN C_ACTREST%NOTFOUND;

		 LV_sSql := 'SELECT tip_rutina, nom_rutina '||
         	  	 'INTO   LV_tip_rutina, LV_nom1_rutina '||
		         'FROM   pv_restricciones '||
		         'WHERE  cod_modulo      = '||EV_cod_modulo ||
		         'AND    cod_producto    = '||EN_cod_producto ||
		         'AND    num_restriccion = '||LV_num_restriccion ;

         SELECT restr.tip_rutina, restr.nom_rutina
         INTO   LV_tip_rutina, LV_nom_rutina
         FROM   PV_RESTRICCIONES restr
         WHERE  restr.cod_modulo      = EV_cod_modulo
         AND    restr.cod_producto    = EN_cod_producto
         AND    restr.num_restriccion = LV_num_restriccion;

		 IF SQLCODE <> 0 THEN
            RAISE error_proceso;
         END IF;

		 begin

--       Llama a la otra rutina diferenciando Funcion, PL sin parametros y PL con parametros
         IF LV_tip_rutina = 'FC' THEN
            LV_sSql:='SELECT '||LV_nom_rutina||'('||EV_param_entrada||') FROM dual';
            EXECUTE IMMEDIATE LV_sSql INTO LV_param_salida;

         ELSIF LV_tip_rutina = 'PL' THEN


               IF TRIM(EV_param_entrada) = '' OR EV_param_entrada IS NULL THEN
                  LV_param_entrada_cte := ':LV_param_ok,:LV_param_salida';
				  LV_sSql:= 'BEGIN ' || LV_nom_rutina||'('|| LV_param_entrada_cte ||'); END;';
                  EXECUTE IMMEDIATE LV_sSql USING OUT LV_param_ok, OUT LV_param_salida;
               ELSE --con 1 parametro compuesto entrada y uno compuesto salida
                  LV_param_entrada_cte := ':EV_param_entrada,:LV_param_ok,:LV_param_salida';
				  LV_sSql:= 'BEGIN ' || LV_nom_rutina ||'('|| LV_param_entrada_cte ||'); END;';
				  --EXECUTE IMMEDIATE LV_sSql USING IN EV_param_entrada, OUT LV_param_ok, OUT LV_param_salida;
               END IF;



         ELSE
            RAISE error_proceso;
         END IF;

		 exception when others then
		 		   LV_des_error := SQLERRM;
			   			 RAISE error_proceso;
		 end;

         IF LV_param_ok = 'FALSE' THEN
            RAISE error_proceso;
         END IF;

     END LOOP;


EXCEPTION
WHEN error_proceso THEN
	 SN_cod_retorno := 321;
	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
     	SV_mens_retorno := LV_error_no_clasif;
     END IF;
  	 LV_des_error	:= SUBSTR(SV_mens_retorno,1,LN_largodesc);
     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, EV_cod_modulo, SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_pr_ejecuta_restriccion', LV_sSql, SQLCODE, LV_des_error );

END ga_ejecuta_restriccion_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_responsable_cuenta_pr (EN_cod_cliente    IN         GE_CLIENTES.cod_cliente%TYPE,
	                              SV_cod_tipident     OUT NOCOPY GA_CUENTAS.cod_tipident%TYPE,
	                              SV_num_ident        OUT NOCOPY GA_CUENTAS.num_ident%TYPE,
	                              SV_nom_responsable  OUT NOCOPY GA_CUENTAS.nom_responsable%TYPE,
								  SV_obs_direccion    OUT NOCOPY GE_DIRECCIONES.obs_direccion%TYPE,
								  SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
                                  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ga_responsable_cuenta_pr"
      Lenguaje="PL/SQL"
      Fecha="09-08-2005"
      Versión="1.0"
      Diseñador=""Fernando Garcia E."
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Servicio capa de negocio que retorna el responsable de una cuenta</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente" Tipo="NUMERICO">Código del cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_tipident" Tipo="CARACTER">Tipo de identificación</param>
            <param nom="SV_num_ident" Tipo="CARACTER">Nro de identificación</param>
            <param nom="SV_nom_responsable" Tipo="CARACTER">Nombre del responsable</param>
            <param nom="SV_obs_direccion Tipo="CARACTER">Observación de dirección del responsable</param>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Nro de evento </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

        error_ejecucion      EXCEPTION;
		error_tipo_cuenta	 EXCEPTION;
		LV_des_error		 	 ge_errores_pg.DesEvent;
        sSql             	 ge_errores_pg.vQuery;
		SV_deserror 		 ge_errores_pg.DesEvent;
   		LN_cod_cuenta        GE_CLIENTES.cod_cuenta%TYPE;
   		LN_cod_direccion     GA_CUENTAS.cod_direccion%TYPE;
		LN_cod_categoria	 GE_CLIENTES.cod_categoria%TYPE;
		LV_cod_tipident		 GE_CLIENTES.cod_tipident%TYPE;
		LV_num_ident		 GE_CLIENTES.num_ident%TYPE;
		LV_des_tipident		 GE_TIPIDENT.des_tipident%TYPE;
		LV_tip_cuenta		 GA_CUENTAS.tip_cuenta%TYPE;

    BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
		SV_mens_retorno:=NULL;
		SV_cod_tipident:=NULL;
		SV_num_ident:=NULL;
		SV_nom_responsable:=NULL;
		SV_obs_direccion:=NULL;
		LN_cod_cuenta:=NULL;
		LN_cod_direccion:=NULL;
		LN_cod_categoria:=NULL;
		LV_cod_tipident:=NULL;
		LV_num_ident:=NULL;
		LV_des_tipident:=NULL;
		LV_tip_cuenta:=NULL;

		--Validar si existe el cliente...
		sSql:='GA_VALIDA_CLIENTE_FN('||EN_cod_cliente||','||CV_comportamiento||')';
	    IF NOT GA_VALIDA_CLIENTE_FN(EN_cod_cliente,CV_comportamiento,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
    	   RAISE error_ejecucion;
		END IF;

        --Obtener cuenta del cliente....
		sSql:='GA_CONSULTAS_PG.GA_CONSULTA_CLIENTE_PR('||EN_cod_cliente||')';
    	Ga_Consultas_Pg.GA_CONSULTA_CLIENTE_PR(EN_cod_cliente,LN_cod_cuenta,LN_cod_categoria,
    			LV_cod_tipident,LV_num_ident,LV_des_tipident,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    	IF SN_cod_retorno<>0 THEN
       	   RAISE  error_ejecucion;
   		END IF;

		--Obtener datos del responsable de la cuenta...
		sSql:='GA_CONSULTAS_PG.GA_CONSULTA_CUENTA_PR('||LN_cod_cuenta||')';
	    Ga_Consultas_Pg.GA_CONSULTA_CUENTA_PR(LN_cod_cuenta,SV_cod_tipident,SV_num_ident,
		       SV_nom_responsable,LN_cod_direccion,LV_tip_cuenta,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    	IF SN_cod_retorno<>0 THEN
       	   RAISE  error_ejecucion;
   		END IF;

        --Verificar si tipo de la cuenta es válido para el servicio....
		sSql:='GA_VALIDA_CODIGOS_FN('||CV_cod_modulo||','||CV_nom_tabla||','||CV_nom_columna||','||LV_tip_cuenta||')';
		IF NOT GA_VALIDA_CODIGOS_FN(CV_cod_modulo,CV_nom_tabla,
		   	   CV_nom_columna,LV_tip_cuenta,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
       	   RAISE  error_tipo_cuenta;
		END IF;

		--Obtener datos de la dirección....
		sSql:='GA_CONSULTA_DIRECCION_PG.GA_CONSULTA_DIRECCION_PR('||LN_cod_direccion||')';
	    Ga_Consulta_Direccion_Pg.GA_CONSULTA_DIRECCION_PR(LN_cod_direccion,SV_obs_direccion,
		       SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    	IF SN_cod_retorno<>0 THEN
       	   RAISE  error_ejecucion;
   		END IF;

EXCEPTION
WHEN error_ejecucion THEN
		 SV_cod_tipident:=NULL;
		 SV_num_ident:=NULL;
		 SV_nom_responsable:=NULL;
		 SV_obs_direccion:=NULL;
         LV_des_error:='error_ejecucion: ga_responsable_cuenta_pr('||EN_cod_cliente||'); - ' || SQLERRM;
         SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_responsable_cuenta_pr', sSql, SQLCODE, LV_des_error );

WHEN error_tipo_cuenta THEN
		 SV_cod_tipident:=NULL;
		 SV_num_ident:=NULL;
		 SV_nom_responsable:=NULL;
		 SV_obs_direccion:=NULL;
		 SN_cod_retorno:=479;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error:='error_tipo_cuenta: ga_responsable_cuenta_pr('||EN_cod_cliente||'); - ' || SQLERRM;
         SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_responsable_cuenta_pr', sSql, SQLCODE, LV_des_error );

WHEN OTHERS THEN
		 SV_cod_tipident:=NULL;
		 SV_num_ident:=NULL;
		 SV_nom_responsable:=NULL;
		 SV_obs_direccion:=NULL;
         SN_cod_retorno:=156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno:=CV_error_no_clasif;
         END IF;
         LV_des_error:='Others: ga_responsable_cuenta_pr('||EN_cod_cliente||'); - ' || SQLERRM;
         SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version||'.'||CV_subversion, USER, 'ga_responsable_cuenta_pr', sSql, SQLCODE, LV_des_error );
END ga_responsable_cuenta_pr;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_version_fn RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función>
   <Elemento
      Nombre = "GA_VERSION_FN"
      Lenguaje="PL/SQL"
      Fecha="26-12-2004"
      Versión="La del package"
      Diseñador="Carlos Navarro H. - Marcelo Godoy S."
      Programador="Marcelo Godoy S. - Carlos Navarro H."
      Ambiente Desarrollo="BD">
      <Retorno>Versión y subversión del package</Retorno>
      <Descripción>Mostrar versión y subversión del package</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
BEGIN
   RETURN('Version : '||CV_version||' <--> SubVersion : '||CV_subversion);
END;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END Ga_Segmentacion_Pg;
/
SHOW ERRORS
