CREATE OR REPLACE PACKAGE Ve_Serv_Suplem_Abo_Pg IS

        /*
        <Documentacion
        TipoDoc = "Package">
        <Elemento
           Nombre = "VE_serv_suplem_abo_PG"
           Lenguaje="PL/SQL"
           Fecha="07-03-2007"
           Version="1.0"
           Dise?ador="wjrc"
           Programador="wjrc"
           Ambiente Desarrollo="BD">
           <Retorno>NA</Retorno>
           <Descripcion>Package para obtener los servicios suplementarios del abonado</Descripcion>
           <Parametros>
              <Entrada>NA</Entrada>
              <Salida>NA</Salida>
           </Parametros>
        </Elemento>
        </Documentacion>
        */

        -- Nombre del package
        CV_NOMBRE_PACKAGE     CONSTANT VARCHAR2(21) := 'Ve_Serv_Suplem_Abo_Pg';

        --type REFCURSOR                 IS REF CURSOR;
    cv_error_no_clasif   CONSTANT VARCHAR2 (60) := 'Error no clasificado';
        cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'VE';
        cn_largoerrtec       CONSTANT NUMBER        := 4000;
        cn_largodesc         CONSTANT NUMBER        := 2000;
        CV_VERSION                   CONSTANT VARCHAR2(3)  := '1.0';

        CV_CODMODULO_AL      CONSTANT VARCHAR2(2)  := 'AL';
        CV_CODMODULO_GA      CONSTANT VARCHAR2(2)  := 'GA';
        CV_CODMODULO_GE      CONSTANT VARCHAR2(2)  := 'GE';
        CV_CODPRODUCTO       CONSTANT VARCHAR2(1)  := '1';
        CV_SISTEMA           CONSTANT VARCHAR2(1)  := '1';

        CV_CODACT_VEN        CONSTANT VARCHAR2(2)  := 'VO';                       -- codigo actuacion venta
        CV_CODACT_FAC        CONSTANT VARCHAR2(2)  := 'FA';                       -- codigo actuacion facturacion
        CV_CODACT_AAH        CONSTANT VARCHAR2(2)  := 'HH';                       -- codigo actuacion alta abonado hibrido
        CV_CODACT_AAM        CONSTANT VARCHAR2(2)  := 'AM';                       

        CV_NOMPAR_TIPPLANHIB     CONSTANT VARCHAR2(16) := 'TIP_PLAN_HIBRIDO';
        CV_NOMPAR_INDAUTENTI     CONSTANT VARCHAR2(17) := 'IND_AUTENTICACION';
        CV_NOMPAR_FORMAFECHA     CONSTANT VARCHAR2(12) := 'FORMATO_SEL2';
    CV_NOMPAR_FRIENDFAMI     CONSTANT VARCHAR2(10) := 'FRIEND_FAM';
    CV_NOMPAR_TIPTERMINALGSM CONSTANT VARCHAR2(15) := 'COD_SIMCARD_GSM';
        CV_CODPRO_SERVSUP        CONSTANT VARCHAR2(16) := 'COD_PROC_SERVSUP';

        CV_TECNOLOGIA        CONSTANT VARCHAR2(3)  := 'GSM';
    CV_TIPTERMINAL_EQUI  CONSTANT VARCHAR2(1)  := 'T';
    CV_TIPTERMINAL_SIMC  CONSTANT VARCHAR2(1)  := 'G';

        -- * CONSTANTES DEFINIDAS EN CODIGO VB

        CV_INDESTADO_ALTBD   CONSTANT VARCHAR2(1)  := '1';                                -- alta base de datos
        CV_INDESTADO_ALTCEN  CONSTANT VARCHAR2(1)  := '2';                                -- alta centrales
        CV_INDCOMERCIAL      CONSTANT VARCHAR2(1)  := '1';
    CV_TIPSERVICIO_1     CONSTANT VARCHAR2(1)  := '1';
    CV_TIPSERVICIO_2     CONSTANT VARCHAR2(1)  := '2';
        CV_PROGRAMA          CONSTANT VARCHAR2(3)  := 'GAC';
        CV_VERSIONPROGRAMA   CONSTANT VARCHAR2(2)  := '13';

        CV_FORMATO_FECHA_SIS CONSTANT VARCHAR2(17)  := 'DDMMYYYY HH24MISS';
        CV_FECHATOPE_SS          CONSTANT VARCHAR2(10)  := '31-12-3000';
        CV_HORATOPE_SS       CONSTANT VARCHAR2(10)  := ' 23:59:00';       -- conservar el especio delante
        CV_DURACION_INFINITA CONSTANT VARCHAR2(1)  := 'I';
        CV_TIPO_RELACION     CONSTANT VARCHAR2(2)  := '3';
        CV_TIPO_SERV_NORMAL  CONSTANT VARCHAR2(1)  := '1';

        CV_ESTADO_1          CONSTANT NUMBER  := 1;
        CV_ESTADO_2              CONSTANT NUMBER  := 2;

    TYPE ArregloParametros  IS TABLE  OF ged_parametros.val_parametro%TYPE INDEX BY BINARY_INTEGER;
        TYPE REFCURSOR    IS REF CURSOR;

        PROCEDURE VE_ProcesoSSAbonado_PR( EV_abonado       IN  VARCHAR2,
                                          EV_plan          IN  VARCHAR2,
                                          EV_numterminal   IN  VARCHAR2,
                                          EV_usuario       IN  VARCHAR2,
                                          EV_CodTecnologia IN  AL_TECNOLOGIA.COD_TECNOLOGIA%TYPE,
                                          EV_TipTerminal   IN  AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE, 
                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento
                                                      );                                              

        PROCEDURE VE_obtiene_SS_abonado_PR ( EV_num_abonado  IN  NUMBER,
                                                                                 SC_cursordatos   OUT NOCOPY REFCURSOR,
                                                                                 SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                 SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                 SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

                PROCEDURE VE_obtiene_SSabo_paracent_PR(EN_numabonado   IN ga_servsuplabo.num_abonado%TYPE,
                                               EN_indestado    IN ga_servsuplabo.ind_estado%TYPE,
                                               EV_codProducto  IN VARCHAR2,
                                               EV_codModulo    IN VARCHAR2,
                                               EV_codSistema   IN VARCHAR2,
                                               EV_codActuacion IN VARCHAR2,
                                               EV_TipTerminal  IN AL_TIPOS_TERMINALES.TIP_TERMINAL%TYPE,
                                               SC_cursordatos  OUT NOCOPY REFCURSOR,
                                               SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                               SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                               SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE VE_insServSuplAdicionales_PR(EV_numAbonado   IN VARCHAR2,
                                                                                   EV_cadenaSS     IN VARCHAR2,
                                                                                   EV_numTerminal  IN VARCHAR2,
                                                                                   EV_usuario      IN VARCHAR2,
                                                                                   SV_cadenaSS     OUT NOCOPY VARCHAR2,
                                                                                   SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                                                   SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                                                   SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE VE_obtiene_SSabo_nocent_PR(EN_numabonado   IN ga_servsuplabo.num_abonado%TYPE,
                                              EN_indestado    IN ga_servsuplabo.ind_estado%TYPE,
                                                                                  EV_codProducto  IN VARCHAR2,
                                                                                  EV_codModulo    IN VARCHAR2,
                                                                                  EV_codSistema   IN VARCHAR2,
                                                                                  EV_codActuacion IN VARCHAR2,
                                                                      SC_cursordatos  OUT NOCOPY REFCURSOR,
                                                                          SN_cod_retorno  OUT NOCOPY ge_errores_pg.CodError,
                                                          SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError,
                                                          SN_num_evento   OUT NOCOPY ge_errores_pg.Evento);
                       PROCEDURE VE_InsertaSSAbonado_PR( EV_num_abonado      IN  VARCHAR2,
                                                         EV_cod_servicio     IN  VARCHAR2,
                                                         EV_cod_servsupl     IN  VARCHAR2,
                                                         EV_cod_nivel        IN  VARCHAR2,
                                                         EV_cod_producto     IN  VARCHAR2,
                                                         EV_num_terminal     IN  VARCHAR2,
                                                         EV_cod_concepto     IN  VARCHAR2,
                                                         EV_ind_estado       IN  VARCHAR2,
                                                         EV_num_diasnum      IN  VARCHAR2,
                                                         EV_fecha_alta       IN  VARCHAR2,
                                                         EV_usuario          IN  VARCHAR2,
                                                         SN_cod_retorno      OUT NOCOPY ge_errores_pg.CodError,
                                                         SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError,
                                                         SN_num_evento       OUT NOCOPY ge_errores_pg.Evento
                                                );                                                          
        PROCEDURE VE_obtiene_SS_abonadoEV_PR( EV_num_abonado     IN NUMBER,
                                              SC_cursordatos         OUT NOCOPY REFCURSOR,
                                              SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                              SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
END Ve_Serv_Suplem_Abo_Pg;
/
SHOW ERRORS