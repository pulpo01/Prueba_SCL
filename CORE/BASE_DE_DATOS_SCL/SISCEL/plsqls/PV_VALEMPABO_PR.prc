CREATE OR REPLACE PROCEDURE PV_VALEMPABO_PR (
    EV_cadena_entrada IN  VARCHAR2,
    SV_resultado      OUT NOCOPY VARCHAR2,
    SV_mensaje        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "PV_VALEMPABO_PR" Lenguaje="PL/SQL" Fecha="17-04-2007" Versión="1.2.0" Diseñador="Posventa" Programador="Posventa****" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Descripción</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EV_cadena_entrada" Tipo="VARCHAR2">CADENA CONTIENE NUM_ABONADO</param>
    </Entrada>
    <Salida>
        <param nom="SV_resultado" Tipo="VARCHAR2">Resultado ejecucion</param>
        <param nom="SV_mensaje" Tipo="VARCHAR2">Mensaje Respuesta</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');


                nNum_abonado       GA_ABOCEL.NUM_ABONADO%TYPE;
                vTipEmpresa        GA_ABOCEL.TIP_PLANTARIF%TYPE:='E'; --Tipo de plan tarifario .
                vCodPlantarif      TA_PLANTARIF.COD_PLANTARIF%TYPE;
                --nTipPlan           NUMBER(1) := 3;

                vCodTipPlan        TA_PLANTARIF.COD_TIPLAN%TYPE;
                vTipPlanTarif      TA_PLANTARIF.TIP_PLANTARIF%TYPE;


                ERROR_PROCESO EXCEPTION;

BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_cadena_entrada, string);
        nNum_abonado  := TO_NUMBER(string(5));

        SV_resultado:='TRUE';
                SV_mensaje  := 'OK';

                BEGIN
                   SELECT COD_PLANTARIF
                   INTO   vCodPlantarif
                   FROM   GA_ABOCEL
                   WHERE  NUM_ABONADO = nNum_abonado
                   UNION SELECT COD_PLANTARIF
                   FROM GA_ABOAMIST
                   WHERE  NUM_ABONADO = nNum_abonado
                   AND    ROWNUM = 1;

                EXCEPTION
                   WHEN   NO_DATA_FOUND THEN
                                  SV_mensaje   := 'Error al buscar abonado.';
                                  RAISE ERROR_PROCESO;
                END;

                BEGIN
                   SELECT COD_TIPLAN,TIP_PLANTARIF
                   INTO   vCodTipPlan , vTipPlanTarif
                   FROM   TA_PLANTARIF
                   WHERE  COD_PLANTARIF = vCodPlantarif
                   AND    ROWNUM = 1;
                EXCEPTION
                   WHEN   NO_DATA_FOUND THEN
                                  SV_mensaje   := 'Error al buscar Plan Tarifario.';
                                  RAISE ERROR_PROCESO;
                END;

        IF vTipPlanTarif = vTipEmpresa THEN
                  SV_mensaje   := 'ERROR : ABONADO ES EMPRESA, TRANSACCION NO PERMITIDA';
                          RAISE ERROR_PROCESO;
                END IF;

EXCEPTION
     WHEN ERROR_PROCESO THEN
                                  SV_resultado:='FALSE';

     WHEN OTHERS  THEN
                  SV_resultado:='FALSE';
                  SV_mensaje  :='Error de Acceso ';




END PV_VALEMPABO_PR;
/
SHOW ERRORS
