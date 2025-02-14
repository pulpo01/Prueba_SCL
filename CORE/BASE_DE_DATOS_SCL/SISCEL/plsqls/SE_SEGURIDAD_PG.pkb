CREATE OR REPLACE package body SE_SEGURIDAD_PG AS

	PROCEDURE SE_valida_version_sistema_PR ( EV_cod_programa  IN  VARCHAR2,
		  							   	 EN_num_version IN NUMBER,
										 EN_num_subversion IN NUMBER,
										 SN_resultado      OUT NOCOPY PLS_INTEGER,
				 				 	  	 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                        		      	 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                           		      	 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
 		/*
		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "SE_valida_version_sistema_PR"
			Lenguaje="PL/SQL"
			Fecha="10-04-2007"
			Versión="1.0.0"
			Diseñador="Mario Tigua"
			Programador="Mario Tigua"
			Ambiente="BD"
		<Retorno> NA </Retorno>
		<Descripción>
			Retorna 1 si la consulta de la version del sistema es exitosa, 0 de lo contrario
		</Descripción>
		<Parámetros>
		<Entrada>
				<param nom="EV_cod_programa" Tipo="VARCHAR2"> codigo del programa /param>
				<param nom="EN_num_version" Tipo="NUMBER"> numero de version  /param>
				<param nom="EN_num_subversion" Tipo="NUMBER"> numero de subversion /param>

		</Entrada>
		<Salida>
   			    <param nom="SN_RESULTADO" Tipo="PLS_INTEGER">1 consulta exitosa, 0 de lo contrario</param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
        */

	LV_resultado  VARCHAR2(1);
	LV_des_error	   ge_errores_pg.DesEvent;
	LV_Sql			   ge_errores_pg.vQuery;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;
		SN_resultado:=0;

		LV_Sql := 'SELECT ' || '''1'''
			   || ' FROM GE_PROGRAMAS'
			   || ' WHERE COD_PROGRAMA = ' || EV_cod_programa
			   || ' AND NUM_VERSION = ' || EN_num_version
			   || ' AND NUM_SUBVERSION = ' || EN_num_subversion
			   || ' AND SYSDATE BETWEEN FEC_DESDE_DH AND FEC_HASTA_DH';

		SELECT '1'
		INTO  LV_resultado
		FROM  GE_PROGRAMAS
		WHERE COD_PROGRAMA = EV_cod_programa
		  AND NUM_VERSION = EN_num_version
		  AND NUM_SUBVERSION = EN_num_subversion
	    AND SYSDATE BETWEEN FEC_DESDE_DH AND FEC_HASTA_DH;

		SN_resultado:=1;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=4;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='NO_DATA_FOUND:SE_SEGURIDAD_PG.SE_valida_version_sistema_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'NO_DATA_FOUND:SE_SEGURIDAD_PG.SE_valida_version_sistema_PR()', LV_Sql, SQLCODE, LV_des_error );
		WHEN OTHERS THEN
            SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:SE_SEGURIDAD_PG.SE_valida_version_sistema_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'OTHERS:SE_SEGURIDAD_PG.SE_valida_version_sistema_PR()', LV_Sql, SQLCODE, LV_des_error );

	END SE_valida_version_sistema_PR;







	PROCEDURE VE_valida_usuario_PR (  	 EV_nom_usuario IN  VARCHAR2,
									 	 SN_resultado    OUT NOCOPY PLS_INTEGER,
										 SN_codigo_vendedor OUT NOCOPY PLS_INTEGER,
										 SV_codigo_oficina OUT VARCHAR2,
										 SV_nombre_usuario OUT VARCHAR2,
			 				 	  	 	 SV_Codigo_Comisionista OUT GE_SEG_USUARIO.COD_TIPCOMIS%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                       		      	 	 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                          		      	 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
	  /*

		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_valida_usuario_PR"
			Lenguaje="PL/SQL"
			Fecha="10-04-2007"
			Versión="1.0.0"
			Diseñador="Mario Tigua"
			Programador="Mario Tigua"
			Ambiente="BD"
		<Retorno> NA </Retorno>
		<Descripción>
			Retorna el codigo de vendedor si el usuario existe en la tabla de usuarios
		</Descripción>
		<Parámetros>
		<Entrada>
				<param nom="EV_nom_usuario" Tipo="VARCHAR2"> nombre del usuario /param>

		</Entrada>
		<Salida>
				<param nom="SN_resultado" Tipo="PLS_INTEGER">1 consulta exitosa, 0 de lo contrario/param>
				<param nom="SN_codigo_vendedor" Tipo="PLS_INTEGER"> codigo de vendedor /param>
				<param nom="SV_codigo_oficina" Tipo="VARCHAR2"> codigo de oficina /param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
      */


	LV_resultado  VARCHAR2(1);
	LV_des_error  ge_errores_pg.DesEvent;
	LV_Sql		  ge_errores_pg.vQuery;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		SN_resultado:=0;

		LV_Sql := 'SELECT ' || '''1''' ||',G.COD_VENDEDOR,G.COD_OFICINA,G.NOM_USUARIO,G.COD_TIPCOMIS'
			   || ' FROM GE_SEG_USUARIO G'
			   || ' WHERE UPPER(G.NOM_USUARIO) = UPPER(' || EV_nom_usuario || ')';

		SELECT '1',G.COD_VENDEDOR,G.COD_OFICINA,G.NOM_USUARIO,G.COD_TIPCOMIS
		INTO   LV_resultado,SN_codigo_vendedor,SV_codigo_oficina,SV_nombre_usuario,SV_Codigo_Comisionista
		FROM   GE_SEG_USUARIO G
		WHERE  UPPER(G.NOM_USUARIO) = UPPER(EV_nom_usuario);

		SN_resultado:=1;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=4;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='NO_DATA_FOUND:SE_SEGURIDAD_PG.VE_valida_usuario_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'NO_DATA_FOUND:SE_SEGURIDAD_PG.VE_valida_usuario_PR()', LV_Sql, SQLCODE, LV_des_error );
		WHEN OTHERS THEN
            SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR()', LV_Sql, SQLCODE, LV_des_error );

	END VE_valida_usuario_PR;


	-- Sobrecarga Valida Usuario
	PROCEDURE VE_valida_usuario_PR ( EV_nom_usuario     IN  VARCHAR2,
									 SN_resultado       OUT NOCOPY PLS_INTEGER,
									 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                       		      	 SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                          		     SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
	  /*

		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_valida_usuario_PR"
			Lenguaje="PL/SQL"
			Fecha="10-04-2007"
			Versión="1.0.0"
			Diseñador="Mario Tigua"
			Programador="Mario Tigua"
			Ambiente="BD"
		<Retorno> NA </Retorno>
		<Descripción>
			Retorna el codigo de vendedor si el usuario existe en la tabla de usuarios
		</Descripción>
		<Parámetros>
		<Entrada>
				<param nom="EV_nom_usuario" Tipo="VARCHAR2"> nombre del usuario /param>

		</Entrada>
		<Salida>
				<param nom="SN_resultado" Tipo="PLS_INTEGER">1 consulta exitosa, 0 de lo contrario/param>
				<param nom="SN_codigo_vendedor" Tipo="PLS_INTEGER"> codigo de vendedor /param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
      */


	LV_resultado  VARCHAR2(1);
	LV_des_error  ge_errores_pg.DesEvent;
	LV_Sql		  ge_errores_pg.vQuery;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		SN_resultado:=0;

		LV_Sql := 'SELECT 1'
			   || ' FROM GE_SEG_USUARIO G'
			   || ' WHERE G.NOM_USUARIO = UPPER(' || EV_nom_usuario || ')';

		SELECT '1'
		INTO   LV_resultado
		FROM   GE_SEG_USUARIO G
		WHERE  G.NOM_USUARIO = UPPER(EV_nom_usuario);

		SN_resultado:=1;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=4;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='NO_DATA_FOUND:SE_SEGURIDAD_PG.VE_valida_usuario_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'NO_DATA_FOUND:SE_SEGURIDAD_PG.VE_valida_usuario_PR()', LV_Sql, SQLCODE, LV_des_error );
		WHEN OTHERS THEN
            SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR()', LV_Sql, SQLCODE, LV_des_error );

	END VE_valida_usuario_PR;

	PROCEDURE VE_valida_usuario_PR (EV_nom_usuario     IN  VARCHAR2,
                                    EV_cod_programa    IN  VARCHAR2,
                                    EV_cod_proceso     IN  VARCHAR2,
                                    EV_cod_opcion      IN  VARCHAR2,
									SN_resultado       OUT NOCOPY PLS_INTEGER,
			 				 	  	SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                       		      	SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                          		    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
	  /*

		<Documentación TipoDoc = "Procedimiento">
			Elemento Nombre = "VE_valida_usuario_PR"
			Lenguaje="PL/SQL"
			Fecha="18-10-2007"
			Versión="1.0.0"
			Diseñador="Héctor Hermosilla"
			Programador="Héctor Hermosilla"
			Ambiente="BD"
		<Retorno> NA </Retorno>
		<Descripción>
			Retorna el codigo de vendedor si el usuario existe en la tabla de usuarios
		</Descripción>
		<Parámetros>
		<Entrada>
				<param nom="EV_nom_usuario"  Tipo="VARCHAR2"> nombre del usuario </param>
				<param nom="EV_cod_programa" Tipo="VARCHAR2"> codigo programa </param>
				<param nom="EV_cod_proceso"  Tipo="VARCHAR2"> codigo proceso </param>
				<param nom="EV_cod_opcion"   Tipo="VARCHAR2"> codigo opcion /param>

		</Entrada>
		<Salida>
				<param nom="SN_resultado" Tipo="PLS_INTEGER">1 consulta exitosa, 0 de lo contrario/param>
				<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
				<param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
				<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>

		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
      */


	LV_resultado  VARCHAR2(1);
	LV_des_error  ge_errores_pg.DesEvent;
	LV_Sql		  ge_errores_pg.vQuery;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

		SN_resultado:=0;

		LV_Sql := 'SELECT 1'
			   || ' FROM   ge_seg_usuario a,  ge_seg_perfiles b,'
			   || ' ge_seg_procesos c, ge_seg_grpusuario d,'
			   || ' ge_seg_procprog e'
			   || ' WHERE  a.nom_usuario  = UPPER(''' || EV_nom_usuario || ''')'
			   || ' AND	   c.cod_proceso  =''' ||  EV_cod_proceso || ''''
			   || ' AND    e.menu         =''' ||  EV_cod_opcion || ''''
			   || ' AND    e.cod_programa =''' || EV_cod_programa ||''''
			   || ' AND	   e.cod_proceso  = c.cod_proceso'
			   || ' AND    c.cod_proceso  = b.cod_proceso'
			   || ' AND	   b.cod_grupo    = d.cod_grupo'
			   || ' AND	   d.nom_usuario  = a.nom_usuario';


		SELECT '1'
	    INTO   LV_resultado
		FROM   ge_seg_usuario a,  ge_seg_perfiles b,
			   ge_seg_procesos c, ge_seg_grpusuario d,
			   ge_seg_procprog e
		WHERE  a.nom_usuario  = UPPER(EV_nom_usuario)
		AND	   c.cod_proceso  = EV_cod_proceso
		AND    e.menu         = EV_cod_opcion
		AND    e.cod_programa = EV_cod_programa
		AND	   e.cod_proceso  = c.cod_proceso
		AND    c.cod_proceso  = b.cod_proceso
	    AND	   b.cod_grupo    = d.cod_grupo
	    AND	   d.nom_usuario  = a.nom_usuario
	    AND    ROWNUM = 1;


		SN_resultado:=1;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
            SN_cod_retorno:=4;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='NO_DATA_FOUND:SE_SEGURIDAD_PG.VE_valida_usuario_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'NO_DATA_FOUND:SE_SEGURIDAD_PG.VE_valida_usuario_PR()', LV_Sql, SQLCODE, LV_des_error );
		WHEN OTHERS THEN
            SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR()', LV_Sql, SQLCODE, LV_des_error );

	END VE_valida_usuario_PR;
	PROCEDURE VE_obtiene_menu_pr (  EV_cod_programa     IN GE_PROGRAMAS.COD_PROGRAMA%TYPE,
                                    EN_NUM_VERSION      IN GE_PROGRAMAS.NUM_VERSION%TYPE,
                                    EV_nom_usuario      IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
			 				 	  	SC_CURSORDATOS     OUT NOCOPY refcursor,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                       		      	SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                          		    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS

	LV_resultado  VARCHAR2(1);
	LV_des_error  ge_errores_pg.DesEvent;
	LV_Sql		  ge_errores_pg.vQuery;
	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;


	     OPEN SC_CURSORDATOS FOR
         SELECT distinct c.formulario,'0'
         FROM GE_SEG_GRPUSUARIO A, GE_SEG_PERFILES B, GE_SEG_PROCPROG C
         WHERE A.COD_GRUPO = B.COD_GRUPO
         AND B.COD_PROGRAMA = C.COD_PROGRAMA
         AND B.NUM_VERSION = C.NUM_VERSION
         AND B.COD_PROCESO = C.COD_PROCESO
         AND B.COD_PROGRAMA = EV_cod_programa
         AND B.NUM_VERSION = EN_NUM_VERSION
         AND A.NOM_USUARIO = EV_nom_usuario;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
            NULL;
		WHEN OTHERS THEN
            SN_cod_retorno:=156;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno:=CV_error_no_clasif;
            END IF;
            LV_des_error:='OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR();- ' || SQLERRM;
            SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_codmodulo,SV_mens_retorno, '1.0', USER,
            'OTHERS:SE_SEGURIDAD_PG.VE_valida_usuario_PR()', LV_Sql, SQLCODE, LV_des_error );

	END VE_obtiene_menu_pr;

END SE_SEGURIDAD_PG;
/
SHOW ERRORS