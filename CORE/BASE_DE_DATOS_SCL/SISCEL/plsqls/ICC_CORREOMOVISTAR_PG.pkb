CREATE OR REPLACE PACKAGE BODY ICC_CORREOMOVISTAR_PG AS


FUNCTION IC_AUTENTICACIONSEVEN_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_AUTENTICACIONSEVEN_FN"
                Lenguaje="PL/SQL"
                Fecha creación="12-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos de autenticacion en la plataforma de Correo Seven.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
		LV_username      ga_abomail_to.username%TYPE;
		LV_password      ga_abomail_to.passwabo%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        sSql := 'GA_SRVCRM_PG.GA_CORREOUSERPWD_PR('||CV_Plat_Seven;
        sSql := sSql||',LV_username, LV_password, LN_cod_retorno,LV_mens_retorno,LN_num_evento );';

        -- Se invoca servicio comercial para obtener datos de autenticacion.
		GA_SRVCRM_PG.GA_CORREOUSERPWD_PR( CV_Plat_Seven, LV_username, LV_password, LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno<>0 THEN
                RETURN  'FALSE: PROBLEMA AL USAR SERVICIO PARA DATOS DE AUTENTICACION';
        END IF;

		RETURN LV_username||',password='||LV_password;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_AUTENTICACIONSEVEN_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_AUTENTICACIONSEVEN_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE AUTENTICACION-' || SQLERRM;
END;


FUNCTION IC_AUTENTICACIONBBERRY_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_AUTENTICACIONBBERRY_FN"
                Lenguaje="PL/SQL"
                Fecha creación="12-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los datos de autenticacion en la plataforma de Correo BlackBerry.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
		LV_username      ga_abomail_to.username%TYPE;
		LV_password      ga_abomail_to.passwabo%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        sSql := 'GA_SRVCRM_PG.GA_CORREOUSERPWD_PR('||CV_Plat_BlackBerry;
        sSql := sSql||',LV_username, LV_password, LN_cod_retorno,LV_mens_retorno,LN_num_evento );';

        -- Se invoca servicio comercial para obtener datos de autenticacion.
		GA_SRVCRM_PG.GA_CORREOUSERPWD_PR( CV_Plat_BlackBerry, LV_username, LV_password, LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno<>0 THEN
                RETURN  'FALSE: PROBLEMA AL USAR SERVICIO PARA DATOS DE AUTENTICACION';
        END IF;

		RETURN LV_username||',password='||LV_password;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_AUTENTICACIONBBERRY_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_AUTENTICACIONBBERRY_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE AUTENTICACION';
END;



FUNCTION IC_SERVSEVEN_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_SERVSEVEN_FN"
                Lenguaje="PL/SQL"
                Fecha creación="12-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los productos de la plataforma SEVEN que se deben aprovisionar. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado   icc_movimiento.num_abonado%TYPE;
        LV_plataforma    varchar2(512);
		LN_servicio      icg_servicio.cod_servicio%TYPE;
		LN_nivel         icg_nivelservicio.cod_nivel%TYPE;
		LN_cod_servcen   icg_servicio.cod_servicio%TYPE;
		LN_nivelcen      icg_nivelservicio.cod_nivel%TYPE;
		LV_actnivelcen   icg_nivelserviciocen.act_nivelcen%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;

        SELECT icc.num_abonado
        INTO  LN_num_abonado
        FROM  icc_movimiento icc
        WHERE icc.num_movimiento = EN_num_mov;


	    -- Invoca servicio comercial para obtener la plataforma, grupo y nivel del servicio de correo.

		GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR( LN_num_abonado, CV_Contrata, LN_servicio,LN_nivel, LV_plataforma, LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno<>0 THEN
                RETURN  'FALSE: PROBLEMA AL USAR SERVICIO PARA IDENTIFICACION DE CORREO MOVIL';
        END IF;

        IF LV_plataforma IS NULL OR LV_plataforma <> CV_Plat_Seven THEN
		        RETURN  'SEVEN=0';  -- No aplica al abonado.-
		END IF;

--		IF LN_nivel = 0 THEN
--		        RETURN 'SEVEN=0';
--		END IF;
		-- Obtiene la cadena correspondiente al nivel del servicio.

        sSql := 'SELECT cod_serviciocen, cod_nivelcen';
        sSql := sSql||' INTO LN_cod_servcen, LN_nivelcen';
        sSql := sSql||' FROM icg_entservicio';
        sSql := sSql||' WHERE cod_producto = '||TO_CHAR(CN_Producto);
        sSql := sSql||' AND cod_lenguaje = '||TO_CHAR(CN_Lenguaje);
        sSql := sSql||' AND cod_servicio = '||TO_CHAR(LN_servicio);
        sSql := sSql||' AND cod_nivel = '||TO_CHAR(LN_nivel);

		SELECT cod_serviciocen, cod_nivelcen
		INTO LN_cod_servcen, LN_nivelcen
		FROM icg_entservicio
		WHERE cod_producto = CN_Producto
		AND cod_lenguaje = CN_Lenguaje
		AND cod_servicio = LN_servicio
		AND cod_nivel = LN_nivel;

        sSql := 'SELECT NVL(act_nivelcen,CHR(0))';
        sSql := sSql||' INTO LV_actnivelcen';
        sSql := sSql||' FROM icg_nivelserviciocen';
        sSql := sSql||' WHERE cod_producto = '||TO_CHAR(CN_Producto);
        sSql := sSql||' AND cod_serviciocen = '||TO_CHAR(LN_cod_servcen);
        sSql := sSql||' AND cod_lenguaje = '||TO_CHAR(CN_Lenguaje);
        sSql := sSql||' AND cod_nivelcen = '||TO_CHAR(LN_nivelcen);

		SELECT NVL(act_nivelcen,CHR(0))
		INTO LV_actnivelcen
		FROM icg_nivelserviciocen
		WHERE cod_producto = CN_Producto
		AND cod_serviciocen = LN_cod_servcen
		AND cod_lenguaje = CN_Lenguaje
		AND cod_nivelcen = LN_nivelcen;

        IF LV_actnivelcen <> CHR(0) THEN
            RETURN LV_actnivelcen;
        ELSE
		    RETURN  'FALSE: PROBLEMA AL RESCATAR SERVICIO EN CENTRALES';
		END IF;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_SERVSEVEN_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_SERVSEVEN_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO SEVEN';
END;



FUNCTION IC_BAJASERVSEVEN_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_BAJASERVSEVEN_FN"
                Lenguaje="PL/SQL"
                Fecha creación="01-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para conocer si los productos de la plataforma SEVEN se estan dando de baja. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado   icc_movimiento.num_abonado%TYPE;
        LV_plataforma    varchar2(512);
		LN_servicio      icg_servicio.cod_servicio%TYPE;
		LN_nivel         icg_nivelservicio.cod_nivel%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;

        SELECT icc.num_abonado
        INTO  LN_num_abonado
        FROM  icc_movimiento icc
        WHERE icc.num_movimiento = EN_num_mov;


	    -- Invoca servicio comercial para obtener la plataforma, grupo y nivel del servicio de correo.

		GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR( LN_num_abonado, CV_Descontrata, LN_servicio,LN_nivel, LV_plataforma, LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno<>0 THEN
                RETURN  'FALSE: PROBLEMA AL USAR SERVICIO PARA IDENTIFICACION DE CORREO MOVIL';
        END IF;

        IF LV_plataforma IS NULL OR LV_plataforma <> CV_Plat_Seven THEN
				RETURN 'SEVEN=0';  -- No aplica al abonado.-
		END IF;

		-- Se esta dando de baja un servicio SEVEN.
        RETURN 'SEVEN=1';   -- Aplica la baja.-

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_BAJASERVSEVEN_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_BAJASERVSEVEN_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO SEVEN';
END;




FUNCTION IC_BAJACONDICION_SERVCORREO_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE,
		EV_plataforma IN varchar2)
		RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_BAJACONDICION_SERVCORREO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="01-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para conocer si aplica baka de servicio de correo en movimientos SS. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado   icc_movimiento.num_abonado%TYPE;
        LV_plataforma    varchar2(512);
		LN_servicio      icg_servicio.cod_servicio%TYPE;
		LN_nivel         icg_nivelservicio.cod_nivel%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

		ERROR_CONTROLADO EXCEPTION;
		LN_HayBaja       number;
		LN_GrupoSrvDato  icg_servicio.cod_servicio%TYPE;
		LN_NivelSrvDato  icg_nivelservicio.cod_nivel%TYPE;
		LN_servDatoNew   icg_servicio.cod_servicio%TYPE;
		LN_nivelDatoNew  icg_nivelservicio.cod_nivel%TYPE;
		LB_CambNivelDato boolean := FALSE;
		LB_EsServDatos   boolean := FALSE;
		LN_pos           number;
		LV_cad_servIC    icc_movimiento.cod_servicios%TYPE;
		LV_cadserv       icc_movimiento.cod_servicios%TYPE;

BEGIN

        sSql := 'SELECT icc.num_abonado, NVL(cod_servicios,CHR(0)';
        sSql := sSql||' INTO LN_num_abonado, LV_cad_servIC';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;

        SELECT icc.num_abonado, NVL(cod_servicios,CHR(0))
        INTO  LN_num_abonado, LV_cad_servIC
        FROM  icc_movimiento icc
        WHERE icc.num_movimiento = EN_num_mov;


        -- Valida que el servicio de correo está descontratado.-
	    -- Invoca servicio comercial para obtener la plataforma, grupo y nivel del servicio de correo.

		GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR( LN_num_abonado, CV_Descontrata, LN_servicio,LN_nivel, LV_plataforma, LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno<>0 THEN
		        LV_mens_retorno:= 'GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR '||LV_mens_retorno;
		        RAISE ERROR_CONTROLADO;
        END IF;

        -- Se está descontratando pero es otra plataforma.-
        IF LV_plataforma IS NOT NULL AND LV_plataforma <> EV_plataforma THEN
				RETURN '0';  -- No aplica al abonado.-
		END IF;

		-- Se esta dando de baja un servicio de correo.
        IF LV_plataforma IS NOT NULL AND LV_plataforma = EV_plataforma THEN
                -- Actualiza  registro de correo.-
		        GA_SRVCRM_PG.GA_RegDescontratacionCorreo_PR( LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento );
		        RETURN  '1';  -- Aplica baja.-
		END IF;


        -- Valida que el servicio de correo está contratado.-
	    -- Invoca servicio comercial para obtener la plataforma, grupo y nivel del servicio de correo.

		GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR( LN_num_abonado, CV_Contrata, LN_servicio,LN_nivel, LV_plataforma, LN_cod_retorno,LV_mens_retorno,LN_num_evento );
        IF LN_cod_retorno<>0 THEN
                LV_mens_retorno:= 'GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR: '||LV_mens_retorno;
                RAISE ERROR_CONTROLADO;
        END IF;

		-- Está contratado serv de correo pero es otra plataforma.-
        IF LV_plataforma IS NOT NULL AND LV_plataforma <> EV_plataforma THEN
				RETURN '0';  -- No aplica al abonado.-
		END IF;

        -- No tiene servicio de correo contratado.-
        IF LV_plataforma IS NULL THEN
		        RETURN  '0';  -- No aplica al abonado. No tiene correo contratado.-
		END IF;


        -- Está contratado el servicio de correo.-
        IF LV_plataforma IS NOT NULL AND LV_plataforma = EV_plataforma THEN

             GA_SRVCRM_PG.GA_GetSrvDatosBaja_PR( LN_num_abonado,LN_GrupoSrvDato,LN_NivelSrvDato, LN_cod_retorno,LV_mens_retorno,LN_num_evento );
			 IF LN_cod_retorno <> 0 THEN
                  LV_mens_retorno:= 'GA_SRVCRM_PG.GA_GetSrvDatosBaja_PR: '||LV_mens_retorno;
                  RAISE ERROR_CONTROLADO;
			 END IF;

             IF LN_GrupoSrvDato IS NULL THEN  -- Podria estar contratado serv de datos.- No hay serv de datos en baja.-
				  RETURN '0';  -- No aplica baja de correo al abonado.-
			 END IF;

             -- Revisa los servicios de la cadena de servicios por si hay alta de otro servicio de datos.
             LN_pos :=1;
             WHILE (LN_pos<length(LV_cad_servIC)) LOOP
         		LV_cadserv :=substr(LV_cad_servIC,LN_pos,6);
				LN_servDatoNew := TO_NUMBER(substr(LV_cadserv,1,2));
				LN_nivelDatoNew:= TO_NUMBER(substr(LV_cadserv,3,4));


                IF LN_servDatoNew = LN_GrupoSrvDato AND LN_nivelDatoNew = 0 THEN -- es el registro del serv en baja.-
				    LN_pos:=LN_pos+6;
                ELSE
				    LB_EsServDatos :=FALSE;

					--Valida si es un servicio de datos.-
                    LB_EsServDatos := GA_SRVCRM_PG.GA_IsSrvDatos_FN( LN_servDatoNew,LN_nivelDatoNew, LN_cod_retorno,LV_mens_retorno,LN_num_evento );
                    IF LN_cod_retorno <> 0 THEN
                         LV_mens_retorno:= 'GA_SRVCRM_PG.GA_IsSrvDatos_PR: '||LV_mens_retorno;
                         RAISE ERROR_CONTROLADO;
                    END IF;

	                IF LB_EsServDatos = TRUE THEN
		                EXIT;
                    ELSE
				        LN_pos:=LN_pos+6;
	                END IF;
				END IF;
             END LOOP;

			 IF LB_EsServDatos = FALSE THEN
			     -- Se baja el servicio de correo porque no hay otro servicio de datos en alta.-
                 GA_SRVCRM_PG.GA_RegDescontratacionCorreo_PR( LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento );
			     RETURN '1';  -- Aplica baja de correo.-
			 END IF;

			 IF LB_EsServDatos = TRUE THEN
                 -- Valida si el servicio nuevo de datos, es prerequisito del servicio de correo.-
                 LB_CambNivelDato:=GA_SRVCRM_PG.GA_IsPreRequisito_FN(LN_num_abonado,LN_servDatoNew,LN_nivelDatoNew, LN_cod_retorno,LV_mens_retorno,LN_num_evento );
                 IF LN_cod_retorno <> 0 THEN
                      LV_mens_retorno:= 'GA_SRVCRM_PG.GA_IsPreRequisito_PR: '||LV_mens_retorno;
                      RAISE ERROR_CONTROLADO;
    			 END IF;

    			 IF LB_CambNivelDato = FALSE THEN -- No es prerequisito, se puede bajar el serv de correo.-
                    -- Actualiza  registro de correo.-
    		        GA_SRVCRM_PG.GA_RegDescontratacionCorreo_PR( LN_num_abonado,LN_cod_retorno,LV_mens_retorno,LN_num_evento );
    		        RETURN '1';  -- Aplica baja de correo.-
                 ELSE
    			 	-- No aplica porque el servicio de datos nuevo permite mantener el serv de correo.-
					RETURN '0';  -- No aplica baja de correo.-
			     END IF;
			 END IF;

		END IF;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_BAJACONDICION_SERVCORREO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_BAJACONDICION_SERVCORREO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO '||EV_plataforma||':'||LV_mens_retorno;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_BAJACONDICION_SERVCORREO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_BAJACONDICION_SERVCORREO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO '||EV_plataforma||':'||LV_mens_retorno;
END;




PROCEDURE IC_BAJACOND_SERVSEVEN_PR(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE,
        SV_salida  OUT STRING)
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "IC_BAJACOND_SERVSEVEN_PR"
                Lenguaje="PL/SQL"
                Fecha creación="01-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para conocer si aplica baja de correo SEVEN en movimientos SS. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
        						<param nom="SV_salida" Tipo="STRING">Indicador del servicio de correo</param>
						</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;
        LV_resultado     VARCHAR2(512);
BEGIN
        LV_resultado := IC_BAJACONDICION_SERVCORREO_FN(EN_num_mov, CV_Plat_Seven);

		IF LV_resultado = '1' THEN
              LV_resultado:= 'SEVEN=1';  -- Aplica.-
		ELSE IF LV_resultado = '0' THEN
                  LV_resultado:= 'SEVEN=0';  -- No aplica.-
		     END IF;
		END IF;
        -- Si el resultado es un error con 'FALSE' se retorna tal cual.-
        SV_salida := LV_resultado;
END;


PROCEDURE IC_BAJACOND_SERVBBERRY_PR(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE,
		SV_salida  OUT STRING)
/*
<Documentación
        TipoDoc = "Procedure">
        <Elemento
                Nombre = "IC_BAJACOND_SERVBLACKBERRY_PR"
                Lenguaje="PL/SQL"
                Fecha creación="01-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Procedure para conocer si aplica baja de correo BLACKBERRY en movimientos SS. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>
        						<param nom="SV_salida" Tipo="STRING">Indicador del servicio de correo</param>
						</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;
        LV_resultado     VARCHAR2(512);
BEGIN
        LV_resultado := IC_BAJACONDICION_SERVCORREO_FN(EN_num_mov, CV_Plat_BlackBerry);

	    SV_salida := LV_resultado;
END;




FUNCTION IC_SERVBLACKBERRY_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_SERVBLACKBERRY_FN"
                Lenguaje="PL/SQL"
                Fecha creación="12-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los productos de la plataforma BlackBerry que se deben aprovisionar. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado  icc_movimiento.num_abonado%TYPE;
		LV_plataforma   varchar2(25);
		LN_servicio     icg_servicio.cod_servicio%TYPE;
		LN_nivel        icg_nivelservicio.cod_nivel%TYPE;
		LN_cod_servcen  icg_servicio.cod_servicio%TYPE;
		LN_nivelcen     icg_nivelservicio.cod_nivel%TYPE;
		LV_actnivelcen  icg_nivelserviciocen.act_nivelcen%TYPE;
        LN_cod_retorno  GE_Errores_PG.coderror;
        LV_mens_retorno GE_Errores_PG.msgerror;
        LN_num_evento   GE_Errores_PG.evento;
        LV_des_error    VARCHAR2(512);
        sSql            GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;

        SELECT icc.num_abonado
        INTO  LN_num_abonado
        FROM  icc_movimiento icc
        WHERE icc.num_movimiento = EN_num_mov;

	    -- Invoca servicio comercial para obtener la plataforma, grupo y nivel del servicio de correo.
		GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR( LN_num_abonado, CV_Contrata, LN_servicio,LN_nivel, LV_plataforma, LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno<>0 THEN
                RETURN  'FALSE: PROBLEMA AL USAR SERVICIO PARA IDENTIFICACION DE CORREO MOVIL';
        END IF;

        IF LV_plataforma IS NULL OR LV_plataforma <> CV_Plat_BlackBerry THEN
				RETURN '0'; -- No aplica al abonado.-
		END IF;

--		IF LN_nivel = 0 THEN
--		        RETURN '0';
--		END IF;
		-- Obtiene la cadena correspondiente al nivel del servicio.

        sSql := 'SELECT cod_serviciocen, cod_nivelcen';
        sSql := sSql||' INTO LN_cod_servcen, LN_nivelcen';
        sSql := sSql||' FROM icg_entservicio';
        sSql := sSql||' WHERE cod_producto = '||TO_CHAR(CN_Producto);
        sSql := sSql||' AND cod_lenguaje = '||TO_CHAR(CN_Lenguaje);
        sSql := sSql||' AND cod_servicio = '||TO_CHAR(LN_servicio);
        sSql := sSql||' AND cod_nivel = '||TO_CHAR(LN_nivel);

		SELECT cod_serviciocen, cod_nivelcen
		INTO LN_cod_servcen, LN_nivelcen
		FROM icg_entservicio
		WHERE cod_producto = CN_Producto
		AND cod_lenguaje = CN_Lenguaje
		AND cod_servicio = LN_servicio
		AND cod_nivel = LN_nivel;

        sSql := 'SELECT NVL(act_nivelcen,CHR(0))';
        sSql := sSql||' INTO LV_actnivelcen';
        sSql := sSql||' FROM icg_nivelserviciocen';
        sSql := sSql||' WHERE cod_producto = '||TO_CHAR(CN_Producto);
        sSql := sSql||' AND cod_serviciocen = '||TO_CHAR(LN_cod_servcen);
        sSql := sSql||' AND cod_lenguaje = '||TO_CHAR(CN_Lenguaje);
        sSql := sSql||' AND cod_nivelcen = '||TO_CHAR(LN_nivelcen);

		SELECT NVL(act_nivelcen,CHR(0))
		INTO LV_actnivelcen
		FROM icg_nivelserviciocen
		WHERE cod_producto = CN_Producto
		AND cod_serviciocen = LN_cod_servcen
		AND cod_lenguaje = CN_Lenguaje
		AND cod_nivelcen = LN_nivelcen;

        IF LV_actnivelcen <> CHR(0) THEN
            RETURN LV_actnivelcen;
        ELSE
		    RETURN  'FALSE: PROBLEMA AL RESCATAR SERVICIO EN CENTRALES';
		END IF;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_SERVBLACKBERRY_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_SERVBLACKBERRY_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO BB';
END;


FUNCTION IC_BAJASERVBLACKBERRY_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_BAJASERVBLACKBERRY_FN"
                Lenguaje="PL/SQL"
                Fecha creación="01-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para conocer si los productos de la plataforma BlackBerry se estan dando de baja. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado  icc_movimiento.num_abonado%TYPE;
		LV_plataforma   varchar2(25);
		LN_servicio     icg_servicio.cod_servicio%TYPE;
		LN_nivel        icg_nivelservicio.cod_nivel%TYPE;
        LN_cod_retorno  GE_Errores_PG.coderror;
        LV_mens_retorno GE_Errores_PG.msgerror;
        LN_num_evento   GE_Errores_PG.evento;
        LV_des_error    VARCHAR2(512);
        sSql            GE_Errores_PG.vQuery;

BEGIN

        sSql := 'SELECT icc.num_abonado';
        sSql := sSql||' INTO LN_num_abonado';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;

        SELECT icc.num_abonado
        INTO  LN_num_abonado
        FROM  icc_movimiento icc
        WHERE icc.num_movimiento = EN_num_mov;

	    -- Invoca servicio comercial para obtener la plataforma, grupo y nivel del servicio de correo.
		GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR( LN_num_abonado, CV_Descontrata, LN_servicio,LN_nivel, LV_plataforma, LN_cod_retorno,LV_mens_retorno,LN_num_evento );

        IF LN_cod_retorno<>0 THEN
                RETURN  'FALSE: PROBLEMA AL USAR SERVICIO PARA IDENTIFICACION DE CORREO MOVIL';
        END IF;

        IF LV_plataforma IS NULL OR LV_plataforma <> CV_Plat_BlackBerry THEN
				RETURN '0';  -- No aplica baja.-
		END IF;

        -- Se está dando de baja un servicio BlackBerry.
        RETURN '1';  -- Aplica la baja.-

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_BAJASERVBLACKBERRY_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_BAJASERVBLACKBERRY_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO BB';
END;


FUNCTION IC_ALTACOND_SERVCORREO_FN(EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ALTACOND_SERVCORREO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="01-2009"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para conocer si aplica alta de servicio de correo de acuerdo a condicion de baja y alta informada en movimiento SS. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_num_abonado   icc_movimiento.num_abonado%TYPE;
        LV_plataforma    varchar2(512);
		LN_servicio      icg_servicio.cod_servicio%TYPE;
		LN_nivel         icg_nivelservicio.cod_nivel%TYPE;
        LN_cod_retorno   GE_Errores_PG.coderror;
        LV_mens_retorno  GE_Errores_PG.msgerror;
        LN_num_evento    GE_Errores_PG.evento;
        LV_des_error     VARCHAR2(512);
        sSql             GE_Errores_PG.vQuery;

		ERROR_CONTROLADO EXCEPTION;
		LN_GrupoSrv      icg_servicio.cod_servicio%TYPE;
		LN_NivelSrv      icg_nivelservicio.cod_nivel%TYPE;
		LN_servNew       icg_servicio.cod_servicio%TYPE;
		LN_nivelNew      icg_nivelservicio.cod_nivel%TYPE;
		LB_InformaBaja   boolean := FALSE;
		LB_InformaAlta   boolean := FALSE;
		LB_EsServCond    boolean := FALSE;
		LN_pos           number;
		LV_cad_servIC    icc_movimiento.cod_servicios%TYPE;
		LV_cadserv       icc_movimiento.cod_servicios%TYPE;

BEGIN

        sSql := 'SELECT icc.num_abonado, NVL(cod_servicios,CHR(0)';
        sSql := sSql||' INTO LN_num_abonado, LV_cad_servIC';
        sSql := sSql||' FROM icc_movimiento icc';
        sSql := sSql||' WHERE icc.num_movimiento = '||EN_num_mov;

        SELECT icc.num_abonado, NVL(cod_servicios,CHR(0))
        INTO  LN_num_abonado, LV_cad_servIC
        FROM  icc_movimiento icc
        WHERE icc.num_movimiento = EN_num_mov;


        -- Valida que el servicio de correo está contratado.-
	    -- Invoca servicio comercial para obtener la plataforma, grupo y nivel del servicio de correo.

		GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR( LN_num_abonado, CV_Contrata, LN_servicio,LN_nivel, LV_plataforma, LN_cod_retorno,LV_mens_retorno,LN_num_evento );
        IF LN_cod_retorno<>0 THEN
                LV_mens_retorno:= 'GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR: '||LV_mens_retorno;
                RAISE ERROR_CONTROLADO;
        END IF;

        -- No tiene servicio de correo contratado.- independientemente el comando deberia estar condicionado a alta.
        IF LN_servicio IS NULL THEN
				RETURN '0';  -- No aplica al abonado. No tiene correo contratado.-
		END IF;

        LN_pos :=1;
        WHILE (LN_pos<length(LV_cad_servIC)) LOOP
         		LV_cadserv :=substr(LV_cad_servIC,LN_pos,6);
				LN_servNew := TO_NUMBER(substr(LV_cadserv,1,2));
				LN_nivelNew:= TO_NUMBER(substr(LV_cadserv,3,4));


				IF LN_servNew = LN_servicio AND LN_nivelNew = 0 THEN
				    LB_informaBaja := TRUE;
				END IF;

				IF LN_servNew = LN_servicio AND LN_nivelNew <> 0 THEN
				    LB_informaAlta := TRUE;
				END IF;

				IF LB_informaBaja = TRUE AND LB_informaAlta = TRUE THEN
				    EXIT;
				END IF;

				LN_pos:=LN_pos+6;

        END LOOP;

		-- Solo hay un alta o solo hay una baja del servicio informados en el movimiento.-
		-- Independientemente el comando deberia estar condicionado a alta.
		IF LB_informaBaja = FALSE OR LB_informaAlta = FALSE THEN
			 RETURN '1';  -- asume que tiene servicio de correo contratado de acuerdo a  paso anterior.-
		END IF;

        LB_EsServCond := GA_SRVCRM_PG.GA_IsSrvCondicion_FN(LN_num_abonado,LN_servNew,LN_cod_retorno,LV_mens_retorno,LN_num_evento );
		 -- El servicio no es condicion para no aplicar el alta. Por lo tanto, si aplica comando de alta de servicio.
        IF LB_EsServCond = FALSE THEN
               RETURN '1'; -- finalmente permite la ejecucion del comando de alta.-
        ELSE
			   RETURN '0';  -- Alta no aplica por condicion.-
        END IF;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_ALTACOND_SERVCORREO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_ALTACOND_SERVCORREO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO '||LN_servicio||':'||LV_mens_retorno;
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_ALTACOND_SERVCORREO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_ALTACOND_SERVCORREO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DEL SERVICIO '||LN_servicio||':'||LV_mens_retorno;
END;



FUNCTION IC_PRIORIDAD_COMCORREO_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_PRIORIDAD_COMCORREO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="12-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los productos de la plataforma BlackBerry que se deben aprovisionar. </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO">Numero del Movimiento</param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
		LV_comandosbaja ged_parametros.val_parametro%TYPE;
		LN_cont         number;
        LN_cod_retorno  GE_Errores_PG.coderror;
        LV_mens_retorno GE_Errores_PG.msgerror;
        LN_num_evento   GE_Errores_PG.evento;
        LV_des_error    VARCHAR2(512);
        sSql            GE_Errores_PG.vQuery;

BEGIN

        sSql := 'NVL(val_parametro,''0'')';
        sSql := sSql || ' INTO LV_comandosbaja ';
        sSql := sSql || ' FROM ged_parametros ';
        sSql := sSql || ' WHERE nom_parametro = ''COM_PRIORITARIO'' ';
        sSql := sSql || ' AND cod_modulo = ' || CV_ModCentrales;
        sSql := sSql || ' AND cod_producto = 1;';

        SELECT NVL(val_parametro,'0')
		INTO LV_comandosbaja
		FROM ged_parametros
		WHERE nom_parametro = 'COM_PRIORITARIO'
		AND cod_modulo = CV_ModCentrales
		AND cod_producto = 1;

        -- Busca otros abonados del cliente que tengan efectivamente activo un servicio de Atlantida.
        sSql := 'SELECT COUNT(1) FROM  icc_comproc A ';
        sSql := sSql || ' WHERE  A.num_movimiento = ' || EN_num_mov;
        sSql := sSql || ' AND A.cod_comando IN (' ||  LV_comandosbaja || ')';
        sSql := sSql || ' AND A.tip_respuesta = -1 ';

        EXECUTE IMMEDIATE sSql INTO LN_cont;

	    IF LN_cont = 0 THEN
		    RETURN '1'; -- No hay comandos de baja por ejecutar o no se generaron. El comando que hace la consulta se impacta.
        ELSE
		    RETURN '0'; -- Aun quedan comandos de baja. El comando que hace la consulta no procede.-
		END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
		       dbms_output.put_line('no data_found');
		        RETURN '1';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Usuario;
                IF NOT GE_Errores_PG.MensajeError(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'ICC_CORREOMOVISTAR_PG.IC_PRIORIDAD_COMCORREO_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_Errores_PG.GrabarPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'ICC_CORREOMOVISTAR_PG.IC_PRIORIDAD_COMCORREO_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER DATOS DE PRIORIDAD';
END;



FUNCTION ICC_EXTRAE_EMAIL_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "ICC_EXTRAE_EMAIL_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna el email del abonado asociado al servicio de correo móvil</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="NUMBER(9)">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_numabo  ICC_MOVIMIENTO.NUM_ABONADO%type;
LV_abomail GA_ABOMAIL_TO.ABOMAIL%type;

BEGIN

	SELECT NUM_ABONADO INTO LV_numabo
	FROM ICC_MOVIMIENTO
	WHERE NUM_MOVIMIENTO=EN_NUM_MOV;


	SELECT ABOMAIL INTO LV_abomail
	FROM   GA_ABOMAIL_TO
	WHERE  NUM_ABONADO=LV_numabo;

    RETURN LV_abomail;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
	 	  RETURN '0';
END ICC_EXTRAE_EMAIL_FN;


FUNCTION ICC_EXTRAE_USER_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "ICC_EXTRAE_USER_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna el usuario BlackBerry del abonado asociado al servicio de correo móvil</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="NUMBER(9)">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_numabo ICC_MOVIMIENTO.NUM_ABONADO%type;
LV_user GA_ABOMAIL_TO.USERNAME%type;

BEGIN

	SELECT NUM_ABONADO INTO LV_numabo
	FROM ICC_MOVIMIENTO
	WHERE NUM_MOVIMIENTO=EN_NUM_MOV;


	SELECT USERNAME INTO LV_user
	FROM   GA_ABOMAIL_TO
	WHERE  NUM_ABONADO=LV_numabo;

    RETURN LV_user;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
	 	  RETURN '0';
END ICC_EXTRAE_USER_FN;



FUNCTION ICC_EXTRAE_PASS_FN(EN_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN STRING
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "ICC_EXTRAE_PASS_FN" Lenguaje="PL/SQL" Fecha="09-03-2007" Versión="1.0.0" Diseñador="José J. Figueroa " Programador="José J. Figueroa" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>retorna la password BlackBerry del abonado asociado al servicio de correo móvil</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_NUM_MOV" Tipo="NUMBER(9)">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
LV_numabo ICC_MOVIMIENTO.NUM_ABONADO%type;
LV_pass GA_ABOMAIL_TO.PASSWABO %type;

BEGIN

	SELECT NUM_ABONADO INTO LV_numabo
	FROM ICC_MOVIMIENTO
	WHERE NUM_MOVIMIENTO=EN_NUM_MOV;

	SELECT PASSWABO INTO LV_pass
	FROM   GA_ABOMAIL_TO
	WHERE  NUM_ABONADO=LV_numabo;

    RETURN LV_pass;

EXCEPTION
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
	 	  RETURN '0';
END ICC_EXTRAE_PASS_FN;




END ICC_CORREOMOVISTAR_PG;
/
SHOW ERRORS
