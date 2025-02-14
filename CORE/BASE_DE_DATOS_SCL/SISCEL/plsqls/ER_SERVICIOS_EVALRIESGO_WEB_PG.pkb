CREATE OR REPLACE PACKAGE BODY ER_servicios_evalriesgo_web_PG IS

-------------------------------------------------------------------------------------------------------------------------------------------

        --------------------
        -- FUNCIONES      --
        --------------------

-------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION VE_cierre_solicitud_FN    (EN_numSolicitud              IN         ert_solicitud_planes.num_solicitud%TYPE,
                                    SN_codRetorno                OUT NOCOPY ge_errores_pg.CODERROR,
                                    SV_menRetorno                OUT NOCOPY ge_errores_pg.MSGERROR,
                                    SN_numEvento                 OUT NOCOPY ge_errores_pg.EVENTO)
                                    RETURN BOOLEAN
/*
<Documentación TipoDoc = "Funcion">
    Elemento Nombre = "VE_valida_en_gedcodigos_FN"
    Lenguaje="PL/SQL"
    Fecha="14-04-2008"
    Versión="1.0.0"
    Diseñador="wjrc"
    Programador="wjrc"
    Ambiente="BD"
<Retorno>
     valor string
</Retorno>
<Descripción>
     Retorna el valor del parametro
</Descripción>
<Parámetros>
   <Entrada>
      <param nom="EV_nomTabla"    Tipo="STRING"> Nombre de tabla </param>
      <param nom="EV_nomColumna"  Tipo="STRING"> Nombre de columna </param>
      <param nom="EV_modulo"      Tipo="STRING"> modulo </param>
      <param nom="EV_valor"       Tipo="STRING"> Valor a buscar</param>
   </Entrada>
   <Salida>
      <param nom="SN_cod_Retorno"  Tipo="NUMBER"> Codigo de retorno del procedimiento</param>
      <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento</param>
      <param nom="SN_num_evento"   Tipo="NUMBER"> Numero de evento en caso de error en ejecucion</param>
   </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
    LV_des_error    ge_errores_pg.desevent;
    LV_sql              ge_errores_pg.vquery;
    can_terminal NUMBER;
    can_vendidos NUMBER;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno  := NULL;
    SN_numEvento := 0;

    SELECT sum(a.val_cant_terminales), sum(a.val_cant_vendidos)
      INTO can_terminal, can_vendidos
      FROM ert_solicitud_planes a
     WHERE a.num_solicitud = EN_numSolicitud;

     IF (can_terminal = can_vendidos) THEN

            LV_Sql:= 'UPDATE ert_solicitud'
              || ' SET cod_estado = '|| 4
              || ' WHERE num_solicitud = '||EN_numSolicitud;

         UPDATE ert_solicitud
            SET cod_estado = 4
          WHERE num_solicitud = EN_numSolicitud;

     END IF;

     RETURN(TRUE);

EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
        SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',
        LV_Sql, SQLCODE, LV_des_error);
        RETURN(FALSE);
END VE_cierre_solicitud_FN;

-------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION VE_relaciona_solvta_FN(EN_numSolicitud IN  ert_solicitud_venta.num_solicitud%TYPE,
                                EN_numVenta     IN  ert_solicitud_venta.num_venta%TYPE,
                                SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO)
                                RETURN BOOLEAN
/*
<Documentación TipoDoc = "Funcion">
    Elemento Nombre = "VE_relaciona_solvta_FN"
    Lenguaje="PL/SQL"
    Fecha="18-05-2008"
    Versión="1.0.0"
    Diseñador="wjrc"
    Programador="wjrc"
    Ambiente="BD"
<Retorno>
     TRUE si la operacion fue exitosa
</Retorno>
<Descripción>
</Descripción>
<Parámetros>
   <Entrada>
      <param nom="EN_numSolicitud" Tipo="NUMBER"> Numero de solicitud </param>
      <param nom="EN_numVenta"     Tipo="NUMBER"> Numero de venta </param>
   </Entrada>
   <Salida>
      <param nom="SN_cod_Retorno"  Tipo="NUMBER"> Codigo de retorno del procedimiento</param>
      <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento</param>
      <param nom="SN_num_evento"   Tipo="NUMBER"> Numero de evento en caso de error en ejecucion</param>
   </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
    LV_des_error    ge_errores_pg.desevent;
    LV_sql          ge_errores_pg.vquery;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno  := NULL;
    SN_numEvento := 0;

        LV_Sql:= 'INSERT INTO ert_solicitud_venta'
        || ' (num_solicitud,num_venta)'
        || ' VALUES (' || EN_numSolicitud || ',' || EN_numVenta || ')';

        INSERT INTO ert_solicitud_venta
        (num_solicitud,num_venta)
        VALUES (EN_numSolicitud,EN_numVenta);

        RETURN(TRUE);

EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
        SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',
        LV_Sql, SQLCODE, LV_des_error);
        RETURN(FALSE);
END VE_relaciona_solvta_FN;

-------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION VE_valida_existe_en_SCL_FN(EV_Tabla        IN  VARCHAR2,
                                    EV_Columna      IN  VARCHAR2,
                                    EV_Valor_STR    IN  VARCHAR2,
                                    EV_Valor_NUM    IN  LONG,
                                    SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                    SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                    SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO)
                                    RETURN BOOLEAN
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
        LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_valida_existe_en_SCL_fn();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
        SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_valida_existe_en_SCL_fn',
        LV_sql, SQLCODE, LV_desError);
        RETURN(FALSE);
END VE_valida_existe_en_SCL_FN;

-------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION VE_valida_en_gedcodigos_FN(EV_nomTabla     IN ged_codigos.NOM_TABLA%TYPE,
                                    EV_nomColumna   IN ged_codigos.NOM_COLUMNA%TYPE,
                                    EV_modulo       IN ged_codigos.COD_MODULO%TYPE,
                                    EV_valor        IN ged_codigos.COD_VALOR%TYPE,
                                    SN_cod_Retorno  OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.Evento)
                                                                        RETURN BOOLEAN
/*
<Documentación TipoDoc = "Funcion">
    Elemento Nombre = "VE_valida_en_gedcodigos_FN"
    Lenguaje="PL/SQL"
    Fecha="14-04-2008"
    Versión="1.0.0"
    Diseñador="wjrc"
    Programador="wjrc"
    Ambiente="BD"
<Retorno>
    valor string
</Retorno>
<Descripción>
    Retorna el valor del parametro
</Descripción>
<Parámetros>
   <Entrada>
           <param nom="EV_nomTabla"    Tipo="STRING"> Nombre de tabla </param>
           <param nom="EV_nomColumna"  Tipo="STRING"> Nombre de columna </param>
           <param nom="EV_modulo"      Tipo="STRING"> modulo </param>
           <param nom="EV_valor"       Tipo="STRING"> Valor a buscar</param>
   </Entrada>
   <Salida>
           <param nom="SN_cod_Retorno"  Tipo="NUMBER"> Codigo de retorno del procedimiento</param>
           <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento</param>
           <param nom="SN_num_evento"   Tipo="NUMBER"> Numero de evento en caso de error en ejecucion</param>
   </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
    LV_des_error    ge_errores_pg.desevent;
    LV_sql              ge_errores_pg.vquery;
    LN_contador NUMBER;
BEGIN
    SN_cod_Retorno := 0;
    SV_mens_retorno := NULL;
    SN_num_evento := 0;

    LV_Sql :='SELECT COUNT(1)';
    LV_Sql := LV_Sql || ' FROM ged_codigos a';
    LV_Sql := LV_Sql || ' WHERE a.nom_tabla = ''' || EV_nomTabla || '''';
    LV_Sql := LV_Sql || '   AND a.nom_columna = ''' || EV_nomColumna || '''';
    LV_Sql := LV_Sql || '   AND a.cod_modulo = ''' || EV_modulo || '''';
    LV_Sql := LV_Sql || '   AND a.cod_valor = ''' || EV_valor || '''';

    EXECUTE IMMEDIATE LV_sql INTO LN_contador;

    IF (LN_contador > 0) THEN
       RETURN(TRUE);
    ELSE
       RETURN(FALSE);
    END IF;

EXCEPTION
     WHEN OTHERS THEN
        SN_cod_Retorno := CN_ERROR_OTHERS;
        LV_des_error   := 'OTHERS:VE_ACT_CLIENTEUSUARIO_PG.VE_valida_en_gedcodigos_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_Retorno,SV_mens_retorno) THEN
            SV_mens_retorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_MODULO_GA,
        SV_mens_retorno, '1.0', USER, 'VE_ACT_CLIENTEUSUARIO_PG.VE_valida_en_gedcodigos_FN',
        LV_Sql, SQLCODE, LV_des_error);
        RETURN(FALSE);
END VE_valida_en_gedcodigos_FN;

-------------------------------------------------------------------------------------------------------------------------------------------

        --------------------
        -- PROCEDIMIENTOS --
        --------------------

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_getExcepcion_PR(EV_codTipIdent  IN  erd_excepcion.COD_TIPIDENT%TYPE,
                             EV_numIdent     IN  erd_excepcion.NUM_IDENT%TYPE,
                             SN_codRestricc  OUT NOCOPY erd_excepcion.COD_RESTRIC%TYPE,
                             SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                             SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                             SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
   Elemento Nombre = 'ER_getExcepcion_PR'
   Lenguaje='PL/SQL'
   Fecha='10-04-2008'
   Versión='1.0.0'
   Diseñador='wjrc'
   Programador='wjrc'
   Ambiente='BD'
<Retorno>
   Retorna un number
</Retorno>
<Descripción>
   Retorna si existe excepcion para numero identificacion.
</Descripción>
<Parámetros>
   <Entrada>
      <param nom='EV_numIdent'    Tipo='STRING'> numero de identificacion </param>
      <param nom='EV_codTipIdent' Tipo='STRING'> codigo tipo identificador </param>
    </Entrada>
   <Salida>
      <param nom='SN_codRestricc' Tipo='NUMBER'> codigo de restriccion </param>
      <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
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

    LV_Sql := 'SELECT a.cod_restric '
            || ' FROM erd_excepcion a '
            || ' WHERE a.cod_tipident = ''' || EV_codTipIdent || ''''
            || ' AND a.num_ident = ''' || EV_numIdent || ''''
            || ' AND TRUNC(SYSDATE) BETWEEN a.fec_desde_h AND a.fec_hasta_h';

    BEGIN
        SELECT a.cod_restric
        INTO SN_codRestricc
        FROM erd_excepcion a
        WHERE a.cod_tipident = EV_codTipIdent
        AND a.num_ident = EV_numIdent
        AND TRUNC(SYSDATE) BETWEEN a.fec_desde_h AND a.fec_hasta_h;

    EXCEPTION
         WHEN NO_DATA_FOUND THEN
              SN_codRestricc := CN_NOHAYEXCEPCION;
              SN_codRetorno := CN_ERROR_NODATAFOUND;
              SV_menRetorno := CV_ERROR_NODATAFOUND;
    END;

EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := CN_ERROR_OTHERS;
        LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := CV_ERROR_NOCLASIF;
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
        SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR',
        LV_Sql, SQLCODE, LV_desError);
END ER_getExcepcion_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_getUltimaSolicitud_PR(EV_codTipIdentif    IN ert_solicitud.COD_TIPIDENT%TYPE,
                                   EV_numIdentif       IN ert_solicitud.NUM_IDENT_CLIENTE%TYPE,
                                   SN_numSolicitud     OUT NOCOPY ert_solicitud.NUM_SOLICITUD%TYPE,
                                   SN_estSolicitud     OUT NOCOPY ert_solicitud.COD_ESTADO%TYPE,
                                   SN_indTipoSolicitud OUT NOCOPY ert_solicitud.IND_TIPO_SOLICITUD%TYPE,
                                   SN_indEvento        OUT NOCOPY ert_solicitud.IND_EVENTO%TYPE,
                                   SN_codRetorno       OUT NOCOPY ge_errores_pg.CODERROR,
                                   SV_menRetorno           OUT NOCOPY ge_errores_pg.MSGERROR,
                                   SN_numEvento        OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getUltimaSolicitud_PR'
    Lenguaje='PL/SQL'
    Fecha='11-04-2008'
    Versión='1.0.0'
    Diseñador='wjrc'
    Programador='wjrc'
    Ambiente='BD'
<Retorno>
    Numero de solicitud
    Estado de la solicitud
    Tipo de solicitud
    Indicador de evento
</Retorno>
<Descripción>
    Retorna numero y estado de la ultima solicitud para un numero identificador
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EV_codTipIdentif'    Tipo='STRING'> Tipo identificador </param>
     <param nom='EV_numIdentif'       Tipo='STRING'> Numero identificador </param>
    </Entrada>
   <Salida>
     <param nom='SN_numSolicitud'     Tipo='NUMBER'> Numero de solicitud </param>
     <param nom='SN_estSolicitud'     Tipo='NUMBER'> Estado de solicitud </param>
     <param nom='SN_indTipoSolicitud' Tipo='NUMBER'> Tipo de solicitud </param>
     <param nom='SN_indEvento'        Tipo='NUMBER'> Tipo evento </param>
     <param nom='SN_codRetorno'           Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'       Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'        Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    no_data_found_cursor EXCEPTION;
    LV_desError  ge_errores_pg.desevent;
    LV_sql           ge_errores_pg.vquery;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql := 'SELECT s.num_solicitud,';
    LV_Sql := LV_Sql || ' s.cod_estado,';
    LV_Sql := LV_Sql || ' s.ind_tipo_solicitud,';
    LV_Sql := LV_Sql || ' s.ind_evento';
    LV_Sql := LV_Sql || ' FROM ert_solicitud s';
    LV_Sql := LV_Sql || ' WHERE s.num_solicitud IN (';
    LV_Sql := LV_Sql || '       SELECT MAX(a.num_solicitud)';
    LV_Sql := LV_Sql || '       FROM ert_solicitud a';
    LV_Sql := LV_Sql || '       WHERE a.cod_tipident = ''' || EV_codTipIdentif || '''';
    LV_Sql := LV_Sql || '         AND a.num_ident_cliente = ''' || EV_numIdentif || '''';
    LV_Sql := LV_Sql || ')';

    BEGIN
        SELECT s.num_solicitud,
               s.cod_estado,
               s.ind_tipo_solicitud,
               s.ind_evento
        INTO SN_numSolicitud,
             SN_estSolicitud,
             SN_indTipoSolicitud,
             SN_indEvento
        FROM ert_solicitud s
        WHERE s.num_solicitud IN (SELECT MAX(a.num_solicitud)
                                  FROM ert_solicitud a
                                  WHERE a.cod_tipident = EV_codTipIdentif
                                  AND a.num_ident_cliente = EV_numIdentif
                                  AND a.cod_estado IN (CN_ESTADOSOL_APROB1,CN_ESTADOSOL_APROB2,CN_ESTSOL_ENPROCVTA));
        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                  SN_codRetorno := CN_ERROR_NOEXSOLEVRIES;
                  SV_menRetorno := CV_ERROR_NOEXSOLEVRIES;
                              SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                      SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getUltimaSolicitud_PR',
                      LV_Sql, SQLCODE, LV_desError);
    END;

EXCEPTION
        WHEN OTHERS THEN
                        SN_codRetorno := CN_ERROR_OTHERS;
                        LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getUltimaSolicitud_PR;- ' || SQLERRM;
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                           SV_menRetorno := CV_ERROR_NOCLASIF;
                        END IF;
                        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                        SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getUltimaSolicitud_PR',
                        LV_Sql, SQLCODE, LV_desError);
END ER_getUltimaSolicitud_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_getSolicitud_PR(EN_numSolicitud     IN ert_solicitud.NUM_SOLICITUD%TYPE,
                             SV_codTipIdentif    OUT NOCOPY ert_solicitud.COD_TIPIDENT%TYPE,
                             SV_numIdentif       OUT NOCOPY ert_solicitud.NUM_IDENT_CLIENTE%TYPE,
                             SN_estSolicitud     OUT NOCOPY ert_solicitud.COD_ESTADO%TYPE,
                             SN_indTipoSolicitud OUT NOCOPY ert_solicitud.IND_TIPO_SOLICITUD%TYPE,
                             SN_indEvento        OUT NOCOPY ert_solicitud.IND_EVENTO%TYPE,
                             SN_codRetorno       OUT NOCOPY ge_errores_pg.CODERROR,
                             SV_menRetorno       OUT NOCOPY ge_errores_pg.MSGERROR,
                             SN_numEvento        OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getSolicitud_PR'
    Lenguaje='PL/SQL'
    Fecha='11-04-2008'
    Versión='1.0.0'
    Diseñador='wjrc'
    Programador='wjrc'
    Ambiente='BD'
<Retorno>
    Tipo identificador
    Numero identificador cliente
    Estado de la solicitud
    Tipo de solicitud
    Indicador evento
</Retorno>
<Descripción>
    Retorna datos de la solicitud
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EN_numSolicitud'     Tipo='NUMBER'> Numero de solicitud </param>
    </Entrada>
   <Salida>
     <param nom='SV_codTipIdentif'    Tipo='STRING'> Tipo identificador </param>
     <param nom='SV_numIdentif'       Tipo='STRING'> Numero identificador </param>
     <param nom='SN_estSolicitud'     Tipo='NUMBER'> Estado de solicitud </param>
     <param nom='SN_indTipoSolicitud' Tipo='NUMBER'> Tipo de solicitud </param>
     <param nom='SN_indEvento'        Tipo='NUMBER'> Tipo evento </param>
     <param nom='SN_codRetorno'           Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'       Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'        Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    no_data_found_cursor EXCEPTION;
    LV_desError          ge_errores_pg.desevent;
    LV_sql               ge_errores_pg.vquery;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql := 'SELECT s.cod_tipident,';
    LV_Sql := LV_Sql || ' s.num_ident_cliente,';
    LV_Sql := LV_Sql || ' s.cod_estado,';
    LV_Sql := LV_Sql || ' s.ind_tipo_solicitud,';
    LV_Sql := LV_Sql || ' s.ind_evento';
    LV_Sql := LV_Sql || ' FROM ert_solicitud s';
    LV_Sql := LV_Sql || ' WHERE s.num_solicitud = ' || EN_numSolicitud;

    SELECT s.cod_tipident,
           s.num_ident_cliente,
               s.cod_estado,
               s.ind_tipo_solicitud,
               s.ind_evento
    INTO SV_codTipIdentif,
         SV_numIdentif,
             SN_estSolicitud,
             SN_indTipoSolicitud,
             SN_indEvento
    FROM ert_solicitud s
    WHERE s.num_solicitud = EN_numSolicitud;

EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_codRetorno := CN_ERROR_NODATAFOUND;
          SV_menRetorno := CV_ERROR_NODATAFOUND;
          SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
          SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getSolicitud_PR',
          LV_Sql, SQLCODE, LV_desError);
     WHEN OTHERS THEN
                 SN_codRetorno := CN_ERROR_OTHERS;
         LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getSolicitud_PR;- ' || SQLERRM;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := CV_ERROR_NOCLASIF;
         END IF;
         SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
         SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getSolicitud_PR',
         LV_Sql, SQLCODE, LV_desError);
END ER_getSolicitud_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_getlistPlanTarifSolApro_PR(EV_codTipIdentif    IN ert_solicitud.COD_TIPIDENT%TYPE,
                                        EV_numIdentif       IN ert_solicitud.NUM_IDENT_CLIENTE%TYPE,
                                        EN_indEvento        IN ert_solicitud.IND_EVENTO%TYPE,
                                        EN_indTipoSolicitud IN ert_solicitud.IND_TIPO_SOLICITUD%TYPE,
                                        EV_tipProducto      IN ta_plantarif.COD_TIPLAN%TYPE,
                                        EV_tipPlanTarif     IN ta_plantarif.TIP_PLANTARIF%TYPE,
                                        SC_cursorDatos      OUT NOCOPY REFCURSOR,
                                        SN_codRetorno       OUT NOCOPY ge_errores_pg.CODERROR,
                                        SV_menRetorno       OUT NOCOPY ge_errores_pg.MSGERROR,
                                        SN_numEvento        OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getlistPlanTarifSolApro_PR'
    Lenguaje='PL/SQL'
    Fecha='11-04-2008'
    Versión='1.0.0'
    Diseñador='wjrc'
    Programador='wjrc'
    Ambiente='BD'
<Retorno>
    Cursor
</Retorno>
<Descripción>
    Retorna lista planes tarifario segun numero identificador y tipo de solicitud
    Solicitudes Aprobadas solamente
</Descripción>
<Parámetros>
    <Entrada>
      <param nom='EV_codTipIdentif'    Tipo='STRING'> Tipo identificador </param>
      <param nom='EV_numIdentif'       Tipo='STRING'> Numero identificador </param>
      <param nom='EN_indEvento'        Tipo='NUMBER'> Tipo evento </param>
      <param nom='EN_indTipoSolicitud' Tipo='NUMBER'> Tipo de solicitud </param>
      <param nom='EV_tipProducto'      Tipo='NUMBER'> Tipo de producto </param>
      <param nom='EV_tipPlan'          Tipo='STRING'> Tipo de plan </param>
     </Entrada>
    <Salida>
      <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
      <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
      <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
      <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
     </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    no_data_found_cursor EXCEPTION;
    LV_desError          ge_errores_pg.desevent;
    LV_sql               ge_errores_pg.vquery;
    LN_contador          NUMBER;
    EV_coduso            VARCHAR2(4000);
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql := 'SELECT COUNT(1)'
                    || ' FROM ert_solicitud_planes a,'
                    || '      ga_planuso b,'
                    || '      ta_plantarif p,'
                    || '      ert_solicitud s'
                    || ' WHERE s.cod_tipident = ''' || EV_codTipIdentif || ''''
                    || '   AND s.num_ident_cliente = ''' || EV_numIdentif || ''''
                    || '   AND s.ind_tipo_solicitud = ' || EN_indTipoSolicitud
                    || '   AND s.ind_evento = ' || EN_indEvento
                    || '   AND s.cod_estado IN (' || CN_ESTADOSOL_APROB1 || ',' || CN_ESTADOSOL_APROB2 ||')'
                    || '   AND a.num_solicitud = s.num_solicitud'
                    || '   AND a.val_cant_terminales > a.val_cant_vendidos'
                    || '   AND a.cod_plantarif = p.cod_plantarif'
                    || '   AND p.cod_producto = ' || CN_PRODUCTO
                    || '   AND p.cla_plantarif <> ''SRV'''
                    || '   AND p.cod_tiplan = ''' || EV_tipProducto || ''''
                    || '   AND p.tip_plantarif = ''' || EV_tipPlanTarif || ''''
                    || '   AND p.ind_comer_web = ' || CN_PLANCOMERVIAWEB
                    || '   AND p.cod_plantarif = b.cod_plantarif'
                    || '   AND p.cod_producto = b.cod_producto(+)';

    IF (EV_tipProducto = CN_CODUSO_POSTPAGO) THEN
            LV_Sql := LV_Sql || '   AND b.cod_uso = ' || CN_CODUSO_POSTPAGO ;
    ELSE
            LV_Sql := LV_Sql || '   AND b.cod_uso = ' || CN_CODUSO_HIBRIDO;
    END IF;

    LN_contador := 0;
    EXECUTE IMMEDIATE LV_sql INTO LN_contador;

    -- Obtiene todos los planes
    LV_Sql:='SELECT p.cod_plantarif,'
                    || '    p.des_plantarif,'
                    || '    s.num_solicitud'
                    || ' FROM ert_solicitud_planes a,'
                    || '      ga_planuso b,'
                    || '      ta_plantarif p,'
                    || '      ert_solicitud s'
                    || ' WHERE s.cod_tipident = ''' || EV_codTipIdentif || ''''
                    || '   AND s.num_ident_cliente = ''' || EV_numIdentif || ''''
                    || '   AND s.ind_tipo_solicitud = ' || EN_indTipoSolicitud
                    || '   AND s.ind_evento = ' || EN_indEvento
                    || '   AND s.cod_estado IN (' || CN_ESTADOSOL_APROB1 || ',' || CN_ESTADOSOL_APROB2 ||')'
                    || '   AND a.num_solicitud = s.num_solicitud'
                    || '   AND a.val_cant_terminales > a.val_cant_vendidos'
                    || '   AND a.cod_plantarif = p.cod_plantarif'
                    || '   AND p.cod_producto = ' || CN_PRODUCTO
                    || '   AND p.cla_plantarif <> ''SRV'''
                    || '   AND p.cod_tiplan = ''' || EV_tipProducto || ''''
                    || '   AND p.tip_plantarif = ''' || EV_tipPlanTarif || ''''
                    || '   AND p.ind_comer_web = ' || CN_PLANCOMERVIAWEB
                    || '   AND p.cod_plantarif = b.cod_plantarif'
                    || '   AND p.cod_producto = b.cod_producto(+)';

    IF (EV_tipProducto = CN_CODUSO_POSTPAGO) THEN
            LV_Sql := LV_Sql || '   AND b.cod_uso = ' || CN_CODUSO_POSTPAGO ;
    ELSE
            LV_Sql := LV_Sql || '   AND b.cod_uso = ' || CN_CODUSO_HIBRIDO;
    END IF;

    OPEN SC_cursorDatos FOR LV_Sql;

    IF (LN_contador = 0) THEN
            RAISE no_data_found_cursor;
    END IF;

EXCEPTION
        WHEN no_data_found_cursor THEN
             SN_codRetorno := CN_ERROR_NODATAFOUNDSOL;
             SV_menRetorno := CV_ERROR_NODATAFOUNDSOL;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolApro_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
             SN_codRetorno := CN_ERROR_OTHERS;
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolApro_PR;- ' || SQLERRM;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                SV_menRetorno := CV_ERROR_NOCLASIF;
             END IF;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolApro_PR',
             LV_Sql, SQLCODE, LV_desError);
END ER_getlistPlanTarifSolApro_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_getlistPlanTarifSolic_PR(EN_numSolicitud IN ert_solicitud.NUM_SOLICITUD%TYPE,
                                      EV_tipProducto  IN ta_plantarif.COD_TIPLAN%TYPE,
                                      EV_tipPlanTarif IN ta_plantarif.TIP_PLANTARIF%TYPE,
                                      SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                      SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                      SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
   Elemento Nombre = 'ER_getlistPlanTarifSolic_PR'
   Lenguaje='PL/SQL'
   Fecha='11-04-2008'
   Versión='1.0.0'
   Diseñador='wjrc'
   Programador='wjrc'
   Ambiente='BD'
<Retorno>
   Cursor
</Retorno>
<Descripción>
   Retorna lista planes tarifario segun numero identificador y tipo de solicitud
   Solicitudes Aprobadas solamente
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EN_numSolicitud' Tipo='NUMBER'> Numero de solicitud </param>
     <param nom='EV_tipProducto'  Tipo='NUMBER'> Tipo de producto </param>
     <param nom='EV_tipPlan'      Tipo='STRING'> Tipo de plan </param>
   </Entrada>
   <Salida>
     <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
     <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    error_controlado  EXCEPTION;

    LV_desError          ge_errores_pg.desevent;
    LV_sql               ge_errores_pg.vquery;
    LV_sql1              ge_errores_pg.vquery;
    LV_sql2              ge_errores_pg.vquery;
    LN_contador          NUMBER;
    EV_coduso            VARCHAR2(4000);
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;
    LV_sql1   := '11';
    LV_sql2   := '12';

    DBMS_OUTPUT.Put_Line('LV_sql1['||LV_sql1||']');
    DBMS_OUTPUT.Put_Line('LV_sql2['||LV_sql2||']');

    DBMS_OUTPUT.Put_Line('INGRESO A ER_getlistPlanTarifSolic_PR');

    LV_Sql1 := 'SELECT COUNT(1)';

    LV_Sql2 := ' FROM ert_solicitud_planes a,'
        || '      ga_planuso b,'
        || '      ta_plantarif p'
        || ' WHERE a.num_solicitud = ' || EN_numSolicitud
        || '   AND a.val_cant_terminales > a.val_cant_vendidos'
        || '   AND a.cod_plantarif = p.cod_plantarif'
        || '   AND p.cod_producto = ' || CN_PRODUCTO
        || '   AND p.cla_plantarif <> ''SRV''';


    DBMS_OUTPUT.Put_Line('PARTE 1');
    IF (EV_tipProducto IS NOT NULL) THEN
        LV_Sql2 := LV_Sql2 || ' AND p.cod_tiplan = ''' || EV_tipProducto || '''';
    END IF;

    DBMS_OUTPUT.Put_Line('PARTE 2');
    IF (EV_tipPlanTarif IS NOT NULL) THEN
        LV_Sql2 := LV_Sql2 || ' AND p.tip_plantarif = ''' || EV_tipPlanTarif || '''';
    END IF;

    DBMS_OUTPUT.Put_Line('PARTE 3');
    LV_Sql2 := LV_Sql2 || ' AND p.ind_comer_web = ' || CN_PLANCOMERVIAWEB
                       || ' AND p.cod_plantarif = b.cod_plantarif'
                       || ' AND p.cod_producto = b.cod_producto(+)';

    IF (EV_tipProducto = CN_CODUSO_POSTPAGO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_POSTPAGO ;
    ELSIF (EV_tipProducto = CN_CODUSO_HIBRIDO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_HIBRIDO;
    END IF;

    DBMS_OUTPUT.Put_Line('PARTE 4');

    LV_Sql :=  LV_Sql1 || LV_Sql2;

    DBMS_OUTPUT.Put_Line('PARTE 5');

    LN_contador := 0;
    DBMS_OUTPUT.Put_Line('PARTE 6');


    EXECUTE IMMEDIATE LV_sql INTO LN_contador;
    DBMS_OUTPUT.Put_Line('LN_contador ['||LN_contador||']');
    -- Obtiene todos los planes
    LV_Sql1 :='SELECT p.cod_plantarif,'
            || '  p.des_plantarif, p.cod_tiplan, p.tip_plantarif'
                        || '  ,(a.val_cant_terminales - a.val_cant_vendidos) as can_ter_disp';

    LV_Sql :=  LV_Sql1 || LV_Sql2;

    OPEN SC_cursorDatos FOR LV_Sql;

    IF (LN_contador = 0 OR LN_contador IS NULL) THEN
                DBMS_OUTPUT.Put_Line('Entra al IF LN_contador = 0');

                IF (CV_TIPPROSCL_PREPAGO = EV_tipProducto) THEN
                    SN_codRetorno := CN_ERROR_NODATAPREPAGO;
                    SV_menRetorno := CV_ERROR_NODATAPREPAGO;
                    RAISE error_controlado;
                ELSIF (CV_TIPPROSCL_POSTPAGO = EV_tipProducto) THEN
                    SN_codRetorno := CN_ERROR_NODATAPOSTPAGO;
                    SV_menRetorno := CV_ERROR_NODATAPOSTPAGO;
                    RAISE error_controlado;
                ELSIF (CV_TIPPROSCL_HIBRIDO = EV_tipProducto) THEN
                    SN_codRetorno := CN_ERROR_NODATAHIBRIDO;
                    SV_menRetorno := CV_ERROR_NODATAHIBRIDO;
                    RAISE error_controlado;
                ELSIF (EV_tipPlanTarif = 'I') THEN
                    SN_codRetorno := CN_ERROR_TIPINDNOENSCL;
                    SV_menRetorno := CV_ERROR_TIPINDNOENSCL;
                    RAISE error_controlado;
                ELSIF (EV_tipPlanTarif = 'E') THEN
                    SN_codRetorno := CN_ERROR_TIPEMPNOENSCL;
                    SV_menRetorno := CV_ERROR_TIPEMPNOENSCL;
                    RAISE error_controlado;
                ELSE
                   SN_codRetorno := CN_ERROR_NODATAFOUNDSOL;
                   SV_menRetorno := CV_ERROR_NODATAFOUNDSOL;
                   RAISE error_controlado;
                END IF;
    END IF;

EXCEPTION
        WHEN error_controlado THEN
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolic_PR;- ' || SQLERRM;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolic_PR',LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
             SN_codRetorno := CN_ERROR_OTHERS;
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolic_PR;- ' || SQLERRM;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_ERROR_NOCLASIF;
             END IF;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
END ER_getlistPlanTarifSolic_PR;
PROCEDURE ER_getNombreCliente_PR     (EN_numSolicitud IN ert_solicitud.NUM_SOLICITUD%TYPE,
                                      SV_NOMBRE       OUT NOCOPY ERT_SOLICITUD_CAMPOS.NOMBRE_CLIENTE%TYPE,
                                      SV_APELLIDO     OUT NOCOPY ERT_SOLICITUD_CAMPOS.PRIMER_APELLIDO%TYPE,
                                      SV_APELLIDO2    OUT NOCOPY ERT_SOLICITUD_CAMPOS.SEGUNDO_APELLIDO%TYPE,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                      SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                      SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
   Elemento Nombre = 'ER_getNombreCliente_PR'
   Lenguaje='PL/SQL'
   Fecha='03-12-2008'
   Versión='1.0.0'
   Diseñador='****'
   Programador='****'
   Ambiente='BD'
<Retorno>
   Cursor
</Retorno>
<Descripción>
   Retorna Nombre y apellidos de Cliente que tenga solicitud de evaluacion de Riesgo
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EN_numSolicitud' Tipo='NUMBER'> Numero de solicitud </param>
   </Entrada>
   <Salida>
     <param nom='SN_NOMBRE'      Tipo='STRING'> Primer Nombre de Cliente </param>
     <param nom='SN_APELLIDO'    Tipo='STRING'> Primer apellido del Cliente</param>
     <param nom='SN_APELLIDO2'   Tipo='STRING'> Segundo Apellido del Cliente </param>
     <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
     <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

    LV_Sql               ge_errores_pg.vquery;
    LV_desError          ge_errores_pg.desevent;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    BEGIN

        SELECT NOMBRE_CLIENTE,PRIMER_APELLIDO,SEGUNDO_APELLIDO
        INTO SV_NOMBRE,SV_APELLIDO,SV_APELLIDO2
        FROM ERT_SOLICITUD_CAMPOS
        WHERE NUM_SOLICITUD=EN_numSolicitud;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        NULL;
    END;

EXCEPTION
        WHEN OTHERS THEN
             SN_codRetorno := CN_ERROR_OTHERS;
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getNombreCliente_PR;- ' || SQLERRM;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_ERROR_NOCLASIF;
             END IF;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getNombreCliente_PR',
             LV_Sql, SQLCODE, LV_desError);
END ER_getNombreCliente_PR;




-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_getlistPlanTarifCteExc_PR(EV_tipProducto     IN ta_plantarif.COD_TIPLAN%TYPE,
                                       EV_tipPlanTarif    IN ta_plantarif.TIP_PLANTARIF%TYPE,
                                       EN_codRestriccion  IN erd_excepcion.COD_RESTRIC%TYPE,
                                       EV_TipRed          IN TA_PLANTARIF.TIP_RED%TYPE,
                                       EV_codPrestacion   IN GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                       EV_ORIGEN          IN VARCHAR2,
                                       EN_indRenova       IN NUMBER,
                                       EV_codCalificacion IN ve_calificacion_tarifario_td.COD_CALIFICACION%TYPE, --P-CSR-11002 JLGN 13-05-2011 
                                       SC_cursorDatos     OUT NOCOPY REFCURSOR,
                                       SN_codRetorno      OUT NOCOPY ge_errores_pg.CODERROR,
                                       SV_menRetorno      OUT NOCOPY ge_errores_pg.MSGERROR,
                                       SN_numEvento       OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getlistPlanTarifCtesExc_PR'
    Lenguaje='PL/SQL'
    Fecha='11-04-2008'
    Versión='1.0.0'
    Diseñador='wjrc'
    Programador='wjrc'
    Ambiente='BD'
<Retorno>
    Cursor
</Retorno>
<Descripción>
    Retorna lista planes tarifario segun numero identificador y tipo de solicitud
    Clientes excepcionados
</Descripción>
<Parámetros>
  <Entrada>
    <param nom='EV_tipProducto'      Tipo='STRING'> Tipo de producto </param>
    <param nom='EV_tipPlanTarif'     Tipo='STRING'> Tipo de plan tarifario </param>
    <param nom='EN_codRestriccion'   Tipo='NUMBER'> Codigo de restriccion </param>
  </Entrada>
  <Salida>
    <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
    <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
    <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
    <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
   </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    no_data_found_prepago  EXCEPTION;
    no_data_found_postpago EXCEPTION;
    no_data_found_hibrido  EXCEPTION;
    no_data_found_cursor   EXCEPTION;

    LV_desError              ge_errores_pg.desevent;
    LV_sql                   ge_errores_pg.vquery;
    LV_sql1                  ge_errores_pg.vquery;
    LV_sql2                  ge_errores_pg.vquery;
    LN_contador              NUMBER;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    -- Controlamos datos
    -- Obtiene todos los planes

 LV_Sql1 := 'SELECT COUNT(1)';

    --LV_Sql2 := LV_Sql2 || ' FROM ta_plantarif p, ga_planuso b, TA_CARGOSBASICO c'; P-CSR-11002 JLGN 13-05-2011
    LV_Sql2 := LV_Sql2 || ' FROM ta_plantarif p, ga_planuso b, TA_CARGOSBASICO c, ve_calificacion_tarifario_td d ';--P-CSR-11002 JLGN 13-05-2011
    LV_Sql2 := LV_Sql2 || ' WHERE p.cod_producto = ' || CN_PRODUCTO;

    IF (EV_tipProducto IS NOT NULL) THEN
           LV_Sql2 := LV_Sql2 || ' AND p.cod_tiplan = ''' || EV_tipProducto || '''';
    END IF;

        IF (EV_tipPlanTarif IS NOT NULL) THEN
        LV_Sql2 := LV_Sql2 || ' AND p.tip_plantarif = ''' || EV_tipPlanTarif || '''';
        END IF;

    IF (EN_codRestriccion = CN_PLANES_NOCOMERCIA) THEN
    -- No se obtienen planes no comercializables
            LV_Sql2 := LV_Sql2 || ' AND p.cod_plantarif = ''XYZ'''; -- para que el cursor se genere vacio
        ELSE
    -- Filtra a solo planes comercializables
        LV_Sql2 := LV_Sql2 || ' AND SYSDATE BETWEEN p.fec_desde AND NVL(p.fec_hasta,SYSDATE)';
    END IF;

    LV_Sql2 := LV_Sql2 || ' AND p.tip_red = ''' || EV_TipRed || '''';
    LV_Sql2 := LV_Sql2 || ' AND p.cod_prestacion = ''' || EV_codPrestacion || '''';
    LV_Sql2 := LV_Sql2 || ' AND p.cla_plantarif <> ''SRV''';
    LV_Sql2 := LV_Sql2 || ' AND p.cod_plantarif = b.cod_plantarif';
    LV_Sql2 := LV_Sql2 || ' AND p.cod_producto = b.cod_producto(+)';
    LV_Sql2 := LV_Sql2 || ' AND p.cod_cargoBasico = c.cod_cargoBasico';
    LV_Sql2 := LV_Sql2 || ' AND SYSDATE BETWEEN C.FEC_DESDE AND C.FEC_HASTA';
    
    --Inicio P-CSR-11002 JLGN 13-05-2011
    LV_Sql2 := LV_Sql2 || ' AND p.cod_plantarif = d.cod_plantarif ';
    LV_Sql2 := LV_Sql2 || ' AND d.cod_calificacion = '''|| EV_codCalificacion || '''';
    LV_Sql2 := LV_Sql2 || ' AND d.ind_vigencia = 1'; --cod_calificacion esta vigente    
    --Fin P-CSR-11002 JLGN 13-05-2011

    IF (EV_tipProducto = CV_TIPPROSCL_POSTPAGO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_POSTPAGO ;
    ELSIF (EV_tipProducto = CV_TIPPROSCL_HIBRIDO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_HIBRIDO;
    ELSIF (EV_tipProducto = CV_TIPPROSCL_PREPAGO) THEN
           LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_PREPAGO;
    END IF;
    IF EV_ORIGEN='DIS' THEN
       LV_Sql2 := LV_Sql2 || '   AND p.cla_plantarif = ''' || CV_TIPLAN_DIS || '''';
    END IF;

    LV_Sql2 := LV_Sql2 || '   AND p.IND_ARRASTRE =' || EN_indRenova;

    LV_sql := LV_sql1 || LV_sql2;

    LN_contador := 0;
    EXECUTE IMMEDIATE LV_sql INTO LN_contador;

    -- Obtiene todos los planes
    LV_Sql1 := 'SELECT p.cod_plantarif,p.cod_plantarif ||''  '' ||  p.des_plantarif,p.cod_tiplan, p.tip_plantarif,0 AS can_ter_disp';

    LV_sql := LV_sql1 || LV_sql2;
    --LV_sql := LV_sql || ' Order by p.des_plantarif'; P-CSR-11002 JLGN 04-11-2011
    LV_sql := LV_sql || ' Order by p.des_plantarif desc';
    
    DBMS_OUTPUT.Put_Line('SQL = ' || LV_sql);
    
    OPEN SC_cursorDatos FOR LV_sql;

    --IF (LN_contador = 0) THEN
    --           IF (CV_TIPPROSCL_PREPAGO = EV_tipProducto) THEN
    --                RAISE no_data_found_prepago;
    --           ELSIF (CV_TIPPROSCL_POSTPAGO = EV_tipProducto) THEN
    --                RAISE no_data_found_postpago;
    --            ELSIF (CV_TIPPROSCL_HIBRIDO = EV_tipProducto) THEN
    --                RAISE no_data_found_hibrido;
    --           ELSE
    --        RAISE no_data_found_cursor;
    --           END IF;
    -- END IF;

EXCEPTION
        WHEN no_data_found_prepago THEN
             SN_codRetorno := CN_ERROR_NODATAPREPAGO;
             SV_menRetorno := CV_ERROR_NODATAPREPAGO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_postpago THEN
             SN_codRetorno := CN_ERROR_NODATAPOSTPAGO;
             SV_menRetorno := CV_ERROR_NODATAPOSTPAGO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_hibrido THEN
             SN_codRetorno := CN_ERROR_NODATAHIBRIDO;
             SV_menRetorno := CV_ERROR_NODATAHIBRIDO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_cursor THEN
             SN_codRetorno := CN_ERROR_NODATAFOUNDEXC;
             SV_menRetorno := CV_ERROR_NODATAFOUNDEXC;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifCteExc',
             LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
             SN_codRetorno := CN_ERROR_OTHERS;
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifCteExc_PR;- ' || SQLERRM;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                SV_menRetorno := CV_ERROR_NOCLASIF;
             END IF;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getlistPlanTarifCteExc_PR',
             LV_Sql, SQLCODE, LV_desError);
END ER_getlistPlanTarifCteExc_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_getListaPlanesTarif_PR(EV_tipoProducto    IN           ta_plantarif.COD_TIPLAN%TYPE,
                                    EV_tipPlanTarif    IN           ta_plantarif.TIP_PLANTARIF%TYPE,
                                    EV_codPrestacion   IN           ge_prestaciones_td.COD_PRESTACION%TYPE,
                                    EV_ORIGEN          IN           VARCHAR2,
                                    EN_indRenova       IN           NUMBER,
                                    EV_codCalificacion IN           ve_calificacion_tarifario_td.COD_CALIFICACION%TYPE, --P-CSR-11002 JLGN 13-05-2011
                                    SC_cursorDatos     OUT NOCOPY   REFCURSOR,
                                    SN_codRetorno      OUT NOCOPY   ge_errores_pg.CODERROR,
                                    SV_menRetorno      OUT NOCOPY   ge_errores_pg.MSGERROR,
                                    SN_numEvento       OUT NOCOPY   ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getListaPlanesTarif_PR'
    Lenguaje='PL/SQL'
    Fecha='11-04-2008'
    Versión='1.0.0'
    Diseñador='wjrc'
    Programador='wjrc'
    Ambiente='BD'
<Retorno>
    Numero de solicitud
    Cursor con planes tarifarios
</Retorno>
<Descripción>
    Retorna lista planes tarifario
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EV_tipoProducto'  Tipo='STRING'> Tipo producto </param>
     <param nom='EV_tipoPlan'              Tipo='STRING'> Tipo plan </param>
     <param nom='EV_codTipIdentif' Tipo='STRING'> Tipo identificador </param>
     <param nom='EV_numIdentif'    Tipo='STRING'> Numero identificador </param>
    </Entrada>
   <Salida>
     <param nom='SN_numSolicitud' Tipo='NUMBER'> Numero de solicitud </param>
     <param nom='SC_cursorDatos'  Tipo='CURSOR'> cursor planes tarifario </param>
     <param nom='SN_codRetorno'   Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'   Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'    Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    error_en_parametro     EXCEPTION;
    error_en_procedimiento EXCEPTION;
    error_de_negocio       EXCEPTION;
    error_ejecucion        EXCEPTION;

    LV_desError             ge_errores_pg.desevent;
    LV_sql                          ge_errores_pg.vquery;

    LN_contador         NUMBER;
    LV_numIdentif       VARCHAR2(20);
    LN_numSolicitud     ert_solicitud.NUM_SOLICITUD%TYPE;
    LN_estSolicitud     ert_solicitud.COD_ESTADO%TYPE;
    LN_indTipoSolicitud ert_solicitud.IND_TIPO_SOLICITUD%TYPE;
    LN_indEvento        ert_solicitud.IND_EVENTO%TYPE;
    LN_codRestricc      erd_excepcion.COD_RESTRIC%TYPE;
    LV_tipoProducto     ta_plantarif.COD_TIPLAN%TYPE;
    LV_tipoRed          ta_plantarif.TIP_RED%TYPE;

BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;
    DBMS_OUTPUT.Put_Line('INGRESO  ER_getListaPlanesTarif_PR');
    -----------------------------------------------------------------------------------------
    -- Validar parametros de entrada
    -----------------------------------------------------------------------------------------

    -- tipo plan tarifario
    -- I : individual / E : empresa
    DBMS_OUTPUT.Put_Line('EV_tipPlanTarif ['||EV_tipPlanTarif||']');
    IF (EV_tipPlanTarif IS NOT NULL) THEN
       IF (EV_tipPlanTarif <> CV_TIPPLANTARIF_IND AND EV_tipPlanTarif <> CV_TIPPLANTARIF_EMP) THEN
       SN_codRetorno := CN_ERROR_TIPPLANOENSCL;
       SV_menRetorno := CV_ERROR_TIPPLANOENSCL;
       RAISE error_en_parametro;
            END IF;
    END IF;

    SELECT TIP_RED
    INTO LV_TipoRed
    FROM GE_PRESTACIONES_TD
    WHERE COD_PRESTACION=EV_codPrestacion;

    -----------------------------------------------------------------------------------------
    -- Pareamos tipo de producto SCL a Colombia
    -----------------------------------------------------------------------------------------
    LV_tipoProducto := EV_tipoProducto;

    IF EV_tipoProducto=CN_CODUSO_PREPAGO THEN
       LV_tipoProducto :=CV_TIPPROSCL_PREPAGO;
    END IF;

    IF EV_tipoProducto=CN_CODUSO_POSTPAGO THEN
       LV_tipoProducto :=CV_TIPPROSCL_POSTPAGO;
    END IF;


    IF EV_tipoProducto=CN_CODUSO_HIBRIDO THEN
       LV_tipoProducto :=CV_TIPPROSCL_HIBRIDO;
    END IF;

    -- Obtener planes con cliente excepcionado
    ER_getlistPlanTarifCteExc_PR(LV_tipoProducto,
                                 EV_tipPlanTarif,
                                 LN_codRestricc,
                                 LV_TipoRed,
                                 EV_codPrestacion,
                                 EV_ORIGEN,
                                 EN_indRenova,
                                 EV_codCalificacion, --P-CSR-11002 JLGN 13-05-2011
                                 SC_cursorDatos,
                                 SN_codRetorno,
                                 SV_menRetorno,
                                 SN_numEvento);

     IF SN_codRetorno <> 0 THEN
        RAISE error_ejecucion;
     END IF;


EXCEPTION
        WHEN error_en_parametro THEN
                LV_desError   := 'error_en_parametro:ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR;- ' || SV_menRetorno;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR',
                LV_Sql, SN_codRetorno, LV_desError);
        WHEN error_en_procedimiento THEN
                LV_desError   := 'error_en_procedimiento:ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR;- ' || SV_menRetorno;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR',
                LV_Sql, SN_codRetorno, LV_desError);
        WHEN error_de_negocio THEN
                LV_desError   := 'error_de_negocioERS:ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR;- ' || SV_menRetorno;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR',
                LV_Sql, SN_codRetorno, LV_desError);
        WHEN error_ejecucion THEN
                LV_desError   := 'error_de_negocioERS:ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR;- ' || SQLERRM;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR',LV_Sql, SN_codRetorno, LV_desError);
        WHEN OTHERS THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR;- ' || SQLERRM;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERROR_NOCLASIF;
                END IF;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getListaPlanesTarif_PR',
                LV_Sql, SQLCODE, LV_desError);
END ER_getListaPlanesTarif_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_cambia_estado_solicitud_PR(EN_numSolicitud   IN         ert_solicitud.num_solicitud%TYPE,
                                        EN_codEstado      IN         ert_solicitud.cod_estado%TYPE,
                                        SN_codRetorno     OUT NOCOPY ge_errores_pg.CODERROR,
                                        SV_menRetorno     OUT NOCOPY ge_errores_pg.MSGERROR,
                                        SN_numEvento      OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_cambia_estado_solicitud_PR'
    Lenguaje='PL/SQL'
    Fecha='16-04-2008'
    Versión='1.0.0'
    Diseñador= Patricia Molina
    Programador= Marcelo Godoy
    Ambiente='BD'
<Retorno>
</Retorno>
<Descripción>
</Descripción>
<Parámetros>
    <Entrada>
        </Entrada>
    <Salida>
        <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
        <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
        <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
      </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    LV_desError ge_errores_pg.desevent;
    LV_sql      ge_errores_pg.vquery;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := 'OK';
    SN_numEvento  := 0;

    LV_Sql:= 'UPDATE ert_solicitud'
      || ' SET cod_estado = '|| EN_codEstado
      || ' WHERE num_solicitud = '||EN_numSolicitud;

    UPDATE ert_solicitud
       SET cod_estado = EN_codEstado
     WHERE num_solicitud = EN_numSolicitud
           AND cod_estado <> CN_ESTADOSOL_VENDIDO;

EXCEPTION
     WHEN OTHERS THEN
          SN_codRetorno := CN_ERROR_OTHERS;
          LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_cambia_estado_solicitud_PR()'||SQLERRM;
          SV_menRetorno := 'Error al modificar el estado de Evaluación de Riesgo';
          SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR', LV_Sql, SQLCODE, LV_desError);
END ER_cambia_estado_solicitud_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_upd_solicplanes_PR(EN_numSolicitud IN ert_solicitud_planes.num_solicitud%TYPE,
                                EV_planTarif    IN ert_solicitud_planes.cod_plantarif%TYPE,
                                                                EN_numVenta     IN ert_solicitud_venta.NUM_VENTA%TYPE,
                                SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getExcepcion_PR'
    Lenguaje='PL/SQL'
    Fecha='16-04-2008'
    Versión='1.0.0'
    Diseñador= Patricia Molina
    Programador= Marcelo Godoy
    Ambiente='BD'
<Retorno>
    Retorna un number
</Retorno>
<Descripción>
    Retorna si existe excepcion para numero identificacion.
</Descripción>
<Parámetros>
    <Entrada>
       <param nom='EV_numIdent'    Tipo='STRING'> numero de identificacion </param>
       <param nom='EV_codTipIdent' Tipo='STRING'> codigo tipo identificador </param>
     </Entrada>
    <Salida>
       <param nom='SN_codRestricc' Tipo='NUMBER'> codigo de restriccion </param>
       <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
      <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
      <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
     </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    error_ejecucion exception;

    LV_desError     ge_errores_pg.desevent;
    LV_sql          ge_errores_pg.vquery;
    can_terminal    NUMBER;
    can_vendidos    NUMBER;
    LN_ind_venta    NUMBER;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql:= 'SELECT a.val_cant_terminales, a.val_cant_vendidos'
          || ' FROM ert_solicitud_planes a'
          || ' WHERE a.num_solicitud = '|| EN_numSolicitud
          || ' AND a.cod_plantarif = '|| EV_planTarif;

    SELECT a.val_cant_terminales, a.val_cant_vendidos
      INTO can_terminal, can_vendidos
      FROM ert_solicitud_planes a
     WHERE a.num_solicitud = EN_numSolicitud
       AND a.cod_plantarif = EV_planTarif;

    can_vendidos := can_vendidos + 1;

    IF can_vendidos = can_terminal THEN
        LN_ind_venta := CN_PLAN_ASIGVENTA;
    ELSE
        LN_ind_venta := CN_PLAN_NOASIGVENTA;--2;
    END IF;

    LV_Sql:= 'UPDATE ERT_SOLICITUD_PLANES'
          || ' SET val_cant_vendidos =' || can_vendidos||','
          || ' ind_venta = '|| LN_ind_venta
          || ' WHERE num_solicitud = ' || EN_numSolicitud
          || ' AND cod_plantarif = ' || EV_planTarif;

    UPDATE ERT_SOLICITUD_PLANES
       SET val_cant_vendidos = can_vendidos,
           ind_venta = LN_ind_venta
     WHERE num_solicitud = EN_numSolicitud
       AND cod_plantarif = EV_planTarif;

     IF NOT (VE_relaciona_solvta_FN(EN_numSolicitud,
                                        EN_numVenta,
                                    SN_codRetorno,
                                    SV_menRetorno,
                                    SN_numEvento)) THEN
             raise error_ejecucion;
     END IF;

     IF NOT (VE_cierre_solicitud_FN(EN_numSolicitud,
                                    SN_codRetorno,
                                    SV_menRetorno,
                                    SN_numEvento)) THEN
             raise error_ejecucion;
     END IF;

EXCEPTION
        WHEN error_ejecucion THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'error_ejecucion:ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR()'||SQLERRM;
                SV_menRetorno := 'Error al modificar el estado de Evaluación de Riesgo';
                SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR', LV_Sql, SQLCODE, LV_desError);
        WHEN NO_DATA_FOUND THEN
                SN_codRetorno := CN_ERROR_NODATAFOUND;
                LV_desError   := 'NO_DATA_FOUND:ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR()'||SQLERRM;
                SV_menRetorno := CV_ERROR_NODATAFOUND;
                SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR', LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR()'||SQLERRM;
                SV_menRetorno := 'Error al modificar el estado de Evaluación de Riesgo';
                SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getExcepcion_PR', LV_Sql, SQLCODE, LV_desError);
END ER_upd_solicplanes_PR;

-------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_upd_solicplanes_PR(EN_numSolicitud IN ert_solicitud_planes.num_solicitud%TYPE,
                                EV_planTarif    IN ert_solicitud_planes.cod_plantarif%TYPE,
                                EN_numVenta     IN ert_solicitud_venta.NUM_VENTA%TYPE,
                                EN_numlineas    IN ert_solicitud_planes.VAL_CANT_VENDIDOS%TYPE,
                                SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getExcepcion_PR'
    Lenguaje='PL/SQL'
    Fecha='16-04-2008'
    Versión='1.0.0'
    Diseñador= Patricia Molina
    Programador= Marcelo Godoy
    Ambiente='BD'
<Retorno>
    Retorna un number
</Retorno>
<Descripción>
    Retorna si existe excepcion para numero identificacion.
</Descripción>
<Parámetros>
    <Entrada>
       <param nom='EV_numIdent'    Tipo='STRING'> numero de identificacion </param>
       <param nom='EV_codTipIdent' Tipo='STRING'> codigo tipo identificador </param>
     </Entrada>
    <Salida>
       <param nom='SN_codRestricc' Tipo='NUMBER'> codigo de restriccion </param>
       <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
      <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
      <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
     </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    error_ejecucion exception;

    LV_desError     ge_errores_pg.desevent;
    LV_sql          ge_errores_pg.vquery;
    can_terminal    NUMBER;
    can_vendidos    NUMBER;
    LN_ind_venta    NUMBER;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := 'OK';
    SN_numEvento  := 0;

    LV_Sql:= 'SELECT a.val_cant_terminales, a.val_cant_vendidos'
          || ' FROM  ert_solicitud_planes a'
          || ' WHERE a.num_solicitud = '|| EN_numSolicitud
          || ' AND   a.cod_plantarif = '|| EV_planTarif;

    SELECT a.val_cant_terminales, a.val_cant_vendidos
      INTO can_terminal, can_vendidos
      FROM ert_solicitud_planes a
     WHERE a.num_solicitud = EN_numSolicitud
       AND a.cod_plantarif = EV_planTarif;

    can_vendidos := can_vendidos + EN_numlineas;

    IF can_vendidos = can_terminal THEN
        LN_ind_venta := CN_PLAN_ASIGVENTA;
    ELSE
        LN_ind_venta := CN_PLAN_NOASIGVENTA;--2;
    END IF;

    LV_Sql:= 'UPDATE ERT_SOLICITUD_PLANES'
          || ' SET val_cant_vendidos = '|| can_vendidos||','
          || '     ind_venta         = '|| LN_ind_venta
          || ' WHERE num_solicitud = ' || EN_numSolicitud
          || ' AND   cod_plantarif = ' || EV_planTarif;

    UPDATE ERT_SOLICITUD_PLANES
       SET val_cant_vendidos = can_vendidos,
           ind_venta         = LN_ind_venta
     WHERE num_solicitud = EN_numSolicitud
       AND cod_plantarif = EV_planTarif;

     IF EN_numVenta > 0 THEN
        IF NOT (VE_relaciona_solvta_FN(EN_numSolicitud,
                                       EN_numVenta,
                                       SN_codRetorno,
                                       SV_menRetorno,
                                       SN_numEvento)) THEN
                raise error_ejecucion;
        END IF;
     END IF ;

     IF NOT (VE_cierre_solicitud_FN(EN_numSolicitud,
                                    SN_codRetorno,
                                    SV_menRetorno,
                                    SN_numEvento)) THEN
             raise error_ejecucion;
     END IF;

EXCEPTION
        WHEN error_ejecucion THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'error_ejecucion:ER_servicios_evalriesgo_web_PG.PV_upd_solicplanes_PR()'||SQLERRM;
                SV_menRetorno := 'Error al actualizar la cantidad de lineas';
                SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_upd_solicplanes_PR', LV_Sql, SQLCODE, LV_desError);
        WHEN NO_DATA_FOUND THEN
                SN_codRetorno := CN_ERROR_NODATAFOUND;
                LV_desError   := 'NO_DATA_FOUND:ER_servicios_evalriesgo_web_PG.PV_upd_solicplanes_PR()'||SQLERRM;
                SV_menRetorno := CV_ERROR_NODATAFOUND;
                SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_upd_solicplanes_PR', LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.PV_upd_solicplanes_PR()'||SQLERRM;
                SV_menRetorno := 'Error al actualizar la cantidad de lineas';
                SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_upd_solicplanes_PR', LV_Sql, SQLCODE, LV_desError);
END PV_upd_solicplanes_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ER_val_planTarif_solic_PR(EN_numSolicitud IN         ert_solicitud_planes.num_solicitud%TYPE,
                                    EV_planTarif    IN         ert_solicitud_planes.cod_plantarif%TYPE,
                                    SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                    SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                    SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'ER_getExcepcion_PR'
    Lenguaje='PL/SQL'
    Fecha='16-04-2008'
    Versión='1.0.0'
    Diseñador= Patricia Molina
    Programador= Marcelo Godoy
    Ambiente='BD'
<Retorno>
    Retorna un number
</Retorno>
<Descripción>
    Retorna si existe excepcion para numero identificacion.
</Descripción>
<Parámetros>
    <Entrada>
       <param nom='EV_numIdent'    Tipo='STRING'> numero de identificacion </param>
       <param nom='EV_codTipIdent' Tipo='STRING'> codigo tipo identificador </param>
     </Entrada>
    <Salida>
       <param nom='SN_codRestricc' Tipo='NUMBER'> codigo de restriccion </param>
       <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
      <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
      <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
     </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    error_plant  EXCEPTION;
    LV_desError  ge_errores_pg.desevent;
    LV_sql       ge_errores_pg.vquery;
    can_terminal NUMBER;
    can_vendidos NUMBER;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql:= 'SELECT a.val_cant_terminales, a.val_cant_vendidos'
          || ' FROM ert_solicitud_planes a'
          || ' WHERE a.num_solicitud = '|| EN_numSolicitud
          || ' AND a.cod_plantarif = '|| EV_planTarif;

    SELECT a.val_cant_terminales, a.val_cant_vendidos
      INTO can_terminal, can_vendidos
      FROM ert_solicitud_planes a
     WHERE a.num_solicitud = EN_numSolicitud
       AND a.cod_plantarif = EV_planTarif;


    IF NOT (can_vendidos < can_terminal) THEN
        RAISE error_plant;
    END IF;

EXCEPTION
        WHEN error_plant THEN
                SN_codRetorno := 386;
                LV_desError   := 'ERROR_PLANT:ER_servicios_evalriesgo_web_PG.ER_val_planTarif_solic_PR()'||SQLERRM;
                SV_menRetorno := 'No Existen Planes Tarifarios para la Evaluación de Riesgo';
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_val_planTarif_solic_PR', LV_Sql, SQLCODE, LV_desError);
        WHEN NO_DATA_FOUND THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'NO_DATA_FOUND:ER_servicios_evalriesgo_web_PG.ER_val_planTarif_solic_PR()'||SQLERRM;
                SV_menRetorno := 'Error al modificar el estado de Evaluación de Riesgo';
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_val_planTarif_solic_PR', LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_val_planTarif_solic_PR()'||SQLERRM;
                SV_menRetorno := 'Error al modificar el estado de Evaluación de Riesgo';
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA, SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_val_planTarif_solic_PR', LV_Sql, SQLCODE, LV_desError);
END ER_val_planTarif_solic_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_getListaPlanesTarif_PR(EV_tipoProducto  IN ta_plantarif.COD_TIPLAN%TYPE,
                                    EV_tipPlanTarif  IN ta_plantarif.TIP_PLANTARIF%TYPE,
                                    EV_codTipIdentif IN ert_solicitud.COD_TIPIDENT%TYPE,
                                    EV_numIdentif    IN ert_solicitud.NUM_IDENT_CLIENTE%TYPE,
                                    SN_numSolicitud  OUT NOCOPY ert_solicitud.NUM_SOLICITUD%TYPE,
                                    SC_cursorDatos   OUT NOCOPY REFCURSOR,
                                    SN_codRetorno    OUT NOCOPY ge_errores_pg.CODERROR,
                                    SV_menRetorno    OUT NOCOPY ge_errores_pg.MSGERROR,
                                    SN_numEvento     OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'PV_getListaPlanesTarif_PR'
    Lenguaje='PL/SQL'
    Fecha='11-04-2008'
    Versión='1.0.0'
    Diseñador='wjrc'
    Programador='wjrc'
    Ambiente='BD'
<Retorno>
    Numero de solicitud
    Cursor con planes tarifarios
</Retorno>
<Descripción>
    Retorna lista planes tarifario.
        Fue creado sólo para CPU y TRASABO ya que estas procedimientos no considran el campo ind_comer_web.
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EV_tipoProducto'  Tipo='STRING'> Tipo producto </param>
     <param nom='EV_tipoPlan'      Tipo='STRING'> Tipo plan </param>
     <param nom='EV_codTipIdentif' Tipo='STRING'> Tipo identificador </param>
     <param nom='EV_numIdentif'    Tipo='STRING'> Numero identificador </param>
    </Entrada>
   <Salida>
     <param nom='SN_numSolicitud' Tipo='NUMBER'> Numero de solicitud </param>
     <param nom='SC_cursorDatos'  Tipo='CURSOR'> cursor planes tarifario </param>
     <param nom='SN_codRetorno'   Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'   Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'    Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    error_en_parametro     EXCEPTION;
    error_en_procedimiento EXCEPTION;
    error_de_negocio       EXCEPTION;

    LV_desError             ge_errores_pg.desevent;
    LV_sql                          ge_errores_pg.vquery;

    LN_contador         NUMBER;
    LV_numIdentif       VARCHAR2(20);
    LN_numSolicitud     ert_solicitud.NUM_SOLICITUD%TYPE;
    LN_estSolicitud     ert_solicitud.COD_ESTADO%TYPE;
    LN_indTipoSolicitud ert_solicitud.IND_TIPO_SOLICITUD%TYPE;
    LN_indEvento        ert_solicitud.IND_EVENTO%TYPE;
    LN_codRestricc      erd_excepcion.COD_RESTRIC%TYPE;
    LV_tipoProducto     ta_plantarif.COD_TIPLAN%TYPE;

BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    -----------------------------------------------------------------------------------------
    -- Validar parametros de entrada
    -----------------------------------------------------------------------------------------
    -- tipo producto
    -- Solo se hara la transformacion de SCL a Colombia

    -- tipo plan tarifario
    -- I : individual / E : empresa
    IF (EV_tipPlanTarif IS NOT NULL) THEN
       IF (EV_tipPlanTarif <> CV_TIPPLANTARIF_IND AND EV_tipPlanTarif <> CV_TIPPLANTARIF_EMP) THEN
       SN_codRetorno := CN_ERROR_TIPPLANOENSCL;
       SV_menRetorno := CV_ERROR_TIPPLANOENSCL;
       RAISE error_en_parametro;
            END IF;
    END IF;

    -- tipo Identificador --
    LV_Sql := 'VE_valida_existe_en_SCL_FN(''GE_TIPIDENT'',''COD_TIPIDENT'','
                                          || EV_codTipIdentif || ','
                                          || 'NULL,'
                                          || '...)';

    IF NOT VE_valida_existe_en_SCL_FN('GE_TIPIDENT',
                                      'COD_TIPIDENT',
                                      EV_codTipIdentif,
                                      NULL,
                                      SN_codRetorno,
                                      SV_menRetorno,
                                      SN_numEvento) THEN
            IF (SN_codRetorno = 0) THEN
                SN_codRetorno := CN_ERROR_TIPIDENOENSCL;
                SV_menRetorno := CV_ERROR_TIPIDENOENSCL;
            END IF;
            RAISE error_en_parametro;
    END IF;

    -- numero identificador --
--    LV_numIdentif := 'OK';

--    LV_Sql:='VE_INTERMEDIARIO_PG.VE_ValidarIdentificador_PR(' || CV_MODULO_GE || ',1,'
--                                                              || EV_numIdentif|| ',' || EV_codTipIdentif
--                                                              || ',' || SN_codRetorno ||',' || SV_menRetorno || ','
--                                                              || SN_numEvento || ')';

--    VE_INTERMEDIARIO_PG.VE_ValidarIdentificador_PR(CV_MODULO_GE,'1',EV_numIdentif,EV_codTipIdentif,SN_codRetorno,SV_menRetorno,SN_numEvento);

--    IF (SN_codRetorno <> 0) THEN
--        SN_codRetorno := CN_ERROR_NUMIDEINVALID;
--        SV_menRetorno := CV_ERROR_NUMIDEINVALID;
--        RAISE error_en_parametro;
--    END IF;

    -----------------------------------------------------------------------------------------
    -- Pareamos tipo de producto SCL a Colombia
    -----------------------------------------------------------------------------------------
    LV_tipoProducto := NULL;
    -- Tipo producto prepago
    IF (EV_tipoProducto = CV_TIPPROCOL_PREPAGO) THEN
        LV_tipoProducto := CV_TIPPROSCL_PREPAGO;
    END IF;

    -- Tipo producto postpago
    IF (EV_tipoProducto = CV_TIPPROCOL_POSTPAGO) THEN
        LV_tipoProducto := CV_TIPPROSCL_POSTPAGO;
    END IF;

    -- Tipo producto hibrido
    IF (EV_tipoProducto = CV_TIPPROCOL_HIBRIDO) THEN
        LV_tipoProducto := CV_TIPPROSCL_HIBRIDO;
    END IF;

    -----------------------------------------------------------------------------------------
    -- Verificamos excepcion para el cliente
    -----------------------------------------------------------------------------------------
    ER_getExcepcion_PR(EV_codTipIdentif,
                       EV_numIdentif,
                       LN_codRestricc,
                       SN_codRetorno,
                       SV_menRetorno,
                       SN_numEvento);

    IF (SN_codRetorno <> CN_NOERRORSQL) THEN
        IF (SN_codRetorno <> CN_ERROR_NODATAFOUND) THEN
            RAISE error_en_procedimiento;
        END IF;
    END IF;

    IF ( LN_codRestricc = CN_NOHAYEXCEPCION) THEN
    -- no existe excepcion para el cliente, se buscara solicitud

         -----------------------------------------------------------------------------------------
         -- Obtenemos ultima solicitud del cliente
         -----------------------------------------------------------------------------------------
         ER_getUltimaSolicitud_PR(EV_codTipIdentif,
                                  EV_numIdentif,
                                  LN_numSolicitud,
                                  LN_estSolicitud,
                                  LN_indTipoSolicitud,
                                  LN_indEvento,
                                  SN_codRetorno,
                                  SV_menRetorno,
                                  SN_numEvento);

         IF (SN_codRetorno <> 0) THEN
                 RAISE error_en_procedimiento;
         END IF;

         -----------------------------------------------------------------------------------------
         -- Validamos ultima solicitud del cliente
         -----------------------------------------------------------------------------------------
         -- corresponde a una postventa ?
         IF (LN_indEvento = CN_EVENTO_POSTVTA) THEN
                 SN_codRetorno := CN_ERROR_SOLEVAPOSTVTA;
                 SV_menRetorno := CV_ERROR_SOLEVAPOSTVTA;
                 RAISE error_de_negocio;
         END IF;

         -- corresponde a un prechequeo ?
         IF (LN_indTipoSolicitud = CN_TIPSOL_PRECHEQ) THEN
                 SN_codRetorno := CN_ERROR_SOLEVAPRECHEQ;
                 SV_menRetorno := CV_ERROR_SOLEVAPRECHEQ;
                 RAISE error_de_negocio;
         END IF;

         -- solicitud rechazada ?
         IF (LN_estSolicitud = CN_ESTSOL_RECHAZADA) THEN
                 SN_codRetorno := CN_ERROR_ESTSOLRECHAZA;
                 SV_menRetorno := CV_ERROR_ESTSOLRECHAZA;
                 RAISE error_de_negocio;
         END IF;

         -- solicitud en proceso de venta ?
         IF (LN_estSolicitud = CN_ESTSOL_ENPROCVTA ) THEN
                 SN_codRetorno := CN_ERROR_ESTSOLPROCVTA;
                 SV_menRetorno := CV_ERROR_ESTSOLPROCVTA;
                 RAISE error_de_negocio;
         END IF;

         SN_numSolicitud := LN_numSolicitud;

         -- Obtener planes para el cliente y solicitud
         PV_getlistPlanTarifSolic_PR(SN_numSolicitud,
                                     LV_tipoProducto,
                                     EV_tipPlanTarif,
                                     SC_cursorDatos,
                                     SN_codRetorno,
                                     SV_menRetorno,
                                     SN_numEvento);

    ELSE
    -- cliente tiene excepcion

         SN_numSolicitud := 0;

         -- Obtener planes con cliente excepcionado
         PV_getlistPlanTarifCteExc_PR(LV_tipoProducto,
                                      EV_tipPlanTarif,
                                      LN_codRestricc,
                                      SC_cursorDatos,
                                      SN_codRetorno,
                                      SV_menRetorno,
                                      SN_numEvento);
    END IF;

EXCEPTION
        WHEN error_en_parametro THEN
                LV_desError   := 'error_en_parametro:ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR;- ' || SV_menRetorno;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR',
                LV_Sql, SN_codRetorno, LV_desError);
        WHEN error_en_procedimiento THEN
                LV_desError   := 'error_en_procedimiento:ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR;- ' || SV_menRetorno;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR',
                LV_Sql, SN_codRetorno, LV_desError);
        WHEN error_de_negocio THEN
                LV_desError   := 'error_de_negocioERS:ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR;- ' || SV_menRetorno;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR',
                LV_Sql, SN_codRetorno, LV_desError);
        WHEN OTHERS THEN
                SN_codRetorno := CN_ERROR_OTHERS;
                LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR;- ' || SQLERRM;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                    SV_menRetorno := CV_ERROR_NOCLASIF;
                END IF;
                SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
                SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getListaPlanesTarif_PR',
                LV_Sql, SQLCODE, LV_desError);
END PV_getListaPlanesTarif_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_getlistPlanTarifSolic_PR(EN_numSolicitud IN ert_solicitud.NUM_SOLICITUD%TYPE,
                                      EV_tipProducto  IN ta_plantarif.COD_TIPLAN%TYPE,
                                      EV_tipPlanTarif IN ta_plantarif.TIP_PLANTARIF%TYPE,
                                      SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                      SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                      SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                      SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
   Elemento Nombre = 'PV_getlistPlanTarifSolic_PR'
   Lenguaje='PL/SQL'
   Fecha='11-04-2008'
   Versión='1.0.0'
   Diseñador='wjrc'
   Programador='wjrc'
   Ambiente='BD'
<Retorno>
   Cursor
</Retorno>
<Descripción>
   Retorna lista planes tarifario segun numero identificador y tipo de solicitud.
   Solicitudes Aprobadas solamente.
   Fue creado sólo para CPU y TRASABO ya que estas procedimientos no considran el campo ind_comer_web.
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EN_numSolicitud' Tipo='NUMBER'> Numero de solicitud </param>
     <param nom='EV_tipProducto'  Tipo='NUMBER'> Tipo de producto </param>
     <param nom='EV_tipPlan'      Tipo='STRING'> Tipo de plan </param>
   </Entrada>
   <Salida>
     <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
     <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    no_data_found_prepago  EXCEPTION;
    no_data_found_postpago EXCEPTION;
    no_data_found_hibrido  EXCEPTION;
    no_data_found_cursor   EXCEPTION;

    LV_desError          ge_errores_pg.desevent;
    LV_sql               ge_errores_pg.vquery;
    LV_sql1              ge_errores_pg.vquery;
    LV_sql2              ge_errores_pg.vquery;
    LN_contador          NUMBER;
    EV_coduso            VARCHAR2(4000);
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    LV_Sql1 := 'SELECT COUNT(1)';

    LV_Sql2 := ' FROM ert_solicitud_planes a,'
        || '      ga_planuso b,'
        || '      ta_plantarif p'
        || ' WHERE a.num_solicitud = ' || EN_numSolicitud
        || '   AND a.val_cant_terminales > a.val_cant_vendidos'
        || '   AND a.cod_plantarif = p.cod_plantarif'
        || '   AND p.cod_producto = ' || CN_PRODUCTO
        || '   AND p.cla_plantarif <> ''SRV''';

    IF (EV_tipProducto IS NOT NULL) THEN
        LV_Sql2 := LV_Sql2 || ' AND p.cod_tiplan = ''' || EV_tipProducto || '''';
    END IF;

    IF (EV_tipPlanTarif IS NOT NULL) THEN
        LV_Sql2 := LV_Sql2 || ' AND p.tip_plantarif = ''' || EV_tipPlanTarif || '''';
    END IF;

--    LV_Sql2 := LV_Sql2 || ' AND p.ind_comer_web = ' || CN_PLANCOMERVIAWEB;
    LV_Sql2 := LV_Sql2 || ' AND p.cod_plantarif = b.cod_plantarif';
    LV_Sql2 := LV_Sql2 || ' AND p.cod_producto = b.cod_producto(+)';

    IF (EV_tipProducto = CN_CODUSO_POSTPAGO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_POSTPAGO ;
    ELSIF (EV_tipProducto = CN_CODUSO_HIBRIDO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_HIBRIDO;
    END IF;

    LV_Sql :=  LV_Sql1 || LV_Sql2;

    LN_contador := 0;
    EXECUTE IMMEDIATE LV_sql INTO LN_contador;

    -- Obtiene todos los planes
    LV_Sql1 :='SELECT p.cod_plantarif,'
            || '  p.des_plantarif, p.cod_tiplan, p.tip_plantarif'
                        || '  ,(a.val_cant_terminales - a.val_cant_vendidos) as can_ter_disp';

    LV_Sql :=  LV_Sql1 || LV_Sql2;

    OPEN SC_cursorDatos FOR LV_Sql;

    IF (LN_contador = 0) THEN
                IF (CV_TIPPROSCL_PREPAGO = EV_tipProducto) THEN
                    RAISE no_data_found_prepago;
                ELSIF (CV_TIPPROSCL_POSTPAGO = EV_tipProducto) THEN
                    RAISE no_data_found_postpago;
                ELSIF (CV_TIPPROSCL_HIBRIDO = EV_tipProducto) THEN
                    RAISE no_data_found_hibrido;
                ELSE
            RAISE no_data_found_cursor;
                END IF;
    END IF;

EXCEPTION
        WHEN no_data_found_prepago THEN
             SN_codRetorno := CN_ERROR_NODATAPREPAGO;
             SV_menRetorno := CV_ERROR_NODATAPREPAGO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_postpago THEN
             SN_codRetorno := CN_ERROR_NODATAPOSTPAGO;
             SV_menRetorno := CV_ERROR_NODATAPOSTPAGO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_hibrido THEN
             SN_codRetorno := CN_ERROR_NODATAHIBRIDO;
             SV_menRetorno := CV_ERROR_NODATAHIBRIDO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_cursor THEN
             SN_codRetorno := CN_ERROR_NODATAFOUNDSOL;
             SV_menRetorno := CV_ERROR_NODATAFOUNDSOL;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
             SN_codRetorno := CN_ERROR_OTHERS;
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR;- ' || SQLERRM;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_ERROR_NOCLASIF;
             END IF;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
END PV_getlistPlanTarifSolic_PR;

-------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_getlistPlanTarifCteExc_PR(EV_tipProducto    IN ta_plantarif.COD_TIPLAN%TYPE,
                                       EV_tipPlanTarif   IN ta_plantarif.TIP_PLANTARIF%TYPE,
                                       EN_codRestriccion IN erd_excepcion.COD_RESTRIC%TYPE,
                                       SC_cursorDatos    OUT NOCOPY REFCURSOR,
                                       SN_codRetorno     OUT NOCOPY ge_errores_pg.CODERROR,
                                       SV_menRetorno     OUT NOCOPY ge_errores_pg.MSGERROR,
                                       SN_numEvento      OUT NOCOPY ge_errores_pg.EVENTO) IS
/*
<Documentación TipoDoc = 'Procedimiento'>
    Elemento Nombre = 'PV_getlistPlanTarifCtesExc_PR'
    Lenguaje='PL/SQL'
    Fecha='11-04-2008'
    Versión='1.0.0'
    Diseñador='wjrc'
    Programador='wjrc'
    Ambiente='BD'
<Retorno>
    Cursor
</Retorno>
<Descripción>
    Retorna lista planes tarifario segun numero identificador y tipo de solicitud.
    Clientes excepcionados.
    Fue creado sólo para CPU y TRASABO ya que estas procedimientos no considran el campo ind_comer_web.
</Descripción>
<Parámetros>
  <Entrada>
    <param nom='EV_tipProducto'      Tipo='STRING'> Tipo de producto </param>
    <param nom='EV_tipPlanTarif'     Tipo='STRING'> Tipo de plan tarifario </param>
    <param nom='EN_codRestriccion'   Tipo='NUMBER'> Codigo de restriccion </param>
  </Entrada>
  <Salida>
    <param nom='SC_cursorDatos' Tipo='CURSOR'> cursor planes tarifario </param>
    <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
    <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
    <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
   </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
    no_data_found_prepago  EXCEPTION;
    no_data_found_postpago EXCEPTION;
    no_data_found_hibrido  EXCEPTION;
    no_data_found_cursor   EXCEPTION;

    LV_desError              ge_errores_pg.desevent;
    LV_sql                   ge_errores_pg.vquery;
    LV_sql1                  ge_errores_pg.vquery;
    LV_sql2                  ge_errores_pg.vquery;
    LN_contador              NUMBER;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    -- Controlamos datos
    -- Obtiene todos los planes
    LV_Sql1 := 'SELECT COUNT(1)';

    LV_Sql2 := LV_Sql2 || ' FROM ta_plantarif p, ga_planuso b';
    LV_Sql2 := LV_Sql2 || ' WHERE p.cod_producto = ' || CN_PRODUCTO;

        IF (EV_tipProducto IS NOT NULL) THEN
           LV_Sql2 := LV_Sql2 || ' AND p.cod_tiplan = ''' || EV_tipProducto || '''';
    END IF;

        IF (EV_tipPlanTarif IS NOT NULL) THEN
        LV_Sql2 := LV_Sql2 || ' AND p.tip_plantarif = ''' || EV_tipPlanTarif || '''';
        END IF;

--     IF (EN_codRestriccion = CN_PLANES_COMERCIALI) THEN
--     -- Filtra a solo planes comercializables
--         LV_Sql2 := LV_Sql2 || ' AND SYSDATE BETWEEN p.fec_desde AND NVL(p.fec_hasta,SYSDATE)';
--     ELSE
--         IF (EN_codRestriccion = CN_PLANES_NOCOMERCIA) THEN
--         -- Filtra a solo planes no comercializables
--            LV_Sql2 := LV_Sql2 || ' AND NOT (SYSDATE BETWEEN p.fec_desde AND NVL(p.fec_hasta,SYSDATE))';
--         END IF;
--     END IF;

    IF (EN_codRestriccion = CN_PLANES_NOCOMERCIA) THEN
    -- No se obtienen planes no comercializables
            LV_Sql2 := LV_Sql2 || ' AND p.cod_plantarif = ''XYZ'''; -- para que el cursor se genere vacio
        ELSE
    -- Filtra a solo planes comercializables
        LV_Sql2 := LV_Sql2 || ' AND SYSDATE BETWEEN p.fec_desde AND NVL(p.fec_hasta,SYSDATE)';
    END IF;

--    LV_Sql2 := LV_Sql2 || ' AND p.ind_comer_web = ' || CN_PLANCOMERVIAWEB;
    LV_Sql2 := LV_Sql2 || ' AND p.cla_plantarif <> ''SRV''';
    LV_Sql2 := LV_Sql2 || ' AND p.cod_plantarif = b.cod_plantarif';
    LV_Sql2 := LV_Sql2 || ' AND p.cod_producto = b.cod_producto(+)';

    IF (EV_tipProducto = CN_CODUSO_POSTPAGO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_POSTPAGO ;
    ELSIF (EV_tipProducto = CN_CODUSO_HIBRIDO) THEN
            LV_Sql2 := LV_Sql2 || '   AND b.cod_uso = ' || CN_CODUSO_HIBRIDO;
    END IF;

    LV_sql := LV_sql1 || LV_sql2;

    LN_contador := 0;
    EXECUTE IMMEDIATE LV_sql INTO LN_contador;

    -- Obtiene todos los planes
    LV_Sql1 := 'SELECT p.cod_plantarif,p.des_plantarif,p.cod_tiplan, p.tip_plantarif,0 AS can_ter_disp';

    LV_sql := LV_sql1 || LV_sql2;

    OPEN SC_cursorDatos FOR LV_sql;

    IF (LN_contador = 0) THEN
                IF (CV_TIPPROSCL_PREPAGO = EV_tipProducto) THEN
                    RAISE no_data_found_prepago;
                ELSIF (CV_TIPPROSCL_POSTPAGO = EV_tipProducto) THEN
                    RAISE no_data_found_postpago;
                ELSIF (CV_TIPPROSCL_HIBRIDO = EV_tipProducto) THEN
                    RAISE no_data_found_hibrido;
                ELSE
            RAISE no_data_found_cursor;
                END IF;
    END IF;

EXCEPTION
        WHEN no_data_found_prepago THEN
             SN_codRetorno := CN_ERROR_NODATAPREPAGO;
             SV_menRetorno := CV_ERROR_NODATAPREPAGO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_postpago THEN
             SN_codRetorno := CN_ERROR_NODATAPOSTPAGO;
             SV_menRetorno := CV_ERROR_NODATAPOSTPAGO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_hibrido THEN
             SN_codRetorno := CN_ERROR_NODATAHIBRIDO;
             SV_menRetorno := CV_ERROR_NODATAHIBRIDO;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifSolic_PR',
             LV_Sql, SQLCODE, LV_desError);
        WHEN no_data_found_cursor THEN
             SN_codRetorno := CN_ERROR_NODATAFOUNDEXC;
             SV_menRetorno := CV_ERROR_NODATAFOUNDEXC;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifCteExc',
             LV_Sql, SQLCODE, LV_desError);
        WHEN OTHERS THEN
             SN_codRetorno := CN_ERROR_OTHERS;
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifCteExc_PR;- ' || SQLERRM;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                SV_menRetorno := CV_ERROR_NOCLASIF;
             END IF;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.PV_getlistPlanTarifCteExc_PR',
             LV_Sql, SQLCODE, LV_desError);
END PV_getlistPlanTarifCteExc_PR;

-------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ER_getdatosSolicitud_PR     (EN_numSolicitud      IN ERT_SOLICITUD.NUM_SOLICITUD%TYPE,
                                      SV_NOM_USUARIO        OUT NOCOPY ERT_SOLICITUD.NOM_USUARIO_EVALUACION%TYPE,
                                      SV_fecha_creacion     OUT NOCOPY ERT_SOLICITUD.FEC_INGRESO_H%TYPE,
                                      SN_codRetorno         OUT NOCOPY ge_errores_pg.CODERROR,
                                      SV_menRetorno         OUT NOCOPY ge_errores_pg.MSGERROR,
                                      SN_numEvento          OUT NOCOPY ge_errores_pg.EVENTO)
/*
<Documentación TipoDoc = 'Procedimiento'>
   Elemento Nombre = 'ER_getNomUsuario_PR'
   Lenguaje='PL/SQL'
   Fecha='03-12-2008'
   Versión='1.0.0'
   Diseñador='****'
   Programador='****'
   Ambiente='BD'
<Retorno>
   Cursor
</Retorno>
<Descripción>
   Retorna Nombre de usuario que realizo la evaluacion de Riesgo
</Descripción>
<Parámetros>
   <Entrada>
     <param nom='EN_numSolicitud' Tipo='NUMBER'> Numero de solicitud </param>
   </Entrada>
   <Salida>
     <param nom='SV_NOM_USUARIO' Tipo='STRING'> Nombre de usuario que realizo Evaluacion </param>
     <param nom='SN_codRetorno'  Tipo='NUMBER'> codigo de retorno del procedimiento </param>
     <param nom='SV_menRetorno'  Tipo='STRING'> Mensaje de retorno del procedimiento </param>
     <param nom='SN_numEvento'   Tipo='NUMBER'> numero de evento en caso de error en ejecucion </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
    LV_Sql               ge_errores_pg.vquery;
    LV_desError          ge_errores_pg.desevent;
BEGIN
    SN_codRetorno := 0;
    SV_menRetorno := NULL;
    SN_numEvento  := 0;

    BEGIN

        lv_sql:='SELECT NOM_USUARIO_EVALUACION,FEC_INGRESO_H'
        || 'FROM ERT_SOLICITUD'
        || 'WHERE NUM_SOLICITUD= ' || en_numsolicitud;



        SELECT nom_usuario_evaluacion, fec_ingreso_h
          INTO sv_nom_usuario, sv_fecha_creacion
          FROM ert_solicitud
         WHERE num_solicitud = en_numsolicitud;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        NULL;
    END;

EXCEPTION
        WHEN OTHERS THEN
             SN_codRetorno := CN_ERROR_OTHERS;
             LV_desError   := 'OTHERS:ER_servicios_evalriesgo_web_PG.ER_getNombreCliente_PR;- ' || SQLERRM;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
                 SV_menRetorno := CV_ERROR_NOCLASIF;
             END IF;
             SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,
             SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.ER_getNombreCliente_PR',
             LV_Sql, SQLCODE, LV_desError);


END ER_getdatosSolicitud_PR;


END ER_servicios_evalriesgo_web_PG;
/
