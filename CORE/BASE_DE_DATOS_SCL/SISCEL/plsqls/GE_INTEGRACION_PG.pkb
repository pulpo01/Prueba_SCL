CREATE OR REPLACE PACKAGE BODY GE_INTEGRACION_PG AS

    --------------------
    -- PROCEDIMIENTOS --
    --------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GE_INS_AUDITORIA_PR(EV_nom_usuario        IN  ge_auditoria_int_to.nom_usuario%TYPE,
                              EV_cod_puntoacceso    IN  ge_puntoacceso_int_td.cod_puntoacceso%TYPE,
                              EV_cod_aplicacion     IN  ge_aplicacion_int_td.cod_aplicacion%TYPE,
                              EV_cod_servicio       IN  ge_servicio_int_td.cod_servicio%TYPE,
                              SN_cod_auditoria      OUT NOCOPY ge_auditoria_int_to.cod_auditoria%TYPE,
                              SN_codRetorno         OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno         OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento          OUT NOCOPY ge_errores_pg.Evento)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        <Elemento
            Nombre = "GE_INS_AUDITORIA_PR"
            Lenguaje="PL/SQL"
            Fecha="29-05-2008"
            Versión="1.0.0"
            Diseñador="Joan Zamorano
            Programador="Joan Zamorano"
            Ambiente="BD">
            <Retorno>N/A</Retorno>
            <Descripción>Registra la auditoría de las llamadas realizadas a los servicios de integración</Descripción>
            <Parámetros>
                <Entrada>
                    <param nom="EV_nom_usuario"  Tipo="CARACTER">Nombre del usuario que ejecuta el servicio</param>
                    <param nom="EV_cod_puntoacceso"  Tipo="CARACTER">Código del punto de acceso o plataforma</param>
                    <param nom="EV_cod_aplicacion"  Tipo="CARACTER">Código de la aplicación que ejecuta el servicio</param>
                    <param nom="EV_cod_servicio"  Tipo="CARACTER">Código del servicio que se ejecuta</param>
                </Entrada>
                <Salida>
                    <param nom="SN_cod_auditoria" Tipo="NUMERICO">Codigo del registro de auditoría</param>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
                </Salida>
            </Parámetros>
        </Elemento>
    </Documentación>
    */

    PRAGMA AUTONOMOUS_TRANSACTION;
    error_exception     EXCEPTION;
    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;
    LV_nomSecuencia VARCHAR2(50):='ge_auditoria_int_sq';
    LV_errorclasif  VARCHAR2(100)      := 'Se ha producido un error al registrar auditoría de servicio';

BEGIN

    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql:='GE_INTEGRACION_PG.GE_CONS_NUM_SEC_PR(' || LV_nomSecuencia || ', SN_cod_auditoria, SN_codRetorno, SV_menRetorno, SN_numEvento)';

    GE_INTEGRACION_PG.ge_cons_num_sec_pr(LV_nomSecuencia, SN_cod_auditoria, SN_codRetorno, SV_menRetorno, SN_numEvento);

    IF SN_codRetorno <> 0 THEN
          RAISE error_exception;
    END IF;

    LV_Sql:='INSERT INTO ge_auditoria_int_to (cod_auditoria, nom_usuario, cod_puntoacceso, cod_aplicacion, cod_servicio)';
    LV_Sql:= LV_Sql || ' VALUES (';
    LV_Sql:= LV_Sql || SN_cod_auditoria || ', ';
    LV_Sql:= LV_Sql || EV_nom_usuario || ', ';
    LV_Sql:= LV_Sql || EV_cod_puntoacceso || ', ';
    LV_Sql:= LV_Sql || EV_cod_aplicacion || ', ';
    LV_Sql:= LV_Sql || EV_cod_servicio || ')';

    INSERT INTO ge_auditoria_int_to (cod_auditoria, nom_usuario, cod_puntoacceso, cod_aplicacion, cod_servicio)
    VALUES (SN_cod_auditoria, EV_nom_usuario, EV_cod_puntoacceso, EV_cod_aplicacion, EV_cod_servicio);

    COMMIT;

    EXCEPTION
        WHEN error_exception THEN
            SN_codRetorno := 301028;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_codRetorno,SV_menRetorno) THEN
                SV_menRetorno := CV_errornoclasificado;
            ELSE
                SV_menRetorno := SV_menRetorno   || LV_nomSecuencia;
            END IF;
            LV_des_error    :=  ' GE_INS_AUDITORIA_PR ('||'); - ' || SQLERRM;
            SN_numEvento    :=  Ge_Errores_Pg.Grabarpl(
                                SN_numEvento,
                                CV_MODULO_GE,
                                SV_menRetorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.GE_INS_AUDITORIA_PR',
                                LV_Sql,
                                SN_codRetorno,
                                LV_des_error);

        WHEN OTHERS THEN
            SN_codRetorno := 301001;
            IF NOT ge_errores_pg.mensajeerror(SN_codRetorno,SV_menRetorno) THEN
                SV_menRetorno := CV_errornoclasificado;
            ELSE
                SV_menRetorno := SV_menRetorno || SN_cod_auditoria;
            END IF;

            LV_des_error  := 'GE_INTEGRACION_PG.GE_INS_AUDITORIA_PR;- ' || SQLERRM;
            SN_numEvento := Ge_Errores_Pg.Grabarpl(SN_numEvento, CV_MODULO_GE, SV_menRetorno,CV_version, EV_nom_usuario, 'GE_INTEGRACION_PG.GE_INS_AUDITORIA_PR', LV_Sql, SQLCODE, LV_des_error);



END GE_INS_AUDITORIA_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GE_INS_PARAM_SERV_PR(EV_nom_usuario       IN  ge_auditoria_int_to.nom_usuario%TYPE,
                               EN_cod_auditoria     IN  ge_auditoria_int_to.cod_auditoria%TYPE,
                               EV_nom_parametro     IN  ge_param_serv_int_to.nom_parametro%TYPE,
                               EV_val_parametro     IN  ge_param_serv_int_to.val_parametro%TYPE,
                               SN_codRetorno        OUT NOCOPY ge_errores_pg.CodError,
                               SV_menRetorno        OUT NOCOPY ge_errores_pg.MsgError,
                               SN_numEvento         OUT NOCOPY ge_errores_pg.Evento)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        <Elemento
            Nombre = "GE_INS_PARAM_SERV_PR"
            Lenguaje="PL/SQL"
            Fecha="29-05-2008"
            Versión="1.0.0"
            Diseñador="Joan Zamorano
            Programador="Joan Zamorano"
            Ambiente="BD">
            <Retorno>N/A</Retorno>
            <Descripción>Registra los parámetros de los servicios asociados a un registro de auditoría</Descripción>
            <Parámetros>
                <Entrada>
                    <param nom="EV_nom_usuario"  Tipo="CARACTER">Nombre del usuario que ejecuta el servicio</param>
                    <param nom="EN_cod_auditoria"  Tipo="NUMERICO">Código del registro de auditoría asociado al parámetro</param>
                    <param nom="EV_nom_parametro"  Tipo="CARACTER">Nombre del parámetro de un servicio asociado al registro de una auditoría</param>
                    <param nom="EV_val_parametro"  Tipo="CARACTER">Valor del parámetro de un servicio asociado al registro de una auditoría</param>
                    <param nom="EV_cod_servicio"  Tipo="CARACTER">Código del servicio que se ejecuta</param>
                </Entrada>
                <Salida>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de retorno</param>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>
                </Salida>
            </Parámetros>
        </Elemento>
    </Documentación>
    */

    PRAGMA AUTONOMOUS_TRANSACTION;
    error_exception     EXCEPTION;
    LV_des_error         ge_errores_pg.desevent;
    LV_sql                 ge_errores_pg.vquery;
    LV_nomSecuencia     VARCHAR2(50):='ge_param_serv_int_sq';
    LV_errorclasif      VARCHAR2(150)      := 'Se ha producido un error al registrar el parámetro del servicio asociado a la auditoría de código: ' || EN_cod_auditoria;
    LN_cod_parametro    ge_param_serv_int_to.cod_parametro%TYPE;

BEGIN

    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql:='GE_INTEGRACION_PG.GE_CONS_NUM_SEC_PR(' || LV_nomSecuencia || ', LN_cod_parametro, SN_codRetorno, SV_menRetorno, SN_numEvento)';

    GE_INTEGRACION_PG.ge_cons_num_sec_pr(LV_nomSecuencia, LN_cod_parametro, SN_codRetorno, SV_menRetorno, SN_numEvento);

    IF SN_codRetorno <> 0 THEN
          RAISE error_exception;
    END IF;

    LV_Sql:='INSERT INTO ge_param_serv_int_to (cod_parametro, cod_auditoria, nom_parametro, val_parametro)';
    LV_Sql:= LV_Sql || ' VALUES (';
    LV_Sql:= LV_Sql || LN_cod_parametro || ', ';
    LV_Sql:= LV_Sql || EN_cod_auditoria || ', ';
    LV_Sql:= LV_Sql || EV_nom_parametro || ', ';
    LV_Sql:= LV_Sql || EV_val_parametro || ')';

    INSERT INTO ge_param_serv_int_to (cod_parametro, cod_auditoria, nom_parametro, val_parametro)
    VALUES (LN_cod_parametro, EN_cod_auditoria, EV_nom_parametro, EV_val_parametro);

    COMMIT;

    EXCEPTION

        WHEN error_exception THEN
            SN_codRetorno := 301028;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_codRetorno,SV_menRetorno) THEN
                SV_menRetorno := CV_errornoclasificado;
            ELSE
                SV_menRetorno := SV_menRetorno ||  LV_nomSecuencia;
            END IF;
            LV_des_error    :=  ' GE_INS_PARAM_SERV_PR ('||'); - ' || SQLERRM;
            SN_numEvento    :=  Ge_Errores_Pg.Grabarpl(
                                SN_numEvento,
                                CV_MODULO_GE,
                                SV_menRetorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.GE_INS_PARAM_SERV_PR',
                                LV_Sql,
                                SN_codRetorno,
                                LV_des_error);

        WHEN OTHERS THEN
            SN_codRetorno := 301001;
            IF NOT ge_errores_pg.mensajeerror(SN_codRetorno,SV_menRetorno) THEN
                SV_menRetorno := CV_errornoclasificado;
            ELSE
               SV_menRetorno := SV_menRetorno ||  EN_cod_auditoria;
            END IF;
            LV_des_error  := 'GE_INTEGRACION_PG.GE_INS_PARAM_SERV_PR;- ' || SQLERRM;
            SN_numEvento := Ge_Errores_Pg.Grabarpl(SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, EV_nom_usuario, 'GE_INTEGRACION_PG.GE_INS_PARAM_SERV_PR', LV_Sql, SQLCODE, LV_des_error);

END GE_INS_PARAM_SERV_PR;

---------------------------------------------------------------------------------------------------
PROCEDURE ge_consultar_pto_acceso_pr (EV_punto_Acceso     IN GE_PUNTOACCESO_INT_TD.COD_PUNTOACCESO%TYPE,
                                      SV_des_punto_acceso OUT NOCOPY GE_PUNTOACCESO_INT_TD.DES_PUNTOACCESO%TYPE,
                                      SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_val_clie_telef_pr"
        Lenguaje="PL/SQL"
        Fecha="24-07-2009"
        Versión="1.0.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> boolean </Retorno>
    <Descripción>
         Retorna descriopcion de Punto de Acceso segun su Codigo
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EV_punto_Acceso"  Tipo="GE_PUNTOACCESO_INT_TD.DES_PUNTOACCESO%TYPE">Codigo Punto de acceso</param>
    </Entrada>
    <Salida>
        <param nom="SV_des_punto_acceso" Tipo="GE_PUNTOACCESO_INT_TD.COD_PUNTOACCESO%TYPE">Descripcion de Punto de acceso</param>
        <param nom="SN_cod_retorno"      Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"     Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"       Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;
     LN_cont number;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;
    LN_cont :=0;

    LV_sSql := 'SELECT DES_PUNTOACCESO INTO SV_des_punto_acceso'
            ||' FROM GE_PUNTOACCESO_INT_TD'
            ||' WHERE cod_puntoacceso = '||EV_punto_Acceso;


               SELECT DES_PUNTOACCESO INTO SV_des_punto_acceso
               FROM GE_PUNTOACCESO_INT_TD
               WHERE cod_puntoacceso = EV_punto_Acceso;


EXCEPTION

      WHEN NO_DATA_FOUND THEN
          sn_cod_retorno := 301002;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_consultar_pto_acceso_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG..ge_consultar_pto_acceso_pr', lv_ssql, sn_cod_retorno, LV_des_error );

      WHEN OTHERS THEN
          sn_cod_retorno := 301002;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_consultar_pto_acceso_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_consultar_pto_acceso_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

-------------------------------------------------------------------------------------------------------------
PROCEDURE ge_validar_aplicacion_pr (EV_aplicacion   IN GE_APLICACION_INT_TD.COD_APLICACION%TYPE,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_val_clie_telef_pr"
        Lenguaje="PL/SQL"
        Fecha="24-07-2009"
        Versión="1.0.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> Respuesta DTO </Retorno>
    <Descripción>
         Retorna DTO de Respuesta para saber si hubo error al validar
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EV_aplicacion"  Tipo="GE_APLICACION_INT_TD.COD_APLICACION%TYPE">Codigo de la Aplicacion</param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"    Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;
     LN_cont number;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;
    LN_cont :=0;

    LV_sSql := 'SELECT COUNT(*) INTO LN_cont '
            ||' FROM GE_APLICACION_INT_TD'
            ||' WHERE COD_APLICACION = '||EV_aplicacion;


                SELECT COUNT(1) INTO LN_cont
                FROM GE_APLICACION_INT_TD
                WHERE COD_APLICACION = EV_aplicacion;

                if LN_cont = 0 then
                    RAISE cursorVacio_exception;
                end if;

EXCEPTION

      WHEN cursorVacio_exception THEN
          sn_cod_retorno := 301003;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_validar_aplicacion_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_validar_aplicacion_pr', lv_ssql, sn_cod_retorno, LV_des_error );

      WHEN OTHERS THEN
          sn_cod_retorno := 301003;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_validar_aplicacion_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_validar_aplicacion_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

--------------------------------------------------------------------------------------------
PROCEDURE ge_validar_servicio_pr (EV_servicio     IN GE_SERVICIO_INT_TD.COD_SERVICIO%TYPE,
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_val_clie_telef_pr"
        Lenguaje="PL/SQL"
        Fecha="24-07-2009"
        Versión="1.0.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> Respuesta DTO </Retorno>
    <Descripción>
         Retorna DTO de Respuesta para saber si hubo error al validar
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EV_servicio"  Tipo="GE_SERVICIO_INT_TD.COD_SERVICIO%TYPE">Codigo de Servicio</param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"    Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;
     LN_cont number;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;
    LN_cont :=0;

    LV_sSql := 'SELECT COUNT(*) INTO LN_cont '
            ||' FROM GE_SERVICIO_INT_TD'
            ||' WHERE COD_SERVICIO = '||EV_servicio;

                SELECT COUNT(1) INTO LN_cont
                FROM GE_SERVICIO_INT_TD
                WHERE COD_SERVICIO = EV_servicio;

                if LN_cont = 0 then
                   RAISE cursorVacio_exception;
                end if;

EXCEPTION

       WHEN cursorVacio_exception THEN
          sn_cod_retorno := 301004;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_validar_servicio_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_validar_servicio_pr', lv_ssql, sn_cod_retorno, LV_des_error );

      WHEN OTHERS THEN
          sn_cod_retorno := 301004;

          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_validar_servicio_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_validar_servicio_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

--------------------------------------------------------------------------------------------
PROCEDURE ge_validar_usuario_pr  (EV_usuario      IN GE_AUDITORIA_INT_TO.NOM_USUARIO%TYPE,
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_val_clie_telef_pr"
        Lenguaje="PL/SQL"
        Fecha="24-07-2009"
        Versión="1.0.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> Respuesta DTO </Retorno>
    <Descripción>
         Retorna DTO de Respuesta para saber si hubo error al validar
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EV_usuario"  Tipo="GE_AUDITORIA_INT_TO.NOM_USUARIO%TYPE">nombre de Usuario</param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"    Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;
     LN_cont number;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;
    LN_cont :=0;

    LV_sSql := 'SELECT COUNT(*) INTO LN_cont '
            ||' FROM GE_SEG_USUARIO'
            ||' WHERE NOM_USUARIO = '||EV_usuario;

                SELECT COUNT(1)
                INTO LN_cont
                FROM ge_seg_usuario a
                WHERE a.nom_usuario = EV_usuario AND
                      a.ind_activo = 'Y';

                if LN_cont = 0 then
                   RAISE cursorVacio_exception;
                end if;

EXCEPTION

       WHEN cursorVacio_exception THEN
          sn_cod_retorno := 301005;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_validar_usuario_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_validar_usuario_pr', lv_ssql, sn_cod_retorno, LV_des_error );

      WHEN OTHERS THEN
          sn_cod_retorno := 301005;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_validar_usuario_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_validar_usuario_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ge_val_num_hib_pr(
        EN_numTelefono    IN ga_abocel.NUM_CELULAR%TYPE,
        SN_cod_retorno   OUT NOCOPY   ge_errores_pg.CodError,
        SV_mens_retorno  OUT NOCOPY   ge_errores_pg.MsgError,
        SN_num_evento    OUT NOCOPY   ge_errores_pg.Evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_val_num_hib_pr"
        Lenguaje="PL/SQL"
        Fecha="29-05-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> N/A </Retorno>

    <Descripción>
        Este procedimiento consulta si un numero es "HIBRIDO",
        además valida si el número corresponde a un celular
        y no debe estar dado de baja ni tampoco en proceso de baja.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_numTelefono"  Tipo="NUMBER(15)">
        Variable de Entrada Numero de Celular </param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    i integer;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql:= 'SELECT 1 ';
        LV_sSql:= LV_sSql||' FROM ga_abocel b, ta_plantarif a ';
        LV_sSql:= LV_sSql||' WHERE a.cod_plantarif = b.cod_plantarif AND ';
        LV_sSql:= LV_sSql||' b.num_celular = '||EN_numTelefono||' AND ';
        LV_sSql:= LV_sSql||' b.cod_situacion NOT IN (''BAA'',''BAP'') AND ';
        LV_sSql:= LV_sSql||' a.cod_tiplan = (SELECT a.cod_valor FROM ged_codigos a ';
        LV_sSql:= LV_sSql||' WHERE a.cod_modulo = ''GE'' AND a.nom_tabla = ''TA_PLANTARIF''';
        LV_sSql:= LV_sSql||' AND a.nom_columna = ''COD_TIPLAN'' AND a.des_valor = ''HIBRIDO''';

        SELECT 1 into i
        FROM    ga_abocel b, ta_plantarif a
        WHERE   a.cod_plantarif = b.cod_plantarif
        AND     b.num_celular   = EN_numTelefono
        AND     b.cod_situacion NOT IN ('BAA','BAP')
        AND     a.cod_tiplan    = (SELECT a.cod_valor
            FROM  ged_codigos a
            WHERE a.cod_modulo  = 'GE'
            AND   a.nom_tabla   = 'TA_PLANTARIF'
            AND      a.nom_columna = 'COD_TIPLAN'
            AND   a.des_valor   = 'HIBRIDO');

EXCEPTION
        WHEN no_data_found THEN
            SN_cod_retorno := 301007;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_errornoclasificado;
            END IF;


        WHEN OTHERS THEN
            SN_cod_retorno := 301006;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_val_num_hib_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_val_num_hib_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

    END ge_val_num_hib_pr;

-----------------------------------------------------------------------------

PROCEDURE ge_cons_link_fact_pr (
        EN_num_proceso    IN              fa_interimpresion_td.num_proceso%TYPE,
        EN_cod_cliente    IN              fa_interimpresion_td.cod_cliente%TYPE,
        SV_rutafac        OUT NOCOPY      VARCHAR2,
        SN_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
        SV_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
        SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_cons_link_fact_pr"
        Lenguaje="PL/SQL"
        Fecha="08-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> VARCHAR2 </Retorno>

    <Descripción>
        Este procedimiento retorna un link
        asociado al número de proceso ingresado.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_num_proceso"  Tipo="NUMBER(8)">
        Variable de entrada Numero de Proceso </param>
        <param nom="EN_cod_cliente"  Tipo="NUMBER(8)">
        Variable de entrada Codigo Cliente </param>
    </Entrada>
    <Salida>
        <param nom="SV_rutafac" Tipo="VARCHAR2">
        Variable de salida Ruta de Factura
        (fad_parametros.val_caracter + fa_interimpresion_td.dir_web)
        </param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    CN_num              CONSTANT NUMBER := 66;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';


    LV_sSql := 'SELECT b.val_caracter || a.dir_web ';
    LV_sSql := LV_sSql || ' FROM fa_interimpresion_td a, fad_parametros b ';
    LV_sSql := LV_sSql || ' WHERE a.num_proceso = ' || EN_num_proceso;
    LV_sSql := LV_sSql || ' AND a.cod_cliente = ' || EN_cod_cliente;
    LV_sSql := LV_sSql || ' AND b.cod_parametro = '||CN_num;

    SELECT  b.val_caracter || a.dir_web into SV_rutafac
    FROM    fa_interimpresion_td a, fad_parametros b
    WHERE   a.num_proceso   = EN_num_proceso
    AND     a.cod_cliente   = EN_cod_cliente
    AND     b.cod_parametro = CN_num;

EXCEPTION

        WHEN OTHERS THEN
            SN_cod_retorno := 301008;
             IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_link_fact_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_link_fact_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );
    END ge_cons_link_fact_pr;

-----------------------------------------------------------------------------

PROCEDURE ge_cons_ciclo_fact_pr(
        EN_codCiclo         IN          ge_clientes.cod_ciclo%TYPE,
        SN_codCicloFact     OUT NOCOPY  fa_ciclfact.cod_ciclfact%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)
IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_cons_ciclo_fact_pr"
        Lenguaje="PL/SQL"
        Fecha="16-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> NUMBER(6) </Retorno>

    <Descripción>
        Este procedimiento consulta el código del ciclo de
        facturación vigente para el código de ciclo del cliente.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_codCiclo"  Tipo="NUMBER(2)">
        Variable de entrada Codigo Ciclo</param>
    </Entrada>
    <Salida>
        <param nom="SN_codCicloFact" Tipo="NUMBER(6)">
        Variable de salida Codigo del Ciclo de Facturación</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    LV_sSql := 'SELECT a.cod_ciclfact ';
    LV_sSql := LV_sSql || ' FROM fa_ciclfact a WHERE a.cod_ciclo = ';
    LV_sSql := LV_sSql || EN_codCiclo;
    LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN a.fec_desdellam AND a.fec_hastallam';

    SELECT  a.cod_ciclfact into SN_codCicloFact
    FROM    fa_ciclfact a
    WHERE   a.cod_ciclo = EN_codCiclo
    AND     SYSDATE BETWEEN a.fec_desdellam
    AND     a.fec_hastallam;

    EXCEPTION

        WHEN OTHERS THEN
            SN_cod_retorno := 301010;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_ciclo_fact_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_ciclo_fact_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_cons_ciclo_fact_pr;

-----------------------------------------------------------------------------

PROCEDURE ge_val_clie_facturable_pr(
        EN_codCliente       IN          ga_infaccel.cod_cliente%TYPE,
        EN_numAbonado       IN          ga_infaccel.num_abonado%TYPE,
        EN_codCicloFact     IN          ga_infaccel.cod_ciclfact%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)
IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_val_clie_facturable_pr"
        Lenguaje="PL/SQL"
        Fecha="16-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> N/A </Retorno>

    <Descripción>
        Este procedimiento valida que el cliente
        y teléfono se encuentren facturables.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_codCliente"  Tipo="NUMBER(8)">
        Variable de entrada Código de Cliente </param>
        <param nom="EN_numAbonado"  Tipo="NUMBER(8)">
        Variable de entrada Numero de Abonado/Producto </param>
        <param nom="EN_codCicloFact"  Tipo="NUMBER(6)">
        Variable de entrada Ciclo de Facturación Vigencia </param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    i integer;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    CN_ind_factur       CONSTANT NUMBER := 1;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    LV_sSql := 'SELECT 1 FROM ga_infaccel a WHERE a.cod_cliente = ';
    LV_sSql := LV_sSql || EN_codCliente;
    LV_sSql := LV_sSql || ' AND a.num_abonado = ';
    LV_sSql := LV_sSql || EN_numAbonado;
    LV_sSql := LV_sSql || ' AND a.cod_ciclfact = ';
    LV_sSql := LV_sSql || EN_codCicloFact;
    LV_sSql := LV_sSql || ' AND a.fec_alta <= SYSDATE AND a.ind_factur = ';
    LV_sSql := LV_sSql || CN_ind_factur;


    SELECT  1 into i
    FROM    ga_infaccel a
    WHERE   a.cod_cliente   = EN_codCliente
    AND     a.num_abonado   = EN_numAbonado
    AND     a.cod_ciclfact  = EN_codCicloFact
    AND     a.fec_alta      <= SYSDATE
    AND     a.ind_factur    = CN_ind_factur;

EXCEPTION
        WHEN no_data_found THEN
            SN_cod_retorno := 301012;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_val_clie_facturable_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_val_clie_facturable_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );


        WHEN OTHERS THEN
            SN_cod_retorno := 301011;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_val_clie_facturable_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_val_clie_facturable_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_val_clie_facturable_pr;


------------------------------------------------------------------------------

PROCEDURE ge_obtener_saldo_clie_pr(
        EN_codCliente        IN         ge_clientes.cod_cliente%TYPE,
        SN_saldoCliente     OUT NOCOPY  CO_CARTERA.IMPORTE_DEBE%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)

IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_obtener_saldo_clie_pr"
        Lenguaje="PL/SQL"
        Fecha="01-07-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> NUMBER </Retorno>

    <Descripción>
        Este procedimiento retorna saldo total de un cliente.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_codCliente"  Tipo="NUMBER(8)">
        Variable de entrada Código de Cliente </param>
    </Entrada>
    <Salida>
        <param nom="SN_saldoCliente" Tipo="NUMBER">
        Saldo total de un cliente </param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    LN_numDecimal       ged_parametros.VAL_PARAMETRO%TYPE;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='null';
    LV_sSql := ('co_saldo_fn('||EN_codCliente||')');

    SN_saldoCliente := co_saldo_fn(EN_codCliente);

    LV_Ssql:='SELECT VAL_PARAMETRO '
    || 'FROM GED_PARAMETROS '
    || ' WHERE NOM_PARAMETRO=NUM_DECIMAL';


    SELECT VAL_PARAMETRO
    INTO LN_numDecimal
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO ='NUM_DECIMAL';


    SELECT ROUND(SN_saldoCliente,LN_numDecimal)
    INTO SN_saldoCliente
    FROM DUAL;


EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno := 301013;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_obtener_saldo_clie_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_obtener_saldo_clie_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_obtener_saldo_clie_pr;

-----------------------------------------------------------------------------


PROCEDURE ge_cons_planes_disponibles_pr(
        EN_grpPrestacion    IN  VARCHAR2 ,
        EN_codPrestacion    IN  VARCHAR2 ,
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)

IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_cons_planes_disponibles_pr"
        Lenguaje="PL/SQL"
        Fecha="16-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> CURSOR </Retorno>

    <Descripción>
        Este procedimiento devuelve todos los planes tarifarios vigentes
        asociados a los grupos de prestación y códigos de prestación ingresados.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_grpPrestacion"  Tipo="VARCHAR2">
        Variable de entrada grupos de prestación </param>
        <param nom="EN_codPrestacion"  Tipo="VARCHAR2">
        Variable de entrada códigos de prestación </param>
    </Entrada>
    <Salida>
        <param nom="cod_plantarif" Tipo="VARCHAR2(3)">
        Variable de salida Codigo de Plan Tarifario</param>

        <param nom="des_plantarif" Tipo="VARCHAR2(30)">
        Variable de salida Descripcion de Plan Tarifario</param>

        <param nom="grp_prestacion" Tipo="VARCHAR2(5)">
        Variable de salida Grupo Prestación (Ged_Codigos)</param>

        <param nom="des_grupo_prestacion" Tipo="VARCHAR2(512)">
        Variable de salida Descripción de codigo asignado</param>

        <param nom="cod_prestacion" Tipo="VARCHAR2(5)">
        Variable de salida Código de Prestación (ge_prestaciones_td)</param>

        <param nom="des_prestacion" Tipo="VARCHAR2(50)">
        Variable de salida Descripción de la Prestación</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    i number;
BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

        LV_sSql := 'SELECT COUNT(*)
                    FROM ta_plantarif a, ged_codigos b, ge_prestaciones_td c
                    WHERE a.grp_prestacion = b.cod_valor AND
                        a.cod_prestacion = c.cod_prestacion AND
                        SYSDATE BETWEEN a.fec_desde AND a.fec_hasta AND
                        a.grp_prestacion IN (' || EN_grpPrestacion || ') AND
                        a.cod_prestacion IN (' || EN_codPrestacion || ') AND
                        b.nom_tabla = ''GE_PRESTACIONES_TD'' AND
                        b.nom_columna = ''GRP_PRESTACION'' AND
                        b.cod_modulo = ''GA''
                    ORDER BY a.grp_prestacion, a.cod_prestacion, a.des_plantarif ASC';

        EXECUTE IMMEDIATE LV_sSql INTO i;

        LV_sSql := 'SELECT  a.cod_plantarif, a.des_plantarif, a.grp_prestacion,';
        LV_sSql := LV_sSql || '        b.des_valor AS des_grupo_prestacion, a.cod_prestacion, c.des_prestacion';
        LV_sSql := LV_sSql || ' FROM    ta_plantarif a, ged_codigos b, ge_prestaciones_td c';
        LV_sSql := LV_sSql || ' WHERE   a.grp_prestacion = b.cod_valor AND';
        LV_sSql := LV_sSql || '        a.cod_prestacion = c.cod_prestacion AND';
        LV_sSql := LV_sSql || '        SYSDATE BETWEEN a.fec_desde AND a.fec_hasta AND';
        LV_sSql := LV_sSql || '        a.grp_prestacion IN (' || EN_grpPrestacion || ') AND';
        LV_sSql := LV_sSql || '        a.cod_prestacion IN (' || EN_codPrestacion || ') AND';
        LV_sSql := LV_sSql || '        b.nom_tabla = ''GE_PRESTACIONES_TD'' AND';
        LV_sSql := LV_sSql || '        b.nom_columna = ''GRP_PRESTACION'' AND';
        LV_sSql := LV_sSql || '        b.cod_modulo = ''GA''';
        LV_sSql := LV_sSql || ' ORDER BY a.grp_prestacion, a.cod_prestacion, a.des_plantarif ASC';

        if i = 0 then
            RAISE cursorVacio_exception;
        end if;

        OPEN sc_cursor FOR LV_sSql;

    EXCEPTION
            WHEN cursorVacio_exception THEN
            SN_cod_retorno := 301014;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_planes_disponibles_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

        WHEN OTHERS THEN
            SN_cod_retorno := 301014;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_planes_disponibles_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_cons_planes_disponibles_pr;

-----------------------------------------------------------------------------


PROCEDURE ge_cons_planes_disponibles_pr(
        EN_grpPrestacion    IN  VARCHAR2 ,
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)

IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_cons_planes_disponibles_pr"
        Lenguaje="PL/SQL"
        Fecha="16-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> CURSOR </Retorno>

    <Descripción>
        Este procedimiento devuelve todos los planes tarifarios vigentes
        asociados a los grupos de prestación ingresados.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_grpPrestacion"  Tipo="VARCHAR2">
        Variable de entrada grupos de prestación </param>
    </Entrada>
    <Salida>
        <param nom="cod_plantarif" Tipo="VARCHAR2(3)">
        Variable de salida Codigo de Plan Tarifario</param>

        <param nom="des_plantarif" Tipo="VARCHAR2(30)">
        Variable de salida Descripcion de Plan Tarifario</param>

        <param nom="grp_prestacion" Tipo="VARCHAR2(5)">
        Variable de salida Grupo Prestación (Ged_Codigos)</param>

        <param nom="des_grupo_prestacion" Tipo="VARCHAR2(512)">
        Variable de salida Descripción de codigo asignado</param>

        <param nom="cod_prestacion" Tipo="VARCHAR2(5)">
        Variable de salida Código de Prestación (ge_prestaciones_td)</param>

        <param nom="des_prestacion" Tipo="VARCHAR2(50)">
        Variable de salida Descripción de la Prestación</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    i number;
BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

        LV_sSql := 'SELECT COUNT(*)
                    FROM ta_plantarif a, ged_codigos b, ge_prestaciones_td c
                    WHERE a.grp_prestacion = b.cod_valor AND
                        a.cod_prestacion = c.cod_prestacion AND
                        SYSDATE BETWEEN a.fec_desde AND a.fec_hasta AND
                        a.grp_prestacion IN (' || EN_grpPrestacion || ') AND
                        b.nom_tabla = ''GE_PRESTACIONES_TD'' AND
                        b.nom_columna = ''GRP_PRESTACION'' AND
                        b.cod_modulo = ''GA''
                    ORDER BY a.grp_prestacion, a.cod_prestacion, a.des_plantarif ASC';

        EXECUTE IMMEDIATE LV_sSql INTO i;

        LV_sSql := 'SELECT  a.cod_plantarif, a.des_plantarif, a.grp_prestacion,';
        LV_sSql := LV_sSql || '        b.des_valor AS des_grupo_prestacion, a.cod_prestacion, c.des_prestacion';
        LV_sSql := LV_sSql || ' FROM    ta_plantarif a, ged_codigos b, ge_prestaciones_td c';
        LV_sSql := LV_sSql || ' WHERE   a.grp_prestacion = b.cod_valor AND';
        LV_sSql := LV_sSql || '        a.cod_prestacion = c.cod_prestacion AND';
        LV_sSql := LV_sSql || '        SYSDATE BETWEEN a.fec_desde AND a.fec_hasta AND';
        LV_sSql := LV_sSql || '        a.grp_prestacion IN (' || EN_grpPrestacion || ') AND';
        LV_sSql := LV_sSql || '        b.nom_tabla = ''GE_PRESTACIONES_TD'' AND';
        LV_sSql := LV_sSql || '        b.nom_columna = ''GRP_PRESTACION'' AND';
        LV_sSql := LV_sSql || '        b.cod_modulo = ''GA''';
        LV_sSql := LV_sSql || ' ORDER BY a.grp_prestacion, a.cod_prestacion, a.des_plantarif ASC';

        if i = 0 then
            RAISE cursorVacio_exception;
        end if;

        OPEN sc_cursor FOR LV_sSql;

    EXCEPTION
            WHEN cursorVacio_exception THEN
            SN_cod_retorno := 301014;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_planes_disponibles_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

        WHEN OTHERS THEN
            SN_cod_retorno := 301014;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_planes_disponibles_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_cons_planes_disponibles_pr;

-----------------------------------------------------------------------------

PROCEDURE ge_cons_planes_disponibles_pr(
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)

IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_cons_planes_disponibles_pr"
        Lenguaje="PL/SQL"
        Fecha="16-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> CURSOR </Retorno>

    <Descripción>
        Este procedimiento devuelve todos los planes tarifarios vigentes.
    </Descripción>

    <Parámetros>
    <Entrada>
    </Entrada>
    <Salida>
        <param nom="cod_plantarif" Tipo="VARCHAR2(3)">
        Variable de salida Codigo de Plan Tarifario</param>

        <param nom="des_plantarif" Tipo="VARCHAR2(30)">
        Variable de salida Descripcion de Plan Tarifario</param>

        <param nom="grp_prestacion" Tipo="VARCHAR2(5)">
        Variable de salida Grupo Prestación (Ged_Codigos)</param>

        <param nom="des_grupo_prestacion" Tipo="VARCHAR2(512)">
        Variable de salida Descripción de codigo asignado</param>

        <param nom="cod_prestacion" Tipo="VARCHAR2(5)">
        Variable de salida Código de Prestación (ge_prestaciones_td)</param>

        <param nom="des_prestacion" Tipo="VARCHAR2(50)">
        Variable de salida Descripción de la Prestación</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    LV_error_clasif     CONSTANT VARCHAR2 (100) := 'No ha sido posible obtener planes tarifarios vigentes para la consulta realizada';
    i number;
BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    LV_sSql := 'SELECT  a.cod_plantarif, a.des_plantarif, a.grp_prestacion, b.des_valor
                AS      des_grupo_prestacion, a.cod_prestacion, c.des_prestacion
                FROM    ta_plantarif a, ged_codigos b, ge_prestaciones_td c
                WHERE   a.grp_prestacion = b.cod_valor AND
                        a.cod_prestacion = c.cod_prestacion AND
                        SYSDATE BETWEEN a.fec_desde AND a.fec_hasta AND
                        b.nom_tabla = ''GE_PRESTACIONES_TD'' AND
                        b.nom_columna = ''GRP_PRESTACION'' AND
                        b.cod_modulo = ''GA''
                ORDER BY a.grp_prestacion, a.cod_prestacion, a.des_plantarif ASC';

        SELECT count(*) into i
            FROM    ta_plantarif a, ged_codigos b, ge_prestaciones_td c
            WHERE   a.grp_prestacion = b.cod_valor AND
                    a.cod_prestacion = c.cod_prestacion AND
                    SYSDATE BETWEEN a.fec_desde AND a.fec_hasta AND
                    b.nom_tabla = 'GE_PRESTACIONES_TD' AND
                    b.nom_columna = 'GRP_PRESTACION' AND
                    b.cod_modulo = 'GA'
            ORDER BY a.grp_prestacion, a.cod_prestacion, a.des_plantarif ASC;

        if i = 0 then
            RAISE cursorVacio_exception;
        end if;

        OPEN SC_cursor FOR
            SELECT  a.cod_plantarif, a.des_plantarif, a.grp_prestacion, b.des_valor
            AS      des_grupo_prestacion, a.cod_prestacion, c.des_prestacion
            FROM    ta_plantarif a, ged_codigos b, ge_prestaciones_td c
            WHERE   a.grp_prestacion = b.cod_valor AND
                    a.cod_prestacion = c.cod_prestacion AND
                    SYSDATE BETWEEN a.fec_desde AND a.fec_hasta AND
                    b.nom_tabla = 'GE_PRESTACIONES_TD' AND
                    b.nom_columna = 'GRP_PRESTACION' AND
                    b.cod_modulo = 'GA'
            ORDER BY a.grp_prestacion, a.cod_prestacion, a.des_plantarif ASC;

        EXCEPTION
        WHEN cursorVacio_exception THEN
            SN_cod_retorno := 301014;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_planes_disponibles_pr ('||'); - ' || SQLERRM;

            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

        WHEN OTHERS THEN
            SN_cod_retorno := 301014;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_cons_planes_disponibles_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_cons_planes_disponibles_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_cons_planes_disponibles_pr;


---------------------------------------------------------------------------------
PROCEDURE ge_val_soporte_gprs_pr (
        EN_num_abonado      IN  ga_abocel.Num_abonado%TYPE,
        EV_cod_tecnologia   IN  ga_abocel.Cod_tecnologia%TYPE,
        EV_num_serie        IN  ga_abocel.Num_serie%TYPE,
        EV_num_imei         IN  ga_abocel.num_imei%TYPE,
        EV_cod_servicio     IN  gad_servsup_art.cod_servicio%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)

IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_val_soporte_gprs_pr"
        Lenguaje="PL/SQL"
        Fecha="16-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno>  </Retorno>

    <Descripción>
        Este procedimiento valida si un determinado
        modelo de equipo soporta tiene soporte GPRS.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_num_abonado" Tipo="NUMBER(8)">
        Variable de entrada Secuencia Numero Abonado</param>
        <param nom="EV_cod_tecnologia" Tipo="VARCHAR2(7)">
        Variable de entrada Codigo Tecnologia</param>
        <param nom="EV_num_serie" Tipo="VARCHAR2(25)">
        Variable de entrada Numero de Serie Decimal</param>
        <param nom="EV_num_imei" Tipo="VARCHAR2(25)">
        Variable de entrada Numero Serie Terminal GSM</param>
        <param nom="EV_cod_servicio" Tipo="VARCHAR2(4)">
        Variable de entrada código de servicio a validar</param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    i integer;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    LN_num_abonado      ga_abocel.Num_abonado%TYPE;
BEGIN
    i := 0;
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    IF EV_cod_tecnologia = 'GSM'
    THEN

        LV_sSql := 'SELECT 1 FROM ga_equipaboser a, gad_servsup_art b ';
        LV_sSql := LV_sSql || ' WHERE   a.cod_articulo = b.cod_articulo AND ';
        LV_sSql := LV_sSql || ' a.num_abonado = ' || EN_num_abonado || ' AND ';
        LV_sSql := LV_sSql || ' a.num_serie = ' || EV_num_imei || ' AND ';
        LV_sSql := LV_sSql || ' b.cod_producto = 1 AND b.cod_servicio = ' || EV_cod_servicio;

        SELECT 1 into i
        FROM ga_equipaboser a, gad_servsup_art b
        WHERE   a.cod_articulo = b.cod_articulo AND
                a.num_abonado  = EN_num_abonado AND
                a.num_serie    = EV_num_imei AND
                b.cod_producto = 1 AND
                b.cod_servicio = EV_cod_servicio;

    ELSE
        LV_sSql := 'SELECT 1 FROM ga_equipaboser a, gad_servsup_art b ';
        LV_sSql := LV_sSql || ' WHERE   a.cod_articulo = b.cod_articulo AND ';
        LV_sSql := LV_sSql || ' a.num_abonado = ' || EN_num_abonado || ' AND ';
        LV_sSql := LV_sSql || ' a.num_serie = ' || EV_num_serie || ' AND ';
        LV_sSql := LV_sSql || ' b.cod_producto = 1 AND b.cod_servicio = ' || EV_cod_servicio;

        SELECT 1 into i
        FROM ga_equipaboser a, gad_servsup_art b
        WHERE   a.cod_articulo = b.cod_articulo AND
                a.num_abonado  = EN_num_abonado AND
                a.num_serie    = EV_num_serie AND
                b.cod_producto = 1 AND
                b.cod_servicio = EV_cod_servicio;

    END IF;

EXCEPTION
        WHEN no_data_found THEN
            SN_cod_retorno := 301016;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            SV_mens_retorno := SV_mens_retorno || EV_cod_servicio;
            LV_des_error    :=  'ge_val_soporte_gprs_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_val_soporte_gprs_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );


        WHEN OTHERS THEN
            SN_cod_retorno := 301015;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  'ge_val_soporte_gprs_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_val_soporte_gprs_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_val_soporte_gprs_pr;


PROCEDURE GE_CONS_PLANTARIF_PR(
           EN_numero_celular IN  GA_ABOCEL.NUM_CELULAR%TYPE,
           SV_cod_plantarif  OUT ta_plantarif.cod_plantarif%TYPE,
           SV_des_plantarif  OUT ta_plantarif.des_plantarif%TYPE,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento

)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_PLANTARIF_PR"
        Lenguaje="PL/SQL"
        Fecha="29-05-2008"
        Versión="1.0.0"
        Diseñador="Joan Zamorano Jaramillo"
        Programador="Juan Daniel Muñoz Queupul"
        Ambiente="BD"
         <Retorno>Retorna el valor del codigo </Retorno>
         <Descripción>Retorna el valor de la descripcion</Descripción>
      <Parámetros>
      <Entrada><param nom="EN_numero_celular"  Tipo="NUMBER">numero de celular o red fija</param></Entrada>
      <Salida>
        <param nom="SV_cod_plantarif"  Tipo="VARCHAR2">Codigo del plan tarifario</param>
        <param nom="SV_des_plantarif"  Tipo="VARCHAR2">descripcion del plan tarifario</param>
        <param nom="SN_cod_error"      Tipo="NUMBER">Nro de evento</param>
      </Salida>
      </Parámetros>
     </Elemento>
    </Documentación>
    */

    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;

    LV_CodeSql      ga_errores.cod_sqlcode%TYPE;
    LV_ErrmSql      ga_errores.cod_sqlerrm%TYPE;
    LN_NumEvento    NUMBER;

BEGIN

        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT b.cod_plantarif, b.des_plantarif';
        LV_Sql:= LV_Sql || ' FROM ga_abocel a, ta_plantarif b';
        LV_Sql:= LV_Sql || ' WHERE a.cod_plantarif = b.cod_plantarif AND';
        LV_Sql:= LV_Sql || ' a.num_celular   = ' || EN_numero_celular;
        LV_Sql:= LV_Sql || ' AND a.cod_situacion NOT IN (''BAA'',''BAP'')';
        LV_Sql:= LV_Sql || ' UNION';
        LV_Sql:= LV_Sql || ' SELECT b.cod_plantarif, b.des_plantarif';
        LV_Sql:= LV_Sql || ' FROM ga_aboamist a, ta_plantarif b';
        LV_Sql:= LV_Sql || ' WHERE a.cod_plantarif = b.cod_plantarif AND';
        LV_Sql:= LV_Sql || ' a.num_celular   = ' || EN_numero_celular;
        LV_Sql:= LV_Sql || ' AND a.cod_situacion NOT IN (''BAA'',''BAP'')';


      SELECT b.cod_plantarif, b.des_plantarif
      INTO SV_cod_plantarif,SV_des_plantarif
      FROM ga_abocel a, ta_plantarif b
      WHERE a.cod_plantarif = b.cod_plantarif AND
          a.num_celular   = EN_numero_celular AND
          a.cod_situacion NOT IN ('BAA','BAP')
      UNION
      SELECT b.cod_plantarif, b.des_plantarif
      FROM ga_aboamist a, ta_plantarif b
      WHERE a.cod_plantarif = b.cod_plantarif AND
            a.num_celular = EN_numero_celular AND
            a.cod_situacion NOT IN ('BAA', 'BAP');

      EXCEPTION
           WHEN OTHERS THEN
              SN_codRetorno := 301017;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_errornoclasificado;
              END IF;
              LV_des_error  := 'GE_INTEGRACION_PG.GE_CONS_PLANTARIF_PR;- ' || SQLERRM;
              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, USER, 'GE_INTEGRACION_PG.GE_CONS_PLANTARIF_PR', LV_Sql, SQLCODE, LV_des_error );

END GE_CONS_PLANTARIF_PR;


PROCEDURE GE_CONS_FECALTA_PREPAGO_PR (
        EN_num_telefono    IN             ga_aboamist.num_celular%TYPE,
        SD_fecha_alta     OUT NOCOPY      ga_aboamist.fec_alta%TYPE,
        SN_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
        SV_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
        SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "GE_CONS_FECHA_ALTA_PR"
        Lenguaje="PL/SQL"
        Fecha="08-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Juan Muñoz"
        Ambiente="BD"

    <Retorno>  </Retorno>

    <Descripción>
        Este procedimiento retorna la Fecha de Alta
        en BD para el número consultado.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_num_telefono"  Tipo="NUMBER(15)">Variable de entrada Numero de Telefono </param>
    </Entrada>
    <Salida>
        <param nom="SD_fecha_alta" Tipo="DATE">Fecha de Alta</param>
        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">Codigo de Retorno (SN_cod_retorno=0 numero valido, SN_cod_retorno=-1 error)</param>
        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">Descripcion mensaje de error</param>
        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">Número de evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    LV_sSql := 'SELECT a.fec_alta';
    LV_sSql := LV_sSql || ' FROM ga_aboamist a ';
    LV_sSql := LV_sSql || ' WHERE a.num_celular = ' || EN_num_telefono;
    LV_sSql := LV_sSql || ' AND a.cod_situacion NOT IN (''BAA'',''BAP'')';

    SELECT a.fec_alta into SD_fecha_alta
    FROM ga_aboamist a
    WHERE a.num_celular = EN_num_telefono
    AND a.cod_situacion NOT IN ('BAA','BAP');


EXCEPTION

        WHEN OTHERS THEN
            SN_cod_retorno := 301018;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_CONS_FECALTA_PREPAGO_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.GE_CONS_FECALTA_PREPAGO_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );
    END GE_CONS_FECALTA_PREPAGO_PR;


 PROCEDURE GE_REC_SERV_SUPL_ABONADO_PR (
        EN_num_abonado    IN              ga_abocel.num_abonado%TYPE,
        EN_tip_servicio   IN              NUMBER,
        SC_servsupl       OUT             refcursor,
        SN_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
        SV_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
        SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "GE_REC_SERV_SUPL_ABONADO_PR"
        Lenguaje="PL/SQL"
        Fecha="18-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Juan Muñoz"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Este procedimiento retorna los servicios suplementarios contrados por un abonado</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_num_telefono"  Tipo="NUMBER(8)">Variable de entrada Numero de Abonado</param>
    </Entrada>
    <Salida>
        <param nom="SC_servsupl" Tipo="CURSOR">Cursor que contiene los servicios suplementarios contrados por un abonado</param>
        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">Codigo de Retorno (SN_cod_retorno=0 numero valido, SN_cod_retorno=-1 error)</param>
        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">Descripcion mensaje de error</param>
        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">Número de evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    LO_abonado          pv_datos_abo_qt := NEW pv_datos_abo_qt();
    error_exception     EXCEPTION;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    LO_abonado.num_abonado:= EN_num_abonado;

    LV_sSql := 'PV_SERV_SUPLEMENTARIO_SB_PG.PV_REC_SERV_SUPL_ABONADO_PR(' || LO_abonado.num_abonado;
    LV_sSql := LV_sSql || ', ' || EN_tip_servicio || ')';

    PV_SERV_SUPLEMENTARIO_SB_PG.PV_REC_SERV_SUPL_ABONADO_PR(LO_abonado, EN_tip_servicio, SC_servsupl, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
        RAISE error_exception;
    END IF;

EXCEPTION
        WHEN error_exception THEN
            SN_cod_retorno := 301019;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_REC_SERV_SUPL_ABONADO_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                '1.0',
                                USER,
                                'GE_INTEGRACION_PG.GE_REC_SERV_SUPL_ABONADO_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error);

        WHEN OTHERS THEN
            SN_cod_retorno := 301019;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_REC_SERV_SUPL_ABONADO_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                '1.0',
                                USER,
                                'GE_INTEGRACION_PG.GE_REC_SERV_SUPL_ABONADO_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error);
END GE_REC_SERV_SUPL_ABONADO_PR;

PROCEDURE GE_CONSULTARDIRECCLIENTE_PR (
                                       EN_direccliente   IN             ga_direccli.COD_CLIENTE%TYPE,
                                       SC_direccliente OUT NOCOPY    refcursor,
                                       SN_cod_retorno  OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento   OUT NOCOPY    ge_errores_pg.evento)

IS
   /*
   <Documentación   TipoDoc = "Procedure">>
      <Elemento
         Nombre = "GE_CONSULTARDIRECCLIENTE_PR"
         Lenguaje="PL/SQL"
         Fecha="25-06-2006"
         Versión="1.0"
         Diseñador="Joan Zamorano"
         Programador="Juan Daniel Muñoz Queupul"
         Ambiente Desarrollo="BD">
         <Retorno>SO_direccion</Retorno>>
         <Descripción>Retorna una dirección dado su tipo y código de dirección</Descripción>>
         <Parámetros>
            <Entrada>
               <param nom="SO_direccliente" Tipo="estructura">estructura de cliente-dirección</param>>
            </Entrada>
            <Salida>
               <param nom="cod_tipdireccione" Tipo="CARACTER">codigo del tipo dirección</param>>
               <param nom="cod_direccion" Tipo="NUMERICO">codigo de dirección</param>>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
            </Salida>
         </Parámetros>
      </Elemento>
   </Documentación>
   */

   LV_des_error    ge_errores_pg.DesEvent;
   LV_sSql         ge_errores_pg.vQuery;
   error_exception     EXCEPTION;
   LN_cantidad     NUMBER;
BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

    LV_sSql := ' SELECT cod_tipdireccion, cod_direccion';
    LV_sSql := LV_sSql || ' FROM ga_direccli ';
    LV_sSql := LV_sSql || ' WHERE cod_cliente = ' || EN_direccliente;

    SELECT count(*) INTO LN_cantidad
    FROM ga_direccli a, ge_tipdireccion b
    WHERE a.cod_tipdireccion = b.cod_tipdireccion AND
    a.cod_cliente = EN_direccliente;

    IF LN_cantidad = 0 THEN
         RAISE error_exception;
    END IF;


    OPEN SC_direccliente FOR
    SELECT a.cod_tipdireccion, a.cod_direccion, b.des_tipdireccion
    FROM ga_direccli a, ge_tipdireccion b
    WHERE a.cod_tipdireccion = b.cod_tipdireccion AND
    a.cod_cliente = EN_direccliente;


EXCEPTION
        WHEN error_exception THEN
            SN_cod_retorno := 301020;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_CONSULTARDIRECCLIENTE_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                '1.0',
                                USER,
                                'GE_INTEGRACION_PG.GE_CONSULTARDIRECCLIENTE_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error);


       WHEN OTHERS THEN
            SN_cod_retorno := 301020;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONSULTARDIRECCLIENTE_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONSULTARDIRECCLIENTE_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

END GE_CONSULTARDIRECCLIENTE_PR;

PROCEDURE GE_CONSULTARDIRECCLIENTE_PR (
                                       EN_direccliente IN              ga_direccli.COD_CLIENTE%TYPE,
                                       EN_direcctipo   IN              ga_direccli.COD_TIPDIRECCION%TYPE,
                                       SV_tipo_direcc  OUT NOCOPY    VARCHAR2,
                                       SN_cod_direcc   OUT NOCOPY    NUMBER,
                                       SN_cod_retorno  OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento   OUT NOCOPY    ge_errores_pg.evento)

IS
   /*
   <Documentación       TipoDoc = "Procedure">>
      <Elemento
         Nombre = "GE_consultarDireccionesCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="20-03-2007"
         Versión="1.0"
         Diseñador="Joan Zamorano"
         Programador="Karin Fernandez"
         Ambiente Desarrollo="BD">
         <Retorno>SO_direccion</Retorno>>
         <Descripción>Retorna una dirección dado su tipo y código de dirección</Descripción>>
         <Parámetros>
            <Entrada>
               <param nom="cod_cliente" Tipo="NUMERICO">estructura de cliente-dirección</param>>
               <param nom="cod_tipdireccion" Tipo="VARCHAR">estructura de cliente-dirección</param>>
            </Entrada>
            <Salida>
               <param nom="cod_tipdireccione" Tipo="CARACTER">codigo del tipo dirección</param>>
               <param nom="cod_direccion" Tipo="NUMERICO">codigo de dirección</param>>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
            </Salida>
         </Parámetros>
      </Elemento>
   </Documentación>
   */

    LV_des_error ge_errores_pg.DesEvent;
    LV_sSql      ge_errores_pg.vQuery;
    error_exception     EXCEPTION;

BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

    LV_sSql := ' SELECT cod_tipdireccion, cod_direccion';
    LV_sSql := LV_sSql || ' FROM ga_direccli ';
    LV_sSql := LV_sSql || ' WHERE cod_cliente = ' || EN_direccliente;
    LV_sSql := LV_sSql || ' AND cod_tipdireccion = ' || EN_direcctipo;

    SELECT cod_tipdireccion, cod_direccion
    INTO SV_tipo_direcc,SN_cod_direcc
    FROM ga_direccli
    WHERE cod_cliente = EN_direccliente
    AND cod_tipdireccion = EN_direcctipo;

EXCEPTION
/*
       WHEN error_exception THEN
            SN_cod_retorno := -1;
            LV_des_error    :=  ' GE_CONSULTARDIRECCLIENTE_PR ('||'); - ' || SQLERRM;

            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                '1.0',
                                USER,
                                'GE_INTEGRACION_PG.GE_CONSULTARDIRECCLIENTE_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error);
*/
        WHEN OTHERS THEN
             SN_cod_retorno := 301021;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_errornoclasificado;
             END IF;
             LV_des_error      :=  'GE_CONSULTARDIRECCLIENTE_PR ('||'); - ' || SQLERRM;
             SN_num_evento     :=  Ge_Errores_Pg.Grabarpl(
                                   SN_num_evento,
                                   CV_modulo_ge,
                                   SV_mens_retorno,
                                   '1.0', USER,
                                   'GE_INTEGRACION_PG.GE_CONSULTARDIRECCLIENTE_PR ',
                                   LV_sSQL,
                                   SN_cod_retorno,
                                   LV_des_error );

END GE_CONSULTARDIRECCLIENTE_PR;

PROCEDURE GE_consultarDireccion_PR (EN_cod_direccion         IN               NUMBER,
                                    EN_cod_tipdireccion      IN               VARCHAR2,
                                    SV_cod_tipocalle         OUT NOCOPY       VARCHAR2,
                                    SV_cod_tipdireccion      OUT NOCOPY       VARCHAR2,
                                    SV_des_tipdireccion      OUT NOCOPY       VARCHAR2,
                                    SV_cod_direccion         OUT NOCOPY       VARCHAR2,
                                    SV_cod_provincia         OUT NOCOPY       VARCHAR2,
                                    SV_des_provincia         OUT NOCOPY       VARCHAR2,
                                    SV_cod_region            OUT NOCOPY       VARCHAR2,
                                    SV_des_region            OUT NOCOPY       VARCHAR2,
                                    SV_cod_ciudad            OUT NOCOPY       VARCHAR2,
                                    SV_des_cuidad            OUT NOCOPY       VARCHAR2,
                                    SV_cod_comuna            OUT NOCOPY       VARCHAR2,
                                    SV_des_comuna            OUT NOCOPY       VARCHAR2,
                                    SV_nom_calle             OUT NOCOPY       VARCHAR2,
                                    SV_num_calle             OUT NOCOPY       VARCHAR2,
                                    SV_num_casilla           OUT NOCOPY       VARCHAR2,
                                    SV_obs_direccion         OUT NOCOPY       VARCHAR2,
                                    SV_zip                   OUT NOCOPY       VARCHAR2,
                                    SV_des_direc1            OUT NOCOPY       VARCHAR2,
                                    SV_des_direc2            OUT NOCOPY       VARCHAR2,
                                    SV_cod_pueblo            OUT NOCOPY       VARCHAR2,
                                    SV_cod_estado            OUT NOCOPY       VARCHAR2,
                                    SV_num_piso              OUT NOCOPY       VARCHAR2,
                                    SN_cod_retorno           OUT NOCOPY       ge_errores_pg.CodError,
                                    SV_mens_retorno          OUT NOCOPY       ge_errores_pg.MsgError,
                                    SN_num_evento            OUT NOCOPY       ge_errores_pg.evento)

IS
/*
<Documentación
  TipoDoc = "Procedure">>
   <Elemento
      Nombre = "GE_consultarDireccion_PR"
      Lenguaje="PL/SQL"
      Fecha="20-03-2007"
      Versión="1.0"
      Diseñador="Joan Zamorano"
      Programador="Karin Fernandez"
      Ambiente Desarrollo="BD">
      <Retorno>SO_direccion</Retorno>>
      <Descripción>Retorna una dirección dado su tipo y código de dirección</Descripción>>
      <Parámetros>
         <Entrada>
            <param nom="SO_direccion" Tipo="estructura">estructura de dirección</param>>
         </Entrada>
         <Salida>
            <param nom="SO_direccion" Tipo="estructura">estructura de dirección</param>>
            <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
            <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error         ge_errores_pg.DesEvent;
LV_sSql                   ge_errores_pg.vQuery;

BEGIN
    sn_cod_retorno      := 0;
    sv_mens_retorno     := NULL;
    sn_num_evento       := 0;
    SV_cod_direccion    := EN_cod_direccion;

    LV_sSql := ' SELECT Cod_provincia, Cod_region, Cod_ciudad, Cod_comuna, Nom_calle, Num_calle, Num_piso, Num_casilla ,';
    LV_sSql := LV_sSql || ' Obs_direccion, Des_direc1, Des_direc2, Cod_pueblo, Cod_estado, Zip ';
    LV_sSql := LV_sSql || ' FROM ge_direcciones ';
    LV_sSql := LV_sSql || ' WHERE cod_direccion = ' || EN_cod_direccion;

    SELECT Cod_provincia, Cod_region, Cod_ciudad, Cod_comuna, Nom_calle, Num_calle, Num_piso, Num_casilla,
           Obs_direccion, Des_direc1, Des_direc2, Cod_pueblo, Cod_estado, Zip, cod_tipocalle
    INTO SV_cod_provincia, SV_cod_region, SV_cod_ciudad, SV_cod_comuna, SV_nom_calle, SV_num_calle, SV_num_piso, SV_num_casilla,
         SV_obs_direccion, SV_des_direc1, SV_des_direc2, SV_cod_pueblo, SV_cod_estado, SV_zip, SV_cod_tipocalle
    FROM ge_direcciones
    WHERE cod_direccion = EN_cod_direccion;


    --Obtengo descripción provincia
    IF SV_cod_provincia IS NOT NULL AND SV_cod_region IS NOT NULL THEN
        GE_INTEGRACION_PG.GE_consultarDescProv_PR( SV_cod_provincia, SV_cod_region, SV_des_provincia, sn_cod_retorno, sv_mens_retorno , sn_num_evento );
    END IF;

    --Obtengo descripción región
    IF SV_cod_region IS NOT NULL THEN
        GE_INTEGRACION_PG.GE_consultarDescRegion_PR( SV_cod_region, SV_des_region, sn_cod_retorno, sv_mens_retorno , sn_num_evento );
    END IF;

    --Obtengo descripción ciudad
    IF SV_cod_region IS NOT NULL AND SV_cod_provincia IS NOT NULL  AND  SV_cod_ciudad IS NOT NULL THEN
        GE_INTEGRACION_PG.GE_consultarDescCiudad_PR( SV_cod_region, SV_cod_provincia, SV_cod_ciudad, SV_des_cuidad, sn_cod_retorno, sv_mens_retorno , sn_num_evento );
    END IF;

    --Obtengo descripción comuna
    IF SV_cod_region IS NOT NULL AND SV_cod_provincia IS NOT NULL AND SV_cod_comuna IS NOT NULL THEN
        GE_INTEGRACION_PG.GE_consultarDescComuna_PR(  SV_cod_region, SV_cod_provincia, SV_cod_comuna , SV_des_comuna, sn_cod_retorno, sv_mens_retorno , sn_num_evento );
    END IF;

    --Obtengo descripción tipo de dirección
    IF EN_cod_tipdireccion IS NOT NULL THEN
        GE_INTEGRACION_PG.GE_consultarDescTipoDir_PR(EN_cod_tipdireccion, SV_des_tipdireccion , sn_cod_retorno, sv_mens_retorno , sn_num_evento );
        SV_cod_tipdireccion := EN_cod_tipdireccion;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
         SN_cod_retorno := 301021;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_errornoclasificado;
         END IF;
         LV_des_error   := ' GE_consultarDireccion_PR ('||'); - ' || SQLERRM;
         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.GE_consultarDireccion_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
END GE_consultarDireccion_PR;

PROCEDURE GE_consultarDescProv_PR (
      EN_provincia             IN                 ge_provincias.COD_PROVINCIA%TYPE,
      EN_cod_region            IN               ge_provincias.COD_REGION%TYPE,
      SV_descripcion           OUT              ge_provincias.DES_PROVINCIA%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY            ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_consultarDescProv_PR"
          Lenguaje="PL/SQL"
          Fecha="24-06-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>descripcion</Retorno>>
          <Descripción>Retorna la descripción de la provincia dado su código</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="cod_proviencia" Tipo="CARACTER">código de provincia</param>>
                <param nom="cod_region" Tipo="CARACTER">código de región</param>>
             </Entrada>
             <Salida>
                <param nom="des_provincia" Tipo="CARACTER">descripción de la provincia</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := ' SELECT des_provincia';
        LV_sSql := LV_sSql || ' FROM ge_provincias ';
        LV_sSql := LV_sSql || ' WHERE cod_region = ' || EN_cod_region;
        LV_sSql := LV_sSql || ' AND cod_provincia = ' || EN_provincia;

        SELECT des_provincia
        INTO SV_descripcion
        FROM ge_provincias
        WHERE cod_region = EN_cod_region
        AND cod_provincia = EN_provincia;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
          SN_cod_retorno := 272; --?No es posible recuperar la provincia ?
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' GE_consultarDescProv_PR ('||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.GE_consultarDescProv_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
    END GE_consultarDescProv_PR;


  PROCEDURE GE_consultarDescRegion_PR (
      EN_cod_region               IN                  ge_regiones.COD_REGION%TYPE,
      SV_descripcion           OUT              ge_regiones.DES_REGION%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY            ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_consultarDescRegion_PR"
          Lenguaje="PL/SQL"
          Fecha="24-06-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>descripcion</Retorno>>
          <Descripción>Retorna la descripción de la región dado su código</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="cod_region" Tipo="CARACTER">código de región</param>>
             </Entrada>
             <Salida>
                <param nom="des_region" Tipo="CARACTER">descripción de la región</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := ' SELECT des_region';
        LV_sSql := LV_sSql || ' FROM ge_regiones ';
        LV_sSql := LV_sSql || ' WHERE cod_region = ' || EN_cod_region;

        SELECT des_region
        INTO SV_descripcion
        FROM ge_regiones
        WHERE cod_region = EN_cod_region;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
          SN_cod_retorno := 273; --No es posible recuperar la región ;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' GE_consultarDescRegion_PR ('||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.GE_consultarDescRegion_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
    END GE_consultarDescRegion_PR;


PROCEDURE GE_consultarDescCiudad_PR (
      EN_cod_region            IN         ge_ciudades.COD_REGION%TYPE,
      EN_cod_provincia         IN         ge_ciudades.COD_PROVINCIA%TYPE,
      EN_cod_ciudad            IN         ge_ciudades.COD_CIUDAD%TYPE,
      SV_descripcion           OUT        ge_ciudades.DES_CIUDAD%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY            ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_consultarDescCiudad_PR"
          Lenguaje="PL/SQL"
          Fecha="24-06-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>descripcion</Retorno>>
          <Descripción>Retorna la descripción de la ciudad dado su código</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="cod_region" Tipo="CARACTER">código de región</param>>
              <param nom="cod_provincia" Tipo="CARACTER">código de provincia</param>>
              <param nom="cod_ciudad" Tipo="CARACTER">código de ciudad</param>>
             </Entrada>
             <Salida>
                <param nom="des_ciudad" Tipo="CARACTER">descripción de la ciudad</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := ' SELECT des_ciudad';
        LV_sSql := LV_sSql || ' FROM ge_ciudades ';
        LV_sSql := LV_sSql || ' WHERE cod_region = ' ||EN_cod_region;
        LV_sSql := LV_sSql || ' AND cod_provincia = ' || EN_cod_provincia;
        LV_sSql := LV_sSql || ' AND cod_ciudad = ' || EN_cod_ciudad;

        SELECT des_ciudad
        INTO SV_descripcion
        FROM ge_ciudades
        WHERE cod_region = EN_cod_region
        AND cod_provincia = EN_cod_provincia
        AND cod_ciudad = EN_cod_ciudad;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
          SN_cod_retorno := 271 ; --No es posible recuperar la ciudad
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' GE_consultarDescCiudad_PR ('||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.GE_consultarDescCiudad_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
    END GE_consultarDescCiudad_PR;


PROCEDURE GE_consultarDescComuna_PR (
      EN_cod_region             IN           ge_comunas.COD_REGION%TYPE,
      EN_cod_provincia          IN           ge_comunas.COD_PROVINCIA%TYPE,
      EN_cod_comuna             IN           ge_comunas.COD_COMUNA%TYPE,
      SV_descripcion            OUT          ge_comunas.DES_COMUNA% TYPE,
      SN_cod_retorno            OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno           OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento             OUT NOCOPY        ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_consultarDescComuna_PR"
          Lenguaje="PL/SQL"
          Fecha="24-06-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>descripcion</Retorno>>
          <Descripción>Retorna la descripción de la comuna dado su código</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="cod_region" Tipo="CARACTER">código de región</param>>
              <param nom="cod_provincia" Tipo="CARACTER">código de provincia</param>>
              <param nom="cod_comuna" Tipo="CARACTER">código de comuna</param>>
             </Entrada>
             <Salida>
                <param nom="des_comuna" Tipo="CARACTER">descripción de la comuna</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */


    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := ' SELECT des_comuna';
        LV_sSql := LV_sSql || ' FROM ge_comunas ';
        LV_sSql := LV_sSql || ' WHERE cod_region = ' || EN_cod_region;
        LV_sSql := LV_sSql || ' AND cod_provincia = ' || EN_cod_provincia;
        LV_sSql := LV_sSql || ' AND cod_comuna = ' || EN_cod_comuna;

        SELECT des_comuna
        INTO SV_descripcion
        FROM ge_comunas
        WHERE cod_region = EN_cod_region
        AND cod_provincia = EN_cod_provincia
        AND cod_comuna = EN_cod_comuna;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
          SN_cod_retorno := 270; --No es posible recuperar la comuna
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' GE_consultarDescComuna_PR ('||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_DIRECCION_SB_PG.GE_consultarDescComuna_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
    END GE_consultarDescComuna_PR;


PROCEDURE GE_consultarDescPueblo_PR (
       EN_cod_pueblo        IN              ge_pueblos.COD_PUEBLO%TYPE,
       EN_cod_estado        IN              ge_pueblos.COD_ESTADO%TYPE,
       SV_decripcion        OUT             ge_pueblos.DES_PUEBLO%TYPE,
       SN_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
       SN_num_evento        OUT NOCOPY          ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_consultarDescPueblo_PR"
          Lenguaje="PL/SQL"
          Fecha="24-06-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>descripcion</Retorno>>
          <Descripción>Retorna la descripción de la pueblo dado su código</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="cod_pueblo" Tipo="CARACTER">código de pueblo</param>>
              <param nom="cod_estado" Tipo="CARACTER">código de provincia</param>>
             </Entrada>
             <Salida>
                <param nom="des_pueblo" Tipo="CARACTER">descripción del pueblo</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */


    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := ' SELECT des_pueblo';
        LV_sSql := LV_sSql || ' FROM ge_pueblos ';
        LV_sSql := LV_sSql || ' WHERE cod_pueblo = ' || EN_cod_pueblo;
        LV_sSql := LV_sSql || ' AND cod_estado = ' || EN_cod_estado;

        SELECT des_pueblo
        INTO SV_decripcion
        FROM ge_pueblos
        WHERE cod_pueblo = EN_cod_pueblo
        AND cod_estado = EN_cod_estado;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
          SN_cod_retorno := 319;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' GE_consultarDescPueblo_PR ('||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.GE_consultarDescPueblo_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
    END GE_consultarDescPueblo_PR;


PROCEDURE GE_consultarDescEstado_PR (
      EN_cod_estado          IN              ge_estados.COD_ESTADO%TYPE,
      SV_descripcion         OUT             ge_estados.DES_ESTADO%TYPE,
      SN_cod_retorno         OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno        OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento          OUT NOCOPY           ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_consultarDescEstado_PR"
          Lenguaje="PL/SQL"
          Fecha="24-06-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>descripcion</Retorno>>
          <Descripción>Retorna la descripción del estado dado su código</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="cod_estado" Tipo="CARACTER">código de estado</param>>
             </Entrada>
             <Salida>
                <param nom="des_estado" Tipo="CARACTER">descripción del estado</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := ' SELECT des_estado';
        LV_sSql := LV_sSql || ' FROM ge_estados ';
        LV_sSql := LV_sSql || ' WHERE cod_estado = ' || EN_cod_estado;

        SELECT des_estado
        INTO SV_descripcion
        FROM ge_estados
        WHERE cod_estado = EN_cod_estado;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
          SN_cod_retorno := 319;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' GE_consultarDescEstado_PR ('||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.GE_consultarDescEstado_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
END GE_consultarDescEstado_PR;

PROCEDURE GE_consultarDescTipoDir_PR (
      EN_cod_tipdireccion      IN            ge_tipdireccion.COD_TIPDIRECCION%TYPE,
      SV_descripcion           OUT           ge_tipdireccion.DES_TIPDIRECCION%TYPE,
      SN_cod_retorno           OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY         ge_errores_pg.evento)


    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_consultarDescEstado_PR"
          Lenguaje="PL/SQL"
          Fecha="24-06-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>descripcion</Retorno>>
          <Descripción>Retorna la descripción de el tipo de direción dado su código</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="cod_tipdireccion" Tipo="CARACTER">código de tipo de direccion</param>>
             </Entrada>
             <Salida>
                <param nom="des_tipdireccion" Tipo="CARACTER">descripción del tipo de direccion</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := ' SELECT des_tipdireccion';
        LV_sSql := LV_sSql || ' FROM ge_tipdireccion ';
        LV_sSql := LV_sSql || ' WHERE cod_tipdireccion = ' || EN_cod_tipdireccion;

        SELECT des_tipdireccion
        INTO SV_descripcion
        FROM ge_tipdireccion
        WHERE cod_tipdireccion = EN_cod_tipdireccion;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
          SN_cod_retorno := 269;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' GE_consultarDescTipoDir_PR ('||'); - ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.GE_consultarDescTipoDir_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
    END GE_consultarDescTipoDir_PR;


 PROCEDURE GE_CONS_FACT_CLIE_PR (
                EN_cod_cliente           IN      	        NUMBER,
                EN_num_iteracion         IN               NUMBER,
                EN_num_opcion            IN               NUMBER,
                EV_fecha_desde           IN               VARCHAR2,
                EV_fecha_hasta           IN               VARCHAR2,
	              SC_faturas    		       OUT NOCOPY	  	  refcursor,
                SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                SN_num_evento            OUT NOCOPY		    ge_errores_pg.evento)

IS
   /*
   <Documentación   TipoDoc = "Procedure">>
      <Elemento
         Nombre = "GE_CONS_FACT_CLIE_PR"
         Lenguaje="PL/SQL"
         Fecha="25-06-2006"
         Versión="1.0"
         Diseñador="Joan Zamorano"
         Programador="Juan Daniel Muñoz Queupul"
         Ambiente Desarrollo="BD">
         <Retorno>SC_faturas</Retorno>>
         <Descripción>Retorna lista con los datos de facturas</Descripción>>
         <Parámetros>
            <Entrada>
               <param nom="EN_cod_cliente" Tipo="NUMBER">codigo del cliente</param>>
               <param nom="EN_num_iteracion" Tipo="NUMBER">número de iteraciones</param>>
            </Entrada>
            <Salida>
               <param nom="SC_faturas" Tipo="CURSOR">cursor de retorno</param>>
               <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
               <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
               <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
            </Salida>
         </Parámetros>
      </Elemento>
   </Documentación>
   */

   LV_des_error    ge_errores_pg.DesEvent;
   LV_sSql         ge_errores_pg.vQuery;
   error_exception  EXCEPTION;
   LN_cantidad     NUMBER;
   LD_FEC_INI DATE;
   LD_FEC_TERM DATE;
BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;


IF EN_num_opcion = 1 THEN

    LV_sSql := ' SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio, ';
    LV_sSql := LV_sSql || 'DECODE(f.folio_cancelado, NULL, ''NO PAGADA'', ''PAGADA'') AS estado, f.cod_tipdocum, ';
    LV_sSql := LV_sSql || '  f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva, ';
    LV_sSql := LV_sSql || '  f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact, f.fec_cancelacion ';
    LV_sSql := LV_sSql || ' FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio, ';
    LV_sSql := LV_sSql || ' b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum, ';
    LV_sSql := LV_sSql || ' a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva ,';
    LV_sSql := LV_sSql || ' a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact, b.fec_cancelacion ';
    LV_sSql := LV_sSql || ' FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e ';
    LV_sSql := LV_sSql || ' WHERE a.cod_cliente = b.cod_cliente(+) AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum(+) AND ';
    LV_sSql := LV_sSql || ' a.num_folio = b.num_folio(+) AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = c.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = d.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' c.cod_tipdocummov = d.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_ciclfact = e.cod_ciclfact AND ';
    LV_sSql := LV_sSql || ' a.cod_cliente = ' ||  EN_cod_cliente || ' AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND ';
    LV_sSql := LV_sSql || ' a.cod_ciclfact <> ' || 19010102 ;
    LV_sSql := LV_sSql || ' ORDER BY a.fec_emision DESC) f ';
    LV_sSql := LV_sSql || ' WHERE ROWNUM <= ' ||  EN_num_iteracion;

    SELECT  COUNT(*) INTO LN_cantidad
    FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                  b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                  a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                  a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact,
                  b.fec_cancelacion
                FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                WHERE a.cod_cliente = b.cod_cliente(+) AND
                      a.cod_tipdocum = b.cod_tipdocum(+) AND
                      a.num_folio = b.num_folio(+) AND
                      a.cod_tipdocum = c.cod_tipdocum AND
                        a.cod_tipdocum = d.cod_tipdocum AND
                         c.cod_tipdocummov = d.cod_tipdocum AND
                         a.cod_ciclfact = e.cod_ciclfact AND
                      a.cod_cliente = EN_cod_cliente AND
                      a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                      a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
            ORDER BY a.fec_emision DESC) f
   WHERE ROWNUM <= EN_num_iteracion;

   IF LN_cantidad = 0 THEN
         RAISE error_exception;
   END IF;


  OPEN SC_faturas FOR
     SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio,
            DECODE(f.folio_cancelado, NULL, 'NO PAGADA', 'PAGADA') AS estado, f.cod_tipdocum,
            f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva,
            f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact, f.fec_cancelacion
            FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                  b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                  a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                  a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact,
                  b.fec_cancelacion
            FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                WHERE a.cod_cliente = b.cod_cliente(+) AND
                      a.cod_tipdocum = b.cod_tipdocum(+) AND
                      a.num_folio = b.num_folio(+) AND
                      a.cod_tipdocum = c.cod_tipdocum AND
                        a.cod_tipdocum = d.cod_tipdocum AND
                         c.cod_tipdocummov = d.cod_tipdocum AND
                         a.cod_ciclfact = e.cod_ciclfact AND
                      a.cod_cliente = EN_cod_cliente AND
                      a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                      a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
            ORDER BY a.fec_emision DESC) f
   WHERE ROWNUM <= EN_num_iteracion;

END IF;

IF EN_num_opcion = 2 THEN

    LV_sSql := ' SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio, ';
    LV_sSql := LV_sSql || '''NO PAGADA'' AS estado, f.cod_tipdocum, ';
    LV_sSql := LV_sSql || '  f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva, ';
    LV_sSql := LV_sSql || '  f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact ';
    LV_sSql := LV_sSql || ' FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio, ';
    LV_sSql := LV_sSql || ' b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum, ';
    LV_sSql := LV_sSql || ' a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva ,';
    LV_sSql := LV_sSql || ' a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact ';
    LV_sSql := LV_sSql || ' FROM fa_histdocu a, co_cartera b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e ';
    LV_sSql := LV_sSql || ' WHERE a.cod_cliente = b.cod_cliente(+) AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum(+) AND ';
    LV_sSql := LV_sSql || ' a.num_folio = b.num_folio(+) AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = c.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = d.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' c.cod_tipdocummov = d.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_ciclfact = e.cod_ciclfact AND ';
    LV_sSql := LV_sSql || ' a.cod_cliente = ' ||  EN_cod_cliente || ' AND ';
    LV_sSql := LV_sSql || ' b.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND ';
    LV_sSql := LV_sSql || ' a.cod_ciclfact <> ' || 19010102 ;
    LV_sSql := LV_sSql || ' ORDER BY a.fec_emision DESC) f ';
    LV_sSql := LV_sSql || ' WHERE ROWNUM <= ' ||  EN_num_iteracion;

    SELECT COUNT(*) INTO LN_cantidad
    FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                      b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                      a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                      a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
                FROM fa_histdocu a, co_cartera b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                WHERE a.cod_cliente = b.cod_cliente(+) AND
                      a.cod_tipdocum = b.cod_tipdocum(+) AND
                      a.num_folio = b.num_folio(+) AND
                      a.cod_tipdocum = c.cod_tipdocum AND
                      a.cod_tipdocum = d.cod_tipdocum AND
                      c.cod_tipdocummov = d.cod_tipdocum AND
                      a.cod_ciclfact = e.cod_ciclfact AND
                      a.cod_cliente = EN_cod_cliente AND
                      b.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                      a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
            ORDER BY a.fec_emision DESC) f
   WHERE ROWNUM <= EN_num_iteracion;

   IF LN_cantidad = 0 THEN
         RAISE error_exception;
   END IF;


  OPEN SC_faturas FOR
    SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio,
           'NO PAGADA' AS estado, f.cod_tipdocum,
           f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva,
           f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact
           FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                      b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                      a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                      a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact
                FROM fa_histdocu a, co_cartera b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
                WHERE a.cod_cliente = b.cod_cliente(+) AND
                      a.cod_tipdocum = b.cod_tipdocum(+) AND
                      a.num_folio = b.num_folio(+) AND
                      a.cod_tipdocum = c.cod_tipdocum AND
                      a.cod_tipdocum = d.cod_tipdocum AND
                      c.cod_tipdocummov = d.cod_tipdocum AND
                      a.cod_ciclfact = e.cod_ciclfact AND
                      a.cod_cliente = EN_cod_cliente AND
                      b.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                      a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
            ORDER BY a.fec_emision DESC) f
   WHERE ROWNUM <= EN_num_iteracion;


END IF;

IF  EN_num_opcion = 3 THEN

    LV_sSql := ' SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio, ';
    LV_sSql := LV_sSql || '''PAGADA'' AS estado, f.cod_tipdocum, ';
    LV_sSql := LV_sSql || '  f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva, ';
    LV_sSql := LV_sSql || '  f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact, f.fec_cancelacion ';
    LV_sSql := LV_sSql || ' FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,  ';
    LV_sSql := LV_sSql || ' b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum, ';
    LV_sSql := LV_sSql || ' a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva ,';
    LV_sSql := LV_sSql || ' a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact, b.fec_cancelacion ';
    LV_sSql := LV_sSql || ' FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e';
    LV_sSql := LV_sSql || ' WHERE a.cod_cliente = b.cod_cliente AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.num_folio = b.num_folio AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = c.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = d.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' c.cod_tipdocummov = d.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_ciclfact = e.cod_ciclfact AND ';
    LV_sSql := LV_sSql || ' a.cod_cliente = ' ||  EN_cod_cliente || ' AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND ';
    LV_sSql := LV_sSql || ' a.cod_ciclfact <> ' || 19010102 ;
    LV_sSql := LV_sSql || ' ORDER BY a.fec_emision DESC) f ';
    LV_sSql := LV_sSql || ' WHERE ROWNUM <= ' ||  EN_num_iteracion;

    SELECT COUNT(*) INTO LN_cantidad
    FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                      b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                      a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                      a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact,
                      b.fec_cancelacion
          FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
          WHERE a.cod_cliente = b.cod_cliente AND
                a.cod_tipdocum = b.cod_tipdocum AND
                a.num_folio = b.num_folio AND
                a.cod_tipdocum = c.cod_tipdocum AND
                  a.cod_tipdocum = d.cod_tipdocum AND
                   c.cod_tipdocummov = d.cod_tipdocum AND
                   a.cod_ciclfact = e.cod_ciclfact AND
                a.cod_cliente = EN_cod_cliente AND
                a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
                a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
         ORDER BY a.fec_emision DESC) f
    WHERE ROWNUM<=EN_num_iteracion;

   IF LN_cantidad = 0 THEN
         RAISE error_exception;
   END IF;

  OPEN SC_faturas FOR
  SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio,  'PAGADA' AS estado, f.cod_tipdocum,
         f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva,
         f.tot_descuento, f.tot_cargosme, f.fec_desdellam, f.fec_hastallam, f.cod_ciclfact, f.fec_cancelacion
  FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
                      b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
                      a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
                      a.tot_descuento, a.tot_cargosme, e.fec_desdellam, e.fec_hastallam, a.cod_ciclfact,
                      b.fec_cancelacion
        FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d, fa_ciclfact e
        WHERE a.cod_cliente = b.cod_cliente AND
              a.cod_tipdocum = b.cod_tipdocum AND
              a.num_folio = b.num_folio AND
              a.cod_tipdocum = c.cod_tipdocum AND
                a.cod_tipdocum = d.cod_tipdocum AND
                 c.cod_tipdocummov = d.cod_tipdocum AND
                 a.cod_ciclfact = e.cod_ciclfact AND
              a.cod_cliente =  EN_cod_cliente AND
              a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND
              a.cod_ciclfact <> '19010102' --Esto permite retornar solo facturas ciclo
       ORDER BY a.fec_emision DESC) f
  WHERE ROWNUM<= EN_num_iteracion;
END IF;

IF  EN_num_opcion = 4 THEN

    IF EV_fecha_desde IS NOT NULL THEN
           LD_FEC_INI  :=  TO_DATE(EV_fecha_desde, 'YYYYMMDD') ;
    END IF;
    IF EV_fecha_hasta IS NOT NULL THEN
          LD_FEC_TERM := TO_DATE(EV_fecha_hasta, 'YYYYMMDD') ;
    END IF;

    LV_sSql := ' SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio, ';
    LV_sSql := LV_sSql || ' DECODE(f.folio_cancelado, NULL, ''NO PAGADA'', ''PAGADA'') AS estado, f.cod_tipdocum, ';
    LV_sSql := LV_sSql || ' f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva, ';
    LV_sSql := LV_sSql || ' f.tot_descuento, f.tot_cargosme, f.fec_cancelacion ';
    LV_sSql := LV_sSql || ' FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,  ';
    LV_sSql := LV_sSql || ' b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum, ';
    LV_sSql := LV_sSql || ' a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,';
    LV_sSql := LV_sSql || ' a.tot_descuento, a.tot_cargosme, b.fec_cancelacion ';
    LV_sSql := LV_sSql || ' FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d';
    LV_sSql := LV_sSql || ' WHERE a.cod_cliente = b.cod_cliente(+) AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum(+) AND ';
    LV_sSql := LV_sSql || ' a.num_folio = b.num_folio(+) AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = c.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum = d.cod_tipdocum AND  ';
    LV_sSql := LV_sSql || ' c.cod_tipdocummov = d.cod_tipdocum AND ';
    LV_sSql := LV_sSql || ' a.cod_cliente ='|| EN_cod_cliente || ' AND ';
    LV_sSql := LV_sSql || ' a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND a.fec_emision BETWEEN' || LD_FEC_INI || ' AND ' || LD_FEC_TERM || ' AND';
    LV_sSql := LV_sSql || ' a.cod_ciclfact = ''19010102''';
    LV_sSql := LV_sSql || ' ORDER BY a.fec_emision DESC) f ';
    LV_sSql := LV_sSql || ' WHERE ROWNUM <= ' ||  EN_num_iteracion;

		SELECT COUNT(*) INTO LN_cantidad
		FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
		                      b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
		                      a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
		                      a.tot_descuento, a.tot_cargosme, b.fec_cancelacion
		      FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d
		      WHERE a.cod_cliente = b.cod_cliente(+) AND
		            a.cod_tipdocum = b.cod_tipdocum(+) AND
		            a.num_folio = b.num_folio(+) AND
		            a.cod_tipdocum = c.cod_tipdocum AND
		      	    a.cod_tipdocum = d.cod_tipdocum AND
		       	    c.cod_tipdocummov = d.cod_tipdocum AND
		            a.cod_cliente = EN_cod_cliente AND
		            a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND a.fec_emision BETWEEN LD_FEC_INI AND LD_FEC_TERM AND
		            a.cod_ciclfact = '19010102' --Esto permite retornar solo facturas no ciclo
		      ORDER BY a.fec_emision DESC) f
		WHERE ROWNUM<= EN_num_iteracion;

   IF LN_cantidad = 0 THEN
         RAISE error_exception;
   END IF;

  OPEN SC_faturas FOR
		SELECT f.num_proceso, f.cod_cliente, f.imp_saldoant, f.num_folio,
		       DECODE(f.folio_cancelado, NULL, 'NO PAGADA', 'PAGADA') AS estado, f.cod_tipdocum,
		       f.des_tipdocum, f.fec_emision, f.fec_vencimie, f.tot_factura, f.tot_pagar, f.acum_iva,
		       f.tot_descuento, f.tot_cargosme, f.fec_cancelacion
		FROM (SELECT DISTINCT a.num_proceso, a.cod_cliente, a.imp_saldoant, a.num_folio,
		                      b.num_folio as folio_cancelado, a.cod_tipdocum, d.des_tipdocum,
		                      a.fec_emision, a.fec_vencimie, a.tot_factura, a.tot_pagar, a.acum_iva,
		                      a.tot_descuento, a.tot_cargosme, b.fec_cancelacion
		      FROM fa_histdocu a, co_cancelados b, fa_tipdocumen c, ge_tipdocumen d
		      WHERE a.cod_cliente = b.cod_cliente(+) AND
		            a.cod_tipdocum = b.cod_tipdocum(+) AND
		            a.num_folio = b.num_folio(+) AND
		            a.cod_tipdocum = c.cod_tipdocum AND
		      	    a.cod_tipdocum = d.cod_tipdocum AND
		       	    c.cod_tipdocummov = d.cod_tipdocum AND
		            a.cod_cliente = EN_cod_cliente AND
		            a.cod_tipdocum != (SELECT cod_notacre FROM fa_datosgener) AND a.fec_emision BETWEEN LD_FEC_INI AND LD_FEC_TERM AND
		            a.cod_ciclfact = '19010102' --Esto permite retornar solo facturas no ciclo
		      ORDER BY a.fec_emision DESC) f
		WHERE ROWNUM<= EN_num_iteracion;
END IF;

IF EN_num_opcion != 1  AND EN_num_opcion != 2 AND EN_num_opcion != 3  AND EN_num_opcion != 4 THEN
      RAISE error_exception;
END IF;
EXCEPTION
        WHEN error_exception THEN
            SN_cod_retorno := 301022;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_CONS_FACT_CLIE_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                '1.0',
                                USER,
                                'GE_INTEGRACION_PG.GE_CONS_FACT_CLIE_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error);


       WHEN OTHERS THEN
            SN_cod_retorno := 301022;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_FACT_CLIE_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_FACT_CLIE_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );


END GE_CONS_FACT_CLIE_PR;

PROCEDURE GE_CONS_FECH_REP_CON_PR (
       EN_cod_cliente           IN               NUMBER,
       SC_fechas                OUT NOCOPY       refcursor,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY       ge_errores_pg.evento)
    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_CONS_FECH_REP_CON_PR"
          Lenguaje="PL/SQL"
          Fecha="07-07-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>fechas</Retorno>>
          <Descripción>Retorna la 12 fechas del ultimo corte</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EN_cod_cliente" Tipo="NUMERICO">codigo del cliente</param>>
             </Entrada>
             <Salida>
                <param nom="des_tipdireccion" Tipo="CARACTER">cursor con las 12 fechas obtenida por la consulta</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_des_error       ge_errores_pg.DesEvent;
    LV_sSql                 ge_errores_pg.vQuery;
    error_exception  EXCEPTION;
    LN_cantidad      NUMBER;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

    LV_sSql := ' SELECT c.fec_hastallam';
    LV_sSql := LV_sSql || '  FROM (SELECT DISTINCT a.fec_hastallam ';
    LV_sSql := LV_sSql || '  FROM fa_ciclfact a, ga_infaccel b ' ;
    LV_sSql := LV_sSql || '  WHERE a.cod_ciclfact = b.cod_ciclfact AND ';
    LV_sSql := LV_sSql || '  b.cod_cliente = ' || EN_cod_cliente;
    LV_sSql := LV_sSql || '  ORDER BY a.fec_hastallam DESC) c ';
    LV_sSql := LV_sSql || '  WHERE ROWNUM<=12';

    SELECT COUNT(*) INTO LN_cantidad
    FROM (SELECT DISTINCT a.fec_hastallam
          FROM fa_ciclfact a, ga_infaccel b
          WHERE a.cod_ciclfact = b.cod_ciclfact AND
            b.cod_cliente = EN_cod_cliente
         ORDER BY a.fec_hastallam DESC) c
    WHERE ROWNUM<=12;

    IF LN_cantidad = 0 THEN
         RAISE error_exception;
    END IF;

   OPEN SC_fechas FOR
    SELECT c.fec_hastallam
    FROM (SELECT DISTINCT a.fec_hastallam
          FROM fa_ciclfact a, ga_infaccel b
          WHERE a.cod_ciclfact = b.cod_ciclfact AND
            b.cod_cliente = EN_cod_cliente
         ORDER BY a.fec_hastallam DESC) c
    WHERE ROWNUM<=12;

    EXCEPTION
        WHEN error_exception THEN
              SN_cod_retorno := 301023;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_FECH_REP_CON_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_FECH_REP_CON_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

         WHEN OTHERS THEN
            SN_cod_retorno := 301023;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_FECH_REP_CON_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_FECH_REP_CON_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_FECH_REP_CON_PR;

  PROCEDURE GE_CONS_TEL_BLOQ_POSP_PR (
       EN_cod_abonado           IN                 NUMBER,
       SD_fec_suspbd            OUT NOCOPY       ga_susprehabo.fec_suspbd%TYPE,
       SN_num_terminal          OUT NOCOPY       VARCHAR2,
       SD_fec_suspcen           OUT NOCOPY       ga_susprehabo.fec_suspcen%TYPE,
       SN_cod_caususp           OUT NOCOPY       VARCHAR2,
       SV_des_caususp           OUT NOCOPY       VARCHAR2,
       SN_ind_fraude            OUT NOCOPY       NUMBER,
       SV_cod_tipfraude         OUT NOCOPY       VARCHAR2,
       SN_tip_suspencion        OUT NOCOPY       NUMBER,
       SV_des_valor             OUT NOCOPY       VARCHAR2,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY           ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_CONS_TEL_BLOQ_POSP_PR"
          Lenguaje="PL/SQL"
          Fecha="17-07-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>fechas</Retorno>>
          <Descripción>Retorna la información de un bloqueo o una suspención</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EN_cod_cliente" Tipo="NUMERICO">codigo del abonado</param>>
             </Entrada>
             <Salida>
              <param nom="SD_fec_suspbd" Tipo="DATE">fecha de suspensión en BD</param>>
              <param nom="SN_num_terminal" Tipo="NUMBER">número del teléfono consultado</param>>
              <param nom="SD_fec_suspcen" Tipo="DATE">fecha de suspensión en central</param>>
              <param nom="SN_cod_caususp" Tipo="NUMBER">código causa de suspensión</param>>
              <param nom="SV_des_caususp" Tipo="CARACTER">descripción de la causa de suspensión</param>>
              <param nom="SN_ind_fraude" Tipo="NUMBER">indicador de fraude (0: suspensión no asociada a fraude; 1: suspensión asociada a fraude)</param>>
              <param nom="SV_cod_tipfraude" Tipo="CARACTER">código del tipo de fraude (solo si el indicador de fraude es 1)</param>>
              <param nom="SN_tip_suspencion" Tipo="NUMBER">tipo de suspensión (1: unidireccional; 2: bidireccional)</param>>
              <param nom="SV_des_valor" Tipo="CARACTER">descripción tipo de suspensión</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

      LV_des_error       ge_errores_pg.DesEvent;
      LV_sSql                 ge_errores_pg.vQuery;
    error_exception  EXCEPTION;
    LN_cantidad      NUMBER;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := '  SELECT a.fec_suspbd, a.num_terminal, a.fec_suspcen, a.cod_caususp, ';
        LV_sSql := LV_sSql || '   b.des_caususp, b.ind_fraude, b.cod_tipfraude, b.tip_suspencion, c.des_valor';
        LV_sSql := LV_sSql || '  FROM ga_susprehabo a, ga_caususp b, ged_codigos c ' ;
    LV_sSql := LV_sSql || '  WHERE a.cod_producto = b.cod_producto AND ';
    LV_sSql := LV_sSql || '  a.cod_modulo = b.cod_modulo AND ';
    LV_sSql := LV_sSql || '  a.cod_caususp = b.cod_caususp AND ';
    LV_sSql := LV_sSql || '  a.num_abonado = '|| EN_cod_abonado ||' AND ';
    LV_sSql := LV_sSql || '  b.tip_suspencion = c.cod_valor AND ';
    LV_sSql := LV_sSql || '   c.cod_modulo = ''GA'' AND ';
    LV_sSql := LV_sSql || '  c.nom_tabla = ''GA_CAUSUSP'' AND ';
    LV_sSql := LV_sSql || '   c.nom_columna = ''TIP_SUSPENCION''';

    SELECT COUNT(*) INTO LN_cantidad
    FROM ga_susprehabo a, ga_caususp b, ged_codigos c
    WHERE a.cod_producto = b.cod_producto AND
          a.cod_modulo = b.cod_modulo AND
          a.cod_caususp = b.cod_caususp AND
          a.num_abonado = EN_cod_abonado AND
          b.tip_suspencion = c.cod_valor AND
          c.cod_modulo = 'GA' AND
          c.nom_tabla = 'GA_CAUSUSP' AND
          c.nom_columna = 'TIP_SUSPENCION';

    IF LN_cantidad = 0 THEN
         RAISE error_exception;
    END IF;

   SELECT a.fec_suspbd, a.num_terminal, a.fec_suspcen, a.cod_caususp,
       b.des_caususp, b.ind_fraude, b.cod_tipfraude, b.tip_suspencion, c.des_valor

   INTO  SD_fec_suspbd, SN_num_terminal, SD_fec_suspcen, SN_cod_caususp,
         SV_des_caususp,SN_ind_fraude, SV_cod_tipfraude,SN_tip_suspencion,SV_des_valor

   FROM  ga_susprehabo a, ga_caususp b, ged_codigos c
   WHERE a.cod_producto = b.cod_producto AND
         a.cod_modulo = b.cod_modulo AND
         a.cod_caususp = b.cod_caususp AND
         a.num_abonado = EN_cod_abonado AND
         b.tip_suspencion = c.cod_valor AND
         c.cod_modulo = 'GA' AND
         c.nom_tabla = 'GA_CAUSUSP' AND
         c.nom_columna = 'TIP_SUSPENCION';


    EXCEPTION
        WHEN error_exception THEN
              SN_cod_retorno := 301024;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_TEL_BLOQ_POSP_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_TEL_BLOQ_POSP_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

         WHEN OTHERS THEN
            SN_cod_retorno := 301024;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_TEL_BLOQ_POSP_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_TEL_BLOQ_POSP_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_TEL_BLOQ_POSP_PR;

   PROCEDURE GE_CONS_TEL_BLOQ_PREP_PR (
       EN_cod_abonado           IN                 NUMBER,
       SD_fec_suspbd            OUT NOCOPY       ga_susprehabo.fec_suspbd%TYPE,
       SN_num_terminal          OUT NOCOPY       VARCHAR2,
       SD_fec_suspcen           OUT NOCOPY       ga_susprehabo.fec_suspcen%TYPE,
       SN_cod_caususp           OUT NOCOPY       VARCHAR2,
       SV_des_caususp           OUT NOCOPY       VARCHAR2,
       SN_ind_fraude            OUT NOCOPY       NUMBER,
       SV_cod_tipfraude         OUT NOCOPY       VARCHAR2,
       SN_tip_suspencion        OUT NOCOPY       NUMBER,
       SV_des_valor             OUT NOCOPY       VARCHAR2,
       SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY           ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_CONS_TEL_BLOQ_PREP_PR"
          Lenguaje="PL/SQL"
          Fecha="17-07-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>fechas</Retorno>>
          <Descripción>Retorna la información de un bloqueo o una suspención</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EN_cod_cliente" Tipo="NUMERICO">codigo del abonado</param>>
             </Entrada>
             <Salida>
              <param nom="SD_fec_suspbd" Tipo="DATE">fecha de suspensión en BD</param>>
              <param nom="SN_num_terminal" Tipo="NUMBER">número del teléfono consultado</param>>
              <param nom="SD_fec_suspcen" Tipo="DATE">fecha de suspensión en central</param>>
              <param nom="SN_cod_caususp" Tipo="CARACTER">código causa de suspensión</param>>
              <param nom="SV_des_caususp" Tipo="CARACTER">descripción de la causa de suspensión</param>>
              <param nom="SN_ind_fraude" Tipo="NUMBER">indicador de fraude (0: suspensión no asociada a fraude; 1: suspensión asociada a fraude)</param>>
              <param nom="SV_cod_tipfraude" Tipo="CARACTER">código del tipo de fraude (solo si el indicador de fraude es 1)</param>>
              <param nom="SN_tip_suspencion" Tipo="NUMBER">tipo de suspensión (1: unidireccional; 2: bidireccional)</param>>
              <param nom="SV_des_valor" Tipo="CARACTER">descripción tipo de suspensión</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

      LV_des_error       ge_errores_pg.DesEvent;
      LV_sSql                 ge_errores_pg.vQuery;
    error_exception  EXCEPTION;
    LN_cantidad      NUMBER;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        LV_sSql := '  SELECT a.fec_suspbd, a.num_terminal, a.fec_suspcen, a.cod_caususp, ';
        LV_sSql := LV_sSql || '   b.des_caususp, b.ind_fraude, b.cod_tipfraude, b.tip_suspencion, c.des_valor';
        LV_sSql := LV_sSql || '  FROM ga_susprehabo a, ga_caususp b, ged_codigos c ' ;
    LV_sSql := LV_sSql || '  WHERE a.cod_producto = b.cod_producto AND ';
    LV_sSql := LV_sSql || '  a.cod_caususp = b.cod_causablodes AND ';
    LV_sSql := LV_sSql || '  a.num_abonado = '|| EN_cod_abonado ||' AND ';
    LV_sSql := LV_sSql || '  b.tip_suspencion = c.cod_valor AND ';
    LV_sSql := LV_sSql || '   c.cod_modulo = ''GA'' AND ';
    LV_sSql := LV_sSql || '  c.nom_tabla = ''GA_CAUSUSP'' AND ';
    LV_sSql := LV_sSql || '   c.nom_columna = ''TIP_SUSPENCION''';


    SELECT COUNT(*) INTO LN_cantidad
    FROM ga_susprehabo a, pv_causablodesq_to b, ged_codigos c
    WHERE a.cod_producto = b.cod_producto AND
          a.cod_caususp = b.cod_causablodes AND
          a.num_abonado = EN_cod_abonado AND
          b.tip_suspencion = c.cod_valor AND
          c.cod_modulo = 'GA' AND
          c.nom_tabla = 'GA_CAUSUSP' AND
          c.nom_columna = 'TIP_SUSPENCION';

    IF LN_cantidad = 0 THEN
         RAISE error_exception;
    END IF;

    SELECT a.fec_suspbd, a.num_terminal, a.fec_suspcen, a.cod_caususp,
           b.des_causablodes, b.ind_fraude, b.cod_tipfraude, b.tip_suspencion, c.des_valor
    INTO  SD_fec_suspbd, SN_num_terminal, SD_fec_suspcen, SN_cod_caususp,
          SV_des_caususp,SN_ind_fraude, SV_cod_tipfraude,SN_tip_suspencion,SV_des_valor
    FROM ga_susprehabo a, pv_causablodesq_to b, ged_codigos c
    WHERE a.cod_producto = b.cod_producto AND
          a.cod_caususp = b.cod_causablodes AND
          a.num_abonado = EN_cod_abonado AND
          b.tip_suspencion = c.cod_valor AND
          c.cod_modulo = 'GA' AND
          c.nom_tabla = 'GA_CAUSUSP' AND
          c.nom_columna = 'TIP_SUSPENCION';


    EXCEPTION
        WHEN error_exception THEN
              SN_cod_retorno := 301024;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_TEL_BLOQ_PREP_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_TEL_BLOQ_PREP_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

         WHEN OTHERS THEN
            SN_cod_retorno := 301024;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_TEL_BLOQ_PREP_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_TEL_BLOQ_PREP_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_TEL_BLOQ_PREP_PR;

  PROCEDURE GE_VALIDA_FECHA_CICLO_PR (
       EN_cod_ciclfact          IN              NUMBER,
       EV_FEC_INI               IN              VARCHAR2,
       EV_FEC_TERM              IN              VARCHAR2,
       SV_fecha_ini             OUT NOCOPY      VARCHAR2,
       SV_fecha_term            OUT NOCOPY      VARCHAR2,
       SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY          ge_errores_pg.evento)

    IS
    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "GE_VALIDA_FECHA_CICLO_PR"
          Lenguaje="PL/SQL"
          Fecha="17-07-2009"
          Versión="1.0"
          Diseñador="Joan Zamorano"
          Programador="Juan Daniel Muñoz Queupul"
          Ambiente Desarrollo="BD">
          <Retorno>fechas</Retorno>>
          <Descripción>Retorna fechas de inicio y termino</Descripción>>
          <Parámetros>
             <Entrada>
                 <param nom="EN_FEC_INI" Tipo="DATE">fecha de inicio</param>>
               <param nom="EN_FEC_TERM" Tipo="DATE">fecha de termino</param>>
               <param nom="EN_cod_ciclfact" Tipo="NUMERICO">codigo del ciclo de facturacion</param>>
             </Entrada>
             <Salida>
              <param nom="SV_fecha_ini" Tipo="DATE">fecha de inicio del ciclo</param>>
              <param nom="SV_fecha_term" Tipo="DATE">fecha de termino de ciclo</param>>
                <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

      LV_des_error       ge_errores_pg.DesEvent;
      LV_sSql                 ge_errores_pg.vQuery;
    LO_NO_DATA  EXCEPTION;
    LN_VALOR NUMBER;
    LD_FEC_INI DATE;
    LD_FEC_TERM DATE;

    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

      IF EV_FEC_INI IS NOT NULL THEN
            LD_FEC_INI  :=  TO_DATE(EV_FEC_INI, 'YYYYMMDD') ;
      END IF;
      IF EV_FEC_TERM IS NOT NULL THEN
            LD_FEC_TERM := TO_DATE(EV_FEC_TERM, 'YYYYMMDD') ;
      END IF;


    IF (LD_FEC_INI IS NULL AND LD_FEC_TERM IS NULL) THEN /*si ambas fechas son NULL*/
        LV_sSql :='SELECT a.fec_desdellam, a.fec_hastallam';
        LV_sSql :=LV_sSql || ' FROM fa_ciclfact a';
        LV_sSql :=LV_sSql || ' WHERE a.cod_ciclfact = ' || EN_cod_ciclfact;

        SELECT TO_CHAR(a.fec_desdellam, 'DD-MM-YYYY') as SV_fecha_ini, TO_CHAR(a.fec_hastallam, 'DD-MM-YYYY') as SV_fecha_term
        INTO SV_fecha_ini, SV_fecha_term
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = EN_cod_ciclfact;

    ELSIF (LD_FEC_INI IS NULL AND LD_FEC_TERM IS NOT NULL) THEN /*si la fecha de inicio es nula y la de fin es no nula*/

        LV_sSql :=' SELECT COUNT(1)';
        LV_sSql :=LV_sSql || ' FROM fa_ciclfact a';
        LV_sSql :=LV_sSql || ' WHERE a.cod_ciclfact = ' || EN_cod_ciclfact || ' AND ';
        LV_sSql :=LV_sSql ||  TO_DATE(EV_FEC_TERM, 'YYYYMMDD') || ' BETWEEN a.fec_desdellam AND a.fec_hastallam';

        SELECT COUNT(*)
        INTO LN_VALOR
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = EN_cod_ciclfact AND
              LD_FEC_TERM BETWEEN a.fec_desdellam AND a.fec_hastallam;

        IF LN_VALOR=0 THEN
            RAISE LO_NO_DATA; --se genera exception
        END IF;

        SELECT TO_CHAR(a.fec_desdellam, 'DD-MM-YYYY') as SV_fecha_ini
        INTO SV_fecha_ini
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = EN_cod_ciclfact;

    ELSIF (LD_FEC_INI IS NOT NULL AND LD_FEC_TERM IS NULL) THEN     /*si la fecha de inicio no es nula y la de fin es nula*/
        LV_sSql :=' SELECT COUNT(1)';
        LV_sSql :=LV_sSql || ' FROM fa_ciclfact a';
        LV_sSql :=LV_sSql || ' WHERE a.cod_ciclfact = ' || EN_cod_ciclfact || ' AND ';
        LV_sSql :=LV_sSql ||  TO_DATE(EV_FEC_INI, 'YYYYMMDD') || ' BETWEEN a.fec_desdellam AND a.fec_hastallam';

        SELECT COUNT(*)
        INTO LN_VALOR
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = EN_cod_ciclfact AND
              LD_FEC_INI BETWEEN a.fec_desdellam AND a.fec_hastallam;

        IF LN_VALOR=0 THEN
            RAISE LO_NO_DATA; --se genera exception
        END IF;

        SELECT TO_CHAR(a.fec_hastallam, 'DD-MM-YYYY') as SV_fecha_term
        INTO SV_fecha_term
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = EN_cod_ciclfact;

    ELSE /*si ambas fechas son no nulas */

        LV_sSql :=' SELECT COUNT(1)';
        LV_sSql :=LV_sSql || ' FROM fa_ciclfact a';
        LV_sSql :=LV_sSql || ' WHERE a.cod_ciclfact = ' || EN_cod_ciclfact || ' AND ';
        LV_sSql :=LV_sSql ||  TO_DATE(EV_FEC_INI, 'YYYYMMDD') || ' BETWEEN a.fec_desdellam AND a.fec_hastallam AND ';
        LV_sSql :=LV_sSql ||  TO_DATE(EV_FEC_TERM, 'YYYYMMDD') || ' BETWEEN a.fec_desdellam AND a.fec_hastallam';

        SELECT COUNT(*)
        INTO LN_VALOR
        FROM fa_ciclfact a
        WHERE a.cod_ciclfact = EN_cod_ciclfact AND
              LD_FEC_INI BETWEEN a.fec_desdellam AND a.fec_hastallam AND
              LD_FEC_TERM BETWEEN a.fec_desdellam AND a.fec_hastallam;

        IF LN_VALOR=0 THEN
            RAISE LO_NO_DATA; --se genera exception
        END IF;

        SV_fecha_ini   := TO_CHAR(LD_FEC_INI, 'DD-MM-YYYY');
        SV_fecha_term  := TO_CHAR(LD_FEC_TERM, 'DD-MM-YYYY');

    END IF;

    EXCEPTION
        WHEN LO_NO_DATA THEN
              SN_cod_retorno := 301025;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_VALIDA_FECHA_CICLO_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_VALIDA_FECHA_CICLO_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

         WHEN OTHERS THEN
            SN_cod_retorno := 301025;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_VALIDA_FECHA_CICLO_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_modulo_ge,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_VALIDA_FECHA_CICLO_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_VALIDA_FECHA_CICLO_PR;


PROCEDURE ge_cons_abo_clie_telef_pr(EN_numCliente       IN NUMBER,
                                    EN_numCelular       IN NUMBER,
                                    SN_num_abonado      OUT NOCOPY ga_abocel.Num_abonado%TYPE,
                                    SN_cod_cuenta       OUT NOCOPY ga_abocel.Cod_cuenta%TYPE,
                                    SN_cod_uso          OUT NOCOPY ga_abocel.Cod_uso%TYPE,
                                    SV_cod_situacion    OUT NOCOPY ga_abocel.Cod_situacion%TYPE,
                                    SN_cod_vendedor     OUT NOCOPY ga_abocel.Cod_vendedor%TYPE,
                                    SV_tip_plantarif    OUT NOCOPY ga_abocel.Tip_plantarif%TYPE,
                                    SV_tip_terminal     OUT NOCOPY ga_abocel.Tip_terminal%TYPE,
                                    SV_cod_plantarif    OUT NOCOPY ga_abocel.Cod_plantarif%TYPE,
                                    SV_num_serie        OUT NOCOPY ga_abocel.Num_serie%TYPE,
                                    SD_fec_alta         OUT NOCOPY ga_abocel.fec_alta%TYPE,
                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
AS

    /*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_val_clie_telef_pr"
        Lenguaje="PL/SQL"
        Fecha="22-07-2009"
        Versión="1.1.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> boolean </Retorno>
    <Descripción>
         Retorna Datos del abonado (num_abonado, cod_cuenta, cod_uso, cod_situacion, cod_vendedor,
                                    tip_plantarif, tip_terminal, cod_plantarif, num_serie, fec_alta)
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="Lnum_cliente"  Tipo="NUMBER(8)">Numero Cliente</param>
        <param nom="Lnum_celular" Tipo="NUMBER(15)">Numero celular</param>

    </Entrada>
    <Salida>
        <param nom="SN_num_abonado"    Tipo="ga_abocel.Num_abonado%TYPE">Número Abonado</param>
        <param nom="SN_cod_cuenta"     Tipo="ga_abocel.Cod_cuenta%TYPE">codigo de cuenta</param>
        <param nom="SN_cod_uso"        Tipo="ga_abocel.Cod_uso%TYPE">codigo de uso</param>
        <param nom="SV_cod_situacion"  Tipo="ga_abocel.Cod_situacion%TYPE">codigo de situacion</param>
        <param nom="SN_cod_vendedor"   Tipo="ga_abocel.Cod_vendedor%TYPE">codigo de vendedor</param>
        <param nom="SV_tip_plantarif"  Tipo="ga_abocel.Tip_plantarif%TYPE">tipo plan tarifario</param>
        <param nom="SV_tip_terminal"   Tipo="ga_abocel.Tip_terminal%TYPE">tipo terminal</param>
        <param nom="SV_cod_plantarif"  Tipo="ga_abocel.Num_serie%TYPE">codigo plan tarifacio</param>
        <param nom="SV_num_serie"      Tipo="ga_abocel.Cod_plantarif%TYPE">numero de serie</param>
        <param nom="SD_fec_alta"       Tipo="ga_abocel.fec_alta%TYPE">fecha de alta</param>
        <param nom="SN_cod_retorno"    Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;

    LV_sSql := ' SELECT a.num_abonado, a.cod_cuenta, a.cod_uso, a.cod_situacion, a.cod_vendedor, a.tip_plantarif, a.tip_terminal, a.cod_plantarif, a.num_serie, a.fec_alta'
            ||' FROM ga_abocel a '
            ||' WHERE a.cod_cliente = '||EN_numCliente
            ||' AND a.num_celular = '||EN_numCelular
            ||' AND a.cod_situacion NOT IN (''BAA'',''BAP'')'
            ||' UNION '
            ||' SELECT a.num_abonado, a.cod_cuenta, a.cod_uso, a.cod_situacion, a.cod_vendedor, a.tip_plantarif, a.tip_terminal, a.cod_plantarif, a.num_serie, a.fec_alta '
            ||' FROM ga_aboamist a '
            ||' WHERE a.cod_cliente = ' ||EN_numCliente
            ||' AND a.num_celular = '||EN_numCelular
            ||' AND a.cod_situacion NOT IN (''BAA'',''BAP'')';


                SELECT a.num_abonado, a.cod_cuenta, a.cod_uso, a.cod_situacion, a.cod_vendedor, a.tip_plantarif, a.tip_terminal, a.cod_plantarif, a.num_serie, a.fec_alta
                INTO SN_num_abonado, SN_cod_cuenta, SN_cod_uso, SV_cod_situacion, SN_cod_vendedor, SV_tip_plantarif, SV_tip_terminal, SV_cod_plantarif, SV_num_serie, SD_fec_alta
                FROM ga_abocel a
                WHERE a.cod_cliente = EN_numCliente AND
                      a.num_celular = EN_numCelular AND
                      a.cod_situacion NOT IN ('BAA','BAP')
                UNION
                SELECT a.num_abonado, a.cod_cuenta, a.cod_uso, a.cod_situacion, a.cod_vendedor, a.tip_plantarif, a.tip_terminal, a.cod_plantarif, a.num_serie, a.fec_alta
                FROM ga_aboamist a
                WHERE a.cod_cliente = EN_numCliente AND
                      a.num_celular = EN_numCelular AND
                      a.cod_situacion NOT IN ('BAA','BAP');

EXCEPTION

      WHEN OTHERS THEN
          sn_cod_retorno := 301026;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_cons_abo_clie_telef_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_cons_abo_clie_telef_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_cons_abo_tel_pr (   EN_numTelefono      IN NUMBER,
                                 SN_num_abonado      OUT NOCOPY   ga_abocel.Num_abonado%TYPE,
                                 SN_cod_cliente      OUT NOCOPY   ga_aboamist.Cod_cliente%TYPE,
                                 SV_tip_abonado      OUT NOCOPY   VARCHAR2,
                                 SV_cod_tecnologia   OUT NOCOPY   ga_abocel.Cod_tecnologia%TYPE,
                                 SV_num_serie        OUT NOCOPY   ga_abocel.num_serie%TYPE,
                                 SV_num_imei         OUT NOCOPY   ga_abocel.num_imei%TYPE,
                                 SV_cod_prestacion   OUT NOCOPY   ga_abocel.Cod_prestacion%TYPE,
                                 SN_cod_cuenta       OUT NOCOPY   ga_abocel.Cod_cuenta%TYPE,
                                 SV_cod_plantarif    OUT NOCOPY   ga_abocel.Cod_plantarif%TYPE,
                                 SV_des_prestacion   OUT NOCOPY   ge_prestaciones_td.des_prestacion%TYPE,
                                 SV_cod_tiplan       OUT NOCOPY   ta_plantarif.Cod_tiplan%TYPE,
                                 SV_cod_planserv     OUT NOCOPY   ga_abocel.cod_planserv%TYPE,
                                 SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                 SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                 SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_cons_abo_tel_pr"
        Lenguaje="PL/SQL"
        Fecha="19-08-2009"
        Versión="1.2.0"
        Diseñador="Joan Zamorano"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Retorna los datos del abonado a partir de un numero de teléfono</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_numTelefono"  Tipo="NUMBER(15)">Numero celular</param>
    </Entrada>
    <Salida>
        <param nom="SN_num_abonado"     Tipo="ga_abocel.Num_abonado%TYPE">numero abonado</param>
        <param nom="SN_cod_cuenta"      Tipo="ga_abocel.Cod_cuenta%TYPE">Codigo de cuenta</param>
        <param nom="SN_cod_cliente"     Tipo="ga_aboamist.Cod_cliente%TYPE">Codigo Cliente</param>
        <param nom="SV_tip_abonado"     Tipo="VARCHAR2">Tipo Abonado</param>
        <param nom="SV_cod_tecnologia"  Tipo="ga_abocel.Cod_tecnologia%TYPE">Codigo tecnologia</param>
        <param nom="SV_num_serie"       Tipo="VARCHAR2(25)">Numero de Serie Decimal</param>
        <param nom="SV_num_imei"        Tipo="VARCHAR2(25)">Numero Serie Terminal GSM</param>
        <param nom="SV_cod_prestacion"  Tipo="VARCHAR2(5)">Código de prestación</param>
        <param nom="SV_cod_plantarif"   Tipo="VARCHAR2(3)">Código de Plan Tarifario</param>
        <param nom="SV_cod_tiplan"      Tipo="VARCHAR2(5)">Código tipo Plan</param>
        <param nom="SV_des_prestacion"  Tipo="VARCHAR2(50)">Descripcion de la Prestacion</param>
        <param nom="SV_cod_tiplan"      Tipo="VARCHAR2(3)">Código tipo plan</param>
        <param nom="SV_cod_planserv"    Tipo="VARCHAR2(3)">Código del tipo de servicio</param>
        <param nom="SN_cod_retorno"     Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"    Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;

BEGIN

    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;

    LV_sSql := ' SELECT  a.num_abonado, a.cod_cuenta, a.cod_cliente, c.des_valor AS tip_abonado, a.cod_tecnologia,'
            || ' a.num_serie, a.num_imei, a.cod_prestacion, a.cod_plantarif, d.des_prestacion, b.cod_tiplan,b.cod_tiplan, a.cod_planserv  '
            || ' FROM ga_abocel a, ta_plantarif b, ged_codigos c, ge_prestaciones_td d'
            || ' WHERE a.cod_plantarif = b.cod_plantarif AND'
            || ' a.cod_producto = b.cod_producto AND'
            || ' a.num_celular = '||EN_numTelefono
            || ' AND a.cod_situacion NOT IN (''BAA'',''BAP'')'
            || ' AND a.cod_prestacion = d.cod_prestacion '
            || ' AND b.cod_tiplan = c.cod_valor '
            || ' AND c.cod_modulo = ''GE'''
            || ' AND c.nom_tabla = ''TA_PLANTARIF'''
            || ' AND c.nom_columna = ''COD_TIPLAN'''
            || ' UNION '
            || ' SELECT a.num_abonado, a.cod_cuenta, a.cod_cliente, c.des_valor AS tip_abonado, a.cod_tecnologia,'
            || ' a.num_serie, a.num_imei, a.cod_prestacion, a.cod_plantarif, d.des_prestacion, b.cod_tiplan, b.cod_tiplan, a.cod_planserv '
            || ' FROM ga_aboamist a, ta_plantarif b, ged_codigos c, ge_prestaciones_td d'
            || ' WHERE a.cod_plantarif = b.cod_plantarif AND'
            || ' a.cod_producto = b.cod_producto AND'
            || ' a.num_celular = '||EN_numTelefono
            || ' AND a.cod_situacion NOT IN (''BAA'',''BAP'')'
            || ' AND a.cod_prestacion = d.cod_prestacion '
            || ' AND b.cod_tiplan = c.cod_valor '
            || ' AND c.cod_modulo = ''GE'''
            || ' AND c.nom_tabla = ''TA_PLANTARIF'''
            || ' AND c.nom_columna = ''COD_TIPLAN''';


            SELECT a.num_abonado, a.cod_cuenta, a.cod_cliente, c.des_valor AS tip_abonado, a.cod_tecnologia,
                   a.num_serie, a.num_imei, a.cod_prestacion, a.cod_plantarif, d.des_prestacion, b.cod_tiplan, a.cod_planserv
            INTO   SN_num_abonado, SN_cod_cuenta, SN_cod_cliente, SV_tip_abonado, SV_cod_tecnologia,
                   SV_num_serie, SV_num_imei, SV_cod_prestacion, SV_cod_plantarif, SV_des_prestacion,SV_cod_tiplan,SV_cod_planserv
            FROM ga_abocel a, ta_plantarif b, ged_codigos c, ge_prestaciones_td d
            WHERE a.cod_plantarif = b.cod_plantarif AND
                  a.cod_producto = b.cod_producto AND
                  a.num_celular = EN_numTelefono AND
                  a.cod_situacion NOT IN ('BAA','BAP') AND
                  a.cod_prestacion = d.cod_prestacion AND
                  b.cod_tiplan = c.cod_valor AND
                  c.cod_modulo = 'GE' AND
                  c.nom_tabla = 'TA_PLANTARIF' AND
                  c.nom_columna = 'COD_TIPLAN'
            UNION
            SELECT a.num_abonado, a.cod_cuenta, a.cod_cliente, c.des_valor AS tip_abonado, a.cod_tecnologia,
                   a.num_serie, a.num_imei, a.cod_prestacion, a.cod_plantarif, d.des_prestacion, b.cod_tiplan, a.cod_planserv
            FROM ga_aboamist a, ta_plantarif b, ged_codigos c, ge_prestaciones_td d
            WHERE a.cod_plantarif = b.cod_plantarif AND
                  a.cod_producto = b.cod_producto AND
                  a.num_celular = EN_numTelefono AND
                  a.cod_situacion NOT IN ('BAA','BAP') AND
                  a.cod_prestacion = d.cod_prestacion AND
                  b.cod_tiplan = c.cod_valor AND
                  c.cod_modulo = 'GE' AND
                  c.nom_tabla = 'TA_PLANTARIF' AND
                  c.nom_columna = 'COD_TIPLAN';

EXCEPTION

     WHEN OTHERS THEN
          sn_cod_retorno := 301027;

          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_cons_abo_tel_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, sv_mens_retorno, CV_version, USER, 'ge_integracion_pg.ge_cons_abo_tel_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_cons_num_sec_pr(EN_nomSecuencia     IN VARCHAR2,
                             SN_numSecuencia     OUT NOCOPY  NUMBER,
                             SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                             SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS

    /*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_cons_num_sec_pr"
        Lenguaje="PL/SQL"
        Fecha="18-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Retorna el numero de secuencia a partir de un nombre de secuencia</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EV_nomSecuencia  Tipo="VARCHAR2">Nombre Secuencia</param>
    </Entrada>
    <Salida>
        <param nom="SN_numSecuencia"  Tipo="NUMBER">Numero Secuencia</param>
        <param nom="SN_cod_retorno"   Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;

    LV_sSql := 'SELECT ' || EN_nomSecuencia || '.NEXTVAL FROM dual';

    EXECUTE IMMEDIATE LV_sSql INTO SN_numSecuencia;

EXCEPTION

     WHEN OTHERS THEN
          sn_cod_retorno := 301028;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          ELSE
              SV_mens_retorno := SV_mens_retorno || EN_nomSecuencia;
          END IF;

          LV_des_error   := ' ge_cons_num_sec_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_cons_num_sec_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_cons_datos_cli_cod_pr(EN_codCliente       IN  ge_clientes.cod_cliente%TYPE,
                                   SV_num_ident        OUT NOCOPY   ge_clientes.Num_ident%TYPE,
                                   SV_cod_tipident     OUT NOCOPY   ge_clientes.Cod_Tipident%TYPE,
                                   SN_cod_ciclo        OUT NOCOPY   ge_clientes.Cod_Ciclo%TYPE,
                                   SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                   SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                   SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS

    /*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_cons_datos_cli_cod_pr"
        Lenguaje="PL/SQL"
        Fecha="24-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Retorna los datos del abonado a partir de un numero de teléfono</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_codCliente"  Tipo="NUMBER(8)">código Cliente</param>
    </Entrada>
    <Salida>
        <param nom="SV_num_ident"     Tipo="ge_clientes.Num_ident%TYPE">numero Identificacion Error</param>
        <param nom="SV_cod_tipident"  Tipo="ge_clientes.Cod_Tipident%TYPE">codigo tipo Identificacion</param>
        <param nom="SN_cod_ciclo"     Tipo="ge_clientes.Cod_Ciclo%TYPE">codigo ciclo</param>
        <param nom="SN_cod_error"     Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error" Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;

    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        SN_num_evento   := 0;




        LV_sSql := 'SELECT a.num_ident, a.cod_tipident, a.cod_ciclo'
                ||' FROM ge_clientes a  '
                ||' WHERE a.cod_cliente = '||EN_codCliente;

             SELECT a.num_ident, a.cod_tipident, a.cod_ciclo
             INTO SV_num_ident, SV_cod_tipident, SN_cod_ciclo
             FROM ge_clientes a
             WHERE a.cod_cliente = EN_codCliente;

EXCEPTION

     WHEN OTHERS THEN
          sn_cod_retorno := 301029;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_cons_datos_cli_cod_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_cons_datos_cli_cod_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_listar_cli_cuenta_pr(EN_codCuenta        IN  ge_clientes.cod_cuenta%TYPE,
                                  SC_cursor           OUT NOCOPY   refcursor,
                                  SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_listar_cli_cuenta_pr"
        Lenguaje="PL/SQL"
        Fecha="23-07-2009"
        Versión="1.1.0"
        Diseñador="Joan Zamorano"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Retorna un listado de datos del cliente a partir de un codigo cuenta</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_codCuenta"  Tipo="NUMBER(8)">codigo Cuenta</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursor  Tipo="refcursor">cursor de Cliente</param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error    ge_errores_pg.DesEvent;
     LV_sSql         ge_errores_pg.vQuery;
     i number;

     LV_nom_tabla  VARCHAR2 (25);
     LV_nom_columna VARCHAR2 (10);
     LV_cod_modulo  VARCHAR2 (3);

    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        SN_num_evento   := 0;
        LV_nom_tabla  :='GE_CLIENTES';
        LV_nom_columna:='COD_TIPO';
        LV_cod_modulo :='GE';

        LV_sSql := 'SELECT COUNT(1)'
                ||' FROM ge_clientes a, ga_cuentas b, ged_codigos c  '
                ||' WHERE a.cod_cuenta = b.cod_cuenta AND '
                ||' a.cod_tipo = c.cod_valor(+) AND '
                ||' b.cod_cuenta = '||EN_codCuenta
                ||' AND c.nom_tabla(+) =  '''|| LV_nom_tabla ||'''
                 AND c.nom_columna(+) = '''|| LV_nom_columna ||'''
                 AND c.cod_modulo(+) = '''|| LV_cod_modulo ||'''';

        EXECUTE IMMEDIATE LV_sSql INTO i;

        if i = 0 then
            RAISE cursorVacio_exception;
        end if;

        LV_sSql := 'SELECT a.cod_cuenta, a.cod_cliente, a.nom_cliente, a.nom_apeclien1, a.nom_apeclien2, a.cod_tipo, c.des_valor, b.des_cuenta'
                ||' FROM ge_clientes a, ga_cuentas b, ged_codigos c  '
                ||' WHERE a.cod_cuenta = b.cod_cuenta AND '
                ||' a.cod_tipo = c.cod_valor(+) AND '
                ||' b.cod_cuenta = '||EN_codCuenta
                ||' AND c.nom_tabla(+) =  '''|| LV_nom_tabla ||'''
                 AND c.nom_columna(+) = '''|| LV_nom_columna ||'''
                 AND c.cod_modulo(+) = '''|| LV_cod_modulo ||'''';

        OPEN SC_cursor FOR
            SELECT a.cod_cuenta, a.cod_cliente, a.nom_cliente, a.nom_apeclien1, a.nom_apeclien2, a.cod_tipo, c.des_valor,b.des_cuenta
            FROM ge_clientes a, ga_cuentas b, ged_codigos c
            WHERE a.cod_cuenta = b.cod_cuenta AND
            a.cod_tipo = c.cod_valor(+) AND
            b.cod_cuenta = EN_codCuenta AND
            c.nom_tabla(+) = LV_nom_tabla AND
            c.nom_columna(+) = LV_nom_columna AND
            c.cod_modulo(+) = LV_cod_modulo;

EXCEPTION

     WHEN cursorVacio_exception THEN
                SN_cod_retorno := 301030;
                IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error    :=  ' ge_listar_cli_cuenta_pr ('||'); - ' || SQLERRM;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_modulo_ge,
                                    SV_mens_retorno,
                                    CV_version,
                                    USER,
                                    'GE_INTEGRACION_PG.ge_listar_cli_cuenta_pr',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error );

     WHEN OTHERS THEN
          sn_cod_retorno := 301030;
          sv_mens_retorno := 'No existen clientes asociados al código de cuenta consultado';
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_listar_cli_cuenta_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_listar_cli_cuenta_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_listar_cli_nit_pr(EN_numIdent         IN  VARCHAR2,
                               EN_codTipIdent      IN  VARCHAR2,
                               SC_cursor           OUT NOCOPY   refcursor,
                               SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                               SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                               SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_listar_cli_nit_pr"
        Lenguaje="PL/SQL"
        Fecha="23-07-2009"
        Versión="1.1.0"
        Diseñador="Joan Zamorano"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Entrega Listado de Clientes por número de identificación del cliente (NIT) y el código de tipo de identificación</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_numIdem"  Tipo="VARCHAR2(20)">numero Identificacion del cliente</param>
        <param nom="EN_codTipIdent"  Tipo="VARCHAR2(2)">código de tipo de identificación</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursor  Tipo="refcursor">cursor de Cliente</param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error    ge_errores_pg.DesEvent;
     LV_sSql         ge_errores_pg.vQuery;
     i number;

     LV_nom_tabla  VARCHAR2 (25);
     LV_nom_columna VARCHAR2 (10);
     LV_cod_modulo  VARCHAR2 (3);

    BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        SN_num_evento   := 0;
        LV_nom_tabla  :='GE_CLIENTES';
        LV_nom_columna:='COD_TIPO';
        LV_cod_modulo :='GE';

       LV_sSql := 'SELECT COUNT(*)'
                ||' FROM ge_clientes a, ga_cuentas b, ged_codigos c  '
                ||' WHERE a.cod_cuenta = b.cod_cuenta AND '
                ||' a.num_ident = '''|| EN_numIdent||'''
                    AND a.cod_tipident ='''|| EN_codTipIdent ||'''
                    AND a.cod_tipo = c.cod_valor '
                ||' AND  c.nom_tabla =  '''|| LV_nom_tabla ||'''
                    AND c.nom_columna = '''||LV_nom_columna ||'''
                    AND c.cod_modulo= '''||LV_cod_modulo ||'''';

       EXECUTE IMMEDIATE LV_sSql INTO i;


        LV_sSql := 'SELECT a.cod_cuenta, a.cod_cliente, a.nom_cliente, a.nom_apeclien1, a.nom_apeclien2, a.cod_tipo, c.des_valor'
                ||' FROM ge_clientes a, ga_cuentas b, ged_codigos c  '
                ||' WHERE a.cod_cuenta = b.cod_cuenta AND '
                ||' a.num_ident = '''|| EN_numIdent||'''
                    AND a.cod_tipident ='''|| EN_codTipIdent ||'''
                     AND a.cod_tipo = c.cod_valor '
                ||' AND  c.nom_tabla =  '''|| LV_nom_tabla ||'''
                     AND c.nom_columna = '''||LV_nom_columna ||'''
                     AND c.cod_modulo= '''||LV_cod_modulo ||'''';

        if i = 0 then
            RAISE cursorVacio_exception;
        end if;

        OPEN SC_cursor FOR
                SELECT a.cod_cuenta, a.cod_cliente, a.nom_cliente, a.nom_apeclien1, a.nom_apeclien2, a.cod_tipo, c.des_valor
                FROM ge_clientes a, ga_cuentas b, ged_codigos c
                WHERE a.cod_cuenta = b.cod_cuenta AND
                a.num_ident = EN_numIdent AND
                a.cod_tipident = EN_codTipIdent AND
                a.cod_tipo = c.cod_valor AND
                c.nom_tabla = LV_nom_tabla AND
                c.nom_columna = LV_nom_columna AND
                c.cod_modulo= LV_cod_modulo;

EXCEPTION

     WHEN cursorVacio_exception THEN
                SN_cod_retorno := 301031;
                IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error    :=  ' ge_listar_cli_nit_pr ('||'); - ' || SQLERRM;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_modulo_ge,
                                    SV_mens_retorno,
                                    CV_version,
                                    USER,
                                    'GE_INTEGRACION_PG.ge_listar_cli_nit_pr',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error );

     WHEN OTHERS THEN
          sn_cod_retorno := 301031;
           IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_listar_cli_nit_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_listar_cli_nit_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_cons_conc_factura_pr(EN_codCliente       IN NUMBER,
                                  EN_codTipDocum      IN NUMBER,
                                  EN_num_folio        IN NUMBER,
                                  SC_cursor           OUT NOCOPY refcursor,
                                  SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                  SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                  SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS
/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_cons_conc_factura_pr"
        Lenguaje="PL/SQL"
        Fecha="01-06-2009"
        Versión="1.0.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> boolean </Retorno>
    <Descripción>
         Retorna los códigos y descripciones de conceptos facturables según corresponda
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_codCliente  Tipo="NUMBER(8)">Codigo Cliente</param>
        <param nom="EN_codTipDocum" Tipo="NUMBER(2)">Codigo Tipo Documernto</param>
        <param nom="EN_num_folio" Tipo="NUMBER(9)">Numero folio</param>

    </Entrada>
    <Salida>
        <param nom="SC_cursor"        Tipo="refcursor>Cursor</param>
        <param nom="SN_cod_error"     Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error" Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;
     i number;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;

     LV_sSql := 'SELECT COUNT(*) '
            ||' FROM (SELECT a.cod_concepto, b.des_concepto, a.importe_debe, a.importe_haber '
            ||' FROM co_cartera a, co_conceptos b '
            ||' WHERE a.cod_concepto = b.cod_concepto AND '
            ||' a.cod_cliente = '||EN_codCliente
            ||' AND a.cod_tipdocum = 2 AND '
            ||' a.num_folio = '||  EN_num_folio
            ||' UNION '
            ||' SELECT  a.cod_concepto, b.des_concepto, a.importe_debe, a.importe_haber '
            ||' FROM co_cancelados a, co_conceptos b '
            ||' WHERE a.cod_concepto = b.cod_concepto AND '
            ||' a.cod_cliente = '||EN_codCliente
            ||' AND a.cod_tipdocum = 2 AND '
            ||' a.num_folio = '||  EN_num_folio
            ||' ) c ORDER BY c.cod_concepto ASC';

    EXECUTE IMMEDIATE LV_sSql INTO i;

    LV_sSql := 'SELECT c.cod_concepto, c.des_concepto, c.importe_debe, c.importe_haber'
            ||' FROM (SELECT a.cod_concepto, b.des_concepto, a.importe_debe, a.importe_haber '
            ||' FROM co_cartera a, co_conceptos b '
            ||' WHERE a.cod_concepto = b.cod_concepto AND '
            ||' a.cod_cliente = '||EN_codCliente
            ||' AND a.cod_tipdocum = 2 AND '
            ||' a.num_folio = '||  EN_num_folio
            ||' UNION '
            ||' SELECT  a.cod_concepto, b.des_concepto, a.importe_debe, a.importe_haber '
            ||' FROM co_cancelados a, co_conceptos b '
            ||' WHERE a.cod_concepto = b.cod_concepto AND '
            ||' a.cod_cliente = '||EN_codCliente
            ||' AND a.cod_tipdocum = 2 AND '
            ||' a.num_folio = '||  EN_num_folio
            ||' ) c ORDER BY c.cod_concepto ASC';

     if i = 0 then
            RAISE cursorVacio_exception;
        end if;


         OPEN SC_cursor FOR
            SELECT c.cod_concepto, c.des_concepto, c.importe_debe, c.importe_haber
            FROM (SELECT a.cod_concepto, b.des_concepto, a.importe_debe, a.importe_haber
                FROM co_cartera a, co_conceptos b
                WHERE a.cod_concepto = b.cod_concepto AND
                      a.cod_cliente = EN_codCliente AND
                      a.cod_tipdocum = 2 AND
                      a.num_folio = EN_num_folio
                UNION
                SELECT  a.cod_concepto, b.des_concepto, a.importe_debe, a.importe_haber
                FROM co_cancelados a, co_conceptos b
                WHERE a.cod_concepto = b.cod_concepto AND
                      a.cod_cliente = EN_codCliente AND
                      a.cod_tipdocum = 2 AND
                      a.num_folio = EN_num_folio) c
            ORDER BY c.cod_concepto ASC;


EXCEPTION

     WHEN cursorVacio_exception THEN
                SN_cod_retorno := 301032;
                IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error    :=  ' ge_cons_conc_factura_pr ('||'); - ' || SQLERRM;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_modulo_ge,
                                    SV_mens_retorno,
                                    CV_version,
                                    USER,
                                    'GE_INTEGRACION_PG.ge_cons_conc_factura_pr',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error );


      WHEN OTHERS THEN
          sn_cod_retorno := 301032;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_cons_conc_factura_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_cons_conc_factura_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_consultar_ss_vigentes_pr(EN_num_abonado      IN  ga_servsuplabo.num_abonado%TYPE,
                                     SC_cursor           OUT NOCOPY   refcursor,
                                     SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_consultar_ss_vigente_pr"
        Lenguaje="PL/SQL"
        Fecha="30-07-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Retorna un listado de servicios suplementarios vigentes del Abonado</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_num_abonado"  Tipo="ga_servsuplabo.num_abonado%TYPE">número abonado</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursor  Tipo="refcursor">cursor de Servicios suplementarios vigentes</param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error    ge_errores_pg.DesEvent;
     LV_sSql         ge_errores_pg.vQuery;
     LN_estado number;

   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        SN_num_evento   := 0;
        LN_estado       := 3;

         LV_sSql := 'SELECT a.cod_servicio, a.cod_servsupl, a.cod_nivel, b.des_servicio'
                ||' FROM ga_servsuplabo a, ga_servsupl b '
                ||' WHERE a.cod_servicio = b.cod_servicio AND '
                ||' a.num_abonado = '|| EN_num_abonado
                ||' AND a.ind_estado < '||LN_estado;


        OPEN SC_cursor FOR
            SELECT a.cod_servicio, a.cod_servsupl, a.cod_nivel, b.des_servicio
            FROM ga_servsuplabo a, ga_servsupl b
            WHERE a.cod_servicio = b.cod_servicio AND
            a.num_abonado = EN_num_abonado AND
            a.ind_estado < LN_estado;

EXCEPTION

    WHEN OTHERS THEN
          sn_cod_retorno := 301033;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_consultar_ss_vigente_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, sv_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_consultar_ss_vigente_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_consultar_ss_inactivos_pr(EN_num_abonado      IN  ga_servsuplabo.num_abonado%TYPE,
                                       SC_cursor           OUT NOCOPY   refcursor,
                                       SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
                                       SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
                                       SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = " ge_consultar_ss_inactivos_pr"
        Lenguaje="PL/SQL"
        Fecha="30-07-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Retorna un listado de servicios suplementarios inactivos del Abonado</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_num_abonado"  Tipo="ga_servsuplabo.num_abonado%TYPE">número abonado</param>
    </Entrada>
    <Salida>
        <param nom="SC_cursor  Tipo="refcursor">cursor de Servicios suplementarios vigentes</param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error    ge_errores_pg.DesEvent;
     LV_sSql         ge_errores_pg.vQuery;
     LN_ind_estado1 number;
     LN_ind_estado2 number;

   BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        SN_num_evento   := 0;
        LN_ind_estado1  := 3;
        LN_ind_estado2  := 4;


        LV_sSql := 'SELECT DISTINCT a.cod_servicio, a.cod_servsupl, a.cod_nivel, b.des_servicio'
                ||' FROM ga_servsuplabo a, ga_servsupl b '
                ||' WHERE a.cod_servicio = b.cod_servicio AND '
                ||' a.num_abonado = '||EN_num_abonado
                ||' AND a.ind_estado BETWEEN '||LN_ind_estado1
                ||' AND'||LN_ind_estado2
                ||' AND a.cod_servicio NOT IN (SELECT a.cod_servicio'
                ||' FROM ga_servsuplabo a '
                ||' WHERE a.num_abonado ='||EN_num_abonado
                ||' AND a.ind_estado < ='||LN_ind_estado1
                ||' )';

        OPEN SC_cursor FOR
             SELECT DISTINCT a.cod_servicio, a.cod_servsupl, a.cod_nivel, b.des_servicio
             FROM ga_servsuplabo a, ga_servsupl b
             WHERE a.cod_servicio = b.cod_servicio AND
                   a.num_abonado = EN_num_abonado AND
                   a.ind_estado BETWEEN LN_ind_estado1 AND LN_ind_estado2 AND
                   a.cod_servicio NOT IN (SELECT a.cod_servicio
                                          FROM ga_servsuplabo a
                                          WHERE a.num_abonado = EN_num_abonado AND
                                          a.ind_estado < LN_ind_estado1 );

EXCEPTION

     WHEN OTHERS THEN
          sn_cod_retorno := 301033;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_consultar_ss_inactivos_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_consultar_ss_inactivos_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_obtener_seg_cliente_pr(EN_cod_cliente      IN         ga_abocel.Cod_cliente%TYPE,
                                     SV_cod_segmento     OUT NOCOPY ge_clientes.Cod_segmento%TYPE,
                                     SV_des_segmento     OUT NOCOPY ge_segmentacion_clientes_td.Des_segmento%TYPE,
                                     SV_cod_tipo         OUT NOCOPY ge_clientes.Cod_tipo%TYPE,
                                     SV_des_tipo         OUT NOCOPY ged_codigos.Des_valor%TYPE,
                                     SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_obtener_segmento_cliente__pr"
        Lenguaje="PL/SQL"
        Fecha="03-08-2009"
        Versión="1.1.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> boolean </Retorno>
    <Descripción>
         Retorna Datos del segmento del cliente
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_cod_cliente"  Tipo="ga_abocel.Cod_cliente%TYPE">Codigo Cliente</param>
    </Entrada>
    <Salida>
        <param nom="SV_cod_segmento"   Tipo="ge_clientes.Cod_segmento%TYPE">Código del segmento del cliente</param>
        <param nom="SV_des_segmento"   Tipo="ge_segmentacion_clientes_td.Des_segmento%TYPE">Descripción del segmento del cliente</param>
        <param nom="SV_cod_tipo"       Tipo="ge_clientes.Cod_tipo%TYPE">Código del tipo de cliente</param>
        <param nom="SV_des_tipo"       Tipo="ged_codigos.Des_valor%TYPE">Descripción del tipo del cliente</param>
        <param nom="SN_cod_retorno"    Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;


     LV_nom_tabla  VARCHAR2 (25);
     LV_nom_columna VARCHAR2 (10);
     LV_cod_modulo  VARCHAR2 (3);

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;
    LV_nom_tabla  :='GE_CLIENTES';
    LV_nom_columna:='COD_TIPO';
    LV_cod_modulo :='GE';

    LV_sSql := 'SELECT a.cod_segmento, c.des_segmento, a.cod_tipo, b.des_valor as des_tipo '
            ||' FROM ge_clientes a, ged_codigos b, ge_segmentacion_clientes_td c '
            ||' WHERE a.cod_tipo = b.cod_valor AND '
            ||' a.cod_segmento = c.cod_segmento AND '
            ||' a.cod_tipo = c.cod_tipo AND'
            ||' a.cod_cliente = '|| EN_cod_cliente
            ||' AND b.nom_tabla = ' || LV_nom_tabla
            ||' AND b.nom_columna = '  || LV_nom_columna
            ||' AND b.cod_modulo = ' ||LV_cod_modulo;



            SELECT a.cod_segmento, c.des_segmento, a.cod_tipo, b.des_valor as des_tipo
            INTO SV_cod_segmento, SV_des_segmento, SV_cod_tipo, SV_des_tipo
            FROM ge_clientes a, ged_codigos b, ge_segmentacion_clientes_td c
            WHERE a.cod_tipo = b.cod_valor AND
                  a.cod_segmento = c.cod_segmento AND
                  a.cod_tipo = c.cod_tipo AND
                  a.cod_cliente = EN_cod_cliente AND
                  b.nom_tabla = LV_nom_tabla AND
                  b.nom_columna = LV_nom_columna AND
                  b.cod_modulo = LV_cod_modulo;

EXCEPTION

      WHEN OTHERS THEN
          sn_cod_retorno := 301034;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
             sv_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_obtener_segmento_cliente_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, sv_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_obtener_segmento_cliente_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE ge_obtiene_fecha_corte_pr(EN_codCicloFact     IN  fa_ciclfact.cod_ciclfact%TYPE,
                                    SD_fecDesdellam     OUT NOCOPY fa_ciclfact.fec_desdellam%TYPE,
                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
AS

/*--
    <Documentación TipoDoc = "PROCEDURE">
        Elemento Nombre = "ge_obtiene_fecha_corte_pr"
        Lenguaje="PL/SQL"
        Fecha="04-08-2009"
        Versión="1.0.0"
        Diseñador="Daniel Jara"
        Programador="Daniel Jara"
        Ambiente="BD"
    <Retorno> FecHastallam </Retorno>
    <Descripción>
         Retorna la fecha de corte de ciclo asociada al ciclo de facturación
    </Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_codCicloFact"  Tipo="fa_ciclfact.cod_ciclfact%TYPE">Codigo Cliclo Facturacion</param>
    </Entrada>
    <Salida>
        <param nom="SD_fecHastallam"    Tipo="ga_abocel.fec_hastallam%TYPE">fecha de la última llamada</param>
        <param nom="SN_cod_retorno"    Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mens_retorno"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"     Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error ge_errores_pg.DesEvent;
     LV_sSql      ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento   := 0;

    LV_sSql := ' SELECT a.fec_desdellam'
             ||' FROM fa_ciclfact a'
             ||' WHERE a.cod_ciclfact = '||EN_codCicloFact ;



              SELECT a.fec_desdellam
              INTO SD_fecDesdellam
              FROM fa_ciclfact a
              WHERE a.cod_ciclfact = EN_codCicloFact;

EXCEPTION

      WHEN OTHERS THEN
          sn_cod_retorno := 301035;
          IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_errornoclasificado;
          END IF;
          LV_des_error   := ' ge_obtiene_fecha_corte_pr ('||'); - ' || SQLERRM;
          sn_num_evento  := Ge_Errores_Pg.grabarpl( sn_num_evento, CV_modulo_ge, SV_mens_retorno, CV_version, USER, 'GE_INTEGRACION_PG.ge_obtiene_fecha_corte_pr', lv_ssql, sn_cod_retorno, LV_des_error );
END;

PROCEDURE GE_CONSGEDPARAMETRO_PR (  EV_nom_parametro    IN         ged_parametros.nom_parametro%TYPE,
                                    EV_cod_modulo       IN         ged_parametros.cod_modulo%TYPE,
                                    EN_cod_producto     IN         ged_parametros.cod_producto%TYPE,
                                    SV_valor_parametro  OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                    SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)

IS

/*--
    <Documentación TipoDoc = "Procedure">
        Elemento Nombre = "GE_CONSGEDPARAMETRO_PR"
        Lenguaje="PL/SQL"
        Fecha="02-06-2009"
        Versión="1.0.0"
        Diseñador="Leonardo Muñoz R."
        Programador="Leonardo Muñoz R."
        Ambiente="BD"
    <Retorno> varchar </Retorno>
    <Descripción>
        Retorna el código de tecnología GSM.
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="nom_parametro"  Tipo="VARCHAR(2) "> Nombre parámetro tecnología </param>
        <param  nom="cod_modulo"     Tipo="VARCHAR(2)""> Código de modulo </param>
        <param  nom="cod_producto    Tipo="NUMBER(1)"  > Código de producto </param>
    </Entrada>
    <Salida>
        <param  nom="val_parametro" Tipo="VARCHAR(2)> Parametro tecnología </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error           ge_errores_pg.DesEvent;
     LV_sSql                ge_errores_pg.vQuery;


BEGIN
    SN_cod_error:=0;
    SV_mensaje_error:='';
    SN_num_evento:= 0;

    LV_sSql := 'SELECT a.val_parametro '
            ||' FROM ged_parametros a'
            ||' WHERE a.nom_parametro = '   || EV_nom_parametro
            ||' AND a.cod_modulo = '        || EV_cod_modulo
            ||' AND a.cod_producto = '      || EN_cod_producto;

    SELECT a.val_parametro into SV_valor_parametro
    FROM ged_parametros a
    WHERE a.nom_parametro = EV_nom_parametro AND
      a.cod_modulo = EV_cod_modulo AND
      a.cod_producto = EN_cod_producto;

EXCEPTION
        WHEN OTHERS THEN
            SN_cod_error := 301036;
             IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error,SV_mensaje_error) THEN
                SV_mensaje_error := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_CONSGEDPARAMETRO_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mensaje_error || EV_nom_parametro,
                                cv_version,
                                USER,
                                'GE_INTEGRACION_PG.GE_CONSGEDPARAMETRO_PR',
                                LV_sSql,
                                SN_cod_error,
                                LV_des_error );

END;


Procedure GE_CONSPUK_PR (  EN_num_celular     IN         ga_abocel.num_celular%TYPE,
                           SV_puk             OUT NOCOPY gsm_det_simcard_to.val_campo%TYPE,
                           SN_cod_error       OUT NOCOPY ge_errores_pg.CodError,
                           SV_mensaje_error   OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

IS

        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "GE_CONSPUK_PR"
            Lenguaje="PL/SQL"
            Fecha="29-05-2009"
            Versión="1.0.0"
            Diseñador="Leonardo Muñoz"
            Programador="Leonardo Muñoz"
            Ambiente="BD"
        <Retorno>
                  NA
        </Retorno>
        <Descripción>
                  Servicio que permite consultar el PUK de una Serie Simcard
        </Descripción>
        <Parámetros>
             <Entrada>
                <param  nom="EN_num_celular"  Tipo="NUMBER(15)"> Número de celular abonado </param>
             </Entrada>
             <Salida>
                NA
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

        LV_des_error            ge_errores_pg.DesEvent;
        LV_sSql                 ge_errores_pg.vQuery;
        LV_tecnologia           varchar2(20);
        LN_serie                al_series.num_serie%TYPE;
        LE_error_exception      EXCEPTION;
        LE_error_tecnologia     EXCEPTION;

        EV_nom_parametro    ged_parametros.nom_parametro%TYPE;
        EV_cod_modulo       ged_parametros.cod_modulo%TYPE;
        EN_cod_producto     ged_parametros.cod_producto%TYPE;

BEGIN
        LV_tecnologia    := '';
        EV_nom_parametro := 'GRUPO_TEC_GSM';
        EV_cod_modulo    := 'GA';
        EN_cod_producto  := 1;
        SN_cod_error     := 0;
        SV_mensaje_error := '';
        SN_num_evento    := 0;

        LV_sSql := 'GE_INTEGRACION_PG.GE_CONSGEDPARAMETRO_PR(' || EV_nom_parametro;
        LV_sSql := LV_sSql || ', ' || EV_cod_modulo;
        LV_sSql := LV_sSql || ', ' || EN_cod_producto;
        LV_sSql := LV_sSql || ', ' || LV_tecnologia;
        LV_sSql := LV_sSql || ', ' || SN_cod_error;
        LV_sSql := LV_sSql || ', ' || SV_mensaje_error;
        LV_sSql := LV_sSql || ', ' || SN_num_evento || ')';

        --LV_tecnologia := GE_INTEGRACION_PG.GE_CONSGEDPARAMETRO_FN(EV_nom_parametro, EV_cod_modulo, EN_cod_producto, SN_cod_error, SV_mensaje_error, SN_num_evento);
        GE_INTEGRACION_PG.GE_CONSGEDPARAMETRO_PR(EV_nom_parametro, EV_cod_modulo, EN_cod_producto, LV_tecnologia, SN_cod_error, SV_mensaje_error, SN_num_evento);

        IF SN_cod_error <> 0 THEN
            RAISE LE_error_tecnologia;
        END IF;


            LV_sSql := ' SELECT a.num_serie into LN_nserie'
                     ||' FROM ga_abocel a'
                     ||' WHERE a.nom_perfil_proceso = '||LV_tecnologia
                     ||' AND a.num_celular = '||EN_num_celular
                     ||' AND a.cod_producto = 1 '
                     ||' AND a.cod_situacion NOT IN (''BAA'',''BAP'')'
                     ||' UNION'
                     ||' SELECT a.num_serie'
                     ||' FROM ga_aboamist a'
                     ||' WHERE a.cod_tecnologia = '||LV_tecnologia
                     ||' AND a.num_celular = '||EN_num_celular
                     || 'and a.cod_producto = 1 AND'
                     ||' AND a.cod_situacion NOT IN (''BAA'',''BAP'')';

            SELECT a.num_serie into LN_serie
            FROM ga_abocel a
            WHERE a.cod_tecnologia = LV_tecnologia AND
                  a.num_celular = EN_num_celular AND
                  a.cod_producto = 1 AND
                  a.cod_situacion NOT IN ('BAA','BAP')
            UNION
            SELECT a.num_serie
            FROM ga_aboamist a
            WHERE a.cod_tecnologia = LV_tecnologia AND
                  a.num_celular = EN_num_celular AND
                  a.cod_producto = 1 AND
                  a.cod_situacion NOT IN ('BAA','BAP');

            LV_sSql := 'fRecuperSIMCARD_FN(' || LN_serie;
            LV_sSql := LV_sSql || ', ''PUK'')';

            SV_puk := fRecuperSIMCARD_FN(LN_serie,'PUK');

            IF SV_puk = '*' THEN
                RAISE LE_error_exception;
            END IF;

EXCEPTION
            WHEN LE_error_tecnologia THEN
                SN_cod_error       := 301037;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error,SV_mensaje_error) THEN
                    SV_mensaje_error := CV_errornoclasificado;
                END IF;
                LV_des_error       := 'ge_integracion_pg.ge_conspuk_pr ('||'); - ' || SQLERRM;
                SN_num_evento      := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_modulo_ge,SV_mensaje_error, cv_version, USER,'ge_integracion_pg.ge_conspuk_pr', LV_sSql, SN_cod_error, LV_des_error );

            WHEN OTHERS THEN
                 SN_cod_error       := 301037;
                 IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error,SV_mensaje_error) THEN
                    SV_mensaje_error := CV_errornoclasificado;
                 END IF;
                 LV_des_error       := 'ge_integracion_pg.ge_conspuk_pr ('||'); - ' || SQLERRM;
                 SN_num_evento      := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_modulo_ge,SV_mensaje_error, cv_version, USER,'ge_integracion_pg.ge_conspuk_pr', LV_sSql, SN_cod_error, LV_des_error );

END;


PROCEDURE GE_VALNUMTELEFONICA_PR (EN_num_celular     IN         ga_abocel.num_celular%TYPE,
                                  EN_cod_operador    IN         ta_numnacional.cod_operador%TYPE,
                                  SN_cod_error       OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mensaje_error   OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
IS

        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "GE_VALNUMTELEFONICA_PR"
            Lenguaje="PL/SQL"
            Fecha="08-06-2009"
            Versión="1.0.0"
            Diseñador="Leonardo Muñoz"
            Programador="Leonardo Muñoz"
            Ambiente="BD"
        <Retorno>
                  NA
        </Retorno>
        <Descripción>
                  Servicio que permite validar si un número de teléfono pertenece al plan de numeración de telefónica
        </Descripción>
        <Parámetros>
             <Entrada>
                <param  nom="SN_num_celular"  Tipo="NUMBER(15)"> Número de celular abonado</param>
             </Entrada>
             <Salida>
               NA
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

        LV_des_error            ge_errores_pg.DesEvent;
        LV_sSql                 ge_errores_pg.vQuery;
        i numeric;

BEGIN

        SN_num_evento    := 0;
        SN_cod_error     := 0;
        SV_mensaje_error := '';

            LV_sSql := ' SELECT 1 into i'
                     ||' FROM ta_numnacional a'
                     ||' WHERE '|| EN_num_celular ||' BETWEEN a.num_tdesde AND a.num_thasta AND'
                     ||' a.cod_operador = EN_cod_operador';

            SELECT 1 INTO i
            FROM ta_numnacional a
            WHERE EN_num_celular BETWEEN a.num_tdesde AND a.num_thasta AND
                  a.cod_operador = EN_cod_operador;

EXCEPTION

            WHEN OTHERS THEN

                 SN_cod_error    := 301038;
                 IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error,SV_mensaje_error) THEN
                    SV_mensaje_error := CV_errornoclasificado;
                 END IF;
                  LV_des_error       := 'ge_integracion_pg.ge_valnumtelefonica_pr ('||'); - ' || SQLERRM;
                  SN_num_evento      := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_modulo_ge,SV_mensaje_error, cv_version, USER,'ge_integracion_pg.ge_valnumtelefonica_pr', LV_sSql, SN_cod_error, LV_des_error );

END;

PROCEDURE GE_AVISOSIN_PR (  EN_num_celular      IN ga_abocel.num_celular%TYPE,
                            EN_cod_estado       IN ga_siniestros.cod_estado%TYPE,
                            SC_cursor          OUT NOCOPY refcursor,
                            SN_cod_error       OUT NOCOPY ge_errores_pg.CodError,
                            SV_mensaje_error   OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

IS

        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "GE_AVISOSIN_PR"
            Lenguaje="PL/SQL"
            Fecha="17-06-2009"
            Versión="1.0.0"
            Diseñador="Leonardo Muñoz"
            Programador="Leonardo Muñoz"
            Ambiente="BD"
        <Retorno>
                  NA
        </Retorno>
        <Descripción>
                  Servicio que permite consultar los avisos de siniestros que tiene vigente un número telefónico
        </Descripción>
        <Parámetros>
             <Entrada>
                    <param  nom="EN_num_celular"  Tipo="NUMBER(15)"> Número de celular abonado </param>
             </Entrada>
             <Salida>
                    <param nom="SC_cursor"  Tipo="refcursor>Cursor</param>
                    <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
                    <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
                    <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

        LV_des_error        ge_errores_pg.DesEvent;
        LV_sSql             ge_errores_pg.vQuery;
        i number;
BEGIN

            SN_cod_error:=0;
            SV_mensaje_error:='';
            SN_num_evento:= 0;

            LV_sSql := ' SELECT COUNT(*)'
                     ||' FROM ga_siniestros a, ga_abocel b, ga_causinie c, al_tipos_terminales d'
                     ||' WHERE a.num_abonado = b.num_abonado'
                     ||' AND a.cod_estado IN ('||EN_cod_estado||')'
                     ||' AND b.num_celular = ' ||EN_num_celular
                     ||' AND b.cod_situacion NOT IN (''BAA'', ''BAP'')'
                     ||' AND a.cod_causa = c.cod_causa'
                     ||' AND a.cod_producto = c.cod_producto'
                     ||' AND a.tip_terminal = d.tip_terminal';

            EXECUTE IMMEDIATE LV_sSql INTO i;

            LV_sSql := ' SELECT a.num_siniestro, a.num_abonado, a.cod_producto, a.cod_causa, c.des_causa,'
                     ||' a.cod_estado, a.num_serie, a.fec_siniestro, a.cod_servicio, a.ind_susp,'
                     ||' a.tip_terminal, d.des_terminal'
                     ||' FROM ga_siniestros a, ga_abocel b, ga_causinie c, al_tipos_terminales d'
                     ||' WHERE a.num_abonado = b.num_abonado'
                     ||' AND a.cod_estado IN ('||EN_cod_estado||')'
                     ||' AND b.num_celular = ' ||EN_num_celular
                     ||' AND b.cod_situacion NOT IN (''BAA'', ''BAP'')'
                     ||' AND a.cod_causa = c.cod_causa'
                     ||' AND a.cod_producto = c.cod_producto'
                     ||' AND a.tip_terminal = d.tip_terminal';

        if i = 0 then
            RAISE cursorVacio_exception;
        end if;

            OPEN SC_cursor FOR LV_sSql;
            /*
            OPEN SC_cursor FOR
                SELECT a.num_siniestro, a.num_abonado, a.cod_producto, a.cod_causa, c.des_causa,
                       a.cod_estado, a.num_serie, a.fec_siniestro, a.cod_servicio, a.ind_susp,
                       a.tip_terminal, d.des_terminal
                FROM ga_siniestros a, ga_abocel b, ga_causinie c, al_tipos_terminales d
                WHERE a.num_abonado = b.num_abonado AND
                      a.cod_estado IN ('AV','FO') AND
                      b.num_celular = EN_num_celular AND
                      b.cod_situacion NOT IN ('BAA', 'BAP') AND
                      a.cod_causa = c.cod_causa AND
                      a.cod_producto = c.cod_producto AND
                      a.tip_terminal = d.tip_terminal;
            */
EXCEPTION
            WHEN cursorVacio_exception THEN
            SN_cod_error := 301039;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error, SV_mensaje_error) THEN
                SV_mensaje_error := CV_errornoclasificado;
             END IF;
                LV_des_error    :=  ' ge_avisosin_pr ('||'); - ' || SQLERRM;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_modulo_ge,
                                    SV_mensaje_error,
                                    cv_version,
                                    USER,
                                    'GE_INTEGRACION_PG.ge_avisosin_pr',
                                    LV_sSql,
                                    SN_cod_error,
                                    LV_des_error );

            WHEN OTHERS THEN
            SN_cod_error := 301040;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error, SV_mensaje_error) THEN
                SV_mensaje_error := CV_errornoclasificado;
             END IF;
            LV_des_error    :=  ' ge_avisosin_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mensaje_error,
                                cv_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_avisosin_pr',
                                LV_sSql,
                                SN_cod_error,
                                LV_des_error );
END;

PROCEDURE GE_CONS_CLIE_POS_PR (     EN_num_celular      IN         ga_abocel.num_celular%TYPE,
                                    SD_fec_sistema      OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_num_celular      OUT NOCOPY ga_abocel.NUM_CELULAR%TYPE,
                                    SN_cod_cliente      OUT NOCOPY ga_abocel.COD_CLIENTE%TYPE,
                                    SD_fec_alta         OUT NOCOPY ga_abocel.FEC_ALTA%TYPE,
                                    SD_fec_fincontra    OUT NOCOPY ga_abocel.FEC_FINCONTRA%TYPE,
                                    SV_nom_cliente      OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                                    SV_nom_apeclien1    OUT NOCOPY ge_clientes.NOM_APECLIEN1%TYPE,
                                    SV_nom_apeclien2    OUT NOCOPY ge_clientes.NOM_APECLIEN2%TYPE,
                                    SV_num_ident        OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                                    SV_cod_tipident     OUT NOCOPY ge_clientes.COD_TIPIDENT%TYPE,
                                    SV_des_nit          OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                                    SV_num_ident2       OUT NOCOPY ge_clientes.NUM_IDENT2%TYPE,
                                    SV_cod_tipident2    OUT NOCOPY ge_clientes.COD_TIPIDENT2%TYPE,
                                    SV_num_identapor    OUT NOCOPY ge_clientes.NUM_IDENTAPOR%TYPE,
                                    SV_cod_tipidentapor OUT NOCOPY ge_clientes.COD_TIPIDENTAPOR%TYPE,
                                    SD_fec_nacimien     OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_cod_profesion    OUT NOCOPY ge_clientes.COD_PROFESION%TYPE,
                                    SV_cod_ocupacion    OUT NOCOPY ge_clientes.COD_OCUPACION%TYPE,
                                    SV_nom_apoderado    OUT NOCOPY ge_clientes.NOM_APODERADO%TYPE,
                                    SV_ind_estcivil     OUT NOCOPY ge_clientes.IND_ESTCIVIL%TYPE,
                                    SV_estado_civil     OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_cod_pais         OUT NOCOPY ge_clientes.COD_PAIS%TYPE,
                                    SV_des_pais         OUT NOCOPY ge_paises.DES_PAIS%TYPE,
                                    SV_cod_tecnologia   OUT NOCOPY ga_abocel.COD_TECNOLOGIA%TYPE,
                                    SV_num_serie        OUT NOCOPY ga_abocel.NUM_SERIE%TYPE,
                                    SV_num_imei         OUT NOCOPY ga_abocel.NUM_IMEI%TYPE,
                                    SV_cod_plantarif    OUT NOCOPY ga_abocel.COD_PLANTARIF%TYPE,
                                    SV_des_plantarif    OUT NOCOPY ta_plantarif.DES_PLANTARIF%TYPE,
                                    SV_cod_tipo         OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                                    SV_tip_cliente      OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_tef_cliente1     OUT NOCOPY ge_clientes.TEF_CLIENTE1%TYPE,
                                    SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "GE_CONS_CLIE_POS_PR"
            Lenguaje="PL/SQL"
            Fecha="23-06-2009"
            Versión="1.0.0"
            Diseñador="Leonardo Muñoz"
            Programador="Leonardo Muñoz"
            Ambiente="BD"
        <Retorno>
                  NA
        </Retorno>
        <Descripción>
                  Servicio que permite retornar los datos generales asociados a un cliente a partir
                  del número de teléfono de uno de sus abonados.
        </Descripción>
        <Parámetros>
             <Entrada>
                    <param  nom="EN_num_celular"  Tipo="NUMBER(15)"> Número de celular abonado </param>
             </Entrada>
             <Salida>
                    <param nom="SD_fec_sistema" Tipo="ge_clientes.FEC_NACIMIEN">fec_sistema</param>
                    <param nom="SN_num_celular" Tipo="ga_abocel.NUM_CELULAR">num_celular</param>
                    <param nom="SN_cod_cliente" Tipo="ga_abocel.COD_CLIENTE">cod_cliente</param>
                    <param nom="SD_fec_alta" Tipo="ga_abocel.FEC_ALTA">fec_alta</param>
                    <param nom="SD_fec_fincontra" Tipo="ga_abocel.FEC_FINCONTRA">fec_fincontra</param>
                    <param nom="SV_nom_cliente" Tipo="ge_clientes.NOM_CLIENTE">nom_cliente</param>
                    <param nom="SV_nom_apeclien1" Tipo="ge_clientes.NOM_APECLIEN1">nom_apeclien1</param>
                    <param nom="SV_nom_apeclien2" Tipo="ge_clientes.NOM_APECLIEN2">nom_apeclien2</param>
                    <param nom="SV_num_ident" Tipo="ge_clientes.NUM_IDENT">num_ident</param>
                    <param nom="SV_cod_tipident" Tipo="ge_clientes.COD_TIPIDENT">cod_tipident</param>
                    <param nom="SV_des_nit" Tipo="ge_tipident.DES_TIPIDENT">des_nit</param>
                    <param nom="SV_num_ident2" Tipo="ge_clientes.NUM_IDENT2">num_ident2</param>
                    <param nom="SV_cod_tipident2" Tipo="ge_clientes.COD_TIPIDENT2">cod_tipident2</param>
                    <param nom="SV_num_identapor" Tipo="ge_clientes.NUM_IDENTAPOR">num_identapor</param>
                    <param nom="SV_cod_tipidentapor" Tipo="ge_clientes.COD_TIPIDENTAPOR">cod_tipidentapor</param>
                    <param nom="SD_fec_nacimien" Tipo="ge_clientes.FEC_NACIMIEN">fec_nacimien</param>
                    <param nom="SN_cod_profesion" Tipo="ge_clientes.COD_PROFESION">cod_profesion</param>
                    <param nom="SV_nom_apoderado" Tipo="ge_clientes.NOM_APODERADO">nom_apoderado</param>
                    <param nom="SV_ind_estcivil" Tipo="ge_clientes.IND_ESTCIVIL">ind_estcivil</param>
                    <param nom="SV_estado_civil" Tipo="ged_codigos.DES_VALOR">estado_civil</param>
                    <param nom="SV_cod_pais" Tipo="ge_clientes.COD_PAIS">cod_pais</param>
                    <param nom="SV_des_pais" Tipo="ge_paises.DES_PAIS">des_pais</param>
                    <param nom="SV_cod_tecnologia" Tipo="ga_abocel.COD_TECNOLOGIA">cod_tecnologia</param>
                    <param nom="SV_num_serie" Tipo="ga_abocel.NUM_SERIE">num_serie</param>
                    <param nom="SV_num_imei" Tipo="ga_abocel.NUM_IMEI">num_imei</param>
                    <param nom="SV_cod_plantarif" Tipo="ga_abocel.COD_PLANTARIF">cod_plantarif</param>
                    <param nom="SV_des_plantarif" Tipo="ta_plantarif.DES_PLANTARIF">des_plantarif</param>
                    <param nom="SV_cod_tipo" Tipo="ge_clientes.COD_TIPO">cod_tipo</param>
                    <param nom="SV_tip_cliente" Tipo="ged_codigos.DES_VALOR">tip_cliente</param>
                    <param nom="SV_tef_cliente1" Tipo="ge_clientes.TEF_CLIENTE1">tef_cliente1</param>
                    <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
                    <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
                    <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

        LV_cod_modulo     ged_codigos.COD_MODULO%TYPE       := 'GE';
        LV_nom_tabla      ged_codigos.NOM_TABLA%TYPE        := 'GE_CLIENTES';
        LV_nom_columna    ged_codigos.NOM_COLUMNA%TYPE      := 'IND_ESTCIVIL';

        LV_des_error      ge_errores_pg.DesEvent;
        LV_sSql           ge_errores_pg.vQuery;

BEGIN

        SN_cod_error:=0;
        SV_mensaje_error:='';
        SN_num_evento:= 0;

        LV_sSql := ' SELECT SYSDATE AS fec_sistema, a.num_celular, a.cod_cliente, a.fec_alta,'
                         ||' a.fec_fincontra, b.nom_cliente, b.nom_apeclien1, b.nom_apeclien2,'
                         ||' b.num_ident, b.cod_tipident, c.des_tipident AS des_nit, b.num_ident2,'
                         ||' b.cod_tipident2, b.num_identapor, b.cod_tipidentapor, b.fec_nacimien,'
                         ||' b.cod_profesion, b.cod_ocupacion, b.nom_apoderado, b.ind_estcivil, f.des_valor AS estado_civil,'
                         ||' b.cod_pais, d.des_pais, a.cod_tecnologia, a.num_serie, a.num_imei,'
                         ||' a.cod_plantarif, e.des_plantarif, b.cod_tipo, g.des_valor AS tip_cliente, b.tef_cliente1'
                         ||' FROM ga_abocel a, ge_clientes b, ta_plantarif e, ged_codigos f, ged_codigos g,'
                         ||' ge_tipident c, ge_paises d'
                         ||' WHERE a.cod_cliente = b.cod_cliente'
                         ||' AND a.num_celular = EN_num_celular'
                         ||' AND a.cod_situacion NOT IN (''BAA'', ''BAP'')'
                         ||' AND a.cod_plantarif = e.cod_plantarif'
                         ||' AND f.cod_modulo(+) = ' ||LV_cod_modulo
                         ||' AND f.nom_tabla(+) = ' ||LV_nom_tabla
                         ||' AND f.nom_columna(+) = ' ||LV_nom_columna
                         ||' AND b.ind_estcivil = f.cod_valor(+)'
                         ||' AND b.cod_tipo = g.cod_valor(+)'
                         ||' AND g.cod_modulo(+) = ' ||LV_cod_modulo
                         ||' AND g.nom_tabla(+) = ' ||LV_nom_tabla
                         ||' AND g.nom_columna(+) = ' ||LV_nom_columna
                         ||' AND b.cod_tipident = c.cod_tipident'
                         ||' AND b.cod_pais = d.cod_pais(+)';


            SELECT SYSDATE AS fec_sistema, a.num_celular, a.cod_cliente, a.fec_alta,
                a.fec_fincontra, b.nom_cliente, b.nom_apeclien1, b.nom_apeclien2,
                b.num_ident, b.cod_tipident, c.des_tipident AS des_nit, b.num_ident2,
                b.cod_tipident2, b.num_identapor, b.cod_tipidentapor, b.fec_nacimien,
                b.cod_profesion, b.cod_ocupacion, b.nom_apoderado, b.ind_estcivil, f.des_valor AS estado_civil,
                b.cod_pais, d.des_pais, a.cod_tecnologia, a.num_serie, a.num_imei,
                a.cod_plantarif, e.des_plantarif, b.cod_tipo, g.des_valor AS tip_cliente, b.tef_cliente1
            INTO    SD_fec_sistema, SN_num_celular, SN_cod_cliente, SD_fec_alta,
                    SD_fec_fincontra, SV_nom_cliente, SV_nom_apeclien1, SV_nom_apeclien2,
                    SV_num_ident, SV_cod_tipident, SV_des_nit, SV_num_ident2,
                    SV_cod_tipident2, SV_num_identapor, SV_cod_tipidentapor, SD_fec_nacimien,
                    SN_cod_profesion, SV_cod_ocupacion, SV_nom_apoderado, SV_ind_estcivil, SV_estado_civil,
                    SV_cod_pais, SV_des_pais, SV_cod_tecnologia, SV_num_serie, SV_num_imei,
                    SV_cod_plantarif, SV_des_plantarif, SV_cod_tipo, SV_tip_cliente, SV_tef_cliente1
            FROM ga_abocel a, ge_clientes b, ta_plantarif e, ged_codigos f, ged_codigos g,
                 ge_tipident c, ge_paises d
            WHERE   a.cod_cliente = b.cod_cliente
                    AND a.num_celular = EN_num_celular
                    AND a.cod_plantarif = e.cod_plantarif
                    AND a.cod_situacion NOT IN ('BAA', 'BAP')
                    AND f.cod_modulo(+) = 'GE'
                    AND f.nom_tabla(+) = 'GE_CLIENTES'
                    AND f.nom_columna(+) = 'IND_ESTCIVIL'
                    AND b.ind_estcivil= f.cod_valor(+)
                    AND b.cod_tipo = g.cod_valor(+)
                    AND b.cod_tipident = c.cod_tipident
                    AND g.cod_modulo(+) = 'GE'
                    AND g.nom_tabla(+) = 'GE_CLIENTES'
                    AND g.nom_columna(+) = 'COD_TIPO'
                    AND b.cod_pais = d.cod_pais(+);




EXCEPTION

            WHEN OTHERS THEN
                 SN_cod_error       :=  301041;
                 IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error, SV_mensaje_error) THEN
                        SV_mensaje_error := CV_errornoclasificado;
                 END IF;
                 LV_des_error       :=  SUBSTR('OTHERS:NO_DATA_FOUND; - '|| SQLERRM,1,CN_largoerrtec);
                 SN_num_evento      :=  Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_modulo_ge,SV_mensaje_error, '1.0', USER,
                                        'NO_DATA_FOUND', LV_sSql, SN_cod_error, LV_des_error );


END;

PROCEDURE GE_CONS_CLIE_PRE_PR (     EN_num_celular      IN         ga_abocel.num_celular%TYPE,
                                    SD_fec_sistema      OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_num_celular      OUT NOCOPY ga_aboamist.NUM_CELULAR%TYPE,
                                    SN_cod_cliente      OUT NOCOPY ga_aboamist.COD_CLIENTE%TYPE,
                                    SV_nom_cliente      OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                                    SV_nom_apeclien1    OUT NOCOPY ge_clientes.NOM_APECLIEN1%TYPE,
                                    SV_nom_apeclien2    OUT NOCOPY ge_clientes.NOM_APECLIEN2%TYPE,
                                    SV_num_ident        OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                                    SV_cod_tipident     OUT NOCOPY ge_clientes.COD_TIPIDENT%TYPE,
                                    SV_des_nit          OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                                    SV_num_ident2       OUT NOCOPY ge_clientes.NUM_IDENT2%TYPE,
                                    SV_cod_tipident2    OUT NOCOPY ge_clientes.COD_TIPIDENT2%TYPE,
                                    SD_fec_nacimien     OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SV_cod_tecnologia   OUT NOCOPY ga_aboamist.COD_TECNOLOGIA%TYPE,
                                    SV_num_serie        OUT NOCOPY ga_aboamist.NUM_SERIE%TYPE,
                                    SV_num_imei         OUT NOCOPY ga_aboamist.NUM_IMEI%TYPE,
                                    SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

        /*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "GE_CONS_CLIE_PRE_PR"
            Lenguaje="PL/SQL"
            Fecha="23-06-2009"
            Versión="1.0.0"
            Diseñador="Leonardo Muñoz"
            Programador="Leonardo Muñoz"
            Ambiente="BD"
        <Retorno>
                  NA
        </Retorno>
        <Descripción>
                  Servicio que permite retornar los datos generales asociados a un cliente a partir
                  del número de teléfono de uno de sus abonados.
        </Descripción>
        <Parámetros>
             <Entrada>
                    <param  nom="EN_num_celular"  Tipo="NUMBER(15)"> Número de celular abonado </param>
             </Entrada>
             <Salida>
                    <param nom="SD_fec_sistema"  Tipo="ge_clientes.FEC_NACIMIEN">fec_sistema</param>
                    <param nom="SN_num_celular"  Tipo="ga_aboamist.NUM_CELULAR">num_celular</param>
                    <param nom="SN_cod_cliente"  Tipo="ga_aboamist.COD_CLIENTE">cod_cliente</param>
                    <param nom="SV_nom_cliente"  Tipo="ge_clientes.NOM_CLIENTE">nom_cliente</param>
                    <param nom="SV_nom_apeclien1"  Tipo="ge_clientes.NOM_APECLIEN1">nom_apeclien1</param>
                    <param nom="SV_nom_apeclien2"  Tipo="ge_clientes.NOM_APECLIEN2">nom_apeclien2</param>
                    <param nom="SV_num_ident"  Tipo="ge_clientes.NUM_IDENT">num_ident</param>
                    <param nom="SV_cod_tipident"  Tipo="ge_clientes.COD_TIPIDENT">cod_tipident</param>
                    <param nom="SV_des_nit"  Tipo="ge_tipident.DES_TIPIDENT">des_nit</param>
                    <param nom="SV_num_ident2"  Tipo="ge_clientes.NUM_IDENT2">num_ident2</param>
                    <param nom="SV_cod_tipident2"  Tipo="ge_clientes.COD_TIPIDENT2">cod_tipident2</param>
                    <param nom="SD_fec_nacimien"  Tipo="ge_clientes.FEC_NACIMIEN">fec_nacimien</param>
                    <param nom="SV_cod_tecnologia"  Tipo="ga_aboamist.COD_TECNOLOGIA">cod_tecnologia</param>
                    <param nom="SV_num_serie"  Tipo="ga_aboamist.NUM_SERIE">num_serie</param>
                    <param nom="SV_num_imei"  Tipo="ga_aboamist.NUM_IMEI">num_imei</param>
                    <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
                    <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
                    <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

        LV_des_error            ge_errores_pg.DesEvent;
        LV_sSql                 ge_errores_pg.vQuery;

BEGIN

        SN_cod_error:=0;
        SV_mensaje_error:='';
        SN_num_evento:= 0;

        LV_sSql := ' SELECT SYSDATE AS fec_sistema, a.num_celular, a.cod_cliente, b.nom_cliente, b.nom_apeclien1, b.nom_apeclien2,'
                 ||' b.num_ident, b.cod_tipident, c.des_tipident AS des_nit, b.num_ident2, b.cod_tipident2,'
                 ||' b.fec_nacimien, a.cod_tecnologia, a.num_serie, a.num_imei'
                 ||' FROM ga_aboamist a, ge_clientes b, ge_tipident c'
                 ||' WHERE a.cod_cliente = b.cod_cliente AND'
                 ||' a.num_celular =  ' || EN_num_celular || ' AND '
                 ||' a.cod_situacion NOT IN (''BAA'', ''BAP'') AND '
                 ||' b.cod_tipident = c.cod_tipident';


            SELECT SYSDATE AS fec_sistema, a.num_celular, a.cod_cliente, b.nom_cliente, b.nom_apeclien1, b.nom_apeclien2,
               b.num_ident, b.cod_tipident, c.des_tipident AS des_nit, b.num_ident2, b.cod_tipident2,
               b.fec_nacimien, a.cod_tecnologia, a.num_serie, a.num_imei
            INTO    SD_fec_sistema, SN_num_celular, SN_cod_cliente, SV_nom_cliente,
                    SV_nom_apeclien1, SV_nom_apeclien2, SV_num_ident, SV_cod_tipident,
                    SV_des_nit, SV_num_ident2, SV_cod_tipident2, SD_fec_nacimien,
                    SV_cod_tecnologia, SV_num_serie, SV_num_imei
            FROM ga_aboamist a, ge_clientes b, ge_tipident c
            WHERE a.cod_cliente = b.cod_cliente AND
                  a.num_celular = EN_num_celular AND
                  a.cod_situacion NOT IN ('BAA', 'BAP') AND
                  b.cod_tipident = c.cod_tipident;

EXCEPTION



            WHEN OTHERS THEN
                 SN_cod_error       := 301042;
                 IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error, SV_mensaje_error) THEN
                        SV_mensaje_error := CV_errornoclasificado;
                 END IF;
                 LV_des_error       := SUBSTR('OTHERS:NO_DATA_FOUND; - '|| SQLERRM,1,CN_largoerrtec);
                 SN_num_evento      := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_modulo_ge,SV_mensaje_error, '1.0', USER,
                                       'NO_DATA_FOUND', LV_sSql, SN_cod_error, LV_des_error );

END;

PROCEDURE GE_CONS_CLIE_COD_PR (     EN_cod_cliente      IN         ge_clientes.COD_CLIENTE%TYPE,
                                    SD_fec_sistema      OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_cod_cliente      OUT NOCOPY ge_clientes.COD_CLIENTE%TYPE,
                                    SV_nom_cliente      OUT NOCOPY ge_clientes.NOM_CLIENTE%TYPE,
                                    SV_nom_apeclien1    OUT NOCOPY ge_clientes.NOM_APECLIEN1%TYPE,
                                    SV_nom_apeclien2    OUT NOCOPY ge_clientes.NOM_APECLIEN2%TYPE,
                                    SV_num_ident        OUT NOCOPY ge_clientes.NUM_IDENT%TYPE,
                                    SV_cod_tipident     OUT NOCOPY ge_clientes.COD_TIPIDENT%TYPE,
                                    SV_des_nit          OUT NOCOPY ge_tipident.DES_TIPIDENT%TYPE,
                                    SV_num_ident2       OUT NOCOPY ge_clientes.NUM_IDENT2%TYPE,
                                    SV_cod_tipident2    OUT NOCOPY ge_clientes.COD_TIPIDENT2%TYPE,
                                    SV_num_identapor    OUT NOCOPY ge_clientes.NUM_IDENTAPOR%TYPE,
                                    SV_cod_tipidentapor OUT NOCOPY ge_clientes.COD_TIPIDENTAPOR%TYPE,
                                    SD_fec_nacimien     OUT NOCOPY ge_clientes.FEC_NACIMIEN%TYPE,
                                    SN_cod_profesion    OUT NOCOPY ge_clientes.COD_PROFESION%TYPE,
                                    SV_cod_ocupacion    OUT NOCOPY ge_clientes.COD_OCUPACION%TYPE,
                                    SV_nom_apoderado    OUT NOCOPY ge_clientes.NOM_APODERADO%TYPE,
                                    SV_ind_estcivil     OUT NOCOPY ge_clientes.IND_ESTCIVIL%TYPE,
                                    SV_estado_civil     OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_cod_pais         OUT NOCOPY ge_clientes.COD_PAIS%TYPE,
                                    SV_des_pais         OUT NOCOPY ge_paises.DES_PAIS%TYPE,
                                    SV_cod_tipo         OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                                    SV_tip_cliente      OUT NOCOPY ged_codigos.DES_VALOR%TYPE,
                                    SV_tef_cliente1     OUT NOCOPY ge_clientes.TEF_CLIENTE1%TYPE,
                                    SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

/*
        <Documentación TipoDoc = "Procedimiento">
            Elemento Nombre = "GE_CONS_CLIE_COD_PR"
            Lenguaje="PL/SQL"
            Fecha="24-06-2009"
            Versión="1.0.0"
            Diseñador="Leonardo Muñoz"
            Programador="Leonardo Muñoz"
            Ambiente="BD"
        <Retorno>
                  NA
        </Retorno>
        <Descripción>
                  Servicio que permite retornar los datos generales asociados a un cliente a partir
                  del código de cliente de uno de sus abonados.
        </Descripción>
        <Parámetros>
             <Entrada>
                    <param  nom="EN_cod_cliente"  Tipo="NUMBER(8)"> Código de cliente </param>
             </Entrada>
             <Salida>
                    <param nom="SD_fec_sistema"  Tipo="ge_clientes.FEC_NACIMIEN">fec_sistema</param>
                    <param nom="SN_cod_cliente"  Tipo="ge_clientes.COD_CLIENTE">cod_cliente</param>
                    <param nom="SV_nom_cliente"  Tipo="ge_clientes.NOM_CLIENTE">nom_cliente</param>
                    <param nom="SV_nom_apeclien1"  Tipo="ge_clientes.NOM_APECLIEN1">nom_apeclien1</param>
                    <param nom="SV_nom_apeclien2"  Tipo="ge_clientes.NOM_APECLIEN2">nom_apeclien2</param>
                    <param nom="SV_num_ident"  Tipo="ge_clientes.NUM_IDENT">num_ident</param>
                    <param nom="SV_cod_tipident"  Tipo="ge_clientes.COD_TIPIDENT">cod_tipident</param>
                    <param nom="SV_des_nit"  Tipo="ge_tipident.DES_TIPIDENT">des_nit</param>
                    <param nom="SV_num_ident2"  Tipo="ge_clientes.NUM_IDENT2">num_ident2</param>
                    <param nom="SV_cod_tipident2"  Tipo="ge_clientes.COD_TIPIDENT2">cod_tipident2</param>
                    <param nom="SV_num_identapor"  Tipo="ge_clientes.NUM_IDENTAPOR">num_identapor</param>
                    <param nom="SV_cod_tipidentapor"  Tipo="ge_clientes.COD_TIPIDENTAPOR">tipidentapor</param>
                    <param nom="SD_fec_nacimien"  Tipo="ge_clientes.FEC_NACIMIEN">fec_nacimien</param>
                    <param nom="SN_cod_profesion"  Tipo="ge_clientes.COD_PROFESION">cod_profesion</param>
                    <param nom="SV_nom_apoderado"  Tipo="ge_clientes.NOM_APODERADO">nom_apoderado</param>
                    <param nom="SV_ind_estcivil"  Tipo="ge_clientes.IND_ESTCIVIL">ind_estcivil</param>
                    <param nom="SV_estado_civil"  Tipo="ged_codigos.DES_VALOR">estado_civil</param>
                    <param nom="SV_cod_pais"  Tipo="ge_clientes.COD_PAIS">cod_pais</param>
                    <param nom="SV_des_pais"  Tipo="ge_paises.DES_PAIS">des_pais</param>
                    <param nom="SV_cod_tipo"  Tipo="ge_clientes.COD_TIPO">cod_tipo</param>
                    <param nom="SV_tip_cliente"  Tipo="ged_codigos.DES_VALOR">tip_cliente</param>
                    <param nom="SV_tef_cliente1"  Tipo="ge_clientes.TEF_CLIENTE1">tef_cliente1</param>
                    <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
                    <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
                    <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
             </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

        LV_des_error          ge_errores_pg.DesEvent;
        LV_sSql               ge_errores_pg.vQuery;

        LV_cod_modulo         ged_codigos.COD_MODULO%TYPE     := 'GE';
        LV_nom_tabla          ged_codigos.NOM_TABLA%TYPE      := 'GE_CLIENTES';

BEGIN

        SN_cod_error:=0;
        SV_mensaje_error:='';
        SN_num_evento:= 0;

        LV_sSql := ' SELECT SYSDATE AS fec_sistema, b.cod_cliente, b.nom_cliente, b.nom_apeclien1, b.nom_apeclien2,'
                 ||' b.num_ident, b.cod_tipident, c.des_tipident AS des_nit, b.num_ident2, b.cod_tipident2,'
                 ||' b.num_identapor, b.cod_tipidentapor, b.fec_nacimien, b.cod_profesion, b.cod_ocupacion,'
                 ||' b.nom_apoderado, b.ind_estcivil, f.des_valor AS estado_civil, b.cod_pais, d.des_pais,'
                 ||' b.cod_tipo, g.des_valor AS tip_cliente, b.tef_cliente1'
                 ||' FROM ge_clientes b, ged_codigos f, ged_codigos g, ge_tipident c, ge_paises d'
                 ||' WHERE b.ind_estcivil = f.cod_valor(+)'
                 ||' AND f.cod_modulo(+) = ' || LV_cod_modulo
                 ||' AND f.nom_tabla(+) = ' || LV_nom_tabla
                 ||' AND f.nom_columna(+) = ''IND_ESTCIVIL'''
                 ||' AND b.cod_tipo = g.cod_valor(+)'
                 ||' AND b.cod_cliente = ' || EN_cod_cliente
                 ||' AND g.cod_modulo(+) = ' || LV_cod_modulo
                 ||' AND g.nom_tabla(+) = ' || LV_nom_tabla
                 ||' AND g.nom_columna(+) = ''COD_TIPO'''
                 ||' AND b.cod_tipident = c.cod_tipident'
                 ||' AND b.cod_pais = d.cod_pais(+)';


        SELECT SYSDATE AS fec_sistema, b.cod_cliente, b.nom_cliente, b.nom_apeclien1, b.nom_apeclien2,
           b.num_ident, b.cod_tipident, c.des_tipident AS des_nit, b.num_ident2, b.cod_tipident2,
           b.num_identapor, b.cod_tipidentapor, b.fec_nacimien, b.cod_profesion, b.cod_ocupacion,
           b.nom_apoderado, b.ind_estcivil, f.des_valor AS estado_civil, b.cod_pais, d.des_pais,
           b.cod_tipo, g.des_valor AS tip_cliente, b.tef_cliente1
        INTO SD_fec_sistema, SN_cod_cliente, SV_nom_cliente, SV_nom_apeclien1, SV_nom_apeclien2,
             SV_num_ident, SV_cod_tipident, SV_des_nit, SV_num_ident2, SV_cod_tipident2,
             SV_num_identapor, SV_cod_tipidentapor, SD_fec_nacimien, SN_cod_profesion, SV_cod_ocupacion,
             SV_nom_apoderado, SV_ind_estcivil, SV_estado_civil, SV_cod_pais, SV_des_pais,
             SV_cod_tipo, SV_tip_cliente, SV_tef_cliente1
        FROM ge_clientes b, ged_codigos f, ged_codigos g, ge_tipident c, ge_paises d
        WHERE b.ind_estcivil = f.cod_valor(+) AND
           f.cod_modulo(+) = LV_cod_modulo AND
           f.nom_tabla(+) = LV_nom_tabla AND
           f.nom_columna(+) = 'IND_ESTCIVIL' AND
           b.cod_tipo = g.cod_valor(+) AND
           b.cod_cliente = EN_cod_cliente AND
           g.cod_modulo(+) = LV_cod_modulo AND
           g.nom_tabla(+) = LV_nom_tabla AND
           g.nom_columna(+) = 'COD_TIPO' AND
           b.cod_tipident = c.cod_tipident AND
           b.cod_pais = d.cod_pais(+);


EXCEPTION

            WHEN OTHERS THEN
                 SN_cod_error       := 301043;
                 IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_error, SV_mensaje_error) THEN
                        SV_mensaje_error := CV_errornoclasificado;
                 END IF;
                 LV_des_error       := SUBSTR('OTHERS:NO_DATA_FOUND; - '|| SQLERRM,1,CN_largoerrtec);
                 SN_num_evento      := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_modulo_ge,SV_mensaje_error, '1.0', USER,
                                       'NO_DATA_FOUND', LV_sSql, SN_cod_error, LV_des_error );

END;

PROCEDURE GE_CONS_EQUIPO_PR (EV_num_serie        IN         ga_equipaboser.NUM_SERIE%TYPE,
                             EV_num_abonado      IN         ga_equipaboser.NUM_ABONADO%TYPE,
                             SV_des_equipo       OUT NOCOPY ga_equipaboser.DES_EQUIPO%TYPE,
                             SV_cod_articulo     OUT NOCOPY ga_equipaboser.COD_ARTICULO%TYPE,
                             SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

/*
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_EQUIPO_PR"
        Lenguaje="PL/SQL"
        Fecha="24-06-2009"
        Versión="1.0.0"
        Diseñador="Leonardo Muñoz R."
        Programador="Leonardo Muñoz R."
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Retorna la descripción del modelo de equipo asociado al teléfono consultado.
    </Descripción>
    <Parámetros>
        <Entrada>
             <param  nom="EV_num_serie"  Tipo="VARCHAR(2) "> Numero de serie </param>
        </Entrada>
        <Salida>
             <param  nom="SV_des_equipo Tipo="VARCHAR(40)> Descripción modelo equipo </param>
             <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
             <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
             <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error           ge_errores_pg.DesEvent;
     LV_sSql                ge_errores_pg.vQuery;

BEGIN

    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    SN_num_evento:=0;

    LV_sSql := ' SELECT DISTINCT a.des_equipo, a.cod_articulo '
             ||' FROM ga_equipaboser a'
             ||' WHERE a.num_serie = ''' || EV_num_serie || ''''
             ||' AND a.num_abonado = ' || EV_num_abonado;

    SELECT DISTINCT a.des_equipo, a.cod_articulo INTO SV_des_equipo, SV_cod_articulo
    FROM ga_equipaboser a
    WHERE a.num_serie = EV_num_serie AND
          a.num_abonado = EV_num_abonado;

EXCEPTION

            WHEN OTHERS THEN
                SN_cod_retorno     := 301066;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
                        SV_mens_retorno := CV_errornoclasificado;
                 END IF;
                LV_des_error     := 'ge_cons_equipo_pr ('||'); - ' || SQLERRM;
                SN_num_evento    := Ge_Errores_Pg.grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, cv_version, USER, 'ge_integracion_pg.ge_cons_equipo_pr', LV_sSql, SN_cod_retorno, SV_mens_retorno );
END;

PROCEDURE GE_CONS_PROFESION_PR (EN_cod_prof        IN         ge_actividades.COD_ACTIVIDAD%TYPE,
                                SV_des_actividad   OUT NOCOPY ge_actividades.DES_ACTIVIDAD%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_PROFESION_PR"
        Lenguaje="PL/SQL"
        Fecha="24-06-2009"
        Versión="1.0.0"
        Diseñador="Leonardo Muñoz R."
        Programador="Leonardo Muñoz R."
        Ambiente="BD"
    <Retorno> varchar </Retorno>
    <Descripción>
        Retorna la descripción de la profesón de un cliente.
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EN_cod_prof"  Tipo="NUMBER(3) "> Numero de serie </param>
    </Entrada>
    <Salida>
        <param nom="SV_des_actividad" Tipo="VARCHAR(2)> Descripción actividad </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error           ge_errores_pg.DesEvent;
     LV_sSql                ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    SN_num_evento:=0;
    LV_sSql := ' SELECT a.des_actividad INTO SV_des_actividad'
             ||' FROM ge_actividades a'
             ||' WHERE a.cod_actividad = ' ||EN_cod_prof;

    SELECT a.des_actividad INTO SV_des_actividad
    FROM ge_actividades a
    WHERE a.cod_actividad = EN_cod_prof;

EXCEPTION

            WHEN OTHERS THEN
                SN_cod_retorno     := 301045;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
                       SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_cons_profesion_pr ('||'); - ' || SQLERRM;
                SN_num_evento    := Ge_Errores_Pg.grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, cv_version, USER, 'ge_integracion_pg.ge_cons_profesion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END;

PROCEDURE GE_CONS_OCUPACION_PR (EV_cod_ocup         IN         ge_ocupaciones.COD_OCUPACION%TYPE,
                                SV_des_ocupacion    OUT NOCOPY ge_ocupaciones.DES_OCUPACION%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_OCUPACION_PR"
        Lenguaje="PL/SQL"
        Fecha="04-01-2010"
        Versión="1.0.0"
        Diseñador="Juan Daniel Muñoz Queupul."
        Programador="Juan Daniel Muñoz Queupul."
        Ambiente="BD"
    <Retorno> varchar </Retorno>
    <Descripción>
        Retorna la descripción de la profesón de un cliente.
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_ocup"  Tipo="NUMBER(3) "> codigo de ocupacion </param>
    </Entrada>
    <Salida>
        <param nom="SV_des_ocupacion" Tipo="VARCHAR(2)> Descripción ocupacion </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error           ge_errores_pg.DesEvent;
     LV_sSql                ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    SN_num_evento:=0;
    LV_sSql := ' SELECT a.des_ocupacion INTO SV_des_ocupacion'
             ||' FROM ge_ocupaciones a'
             ||'  WHERE a.cod_ocupacion = ' || EV_cod_ocup;


    SELECT a.des_ocupacion INTO SV_des_ocupacion
    FROM ge_ocupaciones a
    WHERE a.cod_ocupacion = EV_cod_ocup;



EXCEPTION

            WHEN OTHERS THEN
                SN_cod_retorno     := 301045;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
                       SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'GE_CONS_OCUPACION_PR ('||'); - ' || SQLERRM;
                SN_num_evento    := Ge_Errores_Pg.grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, cv_version, USER, 'ge_integracion_pg.GE_CONS_OCUPACION_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END;



PROCEDURE GE_CONS_TIPOS_IDENT_PR ( EV_cod_tipident    IN         ge_tipident.COD_TIPIDENT%TYPE,
                                   SV_des_tipident    OUT NOCOPY ge_tipident.des_tipident%TYPE,
                                   SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_TIPOS_IDENT_PR"
        Lenguaje="PL/SQL"
        Fecha="24-06-2009"
        Versión="1.0.0"
        Diseñador="Leonardo Muñoz R."
        Programador="Leonardo Muñoz R."
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Retorna la descripción para los tipos de identificacion del apoderado.
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_tipident"  Tipo="VARCHAR(2) "> Código identificación </param>
    </Entrada>
    <Salida>
        <param  nom="SV_des_tipident" Tipo="VARCHAR(2)> Descripción tipo identificación </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error           ge_errores_pg.DesEvent;
     LV_sSql                ge_errores_pg.vQuery;
     SV_valor_parametro     varchar2(20);

BEGIN

    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    SN_num_evento:=0;
    LV_sSql := ' SELECT a.des_tipident INTO SV_des_tipident'
             ||' FROM ge_tipident a'
             ||' WHERE a.cod_tipident = ' ||EV_cod_tipident;

    SELECT a.des_tipident INTO SV_des_tipident
    FROM ge_tipident a
    WHERE a.cod_tipident = EV_cod_tipident;

EXCEPTION

            WHEN OTHERS THEN
                SN_cod_retorno     := 301044;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
                       SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_cons_tipos_ident_pr ('||'); - ' || SQLERRM;
                SN_num_evento    := Ge_Errores_Pg.grabarpl( SN_num_evento, CV_modulo_ge,  SV_mens_retorno , cv_version, USER, 'ge_integracion_pg.ge_cons_tipos_ident_pr', LV_sSql, SN_cod_retorno, LV_des_error );
END;

PROCEDURE GE_CONS_TIPO_CLIENTE_PR ( EN_cod_cliente     IN         ge_clientes.COD_CLIENTE%TYPE,
                                    SN_cod_cliente     OUT NOCOPY ge_clientes.COD_CLIENTE%TYPE,
                                    SV_cod_tipo        OUT NOCOPY ge_clientes.COD_TIPO%TYPE,
                                    SV_tip_cliente     OUT NOCOPY ged_codigos.des_valor%TYPE,
                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_TIPO_CLIENTE_PR"
        Lenguaje="PL/SQL"
        Fecha="10-07-2009"
        Versión="1.0.0"
        Diseñador="Leonardo Muñoz R."
        Programador="Leonardo Muñoz R."
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Servicio que permite identificar si una persona es de tipo natural o empresa
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EN_cod_cliente"  Tipo="NUMBER(8) "> Código de cliente </param>
    </Entrada>
    <Salida>
        <param  nom="SV_tip_cliente" Tipo="VARCHAR(2)> Tipo de cliente </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_cod_modulo         ged_codigos.COD_MODULO%TYPE     := 'GE';
    LV_nom_tabla          ged_codigos.NOM_TABLA%TYPE      := 'GE_CLIENTES';
    LV_nom_columna        ged_codigos.NOM_COLUMNA%TYPE    := 'COD_TIPO';
    LV_des_error          ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;

BEGIN

    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    SN_num_evento:=0;

    LV_sSql := ' SELECT a.cod_cliente, a.cod_tipo, b.des_valor AS tip_cliente'
             ||' FROM ge_clientes a, ged_codigos b'
             ||' WHERE a.cod_tipo = b.cod_valor'
             ||' AND a.cod_cliente = ' || EN_cod_cliente
             ||' AND b.cod_modulo = ''' || LV_cod_modulo || ''''
             ||' AND b.nom_tabla = ''' || LV_nom_tabla || ''''
             ||' AND b.nom_columna = ''' || LV_nom_columna || '''';

    SELECT a.cod_cliente, a.cod_tipo, b.des_valor AS tip_cliente
    INTO SN_cod_cliente, SV_cod_tipo, SV_tip_cliente
    FROM ge_clientes a, ged_codigos b
    WHERE a.cod_tipo = b.cod_valor AND
          a.cod_cliente = EN_cod_cliente AND
          b.cod_modulo = 'GE' AND
          b.nom_tabla = 'GE_CLIENTES' AND
          b.nom_columna = 'COD_TIPO';

EXCEPTION

            WHEN OTHERS THEN
                SN_cod_retorno     := 301046;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
                       SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_cons_tipo_cliente_pr ('||'); - ' || SQLERRM;
                SN_num_evento    := Ge_Errores_Pg.grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, cv_version, USER, 'ge_integracion_pg.ge_cons_tipo_cliente_pr', LV_sSql, SN_cod_retorno, LV_des_error );
END;

PROCEDURE GE_CONSTIPSERV_PR (   EV_cod_prestacion   IN         ga_abocel.COD_PRESTACION%TYPE,
                                SV_des_prestacion   OUT NOCOPY ge_prestaciones_td.DES_PRESTACION%TYPE,
                                SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

    /*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONSTIPSERV_PR"
        Lenguaje="PL/SQL"
        Fecha="28-07-2009"
        Versión="1.0.0"
        Diseñador="Leonardo Muñoz R."
        Programador="Leonardo Muñoz R."
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Servicio que permite consultar el código y descripción de la prestación asociada a un número de teléfono
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_prestacion"  Tipo="VARCHAR(2)"> Código de prestación </param>
    </Entrada>
    <Salida>
        <param  nom="SV_des_prestacion" Tipo="VARCHAR(2)> Descripción de prestación </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;
    LV_sSql               ge_errores_pg.vQuery;

BEGIN
    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    SN_num_evento:=0;

    LV_sSql := ' SELECT a.des_prestacion INTO SV_des_prestacion'
             ||' FROM ge_prestaciones_td a'
             ||' WHERE a.cod_tipo = ' ||EV_cod_prestacion;

    SELECT a.des_prestacion
    INTO SV_des_prestacion
    FROM ge_prestaciones_td a
    WHERE cod_prestacion = EV_cod_prestacion;

EXCEPTION

        WHEN OTHERS THEN
                SN_cod_retorno     := 301047;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
                       SV_mens_retorno := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_constipserv_pr ('||'); - ' || SQLERRM;
                SN_num_evento    := Ge_Errores_Pg.grabarpl( SN_num_evento, CV_modulo_ge, SV_mens_retorno, cv_version, USER, 'ge_integracion_pg.ge_constipserv_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END;

  PROCEDURE GE_CONS_PAGOS_REALIZADO_PR (
       EN_cod_cliente           IN              NUMBER,
       SC_pagosRealizados       OUT NOCOPY	  	refcursor,
       SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		  ge_errores_pg.evento)
	IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "GE_CONS_PAGOS_REALIZADO_PR"
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2009"
	      Versión="1.0"
	      Diseñador="Joan Zamorano"
	      Programador="Juan Daniel Muñoz Queupul"
	      Ambiente Desarrollo="BD">
	      <Retorno>fechas</Retorno>>
	      <Descripción>Detalle </Descripción>>
	      <Parámetros>
	         <Entrada>
	             <param nom="EN_cod_cliente" Tipo="NUMERICO">codigo del cliente</param>>
	         </Entrada>
	         <Salida>
              <param nom="SC_pagosRealizados"  Tipo="CURSOR">Listado de Detalle Pagos Realizado</param>>
	            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>>
           </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

    num_secuenci       NUMBER;
    cod_tipdocum       NUMBER;
    cod_cliente        NUMBER;
    imp_pago           NUMBER;
    cod_oripago        NUMBER;
    cod_caja           VARCHAR2(4);
    fec_efectividad    DATE;
    importe_tot_doc    NUMBER;
    num_folio          NUMBER;
    cod_tipdocrel      NUMBER;
    pref_plaza         VARCHAR2(25);
    num_compago        NUMBER;
    cod_banco          VARCHAR2(15);
    tot_factura        NUMBER;
    tot_pagar          NUMBER;
    fecha_hora         VARCHAR2(30);

	  LV_des_error	   ge_errores_pg.DesEvent;
  	LV_sSql			     ge_errores_pg.vQuery;
    LO_NO_DATA  EXCEPTION;
    LN_cantidad NUMBER;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;



     LV_sSql :=' SELECT DISTINCT COUNT(*) INTO LN_cantidad ';
     LV_sSql :=LV_sSql || ' FROM fa_histdocu a';
     LV_sSql :=LV_sSql || ' (SELECT a.num_secuenci, a.cod_tipdocum, a.cod_cliente, a.imp_pago, a.cod_oripago, ';
     LV_sSql :=LV_sSql || ' a.cod_caja, a.fec_efectividad, SUM(b.imp_concepto) as importe_tot_doc, b.num_folio, ';
     LV_sSql :=LV_sSql || ' b.cod_tipdocrel, b.num_securel, b.cod_agenterel, b.letra_rel, b.cod_centrrel, ';
     LV_sSql :=LV_sSql || ' a.pref_plaza, a.num_compago, a.cod_banco ';
     LV_sSql :=LV_sSql || ' FROM co_pagos a, co_pagosconc b ';
     LV_sSql :=LV_sSql || ' WHERE a.num_secuenci = b.num_secuenci AND ';
     LV_sSql :=LV_sSql || ' a.cod_tipdocum = b.cod_tipdocum AND ';
     LV_sSql :=LV_sSql || ' a.cod_vendedor_agente = b.cod_vendedor_agente AND ';
     LV_sSql :=LV_sSql || ' a.letra = b.letra AND ';
     LV_sSql :=LV_sSql || ' a.cod_centremi = b.cod_centremi AND ';
     LV_sSql :=LV_sSql || ' a.cod_tipdocum IN (8,9,25,83,88) AND ';
     LV_sSql :=LV_sSql || ' a.cod_cliente =' || EN_cod_cliente ;
     LV_sSql :=LV_sSql || ' a.ind_regulariza IS NULL AND ';
     LV_sSql :=LV_sSql || ' GROUP BY a.num_secuenci, a.cod_tipdocum, a.cod_cliente, a.imp_pago, a.cod_oripago, a.cod_caja, a.fec_efectividad, b.num_folio,  ';
     LV_sSql :=LV_sSql || ' b.cod_tipdocrel, b.num_securel, b.cod_agenterel, b.letra_rel, b.cod_centrrel, a.pref_plaza, a.num_compago, a.cod_banco) b ';
     LV_sSql :=LV_sSql || ' WHERE a.cod_cliente(+)  = b.cod_cliente AND ';
     LV_sSql :=LV_sSql || ' a.num_secuenci(+) = b.num_securel  AND ';
     LV_sSql :=LV_sSql || ' a.cod_tipdocum(+) = b.cod_tipdocrel AND ';
     LV_sSql :=LV_sSql || ' a.cod_vendedor_agente(+) = b.cod_agenterel AND ';
     LV_sSql :=LV_sSql || ' a.letra(+) = b.letra_rel AND ';
     LV_sSql :=LV_sSql || ' a.cod_centremi(+) = b.cod_centrrel ';
     LV_sSql :=LV_sSql || ' ORDER BY b.fec_efectividad DESC, b.num_folio DESC';



		SELECT DISTINCT COUNT(*) INTO LN_cantidad
		FROM fa_histdocu a,
		    (SELECT a.num_secuenci, a.cod_tipdocum, a.cod_cliente, a.imp_pago, a.cod_oripago,
		           a.cod_caja, a.fec_efectividad, SUM(b.imp_concepto) as importe_tot_doc, b.num_folio,
		           b.cod_tipdocrel, b.num_securel, b.cod_agenterel, b.letra_rel, b.cod_centrrel,
		           a.pref_plaza, a.num_compago, a.cod_banco
		    FROM co_pagos a, co_pagosconc b
		    WHERE a.num_secuenci = b.num_secuenci AND
		          a.cod_tipdocum = b.cod_tipdocum AND
		          a.cod_vendedor_agente = b.cod_vendedor_agente AND
		          a.letra = b.letra AND
		          a.cod_centremi = b.cod_centremi AND
		          a.cod_tipdocum IN (8,9,25,83,88) AND
		          a.cod_cliente = EN_cod_cliente AND
              a.ind_regulariza IS NULL AND
		          b.cod_tipdocrel NOT IN (8)
		    GROUP BY a.num_secuenci, a.cod_tipdocum, a.cod_cliente, a.imp_pago, a.cod_oripago, a.cod_caja, a.fec_efectividad, b.num_folio,
		         b.cod_tipdocrel, b.num_securel, b.cod_agenterel, b.letra_rel, b.cod_centrrel, a.pref_plaza, a.num_compago, a.cod_banco) b
		WHERE a.cod_cliente(+)  = b.cod_cliente AND
		      a.num_secuenci(+) = b.num_securel  AND
		      a.cod_tipdocum(+) = b.cod_tipdocrel AND
		      a.cod_vendedor_agente(+) = b.cod_agenterel AND
		      a.letra(+) = b.letra_rel AND
		      a.cod_centremi(+) = b.cod_centrrel
		ORDER BY b.fec_efectividad DESC, b.num_folio DESC;

    IF LN_cantidad = 0 THEN
            RAISE LO_NO_DATA; --se genera exception
    END IF;



    OPEN SC_pagosRealizados FOR
		SELECT DISTINCT b.num_secuenci, b.cod_tipdocum, b.cod_cliente, b.imp_pago, b.cod_oripago,
		               b.cod_caja, b.fec_efectividad, b.importe_tot_doc, b.num_folio,
		               b.cod_tipdocrel, b.pref_plaza, b.num_compago, b.cod_banco, a.tot_factura, a.tot_pagar, sysdate as fecha_Hora

              INTO num_secuenci, cod_tipdocum, cod_cliente, imp_pago, cod_oripago,
		               cod_caja, fec_efectividad, importe_tot_doc, num_folio,
		               cod_tipdocrel, pref_plaza, num_compago, cod_banco, tot_factura, tot_pagar, fecha_hora

		FROM fa_histdocu a,
		    (SELECT a.num_secuenci, a.cod_tipdocum, a.cod_cliente, a.imp_pago, a.cod_oripago,
		           a.cod_caja, a.fec_efectividad, SUM(b.imp_concepto) as importe_tot_doc, b.num_folio,
		           b.cod_tipdocrel, b.num_securel, b.cod_agenterel, b.letra_rel, b.cod_centrrel,
		           a.pref_plaza, a.num_compago, a.cod_banco
		    FROM co_pagos a, co_pagosconc b
		    WHERE a.num_secuenci = b.num_secuenci AND
		          a.cod_tipdocum = b.cod_tipdocum AND
		          a.cod_vendedor_agente = b.cod_vendedor_agente AND
		          a.letra = b.letra AND
		          a.cod_centremi = b.cod_centremi AND
		          a.cod_tipdocum IN (8,9,25,83,88) AND
		          a.cod_cliente = EN_cod_cliente AND
              a.ind_regulariza IS NULL AND
		          b.cod_tipdocrel NOT IN (8)
		    GROUP BY a.num_secuenci, a.cod_tipdocum, a.cod_cliente, a.imp_pago, a.cod_oripago, a.cod_caja, a.fec_efectividad, b.num_folio,
		         b.cod_tipdocrel, b.num_securel, b.cod_agenterel, b.letra_rel, b.cod_centrrel, a.pref_plaza, a.num_compago, a.cod_banco) b
		WHERE a.cod_cliente(+)  = b.cod_cliente AND
		      a.num_secuenci(+) = b.num_securel  AND
		      a.cod_tipdocum(+) = b.cod_tipdocrel AND
		      a.cod_vendedor_agente(+) = b.cod_agenterel AND
		      a.letra(+) = b.letra_rel AND
		      a.cod_centremi(+) = b.cod_centrrel
		ORDER BY b.fec_efectividad DESC, b.num_folio DESC;




	EXCEPTION
  	  WHEN LO_NO_DATA THEN
	          SN_cod_retorno := 301055;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_PAGOS_REALIZADO_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_MODULO_GE,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_PAGOS_REALIZADO_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

     	WHEN OTHERS THEN
            SN_cod_retorno := 301055;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_PAGOS_REALIZADO_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_MODULO_GE,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_PAGOS_REALIZADO_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_PAGOS_REALIZADO_PR;

  PROCEDURE GE_CONS_RECAUDADORA_PAGO_PR (
       EV_pref_plaza            IN             VARCHAR2,
       EN_cod_cliente           IN             NUMBER,
       EN_num_compago           IN             NUMBER,
       SV_recaudadora           OUT NOCOPY     VARCHAR2,
       SV_des_empresa           OUT NOCOPY     VARCHAR2,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento)
	IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "GE_CONS_RECAUDADORA_PAGO_PR"
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2009"
	      Versión="1.0"
	      Diseñador="Joan Zamorano"
	      Programador="Juan Daniel Muñoz Queupul"
	      Ambiente Desarrollo="BD">
	      <Retorno>fechas</Retorno>>
	      <Descripción>Detalle </Descripción>>
	      <Parámetros>
	         <Entrada>
	             <param nom="EV_pref_plaza" Tipo="CARACTER">Pref de Plaza</param>>
	             <param nom="EN_cod_cliente" Tipo="NUMERICO">codigo del cliente</param>>
	             <param nom="EN_num_compago" Tipo="NUMERICO">numero de comprobante de pago</param>>
	         </Entrada>
	         <Salida>
              <param nom="SV_recaudadora"      Tipo="CARACTER">empresa recaudadora</param>>
              <param nom="SV_des_empresa"      Tipo="CARACTER">descripcion de la empresa</param>>
	            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>>

	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	  LV_des_error	   ge_errores_pg.DesEvent;
  	LV_sSql			     ge_errores_pg.vQuery;
    LO_NO_DATA  EXCEPTION;
    LN_cantidad NUMBER;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

     LV_sSql :=' SELECT a.emp_recaudadora, b.des_empresa  ';
     LV_sSql :=LV_sSql || ' FROM co_interfaz_pagos a, ced_empresas b';
     LV_sSql :=LV_sSql || ' WHERE a.emp_recaudadora = b.cod_empresa ';
     LV_sSql :=LV_sSql || ' AND a.pref_plaza =  ' || EV_pref_plaza;
     LV_sSql :=LV_sSql || ' AND a.num_compago = ' || EN_num_compago;
     LV_sSql :=LV_sSql || ' AND a.cod_estado = ''PRO''';
     LV_sSql :=LV_sSql || ' AND a.cod_cliente = ' || EN_cod_cliente;
     LV_sSql :=LV_sSql || ' UNION ';
     LV_sSql :=LV_sSql || ' SELECT a.emp_recaudadora, b.des_empresa ';
     LV_sSql :=LV_sSql || ' FROM co_hinterfaz_pagos a, ced_empresas b ';
     LV_sSql :=LV_sSql || ' WHERE a.emp_recaudadora = b.cod_empresa ';
     LV_sSql :=LV_sSql || ' AND a.pref_plaza = ' || EV_pref_plaza;
     LV_sSql :=LV_sSql || ' AND a.num_compago = ' || EN_num_compago;
     LV_sSql :=LV_sSql || ' AND a.cod_estado = ''PRO''';
     LV_sSql :=LV_sSql || ' AND a.cod_cliente =' || EN_cod_cliente ;


  	SELECT a.emp_recaudadora, b.des_empresa
    INTO SV_recaudadora, SV_des_empresa
		FROM co_interfaz_pagos a, ced_empresas b
		WHERE a.emp_recaudadora = b.cod_empresa
      AND a.pref_plaza = EV_pref_plaza
      AND a.num_compago = EN_num_compago
      AND a.cod_estado = 'PRO'
      AND a.cod_cliente = EN_cod_cliente
		UNION
		SELECT a.emp_recaudadora, b.des_empresa
		FROM co_hinterfaz_pagos a, ced_empresas b
		WHERE a.emp_recaudadora = b.cod_empresa
      AND a.pref_plaza = EV_pref_plaza
      AND a.num_compago = EN_num_compago
      AND a.cod_estado = 'PRO'
      AND a.cod_cliente = EN_cod_cliente;



	EXCEPTION
     	WHEN OTHERS THEN
            SN_cod_retorno := 301056;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_RECAUDADORA_PAGO_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_MODULO_GE,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_RECAUDADORA_PAGO_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_RECAUDADORA_PAGO_PR;




     PROCEDURE GE_CONS_BANCO_PR (
       EV_cod_banco             IN             VARCHAR2,
       SV_cod_banco             OUT NOCOPY     VARCHAR2,
       SV_des_banco             OUT NOCOPY     VARCHAR2,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento)
	IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "GE_CONS_BANCO_PR"
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2009"
	      Versión="1.0"
	      Diseñador="Joan Zamorano"
	      Programador="Juan Daniel Muñoz Queupul"
	      Ambiente Desarrollo="BD">
	      <Retorno>fechas</Retorno>>
	      <Descripción>Detalle </Descripción>>
	      <Parámetros>
	         <Entrada>
	             <param nom="EV_cod_banco" Tipo="CARACTER">Codigo del banco</param>>
	         </Entrada>
	         <Salida>
              <param nom="SV_cod_banco"      Tipo="CARACTER">codigo de banco</param>>
              <param nom="SV_des_banco"      Tipo="CARACTER">descripcion del banco</param>>
	            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	  LV_des_error	   ge_errores_pg.DesEvent;
  	LV_sSql			     ge_errores_pg.vQuery;
    LO_NO_DATA  EXCEPTION;
    LN_cantidad NUMBER;


	BEGIN
	    SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

     LV_sSql :=' SELECT a.cod_banco, a.des_banco ';
     LV_sSql :=LV_sSql || '  FROM ge_bancos a';
     LV_sSql :=LV_sSql || '  WHERE a.cod_banco = ' || EV_cod_banco ;

     SELECT a.cod_banco, a.des_banco
     INTO SV_cod_banco, SV_des_banco
     FROM ge_bancos a
     WHERE a.cod_banco = EV_cod_banco;



	EXCEPTION
     	WHEN OTHERS THEN
            SN_cod_retorno := 301057;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_BANCO_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_MODULO_GE,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_BANCO_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_BANCO_PR;

 PROCEDURE GE_CONS_OFICINA_PR (
       EN_num_compago           IN             NUMBER,
       EV_pref_plaza            IN             VARCHAR2,
       SV_cod_oficina           OUT NOCOPY     VARCHAR2,
       SV_des_oficina           OUT NOCOPY     VARCHAR2,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento)
	IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "GE_CONS_OFICINA_PR"
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2009"
	      Versión="1.0"
	      Diseñador="Joan Zamorano"
	      Programador="Juan Daniel Muñoz Queupul"
	      Ambiente Desarrollo="BD">
	      <Retorno>oficinas</Retorno>>
	      <Descripción>Detalle </Descripción>>
	      <Parámetros>
	         <Entrada>
	             <param nom="EV_num_compago" Tipo="CARACTER">Numero de comprobante de pago</param>>
               <param nom="EV_pref_plaza" Tipo="CARACTER">Pref plaza de comprobante de pago</param>>
	         </Entrada>
	         <Salida>
              <param nom="SV_cod_oficina"      Tipo="CARACTER">codigo de oficina</param>>
              <param nom="SV_des_banco"      Tipo="CARACTER">descripcion de la oficina</param>>
	            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	  LV_des_error	   ge_errores_pg.DesEvent;
  	LV_sSql			     ge_errores_pg.vQuery;
    LO_NO_DATA  EXCEPTION;
    LN_cantidad NUMBER;


	BEGIN
	    SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

     LV_sSql :=' SELECT a.cod_oficina, b.des_oficina ';
     LV_sSql :=LV_sSql || '  FROM co_movimientoscaja a, ge_oficinas b';
     LV_sSql :=LV_sSql || '  WHERE a.cod_oficina = b.cod_oficina  ';
     LV_sSql :=LV_sSql || '  AND a.pref_plaza =' || EV_pref_plaza ;
     LV_sSql :=LV_sSql || '  AND a.num_compago = ' || EN_num_compago;
     LV_sSql :=LV_sSql || '  AND a.tip_movcaja = 6';
     LV_sSql :=LV_sSql || '  AND a.cod_oficina <> ''NT''';
     LV_sSql :=LV_sSql || '  UNION ';
     LV_sSql :=LV_sSql || '  SELECT a.cod_oficina, b.des_oficina ';
     LV_sSql :=LV_sSql || '  FROM co_histmovcaja a, ge_oficinas b ';
     LV_sSql :=LV_sSql || '  WHERE a.cod_oficina = b.cod_oficina ';
     LV_sSql :=LV_sSql || '  AND  a.pref_plaza =' ||  EV_pref_plaza ;
     LV_sSql :=LV_sSql || '  AND  a.num_compago = ' || EN_num_compago ;
     LV_sSql :=LV_sSql || '  AND  a.tip_movcaja = 6';
     LV_sSql :=LV_sSql || '  AND   a.cod_oficina <> ''NT''';

		SELECT a.cod_oficina, b.des_oficina
    INTO SV_cod_oficina, SV_des_oficina
		FROM co_movimientoscaja a, ge_oficinas b
		WHERE a.cod_oficina = b.cod_oficina AND
		      a.pref_plaza = EV_pref_plaza AND
		      a.num_compago = EN_num_compago AND
		      a.tip_movcaja = 6 AND
		      a.cod_oficina <> 'NT'
		UNION
		SELECT a.cod_oficina, b.des_oficina
		FROM co_histmovcaja a, ge_oficinas b
		WHERE a.cod_oficina = b.cod_oficina AND
		      a.pref_plaza = EV_pref_plaza AND
		      a.num_compago = EN_num_compago AND
		      a.tip_movcaja = 6 AND
		      a.cod_oficina <> 'NT';




	EXCEPTION
     	WHEN OTHERS THEN
            SN_cod_retorno := 301058;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_OFICINA_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_MODULO_GE,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_OFICINA_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_OFICINA_PR;


  PROCEDURE GE_CONS_DISTRIBUIDOR_PR (
       EN_cod_distribuidor      IN             NUMBER,
       SN_cod_cliente           OUT NOCOPY     NUMBER,
       SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento            OUT NOCOPY		 ge_errores_pg.evento)
	IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "GE_CONS_DISTRIBUIDOR_PR"
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2009"
	      Versión="1.0"
	      Diseñador="Joan Zamorano"
	      Programador="Juan Daniel Muñoz Queupul"
	      Ambiente Desarrollo="BD">
	      <Retorno>codigo del cliente</Retorno>>
	      <Descripción>Detalle </Descripción>>
	      <Parámetros>
	         <Entrada>
	             <param nom="EN_cod_distribuidor" Tipo="CARACTER">Número de comprobante de pago</param>>
	         </Entrada>
	         <Salida>
              <param nom="SN_cod_cliente"      Tipo="CARACTER">codigo del cliente </param>>
	            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	  LV_des_error	   ge_errores_pg.DesEvent;
  	LV_sSql			     ge_errores_pg.vQuery;
    LO_NO_DATA  EXCEPTION;
    LN_cantidad NUMBER;


	BEGIN
	    SN_cod_retorno 	:= 0;
	    SV_mens_retorno := NULL;
	    SN_num_evento 	:= 0;

     LV_sSql :=' SELECT a.cod_cliente  ';
     LV_sSql :=LV_sSql || '  INTO SN_cod_cliente ';
     LV_sSql :=LV_sSql || '  FROM ve_vendedores a  ';
     LV_sSql :=LV_sSql || '  WHERE a.cod_vendedor =' || EN_cod_distribuidor || ' AND ' ;
     LV_sSql :=LV_sSql || '   a.ind_interno = 0 ';



     SELECT a.cod_cliente
     INTO SN_cod_cliente
     FROM ve_vendedores a
     WHERE a.cod_vendedor = EN_cod_distribuidor AND
           a.ind_interno = 0;

	EXCEPTION
     	WHEN OTHERS THEN
            SN_cod_retorno := 301059;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_DISTRIBUIDOR_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_MODULO_GE,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_DISTRIBUIDOR_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_DISTRIBUIDOR_PR;



  PROCEDURE GE_CONS_SEGURO_PR (
       EN_cod_abonado             IN             NUMBER,
       SV_cod_seguro              OUT NOCOPY     VARCHAR2,
       SV_des_segur               OUT NOCOPY     VARCHAR2,
       SN_num_eventos             OUT NOCOPY     NUMBER,
       SD_importe_equipo          OUT NOCOPY     ga_seguroabonado_to.importe_equipo%TYPE,
       SN_fec_alta                OUT NOCOPY     DATE,
       SN_fec_fincontrato         OUT NOCOPY     DATE,
       SN_num_maxev               OUT NOCOPY     NUMBER,
       SN_tip_cobert              OUT NOCOPY     NUMBER,
       SV_des_valor               OUT NOCOPY     VARCHAR2,
       SD_deducible               OUT NOCOPY     ga_tiposeguro_td.deducible%TYPE,
       SD_imp_segur	              OUT NOCOPY     ga_tiposeguro_td.imp_segur%TYPE,
       SN_cod_retorno             OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
       SV_mens_retorno            OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
       SN_num_evento              OUT NOCOPY		 ge_errores_pg.evento)
	IS
/*
	<Documentación
	  TipoDoc = "Procedure">>
	   <Elemento
	      Nombre = "GE_CONS_SEGURO_PR"
	      Lenguaje="PL/SQL"
	      Fecha="17-07-2009"
	      Versión="1.0"
	      Diseñador="Joan Zamorano"
	      Programador="Juan Daniel Muñoz Queupul"
	      Ambiente Desarrollo="BD">
	      <Retorno>seguro</Retorno>>
	      <Descripción>Detalle del seguro</Descripción>>
	      <Parámetros>
	         <Entrada>
	             <param nom="EN_cod_abonado" Tipo="CARACTER">Número del abonado</param>>
	         </Entrada>
	         <Salida>
              <param nom="SV_cod_seguro"       Tipo="CARACTER"> código del seguro                                        </param>>
              <param nom="SV_des_segur"        Tipo="CARACTER"> descripción del seguro                                   </param>>
              <param nom="SN_num_eventos"      Tipo="NUMBER">   número de eventos o siniestros que presenta el abonado   </param>>
              <param nom="SD_importe_equipo"   Tipo="DOUBLE">   importe asociado al equipo del abonado                   </param>>
              <param nom="SN_fec_alta"         Tipo="DATE">     fecha de alta del seguro                                 </param>>
              <param nom="SN_fec_fincontrato"  Tipo="DATE">     fecha de fin de contrato del seguro                      </param>>
              <param nom="SN_num_maxev"        Tipo="NUMBER">   cantidad máxima de eventos que permite el seguro         </param>>
              <param nom="SN_tip_cobert"       Tipo="NUMBER">   tipo de cobertura asociada al seguro                     </param>>
              <param nom="SV_des_valor"        Tipo="CARACTER"> descripción del tipo de cobertura                        </param>>
              <param nom="SD_deducible"        Tipo="DOUBLE">   deducible que debe pagar                                 </param>>
              <param nom="SD_imp_segur"        Tipo="DOUBLE">   importe mensual del seguro                               </param>>
	            <param nom="SN_cod_retorno"      Tipo="NUMERICO">Codigo de Retorno</param>>
	            <param nom="SV_mens_retorno"     Tipo="CARACTER">Mensaje de Retorno</param>>
	            <param nom="SN_num_evento"       Tipo="NUMERICO">Numero de Evento</param>>
	         </Salida>
	      </Parámetros>
	   </Elemento>
	</Documentación>
	*/

	  LV_des_error	   ge_errores_pg.DesEvent;
  	LV_sSql			     ge_errores_pg.vQuery;
    LO_NO_DATA  EXCEPTION;
    LN_cantidad NUMBER;


	BEGIN
	    sn_cod_retorno 	:= 0;
	    sv_mens_retorno := NULL;
	    sn_num_evento 	:= 0;

     LV_sSql :=' SELECT a.cod_seguro, b.des_segur, a.num_eventos, a.importe_equipo,  ';
     LV_sSql :=LV_sSql || ' a.fec_alta, a.fec_fincontrato, b.num_maxev, b.tip_cobert, c.des_valor as des_cobertura, ';
     LV_sSql :=LV_sSql || ' b.deducible, b.imp_segur  ';
     LV_sSql :=LV_sSql || ' FROM ga_seguroabonado_to a, ga_tiposeguro_td b, ged_codigos c  ' ;
     LV_sSql :=LV_sSql || ' WHERE a.cod_seguro = b.cod_seguro AND ';
     LV_sSql :=LV_sSql || '       a.num_abonado = '|| EN_cod_abonado ||' AND ';
     LV_sSql :=LV_sSql || '       SYSDATE BETWEEN a.fec_alta AND a.fec_fincontrato AND ';
     LV_sSql :=LV_sSql || '       b.TIP_COBERT = c.cod_valor AND ';
     LV_sSql :=LV_sSql || '       c.cod_modulo = ''GE'' AND ';
     LV_sSql :=LV_sSql || '       c.nom_tabla = ''GA_TIPOSEGURO_TD'' AND ';
     LV_sSql :=LV_sSql || '       c.nom_columna = ''TIP_COBERT''';



		SELECT a.cod_seguro, b.des_segur, a.num_eventos, a.importe_equipo,
		       a.fec_alta, a.fec_fincontrato, b.num_maxev, b.tip_cobert, c.des_valor as des_cobertura,
		       b.deducible, b.imp_segur
    INTO   SV_cod_seguro, SV_des_segur, SN_num_eventos, SD_importe_equipo,
           SN_fec_alta, SN_fec_fincontrato, SN_num_maxev, SN_tip_cobert, SV_des_valor,
           SD_deducible, SD_imp_segur
		FROM ga_seguroabonado_to a, ga_tiposeguro_td b, ged_codigos c
		WHERE a.cod_seguro = b.cod_seguro AND
		      a.num_abonado = EN_cod_abonado AND
		      SYSDATE BETWEEN a.fec_alta AND a.fec_fincontrato AND
		      b.TIP_COBERT = c.cod_valor AND
		      c.cod_modulo = 'GE' AND
		      c.nom_tabla = 'GA_TIPOSEGURO_TD' AND
		      c.nom_columna = 'TIP_COBERT';

	EXCEPTION
     	WHEN OTHERS THEN
            SN_cod_retorno := 301061;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error     :=  'GE_CONS_SEGURO_PR ('||'); - ' || SQLERRM;
            SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                 SN_num_evento,
                                 CV_MODULO_GE,
                                 SV_mens_retorno,
                                 '1.0',
                                 USER,
                                 'GE_INTEGRACION_PG.GE_CONS_SEGURO_PR ',
                                 LV_sSQL, SN_cod_retorno, LV_des_error );

  END GE_CONS_SEGURO_PR;

    PROCEDURE GE_CONS_ABO_PROD_PR ( EV_num_serie        IN         ga_abocel.num_serie%TYPE,
                                    SV_tip_producto     OUT NOCOPY al_componente_kit.NUM_KIT%TYPE,
                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
    IS

    /*
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_ABO_PROD_PR"
        Lenguaje="PL/SQL"
        Fecha="27-08-2009"
        Versión="1.0.0"
        Diseñador="Leonardo Muñoz R."
        Programador="Leonardo Muñoz R."
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Retorna el número de kit asociado al número de serie de un abonado.
    </Descripción>
    <Parámetros>
        <Entrada>
             <param  nom="EV_num_serie"  Tipo="VARCHAR(2) "> Numero de serie </param>
        </Entrada>
        <Salida>
             <param  nom="SV_tip_producto" Tipo="VARCHAR(2)> Tipo de producto </param>
             <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
             <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
             <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

     LV_des_error           ge_errores_pg.DesEvent;
     LV_sSql                ge_errores_pg.vQuery;
     LN_cod_error           ge_errores_pg.CodError;
     LV_mensaje_error       ge_errores_pg.MsgError;
     LN_num_evento          ge_errores_pg.Evento;

    BEGIN

        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        SN_num_evento:= 0;

        LV_sSql := ' SELECT a.num_kit into SV_tip_producto'
                 ||' FROM al_componente_kit a'
                 ||' WHERE a.num_serie = ' ||EV_num_serie;

        SELECT a.num_kit into SV_tip_producto
        FROM al_componente_kit a
        WHERE a.num_serie = EV_num_serie;


    EXCEPTION

            WHEN NO_DATA_FOUND THEN
                NULL;

            WHEN OTHERS THEN
                SN_cod_retorno     := 301062;
                IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno, SV_mens_retorno) THEN
                        SV_mens_retorno := CV_errornoclasificado;
                 END IF;
                LV_des_error     := 'ge_cons_abo_prod_pr ('||'); - ' || SQLERRM;
                SN_num_evento    := Ge_Errores_Pg.grabarpl( LN_num_evento, CV_modulo_ge, SV_mens_retorno, cv_version, USER, 'ge_integracion_pg.ge_cons_abo_prod_pr', LV_sSql, SN_cod_retorno, LV_des_error );
    END;


-------------------------------------------------------------------------------
PROCEDURE ge_obtener_datos_distrib_pr (
        EN_cod_distribuidor IN  ve_vendedores.cod_vendedor%TYPE,
        SV_nom_vendedor     OUT NOCOPY ve_vendedores.nom_vendedor%TYPE,
        SV_cod_tipident     OUT NOCOPY ve_vendedores.cod_tipident%TYPE,
        SV_des_tipident     OUT NOCOPY ge_tipident.des_tipident%TYPE,
        SV_num_ident        OUT NOCOPY ve_vendedores.num_ident%TYPE,
        SN_cod_cliente      OUT NOCOPY ve_vendedores.cod_cliente%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_obtener_datos_distrib_pr"
        Lenguaje="PL/SQL"
        Fecha="05-08-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> Datos Distribuidor </Retorno>

    <Descripción>
        Este procedimiento retorna los datos del distribuidor
        asociado al código de ditribuidor ingresado.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_cod_distribuidor" Tipo="NUMBER(6)">
        Variable de entrada Código de Comisionista</param>
    </Entrada>
    <Salida>
        <param nom="SV_nom_vendedor" Tipo="VARCHAR2(40)">
            Variable de salida Nombre de Comisionista</param>

        <param nom="SV_cod_tipident" Tipo="VARCHAR2(2)">
            Variable de salida Código Tipo de Identificación</param>

        <param nom="SV_des_tipident" Tipo="VARCHAR2(20)">
            Variable de salida Descripcion del tipo de identificacion - Retrofitted</param>

        <param nom="SV_num_ident" Tipo="VARCHAR2(20)">
            Variable de salida Número de Identificación</param>

        <param nom="SN_cod_cliente" Tipo="VARCHAR2(8)">
            Variable de salida Código de Cliente asociado</param>

        <param nom="SV_cod_tipcontrato" Tipo="VARCHAR2(3)">
            Variable de salida Codigo de Tipo de Contrato</param>

        <param nom="SV_des_tipcontrato" Tipo="VARCHAR2(30)">
            Variable de salida Descripción de Tipo de Contrato</param>

        <param nom="SV_num_contrato" Tipo="VARCHAR2(21)">
            Variable de salida Numero de Contrato</param>

        <param nom="SV_num_anexo" Tipo="VARCHAR2(21)">
            Variable de salida Numero de Anexo de Contrato</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	*/

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN

    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    
    LV_sSql := 'SELECT  a.nom_vendedor, a.cod_tipident, b.des_tipident, a.num_ident,
                        a.cod_cliente 
                FROM (  SELECT  a.cod_vendedor, a.nom_vendedor, a.cod_tipident,
                                a.num_ident, a.cod_cliente
                        FROM (  SELECT  a.cod_vendedor, a.nom_vendedor, a.cod_tipident,
                                        a.num_ident, a.cod_cliente
                                FROM    ve_vendedores a, ge_clientes b 
                                WHERE   a.cod_cliente = b.cod_cliente AND
                                        a.cod_vendedor = ' || EN_cod_distribuidor || ' AND
                                        a.ind_interno = 0
                                ) a
                        WHERE ROWNUM=1) a, ge_tipident b
                WHERE   a.cod_tipident = b.cod_tipident ';
                        
                        

    SELECT  a.nom_vendedor, a.cod_tipident, b.des_tipident, a.num_ident,
            a.cod_cliente
    INTO    SV_nom_vendedor, SV_cod_tipident, SV_des_tipident, SV_num_ident,
            SN_cod_cliente
    FROM (  SELECT  a.cod_vendedor, a.nom_vendedor, a.cod_tipident,
                    a.num_ident, a.cod_cliente
            FROM (  SELECT  a.cod_vendedor, a.nom_vendedor, a.cod_tipident,
                            a.num_ident, a.cod_cliente
                    FROM    ve_vendedores a, ge_clientes b
                    WHERE   a.cod_cliente = b.cod_cliente AND
                            a.cod_vendedor = EN_cod_distribuidor AND
                            a.ind_interno = 0) a
            WHERE ROWNUM=1) a, ge_tipident b
    WHERE   a.cod_tipident = b.cod_tipident;


EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno := 301049;
        IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_errornoclasificado;
        END IF;
        LV_des_error    :=  ' ge_obtener_datos_distrib_pr ('||'); - ' || SQLERRM;
        SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                            SN_num_evento,
                            CV_modulo_ge,
                            SV_mens_retorno,
                            CV_version,
                            USER,
                            'GE_INT_ALEJANDRO_PG.ge_obtener_datos_distrib_pr',
                            LV_sSql,
                            SN_cod_retorno,
                            LV_des_error );

END ge_obtener_datos_distrib_pr;

------------------------------------------------------------------------------
PROCEDURE ge_obtener_bodegas_distrib_pr (
        EN_cod_distribuidor IN  ve_vendedores.cod_vendedor%TYPE,
        SC_cursor           OUT NOCOPY  refcursor,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_obtener_datos_distrib_pr"
        Lenguaje="PL/SQL"
        Fecha="05-08-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> Datos Bodega asociados al Distribuidor </Retorno>

    <Descripción>
        Este procedimiento retorna un listado de bodegas
        asociado al código de ditribuidor ingresado.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_cod_distribuidor" Tipo="NUMBER(6)">
        Variable de entrada Código de Comisionista</param>
    </Entrada>
    <Salida>
        <param nom="cod_bodega" Tipo="NUMBER(6)">
            Variable de salida Código de Bodega</param>

        <param nom="des_bodega" Tipo="VARCHAR2(30)">
            Variable de salida Descripción Bodega</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	*/

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    i number;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

        LV_sSql := 'SELECT COUNT(*)
                    FROM ve_vendalmac a, al_bodegas b, al_bodeganodo c, ge_operadora_scl d
                    WHERE a.cod_vendedor = ' || EN_cod_distribuidor || ' AND
                    SYSDATE BETWEEN a.fec_asignacion AND  NVL(a.fec_desasignac,SYSDATE) AND
                    a.cod_bodega = b.cod_bodega AND
                    b.cod_bodega = c.cod_bodega AND
                    c.cod_bodeganodo = d.cod_bodeganodo AND
                    d.cod_operadora_scl = GE_FN_OPERADORA_SCL
                    ORDER BY b.des_bodega ASC';

        EXECUTE IMMEDIATE LV_sSql INTO i;

        LV_sSql := 'SELECT a.cod_bodega, b.des_bodega
                    FROM ve_vendalmac a, al_bodegas b, al_bodeganodo c, ge_operadora_scl d
                    WHERE a.cod_vendedor = ' || EN_cod_distribuidor || ' AND
                    SYSDATE BETWEEN a.fec_asignacion AND  NVL(a.fec_desasignac,SYSDATE) AND
                    a.cod_bodega = b.cod_bodega AND
                    b.cod_bodega = c.cod_bodega AND
                    c.cod_bodeganodo = d.cod_bodeganodo AND
                    d.cod_operadora_scl = GE_FN_OPERADORA_SCL
                    ORDER BY b.des_bodega ASC';

        if i = 0 then
            RAISE cursorVacio_exception;
        end if;

        OPEN SC_cursor FOR LV_sSql;

    EXCEPTION
            WHEN cursorVacio_exception THEN
            SN_cod_retorno := 301050;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
	        END IF;
            LV_des_error    :=  ' ge_obtener_bodegas_distrib_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INT_ALEJANDRO_PG.ge_obtener_bodegas_distrib_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

        WHEN OTHERS THEN
            SN_cod_retorno := 301050;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
                sv_mens_retorno := CV_errornoclasificado;
	        END IF;
            LV_des_error    :=  ' ge_obtener_bodegas_distrib_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                cv_version,
                                USER,
                                'GE_INT_ALEJANDRO_PG.ge_obtener_bodegas_distrib_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_obtener_bodegas_distrib_pr;

----------------------------------------------------------------------------------
PROCEDURE ge_obtener_pedido_distrib_pr (
        EN_cod_cliente_distrib  IN  npt_pedido.cod_cliente%TYPE,
        EN_cod_pedido           IN  npt_pedido.cod_pedido%TYPE,
        SN_mto_neto_pedido      OUT NOCOPY npt_pedido.mto_neto_pedido%TYPE,
        SN_can_total_pedido     OUT NOCOPY npt_pedido.can_total_pedido%TYPE,
        SN_mto_total_pedido     OUT NOCOPY npt_pedido.mto_tot_pedido%TYPE,
        SN_cod_bodega           OUT NOCOPY npt_pedido.cod_bodega%TYPE,
        SV_des_bodega           OUT NOCOPY al_bodegas.des_bodega%TYPE,
        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_obtener_pedido_distrib_pr"
        Lenguaje="PL/SQL"
        Fecha="05-08-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> Datos Pedido asociados al Distribuidor </Retorno>

    <Descripción>
        Este procedimiento retorna los datos del pedido
        asociados al código de ditribuidor y código de pedido ingresado.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_cod_distribuidor" Tipo="NUMBER(6)">
        Variable de entrada Código de Comisionista</param>
        <param nom="EN_cod_pedido" Tipo="NUMBER(12)">
        Variable de entrada Código de Pedido</param>
    </Entrada>
    <Salida>
        <param nom="SN_mto_neto_pedido" Tipo="NUMBER(16.4)">
            Variable de salida Monto Neto del Pedido</param>

        <param nom="SN_can_total_pedido" Tipo="NUMBER(8)">
            Variable de salida Cantidad Total del Pedido</param>

        <param nom="SN_mto_total_pedido" Tipo="NUMBER(7.2)">
            Variable de salida Código de Bodega</param>

        <param nom="SN_cod_bodega" Tipo="NUMBER(6)">
            Variable de salida Código de Bodega</param>

        <param nom="SV_des_bodega" Tipo="VARCHAR2(30)">
            Variable de salida Descripción Bodega</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	*/

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN

    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    LV_sSql := 'SELECT  a.mto_neto_pedido, a.can_total_pedido, a.mto_tot_pedido,
                        a.cod_bodega, b.des_bodega
                FROM npt_pedido a, al_bodegas b
                WHERE a.cod_bodega = b.cod_bodega AND
                a.cod_cliente = ' || EN_cod_cliente_distrib || ' AND
                a.cod_pedido = ' || EN_cod_pedido;

    SELECT  a.mto_neto_pedido, a.can_total_pedido, a.mto_tot_pedido,
            a.cod_bodega, b.des_bodega
    INTO    SN_mto_neto_pedido, SN_can_total_pedido, SN_mto_total_pedido,
            SN_cod_bodega, SV_des_bodega
    FROM    npt_pedido a, al_bodegas b
    WHERE   a.cod_bodega = b.cod_bodega AND
            a.cod_cliente = EN_cod_cliente_distrib  AND
            a.cod_pedido = EN_cod_pedido;

EXCEPTION
    WHEN OTHERS THEN
        SN_cod_retorno := 301051;
        IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
            sv_mens_retorno := CV_errornoclasificado;
        END IF;
        LV_des_error    :=  ' ge_obtener_pedido_distrib_pr ('||'); - ' || SQLERRM;
        SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                            SN_num_evento,
                            CV_modulo_ge,
                            SV_mens_retorno,
                            cv_version,
                            USER,
                            'GE_INT_ALEJANDRO_PG.ge_obtener_pedido_distrib_pr',
                            LV_sSql,
                            SN_cod_retorno,
                            LV_des_error );

END ge_obtener_pedido_distrib_pr;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ge_obtener_saldo_moroso_pr(
        EN_cod_cliente      IN  co_morosos.cod_cliente%TYPE,
        SV_sSaldoVenc       OUT NOCOPY   NUMBER,
        SV_sSaldoNoVenc     OUT NOCOPY   NUMBER,
        SN_cod_retorno      OUT NOCOPY   ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY   ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY   ge_errores_pg.Evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_val_clie_moroso_pr"
        Lenguaje="PL/SQL"
        Fecha="12-08-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> N/A </Retorno>

    <Descripción>
        Este procedimiento valida si cod_cliente ingresado se encuentra moroso.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_cod_cliente"  Tipo="NUMBER(8)">
        Variable de Entrada Código de Cliente </param>
    </Entrada>
    <Salida>
        <param nom="SV_sSaldoVenc" Tipo="NUMBER">
        monto actual: corresponde al total de la deuda (deuda vencida + deuda no vencida) </param>

        <param nom="SV_sSaldoNoVenc" Tipo="NUMBER">
        pago mínimo: saldo total en mora (deuda vencida) </param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    i integer;
    no_es_clie_moroso   EXCEPTION;
    LV_sFecVencimiento VARCHAR2(8);
    LV_clie_moroso      BOOLEAN;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql:=   'SELECT COUNT(1)
                     FROM co_morosos a
                     WHERE a.cod_cliente = ' || EN_cod_cliente;

        SELECT COUNT(1) into i
        FROM co_morosos a
        WHERE a.cod_cliente = EN_cod_cliente;

        IF i>0 THEN
            LV_clie_moroso := CO_CRITERIOS_PG.CO_GETSALDOCLIENTE_FN(EN_cod_cliente, SV_sSaldoVenc, SV_sSaldoNoVenc, LV_sFecVencimiento );
            IF LV_clie_moroso = FALSE THEN
                RAISE no_es_clie_moroso;
            END IF;
        ELSE
            RAISE no_es_clie_moroso;
        END IF;

EXCEPTION
        WHEN no_es_clie_moroso THEN
            SN_cod_retorno := 301053;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,sv_mens_retorno) THEN
                sv_mens_retorno := CV_errornoclasificado;
            END IF;


        WHEN OTHERS THEN
            SN_cod_retorno := 301052;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_obtener_saldo_moroso_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_obtener_saldo_moroso_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

    END ge_obtener_saldo_moroso_pr;

--------------------------------------------------------------------------------

PROCEDURE ge_val_pospago_hib_pr(
        EN_numCelular       IN          ga_abocel.num_celular%TYPE,
        EN_tipo_abonado     IN          ged_codigos.des_valor%TYPE,
        SN_num_abonado      OUT NOCOPY  ga_abocel.num_abonado%TYPE,
        SN_cod_cliente      OUT NOCOPY  ga_abocel.cod_cliente%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)
IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_val_pospago_hib_pr"
        Lenguaje="PL/SQL"
        Fecha="19-08-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> Abonado vigente (cliente pospago o hibrido)</Retorno>

    <Descripción>
        Este procedimiento consulta datos de abonado pospago o hibrido para un número de teléfono.
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_numCelular"  Tipo="NUMBER(15)">
        Variable de entrada Número Celular </param>

        <param nom="EN_tipo_abonado" Tipo="ged_codigos.des_valor%TYPE">
        Variable de entrada Tipo de Abonado</param>
    </Entrada>
    <Salida>
        <param nom="SN_numAbonado" Tipo="NUMBER(8)">
        Variable de salida Secuencia Numero Abonado</param>

        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    LV_sSql := 'SELECT  b.num_abonado, b.cod_cliente
                FROM    ga_abocel b, ta_plantarif a
                WHERE   a.cod_plantarif = b.cod_plantarif AND
                        b.num_celular = '||EN_numCelular||' AND
                        b.cod_situacion NOT IN (''BAA'',''BAP'') AND
                        a.cod_tiplan = (SELECT a.cod_valor
                            FROM ged_codigos a
                            WHERE a.cod_modulo = ''GE'' AND
                                a.nom_tabla = ''TA_PLANTARIF'' AND
                                a.nom_columna = ''COD_TIPLAN'' AND
                                a.des_valor = '''||EN_tipo_abonado||''')';

    SELECT  b.num_abonado, b.cod_cliente
    INTO    SN_num_abonado, SN_cod_cliente
    FROM    ga_abocel b, ta_plantarif a
    WHERE   a.cod_plantarif = b.cod_plantarif AND
            b.num_celular = EN_numCelular AND
            b.cod_situacion NOT IN ('BAA','BAP') AND
            a.cod_tiplan = (SELECT a.cod_valor
                      FROM ged_codigos a
                      WHERE a.cod_modulo = 'GE' AND
                            a.nom_tabla = 'TA_PLANTARIF' AND
                            a.nom_columna = 'COD_TIPLAN' AND
                            a.des_valor = ''||EN_tipo_abonado||'');


    EXCEPTION

        WHEN OTHERS THEN
            SN_cod_retorno := 301009;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_val_pospago_hib_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_val_pospago_hib_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_val_pospago_hib_pr;

--------------------------------------------------------------------------------

PROCEDURE ge_update_cliente_pr(
        EN_cod_cliente      IN          ge_clientes.cod_cliente%TYPE,
        EV_num_tarjeta      IN          ge_clientes.num_tarjeta%TYPE,
        EV_ind_debito       IN          ge_clientes.ind_debito%TYPE,
        EV_cod_tiptarjeta   IN          ge_clientes.cod_tiptarjeta%TYPE,
        ED_fec_venc_tarj    IN          VARCHAR2,
        EV_cod_banco_tarj   IN          ge_clientes.cod_bancotarj%TYPE,
        EV_nom_titular_tarj IN          ge_clientes.nom_titulartarjeta%TYPE,
        EV_obs_pac          IN          ge_clientes.obs_pac%TYPE,
        SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
        SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
        SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento)


IS
    /*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "ge_update_cliente_pr"
        Lenguaje="PL/SQL"
        Fecha="24-08-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Alejandro Lorca"
        Ambiente="BD"

    <Retorno> </Retorno>

    <Descripción>
        Este procedimiento actualiza el registro de la tabla de clientes
        asociado al código de cliente ingresado
    </Descripción>

    <Parámetros>
    <Entrada>
        <param nom="EN_cod_cliente"  Tipo="NUMBER(8)">
        Variable de entrada Código Cliente </param>

        <param nom="EV_num_tarjeta"  Tipo="VARCHAR2(18)">
        Variable de entrada Numero de tarjeta </param>

        <param nom="EV_ind_debito"  Tipo="VARCHAR"(1)">
        Variable de entrada Indicativo Debito ; Automatico (A), Manual (M) </param>

        <param nom="EN_cod_sispago"  Tipo="NUMBER(2)">
        Variable de entrada Sistema de pago </param>

        <param nom="EV_cod_tiptarjeta"  Tipo="VARCHAR2(3)">
        Variable de entrada Codigo Tipo Tarjeta </param>

        <param nom="ED_fec_venc_tarj"  Tipo="DATE">
        Variable de entrada Fecha vencimiento de la tarjeta </param>

        <param nom="EV_cod_banco_tarj"  Tipo="VARCHAR2(15)">
        Variable de entrada Codigo banco tarjeta </param>

        <param nom="EV_nom_titular_tarj"  Tipo="VARCHAR2(50)">
        Variable de entrada Nombre del Titular de la tarjeta </param>

        <param nom="EV_obs_pac"  Tipo="VARCHAR2(100)">
        Variable de entrada Observacion </param>

    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">
        Variable de salida Codigo de Retorno,
        SN_cod_retorno=0 valido,
        SN_cod_retorno=-1 error</param>

        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">
        Variable Descripcion mensaje de error </param>

        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">
        Variable de salida numero de evento </param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    LD_fec_venc_tarj    ge_clientes.fec_vencitarj%TYPE;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';
    LD_fec_venc_tarj := to_date(ED_fec_venc_tarj, 'yyyymmdd');

    LV_sSql := 'UPDATE ge_clientes a
                SET a.ind_debito = '''||EV_ind_debito||'''
                    ,a.cod_sispago = 4
                    ,a.cod_tiptarjeta = '''||EV_cod_tiptarjeta||'''
                    ,a.num_tarjeta = '''||EV_num_tarjeta||'''
                    ,a.fec_vencitarj = '''||LD_fec_venc_tarj||'''
                    ,a.cod_bancotarj = '''||EV_cod_banco_tarj||'''
                    ,a.nom_titulartarjeta = '''||EV_nom_titular_tarj||'''
                    ,a.obs_pac = '''||EV_obs_pac||'''
                WHERE a.cod_cliente = '||EN_cod_cliente;

    UPDATE ge_clientes a
    SET a.ind_debito = ''||EV_ind_debito||''
        ,a.cod_sispago = 4
        ,a.cod_tiptarjeta = ''||EV_cod_tiptarjeta||''
        ,a.num_tarjeta = ''||EV_num_tarjeta||''
        ,a.fec_vencitarj = ''||LD_fec_venc_tarj||''
        ,a.cod_bancotarj = ''||EV_cod_banco_tarj||''
        ,a.nom_titulartarjeta = ''||EV_nom_titular_tarj||''
        ,a.obs_pac = ''||EV_obs_pac||''
    WHERE a.cod_cliente = EN_cod_cliente;


    EXCEPTION

        WHEN OTHERS THEN
            SN_cod_retorno := 301060;
            IF NOT Ge_Errores_Pg.mensajeerror(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' ge_update_cliente_pr ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_modulo_ge,
                                SV_mens_retorno,
                                CV_version,
                                USER,
                                'GE_INTEGRACION_PG.ge_update_cliente_pr',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error );

END ge_update_cliente_pr;


PROCEDURE GE_CONS_SERV_SUPLEMENTARIOS_PR (
        EN_num_abonado    IN              ga_abocel.num_abonado%TYPE,
        EV_cod_plantarif  IN              ga_abocel.Cod_plantarif%TYPE,
        EV_cod_planserv   IN              ga_abocel.cod_planserv%TYPE,
        EN_tip_servicio   IN              NUMBER,
        SC_servsupl		    OUT             refcursor,
        SN_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
        SV_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
        SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS

/*--
    <Documentación TipoDoc = "Procedimiento Almacenado">
        Elemento Nombre = "GE_CONS_SERV_SUPLEMENTARIOS_PR"
        Lenguaje="PL/SQL"
        Fecha="18-06-2009"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="Juan Muñoz"
        Ambiente="BD"
    <Retorno>N/A</Retorno>
    <Descripción>Este procedimiento retorna los servicios suplementarios contrados por un abonado</Descripción>
    <Parámetros>
    <Entrada>
        <param nom="EN_num_telefono"  Tipo="NUMBER(8)">Variable de entrada Numero de Abonado</param>
    </Entrada>
    <Salida>
        <param nom="SC_servsupl" Tipo="CURSOR">Cursor que contiene los servicios suplementarios contrados por un abonado</param>
        <param nom="SN_cod_retorno" Tipo="ge_errores_pg.CodError">Codigo de Retorno (SN_cod_retorno=0 numero valido, SN_cod_retorno=-1 error)</param>
        <param nom="SV_mens_retorno" Tipo="ge_errores_pg.MsgError">Descripcion mensaje de error</param>
        <param nom="SN_num_evento" Tipo="ge_errores_pg.Evento">Número de evento</param>
	</Salida>
	</Parámetros>
	</Elemento>
	</Documentación>
	*/

    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
    LV_ERRORCLASIF      VARCHAR2 (500) := 'No fue posible obtener los servicios suplementarios contratados por el abonado asociado al número de teléfono ingresado';
    LO_abonado          pv_datos_abo_qt := NEW pv_datos_abo_qt();
    error_exception     EXCEPTION;

BEGIN
    SN_num_evento:= 0;
    SN_cod_retorno:=0;
    SV_mens_retorno:='';

    LO_abonado.num_abonado:= EN_num_abonado;

    LV_sSql := 'PV_SERV_SUPLEMENTARIO_SB_PG.PV_REC_SERV_SUPL_ABONADO_PR(' || LO_abonado.num_abonado;
    LV_sSql := LV_sSql || ', ' || EN_tip_servicio || ')';

    PV_SERV_SUPLEMENTARIO_SB_PG.PV_REC_SERV_SUPL_ABONADO_PR(LO_abonado, EN_tip_servicio, SC_servsupl, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

    IF SN_cod_retorno <> 0 THEN
        RAISE error_exception;
    END IF;

EXCEPTION
        WHEN error_exception THEN
            SN_cod_retorno := 301019;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_CONS_SERV_SUPLEMENTARIOS_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_MODULO_GE,
                                SV_mens_retorno,
                                '1.0',
                                USER,
                                'GE_INTEGRACION_PG.GE_CONS_SERV_SUPLEMENTARIOS_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error);

        WHEN OTHERS THEN
            SN_cod_retorno := 301019;
            IF NOT Ge_Errores_Pg.mensajeerror(sn_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_errornoclasificado;
            END IF;
            LV_des_error    :=  ' GE_CONS_SERV_SUPLEMENTARIOS_PR ('||'); - ' || SQLERRM;
            SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                SN_num_evento,
                                CV_MODULO_GE,
                                SV_mens_retorno,
                                '1.0',
                                USER,
                                'GE_INTEGRACION_PG.GE_CONS_SERV_SUPLEMENTARIOS_PR',
                                LV_sSql,
                                SN_cod_retorno,
                                LV_des_error);
END GE_CONS_SERV_SUPLEMENTARIOS_PR;


-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_COD_CLASCLIE( EV_cod_cliente      IN         ge_clientes.cod_cliente%TYPE,
                                SV_cod_tipo         OUT NOCOPY ge_clientes.cod_tipo%TYPE,
                                SV_cod_segmento     OUT NOCOPY ge_clientes.cod_segmento%TYPE,
                                SV_cod_color        OUT NOCOPY ge_clientes.cod_color%TYPE,
                                SV_cod_calificacion OUT NOCOPY ge_clientes.cod_calificacion%TYPE,
                                SV_cod_categoria    OUT NOCOPY ge_clientes.cod_categoria%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

    /*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_COD_CLASCLIE"
        Lenguaje="PL/SQL"
        Fecha="14-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="rlozano"
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Servicio que permite consultar los códigos asociados a la clasificación del Cliente
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_cliente"  Tipo="NUMBER"> Código de Cliente </param>
    </Entrada>
    <Salida>
        <param  nom="SV_cod_tipo" Tipo="VARCHAR(2)> Código de tipo </param>
        <param  nom="SV_cod_segmento" Tipo="VARCHAR(2)> Código de segmento </param>
        <param  nom="SV_cod_color" Tipo="VARCHAR(2)> Código de color </param>
        <param  nom="SV_cod_calificacion" Tipo="VARCHAR(2)> Código de calificación </param>
        <param  nom="SV_cod_categoria" Tipo="VARCHAR(2)> Código de categoria </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;

    LN_cod_error          ge_errores_pg.CodError;
    LV_mensaje_error      ge_errores_pg.MsgError;
    LN_num_evento         ge_errores_pg.Evento;

    LV_sSql               ge_errores_pg.vQuery;

BEGIN

    LN_num_evento:= 0;
    LN_cod_error:=0;
    LV_mensaje_error:='';

      LV_sSql :=   ' SELECT cod_tipo, cod_segmento, cod_color, cod_calificacion, cod_categoria'
                 ||' FROM ge_clientes '
                 ||' WHERE cod_cliente =' ||EV_cod_cliente;

         SELECT cod_tipo, cod_segmento, cod_color, cod_calificacion, cod_categoria
         INTO SV_cod_tipo, SV_cod_segmento, SV_cod_color, SV_cod_calificacion, SV_cod_categoria
         FROM ge_clientes
         WHERE cod_cliente = EV_cod_cliente;


EXCEPTION

        WHEN OTHERS THEN
                LN_cod_error     := 301047;
                IF NOT Ge_Errores_Pg.mensajeerror(LN_cod_error, SV_mensaje_error) THEN
                       SV_mensaje_error := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_constipserv_pr ('||'); - ' || SQLERRM;
                LN_num_evento    := Ge_Errores_Pg.grabarpl( LN_num_evento, CV_modulo_ge, SV_mensaje_error, cv_version, USER, 'ge_integracion_pg.GE_CONS_COD_CLASCLIE', LV_sSql, LN_cod_error, LV_des_error );

END;
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_COD_SEGM(     EV_cod_segmento     IN ge_clientes.cod_segmento%TYPE,
                                EV_cod_tipo         IN ge_clientes.cod_tipo%TYPE,
                                SV_des_segmento     OUT NOCOPY ge_segmentacion_clientes_td.des_segmento%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

    /*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_COD_CLASCLIE"
        Lenguaje="PL/SQL"
        Fecha="14-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="rlozano"
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
         Servicio que permite consultar la descripcion del segmento  del Cliente
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_segmento"  Tipo="VARCHAR"> Código de segemnto </param>
        <param  nom="EV_cod_tipo"  Tipo="VARCHAR"> Código de tipo </param>
    </Entrada>
    <Salida>

        <param  nom="SV_des_segmento" Tipo="VARCHAR(2)> Descripcion de segmento </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;

    LN_cod_error          ge_errores_pg.CodError;
    LV_mensaje_error      ge_errores_pg.MsgError;
    LN_num_evento         ge_errores_pg.Evento;

    LV_sSql               ge_errores_pg.vQuery;

BEGIN

    LN_num_evento:= 0;
    LN_cod_error:=0;
    LV_mensaje_error:='';

      LV_sSql :=   ' SELECT a.des_segmento '
                 ||' FROM ge_segmentacion_clientes_td a '
                 ||' WHERE a.cod_tipo = '||EV_cod_tipo
                 ||' AND  a.cod_segmento ='||EV_cod_segmento;


                SELECT a.des_segmento
                INTO SV_des_segmento
                FROM ge_segmentacion_clientes_td a
                WHERE a.cod_tipo = EV_cod_tipo
                 AND  a.cod_segmento =EV_cod_segmento;


EXCEPTION

        WHEN OTHERS THEN
                LN_cod_error     := 301047;
                IF NOT Ge_Errores_Pg.mensajeerror(LN_cod_error, SV_mensaje_error) THEN
                       SV_mensaje_error := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_constipserv_pr ('||'); - ' || SQLERRM;
                LN_num_evento    := Ge_Errores_Pg.grabarpl( LN_num_evento, CV_modulo_ge, SV_mensaje_error, cv_version, USER, 'ge_integracion_pg.GE_CONS_COD_SEGM', LV_sSql, LN_cod_error, LV_des_error );

END;
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_COLOR  (      EV_cod_color        IN ge_clientes.cod_color%TYPE,
                                SV_des_color        OUT NOCOPY ge_color_td .des_color%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

    /*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_COD_CLASCLIE"
        Lenguaje="PL/SQL"
        Fecha="14-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="rlozano"
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
         Servicio que permite consultar la descripcion del color asociado al  Cliente
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_color"  Tipo="VARCHAR"> Código de color </param>
    </Entrada>
    <Salida>

        <param  nom="SV_des_color" Tipo="VARCHAR(2)> Descripcion de color </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;

    LN_cod_error          ge_errores_pg.CodError;
    LV_mensaje_error      ge_errores_pg.MsgError;
    LN_num_evento         ge_errores_pg.Evento;

    LV_sSql               ge_errores_pg.vQuery;

BEGIN

    LN_num_evento:= 0;
    LN_cod_error:=0;
    LV_mensaje_error:='';

      LV_sSql :=   ' SELECT a.des_color'
                || ' FROM ge_color_td a '
                || ' WHERE a.cod_color = '||EV_cod_color;


                SELECT a.des_color
                INTO SV_des_color
                FROM ge_color_td a
                WHERE a.cod_color = EV_cod_color;



EXCEPTION

        WHEN OTHERS THEN
                LN_cod_error     := 301047;
                IF NOT Ge_Errores_Pg.mensajeerror(LN_cod_error, SV_mensaje_error) THEN
                       SV_mensaje_error := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_constipserv_pr ('||'); - ' || SQLERRM;
                LN_num_evento    := Ge_Errores_Pg.grabarpl( LN_num_evento, CV_modulo_ge, SV_mensaje_error, cv_version, USER, 'ge_integracion_pg.GE_CONS_COLOR', LV_sSql, LN_cod_error, LV_des_error );

END;
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_CALIFCLIE  (  EV_cod_calificacion IN ge_clientes.cod_calificacion%TYPE,
                                SV_des_calificacion OUT NOCOPY ge_calificacion_td.des_calificacion%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

    /*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_COD_CLASCLIE"
        Lenguaje="PL/SQL"
        Fecha="14-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="rlozano"
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Servicio que permite consultar la descripcion de la calificacion del cliente
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_calificacion"  Tipo="VARCHAR"> Código de calificacion </param>
    </Entrada>
    <Salida>

        <param  nom="SV_des_calificacion" Tipo="VARCHAR(2)> Descripcion de calificacion </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;

    LN_cod_error          ge_errores_pg.CodError;
    LV_mensaje_error      ge_errores_pg.MsgError;
    LN_num_evento         ge_errores_pg.Evento;

    LV_sSql               ge_errores_pg.vQuery;

BEGIN

    LN_num_evento:= 0;
    LN_cod_error:=0;
    LV_mensaje_error:='';

      LV_sSql :=   ' SELECT a.des_calificacion '
                 ||' FROM ge_calificacion_td a '
                 ||' WHERE a.cod_calificacion = '||EV_cod_calificacion;


               SELECT a.des_calificacion
               INTO SV_des_calificacion
               FROM ge_calificacion_td a
               WHERE a.cod_calificacion = EV_cod_calificacion;




EXCEPTION

        WHEN OTHERS THEN
                LN_cod_error     := 301047;
                IF NOT Ge_Errores_Pg.mensajeerror(LN_cod_error, SV_mensaje_error) THEN
                       SV_mensaje_error := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_constipserv_pr ('||'); - ' || SQLERRM;
                LN_num_evento    := Ge_Errores_Pg.grabarpl( LN_num_evento, CV_modulo_ge, SV_mensaje_error, cv_version, USER, 'ge_integracion_pg.GE_CONS_CALIFCLIE', LV_sSql, LN_cod_error, LV_des_error );

END;
-------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_CATEGCLIE  (  EV_cod_categoria    IN ge_clientes.cod_categoria%TYPE,
                                SV_des_categoria    OUT NOCOPY ge_categorias.des_categoria%TYPE,
                                SN_cod_error        OUT NOCOPY ge_errores_pg.CodError,
                                SV_mensaje_error    OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
IS

    /*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_COD_CLASCLIE"
        Lenguaje="PL/SQL"
        Fecha="14-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano"
        Programador="rlozano"
        Ambiente="BD"
    <Retorno>
        NA
    </Retorno>
    <Descripción>
        Servicio que permite consultar la descripcion de la categoría del cliente
    </Descripción>
    <Parámetros>
    <Entrada>
        <param  nom="EV_cod_categoria"  Tipo="VARCHAR"> Código de categoria asociado al cliente </param>
    </Entrada>
    <Salida>

        <param  nom="SV_des_categoria" Tipo="VARCHAR(2)> Descripcion de la categoría asociada al cliente </param>
        <param nom="SN_cod_error"  Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"  Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"  Tipo="ge_errores_pg.Evento">Numero evento</param>
    </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error          ge_errores_pg.DesEvent;

    LN_cod_error          ge_errores_pg.CodError;
    LV_mensaje_error      ge_errores_pg.MsgError;
    LN_num_evento         ge_errores_pg.Evento;

    LV_sSql               ge_errores_pg.vQuery;

BEGIN

    LN_num_evento:= 0;
    LN_cod_error:=0;
    LV_mensaje_error:='';

      LV_sSql :=   ' SELECT a.des_categoria '
                 ||' INTO SV_des_categoria '
                 ||' FROM ge_categorias a '
                 ||' WHERE cod_categoria = '||EV_cod_categoria;


              SELECT a.des_categoria
              INTO SV_des_categoria
              FROM ge_categorias a
              WHERE cod_categoria = EV_cod_categoria;

EXCEPTION

        WHEN OTHERS THEN
                LN_cod_error     := 301047;
                IF NOT Ge_Errores_Pg.mensajeerror(LN_cod_error, SV_mensaje_error) THEN
                       SV_mensaje_error := CV_errornoclasificado;
                END IF;
                LV_des_error     := 'ge_constipserv_pr ('||'); - ' || SQLERRM;
                LN_num_evento    := Ge_Errores_Pg.grabarpl( LN_num_evento, CV_modulo_ge, SV_mensaje_error, cv_version, USER, 'ge_integracion_pg.GE_CONS_CATEGCLIE', LV_sSql, LN_cod_error, LV_des_error );

END;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GE_CONS_BOLSA_PLANTARIF_PR(
           EV_cod_plan       IN  tol_bolsa_plan_td.cod_plan%TYPE,
           SV_cod_bolsa      OUT tol_bolsa_plan_td.cod_bolsa%TYPE,
           SV_ind_unidad     OUT tol_bolsa_td.ind_unidad%TYPE,
           SN_cnt_bolsa      OUT tol_bolsa_td.cnt_bolsa%TYPE,
           SD_fec_ini_vig    OUT tol_bolsa_plan_td.fec_ini_vig%TYPE,
           SD_fec_ter_vig    OUT tol_bolsa_plan_td.fec_ter_vig%TYPE,
           SV_des_unidad     OUT sch_codigos.gls_param%TYPE,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_BOLSA_PLANTARIF_PR"
        Lenguaje="PL/SQL"
        Fecha="29-05-2008"
        Versión="1.0.0"
        Diseñador="Joan Zamorano Jaramillo"
        Programador=""
        Ambiente="BD"
         <Retorno>N/A</Retorno>
         <Descripción>Retorna los datos de la bolsa asociada a un plantarifario</Descripción>
      <Parámetros>
      <Entrada>
        <param nom="EV_cod_plan"  Tipo="VARCHAR2">código del plan tarifario</param>
      </Entrada>
      <Salida>
        <param nom="SV_cod_bolsa"       Tipo="VARCHAR2">Codigo de la bolsa asociada al plan tarifario consultado</param>
        <param nom="SV_ind_unidad"      Tipo="VARCHAR2">Indicador de la unidad en que se encuentra la bolsa</param>
        <param nom="SN_cnt_bolsa"       Tipo="NUMBER">Cantidad o monto de la bolsa</param>
        <param nom="SD_fec_ini_vig"     Tipo="NUMBER">Fecha de inicio de vigencia de la bolsa</param>
        <param nom="SD_fec_ter_vig"     Tipo="NUMBER">Fecha de término de vigencia de la bolsa</param>
        <param nom="SN_cod_error"       Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Numero evento</param>
      </Salida>
      </Parámetros>
     </Elemento>
    </Documentación>
    */

    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;

    LV_CodeSql      ga_errores.cod_sqlcode%TYPE;
    LV_ErrmSql      ga_errores.cod_sqlerrm%TYPE;
    LN_NumEvento    NUMBER;

BEGIN

        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_bolsa, b.ind_unidad, b.cnt_bolsa, a.fec_ini_vig, a.fec_ter_vig, c.gls_param as des_unidad';
        LV_Sql:= LV_Sql || ' FROM tol_bolsa_plan_td a, tol_bolsa_td b';
        LV_Sql:= LV_Sql || ' WHERE a.cod_bolsa = b.cod_bolsa AND';
        LV_Sql:= LV_Sql || ' a.cod_plan = ' || EV_cod_plan || ' AND';
        LV_Sql:= LV_Sql || ' SYSDATE BETWEEN a.fec_ini_vig AND a.fec_ter_vig AND';
        LV_Sql:= LV_Sql || ' b.ind_unidad = c.cod_param AND';
        LV_Sql:= LV_Sql || ' c.cod_tipo = ''INDUNIDAD''';

        SELECT a.cod_bolsa, b.ind_unidad, b.cnt_bolsa, a.fec_ini_vig, a.fec_ter_vig, c.gls_param as des_unidad
        INTO SV_cod_bolsa, SV_ind_unidad, SN_cnt_bolsa, SD_fec_ini_vig, SD_fec_ter_vig, SV_des_unidad
        FROM tol_bolsa_plan_td a, tol_bolsa_td b, sch_codigos c
        WHERE a.cod_bolsa = b.cod_bolsa AND
              a.cod_plan = EV_cod_plan AND
              SYSDATE BETWEEN a.fec_ini_vig AND a.fec_ter_vig AND
              b.ind_unidad = c.cod_param AND
              c.cod_tipo = 'INDUNIDAD' AND
              a.ind_default = 'S'; --S indica default; N: indica no default

      EXCEPTION
           WHEN OTHERS THEN
              SN_codRetorno := 301065;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_errornoclasificado;
              END IF;
              LV_des_error  := 'GE_INTEGRACION_PG.GE_CONS_BOLSA_PLANTARIF_PR;- ' || SQLERRM;
              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, USER, 'GE_INTEGRACION_PG.GE_CONS_BOLSA_PLANTARIF_PR', LV_Sql, SQLCODE, LV_des_error );

END GE_CONS_BOLSA_PLANTARIF_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_CONS_ULT_OOSS_EJEC_PR(
           EV_cod_os         IN  ci_tiporserv.cod_os%TYPE,
           EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
           SN_num_os         OUT ci_orserv.num_os%TYPE,
           SD_fecha_os       OUT ci_orserv.fecha%TYPE,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_ULT_OOSS_EJEC_PR"
        Lenguaje="PL/SQL"
        Fecha="30-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano Jaramillo"
        Programador=""
        Ambiente="BD"
         <Retorno>N/A</Retorno>
         <Descripción>Retorna el número de la última OOSS ejecutada para un abonado y código de orden de servicio específica</Descripción>
      <Parámetros>
      <Entrada>
        <param nom="EV_cod_os"   Tipo="VARCHAR2">código de la OOSS a consultar</param>
        <param nom="EN_num_abonado"   Tipo="NUMBER">número de abonado a consultar</param>
      </Entrada>
      <Salida>
        <param nom="SN_num_os"          Tipo="NUMBER">Número de la OOSS</param>
        <param nom="SD_fecha_os"        Tipo="DATE">Fecha en que se registró la OOSS</param>
        <param nom="SN_cod_error"       Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Numero evento</param>
      </Salida>
      </Parámetros>
     </Elemento>
    </Documentación>
    */

    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;

    LV_CodeSql      ga_errores.cod_sqlcode%TYPE;
    LV_ErrmSql      ga_errores.cod_sqlerrm%TYPE;
    LN_NumEvento    NUMBER;

BEGIN

        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.num_os, a.fecha';
        LV_Sql:= LV_Sql || ' FROM ci_orserv a';
        LV_Sql:= LV_Sql || ' WHERE a.cod_os = ' || EV_cod_os || ' AND';
        LV_Sql:= LV_Sql || ' a.cod_inter = ' || EN_num_abonado || ' AND';
        LV_Sql:= LV_Sql || ' a.fecha = (SELECT MAX(a.fecha) FROM ci_orserv a WHERE a.cod_os = ' || EV_cod_os;
        LV_Sql:= LV_Sql || ' AND a.cod_inter = ' || EN_num_abonado || ')';

        SELECT a.num_os, a.fecha
        INTO SN_num_os, SD_fecha_os
        FROM ci_orserv a
        WHERE a.cod_os = EV_cod_os AND
              a.cod_inter = EN_num_abonado AND
              a.fecha = (SELECT MAX(a.fecha) FROM ci_orserv a WHERE a.cod_os = EV_cod_os AND a.cod_inter = EN_num_abonado);

      EXCEPTION
           WHEN NO_DATA_FOUND THEN
              SN_num_os := 0;
           WHEN OTHERS THEN
              SN_codRetorno := 301067;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_errornoclasificado;
              END IF;
              LV_des_error  := 'GE_INTEGRACION_PG.GE_CONS_ULT_OOSS_EJEC_PR;- ' || SQLERRM;
              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, USER, 'GE_INTEGRACION_PG.GE_CONS_ULT_OOSS_EJEC_PR', LV_Sql, SQLCODE, LV_des_error );

END GE_CONS_ULT_OOSS_EJEC_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_CONS_RENOVACION_PR(
           EV_cod_os         IN  ci_tiporserv.cod_os%TYPE,
           EN_num_os         IN  ci_orserv.num_os%TYPE,
           SN_ind_renova     OUT NUMBER,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_RENOVACION_PR"
        Lenguaje="PL/SQL"
        Fecha="30-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano Jaramillo"
        Programador=""
        Ambiente="BD"
         <Retorno>N/A</Retorno>
         <Descripción>Retorna indicador de renovación (0: abonado renovado; 1: indica abonado no renovado)</Descripción>
      <Parámetros>
      <Entrada>
        <param nom="EV_cod_os"   Tipo="VARCHAR2">código de la OOSS a consultar</param>
        <param nom="EN_num_os"   Tipo="NUMBER">Número de la OOSS</param>
      </Entrada>
      <Salida>
        <param nom="SN_ind_renova"      Tipo="NUMBER">Indicador de Renovación</param>
        <param nom="SN_cod_error"       Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Numero evento</param>
      </Salida>
      </Parámetros>
     </Elemento>
    </Documentación>
    */

    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;

    LV_CodeSql      ga_errores.cod_sqlcode%TYPE;
    LV_ErrmSql      ga_errores.cod_sqlerrm%TYPE;
    LN_NumEvento    NUMBER;

BEGIN

        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT 0 as ind_renovacion';
        LV_Sql:= LV_Sql || ' FROM pv_registra_renovacion_os_to a';
        LV_Sql:= LV_Sql || ' WHERE a.cod_os = ' || EV_cod_os || ' AND';
        LV_Sql:= LV_Sql || ' a.num_os = ' || EN_num_os;

        SELECT 0 as ind_renovacion
        INTO SN_ind_renova
        FROM pv_registra_renovacion_os_to a
        WHERE a.cod_os = EV_cod_os AND
              a.num_os = EN_num_os;

      EXCEPTION
           WHEN NO_DATA_FOUND THEN
              SN_ind_renova := 1;
           WHEN OTHERS THEN
              SN_codRetorno := 301068;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_errornoclasificado;
              END IF;
              LV_des_error  := 'GE_INTEGRACION_PG.GE_CONS_RENOVACION_PR;- ' || SQLERRM;
              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, USER, 'GE_INTEGRACION_PG.GE_CONS_RENOVACION_PR', LV_Sql, SQLCODE, LV_des_error );

END GE_CONS_RENOVACION_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_CONS_CAU_CAM_EQ_PR(
           EN_num_abonado    IN  ga_abocel.num_abonado%TYPE,
           SV_cod_caucaser   OUT ga_caucaser.cod_caucaser%TYPE,
           SV_des_caucaser   OUT ga_caucaser.des_caucaser%TYPE,
           SN_codRetorno     OUT NOCOPY ge_errores_pg.CodError,
           SV_menRetorno     OUT NOCOPY ge_errores_pg.MsgError,
           SN_numEvento      OUT NOCOPY ge_errores_pg.Evento)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_CONS_CAU_CAM_EQ_PR"
        Lenguaje="PL/SQL"
        Fecha="30-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano Jaramillo"
        Programador=""
        Ambiente="BD"
         <Retorno>N/A</Retorno>
         <Descripción>Retorna los datos asociados a la causa del cambio de un equipo</Descripción>
      <Parámetros>
      <Entrada>
        <param nom="EN_num_abonado"   Tipo="NUMBER">número de abonado a consultar</param>
      </Entrada>
      <Salida>
        <param nom="SV_cod_caucaser"    Tipo="VARCHAR2">Código de causa cambio de equipo</param>
        <param nom="SV_des_caucaser"    Tipo="VARCHAR2">Descripción de causa cambio de equipo</param>
        <param nom="SN_cod_error"       Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_mensaje_error"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_num_evento"      Tipo="ge_errores_pg.Evento">Numero evento</param>
      </Salida>
      </Parámetros>
     </Elemento>
    </Documentación>
    */

    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;

    LV_CodeSql      ga_errores.cod_sqlcode%TYPE;
    LV_ErrmSql      ga_errores.cod_sqlerrm%TYPE;
    LN_NumEvento    NUMBER;

BEGIN

        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='SELECT a.cod_caucaser, a.des_caucaser';
        LV_Sql:= LV_Sql || ' FROM ga_caucaser a';
        LV_Sql:= LV_Sql || ' WHERE a.cod_caucaser = (SELECT b.cod_causa';
        LV_Sql:= LV_Sql || ' FROM ga_equipaboser b';
        LV_Sql:= LV_Sql || ' WHERE b.num_abonado = ' || EN_num_abonado || ' AND';
        LV_Sql:= LV_Sql || ' b.fec_alta = (SELECT MAX(c.fec_alta) FROM ga_equipaboser c WHERE c.num_abonado = ' || EN_num_abonado || ') AND';
        LV_Sql:= LV_Sql || ' ROWNUM=1)';

        SELECT a.cod_caucaser, a.des_caucaser
        INTO SV_cod_caucaser, SV_des_caucaser
        FROM ga_caucaser a
        WHERE a.cod_caucaser = (SELECT b.cod_causa
                                FROM ga_equipaboser b
                                WHERE b.num_abonado = EN_num_abonado AND
                                      b.fec_alta = (SELECT MAX(c.fec_alta) FROM ga_equipaboser c WHERE c.num_abonado = EN_num_abonado) AND
                                      ROWNUM=1);

      EXCEPTION
           WHEN OTHERS THEN
              SN_codRetorno := 301069;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_errornoclasificado;
              END IF;
              LV_des_error  := 'GE_INTEGRACION_PG.GE_CONS_CAU_CAM_EQ_PR;- ' || SQLERRM;
              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, USER, 'GE_INTEGRACION_PG.GE_CONS_CAU_CAM_EQ_PR', LV_Sql, SQLCODE, LV_des_error );

END GE_CONS_CAU_CAM_EQ_PR;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GE_insPagoAutomatico_PR(EN_codcliente   IN  co_unipac.cod_cliente%TYPE,
                                  EV_codbanco     IN  co_unipac.cod_banco%TYPE,
                                  EN_numtelefono  IN  co_unipac.num_telefono%TYPE,
                                  EV_codzona      IN  co_unipac.cod_zona%TYPE,
                                  EV_codcentral   IN  co_unipac.cod_central%TYPE,
                                  EN_codbcoi      IN  co_unipac.cod_bcoi%TYPE,
                                  SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_numEvento    OUT NOCOPY ge_errores_pg.Evento)
IS
/*--
    <Documentación TipoDoc = "Procedimiento">
        Elemento Nombre = "GE_insPagoAutomatico_PR"
        Lenguaje="PL/SQL"
        Fecha="30-03-2010"
        Versión="1.0.0"
        Diseñador="Joan Zamorano Jaramillo"
        Programador=""
        Ambiente="BD"
         <Retorno>N/A</Retorno>
         <Descripción>Inserta los datos de la tarjeta de crédito necesarios para realizar un pago (PAT)</Descripción>
      <Parámetros>
      <Entrada>
        <param nom="EN_codcliente"   Tipo="NUMBER">número de cliente</param>
        <param nom="EV_codbanco"   Tipo="VARCHAR2">Código del banco asociado a la tarjeta</param>
        <param nom="EN_numtelefono"   Tipo="NUMBER">número de teléfono</param>
        <param nom="EV_codzona"   Tipo="VARCHAR2">Codigo de Zona</param>
        <param nom="EV_codcentral"   Tipo="VARCHAR2">Codigo de Central</param>
        <param nom="EN_codbcoi"   Tipo="NUMBER">Codigo de Banco Interno</param>
      </Entrada>
      <Salida>
        <param nom="SN_codRetorno"       Tipo="ge_errores_pg.CodError">Código Error</param>
        <param nom="SV_menRetorno"   Tipo="ge_errores_pg.MsgError">Mensaje Error</param>
        <param nom="SN_numEvento"      Tipo="ge_errores_pg.Evento">Numero evento</param>
      </Salida>
      </Parámetros>
     </Elemento>
    </Documentación>
    */

    LV_des_error     ge_errores_pg.desevent;
    LV_sql             ge_errores_pg.vquery;

    LV_CodeSql      ga_errores.cod_sqlcode%TYPE;
    LV_ErrmSql      ga_errores.cod_sqlerrm%TYPE;
    LN_NumEvento    NUMBER;
    error_excepcion EXCEPTION;

BEGIN

        SN_codRetorno := 0;
        SV_menRetorno := NULL;
        SN_numEvento  := 0;

        LV_Sql:='DELETE co_unipac WHERE cod_cliente = ' || EN_codcliente;

        DELETE co_unipac WHERE cod_cliente = EN_codcliente;

        LV_Sql:='CO_SERVICIOS_COBRANZA_PG.CO_insPagoAutomatico_PR(' || EN_CODCLIENTE;
        LV_Sql:= LV_Sql || ', ' || EV_CODBANCO;
        LV_Sql:= LV_Sql || ', ' || EN_NUMTELEFONO;
        LV_Sql:= LV_Sql || ', ' || EV_CODZONA;
        LV_Sql:= LV_Sql || ', ' || EV_CODCENTRAL;
        LV_Sql:= LV_Sql || ', ' || EN_CODBCOI;
        LV_Sql:= LV_Sql || ', SN_CODRETORNO';
        LV_Sql:= LV_Sql || ', SV_MENRETORNO';
        LV_Sql:= LV_Sql || ', SN_NUMEVENTO';
        LV_Sql:= LV_Sql || ')' ;

        CO_SERVICIOS_COBRANZA_PG.CO_insPagoAutomatico_PR(EN_CODCLIENTE, EV_CODBANCO, EN_NUMTELEFONO, EV_CODZONA, EV_CODCENTRAL, EN_CODBCOI, SN_CODRETORNO, SV_MENRETORNO, SN_NUMEVENTO);

        IF (SN_CODRETORNO != 0) THEN
            RAISE error_excepcion;
        END IF;


      EXCEPTION
           WHEN error_excepcion THEN
              SN_codRetorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_errornoclasificado;
              END IF;
              LV_des_error  := 'GE_INTEGRACION_PG.GE_insPagoAutomatico_PR;- ' || SQLERRM;
              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, USER, 'GE_INTEGRACION_PG.GE_insPagoAutomatico_PR', LV_Sql, SQLCODE, LV_des_error );

           WHEN OTHERS THEN
              SN_codRetorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_errornoclasificado;
              END IF;
              LV_des_error  := 'GE_INTEGRACION_PG.GE_insPagoAutomatico_PR;- ' || SQLERRM;
              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_modulo_ge, SV_menRetorno,CV_version, USER, 'GE_INTEGRACION_PG.GE_insPagoAutomatico_PR', LV_Sql, SQLCODE, LV_des_error );

END GE_insPagoAutomatico_PR;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END GE_INTEGRACION_PG;
/
SHOW ERRORS