CREATE OR REPLACE PACKAGE BODY PV_GEST_LIM_CON_VALIDA_PG IS


PROCEDURE PV_VALIDA_OS_PENDIENTE_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EV_COD_OS             IN VARCHAR2,
                                    SN_cod_retorno        OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno        OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento          OUT NOCOPY ge_errores_pg.Evento
)
 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VALIDA_OS_PENDIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2008"
      Versión="1.0"
      Diseñador="EVERIS"
      Programador="EVERIS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> VALIDA SI POSEE OOSS PENDIENTE </Descripción>
      <Parámetros>
         <ENTRADA>
              <PARAM NOM="EN_NUM_ABONADO" TIPO="NUMBER"> NUMERO DE ABONADO</PARAM>
              <PARAM NOM="EV_COD_OS" TIPO="VARCHAR2"> CODIGO DE OOSS </PARAM>
         </ENTRADA>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC             STRING(30)   := 'PV_VALIDA_OS_PENDIENTE_PR';
    LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
    LN_NUM_TRANSACC            GA_TRANSACABO.NUM_TRANSACCION%TYPE;
    
    LV_OS_FINAL                GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    LN_CANTIDAD                NUMBER;
BEGIN

     SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;

    BEGIN
        SELECT VAL_PARAMETRO INTO LV_OS_FINAL
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = 'EST_RESPCENTRAL'
        AND COD_MODULO = 'GA'
        AND COD_PRODUCTO = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            SV_MENS_RETORNO := 'No se encuentra estado final para retorno exitoso de plataforma';
            SN_COD_RETORNO := 1002;
            RAISE ERROR_GENERAL;
    END;

    SELECT COUNT (1) INTO LN_CANTIDAD
    FROM pv_iorserv e, pv_erecorrido f, pv_camcom g
    WHERE e.num_os = f.num_os
    AND e.num_os = g.num_os
    AND g.num_abonado = EN_NUM_ABONADO
    AND e.cod_os = EV_COD_OS
    AND e.num_os NOT IN (
        SELECT a.num_os
        FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
        WHERE a.num_os = b.num_os
            AND a.cod_os = EV_COD_OS
            AND (a.fh_ejecucion IS NULL OR a.fh_ejecucion <= SYSDATE)
            AND a.num_os = c.num_os
            AND c.num_abonado = EN_NUM_ABONADO
            AND a.cod_modgener = d.cod_modgener
            AND d.atrib_estado IN (2, 3)
            AND d.cod_aplic = 'PVA'
            AND ((b.cod_estado = d.est_final) OR (b.cod_estado = LV_OS_FINAL))
            AND b.tip_estado = 3
        UNION ALL
        SELECT a.num_os
        FROM pv_iorserv a, pv_erecorrido b, pv_camcom c, pv_arcos d
        WHERE a.num_os = b.num_os
            AND a.cod_os = EV_COD_OS
            AND a.num_os = c.num_os
            AND (a.fh_ejecucion IS NULL OR a.fh_ejecucion <= SYSDATE)
            AND c.num_abonado = EN_NUM_ABONADO
            AND a.cod_modgener = d.cod_modgener
            AND d.atrib_estado IN (2, 3)
            AND d.cod_aplic = 'PVA'
            AND b.tip_estado = 4);
    
    IF LN_CANTIDAD > 0 THEN
        SN_COD_RETORNO := 1001;
        SV_MENS_RETORNO := 'No es posible ejecutar por existir OOSS Pendiente';
        RAISE ERROR_GENERAL;
    END IF;
    
EXCEPTION
    WHEN ERROR_GENERAL THEN
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
            NULL;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||','''||EV_COD_OS||'''); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER, 
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||','''||EV_COD_OS||'''); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER, 
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_VALIDA_OS_PENDIENTE_PR;


PROCEDURE PV_VALIDA_AVISO_SINIESTRO_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EV_TABLA              IN VARCHAR2,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
)
 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VALIDA_AVISO_SINIESTRO_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2008"
      Versión="1.0"
      Diseñador="EVERIS"
      Programador="EVERIS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> VALIDA SI REALIZO AVISO SINIESTRO</Descripción>
      <Parámetros>
         <ENTRADA>
              <PARAM NOM="EN_NUM_ABONADO" TIPO="NUMBER"> NUMERO DE ABONADO</PARAM>
              <PARAM NOM="EV_TABLA" TIPO="VARCHAR2"> NOMBRE DE LA TABLA A LA QUE PERTENECE </PARAM>
         </ENTRADA>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC             STRING(30)   := 'PV_VALIDA_AVISO_SINIESTRO_PR';
    LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
    LN_NUM_TRANSACC            GA_TRANSACABO.NUM_TRANSACCION%TYPE;
    
    LN_ESTADO_SINIE            NUMBER;
    LN_SINIEAV                 NUMBER;
    LV_MENSAJE                 VARCHAR2(100);
BEGIN

     SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO     := 0;
    
    BEGIN
        LV_SSQL := 'SELECT COUNT(1) ' 
                || 'FROM GA_SINIESTROS A, '||EV_TABLA||' B '
                || 'WHERE B.NUM_ABONADO = '||EN_NUM_ABONADO||' '
                || 'AND A.NUM_ABONADO = B.NUM_ABONADO';
        
        EXECUTE IMMEDIATE LV_SSQL INTO LN_ESTADO_SINIE;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        
            SELECT COUNT(1) INTO LN_SINIEAV
            FROM GA_SINIESTROS
            WHERE NUM_ABONADO = EN_NUM_ABONADO;
            
            IF LN_SINIEAV = 0 THEN
                SN_COD_RETORNO := 10012;
                LV_MENSAJE := 'El abonado no ha realizado Aviso de Siniestro';
                RAISE ERROR_GENERAL;
            ELSE
                SN_COD_RETORNO := 10013;
                LV_MENSAJE := 'El abonado debe formalizar su aviso de siniestro';
                RAISE ERROR_GENERAL;
            END IF;      
            
                      
    END;
    
EXCEPTION
    WHEN ERROR_GENERAL THEN
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
            SV_MENS_RETORNO := LV_MENSAJE;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||','''||EV_TABLA||'''); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER, 
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||','''||EV_TABLA||'''); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER, 
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_VALIDA_AVISO_SINIESTRO_PR;

PROCEDURE PV_VALIDA_RECAMBIO_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EN_COD_CLIENTE        IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                    EV_NOM_USUARIO        IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                    SN_cod_retorno        OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno       OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento         OUT NOCOPY ge_errores_pg.Evento
)
 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VALIDA_RECAMBIO_PR"
      Lenguaje="PL/SQL"
      Fecha="10-06-2008"
      Versión="1.0"
      Diseñador="EVERIS"
      Programador="EVERIS"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> VALIDA SI PUEDE REALIZAR O NO EL RECAMBIO</Descripción>
      <Parámetros>
         <ENTRADA>
              <PARAM NOM="EN_NUM_ABONADO" TIPO="NUMBER"> NUMERO DE ABONADO</PARAM>
         </ENTRADA>
         <Salida>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_DES_ERROR               GE_ERRORES_PG.DESEVENT;
    LV_SSQL                    GE_ERRORES_PG.VQUERY;
    LV_NOMBRE_PROC             STRING(30)   := 'PV_VALIDA_RECAMBIO_PR';
    LV_PKG_PROC                STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
    
    LV_FECHA_ALTA              VARCHAR2(30);  
    LN_NUMDIAS                 NUMBER       := 180; --6 meses
    LN_CODSER                  NUMBER       := 59; -- corte bidireccional
    LV_FORMATO_SEL2            GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    LN_DIAS_APLIC              NUMBER;
    LN_PERMISO                 NUMBER;
    LN_DEUDA                   NUMBER(16,4);
BEGIN

    SN_COD_RETORNO  := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO   := 0;
        
    SELECT COUNT (A.COD_PROCESO) INTO LN_PERMISO
    FROM GE_SEG_PERFILES A, GE_SEG_GRPUSUARIO B
    WHERE A.COD_GRUPO = B.COD_GRUPO
    AND B.NOM_USUARIO = EV_NOM_USUARIO
    AND A.COD_PROGRAMA = 'GPA'
    AND A.NUM_VERSION = (
        SELECT NVL (MAX (NUM_VERSION), 0)
        FROM GE_PROGRAMAS
        WHERE COD_PROGRAMA = 'GPA')
    AND A.COD_PROCESO = (
        SELECT COD_PROCESO
        FROM GAD_PROCESOS_PERFILES
        WHERE NOM_PERFIL_PROCESO = 'COD_PROC_ACC_CAMBIO')
    AND ROWNUM = 1;
    
    IF LN_PERMISO = 0 THEN
    
        SELECT VAL_PARAMETRO INTO LV_FORMATO_SEL2 
        FROM GED_PARAMETROS
        WHERE COD_MODULO = 'GE'
        AND COD_PRODUCTO = 1
        AND NOM_PARAMETRO = 'FORMATO_SEL2';
        
        BEGIN
        
        LV_SSQL := 'SELECT TO_CHAR(FEC_SUSPBD + '||LN_CODSER||' , '''||LV_FORMATO_SEL2||''') '
                || 'FROM GA_SUSPREHABO '
                || 'WHERE NUM_ABONADO = '|| EN_NUM_ABONADO|| ' '
                || 'AND COD_MODULO = ''CO'' '
                || 'AND FEC_SUSPBD BETWEEN SYSDATE - '||LN_NUMDIAS||'  AND SYSDATE '
                || 'AND COD_SERVICIO = '||LN_CODSER;
           
            SELECT TO_CHAR(FEC_SUSPBD + LN_CODSER , LV_FORMATO_SEL2) INTO LV_FECHA_ALTA
            FROM GA_SUSPREHABO
            WHERE NUM_ABONADO =  EN_NUM_ABONADO
            AND COD_MODULO = 'CO'
            AND FEC_SUSPBD BETWEEN SYSDATE - LN_NUMDIAS  AND SYSDATE
            AND COD_SERVICIO = LN_CODSER;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL;
        END;

        IF LV_FECHA_ALTA IS NOT NULL THEN
            SN_COD_RETORNO := 1;
            SV_MENS_RETORNO := 'NO puede realizar OOSS para este abonado, Puede realizar OOSS a contar de: ' || LV_FECHA_ALTA;
            RAISE ERROR_GENERAL;
        END IF;

        LV_SSQL := 'SELECT DIAS_APLICACION '
                || 'FROM CO_INTERESES ' 
                || 'WHERE SYSDATE BETWEEN FEC_VIGENCIA_DD_DH  '
                || 'AND FEC_VIGENCIA_HH_DH';

        SELECT DIAS_APLICACION INTO LN_DIAS_APLIC
        FROM CO_INTERESES 
        WHERE SYSDATE BETWEEN FEC_VIGENCIA_DD_DH 
        AND  FEC_VIGENCIA_HH_DH;
            
        LV_SSQL := 'SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0) '
                || 'FROM CO_CARTERA '
                || 'WHERE COD_CLIENTE = '|| EN_COD_CLIENTE|| ' ' 
                || 'AND IND_FACTURADO = 1 '
                || 'AND (FEC_VENCIMIE + '||LN_DIAS_APLIC||')  < TRUNC(SYSDATE) '
                || 'AND COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR) '
                || 'FROM CO_CODIGOS '
                || 'WHERE NOM_TABLA = ''CO_CARTERA'' AND  NOM_COLUMNA = ''COD_TIPDOCUM'')';
        
        SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0) INTO LN_DEUDA
        FROM CO_CARTERA
        WHERE COD_CLIENTE =  EN_COD_CLIENTE 
        AND IND_FACTURADO = 1
        AND (FEC_VENCIMIE + LN_DIAS_APLIC)  < TRUNC(SYSDATE)
        AND COD_TIPDOCUM NOT IN (SELECT  TO_NUMBER(COD_VALOR)
        FROM CO_CODIGOS
        WHERE NOM_TABLA = 'CO_CARTERA' AND  NOM_COLUMNA = 'COD_TIPDOCUM');
            
        If LN_DEUDA > 1 Then
            SN_COD_RETORNO := 1;
            SV_MENS_RETORNO := 'No puede realizar OOSS para este abonado, Debe Regularizar deuda de $ '||LN_DEUDA;
            RAISE ERROR_GENERAL;
        End If;      
    
    END IF;
    
EXCEPTION
    WHEN ERROR_GENERAL THEN
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||','||EN_COD_CLIENTE||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER, 
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

    WHEN OTHERS THEN
        SN_COD_RETORNO := GV_ERROR_OTHERS;
        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
          SV_MENS_RETORNO := GV_ERROR_NO_CLASIF;
        END IF;
        LV_DES_ERROR := SUBSTR(LV_NOMBRE_PROC || '('||EN_NUM_ABONADO||','||EN_COD_CLIENTE||'); - ' || SQLERRM,1,GN_LARGOERRTEC);
        SV_MENS_RETORNO:=SUBSTR(SV_MENS_RETORNO,1,GN_LARGODESC);
        SN_NUM_EVENTO := GE_ERRORES_PG.GRABARPL(SN_NUM_EVENTO, GV_COD_MODULO, SV_MENS_RETORNO, '1.0', USER, 
        LV_PKG_PROC, LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );

END PV_VALIDA_RECAMBIO_PR;


PROCEDURE PV_VAL_VENTA_SIN_FOLIO_PR(
                                SN_IND_VTASINFOLIO  OUT GE_OPERADORA_SCL.IND_VTASINFOLIO%TYPE,
                                SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.EVENTO 
) IS
/*
<DOCUMENTACIÓN TIPODOC = "PROCEDIMIENTO">
<ELEMENTO NOMBRE = "PV_VAL_VENTA_SIN_FOLIO_PR"
LENGUAJE="PL/SQL"
FECHA="10-10-2011"
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
    LV_NOMBRE_PROC              STRING(30)   := 'PV_VAL_VENTA_SIN_FOLIO_PR';
    LV_PKG_PROC                 STRING(60)   := GV_PACKAGE||'.'||LV_NOMBRE_PROC;
    LV_COD_OPERADORA            GE_PARAMETROS_SISTEMA_VW.VALOR_TEXTO%TYPE;
BEGIN

    SN_COD_RETORNO := 0;
    SV_MENS_RETORNO := 'OK';
    SN_NUM_EVENTO := 0;
    
    SELECT  VALOR_TEXTO INTO LV_COD_OPERADORA
    FROM GE_PARAMETROS_SISTEMA_VW
    WHERE  NOM_PARAMETRO = 'COD_OPERADORA_LOCAL'
    AND    COD_MODULO    = 'GE';

    LV_SSQL := 'SELECT IND_VTASINFOLIO FROM GE_OPERADORA_SCL '
            || 'WHERE COD_OPERADORA_SCL = '''||LV_COD_OPERADORA||''''; 
   
    SELECT IND_VTASINFOLIO 
    INTO SN_IND_VTASINFOLIO
    FROM GE_OPERADORA_SCL 
    WHERE COD_OPERADORA_SCL = LV_COD_OPERADORA;
       


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
END PV_VAL_VENTA_SIN_FOLIO_PR;

END PV_GEST_LIM_CON_VALIDA_PG;
/
SHOW ERRORS