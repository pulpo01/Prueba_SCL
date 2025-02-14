CREATE OR REPLACE PACKAGE BODY PV_CONFIG_RENOVACION_PG AS
-------------------------------------------------------------------------------
FUNCTION PV_OBTENERPARAMETRO_FN(EV_nom_parametro  IN ged_parametros.nom_parametro%type,
                                EV_cod_modulo     IN ged_parametros.cod_modulo%type,
                                SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) RETURN VARCHAR2 IS

/*--
        <Documentacion TipoDoc = "Funcion">
            Elemento Nombre = "PV_OBTENERPARAMETRO_FN"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Diseñador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> VARCHAR2 </Retorno>
        <Descripcion>
            retornar parametro del sistema LIB-General
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EV_nom_parametro"    Tipo="NUMBER> parametro sistema</param>
            <param nom="EV_cod_modulo"       Tipo="VARCHAR2> Modulo</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
lv_val_parametro  ged_parametros.val_parametro%type;
BEGIN
        SN_num_evento:= 0;
        SN_cod_retorno:=0;
        SV_mens_retorno:='';

        lv_sSql := ' SELECT  a.val_parametro ';
        lv_sSql := lv_sSql || ' FROM ged_parametros a ';
        lv_sSql := lv_sSql || ' WHERE a.cod_modulo = ' || EV_cod_modulo;
        lv_sSql := lv_sSql || ' AND a.cod_producto = ' || CN_producto;
        lv_sSql := lv_sSql || ' AND a.nom_parametro = ' || EV_nom_parametro;

        SELECT  a.val_parametro
        INTO  LV_val_parametro
        FROM ged_parametros a
        WHERE a.cod_modulo = EV_cod_modulo
        AND a.cod_producto = CN_producto
        AND a.nom_parametro = EV_nom_parametro;

    return LV_val_parametro;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1362;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_CONFIG_RENOVACION_PG.PV_OBTENERPARAMETRO_FN('|| EV_nom_parametro || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,EV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CONFIG_RENOVACION_PG.PV_OBTENERPARAMETRO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PENALIZACION_PG.PV_OBTENERPARAMETRO_FN('|| EV_nom_parametro || '); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,EV_cod_modulo,SV_mens_retorno, '1.0', USER,
          'PV_CONFIG_RENOVACION_PG.PV_OBTENERPARAMETRO_FN', lv_sSql, SN_cod_retorno, LV_des_error );
          return '';
END;

  PROCEDURE PV_REGISRENOVA_PR(              EO_NUM_OS_RENOVA       IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS_RENOVA%TYPE,
                                            EO_NUM_ABONADO         IN PV_REGISTRA_RENOVACION_OS_TO.NUM_ABONADO%TYPE,
                                            EO_COD_OS              IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE,
                                            EO_NOM_USUARIO         IN PV_REGISTRA_RENOVACION_OS_TO.NOM_USUARIO%TYPE,
                                            EO_IND_CARGO           IN PV_REGISTRA_RENOVACION_OS_TO.IND_CARGO%TYPE,
                                            SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                            SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                            SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
 PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

        sn_cod_retorno := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;

        LV_sSql:='INSERT INTO PV_REGISTRA_RENOVACION_OS_TO(';
        LV_sSql:=LV_sSql || 'NUM_OS,NUM_OS_RENOVA,NUM_ABONADO,COD_OS,FEC_INGRESO,NOM_USUARIO,COD_ESTADO)';
        LV_sSql:=LV_sSql || 'VALUES(0,'||EO_NUM_OS_RENOVA||','||EO_NUM_ABONADO||','||EO_COD_OS||','||'SYSDATE'||','||EO_NOM_USUARIO ||','||'PD'||','||EO_IND_CARGO||')';


        INSERT INTO PV_REGISTRA_RENOVACION_OS_TO(
        NUM_OS,
        NUM_OS_RENOVA,
        NUM_ABONADO,
        COD_OS     ,
        FEC_INGRESO,
        NOM_USUARIO,COD_ESTADO,IND_CARGO)
        VALUES
        (
        0,
        EO_NUM_OS_RENOVA,
        EO_NUM_ABONADO,
        EO_COD_OS,
        SYSDATE,
        EO_NOM_USUARIO ,'PD',EO_IND_CARGO
        );
        commit;
EXCEPTION
                WHEN OTHERS THEN
                         SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                      SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_REGISTRARENOVA_PR(0'||EO_NUM_OS_RENOVA||','||EO_NUM_ABONADO||','||EO_COD_OS||','|| EO_NOM_USUARIO ||','||EO_IND_CARGO||')' || SQLERRM;

                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_REGISTRARENOVA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_REGISRENOVA_PR;
-------------------------------------------------------------------------------

PROCEDURE PV_ACTUARENOVA_ODBC_PR(                EO_NUM_TRANSACCION     IN GA_TRANSACABO.NUM_TRANSACCION%TYPE,
                                                 EO_NUM_OS_RENOVA       IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS_RENOVA%TYPE,
                                                 EO_NUM_OS              IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS%TYPE,
                                                 EO_NUM_ABONADO         IN PV_REGISTRA_RENOVACION_OS_TO.NUM_ABONADO%TYPE,
                                                 EO_COD_OS              IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE)
IS
 LV_des_error         ge_errores_pg.DesEvent;
 LV_sSql              ge_errores_pg.vQuery;
 SN_cod_retorno       ge_errores_td.cod_msgerror%TYPE;
 SV_mens_retorno      ge_errores_td.det_msgerror%TYPE;
 SN_num_evento        ge_errores_pg.evento;

BEGIN

        sn_cod_retorno := 0;
        sv_mens_retorno := 'OK';
        sn_num_evento  := 0;

        LV_sSql:='PV_CONFIG_RENOVACION_PG.PV_ACTUARENOVA_PR('||EO_NUM_OS_RENOVA||','||EO_NUM_OS||','||EO_NUM_ABONADO||','||EO_COD_OS||','||sn_cod_retorno||','||sv_mens_retorno||','||sn_num_evento||')';

        PV_CONFIG_RENOVACION_PG.PV_ACTUARENOVA_PR(EO_NUM_OS_RENOVA,EO_NUM_OS,EO_NUM_ABONADO,EO_COD_OS,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

        IF   sn_cod_retorno > 0 THEN
             sv_mens_retorno :=sv_mens_retorno || ' ,EVENTO:' ||sn_num_evento;
        end if;

        LV_sSql:='INSERT INTO GA_TRANSACABO(  NUM_TRANSACCION,COD_RETORNO,DES_CADENA) VALUES('|| EO_NUM_TRANSACCION||','||sn_cod_retorno||','||sv_mens_retorno||')' ;


        INSERT INTO GA_TRANSACABO(  NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
        VALUES( EO_NUM_TRANSACCION,sn_cod_retorno,sv_mens_retorno) ;

EXCEPTION
                WHEN OTHERS THEN
                          SN_cod_retorno := 156;
                         INSERT INTO GA_TRANSACABO(  NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                         VALUES( EO_NUM_TRANSACCION,sn_cod_retorno,CV_error_no_clasif || ' ,EVENTO:' ||sn_num_evento);


                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                      SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_ACTUARENOVA_ODBC_PR('||EO_NUM_TRANSACCION||','||EO_NUM_OS_RENOVA||','||EO_NUM_OS||','||EO_NUM_ABONADO||','||EO_COD_OS||')' || SQLERRM;

                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_ACTUARENOVA_ODBC_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_ACTUARENOVA_ODBC_PR;
-------------------------------------------------------------------------------
PROCEDURE PV_ACTUARENOVA_PR(                EO_NUM_OS_RENOVA       IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS_RENOVA%TYPE,
                                            EO_NUM_OS              IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS%TYPE,
                                            EO_NUM_ABONADO         IN PV_REGISTRA_RENOVACION_OS_TO.NUM_ABONADO%TYPE,
                                            EO_COD_OS              IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE,
                                            SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                            SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                            SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;

BEGIN

        sn_cod_retorno := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;

        IF EO_NUM_ABONADO  > 0 THEN

            LV_sSql:='UPDATE PV_REGISTRA_RENOVACION_OS_TO';
            LV_sSql:=LV_sSql || ' SET  NUM_OS     = '||EO_NUM_OS||','|| 'COD_ESTADO ='||'''OK''';
            LV_sSql:=LV_sSql || ' WHERE  NUM_OS_RENOVA = ' ||EO_NUM_OS_RENOVA|| 'AND' ;
            LV_sSql:=LV_sSql || ' NUM_ABONADO   = ' || EO_NUM_ABONADO  || 'AND';
            LV_sSql:=LV_sSql || ' COD_OS        = ' || EO_COD_OS;


            UPDATE PV_REGISTRA_RENOVACION_OS_TO
            SET
            NUM_OS     = EO_NUM_OS,
            COD_ESTADO ='OK'
            WHERE
            NUM_OS_RENOVA = EO_NUM_OS_RENOVA AND
            NUM_ABONADO   = EO_NUM_ABONADO   AND
            COD_OS        = EO_COD_OS;

        ELSE


            LV_sSql:=' UPDATE PV_REGISTRA_RENOVACION_OS_TO';
            LV_sSql:=LV_sSql || 'SET NUM_OS     = ' ||EO_NUM_OS||','|| 'COD_ESTADO ='||'''OK''';
            LV_sSql:=LV_sSql || ' WHERE  NUM_OS_RENOVA = '||EO_NUM_OS_RENOVA ||'AND '||'COD_OS        ='|| EO_COD_OS;

            UPDATE PV_REGISTRA_RENOVACION_OS_TO
            SET
            NUM_OS     = EO_NUM_OS,
            COD_ESTADO ='OK'
            WHERE
            NUM_OS_RENOVA = EO_NUM_OS_RENOVA AND
            COD_OS        = EO_COD_OS;
        END IF;


EXCEPTION
                WHEN OTHERS THEN
                         SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                      SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_ACTUARENOVA_PR('||EO_NUM_OS_RENOVA||','||EO_NUM_OS||','||EO_NUM_ABONADO||','||EO_COD_OS||')' || SQLERRM;

                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_ACTUARENOVA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_ACTUARENOVA_PR;
-------------------------------------------------------------------------------
PROCEDURE PV_CARGATIPOPROD_PR(SO_Lista_Abonado         IN OUT NOCOPY   refCursor,
                              SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                              SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                              SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CARGATIPOPROD_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
              <param nom="SO_Lista_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error             ge_errores_pg.DesEvent;
 LV_sSql                  ge_errores_pg.vQuery;


BEGIN
                sn_cod_retorno  := 0;
                sv_mens_retorno := NULL;
                sn_num_evento  := 0;


                LV_sSql:=' OPEN SO_Lista_Abonado FOR  select  g.COD_VALOR,g.DES_VALOR';
                LV_sSql:=LV_sSql || ' FROM ged_codigos g where  g.cod_modulo= ' ||CV_cod_modulo;
                LV_sSql:=LV_sSql || ' AND g.nom_tabla ='||'''GE_PRESTACIONES_TD'''|| 'AND g.NOM_COLUMNA='||'''GRP_PRESTACION''';
                LV_sSql:=LV_sSql || ' ORDER BY g.COD_VALOR';

                OPEN SO_Lista_Abonado FOR
                select  g.COD_VALOR,g.DES_VALOR
                FROM ged_codigos g
                where
                g.cod_modulo=CV_cod_modulo
                AND g.nom_tabla ='GE_PRESTACIONES_TD'
                AND g.NOM_COLUMNA='GRP_PRESTACION'
                ORDER BY g.COD_VALOR ASC;

EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_CARGATIPOPROD_PR('||  'SO_Lista_Abonado' ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_CARGATIPOPROD_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CARGATIPOPROD_PR;
-------------------------------------------------------------------------------
PROCEDURE PV_CARGATIPOABO_PR( SO_Lista_Abonado         IN OUT NOCOPY   refCursor,
                              SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                              SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                              SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CARGATIPOABO_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Lista_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql      ge_errores_pg.vQuery;

BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;


         LV_sSql:=' OPEN SO_Lista_Abonado FOR ';
         LV_sSql:=LV_sSql || ' select  g.COD_VALOR,g.DES_VALOR  FROM ged_codigos g where';
         LV_sSql:=LV_sSql || ' g.cod_modulo=CV_cod_modulo  AND g.nom_tabla ='||'CI_TIPORSERV'||' AND g.NOM_COLUMNA='||'IND_ORSERV';
          LV_sSql:=LV_sSql || ' ORDER BY g.COD_VALOR';

         OPEN SO_Lista_Abonado FOR
         select  g.COD_VALOR,g.DES_VALOR
         FROM ged_codigos g
         where
         g.cod_modulo=CV_cod_modulo
         AND g.nom_tabla ='CI_TIPORSERV'
         AND g.NOM_COLUMNA='IND_ORSERV'
         ORDER BY g.COD_VALOR ASC;




EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_CARGATIPOABO_PR('|| 'SO_Lista_Abonado'  ||') '|| SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_CARGATIPOABO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CARGATIPOABO_PR;
-------------------------------------------------------------------------------

PROCEDURE PV_CARGAACCOMER_PR(EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                             EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                             SO_Lista_Abonado         OUT NOCOPY      refCursor/*,
                             SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento            OUT NOCOPY      ge_errores_pg.evento*/)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CARGAACCOMER_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
              <param nom="EO_TIPO_ABONADO" Tipo="NUMERICO">TIPO ABONADO<param>>
             <param nom="EO_TIPO_PRODUCTO" Tipo="NUMERICO">TIPO PRODUCTO<param>>
          </Entrada>
          <Salida>
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
 SN_cod_retorno  ge_errores_td.cod_msgerror%TYPE;
 SV_mens_retorno ge_errores_td.det_msgerror%TYPE;
 SN_num_evento   ge_errores_pg.evento;
 LV_IND_ORSERV   varchar2(6);
BEGIN

        sn_cod_retorno  := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;



        LV_sSql:=' OPEN SO_Lista_Abonado FOR SELECT  COD_OS ,DESCRIPCION FROM  CI_TIPORSERV WHERE COD_OS  IN (SELECT  COD_VALOR ';
        LV_sSql:=LV_sSql || ' FROM GED_CODIGOS WHERE     COD_MODULO='||'GA'||' AND NOM_TABLA ='||'CI_ORSERV'|| 'AND    NOM_COLUMNA='||'COD_OS'|| ' and' ;
        LV_sSql:=LV_sSql || ' cod_os in (select cod_acci_comer PV_RENOVACIONES_TO WHERE tipo_producto ='||EO_TIPO_PRODUCTO|| 'and tipo_abonado    = '||EO_TIPO_ABONADO|| '))';

         LV_IND_ORSERV := '%' || EO_TIPO_ABONADO || '%';

         OPEN SO_LISTA_ABONADO FOR
         SELECT  c.cod_os ,c.descripcion
         FROM  ci_tiporserv c
         WHERE c.cod_os  IN (SELECT  g.cod_valor
                          FROM GED_CODIGOS g
                          WHERE
                          g.COD_MODULO='GA' AND
                          g.NOM_TABLA ='CI_ORSERV' AND
                          g.NOM_COLUMNA='COD_OS')
         AND  c.ind_orserv like LV_IND_ORSERV
         ORDER BY c.cod_os ASC;

/*                          c.COD_OS IN (SELECT p.cod_acci_comer
                                     FROM PV_RENOVACIONES_TD p
                                     WHERE p.TIP_PRODUCTO = EO_TIPO_PRODUCTO
                                     AND p.TIP_ABONADO    = EO_TIPO_ABONADO)*/





EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_CARGAACCOMER_PR'||EO_TIPO_ABONADO||','||EO_TIPO_PRODUCTO ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_CARGAACCOMER_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CARGAACCOMER_PR;
-------------------------------------------------------------------------------

PROCEDURE PV_CONSULTARENOVA_PR(                 SO_Lista_Abonado         IN OUT NOCOPY   refCursor,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "SO_Lista_Abonado"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="SO_Lista_Abonado" Tipo="estructura">REGISTRO DE RENOVACIONES<param>>
          </Entrada>
          <Salida>
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
 LV_Formato_Sel  varchar2(50);
BEGIN

        sn_cod_retorno  := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;

        LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

        LV_sSql:=' OPEN SO_Lista_Abonado FOR SELECT TIP_PRODUCTO,TIP_ABONADO,COD_ACCI_COMER,FEC_INI_VIG,    FEC_TER_VIG,NOM_USUARIO,';
        LV_sSql:=LV_sSql || ' FEC_ULT_MOD,IND_CARGO FROM PV_RENOVACIONES_TD';

        OPEN SO_Lista_Abonado FOR
        SELECT
        TIP_PRODUCTO,
        TIP_ABONADO,
        COD_ACCI_COMER,
        TO_CHAR(FEC_INI_VIG,LV_Formato_Sel),
        TO_CHAR(FEC_TER_VIG,LV_Formato_Sel),
        NOM_USUARIO,
        TO_CHAR(FEC_ULT_MOD,LV_Formato_Sel),
        IND_CARGO,
        IND_PRIO
        FROM PV_RENOVACIONES_TD
        WHERE SYSDATE BETWEEN FEC_INI_VIG AND FEC_TER_VIG;


EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_CONSULTARENOVA_PR('||'SO_Lista_Abonado'  ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_CONSULTARENOVA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CONSULTARENOVA_PR;
-------------------------------------------------------------------------------

PROCEDURE PV_CARGAACCOMERABO_PR(                EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                                                EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                                                SO_Lista_Abonado         OUT NOCOPY      refCursor
                                                )
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CARGAACCOMERABO_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_TIPO_ABONADO" Tipo="NUMERICO">TIPO ABONADO<param>>
             <param nom="EO_TIPO_PRODUCTO" Tipo="NUMERICO">TIPO PRODUCTO<param>>

          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO DE RENOVACIONES POR PRODUCTO Y TIPO DE ABONADO<param>>
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
 SN_cod_retorno       ge_errores_td.cod_msgerror%TYPE;
 SV_mens_retorno      ge_errores_td.det_msgerror%TYPE;
 SN_num_evento        ge_errores_pg.evento;

BEGIN

         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

        --AQUI DEBERÍA IR ALGUNOS CAMBIOS DEPENDE DE LA DEFINCION DE VENTAS

        LV_sSql:=' OPEN SO_Lista_Abonado FOR SELECT  A.TIP_PRODUCTO,A.TIP_ABONADO,A.COD_ACCI_COMER,';
        LV_sSql:=LV_sSql || ' A.FEC_INI_VIG,A.FEC_TER_VIG,A.NOM_USUARIO,A.FEC_ULT_MOD,A.IND_CARGO,B.DESCRIPCION,a.IND_PRIO';
        LV_sSql:=LV_sSql || ' FROM PV_RENOVACIONES_TD A ,CI_TIPORSERV B WHERE';
        LV_sSql:=LV_sSql || ' A.TIP_PRODUCTO = '||EO_TIPO_PRODUCTO||'   AND';
        LV_sSql:=LV_sSql || ' A.TIP_ABONADO  =  '||EO_TIPO_ABONADO||'  AND';
        LV_sSql:=LV_sSql || ' SYSDATE BETWEEN A.FEC_INI_VIG AND NVL(A.fEC_TER_VIG,SYSDATE) AND A.COD_ACCI_COMER=B.COD_OS';
        LV_sSql:=LV_sSql || 'order by a.IND_PRIO DESC';


        OPEN SO_Lista_Abonado FOR
        SELECT
            A.TIP_PRODUCTO,
            A.TIP_ABONADO,
            A.COD_ACCI_COMER,
            A.FEC_INI_VIG,
            A.FEC_TER_VIG,
            A.NOM_USUARIO,
            A.FEC_ULT_MOD,
            A.IND_CARGO,
            B.DESCRIPCION,
            a.IND_PRIO
            FROM PV_RENOVACIONES_TD A ,CI_TIPORSERV B
            WHERE
            A.TIP_PRODUCTO = EO_TIPO_PRODUCTO AND
            A.TIP_ABONADO  = EO_TIPO_ABONADO  AND
            SYSDATE BETWEEN A.FEC_INI_VIG AND NVL(A.fEC_TER_VIG,SYSDATE) AND
            A.COD_ACCI_COMER=B.COD_OS
            order by a.IND_PRIO DESC;

 EXCEPTION
                WHEN no_data_found THEN
                 sv_mens_retorno := 'No hay configuración para el tipo de abonado y prestación asociada';

                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_CONSULTARENOVA_PR('|| EO_TIPO_ABONADO ||','||EO_TIPO_PRODUCTO  ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_CONSULTARENOVA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_CARGAACCOMERABO_PR;


------------------------------------------------------------------------------------------------------

PROCEDURE PV_ELIMINA_CONFIG_PR(         EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                                                EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                                                EO_ACCI_COMMER           IN              CI_TIPORSERV.COD_OS%TYPE,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)



IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ELIMINA_CONFIG_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_TIPO_ABONADO" Tipo="NUMERICO">TIPO ABONADO<param>>
             <param nom="EO_TIPO_PRODUCTO" Tipo="CARACTER">TIPO PRODUCTO<param>>
             <param nom="EO_ACCI_COMMER" Tipo="CARACTER">CODIGO OOSS<param>>
          </Entrada>
          <Salida>
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
 LV_formato_sel2 ged_parametros.val_parametro%type;
 LV_formato_sel7 ged_parametros.val_parametro%type;
 LV_MES          varchar2(10);
 LV_HRS          varchar2(10);
 LV_formato      varchar2(50);
 LV_fec_ter_vig  varchar2(50);
BEGIN

            sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento  := 0;

            lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_gsFormato2  ||','||CV_cod_modulo_GE||')';
            LV_formato_sel2 := PV_OBTENERPARAMETRO_FN(CV_gsFormato2,CV_cod_modulo_GE,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

            lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_gsFormato7  ||','||CV_cod_modulo_GE||')';
            LV_formato_sel7 := PV_OBTENERPARAMETRO_FN(CV_gsFormato7,CV_cod_modulo_GE,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            LV_formato := LV_formato_sel2 || ' ' || LV_formato_sel7;
            LV_MES := TO_CHAR(SYSDATE,LV_formato_sel2);
            LV_HRS := TO_CHAR(SYSDATE,LV_formato_sel7);
            LV_fec_ter_vig :=LV_MES || ' ' || LV_HRS;

            LV_sSql:=' update  PV_RENOVACIONES_TD';
            LV_sSql:=LV_sSql || 'set fEC_TER_VIG=sysdate';
            LV_sSql:=LV_sSql || ' WHERE TIP_PRODUCTO   =' || EO_TIPO_PRODUCTO ||' AND';
            LV_sSql:=LV_sSql || ' TIP_ABONADO    =' || EO_TIPO_ABONADO || ' AND';
            LV_sSql:=LV_sSql || ' COD_ACCI_COMER = ' ||EO_ACCI_COMMER  || ' AND';
            LV_sSql:=LV_sSql || ' SYSDATE BETWEEN FEC_INI_VIG AND NVL(fEC_TER_VIG,SYSDATE)';

            UPDATE  PV_RENOVACIONES_TD
            SET fec_ter_vig= TO_DATE(LV_fec_ter_vig,LV_formato)
            WHERE
            tip_producto   = EO_TIPO_PRODUCTO AND
            tip_abonado    = EO_TIPO_ABONADO  AND
            cod_acci_comer = EO_ACCI_COMMER   AND
            SYSDATE BETWEEN fec_ini_vig AND NVL(fec_ter_vig,SYSDATE);

 EXCEPTION
                WHEN no_data_found THEN
                 sv_mens_retorno := 'Error en la actualización';

                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_ELIMINA_CONFIG_PR('|| EO_TIPO_ABONADO ||','||EO_TIPO_PRODUCTO  ||','||EO_ACCI_COMMER||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_ELIMINA_CONFIG_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_ELIMINA_CONFIG_PR;



-------------------------------------------------------------------------------------------------------

PROCEDURE PV_REGISTRA_CONFIG_PR(                EO_TIPO_ABONADO          IN              TA_PLANTARIF.COD_TIPLAN%TYPE,
                                                EO_TIPO_PRODUCTO         IN              GED_CODIGOS.COD_VALOR%TYPE,
                                                EO_ACCI_COMMER           IN              CI_TIPORSERV.COD_OS%TYPE,
                                                EO_IND_CARGO             IN              PV_RENOVACIONES_TD.IND_CARGO%TYPE,
                                                EO_NOM_USUARIO           IN              PV_RENOVACIONES_TD.NOM_USUARIO%TYPE,
                                                EO_FEC_INI               IN              VARCHAR2,
                                                EO_FEC_TER               IN              VARCHAR2,
                                                EO_IND_PRIO              IN              PV_RENOVACIONES_TD.IND_PRIO%TYPE,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS

/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_REGISTRA_CONFIG_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_TIPO_ABONADO" Tipo="NUMERICO">TIPO ABONADO<param>>
             <param nom="EO_TIPO_PRODUCTO" Tipo="CARACTER">TIPO PRODUCTO<param>>
             <param nom="EO_ACCI_COMMER" Tipo="CARACTER">CODIGO OOSS<param>>
             <param nom="EO_IND_CARGO" Tipo="NUMERICO">INDICADOR DE COBRO<param>>
             <param nom="EO_NOM_USUARIO" Tipo="CARACTER">NOMBRE USUARIO<param>>
             <param nom="EO_FEC_INI" Tipo="DATE">FECHA INICIO VIGENCIA<param>>
             <param nom="EO_FEC_TER" Tipo="DATE">FECHA TERMINI VIGENCIA <param>>
          </Entrada>
          <Salida>
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
 LV_Formato_Sel  varchar2(50);
 LV_formato_sel2 ged_parametros.val_parametro%type;
 LV_formato_sel7 ged_parametros.val_parametro%type;
 LV_MES          varchar2(50);
 LV_HRS          varchar2(50);
 LV_formato      varchar2(50);
 LV_FEC_TER_VIG  varchar2(50);
 LV_FEC_INI_VIG  varchar2(50);
BEGIN

       /* LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato11) ;*/

        sn_cod_retorno := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;


        lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_gsFormato2  ||','||CV_cod_modulo_GE||')';
        LV_formato_sel2 := PV_OBTENERPARAMETRO_FN(CV_gsFormato2,CV_cod_modulo_GE,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

        lv_sSql := 'PV_OBTENERPARAMETRO_FN(' || CV_gsFormato7  ||','||CV_cod_modulo_GE||')';
        LV_formato_sel7 := PV_OBTENERPARAMETRO_FN(CV_gsFormato7,CV_cod_modulo_GE,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        LV_formato := LV_formato_sel2 || ' ' || LV_formato_sel7;

        LV_HRS := TO_CHAR(SYSDATE,LV_formato_sel7);
        LV_FEC_INI_VIG :=EO_FEC_INI || ' ' || LV_HRS;

        LV_HRS := '23:59:59';
        LV_FEC_TER_VIG :=EO_FEC_TER || ' ' || LV_HRS;


        LV_sSql:=' INSERT INTO PV_RENOVACIONES_TD(TIP_PRODUCTO,TIP_ABONADO,COD_ACCI_COMER,FEC_INI_VIG,FEC_TER_VIG,NOM_USUARIO,';
        LV_sSql:=LV_sSql || 'FEC_ULT_MOD,IND_CARGO)VALUES(';
        LV_sSql:=LV_sSql || EO_TIPO_PRODUCTO||','||EO_TIPO_ABONADO||','||EO_ACCI_COMMER||','||EO_FEC_INI||','||EO_FEC_TER||','||EO_NOM_USUARIO||',sysdate,'||EO_IND_CARGO||')';

        INSERT INTO PV_RENOVACIONES_TD(
        TIP_PRODUCTO,
        TIP_ABONADO,
        COD_ACCI_COMER,
        FEC_INI_VIG,
        FEC_TER_VIG,
        NOM_USUARIO,
        FEC_ULT_MOD,
        IND_CARGO,
        IND_PRIO
        )
        VALUES
        (
         EO_TIPO_PRODUCTO,
         EO_TIPO_ABONADO,
         EO_ACCI_COMMER,
         TO_DATE(LV_FEC_INI_VIG,LV_formato),
         TO_DATE(LV_FEC_TER_VIG,LV_formato),
         EO_NOM_USUARIO,
         sysdate,
         EO_IND_CARGO,
         EO_IND_PRIO 
        );

EXCEPTION
                WHEN no_data_found THEN
                 sv_mens_retorno := 'Error en la actualización';

                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_REGISTRA_CONFIG_PR('|| EO_TIPO_PRODUCTO||','||EO_TIPO_ABONADO||','||EO_ACCI_COMMER||','||EO_FEC_INI||','||EO_FEC_TER||','||EO_NOM_USUARIO||',sysdate,'||EO_IND_CARGO ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_REGISTRA_CONFIG_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REGISTRA_CONFIG_PR;

-------------------------------------------------------------------------------------------------------

 PROCEDURE PV_VERIFICA_RENOVACION_PR(           EO_NUM_OS                IN PV_REGISTRA_RENOVACION_OS_TO.NUM_OS%TYPE,
                                                EO_COD_OS                IN PV_REGISTRA_RENOVACION_OS_TO.COD_OS%TYPE,
                                                SN_IND_CARGO             OUT NOCOPY      PV_RENOVACIONES_TD.IND_CARGO%TYPE,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
/*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_VERIFICA_RENOVACION_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2009"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EO_NUM_OS" Tipo="NUMERICO">Número OOSS</param>>
             <param nom="EO_COD_OS" Tipo="NUMERICO">Codigo OOSS</param>>
          </Entrada>
          <Salida>
            <param nom="SN_IND_CARGO" Tipo="NUMERICO">Numero de Evento</param>>
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
BEGIN
        sn_cod_retorno := 0;
        sv_mens_retorno := NULL;
        sn_num_evento  := 0;



        LV_sSql:='SELECT  IND_CARGO  INTO' || sn_cod_retorno;
        LV_sSql:=LV_sSql || ' from PV_REGISTRA_RENOVACION_OS_TO';
        LV_sSql:=LV_sSql || ' Where NUM_OS_RENOVA = '|| EO_NUM_OS;
        LV_sSql:=LV_sSql || ' AND Cod_os = ' ||EO_COD_OS ;


        SELECT  IND_CARGO
        INTO SN_IND_CARGO
        from PV_REGISTRA_RENOVACION_OS_TO
        Where NUM_OS_RENOVA =  EO_NUM_OS
        AND Cod_os = EO_COD_OS ;



EXCEPTION
                WHEN no_data_found THEN
                 sn_cod_retorno  := 1;
                 sv_mens_retorno := 'No existe registro de renovación';

                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_CONFIG_RENOVACION_PG.PV_VERIFICA_RENOVACION_PR('|| EO_NUM_OS   ||','||EO_COD_OS   ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CONFIG_RENOVACION_PG.PV_VERIFICA_RENOVACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

end  PV_VERIFICA_RENOVACION_PR;
---------------------------------------------------------------------

  PROCEDURE PV_RENOVAWEB_PR (
              eo_iorserv        IN              pv_iorserv_qt,
              sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
              sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
              sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
   IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "PV_RENOVAWEB_PR"
            Lenguaje="PL/SQL"
            Fecha="01-07-2009"
            Versión="La del package"
            Diseñador=""
            Programador="ocb"
            Ambiente Desarrollo="BD">
            <Retorno>N/A</Retorno>>
               <Descripción>Metodo  :  Actualiza Renovación</Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="SO_IORSERV_QT    Tipo="Estructura de Type ">Estructura de Type    </param>>
               </Entrada>
               <Salida>
                  <param nom="SN_cod_retorno"                   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"                  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"                       Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

     if (eo_iorserv.NUM_OS_ORIGEN > 0 and eo_iorserv.NUM_OS_ORIGEN is not null) then

             IF (eo_iorserv.NUM_ABONADO   > 0 ) THEN

                    LV_sSql:='UPDATE PV_REGISTRA_RENOVACION_OS_TO';
                    LV_sSql:=LV_sSql || ' SET  NUM_OS     = '||eo_iorserv.NUM_OS ||','|| 'COD_ESTADO ='||'''OK''';
                    LV_sSql:=LV_sSql || ' WHERE  NUM_OS_RENOVA = ' ||eo_iorserv.NUM_OS_ORIGEN|| 'AND' ;
                    LV_sSql:=LV_sSql || ' NUM_ABONADO   = ' || eo_iorserv.NUM_ABONADO || 'AND';
                    LV_sSql:=LV_sSql || ' COD_OS        = ' || eo_iorserv.COD_OS  ;


                    UPDATE PV_REGISTRA_RENOVACION_OS_TO
                    SET
                    NUM_OS     = eo_iorserv.NUM_OS,
                    COD_ESTADO ='OK'
                    WHERE
                    NUM_OS_RENOVA = eo_iorserv.NUM_OS_ORIGEN AND
                    NUM_ABONADO   = eo_iorserv.NUM_ABONADO   AND
                    COD_OS        = eo_iorserv.COD_OS;

             ELSE


                    LV_sSql:=' UPDATE PV_REGISTRA_RENOVACION_OS_TO';
                    LV_sSql:=LV_sSql || 'SET NUM_OS     = ' ||eo_iorserv.NUM_OS||','|| 'COD_ESTADO ='||'''OK''';
                    LV_sSql:=LV_sSql || ' WHERE  NUM_OS_RENOVA = '||eo_iorserv.NUM_OS_ORIGEN ||'AND '||'COD_OS        ='|| eo_iorserv.COD_OS;

                    UPDATE PV_REGISTRA_RENOVACION_OS_TO
                    SET
                    NUM_OS     =  eo_iorserv.NUM_OS,
                    COD_ESTADO ='OK'
                    WHERE
                    NUM_OS_RENOVA = eo_iorserv.NUM_OS_ORIGEN  AND
                    COD_OS        = eo_iorserv.COD_OS;
             END IF;
     end if;



   EXCEPTION
      WHEN OTHERS    THEN
         sn_cod_retorno := 156;

         IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno)
         THEN
            sv_mens_retorno := cv_error_no_clasif;
         END IF;

         lv_des_error :=' PV_RENOVAWEB_PR ('   || eo_iorserv.num_os  || '); ' || SQLERRM;
         sn_num_evento :=  ge_errores_pg.grabarpl
                           (sn_num_evento,
                            cv_cod_modulo,
                            sv_mens_retorno,
                            cv_version,
                            USER,
                            'PV_CONFIG_RENOVACION_PG.PV_RENOVAWEB_PR',
                            lv_ssql,
                            sn_cod_retorno,
                            lv_des_error
                           );
 END PV_RENOVAWEB_PR;



procedure pv_carga_prestacion_pr   (            SO_Lista         OUT NOCOPY      refCursor,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento) IS

        LV_des_error ge_errores_pg.DesEvent;
        LV_sSql      ge_errores_pg.vQuery;

       BEGIN
            SN_num_evento:= 0;
            SN_cod_retorno:=0;
            SV_mens_retorno:='';

            LV_sSql  :='OPEN    SO_Lista FOR SELECT COD_PRESTACION,DES_PRESTACION,GRP_PRESTACION FROM GE_PRESTACIONES_TD';


            --SELECT COD_PRESTACION,DES_PRESTACION,GRP_PRESTACION
            --where
            --FROM GE_PRESTACIONES_TD;

            OPEN    SO_Lista FOR
            Select  COD_PRESTACION,DES_PRESTACION,GRP_PRESTACION
            FROM GE_PRESTACIONES_TD
            WHERE COD_PRESTACION NOT IN (SELECT COD_PRESTACION FROM GE_PRESTACIONES_TD
                                         WHERE UPPER(DES_PRESTACION) LIKE '%PREPAGO%' )
            ORDER BY 1 ASC;





    EXCEPTION

         WHEN OTHERS THEN
             SN_cod_retorno:=156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasIF;
             END IF;
             LV_des_error := 'OTHERS:PV_CONFIG_RENOVACION_PG.pv_carga_prestacion_pr; - '|| SQLERRM;
             SV_mens_retorno:=LV_des_error;

             SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_cod_modulo,SV_mens_retorno, '1.0', USER,
             'PV_CONFIG_RENOVACION_PG.pv_carga_prestacion_pr', LV_sSql, SN_cod_retorno, LV_des_error );

    END pv_carga_prestacion_pr;
END PV_CONFIG_RENOVACION_PG;
/
SHOW ERROR