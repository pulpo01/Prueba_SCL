CREATE OR REPLACE PACKAGE BODY PV_AUTORIZA_RENOVA_PG AS

PROCEDURE PV_REGISTRA_AUTORIZA_PR(EO_NUM_AUTORIZACION     IN GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                  EO_NOM_USUARIO_AUTORIZA IN GA_AUTORIZA_RENOVA_TO.NOM_USUARIO_AUTORIZA%type,
                                  EO_COD_VENDEDOR         IN GA_AUTORIZA_RENOVA_TO.COD_VENDEDOR%type,
                                  EO_COD_OFICINA          IN GA_AUTORIZA_RENOVA_TO.COD_OFICINA%type,
                                  EO_COD_CLIENTE          IN GA_AUTORIZA_RENOVA_TO.COD_CLIENTE%type,
                                  EO_NUM_ABONADO          IN GA_AUTORIZA_RENOVA_TO.NUM_ABONADO%type,
                                  SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento       OUT NOCOPY  ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_REGISTRA_AUTORIZA_PR"
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
             <param nom="EO_NUM_AUTORIZACION" Tipo="NUMERICO">NUMERO AUTORIZACION<param>>
             <param nom="EO_NOM_USUARIO_AUTORIZA" Tipo="CARACTER">USUARIO AUTORIZA <param>>
             <param nom="EO_COD_VENDEDOR" Tipo="NUMERICO">CODIGO VENDEDOR<param>>
             <param nom="EO_COD_OFICINA  Tipo="NUMERICO">CODIGO OFICINA<param>>
             <param nom="EO_COD_CLIENTE " Tipo="NUMERICO">CODIGO CLIENTE<param>>
             <param nom="EO_NUM_ABONADO Tipo="NUMERICO">NUMERO ABONADO<param>>
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


PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

    LV_sSql:=' INSERT INTO GA_AUTORIZA_RENOVA_TO ( NUM_AUTORIZA_RENOVA,';
    LV_sSql:=LV_sSql || ' COD_ESTADO, NOM_USUARIO_AUTORIZA,COD_VENDEDOR,COD_OFICINA,COD_CLIENTE,NUM_ABONADO,FEC_AUTORIZA,FEC_SOLICITUD)';
    LV_sSql:=LV_sSql || ' VALUES ( ' ||EO_NUM_AUTORIZACION||',''PD'',';
    LV_sSql:=LV_sSql || EO_NOM_USUARIO_AUTORIZA||','||EO_COD_VENDEDOR||',';
    LV_sSql:=LV_sSql || EO_COD_OFICINA||','|| EO_COD_CLIENTE||',';
    LV_sSql:=LV_sSql || EO_NUM_ABONADO||','|| NULL||','|| SYSDATE||')';


    INSERT INTO GA_AUTORIZA_RENOVA_TO ( NUM_AUTORIZA_RENOVA,
    COD_ESTADO,
    NOM_USUARIO_AUTORIZA,
    COD_VENDEDOR,
    COD_OFICINA,
    COD_CLIENTE,
    NUM_ABONADO,
    FEC_AUTORIZA,
    FEC_SOLICITUD)
    VALUES (
    EO_NUM_AUTORIZACION,
    'PD',
    EO_NOM_USUARIO_AUTORIZA,
    EO_COD_VENDEDOR,
    EO_COD_OFICINA,
    EO_COD_CLIENTE,
    EO_NUM_ABONADO,
    NULL,
    SYSDATE
    );

    COMMIT;

EXCEPTION
                WHEN OTHERS THEN
                         SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                      SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_AUTORIZA_RENOVA_PG.PV_REGISTRA_AUTORIZA_PR('|| EO_NUM_AUTORIZACION || ',';
                         LV_des_error   := LV_des_error ||   EO_NOM_USUARIO_AUTORIZA||',' ;
                         LV_des_error   := LV_des_error ||   EO_COD_VENDEDOR||','||  EO_COD_OFICINA||',';
                         LV_des_error   := LV_des_error ||   EO_COD_CLIENTE||','|| EO_NUM_ABONADO||','|| 'NULL,'||  'SYSDATE'  ||')' ||SQLERRM;

                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AUTORIZA_RENOVA_PG.PV_REGISTRA_AUTORIZA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REGISTRA_AUTORIZA_PR;
-------------------------------------------------------------------------------
     PROCEDURE PV_CONSESTADO_AUTORIZA_PR(       EO_AUTORIZA              IN GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                                SV_estado                OUT NOCOPY      GA_AUTORIZA_RENOVA_TO.cod_estado%type,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CONSESTADO_AUTORIZA_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripciódsn>>
       <Parámetros>
          <Entrada>
             <param nom="EO_AUTORIZA" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
            <param nom="SV_estado " Tipo="CARACTER">ESTADO AUTORIZACION</param>>
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

                LV_sSql:=' SELECT  COD_ESTADO';
                LV_sSql:=LV_sSql || ' INTO ' ||SV_estado ;
                LV_sSql:=LV_sSql || ' FROM GA_AUTORIZA_RENOVA_TO';
                LV_sSql:=LV_sSql || ' WHERE NUM_AUTORIZA_RENOVA= '|| EO_AUTORIZA;


                SELECT  COD_ESTADO
                INTO SV_estado
                FROM GA_AUTORIZA_RENOVA_TO
                WHERE
                NUM_AUTORIZA_RENOVA= EO_AUTORIZA;

EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_AUTORIZA_RENOVA_PG.PV_CONSESTADO_AUTORIZA_PR('||EO_AUTORIZA  ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AUTORIZA_RENOVA_PG.PV_CONSESTADO_AUTORIZA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CONSESTADO_AUTORIZA_PR;
-------------------------------------------------------------------------------
PROCEDURE PV_LISTA_AUTORIZA_PR(                 SO_Lista_Abonado         IN OUT NOCOPY         refCursor,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_LISTA_AUTORIZA_PR"
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
 LV_sSql         ge_errores_pg.vQuery;
 LV_Formato_Sel  varchar2(50);

BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

          LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=' OPEN SO_Lista_Abonado FOR ';
         LV_sSql:=LV_sSql || ' select  aut.num_autoriza_renova';
         LV_sSql:=LV_sSql || '                 ,aut.cod_estado';
         LV_sSql:=LV_sSql || ' ,aut.nom_usuario_autoriza';
         LV_sSql:=LV_sSql || ' ,aut.cod_vendedor';
         LV_sSql:=LV_sSql || ' ,ven.nom_vendedor';
         LV_sSql:=LV_sSql || ' ,aut.cod_oficina';
         LV_sSql:=LV_sSql || ' ,ofc.des_oficina';
         LV_sSql:=LV_sSql || ' ,aut.cod_cliente';
         LV_sSql:=LV_sSql || ' ,clie.nom_cliente|| '' '' || clie.nom_apeclien1 || '' '' || clie.nom_apeclien2';
         LV_sSql:=LV_sSql || ' ,aut.num_abonado';
         LV_sSql:=LV_sSql || ' ,to_char(aut.fec_solicitud,' || '''' || LV_Formato_Sel||''')';
         LV_sSql:=LV_sSql || ' ,to_char(sysdate,' || '''' || LV_Formato_Sel||''')';
         LV_sSql:=LV_sSql || ' from  ge_clientes clie,ve_vendedores ven, ga_autoriza_renova_to aut, ge_oficinas ofc';
         LV_sSql:=LV_sSql || ' where clie.cod_cliente = aut.cod_cliente';
         LV_sSql:=LV_sSql || ' and   ven.cod_vendedor = aut.cod_vendedor';
         LV_sSql:=LV_sSql || ' and   ofc.cod_oficina  = aut.cod_oficina';
         LV_sSql:=LV_sSql || ' and   aut.cod_estado   = ''' || CV_estado_pd||'''';


         OPEN SO_Lista_Abonado FOR
         select  aut.num_autoriza_renova
                ,aut.cod_estado
                ,aut.cod_oficina
                ,ofc.des_oficina
                ,aut.cod_vendedor
                ,ven.nom_vendedor
                ,aut.cod_cliente
                ,clie.nom_cliente|| ' ' || clie.nom_apeclien1 || ' ' || clie.nom_apeclien2
                ,aut.num_abonado
                ,to_char(aut.fec_solicitud,LV_Formato_Sel)
                ,to_char(sysdate,LV_Formato_Sel)
                ,aut.nom_usuario_autoriza
        from  ge_clientes clie,ve_vendedores ven, ga_autoriza_renova_to aut, ge_oficinas ofc
        where clie.cod_cliente = aut.cod_cliente
        and   ven.cod_vendedor = aut.cod_vendedor
        and   ofc.cod_oficina  = aut.cod_oficina
        and   aut.cod_estado   = CV_estado_pd;

EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_AUTORIZA_RENOVA_PG.PV_LISTA_AUTORIZA_PR(' || 'SO_Lista_Abonado'  || ')' || SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AUTORIZA_RENOVA_PG.PV_LISTA_AUTORIZA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_LISTA_AUTORIZA_PR;
-------------------------------------------------------------------------------
PROCEDURE PV_ACTUALIZA_AUTORIZA_PR(  EO_NUM_AUTORIZACION      IN              GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                     EO_COD_ESTADO            IN              GA_AUTORIZA_RENOVA_TO.COD_ESTADO%type,
                                     EO_NOM_USUARIO_AUTORIZA  IN              GA_AUTORIZA_RENOVA_TO.NOM_USUARIO_AUTORIZA%type,
                                     SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUALIZA_AUTORIZA_PR"
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
             <param nom="EO_NUM_AUTORIZACION " Tipo="NUMERICO">NUMERO AUTRIZACION<param>>
             <param nom="EO_COD_ESTADO" Tipo="CARACTER">ESTADO DE LA AUTORIZACION<param>>
             <param nom="EO_NOM_USUARIO_AUTORIZA" Tipo="CARACTER">USUARIO QUIEN AUTORIZA<param>>



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

BEGIN

         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;

         IF EO_COD_ESTADO ='AU' then

             LV_sSql:=' UPDATE GA_AUTORIZA_RENOVA_TO SET';
             LV_sSql:=LV_sSql || '  COD_ESTADO           = '|| EO_COD_ESTADO;
             LV_sSql:=LV_sSql || ', FEC_AUTORIZA         = SYSDATE';
             LV_sSql:=LV_sSql || ', NOM_USUARIO_AUTORIZA = '|| EO_NOM_USUARIO_AUTORIZA;
             LV_sSql:=LV_sSql || '  WHERE NUM_AUTORIZA_RENOVA=' || EO_NUM_AUTORIZACION;

             UPDATE GA_AUTORIZA_RENOVA_TO SET
             COD_ESTADO           = EO_COD_ESTADO,
             FEC_AUTORIZA         = SYSDATE,
             NOM_USUARIO_AUTORIZA = EO_NOM_USUARIO_AUTORIZA
             WHERE NUM_AUTORIZA_RENOVA=EO_NUM_AUTORIZACION;

         else

             LV_sSql:=' UPDATE GA_AUTORIZA_RENOVA_TO SET';
             LV_sSql:=LV_sSql || ' COD_ESTADO           = '||EO_COD_ESTADO;
             LV_sSql:=LV_sSql || ' , NOM_USUARIO_AUTORIZA = ' ||EO_NOM_USUARIO_AUTORIZA;
             LV_sSql:=LV_sSql || ' WHERE NUM_AUTORIZA_RENOVA='||EO_NUM_AUTORIZACION;

             UPDATE GA_AUTORIZA_RENOVA_TO SET
             COD_ESTADO           = EO_COD_ESTADO,
             NOM_USUARIO_AUTORIZA = EO_NOM_USUARIO_AUTORIZA
             WHERE NUM_AUTORIZA_RENOVA=EO_NUM_AUTORIZACION;

         end if;





EXCEPTION
                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_AUTORIZA_RENOVA_PG.PV_ACTUALIZA_AUTORIZA_PR('||EO_NUM_AUTORIZACION||','||  EO_COD_ESTADO|| ' ,' ||EO_NOM_USUARIO_AUTORIZA   || ')' || SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AUTORIZA_RENOVA_PG.PV_ACTUALIZA_AUTORIZA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUALIZA_AUTORIZA_PR;
-------------------------------------------------------------------------------
  PROCEDURE PV_CONSESTADOABO_AUTORIZA_PR(       EO_abonado               IN              GA_AUTORIZA_RENOVA_TO.NUM_ABONADO%type,
                                                SN_autoriza              OUT NOCOPY      GA_AUTORIZA_RENOVA_TO.NUM_AUTORIZA_RENOVA%type,
                                                SV_estado                OUT NOCOPY      GA_AUTORIZA_RENOVA_TO.cod_estado%type,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_CONSESTADOABO_AUTORIZA_PR"
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
             <param nom="EO_ABONADO" Tipo="CARACTER">NUMERO ABONADO<param>>
          </Entrada>
          <Salida>
              <param nom="SN_autoriza" Tipo="NUMERICO">NUMERO AUTORIZACION</param>>
              <param nom="SV_estado " Tipo="CARACTER">ESTADO AUTORIZACION</param>>
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


                LV_sSql:=LV_sSql || 'SELECT NUM_AUTORIZA_RENOVA,cod_estado  ';
                LV_sSql:=LV_sSql || 'INTO SN_autoriza ,SV_estado    ';
                LV_sSql:=LV_sSql || 'FROM GA_AUTORIZA_RENOVA_TO ';
                LV_sSql:=LV_sSql || 'WHERE   ';
                LV_sSql:=LV_sSql || 'NUM_ABONADO= '||EO_abonado;
                LV_sSql:=LV_sSql || 'AND  OD_ESTADO NOT (''CA'',''RE'')';
                LV_sSql:=LV_sSql || 'AND FEC_AUTORIZA IS NULL';

                SELECT NUM_AUTORIZA_RENOVA,cod_estado
                INTO SN_autoriza ,SV_estado
                FROM GA_AUTORIZA_RENOVA_TO
                WHERE
                NUM_ABONADO= EO_abonado
                AND  COD_ESTADO NOT IN  ('CA','RE')
                AND  FEC_AUTORIZA IS NULL;


EXCEPTION

                WHEN NO_DATA_FOUND THEN
                 SN_autoriza :=0;
                 SV_estado   :='' ;

                WHEN OTHERS THEN
                 SN_cod_retorno := 156;
                         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                SV_mens_retorno := CV_error_no_clasif;
                         END IF;

                         LV_des_error   := 'PV_AUTORIZA_RENOVA_PG.PV_CONSESTADOABO_AUTORIZA_PR('||EO_ABONADO   ||') '||SQLERRM;
                         SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AUTORIZA_RENOVA_PG.PV_CONSESTADOABO_AUTORIZA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_CONSESTADOABO_AUTORIZA_PR;

END PV_AUTORIZA_RENOVA_PG;
/
SHOW ERRORS