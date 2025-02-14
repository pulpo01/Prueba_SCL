CREATE OR REPLACE PACKAGE BODY PV_GENERALES_PG AS

--------------------------------------------------------------------------------------------------------------------------------------------------
--1.-
PROCEDURE PV_OBTIENE_GED_PARAMETROS_PR (EO_GED_PARAMETROS	IN OUT NOCOPY	PV_GED_PARAMETROS_QT,
									    SN_cod_retorno    	OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									    SV_mens_retorno   	OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
									    SN_num_evento     	OUT    NOCOPY	ge_errores_pg.evento)
IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_GED_CODIGOS_PR    "
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Carlos Elizondo"
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=COD_MODULO    VARCHAR2(2)   </param>>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=COD_PRODUCTO  NUMBER (1)    </param>>
	         </Entrada>
	         <Salida>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VAL_PARAMETRO VARCHAR2(20) </param>>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=DES_PARAMETRO VARCHAR2(50) </param>>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
				<param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
				<param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;

		BEGIN
			SN_cod_retorno 	:= 0;
			SN_num_evento   := 0;
		    SV_mens_retorno := NULL;

			LV_sSql:='SELECT VAL_PARAMETRO,DES_PARAMETRO FROM  GED_PARAMETROS  ';
			LV_sSql:= LV_sSql || ' WHERE NOM_PARAMETRO = ' || EO_GED_PARAMETROS.NOM_PARAMETRO || ' ';
			LV_sSql:= LV_sSql || ' AND	 COD_MODULO    = ' || EO_GED_PARAMETROS.COD_MODULO    || ' ';

			SELECT VAL_PARAMETRO,
				   DES_PARAMETRO
			INTO  EO_GED_PARAMETROS.VAL_PARAMETRO,
				  EO_GED_PARAMETROS.DES_PARAMETRO
			FROM  GED_PARAMETROS
			WHERE NOM_PARAMETRO = EO_GED_PARAMETROS.NOM_PARAMETRO
			AND	  COD_MODULO    = EO_GED_PARAMETROS.COD_MODULO
			AND   COD_PRODUCTO  = EO_GED_PARAMETROS.COD_PRODUCTO;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1362;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_GED_PARAMETROS_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||','||EO_GED_PARAMETROS.COD_PRODUCTO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_GED_PARAMETROS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_GED_PARAMETROS_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--2.-
PROCEDURE PV_OBTIENE_GED_PARAM_SIMPL_PR (EO_GED_PARAMETROS	IN OUT NOCOPY	PV_GED_PARAMETROS_QT,
									      SN_cod_retorno       OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									      SV_mens_retorno      OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									      SN_num_evento        OUT NOCOPY	ge_errores_pg.evento)
IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_GED_PARAM_SIMPL_PR    "
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Carlos Elizondo"
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=COD_MODULO    VARCHAR2(2)   </param>>
	         </Entrada>
	         <Salida>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_NUMERICO NUMBER(20,6) </param>>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_TEXTO   VARCHAR2(255) </param>>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_FECHA   DATE          </param>>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
				<param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
				<param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;
		BEGIN
			SN_cod_retorno 	:= 0;
			SN_num_evento   := 0;
		    SV_mens_retorno := NULL;

			LV_sSql:='SELECT VALOR_NUMERICO,VALOR_TEXTO,VALOR_FECHA,VALOR_DOMINIO';
			LV_sSql:= LV_sSql || ' FROM   GA_PARAMETROS_SIMPLES_VW WHERE NOM_PARAMETRO = '||EO_GED_PARAMETROS.NOM_PARAMETRO ||' ';
			LV_sSql:= LV_sSql || ' AND	 COD_MODULO   = ' ||EO_GED_PARAMETROS.COD_MODULO  ||' ';

			SELECT VALOR_NUMERICO,
				   VALOR_TEXTO,
				   VALOR_FECHA,
				   VALOR_DOMINIO
			INTO  EO_GED_PARAMETROS.VALOR_NUMERICO,
				  EO_GED_PARAMETROS.VALOR_TEXTO,
				  EO_GED_PARAMETROS.VALOR_FECHA,
				  EO_GED_PARAMETROS.VALOR_DOMINIO
			FROM  GA_PARAMETROS_SIMPLES_VW
			WHERE NOM_PARAMETRO = EO_GED_PARAMETROS.NOM_PARAMETRO
			AND	  COD_MODULO    = EO_GED_PARAMETROS.COD_MODULO;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1362;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_OBTIENE_GED_PARAM_SIMPLES_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_GED_PARAM_SIMPLES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_OBTIENE_GED_PARAM_SIMPLES_PR('||EO_GED_PARAMETROS.NOM_PARAMETRO||','||EO_GED_PARAMETROS.COD_MODULO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_GED_PARAM_SIMPLES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_GED_PARAM_SIMPL_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--3.-
	PROCEDURE PV_FORMATO_FEC_PR (EO_FORMATO_FEC		IN OUT NOCOPY	PV_FORMATO_FEC_QT,
						         SN_cod_retorno    	OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
						         SV_mens_retorno   	OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
						         SN_num_evento     	OUT    NOCOPY	ge_errores_pg.evento)
	IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_FORMATO_FEC_PR    "
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Carlos Elizondo"
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
	         </Entrada>
	         <Salida>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_NUMERICO NUMBER(20,6) </param>>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
				<param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
				<param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;
		BEGIN
			SN_cod_retorno 	:= 0;
			SN_num_evento   := 0;
		    SV_mens_retorno := NULL;

			LV_sSql:='';
			LV_sSql:=LV_sSql||'';
			LV_sSql:=LV_sSql||' SELECT decode('||EO_FORMATO_FEC.FORMATO||','||'CV_gsFormato_sel1'||','||CV_gsFormato_sel1||',   ';
			LV_sSql:=LV_sSql||'        decode('||EO_FORMATO_FEC.FORMATO||','||'CV_gsFormato_sel2'||','||CV_gsFormato_sel2||'))  ';
			LV_sSql:=LV_sSql||' INTO EO_FORMATO_FEC.FORMATO ';
			LV_sSql:=LV_sSql||' FROM DUAL; ';

			SELECT decode(EO_FORMATO_FEC.FORMATO,'CV_gsFormato_sel1',CV_gsFormato_sel1,
				   decode(EO_FORMATO_FEC.FORMATO,'CV_gsFormato_sel2',CV_gsFormato_sel2))
			INTO EO_FORMATO_FEC.FORMATO
			FROM DUAL;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 149;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_FORMATO_FEC_PR('||EO_FORMATO_FEC.FORMATO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_FORMATO_FEC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_FORMATO_FEC_PR('||EO_FORMATO_FEC.FORMATO||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_FORMATO_FEC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

	END PV_FORMATO_FEC_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4.-
	PROCEDURE PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA	IN OUT NOCOPY	PV_SECUENCIA_QT,
									   SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   SN_num_evento   OUT NOCOPY	ge_errores_pg.evento)
IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_SECUENCIA_PR    "
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Carlos Elizondo"
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
	         </Entrada>
	         <Salida>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_NUMERICO NUMBER(20,6) </param>>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
				<param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
				<param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;

	BEGIN
			SN_cod_retorno 	:= 0;
			SN_num_evento   := 0;
		    SV_mens_retorno := NULL;

		LV_sSql := 'SELECT ' || EO_SECUENCIA.NOM_SECUENCIA || '.NEXTVAL FROM DUAL';
		EXECUTE IMMEDIATE LV_sSql INTO EO_SECUENCIA.NUM_SECUENCIA;

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_SECUENCIA_PR('||EO_SECUENCIA.NOM_SECUENCIA||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

	END PV_OBTIENE_SECUENCIA_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--5.-
 PROCEDURE PV_OBTIENE_GED_CODIGOS_PR(SO_GEDCODIGOS		    IN OUT NOCOPY   PV_TIPOS_PG.TIP_GED_CODIGOS,
   			 						   SO_cursor            OUT    NOCOPY	refCursor,
									   SN_cod_retorno   	OUT    NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   SV_mens_retorno  	OUT    NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   SN_num_evento    	OUT    NOCOPY	ge_errores_pg.evento)
IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_GED_CODIGOS_PR
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Raúl Lozano"
	      Programador="Raúl Lozano"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
	            <param nom="SO_GEDCODIGOS" Tipo="estructura">estructura de GED_CODIGOS</param>>
	         </Entrada>
	         <Salida>
	            <param nom="" Tipo=""></param>>
	            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
		BEGIN
	        SN_cod_retorno 	:= 0;
        	SV_mens_retorno := ' ';
        	SN_num_evento 	:= 0;

			LV_sSql := ' ';
			OPEN SO_cursor FOR
    			SELECT  cod_modulo, nom_tabla, nom_columna, cod_valor,des_valor, fec_ultmod, nom_usuario
	     		FROM ged_codigos g
			    WHERE g.cod_modulo =SO_GEDCODIGOS(1).cod_modulo
     			  AND g.nom_columna=SO_GEDCODIGOS(1).nom_columna
		    	  AND g.nom_tabla  =SO_GEDCODIGOS(1).nom_tabla;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 1362;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_OBTIENE_GED_CODIGOS_PR('||SO_GEDCODIGOS(1).nom_columna||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_GED_CODIGOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
	WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_GED_CODIGOS_PR('||SO_GEDCODIGOS(1).nom_columna||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_GED_CODIGOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_OBTIENE_GED_CODIGOS_PR;

--------------------------------------------------------------------------------------------------------------------------------------------------
--6.-
FUNCTION PV_obtiene_version_FN(SV_Version       OUT NOCOPY   ge_programas.num_version%TYPE,
		 					   SV_SubVersion    OUT NOCOPY   ge_programas.num_subversion%TYPE,
		 					   SN_cod_retorno   OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
					      	   SV_mens_retorno  OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
					      	   SN_num_evento    OUT NOCOPY	 ge_errores_pg.evento)
	RETURN BOOLEAN
	IS
	/*
	<Documentacion TipoDoc = "PROCEDURE">
	<Elemento Nombre = "PV_obtiene_numversion_FN  "
	 Lenguaje="PL/SQL" Fecha="12-04-2005"
	 Versión"1.0.0" Diseñador"Carlos Elizondo"
	 Programador="" Ambiente="BD">
	<Retorno>NA</Retorno>
	<Descripcion> Obtiene version y subversion /Descripcion>
	<Parametros>
	<Entrada>
	</Entrada>
	<Salida>
			<param nom="LN_numversion"   Tipo="NUMERO DE VERSION">     CAMPO =NUM_VERSION    NUMBER(2)  </param>>
			<param nom="SV_SubVersion"   Tipo="NUMERO DE SUBVERSION">  CAMPO=NUM_SUBVERSION  NUMBER(3) </param>>
           <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>>
	</Salida>
	</Parametros>
	</Elemento>
	</Documentacion>
	*/
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_sSql			   ge_errores_pg.vQuery;
	LN_numversion	   ge_programas.num_version%TYPE;
	BEGIN
	    SN_cod_retorno 	  := 0;
	    SV_mens_retorno   := NULL;
	    SN_num_evento 	  := 0;
		LN_numversion	  := 0;

		LV_sSql:='';
		LV_sSql:=LV_sSql||' SELECT MAX(NUM_VERSION) INTO LN_numversion FROM GE_PROGRAMAS ';
		LV_sSql:=LV_sSql||' WHERE COD_PROGRAMA = '||CV_programa|| ' ';
		LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN FEC_DESDE_DH AND FEC_HASTA_DH; ';

		SELECT nvl(MAX(NUM_VERSION),0)
		INTO LN_numversion
		 FROM GE_PROGRAMAS
		  WHERE COD_PROGRAMA = CV_programa
				AND SYSDATE BETWEEN FEC_DESDE_DH AND FEC_HASTA_DH;

		SV_Version :=	LN_numversion;
		LV_sSql:='';
		LV_sSql:=LV_sSql||' SELECT MAX(NUM_SUBVERSION) INTO LN_NumSubVersion FROM GE_PROGRAMAS ';
		LV_sSql:=LV_sSql||' WHERE COD_PROGRAMA= '||CV_programa||' ';
		LV_sSql:=LV_sSql||' AND NUM_VERSION = '||LN_numversion||' ';
		LV_sSql:=LV_sSql||' AND SYSDATE BETWEEN FEC_DESDE_DH AND FEC_HASTA_DH; ';

		--Query que obtiene el número de Subversion de la orden de servicio
		SELECT MAX(NUM_SUBVERSION)
		INTO SV_SubVersion
		 FROM GE_PROGRAMAS
		  WHERE COD_PROGRAMA = CV_programa
			 	AND NUM_VERSION  = LN_numversion
				AND SYSDATE BETWEEN FEC_DESDE_DH AND FEC_HASTA_DH;

		RETURN TRUE;


    EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 149;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_obtiene_numversion_FN(''); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_numversion_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
    WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := 'PV_obtiene_numversion_FN(''); - ' || SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_PLAN_BASICO_PG.PV_obtiene_numversion_FN', LV_sSQL, SN_cod_retorno, LV_des_error );
		  RETURN FALSE;
END PV_obtiene_version_FN;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE PV_OBTIENE_SECUENCIA_PR (EO_SECUENCIA	IN OUT NOCOPY	PV_SECUENCIA_QT,
									   EN_NUM_VECES IN              NUMBER,
									   SO_numerosOS    OUT NOCOPY refcursor,
									   SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   SN_num_evento   OUT NOCOPY	ge_errores_pg.evento)
IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_SECUENCIA_PR    "
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Carlos Elizondo"
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
	         </Entrada>
	         <Salida>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_NUMERICO NUMBER(20,6) </param>>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
				<param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
				<param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;
		lv_numos		   NUMBER(10);
		LV_COUNT           NUMBER(4);
		numerosOS		   listaNumOS;

    BEGIN

			SN_cod_retorno 	:= 0;
			SN_num_evento   := 0;
		    SV_mens_retorno := NULL;
            LV_COUNT        :=1;

		EO_SECUENCIA.NUM_SECUENCIA:=NULL;

		LV_sSql := 'select '||EO_SECUENCIA.NOM_SECUENCIA||'.nextval';
		LV_sSql :=  LV_sSql ||' from ga_Abocel';
		LV_sSql :=  LV_sSql ||' where rownum <= '||EN_NUM_VECES;


		OPEN SO_numerosOS for LV_sSql;

	EXCEPTION
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_SECUENCIA_PR('||EO_SECUENCIA.NOM_SECUENCIA||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_SECUENCIA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

	END PV_OBTIENE_SECUENCIA_PR;
/**********************************************************************************************************************************************/

PROCEDURE PV_OBTIENE_DATOS_OFICINA(EO_OFICINA      IN OUT NOCOPY PV_OFICINA_QT,
  							       SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
								   SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
								   SN_num_evento   OUT NOCOPY	ge_errores_pg.evento)
IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_OBTIENE_DATOS_OFICINA"
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Andrés Osorio
	      Programador="Andrés Osorio"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
				<param nom="EO_OFICINA" Tipo="estructura">Oficina de Atención de la OOSS</param>>
	         </Entrada>
	         <Salida>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
				<param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
				<param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;

		BEGIN
			SN_cod_retorno 	:= 0;
			SN_num_evento   := 0;
		    SV_mens_retorno := NULL;

			LV_sSql:= ' SELECT o.des_oficina,';
			LV_sSql:= LV_sSql || ' o.cod_comuna,';
			LV_sSql:= LV_sSql || ' c.des_comuna';
			LV_sSql:= LV_sSql || ' FROM ge_oficinas o, ge_comunas c';
			LV_sSql:= LV_sSql || ' WHERE o.cod_oficina = '||eo_oficina.cod_oficina;
			LV_sSql:= LV_sSql || ' AND o.cod_comuna = c.cod_comuna';

			SELECT o.des_oficina,
				   o.cod_comuna,
				   c.des_comuna
			INTO   EO_OFICINA.DES_OFICINA,
				   EO_OFICINA.COD_COMUNA,
				   EO_OFICINA.DES_COMUNA
			FROM   ge_oficinas o, ge_comunas c
			WHERE  o.cod_oficina = eo_oficina.cod_oficina
			AND	   o.cod_comuna = c.cod_comuna;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	      SN_cod_retorno := 173;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_DATOS_OFICINA('||EO_OFICINA.COD_OFICINA||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_DATOS_OFICINA', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 626;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_OBTIENE_DATOS_OFICINA('||NVL(EO_OFICINA.COD_OFICINA,'NULL')||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_DATOS_OFICINA', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_OBTIENE_DATOS_OFICINA;

/*****************************************************************************************************************************************************/
	PROCEDURE PV_ABONADOS_SECUENCIA_PR (EO_CLIENTE		IN PV_CLIENTE_QT,
		  						   	    EO_SECUENCIA	IN PV_SECUENCIA_QT,
									   	SO_numerosOS    OUT NOCOPY refcursor,
	  							       	SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
									   	SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
									   	SN_num_evento   OUT NOCOPY	ge_errores_pg.evento)
IS
	/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "PV_ABONADOS_SECUENCIA_PR   "
	      Lenguaje="PL/SQL"
	      Fecha="25-07-2007"
	      Versión="La del package"
	      Diseñador="Carlos Elizondo"
	      Programador="Carlos Elizondo"
	      Ambiente Desarrollo="BD">
	      <Retorno>N/A</Retorno>>
	      <Descripción></Descripción>>
	      <Parámetros>
	         <Entrada>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=NOM_PARAMETRO VARCHAR2(20)  </param>>
	         </Entrada>
	         <Salida>
				<param nom="EO_GED_PARAMETROS.PV_GED_PARAMETROS_QT" Tipo="estructura">estructura campo=VALOR_NUMERICO NUMBER(20,6) </param>>
				<param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
				<param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
				<param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/
		LV_des_error	   ge_errores_pg.DesEvent;
		LV_sSql			   ge_errores_pg.vQuery;
		lv_numos		   NUMBER(10);
		LV_COUNT           NUMBER(4);
		numerosOS		   listaNumOS;
		ERROR_PARAMETROS   EXCEPTION;

    BEGIN

			SN_cod_retorno 	:= 0;
			SN_num_evento   := 0;
		    SV_mens_retorno := NULL;
            LV_COUNT        :=1;

		IF (EO_CLIENTE.COD_CLIENTE IS NULL OR EO_SECUENCIA.NOM_SECUENCIA IS NULL) THEN
		   RAISE ERROR_PARAMETROS;
		END IF;


		LV_sSql := 'SELECT count(0)';
		LV_sSql :=  LV_sSql ||' FROM   ga_abocel';
		LV_sSql :=  LV_sSql ||' WHERE  cod_cliente = '||EO_CLIENTE.COD_CLIENTE;

		SELECT count(0)
		INTO   LV_COUNT
		FROM   ga_abocel
		WHERE  cod_cliente = EO_CLIENTE.COD_CLIENTE;

		IF (LV_COUNT != 0) THEN
			LV_sSql := 'SELECT num_abonado,'||EO_SECUENCIA.NOM_SECUENCIA||'.nextval';
			LV_sSql :=  LV_sSql ||' FROM ga_abocel';
			LV_sSql :=  LV_sSql ||' WHERE cod_cliente = '||EO_CLIENTE.COD_CLIENTE;
			LV_sSql :=  LV_sSql ||' AND cod_situacion NOT IN ('||''''||CV_SITUA_BAA||''''||', '||''''||CV_SITUA_BAP||''''||')';

		ELSE
			LV_sSql := 'SELECT num_abonado,'||EO_SECUENCIA.NOM_SECUENCIA||'.nextval';
			LV_sSql :=  LV_sSql ||' FROM ga_aboamist';
			LV_sSql :=  LV_sSql ||' WHERE cod_cliente = '||EO_CLIENTE.COD_CLIENTE;
			LV_sSql :=  LV_sSql ||' AND cod_situacion NOT IN ('||''''||CV_SITUA_BAA||''''||', '||''''||CV_SITUA_BAP||''''||')';
		END IF;



		OPEN SO_numerosOS for LV_sSql;

	EXCEPTION
	  WHEN ERROR_PARAMETROS THEN
	      SN_cod_retorno := 98;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_ABONADOS_SECUENCIA_PR(NULL); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_OBTIENE_DATOS_OFICINA', LV_sSQL, SN_cod_retorno, LV_des_error );
	  WHEN OTHERS THEN
	      SN_cod_retorno := 156;
	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
	         SV_mens_retorno := CV_error_no_clasif;
	      END IF;
		  LV_des_error   := ' PV_ABONADOS_SECUENCIA_PR('||EO_SECUENCIA.NOM_SECUENCIA||'); '||SQLERRM;
	      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_GENERALES_PG.PV_ABONADOS_SECUENCIA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

	END PV_ABONADOS_SECUENCIA_PR;
/**********************************************************************************************************************************************/




END PV_GENERALES_PG;
/
SHOW ERRORS
