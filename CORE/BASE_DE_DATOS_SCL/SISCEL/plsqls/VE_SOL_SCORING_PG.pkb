CREATE OR REPLACE PACKAGE BODY VE_SOL_SCORING_PG AS


 PROCEDURE VE_inserta_solScoring_PR(
    EV_APLICA_TARJETA       IN EV_ENTRADAWS_SCORING_TO.APLICA_TARJETA%TYPE,
    EV_PRIMER_NOMBRE        IN EV_ENTRADAWS_SCORING_TO.PRIMER_NOMBRE%TYPE,
    EV_SEGUNDO_NOMBRE       IN EV_ENTRADAWS_SCORING_TO.SEGUNDO_NOMBRE%TYPE,
    EV_PRIMER_APELLIDO      IN EV_ENTRADAWS_SCORING_TO.PRIMER_APELLIDO%TYPE,
    EV_SEGUNDO_APELLIDO     IN EV_ENTRADAWS_SCORING_TO.SEGUNDO_APELLIDO%TYPE,
    EV_COD_TIPDOCUMENTO     IN EV_ENTRADAWS_SCORING_TO.COD_TIPDOCUMENTO%TYPE,
    EV_NUM_DOCUMENTO        IN EV_ENTRADAWS_SCORING_TO.NUM_DOCUMENTO%TYPE,
    EV_NIT                  IN EV_ENTRADAWS_SCORING_TO.NIT%TYPE,
    EV_FECHA_NACIMIENTO     IN EV_ENTRADAWS_SCORING_TO.FECHA_NACIMIENTO%TYPE,
    EV_CAPACIDAD_PAGO       IN EV_ENTRADAWS_SCORING_TO.CAPACIDAD_PAGO%TYPE,
    EV_ANTIGUEDAD_LABORAL   IN EV_ENTRADAWS_SCORING_TO.ANTIGUEDAD_LABORAL%TYPE,
    EV_TIPO_PRODUCTO        IN EV_ENTRADAWS_SCORING_TO.TIPO_PRODUCTO%TYPE,
    EV_NOMUSUARORA          IN EV_ENTRADAWS_SCORING_TO.NOMUSUARORA%TYPE,
    EV_COD_CLIENTE          IN EV_ENTRADAWS_SCORING_TO.COD_CLIENTE%TYPE,
    EV_COD_TIPO_TARJETA     IN EV_ENTRADAWS_SCORING_TO.COD_TIPO_TARJETA%TYPE,
    EV_COD_NACIONALIDAD     IN EV_ENTRADAWS_SCORING_TO.COD_NACIONALIDAD%TYPE,
    EV_COD_NIVEL_ACADEMICO  IN EV_ENTRADAWS_SCORING_TO.COD_NIVEL_ACADEMICO%TYPE,
    EV_COD_ESTADO_CIVIL     IN EV_ENTRADAWS_SCORING_TO.COD_ESTADO_CIVIL%TYPE,
    EV_COD_TIPO_EMPRESA     IN EV_ENTRADAWS_SCORING_TO.COD_TIPO_EMPRESA%TYPE,
    EV_DES_TIPO_TARJETA     IN EV_ENTRADAWS_SCORING_TO.DES_TIPO_TARJETA%TYPE,
    EV_DES_NACIONALIDAD     IN EV_ENTRADAWS_SCORING_TO.DES_NACIONALIDAD%TYPE,
    EV_DES_NIVEL_ACADEMICO  IN EV_ENTRADAWS_SCORING_TO.DES_NIVEL_ACADEMICO%TYPE,
    EV_DES_ESTADO_CIVIL     IN EV_ENTRADAWS_SCORING_TO.DES_ESTADO_CIVIL%TYPE,
    EV_DES_TIPO_EMPRESA     IN EV_ENTRADAWS_SCORING_TO.DES_TIPO_EMPRESA%TYPE,
    EV_DES_TIPDOCUMENTO     IN EV_ENTRADAWS_SCORING_TO.DES_TIPDOCUMENTO%TYPE,
    EV_NUM_TARJETA          IN EV_ENTRADAWS_SCORING_TO.NUM_TARJETA%TYPE,
    EV_COD_BANCOTARJ        IN EV_ENTRADAWS_SCORING_TO.COD_BANCOTARJ%TYPE,
    EV_MES_VENCITARJ        IN EV_ENTRADAWS_SCORING_TO.MES_VENCITARJ%TYPE,
    EV_ANIO_VENCITARJ       IN EV_ENTRADAWS_SCORING_TO.ANIO_VENCITARJ%TYPE,
    EV_COD_TIPTARJETASCL    IN EV_ENTRADAWS_SCORING_TO.COD_TIPTARJETASCL%TYPE,
    SN_NUM_SOL_SCORING      OUT EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
    SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        SELECT EV_ENTRADAWS_SCORING_SQ.NEXTVAL INTO SN_NUM_SOL_SCORING FROM DUAL;

        INSERT INTO EV_ENTRADAWS_SCORING_TO a (
            a.NUM_SOLSCORING,
            a.APLICA_TARJETA,
            a.FECHA_CREACION,
            a.PRIMER_NOMBRE,
            a.SEGUNDO_NOMBRE,
            a.PRIMER_APELLIDO,
            a.SEGUNDO_APELLIDO,
            a.COD_TIPDOCUMENTO,
            a.NUM_DOCUMENTO,
            a.NIT,
            a.FECHA_NACIMIENTO,
            a.CAPACIDAD_PAGO,
            a.ANTIGUEDAD_LABORAL,
            a.TIPO_PRODUCTO,
            a.NOMUSUARORA,
            a.COD_CLIENTE,
            a.COD_TIPO_TARJETA,
            a.COD_NACIONALIDAD,
            a.COD_NIVEL_ACADEMICO,
            a.COD_ESTADO_CIVIL,
            a.COD_TIPO_EMPRESA,
            a.DES_TIPO_TARJETA,
            a.DES_NACIONALIDAD,
            a.DES_NIVEL_ACADEMICO,
            a.DES_ESTADO_CIVIL,
            a.DES_TIPO_EMPRESA,
            a.DES_TIPDOCUMENTO,
            a.NUM_TARJETA,
            a.COD_BANCOTARJ,
            a.MES_VENCITARJ,
            a.ANIO_VENCITARJ,
            a.COD_TIPTARJETASCL
             )
        VALUES (
                SN_NUM_SOL_SCORING,
                EV_APLICA_TARJETA,
                SYSDATE,
                EV_PRIMER_NOMBRE,
                EV_SEGUNDO_NOMBRE,
                EV_PRIMER_APELLIDO,
                EV_SEGUNDO_APELLIDO,
                EV_COD_TIPDOCUMENTO,
                EV_NUM_DOCUMENTO,
                EV_NIT,
                EV_FECHA_NACIMIENTO,
                EV_CAPACIDAD_PAGO,
                EV_ANTIGUEDAD_LABORAL,
                EV_TIPO_PRODUCTO,
                EV_NOMUSUARORA,
                EV_COD_CLIENTE,
                EV_COD_TIPO_TARJETA,
                EV_COD_NACIONALIDAD,
                EV_COD_NIVEL_ACADEMICO,
                EV_COD_ESTADO_CIVIL,
                EV_COD_TIPO_EMPRESA,
                EV_DES_TIPO_TARJETA,
                EV_DES_NACIONALIDAD,
                EV_DES_NIVEL_ACADEMICO,
                EV_DES_ESTADO_CIVIL,
                EV_DES_TIPO_EMPRESA,
                EV_DES_TIPDOCUMENTO,
                EV_NUM_TARJETA,
                EV_COD_BANCOTARJ,
                EV_MES_VENCITARJ,
                EV_ANIO_VENCITARJ,
                EV_COD_TIPTARJETASCL
         );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_solScoring_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_solScoring_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_inserta_solScoring_PR;



PROCEDURE VE_obtiene_SolicitudScoring_PR (EN_CODVENDEDOR   IN EV_DATOSGENER_SCORING_TO.COD_VENDEDOR%TYPE,
                                          EN_NUMSOLSCORING IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
                                          EV_CODOFICINA    IN EV_DATOSGENER_SCORING_TO.COD_OFICINA%TYPE,
                                          EV_FECDESDE      IN VARCHAR2,
                                          EV_FECHASTA      IN VARCHAR2,
                                          EN_COD_CLIENTE   IN EV_ENTRADAWS_SCORING_TO.COD_CLIENTE%TYPE,
                                          EV_ESTADOSOL     IN EV_ESTADOSSCORING_TO.COD_ESTADO%TYPE,
                                          SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
                                          SN_COD_RETORNO   OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                          SV_MENS_RETORNO  OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                          SN_NUM_EVENTO    OUT NOCOPY GE_ERRORES_PG.EVENTO) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_SolicitudScoring_PR"
            Lenguaje="PL/SQL"
            Fecha="07-08-2008"
            Version="1.0.0"
            Ambiente="BD"
        <Retorno>
            cursor
        </Retorno>
        <Descripcion>
            Obtiene Listado solicitudes scoring segun parametros de busqueda
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_codVendedor"   Tipo="NUMBER"> codigo vendedor </param>
            <param nom="EN_numVenta"      Tipo="NUMBER"> numero de venta </param>
            <param nom="EV_codOficina"    Tipo="NUMBER"> codigo oficina </param>
            <param nom="EV_fecDesde"      Tipo="STRING"> fecha desde</param>
            <param nom="EV_fecHasta"      Tipo="STRING"> fecha hasta </param>
        </Entrada>
        <Salida>
            <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor ventas </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
            LV_des_Error ge_errores_pg.desevent;
            LV_sql         ge_errores_pg.vquery;
            LV_sql2         ge_errores_pg.vquery;
            LV_sql3         ge_errores_pg.vquery;
            LV_sql5         ge_errores_pg.vquery;
            LE_ERROR_VENTA EXCEPTION;
            LN_contador  NUMBER;
            LB_and       BOOLEAN;
        BEGIN

            SN_num_evento   := 0;
            SN_cod_retorno  := 0;
            SV_mens_retorno := '';

            LB_and  := FALSE;

            LV_sql2 := ' SELECT a.num_solscoring, a.fecha_creacion, '
                    || ' a.primer_nombre,a.segundo_nombre,a.primer_apellido,a.segundo_apellido,c.nom_vendedor AS NOMBRE_VENDEDOR,'
                    || ' b.cod_oficina,b.cod_vendedor,a.cod_cliente,a.nit,b.cod_modventa,b.cod_tipcontrato,f.nom_vendealer,b.cod_cuota,b.cod_vendealer, b.cod_tipcomis,g.cod_estado, h.des_valor';
            LV_sql3 := ' FROM ev_entradaws_scoring_to a,ev_datosgener_scoring_to b ,ve_vendedores c, ge_oficinas d, ve_vendealer f, ev_estadosscoring_to g, ged_codigos h'
                    || ' WHERE ';

            IF (EN_NUMSOLSCORING <> 0) THEN
                LV_sql3 := LV_sql3 || ' a.num_solscoring = ' || EN_NUMSOLSCORING;
                LB_and  := TRUE;
            END IF;

            IF (EN_codVendedor <> 0) THEN
               IF (LB_and = FALSE) THEN
                      LV_sql3 := LV_sql3 || ' b.cod_vendedor = ' || EN_codVendedor;
                    LB_and  := TRUE;
               ELSE
                      LV_sql3 := LV_sql3 || ' AND b.cod_vendedor = ' || EN_codVendedor;
               END IF;
            END IF;

            IF (EV_codOficina <> '0') THEN
               IF (LB_and = FALSE) THEN
                   LV_sql3 := LV_sql3 || ' b.cod_oficina = ''' || EV_codOficina || '''';
                    LB_and  := TRUE;
               ELSE
                   LV_sql3 := LV_sql3 || ' AND b.cod_oficina = ''' || EV_codOficina || '''';
               END IF;
            END IF;


            IF (EN_COD_CLIENTE <> 0 ) THEN
                IF (LB_and = FALSE) THEN
                    LV_sql3 := LV_sql3 || ' a.cod_cliente = ' || EN_COD_CLIENTE;
                    LB_and  := TRUE;
                ELSE
                    LV_sql3 := LV_sql3 || ' AND  a.cod_cliente = ' || EN_COD_CLIENTE;
                END IF;
            END IF;



            IF ( EV_ESTADOSOL IS NOT NULL AND LENGTH(TRIM(EV_ESTADOSOL)) > 0 AND EV_ESTADOSOL <> '0') THEN
                    IF (LB_and = FALSE) THEN
                        LV_sql3 := LV_sql3 || ' g.cod_estado = ''' || EV_ESTADOSOL || '''';
                        LB_and  := TRUE;
                    ELSE
                        LV_sql3 := LV_sql3 || ' AND g.cod_estado = ''' || EV_ESTADOSOL || '''';
                    END IF;
            END IF;


            IF EV_fecDesde IS NOT NULL AND EV_fecHasta IS NOT NULL THEN
                IF (LB_and = FALSE) THEN
                    LV_sql3 := LV_sql3 || ' a.fecha_creacion between TO_DATE(''' || EV_fecDesde || ''',''DD-MM-YYYY'')'
                                       || ' AND TO_DATE(''' || EV_fecHasta || ' 235900' || ''',''DD-MM-YYYY HH24MISS'')';
                    LB_and  := TRUE;
                ELSE
                    LV_sql3 := LV_sql3 || ' AND a.fecha_creacion between TO_DATE(''' || EV_fecDesde || ''',''DD-MM-YYYY'')'
                                       || ' AND TO_DATE(''' || EV_fecHasta || ' 235900' || ''',''DD-MM-YYYY HH24MISS'')';
                END IF;
            END IF;


            LV_sql3 := LV_sql3 || ' AND a.num_solscoring = b.num_solscoring'
                               || ' AND b.cod_vendedor = c.cod_vendedor'
                               || ' AND b.cod_oficina = d.cod_oficina'
                               || ' AND b.cod_vendealer = f.cod_vendealer(+)'
                               || ' AND a.num_solscoring = g.num_solscoring'
                               || ' AND h.nom_tabla = ''EV_ESTADOSSCORING_TO'' '
                               || ' AND g.cod_estado = h.cod_valor '
                               || ' AND g.fecha_termino is null';

            LB_and  := FALSE;

            LV_sql5 := ' ORDER BY a.num_solscoring DESC';
            LV_sql := LV_sql2 || LV_sql3 || LV_sql5;
            OPEN SC_cursordatos FOR LV_Sql;

        EXCEPTION
            WHEN LE_ERROR_VENTA THEN
                 SN_cod_retorno := 156;

                 LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_obtiene_SolicitudScoring_PR('|| EN_codVendedor ||'); - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno,'1.0', USER,
                 'VE_SOL_SCORING_PG.VE_obtiene_SolicitudScoring_PR',LV_Sql,SN_cod_retorno,LV_des_error);

            WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error    := SUBSTR('OTHERS:Ve_Servicios_Venta_Pg.VE_obtiene_SolicitudScoring_PR('|| EN_codVendedor ||'); - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno,'1.0', USER,
                 'VE_SOL_SCORING_PG.VE_obtiene_SolicitudScoring_PR',LV_Sql,SN_cod_retorno,LV_des_error);
    END VE_obtiene_SolicitudScoring_PR;

    PROCEDURE VE_insert_datGenerScoring_PR(
			EV_NUM_SOLSCORING      IN EV_DATOSGENER_SCORING_TO.NUM_SOLSCORING%TYPE,
			EV_COD_OFICINA       	IN EV_DATOSGENER_SCORING_TO.COD_OFICINA%TYPE,
			EV_COD_TIPCOMIS        	IN EV_DATOSGENER_SCORING_TO.COD_TIPCOMIS%TYPE,
			EV_COD_MODVENTA       	IN EV_DATOSGENER_SCORING_TO.COD_MODVENTA%TYPE,
			EV_COD_TIPCONTRATO      IN EV_DATOSGENER_SCORING_TO.COD_TIPCONTRATO%TYPE,
			EV_COD_CUOTA     		IN EV_DATOSGENER_SCORING_TO.COD_CUOTA%TYPE,
			EV_COD_VENDEDOR     	IN EV_DATOSGENER_SCORING_TO.COD_VENDEDOR%TYPE,
			EV_COD_VENDEALER        IN EV_DATOSGENER_SCORING_TO.COD_VENDEALER%TYPE,
			EV_COD_AGENTE           IN EV_DATOSGENER_SCORING_TO.COD_AGENTE%TYPE,
            EV_COD_PERIODO          IN EV_DATOSGENER_SCORING_TO.COD_PERIODO%TYPE,
            EV_MONTO_PREAUTORIZADO  IN EV_DATOSGENER_SCORING_TO.MONTO_PREAUTORIZADO%TYPE,
            EV_FACTURA_TERCERO      IN EV_DATOSGENER_SCORING_TO.FACTURA_TERCERO%TYPE,
            EV_IND_VTA_EXTERNA      IN EV_DATOSGENER_SCORING_TO.IND_VTA_EXTERNA%TYPE,
			SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
			SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
			SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        INSERT INTO EV_DATOSGENER_SCORING_TO a (
            a.NUM_SOLSCORING,
            a.COD_OFICINA,
            a.COD_TIPCOMIS,
            a.COD_MODVENTA,
            a.COD_TIPCONTRATO,
            a.COD_CUOTA,
            a.COD_VENDEDOR,
            a.COD_VENDEALER,
            a.COD_AGENTE,
            a.COD_PERIODO, a.MONTO_PREAUTORIZADO, a.FACTURA_TERCERO, a.IND_VTA_EXTERNA )
        VALUES (
            EV_NUM_SOLSCORING,
            EV_COD_OFICINA,
            EV_COD_TIPCOMIS,
            EV_COD_MODVENTA,
            EV_COD_TIPCONTRATO,
            EV_COD_CUOTA,
            EV_COD_VENDEDOR,
            EV_COD_VENDEALER,
            EV_COD_AGENTE, EV_COD_PERIODO, EV_MONTO_PREAUTORIZADO, EV_FACTURA_TERCERO, EV_IND_VTA_EXTERNA
          );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_datosGenerScoring_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_datosGenerScoring_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_insert_datGenerScoring_PR;

     PROCEDURE VE_inserta_estadoScoring_PR(EV_NUM_SOLSCORING    IN EV_DATOSGENER_SCORING_TO.NUM_SOLSCORING%TYPE,
			                               EV_COD_ESTADO        IN EV_ESTADOSSCORING_TO.COD_ESTADO%TYPE,
			                               EV_COD_VENDEDOR      IN EV_DATOSGENER_SCORING_TO.COD_VENDEDOR%TYPE,
			                               SN_cod_retorno       OUT NOCOPY ge_errores_pg.CodError,
			                               SV_mens_retorno      OUT NOCOPY ge_errores_pg.MsgError,
			                               SN_num_evento        OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    LV_EXISTE_ESTADOORIGEN NUMBER(8);
    LV_COD_ESTADOORIGEN VE_ESTADOSOLIC_TD.COD_ESTADOORIGEN%TYPE;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        LV_EXISTE_ESTADOORIGEN := 0;


        SELECT COUNT(*) INTO LV_EXISTE_ESTADOORIGEN
        FROM  EV_ESTADOSSCORING_TO a
        WHERE a.FECHA_TERMINO IS NULL
        AND a.NUM_SOLSCORING = EV_NUM_SOLSCORING;

        IF (LV_EXISTE_ESTADOORIGEN > 0) THEN

            UPDATE EV_ESTADOSSCORING_TO a SET a.FECHA_TERMINO = SYSDATE
            WHERE a.FECHA_TERMINO IS NULL
            AND a.NUM_SOLSCORING = EV_NUM_SOLSCORING;

        END IF;

        INSERT INTO EV_ESTADOSSCORING_TO a (
            a.NUM_SOLSCORING, a.COD_ESTADO,
            a.FECHA_INICIO, a.FECHA_TERMINO, a.COD_VENDEDOR
            )
        VALUES (
            EV_NUM_SOLSCORING, EV_COD_ESTADO,
            sysdate, null, EV_COD_VENDEDOR
        );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_estadoScoring_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_estadoScoring_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_inserta_estadoScoring_PR;


    PROCEDURE VE_obtiene_SolicitudScoring_PR (
										EV_NUM_SOLSCORING IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
										SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
										SN_COD_RETORNO   OUT NOCOPY GE_ERRORES_PG.CODERROR,
										SV_MENS_RETORNO  OUT NOCOPY GE_ERRORES_PG.MSGERROR,
										SN_NUM_EVENTO    OUT NOCOPY GE_ERRORES_PG.EVENTO) IS
		LV_des_Error ge_errores_pg.desevent;
		LV_sql         ge_errores_pg.vquery;
		LE_ERROR_VENTA EXCEPTION;
	BEGIN
		SN_num_evento   := 0;
		SN_cod_retorno  := 0;
		SV_mens_retorno := '';


        LV_sql := 'SELECT a.NUM_SOLSCORING, a.APLICA_TARJETA, a.COD_TIPO_TARJETA,
a.FECHA_CREACION, a.PRIMER_NOMBRE, a.SEGUNDO_NOMBRE, a.PRIMER_APELLIDO,
a.SEGUNDO_APELLIDO, a.COD_TIPDOCUMENTO, a.NUM_DOCUMENTO, a.NIT, a.FECHA_NACIMIENTO,
a.CAPACIDAD_PAGO, a.COD_NACIONALIDAD, a.COD_NIVEL_ACADEMICO,
a.COD_ESTADO_CIVIL, a.COD_TIPO_EMPRESA, a.ANTIGUEDAD_LABORAL,
a.TIPO_PRODUCTO, a.NOMUSUARORA, a.COD_CLIENTE, a.DES_ESTADO_CIVIL,
a.DES_NACIONALIDAD, a.DES_TIPO_EMPRESA, a.DES_NIVEL_ACADEMICO, a.DES_TIPO_TARJETA, a.DES_TIPDOCUMENTO, a.NUM_TARJETA,
a.COD_BANCOTARJ, a.MES_VENCITARJ, a.ANIO_VENCITARJ, a.COD_TIPTARJETASCL,
b.COD_OFICINA, b.COD_TIPCOMIS, b.COD_MODVENTA, b.COD_TIPCONTRATO, b.COD_CUOTA,
b.COD_VENDEDOR, b.COD_VENDEALER, b.COD_AGENTE, b.COD_PERIODO, c.COD_ESTADO, c.COD_VENDEDOR, d.DES_VALOR, b.IND_VTA_EXTERNA
FROM EV_ENTRADAWS_SCORING_TO a, EV_DATOSGENER_SCORING_TO b, EV_ESTADOSSCORING_TO c, GED_CODIGOS d
WHERE a.NUM_SOLSCORING = b.NUM_SOLSCORING
AND a.NUM_SOLSCORING = c.NUM_SOLSCORING
AND d.NOM_TABLA = ''EV_ESTADOSSCORING_TO''
AND c.COD_ESTADO = d.COD_VALOR
AND c.FECHA_TERMINO is null
AND a.NUM_SOLSCORING = ' ||  EV_NUM_SOLSCORING;


    OPEN SC_cursordatos FOR LV_Sql;

	EXCEPTION
		WHEN LE_ERROR_VENTA THEN
				SN_cod_retorno 	:= 200;
				LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_obtiene_SolicitudScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_obtiene_SolicitudScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
		WHEN OTHERS THEN
				SN_cod_retorno 	:= 300;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
					SV_mens_retorno := CV_error_no_clasIF;
				END IF;
				LV_des_error    := SUBSTR('OTHERS:Ve_Servicios_Venta_Pg.VE_obtiene_SolicitudScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_obtiene_SolicitudScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
END VE_obtiene_SolicitudScoring_PR;

    PROCEDURE VE_obtiene_RepSolScoring_PR (
										EV_NUM_SOLSCORING       IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
                                        EV_CANTIDAD_LINEAS      OUT NOCOPY NUMBER,
                                        EV_CANTIDAD_PLANESTARIF OUT NOCOPY NUMBER,
                                        EV_CANTIDAD_SERVSP      OUT NOCOPY NUMBER,
										SC_CURSORDATOS          OUT NOCOPY REFCURSOR,
                                        SC_CURSORPLANESTARIF    OUT NOCOPY REFCURSOR,
										SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
										SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
										SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO) IS
		LV_des_Error ge_errores_pg.desevent;
		LV_sql         ge_errores_pg.vquery;
        LV_sql2         ge_errores_pg.vquery;
		LE_ERROR_VENTA EXCEPTION;
	BEGIN
		SN_num_evento   := 0;
		SN_cod_retorno  := 0;
		SV_mens_retorno := '';


        EV_CANTIDAD_LINEAS := 0;
        EV_CANTIDAD_PLANESTARIF := 0;
        EV_CANTIDAD_SERVSP := 0;

        SELECT COUNT(1)
        INTO EV_CANTIDAD_LINEAS
        FROM ev_prestsolic_scoring_to a
        WHERE a.num_solscoring = EV_NUM_SOLSCORING;

        SELECT COUNT(1)
        INTO EV_CANTIDAD_PLANESTARIF
        FROM ev_prestsolic_scoring_to a
        WHERE a.num_solscoring = EV_NUM_SOLSCORING;

        SELECT COUNT(1)
        INTO EV_CANTIDAD_SERVSP
        FROM ev_ss_scoring_to a
        WHERE a.num_solscoring = EV_NUM_SOLSCORING;

        LV_sql := 'SELECT a.NUM_SOLSCORING, a.APLICA_TARJETA, a.COD_TIPO_TARJETA,a.FECHA_CREACION, a.PRIMER_NOMBRE,
        a.SEGUNDO_NOMBRE, a.PRIMER_APELLIDO, a.SEGUNDO_APELLIDO, a.COD_TIPDOCUMENTO, a.NUM_DOCUMENTO, a.NIT, a.FECHA_NACIMIENTO,
        a.CAPACIDAD_PAGO, a.COD_NACIONALIDAD, a.COD_NIVEL_ACADEMICO,a.COD_ESTADO_CIVIL, a.COD_TIPO_EMPRESA, a.ANTIGUEDAD_LABORAL,
        a.TIPO_PRODUCTO, a.NOMUSUARORA, a.COD_CLIENTE, a.DES_ESTADO_CIVIL,a.DES_NACIONALIDAD, a.DES_TIPO_EMPRESA,
        a.DES_NIVEL_ACADEMICO, a.DES_TIPO_TARJETA, a.DES_TIPDOCUMENTO, b.COD_OFICINA, b.COD_TIPCOMIS, b.COD_MODVENTA,
        b.COD_TIPCONTRATO, b.COD_CUOTA,b.COD_VENDEDOR, b.COD_VENDEALER, b.COD_AGENTE, b.COD_PERIODO, c.COD_ESTADO,
        c.COD_VENDEDOR, d.DES_VALOR, b.IND_VTA_EXTERNA, e.nom_vendedor, f.CLASIFICACION
        FROM EV_ENTRADAWS_SCORING_TO a, EV_DATOSGENER_SCORING_TO b, EV_ESTADOSSCORING_TO c,
        GED_CODIGOS d, VE_VENDEDORES e, EV_SALIDAWS_SCORING_TO f
        WHERE a.NUM_SOLSCORING = b.NUM_SOLSCORING
        AND a.NUM_SOLSCORING = c.NUM_SOLSCORING
        AND a.NUM_SOLSCORING = f.NUM_SOLSCORING
        AND d.NOM_TABLA  = ''EV_ESTADOSSCORING_TO''
        AND c.COD_ESTADO = d.COD_VALOR
        AND b.COD_VENDEDOR = e.COD_VENDEDOR
        AND a.NUM_SOLSCORING = ' ||  EV_NUM_SOLSCORING;-- = ''SE''
        --AND c.COD_ESTADO IN (''SE'' ,''RS'')

        OPEN SC_cursordatos FOR LV_Sql;

        if(EV_CANTIDAD_PLANESTARIF > 0 ) THEN

        LV_sql2 := 'SELECT DISTINCT a.cod_plantarif || ''  '' || b.des_plantarif
                    FROM ev_prestsolic_scoring_to a, ta_plantarif b
                    WHERE a.cod_plantarif = b.cod_plantarif
                    AND NUM_SOLSCORING = '||  EV_NUM_SOLSCORING;

        OPEN SC_CURSORPLANESTARIF FOR LV_Sql2;

        END IF;



	EXCEPTION
		WHEN LE_ERROR_VENTA THEN
				SN_cod_retorno 	:= 200;
				LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_obtiene_RepSolScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_obtiene_RepSolScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
		WHEN OTHERS THEN
				SN_cod_retorno 	:= 300;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
					SV_mens_retorno := CV_error_no_clasIF;
				END IF;
				LV_des_error    := SUBSTR('OTHERS:Ve_Servicios_Venta_Pg.VE_obtiene_RepSolScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_obtiene_RepSolScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
END VE_obtiene_RepSolScoring_PR;

    PROCEDURE VE_obtiene_EstSolScoring_PR (
										EV_NUM_SOLSCORING IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
										SC_CURSORDATOS   OUT NOCOPY REFCURSOR,
										SN_COD_RETORNO   OUT NOCOPY GE_ERRORES_PG.CODERROR,
										SV_MENS_RETORNO  OUT NOCOPY GE_ERRORES_PG.MSGERROR,
										SN_NUM_EVENTO    OUT NOCOPY GE_ERRORES_PG.EVENTO) IS
		LV_des_Error ge_errores_pg.desevent;
		LV_sql         ge_errores_pg.vquery;
		LE_ERROR_VENTA EXCEPTION;
	BEGIN
		SN_num_evento   := 0;
		SN_cod_retorno  := 0;
		SV_mens_retorno := '';


        LV_sql := 'SELECT c.COD_ESTADO, d.DES_VALOR, c.FECHA_INICIO, c.FECHA_TERMINO, c.COD_VENDEDOR
        FROM EV_ENTRADAWS_SCORING_TO a, EV_DATOSGENER_SCORING_TO b, EV_ESTADOSSCORING_TO c, GED_CODIGOS d, VE_VENDEDORES e
        WHERE a.NUM_SOLSCORING = b.NUM_SOLSCORING
        AND a.NUM_SOLSCORING   = c.NUM_SOLSCORING
        AND d.NOM_TABLA        = ''EV_ESTADOSSCORING_TO''
        AND c.COD_ESTADO       = d.COD_VALOR
        AND b.COD_VENDEDOR     = e.COD_VENDEDOR
        AND a.NUM_SOLSCORING   = ' ||  EV_NUM_SOLSCORING ||
        ' ORDER BY c.FECHA_INICIO';

        --OPEN SC_cursordatos FOR LV_Sql;

        OPEN SC_cursordatos FOR
            SELECT
                c.COD_ESTADO, d.DES_VALOR, c.FECHA_INICIO, c.FECHA_TERMINO,
                c.COD_VENDEDOR
            FROM
                EV_ENTRADAWS_SCORING_TO a, EV_DATOSGENER_SCORING_TO b,
                EV_ESTADOSSCORING_TO c, GED_CODIGOS d, VE_VENDEDORES e
            WHERE
                a.NUM_SOLSCORING = b.NUM_SOLSCORING
                AND a.NUM_SOLSCORING = c.NUM_SOLSCORING
                AND d.NOM_TABLA = 'EV_ESTADOSSCORING_TO'
                AND c.COD_ESTADO = d.COD_VALOR
                AND b.COD_VENDEDOR = e.COD_VENDEDOR
                AND a.NUM_SOLSCORING = EV_NUM_SOLSCORING
            ORDER BY
                c.FECHA_INICIO;

	EXCEPTION
		WHEN LE_ERROR_VENTA THEN
				SN_cod_retorno 	:= 200;
				LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_obtiene_EstSolScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_obtiene_EstSolScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
		WHEN OTHERS THEN
				SN_cod_retorno 	:= 300;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
					SV_mens_retorno := CV_error_no_clasIF;
				END IF;
				LV_des_error    := SUBSTR('OTHERS:Ve_Servicios_Venta_Pg.VE_obtiene_EstSolScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_obtiene_EstSolScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
END VE_obtiene_EstSolScoring_PR;

    PROCEDURE VE_update_SolScoring_PR (
	    EV_NUM_SOLSCORING   IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
        EV_CAPACIDAD_PAGO   IN EV_ENTRADAWS_SCORING_TO.CAPACIDAD_PAGO%TYPE,
        EV_TIPO_PRODUCTO    IN EV_ENTRADAWS_SCORING_TO.TIPO_PRODUCTO%TYPE,
		SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
		SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
		SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO)
		IS
		LV_des_Error 		ge_errores_pg.desevent;
		LV_sql         		ge_errores_pg.vquery;
		BEGIN
			SN_num_evento   := 0;
			SN_cod_retorno  := 0;
			SV_mens_retorno := '';

			UPDATE EV_ENTRADAWS_SCORING_TO a SET
			a.CAPACIDAD_PAGO = EV_CAPACIDAD_PAGO,
			a.TIPO_PRODUCTO = EV_TIPO_PRODUCTO
			WHERE num_solscoring = EV_NUM_SOLSCORING;

	EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 100;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_Error  := 'VE_SOL_SCORING_PG.VE_update_SolScoring_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_update_SolScoring_PR',  LV_sql, SQLCODE, LV_des_Error);

END VE_update_SolScoring_PR;


PROCEDURE VE_obtiene_lineasSolScoring_PR (EN_NUMSOLSCORING IN EV_ENTRADAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
                                          SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_lineasSolScoring_PR"
            Lenguaje="PL/SQL"
            Fecha="26-05-2010"
            Version="1.0.0"
            Ambiente="BD"
        <Retorno>
            cursor
        </Retorno>
        <Descripcion>
            Obtiene Listado lineas asociadas a la solicitud de scoring
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_NUMSOLSCORING"   Tipo="NUMBER"> codigo vendedor </param>
        </Entrada>
        <Salida>
            <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor ventas </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;

    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql := 'SELECT a.num_lineascoring'
                   ||',a.cod_central'
                   ||',a.cod_prestacion'
                   ||',b.grp_prestacion'
                   ||',a.cod_plantarif'
                   ||',a.cod_uso'
                   ||' FROM ev_prestsolic_scoring_to a, ge_prestaciones_td b'
                   ||' WHERE a.num_solscoring ='|| EN_NUMSOLSCORING
                   ||' and a.cod_prestacion=b.cod_prestacion';


        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ev_prestsolic_scoring_to a
        WHERE a.num_solscoring = EN_NUMSOLSCORING
        AND ROWNUM <= 1;

        OPEN SC_cursordatos FOR


        SELECT a.num_lineascoring
              ,a.cod_central
              ,a.cod_prestacion
              ,b.grp_prestacion
              ,a.cod_plantarif
              ,a.cod_uso
              ,b.des_prestacion
              ,c.des_plantarif
        FROM  ev_prestsolic_scoring_to a, ge_prestaciones_td b, ta_plantarif c
        WHERE a.num_solscoring = EN_NUMSOLSCORING
        and a.cod_prestacion= b.cod_prestacion
        and a.cod_plantarif = c.cod_plantarif
        and a.REPLICADO='NO';

        IF (LN_contador = 0) THEN
            RAISE no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_obtiene_lineasSolScoring_PR(); - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno,'1.0', USER,
                 'VE_SOL_SCORING_PG.VE_obtiene_lineasSolScoring_PR',LV_sSql,SN_cod_retorno,LV_des_error);
    END VE_obtiene_lineasSolScoring_PR;


     PROCEDURE VE_inserta_lineaScoring_PR(
    EV_COD_ARTICULO             IN ev_prestsolic_scoring_to.COD_ARTICULO%TYPE,
    EV_COD_CELDA                IN ev_prestsolic_scoring_to.COD_CELDA%TYPE,
    EV_COD_CENTRAL              IN ev_prestsolic_scoring_to.COD_CENTRAL%TYPE,
    EV_COD_DEPARTAMENTO         IN ev_prestsolic_scoring_to.COD_DEPARTAMENTO%TYPE,
    EV_COD_MONEDACARGOBASICO    IN ev_prestsolic_scoring_to.COD_MONEDACARGOBASICO%TYPE,
    EV_COD_MONEDASEGURO         IN ev_prestsolic_scoring_to.COD_MONEDASEGURO%TYPE,
    EV_COD_MUNICIPIO            IN ev_prestsolic_scoring_to.COD_MUNICIPIO%TYPE,
    EV_COD_PLANSERV             IN ev_prestsolic_scoring_to.COD_PLANSERV%TYPE,
    EV_COD_PLANTARIF            IN ev_prestsolic_scoring_to.COD_PLANTARIF%TYPE,
    EV_COD_PRESTACION           IN ev_prestsolic_scoring_to.COD_PRESTACION%TYPE,
    EV_COD_SEGURO               IN ev_prestsolic_scoring_to.COD_SEGURO%TYPE,
    EV_COD_USO                  IN ev_prestsolic_scoring_to.COD_USO%TYPE,
    EV_COD_ZONA                 IN ev_prestsolic_scoring_to.COD_ZONA%TYPE,
    EV_IMPORTE_CARGOBASICO      IN ev_prestsolic_scoring_to.IMPORTE_CARGOBASICO%TYPE,
    EV_IMPORTE_EQUIPO           IN ev_prestsolic_scoring_to.IMPORTE_EQUIPO%TYPE,
    EV_IMPORTE_SEGURO           IN ev_prestsolic_scoring_to.IMPORTE_SEGURO%TYPE,
    EV_NUM_SOLSCORING           IN ev_prestsolic_scoring_to.NUM_SOLSCORING%TYPE,
    EV_COD_TECNOLOGIA           IN  ev_prestsolic_scoring_to.COD_TECNOLOGIA%TYPE,
    EV_COD_SUBALM               IN  ev_prestsolic_scoring_to.COD_SUBALM%TYPE,
    EV_COD_CAUSAVENTA           IN  ev_prestsolic_scoring_to.COD_CAUSAVENTA%TYPE,
    EV_COD_CAMPANA              IN  ev_prestsolic_scoring_to.COD_CAMPANA%TYPE,
    EV_COD_LIMCONSUMO           IN  ev_prestsolic_scoring_to.COD_LIMCONSUMO%TYPE,
    EV_IND_RENOVA               IN  ev_prestsolic_scoring_to.IND_RENOVA%TYPE,
    EV_TIP_TERMINAL             IN ev_prestsolic_scoring_to.TIP_TERMINAL%TYPE,
    EV_COD_CALIFICACION         IN ev_prestsolic_scoring_to.COD_CALIFICACION%TYPE,
    EN_IMP_LIMCONS              IN ev_prestsolic_scoring_to.IMP_LIMCONS%TYPE,
    SN_NUM_LINEASCORING         OUT ev_prestsolic_scoring_to.NUM_LINEASCORING%TYPE,
    SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento               OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        SELECT ev_prestsolic_scoring_SQ.NEXTVAL INTO SN_NUM_LINEASCORING FROM DUAL;

        INSERT INTO ev_prestsolic_scoring_to a (
                a.COD_ARTICULO,
                a.COD_CELDA,
                a.COD_CENTRAL,
                a.COD_DEPARTAMENTO,
                a.COD_MONEDACARGOBASICO,
                a.COD_MONEDASEGURO,
                a.COD_MUNICIPIO,
                a.COD_PLANSERV,
                a.COD_PLANTARIF,
                a.COD_PRESTACION,
                a.COD_SEGURO,
                a.COD_USO,
                a.COD_ZONA,
                a.IMPORTE_CARGOBASICO,
                a.IMPORTE_EQUIPO,
                a.IMPORTE_SEGURO,
                a.NUM_LINEASCORING,
                a.NUM_SOLSCORING,
                a.COD_TECNOLOGIA,
                a.COD_SUBALM,
                a.REPLICADO,
                a.COD_CAUSAVENTA,
                a.COD_CAMPANA,
                a.COD_LIMCONSUMO,
                a.IND_RENOVA,
                a.TIP_TERMINAL,
                a.COD_CALIFICACION,
                a.IMP_LIMCONS)
        VALUES (
                EV_COD_ARTICULO,
                EV_COD_CELDA,
                EV_COD_CENTRAL,
                EV_COD_DEPARTAMENTO,
                EV_COD_MONEDACARGOBASICO,
                EV_COD_MONEDASEGURO,
                EV_COD_MUNICIPIO,
                EV_COD_PLANSERV,
                EV_COD_PLANTARIF,
                EV_COD_PRESTACION,
                EV_COD_SEGURO,
                EV_COD_USO,
                EV_COD_ZONA,
                EV_IMPORTE_CARGOBASICO,
                EV_IMPORTE_EQUIPO,
                EV_IMPORTE_SEGURO,
                SN_NUM_LINEASCORING,
                EV_NUM_SOLSCORING,
                EV_COD_TECNOLOGIA,
                EV_COD_SUBALM,
                'NO',
                EV_COD_CAUSAVENTA,
                EV_COD_CAMPANA,
                EV_COD_LIMCONSUMO,
                EV_IND_RENOVA,
                EV_TIP_TERMINAL,
                EV_COD_CALIFICACION,
                EN_IMP_LIMCONS
         );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_lineaScoring_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_lineaScoring_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_inserta_lineaScoring_PR;

   PROCEDURE VE_inserta_salidaScoring_PR(
            EV_NUM_SOLSCORING           IN EV_SALIDAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
            EV_MENSAJE                  IN EV_SALIDAWS_SCORING_TO.MENSAJE%TYPE,
            EV_REFERENCIA               IN EV_SALIDAWS_SCORING_TO.REFERENCIA%TYPE,
            EV_CLASIFICACION            IN EV_SALIDAWS_SCORING_TO.CLASIFICACION%TYPE,
            EV_PUNTEO                   IN EV_SALIDAWS_SCORING_TO.PUNTEO%TYPE,
            SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
            SN_num_evento               OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        INSERT INTO EV_SALIDAWS_SCORING_TO a (
                a.NUM_SOLSCORING,
                a.MENSAJE ,
                a.REFERENCIA ,
                a.CLASIFICACION,
                a.PUNTEO)
        VALUES (
                EV_NUM_SOLSCORING,
                EV_MENSAJE ,
                EV_REFERENCIA ,
                EV_CLASIFICACION,
                EV_PUNTEO
         );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_salidaScoring_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_salidaScoring_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_inserta_salidaScoring_PR;

 PROCEDURE VE_obtiene_lineaScoring_PR (EN_NUMLINEASCORING IN EV_PRESTSOLIC_SCORING_TO.NUM_LINEASCORING%TYPE,
                                       SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                       SC_cursorSS      OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentacion TipoDoc = "Procedimiento">
            Elemento Nombre = "VE_obtiene_lineaScoring_PR "
            Lenguaje="PL/SQL"
            Fecha="26-05-2010"
            Version="1.0.0"
            Ambiente="BD"
        <Retorno>
            cursor
        </Retorno>
        <Descripcion>
            Obtiene Listado lineas asociadas a la solicitud de scoring
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_NUMSOLSCORING"   Tipo="NUMBER"> codigo vendedor </param>
        </Entrada>
        <Salida>
            <param nom="SV_cursorDatos"   Tipo="CURSOR"> cursor ventas </param>
            <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"  Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

       no_data_found_cursor      EXCEPTION;
       LV_des_error ge_errores_pg.DesEvent;
       LV_sSql      ge_errores_pg.vQuery;
       LN_contador      NUMBER;

    BEGIN

        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        LV_sSql := 'SELECT a.num_solscoring'
                   ||',a.cod_departamento'
                   ||',a.cod_municipio'
                   ||',a.cod_zona'
                   ||',a.cod_celda'
                   ||',a.cod_central'
                   ||',a.cod_prestacion'
                   ||',a.cod_plantarif'
                   ||',a.cod_uso'
                   ||',a.cod_planserv'
                   ||',a.cod_articulo'
                   ||',a.cod_seguro'
                   ||',a.cod_tecnologia'
                   ||',a.cod_subalm'
                   ||',b.grp_prestacion'
                   ||',a.tip_terminal'
                   ||' FROM ev_prestsolic_scoring_to a'
                   ||' WHERE a.num_lineascoring ='|| EN_NUMLINEASCORING;

        LN_contador := 0;
        SELECT COUNT(1)
        INTO LN_contador
        FROM ev_prestsolic_scoring_to a
        WHERE a.num_lineascoring = EN_NUMLINEASCORING
        AND ROWNUM <= 1;

        OPEN SC_cursordatos FOR


        SELECT a.num_solscoring
              ,a.cod_departamento
              ,a.cod_municipio
              ,a.cod_zona
              ,a.cod_celda
              ,a.cod_central
              ,a.cod_prestacion
              ,a.cod_plantarif
              ,a.cod_uso
              ,a.cod_planserv
              ,a.cod_articulo
              ,a.cod_seguro
              ,a.cod_tecnologia
              ,a.cod_subalm
              ,b.grp_prestacion
              ,a.tip_terminal
              ,a.cod_limconsumo
              ,a.imp_limcons
        FROM  ev_prestsolic_scoring_to a, ge_prestaciones_td b
        WHERE a.num_lineascoring = EN_NUMLINEASCORING
        and a.cod_prestacion=b.cod_prestacion;


        OPEN SC_cursorSS FOR

        SELECT a.num_solscoring
              ,a.cod_servicio
        FROM  ev_ss_scoring_to a
        WHERE a.num_lineascoring = EN_NUMLINEASCORING;


        IF (LN_contador = 0) THEN
            RAISE no_data_found_cursor;
        END IF;

        EXCEPTION
            WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                 IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasIF;
                 END IF;
                 LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_obtiene_lineaScoring_PR(); - '|| SQLERRM,1,CN_largoerrtec);
                 SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
                 SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno,'1.0', USER,
                 'VE_SOL_SCORING_PG.VE_obtiene_lineaScoring_PR',LV_sSql,SN_cod_retorno,LV_des_error);
    END VE_obtiene_lineaScoring_PR ;



    PROCEDURE VE_updLineaScoring_PR(EN_NUMLINEASCORING IN EV_PRESTSOLIC_SCORING_TO.NUM_LINEASCORING%TYPE,
                                    EN_NUMABONADO      IN EV_PRESTSOLIC_SCORING_TO.NUM_ABONADO%TYPE,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS

            LV_des_error ge_errores_pg.DesEvent;
            LV_sSql      ge_errores_pg.vQuery;
			EV_COD_Seguro	  EV_PRESTSOLIC_SCORING_TO.COD_SEGURO%TYPE;
			EV_IMPORTE_SEGURO EV_PRESTSOLIC_SCORING_TO.IMPORTE_SEGURO%TYPE;
			EV_NON_USUARORA   VARCHAR(30);
			EV_FEC_ALTA DATE;
    BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';


            LV_sSql := 'UPDATE ev_prestsolic_scoring_to'
                       ||' SET replicado = ' || 'SI'
                       ||' , num_abonado = ' ||  EN_NUMABONADO
                       ||' WHERE num_lineascoring = ' || EN_NUMLINEASCORING;

            UPDATE ev_prestsolic_scoring_to
            SET replicado = 'SI' , num_abonado = EN_NUMABONADO
            WHERE num_lineascoring = EN_NUMLINEASCORING;

  			LV_sSql :=  'Select  Distinct a.COD_Seguro, a.IMPORTE_SEGURO,b.NOM_USUARORA,b.FEC_ALTA'
		   				||' INTO    EV_COD_Seguro, EV_IMPORTE_SEGURO,EV_NON_USUARORA'
					    ||' from    EV_PRESTSOLIC_SCORING_TO a,GA_ABOCEL b'
					    ||' WHERE   a.NUM_Abonado ='|| EN_NUMABONADO
					    ||' AND     b.NUM_Abonado=a.NUM_Abonado'
					    ||' AND 	   num_lineascoring ='|| EN_NUMLINEASCORING;

		   Select  Distinct a.COD_Seguro, a.IMPORTE_SEGURO,b.NOM_USUARORA,b.FEC_ALTA
		   INTO    EV_COD_Seguro, EV_IMPORTE_SEGURO,EV_NON_USUARORA,EV_FEC_ALTA
		   from    EV_PRESTSOLIC_SCORING_TO a,GA_ABOCEL b
		   WHERE   a.NUM_Abonado = EN_NUMABONADO
		   AND     b.NUM_Abonado=a.NUM_Abonado
		   AND 	   num_lineascoring = EN_NUMLINEASCORING;

		   LV_sSql := 'INSERT INTO GA_SEGUROABONADO_TO (NUM_Abonado, COD_Seguro, IMPORTE_EQUIPO, FEC_ALTA, FEC_FINCONTRATO, FEC_MODIFICACION, NOM_USUARORA)'
		   ||' VALUES ('||EN_NUMABONADO||', '||EV_COD_Seguro||','|| EV_IMPORTE_SEGURO||','||EV_FEC_ALTA||', TO_DATE(31/12/3000,DD-MM-YYYY),'||EV_FEC_ALTA||','||EV_NON_USUARORA||');';

		   -- Se realiza el insert para la tabla de Seguros
		   INSERT INTO GA_SEGUROABONADO_TO (NUM_Abonado, COD_Seguro, IMPORTE_EQUIPO, FEC_ALTA, FEC_FINCONTRATO, FEC_MODIFICACION, NOM_USUARORA)
		   VALUES (EN_NUMABONADO, EV_COD_Seguro, EV_IMPORTE_SEGURO, EV_FEC_ALTA, TO_DATE('31/12/3000','DD-MM-YYYY'), EV_FEC_ALTA, EV_NON_USUARORA);


 		   LV_des_error :=LV_sSql;

    EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_updLineaScoring_PR; - '|| SQLERRM,1,CN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_updLineaScoring_PR', LV_sSql, SN_cod_retorno, LV_des_error );
    END VE_updLineaScoring_PR;

    PROCEDURE VE_inserta_solScoringVta_PR(EN_NUM_SOLSCORING           IN EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                          EN_NUM_VENTA                IN EV_SOLSCORING_VENTA_TO.NUM_VENTA%TYPE,
                                          SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento               OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        INSERT INTO EV_SOLSCORING_VENTA_TO a (
                a.NUM_SOLSCORING ,
                a.NUM_VENTA)
        VALUES (
                EN_NUM_SOLSCORING ,
                EN_NUM_VENTA
         );

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_solScoringVta_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_solScoringVta_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_inserta_solScoringVta_PR;


    PROCEDURE VE_OBTIENE_ESTADOSDESTINO_PR (EV_COD_PROGRAMA         IN  VE_ESTADOSOLIC_TD.COD_PROGRAMA%TYPE,
                                            EV_COD_ESTADOORIGEN     IN  VE_ESTADOSOLIC_TD.COD_ESTADOORIGEN%TYPE,
                                            EV_NOM_TABLA            IN  GED_CODIGOS.NOM_TABLA%TYPE,
                                            SC_cursorDatos          OUT NOCOPY REFCURSOR,
                                            SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS

        LV_des_Error    ge_errores_pg.desevent;
		LV_sql          ge_errores_pg.vquery;


        BEGIN

        SN_num_evento   := 0;
		SN_cod_retorno  := 0;
		SV_mens_retorno := '';


        LV_sql := 'SELECT a.COD_ESTADODESTINO, b.DES_VALOR AS DES_ESTADODESTINO
                    FROM  VE_ESTADOSOLIC_TD a, GED_CODIGOS b
                    WHERE a.COD_PROGRAMA = ' || EV_COD_PROGRAMA ||
                    'AND a.COD_ESTADODESTINO = b.COD_VALOR
                     AND a.cod_estadoorigen = ' || EV_COD_ESTADOORIGEN ||
                    ' AND b.NOM_TABLA = ' || EV_NOM_TABLA ||
                    ' AND a.IND_VIGENCIA = 1';

        OPEN SC_cursordatos
            FOR SELECT a.COD_ESTADODESTINO, b.DES_VALOR AS DES_ESTADODESTINO
                    FROM  VE_ESTADOSOLIC_TD a, GED_CODIGOS b
                    WHERE a.COD_PROGRAMA = EV_COD_PROGRAMA
                    AND a.COD_ESTADODESTINO = b.COD_VALOR
                    AND a.cod_estadoorigen = EV_COD_ESTADOORIGEN
                    AND b.NOM_TABLA = EV_NOM_TABLA
                    AND a.IND_VIGENCIA = 1;

	    EXCEPTION
		    WHEN OTHERS THEN
				SN_cod_retorno 	:= 300;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
					SV_mens_retorno := CV_error_no_clasIF;
				END IF;
				LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_OBTIENE_ESTADOSDESTINO_PR('|| EV_COD_ESTADOORIGEN ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_OBTIENE_ESTADOSDESTINO_PR', LV_Sql, SN_cod_retorno, LV_des_error);

        END VE_OBTIENE_ESTADOSDESTINO_PR;


PROCEDURE VE_calcula_capacidadpago_PR(EN_NUM_SOLSCORING     IN EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                      SN_CAPACIDAD_PAGO     OUT NOCOPY EV_ENTRADAWS_SCORING_TO.CAPACIDAD_PAGO%TYPE,
                                      SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno       OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento         OUT NOCOPY ge_errores_pg.Evento) IS

        LV_des_Error    ge_errores_pg.desevent;
		LV_sql          ge_errores_pg.vquery;

        importe_cargo_basico NUMBER(14,4);
        importe_seguro NUMBER(14,4);
        importe_ss NUMBER(14,4);
        importe_pa NUMBER(14,4);
        ingreso_cliente NUMBER(14,4);


        BEGIN

        SN_num_evento   := 0;
		SN_cod_retorno  := 0;
		SV_mens_retorno := '';

        SELECT DECODE(imp_ingresos, 0, 1, imp_ingresos)
        INTO ingreso_cliente
        from EV_ENTRADAWS_SCORING_TO a,  GE_CLIENTES b
        where a.num_solscoring = EN_NUM_SOLSCORING
        AND a.cod_cliente = b.cod_cliente;

        SELECT SUM(a.importe_cargobasico), SUM(a.importe_seguro)
        INTO importe_cargo_basico, importe_seguro
        from EV_PRESTSOLIC_SCORING_TO a
        where  a.num_solscoring = EN_NUM_SOLSCORING;

        SELECT NVL(SUM(a.IMPORTE_MENSUAL), 0)
        INTO importe_ss
        from EV_SS_SCORING_TO a
        WHERE a.num_solscoring = EN_NUM_SOLSCORING;

        SELECT NVL(SUM(importe_recurrente), 0)
        INTO importe_pa
        FROM EV_PA_SCORING_TO a
        WHERE a.num_solscoring = EN_NUM_SOLSCORING;


        SN_CAPACIDAD_PAGO := ( (importe_cargo_basico + importe_ss  + importe_pa + importe_seguro) / ingreso_cliente ) * 100;

        UPDATE EV_ENTRADAWS_SCORING_TO a
        SET a.CAPACIDAD_PAGO = SN_CAPACIDAD_PAGO
        WHERE a.NUM_SOLSCORING = EN_NUM_SOLSCORING;


	    EXCEPTION
		    WHEN OTHERS THEN
				SN_cod_retorno 	:= 300;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
					SV_mens_retorno := CV_error_no_clasIF;
				END IF;
				LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_calcula_capacidadpago_PR('|| EN_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_calcula_capacidadpago_PR', LV_Sql, SN_cod_retorno, LV_des_error);

        END VE_calcula_capacidadpago_PR;

        PROCEDURE VE_inserta_ServSup_PR(
            EV_NUM_SOLSCORING           IN EV_SS_SCORING_TO.NUM_SOLSCORING%TYPE,
			EV_NUM_LINEASCORING         IN EV_SS_SCORING_TO.NUM_LINEASCORING%TYPE,
            EV_COD_SERVICIO             IN EV_SS_SCORING_TO.COD_SERVICIO%TYPE,
            EV_IMPORTE_MENSUAL          IN EV_SS_SCORING_TO.IMPORTE_MENSUAL%TYPE,
			EV_COD_MONEDA_MENSUAL       IN EV_SS_SCORING_TO.COD_MONEDA_MENSUAL%TYPE,
            EV_IMPORTE_CONEXION         IN EV_SS_SCORING_TO.IMPORTE_CONEXION%TYPE,
			EV_COD_MONEDA_CONEXION      IN EV_SS_SCORING_TO.COD_MONEDA_CONEXION%TYPE,
            SN_cod_retorno              OUT NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno             OUT NOCOPY ge_errores_pg.MsgError,
            SN_num_evento               OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

      INSERT INTO EV_SS_SCORING_TO a (
                a.NUM_SOLSCORING,
                a.NUM_LINEASCORING,
                a.COD_SERVICIO,
                a.IMPORTE_MENSUAL,
                a.COD_MONEDA_MENSUAL,
                a.IMPORTE_CONEXION,
                a.COD_MONEDA_CONEXION)
        VALUES (
                EV_NUM_SOLSCORING,
                EV_NUM_LINEASCORING,
                EV_COD_SERVICIO,
                EV_IMPORTE_MENSUAL,
                EV_COD_MONEDA_MENSUAL,
                EV_IMPORTE_CONEXION,
                EV_COD_MONEDA_CONEXION);

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_ServSup_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_ServSup_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_inserta_ServSup_PR;


    PROCEDURE VE_OBTIENE_NUMVENTA_PR ( EN_NUM_SOLSCORING       IN EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                       SN_NUM_VENTA            OUT NOCOPY EV_SOLSCORING_VENTA_TO.NUM_VENTA%TYPE,
                                       SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS



    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        select num_venta
        into  SN_NUM_VENTA
        from EV_SOLSCORING_VENTA_TO a
        where  a.NUM_SOLSCORING = EN_NUM_SOLSCORING;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_OBTIENE_NUMVENTA_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_OBTIENE_NUMVENTA_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_OBTIENE_NUMVENTA_PR;


    PROCEDURE VE_OBTIENE_NUMSCORING_PR ( EN_NUM_VENTA            IN  EV_SOLSCORING_VENTA_TO.NUM_VENTA%TYPE,
                                       SN_NUM_SOLSCORING       OUT NOCOPY EV_SOLSCORING_VENTA_TO.NUM_SOLSCORING%TYPE,
                                       SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento           OUT NOCOPY ge_errores_pg.Evento) IS



    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        select num_solscoring
        into  SN_NUM_SOLSCORING
        from EV_SOLSCORING_VENTA_TO a
        where  a.NUM_VENTA = EN_NUM_VENTA;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_OBTIENE_NUMVENTA_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_OBTIENE_NUMVENTA_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_OBTIENE_NUMSCORING_PR;

    PROCEDURE VE_obt_estScoring_X_tarjeta_PR (
        EV_COD_TIPTARJETASCL    IN EV_ENTRADAWS_SCORING_TO.COD_TIPTARJETASCL%TYPE,
        EV_NUM_TARJETA          IN EV_ENTRADAWS_SCORING_TO.NUM_TARJETA%TYPE,
        SC_CURSORDATOS          OUT NOCOPY REFCURSOR,
        SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento)
    IS
        LV_des_Error            ge_errores_pg.desevent;
		LV_sql                  ge_errores_pg.vquery;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        LV_sql :=
            'SELECT
                b.num_solscoring,
                b.COD_ESTADO,
                c.DES_VALOR,
                b.FECHA_INICIO,
                b.FECHA_TERMINO,
                b.COD_VENDEDOR,
                d.NOM_VENDEDOR
            FROM
                EV_ENTRADAWS_SCORING_TO a,
                EV_ESTADOSSCORING_TO b,
                GED_CODIGOS c,
                VE_VENDEDORES d
            WHERE 0=0
            AND a.NUM_SOLSCORING = b.NUM_SOLSCORING
            AND b.COD_VENDEDOR = d.COD_VENDEDOR
            AND b.COD_ESTADO = c.COD_VALOR
            AND b.COD_ESTADO NOT IN (''CA'',''PR'')
            AND c.NOM_TABLA = ''EV_ESTADOSSCORING_TO''
            AND c.NOM_COLUMNA = ''COD_ESTADO''
            AND a.NUM_TARJETA = ''' || EV_NUM_TARJETA || '''
            AND a.COD_TIPTARJETASCL = ''' || EV_COD_TIPTARJETASCL || '''';


        OPEN SC_cursordatos FOR LV_Sql;

    EXCEPTION
        WHEN OTHERS THEN
            SN_cod_retorno 	:= 300;
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
            END IF;
            LV_des_error    := SUBSTR('OTHERS:Ve_Servicios_Venta_Pg.VE_obt_estScoring_X_tarjeta_PR('|| EV_NUM_TARJETA   ||'); - '|| SQLERRM, 1, CN_largoerrtec);
            SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
            SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
            'VE_SOL_SCORING_PG.VE_obt_estScoring_X_tarjeta_PR', LV_Sql, SN_cod_retorno, LV_des_error);
    END VE_obt_estScoring_X_tarjeta_PR;

   PROCEDURE VE_get_ResultadoScoring_PR (
	    EV_NUM_SOLSCORING   IN EV_SALIDAWS_SCORING_TO.NUM_SOLSCORING%TYPE,
		SC_CURSORDATOS      OUT NOCOPY REFCURSOR,
		SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
		SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
		SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO)
    IS

		LV_des_Error        ge_errores_pg.desevent;
		LV_sql              ge_errores_pg.vquery;
		LE_ERROR_VENTA      EXCEPTION;

	BEGIN
		SN_num_evento   := 0;
		SN_cod_retorno  := 0;
		SV_mens_retorno := '';

        LV_sql := 'SELECT
            a.CLASIFICACION,
            a.MENSAJE,
            a.NUM_SOLSCORING,
            a.PUNTEO,
            a.REFERENCIA
        FROM EV_SALIDAWS_SCORING_TO a
        WHERE
            a.NUM_SOLSCORING = ' || EV_NUM_SOLSCORING;


    OPEN SC_cursordatos FOR
        SELECT
            a.CLASIFICACION,
            a.MENSAJE,
            a.NUM_SOLSCORING,
            a.PUNTEO,
            a.REFERENCIA
        FROM EV_SALIDAWS_SCORING_TO a
        WHERE
            a.NUM_SOLSCORING = EV_NUM_SOLSCORING;

	EXCEPTION
		WHEN LE_ERROR_VENTA THEN
				SN_cod_retorno 	:= 200;
				LV_des_error    := SUBSTR('OTHERS:VE_SOL_SCORING_PG.VE_get_ResultadoScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_get_ResultadoScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
		WHEN OTHERS THEN
				SN_cod_retorno 	:= 300;
				IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
					SV_mens_retorno := CV_error_no_clasIF;
				END IF;
				LV_des_error    := SUBSTR('OTHERS:Ve_Servicios_Venta_Pg.VE_get_ResultadoScoring_PR('|| EV_NUM_SOLSCORING ||'); - '|| SQLERRM, 1, CN_largoerrtec);
				SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_largodesc);
				SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo, SV_mens_retorno,'1.0', USER,
				'VE_SOL_SCORING_PG.VE_get_ResultadoScoring_PR', LV_Sql, SN_cod_retorno, LV_des_error);
    END VE_get_ResultadoScoring_PR;


    PROCEDURE VE_inserta_PA_PR( EV_NUM_SOLSCORING      IN EV_PA_SCORING_TO.NUM_SOLSCORING%TYPE,
			                    EV_NUM_LINEASCORING    IN EV_PA_SCORING_TO.NUM_LINEASSCORING%TYPE,
                                EN_COD_PROD_OFERTADO   IN EV_PA_SCORING_TO.COD_PROD_OFERTADO%TYPE,
                                EN_CANTIDAD            IN EV_PA_SCORING_TO.CANTIDAD%TYPE,
                                EN_COD_CLIENTE         IN EV_ENTRADAWS_SCORING_TO.COD_CLIENTE%TYPE,
                                SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento          OUT NOCOPY ge_errores_pg.Evento) IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;
    SC_CURSORDATOS refcursor;
    LV_COD_CANAL      VARCHAR2(2);
    LN_COD_CARGO      EV_PA_SCORING_TO.COD_CARGO_CONTRATADO%TYPE;
    LN_MONTO_IMPORTE  EV_PA_SCORING_TO.IMPORTE_RECURRENTE%TYPE;
    LV_COD_MONEDA     EV_PA_SCORING_TO.COD_MONEDA%TYPE;
    LN_COD_CONCEPTO   EV_PA_SCORING_TO.COD_CONCEPTO%TYPE;
    LV_TIPO_CARGO     VARCHAR2(5);

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';

        LV_COD_CANAL:=CN_VENTA;

      --Busca los cargos asociados al producto ofertado

      PF_CARGOS_PRODUCTOS_PG.PF_CARGO_PRODUCTO_S_PR (EN_COD_PROD_OFERTADO,LV_COD_CANAL,SC_CURSORDATOS,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        LOOP
            FETCH SC_CURSORDATOS
            INTO  LN_COD_CARGO, LN_COD_CONCEPTO ,LN_MONTO_IMPORTE, LV_COD_MONEDA, LV_TIPO_CARGO;
            EXIT WHEN SC_CURSORDATOS%NOTFOUND;

            INSERT INTO EV_PA_SCORING_TO a (
            a.NUM_SOLSCORING,
            a.NUM_LINEASSCORING,
            a.COD_CARGO_CONTRATADO,
            a.IMPORTE_RECURRENTE,
            a.NIVEL,
            a.COD_MONEDA,
            a.COD_CLIENTE,
            a.CANTIDAD,
            a.COD_PROD_OFERTADO,
            a.COD_CONCEPTO )
            VALUES (
            EV_NUM_SOLSCORING,
            EV_NUM_LINEASCORING,
            LN_COD_CARGO,
            LN_MONTO_IMPORTE,
            'A', -- A:Nivel abonado, C:Nivel Cliente
            LV_COD_MONEDA,
            EN_COD_CLIENTE,
            EN_CANTIDAD,
            EN_COD_PROD_OFERTADO,
            LN_COD_CONCEPTO );

        END LOOP;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_inserta_PA_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_inserta_PA_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_inserta_PA_PR;


    PROCEDURE VE_consulta_PA_PR(EN_NUM_SOLSCORING      IN EV_PA_SCORING_TO.NUM_SOLSCORING%TYPE,
			                    SV_EXISTEN_PLANES      OUT NOCOPY VARCHAR2,
                                SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento          OUT NOCOPY ge_errores_pg.Evento)
    IS


    LV_desError ge_errores_pg.desevent;
    LV_sql ge_errores_pg.vquery;
    LN_contador      NUMBER;

    BEGIN
        SN_num_evento   := 0;
        SN_cod_retorno  := 0;
        SV_mens_retorno := '';
        SV_EXISTEN_PLANES := 'FALSE';

        SELECT COUNT(1) INTO  LN_contador
        FROM EV_PA_SCORING_TO
        WHERE num_solscoring = EN_NUM_SOLSCORING;

        IF (LN_contador > 0 ) THEN
            SV_EXISTEN_PLANES := 'TRUE';
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 4;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno, SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_desError  := 'VE_SOL_SCORING_PG.VE_consulta_PA_PR;- ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, cv_cod_modulo, SV_mens_retorno, '1.0', USER,
             'VE_SOL_SCORING_PG.VE_consulta_PA_PR',  LV_sql, SQLCODE, LV_desError);

    END VE_consulta_PA_PR;

END VE_SOL_SCORING_PG;
/
SHOW ERRORS