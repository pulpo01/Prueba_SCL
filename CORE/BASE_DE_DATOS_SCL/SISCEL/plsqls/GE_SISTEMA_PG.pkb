CREATE OR REPLACE PACKAGE BODY GE_SISTEMA_PG AS

 GV_error_no_clasif VARCHAR2(100):= 'Error no clasificado';
 GV_FORMATO_FECHAS  VARCHAR2(30) := 'DDMMYYYYHH24MISS';
 GV_SQL             VARCHAR2(1000);


 FUNCTION GE_RECUPERARROL_FN (ev_id_user      IN ge_seg_grpusuario.NOM_USUARIO%type,
			                  ev_programa     IN ge_seg_perfiles.COD_PROGRAMA%type,
                              en_version      IN ge_seg_perfiles.NUM_VERSION%type,
                              SN_COD_RETORNO  OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SN_NUM_EVENTO   OUT NOCOPY NUMBER)
RETURN NUMBER
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_RECUPERARROL_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Valida si el usuario ingredado tiene permisos sobre la aplicación</Retorno>
      <Descripcion>función que retorna 1:Si el usuario tiene permiso para utilizar la aplicación,
	                                   0:Si no tiene permiso</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="ev_id_user" Tipo="VARCHAR2">Nombre del usuario</param>
            <param nom="ev_programa" Tipo="VARCHAR2">Codigo del programa</param>
            <param nom="en_version" Tipo="NUMBER">número de la version</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    LN_EXISTEROL NUMBER:=0;

 BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    GV_SQL:='';
    GV_SQL:='SELECT UNIQUE 1 ';
	GV_SQL:= GV_SQL || 'FROM GE_SEG_PERFILES A,GE_SEG_GRPUSUARIO B ';
	GV_SQL:= GV_SQL || 'WHERE ';
	GV_SQL:= GV_SQL || '	    A.COD_GRUPO = B.COD_GRUPO ';
	GV_SQL:= GV_SQL || '	AND B.NOM_USUARIO = ' || ev_id_user;
	GV_SQL:= GV_SQL || '	AND A.COD_PROGRAMA = ' || ev_programa;
	GV_SQL:= GV_SQL || '	AND A.NUM_VERSION = ' || en_version;


	SELECT UNIQUE 1
	INTO   LN_EXISTEROL
	FROM   GE_SEG_PERFILES A,GE_SEG_GRPUSUARIO B
	WHERE  A.COD_GRUPO    = B.COD_GRUPO
	AND    B.NOM_USUARIO  = ev_id_user
	AND    A.COD_PROGRAMA = ev_programa
	AND    A.NUM_VERSION  = en_version;

    RETURN LN_EXISTEROL;

 EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_COD_RETORNO := 1085; -- Rol No Existe.

  	      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	      END IF;
  	      SN_num_evento  := Ge_Errores_Pg.Grabarpl(SN_num_evento, 'FA',
	                                               SV_mens_retorno, 1.0,
												   USER,
												   'GE_SISTEMA_PG.GE_RECUPERARROL_FN',
												   GV_SQL, SQLCODE, SQLERRM );
          RETURN 0; -- FALSE

   WHEN OTHERS THEN
        SN_COD_RETORNO := 2174; -- Error en Recuperar Rol.

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := GV_error_no_clasif;
 	    END IF;
  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
	                                             SV_mens_retorno, 1.0,
												 USER,
												 'GE_SISTEMA_PG.GE_RECUPERARROL_FN',
												 GV_SQL, SQLCODE, SQLERRM );
	    RETURN 0; -- FALSE

 END;


 FUNCTION GE_VERIFICAVERSION_FN (ev_cod_programa IN ge_programas.COD_PROGRAMA%type,
			   					 en_num_version  IN ge_programas.NUM_VERSION%type,
			   					 en_sub_version  IN  ge_programas.NUM_SUBVERSION%type,
 			   					 sn_cod_retorno  OUT NOCOPY NUMBER,
			   					 sv_mens_retorno OUT NOCOPY VARCHAR2,
			   					 sn_num_evento   OUT NOCOPY NUMBER)
 RETURN NUMBER
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_VERIFICAVERSION_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Verifica si un programa tiene la versión vigente</Retorno>
      <Descripcion>función que retorna 1:Si el el programa tiene versión vigente,
	                                   0:Si el la versión caduco</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="ev_cod_programa" Tipo="VARCHAR2">Codigo del programa</param>
            <param nom="en_num_version"  Tipo="NUMBER">número de la version</param>
            <param nom="en_sub_version"  Tipo="NUMBER">Número de sub versión</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS

    LN_EXISTEVERSION NUMBER :=0;

 BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    GV_SQL:='';
	GV_SQL:= 'SELECT COUNT(1) ';
	GV_SQL:= GV_SQL || ' FROM GE_PROGRAMAS ';
	GV_SQL:= GV_SQL || ' WHERE  A.cod_programa   = ' || EV_COD_PROGRAMA;
	GV_SQL:= GV_SQL || ' and    A.num_version    = ' || TO_CHAR(en_num_version);
	GV_SQL:= GV_SQL || ' and    A.num_subversion = ' || TO_CHAR(en_sub_version);
	GV_SQL:= GV_SQL || ' and ' || to_char(sysdate,GV_FORMATO_FECHAS) || ' between a.fec_desde_dh and A.fec_hasta_dh';

	SELECT COUNT(1)
	INTO   LN_EXISTEVERSION
	FROM   ge_programas A
	WHERE  A.cod_programa   = ev_cod_programa
	and    A.num_version    = en_num_version
	and    A.num_subversion = en_sub_version
	and    SYSDATE between A.FEC_DESDE_DH and A.FEC_HASTA_DH;

	IF LN_EXISTEVERSION > 0
	THEN
	    RETURN 1; -- TRUE
    ELSE
		RETURN 0; -- FALSE
	END IF;

 EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_COD_RETORNO := 2224; -- Versión no existe.

  	      IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	      END IF;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl(SN_num_evento, 'GE',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_VERIFICAVERSION_FN',
												   GV_SQL, SQLCODE, SQLERRM );
          RETURN 0; -- FALSE

     WHEN OTHERS THEN
          SN_COD_RETORNO := 2175; -- Error en Recupera Rol.

  	      IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	      END IF;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl(SN_num_evento, 'GE',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_VERIFICAVERSION_FN',
												   GV_SQL, SQLCODE, SQLERRM );
          RETURN 0; --FALSE
 END;


 PROCEDURE GE_REC_PARAM_FECHA_PR (ev_cod_modulo   IN ged_parametros.COD_MODULO%type,
	                              en_cod_producto IN ged_parametros.COD_PRODUCTO%type,
	                              SC_Fechas       OUT NOCOPY refCursor,
                                  SN_COD_RETORNO  OUT NOCOPY NUMBER,
							      SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
								  SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_REC_PARAM_FECHA_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Cursor con los parametros de fechas</Retorno>
      <Descripcion>Procedimiento que retorna un cursor con los parametros de fecha desde GED_PARAMTROS</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="ev_cod_modulo" Tipo="VARCHAR2">Codigo del modulo</param>
            <param nom="en_cod_producto"  Tipo="NUMBER">Código del producto</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 IS

 BEGIN

	SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
 	SN_num_evento := 0;

    GV_SQL:='';
 	GV_SQL := 'SELECT nom_parametro, val_parametro, des_parametro ';
 	GV_SQL := GV_SQL || ' FROM ged_parametros ';
 	GV_SQL := GV_SQL || ' WHERE cod_modulo = ' || ev_cod_modulo;
 	GV_SQL := GV_SQL || ' AND cod_producto = ' || en_cod_producto;
 	GV_SQL := GV_SQL || ' AND Nom_parametro in (FORMATO_SEL1, etc)';

	OPEN SC_Fechas FOR
		SELECT nom_parametro, val_parametro, des_parametro
		FROM   ged_parametros
		WHERE cod_modulo =  ev_cod_modulo
		AND cod_producto =  en_cod_producto
		AND Nom_parametro in ('FORMATO_SEL1', 'FORMATO_SEL2', 'FORMATO_SEL3', 'FORMATO_SEL4', 'FORMATO_SEL5', 'FORMATO_SEL6',
		'FORMATO_SEL7', 'FORMATO_SEL8', 'FORMATO_SEL9', 'FORMATO_SEL10','FORMATO_SEL11','FORMATO_SEL12',
		'FORMATO_SEL13','FORMATO_SEL14','FORMATO_SEL15','FORMATO_SEL18','FORMATO_SEL19','FORMATO_SEL20',
		'FORMATO_SEL21','FORMATO_SEL22','FORMATO_SEL23','FORMATO_SEL24','FORMATO_SEL25','FORMATO_SEL26',
		'FORMATO_SEL27','FORMATO_ING',	'FECHA_MAXIMA');

	EXCEPTION
      WHEN NO_DATA_FOUND THEN
           SN_COD_RETORNO := 2176; --Error No encuentra registros en parametros de fecha

  	       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	          SV_mens_retorno := GV_error_no_clasif;
 	       END IF;

  	       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                             SV_mens_retorno, 1.0, USER,
				     							     'GE_SISTEMA_PG.GE_REC_PARAM_FECHA_PR',
												     GV_SQL, SQLCODE, SQLERRM );

      WHEN OTHERS THEN
           SN_COD_RETORNO := 2177; --Error al intentar recuperar parametros de fecha

  	       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	          SV_mens_retorno := GV_error_no_clasif;
 	       END IF;

  	       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                             SV_mens_retorno, 1.0, USER,
												    'GE_SISTEMA_PG.GE_REC_PARAM_FECHA_PR',
												     GV_SQL, SQLCODE, SQLERRM );

 END;


 PROCEDURE GE_OBT_CONF_INTERNACIONAL_PR(ev_cod_modulo   IN  ged_parametros.COD_MODULO%type,
	                                    en_cod_producto IN  ged_parametros.COD_PRODUCTO%type,
	                                    SC_Param        OUT NOCOPY refCursor,
                                        SN_COD_RETORNO  OUT NOCOPY NUMBER,
							            SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
								        SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_OBT_CONF_INTERNACIONAL_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Cursor con los parametros internacionales</Retorno>
      <Descripcion>Procedimiento que retorna un cursor con los parametros Internacionales de GED_PARAMTROS</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="ev_cod_modulo" Tipo="VARCHAR2">Codigo del modulo</param>
            <param nom="en_cod_producto"  Tipo="NUMBER">Código del producto</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 IS

 BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
 	SN_num_evento := 0;

    GV_SQL:='';
	GV_SQL := 'SELECT   B.NOM_PARAM, A.NOM_PARAMETRO, A.VAL_PARAMETRO, A.DES_PARAMETRO';
  	GV_SQL := GV_SQL || ' FROM     GED_PARAMETROS A,';
	GV_SQL := GV_SQL || ' 		  (';
	GV_SQL := GV_SQL || ' 		       SELECT "NUM_DECIMAL" NOM_PARAM FROM DUAL UNION';
	GV_SQL := GV_SQL || '              SELECT "SEP_MILES_MONTOS" NOM_PARAM FROM DUAL UNION';
	GV_SQL := GV_SQL || '              SELECT "SEP_DECIMALES_MONTOS" NOM_PARAM FROM DUAL UNION';
	GV_SQL := GV_SQL || '       	   SELECT "SEP_DECIMALES_ORACLE"  NOM_PARAM FROM DUAL UNION';
	GV_SQL := GV_SQL || '       	   SELECT "FORMATO_N_CELULAR" NOM_PARAM FROM DUAL UNION';
	GV_SQL := GV_SQL || '       	   SELECT "LARGO_N_CELULAR" NOM_PARAM FROM DUAL UNION';
	GV_SQL := GV_SQL || '       	   SELECT "IDIOMA_INST_ORA8I" NOM_PARAM FROM DUAL UNION';
	GV_SQL := GV_SQL || '       	   SELECT "NUM_DECIMAL_FACT" NOM_PARAM FROM DUAL';
	GV_SQL := GV_SQL || '  		   ) B';
	GV_SQL := GV_SQL || '  		WHERE A.COD_MODULO(+) = ' || Ev_cod_modulo;
	GV_SQL := GV_SQL || '  		AND   A.COD_PRODUCTO(+) = ' || En_cod_producto;
	GV_SQL := GV_SQL || '  		AND   A.NOM_PARAMETRO(+) = B.NOM_PARAM ';

	OPEN SC_Param FOR
		SELECT   A.NOM_PARAMETRO, A.VAL_PARAMETRO, A.DES_PARAMETRO
		FROM     GED_PARAMETROS A,
		  (
		   SELECT 'NUM_DECIMAL'          NOM_PARAM FROM DUAL UNION
      	   SELECT 'SEP_MILES_MONTOS'     NOM_PARAM FROM DUAL UNION
      	   SELECT 'SEP_DECIMALES_MONTOS' NOM_PARAM FROM DUAL UNION
      	   SELECT 'SEP_DECIMALES_ORACLE' NOM_PARAM FROM DUAL UNION
      	   SELECT 'FORMATO_N_CELULAR'    NOM_PARAM FROM DUAL UNION
      	   SELECT 'LARGO_N_CELULAR'      NOM_PARAM FROM DUAL UNION
      	   SELECT 'IDIOMA_INST_ORA8I'    NOM_PARAM FROM DUAL UNION
      	   SELECT 'NUM_DECIMAL_FACT'     NOM_PARAM FROM DUAL
 		   ) B
 		WHERE A.COD_MODULO(+) = ev_cod_modulo
 		AND   A.COD_PRODUCTO(+) = en_cod_producto
 		AND   A.NOM_PARAMETRO(+) = B.NOM_PARAM;

 EXCEPTION
   WHEN NO_DATA_FOUND THEN
        SN_COD_RETORNO := 2178; -- No encuentra registros en Configuración Internacional

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_OBT_CONF_INTERNACIONAL_PR',
												  GV_SQL, SQLCODE, SQLERRM );

   WHEN OTHERS THEN
        SN_COD_RETORNO := 2179; -- Error al recuperar Configuración Internacional

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_OBT_CONF_INTERNACIONAL_PR',
												  GV_SQL, SQLCODE, SQLERRM );

 END;


 FUNCTION GE_OBTENER_LETRA_FN (en_cod_tipdocum IN ge_letras.COD_TIPDOCUM%type,
			   				   en_cod_catimpos IN ge_letras.COD_CATIMPOS%type,
 			   				   sn_cod_retorno  OUT NOCOPY NUMBER,
			   				   sv_mens_retorno OUT NOCOPY VARCHAR2,
			   				   sn_num_evento   OUT NOCOPY NUMBER)
RETURN VARCHAR2
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_OBTENER_LETRA_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Letra para el tipo de documento y la categoria impositiva ingresada</Retorno>
      <Descripcion>Función que retorna la Letra que le corresponde a la Categoria y Documentos ingresados</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="en_cod_tipdocum" Tipo="NUMBER">Codigo del tipo de documento</param>
            <param nom="en_cod_catimpos"  Tipo="NUMBER">Código de la categoria impositiva</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS

    LV_Letra VARCHAR2(1);

 BEGIN
    LV_Letra:='';
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    GV_SQL:='';
 	GV_SQL:= 'SELECT LETRA ';
	GV_SQL:= GV_SQL || 'FROM GE_LETRAS ';
	GV_SQL:= GV_SQL || 'WHERE ';
	GV_SQL:= GV_SQL || '     COD_TIPDOCUM = ' || en_cod_tipdocum;
	GV_SQL:= GV_SQL || ' AND COD_CATIMPOS = ' || en_cod_catimpos;

	SELECT LETRA
	INTO   LV_Letra
	FROM   GE_LETRAS
	WHERE  COD_TIPDOCUM = en_cod_tipdocum
	AND    COD_CATIMPOS = en_cod_catimpos;

    RETURN LV_Letra;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 2180; -- NO FOUND

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GE',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_OBTENER_LETRA_FN',
												   GV_SQL, SQLCODE, SQLERRM );
         RETURN NULL;

    WHEN OTHERS THEN
         SN_COD_RETORNO := 2181; -- Error en Recupera Rol.

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(sn_cod_retorno,sv_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GE',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_OBTENER_LETRA_FN',
												   GV_SQL, SQLCODE, SQLERRM );
         RETURN NULL;

 END;


FUNCTION GE_VALIDA_FECHA_VCTO_FN (ev_fecha_vencimiento IN VARCHAR2,
 			                      SN_COD_RETORNO       OUT NOCOPY NUMBER,
			                      SV_MENS_RETORNO      OUT NOCOPY VARCHAR2,
			                      SN_NUM_EVENTO        OUT NOCOPY NUMBER)
RETURN NUMBER
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_VALIDA_FECHA_VCTO_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Retorna 1:Si la fecha de vencimiento es válida
	                   0:Si la fecha de vencimiento esta fuera de rango</Retorno>
      <Descripcion>Función que valida si la fecha de vencimiento ingresada se encuentra en rango
	               valido que es entre la fecha de hoy y la fecha máxima de vencimiento</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="ev_fecha_vencimiento" Tipo="VARCHAR2">Fecha de vencimiento</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    Ld_fecha_vencimiento DATE;
	LD_FECHAVENCIMIENTO  DATE;

 BEGIN

    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

	LD_FECHAVENCIMIENTO := TO_DATE(EV_FECHA_VENCIMIENTO,GV_FORMATO_FECHAS);

    GV_SQL :='';
    GV_SQL := 'SELECT SYSDATE + B.DIAS_VENCIMIENTO ';
	GV_SQL := GV_SQL || 'FROM DUAL A, FA_DATOSGENER B ';

    SELECT SYSDATE + B.DIAS_VENCIMIENTO
	INTO   LD_FECHA_VENCIMIENTO
	FROM   DUAL A, FA_DATOSGENER B;

	IF  TRUNC(LD_FECHAVENCIMIENTO) BETWEEN TRUNC(SYSDATE) AND TRUNC(LD_FECHA_VENCIMIENTO) THEN
		RETURN 1; -- TRUE
	ELSE
		RETURN 0; -- FALSE
	END IF;

 EXCEPTION
    WHEN OTHERS THEN
         SN_COD_RETORNO := 2173;

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, 1.0, USER, 'GE_SISTEMA_PG.GE_VALIDA_FECHA_VCTO_FN', GV_SQL, SQLCODE, SQLERRM );
	     RETURN 0; -- FALSE

 END;


FUNCTION GE_RECUPERAR_FECHA_SISTEMA_FN (SN_COD_RETORNO  OUT NOCOPY NUMBER,
			   						    SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			   						    SN_NUM_EVENTO   OUT NOCOPY NUMBER)
 RETURN VARCHAR2
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_RECUPERAR_FECHA_SISTEMA_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Retorna Fecha de Sistema</Retorno>
      <Descripcion>Función que retorna la fecha del sistema con formato predeterminado por constate GV_FORMATO_FECHAS</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    Lv_Fecha_Sistema varchar2(30);

 BEGIN
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    Lv_Fecha_Sistema := NULL;

    GV_SQL :='';
    GV_SQL := 'SELECT to_char(SYSDATE, GV_FORMATO_FECHAS)';
    GV_SQL := GV_SQL || 'FROM DUAL ';

    SELECT to_char(SYSDATE, GV_FORMATO_FECHAS)
	INTO   Lv_Fecha_Sistema
	FROM   DUAL;

    RETURN Lv_Fecha_Sistema;

 EXCEPTION
    WHEN OTHERS THEN
         SN_COD_RETORNO := 2229; -- Error al Recuperar Fecha del Sistema

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_RECUPERAR_FECHA_SISTEMA_FN',
												   GV_SQL, SQLCODE, SQLERRM );
	     RETURN NULL;

 END;


FUNCTION GE_VALIDA_MONEDA_FN (ev_cod_moneda   IN GE_MONEDAS.COD_MONEDA%type,
 			                  SN_COD_RETORNO  OUT NOCOPY NUMBER,
			                  SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			                  SN_NUM_EVENTO   OUT NOCOPY NUMBER) RETURN NUMBER
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_VALIDA_MONEDA_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Retorna 1:Si la moneda es  válida
	                   0:Si la moneda no es valida</Retorno>
      <Descripcion>Función que valida si el Código de moneda ingresado es valido</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="ev_cod_moneda" Tipo="VARCHAR2">Código de moneda</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    Ln_Valida number;

 BEGIN
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    GV_SQL:='';
    GV_SQL := 'SELECT count(1) ';
	GV_SQL := GV_SQL || 'FROM GE_MONEDAS ';
	GV_SQL := GV_SQL || 'WHERE COD_MONEDA = ' || ev_cod_moneda;

    SELECT count(1)
	INTO   Ln_Valida
	FROM   GE_MONEDAS
	WHERE  COD_MONEDA = ev_cod_moneda;

    RETURN Ln_Valida;

 EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_RETORNO := 1050; -- Moneda no existe

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_VALIDA_MONEDA_FN',
												   GV_SQL, SQLCODE, SQLERRM );
	     RETURN 0;

    WHEN OTHERS THEN
         SN_COD_RETORNO := 2183; -- Error en recuperar Moneda

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_VALIDA_MONEDA_FN',
												   GV_SQL, SQLCODE, SQLERRM );
	     RETURN 0;

 END;

FUNCTION GE_VALIDAMODVENTA_FN (EN_COD_MODVENTA IN GE_MODVENTA.COD_MODVENTA%TYPE,
		 					 SN_COD_RETORNO  OUT NOCOPY NUMBER,
			   			     SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			   				 SN_NUM_EVENTO   OUT NOCOPY NUMBER)
 RETURN NUMBER
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_VALIDA_VENTA_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Retorna un valor lógico para determina si el codigo de la venta existe o no</Retorno>
      <Descripcion>Función que retorna 1:Si Código de la venta existe en la tabla GE_MODVENTA
	                                   0:Si el código no existe.</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_COD_MODVENTA" Tipo="NUMBER">Código de venta</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    Ln_valida NUMBER;

 BEGIN
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    Ln_valida := 0;

    GV_SQL :='';
    GV_SQL := 'SELECT COUNT(1)';
    GV_SQL := GV_SQL || 'FROM GE_MODVENTA ';
    GV_SQL := GV_SQL || 'WHERE ';
    GV_SQL := GV_SQL || '  COD_MODVENTA = ' || EN_COD_MODVENTA;

	 SELECT COUNT(1)
	 INTO   Ln_valida
	 FROM   GE_MODVENTA
	 WHERE
	    COD_MODVENTA  = EN_COD_MODVENTA;

    RETURN Ln_valida;

 EXCEPTION
    WHEN OTHERS THEN
         SN_COD_RETORNO := 2280; -- Error al validar el código de la venta

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_VALIDA_VENTA_FN',
												   GV_SQL, SQLCODE, SQLERRM );
	     RETURN 0;

 END;

 PROCEDURE GE_PERIODOCONTABLE_PR(EV_FechaSistema    IN  VARCHAR2,
	                             SV_ESTADO_PERIODO  OUT VARCHAR2,
	                             SN_COD_RETORNO    OUT NOCOPY NUMBER,
							     SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
								 SN_NUM_EVENTO     OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_PERIODOCONTABLE_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Variable SV_ESTADO_PERIODO con el estado del periodo </Retorno>
      <Descripcion>Procedimiento que retorna el estado del periodo para la fecha ingresada</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EV_FechaSistema" Tipo="VARCHAR2">Fecha del sistema</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 IS
 LV_PERIODO VARCHAR2(10);
 LV_ESTADOPER VARCHAR(3);

 BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
 	SN_num_evento := 0;
    SV_ESTADO_PERIODO := NULL;

    GV_SQL:='';
	GV_SQL := 'SELECT COD_ESTADO ';
	GV_SQL := GV_SQL || 'FROM   FA_PERCONTABLE ';
	GV_SQL := GV_SQL || 'WHERE ';
	GV_SQL := GV_SQL || 'COD_PERCONTAB = LV_PERIODO';

	SELECT to_char(to_date(EV_FechaSistema,'DDMMYYYYHH24MISS'), 'YYYYMM')
	INTO   LV_PERIODO
	FROM dual;

	dbms_output.put_line('PERIODO: ' || LV_PERIODO);

	SELECT COD_ESTADO
	INTO   LV_ESTADOPER
	FROM   FA_PERCONTABLE
	WHERE
	   COD_PERCONTAB = LV_PERIODO;

	SV_ESTADO_PERIODO := LV_ESTADOPER;

 EXCEPTION
   WHEN NO_DATA_FOUND THEN
        SN_COD_RETORNO := 2281; -- No encuentra el Periodo Contable

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_PERIODOCONTABLE_PR',
												  GV_SQL, SQLCODE, SQLERRM );

   WHEN OTHERS THEN
        SN_COD_RETORNO := 2282; -- Error en la consulta al Periodo Contable

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_PERIODOCONTABLE_PR',
												  GV_SQL, SQLCODE, SQLERRM );
 END;

 PROCEDURE GE_RECPARAMGENER_PR (ev_cod_modulo      IN ged_parametros.COD_MODULO%type,
	                            en_cod_producto    IN ged_parametros.COD_PRODUCTO%type,
								ev_nom_parametro   IN ged_parametros.NOM_PARAMETRO%type,
	                            Sv_val_parametro  OUT NOCOPY VARCHAR2,
								Sv_des_parametro  OUT NOCOPY VARCHAR2,
                                SN_COD_RETORNO    OUT NOCOPY NUMBER,
							    SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
								SN_NUM_EVENTO     OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_RECPARAMFECHA_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Valor y descripción del parametro de fecha ingresado</Retorno>
      <Descripcion>Procedimiento que retorna los parametros de fecha desde GED_PARAMTROS</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="ev_cod_modulo" Tipo="VARCHAR2">Codigo del modulo</param>
            <param nom="en_cod_producto"  Tipo="NUMBER">Código del producto</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 IS
 Lv_val_parametro ged_parametros.VAL_PARAMETRO%type;
 Lv_des_parametro ged_parametros.DES_PARAMETRO%type;

 BEGIN

	SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
 	SN_num_evento := 0;

    GV_SQL:='';
 	GV_SQL := 'SELECT val_parametro, des_parametro ';
 	GV_SQL := GV_SQL || ' FROM ged_parametros ';
 	GV_SQL := GV_SQL || ' WHERE cod_modulo = ' || ev_cod_modulo;
 	GV_SQL := GV_SQL || ' AND cod_producto = ' || en_cod_producto;
 	GV_SQL := GV_SQL || ' AND Nom_parametro = ' || ev_nom_parametro;

		SELECT val_parametro, des_parametro
		INTO   Lv_val_parametro, Lv_des_parametro
		FROM   ged_parametros
		WHERE cod_modulo =  ev_cod_modulo
		AND   cod_producto =  en_cod_producto
		AND   Nom_parametro = ev_nom_parametro;

		Sv_val_parametro := Lv_val_parametro;
		Sv_des_parametro := Lv_des_parametro;

	EXCEPTION
      WHEN NO_DATA_FOUND THEN
           SN_COD_RETORNO := 2176; --Error No encuentra registros en parametros de fecha

  	       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	          SV_mens_retorno := GV_error_no_clasif;
 	       END IF;

  	       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                             SV_mens_retorno, 1.0, USER,
				     							     'GE_SISTEMA_PG.GE_RECPARAMFECHA_PR',
												     GV_SQL, SQLCODE, SQLERRM );

      WHEN OTHERS THEN
           SN_COD_RETORNO := 2177; --Error al intentar recuperar parametros de fecha

  	       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	          SV_mens_retorno := GV_error_no_clasif;
 	       END IF;

  	       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                             SV_mens_retorno, 1.0, USER,
												    'GE_SISTEMA_PG.GE_RECPARAMFECHA_PR',
												     GV_SQL, SQLCODE, SQLERRM );

 END;

 PROCEDURE GE_RECDATOSGENER_PR ( SN_COD_MISCELA  OUT FA_DATOSGENER.COD_MISCELA%TYPE,
 		   						 SV_COD_MONEFACT OUT FA_DATOSGENER.COD_MONEFACT%TYPE,
	                             SN_COD_RETORNO  OUT NOCOPY NUMBER,
							     SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
								 SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_RECDATOSGENER_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Recupera cod.documento de la factura miscelanea y moneda</Retorno>
      <Descripcion>Procedimiento que retorna cod.documento de la factura miscelanea y meneda</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 IS
  LN_COD_MISCELA FA_DATOSGENER.COD_MISCELA%TYPE;
  LV_COD_MONEFACT FA_DATOSGENER.COD_MONEFACT%TYPE;

 BEGIN
	SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
 	SN_num_evento := 0;

    GV_SQL:='';
	GV_SQL := 'SELECT COD_MISCELA, COD_MONEFACT ';
	GV_SQL := GV_SQL || 'FROM FA_DATOSGENER ';


	SELECT COD_MISCELA, COD_MONEFACT
	INTO   LN_COD_MISCELA, LV_COD_MONEFACT
	FROM FA_DATOSGENER;

	SN_COD_MISCELA  := LN_COD_MISCELA;
	SV_COD_MONEFACT := LV_COD_MONEFACT;

 EXCEPTION
   WHEN NO_DATA_FOUND THEN
        SN_COD_RETORNO := 2297; -- Registro en datos generales no existe

	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_RECDATOSGENER_PR',
												  GV_SQL, SQLCODE, SQLERRM );

   WHEN OTHERS THEN
        SN_COD_RETORNO := 1362; -- No es posible recuperar parametros generales

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_RECDATOSGENER_PR',
												  GV_SQL, SQLCODE, SQLERRM );
 END;

PROCEDURE GE_RECCENTREMI_PR ( EN_COD_OFICINA   IN  AL_DOCUM_SUCURSAL.COD_OFICINA%TYPE,
		 				      EN_COD_TIPDOCUM  IN  AL_DOCUM_SUCURSAL.COD_TIPDOCUM%TYPE,
							  SN_COD_CENTREMI  OUT AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE,
		 					  SN_COD_RETORNO   OUT NOCOPY NUMBER,
			   			      SV_MENS_RETORNO  OUT NOCOPY VARCHAR2,
			   				  SN_NUM_EVENTO    OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GE_RECCENTREMI_FN"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Retorna el código del centro de emisión</Retorno>
      <Descripcion>Procedimiento que el número del centro de emisión</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_COD_MODVENTA" Tipo="NUMBER">Código de venta</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    Ln_cod_centremi AL_DOCUM_SUCURSAL.COD_CENTREMI%TYPE;

 BEGIN
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    GV_SQL :='';
    GV_SQL := 'SELECT COD_CENTREMI';
    GV_SQL := GV_SQL || 'FROM   AL_DOCUM_SUCURSAL ';
    GV_SQL := GV_SQL || 'WHERE  COD_OFICINA  = ' || EN_COD_OFICINA;
    GV_SQL := GV_SQL || '  AND  COD_TIPDOCUM = ' || EN_COD_TIPDOCUM;

	SELECT COD_CENTREMI
	INTO   Ln_cod_centremi
	FROM   AL_DOCUM_SUCURSAL
	WHERE  COD_OFICINA = EN_COD_OFICINA
	  AND  COD_TIPDOCUM = EN_COD_TIPDOCUM;

	SN_COD_CENTREMI:= Ln_cod_centremi;

 EXCEPTION
   WHEN NO_DATA_FOUND THEN
        SN_COD_RETORNO := 2299; -- Centro de emisión no existe

		IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_RECCENTREMI_PR',
												  GV_SQL, SQLCODE, SQLERRM );

   WHEN OTHERS THEN
        SN_COD_RETORNO := 2301; -- Error no es posible recuperar Centro de Emisión.

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_RECCENTREMI_PR',
												  GV_SQL, SQLCODE, SQLERRM );
 END;

PROCEDURE GE_RECMODGENER_PR ( EV_COD_CATRIBUT    IN  FA_GENCENTREMI.COD_CATRIBUT%TYPE,
		 				      EV_COD_MODVENTA    IN  FA_GENCENTREMI.COD_MODVENTA%TYPE,
							  EN_COD_CENTREMI    IN  FA_GENCENTREMI.COD_CENTREMI%TYPE,
							  EN_COD_TIPMOVIMIEN IN  FA_GENCENTREMI.COD_TIPMOVIMIEN%TYPE,
							  SV_COD_MODGENER    OUT FA_GENCENTREMI.COD_MODGENER%TYPE,
		 					  SN_COD_RETORNO     OUT NOCOPY NUMBER,
			   			      SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
			   				  SN_NUM_EVENTO      OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GE_RECMODGENER_PR
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Retorna el código del modo de generación</Retorno>
      <Descripcion>Procedimiento que retorna modo de generación</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom=</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    LV_COD_MODGENER FA_GENCENTREMI.COD_MODGENER%TYPE;

 BEGIN
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    GV_SQL :='';
    GV_SQL := 'SELECT a.COD_MODGENER ';
    GV_SQL := GV_SQL || 'FROM  FA_GENCENTREMI a ';
    GV_SQL := GV_SQL || 'WHERE a.COD_CENTREMI = ' || EN_COD_CENTREMI || ' AND ';
    GV_SQL := GV_SQL || 'a.COD_TIPMOVIMIEN = ' || EN_COD_TIPMOVIMIEN || ' AND ';
    GV_SQL := GV_SQL || 'a.COD_CATRIBUT = ' || EV_COD_CATRIBUT || ' AND ';
    GV_SQL := GV_SQL || 'a.COD_MODVENTA = ' || EV_COD_MODVENTA || ' AND ';
    GV_SQL := GV_SQL || 'a.TIP_FOLIACION IN (SELECT b.TIP_FOLIACION FROM GE_TIPDOCUMEN b ';
    GV_SQL := GV_SQL || 'WHERE b.COD_TIPDOCUM =(SELECT  c.COD_TIPDOCUM ';
    GV_SQL := GV_SQL || 'FROM FA_TIPDOCUMEN c ';
    GV_SQL := GV_SQL || 'WHERE c.COD_TIPDOCUMMOV = '  || EN_COD_TIPMOVIMIEN || '))';

	SELECT a.COD_MODGENER
	INTO  LV_COD_MODGENER
	FROM  FA_GENCENTREMI a
	WHERE a.COD_CENTREMI = EN_COD_CENTREMI AND
	      a.COD_TIPMOVIMIEN = EN_COD_TIPMOVIMIEN AND
		  a.COD_CATRIBUT = EV_COD_CATRIBUT AND
		  a.COD_MODVENTA = EV_COD_MODVENTA AND
   		  a.TIP_FOLIACION IN (SELECT b.TIP_FOLIACION FROM GE_TIPDOCUMEN b
                              WHERE b.COD_TIPDOCUM =(SELECT  c.COD_TIPDOCUM
                                                     FROM FA_TIPDOCUMEN c
                                                     WHERE c.COD_TIPDOCUMMOV = EN_COD_TIPMOVIMIEN));

	SV_COD_MODGENER := LV_COD_MODGENER;

 EXCEPTION
   WHEN NO_DATA_FOUND THEN
        SN_COD_RETORNO := 2302; -- Modo Generación no existe.

        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_RECMODGENER_PR',
												  GV_SQL, SQLCODE, SQLERRM );

   WHEN OTHERS THEN
        SN_COD_RETORNO := 2303; -- Error en la consulta Modo de Generación

  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_RECMODGENER_PR',
												  GV_SQL, SQLCODE, SQLERRM );
 END;

PROCEDURE GE_OBTENERCAMBIO_PR ( EN_COD_MONEDA   IN GE_CONVERSION.COD_MONEDA%TYPE,
		 					    EV_FECHAINGRESO  IN VARCHAR2,
							    SN_CAMBIO       OUT GE_CONVERSION.CAMBIO%TYPE,
		 					    SN_COD_RETORNO  OUT NOCOPY NUMBER,
			   			        SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
			   				    SN_NUM_EVENTO   OUT NOCOPY NUMBER)
/*
<Documentacion
  TipoDoc = Función">
   <Elemento
      Nombre = "GE_OBTENERCAMBIO_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="25-09-2008"
      Creado por="Marisol Caballero"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>Retorna el cambio de conversión</Retorno>
      <Descripcion>Procedimiento que retorna el cambio de conversión</Descripcion>
      <Parámetros>
          <Entrada>
            <param nom="EN_COD_MONEDA" Tipo="NUMBER">Código de moneda</param>
            <param nom="EV_FECHAINGRESO" Tipo="VARCHAR2">Código fecha de ingreso</param>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 AS
    LD_FECHA_INGRESO DATE;
    LN_CAMBIO GE_CONVERSION.CAMBIO%TYPE;

 BEGIN
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;


	LD_FECHA_INGRESO:=TO_DATE(EV_FECHAINGRESO, GV_FORMATO_FECHAS);

    GV_SQL :='SELECT CAMBIO ';
    GV_SQL := GV_SQL || 'FROM  GE_CONVERSION ';
    GV_SQL := GV_SQL || 'WHERE COD_MONEDA = ' || EN_COD_MONEDA || ' AND ';
    GV_SQL := GV_SQL || LD_FECHA_INGRESO || '  BETWEEN FEC_DESDE AND FEC_HASTA';

    SELECT CAMBIO
 	INTO   LN_CAMBIO
 	FROM   GE_CONVERSION
 	WHERE  COD_MONEDA = EN_COD_MONEDA
	AND    LD_FECHA_INGRESO BETWEEN FEC_DESDE AND FEC_HASTA;

	SN_CAMBIO := LN_CAMBIO;

 EXCEPTION
   WHEN NO_DATA_FOUND THEN
        SN_COD_RETORNO := 2304; -- Cambio en Conversión no existe

        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := GV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                          SV_mens_retorno, 1.0, USER,
												  'GE_SISTEMA_PG.GE_OBTENERCAMBIO_PR',
												  GV_SQL, SQLCODE, SQLERRM );
    WHEN OTHERS THEN
         SN_COD_RETORNO := 2305; -- Error al recuperar Cambio en Conversión

  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	        SV_mens_retorno := GV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA',
		                                           SV_mens_retorno, 1.0, USER,
												   'GE_SISTEMA_PG.GE_OBTENERCAMBIO_PR',
												   GV_SQL, SQLCODE, SQLERRM );

 END;

END;
/
SHOW ERRORS