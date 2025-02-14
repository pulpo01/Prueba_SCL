CREATE OR REPLACE package body PV_CONSULTA_SERIENEGATIVAS_PG IS
        PROCEDURE PV_SERIES_NEGATIVAS_PR
        ( EV_SERIE IN VARCHAR2,
          EV_SALIDA OUT BOOLEAN
        )IS

          /*
                <Documentación TipoDoc = "Prcedimiento">
                <Elemento
                        Nombre = "PV_SERIES_NEGATIVAS_PR"
                        Lenguaje="PL/SQL"
                        Fecha="09-11-2007"
                        Versión="1.1.0"
                        Diseñador=""
                        Programador=""
                        Ambiente="BD">
                <Retorno>NA</Retorno>
                <Descripción>Llama a procedimientos de Mix_06003</Descripción>
                <Parámetros>
                    <Entrada>
                                <param nom="EV_SERIE" Tipo="NUMBER>Numero serie /param>
                    </Entrada>
                    <Salida>
                        <param nom="EV_SALIDA" Tipo="boolean">Numero error que toma segun sea el caso</param>
                    </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
     */
          P_DESERROR VARCHAR2(100);
          P_CODERROR NUMBER(3);
          v_es_negativo boolean;

        BEGIN
                EV_SALIDA := FALSE;

                PAC_NSR_NEG.P_CONS_NSR_NEG(EV_SERIE,
                             v_es_negativo,
                             P_CODERROR,
                             P_DESERROR);

                        if v_es_negativo then
                                EV_SALIDA := TRUE;
                        end if;



        END PV_SERIES_NEGATIVAS_PR;
END PV_CONSULTA_SERIENEGATIVAS_PG;
/
SHOW ERRORS
