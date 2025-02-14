CREATE OR REPLACE package body PV_RESULTADOS_PG IS

        PROCEDURE PV_RESULTADO_PR
        (
          EV_transac in varchar2,
          EN_cod_cliente in number
        )IS

          /*
                <Documentación TipoDoc = "Prcedimiento">
                <Elemento
                        Nombre = "PV_RESULTADO_PR"
                        Lenguaje="PL/SQL"
                        Fecha="19-04-2007"
                        Versión="1.1.0"
                        Diseñador="Yesenia Osses"
                        Programador="Yesenia Osses"
                        Ambiente="BD">
                <Retorno>NA</Retorno>
                <Descripción>Llama a procedimientos de Mix_06003_G1</Descripción>
                <Parámetros>
                    <Entrada>
                        <param nom="EV_transac" Tipo="VARCHAR2">Numero transaccion</param>
                                <param nom="EN_cod_cliente" Tipo="NUMBER>Codigo cliente</param>
                    </Entrada>
                    <Salida>
                        <param nom="Parametro2" Tipo="VARCHAR2">Descripción Parametro2</param>
                        <param nom="Parametro3" Tipo="VARCHAR2">Descripción Parametro3</param>
                    </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
     */



        validacion varchar2(1);
        respuesta number;
        mensaje varchar2(255);
        error number;
        empresa number;

        BEGIN

       SELECT distinct 1 into empresa FROM GA_EMPRESA WHERE COD_CLIENTE = EN_cod_cliente; --Verifica si es  empresa

                IF empresa = 1 THEN

                        VE_ABONADO_0_PG.VE_VALIDA_ABONADO_PR (EN_cod_cliente,validacion,respuesta,mensaje);

                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
                        VALUES(TO_NUMBER(EV_transac),respuesta,validacion);

                END IF;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA) -- Inserta valores
                        VALUES(TO_NUMBER(EV_transac),'5','El abonado no es empresa.');


        END PV_RESULTADO_PR;
/*-----------------------------------------------------------------------------------------------------------*/

        PROCEDURE PV_RESULTADO_DOS_PR
        (
          EV_transac in varchar2,
          EN_cod_cliente in number
        )IS

                  /*
                <Documentación TipoDoc = "Prcedimiento">
                <Elemento
                        Nombre = "PV_RESULTADO_DOS_PR"
                        Lenguaje="PL/SQL"
                        Fecha="19-04-2007"
                        Versión="1.1.0"
                        Diseñador="Yesenia Osses"
                        Programador="Yesenia Osses"
                        Ambiente="BD">
                <Retorno>NA</Retorno>
                <Descripción>Llama a procedimientos de Mix_06003_G1</Descripción>
                <Parámetros>
                    <Entrada>
                        <param nom="EV_transac" Tipo="VARCHAR2">Numero transaccion</param>
                                <param nom="EN_cod_cliente" Tipo="NUMBER>Codigo cliente</param>
                    </Entrada>
                    <Salida>
                        <param nom="Parametro2" Tipo="VARCHAR2">Descripción Parametro2</param>
                        <param nom="Parametro3" Tipo="VARCHAR2">Descripción Parametro3</param>
                    </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
     */

        resultado varchar(20);
        error number;
        fecha date;
        des_cadena1 varchar(20);


        BEGIN
        fecha:= SYSDATE;

                resultado := PV_BOLSAS_DINAMICAS_PG.PV_CNSLTA_CARBASICOCLTE_FN (EN_cod_cliente,fecha);

                        IF resultado = '-1' THEN
                            resultado := '0';
                                des_cadena1 := ' ';

                        ELSIF  length(resultado) < -1 THEN
                                resultado := '0';
                                des_cadena1 := 'E';
                        END IF;

                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA) -- Inserta valores
                        VALUES(TO_NUMBER(EV_transac),TO_NUMBER(resultado),des_cadena1);

        EXCEPTION
                WHEN OTHERS THEN
                     error := '4';
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA) -- Inserta valores
                        VALUES(TO_NUMBER(EV_transac),TO_NUMBER(error),null);

        END PV_RESULTADO_DOS_PR;

PROCEDURE PV_RESULTADO_PR
        (
          EV_transac in varchar2,
          EN_cod_cliente in number,
          EN_num_abonado in GA_ABOCEL.NUM_ABONADO%TYPE
        )IS
          /*
                <Documentación TipoDoc = "Prcedimiento">
                <Elemento
                        Nombre = "PV_RESULTADO_PR"
                        Lenguaje="PL/SQL"
                        Fecha="19-04-2007"
                        Versión="1.1.0"
                        Diseñador="NRCA"
                        Programador="NRCA"
                        Ambiente="BD">
                <Retorno>NA</Retorno>
                <Descripción>Llama a procedimientos de Mix_06003_G1</Descripción>
                <Parámetros>
                    <Entrada>
                        <param nom="EV_transac" Tipo="VARCHAR2">Numero transaccion</param>
                                <param nom="EN_cod_cliente" Tipo="NUMBER>Codigo cliente</param>
                    </Entrada>
                    <Salida>
                        <param nom="Parametro2" Tipo="VARCHAR2">Descripción Parametro2</param>
                        <param nom="Parametro3" Tipo="VARCHAR2">Descripción Parametro3</param>
                    </Salida>
                </Parámetros>
                </Elemento>
                </Documentación>
     */

        TYPE cursorTYPE IS REF CURSOR;  -- define control ref cursor type  --
        cursor_ga_infaccel cursorTYPE;  -- declare cursor variable         --
        LV_sql     varchar2(1000):='';

        LV_cod_ciclfact varchar2(6);
        validacion varchar2(1);
        respuesta number;
        mensaje varchar2(255);
        error number;
        empresa number;
        LV_CICLFACTBAJA   FA_CICLFACT.COD_CICLFACT%TYPE;
        LV_CICLFACTACTUAL FA_CICLFACT.COD_CICLFACT%TYPE;
        LV_FECHA_BAJA DATE;
        LV_FECHA_ALTA DATE;
        LV_CICLO GE_CLIENTES.COD_CICLO%TYPE;

        LV_ciclo1_old varchar2(6);
        LV_ciclo1   varchar2(6);
        LV_ciclo1_4 varchar2(4);
        LV_ciclo1_2 varchar2(2);
BEGIN

       SELECT distinct 1 into empresa FROM GA_EMPRESA WHERE COD_CLIENTE = EN_cod_cliente; --Verifica si es  empresa
       IF empresa = 1 THEN

          --se obtiene ciclo de facturacion
                    SELECT COD_CICLO
                        INTO LV_CICLO
                        FROM GE_CLIENTES
                        WHERE COD_CLIENTE=EN_COD_CLIENTE;


           --Obtenemos parametro de codigo ciclo de facturacion actual
          SELECT COD_CICLFACT
                  INTO LV_CICLFACTACTUAL
                  FROM FA_CICLFACT
                  WHERE SYSDATE
                  BETWEEN FEC_DESDELLAM
                  AND FEC_HASTALLAM
                  AND COD_CICLO=LV_CICLO;


          --Se obtiene fecha de baja de ga_infaccel para abonado y cliente
          SELECT MAX (FEC_ALTA)
          INTO LV_FECHA_ALTA
                  FROM GA_INFACCEL
          WHERE COD_CLIENTE = EN_COD_CLIENTE
                  AND NUM_ABONADO = EN_NUM_ABONADO
          AND FEC_BAJA <= SYSDATE;


          --SELECT MIN(COD_CICLFACT)
          --INTO LV_CICLFACTBAJA
          --FROM GA_INFACCEL
          --WHERE COD_CLIENTE = EN_COD_CLIENTE
          --AND NUM_ABONADO = EN_NUM_ABONADO
          --AND FEC_ALTA = LV_FECHA_ALTA
          --AND IND_ACTUAC=2;

          LV_sql := 'SELECT COD_CICLFACT ';
          LV_sql := LV_sql || ' FROM GA_INFACCEL ';
          LV_sql := LV_sql || ' WHERE COD_CLIENTE = :1';
          LV_sql := LV_sql || ' AND NUM_ABONADO = :2 ';
          LV_sql := LV_sql || ' AND FEC_ALTA = :3';
          LV_sql := LV_sql || ' AND IND_ACTUAC= :4 ';

          LV_ciclo1_old:=0;
          OPEN cursor_ga_infaccel FOR LV_sql USING EN_COD_CLIENTE,EN_NUM_ABONADO,LV_FECHA_ALTA,2;
          LOOP
             FETCH cursor_ga_infaccel INTO LV_cod_ciclfact;
             EXIT WHEN cursor_ga_infaccel%NOTFOUND;

            if length(LV_cod_ciclfact) = 6 then
               LV_ciclo1_4 :=substr(LV_cod_ciclfact,1,4);
               LV_ciclo1_2 :=substr(LV_cod_ciclfact,5,2);
            else
               LV_ciclo1_4 :=substr(LV_cod_ciclfact,1,3);
               LV_ciclo1_2 :=substr(LV_cod_ciclfact,4,2);
            end if;

            LV_ciclo1 := LV_ciclo1_2 || LV_ciclo1_4;

            if to_number(LV_ciclo1_old) =0 then
                LV_ciclo1_old :=LV_ciclo1;
            elsif to_number(LV_ciclo1) > to_number(LV_ciclo1_old) then
                LV_ciclo1_old :=LV_ciclo1_old;
            else
                LV_ciclo1_old := LV_ciclo1;
            end if;
          END LOOP;
          CLOSE cursor_ga_infaccel;

          LV_ciclo1_4 :=substr(LV_ciclo1_old,3);
          LV_ciclo1_2 :=substr(LV_ciclo1_old,1,2);
          LV_ciclo1_old:=LV_ciclo1_4||LV_ciclo1_2;
          LV_CICLFACTBAJA:= LV_ciclo1_old;

          IF LV_CICLFACTBAJA = LV_CICLFACTACTUAL THEN
             RAISE NO_DATA_FOUND;
          END IF;

          VE_ABONADO_0_PG.VE_VALIDA_ABONADO_PR (EN_cod_cliente,validacion,respuesta,mensaje);

          INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA)
          VALUES(TO_NUMBER(EV_transac),respuesta,validacion);

        END IF;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,COD_RETORNO,DES_CADENA) -- Inserta valores
                        VALUES(TO_NUMBER(EV_transac),'5','El abonado no es empresa.');

        END PV_RESULTADO_PR;
END PV_RESULTADOS_PG;
/
SHOW ERRORS
