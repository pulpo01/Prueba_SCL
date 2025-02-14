CREATE OR REPLACE PACKAGE BODY SISCEL.VE_servicios_direcciones_PG IS

        --------------------
        -- PROCEDIMIENTOS --
        --------------------

        PROCEDURE VE_getDireccion_PR(EV_codSujeto      IN  VARCHAR2,
                                     EN_tipSujeto      IN  NUMBER,
                                     EN_tipDireccion   IN  NUMBER,
                                     EN_tipDisplay     IN  NUMBER,
                                                                 SV_cod_region     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_provincia  OUT NOCOPY VARCHAR2,
                                                                 SV_cod_ciudad     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_comuna     OUT NOCOPY VARCHAR2,
                                                                 SV_nom_calle      OUT NOCOPY VARCHAR2,
                                                                 SV_num_calle      OUT NOCOPY VARCHAR2,
                                                                 SV_num_piso       OUT NOCOPY VARCHAR2,
                                                                 SV_num_casilla    OUT NOCOPY VARCHAR2,
                                                                 SV_obs_direccion  OUT NOCOPY VARCHAR2,
                                                                 SV_des_direc1     OUT NOCOPY VARCHAR2,
                                                                 SV_des_direc2     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_pueblo     OUT NOCOPY VARCHAR2,
                                                                 SV_cod_estado     OUT NOCOPY VARCHAR2,
                                                                 SV_zip                    OUT NOCOPY VARCHAR2,
                                                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getDireccion_PR"
                        Lenguaje="PL/SQL"
                        Fecha="12-04-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                        Retorna direccion del cliente
                </Retorno>
                <Descripción>
                        Retorna direccion del cliente
                </Descripción>
                <Parámetros>
                <Entrada>
                        <param nom="EV_codSujeto"    Tipo="VARCHAR2"> copdigo tipo de sujero </param>
                        <param nom="EV_tipSujeto"    Tipo="VARCHAR2"> tipo de sujero </param>
                        <param nom="EV_tipDireccion" Tipo="VARCHAR2"> tipo direccion </param>
                        <param nom="EV_tipDisplay"   Tipo="VARCHAR2"> tipo display (descr. corta o larga) </param>
                </Entrada>
                <Salida>
                        <param nom="SV_valor"        Tipo="VARCHAR2"> direccion cliente </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER">codigo de retorno del procedimiento</param>
                        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                        <param nom="SN_num_evento"   Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LE_exception_fin   EXCEPTION;
                LA_arreglo1 VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();
                LA_arreglo2 VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();

                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;

                LV_string       VARCHAR2(500);
                LV_dato1        VARCHAR2(100);
                LV_dato2        VARCHAR2(100);
                LN_indice1      NUMBER;
                LN_indice2      NUMBER;
                LN_columna      NUMBER;
                LV_valorColumna VARCHAR2(100);
        BEGIN
                SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

                SV_cod_region     := '';
                SV_cod_provincia  := '';
                SV_cod_ciudad     := '';
                SV_cod_comuna     := '';
                SV_nom_calle      := '';
                SV_num_calle      := '';
                SV_num_piso       := '';
                SV_num_casilla    := '';
                SV_obs_direccion  := '';
                SV_des_direc1     := '';
                SV_des_direc2     := '';
                SV_cod_pueblo     := '';
                SV_cod_estado     := '';
                SV_zip            := '';

                LV_Sql:='SELECT GE_FN_OBTIENE_DIRCLIE(EV_codSujeto,EV_tipSujeto,EV_tipDireccion,EV_tipDisplay)'
                                 || ' FROM DUAL ';

                SELECT GE_FN_OBTIENE_DIRCLIE(EV_codSujeto,EN_tipSujeto,EN_tipDireccion,EN_tipDisplay)
                INTO LV_string
                FROM DUAL;

                IF (EN_tipDisplay = 1) THEN
                -- tipo display 1 (descripcion corta direccion)
                        SV_des_direc1 := LV_string;
                ELSE
                -- tipo display 2 (codigos direccion) 3 (descripcion completa direccion)

                        LA_arreglo1 := VE_intermediario_PG.VE_descompone_cadena_FN(LV_string,';', SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                                RAISE LE_exception_fin;
                        END IF;

                        -- Recorremos arreglo que contiene la direccion
                        LN_indice1 := 1;
                        FOR LN_indice1 IN 1..LA_arreglo1.COUNT-1 LOOP
                                LV_dato1 := LA_arreglo1(LN_indice1);

                                LA_arreglo2 := VE_intermediario_PG.VE_descompone_cadena_FN(LV_dato1,':', SN_cod_retorno, SV_mens_retorno, SN_num_evento);
                                IF (SN_cod_retorno <> 0) THEN
                                        RAISE LE_exception_fin;
                                END IF;

                                -- Obtenemos identificador columna y valor columna
                                FOR LN_indice2 IN 1..LA_arreglo2.COUNT LOOP
                                        LV_dato2 := LA_arreglo2(LN_indice2);

                                        IF (LN_indice2 = 1) THEN
                                           LN_columna := LA_arreglo2(LN_indice2);
                                        END IF;

                                        IF (EN_tipDisplay = 2 AND LN_indice2 = 2) THEN
                                           LV_valorColumna := LA_arreglo2(LN_indice2);
                                        END IF;

                                        IF (EN_tipDisplay = 3 AND LN_indice2 = 3) THEN
                                           LV_valorColumna := LA_arreglo2(LN_indice2);
                                        END IF;

                                        IF (LV_valorColumna = '0') THEN
                                           LV_valorColumna := '';
                                        END IF;

                                END LOOP;

                                CASE LN_columna
                                        WHEN CN_REGION      THEN SV_cod_region    := LV_valorColumna;
                                        WHEN CN_PROVINCIA       THEN SV_cod_provincia := LV_valorColumna;
                                        WHEN CN_CIUDAD      THEN SV_cod_ciudad    := LV_valorColumna;
                                        WHEN CN_COMUNA      THEN SV_cod_comuna    := LV_valorColumna;
                                        WHEN CN_CALLE       THEN SV_nom_calle     := LV_valorColumna;
                                        WHEN CN_NUMERO      THEN SV_num_calle     := LV_valorColumna;
                                        WHEN CN_PISO            THEN SV_num_piso      := LV_valorColumna;
                                        WHEN CN_CASILLA     THEN SV_num_casilla   := LV_valorColumna;
                                        WHEN CN_OBSERVACION     THEN SV_obs_direccion := LV_valorColumna;
                                        WHEN CN_DES_DIREC1      THEN SV_des_direc1    := LV_valorColumna;
                                        WHEN CN_DES_DIREC2      THEN SV_des_direc2    := LV_valorColumna;
                                        WHEN CN_PUEBLO      THEN SV_cod_pueblo    := LV_valorColumna;
                                        WHEN CN_ESTADO      THEN SV_cod_estado    := LV_valorColumna;
                                        WHEN CN_ZIP                     THEN SV_zip           := LV_valorColumna;
                                        ELSE --_output.put_line('ERROR, en identificador columna' || LV_valorColumna);
                                             RAISE LE_exception_fin;
                                END CASE;

                        END LOOP;

                END IF;

        EXCEPTION
                WHEN LE_exception_fin THEN
                SN_cod_retorno := 3;
                LV_des_error:='LE_exception_fin: VE_servicios_direcciones_PG.VE_getDireccion_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_getDireccion_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_ERRORNOCLASIF;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_getDireccion_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_getDireccion_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error := 'OTHERS:VE_servicios_direcciones_PG.VE_getDireccion_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_getDireccion_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_getDireccion_PR;

        --------------------------------------------------------------------------------------------
        --* CURSORES - LISTAS
        --------------------------------------------------------------------------------------------
        PROCEDURE VE_getListConfigDirecciones_PR(EV_codOperadora IN ge_paramdiroperad.cod_operad%TYPE,
                                                 SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                                     SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                     SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListConfigDirecciones_PR"
                        Lenguaje="PL/SQL"
                        Fecha="15-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna configuracion que deben tener las operadoras
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_codOperadora" Tipo="STRING"> codigo operadora </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                NO_DATA_FOUND_CURSOR EXCEPTION;
                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LN_contador  NUMBER;
         BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='SELECT a.cod_paramdir, '
                        || 'a.tip_dat, '
                        || 'a.sec_dat, '
                        || 'a.caption, '
                        || 'a.nom_column, '
                        || 'a.tip_format, '
                        || 'b.orden, '
                        || 'b.ind_obligatorio, '
                        || 'a.largo '
                        || 'FROM ge_paramdir a, ge_paramdiroperad b '
                        || 'WHERE b.cod_operad = ''' || EV_codOperadora || ''''
                        || 'AND b.cod_paramdir = a.cod_paramdir '
            || 'ORDER BY b.orden';

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ge_paramdir a, ge_paramdiroperad b
                WHERE b.cod_operad = EV_codOperadora
                AND b.cod_paramdir = a.cod_paramdir
                ORDER BY b.orden;

                OPEN SC_cursorDatos FOR
                SELECT a.cod_paramdir,
                       a.tip_dat,
                           a.sec_dat,
                           a.caption,
                           a.nom_column,
                           a.tip_format,
                           b.orden,
                           b.ind_obligatorio,
                           a.largo
                FROM ge_paramdir a, ge_paramdiroperad b
                WHERE b.cod_operad = EV_codOperadora
                AND b.cod_paramdir = a.cod_paramdir
                ORDER BY b.orden;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_servicios_direcciones_PG.VE_getListConfigDirecciones_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_servicios_direcciones_PG.VE_getListConfigDirecciones_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_getListConfigDirecciones_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_getListConfigDirecciones_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_getListConfigDirecciones_PR;

        PROCEDURE VE_getListComunas_PR(EV_codRegion    IN  ge_ciucom.cod_region%TYPE,
                                       EV_codProvincia IN  ge_ciucom.cod_provincia%TYPE,
                                                                   EV_codCiudad    IN  ge_ciucom.cod_ciudad%TYPE,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListComunas_PR"
                        Lenguaje="PL/SQL"
                        Fecha="15-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna listado de comunas segun parametros de entrada
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_codRegion"    Tipo="STRING"> codigo region </param>
                           <param nom="EN_codProvincia" Tipo="STRING"> codigo provinvia </param>
                           <param nom="EN_codCiudad"    Tipo="STRING"> codigo ciudad </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                NO_DATA_FOUND_CURSOR EXCEPTION;
                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LN_contador  NUMBER;
         BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                IF (EV_codCiudad IS NOT NULL ) AND (length(EV_codCiudad)) > 0 THEN

                   SELECT COUNT(1)
                   INTO LN_contador
                   FROM ge_ciucom a, ge_comunas b
                   WHERE a.cod_region = EV_codRegion
                   AND a.cod_provincia = EV_codProvincia
                   AND a.cod_ciudad = EV_codCiudad
                   AND a.cod_region = b.cod_region
                   AND a.cod_provincia = b.cod_provincia
                   AND a.cod_comuna = b.cod_comuna;

                   LV_Sql:='SELECT a.cod_comuna, b.des_comuna '
                   || ' FROM ge_ciucom a, ge_comunas b '
                   || ' WHERE a.cod_region = ''' || EV_codRegion || ''''
                   || ' AND a.cod_provincia = ''' || EV_codProvincia || ''''
                   || ' AND a.cod_ciudad = ''' || EV_codCiudad || ''''
                   || ' AND a.cod_region = b.cod_region '
                   || ' AND a.cod_provincia = b.cod_provincia '
                   || ' AND a.cod_comuna = b.cod_comuna';

                ELSE

                   SELECT COUNT(1)
                   INTO LN_contador
                   FROM ge_comunas a
                   WHERE a.cod_region = EV_codRegion
                   AND a.cod_provincia = EV_codProvincia;

                   LV_Sql:='SELECT a.cod_comuna, a.des_comuna '
                   || ' FROM ge_comunas a '
                   || ' WHERE a.cod_region = ''' || EV_codRegion || ''''
                   || ' AND a.cod_provincia = ''' || EV_codProvincia || '''';

                END IF;

                OPEN SC_cursordatos FOR LV_Sql;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_servicios_direcciones_PG.VE_getListComunas_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_servicios_direcciones_PG.VE_getListComunas_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_getListComunas_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_getListComunas_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_getListComunas_PR;

        PROCEDURE VE_getListEstados_PR(EV_indOrden     IN VARCHAR2,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListEstados_PR"
                        Lenguaje="PL/SQL"
                        Fecha="15-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna listado de estados
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_indOrden" Tipo="STRING"> indicador orden </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                NO_DATA_FOUND_CURSOR EXCEPTION;
                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LN_contador  NUMBER;
         BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:= 'SELECT a.cod_estado, a.des_estado '
                        || 'FROM ge_estados a ';
                IF (EV_indOrden = 'S')THEN
                   LV_Sql:= LV_Sql || 'ORDER BY 2';
                END IF;

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ge_estados;

                OPEN SC_cursorDatos FOR LV_Sql;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_servicios_direcciones_PG.VE_getListEstados_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_servicios_direcciones_PG.VE_getListEstados_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_getListEstados_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_getListEstados_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_getListEstados_PR;

        PROCEDURE VE_getListPueblos_PR(EV_codEstado    IN ge_pueblos.cod_estado%TYPE,
                                       EV_indOrden     IN VARCHAR2,
                                       SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                               SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListPueblos_PR"
                        Lenguaje="PL/SQL"
                        Fecha="15-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna listado de pueblos segun cosigo de estado
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_indOrden" Tipo="STRING"> indicador orden </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                NO_DATA_FOUND_CURSOR EXCEPTION;
                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LN_contador  NUMBER;
         BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:= 'SELECT a.cod_pueblo, a.des_pueblo '
                        || 'FROM ge_pueblos a '
                        || 'WHERE a.cod_estado = ''' || EV_codEstado || '''';
                IF (EV_indOrden = 'S')THEN
                   LV_Sql:= LV_Sql || ' ORDER BY 2';
                END IF;

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ge_pueblos a
                WHERE a.cod_estado = EV_codEstado;

                OPEN SC_cursorDatos FOR LV_Sql;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_servicios_direcciones_PG.VE_getListPueblos_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_servicios_direcciones_PG.VE_getListPueblos_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_getListPueblos_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_getListPueblos_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_getListPueblos_PR;

        PROCEDURE VE_getListZip_PR(EV_codZona      IN ge_zipcode_td.COD_ZONA%TYPE,
                                   SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                           SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListZip_PR"
                        Lenguaje="PL/SQL"
                        Fecha="15-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna listado de ZIP segun zona.
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codZona" Tipo="STRING"> codigo zona </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                NO_DATA_FOUND_CURSOR EXCEPTION;
                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LN_contador  NUMBER;
         BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:= 'SELECT a.zip '
                        || 'FROM ge_zipcode_td a '
                        || 'WHERE a.cod_zona = ''' || EV_codZona || '''';

                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ge_zipcode_td a
        WHERE a.cod_zona = EV_codZona;

                OPEN SC_cursorDatos FOR
                SELECT a.zip
                FROM ge_zipcode_td a
        WHERE a.cod_zona = EV_codZona;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_servicios_direcciones_PG.VE_getListZip_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_servicios_direcciones_PG.VE_getListZip_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_getListZip_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_getListZip_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_getListZip_PR;

        PROCEDURE VE_listadoregiones_PR(EV_indOrden      IN VARCHAR2,
                                                                        SC_cursordatos   OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_listadoregiones_PR"
                Lenguaje="PL/SQL"
                Fecha="21-03-2007"
                Versión="1.0.0"
                Diseñador="Roberto Pérez Varas"
                Programador="Roberto Pérez Varas"
                Ambiente="BD"
        <Retorno>Listado de regiones</Retorno>
        <Descripción>
                Listado de regiones
        </Descripción>
        <Parametros>
        <Entrada> NA</Entrada>
        <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con regiones</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentación>
        */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
                LN_count          NUMBER(1);
                LE_no_data_found_cursor EXCEPTION;
    BEGIN
            SN_cod_retorno  := 0;
                SV_mens_retorno := NULL;
                SN_num_evento   := 0;
        LV_Sql:= 'SELECT region.cod_region, region.des_region'
                 || ' FROM ge_regiones region';
                IF (EV_indOrden = 'S')THEN
                   LV_Sql:= LV_Sql || ' ORDER BY 2';
                END IF;

        SELECT COUNT(1)
                INTO   LN_count
        FROM   ge_regiones region
                WHERE  ROWNUM <= 1;

        OPEN SC_cursordatos FOR LV_Sql;

                IF LN_count = 0 THEN
                    RAISE LE_no_data_found_cursor;
                END IF;

                EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_listadoregiones_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadoregiones_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_listadoregiones_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadoregiones_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='OTHERS:VE_servicios_direcciones_PG.VE_listadoregiones_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadoregiones_PR()', LV_Sql, SQLCODE, LV_des_error );
        END VE_listadoregiones_PR;

    PROCEDURE VE_listadoprovincias_PR(EV_codregion     IN  ge_regiones.cod_region%TYPE,
                                          EV_indOrden      IN VARCHAR2,
                                                                          SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                      SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                      SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_listadoprovincias_PR"
                Lenguaje="PL/SQL"
                Fecha="21-03-2007"
                Versión="1.0.0"
                Diseñador="Roberto Pérez Varas"
                Programador="Roberto Pérez Varas"
                Ambiente="BD"
        <Retorno>Listado de provincias</Retorno>
        <Descripción>
                Listado de provincias
        </Descripción>
        <Parametros>
        <Entrada>
        <param nom="EV_codregion" Tipo="VARCHAR2">codigo region</param>
        </Entrada>
        <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con provincias</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentación>
        */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
                LN_count          NUMBER(1);
                LE_no_data_found_cursor EXCEPTION;
    BEGIN
            SN_cod_retorno  := 0;
                SV_mens_retorno := NULL;
                SN_num_evento   := 0;

        LV_Sql:= 'SELECT provincia.cod_provincia, provincia.des_provincia'
                 || ' FROM ge_provincias provincia'
                                 || ' WHERE provincia.cod_region = ''' || EV_codregion || '''';
                IF (EV_indOrden = 'S')THEN
                   LV_Sql:= LV_Sql || ' ORDER BY 2';
                END IF;

        SELECT COUNT(1)
                INTO   LN_count
        FROM   ge_provincias provincia
                WHERE  provincia.cod_region = EV_codregion
                AND        ROWNUM <= 1;

        OPEN SC_cursordatos FOR LV_Sql;

                IF LN_count = 0 THEN
                    RAISE LE_no_data_found_cursor;
                END IF;

                EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_listadoprovincias_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadoprovincias_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_listadoprovincias_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadoprovincias_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='OTHERS:VE_servicios_direcciones_PG.VE_listadoprovincias_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadoprovincias_PR()', LV_Sql, SQLCODE, LV_des_error );
        END VE_listadoprovincias_PR;


    PROCEDURE VE_listadociudades_PR(EV_codregion     IN  ge_regiones.cod_region%TYPE,
                                    EV_codprovincia  IN  ge_provincias.cod_provincia%TYPE,
                                                                        EV_indOrden      IN VARCHAR2,
                                        SC_cursordatos   OUT NOCOPY REFCURSOR,
                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento    OUT NOCOPY ge_errores_pg.Evento)
        /*--
        <Documentación TipoDoc = "Procedimiento">
                Elemento Nombre = "VE_listadociudades_PR"
                Lenguaje="PL/SQL"
                Fecha="21-03-2007"
                Versión="1.0.0"
                Diseñador="Roberto Pérez Varas"
                Programador="Roberto Pérez Varas"
                Ambiente="BD"
        <Retorno>Listado de ciudades</Retorno>
        <Descripción>
                Listado de ciudades
        </Descripción>
        <Parametros>
        <Entrada>
        <param nom="EV_codregion" Tipo="VARCHAR2">codigo region</param>
        <param nom="EV_codprovincia" Tipo="VARCHAR2">codigo provincia</param>
        </Entrada>
        <Salida>
        <param nom="SC_cursordatos"  Tipo="CURSOR">cursor con ciudades</param>
        <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
        <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentación>
        */
    IS
        LV_des_error  ge_errores_pg.desevent;
        LV_Sql        ge_errores_pg.vquery;
        LN_count          NUMBER(1);
        LE_no_data_found_cursor EXCEPTION;
        LV_ciudad GE_CIUDADES.COD_CIUDAD%TYPE;
    BEGIN
            SN_cod_retorno  := 0;
                SV_mens_retorno := NULL;
                SN_num_evento   := 0;

        SELECT VAL_PARAMETRO
        INTO LV_ciudad
        FROM ged_parametros
        where nom_parametro = 'CIUDAD_DEFAULT';

               LV_Sql:= 'SELECT ciudad.cod_ciudad, ciudad.des_ciudad';
               LV_Sql:= LV_Sql || ' FROM ge_ciudades ciudad';
               LV_Sql:= LV_Sql || ' WHERE ciudad.cod_region = ''' || EV_codregion || '''';
               LV_Sql:= LV_Sql || ' AND ciudad.cod_provincia = ''' || EV_codprovincia || '''';
               LV_Sql:= LV_Sql || ' union ' ;
               LV_Sql:= LV_Sql || ' SELECT ciudad.cod_ciudad, ciudad.des_ciudad';
               LV_Sql:= LV_Sql || ' FROM ge_ciudades ciudad';
               LV_Sql:= LV_Sql || ' WHERE ciudad.cod_region = ''' || EV_codregion || '''';
               LV_Sql:= LV_Sql || ' AND ciudad.cod_provincia = ''' || EV_codprovincia || '''';
               LV_Sql:= LV_Sql || ' AND ciudad.cod_ciudad = ''' || LV_ciudad || '''';


                IF (EV_indOrden = 'S')THEN
                   LV_Sql:= LV_Sql || ' ORDER BY 2';
                END IF;


        SELECT COUNT(1)
                INTO   LN_count
        FROM   ge_ciudades ciudad
        WHERE  ciudad.cod_region = EV_codregion
        AND    ciudad.cod_provincia = EV_codprovincia
                AND        ROWNUM <= 1;

        OPEN SC_cursordatos FOR LV_Sql;


                IF LN_count = 0 THEN
                    RAISE LE_no_data_found_cursor;
                END IF;

                EXCEPTION
            WHEN LE_no_data_found_cursor THEN
                SN_cod_retorno:=0;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_listadociudades_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadociudades_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN NO_DATA_FOUND THEN
                SN_cod_retorno:=1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_listadociudades_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadociudades_PR()', LV_Sql, SQLCODE, LV_des_error );
            WHEN OTHERS THEN
                SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error:='OTHERS:VE_servicios_direcciones_PG.VE_listadociudades_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_listadociudades_PR()', LV_Sql, SQLCODE, LV_des_error );
        END VE_listadociudades_PR;

        PROCEDURE VE_getListTiposCalles_PR(SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                   SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListTiposCalles_PR"
                        Lenguaje="PL/SQL"
                        Fecha="10-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Cursor
                </Retorno>
                <Descripción>
                                  Retorna listado de tipos de direcciones
                </Descripción>
                <Parámetros>
                 <Entrada> N/A </Entrada>
                 <Salida>
                           <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                NO_DATA_FOUND_CURSOR EXCEPTION;
                LV_desError  ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;
                LN_contador  NUMBER;
         BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:= 'SELECT a.valor,a.descripcion_valor'
                          || ' FROM ge_tipos_calles_vw';

                LN_contador := 0;

                SELECT COUNT(1)
                INTO LN_contador
                FROM ge_tipos_calles_vw;

                OPEN SC_cursorDatos FOR
                SELECT a.valor,a.descripcion_valor
                FROM ge_tipos_calles_vw a;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_codRetorno:=1;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                            SV_menRetorno := CV_ERRORNOCLASIF;
                         END IF;
                         LV_desError   := SUBSTR('NO_DATA_FOUND_CURSOR:VE_servicios_direcciones_PG.VE_getListTiposCalles_PR;- '|| SQLERRM,1,CN_LARGOERRTEC);
                         SV_menRetorno := SUBSTR(SV_menRetorno,1,CN_LARGODESC);
                                 SN_numEvento  := Ge_Errores_Pg.Grabarpl(SN_numEvento,CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'VE_servicios_direcciones_PG.VE_getListTiposCalles_PR', LV_Sql, SN_codRetorno, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_getListTiposCalles_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_getListTiposCalles_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_getListTiposCalles_PR;

        --------------------------------------------------------------------------------------------
        --* INSERTS y UPDATES
        --------------------------------------------------------------------------------------------

        PROCEDURE VE_updDireccion_PR(EN_cod_direccion IN  NUMBER,
                                 EV_cod_provincia IN  VARCHAR2,
                                                                 EV_cod_region    IN  VARCHAR2,
                                                                 EV_cod_ciudad    IN  VARCHAR2,
                                                                 EV_cod_comuna    IN  VARCHAR2,
                                                                 EV_nom_calle     IN  VARCHAR2,
                                                                 EV_num_calle     IN  VARCHAR2,
                                                                 EV_num_piso      IN  VARCHAR2,
                                                                 EV_num_casilla   IN  VARCHAR2,
                                                                 EV_obs_direccion IN  VARCHAR2,
                                                                 EV_des_direc1    IN  VARCHAR2,
                                                                 EV_des_direc2    IN  VARCHAR2,
                                                                 EV_cod_pueblo    IN  VARCHAR2,
                                                                 EV_cod_estado    IN  VARCHAR2,
                                                                 EV_zip           IN  VARCHAR2,
                                                                 EV_cod_tipo_calle  IN  VARCHAR2,
                                                             SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_updDireccion_PR"
                        Lenguaje="PL/SQL"
                        Fecha="21-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Actualiza direccion
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
                   <param nom="EV_cod_provincia"  Tipo="STRING"> codigo provincia </param>
                   <param nom="EV_cod_region"     Tipo="STRING"> codigo region </param>
                   <param nom="EV_cod_ciudad"     Tipo="STRING"> codigo ciudad </param>
                   <param nom="EV_cod_comuna"     Tipo="STRING"> codigo cimuna </param>
                   <param nom="EV_nom_calle"      Tipo="STRING"> nombre calle </param>
                   <param nom="EV_num_calle"      Tipo="STRING"> numero calle </param>
                   <param nom="EV_num_piso"       Tipo="STRING"> numero piso </param>
                   <param nom="EV_num_casilla"    Tipo="STRING"> numero casilla </param>
                   <param nom="EV_obs_direccion"  Tipo="STRING"> observacion </param>
                   <param nom="EV_des_direc1"     Tipo="STRING"> descripcion 1 </param>
                   <param nom="EV_des_direc2"     Tipo="STRING"> descripcion 2 </param>
                   <param nom="EV_cod_pueblo"     Tipo="STRING"> codigo pueblo </param>
                   <param nom="EV_cod_estado"     Tipo="STRING"> codigo estado </param>
                   <param nom="EV_zip"                    Tipo="STRING"> zip </param>
                            <param nom="EV_cod_tipo_calle    Tipo="STRING"> tipo de calle </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='UPDATE ge_direcciones a '
                    || ' SET a.cod_provincia = ' ||  EV_cod_provincia
                        || ' a.cod_region    = ' ||  EV_cod_region
                        || ' a.cod_ciudad    = ' ||  EV_cod_ciudad
                        || ' a.cod_comuna    = ' ||  EV_cod_comuna
                        || ' a.nom_calle     = ' ||  EV_nom_calle
                        || ' a.num_calle     = ' ||  EV_num_calle
                        || ' a.num_piso      = ' ||  EV_num_piso
                        || ' a.num_casilla   = ' ||  EV_num_casilla
                        || ' a.obs_direccion = ' ||  EV_obs_direccion
                        || ' a.des_direc1    = ' ||  EV_des_direc1
                        || ' a.des_direc2    = ' ||  EV_des_direc2
                        || ' a.cod_pueblo    = ' ||  EV_cod_pueblo
                        || ' a.cod_estado    = ' ||  EV_cod_estado
                        || ' a.zip           = ' ||  EV_zip
                        || ' a.cod_tipocalle = ' ||  EV_cod_tipo_calle
                    || ' WHERE a.cod_direccion = ' || EN_cod_direccion;

                UPDATE ge_direcciones a
                SET a.cod_provincia = EV_cod_provincia,
                        a.cod_region    = EV_cod_region,
                        a.cod_ciudad    = EV_cod_ciudad,
                        a.cod_comuna    = EV_cod_comuna,
                        a.nom_calle     = EV_nom_calle,
                        a.num_calle     = EV_num_calle,
                        a.num_piso      = EV_num_piso,
                        a.num_casilla   = EV_num_casilla,
                        a.obs_direccion = EV_obs_direccion,
                       /* a.des_direc1    = EV_des_direc1,
                        a.des_direc2    = EV_des_direc2, */
                        a.des_direc1    = trim(replace(replace(EV_des_direc1,chr(10),''),chr(13),'')),
                        a.des_direc2    = trim(replace(replace(EV_des_direc2,chr(10),''),chr(13),'')), /*INC 201432*/
                        a.cod_pueblo    = EV_cod_pueblo,
                        a.cod_estado    = EV_cod_estado,
                        a.zip           = EV_zip,
                        a.cod_tipocalle = EV_cod_tipo_calle
                WHERE a.cod_direccion = EN_cod_direccion;

        EXCEPTION
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_updDireccion_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_updDireccion_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_updDireccion_PR;

        PROCEDURE VE_getDireccionCodigo_PR(EN_cod_direccion IN  NUMBER,
                                       SV_cod_provincia OUT NOCOPY  VARCHAR2,
                                                                       SV_cod_region    OUT NOCOPY  VARCHAR2,
                                                                       SV_cod_ciudad    OUT NOCOPY  VARCHAR2,
                                                                       SV_cod_comuna    OUT NOCOPY  VARCHAR2,
                                                                       SV_nom_calle     OUT NOCOPY  VARCHAR2,
                                                                       SV_num_calle     OUT NOCOPY  VARCHAR2,
                                                                       SV_num_piso      OUT NOCOPY  VARCHAR2,
                                                                       SV_num_casilla   OUT NOCOPY  VARCHAR2,
                                                                           SV_obs_direccion OUT NOCOPY  VARCHAR2,
                                                                           SV_des_direc1    OUT NOCOPY  VARCHAR2,
                                                                           SV_des_direc2    OUT NOCOPY  VARCHAR2,
                                                                           SV_cod_pueblo    OUT NOCOPY  VARCHAR2,
                                                                           SV_cod_estado    OUT NOCOPY  VARCHAR2,
                                                                           SV_zip           OUT NOCOPY  VARCHAR2,
                                                                           SV_cod_tipo_calle  OUT NOCOPY  VARCHAR2,
                                                                   SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getDireccionCodigo_PR"
                        Lenguaje="PL/SQL"
                        Fecha="22-06-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Obtiene direccion segun codigo
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
                         </Entrada>
                 <Salida>
                   <param nom="SV_cod_provincia"  Tipo="STRING"> codigo provincia </param>
                   <param nom="SV_cod_region"     Tipo="STRING"> codigo region </param>
                   <param nom="SV_cod_ciudad"     Tipo="STRING"> codigo ciudad </param>
                   <param nom="SV_cod_comuna"     Tipo="STRING"> codigo cimuna </param>
                   <param nom="SV_nom_calle"      Tipo="STRING"> nombre calle </param>
                   <param nom="SV_num_calle"      Tipo="STRING"> numero calle </param>
                   <param nom="SV_num_piso"       Tipo="STRING"> numero piso </param>
                   <param nom="SV_num_casilla"    Tipo="STRING"> numero casilla </param>
                   <param nom="SV_obs_direccion"  Tipo="STRING"> observacion </param>
                   <param nom="SV_des_direc1"     Tipo="STRING"> descripcion 1 </param>
                   <param nom="SV_des_direc2"     Tipo="STRING"> descripcion 2 </param>
                   <param nom="SV_cod_pueblo"     Tipo="STRING"> codigo pueblo </param>
                   <param nom="SV_cod_estado"     Tipo="STRING"> codigo estado </param>
                   <param nom="SV_zip"                    Tipo="STRING"> zip </param>
                           <param nom="SV_cod_tipo_calle" Tipo="STRING"> codigo tipo de calle </param>
                           <param nom="SN_codRetorno"     Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"     Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"      Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='SELECT a.cod_region, '
                       || 'a.cod_provincia, '
                           || 'a.cod_ciudad, '
                           || 'a.cod_comuna, '
                           || 'a.nom_calle, '
                           || 'a.num_calle, '
                           || 'a.num_piso, '
                           || 'a.num_casilla, '
                           || 'a.obs_direccion, '
                           || 'a.des_direc1, '
                           || 'a.des_direc2, '
                           || 'a.cod_pueblo, '
                           || 'a.cod_estado, '
                           || 'a.zip, '
                           || 'a.cod_tipocalle, '
                       || 'FROM ge_direcciones a '
                       || 'WHERE a.cod_direccion = ' || EN_cod_direccion;

                SELECT a.cod_region,
                       a.cod_provincia,
                           a.cod_ciudad,
                           a.cod_comuna,
                           a.nom_calle,
                           a.num_calle,
                           a.num_piso,
                           a.num_casilla,
                           a.obs_direccion,
                           a.des_direc1,
                           a.des_direc2,
                           a.cod_pueblo,
                           a.cod_estado,
                           a.zip,
                           a.cod_tipocalle
                INTO SV_cod_region,
                     SV_cod_provincia,
                         SV_cod_ciudad,
                         SV_cod_comuna,
                         SV_nom_calle,
                         SV_num_calle,
                         SV_num_piso,
                         SV_num_casilla,
                         SV_obs_direccion,
                         SV_des_direc1,
                         SV_des_direc2,
                         SV_cod_pueblo,
                         SV_cod_estado,
                         SV_zip,
                         SV_cod_tipo_calle
                FROM ge_direcciones a
                WHERE a.cod_direccion = EN_cod_direccion;

        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                SN_codRetorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERRORNOCLASIF;
                END IF;
                LV_desError := 'NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_getDireccionCodigo_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_getDireccionCodigo_PR', LV_Sql, SQLCODE, LV_desError );
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_getDireccionCodigo_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_getDireccionCodigo_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_getDireccionCodigo_PR;

        PROCEDURE VE_inserta_direccion_PR(EN_cod_direccion IN  NUMBER,
                                      EV_cod_provincia IN  VARCHAR2,
                                                                      EV_cod_region    IN  VARCHAR2,
                                                                      EV_cod_ciudad    IN  VARCHAR2,
                                                                      EV_cod_comuna    IN  VARCHAR2,
                                                                      EV_nom_calle     IN  VARCHAR2,
                                                                      EV_num_calle     IN  VARCHAR2,
                                                                      EV_num_piso      IN  VARCHAR2,
                                                                      EV_num_casilla   IN  VARCHAR2,
                                                                      EV_obs_direccion IN  VARCHAR2,
                                                                      EV_des_direc1    IN  VARCHAR2,
                                                                      EV_des_direc2    IN  VARCHAR2,
                                                                      EV_cod_pueblo    IN  VARCHAR2,
                                                                      EV_cod_estado    IN  VARCHAR2,
                                                                      EV_zip           IN  VARCHAR2,
                                                                          EV_cod_tipo_calle  IN  VARCHAR2,
                                                                  SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_inserta_direccion_PR"
                        Lenguaje="PL/SQL"
                        Fecha="23-06-2007"
                        Versión="1.0.0"
                        Diseñador="Héctor Hermosilla"
                        Programador="Héctor Hermosilla"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  inserta direccion
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
                   <param nom="EV_cod_provincia"  Tipo="STRING"> codigo provincia </param>
                   <param nom="EV_cod_region"     Tipo="STRING"> codigo region </param>
                   <param nom="EV_cod_ciudad"     Tipo="STRING"> codigo ciudad </param>
                   <param nom="EV_cod_comuna"     Tipo="STRING"> codigo cimuna </param>
                   <param nom="EV_nom_calle"      Tipo="STRING"> nombre calle </param>
                   <param nom="EV_num_calle"      Tipo="STRING"> numero calle </param>
                   <param nom="EV_num_piso"       Tipo="STRING"> numero piso </param>
                   <param nom="EV_num_casilla"    Tipo="STRING"> numero casilla </param>
                   <param nom="EV_obs_direccion"  Tipo="STRING"> observacion </param>
                   <param nom="EV_des_direc1"     Tipo="STRING"> descripcion 1 </param>
                   <param nom="EV_des_direc2"     Tipo="STRING"> descripcion 2 </param>
                   <param nom="EV_cod_pueblo"     Tipo="STRING"> codigo pueblo </param>
                   <param nom="EV_cod_estado"     Tipo="STRING"> codigo estado </param>
                   <param nom="EV_zip"                    Tipo="STRING"> zip </param>
                           <param nom="EV_cod_tipo_calle"                 Tipo="STRING"> tipo de calle</param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;



                LV_Sql:='INSERT INTO ge_direcciones ( '
                    || ' cod_direccion, cod_provincia, cod_region, '
                        || ' cod_ciudad, cod_comuna, nom_calle, '
                        || ' num_calle, num_piso, num_casilla, '
                        || ' obs_direccion, des_direc1, des_direc2, '
                        || ' cod_pueblo, cod_estado, zip, cod_tipocalle) '
                        || ' VALUES ( ' || EN_cod_direccion || ', ''' || EV_cod_provincia || ''',''' || EV_cod_region || ''','''
            || EV_cod_ciudad || ''',''' || EV_cod_comuna || ''',''' || EV_nom_calle  || ''','''
                        || EV_num_calle || ''',''' || EV_num_piso || ''',''' || EV_num_casilla  || ''','''
                        || EV_obs_direccion || ''',''' || EV_des_direc1 || ''',''' || EV_des_direc2  || ''','''
                        || EV_cod_pueblo || ''',''' || EV_cod_estado || ''',''' || EV_zip || ''',''' || EV_cod_tipo_calle  || ''',)';


                INSERT INTO ge_direcciones (
                   cod_direccion, cod_provincia, cod_region,
                   cod_ciudad, cod_comuna, nom_calle,
                   num_calle, num_piso, num_casilla,
                   obs_direccion, des_direc1, des_direc2,
                   cod_pueblo, cod_estado, zip,cod_tipocalle)
        VALUES ( EN_cod_direccion, EV_cod_provincia, EV_cod_region,
                 EV_cod_ciudad, EV_cod_comuna, EV_nom_calle,
                 EV_num_calle, EV_num_piso, EV_num_casilla,
                 /*INC 201432*/
                 /*EV_obs_direccion, EV_des_direc1, EV_des_direc2,*/
                 EV_obs_direccion,trim(replace(replace(EV_des_direc1,chr(10),''),chr(13),'')),trim(replace(replace(EV_des_direc2,chr(10),''),chr(13),'')), 
                 EV_cod_pueblo, EV_cod_estado, EV_zip,EV_cod_tipo_calle);

        EXCEPTION
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_inserta_direccion_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_inserta_direccion_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_inserta_direccion_PR;

PROCEDURE VE_inserta_direccion_PR(EN_cod_direccion IN  NUMBER,
                                      EV_cod_provincia IN  VARCHAR2,
                                                                      EV_cod_region    IN  VARCHAR2,
                                                                      EV_cod_ciudad    IN  VARCHAR2,
                                                                      EV_cod_comuna    IN  VARCHAR2,
                                                                      EV_nom_calle     IN  VARCHAR2,
                                                                      EV_num_calle     IN  VARCHAR2,
                                                                      EV_num_piso      IN  VARCHAR2,
                                                                      EV_num_casilla   IN  VARCHAR2,
                                                                      EV_obs_direccion IN  VARCHAR2,
                                                                      EV_des_direc1    IN  VARCHAR2,
                                                                      EV_des_direc2    IN  VARCHAR2,
                                                                      EV_cod_pueblo    IN  VARCHAR2,
                                                                      EV_cod_estado    IN  VARCHAR2,
                                                                      EV_zip           IN  VARCHAR2,
                                                                  SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_inserta_direccion_PR"
                        Lenguaje="PL/SQL"
                        Fecha="23-06-2007"
                        Versión="1.0.0"
                        Diseñador="Héctor Hermosilla"
                        Programador="Héctor Hermosilla"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  inserta direccion
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
                   <param nom="EV_cod_provincia"  Tipo="STRING"> codigo provincia </param>
                   <param nom="EV_cod_region"     Tipo="STRING"> codigo region </param>
                   <param nom="EV_cod_ciudad"     Tipo="STRING"> codigo ciudad </param>
                   <param nom="EV_cod_comuna"     Tipo="STRING"> codigo cimuna </param>
                   <param nom="EV_nom_calle"      Tipo="STRING"> nombre calle </param>
                   <param nom="EV_num_calle"      Tipo="STRING"> numero calle </param>
                   <param nom="EV_num_piso"       Tipo="STRING"> numero piso </param>
                   <param nom="EV_num_casilla"    Tipo="STRING"> numero casilla </param>
                   <param nom="EV_obs_direccion"  Tipo="STRING"> observacion </param>
                   <param nom="EV_des_direc1"     Tipo="STRING"> descripcion 1 </param>
                   <param nom="EV_des_direc2"     Tipo="STRING"> descripcion 2 </param>
                   <param nom="EV_cod_pueblo"     Tipo="STRING"> codigo pueblo </param>
                   <param nom="EV_cod_estado"     Tipo="STRING"> codigo estado </param>
                   <param nom="EV_zip"                    Tipo="STRING"> zip </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;



                LV_Sql:='INSERT INTO ge_direcciones ( '
                    || ' cod_direccion, cod_provincia, cod_region, '
                        || ' cod_ciudad, cod_comuna, nom_calle, '
                        || ' num_calle, num_piso, num_casilla, '
                        || ' obs_direccion, des_direc1, des_direc2, '
                        || ' cod_pueblo, cod_estado, zip) '
                        || ' VALUES ( ' || EN_cod_direccion || ', ''' || EV_cod_provincia || ''',''' || EV_cod_region || ''','''
            || EV_cod_ciudad || ''',''' || EV_cod_comuna || ''',''' || EV_nom_calle  || ''','''
                        || EV_num_calle || ''',''' || EV_num_piso || ''',''' || EV_num_casilla  || ''','''
                        || EV_obs_direccion || ''',''' || EV_des_direc1 || ''',''' || EV_des_direc2  || ''','''
                        || EV_cod_pueblo || ''',''' || EV_cod_estado || ''',''' || EV_zip  || ''',)';


                INSERT INTO ge_direcciones (
                   cod_direccion, cod_provincia, cod_region,
                   cod_ciudad, cod_comuna, nom_calle,
                   num_calle, num_piso, num_casilla,
                   obs_direccion, des_direc1, des_direc2,
                   cod_pueblo, cod_estado, zip)
        VALUES ( EN_cod_direccion, EV_cod_provincia, EV_cod_region,
                 EV_cod_ciudad, EV_cod_comuna, EV_nom_calle,
                 EV_num_calle, EV_num_piso, EV_num_casilla,
                 /*INC 201432*/
                 /* EV_obs_direccion, EV_des_direc1, EV_des_direc2, */
                 EV_obs_direccion,trim(replace(replace(EV_des_direc1,chr(10),''),chr(13),'')),trim(replace(replace(EV_des_direc2,chr(10),''),chr(13),'')), 
                 EV_cod_pueblo, EV_cod_estado, EV_zip);

        EXCEPTION
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_inserta_direccion_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_inserta_direccion_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_inserta_direccion_PR;

        PROCEDURE VE_insDireccionUsuario_PR(EN_codDireccion    IN  NUMBER,
                                        EV_codUsuario      IN  VARCHAR2,
                                                                                EV_tipDireccion    IN  VARCHAR2,
                                                                        SN_codRetorno      OUT NOCOPY ge_errores_pg.CodError,
                                            SV_menRetorno      OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_numEvento       OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_insDireccionUsuario_PR"
                        Lenguaje="PL/SQL"
                        Fecha="11-09-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  inserta direccion usuario
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_codDireccion"    Tipo="STRING"> codigo direccion </param>
                   <param nom="EV_codUsuario"      Tipo="STRING"> codigo usuario </param>
                           <param nom="EV_tipDireccion"    Tipo="STRING"> tipoDireccion </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='INSERT INTO ga_direcusuar ( '
                    || ' cod_direccion, cod_usuario, cod_tipdireccion) '
                        || ' VALUES ( ' || EN_codDireccion || ', ''' || EV_codUsuario || ''',''' || EV_tipDireccion || ''')';

                INSERT INTO ga_direcusuar (
                   cod_direccion, cod_usuario, cod_tipdireccion)
        VALUES ( EN_codDireccion, EV_codUsuario, EV_tipDireccion);

        EXCEPTION
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_insDireccionUsuario_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_insDireccionUsuario_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_insDireccionUsuario_PR;

        PROCEDURE VE_delDireccion_PR(EN_cod_direccion IN  VARCHAR2,
                                                             SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_numEvento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_delDireccion_PR"
                        Lenguaje="PL/SQL"
                        Fecha="11-09-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Elimina direccion segun codigo
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_cod_direccion"  Tipo="NUMBER"> codigo direccion </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_codRetorno := 0;
                SV_menRetorno := NULL;
                SN_numEvento  := 0;

                LV_Sql:='DELETE ge_direcciones '
                    || ' WHERE cod_direccion = ' || EN_cod_direccion;

                DELETE ge_direcciones
                WHERE cod_direccion = EN_cod_direccion;

        EXCEPTION
                         WHEN OTHERS THEN
                                SN_codRetorno := 156;
                                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                                   SV_menRetorno := CV_ERRORNOCLASIF;
                                END IF;
                                LV_desError  := 'OTHERS:VE_servicios_direcciones_PG.VE_delDireccion_PR;- ' || SQLERRM;
                                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER,
                                'VE_servicios_direcciones_PG.VE_delDireccion_PR', LV_Sql, SQLCODE, LV_desError );
        END VE_delDireccion_PR;

PROCEDURE VE_getCodDireccion_PR(EV_codSujeto      IN  VARCHAR2,
                                     EN_tipSujeto      IN  NUMBER,
                                     EN_tipDireccion   IN  NUMBER,
                                     SV_CodDireccion   OUT NOCOPY GE_DIRECCIONES.COD_DIRECCION%TYPE,
                                     SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                     SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                     SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getDireccion_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-07-2009"
                        Versión="1.0.0"
                        Diseñador="NRCA"
                        Programador="NRCA"
                        Ambiente="BD"
                <Retorno>
                        Retorna direccion del cliente
                </Retorno>
                <Descripción>
                        Retorna direccion del cliente
                </Descripción>
                <Parámetros>
                <Entrada>
                        <param nom="EV_codSujeto"    Tipo="VARCHAR2"> copdigo tipo de sujero </param>
                        <param nom="EV_tipSujeto"    Tipo="VARCHAR2"> tipo de sujero </param>
                        <param nom="EV_tipDireccion" Tipo="VARCHAR2"> tipo direccion </param>
                </Entrada>
                <Salida>
                        <param nom="SV_valor"        Tipo="VARCHAR2"> direccion cliente </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER">codigo de retorno del procedimiento</param>
                        <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
                        <param nom="SN_num_evento"   Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
                </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
                LE_exception_fin   EXCEPTION;
                LA_arreglo1 VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();
                LA_arreglo2 VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();

                LV_des_error ge_errores_pg.desevent;
                LV_sql           ge_errores_pg.vquery;

                LV_string       VARCHAR2(500);
                LV_dato1        VARCHAR2(100);
                LV_dato2        VARCHAR2(100);
                LN_indice1      NUMBER;
                LN_indice2      NUMBER;
                LN_columna      NUMBER;
                LV_valorColumna VARCHAR2(100);
        BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := NULL;
        SN_num_evento := 0;

        --SUJETO_CLIENTE = 1
        --SUJETO_USUARIO = 2
        --SUJETO_CUENTA = 3
        --SUJETO_SUBCUENTA = 4
        --SUJETO_TALLER = 5
        --SUJETO_BODEGA = 7
        --SUJETO_PROVEEDORES = 8
        --SUJETO_AURETEQ = 9
        --SUJETO_OFICINA = 10
        --SUJETO_VENDEDOR = 11
        --SUJETO_OPERADORA = 12
        --SUJETO_PLAZA_OPERADORA = 13

        IF EN_tipSujeto=1 THEN

           LV_Sql:='SELECT COD_DIRECCION FROM GA_DIRECCLI WHERE COD_TIPDIRECCION=' || EN_tipSujeto
                   ||' AND COD_CLIENTE=' || EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM GA_DIRECCLI
           WHERE COD_TIPDIRECCION=EN_tipDireccion
           AND COD_CLIENTE=EV_codSujeto;

        END IF;

        IF EN_tipSujeto=2 THEN

           LV_Sql:='SELECT COD_DIRECCION FROM GA_DIRECUSUAR'
                 ||' WHERE COD_TIPDIRECCION=' || EN_tipSujeto
                 ||' and COD_USUARIO='|| EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM GA_DIRECUSUAR
           WHERE COD_TIPDIRECCION=EN_tipDireccion
           AND COD_USUARIO=EV_CODSUJETO;
        END IF;

        IF EN_tipSujeto=3 THEN

           LV_Sql:='SELECT COD_DIRECCION'
                  ||' FROM GA_CUENTAS'
                  ||' WHERE COD_CUENTA='|| EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM GA_CUENTAS
           WHERE COD_CUENTA=EV_codSujeto;
        END IF;

        IF EN_tipSujeto=4 THEN

           LV_Sql:='SELECT COD_DIRECCION'
                 ||' FROM GA_SUBCUENTAS'
                 ||' WHERE COD_SUBCUENTA=' || EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM GA_SUBCUENTAS
           WHERE COD_SUBCUENTA= EV_codSujeto;

        END IF;

        IF EN_tipSujeto=5 THEN

           LV_Sql:='SELECT COD_DIRECCION'
                 ||' FROM SP_TALLERES'
                 ||' WHERE COD_TALLER=' || EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM SP_TALLERES
           WHERE COD_TALLER=EV_codSujeto;
        END IF;

        IF EN_tipSujeto=7 THEN

           LV_Sql:='SELECT COD_DIRECCION'
                 ||' FROM AL_BODEGAS'
                 ||' WHERE COD_BODEGA='|| EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM AL_BODEGAS
           WHERE COD_BODEGA=EV_codSujeto;
        END IF;

        IF EN_tipSujeto=8 THEN

           LV_Sql:='SELECT COD_DIRECCION'
                 ||' FROM AL_PROVEEDORES'
                 ||' WHERE COD_PROVEEDOR='|| EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM AL_PROVEEDORES
           WHERE COD_PROVEEDOR=EV_codSujeto;
        END IF;

        IF EN_tipSujeto=9 THEN

           LV_Sql:='SELECT COD_DIRECCION_AUT'
                  ||' FROM  SP_ORDENES_REPARACION'
                  ||' WHERE NUM_ORDEN=' || EV_codSujeto;

           SELECT COD_DIRECCION_AUT
           INTO SV_CodDireccion
           FROM SP_ORDENES_REPARACION
           WHERE NUM_ORDEN=EV_codSujeto;
        END IF;

        IF EN_tipSujeto=10 THEN

           LV_Sql:='SELECT COD_DIRECCION'
                 ||' FROM GE_OFICINAS'
                 ||' WHERE COD_OFICINA=' || EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM GE_OFICINAS
           WHERE COD_OFICINA= EV_codSujeto;
        END IF;

        IF EN_tipSujeto=11THEN

           LV_Sql:='SELECT COD_DIRECCION'
                 ||' FROM VE_VENDEDORES'
                 ||'WHERE COD_VENDEDOR=' || EV_codSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM VE_VENDEDORES
           WHERE COD_VENDEDOR=EV_codSujeto;

        END IF;

        IF EN_tipSujeto=12 THEN
           LV_Sql:='SELECT COD_DIRECCION'
                  ||'FROM GE_OPERADORA_SCL'
                  ||'WHERE COD_OPERADORA_SCL=' || EV_CodSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM GE_OPERADORA_SCL
           WHERE COD_OPERADORA_SCL=EV_CodSujeto;
        END IF;

        IF EN_tipSujeto=13 THEN


           LV_Sql:='SELECT COD_DIRECCION'
                 ||' FROM GE_OPERPLAZA_TD'
                 ||' WHERE COD_OPERPLAZA=' || EV_CodSujeto;

           SELECT COD_DIRECCION
           INTO SV_CodDireccion
           FROM GE_OPERPLAZA_TD
           WHERE COD_OPERPLAZA=EV_CodSujeto;

        END IF;


        EXCEPTION
                WHEN LE_exception_fin THEN
                SN_cod_retorno := 3;
                LV_des_error:='LE_exception_fin: VE_servicios_direcciones_PG.VE_getDireccion_PR();- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_getDireccion_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN NO_DATA_FOUND THEN
                SN_cod_retorno := 778;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_ERRORNOCLASIF;
                END IF;
                LV_des_error := 'NO_DATA_FOUND:VE_servicios_direcciones_PG.VE_getDireccion_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_getDireccion_PR', LV_Sql, SQLCODE, LV_des_error );
                WHEN OTHERS THEN
                SN_cod_retorno := 156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno:=CV_ERRORNOCLASIF;
                END IF;
                LV_des_error := 'OTHERS:VE_servicios_direcciones_PG.VE_getDireccion_PR;- ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER,
                'VE_servicios_direcciones_PG.VE_getDireccion_PR', LV_Sql, SQLCODE, LV_des_error );
        END VE_getCodDireccion_PR;

END VE_servicios_direcciones_PG;
/
