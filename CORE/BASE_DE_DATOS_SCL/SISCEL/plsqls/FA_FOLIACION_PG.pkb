CREATE OR REPLACE PACKAGE BODY FA_FOLIACION_PG IS

    /* opciones */
    G_NOPBUSQPUNTUAL            NUMBER;           -- Opcion de busqueda puntual (1)
    G_NOPBUSQDISPSR             NUMBER;           -- Opcion de busqueda sin rango (2)
    G_NOPBUSQDISPCR             NUMBER;           -- Opcion de busqueda con rango (3)
    G_NOPBUSQDISPSRL            NUMBER;           -- Opcion de busqueda sin rango con bloqueo (4)
    G_NOPBUSQDISPCRL            NUMBER;           -- Opcion de busqueda con rango con bloqueo (5)
    G_NOPBUSQDISPVENTA          NUMBER;           -- Opcion de busqueda para venta (6)
    G_NOPCIONCONSUMOSR          NUMBER;           -- Opcion de consumo = 1 (1)
    G_CSEPARADOR                CHAR;             -- SEPARADOR de String de salida (;)
    /* estado de retorno de procesos */
    G_NESTADO_FUNCIONOK         NUMBER(1);        -- Estado de terminación de función correctamente
    G_NESTADO_FUNCIONERR        NUMBER(1);        -- Estado de terminación de función incorrectamente
    /* Estado de posibles estado de folio consumo */
    G_NESTADO_FOLCONSUMIDO      NUMBER;           -- Valor de estado de folio consumido
    G_NESTADO_FOLANULADO        NUMBER;           -- Valor de estado de folio anulado
    /* estado de retorno funciones */
    G_NESTADO_DISPONIBLE        NUMBER;           -- Estado de folio disponible
    G_NESTADO_CONSUMIDO         NUMBER;           -- Estado de folio consumido
    G_NESTADO_ANULADO           NUMBER;           -- Estado de folio anulado
    G_NESTADO_FOLIONOENC        NUMBER;           -- Estado de folio no encontrado
    G_VMSG_FOLIONOENC           VARCHAR2(50);     -- Descripción Estado de folio no encontrado
    G_NFOLIO_NOCONSUMIDO        NUMBER;
    G_NMUCHAS_FILAS             NUMBER;           -- Estado que retorna varias filas
    G_VMSG_MUCHASFILAS          VARCHAR2(50);
    G_NESTADO_INDEFINIDO        NUMBER;           -- Estado de retorno Indefinido
    G_NRANGO_CONSUMIDO          NUMBER;           -- EL Rango se encuentra consumido
    G_NFALTA_PARAM              NUMBER;           -- Estado que indica que faltan parametros
    G_NFOLIOS_NOCOINCIDEN       NUMBER;           -- folio disponible no es igual al folio pasado por parmetro
    G_VDESC_FALTAPARAM          VARCHAR2(70);
    G_VOPCION_INVALIDA          VARCHAR2(50);
    G_VNOFOUND_USUARIO          VARCHAR2(50);
    G_NOINSERTO_CONSUMO         VARCHAR2(70);
    G_VALOR_RESET_VARCHAR       VARCHAR2(2);
    G_VALOR_RESET_NUMBER        NUMBER;
    G_VALOR_RESET_DATE          DATE;

    PROCEDURE FA_INICIALIZA_PR AS
    BEGIN
        G_NOPBUSQPUNTUAL            :=1;
        G_NOPBUSQDISPSR             :=2;
        G_NOPBUSQDISPCR             :=3;
        G_NOPBUSQDISPSRL            :=4;
        G_NOPBUSQDISPCRL            :=5;
        G_NOPBUSQDISPVENTA          :=6;
        G_NOPCIONCONSUMOSR          :=1;
        G_CSEPARADOR                :=';';
        /* estado de retorno de procesos */
        G_NESTADO_FUNCIONOK         :=0;
        G_NESTADO_FUNCIONERR        :=1;
        /* Estado de folio */
        G_NESTADO_FOLCONSUMIDO      :=0;
        G_NESTADO_FOLANULADO        :=1;
        /* estado de retorno funciones */
        G_NESTADO_DISPONIBLE        :=1;
        G_NESTADO_CONSUMIDO         :=2;
        G_NESTADO_ANULADO           :=3;
        G_NESTADO_FOLIONOENC        :=4;
        G_VMSG_FOLIONOENC           :=' Folio No encontrado ';
        G_NMUCHAS_FILAS             :=5;
        G_VMSG_MUCHASFILAS          :=' Se encontro mas de un rango para key entregada ';
        G_NESTADO_INDEFINIDO        :=6;
        G_NRANGO_CONSUMIDO          :=7;
        G_NFOLIO_NOCONSUMIDO        :=8;
        G_NFALTA_PARAM              :=9;
        G_NFOLIOS_NOCOINCIDEN       :=10;
        G_VDESC_FALTAPARAM          :=' Debe Ingresar valores en los parametros de entrada ';
        G_VOPCION_INVALIDA          :=' Opcion de Ingreso Invalida ';
        G_VNOFOUND_USUARIO          :=' No se pudo rescatar el Usuario ';
        G_NOINSERTO_CONSUMO         :=' No se puede insertar en AL_CONSUMO_DOCUMENTOS ';
        G_VALOR_RESET_VARCHAR       :='XX';
        G_VALOR_RESET_NUMBER        :=0;
        G_VALOR_RESET_DATE          :=NULL;

    END;

/****************************************************************************************************************/
/* Funcion: FA_OBTIENE_PARAMETRO_FN                                                                           */
/****************************************************************************************************************/
FUNCTION FA_OBTIENE_PARAMETRO_FN (EV_nomparam IN FAD_PARAMETROS.COD_PARAMETRO%TYPE, EV_codmodulo IN FAD_PARAMETROS.COD_MODULO%TYPE)
      RETURN FAD_PARAMETROS.VAL_CARACTER%TYPE
   IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " FA_OBTIENE_PARAMETRO_FN" Lenguaje="PL/SQL" Fecha="27-05-2010" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna el valor del parametro</Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EV_nomparam" Tipo="VARCHAR2">Nombre del Parámetro</param>
-- </Entrada>
-- <Salida>
-- <param nom="FA_OBTIENE_PARAMETRO_FN" Tipo="VARCHAR2">Oficina</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
      LV_vVal_parametro  FAD_PARAMETROS.VAL_CARACTER%TYPE;
BEGIN
         SELECT VAL_CARACTER
           INTO LV_vVal_parametro
           FROM FAD_PARAMETROS
          WHERE COD_PARAMETRO = EV_nomparam
            AND COD_MODULO    = EV_codmodulo;

      RETURN LV_vVal_parametro;

EXCEPTION
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20103,'ERROR FA_OBTIENE_PARAMETRO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);

END FA_OBTIENE_PARAMETRO_FN;

/****************************************************************************************************************/
/* Funcion: FA_DOCUMENTO_CONSUMO_FN                                                                            */
/****************************************************************************************************************/

FUNCTION FA_DOCUMENTO_CONSUMO_FN (p_ntipo_documento IN NUMBER  )
      RETURN NUMBER
   IS
      LV_vVal_parametro   FA_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
BEGIN
      BEGIN
         SELECT COD_TIPDOCUM
           INTO LV_vVal_parametro
           FROM FA_TIPDOCUMEN
          WHERE COD_TIPDOCUMMOV = p_ntipo_documento;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20202,'ERROR FA_DOCUMENTO_CONSUMO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO EXISTE VALOR PARAMETRO');
      END;
      RETURN LV_vVal_parametro;
EXCEPTION
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20203,'ERROR FA_DOCUMENTO_CONSUMO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);

END FA_DOCUMENTO_CONSUMO_FN;


FUNCTION FA_OFICINA_CONSUMO_FN (EV_cod_oficina IN GE_OFICINAS.COD_OFICINA%TYPE )
      RETURN GE_OFICINAS.COD_OFICINA%TYPE
   IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " FA_OFICINA_CONSUMO_FN" Lenguaje="PL/SQL" Fecha="25-04-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna la oficina de consumo de folios</Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EV_cod_oficina" Tipo="VARCHAR2">Código Oficina</param>
-- </Entrada>
-- <Salida>
-- <param nom="FA_OFICINA_CONSUMO_FN" Tipo="VARCHAR2">Oficina</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
      LV_vVal_parametro  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
--      LV_vMensaje        VARCHAR2 (200);
      LV_vCod_matriz     VE_OFIMATRIZ_TD.COD_MATRIZ%TYPE;
BEGIN
      BEGIN
         SELECT VAL_PARAMETRO
           INTO LV_vVal_parametro
           FROM GED_PARAMETROS
          WHERE NOM_PARAMETRO = CV_nom_param
            AND COD_MODULO    = CV_modulo
            AND COD_PRODUCTO  = CV_producto;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20102,'ERROR FA_OFICINA_CONSUMO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO EXISTE VALOR PARAMETRO');
      END;


      IF upper(LV_vVal_parametro) = CV_true
      THEN

        BEGIN
           SELECT COD_MATRIZ
             INTO LV_vCod_matriz
             FROM VE_OFIMATRIZ_TD
            WHERE COD_OFICINA = EV_cod_oficina;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20102,'ERROR FA_OFICINA_CONSUMO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRO OFICINA CONSUMO');
        END;

      ELSE
          LV_vCod_matriz := EV_cod_oficina;
      END IF;

      RETURN LV_vCod_matriz;

EXCEPTION
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20103,'ERROR FA_OFICINA_CONSUMO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);

END FA_OFICINA_CONSUMO_FN;

/* ------------------------------- PRIMITIVA  PROCEDURE FA_BUSCA_FOLIO_PR ------------------------------------- */
    PROCEDURE  FA_BUSQUEDA_FOLIO_PR(p_nTipo_documento  IN NUMBER  ,p_nCod_vendedor    IN NUMBER,p_vCod_oficina   IN VARCHAR2,
                                    p_vCod_operadora   IN VARCHAR2,p_nRango_Ini       IN NUMBER,p_nOp_busca      IN NUMBER,
                                    p_vPrefijo_folio  OUT VARCHAR2,p_nCorrela_folio  OUT NUMBER,p_nEstado_folio OUT NUMBER,
                                    p_nEst_funcion    OUT NUMBER  ,p_nRango_Ini_out  OUT NUMBER,p_vInd_Consumo IN VARCHAR2 DEFAULT 'A')
    AS
        error_proceso  EXCEPTION;
        LV_vMSG_SALIDA              VARCHAR2(100);
        LV_vSQLCmd                  VARCHAR(1000);
        LN_nRango                   AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        LN_nDesde                   AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        LN_ndesdefin                AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        p_nTipo_documentoConvertido FA_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
        LN_nRanDesde                AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        LN_nRanHasta                AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;
        LV_vPrefijo                 AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
        LV_vPrefijo_folio           AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;        
        LD_dFecResolucion           AL_ASIG_DOCUMENTOS.FEC_RESOLUCION%TYPE;
        LD_dFecAsigna               AL_ASIG_DOCUMENTOS.FEC_ASIGNA%TYPE;

     BEGIN

        FA_INICIALIZA_PR;
        p_nEstado_folio  :=G_VALOR_RESET_NUMBER;
        p_nRango_Ini_out :=G_VALOR_RESET_NUMBER;
        LN_nDesde        :=G_VALOR_RESET_NUMBER;
        LV_vMSG_SALIDA   :=G_VALOR_RESET_VARCHAR;
        LV_vSQLCmd       :=G_VALOR_RESET_VARCHAR;
        p_nCorrela_folio :=0;
        p_nEst_funcion   :=G_NESTADO_FUNCIONERR;
        LN_nRango        :=0;
        
        --DBMS_OUTPUT.PUT_LINE ('entrando a busqueda folio...' );        

        /* Validación de Parametros de Ingreso a la función */
        IF p_nOp_busca=G_NOPBUSQDISPSR OR p_nOp_busca=G_NOPBUSQDISPSRL OR p_nOp_busca=G_NOPBUSQDISPVENTA THEN
            IF (  p_vCod_oficina IS NULL OR p_nTipo_documento IS NULL OR p_vCod_operadora IS NULL ) THEN
                LV_vMSG_SALIDA := G_VDESC_FALTAPARAM ||'Uno';
                RAISE error_proceso;
            END IF;
        ELSIF p_nOp_busca = G_NOPBUSQDISPCR OR p_nOp_busca = G_NOPBUSQDISPCRL  THEN
            IF ( p_vCod_oficina IS NULL OR p_nTipo_documento IS NULL OR p_vCod_operadora IS NULL OR p_nRango_Ini IS NULL )
            THEN
                LV_vMSG_SALIDA := G_VDESC_FALTAPARAM ||'dos';
                RAISE error_proceso;
           END IF;
        ELSE
            LV_vMSG_SALIDA := G_VOPCION_INVALIDA;
            RAISE error_proceso;
        END IF;

        --DBMS_OUTPUT.PUT_LINE ('obtencion rango menor..' );

        ---------------------------------------------------------------
        --OBTENCION DEL RANGO DESDE MENOR SEGUN PARAMETROS ENTREGADOS--
        ---------------------------------------------------------------
        p_nTipo_documentoConvertido := FA_DOCUMENTO_CONSUMO_FN(p_nTipo_documento);

        IF p_nOp_busca = G_NOPBUSQDISPSR OR p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPVENTA THEN
            LV_vSQLCmd := 'SELECT  MIN (RAN_DESDE) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA = '''||p_vCod_oficina||'''';
            LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA>RAN_USADO ';

            IF  p_nCod_vendedor IS NOT NULL
            THEN
                LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
            ELSE
                LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
            END IF;
            LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';

        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,1,200) );
        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,201,200) );

            EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nDesde;

            IF LN_nDesde IS NULL THEN
                RAISE NO_DATA_FOUND;
            END IF;

        END IF;
        

        --DBMS_OUTPUT.PUT_LINE ('seleccion de folio..' );

        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,1,200) );
        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,201,200) );  
        
----------------------------------------------------------------------------------------------------------------        
        
        
        -----------------------------------------------------------------
        --SELECCION DE FECHA RESOLUCION
        -----------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  MIN (FEC_RESOLUCION) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||p_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = ' ||LN_nDesde;

        IF  p_nCod_vendedor IS NOT NULL
        THEN
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
        
        EXECUTE IMMEDIATE LV_vSQLCmd INTO LD_dFecResolucion;

        IF LD_dFecResolucion IS NULL THEN

           LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
           -----------------------------------------------------------------
           --SELECCION DE FECHA CREACION FOLIO (DOCUMENTOS DE PAGO)
           -----------------------------------------------------------------
           LV_vSQLCmd := 'SELECT  MIN (FEC_ASIGNA) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
           LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
           LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||p_vCod_oficina||'''';
           LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
           LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = ' ||LN_nDesde;

           IF  p_nCod_vendedor IS NOT NULL
           THEN
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
           ELSE
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
           END IF;
           LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
           
           EXECUTE IMMEDIATE LV_vSQLCmd INTO LD_dFecAsigna;

           IF LD_dFecAsigna IS NULL THEN
              RAISE NO_DATA_FOUND;
           END IF;

        END IF;


        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
        -----------------------------------------------------------------
        --SELECCION DE FOLIO SEGUN EL RANGO DESDE OBTENIDO Y PARAMETROS--
        -----------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  RAN_USADO, PREF_PLAZA ';
        LV_vSQLCmd := LV_vSQLCmd||' FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||p_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE     = '||LN_nDesde||' ' ;

        IF LD_dFecResolucion IS NULL THEN
           LV_vSQLCmd := LV_vSQLCmd||' AND FEC_ASIGNA  = TO_DATE('''||TO_CHAR(LD_dFecAsigna,'DD-MM-YYYY HH24:MI:SS')||''',''DD-MM-YYYY HH24:MI:SS'')';
        ELSE
           LV_vSQLCmd := LV_vSQLCmd||' AND FEC_RESOLUCION  = TO_DATE('''||TO_CHAR(LD_dFecResolucion,'DD-MM-YYYY')||''',''DD-MM-YYYY'')';
        END IF;


        IF  p_nCod_vendedor IS NOT NULL
        THEN
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
        
-----------------------------------------------------------------------------------------------------------------        
        
              

        --LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
        -----------------------------------------------------------------
        --SELECCION DE FOLIO SEGUN EL RANGO DESDE OBTENIDO Y PARAMETROS--
        -----------------------------------------------------------------
        --LV_vSQLCmd := 'SELECT  RAN_USADO, PREF_PLAZA ';
        --LV_vSQLCmd := LV_vSQLCmd||' FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        --LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||'''';
        --LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||p_vCod_oficina||'''';
        --LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';


        -- SI LA OPCION ES CON RANGO USAR EL QUE SE PASA POR PARAMETRO, SINO EL QUE SE OBTIENE EN EL QUERY 01
        IF p_nOp_busca = G_NOPBUSQDISPCR OR p_nOp_busca = G_NOPBUSQDISPCRL
        THEN
           LN_ndesdefin :=p_nRango_Ini;
        ELSE
           LN_ndesdefin :=LN_nDesde;
        END IF;

        --LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = '||LN_ndesdefin||' ' ;


        --IF  p_nCod_vendedor IS NOT NULL THEN       -- Query por vendedor
        --    LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        --ELSE -- Vendedor Nulo
        --    LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        --END IF;


        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,1,200) );
        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,201,200) );

        ---------------------------------------------------------------
        --SI ES CONSULTA PARA CONSUMIR DEBE LOCKEAR--------------------
        ---------------------------------------------------------------
        IF p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPCRL THEN
           LV_vSQLCmd := LV_vSQLCmd||'';
        END IF;
        
        EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nRango,LV_vPrefijo_folio;      

        --EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nRango,LV_vPrefijo;
        

        LN_nRango := LN_nRango + 1;

        
        --p_vPrefijo_folio  := LV_vPrefijo;
        p_vPrefijo_folio  := LV_vPrefijo_folio;        
        p_nCorrela_folio  := LN_nRango;
        p_nRango_Ini_out  := LN_ndesdefin;
        p_nEst_funcion    := G_NESTADO_FUNCIONOK;
        p_nEstado_folio   := G_NESTADO_DISPONIBLE;
        

     EXCEPTION
        WHEN error_proceso THEN
            RAISE_APPLICATION_ERROR (-20101,'ERROR FA_BUSCA_FOLIO_PR : '||LV_vMSG_SALIDA);
        WHEN NO_DATA_FOUND THEN
             IF p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPCRL THEN
                 RAISE_APPLICATION_ERROR(-20104,'ERROR FA_BUSCA_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRARON FOLIOS DISPONIBLES');
             ELSE
                p_nEstado_folio  := G_NESTADO_FOLIONOENC;
                p_nEst_funcion   := G_NESTADO_FUNCIONERR;
             END IF;
        WHEN TOO_MANY_ROWS THEN
             IF p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPCRL THEN
                 RAISE_APPLICATION_ERROR(-20104,'ERROR FA_BUSCA_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
             ELSE
                 p_nEstado_folio := G_NMUCHAS_FILAS;
                 p_nEst_funcion  := G_NESTADO_FUNCIONERR;
             END IF;
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20104,'ERROR FA_BUSCA_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
    END FA_BUSQUEDA_FOLIO_PR;

/* ------------------------------- PRIMITIVA  PROCEDURE FA_BUSCA_FOLIO_PR ------------------------------------- */
    PROCEDURE  FA_BUSCA_FOLIO_PR(p_nTipo_documento IN NUMBER  ,p_nCod_vendedor    IN NUMBER,p_vCod_oficina   IN VARCHAR2,
                                 p_vCod_operadora  IN VARCHAR2,p_nRango_Ini       IN NUMBER,p_nOp_busca      IN NUMBER,
                                 p_vPrefijo_folio  IN VARCHAR2,p_nCorrela_folio  OUT NUMBER,p_nEstado_folio OUT NUMBER,
                                 p_nEst_funcion   OUT NUMBER  ,p_nRango_Ini_out  OUT NUMBER,
                                 p_vResolucion    OUT VARCHAR2,p_dFec_Resolucion OUT DATE  ,p_vSerie        OUT VARCHAR2,
                                 p_vEtiqueta      OUT VARCHAR2,p_dFec_CreaFolio  OUT DATE  ,p_dFec_Asigna   OUT DATE,
                                 p_nRan_Hasta     OUT NUMBER, p_vInd_Consumo IN VARCHAR2 DEFAULT 'A')
    AS
        error_proceso  EXCEPTION;
        LV_vMSG_SALIDA              VARCHAR2(100);
        LV_vSQLCmd                  VARCHAR(1000);
        LN_nRango                   AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        LN_nDesde                   AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        LN_ndesdefin                AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        p_nTipo_documentoConvertido FA_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
        LD_dFecResolucion           AL_ASIG_DOCUMENTOS.FEC_RESOLUCION%TYPE;
        LV_vResolucion              AL_ASIG_DOCUMENTOS.RESOLUCION%TYPE;
        LV_vSerie                   AL_ASIG_DOCUMENTOS.SERIE%TYPE;
        LV_vEtiqueta                AL_ASIG_DOCUMENTOS.ETIQUETA%TYPE;
        LD_dFecCreaFolio            AL_ASIG_DOCUMENTOS.FEC_CREAFOLIO%TYPE;
        LD_dFecAsigna               AL_ASIG_DOCUMENTOS.FEC_ASIGNA%TYPE;
        LN_nRanDesde                AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
        LN_nRanHasta                AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;

     BEGIN

        FA_INICIALIZA_PR;
        p_nEstado_folio  :=G_VALOR_RESET_NUMBER;
        p_nRango_Ini_out :=G_VALOR_RESET_NUMBER;
        LN_nDesde        :=G_VALOR_RESET_NUMBER;
        LV_vMSG_SALIDA   :=G_VALOR_RESET_VARCHAR;
        LV_vSQLCmd       :=G_VALOR_RESET_VARCHAR;
        p_nCorrela_folio :=0;
        p_nEst_funcion   :=G_NESTADO_FUNCIONERR;
        LN_nRango        :=0;

        /* Validación de Parametros de Ingreso a la función */
        IF p_nOp_busca=G_NOPBUSQDISPSR OR p_nOp_busca=G_NOPBUSQDISPSRL OR p_nOp_busca=G_NOPBUSQDISPVENTA THEN
            IF (  p_vCod_oficina IS NULL OR p_nTipo_documento IS NULL OR p_vCod_operadora IS NULL ) THEN
                LV_vMSG_SALIDA := G_VDESC_FALTAPARAM ||'Uno';
                RAISE error_proceso;
            END IF;
        ELSIF p_nOp_busca = G_NOPBUSQDISPCR OR p_nOp_busca = G_NOPBUSQDISPCRL  THEN
            IF ( p_vCod_oficina IS NULL OR p_nTipo_documento IS NULL OR p_vCod_operadora IS NULL OR p_nRango_Ini IS NULL )
            THEN
                LV_vMSG_SALIDA := G_VDESC_FALTAPARAM ||'dos';
                RAISE error_proceso;
           END IF;
        ELSE
            LV_vMSG_SALIDA := G_VOPCION_INVALIDA;
            RAISE error_proceso;
        END IF;

        ---------------------------------------------------------------
        --OBTENCION DEL RANGO DESDE MENOR SEGUN PARAMETROS ENTREGADOS--
        ---------------------------------------------------------------
        p_nTipo_documentoConvertido := FA_DOCUMENTO_CONSUMO_FN(p_nTipo_documento);

        IF p_nOp_busca = G_NOPBUSQDISPSR OR p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPVENTA THEN
            LV_vSQLCmd := 'SELECT  MIN (RAN_DESDE) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA = '''||p_vCod_oficina||'''';
            LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA>RAN_USADO ';
            LV_vSQLCmd := LV_vSQLCmd||' AND PREF_PLAZA = '''||p_vPrefijo_folio||'''';

            IF  p_nCod_vendedor IS NOT NULL
            THEN
                LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
            ELSE
                LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
            END IF;
            LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';

            EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nDesde;

            IF LN_nDesde IS NULL THEN
                RAISE NO_DATA_FOUND;
            END IF;

        END IF;

        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
        -----------------------------------------------------------------
        --SELECCION DE FOLIO SEGUN EL RANGO DESDE OBTENIDO Y PARAMETROS--
        -----------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  RAN_USADO, RESOLUCION,';
        LV_vSQLCmd := LV_vSQLCmd||'SERIE, ETIQUETA, FEC_CREAFOLIO, FEC_ASIGNA, RAN_DESDE, RAN_HASTA, FEC_RESOLUCION';
        LV_vSQLCmd := LV_vSQLCmd||' FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||p_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
        LV_vSQLCmd := LV_vSQLCmd||' AND PREF_PLAZA    = '''||p_vPrefijo_folio||'''';

        -- SI LA OPCION ES CON RANGO USAR EL QUE SE PASA POR PARAMETRO, SINO EL QUE SE OBTIENE EN EL QUERY 01
        IF p_nOp_busca = G_NOPBUSQDISPCR OR p_nOp_busca = G_NOPBUSQDISPCRL
        THEN
           LN_ndesdefin :=p_nRango_Ini;
        ELSE
           LN_ndesdefin :=LN_nDesde;
        END IF;

        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = '||LN_ndesdefin||' ' ;


        IF  p_nCod_vendedor IS NOT NULL THEN       -- Query por vendedor
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE -- Vendedor Nulo
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';

        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,1,200) );
        --DBMS_OUTPUT.PUT_LINE ( SUBSTR(LV_vSQLCmd,201,200) );

        ---------------------------------------------------------------
        --SI ES CONSULTA PARA CONSUMIR DEBE LOCKEAR--------------------
        ---------------------------------------------------------------
        IF p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPCRL THEN
           LV_vSQLCmd := LV_vSQLCmd||'';
        END IF;

        EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nRango,LV_vResolucion,
                                          LV_vSerie,LV_vEtiqueta,
                                          LD_dFecCreaFolio, LD_dFecAsigna,
                                          LN_nRanDesde,LN_nRanHasta, LD_dFecResolucion;
                                          
        ---LMV, 26-02-2010, Se resuelve incidencia GESDOC, para que permita grabar en tabla AL_CONUSMO_DOCUMENTOS                                          
        --LMV, LN_nRango := LN_nRango + 1;

        p_nCorrela_folio  := LN_nRango;
        p_nEst_funcion    := G_NESTADO_FUNCIONOK;
        p_nEstado_folio   := G_NESTADO_DISPONIBLE;

        p_vResolucion     := LV_vResolucion;
        p_dFec_Resolucion := LD_dFecResolucion;
        p_vSerie          := LV_vSerie;
        p_vEtiqueta       := LV_vEtiqueta;
        p_dFec_CreaFolio  := LD_dFecCreaFolio;
        p_dFec_Asigna     := LD_dFecAsigna;
        p_nRango_Ini_out  := LN_ndesdefin;
        p_nRan_Hasta      := LN_nRanHasta;

     EXCEPTION
        WHEN error_proceso THEN
            RAISE_APPLICATION_ERROR (-20101,'ERROR FA_BUSCA_FOLIO_PR : '||LV_vMSG_SALIDA);
        WHEN NO_DATA_FOUND THEN
             IF p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPCRL THEN
                 RAISE_APPLICATION_ERROR(-20104,'ERROR FA_BUSCA_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRARON FOLIOS DISPONIBLES');
             ELSE
                p_nEstado_folio  := G_NESTADO_FOLIONOENC;
                p_nEst_funcion   := G_NESTADO_FUNCIONERR;
             END IF;
        WHEN TOO_MANY_ROWS THEN
             IF p_nOp_busca = G_NOPBUSQDISPSRL OR p_nOp_busca = G_NOPBUSQDISPCRL THEN
                 RAISE_APPLICATION_ERROR(-20104,'ERROR FA_BUSCA_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
             ELSE
                 p_nEstado_folio := G_NMUCHAS_FILAS;
                 p_nEst_funcion  := G_NESTADO_FUNCIONERR;
             END IF;
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20104,'ERROR FA_BUSCA_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
    END FA_BUSCA_FOLIO_PR;

    /* ------------------------------- PRIMITIVA  PROCEDURE FA_BUSCA_CONSUMO_PR ------------------------------- */

    PROCEDURE FA_BUSCA_CONSUMO_PR( p_nTipo_documento IN NUMBER  ,p_nCod_vendedor    IN NUMBER  , p_vCod_oficina IN VARCHAR2
                                 , p_vCod_operadora  IN VARCHAR2,p_vPrefijo_folio   IN VARCHAR2, p_nCorrela_folio IN NUMBER
                                 , p_nEstado_folio  OUT NUMBER  ,p_nEstado_funcion OUT NUMBER)
    AS
        error_proceso   EXCEPTION;
        LV_vMSG_SALIDA              VARCHAR2(100);
        LV_vSQLCmd                  VARCHAR2(1000);
        LN_nANULADO                 NUMBER(1);
        LV_vPrefijo_folio           AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
        p_nTipo_documentoConvertido FA_TIPDOCUMEN.COD_TIPDOCUM%TYPE;

    BEGIN

        FA_INICIALIZA_PR;
        LV_vMSG_SALIDA    := G_VALOR_RESET_VARCHAR;
        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
        p_nEstado_funcion := G_NESTADO_FUNCIONERR;
        p_nEstado_folio   := G_VALOR_RESET_NUMBER;
        LN_nANULADO       := G_VALOR_RESET_NUMBER;
        LV_vPrefijo_folio := G_VALOR_RESET_VARCHAR;

        IF  p_nTipo_documento IS NULL
         OR p_vCod_operadora  IS NULL
         OR p_nCorrela_folio  IS NULL
         OR p_vPrefijo_folio  IS NULL THEN
             LV_vMSG_SALIDA :=G_VDESC_FALTAPARAM;
             RAISE error_proceso;
        END IF;

        IF p_vPrefijo_folio IS NULL THEN
                LV_vPrefijo_folio := 'IS NULL';
        ELSE
                LV_vPrefijo_folio := p_vPrefijo_folio;
                LV_vPrefijo_folio := '='|| '''' || LV_vPrefijo_folio;
        END IF;

        p_nTipo_documentoConvertido := FA_DOCUMENTO_CONSUMO_FN(p_nTipo_documento);


        LV_vSQLCmd := 'SELECT IND_ANULACION FROM AL_CONSUMO_DOCUMENTOS ';
        LV_vSQLCmd := LV_vSQLCmd||' WHERE COD_OPERADORA = '''||p_vCod_operadora||'''';
        LV_vSQLCmd := LV_vSQLCmd||'   AND COD_OFICINA   = '''||p_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||'   AND TIP_DOCUM     = '||p_nTipo_documentoConvertido;
         LV_vSQLCmd := LV_vSQLCmd||'   AND PREF_PLAZA  '||LV_vPrefijo_folio||'''';
        LV_vSQLCmd := LV_vSQLCmd||'   AND NUM_FOLIO     = '||p_nCorrela_folio;

        LV_vPrefijo_folio := p_vPrefijo_folio;

        EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nANULADO;

        IF LN_nANULADO = G_NESTADO_FOLCONSUMIDO THEN
            p_nEstado_folio   := G_NESTADO_CONSUMIDO;
        ELSIF LN_nANULADO = G_NESTADO_FOLANULADO THEN
            p_nEstado_folio   := G_NESTADO_ANULADO;
        ELSE
            p_nEstado_folio   := G_NESTADO_INDEFINIDO;
        END IF;

        p_nEstado_funcion := G_NESTADO_FUNCIONOK;

    EXCEPTION
        WHEN error_proceso THEN
            RAISE_APPLICATION_ERROR(-20101,'ERROR FA_BUSCA_CONSUMO_PR : '||LV_vMSG_SALIDA||' '||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
        WHEN NO_DATA_FOUND THEN
            p_nEstado_folio     := G_NESTADO_FOLIONOENC;
        WHEN TOO_MANY_ROWS THEN
            p_nEstado_folio := G_NMUCHAS_FILAS;
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20103,'ERROR FA_BUSCA_CONSUMO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
    END FA_BUSCA_CONSUMO_PR;

    /*--------------------------------------    PRIMITIVA   PROCEDIMIENTO FA_CONSUME_FOLIO_PR     -----------------------------------*/

    PROCEDURE  FA_CONSUME_FOLIO_PR (p_nTipo_documento IN NUMBER  ,p_nCod_vendedor  IN NUMBER  ,p_vCod_oficina   IN VARCHAR2
                                   ,p_vCod_operadora  IN VARCHAR2,p_vPrefijo_folio IN VARCHAR2,p_nCorrela_folio IN NUMBER
                                   ,p_nNum_venta      IN NUMBER  ,p_nNum_proceso   IN NUMBER  ,p_dfecha_consumo IN DATE
                                   ,p_nEstado_Ret    OUT NUMBER  ,p_nRango_inicial IN NUMBER
                                   ,p_vResolucion     IN VARCHAR2,p_dFec_Resolucion IN DATE   ,p_vSerie         IN VARCHAR2
                                   ,p_vEtiqueta       IN VARCHAR2,p_dFec_CreaFolio IN DATE    ,p_dFec_Asigna    IN DATE
                                   ,p_nRan_Desde      IN NUMBER  ,p_vInd_Consumo   IN VARCHAR2 DEFAULT 'A'
                                   )
    AS
     PRAGMA AUTONOMOUS_TRANSACTION;

     Error_proceso    EXCEPTION;
     LV_vMSG_SALIDA    VARCHAR2(100);
     LV_vSQLCmd        VARCHAR2(1000);
     LV_vPrefijo_folio AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;

    BEGIN

        FA_INICIALIZA_PR;
        LV_vMSG_SALIDA     := G_VALOR_RESET_VARCHAR;
        LV_vSQLCmd         := G_VALOR_RESET_VARCHAR;
        LV_vPrefijo_folio  := G_VALOR_RESET_VARCHAR;
        p_nEstado_Ret      := G_NESTADO_FUNCIONERR;


        IF  p_nTipo_documento   IS NULL
            OR p_vCod_operadora IS NULL
            OR p_nCorrela_folio IS NULL
            OR p_vCod_oficina   IS NULL
            OR p_dfecha_consumo IS NULL THEN
               LV_vMSG_SALIDA := G_VDESC_FALTAPARAM;
               RAISE error_proceso;
        END IF;

        IF SQLCODE <> 0 THEN
            LV_vMSG_SALIDA := G_VNOFOUND_USUARIO;
            RAISE Error_proceso;
        END IF;

        INSERT INTO SISCEL.AL_CONSUMO_DOCUMENTOS (
                        COD_OFICINA,
                        TIP_DOCUM,
                        NUM_FOLIO,
                        USU_CONSUMO,
                        FEC_CONSUMO,
                        IND_CONSUMO,
                        IND_ANULACION,
                        COD_VENDEDOR,
                        COD_ESTADO,
                        IND_LIBROIVA,
                        COD_OPERADORA,
                        PREF_PLAZA,
                        NUM_VENTA,
                        NUM_PROCESO,
                        RESOLUCION,
                        FEC_RESOLUCION,
                        SERIE,
                        ETIQUETA,
                        FEC_CREAFOLIO
                        )
            VALUES (
                        p_vCod_oficina,
                        p_nTipo_documento,
                        p_nCorrela_folio,
                        USER,
                        p_dfecha_consumo,
                        'A',
                        0,
                        p_nCod_vendedor,
                        'F',
                        0,
                        p_vCod_operadora,
                        p_vPrefijo_folio,
                        p_nNum_venta,
                        p_nNum_proceso,
                        p_vResolucion,
                        p_dFec_Resolucion,
                        p_vSerie,
                        p_vEtiqueta,
                        p_dFec_CreaFolio
                        );

        IF SQLCODE <> 0 THEN
            LV_vMSG_SALIDA := G_NOINSERTO_CONSUMO;
            RAISE Error_proceso;
        END IF;

     IF p_vPrefijo_folio IS NULL
    THEN
        LV_vPrefijo_folio := 'IS NULL';
     ELSE
       LV_vPrefijo_folio := p_vPrefijo_folio;
       LV_vPrefijo_folio := '='|| '''' || LV_vPrefijo_folio;
     END IF;

     LV_vSQLCmd := 'UPDATE AL_ASIG_DOCUMENTOS SET RAN_USADO = '||p_nCorrela_folio;
     LV_vSQLCmd := LV_vSQLCmd||' WHERE COD_TIPDOCUM = '||p_nTipo_documento;
     LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||'''';
     LV_vSQLCmd := LV_vSQLCmd||' AND PREF_PLAZA  '||LV_vPrefijo_folio||'''';
     LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA = '''||p_vCod_oficina||'''';
     LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = '||p_nRango_inicial;

     IF p_nCod_vendedor IS NOT NULL
    THEN
         LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
     ELSE
         LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
     END IF;
    LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
    
    LV_vPrefijo_folio := p_vPrefijo_folio;

    EXECUTE IMMEDIATE LV_vSQLCmd;

    IF SQL%ROWCOUNT <> 0
    THEN
       p_nEstado_Ret := G_NESTADO_FUNCIONOK;
       COMMIT;
    END IF;

    EXCEPTION
        WHEN error_proceso THEN
            RAISE_APPLICATION_ERROR(-20101,'ERROR FA_CONSUME_FOLIO_PR : '||LV_vMSG_SALIDA||' '||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20103,'ERROR FA_CONSUME_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
    END FA_CONSUME_FOLIO_PR;

    /*---------------------------    PRIMITIVA   PROCEDIMIENTO FA_ANULA_FOLIO_PR   -------------------------------------------------*/

    PROCEDURE FA_ANULA_FOLIO_PR (p_nTipo_documento IN NUMBER  ,p_nCod_vendedor  IN NUMBER  , p_vCod_oficina   IN VARCHAR2
                                ,p_vCod_operadora  IN VARCHAR2,p_vPrefijo_folio IN VARCHAR2, p_nCorrela_folio IN NUMBER
                                ,p_nEstado_folio  OUT NUMBER  ,p_nEstado_Ret   OUT NUMBER)
    AS
     PRAGMA AUTONOMOUS_TRANSACTION;

        error_proceso    EXCEPTION;
        LV_vMSG_SALIDA    VARCHAR2(100);
        LV_vSQLCmd        VARCHAR2(1000);
        LV_vPrefijo_folio AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;

    BEGIN

        FA_INICIALIZA_PR;

        LV_vMSG_SALIDA    := G_VALOR_RESET_VARCHAR;
        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
        LV_vPrefijo_folio := G_VALOR_RESET_VARCHAR;
        p_nEstado_Ret     := G_NESTADO_FUNCIONERR;
        p_nEstado_folio   := G_NESTADO_FOLIONOENC;

        IF  p_nTipo_documento   IS NULL
            OR p_vCod_operadora IS NULL
            OR p_nCorrela_folio IS NULL  THEN
               LV_vMSG_SALIDA :=  G_VDESC_FALTAPARAM;
               RAISE error_proceso;
        END IF;


        IF p_vPrefijo_folio IS NULL THEN
                LV_vPrefijo_folio := 'IS NULL';
        ELSE
                LV_vPrefijo_folio := p_vPrefijo_folio;
                LV_vPrefijo_folio := '='|| '''' || LV_vPrefijo_folio;
        END IF;

        LV_vSQLCmd := 'UPDATE AL_CONSUMO_DOCUMENTOS SET IND_ANULACION = 1 ';
        LV_vSQLCmd := LV_vSQLCmd||' WHERE TIP_DOCUM = '||p_nTipo_documento;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||'''';
         LV_vSQLCmd := LV_vSQLCmd||' AND PREF_PLAZA  '||LV_vPrefijo_folio||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND NUM_FOLIO = '||p_nCorrela_folio;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA = '''||p_vCod_oficina||'''';


        IF p_nCod_vendedor IS NOT NULL
        THEN
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
         ELSE
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
         END IF;

        LV_vPrefijo_folio := p_vPrefijo_folio;

        EXECUTE IMMEDIATE LV_vSQLCmd;

        IF SQL%ROWCOUNT <> 0 THEN
            p_nEstado_Ret   := G_NESTADO_FUNCIONOK;
            p_nEstado_folio := G_NESTADO_ANULADO;
               COMMIT;
        ELSE
            LV_vMSG_SALIDA := G_VMSG_FOLIONOENC;
            RAISE error_proceso;
        END IF;

    EXCEPTION
        WHEN error_proceso THEN
             RAISE_APPLICATION_ERROR(-20101,'ERROR FA_ANULA_FOLIO_PR : '||LV_vMSG_SALIDA||' '||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20103,'ERROR FA_ANULA_FOLIO_PR :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
    END FA_ANULA_FOLIO_PR;

    /* ---------------------------------------   FUNCION FA_CONSULTA_FOLIO_FN ------------------------------------- */

    FUNCTION FA_CONSULTA_FOLIO_FN(p_ntipo_documento IN NUMBER , p_nCod_vendedor  IN NUMBER, p_vCod_oficina IN VARCHAR,
                                  p_vCod_operadora  IN VARCHAR, p_vprefijo_folio IN VARCHAR,p_ncorrela_folio IN NUMBER,
                                  p_nRango_inicial  IN NUMBER , p_nop_consulta   IN NUMBER, p_vInd_Consumo IN VARCHAR2 DEFAULT 'A')
    RETURN VARCHAR IS

       LN_ncorrela_folio  NUMBER(9);
       LN_nestado_folio   NUMBER;
       LN_nest_funcion    NUMBER;
       LN_nRango_inicial  NUMBER(9);
       LV_vCod_oficina    GE_OFICINAS.COD_OFICINA%TYPE;
       LV_vPrefijo_folio  AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
       LV_vResolucion     AL_ASIG_DOCUMENTOS.RESOLUCION%TYPE;
       LD_dFec_Resolucion AL_ASIG_DOCUMENTOS.FEC_RESOLUCION%TYPE;
       LV_vSerie          AL_ASIG_DOCUMENTOS.SERIE%TYPE;
       LV_vEtiqueta       AL_ASIG_DOCUMENTOS.ETIQUETA%TYPE;
       LD_dFec_CreaFolio  AL_ASIG_DOCUMENTOS.FEC_CREAFOLIO%TYPE;
       LD_dFec_Asigna     AL_ASIG_DOCUMENTOS.FEC_ASIGNA%TYPE;
       LN_nRan_Hasta      AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;
       LV_paramconsumoManual fad_parametros.val_caracter%TYPE;

    BEGIN

       FA_INICIALIZA_PR;
       LV_vprefijo_folio  :=G_VALOR_RESET_VARCHAR;
       LN_ncorrela_folio  :=G_VALOR_RESET_NUMBER;
       LN_nestado_folio   :=G_VALOR_RESET_NUMBER;
       LN_nest_funcion    :=G_VALOR_RESET_NUMBER;
       LN_nRango_inicial  :=G_VALOR_RESET_NUMBER;
       LV_vResolucion     :=G_VALOR_RESET_VARCHAR;
       LV_vSerie          :=G_VALOR_RESET_VARCHAR;
       LV_vEtiqueta       :=G_VALOR_RESET_VARCHAR;
       LD_dFec_Resolucion :=G_VALOR_RESET_DATE;
       LD_dFec_CreaFolio  :=G_VALOR_RESET_DATE;
       LD_dFec_Asigna     :=G_VALOR_RESET_DATE;
       LN_nRan_Hasta      :=G_VALOR_RESET_NUMBER;

       --LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
        IF p_vInd_Consumo = CV_consumo_manual THEN
            LV_paramconsumoManual:= FA_OBTIENE_PARAMETRO_FN(CV_param_cons_manual, CV_modulo);
            IF LV_paramconsumoManual = 'N' THEN
             LV_vCod_oficina := p_vCod_oficina;
            ELSE
             LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);       
            END IF;  
        ELSE
            LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
        END IF;

       IF p_nop_consulta = G_NOPBUSQPUNTUAL THEN
          FA_BUSCA_CONSUMO_PR(p_ntipo_documento
                             ,p_nCod_vendedor
                             ,LV_vCod_oficina
                             ,p_vcod_operadora
                             ,p_vprefijo_folio
                             ,p_ncorrela_folio
                             ,LN_nestado_folio
                             ,LN_nest_funcion);
          RETURN TO_CHAR(LN_nestado_folio)||G_CSEPARADOR||p_vprefijo_folio||G_CSEPARADOR||TO_CHAR(p_ncorrela_folio);
       ELSIF p_nop_consulta = G_NOPBUSQDISPSR
          OR p_nop_consulta = G_NOPBUSQDISPCR  THEN          
             FA_BUSQUEDA_FOLIO_PR(p_ntipo_documento
                                 ,p_nCod_vendedor
                                 ,LV_vCod_oficina
                                 ,p_vCod_operadora
                                 ,p_nRango_inicial
                                 ,p_nop_consulta
                                 ,LV_vprefijo_folio
                                 ,LN_ncorrela_folio
                                 ,LN_nestado_folio
                                 ,LN_nest_funcion
                                 ,LN_nRango_inicial
                                 ,p_vInd_Consumo);
                              
             RETURN TO_CHAR(LN_nestado_folio)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_ncorrela_folio);
       ELSE
             RAISE_APPLICATION_ERROR(-20104,'ERROR PARAMETRO DE TIPO CONSULTA ERRONEO');
       END IF;

    END FA_CONSULTA_FOLIO_FN;

/* ---------------------------------------   FUNCION FA_CONSUME_FOLIO_FN ------------------------------------- */
FUNCTION FA_CONSUME_FOLIO_FN( p_ntipo_documento IN NUMBER,
                              p_nCod_vendedor   IN NUMBER,
                              p_vCod_oficina    IN VARCHAR,
                              p_vCod_operadora  IN VARCHAR,
                              p_nRango_inicial  IN NUMBER,
                              p_nNumero_venta   IN NUMBER,
                              p_nNumero_proceso IN NUMBER,
                              p_dfecha_proceso  IN DATE,
                              p_nop_consumo     IN NUMBER,
                              p_vInd_Consumo    IN VARCHAR2 DEFAULT 'A')
RETURN VARCHAR IS

    PRAGMA AUTONOMOUS_TRANSACTION;
    error_proceso          EXCEPTION;

    LV_vSQLCmd                  VARCHAR(1000);
    LV_vPrefijo_folio           AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
    LV_vCod_oficina             GE_OFICINAS.COD_OFICINA%TYPE;
    LV_vMSG_SALIDA                    VARCHAR2(100);
    LV_vPrefijoFolio             AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
    LV_vResolucion              AL_ASIG_DOCUMENTOS.RESOLUCION%TYPE;
    LV_vSerie                   AL_ASIG_DOCUMENTOS.SERIE%TYPE;
    LV_vEtiqueta                AL_ASIG_DOCUMENTOS.ETIQUETA%TYPE;
    LN_ncorrela_folio           NUMBER(9);
    LN_nestado_folio            NUMBER;
    LN_nretorno_busc            NUMBER;
    LN_nretorno_cons            NUMBER;
    LN_nOpcion_busqueda         NUMBER;
    LN_nDesde                    AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
    LN_nRango                      AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
    p_nTipo_documentoConvertido FA_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
    LN_nRanDesde                AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
    LN_nRanHasta                AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;
    LD_dFecCreaFolio            AL_ASIG_DOCUMENTOS.FEC_CREAFOLIO%TYPE;
    LD_dFecAsigna               AL_ASIG_DOCUMENTOS.FEC_ASIGNA%TYPE;
    LD_dFecResolucion           AL_ASIG_DOCUMENTOS.FEC_RESOLUCION%TYPE;
    LV_paramconsumoManual fad_parametros.val_caracter%TYPE;

BEGIN

    FA_INICIALIZA_PR;

    LV_vPrefijo_folio           := G_VALOR_RESET_VARCHAR;
    LN_nCorrela_folio           := G_VALOR_RESET_NUMBER;
    LN_nEstado_folio            := G_VALOR_RESET_NUMBER;
    LN_nDesde                   := G_VALOR_RESET_NUMBER;
    LV_vMSG_SALIDA              := G_VALOR_RESET_VARCHAR;
    LV_vSQLCmd                  := G_VALOR_RESET_VARCHAR;
    LN_nRetorno_busc            := G_NESTADO_FUNCIONERR;
    LV_vPrefijoFolio            := G_VALOR_RESET_VARCHAR;
    LN_nRango                     := G_VALOR_RESET_NUMBER;
    LV_vResolucion              := G_VALOR_RESET_VARCHAR;
    LV_vSerie                   := G_VALOR_RESET_VARCHAR;
    LV_vEtiqueta                := G_VALOR_RESET_VARCHAR;
    p_nTipo_documentoConvertido := G_VALOR_RESET_NUMBER;
    LN_nRanDesde                := G_VALOR_RESET_NUMBER;
    LN_nRanHasta                := G_VALOR_RESET_NUMBER;
    LD_dFecCreaFolio            := G_VALOR_RESET_DATE;
    LD_dFecAsigna               := G_VALOR_RESET_DATE;
    LD_dFecResolucion           := G_VALOR_RESET_DATE;

    /* Se asume con lock de registro */
    /* Validación de Parametros de Ingreso a la función */
    IF (  p_vCod_oficina     IS NULL
       OR p_nTipo_documento IS NULL
       OR p_vCod_operadora  IS NULL )
    THEN
        LV_vMSG_SALIDA := G_VDESC_FALTAPARAM ||'dos';
        RAISE error_proceso;
    END IF;


    --LV_vCod_oficina             := FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    IF p_vInd_Consumo = CV_consumo_manual THEN
        LV_paramconsumoManual:= FA_OBTIENE_PARAMETRO_FN(CV_param_cons_manual, CV_modulo);
        IF LV_paramconsumoManual = 'N' THEN
         LV_vCod_oficina := p_vCod_oficina;
        ELSE
         LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);       
        END IF;  
    ELSE
        LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    END IF;    
    p_nTipo_documentoConvertido := FA_DOCUMENTO_CONSUMO_FN(p_nTipo_documento);

    /*************************************************************************/
    BEGIN

        IF (p_nRango_inicial = 0) OR (p_nRango_inicial IS NULL)
        THEN -- Se requiere consumir folios
            ---------------------------------------------------------------
            --OBTENCION DEL RANGO DESDE MENOR SEGUN PARAMETROS ENTREGADOS--
            ---------------------------------------------------------------
            LV_vSQLCmd := 'SELECT  MIN (RAN_DESDE) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||LV_vCod_oficina||'''';
            LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';

            IF  p_nCod_vendedor IS NOT NULL
            THEN
                LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
            ELSE
                LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
            END IF;
            LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
            
            EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nDesde;

            IF LN_nDesde IS NULL THEN
               RAISE NO_DATA_FOUND;
            END IF;
        ELSE
              LN_nDesde :=  p_nRango_inicial;
        END IF;

        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
        -----------------------------------------------------------------
        --SELECCION DE FECHA RESOLUCION
        -----------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  MIN (FEC_RESOLUCION) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||LV_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = ' ||LN_nDesde;

        IF  p_nCod_vendedor IS NOT NULL
        THEN
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
        
        EXECUTE IMMEDIATE LV_vSQLCmd INTO LD_dFecResolucion;

        IF LD_dFecResolucion IS NULL THEN

           LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
           -----------------------------------------------------------------
           --SELECCION DE FECHA CREACION FOLIO (DOCUMENTOS DE PAGO)
           -----------------------------------------------------------------
           LV_vSQLCmd := 'SELECT  MIN (FEC_ASIGNA) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
           LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
           LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||LV_vCod_oficina||'''';
           LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
           LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = ' ||LN_nDesde;

           IF  p_nCod_vendedor IS NOT NULL
           THEN
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
           ELSE
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
           END IF;
           LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
           
           EXECUTE IMMEDIATE LV_vSQLCmd INTO LD_dFecAsigna;

           IF LD_dFecAsigna IS NULL THEN
              RAISE NO_DATA_FOUND;
           END IF;

        END IF;


        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
        -----------------------------------------------------------------
        --SELECCION DE FOLIO SEGUN EL RANGO DESDE OBTENIDO Y PARAMETROS--
        -----------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  RAN_USADO, PREF_PLAZA, RESOLUCION,';
        LV_vSQLCmd := LV_vSQLCmd||'SERIE, ETIQUETA, FEC_CREAFOLIO, FEC_ASIGNA, RAN_DESDE, RAN_HASTA';
        LV_vSQLCmd := LV_vSQLCmd||' FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||LV_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE     = '||LN_nDesde||' ' ;

        IF LD_dFecResolucion IS NULL THEN
           LV_vSQLCmd := LV_vSQLCmd||' AND FEC_ASIGNA  = TO_DATE('''||TO_CHAR(LD_dFecAsigna,'DD-MM-YYYY HH24:MI:SS')||''',''DD-MM-YYYY HH24:MI:SS'')';
        ELSE
           LV_vSQLCmd := LV_vSQLCmd||' AND FEC_RESOLUCION  = TO_DATE('''||TO_CHAR(LD_dFecResolucion,'DD-MM-YYYY')||''',''DD-MM-YYYY'')';
        END IF;


        IF  p_nCod_vendedor IS NOT NULL
        THEN
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
        ---------------------------------------------------------------
        -- ES CONSULTA DEBE LOCKEAR--------------------
        ---------------------------------------------------------------
        LV_vSQLCmd := LV_vSQLCmd||' FOR UPDATE';
        ---------------------------------------------------------------

        EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nRango,LV_vPrefijo_folio,LV_vResolucion,
                                          LV_vSerie,LV_vEtiqueta,
                                          LD_dFecCreaFolio, LD_dFecAsigna,
                                          LN_nRanDesde,LN_nRanHasta;

        LN_nCorrela_folio := LN_nRango + 1;
        LN_nEstado_folio  := G_NESTADO_DISPONIBLE;
        LN_nRetorno_busc  := G_NESTADO_FUNCIONOK ;

     EXCEPTION
        WHEN error_proceso THEN
            RAISE_APPLICATION_ERROR (-20101,'ERROR FA_CONSUME_FOLIO_FN : '||LV_vMSG_SALIDA);
        WHEN NO_DATA_FOUND THEN
                LN_nEstado_folio   := G_NESTADO_FOLIONOENC;
                LN_nRetorno_busc   := G_NESTADO_FUNCIONERR;
                RAISE_APPLICATION_ERROR(-20102,'ERROR FA_CONSUME_FOLIO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRARON FOLIOS DISPONIBLES');
        WHEN TOO_MANY_ROWS THEN
                 LN_nEstado_folio  := G_NMUCHAS_FILAS;
                 LN_nRetorno_busc  := G_NESTADO_FUNCIONERR;
                 RAISE_APPLICATION_ERROR(-20103,'ERROR FA_CONSUME_FOLIO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20104,'ERROR FA_CONSUME_FOLIO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
    END;

    /*************************************************************************/

    IF LN_nRetorno_busc = G_NESTADO_FUNCIONOK AND LN_nEstado_folio = G_NESTADO_DISPONIBLE
    THEN
       IF SQLCODE <> 0 THEN
          LV_vMSG_SALIDA := G_VNOFOUND_USUARIO;
          RAISE Error_proceso;
       END IF;
       /**********************/
       BEGIN

            INSERT INTO AL_CONSUMO_DOCUMENTOS (
                            COD_OFICINA,
                            TIP_DOCUM,
                            NUM_FOLIO,
                            USU_CONSUMO,
                            FEC_CONSUMO,
                            IND_CONSUMO,
                            IND_ANULACION,
                            COD_VENDEDOR,
                            COD_ESTADO,
                            IND_LIBROIVA,
                            COD_OPERADORA,
                            PREF_PLAZA,
                            NUM_VENTA,
                            NUM_PROCESO,
                            RESOLUCION,
                            FEC_RESOLUCION,
                            SERIE,
                            ETIQUETA,
                            FEC_CREAFOLIO
                            )
                VALUES (    LV_vCod_oficina,
                            p_nTipo_documento,
                            LN_nCorrela_folio,
                            USER,
                            p_dfecha_proceso,
                            'A',
                            0,
                            p_nCod_vendedor,
                            'F',
                            0,
                            p_vCod_operadora,
                            LV_vPrefijo_folio,
                            p_nNumero_venta,
                            p_nNumero_proceso,
                            LV_vResolucion,
                            LD_dFecResolucion,
                            LV_vSerie,
                            LV_vEtiqueta,
                            LD_dFecCreaFolio
                            );

            IF SQLCODE <> 0 THEN
                LV_vMSG_SALIDA := G_NOINSERTO_CONSUMO;
                RAISE Error_proceso;
            END IF;

             IF LV_vPrefijo_folio IS NULL THEN
                 LV_vPrefijoFolio := 'IS NULL';
             ELSE
                LV_vPrefijoFolio := '='|| '''' || LV_vPrefijo_folio;
             END IF;

             LV_vSQLCmd := 'UPDATE AL_ASIG_DOCUMENTOS SET RAN_USADO = '||LN_nCorrela_folio;
             LV_vSQLCmd := LV_vSQLCmd||' WHERE COD_TIPDOCUM          = '||p_nTipo_documentoConvertido;
             LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA           = '''||p_vCod_operadora||'''';
             LV_vSQLCmd := LV_vSQLCmd||' AND PREF_PLAZA  '||LV_vPrefijoFolio||'''';
             LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA             = '''||LV_vCod_oficina||'''';
             LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE               = '||LN_nDesde;

             IF p_nCod_vendedor IS NOT NULL
            THEN
                 LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
             ELSE
                 LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
             END IF;
             LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';

            EXECUTE IMMEDIATE LV_vSQLCmd;

            IF SQL%ROWCOUNT <> 0 THEN
                COMMIT;
                LN_nRetorno_cons := G_NESTADO_FUNCIONOK;
            ELSE
                ROLLBACK;
                LN_nRetorno_cons := G_NESTADO_FUNCIONERR;
            END IF;


        EXCEPTION
            WHEN error_proceso THEN
                RAISE_APPLICATION_ERROR(-20101,'ERROR FA_CONSUME_FOLIO_FN : '||LV_vMSG_SALIDA||' '||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20103,'ERROR FA_CONSUME_FOLIO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
        END;

/****************************************************************************************/

        IF LN_nRetorno_cons = G_NESTADO_FUNCIONOK THEN
            RETURN TO_CHAR(G_NESTADO_CONSUMIDO)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||NVL(LV_vEtiqueta,' ')||G_CSEPARADOR||
                   TO_CHAR(LN_nRanDesde)||G_CSEPARADOR||TO_CHAR(LN_nRanHasta)||G_CSEPARADOR||
                   NVL(TO_CHAR(LD_dFecResolucion,'DD-MM-YYYY'),' ')||G_CSEPARADOR;
        ELSE
            RETURN TO_CHAR(G_NFOLIO_NOCONSUMIDO)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||NVL(LV_vEtiqueta,' ')||G_CSEPARADOR||
                   TO_CHAR(LN_nRanDesde)||G_CSEPARADOR||TO_CHAR(LN_nRanHasta)||G_CSEPARADOR||
                   NVL(TO_CHAR(LD_dFecResolucion,'DD-MM-YYYY'),' ')||G_CSEPARADOR;
        END IF;
    ELSE
        RETURN TO_CHAR(LN_nEstado_folio)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||NVL(LV_vEtiqueta,' ')||G_CSEPARADOR||
                   TO_CHAR(LN_nRanDesde)||G_CSEPARADOR||TO_CHAR(LN_nRanHasta)||G_CSEPARADOR||
                   NVL(TO_CHAR(LD_dFecResolucion,'DD-MM-YYYY'),' ')||G_CSEPARADOR;
    END IF;

END FA_CONSUME_FOLIO_FN;

/* ---------------------------------------   FUNCION FA_ANULA_FOLIO_FN ------------------------------------- */
FUNCTION FA_ANULA_FOLIO_FN( p_ntipo_documento   IN NUMBER ,
                            p_nCod_vendedor     IN NUMBER ,
                            p_vCod_oficina      IN VARCHAR,
                            p_vCod_operadora    IN VARCHAR,
                            p_vprefijo_folio    IN VARCHAR,
                            p_ncorrela_folio    IN NUMBER,
                            p_vInd_Consumo      IN VARCHAR2 DEFAULT 'NULL' )
RETURN VARCHAR IS

    LN_nestado_ret   NUMBER;
    LN_nestado_folio NUMBER;
    LV_vCod_oficina  GE_OFICINAS.COD_OFICINA%TYPE;
    LV_paramconsumoManual fad_parametros.val_caracter%TYPE;
    LN_cant NUMBER;

BEGIN

    FA_INICIALIZA_PR;
    LN_nestado_ret   := G_NESTADO_FUNCIONERR;
    LN_nestado_folio := G_VALOR_RESET_NUMBER;

    --LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    LV_paramconsumoManual:= FA_OBTIENE_PARAMETRO_FN(CV_param_cons_manual, CV_modulo);
    IF p_vInd_Consumo = CV_consumo_manual THEN
        IF LV_paramconsumoManual = 'N' THEN
         LV_vCod_oficina := p_vCod_oficina;
        ELSE
         LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);       
        END IF;  
    ELSE
        IF p_vInd_Consumo = CV_consumo_automatico THEN
            LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
        ELSE
            IF LV_paramconsumoManual = 'N' THEN
                --Valida si existe en tabla de pre-foliados. Si existe implica que es manual
                SELECT COUNT(1)
                INTO LN_cant
                FROM al_consumo_documentos a
                WHERE num_folio =  p_ncorrela_folio
                AND pref_plaza = p_vprefijo_folio 
                AND tip_docum = p_ntipo_documento
                AND cod_operadora = p_vCod_operadora
                AND cod_oficina IS NOT NULL
                AND exists(
                    SELECT 1 FROM fa_prefoliados
                    WHERE num_folio = p_ncorrela_folio
                    AND cod_tipdocum = p_ntipo_documento
                    AND pref_plaza = a.pref_plaza
                    AND serie = a.serie
                    AND resolucion = a.resolucion
                    AND cod_tipdocum = a.tip_docum
                    AND (etiqueta = a.etiqueta OR etiqueta IS NULL));
                IF LN_cant > 0 THEN
                     LV_vCod_oficina := p_vCod_oficina;                
                ELSE
                    LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
                END IF;
            ELSE
                LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
            END IF;    
        END IF;
    END IF;    
    FA_ANULA_FOLIO_PR   (p_ntipo_documento
                        ,p_nCod_vendedor
                        ,LV_vCod_oficina
                        ,p_vCod_operadora
                        ,p_vprefijo_folio
                        ,p_ncorrela_folio
                        ,LN_nestado_folio
                        ,LN_nestado_ret);

    RETURN TO_CHAR(LN_nestado_folio)||G_CSEPARADOR||p_vprefijo_folio||G_CSEPARADOR||TO_CHAR(p_ncorrela_folio);

END FA_ANULA_FOLIO_FN;

/* --------------------------------------- FA_CONSUME_FOLIOPUNTUAL_FN ------------------------------------------ */

FUNCTION FA_CONSUME_FOLIOPUNTUAL_FN( p_ntipo_documento IN NUMBER
                                   , p_nCod_vendedor   IN NUMBER
                                   , p_vCod_oficina    IN VARCHAR
                                   , p_vCod_operadora  IN VARCHAR
                                   , p_nRango_inicial  IN NUMBER
                                   , p_nNumero_venta   IN NUMBER
                                   , p_nNumero_proceso IN NUMBER
                                   , p_dfecha_proceso  IN DATE
                                   , p_nop_consumo     IN NUMBER
                                   , p_vPrefijo_folio  IN VARCHAR
                                   , p_ncorrela_folio  IN NUMBER
                                   , p_vInd_Consumo    IN VARCHAR2 DEFAULT 'A'
                                  )
RETURN VARCHAR IS

    LV_vPrefijo_folio   AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
    LN_ncorrela_folio   NUMBER(9);
    LN_nestado_folio    NUMBER;
    LN_nretorno_busc    NUMBER;
    LN_nretorno_cons    NUMBER;
    LN_nOpcion_busqueda NUMBER;
    LN_nRango_inicial   AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
    LV_vCod_oficina     GE_OFICINAS.COD_OFICINA%TYPE;
    LV_vResolucion      AL_ASIG_DOCUMENTOS.RESOLUCION%TYPE;
    LD_dFec_Resolucion  AL_ASIG_DOCUMENTOS.FEC_RESOLUCION%TYPE;
    LV_vSerie           AL_ASIG_DOCUMENTOS.SERIE%TYPE;
    LV_vEtiqueta        AL_ASIG_DOCUMENTOS.ETIQUETA%TYPE;
    LD_dFec_CreaFolio   AL_ASIG_DOCUMENTOS.FEC_CREAFOLIO%TYPE;
    LD_dFec_Asigna      AL_ASIG_DOCUMENTOS.FEC_ASIGNA%TYPE;
    LN_nRan_Hasta       AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;
    LV_paramconsumoManual FAD_PARAMETROS.VAL_CARACTER%TYPE;

BEGIN

    FA_INICIALIZA_PR;
    LV_vPrefijo_folio   :=G_VALOR_RESET_VARCHAR;
    LN_ncorrela_folio   :=G_VALOR_RESET_NUMBER;
    LN_nestado_folio    :=G_VALOR_RESET_NUMBER;
    LN_nRango_inicial   :=G_VALOR_RESET_NUMBER;
    LN_nretorno_busc    :=G_VALOR_RESET_NUMBER;
    LN_nretorno_cons    :=G_VALOR_RESET_NUMBER;
    LN_nOpcion_busqueda :=G_VALOR_RESET_NUMBER;
    LV_vResolucion      :=G_VALOR_RESET_VARCHAR;
    LD_dFec_Resolucion  :=G_VALOR_RESET_DATE;
    LV_vSerie           :=G_VALOR_RESET_VARCHAR;
    LV_vEtiqueta        :=G_VALOR_RESET_VARCHAR;
    LD_dFec_CreaFolio   :=G_VALOR_RESET_DATE;
    LD_dFec_Asigna      :=G_VALOR_RESET_DATE;
    LN_nRan_Hasta       :=G_VALOR_RESET_NUMBER;

    LV_vPrefijo_folio   := p_vPrefijo_folio;

    IF p_nop_consumo = G_NOPCIONCONSUMOSR --(1)
    THEN
        LN_nOpcion_busqueda := G_NOPBUSQDISPSRL;-- (4)
    ELSE
        LN_nOpcion_busqueda := G_NOPBUSQDISPCRL;--(5)
    END IF;

    IF p_vInd_Consumo = CV_consumo_manual THEN
        LV_paramconsumoManual:= FA_OBTIENE_PARAMETRO_FN(CV_param_cons_manual, CV_modulo);
        IF LV_paramconsumoManual = 'N' THEN
         LV_vCod_oficina := p_vCod_oficina;
        ELSE
         LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);       
        END IF;  
    ELSE
        LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    END IF;

    FA_BUSCA_FOLIO_PR(p_ntipo_documento
                     ,p_nCod_vendedor
                     ,LV_vCod_oficina
                     ,p_vCod_operadora
                     ,p_nRango_inicial
                     ,LN_nOpcion_busqueda
                     ,p_vPrefijo_folio
                     ,LN_ncorrela_folio
                     ,LN_nestado_folio
                     ,LN_nretorno_busc
                     ,LN_nRango_inicial
                     ,LV_vResolucion
                     ,LD_dFec_Resolucion
                     ,LV_vSerie
                     ,LV_vEtiqueta
                     ,LD_dFec_CreaFolio
                     ,LD_DFec_Asigna
                     ,LN_nRan_Hasta
                     ,p_vInd_Consumo
                     );

     IF LN_nretorno_busc = G_NESTADO_FUNCIONOK AND LN_nestado_folio = G_NESTADO_DISPONIBLE
     THEN
        --DBMS_OUTPUT.PUT_LINE ( 'G_NESTADO_FUNCIONOK Y G_NESTADO_DISPONIBLE ' ); 

        --DBMS_OUTPUT.PUT_LINE ( 'p_ncorrela_folio = '|| TO_CHAR(p_ncorrela_folio));
        --DBMS_OUTPUT.PUT_LINE ( 'LN_ncorrela_folio = '|| TO_CHAR(LN_ncorrela_folio));

        ---LMV, 26-02-2010, Se resuelve incidencia GESDOC, para que permita grabar en tabla AL_CONUSMO_DOCUMENTOS
        IF p_vprefijo_folio = LV_vPrefijo_folio ---LMV AND p_ncorrela_folio = LN_ncorrela_folio
        THEN
           --DBMS_OUTPUT.PUT_LINE ( 'p_vprefijo_folio = LV_vPrefijo_folio AND p_ncorrela_folio = LN_ncorrela_folio ' );


           FA_CONSUME_FOLIO_PR(p_ntipo_documento
                              ,p_nCod_vendedor
                              ,LV_vCod_oficina
                              ,p_vCod_operadora
                              ,LV_vPrefijo_folio
                              ,p_ncorrela_folio   ------ LMV, 26-02-2010, LN_ncorrela_folio
                              ,p_nNumero_venta
                              ,p_nNumero_proceso
                              ,p_dfecha_proceso
                              ,LN_nretorno_cons
                              ,LN_nRango_inicial
                              ,LV_vResolucion
                              ,LD_dFec_Resolucion
                              ,LV_vSerie
                              ,LV_vEtiqueta
                              ,LD_dFec_CreaFolio
                              ,LD_dFec_Asigna
                              ,LN_nRan_Hasta
                              ,p_vInd_Consumo
                              );

           IF LN_nretorno_cons = G_NESTADO_FUNCIONOK
           THEN
              --DBMS_OUTPUT.PUT_LINE ( 'LN_nretorno_cons = G_NESTADO_FUNCIONOK ' );

              RETURN TO_CHAR(G_NESTADO_CONSUMIDO)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
                   TO_CHAR(LN_nRango_inicial)||G_CSEPARADOR||TO_CHAR(LN_nRan_Hasta);
           ELSE
              --DBMS_OUTPUT.PUT_LINE ( 'NO LN_nretorno_cons = G_NESTADO_FUNCIONOK ' );

              RETURN TO_CHAR(G_NFOLIO_NOCONSUMIDO)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
                   TO_CHAR(LN_nRango_inicial)||G_CSEPARADOR||TO_CHAR(LN_nRan_Hasta);
           END IF;

        ELSE
              --DBMS_OUTPUT.PUT_LINE ( 'NO p_vprefijo_folio = LV_vPrefijo_folio AND p_ncorrela_folio = LN_ncorrela_folio ' );

              RETURN TO_CHAR(G_NFOLIOS_NOCOINCIDEN)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
                   TO_CHAR(LN_nRango_inicial)||G_CSEPARADOR||TO_CHAR(LN_nRan_Hasta);
        END IF;

     ELSE

        --DBMS_OUTPUT.PUT_LINE ( 'NO G_NESTADO_FUNCIONOK Y G_NESTADO_DISPONIBLE ' );

        RETURN TO_CHAR(LN_nestado_folio)||G_CSEPARADOR||p_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
                   TO_CHAR(LN_nRango_inicial)||G_CSEPARADOR||TO_CHAR(LN_nRan_Hasta);
     END IF;

END FA_CONSUME_FOLIOPUNTUAL_FN;

    /* --------------------------------------- FUNCION FA_ANULA_FOLIO_FN ------------------------------------------ */

FUNCTION FA_CONSULTA_FOLIO_MDEALER_FN( p_nCod_vendedor IN NUMBER,
                                       p_vCod_oficina  IN VARCHAR,
                                       p_vCod_operadora IN VARCHAR,
                                       p_vInd_Consumo IN VARCHAR2 DEFAULT 'A'
                                       )
RETURN VARCHAR IS

       LN_ncorrela_folio  NUMBER(9);
       LN_nestado_folio   NUMBER(1);
       LN_nCod_tipdocum   FA_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
       LN_nEst_funcion    NUMBER(1);
       LN_nRango_inicial  AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
       LV_vCod_oficina    GE_OFICINAS.COD_OFICINA%TYPE;
       LV_vPrefijo_folio  AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
       LV_vResolucion     AL_ASIG_DOCUMENTOS.RESOLUCION%TYPE;
       LD_dFec_Resolucion AL_ASIG_DOCUMENTOS.FEC_RESOLUCION%TYPE;
       LV_vSerie          AL_ASIG_DOCUMENTOS.SERIE%TYPE;
       LV_vEtiqueta       AL_ASIG_DOCUMENTOS.ETIQUETA%TYPE;
       LD_dFec_CreaFolio  AL_ASIG_DOCUMENTOS.FEC_CREAFOLIO%TYPE;
       LD_dFec_Asigna     AL_ASIG_DOCUMENTOS.FEC_ASIGNA%TYPE;
       LN_nRan_Hasta      AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;
       LV_paramconsumoManual fad_parametros.val_caracter%TYPE;

       /* Definición de Cursor */
       CURSOR cBuscafolio IS
              SELECT DISTINCT COD_TIPDOCUM
                FROM GE_CATRIBDOCUM
              ORDER BY cod_tipdocum;
    BEGIN

        FA_INICIALIZA_PR;
        LV_vprefijo_folio  :=G_VALOR_RESET_VARCHAR;
        LN_ncorrela_folio  :=G_VALOR_RESET_NUMBER;
        LN_nestado_folio   :=G_VALOR_RESET_NUMBER;
        LN_nCod_tipdocum   :=G_VALOR_RESET_NUMBER;
        LN_nEst_funcion    :=G_VALOR_RESET_NUMBER;
        LN_nRango_inicial  :=NULL;
        LV_vResolucion     :=G_VALOR_RESET_VARCHAR;
        LD_dFec_Resolucion :=G_VALOR_RESET_DATE;
        LV_vSerie          :=G_VALOR_RESET_VARCHAR;
        LV_vEtiqueta       :=G_VALOR_RESET_VARCHAR;
        LD_dFec_CreaFolio  :=G_VALOR_RESET_DATE;
        LD_dFec_Asigna     :=G_VALOR_RESET_DATE;
        LN_nRan_Hasta      :=G_VALOR_RESET_NUMBER;

        --LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    IF p_vInd_Consumo = CV_consumo_manual THEN
        LV_paramconsumoManual:= FA_OBTIENE_PARAMETRO_FN(CV_param_cons_manual, CV_modulo);
        IF LV_paramconsumoManual = 'N' THEN
         LV_vCod_oficina := p_vCod_oficina;
        ELSE
         LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);       
        END IF;  
    ELSE
        LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    END IF;

        OPEN CBuscafolio;
            LOOP

                FETCH CBuscafolio INTO LN_nCod_tipdocum;

                EXIT WHEN CBuscafolio%NOTFOUND;

                BEGIN
                    LN_nestado_folio:= G_NESTADO_FOLIONOENC;
                    LN_nEst_funcion := G_NESTADO_FUNCIONERR;
                    FA_BUSCA_FOLIO_PR(LN_nCod_tipdocum
                                     ,p_nCod_vendedor
                                     ,LV_vCod_oficina
                                     ,p_vCod_operadora
                                     ,LN_nRango_inicial
                                     ,G_NOPBUSQDISPVENTA
                                     ,LV_vPrefijo_folio
                                     ,LN_ncorrela_folio
                                     ,LN_nestado_folio
                                     ,LN_nEst_funcion
                                     ,LN_nRango_inicial
                                     ,LV_vResolucion
                                     ,LD_dFec_Resolucion
                                     ,LV_vSerie
                                     ,LV_vEtiqueta
                                     ,LD_dFec_CreaFolio
                                     ,LD_dFec_Asigna
                                     ,LN_nRan_Hasta
                                     ,p_vInd_Consumo);

                    IF LN_nEst_funcion = G_NESTADO_FUNCIONOK AND LN_nestado_folio = G_NESTADO_DISPONIBLE THEN
                         EXIT;
                    END IF;
                END;
            END LOOP;
        CLOSE CBuscafolio;

        RETURN TO_CHAR(LN_nEstado_folio)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
               LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
               TO_CHAR(LN_nRango_inicial)||G_CSEPARADOR||TO_CHAR(LN_nRan_Hasta);

     END FA_CONSULTA_FOLIO_MDEALER_FN;

/****************************************************************************************************************/
/* Funcion: FA_CONSUME_FOLIO_CICLO_FN                                                                            */
/****************************************************************************************************************/
FUNCTION FA_CONSUME_FOLIO_CICLO_FN (p_ntipo_documento IN NUMBER,
                                    p_nCod_vendedor   IN NUMBER,
                                    p_vCod_oficina    IN VARCHAR,
                                     p_vCod_operadora  IN VARCHAR,
                                    p_nRango_inicial  IN NUMBER,
                                    p_nNumero_venta   IN NUMBER,
                                      p_nNumero_proceso IN NUMBER,
                                    p_dfecha_proceso  IN DATE,
                                    p_nop_consumo     IN NUMBER,
                                    p_vInd_Consumo IN VARCHAR2 DEFAULT 'A'
                                    )
RETURN VARCHAR IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    error_proceso                  EXCEPTION;
    LV_vSQLCmd                     VARCHAR(1000);
    LV_vPrefijo_folio             AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
    LV_vCod_oficina             GE_OFICINAS.COD_OFICINA%TYPE;
    LV_vMSG_SALIDA                    VARCHAR2(100);
    LV_vPrefijoFolio             AL_ASIG_DOCUMENTOS.PREF_PLAZA%TYPE;
    LV_vResolucion              AL_ASIG_DOCUMENTOS.RESOLUCION%TYPE;
    LV_vSerie                   AL_ASIG_DOCUMENTOS.SERIE%TYPE;
    LV_vEtiqueta                AL_ASIG_DOCUMENTOS.ETIQUETA%TYPE;
    LN_ncorrela_folio           NUMBER(9);
    LN_nestado_folio            NUMBER;
    LN_nretorno_busc            NUMBER;
    LN_nretorno_cons            NUMBER;
    LN_nOpcion_busqueda         NUMBER;
    LN_nRango                      NUMBER(9);
    LN_nDesde                      AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
    p_nTipo_documentoConvertido FA_TIPDOCUMEN.COD_TIPDOCUM%TYPE;
    LN_nRanDesde                AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
    LN_nRanHasta                AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;
    LD_dFecCreaFolio            AL_ASIG_DOCUMENTOS.FEC_CREAFOLIO%TYPE;
    LD_dFecAsigna               AL_ASIG_DOCUMENTOS.FEC_ASIGNA%TYPE;
    LD_dFecResolucion           AL_ASIG_DOCUMENTOS.FEC_RESOLUCION%TYPE;
    LV_paramconsumoManual fad_parametros.val_caracter%TYPE;
    
BEGIN

    FA_INICIALIZA_PR;

    LV_vPrefijo_folio           := G_VALOR_RESET_VARCHAR;
    LN_nCorrela_folio           := G_VALOR_RESET_NUMBER;
    LN_nEstado_folio            := G_VALOR_RESET_NUMBER;
    LN_nDesde                   := G_VALOR_RESET_NUMBER;
    LV_vMSG_SALIDA              := G_VALOR_RESET_VARCHAR;
    LV_vSQLCmd                  := G_VALOR_RESET_VARCHAR;
    LN_nRetorno_busc            := G_NESTADO_FUNCIONERR;
    LV_vPrefijoFolio            := G_VALOR_RESET_VARCHAR;
    LN_nRango                     := G_VALOR_RESET_NUMBER;
    LV_vResolucion              := G_VALOR_RESET_VARCHAR;
    LV_vSerie                   := G_VALOR_RESET_VARCHAR;
    LV_vEtiqueta                := G_VALOR_RESET_VARCHAR;
    p_nTipo_documentoConvertido := G_VALOR_RESET_NUMBER;
    LN_nRanDesde                := G_VALOR_RESET_NUMBER;
    LN_nRanHasta                := G_VALOR_RESET_NUMBER;
    LD_dFecCreaFolio            := G_VALOR_RESET_DATE;
    LD_dFecAsigna               := G_VALOR_RESET_DATE;
    LD_dFecResolucion           := G_VALOR_RESET_DATE;

    /* Se asume con lock de registro */
    /* Validación de Parametros de Ingreso a la función */
    IF (  p_vCod_oficina     IS NULL
       OR p_nTipo_documento IS NULL
       OR p_vCod_operadora  IS NULL )
    THEN
        LV_vMSG_SALIDA := G_VDESC_FALTAPARAM ||'dos';
        RAISE error_proceso;
    END IF;

    --LV_vCod_oficina             := FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    IF p_vInd_Consumo = CV_consumo_manual THEN
        LV_paramconsumoManual:= FA_OBTIENE_PARAMETRO_FN(CV_param_cons_manual, CV_modulo);
        IF LV_paramconsumoManual = 'N' THEN
         LV_vCod_oficina := p_vCod_oficina;
        ELSE
         LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);       
        END IF;  
    ELSE
        LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    END IF;
        
    p_nTipo_documentoConvertido := FA_DOCUMENTO_CONSUMO_FN(p_nTipo_documento);

    /*************************************************************************************/
    BEGIN
        ---------------------------------------------------------------
        --OBTENCION DEL RANGO DESDE MENOR SEGUN PARAMETROS ENTREGADOS--
        ---------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  MIN (RAN_DESDE) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA = '''||LV_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA>RAN_USADO ';

        IF  p_nCod_vendedor IS NOT NULL
        THEN
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
        
        EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nDesde;

        IF LN_nDesde IS NULL THEN
            RAISE NO_DATA_FOUND;
        END IF;

        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;

        -----------------------------------------------------------------
        --SELECCION DE FECHA RESOLUCION
        -----------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  MIN (FEC_RESOLUCION) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||LV_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = ' ||LN_nDesde;


        IF  p_nCod_vendedor IS NOT NULL
        THEN
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';

        EXECUTE IMMEDIATE LV_vSQLCmd INTO LD_dFecResolucion;

        IF LD_dFecResolucion IS NULL THEN

           LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;
           -----------------------------------------------------------------
           --SELECCION DE FECHA CREACION FOLIO (DOCUMENTOS DE PAGO)
           -----------------------------------------------------------------
           LV_vSQLCmd := 'SELECT  MIN (FEC_ASIGNA) FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
           LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
           LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA   = '''||LV_vCod_oficina||'''';
           LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
           LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = ' ||LN_nDesde;

           IF  p_nCod_vendedor IS NOT NULL
           THEN
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
           ELSE
               LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
           END IF;
           LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
           
           EXECUTE IMMEDIATE LV_vSQLCmd INTO LD_dFecAsigna;

           IF LD_dFecAsigna IS NULL THEN
              RAISE NO_DATA_FOUND;
           END IF;

        END IF;


        LV_vSQLCmd        := G_VALOR_RESET_VARCHAR;

        -----------------------------------------------------------------
        --SELECCION DE FOLIO SEGUN EL RANGO DESDE OBTENIDO Y PARAMETROS--
        -----------------------------------------------------------------
        LV_vSQLCmd := 'SELECT  RAN_USADO, PREF_PLAZA, RESOLUCION,';
        LV_vSQLCmd := LV_vSQLCmd||' SERIE, ETIQUETA, FEC_CREAFOLIO, FEC_ASIGNA, RAN_DESDE, RAN_HASTA';
        LV_vSQLCmd := LV_vSQLCmd||' FROM AL_ASIG_DOCUMENTOS WHERE COD_TIPDOCUM = '||p_nTipo_documentoConvertido;
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA = '''||p_vCod_operadora||''' ';
        LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA = '''||LV_vCod_oficina||'''';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_HASTA > RAN_USADO ';
        LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE = '||LN_nDesde||' ' ;


        IF LD_dFecResolucion IS NULL THEN
           LV_vSQLCmd := LV_vSQLCmd||' AND FEC_ASIGNA  = TO_DATE('''||TO_CHAR(LD_dFecAsigna,'DD-MM-YYYY HH24:MI:SS')||''',''DD-MM-YYYY HH24:MI:SS'')';
        ELSE
           LV_vSQLCmd := LV_vSQLCmd||' AND FEC_RESOLUCION  = TO_DATE('''||TO_CHAR(LD_dFecResolucion,'DD-MM-YYYY')||''',''DD-MM-YYYY'')';
        END IF;



        IF  p_nCod_vendedor IS NOT NULL
        THEN
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
        ELSE
            LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
        END IF;
        LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
                
        ---------------------------------------------------------------
        -- ES CONSULTA DEBE LOCKEAR--------------------
        ---------------------------------------------------------------
        LV_vSQLCmd := LV_vSQLCmd||' FOR UPDATE';
        ---------------------------------------------------------------

        EXECUTE IMMEDIATE LV_vSQLCmd INTO LN_nRango,LV_vPrefijo_folio,LV_vResolucion,
                                          LV_vSerie,LV_vEtiqueta,
                                          LD_dFecCreaFolio,LD_dFecAsigna,
                                          LN_nRanDesde,LN_nRanHasta;

        LN_nCorrela_folio := LN_nRango + 1;
        LN_nEstado_folio  := G_NESTADO_DISPONIBLE;
        LN_nRetorno_busc  := G_NESTADO_FUNCIONOK ;

     EXCEPTION
        WHEN error_proceso THEN
            RAISE_APPLICATION_ERROR (-20101,'ERROR FA_CONSUME_FOLIO_CICLO_FN : '||LV_vMSG_SALIDA);
        WHEN NO_DATA_FOUND THEN
                LN_nEstado_folio  := G_NESTADO_FOLIONOENC;
                LN_nRetorno_busc  := G_NESTADO_FUNCIONERR;
                RAISE_APPLICATION_ERROR(-20102,'ERROR FA_CONSUME_FOLIO_CICLO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM: NO SE ENCONTRARON FOLIOS DISPONIBLES');
        WHEN TOO_MANY_ROWS THEN
                 LN_nEstado_folio := G_NMUCHAS_FILAS;
                 LN_nRetorno_busc := G_NESTADO_FUNCIONERR;
                 RAISE_APPLICATION_ERROR(-20103,'ERROR FA_CONSUME_FOLIO_CICLO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20104,'ERROR FA_CONSUME_FOLIO_CICLO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
    END;

    /*************************************************************************/

    IF LN_nRetorno_busc = G_NESTADO_FUNCIONOK AND LN_nEstado_folio = G_NESTADO_DISPONIBLE
    THEN
        IF SQLCODE <> 0 THEN
            LV_vMSG_SALIDA := G_VNOFOUND_USUARIO;
            RAISE Error_proceso;
        END IF;
        /**********************/
        BEGIN

            INSERT INTO AL_CONSUMO_DOCUMENTOS (
                            COD_OFICINA,
                            TIP_DOCUM,
                            NUM_FOLIO,
                            USU_CONSUMO,
                            FEC_CONSUMO,
                            IND_CONSUMO,
                            IND_ANULACION,
                            COD_VENDEDOR,
                            COD_ESTADO,
                            IND_LIBROIVA,
                            COD_OPERADORA,
                            PREF_PLAZA,
                            NUM_VENTA,
                            NUM_PROCESO,

                            RESOLUCION,
                            FEC_RESOLUCION,
                            SERIE,
                            ETIQUETA,
                            FEC_CREAFOLIO
                            )
                VALUES (    LV_vCod_oficina,
                            p_nTipo_documento,
                            LN_nCorrela_folio,
                            USER,
                            p_dfecha_proceso,
                            'A',
                            0,
                            p_nCod_vendedor,
                            'F',
                            0,
                            p_vCod_operadora,
                            LV_vPrefijo_folio,
                            p_nNumero_venta,
                            p_nNumero_proceso,

                            LV_vResolucion,
                            LD_dFecResolucion,
                            LV_vSerie,
                            LV_vEtiqueta,
                            LD_dFecCreaFolio
                            );

            IF SQLCODE <> 0 THEN
                LV_vMSG_SALIDA := G_NOINSERTO_CONSUMO;
                RAISE Error_proceso;
            END IF;

             IF LV_vPrefijo_folio IS NULL THEN
                 LV_vPrefijoFolio := 'IS NULL';
             ELSE
                LV_vPrefijoFolio := '='|| '''' || LV_vPrefijo_folio;
             END IF;

             LV_vSQLCmd := 'UPDATE AL_ASIG_DOCUMENTOS SET RAN_USADO = '||LN_nCorrela_folio;
             LV_vSQLCmd := LV_vSQLCmd||' WHERE COD_TIPDOCUM          = '||p_nTipo_documentoConvertido;
             LV_vSQLCmd := LV_vSQLCmd||' AND COD_OPERADORA           = '''||p_vCod_operadora||'''';
             LV_vSQLCmd := LV_vSQLCmd||' AND PREF_PLAZA  '||LV_vPrefijoFolio||'''';
             LV_vSQLCmd := LV_vSQLCmd||' AND COD_OFICINA             = '''||LV_vCod_oficina||'''';
             LV_vSQLCmd := LV_vSQLCmd||' AND RAN_DESDE               = '||LN_nDesde;

             IF p_nCod_vendedor IS NOT NULL THEN
                 LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR = '||p_nCod_vendedor;
             ELSE
                 LV_vSQLCmd := LV_vSQLCmd||' AND COD_VENDEDOR IS NULL';
             END IF;
             LV_vSQLCmd := LV_vSQLCmd||' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';

            EXECUTE IMMEDIATE LV_vSQLCmd;

            IF SQL%ROWCOUNT <> 0 THEN
                COMMIT;
                LN_nRetorno_cons := G_NESTADO_FUNCIONOK;
            ELSE
                ROLLBACK;
                LN_nRetorno_cons := G_NESTADO_FUNCIONERR;
            END IF;


        EXCEPTION
            WHEN error_proceso THEN
                RAISE_APPLICATION_ERROR(-20101,'ERROR FA_CONSUME_FOLIO_CICLO_FN : '||LV_vMSG_SALIDA||' '||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20103,'ERROR FA_CONSUME_FOLIO_CICLO_FN :, SQLCODE:'||TO_CHAR(SQLCODE)||' SQLERRM:'||SQLERRM);
        END;

/*************************************************************************/

        IF LN_nRetorno_cons = G_NESTADO_FUNCIONOK THEN
            RETURN TO_CHAR(G_NESTADO_CONSUMIDO)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
                   TO_CHAR(LN_nRanDesde)||G_CSEPARADOR||TO_CHAR(LN_nRanHasta);
        ELSE
            RETURN TO_CHAR(G_NFOLIO_NOCONSUMIDO)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
                   LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
                   TO_CHAR(LN_nRanDesde)||G_CSEPARADOR||TO_CHAR(LN_nRanHasta);
        END IF;
    ELSE
        RETURN TO_CHAR(LN_nEstado_folio)||G_CSEPARADOR||LV_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(LN_nCorrela_folio)||G_CSEPARADOR||
               LV_vResolucion||G_CSEPARADOR||LV_vSerie||G_CSEPARADOR||LV_vEtiqueta||G_CSEPARADOR||
               TO_CHAR(LN_nRanDesde)||G_CSEPARADOR||TO_CHAR(LN_nRanHasta);
    END IF;

END FA_CONSUME_FOLIO_CICLO_FN;

/****************************************************************************************************************/

/* --------------------------------------- FA_CONSUME_FOLIOPUNTUAL_FN ------------------------------------------ */

PROCEDURE FA_CORRIGE_RANGOS_PR( p_ntipo_documento IN NUMBER
                                   , p_nCod_vendedor   IN NUMBER
                                   , p_vCod_oficina    IN VARCHAR
                                   , p_vCod_operadora  IN VARCHAR
                                   , p_nRango_inicial  IN NUMBER
                                   , p_nNumero_venta   IN NUMBER
                                   , p_nNumero_proceso IN NUMBER
                                   , p_dfecha_proceso  IN DATE
                                   , p_nop_consumo     IN NUMBER
                                   , p_vPrefijo_folio  IN VARCHAR
                                   , p_ncorrela_folio  IN NUMBER
                                   , p_nNewRango_inicial OUT NUMBER
                                   , p_retorno OUT NUMBER
                                   , p_vInd_Consumo IN VARCHAR2 DEFAULT 'M' --Por defecto es Prefoliado
                                  )IS
PRAGMA AUTONOMOUS_TRANSACTION;
                                  
LV_vSQLCmd          VARCHAR(1000);
LV_vCod_oficina     GE_OFICINAS.COD_OFICINA%TYPE;

LN_nRanDesde                AL_ASIG_DOCUMENTOS.RAN_DESDE%TYPE;
LN_nRanHasta                AL_ASIG_DOCUMENTOS.RAN_HASTA%TYPE;
LN_nRangoUsado              AL_ASIG_DOCUMENTOS.RAN_USADO%TYPE;
LD_dFecResolucion           VARCHAR2(10);
LD_dFecAsigna               VARCHAR2(20);
LD_dFecCrea                 VARCHAR2(20);
LV_vResolucion              AL_ASIG_DOCUMENTOS.RESOLUCION%TYPE;
LV_vSerie                   AL_ASIG_DOCUMENTOS.SERIE%TYPE;
LV_vEtiqueta                AL_ASIG_DOCUMENTOS.ETIQUETA%TYPE;
LN_nSolFolios               AL_ASIG_DOCUMENTOS.NUM_SOLFOLIOS%TYPE;
LN_codVendedor              AL_ASIG_DOCUMENTOS.COD_VENDEDOR%TYPE;
LV_retorno                  VARCHAR2(2500);
LN_nestado_folio    NUMBER;
LV_vInd_Consumo              AL_ASIG_DOCUMENTOS.IND_CONSUMO%TYPE;


EXCEPCION_BLOQUEO EXCEPTION; 
                                
BEGIN
    p_retorno := 1;
    p_nNewRango_inicial := p_nRango_inicial;
    
    LV_vCod_oficina:= p_vCod_oficina; --Se envia la oficina de consumo
    --FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    LV_vSQLCmd := 'SELECT TO_CHAR(FEC_ASIGNA,''DD-MM-YYYY HH24:MI:SS''),'; 
    LV_vSQLCmd := LV_vSQLCmd|| ' RAN_DESDE, RAN_HASTA, RAN_USADO, TO_CHAR(FEC_CREAFOLIO, ''DD/MM/YYYY HH24:MI:SS''),NUM_SOLFOLIOS,';
    LV_vSQLCmd := LV_vSQLCmd|| ' RESOLUCION,TO_CHAR(FEC_RESOLUCION,''DD-MM-YYYY''),SERIE, ETIQUETA, COD_VENDEDOR, IND_CONSUMO';
    LV_vSQLCmd := LV_vSQLCmd|| ' FROM AL_ASIG_DOCUMENTOS'; 
    LV_vSQLCmd := LV_vSQLCmd|| ' WHERE COD_OFICINA = ''' || LV_vCod_oficina || '''';
    LV_vSQLCmd := LV_vSQLCmd|| ' AND COD_TIPDOCUM = ' || p_ntipo_documento;
    LV_vSQLCmd := LV_vSQLCmd|| ' AND RAN_USADO < ' || p_ncorrela_folio; 
    LV_vSQLCmd := LV_vSQLCmd|| ' AND RAN_HASTA >= ' || p_ncorrela_folio; 
    LV_vSQLCmd := LV_vSQLCmd|| ' AND PREF_PLAZA = ''' || p_vPrefijo_folio || '''';
    LV_vSQLCmd := LV_vSQLCmd|| ' AND COD_OPERADORA = ''' || p_vCod_operadora || '''';
    IF p_nCod_vendedor IS NOT NULL THEN
        LV_vSQLCmd := LV_vSQLCmd|| ' AND COD_VENDEDOR = ' || p_nCod_vendedor;
    ELSE
        LV_vSQLCmd := LV_vSQLCmd|| ' AND COD_VENDEDOR IS NULL';    
    END IF;
    LV_vSQLCmd := LV_vSQLCmd|| ' AND IND_CONSUMO = ''' || p_vInd_Consumo || '''';
    --LV_vSQLCmd := LV_vSQLCmd|| ' FOR UPDATE';
    DBMS_OUTPUT.PUT_LINE('LV_vSQLCmd1 = ' || LV_vSQLCmd);
    EXECUTE IMMEDIATE LV_vSQLCmd INTO LD_dFecAsigna, LN_nRanDesde,LN_nRanHasta, LN_nRangoUsado, LD_dFecCrea, LN_nSolFolios, 
                                          LV_vResolucion, LD_dFecResolucion, LV_vSerie, LV_vEtiqueta, LN_codVendedor, LV_vInd_Consumo;
    IF (LN_nRangoUsado + 1) != p_ncorrela_folio AND LN_nRangoUsado != 0 THEN
         BEGIN     
         LV_vSQLCmd := 'UPDATE SISCEL.AL_ASIG_DOCUMENTOS';
         LV_vSQLCmd := LV_vSQLCmd|| ' SET RAN_HASTA = ' || (p_ncorrela_folio-1);
         LV_vSQLCmd := LV_vSQLCmd|| ' WHERE COD_OPERADORA = ''' || p_vCod_operadora || '''';
         LV_vSQLCmd := LV_vSQLCmd|| ' AND COD_OFICINA = ''' || LV_vCod_oficina || '''';
         LV_vSQLCmd := LV_vSQLCmd|| ' AND COD_TIPDOCUM = ' || p_ntipo_documento;
         LV_vSQLCmd := LV_vSQLCmd|| ' AND FEC_ASIGNA = TO_DATE(''' || LD_dFecAsigna || ''', ''DD-MM-YYYY HH24:MI:SS'')';
         LV_vSQLCmd := LV_vSQLCmd|| ' AND PREF_PLAZA = ''' || p_vPrefijo_folio || '''';
         LV_vSQLCmd := LV_vSQLCmd|| ' AND RAN_DESDE = ' || LN_nRanDesde;
         DBMS_OUTPUT.PUT_LINE('LV_vSQLCmd2 = ' || LV_vSQLCmd);
         EXECUTE IMMEDIATE LV_vSQLCmd;
         EXCEPTION
         WHEN OTHERS THEN
            RAISE EXCEPCION_BLOQUEO;
         END;
         
         IF SQL%ROWCOUNT = 0 THEN
            RAISE EXCEPCION_BLOQUEO;         
         END IF;

         begin                                           
         LV_vSQLCmd := 'INSERT INTO AL_ASIG_DOCUMENTOS (COD_OFICINA,COD_TIPDOCUM,FEC_ASIGNA,RAN_DESDE,';
         LV_vSQLCmd := LV_vSQLCmd|| ' RAN_HASTA,RAN_USADO,COD_VENDEDOR,IND_RESERVA,';
         LV_vSQLCmd := LV_vSQLCmd|| ' PREF_PLAZA,COD_OPERADORA,RESOLUCION,FEC_RESOLUCION,';
         LV_vSQLCmd := LV_vSQLCmd|| ' SERIE,ETIQUETA,FEC_CREAFOLIO,';
         LV_vSQLCmd := LV_vSQLCmd|| ' NUM_SOLFOLIOS, IND_CONSUMO)';
         LV_vSQLCmd := LV_vSQLCmd|| ' VALUES (''' ||LV_vCod_oficina || ''',' || p_ntipo_documento || ',sysdate,' || p_ncorrela_folio || ',';
         LV_vSQLCmd := LV_vSQLCmd|| LN_nRanHasta || ',0 ,';
         IF LN_codVendedor IS NULL THEN
            LV_vSQLCmd := LV_vSQLCmd|| 'NULL, ';
         ELSE
             LV_vSQLCmd := LV_vSQLCmd || LN_codVendedor || ',';
         END IF;
         LV_vSQLCmd := LV_vSQLCmd|| ' 0, ''' || p_vPrefijo_folio || ''',''' || p_vCod_operadora || ''',''' || LV_vResolucion || ''',to_date('''|| LD_dFecResolucion || ''',''dd/mm/yyyy''),';
         LV_vSQLCmd := LV_vSQLCmd|| '''' || LV_vSerie || ''',';
         IF LV_vEtiqueta IS NOT NULL THEN
            LV_vSQLCmd := LV_vSQLCmd|| '''' || LV_vEtiqueta || ''',';
         ELSE
             LV_vSQLCmd := LV_vSQLCmd|| 'NULL,';
         END IF;
         LV_vSQLCmd := LV_vSQLCmd|| 'to_date(''' || LD_dFecCrea || ''',''dd/mm/yyyy hh24:mi:ss''),';
         LV_vSQLCmd := LV_vSQLCmd|| LN_nSolFolios || ',''' || LV_vInd_Consumo || ''')';         
         DBMS_OUTPUT.PUT_LINE('LV_vSQLCmd3 = ' || LV_vSQLCmd);
         
         EXECUTE IMMEDIATE LV_vSQLCmd;
         
         EXCEPTION
           WHEN OTHERS THEN
                RAISE EXCEPCION_BLOQUEO;
         END;
        p_nNewRango_inicial :=  p_ncorrela_folio;           
    END IF;  
    COMMIT;       
   p_retorno := 0;
   
EXCEPTION
WHEN EXCEPCION_BLOQUEO THEN
    DBMS_OUTPUT.PUT_LINE('EXCEPCION_BLOQUEO: ' || SQLERRM);
   ROLLBACK;
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('OTHERS: ' || SQLERRM);
   ROLLBACK;
END FA_CORRIGE_RANGOS_PR;                              

FUNCTION FA_CONSUME_FOLIONOCORREL_FN( p_ntipo_documento IN NUMBER
                                   , p_nCod_vendedor   IN NUMBER
                                   , p_vCod_oficina    IN VARCHAR
                                   , p_vCod_operadora  IN VARCHAR
                                   , p_nRango_inicial  IN NUMBER
                                   , p_nNumero_venta   IN NUMBER
                                   , p_nNumero_proceso IN NUMBER
                                   , p_dfecha_proceso  IN DATE
                                   , p_nop_consumo     IN NUMBER
                                   , p_vPrefijo_folio  IN VARCHAR
                                   , p_ncorrela_folio  IN NUMBER
                                   , p_vInd_Consumo IN VARCHAR2 DEFAULT 'M' --Por defecto es Prefoliado
                                  )
RETURN VARCHAR IS


LN_nestado_folio    NUMBER;

LV_retorno              VARCHAR2(2500);
LN_retorno              number(1);

LN_NewRangoInicial al_asig_documentos.ran_desde%TYPE;
LV_paramconsumoManual fad_parametros.val_caracter%TYPE;
LV_vCod_oficina GE_OFICINAS.COD_OFICINA%TYPE;

BEGIN

    --Obtiene Oficina de Envio a consumo
    
    IF p_vInd_Consumo = CV_consumo_manual THEN
        LV_paramconsumoManual:= FA_OBTIENE_PARAMETRO_FN(CV_param_cons_manual, CV_modulo);
        IF LV_paramconsumoManual = 'N' THEN
         LV_vCod_oficina := p_vCod_oficina;
        ELSE
         LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);       
        END IF;
    ELSE
        LV_vCod_oficina:= FA_OFICINA_CONSUMO_FN(p_vCod_oficina);
    END IF;
                                                                          
    FA_CORRIGE_RANGOS_PR(p_ntipo_documento, p_nCod_vendedor, LV_vCod_oficina,
                         p_vCod_operadora, p_nRango_inicial, p_nNumero_venta,
                         p_nNumero_proceso, p_dfecha_proceso, p_nop_consumo,
                         p_vPrefijo_folio, p_ncorrela_folio, LN_NewRangoInicial, LN_retorno);  
                                                                         
    IF LN_retorno != 0 THEN
        LN_nEstado_folio  := G_NESTADO_FOLIONOENC;
        RETURN TO_CHAR(LN_nestado_folio)||G_CSEPARADOR||p_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(p_ncorrela_folio);
    END IF;  
    
    LV_retorno := 'FA_CONSUME_FOLIOPUNTUAL_FN( ' || p_ntipo_documento || ',' || p_nCod_vendedor || ',' || p_vCod_oficina || ',';
    LV_retorno := LV_retorno || p_vCod_operadora || ',' || LN_NewRangoInicial || ',' || p_nNumero_venta || ',' || p_nNumero_proceso || ',';
    LV_retorno := LV_retorno || p_dfecha_proceso || ', 2, ' || p_vPrefijo_folio || ',' || p_ncorrela_folio || ')';         
    DBMS_OUTPUT.PUT_LINE('LV_retorno: ' || LV_retorno);
                             
    LV_retorno := FA_CONSUME_FOLIOPUNTUAL_FN( p_ntipo_documento, p_nCod_vendedor, p_vCod_oficina,
                                  p_vCod_operadora, LN_NewRangoInicial, p_nNumero_venta, p_nNumero_proceso,
                                  p_dfecha_proceso, 2, p_vPrefijo_folio, p_ncorrela_folio, p_vInd_Consumo);
                                  
    RETURN LV_retorno;
                                            
EXCEPTION
WHEN NO_DATA_FOUND THEN    
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND: ' || SQLERRM);      
        LN_nEstado_folio  := G_NESTADO_FOLIONOENC;
        RETURN TO_CHAR(LN_nestado_folio)||G_CSEPARADOR||p_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(p_ncorrela_folio);
WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OTHERS 2: ' || SQLERRM);
        LN_nEstado_folio  := G_NESTADO_FOLIONOENC;
        RETURN TO_CHAR(LN_nestado_folio)||G_CSEPARADOR||p_vPrefijo_folio||G_CSEPARADOR||TO_CHAR(p_ncorrela_folio);       
                       
END;
                          
/* --------------------------------------- FA_CONSUME_FOLIONOCORREL_FN ------------------------------------------ */

END ; -- Package Body FA_FOLIACION_PG
/
SHOW ERRORS