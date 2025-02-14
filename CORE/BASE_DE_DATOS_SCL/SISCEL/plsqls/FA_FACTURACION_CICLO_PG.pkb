CREATE OR REPLACE PACKAGE BODY FA_FACTURACION_CICLO_PG IS

FUNCTION FA_COD_SEGMENTACION_FN ( EN_Cod_Cliente  NUMBER )
RETURN VARCHAR2
IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_COD_SEGMENTACION_FN" Lenguaje="PL/SQL" Fecha="03-12-2007" Versión="1" Diseñador="****"

Programador="****" Ambiente="BD">
3.  <Retorno>VARCHAR2</Retorno>
4.  <Descripción>Obtiene el codigo de segmentacion de un cliente </Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_codcliente"  Tipo="NUMBER"> Código del cliente a consultar</param>
8.  </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/
    MSG_ERROR_NOCLASIF  VARCHAR2(50):= 'No es posible clasificar el error';
    LV_parametros       VARCHAR2(2000);
    GV_des_Auxiliar     GE_ERRORES_PG.VQUERY;   /* Sub tipo asociado a paquete de errores */
    GV_cod_Retorno      VARCHAR2(6);
    GV_msg_Retorno      VARCHAR2(100);
        SN_num_Evento       NUMBER;

        LN_FlagTabla             NUMBER := 0;
        LN_CONTADOR              NUMBER := 0;
        fdbk                     INTEGER;

        LV_Query                 VARCHAR2(256):= '';
    LN_id_Select_GaValorCli  INTEGER;
    LV_Cod_Valor             VARCHAR(5);

                /*CURSOR c_segmentacion IS
                   SELECT COD_VALOR
                   INTO LV_CodValor
                   FROM GA_VALOR_CLI
                   WHERE COD_CLIENTE = EN_Cod_Cliente;*/

    BEGIN

        LV_Cod_Valor := 0;

        LV_parametros := '';
    LV_parametros := LV_parametros || 'FA_COD_SEGMENTACION_FN(' || EN_Cod_Cliente || ')';

        SELECT count(1)
        INTO LN_FlagTabla
        FROM ALL_TABLES
        WHERE TABLE_NAME = 'GA_VALOR_CLI';


        IF LN_FlagTabla != 1 THEN
         GV_cod_Retorno := '1'; --'Falla controlada en FA_COD_SEGMENTACION_FN'
     IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
            GV_msg_Retorno := MSG_ERROR_NOCLASIF;
     END IF;
     SN_num_Evento := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                            ,'FA'
                            ,GV_msg_Retorno
                            ,'1.0'
                            ,USER
                            ,'FA_COD_SEGMENTACION_FN'
                            ,GV_des_Auxiliar
                            ,SQLCODE
                            ,LV_parametros || '-' || SQLERRM);

           RETURN 0;
        END IF;


        LV_Query := 'SELECT COD_VALOR';
    LV_Query := LV_Query || ' FROM GA_VALOR_CLI';
    LV_Query := LV_Query || ' WHERE COD_CLIENTE = ' || EN_Cod_Cliente ;

        LN_id_Select_GaValorCli := DBMS_SQL.OPEN_CURSOR;

        DBMS_SQL.PARSE(LN_id_Select_GaValorCli, LV_Query, dbms_sql.NATIVE);
        DBMS_SQL.DEFINE_COLUMN(LN_id_Select_GaValorCli, 1,  LV_Cod_Valor,1);

        fdbk := DBMS_SQL.EXECUTE (LN_id_Select_GaValorCli);

        LOOP
        BEGIN
                         EXIT WHEN DBMS_SQL.FETCH_ROWS (LN_id_Select_GaValorCli)= 0 ;



                         LN_CONTADOR:= LN_CONTADOR + 1 ;

                         IF LN_CONTADOR > 1 THEN
                                RETURN -1;
                         END IF;

                         DBMS_SQL.COLUMN_VALUE(LN_id_Select_GaValorCli, 1,  LV_Cod_Valor);
                EXCEPTION
        WHEN NO_DATA_FOUND THEN
                 LV_Cod_Valor := 0;
                         RETURN LV_Cod_Valor;
                END;

        END LOOP; /* FIN CURSOR */




        RETURN LV_Cod_Valor;

 EXCEPTION
     WHEN OTHERS THEN
     GV_cod_Retorno := '101'; --'Falla no controlada en FA_MARCADET_PR'
     IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
            GV_msg_Retorno := MSG_ERROR_NOCLASIF;
     END IF;
     SN_num_Evento := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                            ,'FA'
                            ,GV_msg_Retorno
                            ,'1.0'
                            ,USER
                            ,'FA_COD_SEGMENTACION_FN'
                            ,GV_des_Auxiliar
                            ,SQLCODE
                            ,LV_parametros || '-' || SQLERRM);

         LV_Cod_Valor := 0;
         RETURN LV_Cod_Valor;
END FA_COD_SEGMENTACION_FN;

END FA_FACTURACION_CICLO_PG;
/
SHOW ERRORS
