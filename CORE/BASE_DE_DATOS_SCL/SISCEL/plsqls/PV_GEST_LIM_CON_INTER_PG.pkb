CREATE OR REPLACE PACKAGE BODY PV_GEST_LIM_CON_INTER_PG IS

PROCEDURE PV_EJEC_GA_ESTADO_VENDEDOR_PR(
                                        EN_COD_VENDEDOR     IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                        SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO)
IS



/*
  <DOCUMENTACIÓN
    TIPODOC = "PROCEDURE">
     <ELEMENTO
        NOMBRE = "PV_EJEC_GA_ESTADO_VENDEDOR_PR"
        LENGUAJE="PL/SQL"
        FECHA="08-03-2011"
        VERSIÓN="1.0"
        DISEÑADOR="EVERIS"
        PROGRAMADOR="EVERIS"
        AMBIENTE DESARROLLO="BD">
        <RETORNO></RETORNO>
        <DESCRIPCIÓN>EJECUTA EL PROCEDIMIENTO ALMACENADO P_GA_ESTADO_VENDEDOR PARA OBTENER EL ESTADO DEL VENDEDOR</DESCRIPCIÓN>
        <PARÁMETROS>
           <ENTRADA>
              <PARAM NOM="EN_COD_VENDEDOR" TIPO="NUMBER"> CODIGO DEL VENDEDOR </PARAM>
           </ENTRADA>
           <RETORNO>
              <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
              <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
              <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
            </RETORNO>
        </PARÁMETROS>
     </ELEMENTO>
  </DOCUMENTACIÓN>
*/


LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
LV_SSQL                    GE_ERRORES_PG.VQUERY;
LV_NOMBRE_PROC             STRING(30)   := 'PV_EJEC_GA_ESTADO_VENDEDOR_PR';
LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
LN_NUM_TRANSACC            GA_TRANSACABO.NUM_TRANSACCION%TYPE;




BEGIN
    SN_COD_RETORNO := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO := 0;


    LV_SSQL := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL FROM DUAL';

    SELECT GA_SEQ_TRANSACABO.NEXTVAL
    INTO LN_NUM_TRANSACC FROM DUAL ;


    LV_SSQL := 'P_GA_ESTADO_VENDEDOR('|| LN_NUM_TRANSACC ||','|| EN_COD_VENDEDOR || ')';

    P_GA_ESTADO_VENDEDOR(LN_NUM_TRANSACC,EN_COD_VENDEDOR);

    LV_SSQL := 'SELECT COD_RETORNO, DES_CADENA '
            || 'FROM GA_TRANSACABO WHERE NUM_TRANSACCION = ' || LN_NUM_TRANSACC;

    SELECT COD_RETORNO, DES_CADENA
    INTO SN_COD_RETORNO, SV_MENS_RETORNO
    FROM GA_TRANSACABO WHERE NUM_TRANSACCION = LN_NUM_TRANSACC;

    DELETE
    FROM GA_TRANSACABO
    WHERE NUM_TRANSACCION = LN_NUM_TRANSACC;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SN_COD_RETORNO := 100007;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_COD_VENDEDOR||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_COD_VENDEDOR||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


END PV_EJEC_GA_ESTADO_VENDEDOR_PR;


PROCEDURE PV_BLOQ_DESBLOQ_VENDEDOR_PR(
                                      EN_COD_VENDEDOR       IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                      EV_ACCION             IN VARCHAR2,
                                      SN_COD_RETORNO           OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                      SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                      SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO
)
 /*
<DOCUMENTACIÓN
  TIPODOC = "PROCEDIMIENTO">
   <ELEMENTO
      NOMBRE = "PV_BLOQ_DESBLOQ_VENDEDOR_PR"
      LENGUAJE="PL/SQL"
      FECHA="10-06-2008"
      VERSIÓN="1.0"
      DISEÑADOR="EVERIS"
      PROGRAMADOR="EVERIS"
      AMBIENTE DESARROLLO="BD">
      <RETORNO>NA</RETORNO>
      <DESCRIPCIÓN>  OBTENER EL CÓDIGO DE PRODUCTO CELULAR </DESCRIPCIÓN>
      <PARÁMETROS>
         <ENTRADA>
              <PARAM NOM="EN_COD_VENDEDOR" TIPO="NUMBER"> CODIGO DEL VENDEDOR </PARAM>
              <PARAM NOM="EV_ACCION" TIPO="VARCHAR2"> CODIGO DE ACCION </PARAM>
         </ENTRADA>
         <SALIDA>
            <PARAM NOM="SN_COD_RETORNO"  TIPO="NUMERICO" >CÓDIGO DE RETORNO (DESCRIPCIÓN DE ERROR)</PARAM>
            <PARAM NOM="SV_MENS_RETORNO"  TIPO="VARCHAR" >MENSAJE DE RETORNO (CÓDIGO DE ERROR)</PARAM>
            <PARAM NOM="SN_NUM_EVENTO"  TIPO="NUMERICO" >NÚMERO DE EVENTO</PARAM>
         </SALIDA>
      </PARÁMETROS>
   </ELEMENTO>
</DOCUMENTACIÓN>
*/
IS
    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC             STRING(30)   := 'PV_BLOQ_DESBLOQ_VENDEDOR_PR';
    LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
    LN_NUM_TRANSACC            GA_TRANSACABO.NUM_TRANSACCION%TYPE;
BEGIN

     SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;

    SELECT GA_SEQ_TRANSACABO.NEXTVAL
    INTO LN_NUM_TRANSACC FROM DUAL;

    LV_SSQL:='P_GA_BLOQUEA_VENDEDOR('||LN_NUM_TRANSACC||','||EN_COD_VENDEDOR||','||EV_ACCION||')';

    P_GA_BLOQUEA_VENDEDOR(LN_NUM_TRANSACC,EN_COD_VENDEDOR,EV_ACCION);

    LV_SSQL := 'SELECT COD_RETORNO, DES_CADENA '
            || 'FROM GA_TRANSACABO '
            || 'WHERE NUM_TRANSACCION ='||LN_NUM_TRANSACC;

    SELECT COD_RETORNO, DES_CADENA INTO SN_COD_RETORNO, SV_MENS_RETORNO
    FROM GA_TRANSACABO
    WHERE NUM_TRANSACCION = LN_NUM_TRANSACC;

    DELETE
    FROM GA_TRANSACABO
    WHERE NUM_TRANSACCION = LN_NUM_TRANSACC;

EXCEPTION
    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
            SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC||'('||EN_COD_VENDEDOR||','''||EV_ACCION||'''); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, GV_COD_MODULO,SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_BLOQ_DESBLOQ_VENDEDOR_PR;


PROCEDURE PV_EJECUTA_ESQ_RESTRICCION_PR(
                                        EV_SECUENCIA       IN VARCHAR2,
                                        EV_CODMODULO       IN VARCHAR2,
                                        EV_CODPRODUCTO     IN VARCHAR2,
                                        EV_CODACTABO       IN VARCHAR2,
                                        EV_EVENTO          IN VARCHAR2,
                                        EV_PROGRAMA        IN VARCHAR2,
                                        EV_PROCESO         IN VARCHAR2,
                                        EV_CODACTABODET    IN VARCHAR2,
                                        EV_NUMABONADO      IN VARCHAR2,
                                        EV_CODCLIENTE      IN VARCHAR2,
                                        EV_CODMODGENER     IN VARCHAR2,
                                        EV_NUMVENTA        IN VARCHAR2,
                                        EV_CODOS           IN VARCHAR2,
                                        EV_CODVENDEDOR     IN VARCHAR2,
                                        EV_DESSS           IN VARCHAR2,
                                        EV_CODPLANTARIFD   IN VARCHAR2,
                                        EV_CODUSO          IN VARCHAR2,
                                        EV_CODCUENTAORIGEN IN VARCHAR2,
                                        EV_CODCUENTADEST   IN VARCHAR2,
                                        EV_CODCLIENTEDEST  IN VARCHAR2,
                                        EV_CODTIPPLANTARIF IN VARCHAR2,
                                        EV_CODTIPPLANTARID IN VARCHAR2,
                                        EV_CODCICLO        IN VARCHAR2,
                                        EV_CODFECHASISTEMA IN VARCHAR2,
                                        EV_RESTRICCION     IN VARCHAR2,
                                        EV_CODMODULODET    IN VARCHAR2,
                                        EV_NUMID           IN VARCHAR2,
                                        EV_CODCENTRAL      IN VARCHAR2,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS
    /*
    <DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
    <ELEMENTO NOMBRE = "PV_EJECUTA_ESQUEMA_RESTRICCION_PR"
    LENGUAJE="PL/SQL"
    FECHA="13-03-2008"
    VERSIÓN="1.0.1"
     DISEÑADOR="EVERIS"
    PROGRAMADOR="EVERIS"
    AMBIENTE="BD">
    <RETORNO> NUMERO DE CELULAR </RETORNO>
    <DESCRIPCIÓN> EJECUTA EL ESQUEMA DE RESTRICCIONES DE POST VENTA</DESCRIPCIÓN>
    <PARÁMETROS>
        <ENTRADA>
            <PARAM NOM="EV_SECUENCIA"  TIPO="VARCHAR2"> SECUENCIA TRANSACABO </PARAM>
            <PARAM NOM="EV_CODMODULO"  TIPO="VARCHAR2"> CÓDIGO DEL MODULO </PARAM>
            <PARAM NOM="EV_CODPRODUCTO"  TIPO="VARCHAR2"> CÓDIGO DEL PRODUCTO </PARAM>
            <PARAM NOM="EV_CODACTABO"  TIPO="VARCHAR2"> CÓDIGO ACTUACIÓN </PARAM>
            <PARAM NOM="EV_EVENTO"  TIPO="VARCHAR2"> EVENTO </PARAM>
            <PARAM NOM="EV_PROGRAMA"  TIPO="VARCHAR2"> PROGRAMA </PARAM>
            <PARAM NOM="EV_PROCESO"  TIPO="VARCHAR2"> NUMERO PROCESO </PARAM>
            <PARAM NOM="EV_CODACTABODET"  TIPO="VARCHAR2"> CÓDIGO ACTUACIÓN </PARAM>
            <PARAM NOM="EV_NUMABONADO"  TIPO="VARCHAR2"> NUMERO ABONADO </PARAM>
            <PARAM NOM="EV_CODCLIENTE"  TIPO="VARCHAR2"> CODIGO CLIENTE </PARAM>
            <PARAM NOM="EV_CODMODGENER"  TIPO="VARCHAR2"> MODO DE GENERACIÓN </PARAM>
            <PARAM NOM="EV_NUMVENTA"  TIPO="VARCHAR2"> NUMERO VENTA </PARAM>
            <PARAM NOM="EV_CODOS"  TIPO="VARCHAR2"> CÓDIGO ORDEN DE SERVICIO </PARAM>
            <PARAM NOM="EV_CODVENDEDOR"  TIPO="VARCHAR2"> CÓDIGO VENDEDOR </PARAM>
            <PARAM NOM="EV_DESSS"  TIPO="VARCHAR2"> DESSS </PARAM>
            <PARAM NOM="EV_CODPLANTARIFD"  TIPO="VARCHAR2"> CODIGO PLAN TARIFARIO DESTINO </PARAM>
            <PARAM NOM="EV_CODUSO"  TIPO="VARCHAR2"> CODIGO USO </PARAM>
            <PARAM NOM="EV_CODCUENTAORIGEN"  TIPO="VARCHAR2"> CODIGO CUENTA ORIGEN </PARAM>
            <PARAM NOM="EV_CODCUENTADEST"  TIPO="VARCHAR2"> CODIGO CUENTA DESTINO </PARAM>
            <PARAM NOM="EV_CODCLIENTEDEST"  TIPO="VARCHAR2"> CODIGO CLIENTE DESTINO </PARAM>
            <PARAM NOM="EV_CODTIPPLANTARIF"  TIPO="VARCHAR2"> CODIGO TIPO PLAN TARIFARIO </PARAM>
            <PARAM NOM="EV_CODTIPPLANTARID"  TIPO="VARCHAR2"> CODIGO TIPO PLAN TARIFARIO DESTINO </PARAM>
            <PARAM NOM="EV_CODCICLO"  TIPO="VARCHAR2"> CODIGO CICLO DE FACTURACION </PARAM>
            <PARAM NOM="EV_CODFECHASISTEMA"  TIPO="VARCHAR2"> FECHA ACTUAL DE SISTEMA </PARAM>
            <PARAM NOM="EV_RESTRICCION"  TIPO="VARCHAR2"> RESTRICCION </PARAM>
            <PARAM NOM="EV_CODMODULODET"  TIPO="VARCHAR2"> CODIGO MODULO DETALLE </PARAM>
            <PARAM NOM="EV_NUMID"  TIPO="VARCHAR2"> NUMERO ID </PARAM>
            <PARAM NOM="EV_CODCENTRAL"  TIPO="VARCHAR2"> CODIGO CENTRAL </PARAM>
        </ENTRADA>
        <SALIDA>
            <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
            <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
            <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
        </SALIDA>
    </PARÁMETROS>
    </ELEMENTO>
    </DOCUMENTACIÓN>
    */

    LV_VERSION                  GE_PROGRAMAS.NUM_VERSION%TYPE;
    LV_SUBVERSION               GE_PROGRAMAS.NUM_SUBVERSION%TYPE;
    V_SECUENCIA                 VARCHAR2(09);
    V_MODULO                    VARCHAR2(02);
    V_PRODUCTO                  NUMBER  (01);
    V_ACTUACION                 VARCHAR2(02);
    V_EVENTO                    VARCHAR2(10);
    V_PARAM_ENTRADA             VARCHAR2(2000);
    V_SCRIPT                    VARCHAR(200);

    LV_DES_ERROR                GE_ERRORES_PG.DESEVENT;
    LV_SSQL                     GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC              STRING(30)   := 'PV_EJECUTA_ESQ_RESTRICCION_PR';
    LV_PKG_PROC                 STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
    LN_NUM_TRANSACC             GA_TRANSACABO.NUM_TRANSACCION%TYPE;

BEGIN

     SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;

    SELECT GA_SEQ_TRANSACABO.NEXTVAL
    INTO V_SECUENCIA FROM DUAL;
    V_MODULO        := 'GA';
    V_PRODUCTO      := 1;

    V_ACTUACION     := EV_CODACTABO;
    V_EVENTO        := EV_EVENTO;

    LV_SSQL:='SISCEL.PV_GENERALES_PG.PV_obtiene_version_FN('||LV_VERSION||','||LV_SUBVERSION||','||SN_COD_RETORNO||','||SV_MENS_RETORNO||','||SN_NUM_EVENTO||') ';
    IF PV_GENERALES_PG.PV_OBTIENE_VERSION_FN(LV_VERSION,LV_SUBVERSION,SN_COD_RETORNO,SV_MENS_RETORNO, SN_NUM_EVENTO) = FALSE THEN
               RAISE ERROR_GENERAL;
    END IF;

    V_PARAM_ENTRADA  := '';
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_PROGRAMA;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||TO_CHAR(LV_VERSION);
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_PROCESO;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODACTABODET;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_NUMABONADO;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODCLIENTE;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODMODGENER;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_NUMVENTA;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODOS;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODVENDEDOR;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_DESSS;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODPLANTARIFD;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODUSO;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODCUENTAORIGEN;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODCUENTADEST;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODCLIENTEDEST;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODTIPPLANTARIF;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODTIPPLANTARID;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODCICLO;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODFECHASISTEMA;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_RESTRICCION;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODMODULODET;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_NUMID;
    V_PARAM_ENTRADA  := V_PARAM_ENTRADA ||'|'||EV_CODCENTRAL||'|';

    LV_SSQL:='SISCEL.PV_PR_EJECUTA_RESTRICCION('''||V_SECUENCIA||''','''||V_MODULO||''','''||V_PRODUCTO||''','''||V_ACTUACION||''','''||V_EVENTO||''','''||V_PARAM_ENTRADA||''') ';

    V_SCRIPT := LV_SSQL;

    SISCEL.PV_PR_EJECUTA_RESTRICCION (V_SECUENCIA,V_MODULO,V_PRODUCTO,V_ACTUACION,V_EVENTO,V_PARAM_ENTRADA);

    LV_SSQL := 'SELECT COD_RETORNO, DES_CADENA '
            || 'FROM GA_TRANSACABO '
            || 'WHERE NUM_TRANSACCION ='||V_SECUENCIA;

    SELECT COD_RETORNO, DES_CADENA
    INTO SN_COD_RETORNO, SV_MENS_RETORNO
    FROM GA_TRANSACABO
    WHERE NUM_TRANSACCION = V_SECUENCIA;

    IF SN_COD_RETORNO > 0 THEN
        RAISE ERROR_GENERAL;
    ELSE
        DELETE
        FROM GA_TRANSACABO
        WHERE NUM_TRANSACCION = V_SECUENCIA;
    END IF;

EXCEPTION
    WHEN ERROR_GENERAL THEN
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||TO_CHAR(V_SECUENCIA)||', '||V_MODULO||','||V_PRODUCTO||','||V_ACTUACION||','||V_EVENTO||','||V_PARAM_ENTRADA||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||TO_CHAR(V_SECUENCIA)||', '||V_MODULO||','||V_PRODUCTO||','||V_ACTUACION||','||V_EVENTO||','||V_PARAM_ENTRADA||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_EJECUTA_ESQ_RESTRICCION_PR;


PROCEDURE PV_EJECUTA_ABO_LIM_CONS_PR(
                                        EN_COD_CLIENTE     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                        EN_ABONO           IN NUMBER,
                                        EV_USUARIO         IN VARCHAR2,
                                        EV_MODULO          IN PV_IORSERV.COD_MODULO%TYPE,
                                        EN_NUMTAR          IN VARCHAR2,
                                        EV_COD_OOSS        IN VARCHAR2,
                                        EN_ABONADO         IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
)

    /*
    <DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
    <ELEMENTO NOMBRE = "PV_EJECUTA_ABO_LIM_CONS_PR"
    LENGUAJE="PL/SQL"
    FECHA="28-03-2011"
    VERSIÓN="1.0.1"
     DISEÑADOR="EVERIS"
    PROGRAMADOR="EVERIS"
    AMBIENTE="BD">
    <RETORNO>  </RETORNO>
    <DESCRIPCIÓN> EJECUTA EL INGRESO DEL ABONO LIMITE DE CONSUMO</DESCRIPCIÓN>
    <PARÁMETROS>
        <ENTRADA>
            <PARAM NOM="EN_COD_CLIENTE"  TIPO="NUMBER"> CODIGO DE CLIENTE </PARAM>
            <PARAM NOM="EN_ABONO"  TIPO="NUMBER"> CANTIDAD DE ABONO </PARAM>
            <PARAM NOM="EV_USUARIO"  TIPO="VARCHAR2"> USUARIO DE LA OPERACION </PARAM>
            <PARAM NOM="EV_MODULO"  TIPO="VARCHAR2"> MODULO GESTOR </PARAM>
            <PARAM NOM="EN_NUMTAR"  TIPO="NUMBER"> NUMERO TAREA </PARAM>
            <PARAM NOM="EV_COD_OOSS"  TIPO="VARCHAR2"> CODIGO DE ORDEN DE SERVICIO </PARAM>
            <PARAM NOM="EN_ABONADO"  TIPO="NUMBER"> NUMERO DE ABONADO </PARAM>
        </ENTRADA>
        <SALIDA>
            <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
            <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
            <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
        </SALIDA>
    </PARÁMETROS>
    </ELEMENTO>
    </DOCUMENTACIÓN>
    */

IS

    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC             STRING(30)   := 'PV_EJECUTA_ABO_LIM_CONS_PR';
    LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;

    LN_SECUENCIA               NUMBER;
    LV_INSTANCE_NAME           VARCHAR2(16);

BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;

    LV_SSQL:=' SELECT GA_SEQ_TRANSACABO.NEXTVAL FROM DUAL ';

    SELECT GA_SEQ_TRANSACABO.NEXTVAL
    INTO LN_SECUENCIA FROM DUAL;

    LV_SSQL:=' select INSTANCE_NAME from v$instance ';

    SELECT INSTANCE_NAME INTO LV_INSTANCE_NAME FROM V$INSTANCE;

    LV_SSQL:='PV_INS_MOV_ABOLIMCONS_PR('''||LN_SECUENCIA||''','''
                                          ||EN_COD_CLIENTE||''','''
                                          ||EN_ABONO||''','''
                                          ||EV_USUARIO||''','''
                                          ||LV_INSTANCE_NAME||''','''
                                          ||EV_MODULO||''','''
                                          ||EN_NUMTAR||''','''
                                          ||EV_COD_OOSS||''','''
                                          ||EN_ABONADO||''') ';

    PV_INS_MOV_ABOLIMCONS_PR(LN_SECUENCIA,
                             EN_COD_CLIENTE,
                             EN_ABONO,
                             EV_USUARIO,
                             LV_INSTANCE_NAME,
                             EV_MODULO,
                             EN_NUMTAR,
                             EV_COD_OOSS,
                             EN_ABONADO);


    LV_SSQL := 'SELECT COD_RETORNO, DES_CADENA '
            || 'FROM GA_TRANSACABO '
            || 'WHERE NUM_TRANSACCION ='||LN_SECUENCIA;

    SELECT COD_RETORNO, DES_CADENA
    INTO SN_COD_RETORNO, SV_MENS_RETORNO
    FROM GA_TRANSACABO
    WHERE NUM_TRANSACCION = LN_SECUENCIA;

    IF SN_COD_RETORNO > 0 THEN
        RAISE ERROR_GENERAL;
    ELSE
        DELETE
        FROM GA_TRANSACABO
        WHERE NUM_TRANSACCION = LN_SECUENCIA;
    END IF;

EXCEPTION
    WHEN ERROR_GENERAL THEN
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||TO_CHAR(LN_SECUENCIA)||', '||EN_COD_CLIENTE||','||EN_ABONO||','||EV_USUARIO||','||EV_MODULO||','||EN_NUMTAR||','||EV_COD_OOSS||','||EN_ABONADO||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||TO_CHAR(LN_SECUENCIA)||', '||EN_COD_CLIENTE||','||EN_ABONO||','||EV_USUARIO||','||EV_MODULO||','||EN_NUMTAR||','||EV_COD_OOSS||','||EN_ABONADO||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


END PV_EJECUTA_ABO_LIM_CONS_PR;

PROCEDURE PV_INSERT_CI_ORSERV_PR(
                                        EN_NUM_OS          IN CI_ORSERV.NUM_OS%TYPE,
                                        EV_COD_OS          IN CI_ORSERV.COD_OS%TYPE,
                                        EN_PRODUCTO        IN CI_ORSERV.PRODUCTO%TYPE,
                                        EN_COD_INTER       IN CI_ORSERV.COD_INTER%TYPE,
                                        EV_USUARIO         IN CI_ORSERV.USUARIO%TYPE,
                                        EV_COMENTARIO      IN CI_ORSERV.COMENTARIO%TYPE,
                                        EV_COD_MODULO      IN CI_ORSERV.COD_MODULO%TYPE,
                                        EN_ID_GESTOR       IN CI_ORSERV.ID_GESTOR%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
)

    /*
    <DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
    <ELEMENTO NOMBRE = "PV_INSERT_CI_ORSERV_PR"
    LENGUAJE="PL/SQL"
    FECHA="28-03-2011"
    VERSIÓN="1.0.1"
     DISEÑADOR="EVERIS"
    PROGRAMADOR="EVERIS"
    AMBIENTE="BD">
    <RETORNO>  </RETORNO>
    <DESCRIPCIÓN> EJECUTA EL INGRESO DE LA OOSS EN LA CI_ORSERV</DESCRIPCIÓN>
    <PARÁMETROS>
        <ENTRADA>
            <PARAM NOM="EN_NUM_OS"  TIPO="NUMBER"> IDENTIFICADOT DE LA OOSS </PARAM>
            <PARAM NOM="EV_COD_OS"  TIPO="NUMBER"> COD OOSS </PARAM>
            <PARAM NOM="EN_PRODUCTO"  TIPO="VARCHAR2"> PRODUCTO </PARAM>
            <PARAM NOM="EN_TIP_INTER"  TIPO="VARCHAR2"> TIP INTER </PARAM>
            <PARAM NOM="EN_COD_INTER"  TIPO="NUMBER"> COD INTER </PARAM>
            <PARAM NOM="EV_USUARIO"  TIPO="VARCHAR2"> USUARIO </PARAM>
            <PARAM NOM="EV_COMENTARIO"  TIPO="NUMBER"> COMENTARIO INGRESADO EN LA OOSS </PARAM>
            <PARAM NOM="EV_COD_MODULO"  TIPO="VARCHAR2"> CODIGO DE MODULO </PARAM>
            <PARAM NOM="EN_ID_GESTOR"  TIPO="NUMBER"> NUMERO DE LA TAREA </PARAM>
        </ENTRADA>
        <SALIDA>
            <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
            <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
            <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
        </SALIDA>
    </PARÁMETROS>
    </ELEMENTO>
    </DOCUMENTACIÓN>
    */

IS

    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC             STRING(30)   := 'PV_INSERT_CI_ORSERV_PR';
    LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;

    LV_GRUPO                   CI_TIPORSERV.GRUPO%TYPE;

BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;


    IF TRIM(EV_COD_OS) = '10668' THEN

            LV_SSQL:=' SELECT GRUPO FROM CI_TIPORSERV WHERE COD_OS = ' || EV_COD_OS;

            SELECT GRUPO
            INTO LV_GRUPO
            FROM CI_TIPORSERV
            WHERE COD_OS = EV_COD_OS;

            LV_SSQL:=' INSERT INTO CI_ORSERV(num_os, '
                                           || ' cod_os, '
                                           || ' producto, '
                                           || ' tip_inter, '
                                           || ' cod_inter, '
                                           || ' usuario, '
                                           || ' fecha, '
                                           || ' comentario, '
                                           || ' cod_modulo, '
                                           || ' id_gestor) '
                                 || ' VALUES('''||EN_NUM_OS||''','''
                                                ||EV_COD_OS||''','''
                                                ||EN_PRODUCTO||''','''
                                                ||LV_GRUPO||''','''
                                                ||EN_COD_INTER||''','''
                                                ||EV_USUARIO||''','''
                                                ||SYSDATE||''','''
                                                ||EV_COMENTARIO||''','''
                                                ||EV_COD_MODULO||''','''
                                                ||EN_ID_GESTOR||''')';


            INSERT INTO CI_ORSERV(NUM_OS,
                                  COD_OS,
                                  PRODUCTO,
                                  TIP_INTER,
                                  COD_INTER,
                                  USUARIO,
                                  FECHA,
                                  COMENTARIO,
                                  COD_MODULO,
                                  ID_GESTOR)
                           VALUES(EN_NUM_OS,
                                  EV_COD_OS,
                                  EN_PRODUCTO,
                                  LV_GRUPO,
                                  EN_COD_INTER,
                                  EV_USUARIO,
                                  SYSDATE,
                                  EV_COMENTARIO,
                                  EV_COD_MODULO,
                                  EN_ID_GESTOR);



    ELSIF TRIM(EV_COD_OS) = '10666' THEN

            LV_SSQL:=' SELECT GRUPO FROM CI_TIPORSERV WHERE COD_OS = ' || EV_COD_OS;

            SELECT GRUPO
            INTO LV_GRUPO
            FROM CI_TIPORSERV
            WHERE COD_OS = EV_COD_OS;

            LV_SSQL:=' INSERT INTO CI_ORSERV(num_os, '
                                           || ' cod_os, '
                                           || ' producto, '
                                           || ' tip_inter, '
                                           || ' cod_inter, '
                                           || ' usuario, '
                                           || ' fecha, '
                                           || ' comentario, '
                                 || ' VALUES('''||EN_NUM_OS||''','''
                                                ||EV_COD_OS||''','''
                                                ||EN_PRODUCTO||''','''
                                                ||LV_GRUPO||''','''
                                                ||EN_COD_INTER||''','''
                                                ||EV_USUARIO||''','''
                                                ||SYSDATE||''','''
                                                ||EV_COMENTARIO||''')';


            INSERT INTO CI_ORSERV(NUM_OS,
                                  COD_OS,
                                  PRODUCTO,
                                  TIP_INTER,
                                  COD_INTER,
                                  USUARIO,
                                  FECHA,
                                  COMENTARIO)
                           VALUES(EN_NUM_OS,
                                  EV_COD_OS,
                                  EN_PRODUCTO,
                                  LV_GRUPO,
                                  EN_COD_INTER,
                                  EV_USUARIO,
                                  SYSDATE,
                                  EV_COMENTARIO);

    END IF;


EXCEPTION

    WHEN OTHERS THEN
       SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||TO_CHAR(EN_NUM_OS)||', '||EV_COD_OS||','||EN_PRODUCTO||','||EN_COD_INTER||','||EV_USUARIO||','||EV_COMENTARIO||','||EV_COD_MODULO||','||EN_ID_GESTOR||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_INSERT_CI_ORSERV_PR;


PROCEDURE PV_REGISTRAR_ABO_LIM_CON_PR(
                                        EN_COD_CLIENTE     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                        EN_ABONADO         IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EN_ABONO           IN NUMBER,
                                        EV_USUARIO         IN VARCHAR2,
                                        EV_MODULO          IN PV_IORSERV.COD_MODULO%TYPE,
                                        EN_NUMTAR          IN VARCHAR2,
                                        EN_NUM_OS          IN CI_ORSERV.NUM_OS%TYPE,
                                        EV_COD_OOSS        IN VARCHAR2,
                                        EN_PRODUCTO        IN CI_ORSERV.PRODUCTO%TYPE,
                                        EN_COD_INTER       IN CI_ORSERV.COD_INTER%TYPE,
                                        EV_COMENTARIO      IN CI_ORSERV.COMENTARIO%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
)

    /*
    <DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
    <ELEMENTO NOMBRE = "PV_REGISTRAR_ABO_LIM_CON_PR"
    LENGUAJE="PL/SQL"
    FECHA="28-03-2011"
    VERSIÓN="1.0.1"
     DISEÑADOR="EVERIS"
    PROGRAMADOR="EVERIS"
    AMBIENTE="BD">
    <RETORNO>  </RETORNO>
    <DESCRIPCIÓN> EJECUTA EL INGRESO DE LA OOSS EN LA CI_ORSERV</DESCRIPCIÓN>
    <PARÁMETROS>
        <ENTRADA>
            <PARAM NOM="EN_COD_CLIENTE"  TIPO="NUMBER"> COD CLIENTE </PARAM>
            <PARAM NOM="EN_ABONADO"  TIPO="NUMBER"> NUM ABONADO </PARAM>
            <PARAM NOM="EN_ABONO"  TIPO="VARCHAR2"> CANTIDAD ABONO LIMITE CONSUMO </PARAM>
            <PARAM NOM="EV_USUARIO"  TIPO="VARCHAR2"> USUARIO DE LA OPERACION </PARAM>
            <PARAM NOM="EV_MODULO"  TIPO="VARCHAR2"> CODIGO DE MODULO </PARAM>
            <PARAM NOM="EN_NUMTAR"  TIPO="VARCHAR2">  NUMERO TAREA </PARAM>
            <PARAM NOM="EN_NUM_OS"  TIPO="NUMBER"> NUMERO DE ORDEN DE SERVICIO </PARAM>
            <PARAM NOM="EV_COD_OOSS"  TIPO="VARCHAR2"> CODIGO DE ORDEN DE SERVICIO </PARAM>
            <PARAM NOM="EN_PRODUCTO"  TIPO="NUMBER"> CODIGO PRODUCTO </PARAM>
            <PARAM NOM="EN_COD_INTER"  TIPO="NUMBER"> COD INTER </PARAM>
            <PARAM NOM="EV_COMENTARIO"  TIPO="VARCHAR2"> COMENTARIO DE INGRESO DE LA OOSS </PARAM>
        </ENTRADA>
        <SALIDA>
            <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
            <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
            <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
        </SALIDA>
    </PARÁMETROS>
    </ELEMENTO>
    </DOCUMENTACIÓN>
    */

IS

    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC             STRING(30)   := 'PV_REGISTRAR_ABO_LIM_CON_PR';
    LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;

    ERROR_EJECUCION            EXCEPTION;

BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;


    LV_SSQL:=' PV_EJECUTA_ABO_LIM_CONS_PR ( '
                                           ||EN_COD_CLIENTE||''','''
                                           ||EN_ABONO||''','''
                                           ||EV_USUARIO||''','''
                                           ||EV_MODULO||''','''
                                           ||EN_NUMTAR||''','''
                                           ||EV_COD_OOSS||''','''
                                           ||EN_ABONADO||''')';


    PV_EJECUTA_ABO_LIM_CONS_PR (
                                 EN_COD_CLIENTE,
                                 EN_ABONO,
                                 EV_USUARIO,
                                 EV_MODULO,
                                 EN_NUMTAR,
                                 EV_COD_OOSS,
                                 EN_ABONADO,
                                 SN_COD_RETORNO,
                                 SV_MENS_RETORNO,
                                 SN_NUM_EVENTO);


    IF SN_COD_RETORNO <> 0 THEN

        RAISE ERROR_EJECUCION;

    END IF;


    LV_SSQL:=' PV_INSERT_CI_ORSERV_PR ( '
                                       ||EN_NUM_OS||''','''
                                       ||EV_COD_OOSS||''','''
                                       ||EN_PRODUCTO||''','''
                                       ||EN_COD_INTER||''','''
                                       ||EV_USUARIO||''','''
                                       ||EV_COMENTARIO||''','''
                                       ||EV_MODULO||''','''
                                       ||EN_NUMTAR||''')';


    PV_INSERT_CI_ORSERV_PR (
                                 EN_NUM_OS,
                                 EV_COD_OOSS,
                                 EN_PRODUCTO,
                                 EN_COD_INTER,
                                 EV_USUARIO,
                                 EV_COMENTARIO,
                                 EV_MODULO,
                                 EN_NUMTAR,
                                 SN_COD_RETORNO,
                                 SV_MENS_RETORNO,
                                 SN_NUM_EVENTO);


    IF SN_COD_RETORNO <> 0 THEN

        RAISE ERROR_EJECUCION;

    END IF;

EXCEPTION

    WHEN ERROR_EJECUCION THEN
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||EN_COD_CLIENTE||', '||EN_ABONADO||','||EN_ABONO||','||EV_USUARIO||','||EV_MODULO||','||EN_NUMTAR||','||EN_NUM_OS||','||EV_COD_OOSS||','||EN_PRODUCTO||','||EN_COD_INTER||','||EV_COMENTARIO||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||EN_COD_CLIENTE||', '||EN_ABONADO||','||EN_ABONO||','||EV_USUARIO||','||EV_MODULO||','||EN_NUMTAR||','||EN_NUM_OS||','||EV_COD_OOSS||','||EN_PRODUCTO||','||EN_COD_INTER||','||EV_COMENTARIO||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );


END PV_REGISTRAR_ABO_LIM_CON_PR;


PROCEDURE PV_EJECUTA_MOD_LIM_CONS_PR(

                                                        EN_COD_CLIENTE          IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                                        EN_NUM_ABONADO             IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                                        EN_DET_MONTO               IN NUMBER,
                                                        EV_RESP_CONTINUAR          IN VARCHAR2,
                                                        EV_COD_PLANTARIF           IN GA_ABOCEL.COD_PLANTARIF%TYPE,
                                                        EV_COD_LIMCONS             IN TOL_LIMITE_TD.COD_LIMCONS%TYPE,
                                                        EV_USUARIO_BD            IN VARCHAR2,
                                                        EV_COMEN_VENDEDOR          IN CI_ORSERV.COMENTARIO%TYPE,
                                                        EN_NUM_OS               IN CI_ORSERV.NUM_OS%TYPE,
                                                        EV_COD_OS               IN CI_ORSERV.COD_OS%TYPE,
                                                        EN_COD_PRODUCTO         IN CI_ORSERV.PRODUCTO%TYPE,
                                                        EN_COD_INTER            IN CI_ORSERV.COD_INTER%TYPE,
                                                        SN_COD_RETORNO             OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                                        SV_MENS_RETORNO            OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                                        SN_NUM_EVENTO              OUT NOCOPY GE_ERRORES_PG.EVENTO

)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_EJECUTA_MODIFICACION_LIMITE_CONSUMO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="10-03-2011"
      Creado por="Felipe Diaz Lineros"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno> </Retorno>
      <Descripción>Modificacion Limite Consumo</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_COD_CLIENTE" Tipo="NUMBER"Codigo del cliente</param>
            <param nom="EN_NUM_ABONADO" Tipo="NUMBER"Numero del abonado</param>
            <param nom="EN_DET_MONTO" Tipo="NUMBER"Valor modificacion monto</param>
            <param nom="EV_RESP_CONTINUAR" Tipo="VARCHAR2"Respuesta si se continua o no con el cambio pendiente</param>
            <param nom="EV_COD_PLANTARIF" Tipo="NUMBER"Codigo plan tarifario</param>
            <param nom="EV_COD_LIMCONS" Tipo="VARCHAR2"Codigo plan tarifario</param>
            <param nom="EV_USUARIO_BD" Tipo="VARCHAR2"Usuario de Base de Datos</param>;
         </Entrada>
         <Salida>
            <param nom="SN_COD_RETORNO" Tipo="VARCHAR2"Código de Retorno (descripción de error) </param>
            <param nom="SV_MENS_RETORNO" Tipo="VARCHAR2"Mensaje de Retorno (código de error) </param>
            <param nom="SN_NUM_EVENTO" Tipo="NUMBER"Número de Evento </param>;
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_COD_SEGMENTO                  GE_CLIENTES.COD_SEGMENTO%TYPE;

LV_GSFORMATO_SEL2                GED_PARAMETROS.VAL_PARAMETRO%TYPE;

LN_MONTOMIN                      TOL_LIMITE_PLAN_TD.MTO_MIN%TYPE;
LN_MONTOMAX                     TOL_LIMITE_PLAN_TD.MTO_MAX%TYPE;

LN_SOLICITUDES_PENDIENTES        NUMBER;

LN_POSICION                        NUMBER;

LV_COLIMITE                        VARCHAR2(50);

LN_COD_CICLO                    GE_CLIENTES.COD_CICLO%TYPE;

LV_FEC_DESDELLAM                 VARCHAR2(15);

LV_TIP_PLANTARIF                GA_ABOCEL.TIP_PLANTARIF%TYPE;
LV_PLAN_TARIFARIO                GA_ABOCEL.COD_PLANTARIF%TYPE;

LV_COD_PLANTARIF                GA_ABOCEL.COD_PLANTARIF%TYPE;

LN_NEXTVAL_TRANSACABO             NUMBER;

LV_COD_COLOR                    GE_CLIENTES.COD_COLOR%TYPE;

LV_INSTANCE_NAME                VARCHAR2(16);

LV_COD_MODULO                   CI_ORSERV.COD_MODULO%TYPE;
LN_ID_GESTOR                    CI_ORSERV.ID_GESTOR%TYPE;


ERROR_MONTO                       EXCEPTION;
ERROR_PROCESO                     EXCEPTION;
ERROR_NO_DATOS_CICLO              EXCEPTION;
ERROR_SOLICITUDES_PENDIENTES     EXCEPTION;
ERROR_INSERT_LIMITE_CLIABO_TH     EXCEPTION;

pvCodValor                      VARCHAR2(50);
pvErrorAplic                     VARCHAR2(50);
pvErrorGlosa                     VARCHAR2(100);
pvErrorOra                       VARCHAR2(100);
pvErrorOraGlosa                  VARCHAR2(100);
pvTrace                          VARCHAR2(100);

pvCodSalida                      VARCHAR2(50);

EV_StrError       GA_TRANSACABO.DES_CADENA%TYPE;
EV_StrCodError    NUMBER;

LV_DES_ERROR                       GE_ERRORES_PG.DESEVENT;
LV_SSQL                            GE_ERRORES_PG.VQUERY;
LV_NOMBRE_PROC                     STRING(30)   := 'PV_EJECUTA_MOD_LIM_CONS_PR';
LV_PKG_PROC                        STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;



BEGIN
        SN_COD_RETORNO := 0;
        SV_MENS_RETORNO := 'OK';
        SN_NUM_EVENTO :=  0;

        BEGIN

                LV_SSQL :='SELECT COD_SEGMENTO INTO LV_COD_SEGMENTO FROM GE_CLIENTES WHERE COD_CLIENTE='||EN_COD_CLIENTE;

                SELECT COD_SEGMENTO
                INTO LV_COD_SEGMENTO
                FROM GE_CLIENTES
                WHERE COD_CLIENTE=EN_COD_CLIENTE;

        END;


        BEGIN

                SELECT VAL_PARAMETRO
                INTO LV_GSFORMATO_SEL2
                FROM GED_PARAMETROS
                WHERE COD_MODULO = 'GE'
                AND COD_PRODUCTO=1
                AND NOM_PARAMETRO ='FORMATO_SEL2';

        END;


        LV_SSQL :='SELECT INSTR(V_COD_LIMCONS, ''-'', 1, 1 ) '
        || ' INTO LN_POSICION FROM DUAL ';

        SELECT INSTR(EV_COD_LIMCONS, '-', 1, 1 )
        INTO LN_POSICION
        FROM DUAL;

        LV_SSQL :='SELECT SUBSTR( ' || EV_COD_LIMCONS || ', 1, LN_POSICION - 1) '
        || 'INTO LV_COLIMITE FROM DUAL ';

        
        --INI 208319 MAV
        IF LN_POSICION  <> 0 Then
            SELECT SUBSTR(EV_COD_LIMCONS, 1, LN_POSICION - 1)
            INTO LV_COLIMITE
            FROM DUAL;
        ELSE
            LV_COLIMITE := EV_COD_LIMCONS;
        END IF;
        --FIN 208319 MAV

        LV_SSQL := ' SELECT MTO_MIN,MTO_MAX
                        FROM TOL_LIMITE_PLAN_TD
                        WHERE
                            COD_LIMCONS= ' || LV_COLIMITE;
        LV_SSQL :=  LV_SSQL || ' AND COD_PLANTARIF= '||EV_COD_PLANTARIF;
        LV_SSQL :=  LV_SSQL || ' AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
                            AND ID_SUBSEGMENTO= ' || LV_COD_SEGMENTO;
        LV_SSQL :=  LV_SSQL || ' AND IND_PRIORIDAD >= TO_NUMBER (3)
                            AND ROWNUM=1';

        SELECT MTO_MIN,MTO_MAX
        INTO LN_MONTOMIN, LN_MONTOMAX
        FROM TOL_LIMITE_PLAN_TD
        WHERE
        COD_LIMCONS= LV_COLIMITE
        AND COD_PLANTARIF= EV_COD_PLANTARIF
        AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
        AND ID_SUBSEGMENTO= LV_COD_SEGMENTO
        AND IND_PRIORIDAD >= TO_NUMBER (3)
        AND ROWNUM=1;



        IF (EN_DET_MONTO < LN_MONTOMIN) OR (EN_DET_MONTO > LN_MONTOMAX) THEN
                RAISE ERROR_MONTO;
        END IF;

        BEGIN

                LV_SSQL :='SELECT COUNT(1) INTO LN_SOLICITUDES_PENDIENTES FROM  GA_FINCICLO '
                || 'WHERE COD_CLIENTE =' || EN_COD_CLIENTE || ' '
                || 'AND TRIM(COD_PLANTARIF) <> ''-1''';


                SELECT COUNT(1)
                INTO LN_SOLICITUDES_PENDIENTES
                FROM GA_FINCICLO
                WHERE COD_CLIENTE = EN_COD_CLIENTE
                AND TRIM(COD_PLANTARIF) <> '-1';

                IF LN_SOLICITUDES_PENDIENTES > 0 THEN
                    RAISE ERROR_SOLICITUDES_PENDIENTES;
                END IF;
        END;

        

        LV_SSQL :='SELECT COD_CICLO '
        || 'INTO LN_COD_CICLO '
        || 'FROM GE_CLIENTES '
        || 'WHERE  COD_CLIENTE = ' || EN_COD_CLIENTE;

        SELECT COD_CICLO
        INTO LN_COD_CICLO
        FROM GE_CLIENTES
        WHERE  COD_CLIENTE = EN_COD_CLIENTE;

        BEGIN

                LV_SSQL :='SELECT TO_CHAR(FEC_DESDELLAM,''DD-MM-YYYY'')'
                || 'INTO LV_FEC_DESDELLAM '
                || 'FROM FA_CICLFACT '
                || 'WHERE  COD_CICLO= ' || LN_COD_CICLO || ' '
                || ' AND SYSDATE <=FEC_DESDELLAM '
                || ' AND IND_FACTURACION =0 '
                || ' AND ROWNUM=1';


                SELECT TO_CHAR(FEC_DESDELLAM,'DD-MM-YYYY')
                INTO LV_FEC_DESDELLAM
                FROM FA_CICLFACT
                WHERE COD_CICLO=LN_COD_CICLO
                AND SYSDATE <=FEC_DESDELLAM
                AND IND_FACTURACION =0
                AND ROWNUM=1;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RAISE ERROR_NO_DATOS_CICLO;


        END;



        IF TRIM(LV_FEC_DESDELLAM) = '' Then
                RAISE ERROR_NO_DATOS_CICLO;
        END IF;

        BEGIN

                LV_SSQL :='SELECT TIP_PLANTARIF '
                || 'INTO LV_TIP_PLANTARIF '
                || 'FROM GA_ABOCEL '
                || 'WHERE NUM_ABONADO =' || EN_NUM_ABONADO
                || 'AND COD_CLIENTE =' || EN_COD_CLIENTE;

                SELECT TIP_PLANTARIF
                INTO LV_TIP_PLANTARIF
                FROM GA_ABOCEL
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND COD_CLIENTE = EN_COD_CLIENTE;

        END;


        IF LV_TIP_PLANTARIF = 'I' THEN
                LV_PLAN_TARIFARIO := 'II';

        ELSE
                LV_PLAN_TARIFARIO := 'EE';

        END IF;

        IF EN_NUM_ABONADO <> '0' THEN

                LV_SSQL :='SELECT COD_PLANTARIF '
                || 'INTO LV_COD_PLANTARIF '
                || 'FROM GA_ABOCEL '
                || 'WHERE NUM_ABONADO =' || EN_NUM_ABONADO
                || 'AND COD_CLIENTE =' || EN_COD_CLIENTE;

                SELECT COD_PLANTARIF
                INTO LV_COD_PLANTARIF
                FROM GA_ABOCEL
                WHERE NUM_ABONADO = EN_NUM_ABONADO
                AND COD_CLIENTE = EN_COD_CLIENTE;

        ELSE

                LV_SSQL :='SELECT C.COD_PLANTARIF '
                || 'INTO LV_COD_PLANTARIF '
                || 'FROM GA_EMPRESA A, GE_CLIENTES B, TA_PLANTARIF C '
                || 'WHERE B.COD_CLIENTE =' || EN_COD_CLIENTE || ' '
                || 'AND B.COD_CLIENTE = A.COD_CLIENTE '
                || 'AND A.COD_PLANTARIF = C.COD_PLANTARIF '
                || 'AND A.COD_PRODUCTO = C.COD_PRODUCTO '
                || 'AND A.COD_PRODUCTO = 1';

                SELECT C.COD_PLANTARIF
                INTO LV_COD_PLANTARIF
                FROM GA_EMPRESA A, GE_CLIENTES B, TA_PLANTARIF C
                WHERE B.COD_CLIENTE = EN_COD_CLIENTE
                AND B.COD_CLIENTE = A.COD_CLIENTE
                AND A.COD_PLANTARIF = C.COD_PLANTARIF
                AND A.COD_PRODUCTO = C.COD_PRODUCTO
                AND A.COD_PRODUCTO = 1;

        END IF;


        LV_SSQL :='SELECT COUNT(1) '
        || 'INTO LN_SOLICITUDES_PENDIENTES '
        || 'FROM GA_LIMITE_CLIABO_TO '
        || 'WHERE COD_CLIENTE =' || EN_COD_CLIENTE || ' '
        || 'AND NUM_ABONADO = ' || EN_NUM_ABONADO
        || 'AND FEC_DESDE > SYSDATE';

        SELECT COUNT(1)
        INTO LN_SOLICITUDES_PENDIENTES
        FROM GA_LIMITE_CLIABO_TO
        WHERE COD_CLIENTE = EN_COD_CLIENTE
        AND NUM_ABONADO = EN_NUM_ABONADO
        AND FEC_DESDE > SYSDATE;

        IF LN_SOLICITUDES_PENDIENTES > 0 AND EV_RESP_CONTINUAR = 'true' THEN

                LV_SSQL :='DELETE GA_FINCICLO '
                || 'WHERE COD_CLIENTE = ' || EN_COD_CLIENTE || ' '
                || 'AND COD_PLANTARIF = ''-1''';

                DELETE GA_FINCICLO
                WHERE COD_CLIENTE = EN_COD_CLIENTE
                AND COD_PLANTARIF = '-1';


                BEGIN

                        LV_SSQL :='INSERT INTO GA_LIMITE_CLIABO_TH (COD_CAUSA_HIST,FEC_HISTORICO, '
                        || 'COD_CLIENTE,NUM_ABONADO,COD_LIMCONS,FEC_DESDE,FEC_HASTA, '
                        || 'NOM_USUARORA,FEC_ASIGNACION,EST_APLICA_TOL,FEC_APLICA_TOL, '
                        || 'COD_PLANTARIF) '
                        || 'SELECT ''LCON'',sysdate,COD_CLIENTE, NUM_ABONADO,COD_LIMCONS, '
                        || 'FEC_DESDE,FEC_HASTA,NOM_USUARORA ,FEC_ASIGNACION,EST_APLICA_TOL, '
                        || 'FEC_APLICA_TOL,COD_PLANTARIF '
                        || 'FROM GA_LIMITE_CLIABO_TO '
                        || 'WHERE COD_CLIENTE =' || EN_COD_CLIENTE || ' '
                        || 'AND NUM_ABONADO =' || EN_NUM_ABONADO || ' '
                        || 'AND FEC_DESDE > sysdate ';

                        INSERT INTO GA_LIMITE_CLIABO_TH (COD_CAUSA_HIST,FEC_HISTORICO,
                        COD_CLIENTE,NUM_ABONADO,COD_LIMCONS,FEC_DESDE,FEC_HASTA,
                        NOM_USUARORA,FEC_ASIGNACION,EST_APLICA_TOL,FEC_APLICA_TOL,
                        COD_PLANTARIF)
                        SELECT 'LCON',sysdate,COD_CLIENTE, NUM_ABONADO,COD_LIMCONS,
                        FEC_DESDE,FEC_HASTA,NOM_USUARORA ,FEC_ASIGNACION,EST_APLICA_TOL,
                        FEC_APLICA_TOL,COD_PLANTARIF
                        FROM GA_LIMITE_CLIABO_TO
                        WHERE COD_CLIENTE = EN_COD_CLIENTE
                        AND NUM_ABONADO = EN_NUM_ABONADO
                        AND FEC_DESDE > sysdate;

                        EXCEPTION
                                WHEN OTHERS THEN
                                        RAISE ERROR_INSERT_LIMITE_CLIABO_TH;
                END;

                LV_SSQL :='DELETE GA_LIMITE_CLIABO_TO '
                || 'WHERE COD_CLIENTE = ' || EN_COD_CLIENTE || ' '
                || 'AND NUM_ABONADO = ' || EN_NUM_ABONADO  || ' '
                || 'AND FEC_DESDE > SYSDATE';

                DELETE GA_LIMITE_CLIABO_TO
                WHERE COD_CLIENTE = EN_COD_CLIENTE
                AND NUM_ABONADO = EN_NUM_ABONADO
                AND FEC_DESDE > SYSDATE;


                LV_SSQL :='UPDATE GA_LIMITE_CLIABO_TO SET fec_hasta = NULL '
                || 'WHERE COD_CLIENTE =' || EN_COD_CLIENTE || ' '
                || 'AND NUM_ABONADO =' || EN_NUM_ABONADO || ' '
                || 'AND FEC_DESDE = (SELECT MAX(FEC_DESDE) '
                || 'FROM ga_limite_cliabo_to '
                || 'WHERE COD_CLIENTE =' || EN_COD_CLIENTE || ' '
                || 'AND NUM_ABONADO =' || EN_NUM_ABONADO || ')';

                UPDATE GA_LIMITE_CLIABO_TO SET fec_hasta = NULL
                WHERE COD_CLIENTE = EN_COD_CLIENTE
                AND NUM_ABONADO = EN_NUM_ABONADO
                AND FEC_DESDE = (SELECT MAX(FEC_DESDE)
                FROM ga_limite_cliabo_to
                WHERE COD_CLIENTE = EN_COD_CLIENTE
                AND NUM_ABONADO = EN_NUM_ABONADO );

        END IF;

        LV_SSQL :='PV_LIMITE_CONSUMO_TRASPASO_PG.PV_MODIFICA_LCCICLO_PR('|| EN_NUM_ABONADO ||',''AL'','|| LV_COLIMITE ||',''3'','|| LV_FEC_DESDELLAM ||',''*'','|| LV_COD_PLANTARIF ||','|| LV_PLAN_TARIFARIO ||', '|| EN_DET_MONTO ||',pvCodValor, pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace)';

        PV_LIMITE_CONSUMO_TRASPASO_PG.PV_MODIFICA_LCCICLO_PR(EN_NUM_ABONADO,'AL',LV_COLIMITE,'3',LV_FEC_DESDELLAM,'*',LV_COD_PLANTARIF,LV_PLAN_TARIFARIO,EN_DET_MONTO,pvCodValor, pvErrorAplic,pvErrorGlosa,pvErrorOra,pvErrorOraGlosa,pvTrace);

        DBMS_OUTPUT.PUT_LINE ( 'pvErrorGlosa = ' || pvErrorGlosa );

        IF pvCodValor <> 'TRUE' THEN

                EV_STRERROR := 'Error: Problemas con V_PAR_SALIDA.';
                EV_STRCODERROR := 1;
                RAISE ERROR_PROCESO;
        ELSE
                IF LV_PLAN_TARIFARIO = 'EE' THEN

                        LV_SSQL :='SELECT GA_SEQ_TRANSACABO.NEXTVAL'
                        || 'INTO LN_NEXTVAL_TRANSACABO'
                        || 'FROM DUAL;';

                        SELECT GA_SEQ_TRANSACABO.NEXTVAL
                        INTO LN_NEXTVAL_TRANSACABO
                        FROM DUAL;

                        LV_SSQL := 'SELECT COD_COLOR'
                        || 'INT LV_COD_COLOR'
                        || 'FROM GE_CLIENTES'
                        || 'WHERE COD_CLIENTE =' || EN_COD_CLIENTE;

                        SELECT COD_COLOR
                        INTO LV_COD_COLOR
                        FROM GE_CLIENTES
                        WHERE COD_CLIENTE = EN_COD_CLIENTE;

                        LV_SSQL:=' SELECT INSTANCE_NAME FROM v$instance ';

                        SELECT INSTANCE_NAME
                        INTO LV_INSTANCE_NAME
                        FROM v$instance;

                        LV_SSQL :=' PV_LIMITE_CONSUMO_TRASPASO_PG.PV_MODIFICA_LCCICLO_PR('|| LN_NEXTVAL_TRANSACABO ||','|| EN_COD_CLIENTE ||','|| LV_COD_COLOR ||','|| EV_USUARIO_BD ||','|| LV_INSTANCE_NAME ||',GA,8542,10666,'|| LN_COD_CICLO ||','|| LV_COLIMITE ||',pvCodValor' ;

                        PV_INS_MOV_LIMCONS_PR(LN_NEXTVAL_TRANSACABO,EN_COD_CLIENTE,LV_COD_COLOR,EV_USUARIO_BD,LV_INSTANCE_NAME,'GA','8542','10666',LN_COD_CICLO,LV_COLIMITE);

                        IF pvCodValor <> '0' THEN

                                EV_STRERROR := 'Error: Problemas con V_PAR_SALIDA.';
                                EV_STRCODERROR := 1;
                                RAISE ERROR_PROCESO;
                        END IF;
                END IF;

        END IF;


        IF pvErrorAplic = 'FALSE' OR pvErrorAplic = '' THEN

            EV_STRERROR := 'Error: Problemas con V_PAR_SALIDA.';
            EV_STRCODERROR := 1;
            RAISE ERROR_PROCESO;
        END IF;

        LV_COD_MODULO := NULL;
        LN_ID_GESTOR  := NULL;

        LV_SSQL:=' PV_INSERT_CI_ORSERV_PR ( '
                                       ||EN_NUM_OS||''','''
                                       ||EV_COD_OS||''','''
                                       ||EN_COD_PRODUCTO||''','''
                                       ||EN_COD_INTER||''','''
                                       ||EV_USUARIO_BD||''','''
                                       ||EV_COMEN_VENDEDOR||''','''
                                       ||LV_COD_MODULO||''','''
                                       ||LN_ID_GESTOR||''')';

        PV_INSERT_CI_ORSERV_PR (
                                 EN_NUM_OS,
                                 EV_COD_OS,
                                 EN_COD_PRODUCTO,
                                 EN_COD_INTER,
                                 EV_USUARIO_BD,
                                 EV_COMEN_VENDEDOR,
                                 LV_COD_MODULO,
                                 LN_ID_GESTOR,
                                 SN_COD_RETORNO,
                                 SV_MENS_RETORNO,
                                 SN_NUM_EVENTO);


    IF SN_COD_RETORNO <> 0 THEN

        RAISE ERROR_PROCESO;

    END IF;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                SN_COD_RETORNO := 1;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
                END IF;
                LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
                SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
                LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

        WHEN ERROR_MONTO THEN
                SN_COD_RETORNO := 100016;-- El monto ingresado esta fuera del rango mínimo y máximo
                IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
                END IF;
                LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
                SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
                LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

        WHEN ERROR_SOLICITUDES_PENDIENTES THEN
                SN_COD_RETORNO := 100015;-- Error al buscar Solicitudes Pendientes a Ciclo
                IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
                END IF;
                LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
                SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
                LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

        WHEN ERROR_NO_DATOS_CICLO THEN
                SN_COD_RETORNO := 100017;-- No existe Ciclo de Facturación Vigente
                IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
                END IF;
                LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
                SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
                LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

        WHEN ERROR_INSERT_LIMITE_CLIABO_TH THEN
                SN_COD_RETORNO := 100018;-- Error al insertar registro  en tabla GA_LIMITE_CLIABO_TH
                IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
                END IF;
                LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
                SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
                LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

        WHEN ERROR_PROCESO THEN
                SN_COD_RETORNO := 100019;-- Error al ejecutar proceso de Modificacion de LC
                IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
                END IF;
                LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
                SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO || EN_DET_MONTO,1,GN_LARGODESC);
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
                LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

        WHEN OTHERS THEN
                SN_COD_RETORNO := 1; --
                IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                        SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
                END IF;
                LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
                SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
                SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
                LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_EJECUTA_MOD_LIM_CONS_PR;


PROCEDURE PV_GET_OPERADORA_CLI_PR(
                                        EN_COD_CLIENTE      IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                        SV_COD_OPERADORA    OUT GE_CLIENTES.COD_OPERADORA%TYPE,
                                        SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO)
IS



/*
  <DOCUMENTACIÓN
    TIPODOC = "PROCEDURE">
     <ELEMENTO
        NOMBRE = "PV_GET_OPERADORA_CLI_PR"
        LENGUAJE="PL/SQL"
        FECHA="08-04-2011"
        VERSIÓN="1.0"
        DISEÑADOR="EVERIS"
        PROGRAMADOR="EVERIS"
        AMBIENTE DESARROLLO="BD">
        <RETORNO></RETORNO>
        <DESCRIPCIÓN>EJECUTA EL PROCEDIMIENTO ALMACENADO P_GA_ESTADO_VENDEDOR PARA OBTENER EL ESTADO DEL VENDEDOR</DESCRIPCIÓN>
        <PARÁMETROS>
           <ENTRADA>
              <PARAM NOM="EN_COD_CLIENTE" TIPO="NUMBER"> CODIGO DE CLIENTE</PARAM>
           </ENTRADA>
           <RETORNO>
              <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
              <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
              <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
            </RETORNO>
        </PARÁMETROS>
     </ELEMENTO>
  </DOCUMENTACIÓN>
*/


LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
LV_SSQL                    GE_ERRORES_PG.VQUERY;
LV_NOMBRE_PROC             STRING(30)   := 'PV_GET_OPERADORA_CLI_PR';
LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
LN_NUM_TRANSACC            GA_TRANSACABO.NUM_TRANSACCION%TYPE;




BEGIN
    SN_COD_RETORNO := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO := 0;

    LV_SSQL := 'SELECT A.COD_OPERADORA FROM GE_CLIENTES A '
            || 'WHERE A.COD_CLIENTE = '||EN_COD_CLIENTE;


    SELECT A.COD_OPERADORA INTO SV_COD_OPERADORA
    FROM GE_CLIENTES A
    WHERE A.COD_CLIENTE = EN_COD_CLIENTE;

EXCEPTION

    WHEN OTHERS THEN
       SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC ||'('||EN_COD_CLIENTE||'); '||SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_GET_OPERADORA_CLI_PR;

PROCEDURE PV_CNSLTA_P_GA_INTERAL_PR( EV_NUM_TRASACC  IN VARCHAR2,
                                     EV_TIPMOV       IN VARCHAR2,
                                     EV_TIPSTOCK     IN VARCHAR2,
                                     EV_CODBODEGA       IN VARCHAR2,
                                     EV_CODARTICULO  IN VARCHAR2,
                                     EV_CODUSO       IN VARCHAR2,
                                     EV_CODESTADO    IN VARCHAR2,
                                     EV_NUMVENTA     IN VARCHAR2,
                                     EV_ICANTIDAD    IN VARCHAR2,
                                     EV_NUMSERIE     IN VARCHAR2,
                                     EV_IINDTELEF    IN VARCHAR2,
                                     SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                     SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                     SN_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.EVENTO ) IS
/*
<DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
<ELEMENTO NOMBRE = "PV_CNSLTA_P_GA_INTERAL_PR"
LENGUAJE="PL/SQL"
FECHA="10-10-2008"
VERSIÓN="1.0.0"
DISEÑADOR="PATRICIO GALLEGOS"
PROGRAMADOR="PATRICIO GALLEGOS"
AMBIENTE="BD">
<RETORNO>  </RETORNO>
<DESCRIPCIÓN> LLAMAMOS AL P_GA_INTERAL ( ACTUAIZAMOS STOCK ) </DESCRIPCIÓN>
<PARÁMETROS>
    <ENTRADA>
        <PARAM NOM="EV_NUMTRANSAC"  TIPO="VARCHAR"> NUMERO DE TRANSACCION</PARAM>
        <PARAM NOM="EV_TIPMOV"  TIPO="VARCHAR"> TIPO DE MOVIMIENTO </PARAM>
        <PARAM NOM="EV_TIPSTOCK"  TIPO="VARCHAR"> TIPO DE STOCK</PARAM>
        <PARAM NOM="EV_CODBODEGA"  TIPO="VARCHAR"> CÓDIGO DE LA BODEGA </PARAM>
        <PARAM NOM="EV_CODARTICULO"  TIPO="VARCHAR"> CÓDIGO DEL ARTICULO</PARAM>
        <PARAM NOM="EV_CODUSO"  TIPO="VARCHAR"> CÓDIGO DE USOI</PARAM>
        <PARAM NOM="EV_CODESTADO"  TIPO="VARCHAR"> CÓDIGO DE ESTADO </PARAM>
        <PARAM NOM="EV_NUMVENTA"  TIPO="VARCHAR"> NUMERO DE VENTA </PARAM>
        <PARAM NOM="EV_ICANTIDAD"  TIPO="VARCHAR"> CANTIDAD</PARAM>
        <PARAM NOM="EV_NUMSERIE"  TIPO="VARCHAR"> NUMERO DE SERIE</PARAM>
        <PARAM NOM="EV_IINDTELEF"  TIPO="VARCHAR"> INDICADOR DE TELEFONO </PARAM>
        <PARAM NOM="EV_PRMTIPDEV"  TIPO="VARCHAR"> PERMISO TIPO DE DEVOLUCION</PARAM>
    </ENTRADA>
    <SALIDA>
        <PARAM NOM="SV_DES_VALOR  TIPO="VARCHAR"> DESCRIPCIÓN VALOR. </PARAM>
        <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
        <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
        <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
    </SALIDA>
</PARÁMETROS>
</ELEMENTO>
</DOCUMENTACIÓN>
*/

    LV_DES_ERROR                GE_ERRORES_PG.DESEVENT;
    LV_SSQL                     GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC              STRING(30)   := 'PV_CNSLTA_P_GA_INTERAL_PR';
    LV_PKG_PROC                 STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;

BEGIN

    SN_COD_RETORNO := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO := 0;

    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ''. ''';


    LV_SSQL := 'P_GA_INTERAL('''||EV_NUM_TRASACC||''','''||EV_TIPMOV||''','''||EV_TIPSTOCK||''','''||EV_CODBODEGA||''','''||EV_CODARTICULO||''','''||EV_CODUSO||''','''||EV_CODESTADO||''','''||EV_NUMVENTA||''','''||EV_ICANTIDAD||''','''||EV_NUMSERIE||''','''||EV_IINDTELEF||''')';
    P_GA_INTERAL (EV_NUM_TRASACC,EV_TIPMOV, EV_TIPSTOCK, EV_CODBODEGA,EV_CODARTICULO, EV_CODUSO, EV_CODESTADO,EV_NUMVENTA,EV_ICANTIDAD, EV_NUMSERIE, EV_IINDTELEF);


    SV_MENS_RETORNO := LV_SSQL;
    LV_SSQL := 'SELECT cod_retorno, des_cadena '
            || 'FROM ga_transacabo '
            || 'WHERE num_transaccion  = ' || EV_NUM_TRASACC;

    SELECT COD_RETORNO, REPLACE(DES_CADENA,'/',' ')
    INTO  SN_COD_RETORNO, SV_MENS_RETORNO
    FROM GA_TRANSACABO
    WHERE NUM_TRANSACCION = EV_NUM_TRASACC;


    IF SN_COD_RETORNO = 0 AND TRIM(SV_MENS_RETORNO) IS NULL THEN
        RAISE ERROR_GENERAL;
    END IF;


EXCEPTION
    WHEN ERROR_GENERAL THEN
         SN_COD_RETORNO := 2;
         SV_MENS_RETORNO := 'Error recuperando n° de movimiento de p_ga_interal.';
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
END PV_CNSLTA_P_GA_INTERAL_PR;

PROCEDURE PV_INTRFZ_ABONADOS_PR(EV_ACTABO                   IN VARCHAR2,
                                EV_PRODUCTO                 IN VARCHAR2,
                                EV_ABONADO                  IN VARCHAR2,
                                EV_ORIGEN                   IN VARCHAR2,
                                EV_DESTINO                  IN VARCHAR2,
                                EV_VAR3                     IN VARCHAR2,
                                EV_VAR4                     IN VARCHAR2,
                                EV_VAR5                     IN VARCHAR2,
                                EV_VAR6                     IN VARCHAR2,
                                SN_NUM_TRANSACCION          OUT NUMBER,
                                SN_COD_RETORNO              OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO             OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO               OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS --PRAGMA AUTONOMOUS_TRANSACTION;


    LV_NOMBRE_PROC              STRING(30)   := 'PV_INTRFZ_ABONADOS_PR';
    LV_PKG_PROC                 STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;

    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LN_NUM_TRANSACCION         GA_TRANSACABO.NUM_TRANSACCION%TYPE;
    LN_COD_RETORNO             GA_TRANSACABO.COD_RETORNO%TYPE;
    LV_DES_CADENA              GA_TRANSACABO.DES_CADENA%TYPE;
    LV_NOM_PROCESO             GA_ERRORES.NOM_PROC%TYPE;
    LV_NOMBRE_TABLA            GA_ERRORES.NOM_TABLA%TYPE;
    LV_CODE                    GA_ERRORES.COD_SQLCODE%TYPE;
    LN_EXISTE_VENTA            NUMBER;

BEGIN
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;

    LV_SSQL := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL FROM DUAL';

    SELECT GA_SEQ_TRANSACABO.NEXTVAL
    INTO SN_NUM_TRANSACCION FROM DUAL;

    IF SN_NUM_TRANSACCION IS NOT NULL THEN
         LV_SSQL := 'P_INTERFASES_ABONADOS('''|| SN_NUM_TRANSACCION ||''','''|| EV_ACTABO ||''','''|| EV_PRODUCTO ||''','''|| EV_ABONADO ||''','''|| EV_ORIGEN ||''','''|| EV_DESTINO ||''','''|| EV_VAR3 ||''','''|| EV_VAR4 ||''','''|| EV_VAR5 ||''','''|| EV_VAR6 ||''');';
         P_INTERFASES_ABONADOS(SN_NUM_TRANSACCION,EV_ACTABO,EV_PRODUCTO,EV_ABONADO,EV_ORIGEN,EV_DESTINO,EV_VAR3,EV_VAR4,EV_VAR5,EV_VAR6);

        BEGIN

            SELECT A.COD_RETORNO, A.DES_CADENA
            INTO LN_COD_RETORNO, LV_DES_CADENA
            FROM GA_TRANSACABO A
            WHERE NUM_TRANSACCION = SN_NUM_TRANSACCION;

            LV_SSQL := 'SELECT TRIM(G.NOM_PROC), TRIM(G.NOM_TABLA) '
                    || 'FROM GA_ERRORES G '
                    || 'WHERE G.CODIGO = '''||EV_ABONADO||''''
                    || 'AND ((SYSDATE-G.FEC_ERROR)*24*60*60) <= 60 '
                    || 'AND G.COD_SQLCODE NOT IN (''0'',''0000'',''OK'') '
                    || 'AND ROWNUM = 1 ';

            SELECT TRIM(G.NOM_PROC), TRIM(G.NOM_TABLA), TRIM(G.COD_SQLCODE)
            INTO LV_NOM_PROCESO, LV_NOMBRE_TABLA, LV_CODE
            FROM GA_ERRORES G
            WHERE G.CODIGO = EV_ABONADO
            AND ((SYSDATE-G.FEC_ERROR)*24*60*60) <= 60 -- <= 60 (EN SEGUNDOS)
            AND G.COD_SQLCODE NOT IN ('0','0000','OK')
            AND ROWNUM = 1;

            IF LN_COD_RETORNO = 4 OR LV_NOM_PROCESO IS NOT NULL THEN
                RAISE ERROR_GENERAL ;
            END IF;

            SV_MENS_RETORNO := SV_MENS_RETORNO||'|'||LV_NOM_PROCESO||'|'||LV_NOMBRE_TABLA||'|'||LV_DES_CADENA||'|'||LN_COD_RETORNO;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                LN_COD_RETORNO := 0;
                LV_DES_CADENA := 'NO SE ENCONTRO ERROR';
                SV_MENS_RETORNO := SV_MENS_RETORNO||LV_DES_CADENA;
        END;

    END IF;

    IF SN_COD_RETORNO = 4 THEN
        RAISE ERROR_GENERAL ;
    END IF;

    SV_MENS_RETORNO := SV_MENS_RETORNO||' | '||LV_SSQL;

EXCEPTION
    WHEN ERROR_GENERAL THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
            SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
            SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
END PV_INTRFZ_ABONADOS_PR;

PROCEDURE PV_CONSULTA_FOLIO_PR( EV_COD_CATTRIBUT    IN GE_CATRIBDOCUM.COD_CATRIBUT%TYPE,
                                EN_COD_VENDEDOR     IN NUMBER,
                                EV_COD_OFICINA      IN VARCHAR2,
                                EV_PREFIJO_FOLIO    IN VARCHAR2,
                                EN_CORRELATIVO      IN NUMBER,
                                EN_RANGO_INICIAL    IN NUMBER,
                                EN_OPCION           IN NUMBER,
                                SV_RESULTADO        OUT VARCHAR2,
                                SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.EVENTO
) IS
/*
<DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
<ELEMENTO NOMBRE = "PV_CONSULTA_FOLIO_PR"
LENGUAJE="PL/SQL"
FECHA="10-10-2008"
VERSIÓN="1.0.0"
DISEÑADOR="EVERIS"
PROGRAMADOR="EVERIS"
AMBIENTE="BD">
<RETORNO>  </RETORNO>
<DESCRIPCIÓN> CONSULTA FOLIO </DESCRIPCIÓN>
<PARÁMETROS>
    <ENTRADA>
    </ENTRADA>
    <SALIDA>
        <PARAM NOM="SV_FOLIO" TIPO="VARCHAR"> DETALLE DEL FOLIO </PARAM>
        <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
        <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
        <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
    </SALIDA>
</PARÁMETROS>
</ELEMENTO>
</DOCUMENTACIÓN>
*/

    LV_DES_ERROR                GE_ERRORES_PG.DESEVENT;
    LV_SSQL                     GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC              STRING(30)   := 'PV_CONSULTA_FOLIO_PR';
    LV_PKG_PROC                 STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
    LN_COD_TIPDOCUM             GE_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
    LV_COD_OPERADORA            GE_PARAMETROS_SISTEMA_VW.VALOR_TEXTO%TYPE;
BEGIN

    SN_COD_RETORNO := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO := 0;

    SELECT B.COD_TIPDOCUM INTO LN_COD_TIPDOCUM
    FROM GE_CATRIBDOCUM A, GE_TIPDOCUMEN B
    WHERE A.COD_TIPDOCUM = B.COD_TIPDOCUM
    AND A.COD_CATRIBUT = EV_COD_CATTRIBUT;

     SELECT  VALOR_TEXTO INTO LV_COD_OPERADORA
    FROM GE_PARAMETROS_SISTEMA_VW
    WHERE  NOM_PARAMETRO = 'COD_OPERADORA_LOCAL'
    AND    COD_MODULO    = 'GE';


    LV_SSQL := 'SELECT FA_FOLIACION_PG.FA_CONSULTA_FOLIO_FN('||LN_COD_TIPDOCUM;
    IF EN_COD_VENDEDOR = '' OR EN_COD_VENDEDOR IS NULL THEN
        LV_SSQL := LV_SSQL || ',NULL';
    ELSE
        LV_SSQL := LV_SSQL || ','||EN_COD_VENDEDOR;
    END IF;
    IF EV_COD_OFICINA = '' OR EV_COD_OFICINA IS NULL THEN
        LV_SSQL := LV_SSQL || ',NULL';
    ELSE
        LV_SSQL := LV_SSQL || ','''||EV_COD_OFICINA||'''';
    END IF;
    IF LV_COD_OPERADORA = '' OR LV_COD_OPERADORA IS NULL THEN
        LV_SSQL := LV_SSQL || ',NULL';
    ELSE
        LV_SSQL := LV_SSQL || ','''||LV_COD_OPERADORA||'''';
    END IF;
    IF EV_PREFIJO_FOLIO = '' OR EV_PREFIJO_FOLIO IS NULL THEN
        LV_SSQL := LV_SSQL || ',NULL';
    ELSE
        LV_SSQL := LV_SSQL || ','''||EV_PREFIJO_FOLIO||'''';
    END IF;
    IF EN_CORRELATIVO = 0 OR EN_CORRELATIVO IS NULL THEN
        LV_SSQL := LV_SSQL || ',NULL';
    ELSE
        LV_SSQL := LV_SSQL || ','||EN_CORRELATIVO;
    END IF;
    IF EN_RANGO_INICIAL = '' OR EN_RANGO_INICIAL IS NULL THEN
        LV_SSQL := LV_SSQL || ',NULL';
    ELSE
        LV_SSQL := LV_SSQL || ','||EN_RANGO_INICIAL;
    END IF;
    LV_SSQL := LV_SSQL ||','||EN_OPCION||') FROM DUAL';

    EXECUTE IMMEDIATE LV_SSQL INTO SV_RESULTADO;



EXCEPTION
    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
END PV_CONSULTA_FOLIO_PR;



PROCEDURE PV_DES_RESERVART_PR(EN_NUMTRANSACCION       IN GA_RESERVART.NUM_TRANSACCION%TYPE,
 		  										      SN_COD_RETORNO     	   OUT NOCOPY GE_ERRORES_PG.CODERROR,
	                 				  				  SV_MENS_RETORNO  	   OUT NOCOPY GE_ERRORES_PG.MSGERROR,
	                 								  SN_NUM_EVENTO    	   OUT NOCOPY GE_ERRORES_PG.EVENTO ) IS
/*
<DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
<ELEMENTO NOMBRE = "PV_DES_RESERVART_PR"
LENGUAJE="PL/SQL"
FECHA="10-10-2008"
VERSIÓN="1.0.0"
DISEÑADOR="PATRICIO GALLEGOS"
PROGRAMADOR="PATRICIO GALLEGOS"
AMBIENTE="BD">
<RETORNO>  </RETORNO>
<DESCRIPCIÓN>SE REALIZA LA DESRESERVA DEL ARTICULO</DESCRIPCIÓN>
<PARÁMETROS>
	<ENTRADA>
		<PARAM NOM="EN_NUMTRANSACCION"  TIPO="VARCHAR">NUMERO DE TRANSACCION </PARAM>
	</ENTRADA>
	<SALIDA>
		<PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
		<PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
		<PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
	</SALIDA>
</PARÁMETROS>
</ELEMENTO>
</DOCUMENTACIÓN>
*/

LV_DES_ERROR         	    GE_ERRORES_PG.DESEVENT;
LV_SSQL                 	GE_ERRORES_PG.VQUERY;
LV_NOMBRE_PROC              STRING(30)   := 'PV_DES_RESERVART_PR';
LV_PKG_PROC                 STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;

BEGIN


	SN_COD_RETORNO := 0;
	SV_MENS_RETORNO := 'OK';
	SN_NUM_EVENTO := 0;

        LV_SSQL := ' DELETE GA_RESERVART'
             || ' WHERE NUM_TRANSACCION ='|| EN_NUMTRANSACCION;

        DELETE GA_RESERVART
        WHERE NUM_TRANSACCION = EN_NUMTRANSACCION;

        LV_SSQL := 'DELETE GA_RESNUMCEL '
             || 'WHERE NUM_TRANSACCION = '||EN_NUMTRANSACCION;

        DELETE GA_RESNUMCEL
        WHERE NUM_TRANSACCION = EN_NUMTRANSACCION;


EXCEPTION
    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
END PV_DES_RESERVART_PR;

PROCEDURE PV_ROLLBACK_RESERV_PR (EN_NUMTRANSACCION       IN GA_RESERVART.NUM_TRANSACCION%TYPE,
                                                         SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                                         SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                                       SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO ) IS
/*
<DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
<ELEMENTO NOMBRE = "PV_DES_RESERVART_PR"
LENGUAJE="PL/SQL"
FECHA="10-10-2008"
VERSIÓN="1.0.0"
DISEÑADOR="PATRICIO GALLEGOS"
PROGRAMADOR="PATRICIO GALLEGOS"
AMBIENTE="BD">
<RETORNO>  </RETORNO>
<DESCRIPCIÓN>SE REALIZA LA DESRESERVA DEL ARTICULO</DESCRIPCIÓN>
<PARÁMETROS>
    <ENTRADA>
        <PARAM NOM="EN_NUMTRANSACCION"  TIPO="VARCHAR">NUMERO DE TRANSACCION </PARAM>
    </ENTRADA>
    <SALIDA>
        <PARAM NOM="SN_COD_RETORNO"    TIPO="NUMBER"> CODIGO RETORNO </PARAM>
        <PARAM NOM="SV_MENS_RETORNO"   TIPO="STRING"> GLOSA MENSAJE ERROR </PARAM>
        <PARAM NOM="SN_NUM_EVENTO"     TIPO="NUMBER"> NUMERO DE EVENTO </PARAM>
    </SALIDA>
</PARÁMETROS>
</ELEMENTO>
</DOCUMENTACIÓN>
*/

LV_DES_ERROR                 GE_ERRORES_PG.DESEVENT;
LV_SSQL                     GE_ERRORES_PG.VQUERY;
LV_NOMBRE_PROC              STRING(30)   := 'PV_DES_RESERVART_PR';
LV_PKG_PROC                 STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
LV_TIPMOV                   VARCHAR2(20);
LV_TIPSTOCK                 GA_RESERVART.TIP_STOCK%TYPE;
LV_CODBODEGA                  GA_RESERVART.COD_BODEGA%TYPE;
LV_CODARTICULO              GA_RESERVART.COD_ARTICULO%TYPE;
LV_CODUSO                   GA_RESERVART.COD_USO%TYPE;
LV_CODESTADO                GA_RESERVART.COD_ESTADO%TYPE;
LV_NUMVENTA                 GA_RESERVART.NUM_VENTA%TYPE;
LV_ICANTIDAD                GA_RESERVART.NUM_UNIDADES%TYPE;
LV_NUMSERIE                 GA_RESERVART.NUM_SERIE%TYPE;
LV_IINDTELEF                VARCHAR2(2);
LN_SECUENCIA                NUMBER(10);
SIN_NUMMOVIMIENTO            EXCEPTION;
BEGIN


    SN_COD_RETORNO := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO := 0;

    LV_TIPMOV := '5';
    LV_NUMVENTA := NULL;
    LV_IINDTELEF := '0';

    LV_SSQL := ' SELECT A.TIP_STOCK, A.COD_BODEGA, A.COD_ARTICULO, A.COD_USO, A.COD_ESTADO, A.NUM_UNIDADES, A.NUM_SERIE '
         || ' FROM GA_RESERVART A '
         || ' WHERE NUM_TRANSACCION = '|| EN_NUMTRANSACCION;

        SELECT A.TIP_STOCK, A.COD_BODEGA, A.COD_ARTICULO, A.COD_USO, A.COD_ESTADO, A.NUM_UNIDADES, A.NUM_SERIE
        INTO LV_TIPSTOCK, LV_CODBODEGA, LV_CODARTICULO, LV_CODUSO, LV_CODESTADO, LV_ICANTIDAD, LV_NUMSERIE
        FROM GA_RESERVART A
        WHERE NUM_TRANSACCION = EN_NUMTRANSACCION;

        LV_SSQL := ' DELETE GA_RESERVART'
             || ' WHERE NUM_TRANSACCION ='|| EN_NUMTRANSACCION;

        DELETE GA_RESERVART
        WHERE NUM_TRANSACCION = EN_NUMTRANSACCION;

        LV_SSQL := 'DELETE GA_RESNUMCEL '
             || 'WHERE NUM_TRANSACCION = '||EN_NUMTRANSACCION;

        DELETE GA_RESNUMCEL
        WHERE NUM_TRANSACCION = EN_NUMTRANSACCION;

        LV_SSQL := 'SELECT GA_SEQ_TRANSACABO.NEXTVAL FROM DUAL';
        EXECUTE IMMEDIATE LV_SSQL
        INTO LN_SECUENCIA;

        LV_SSQL := 'P_Ga_Interal ('''||LN_SECUENCIA||''','''||LV_TIPSTOCK||''','''||LV_CODBODEGA||''','''||LV_CODARTICULO
             || ''','''||LV_CODUSO||''','''||LV_CODESTADO||''','''|| LV_NUMVENTA ||''','''||LV_ICANTIDAD
             || ''','''||LV_NUMSERIE||''','''||LV_IINDTELEF||''')';

        P_GA_INTERAL(LN_SECUENCIA, LV_TIPMOV, LV_TIPSTOCK,
                    LV_CODBODEGA, LV_CODARTICULO, LV_CODUSO,
                    LV_CODESTADO, LV_NUMVENTA, LV_ICANTIDAD,
                    LV_NUMSERIE, LV_IINDTELEF);

        LV_SSQL := 'SELECT cod_retorno, des_cadena '
                || ' FROM ga_transacabo '
                || ' WHERE num_transaccion  = ' || LN_SECUENCIA;

        SELECT COD_RETORNO, REPLACE(DES_CADENA,'/','')
        INTO  SN_COD_RETORNO, SV_MENS_RETORNO
        FROM GA_TRANSACABO
        WHERE NUM_TRANSACCION = LN_SECUENCIA;


    IF SN_COD_RETORNO=0 AND    TRIM(SV_MENS_RETORNO) IS NULL THEN
       RAISE SIN_NUMMOVIMIENTO;
    END IF;

EXCEPTION
    WHEN SIN_NUMMOVIMIENTO THEN
        SN_COD_RETORNO := 100013;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '( ); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER,
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
END PV_ROLLBACK_RESERV_PR;

END PV_GEST_LIM_CON_INTER_PG;
/
SHOW ERRORS
