CREATE OR REPLACE PROCEDURE PV_VALPLANES_ATLAN_PR(
                                                                                        EV_param_entrada IN  VARCHAR2,
                                                                                        SV_RESULTADO    OUT NOCOPY VARCHAR2,
                                                                                SV_MENSAJE      OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VALPLANES_ATLAN_PR"
      Lenguaje="PL/SQL"
      Fecha="21-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
          Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EV_param_entrada"      Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
                <param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
                <param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        ---- parametros reales de entrada --------------

    LV_ABONADO     GA_ABOCEL.COD_CLIENTE%TYPE;
        LV_PLANDESTINO GA_ABOCEL.COD_PLANTARIF%TYPE;
        LV_PLANORIGEN  GA_ABOCEL.COD_PLANTARIF%TYPE;
    LV_TIPLANORI   TA_PLANTARIF.COD_TIPLAN%TYPE;
        LV_TIPLANDES   TA_PLANTARIF.COD_TIPLAN%TYPE;
        LV_POSTPAGO    TA_PLANTARIF.COD_TIPLAN%TYPE;
        LV_HIBRIDO     TA_PLANTARIF.COD_TIPLAN%TYPE;


        ------------------------------------------------

        LV_APLICA_ATL            GED_PARAMETROS.VAL_PARAMETRO%TYPE;


        CV_codmodulo     CONSTANT VARCHAR2(2)   := 'GA';
        CV_codmodulo_aux CONSTANT VARCHAR2(2)   := 'GE';

        CN_producto  CONSTANT number        := 1;
        CV_tabla     CONSTANT VARCHAR2(12)  := 'TA_PLANTARIF';
        CV_columna   CONSTANT VARCHAR2(10)  := 'COD_TIPLAN';
        CV_postpago  CONSTANT VARCHAR2(8)   := 'POSTPAGO';
        CV_hibrido   CONSTANT VARCHAR2(7)   := 'HIBRIDO';



BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);

    LV_ABONADO          := string(5);
        LV_PLANDESTINO  := string(12);


        LV_APLICA_ATL := PV_OBTIENEINFO_ATLANTIDA_PG.PV_OBTIENE_PARAM_VISTA_FN(CV_codmodulo, 'APLICA_ATLANTIDA');

        IF LV_APLICA_ATL ='FALSE' THEN
           SV_MENSAJE   := '';
           SV_RESULTADO := 'TRUE';

        ELSE

      SELECT  COD_PLANTARIF
          INTO  LV_PLANORIGEN
          FROM GA_ABOCEL
          WHERE
          NUM_ABONADO  =  LV_ABONADO;

          SELECT  COD_TIPLAN
          INTO  LV_TIPLANORI
          FROM TA_PLANTARIF
          WHERE
          COD_PRODUCTO  =  CN_producto AND
          COD_PLANTARIF =  LV_PLANORIGEN;


          SELECT  COD_TIPLAN
          INTO  LV_TIPLANDES
          FROM TA_PLANTARIF
          WHERE
          COD_PRODUCTO  =  CN_producto AND
          COD_PLANTARIF =  LV_PLANDESTINO;


          SELECT  COD_VALOR
          INTO LV_POSTPAGO
          FROM  GED_CODIGOS
          WHERE
          COD_MODULO  = CV_codmodulo_aux AND
          NOM_TABLA   = CV_tabla     AND
          NOM_COLUMNA = CV_columna   AND
          TRIM(DES_VALOR)   = CV_postpago;


          SELECT  COD_VALOR
          INTO LV_HIBRIDO
          FROM  GED_CODIGOS
          WHERE
          COD_MODULO  = CV_codmodulo_aux AND
          NOM_TABLA   = CV_tabla     AND
          NOM_COLUMNA = CV_columna   AND
          TRIM(DES_VALOR)   = CV_hibrido;


          IF (LV_TIPLANORI = LV_POSTPAGO AND  LV_TIPLANDES = LV_POSTPAGO) OR (LV_TIPLANORI = LV_HIBRIDO AND  LV_TIPLANDES = LV_HIBRIDO) THEN
                 SV_MENSAJE   := ' ';
                 SV_RESULTADO := 'TRUE';


          ELSE
                 -- XO-200605251112 26.05.2006
                 SV_MENSAJE   := 'No se puede realizar traspaso entre productos diferentes, sólo debe ser de POSTPAGO A POSTPAGO o HIBRIDO A HIBRIDO';
                 SV_RESULTADO := 'FALSE';
          END IF;
    END IF;

EXCEPTION

     WHEN NO_DATA_FOUND THEN
          SV_MENSAJE   := 'ERROR EN PV_VALPLANES_ATLAN_PR: NO SE PUEDE VALIDAR PLANES , NO EXISTEN PLANES';
                  SV_RESULTADO := 'FALSE';


     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VALPLANES_ATLAN_PR: NO SE PUEDE VALIDAR PLANES';
                  SV_RESULTADO := 'FALSE';
END PV_VALPLANES_ATLAN_PR;
/
SHOW ERRORS
