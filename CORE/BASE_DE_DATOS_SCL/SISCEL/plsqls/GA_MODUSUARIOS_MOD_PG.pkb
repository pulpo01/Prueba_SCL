CREATE OR REPLACE PACKAGE BODY GA_MODUSUARIOS_MOD_PG AS

CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

PROCEDURE GA_RECUPERA_USUARIO_CEL_PR (EN_num_celular IN ga_abocel.cod_usuario%type,
                                    SV_COD_USUARIO OUT NOCOPY ga_abocel.cod_usuario%type,
									SV_ORIGEN OUT NOCOPY varchar2,
									SN_COD_RETORNO OUT NOCOPY NUMBER,
									SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
									SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_RECUPERA_USUARIO_CEL_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);

  BEGIN
    SN_COD_RETORNO := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    lv_sql := 'SELECT B.NOM_USUARIO FROM GA_ABOAMIST A	WHERE NUM_CELULAR = ' || en_num_celular || ' AND COD_SITUACION NOT IN (BAP,BAA)';

	SELECT A.COD_USUARIO, 'PRE'
	INTO sv_cod_usuario, sv_origen
	FROM GA_ABOAMIST A
	WHERE a.NUM_CELULAR = en_num_celular
	AND a.COD_SITUACION NOT IN ('BAP','BAA')
	UNION
	SELECT B.COD_USUARIO, 'POS'
	FROM GA_ABOCEL B
	WHERE B.NUM_CELULAR = en_num_celular
	AND B.COD_SITUACION NOT IN ('BAP','BAA');

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       SV_COD_USUARIO := NULL;
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1943; -- --10 Error al recuperar usuario asociado al nro. de celular
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODUSUARIOS_MOD_PG.GA_RECUPERA_USUARIO_CEL_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE GA_RECUPERA_DATOS_USUA_PREP_PR (ST_USUARIO IN OUT NOCOPY ga_usuamist%ROWtype,
                                            SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_RECUPERA_DATOS_USUA_PREP_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);

  BEGIN
    SN_COD_RETORNO := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    lv_sql := 'SELECT cod_usuario, email, cod_causa  FROM GA_USUAMIST A	WHERE a.cod_usuario =' || st_usuario.cod_usuario;

	SELECT cod_usuario, email
	INTO ST_USUARIO.cod_usuario, st_usuario.email
	FROM GA_USUAMIST A
	WHERE a.cod_usuario = st_usuario.cod_usuario;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       ST_USUARIO := NULL;
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1944; -- --20 Error al recuperar datos del usuario prepago
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODUSUARIOS_MOD_PG.GA_RECUPERA_DATOS_USUA_PREP_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE GA_RECUPERA_DATOS_USUA_POST_PR (ST_USUARIO IN OUT NOCOPY ga_usuarios%ROWtype,
                                          SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_RECUPERA_DATOS_USUA_POST_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);

  BEGIN
    SN_COD_RETORNO := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    lv_sql := 'SELECT cod_usuario, email, cod_causa  FROM GA_USUAMIST A	WHERE a.cod_usuario =' || st_usuario.cod_usuario;

	SELECT cod_usuario, email
	INTO ST_USUARIO.cod_usuario, st_usuario.email
	FROM GA_USUARIOS A
	WHERE a.cod_usuario = st_usuario.cod_usuario;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       ST_USUARIO := NULL;
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1945; -- --21 Error al recuperar datos del usuario postpago
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODUSUARIOS_MOD_PG.GA_RECUPERA_DATOS_USUA_POST_PR', lv_sql, SQLCODE, SQLERRM );
  END;

 PROCEDURE GA_ACTUALIZA_DATOS_USUA_POS_PR (ST_USUARIO IN OUT NOCOPY ga_usuarios%ROWtype,
                                          SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_ACTUALIZA_DATOS_USUA_POS_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);

  BEGIN
    SN_COD_RETORNO := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    lv_sql := 'SELECT cod_usuario, email, cod_causa  FROM GA_USUAMIST A	WHERE a.cod_usuario =' || st_usuario.cod_usuario;

	UPDATE  GA_USUARIOS
	SET email = st_usuario.email
	WHERE cod_usuario = st_usuario.cod_usuario;

  EXCEPTION
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1946; -- --30 Error al actualizar e-mail del usuario postpago
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODUSUARIOS_MOD_PG.GA_ACTUALIZA_DATOS_USUA_POS_PR', lv_sql, SQLCODE, SQLERRM );
  END;

 PROCEDURE GA_ACTUALIZA_DATOS_USUA_PRE_PR (ST_USUARIO IN OUT NOCOPY ga_usuamist%ROWtype,
                                          SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_ACTUALIZA_DATOS_USUA_PRE_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);

  BEGIN
    SN_COD_RETORNO := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    lv_sql := 'SELECT cod_usuario, email, cod_causa  FROM GA_USUAMIST A	WHERE a.cod_usuario =' || st_usuario.cod_usuario;

	UPDATE  GA_USUAMIST
	SET email = st_usuario.email
	WHERE cod_usuario = st_usuario.cod_usuario;

  EXCEPTION
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1947; -- -40 Error al actualizar e-mail del usuario prepago
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODUSUARIOS_MOD_PG.GA_ACTUALIZA_DATOS_USUA_PRE_PR', lv_sql, SQLCODE, SQLERRM );
  END;

  PROCEDURE GA_INSERTA_MODIF_USUARIO_PR (ET_MODUSUARIO IN ga_modusuarios%ROWtype,
                                       SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_INSERTA_MODIF_USUARIO_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>recupera datos de cliente en facturacion</Descripcion>
      <Parámetros>
          <Entrada>

         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(1000);

  BEGIN
    SN_COD_RETORNO := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    lv_sql := 'INSERT INTO GA_MODUSUARIOS ';

	INSERT INTO GA_MODUSUARIOS VALUES ET_MODUSUARIO;

  EXCEPTION
    WHEN OTHERS THEN
	    SN_COD_RETORNO := 1948; -- -50 Error al registrar modificaciones del usuario
  	    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	         SV_mens_retorno := CV_error_no_clasif;
 	    END IF;

  	    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODUSUARIOS_MOD_PG.GA_INSERTA_MODIF_USUARIO_PR', lv_sql, SQLCODE, SQLERRM );
  END;
END;
/
SHOW ERRORS
