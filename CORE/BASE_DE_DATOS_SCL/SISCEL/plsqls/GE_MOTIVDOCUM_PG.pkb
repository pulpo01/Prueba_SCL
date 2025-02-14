CREATE OR REPLACE PACKAGE BODY Ge_Motivdocum_Pg IS


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
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GE_INSDOCUMMOTIV_TO_PR"
      Lenguaje="PL/SQL"
      Fecha="05-01-2007"
      Versión="1.0"
      Diseñador="RyC"
      Programador="RyC"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
          <Descripción></Descripción>
       <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

LN_COLUMNA GE_DOCUMMOTIV_TO.COLUMNA%TYPE;

BEGIN

    SN_retorno  :=0;

    IF EN_COD_CONCEPTO=0 THEN
       LN_COLUMNA:=0;
    ELSE
       LN_COLUMNA:=EN_COLUMNA;
     END IF;
    
    INSERT INTO GE_DOCUMMOTIV_TO 
           (NUM_PROCESO    , COD_CONCEPTO   , COLUMNA        , COD_JUSTIFICACION,
            COD_CENTCOS    , COD_TIPDOCUM   , FEC_EMISION    , NUM_SECUENCI     ,
            COD_VENDEDOR_AGENTE, LETRA      , COD_CENTREMI   , NUM_SECDOCUMMOTIV)
    VALUES (EN_NUM_PROCESO , EN_COD_CONCEPTO, LN_COLUMNA     , EN_JUSTIFICACION ,
            EN_COD_CENTCOS , EN_COD_DOCUMEN , EV_FEC_EMISION , EN_NUM_SECUENCI  ,
            EN_COD_VENDEDOR, EV_LETRA       , EN_COD_CENTREMI, EN_NUM_SECDOCUMMOTIV);
    


EXCEPTION
          WHEN OTHERS THEN

            SN_retorno:= GE_ERRORES_PG.GRABARPL(CN_0, EV_PROG_ORIG, CV_DES_ERROR_V1, CV_Version, USER,
                                              CV_PROCEDURE1,NULL, SQLCODE, SQLERRM);

         SV_mens_retorno  := SUBSTR(CV_DES_ERROR_V1 || SQLERRM,1,255);
         

END GE_INSDOCUMMOTIV_TO_PR;


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
/*
<Documentación>
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "SEL_DOCUMMOTIV_TO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-01-2007"
                Creado por="RyC"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener si existe cambio de producto</Descripción>
                <Parámetros>
                    <Entrada></Entrada>
                    <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS

Lv_query       VARCHAR2(250);
Ln_proceso     GE_DOCUMMOTIV_TO.NUM_PROCESO%TYPE := EN_NUM_PROCESO;
Ln_concepto    GE_DOCUMMOTIV_TO.COD_CONCEPTO%TYPE := EN_COD_CONCEPTO;
Ln_columna     GE_DOCUMMOTIV_TO.COLUMNA%TYPE := EN_COLUMNA;
Ln_justifica   GE_DOCUMMOTIV_TO.COD_JUSTIFICACION%TYPE := EN_JUSTIFICACION;
Ln_cod_documen GE_DOCUMMOTIV_TO.COD_TIPDOCUM%TYPE := EN_COD_DOCUMEN;
Lv_fec_emision GE_DOCUMMOTIV_TO.FEC_EMISION%TYPE :=EV_FEC_EMISION;

ERROR_PROCESO  EXCEPTION;    

BEGIN

        Lv_query := 'SELECT NUM_PROCESO   , COD_CONCEPTO   , COLUMNA    , COD_JUSTIFICACION,';
         Lv_query := Lv_query || ' COD_CENTCOS   , COD_TIPDOCUM  , FEC_EMISION ';
         Lv_query := Lv_query || ' FROM GE_DOCUMMOTIV_TO ';
         Lv_query := Lv_query || ' WHERE 1 = 1 ' ;
         
         IF Ln_proceso != 0 THEN
            Lv_query := Lv_query || ' AND NUM_PROCESO = '|| EN_NUM_PROCESO ;
         END IF;
         IF Ln_concepto != 0 THEN
            Lv_query := Lv_query || ' AND COD_CONCEPTO = '|| EN_COD_CONCEPTO ;
         END IF;
         IF Ln_columna != 0 THEN
            Lv_query := Lv_query || ' AND COLUMNA = ' || EN_COLUMNA  ;
         END IF;
         IF Ln_justifica != 0 THEN
            Lv_query := Lv_query || ' AND COD_JUSTIFICACION = ' || EN_JUSTIFICACION  ;
         END IF;
         IF Ln_cod_documen != 0 THEN
            Lv_query := Lv_query || ' AND COD_TIPDOCUM = ' || EN_COD_DOCUMEN  ;
         END IF;
         IF Lv_fec_emision != NULL THEN
            Lv_query := Lv_query || ' AND TRUNC(FEC_EMISION) = ' || TO_DATE(EV_FEC_EMISION,'DD-MM-YYYY')  ;
         END IF;
         
         OPEN  SV_record  FOR Lv_query;
 

    --RETURN Lv_query;
EXCEPTION

   WHEN NO_DATA_FOUND THEN
            SN_cod_retorno   := 100;
            SV_mens_retorno  := 'No se encuentra datos';
            RETURN 'FALSE';
   
   WHEN OTHERS THEN
           SN_cod_retorno   := -1;
           SV_mens_retorno  := CV_DES_ERROR_V2;
             SN_cod_retorno:= GE_ERRORES_PG.GRABARPL(CN_0, EV_PROG_ORIG, CV_DES_ERROR_V2, CV_Version,USER,
                                                   CV_FUNCTION1, NULL, SQLCODE, SQLERRM);

          SV_mens_retorno  := SUBSTR(CV_DES_ERROR_V2 || SQLERRM,1,255);

        RETURN 'FALSE';
        
END SEL_DOCUMMOTIV_TO_FN;


FUNCTION SEL_JUSTDOCUM_TO_FN (EN_COD_TIPDOCUM   IN  GE_JUSTDOCUM_TO.COD_TIPDOCUM%TYPE,
                                      EV_PROG_ORIG      IN  VARCHAR2,
                              SN_cod_retorno    OUT NOCOPY VARCHAR2,
                                     SV_mens_retorno   OUT NOCOPY VARCHAR2,
                                     SV_record         OUT NOCOPY refcursor
                                     ) RETURN VARCHAR2
/*
<Documentación>
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "SEL_JUSTDOCUM_TO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-01-2007"
                Creado por="RyC"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener si existe cambio de producto</Descripción>
                <Parámetros>
                    <Entrada></Entrada>
                    <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS


ERROR_PROCESO  EXCEPTION;

BEGIN

         OPEN  SV_record  FOR 
         SELECT COD_JUSTIFICACION,
                COD_MODULO       ,
                IND_CENTCOS
         FROM   GE_JUSTDOCUM_TO 
         WHERE  COD_TIPDOCUM = EN_COD_TIPDOCUM;
 

    --RETURN Lv_query;
EXCEPTION

   WHEN NO_DATA_FOUND THEN
            SN_cod_retorno   := 100;
            SV_mens_retorno  := 'No se encuentra datos';
            RETURN 'FALSE';
   
   WHEN OTHERS THEN
           SN_cod_retorno   := -1;
           SV_mens_retorno  := CV_DES_ERROR_V2;
             SN_cod_retorno:= GE_ERRORES_PG.GRABARPL(CN_0, EV_PROG_ORIG, CV_DES_ERROR_V2, CV_Version,USER,
                                                   CV_FUNCTION1, NULL, SQLCODE, SQLERRM);

          SV_mens_retorno  := SUBSTR(CV_DES_ERROR_V2 || SQLERRM,1,255);

        RETURN 'FALSE';
        
END SEL_JUSTDOCUM_TO_FN;


FUNCTION SEL_CENTCOSTO_TO_FN (    EV_PROG_ORIG      IN  VARCHAR2,
                                   SN_cod_retorno    OUT NOCOPY VARCHAR2,
                                 SV_mens_retorno   OUT NOCOPY VARCHAR2,
                                 SV_record         OUT NOCOPY refcursor
                            ) RETURN VARCHAR2
/*
<Documentación>
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "SEL_CENTCOSTO_TO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="15-05-2007"
                Creado por="RyC"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener los centros de costos</Descripción>
                <Parámetros>
                    <Entrada></Entrada>
                    <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS


ERROR_PROCESO  EXCEPTION;
VALOR   NUMBER; -- Borrar

BEGIN

        -- OPEN  SV_record  FOR 
          --  SELECT VALOR, DESCRIPCION_VALOR  FROM GE_CENTRO_COSTOS_DSCTO_VW;
        valor := 0; 

    --RETURN Lv_query;
EXCEPTION

   WHEN NO_DATA_FOUND THEN
            SN_cod_retorno   := 100;
            SV_mens_retorno  := 'No se encuentra datos';
            RETURN 'FALSE';
   
   WHEN OTHERS THEN
           SN_cod_retorno   := -1;
           SV_mens_retorno  := CV_DES_ERROR_V2;
             SN_cod_retorno:= GE_ERRORES_PG.GRABARPL(CN_0, EV_PROG_ORIG, CV_DES_ERROR_V2, CV_Version,USER,
                                                   CV_FUNCTION1, NULL, SQLCODE, SQLERRM);

          SV_mens_retorno  := SUBSTR(CV_DES_ERROR_V2 || SQLERRM,1,255);

        RETURN 'FALSE';
        
END SEL_CENTCOSTO_TO_FN;


FUNCTION SEL_JUSTDOCUMDESC_TO_FN (EN_COD_TIPDOCUM   IN  GE_JUSTDOCUM_TO.COD_TIPDOCUM%TYPE,
                                      EV_PROG_ORIG      IN  VARCHAR2,
                              SN_cod_retorno    OUT NOCOPY VARCHAR2,
                                     SV_mens_retorno   OUT NOCOPY VARCHAR2,
                                     SV_record         OUT NOCOPY refcursor
                                     ) RETURN VARCHAR2
/*
<Documentación>
        TipoDoc = "Funcion">
        <Elemento
                Nombre = "SEL_JUSTDOCUM_TO_FN"
                Lenguaje="PL/SQL"
                Fecha creación="05-01-2007"
                Creado por="RyC"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>VARCHAR2</Retorno>
                <Descripción>Funcion para obtener si existe cambio de producto</Descripción>
                <Parámetros>
                    <Entrada></Entrada>
                    <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS


ERROR_PROCESO  EXCEPTION;
VALOR   NUMBER; -- Borrar
BEGIN

      /*   OPEN  SV_record  FOR 
         SELECT a.COD_JUSTIFICACION,
                a.COD_MODULO       ,
                a.IND_CENTCOS,
                b.DESCRIPCION_VALOR
         FROM   GE_JUSTDOCUM_TO a,
                 GE_JUSTIFICACION_DOCUM_VW B
         WHERE  a.COD_TIPDOCUM = EN_COD_TIPDOCUM
                 AND b.COD_DOMINIO='JUSTIFICACION_DOCUM'
                AND a.COD_JUSTIFICACION=b.VALOR ;*/
 
VALOR := 0;

    --RETURN Lv_query;
EXCEPTION

   WHEN NO_DATA_FOUND THEN
            SN_cod_retorno   := 100;
            SV_mens_retorno  := 'No se encuentra datos';
            RETURN 'FALSE';
   
   WHEN OTHERS THEN
           SN_cod_retorno   := -1;
           SV_mens_retorno  := CV_DES_ERROR_V2;
             SN_cod_retorno:= GE_ERRORES_PG.GRABARPL(CN_0, EV_PROG_ORIG, CV_DES_ERROR_V2, CV_Version,USER,
                                                   CV_FUNCTION1, NULL, SQLCODE, SQLERRM);

          SV_mens_retorno  := SUBSTR(CV_DES_ERROR_V2 || SQLERRM,1,255);

        RETURN 'FALSE';
        
END SEL_JUSTDOCUMDESC_TO_FN;

END Ge_Motivdocum_Pg;
/
show errors