CREATE OR REPLACE PACKAGE BODY Ve_Servicios_solicitud_Pg IS

    PROCEDURE VE_obtiene_niveles_prest_PR(  EV_cod_prestacion  IN  GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                                EN_cod_nivel       IN GA_NIVELPRESTACION_TD.COD_NIVEL%TYPE,
                                                SC_cursordatos     OUT NOCOPY REFCURSOR,
                                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
IS
   /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_obtiene_niveles_prest_PR
        Lenguaje="PL/SQL"
        Fecha="16-12-2009"
        Version="1.0.0"
        Dise?ador="Elizabeth Vera"
        Programador="Elizabeth Vera"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Obtiene lista de niveles o subniveles configurados para una prestacion
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EV_cod_prestacion"     Tipo="VARCHAR2"> codigo de prestacion </param>
        <param nom="EN_cod_nivel"          Tipo="NUMBER""> codigo de nivel </param>
    </Entrada>
    <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR"> lista de niveles </param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;

    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_Sql:= 'SELECT COD_NIVEL, DES_NIVEL FROM GA_NIVELPRESTACION_TD WHERE COD_PRESTACION= ' || EV_cod_prestacion
                ||' AND COD_PADRE ='||EN_cod_nivel || ' AND IND_VIGENCIA = 1 ORDER BY IND_ORDEN';

        OPEN SC_cursordatos FOR
            SELECT COD_NIVEL, DES_NIVEL FROM GA_NIVELPRESTACION_TD
            WHERE COD_PRESTACION = EV_cod_prestacion
            AND COD_PADRE = EN_cod_nivel
            AND IND_VIGENCIA = 1 ORDER BY IND_ORDEN;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:Ve_Servicios_Solicitud_Pg.VE_obtiene_niveles_prest_PR('|| EV_cod_prestacion ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'Ve_Servicios_Solicitud_Pg.VE_obtiene_niveles_prest_PR', LV_Sql, SN_cod_retorno, LV_des_error );
    END VE_obtiene_niveles_prest_PR;



   PROCEDURE VE_inserta_niveles_abo_PR ( EN_numAbonado         IN GA_ABONIVEL_TO.NUM_ABONADO%TYPE,
                                         EN_codNivel1         IN GA_ABONIVEL_TO.COD_NIVEL1%TYPE,
                                         EN_codNivel2         IN GA_ABONIVEL_TO.COD_NIVEL2%TYPE,
                                         EN_codNivel3         IN GA_ABONIVEL_TO.COD_NIVEL3%TYPE,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
   IS
   /*--
    <Documentacion TipoDoc = "Procedimiento">
        Elemento Nombre = "VE_inserta_niveles_abo_PR"
        Lenguaje="PL/SQL"
        Fecha="17-12-2009"
        Version="1.0.0"
        Dise?ador="Elizabeth Vera"
        Programador="Elizabeth Vera"
        Ambiente="BD"
    <Retorno>NA</Retorno>
    <Descripcion>
        Graba niveles asociados al abonado
    </Descripcion>
    <Parametros>
    <Entrada>
        <param nom="EN_numAbonado     Tipo="NUMBER"> numero del abonado </param>
        <param nom="EN_cod_nivel1"          Tipo="NUMBER""> codigo de nivel 1</param>
        <param nom="EN_cod_nivel2"          Tipo="NUMBER""> codigo de nivel 2</param>
        <param nom="EN_cod_nivel3"          Tipo="NUMBER""> codigo de nivel 3</param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
    </Salida>
    </Parametros>
    </Elemento>
    </Documentacion>
    --*/
        LV_des_error  ge_errores_pg.desevent;
        LV_sSql        ge_errores_pg.vquery;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        LV_sSql:= 'INSERT INTO GA_ABONIVEL_TO(NUM_ABONADO, COD_NIVEL1, COD_NIVEL2, COD_NIVEL3) '
                || 'VALUES('||EN_numAbonado||','||EN_codNivel1||','|| EN_codNivel2||','|| EN_codNivel3||');';

        INSERT INTO GA_ABONIVEL_TO(NUM_ABONADO, COD_NIVEL1, COD_NIVEL2, COD_NIVEL3)
        VALUES(EN_numAbonado, EN_codNivel1, EN_codNivel2, EN_codNivel3);


   EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_inserta_niveles_abo_PR('|| EN_numAbonado ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_inserta_niveles_abo_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_inserta_niveles_abo_PR;

      PROCEDURE VE_Consulta_Vta_abo_PR ( EN_codCliente        IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                         SN_COUNT            OUT NOCOPY NUMBER,
                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
   IS
        LV_des_error  ge_errores_pg.desevent;
        LV_sSql        ge_errores_pg.vquery;
        LN_COUNT      NUMBER(9);
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        SN_COUNT:=0;

        LV_sSql:='SELECT COUNT(1) FROM GA_ABOCEL'
        || 'WHERE COD_CLIENTE=' || EN_codCliente
        || ' AND COD_SITUACION IN (AAA)';

        SELECT COUNT(1)
        INTO LN_COUNT
        FROM GA_ABOCEL
        WHERE COD_CLIENTE= EN_codCliente
        AND COD_SITUACION IN ('AAA');

        IF LN_COUNT >0 THEN
           SN_COUNT:= LN_COUNT;
        ELSE --Podria haber en prepago

           LV_sSql:='SELECT COUNT(1) FROM GA_ABOAMIST'
           || 'WHERE COD_CLIENTE=' || EN_codCliente
           || ' AND COD_SITUACION IN (AAA)';

           SELECT COUNT(1)
           INTO LN_COUNT
           FROM GA_ABOAMIST
           WHERE COD_CLIENTE= EN_codCliente
           AND COD_SITUACION IN ('AAA');

           IF LN_COUNT >0 THEN
           SN_COUNT:= LN_COUNT;
           END IF;
        END IF;


   EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_Consulta_Vta_abo_PR('|| EN_codCliente ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_Consulta_Vta_abo_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_Consulta_Vta_abo_PR;
PROCEDURE VE_inserta_datosAdic_abo_PR ( EN_numAbonado       IN GA_DATABONADO_TO.NUM_ABONADO%TYPE,
                                        EN_indRenova        IN GA_DATABONADO_TO.IND_RENOVA%TYPE,
                                        EN_numFax           IN GA_DATABONADO_TO.NUM_FAX%TYPE,
                                        EV_codCalificacion  IN GA_DATABONADO_TO.COD_CALIFICACION%TYPE,
                                        SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
   IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        LV_sSql:= 'INSERT INTO GA_DATABONADO_TO(NUM_ABONADO, IND_RENOVA,NUM_FAX, COD_CALIFICACION) '
                || 'VALUES('||EN_numAbonado||','||EN_indRenova||',' || EN_numFax ||', ' || EV_codCalificacion ||');';

        INSERT INTO GA_DATABONADO_TO(NUM_ABONADO, IND_RENOVA,NUM_FAX, COD_CALIFICACION)
        VALUES(EN_numAbonado, EN_indRenova,EN_numFax,EV_codCalificacion);

   EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_inserta_datosAdic_abo_PR('|| EN_numAbonado ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_inserta_datosAdic_abo_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_inserta_datosAdic_abo_PR;
      PROCEDURE VE_Upd_datosAdic_abo_PR ( EN_numAbonado     IN GA_DATABONADO_TO.NUM_ABONADO%TYPE,
                                          EV_DIR_MAC        IN GA_DATABONADO_TO.MAC_ADDRESS%TYPE,
                                          SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento       OUT NOCOPY ge_errores_pg.Evento)
   IS
        LV_des_error  ge_errores_pg.desevent;
        LV_sSql        ge_errores_pg.vquery;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

         LV_sSql:= 'UPDATE  GA_DATABONADO_TO';
        IF (EV_DIR_MAC IS NOT NULL) THEN
            LV_sSql:= LV_sSql || ' SET MAC_ADDRESS =''' ||  EV_DIR_MAC || '''';
        END IF;
            LV_sSql:= LV_sSql || ' WHERE NUM_ABONADO =' || EN_numAbonado;

        EXECUTE IMMEDIATE LV_sSql;

   EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_Upd_datosAdic_abo_PR('|| EN_numAbonado ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_Upd_datosAdic_abo_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_Upd_datosAdic_abo_PR;
       PROCEDURE VE_Valida_FlitroImpresion_PR
                                        (EV_NomUsuario          IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                         EV_cod_Programa        IN GE_PROGRAMAS.COD_PROGRAMA%TYPE,
                                         EV_NomProceso          IN GAD_PROCESOS_PERFILES.NOM_PERFIL_PROCESO%TYPE,
                                         EV_codVersion          IN GE_PROGRAMAS.NUM_VERSION%TYPE,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS

            LV_des_Error ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
             LN_contador  NUMBER;
            LB_and       BOOLEAN;
            v_cod_retorno      ge_errores_pg.CodError;
            v_mens_retorno     ge_errores_pg.MsgError;
            v_num_evento       ge_errores_pg.Evento;
            v_cod_operadora    ge_parametros_sistema_vw.VALOR_TEXTO%TYPE;
            LV_codProceso GAD_PROCESOS_PERFILES.COD_PROCESO%TYPE;


        BEGIN
            SN_num_evento   := 0;
            SN_cod_retorno  := 0;
            SV_mens_retorno := '';


            LV_sql:='SELECT COD_PROCESO FROM GAD_PROCESOS_PERFILES WHERE NOM_PERFIL_PROCESO =' || EV_NomProceso ;

            SELECT COD_PROCESO
            INTO LV_codProceso
            FROM GAD_PROCESOS_PERFILES
            WHERE NOM_PERFIL_PROCESO =EV_NomProceso;



            LV_sql:='SELECT A.COD_PROCESO'
            || ' FROM GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B'
            || ' WHERE A.COD_GRUPO = B.COD_GRUPO'
            || ' AND B.NOM_USUARIO = ' || EV_NomUsuario
            || ' AND A.COD_PROGRAMA =' || EV_cod_programa
            || ' AND A.NUM_VERSION =  '|| EV_codVersion
            || ' AND A.COD_PROCESO = ' || LV_codProceso
            || ' AND ROWNUM = 1';

            SELECT A.COD_PROCESO
            INTO LV_codProceso
            FROM GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
            WHERE A.COD_GRUPO = B.COD_GRUPO
            AND B.NOM_USUARIO = EV_NomUsuario
            AND A.COD_PROGRAMA = EV_cod_programa
            AND A.NUM_VERSION =  EV_codVersion
            AND A.COD_PROCESO =  LV_codProceso
            AND ROWNUM = 1;

        EXCEPTION
            WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error    := SUBSTR('OTHERS:Ve_Servicios_solicitud_Pg.VE_Valida_FlitroImpresion_PR(); - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno,'1.0', USER,
                 'Ve_Servicios_solicitud_Pg.VE_Valida_FlitroImpresion_PR',LV_Sql,SN_cod_retorno,LV_des_error);
    END VE_Valida_FlitroImpresion_PR;
    PROCEDURE VE_obtiene_Detalle_PA_PR(     EV_numVenta        IN GA_ABOCEL.NUM_VENTA%TYPE,
                                            SC_cursordatos           OUT NOCOPY REFCURSOR,
                                            SC_cursordatosSeguro     OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
IS
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;

    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


        OPEN SC_cursordatos FOR
                  SELECT e.num_abonado,D.DES_PROD_OFERTADO,B.MONTO_IMPORTE, B.COD_MONEDA,A.COD_PROD_CONTRATADO, A.COD_CARGO_CONTRATADO, A.COD_CONCEPTO, f.des_moneda
                  FROM FA_CARGOS_REC_TO A, PF_CARGOS_PRODUCTOS_TD B, PR_PRODUCTOS_CONTRATADOS_TO C, PF_PRODUCTOS_OFERTADOS_TD D, ga_abocel e, ge_monedas f
                  WHERE A.COD_PROD_CONTRATADO<>0
                  AND A.COD_CARGO_CONTRATADO=B.COD_CARGO
                  AND A.COD_PROD_CONTRATADO=C.COD_PROD_CONTRATADO
                  AND C.COD_PROD_OFERTADO=D.COD_PROD_OFERTADO
                  AND e.num_venta = EV_numVenta
                  AND e.num_abonado = a.NUM_ABONADOSERV
                  AND b.cod_moneda = f.cod_moneda;


        OPEN SC_cursordatosSeguro FOR
                  SELECT e.num_abonado,D.DES_SEGUR,D.IMP_SEGUR , B.COD_MONEDA,A.COD_PROD_CONTRATADO, A.COD_CARGO_CONTRATADO, A.COD_CONCEPTO, f.des_moneda
                  FROM FA_CARGOS_REC_TO A, PF_CARGOS_PRODUCTOS_TD B, GA_TIPOSEGURO_TD D, ga_abocel e, ge_monedas f
                  WHERE A.COD_PROD_CONTRATADO=0
                  AND A.COD_CARGO_CONTRATADO=B.COD_CARGO
                  AND A.COD_CARGO_CONTRATADO=D.COD_CARGO
                  AND e.num_venta = EV_numVenta
                  AND e.num_abonado = a.NUM_ABONADOSERV
                  and a.cod_concepto=d.cod_concepto
                  AND b.cod_moneda = f.cod_moneda;




    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:Ve_Servicios_Solicitud_Pg.VE_obtiene_Detalle_PA_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'Ve_Servicios_Solicitud_Pg.VE_obtiene_Detalle_PA_PR', LV_Sql, SN_cod_retorno, LV_des_error );
    END VE_obtiene_Detalle_PA_PR;


 PROCEDURE VE_inserta_numsms_PR(  EN_numAbonado        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EN_numSMS            IN GA_NUMSMS_TO.NUM_TELSMS%TYPE,
                                  EV_usuario           IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                  SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
   IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        LV_sSql:= 'INSERT INTO GA_NUMSMS_TO(NUM_ABONADO, NUM_TELSMS,NOM_USUARIO) '
                || 'VALUES('||EN_numAbonado||','||EN_numSMS||',' || EV_usuario ||');';

        INSERT INTO GA_NUMSMS_TO(NUM_ABONADO,NUM_TELSMS,NOM_USUARIO, FEC_MODIFICA )
        VALUES(EN_numAbonado, EN_numSMS,EV_Usuario , sysdate);

   EXCEPTION
            WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_inserta_numsms_PR('|| EN_numAbonado ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_inserta_numsms_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_inserta_numsms_PR;



  PROCEDURE VE_existe_numsms_PR(  EN_numSMS             IN GA_NUMSMS_TO.NUM_TELSMS%TYPE,
                                  SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
   IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

     existe            NUMBER(1);
     ERROR_PROCEDIMIENTO   EXCEPTION;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        SELECT count(1)
        INTO existe
        FROM GA_NUMSMS_TO
        WHERE NUM_TELSMS = EN_numSMS;

        IF existe > 0 THEN
           RAISE ERROR_PROCEDIMIENTO;
        END IF;


   EXCEPTION
   WHEN ERROR_PROCEDIMIENTO THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'El número SMS ya se encuentra asignado.';
             LV_des_error := SUBSTR('OTHERS:VE_existe_numsms_PR('|| EN_numSMS ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_existe_numsms_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_existe_numsms_PR('|| EN_numSMS ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_existe_numsms_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_existe_numsms_PR;
     PROCEDURE VE_VALIDA_VENDEDORLN_PR ( EN_COD_VENDEDOR      IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
   IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

     existe            NUMBER(2);
     ERROR_PROCEDIMIENTO   EXCEPTION;
     LV_NUM_IDENT GE_CLIENTES.NUM_IDENT%TYPE;
     LV_COD_TIPIDENT GE_CLIENTES.COD_TIPIDENT%TYPE;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

         SELECT COUNT(1)
         INTO existe
         FROM GA_LNVEN_TO
         WHERE COD_VENDEDOR=EN_COD_VENDEDOR
         AND COD_ESTADO=1;--Vigencia

         IF existe > 0 THEN
           RAISE ERROR_PROCEDIMIENTO;
         END IF;


   EXCEPTION
   WHEN ERROR_PROCEDIMIENTO THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Vendedor se encuentra en Listas Negras, no se puede continuar con la solicitud de venta.';
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_VENDEDORLN('|| EN_COD_VENDEDOR  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_VENDEDORLN', LV_sSql, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_VENDEDORLN('|| EN_COD_VENDEDOR  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_VENDEDORLN', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_VALIDA_VENDEDORLN_PR;
        PROCEDURE VE_VALIDA_VENDEDOREXTLN_PR
                                     (EN_COD_VENDEALER      IN VE_VENDEALER.COD_VENDEALER%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
   IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

     existe            NUMBER(2);
     ERROR_PROCEDIMIENTO   EXCEPTION;
     LV_NUM_IDENT GE_CLIENTES.NUM_IDENT%TYPE;
     LV_COD_TIPIDENT GE_CLIENTES.COD_TIPIDENT%TYPE;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

         SELECT COUNT(1)
         INTO existe
         FROM GA_LNVEN_TO
         WHERE COD_VENDEALER=EN_COD_VENDEALER
         AND COD_ESTADO=1;--Vigencia

         IF existe > 0 THEN
           RAISE ERROR_PROCEDIMIENTO;
         END IF;

   EXCEPTION
   WHEN ERROR_PROCEDIMIENTO THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Vendedor externo se encuentra en Listas Negras, no se puede continuar con la solicitud de venta.';
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_VENDEDOREXTLN_PR('|| EN_COD_VENDEALER  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_VENDEDOREXTLN_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_VENDEDORLN('|| EN_COD_VENDEALER  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_VENDEDOREXTLN_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_VALIDA_VENDEDOREXTLN_PR;

   PROCEDURE VE_VALIDA_CLIENTELN_PR
                                     (EN_COD_CLIENTE       IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                      EV_NUM_IDENT         GE_CLIENTES.NUM_IDENT%TYPE,
                                      EV_COD_TIPIDENT      GE_CLIENTES.COD_TIPIDENT%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
   IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

     existe            NUMBER(8);
     ERROR_PROCEDIMIENTO   EXCEPTION;

   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

         IF EN_COD_CLIENTE IS NOT NULL THEN
            SELECT COUNT(1)
            INTO existe
            FROM GA_LNCLI_TO
            WHERE COD_CLIENTE=EN_COD_CLIENTE
            AND COD_ESTADO=1;--Vigencia

         ELSE
            SELECT COUNT(1)
            INTO existe
            FROM GA_LNCLI_TO
            WHERE NUM_IDENT1=EV_NUM_IDENT
            AND COD_TIPIDENT1=EV_COD_TIPIDENT
			AND COD_ESTADO = 1
            AND NUM_IDENT1 <> 'C/F';
         END IF;

         IF existe > 0 THEN
           RAISE ERROR_PROCEDIMIENTO;
         END IF;

   EXCEPTION
   WHEN ERROR_PROCEDIMIENTO THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Cliente se encuentra en Listas Negras, no se puede continuar con la solicitud de venta.';
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_CLIENTELN_PR('|| EN_COD_CLIENTE  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_CLIENTELN_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_CLIENTELN_PR('|| EN_COD_CLIENTE  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_CLIENTELN_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_VALIDA_CLIENTELN_PR;
      PROCEDURE VE_VALIDA_SERIELN_PR
                                     (EN_NUM_SERIE         IN GA_ABOCEL.NUM_SERIE%TYPE,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
   IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

     existe            NUMBER(2);
     ERROR_PROCEDIMIENTO   EXCEPTION;
     LV_NUM_IDENT GE_CLIENTES.NUM_IDENT%TYPE;
     LV_COD_TIPIDENT GE_CLIENTES.COD_TIPIDENT%TYPE;
   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

         SELECT COUNT(1)
         INTO existe
         FROM GA_LNCELU
         WHERE NUM_SERIE=EN_NUM_SERIE
         AND TIP_LISTA='B';

         IF existe > 0 THEN
           RAISE ERROR_PROCEDIMIENTO;
         END IF;


   EXCEPTION
   WHEN ERROR_PROCEDIMIENTO THEN
             SN_cod_retorno:=4;
             SV_mens_retorno := 'Serie se Encuentra en Listas Negras, no se puede seleccionar.';
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_SERIELN_PR('|| EN_NUM_SERIE  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_SERIELN_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_VALIDA_SERIELN_PR('|| EN_NUM_SERIE  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_VALIDA_SERIELN_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_VALIDA_SERIELN_PR;




PROCEDURE VE_ACTUALIZA_MOVPREACTIVO_PR (EN_NUM_ABONADO       IN GA_ABOCEL.NUM_SERIE%TYPE,
                                             SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)

     IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        UPDATE ICC_MOVIMIENTO
        SET COD_ESTADO=1
        WHERE NUM_ABONADO=EN_NUM_ABONADO
        AND COD_ACTABO in ('ZP', 'ZH');


   EXCEPTION
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_ACTUALIZA_MOVPREACTIVO_PR('|| EN_NUM_ABONADO ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_ACTUALIZA_MOVPREACTIVO_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_ACTUALIZA_MOVPREACTIVO_PR;


PROCEDURE VE_LIBERAR_SERIESYTELEFONO_PR (EN_NumAbonado   IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)

     IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sql       ge_errores_pg.vquery;
     LV_ind_procequi ga_equipaboser.ind_procequi%TYPE;
	 LV_num_seriemec ga_equipaboser.num_seriemec%TYPE;
	 LN_tip_stock ga_equipaboser.tip_stock%TYPE;
     LN_cod_bodega ga_equipaboser.cod_bodega%TYPE;
	 LN_cod_articulo ga_equipaboser.cod_articulo%TYPE;
	 LN_cod_uso ga_equipaboser.cod_uso%TYPE;
     LN_cod_estado ga_equipaboser.cod_estado%TYPE;
	 LN_ind_telefono ga_abocel.ind_telefono%TYPE;
     LN_num_celular ga_abocel.num_celular%TYPE;
	 LV_num_serie ga_equipaboser.num_serie%TYPE;
     LN_PRESTACION      GE_PRESTACIONES_TD.COD_PRESTACION%TYPE;
     LN_IND_PILOTO      GE_PRESTACIONES_TD.IND_NUMPILOTO%TYPE;
     LV_IND_PROCNUM     GA_RESNUMCEL.IND_PROCNUM%TYPE;
     EN_num_venta     ga_ventas.num_venta%TYPE;
     LV_CODSUBALM 	   GA_RESNUMCEL.COD_SUBALM%TYPE;
	 LN_CENTRAL 	 	   GA_RESNUMCEL.COD_CENTRAL%TYPE;
     LN_CATEGORIA 	   GA_RESNUMCEL.COD_CAT%TYPE;
	 LN_USO 		 	   GA_RESNUMCEL.COD_USO%TYPE;
     LV_NumMovimiento VARCHAR2(20);
     LV_IndSerConTel  VARCHAR2(20);
     LN_contador  NUMBER;
     LV_COUNT NUMBER(9);

     CURSOR cursorArticulos IS
     SELECT ind_procequi, num_seriemec, tip_stock, cod_bodega,
     cod_articulo, cod_uso, cod_estado, num_serie
     FROM ga_equipaboser
     WHERE num_abonado = EN_NumAbonado;


        BEGIN

            SN_num_evento   := 0;
            SN_cod_retorno  := 0;
            SV_mens_retorno := '';

            SELECT num_celular, cod_prestacion, num_venta
            INTO LN_num_celular, LN_prestacion , EN_num_venta
            FROM ga_abocel
            WHERE num_abonado = EN_NumAbonado;



                OPEN cursorArticulos;
				LOOP
					FETCH cursorArticulos
					INTO LV_ind_procequi, LV_num_seriemec, LN_tip_stock,
					LN_cod_bodega, LN_cod_articulo, LN_cod_uso,
					LN_cod_estado, LV_num_serie;
					EXIT WHEN cursorArticulos%NOTFOUND;

					IF (LV_num_serie IS NULL OR LV_num_serie ='') THEN
					   LV_num_serie:= LV_num_seriemec;
					END IF;



                    IF LV_ind_procequi<>'E' THEN

					   LV_Sql := 'VE_intermediario_PG.VE_actualiza_stock_PR(5,'
		                          || LN_tip_stock || ','
								  || LN_cod_bodega || ','
					 			  || LN_cod_articulo || ','
					 			  || LN_cod_uso || ','
					 			  || '1' || ','
					 			  || EN_num_venta || ','
					 			  || LV_num_serie || ','
					 			  || LN_ind_telefono || ','
					 			  || LV_NumMovimiento || ','
								  || LV_IndSerConTel || ','
								  || SN_cod_retorno || ','
								  || SV_mens_retorno || ','
					 			  || SN_num_evento || ')';


		    	       -- llamar procedimiento p_GA_INTERAL para desreservar simcard
				       VE_intermediario_PG.VE_actualiza_stock_PR
                                    ('5',
					                LN_tip_stock,
					  				LN_cod_bodega,
					 				LN_cod_articulo,
					 				LN_cod_uso,
					 				'1',
					 				EN_num_venta,
					 				LV_num_serie,
					 				LN_ind_telefono,
									LV_NumMovimiento,
									LV_IndSerConTel,
									SN_cod_retorno,
									SV_mens_retorno,
									SN_num_evento);

					-- Desreserva el articulo
					LV_Sql := 'DELETE'
		           	   || ' FROM ga_reservart'
				   	   || ' WHERE'
					   || ' num_serie =''' || LV_num_serie || '''';

				   DELETE
				   FROM ga_reservart
				   WHERE num_serie = LV_num_serie;
                 END IF;

				END LOOP;

				CLOSE cursorArticulos;

                --Elimina reserva de numero celular
				LN_contador := 0;
				SELECT COUNT(1)
				INTO LN_contador
				FROM ga_resnumcel
				WHERE num_celular = LN_num_celular;

				IF (LN_contador > 0) THEN

                   SELECT IND_PROCNUM
                   INTO LV_IND_PROCNUM
                   FROM GA_RESNUMCEL
                   WHERE NUM_CELULAR=LN_num_celular;


                   SELECT a.cod_subalm, a.cod_central,
			       a.cod_cat, a.cod_uso
		           INTO   LV_codsubalm, LN_central,
		           LN_categoria, LN_uso
		           FROM   ga_resnumcel a
		           WHERE  a.num_celular = LN_num_celular
		           AND ROWNUM <=1;

                   IF LV_IND_PROCNUM<> CV_REPONE_CEL_RES THEN

                      VE_Numeracion_Pg.VE_P_REPONER_NUMERACION_PR(
                      CV_REPONE_CELULAR,
                      LV_codsubalm,
                      LN_central,
                      LN_categoria,
                      LN_uso ,
                      LN_num_celular,
                      SN_COD_RETORNO,
                      SV_MENS_RETORNO,
                      SN_NUM_EVENTO
                       );


			       ELSE

                      VE_Numeracion_Pg.VE_P_REPONER_NUMERACION_PR(
                      CV_REPONE_CEL_RES,
                      LV_codsubalm,
                      LN_central,
                      LN_categoria,
                      LN_uso ,
                      LN_num_celular,
                      SN_COD_RETORNO,
                      SV_MENS_RETORNO,
                      SN_NUM_EVENTO
                      );

					END IF;


				   LV_Sql := 'DELETE'
		           		  || ' FROM ga_resnumcel'
				   		  || ' WHERE'
						  || ' num_celular =' || LN_num_celular;

				   DELETE
				   FROM ga_resnumcel
				   WHERE num_celular = LN_num_celular;

                  IF LV_COUNT<>0 THEN

                     --Verifico si la prestacion obtenida soporta numeros piloto

                     LV_SQL := 'SELECT A.IND_NUMPILOTO '
                          || ' FROM GE_PRESTACIONES_TD A'
   				   		  || ' WHERE'
						  || ' COD_PRESTACION =' || LN_PRESTACION;

                     SELECT  A.IND_NUMPILOTO
                     INTO LN_IND_PILOTO
                     FROM GE_PRESTACIONES_TD A
                     WHERE COD_PRESTACION= LN_PRESTACION;

                     IF LN_IND_PILOTO=1 THEN

                     LV_SQL := 'UPDATE GA_RANGOS_FIJOS_TO SET ESTADO=1'
                          || ' WHERE'
                          || ' NUM_DESDE IN'
                          || ' (SELECT NUM_DESDE'
                          || ' FROM GA_NRO_PILOTO_RANGO_TO'
 						  || ' WHERE NUM_PILOTO =' || LN_num_celular;

                        UPDATE GA_RANGOS_FIJOS_TO
                        SET ESTADO=1
                        WHERE
                        NUM_DESDE IN
                        (SELECT NUM_DESDE
                         FROM GA_NRO_PILOTO_RANGO_TO
                         WHERE NUM_PILOTO= LN_num_celular );

                        LV_SQL := 'DELETE FROM GA_NRO_PILOTO_RANGO_TO'
                          || ' WHERE'
						  || ' NUM_PILOTO =' || LN_num_celular;

                        DELETE FROM
                        GA_NRO_PILOTO_RANGO_TO
                        WHERE NUM_PILOTO= LN_num_celular;
                     END IF;

                  END IF;


				END IF;

           --Actualiza estado del abonado
           update ga_abocel
           set cod_situacion = 'RSV'
           where num_abonado = EN_NumAbonado;

   EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_LIBERAR_SERIESTELEFONO_PR('|| EN_NumAbonado  ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_LIBERAR_SERIESTELEFONO_PR', LV_Sql, SN_cod_retorno, LV_des_error );
   END VE_LIBERAR_SERIESYTELEFONO_PR;


 PROCEDURE VE_obtiene_montoCargoRec_PR(EN_cod_cargo      IN PF_CARGOS_PRODUCTOS_TD.COD_CARGO%TYPE,
                                       SN_monto_importe  OUT NOCOPY PF_CARGOS_PRODUCTOS_TD.MONTO_IMPORTE%TYPE,
                                       SV_cod_moneda     OUT NOCOPY PF_CARGOS_PRODUCTOS_TD.COD_MONEDA%TYPE,
                                       SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)

     IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        SELECT MONTO_IMPORTE, COD_MONEDA
        INTO SN_monto_importe, SV_cod_moneda
        FROM PF_CARGOS_PRODUCTOS_TD
        WHERE COD_CARGO=EN_cod_cargo;

   EXCEPTION
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_obtiene_montoCargoRec_PR('|| EN_cod_cargo ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_obtiene_montoCargoRec_PR', LV_sSql, SN_cod_retorno, LV_des_error );
   END VE_obtiene_montoCargoRec_PR;


   PROCEDURE ve_actualiza_movproductosol_pr (EN_NUM_VENTA       IN GA_ABOCEL.NUM_VENTA%TYPE,
                                             SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

     IS
     LV_des_error  ge_errores_pg.desevent;
     LV_sSql        ge_errores_pg.vquery;

   BEGIN
	    SN_cod_retorno  := 0;
		SV_mens_retorno := NULL;
		SN_num_evento   := 0;

        UPDATE icc_movimiento
        SET cod_estado = 9
        WHERE cod_estado = 1
        AND num_abonado in (
                select num_abonado from ga_abocel where num_venta =  EN_NUM_VENTA
                UNION select num_abonado from ga_aboamist where num_venta =  EN_NUM_VENTA );

   EXCEPTION
   WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:ve_actualiza_movproductosol_pr('|| EN_NUM_VENTA ||'); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             've_actualiza_movproductosol_pr', LV_sSql, SN_cod_retorno, LV_des_error );
   END ve_actualiza_movproductosol_pr;

   PROCEDURE VE_con_rango_descto_usuario_PR(EN_nom_usuario    IN  ve_usuperfil_td.nom_usuario%TYPE,
                                          SN_pnt_dto_inf     OUT NOCOPY ga_perfilcargos.pnt_dto_inf%TYPE,
                                          SN_pnt_dto_sup     OUT NOCOPY ga_perfilcargos.pnt_dto_sup%TYPE,
                                          SN_prc_dto_inf     OUT NOCOPY ga_perfilcargos.prc_dto_inf%TYPE,
                                          SN_prc_dto_sup     OUT NOCOPY ga_perfilcargos.prc_dto_sup%TYPE,
                                          SN_ind_moddtos     OUT NOCOPY ga_perfilcargos.ind_moddtos%TYPE,
                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_con_rango_descto_usuario_PR"
            Lenguaje="PL/SQL"
            Fecha="22-05-2007"
            Version="1.0.0"
            Dise?ador="Héctor Hermosilla"
            Programador="Héctor Hermosilla"
            Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripcion>
            Obtiene rangos e descuentos asociados al vendedor
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_vendedor"    Tipo="NUMBER"> código vendedor</param>
        </Entrada>
        <Salida>
            <param nom="SN_pnt_dto_inf"  Tipo="NUMBER"> rango inferior puntos de posibilidad dcto.</param>
            <param nom="SN_pnt_dto_sup"  Tipo="NUMBER"> rango superior puntos de posibilidad dcto.</param>
            <param nom="SN_prc_dto_inf"  Tipo="NUMBER"> rango inferior porcentaje de dcto. </param>
            <param nom="SN_prc_dto_sup"  Tipo="NUMBER"> rango superior porcentaje de dcto. </param>
            <param nom="SN_prc_dto_sup"  Tipo="NUMBER"> indica si vendedor puede o no modificar descuentos </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_CodeSql     ga_errores.cod_sqlcode%TYPE;
            LV_ErrmSql     ga_errores.cod_sqlerrm%TYPE;
            LN_NumEvento   NUMBER;
            LV_Sql      ge_errores_pg.vQuery;
            LV_des_error ge_errores_pg.DesEvent;
            LV_indTelOut VARCHAR2(20);
        BEGIN

            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_Sql:= 'SELECT perfilusuario.pnt_dto_inf, perfilusuario.pnt_dto_sup, perfilusuario.prc_dto_inf,'
                     || ' perfilusuario.prc_dto_sup,perfilusuario.ind_moddtos'
                     || ' FROM ve_usuperfil_td perfilusuario, ga_perfilcargos perfilcargos'
                     || ' WHERE perfilusuario.nom_usuario = ' || EN_nom_usuario
                     || ' AND perfilcargos.cod_perfil = perfilusuario.cod_perfil'
                     || ' AND SYSDATE BETWEEN perfilusuario.fec_asignacion AND NVL(perfilusuario.fec_desasignac,' || SYSDATE || ')';



            SELECT perfilcargos.pnt_dto_inf, perfilcargos.pnt_dto_sup, perfilcargos.prc_dto_inf,
                   perfilcargos.prc_dto_sup, perfilcargos.ind_moddtos
            INTO  SN_pnt_dto_inf, SN_pnt_dto_sup, SN_prc_dto_inf,
                  SN_prc_dto_sup, SN_ind_moddtos
            FROM ve_usuperfil_td perfilusuario, ga_perfilcargos perfilcargos
            WHERE perfilusuario.nom_usuario = EN_nom_usuario
            AND perfilcargos.cod_perfil = perfilusuario.cod_perfil
            AND SYSDATE BETWEEN perfilusuario.fec_asignacion AND NVL(perfilusuario.fec_desasignac,SYSDATE);

        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                   SN_cod_retorno:=4;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='NO_DATA_FOUND:VE_servicios_venta_PG.VE_con_rango_descto_usuario_PR(' || EN_nom_usuario || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'VE_servicios_venta_PG.VE_con_rango_descto_usuario_PR(' || EN_nom_usuario || ')', LV_Sql, SQLCODE, LV_des_error );
             WHEN OTHERS THEN
                   SN_cod_retorno:=156;
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno:=CV_error_no_clasif;
                  END IF;
                  LV_des_error:='OTHERS:VE_servicios_venta_PG.VE_con_rango_descto_usuario_PR(' || EN_nom_usuario || ');- ' || SQLERRM;
                  SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_modulo_GA,SV_mens_retorno, '1.0', USER,
                  'VE_servicios_venta_PG.VE_con_rango_descto_usuario_PR(' || EN_nom_usuario || ')', LV_Sql, SQLCODE, LV_des_error );
    END VE_con_rango_descto_usuario_PR;

--Iniciio MA-180654 HOM
PROCEDURE VE_GET_ABONADOS_ACTIVOS_PR( EV_NUM_IDENT         GE_CLIENTES.NUM_IDENT%TYPE,
                                      EV_COD_TIPIDENT      GE_CLIENTES.COD_TIPIDENT%TYPE,
                                      SC_cursordatos       OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
IS
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;

    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';


        OPEN SC_cursordatos FOR
                  select b.COD_CLIENTE,b.NUM_CELULAR, b.FEC_ALTA, d.DES_SITUACION, c.IND_ESTVENTA
                  from ge_clientes a, ga_abocel b, ga_ventas c , ga_situabo d
                  where a.NUM_IDENT=EV_NUM_IDENT
                  and a.COD_TIPIDENT=EV_COD_TIPIDENT
                  and b.COD_CLIENTE=a.COD_CLIENTE
                  and b.COD_SITUACION not in ('BAA','BAP')
                  and b.NUM_VENTA=c.num_venta
                  and b.COD_SITUACION=d.COD_SITUACION;


    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:Ve_Servicios_Solicitud_Pg.VE_GET_ABONADOS_ACTIVOS_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'Ve_Servicios_Solicitud_Pg.VE_GET_ABONADOS_ACTIVOS_PR', LV_Sql, SN_cod_retorno, LV_des_error );
    END VE_GET_ABONADOS_ACTIVOS_PR;
    PROCEDURE VE_DATOS_ANEXOTERMINALES_PR( EN_NUM_VENTA        IN GA_VENTAS.NUM_VENTA%TYPE,
                                      SV_NOM_CLIENTE       OUT NOCOPY VARCHAR,
                                      SV_TIP_IDENT         OUT NOCOPY GE_TIPIDENT.DES_TIPIDENT%TYPE,
                                      SV_NUM_IDENT         OUT NOCOPY GE_CLIENTES.NUM_IDENT%TYPE,
                                      SC_cursorterminales  OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)
IS
        LV_Sql      ge_errores_pg.vQuery;
        LV_des_error ge_errores_pg.DesEvent;
    BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        select a.NOM_CLIENTE ||' ' ||a.NOM_APECLIEN1 ||' ' ||a.NOM_APECLIEN2,c.DES_TIPIDENT, a.NUM_IDENT
        into sv_nom_cliente,sv_tip_ident,sv_num_ident
        from ge_clientes a, ga_ventas b, ge_tipident c
        where b.NUM_VENTA=EN_NUM_VENTA
        and a.cod_cliente=b.cod_cliente
        and a.COD_TIPIDENT=c.COD_TIPIDENT;
        OPEN SC_cursorterminales FOR
                SELECT a.DES_EQUIPO,
                       a.NUM_SERIE,
                       d.DES_PLANTARIF,
                       --TRIM(TO_CHAR(a.PRC_VENTA, '999,999,999,999' )) as PRECIO_PAGADO, --JLGN
                       TRIM(TO_CHAR(decode(length(c.TIP_DTO),1,(c.IMP_CARGO - DECODE (c.TIP_DTO,0, c.VAL_DTO,(c.IMP_CARGO * c.VAL_DTO / 100))), c.imp_cargo), '999,999,999,999')) as PRECIO_PAGADO,
                       e.DES_MODVENTA,
                       f.DES_TIPCONTRATO,
                       h.DES_FABRICANTE,
                       g.COD_MODELO,
                       TRIM(TO_CHAR(z.PRC_VENTA, '999,999,999,999' )) as PRECIO_PREPAGO,
                       y.DES_OFICINA,
                       --TRIM(TO_CHAR(z.PRC_VENTA - a.PRC_VENTA,'999,999,999,999' )) as PENALIDAD --JLGN
                       TRIM(TO_CHAR(z.PRC_VENTA - c.IMP_CARGO,'999,999,999,999' )) as PENALIDAD
                from ga_equipaboser a, ga_abocel b, ta_plantarif d, GE_MODVENTA e,
                GA_TIPCONTRATO f, al_fabricantes h, al_articulos g, al_precios_venta z,
                ve_vendedores x, ge_oficinas y, ge_cargos c
                where b.num_venta=EN_NUM_VENTA
                and a.NUM_ABONADO = b.NUM_ABONADO
                and b.num_abonado = c.num_abonado
                and b.num_venta = c.num_venta
                and a.num_serie = c.num_serie
                and a.NUM_SERIE = b.NUM_IMEI
                and a.FEC_ALTA in(select max(fec_alta) from ga_equipaboser c where c.NUM_ABONADO = b.NUM_ABONADO
                and c.NUM_SERIE = b.NUM_IMEI)
                and a.ind_procequi='I'
                and d.COD_PLANTARIF=b.COD_PLANTARIF
                and a.COD_MODVENTA=e.COD_MODVENTA
                and f.COD_TIPCONTRATO=b.COD_TIPCONTRATO
                and g.COD_ARTICULO=a.COD_ARTICULO
                and g.COD_FABRICANTE=h.COD_FABRICANTE
                and z.COD_ARTICULO=g.COD_ARTICULO
                and z.IND_RECAMBIO=0
                and z.cod_uso=3
                and z.cod_estado=1
                AND    SYSDATE    BETWEEN z.FEC_DESDE AND NVL(z.FEC_HASTA, SYSDATE)
				and z.TIP_STOCK = a.TIP_STOCK --Inc. -  24-05-2012 - FADL
                and z.TIP_STOCK in(2,4) --Inc. -  24-05-2012 - FADL
                and z.COD_MODVENTA=1
                and x.COD_VENDEDOR=b.COD_VENDEDOR
                and y.COD_OFICINA = x.COD_OFICINA
				UNION
				SELECT a.DES_EQUIPO,
                       a.NUM_SERIE,
                       d.DES_PLANTARIF,
                       --TRIM(TO_CHAR(a.PRC_VENTA, '999,999,999,999' )) as PRECIO_PAGADO, --JLGN
                       TRIM(TO_CHAR(decode(length(c.TIP_DTO),1,(c.IMP_CARGO - DECODE (c.TIP_DTO,0, c.VAL_DTO,(c.IMP_CARGO * c.VAL_DTO / 100))), c.imp_cargo), '999,999,999,999')) as PRECIO_PAGADO,
                       e.DES_MODVENTA,
                       f.DES_TIPCONTRATO,
                       h.DES_FABRICANTE,
                       g.COD_MODELO,
                       TRIM(TO_CHAR(z.PRC_VENTA, '999,999,999,999' )) as PRECIO_PREPAGO,
                       y.DES_OFICINA,
                       --TRIM(TO_CHAR(z.PRC_VENTA - a.PRC_VENTA,'999,999,999,999' )) as PENALIDAD --JLGN
                       TRIM(TO_CHAR(z.PRC_VENTA - c.IMP_CARGO,'999,999,999,999' )) as PENALIDAD
                from ga_equipaboser a, ga_abocel b, ta_plantarif d, GE_MODVENTA e,
                GA_TIPCONTRATO f, al_fabricantes h, al_articulos g, al_precios_venta z,
                ve_vendedores x, ge_oficinas y, fa_histcargos c
                where b.num_venta=EN_NUM_VENTA
                and a.NUM_ABONADO = b.NUM_ABONADO
                and b.num_abonado = c.num_abonado
                and b.num_venta = c.num_venta
                and a.num_serie = c.num_serie
                and a.NUM_SERIE = b.NUM_IMEI
                and a.FEC_ALTA in(select max(fec_alta) from ga_equipaboser c where c.NUM_ABONADO = b.NUM_ABONADO
                and c.NUM_SERIE = b.NUM_IMEI)
                and a.ind_procequi='I'
                and d.COD_PLANTARIF=b.COD_PLANTARIF
                and a.COD_MODVENTA=e.COD_MODVENTA
                and f.COD_TIPCONTRATO=b.COD_TIPCONTRATO
                and g.COD_ARTICULO=a.COD_ARTICULO
                and g.COD_FABRICANTE=h.COD_FABRICANTE
                and z.COD_ARTICULO=g.COD_ARTICULO
                and z.IND_RECAMBIO=0
                and z.cod_uso=3
                and z.cod_estado=1
                AND    SYSDATE    BETWEEN z.FEC_DESDE AND NVL(z.FEC_HASTA, SYSDATE)
				and z.TIP_STOCK = a.TIP_STOCK --Inc. -  24-05-2012 - FADL
                and z.TIP_STOCK in(2,4) --Inc. -  24-05-2012 - FADL
                and z.COD_MODVENTA=1
                and x.COD_VENDEDOR=b.COD_VENDEDOR
                and y.COD_OFICINA = x.COD_OFICINA;
				
    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno:=4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:Ve_Servicios_Solicitud_Pg.VE_DATOS_ANEXOTERMINALES_PR(); - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'Ve_Servicios_Solicitud_Pg.VE_DATOS_ANEXOTERMINALES_PR', LV_Sql, SN_cod_retorno, LV_des_error );
    END VE_DATOS_ANEXOTERMINALES_PR;
    --Fin MA-180654 HOM
END Ve_Servicios_solicitud_Pg;
/
