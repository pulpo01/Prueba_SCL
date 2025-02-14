CREATE OR REPLACE PACKAGE BODY PV_CARGOS_CICLO_ODBC_PG AS

PROCEDURE PV_CARGOS_ODBC_PR(
             EV_TRANSACCION            IN VARCHAR2
            ,EN_SEQ_CARGO            IN NUMBER
            ,EN_EN_COD_CLIENTE         IN NUMBER
            ,EN_NUM_ABONADO            IN NUMBER
            ,EN_COD_PROD_CONTRATADO    IN NUMBER
            ,EN_COD_PRODUCTO           IN NUMBER
            ,EN_ID_CARGO               IN NUMBER
            ,EN_COD_CONCEPTO           IN NUMBER
            ,EN_COLUMNA                IN NUMBER
            ,ED_FEC_ALTA               IN VARCHAR2
            ,EN_IMP_CARGO              IN NUMBER
            ,EV_COD_MONEDA             IN VARCHAR2
            ,EN_COD_PLANCOM            IN NUMBER
            ,EN_NUM_UNIDADES           IN NUMBER
            ,EN_IND_FACTUR             IN NUMBER
            ,EN_NUM_TRANSACCION        IN NUMBER
            ,EN_NUM_VENTA              IN NUMBER
            ,EN_NUM_PAQUETE            IN NUMBER
            ,EV_NUM_TERMINAL           IN VARCHAR2
            ,EV_COD_CICLFACT           IN VARCHAR2
            ,EV_NUM_SERIE              IN VARCHAR2
            ,EV_NUM_SERIEMEC           IN VARCHAR2
            ,EN_CAP_CODE               IN NUMBER
            ,EN_MES_GARANTIA           IN NUMBER
            ,EV_NUM_PREGUIA            IN VARCHAR2
            ,EV_NUM_GUIA               IN VARCHAR2
            ,EN_COD_CONCEREL           IN NUMBER
            ,EN_COLUMNA_REL            IN NUMBER
            ,EN_COD_CONCEPTO_DTO       IN NUMBER
            ,EN_VAL_DTO                IN NUMBER
            ,EN_TIP_DTO                IN NUMBER
            ,EN_IND_CUOTA              IN NUMBER
            ,EN_NUM_CUOTAS             IN NUMBER
            ,EN_ORD_CUOTA              IN NUMBER
            ,EN_IND_SUPERTEL           IN NUMBER
            ,EN_IND_MANUAL             IN NUMBER
            ,EV_PREF_PLAZA             IN VARCHAR2
            ,EV_COD_TECNOLOGIA         IN VARCHAR2
            ,EV_GLS_DESCRIP            IN VARCHAR2
            ,EN_NUM_FACTURA            IN NUMBER
            ,ED_FEC_ULTMOD             IN VARCHAR2
            ,EV_NOM_USUARIO            IN VARCHAR2
            )
IS

/*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "PV_CARGOS_CICLO_ODBC_PG"
          Lenguaje="PL/SQL"
          Fecha="03-09-2007"
          Versión="La del package"
          Diseñador="Orlando Cabezas"
          Programador="Orlando Cabezas"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción></Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="EN_SEQ_CARGO" Tipo="NUMERICO">Secuencia</param>
                <param nom="EN_EN_COD_CLIENTE" Tipo="NUMERICO">Codigo del cliente</param>
                <param nom="EN_NUM_ABONADO" Tipo="NUMERICO">numero del abonado</param>
                <param nom="EN_COD_PROD_CONTRATADO" Tipo="NUMERICO">codigo producto contratado</param>
                <param nom="EN_COD_PRODUCTO" Tipo="NUMERICO">codigo producto</param>
                <param nom="EN_ID_CARGO" Tipo="NUMERICO">identificador de cargos</param>
                <param nom="EN_COD_CONCEPTO" Tipo="NUMERICO">codigo de concepto</param>
                <param nom="EN_COLUMNA" Tipo="NUMERICO">columna</param>
                <param nom="ED_FEC_ALTA" Tipo="FECHA">fecha de alta</param>
                <param nom="EN_IMP_CARGO" Tipo="NUMERICO">importe del cargo</param>
                <param nom="EV_COD_MONEDA" Tipo="CARACTER">codigo de moneda</param>
                <param nom="EN_COD_PLANCOM" Tipo="NUMERICO">codigo plan comercial</param>
                <param nom="EN_NUM_UNIDADES" Tipo="NUMERICO">numero de unidades</param>
                <param nom="EN_IND_FACTUR" Tipo="NUMERICO">indicador de facturado/param>
                <param nom="EN_NUM_TRANSACCION" Tipo="NUMERICO">numero de transaccion</param>
                <param nom="EN_NUM_VENTA" Tipo="NUMERICO">numero de venta</param>
                <param nom="EN_NUM_PAQUETE" Tipo="NUMERICO">numero de paquete</param>
                <param nom="EV_NUM_TERMINAL" Tipo="CARACTER">numero de terminalo</param>
                <param nom="EV_COD_CICLFACT" Tipo="CARACTER">codigo ciclo de facturacion</param>
                <param nom="EV_NUM_SERIE" Tipo="CARACTER">numero de serie</param>
                <param nom="EV_NUM_SERIEMEC" Tipo="CARACTER">numero de serie</param>
                <param nom="EN_CAP_CODE" Tipo="NUMERICO">cap code</param>
                <param nom="EN_MES_GARANTIA" Tipo="NUMERICO">mes de garantia</param>
                <param nom="EV_NUM_PREGUIA" Tipo="CARACTER">numero de pre guia</param>
                <param nom="EV_NUM_GUIA" Tipo="CARACTER">numero de guia</param>
                <param nom="EN_COD_CONCEREL" Tipo="NUMERICO">codigo de concepto relacionado</param>
                <param nom="EN_COLUMNA_REL" Tipo="NUMERICO">columna relacionada</param>
                <param nom="EN_COD_CONCEPTO_DTO" Tipo="NUMERICO">codigo concepto dto</param>
                <param nom="EN_VAL_DTO" Tipo="NUMERICO">valor dto</param>
                <param nom="EN_TIP_DTO" Tipo="NUMERICO">tipo dto</param>
                <param nom="EN_IND_CUOTA" Tipo="NUMERICO">indicador de cuota</param>
                <param nom="EN_NUM_CUOTAS" Tipo="NUMERICO">numero de cuotas</param>
                <param nom="EN_ORD_CUOTA" Tipo="NUMERICO">ordenador de cuotas</param>
                <param nom="EN_IND_SUPERTEL" Tipo="NUMERICO">indicador</param>
                <param nom="EN_IND_MANUAL" Tipo="NUMERICO">indicador manual</param>
                <param nom="EV_PREF_PLAZA" Tipo="CARACTER">prefijo plaza</param>
                <param nom="EV_COD_TECNOLOGIA" Tipo="CARACTER">codigo tecnologia</param>
                <param nom="EV_GLS_DESCRIP" Tipo="CARACTER">glosa descripcion</param>
                <param nom="EN_NUM_FACTURA" Tipo="NUMERICO">numero de factura</param>
                <param nom="ED_FEC_ULTMOD" Tipo="FECHA">fecha ultima modificacion</param>
                <param nom="EV_NOM_USUARIO" Tipo="CARACTER">nombre de usuario</param>
                <param nom="EV_TRANSACCION" Tipo="CARACTER">NUMERO TRANSACCION </param>
             </Entrada>
             <Salida>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

  REGISTRO2 FA_CARGOS_QT:=PV_INICIA_ESTRUCTURAS_PG.FA_CARGOS_SN_QT_FN;
  SN_cod_retorno     ge_errores_td.cod_msgerror%TYPE;
  SV_mens_retorno    ge_errores_td.det_msgerror%TYPE;
  V_TRANSAC GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  SN_num_evento      ge_errores_pg.evento;
  LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
  LV_SSQL         GE_ERRORES_PG.VQUERY;
  LN_RETORNO      NUMBER;
  LV_GLOSA        VARCHAR2(255);

BEGIN
    V_TRANSAC := TO_NUMBER(EV_TRANSACCION);
    LN_RETORNO:=0;
    LV_GLOSA:='OK';
    REGISTRO2.SEQ_CARGO            :=EN_SEQ_CARGO             ;
    REGISTRO2.COD_CLIENTE          :=EN_EN_COD_CLIENTE        ;
    REGISTRO2.NUM_ABONADO          :=EN_NUM_ABONADO           ;
    REGISTRO2.COD_PROD_CONTRATADO  :=EN_COD_PROD_CONTRATADO   ;
    REGISTRO2.COD_PRODUCTO         :=EN_COD_PRODUCTO          ;
    REGISTRO2.ID_CARGO             :=EN_ID_CARGO              ;
    REGISTRO2.COD_CONCEPTO         :=EN_COD_CONCEPTO          ;
    REGISTRO2.COLUMNA              :=EN_COLUMNA               ;
    REGISTRO2.FEC_ALTA             :=SYSDATE                  ;
    REGISTRO2.IMP_CARGO            :=EN_IMP_CARGO             ;
    REGISTRO2.COD_MONEDA           :=EV_COD_MONEDA            ;
    REGISTRO2.COD_PLANCOM          :=EN_COD_PLANCOM           ;
    REGISTRO2.NUM_UNIDADES         :=EN_NUM_UNIDADES          ;
    REGISTRO2.IND_FACTUR           :=EN_IND_FACTUR            ;
    REGISTRO2.NUM_TRANSACCION      :=EN_NUM_TRANSACCION       ;
    REGISTRO2.NUM_VENTA            :=EN_NUM_VENTA             ;
    REGISTRO2.NUM_PAQUETE          :=EN_NUM_PAQUETE           ;
    REGISTRO2.NUM_TERMINAL         :=EV_NUM_TERMINAL          ;
    REGISTRO2.COD_CICLFACT         :=EV_COD_CICLFACT          ;
    REGISTRO2.NUM_SERIE            :=EV_NUM_SERIE             ;
    REGISTRO2.NUM_SERIEMEC         :=EV_NUM_SERIEMEC          ;
    REGISTRO2.CAP_CODE             :=EN_CAP_CODE              ;
    REGISTRO2.MES_GARANTIA         :=EN_MES_GARANTIA          ;
    REGISTRO2.NUM_PREGUIA          :=EV_NUM_PREGUIA           ;
    REGISTRO2.NUM_GUIA             :=EV_NUM_GUIA              ;
    REGISTRO2.COD_CONCEREL         :=EN_COD_CONCEREL          ;
    REGISTRO2.COLUMNA_REL          :=EN_COLUMNA_REL           ;
    REGISTRO2.COD_CONCEPTO_DTO     :=EN_COD_CONCEPTO_DTO      ;
    REGISTRO2.VAL_DTO              :=EN_VAL_DTO               ;
    REGISTRO2.TIP_DTO              :=EN_TIP_DTO               ;
    REGISTRO2.IND_CUOTA            :=EN_IND_CUOTA             ;
    REGISTRO2.NUM_CUOTAS           :=EN_NUM_CUOTAS            ;
    REGISTRO2.ORD_CUOTA            :=EN_ORD_CUOTA             ;
    REGISTRO2.IND_SUPERTEL         :=EN_IND_SUPERTEL          ;
    REGISTRO2.IND_MANUAL           :=EN_IND_MANUAL            ;
    REGISTRO2.PREF_PLAZA           :=EV_PREF_PLAZA            ;
    REGISTRO2.COD_TECNOLOGIA       :=EV_COD_TECNOLOGIA        ;
    REGISTRO2.GLS_DESCRIP          :=EV_GLS_DESCRIP           ;
    REGISTRO2.NUM_FACTURA          :=EN_NUM_FACTURA           ;
    REGISTRO2.FEC_ULTMOD           :=SYSDATE                  ;
    REGISTRO2.NOM_USUARIO          :=EV_NOM_USUARIO           ;

    LV_SSQL:='FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(REGISTRO2,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
    FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(REGISTRO2,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
    
    IF SN_cod_retorno> 0 THEN
       LN_RETORNO:=4;
       LV_GLOSA:=SUBSTR(SV_mens_retorno,1,255);
    END IF;
    
    INSERT INTO GA_TRANSACABO(NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
    VALUES (V_TRANSAC, LN_RETORNO,LV_GLOSA);
    
EXCEPTION
                                                      
                WHEN OTHERS THEN                        
                        SN_COD_RETORNO := 156;             
                        IF NOT GE_ERRORES_PG.MENSAJEERROR(SN_COD_RETORNO,SV_MENS_RETORNO) THEN
                                      SV_MENS_RETORNO := CV_ERROR_NO_CLASIF;
                        END IF;                        
                                       
                        LV_DES_ERROR   := 'PV_CARGOS_CICLO_ODBC_PG.PV_CARGOS_ODBC_PR(';
                        LV_DES_ERROR:= LV_DES_ERROR || EN_SEQ_CARGO           || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_EN_COD_CLIENTE      || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_NUM_ABONADO         || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COD_PROD_CONTRATADO || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COD_PRODUCTO        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_ID_CARGO            || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COD_CONCEPTO        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COLUMNA             || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || SYSDATE                || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_IMP_CARGO           || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_COD_MONEDA          || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COD_PLANCOM         || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_NUM_UNIDADES        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_IND_FACTUR          || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_NUM_TRANSACCION     || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_NUM_VENTA           || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_NUM_PAQUETE         || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_NUM_TERMINAL        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_COD_CICLFACT        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_NUM_SERIE           || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_NUM_SERIEMEC        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_CAP_CODE            || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_MES_GARANTIA        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_NUM_PREGUIA         || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_NUM_GUIA            || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COD_CONCEREL        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COLUMNA_REL         || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_COD_CONCEPTO_DTO    || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_VAL_DTO             || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_TIP_DTO             || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_IND_CUOTA           || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_NUM_CUOTAS          || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_ORD_CUOTA           || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_IND_SUPERTEL        || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_IND_MANUAL          || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_PREF_PLAZA          || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_COD_TECNOLOGIA      || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_GLS_DESCRIP         || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EN_NUM_FACTURA         || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || SYSDATE                || ',';   
                        LV_DES_ERROR:= LV_DES_ERROR || EV_NOM_USUARIO         || ')'|| SQLERRM;   
                                                  
                        SN_NUM_EVENTO  := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'PV_CARGOS_CICLO_ODBC_PG.PV_CARGOS_ODBC_PR', LV_SSQL, SN_COD_RETORNO, LV_DES_ERROR );
     

END PV_CARGOS_ODBC_PR;
END PV_CARGOS_CICLO_ODBC_PG;
/
SHOW ERRORS