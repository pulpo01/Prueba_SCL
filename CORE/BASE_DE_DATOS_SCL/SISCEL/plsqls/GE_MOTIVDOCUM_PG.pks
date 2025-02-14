CREATE OR REPLACE PACKAGE Ge_Motivdocum_Pg

/*
<Documentación
   TipoDoc = "Package">
   <Elemento
       Nombre = "GE_MOTIVDOCUM_PG"
       Lenguaje="PL/SQL"
       Fecha="15-12-2006"
       Versión="1.0"
       Diseñador="RyC"
       Programador="RyC"
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripción>Package llamada a package de Registro de Observaciones de Cargos</Descripción>
       <Parámetros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Parámetros>    
       }
    </Elemento>
   </Documentación>
*/
 IS
-------------------------------------------------------------------------------------------------------------------------------------
--Constantes Globales--

CV_Version        CONSTANT VARCHAR2(3)   := '1.0';
CV_PROCEDURE1     CONSTANT VARCHAR2(100) := 'GE_MOTIVDOCUM_PG.PV_REGISTRA_DESCRIPCION_PR';
CV_FUNCTION1      CONSTANT VARCHAR2(100) := 'GE_MOTIVDOCUM_PG.SEL_DOCUMMOTIV_TO_FN';
CV_0              CONSTANT VARCHAR2(1)   := '0';
CV_4              CONSTANT VARCHAR2(1)   := '4';
CN_0              CONSTANT NUMBER(1)     := 0;
CV_DES_ERROR_V1   CONSTANT VARCHAR2(100) := 'Error en proceso PV_REGISTRA_DESCRIPCION_PR';
CV_DES_ERROR_V2   CONSTANT VARCHAR2(100) := 'Error en funcion SEL_DOCUMMOTIV_TO_FN';
CN_20010          CONSTANT NUMBER (6)    := -20010;

--Variables Globales--
 LV_v_verror              VARCHAR2(255);
 
TYPE refcursor IS REF CURSOR;

PROCEDURE GE_INSDOCUMMOTIV_TO_PR(EN_NUM_PROCESO       IN  GE_DOCUMMOTIV_TO.NUM_PROCESO%TYPE,
                                 EN_COD_CONCEPTO      IN  GE_DOCUMMOTIV_TO.COD_CONCEPTO%TYPE,
                                 EN_COLUMNA           IN  GE_DOCUMMOTIV_TO.COLUMNA%TYPE,
                                 EN_JUSTIFICACION     IN  GE_DOCUMMOTIV_TO.COD_JUSTIFICACION%TYPE,
                                 EN_COD_CENTCOS       IN  GE_DOCUMMOTIV_TO.COD_CENTCOS%TYPE,
                                 EN_COD_DOCUMEN       IN  GE_DOCUMMOTIV_TO.COD_TIPDOCUM%TYPE,
                                 EV_FEC_EMISION       IN  GE_DOCUMMOTIV_TO.FEC_EMISION%TYPE,
                                 EN_NUM_SECUENCI      IN  GE_DOCUMMOTIV_TO.NUM_SECUENCI%TYPE,
                                 EN_COD_VENDEDOR      IN  GE_DOCUMMOTIV_TO.COD_VENDEDOR_AGENTE%TYPE,
                                 EV_LETRA             IN  GE_DOCUMMOTIV_TO.LETRA%TYPE,
                                 EN_COD_CENTREMI      IN  GE_DOCUMMOTIV_TO.COD_CENTREMI%TYPE,
                                 EN_NUM_SECDOCUMMOTIV IN  GE_DOCUMMOTIV_TO.NUM_SECDOCUMMOTIV%TYPE,
                                 EV_PROG_ORIG         IN  VARCHAR2,
                                 SV_mens_retorno      OUT NOCOPY VARCHAR2,
                                 SN_retorno           OUT NOCOPY VARCHAR2
);
 
 
FUNCTION SEL_DOCUMMOTIV_TO_FN ( EN_NUM_PROCESO    IN  GE_DOCUMMOTIV_TO.NUM_PROCESO%TYPE,
                                EN_COD_CONCEPTO   IN  GE_DOCUMMOTIV_TO.COD_CONCEPTO%TYPE,
                                EN_COLUMNA        IN  GE_DOCUMMOTIV_TO.COLUMNA%TYPE,
                                EN_JUSTIFICACION  IN  GE_DOCUMMOTIV_TO.COD_JUSTIFICACION%TYPE,
                                EN_COD_DOCUMEN    IN  GE_DOCUMMOTIV_TO.COD_TIPDOCUM%TYPE,
                                EV_FEC_EMISION    IN  GE_DOCUMMOTIV_TO.FEC_EMISION%TYPE,
                                EV_PROG_ORIG      IN  VARCHAR2,
                                SN_cod_retorno    OUT NOCOPY VARCHAR2,
                                SV_mens_retorno   OUT NOCOPY VARCHAR2,
                                SV_record         OUT NOCOPY refcursor
                                ) RETURN VARCHAR2
;


FUNCTION SEL_JUSTDOCUM_TO_FN (EN_COD_TIPDOCUM   IN  GE_JUSTDOCUM_TO.COD_TIPDOCUM%TYPE,
                              EV_PROG_ORIG      IN  VARCHAR2,
                              SN_cod_retorno    OUT NOCOPY VARCHAR2,
                              SV_mens_retorno   OUT NOCOPY VARCHAR2,
                              SV_record         OUT NOCOPY refcursor
                              ) RETURN VARCHAR2
;
FUNCTION SEL_CENTCOSTO_TO_FN (    EV_PROG_ORIG      IN  VARCHAR2,
                                   SN_cod_retorno    OUT NOCOPY VARCHAR2,
                                 SV_mens_retorno   OUT NOCOPY VARCHAR2,
                                 SV_record         OUT NOCOPY refcursor
                            ) RETURN VARCHAR2
;
FUNCTION SEL_JUSTDOCUMDESC_TO_FN (EN_COD_TIPDOCUM   IN  GE_JUSTDOCUM_TO.COD_TIPDOCUM%TYPE,
                                      EV_PROG_ORIG      IN  VARCHAR2,
                              SN_cod_retorno    OUT NOCOPY VARCHAR2,
                                     SV_mens_retorno   OUT NOCOPY VARCHAR2,
                                     SV_record         OUT NOCOPY refcursor
                                     ) RETURN VARCHAR2
;
END Ge_Motivdocum_Pg;
/
show errors