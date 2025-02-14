CREATE OR REPLACE PACKAGE BODY ve_recuperaparametros_sms_pg IS

/*
<Documentación
  TipoDoc = "Package">
   <Elemento
      Nombre="ve_recuperaparametros_sms_pg"
      Lenguaje="PL/SQL"
      Fecha creación="31-05-2005"
      Creado por="Héctor Pérez Guzmán."
      Fecha modificación=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>package que recupera el valor de un parametro definido en la ged_parametros</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

CV_error_no_clasif  VARCHAR2(50):= 'No es posible clasificar el error';
--------------------------------------------------------------------------------------------------------
FUNCTION ve_recupera_parametros_fn (
        ev_nom_parametro    IN               ged_parametros.nom_parametro%TYPE,
        ev_cod_modulo       IN               ged_parametros.cod_modulo%TYPE,
        en_cod_producto     IN               ged_parametros.cod_producto%TYPE,
        sv_val_parametro    OUT NOCOPY       ged_parametros.val_parametro%TYPE,
        sn_cod_retorno      OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
        sv_mens_retorno     OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
        sn_num_evento       OUT NOCOPY       ge_errores_pg.evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ve_recupera_parametros_fn""
      Lenguaje="PL/SQL"
      Fecha="31-08-2005"
      Versión="1.0"
      Diseñador="Héctor Pérez Guzmán"
      Programador="Héctor Pérez Guzmán"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción></Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_parametro" Tipo="CARACTER">Nombre de parametro </param>
			<param nom="EV_cod_modulo   " Tipo="CARACTER">Codigo de Modulo    </param>
			<param nom="EN_cod_producto " Tipo="NUMERICO">Cod.Producto Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_val_parametro" Tipo="CARACTER">Valor parametro   </param>
            <param nom="SN_cod_retorno  " Tipo="NUMERICO">Codigo de Retorno </param>
            <param nom="SV_mens_retorno " Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento   " Tipo="NUMERICO">Numero de Evento  </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    exception_ErrParam EXCEPTION;
	V_des_error  	   ge_errores_pg.DesEvent;
	LV_sql         	   ge_errores_pg.vQuery;
	LV_nomparametro    ged_parametros.nom_parametro%TYPE;
BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= NULL;

    LV_sql := 'SELECT param.val_parametro';
    LV_sql := LV_sql || ' INTO EV_val_parametro';
    LV_sql := LV_sql || ' FROM ged_parametros param';
    LV_sql := LV_sql || ' WHERE nom_parametro = '|| EV_nom_parametro;
    LV_sql := LV_sql || ' AND cod_modulo = '|| EV_cod_modulo;
    LV_sql := LV_sql || ' AND cod_producto = '|| EN_cod_producto;

    SELECT param.val_parametro
      INTO SV_val_parametro
      FROM ged_parametros param
     WHERE nom_parametro = EV_nom_parametro
       AND cod_modulo = EV_cod_modulo
       AND cod_producto = EN_cod_producto;

    RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
		SN_cod_retorno := 156;
		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
		    SV_mens_retorno := CV_error_no_clasif;
		END IF;
		V_des_error := 've_recuperaparametros_sms_pg.ve_recupera_parametros_fn('|| EV_nom_parametro||', '||EV_cod_modulo||', '||EN_cod_producto||'); - ' || SQLERRM;
		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, CV_version, USER, 've_recuperaparametros_sms_pg.ve_recupera_parametros_fn', LV_sql, SQLCODE, V_des_error );
		RETURN FALSE;
END ve_recupera_parametros_fn;
--------------------------------------------------------------------------------------------------------
FUNCTION VE_recupera_glosa_FN(
        EV_cod_modulo    IN         ged_codigos.cod_modulo%TYPE,
        EV_nom_tabla     IN         ged_codigos.nom_tabla%TYPE,
        EV_nom_columna   IN         ged_codigos.nom_columna%TYPE,
        SV_des_valor     OUT NOCOPY ged_codigos.des_valor%TYPE,
	    SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
	    SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
	    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
)

RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "VE_obtiene_glosa_exito_FN""
      Lenguaje="PL/SQL"
      Fecha="31-08-2005"
      Versión="1.0"
      Diseñador="Roberto Perez"
      Programador="Roberto Perez"
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene la glosa del mensaje de exito desde ged_codigos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_modulo" Tipo="CARACTER">Codigo del modulo</param>
            <param nom="EV_nom_tabla" Tipo="CARACTER">Nombre de la tabla</param>
            <param nom="EV_nom_columna" Tipo="CARACTER">Nombre de la columna</param>
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
BEGIN
        SN_cod_retorno:=0;
        SN_num_evento:=0;
        SV_mens_retorno:=NULL;
    	SV_des_valor:=NULL;

    	LV_sql:=' SELECT g.des_valor INTO  SV_des_valor '||
    	        '   FROM ged_codigos g '||
    	        '  WHERE g.cod_modulo='||EV_cod_modulo||
    	        '    AND g.nom_tabla='||EV_nom_tabla||
	            '    AND g.nom_columna='||EV_nom_columna;

    	SELECT g.des_valor INTO  SV_des_valor
    	FROM   ged_codigos g
    	WHERE  g.cod_modulo=EV_cod_modulo
    	  AND  g.nom_tabla=EV_nom_tabla
	      AND  g.nom_columna=EV_nom_columna;
    	RETURN TRUE ;

EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error:='ve_recuperaparametros_sms_pg.VE_recupera_glosa_FN() ' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo, SV_mens_retorno, CV_version, USER,'ve_recuperaparametros_sms_pg.VE_recupera_glosa_FN', LV_sql, SQLCODE, LV_des_error );
      RETURN FALSE;
END VE_recupera_glosa_FN;
END ve_recuperaparametros_sms_pg;
/
SHOW ERRORS
