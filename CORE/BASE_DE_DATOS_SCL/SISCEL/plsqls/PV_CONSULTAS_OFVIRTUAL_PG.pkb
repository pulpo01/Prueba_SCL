CREATE OR REPLACE PACKAGE BODY Pv_Consultas_Ofvirtual_Pg
IS

FUNCTION GE_is_number_FN (EV_cadena IN VARCHAR2)RETURN BOOLEAN

/*<Documentación>
  <TipoDoc = "Función"/>
   <Elemento
      Nombre = "GE_is_number_FN"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>Boolean</Retorno>
      <Descripción>Valida que una cadena sea numérica</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cadena" Tipo="VARCHAR2">Cadena a validar</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS
	LN_numero NUMBER;

BEGIN
	LN_numero:=TO_NUMBER(EV_cadena);
	RETURN TRUE;

	EXCEPTION
	WHEN OTHERS THEN
		RETURN FALSE;
END GE_is_number_FN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION GE_is_serie_number_FN (EN_num_serie     IN GA_ABOCEL.NUM_SERIE%TYPE,
			    		  	    SN_cod_retorno  OUT NOCOPY   ge_errores_pg.CodError,
			    		  		SV_mens_retorno OUT NOCOPY  ge_errores_pg.MsgError,
			    		  		SN_num_evento   OUT NOCOPY  ge_errores_pg.Evento)RETURN BOOLEAN
/*
<Documentación>
  <TipoDoc = "Función"/>
   <Elemento
      Nombre = "GE_is_serie_number_FN "
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>Boolean</Retorno>
      <Descripción>Valida que un número de serie sea un número puro</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_serie" Tipo="CARACTER">Numero de serie a validar</param>
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
AS
	serie_no_es_numero EXCEPTION;

	sSql ge_errores_pg.vQuery;
   	V_des_error  ge_errores_pg.DesEvent;

BEGIN
		--Inicializar variables...
		SN_cod_retorno:='0';
		SN_num_evento:=0;
		SV_mens_retorno:=NULL;

		sSql:='IS_NUMBER(' || EN_num_serie || ')';
		IF NOT GE_IS_NUMBER_FN(EN_num_serie) THEN
		   RAISE serie_no_es_numero;
		END IF;

		RETURN TRUE;

EXCEPTION
	WHEN serie_no_es_numero THEN
		 SN_cod_retorno := '300121';
   		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
       		SV_mens_retorno := CV_error_no_clasif;
   		 END IF;
   		 V_des_error := SUBSTR('IS_SERIE_NUMBER(...); - ' || SQLERRM,1,CN_largoerrtec);
  		 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
   		 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'IS_SERIE_NUMBER', sSql, SQLCODE, V_des_error );
		 RETURN FALSE;
END GE_is_serie_number_FN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION GE_get_parametro_FN (EV_nombre_par 	IN ged_parametros.nom_parametro%TYPE,
		 			   		  EV_cod_modulo IN ged_parametros.cod_modulo%TYPE,
							  EN_cod_producto IN ged_parametros.cod_producto%TYPE,
							  SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                        	  SV_mens_retorno     OUT  NOCOPY  ge_errores_pg.MsgError,
							  SN_num_evento       OUT  NOCOPY  ge_errores_pg.Evento
                        	  ) RETURN ged_parametros.val_parametro%TYPE/*VARCHAR2(20)*/
/*
<Documentación>
  <TipoDoc = "Función"/>
   <Elemento
      Nombre = "GE_get_parametro_FN"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>ged_parametros.val_parametro</Retorno>
      <Descripción>Devuelve el valor de un parametro dado su nombre</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nombre_par" Tipo="CARACTER">Nombre del parametro cuyo valor sera devuelto</param>
            <param nom="EV_cod_modulo" Tipo="CARACTER">Codigo del modulo</param>
            <param nom="EN_cod_producto" Tipo="CARACTER">Codigo del producto</param>
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
AS
	sSql ge_errores_pg.vQuery;
	V_des_error  ge_errores_pg.DesEvent;

	LV_valor_par ged_parametros.val_parametro%TYPE:=NULL;

	BEGIN

		sSql:='SELECT val_parametro ' ||
			'INTO LV_valor_par ' ||
			'FROM ged_parametros ' ||
			'WHERE nom_parametro=' || EV_nombre_par || 'AND' ||
			'cod_modulo=' || EV_cod_modulo || 'AND' ||
			'cod_producto=' || EN_cod_producto;

		SELECT val_parametro
		INTO LV_valor_par
		FROM ged_parametros
		WHERE nom_parametro=EV_nombre_par
		AND cod_modulo=EV_cod_modulo
		AND	cod_producto=EN_cod_producto;

		RETURN LV_valor_par;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			SN_cod_retorno := '302';
      		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          		SV_mens_retorno := CV_error_no_clasif;
      		END IF;
      		V_des_error := SUBSTR('GET_PARAMETRO(...); - ' || SQLERRM,1,CN_largoerrtec);
  	  		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'GET_PARAMETRO', sSql, SQLCODE, V_des_error );
			RETURN NULL;
		WHEN OTHERS THEN
      		SN_cod_retorno := '302';
      		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          		SV_mens_retorno := CV_error_no_clasif;
	      	END IF;
      		V_des_error := SUBSTR('GET_PARAMETRO(...); - ' || SQLERRM,1,CN_largoerrtec);
			SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'GET_PARAMETRO', sSql, SQLCODE, V_des_error );
      		RETURN NULL;

END GE_get_parametro_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION GE_valida_existe_cliente_FN (EN_cod_cliente   IN			 ge_clientes.cod_cliente%TYPE,
   		 							  SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
   									  SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
   									  SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "ge_valida_existe_cliente_fn"
      Lenguaje="PL/SQL"
      Fecha="28-04-2005"
      Versión="1.0"
      Diseñador="Fernando Garcia"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Validar si existe un cliente prepago.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_cliente"       Tipo="NUMERICO">Codigo de cliente. Retorna NULL si no existe/param>
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
        V_des_error     ge_errores_pg.DesEvent;
        sSql            ge_errores_pg.vQuery;

		CV_ind_alta 	CONSTANT ge_clientes.ind_alta%TYPE := 'M';
		LN_cod_cliente  ge_clientes.cod_cliente%TYPE;

BEGIN
   	    --Inicializar variables
		SN_cod_retorno := '0';
        SN_num_evento  := 0;
		LN_cod_cliente:=NULL;

        sSql:='SELECT cod_cliente FROM ge_clientes '||
	          ' WHERE cod_cliente='||EN_cod_cliente;

        SELECT cod_cliente INTO LN_cod_cliente
	    FROM ge_clientes
	    WHERE cod_cliente=EN_cod_cliente;


		RETURN  TRUE;

EXCEPTION
WHEN  NO_DATA_FOUND THEN
      SN_cod_retorno := '226';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('others: ge_valida_existe_cliente_fn('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_existe_cliente_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;

WHEN  OTHERS   THEN
      SN_cod_retorno := '302';
      IF NOT  Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasIF;
      END  IF;
      V_des_error := SUBSTR('others: ge_valida_existe_cliente_fn('||EN_cod_cliente||'); - ' || SQLERRM,1,CN_largoerrtec);
	  SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GE_VALIDACIONES_PG.ge_valida_existe_cliente_fn', sSql, SQLCODE, V_des_error );
      RETURN  FALSE;
END  ge_valida_existe_cliente_fn;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_cons_tipo_contrato_PR (EN_num_celular         IN  ga_abocel.num_celular%TYPE,
				    			    SV_cod_tipo_contrato  OUT  NOCOPY   ga_abocel.cod_tipcontrato%TYPE,
				    				SV_desc_tipo_contrato OUT  NOCOPY   ga_tipcontrato.des_tipcontrato%TYPE,
				    				SN_cod_retorno        OUT  NOCOPY   ge_errores_pg.CodError,
                              	    SV_mens_retorno       OUT  NOCOPY   ge_errores_pg.MsgError,
				    				SN_num_evento         OUT  NOCOPY   ge_errores_pg.Evento
                             		)
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_CONS_TIPO_CONTRATO_PR"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para obtener información sobre tipos de contrato</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_cod_tipo_contrato"     Tipo="Caracter">Codigo de contrato</param>
            <param nom="SV_desc_tipo_contrato"     Tipo="Caracter">Descripcion del contrato</param>
            <param nom="SN_cod_retorno"    Tipo="CARACTER">Codigo de retorno</param>
            <param nom="SV_mens_retorno"    Tipo="ge_errores_pg.Evento">Mensaje de retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

    error_abonado       EXCEPTION;
    celular_nulo        EXCEPTION;

   	sSql ge_errores_pg.vQuery;
   	V_des_error  ge_errores_pg.DesEvent;

    CV_mens_retorno_ok CONSTANT GE_ERRORES_TD.DET_MSGERROR%TYPE :='Transacción ejecutada correctamente';

BEGIN
	--Inicializar variables...
  	sSql:=NULL;
	SN_cod_retorno:='0';
	SN_num_evento:=0;
    SV_mens_retorno:=' ';

	IF TRIM(EN_num_celular) IS NULL THEN
  	   RAISE celular_nulo;
	END IF;

    -- Validar si numero celular existe asociado al cliente y datos del abonado
	Pv_Consultas_Ofvirtual_Pg.PV_datos_abonado_PR(EN_num_celular,LR_DatAbonado,LV_tabla_abo,SN_cod_retorno);

    IF SN_cod_retorno<>0 THEN
	   RAISE error_abonado;
	END IF;

	sSql:='SELECT b.cod_tipcontrato, b.des_tipcontrato '||
	' INTO SV_cod_tipo_contrato, SV_desc_tipo_contrato '||
	' FROM ga_tipcontrato b '||
   	' WHERE a.cod_tipcontrato = ' || LR_DatAbonado.cod_tipcontrato;

	SELECT b.cod_tipcontrato, b.des_tipcontrato
    INTO SV_cod_tipo_contrato, SV_desc_tipo_contrato
    FROM ga_tipcontrato b
    WHERE b.cod_tipcontrato = LR_DatAbonado.cod_tipcontrato;

    SV_mens_retorno:=CV_mens_retorno_ok;
	IF SN_cod_retorno IS NULL THEN
	   SN_cod_retorno := 0;
	END IF;
	IF SN_num_evento IS NOT NULL THEN
       SN_num_evento := '';
	END IF;


EXCEPTION

   	WHEN celular_nulo THEN
      	 SN_cod_retorno := '142';
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_CONS_TIPO_CONTRATO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
      	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

	WHEN error_abonado THEN
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_CONS_TIPO_CONTRATO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
      	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

   	WHEN NO_DATA_FOUND THEN
      	 SN_cod_retorno := '546';
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_CONS_TIPO_CONTRATO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
      	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

	WHEN OTHERS THEN
   		SN_cod_retorno := '302';
    	IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      		SV_mens_retorno := CV_error_no_clasif;
    	END IF;
    	V_des_error := SUBSTR('PV_CONS_TIPO_CONTRATO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
    	SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	    IF SN_num_evento IS NULL THEN
       	   SN_num_evento := 0;
	 	END IF;
    	SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

END PV_CONS_TIPO_CONTRATO_PR;

-------------------------------------------------------------------------------------------------------

PROCEDURE PV_antiguedad_serie_PR (EN_num_celular       IN     ga_abocel.num_celular%TYPE,
				    			  SV_fecha_serie      OUT    NOCOPY   VARCHAR2,
				    			  SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                    			  SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
				    			  SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             )
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_ANTIGUEDAD_SERIE_PR"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para obtener información sobre antiguedad de la serie</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SV_fecha_serie"     Tipo="Date">Fecha de la serie</param>
            <param nom="SN_cod_retorno"    Tipo="CARACTER">Codigo de retorno</param>
            <param nom="SV_mens_retorno"    Tipo="ge_errores_pg.Evento">Mensaje de retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   error_abonado       EXCEPTION;
   celular_nulo        EXCEPTION;

   sSql ge_errores_pg.vQuery;
   V_des_error  ge_errores_pg.DesEvent;
   /* Constantes */
   CV_mens_retorno_ok CONSTANT GE_ERRORES_TD.DET_MSGERROR%TYPE :='Transacción ejecutada correctamente';
   /* Variables */
   LN_num_abonado ga_abocel.num_abonado%TYPE;/*OUT*/
   LN_num_abonado_aux ga_abocel.num_abonado%TYPE;/*OUT*/
   LN_num_abonado_ant ga_abocel.num_abonado%TYPE;/*OUT*/
   LV_num_serie ga_abocel.num_serie%TYPE;
   LV_num_serie_aux ga_abocel.num_serie%TYPE;
   LD_fecha_alta DATE;
   LD_fecha_alta_aux DATE;
   LV_formato_fecha ged_parametros.val_parametro%TYPE;

BEGIN
	--Inicializar variables...
	SV_fecha_serie:=NULL;
  	sSql:=NULL;
	SN_cod_retorno:='0';
	SN_num_evento:=0;
    SV_mens_retorno:=' ';
	LD_fecha_alta:=NULL;
	LD_fecha_alta_aux:=NULL;
	LV_num_serie:=NULL;
	LV_num_serie_aux:=NULL;
	LN_num_abonado:=NULL;
	LN_num_abonado_aux:=NULL;
	LN_num_abonado_ant:=NULL;
	LV_formato_fecha:=NULL;


	IF TRIM(EN_num_celular) IS NULL THEN
  	   RAISE celular_nulo;
	END IF;

    -- Validar si numero celular existe asociado al cliente y datos del abonado
	Pv_Consultas_Ofvirtual_Pg.PV_datos_abonado_PR(EN_num_celular,LR_DatAbonado,LV_tabla_abo,SN_cod_retorno);

    IF SN_cod_retorno<>0 THEN
	   RAISE error_abonado;
	END IF;

	-- Obtengo la serie del abonado y el nro de abonado activo (debiera coincidir con el anterior servicio)
	sSql:='SELECT DECODE(cod_tecnologia, ''GSM'', num_imei, num_serie), num_abonado ' ||
		'INTO LV_num_serie, SN_num_abonado ' ||
		'FROM ga_abocel ' ||
		'WHERE num_abonado=' || LR_DatAbonado.num_abonado ||
		'AND cod_situacion NOT IN(''BAA'',''BAP'') ' ||
		'UNION ' ||
		'SELECT DECODE(cod_tecnologia, ''GSM'', num_imei, num_serie), num_abonado ' ||
		'FROM ga_aboamist ' ||
		'WHERE num_abonado=' || LR_DatAbonado.num_abonado ||
		'AND cod_situacion NOT IN(''BAA'',''BAP'')';

	SELECT DECODE(cod_tecnologia, 'GSM', num_imei, num_serie), num_abonado
	  INTO LV_num_serie, LN_num_abonado
	  FROM ga_abocel
	 WHERE num_abonado=LR_DatAbonado.num_abonado
	   AND cod_situacion NOT IN('BAA','BAP')
	UNION
	SELECT DECODE(cod_tecnologia, 'GSM', num_imei, num_serie), num_abonado
	  FROM ga_aboamist
	 WHERE num_abonado=LR_DatAbonado.num_abonado
	   AND cod_situacion NOT IN('BAA','BAP');

	LN_num_abonado_aux:=LN_num_abonado;

	LOOP

		BEGIN
			SELECT num_abonado, num_abonadoant
			INTO LN_num_abonado_aux, LN_num_abonado_ant
			FROM ga_traspabo
			WHERE  num_abonado=LN_num_abonado_aux
			AND num_abonado<>num_abonadoant;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				EXIT;

		END;

		sSql:='SELECT b.fec_alta, a.num_serie ' ||
		   'INTO SD_fecha_serie ' ||
		   'FROM ga_abocel a, ga_equipaboser b ' ||
		   'WHERE a.num_abonado=' || LN_num_abonado_aux  ||
		   'AND a.cod_situacion NOT IN (''BAA'', ''BAP'') ' ||
		   'AND a.num_abonado=b.num_abonado ' ||
		   'AND a.num_serie=b.num_serie ' ||
		   'AND b.fec_alta in (SELECT MAX(fec_alta) ' ||
		   	   			  	 		 'FROM ga_equipaboser c ' ||
									 'WHERE c.num_abonado=a.num_abonado ' ||
									 'AND c.num_serie=a.num_serie) ' ||
			'UNION ' ||
			'SELECT b.fec_alta, a.num_serie ' ||
		   'FROM ga_aboamist a, ga_equipaboser b ' ||
		   'WHERE a.num_abonado=' || LN_num_abonado_aux ||
		   'AND a.cod_situacion NOT IN (''BAA'', ''BAP'') ' ||
		   'AND a.num_abonado=b.num_abonado ' ||
		   'AND a.num_serie=b.num_serie ' ||
		   'AND b.fec_alta in (SELECT MAX(fec_alta) ' ||
		   	   			  	 		 'FROM ga_equipaboser c ' ||
									 'WHERE c.num_abonado=a.num_abonado ' ||
									 'AND c.num_serie=a.num_serie)';

		SELECT b.fec_alta, a.num_serie
	   	INTO LD_fecha_alta, LV_num_serie_aux
	   	FROM ga_abocel a, ga_equipaboser b
	   	WHERE a.num_abonado=LN_num_abonado_aux
	   	AND a.cod_situacion NOT IN ('BAA', 'BAP')
	   	AND a.num_abonado=b.num_abonado
	   	AND a.num_serie=b.num_serie
	   	AND b.fec_alta IN (SELECT MAX(fec_alta)
	   	   			  	 		 FROM ga_equipaboser c
								 WHERE c.num_abonado=a.num_abonado
								 AND c.num_serie=a.num_serie)
		UNION
		SELECT b.fec_alta, a.num_serie
	   	FROM ga_aboamist a, ga_equipaboser b
	   	WHERE a.num_abonado=LN_num_abonado_aux
	   	AND a.cod_situacion NOT IN ('BAA', 'BAP')
	   	AND a.num_abonado=b.num_abonado
	   	AND a.num_serie=b.num_serie
	   	AND b.fec_alta IN (SELECT MAX(fec_alta)
	   	   			  	 		 FROM ga_equipaboser c
								 WHERE c.num_abonado=a.num_abonado
								 AND c.num_serie=a.num_serie);

		IF LV_num_serie_aux=LV_num_serie THEN
			LD_fecha_alta_aux:=LD_fecha_alta;
		ELSE
			EXIT;
		END IF;

		LN_num_abonado_aux:=LN_num_abonado_ant;

	END LOOP;

	--Si la fecha alta auxiliar es nula, no encontré fechas en los traspasos,con lo q ejecuto el query para el abonado original
	IF LD_fecha_alta_aux IS NULL THEN
		sSql:='SELECT b.fec_alta ' ||
		   'INTO LD_fecha_alta_aux ' ||
		   'FROM ga_abocel a, ga_equipaboser b ' ||
		   'WHERE a.num_abonado=' || LN_num_abonado  ||
		   'AND a.cod_situacion NOT IN (''BAA'', ''BAP'') ' ||
		   'AND a.num_abonado=b.num_abonado ' ||
		   'AND a.num_serie=b.num_serie ' ||
		   'AND b.fec_alta in (SELECT MAX(fec_alta) ' ||
		   	   			  	 		 'FROM ga_equipaboser c ' ||
									 'WHERE c.num_abonado=a.num_abonado ' ||
									 'AND c.num_serie=a.num_serie) ' ||
			'UNION ' ||
			'SELECT b.fec_alta ' ||
		   'FROM ga_aboamist a, ga_equipaboser b ' ||
		   'WHERE a.num_abonado=' || LN_num_abonado ||
		   'AND a.cod_situacion NOT IN (''BAA'', ''BAP'') ' ||
		   'AND a.num_abonado=b.num_abonado ' ||
		   'AND a.num_serie=b.num_serie ' ||
		   'AND b.fec_alta in (SELECT MAX(fec_alta) ' ||
		   	   			  	 		 'FROM ga_equipaboser c ' ||
									 'WHERE c.num_abonado=a.num_abonado ' ||
									 'AND c.num_serie=a.num_serie)';

		SELECT b.fec_alta
		   INTO LD_fecha_alta_aux
		   FROM ga_abocel a, ga_equipaboser b
		   WHERE a.num_abonado=LN_num_abonado
		   AND a.cod_situacion NOT IN ('BAA', 'BAP')
		   AND a.num_abonado=b.num_abonado
		   AND a.num_serie=b.num_serie
		   AND b.fec_alta IN (SELECT MAX(fec_alta)
		   	   			  	 		 FROM ga_equipaboser c
									 WHERE c.num_abonado=a.num_abonado
									 AND c.num_serie=a.num_serie)
			UNION
			SELECT b.fec_alta
		   FROM ga_aboamist a, ga_equipaboser b
		   WHERE a.num_abonado=LN_num_abonado
		   AND a.cod_situacion NOT IN ('BAA', 'BAP')
		   AND a.num_abonado=b.num_abonado
		   AND a.num_serie=b.num_serie
		   AND b.fec_alta IN (SELECT MAX(fec_alta)
		   	   			  	 		 FROM ga_equipaboser c
									 WHERE c.num_abonado=a.num_abonado
									 AND c.num_serie=a.num_serie);
	END IF;

	--Convierto a caracter la fecha (obtengo el formato de la tabla)
	sSql:='GET_PARAMETRO(' || LV_formato_sel2 || ', ' || CV_cod_modulo_al || ', ' || CV_cod_producto || ')';
        LV_formato_fecha:=GE_GET_PARAMETRO_FN(LV_formato_sel2,
        			     CV_cod_modulo_ge,
        			     CV_cod_producto,
        			     SN_cod_retorno,
        			     SV_mens_retorno,
        			     SN_num_evento);
        IF LV_formato_fecha IS NULL
        	THEN
        		RAISE NO_DATA_FOUND;
        END IF;

	SV_fecha_serie:=TO_CHAR(LD_fecha_alta_aux, LV_formato_fecha);

    SV_mens_retorno:=CV_mens_retorno_ok;
	IF SN_cod_retorno IS NULL THEN
	   SN_cod_retorno := 0;
	END IF;
	IF SN_num_evento IS NOT NULL THEN
       SN_num_evento := '';
	END IF;


EXCEPTION

   	WHEN celular_nulo THEN
      	 SN_cod_retorno := '142';
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_CONS_TIPO_CONTRATO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
      	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

   	WHEN error_abonado THEN
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_ANTIGUEDAD_SERIE_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
      	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

	WHEN OTHERS THEN
   		SN_cod_retorno := '302';
   		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
     		SV_mens_retorno := CV_error_no_clasif;
   		END IF;
   		V_des_error := SUBSTR('PV_ANTIGUEDAD_SERIE_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
   		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		IF SN_num_evento IS NULL THEN
   		   SN_num_evento := 0;
 		END IF;
   		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_ANTIGUEDAD_SERIE_PR', sSql, SQLCODE, V_des_error );

END PV_ANTIGUEDAD_SERIE_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_val_form_serie_equipo_PR (EN_num_serie IN GA_ABOCEL.NUM_SERIE%TYPE,
				    				   SN_formato      OUT    NOCOPY  NUMBER,
				    				   SN_cod_retorno      OUT  NOCOPY     ge_errores_pg.CodError,
                    				   SV_mens_retorno     OUT  NOCOPY     ge_errores_pg.MsgError,
				    				   SN_num_evento       OUT  NOCOPY     ge_errores_pg.Evento
                             )
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_VAL_FORM_SERIE_EQUIPO_PR"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para validar el numero de serie del equipo</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_serie" Tipo="NUMERICO">Numero de serie del equipo</param>
         </Entrada>
         <Salida>
            <param nom="SN_formato"     Tipo="Numerico">Indicador de numero de serie de acuerdo a formato</param>
            <param nom="SN_cod_retorno"    Tipo="CARACTER">Codigo de retorno</param>
            <param nom="SV_mens_retorno"    Tipo="ge_errores_pg.Evento">Mensaje de retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    serie_incorrecta   EXCEPTION;
    serie_no_es_numero EXCEPTION;

   	sSql ge_errores_pg.vQuery;
   	V_des_error  ge_errores_pg.DesEvent;

	CC_excep CONSTANT CHAR := '4';
	CC_error CONSTANT CHAR := '1';
	CN_salida_formato_si CONSTANT NUMBER := 0;
	CN_salida_formato_no CONSTANT NUMBER := 1;
    CV_mens_retorno_ok CONSTANT GE_ERRORES_TD.DET_MSGERROR%TYPE :='Transacción ejecutada correctamente';

   	LN_largo_tgsm NUMBER;
	LN_largo_ttdma NUMBER;

	LN_longitud NUMBER;
	LC_error CHAR;

    BEGIN
	--Inicializar variables...
	SN_formato:=CN_salida_formato_si;
  	sSql:=NULL;
	SN_cod_retorno:=0;
	SN_num_evento:=0;
    SV_mens_retorno:=' ';
	LN_largo_tgsm:=0;
	LN_largo_ttdma:=0;

	IF TRIM(EN_num_serie) IS NULL THEN
  	   RAISE serie_incorrecta;
	END IF;

	--Validar si el numero de serie es numero puro
	IF NOT Pv_Consultas_Ofvirtual_Pg.GE_is_serie_number_FN(EN_num_serie,
				 SN_cod_retorno,
				 SV_mens_retorno,
				 SN_num_evento)		THEN
			RAISE serie_no_es_numero;
	END IF;

    LN_longitud:=LENGTH(EN_num_serie);

    sSql:='GET_PARAMETRO(' || LV_largo_tgsm || ', ' || CV_cod_modulo_al || ', ' || CV_cod_producto || ')';
    LN_largo_tgsm:=GE_GET_PARAMETRO_FN(LV_largo_tgsm,
    			     CV_cod_modulo_al,
    			     CV_cod_producto,
    			     SN_cod_retorno,
    			     SV_mens_retorno,
    			     SN_num_evento);


    IF LN_largo_tgsm IS NULL THEN
   	   RAISE NO_DATA_FOUND;
    END IF;

    sSql:='GET_PARAMETRO(' || LV_largo_ttdma || ', ' || CV_cod_modulo_al || ', ' || CV_cod_producto || ')';
    LN_largo_ttdma:=GE_GET_PARAMETRO_FN(LV_largo_ttdma,
    			     CV_cod_modulo_al,
    			     CV_cod_producto,
    			     SN_cod_retorno,
    			     SV_mens_retorno,
    			     SN_num_evento);

    IF LN_largo_ttdma IS NULL 	THEN
    		RAISE NO_DATA_FOUND;
    END IF;

    --Verifico q sea alguno de los 2
    IF LN_longitud <> LN_largo_tgsm AND LN_longitud<>LN_largo_ttdma THEN
	   RAISE serie_incorrecta;
	END IF;

    --Si es TDMA ademas...
   	IF LN_longitud=LN_largo_ttdma THEN
	   P_VALIDA_FORMATO(EN_num_serie, LC_error);
	   IF LC_error = CC_error OR LC_error = CC_excep THEN
	  	  RAISE serie_incorrecta;
	   END IF;
	END IF;

	SN_formato:=CN_salida_formato_si;

    SV_mens_retorno:=CV_mens_retorno_ok;
	IF SN_cod_retorno IS NULL THEN
	   SN_cod_retorno := 0;
	END IF;
	IF SN_num_evento IS NOT NULL THEN
       SN_num_evento := '';
	END IF;


EXCEPTION
	WHEN serie_no_es_numero THEN
		 SN_formato:=CN_salida_formato_no;
		 RETURN;
	WHEN serie_incorrecta THEN
 		SN_cod_retorno := '300121';
      			IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          			SV_mens_retorno := CV_error_no_clasif;
      			END IF;
      		V_des_error := SUBSTR('PV_VAL_FORM_SERIE_EQUIPO_PR' || SQLERRM,1,CN_largoerrtec);
  	  		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
  	  		sSql:='P_VALIDA_FORMATO(' || EN_num_serie || ', ' || LC_error || ')';
 		IF SN_num_evento IS NULL THEN
 		   SN_num_evento := 0;
 		END IF;
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_VAL_FORM_SERIE_EQUIPO_PR', sSql, SQLCODE, V_des_error );
 		SN_formato:=CN_salida_formato_no;

	WHEN NO_DATA_FOUND THEN
			SN_cod_retorno := '302';
      			IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          			SV_mens_retorno := CV_error_no_clasif;
      			END IF;
      			V_des_error := SUBSTR('PV_VAL_FORM_SERIE_EQUIPO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
  	  		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
			IF SN_num_evento IS NULL THEN
			   SN_num_evento := 0;
			END IF;
      			SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_VAL_FORM_SERIE_EQUIPO_PR', sSql, SQLCODE, V_des_error );
     			SN_formato:=CN_salida_formato_no;

	  WHEN OTHERS THEN
      		SN_cod_retorno := '302';
      		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          		SV_mens_retorno := CV_error_no_clasif;
      		END IF;
      		V_des_error := SUBSTR('PV_VAL_FORM_SERIE_EQUIPO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	  	sSql:='P_VALIDA_FORMATO(' || EN_num_serie || ', ' || LC_error || ')';
			IF SN_num_evento IS NULL THEN
			   SN_num_evento := 0;
			END IF;
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_VAL_FORM_SERIE_EQUIPO_PR', sSql, SQLCODE, V_des_error );
     		SN_formato:=CN_salida_formato_no;
END PV_val_form_serie_equipo_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_val_form_serie_simcard_PR (EN_num_serie     IN  GA_ABOCEL.NUM_SERIE%TYPE,
				    				    SN_formato      OUT  NOCOPY   NUMBER,
				    					SN_cod_retorno  OUT  NOCOPY   ge_errores_pg.CodError,
                              	    	SV_mens_retorno OUT  NOCOPY   ge_errores_pg.MsgError,
				    					SN_num_evento   OUT  NOCOPY   ge_errores_pg.Evento
                             			)
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_VAL_FORM_SERIE_SIMCARD_PR"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para validar el numero de serie de la tarjeta simcard</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_serie" Tipo="NUMERICO">Numero de serie de la tarjeta simcard</param>
         </Entrada>
         <Salida>
            <param nom="SN_formato"     Tipo="Numerico">Indicador de numero de serie de acuerdo a formato</param>
            <param nom="SN_cod_retorno"    Tipo="CARACTER">Codigo de retorno</param>
            <param nom="SV_mens_retorno"    Tipo="ge_errores_pg.Evento">Mensaje de retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS

    serie_incorrecta   EXCEPTION;
    serie_no_es_numero EXCEPTION;
   	sSql ge_errores_pg.vQuery;
   	V_des_error  ge_errores_pg.DesEvent;

	CN_salida_formato_si CONSTANT NUMBER := 0;
	CN_salida_formato_no CONSTANT NUMBER := 1;
    CV_mens_retorno_ok CONSTANT GE_ERRORES_TD.DET_MSGERROR%TYPE :='Transacción ejecutada correctamente';

   	LN_largo_ggsm NUMBER;
	LN_longitud NUMBER;

    BEGIN
	--Inicializar variables...
	SN_formato:=CN_salida_formato_si;
  	sSql:=NULL;
	SN_cod_retorno:=0;
	SN_num_evento:=0;
	SV_mens_retorno:=NULL;
	LN_largo_ggsm:=0;

	IF TRIM(EN_num_serie) IS NULL THEN
  	   RAISE serie_incorrecta;
	END IF;


	--Validar si el numero de serie es numero puro
	IF NOT Pv_Consultas_Ofvirtual_Pg.GE_is_serie_number_FN(EN_num_serie,
				 SN_cod_retorno,
				 SV_mens_retorno,
				 SN_num_evento)
	THEN
			RAISE serie_no_es_numero;
	END IF;

    LN_longitud:=LENGTH(EN_num_serie);

    sSql:='GET_PARAMETRO(' || LV_largo_ggsm || ', ' || CV_cod_modulo_al || ', ' || CV_cod_producto || ')';
    LN_largo_ggsm:=GE_GET_PARAMETRO_FN(LV_largo_ggsm,
        			     CV_cod_modulo_al,
        			     CV_cod_producto,
        			     SN_cod_retorno,
        			     SV_mens_retorno,
        			     SN_num_evento);
    IF LN_largo_ggsm IS NULL THEN
 	   RAISE NO_DATA_FOUND;
    END IF;

   	IF LN_longitud <> LN_largo_ggsm THEN
	   RAISE serie_incorrecta;
	END IF;

	SN_formato:=CN_salida_formato_si;

    SV_mens_retorno:=CV_mens_retorno_ok;
	IF SN_cod_retorno IS NULL THEN
	   SN_cod_retorno := 0;
	END IF;
	IF SN_num_evento IS NOT NULL THEN
       SN_num_evento := '';
	END IF;


EXCEPTION
	WHEN serie_no_es_numero
		THEN
			SN_formato:=CN_salida_formato_no;
			RETURN;

	WHEN serie_incorrecta
		THEN
			SN_cod_retorno := '300121';
      			IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          			SV_mens_retorno := CV_error_no_clasif;
      			END IF;
      			V_des_error := SUBSTR('PV_VAL_FORM_SERIE_SIMCARD_PR' || SQLERRM,1,CN_largoerrtec);
  	  		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
  	  		sSql:='LN_longitud_serie<>LN_largo_ggsm';
 		 	IF SN_num_evento IS NULL THEN
		       SN_num_evento := 0;
	 	 	END IF;
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_VAL_FORM_SERIE_SIMCARD_PR', sSql, SQLCODE, V_des_error );
			SN_formato:=CN_salida_formato_no;

	WHEN NO_DATA_FOUND
		 THEN
			SN_cod_retorno := '302';
      			IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          			SV_mens_retorno := CV_error_no_clasif;
      			END IF;
      			V_des_error := SUBSTR('PV_VAL_FORM_SERIE_SIMCARD_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
  	  		SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
      		IF SN_num_evento IS NULL THEN
		       SN_num_evento := 0;
	 	 	END IF;
			SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_VAL_FORM_SERIE_SIMCARD_PR', sSql, SQLCODE, V_des_error );
     		SN_formato:=CN_salida_formato_no;

	  WHEN OTHERS THEN
      		SN_cod_retorno := '302';
      		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          		SV_mens_retorno := CV_error_no_clasif;
      		END IF;
      		V_des_error := SUBSTR('PV_VAL_FORM_SERIE_SIMCARD_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
			SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	  		sSql:='LN_longitud_serie<>LN_largo_ggsm';
      		IF SN_num_evento IS NULL THEN
		    		 SN_num_evento := 0;
	 	 	END IF;
		    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_VAL_FORM_SERIE_SIMCARD_PR', sSql, SQLCODE, V_des_error );
     		SN_formato:=CN_salida_formato_no;
END PV_val_form_serie_simcard_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_cons_deuda_cliente_PR (
		  						   	EN_num_celular       IN ga_abocel.num_celular%TYPE,
				    			    SN_deuda_vencida    OUT NOCOPY  NUMBER,
				    				SN_deuda_no_vencida OUT NOCOPY  NUMBER,
				    				SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
                              	    SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
				    				SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento
                             )
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_CONS_DEUDA_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para consultar la deuda del cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de celular</param>
         </Entrada>
         <Salida>
            <param nom="SN_deuda_vencida"     Tipo="Numerico">Monto de la deuda vencida</param>
            <param nom="SN_deuda_no_vencida"     Tipo="Numerico">Monto de la deuda no vencida</param>
            <param nom="SN_cod_retorno"    Tipo="CARACTER">Codigo de retorno</param>
            <param nom="SV_mens_retorno"    Tipo="ge_errores_pg.Evento">Mensaje de retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
	error_abonado       EXCEPTION;
	celular_nulo        EXCEPTION;

   	sSql ge_errores_pg.vQuery;
   	V_des_error  ge_errores_pg.DesEvent;

    CV_mens_retorno_ok CONSTANT GE_ERRORES_TD.DET_MSGERROR%TYPE :='Transacción ejecutada correctamente';

    BEGIN
	--Inicializar variables...
	SN_deuda_vencida:=0;
	SN_deuda_no_vencida:=0;
  	sSql:=NULL;
	SN_cod_retorno:=0;
	SN_num_evento:=0;
	SV_mens_retorno:=NULL;

	IF TRIM(EN_num_celular) IS NULL THEN
  	   RAISE celular_nulo;
	END IF;

    -- Validar si numero celular existe asociado al cliente y datos del abonado
	Pv_Consultas_Ofvirtual_Pg.PV_datos_abonado_PR(EN_num_celular,LR_DatAbonado,LV_tabla_abo,SN_cod_retorno);

    IF SN_cod_retorno<>0 THEN
	   RAISE error_abonado;
	END IF;


    sSql:='SELECT NVL(SUM(CART.IMPORTE_DEBE - CART.IMPORTE_HABER),0)' ||
		  'INTO SN_deuda_vencida ' ||
  		  'FROM CO_CARTERA CART ' ||
 		  'WHERE CART.COD_CLIENTE=' || LR_DatAbonado.cod_cliente ||
   		  'AND CART.IND_FACTURADO=1 ' ||
   		  'AND CART.FEC_VENCIMIE<TRUNC(SYSDATE) ' ||
   		  'AND NOT EXISTS ( ' ||
   		  'SELECT 1 ' ||
          'FROM CO_CODIGOS CODG ' ||
          'WHERE CODG.NOM_TABLA=''CO_CARTERA'' ' ||
          'AND CODG.NOM_COLUMNA=''COD_TIPDOCUM'''||
          'AND TO_NUMBER(CODG.COD_VALOR) = CART.COD_TIPDOCUM);'
				 ;

        /*SALDO VENCIDO*/
    	SELECT NVL(SUM(CART.IMPORTE_DEBE - CART.IMPORTE_HABER),0)
    	INTO SN_deuda_vencida
      	FROM CO_CARTERA CART
     	WHERE CART.COD_CLIENTE=LR_DatAbonado.cod_cliente
       	AND CART.IND_FACTURADO=1
       	AND CART.FEC_VENCIMIE<TRUNC(SYSDATE)
		AND NOT EXISTS (
			SELECT 1
			  FROM CO_CODIGOS CODG
			 WHERE CODG.NOM_TABLA='CO_CARTERA'
			   AND CODG.NOM_COLUMNA='COD_TIPDOCUM'
			   AND TO_NUMBER(CODG.COD_VALOR) = CART.COD_TIPDOCUM
			   );


	sSql:='SELECT NVL(SUM(CART.IMPORTE_DEBE - CART.IMPORTE_HABER),0) ' ||
    		'INTO SN_deuda_vencida ' ||
      		'FROM CO_CARTERA CART ' ||
     		'WHERE CART.COD_CLIENTE=' || LR_DatAbonado.cod_cliente ||
       		'AND CART.IND_FACTURADO=1 ' ||
       		'AND CART.FEC_VENCIMIE<TRUNC(SYSDATE) ' ||
       		'AND NOT EXISTS ( ' ||
       		'SELECT 1' ||
				 'FROM CO_CODIGOS CODG ' ||
                'WHERE CODG.NOM_TABLA=''CO_CARTERA'' ' ||
                  'AND CODG.NOM_COLUMNA=''COD_TIPDOCUM'')'||
                  'AND TO_NUMBER(CODG.COD_VALOR) = CART.COD_TIPDOCUM);'
								 ;

        -- SALDO NO VENCIDO
	SELECT NVL(SUM(CART.IMPORTE_DEBE - CART.IMPORTE_HABER),0)
	INTO SN_deuda_no_vencida
      	FROM CO_CARTERA CART
     	WHERE CART.COD_CLIENTE=LR_DatAbonado.cod_cliente
       	AND CART.IND_FACTURADO=1
       	AND CART.FEC_VENCIMIE>=TRUNC(SYSDATE)
		AND NOT EXISTS (
			SELECT 1
  			  FROM CO_CODIGOS CODG
             WHERE CODG.NOM_TABLA='CO_CARTERA'
               AND CODG.NOM_COLUMNA='COD_TIPDOCUM'
			   AND TO_NUMBER(CODG.COD_VALOR) = CART.COD_TIPDOCUM);


    SV_mens_retorno:=CV_mens_retorno_ok;
	IF SN_cod_retorno IS NULL THEN
	   SN_cod_retorno := 0;
	END IF;
	IF SN_num_evento IS NOT NULL THEN
       SN_num_evento := '';
	END IF;

EXCEPTION
   	WHEN celular_nulo THEN
      	 SN_cod_retorno := '142';
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_CONS_TIPO_CONTRATO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
      	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

	WHEN error_abonado THEN
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_CONS_TIPO_CONTRATO_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
      	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_TIPO_CONTRATO_PR', sSql, SQLCODE, V_des_error );

  	WHEN OTHERS THEN
      		SN_cod_retorno := '302';
      		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          		SV_mens_retorno := CV_error_no_clasif;
      		END IF;
      		V_des_error := SUBSTR('PV_CONS_DEUDA_CLIENTE_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
			SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	  		sSql:='LN_longitud_serie<>LN_largo_ggsm';
 		 	IF SN_num_evento IS NULL THEN
		       SN_num_evento := 0;
	 	 	END IF;
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_DEUDA_CLIENTE_PR', sSql, SQLCODE, V_des_error );

END PV_cons_deuda_cliente_PR;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_cons_art_bodega_PR (EN_num_serie IN GA_ABOCEL.NUM_SERIE%TYPE,
				    SN_cod_art      OUT    NOCOPY  al_articulos.cod_articulo%TYPE,
				    SV_desc_art      OUT    NOCOPY  al_articulos.des_articulo%TYPE,
				    SV_modelo      OUT    NOCOPY  al_articulos.cod_modelo%TYPE,
				    SV_fabricante      OUT    NOCOPY  al_fabricantes.des_fabricante%TYPE,
				    SV_tecnologia      OUT    NOCOPY  al_tecnologia.des_tecnologia%TYPE,
				    SV_concepto      OUT    NOCOPY  fa_conceptos.des_concepto%TYPE,
				    SN_cod_retorno      OUT    NOCOPY   ge_errores_pg.CodError,
                              	    SV_mens_retorno     OUT    NOCOPY   ge_errores_pg.MsgError,
				    SN_num_evento       OUT    NOCOPY   ge_errores_pg.Evento
                             )
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_CONS_ART_BODEGA_PR"
      Lenguaje="PL/SQL"
      Fecha="14-11-2005"
      Versión="1.0"
      Diseñador="***"
      Programador="Diego Rojo"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Capa de negocio para consultar articulos en bodega</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_serie" Tipo="NUMERICO">Numero de serie del equipo, accesorio, simcard o kit</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_art"     Tipo="Numerico">Codigo del articulo asociado al equipo, accesorio, simcard o kit</param>
            <param nom="SV_desc_art"     Tipo="Caracter">Descripcion del articulo asociado al equipo, accesorio, simcard o kit</param>
            <param nom="SV_modelo"     Tipo="Caracter">Modelo del articulo asociado al equipo, accesorio, simcard o kit</param>
            <param nom="SV_fabricante"     Tipo="Caracter">Fabricante del articulo asociado al equipo, accesorio, simcard o kit</param>
            <param nom="SV_tecnologia"     Tipo="Caracter">Tecnologia del articulo asociado al equipo, accesorio, simcard o kit</param>
            <param nom="SV_concepto"     Tipo="Caracter">Concepto facturable del articulo asociado al equipo, accesorio, simcard o kit</param>
            <param nom="SN_cod_retorno"    Tipo="CARACTER">Codigo de retorno</param>
            <param nom="SV_mens_retorno"    Tipo="ge_errores_pg.Evento">Mensaje de retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
	parametro_no_encontrado EXCEPTION;
	serie_incorrecta EXCEPTION;
	serie_no_es_numero EXCEPTION;

   	sSql ge_errores_pg.vQuery;
   	V_des_error  ge_errores_pg.DesEvent;

    CV_mens_retorno_ok CONSTANT GE_ERRORES_TD.DET_MSGERROR%TYPE :='Transacción ejecutada correctamente';

   	LN_largo_tgsm NUMBER;
	LN_largo_ttdma NUMBER;
	LN_largo_ggsm NUMBER;
	LN_longitud NUMBER;
	LN_formato NUMBER;

    BEGIN
	--Inicializar variables...
  	sSql:=NULL;
	SN_cod_retorno:=0;
	SN_num_evento:=0;
	SV_mens_retorno:=NULL;
	LN_formato:=0;
	LN_largo_tgsm:=0;
	LN_largo_ttdma:=0;
	LN_largo_ggsm:=0;
	LN_longitud:=0;

	IF TRIM(EN_num_serie) IS NULL THEN
  	   RAISE serie_incorrecta;
	END IF;

	--Validar si el numero de serie es numero puro
	IF NOT Pv_Consultas_Ofvirtual_Pg.GE_is_serie_number_FN(EN_num_serie,
				 SN_cod_retorno,
				 SV_mens_retorno,
				 SN_num_evento)
	THEN
			RAISE serie_no_es_numero;
	END IF;

        LN_longitud:=LENGTH(EN_num_serie);

        sSql:='GET_PARAMETRO(' || LV_largo_tgsm || ', ' || CV_cod_modulo_al || ', ' || CV_cod_producto || ')';
        LN_largo_tgsm:=GE_GET_PARAMETRO_FN(LV_largo_tgsm,
        			     CV_cod_modulo_al,
        			     CV_cod_producto,
        			     SN_cod_retorno,
        			     SV_mens_retorno,
        			     SN_num_evento);
        IF LN_largo_tgsm IS NULL
        	THEN
        		RAISE parametro_no_encontrado;
        END IF;

        sSql:='GET_PARAMETRO(' || LV_largo_ttdma || ', ' || CV_cod_modulo_al || ', ' || CV_cod_producto || ')';
        LN_largo_ttdma:=GE_GET_PARAMETRO_FN(LV_largo_ttdma,
        			     CV_cod_modulo_al,
        			     CV_cod_producto,
        			     SN_cod_retorno,
        			     SV_mens_retorno,
        			     SN_num_evento);
        IF LN_largo_ttdma IS NULL
        	THEN
        		RAISE parametro_no_encontrado;
        END IF;

       	IF LN_longitud=LN_largo_tgsm OR LN_longitud=LN_largo_ttdma
       		THEN
       			Pv_Consultas_Ofvirtual_Pg.PV_val_form_serie_equipo_PR (
					             EN_num_serie,
				    		     LN_formato,
				    		     SN_cod_retorno,
                              	 SV_mens_retorno,
				    		     SN_num_evento);
			IF LN_formato=1 THEN
				RAISE serie_incorrecta;
       			END IF;
       	ELSE
	        sSql:='GET_PARAMETRO(' || LV_largo_ggsm || ', ' || CV_cod_modulo_al || ', ' || CV_cod_producto || ')';
	        LN_largo_ggsm:=GE_GET_PARAMETRO_FN(LV_largo_ggsm,
	        			     CV_cod_modulo_al,
	        			     CV_cod_producto,
	        			     SN_cod_retorno,
	        			     SV_mens_retorno,
	        			     SN_num_evento);
	        IF LN_largo_ggsm IS NULL
	        	THEN
	        		RAISE parametro_no_encontrado;
	        END IF;

	        IF LN_longitud=LN_largo_ggsm
       		THEN
       			Pv_Consultas_Ofvirtual_Pg.PV_VAL_FORM_SERIE_SIMCARD_PR (EN_num_serie,
				    		     LN_formato,
				    		     SN_cod_retorno,
                              	    		     SV_mens_retorno,
				    		     SN_num_evento);
			IF LN_formato=1 THEN
				RAISE serie_incorrecta;
       			END IF;
       		END IF;
       	END IF;

	sSql:='SELECT a.cod_articulo, a.des_articulo, a.cod_modelo, ' ||
  		'b.des_fabricante, d.des_tecnologia, e.des_concepto ' ||
  		'INTO SN_cod_art, SV_desc_art, SV_modelo, SV_fabricante, SV_tecnologia, SV_concepto ' ||
  		'from al_series f, al_articulos a, al_fabricantes b, ' ||
   		'al_tipos_terminales c, al_tecnoarticulo_td g, al_tecnologia d, fa_conceptos e ' ||
 		    'where f.num_serie=' || EN_num_serie || ' ' ||
   			'and a.cod_articulo=f.cod_articulo ' ||
   			'and f.cod_articulo = g.cod_articulo ' ||
   			'and a.cod_fabricante=b.cod_fabricante ' ||
   			'and a.cod_producto=c.cod_producto (+)' ||
   			'and a.tip_terminal=c.tip_terminal (+)' ||
   			'and g.cod_tecnologia = d.cod_tecnologia(+)' ||
   			'and a.COD_CONCEPTOART=e.COD_CONCEPTO';

	SELECT a.cod_articulo, a.des_articulo, a.cod_modelo,
  	b.des_fabricante, d.des_tecnologia, e.des_concepto
  	INTO sn_cod_art, sv_desc_art, sv_modelo, sv_fabricante, sv_tecnologia, sv_concepto
  	FROM al_series f, al_articulos a, al_fabricantes b,	al_tipos_terminales c,
		 al_tecnoarticulo_td g, al_tecnologia d, fa_conceptos e
 		    WHERE f.num_serie = EN_num_serie
   			AND a.cod_articulo = f.cod_articulo
			AND f.cod_articulo = g.cod_articulo
   			AND a.cod_fabricante = b.cod_fabricante
   			AND a.cod_producto = c.cod_producto (+)
   			AND a.tip_terminal = c.tip_terminal (+)
			AND g.cod_tecnologia = d.cod_tecnologia (+)
   			AND a.cod_conceptoart = e.cod_concepto;

/* ELIMINAR
	SELECT a.cod_articulo, a.DES_ARTICULO, a.COD_MODELO,
  	b.DES_FABRICANTE, d.DES_TECNOLOGIA, e.DES_CONCEPTO
  	INTO SN_cod_art, SV_desc_art, SV_modelo, SV_fabricante, SV_tecnologia, SV_concepto
  	FROM al_series f, al_articulos a, AL_FABRICANTES b,
   	al_tipos_terminales c, al_tecnoarticulo_td g, al_tecnologia d, fa_conceptos e
 		    WHERE f.num_serie=EN_num_serie
   			AND a.cod_articulo=f.cod_articulo
			AND f.cod_articulo = g.cod_articulo
   			AND a.cod_fabricante=b.cod_fabricante
   			AND a.COD_PRODUCTO=c.cod_producto (+)
   			AND a.TIP_TERMINAL=c.TIP_TERMINAL (+)
			AND g.cod_tecnologia = d.cod_tecnologia(+)
   			AND c.cod_tecnologia=d.cod_tecnologia (+)
   			AND a.COD_CONCEPTOART=e.COD_CONCEPTO;*/

    SV_mens_retorno := CV_mens_retorno_ok;
	IF SN_cod_retorno IS NULL THEN
	   SN_cod_retorno := 0;
	END IF;
	IF SN_num_evento IS NOT NULL THEN
       SN_num_evento := '';
	END IF;

EXCEPTION
	WHEN serie_no_es_numero THEN
		RETURN;

	WHEN serie_incorrecta THEN
		 SN_cod_retorno := '300121';
   		 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
       		SV_mens_retorno := CV_error_no_clasif;
   		 END IF;
   		 V_des_error := SUBSTR('PV_VAL_FORM_SERIE_EQUIPO_PR' || SQLERRM,1,CN_largoerrtec);
  		 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
   		 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_VAL_FORM_SERIE_EQUIPO_PR', sSql, SQLCODE, V_des_error );

	WHEN parametro_no_encontrado THEN
		 SN_cod_retorno := '302';
      	 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         	SV_mens_retorno := CV_error_no_clasif;
      	 END IF;
      	 V_des_error := SUBSTR('PV_CONS_ART_BODEGA_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
  	  	 SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 IF SN_num_evento IS NULL THEN
		    SN_num_evento := 0;
	 	 END IF;
      	 SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_ART_BODEGA_PR', sSql, SQLCODE, V_des_error );

	WHEN NO_DATA_FOUND THEN
		SN_cod_retorno := '107'; /*la serie no existe*/
      		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          		SV_mens_retorno := CV_error_no_clasif;
      		END IF;
      		V_des_error := SUBSTR('PV_CONS_ART_BODEGA_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
			SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
 		 	IF SN_num_evento IS NULL THEN
		    	  SN_num_evento := 0;
	 	 	END IF;
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_ART_BODEGA_PR', sSql, SQLCODE, V_des_error );

  	WHEN OTHERS THEN
      		SN_cod_retorno := '302';
      		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          		SV_mens_retorno := CV_error_no_clasif;
      		END IF;
      		V_des_error := SUBSTR('PV_CONS_ART_BODEGA_PR(...); - ' || SQLERRM,1,CN_largoerrtec);
			SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
	  		sSql:='LN_longitud_serie<>LN_largo_ggsm';
 		 	IF SN_num_evento IS NULL THEN
		       SN_num_evento := 0;
	 	 	END IF;
      		SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_pv,SV_mens_retorno, '1.0', USER, 'PV_CONS_ART_BODEGA_PR', sSql, SQLCODE, V_des_error );

END PV_CONS_ART_BODEGA_PR;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_datos_abonado_PR(
	   EN_num_celular      IN  ga_abocel.num_celular%TYPE,
	   SR_ABONADO 		   OUT NOCOPY GA_ABOCEL%ROWTYPE,
	   SV_tabla_abo		   OUT NOCOPY VARCHAR2,
	   SN_cod_retorno      OUT NOCOPY ge_errores_td.Cod_MsgError%TYPE
	   )
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "PV_DATOS_ABONADO_PR"
      Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recuperar datos del Abonado a partir del celular</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SR_abonado"      Tipo="Numerico">Registro con los datos del abonado</param>
			<param nom="SV_tabla_abo"    Tipo="Caracter">Nombre de la tabla donde se encuentra el Celular</param>
            <param nom="SN_cod_retorno"  Tipo="CARACTER">Codigo de retorno</param>
            <param nom="SV_mens_retorno" Tipo="ge_errores_pg.Evento">Mensaje de retorno</param>
            <param nom="SN_num_evento"   Tipo="ge_errores_pg.Evento">Numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/


AS

error_abonado       EXCEPTION;
LV_mensaje			VARCHAR2(250);

BEGIN

	SN_cod_retorno:='302';
	LV_mensaje:=NULL;

	BEGIN

		SELECT NUM_ABONADO, NUM_CELULAR, COD_PRODUCTO, COD_CLIENTE, COD_CUENTA,
		COD_SUBCUENTA, COD_USUARIO, COD_REGION, COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL, COD_USO,
		COD_SITUACION, IND_PROCALTA, IND_PROCEQUI, COD_VENDEDOR, COD_VENDEDOR_AGENTE, TIP_PLANTARIF,
		TIP_TERMINAL, COD_PLANTARIF, COD_CARGOBASICO, COD_PLANSERV, COD_LIMCONSUMO, NUM_SERIE, NUM_SERIEHEX,
		NOM_USUARORA, FEC_ALTA, NUM_PERCONTRATO, COD_ESTADO, NUM_SERIEMEC, COD_HOLDING, COD_EMPRESA,
		COD_GRPSERV, IND_SUPERTEL, NUM_TELEFIJA, COD_OPREDFIJA, COD_CARRIER, IND_PREPAGO, IND_PLEXSYS,
		COD_CENTRAL_PLEX, NUM_CELULAR_PLEX, NUM_VENTA, COD_MODVENTA, COD_TIPCONTRATO, NUM_CONTRATO,
		NUM_ANEXO, FEC_CUMPLAN, COD_CREDMOR, COD_CREDCON, COD_CICLO, IND_FACTUR, IND_SUSPEN, IND_REHABI,
		IND_INSGUIAS, FEC_FINCONTRA, FEC_RECDOCUM, FEC_CUMPLIMEN, FEC_ACEPVENTA, FEC_ACTCEN, FEC_BAJA,
		FEC_BAJACEN, FEC_ULTMOD, COD_CAUSABAJA, NUM_PERSONAL, IND_SEGURO, CLASE_SERVICIO, PERFIL_ABONADO,
		NUM_MIN, COD_VENDEALER, IND_DISP, COD_PASSWORD, IND_PASSWORD, COD_AFINIDAD, FEC_PRORROGA,
		IND_EQPRESTADO, FLG_CONTDIGI, FEC_ALTANTRAS, COD_INDEMNIZACION, NUM_IMEI, COD_TECNOLOGIA,
		NUM_MIN_MDN, FEC_ACTIVACION, IND_TELEFONO, COD_OFICINA_PRINCIPAL, COD_CAUSA_VENTA, COD_OPERACION,
        COD_PRESTACION,MTO_VALOR_REFERENCIA,COD_MONEDA,TIPO_PRIMARIACARRIER,OBS_INSTANCIA        
        INTO  SR_ABONADO
		FROM ga_abocel
		WHERE num_celular = EN_num_celular
		AND cod_situacion NOT IN ('BAA','BAP');

		SV_tabla_abo:= 'GA_ABOCEL';
		SN_cod_retorno:=0;

		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				BEGIN
					SELECT NUM_ABONADO, NUM_CELULAR, COD_PRODUCTO, COD_CLIENTE, COD_CUENTA,
					COD_SUBCUENTA, COD_USUARIO, COD_REGION, COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL, COD_USO,
					COD_SITUACION, IND_PROCALTA, IND_PROCEQUI, COD_VENDEDOR, COD_VENDEDOR_AGENTE, TIP_PLANTARIF,
					TIP_TERMINAL, COD_PLANTARIF, COD_CARGOBASICO, COD_PLANSERV, COD_LIMCONSUMO, NUM_SERIE, NUM_SERIEHEX,
					NOM_USUARORA, FEC_ALTA, NUM_PERCONTRATO, COD_ESTADO, NUM_SERIEMEC, COD_HOLDING, COD_EMPRESA,
					COD_GRPSERV, IND_SUPERTEL, NUM_TELEFIJA, COD_OPREDFIJA, COD_CARRIER, IND_PREPAGO, IND_PLEXSYS,
					COD_CENTRAL_PLEX, NUM_CELULAR_PLEX, NUM_VENTA, COD_MODVENTA, COD_TIPCONTRATO, NUM_CONTRATO,
					NUM_ANEXO, FEC_CUMPLAN, COD_CREDMOR, COD_CREDCON, COD_CICLO, IND_FACTUR, IND_SUSPEN, IND_REHABI,
					IND_INSGUIAS, FEC_FINCONTRA, FEC_RECDOCUM, FEC_CUMPLIMEN, FEC_ACEPVENTA, FEC_ACTCEN, FEC_BAJA,
					FEC_BAJACEN, FEC_ULTMOD, COD_CAUSABAJA, NUM_PERSONAL, IND_SEGURO, CLASE_SERVICIO, PERFIL_ABONADO,
					NUM_MIN, COD_VENDEALER, IND_DISP, COD_PASSWORD, IND_PASSWORD, COD_AFINIDAD, NULL,
					NULL, NULL, NULL, NULL, NUM_IMEI, COD_TECNOLOGIA,
					NUM_MIN_MDN, FEC_ACTIVACION, IND_TELEFONO, COD_OFICINA_PRINCIPAL, COD_CAUSA_VENTA, COD_OPERACION,
                    COD_PRESTACION,NULL, NULL, NULL, NULL   
					INTO  SR_ABONADO
					FROM ga_aboamist
					WHERE num_celular = EN_num_celular
					AND cod_situacion NOT IN ('BAA','BAP');

					SV_tabla_abo:= 'GA_ABOAMIST';
					SN_cod_retorno:=0;

					EXCEPTION
						WHEN NO_DATA_FOUND THEN
							BEGIN
									SELECT num_abonado
									INTO SR_ABONADO.num_abonado
									FROM ga_abocel
									WHERE num_celular = EN_num_celular
									AND cod_situacion IN ('BAA','BAP')
									AND ROWNUM=1
									UNION
									SELECT num_abonado
									FROM ga_aboamist
									WHERE num_celular = EN_num_celular
									AND cod_situacion IN ('BAA','BAP')
									AND ROWNUM=1;

									SN_cod_retorno:= 146;
							EXCEPTION
								WHEN NO_DATA_FOUND THEN
									 SN_cod_retorno:= 147;
								END;
				END;

	END;

EXCEPTION
  	WHEN OTHERS THEN
		 LV_mensaje:=SQLERRM;
      	 SN_cod_retorno := '302';


END PV_datos_abonado_PR;

----------------------------------------------------------------------------
PROCEDURE PV_bodega_vendedor_PR(
	   	  		  			EN_CodVendedor		IN  ve_vendedores.cod_vendedor%TYPE,
							EN_CodBodega		IN  al_bodegas.cod_bodega%TYPE,
							EV_Cod_operadora	IN  ge_clientes.cod_operadora%TYPE,
							SN_cod_retorno      OUT NOCOPY ge_errores_td.Cod_MsgError%TYPE )
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "pv_bodega_vendedor_pr"
      Lenguaje="PL/SQL"
      Fecha="21-11-2005"
      Versión="1.0"
      Diseñador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Consulta bodega del vendedor.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_CodVendedor" Tipo="NUMERO">Código de vendedor.</param>
           <param nom="EN_CodBodega" Tipo="NUMERO">Código de bodega.</param>
		   <param nom="EV_Cod_operadora" Tipo="CARACTER">Código de operadora.</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMERO">Código retorno error</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS
BEGIN
	 SELECT  0 INTO SN_cod_retorno
	 FROM VE_VENDALMAC A, AL_BODEGAS B,
	      AL_BODEGANODO C, GE_OPERADORA_SCL D
	 WHERE SYSDATE BETWEEN A.FEC_ASIGNACION AND NVL(A.FEC_DESASIGNAC,SYSDATE)
	 AND   A.COD_BODEGA = B.COD_BODEGA
	 AND   B.COD_BODEGA = C.COD_BODEGA
	 AND   C.COD_BODEGANODO = D.COD_BODEGANODO
	 AND   A.COD_VENDEDOR = EN_CodVendedor
	 AND   A.COD_BODEGA  = EN_CodBodega
	 AND   D.COD_OPERADORA_SCL = EV_Cod_operadora;
EXCEPTION
		 WHEN NO_DATA_FOUND THEN
		 SN_cod_retorno := 300102; /* Bodega del articulo no asignada */
		 WHEN OTHERS THEN
	 	 SN_cod_retorno:= 56;/* No se ha podido ejecutar la consulta */
END PV_bodega_vendedor_PR;
-------------------------------------------------------------------------------------------------
PROCEDURE PV_serv_supl_PR(
ET_NumAbonado	  			IN				ga_abocel.num_abonado%TYPE,
ET_CodProducto	  			IN				ga_abocel.cod_producto%TYPE,
ET_codcentral				IN				icg_central.cod_central%TYPE,
ET_CodPlantarif				IN				ga_abocel.cod_plantarif%TYPE,
ET_CodUso					IN				ga_abocel.cod_uso%TYPE,
ET_Num_Celular				IN				ga_abocel.num_celular%TYPE,
ET_Tip_Terminal				IN 				icg_serviciotercen.tip_terminal%TYPE,
ET_Tip_Tecnologia			IN				icg_serviciotercen.tip_tecnologia%TYPE,
SV_CadServicio    			OUT NOCOPY   VARCHAR2)
/*
<Documentación>
  <TipoDoc = "Procedimiento"/>
   <Elemento
      Nombre = "pv_serv_supl_pr "
      Lenguaje="PL/SQL"
      Fecha="21-11-2005"
      Versión="1.0"
      Diseñador="Patricio Gallegos"
      Programador="Patricio Gallegos"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Configura servicios suplementarios por defecto.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ET_NumAbonado" Tipo="NUMERO">Numero de abonado</param>
            <param nom="ET_CodProducto" Tipo="NUMERO">Código producto</param>
            <param nom="ET_codcentral" Tipo="NUMERO">Código central</param>
            <param nom="ET_CodPlantarif" Tipo="CARACTER">Código plan tarifario</param>
			<param nom="ET_CodUso" Tipo="NUMERO">Código de uso.</param>
			<param nom="ET_Num_Celular" Tipo="NUMERO">Número de celular.</param>
			<param nom="ET_Tip_Terminal" Tipo="CARACTER">Tipo de terminal.</param>
         </Entrada>
         <Salida>
			<param nom="SV_CadServicio" Tipo="CARACTER">Cadena de servicios suplementarios</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

/* Servicios suplementarios actuales para dar de baja */
 CURSOR C_SERVACT IS
            SELECT LPAD(TO_CHAR(COD_SERVSUPL),2,'00')||'0000'
            FROM GA_SERVSUPLABO
            WHERE NUM_ABONADO=ET_NumAbonado
            AND IND_ESTADO<3;

/* Servicios suplemenetarios para dar de Alta */
 CURSOR CUR_SERVICIO_DEFAULT(nCodSistema NUMBER) IS
	   SELECT CONCAT(LTRIM(TO_CHAR(B.COD_SERVSUPL,'00')),LTRIM(TO_CHAR(B.COD_NIVEL,'0000')))
	   FROM GA_SERVSUPL B, GAD_SERVSUP_PLAN A,  ICG_SERVICIOTERCEN D, GA_SERVUSO C
	   WHERE A.COD_PRODUCTO = ET_CodProducto
	   AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
	   AND A.COD_PLANTARIF = ET_CodPlantarif
	   AND A.TIP_RELACION IN (3,4)
	   AND C.COD_USO = ET_CodUso
	   AND A.COD_SERVICIO = B.COD_SERVICIO
	   AND C.COD_SERVICIO = B.COD_SERVICIO
	   AND A.COD_PRODUCTO = B.COD_PRODUCTO
	   AND A.COD_PRODUCTO = C.COD_PRODUCTO
	   AND A.COD_PRODUCTO = D.COD_PRODUCTO
	   AND B.COD_SERVSUPL = D.COD_SERVICIO
	   AND D.COD_SISTEMA = nCodSistema
	   AND D.TIP_TERMINAL = ET_Tip_Terminal
	   AND D.TIP_TECNOLOGIA = ET_Tip_Tecnologia;

LV_CadServiciosDefault	  icc_movimiento.cod_servicios%TYPE;
LV_Servicio	VARCHAR2(6);
LT_CodSistema			icg_central.cod_sistema%TYPE;

BEGIN

OPEN C_SERVACT;
 LOOP
       FETCH C_SERVACT INTO LV_Servicio;
       EXIT WHEN C_SERVACT%NOTFOUND;

       SV_CadServicio := SV_CadServicio || LV_Servicio;

 END LOOP;

UPDATE GA_SERVSUPLABO
SET IND_ESTADO = 3,FEC_BAJABD = SYSDATE
WHERE NUM_ABONADO=ET_NumAbonado
AND IND_ESTADO<3;

SELECT cod_sistema
INTO LT_CodSistema
FROM icg_central
WHERE cod_producto = ET_CodProducto
AND cod_central = ET_codcentral;

      OPEN CUR_SERVICIO_DEFAULT(LT_CodSistema);
                  LOOP
                          FETCH CUR_SERVICIO_DEFAULT INTO LV_Servicio;
                          EXIT WHEN CUR_SERVICIO_DEFAULT%NOTFOUND;

						  /* sCadServiciosDefault: cadena de servicios que debe utilizarse
						  para actualizar el perfil de servicios del abonado */
                          LV_CadServiciosDefault := LV_CadServiciosDefault || LV_Servicio;

                  END LOOP;
      CLOSE CUR_SERVICIO_DEFAULT;

     INSERT INTO GA_SERVSUPLABO
     (num_abonado, cod_servicio, fec_altabd, cod_servsupl,
     cod_nivel, cod_producto, num_terminal, nom_usuarora,
     ind_estado, fec_altacen, fec_bajabd, fec_bajacen, cod_concepto)
     SELECT ET_NumAbonado, a.cod_servicio, SYSDATE, B.cod_servsupl,
  	 B.cod_nivel, B.cod_producto, ET_Num_Celular,USER,
  	 1, SYSDATE, NULL, NULL, NULL
	   FROM GA_SERVSUPL B, GAD_SERVSUP_PLAN A,  ICG_SERVICIOTERCEN D, GA_SERVUSO C
	   WHERE A.COD_PRODUCTO = ET_CodProducto
	   AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA, SYSDATE)
	   AND A.COD_PLANTARIF = ET_CodPlantarif
	   AND A.TIP_RELACION IN (3,4)
	   AND C.COD_USO = ET_CodUso
	   AND A.COD_SERVICIO = B.COD_SERVICIO
	   AND C.COD_SERVICIO = B.COD_SERVICIO
	   AND A.COD_PRODUCTO = B.COD_PRODUCTO
	   AND A.COD_PRODUCTO = C.COD_PRODUCTO
	   AND A.COD_PRODUCTO = D.COD_PRODUCTO
	   AND B.COD_SERVSUPL = D.COD_SERVICIO
	   AND D.COD_SISTEMA = LT_CodSistema
	   AND D.TIP_TERMINAL = ET_Tip_Terminal
	   AND D.TIP_TECNOLOGIA = ET_Tip_Tecnologia;

/* vCadServicio: se utilizará para enviar el movimiento central */
SV_CadServicio := LV_CadServiciosDefault || SV_CadServicio;

END PV_serv_supl_PR;

END Pv_Consultas_Ofvirtual_Pg;
/
SHOW ERRORS