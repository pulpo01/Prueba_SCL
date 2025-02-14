CREATE OR REPLACE PACKAGE BODY IC_GENERACOMANDO_PG IS

--------------------------------------------------
FUNCTION IC_ALTABONOS_SMS_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ALTABONOS_SMS_FN"
                Lenguaje="PL/SQL"
                Fecha creación="10-2007"
                Creado por="Juan Gonzalez C."
                Fecha modificacion="01-2008"
                Modificado por="Juan Gonzalez C."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción> Funcion para obtener la cadena de comando asociada a un movimiento de Alta de Bonos SMS </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO"> Numero del Movimiento </param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.msgerror;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);

        sSql GE_Errores_PG.vQuery;

        LV_val_subparametro ic_detalle_movimiento_to.val_subparametro%TYPE;

        LV_cadena VARCHAR2(1000);

        CURSOR c_subp IS
                SELECT b.nom_subparametro, b.tip_subparametro
                FROM  ic_subparametro_td a, ic_codsubparametro_td b
                WHERE a.nom_parametro = CV_CmdAltaBonoSMS
                AND     b.cod_subparametro = a.cod_subparametro;

BEGIN
		sSql := 'SELECT b.nom_subparametro, b.tip_subparametro';
		sSql := sSql || ' FROM ic_subparametro_td a, ic_codsubparametro_td b';
		sSql := sSql || ' WHERE a.nom_parametro = '''|| CV_CmdAltaBonoSMS ||'''';
		sSql := sSql || ' AND b.cod_subparametro = a.cod_subparametro';

        FOR r_subp IN c_subp LOOP
                LV_val_subparametro := NULL;

				sSql := ' SELECT val_subparametro';
				sSql := sSql || ' FROM  ic_detalle_movimiento_to';
				sSql := sSql || ' WHERE num_movimiento = '|| EN_num_mov;
				sSql := sSql || ' AND nom_subparametro = '|| r_subp.nom_subparametro;

                SELECT val_subparametro
                INTO   LV_val_subparametro
                FROM  ic_detalle_movimiento_to
                WHERE num_movimiento = EN_num_mov
                AND     nom_subparametro = r_subp.nom_subparametro;

                LV_cadena := LV_cadena || r_subp.tip_subparametro || '=' || TRIM(LV_val_subparametro) || ',';
        END LOOP;

        IF LENGTH(LV_cadena) > 0 THEN
                LV_cadena := SUBSTR(LV_cadena,1,LENGTH(LV_cadena)-1);
        ELSE
		        LV_cadena := 'FALSE:SIN VALORES';
		END IF;

        RETURN LV_cadena;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_ALTABONOS_SMS_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_ALTABONOS_SMS_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END IC_ALTABONOS_SMS_FN;

--------------------------------------------------
FUNCTION IC_ALTABONOS_REC_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ALTABONOS_REC_FN"
                Lenguaje="PL/SQL"
                Fecha creación="10-2007"
                Creado por="Juan Gonzalez C."
                Fecha modificacion="01-2008"
                Modificado por="Juan Gonzalez C."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción> Funcion para obtener la cadena de comando asociada a un movimiento de Alta de Bonos Dinero </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO"> Numero del Movimiento </param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.msgerror;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);

        sSql GE_Errores_PG.vQuery;

        LV_val_subparametro ic_detalle_movimiento_to.val_subparametro%TYPE;

        LV_cadena VARCHAR2(1000);

        CURSOR c_subp IS
                SELECT b.nom_subparametro, b.tip_subparametro
                FROM  ic_subparametro_td a, ic_codsubparametro_td b
                WHERE a.nom_parametro = CV_CmdAltaBonoRec
                AND     b.cod_subparametro = a.cod_subparametro;

BEGIN
		sSql := 'SELECT b.nom_subparametro, b.tip_subparametro';
		sSql := sSql || ' FROM ic_subparametro_td a, ic_codsubparametro_td b';
		sSql := sSql || ' WHERE a.nom_parametro = '''|| CV_CmdAltaBonoRec ||'''';
		sSql := sSql || ' AND b.cod_subparametro = a.cod_subparametro';

        FOR r_subp IN c_subp LOOP
                LV_val_subparametro := NULL;

				sSql := ' SELECT val_subparametro';
				sSql := sSql || ' FROM  ic_detalle_movimiento_to';
				sSql := sSql || ' WHERE num_movimiento = '|| EN_num_mov;
				sSql := sSql || ' AND nom_subparametro = '|| r_subp.nom_subparametro;

                SELECT val_subparametro
                INTO   LV_val_subparametro
                FROM  ic_detalle_movimiento_to
                WHERE num_movimiento = EN_num_mov
                AND     nom_subparametro = r_subp.nom_subparametro;

                LV_cadena := LV_cadena || r_subp.tip_subparametro || '=' || TRIM(LV_val_subparametro) || ',';
        END LOOP;

        IF LENGTH(LV_cadena) > 0 THEN
                LV_cadena := SUBSTR(LV_cadena,1,LENGTH(LV_cadena)-1);
        ELSE
		        LV_cadena := 'FALSE:SIN VALORES';
		END IF;

        RETURN LV_cadena;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_ALTABONOS_REC_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_ALTABONOS_REC_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END IC_ALTABONOS_REC_FN;

--------------------------------------------------
FUNCTION IC_BAJABONOS_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_BAJABONOS_FN"
                Lenguaje="PL/SQL"
                Fecha creación="10-2007"
                Creado por="Juan Gonzalez C."
                Fecha modificacion="01-2008"
                Modificado por="Juan Gonzalez C."
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción> Funcion para obtener la cadena de comando asociada a un movimiento de Baja de Bonos, ya sea SMS o Dinero </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO"> Numero del Movimiento </param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.msgerror;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);

        sSql GE_Errores_PG.vQuery;

        LN_codprodcontratado icc_movimiento.cod_prod_contratado%TYPE;
		LN_num_celular       icc_movimiento.num_celular%TYPE;
        LV_val_subparametro  ic_detalle_movimiento_to.val_subparametro%TYPE;
        LN_id_secuencia      ic_sectransaccion_to.id_secuencia%TYPE;

        LV_cadena VARCHAR2(1000);

        CURSOR c_subp IS
                SELECT b.nom_subparametro, b.tip_subparametro
                FROM  ic_subparametro_td a, ic_codsubparametro_td b
                WHERE a.nom_parametro = CV_CmdBajaBono
                AND     b.cod_subparametro = a.cod_subparametro;

BEGIN
        LV_cadena := NULL;
        LN_id_secuencia := NULL;

		sSql := ' SELECT b.nom_subparametro, b.tip_subparametro';
		sSql := sSql || ' FROM  ic_subparametro_td a, ic_codsubparametro_td b';
		sSql := sSql || ' WHERE a.nom_parametro = '''|| CV_CmdBajaBono || '''';
		sSql := sSql || ' AND     b.cod_subparametro = a.cod_subparametro';

        FOR r_subp IN c_subp LOOP
                LV_val_subparametro := NULL;

				sSql := ' SELECT val_subparametro';
				sSql := sSql || ' FROM  ic_detalle_movimiento_to';
				sSql := sSql || ' WHERE num_movimiento = '|| EN_num_mov;
				sSql := sSql || ' AND     nom_subparametro = '|| r_subp.nom_subparametro;

                SELECT val_subparametro
                INTO   LV_val_subparametro
                FROM  ic_detalle_movimiento_to
                WHERE num_movimiento = EN_num_mov
                AND     nom_subparametro = r_subp.nom_subparametro;

                LV_cadena := LV_cadena || r_subp.tip_subparametro || '=' || TRIM(LV_val_subparametro) || ',';
        END LOOP;

		sSql := sSql || 'SELECT mov.num_celular, mov.cod_prod_contratado';
		sSql := sSql || 'FROM icc_movimiento mov';
		sSql := sSql || 'WHERE mov.num_movimiento = '|| EN_num_mov;

        SELECT mov.num_celular, mov.cod_prod_contratado
        INTO   LN_num_celular, LN_codprodcontratado
        FROM  icc_movimiento mov
        WHERE mov.num_movimiento = EN_num_mov;

		sSql := sSql || 'SELECT sec.id_secuencia';
		sSql := sSql || 'FROM  ic_sectransaccion_to sec';
		sSql := sSql || 'WHERE sec.cod_prod_contratado = '|| LN_codprodcontratado;
		sSql := sSql || 'AND   sec.num_celular = '|| LN_num_celular;

        SELECT sec.id_secuencia
        INTO   LN_id_secuencia
        FROM  ic_sectransaccion_to sec
        WHERE sec.cod_prod_contratado = LN_codprodcontratado
		AND   sec.num_celular = LN_num_celular;

        LV_cadena := LV_cadena || 'secActu=' || TRIM(LN_id_secuencia);

        RETURN LV_cadena;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_BAJABONOS_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_BAJABONOS_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END IC_BAJABONOS_FN;


--------------------------------------------------
FUNCTION IC_ALTALISTA_FREC_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_ALTALISTA_FREC_FN"
                Lenguaje="PL/SQL"
                Fecha creación="01-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción> Funcion para obtener la cadena de comando asociada a un movimiento de Alta de Lista num frecuentes </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO"> Numero del Movimiento </param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.msgerror;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);

        sSql GE_Errores_PG.vQuery;

        LV_val_subparametro ic_detalle_movimiento_to.val_subparametro%TYPE;

        LV_cadena VARCHAR2(1000);

        CURSOR c_subp IS
                SELECT b.nom_subparametro, b.tip_subparametro
                FROM  ic_subparametro_td a, ic_codsubparametro_td b
                WHERE a.nom_parametro = CV_CmdAltaListaFrec
                AND     b.cod_subparametro = a.cod_subparametro;

BEGIN
		sSql := 'SELECT b.nom_subparametro, b.tip_subparametro';
		sSql := sSql || ' FROM ic_subparametro_td a, ic_codsubparametro_td b';
		sSql := sSql || ' WHERE a.nom_parametro = '''|| CV_CmdAltaListaFrec ||'''';
		sSql := sSql || ' AND b.cod_subparametro = a.cod_subparametro';

        FOR r_subp IN c_subp LOOP
                LV_val_subparametro := NULL;

				sSql := ' SELECT val_subparametro';
				sSql := sSql || ' FROM  ic_detalle_movimiento_to';
				sSql := sSql || ' WHERE num_movimiento = '|| EN_num_mov;
				sSql := sSql || ' AND nom_subparametro = '|| r_subp.nom_subparametro;

                SELECT val_subparametro
                INTO   LV_val_subparametro
                FROM  ic_detalle_movimiento_to
                WHERE num_movimiento = EN_num_mov
                AND     nom_subparametro = r_subp.nom_subparametro;

                LV_cadena := LV_cadena || r_subp.tip_subparametro || '=' || TRIM(LV_val_subparametro) || ',';
        END LOOP;

        IF LENGTH(LV_cadena) > 0 THEN
                LV_cadena := SUBSTR(LV_cadena,1,LENGTH(LV_cadena)-1);
        ELSE
		        LV_cadena := 'FALSE:SIN VALORES';
		END IF;

        RETURN LV_cadena;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_ALTALISTA_FREC_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_ALTALISTA_FREC_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END IC_ALTALISTA_FREC_FN;


--------------------------------------------------
FUNCTION IC_BAJALISTA_FREC_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
		) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_BAJALISTA_FREC_FN"
                Lenguaje="PL/SQL"
                Fecha creación="01-2008"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción> Funcion para obtener la cadena de comando asociada a un movimiento de Baja de Lista num frecuentes </Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO"> Numero del Movimiento </param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
        LN_cod_retorno ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.msgerror;
        LN_num_evento GE_Errores_PG.evento;
        LV_des_error VARCHAR2(512);

        sSql GE_Errores_PG.vQuery;

        LV_val_subparametro ic_detalle_movimiento_to.val_subparametro%TYPE;

        LV_cadena VARCHAR2(1000);

        CURSOR c_subp IS
                SELECT b.nom_subparametro, b.tip_subparametro
                FROM  ic_subparametro_td a, ic_codsubparametro_td b
                WHERE a.nom_parametro = CV_CmdBajaListaFrec
                AND     b.cod_subparametro = a.cod_subparametro;

BEGIN
		sSql := 'SELECT b.nom_subparametro, b.tip_subparametro';
		sSql := sSql || ' FROM ic_subparametro_td a, ic_codsubparametro_td b';
		sSql := sSql || ' WHERE a.nom_parametro = '''|| CV_CmdBajaListaFrec ||'''';
		sSql := sSql || ' AND b.cod_subparametro = a.cod_subparametro';

        FOR r_subp IN c_subp LOOP
                LV_val_subparametro := NULL;

				sSql := ' SELECT val_subparametro';
				sSql := sSql || ' FROM  ic_detalle_movimiento_to';
				sSql := sSql || ' WHERE num_movimiento = '|| EN_num_mov;
				sSql := sSql || ' AND nom_subparametro = '|| r_subp.nom_subparametro;

                SELECT val_subparametro
                INTO   LV_val_subparametro
                FROM  ic_detalle_movimiento_to
                WHERE num_movimiento = EN_num_mov
                AND     nom_subparametro = r_subp.nom_subparametro;

                LV_cadena := LV_cadena || r_subp.tip_subparametro || '=' || TRIM(LV_val_subparametro) || ',';
        END LOOP;

        IF LENGTH(LV_cadena) > 0 THEN
                LV_cadena := SUBSTR(LV_cadena,1,LENGTH(LV_cadena)-1);
        ELSE
		        LV_cadena := 'FALSE:SIN VALORES';
		END IF;

        RETURN LV_cadena;

EXCEPTION
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_BAJALISTA_FREC_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_BAJALISTA_FREC_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE';
END IC_BAJALISTA_FREC_FN;

FUNCTION IC_INFORMA_PA_FN(
        EN_num_mov IN icc_movimiento.num_movimiento%TYPE
  ) RETURN STRING
/*
<Documentación
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "IC_INFORMA_PA_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-2010"
                Creado por="Carlos Sellao H."
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción> Funcion para obtener los datos del plan adicional.</Descripción>
                <Parámetros>
                        <Entrada>
                                <param nom="EN_num_mov" Tipo="NUMERICO"> Numero del Movimiento </param>
                        </Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
AS
LN_cod_retorno   ge_errores_pg.coderror;
LV_mens_retorno  ge_errores_pg.msgerror;
LN_num_evento    GE_Errores_PG.evento;
LV_des_error     VARCHAR2(512);
sSql             GE_Errores_PG.vQuery;
LV_cadena         VARCHAR2(1000);
LN_num_abonado    icc_movimiento.num_abonado%TYPE;
LN_cod_espec_prov icc_movimiento.cod_espec_prov%TYPE;
LN_cod_prod_ofer  se_prod_provisionado_to.cod_prod_ofertado%TYPE;
LV_des_prod_ofer  se_prod_provisionado_to.des_prod_ofertado%TYPE;
LN_cod_prod_cont  se_prod_provisionado_to.cod_prod_contratado%TYPE;
error_controlado  exception;

BEGIN

    -- Lee abonado y producto desde el movimiento.-        
    sSql := 'SELECT num_abonado, cod_prod_contratado, cod_espec_prov';
    sSql := sSql||' INTO LN_num_abonado, LN_cod_prod_cont, LN_cod_espec_prov';
    sSql := sSql||' FROM icc_movimiento';    
    sSql := sSql||' WHERE num_movimiento = '||EN_num_mov;

    SELECT num_abonado, cod_prod_contratado, cod_espec_prov
    INTO LN_num_abonado, LN_cod_prod_cont, LN_cod_espec_prov
    FROM icc_movimiento
    WHERE num_movimiento = EN_num_mov;

    -- Rescata el plan adicional PA asociado al abonado.-
    sSql := 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_APROVISIONA_PA_PR( '||LN_num_abonado||', '||LN_cod_prod_cont||' )';    
    SE_PROD_PROVISIONADO_TO_SP_PG.SE_APROVISIONA_PA_PR (LN_num_abonado,LN_cod_prod_cont,LN_cod_prod_ofer,LV_des_prod_ofer,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

    IF LN_cod_retorno != 0 THEN
       RAISE error_controlado;
    END IF;

    --|  (pipe) se cambia por  <$>
    --,  (coma) se cambia por  <#>
    --;  (punto y coma) se cambia por  <@>

    LV_des_prod_ofer:=REPLACE(LV_des_prod_ofer,'|','<$>' );
    LV_des_prod_ofer:=REPLACE(LV_des_prod_ofer,',','<#>' );
    LV_des_prod_ofer:=REPLACE(LV_des_prod_ofer,';','<@>' );

    LV_cadena := 'padic='||TO_CHAR(LN_cod_prod_ofer)||',despadic='||LV_des_prod_ofer||',espec='||TO_CHAR(LN_cod_espec_prov);

    RETURN LV_cadena;

EXCEPTION
        WHEN error_controlado THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_INFORMA_PA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_INFORMA_PA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER EL PLAN ADIC.';
        WHEN OTHERS THEN
                LN_cod_retorno := CN_Err_Cli;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                        LV_mens_retorno := CV_Err_NoClasif;
                END IF;
                LV_des_error := 'IC_GENERACOMANDO_PG.IC_INFORMA_PA_FN('||EN_num_mov||'); - ' || SQLERRM;
                LN_num_evento := GE_ERRORES_PG.GRABARPL(LN_num_evento,'IC',LV_mens_retorno,'1.0',USER,'IC_GENERACOMANDO_PG.IC_INFORMA_PA_FN',sSql,SQLCODE,LV_des_error);
                RETURN 'FALSE: NO SE PUDO OBTENER EL PLAN ADIC.';
END IC_INFORMA_PA_FN;

END IC_GENERACOMANDO_PG;
/
SHOW ERRORS
