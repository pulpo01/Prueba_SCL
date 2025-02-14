CREATE OR REPLACE PACKAGE BODY FA_AUDITORIA_PG
IS
------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_version_fn RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Función>
   <Elemento
      Nombre = "FA_VERSION_FN"
      Lenguaje="PL/SQL"
      Fecha="23-11-2005"
      Versión="La del package"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>Versión y subversión del package</Retorno>
      <Descripción>Mostrar versión y subversión del package</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
BEGIN
   RETURN('Version : '||CV_version||' <--> SubVersion : '||CV_subversion);
END;
---------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE fa_impuesto_in_pr (EN_num_transaccion IN ga_transacabo.num_transaccion%type,
                             EN_cod_catimpos    IN ge_impuestos.cod_catimpos%type,
                             EN_cod_zonaimpo    IN ge_impuestos.cod_zonaimpo%type,
                             EN_cod_zonaabon    IN ge_impuestos.cod_zonaabon%type,
                             EN_cod_tipimpues   IN ge_impuestos.cod_tipimpues%type,
                             EN_cod_grpservi    IN ge_impuestos.cod_grpservi%type,
                             EV_fec_desde       IN VARCHAR2,
                             EN_cod_concgene    IN ge_impuestos.cod_concgene%type,
                             EV_fec_hasta       IN VARCHAR2,
                             EN_prc_impuesto    IN ge_impuestos.prc_impuesto%type)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "fa_impuesto_in_pr"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>ECU-05017 Porción de código que analiza y procede a insertar el Impuesto.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_transaccion" Tipo="NUMERICO">Numero Transaccion</param>
            <param nom="EN_cod_catimpos"    Tipo="NUMERICO"> Categoria impositiva del centro emisor </param>
            <param nom="EN_cod_zonaimpo"    Tipo="NUMERICO"> Division en zonas impositivas del pais </param>
            <param nom="EN_cod_zonaabon"    Tipo="NUMERICO"> Zona Impositiva del Abonado.</param>
            <param nom="EN_cod_tipimpues"   Tipo="NUMERICO"> Codigo de Tipo de Iva </param>
            <param nom="EN_cod_grpservi"    Tipo="NUMERICO"> Codigo grupo de servicio </param>
            <param nom="EV_fec_desde"       Tipo="VARCHAR2"> Fecha de entrada en vigencia del impuesto </param>
            <param nom="EN_cod_concgene"    Tipo="NUMERICO"> Concepto de facturacion que genera </param>
            <param nom="EV_fec_hasta"       Tipo="VARCHAR2"> Fecha Fin Periodo </param>
            <param nom="EN_prc_impuesto"    Tipo="NUMERICO"> Porcentaje de impuesto </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    LV_des_error         ge_errores_pg.DesEvent;
    LV_Sql               ge_errores_pg.vQuery;
    LN_Existe            NUMBER(2);
    LN_cod_Error         ge_errores_pg.CodError;
    LV_mens_Error        ge_errores_pg.MsgError;
    LN_num_evento        ge_errores_pg.Evento;
    LV_des_cadena        ga_transacabo.des_cadena%type;
    LN_cod_retorno       ga_transacabo.cod_retorno%type;
    LD_fec_desde         ge_impuestos.fec_desde%type;
    LD_fec_hasta         ge_impuestos.fec_hasta%type;
    LV_formato_fecha     VARCHAR2(40);
    error_ejec_omensaje  EXCEPTION;
    BEGIN
            LN_cod_Error    :=0;
            LV_mens_Error   :=NULL;
        LN_num_evento   :=0;
        LV_des_cadena   :=NULL;
        LV_formato_fecha:=TRIM(ge_fn_devvalparam(CV_cod_modparam,CN_cod_producto,CV_formato_sel2));
        LV_formato_fecha:=TRIM(LV_formato_fecha)|| ' ' ||TRIM(ge_fn_devvalparam(CV_cod_modparam,CN_cod_producto,CV_formato_sel7));
        LD_fec_desde    :=TO_DATE(EV_fec_desde,LV_formato_fecha);
        LD_fec_hasta    :=TO_DATE(EV_fec_hasta,LV_formato_fecha);

        --Validaciones de parámetros
        LV_Sql :='FA_AUDITORIA_PG.fa_categoria_imp_fn('||EN_cod_catimpos||');';
        IF NOT FA_AUDITORIA_PG.fa_categoria_imp_fn(EN_cod_catimpos) THEN
           LN_cod_Error:=40;
           RAISE error_ejec_omensaje;
        END IF;

        LV_Sql :='FA_AUDITORIA_PG.fa_zona_imp_fn('||EN_cod_zonaimpo||');';
        IF NOT FA_AUDITORIA_PG.fa_zona_imp_fn(EN_cod_zonaimpo) THEN
           LN_cod_Error:=614;
           RAISE error_ejec_omensaje;
        END IF;
        LV_Sql :='FA_AUDITORIA_PG.fa_zona_imp_fn('||EN_cod_zonaabon||');';
        IF NOT FA_AUDITORIA_PG.fa_zona_imp_fn(EN_cod_zonaabon) THEN
           LN_cod_Error:=615;
           RAISE error_ejec_omensaje;
        END IF;
        LV_Sql :='FA_AUDITORIA_PG.fa_tipo_impuesto_fn('||EN_cod_tipimpues||');';
        IF NOT FA_AUDITORIA_PG.fa_tipo_impuesto_fn(EN_cod_tipimpues) THEN
           LN_cod_Error:=616;
           RAISE error_ejec_omensaje;
        END IF;
        LV_Sql :='FA_AUDITORIA_PG.fa_grpservicios_fn('||EN_cod_grpservi||');';
        IF NOT FA_AUDITORIA_PG.fa_grpservicios_fn(EN_cod_grpservi) THEN
           LN_cod_Error:=617;
           RAISE error_ejec_omensaje;
        END IF;
        LV_Sql :='FA_AUDITORIA_PG.fa_concepto_fac_fn('||EN_cod_concgene||');';
        IF NOT FA_AUDITORIA_PG.fa_concepto_fac_fn(EN_cod_concgene) THEN
           LN_cod_Error:=618;
           RAISE error_ejec_omensaje;
        END IF;
        --Validar la existencia del registro antes de insertarlo
        LV_Sql:='SELECT COUNT(1) INTO INTO LN_Existe FROM GE_IMPUESTOS '||
        'WHERE COD_CATIMPOS ='||EN_cod_catimpos ||
        'AND COD_ZONAIMPO   ='||EN_cod_zonaimpo ||
        'AND COD_ZONAABON   ='||EN_cod_zonaabon ||
        'AND COD_TIPIMPUES  ='||EN_cod_tipimpues||
        'AND COD_GRPSERVI   ='||EN_cod_grpservi ||
        'AND FEC_DESDE      ='||LD_fec_desde;

        SELECT COUNT(1)
        INTO LN_Existe
        FROM GE_IMPUESTOS
        WHERE COD_CATIMPOS = EN_cod_catimpos
          AND COD_ZONAIMPO = EN_cod_zonaimpo
          AND COD_ZONAABON = EN_cod_zonaabon
          AND COD_TIPIMPUES= EN_cod_tipimpues
          AND COD_GRPSERVI = EN_cod_grpservi
          AND FEC_DESDE    = LD_fec_desde;
        IF LN_Existe > 0 THEN
           LN_cod_Error:=110;
           RAISE error_ejec_omensaje;
        END IF;
        --Insertar GE_IMPUESTOS ....
        LV_Sql:='INSERT INTO GE_IMPUESTOS (COD_CATIMPOS, COD_ZONAIMPO,COD_ZONAABON, COD_TIPIMPUES, COD_GRPSERVI,'||
        ' FEC_DESDE,COD_CONCGENE, FEC_HASTA, PRC_IMPUESTO) VALUES '||
        ' ('||EN_cod_catimpos||','||EN_cod_zonaimpo||','||EN_cod_zonaabon||','||EN_cod_tipimpues||','||EN_cod_grpservi||','||LD_fec_desde||','||EN_cod_concgene||','|| LD_fec_hasta||','||EN_prc_impuesto||')';

        INSERT INTO GE_IMPUESTOS
        (COD_CATIMPOS, COD_ZONAIMPO,COD_ZONAABON, COD_TIPIMPUES, COD_GRPSERVI, FEC_DESDE,COD_CONCGENE, FEC_HASTA, PRC_IMPUESTO)
        VALUES (EN_cod_catimpos, EN_cod_zonaimpo, EN_cod_zonaabon, EN_cod_tipimpues,EN_cod_grpservi, LD_fec_desde, EN_cod_concgene, LD_fec_hasta, EN_prc_impuesto);
        IF SQL%ROWCOUNT = 0 THEN
           LN_cod_Error:=4;
           RAISE error_ejec_omensaje;
        END IF;
        LN_cod_retorno:=0;
        LV_des_cadena :='OK';
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
EXCEPTION
WHEN error_ejec_omensaje THEN
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_Error,LV_mens_Error) THEN
             LV_mens_Error:=CV_error_no_clasIF;
        END IF;
        LV_des_error  :='error_ejec_omensaje:fa_impuesto_in_pr('||EN_num_transaccion||','||EN_cod_catimpos||','||EN_cod_zonaimpo||','||EN_cod_zonaabon||','||EN_cod_tipimpues||','||EN_cod_grpservi||','||EV_fec_desde||','||EN_cod_concgene||','||EV_fec_hasta||','||EN_prc_impuesto||')- '||SUBSTR(SQLERRM,1,50);
        LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo,LV_mens_Error,CV_version||'.'||CV_subversion, USER, 'FA_AUDITORIA_PG.fa_impuesto_in_pr', LV_Sql , SQLCODE, LV_des_error );
        LV_des_cadena :='Evento: '||LN_num_evento||' Codigo Error: '||LN_cod_Error||' Mensaje Error: '||LV_mens_Error;
        LN_cod_retorno:=4;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
WHEN OTHERS THEN
        LN_cod_Error:=302;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_Error,LV_mens_Error) THEN
             LV_mens_Error:=CV_error_no_clasIF;
        END IF;
        LV_des_error  :='OTHERS:fa_impuesto_in_pr('||EN_num_transaccion||','||EN_cod_catimpos||','||EN_cod_zonaimpo||','||EN_cod_zonaabon||','||EN_cod_tipimpues||','||EN_cod_grpservi||','||EV_fec_desde||','||EN_cod_concgene||','||EV_fec_hasta||','||EN_prc_impuesto||')- '||SUBSTR(SQLERRM,1,50);
        LN_num_evento := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo,LV_mens_Error,CV_version||'.'||CV_subversion, USER, 'FA_AUDITORIA_PG.fa_impuesto_in_pr', LV_Sql , SQLCODE, LV_des_error );
        LV_des_cadena :='Evento: '||LN_num_evento||' Codigo Error: '||LN_cod_Error||' Mensaje Error: '||LV_mens_Error;
        LN_cod_retorno:=4;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
END fa_impuesto_in_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE fa_impuesto_up_pr (EN_num_transaccion IN ga_transacabo.num_transaccion%type,
                             EN_cod_catimpos    IN ge_impuestos.cod_catimpos%type,
                             EN_cod_zonaimpo    IN ge_impuestos.cod_zonaimpo%type,
                             EN_cod_zonaabon    IN ge_impuestos.cod_zonaabon%type,
                             EN_cod_tipimpues   IN ge_impuestos.cod_tipimpues%type,
                             EN_cod_grpservi    IN ge_impuestos.cod_grpservi%type,
                             EV_fec_desde       IN VARCHAR2,
                             EN_cod_concgene    IN ge_impuestos.cod_concgene%type,
                             EV_fec_hasta       IN VARCHAR2,
                             EN_prc_impuesto    IN ge_impuestos.prc_impuesto%type,
                                                         EN_TipoActual      IN Number,
                                                         EV_fec_desdePost   IN VARCHAR2 DEFAULT NULL)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "fa_impuesto_up_pr"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>ECU-05017 Porción de código que analiza y procede a insertar el Impuesto.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_transaccion" Tipo="NUMERICO">Numero Transaccion</param>
            <param nom="EN_cod_catimpos"    Tipo="NUMERICO"> Categoria impositiva del centro emisor </param>
            <param nom="EN_cod_zonaimpo"    Tipo="NUMERICO"> Division en zonas impositivas del pais </param>
            <param nom="EN_cod_zonaabon"    Tipo="NUMERICO"> Zona Impositiva del Abonado.</param>
            <param nom="EN_cod_tipimpues"   Tipo="NUMERICO"> Codigo de Tipo de Iva </param>
            <param nom="EN_cod_grpservi"    Tipo="NUMERICO"> Codigo grupo de servicio </param>
            <param nom="EV_fec_desde"       Tipo="VARCHAR2"> Fecha de entrada en vigencia del impuesto </param>
            <param nom="EN_cod_concgene"    Tipo="NUMERICO"> Concepto de facturacion que genera </param>
            <param nom="EV_fec_hasta"       Tipo="VARCHAR2"> Fecha Fin Periodo </param>
            <param nom="EN_prc_impuesto"    Tipo="NUMERICO"> Porcentaje de impuesto </param>
            <param nom="EN_TipoActual"      Tipo="NUMERICO"> Tipo de Condicion </param>
            <param nom="EV_fec_desdePost"   Tipo="VARCHAR2"> Fecha desde Posterior </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error         ge_errores_pg.DesEvent;
    LV_Sql               ge_errores_pg.vQuery;
    LN_Existe            NUMBER(2);
    LN_cod_Error         ge_errores_pg.CodError;
    LV_mens_Error        ge_errores_pg.MsgError;
    LN_num_evento        ge_errores_pg.Evento;
    LV_des_cadena        ga_transacabo.des_cadena%type;
    LN_cod_retorno       ga_transacabo.cod_retorno%type;
    LD_fec_desde         ge_impuestos.fec_desde%type;
    LD_fec_hasta         ge_impuestos.fec_hasta%type;
    LD_fec_desdePost     ge_impuestos.fec_desde%type;
    LV_formato_fecha     VARCHAR2(40);
    error_ejec_omensaje  EXCEPTION;
    BEGIN
        LN_cod_Error    :=0;
        LV_mens_Error   :=NULL;
        LN_num_evento   :=0;
        LV_des_cadena   :=NULL;
        LV_Sql          :=NULL;
        LV_formato_fecha:=TRIM(ge_fn_devvalparam(CV_cod_modparam,CN_cod_producto,CV_formato_sel2));
        LV_formato_fecha:=TRIM(LV_formato_fecha)|| ' ' ||TRIM(ge_fn_devvalparam(CV_cod_modparam,CN_cod_producto,CV_formato_sel7));
        LD_fec_desde    :=TO_DATE(EV_fec_desde,LV_formato_fecha);
        LD_fec_hasta    :=TO_DATE(EV_fec_hasta,LV_formato_fecha);
        --Validar la existencia del registro antes de modificar
        LV_Sql:='SELECT COUNT(1) INTO INTO LN_Existe FROM GE_IMPUESTOS '||
        'WHERE COD_CATIMPOS ='||EN_cod_catimpos ||
        'AND COD_ZONAIMPO   ='||EN_cod_zonaimpo ||
        'AND COD_ZONAABON   ='||EN_cod_zonaabon ||
        'AND COD_TIPIMPUES  ='||EN_cod_tipimpues||
        'AND COD_GRPSERVI   ='||EN_cod_grpservi ||
        'AND FEC_DESDE      ='||LD_fec_desde;

        SELECT COUNT(1)
        INTO LN_Existe
        FROM GE_IMPUESTOS
        WHERE COD_CATIMPOS = EN_cod_catimpos
          AND COD_ZONAIMPO = EN_cod_zonaimpo
          AND COD_ZONAABON = EN_cod_zonaabon
          AND COD_TIPIMPUES= EN_cod_tipimpues
          AND COD_GRPSERVI = EN_cod_grpservi
          AND FEC_DESDE    = LD_fec_desde;
        IF LN_Existe = 0 THEN
           LN_cod_Error:=619;
           RAISE error_ejec_omensaje;
        END IF;
                IF EN_TipoActual = 0 THEN --ACTUALIZACION NORMAL
           LV_Sql :='FA_AUDITORIA_PG.fa_concepto_fac_fn('||EN_cod_concgene||');';
           IF EN_cod_concgene IS NOT NULL THEN
              IF NOT FA_AUDITORIA_PG.fa_concepto_fac_fn(EN_cod_concgene) THEN
                 LN_cod_Error:=618;
                 RAISE error_ejec_omensaje;
              END IF;
           END IF;
           --Validación de Fechas (Fecha Hasta debe mayor que fecha desde)
           LV_Sql :='fecha desde('||LD_fec_desde||')'||'fecha hasta('||LD_fec_hasta||');';
           IF LD_fec_hasta IS NOT NULL THEN
              IF LD_fec_desde > LD_fec_hasta THEN
                 LN_cod_Error:=426;
                 RAISE error_ejec_omensaje;
              END IF;
           END IF;
           LV_Sql :='Pocentaje entre 0 ('||EN_prc_impuesto||')'||' y 100';
           --Validar porcentaje entre 0 y 100
           IF EN_prc_impuesto IS NOT NULL THEN
              IF NOT (EN_prc_impuesto >=0 AND EN_prc_impuesto <= 100) THEN
                 LN_cod_Error:=620;
                 RAISE error_ejec_omensaje;
              END IF;
           END IF;
               LV_Sql :='UPDATE GE_IMPUESTOS SET cod_concgene =DECODE('||EN_cod_concgene||', NULL, cod_concgene,'||EN_cod_concgene||'),'||
                ' fec_hasta =DECODE('||LD_fec_hasta||', NULL, fec_hasta,'||LD_fec_hasta||'),'||
                ' prc_impuesto =DECODE('||EN_prc_impuesto||', NULL, prc_impuesto,'||EN_prc_impuesto||')'||
                ' WHERE COD_CATIMPOS='||EN_cod_catimpos||
                ' AND  COD_ZONAIMPO ='||EN_cod_zonaimpo||
                ' AND  COD_ZONAABON ='||EN_cod_zonaabon||
                ' AND  COD_TIPIMPUES='||EN_cod_tipimpues||
                ' AND  COD_GRPSERVI ='||EN_cod_grpservi||
                ' AND  FEC_DESDE    ='||LD_fec_desde;
                    --DML UPDATE
                    UPDATE GE_IMPUESTOS
                    SET  cod_concgene =DECODE(EN_cod_concgene, NULL, cod_concgene, EN_cod_concgene),
                 fec_hasta    =DECODE(LD_fec_hasta, NULL, fec_hasta, LD_fec_hasta),
                 prc_impuesto =DECODE(EN_prc_impuesto, NULL, prc_impuesto, EN_prc_impuesto)
                    WHERE COD_CATIMPOS = EN_cod_catimpos
                      AND COD_ZONAIMPO = EN_cod_zonaimpo
                      AND COD_ZONAABON = EN_cod_zonaabon
                      AND COD_TIPIMPUES= EN_cod_tipimpues
                      AND COD_GRPSERVI = EN_cod_grpservi
                      AND FEC_DESDE    = LD_fec_desde;
                ELSIF EN_TipoActual = 1 THEN --ACTUALIZACION FEC_HASTA
                    LV_Sql :='UPDATE GE_IMPUESTOS SET fec_hasta ='||LD_fec_hasta||
                ' WHERE COD_CATIMPOS='||EN_cod_catimpos||
                ' AND  COD_ZONAIMPO ='||EN_cod_zonaimpo||
                ' AND  COD_ZONAABON ='||EN_cod_zonaabon||
                ' AND  COD_TIPIMPUES='||EN_cod_tipimpues||
                ' AND  COD_GRPSERVI ='||EN_cod_grpservi||
                ' AND  FEC_DESDE    ='||LD_fec_desde;
                    --DML UPDATE
                    UPDATE GE_IMPUESTOS
                    SET  fec_hasta     = LD_fec_hasta
                    WHERE COD_CATIMPOS = EN_cod_catimpos
                      AND COD_ZONAIMPO = EN_cod_zonaimpo
                      AND COD_ZONAABON = EN_cod_zonaabon
                      AND COD_TIPIMPUES= EN_cod_tipimpues
                      AND COD_GRPSERVI = EN_cod_grpservi
                      AND FEC_DESDE    = LD_fec_desde;
                ELSIF EN_TipoActual = 2 THEN --ACTUALIZACION FECHA DESDE
                        LD_fec_desdePost    :=TO_DATE(EV_fec_desdePost,LV_formato_fecha);
                    LV_Sql :='UPDATE GE_IMPUESTOS fec_desde ='||LD_fec_desdePost||
                ' WHERE COD_CATIMPOS='||EN_cod_catimpos||
                ' AND  COD_ZONAIMPO ='||EN_cod_zonaimpo||
                ' AND  COD_ZONAABON ='||EN_cod_zonaabon||
                ' AND  COD_TIPIMPUES='||EN_cod_tipimpues||
                ' AND  COD_GRPSERVI ='||EN_cod_grpservi||
                ' AND  FEC_DESDE    ='||LD_fec_desde;
                    --DML UPDATE
                    UPDATE GE_IMPUESTOS
                    SET   fec_desde    = LD_fec_desdePost
                    WHERE COD_CATIMPOS = EN_cod_catimpos
                      AND COD_ZONAIMPO = EN_cod_zonaimpo
                      AND COD_ZONAABON = EN_cod_zonaabon
                      AND COD_TIPIMPUES= EN_cod_tipimpues
                      AND COD_GRPSERVI = EN_cod_grpservi
                      AND FEC_DESDE    = LD_fec_desde;
                END IF;
        IF SQL%ROWCOUNT = 0 THEN
            LN_cod_Error:=2;
            RAISE error_ejec_omensaje;
        END IF;
        LN_cod_retorno:=0;
        LV_des_cadena :='OK';
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
EXCEPTION
WHEN error_ejec_omensaje THEN
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_Error,LV_mens_Error) THEN
             LV_mens_Error:=CV_error_no_clasIF;
        END IF;
        LV_des_error :='error_ejec_omensaje:fa_impuesto_up_pr('||EN_num_transaccion||','||EN_cod_catimpos||','||EN_cod_zonaimpo||','||EN_cod_zonaabon||','||EN_cod_tipimpues||','||EN_cod_grpservi||','||EV_fec_desde||','||EN_cod_concgene||','||EV_fec_hasta||','||EN_prc_impuesto||')- '||SUBSTR(SQLERRM,1,50);
        LN_num_evento:= Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo,LV_mens_Error,CV_version||'.'||CV_subversion, USER, 'FA_AUDITORIA_PG.fa_impuesto_up_pr', LV_Sql , SQLCODE, LV_des_error );
        LV_des_cadena :='Evento: '||LN_num_evento||' Codigo Error: '||LN_cod_Error||' Mensaje Error: '||LV_mens_Error;
        LN_cod_retorno:=4;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
WHEN OTHERS THEN
        LN_cod_Error:=110;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_Error,LV_mens_Error) THEN
             LV_mens_Error:=CV_error_no_clasIF;
        END IF;
        LV_des_error:='OTHERS:fa_impuesto_up_pr('||EN_num_transaccion||','||EN_cod_catimpos||','||EN_cod_zonaimpo||','||EN_cod_zonaabon||','||EN_cod_tipimpues||','||EN_cod_grpservi||','||EV_fec_desde||','||EN_cod_concgene||','||EV_fec_hasta||','||EN_prc_impuesto||')- '||SUBSTR(SQLERRM,1,50);
        LN_num_evento:= Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo,LV_mens_Error,CV_version||'.'||CV_subversion, USER, 'FA_AUDITORIA_PG.fa_impuesto_up_pr', LV_Sql , SQLCODE, LV_des_error );
        LV_des_cadena :='Evento: '||LN_num_evento||' Codigo Error: '||LN_cod_Error||' Mensaje Error: '||LV_mens_Error;
        LN_cod_retorno:=4;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_Error,LV_des_cadena);
END fa_impuesto_up_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE fa_impuesto_de_pr (EN_num_transaccion IN ga_transacabo.num_transaccion%type,
                             EN_cod_catimpos    IN ge_impuestos.cod_catimpos%type,
                             EN_cod_zonaimpo    IN ge_impuestos.cod_zonaimpo%type,
                             EN_cod_zonaabon    IN ge_impuestos.cod_zonaabon%type,
                             EN_cod_tipimpues   IN ge_impuestos.cod_tipimpues%type,
                             EN_cod_grpservi    IN ge_impuestos.cod_grpservi%type,
                             EV_fec_desde       IN VARCHAR2)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "fa_impuesto_de_pr"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>ECU-05017 Porción de código que analiza y procede a eliminar Impuesto.</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_transaccion" Tipo="NUMERICO">Numero Transaccion</param>
            <param nom="EN_cod_catimpos"    Tipo="NUMERICO"> Categoria impositiva del centro emisor </param>
            <param nom="EN_cod_zonaimpo"    Tipo="NUMERICO"> Division en zonas impositivas del pais </param>
            <param nom="EN_cod_zonaabon"    Tipo="NUMERICO"> Zona Impositiva del Abonado.</param>
            <param nom="EN_cod_tipimpues"   Tipo="NUMERICO"> Codigo de Tipo de Iva </param>
            <param nom="EN_cod_grpservi"    Tipo="NUMERICO"> Codigo grupo de servicio </param>
            <param nom="EV_fec_desde"       Tipo="VARCHAR2"> Fecha de entrada en vigencia del impuesto </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    LV_des_error         ge_errores_pg.DesEvent;
    LV_Sql               ge_errores_pg.vQuery;
    LN_Existe            NUMBER(2);
    LN_cod_Error         ge_errores_pg.CodError;
    LV_mens_Error        ge_errores_pg.MsgError;
    LN_num_evento        ge_errores_pg.Evento;
    LV_des_cadena        ga_transacabo.des_cadena%type;
    LN_cod_retorno       ga_transacabo.cod_retorno%type;
    LD_fec_desde         ge_impuestos.fec_desde%type;
    LV_formato_fecha     VARCHAR2(40);
    error_ejec_omensaje  EXCEPTION;
    BEGIN
        LN_cod_Error    :=0;
        LV_mens_Error   :=NULL;
        LN_num_evento   :=0;
        LV_des_cadena   :=NULL;
        LV_formato_fecha:=TRIM(ge_fn_devvalparam(CV_cod_modparam,CN_cod_producto,CV_formato_sel2));
        LV_formato_fecha:=TRIM(LV_formato_fecha)|| ' ' ||TRIM(ge_fn_devvalparam(CV_cod_modparam,CN_cod_producto,CV_formato_sel7));
        LD_fec_desde    :=TO_DATE(EV_fec_desde,LV_formato_fecha);
            --Validar la existencia del registro antes de Eliminar
        LV_Sql:='SELECT COUNT(1) INTO INTO LN_Existe FROM GE_IMPUESTOS '||
        'WHERE COD_CATIMPOS ='||EN_cod_catimpos ||
        'AND COD_ZONAIMPO   ='||EN_cod_zonaimpo ||
        'AND COD_ZONAABON   ='||EN_cod_zonaabon ||
        'AND COD_TIPIMPUES  ='||EN_cod_tipimpues||
        'AND COD_GRPSERVI   ='||EN_cod_grpservi ||
        'AND FEC_DESDE      ='||LD_fec_desde;

        SELECT COUNT(1)
        INTO LN_Existe
        FROM GE_IMPUESTOS
        WHERE COD_CATIMPOS = EN_cod_catimpos
          AND COD_ZONAIMPO = EN_cod_zonaimpo
          AND COD_ZONAABON = EN_cod_zonaabon
          AND COD_TIPIMPUES= EN_cod_tipimpues
          AND COD_GRPSERVI = EN_cod_grpservi
          AND FEC_DESDE    = LD_fec_desde;
        IF LN_Existe = 0 THEN
           LN_cod_Error:=619;
           RAISE error_ejec_omensaje;
        END IF;

        LV_Sql := 'DELETE FROM GE_IMPUESTOS'||
                  'WHERE COD_CATIMPOS  ='||EN_cod_catimpos||
                  '  AND  COD_ZONAIMPO ='||EN_cod_zonaimpo||
                  '  AND  COD_ZONAABON ='||EN_cod_zonaabon||
                  '  AND  COD_TIPIMPUES='||EN_cod_tipimpues||
                  '  AND  COD_GRPSERVI ='||EN_cod_grpservi||
                  '  AND  FEC_DESDE    ='||LD_fec_desde;

        --DML DELETE
        DELETE FROM GE_IMPUESTOS
        WHERE COD_CATIMPOS = EN_cod_catimpos
         AND  COD_ZONAIMPO = EN_cod_zonaimpo
         AND  COD_ZONAABON = EN_cod_zonaabon
         AND  COD_TIPIMPUES= EN_cod_tipimpues
         AND  COD_GRPSERVI = EN_cod_grpservi
         AND  FEC_DESDE    = LD_fec_desde;
        IF SQL%ROWCOUNT = 0 THEN
            LN_cod_Error:=3;
            RAISE error_ejec_omensaje;
        END IF;
        LN_cod_retorno:=0;
        LV_des_cadena:='OK';
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
EXCEPTION
WHEN error_ejec_omensaje THEN
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_Error,LV_mens_Error) THEN
             LV_mens_Error:=CV_error_no_clasIF;
        END IF;
        LV_des_error:='error_ejec_omensaje:fa_impuesto_de_pr ('||EN_num_transaccion||','||EN_cod_catimpos||','||EN_cod_zonaimpo||','||EN_cod_zonaabon||','||EN_cod_tipimpues||','||EN_cod_grpservi||','||EV_fec_desde||')- '||SUBSTR(SQLERRM,1,50);
        LN_num_evento:= Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo,LV_mens_Error,CV_version||'.'||CV_subversion, USER, 'FA_AUDITORIA_PG.fa_impuesto_de_pr', LV_Sql , SQLCODE, LV_des_error );
        LV_des_cadena :='Evento: '||LN_num_evento||' Codigo Error: '||LN_cod_Error||' Mensaje Error: '||LV_mens_Error;
        LN_cod_retorno:=4;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
WHEN OTHERS THEN
        LN_cod_Error:=110;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_Error,LV_mens_Error) THEN
             LV_mens_Error:=CV_error_no_clasIF;
        END IF;
        LV_des_error:='OTHERS:fa_impuesto_de_pr ('||EN_num_transaccion||','||EN_cod_catimpos||','||EN_cod_zonaimpo||','||EN_cod_zonaabon||','||EN_cod_tipimpues||','||EN_cod_grpservi||','||EV_fec_desde||')- '||SUBSTR(SQLERRM,1,50);
        LN_num_evento:= Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo,LV_mens_Error,CV_version||'.'||CV_subversion, USER, 'FA_AUDITORIA_PG.fa_impuesto_de_pr', LV_Sql , SQLCODE, LV_des_error );
        LV_des_cadena :='Evento: '||LN_num_evento||' Codigo Error: '||LN_cod_Error||' Mensaje Error: '||LV_mens_Error;
        LN_cod_retorno:=4;
        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
        VALUES (EN_num_transaccion,LN_cod_retorno,LV_des_cadena);
END fa_impuesto_de_pr;
---------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_categoria_imp_fn(EN_cod_catimpos  IN ge_impuestos.cod_catimpos%type)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fa_categoria_imp_fn"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene estado de una categoria Impositiva</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_catimpos" Tipo="NUMERICO"> Categoria impositiva del centro emisor </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    LN_cod_catimpos  ge_impuestos.cod_catimpos%type;
BEGIN
    SELECT cod_catimpos
    INTO LN_cod_catimpos
    FROM ge_catimpositiva
    WHERE cod_catimpos = EN_cod_catimpos;
    RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RETURN FALSE;
END fa_categoria_imp_fn;
---------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_zona_imp_fn(EN_cod_zonaimpo  IN ge_impuestos.cod_zonaimpo%type)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fa_zona_imp_fn"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene estado de la zona </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_zonaimpo" Tipo="NUMERICO"> Division en zonas impositivas del pais </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    LN_cod_zonaimpo  ge_impuestos.cod_zonaimpo%type;
BEGIN
    SELECT cod_zonaimpo
    INTO LN_cod_zonaimpo
    FROM ge_zonaimpositiva
    WHERE cod_zonaimpo = EN_cod_zonaimpo;
    RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RETURN FALSE;
END fa_zona_imp_fn;
---------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_tipo_impuesto_fn(EN_cod_tipimpues IN ge_impuestos.cod_tipimpues%type)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fa_tipo_impuesto_fn"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene estado del codigo tipo de Impuesto</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_tipimpues" Tipo="NUMERICO"> Codigo de Tipo de Iva </param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    LN_cod_tipimpues ge_impuestos.cod_tipimpues%type;
BEGIN
    SELECT cod_tipimpue
    INTO LN_cod_tipimpues
    FROM ge_tipimpues
    WHERE cod_tipimpue = EN_cod_tipimpues;
    RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RETURN FALSE;
END fa_tipo_impuesto_fn;
---------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_grpservicios_fn(EN_cod_grpservi IN ge_impuestos.cod_grpservi%type)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fa_grpservicios_fn"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene estado de grupo de servicios</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_grpservi" Tipo="NUMERICO"> Codigo grupo de servicio</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    LN_cod_grpservi ge_impuestos.cod_grpservi%type;
BEGIN
    SELECT cod_grpservi
    INTO LN_cod_grpservi
    FROM ge_grpservicios
    WHERE cod_grpservi = EN_cod_grpservi;
    RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RETURN FALSE;
END fa_grpservicios_fn;
---------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fa_concepto_fac_fn(EN_cod_concgene IN ge_impuestos.cod_concgene%type)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "fa_concepto_fac_fn"
          Lenguaje="PL/SQL"
      Fecha="15-11-2005"
      Versión="1.0"
      Diseñador="Luis Santana L."
      Programador="Luis Santana L."
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Obtiene estado de grupo de servicios</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_concgene" Tipo="NUMERICO"> codigo de concepto de facturacion</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
    LN_cod_concgene ge_impuestos.cod_concgene%type;
BEGIN
    SELECT cod_concepto
    INTO LN_cod_concgene
    FROM fa_conceptos
    WHERE cod_concepto = EN_cod_concgene;
    RETURN TRUE;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RETURN FALSE;
END fa_concepto_fac_fn;

END FA_AUDITORIA_PG;
/
SHOW ERRORS
