CREATE OR REPLACE PACKAGE BODY VE_intermediario_PG IS

    FUNCTION VE_descompone_cadena_FN(EV_cadena         IN VARCHAR2,
                                         EN_largosubstring IN NUMBER,
                                                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento)
                                                                         RETURN tipoArray
        IS
        /*--
        <Documentación TipoDoc = "Funcion">
                Elemento Nombre = "VE_descompone_servicios_FN"
                Lenguaje="PL/SQL"
                Fecha="21-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Descompone cadena de servicios : 6 caracteres
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_cadena" Tipo="VARCHAR2"> cadena de entrada</param>
        </Entrada>
        <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LA_arregloSalida tipoArray := tipoArray();

        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;

        iCont     INTEGER;
        iPos      INTEGER;
        LV_cadena VARCHAR2(4500);

        BEGIN

            LV_sql := EV_cadena;

                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                IF (LENGTH(EV_cadena) < EN_largosubstring) THEN
                        LV_cadena := '0';
                        LA_arregloSalida(1) := LV_cadena;
                ELSE
                        LV_cadena := EV_cadena;
                END IF;

                iCont := 0;
                iPos  := EN_largosubstring;

                LOOP
                        IF (iPos = 0) THEN
                                EXIT;
                        END IF;
                        iCont := iCont + 1;

                        LA_arregloSalida.extend;
                        LA_arregloSalida(iCont) := TRIM(SUBSTR(LV_cadena,1,iPos));
            LV_cadena := TRIM(SUBSTR(LV_cadena,iPos+1,LENGTH(LV_cadena)));

                        IF (LV_cadena = '' OR LENGTH(LV_cadena) < EN_largosubstring OR LV_cadena IS NULL) THEN
                                iPos := 0;
                        ELSE
                                iPos := EN_largosubstring;
                        END IF;

                END LOOP;

                RETURN LA_arregloSalida;

        EXCEPTION
                         WHEN OTHERS THEN
                        SN_cod_retorno := 156;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                            SV_mens_retorno:=CV_error_no_clasif;
                        END IF;
                        LV_des_error:='OTHERS:VE_intermediario_PG.VE_descompone_cadena_FN;- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                        'VE_intermediario_PG.VE_descompone_cadena_FN', LV_Sql, SQLCODE, LV_des_error );
                                                RETURN NULL;
        END VE_descompone_cadena_FN;

        FUNCTION VE_descompone_cadena_FN(EV_cadena         IN VARCHAR2,
                                         EV_separador      IN VARCHAR2,
                                                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN tipoArray IS
        /*--
        <Documentación TipoDoc = "Funcion">
                Elemento Nombre = "VE_descompone_cadena_FN"
                Lenguaje="PL/SQL"
                Fecha="21-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Descompone cadena en campos. Caracter separador "/"
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_cadena" Tipo="VARCHAR2"> cadena de entrada</param>
        </Entrada>
        <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LA_arregloSalida tipoArray := tipoArray();

        CV_SEPARADOR CONSTANT CHAR := EV_separador;

        iCont     INTEGER;
        iPos      INTEGER;
        bExiste   BOOLEAN;
        LV_cadena VARCHAR2(300);
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
        BEGIN
            LV_sql := EV_cadena;

                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                IF (substr(EV_cadena,LENGTH(EV_cadena),1) = CV_SEPARADOR) THEN
                        LV_cadena := EV_cadena || '0';
                ELSE
                        LV_cadena := EV_cadena;
                END IF;

                iCont := 0;
                iPos  := INSTR(LV_cadena,CV_SEPARADOR);
                IF (iPos = 1) THEN
                        LV_cadena := TRIM(SUBSTR(LV_cadena,iPos+1,LENGTH(LV_cadena)));
                        iPos := INSTR(LV_cadena,CV_SEPARADOR);
                        bExiste := TRUE;
                ELSE
                        bExiste := FALSE;
                END IF;

                LOOP
                        IF (iPos = 0) THEN
                                EXIT;
                        END IF;

                        bExiste := TRUE;
                        iCont := iCont + 1;

                        LA_arregloSalida.extend;
                        LA_arregloSalida(iCont) := TRIM(SUBSTR(LV_cadena,1,iPos-1));
                        LV_cadena := TRIM(SUBSTR(LV_cadena,iPos+1,LENGTH(LV_cadena)));
                        iPos := INSTR(LV_cadena,CV_SEPARADOR);
                END LOOP;

                IF (bExiste) THEN
                        iCont := iCont + 1;
                        LA_arregloSalida.extend;
                        LA_arregloSalida(iCont) := TRIM(LV_cadena);
                END IF;

                RETURN LA_arregloSalida;

        EXCEPTION
                         WHEN OTHERS THEN
                        SN_cod_retorno := 156;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                            SV_mens_retorno:=CV_error_no_clasif;
                        END IF;
                        LV_des_error:='OTHERS:VE_intermediario_PG.VE_descompone_cadena_FN;- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                        'VE_intermediario_PG.VE_descompone_cadena_FN', LV_Sql, SQLCODE, LV_des_error );
                                            RETURN NULL;
        END VE_descompone_cadena_FN;

        FUNCTION VE_ObtieneFormatoFecha_FN(SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN VARCHAR2 IS
        /*--
        <Documentación TipoDoc = "Función">
                Elemento Nombre = "VE_ObtieneFormatoFecha_FN"
                Lenguaje="PL/SQL"
                Fecha="21-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripción>
                Retorna el formato de fecha segun parametros (FORMATO_SEL2)
        </Descripción>
        <Parámetros>
        <Entrada> NA </Entrada>
        <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_FormatoFecha ged_parametros.val_parametro%TYPE;
        LV_des_error    ge_errores_pg.desevent;
        LV_sql                  ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_Sql := 'SELECT val_parametro a'
                                || ' FROM ged_parametros a'
                                || ' WHERE a.cod_producto = ' || CN_PRODUCTO
                                || ' AND a.cod_modulo = ' || CV_MODULO_GE
                                || ' AND a.nom_parametro = ' || CV_FORMATO_FECHA;

                SELECT val_parametro a
                INTO   LV_FormatoFecha
                FROM   ged_parametros a
                WHERE  a.cod_producto = CN_PRODUCTO
                AND    a.cod_modulo = CV_MODULO_GE
                AND    a.nom_parametro = CV_FORMATO_FECHA;

                RETURN LV_FormatoFecha;

        EXCEPTION
                WHEN OTHERS THEN
                         LV_FormatoFecha := 'YYYYMMDD HH24MISS';
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno:=CV_error_no_clasif;
             END IF;
             LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtieneFormatoFecha_FN;- ' || SQLERRM;
             SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
             'VE_intermediario_PG.VE_ObtieneFormatoFecha_FN', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtieneFormatoFecha_FN;

        FUNCTION VE_convertir_FN (EB_valor IN BOOLEAN,
                                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN PLS_INTEGER IS
        /*--
        <Documentación TipoDoc = "Función">
                Elemento Nombre = "VE_convertir_FN"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno> PLS_INTEGER </Retorno>
        <Descripción>
                Convierte entrada booleana en integer
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EB_valor" Tipo="BOOLEAN"> valor boolean TRUE o FALSE </param>
        </Entrada>
        <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                <param nom="Salida" Tipo="PLS_INTEGER"> equivalente de TRUE o FALSE en ineteger </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LV_des_error    ge_errores_pg.desevent;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;
                IF EB_valor = TRUE THEN
                        RETURN CI_TRUE;
                ELSE
                        RETURN CI_FALSE;
                END IF;
        EXCEPTION
                WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno:=CV_error_no_clasif;
             END IF;
             LV_des_error:='OTHERS:VE_intermediario_PG.VE_convertir_FN;- ' || SQLERRM;
             SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
             'VE_intermediario_PG.VE_convertir_FN', NULL, SQLCODE, LV_des_error );
        END VE_convertir_FN;

        FUNCTION VE_ObtieneNumDiasNum_FN(SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN NUMBER IS
        /*--
        <Documentación TipoDoc = "Función">
                Elemento Nombre = "VE_ObtieneNumDiasNum_FN"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno> NUMBER </Retorno>
        <Descripción>
                Retorna el numero de dias num
        </Descripción>
        <Parámetros>
        <Entrada> NA </Entrada>
        <Salida>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
                <param nom="Salida" Tipo="NUMBER">Numero Dias Num</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LI_NumDiasNum NUMBER;
        LV_des_error  ge_errores_pg.desevent;
        LV_sql            ge_errores_pg.vquery;

        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql := 'SELECT GA_SEQ_NUMDIASNUM.NEXTVAL FROM DUAL';

                SELECT GA_SEQ_NUMDIASNUM.NEXTVAL
                INTO   LI_NumDiasNum
                FROM   DUAL;

                RETURN LI_NumDiasNum;
        EXCEPTION
                WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno:=CV_error_no_clasif;
             END IF;
             LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtieneNumDiasNum_FN;- ' || SQLERRM;
             SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
             'VE_intermediario_PG.VE_ObtieneNumDiasNum_FN', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtieneNumDiasNum_FN;

        PROCEDURE VE_obtiene_valor_parametro_PR(EV_nomparametro   IN ged_parametros.nom_parametro%TYPE,
                                                                                EV_codmodulo      IN ged_parametros.cod_modulo%TYPE,
                                                                                EV_codproducto    IN ged_parametros.cod_producto%TYPE,
                                                                                SV_valparametro   OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                                                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                        SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                        SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_obtiene_valor_parametro_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-03-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> Retorna el valor del parametro buscado </Retorno>
                <Descripción>
                        Retorna el valor del parametro
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_nomparametro" Tipo="VARCHAR2">Nombre del parametro</param>
                           <param nom="EV_codmodulo" Tipo="VARCHAR2">codigo de modulo</param>
                           <param nom="EV_codproducto" Tipo="VARCHAR2">codigo de producto</param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_valparametro" Tipo="VARCHAR2">valor de parametro buscado</param>
                           <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
                   <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                   <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_Sql:='SELECT a.val_parametro '
                                 || 'FROM ged_parametros a '
                                 || 'WHERE a.nom_parametro = ' || EV_nomparametro
                             || ' AND a.cod_modulo = ' || EV_codmodulo
                             || ' AND a.cod_producto = ' || EV_codproducto;

                SELECT a.val_parametro
                INTO   SV_valparametro
                FROM   ged_parametros a
                WHERE  a.nom_parametro = EV_nomparametro
                AND    a.cod_modulo        = EV_codmodulo
                AND    a.cod_producto  = EV_codproducto;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno := 778;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := CV_error_no_clasif;
                    END IF;
                    LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_obtiene_valor_parametro_PR;- ' || SQLERRM;
                    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                    'VE_estado_proceso_PG.VE_obtiene_valor_parametro_PR', LV_Sql, SQLCODE, LV_des_error );
                         WHEN OTHERS THEN
                        SN_cod_retorno := 156;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                            SV_mens_retorno:=CV_error_no_clasif;
                        END IF;
                        LV_des_error:='OTHERS:VE_intermediario_PG.VE_obtiene_valor_parametro_PR;- ' || SQLERRM;
                        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                        'VE_intermediario_PG.VE_obtiene_valor_parametro_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_valor_parametro_PR;


        PROCEDURE VE_obtiene_secuencia_PR(EV_nomsecuencia IN VARCHAR2,
                                          SV_secuencia    OUT NOCOPY VARCHAR2,
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) AS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_secuencia_PR"
                Lenguaje="PL/SQL"
                Fecha="22-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno> Numero de secuencia solicitado </Retorno>
        <Descripción> Retorna el numero de secuencia </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_nomsecuencia" Tipo="VARCHAR2"> identificador de la secuencia</param>
        </Entrada>
        <Salida>
                <param nom="SV_secuencia"    Tipo="VARCHAR2"> numero secuencia</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento</param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> Mensaje de retorno del procedimiento</param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LV_des_error        ge_errores_pg.desevent;
        LV_Sql              ge_errores_pg.vquery;
        LN_num_transaccion  NUMBER;
        BEGIN
            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;

            IF (EV_nomsecuencia = 'GE_SEQ_CLIENTES') THEN

                SN_cod_retorno := CV_ERROR_SEQCLIENTE;

                                LV_Sql := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL FROM DUAL';
                EXECUTE IMMEDIATE LV_Sql INTO LN_num_transaccion;

                                SV_secuencia := GE_SEQ_CLIENTES_FN(LN_num_transaccion);

                        ELSE
                SN_cod_retorno := 156;

                                LV_Sql := 'SELECT ' || EV_nomsecuencia || '.NEXTVAL FROM DUAL';
                EXECUTE IMMEDIATE LV_Sql INTO SV_secuencia;
                        END IF;

            SN_cod_retorno  := 0;
            SV_mens_retorno := NULL;
            SN_num_evento   := 0;

                EXCEPTION
             WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_obtiene_secuencia_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_obtiene_secuencia_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_OBTIENE_SECUENCIA_PR;


        PROCEDURE VE_obtiene_transaccion_PR(EN_transaccion  IN NUMBER,
                                                                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
        IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_transaccion_PR"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>Obtiene transacion de tabla GA_TRANSACABO</Retorno>
        <Descripción>
                Obtiene transacion de tabla GA_TRANSACABO
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EN_transaccion" Tipo="NUMBER> numero de transaccion </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */

        LV_Sql            ge_errores_pg.vQuery;
        LV_des_error  ge_errores_pg.desevent;

        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;


                LV_Sql := 'SELECT a.cod_retorno,a.des_cadena '
                                || 'INTO   SN_cod_retorno, SV_mens_retorno '
                                || 'FROM   ga_transacabo a '
                                || 'WHERE  a.num_transaccion = ' || EN_transaccion;

                SELECT a.cod_retorno,a.des_cadena
                INTO   SN_cod_retorno, SV_mens_retorno
                FROM   ga_transacabo a
                WHERE  a.num_transaccion = EN_transaccion;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_intermediario_PG.VE_obtiene_secuencia_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_obtiene_secuencia_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_obtiene_secuencia_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_obtiene_secuencia_PR', LV_Sql, SQLCODE, LV_des_error );

        END VE_obtiene_transaccion_PR;

        PROCEDURE VE_bloqdesbloq_vendedor_PR(EV_codvendedor  IN ve_vendedores.cod_vendedor%TYPE,
                                                                                 EC_accion       IN CHAR,
                                                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_bloqdesbloq_vendedor_PR"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>Bloquea o desbloquea el vendedor</Retorno>
        <Descripción>
                Bloquea o desbloquea el vendedor segun accion
                accion:
                                 "B" bloquea / "D" desbloquea
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_codvendedor" Tipo="NUMBER> codigo del vendedor </param>
                <param nom="EC_accion"      Tipo="CHAR"> accion a realizar </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        PRAGMA AUTONOMOUS_TRANSACTION;
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
        LE_exception_fin   EXCEPTION;
        BEGIN

            SN_cod_retorno := 0;
            SV_mens_retorno := NULL;
            SN_num_evento := 0;

            IF EC_accion = 'B' THEN
                UPDATE VE_VENDEDORES
                  SET VE_INDBLOQUEO = 1
                 WHERE COD_VENDEDOR = EV_codvendedor;
            ELSIF EC_accion = 'D' THEN
                UPDATE VE_VENDEDORES
                  SET VE_INDBLOQUEO = 0
                WHERE COD_VENDEDOR = EV_codvendedor;
            END IF;



            COMMIT;

        EXCEPTION
            WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_bloqdesbloq_vendedor_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_bloqdesbloq_vendedor_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_bloqdesbloq_vendedor_PR;

        PROCEDURE VE_ObtieneNumeroCelularAut_PR (EV_codsubalm     IN VARCHAR2,
                                                                                         EV_codcentral    IN VARCHAR2,
                                                                                         EV_coduso        IN VARCHAR2,
                                                                                         EV_codActabo     IN VARCHAR2,
                                                                                         SV_numerocelular OUT NOCOPY VARCHAR2,
                                                                                         SV_tipocelular   OUT NOCOPY VARCHAR2,
                                                                                         SV_categoria     OUT NOCOPY VARCHAR2,
                                                                                         SV_fechabaja     OUT NOCOPY VARCHAR2,
                                                                                         SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                                                         SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                                                         SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                                                                         )
    IS
        /*
        <Documentación TipoDoc = "Procedimiento">
        <Elemento Nombre = "VE_ObtieneNumeroCelularAut_PR"
        Lenguaje="PL/SQL"
        Fecha="01-03-2007"
        Versión="1.0.0"
        Diseñador="wjrc"
        Programador="wjrc"
        Ambiente="BD">
        <Retorno> Numero de celular </Retorno>
        <Descripción> Retorna el numero de celular </Descripción>
        <Parámetros>
                <Entrada>
                        <param nom="EV_codsubalm"  Tipo="STRING"> codigo sub alimentador </param>
                        <param nom="EV_codcentral" Tipo="STRING"> codigo central</param>
                        <param nom="EV_coduso"     Tipo="STRING"> codigo uso </param>
                        <param nom="EV_codActabo"  Tipo="STRING"> codigo actuacion venta </param>
                </Entrada>
                <Salida>
                        <param nom="SV_numerocelular"  Tipo="STRING"> numero celular obtenido</param>
                        <param nom="SV_tipocelular"    Tipo="STRING"> tipo del celular obtenido</param>
                        <param nom="SV_categoria"      Tipo="STRING"> categoria del celular obtenido</param>
                        <param nom="SV_fechabaja"      Tipo="STRING"> fecha baja del celular obtenido</param>
                        <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
                </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LN_num_transaccion NUMBER;
        LN_num_celular     NUMBER;
        LN_max             NUMBER;
        LN_ind             NUMBER;
        LV_des_error       ge_errores_pg.desevent;
        LV_sql                     ge_errores_pg.vquery;

        LA_arreglo tipoArray := tipoArray();
                -- (1) numero celular
                -- (2) tipo celular R:reutilizable L:libre
                -- (3) categoria
                -- (4) fecha baja celular
        LE_exception_fin   EXCEPTION;
        LV_cadena VARCHAR2(100);
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- obtener numero de transaccion
                LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

                -- llamar procedimiento de bloqueo/desbloqueo del vendedor
                LV_Sql := 'VE_NUMERACION_AUTOMATICA_PR('||LN_num_transaccion||','||EV_codActabo||','||EV_codsubalm||','||EV_codcentral||','||EV_coduso||')';
                VE_NUMERACION_AUTOMATICA_PR(LN_num_transaccion, EV_codActabo, EV_codsubalm, EV_codcentral, EV_coduso);

                -- verificamos estado del llamado
                LV_Sql := 'VE_obtiene_transaccion_PR('||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_transaccion_PR(LN_num_transaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                LV_cadena:=SV_mens_retorno;

                IF (SN_cod_retorno = 0) THEN
                        LA_arreglo := VE_descompone_cadena_FN(LV_cadena,'/', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                                RAISE LE_exception_fin;
                        END IF;
                        LN_max := LA_arreglo.count;

                        SV_numerocelular := LA_arreglo(1);
                        SV_tipocelular   := LA_arreglo(2);
                        SV_categoria     := LA_arreglo(3);
                        SV_fechabaja     := LA_arreglo(4);
                ELSE
                        RAISE LE_exception_fin;
                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: VE_intermediario_PG.VE_ObtieneNumeroCelularAut_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneNumeroCelularAut_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtieneNumeroCelularAut_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneNumeroCelularAut_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtieneNumeroCelularAut_PR;

        PROCEDURE VE_reserva_numero_celular_PR( EN_transaccion     IN NUMBER,
                                                                                        EV_numeroLinea     IN VARCHAR2,
                                                                                        EV_numeroOrden     IN VARCHAR2,
                                                                                        EV_numeroCelular   IN VARCHAR2,
                                                                                        EV_codSubAlmacen   IN VARCHAR2,
                                                                                        EV_codigoCentral   IN VARCHAR2,
                                                                                        EV_codigoCategoria IN VARCHAR2,
                                                                                        EV_codigoUso       IN VARCHAR2,
                                                                                        EV_indProcNumero   IN VARCHAR2,
                                                                                        EV_fecBajaCelular  IN VARCHAR2,
                                                                                        SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                                                                        SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                                                                        SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_reserva_numero_celular_PR"
                Lenguaje="PL/SQL"
                Fecha="21-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Inserta reserva numero celular en GA_RESNUMCEL
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EN_transaccion"     Tipo="NUMBER"> numero de transaccion </param>
                <param nom="EV_numeroLinea"     Tipo="VARCHAR2"> numero de linea </param>
                <param nom="EV_numeroOrden"     Tipo="VARCHAR2"> numero de orden </param>
                <param nom="EV_numeroCelular"   Tipo="VARCHAR2"> numero de celular </param>
                <param nom="EV_codSubAlmacen"   Tipo="VARCHAR2"> codigo sub almacen </param>
                <param nom="EV_codigoCentral"   Tipo="VARCHAR2"> codigo central </param>
                <param nom="EV_codigoCategoria" Tipo="VARCHAR2"> codigo categoria </param>
                <param nom="EV_codigoUso"       Tipo="VARCHAR2"> codigo uso </param>
                <param nom="EV_indProcNumero"   Tipo="VARCHAR2"> indicador procedencia numero </param>
                <param nom="EV_fecBajaCelular"  Tipo="VARCHAR2"> fecha baja celular </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
                LV_fecBajaCelular VARCHAR2(100);
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LE_exception_fin  EXCEPTION;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                IF (EV_indProcNumero = CV_PROCNUMERO) THEN
                        LV_fecBajaCelular := TO_DATE(EV_fecBajaCelular,VE_ObtieneFormatoFecha_FN(SN_cod_retorno, SV_mens_retorno, SN_num_evento));
                        IF SN_cod_retorno = 0 THEN
                           RAISE LE_exception_fin;
                        END IF;
                ELSE
                        LV_fecBajaCelular := NULL;
                END IF;

                LV_Sql := 'INSERT INTO ga_resnumcel (num_transaccion'
                                ||'     ,num_linea'
                                ||'     ,num_orden'
                                ||'     ,num_celular'
                                ||'     ,cod_subalm'
                                ||'     ,cod_producto'
                                ||'     ,cod_central'
                                ||'     ,cod_cat'
                                ||'     ,cod_uso'
                                ||'     ,fec_reserva'
                                ||'     ,nom_usuario'
                                ||'     ,ind_procnum'
                                ||'     ,fec_baja'
                                ||') VALUES ('||EN_transaccion
                                ||' ,'||EV_numeroLinea
                                ||' ,'||EV_numeroOrden
                                ||' ,'||EV_numeroCelular
                                ||' ,'||EV_codSubAlmacen
                                ||' ,'||CN_PRODUCTO
                                ||' ,'||EV_codigoCentral
                                ||' ,'||EV_codigoCategoria
                                ||' ,'||EV_codigoUso
                                ||' ,SYSDATE'
                                ||' ,USER'
                                ||' ,'||EV_indProcNumero
                                ||' ,'||LV_fecBajaCelular
                                ||' )';

                INSERT INTO ga_resnumcel (num_transaccion
                                                                 ,num_linea
                                                                 ,num_orden
                                                                 ,num_celular
                                                                 ,cod_subalm
                                                                 ,cod_producto
                                                                 ,cod_central
                                                                 ,cod_cat
                                                                 ,cod_uso
                                                                 ,fec_reserva
                                                                 ,nom_usuario
                                                                 ,ind_procnum    -- Indicativo de Procedencia del número; (L)ibres, (R)eutilizable
                                                                 ,fec_baja               -- Si IND_PROCNUM = L -> NULL
                ) VALUES (EN_transaccion
                                 ,EV_numeroLinea
                                 ,EV_numeroOrden
                                 ,EV_numeroCelular
                                 ,EV_codSubAlmacen
                                 ,CN_PRODUCTO
                                 ,EV_codigoCentral
                                 ,EV_codigoCategoria
                                 ,EV_codigoUso
                                 ,SYSDATE
                                 ,USER
                                 ,EV_indProcNumero
                                 ,LV_fecBajaCelular
                                 );

        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:VE_intermediario_PG.VE_reserva_numero_celular_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_reserva_numero_celular_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_reserva_numero_celular_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_reserva_numero_celular_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_reserva_numero_celular_PR;

        PROCEDURE VE_ObtieneGrupoTecnologico_PR(EV_tecnologia     IN  VARCHAR2,
                                                                            SV_valor              OUT NOCOPY VARCHAR2,
                                                                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_ObtieneGrupoTecnologico_PR"
                        Lenguaje="PL/SQL"
                        Fecha="12-04-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> Grupo tecnologia GSM </Retorno>
                <Descripción>
                        Retorna grupo tecnologia GSM
                </Descripción>
                <Parámetros>
                <Entrada>
                        <param nom="EV_tecnologia" Tipo="VARCHAR2"> tecnologia</param>
                </Entrada>
                <Salida>
                        <param nom="SV_valor" Tipo="VARCHAR2">Grupo tecnologia </param>
                        <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
                        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                        <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_Sql:='GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN'
                                 || '(' || EV_tecnologia ||')';

                SV_valor := GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EV_tecnologia);

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_ObtieneGrupoTecnologico_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error := 'OTHERS:VE_intermediario_PG.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneGrupoTecnologico_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtieneGrupoTecnologico_PR;

PROCEDURE VE_ejecuta_prebilling_PR(
   EV_sec_transacabo IN  VARCHAR2,
   EV_actprebilling  IN  VARCHAR2,
   EV_productogral   IN  VARCHAR2,
   EV_cod_cliente    IN  VARCHAR2,
   EV_num_venta      IN  VARCHAR2,
   EV_num_transacvta IN  VARCHAR2,
   EV_num_procfact   IN  VARCHAR2,
   EV_modgeneracion  IN  VARCHAR2,
   EV_cattributaria  IN  VARCHAR2,
   SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
   SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
   SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
) IS
/*
   <Documentación TipoDoc = "Procedimiento">
      Elemento Nombre = "VE_ejecuta_prebilling_PR"
      Lenguaje="PL/SQL"
      Fecha="12-04-2007"
      Versión="1.0.0"
      Diseñador="wjrc"
      Programador="wjrc"
      Ambiente="BD"
      <Retorno> Ejecucion de Prebilling </Retorno>
      <Descripción> Ejecuta Prebilling </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_sec_transacabo" Tipo="VARCHAR2"> secuencia transacabo </param>
            <param nom="EV_actprebilling" Tipo="VARCHAR2"> código actuación prebilling </param>
            <param nom="EV_productogral" Tipo="VARCHAR2"> producto general</param>
            <param nom="EV_cod_cliente" Tipo="VARCHAR2"> código cliente</param>
            <param nom="EV_num_venta" Tipo="VARCHAR2"> número de la venta</param>
            <param nom="EV_num_transacvta" Tipo="VARCHAR2"> numero de la transaccion de la venta</param>
            <param nom="EV_num_procfact" Tipo="VARCHAR2"> número proceso facturación</param>
            <param nom="EV_modgeneracion" Tipo="VARCHAR2"> modo generación</param>
            <param nom="EV_cattributaria" Tipo="VARCHAR2"> categoria tributaria de la venta</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
            <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
         </Salida>
      </Parámetros>
   </Elemento>
   </Documentación>
*/
   -- v1.1 COL|77754|13-02-2009|SAQL
   LV_des_error   ge_errores_pg.desevent;
   LV_sql         ge_errores_pg.vquery;
   sFormatoFecha  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN
   SN_cod_retorno := 0;
   SV_mens_retorno := NULL;
   SN_num_evento := 0;
   --sFormatoFecha := GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
   VE_intermediario_PG.VE_obtiene_valor_parametro_PR('FORMATO_SEL2', CV_MODULO_GE, CN_PRODUCTO,sFormatoFecha,SN_cod_retorno ,SV_mens_retorno,SN_num_evento  );
   IF SN_cod_retorno <> 0 THEN
      RAISE NO_DATA_FOUND;
   END IF;

   -- INI COL 77754|13-02-2008|SAQL
   -- LLAMO A VALIDAR SI EXISTE OTRO PROCESO DE FACTURACION CON EL MISMO NUMERO DE VENTA
   -- EN EL CASO DE EXISTIR ANULO LOS OTROS PROCESOS Y CONTINUO CON EL ACTUAL
   LV_Sql := 'FA_PRESUPUESTO_SN_PG.FA_VALIDA_ELIM_PRES_PR('||EV_num_procfact||','||EV_num_venta||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||');';
   FA_PRESUPUESTO_SN_PG.FA_VALIDA_ELIM_PRES_PR(EV_num_procfact, EV_num_venta, SN_cod_retorno, SV_mens_retorno, SN_num_evento);
   -- FIN COL 77754|13-02-2008|SAQL

   -- LV_Sql:='P_INTERFASES_ABONADOS'
   -- || '(' || EV_sec_transacabo ||',' || EV_actprebilling || ',' || EV_productogral || ',' || EV_cod_cliente || ','
   -- || EV_num_venta || ',' || EV_num_transacvta || ',' || EV_num_procfact || ',' || EV_modgeneracion || ','
   -- || EV_cattributaria || ', SYSDATE ) ';
   LV_Sql:='P_INTERFASES_ABONADOS'
      || '(' || EV_sec_transacabo ||',' || EV_actprebilling || ',' || EV_productogral || ',' || EV_cod_cliente || ','
      || EV_num_venta || ',' || EV_num_transacvta || ',' || EV_num_procfact || ',' || EV_modgeneracion || ','
      || EV_cattributaria || ',''' || to_char(sysdate, sFormatoFecha ) || ''' ) ';

   -- P_INTERFASES_ABONADOS(EV_sec_transacabo, EV_actprebilling, EV_productogral, EV_cod_cliente,
   --    EV_num_venta, EV_num_transacvta, EV_num_procfact, EV_modgeneracion,
   --    EV_cattributaria, SYSDATE);
   P_INTERFASES_ABONADOS(EV_sec_transacabo, EV_actprebilling, EV_productogral, EV_cod_cliente,EV_num_venta, EV_num_transacvta, EV_num_procfact, EV_modgeneracion,EV_cattributaria, to_char(sysdate, sFormatoFecha ));
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 778;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
      'VE_estado_proceso_PG.VE_ObtieneGrupoTecnologico_PR', LV_Sql, SQLCODE, LV_des_error );
   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno:=CV_error_no_clasif;
      END IF;
      LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
      SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
      'VE_intermediario_PG.VE_ObtieneGrupoTecnologico_PR', LV_Sql, SQLCODE, LV_des_error );
END VE_ejecuta_prebilling_PR;

------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_ObtienePlaza_Cliente_PR(scodcliente  IN  ga_ventas.cod_cliente%TYPE,
                                                                                 codPlazaCliente OUT NOCOPY ga_ventas.COD_PLAZA%TYPE,
                                                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_ObtienePlaza_Cliente_PR
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Bloquea o desbloquea el vendedor segun accion
                accion:
                                 "B" bloquea / "D" desbloquea
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="scodcliente" Tipo="VARCHAR2"> codigo de cliente </param>
                <param nom="codPlazaOficina"  Tipo="VARCHAR2"> Código de la plaza de la venta - vendedor</param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;

        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- Funcion que  devuelve el codigo de plaza a través del código del Cliente
                LV_sql := 'FN_OBTIENE_PLAZACLIENTE('||scodcliente||')';
                codPlazaCliente:=FN_OBTIENE_PLAZACLIENTE(scodcliente);

        EXCEPTION
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtienePlaza_Cliente_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtienePlaza_Cliente_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtienePlaza_Cliente_PR;

------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_ObtienePlaza_Oficina_PR(scodOficina  IN  ga_ventas.cod_oficina%TYPE,
                                                                         codPlazaOficina OUT NOCOPY ga_ventas.cod_plaza%TYPE,
                                                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_ObtienePlaza_Oficina_PR"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Obtiene codigo de la plaza de la oficina
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="scodOficina"      Tipo="STRING"> codigo de oficina </param>
                <param nom="codPlazaOficina"  Tipo="STRING"> Código de la plaza de la venta - vendedor</param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql := 'FN_OBTIENE_PLAZAOFICINA('||scodOficina||')';
                codPlazaOficina:=FN_OBTIENE_PLAZAOFICINA(scodOficina);

        EXCEPTION
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtienePlaza_Oficina_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtienePlaza_Oficina_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtienePlaza_Oficina_PR;

------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_ObtienePresupuesto_PR(EN_num_proceso    IN  ga_presupuesto.num_proceso%TYPE,
                                                                       SN_cargos         OUT NOCOPY ga_presupuesto.imp_base%TYPE,
                                                                           SN_descuentos     OUT NOCOPY ga_presupuesto.imp_dto%TYPE,
                                                                           SN_impuestos      OUT NOCOPY ga_presupuesto.imp_impuesto%TYPE,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_ObtienePresupuesto_PR"
                        Lenguaje="PL/SQL"
                        Fecha="04-05-2007"
                        Versión="1.0.0"
                        Diseñador="Héctor Hermosilla"
                        Programador=Héctor Hermosilla"
                        Ambiente="BD"
                <Retorno> N/A</Retorno>
                <Descripción>
                        OBTIENE PRESUPUESTO DE LA VENTA
                </Descripción>
                <Parámetros>
                <Entrada>
                        <param nom="En_num_proceso" Tipo="NUMBER"> numero proceso facturación</param>
                </Entrada>
                <Salida>
                    <param nom="SN_cargos"       Tipo="NUMBER"> total cargos </param>
                        <param nom="SN_descuentos"   Tipo="NUMBER"> total descuentos </param>
                        <param nom="SN_impuestos"    Tipo="NUMBER"> total impuestos </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                --*/
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_Sql:= 'SELECT presupuesto.imp_base, presupuesto.imp_dto,'
                         || ' presupuesto.imp_impuesto'
                                 || ' FROM ga_presupuesto presupuesto'
                                 || ' WHERE presupuesto.num_proceso =' || EN_num_proceso;

                SELECT sum(presupuesto.imp_base), sum(presupuesto.imp_dto),
                       sum(presupuesto.imp_impuesto)
            INTO   SN_cargos, SN_descuentos,
                       SN_impuestos
            FROM ga_presupuesto presupuesto
                WHERE presupuesto.num_proceso = EN_num_proceso;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_ObtienePresupuesto_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_ObtienePresupuesto_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtienePresupuesto_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtienePresupuesto_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtienePresupuesto_PR;


------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE VE_ObtienePresupuestoDesc_PR(EN_num_proceso    IN  ga_presupuesto.num_proceso%TYPE,
                                       SN_cargos         OUT NOCOPY ga_presupuesto.imp_base%TYPE,
                                       SN_descuentos     OUT NOCOPY ga_presupuesto.imp_dto%TYPE,
                                       SN_impuestos      OUT NOCOPY ga_presupuesto.imp_impuesto%TYPE,
                                       SC_cursordatos    OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "ObtienePresupuestoDesc"
                        Lenguaje="PL/SQL"
                        Fecha="04-05-2007"
                        Versión="1.0.0"
                        Diseñador="Héctor Hermosilla"
                        Programador=Héctor Hermosilla"
                        Ambiente="BD"
                <Retorno> N/A</Retorno>
                <Descripción>
                        OBTIENE PRESUPUESTO DE LA VENTA
                </Descripción>
                <Parámetros>
                <Entrada>
                        <param nom="En_num_proceso" Tipo="NUMBER"> numero proceso facturación</param>
                </Entrada>
                <Salida>
                    <param nom="SN_cargos"       Tipo="NUMBER"> total cargos </param>
                        <param nom="SN_descuentos"   Tipo="NUMBER"> total descuentos </param>
                        <param nom="SN_impuestos"    Tipo="NUMBER"> total impuestos </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                --*/
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

        OPEN SC_cursordatos FOR
        select a.imp_concepto + b.imp_concepto from fa_presupuesto A, fa_presupuesto B
        where a.num_proceso =EN_num_proceso
        and a.num_proceso = b.num_proceso
        and a.cod_tipconce in (2,3)
        and b.cod_tipconce = 1
        and a.cod_concepto = b.cod_concerel
        and a.columna = b.columna_rel;


                LV_Sql:= 'SELECT presupuesto.imp_base, presupuesto.imp_dto,'
                         || ' presupuesto.imp_impuesto'
                                 || ' FROM ga_presupuesto presupuesto'
                                 || ' WHERE presupuesto.num_proceso =' || EN_num_proceso;

                SELECT sum(presupuesto.imp_base), sum(presupuesto.imp_dto),
                       sum(presupuesto.imp_impuesto)
            INTO   SN_cargos, SN_descuentos,
                       SN_impuestos
            FROM ga_presupuesto presupuesto
                WHERE presupuesto.num_proceso = EN_num_proceso;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_ObtienePresupuesto_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_ObtienePresupuesto_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtienePresupuesto_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtienePresupuesto_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtienePresupuestoDesc_PR;

------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE VE_ObtieneOperadora_PR(SV_codoperadora   OUT NOCOPY VARCHAR2,
                                                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_ObtieneOperadora_PR"
                        Lenguaje="PL/SQL"
                        Fecha="05-05-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> NUMBER </Retorno>
                <Descripción>
                        Retorna codigo operadora
                </Descripción>
                <Parámetros>
                <Entrada> N/A </Entrada>
                <Salida>
                    <param nom="SV_codoperadora" Tipo="VARCHAR2"> codigo operadora </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                --*/
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;


        SV_codoperadora:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_ObtieneOperadora_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_ObtieneOperadora_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtieneOperadora_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneOperadora_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtieneOperadora_PR;

        PROCEDURE VE_ObtieneOperadora_PR(SV_codoperadora   OUT NOCOPY VARCHAR2,
                                         SV_desoperadora   OUT NOCOPY VARCHAR2,
                                                                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_ObtieneOperadora_PR"
                        Lenguaje="PL/SQL"
                        Fecha="05-05-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> NUMBER </Retorno>
                <Descripción>
                        Retorna codigo y descripcion de la operadora
                </Descripción>
                <Parámetros>
                <Entrada> N/A </Entrada>
                <Salida>
                    <param nom="SV_codoperadora" Tipo="STRING"> codigo operadora </param>
                    <param nom="SV_desoperadora" Tipo="STRING"> descripcion operadora </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                    <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                --*/
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_Sql:='SELECT a.cod_operadora_scl,a.des_operadora_scl '
                || 'INTO SV_codoperadora,SV_desoperadora '
                || 'FROM ge_operadora_scl_local b,ge_operadora_scl a '
        || 'WHERE a.cod_operadora_scl=b.cod_operadora_scl';

                SELECT a.cod_operadora_scl,a.des_operadora_scl
                INTO SV_codoperadora,SV_desoperadora
                FROM ge_operadora_scl_local b,ge_operadora_scl a
                WHERE a.cod_operadora_scl=b.cod_operadora_scl;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_ObtieneOperadora_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_ObtieneOperadora_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtieneOperadora_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneOperadora_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtieneOperadora_PR;

------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE VE_numeracion_manual_PR(EV_numcelular   IN VARCHAR2,
                                                                          EV_tipocelular  IN VARCHAR2,
                                                                          EV_codcatcel    IN VARCHAR2,
                                                                          EV_coduso       IN VARCHAR2,
                                                                          EV_codcentral   IN VARCHAR2,
                                                                          EV_codsubalm    IN VARCHAR2,
                                                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_numeracion_manual_PR"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Llama procedimiento p_numeracion_manual
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_numcelular" Tipo="VARCHAR2">numero celular</param>
                <param nom="EV_tipocelular" Tipo="VARCHAR2">tipo celular</param>
                <param nom="EV_codcatcel" Tipo="VARCHAR2"> codigo cetegoria celular</param>
                <param nom="EV_coduso" Tipo="VARCHAR2"> codigo uso celular </param>
                <param nom="EV_codcentral" Tipo="VARCHAR2"> codigo central</param>
                <param nom="EV_codsubalm" Tipo="VARCHAR2"> codigo sub alimentador </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
        LE_exception_fin   EXCEPTION;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- obtener numero de transaccion
                LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||', '||LN_num_transaccion||', '||SN_cod_retorno||', '||SV_mens_retorno||', '||SN_num_evento||')';
                VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE LE_exception_fin;
                END IF;

                -- llamar procedimiento de bloqueo/desbloqueo del vendedor
                P_NUMERACION_MANUAL(LN_num_transaccion,
                            EV_tipocelular,
                                                    EV_codsubalm,
                                                        EV_codcentral,
                                                        EV_codcatcel,
                                                        EV_coduso,
                                                        EV_numcelular);

                -- verificamos estado del llamado
                LV_Sql := 'VE_obtiene_transaccion_PR('||LN_num_transaccion||', '||SN_cod_retorno||', '||SV_mens_retorno||', '||SN_num_evento||')';
                VE_obtiene_transaccion_PR(LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE LE_exception_fin;
                END IF;
        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:VE_intermediario_PG.VE_numeracion_manual_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_numeracion_manual_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_numeracion_manual_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_numeracion_manual_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_numeracion_manual_PR;

------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE VE_obtiene_prefijo_num_PR(EN_numcelular   IN  ga_abocel.num_celular%TYPE,
                                                                                SV_numprefijo   OUT NOCOPY ga_celnum_subalm.num_min%TYPE,
                                                                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_prefijo_num_PR"
                Lenguaje="PL/SQL"
                Fecha="07-05-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Obtiene prefijo de numero de celular
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EN_numcelular    Tipo="NUMBER"> anumero de celular</param>
        </Entrada>
        <Salida>
                <param nom="SV_numprefijo"   Tipo="VARCHAR2"> prefijo celular</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error</param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;

        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql := 'AL_FN_PREFIJO_NUMERO('||EN_numcelular||')';
                SV_numprefijo:=AL_FN_PREFIJO_NUMERO(EN_numcelular);

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_obtiene_prefijo_num_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_obtiene_prefijo_num_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_obtiene_prefijo_num_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_obtiene_prefijo_num_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_prefijo_num_PR;

------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE VE_valida_autentificacion_PR(EV_numserie     IN al_series.num_serie%TYPE,
                                                                                   EV_procedencia  IN VARCHAR2,
                                                                                   EN_coduso       IN al_usos.cod_uso%TYPE,
                                                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_valida_autentificacion_PR"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Bloquea o desbloquea el vendedor segun accion
                accion:
                                 "B" bloquea / "D" desbloquea
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_numserie"    Tipo="VARCHAR2"> numero de serie </param>
                <param nom="EV_procedencia" Tipo="VARCHAR2"> procedencia equipo (E/I) </param>
                <param nom="EV_numserie"    Tipo="VARCHAR2> numero de serie </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
        LE_exception_fin   EXCEPTION;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- obtener numero de transaccion
                LV_sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||', ' ||LN_num_transaccion||', ' ||SN_cod_retorno||', ' ||SV_mens_retorno||', ' ||SN_num_evento||')';
                VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE LE_exception_fin;
                END IF;

                -- llamar procedimiento valida autentificacion
                LV_sql := 'VT_VALIDA_AUTENTICACION_PR('||LN_num_transaccion||', '||EV_numserie||', '||EV_procedencia||', '||EN_coduso||')';
                VT_VALIDA_AUTENTICACION_PR(LN_num_transaccion, EV_numserie, EV_procedencia, EN_coduso);
                IF SN_cod_retorno <> 0 THEN
                    RAISE LE_exception_fin;
                END IF;

                -- verificamos estado del llamado
                LV_sql := 'VE_obtiene_transaccion_PR('||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_transaccion_PR(LN_num_transaccion,SN_cod_retorno,SV_mens_retorno, SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE LE_exception_fin;
                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:VE_intermediario_PG.VE_valida_autentificacion_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_valida_autentificacion_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_valida_autentificacion_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_valida_autentificacion_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_valida_autentificacion_PR;


        PROCEDURE VE_obtiene_imsi_simcard_PR(EV_num_serie    IN  gsm_det_simcard_to.num_simcard%TYPE,
                                                                                 EV_cod_campo    IN  gsm_campos_to.cod_campo%TYPE,
                                                                                 SV_imsi         OUT NOCOPY VARCHAR2,
                                                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_imsi_simcard_PR"
                Lenguaje="PL/SQL"
                Fecha="08-05-2007"
                Versión="1.0.0"
                Diseñador="Héctor Hermosilla"
                Programador="Héctor Hermosilla"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Obtiene imsi de la simcard, utilizado para insertar movimiento en centrales
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_num_serie"   Tipo="VARCHAR2"> numero de la serie simcard</param>
                <param nom="EV_cod_campo"   Tipo="VARCHAR2"> código campo</param>
        </Entrada>
        <Salida>
                <param nom="SV_imsi"         Tipo="VARCHAR2"> prefijo celular</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error</param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;

        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql := 'FRECUPERSIMCARD_FN('||EV_num_serie||','||EV_cod_campo||')';
                SV_imsi:=FRECUPERSIMCARD_FN(EV_num_serie,EV_cod_campo);

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_obtiene_imsi_simcard_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_estado_proceso_PG.VE_obtiene_imsi_simcard_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_obtiene_imsi_simcard_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_obtiene_imsi_simcard_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_obtiene_imsi_simcard_PR;

        PROCEDURE VE_actualiza_stock_PR(EV_tipoMovto     IN  VARCHAR2,
                                                        EV_TipStock      IN  VARCHAR2,
                                                                        EV_CodBodega     IN  VARCHAR2,
                                                                        EV_CodArticulo   IN  VARCHAR2,
                                                                        EV_CodUso        IN  VARCHAR2,
                                                                        EV_CodEstado     IN  VARCHAR2,
                                                                        EV_NumVenta      IN  VARCHAR2,
                                                                        EV_Numserie      IN  VARCHAR2,
                                                                        EV_IndTelef      IN  VARCHAR2,
                                                                        SV_NumMovimiento OUT NOCOPY VARCHAR2,
                                                                        SV_IndSerConTel  OUT NOCOPY VARCHAR2,
                                                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                                        SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                                        SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_actualiza_stock_PR"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>N/A</Retorno>
        <Descripción>
                LLama procedimiento P_GA_INTERAL, para actualizar stock
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EC_tipoMovto"    Tipo="VARCHAR2"> tipo movimiento </param>
                <param nom="EC_TipStock"     Tipo="VARCHAR2"> tipo stock </param>
                <param nom="EC_CodBodega"    Tipo="VARCHAR2"> codigo bodega </param>
                <param nom="EC_CodArticulo"  Tipo="VARCHAR2"> codigo articulo </param>
                <param nom="EC_CodUso"       Tipo="VARCHAR2"> codigo uso </param>
                <param nom="EC_CodEstado"    Tipo="VARCHAR2"> codigo estado </param>
                <param nom="EC_NumVenta"     Tipo="VARCHAR2"> numero venta </param>
                <param nom="EC_Numserie"     Tipo="VARCHAR2"> numero serie </param>
                <param nom="EC_IndTelef"     Tipo="VARCHAR2"> indicador telefono </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LE_exception_fin        EXCEPTION;
        LA_arreglo tipoArray    := tipoArray();
        LV_cadena                               VARCHAR2(100);
        LN_num_transaccion      NUMBER;
        LV_des_error            ge_errores_pg.desevent;
        LV_sql                      ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- obtener numero de transaccion
                LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE LE_exception_fin;
                END IF;

                LV_Sql := 'P_GA_INTERAL(' || LN_num_transaccion || ','
                                          || EV_tipoMovto || ','
                                                                  || EV_TipStock || ','
                                                                  || EV_CodBodega || ','
                                                                  || EV_CodArticulo || ','
                                                                  || EV_CodUso || ','
                                                                  || EV_CodEstado || ','
                                                                  || EV_NumVenta || ','
                                                                  || '1' || ','
                                                                  || EV_Numserie || ','
                                                                  || EV_IndTelef || ')';

        -- llamar procedimiento P_GA_INTERAL
                P_GA_INTERAL(LN_num_transaccion,
                             EV_tipoMovto,
                                         EV_TipStock,
                                         EV_CodBodega,
                                         EV_CodArticulo,
                                         EV_CodUso,
                                         EV_CodEstado,
                                         EV_NumVenta,
                                         '1',-- cantidad
                                         EV_Numserie,
                                         EV_IndTelef);

                -- verificamos estado del llamado
                LV_Sql := 'VE_obtiene_transaccion_PR('||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_transaccion_PR(LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno <> 0 THEN
                    RAISE LE_exception_fin;
                ELSE
                        IF (SV_mens_retorno = '')THEN
                                RAISE LE_exception_fin;
                        ELSE
                                LV_cadena  := SV_mens_retorno;
                                LA_arreglo := VE_descompone_cadena_FN(LV_cadena,'/', SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                SV_NumMovimiento := LA_arreglo(1);
                                SV_IndSerConTel  := LA_arreglo(2);
                        END IF;
                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin:VE_intermediario_PG.VE_actualiza_stock_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_actualiza_stock_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_actualiza_stock_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_actualiza_stock_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_actualiza_stock_PR;

        PROCEDURE VE_getConsumeFolio_PR(SV_valor        OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getConsumeFolio_PR"
                Lenguaje="PL/SQL"
                Fecha="07-05-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Obtiene valor que indica si la operadora consume folio
        </Descripción>
        <Parámetros>
        <Entrada> N/A </Entrada>
        <Salida>
                <param nom="SV_valor"        Tipo="STRING"> valor parametro </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
                <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error</param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LN_num_transaccion NUMBER;
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;

        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql   := 'GE_FN_CONSUMOFOLIO_SCL()';
                SV_valor := GE_FN_CONSUMOFOLIO_SCL();

        EXCEPTION
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_getConsumeFolio_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_getConsumeFolio_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_getConsumeFolio_PR;

        PROCEDURE VE_getDatosGener_PR(EV_columna      IN VARCHAR2,
                                                                  SV_valor        OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getDatosGener_PR"
                Lenguaje="PL/SQL"
                Fecha="12-06-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Obtiene valor columna de la tabla ga_datosgener
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="SV_columna"     Tipo="STRING"> columna de la tabla </param>
        </Entrada>
        <Salida>
                <param nom="SV_valor"        Tipo="STRING"> valor </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
                <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error</param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql   := 'SELECT a.' || EV_columna
                         || ' FROM ga_datosgener a';
                EXECUTE IMMEDIATE LV_Sql INTO SV_valor;

        EXCEPTION
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_getDatosGener_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_getDatosGener_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_getDatosGener_PR;

        PROCEDURE VE_ValidarIdentificador_PR(EV_modulo         IN  VARCHAR2,
                                             EN_correlativo    IN  NUMBER,
                                             EV_numIdentif     IN  VARCHAR2,
                                             EV_tipoIdentif    IN  VARCHAR2,
                                             SV_num_ident      OUT NOCOPY GE_CLIENTES.NUM_IDENT%TYPE,
                                             SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_ValidarIdentificador_PR"
                        Lenguaje="PL/SQL"
                        Fecha="12-04-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                </Retorno>
                <Descripción>
                        Valida numero identificacion
                </Descripción>
                <Parámetros>
                <Entrada>
                        <param nom="EV_modulo"      Tipo="STRING"> modulo </param>
                        <param nom="EN_correlativo" Tipo="NUMBER"> correlativo </param>
                        <param nom="EV_numIdentif"  Tipo="STRING"> numero identificador </param>
                        <param nom="EV_tipoIdentif"  Tipo="STRING"> tipo identificador </param>
                </Entrada>
                <Salida>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento</param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento</param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion</param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LE_exception_fin   EXCEPTION;
                LV_des_error       ge_errores_pg.desevent;
                LV_sql                 ge_errores_pg.vquery;
                LV_cadena                  VARCHAR2(500);
        BEGIN
                SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

                LV_Sql:='ge_fn_ejecuta_rutina_bind'
                                 || '(''' || EV_modulo || ''',' || EN_correlativo || ',''''' || EV_numIdentif || ''',''' || EV_tipoIdentif || ''''')';

        LV_cadena := ge_fn_ejecuta_rutina_bind(EV_modulo,EN_correlativo,'''' || EV_numIdentif || ''',''' || EV_tipoIdentif || '''');

                IF (INSTR(LV_cadena,'ERROR') > 0)THEN
                        RAISE LE_exception_fin;
                END IF;

        SV_num_ident:=LV_cadena;

        EXCEPTION
                WHEN LE_exception_fin THEN
                SN_cod_retorno := 1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := LV_CADENA;
                END IF;
                LV_des_error := 'FORMATO_INCORRECTO: ' || LV_cadena || ' VE_intermediario_PG.VE_ValidarIdentificador_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ValidarIdentificador_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error := 'OTHERS:VE_intermediario_PG.VE_ValidarIdentificador_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ValidarIdentificador_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ValidarIdentificador_PR;

        PROCEDURE VE_ObtieneCategoriaCta_PR (EV_numIdentif   IN VARCHAR2,
                                                                                 EV_codCategTrib IN VARCHAR2,
                                                                                 EV_tipoModulo   IN VARCHAR2,
                                                                                 SV_codCategoria OUT NOCOPY VARCHAR2,
                                                                                 SV_codSubCateg  OUT NOCOPY VARCHAR2,
                                                                                 SV_codMultUso   OUT NOCOPY VARCHAR2,
                                                                                 SV_codCliePot   OUT NOCOPY VARCHAR2,
                                                                                 SV_desRazon     OUT NOCOPY VARCHAR2,
                                                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                                                                 ) IS
        /*
        <Documentación TipoDoc = "Procedimiento">
        <Elemento Nombre = "VE_ObtieneCategoriaCta_PR"
        Lenguaje="PL/SQL"
        Fecha="01-03-2007"
        Versión="1.0.0"
        Diseñador="wjrc"
        Programador="wjrc"
        Ambiente="BD">
        <Retorno> Categoria de la cuenta </Retorno>
        <Descripción> Retorna categoria de la cuenta </Descripción>
        <Parámetros>
                <Entrada>
                        <param nom="EV_numIdentif"   Tipo="STRING"> numero identificador</param>
                        <param nom="EV_codCategTrib" Tipo="STRING"> codigo categoria tributaria </param>
                        <param nom="EV_tipoModulo"   Tipo="STRING"> tipo modulo </param>
                </Entrada>
                <Salida>
                        <param nom="SV_codCategoria" Tipo="STRING"> codigo categoria </param>
                        <param nom="SV_codSubCateg"  Tipo="STRING"> codigo subcategoria </param>
                        <param nom="SV_codMultUso"   Tipo="STRING"> codigo multi uso </param>
                        <param nom="SV_codCliePot"   Tipo="STRING"> codigo cliente potencial </param>
                        <param nom="SV_desRazon"     Tipo="STRING"> descripcion razon </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
        LE_exception_fin   EXCEPTION;
        LV_des_error       ge_errores_pg.desevent;
        LV_sql                     ge_errores_pg.vquery;

        LA_arreglo tipoArray := tipoArray();
                -- (1) codigo categoria
                -- (2) odigo subcategoria
                -- (3) codigo multi uso
                -- (4) codigo cliente potencial
                -- (5) descripcion razon
        LV_cadena          VARCHAR2(100);
        LN_num_transaccion NUMBER;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- obtener numero de transaccion
                LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

                -- llamar procedimiento de categoria cuenta
                LV_Sql := 'GA_P_CATCUENTAS('||LN_num_transaccion||','||EV_numIdentif||','||EV_codCategTrib||','||EV_tipoModulo||')';
                GA_P_CATCUENTAS(LN_num_transaccion,
                                EV_numIdentif,
                                                EV_codCategTrib,
                                                EV_tipoModulo);

                -- verificamos estado del llamado
                LV_Sql := 'VE_obtiene_transaccion_PR('||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_transaccion_PR(LN_num_transaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                LV_cadena:=SV_mens_retorno;

                IF (SN_cod_retorno = 0) THEN
                        LA_arreglo := VE_descompone_cadena_FN(LV_cadena,'/', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                                RAISE LE_exception_fin;
                        END IF;

                        SV_codCategoria := LA_arreglo(1);
                        SV_codSubCateg  := LA_arreglo(2);
                        SV_codMultUso   := LA_arreglo(3);
                        SV_codCliePot   := LA_arreglo(4);
                        SV_desRazon     := LA_arreglo(5);
                ELSE
                        RAISE LE_exception_fin;
                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: VE_intermediario_PG.VE_ObtieneCategoriaCta_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneCategoriaCta_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtieneCategoriaCta_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtieneCategoriaCta_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtieneCategoriaCta_PR;

        PROCEDURE VE_getMinMDN_PR(EV_numCelular   IN  VARCHAR2,
                                                                   SV_minMDN       OUT NOCOPY VARCHAR2,
                                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getMinMDN_PR"
                Lenguaje="PL/SQL"
                Fecha="24-07-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                Obtiene prefijo de numero de celular
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_numCelular    Tipo="STRING"> numero de celular</param>
        </Entrada>
        <Salida>
                <param nom="SV_minMDN"       Tipo="STRING"> numero minMDN</param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
                <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error</param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql := 'GE_FN_MIN_DE_MDN('||EV_numCelular||')';
                SV_minMDN := GE_FN_MIN_DE_MDN(EV_numCelular);

        EXCEPTION
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_getMinMDN_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_getMinMDN_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_getMinMDN_PR;

        PROCEDURE VE_ObtienePlazaCliente_PR(EV_codCliente   IN  VARCHAR2,
                                                                        SN_codPlaza     OUT NOCOPY VARCHAR2,
                                                                        SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_ObtienePlazaCliente_PR"
                Lenguaje="PL/SQL"
                Fecha="01-03-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Obtiene codigo de la plaza del cliente
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_codCliente" Tipo="STRING"> codigo del cliente </param>
        </Entrada>
        <Salida>
                <param nom="SV_codPlaza"  Tipo="STRING"> Código de la plaza </param>
                <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                LV_sql := 'FN_OBTIENE_PLAZACLIENTE('||EV_codCliente||')';
                SN_codPlaza:=FN_OBTIENE_PLAZAOFICINA(EV_codCliente);

        EXCEPTION
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ObtienePlazaCliente_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ObtienePlazaCliente_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_ObtienePlazaCliente_PR;

        PROCEDURE VE_getOrigenVenta_PR(EV_numeroSerie         IN  VARCHAR2,
                                                                   SV_codigoUso           OUT NOCOPY VARCHAR2,
                                                                   SV_descripcionUso      OUT NOCOPY VARCHAR2,
                                                                   SV_codigoArticulo      OUT NOCOPY VARCHAR2,
                                                                   SV_descripcionArticulo OUT NOCOPY VARCHAR2,
                                                                   SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                                                   SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                                                   SN_num_evento          OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_getOrigenVenta_PR"
                Lenguaje="PL/SQL"
                Fecha="31-08-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>
                         ?
        </Retorno>
        <Descripción>
                Obtiene el origen de la venta
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_numeroSerie" Tipo="STRING> numero de la serie </param>
                <param nom="EN_tipoProceso" Tipo="NUMBER"> tipo proceso </param>
        </Entrada>
        <Salida>
                <param nom="SV_codigoUso"           Tipo="STRING> codigo uso </param>
                <param nom="SV_descripcionUso"      Tipo="STRING> descripcion uso </param>
                <param nom="SV_codigoArticulo"      Tipo="STRING> codigo articulo </param>
                <param nom="SV_descripcionArticulo" Tipo="STRING> descripcion articulo </param>
                <param nom="SN_cod_retorno"         Tipo="NUMBER"> codigo retorno </param>
                <param nom="SV_mens_retorno"            Tipo="STRING"> glosa mensaje error </param>
                <param nom="SN_num_evento"              Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        */
    CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(20) := 'VE_getOrigenVenta_PR';

        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
        LE_exception_fin   EXCEPTION;

        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                -- llamar procedimiento de bloqueo/desbloqueo del vendedor
                LV_Sql := 'NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR(' || EV_numeroSerie         ||','
                                                                                               || CI_ALTAMAYORISTA       ||','
                                                                                                                           || SV_codigoUso           ||','
                                                                                                                           || SV_descripcionUso      ||','
                                                                                                                           || SV_codigoArticulo      ||','
                                                                                                                           || SV_descripcionArticulo ||','
                                                                                                                           || SV_mens_retorno        || ')';

                --NP_TRANSACCIONES_WEB_PG.NP_ORIGENVENTA_PR(EV_numeroSerie,
                --                                                                  CI_ALTAMAYORISTA,
                 --                                                                                 SV_codigoUso,
                  --                                                                                SV_descripcionUso,
                   --                                                                               SV_codigoArticulo,
                    --                                                                              SV_descripcionArticulo,
                     --                                                                             SV_mens_retorno);

                -- verificamos estado del llamado
                IF SV_codigoUso IS NOT NULL AND SV_descripcionUso IS NOT NULL AND SV_codigoArticulo IS NOT NULL AND SV_descripcionArticulo IS NOT NULL  THEN
                   SN_cod_retorno:=0;
                ELSE
                    SV_mens_retorno:='Serie No recepcionada por Nota Pedido Web';
                        RAISE LE_exception_fin;
                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                         SN_cod_retorno := 4;
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                WHEN OTHERS THEN
                         SN_cod_retorno := 4;
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getOrigenVenta_PR;

---------------------------------------------------------------------------------------------------------
-- MANEJO DE ERRORES EN LOS PROCEDIMIENTOS : EXCEPTION
-- !!! no borrar por dependencia de otros packages
------------------------------------------------------

        PROCEDURE VE_NoDataFoundCursor_PR(EV_nomPackage   IN  VARCHAR2,
                                          EV_nomProcedure IN  VARCHAR2,
                                                                          EV_sql          IN  VARCHAR2,
                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_NoDataFoundCursor_PR"
                Lenguaje="PL/SQL"
                Fecha="10-08-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Registra error de excepcion NoDataFoundCursor
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_nomPackage"   Tipo="STRING"> nombre del package </param>
                <param nom="EV_nomProcedure" Tipo="STRING"> nombre del procedure </param>
                <param nom="EV_sql"          Tipo="STRING"> sql </param>
        </Entrada>
        <Salida>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_desError     ge_errores_pg.desevent;
        BEGIN
                SN_cod_retorno := 1;
                SN_num_evento:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_desError     := SUBSTR('NO_DATA_FOUND_CURSOR:'||EV_nomPackage||'.'||EV_nomProcedure||';- '|| SQLERRM,1,CN_LARGOERRTEC);
                SV_mens_retorno := SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
                SN_num_evento   := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                          CV_MODULO_GA,
                                                                                                  SV_mens_retorno,
                                                                                                  '1.0',
                                                                                                  USER,
                                                                                                  EV_nomPackage||'.'||EV_nomProcedure,
                                                                                                  EV_sql,
                                                                                                  SN_cod_retorno,
                                                                                                  LV_desError);
        END VE_NoDataFoundCursor_PR;

        PROCEDURE VE_Others_PR(EV_nomPackage   IN  VARCHAR2,
                               EV_nomProcedure IN  VARCHAR2,
                                                   EV_sql          IN  VARCHAR2,
                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_Others_PR"
                Lenguaje="PL/SQL"
                Fecha="10-08-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Registra error de excepcion Others
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_nomPackage"   Tipo="STRING"> nombre del package </param>
                <param nom="EV_nomProcedure" Tipo="STRING"> nombre del procedure </param>
                <param nom="EV_sql"          Tipo="STRING"> sql </param>
        </Entrada>
        <Salida>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_desError     ge_errores_pg.desevent;
        BEGIN
                SN_cod_retorno := 156;
                SN_num_evento:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_desError := 'OTHERS:'||EV_nomPackage||'.'||EV_nomProcedure||';- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                        CV_MODULO_GA,
                                                                                                SV_mens_retorno,
                                                                                                '1.0',
                                                                                                USER,
                                                                                                EV_nomPackage||'.'||EV_nomProcedure,
                                                                                                EV_sql,
                                                                                                SQLCODE,
                                                                                                LV_desError);
        END VE_Others_PR;

        PROCEDURE VE_ErrorSql_PR(EV_nomPackage   IN  VARCHAR2,
                                 EV_nomProcedure IN  VARCHAR2,
                                                     EV_sql          IN  VARCHAR2,
                                         SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_ErrorSql_PR"
                Lenguaje="PL/SQL"
                Fecha="10-08-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Registra error de excepcion ErrorSql
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_nomPackage"   Tipo="STRING"> nombre del package </param>
                <param nom="EV_nomProcedure" Tipo="STRING"> nombre del procedure </param>
                <param nom="EV_sql"          Tipo="STRING"> sql </param>
        </Entrada>
        <Salida>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_desError     ge_errores_pg.desevent;
        BEGIN
                SN_cod_retorno := 4;
                SN_num_evento:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_desError := 'ERROR_SQL:'||EV_nomPackage||'.'||EV_nomProcedure||';- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                        CV_MODULO_GA,
                                                                                                SV_mens_retorno,
                                                                                                '1.0',
                                                                                                USER,
                                                                                                EV_nomPackage||'.'||EV_nomProcedure,
                                                                                                EV_sql,
                                                                                                SQLCODE,
                                                                                                LV_desError);
        END VE_ErrorSql_PR;

        PROCEDURE VE_NotDataFound_PR(EV_nomPackage   IN  VARCHAR2,
                                     EV_nomProcedure IN  VARCHAR2,
                                                         EV_sql          IN  VARCHAR2,
                                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_NotDataFound_PR"
                Lenguaje="PL/SQL"
                Fecha="10-08-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Registra error de excepcion NotDataFound
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_nomPackage"   Tipo="STRING"> nombre del package </param>
                <param nom="EV_nomProcedure" Tipo="STRING"> nombre del procedure </param>
                <param nom="EV_sql"          Tipo="STRING"> sql </param>
        </Entrada>
        <Salida>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_desError     ge_errores_pg.desevent;
        BEGIN
                SN_num_evento:=0;
                SN_cod_retorno := 4;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_desError := 'NO_DATA_FOUND:'||EV_nomPackage||'.'||EV_nomProcedure||';- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                        CV_MODULO_GA,
                                                                                                SV_mens_retorno,
                                                                                                '1.0',
                                                                                                USER,
                                                                                                EV_nomPackage||'.'||EV_nomProcedure,
                                                                                                EV_sql,
                                                                                                SQLCODE,
                                                                                                LV_desError);
        END VE_NotDataFound_PR;

        PROCEDURE VE_ErrorParametro_PR(EV_nomPackage   IN  VARCHAR2,
                                       EV_nomProcedure IN  VARCHAR2,
                                                           EV_sql          IN  VARCHAR2,
                                               SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_ErrorParametro_PR"
                Lenguaje="PL/SQL"
                Fecha="10-08-2007"
                Versión="1.0.0"
                Diseñador="wjrc"
                Programador="wjrc"
                Ambiente="BD"
        <Retorno>NA</Retorno>
        <Descripción>
                                  Registra error de excepcion ErrorParametro
        </Descripción>
        <Parámetros>
        <Entrada>
                <param nom="EV_nomPackage"   Tipo="STRING"> nombre del package </param>
                <param nom="EV_nomProcedure" Tipo="STRING"> nombre del procedure </param>
                <param nom="EV_sql"          Tipo="STRING"> sql </param>
        </Entrada>
        <Salida>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parámetros>
        </Elemento>
        </Documentación>
        --*/
                LV_desError     ge_errores_pg.desevent;
        BEGIN
                SN_cod_retorno := 5;
                SN_num_evento:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                   SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_desError := 'ERROR_SQL:'||EV_nomPackage||'.'||EV_nomProcedure||';- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,
                                                        CV_MODULO_GA,
                                                                                                SV_mens_retorno,
                                                                                                '1.0',
                                                                                                USER,
                                                                                                EV_nomPackage||'.'||EV_nomProcedure,
                                                                                                EV_sql,
                                                                                                SQLCODE,
                                                                                                LV_desError);
        END VE_ErrorParametro_PR;



        PROCEDURE VE_obtenerhomenonumerado_pr  (EV_NumIcc          IN  AL_SERIES.num_serie%TYPE,
                                                EV_Actabo          IN  GA_ACTABO.cod_actabo%TYPE,
                                                                                        EV_uso             IN  AL_USOS.Cod_uso%TYPE,
                                                                                        EV_CodVendedor     IN  ve_vendedores.cod_vendedor%TYPE,
                                                                                        SN_NumTelefono     OUT AL_SERIES.NUM_TELEFONO%TYPE,
                                                                                        SN_Codsubalm       OUT al_series.cod_subalm%TYPE,
                                                                            SV_CodCentral      OUT al_series.COD_CENTRAL%TYPE,
                                                                                SV_CodHlr          OUT al_series.COD_HLR%TYPE,
                                                                            SV_CodCelda        OUT ge_celdas.COD_CELDA%TYPE,
                                                                                    SV_Region          OUT ge_direcciones.COD_REGION%TYPE,
                                                                                    SV_Provincia       OUT ge_direcciones.COD_PROVINCIA%TYPE,
                                                                                    SV_Ciudad          OUT ge_direcciones.COD_CIUDAD%TYPE,
                                                                                        SN_cod_retorno     OUT ge_errores_pg.CodError,
                                                    SV_mens_retorno    OUT ge_errores_pg.MsgError,
                                                    SN_num_evento      OUT ge_errores_pg.Evento) IS



        /*--
                        <Documentación TipoDoc = "Procedimiento">
                                Elemento Nombre = "VE_obtenerhomenonumerado_pr"
                                Lenguaje="PL/SQL"
                                Fecha="10-09-2007"
                                Versión="1.0.0"
                                Diseñador="NRCA"
                                Programador="NRCA"
                                Ambiente="BD"
                        <Retorno>
                                         SUBALM,CENTRAL,HLR,CELDA Y TELEFONO
                        </Retorno>
                        <Descripción>
                 obtiene central,hlr,subalm,celda en caso que la serie sea numerada
                                 en caso contrario solo devolvera el hlr.
                        </Descripción>
                        <Parámetros>
                        <Entrada>
                                <param nom="EV_numSerie" Tipo="STRING> numero de serie </param>
                        </Entrada>
                        <Salida>
                            <param nom="EV_numTelefono"         Tipo="NUMBER"> Numero Telefono </param>
                                <param nom="SN_CodSubalm"           Tipo="NUMBER"> Codigo Subalm </param>
                                <param nom="SV_CodCentral"          Tipo="STRING"> Codigo Central</param>
                                <param nom="SV_CodHLR"              Tipo="STRING"> codigo HLR </param>
                                <param nom="SV_CodCelda"            Tipo="STRING"> Codigo Celda </param>
                                <param nom="SN_cod_retorno"         Tipo="NUMBER"> codigo retorno </param>
                                <param nom="SV_mens_retorno"        Tipo="STRING"> glosa mensaje error </param>
                                <param nom="SN_num_evento"          Tipo="NUMBER"> numero de evento </param>
                        </Salida>
                        </Parámetros>
                        </Elemento>
                        </Documentación>
                        */
CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(30) := 'VE_obtenerhomenonumerado_pr';
CN_TIPOPROCESO        CONSTANT NUMBER       := 1;

ERROR_PROCEDIMIENTO   EXCEPTION;

LV_des_error      ge_errores_pg.desevent;
LV_sql                ge_errores_pg.vquery;
LV_NumTelefono    AL_SERIES.NUM_TELEFONO%TYPE;
LV_cadena         VARCHAR2(200);
LN_max            NUMBER(5);
LN_transaccion GA_TRANSACABO.num_transaccion%TYPE;
LA_arreglo tipoArray := tipoArray();

LV_COD_ERROR VARCHAR2(5):='0';


CURSOR CargaDatosNumeracion IS

  SELECT C.COD_SUBALM ,B.COD_CENTRAL,  A.COD_HLR, D.COD_CELDA
  FROM GSM_SIMCARD_TO A, ICG_CENTRAL B , TA_SUBCENTRAL C , GE_CELDAS D
  WHERE A.COD_HLR = B.COD_HLR
  AND B.COD_CENTRAL=C.COD_CENTRAL
  AND D.COD_SUBALM=C.COD_SUBALM
  AND A.NUM_SIMCARD= EV_NumIcc
  AND D.COD_CELDA=SV_CodCelda;

BEGIN
        SN_cod_retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;


        SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD, C.COD_CELDA
        INTO
        SV_Region,
        SV_Provincia,
        SV_Ciudad,
        SV_CodCelda
        FROM VE_VENDEDORES A,
        GE_DIRECCIONES B,
        GE_CIUCELDAS_TD C
        WHERE A.COD_DIRECCION=B.COD_DIRECCION
        AND B.COD_REGION=C.COD_REGION
        AND B.COD_PROVINCIA=C.COD_PROVINCIA
        AND B.COD_CIUDAD=C.COD_CIUDAD
        AND A.COD_VENDEDOR=EV_CodVendedor;

        OPEN CargaDatosNumeracion;
          LOOP
         FETCH CargaDatosNumeracion INTO SN_Codsubalm,SV_CodCentral,SV_CodHlr,SV_CodCelda;
             EXIT WHEN CargaDatosNumeracion%NOTFOUND;

             -- obtener numero de transaccion
                 LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                 VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                 IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_PROCEDIMIENTO;
                 END IF;

                 -- llamar procedimiento de numeracion automatica
                 LV_Sql := 'VE_NUMERACION_AUTOMATICA_PR('||LN_transaccion||','||EV_Actabo||','||SN_Codsubalm||','||SV_CodCentral||','||EV_uso||')';
                 VE_NUMERACION_AUTOMATICA_PR(LN_transaccion, EV_Actabo, SN_codsubalm, SV_codcentral, EV_uso);

                 --Incidencia 63093
                 SELECT COD_RETORNO
                 INTO LV_COD_ERROR
                 FROM GA_TRANSACABO
                 WHERE NUM_TRANSACCION = LN_transaccion;

                 IF LV_COD_ERROR <> '0' then
                        SN_cod_retorno  := LV_COD_ERROR;
                        SV_mens_retorno := 'No hay numeración disponible para realizar alta de Cliente';
                        RAISE ERROR_PROCEDIMIENTO;
                 END IF;
                 --Fin 63093

                -- verificamos estado del llamado
                LV_Sql := 'VE_obtiene_transaccion_PR('||LN_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_transaccion_PR(LN_transaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                LV_cadena:=SV_mens_retorno;

                IF (SN_cod_retorno = 0) THEN
                        LA_arreglo := VE_descompone_cadena_FN(LV_cadena,'/', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                                RAISE ERROR_PROCEDIMIENTO;
                        END IF;
                        LN_max := LA_arreglo.count;

                        SN_NumTelefono := LA_arreglo(1);
                        EXIT;
                END IF;
          END LOOP;

        CLOSE CargaDatosNumeracion;

        IF SN_Numtelefono is NULL THEN
                SN_cod_retorno  := 4;
            SV_mens_retorno := 'No se puede asignar numeración en forma automatica.';
           RAISE ERROR_PROCEDIMIENTO;
        END IF;

        EXCEPTION
                WHEN ERROR_PROCEDIMIENTO THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                WHEN OTHERS THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

END VE_obtenerhomenonumerado_pr;


PROCEDURE  VE_VALIDA_SERIE_GSM_PR (EV_NumSerie        IN  AL_SERIES.NUM_SERIE%TYPE,
                                                                   SN_cod_retorno     OUT ge_errores_pg.CodError,
                                           SV_mens_retorno    OUT ge_errores_pg.MsgError,
                                           SN_num_evento      OUT ge_errores_pg.Evento) IS



        /*--
                        <Documentación TipoDoc = "Procedimiento">
                                Elemento Nombre = "VE_VALIDA_SERIE_GSM_PR"
                                Lenguaje="PL/SQL"
                                Fecha="22-02-2008"
                                Versión="1.0.0"
                                Diseñador="NRCA"
                                Programador="NRCA"
                                Ambiente="BD"
                        <Retorno>
                                         Cod_retorno,Mensaje Retorno y Numero de evento
                        </Retorno>
                        <Descripción>
                 VALIDA SERIES EXTERNAS, QUE ESTAS NO SE ENCUENTREN EN LISTA NEGRA
                        </Descripción>
                        <Parámetros>
                        <Entrada>
                                <param nom="EV_numSerie" Tipo="STRING> numero de serie </param>
                        </Entrada>
                        <Salida>
                            <param nom="SN_cod_retorno"         Tipo="NUMBER"> codigo retorno </param>
                                <param nom="SV_mens_retorno"        Tipo="STRING"> glosa mensaje error </param>
                                <param nom="SN_num_evento"          Tipo="NUMBER"> numero de evento </param>
                        </Salida>
                        </Parámetros>
                        </Elemento>
                        </Documentación>
                        */
CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(30) := 'VE_obtenerhomenonumerado_pr';
CN_TIPOPROCESO        CONSTANT NUMBER       := 1;

ERROR_PROCEDIMIENTO   EXCEPTION;
LV_cadena         VARCHAR(200);
LV_des_error      ge_errores_pg.desevent;
LV_sql                ge_errores_pg.vquery;
LN_transaccion GA_TRANSACABO.num_transaccion%TYPE;

BEGIN
             SN_cod_retorno  := 0;
             SV_mens_retorno := NULL;
             SN_num_evento   := 0;
             -- obtener numero de transaccion
                 LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                 VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                 IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_PROCEDIMIENTO;
                 END IF;


                 LV_Sql := 'P_VALIDA_SERIE_GSM('||LN_transaccion||','||EV_NumSerie||')';
                 P_VALIDA_SERIE_GSM (LN_transaccion, EV_NumSerie);

                 -- verificamos estado del llamado
                LV_Sql := 'VE_obtiene_transaccion_PR('||LN_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_obtiene_transaccion_PR(LN_transaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                LV_cadena:=SV_mens_retorno;

                    IF (SN_cod_retorno <> 0) THEN
                            SN_cod_retorno  := 4;
                                RAISE ERROR_PROCEDIMIENTO;
                        END IF;


EXCEPTION
                WHEN ERROR_PROCEDIMIENTO THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                WHEN OTHERS THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

END VE_VALIDA_SERIE_GSM_PR;
PROCEDURE VE_NUMERACION_AUTOMATICA_PR(
  VP_TRANSAC IN VARCHAR2 ,
  VP_ACTABO IN VARCHAR2 ,
  VP_SUBALM IN VARCHAR2 ,
  VP_CENTRAL IN VARCHAR2 ,
  VP_USO IN VARCHAR2 )
IS PRAGMA AUTONOMOUS_TRANSACTION;
--
-- Procedimiento de recuperacion de numeracion seleccionada de forma
-- automatica en funcion del Subalm, Central y Uso de la linea
--
-- Los valores del codigo de retorno seran los siguientes :
--         - "0" ; Numero Seleccionado y Reservado
--         - "1" ; Rango Bloqueado Temporalmente
--         - "2" ; No Existe Numeracion para Asignar
--         - "4" ; Error en el proceso
--
   V_ERROR CHAR(1) := '2';
   V_CAT GA_CELNUM_USO.COD_CAT%TYPE;
   V_CELULAR GA_ABOCEL.NUM_CELULAR%TYPE;
   V_TABLA CHAR(1);
   V_FECBAJA DATE := NULL;
   V_CADENA GA_TRANSACABO.DES_CADENA%TYPE := NULL;
   ERROR_PROCESO EXCEPTION;
   V_FORMAT_FECHA  GA_TRANSACABO.DES_CADENA%TYPE;
BEGIN
   V_TABLA := 'R';
   P_SELECT_REUTILIZABLES (VP_ACTABO,VP_SUBALM,VP_CENTRAL,
                           VP_USO,V_CELULAR,V_CAT,V_FECBAJA,V_ERROR);
   IF V_ERROR = '2' THEN
      V_TABLA := 'L';
     P_SELECT_RANGOS (VP_ACTABO,VP_SUBALM,VP_CENTRAL,
                       VP_USO,V_CELULAR,V_CAT,V_ERROR);
   END IF;

   SELECT VAL_PARAMETRO INTO V_FORMAT_FECHA FROM GED_PARAMETROS
   WHERE COD_PRODUCTO = 1  AND COD_MODULO = 'GE' AND NOM_PARAMETRO = 'FORMATO_SEL2';

   IF V_ERROR = '0' THEN
      V_CADENA := '/'||TO_CHAR(V_CELULAR)||
                  '/'||V_TABLA||
                  '/'||TO_CHAR(V_CAT)||
                  '/'||TO_CHAR(V_FECBAJA,V_FORMAT_FECHA);
      INSERT INTO GA_TRANSACABO
                 (NUM_TRANSACCION,
                  COD_RETORNO,
                  DES_CADENA)
          VALUES (VP_TRANSAC,
                  V_ERROR,
                  V_CADENA);
      COMMIT;
   ELSif V_ERROR <> '2' then
      RAISE ERROR_PROCESO;
   END IF;
EXCEPTION
   WHEN ERROR_PROCESO THEN
           ROLLBACK;
           INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (VP_TRANSAC,
                   V_ERROR,
                   NULL);
           COMMIT;
   WHEN OTHERS THEN
           ROLLBACK;
           INSERT INTO GA_TRANSACABO
                  (NUM_TRANSACCION,
                   COD_RETORNO,
                   DES_CADENA)
           VALUES (VP_TRANSAC,
                   V_ERROR,
                   NULL);
           COMMIT;
END VE_NUMERACION_AUTOMATICA_PR;

PROCEDURE VE_reponeNumeracion_PR (EN_num_celular   IN  ga_resnumcel.num_celular%TYPE,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                             )
    IS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "VE_reponeNumeracion_PR"
    Lenguaje="PL/SQL"
    Fecha="12-10-2007"
    Versión="1.0.0"
    Diseñador="Héctor Hermosilla"
    Programador="Héctor Hermosilla"
    Ambiente="BD">
    <Retorno> Numero de celular </Retorno>
    <Descripción> Repone numero celular</Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EN_num_celular"  Tipo="NUMBER"> numero celular </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
    LN_num_transaccion NUMBER;
    LV_des_error        ge_errores_pg.desevent;
    LV_sql                ge_errores_pg.vquery;
    LV_codsubalm        ga_resnumcel.cod_subalm%TYPE;
    LN_central             ga_resnumcel.cod_central%TYPE;
    LN_categoria        ga_resnumcel.cod_cat%TYPE;
    LN_uso                 ga_resnumcel.cod_uso%TYPE;
    LE_exception_fin   EXCEPTION;
    BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

        -- obtener numero de transaccion
        LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
        VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF (SN_cod_retorno <> 0) THEN
            RAISE LE_exception_fin;
        END IF;

        LV_Sql := 'SELECT a.cod_subalm, a.cod_central,'
                  || ' a.cod_cat, a.cod_uso'
                  || ' FROM   ga_resnumcel a'
                  || ' WHERE  a.num_celular = EN_num_celular'
                  || ' AND ROWNUM <=1';

        SELECT a.cod_subalm, a.cod_central,
               a.cod_cat, a.cod_uso
        INTO   LV_codsubalm, LN_central,
               LN_categoria, LN_uso
        FROM   ga_resnumcel a
        WHERE  a.num_celular = EN_num_celular
        AND ROWNUM <=1;

        -- llamar procedimiento que realiza reposición de número celular
        LV_Sql := 'P_REPONER_NUMERACION('||LN_num_transaccion||',' ||CV_REPONE_CELULAR || ',' || LV_codsubalm ||','
                 || LN_central ||','|| LN_categoria || ',' || LN_uso || ',' || EN_num_celular ||','
                 || TO_CHAR(SYSDATE,'DD/MM/YYYY') ||')';
        P_REPONER_NUMERACION(LN_num_transaccion,CV_REPONE_CELULAR, LV_codsubalm, LN_central, LN_categoria, LN_uso, EN_num_celular,
                             TO_CHAR(SYSDATE,'DD/MM/YYYY'));

    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: VE_intermediario_PG.VE_reponeNumeracion_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_reponeNumeracion_PR', LV_Sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_reponeNumeracion_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_reponeNumeracion_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_reponeNumeracion_PR;

        PROCEDURE VE_reponeNumeracion_PR (EN_num_celular   IN  ga_resnumcel.num_celular%TYPE,
                                      EV_tip_repos     IN  VARCHAR2,
                                      SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                             )
    IS
    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "VE_reponeNumeracion_PR"
    Lenguaje="PL/SQL"
    Fecha="12-10-2007"
    Versión="1.0.0"
    Diseñador="Héctor Hermosilla"
    Programador="Héctor Hermosilla"
    Ambiente="BD">
    <Retorno> Numero de celular </Retorno>
    <Descripción> Repone numero celular</Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EN_num_celular"  Tipo="NUMBER"> numero celular </param>
            <param nom="EV_tip_repos"    Tipo="NUMBER"> tipo reposición </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
    LN_num_transaccion NUMBER;
    LV_des_error        ge_errores_pg.desevent;
    LV_sql                ge_errores_pg.vquery;
    LV_codsubalm        ga_resnumcel.cod_subalm%TYPE;
    LN_central             ga_resnumcel.cod_central%TYPE;
    LN_categoria        ga_resnumcel.cod_cat%TYPE;
    LN_uso                 ga_resnumcel.cod_uso%TYPE;
    LE_exception_fin   EXCEPTION;
    BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

        -- obtener numero de transaccion
        LV_Sql := 'VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_num_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
        VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_num_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        IF (SN_cod_retorno <> 0) THEN
            RAISE LE_exception_fin;
        END IF;

        LV_Sql := 'SELECT a.cod_subalm, a.cod_central,'
                  || ' a.cod_cat, a.cod_uso'
                  || ' FROM   ga_resnumcel a'
                  || ' WHERE  a.num_celular = EN_num_celular'
                  || ' AND ROWNUM <=1';

        SELECT a.cod_subalm, a.cod_central,
               a.cod_cat, a.cod_uso
        INTO   LV_codsubalm, LN_central,
               LN_categoria, LN_uso
        FROM   ga_resnumcel a
        WHERE  a.num_celular = EN_num_celular
        AND ROWNUM <=1;

        -- llamar procedimiento que realiza reposición de número celular
        LV_Sql := 'P_REPONER_NUMERACION('||LN_num_transaccion||',' ||EV_tip_repos || ',' || LV_codsubalm ||','
                 || LN_central ||','|| LN_categoria || ',' || LN_uso || ',' || EN_num_celular ||','
                 || TO_CHAR(SYSDATE,'DD/MM/YYYY') ||')';
        P_REPONER_NUMERACION(LN_num_transaccion,EV_tip_repos, LV_codsubalm, LN_central, LN_categoria, LN_uso, EN_num_celular,
                             TO_CHAR(SYSDATE,'DD/MM/YYYY'));

    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: VE_intermediario_PG.VE_reponeNumeracion_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_reponeNumeracion_PR', LV_Sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_reponeNumeracion_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_reponeNumeracion_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_reponeNumeracion_PR;
            PROCEDURE VE_ActualizaLimAbo_PR (EN_num_abonado   IN  ga_Abocel.num_abonado%TYPE,
                                             EN_MontoLimCons  IN  GA_LCABO_TO.IMP_LIMCONS%TYPE,
                                             SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                             )
    IS

    LN_num_transaccion NUMBER;
    LV_des_error        ge_errores_pg.desevent;
    LV_sql                ge_errores_pg.vquery;
    LV_codsubalm        ga_resnumcel.cod_subalm%TYPE;
    LN_central             ga_resnumcel.cod_central%TYPE;
    LN_categoria        ga_resnumcel.cod_cat%TYPE;
    LN_uso                 ga_resnumcel.cod_uso%TYPE;
    LE_exception_fin   EXCEPTION;
    LN_COUNT NUMBER(5);
    BEGIN

    SELECT COUNT(1)
    INTO LN_COUNT
    FROM GA_LCABO_TO
    WHERE NUM_ABONADO=EN_num_abonado;


    IF LN_COUNT <> 0 THEN


       LV_sql:='UDPATE GA_LCABO_TO'
       || 'SET IMP_LIMCONS= ' || EN_MontoLimCons
       || ' WHERE NUM_ABONADO= ' ||EN_num_abonado;


       UPDATE GA_LCABO_TO
       SET IMP_LIMCONS= EN_MontoLimCons
       WHERE NUM_ABONADO= EN_num_abonado;
    ELSE
       INSERT INTO GA_LCABO_TO (NUM_ABONADO,IMP_LIMCONS)
       VALUES(EN_num_abonado,EN_MontoLimCons);
    END IF;

    EXCEPTION
        WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: VE_intermediario_PG.VE_ActualizaLimAbo_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ActualizaLimAbo_PR', LV_Sql, SQLCODE, LV_des_error );
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_ActualizaLimAbo_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_ActualizaLimAbo_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_ActualizaLimAbo_PR;

--Inicio P-CSR-11002 JLGN 18-10-2011    
PROCEDURE VE_desArticulo_PR (EN_cod_articulo IN  al_articulos.cod_articulo%TYPE,
                             SV_des_articulo OUT NOCOPY al_articulos.des_articulo%TYPE,
                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS

    LV_sql                ge_errores_pg.vquery;
    LV_des_error        ge_errores_pg.desevent;

    BEGIN
    
    LV_sql:='SELECT des_articulo '
         || 'FROM   al_articulos '
         || 'WHERE  cod_articulo = '||EN_cod_articulo;

    SELECT des_articulo
    INTO   SV_des_articulo
    FROM   al_articulos
    WHERE  cod_articulo = EN_cod_articulo;
    
    EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.VE_desArticulo_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.VE_desArticulo_PR', LV_Sql, SQLCODE, LV_des_error );
    END VE_desArticulo_PR;
-- Fin P-CSR-11002 JLGN 18-10-2011    
--Inicio P-CSR-11002 JLGN 10-11-2011 
PROCEDURE ve_in_ruta_contrato_pg (en_num_venta    IN ga_ventas.num_venta%TYPE,
                                  ev_ruta         IN ve_ruta_contrato_venta_td.ruta_contrato%TYPE,
                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS

    LV_sql                ge_errores_pg.vquery;
    LV_des_error        ge_errores_pg.desevent;

    BEGIN
    
    LV_sql:='INSERT INTO ve_ruta_contrato_venta_td (num_venta,ruta_contrato) '
         || 'VALUES('||en_num_venta||','||ev_ruta||')';

    INSERT INTO ve_ruta_contrato_venta_td (num_venta,ruta_contrato)
    VALUES(en_num_venta,ev_ruta);
    
    EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.ve_in_ruta_contrato_pg ;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.ve_in_ruta_contrato_pg ', LV_Sql, SQLCODE, LV_des_error );
    END ve_in_ruta_contrato_pg ;
-- Fin P-CSR-11002 JLGN 10-11-2011    
--Inicio P-CSR-11002 JLGN 11-11-2011 
PROCEDURE ve_obt_ruta_contrato_pg (en_num_venta    IN ga_ventas.num_venta%TYPE,
                                   ev_ruta         OUT NOCOPY ve_ruta_contrato_venta_td.ruta_contrato%TYPE,
                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
IS

    LV_sql                ge_errores_pg.vquery;
    LV_des_error        ge_errores_pg.desevent;

    BEGIN
    
    LV_sql:='SELECT ruta_contrato '
         || 'FROM   ve_ruta_contrato_venta_td '
         || 'WHERE  num_venta = '||en_num_venta;

    SELECT ruta_contrato
    INTO   ev_ruta 
    FROM   ve_ruta_contrato_venta_td
    WHERE  num_venta = en_num_venta;
    
    EXCEPTION
        WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_error_no_clasif;
                END IF;
                LV_des_error:='OTHERS:VE_intermediario_PG.ve_obt_ruta_contrato_pg ;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_intermediario_PG.ve_obt_ruta_contrato_pg ', LV_Sql, SQLCODE, LV_des_error );
    END ve_obt_ruta_contrato_pg ;
-- Fin P-CSR-11002 JLGN 11-11-2011    

PROCEDURE VE_obtiene_numero_movi_PR(EV_numserie      IN ga_equipaboser.NUM_SERIE%TYPE,
                                          SN_nummovimiento  OUT NOCOPY ga_equipaboser.NUM_MOVIMIENTO%TYPE,
                                          SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

        /*
        <Documentaci¢n TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_obtiene_numero_movi_PR"
                Lenguaje="PL/SQL"
                Fecha="26-09-2012"
                Versi¢n="1.0.0"
                Dise¤ador="CGR"
                Programador="CGR"
                Ambiente="BD"
        <Retorno> Retorna el valor del numero de movimiento </Retorno>
        <Descripci¢n>
                Retorna el valor del movimiento
        </Descripci¢n>
        <Par metros>
         <Entrada>
                   <param nom="EV_numserie" Tipo="VARCHAR2(25)">numero serie</param>
                 </Entrada>
         <Salida>
                   <param nom="SN_nummovimiento Tipo="NUMBER">valor numero de movimiento</param>
                   <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                    <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                 </Salida>
        </Par metros>
        </Elemento>
        </Documentaci¢n>
        */
        LV_des_error ge_errores_pg.desevent;
        LV_sql           ge_errores_pg.vquery;
BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

        LV_Sql:=' SELECT a.num_movimiento '
                         || 'FROM   al_movimientos a '
                         || 'WHERE a.num_serie = ' || EV_numserie 
                     || ' AND a.fec_movimiento IN (SELECT MAX (fec_movimiento)'
                     || ' FROM al_movimientos'
                     || ' WHERE a.num_serie = ' || EV_numserie ||')'
                     || ' AND a.tip_movimiento = 3;';
                     
                     
                     

        SELECT a.num_movimiento
        INTO   SN_nummovimiento
        FROM   al_movimientos a
        WHERE a.num_serie = EV_numserie
        AND a.fec_movimiento IN (SELECT MAX (fec_movimiento)
                                  FROM al_movimientos
                                 WHERE num_serie = EV_numserie)
        AND a.tip_movimiento = 3; 

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SN_cod_retorno := 778;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error := 'NO_DATA_FOUND:VE_intermediario_PG.VE_obtiene_numero_movi_PR;- ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
        'VE_estado_proceso_PG.VE_obtiene_numero_movi_PR', LV_Sql, SQLCODE, LV_des_error );
    WHEN OTHERS THEN
        SN_cod_retorno := 156;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno:=CV_error_no_clasif;
        END IF;
        LV_des_error:='OTHERS:VE_intermediario_PG.VE_obtiene_numero_movi_PR;- ' || SQLERRM;
        SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
        'VE_intermediario_PG.VE_obtiene_numero_movi_PR', LV_Sql, SQLCODE, LV_des_error );
        
END VE_obtiene_numero_movi_PR;

END VE_INTERMEDIARIO_PG;
/
SHOW ERRORS