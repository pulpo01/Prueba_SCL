CREATE OR REPLACE PACKAGE BODY FA_GESTION_ERRORES_PG IS


FUNCTION Fa_DeterminaInsert_Fn(EN_NumProceso IN NUMBER, EN_CodCliente IN NUMBER)  RETURN NUMBER IS
/*
<Documentación TipoDoc = "Función">
   <Elemento Nombre = "Fa_DeterminaInsert_Fn" Lenguaje="PL/SQL" Fecha="26-12-2005" Versión="1.0" Diseñador="Fabian Aedo" Programador="Fabián Aedo" Ambiente="BD">
   <Retorno>NUMBER</Retorno>
   <Descripción>Permite determinar el insert a realizar.. fa_anoproceso o fa_detanoproceso_td.</Descripción>
   <Parámetros>
   <Entrada>
      <param nom="EN_NumProceso" Tipo="NUMBER">Número de Proceso de Facturación</param>
      <param nom="EN_CodCliente" Tipo="NUMBER">Código del Cliente Facturado con Error</param>
   <Salida>
          <out Tipo="NUMBER">0: Se debe insertar error en tabla fa_anoproceso;
                                                 1: Se debe insertar error en tabla fa_detanoproceso_td.</Salida>
   </Parámetros>
   </Elemento>
</Documentación>
*/
LN_Existe       NUMBER(1) := 0;
BEGIN
                BEGIN
                SELECT
                                        1
                        INTO
                                        LN_Existe
                                FROM
                                                fa_anoproceso
                                WHERE
                                                num_proceso = EN_NumProceso
                                AND             cod_cliente = EN_CodCliente;

                EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                                        LN_Existe := 0;
                                WHEN OTHERS THEN
                                        RAISE_APPLICATION_ERROR(-20002,'ERROR DETERMINANDO INSERCION DE DETALLE DE ERROR. '||SUBSTR(SQLERRM, 1, 100), FALSE);
                END;

                RETURN LN_Existe;

END Fa_DeterminaInsert_Fn;


FUNCTION Fa_ObtieneSeqRecorrido_Fn(EN_NumProceso IN NUMBER, EN_CodCliente IN NUMBER)  RETURN NUMBER IS
/*
<Documentación TipoDoc = "Función">
   <Elemento Nombre = "Fa_ObtieneSeqRecorrido_Fn" Lenguaje="PL/SQL" Fecha="22-12-2005" Versión="1.0" Diseñador="Fabian Aedo" Programador="Fabián Aedo" Ambiente="BD">
   <Retorno>NUMBER</Retorno>
   <Descripción>Retorna la siguiente sequencia a utilizar en la tabla de recorrido del error.</Descripción>
   <Parámetros>
   <Entrada>
      <param nom="EN_NumProceso" Tipo="NUMBER">Número de Proceso de Facturación</param>
      <param nom="EN_CodCliente" Tipo="NUMBER">Código del Cliente Facturado con Error</param>
   <Salida>
          <out Tipo="NUMBER">Siguiente sequencia a utilizar en tabla fa_detanoproceso_td.seq_recorrido</Salida>
   </Parámetros>
   </Elemento>
</Documentación>
*/
LN_seq_recorrido        fa_detanoproceso_td.seq_recorrido%type;
BEGIN
                BEGIN
                SELECT
                                        NVL(MAX(seq_recorrido) , 0)
                        INTO
                                        LN_seq_recorrido
                                FROM
                                                fa_detanoproceso_td
                                WHERE
                                                num_proceso = EN_NumProceso
                                AND             cod_cliente = EN_CodCliente;

                EXCEPTION
                                WHEN OTHERS THEN
                                                        LN_seq_recorrido := 0;
                END;

                RETURN LN_seq_recorrido +1;

END Fa_ObtieneSeqRecorrido_Fn;
PROCEDURE Fa_InsertaAnoProceso_Pr(ER_regAnoProceso IN FA_ANOPROCESO%ROWTYPE) IS
/*
<Documentación TipoDoc = "Procedimiento">
   <Elemento Nombre = "Fa_InsertaAnoProceso_Pr" Lenguaje="PL/SQL" Fecha="22-12-2005" Versión="1.0" Diseñador="Fabian Aedo" Programador="Fabián Aedo" Ambiente="BD">
   <Retorno>N/A</Retorno>
   <Descripción>Inserta un registro en tabla FA_ANOPROCESO</Descripción>
   <Parámetros>
   <Entrada>
      <param nom="ER_regAnoProceso" Tipo="FA_ANOPROCESO%ROWTYPE"></param>
        Salida>
    </Salida>
   </Parámetros>
   </Elemento>
</Documentación>
*/
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
        BEGIN
                INSERT INTO fa_anoproceso (
                                                num_proceso, cod_cliente, cod_concepto, cod_producto, cod_ciclfact, num_abonado,
                                                des_proceso, cod_anomalia, obs_anomalia )
                                VALUES (
                                                ER_regAnoProceso.num_proceso,
                                                ER_regAnoProceso.cod_cliente,
                                                ER_regAnoProceso.cod_concepto,
                                                ER_regAnoProceso.cod_producto,
                                                ER_regAnoProceso.cod_ciclfact,
                                                ER_regAnoProceso.num_abonado,
                                                ER_regAnoProceso.des_proceso,
                                                ER_regAnoProceso.cod_anomalia,
                                                ER_regAnoProceso.obs_anomalia);
                                EXCEPTION
                                WHEN OTHERS THEN
                                RAISE_APPLICATION_ERROR(-20002,'ERROR INSERTANDO REGISTRO EN TABLA FA_ANOPROCESO. '||SUBSTR(SQLERRM, 1, 100), FALSE);
                END;
                COMMIT;
EXCEPTION
                WHEN OTHERS THEN
                                ROLLBACK;
                                RAISE;
END Fa_InsertaAnoProceso_Pr;

PROCEDURE Fa_InsertaDetAnoProceso_Pr(ER_regDetAnoProceso IN FA_DETANOPROCESO_TD%ROWTYPE) IS
/*
<Documentación TipoDoc = "Procedimiento">
   <Elemento Nombre = "Fa_InsertaDetAnoProceso_Pr" Lenguaje="PL/SQL" Fecha="22-12-2005" Versión="1.0" Diseñador="Fabian Aedo" Programador="Fabián Aedo" Ambiente="BD">
   <Retorno>N/A</Retorno>
   <Descripción>Inserta un registro en tabla FA_DETANOPROCESO_TD</Descripción>
   <Parámetros>
   <Entrada>
      <param nom="ER_regDetAnoProceso" Tipo="FA_DETANOPROCESO_TD%ROWTYPE"></param>
        Salida>
    </Salida>
   </Parámetros>
   </Elemento>
</Documentación>
*/
PRAGMA AUTONOMOUS_TRANSACTION;
LN_seq_recorrido        fa_detanoproceso_td.seq_recorrido%type;
BEGIN
        LN_seq_recorrido := Fa_ObtieneSeqRecorrido_Fn(ER_regDetAnoProceso.num_proceso, ER_regDetAnoProceso.cod_cliente);
        BEGIN
                INSERT INTO fa_detanoproceso_td (
                                num_proceso, cod_cliente, seq_recorrido, des_recorrido)
                                VALUES (

                                                ER_regDetAnoProceso.num_proceso,
                                                ER_regDetAnoProceso.cod_cliente,
                                                LN_seq_recorrido,
                                                ER_regDetAnoProceso.des_recorrido);
                                EXCEPTION
                                WHEN OTHERS THEN
                                RAISE_APPLICATION_ERROR(-20002,'ERROR INSERTANDO REGISTRO EN TABLA FA_DETANOPROCESO_TD. '||SUBSTR(SQLERRM, 1, 100), FALSE);
                END;
                COMMIT;
EXCEPTION
                WHEN OTHERS THEN
                                ROLLBACK;
                                RAISE;
END Fa_InsertaDetAnoProceso_Pr;

PROCEDURE Fa_InsertaAnomalia_Pr(ER_regAnoProceso IN FA_ANOPROCESO%ROWTYPE) IS
/*
<Documentación TipoDoc = "Procedimiento">
   <Elemento Nombre = "Fa_InsertaAnoProceso_Pr" Lenguaje="PL/SQL" Fecha="22-12-2005" Versión="1.0" Diseñador="Fabian Aedo" Programador="Fabián Aedo" Ambiente="BD">
   <Retorno>N/A</Retorno>
   <Descripción>Inserta un registro en tabla FA_ANOPROCESO</Descripción>
   <Parámetros>
   <Entrada>
      <param nom="ER_regAnoProceso" Tipo="FA_ANOPROCESO%ROWTYPE"></param>
        Salida>
    </Salida>
   </Parámetros>
   </Elemento>
</Documentación>
*/
LS_regDetAnoProceso     fa_detanoproceso_td%ROWTYPE;
LN_Inserta                      NUMBER;
BEGIN
                LN_Inserta := Fa_DeterminaInsert_Fn(ER_regAnoProceso.num_proceso, ER_regAnoProceso.cod_cliente);
                IF LN_Inserta = 0 THEN
                        /* Inserta en FA_ANOPROCESO */
                        Fa_InsertaAnoProceso_Pr(ER_regAnoProceso);
                ELSE
                        /* Inserta en FA_DETANOPROCESO_TD */
                        LS_regDetAnoProceso.num_proceso         := ER_regAnoProceso.num_proceso;
                        LS_regDetAnoProceso.cod_cliente     := NVL(ER_regAnoProceso.cod_cliente, -1);
                        LS_regDetAnoProceso.seq_recorrido   := 0;
                        LS_regDetAnoProceso.des_recorrido   := NVL(ER_regAnoProceso.obs_anomalia, 'Error en proceso indefinido.');
                        Fa_InsertaDetAnoProceso_Pr(LS_regDetAnoProceso);
                END IF;

EXCEPTION
        WHEN OTHERS THEN
                        RAISE;
END Fa_InsertaAnomalia_Pr;

END FA_GESTION_ERRORES_PG;
/
SHOW ERRORS
