CREATE OR REPLACE PACKAGE PV_PAGOANTICIPADO_PG
AS
/*--
        <Documentacion TipoDoc = "PACKAGE>
            Elemento Nombre = "PV_PAGOANTICIPADO_PG"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Diseñador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  </Retorno>
        <Descripcion>
              Ingresa el pago anticipado por Plan, Servicios Suplementarios y Planes Adicionales
        </Descripcion>
        <Parametros>
        <Entrada>
        </Entrada>
        <Salida>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/

--Definicion de Constantes
CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';
CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
CV_ERROR_NO_CLASIF   CONSTANT VARCHAR2(30) := 'Error no clasificado';
CV_COD_PRODUCTO      CONSTANT NUMBER(1)    := 1;
CV_COD_TIPSERV       CONSTANT NUMBER(1)    := 2;
CN_ind_estado        CONSTANT NUMBER(1)    := 3;
CN_TIPO_SERVICIOSS   CONSTANT NUMBER(1)    := 2;
CN_TIPO_SERVICIOPLAN CONSTANT NUMBER(1)    := 1;
CN_TIPO_SERVICIOADIC CONSTANT NUMBER(1)    := 3;
CV_TIP_COBRO         CONSTANT VARCHAR2(1)  := 'A';
CN_LARGOERRTEC       CONSTANT NUMBER       := 4000;
CN_LARGODESC         CONSTANT NUMBER       := 2000;

--Definicion de Procedimientos / Funciones Publicas

PROCEDURE PV_INICIO_PAGOANTICIPADO_PR(EN_num_abonado    IN ga_abocel.num_abonado%type,
                                 EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                                 EV_cod_plantarif  IN  ta_plantarif.cod_plantarif%type,
                                 EV_cod_actabo     IN ga_actabo.cod_actabo%type,
                                 EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                                 EN_aplica_pago    in number,
                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
                                 
                                 
PROCEDURE PV_OBTENERSS_AUX_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                         EN_num_abonado    IN ga_abocel.num_abonado%type,
                         EV_cod_actabo     IN ga_actabo.cod_actabo%type,
						 EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);
                         
                         
PROCEDURE PV_OBTENERSS_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                         EN_num_abonado    IN ga_abocel.num_abonado%type,
                         EV_cod_actabo     IN ga_actabo.cod_actabo%type,
						 EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);                         
                                                          
END;
/
SHOW ERRORS