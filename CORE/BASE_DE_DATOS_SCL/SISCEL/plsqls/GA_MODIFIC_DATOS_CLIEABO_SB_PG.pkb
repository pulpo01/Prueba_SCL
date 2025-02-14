CREATE OR REPLACE PACKAGE BODY Ga_Modific_Datos_Clieabo_Sb_Pg AS

 CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

 PROCEDURE GA_VALIDA_DATOS_PR ( EV_cod_causa IN GA_MODCLI.cod_causa%TYPE,
								EV_nom_usuario IN VARCHAR2,
								EV_cod_actabo IN ga_actabo.cod_actabo%TYPE,
                                 SN_cod_retorno OUT NOCOPY NUMBER, SV_mens_retorno OUT NOCOPY VARCHAR2, SN_num_evento OUT NOCOPY NUMBER)
 AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_VALIDA_DATOS_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion></Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  ERROR_CONTROLADO EXCEPTION;
  ERROR_VALIDACION EXCEPTION;

  LV_sql VARCHAR2(1000);
  ln_cantidad NUMBER;
 BEGIN
    SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
	SN_num_evento := 0;

	LV_sql:='GE_SEG_USUARIO_SP_PG.GE_EXISTE_PR';
    Ge_Seg_Usuario_Mod_Pg.GE_EXISTE_PR( EV_nom_usuario, ln_cantidad, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	IF LN_cantidad != 1 THEN
	   sn_cod_retorno := 1953; -- -100 Usuario informado no está registrado en SCL 50
	   RAISE ERROR_VALIDACION;
	END IF;

    ln_cantidad:= 0;
	LV_sql:='GA_CAUSALESMODIFICACION_SP_PG.GE_EXISTE_PR';
    Ga_Causalesmodificacion_Mod_Pg.GA_EXISTE_PR( EV_cod_causa, SYSDATE, ln_cantidad, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	IF LN_cantidad != 1 THEN
	   sn_cod_retorno := 1955; --200 Código de causal de modificación no está Activa o no está registrada en SCL 52
	   RAISE ERROR_VALIDACION;
	END IF;

	ln_cantidad:= 0;
	LV_sql:='GA_ACTABO_SP_PG.GA_EXISTE_PR';
    Ga_Actabo_Mod_Pg.ga_existe_pr( ev_cod_actabo, ln_cantidad, sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	IF LN_cantidad < 1 THEN
	   sn_cod_retorno := 1976;
	   RAISE ERROR_VALIDACION;
	END IF;

  EXCEPTION
      WHEN ERROR_CONTROLADO THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_VALIDA_DATOS_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

      WHEN ERROR_VALIDACION THEN
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_VALIDA_DATOS_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

      WHEN OTHERS THEN
         SN_COD_RETORNO := 1957; -- -300 Error en proceso de validación de parámetros.
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_VALIDA_DATOS_PR', lv_sql, SQLCODE, SQLERRM );

 END;


 PROCEDURE GA_MODIFICA_DATOS_CLIE_PR (EN_cod_cliente IN GE_CLIENTES.cod_cliente%TYPE,
                                   EV_nom_email IN GE_CLIENTES.nom_email%TYPE,
								   EV_ind_fact_Elect IN GE_CLIENTES.ind_facturaelectronica%TYPE,
								   EV_cod_causa IN GA_MODCLI.cod_causa%TYPE,
								   EV_tip_modi  IN GA_MODCLI.cod_tipmodi%TYPE,
								   EV_nom_usuario IN GE_CLIENTES.NOM_USUARORA%TYPE,
								   SN_ind_facturaelect OUT NOCOPY ge_clientes.IND_FACTURAELECTRONICA%TYPE, --COL
								   SV_nom_email_clie OUT NOCOPY GE_CLIENTES.nom_email%TYPE, --COL
                                   SN_cod_retorno OUT NOCOPY NUMBER, SV_mens_retorno OUT NOCOPY VARCHAR2, SN_num_evento OUT NOCOPY NUMBER)
 AS
 /*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_DATOS_CLIE_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion></Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 ERROR_CONTROLADO EXCEPTION;
 ERROR_VALIDACION EXCEPTION;

 lt_cliente GE_CLIENTES%ROWTYPE;
 LT_modcli GA_MODCLI%ROWTYPE;
 LV_sql VARCHAR2(1000);
 BEGIN

    SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
	SN_num_evento := 0;

    IF EN_COD_CLIENTE IS NULL THEN
	   SN_COD_RETORNO := 1959; --400 Codigo de cliente debe ser informado 10
	   RAISE ERROR_VALIDACION;
	END IF;

	IF TRIM(EV_NOM_USUARIO) IS NULL THEN
	   SN_COD_RETORNO := 1961; -- 500 Usuario debe ser informado 12
	   RAISE ERROR_VALIDACION;
	END IF;

	IF TRIM(EV_cod_causa) IS NULL THEN
	   SN_COD_RETORNO := 1962; --600 Código de causal de modificación debe ser informado. 13
	   RAISE ERROR_VALIDACION;
	END IF;


	IF EV_nom_email IS NOT NULL AND  EV_ind_fact_Elect IS NOT NULL THEN
	   sn_cod_retorno := 1973; ---650 Solo se debe informar e-mail o indicador de factura electrónica.
	   RAISE ERROR_VALIDACION;
	END IF;

	IF EV_nom_email IS NULL AND  EV_ind_fact_Elect IS  NULL THEN
	   sn_cod_retorno := 1963; ---700 No se ha informado e-mail o indicador de factura electrónica.
	   RAISE ERROR_VALIDACION;
	END IF;


	IF  EV_ind_fact_Elect NOT IN (1,0) THEN
	   sn_cod_retorno := 1964; --- 750 El parámetro indicador de factura electrónica debe tener valores 0 o 1.
	   RAISE ERROR_VALIDACION;
	END IF;

	LV_sql:='GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_VALIDA_DATOS_PR';
	GA_VALIDA_DATOS_PR ( EV_cod_causa, EV_nom_usuario,EV_tip_modi, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	--RECUPERAR CLIENTE
	LV_sql:='GE_CLIENTES_SP_PG.GE_RECUPERA_PR';
	lt_cliente.cod_cliente := EN_cod_cliente;
	Ge_Clientes_Mod_Pg.ge_recupera_pr( lt_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	IF lt_cliente.cod_cliente IS NULL THEN
	  SN_cod_retorno := 1965;  -- 800 Código de cliente no existe en SCL 10
	  RAISE ERROR_VALIDACION;
	END IF;


	IF EV_ind_fact_Elect= 1 THEN
	   IF TRIM( lt_cliente.nom_email )  IS NULL THEN
	      SN_cod_retorno := 1966; -- 810 Cliente no tiene asignado un correo electrónico, no se puede asignar facturación electrónica
	      RAISE ERROR_VALIDACION;
	   END IF;
	END IF;

	SN_ind_facturaelect := lt_cliente.ind_facturaelectronica;--col
	SV_nom_email_clie := NVL(EV_nom_email,lt_cliente.nom_email);

    --No se hacen modificaciones si no ha cambiado el e-mail y el indicador de fac. elect
    IF NVL(lt_cliente.nom_email,' ') != NVL( EV_nom_email,NVL(lt_cliente.nom_email,' ') ) OR
       NVL(lt_cliente.ind_facturaelectronica, -9) !=  NVL(EV_ind_fact_Elect, NVL(lt_cliente.ind_facturaelectronica, -9))
	   THEN
	      --REGISTRAR CAMBIO DE DATOS DE CLIENTE
	      lt_modcli.cod_cliente := lt_cliente.cod_cliente;
	      lt_modcli.cod_tipmodi := EV_tip_modi;
	      lt_modcli.fec_modifica := SYSDATE;
	      lt_modcli.nom_usuarora := ev_nom_usuario;
	      lt_modcli.nom_email := NVL(lt_cliente.nom_email,'*');
	      lt_modcli.ind_facturaelectronica :=lt_cliente.ind_facturaelectronica;
	      lt_modcli.cod_causa := ev_cod_causa;

	      LV_sql:='GA_MODCLI_SP_PG.GA_INSERTA_PR';
	      Ga_Modcli_Mod_Pg.GA_INSERTA_PR( LT_modcli, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	      IF sn_cod_retorno <> 0 THEN
	         RAISE ERROR_CONTROLADO;
	      END IF;

	      --ACTUALIZAR LOS DATOS DEL CLIENTE
	      lt_cliente.nom_email := NVL(EV_nom_email,lt_cliente.nom_email);
	      lt_cliente.ind_facturaelectronica:= NVL(EV_ind_fact_Elect, lt_cliente.ind_facturaelectronica);
	      lt_cliente.fec_ultmod := SYSDATE;

	      LV_sql:='GE_CLIENTES_SP_PG.GE_ACTUALIZA_MAIL_FACT_ELEC_PR';
	      Ge_Clientes_Mod_Pg.GE_ACTUALIZA_MAIL_FACT_ELEC_PR( lt_cliente, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	      IF sn_cod_retorno <> 0 THEN
	          RAISE ERROR_CONTROLADO;
	      END IF;
    END IF;

    EXCEPTION
      WHEN ERROR_CONTROLADO THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_CLIE_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

      WHEN ERROR_VALIDACION THEN
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_CLIE_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

      WHEN OTHERS THEN
         SN_COD_RETORNO := 1967; -- -900 Error en proceso de registro de los datos de cliente.
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_CLIE_PR', lv_sql, SQLCODE, SQLERRM );

 END;


 PROCEDURE GA_MODIFICA_DATOS_USUA_PR (EN_num_celular IN ga_abocel.num_celular%TYPE,
                                   EV_email IN GA_MODUSUARIOS.email%TYPE,
								   EV_cod_causa IN GA_MODUSUARIOS.cod_causa%TYPE,
								   EV_tip_modi  IN GA_MODUSUARIOS.cod_tipmodi%TYPE,
								   EV_nom_usuario IN GA_MODUSUARIOS.nom_usuarora%TYPE,
								   SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
 AS
  /*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_MODIFICA_DATOS_USUA_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion></Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
		 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
 ERROR_CONTROLADO EXCEPTION;
 ERROR_VALIDACION EXCEPTION;

 lt_usuario_pre GA_USUAMIST%ROWTYPE;
 lt_usuario_pos GA_USUARIOS%ROWTYPE;
 LT_modusuario GA_MODUSUARIOS%ROWTYPE;
 lv_cod_usuario GA_MODUSUARIOS.cod_usuario%TYPE;
 LV_sql VARCHAR2(1000);

 lv_origen VARCHAR2(6);
 BEGIN

    SN_cod_retorno := 0;
	SV_mens_retorno := NULL;
	SN_num_evento := 0;

    IF EN_num_celular IS NULL THEN
	   SN_COD_RETORNO := 1954; -- 130 El número de celular debe ser informado 40
	   RAISE ERROR_VALIDACION;
	END IF;

	IF TRIM(EV_NOM_USUARIO) IS NULL THEN
	   SN_COD_RETORNO := 1961; -- 500 Usuario debe ser informado 12
	   RAISE ERROR_VALIDACION;
	END IF;

	IF TRIM(EV_cod_causa) IS NULL THEN
	   SN_COD_RETORNO := 1962; --600 Código de causal de modificación debe ser informado. 13
	   RAISE ERROR_VALIDACION;
	END IF;


	IF TRIM(EV_email) IS NULL  THEN
	   sn_cod_retorno := 1956; ---230 Dirección e-mail inválida  60
	   RAISE ERROR_VALIDACION;
	END IF;


	LV_sql:='GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_VALIDA_DATOS_PR';
	GA_VALIDA_DATOS_PR ( EV_cod_causa, EV_nom_usuario,EV_tip_modi, sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;


    LV_sql:='GA_MODUSUARIOS_SP_PG.GA_RECUPERA_USUARIO_CEL_PR';
    Ga_Modusuarios_Mod_Pg.ga_recupera_usuario_cel_pr( EN_num_celular, lv_cod_usuario, lv_origen, sn_cod_retorno, sv_mens_retorno, sn_num_evento );

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;

	IF lv_cod_usuario IS NULL THEN
	   SN_COD_RETORNO := 1958; --330 Número de celular está asociado a un abonado en baja o la línea informada no se encuentra registrada en SCL.
	   RAISE ERROR_VALIDACION;
	END IF;

	IF lv_origen = 'PRE' THEN
		LV_sql:='GA_MODUSUARIOS_SP_PG.GA_RECUPERA_DATOS_USUA_PREP_PR';
		lt_usuario_pre.cod_usuario := lv_cod_usuario;
		Ga_Modusuarios_Mod_Pg.GA_RECUPERA_DATOS_USUA_PREP_PR( lt_usuario_pre, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	    IF sn_cod_retorno <> 0 THEN
	      RAISE ERROR_CONTROLADO;
	    END IF;

		IF lt_usuario_pre.cod_usuario IS NULL THEN
		   sn_cod_retorno := 1960;  -- 460 Usuario asociado al nro. celular informado no existe en SCL
		   RAISE ERROR_VALIDACION;
		END IF;

    ELSE
		LV_sql:='GA_MODUSUARIOS_SP_PG.GA_RECUPERA_DATOS_USUA_POST_PR';
	    lt_usuario_pos.cod_usuario := lv_cod_usuario;
	    Ga_Modusuarios_Mod_Pg.GA_RECUPERA_DATOS_USUA_POST_PR( lt_usuario_pos, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	    IF sn_cod_retorno <> 0 THEN
	      RAISE ERROR_CONTROLADO;
	    END IF;

		IF lt_usuario_pos.cod_usuario IS NULL THEN
		   sn_cod_retorno := 1960; -- 460 Usuario asociado al nro. celular informado no existe en SCL
		   RAISE ERROR_VALIDACION;
		END IF;

		--REGISTRAR CAMBIO DE DATOS DE USUARIO
     	LT_modusuario.COD_USUARIO := lv_cod_usuario;
    	LT_modusuario.COD_TIPMODI := EV_tip_modi;
    	LT_modusuario.FEC_MODIFICA := SYSDATE;
    	LT_modusuario.NOM_USUARORA := EV_nom_usuario;
    	LT_modusuario.EMAIL := lt_usuario_pos.email;
    	LT_modusuario.COD_CAUSA := EV_cod_causa;

    	LV_sql:='GA_MODUSUARIOS_SP_PG.FA_INSERTA_MODIF_USUARIO_PR';
	    Ga_Modusuarios_Mod_Pg.GA_INSERTA_MODIF_USUARIO_PR( LT_modusuario, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );

	    IF sn_cod_retorno <> 0 THEN
	       RAISE ERROR_CONTROLADO;
	    END IF;

	END IF;



	--ACTUALIZAR LOS DATOS DEL CLIENTE


    IF LV_ORIGEN = 'PRE' THEN
	   LV_sql:='GA_MODUSUARIOS_SP_PG.GA_ACTUALIZA_DATOS_USUA_PRE_PR';
	   lt_usuario_pre.email := EV_email;
	   Ga_Modusuarios_Mod_Pg.GA_ACTUALIZA_DATOS_USUA_PRE_PR( lt_usuario_pre, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );
	ELSE
	   LV_sql:='GA_MODUSUARIOS_SP_PG.GA_ACTUALIZA_DATOS_USUA_POS_PR';
       lt_usuario_pos.email := EV_email;
	   Ga_Modusuarios_Mod_Pg.GA_ACTUALIZA_DATOS_USUA_POS_PR( lt_usuario_pos, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );
	END IF;

	IF sn_cod_retorno <> 0 THEN
	  RAISE ERROR_CONTROLADO;
	END IF;


    EXCEPTION
      WHEN ERROR_CONTROLADO THEN
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_USUA_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

      WHEN ERROR_VALIDACION THEN
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_USUA_PR', lv_sql, SN_cod_retorno, SV_mens_retorno );

      WHEN OTHERS THEN
         SN_COD_RETORNO := 1969; -- -930 Error en proceso de registro de los datos de usuario.
  	     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
  	       SV_mens_retorno := CV_error_no_clasif;
 	     END IF;
  	     SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODIFIC_DATOS_CLIEABO_SB_PG.GA_MODIFICA_DATOS_USUA_PR', lv_sql, SQLCODE, SQLERRM );

 END;

END;
/
SHOW ERRORS
