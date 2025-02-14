CREATE OR REPLACE PACKAGE BODY CO_COBRANZA_EXTERNA_PG As

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_EMPRESAS_PR(SO_Lista_empresa        OUT NOCOPY refCursor,
                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_EMPRESAS_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=' OPEN SO_Lista_empresa FOR ';
         LV_sSql:=LV_sSql || ' select  cod_entidad, des_entidad';
         LV_sSql:=LV_sSql || ' ,direccion ,telefono';
         LV_sSql:=LV_sSql || ' ,email';
         LV_sSql:=LV_sSql || ' ,to_char(fec_ini_vigencia,LV_Formato_Sel)';
         LV_sSql:=LV_sSql || ' ,to_char(fec_fin_vigencia,LV_Formato_Sel)';
         LV_sSql:=LV_sSql || ' from  co_entcob';


         OPEN SO_Lista_empresa FOR
         select  a.cod_entidad, a.des_entidad, b.des_valor, 
                 direccion,telefono,
                 email,
                 to_char(fec_ini_vigencia,LV_Formato_Sel),
                 to_char(fec_fin_vigencia,LV_Formato_Sel),
                 a.tip_entidad
         from    co_entcob a, co_codigos b
         WHERE a.tip_entidad = b.cod_valor
         AND b.nom_tabla = 'CO_ENTCOB'
         AND b.nom_columna = 'TIP_ENTIDAD'
         ORDER BY a.COD_ENTIDAD;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2910; --Error al obtener Empresas de Cobranza
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_EMPRESAS_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_EMPRESAS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_EMPRESAS_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_ACTUALIZA_EMPRESA_PR (  EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                     EO_Des_entidad    IN              CO_ENTCOB.DES_ENTIDAD%TYPE,
                                     EO_Direccion      IN              CO_ENTCOB.DIRECCION%type,
                                     EO_Telefono       IN              CO_ENTCOB.TELEFONO%type,
                                     EO_Email          IN              CO_ENTCOB.EMAIL%type,
                                     EO_Tip_comision   IN              CO_ENTCOB.TIP_COMISION%type,
                                     EO_Tip_entidad    IN              CO_ENTCOB.TIP_ENTIDAD%TYPE,
                                     SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_ACTUALIZA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

       LV_sSql:=' UPDATE CO_ENTCOB SET';
       LV_sSql:=LV_sSql || '  DES_ENTIDAD= '|| EO_Des_entidad;
       LV_sSql:=LV_sSql || '  DIRECCION= '|| EO_Direccion;
       LV_sSql:=LV_sSql || ', TELEFONO = '||EO_Telefono;
       LV_sSql:=LV_sSql || ', EMAIL    = '|| EO_Email;
       LV_sSql:=LV_sSql || ', TIP_COMISION = '|| EO_Tip_comision;
       LV_sSql:=LV_sSql || '  WHERE COD_ENTIDAD=' || EO_Cod_entidad;

       UPDATE CO_ENTCOB SET
              DES_ENTIDAD   = EO_Des_entidad,
              DIRECCION    = EO_Direccion,
              TELEFONO     = EO_Telefono,
              EMAIL        = EO_Email,
              TIP_ENTIDAD  = EO_Tip_entidad     
       WHERE  COD_ENTIDAD  = EO_Cod_entidad;


EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2911;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_ACTUALIZA_EMPRESA_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_EMPRESAS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_ACTUALIZA_EMPRESA_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_INSERTA_EMPRESA_PR (  EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   EO_Des_entidad    IN              CO_ENTCOB.DES_ENTIDAD%type,
                                   EO_Direccion      IN              CO_ENTCOB.DIRECCION%type,
                                   EO_Telefono       IN              CO_ENTCOB.TELEFONO%type,
                                   EO_Email          IN              CO_ENTCOB.EMAIL%type,
                                   EO_Tip_comision   IN              CO_ENTCOB.TIP_COMISION%type,
                                   EO_Tip_entidad    IN              CO_ENTCOB.TIP_ENTIDAD%TYPE,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_INSERTA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

    LV_sSql:=' INSERT INTO CO_ENTCOB';
    LV_sSql:=LV_sSql || ' (COD_ENTIDAD, DES_ENTIDAD, TIP_ENTIDAD, TIP_COBRANZA, FEC_ULTMOD, NOM_USUARIO,';
    LV_sSql:=LV_sSql || ' TIP_COMISION, DIAS_COMISIONABLES, DIRECCION, TELEFONO, EMAIL, FEC_INI_VIGENCIA, FEC_FIN_VIGENCIA )';
    LV_sSql:=LV_sSql || ' VALUES ( ' ||EO_Cod_entidad||','||EO_Des_entidad||',' || EO_Tip_entidad ||',N,';
    LV_sSql:=LV_sSql || SYSDATE||','||USER||','||NVL(EO_Tip_comision,0)||',0,'||EO_Direccion||',';
    LV_sSql:=LV_sSql || EO_Telefono||','|| EO_Email||',';
    LV_sSql:=LV_sSql || SYSDATE||',31-12-3000'||')';


    INSERT INTO CO_ENTCOB 
           (COD_ENTIDAD, DES_ENTIDAD, TIP_ENTIDAD, TIP_COBRANZA, FEC_ULTMOD, NOM_USUARIO,
            TIP_COMISION, DIA_COMISIONABLES, DIRECCION, TELEFONO, EMAIL, FEC_INI_VIGENCIA, FEC_FIN_VIGENCIA )
    VALUES (EO_Cod_entidad, EO_Des_entidad,EO_Tip_entidad, 'N', trunc(SYSDATE) , USER,
            NVL(EO_Tip_comision, 0), 0, EO_Direccion, EO_Telefono, EO_Email, SYSDATE, TO_DATE('31-12-3000 00:00:00','DD-MM-YYYY HH24:MI:SS'));


EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2912;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_EMPRESA_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_EMPRESA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_INSERTA_EMPRESA_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_ELIMINA_EMPRESA_PR (  EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_ELIMINA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

       LV_sSql:=' UPDATE CO_ENTCOB SET';
       LV_sSql:=LV_sSql || ' FEC_FIN_VIGENCIA = SYSDATE';
       LV_sSql:=LV_sSql || '  WHERE COD_ENTIDAD=' || EO_Cod_entidad;

       UPDATE CO_ENTCOB SET
              FEC_FIN_VIGENCIA = SYSDATE
       WHERE  COD_ENTIDAD  = EO_Cod_entidad;


EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2913;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_EMPRESA_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_EMPRESA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_ELIMINA_EMPRESA_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_INMUNES_PR(SO_Lista_inmunes        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_INMUNES_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
LN_nomtabla VARCHAR2(11) := 'GE_CLIENTES';
LN_categoria VARCHAR2(16) := 'COD_CATEGORIA';
LN_tablamorosos VARCHAR2(10) := 'CO_MOROSOS';

LV_Formato_Sel2 varchar2(50);

BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);
         LV_Formato_Sel2 := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2);
         
         LV_sSql:=' OPEN SO_Lista_inmunes FOR ';
         LV_sSql:=LV_sSql || ' select  a.cod_cliente ,';
         LV_sSql:=LV_sSql || ' b.nom_cliente b.nom_apeclien1 b.nom_apeclien2,';
         LV_sSql:=LV_sSql || ' cob.des_valor,a.cod_categoria,';
         LV_sSql:=LV_sSql || ' a.cod_segmento, a.cod_calificacion,';
         LV_sSql:=LV_sSql || ' a.dias_mora   , a.monto_mora,';
         LV_sSql:=LV_sSql || ' to_char(a.fec_inmunidad,LV_Formato_Sel),';
         LV_sSql:=LV_sSql || ' a.nom_usuarora';
         LV_sSql:=LV_sSql || ' from  co_cobex_inmune_to a, ge_clientes b';
         LV_sSql:=LV_sSql || ' where   a.cod_cliente = b.cod_cliente';


         OPEN SO_Lista_inmunes FOR
         select  a.cod_cliente , 
                 b.nom_cliente||' '||b.nom_apeclien1||' '||b.nom_apeclien2,
                 cob.des_valor,
                 c.des_categoria, 
                 d.des_segmento, 
                 e.des_calificacion,
                 trunc(sysdate)-trunc(nvl(m.fec_deudvenc,sysdate)), nvl(m.deu_vencida,0),
                 to_char(a.fec_inmunidad,LV_Formato_Sel),
                 a.nom_usuarora,
                 b.cod_categoria, 
                 b.cod_segmento, b.cod_calificacion  ,
                 to_char(a.fec_desde,LV_Formato_Sel2), to_char(a.fec_hasta,LV_Formato_Sel2)               
         from    co_cobex_inmune_to a, ge_clientes b, co_morosos m, ge_categorias c, ge_segmentacion_clientes_td d, ge_calificacion_td e,
                 co_codigos cli, co_codigos cob
         where   a.cod_cliente = b.cod_cliente
         and a.cod_cliente = m.cod_cliente (+)
         and b.cod_categoria = c.cod_categoria
         and b.cod_segmento = d.cod_segmento (+)
         and b.cod_tipo = d.cod_tipo (+)
         and b.cod_calificacion = e.cod_calificacion(+)
         and cli.nom_tabla (+) = LN_nomtabla
         and cli.nom_columna (+) = LN_categoria
         and cli.cod_valor (+) = b.cod_categoria
         and cli.des_valor = cob.cod_valor (+)
         and cob.nom_tabla (+) = LN_tablamorosos
         and cob.nom_columna (+) = LN_categoria
         ORDER BY a.cod_cliente;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2914;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_INMUNES_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_INMUNES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_INMUNES_PR;

PROCEDURE CO_CARGA_CLIENTE_INMUNE_PR(EO_cliente IN co_cobex_inmune_to.cod_cliente%TYPE,
                               EO_fecdesde IN VARCHAR2,
                               SO_Lista_inmunes        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CLIENTE_INMUNE_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
LV_Formato_Sel2 varchar2(50);

BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel2 := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2);
         
         LV_sSql:=' OPEN SO_Lista_inmunes FOR ';
         LV_sSql:=LV_sSql || ' select  a.cod_cliente ,';
         LV_sSql:=LV_sSql || ' from    co_cobex_inmune_to';
         LV_sSql:=LV_sSql || ' where   a.cod_cliente = ' || EO_cliente;
         LV_sSql:=LV_sSql || ' and a.fec_desde = TO_DATE(' || EO_fecdesde || ',' || LV_Formato_Sel2 || ')';

         OPEN SO_Lista_inmunes FOR
         select  cod_cliente              
         from    co_cobex_inmune_to 
         where   cod_cliente = EO_cliente
         and fec_desde = TO_DATE(EO_fecdesde, LV_Formato_Sel2);

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2918;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CLIENTE_INMUNE_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CLIENTE_INMUNE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CLIENTE_INMUNE_PR;
-------------------------------------------------------------------------------
PROCEDURE CO_INSERTA_INMUNES_PR (  EO_Cod_cliente      IN              CO_COBEX_INMUNE_TO.COD_CLIENTE%type,
                                   EO_Fec_inmunidad    IN              VARCHAR2,
                                   EO_Fec_desde        IN              VARCHAR2,
                                   EO_Fec_hasta        IN              VARCHAR2,
                                   SN_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento       OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_INSERTA_INMUNES_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 LV_Formato_Sel2  varchar2(50);
 LN_cuenta NUMBER(1);
 EXCEPTION_FECHA EXCEPTION;
BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento  := 0;
    LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);
    LV_Formato_Sel2 := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2);
    
    SELECT count(1)
    INTO LN_cuenta
    FROM co_cobex_inmune_to
    WHERE cod_cliente = EO_Cod_cliente
    AND fec_desde = TO_DATE(EO_Fec_Desde, LV_Formato_Sel2)
    AND rownum = 1;
    
    IF LN_cuenta = 0 THEN
        LV_sSql:=' INSERT INTO CO_COBEX_INMUNE_TO';
        LV_sSql:=LV_sSql || ' (COD_CLIENTE, FEC_INMUNIDAD, NOM_USUARORA  )';
        LV_sSql:=LV_sSql || ' VALUES ( ' ||EO_Cod_cliente||','||EO_Fec_inmunidad||',';
        LV_sSql:=LV_sSql || user||')';


        INSERT INTO co_cobex_inmune_to 
               (cod_cliente, fec_inmunidad, nom_usuarora, fec_desde, fec_hasta )
        VALUES (EO_Cod_cliente, to_date(EO_Fec_inmunidad,LV_Formato_Sel), user, TO_DATE(EO_Fec_Desde, LV_Formato_Sel2), TO_DATE(EO_Fec_hasta,LV_Formato_Sel2));
    ELSE
        LV_sSql:=' UPDATE co_cobex_inmune_to';
        LV_sSql:=LV_sSql || ' SET fec_hasta = TO_DATE(' || EO_Fec_Hasta || ', LV_Formato_Sel2)';
        LV_sSql:=LV_sSql || ' WHERE cod_cliente = ' ||EO_Cod_cliente;
        LV_sSql:=LV_sSql || ' AND fec_desde = TO_DATE(' || EO_Fec_Desde || ', LV_Formato_Sel2) ';
        
        UPDATE co_cobex_inmune_to
        SET fec_hasta = TO_DATE(EO_Fec_Hasta, LV_Formato_Sel2)
        WHERE cod_cliente = EO_Cod_cliente
        AND fec_desde = TO_DATE(EO_Fec_Desde, LV_Formato_Sel2); 
    END IF;  


EXCEPTION
   
   WHEN OTHERS THEN
       SN_cod_retorno := 2915;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_INMUNES_PR' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_INMUNES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
       RAISE_APPLICATION_ERROR(-20104,'Error inesperado, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM);       

END CO_INSERTA_INMUNES_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_ELIMINA_INMUNES_PR (  EO_Cod_cliente    IN              CO_COBEX_INMUNE_TO.COD_CLIENTE%type,
                                   EO_Fec_desde      IN              VARCHAR2,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_ELIMINA_INMUNES_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 LV_Formato_Sel2  varchar2(50);
BEGIN

       sn_cod_retorno  := 0;
       sv_mens_retorno := NULL;
       sn_num_evento  := 0;
       
       LV_Formato_Sel2 := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2);
       
       LV_sSql:=' DELETE CO_COBEX_INMUNE_TO ';
       LV_sSql:=LV_sSql || '  WHERE COD_CLIENTE=' || EO_Cod_cliente;

       DELETE CO_COBEX_INMUNE_TO 
       WHERE  COD_CLIENTE  = EO_Cod_cliente
       AND FEC_DESDE = TO_DATE(EO_Fec_desde, LV_Formato_Sel2);


EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2916;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_INMUNES_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_INMUNES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_ELIMINA_INMUNES_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_OBTIENE_DATCLIE_PR(EO_Cod_cliente    IN  CO_COBEX_INMUNE_TO.COD_CLIENTE%type,
                                SO_Lista_cliente  OUT NOCOPY refCursor,
                                SV_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_OBTIENE_DATCLIE_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
LN_nomtabla VARCHAR2(11) := 'GE_CLIENTES';
LN_categoria VARCHAR2(16) := 'COD_CATEGORIA';
LN_tablamorosos VARCHAR2(10) := 'CO_MOROSOS';
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=' OPEN SO_Lista_cliente FOR ';
         LV_sSql:=LV_sSql || ' select  a.cod_cliente ,';
         LV_sSql:=LV_sSql || ' a.nom_cliente a.nom_apeclien1 a.nom_apeclien2,';
         LV_sSql:=LV_sSql || ' c.cod_categoria,';
         LV_sSql:=LV_sSql || ' a.cod_segmento, a.cod_calificacion,';
         LV_sSql:=LV_sSql || ' trunc(sysdate)-trunc(b.fec_deudvenc),';
         LV_sSql:=LV_sSql || ' b.deu_vencida,,';
         LV_sSql:=LV_sSql || ' to_char(sysdate,dd-mm-yyyy hh24:mi:ss)';
         LV_sSql:=LV_sSql || ' ge_clientes a, co_morosos b, ge_clientes c';
         LV_sSql:=LV_sSql || ' where a.cod_cliente ='||EO_Cod_cliente;
         LV_sSql:=LV_sSql || ' and   a.cod_cliente = b.cod_cliente';
         LV_sSql:=LV_sSql || ' and   a.cod_categoria = c.cod_categoria';


         OPEN SO_Lista_cliente FOR
         select a.cod_cliente , 
                a.nom_cliente||' '||a.nom_apeclien1||' '||a.nom_apeclien2 nombre,
                nvl(cob.cod_valor,' '), 
                nvl(a.cod_segmento,'0'), 
                nvl(a.cod_calificacion,'0'),
                trunc(sysdate)-trunc(nvl(b.fec_deudvenc,sysdate)) dias_mora,    
                nvl(b.deu_vencida,0),
                to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'),
                nvl(cob.des_valor,' ') des_categoria,
                nvl(d.des_segmento,' ') des_segmento,
                nvl(e.des_calificacion,' ') des_calificacion
         from  ge_clientes a, co_morosos b, ge_segmentacion_clientes_td d, ge_calificacion_td e,
         co_codigos cli, co_codigos cob
         where a.cod_cliente=EO_Cod_cliente
         and   a.cod_cliente = b.cod_cliente (+)
         and a.cod_segmento = d.cod_segmento (+)
         and a.cod_tipo = d.cod_tipo (+)
         and a.cod_calificacion = e.cod_calificacion (+)
         and cli.nom_tabla (+) = LN_nomtabla
         and cli.nom_columna (+) = LN_categoria
         and cli.cod_valor (+) = a.cod_categoria
         and cli.des_valor = cob.cod_valor (+)
         and cob.nom_tabla (+) = LN_tablamorosos
         and cob.nom_columna (+) = LN_categoria;         

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2917;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_OBTIENE_DATCLIE_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_OBTIENE_DATCLIE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_OBTIENE_DATCLIE_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_OBTIENE_REASIGNAR_PR(EO_Cod_entidad   IN CO_ENTCOB.COD_ENTIDAD%type,
                                  EO_Cod_rango     IN CO_PARAM_COBEX_TO.COD_RANGO%TYPE,
                                  EO_Cod_ciclo  IN CO_PARAM_COBEX_TO.COD_CICLO%type,
                                  EO_Cod_categoria IN CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                  EO_cod_segmento  IN CO_PARAM_COBEX_TO.COD_SEGMENTO%type,
                                  EO_cod_calificacion IN CO_PARAM_COBEX_TO.COD_CALIFICACION%type,
                                  EO_mto_Desde IN CO_PARAM_COBEX_TO.MTO_DESDE%TYPE,
                                  EO_mto_Hasta IN CO_PARAM_COBEX_TO.MTO_HASTA%TYPE,                                  
                                  SO_Lista_cliente OUT NOCOPY refCursor,
                                  SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_OBTIENE_REASIGNAR_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
LN_nomtabla VARCHAR2(11) := 'GE_CLIENTES';
LN_nomtablacat VARCHAR2(13) := 'GE_CATEGORIAS';
LN_categoria VARCHAR2(16) := 'COD_CATEGORIA';
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=' select to_char(b.cod_cuenta), to_char(b.cod_cliente), b.nom_cliente||'' ''||b.nom_apeclien1||'' ''||b.nom_apeclien2 nombre,';
         LV_sSql:=LV_sSql || ' a.des_entidad, NVL(cob.des_valor,'' '') des_categoriacob, NVL(d.des_categoria, '' '') des_categoria, NVL(e.des_segmento,'' '') des_segmento, NVL(f.des_calificacion,'' '') des_calificacion,';
         LV_sSql:=LV_sSql || ' to_char(trunc(sysdate)-trunc(c.fec_deudvenc)) dias_mora, nvl(to_char(c.deu_vencida),0),';
         LV_sSql:=LV_sSql || ' c.nom_usuario';
         LV_sSql:=LV_sSql || ' from   co_entcob a, ge_clientes b, co_morosos c, ge_categorias d, ge_segmentacion_clientes_td e, ge_calificacion_td f, co_codigos cob';
         IF EO_Cod_rango IS NOT NULL THEN
            LV_sSql:=LV_sSql || ', co_rangos_cobex_td g';
         END IF;
         /*IF EO_Cod_ciclo IS NOT NULL THEN
            LV_sSql:=LV_sSql || ', fa_ciclfact h';
         END IF;*/
         LV_sSql:=LV_sSql || ' where  b.cod_cliente = c.cod_cliente';
         LV_sSql:=LV_sSql || ' and a.cod_entidad = c.cod_agente';
         LV_sSql:=LV_sSql || ' and b.cod_categoria = d.cod_categoria';
         LV_sSql:=LV_sSql || ' and b.cod_segmento = e.cod_segmento (+)';
         LV_sSql:=LV_sSql || ' and b.cod_tipo = e.cod_tipo (+)';
         LV_sSql:=LV_sSql || ' and b.cod_calificacion = f.cod_calificacion (+)';
         LV_sSql:=LV_sSql || ' and c.cod_categoria = cob.cod_valor (+)';
         LV_sSql:=LV_sSql || ' and cob.nom_tabla (+) = ''CO_MOROSOS''';
         LV_sSql:=LV_sSql || ' and cob.nom_columna (+) = ''COD_CATEGORIA''';              
         LV_sSql:=LV_sSql || ' and a.cod_entidad = '''||EO_Cod_entidad || '''';
         IF EO_Cod_rango IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' AND g.cod_rango = ''' || EO_Cod_rango || '''';
            LV_sSql:=LV_sSql || ' AND trunc(sysdate)-trunc(c.fec_deudvenc) BETWEEN g.dia_inicial AND g.dia_final';
         END IF;
         IF EO_Cod_ciclo IS NOT NULL THEN
            /*LV_sSql:=LV_sSql || ' and b.cod_ciclo = h.cod_ciclo';
            LV_sSql:=LV_sSql || ' and h.cod_ciclfact = ' || EO_Cod_ciclo;*/
            LV_sSql:=LV_sSql || ' and b.cod_ciclo = ' || EO_Cod_ciclo;
         END IF;
         IF EO_Cod_categoria IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' and c.cod_categoria = '''||EO_Cod_categoria || '''';
         END IF;
         IF EO_cod_segmento IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' and b.cod_segmento = '''||EO_cod_segmento || '''';
         END IF;
         IF EO_cod_calificacion IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' and b.cod_calificacion = '''||EO_cod_calificacion || '''';
         END IF;
         IF EO_mto_Desde IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' and c.deu_vencida >= '||EO_mto_Desde;
         END IF;
         IF EO_mto_Hasta IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' and c.deu_vencida <= '||EO_mto_Hasta;
         END IF;
         LV_sSql:=LV_sSql || ' ORDER BY b.cod_cuenta, b.cod_cliente';
         
         OPEN SO_Lista_cliente FOR LV_sSql;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2918;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;
       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_OBTIENE_REASIGNAR_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_OBTIENE_REASIGNAR_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_OBTIENE_REASIGNAR_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_REASIGNA_MOROSOS_PR ( EO_Cod_entidad    IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   EO_Cod_cliente    IN              CO_MOROSOS.COD_CLIENTE%type,
                                   EO_Num_secuencia  IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%TYPE,
                                   EO_Cod_rango      IN              CO_PARAM_COBEX_TO.COD_RANGO%TYPE,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_REASIGNA_MOROSOS_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 LN_cuenta ge_clientes.cod_cuenta%type;
 LV_tipident ge_clientes.cod_tipident%type;
 LV_numident ge_clientes.num_ident%type;
 LV_codgestion co_gestion.cod_gestion%type := '80';
 LV_tipmor VARCHAR2(10) := 'MOROS';
 LV_observacion VARCHAR2(100) := 'REASIGNA EMPRESA DE COBRANZA: ';

BEGIN

       sn_cod_retorno  := 0;
       sv_mens_retorno := NULL;
       sn_num_evento  := 0;

       LV_sSql:='UPDATE CO_MOROSOS SET';
       LV_sSql:=LV_sSql || ' COD_AGENTE = '||EO_Cod_entidad;
       LV_sSql:=LV_sSql || '  WHERE COD_CLIENTE=' || EO_Cod_cliente;

       UPDATE CO_MOROSOS SET
              COD_AGENTE = EO_Cod_entidad
       WHERE  COD_CLIENTE  = EO_Cod_cliente;
       
       LV_sSql:='SELECT cod_cuenta, cod_tipident, num_ident';
       LV_sSql:=LV_sSql || ' FROM ge_clientes';
       LV_sSql:=LV_sSql || '  WHERE COD_CLIENTE=' || EO_Cod_cliente;
       
       SELECT cod_cuenta, cod_tipident, num_ident
       INTO LN_cuenta, LV_tipident, LV_numident
       FROM ge_clientes
       WHERE cod_cliente = EO_Cod_cliente;
       
       LV_observacion := LV_observacion || EO_Cod_entidad;
       
       LV_sSql:='INSERT INTO CO_GESTION_TO ';
       LV_sSql:=LV_sSql || '  (COD_CLIENTE, COD_CUENTA, COD_TIPIDENT, NUM_IDENT,';
       LV_sSql:=LV_sSql || '  COD_GESTION, FEC_GESTION, OBS_GESTION, NOM_USUARIO,';
       LV_sSql:=LV_sSql || '  FEC_ULTMOD, COD_CICLO, COD_TIPMOR)';
       LV_sSql:=LV_sSql || '  VALUES (' || EO_Cod_cliente || ',' || LN_cuenta || ',' || LV_tipident || ',' || LV_numident|| ',';
       LV_sSql:=LV_sSql || '  ' || LV_codgestion|| ', SYSDATE, '|| LV_observacion||', USER,';
       LV_sSql:=LV_sSql || '  SYSDATE, NULL, ' ||LV_tipmor||')';
       
       INSERT INTO CO_GESTION_TO 
       (COD_CLIENTE, COD_CUENTA, COD_TIPIDENT, NUM_IDENT, 
       COD_GESTION, FEC_GESTION, OBS_GESTION, NOM_USUARIO,
       FEC_ULTMOD, COD_CICLO, COD_TIPMOR)
       VALUES (EO_Cod_cliente, LN_cuenta, LV_tipident, LV_numident,
       LV_codgestion, SYSDATE, LV_observacion, USER,
       SYSDATE, NULL, LV_tipmor);
       
       LV_sSql:='UPDATE CO_GESTION_COBEX_TO';
       LV_sSql:=LV_sSql || ' SET FEC_TERMINO = SYSDATE';
       LV_sSql:=LV_sSql || ' WHERE COD_CLIENTE = ' || EO_Cod_cliente;
       LV_sSql:=LV_sSql || ' AND FEC_TERMINO IS NULL';
       
       UPDATE CO_GESTION_COBEX_TO
       SET FEC_TERMINO = SYSDATE
       WHERE COD_CLIENTE = EO_Cod_cliente
       AND FEC_TERMINO IS NULL; 
       
       --Inserta en CO_GESTION_COBEX_TO 
       LV_sSql:='INSERT INTO CO_GESTION_COBEX_TO';
       LV_sSql:=LV_sSql || ' (NUM_SECUENCIA, COD_ENTIDAD, COD_CLIENTE,';
       LV_sSql:=LV_sSql || ' FEC_INGRESO, TIP_GESTION, COD_RANGO)';
       LV_sSql:=LV_sSql || ' VALUES ('||EO_Num_secuencia||','||EO_Cod_entidad ||',' || EO_Cod_cliente || ',';
       LV_sSql:=LV_sSql || ' SYSDATE, M, ' || EO_Cod_rango ||')'; 
       
       INSERT INTO CO_GESTION_COBEX_TO
       (NUM_SECUENCIA, COD_ENTIDAD, COD_CLIENTE,
       FEC_INGRESO, TIP_GESTION, COD_RANGO)
       VALUES (EO_Num_secuencia,EO_Cod_entidad , EO_Cod_cliente,
       SYSDATE, 'M',  EO_Cod_rango);       

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2919;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_REASIGNA_MOROSOS_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_REASIGNA_MOROSOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_REASIGNA_MOROSOS_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CONSULTA_INMUNES_PR(EO_Cod_categoria    IN         CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                 EO_Cod_segmento     IN         GE_CLIENTES.COD_SEGMENTO%type,
                                 EO_Cod_calificacion IN         GE_CLIENTES.COD_CALIFICACION%type,
                                 EO_Fec_desde        IN         VARCHAR2,
                                 EO_Fec_hasta        IN         VARCHAR2,
                                 SO_Lista_inmunes    OUT NOCOPY refCursor,
                                 SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CONSULTA_INMUNES_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=LV_sSql || ' select a.cod_cliente ,';
         LV_sSql:=LV_sSql || ' b.nom_cliente||'' ''||b.nom_apeclien1||'' ''||b.nom_apeclien2,';
         LV_sSql:=LV_sSql || ' nvl(cob.des_valor,'' '') des_categoriacob, nvl(c.des_categoria,'' '') des_categoria,';
         LV_sSql:=LV_sSql || ' nvl(d.des_segmento,'' '') des_segmento, nvl(e.des_calificacion,'' '') des_calificacion,';
         LV_sSql:=LV_sSql || ' to_char(trunc(sysdate)-trunc(nvl(m.fec_deudvenc, trunc(sysdate)))) dias_mora, nvl(m.deu_vencida,0) mto_mora,';
         LV_sSql:=LV_sSql || ' to_char(a.fec_inmunidad,'''||LV_Formato_Sel||'''),';
         LV_sSql:=LV_sSql || ' to_char(a.fec_desde,'''||LV_Formato_Sel||'''),';
         LV_sSql:=LV_sSql || ' to_char(a.fec_hasta,'''||LV_Formato_Sel||'''),';
         LV_sSql:=LV_sSql || ' a.nom_usuarora';
         LV_sSql:=LV_sSql || ' from  co_cobex_inmune_to a, ge_clientes b, co_morosos m, ge_categorias c, ge_segmentacion_clientes_td d, ge_calificacion_td e, co_codigos cob, co_codigos cli';
         LV_sSql:=LV_sSql || ' where a.cod_cliente = b.cod_cliente';
         LV_sSql:=LV_sSql || ' and a.cod_cliente = m.cod_cliente (+)';
         LV_sSql:=LV_sSql || ' and b.cod_categoria = c.cod_categoria';
         LV_sSql:=LV_sSql || ' and b.cod_segmento = d.cod_segmento (+)';
         LV_sSql:=LV_sSql || ' and b.cod_tipo = d.cod_tipo (+)';
         LV_sSql:=LV_sSql || ' and b.cod_calificacion = e.cod_calificacion (+)';
         LV_sSql:=LV_sSql || ' and cli.nom_tabla (+) = ''GE_CLIENTES''';
         LV_sSql:=LV_sSql || ' and cli.nom_columna (+) = ''COD_CATEGORIA''';
         LV_sSql:=LV_sSql || ' and cli.cod_valor (+) = b.cod_categoria';
         LV_sSql:=LV_sSql || ' and cli.des_valor = cob.cod_valor (+) ';
         LV_sSql:=LV_sSql || ' and cob.nom_tabla (+) = ''CO_MOROSOS''';
         LV_sSql:=LV_sSql || ' and cob.nom_columna (+) = ''COD_CATEGORIA''';             
         if EO_Cod_categoria is not null then
            LV_sSql:=LV_sSql || ' and     cob.cod_valor = '''||EO_Cod_categoria||'''';
         end if;
         if EO_Cod_segmento is not null then
            LV_sSql:=LV_sSql || ' and   b.cod_segmento = '''||EO_Cod_segmento||'''';
         end if;
         if EO_Cod_calificacion is not null then
            LV_sSql:=LV_sSql || ' and   b.cod_calificacion = '''||EO_Cod_calificacion||'''';
         end if;
         /*if EO_Fec_desde is not null then
            LV_sSql:=LV_sSql || ' and   a.fec_inmunidad >= TO_DATE('''||EO_Fec_desde||' 00:00:00'','''||LV_Formato_Sel||''')';
         end if;
         if EO_Fec_hasta is not null then
            LV_sSql:=LV_sSql || ' and   a.fec_inmunidad <= TO_DATE('''||EO_Fec_hasta||' 23:59:59'','''||LV_Formato_Sel||''')';
         end if;*/
         If EO_Fec_desde is not null and EO_Fec_hasta is not null then
            LV_sSql:=LV_sSql || ' and  ( ';
                LV_sSql:=LV_sSql || ' (a.fec_desde <= TO_DATE('''||EO_Fec_desde||' 00:00:00'','''||LV_Formato_Sel||''')';
                LV_sSql:=LV_sSql || ' and  a.fec_hasta >= TO_DATE('''||EO_Fec_Desde||' 00:00:00'','''||LV_Formato_Sel||'''))';
                
                LV_sSql:=LV_sSql || ' OR';
                
                LV_sSql:=LV_sSql || ' (a.fec_desde <= TO_DATE('''||EO_Fec_hasta||' 00:00:00'','''||LV_Formato_Sel||''')';
                LV_sSql:=LV_sSql || ' and  a.fec_hasta >= TO_DATE('''||EO_Fec_hasta||' 00:00:00'','''||LV_Formato_Sel||'''))';
                
                LV_sSql:=LV_sSql || ' OR';                
                
                LV_sSql:=LV_sSql || ' (a.fec_desde >= TO_DATE('''||EO_Fec_desde||' 00:00:00'','''||LV_Formato_Sel||''')';
                LV_sSql:=LV_sSql || ' and  a.fec_hasta <= TO_DATE('''||EO_Fec_hasta||' 00:00:00'','''||LV_Formato_Sel||'''))';
                                
            LV_sSql:=LV_sSql || ' )';
         end if;

         OPEN SO_Lista_inmunes FOR LV_sSql;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2920;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CONSULTA_INMUNES_PR(' || 'SO_Lista_inmunes'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CONSULTA_INMUNES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CONSULTA_INMUNES_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_EMPRE_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_EMPRE" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_entidad, des_entidad ';
         LV_sSql:=LV_sSql || ' from co_entcob';

         OPEN SO_Lista_cbo FOR
         select cod_entidad, des_entidad 
         from co_entcob;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2910;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_EMPRE_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_EMPRE_VIG_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_EMPRE" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_entidad, des_entidad ';
         LV_sSql:=LV_sSql || ' from co_entcob';

         OPEN SO_Lista_cbo FOR
         SELECT cod_entidad, des_entidad 
         FROM co_entcob
         WHERE SYSDATE BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2921;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE_VIG_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_EMPRE_VIG_PR;
-------------------------------------------------------------------------------

PROCEDURE CO_CARGA_CBO_EMPRE_RANGO_PR(EV_cod_rango CO_ENTIDAD_RANGO_TD.cod_rango%TYPE,
                                SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_EMPRE" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' SELECT DISTINCT a.cod_entidad, a.des_entidad ';
         LV_sSql:=LV_sSql || ' FROM co_entcob a, co_entidad_rango_td b';
         LV_sSql:=LV_sSql || ' WHERE SYSDATE BETWEEN a.fec_ini_vigencia AND a.fec_fin_vigencia';
         LV_sSql:=LV_sSql || ' AND a.cod_entidad = b.cod_entidad';
         IF EV_cod_rango IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' AND b.cod_rango = ''' || EV_cod_rango || '''';
         END IF;

         OPEN SO_Lista_cbo FOR LV_sSql;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2922;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE_RANGO_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE_RANGO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_EMPRE_RANGO_PR;
-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_CICLO_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_CICLO_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_ciclfact, cod_ciclo ';
         LV_sSql:=LV_sSql || ' from fa_ciclfact';
         LV_sSql:=LV_sSql || ' where sysdate between fec_desdellam and fec_hastallam';

         OPEN SO_Lista_cbo FOR
         select cod_ciclfact, cod_ciclo 
         from fa_ciclfact
         where sysdate between fec_desdellam and fec_hastallam;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2923;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CICLO_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CICLO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_CICLO_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_CATEG_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_CATEG_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
LN_tablamorosos VARCHAR2(10) := 'CO_MOROSOS';
LN_categoria VARCHAR2(13) := 'COD_CATEGORIA';

BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_valor, des_valor  ';
         LV_sSql:=LV_sSql || ' from co_codigos';
         LV_sSql:=LV_sSql || ' WHERE nom_tabla = ' || LN_tablamorosos;
         LV_sSql:=LV_sSql || ' AND nom_columna = ' || LN_categoria;

         OPEN SO_Lista_cbo FOR
         select cod_valor, des_valor 
         from co_codigos
         WHERE nom_tabla = LN_tablamorosos
         AND nom_columna = LN_categoria;         

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2712;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CATEG_PR(' || 'SO_Lista_cbo'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CATEG_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_CATEG_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_SEGME_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_SEGME_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_segmento, des_segmento ';
         LV_sSql:=LV_sSql || ' from ge_segmentacion_clientes_td';
         LV_sSql:=LV_sSql || ' order by des_segmento';

         OPEN SO_Lista_cbo FOR
         select cod_segmento, des_segmento 
         from ge_segmentacion_clientes_td
         order by des_segmento;      

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2689; --Error al intentar recuperar segmentos de clientes.
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_SEGME_PR(' || 'SO_Lista_cbo'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_SEGME_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_SEGME_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_CALIF_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_CALIF_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
LV_indvigencia ge_calificacion_td.ind_vigencia%TYPE := 'S';
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_calificacion, des_calificacion  ';
         LV_sSql:=LV_sSql || ' from ge_calificacion_td';
         LV_sSql:=LV_sSql || ' where ind_vigencia = LV_indvigencia';
         LV_sSql:=LV_sSql || ' order by des_calificacion';

         OPEN SO_Lista_cbo FOR
         select cod_calificacion, des_calificacion 
         from ge_calificacion_td
         where ind_vigencia = LV_indvigencia
         order by des_calificacion;         

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2924;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CALIF_PR(' || 'SO_Lista_cbo'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CALIF_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_CALIF_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_PRODU_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_PRODU_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_valor, des_valor  ';
         LV_sSql:=LV_sSql || ' from ged_codigos';
         LV_sSql:=LV_sSql || ' where nom_tabla = GE_PRESTACIONES_TD';
         LV_sSql:=LV_sSql || ' and nom_columna = GRP_PRESTACION';

         OPEN SO_Lista_cbo FOR
         select cod_valor, des_valor 
         from ged_codigos
         where nom_tabla = 'GE_PRESTACIONES_TD'
         and nom_columna = 'GRP_PRESTACION';         

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 156;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_PRODU_PR(' || 'SO_Lista_cbo'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_PRODU_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_PRODU_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CONSULTA_MOROSOS_PR(EO_Cod_categoria    IN         CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                 EO_Cod_segmento     IN         GE_CLIENTES.COD_SEGMENTO%type,
                                 EO_Cod_calificacion IN         GE_CLIENTES.COD_CALIFICACION%type,
                                 EO_Fec_desde        IN         VARCHAR2,
                                 EO_Fec_hasta        IN         VARCHAR2,
                                 SO_Lista_morosos    OUT NOCOPY refCursor,
                                 SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CONSULTA_MOROSOS_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=LV_sSql || ' select  a.cod_cliente ,';
         LV_sSql:=LV_sSql || ' b.nom_cliente||'' ''||b.nom_apeclien1||'' ''||b.nom_apeclien2,';
         LV_sSql:=LV_sSql || ' a.cod_ptogest, a.cod_agente,';
         LV_sSql:=LV_sSql || ' cob.des_valor, c.des_categoria,';
         LV_sSql:=LV_sSql || ' d.des_segmento, e.des_calificacion,';
         LV_sSql:=LV_sSql || ' trunc(sysdate)-trunc(a.fec_deudvenc)  , a.deu_vencida,';
         LV_sSql:=LV_sSql || ' to_char(a.fec_ingreso,'''||LV_Formato_Sel||'''),';
         LV_sSql:=LV_sSql || ' a.nom_usuario';
         LV_sSql:=LV_sSql || ' from  co_morosos a, ge_clientes b, ge_categorias c, ge_segmentacion_clientes_td d, ge_calificacion_td e, co_codigos cob';
         LV_sSql:=LV_sSql || ' where a.cod_cliente = b.cod_cliente';
         LV_sSql:=LV_sSql || ' and b.cod_categoria = c.cod_categoria';
         LV_sSql:=LV_sSql || ' and b.cod_segmento = d.cod_segmento (+)';
         LV_sSql:=LV_sSql || ' and b.cod_tipo = d.cod_tipo (+)';
         LV_sSql:=LV_sSql || ' and b.cod_calificacion = e.cod_calificacion (+)';
         LV_sSql:=LV_sSql || ' and a.cod_categoria = cob.cod_valor (+)';
         LV_sSql:=LV_sSql || ' and cob.nom_tabla (+) = ''CO_MOROSOS''';
         LV_sSql:=LV_sSql || ' and cob.nom_columna (+) = ''COD_CATEGORIA''';           
         if EO_Cod_categoria is not null then
            LV_sSql:=LV_sSql || ' and   a.cod_categoria = '''||EO_Cod_categoria||'''';
         end if;
         if EO_Cod_segmento is not null then
            LV_sSql:=LV_sSql || ' and   b.cod_segmento = '''||EO_Cod_segmento||'''';
         end if;
         if EO_Cod_calificacion is not null then
            LV_sSql:=LV_sSql || ' and   b.cod_calificacion = '''||EO_Cod_calificacion||'''';
         end if;
         if EO_Fec_desde is not null then
            LV_sSql:=LV_sSql || ' and   a.fec_ingreso >= TO_DATE('''||EO_Fec_desde||' 00:00:00'','''||LV_Formato_Sel ||''')';
         end if;
         if EO_Fec_hasta is not null then
            LV_sSql:=LV_sSql || ' and   a.fec_ingreso <= TO_DATE('''||EO_Fec_hasta||' 23:59:59'','''||LV_Formato_Sel ||''')';
         end if;


         OPEN SO_Lista_morosos FOR LV_sSql;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2925; --Error al obtener Datos de Clientes Morosos.
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CONSULTA_MOROSOS_PR(' || 'SO_Lista_morosos'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CONSULTA_MOROSOS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CONSULTA_MOROSOS_PR;


-------------------------------------------------------------------------------
PROCEDURE CO_OBTIENE_CARTERA_PREMORA_PR(EO_Num_secuencia CO_PARAM_COBEX_TO.NUM_SECUENCIA%TYPE,
                                        EO_Cod_entidad      IN         CO_PARAM_COBEX_TO.COD_ENTIDAD%TYPE,
                                        EO_Cod_ciclo        IN         CO_PARAM_COBEX_TO.COD_CICLO%TYPE,
                                        EO_Cod_categoria    IN         CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                        EO_Cod_segmento     IN         GE_CLIENTES.COD_SEGMENTO%type,
                                        EO_Cod_calificacion IN         GE_CLIENTES.COD_CALIFICACION%type,
                                        EO_monto_desde      IN         CO_PARAM_COBEX_TO.MTO_DESDE%TYPE,
                                        EO_monto_hasta      IN         CO_PARAM_COBEX_TO.MTO_HASTA%TYPE,
                                        SO_Lista_morosos    OUT NOCOPY refCursor,
                                        SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_OBTIENE_CARTERA_PREMORA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 LV_Formato_Sel2 varchar2(50);
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';
         LV_Formato_Sel2 := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2);
         LV_Formato_Sel := LV_Formato_Sel2 || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);
                 
         LV_sSql:=' select /*+ rule */ c.des_entidad, to_char(b.cod_cuenta), to_char(b.cod_cliente), b.nom_cliente||'' ''||b.nom_apeclien1||'' ''||b.nom_apeclien2,';
         LV_sSql:=LV_sSql || ' cob.des_valor des_categoriacob, d.des_categoria, ';
         LV_sSql:=LV_sSql || ' to_char(nvl(MIN (z.fec_ven),to_date(''31-12-3000'',''dd-mm-yyyy'')), ''' || LV_Formato_Sel2 || '''), to_char(sum(nvl(z.monto,0)),''999999999999.9999''),to_char(trunc(max(nvl(dias_mora,0)))), decode(z.cod_cliente, null,''0'',TO_CHAR (COUNT (1))) , c.cod_entidad';
         LV_sSql:=LV_sSql || ' from co_gestion_cobex_to a,ge_clientes b, co_entcob c, ge_categorias d, co_codigos cli, co_codigos cob,';
         LV_sSql:=LV_sSql || '(select a.cod_cliente, min(z.fec_vencimie) as fec_ven, SUM(z.importe_debe - z.importe_haber) as monto, (trunc(sysdate) - min(z.fec_vencimie)) as dias_mora, z.num_folio,z.pref_plaza, z.cod_tipdocum ';
         LV_sSql:=LV_sSql || ' FROM co_gestion_cobex_to a, co_cartera z WHERE z.cod_cliente = a.cod_cliente';
         LV_sSql:=LV_sSql || ' and a.num_secuencia = ' || EO_Num_secuencia;
         LV_sSql:=LV_sSql || ' and a.fec_termino IS NULL';    
         --LV_sSql:=LV_sSql || ' and z.fec_vencimie < TRUNC(SYSDATE)'; 
         LV_sSql:=LV_sSql || ' AND z.cod_tipdocum NOT IN (SELECT cod_valor FROM co_codigos WHERE nom_tabla = ''CO_CARTERA'' AND nom_columna = ''COD_TIPDOCUM'')';
         LV_sSql:=LV_sSql || ' GROUP by a.cod_cliente, a.cod_entidad, z.cod_tipdocum, z.num_folio, z.pref_plaza) z';          
         LV_sSql:=LV_sSql || ' where a.cod_cliente = b.cod_cliente ';
         LV_sSql:=LV_sSql || ' and z.cod_cliente (+) = b.cod_cliente ';
         LV_sSql:=LV_sSql || ' AND a.num_secuencia = ' || EO_Num_secuencia || ' AND a.fec_termino IS NULL';
         LV_sSql:=LV_sSql || ' and b.cod_categoria = d.cod_categoria';  
         LV_sSql:=LV_sSql || ' AND a.cod_entidad = c.cod_entidad'; 
         LV_sSql:=LV_sSql || ' and cli.nom_tabla (+) = ''GE_CLIENTES''';
         LV_sSql:=LV_sSql || ' and cli.nom_columna (+) = ''COD_CATEGORIA''';
         LV_sSql:=LV_sSql || ' and cli.cod_valor (+) = b.cod_categoria';
         LV_sSql:=LV_sSql || ' and cli.des_valor = cob.cod_valor ';
         LV_sSql:=LV_sSql || ' and cob.nom_tabla (+) = ''CO_MOROSOS''';
         LV_sSql:=LV_sSql || ' and cob.nom_columna (+) = ''COD_CATEGORIA''';
         IF EO_Cod_ciclo IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' AND b.cod_ciclo = ' || EO_Cod_ciclo;
         END IF;      
         IF EO_Cod_categoria IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' AND cob.cod_valor = ''' || EO_Cod_categoria || '''';
         END IF;
         IF EO_Cod_segmento IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' AND b.cod_segmento = ''' || EO_Cod_segmento || '''';
            
         END IF;   
         IF EO_Cod_calificacion IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' AND b.cod_calificacion = ''' || EO_Cod_calificacion || '''';
         END IF;                 
         LV_sSql:=LV_sSql || ' group by z.cod_cliente, c.des_entidad, b.cod_cuenta, b.nom_cliente, b.nom_apeclien1, b.nom_apeclien2, b.cod_cliente, cob.des_valor, d.des_categoria, c.cod_entidad ';
         IF EO_monto_desde IS NOT NULL AND EO_monto_hasta IS NOT NULL THEN
            LV_sSql:=LV_sSql || ' HAVING sum(z.monto) >= ' || EO_monto_desde;
            LV_sSql:=LV_sSql || ' AND sum(z.monto) <= ' || EO_monto_hasta;
         ELSE
             IF EO_monto_desde IS NOT NULL THEN
                LV_sSql:=LV_sSql || ' HAVING sum(z.monto) >= ' || EO_monto_desde;
             END IF;
             IF EO_monto_hasta IS NOT NULL THEN
                LV_sSql:=LV_sSql || ' HAVING sum(z.monto) <= ' || EO_monto_hasta;
             END IF;
         END IF;                  
         LV_sSql:=LV_sSql || ' ORDER BY c.des_entidad, b.cod_cuenta, b.cod_cliente';

         OPEN SO_Lista_morosos FOR LV_sSql;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2926; --Error al obtener Datos de Clientes de Filtro seleccionado
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_OBTIENE_CARTERA_PREMORA_PR(' || 'SO_Lista_morosos'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_OBTIENE_CARTERA_PREMORA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_OBTIENE_CARTERA_PREMORA_PR;

-------------------------------------------------------------------------------

PROCEDURE CO_INSERTA_CONFIGURACION_PR (  Ev_Cod_rango    IN              CO_PARAM_COBEX_TO.COD_RANGO%type,
                                   EO_Tip_gestion    IN               CO_PARAM_COBEX_TO.TIP_GESTION%type,
                                   EO_Cod_entidad      IN              CO_PARAM_COBEX_TO.COD_ENTIDAD%type,
                                   EO_Cod_ciclo      IN              CO_PARAM_COBEX_TO.COD_CICLO%type,
                                   EO_Cod_categoria          IN              CO_PARAM_COBEX_TO.COD_CATEGORIA%type,
                                   EO_cod_segmento   IN              CO_PARAM_COBEX_TO.COD_SEGMENTO%type,
                                   EO_cod_calificacion   IN              CO_PARAM_COBEX_TO.COD_CALIFICACION%type,
                                   EO_mto_Desde IN CO_PARAM_COBEX_TO.MTO_DESDE%TYPE,
                                   EO_mto_Hasta IN CO_PARAM_COBEX_TO.MTO_HASTA%TYPE,
                                   EO_ind_historico IN CO_PARAM_COBEX_TO.IND_HISTORICO%TYPE,
                                   EO_num_vecesmora IN CO_PARAM_COBEX_TO.NUM_VECESMORA%TYPE,
                                   EO_num_meses IN CO_PARAM_COBEX_TO.NUM_MESES%TYPE,
                                   EO_cod_estado IN CO_PARAM_COBEX_TO.COD_ESTADO%TYPE,
                                   SN_num_secuencia OUT NOCOPY refCursor,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_INSERTA_CONFIGURACION_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 ERROR_CONTROLADO EXCEPTION;
 LN_num_secuencia CO_PARAM_COBEX_TO.NUM_SECUENCIA%TYPE; 
 LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
 LN_num_evento     ge_errores_pg.evento;
BEGIN

       ln_cod_retorno  := 0;
       sv_mens_retorno := '';
       
    SELECT CO_PARAM_COBEX_SQ.NEXTVAL
    INTO LN_num_secuencia
    FROM DUAL;

    LV_sSql:=' INSERT INTO CO_PARAM_COBEX_TO';
    LV_sSql:=LV_sSql || ' (NUM_SECUENCIA, COD_RANGO, TIP_GESTION, COD_ENTIDAD, COD_CICLO, COD_CATEGORIA,';
    LV_sSql:=LV_sSql || ' COD_SEGMENTO, COD_CALIFICACION, MTO_DESDE, MTO_HASTA, IND_HISTORICO, NUM_VECESMORA, NUM_MESES,';
    LV_sSql:=LV_sSql || ' FEC_INGRESO, COD_ESTADO, NOM_USUARIO, FEC_ESTADO)';
    LV_sSql:=LV_sSql || ' VALUES ( ' || LN_num_secuencia ||',';
    IF  Ev_Cod_rango IS NOT NULL THEN
        LV_sSql:=LV_sSql || '''' ||Ev_Cod_rango||''',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;
    LV_sSql:=LV_sSql || '''' || EO_Tip_gestion || ''',';
    IF  EO_Cod_entidad IS NOT NULL THEN
        LV_sSql:=LV_sSql || '''' ||EO_Cod_entidad||''',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;    
    IF  EO_Cod_ciclo IS NOT NULL THEN
        LV_sSql:=LV_sSql || EO_Cod_ciclo||',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;    
    IF  EO_Cod_categoria IS NOT NULL THEN
        LV_sSql:=LV_sSql || '''' ||EO_Cod_categoria|| ''',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;    
    IF  EO_cod_segmento IS NOT NULL THEN
        LV_sSql:=LV_sSql || '''' ||EO_cod_segmento||''',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;  
    IF  EO_cod_calificacion IS NOT NULL THEN
        LV_sSql:=LV_sSql || '''' ||EO_cod_calificacion||''',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;     
    IF  EO_mto_Desde IS NOT NULL THEN
        LV_sSql:=LV_sSql || EO_mto_Desde||',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;  
    IF  EO_mto_Desde IS NOT NULL THEN
        LV_sSql:=LV_sSql || EO_mto_Hasta||',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;              
    IF  EO_ind_historico IS NOT NULL THEN
        LV_sSql:=LV_sSql || '''' ||EO_ind_historico||''',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;     
    IF  EO_num_vecesmora IS NOT NULL THEN
        LV_sSql:=LV_sSql || EO_num_vecesmora||',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;  
    IF  EO_num_meses IS NOT NULL THEN
        LV_sSql:=LV_sSql || EO_num_meses||',';
    ELSE
        LV_sSql:=LV_sSql || 'NULL,';
    END IF;               
    LV_sSql:=LV_sSql || 'SYSDATE,''' || EO_cod_estado ||''',USER,SYSDATE)';
    EXECUTE IMMEDIATE  LV_sSql;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE ERROR_CONTROLADO;
    END IF;    
    
    OPEN SN_num_secuencia FOR SELECT LN_num_secuencia FROM DUAL;

EXCEPTION
   WHEN ERROR_CONTROLADO THEN
       LN_cod_retorno := 2927; --Error al ingresar Filtros.
       IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_CONFIGURACION_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_EMPRESA_PR', LV_sSQL, LN_cod_retorno, LV_des_error );    
   WHEN OTHERS THEN
       LN_cod_retorno := 2927; --Error al ingresar Filtros.
       IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_CONFIGURACION_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_EMPRESA_PR', LV_sSQL, LN_cod_retorno, LV_des_error );

END CO_INSERTA_CONFIGURACION_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CBO_RANGO_PR(SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_RANGO_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' select cod_rango, des_rango, dia_inicial, dia_final  ';
         LV_sSql:=LV_sSql || ' FROM CO_RANGOS_COBEX_TD';
         LV_sSql:=LV_sSql || ' ORDER BY cod_rango';

         OPEN SO_Lista_cbo FOR
         select cod_rango, des_rango, dia_inicial, dia_final 
         from CO_RANGOS_COBEX_TD
         ORDER BY cod_rango;       

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2928; --Error al obtener Rangos.
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CATEG_PR(' || 'SO_Lista_cbo'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_CATEG_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_RANGO_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_CARGA_CONFIGURACION_PR(EV_estado1 VARCHAR2,
                               EV_estado2 VARCHAR2,
                               SO_Lista_configuracion        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_INMUNES_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
LN_nomtabla VARCHAR2(11) := 'GE_CLIENTES';
LN_categoria VARCHAR2(16) := 'COD_CATEGORIA';
LV_nomtablaconf VARCHAR2(17) := 'CO_PARAM_COBEX_TO';
LV_tipogestion VARCHAR2(11) := 'TIP_GESTION';
LN_tablamorosos VARCHAR2(10) := 'CO_MOROSOS';

BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=' OPEN SO_Lista_configuracion FOR ';
         LV_sSql:=LV_sSql || ' select  a.cod_cliente ,';
         LV_sSql:=LV_sSql || ' b.nom_cliente b.nom_apeclien1 b.nom_apeclien2,';
         LV_sSql:=LV_sSql || ' a.cod_categoria,';
         LV_sSql:=LV_sSql || ' a.cod_segmento, a.cod_calificacion,';
         LV_sSql:=LV_sSql || ' a.dias_mora   , a.monto_mora,';
         LV_sSql:=LV_sSql || ' to_char(a.fec_inmunidad,LV_Formato_Sel),';
         LV_sSql:=LV_sSql || ' a.nom_usuarora';
         LV_sSql:=LV_sSql || ' from  co_cobex_inmune_to a, ge_clientes b';
         LV_sSql:=LV_sSql || ' where   a.cod_cliente = b.cod_cliente';

         OPEN SO_Lista_configuracion FOR
         select a.num_secuencia,  
                 nvl(f.des_valor, '') des_gestion,
                 nvl(b.des_rango, ''),
                 nvl(g.des_entidad, ''),
                 nvl(a.cod_ciclo,''),
                 nvl(cob.des_valor,''), 
                 d.des_segmento, 
                 e.des_calificacion,
                 a.mto_desde,
                 a.mto_hasta,
                 a.ind_historico,
                 a.num_vecesmora,
                 a.num_meses,                 
                 to_char(a.fec_ingreso,LV_Formato_Sel),
                 a.cod_estado,                 
                 to_char(a.fec_estado,LV_Formato_Sel),
                 a.nom_usuario,                 
                 a.tip_gestion,
                 a.cod_rango,
                 a.cod_entidad,
                 a.cod_ciclo,
                 a.cod_categoria,
                 a.cod_segmento,
                 a.cod_calificacion,
                 b.dia_inicial,
                 b.dia_final
         from    co_param_cobex_to a, co_rangos_cobex_td b, 
         co_entcob g, co_codigos cob, ge_segmentacion_clientes_td d, ge_calificacion_td e, ged_codigos f 
         where a.cod_rango = b.cod_rango (+)
         and a.cod_entidad = g.cod_entidad (+)
         and a.cod_segmento = d.cod_segmento (+)
         and a.cod_calificacion = e.cod_calificacion(+)
         and a.tip_gestion = f.cod_valor (+)
         and f.nom_tabla (+) = LV_nomtablaconf
         and f.nom_columna (+) = LV_tipogestion 
         and a.cod_categoria = cob.cod_valor(+)
         and cob.nom_tabla (+) = LN_tablamorosos
         and cob.nom_columna (+) = LN_categoria        
         and a.cod_estado in (EV_estado1, EV_estado2)--LV_estadoPEN
         ORDER BY a.num_secuencia;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2929; --Error al cargar datos de Filtros
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CONFIGURACION_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_INMUNES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CONFIGURACION_PR;

PROCEDURE CO_CARGA_CONFIGURACION_PEN_PR(SO_Lista_configuracion        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_INMUNES_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

LV_estadoPEN VARCHAR2(3) := 'PEN';
BEGIN

CO_CARGA_CONFIGURACION_PR(LV_estadoPEN,null, SO_Lista_configuracion, SV_mens_retorno);

END CO_CARGA_CONFIGURACION_PEN_PR;

PROCEDURE CO_CARGA_CONFIGURACION_PRO_PR(SO_Lista_configuracion        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_INMUNES_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

LV_estadoPRO VARCHAR2(15) := 'PRO';
LV_estadoVIS VARCHAR2(15) := 'VIS';
BEGIN

CO_CARGA_CONFIGURACION_PR(LV_estadoPRO, LV_estadoVIS, SO_Lista_configuracion, SV_mens_retorno);

END CO_CARGA_CONFIGURACION_PRO_PR;


PROCEDURE CO_ELIMINA_CONFIGURACION_PR (  EO_Num_secuencia    IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_ELIMINA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

       LV_sSql:=' DELETE CO_PARAM_COBEX_TO';
       LV_sSql:=LV_sSql || ' WHERE  NUM_SECUENCIA = ' || EO_Num_secuencia;

       DELETE CO_PARAM_COBEX_TO
       WHERE NUM_SECUENCIA = EO_Num_secuencia;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2930; --Error al eliminar datos de Filtros
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_CONFIGURACION_PR(' || EO_Num_secuencia  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_CONFIGURACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_ELIMINA_CONFIGURACION_PR;

PROCEDURE CO_REASIGNA_EMPRESA_PR (EO_Num_secuencia IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                   EO_Cod_entidad  IN              CO_ENTCOB.COD_ENTIDAD%type,
                                   EO_Cod_cliente  IN              CO_MOROSOS.COD_CLIENTE%type,
                                   SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento   OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_REASIGNA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="16-09-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

       LV_sSql:='UPDATE CO_GESTION_COBEX_TO SET';
       LV_sSql:=LV_sSql || ' COD_ENTIDAD = '||EO_Cod_entidad;
       LV_sSql:=LV_sSql || ' WHERE COD_CLIENTE=' || EO_Cod_cliente;
       LV_sSql:=LV_sSql || ' AND NUM_SECUENCIA = ' || EO_Num_secuencia; 
       
       UPDATE CO_GESTION_COBEX_TO SET
              COD_ENTIDAD = EO_Cod_entidad
       WHERE  COD_CLIENTE  = EO_Cod_cliente
       AND NUM_SECUENCIA = EO_Num_secuencia; 

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2931; --Error al Reasignar Cliente
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_REASIGNA_EMPRESA_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_REASIGNA_EMPRESA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_REASIGNA_EMPRESA_PR;

PROCEDURE CO_EXCLUYE_CLIENTE_PR (EO_Num_secuencia IN CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                   EO_Cod_cliente  IN CO_MOROSOS.COD_CLIENTE%type,
                                   SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_REASIGNA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="16-09-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

       LV_sSql:='UPDATE CO_GESTION_COBEX_TO SET';
       LV_sSql:=LV_sSql || ' FEC_TERMINO = SYSDATE';
       LV_sSql:=LV_sSql || ' WHERE COD_CLIENTE=' || EO_Cod_cliente;
       LV_sSql:=LV_sSql || ' AND NUM_SECUENCIA = ' || EO_Num_secuencia; 
       
       UPDATE CO_GESTION_COBEX_TO SET
              FEC_TERMINO = SYSDATE
       WHERE  COD_CLIENTE  = EO_Cod_cliente
       AND NUM_SECUENCIA = EO_Num_secuencia; 

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2932; --Error al Excluir cliente de Cobranza
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_EXCLUYE_CLIENTE_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_EXCLUYE_CLIENTE_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_EXCLUYE_CLIENTE_PR;

PROCEDURE CO_VISA_CONFIGURACION_PR (EO_Num_secuencia    IN              CO_PARAM_COBEX_TO.NUM_SECUENCIA%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_ELIMINA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 LV_estadovisado VARCHAR2(3) := 'VIS';
 LV_observacion VARCHAR2(100);
 LV_tipmor VARCHAR2(10) := 'MOROS';
 LV_tipGestion CO_PARAM_COBEX_TO.TIP_GESTION%TYPE;
 LV_codGestion CO_GESTION_TO.COD_GESTION%TYPE;
BEGIN

       sn_cod_retorno  := 0;
       sv_mens_retorno := NULL;
       sn_num_evento  := 0;

       LV_sSql:=' UPDATE CO_PARAM_COBEX_TO';
       LV_sSql:=LV_sSql || ' SET COD_ESTADO = ' || LV_estadovisado;
       LV_sSql:=LV_sSql || ' WHERE  NUM_SECUENCIA = ' || EO_Num_secuencia; 

       UPDATE CO_PARAM_COBEX_TO
       SET COD_ESTADO = LV_estadovisado
       WHERE NUM_SECUENCIA = EO_Num_secuencia;
       
       SELECT TIP_GESTION
       INTO LV_tipGestion
       FROM CO_PARAM_COBEX_TO
       WHERE NUM_SECUENCIA = EO_Num_secuencia;
       
       LV_codGestion := '798'; --Por Defecto Pre-Mora
       LV_observacion := 'ASIGNA EMPRESA DE PRE-MORA: ';
       IF LV_tipGestion = 'M' THEN   
           LV_codGestion := '778';
           LV_observacion := 'ASIGNA EMPRESA DE COBRANZA: ';    
           
            LV_sSql:=' UPDATE co_morosos  z';
            LV_sSql:=LV_sSql || ' SET z.cod_agente = ';
            LV_sSql:=LV_sSql || ' (SELECT b.cod_entidad FROM co_gestion_cobex_to b';
            LV_sSql:=LV_sSql || ' WHERE z.cod_cliente = b.cod_cliente AND b.num_secuencia = ' || EO_Num_secuencia;
            LV_sSql:=LV_sSql || ' AND b.fec_termino IS NULL)';
            LV_sSql:=LV_sSql || ' WHERE cod_cliente IN';
            LV_sSql:=LV_sSql || ' (SELECT a.cod_cliente FROM co_gestion_cobex_to a';
            LV_sSql:=LV_sSql || ' WHERE z.cod_cliente = a.cod_cliente';
            LV_sSql:=LV_sSql || ' AND a.num_secuencia = ' || EO_Num_secuencia || ' AND a.fec_termino IS NULL)';
                       
            UPDATE co_morosos  z
            SET z.cod_agente = 
            (SELECT b.cod_entidad FROM co_gestion_cobex_to b 
            WHERE z.cod_cliente = b.cod_cliente AND b.num_secuencia = EO_Num_secuencia 
            AND b.fec_termino IS NULL)
            WHERE cod_cliente IN
            (SELECT a.cod_cliente FROM co_gestion_cobex_to a
            WHERE z.cod_cliente = a.cod_cliente
            AND a.num_secuencia = EO_Num_secuencia AND a.fec_termino IS NULL);           
       END IF;
            
       LV_sSql:='INSERT INTO CO_GESTION_TO (COD_CLIENTE, COD_CUENTA, COD_TIPIDENT, NUM_IDENT,';
       LV_sSql:=LV_sSql || ' COD_GESTION, FEC_GESTION, OBS_GESTION, NOM_USUARIO, ';
       LV_sSql:=LV_sSql || ' FEC_ULTMOD, COD_CICLO, COD_TIPMOR)';
       LV_sSql:=LV_sSql || ' SELECT B.COD_CLIENTE, B.COD_CUENTA, B.COD_TIPIDENT, B.NUM_IDENT,';
       LV_sSql:=LV_sSql || ' ' || LV_codGestion || ',SYSDATE, ''' || LV_observacion || '''' || 'A.COD_ENTIDAD, USER,';
       LV_sSql:=LV_sSql || ' SYSDATE, NULL, ''' || LV_tipmor||'''';
       LV_sSql:=LV_sSql || ' FROM GE_CLIENTES B, CO_GESTION_COBEX_TO A';
       LV_sSql:=LV_sSql || ' WHERE B.COD_CLIENTE = A.COD_CLIENTE';
       LV_sSql:=LV_sSql || ' AND A.NUM_SECUENCIA = ' || EO_Num_secuencia;
       LV_sSql:=LV_sSql || ' AND A.FEC_TERMINO IS NULL';
       
       INSERT INTO CO_GESTION_TO (COD_CLIENTE, COD_CUENTA, COD_TIPIDENT, NUM_IDENT,
       COD_GESTION, FEC_GESTION, OBS_GESTION, NOM_USUARIO, 
       FEC_ULTMOD, COD_CICLO, COD_TIPMOR)
       SELECT B.COD_CLIENTE, B.COD_CUENTA, B.COD_TIPIDENT, B.NUM_IDENT,
       LV_codGestion,SYSDATE, LV_observacion || A.COD_ENTIDAD, USER,
       SYSDATE, NULL, LV_tipmor
       FROM GE_CLIENTES B, CO_GESTION_COBEX_TO A
       WHERE B.COD_CLIENTE = A.COD_CLIENTE
       AND A.NUM_SECUENCIA = EO_Num_secuencia
       AND A.FEC_TERMINO IS NULL;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2933; --Error al Visar Asignacion de Clientes a Empresas de Cobranza
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_VISA_CONFIGURACION_PR(' || EO_Num_secuencia  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_VISA_CONFIGURACION_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_VISA_CONFIGURACION_PR;


PROCEDURE CO_CARGA_PORCENTAJES_PR(SO_Lista_empresa        OUT NOCOPY refCursor,
                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_PORCENTAJES_PR Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2) || ' ' ||ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato7);

         LV_sSql:=' OPEN SO_Lista_empresa FOR ';
         LV_sSql:=LV_sSql || ' select c.des_entidad';
         LV_sSql:=LV_sSql || ' ,b.des_rango';
         LV_sSql:=LV_sSql || ' ,a.prc_asignacion, a.nom_usuario, to_char(fec_modificacion,LV_Formato_Sel), a.cod_entidad, a.cod_rango';
         LV_sSql:=LV_sSql || ' from  co_entidad_rango_td a, co_rangos_cobex_td b, co_entcob c';
         LV_sSql:=LV_sSql || ' WHERE a.cod_rango = b.cod_rango';
         LV_sSql:=LV_sSql || ' AND a.cod_entidad = c.cod_entidad';
         LV_sSql:=LV_sSql || ' AND SYSDATE BETWEEN c.fec_ini_vigencia AND c.fec_fin_vigencia';
         LV_sSql:=LV_sSql || ' ORDER BY a.cod_rango, a.cod_entidad';


         OPEN SO_Lista_empresa FOR
         SELECT  c.des_entidad
                 ,b.des_rango
                 ,a.prc_asignacion, a.nom_usuario, to_char(fec_modificacion,LV_Formato_Sel), a.cod_entidad, a.cod_rango
         FROM co_entidad_rango_td a, co_rangos_cobex_td b, co_entcob c
         WHERE a.cod_rango = b.cod_rango
         AND a.cod_entidad = c.cod_entidad
         AND SYSDATE BETWEEN c.fec_ini_vigencia AND c.fec_fin_vigencia
         ORDER BY a.cod_rango, a.cod_entidad;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2934; -- Error al cargar Porcentajes de Asignacion por Entidad
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_PORCENTAJES_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_PORCENTAJES_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_PORCENTAJES_PR;

PROCEDURE CO_INSERTA_RANGO_PR (  EO_Cod_entidad  IN              CO_ENTIDAD_RANGO_TD.COD_ENTIDAD%type,
                                   EO_Cod_rango    IN              CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                   EO_Porcentaje      IN           CO_ENTIDAD_RANGO_TD.PRC_ASIGNACION%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_INSERTA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 LN_contador INTEGER;

BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento  := 0;

    LV_sSql:=' INSERT INTO CO_ENTIDAD_RANGO_TD';
    LV_sSql:=LV_sSql || ' (COD_ENTIDAD, COD_RANGO, PRC_ASIGNACION, NOM_USUARIO, FEC_MODIFICACION)';
    LV_sSql:=LV_sSql || ' VALUES ('||EO_Cod_entidad ||', ' || EO_Cod_rango || ', ' || EO_Porcentaje || ', USER, SYSDATE)';
    
    SELECT COUNT(1) 
    INTO LN_contador
    FROM CO_ENTIDAD_RANGO_TD 
    WHERE cod_entidad = EO_Cod_entidad
    AND cod_rango = EO_Cod_rango;
    
    IF LN_contador = 0 THEN
        INSERT INTO co_entidad_rango_td 
               (COD_ENTIDAD, COD_RANGO, PRC_ASIGNACION, NOM_USUARIO, FEC_MODIFICACION)
        VALUES (EO_Cod_entidad, EO_Cod_rango,EO_Porcentaje, USER, SYSDATE);
    ELSE
        UPDATE co_entidad_rango_td 
        SET prc_asignacion = EO_Porcentaje,
        nom_usuario = USER,
        fec_modificacion = SYSDATE
        WHERE cod_entidad = EO_Cod_entidad
        AND cod_rango = EO_Cod_rango;
    
    END IF;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2935; --Error al ingresar Porcentaje asignado a Empresa de Cobranza
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_RANGO_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_RANGO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
       RAISE_APPLICATION_ERROR(-20104, SV_mens_retorno);

END CO_INSERTA_RANGO_PR;

PROCEDURE CO_ELIMINA_RANGO_PR (  EO_Cod_entidad  IN              CO_ENTIDAD_RANGO_TD.COD_ENTIDAD%type,
                                   EO_Cod_rango    IN              CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                   SN_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento     OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_ELIMINA_RANGO_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

       LV_sSql:=' DELETE CO_ENTIDAD_RANGO_TD';
       LV_sSql:=LV_sSql || ' WHERE COD_ENTIDAD = ' || EO_Cod_entidad;
       LV_sSql:=LV_sSql || ' AND COD_RANGO = ' || EO_Cod_rango;

       DELETE CO_ENTIDAD_RANGO_TD
       WHERE COD_ENTIDAD = EO_Cod_entidad
       AND COD_RANGO = EO_Cod_rango;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2936; --Error al Eliminar Porcentaje asignado a Empresa de Cobranza 
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_RANGO_PR(' || EO_Cod_entidad  || ',' || EO_Cod_rango || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_ELIMINA_RANGO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_ELIMINA_RANGO_PR;

PROCEDURE CO_CARGA_CBO_EMPRE_RAN_PR(EO_Cod_rango    IN  CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                SO_Lista_cbo        OUT NOCOPY refCursor,
                                SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_CBO_EMPRE_RAN_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_cbo FOR ';
         LV_sSql:=LV_sSql || ' a.cod_entidad, a.des_entidad ';
         LV_sSql:=LV_sSql || ' co_entcob a, co_entidad_rango_td b';
         LV_sSql:=LV_sSql || ' WHERE a.cod_entidad = b.cod_entidad';
         LV_sSql:=LV_sSql || ' AND b.cod_rango = ' || EO_Cod_rango;
         LV_sSql:=LV_sSql || ' AND SYSDATE BETWEEN fec_ini_vigencia AND fec_fin_vigencia';
         
         OPEN SO_Lista_cbo FOR
         SELECT a.cod_entidad, a.des_entidad 
         FROM co_entcob a, co_entidad_rango_td b
         WHERE a.cod_entidad = b.cod_entidad 
         AND b.cod_rango = EO_Cod_rango
         AND SYSDATE BETWEEN fec_ini_vigencia AND fec_fin_vigencia;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2937; --Error al obtener Empresas de Cobranza con participacion en el Rango
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE_VIG_PR(' || 'SO_Lista_empresa'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_CBO_EMPRE', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_CBO_EMPRE_RAN_PR;

PROCEDURE CO_PORCENTAJE_RANGO_PR (EO_Cod_entidad  IN              CO_ENTIDAD_RANGO_TD.COD_ENTIDAD%type,
                                   EO_Cod_rango    IN              CO_ENTIDAD_RANGO_TD.COD_RANGO%type,
                                   EO_Porcentaje     OUT NOCOPY     refCursor,
                                   SV_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_INSERTA_EMPRESA_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
 LN_contador INTEGER;
 ERR_PORCENTAJE EXCEPTION;
 LN_num_evento     ge_errores_pg.evento;
 LN_cod_retorno    ge_errores_td.cod_msgerror%TYPE;
BEGIN

    ln_cod_retorno  := 0;
    sv_mens_retorno := '';
    ln_num_evento  := 0;

    LV_sSql:=' OPEN EO_Porcentaje FOR';
    LV_sSql:=LV_sSql || ' SELECT NVL(SUM(B.PRC_ASIGNACION), 0)';
    LV_sSql:=LV_sSql || ' WHERE A.COD_ENTIDAD = B.COD_ENTIDAD';
    LV_sSql:=LV_sSql || ' AND SYSDATE BETWEEN A.FEC_INI_VIGENCIA AND A.FEC_FIN_VIGENCIA';
    LV_sSql:=LV_sSql || ' AND B.COD_RANGO = ' || EO_Cod_rango;
    LV_sSql:=LV_sSql || ' AND B.COD_ENTIDAD != ' || EO_Cod_entidad;
    
    OPEN EO_Porcentaje FOR
    SELECT NVL(SUM(B.PRC_ASIGNACION), 0)
    FROM CO_ENTCOB A, CO_ENTIDAD_RANGO_TD B    
    WHERE A.COD_ENTIDAD = B.COD_ENTIDAD
    AND SYSDATE BETWEEN A.FEC_INI_VIGENCIA AND A.FEC_FIN_VIGENCIA
    AND B.COD_RANGO = EO_Cod_rango
    AND B.COD_ENTIDAD != EO_Cod_entidad ;

EXCEPTION
   WHEN OTHERS THEN
       LN_cod_retorno := 2938; --Error al obtener Porcentaje asignado a otras Empresas de Cobranza en el Rango
       IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_PORCENTAJE_RANGO_PR(' || 'EO_Cod_entidad'  || ')' || SQLERRM;
       LN_num_evento  := Ge_Errores_Pg.Grabarpl( LN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_INSERTA_RANGO_PR', LV_sSQL, LN_cod_retorno, LV_des_error );

END CO_PORCENTAJE_RANGO_PR;

PROCEDURE CO_CARGA_TIPENTIDAD_PR(SO_Lista_entidad        OUT NOCOPY refCursor,
                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_CARGA_EMPRESAS_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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
SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_sSql:=' OPEN SO_Lista_empresa FOR ';
         LV_sSql:=LV_sSql || ' select  cod_valor,des_valor';
         LV_sSql:=LV_sSql || ' from    co_codigos';
         LV_sSql:=LV_sSql || ' WHERE nom_tabla = CO_ENTCOB';
         LV_sSql:=LV_sSql || ' AND nom_columna = TIP_ENTIDAD';
         LV_sSql:=LV_sSql || ' ORDER BY DES_VALOR;';


         OPEN SO_Lista_entidad  FOR
         select  cod_valor,des_valor
         from    co_codigos
         WHERE nom_tabla = 'CO_ENTCOB'
         AND nom_columna = 'TIP_ENTIDAD'
         ORDER BY DES_VALOR;

EXCEPTION
   WHEN OTHERS THEN
       SN_cod_retorno := 2939; --Error al Obtener Tipos de Entidad de Cobranza
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_TIPENTIDAD_PR(' || 'SO_Lista_entidad'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_CARGA_TIPENTIDAD_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_CARGA_TIPENTIDAD_PR;

-------------------------------------------------------------------------------
PROCEDURE CO_VALIDA_RANGO_INMUNIDAD_PR(EO_CodCliente IN CO_COBEX_INMUNE_TO.COD_CLIENTE%TYPE,
                               EO_FecDesde IN VARCHAR2,
                               EO_FecHasta IN VARCHAR2,                               
                               SO_Lista_inmunes        OUT NOCOPY refCursor,
                               SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE)

IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "CO_VALIDA_RANGO_INMUNIDAD_PR" Lenguaje="PL/SQL" Fecha="21-07-2009"   Versión="1.0.0"  Diseñador="RyC" Programador="RyC"   
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
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

SN_cod_retorno        ge_errores_td.cod_msgerror%TYPE;
SN_num_evento         ge_errores_pg.evento;
/*LN_nomtabla VARCHAR2(11) := 'GE_CLIENTES';
LN_segmento VARCHAR2(12) := 'COD_SEGMENTO';
LN_calificacion VARCHAR2(16) := 'COD_CALIFICACION';
LN_nomtablacat VARCHAR2(13) := 'GE_CATEGORIAS';
LN_categoria VARCHAR2(16) := 'COD_CATEGORIA';
LN_tablamorosos VARCHAR2(10) := 'CO_MOROSOS';*/
LV_Formato_Sel2 varchar2(50);
LN_contador NUMBER(1) := 0;
ERR_INMUNIDAD EXCEPTION;

BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := '';

         LV_Formato_Sel2 := ge_fn_devvalparam(CV_cod_modulo_GE, CN_producto,CV_gsFormato2);
         
         SELECT count(1)
         INTO LN_contador
         FROM co_cobex_inmune_to
         WHERE cod_cliente = EO_CodCliente
         AND fec_desde != TO_DATE(EO_FecDesde, LV_Formato_Sel2)
         AND (
         (fec_desde <= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta >= TO_DATE(EO_FecHasta, LV_Formato_Sel2))
         OR
         (fec_desde >= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta <= TO_DATE(EO_FecHasta, LV_Formato_Sel2))
         OR
         (fec_desde <= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta >= TO_DATE(EO_FecDesde, LV_Formato_Sel2))
         OR
         (fec_desde <= TO_DATE(EO_FecHasta, LV_Formato_Sel2) AND fec_hasta >= TO_DATE(EO_FecHasta, LV_Formato_Sel2))
         OR
         (fec_desde >= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta <= TO_DATE(EO_FecHasta, LV_Formato_Sel2))          
         );
         
         OPEN SO_Lista_inmunes FOR
         select  a.cod_cliente ,                 
                 to_char(a.fec_desde,LV_Formato_Sel2), to_char(a.fec_hasta,LV_Formato_Sel2)               
         from    co_cobex_inmune_to a
         WHERE cod_cliente = EO_CodCliente
         AND fec_desde != TO_DATE(EO_FecDesde, LV_Formato_Sel2)
         AND (
         (fec_desde <= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta >= TO_DATE(EO_FecHasta, LV_Formato_Sel2))
         OR
         (fec_desde >= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta <= TO_DATE(EO_FecHasta, LV_Formato_Sel2))
         OR
         (fec_desde <= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta >= TO_DATE(EO_FecDesde, LV_Formato_Sel2))
         OR
         (fec_desde <= TO_DATE(EO_FecHasta, LV_Formato_Sel2) AND fec_hasta >= TO_DATE(EO_FecHasta, LV_Formato_Sel2))
         OR
         (fec_desde >= TO_DATE(EO_FecDesde, LV_Formato_Sel2) AND fec_hasta <= TO_DATE(EO_FecHasta, LV_Formato_Sel2))          
         );
                  
         IF LN_contador >0 THEN
            RAISE ERR_INMUNIDAD;
         END IF;        

EXCEPTION
   WHEN ERR_INMUNIDAD THEN
       SN_cod_retorno := 2941;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_VALIDA_RANGO_INMUNIDAD_PR(' || 'SO_Lista_inmunes'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_VALIDA_RANGO_INMUNIDAD_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          
   WHEN OTHERS THEN
       SN_cod_retorno := 2942;
       IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_error_no_clasif;
       END IF;

       LV_des_error   := 'CO_COBRANZA_EXTERNA_PG.CO_VALIDA_RANGO_INMUNIDAD_PR(' || 'SO_Lista_inmunes'  || ')' || SQLERRM;
       SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo_CO, SV_mens_retorno, CV_version, USER, 'CO_COBRANZA_EXTERNA_PG.CO_VALIDA_RANGO_INMUNIDAD_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END CO_VALIDA_RANGO_INMUNIDAD_PR;

END CO_COBRANZA_EXTERNA_PG;
/
SHOW ERRORS