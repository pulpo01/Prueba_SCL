CREATE OR REPLACE PACKAGE BODY Ve_Servs_ActivacionesWeb_Pg IS

    -- Datos -----------------------------------------------------------------------------------

FUNCTION VE_valida_existe_en_SCL_FN(EV_Tabla        IN  VARCHAR2,
                                    EV_Columna      IN  VARCHAR2,
                                    EV_Valor_STR    IN  VARCHAR2,
                                    EV_Valor_NUM    IN  LONG,
                                    SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                    SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                    SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) RETURN BOOLEAN
/*
<Documentación TipoDoc = "Funcion">
    Elemento Nombre = "VE_valida_existe_en_SCL_FN"
    Lenguaje="PL/SQL"
    Fecha="11-04-2008"
    Versión="1.0"
    Diseñador="wjrc"
    Programador="wjrc"
    Ambiente="BD"
<Retorno>
</Retorno>
<Descripción>
        Valida que el valor exista en las tablas de SCL
</Descripción>
<Parámetros>
   <Entrada>
     <param nom="EV_Tabla"   Tipo="STRING"> Nombre de la tabla </param>
     <param nom="EV_Columna" Tipo="STRING"> Nombre de la columna </param>
     <param nom="EV_Valor"   Tipo="STRING"> valor a buscar </param>
   </Entrada>
   <Salida>
     <param nom="SN_codRetorno" Tipo="NUMBER"> Codigo de retorno del procedimiento </param>
     <param nom="SV_menRetorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
     <param nom="SN_numEvento"  Tipo="NUMBER"> Numero de evento en caso de error en ejecucion </param>
   </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
    LV_desError ge_errores_pg.desevent;
    LV_sql      VARCHAR2(500);
    LN_contador NUMBER;
BEGIN
    SN_codRetorno  := 0;
    SV_menRetorno := NULL;
    SN_numEvento   := 0;

    LV_sql := '';
    LN_contador := 0;

    LV_sql := 'SELECT COUNT(1)';
    LV_sql := LV_sql || ' FROM ' || EV_Tabla;
    IF (EV_Valor_NUM IS NOT NULL) THEN
            LV_sql := LV_sql || ' WHERE ' || EV_Columna || ' = ' || EV_Valor_NUM;
    ELSE
            LV_sql := LV_sql || ' WHERE ' || EV_Columna || ' = ''' || EV_Valor_STR || '''';
    END IF;

    EXECUTE IMMEDIATE LV_sql INTO LN_contador;

    IF (LN_contador > 0) THEN
       RETURN(TRUE);
    ELSE
       RETURN(FALSE);
    END IF;

EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := CN_ERROR_OTHERS;
        LV_desError   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_valida_existe_en_SCL_fn();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
        SV_menRetorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_valida_existe_en_SCL_fn',
        LV_sql, SQLCODE, LV_desError);
        RETURN(FALSE);
END VE_valida_existe_en_SCL_FN;

-------------------------------------------------------------------------------------------

FUNCTION VE_valida_existe_relacion_FN(ER_sector       IN rUBICACION_DIR,
                                          SN_cod_Retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                      SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                      SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
                                                                          RETURN BOOLEAN
/*
<Documentación TipoDoc = "Funcion">
        Elemento Nombre = "VE_valida_existe_relacion_FN"
        Lenguaje="PL/SQL"
        Fecha="12-03-2008"
        Versión="1.0"
        Diseñador="wjrc"
        Programador="wjrc"
        Ambiente="BD"
<Retorno>
</Retorno>
<Descripción>
        Valida que exista relacion entre los datos correspondiente a la direccion
        Por ejemplo : debe existir la relacion region - provincia
                                  debe existir la relacion provincia - ciudad
                                  debe existir la relacion provincia - comuna
</Descripción>
<Parámetros>
        <Entrada>
                <param nom="EV_Valor" Tipo="STRING"> Valor a validar </param>
        </Entrada>
        <Salida>
                <param nom="SN_cod_Retorno"  Tipo="NUMBER"> Codigo de retorno del procedimiento </param>
                <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                <param nom="SN_num_evento"   Tipo="NUMBER"> Numero de evento en caso de error en ejecucion </param>
        </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
        LV_des_error ge_errores_pg.desevent;
        LV_sql       VARCHAR2(500);
        LN_contador  NUMBER;
BEGIN
        SN_cod_Retorno  := 0;
        SV_mens_retorno := NULL;
        SN_num_evento   := 0;

        LN_contador := 0;

        SELECT COUNT(1)
        INTO LN_contador
        FROM ge_ciucom a
        WHERE a.cod_region = ER_sector.COD_REGION
        AND a.cod_provincia = ER_sector.COD_PROVINCIA
        AND a.cod_comuna = ER_sector.COD_COMUNA
        AND a.cod_ciudad = ER_sector.COD_CIUDAD;

        IF (LN_contador < 1) THEN
                RETURN(FALSE);
        END IF;

        RETURN(TRUE);

EXCEPTION
         WHEN OTHERS THEN
        SN_cod_retorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_valida_existe_relacion_fn();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_valida_existe_relacion_fn',
                LV_sql, SQLCODE, LV_des_error);
                RETURN(FALSE);
END VE_valida_existe_relacion_FN;

---------------------------------------------------------------------------------------------

FUNCTION VE_valida_tipo_calle_FN(EV_valor        IN  VARCHAR2,
                                 SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                 SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                 SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) RETURN BOOLEAN
/*
<Documentación TipoDoc = "Funcion">
        Elemento Nombre = "VE_valida_tipo_calle_FN"
        Lenguaje="PL/SQL"
        Fecha="15-05-2008"
        Versión="1.0"
        Diseñador="wjrc"
        Programador="wjrc"
        Ambiente="BD"
<Retorno>
</Retorno>
<Descripción>
    Valida que el valor exista en las tablas de SCL
</Descripción>
<Parámetros>
   <Entrada>
      <param nom="EV_valor"      Tipo="STRING"> Valor del tipo calle  a buscar</param>
   </Entrada>
   <Salida>
      <param nom="SN_codRetorno" Tipo="NUMBER"> Codigo de retorno del procedimiento </param>
      <param nom="SV_menRetorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
      <param nom="SN_numEvento"  Tipo="NUMBER"> Numero de evento en caso de error en ejecucion </param>
   </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
    LV_desError ge_errores_pg.desevent;
    LV_sql      VARCHAR2(500);
    LN_contador NUMBER;
BEGIN
    SN_codRetorno  := 0;
    SV_menRetorno := NULL;
    SN_numEvento   := 0;

    LV_sql := '';
    LN_contador := 0;

    LV_sql := 'SELECT COUNT(1)'
           || ' FROM ge_tipos_calles_vw v'
           || ' WHERE v.cod_dominio = ''TIPOS_CALLES'''
           || ' AND v.valor = ''' || EV_valor || '''';

    EXECUTE IMMEDIATE LV_sql INTO LN_contador;

    IF (LN_contador > 0) THEN
       RETURN(TRUE);
    ELSE
       RETURN(FALSE);
    END IF;

EXCEPTION
         WHEN OTHERS THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_valida_tipo_calle_FN();- ' || SQLERRM;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERROR_NOCLASIF;
                END IF;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_valida_tipo_calle_FN',
                LV_sql, SQLCODE, LV_desError);
                RETURN(FALSE);
END VE_valida_tipo_calle_FN;

-------------------------------------------------------------------------------------------

        PROCEDURE VE_getDatosGenerales_PR(EV_columna      IN VARCHAR2,
                                      SN_valor        OUT NOCOPY VARCHAR2,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getDatosGenerales_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Valor columna datos generales
                </Retorno>
                <Descripción>
                                  Recupera valor columna datos generales
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_columna" Tipo="STRING"> columna </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_valor"        Tipo="STRING"> valor columna </param>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(23) := 'VE_getDatosGenerales_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql:='SELECT a.' || EV_columna
                      || ' FROM ga_datosgener a';

            EXECUTE IMMEDIATE LV_Sql INTO SN_valor;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getDatosGenerales_PR;

        PROCEDURE VE_getCliente_PR(EV_codCliente    IN VARCHAR2,
                                   EV_TipIdentif    IN VARCHAR2,
                                   EV_numIdentif    IN VARCHAR2,
                                   SV_codCliente    OUT NOCOPY VARCHAR2,
                                   SV_nomCliente    OUT NOCOPY VARCHAR2,
                                   SV_nomApell1     OUT NOCOPY VARCHAR2,
                                   SV_nomApell2     OUT NOCOPY VARCHAR2,
                                   SV_TipIdentif    OUT NOCOPY VARCHAR2,
                                   SV_numIdentif    OUT NOCOPY VARCHAR2,
                                   SV_numTelefono1  OUT NOCOPY VARCHAR2,
                                   SV_mail          OUT NOCOPY VARCHAR2,
                                   SV_fecNacimiento OUT NOCOPY VARCHAR2,
                                                           SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getCliente_PR"
                        Lenguaje="PL/SQL"
                        Fecha="30-07-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  datos cliente
                </Retorno>
                <Descripción>
                                  datos cliente segun codigo
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codCliente" Tipo="STRING"> codigo del cliente </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_nomCliente"    Tipo="STRING"> nombre </param>
                           <param nom="SV_nomApell1"     Tipo="STRING"> apellido paterno  </param>
                           <param nom="SV_nomApell2"     Tipo="STRING"> apellido materno </param>
                           <param nom="SV_codTipIdent"   Tipo="STRING"> codigo tipo identificador </param>
                           <param nom="SV_numIdentif"    Tipo="STRING"> numero de identificacion </param>
                           <param nom="SV_numTelefono1"  Tipo="STRING"> numero telefono 1 </param>
                           <param nom="SV_mail"          Tipo="STRING"> mail </param>
                           <param nom="SV_fecNacimiento" Tipo="STRING"> fecha de nacimiento </param>

                           <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(16) := 'VE_getCliente_PR';

            ERROR_PARAMETRO       EXCEPTION;

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
                LV_Count    NUMBER(9);
                --Agregado para manejar excepciones
        LV_codRetorno  ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.desevent;
                LV_COD_CLIENTE_ULT GE_CLIENTES.COD_CLIENTE%TYPE;
                LV_COUNT_CLI     NUMBER(10);
        --fin
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                IF EV_TipIdentif IS NOT NULL THEN

                   LV_Sql:='SELECT COUNT(1) FROM GE_TIPIDENT WHERE COD_TIPIDENT= ' || EV_TipIdentif;

                   SELECT COUNT(1)
                   INTO  LV_Count
                   FROM GE_TIPIDENT
                   WHERE COD_TIPIDENT=EV_tipidentif;

                   IF LV_Count=0 THEN
                      SN_cod_retorno:=225;
                      -- Inc. 64060 Se modifica mensaje de error
                      -- Fecha: 03/04/2008
                      -- Prog : JMC
                      --SV_mens_retorno:='Codigo de Cliente no definido en SCL';
                      SV_mens_retorno:='Tipo de identificación invalida';
                      RAISE ERROR_PARAMETRO;
                   END IF;
                END IF;

                IF (EV_codCliente IS NOT NULL) THEN
                -- Buscamos  cliente por codido

                        LV_Sql:='SELECT a.cod_cliente,'
                               || ' a.nom_cliente,'
                                   || ' a.nom_apeclien1,'
                                   || ' a.nom_apeclien2,'
                                   || ' a.cod_tipident,'
                                   || ' a.num_ident,'
                                   || ' a.tef_cliente1,'
                                   || ' a.nom_email,'
                                   || ' a.fec_nacimien'
                               || ' FROM ge_clientes a'
                               || ' WHERE a.cod_cliente = ' || EV_codCliente;

                        SELECT a.cod_cliente,
                                   a.nom_cliente,
                                   a.nom_apeclien1,
                                   a.nom_apeclien2,
                                   a.cod_tipident,
                                   a.num_ident,
                                   a.tef_cliente1,
                                   a.nom_email,
                                   TO_CHAR(a.fec_nacimien,VE_intermediario_PG.CV_FORMATOFECHA)
                    INTO SV_codCliente,
                                 SV_nomCliente,
                         SV_nomApell1,
                         SV_nomApell2,
                         SV_TipIdentif,
                         SV_numIdentif,
                         SV_numTelefono1,
                         SV_mail,
                         SV_fecNacimiento
                        FROM ge_clientes a
                        WHERE a.cod_cliente = EV_codCliente;
                --  AND a.ind_alta = CV_INDALTA_V;

                ELSIF (EV_numIdentif IS NOT NULL) THEN
                -- Buscamos cliente por numero de identificacion

                        LV_Sql:='SELECT a.cod_cliente,'
                               || ' a.nom_cliente,'
                                   || ' a.nom_apeclien1,'
                                   || ' a.nom_apeclien2,'
                                   || ' a.cod_tipident,'
                                   || ' a.num_ident,'
                                   || ' a.tef_cliente1,'
                                   || ' a.nom_email,'
                                   || ' a.fec_nacimien'
                               || ' FROM ge_clientes a'
                                   || ' WHERE a.COD_CLIENTE = ' || LV_COD_CLIENTE_ULT;

                        SELECT a.cod_cliente,
                                   a.nom_cliente,
                                   a.nom_apeclien1,
                                   a.nom_apeclien2,
                                   a.cod_tipident,
                                   a.num_ident,
                                   a.tef_cliente1,
                                   a.nom_email,
                                   TO_CHAR(a.fec_nacimien,VE_intermediario_PG.CV_FORMATOFECHA)
                    INTO SV_codCliente,
                                 SV_nomCliente,
                         SV_nomApell1,
                         SV_nomApell2,
                         SV_TipIdentif,
                         SV_numIdentif,
                         SV_numTelefono1,
                         SV_mail,
                         SV_fecNacimiento
                        FROM ge_clientes a
                WHERE
                     a.cod_cliente=LV_COD_CLIENTE_ULT;


                ELSE
                -- error en los parametros de entrada
                        RAISE ERROR_PARAMETRO;
                END IF;


        EXCEPTION
                        WHEN ERROR_PARAMETRO THEN
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN NO_DATA_FOUND THEN
                             SN_cod_retorno:=225;
                         SV_mens_retorno:='Codigo de Cliente no definido en SCL';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getCliente_PR;

        PROCEDURE VE_getVendedor_PR(EV_codVendedor     IN VARCHAR2,
                                    EV_codCanal        IN VARCHAR2,
                                                                SV_nomVendedor     OUT NOCOPY VARCHAR2,
                                                                SV_tipComisionista OUT NOCOPY VARCHAR2,
                                                                SV_desComisionista OUT NOCOPY VARCHAR2,
                                                                SV_codDireccion    OUT NOCOPY VARCHAR2,
                                                                SV_codOficina      OUT NOCOPY VARCHAR2,
                                                                SV_desOficina      OUT NOCOPY VARCHAR2,
                                                                SV_codRegion       OUT NOCOPY VARCHAR2,
                                                                SV_desRegion       OUT NOCOPY VARCHAR2,
                                                                SV_codProvincia    OUT NOCOPY VARCHAR2,
                                                                SV_desProvincia    OUT NOCOPY VARCHAR2,
                                                                SV_codCiudad       OUT NOCOPY VARCHAR2,
                                                                SV_desCiudad       OUT NOCOPY VARCHAR2,
                                                                SV_desCalle        OUT NOCOPY VARCHAR2,
                                                                SV_numCalle        OUT NOCOPY VARCHAR2,
                                                                SV_ObsDireccion    OUT NOCOPY VARCHAR2,
                                                            SV_nomVendealer    OUT NOCOPY VARCHAR2,
                                                                SV_CodVendealer    OUT NOCOPY VARCHAR2,
                                                                SV_CodVendedor     OUT NOCOPY VARCHAR2,
                                                                SV_TipoCalle       OUT NOCOPY VARCHAR2,
                                                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getVendedor_PR"
                        Lenguaje="PL/SQL"
                        Fecha="30-07-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  datos vendedor
                </Retorno>
                <Descripción>
                                  datos vendedor segun codigo y canal
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codVendedor" Tipo="STRING"> codigo del vendedor </param>
                           <param nom="EV_codCanal"    Tipo="STRING"> codigo canal </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_nomVendedor"     Tipo="STRING"> nombre </param>
                           <param nom="SV_tipComisionista" Tipo="STRING"> tipo comisionista , descripcion </param>
                           <param nom="SV_desComisionista" Tipo="STRING"> descripcion comisionista , descripcion </param>
                           <param nom="SV_codDireccion"    Tipo="STRING"> codigo direccion  </param>
                           <param nom="SV_codOficina"      Tipo="STRING"> codigo oficina del vendedor </param>
                           <param nom="SV_desOficina"      Tipo="STRING"> nombre oficina del vendedor </param>
                           <param nom="SV_codRegion"       Tipo="STRING"> codigo region </param>
                           <param nom    ="SV_desRegion"       Tipo="STRING"> nombre region </param>
                           <param nom="SV_codProvincia"    Tipo="STRING"> codigo provincia  </param>
                           <param nom="SV_desProvincia"    Tipo="STRING"> nombre provincia  </param>
                           <param nom="SV_codCiudad"       Tipo="STRING"> codigo ciudad </param>
                           <param nom="SV_desCiudad"       Tipo="STRING"> nombre ciudad </param>
                           <param nom="SV_desCalle"        Tipo="STRING"> nombre calle </param>
                           <param nom="SV_numCalle"        Tipo="STRING"> numero calle </param>
                           <param nom="SV_ObsDireccion"    Tipo="STRING"> observacion direccion </param>
                           <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno"    Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(17) := 'VE_getVendedor_PR';

                LV_desError    ge_errores_pg.desevent;
                LV_sql             ge_errores_pg.vquery;
        --Agregado para manejar excepciones
                LV_codRetorno  ge_errores_pg.coderror;
                ERROR_VENDEDOR exception;
                LV_mens_retorno ge_errores_pg.desevent;
                --fin
                LV_COUNT number(1);
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;


                IF UPPER(EV_codCanal) <> 'I' and UPPER(EV_codCanal) <> 'D' THEN
               SN_cod_retorno:=476;
                   SV_mens_retorno:='Vendedor no existe';
                   RAISE ERROR_VENDEDOR;
                END IF;


                IF UPPER(EV_codCanal)= 'I' THEN
                   SELECT COUNT(1)
                   INTO LV_COUNT
                   FROM VE_VENDEALER
                   WHERE COD_VENDEALER=EV_codVendedor;
                ELSE
                   SELECT COUNT(1)
                   INTO LV_COUNT
                   FROM VE_VENDEDORES
                   WHERE COD_VENDEDOR=EV_codVendedor;
                END IF;

                IF LV_COUNT=0 THEN
                   SN_cod_retorno:=476;
                   SV_mens_retorno:='Vendedor no existe';
                   RAISE ERROR_VENDEDOR;
                END IF;

                IF (UPPER(EV_codCanal) = CV_CANALDIRECTO) THEN
                -- vendedor interno

                        LV_Sql:='SELECT a.cod_vendedor,'
                                   || ' a.nom_vendedor,'
                                   || ' a.cod_tipcomis,'
                                   || ' d.des_tipcomis,'
                               || ' a.cod_direccion,'
                                   || ' a.cod_oficina,'
                               || ' c.des_oficina,'
                               || ' b.cod_region,'
                               || ' g.des_region,'
                                   || ' b.cod_provincia,'
                                   || ' e.des_provincia,'
                                   || ' b.cod_ciudad,'
                                   || ' f.des_ciudad,'
                                   || ' b.nom_calle,'
                                   || ' b.num_calle,'
                                   || ' b.obs_direccion,'
                                   || ' NVL(b.cod_tipoCalle,'')'
                               || ' FROM ve_vendedores a,'
                               || ' ge_direcciones b,'
                                   || ' ge_oficinas c,'
                               || ' ve_tipcomis d,'
                                   || ' ge_provincias e,'
                                   || ' ge_ciudades f,'
                                   || ' ge_regiones g'
                               || ' WHERE a.cod_direccion = b.cod_direccion'
                               || ' AND g.cod_region = b.cod_region'
                               || ' AND b.cod_region = e.cod_region'
                                   || ' AND b.cod_provincia = e.cod_provincia'
                                   || ' AND b.cod_ciudad = f.cod_ciudad'
                                   || ' AND b.cod_provincia = f.cod_provincia'
                                   || ' AND b.cod_region = f.cod_region'
                                   || ' AND a.cod_oficina = c.cod_oficina'
                                   || ' AND a.cod_tipcomis = d.cod_tipcomis'
                                   || ' AND a.cod_vendedor = ' || EV_codVendedor;

                        SELECT a.cod_vendedor,
                               a.nom_vendedor,
                                   a.cod_tipcomis,
                                   d.des_tipcomis,
                               a.cod_direccion,
                                   a.cod_oficina,
                               c.des_oficina,
                               b.cod_region,
                                   g.des_region,
                                   b.cod_provincia,
                                   e.des_provincia,
                                   b.cod_ciudad,
                                   f.des_ciudad,
                                   NVL(b.nom_calle, ' '), -- Inc. 63149 Rodrigo Araneda 17-03-2008
                                   NVL(b.num_calle, ' '), -- Inc. 63149 Rodrigo Araneda 17-03-2008
                                   NVL(b.obs_direccion, ' '), -- Inc. 63149 Rodrigo Araneda 17-03-2008
                                   NVL(b.cod_tipocalle, ' ') -- Inc. 63149 Rodrigo Araneda 17-03-2008

                        INTO SV_CodVendedor,
                             SV_nomVendedor,
                                 SV_tipComisionista,
                         SV_desComisionista,
                                 SV_codDireccion,
                                 SV_codOficina,
                                 SV_desOficina,
                                 SV_codRegion,
                                 SV_desRegion,
                                 SV_codProvincia,
                         SV_desProvincia,
                                 SV_codCiudad,
                         SV_desCiudad,
                         SV_desCalle,
                                 SV_numCalle,
                         SV_ObsDireccion,
                                 SV_TipoCalle

                        FROM ve_vendedores a,
                             ge_direcciones b,
                                 ge_oficinas c,
                             ve_tipcomis d,
                                 ge_provincias e,
                                 ge_ciudades f,
                                 ge_regiones g
                        WHERE a.cod_direccion = b.cod_direccion
                        AND g.cod_region = b.cod_region
                        AND b.cod_region = e.cod_region
                        AND b.cod_provincia = e.cod_provincia
                        AND b.cod_ciudad = f.cod_ciudad
                        AND b.cod_provincia = f.cod_provincia
                        AND b.cod_region = f.cod_region
                        AND a.cod_oficina = c.cod_oficina
                        AND a.cod_tipcomis = d.cod_tipcomis
                        AND a.cod_vendedor = EV_codVendedor;

                ELSE
                -- vendedor externo

                        LV_Sql:='SELECT a.cod_VENDEALER,'
                                   || ' h.nom_vendedor,' --COL-08005 se Agrega Nombre de Vendealer en caso que sea vendedor externo
                                   || ' a.nom_vendealer,' --COL-08005 se Agrega Nombre de Vendedor en caso que sea vendedor externo
                                   || ' h.cod_vendedor,'
                                   || ' a.cod_tipcomis,'
                                   || ' d.des_tipcomis,'
                               || ' h.cod_direccion,'
                                   || ' a.cod_oficina,'
                               || ' c.des_oficina,'
                               || ' b.cod_region,'
                               || ' g.des_region,'
                                   || ' b.cod_provincia,'
                                   || ' e.des_provincia,'
                                   || ' b.cod_ciudad,'
                                   || ' f.des_ciudad,'
                                   || ' b.nom_calle,'
                                   || ' b.num_calle,'
                                   || ' b.obs_direccion,'
                               || ' b.cod_tipocalle'
                                   || ' FROM ve_vendealer a,'
                               || ' ge_direcciones b,'
                                   || ' ge_oficinas c,'
                               || ' ve_tipcomis d,'
                                   || ' ge_provincias e,'
                                   || ' ge_ciudades f,'
                                   || ' ge_regiones g,'
                                   || ' ve_vendedores h'
                                   || ' WHERE a.cod_vendedor = h.cod_vendedor'
                                   || ' AND h.cod_direccion = b.cod_direccion'
                               || ' AND g.cod_region = b.cod_region'
                               || ' AND b.cod_region = e.cod_region'
                                   || ' AND b.cod_provincia = e.cod_provincia'
                                   || ' AND b.cod_ciudad = f.cod_ciudad'
                                   || ' AND b.cod_provincia = f.cod_provincia'
                                   || ' AND b.cod_region = f.cod_region'
                                   || ' AND a.cod_oficina = c.cod_oficina'
                                   || ' AND a.cod_tipcomis = d.cod_tipcomis'
                                   || ' AND a.cod_vendealer = ' || EV_codVendedor;

                         SELECT A.COD_VENDEALER,
                                H.NOM_VENDEDOR,
                                        A.NOM_VENDEALER,
                                        H.COD_VENDEDOR,
                                        A.COD_TIPCOMIS,
                                        D.DES_TIPCOMIS,
                                        H.COD_DIRECCION,
                                        A.COD_OFICINA,
                                        C.DES_OFICINA,
                                        B.COD_REGION,
                                        G.DES_REGION,
                                        B.COD_PROVINCIA,
                                        E.DES_PROVINCIA,
                                        B.COD_CIUDAD,
                                        F.DES_CIUDAD,
                                        NVL(B.NOM_CALLE, ' '), -- Inc. 63149 Rodrigo Araneda 17-03-2008
                                        NVL(B.NUM_CALLE, ' '), -- Inc. 63149 Rodrigo Araneda 17-03-2008
                                        NVL(B.OBS_DIRECCION, ' '), -- Inc. 63149 Rodrigo Araneda 17-03-2008
                                        NVL(B.cod_tipocalle, ' ') -- Inc. 63149 Rodrigo Araneda 17-03-2008

                           INTO SV_CodVendealer,
                                SV_NOMVENDEDOR,
                                        SV_nomVendealer,
                                        SV_CodVendedor,
                                        SV_TIPCOMISIONISTA,
                                        SV_DESCOMISIONISTA,
                                        SV_CODDIRECCION,
                                        SV_CODOFICINA,
                                        SV_DESOFICINA,
                                        SV_CODREGION,
                                        SV_DESREGION,
                                        SV_CODPROVINCIA,
                                        SV_DESPROVINCIA,
                                        SV_CODCIUDAD,
                                        SV_DESCIUDAD,
                                        SV_DESCALLE,
                                        SV_NUMCALLE,
                                        SV_OBSDIRECCION,
                                        SV_TipoCalle

                           FROM VE_VENDEALER A,
                                        GE_DIRECCIONES B,
                                        GE_OFICINAS C,
                                        VE_TIPCOMIS D,
                                        GE_PROVINCIAS E,
                                        GE_CIUDADES F,
                                        GE_REGIONES G,
                                        VE_VENDEDORES H
                          WHERE A.COD_VENDEDOR = H.COD_VENDEDOR
                                AND H.COD_DIRECCION = B.COD_DIRECCION
                                AND G.COD_REGION = B.COD_REGION
                                AND B.COD_REGION = E.COD_REGION
                                AND B.COD_PROVINCIA = E.COD_PROVINCIA
                                AND B.COD_CIUDAD = F.COD_CIUDAD
                                AND B.COD_PROVINCIA = F.COD_PROVINCIA
                                AND B.COD_REGION = F.COD_REGION
                                AND A.COD_OFICINA = C.COD_OFICINA
                                AND A.COD_TIPCOMIS = D.COD_TIPCOMIS
                                AND A.COD_VENDEALER =  EV_CODVENDEDOR;

                END IF;

        EXCEPTION
                         WHEN ERROR_VENDEDOR THEN
                             VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                         WHEN NO_DATA_FOUND THEN
                                 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getVendedor_PR;

        PROCEDURE VE_getNombrePDFFactura_PR(EN_numFolio     IN NUMBER,
                                                                                SV_nombre       OUT NOCOPY VARCHAR2,
                                                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getNombrePDFFactura_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Nombre archivo PDF factura
                </Retorno>
                <Descripción>
                                  Recupera Nombre archivo PDF factura
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EN_numFolio" Tipo="NUMBER"> numero folio </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_nombre"       Tipo="STRING"> nombre </param>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE  CONSTANT VARCHAR2(25) := 'VE_getNombrePDFFactura_PR';
                LN_numProceso        FA_FACTDOCU_NOCICLO.NUM_PROCESO%TYPE;
                LV_CODOPERADORA     FA_FACTDOCU_NOCICLO.COD_OPERADORA%TYPE;
                LV_CODTIPDOCUM      FA_FACTDOCU_NOCICLO.COD_TIPDOCUM%TYPE;
                LV_CODCLIENTE       FA_FACTDOCU_NOCICLO.COD_CLIENTE%TYPE;
                LN_TOTPAGAR         FA_FACTDOCU_NOCICLO.TOT_PAGAR%TYPE;
                LD_FECEMISION       FA_FACTDOCU_NOCICLO.FEC_EMISION%TYPE;
                LV_NOMUSUARORA      FA_FACTDOCU_NOCICLO.NOM_USUARORA%TYPE;

                LV_CODOFICCENTRAL    GE_DATOSGENER.COD_OFICCENTRAL%TYPE;
                LN_CANTIDAD          NUMBER;
                ERROR_PARAMETRO      Exception;

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql:='SELECT A.NUM_PROCESO'
                                || ' FROM FA_FACTDOCU_NOCICLO A, GA_VENTAS B'
                                || '  WHERE A.NUM_FOLIO=' || EN_numFolio
                                || '    AND A.NUM_VENTA=B.NUM_VENTA(+)'
                                || '    AND A.COD_TIPDOCUM=B.COD_TIPDOCUM(+)'
                                || '    AND A.COD_CLIENTE=B.COD_CLIENTE(+)'
                                || '    AND A.NUM_PROCESO=B.NUM_PROCESO(+)'
                                || '    AND A.COD_MODVENTA=B.COD_MODVENTA(+)'
                                || '    AND ROWNUM=1';

                --OBTENER NUM_PROCESO--dado el numero de folio--
                SELECT A.NUM_PROCESO,
                           A.COD_OPERADORA,
                           A.COD_TIPDOCUM,
                           A.COD_CLIENTE,
                           A.TOT_PAGAR,
                           A.FEC_EMISION,
                           A.NOM_USUARORA
                  INTO LN_numProceso,
                           LV_CODOPERADORA,
                           LV_CODTIPDOCUM,
                           LV_CODCLIENTE,
                           LN_TOTPAGAR,
                           LD_FECEMISION,
                           LV_NOMUSUARORA
                  FROM FA_FACTDOCU_NOCICLO A, GA_VENTAS B
                 WHERE A.NUM_FOLIO=EN_numFolio
                   AND A.NUM_VENTA=B.NUM_VENTA(+)
                   AND A.COD_TIPDOCUM=B.COD_TIPDOCUM(+)
                   AND A.COD_CLIENTE=B.COD_CLIENTE(+)
                   AND A.NUM_PROCESO=B.NUM_PROCESO(+)
                   AND A.COD_MODVENTA=B.COD_MODVENTA(+)
                   AND ROWNUM=1;

                --Validar si ya se realizo la consulta.
                BEGIN
                        SELECT COUNT(1)
                          INTO LN_CANTIDAD
                          FROM FA_AUDITIMPDES_TH
                         WHERE NUM_PROCESO = LN_numProceso;

                EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              LN_CANTIDAD:=0;
                         WHEN OTHERS THEN
                                  RAISE ERROR_PARAMETRO;
                END;

                IF (LN_CANTIDAD > 0) THEN
                   RAISE ERROR_PARAMETRO;
                END IF;


                LV_Sql:='SELECT a.dir_web'
                      || ' FROM fa_interimpresion_td a'
                      || ' WHERE a.cod_estado = ' || CV_ESTARCHFACTURA
                      || ' AND a.num_proceso = ' || LN_numProceso;

                --Obtener nombre de factura
                SELECT a.dir_web
                  INTO SV_nombre
                  FROM fa_interimpresion_td a
                 WHERE a.cod_estado = CV_ESTARCHFACTURA
                   AND a.num_proceso = LN_numProceso;

                --Insertar registro indicativo de realizada la consulta
                --obtener oficina
                SELECT COD_OFICCENTRAL
                  INTO LV_CODOFICCENTRAL
                  FROM GE_DATOSGENER;


                INSERT INTO FA_AUDITIMPDES_TH
                   (COD_OFICINA, COD_OPERADORA, NOM_USUARIO, FEC_IMPRESION, NUM_PROCESO, COD_TIPDOCUM, COD_CLIENTE, TOT_PAGAR)
                 VALUES
                   (LV_CODOFICCENTRAL, LV_CODOPERADORA, LV_NOMUSUARORA, LD_FECEMISION, LN_numProceso, LV_CODTIPDOCUM, LV_CODCLIENTE, LN_TOTPAGAR);


        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                  VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        WHEN ERROR_PARAMETRO THEN
                                 VE_intermediario_PG.VE_ErrorParametro_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getNombrePDFFactura_PR;

        PROCEDURE VE_getPathPDFFactura_PR(SV_path         OUT NOCOPY VARCHAR2,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getPathPDFFactura_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Path archivo PDF factura
                </Retorno>
                <Descripción>
                                  Recupera Path archivo PDF factura
                </Descripción>
                <Parámetros>
                 <Entrada> N/A </Entrada>
                 <Salida>
                           <param nom="SV_path"         Tipo="STRING"> path </param>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(23) := 'VE_getPathPDFFactura_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql:='SELECT a.des_valor'
                      || ' FROM co_codigos a'
                      || ' WHERE a.cod_modulo = ' || VE_intermediario_PG.CV_MODULO_FA
                      || ' AND a.nom_tabla = ' || CV_NOMTAB_COCODIGOS
                      || ' AND a.nom_columna = ' || CV_NOMCOL_COCODIGOS
                      || ' AND a.cod_valor IN (SELECT b.cod_direccion'
                      || ' FROM fa_tipdocdirec_td b'
                          || ' WHERE b.cod_tipdocum = (SELECT c.cod_tipdocum'
                      || ' FROM ge_catribdocum d, ge_tipdocumen c'
                      || ' WHERE d.cod_catribut = ' || VE_intermediario_PG.CV_CATTRIBFACTURA
                      || ' AND SYSDATE BETWEEN d.fec_desde AND NVL(D.FEC_HASTA,SYSDATE)'
                      || ' AND d.cod_tipdocum = c.cod_tipdocum)'
                      || ' AND b.cod_accion = ' || CN_CODACCION || ')';

                SELECT a.des_valor
                INTO SV_path
                FROM co_codigos a
                WHERE a.cod_modulo = VE_intermediario_PG.CV_MODULO_FA
                AND a.nom_tabla = CV_NOMTAB_COCODIGOS
                AND a.nom_columna = CV_NOMCOL_COCODIGOS
                AND a.cod_valor IN (SELECT b.cod_direccion
                                    FROM fa_tipdocdirec_td b
                                                        WHERE b.cod_tipdocum = (SELECT c.cod_tipdocum
                                                            FROM ge_catribdocum d,
                                                                                                             ge_tipdocumen c
                                                            WHERE d.cod_catribut = VE_intermediario_PG.CV_CATTRIBFACTURA
                                                              AND SYSDATE BETWEEN d.fec_desde AND NVL(D.FEC_HASTA,SYSDATE)
                                                              AND d.cod_tipdocum = c.cod_tipdocum)
                                    AND b.cod_accion = CN_CODACCION);

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                  VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getPathPDFFactura_PR;

        PROCEDURE VE_getCicloFactMasProx_PR(SV_cod_ciclo        OUT NOCOPY VARCHAR2,
                                        SV_ano              OUT NOCOPY VARCHAR2,
                                                                                SV_cod_ciclfact     OUT NOCOPY VARCHAR2,
                                                                                SV_fec_vencimie     OUT NOCOPY VARCHAR2,
                                                                                SV_fec_emision      OUT NOCOPY VARCHAR2,
                                                                                SV_fec_caducida     OUT NOCOPY VARCHAR2,
                                                                                SV_fec_proxvenc     OUT NOCOPY VARCHAR2,
                                                                                SV_fec_desdellam    OUT NOCOPY VARCHAR2,
                                                                                SV_fec_hastallam    OUT NOCOPY VARCHAR2,
                                                                                SV_dia_periodo      OUT NOCOPY VARCHAR2,
                                                                                SV_fec_desdecfijos  OUT NOCOPY VARCHAR2,
                                                                                SV_fec_hastacfijos  OUT NOCOPY VARCHAR2,
                                                                                SV_fec_desdeocargos OUT NOCOPY VARCHAR2,
                                                                                SV_fec_hastaocargos OUT NOCOPY VARCHAR2,
                                                                                SV_fec_desderoa     OUT NOCOPY VARCHAR2,
                                                                                SV_fec_hastaroa     OUT NOCOPY VARCHAR2,
                                                                                SV_ind_facturacion  OUT NOCOPY VARCHAR2,
                                                                                SV_dir_logs         OUT NOCOPY VARCHAR2,
                                                                                SV_dir_spool        OUT NOCOPY VARCHAR2,
                                                                                SV_des_leyen1       OUT NOCOPY VARCHAR2,
                                                                                SV_des_leyen2       OUT NOCOPY VARCHAR2,
                                                                                SV_des_leyen3       OUT NOCOPY VARCHAR2,
                                                                                SV_des_leyen4       OUT NOCOPY VARCHAR2,
                                                                                SV_des_leyen5       OUT NOCOPY VARCHAR2,
                                                                                SV_ind_tasador      OUT NOCOPY VARCHAR2,
                                                                    SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento       OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getCicloFactMasProx_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                 Datos ciclo de facturacion mas proximo
                </Retorno>
                <Descripción>
                                  Recupera Datos ciclo de facturacion mas proximo
                </Descripción>
                <Parámetros>
                 <Entrada> N/A </param>
                         </Entrada>
                 <Salida>
                                <param nom="SV_cod_ciclo"        Tipo="STRING"> codigo ciclo </param>
                                <param nom="SV_ano"              Tipo="STRING"> año </param>
                                <param nom="SV_cod_ciclfact"     Tipo="STRING"> codigo ciclo facturacion </param>
                                <param nom="SV_fec_vencimie"     Tipo="STRING"> fecha vencimiento </param>
                                <param nom="SV_fec_emision"      Tipo="STRING"> fecha emision </param>
                                <param nom="SV_fec_caducida"     Tipo="STRING"> fecha caducidad </param>
                                <param nom="SV_fec_proxvenc"     Tipo="STRING"> fecha prox. vencimiento </param>
                                <param nom="SV_fec_desdellam"    Tipo="STRING"> fecha desde llamada </param>
                                <param nom="SV_fec_hastallam"    Tipo="STRING"> fecha hasta llamada </param>
                                <param nom="SV_dia_periodo"      Tipo="STRING"> dia periodo </param>
                                <param nom="SV_fec_desdecfijos"  Tipo="STRING"> fecha desde cargos fijos </param>
                                <param nom="SV_fec_hastacfijos"  Tipo="STRING"> fecha hasta cargos fijos </param>
                                <param nom="SV_fec_desdeocargos" Tipo="STRING"> fecha desde otros cargos </param>
                                <param nom="SV_fec_hastaocargos" Tipo="STRING"> fecha hasta otros cargos </param>
                                <param nom="SV_fec_desderoa"     Tipo="STRING"> fecha desde roaming </param>
                                <param nom="SV_fec_hastaroa"     Tipo="STRING"> fecha hasta roaming </param>
                                <param nom="SV_ind_facturacion"  Tipo="STRING"> indicador facturacion </param>
                                <param nom="SV_dir_logs"         Tipo="STRING"> direccion logs </param>
                                <param nom="SV_dir_spool"        Tipo="STRING"> direccion spool </param>
                                <param nom="SV_des_leyen1"       Tipo="STRING"> descripcion leyenda 1 </param>
                                <param nom="SV_des_leyen2"       Tipo="STRING"> descripcion leyenda 2 </param>
                                <param nom="SV_des_leyen3"       Tipo="STRING"> descripcion leyenda 3 </param>
                                <param nom="SV_des_leyen4"       Tipo="STRING"> descripcion leyenda 4 </param>
                                <param nom="SV_des_leyen5"       Tipo="STRING"> descripcion leyenda 5 </param>
                                <param nom="SV_ind_tasador"      Tipo="STRING"> indicador tasador </param>
                            <param nom="SN_cod_retorno"      Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                    <param nom="SV_mens_retorno"     Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                    <param nom="SN_num_evento"       Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(25) := 'VE_getCicloFactMasProx_PR';
        V_CICLO FA_CICLOS.COD_CICLO%TYPE;
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql:='SELECT a.cod_ciclo,'
                       || ' a.ano,'
                           || ' a.cod_ciclfact,'
                           || ' a.fec_vencimie,'
                           || ' a.fec_emision,'
                           || ' a.fec_caducida,'
                           || ' a.fec_proxvenc,'
                           || ' a.fec_desdellam,'
                           || ' a.fec_hastallam,'
                           || ' a.dia_periodo,'
                           || ' a.fec_desdecfijos,'
                           || ' a.fec_hastacfijos,'
                           || ' a.fec_desdeocargos,'
                           || ' a.fec_hastaocargos,'
                           || ' a.fec_desderoa,'
                           || ' a.fec_hastaroa,'
                           || ' a.ind_facturacion,'
                           || ' a.dir_logs,'
                           || ' a.dir_spool,'
                           || ' a.des_leyen1,'
                           || ' a.des_leyen2,'
                           || ' a.des_leyen3,'
                           || ' a.des_leyen4,'
                           || ' a.des_leyen5,'
                           || ' a.ind_tasador'
                           || ' FROM fa_ciclfact a'
                           || ' WHERE a.fec_desdellam = (SELECT min(b.fec_desdellam)'
                           || ' FROM fa_ciclfact b'
                           || ' WHERE b.fec_desdellam >= SYSDATE'
                           || ' AND b.cod_ciclo <> ' || VE_intermediario_PG.CN_CODCICLO25
                           || ' AND b.cod_ciclo NOT IN (SELECT c.cod_valor'
                           || ' FROM ged_codigos c'
                           || ' WHERE c.cod_modulo = ' || VE_intermediario_PG.CV_MODULO_GA
                           || ' AND c.nom_tabla = ' || CV_NOMTAB_GEDCODIGOS2
                           || ' AND c.nom_columna = ' || CV_NOMCOL_GEDCODIGOS2 || '))';



                --OBTENGO EL CICLO ACTUAL

                SELECT COD_CICLO
                INTO V_CICLO
        FROM FA_CICLFACT
        WHERE FEC_HASTALLAM = (SELECT MAX(FEC_HASTALLAM) FROM FA_CICLFACT WHERE FEC_HASTALLAM < SYSDATE AND COD_CICLO <> VE_intermediario_PG.CN_CODCICLO25
        AND COD_CICLO IN (SELECT COD_VALOR FROM GED_CODIGOS WHERE NOM_TABLA='FA_CICLOS' AND COD_MODULO='GA' AND NOM_COLUMNA='COD_CICLO_LDI') );

        --UTILIZO LA MISMA CONSULTA PERO APLICO QUE EL CICLO NO SEA EL ACTUAL

        SELECT a.cod_ciclo,
                       a.ano,
                           a.cod_ciclfact,
                           a.fec_vencimie,
                           a.fec_emision,
                           a.fec_caducida,
                           a.fec_proxvenc,
                           a.fec_desdellam,
                           a.fec_hastallam,
                           a.dia_periodo,
                           a.fec_desdecfijos,
                           a.fec_hastacfijos,
                           a.fec_desdeocargos,
                           a.fec_hastaocargos,
                           a.fec_desderoa,
                           a.fec_hastaroa,
                           a.ind_facturacion,
                           a.dir_logs,
                           a.dir_spool,
                           a.des_leyen1,
                           a.des_leyen2,
                           a.des_leyen3,
                           a.des_leyen4,
                           a.des_leyen5,
                           a.ind_tasador
                INTO   SV_cod_ciclo,
                           SV_ano,
                           SV_cod_ciclfact,
                           SV_fec_vencimie,
                           SV_fec_emision,
                           SV_fec_caducida,
                           SV_fec_proxvenc,
                           SV_fec_desdellam,
                           SV_fec_hastallam,
                           SV_dia_periodo,
                           SV_fec_desdecfijos,
                           SV_fec_hastacfijos,
                           SV_fec_desdeocargos,
                           SV_fec_hastaocargos,
                           SV_fec_desderoa,
                           SV_fec_hastaroa,
                           SV_ind_facturacion,
                           SV_dir_logs,
                           SV_dir_spool,
                           SV_des_leyen1,
                           SV_des_leyen2,
                           SV_des_leyen3,
                           SV_des_leyen4,
                           SV_des_leyen5,
                           SV_ind_tasador
        FROM FA_CICLFACT A
        WHERE A.FEC_HASTALLAM =
                (SELECT MAX(FEC_HASTALLAM)
                FROM FA_CICLFACT b  WHERE b.FEC_HASTALLAM < SYSDATE
                AND b.COD_CICLO <> VE_intermediario_PG.CN_CODCICLO25    --INC. 63312
                and b.cod_ciclo=V_CICLO
                AND b.cod_ciclo NOT IN (SELECT c.cod_valor
                    FROM ged_codigos c
                        WHERE c.cod_modulo = VE_intermediario_PG.CV_MODULO_GA
                        AND c.nom_tabla =  CV_NOMTAB_GEDCODIGOS2
                        AND c.nom_columna = CV_NOMCOL_GEDCODIGOS2  ));  -- FIN INC 63312




--              SELECT a.cod_ciclo,
--                     a.ano,
--                         a.cod_ciclfact,
--                         a.fec_vencimie,
--                         a.fec_emision,
--                         a.fec_caducida,
--                         a.fec_proxvenc,
--                         a.fec_desdellam,
--                         a.fec_hastallam,
--                         a.dia_periodo,
--                         a.fec_desdecfijos,
--                         a.fec_hastacfijos,
--                         a.fec_desdeocargos,
--                         a.fec_hastaocargos,
--                         a.fec_desderoa,
--                         a.fec_hastaroa,
--                         a.ind_facturacion,
--                         a.dir_logs,
--                         a.dir_spool,
--                         a.des_leyen1,
--                         a.des_leyen2,
--                         a.des_leyen3,
--                         a.des_leyen4,
--                         a.des_leyen5,
--                         a.ind_tasador
--              INTO SV_cod_ciclo,
--                       SV_ano,
--                       SV_cod_ciclfact,
--                       SV_fec_vencimie,
--                       SV_fec_emision,
--                       SV_fec_caducida,
--                       SV_fec_proxvenc,
--                       SV_fec_desdellam,
--                       SV_fec_hastallam,
--                       SV_dia_periodo,
--                       SV_fec_desdecfijos,
--                       SV_fec_hastacfijos,
--                       SV_fec_desdeocargos,
--                       SV_fec_hastaocargos,
--                       SV_fec_desderoa,
--                       SV_fec_hastaroa,
--                       SV_ind_facturacion,
--                       SV_dir_logs,
--                       SV_dir_spool,
--                       SV_des_leyen1,
--                       SV_des_leyen2,
--                       SV_des_leyen3,
--                       SV_des_leyen4,
--                       SV_des_leyen5,
--                       SV_ind_tasador
--              FROM fa_ciclfact a
--              WHERE a.fec_desdellam = (SELECT min(b.fec_desdellam)
--                                                   FROM fa_ciclfact b
--                                                   WHERE b.fec_desdellam >= SYSDATE
--                                         AND b.cod_ciclo <> VE_intermediario_PG.CN_CODCICLO25
--                                         AND b.cod_ciclo NOT IN (SELECT c.cod_valor
--                                                                 FROM ged_codigos c
--                                                                 WHERE c.cod_modulo = VE_intermediario_PG.CV_MODULO_GA
--                                                                                   AND c.nom_tabla = CV_NOMTAB_GEDCODIGOS2
--                                                                                   AND c.nom_columna = CV_NOMCOL_GEDCODIGOS2));

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                  VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getCicloFactMasProx_PR;
        PROCEDURE VE_getDireccionUsuario_PR(EV_codUsuario   IN VARCHAR2,
                                        EV_TipDireccion IN VARCHAR2,
                                                                                SV_codDireccion OUT NOCOPY VARCHAR2,
                                                            SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getDireccionFactUsuario_PR"
                        Lenguaje="PL/SQL"
                        Fecha="01-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  codigo de la direccion de facturacion, si existe
                </Retorno>
                <Descripción>
                                  Obtiene la direccion de facturacion, en la tabla ga_direcusuar
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codUsuario" Tipo="STRING"> codigo usuario </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_codDireccion" Tipo="STRING"> codigo direccion </param>
                           <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(29) := 'VE_getDireccionFactUsuario_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql:='SELECT a.cod_direccion'
                  || ' FROM ga_direcusuar a'
                  || ' WHERE a.cod_tipdireccion = ' || EV_TipDireccion
                          || ' AND a.cod_usuario = ' || EV_codUsuario;

                SELECT a.cod_direccion
                INTO SV_codDireccion
        FROM ga_direcusuar a
        WHERE a.cod_tipdireccion = EV_TipDireccion
                  AND a.cod_usuario = EV_codUsuario;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                  SV_codDireccion := '0';
                         WHEN OTHERS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getDireccionUsuario_PR;

        PROCEDURE VE_RecepcionDocumentos_PR(EV_numVenta    IN VARCHAR2,
                                            EV_nomUsuario  IN VARCHAR2,
                                                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_RecepcionDocumentos_PR"
                        Lenguaje="PL/SQL"
                        Fecha="10-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Recepcion de documentos en la legalizacion de la venta
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_numVenta"   Tipo="STRING"> numero venta </param>
                           <param nom="EV_nomUsuario" Tipo="STRING"> nombre usuario </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(25) := 'VE_RecepcionDocumentos_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;

                LN_bdealer    NUMBER;
                LV_NomTablAbo VARCHAR2(11);
                LN_bindconsig NUMBER;

        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql := 'SELECT b.ind_vta_externa'
                       || ' FROM ga_ventas a,'
                       || '      ve_tipcomis b'
                       || ' WHERE a.cod_tipcomis = b.cod_tipcomis'
                       || '   AND a.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LN_bdealer;

                LV_Sql := 'SELECT ''GA_ABOCEL'''
                       || ' FROM ga_abocel a'
                       || ' WHERE a.num_venta = ' || EV_numVenta
                       || ' UNION'
                       || ' SELECT ''GA_ABOAMIST'''
                       || ' FROM ga_aboamist b'
                       || ' WHERE b.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LV_NomTablAbo;

                LV_Sql := 'SELECT COUNT(1)'
                       || ' FROM ' || LV_NomTablAbo || ' a,'
                       || '      ga_preliquidacion b'
                       || ' WHERE a.num_venta = b.num_venta'
                       || '   AND a.num_venta = ' || EV_numVenta;

            BEGIN

                EXECUTE IMMEDIATE LV_Sql INTO LN_bindconsig;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                             LN_bindconsig:=0;
                                 NULL;
                END;

                LV_Sql := 'UPDATE ga_ventas'
                       || ' SET ind_estventa = ''' || VE_intermediario_PG.CV_ESTVENTA_PC || ''' '
                       || ' ,nom_usuar_recdoc = ''' || EV_nomUsuario || ''' '
                       || ' ,fec_recdocum = SYSDATE'
                       || ' WHERE num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql;

                LV_Sql := 'UPDATE ' || LV_NomTablAbo
                       || ' SET fec_recdocum = SYSDATE,'
                       || ' fec_ultmod = SYSDATE'
                       || ' WHERE num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql;

                -- Inc. 72217 JMC 27/10/208
                -- IF (LN_bdealer = CN_INDDELAER) AND (LN_bindconsig > 0) THEN
                IF (LN_bindconsig > 0) THEN

                   LV_Sql := 'UPDATE ga_preliquidacion'
                          || ' SET ind_estventa= ''' || VE_intermediario_PG.CV_ESTVENTA_PC || ''' '
                          || ' WHERE num_venta = ' || EV_numVenta;

               EXECUTE IMMEDIATE LV_Sql;


                   LV_Sql := 'UPDATE ga_ventas'
                          -- Inc. 72217 JMC 27/10/208, se corrige esta linea
                          -- || ' SET usu_recep_admvtas =  || EV_nomUsuario
                          || ' SET usu_recep_admvtas = ''' || EV_nomUsuario || ''' '
                          || ' ,fec_recep_admvtas = SYSDATE'
                          || ' WHERE num_venta = ' || EV_numVenta;

               EXECUTE IMMEDIATE LV_Sql;

                END IF;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_RecepcionDocumentos_PR;

        PROCEDURE VE_ComplementacionDatos_PR(EV_numVenta    IN VARCHAR2,
                                             EV_nomUsuario  IN VARCHAR2,
                                                                     SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_ComplementacionDatos_PR"
                        Lenguaje="PL/SQL"
                        Fecha="10-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Complementacion de los datos en la legalizacion de la venta
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_numVenta"   Tipo="STRING"> numero venta </param>
                           <param nom="EV_nomUsuario" Tipo="STRING"> nombre usuario </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(26) := 'VE_ComplementacionDatos_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;

                LN_bdealer    NUMBER;
                LV_NomTablAbo VARCHAR2(11);
                LV_NomTablUsu VARCHAR2(11);
                LN_bindconsig NUMBER;
                LV_nombre     VARCHAR2(50);
                LV_apellido   VARCHAR2(20);
                LV_fecnac     VARCHAR2(10);
                LV_tipoiden   VARCHAR2(2);
                LV_numident   VARCHAR2(20);
                LN_codUsuario NUMBER;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql := 'SELECT b.ind_vta_externa'
                       || ' FROM ga_ventas a,'
                       || '      ve_tipcomis b'
                       || ' WHERE a.cod_tipcomis = b.cod_tipcomis'
                       || '   AND a.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LN_bdealer;

                LV_Sql := 'SELECT ''GA_ABOCEL'''
                       || ' FROM ga_abocel a'
                       || ' WHERE a.num_venta = ' || EV_numVenta
                       || ' UNION'
                       || ' SELECT ''GA_ABOAMIST'''
                       || ' FROM ga_aboamist b'
                       || ' WHERE b.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LV_NomTablAbo;

                LV_Sql := 'SELECT ''GA_USUARIOS'''
                       || ' FROM ga_abocel a'
                       || ' WHERE a.num_venta = ' || EV_numVenta
                       || ' UNION'
                       || ' SELECT ''GA_USUAMIST'''
                       || ' FROM ga_aboamist b'
                       || ' WHERE b.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LV_NomTablUsu;

                LV_Sql := 'SELECT COUNT(1)'
                       || ' FROM ' || LV_NomTablAbo || ' a,'
                       || '      ga_preliquidacion b'
                       || ' WHERE a.num_venta = b.num_venta'
                       || '   AND a.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LN_bindconsig;

                LV_Sql := 'UPDATE ga_ventas'
                       || ' SET ind_estventa = ''' || VE_intermediario_PG.CV_ESTVENTA_PA || ''' '
                       || ' ,nom_usuar_cumpl = ''' || EV_nomUsuario || ''' '
                       || ' ,fec_cumplimenta = SYSDATE'
                       || ' WHERE num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql;

                LV_Sql := 'UPDATE ' || LV_NomTablAbo
                       || ' SET fec_cumplimen = SYSDATE,'
                       || ' fec_ultmod = SYSDATE'
                       || ' WHERE num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql;

                -- Inc. 72217 JMC 27/10/208
                -- IF (LN_bdealer = CN_INDDELAER) AND (LN_bindconsig > 0) THEN
                IF (LN_bindconsig > 0) THEN

                   LV_Sql := 'UPDATE ga_preliquidacion'
                          || ' SET ind_estventa= ''' || VE_intermediario_PG.CV_ESTVENTA_PA || ''' '
                          || ' WHERE num_venta = ' || EV_numVenta;

               EXECUTE IMMEDIATE LV_Sql;
                   -- Inc. 72217 JMC 27/10/208, se corrige esta linea
                   -- || ' SET usu_recep_admvtas = ' || EV_nomUsuario

                   LV_Sql := 'UPDATE ga_ventas'
                          -- Inc. 72217 JMC 27/10/208, se corrige esta linea
                          -- || ' SET usu_recep_admvtas = ' || EV_nomUsuario
                          || ' SET usu_recep_admvtas = ''' || EV_nomUsuario || ''' '
                          || ' ,fec_recep_admvtas = SYSDATE'
                          || ' WHERE num_venta = ' || EV_numVenta;

               EXECUTE IMMEDIATE LV_Sql;

                END IF;

                LV_nombre := NULL;
                LV_apellido := NULL;
                LV_fecnac := NULL;
                LV_tipoiden := NULL;
                LV_numident := NULL;

            LV_Sql := 'SELECT a.nom_cliente'
                       || ' ,a.nom_apeclien1'
                           || ' ,TO_DATE(a.fec_nacimien,''' || VE_intermediario_PG.CV_FORMATOFECHA || ''')'
                           || ' ,a.cod_tipident'
                           || ' ,a.num_ident'
                       || ' FROM ge_clientes a,'
                       || LV_NomTablAbo || ' b'
                       || ' WHERE a.cod_cliente = b.cod_cliente'
                   || ' AND num_venta = ' || EV_numVenta;

        EXECUTE IMMEDIATE LV_Sql INTO LV_nombre,LV_apellido,LV_fecnac,LV_tipoiden,LV_numident;

                IF (LV_nombre IS NOT NULL) THEN

                        BEGIN
                        -- Obtenemos codigo de usuario
                            LV_Sql := 'SELECT a.cod_usuario'
                                       || ' FROM ' || LV_NomTablUsu || ' a,' ||  LV_NomTablAbo || ' b'
                                       || ' WHERE b.cod_usuario = a.cod_usuario'
                                       || ' AND b.num_venta = ' || EV_numVenta;

                        EXECUTE IMMEDIATE LV_Sql INTO LN_codUsuario;

                                EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                                  LN_codUsuario := 0;

                        END;

                        IF (LN_codUsuario <> 0) THEN

                            LV_Sql := 'UPDATE ' || LV_NomTablUsu
                                       || ' SET nom_usuario = ' || LV_nombre
                                       || ' ,nom_apellido1 = ' || LV_apellido
                                       || ' ,fec_nacimien = ' || LV_fecnac
                                       || ' ,cod_tipident = ' || LV_tipoiden
                                       || ' ,num_ident = ' || LV_numident
                                       || ' WHERE cod_usuario = ' || LN_codUsuario;

                        END IF;

                END IF;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_ComplementacionDatos_PR;

        PROCEDURE VE_AceptacionVenta_PR(EV_numVenta    IN VARCHAR2,
                                        EV_nomUsuario  IN VARCHAR2,
                                                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_AceptacionVenta_PR"
                        Lenguaje="PL/SQL"
                        Fecha="10-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Aceptacion de la venta
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_numVenta"   Tipo="STRING"> numero venta </param>
                           <param nom="EV_nomUsuario" Tipo="STRING"> nombre usuario </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(21) := 'VE_AceptacionVenta_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;

                LN_bdealer     NUMBER;
                LV_NomTablAbo  VARCHAR2(11);
                LN_bindconsig  NUMBER;
                LN_codCliente  NUMBER;
                LN_NumUnidades NUMBER;

        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LN_NumUnidades := 0;
                LN_codCliente  := 0;

                LV_Sql := 'SELECT b.ind_vta_externa'
                       || ' ,a.num_unidades'
                           || ' ,a.cod_cliente'
                       || ' FROM ga_ventas a,'
                       || '      ve_tipcomis b'
                       || ' WHERE a.cod_tipcomis = b.cod_tipcomis'
                       || '   AND a.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LN_bdealer,LN_NumUnidades,LN_codCliente;

                LV_Sql := 'SELECT ''GA_ABOCEL'''
                       || ' FROM ga_abocel a'
                       || ' WHERE a.num_venta = ' || EV_numVenta
                       || ' UNION'
                       || ' SELECT ''GA_ABOAMIST'''
                       || ' FROM ga_aboamist b'
                       || ' WHERE b.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LV_NomTablAbo;

                LV_Sql := 'SELECT COUNT(1)'
                       || ' FROM ' || LV_NomTablAbo || ' a,'
                       || '      ga_preliquidacion b'
                       || ' WHERE a.num_venta = b.num_venta'
                       || '   AND a.num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql INTO LN_bindconsig;

                LV_Sql := 'UPDATE ga_ventas'
                       || ' SET ind_estventa = ''' || VE_intermediario_PG.CV_ESTVENTA_AC || ''' '
					   --Inicio Incidencia 71347 [ACP Soporte Ventas 07-10-2008]
					   || ' ,nom_usuar_acerec  = ''' || EV_nomUsuario || ''' '
					   || ' ,fec_aceprec = SYSDATE'
					   --Fin Incidencia 71347 [ACP Soporte Ventas 07-10-2008]
                       || ' WHERE num_venta = ' || EV_numVenta;


            EXECUTE IMMEDIATE LV_Sql;

                LV_Sql := 'UPDATE ' || LV_NomTablAbo
                       || ' SET fec_acepventa = SYSDATE,'
                       || ' fec_ultmod = SYSDATE'
                       || ' WHERE num_venta = ' || EV_numVenta;

            EXECUTE IMMEDIATE LV_Sql;

            LV_Sql := 'UPDATE ge_clientes'
                       || ' SET num_abocel = num_abocel + ' ||  LN_NumUnidades
                       || ' ,ind_acepvent = ' || CN_INDACEPVENT
                       || ' ,fec_acepvent = NVL(fec_acepvent,SYSDATE)'
                       || ' WHERE cod_cliente = ' || LN_codCliente;

            EXECUTE IMMEDIATE LV_Sql;

                -- Inc. 72217 JMC 27/10/208
                -- IF (LN_bdealer = CN_INDDELAER) AND (LN_bindconsig > 0) THEN
                IF (LN_bindconsig > 0) THEN

                   LV_Sql := 'UPDATE ga_preliquidacion'
                          || ' SET ind_estventa= ''' || VE_intermediario_PG.CV_ESTVENTA_AC || ''' '
                                  || ' ,fec_aceprec = SYSDATE'
                          || ' WHERE num_venta = ' || EV_numVenta;

               EXECUTE IMMEDIATE LV_Sql;



                   LV_Sql := 'UPDATE ga_ventas'
                          -- Inc. 72217 JMC 27/10/208, se corrige esta linea
                          -- || ' SET usu_recep_admvtas = ' || EV_nomUsuario
                          || ' SET usu_recep_admvtas = ''' || EV_nomUsuario || ''' '
                          || ' ,fec_recep_admvtas = SYSDATE'
                          || ' WHERE num_venta = ' || EV_numVenta;

               EXECUTE IMMEDIATE LV_Sql;

                END IF;

                --INI Inc 45391
            VE_EjecutaOmitidos_PR(EV_numVenta, SN_cod_retorno, SV_mens_retorno, SN_num_evento );
                --FIN Inc 45391


        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_AceptacionVenta_PR;

-----------------------------------------------------------------------------------------------------

PROCEDURE VE_EjecutaOmitidos_PR(EV_numVenta     IN VARCHAR2,
                                SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
/*
<Documentación TipoDoc = "Procedimiento">
Elemento Nombre = "VE_EjecutaOmitidos_PR"
Lenguaje="PL/SQL"
Fecha="14-08-2007"
Versión="1.0.0"
Diseñador="wjrc"
Programador="wjrc"
Ambiente="BD"
<Retorno> N/A </Retorno>
<Descripción>
			 Ejecuta omitidos en la legalizacion de la venta
</Descripción>
<Parámetros>
<Entrada>
		 <param nom="EV_numVenta"   Tipo="STRING"> numero venta </param>
</Entrada>
<Salida>
		<param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
		<param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
		<param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
	CV_NOMBRE_PRODEDURE CONSTANT VARCHAR2(21) := 'VE_EjecutaOmitidos_PR';
	CV_IND_PROMOCION    CONSTANT VARCHAR2(1):='F';

	ERROR_SQL         EXCEPTION;

	LV_desError       ge_errores_pg.desevent;
	LV_sql            ge_errores_pg.vquery;

	LC_cursorDatos    REFCURSOR;

	LV_NomTablAbo     VARCHAR2(11);
	LN_numAbonado     NUMBER;

	LN_num_abonado    NUMBER(8);
	LN_num_celular    NUMBER(15);
	LV_num_serie      VARCHAR2(25);
	LN_cod_cliente    NUMBER(8);
	LV_cod_situacion  VARCHAR2(3);
	LN_ind_supertel   NUMBER;
	LV_num_telefija   VARCHAR2(15);
	LN_count          NUMBER;
	LB_nParam         BOOLEAN;
	LN_num_secuencia  NUMBER;

	LN_codRetorno     NUMBER;
	LV_desCadena      VARCHAR2(255);

	LV_var1           VARCHAR2(2) := '';
	LV_var2           VARCHAR2(2) := '';
	LV_var3           VARCHAR2(2) := '';
	LV_var4           VARCHAR2(2) := '';
	LV_var5           VARCHAR2(2) := '';
	LV_var6           VARCHAR2(2) := '';
BEGIN
    SN_cod_retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento  := 0;

    LV_Sql := 'SELECT ''GA_ABOCEL'''
           || ' FROM ga_abocel a'
           || ' WHERE a.num_venta = ' || EV_numVenta
           || ' UNION'
           || ' SELECT ''GA_ABOAMIST'''
           || ' FROM ga_aboamist b'
           || ' WHERE b.num_venta = ' || EV_numVenta;

    EXECUTE IMMEDIATE LV_Sql INTO LV_NomTablAbo;

    LV_Sql := 'SELECT a.num_abonado'
           || ' FROM ' || LV_NomTablAbo || ' a'
           || ' WHERE a.num_venta = ' || EV_numVenta;

    EXECUTE IMMEDIATE LV_Sql INTO LN_numAbonado;

    LV_Sql := 'SELECT a.num_abonado,'
           || ' a.num_celular,'
           || ' a.num_serie,'
           || ' a.cod_cliente,'
           || ' a.cod_situacion,'
           || ' a.ind_supertel,'
           || ' a.num_telefija'
           || ' FROM ga_abocel a'
           || ' WHERE a.num_venta = ' || EV_numVenta
           || ' AND a.cod_situacion NOT IN (' || '''BAA''' || ',' || '''BAP''' || ')'
           || ' FOR UPDATE NOWAIT';

    OPEN LC_cursorDatos FOR LV_Sql;
	LOOP

	    FETCH LC_cursorDatos
	    INTO LN_num_abonado,
	         LN_num_celular,
	         LV_num_serie,
	         LN_cod_cliente,
	         LV_cod_situacion,
	         LN_ind_supertel,
	         LV_num_telefija;

	    EXIT WHEN LC_cursorDatos%NOTFOUND;

		IF (LV_NomTablAbo <> 'GA_ABOAMIST') THEN --(+a)

		   IF (LN_ind_supertel = 0 AND LENGTH(TO_NUMBER(LV_num_telefija)) <= 10) THEN --(+b)
               -- No es STM

	          LV_Sql := 'INSERT INTO ga_ctc_movimientos ('
	                 || ' num_redfija,'
	                 || ' fec_movimiento,'
	                 || ' tip_movimiento,'
	                 || ' num_celular1,'
	                 || ' num_celular2)'
	                 || ' VALUES ('
	                 || ':1,'
	                 || ':2,'
	                 || ':3,'
	                 || ':4,'
	                 || ':5)';

         	  BEGIN --(+c)
                  EXECUTE IMMEDIATE LV_Sql USING LV_num_telefija,
                                                 SYSDATE,
                                                 0,
                                                 LN_num_celular,
                                                 0;
			      EXCEPTION
                       WHEN OTHERS THEN
                            SN_cod_retorno := 3;
              END;--(-c)

           END IF;--(-b)

           BEGIN --(+d)
               LB_nParam := TRUE;

               SELECT UNIQUE 1
               INTO LN_count
               FROM ga_intarcel a
               WHERE a.cod_cliente = LN_cod_cliente
                 AND a.num_abonado = LN_num_abonado;

               EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         LB_nParam := FALSE;
                    WHEN OTHERS THEN
                         LB_nParam := FALSE;
                         SN_cod_retorno := 4;
           END; --(-d)

           IF NOT LB_nParam and SN_cod_retorno <> 4 THEN --(+e)
           -- Ejecutando PL de aceptación

              BEGIN --(+f)
                  SELECT ga_seq_transacabo.NEXTVAL
                  INTO LN_num_secuencia
                  FROM dual;

                  EXCEPTION
                       WHEN OTHERS THEN
                            SN_cod_retorno := 5;
              END;--(-f)

              BEGIN --(+g)
                  P_Interfases_Abonados(LN_num_secuencia,
                                        VE_intermediario_PG.CV_ACTABO_AV,
                                        VE_intermediario_PG.CN_PRODUCTO,
                                        LN_num_abonado,
                                        LV_var1,
                                        LV_var2,
                                        LV_var3,
                                        LV_var4,
                                        LV_var5,
                                        LV_var6);
                  EXCEPTION
                       WHEN OTHERS THEN
                            LB_nParam := FALSE;
                            SN_cod_retorno := 6;
              END;--(-g)

              IF NOT LB_nParam and SN_cod_retorno <> 4 THEN --(+h)
                 BEGIN --(+i)
                     SELECT a.cod_retorno,
                            a.des_cadena
                     INTO LN_codRetorno,
                          LV_desCadena
                     FROM ga_transacabo a
                     WHERE a.num_transaccion = LN_num_secuencia;

                     IF SQL%ROWCOUNT = 1 THEN --(+j)
                        DELETE ga_transacabo
                        WHERE num_transaccion = LN_num_secuencia;
                     END IF;--(-j)
                 END;--(-i)
              END IF;--(-h)
           END IF;--(-e)
        END IF;--(-a)

        IF (LV_cod_situacion NOT IN('SAA','STP','SAO','SAT','SCV','SRD','AOS','ATS','CVS','RDS','ERA')) THEN --(+k)

            LV_Sql := 'UPDATE ga_abocel'
                   || ' SET cod_situacion = :1'
                   || ' WHERE num_abonado = :2';

            BEGIN --(+l)
                EXECUTE IMMEDIATE LV_Sql USING  'AAA',LN_num_abonado;

                EXCEPTION
                     WHEN OTHERS THEN
                          SN_cod_retorno := 7;
            END;--(-l)

        END IF;--(-k)

        BEGIN --(+m)
            SELECT 1
            INTO LN_count
            FROM ci_promocion_analogos a
            WHERE a.ind_promocion = CV_IND_PROMOCION
            AND a.num_celular = LN_num_celular;

            IF (SQL%ROWCOUNT = 1) THEN --(+n)
                BEGIN --(+o)
                        UPDATE ci_promocion_analogos
                        SET fec_cambio_dh = SYSDATE,
                            num_serien = LV_num_serie
                        WHERE NUM_CELULAR = LN_num_celular;

                        EXCEPTION
                             WHEN OTHERS THEN
                                  SN_cod_retorno := 8;
                END;--(-o)
            END IF;--(-n)

            EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                      null;
                 WHEN OTHERS THEN
                      SN_cod_retorno := 11;
        END;--(-m)

    END LOOP;

    -- Cerramos el cursor
    CLOSE LC_cursorDatos;

    IF (SN_cod_retorno > 0) THEN --(+p)
       RAISE ERROR_SQL;
    END IF;--(-p)

EXCEPTION
	WHEN ERROR_SQL THEN
		 VE_intermediario_PG.VE_ErrorSql_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	WHEN NO_DATA_FOUND THEN
		 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	WHEN OTHERS THEN
		 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
END VE_EjecutaOmitidos_PR;

-----------------------------------------------------------------------------------------------------

        PROCEDURE VE_LegalizacionVenta_PR(EV_numVenta    IN VARCHAR2,
                                          EV_nomUsuario  IN VARCHAR2,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_LegalizacionVenta_PR"
                        Lenguaje="PL/SQL"
                        Fecha="14-08-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Legalizacion de la venta
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_numVenta"   Tipo="STRING"> numero venta </param>
                           <param nom="EV_nomUsuario" Tipo="STRING"> nombre usuario </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(23) := 'VE_LegalizacionVenta_PR';

            ERROR_SQL   EXCEPTION;

                LV_sql          ge_errores_pg.vquery;
                LV_estVenta VARCHAR2(2);
                --Agregado para manejar excepciones
        LV_codRetorno  ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.desevent;
                LV_COUNT   NUMBER(1);
                ERROR_USUARIO exception;
        --fin
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;


                LV_Sql:= 'SELECT COUNT(1) FROM GA_VENTAS WHERE NUM_VENTA = ' || EV_numVenta;
                LV_Sql:= LV_Sql || 'AND IND_VENTA in (V,P)';

                SELECT COUNT(1)
                INTO LV_COUNT
                FROM GA_VENTAS
                WHERE NUM_VENTA=EV_numVenta
                AND IND_VENTA in ('V','P');


                IF LV_COUNT=0 THEN
                   RAISE NO_DATA_FOUND;
                END IF;


                LV_Sql:= 'SELECT COUNT(1) FROM GE_SEG_USUARIOS WHERE NOM_USUARIO = ' || UPPER(EV_NomUsuario);

                SELECT COUNT(1)
                INTO LV_COUNT
                FROM GE_SEG_USUARIO
                WHERE NOM_USUARIO=UPPER(EV_NomUsuario);

                IF LV_COUNT=0 THEN
                   RAISE ERROR_USUARIO;
                END IF;

                LV_Sql := 'SELECT a.ind_estventa'
                       || ' FROM ga_ventas a'
                       || ' WHERE a.num_venta = ' || EV_numVenta;

                SELECT a.ind_estventa
                INTO LV_estVenta
                FROM ga_ventas a
                WHERE a.num_venta = EV_numVenta;

                IF (LV_estVenta = VE_intermediario_PG.CV_ESTVENTA_PD) THEN
                -- pendiente documentar

                           VE_RecepcionDocumentos_PR(EV_numVenta,
                                             UPPER(EV_nomUsuario),
                                                                     SN_cod_retorno,
                                             SV_mens_retorno,
                                             SN_num_evento);

                           VE_ComplementacionDatos_PR(EV_numVenta,
                                              UPPER(EV_nomUsuario),
                                                                      SN_cod_retorno,
                                              SV_mens_retorno,
                                              SN_num_evento);

                       VE_AceptacionVenta_PR(EV_numVenta,
                                         UPPER(EV_nomUsuario),
                                                                 SN_cod_retorno,
                                         SV_mens_retorno,
                                         SN_num_evento);

                ELSIF (LV_estVenta = VE_intermediario_PG.CV_ESTVENTA_PC) THEN
                -- pendiente cumplimentar

                           VE_ComplementacionDatos_PR(EV_numVenta,
                                              UPPER(EV_nomUsuario),
                                                                      SN_cod_retorno,
                                              SV_mens_retorno,
                                              SN_num_evento);

                       VE_AceptacionVenta_PR(EV_numVenta,
                                         UPPER(EV_nomUsuario),
                                                                 SN_cod_retorno,
                                         SV_mens_retorno,
                                         SN_num_evento);

                ELSIF (LV_estVenta = VE_intermediario_PG.CV_ESTVENTA_PA) THEN
                -- pendiente aceptacion

                       VE_AceptacionVenta_PR(EV_numVenta,
                                         UPPER(EV_nomUsuario),
                                                                 SN_cod_retorno,
                                         SV_mens_retorno,
                                         SN_num_evento);

                ELSIF (LV_estVenta = VE_intermediario_PG.CV_ESTVENTA_AC) THEN
                -- aceptacion de la venta

                        SV_mens_retorno := 'venta está legalizada';

                ELSE
                        RAISE ERROR_SQL;
                END IF;

                IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_SQL;
                END IF;

        EXCEPTION
                        WHEN ERROR_SQL THEN
                                 VE_intermediario_PG.VE_ErrorSql_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN NO_DATA_FOUND THEN
                                 SN_cod_retorno:=761;
                         SV_mens_retorno:='No existen datos de la venta';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                         WHEN ERROR_USUARIO THEN
                             SN_cod_retorno:=172;
                         SV_mens_retorno:='Ingrese Usuario SCL Valido';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_LegalizacionVenta_PR;


    -- Insert y Updates ------------------------------------------------------------------------
                PROCEDURE VE_updUsuario_PR(EV_numAbonado   IN GA_ABOCEL.NUM_ABONADO%TYPE,
                              EV_nomUsuario    IN GA_USUARIOS.NOM_USUARIO%TYPE,
                                  EV_nomApell1     IN GA_USUARIOS.NOM_APELLIDO1%TYPE,
                                  EV_nomApell2     IN GA_USUARIOS.NOM_APELLIDO2%TYPE,
                                  EV_tipIdentif    IN GA_USUARIOS.COD_TIPIDENT%TYPE,
                                  EV_numIdentif    IN GA_USUARIOS.NUM_IDENT%TYPE,
                                  EV_codProvincia  IN GE_DIRECCIONES.COD_PROVINCIA%TYPE,
                                  EV_codCiudad     IN GE_DIRECCIONES.COD_CIUDAD%TYPE,
                                  EV_Direccion     IN GE_DIRECCIONES.DES_DIREC1%TYPE,
                                  EV_Observacion   IN GE_DIRECCIONES.OBS_DIRECCION%TYPE,
                                  EV_fecNacimiento IN VARCHAR2,
                                  EV_Sexo          IN GA_USUARIOS.IND_SEXO%TYPE,
                                  EV_codEstrato    IN GA_USUARIOS.COD_ESTRATO%TYPE,
                                  EV_Mail          IN GA_USUARIOS.EMAIL%TYPE,
                                                          EV_usuarora      IN GA_MODDIRUS.NOM_USUARORA%TYPE,
                                                          EV_TIPDIRECCION  IN GA_DIRECUSUAR.COD_TIPDIRECCION%TYPE,
                                                          EV_cod_region    IN GE_DIRECCIONES.COD_REGION%TYPE,
                                                          EV_cod_comuna    IN GE_DIRECCIONES.COD_COMUNA%TYPE,
                                                          EV_tipo_calle    IN GE_DIRECCIONES.COD_TIPOCALLE%TYPE,
                                                          SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_updUsuario_PR"
                        Lenguaje="PL/SQL"
                        Fecha="14-08-2007"
                        Versión="1.0.0"
                        Diseñador="Igo"
                        Programador="Igo"
                        Ambiente="BD"
                <Retorno> N/A </Retorno>
                <Descripción>
                                  Actualiza datos usuario prepago
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codUsuario"    Tipo="STRING"> codigo usuario </param>
                           <param nom="EV_nomUsuario"    Tipo="STRING"> nombre </param>
                           <param nom="EV_nomApell1"     Tipo="STRING"> apellido paterno </param>
                           <param nom="EV_nomApell2"     Tipo="STRING"> apellido materno </param>
                           <param nom="EV_tipIdentif"    Tipo="STRING"> tipo identificador </param>
                           <param nom="EV_numIdentif"    Tipo="STRING"> numero identificador </param>
                           <param nom="EV_fonContacto"   Tipo="STRING"> fono contacto </param>
                           <param nom="EV_codProvincia"  Tipo="STRING"> codigo provincia </param>
                           <param nom="EV_codCiudad"     Tipo="STRING"> codido ciudad </param>
                           <param nom="EV_Direccion"     Tipo="STRING"> direccion, calle </param>
                           <param nom="EV_Observacion"   Tipo="STRING"> observacion direccion </param>
                           <param nom="EV_fecNacimiento" Tipo="STRING"> fecha nacimiento </param>
                           <param nom="EV_Sexo"          Tipo="STRING"> sexo </param>
                           <param nom="EV_codEstrato"    Tipo="STRING"> codigo estrato </param>
                           <param nom="EV_Mail"          Tipo="STRING"> email </param>
                           <param nom="EV_usuarora"      Tipo="STRING"> Nom_usuarora </param>
                         </Entrada>
                 <Salida>
                           <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(16) := 'VE_updUsuario_PR';
                --EV_TIPDIRECCION       NUMBER(1);
            ERROR_SQL             EXCEPTION;
                CV_TIPOUSUARIO        VARCHAR(8);
                CV_TABABONADO         VARCHAR(11);
                CV_TABUSUARIO         VARCHAR(11);
                CV_CODUSUARIO         GA_ABOCEL.COD_USUARIO%TYPE;
        LV_numAbonado         GA_ABOCEL.NUM_ABONADO%TYPE;
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;

        LV_codDirAnterior VARCHAR2(8);
                LV_secuencia      VARCHAR2(30);
        LV_COUNT          NUMBER(5);
                --Agregado para rellenar datos vacios
                LV_NOMUSUARIO   GA_USUARIOS.NOM_USUARIO%TYPE;
                LV_NOMAPELLIDO1 GA_USUARIOS.NOM_APELLIDO1%TYPE;
                LV_NOMAPELLIDO2 GA_USUARIOS.NOM_APELLIDO2%TYPE;
                LV_CODTIPIDENT  GA_USUARIOS.COD_TIPIDENT%TYPE;
                LV_NUMIDENT     GA_USUARIOS.NUM_IDENT%TYPE;
                LV_FECNACIMIEN  DATE;  --VARCHAR2(10);
                LV_SEXO      GA_USUARIOS.IND_SEXO%TYPE;
                LV_CODESTRATO   GA_USUARIOS.COD_ESTRATO%TYPE;
                LV_EMAIL        GA_USUARIOS.EMAIL%TYPE;
                LV_USUARORA     GA_MODDIRUS.NOM_USUARORA%TYPE;

                LV_TNOMUSUARIO   GA_USUARIOS.NOM_USUARIO%TYPE;
                LV_TNOMAPELLIDO1 GA_USUARIOS.NOM_APELLIDO1%TYPE;
                LV_TNOMAPELLIDO2 GA_USUARIOS.NOM_APELLIDO2%TYPE;
                LV_TCODTIPIDENT  GA_USUARIOS.COD_TIPIDENT%TYPE;
                LV_TNUMIDENT     GA_USUARIOS.NUM_IDENT%TYPE;
                LV_TFECNACIMIEN  DATE;  --VARCHAR2(10);
                LV_TSEXO      GA_USUARIOS.IND_SEXO%TYPE;
                LV_TCODESTRATO   GA_USUARIOS.COD_ESTRATO%TYPE;
                LV_TEMAIL        GA_USUARIOS.EMAIL%TYPE;

                LV_CODCIUDAD    GE_DIRECCIONES.COD_CIUDAD%TYPE;
                LV_Direccion    GE_DIRECCIONES.NOM_CALLE%TYPE;
                LV_Observacion GE_DIRECCIONES.OBS_DIRECCION%TYPE;
                LV_TCODCIUDAD    GE_DIRECCIONES.COD_CIUDAD%TYPE;
                LV_TDireccion     GE_DIRECCIONES.NOM_CALLE%TYPE;
                LV_TObservacion GE_DIRECCIONES.OBS_DIRECCION%TYPE;
                LV_TUSUARORA     GA_MODDIRUS.NOM_USUARORA%TYPE;
                LN_COD_REGION_VE GE_DIRECCIONES.COD_PROVINCIA%TYPE;
                --Agregado para manejar excepciones
        LV_codRetorno  ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.desevent;
        --fin
        BEGIN
                SN_cod_retorno  := 0;
                SV_mens_retorno := NULL;
                SN_num_evento   := 0;

                LV_NOMUSUARIO   := EV_nomUsuario;
                LV_NOMAPELLIDO1 := EV_nomApell1;
                LV_NOMAPELLIDO2 := EV_nomApell2;
                LV_CODTIPIDENT  := EV_tipIdentif;
                LV_NUMIDENT     := EV_numIdentif;
--              LV_FECNACIMIEN  := EV_fecNacimiento;
                LV_SEXO         := EV_Sexo;
                LV_CODESTRATO   := EV_codEstrato;
                LV_EMAIL        := EV_Mail;

                LV_CODCIUDAD    := EV_codCiudad;
                LV_Direccion    := EV_Direccion;
                LV_Observacion  := EV_Observacion;
                LV_Usuarora     := EV_usuarora;


        IF (EV_usuarora IS NULL OR EV_numAbonado IS NULL) OR (LENGTH(EV_usuarora)=0 OR LENGTH(EV_numAbonado) = 0) THEN
                   RAISE ERROR_SQL;
                END IF;

                SELECT NUM_ABONADO
                INTO LV_numAbonado
                FROM GA_ABOCEL
                WHERE NUM_ABONADO=EV_numAbonado
                UNION
                SELECT NUM_ABONADO
                FROM GA_ABOAMIST
                WHERE NUM_ABONADO=EV_numAbonado;



                SELECT 'POSTPAGO' TIPOUSUARIO, COD_USUARIO
                  INTO CV_TIPOUSUARIO, CV_CODUSUARIO
                  FROM GA_ABOCEL
                 WHERE NUM_ABONADO=EV_numAbonado
                 UNION
                SELECT 'PREPAGO' TIPOUSUARIO, COD_USUARIO
                  FROM GA_USUAMIST
             WHERE NUM_ABONADO=EV_numAbonado;


                IF EV_fecNacimiento IS NOT NULL OR LENGTH(EV_fecNacimiento) = 0  THEN

                   LV_FECNACIMIEN := TO_DATE(EV_fecNacimiento,'''' || VE_intermediario_PG.CV_FORMATOFECHA || '''');

                END IF;


                --Recuperar datos usuario a reemplazar en caso de venir vacios los parametros
                BEGIN

                         IF CV_TIPOUSUARIO = 'POSTPAGO' THEN

                                SELECT NOM_USUARIO ,NOM_APELLIDO1 ,NOM_APELLIDO2 ,COD_TIPIDENT,
                                       NUM_IDENT ,FEC_NACIMIEN,IND_SEXO ,COD_ESTRATO ,EMAIL
                                  INTO LV_TNOMUSUARIO,
                                           LV_TNOMAPELLIDO1,
                                           LV_TNOMAPELLIDO2,
                                           LV_TCODTIPIDENT,
                                           LV_TNUMIDENT,
                                           LV_TFECNACIMIEN,
                                           LV_TSEXO,
                                           LV_TCODESTRATO,
                                           LV_TEMAIL
                                 FROM GA_USUARIOS
                                 WHERE COD_USUARIO= CV_CODUSUARIO;

                         ELSIF CV_TIPOUSUARIO='PREPAGO' THEN

                                SELECT NOM_USUARIO ,NOM_APELLIDO1 ,NOM_APELLIDO2 ,COD_TIPIDENT,
                                       NUM_IDENT ,FEC_NACIMIEN,IND_SEXO ,COD_ESTRATO ,EMAIL
                                  INTO LV_TNOMUSUARIO,
                                           LV_TNOMAPELLIDO1,
                                           LV_TNOMAPELLIDO2,
                                           LV_TCODTIPIDENT,
                                           LV_TNUMIDENT,
                                           LV_TFECNACIMIEN,
                                           LV_TSEXO,
                                           LV_TCODESTRATO,
                                           LV_TEMAIL
                                  FROM GA_USUAMIST
                                 WHERE COD_USUARIO= CV_CODUSUARIO;

                         END IF;
                        -- reasignacion de valores en caso que corresponda.

                        IF LV_nomUsuario IS NULL   THEN
                                LV_nomUsuario    := LV_TNOMUSUARIO;
                        END IF;

                        IF LV_NOMAPELLIDO1  IS NULL   THEN
                                LV_NOMAPELLIDO1     := LV_TNOMAPELLIDO1;
                        END IF;

                        IF LV_NOMAPELLIDO2  IS NULL   THEN
                                LV_NOMAPELLIDO2     := LV_TNOMAPELLIDO2;
                        END IF;

                        IF LV_CODTIPIDENT IS NULL   THEN
                                LV_CODTIPIDENT    := LV_TCODTIPIDENT;
                        END IF;

                        IF LV_NUMIDENT IS NULL   THEN
                                LV_NUMIDENT    := LV_TNUMIDENT;
                        END IF;

                        IF LV_FECNACIMIEN IS NULL   THEN
                                LV_FECNACIMIEN := LV_TFECNACIMIEN;
                        END IF;

                        IF LV_Sexo       IS NULL   THEN
                                LV_Sexo          := LV_TSEXO;
                        END IF;

                        IF LV_codEstrato IS NULL   THEN
                                LV_codEstrato    := LV_TCODESTRATO;
                        END IF;

                        IF LV_EMail       IS NULL   THEN
                                LV_EMail          := LV_TEMAIL;
                        END IF;

                        IF LV_usuarorA    IS NULL THEN
                           LV_usuarora    :=LV_TUSUARORA;
                        END IF;

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                 --si no encuentra sigue como estaba
                                 LV_Sql:= '';
                END;
                --FIN Recuperar datos usuario a reemplazar en caso de venir vacios los parametros


                IF CV_TIPOUSUARIO = 'POSTPAGO' THEN
                   LV_Sql:='UPDATE GA_USUARIOS SET';
                ELSE
                   LV_Sql:='UPDATE ga_usuamist SET';
                END IF;

                LV_Sql:= LV_Sql || ' nom_usuario = ' || LV_nomUsuario
                       || ' ,nom_apellido1 = ' || LV_NOMAPELLIDO1
                           || ' ,nom_apellido2 = ' || LV_NOMAPELLIDO2
                           || ' ,cod_tipident = ' || LV_CODTIPIDENT
                           || ' ,num_ident = ' || LV_NUMIDENT
                           || ' ,fec_nacimien = ' || LV_FECNACIMIEN
                           || ' ,ind_sexo = ' || LV_Sexo
                           || ' ,cod_estrato = ' || LV_codEstrato
                           || ' ,email = ' || LV_EMail
                           || ' WHERE cod_usuario = ' || CV_CODUSUARIO;

                 IF CV_TIPOUSUARIO = 'POSTPAGO' THEN
                        UPDATE GA_USUARIOS SET
                               nom_usuario = LV_nomUsuario,
                               nom_apellido1 = LV_NOMAPELLIDO1,
                                   nom_apellido2 = LV_NOMAPELLIDO2,
                                   cod_tipident = LV_CODTIPIDENT,
                                   num_ident = LV_NUMIDENT,
                                   fec_nacimien = LV_FECNACIMIEN,
                                   ind_sexo = LV_Sexo,
                                   cod_estrato = LV_codEstrato,
                                   email = LV_EMail
                        WHERE cod_usuario = CV_CODUSUARIO;
                 ELSE
                        UPDATE ga_usuamist SET
                               nom_usuario = LV_nomUsuario,
                               nom_apellido1 = LV_NOMAPELLIDO1,
                                   nom_apellido2 = LV_NOMAPELLIDO2,
                                   cod_tipident = LV_CODTIPIDENT,
                                   num_ident = LV_NUMIDENT,
                                   fec_nacimien = LV_FECNACIMIEN,
                                   ind_sexo = LV_Sexo,
                                   cod_estrato = LV_codEstrato,
                                   email = LV_EMail
                        WHERE cod_usuario = CV_CODUSUARIO;
                 END IF;

                IF (EV_codProvincia IS NOT NULL) OR (LENGTH(EV_codProvincia)=0 ) THEN
                -- vienen datos para la direccion

--INI INC 45700
--              IF CV_TIPOUSUARIO = 'POSTPAGO' THEN
--                 --postpago
--                 EV_TIPDIRECCION:=1;
--              ELSE
--             --prepago
--                 EV_TIPDIRECCION:=2;
--              END IF;

                IF EV_TIPDIRECCION<>'2' AND EV_TIPDIRECCION<>'3' THEN

                   RAISE ERROR_SQL;

                END IF;
--FIN INC 45700


                --Se obtiene la region segun provincia

                IF EV_cod_region IS NULL THEN

                        SELECT COD_REGION
                INTO LN_COD_REGION_VE
                FROM GE_PROVINCIAS
                WHERE COD_PROVINCIA = EV_codProvincia
                AND ROWNUM=1;

                ELSE

                    LN_COD_REGION_VE := EV_cod_region;

                END IF;

                -- Obtenemos secuencia nueva direccion
                        VE_intermediario_PG.VE_obtiene_secuencia_PR(CV_SECUENCIADIRECCION,
                                                                                            LV_secuencia,
                                                                        SN_cod_retorno,
                                                                SV_mens_retorno,
                                                                SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                                RAISE ERROR_SQL;
                        END IF;


                        VE_getDireccionUsuario_PR    (CV_CODUSUARIO,
                                              EV_TIPDIRECCION,
                                                                                  LV_codDirAnterior,
                                                                  SN_cod_retorno,
                                                  SV_mens_retorno,
                                                  SN_num_evento);

                        IF (SN_cod_retorno <> 0) THEN
                                RAISE ERROR_SQL;
                        END IF;

                        --Recuperar datos direccion a reemplazar en caso de venir vacios los parametros
                        IF (LV_codDirAnterior <> '0') THEN
                                BEGIN

                                        SELECT COD_CIUDAD, NOM_CALLE, OBS_DIRECCION
                                          INTO LV_TCODCIUDAD, LV_TDireccion, LV_TObservacion
                                          FROM GE_DIRECCIONES
                                         WHERE COD_DIRECCION = LV_codDirAnterior;

                                        IF LV_codCiudad  IS NULL   THEN
                                                LV_codCiudad   := LV_TCODCIUDAD;
                                        END IF;

                                        IF LV_Direccion  IS NULL   THEN
                                                LV_Direccion   := LV_TDireccion;
                                        END IF;
                                        IF LV_Observacion IS NULL THEN
                                                LV_Observacion := LV_TObservacion;
                                        END IF;

                                EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                                 --si no encuentra sigue como estaba
                                                 LV_Sql:= '';
                                END;
                        END IF;
                        --FIN Recuperar datos direccion a reemplazar en caso de venir vacios los parametros

                        -- Insertamos nueva direccion
                        INSERT INTO ge_direcciones (cod_direccion,
                                                    cod_provincia,
                                                                                cod_ciudad,
                                                                                nom_calle,
                                                                                obs_direccion,
                                                                                cod_region,
                                                                cod_comuna,
                                                                cod_tipocalle )
                                   VALUES (LV_secuencia,
                                               EV_codProvincia,
                                               LV_codCiudad,
                                                   LV_Direccion,
                                                   LV_Observacion,
                                                   LN_COD_REGION_VE,
                                                   EV_cod_comuna,
                                                   EV_tipo_calle   );

                        IF (LV_codDirAnterior = '0') THEN
                        -- insertar direccion del usuario

                                INSERT INTO ga_direcusuar (cod_usuario,
                                                           cod_tipdireccion,
                                                                                   cod_direccion)
                                VALUES (CV_CODUSUARIO,
                                        EV_TIPDIRECCION,
                                                LV_secuencia);

                        ELSE
                        -- actualizar direccion del usuario

                            -- Actualizamos direccion
                                UPDATE ga_direcusuar
                                SET cod_direccion = LV_secuencia
                                WHERE cod_usuario = CV_CODUSUARIO
                                AND cod_tipdireccion = EV_TIPDIRECCION;

                                -- Registramos cambios en la direccion
                                INSERT INTO ga_moddirus (cod_usuario,
                                                         fec_modifica,
                                                                                 cod_tipdireccion,
                                                                                 cod_direcant,
                                                                                 cod_direcnue,
                                                                                 nom_usuarora)
                                VALUES (CV_CODUSUARIO,
                                        SYSDATE ,
                                                EV_TIPDIRECCION,
                                                LV_codDirAnterior,
                                                LV_secuencia,
                                                LV_USUARORA);
                        END IF;
                END IF;

        EXCEPTION
                        WHEN ERROR_SQL THEN
                                 SN_num_evento   := 0;
                         SN_cod_retorno  := 218;
                         SV_mens_retorno := 'No se encuentran datos de usuario';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                             SN_num_evento   := 0;
                         SN_cod_retorno  := 218;
                         SV_mens_retorno := 'No se encuentran datos de usuario';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
        END VE_updUsuario_PR;

    -- Listas y/o Cursores ---------------------------------------------------------------------

        PROCEDURE VE_getListCuotas_PR(SC_cursordatos     OUT NOCOPY REFCURSOR,
                                                          SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListCuotas_PR"
                        Lenguaje="PL/SQL"
                        Fecha="27-07-2007"
                        Version="1.0.0"
                        Disenador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Recupera listado de cuotas
                </Descripcion>
                <Parametros>
                <Entrada> N/A </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor cuotas </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
           CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(19) := 'VE_getListCuotas_PR';

           NO_DATA_FOUND_CURSOR  EXCEPTION;
--         ERROR_SQL             EXCEPTION;

           LV_desError  ge_errores_pg.DesEvent;
           LV_Sql       ge_errores_pg.vQuery;
           LN_contador       NUMBER;
           LV_cuotas_concons VARCHAR2(20);
           LV_modpricta      VARCHAR2(20);

        BEGIN
                SN_num_evento   := 0;
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';


                LV_cuotas_concons := TO_NUMBER(ge_fn_devvalparam(VE_intermediario_PG.CV_MODULO_GA,VE_intermediario_PG.CN_PRODUCTO,'COD_CONCONS'));


                LV_Sql :=  ' SELECT a.cod_cuota, a.des_cuota'
                                || ' FROM ge_tipcuotas a'
                            || ' WHERE a.COD_CUOTA <> ' || LV_CUOTAS_CONCONS;

                -- Controlamos No Data Found en el cursor
                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
            FROM ge_tipcuotas;

                OPEN SC_cursordatos FOR LV_Sql;

               /* IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;*/

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 VE_intermediario_PG.VE_NoDataFoundCursor_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getListCuotas_PR;

        PROCEDURE VE_getListArticulos_PR(EV_CodFabricante IN AL_ARTICULOS.COD_FABRICANTE%TYPE,
                                         EV_CodTecnologia IN AL_TECNOARTICULO_TD.COD_TECNOLOGIA%TYPE,
                                                                         SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                             SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListArticulos_PR"
                        Lenguaje="PL/SQL"
                        Fecha="27-07-2007"
                        Version="1.0.0"
                        Disenador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Recupera listado de articulos
                </Descripcion>
                <Parametros>
                <Entrada> N/A </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor articulos </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
           CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(22) := 'VE_getListArticulos_PR';

           NO_DATA_FOUND_CURSOR  EXCEPTION;
       ERROR_TECNOLOGIA EXCEPTION;
           ERROR_FABRICANTE EXCEPTION;
           LV_desError  ge_errores_pg.DesEvent;
           LV_Sql       ge_errores_pg.vQuery;
           LN_contador  NUMBER;
           --Agregado para manejar excepciones
       LV_codRetorno  ge_errores_pg.coderror;
       LV_mens_retorno ge_errores_pg.desevent;
       --fin
        BEGIN
                SN_num_evento   := 0;
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';


                -- Validar que exista Tecnologia

                LV_Sql:='SELECT COUNT(1)'
                ||' FROM AL_TECNOLOGIA'
                ||' WHERE COD_TECNOLOGIA= '|| EV_CodTecnologia;

                SELECT COUNT(1)
                into LN_contador
                FROM AL_TECNOLOGIA
                WHERE COD_TECNOLOGIA=EV_CodTecnologia;

                IF LN_contador=0 THEN
                   RAISE ERROR_TECNOLOGIA;
                END IF;


                IF EV_CodFabricante IS NOT NULL THEN

                   LV_Sql:='SELECT COUNT(1)'
                   ||' FROM AL_FABRICANTES'
                   ||' WHERE COD_FABRICANTE= '|| EV_CodFabricante;

                   SELECT COUNT(1)
                   into LN_contador
                   FROM AL_FABRICANTES
                   WHERE COD_FABRICANTE=EV_CodFabricante;

                   IF LN_contador=0 THEN
                      RAISE ERROR_FABRICANTE;
                   END IF;

            END IF;

                LV_Sql := 'SELECT a.cod_articulo, ';
                LV_Sql := LV_Sql || ' a.des_articulo,';
                LV_Sql := LV_Sql || ' a.cod_modelo,';
                LV_Sql := LV_Sql || ' a.cod_fabricante,';
                LV_Sql := LV_Sql || ' b.des_fabricante';
                LV_Sql := LV_Sql || ' FROM al_articulos a,';
                LV_Sql := LV_Sql || ' al_fabricantes b, ';
                LV_Sql := LV_Sql || ' al_tecnoarticulo_TD c ';
                LV_Sql := LV_Sql || ' WHERE a.cod_fabricante = b.cod_fabricante';
                LV_Sql := LV_Sql || ' AND A.COD_ARTICULO = C.COD_ARTICULO';
                IF EV_CodFabricante IS NOT NULL THEN
                   LV_Sql := LV_Sql || ' AND A.COD_FABRICANTE= ' || EV_CodFabricante;
                END IF;
                LV_Sql := LV_Sql || ' AND c.COD_TECNOLOGIA= ''' || EV_CodTecnologia || '''';
                LV_Sql := LV_Sql || ' AND A.IND_COMER_WEB = ' || VE_intermediario_PG.CN_INDICADORWEB;
                LV_Sql := LV_Sql || ' AND A.COD_PRODUCTO = 1';




                -- Controlamos No Data Found en el cursor
--              LN_contador := 0;
--              SELECT COUNT(1)
--              INTO LN_contador
--              FROM al_articulos a,
--                   al_fabricantes b,
--                       AL_TECNOARTICULO_TD c
--              WHERE a.cod_fabricante = b.cod_fabricante
--              AND A.COD_ARTICULO = C.COD_ARTICULO
--              AND A.COD_FABRICANTE=EV_CodFabricante
--              AND c.COD_TECNOLOGIA= EV_CodTecnologia
--              AND a.IND_COMER_WEB = VE_intermediario_PG.CN_INDICADORWEB
--              AND A.COD_PRODUCTO = 1;

                OPEN SC_cursordatos FOR LV_Sql;

--              IF (LN_contador = 0) THEN
--                      RAISE NO_DATA_FOUND_CURSOR;
--              END IF;

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 VE_intermediario_PG.VE_NoDataFoundCursor_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        WHEN ERROR_TECNOLOGIA THEN
                             SN_num_evento   := 0;
                         SN_cod_retorno  := 850;
                         SV_mens_retorno := 'Codigo de tecnologia no existe en SCL';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN ERROR_FABRICANTE THEN
                             SN_num_evento   := 0;
                         SN_cod_retorno  := 851;
                         SV_mens_retorno := 'Codigo de fabricante no existe en SCL';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getListArticulos_PR;

------------------------------------------------------------------------------------------------------

PROCEDURE VE_getListServSupl_PR(EV_codPlanTarif   IN VARCHAR2,
EV_indCompatible  IN VARCHAR2,
EV_TECNOLOGIA     IN AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
EV_CodActabo      IN GA_ACTABO.COD_ACTABO%TYPE,
SC_cursordatos    OUT NOCOPY REFCURSOR,
SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*--
<Documentacion TipoDoc = "Procedimiento">
    Elemento Nombre = "VE_getListServSupl_PR"
    Lenguaje="PL/SQL"
    Fecha="14-08-2007"
    Version="1.0.0"
    Disenador="igo"
    Programador="igo"
    Ambiente="BD"
<Retorno>
    Recupera listado de servicios suplementarios
</Retorno>
<Descripcion>
    Recupera listado de servicios suplementarios segun codigo plan tarifario e
    indicador de compatibilidad
    --si el filtro es cero despliega SS opcionales y por Default
	--Si el filtro es uno despliega SS opcionales que no generen incompatibilidad
	--entre ellos y entre los SS por default
</Descripcion>
<Parametros>
<Entrada>
    <param nom="EV_codPlanTarif"  Tipo="STRING"> codigo plan tarifario </param>
    <param nom="EV_indCompatible" Tipo="STRING"> indicador compatibilidad </param>
</Entrada>
<Salida>
    <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor servicios suplementarios </param>
    <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
    <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
    <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
</Salida>
</Parametros>
</Elemento>
</Documentacion>
--*/
	NO_DATA_FOUND_CURSOR  EXCEPTION;
	ERROR_VENDEDOR 		  exception;
	ERROR_156      		  exception;

	CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(21) := 'VE_getListServSupl_PR';

	LV_CodPlanServ         GA_PLANSERV.COD_PLANSERV%TYPE;
	LV_VALOR_AUTENTICACION GED_PARAMETROS.VAL_PARAMETRO%TYPE; --NOM_PARAMETRO = 'IND_AUTENTICACION'
	LV_COD_TIPLAN          TA_PLANTARIF.COD_TIPLAN%TYPE;
	CV_SERV_SUPL           VARCHAR2(1) :='2';
	CV_COD_ACTABO1         VARCHAR2(2) :='VO';  --  SI COD_TIPLAN=2
    CV_COD_ACTABO2         VARCHAR2(2) :='VT';  --  SI COD_TIPLAN=2
	CV_COD_ACTABO3         VARCHAR2(2) :='HH';  --  SI COD_TIPLAN=3
	CV_COD_ACTABO4         VARCHAR2(2) :='AM';  --  SI COD_TIPLAN=3
    LV_COD_SERLLAMINTER    GA_DATOSGENER.COD_SERLLAMINTER%TYPE;
	LV_COD_DETCEL          GA_DATOSGENER.COD_DETCEL%TYPE;
	LV_TIP_PLAN_HIBRIDO    GED_PARAMETROS.VAL_PARAMETRO%TYPE; --nom_parametro='TIP_PLAN_HIBRIDO'
	LV_QUERY               VARCHAR2(4000);
	LV_CADENA              VARCHAR2(4000);
	LV_CONSULTA              VARCHAR2(4000);
	LV_EXISTE              NUMBER(1);
	LV_desError  		   ge_errores_pg.DesEvent;
	LV_Sql       		   ge_errores_pg.vQuery;
	LN_contador  		   NUMBER;
	LV_ANEXO     		   VARCHAR2(2000);
	--Agregado para manejar excepciones
	LV_codRetorno  		   ge_errores_pg.coderror;
	LV_mens_retorno 	   ge_errores_pg.desevent;
	LV_CodUso   		   al_usos.COD_USO%TYPE;
	LV_COD_SERVICIO        GA_SERVSUPL.COD_SERVICIO%TYPE;
	LV_COD_SERVSUPL        GA_SERVSUPL.COD_SERVSUPL%TYPE;
	LV_DES_SERVICIO        GA_SERVSUPL.DES_SERVICIO%TYPE;
	LV_COD_NIVEL           GA_SERVSUPL.COD_NIVEL%TYPE;
	LV_IND_DEFAULT         VARCHAR2(40);
	LV_IMP_TARIFA_CONEXION GA_TARIFAS.IMP_TARIFA%TYPE;
	LV_DES_MONEDA_CONEXION GE_MONEDAS.DES_MONEDA%TYPE;
	LV_IMP_TARIFA_MENSUAL  GA_TARIFAS.IMP_TARIFA%TYPE;
	LV_DES_MONEDA_MENSUAL  GE_MONEDAS.DES_MONEDA%TYPE;
    LV_IND_IP              GA_SERVSUPL.IND_IP%TYPE;
    LV_TIP_COBRO           GA_SERVSUPL.TIP_COBRO%TYPE;
    SC_cursordatos2 	   REFCURSOR;
	--fin
	TC_CURSORDATOSSS1      TC_cursorDatosSS;
	LV_COUNT               NUMBER(9);
	LV_SECUENCIA           NUMBER(20);
	LN_INDICE              BINARY_INTEGER := 0;
	LV_ACTABO              GA_ACTABO.COD_ACTABO%TYPE;
    LV_Actuacion           GA_ACTABO.COD_ACTCEN%TYPE;
    LV_TipRed              TA_PLANTARIF.TIP_RED%TYPE;
BEGIN
    SN_num_evento   := 0;
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';

    LV_Sql := 'EV_indCompatible';
    IF EV_indCompatible<>'0' AND EV_indCompatible <> '1' THEN
       SN_num_evento   := 0;
       SN_cod_retorno  := 1;
       SV_mens_retorno := 'EV_indCompatible es distinto de 0 y 1.';
       RAISE NO_DATA_FOUND_CURSOR;
    END IF;

	LV_Sql:= 'SELECT COUNT(1) FROM TA_PLANTARIF WHERE COD_PLANTARIF= ' || UPPER(EV_codPlanTarif);
	LV_sql:= LV_sql || ' AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)';

    --Validar que Plan Tarifario exista y este vigente

    SELECT COUNT(1)
    INTO LV_EXISTE
    FROM TA_PLANTARIF
    WHERE COD_PLANTARIF= UPPER(EV_codPlanTarif)
    AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

    IF LV_EXISTE = 0 THEN
       SN_num_evento   := 0;
       SN_cod_retorno  := 232;
       SV_mens_retorno := 'Código de plan no definido en SCL o no se encuentra vigente';
       RAISE NO_DATA_FOUND_CURSOR;
    END IF;

    LV_Sql := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = "IND_AUTENTICACION"';

	--Obtener valores PARA VARIABLES
	SELECT VAL_PARAMETRO
	INTO LV_VALOR_AUTENTICACION
	FROM GED_PARAMETROS
	WHERE NOM_PARAMETRO = 'IND_AUTENTICACION';

	LV_Sql := 'SELECT COD_TIPLAN FROM TA_PLANTARIF WHERE COD_PLANTARIF =' || UPPER(EV_codPlanTarif);

	SELECT COD_TIPLAN
	INTO LV_COD_TIPLAN
	FROM TA_PLANTARIF
	WHERE COD_PLANTARIF = UPPER(EV_codPlanTarif);

	SELECT DECODE(LV_COD_TIPLAN,3,10,2,2,3)
	INTO LV_CodUso
	FROM DUAL;

	LV_Sql := 'SELECT COD_SERLLAMINTER, COD_DETCEL FROM GA_DATOSGENER';

	SELECT COD_SERLLAMINTER, COD_DETCEL
	INTO LV_COD_SERLLAMINTER, LV_COD_DETCEL
	FROM GA_DATOSGENER;


	LV_Sql := 'SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE NOM_PARAMETRO = "TIP_PLAN_HIBRIDO"';

    BEGIN
       SELECT VAL_PARAMETRO
       INTO LV_TIP_PLAN_HIBRIDO
       FROM GED_PARAMETROS
       WHERE NOM_PARAMETRO = 'TIP_PLAN_HIBRIDO';

       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             SN_num_evento   := 0;
             SN_cod_retorno  := 764;
             SV_mens_retorno := 'Tipo Plan Hibrido no esta parametrizado.';
       RAISE NO_DATA_FOUND_CURSOR;
           WHEN OTHERS THEN
       RAISE ERROR_156;
    END;

    IF LV_COD_TIPLAN = 2 THEN  --<TIP_PLAN_HIBRIDO><COD_ACTABO=?VT?>
       LV_ACTABO:=CV_COD_ACTABO2;
    END IF;

    IF LV_COD_TIPLAN = 3 THEN  --<TIP_PLAN_HIBRIDO><COD_ACTABO=?HH?>
       LV_ACTABO:=CV_COD_ACTABO3;
    END IF;

    IF LV_COD_TIPLAN = 1 THEN  --<TIP_PLAN_HIBRIDO><COD_ACTABO=?HH?>
       LV_ACTABO:=CV_COD_ACTABO4;
    END IF;

    SELECT COD_ACTCEN
    INTO LV_Actuacion
    FROM GA_ACTABO
    WHERE COD_ACTABO=EV_CodActabo
    AND COD_TECNOLOGIA=EV_TECNOLOGIA;



    LV_Sql := 'SELECT PLANSERVICIO.COD_PLANSERV ';
    LV_Sql :=  LV_Sql || ' INTO LV_CodPlanServ ';
    LV_Sql :=  LV_Sql || ' FROM   GA_PLANSERV PLANSERVICIO ';
    LV_Sql :=  LV_Sql || ' WHERE  SYSDATE BETWEEN PLANSERVICIO.FEC_DESDE AND NVL(PLANSERVICIO.FEC_HASTA, SYSDATE) ';
    LV_Sql :=  LV_Sql || ' AND    PLANSERVICIO.COD_PRODUCTO = 1 ';
    LV_Sql :=  LV_Sql || ' AND    PLANSERVICIO.COD_PLANSERV IN ( ';
    LV_Sql :=  LV_Sql || '        SELECT RELACION.COD_PLANSERV ';
    LV_Sql :=  LV_Sql || '        FROM  GA_PLANTECPLSERV RELACION ';
    LV_Sql :=  LV_Sql || '        WHERE RELACION.COD_TECNOLOGIA = "'|| EV_TECNOLOGIA || '" ';
    LV_Sql :=  LV_Sql || '        AND   RELACION.COD_PLANTARIF = "' || EV_codPlanTarif || '") ';
    LV_Sql :=  LV_Sql || '        AND ROWNUM <= 1 ';

    BEGIN
        SELECT PLANSERVICIO.COD_PLANSERV
        INTO LV_CodPlanServ
        FROM   GA_PLANSERV PLANSERVICIO
        WHERE  SYSDATE BETWEEN PLANSERVICIO.FEC_DESDE AND NVL(PLANSERVICIO.FEC_HASTA, SYSDATE)
        AND    PLANSERVICIO.COD_PRODUCTO = 1
        AND    PLANSERVICIO.COD_PLANSERV IN (SELECT RELACION.COD_PLANSERV FROM  GA_PLANTECPLSERV RELACION
        WHERE RELACION.COD_TECNOLOGIA = EV_TECNOLOGIA AND   RELACION.COD_PLANTARIF = EV_codPlanTarif)
        AND ROWNUM <= 1;

        EXCEPTION
             WHEN NO_DATA_FOUND THEN
	              SN_num_evento   := 0;
	              SN_cod_retorno  := 283;
	              SV_mens_retorno := 'Plan de Servicio no esta vigente o parametrizado.';
	              RAISE NO_DATA_FOUND_CURSOR;
            WHEN OTHERS THEN
	              RAISE ERROR_156;
   END;

       SELECT TIP_RED
       INTO LV_TipRed
       FROM TA_PLANTARIF
       WHERE COD_PLANTARIF=EV_codPlanTarif;



--    IF EV_CodActabo<>CV_COD_ACTABO4 THEN


       LV_Sql := 'SELECT COUNT(1) FROM GA_SERVSUPL A,GA_SERVUSO I ,GAD_SERVSUP_PLAN X';

	   LV_CADENA := 'SELECT A.COD_SERVICIO, A.COD_SERVSUPL, A.DES_SERVICIO, A.COD_NIVEL,'|| ''''|| 'NO DEFAULT'||'''';
	   LV_CADENA := LV_CADENA || ',G.IMP_TARIFA AS CARGO_CONEXION ,M.DES_MONEDA AS MONEDA_CONEXION, FA.IMP_TARIFA AS TARIFA_MENSUAL, M.DES_MONEDA AS MONEDA_MENSUAL,A.IND_IP,A.TIP_COBRO,A.TIP_RED';

	   LV_QUERY := 'SELECT COUNT(1)';

	   LV_CONSULTA := ' FROM GA_SERVSUPL A,GA_SERVUSO I ,GAD_SERVSUP_PLAN X,GA_TARIFAS G,GA_TARIFAS FA, GE_MONEDAS M ';
	   LV_CONSULTA := LV_CONSULTA || ' WHERE A.COD_PRODUCTO = 1 ';

       IF LV_COD_TIPLAN = '3' THEN  --<Tip_Plan_Hibrido>
          LV_CONSULTA := LV_CONSULTA || ' AND A.COD_SERVICIO <> ' || ''''|| LV_COD_SERLLAMINTER ||'''';
          LV_CONSULTA := LV_CONSULTA || ' AND A.COD_SERVICIO <> ' || ''''|| LV_COD_DETCEL ||'''';
       END IF;
       LV_CONSULTA := LV_CONSULTA || ' AND A.IND_COMERC=1';                     /*SERVICIO COMERCIAL*/
       LV_CONSULTA := LV_CONSULTA || ' AND A.TIP_SERVICIO IN ('|| ''''|| '1'||''''||', '|| ''''|| '2'||''''||') ';  /*1=SERVICIO NORMAL 2=Serv Especial*/
       LV_CONSULTA := LV_CONSULTA || ' AND X.COD_PLANTARIF = ' || ''''|| UPPER(EV_codPlanTarif) ||'''';
       LV_CONSULTA := LV_CONSULTA || ' AND X.TIP_RELACION IN ('|| ''''|| '1'||''''||', '|| ''''|| '2'||''''||') ';   /*1=SERVICIO E-MOCION,2=SERVICIO DE VOZ*/

       IF LV_VALOR_AUTENTICACION <>' ' THEN
          LV_CONSULTA := LV_CONSULTA || ' AND A.COD_SERVICIO <> ' || ''''|| LV_VALOR_AUTENTICACION ||'''';
       END IF;

	   LV_CONSULTA := LV_CONSULTA || ' AND A.COD_NIVEL <> 0';
	   LV_CONSULTA := LV_CONSULTA || ' AND I.COD_USO = ' || ''''|| LV_CodUso ||'''';
	   IF EV_CodActabo=CV_COD_ACTABO3 OR EV_CodActabo = CV_COD_ACTABO1 THEN
          LV_CONSULTA := LV_CONSULTA || ' AND ((A.COD_APLIC IS NULL) OR (A.COD_APLIC LIKE '|| ''''|| '%C%'||''''||'))';
	   ELSE
          LV_CONSULTA := LV_CONSULTA || ' AND ((A.COD_APLIC IS NULL) OR (A.COD_APLIC LIKE '|| ''''|| '%P%'||''''||'))';
       END IF;
       LV_CONSULTA := LV_CONSULTA || ' AND A.COD_SERVICIO=G.COD_SERVICIO';
	   LV_CONSULTA := LV_CONSULTA || ' AND A.COD_PRODUCTO=G.COD_PRODUCTO';

	   LV_CONSULTA := LV_CONSULTA || ' AND G.COD_ACTABO = ' || ''''|| EV_CodActabo ||'''';
	   LV_CONSULTA := LV_CONSULTA || ' AND G.COD_PLANSERV= '|| ''''|| LV_CodPlanServ ||'''';
	   LV_CONSULTA := LV_CONSULTA || ' AND SYSDATE BETWEEN G.FEC_DESDE AND G.FEC_HASTA ';

	   LV_CONSULTA := LV_CONSULTA || ' AND A.COD_SERVICIO= FA.COD_SERVICIO(+) ';
	   LV_CONSULTA := LV_CONSULTA || ' AND A.COD_PRODUCTO= FA.COD_PRODUCTO(+) ';
	   LV_CONSULTA := LV_CONSULTA || ' AND FA.COD_ACTABO(+) =' || '''' || 'FA' || '''';
	   LV_CONSULTA := LV_CONSULTA || ' AND FA.COD_PLANSERV(+) = '|| ''''|| LV_CodPlanServ ||'''';
	   LV_CONSULTA := LV_CONSULTA || ' AND SYSDATE BETWEEN FA.FEC_DESDE(+) AND FA.FEC_HASTA(+) ' ;

	   LV_CONSULTA := LV_CONSULTA || ' AND M.COD_MONEDA=G.COD_MONEDA' ;

	   LV_CONSULTA := LV_CONSULTA || ' AND A.COD_PRODUCTO = X.COD_PRODUCTO';
	   LV_CONSULTA := LV_CONSULTA || ' AND A.COD_SERVICIO = X.COD_SERVICIO';
	   LV_CONSULTA := LV_CONSULTA || ' AND I.COD_PRODUCTO = A.COD_PRODUCTO';
	   LV_CONSULTA := LV_CONSULTA || ' AND I.COD_SERVICIO = A.COD_SERVICIO';
	   LV_CONSULTA := LV_CONSULTA || ' AND SYSDATE BETWEEN X.FEC_DESDE AND NVL(X.FEC_HASTA,SYSDATE)';
	   LV_CONSULTA := LV_CONSULTA || ' AND NVL(A.COD_SERVICIO,'|| ''''|| ' '||''''||' ) NOT IN';
	   LV_CONSULTA := LV_CONSULTA || ' (SELECT NVL(COD_SERVICIO,'||  ''''|| ' '||''''  ||') FROM GA_TIPOSEGURO WHERE COD_PRODUCTO = A.COD_PRODUCTO)';
	   LV_CONSULTA := LV_CONSULTA || ' AND NVL(A.COD_SERVICIO,'||''''|| ' '||'''' ||') NOT IN ';
	   LV_CONSULTA := LV_CONSULTA || ' (SELECT NVL(COD_SERVICIODES,'|| ''''|| ' '||''''||') FROM GA_TIPOSEGURO WHERE COD_PRODUCTO = A.COD_PRODUCTO)';

--	   EXECUTE IMMEDIATE LV_QUERY || LV_CONSULTA INTO LN_contador;

--	   IF LN_contador = 0 THEN

--		  LV_QUERY := 'SELECT A.COD_SERVICIO, A.COD_SERVSUPL, A.DES_SERVICIO, A.COD_NIVEL,'|| ''''|| 'NO DEFAULT'||'''';
--		  LV_QUERY := LV_QUERY || ',G.IMP_TARIFA AS CARGO_CONEXION ,M.DES_MONEDA AS MONEDA_CONEXION, FA.IMP_TARIFA AS TARIFA_MENSUAL, M.DES_MONEDA AS MONEDA_MENSUAL, A.IND_IP,A.TIP_COBRO,A.TIP_RED';
--		  LV_QUERY := LV_QUERY || ' FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_SERVUSO I, GA_TARIFAS G,GA_TARIFAS FA, GE_MONEDAS M ';
--  --      LV_QUERY := LV_QUERY || ' ,GA_ACTUASERV T';
--		  LV_QUERY := LV_QUERY || ' WHERE A.COD_PRODUCTO = 1';

--		  If LV_COD_TIPLAN = 3 Then  --<Tip_Plan_Hibrido>
--		     LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO <> ' || ''''|| LV_COD_SERLLAMINTER ||'''';
--		     LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO <> ' || ''''|| LV_COD_DETCEL ||'''';
--		  END IF;
--
--		     LV_QUERY := LV_QUERY || ' AND A.TIP_RED = ' || ''''|| LV_TipRed ||'''';
--          LV_QUERY := LV_QUERY || ' AND A.TIP_SERVICIO = '|| ''''|| '1' || '''';

--		  IF LV_VALOR_AUTENTICACION <> ' ' THEN
--		     LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO <> ' || ''''|| LV_VALOR_AUTENTICACION ||'''';
--		  END IF;
--          LV_QUERY := LV_QUERY || ' AND A.IND_COMERC=1';                     /*SERVICIO COMERCIAL*/
--		  LV_QUERY := LV_QUERY || ' AND A.COD_NIVEL <> 0';
--		  LV_QUERY := LV_QUERY || ' AND ((A.COD_APLIC IS NULL) OR (A.COD_APLIC LIKE '|| ''''|| '%C%'||''''||'))';
--		  LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO=G.COD_SERVICIO';
--		  LV_QUERY := LV_QUERY || ' AND A.COD_PRODUCTO=G.COD_PRODUCTO';

--          LV_QUERY := LV_QUERY || ' AND FA.COD_PRODUCTO(+) = A.COD_PRODUCTO';
--          LV_QUERY := LV_QUERY || ' AND FA.COD_SERVICIO(+) = A.COD_SERVICIO';
--		  LV_QUERY := LV_QUERY || ' AND FA.COD_ACTABO(+) =' || '''' || 'FA' || '''';
--		  LV_QUERY := LV_QUERY || ' AND FA.COD_PLANSERV(+) = '|| ''''|| LV_CodPlanServ ||'''';
--		  LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN FA.FEC_DESDE(+) AND FA.FEC_HASTA(+) ' ;

--          --LV_QUERY := LV_QUERY || ' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)';
--          --LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO = B.COD_SERVICIO(+)';
--          LV_QUERY := LV_QUERY || ' AND B.COD_ACTABO(+) = ' || ''''|| EV_CodActabo ||'''';
--          LV_QUERY := LV_QUERY || ' AND B.COD_TIPSERV(+) = ' || ''''|| CV_SERV_SUPL ||'''';

--		  LV_QUERY := LV_QUERY || ' AND G.COD_ACTABO = ' || ''''|| EV_CodActabo ||'''';
--		  LV_QUERY := LV_QUERY || ' AND G.COD_PLANSERV = '|| ''''|| LV_CodPlanServ ||'''';
--		  LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN G.FEC_DESDE AND G.FEC_HASTA ';
--          LV_QUERY := LV_QUERY || ' AND G.COD_PRODUCTO = B.COD_PRODUCTO';
--          LV_QUERY := LV_QUERY || ' AND G.COD_TIPSERV = B.COD_TIPSERV';
--          LV_QUERY := LV_QUERY || ' AND G.COD_SERVICIO = B.COD_SERVICIO(+)';

--		  LV_QUERY := LV_QUERY || ' AND M.COD_MONEDA = G.COD_MONEDA' ;

--		  LV_QUERY := LV_QUERY || ' AND I.COD_PRODUCTO = A.COD_PRODUCTO';
--		  LV_QUERY := LV_QUERY || ' AND I.COD_SERVICIO = A.COD_SERVICIO';
--		  LV_QUERY := LV_QUERY || ' AND I.COD_USO = ' || LV_CodUso;
--		  LV_QUERY := LV_QUERY || ' AND NVL(A.COD_SERVICIO, '|| ''''|| ' '||''''||') NOT IN';
--		  LV_QUERY := LV_QUERY || ' (SELECT NVL(COD_SERVICIO, '|| ''''|| ' '||''''||') FROM GA_TIPOSEGURO WHERE COD_PRODUCTO = A.COD_PRODUCTO)';
--		  LV_QUERY := LV_QUERY || ' AND NVL(A.COD_SERVICIO, '|| ''''|| ' '||''''||') NOT IN' ;
--		  LV_QUERY := LV_QUERY || ' (SELECT NVL(COD_SERVICIODES, '|| ''''|| ' '||''''||') FROM GA_TIPOSEGURO WHERE COD_PRODUCTO = A.COD_PRODUCTO)';
--	  ELSE
		  LV_QUERY := LV_CADENA || LV_CONSULTA;
--	  END IF;

	     --SS QUE NO SON POR DEFAULT  EV_indCompatible='0' --
	      LV_QUERY := LV_QUERY || ' AND (A.COD_SERVICIO NOT IN';
	      LV_QUERY := LV_QUERY || ' (SELECT Z1.COD_SERVICIO';
	      LV_QUERY := LV_QUERY || ' FROM ( SELECT A.COD_SERVICIO, A.COD_SERVSUPL, A.COD_NIVEL';
	      LV_QUERY := LV_QUERY || ' FROM GA_SERVSUPL A, GAD_SERVSUP_PLAN X';
	      LV_QUERY := LV_QUERY || ' WHERE A.COD_PRODUCTO = 1';
	      LV_QUERY := LV_QUERY || ' AND A.TIP_SERVICIO IN ('|| ''''|| '1'||''''||', '|| ''''|| '2'||''''||')';  /*1=SERVICIO NORMAL 2=Serv Especial*/
	      LV_QUERY := LV_QUERY || ' AND X.COD_PLANTARIF = ' || ''''|| UPPER(EV_codPlanTarif) ||'''';
	      LV_QUERY := LV_QUERY || ' AND X.TIP_RELACION IN ('|| ''''|| '3'||''''||', '|| ''''|| '4'||''''||')';        /*3=SERV DE VOZ POR DEF. 4=SERV E-MOCION POR DEF*/
	      LV_QUERY := LV_QUERY || ' AND A.IND_COMERC=1';                     /*SERVICIO COMERCIAL*/
	      LV_QUERY := LV_QUERY || ' AND A.COD_PRODUCTO = X.COD_PRODUCTO';
	      LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO = X.COD_SERVICIO';
	      LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN X.FEC_DESDE AND NVL(X.FEC_HASTA,SYSDATE)) Z1';
	      LV_QUERY := LV_QUERY || ' WHERE  Z1.COD_SERVICIO = A.COD_SERVICIO';
	      LV_QUERY := LV_QUERY || ' AND Z1.COD_SERVSUPL = A.COD_SERVSUPL';
	      LV_QUERY := LV_QUERY || ' AND Z1.COD_NIVEL = A.COD_NIVEL))';


	      LV_QUERY := LV_QUERY || ' UNION';
	      --SS POR DEFAULT AL PLAN TARIFARIO--
	      LV_QUERY := LV_QUERY || ' SELECT A.COD_SERVICIO, A.COD_SERVSUPL, A.DES_SERVICIO, A.COD_NIVEL,'|| ''''|| 'DEFAULT'||'''';
	      LV_QUERY := LV_QUERY || ',G.IMP_TARIFA AS CARGO_CONEXION ,M.DES_MONEDA AS MONEDA_CONEXION, NVL(FA.IMP_TARIFA,0) AS TARIFA_MENSUAL, M.DES_MONEDA AS MONEDA_MENSUAL,A.IND_IP,A.TIP_COBRO,A.TIP_RED';
	      LV_QUERY := LV_QUERY || ' FROM GA_SERVSUPL A,GAD_SERVSUP_PLAN X, GA_TARIFAS G,GA_TARIFAS FA, GE_MONEDAS M';
	      LV_QUERY := LV_QUERY || ' WHERE';
	      LV_QUERY := LV_QUERY || ' A.COD_PRODUCTO = 1';
	      LV_QUERY := LV_QUERY || ' AND A.TIP_SERVICIO IN ('|| ''''|| '1'||''''||', '|| ''''|| '2'||''''||')';                  /*NORMAL Y ESPECIAL*/
	      LV_QUERY := LV_QUERY || ' AND X.COD_PLANTARIF = ' || ''''|| UPPER(EV_codPlanTarif) ||'''';
	      LV_QUERY := LV_QUERY || ' AND X.TIP_RELACION IN ('|| ''''|| '3'||''''||', '|| ''''|| '4'||''''||')';                   /*3=SERVICIO DE VOZ POR DEFECTO 4=SERVICIO E-MOCION POR DEFECTO*/
	      LV_QUERY := LV_QUERY || ' AND A.IND_COMERC = 1';                              /*SERVICIO COMERCIAL*/
	      LV_QUERY := LV_QUERY || ' AND A.COD_PRODUCTO = X.COD_PRODUCTO';
	      LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO = X.COD_SERVICIO';
	      LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN X.FEC_DESDE AND NVL(X.FEC_HASTA,SYSDATE)';
	      LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO=G.COD_SERVICIO';
	      LV_QUERY := LV_QUERY || ' AND A.COD_PRODUCTO=G.COD_PRODUCTO';

          LV_QUERY := LV_QUERY || ' AND G.COD_ACTABO = ' || ''''|| EV_CodActabo ||'''';
	      LV_QUERY := LV_QUERY || ' AND G.COD_PLANSERV= '|| ''''|| LV_CodPlanServ ||'''';
	      LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN G.FEC_DESDE AND G.FEC_HASTA ';

	      LV_QUERY := LV_QUERY || ' AND M.COD_MONEDA(+)=G.COD_MONEDA' ;

	      LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO=FA.COD_SERVICIO(+) ';
	      LV_QUERY := LV_QUERY || ' AND A.COD_PRODUCTO=FA.COD_PRODUCTO(+) ';

	      LV_QUERY := LV_QUERY || ' AND FA.COD_ACTABO(+)=' || '''' || 'FA' || '''';
	      LV_QUERY := LV_QUERY || ' AND FA.COD_PLANSERV(+)= '|| ''''|| LV_CodPlanServ ||'''';
	      LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN FA.FEC_DESDE(+) AND FA.FEC_HASTA(+) ' ;

	      LN_contador:=0; --Indice Estrucura
	      LV_COUNT:=0; --Contador Servicios Suplementarios
--    ELSE
--
--          LV_QUERY := LV_QUERY || ' SELECT A.COD_SERVICIO, A.COD_SERVSUPL, A.DES_SERVICIO, A.COD_NIVEL,''NO DEFAULT'',C.IMP_TARIFA AS CARGO_CONEXION ,D.DES_MONEDA AS MONEDA_CONEXION, F.IMP_TARIFA AS TARIFA_MENSUAL,G.DES_MONEDA AS MONEDA_MENSUAL,A.IND_IP,A.TIP_COBRO,A.TIP_RED';
--          LV_QUERY := LV_QUERY || ' FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_TARIFAS C, GE_MONEDAS D, GA_ACTUASERV E, GA_TARIFAS F, GE_MONEDAS G, ICG_SERVICIOTERCEN H, GA_SERVUSO I';
--          LV_QUERY := LV_QUERY || ' WHERE A.COD_PRODUCTO = 1';
--          LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO <> ' || ''''|| LV_COD_SERLLAMINTER ||'''';
--          LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO <> ' || ''''|| LV_COD_DETCEL ||'''';
--          LV_QUERY := LV_QUERY || ' AND A.COD_NIVEL <> 0';
--          LV_QUERY := LV_QUERY || ' AND A.IND_COMERC = 1';
--          LV_QUERY := LV_QUERY || ' AND (A.COD_APLIC LIKE '|| ''''|| '%C%'||''''||')';
--          LV_QUERY := LV_QUERY || ' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)';
--          LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO = B.COD_SERVICIO(+)';
--          LV_QUERY := LV_QUERY || ' AND B.COD_ACTABO(+) = ' || ''''|| EV_CodActabo ||'''';
--          LV_QUERY := LV_QUERY || ' AND B.COD_TIPSERV(+) = 2 AND B.COD_PRODUCTO = C.COD_PRODUCTO(+)';
--          LV_QUERY := LV_QUERY || ' AND B.COD_ACTABO = C.COD_ACTABO(+) AND B.COD_TIPSERV = C.COD_TIPSERV(+)';
--          LV_QUERY := LV_QUERY || ' AND B.COD_SERVICIO = C.COD_SERVICIO(+)';
--          LV_QUERY := LV_QUERY || ' AND C.COD_PLANSERV(+) = '|| ''''|| LV_CodPlanServ ||'''';
--          LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE)';
--          LV_QUERY := LV_QUERY || ' AND C.COD_MONEDA = D.COD_MONEDA(+) AND A.COD_PRODUCTO = E.COD_PRODUCTO(+)';
--          LV_QUERY := LV_QUERY || ' AND A.COD_SERVICIO = E.COD_SERVICIO(+)';
--          LV_QUERY := LV_QUERY || ' AND E.COD_ACTABO(+) =' || '''' || 'FA' || '''';
--          LV_QUERY := LV_QUERY || ' AND E.COD_TIPSERV(+) = 2 AND E.COD_PRODUCTO = F.COD_PRODUCTO(+)';
--          LV_QUERY := LV_QUERY || ' AND E.COD_ACTABO = F.COD_ACTABO(+) AND E.COD_TIPSERV = F.COD_TIPSERV(+)';
--          LV_QUERY := LV_QUERY || ' AND E.COD_SERVICIO = F.COD_SERVICIO(+)';
--          LV_QUERY := LV_QUERY || ' AND F.COD_PLANSERV(+) = '|| ''''|| LV_CodPlanServ ||'''';
--          LV_QUERY := LV_QUERY || ' AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE)';
--          LV_QUERY := LV_QUERY || ' AND F.COD_MONEDA = G.COD_MONEDA(+) AND H.COD_PRODUCTO = A.COD_PRODUCTO';
--
--          IF EV_TECNOLOGIA='GSM' THEN
--             LV_QUERY := LV_QUERY || ' AND H.TIP_TERMINAL =' || '''' || 'G' || '''';
--          ELSIF EV_TECNOLOGIA='FIJO' THEN
--             LV_QUERY := LV_QUERY || ' AND H.TIP_TERMINAL =' || '''' || 'F' || '''';
--          ELSE
--             LV_QUERY := LV_QUERY || ' AND H.TIP_TERMINAL =' || '''' || 'D' || '''';
--          END IF;
--
--          LV_QUERY := LV_QUERY || ' AND H.COD_SISTEMA =1';
--          LV_QUERY := LV_QUERY || ' AND H.COD_SERVICIO = A.COD_SERVSUPL';
--          LV_QUERY := LV_QUERY || ' AND I.COD_PRODUCTO = A.COD_PRODUCTO  AND I.COD_SERVICIO = A.COD_SERVICIO';
--          LV_QUERY := LV_QUERY || ' AND I.COD_USO = ' || ''''|| LV_CodUso ||'''';
--          LV_QUERY := LV_QUERY || ' ORDER BY A.DES_SERVICIO';
--    END IF;





    --Llama a PL SS por Actuacion

	OPEN SC_cursordatos FOR LV_QUERY;
		 IF EV_indCompatible ='1' THEN
            LOOP
               FETCH SC_cursordatos INTO
                        LV_COD_SERVICIO,LV_COD_SERVSUPL,LV_DES_SERVICIO,LV_COD_NIVEL,
                        LV_IND_DEFAULT,LV_IMP_TARIFA_CONEXION,LV_DES_MONEDA_CONEXION,
                        LV_IMP_TARIFA_MENSUAL,LV_DES_MONEDA_MENSUAL,LV_IND_IP,LV_TIP_COBRO,LV_TipRed;
               EXIT WHEN SC_cursordatos%NOTFOUND;

				--si el filtro es cero despliega SS opcionales y por Default
				--Si el filtro es uno despliega SS opcionales que no generen incompatibilidad
				--entre ellos y entre los SS por default
				IF LV_IND_DEFAULT ='NO DEFAULT' THEN

					SELECT COUNT(1)
					INTO LV_COUNT
					FROM GA_SERVSUP_DEF
					WHERE COD_SERVICIO=LV_COD_SERVICIO
					AND TIP_RELACION=3
					AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

					IF LV_COUNT= 0 THEN
						SELECT COUNT(1)
						INTO LV_COUNT
						FROM GAD_SERVSUP_PLAN
						WHERE COD_SERVICIO=LV_COD_SERVICIO
						AND TIP_RELACION=3
						AND COD_PLANTARIF= EV_codPlanTarif
						AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
					END IF;

					IF LV_COUNT=0 THEN
						TC_cursorDatosSS1(LN_contador).T_COD_SERVICIO:=LV_COD_SERVICIO;
						LN_contador:=LN_contador + 1;
						iCantRegistros:=iCantRegistros+1;
						LV_ANEXO := LV_ANEXO || ''''|| LV_COD_SERVICIO ||''',';
					END IF;
                END IF;
		    END LOOP;
			CLOSE SC_cursordatos;
		 ELSE

                        SELECT VE_SEQ_SSTEMP.NEXTVAL
                        INTO LV_SECUENCIA
                        FROM DUAL;
                        iCantRegistros := 0;
                        VE_obtiene_SS_Tercen_PR(EV_CodActabo,LV_CodPlanServ,EV_TECNOLOGIA,TC_CURSORDATOSSS1,SN_cod_retorno,SV_mens_retorno,SN_num_evento);


                        --Grabo en Tabla temporal todos los SS Opcionales y por defecto
                        LOOP
                       FETCH SC_cursordatos INTO
                                 LV_COD_SERVICIO,LV_COD_SERVSUPL,LV_DES_SERVICIO,LV_COD_NIVEL,
                                         LV_IND_DEFAULT,LV_IMP_TARIFA_CONEXION,LV_DES_MONEDA_CONEXION,
                                         LV_IMP_TARIFA_MENSUAL,LV_DES_MONEDA_MENSUAL,LV_IND_IP,LV_TIP_COBRO,LV_TipRed;
                       EXIT WHEN SC_cursordatos%NOTFOUND;
                                INSERT INTO VE_SERVSUPL_TEMP_TT
                                        (SECUENCIA,COD_SERVICIO,COD_SERVSUPL,DES_SERVICIO,COD_NIVEL,DES_TIPSS,CARGO_CONEXION,
                                        MONEDA_CONEXION,TARIFA_MENSUAL,MONEDA_MENSUAL,IND_IP,TIP_COBRO,TIP_RED)
                                        VALUES
                                        (LV_SECUENCIA,LV_COD_SERVICIO,LV_COD_SERVSUPL,LV_DES_SERVICIO,LV_COD_NIVEL,
                                        LV_IND_DEFAULT,LV_IMP_TARIFA_CONEXION,LV_DES_MONEDA_CONEXION,
                                        LV_IMP_TARIFA_MENSUAL,LV_DES_MONEDA_MENSUAL,LV_IND_IP,LV_TIP_COBRO,LV_TipRed);
                        END LOOP;
                        CLOSE SC_cursordatos;
                        -- Abrir cursor "TERCEN" SC_cursordatos2

                        WHILE LN_INDICE < iCantRegistros LOOP

                                 SELECT COUNT(1)
                                 INTO LV_COUNT
                                 FROM VE_SERVSUPL_TEMP_TT
                                 WHERE SECUENCIA=LV_SECUENCIA
                                 AND DES_TIPSS='DEFAULT'
                                 AND COD_SERVSUPL=TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVSUPL;

                                 IF LV_COUNT>0 THEN
                                    DELETE FROM  VE_SERVSUPL_TEMP_TT
                                    WHERE SECUENCIA=LV_SECUENCIA
                                    AND DES_TIPSS='DEFAULT'
                                    AND COD_SERVSUPL=TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVSUPL;

                                 END IF;

                                 SELECT COUNT(1)
                                 INTO LV_COUNT
                                 FROM VE_SERVSUPL_TEMP_TT
                                 WHERE SECUENCIA=LV_SECUENCIA
                                 AND DES_TIPSS='NO DEFAULT'
                                 AND COD_SERVSUPL=TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVSUPL
                                 AND COD_SERVICIO=TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVICIO
                                 AND COD_NIVEL=TC_CURSORDATOSSS1(LN_INDICE).T_COD_NIVEL;

                                 IF LV_COUNT>0 THEN
                                    DELETE FROM  VE_SERVSUPL_TEMP_TT
                                    WHERE SECUENCIA=LV_SECUENCIA
                                    AND DES_TIPSS='NO DEFAULT'
                                    AND COD_SERVSUPL=TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVSUPL
                                        AND COD_SERVICIO=TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVICIO
                                        AND COD_NIVEL=TC_CURSORDATOSSS1(LN_INDICE).T_COD_NIVEL;
                                 END IF;


                                   INSERT INTO VE_SERVSUPL_TEMP_TT
                                        (SECUENCIA,COD_SERVICIO,COD_SERVSUPL,DES_SERVICIO,COD_NIVEL,DES_TIPSS,CARGO_CONEXION,
                                        MONEDA_CONEXION,TARIFA_MENSUAL,MONEDA_MENSUAL,IND_IP,TIP_COBRO,TIP_RED)
                                        VALUES
                                        (LV_SECUENCIA,TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVICIO,TC_CURSORDATOSSS1(LN_INDICE).T_COD_SERVSUPL,
                                        TC_CURSORDATOSSS1(LN_INDICE).T_DES_SERVICIO,TC_CURSORDATOSSS1(LN_INDICE).T_COD_NIVEL,
                                        TC_CURSORDATOSSS1(LN_INDICE).T_IND_DEFAULT,TC_CURSORDATOSSS1(LN_INDICE).T_IMP_TARIFA_CONEXION,TC_CURSORDATOSSS1(LN_INDICE).T_DES_MONEDA_CONEXION,
                                        TC_CURSORDATOSSS1(LN_INDICE).T_IMP_TARIFA_MENSUAL,TC_CURSORDATOSSS1(LN_INDICE).T_DES_MONEDA_MENSUAL,TC_CURSORDATOSSS1(LN_INDICE).T_IND_IP,TC_CURSORDATOSSS1(LN_INDICE).T_TIP_COBRO,TC_CURSORDATOSSS1(LN_INDICE).T_TIP_RED);
                          LN_INDICE:=LN_INDICE+1;
                          END LOOP;

                        LV_QUERY:='';
                        LV_QUERY:='SELECT COD_SERVICIO,COD_SERVSUPL,DES_SERVICIO,COD_NIVEL,DES_TIPSS,CARGO_CONEXION,';
                        LV_QUERY:= LV_QUERY || ' MONEDA_CONEXION,TARIFA_MENSUAL,MONEDA_MENSUAL,IND_IP,TIP_COBRO,TIP_RED';
                        LV_QUERY:= LV_QUERY || ' FROM VE_SERVSUPL_TEMP_TT';
                        LV_QUERY:= LV_QUERY || ' WHERE SECUENCIA=' || LV_SECUENCIA;
          END IF;

          IF EV_IndCompatible=1 and LV_anexo is not NULL then
             LV_QUERY := LV_QUERY || 'AND A.COD_SERVICIO IN ( ';
             LV_QUERY := LV_QUERY || LV_ANEXO;
                 LV_QUERY := LV_QUERY || '''''';
                 LV_QUERY:=  LV_QUERY || ')';
          END IF;
                 LV_QUERY := LV_QUERY || ' ORDER BY DES_SERVICIO ASC';

          OPEN SC_cursordatos FOR LV_QUERY;

          IF EV_indCompatible=0 THEN
             DELETE FROM VE_SERVSUPL_TEMP_TT
                 WHERE SECUENCIA=LV_SECUENCIA;
          END IF;

EXCEPTION
	WHEN ERROR_156 THEN
		 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
	WHEN NO_DATA_FOUND_CURSOR THEN
		 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
	WHEN OTHERS THEN
		 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_QUERY,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
END VE_getListServSupl_PR;

------------------------------------------------------------------------------------------------------

        PROCEDURE
        VE_getListVentas_PR(EV_codVendedor  IN  VARCHAR2,
                                      EV_codVendealer IN  VARCHAR2,
                                      EV_codCanal     IN  VARCHAR2,
                                      EV_fecDesde     IN  VARCHAR2,
                                      EV_fecHasta     IN  VARCHAR2,
                                      EN_filtro       IN  NUMBER,
                                  SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                          SV_codVendedor  OUT VARCHAR2,
                                                                  SV_nomVendedor  OUT VARCHAR2,
                                                                  SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListVentas_PR"
                        Lenguaje="PL/SQL"
                        Fecha="27-07-2007"
                        Version="1.0.0"
                        Disenador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  listado de ventas
                </Retorno>
                <Descripcion>
                        Recupera listado de ventas segun filtro
                        0 : todas las ventas realizadas en un periodo de tiempo
                        1 : todas las ventas no legalizadas (sin recepción de documento y no pagadas)
                            realizadas por un vendedor
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EV_codVendedor"  Tipo="STRING"> codigo vendedor </param>
                        <param nom="EV_codVendealer" Tipo="STRING"> codigo vendedor dealer </param>
                        <param nom="EV_codCanal"     Tipo="STRING"> codigo canal </param>
                        <param nom="EV_fecDesde"     Tipo="STRING"> fecha desde </param>
                        <param nom="EV_fecHasta"     Tipo="STRING"> fecha hasta </param>
                        <param nom="EV_filtro"       Tipo="STRING"> filtro </param>
                </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor ventas </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
           CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(19) := 'VE_getListVentas_PR';
       --SC_acursordatos       TC_cursordatos,

           NO_DATA_FOUND_CURSOR EXCEPTION;
           ERROR_PROCEDIMIENTO  EXCEPTION;
       SC_acursordatos      TC_cursordatos;
           LN_INDICE                    BINARY_INTEGER := 0;
           LV_QUERY             VARCHAR2(500);
           LN_SECUENCIA         VE_TMPVENTAS_SALIDA_TT.SECUENCIA%TYPE;

           LV_desError          ge_errores_pg.DesEvent;
           LV_Sql               ge_errores_pg.vQuery;
           LN_contador          NUMBER;
           LV_existeVendedor    NUMBER(1);


           --Agregado para manejar excepciones
                LV_codRetorno  ge_errores_pg.coderror;
                ERROR_VENDEDOR exception;
                LV_mens_retorno ge_errores_pg.desevent;
                --fin

                BEGIN
                SN_num_evento   := 0;
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';

                LN_contador := 0;
                SV_codVendedor:=EV_codVendedor;
                SV_nomVendedor:='';

                --Validar que el Filtro sea 0 o 1
                IF EN_filtro <> 0 AND EN_filtro <> 1 THEN
                   SN_num_evento   := 0;
                   SN_cod_retorno  := 424;
                   SV_mens_retorno := 'El Filtro debe ser 0 o 1';
                   RAISE NO_DATA_FOUND_CURSOR;
                END IF;

                LV_sql:='SELECT COUNT(1) FROM VE_VENDEDORES WHERE COD_VENDEDOR=' || EV_codVendedor;
                LV_sql:= LV_sql  || ' AND SYSDATE BETWEEN FEC_CONTRATO AND  NVL(FEC_FINCONTRATO, SYSDATE)';

                --Se debe Validar Existencia de Vendedor
                SELECT COUNT(1)
                INTO LV_existeVendedor
                FROM VE_VENDEDORES
                WHERE COD_VENDEDOR= EV_codVendedor
                AND SYSDATE BETWEEN FEC_CONTRATO
                AND  NVL(FEC_FINCONTRATO, SYSDATE);

                IF LV_existeVendedor = 0 THEN
                   SN_num_evento   := 0;
                   SN_cod_retorno  := 405;
                   SV_mens_retorno := 'Vendedor no existe o no esta vigente';
                   RAISE ERROR_PROCEDIMIENTO;
                ELSE
                   --Se valida que Canal sea Directo (D) o indirecto (I)
                   IF UPPER(EV_codCanal) <> 'D' AND UPPER(EV_codCanal) <> 'I' THEN
                      SN_num_evento   := 0;
                      SN_cod_retorno  := 1;
                      SV_mens_retorno := 'El Canal debe ser Directo (D) o indirecto (I) ';
                      RAISE NO_DATA_FOUND_CURSOR;
                   END IF;

                   IF UPPER(EV_codCanal) ='I' THEN
                      LV_sql:='SELECT COUNT(1) FROM VE_VENDEALER WHERE COD_VENDEALER=' || EV_codVendealer;
                      LV_sql:= LV_sql  || ' AND SYSDATE BETWEEN FEC_CONTRATO AND  NVL(FEC_FINCONTRATO, SYSDATE)';

                          --Se debe Validar Existencia de Vendedor dealer
                          SELECT COUNT(1)
                          INTO LV_existeVendedor
                          FROM VE_VENDEALER
                          WHERE COD_VENDEALER= EV_codVendealer
                          AND SYSDATE BETWEEN FEC_CONTRATO
                          AND  NVL(FEC_FINCONTRATO, SYSDATE);

                          IF LV_existeVendedor = 0 THEN
                         SN_num_evento   := 0;
                         SN_cod_retorno  := 406;
                         SV_mens_retorno := 'Vendedor Dealer no existe o no está vigente';
                         RAISE NO_DATA_FOUND_CURSOR;
                          END IF;

                          --Se debe Validar Existencia de Vendedor dealer y vendedor en caso que canal sea indirecto
                          SELECT COUNT(1)
                          INTO LV_existeVendedor
                          FROM VE_VENDEALER
                          WHERE COD_VENDEALER= EV_codVendealer
                          AND COD_VENDEDOR=EV_codVendedor
                          AND SYSDATE BETWEEN FEC_CONTRATO
                          AND  NVL(FEC_FINCONTRATO, SYSDATE);


                          IF LV_existeVendedor = 0 THEN
                         SN_num_evento   := 0;
                         SN_cod_retorno  := 407;
                         SV_mens_retorno := 'Vendedor Dealer no corresponde al vendedor';
                         RAISE NO_DATA_FOUND_CURSOR;
                          END IF;
                   END IF;
                END IF;

                iCantRegistros := 0;  --Cantidad de datos en record a generar --

                SELECT NOM_VENDEDOR
                INTO SV_nomVendedor
                FROM VE_VENDEDORES
                WHERE COD_VENDEDOR=EV_codVendedor;

                IF (EN_filtro = 0) THEN
                -- todas las ventas realizadas en un periodo de tiempo

                    VE_GETVENTAS_PR(EV_codVendedor,
                                        EV_codVendealer,
                                        UPPER(EV_codCanal),
                                        EV_fecDesde,
                                        EV_fecHasta,
                                        SC_acursordatos,
                                        SN_cod_retorno,
                                        SV_mens_retorno,
                                        SN_num_evento);

                ELSIF (EN_filtro = 1) THEN
                -- todas las ventas no legalizadas (sin recepción de documento y no pagadas)
                -- realizadas por un vendedor

                    VE_GETVENTASNOLEGAL_PR(EV_codVendedor,
                                               EV_codVendealer,
                                                                   UPPER(EV_codCanal),
                                                                   SC_acursordatos,
                                                                   SN_cod_retorno,
                                                                   SV_mens_retorno,
                                                                   SN_num_evento);

                ELSE
                        SV_mens_retorno := 'Filtro inválido';
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

                IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_PROCEDIMIENTO;
                END IF;

                --Llenado de tabla temporal segun record SC_acursordatos --
                --Borrar tabla temporal



                WHILE LN_INDICE < iCantRegistros LOOP

                SELECT VE_VENTAS_SQ.NEXTVAL INTO LN_SECUENCIA FROM DUAL ;
                        SC_acursordatos(LN_INDICE).T_SECUENCIA:=LN_SECUENCIA;
                        INSERT INTO VE_TMPVENTAS_SALIDA_TT
                                (SECUENCIA,
                                TIPO,
                                TIPO_PRODUCTO,
                                COD_VENDEDOR,
                                NOM_VENDEDOR,
                                NUM_VENTA,
                                COD_CUENTA,
                                NUM_ABONADO,
                                NUM_CELULAR,
                                COD_TIPIDENT,
                                NUM_IDENT,
                                NOM_CLIENTE,
                                NOM_APECLIEN1,
                                NOM_APECLIEN2,
                                FEC_VENTA,
                                FEC_ALTA,
                                COD_PLANTARIF,
                                DES_PLANTARIF,
                                TOT_FACTURA,
                                NUM_FOLIO,
                                IND_IMPRESA,
                                NOM_USUARIO,
                                COD_CLIENTE,
                                IND_ESTVENTA,
                                COD_SITUACION,
                                COD_CICLO
                                )
                        VALUES
                                (
                                 LN_SECUENCIA
                                ,SC_acursordatos(LN_INDICE).T_TIPO
                                ,SC_acursordatos(LN_INDICE).TIPO_PRODUCTO
                                ,SC_acursordatos(LN_INDICE).T_COD_VENDEDOR
                                ,SC_acursordatos(LN_INDICE).T_NOM_VENDEDOR
                                ,SC_acursordatos(LN_INDICE).T_NUM_VENTA
                                ,SC_acursordatos(LN_INDICE).T_COD_CUENTA
                                ,SC_acursordatos(LN_INDICE).T_NUM_ABONADO
                                ,SC_acursordatos(LN_INDICE).T_NUM_CELULAR
                                ,SC_acursordatos(LN_INDICE).T_COD_TIPIDENT
                                ,SC_acursordatos(LN_INDICE).T_NUM_IDENT
                                ,SC_acursordatos(LN_INDICE).T_NOM_CLIENTE
                                ,SC_acursordatos(LN_INDICE).T_NOM_APECLIEN1
                                ,SC_acursordatos(LN_INDICE).T_NOM_APECLIEN2
                                ,SC_acursordatos(LN_INDICE).T_FEC_VENTA
                                ,SC_acursordatos(LN_INDICE).T_FEC_ALTA
                                ,SC_acursordatos(LN_INDICE).T_COD_PLANTARIF
                                ,SC_acursordatos(LN_INDICE).T_DES_PLANTARIF
                                ,SC_acursordatos(LN_INDICE).T_TOT_FACTURA
                                ,SC_acursordatos(LN_INDICE).T_NUM_FOLIO
                                ,SC_acursordatos(LN_INDICE).T_IND_IMPRESA
                                ,SC_acursordatos(LN_INDICE).T_NOM_USUARORA
                                ,SC_acursordatos(LN_INDICE).T_COD_CLIENTE
                                ,SC_acursordatos(LN_INDICE).T_IND_ESTVENTA
                                ,SC_acursordatos(LN_INDICE).T_COD_SITUACION
                                ,SC_acursordatos(LN_INDICE).T_COD_CICLO
                                );

                        LN_INDICE := LN_INDICE + 1;
                END LOOP;
                --
                LV_QUERY := 'SELECT ';
                LV_QUERY := LV_QUERY || 'NUM_VENTA, ';
                LV_QUERY := LV_QUERY || 'TIPO, ';
                LV_QUERY := LV_QUERY || 'TIPO_PRODUCTO, ';
                LV_QUERY := LV_QUERY || 'COD_VENDEDOR, ';
                LV_QUERY := LV_QUERY || 'NOM_VENDEDOR, ';
                LV_QUERY := LV_QUERY || 'COD_CUENTA, ';
                LV_QUERY := LV_QUERY || 'NUM_ABONADO, ';
                LV_QUERY := LV_QUERY || 'NUM_CELULAR, ';
                LV_QUERY := LV_QUERY || 'COD_TIPIDENT, ';
                LV_QUERY := LV_QUERY || 'NUM_IDENT, ';
                LV_QUERY := LV_QUERY || 'NOM_CLIENTE, ';
                LV_QUERY := LV_QUERY || 'NOM_APECLIEN1, ';
                LV_QUERY := LV_QUERY || 'NOM_APECLIEN2, ';
                LV_QUERY := LV_QUERY || 'FEC_VENTA, ';
                LV_QUERY := LV_QUERY || 'FEC_ALTA, ';
                LV_QUERY := LV_QUERY || 'COD_PLANTARIF, ';
                LV_QUERY := LV_QUERY || 'DES_PLANTARIF, ';
                LV_QUERY := LV_QUERY || 'TOT_FACTURA, ';
                LV_QUERY := LV_QUERY || 'NUM_FOLIO, ';
                LV_QUERY := LV_QUERY || 'IND_IMPRESA, ';
                LV_QUERY := LV_QUERY || 'COD_CLIENTE,';
                LV_QUERY := LV_QUERY || 'NOM_USUARIO, ';
                LV_QUERY := LV_QUERY || 'IND_ESTVENTA, ';
                LV_QUERY := LV_QUERY || 'COD_SITUACION, ';
                LV_QUERY := LV_QUERY || 'COD_CICLO ';
                LV_QUERY := LV_QUERY || 'FROM VE_TMPVENTAS_SALIDA_TT';

                OPEN SC_cursordatos FOR LV_QUERY;

                --Borrar tabla de paso --
                LN_INDICE:=0;
                WHILE LN_INDICE < iCantRegistros LOOP
             DELETE FROM VE_TMPVENTAS_SALIDA_TT WHERE SECUENCIA =SC_acursordatos(LN_INDICE).T_SECUENCIA ;
                        LN_INDICE := LN_INDICE + 1;
                END LOOP;

        EXCEPTION
                        WHEN ERROR_PROCEDIMIENTO THEN
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN NO_DATA_FOUND_CURSOR THEN
                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getListVentas_PR;


PROCEDURE VE_getVentasNoLegal_PR(EV_codVendedor  IN VARCHAR2,
                                     EV_codVendealer IN VARCHAR2,
                                         EV_codCanal     IN VARCHAR2,
                                         SC_cursordatos  OUT NOCOPY TC_cursordatos,
                                                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getVentasNoLegal_PR"
                        Lenguaje="PL/SQL"
                        Fecha="16-08-2007"
                        Version="1.0.0"
                        Disenador="igo"
                        Programador="igo"
                        Ambiente="BD"
                <Retorno>
                                  listado de ventas
                </Retorno>
                <Descripcion>
                        Recupera listado de ventas segun filtro
                        0 : todas las ventas realizadas en un periodo de tiempo
                        1 : todas las ventas no legalizadas (sin recepción de documento y no pagadas)
                            realizadas por un vendedor
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor ventas </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
--   TYPE refcursor IS REF CURSOR;
           CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(22) := 'VE_getVentasNoLegal_PR';

           NO_DATA_FOUND_CURSOR  EXCEPTION;

           LV_desError  ge_errores_pg.DesEvent;
           LV_Sql       ge_errores_pg.vQuery;
           LV_QUERY     VARCHAR2(3000);

           LN_CANT_MAX_VTANOLEGAL NUMBER;
           LN_DIAS_LEGALES_VEND   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
           LN_TN_DIAS_VENCIMIENTO GED_PARAMETROS.VAL_PARAMETRO%TYPE;
           LN_NUMVENTA            GA_VENTAS.NUM_VENTA%TYPE;
           LN_CANTVTANOLEGAL      NUMBER;
           LN_DEBEHABER           NUMBER;
           LC_CURSORDATOS         REFCURSOR;
           LN_CONTADOR            BINARY_INTEGER := 0;
       LV_TIPO_PRODUCTO VARCHAR2(10);
           LV_TIPO          VARCHAR2(9);
           LN_COD_VENDEDOR  NUMBER(6);
           LV_NOM_VENDEDOR  VARCHAR2(40);
           LN_NUM_VENTA     NUMBER(8);
           LN_COD_CUENTA    NUMBER(8);
           LN_NUM_ABONADO   NUMBER(8);
           LN_NUM_CELULAR   NUMBER(15);
           LV_COD_TIPIDENT  VARCHAR2(2);
           LV_NUM_IDENT     VARCHAR2(20);
           LV_NOM_CLIENTE   VARCHAR2(50);
           LV_NOM_APECLIEN1 VARCHAR2(20);
           LV_NOM_APECLIEN2 VARCHAR2(20);
           LD_FEC_VENTA     DATE;
           LD_FEC_ALTA      DATE;
           LV_COD_PLANTARIF VARCHAR2(3);
           LV_DES_PLANTARIF VARCHAR2(30);
           LN_TOLV_FACTURA  NUMBER(14,4);
           LN_NUM_FOLIO     NUMBER(9);
           LV_IND_IMPRESA   VARCHAR2(10);
       LV_COD_CLIENTE   GE_CLIENTES.COD_CLIENTE%TYPE;
       LV_NOM_USUARORA  GE_SEG_USUARIO.NOM_USUARIO%TYPE;
           LV_IND_ESTVENTA  GA_VENTAS.IND_ESTVENTA%TYPE;
           LV_COD_SITUACION GA_ABOCEL.COD_SITUACION%TYPE;
           LV_COD_CICLO     GA_ABOCEL.COD_CICLO%TYPE;
           DAT_cursordatos  REFCURSOR;

        BEGIN
                SN_num_evento   := 0;
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';


                IF UPPER(EV_CodCANAL) <> 'D' AND UPPER(EV_codCANAL) <> 'I' THEN
                   --CANAL DEBE SER D O I
                   RAISE NO_DATA_FOUND_CURSOR;
                END IF;

                LN_CANT_MAX_VTANOLEGAL := TO_NUMBER(GE_FN_DEVVALPARAM(VE_intermediario_PG.CV_MODULO_GA,VE_intermediario_PG.CN_PRODUCTO,'CANT_VENT_NO_LEG'));

                BEGIN
                        SELECT NUM_DIALEG
                          INTO LN_DIAS_LEGALES_VEND
                          FROM VE_CUPOBLOQUEO_TO
                         WHERE COD_VENDEDOR = EV_CODVENDEDOR;
                EXCEPTION
                        WHEN OTHERS THEN
                     LN_DIAS_LEGALES_VEND := TO_NUMBER(ge_fn_devvalparam(VE_intermediario_PG.CV_MODULO_GA,VE_intermediario_PG.CN_PRODUCTO,'DIAS_LEGALIZACION'));
                END;

                BEGIN
                        SELECT NUM_DIAPAG
                          INTO LN_TN_DIAS_VENCIMIENTO
                          FROM VE_CUPOBLOQUEO_TO
                         WHERE COD_VENDEDOR = EV_CODVENDEDOR;
                EXCEPTION
                        WHEN OTHERS THEN
                         LN_TN_DIAS_VENCIMIENTO := TO_NUMBER(ge_fn_devvalparam(VE_intermediario_PG.CV_MODULO_GA,VE_intermediario_PG.CN_PRODUCTO,'DIAS_VENC_FACT'));
                END;


                LV_QUERY := 'select a.num_venta ';
                LV_QUERY := LV_QUERY || ' from ga_ventas a';
                LV_QUERY := LV_QUERY || ' WHERE A.COD_VENDEDOR= '  || EV_codVendedor;

                IF EV_codVendealer is not null then
                   LV_QUERY := LV_QUERY || ' AND A.COD_VENDEALER= ' || EV_codVendealer;
                end if;
                LV_QUERY := LV_QUERY || ' and a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                LV_QUERY := LV_QUERY || ' AND A.FEC_RECDOCUM IS NULL'; --está pendiente la recepcion de doc--


--              LV_QUERY := 'select count(a.num_venta) cantvtanolegal, NVL(SUM(b.importe_debe - b.importe_haber),0) TN_debehaber,';
--              LV_QUERY := LV_QUERY || ' a.num_venta, a.cod_vendedor, a.cod_cliente';
--              LV_QUERY := LV_QUERY || ' from ga_ventas a, co_cartera b';
--              LV_QUERY := LV_QUERY || ' where a.cod_vendedor= ' || EV_codVendedor;
--              LV_QUERY := LV_QUERY || ' AND a.num_venta=b.num_venta';
--              LV_QUERY := LV_QUERY || ' AND a.cod_cliente=b.cod_cliente';
--              LV_QUERY := LV_QUERY || ' and a.ind_venta='|| ''''|| 'V'||'''' ;
--              LV_QUERY := LV_QUERY || ' and a.fec_recdocum is null'; --está pendiente la recepcion de doc--
--              LV_QUERY := LV_QUERY || ' and a.fec_venta + ' || LN_DIAS_LEGALES_VEND || ' < sysdate'; /*Dias_legales_Vend*/
--              LV_QUERY := LV_QUERY || ' and a.cod_cliente=b.cod_cliente';
--              LV_QUERY := LV_QUERY || ' and a.num_venta=b.num_venta';
--              LV_QUERY := LV_QUERY || ' and b.IND_FACTURADO=1';
--              LV_QUERY := LV_QUERY || ' and b.fec_vencimie  < SYSDATE - ' || LN_TN_DIAS_VENCIMIENTO;    --TN_dias_vencimiento
--              LV_QUERY := LV_QUERY || ' and b.cod_tipdocum NOT IN  (SELECT TO_NUMBER(cod.cod_valor) FROM co_codigos cod WHERE';
--              LV_QUERY := LV_QUERY || ' cod.nom_tabla='|| ''''|| 'CO_CARTERA'||''''|| ' AND cod.nom_columna = '|| ''''|| 'COD_TIPDOCUM'||''''|| ')';
--              LV_QUERY := LV_QUERY || ' group by a.num_venta,a.cod_vendedor, a.cod_cliente';

--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1,255));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,256,255));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,502,255));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,753,255));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1004,255));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1259,255));




                OPEN LC_CURSORDATOS FOR LV_QUERY;

        LV_QUERY:=NULL;
                LOOP

            FETCH LC_CURSORDATOS
                        INTO LN_NUMVENTA;

                        EXIT WHEN LC_CURSORDATOS%NOTFOUND;

                                IF UPPER(EV_codcanal)='D' then

                                        LV_QUERY := 'SELECT DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''DIRECTO'',A.COD_VENDEDOR,B.NOM_VENDEDOR,A.NUM_VENTA,C.COD_CUENTA, E.NUM_ABONADO';
                                        LV_QUERY := LV_QUERY || ' ,E.NUM_CELULAR,C.COD_TIPIDENT, C.NUM_IDENT,C.NOM_CLIENTE, C.NOM_APECLIEN1,';
                                        LV_QUERY := LV_QUERY || ' C.NOM_APECLIEN2, A.FEC_VENTA, E.FEC_ALTA, E.COD_PLANTARIF, F.DES_PLANTARIF';
                                        LV_QUERY := LV_QUERY || ' , NVL(D.TOT_FACTURA,0), D.NUM_FOLIO,decode(g.cod_estadoc+g.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',403,''IMPRESA'',501,''IMPRESA'',502,''IMPRESA'',503,''IMPRESA'',601,''IMPRESA'',602,''IMPRESA'',603,''IMPRESA'',701,''IMPRESA'',702,''IMPRESA'',703,''IMPRESA'',801,''IMPRESA'',802,''IMPRESA'',803,''IMPRESA'',903,''ANULADA'',''PENDIENTE''),C.COD_CLIENTE,E.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                                        LV_QUERY := LV_QUERY || ' FROM GA_VENTAS A, VE_VENDEDORES B, GE_CLIENTES C , FA_FACTDOCU_NOCICLO D, ';
                                        LV_QUERY := LV_QUERY || ' GA_ABOAMIST E, TA_PLANTARIF F, fa_interfact g';
                                        LV_QUERY:= LV_QUERY  ||'  WHERE (    (c.cod_cliente = e.cod_cliente)';
                                        LV_QUERY:= LV_QUERY || '  AND (b.cod_vendedor = a.cod_vendedor)';
                                        LV_QUERY:= LV_QUERY || '  AND (e.cod_plantarif = f.cod_plantarif)';
                                        LV_QUERY:= LV_QUERY || '  AND (a.cod_cliente = c.cod_cliente)';
                                        LV_QUERY:= LV_QUERY || '  AND (a.num_venta = d.num_venta(+))';
                                        LV_QUERY:= LV_QUERY || '  AND (a.cod_cliente = d.cod_cliente(+)))';
                                        LV_QUERY:= LV_QUERY  || '  AND (a.num_venta = e.num_venta(+))'; -- Inc. 63162 Rodrigo Araneda 17-03-2008
                                        LV_QUERY := LV_QUERY || ' AND A.NUM_VENTA= ' || LN_NUMVENTA;
                                        LV_QUERY := LV_QUERY || ' and a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                                        LV_QUERY := LV_QUERY || ' and g.num_proceso(+) = d.num_proceso';
                                        LV_QUERY := LV_QUERY || '  UNION';
                                        LV_QUERY := LV_QUERY || '  SELECT DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''DIRECTO'',A.COD_VENDEDOR,B.NOM_VENDEDOR,A.NUM_VENTA,C.COD_CUENTA, E.NUM_ABONADO';
                                        LV_QUERY := LV_QUERY || '  ,E.NUM_CELULAR,C.COD_TIPIDENT, C.NUM_IDENT,C.NOM_CLIENTE, C.NOM_APECLIEN1,';
                                        LV_QUERY := LV_QUERY || '  C.NOM_APECLIEN2, A.FEC_VENTA, E.FEC_ALTA, E.COD_PLANTARIF, F.DES_PLANTARIF';
                                        LV_QUERY := LV_QUERY || '  , NVL(D.TOT_FACTURA,0), D.NUM_FOLIO,decode(g.cod_estadoc+g.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',403,''IMPRESA'',501,''IMPRESA'',502,''IMPRESA'',503,''IMPRESA'',601,''IMPRESA'',602,''IMPRESA'',603,''IMPRESA'',701,''IMPRESA'',702,''IMPRESA'',703,''IMPRESA'',801,''IMPRESA'',802,''IMPRESA'',803,''IMPRESA'',903,''ANULADA'',''PENDIENTE''),C.COD_CLIENTE,E.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                                        LV_QUERY := LV_QUERY || '  FROM GA_VENTAS A, VE_VENDEDORES B, GE_CLIENTES C , FA_FACTDOCU_NOCICLO D ,';
                                        LV_QUERY := LV_QUERY || '  GA_ABOCEL E, TA_PLANTARIF F, fa_interfact g';
                                        LV_QUERY:= LV_QUERY  ||'   WHERE (    (c.cod_cliente = e.cod_cliente)';
                                        LV_QUERY:= LV_QUERY  || '  AND (b.cod_vendedor = a.cod_vendedor)';
                                        LV_QUERY:= LV_QUERY  || '  AND (e.cod_plantarif = f.cod_plantarif)';
                                        LV_QUERY:= LV_QUERY  || '  AND (a.cod_cliente = c.cod_cliente)';
                                        LV_QUERY:= LV_QUERY  || '  AND (a.num_venta = d.num_venta(+))';
                                        LV_QUERY:= LV_QUERY  || '  AND (a.num_venta = e.num_venta(+))'; -- Inc. 63162 Rodrigo Araneda 17-03-2008
                                        LV_QUERY:= LV_QUERY  || '  AND (a.cod_cliente = d.cod_cliente(+)))';
                                        LV_QUERY := LV_QUERY || '  AND A.NUM_VENTA= ' || LN_NUMVENTA;
                                        LV_QUERY := LV_QUERY || ' and a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                                        LV_QUERY := LV_QUERY || ' and g.num_proceso(+) = d.num_proceso';



                                ELSIF UPPER(EV_codcanal)='I' then

                                        -- INC  :  63995 -Se modifica consulta, cod_vendedor_agente por cod_vendedor en tabla GA_VENTAS
                                        --               -Elimina  VE_VENDEALER G en los FROM pues no se utiliza
                                        -- Fecha:  02/04/2008
                                        -- Prog :  JMC
                                        ------------------------------------------------------------------------------------------------
                                        -- INC  :  64060 -Se modifica consulta, se agrega condicion b.cod_vendealer = a.cod_vendealer
                                        -- Fecha:  08/04/2008
                                        -- Prog :  JMC
                                        LV_QUERY := ' SELECT DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''INDIRECTO'',B.COD_VENDEALER,B.NOM_VENDEALER,A.NUM_VENTA,C.COD_CUENTA, E.NUM_ABONADO';
                                        LV_QUERY := LV_QUERY || ' ,E.NUM_CELULAR,C.COD_TIPIDENT, C.NUM_IDENT ,C.NOM_CLIENTE, C.NOM_APECLIEN1,';
                                        LV_QUERY := LV_QUERY || ' C.NOM_APECLIEN2, A.FEC_VENTA, E.FEC_ALTA, E.COD_PLANTARIF, F.DES_PLANTARIF';
                                        LV_QUERY := LV_QUERY || ' , NVL(D.TOT_FACTURA,0), D.NUM_FOLIO,decode(g.cod_estadoc+g.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',403,''IMPRESA'',501,''IMPRESA'',502,''IMPRESA'',503,''IMPRESA'',601,''IMPRESA'',602,''IMPRESA'',603,''IMPRESA'',701,''IMPRESA'',702,''IMPRESA'',703,''IMPRESA'',801,''IMPRESA'',802,''IMPRESA'',803,''IMPRESA'',903,''ANULADA'',''PENDIENTE'')';
                                        LV_QUERY := LV_QUERY || ' ,C.COD_CLIENTE,E.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                                        LV_QUERY := LV_QUERY || ' FROM GA_VENTAS A, VE_VENDEALER B, GE_CLIENTES C , FA_FACTDOCU_NOCICLO D , GA_ABOAMIST E,';
                                        --LV_QUERY := LV_QUERY || ' TA_PLANTARIF F, VE_VENDEALER G'; -- INC  :  63995
                                        LV_QUERY := LV_QUERY || ' TA_PLANTARIF F, fa_interfact g ';
                                        LV_QUERY:= LV_QUERY  ||'  WHERE (    (c.cod_cliente = e.cod_cliente)';
                                        --LV_QUERY:= LV_QUERY || '  AND (b.cod_vendedor = a.cod_vendedor_agente)'; -- INC  :  63995
                                        LV_QUERY:= LV_QUERY || '  AND (b.cod_vendedor = a.cod_vendedor)';          -- INC  :  63995
                                        LV_QUERY:= LV_QUERY || '  AND (b.cod_vendealer = a.cod_vendealer)';        -- INC  :  64060
                                        LV_QUERY:= LV_QUERY || '  AND (e.cod_plantarif = f.cod_plantarif)';
                                        LV_QUERY:= LV_QUERY || '  AND (a.cod_cliente = c.cod_cliente)';
                                        LV_QUERY:= LV_QUERY || '  AND (a.num_venta = d.num_venta(+))';
                                        LV_QUERY:= LV_QUERY || '  AND (a.cod_cliente = d.cod_cliente(+)))';
                                        LV_QUERY := LV_QUERY || ' AND A.NUM_VENTA= ' || LN_NUMVENTA;
                                        LV_QUERY := LV_QUERY || ' and a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                                        LV_QUERY:= LV_QUERY  || '  AND (a.num_venta = e.num_venta(+))'; -- Inc. 63162 Rodrigo Araneda 17-03-2008
                                        LV_QUERY := LV_QUERY || ' and g.num_proceso(+) = d.num_proceso';
                                        LV_QUERY := LV_QUERY || ' UNION';
                                        LV_QUERY := LV_QUERY || ' SELECT DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''INDIRECTO'',A.COD_VENDEALER,B.NOM_VENDEALER,A.NUM_VENTA,C.COD_CUENTA, E.NUM_ABONADO';
                                        LV_QUERY := LV_QUERY || ' ,E.NUM_CELULAR,C.COD_TIPIDENT, C.NUM_IDENT ,C.NOM_CLIENTE, C.NOM_APECLIEN1,';
                                        LV_QUERY := LV_QUERY || ' C.NOM_APECLIEN2, A.FEC_VENTA, E.FEC_ALTA, E.COD_PLANTARIF, F.DES_PLANTARIF';
                                        LV_QUERY := LV_QUERY || ' , NVL(D.TOT_FACTURA,0), D.NUM_FOLIO,decode(g.cod_estadoc+g.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',403,''IMPRESA'',501,''IMPRESA'',502,''IMPRESA'',503,''IMPRESA'',601,''IMPRESA'',602,''IMPRESA'',603,''IMPRESA'',701,''IMPRESA'',702,''IMPRESA'',703,''IMPRESA'',801,''IMPRESA'',802,''IMPRESA'',803,''IMPRESA'',903,''ANULADA'',''PENDIENTE'')';
                                        LV_QUERY := LV_QUERY || ' , C.COD_CLIENTE,E.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                                        LV_QUERY := LV_QUERY || ' FROM GA_VENTAS A, VE_VENDEALER B, GE_CLIENTES C , FA_FACTDOCU_NOCICLO D , GA_ABOCEL E,';
                                        --LV_QUERY := LV_QUERY || ' TA_PLANTARIF F, VE_VENDEALER G'; -- INC  :  63995
                                        LV_QUERY := LV_QUERY || ' TA_PLANTARIF F, fa_interfact g ';
                                        LV_QUERY:= LV_QUERY  ||'  WHERE ((c.cod_cliente = e.cod_cliente)';
                                        --LV_QUERY:= LV_QUERY || '  AND (b.cod_vendedor = a.cod_vendedor_agente)'; -- INC  :  63995
                                        LV_QUERY:= LV_QUERY || '  AND (b.cod_vendedor = a.cod_vendedor)';          -- INC  :  63995
                                        LV_QUERY:= LV_QUERY || '  AND (b.cod_vendealer = a.cod_vendealer)';        -- INC  :  64060
                                        LV_QUERY:= LV_QUERY || '  AND (e.cod_plantarif = f.cod_plantarif)';
                                        LV_QUERY:= LV_QUERY || '  AND (a.cod_cliente = c.cod_cliente)';
                                        LV_QUERY:= LV_QUERY || '  AND (a.num_venta = d.num_venta(+))';
                                        LV_QUERY:= LV_QUERY || '  AND (a.cod_cliente = d.cod_cliente(+)))';
                                        LV_QUERY := LV_QUERY || ' AND A.NUM_VENTA= ' || LN_NUMVENTA;
                                        LV_QUERY := LV_QUERY || ' and a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                                        LV_QUERY:= LV_QUERY  || '  AND (a.num_venta = e.num_venta(+))'; -- Inc. 63162 Rodrigo Araneda 17-03-2008
                                        LV_QUERY := LV_QUERY || ' and g.num_proceso(+) = d.num_proceso';
                           END IF;


--   DBMS_OUTPUT.Put_Line('EV_codCanal ' || EV_codCanal );
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1,255));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,256,501));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,502,752));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,753,1003));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1004,1258));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1259,1524));
--   DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1525,3000));


                        OPEN DAT_cursordatos FOR LV_QUERY;

                        LOOP

                          FETCH DAT_cursordatos
                           INTO LV_TIPO_PRODUCTO ,
                                LV_TIPO          ,
                                        LN_COD_VENDEDOR  ,
                                        LV_NOM_VENDEDOR  ,
                                        LN_NUM_VENTA     ,
                                        LN_COD_CUENTA    ,
                                        LN_NUM_ABONADO   ,
                                        LN_NUM_CELULAR   ,
                                        LV_COD_TIPIDENT  ,
                                        LV_NUM_IDENT     ,
                                        LV_NOM_CLIENTE   ,
                                        LV_NOM_APECLIEN1 ,
                                        LV_NOM_APECLIEN2 ,
                                        LD_FEC_VENTA     ,
                                        LD_FEC_ALTA      ,
                                        LV_COD_PLANTARIF ,
                                        LV_DES_PLANTARIF ,
                                        LN_TOLV_FACTURA  ,
                                        LN_NUM_FOLIO     ,
                                        LV_IND_IMPRESA   ,
                                        LV_COD_CLIENTE   ,
                                        LV_NOM_USUARORA  ,
                                        LV_IND_ESTVENTA  ,
                                        LV_COD_SITUACION,
                                        LV_COD_CICLO      ;

                                EXIT WHEN DAT_cursordatos%NOTFOUND;

                                SC_cursordatos(LN_CONTADOR).T_TIPO         := LV_TIPO         ;
                                SC_cursordatos(LN_CONTADOR).TIPO_PRODUCTO  :=LV_TIPO_PRODUCTO ;
                                SC_cursordatos(LN_CONTADOR).T_COD_VENDEDOR := LN_COD_VENDEDOR ;
                                SC_cursordatos(LN_CONTADOR).T_NOM_VENDEDOR := LV_NOM_VENDEDOR ;
                                SC_cursordatos(LN_CONTADOR).T_NUM_VENTA    := LN_NUM_VENTA    ;
                                SC_cursordatos(LN_CONTADOR).T_COD_CUENTA   := LN_COD_CUENTA   ;
                                SC_cursordatos(LN_CONTADOR).T_NUM_ABONADO  := LN_NUM_ABONADO  ;
                                SC_cursordatos(LN_CONTADOR).T_NUM_CELULAR  := LN_NUM_CELULAR  ;
                                SC_cursordatos(LN_CONTADOR).T_COD_TIPIDENT := LV_COD_TIPIDENT ;
                                SC_cursordatos(LN_CONTADOR).T_NUM_IDENT    := LV_NUM_IDENT    ;
                                SC_cursordatos(LN_CONTADOR).T_NOM_CLIENTE  := LV_NOM_CLIENTE  ;
                                SC_cursordatos(LN_CONTADOR).T_NOM_APECLIEN1:= LV_NOM_APECLIEN1;
                                SC_cursordatos(LN_CONTADOR).T_NOM_APECLIEN2:= LV_NOM_APECLIEN2;
                                SC_cursordatos(LN_CONTADOR).T_FEC_VENTA    := LD_FEC_VENTA    ;
                                SC_cursordatos(LN_CONTADOR).T_FEC_ALTA     := LD_FEC_ALTA     ;
                                SC_cursordatos(LN_CONTADOR).T_COD_PLANTARIF:= LV_COD_PLANTARIF;
                                SC_cursordatos(LN_CONTADOR).T_DES_PLANTARIF:= LV_DES_PLANTARIF;
                                SC_cursordatos(LN_CONTADOR).T_TOT_FACTURA  := LN_TOLV_FACTURA ;
                                SC_cursordatos(LN_CONTADOR).T_NUM_FOLIO    := LN_NUM_FOLIO    ;
                                SC_cursordatos(LN_CONTADOR).T_IND_IMPRESA  := LV_IND_IMPRESA  ;
                                SC_cursordatos(LN_CONTADOR).T_COD_CLIENTE  := LV_COD_CLIENTE  ;
                                SC_cursordatos(LN_CONTADOR).T_NOM_USUARORA := LV_NOM_USUARORA ;
                                SC_cursordatos(LN_CONTADOR).T_IND_ESTVENTA := LV_IND_ESTVENTA ;
                                SC_cursordatos(LN_CONTADOR).T_COD_SITUACION :=LV_COD_SITUACION;
                                SC_cursordatos(LN_CONTADOR).T_COD_CICLO     :=LV_COD_CICLO;
                                LN_CONTADOR := LN_CONTADOR + 1;

                                iCantRegistros := iCantRegistros + 1;


                        END LOOP;

                        -- CERRAMOS EL CURSOR
                        CLOSE DAT_cursordatos;


                END LOOP;

                -- CERRAMOS EL CURSOR
                CLOSE LC_CURSORDATOS;


        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 VE_intermediario_PG.VE_NoDataFoundCursor_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_QUERY,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_QUERY,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getVentasNoLegal_PR;

PROCEDURE VE_getVentas_PR(EV_codVendedor  IN VARCHAR2,
                          EV_codVendealer IN VARCHAR2,
                          EV_codCanal     IN VARCHAR2,
                          EV_fecDesde     IN VARCHAR2,
                          EV_fecHasta     IN VARCHAR2,
                          SC_cursordatos  OUT NOCOPY TC_cursordatos,
                                      SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getVentas_PR"
                        Lenguaje="PL/SQL"
                        Fecha="16-08-2007"
                        Version="1.0.0"
                        Disenador="igo"
                        Programador="igo"
                        Ambiente="BD"
                <Retorno>
                                  listado de ventas
                </Retorno>
                <Descripcion>
                        Recupera listado de ventas segun filtro
                        0 : todas las ventas realizadas en un periodo de tiempo
                        1 : todas las ventas no legalizadas (sin recepción de documento y no pagadas)
                            realizadas por un vendedor
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor ventas </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
           CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(19) := 'VE_getVentas_PR';

           NO_DATA_FOUND_CURSOR  EXCEPTION;

           LV_desError  ge_errores_pg.DesEvent;
           LV_Sql       ge_errores_pg.vQuery;
           LV_QUERY     VARCHAR2(3000);
           DAT_cursordatos  REFCURSOR;
           LN_CONTADOR      BINARY_INTEGER := 0;
           LV_TIPO          VARCHAR2(9);
           LV_TIPOPRODUCTO  VARCHAR2(10);
           LN_COD_VENDEDOR  NUMBER(6);
           LV_NOM_VENDEDOR  VARCHAR2(40);
           LN_NUM_VENTA     NUMBER(8);
           LN_COD_CUENTA    NUMBER(8);
           LN_NUM_ABONADO   NUMBER(8);
           LN_NUM_CELULAR   NUMBER(15);
           LV_COD_TIPIDENT  VARCHAR2(2);
           LV_NUM_IDENT     VARCHAR2(20);
           LV_NOM_CLIENTE   VARCHAR2(50);
           LV_NOM_APECLIEN1 VARCHAR2(20);
           LV_NOM_APECLIEN2 VARCHAR2(20);
           LD_FEC_VENTA     DATE;
           LD_FEC_ALTA      DATE;
           LV_COD_PLANTARIF VARCHAR2(3);
           LV_DES_PLANTARIF VARCHAR2(30);
           LN_TOLV_FACTURA  NUMBER(14,4);
           LN_NUM_FOLIO     NUMBER(9);
           LV_IND_IMPRESA   VARCHAR2(10);
           LV_COD_CICLO     GA_ABOCEL.COD_CICLO%TYPE;
           LV_COD_CLIENTE   GE_CLIENTES.COD_CLIENTE%TYPE;
           LV_NOM_USUARORA  GE_SEG_USUARIO.NOM_USUARIO%TYPE;
           LV_COD_VENDEALER VE_VENDEALER.COD_VENDEALER%TYPE;
           LV_IND_ESTVENTA  GA_VENTAS.IND_ESTVENTA%TYPE;
           LV_COD_SITUACION GA_ABOCEL.COD_SITUACION%TYPE;
           --Agregado para manejar excepciones
                LV_codRetorno  ge_errores_pg.coderror;
            LV_mens_retorno ge_errores_pg.desevent;
           --fin


        BEGIN
                SN_num_evento   := 0;
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';

                IF UPPER(EV_codCanal)='D' then
                        LV_QUERY := ' SELECT DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''DIRECTO'',a.cod_vendedor,b.nom_vendedor,a.num_venta,c.cod_cuenta, e.num_abonado ,e.num_celular,';
                        LV_QUERY := LV_QUERY || ' c.cod_tipident, c.num_ident   ,c.nom_cliente, c.nom_apeclien1, c.nom_apeclien2, a.fec_venta, e.fec_alta,';
                        LV_QUERY := LV_QUERY || ' e.cod_plantarif, f.des_plantarif, NVL(d.tot_factura,0), d.num_folio,';
                        LV_QUERY := LV_QUERY || ' decode(g.cod_estadoc+g.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',''PENDIENTE''),c.COD_CLIENTE,e.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                        LV_QUERY := LV_QUERY || ' from ga_ventas a, ve_vendedores b, ge_clientes c , fa_factdocu_nociclo d , ga_abocel e, ta_plantarif f, fa_interfact g';
                        LV_QUERY := LV_QUERY || ' where a.cod_vendedor= ' || EV_codVendedor;
                        LV_QUERY := LV_QUERY || ' and a.cod_vendedor=b.cod_vendedor(+)';
                        LV_QUERY := LV_QUERY || ' and a.cod_cliente=c.cod_cliente(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=d.num_venta(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=e.num_venta';
                        LV_QUERY := LV_QUERY || ' and e.cod_plantarif=f.cod_plantarif(+)';
                        LV_QUERY := LV_QUERY || ' and a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                        LV_QUERY := LV_QUERY || ' and TRUNC(a.fec_venta) between TO_DATE('|| ''''|| EV_fecDesde ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ') ';
                        LV_QUERY := LV_QUERY || ' and TO_DATE('|| ''''|| EV_fecHasta ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ')';
                                                LV_QUERY := LV_QUERY || ' and g.num_proceso(+) = d.num_proceso';
                        LV_QUERY := LV_QUERY || ' union';
                        LV_QUERY := LV_QUERY || ' select DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''DIRECTO'',a.cod_vendedor,b.nom_vendedor,a.num_venta,c.cod_cuenta, e.num_abonado ,e.num_celular,';
                        LV_QUERY := LV_QUERY || ' c.cod_tipident, c.num_ident    ,c.nom_cliente, c.nom_apeclien1, c.nom_apeclien2, a.fec_venta,';
                        LV_QUERY := LV_QUERY || ' e.fec_alta, e.cod_plantarif, f.des_plantarif, NVL(d.tot_factura,0), d.num_folio,';
                        LV_QUERY := LV_QUERY || ' decode(g.cod_estadoc+g.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',''PENDIENTE''),c.COD_CLIENTE,e.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                        LV_QUERY := LV_QUERY || ' from ga_ventas a, ve_vendedores b, ge_clientes c , fa_factdocu_nociclo d , ga_aboamist e, ta_plantarif f, fa_interfact g';
                        LV_QUERY := LV_QUERY || ' where a.cod_vendedor= ' || EV_codVendedor;
                        LV_QUERY := LV_QUERY || ' and a.cod_vendedor=b.cod_vendedor(+)';
                        LV_QUERY := LV_QUERY || ' and a.cod_cliente=c.cod_cliente(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=d.num_venta(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=e.num_venta';
                        LV_QUERY := LV_QUERY || ' and e.cod_plantarif=f.cod_plantarif(+)';
                        LV_QUERY := LV_QUERY || ' and a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                        LV_QUERY := LV_QUERY || ' and TRUNC(a.fec_venta) between TO_DATE('|| ''''|| EV_fecDesde ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ') ';
                        LV_QUERY := LV_QUERY || ' and TO_DATE('|| ''''|| EV_fecHasta ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ')';
                                                LV_QUERY := LV_QUERY || ' and g.num_proceso(+) = d.num_proceso';

                ELSIF UPPER(EV_codCanal)='I' then

                        LV_QUERY := 'select DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''INDIRECTO'',a.cod_vendealer,b.nom_vendealer,a.num_venta,c.cod_cuenta, e.num_abonado ,e.num_celular,';
                        LV_QUERY := LV_QUERY || ' c.cod_tipident, c.num_ident   ,c.nom_cliente, c.nom_apeclien1, c.nom_apeclien2, a.fec_venta,';
                        LV_QUERY := LV_QUERY || ' e.fec_alta, e.cod_plantarif, f.des_plantarif  , NVL(d.tot_factura,0), d.num_folio,';
                        LV_QUERY := LV_QUERY || ' decode(h.cod_estadoc+h.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',''PENDIENTE''),c.COD_CLIENTE,e.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                        LV_QUERY := LV_QUERY || ' from ga_ventas a, ve_vendealer b, ge_clientes c , fa_factdocu_nociclo d ,';
                        LV_QUERY := LV_QUERY || ' ga_abocel e, ta_plantarif f, ve_vendealer g, fa_interfact h';
                        LV_QUERY := LV_QUERY || ' WHERE a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';

                        if EV_codVendedor IS NOT NULL then
                                LV_QUERY := LV_QUERY || ' and a.cod_vendedor= ' || EV_codVendedor;
                        end if;
                        if EV_codvendealer IS NOT NULL then
                                LV_QUERY := LV_QUERY || ' and a.cod_vendealer= ' || EV_codVendealer;
                        end if;
                        LV_QUERY := LV_QUERY || ' and a.cod_vendedor=b.cod_vendedor(+)';
                        if EV_codvendealer IS NOT NULL then
                                LV_QUERY := LV_QUERY || ' and a.cod_vendealer = b.cod_vendealer(+)';
                        end if;
                        LV_QUERY := LV_QUERY || ' and a.cod_cliente=c.cod_cliente(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=d.num_venta(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=e.num_venta';
                        LV_QUERY := LV_QUERY || ' and e.cod_plantarif=f.cod_plantarif(+)';
                        LV_QUERY := LV_QUERY || ' and a.cod_vendealer=g.cod_vendealer(+)';
                        LV_QUERY := LV_QUERY || ' and TRUNC(a.fec_venta) between TO_DATE('|| ''''|| EV_fecDesde ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ') ';
                        LV_QUERY := LV_QUERY || ' and TO_DATE('|| ''''|| EV_fecHasta ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ')';
                        LV_QUERY := LV_QUERY || ' and h.num_proceso(+) = d.num_proceso';
                        LV_QUERY := LV_QUERY || ' UNION';
                        LV_QUERY := LV_QUERY || ' select DECODE (f.cod_tiplan,''1'',''PREPAGO'',''2'',''POSTPAGO'',''HIBRIDO''),''INDIRECTO'',a.cod_vendealer,b.nom_vendealer,a.num_venta,c.cod_cuenta, e.num_abonado ,e.num_celular,';
                        LV_QUERY := LV_QUERY || ' c.cod_tipident, c.num_ident ,c.nom_cliente, c.nom_apeclien1, c.nom_apeclien2, a.fec_venta,';
                        LV_QUERY := LV_QUERY || ' e.fec_alta, e.cod_plantarif, f.des_plantarif  , NVL(d.tot_factura,0), d.num_folio,';
                        LV_QUERY := LV_QUERY || ' decode(h.cod_estadoc+h.cod_estproc,403,''IMPRESA'',401,''EN PROCESO'',402,''ERROR IMPRESION'',''PENDIENTE''),c.COD_CLIENTE,e.NOM_USUARORA,A.IND_ESTVENTA,E.COD_SITUACION,E.COD_CICLO';
                        LV_QUERY := LV_QUERY || ' from ga_ventas a, ve_vendealer b, ge_clientes c , fa_factdocu_nociclo d , ga_aboamist e,';
                        LV_QUERY := LV_QUERY || ' ta_plantarif f, ve_vendealer g, fa_interfact h';
                        LV_QUERY := LV_QUERY || ' WHERE a.ind_venta in ('|| ''''|| 'V'||'''' ||',' ||  ''''|| 'P'||'''' ||')';
                        if EV_codVendedor IS NOT NULL then
                                LV_QUERY := LV_QUERY || ' and a.cod_vendedor= ' || EV_codVendedor;
                        end if;
                        if EV_codvendealer IS NOT NULL then
                                LV_QUERY := LV_QUERY || ' and a.cod_vendealer= ' || EV_codVendealer;
                        end if;
                        LV_QUERY := LV_QUERY || ' and a.cod_vendedor=b.cod_vendedor(+)';
                        if EV_codvendealer IS NOT NULL then
                                LV_QUERY := LV_QUERY || ' and a.cod_vendealer = b.cod_vendealer(+)';
                        end if;
                        LV_QUERY := LV_QUERY || ' and a.cod_cliente=c.cod_cliente(+)';
                        LV_QUERY := LV_QUERY || ' and e.cod_plantarif=f.cod_plantarif(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=d.num_venta(+)';
                        LV_QUERY := LV_QUERY || ' and a.num_venta=e.num_venta';
                        LV_QUERY := LV_QUERY || ' and a.cod_vendealer=g.cod_vendealer(+)';
                        LV_QUERY := LV_QUERY || ' and TRUNC(a.fec_venta) between TO_DATE('|| ''''|| EV_fecDesde ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ') ';
                        LV_QUERY := LV_QUERY || ' and TO_DATE('|| ''''|| EV_fecHasta ||'''' || ','|| ''''|| VE_intermediario_PG.CV_FORMATOFECHA ||'''' || ')';
                        LV_QUERY := LV_QUERY || ' and h.num_proceso(+) = d.num_proceso';

                ELSE
                                SV_mens_retorno := 'Código de canal inválido';
                                RAISE NO_DATA_FOUND_CURSOR;

                END IF;

--    DBMS_OUTPUT.Put_Line('EV_codCanal ' || EV_codCanal );
--    DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1,255));
--    DBMS_OUTPUT.Put_Line(substr(LV_QUERY,256,255));
--    DBMS_OUTPUT.Put_Line(substr(LV_QUERY,502,255));
--    DBMS_OUTPUT.Put_Line(substr(LV_QUERY,753,255));
--    DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1004,255));
--    DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1259,255));
--    DBMS_OUTPUT.Put_Line(substr(LV_QUERY,1544,255));

                OPEN DAT_cursordatos FOR LV_QUERY;

                LOOP

                  FETCH DAT_cursordatos
                   INTO LV_TIPOPRODUCTO  ,
                        LV_TIPO          ,
                        LN_COD_VENDEDOR  ,
                        LV_NOM_VENDEDOR  ,
                        LN_NUM_VENTA     ,
                        LN_COD_CUENTA    ,
                        LN_NUM_ABONADO   ,
                        LN_NUM_CELULAR   ,
                        LV_COD_TIPIDENT  ,
                        LV_NUM_IDENT     ,
                        LV_NOM_CLIENTE   ,
                        LV_NOM_APECLIEN1 ,
                        LV_NOM_APECLIEN2 ,
                        LD_FEC_VENTA     ,
                        LD_FEC_ALTA      ,
                        LV_COD_PLANTARIF ,
                        LV_DES_PLANTARIF ,
                        LN_TOLV_FACTURA  ,
                        LN_NUM_FOLIO     ,
                        LV_IND_IMPRESA,
                        LV_COD_CLIENTE,
                        LV_NOM_USUARORA,
                        LV_IND_ESTVENTA,
                        LV_COD_SITUACION,
                        LV_COD_CICLO;


                        EXIT WHEN DAT_cursordatos%NOTFOUND;


                        SC_cursordatos(LN_CONTADOR).T_TIPO          := LV_TIPO         ;
                        SC_cursordatos(LN_CONTADOR).TIPO_PRODUCTO   := LV_TIPOPRODUCTO ;
                        SC_cursordatos(LN_CONTADOR).T_COD_VENDEDOR  := LN_COD_VENDEDOR ;
                        SC_cursordatos(LN_CONTADOR).T_NOM_VENDEDOR  := LV_NOM_VENDEDOR ;
                        SC_cursordatos(LN_CONTADOR).T_NUM_VENTA     := LN_NUM_VENTA    ;
                        SC_cursordatos(LN_CONTADOR).T_COD_CUENTA    := LN_COD_CUENTA   ;
                        SC_cursordatos(LN_CONTADOR).T_NUM_ABONADO   := LN_NUM_ABONADO  ;
                        SC_cursordatos(LN_CONTADOR).T_NUM_CELULAR   := LN_NUM_CELULAR  ;
                        SC_cursordatos(LN_CONTADOR).T_COD_TIPIDENT  := LV_COD_TIPIDENT ;
                        SC_cursordatos(LN_CONTADOR).T_NUM_IDENT     := LV_NUM_IDENT    ;
                        SC_cursordatos(LN_CONTADOR).T_NOM_CLIENTE   := LV_NOM_CLIENTE  ;
                        SC_cursordatos(LN_CONTADOR).T_NOM_APECLIEN1 := LV_NOM_APECLIEN1;
                        SC_cursordatos(LN_CONTADOR).T_NOM_APECLIEN2 := LV_NOM_APECLIEN2;
                        SC_cursordatos(LN_CONTADOR).T_FEC_VENTA     := LD_FEC_VENTA    ;
                        SC_cursordatos(LN_CONTADOR).T_FEC_ALTA      := LD_FEC_ALTA     ;
                        SC_cursordatos(LN_CONTADOR).T_COD_PLANTARIF := LV_COD_PLANTARIF;
                        SC_cursordatos(LN_CONTADOR).T_DES_PLANTARIF := LV_DES_PLANTARIF;
                        SC_cursordatos(LN_CONTADOR).T_TOT_FACTURA   := LN_TOLV_FACTURA ;
                        SC_cursordatos(LN_CONTADOR).T_NUM_FOLIO     := LN_NUM_FOLIO    ;
                        SC_cursordatos(LN_CONTADOR).T_IND_IMPRESA   := LV_IND_IMPRESA  ;
                        SC_cursordatos(LN_CONTADOR).T_COD_CLIENTE   := LV_COD_CLIENTE  ;
                        SC_cursordatos(LN_CONTADOR).T_NOM_USUARORA  := LV_NOM_USUARORA ;
                        SC_cursordatos(LN_CONTADOR).T_IND_ESTVENTA  := LV_IND_ESTVENTA ;
                        SC_cursordatos(LN_CONTADOR).T_COD_SITUACION :=LV_COD_SITUACION;
                        SC_cursordatos(LN_CONTADOR).T_COD_CICLO     :=LV_COD_CICLO;
                        LN_CONTADOR := LN_CONTADOR + 1;
                        iCantRegistros := iCantRegistros + 1;

                END LOOP;

                -- CERRAMOS EL CURSOR
                CLOSE DAT_cursordatos;


        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 SN_cod_retorno:=408;
                                 --SV_mens_retorno:='No existen datos de la venta';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getVentas_PR;


        PROCEDURE VE_getListDirCliente_PR(EV_codCliente   IN VARCHAR2,
                                          SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                              SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListDirCliente_PR"
                        Lenguaje="PL/SQL"
                        Fecha="27-07-2007"
                        Version="1.0.0"
                        Disenador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Recupera listado de cuotas
                </Descripcion>
                <Parametros>
                <Entrada> N/A </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor cuotas </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
           CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(23) := 'VE_getListDirCliente_PR';

           NO_DATA_FOUND_CURSOR  EXCEPTION;

           LV_desError  ge_errores_pg.DesEvent;
           LV_Sql       ge_errores_pg.vQuery;
           LV_COUNT     NUMBER(1);
           ERROR_CLIENTE EXCEPTION;
           LN_contador       NUMBER;
           --Agregado para manejar excepciones
       LV_codRetorno  ge_errores_pg.coderror;
       LV_mens_retorno ge_errores_pg.desevent;
       --fin
        BEGIN
                SN_num_evento   := 0;
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';


                LV_sql:='SELECT COUNT(1) FROM GE_CLIENTES WHERE COD_CLIENTE= ' || EV_codCliente;


                SELECT COUNT(1)
                INTO LV_COUNT
                FROM GE_CLIENTES
                WHERE COD_CLIENTE=EV_codCliente;

                IF LV_COUNT=0 THEN
                   RAISE ERROR_CLIENTE;
                END IF;

                LV_Sql := 'SELECT a.cod_tipdireccion,'
                       || ' c.des_tipdireccion,'
                           || ' b.Cod_provincia,'
                           || ' d.des_provincia,'
                       || ' b.Cod_ciudad,'
                           || ' f.des_ciudad,'
                           || ' b.Cod_comuna,'
                           || ' g.des_comuna,'
                           || ' b.Nom_calle ||'
                           || '  ''  '' || b.Num_calle ||'
                           || '  ''  '' || b.Num_piso,'
                           --b.Num_casilla
                           || ' b.Obs_direccion'
                       --b.Des_direc1,
                           --b.Des_direc2,
                           --b.Cod_pueblo,
                           --h.des_pueblo,
                           --b.Cod_estado,
                           --i.des_estado,
                           --b.Zip

                                   || ' ,b.Cod_region'
                                   || ' ,e.des_region'
                                   || ' ,b.Cod_comuna'
                                   || ' ,g.des_comuna'
                                   || ' ,b.COD_TIPOCALLE'
                                || ' ,X.DESCRIPCION_VALOR'


                       || ' FROM ga_direccli a,'
                       || ' ge_direcciones b,'
                           || ' ge_tipdireccion c,'
                           || ' ge_provincias d,'
                           || ' ge_regiones e,'
                           || ' ge_ciudades f,'
                           || ' ge_comunas g,'
                           || ' ge_pueblos h,'
                           || ' ge_estados i,'

                                   || ' GE_TIPOS_CALLES_VW X'

                       || ' WHERE a.cod_direccion = b.cod_direccion'
                       || ' AND a.cod_tipdireccion =c.cod_tipdireccion'
                       || ' AND b.cod_region = d.cod_region'
                       || ' AND b.cod_provincia = d.cod_provincia'
                       || ' AND b.cod_region = e.cod_region(+)'
                       || ' AND b.cod_region = f.cod_region (+)'
                       || ' AND b.cod_provincia = f.cod_provincia(+)'
                       || ' AND b.cod_ciudad = f.cod_ciudad (+)'
                       || ' AND b.cod_region = g.cod_region (+)'
                       || ' AND b.cod_provincia = g.cod_provincia(+)'
                       || ' AND b.cod_comuna = g.cod_comuna(+)'
                       || ' AND b.cod_pueblo = h.cod_pueblo (+)'
                       || ' AND b.cod_estado = h.cod_estado(+)'
                       || ' AND b.cod_Estado = i.cod_estado(+)'

                                --|| ' AND X.COD_DOMINIO = ''' || 'TIPOS_CALLES' || ''''
                                || ' AND B.COD_TIPOCALLE = X.VALOR(+) '

                       || ' AND a.cod_cliente = ' || EV_codCliente;


                -- Controlamos No Data Found en el cursor
                LN_contador := 0;
                SELECT COUNT(1)
                INTO LN_contador
                FROM ga_direccli a,
                     ge_direcciones b,
                         ge_tipdireccion c,
                         ge_provincias d,
                         ge_regiones e,
                         ge_ciudades f,
                         ge_comunas g,
                         ge_pueblos h,
                         ge_estados i,
                         GE_TIPOS_CALLES_VW X
                WHERE a.cod_direccion = b.cod_direccion
                  AND a.cod_tipdireccion =c.cod_tipdireccion
                  AND b.cod_region = d.cod_region
                  AND b.cod_provincia = d.cod_provincia
                  AND b.cod_region = e.cod_region(+)
                  AND b.cod_region = f.cod_region (+)
                  AND b.cod_provincia = f.cod_provincia(+)
                  AND b.cod_ciudad = f.cod_ciudad (+)
                  AND b.cod_region = g.cod_region (+)
                  AND b.cod_provincia = g.cod_provincia(+)
                  AND b.cod_comuna = g.cod_comuna(+)
                  AND b.cod_pueblo = h.cod_pueblo (+)
                  AND b.cod_estado = h.cod_estado(+)
                  AND b.cod_Estado = i.cod_estado(+)
              AND B.COD_TIPOCALLE = X.VALOR(+)
                  AND a.cod_cliente = EV_codCliente;

                -- Inc.  : 64051 Se modifica abrir cursor despues de la validacion
                -- Fecha : 02/04/2008
                -- Prog  : JMC
                --OPEN SC_cursordatos FOR LV_Sql;

                IF (LN_contador = 0) THEN
                        RAISE NO_DATA_FOUND_CURSOR;
                END IF;

                OPEN SC_cursordatos FOR LV_Sql;
                -- Fin 64051

        EXCEPTION
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 -- Inc.  : 64051 Se modifica para personalizar el mensaje de error
                                 -- Fecha : 02/04/2008
                                 -- Prog  : JMC
                                 --VE_intermediario_PG.VE_NoDataFoundCursor_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                 SN_cod_retorno:=319;
                                 SV_mens_retorno:='Cliente existe pero no tiene direcciones asignadas';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                                 -- Fin 64051

                        WHEN ERROR_CLIENTE THEN
                                 SN_cod_retorno:=225;
                                 SV_mens_retorno:='Codigo de Cliente no definido en SCL';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getListDirCliente_PR;

        PROCEDURE VE_getListPlanTarif_PR(EV_tipoProducto IN VARCHAR2,  /* 0 */
                                     EV_codClasific  IN VARCHAR2,  /* I */
                                                         EV_codDcifra    IN VARCHAR2,  /* A */
                                                         EV_limiteCons   IN VARCHAR2,  /* 5000 */
                                                         EV_codCliente   IN VARCHAR2,
                                                                         SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                             SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getListPlanTarif_PR"
                        Lenguaje="PL/SQL"
                        Fecha="03-08-2007"
                        Version="1.0.0"
                        Disenador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                        Listado de planes tarifarios
                </Retorno>
                <Descripcion>
                        Recupera listado de planes tarifarios
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EV_tipoProducto" Tipo="STRING"> tipo producto </param>
                        <param nom="EV_codClasific"  Tipo="STRING"> codigo clasificacion </param>
                        <param nom="EV_codDcifra"    Tipo="STRING"> codigo DCifra </param>
                        <param nom="EV_limiteCons"   Tipo="STRING"> limite consumo </param>
                        <param nom="EV_codCliente"   Tipo="STRING"> codigo cliente </param>
                </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor servicios suplementarios </param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
           CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(22) := 'VE_getListPlanTarif_PR';

           ERROR_PARAMETRO       EXCEPTION;
           ERROR_SQL             EXCEPTION;
           NO_DATA_FOUND_CURSOR  EXCEPTION;

           LV_desError  ge_errores_pg.DesEvent;
           LV_Sql       ge_errores_pg.vQuery;

           LV_tipoPrepago       VARCHAR2(20);
           LV_planServicio      VARCHAR2(20);
           LV_usoPrepago        VARCHAR2(20);
           LV_valClasificacion  VARCHAR2(20);
           LN_contador  NUMBER;
           CV_Tiplan    TA_PLANTARIF.COD_TIPLAN%TYPE;
           LV_nomUsuario VARCHAR2(30);
           LN_impuesto   NUMBER;
           --Agregado para manejar excepciones
           LV_COUNT     NUMBER(1);
           ERROR_CLIENTE EXCEPTION;
           LV_codRetorno  ge_errores_pg.coderror;
       LV_mens_retorno ge_errores_pg.desevent;
           --fin
        BEGIN
                SN_num_evento   := 0;
                SN_cod_retorno  := 0;
                SV_mens_retorno := '';

                IF EV_CodCliente IS NOT NULL THEN

                   LV_Sql:='SELECT COUNT(1) FROM GE_CLIENTES WHERE COD_CLIENTE= ' || EV_CodCliente;

                   SELECT COUNT(1)
                   INTO LV_COUNT
                   FROM GE_CLIENTES
                   WHERE COD_CLIENTE= EV_CodCliente;


                   IF LV_COUNT=0 THEN
                      RAISE ERROR_CLIENTE;
                   END IF;

                END IF;

                -- Obtenemos un usuario que posea oficina
                SELECT a.nom_usuario
                INTO LV_nomUsuario
                FROM ge_seg_usuario a
                WHERE a.cod_oficina IS NOT NULL
                AND ROWNUM = 1;


                --  Obtenemos el valor : tipo prepago
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_TIPOPREPAGO,
                                                                  VE_intermediario_PG.CV_MODULO_GA,
                                                                      VE_intermediario_PG.CN_PRODUCTO,
                                                                                                                  LV_tipoPrepago,
                                                                                                                  SN_cod_retorno,
                                                                                                                  SV_mens_retorno,
                                                                                                                  SN_num_evento);
                IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_SQL;
                END IF;

                --  Obtenemos el valor : tipo plan de servicio
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_TIPPLANSERV,
                                                                  VE_intermediario_PG.CV_MODULO_TA,
                                                                      VE_intermediario_PG.CN_PRODUCTO,
                                                                                                                  LV_planServicio,
                                                                                                                  SN_cod_retorno,
                                                                                                                  SV_mens_retorno,
                                                                                                                  SN_num_evento);
                IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_SQL;
                END IF;

                --  Obtenemos el valor : uso prepago
        Ve_Intermediario_Pg.VE_OBTIENE_VALOR_PARAMETRO_PR(CV_NOMPAR_USOPREPAGO,
                                                                  VE_intermediario_PG.CV_MODULO_GA,
                                                                      VE_intermediario_PG.CN_PRODUCTO,
                                                                                                                  LV_usoPrepago,
                                                                                                                  SN_cod_retorno,
                                                                                                                  SV_mens_retorno,
                                                                                                                  SN_num_evento);
                IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_SQL;
                END IF;

                LN_contador := 0;

        IF (EV_tipoProducto = Ve_Intermediario_Pg.CN_TIPPRODPOSTPAGO) OR (EV_tipoProducto = Ve_Intermediario_Pg.CN_TIPPRODHIBRIDO) THEN
                -- Tipo de producto : postpago o hibrido

            -- Invocamos la función que obtiene el impuesto
                LN_impuesto := 0;
                LN_impuesto := FA_ObtenerImpuesto_FN(EV_codCliente,LV_nomUsuario);

                IF LN_impuesto is NULL THEN
                   LN_IMPUESTO:=1;
                END IF;


        LV_Sql := 'SELECT a.cod_plantarif,'
                               || ' a.des_plantarif'
                       || ' FROM ta_plantarif a,'
                       || ' ta_cargosbasico b,'
                       || ' ve_clasif_credcli_planes_td c,'
                       || ' ga_planuso d'
                       || ' WHERE  a.cod_plantarif = d.cod_plantarif'
                       || ' AND a.cod_producto = d.cod_producto(+)'
                       || ' AND a.cod_producto = ' || VE_intermediario_PG.CN_PRODUCTO
                       || ' AND d.cod_uso <> ' || LV_usoPrepago
                       || ' AND a.cla_plantarif <> ''' || LV_planServicio || ''''
                       || ' AND a.cod_tiplan <> ' || LV_tipoPrepago
                       || ' AND a.cod_cargobasico = b.cod_cargobasico'
                       || ' AND b.cod_producto = ' || VE_intermediario_PG.CN_PRODUCTO
                       || ' AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)'
                       || ' AND ROUND (b.imp_cargobasico * ' || LN_impuesto || ') <= ' || EV_limiteCons
                       || ' AND a.cod_plantarif = c.cod_plantarif'
                       || ' AND c.cod_clasificacion = ''' ||   EV_codClasific || ''''
                       || ' AND c.cod_dcifra = ''' || EV_codDcifra  || ''''
                       || ' AND a.IND_COMER_WEB = ' || Ve_Intermediario_Pg.CN_INDICADORWEB;
                               IF (EV_tipoProducto=Ve_Intermediario_Pg.CN_TIPPRODPOSTPAGO) THEN
                                       CV_Tiplan:=2;
                                           LV_Sql:= LV_Sql || ' AND a.cod_tiplan = '|| CV_Tiplan ;
                                   ELSE
                                       CV_Tiplan:=3;
                                       LV_Sql:= LV_Sql || ' AND a.cod_tiplan = ' || CV_Tiplan;
                                   END IF;

                        -- Controlamos No Data Found en el cursor
                        SELECT COUNT(1)
                        INTO LN_contador
                        FROM ta_plantarif a,
                     ta_cargosbasico b,
                     ve_clasif_credcli_planes_td c,
                     ga_planuso d
                WHERE  a.cod_plantarif = d.cod_plantarif
                  AND a.cod_producto = d.cod_producto(+)
                  AND a.cod_producto = VE_intermediario_PG.CN_PRODUCTO
                  AND d.cod_uso <> LV_usoPrepago
                  AND a.cla_plantarif <> LV_planServicio
                  AND a.cod_tiplan <> LV_tipoPrepago
                  AND a.cod_cargobasico = b.cod_cargobasico
                  AND b.cod_producto = VE_intermediario_PG.CN_PRODUCTO
                  AND SYSDATE BETWEEN b.fec_desde AND NVL(b.fec_hasta, SYSDATE)
                  AND ROUND (b.imp_cargobasico * LN_impuesto) <= EV_limiteCons
                  AND a.cod_plantarif = c.cod_plantarif
                  AND c.cod_clasificacion = EV_codClasific
                  AND c.cod_dcifra = EV_codDcifra
                  AND a.IND_COMER_WEB = Ve_Intermediario_Pg.CN_INDICADORWEB
                          AND COD_TIPLAN = CV_Tiplan;

        ELSIF (EV_tipoProducto = Ve_Intermediario_Pg.CN_TIPPRODPREPAGO) THEN
                -- Tipo de producto : prepago
                    CV_Tiplan:=1;

                LV_Sql := 'SELECT a.cod_plantarif,'
                               || ' a.des_plantarif'
                       || ' FROM ta_plantarif a,'
                       || ' ta_cargosbasico b,'
                       || ' ga_planuso d'
                       || ' WHERE a.cod_plantarif = d.cod_plantarif'
                       || ' AND a.cod_producto = d.cod_producto(+)'
                       || ' AND a.cod_cargobasico = b.cod_cargobasico'
                       || ' AND a.cod_producto = ' || VE_intermediario_PG.CN_PRODUCTO
                       || ' AND a.cla_plantarif <> ''' || LV_planServicio || ''''
                       || ' AND b.cod_producto = ' || VE_intermediario_PG.CN_PRODUCTO
                       || ' AND SYSDATE BETWEEN b.fec_desde AND nvl(b.fec_hasta, SYSDATE)'
                       || ' AND a.IND_COMER_WEB = ' || Ve_Intermediario_Pg.CN_INDICADORWEB
                   || ' AND a.COD_TIPLAN = ' || CV_Tiplan;
                        -- Controlamos No Data Found en el cursor
                        SELECT COUNT(1)
                        INTO LN_contador
                FROM ta_plantarif a,
                     ta_cargosbasico b,
                     ga_planuso d
                WHERE a.cod_plantarif = d.cod_plantarif
                  AND a.cod_producto = d.cod_producto(+)
                  AND a.cod_cargobasico = b.cod_cargobasico
                  AND a.cod_producto = VE_intermediario_PG.CN_PRODUCTO
                  --AND d.cod_uso <> LV_usoPrepago
                  AND a.cla_plantarif <> LV_planServicio
                  --AND a.cod_tiplan <> LV_tipoPrepago
                  AND b.cod_producto = VE_intermediario_PG.CN_PRODUCTO
                  AND SYSDATE BETWEEN b.fec_desde AND nvl(b.fec_hasta, SYSDATE)
                  AND a.IND_COMER_WEB = Ve_Intermediario_Pg.CN_INDICADORWEB
                          AND a.COD_TIPLAN= CV_Tiplan;
        ELSE
                        RAISE ERROR_PARAMETRO;
                END IF;

                OPEN SC_cursordatos FOR LV_Sql;

                IF (LN_contador = 0) THEN
                   RAISE NO_DATA_FOUND_CURSOR;
                END IF;

        EXCEPTION
                        WHEN ERROR_PARAMETRO THEN
                                 VE_intermediario_PG.VE_ErrorParametro_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        WHEN ERROR_CLIENTE THEN
                             SN_cod_retorno:=225;
                         SV_mens_retorno:='Codigo de Cliente no definido en SCL';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN ERROR_SQL THEN
                                 VE_intermediario_PG.VE_ErrorSql_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        WHEN NO_DATA_FOUND_CURSOR THEN
                                 VE_intermediario_PG.VE_NoDataFoundCursor_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getListPlanTarif_PR;

        PROCEDURE VE_getListUsuario_PR(EV_numAbonado    IN VARCHAR2,
                                       SV_nomUsuario    OUT NOCOPY VARCHAR2,
                                       SV_nomApell1     OUT NOCOPY VARCHAR2,
                                       SV_nomApell2     OUT NOCOPY VARCHAR2,
                                       SV_tipIdentif    OUT NOCOPY VARCHAR2,
                                       SV_numIdentif    OUT NOCOPY VARCHAR2,
                                       SV_codProvincia  OUT NOCOPY VARCHAR2,
                                           SV_nomProvincia  OUT NOCOPY VARCHAR2,
                                           SV_codCiudad     OUT NOCOPY VARCHAR2,
                                           SV_nomCiudad     OUT NOCOPY VARCHAR2,
                                           SV_Direccion     OUT NOCOPY VARCHAR2,
                                           SV_Observacion   OUT NOCOPY VARCHAR2,
                                           SV_fecNacimiento OUT NOCOPY VARCHAR2,
                                           SV_Sexo          OUT NOCOPY VARCHAR2,
                                           SV_codEstrato    OUT NOCOPY VARCHAR2,
                                           SV_Mail          OUT NOCOPY VARCHAR2,
                                                                   SV_COD_REGION    OUT NOCOPY VARCHAR2,
                                                                   SV_DES_REGION    OUT NOCOPY VARCHAR2,
                                                                   SV_COD_COMUNA    OUT NOCOPY VARCHAR2,
                                                                   SV_DES_COMUNA    OUT NOCOPY VARCHAR2,
                                                                   SV_COD_TIPOCALLE OUT NOCOPY VARCHAR2,
                                                                   SV_DES_TIPOCALLE OUT NOCOPY VARCHAR2,
                                                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                        /*
                        <Documentación TipoDoc = "Procedimiento">
                                Elemento Nombre = "VE_getListUsuario_PR"
                                Lenguaje="PL/SQL"
                                Fecha="13-08-2007"
                                Versión="1.0.0"
                                Diseñador="igo"
                                Programador="igo"
                                Ambiente="BD"
                        <Retorno>
                                          datos usuario
                        </Retorno>
                        <Descripción>
                                          datos usuario segun numero abonado
                        </Descripción>
                        <Parámetros>
                         <Entrada>
                                   <param nom="EV_numAbonado" Tipo="STRING"> numero abonado </param>
                                 </Entrada>
                         <Salida>
                                   <param nom="SV_nomUsuario"    Tipo="STRING"> nombre </param>
                                   <param nom="SV_nomApell1"     Tipo="STRING"> apellido paterno </param>
                                   <param nom="SV_nomApell2"     Tipo="STRING"> apellido materno </param>
                                   <param nom="SV_tipIdentif"    Tipo="STRING"> tipo identificador </param>
                                   <param nom="SV_numIdentif"    Tipo="STRING"> numero identificador </param>
                                   <param nom="SV_fonContacto"   Tipo="STRING"> fono contacto </param>
                                   <param nom="SV_codProvincia"  Tipo="STRING"> codigo provincia </param>
                                   <param nom="SV_nomProvincia"  Tipo="STRING"> nombre provincia </param>
                                   <param nom="SV_codCiudad"     Tipo="STRING"> codido ciudad </param>
                                   <param nom="SV_nomCiudad"     Tipo="STRING"> nombre ciudad </param>
                                   <param nom="SV_Direccion"     Tipo="STRING"> direccion, calle </param>
                                   <param nom="SV_Observacion"   Tipo="STRING"> observacion direccion </param>
                                   <param nom="SV_fecNacimiento" Tipo="STRING"> fecha nacimiento </param>
                                   <param nom="SV_Sexo"          Tipo="STRING"> sexo </param>
                                   <param nom="SV_codEstrato"    Tipo="STRING"> codigo estrato </param>
                                   <param nom="SV_Mail"          Tipo="STRING"> email </param>

                                   <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                           <param nom="SV_mens_retorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                           <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                                 </Salida>
                        </Parámetros>
                        </Elemento>
                        </Documentación>
                        */
                    CV_NOMBRE_PROCEDURE CONSTANT VARCHAR2(24) := 'VE_getListUsuario_PR';
                    ERROR_PLS            EXCEPTION;

                        CV_TIPOUSUARIO      VARCHAR(8);
                        CV_TABABONADO       VARCHAR(11);
                        CV_TABUSUARIO       VARCHAR(11);

                        LV_CODTIPDIRECCION  VARCHAR(1);

                        LV_desError ge_errores_pg.desevent;
                        LV_sql          ge_errores_pg.vquery;
                        --Agregado para manejar excepciones
                    LV_codRetorno  ge_errores_pg.coderror;
                    LV_mens_retorno ge_errores_pg.desevent;
                    --fin
                BEGIN
                        SN_cod_retorno := 0;
                        SV_mens_retorno := NULL;
                        SN_num_evento  := 0;


                        LV_Sql:= 'SELECT "POSTPAGO" TIPOUSUARIO FROM GA_ABOCEL WHERE NUM_ABONADO=' || EV_numAbonado;
                        LV_Sql:=LV_Sql || ' UNION ';
                        LV_Sql:=LV_Sql || ' SELECT "PREPAGO" TIPOUSUARIO FROM GA_ABOAMIST WHERE NUM_ABONADO=' || EV_numAbonado ;


                        SELECT 'POSTPAGO' TIPOUSUARIO
                          INTO CV_TIPOUSUARIO
                          FROM GA_ABOCEL
                         WHERE NUM_ABONADO=EV_numAbonado
                         UNION
                        SELECT 'PREPAGO' TIPOUSUARIO
                          FROM GA_ABOAMIST
                     WHERE NUM_ABONADO=EV_numAbonado;

                         LV_CODTIPDIRECCION := '3';
                         IF CV_TIPOUSUARIO = 'POSTPAGO' THEN
                                CV_TABABONADO := 'GA_ABOCEL';
                                CV_TABUSUARIO := 'GA_USUARIOS';
                         ELSE
                                CV_TABABONADO := 'GA_ABOAMIST';
                                CV_TABUSUARIO := 'GA_USUAMIST';
                         END IF;


                        LV_Sql:='SELECT A.NOM_USUARIO,'
                                        || ' A.NOM_APELLIDO1,'
                                        || ' A.NOM_APELLIDO2,'
                                        || ' A.COD_TIPIDENT,'
                                        || ' A.NUM_IDENT,'
                                        || ' B.COD_PROVINCIA,'
                                        || ' B.DES_PROVINCIA,'
                                        || ' B.COD_CIUDAD,'
                                        || ' B.DES_CIUDAD,'
                                        || ' B.NOM_CALLE,'
                                        || ' B.OBS_DIRECCION,'
                                        || ' A.FEC_NACIMIEN,'
                                        || ' A.IND_SEXO,'
                                        || ' A.COD_ESTRATO,'
                                        || ' A.EMAIL,'

                                        || ' B.COD_REGION, B.DES_REGION, B.COD_COMUNA, B.DES_COMUNA, B.COD_TIPOCALLE'

                                        || ' ,B.DESCRIPCION_VALOR'

                                || ' FROM ' || CV_TABUSUARIO || ' A,'
                                || ' ('
                                || ' SELECT B.COD_USUARIO, B.COD_TIPDIRECCION, C.COD_PROVINCIA, D.DES_PROVINCIA, C.COD_CIUDAD, E.DES_CIUDAD, C.NOM_CALLE, C.OBS_DIRECCION, C.COD_REGION, F.DES_REGION, C.COD_COMUNA, G.DES_COMUNA,C.COD_TIPOCALLE, V.DESCRIPCION_VALOR'
                                || ' FROM GA_DIRECUSUAR B , GE_DIRECCIONES C, GE_PROVINCIAS D , GE_CIUDADES E, GE_REGIONES F, GE_COMUNAS G, GE_TIPOS_CALLES_VW V'
                                || ' WHERE B.COD_TIPDIRECCION = ' || LV_CODTIPDIRECCION
                                || ' AND  B.COD_DIRECCION = C.COD_DIRECCION(+)'
                                || ' AND C.COD_PROVINCIA = D.COD_PROVINCIA(+)'
                                || ' AND C.COD_CIUDAD = E.COD_CIUDAD(+)'
                                || ' AND C.COD_REGION=D.COD_REGION(+)'

                                || ' AND C.COD_REGION = F.COD_REGION(+)'
                                || ' AND C.COD_COMUNA = G.COD_COMUNA(+)'

                                --|| ' AND V.COD_DOMINIO = ''' || 'TIPOS_CALLES' || ''''
                                || ' AND C.COD_TIPOCALLE = V.VALOR(+) '


                                || ' AND E.COD_REGION=C.COD_REGION'
                                || ' AND E.COD_PROVINCIA=C.COD_PROVINCIA'
                                || ' AND B.COD_USUARIO IN (SELECT X.COD_USUARIO'
                                || '           FROM ' || CV_TABABONADO || ' X '
                                || '          WHERE X.NUM_ABONADO = ' || EV_numAbonado || ')'
                                || ' ) B'
                                || ' WHERE A.COD_USUARIO = B.COD_USUARIO(+)'
                                || ' AND A.COD_USUARIO IN (SELECT X.COD_USUARIO'
                                || '         FROM ' || CV_TABABONADO || ' X '
                                || '        WHERE X.NUM_ABONADO = ' || EV_numAbonado || ')';


                        EXECUTE IMMEDIATE LV_Sql INTO   SV_nomUsuario   ,
                                                                                        SV_nomApell1    ,
                                                                                        SV_nomApell2    ,
                                                                                        SV_tipIdentif   ,
                                                                                        SV_numIdentif   ,
                                                                                        SV_codProvincia ,
                                                                                        SV_nomProvincia ,
                                                                                        SV_codCiudad    ,
                                                                                        SV_nomCiudad    ,
                                                                                        SV_Direccion    ,
                                                                                        SV_Observacion  ,
                                                                                        SV_fecNacimiento,
                                                                                        SV_Sexo         ,
                                                                                        SV_codEstrato   ,
                                                                                        SV_Mail         ,
                                                                                    SV_COD_REGION   ,
                                                                                    SV_DES_REGION   ,
                                                                                    SV_COD_COMUNA   ,
                                                                                    SV_DES_COMUNA   ,
                                                                                    SV_COD_TIPOCALLE,
                                                                                    SV_DES_TIPOCALLE;

                         IF SN_cod_retorno<>0 THEN
                                 RAISE ERROR_PLS;
                         END IF;

                EXCEPTION
                         WHEN ERROR_PLS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PROCEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN NO_DATA_FOUND THEN
                                 SN_cod_retorno:=218;
                         SV_mens_retorno:='No existe informacion para este Abonado';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PROCEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                  VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PROCEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getListUsuario_PR;

        PROCEDURE VE_getCliente2_PR(EV_codCliente   IN VARCHAR2,
                                   EV_TipIdentif    IN VARCHAR2,
                                   EV_numIdentif    IN VARCHAR2,
                                   EV_TipoCliente   IN VARCHAR2,
                                   EV_telefono      IN GE_CLIENTES.TEF_CLIENTE1%TYPE,
                                   EV_Nombre1       IN GE_CLIENTES.NOM_CLIENTE%TYPE,
                                   EV_Apellido1     IN GE_CLIENTES.NOM_APECLIEN1%TYPE,
                                   EV_Apellido2     IN GE_CLIENTES.NOM_APECLIEN2%TYPE,
                                   EV_nomEmpresa    IN GE_CLIENTES.NOM_EMPRESA%TYPE,
                                   SC_cursordatos   OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getCliente_PR"
                        Lenguaje="PL/SQL"
                        Fecha="30-07-2007"
                        Versión="1.0.0"
                        Diseñador="nrca"
                        Programador="nrca"
                        Ambiente="BD"
                <Retorno>
                                  datos cliente
                </Retorno>
                <Descripción>
                                  datos cliente segun codigo
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_codCliente" Tipo="STRING"> codigo del cliente </param>
                         </Entrada>
                 <Salida>
                           <param nom="SC_cursordatos"   Tipo="CURSOR"> CURSOR QUE OBTIENE DATOS DE CLIENTE</param>

                           <param nom="SN_cod_retorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(16) := 'VE_getCliente_PR';

            ERROR_PARAMETRO       EXCEPTION;
        ERROR_CLIENTE         EXCEPTION;
                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
                LV_Count    NUMBER(9);
                LV_COD_CLIENTE_ULT GE_CLIENTES.COD_CLIENTE%TYPE;
                LV_COUNT_CLI     NUMBER(10);
                --Agregado para manejar excepciones
        LV_codRetorno  ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.desevent;
                LV_FechaUltimoCliente Varchar2(20);
                LV_NUM_ABONADO  GA_ABOCEL.NUM_ABONADO%TYPE;
                LB_and       BOOLEAN;
        --fin
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LB_and  := FALSE;

                IF (EV_codCliente IS NOT NULL) THEN
                -- Buscamos  cliente por codigo


                        SELECT COUNT(1)
                        INTO LV_Count
                        FROM GE_CLIENTES
                        WHERE COD_CLIENTE=EV_codCliente;


                        LV_Sql:='SELECT a.cod_cliente,'
                               || ' a.nom_cliente,'
                               || ' a.nom_apeclien1,'
                               || ' a.nom_apeclien2,'
                               || ' a.cod_tipident,'
                               || ' a.num_ident,'
                               || ' a.tef_cliente1,'
                               || ' a.nom_email,'
                               || ' a.fec_nacimien,'
                               || ' b.des_valor,'
                               || ' a.cod_crediticia,'
                               || ' d.MTO_PREAUTO,'
                               || ' a.cod_calificacion,'
                               || ' a.cod_tipo,'
                               || ' c.des_tipident,'
                               || ' e.des_color'
                               || ' ,f.des_segmento'
                               || ' ,a.nom_empresa'
                               || ' ,a.imp_ingresos'
                               || ' FROM ge_clientes a, ged_codigos b, GE_TIPIDENT c,GE_MTOPREAUTOCLI_TO d'
                               || ', GE_COLOR_TD E '
                               || ', GE_SEGMENTACION_CLIENTES_TD F '
                               || ' WHERE a.cod_cliente = ' || EV_codCliente;
                               IF EV_TipoCliente IS NOT NULL THEN
                                  LV_Sql:= LV_Sql || ' AND a.COD_TIPO=''' || EV_TipoCliente || '''';
                               END IF;
                               LV_Sql:= LV_Sql || ' AND b.COD_VALOR=a.cod_tipo'
                               || ' AND b.cod_modulo(+)=''GE'''
                               || ' AND b.nom_tabla=''GE_CLIENTES'''
                               || ' AND b.nom_columna=''COD_TIPO'''
                               || ' AND a.cod_cliente = d.cod_cliente(+)'
                               || ' AND c.cod_tipident = a.cod_tipident'
                               || ' AND e.COD_color(+)=a.cod_color'
                               || ' AND a.cod_segmento=f.COD_SEGMENTO(+)'
                               || ' AND a.cod_tipo=f.cod_tipo(+)';

                              -- || ' AND a.cod_cliente not in (SELECT NVL(COD_CLIENTE,0) FROM VE_VENDEDORES)';

                ELSE
                -- Buscamos cliente por numero de identificacion

                        LV_Sql:='SELECT a.cod_cliente,'
                               || ' a.nom_cliente,'
                                   || ' a.nom_apeclien1,'
                                   || ' a.nom_apeclien2,'
                                   || ' a.cod_tipident,'
                                   || ' a.num_ident,'
                                   || ' a.tef_cliente1,'
                                   || ' a.nom_email,'
                                   || ' a.fec_nacimien,'
                                   || ' b.des_valor,'
                                   || ' a.cod_crediticia,'
                                   || ' d.MTO_PREAUTO,'
                                   || ' a.cod_calificacion,'
                                   || ' a.cod_tipo,'
                                   || ' c.des_tipident'
                                   || ' ,e.des_color'
                                   || ' ,f.des_segmento'
                                   || ' ,a.nom_empresa'
                                   || ' ,a.imp_ingresos'
                                   || ' FROM ge_clientes a, ged_codigos b, GE_TIPIDENT c, GE_MTOPREAUTOCLI_TO d'
                                   || ', GE_color_td E '
                                   || ', GE_SEGMENTACION_CLIENTES_TD F '
                                   || 'WHERE';

                                      IF EV_TipIdentif IS NOT NULL THEN
                                          IF (LB_and = FALSE) THEN
                                              LV_Sql:= LV_Sql || ' a.cod_tipident=''' || EV_TipIdentif || '''';
                                              LB_and  := TRUE;
                                          ELSE
                                              LV_Sql:= LV_Sql ||  ' AND  a.cod_tipident=''' || EV_TipIdentif || '''';
                                          END IF;
                                      END IF;


                                     IF EV_numIdentif IS NOT NULL THEN
                                        IF (LB_and = FALSE) THEN
                                            LV_Sql:= LV_Sql || ' a.num_ident='''      || EV_numIdentif || '''';
                                            LB_and  := TRUE;
                                        ELSE
                                            LV_Sql:= LV_Sql || ' AND a.num_ident='''      || EV_numIdentif || '''';
                                        END IF;
                                     END IF;



                                     IF EV_TipoCliente IS NOT NULL THEN

                                        IF (LB_and = FALSE) THEN
                                            LV_Sql:= LV_Sql || ' a.COD_TIPO=''' || EV_TipoCliente || '''';
                                            LB_and  := TRUE;
                                        ELSE
                                            LV_Sql:= LV_Sql || ' AND a.COD_TIPO=''' || EV_TipoCliente || '''';
                                        END IF;
                                     END IF;

                                      IF EV_Nombre1 IS NOT NULL THEN
                                         IF (LB_and = FALSE) THEN
                                             LV_Sql:= LV_Sql || ' a.NOM_CLIENTE LIKE ''%' || EV_Nombre1 || '%''';
                                             LB_and  := TRUE;
                                        ELSE
                                             LV_Sql:= LV_Sql || ' AND  a.NOM_CLIENTE LIKE ''%' || EV_Nombre1 || '%''';
                                        END IF;
                                      END IF;


                                      IF EV_Apellido1 IS NOT NULL THEN
                                         IF (LB_and = FALSE) THEN
                                             LV_Sql:= LV_Sql || ' a.NOM_APECLIEN1 LIKE ''' || EV_Apellido1 || '%''';
                                             LB_and  := TRUE;
                                        ELSE
                                             LV_Sql:= LV_Sql || ' AND  a.NOM_APECLIEN1 LIKE ''' || EV_Apellido1 || '%''';
                                        END IF;
                                      END IF;

                                      IF EV_Apellido2 IS NOT NULL THEN
                                         IF (LB_and = FALSE) THEN
                                             LV_Sql:= LV_Sql || ' a.NOM_APECLIEN2 LIKE ''' || EV_Apellido2 || '%''';
                                             LB_and  := TRUE;
                                        ELSE
                                             LV_Sql:= LV_Sql || ' AND  a.NOM_APECLIEN2 LIKE ''' || EV_Apellido2 || '%''';
                                        END IF;
                                      END IF;

                                      IF EV_nomEmpresa IS NOT NULL THEN
                                           IF (LB_and = FALSE) THEN
                                             LV_Sql:= LV_Sql || ' a.NOM_CLIENTE LIKE ''%' || EV_nomEmpresa || '%''';
                                             LB_and  := TRUE;
                                        ELSE
                                            LV_Sql:= LV_Sql || ' AND  a.NOM_CLIENTE LIKE ''%' || EV_nomEmpresa || '%''';

                                        END IF;
                                      END IF;

                                      IF EV_telefono IS NOT NULL THEN
                                         IF (LB_and = FALSE) THEN
                                             LV_Sql:= LV_Sql || ' a.TEF_CLIENTE1 = ''' || EV_telefono || '''';
                                             LB_and  := TRUE;
                                        ELSE
                                             LV_Sql:= LV_Sql || ' AND  a.TEF_CLIENTE1 = ''' || EV_telefono || '''';
                                        END IF;
                                      END IF;

                                   LV_Sql:= LV_Sql || ' AND b.COD_VALOR=a.cod_tipo'
                                   || ' AND b.cod_modulo=''GE'''
                                   || ' AND b.nom_tabla=''GE_CLIENTES'''
                                   || ' AND b.nom_columna=''COD_TIPO'''
                                   || ' AND e.COD_color(+)=a.cod_color'
                                   --|| ' AND e.cod_modulo(+)=''GE'''
                                   --|| ' AND e.nom_tabla(+)=''GE_CLIENTES'''
                                   --|| ' AND e.nom_columna(+)=''COD_COLOR'''
                                   || ' AND a.cod_cliente = d.cod_cliente(+)'
                                   || ' AND c.cod_tipident = a.cod_tipident'
                                   || ' AND a.cod_segmento=f.COD_SEGMENTO(+)'
                                   || ' AND a.cod_tipo=f.cod_tipo(+)'
                                   || ' AND ROWNUM<=50';
                                  -- || ' AND a.cod_cliente not in (SELECT NVL(COD_CLIENTE,0) FROM VE_VENDEDORES)';
                END IF;


                OPEN SC_cursordatos FOR LV_Sql;


        EXCEPTION
                        WHEN ERROR_PARAMETRO THEN
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN NO_DATA_FOUND THEN
                             SN_cod_retorno:=225;
                         SV_mens_retorno:='Codigo de Cliente no definido en SCL';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN ERROR_CLIENTE THEN
                             SN_cod_retorno:=149;
                         SV_mens_retorno:='Numero de Identificación posee varios clientes asociados';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getCliente2_PR;

        PROCEDURE VE_getNumMesesTipContrato_PR(EV_tipContrato  IN VARCHAR2,
                                           SN_valor        OUT NOCOPY VARCHAR2,
                                                                       SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getNumMesesTipContrato_PR"
                        Lenguaje="PL/SQL"
                        Fecha="25-09-2007"
                        Versión="1.0.0"
                        Diseñador="wjrc"
                        Programador="wjrc"
                        Ambiente="BD"
                <Retorno>
                                  Numero de meses segun tipo de contrato
                </Retorno>
                <Descripción>
                                  Numero de meses segun tipo de contrato
                </Descripción>
                <Parámetros>
                 <Entrada>
                           <param nom="EV_tipContrato" Tipo="STRING"> tipo contrato </param>
                         </Entrada>
                 <Salida>
                           <param nom="SV_valor"        Tipo="STRING"> numero de meses </param>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(28) := 'VE_getNumMesesTipContrato_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql:= 'SELECT a.num_meses'
                      || ' FROM ga_percontrato a'
                      || ' WHERE a.cod_tipcontrato = ' || EV_tipContrato
                      || ' AND a.cod_producto = ' || VE_intermediario_PG.CN_PRODUCTO;

                SELECT a.num_meses
                INTO SN_valor
                FROM ga_percontrato a
                WHERE a.cod_tipcontrato = EV_tipContrato
                  AND a.cod_producto = VE_intermediario_PG.CN_PRODUCTO;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getNumMesesTipContrato_PR;


        PROCEDURE VE_getTipContrato_PR    (SC_cursordatos    OUT NOCOPY REFCURSOR,
                                                                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS


                /*
                <Documentación TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_getTipContrato_PR
                        Lenguaje="PL/SQL"
                        Fecha="21-02-2008"
                        Versión="1.0.0"
                        Diseñador="NRCA"
                        Programador="NRCA"
                        Ambiente="BD"
                <Retorno>
                                  Rescata los datos del Contrato
                </Retorno>
                <Descripción>
                                  Rescata los datos del Contrato
                </Descripción>
                <Parámetros>
                 <Entrada>
                         </Entrada>
                 <Salida>
                           <param nom="SC_cursordatos"  Tipo="CURSOR"> Datos del Contrato</param>
                           <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                   <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                   <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
                         </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
                */
            CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(28) := 'VE_getTipContrato_PR';

                LV_desError ge_errores_pg.desevent;
                LV_sql          ge_errores_pg.vquery;
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LV_Sql:= 'SELECT COD_TIPCONTRATO,DES_TIPCONTRATO,DECODE(CANAL_VTA,0,''INTERNO'',''1'',''EXTERNO'',''AMBOS''),NVL(MESES_MINIMO,0)'
                || ' FROM GA_TIPCONTRATO'
                || ' WHERE COD_PRODUCTO= ' || VE_intermediario_PG.CN_PRODUCTO
                || ' AND IND_CONTCEL=''V'''
                || ' AND IND_CONTSEG=''P'''
                || ' AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE)';


                OPEN SC_cursordatos FOR LV_Sql;

        EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                                 VE_intermediario_PG.VE_NotDataFound_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                         WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
END VE_getTipContrato_PR;

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
                 VALIDA SERIES EXTERNAS
                                 1. Valida formato de serie con ge_vluhn
                                 2. Valida repeticion con ve_validarepeticiongsm_pr
                                 3. Valida series negativas con pv_series_negativas_pg --> P_valida_robadas
                                 Retorna
                                 Codigo 0.- no hay error
                                 Codigo 1.- Numero de serie incorrecto
                                 Codigo 2.- Serie esta repetida más de lo permitido (parametro NUM_REPETICION_IMEI ged_parametros)
                                 Codigo 3.- Serie Robada
                                 Codigo 4.- Error general
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
CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(30) := 'VE_VALIDA_SERIE_GSM_PR';
CN_TIPOPROCESO        CONSTANT NUMBER       := 1;

ERROR_PROCEDIMIENTO         EXCEPTION;
ERROR_SERIE_INCORRECTA      EXCEPTION;
ERROR_SERIE_REPETIDA        EXCEPTION;
ERROR_SERIE_ROBADA          EXCEPTION;
LV_cadena         VARCHAR(200);
LV_des_error      ge_errores_pg.desevent;
LV_sql                ge_errores_pg.vquery;
LN_transaccion GA_TRANSACABO.num_transaccion%TYPE;
--Agregado para manejar excepciones
       LV_codRetorno  ge_errores_pg.coderror;
       LV_mens_retorno ge_errores_pg.desevent;
--fin

BEGIN
             SN_cod_retorno  := 0;
             SV_mens_retorno := NULL;
             SN_num_evento   := 0;
             -- obtener numero de transaccion
                 LV_Sql := 'VE_INTERMEDIARIO_PG.VE_obtiene_secuencia_PR('||'''GA_SEQ_TRANSACABO'''||','||LN_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                 VE_INTERMEDIARIO_PG.VE_obtiene_secuencia_PR('GA_SEQ_TRANSACABO',LN_transaccion,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                 IF (SN_cod_retorno <> 0) THEN
                        RAISE ERROR_PROCEDIMIENTO;
                 END IF;


                 LV_Sql := 'P_VALIDA_SERIE_GSM('||LN_transaccion||','||EV_NumSerie||')';
                 P_VALIDA_SERIE_GSM (LN_transaccion, EV_NumSerie);

                 -- verificamos estado del llamado
                LV_Sql := 'VE_INTERMEDIARIO_PG.VE_obtiene_transaccion_PR('||LN_transaccion||','||SN_cod_retorno||','||SV_mens_retorno||','||SN_num_evento||')';
                VE_INTERMEDIARIO_PG.VE_obtiene_transaccion_PR(LN_transaccion, SN_cod_retorno, SV_mens_retorno, SN_num_evento);

                LV_cadena:=SV_mens_retorno;

                    IF (SN_cod_retorno = 1) THEN
                            SN_cod_retorno  := 4;
                                RAISE ERROR_SERIE_INCORRECTA;
                        END IF;

                        IF (SN_cod_retorno = 2) THEN
                            SN_cod_retorno  := 4;
                                RAISE ERROR_SERIE_REPETIDA;
                        END IF;

                        IF (SN_cod_retorno = 3) THEN
                            SN_cod_retorno := 4;
                                RAISE ERROR_SERIE_ROBADA;
                        END IF;



--                               Codigo 1.- Numero de serie incorrecto
--                               Codigo 2.- Serie esta repetida más de lo permitido (parametro NUM_REPETICION_IMEI ged_parametros)
--                               Codigo 3.- Serie Robada
EXCEPTION

                WHEN ERROR_SERIE_INCORRECTA THEN
                     SN_num_evento   := 0;
                         SN_cod_retorno:=820;
                     SV_mens_retorno:='Formato de serie incorrecto';
                         VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);

                WHEN ERROR_SERIE_REPETIDA THEN
                     SN_num_evento   := 0;
                     SN_cod_retorno:=760;
                     SV_mens_retorno:='Existe una serie asociada a más de un abonado en estado alta activa abonado';
                         VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);

                WHEN ERROR_SERIE_ROBADA THEN
                     SN_num_evento   := 0;
                     SN_cod_retorno:=473;
                     SV_mens_retorno:='IMEI se encuentra en listas negras';
                         VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);

                WHEN ERROR_PROCEDIMIENTO THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                WHEN OTHERS THEN
                         VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

END VE_VALIDA_SERIE_GSM_PR;


PROCEDURE VE_obtiene_SS_Tercen_PR(  EV_CodActabo    IN  GA_ACTABO.COD_ACTABO%TYPE,
                                    EV_CodPlanServ  IN  GA_PLANSERV.COD_PLANSERV%TYPE,
                                    EV_TECNOLOGIA   IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                    SC_cursordatos  OUT NOCOPY TC_cursorDatosSS,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento) IS
                /*--
                <Documentacion TipoDoc = "Procedimiento">
                        Elemento Nombre = "VE_obtiene_SSabo_nocent_PR"
                        Lenguaje="PL/SQL"
                        Fecha="14-10-2007"
                        Version="1.0.0"
                        Dise?ador="Retorna SS Default por centrales"
                        Programador="Héctor Hermosilla"
                        Ambiente="BD"
                <Retorno>NA</Retorno>
                <Descripcion>
                        Recupera cadena de ss y nivel del abonado informado
                </Descripcion>
                <Parametros>
                <Entrada>
                        <param nom="EN_numabonado"   Tipo="NUMBER> numero de abonado </param>
                        <param nom="EN_indestado"    Tipo="NUMBER> indicador estado</param>
                        <param nom="EV_codProducto"  Tipo="STRING"> codigo producto </param>
                        <param nom="EV_codModulo"    Tipo="STRING"> codigo modulo </param>
                        <param nom="EV_codSistema    Tipo="STRING"> codigo sistema </param>
                        <param nom="EV_codActuacion" Tipo="STRING"> codigo actuacion centrales </param>
                </Entrada>
                <Salida>
                        <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con nivel y servicio asociado al abonado</param>
                        <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                        <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                        <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
                </Salida>
                </Parametros>
                </Elemento>
                </Documentacion>
                --*/
                LE_exception_fin         EXCEPTION;
                no_data_found_cursor EXCEPTION;
        DAT_cursordatos  REFCURSOR;
                CN_LARGOSUBSTRING    CONSTANT NUMBER  := 6;
                CC_CHAR                  CONSTANT CHAR    := ' ';

                LA_arreglo           VE_intermediario_PG.tipoArray := VE_intermediario_PG.tipoArray();

                LV_des_error         ge_errores_pg.DesEvent;
                LV_sSql              ge_errores_pg.vQuery;

                LN_CONTADOR          BINARY_INTEGER := 0;
                LN_indice            NUMBER;
                LV_ValParametro      VARCHAR2(20);
                LV_cadenaServicio    VARCHAR2(1000);
                LV_condicion         VARCHAR2(1000);
                LC_char1             CHAR;
                LV_Actuacion         GA_ACTABO.COD_ACTCEN%TYPE;
                LV_COD_SERVICIO        GA_SERVSUPL.COD_SERVICIO%TYPE;
            LV_COD_SERVSUPL        GA_SERVSUPL.COD_SERVSUPL%TYPE;
            LV_DES_SERVICIO        GA_SERVSUPL.DES_SERVICIO%TYPE;
            LV_COD_NIVEL           GA_SERVSUPL.COD_NIVEL%TYPE;
            LV_IND_DEFAULT         VARCHAR2(40);
            LV_IMP_TARIFA_CONEXION GA_TARIFAS.IMP_TARIFA%TYPE;
            LV_DES_MONEDA_CONEXION GE_MONEDAS.DES_MONEDA%TYPE;
            LV_IMP_TARIFA_MENSUAL  GA_TARIFAS.IMP_TARIFA%TYPE;
            LV_DES_MONEDA_MENSUAL  GE_MONEDAS.DES_MONEDA%TYPE;
            LV_TIP_TERMINAL ICG_ACTUACIONTERCEN.TIP_TERMINAL%TYPE;
            LV_IND_IP GA_SERVSUPL.IND_IP%TYPE;
            LV_TIP_COBRO GA_SERVSUPL.TIP_COBRO%TYPE;
            LV_TIP_RED GA_SERVSUPL.TIP_RED%TYPE;
        BEGIN
                SN_cod_retorno:=0;
                SV_mens_retorno:='';
                SN_num_evento:= 0;

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;


                SELECT COD_ACTCEN
                INTO LV_Actuacion
                FROM GA_ACTABO
                WHERE COD_ACTABO=EV_CodActabo
                AND COD_TECNOLOGIA=EV_TECNOLOGIA;

                IF EV_TECNOLOGIA='GSM' THEN
                   LV_TIP_TERMINAL:='G';
                ELSIF EV_TECNOLOGIA='FIJO' THEN
                   LV_TIP_TERMINAL:='F';
                ELSE
                   LV_TIP_TERMINAL:='D';
                END IF;




                -- BUSCA CADENA DE SERVICIOS POR DEFECTO A CENTRALES
                LV_cadenaServicio := '';



                BEGIN

                SELECT NVL(a.cod_servicios,'')
                INTO LV_cadenaServicio
                FROM ICG_ACTUACIONTERCEN a
                WHERE a.cod_producto = 1
                AND a.tip_terminal = LV_TIP_TERMINAL
                AND a.cod_sistema = 1
                AND a.cod_actuacion = LV_Actuacion;

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                    LV_cadenaServicio:='';
                END;



                IF (LV_cadenaServicio = '' OR LV_cadenaServicio IS NULL) THEN
                        LV_cadenaServicio := '';
                        SELECT cod_servicio
                        INTO LV_cadenaServicio
                        FROM ICG_ACTUACION
                        WHERE cod_actuacion = LV_Actuacion
                        AND cod_producto = 1
                        AND cod_modulo = 'GA';
                END IF;

                LA_arreglo := VE_intermediario_PG.VE_descompone_cadena_FN(LV_cadenaServicio,
                                                                          CN_LARGOSUBSTRING,
                                                                                                                      SN_cod_retorno,
                                                                                                                      SV_mens_retorno,
                                                                                                                      SN_num_evento);

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;

        LV_condicion := '(';
                FOR LN_indice IN 1..LA_arreglo.COUNT LOOP
            LV_condicion := LV_condicion || '''' || LA_arreglo(LN_indice) || ''',';
                END LOOP;

        LV_condicion := SUBSTR(LV_condicion,1,LENGTH(LV_condicion)-1) || ')';

                IF (SN_cod_retorno <> 0) THEN
                        RAISE LE_exception_fin;
                END IF;



--              SELECT A.COD_SERVICIO, A.COD_SERVSUPL, A.DES_SERVICIO, A.COD_NIVEL,'|| ''''|| 'NO DEFAULT'||'''';
--          LV_CADENA := LV_CADENA || ',G.IMP_TARIFA AS CARGO_CONEXION ,M.DES_MONEDA AS MONEDA_CONEXION, FA.IMP_TARIFA AS TARIFA_MENSUAL, M.DES_MONEDA AS MONEDA_MENSUAL';



                 LV_sSql := 'SELECT A.COD_SERVICIO, A.COD_SERVSUPL, A.DES_SERVICIO, A.COD_NIVEL,'|| ''''|| 'DEFAULT'||'''';
         LV_sSql := LV_sSql || ' ,C.IMP_TARIFA, D.DES_MONEDA,';
         LV_sSql := LV_sSql || ' F.IMP_TARIFA, G.DES_MONEDA,A.IND_IP,A.TIP_COBRO,A.TIP_RED';
         LV_sSql := LV_sSql || ' FROM GA_SERVSUPL A, GA_ACTUASERV B, GA_TARIFAS C, GE_MONEDAS D,';
         LV_sSql := LV_sSql || ' GA_ACTUASERV E, GA_TARIFAS F, GE_MONEDAS G';
         LV_sSql := LV_sSql || ' WHERE A.COD_PRODUCTO =1 ';
         LV_sSql := LV_sSql || ' AND A.IND_COMERC=1';
         LV_sSql := LV_sSql || ' AND A.TIP_SERVICIO =''1''';
                 LV_sSql := LV_sSql || ' AND replace(TO_CHAR(a.cod_servsupl,''09'')||';
                 LV_sSql := LV_sSql || ' TO_CHAR(a.cod_nivel, ''0999''),''' || CC_CHAR || ''','''') ';
                 LV_sSql := LV_sSql || ' IN' || LV_condicion;
         LV_sSql := LV_sSql || ' AND A.COD_PRODUCTO = B.COD_PRODUCTO(+)';
         LV_sSql := LV_sSql || ' AND A.COD_SERVICIO = B.COD_SERVICIO(+)';
         LV_sSql := LV_sSql || ' AND B.COD_ACTABO(+) = ''' || EV_CodActabo || '''' ;
         LV_sSql := LV_sSql || ' AND B.COD_TIPSERV(+) = 2';
         LV_sSql := LV_sSql || ' AND B.COD_PRODUCTO = C.COD_PRODUCTO(+)';
         LV_sSql := LV_sSql || ' AND B.COD_ACTABO = C.COD_ACTABO(+)';
         LV_sSql := LV_sSql || ' AND B.COD_TIPSERV = C.COD_TIPSERV(+)';
         LV_sSql := LV_sSql || ' AND B.COD_SERVICIO = C.COD_SERVICIO(+)';
         LV_sSql := LV_sSql || ' AND C.COD_PLANSERV(+) =''' ||   EV_CodPlanServ || ''''  ;
         LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE)';
         LV_sSql := LV_sSql || ' AND C.COD_MONEDA = D.COD_MONEDA(+)';
         LV_sSql := LV_sSql || ' AND A.COD_PRODUCTO = E.COD_PRODUCTO(+)';
         LV_sSql := LV_sSql || ' AND A.COD_SERVICIO = E.COD_SERVICIO(+)';
         LV_sSql := LV_sSql || ' AND E.COD_ACTABO(+) = ''FA''';
         LV_sSql := LV_sSql || ' AND E.COD_TIPSERV(+) =2';
         LV_sSql := LV_sSql || ' AND E.COD_PRODUCTO = F.COD_PRODUCTO(+)';
         LV_sSql := LV_sSql || ' AND E.COD_ACTABO = F.COD_ACTABO(+)';
         LV_sSql := LV_sSql || ' AND E.COD_TIPSERV = F.COD_TIPSERV(+)';
         LV_sSql := LV_sSql || ' AND E.COD_SERVICIO = F.COD_SERVICIO(+)';
         LV_sSql := LV_sSql || ' AND F.COD_PLANSERV(+) = ''' ||   EV_CodPlanServ || '''';
         LV_sSql := LV_sSql || ' AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE) ';
         LV_sSql := LV_sSql || ' AND F.COD_MONEDA = G.COD_MONEDA(+)';

                OPEN DAT_cursordatos FOR LV_sSql;
                LOOP
                  FETCH DAT_cursordatos
                  INTO LV_COD_SERVICIO,
                       LV_COD_SERVSUPL,
                           LV_DES_SERVICIO,
                           LV_COD_NIVEL,
                           LV_IND_DEFAULT,
                           LV_IMP_TARIFA_CONEXION,
                           LV_DES_MONEDA_CONEXION,
                           LV_IMP_TARIFA_MENSUAL,
                           LV_DES_MONEDA_MENSUAL,
                           LV_IND_IP,
                           LV_TIP_COBRO,
                           LV_TIP_RED;
                  EXIT WHEN DAT_cursordatos%NOTFOUND;

                        SC_cursordatos(LN_CONTADOR).T_COD_SERVICIO:= LV_COD_SERVICIO;
                        SC_cursordatos(LN_CONTADOR).T_COD_SERVSUPL:= LV_COD_SERVSUPL;
                        SC_cursordatos(LN_CONTADOR).T_DES_SERVICIO:= LV_DES_SERVICIO;
                        SC_cursordatos(LN_CONTADOR).T_COD_NIVEL   := LV_COD_NIVEL;
                        SC_cursordatos(LN_CONTADOR).T_IND_DEFAULT := LV_IND_DEFAULT;
                        SC_cursordatos(LN_CONTADOR).T_IMP_TARIFA_CONEXION:= LV_IMP_TARIFA_CONEXION;
                        SC_cursordatos(LN_CONTADOR).T_DES_MONEDA_CONEXION:= LV_DES_MONEDA_CONEXION;
                        SC_cursordatos(LN_CONTADOR).T_IMP_TARIFA_MENSUAL := LV_IMP_TARIFA_MENSUAL;
                        SC_cursordatos(LN_CONTADOR).T_DES_MONEDA_MENSUAL := LV_DES_MONEDA_MENSUAL;
                        SC_cursordatos(LN_CONTADOR).T_IND_IP := LV_IND_IP;
                        SC_cursordatos(LN_CONTADOR).T_TIP_COBRO:=LV_TIP_COBRO;
                        SC_cursordatos(LN_CONTADOR).T_TIP_RED:=LV_TIP_RED;
                        LN_CONTADOR := LN_CONTADOR + 1;
                        iCantRegistros := iCantRegistros + 1;
                END LOOP;

                -- CERRAMOS EL CURSOR
                CLOSE DAT_cursordatos;
EXCEPTION
                WHEN LE_exception_fin THEN
                LV_des_error:='LE_exception_fin: Ve_Servs_ActivacionesWeb_Pg.VE_obtiene_SSabo_nocent_PR;- ' || SQLERRM;
                SN_num_evento:=Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, '1.0', USER,
                'Ve_Servs_ActivacionesWeb_Pg.VE_obtiene_SSabo_nocent_PR', LV_sSql, SQLCODE, LV_des_error );
                WHEN no_data_found_cursor THEN
                    SN_cod_retorno:=0;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasIF;
            END IF;
            LV_des_error := SUBSTR('no_data_found_cursor:Ve_Servs_ActivacionesWeb_Pg.VE_obtiene_SSabo_nocent_PR; - '|| SQLERRM,1,CN_largoerrtec);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
            SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                        'Ve_Servs_ActivacionesWeb_Pg.VE_obtiene_SSabo_nocent_PR', LV_sSql, SN_cod_retorno, LV_des_error );
                WHEN OTHERS THEN
                    SN_cod_retorno:=4;
                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := CV_error_no_clasIF;
            END IF;
            LV_des_error := SUBSTR('OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_obtiene_SSabo_nocent_PR; - '|| SQLERRM,1,CN_largoerrtec);
            SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
                        'Ve_Servs_ActivacionesWeb_Pg.VE_obtiene_SSabo_nocent_PR', LV_sSql, SN_cod_retorno, LV_des_error );
        END VE_obtiene_SS_Tercen_PR;

-----------------------------------------------------------------------------------------

PROCEDURE VE_VALIDA_DIRECCION_PR (
   EV_CodRegion      IN   GE_REGIONES.COD_REGION%TYPE,       --Varchar2(3)
   EV_CodProvincia   IN   GE_PROVINCIAS.COD_PROVINCIA%TYPE,  --Varchar2(5)
   EV_CodCiudad      IN   GE_CIUDADES.COD_CIUDAD%TYPE, --Varchar2(3)
   EV_CodComuna      IN   GE_COMUNAS.COD_COMUNA%TYPE, --VARCHAR2(3)
   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
/*
<Documentación TipoDoc = "PROCEDIMIENTO">
        Elemento Nombre = "VE_VALIDA_DIRECCION_PR"
        Lenguaje="PL/SQL"
        Fecha="11-04-2008"
        Versión="1.0"
        Diseñador="NRCA"
        Programador="NRCA"
        Ambiente="BD"
<Retorno>
</Retorno>
<Descripción>
        Valida que la direcciones existan en SCL y no se entreguen valores NULOS
</Descripción>
<Parámetros>
        <Entrada>
                <param nom="EV_CodRegion"   Tipo="STRING"> Codigo Region </param>
                <param nom="EV_CodProvincia" Tipo="STRING"> Codigo Provincia </param>
                <param nom="EV_CodCiudad"   Tipo="STRING"> Codigo Ciudad </param>
                                <param nom="EV_CodComuna"   Tipo="STRING"> Codigo Comuna </param>
        </Entrada>
        <Salida>
                <param nom="SN_codRetorno" Tipo="NUMBER"> Codigo de retorno del procedimiento </param>
                <param nom="SV_menRetorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                <param nom="SN_numEvento"  Tipo="NUMBER"> Numero de evento en caso de error en ejecucion </param>
        </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
AS
         error_validacion  EXCEPTION;
         error_ejecucion   EXCEPTION;
         error_direccion   EXCEPTION;
         LV_des_error     ge_errores_pg.desevent;
         LV_sql                   ge_errores_pg.vquery;
         ER_sector        rUBICACION_DIR;
         LN_coddirAct      NUMBER(20);
         LN_coddirNew      NUMBER(20);
         LV_codofi         ga_exp_oficina.COD_OFICINA%TYPE;

BEGIN

         -- region
         IF EV_CodRegion IS NOT NULL THEN
            LV_Sql := 'VE_valida_existe_en_SCL_FN(''GE_REGIONES'',''COD_REGION'','
                                                       || EV_CodRegion || ','
                                                                                           || '...)';

                        IF NOT VE_valida_existe_en_SCL_FN('GE_REGIONES',
                                                  'COD_REGION',
                                                                                      EV_CodRegion,
                                                                                          NULL,
                                                      SN_cod_Retorno,
                                                                      SV_mens_retorno,
                                                                      SN_num_evento) THEN
                                IF (SN_cod_Retorno = 0) THEN
                           SN_cod_retorno := CN_ERROR_VALIDAREGION;
                                END IF;
                        RAISE error_validacion;
                        END IF;
                END IF;

            -- provincia
            IF EV_CodProvincia IS NOT NULL THEN
                        LV_Sql := 'VE_valida_existe_en_SCL_FN(''GE_PROVINCIAS'',''COD_PROVINCIA'','
                                                              || EV_CodProvincia || ','
                                                                                                  || '...)';

                        IF NOT VE_valida_existe_en_SCL_FN('GE_PROVINCIAS',
                                                  'COD_PROVINCIA',
                                                                                      EV_CodProvincia,
                                                                                          NULL,
                                                      SN_cod_Retorno,
                                                                      SV_mens_retorno,
                                                                      SN_num_evento) THEN
                                IF (SN_cod_Retorno = 0) THEN
                           SN_cod_retorno := CN_ERROR_VALIDAPROVINCIA;
                                END IF;
                        RAISE error_validacion;
                        END IF;
                END IF;

            -- ciudad
            IF EV_CodCiudad IS NOT NULL THEN
                        LV_Sql := 'VE_valida_existe_en_SCL_FN(''GE_CIUDADES'',''COD_CIUDAD'','
                                                              || EV_CodCiudad || ','
                                                                                                  || '...)';

                        IF NOT VE_valida_existe_en_SCL_FN('GE_CIUDADES',
                                                  'COD_CIUDAD',
                                                                                      EV_CodCiudad,
                                                                                          NULL,
                                                      SN_cod_Retorno,
                                                                      SV_mens_retorno,
                                                                      SN_num_evento) THEN
                                IF (SN_cod_Retorno = 0) THEN
                           SN_cod_retorno := CN_ERROR_VALIDACIUDAD;
                                END IF;
                        RAISE error_validacion;
                        END IF;
                END IF;

            -- comuna
            IF EV_CodComuna IS NOT NULL THEN
                        LV_Sql := 'VE_valida_existe_en_SCL_FN(''GE_COMUNAS'',''COD_COMUNA'','
                                                              || EV_CodComuna || ','
                                                                                                  || '...)';

                        IF NOT VE_valida_existe_en_SCL_FN('GE_COMUNAS',
                                                  'COD_COMUNA',
                                                                                      EV_CodComuna,
                                                                                          NULL,
                                                      SN_cod_Retorno,
                                                                      SV_mens_retorno,
                                                                      SN_num_evento) THEN
                                IF (SN_cod_Retorno = 0) THEN
                           SN_cod_retorno := CN_ERROR_VALIDACOMUNA;
                                END IF;
                        RAISE error_validacion;
                        END IF;
                END IF;

            -- region,provincia, y/o ciudad o comuna
            IF (EV_CodRegion IS NOT NULL) AND
                   ((EV_CodProvincia IS  NULL) OR
                    (EV_CodCiudad IS NULL) OR
                        (EV_CodComuna IS NULL)) THEN
                SN_cod_retorno := CN_ERROR_EJECUCION;
                SV_mens_retorno := CV_ERROR_REGPROCOMCIUFDA;
                        RAISE error_direccion;
                END IF;

            IF (EV_CodProvincia IS NOT NULL) AND
                   ((EV_CodRegion IS  NULL) OR
                    (EV_CodCiudad IS NULL) OR
                        (EV_CodComuna IS NULL)) THEN
                SN_cod_retorno := CN_ERROR_EJECUCION;
                SV_mens_retorno := CV_ERROR_REGPROCOMCIUFDA;
                        RAISE error_direccion;
                END IF;

            IF (EV_CodCiudad IS NOT NULL) AND
                   ((EV_CodRegion IS  NULL) OR
                    (EV_CodProvincia IS NULL) OR
                        (EV_CodComuna IS NULL)) THEN
                SN_cod_retorno := CN_ERROR_EJECUCION;
                SV_mens_retorno := CV_ERROR_REGPROCOMCIUFDA;
                        RAISE error_direccion;
                END IF;

            IF (EV_CodComuna IS NOT NULL) AND
                   ((EV_CodRegion IS  NULL) OR
                    (EV_CodProvincia IS NULL) OR
                        (EV_CodCiudad IS NULL)) THEN
                SN_cod_retorno := CN_ERROR_EJECUCION;
                SV_mens_retorno := CV_ERROR_REGPROCOMCIUFDA;
                        RAISE error_direccion;
                END IF;

            -- region,provincia, y/o ciudad o comuna
            IF (EV_CodRegion IS NOT NULL)  AND
                   (EV_CodProvincia IS NOT NULL)  AND
                   (EV_CodCiudad IS NOT NULL OR EV_CodComuna IS NOT NULL) THEN
                        ER_sector := NULL;
                        ER_sector.COD_REGION    := EV_CodRegion;
                        ER_sector.COD_PROVINCIA := EV_CodProvincia;
                        ER_sector.COD_CIUDAD    := EV_CodCiudad;
                        ER_sector.COD_COMUNA    := EV_CodComuna;

                        LV_Sql := 'VE_valida_existe_relacion_FN(' || ER_sector.COD_REGION    || ','
                                                                                                          || ER_sector.COD_PROVINCIA || ','
                                                                                                          || ER_sector.COD_CIUDAD    || ','
                                                                                                          || ER_sector.COD_COMUNA    || ','
                                                                                                          || '...)';

                        IF NOT VE_valida_existe_relacion_FN(ER_sector,
                                                        SN_cod_Retorno,
                                                                        SV_mens_retorno,
                                                                        SN_num_evento) THEN
                   SN_cod_retorno := CN_ERROR_EJECUCION;
                           SV_mens_retorno := CV_ERROR_REGPROCOMCIUNOK;
                                   RAISE error_direccion;
                        END IF;
                END IF;

EXCEPTION
    WHEN error_direccion THEN
        LV_des_error   := 'error_direccion:Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR;- ' || SQLERRM;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR',
                LV_Sql, SQLCODE, LV_des_error);
    WHEN error_validacion THEN
        LV_des_error   := 'error_validacion:Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR',
                LV_Sql, SQLCODE, LV_des_error);
    WHEN error_ejecucion THEN
        LV_des_error   := 'error_ejecucion:Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR',
                LV_Sql, SQLCODE, LV_des_error);
        WHEN OTHERS THEN
        SN_cod_retorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_VALIDA_DIRECCION_PR',
                LV_Sql, SQLCODE, LV_des_error);


END VE_VALIDA_DIRECCION_PR;
PROCEDURE VE_OBTIENE_DATOS_PAGARE_PR (
   EN_NUMVENTA        IN  GA_VENTAS.NUM_VENTA%TYPE,
   --Valores Pagare Equipo CON IVA
   SN_IMP_EQUIPO      OUT NOCOPY NUMBER,
   SV_DINERO_LETRAS_EQ   OUT NOCOPY VARCHAR2,
   SV_DECIMAL_LETRAS_EQ  OUT NOCOPY VARCHAR2,
   --Valores del Pagare Limite consumo SIN IVA
   SN_IMP_LIM      OUT NOCOPY NUMBER,
   SV_DINERO_LETRAS_LIM   OUT NOCOPY VARCHAR2,
   SV_DECIMAL_LETRAS_LIM  OUT NOCOPY VARCHAR2,
   --Valores unicos del reporte
   SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
   SV_GLOSA_DIR       OUT NOCOPY VARCHAR2,
   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)



AS
         LV_sql                   ge_errores_pg.vquery;
         LV_des_error             ge_errores_pg.desevent;
         LV_CodCliente            GE_CLIENTES.COD_CLIENTE%TYPE;
         LV_DIRECCION             GA_DIRECCLI.COD_DIRECCION%TYPE;
         LV_IMEI                  GA_ABOCEL.NUM_IMEI%TYPE;
         LV_SUMA_EQUIPO           NUMBER(30);
         LV_PRECIO_EQUIPO         NUMBER(30);
         LV_PRECIO_EQUIPO_IMP     NUMBER(30);
         LV_COD_OFICINA           GA_VENTAS.COD_OFICINA%TYPE;
         LV_COD_CONCEPTO          FA_CONCEPTOS.COD_CONCEPTO%TYPE;
         LV_COD_ARTICULO          AL_ARTICULOS.COD_ARTICULO%TYPE;


CURSOR CursorEquipos IS
                SELECT NVL(PRC_VENTA, 0),COD_ARTICULO
                FROM GA_EQUIPABOSER
                WHERE NUM_SERIE IN (
                                    SELECT NVL (NUM_IMEI, NUM_SERIE)
                                    FROM GA_ABOCEL
                                    WHERE NUM_VENTA = EN_NUMVENTA
                                    AND COD_MODVENTA IN (SELECT COD_MODVENTA
                                                         FROM GE_MODVENTA
                                                         WHERE IND_CUOTAS = 1));


BEGIN
       LV_PRECIO_EQUIPO:=0;
       LV_SUMA_EQUIPO:=0;

       SELECT COD_CLIENTE,COD_OFICINA
       INTO LV_CodCliente,LV_COD_OFICINA
       FROM GA_VENTAS
       WHERE NUM_VENTA=EN_NUMVENTA;


       OPEN CursorEquipos;

       LOOP
            FETCH CursorEquipos
					INTO LV_PRECIO_EQUIPO,LV_COD_ARTICULO;
					EXIT WHEN CursorEquipos%NOTFOUND;


                    SELECT COD_CONCEPTOART
                    INTO LV_COD_CONCEPTO
                    FROM AL_ARTICULOS
                    WHERE COD_ARTICULO=LV_COD_ARTICULO;


                   SELECT
                   FA_SERVICIOS_FACTURACION_PG.FA_getImpuesto_FN(LV_CodCliente,LV_COD_OFICINA,LV_PRECIO_EQUIPO,LV_COD_CONCEPTO)
                   INTO LV_PRECIO_EQUIPO_IMP
                   FROM DUAL;

                   LV_SUMA_EQUIPO:= LV_SUMA_EQUIPO + LV_PRECIO_EQUIPO_IMP;
       END LOOP;

       CLOSE CursorEquipos;


        --Dinero en letras, Dinero en Decimales
        SELECT PR_MONTO_ESCRITO.mto_escrito(LV_SUMA_EQUIPO,2)
        INTO SV_DINERO_LETRAS_EQ
        FROM DUAL; --Número solo

        IF LV_SUMA_EQUIPO =0 THEN
            SV_DINERO_LETRAS_EQ:='CERO';
        END IF;
        SELECT PR_MONTO_ESCRITO.mto_escrito(LV_SUMA_EQUIPO,3)
        INTO SV_DECIMAL_LETRAS_EQ
        FROM DUAL; --Numero con decimales


        SN_IMP_EQUIPO:=LV_SUMA_EQUIPO;
       ---------------------------------------------------------------

        --Suma Limite


        SELECT NVL(SUM(IMP_LIMCONS),0)
        INTO SN_IMP_LIM
        FROM GA_LCABO_TO
        WHERE NUM_ABONADO
        IN (SELECT NUM_ABONADO FROM GA_ABOCEL WHERE NUM_VENTA=EN_NUMVENTA);

        --Dinero en letras, Dinero en Decimales
        SELECT PR_MONTO_ESCRITO.mto_escrito(SN_IMP_LIM,2)
        INTO SV_DINERO_LETRAS_LIM
        FROM DUAL; --Número solo

        IF SN_IMP_LIM =0 THEN
            SV_DINERO_LETRAS_LIM:='CERO';
        END IF;
        SELECT PR_MONTO_ESCRITO.mto_escrito(SN_IMP_LIM,3)
        INTO SV_DECIMAL_LETRAS_LIM
        FROM DUAL; --Numero con decimales

        -------------------------------------------------------------------------

        --Datos Generales del Cliente

        --Nombre del Cliente

        SELECT A.NOM_CLIENTE || ' ' || A.NOM_APECLIEN1 || ' ' || A.NOM_APECLIEN2
        INTO SV_NOM_CLIENTE
        FROM GE_CLIENTES A
        WHERE A.COD_CLIENTE=LV_CodCliente;

        SELECT COD_DIRECCION
        INTO LV_DIRECCION
        FROM GA_DIRECCLI
        WHERE COD_CLIENTE=LV_CodCliente
        AND COD_TIPDIRECCION=1;

        --Domicilio

        select 'COL ' || c.DES_DIREC1 || ' ' || c.NOM_CALLE || ' ' || c.NUM_CALLE ||  ' ' || d.DES_PROVINCIA || ' ' || a.DES_REGION
        INTO SV_GLOSA_DIR
        from ge_regiones a,ge_direcciones c,ge_provincias d , ge_ciudades e
        where a.COD_REGION=c.COD_REGION
        and c.COD_REGION=d.COD_REGION
        and c.COD_PROVINCIA=d.COD_PROVINCIA
        and e.COD_ciudad=c.COD_CIUDAD
        and e.cod_provincia=c.cod_provincia
        and cod_direccion=LV_DIRECCION;


EXCEPTION
        WHEN OTHERS THEN
        SN_cod_retorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_PAGARE_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_PAGARE_PR',
                LV_Sql, SQLCODE, LV_des_error);


END VE_OBTIENE_DATOS_PAGARE_PR;
PROCEDURE VE_OBTIENE_DATOS_FICHA_PR (
                                       EN_NUM_ABONADO     IN GA_ABOAMIST.NUM_ABONADO%TYPE,
                                       SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
                                       SD_FEC_NACIMIENTO   OUT NOCOPY GE_CLIENTES.FEC_NACIMIEN%TYPE,
                                       SV_PROFESION       OUT NOCOPY VARCHAR2,
                                       SV_TELEFONO        OUT NOCOPY GE_CLIENTES.TEF_CLIENTE1%TYPE,
                                       SV_GLOSA_DIR OUT NOCOPY VARCHAR2,
                                       SV_GLOSA_IDENT     OUT NOCOPY VARCHAR2,
                                       SV_COD_VENDEALER   OUT NOCOPY VE_VENDEALER.COD_VENDEALER%TYPE,
                                       SV_NOM_VENDEALER   OUT NOCOPY VE_VENDEALER.NOM_VENDEALER%TYPE,
                                       SV_DES_OFICINA     OUT NOCOPY GE_OFICINAS.DES_OFICINA%TYPE,
                                       SV_NOM_VENDEDOR    OUT NOCOPY VE_VENDEDORES.NOM_VENDEDOR%TYPE,
                                       SV_DESC_TERMINAL   OUT NOCOPY AL_ARTICULOS.DES_ARTICULO%TYPE,
                                       SV_ICC             OUT NOCOPY GA_ABOAMIST.NUM_SERIE%TYPE,
                                       SV_IMEI            OUT NOCOPY GA_ABOAMIST.NUM_IMEI%TYPE,
                                       SV_NOM_USUARORA    OUT NOCOPY GA_ABOAMIST.NOM_USUARORA%TYPE,
                                       SN_NUM_CELULAR     OUT NOCOPY GA_ABOAMIST.NUM_CELULAR%TYPE,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

AS
   LV_sql                   ge_errores_pg.vquery;
   LV_des_error             ge_errores_pg.desevent;
   LV_CodCliente            GE_CLIENTES.COD_CLIENTE%TYPE;
   LV_DIRECCION             GA_DIRECCLI.COD_DIRECCION%TYPE;
   LV_COD_PROFESION         GE_CLIENTES.COD_PROFESION%TYPE;
   LN_NumVenta              GA_VENTAS.NUM_VENTA%TYPE;
   LV_COD_VENDEALER         GA_VENTAS.COD_VENDEALER%TYPE;
   LV_COD_VENDEDOR          GA_VENTAS.COD_VENDEDOR%TYPE;
   LV_COD_OCUPACION         GE_CLIENTES.COD_OCUPACION%TYPE;
   LV_DES_OCUPACION         GE_OCUPACIONES.DES_OCUPACION%TYPE;

BEGIN




        --Datos del Cliente

        SELECT COD_CLIENTE,NUM_VENTA,NUM_SERIE,NUM_IMEI,NOM_USUARORA,NUM_CELULAR
        INTO LV_CodCliente,LN_NumVenta,SV_ICC,SV_IMEI,SV_NOM_USUARORA,SN_NUM_CELULAR
        FROM GA_ABOAMIST
        WHERE NUM_ABONADO=EN_NUM_ABONADO;

        SELECT A.NOM_CLIENTE || ' ' || A.NOM_APECLIEN1 || ' ' || A.NOM_APECLIEN2,A.FEC_NACIMIEN,A.COD_PROFESION,A.TEF_CLIENTE1,A.COD_OCUPACION
        INTO SV_NOM_CLIENTE,SD_FEC_NACIMIENTO,LV_COD_PROFESION,SV_TELEFONO,LV_COD_OCUPACION
        FROM GE_CLIENTES A
        WHERE A.COD_CLIENTE=LV_CodCliente;


        IF LV_COD_PROFESION IS NOT NULL THEN
           SELECT DES_ACTIVIDAD
           INTO SV_PROFESION
           FROM GE_ACTIVIDADES
           WHERE COD_ACTIVIDAD=LV_COD_PROFESION;
        END IF;

        IF LV_COD_OCUPACION IS NOT NULL THEN
           SELECT DES_OCUPACION
           INTO LV_DES_OCUPACION
           FROM GE_OCUPACIONES
           WHERE COD_OCUPACION=LV_COD_OCUPACION;
        END IF;

        SV_PROFESION:= SV_PROFESION || ' ' || LV_DES_OCUPACION;

        SELECT B.DES_TIPIDENT || ' ' ||  A.NUM_IDENT
        INTO SV_GLOSA_IDENT
        FROM GE_CLIENTES A, GE_TIPIDENT B
        WHERE A.COD_TIPIDENT=B.COD_TIPIDENT
        AND A.COD_CLIENTE= LV_CodCliente;


        SELECT COD_DIRECCION
        INTO LV_DIRECCION
        FROM GA_DIRECCLI
        WHERE COD_CLIENTE=LV_CodCliente
        AND COD_TIPDIRECCION=2;

        --Domicilio

        select 'COL ' || c.DES_DIREC1 || ' ' || c.NOM_CALLE || ' ' || c.NUM_CALLE ||  ' ' || d.DES_PROVINCIA || ' ' || a.DES_REGION
        INTO SV_GLOSA_DIR
        from ge_regiones a,ge_direcciones c,ge_provincias d , ge_ciudades e
        where a.COD_REGION=c.COD_REGION
        and c.COD_REGION=d.COD_REGION
        and c.COD_PROVINCIA=d.COD_PROVINCIA
        and e.COD_ciudad=c.COD_CIUDAD
        and e.cod_provincia=c.cod_provincia
        and cod_direccion=LV_DIRECCION;


        --Datos Del Vendedor

        SELECT COD_VENDEDOR,COD_VENDEALER
        INTO   LV_COD_VENDEDOR,LV_COD_VENDEALER
        FROM GA_VENTAS
        WHERE NUM_VENTA=LN_NumVenta;

        IF LV_COD_VENDEALER IS NULL THEN
        --Si el Codigo de vendedor dealer es nulo se admiten los datos del vendedor interno
           SV_COD_VENDEALER:= LV_COD_VENDEDOR;
           --NOMBRE,OFICINA
           SELECT A.NOM_VENDEDOR, B.DES_OFICINA
           INTO SV_NOM_VENDEALER,SV_DES_OFICINA
           FROM VE_VENDEDORES A , GE_OFICINAS B
           WHERE A.COD_OFICINA=B.COD_OFICINA
           AND A.COD_VENDEDOR=LV_COD_VENDEDOR;

           SV_NOM_VENDEDOR:=SV_NOM_VENDEALER;
        ELSE
        --Si el codigo de vendedor dealer no es nulo se muestran tanto los datos del vendedor interno
        --como externo
          SV_COD_VENDEALER:= LV_COD_VENDEALER;


          BEGIN

          SELECT A.NOM_VENDEALER, B.DES_OFICINA
          INTO SV_NOM_VENDEALER,SV_DES_OFICINA
          FROM VE_VENDEALER A , GE_OFICINAS B
          WHERE A.COD_OFICINA=B.COD_OFICINA
          AND A.COD_VENDEALER=LV_COD_VENDEALER;

          EXCEPTION
          WHEN NO_DATA_FOUND THEN

              SELECT A.NOM_VENDEDOR, B.DES_OFICINA
              INTO SV_NOM_VENDEALER,SV_DES_OFICINA
              FROM VE_VENDEDORES A , GE_OFICINAS B
              WHERE A.COD_OFICINA=B.COD_OFICINA
              AND A.COD_VENDEDOR=LV_COD_VENDEDOR;

          END;



          SELECT A.NOM_VENDEDOR
          INTO   SV_NOM_VENDEDOR
          FROM   VE_VENDEDORES A
          WHERE  A.COD_VENDEDOR=LV_COD_VENDEDOR;
        END IF;

        --Datos del Equipo
        IF SV_IMEI IS NOT NULL THEN
           SELECT  DES_EQUIPO
           INTO    SV_DESC_TERMINAL
           FROM    GA_EQUIPABOSER
           WHERE NUM_SERIE=SV_IMEI
           AND ROWNUM=1;
        ELSE
           SELECT  DES_EQUIPO
           INTO    SV_DESC_TERMINAL
           FROM    GA_EQUIPABOSER
           WHERE NUM_SERIE=SV_ICC
           AND ROWNUM=1;
        END IF;


EXCEPTION
        WHEN OTHERS THEN
        SN_cod_retorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_SALBOD_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_SALBOD_PR',
                LV_Sql, SQLCODE, LV_des_error);


END VE_OBTIENE_DATOS_FICHA_PR;
PROCEDURE VE_OBTIENE_DATOS_SALBOD_PR (
                                       EN_NUM_VENTA       IN GA_VENTAS.NUM_VENTA%TYPE,
                                       SV_ESTADO_VENTA    OUT NOCOPY GA_VENTAS.IND_ESTVENTA%TYPE,
                                       SV_NOM_VENDEDOR        OUT NOCOPY VE_VENDEDORES.NOM_VENDEDOR%TYPE,
                                       SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
                                       SV_NOM_USUARORA    OUT NOCOPY GA_VENTAS.NOM_USUAR_VTA%TYPE,
                                       SC_cursorDatos     OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

AS
   LV_sql                   ge_errores_pg.vquery;
   LV_des_error             ge_errores_pg.desevent;
   LV_CodCliente            GE_CLIENTES.COD_CLIENTE%TYPE;
   LV_DIRECCION             GA_DIRECCLI.COD_DIRECCION%TYPE;
   LV_COD_PROFESION         GE_CLIENTES.COD_PROFESION%TYPE;
   LN_NumVenta              GA_VENTAS.NUM_VENTA%TYPE;
   LV_COD_VENDEALER         GA_VENTAS.COD_VENDEALER%TYPE;
   LV_COD_VENDEDOR          GA_VENTAS.COD_VENDEDOR%TYPE;
   LV_IND_ESTVENTA          GA_VENTAS.IND_ESTVENTA%TYPE;
   LV_CodTipo               GE_CLIENTES.COD_TIPO%TYPE;

BEGIN

        --INICIO
          --NUM_VENTA, IND_ESTVENTA,NOM_VENDEDOR,NOM_CLIENTE,NOM_USUARORA
          --DETALLE
            --TELEFONO IMEI, ICC, TERMINAL, BODEGA
          --FIN DETALLE
        --FIN INICIO


        SELECT IND_ESTVENTA, COD_CLIENTE, NOM_USUAR_VTA, COD_VENDEDOR
        INTO LV_IND_ESTVENTA,LV_CodCliente, SV_NOM_USUARORA, LV_COD_VENDEDOR
        FROM GA_VENTAS
        WHERE NUM_VENTA=EN_NUM_VENTA;

        BEGIN
            SELECT DES_VALOR
            INTO SV_ESTADO_VENTA
            FROM GED_CODIGOS
            WHERE NOM_TABLA='GA_VENTAS'
            AND NOM_COLUMNA='IND_ESTVENTA'
            AND COD_VALOR=LV_IND_ESTVENTA;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN
           SV_ESTADO_VENTA:='ESTADO NO DEFINIDO';
        END;


        SELECT COD_TIPO
        INTO LV_CodTipo
        FROM GE_CLIENTES
        WHERE COD_CLIENTE=LV_CodCliente;

        SELECT A.NOM_CLIENTE || ' ' || A.NOM_APECLIEN1 || ' ' || A.NOM_APECLIEN2
        INTO SV_NOM_CLIENTE
        FROM GE_CLIENTES A
        WHERE A.COD_CLIENTE=LV_CodCliente;

        SELECT A.NOM_VENDEDOR
        INTO SV_NOM_VENDEDOR
        FROM VE_VENDEDORES A
        WHERE A.COD_VENDEDOR=LV_COD_VENDEDOR;

        IF LV_CodTipo=3 THEN --Prepago

            OPEN SC_CURSORDATOS FOR
               SELECT
                    A.NUM_CELULAR, A.NUM_SERIE, A.NUM_IMEI, B.COD_BODEGA,
                    B.IND_PROCEQUI, B.COD_ARTICULO, c.DES_ARTICULO,
                    A.COD_PLANTARIF, d.DES_PLANTARIF
               FROM
                    GA_ABOAMIST A, GA_EQUIPABOSER B,
                    al_articulos c, TA_PLANTARIF d
               WHERE
                    A.NUM_IMEI(+)=B.NUM_SERIE
                    AND A.NUM_ABONADO=B.NUM_ABONADO
                    AND A.NUM_VENTA=EN_NUM_VENTA
                    AND B.COD_ARTICULO = c.COD_ARTICULO
                    AND A.COD_PLANTARIF = d.COD_PLANTARIF;
        ELSE

            OPEN SC_CURSORDATOS FOR
               SELECT
                    A.NUM_CELULAR, A.NUM_SERIE, A.NUM_IMEI, B.COD_BODEGA,
                    B.IND_PROCEQUI, B.COD_ARTICULO, c.DES_ARTICULO,
                    A.COD_PLANTARIF, d.DES_PLANTARIF
               FROM
                    GA_ABOCEL A, GA_EQUIPABOSER B,
                    al_articulos c, TA_PLANTARIF d
               WHERE
                    A.NUM_IMEI(+)=B.NUM_SERIE
                    AND A.NUM_ABONADO=B.NUM_ABONADO
                    AND A.NUM_VENTA=EN_NUM_VENTA
                    AND B.COD_ARTICULO = c.COD_ARTICULO
                    AND A.COD_PLANTARIF = d.COD_PLANTARIF;
        END IF;

EXCEPTION
        WHEN OTHERS THEN
        SN_cod_retorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_SALBOD_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_SALBOD_PR',
                LV_Sql, SQLCODE, LV_des_error);

END VE_OBTIENE_DATOS_SALBOD_PR;
PROCEDURE VE_OBTIENE_DATOS_CPST_PR (
                                       EN_NUM_VENTA       IN GA_VENTAS.NUM_VENTA%TYPE,
                                       SV_NOM_CLIENTE     OUT NOCOPY VARCHAR2,
                                       SV_TELEFONO        OUT NOCOPY GE_CLIENTES.TEF_CLIENTE1%TYPE,
                                       SV_PROFESION       OUT NOCOPY GE_ACTIVIDADES.DES_ACTIVIDAD%TYPE,
                                       SV_NUM_IDENT2      OUT NOCOPY GE_CLIENTES.NUM_IDENT2%TYPE,
                                       SV_GLOSA_DIR       OUT NOCOPY VARCHAR2,
                                       SV_NUM_IDENT       OUT NOCOPY GE_CLIENTES.NUM_IDENT%TYPE,
                                       SV_MODVENTA        OUT NOCOPY GE_MODVENTA.DES_MODVENTA%TYPE,
                                       SN_NUM_MESES       OUT NOCOPY GA_PERCONTRATO.NUM_MESES%TYPE,
                                       SV_REGISTRO_IVA    OUT NOCOPY FA_FACTDOCU_NOCICLO.NUM_FOLIO%TYPE,
                                       SC_cursorDatos     OUT NOCOPY REFCURSOR,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

AS
   LV_sql                   ge_errores_pg.vquery;
   LV_des_error             ge_errores_pg.desevent;
   LV_CodCliente            GE_CLIENTES.COD_CLIENTE%TYPE;
   LV_DIRECCION             GA_DIRECCLI.COD_DIRECCION%TYPE;
   LV_COD_PROFESION         GE_CLIENTES.COD_PROFESION%TYPE;
   LN_NumVenta              GA_VENTAS.NUM_VENTA%TYPE;
   LV_COD_VENDEALER         GA_VENTAS.COD_VENDEALER%TYPE;
   LV_COD_VENDEDOR          GA_VENTAS.COD_VENDEDOR%TYPE;
   LV_IND_ESTVENTA          GA_VENTAS.IND_ESTVENTA%TYPE;
   LV_CodTipo               GE_CLIENTES.COD_TIPO%TYPE;
   LV_COD_OCUPACION         GE_CLIENTES.COD_OCUPACION%TYPE;
   LV_DES_OCUPACION         GE_OCUPACIONES.DES_OCUPACION%TYPE;
   LV_COD_MODVENTA          GA_VENTAS.COD_MODVENTA%TYPE;
   LV_COD_TIPCONTRATO       GA_VENTAS.COD_TIPCONTRATO%TYPE;
BEGIN

--INICIO
    --Cliente Nombre de cliente (GE_CLIENTES)
    --DUI (GE_CLIENTES)
    --Glosa Direccion (CLIENTES)
    --NIT (Clientes)
    --Telefono (Clientes)
    --Profesion (GE_ACTIVIDADES)
    --Giro ()
        --INICIO DETALLE
          --Numero de Abonado --Variable
          --Número de Serie   -- Variable
          --Descripcion de Equipo --Variable
          --Modalidad de Venta --Unico
          --Descripcion Plan --Variable
          --Cargo Mensual (Ta_cARGOsBASICO) --Variable
          --Linea de Credito --Variable
          --Meses del Plan --Unico
          --Tarifa de Referencia (Valor referencia al minuto) --Variable
       --FIN DETALLE
--FIN INICIO

   BEGIN
        SELECT NUM_FOLIO
        INTO SV_REGISTRO_IVA
        FROM FA_FACTDOCU_NOCICLO
        WHERE NUM_VENTA=EN_NUM_VENTA;
   EXCEPTION
        WHEN NO_DATA_FOUND THEN
             SV_REGISTRO_IVA:='0';
             NULL;
   END;

        SELECT COD_CLIENTE
        INTO   LV_CodCliente
        FROM GA_VENTAS
        WHERE NUM_VENTA=EN_NUM_VENTA;

        SELECT A.NOM_CLIENTE || ' ' || A.NOM_APECLIEN1 || ' ' || A.NOM_APECLIEN2,TEF_CLIENTE1,COD_PROFESION,COD_OCUPACION,NUM_IDENT,NUM_IDENT2
        INTO SV_NOM_CLIENTE,SV_TELEFONO,LV_COD_PROFESION,LV_COD_OCUPACION,SV_NUM_IDENT,SV_NUM_IDENT2
        FROM GE_CLIENTES A
        WHERE A.COD_CLIENTE=LV_CodCliente;

        SELECT COD_DIRECCION
        INTO LV_DIRECCION
        FROM GA_DIRECCLI
        WHERE COD_CLIENTE=LV_CodCliente
        AND COD_TIPDIRECCION=2;

        --Domicilio

        select 'COL ' || c.DES_DIREC1 || ' ' || c.NOM_CALLE || ' ' || c.NUM_CALLE ||  ' ' || d.DES_PROVINCIA || ' ' || a.DES_REGION
        INTO SV_GLOSA_DIR
        from ge_regiones a,ge_direcciones c,ge_provincias d , ge_ciudades e
        where a.COD_REGION=c.COD_REGION
        and c.COD_REGION=d.COD_REGION
        and c.COD_PROVINCIA=d.COD_PROVINCIA
        and c.COD_PROVINCIA=e.COD_PROVINCIA
        and e.COD_ciudad=c.COD_CIUDAD
        and c.cod_region=e.cod_region
        and e.cod_provincia=c.cod_provincia
        and cod_direccion=LV_DIRECCION;


         IF LV_COD_PROFESION IS NOT NULL THEN
           SELECT DES_ACTIVIDAD
           INTO SV_PROFESION
           FROM GE_ACTIVIDADES
           WHERE COD_ACTIVIDAD=LV_COD_PROFESION;
        END IF;

        IF LV_COD_OCUPACION IS NOT NULL THEN
           SELECT DES_OCUPACION
           INTO LV_DES_OCUPACION
           FROM GE_OCUPACIONES
           WHERE COD_OCUPACION=LV_COD_OCUPACION;
        END IF;

        SV_PROFESION:= SV_PROFESION || ' ' || LV_DES_OCUPACION;

        SELECT COD_MODVENTA, COD_TIPCONTRATO
        INTO LV_COD_MODVENTA,LV_COD_TIPCONTRATO
        FROM GA_VENTAS
        WHERE NUM_VENTA= EN_NUM_VENTA;

        --Modalidad de Venta
        SELECT DES_MODVENTA
        INTO SV_MODVENTA
        FROM GE_MODVENTA
        WHERE COD_MODVENTA= LV_COD_MODVENTA;

        --Meses del Plan
        SELECT NUM_MESES
        INTO  SN_NUM_MESES
        FROM GA_PERCONTRATO
        WHERE COD_TIPCONTRATO=LV_COD_TIPCONTRATO;

        OPEN SC_CURSORDATOS FOR
            SELECT A.NUM_ABONADO,NVL(A.NUM_IMEI,A.NUM_SERIE) SERIE,B.DES_EQUIPO,'(' || A.COD_PLANTARIF || ') ' || C.DES_PLANTARIF, D.IMP_CARGOBASICO,A.MTO_VALOR_REFERENCIA,B.PRC_VENTA,A.COD_PLANSERV,A.COD_USO, NVL(A.NUM_CELULAR,0)
            FROM GA_ABOCEL A,GA_EQUIPABOSER B, TA_PLANTARIF C, TA_CARGOSBASICO D
            WHERE
            (A.NUM_IMEI = B.NUM_SERIE)
            AND A.NUM_ABONADO=B.NUM_ABONADO
            AND A.COD_PLANTARIF=C.COD_PLANTARIF
            AND A.COD_CARGOBASICO=D.COD_CARGOBASICO
            AND SYSDATE BETWEEN D.FEC_DESDE AND D.FEC_HASTA
            AND A.COD_TECNOLOGIA  IN ('GSM')
            AND A.NUM_VENTA=EN_NUM_VENTA
            UNION
            SELECT A.NUM_ABONADO,NVL(A.NUM_IMEI,A.NUM_SERIE) SERIE,B.DES_EQUIPO,'(' || A.COD_PLANTARIF || ') ' || C.DES_PLANTARIF, D.IMP_CARGOBASICO,A.MTO_VALOR_REFERENCIA,B.PRC_VENTA,A.COD_PLANSERV,A.COD_USO, NVL(A.NUM_CELULAR,0)
            FROM GA_ABOCEL A,GA_EQUIPABOSER B, TA_PLANTARIF C, TA_CARGOSBASICO D
            WHERE
            (A.NUM_SERIE = B.NUM_SERIE(+))
            AND A.NUM_ABONADO=B.NUM_ABONADO(+)
            AND A.COD_PLANTARIF=C.COD_PLANTARIF
            AND A.COD_CARGOBASICO=D.COD_CARGOBASICO
            AND SYSDATE BETWEEN D.FEC_DESDE AND D.FEC_HASTA
            AND A.NUM_VENTA=EN_NUM_VENTA
            AND A.COD_TECNOLOGIA NOT IN ('GSM');

EXCEPTION
        WHEN OTHERS THEN
        SN_cod_retorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_CPST_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
                SV_mens_retorno, '1.0', USER, 'Ve_Servs_ActivacionesWeb_Pg.VE_OBTIENE_DATOS_CPST_PR',
                LV_Sql, SQLCODE, LV_des_error);

END VE_OBTIENE_DATOS_CPST_PR;
        PROCEDURE VE_getCuenta_PR (EV_codCuenta     IN GA_CUENTAS.COD_CUENTA%TYPE,
                                   EV_TipIdentif    IN GE_TIPIDENT.COD_TIPIDENT%TYPE,
                                   EV_numIdentif    IN GA_CUENTAS.NUM_IDENT%TYPE,
                                   EV_TipoCuenta    IN GA_CUENTAS.TIP_CUENTA%TYPE,
                                   EV_telefono      IN GA_CUENTAS.TEL_CONTACTO%TYPE,
                                   EV_NombreCuenta  IN GA_CUENTAS.DES_CUENTA%TYPE,
                                   EV_nombreResponsable GA_CUENTAS.NOM_RESPONSABLE%TYPE,
                                   SC_cursordatos   OUT NOCOPY REFCURSOR,
                                   SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento    OUT NOCOPY ge_errores_pg.Evento) IS


        CV_NOMBRE_PRODEDURE   CONSTANT VARCHAR2(16) := 'VE_getCuenta_PR';
        ERROR_PARAMETRO       EXCEPTION;
        ERROR_CLIENTE         EXCEPTION;
        LV_desError ge_errores_pg.desevent;
        LV_sql          ge_errores_pg.vquery;
        LV_Count    NUMBER(9);
        LV_COD_CLIENTE_ULT GE_CLIENTES.COD_CLIENTE%TYPE;
        LV_COUNT_CLI     NUMBER(10);
       --Agregado para manejar excepciones
        LV_codRetorno  ge_errores_pg.coderror;
        LV_mens_retorno ge_errores_pg.desevent;
                LV_FechaUltimoCliente Varchar2(20);
                LV_NUM_ABONADO  GA_ABOCEL.NUM_ABONADO%TYPE;
                LB_and       BOOLEAN;
        --fin
        BEGIN
                SN_cod_retorno := 0;
                SV_mens_retorno := NULL;
                SN_num_evento  := 0;

                LB_and  := FALSE;

                IF (EV_codCuenta IS NOT NULL) THEN
                -- Buscamos  cliente por codigo


                        SELECT COUNT(1)
                        INTO LV_Count
                        FROM GA_CUENTAS
                        WHERE COD_CUENTA=EV_codCuenta;

                        LV_Sql:='SELECT a.cod_cuenta,'
                               || ' a.cod_tipident,'
                               || ' a.num_ident,'
                               || ' a.tip_cuenta,'
                               || ' a.TEL_CONTACTO,'
                               || ' a.des_cuenta,'
                               || ' a.nom_responsable'
                               || ' FROM ga_cuentas a'
                               || ' WHERE a.cod_cuenta = ' || EV_codCuenta;
                               IF EV_TipoCuenta IS NOT NULL THEN
                                  LV_Sql:= LV_Sql || ' AND a.Tip_cuenta=''' || EV_TipoCuenta || '''';
                               END IF;
                ELSE
                -- Buscamos cuenta por numero de identificacion o por otro filtro
                    LV_Sql:='SELECT a.cod_cuenta,'
                             || ' a.cod_tipident,'
                             || ' a.num_ident,'
                             || ' a.tip_cuenta,'
                             || ' a.TEL_CONTACTO,'
                             || ' a.des_cuenta,'
                             || ' a.nom_responsable'
                             || ' FROM ga_cuentas a '
                             || 'WHERE ';

                             IF EV_TipIdentif IS NOT NULL THEN
                                IF (LB_and = FALSE) THEN
                                    LV_Sql:= LV_Sql || ' a.cod_tipident=''' || EV_TipIdentif || '''';
                                    LB_and  := TRUE;
                                ELSE
                                    LV_Sql:= LV_Sql ||  ' AND  a.cod_tipident=''' || EV_TipIdentif || '''';
                                END IF;
                             END IF;


                             IF EV_numIdentif IS NOT NULL THEN
                                IF (LB_and = FALSE) THEN
                                    LV_Sql:= LV_Sql || ' a.num_ident='''      || EV_numIdentif || '''';
                                    LB_and  := TRUE;
                                ELSE
                                    LV_Sql:= LV_Sql || ' AND a.num_ident='''      || EV_numIdentif || '''';
                                END IF;
                             END IF;


                             IF EV_TipoCuenta IS NOT NULL THEN
                                IF (LB_and = FALSE) THEN
                                    LV_Sql:= LV_Sql || ' a.TIP_CUENTA=''' || EV_TipoCuenta || '''';
                                    LB_and  := TRUE;
                                ELSE
                                    LV_Sql:= LV_Sql || ' AND a.TIP_CUENTA=''' || EV_TipoCuenta || '''';
                                END IF;
                             END IF;

                             IF EV_NombreCuenta IS NOT NULL THEN
                                IF (LB_and = FALSE) THEN
                                    LV_Sql:= LV_Sql || ' a.DES_CUENTA LIKE ''%' || EV_NombreCuenta || '%''';
                                    LB_and  := TRUE;
                                ELSE
                                    LV_Sql:= LV_Sql || ' AND  a.DES_CUENTA LIKE ''%' || EV_NombreCuenta || '%''';
                                END IF;
                             END IF;


                             IF EV_nombreResponsable IS NOT NULL THEN
                                IF (LB_and = FALSE) THEN
                                    LV_Sql:= LV_Sql || ' a.NOM_RESPONSABLE LIKE ''' || EV_nombreResponsable || '%''';
                                    LB_and  := TRUE;
                                ELSE
                                    LV_Sql:= LV_Sql || ' AND  a.NOM_RESPONSABLE LIKE ''' || EV_nombreResponsable || '%''';
                                END IF;
                             END IF;


                               IF EV_telefono IS NOT NULL THEN
                                  IF (LB_and = FALSE) THEN
                                      LV_Sql:= LV_Sql || ' a.TEL_CONTACTO = ''' || EV_telefono || '''';
                                      LB_and  := TRUE;
                                  ELSE
                                      LV_Sql:= LV_Sql || ' AND  a.TEL_CONTACTO = ''' || EV_telefono || '''';
                                  END IF;
                               END IF;

                             LV_Sql:= LV_Sql || ' AND ROWNUM<=50';





                                  -- || ' AND a.cod_cliente not in (SELECT NVL(COD_CLIENTE,0) FROM VE_VENDEDORES)';
                END IF;


                OPEN SC_cursordatos FOR LV_Sql;


        EXCEPTION
                        WHEN ERROR_PARAMETRO THEN
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN NO_DATA_FOUND THEN
                             SN_cod_retorno:=225;
                         SV_mens_retorno:='Cuenta no existente';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN ERROR_CLIENTE THEN
                             SN_cod_retorno:=149;
                         SV_mens_retorno:='Numero de Identificación posee varios clientes asociados';
                                 VE_utilitarios_pg.VE_RegistroDefault_Error_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,LV_codRetorno,LV_mens_retorno,SN_num_evento);
                        WHEN OTHERS THEN
                                 VE_intermediario_PG.VE_Others_PR(CV_NOMBRE_PACKAGE,CV_NOMBRE_PRODEDURE,LV_Sql,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        END VE_getCuenta_PR;
        
        
        PROCEDURE VE_existeAbonadoXSimcard_PR (
            en_num_serie        IN      GA_ABOCEL.NUM_SERIE%TYPE,
            en_existe          	OUT     NOCOPY INTEGER,
            SN_cod_retorno      OUT     NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno     OUT     NOCOPY ge_errores_pg.MsgError,
            SN_num_evento       OUT     NOCOPY ge_errores_pg.Evento
        ) IS
        
        LV_des_Error    ge_errores_pg.desevent;
        LV_sql          ge_errores_pg.vquery;
        LV_nombrePL     VARCHAR2(60);
        cntGA_ABOCEL	INTEGER;
        cntGA_ABOAMIST	INTEGER;
        
        BEGIN
        
            LV_nombrePL := CV_NOMBRE_PACKAGE || '.' || 'VE_existeAbonadoXSimcard_PR';  
            LV_sql := 'SELECT COUNT(1) INTO cntGA_ABOCEL FROM ga_abocel a WHERE a.num_serie = ' || en_num_serie || ' AND a.cod_situacion NOT IN (BAP, BAA)';
            SELECT COUNT(1) INTO cntGA_ABOCEL FROM ga_abocel a WHERE a.num_serie = en_num_serie AND a.cod_situacion NOT IN ('BAP', 'BAA');
                        
            LV_sql := 'SELECT COUNT(1) INTO cntGA_ABOAMIST FROM ga_ABOAMIST a WHERE a.num_serie = ' || en_num_serie || ' AND a.cod_situacion NOT IN (BAP, BAA)';
            SELECT COUNT(1) INTO cntGA_ABOAMIST FROM ga_ABOAMIST a WHERE a.num_serie = en_num_serie AND a.cod_situacion NOT IN ('BAP', 'BAA');
            
            en_existe := cntGA_ABOCEL + cntGA_ABOAMIST;
            
        EXCEPTION
            
            WHEN OTHERS THEN
                SN_cod_retorno := CN_ERROR_OTHERS;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno, SV_mens_retorno) THEN
                    SV_mens_retorno := CV_ERROR_NOCLASIF;
                END IF;
                LV_des_error   := 'OTHERS:'|| LV_nombrePL || '-' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl (SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER, LV_nombrePL, LV_Sql, SQLCODE, LV_des_error);
                                             
        END VE_existeAbonadoXSimcard_PR;
        
        PROCEDURE VE_existeAbonadoXImei_PR (
            en_num_imei         IN      GA_ABOCEL.NUM_IMEI%TYPE,
            en_existe           OUT     NOCOPY INTEGER,
            SN_cod_retorno      OUT     NOCOPY ge_errores_pg.CodError,
            SV_mens_retorno     OUT     NOCOPY ge_errores_pg.MsgError,
            SN_num_evento       OUT     NOCOPY ge_errores_pg.Evento
        ) IS
        
        LV_des_Error    ge_errores_pg.desevent;
        LV_sql          ge_errores_pg.vquery;
        LV_nombrePL     VARCHAR2(60);
        cntGA_ABOCEL	INTEGER;
        cntGA_ABOAMIST	INTEGER;
        
        BEGIN
        
            LV_nombrePL := CV_NOMBRE_PACKAGE || '.' || 'VE_existeAbonadoXImei_PR';  
            LV_sql := 'SELECT COUNT(1) INTO cntGA_ABOCEL FROM ga_abocel a WHERE a.num_imei = ' || en_num_imei  || ' AND a.cod_situacion NOT IN (BAP, BAA)';
            SELECT COUNT(1) INTO cntGA_ABOCEL FROM ga_abocel a WHERE a.num_imei = en_num_imei AND a.cod_situacion NOT IN ('BAP', 'BAA');
            
            LV_sql := 'SELECT COUNT(1) INTO cntGA_ABOAMIST FROM ga_ABOAMIST a WHERE a.num_imei = ' || en_num_imei  || ' AND a.cod_situacion NOT IN (BAP, BAA)';
            SELECT COUNT(1) INTO cntGA_ABOAMIST FROM ga_aboamist a WHERE a.num_imei = en_num_imei AND a.cod_situacion NOT IN ('BAP', 'BAA');
            
            en_existe := cntGA_ABOCEL + cntGA_ABOAMIST;
            
        EXCEPTION
            
            WHEN OTHERS THEN
                SN_cod_retorno := CN_ERROR_OTHERS;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno, SV_mens_retorno) THEN
                    SV_mens_retorno := CV_ERROR_NOCLASIF;
                END IF;
                LV_des_error   := 'OTHERS:'|| LV_nombrePL || '-' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl (SN_num_evento, CV_MODULO_GA, SV_mens_retorno, '1.0', USER, LV_nombrePL, LV_Sql, SQLCODE, LV_des_error);
                                             
        END VE_existeAbonadoXImei_PR;
        
       
END Ve_Servs_ActivacionesWeb_Pg; 
/

SHOW ERRORS
