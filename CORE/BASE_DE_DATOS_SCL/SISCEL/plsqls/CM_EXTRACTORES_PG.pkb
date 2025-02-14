CREATE OR REPLACE PACKAGE BODY cm_extractores_pg
IS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION cm_acttrazextractores_fn(EN_num_secuencia IN NUMBER,
                                  ES_num_proceso   IN VARCHAR2,
                                  EN_cod_error     IN NUMBER,
                                  ES_gls_error     IN VARCHAR2,
                                  EN_cod_accion    IN NUMBER) RETURN NUMBER
/*
<Documentacisn TipoDoc = "Funcisn">
   <Elemento Nombre = "cm_acttrazextractores_fn" Lenguaje="PL/SQL" Fecha="06-05-2005" Versisn="1.0" Diseqador="Fabian Aedo" Programador="Fabian Aedo" Ambiente="BD">
   <Retorno>NUMBER</Retorno>
   <Descripcisn>Descripcisn</Descripcisn>
   <Parametros>
   <Entrada>
      <param nom="EN_num_secuencia" Tipo="INTEGER">Secuencia</param>
      <param nom="ES_num_proceso" Tipo="STRING">Numero proceso</param>
      <param nom="EN_cod_error" Tipo="INTEGER">Codigo Error</param>
      <param nom="ES_gls_error" Tipo="STRING">Descripcion error</param>
      <param nom="EN_cod_accion" Tipo="INTEGER">Accion</param>
   <Salida>
      <param nom="" Tipo="">N/A</param>
   </Salida>
   </Parametros>
   </Elemento>
</Documentacisn>
*/
IS
        LS_gls_error cm_ejecuta_procesos_td.gls_ejecucion%TYPE;
        PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
        IF ES_gls_error = 'X' THEN
                LS_gls_error := NULL;
        ELSE
                LS_gls_error := ES_gls_error;
        END IF;
        IF EN_cod_accion = CN_crea_traza THEN
                UPDATE cm_ejecuta_procesos_td
                SET cod_proceso   = ES_num_proceso,
                    cod_estaejec  = CS_est_iniciado
                WHERE seq_proceso = EN_num_secuencia;
        ELSIF EN_cod_accion = CN_cierra_traza_exito THEN
                UPDATE cm_ejecuta_procesos_td
                SET cod_estaejec  = CS_est_term_exito,
                    cod_error     = 0,
                    gls_ejecucion = 'Proceso terminado OK.'
                WHERE seq_proceso = EN_num_secuencia;
        ELSIF EN_cod_accion = CN_cierra_traza_ERROR THEN
                UPDATE cm_ejecuta_procesos_td
                SET cod_estaejec  = CS_est_term_error,
                    cod_error     = EN_cod_error,
                    gls_ejecucion = ES_gls_error
                WHERE seq_proceso = (SELECT MAX(seq_proceso)
                                     FROM cm_ejecuta_procesos_td);
        ELSE
                RAISE_APPLICATION_ERROR(-20002, 'ERROR, Opcion no valida.', FALSE);
        END IF;
        COMMIT;
        RETURN 0;

        EXCEPTION
                WHEN OTHERS THEN
                RETURN 1;
END cm_acttrazextractores_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION cm_acttrazarchivos_fn(ES_archivo       IN VARCHAR2,
                               ES_universo      IN VARCHAR2,
                               EN_num_secuencia IN NUMBER,
                               ES_ubicacion     IN VARCHAR2,
                               EN_num_registros IN NUMBER,
                               ES_nom_usuario   IN VARCHAR2) RETURN NUMBER
/*
<Documentacisn TipoDoc = "Funcisn">
   <Elemento Nombre = "cm_acttrazarchivos_fn" Lenguaje="PL/SQL" Fecha="06-05-2005" Versisn="1.0" Diseqador="Fabian Aedo" Programador="Fabian Aedo" Ambiente="BD">
   <Retorno>NUMBER</Retorno>
   <Descripcisn>Descripcisn</Descripcisn>
   <Parametros>
   <Entrada>
      <param nom="ES_archivo" Tipo="STRING">Archivo</param>
      <param nom="EN_num_secuencia" Tipo="INTEGER">Secuencia</param>
      <param nom="EN_num_registros" Tipo="INTEGER">Numero de registros</param>
   <Salida>
      <param nom="" Tipo="">N/A</param>
   </Salida>
   </Parametros>
   </Elemento>
</Documentacisn>
*/
IS
        PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
        UPDATE cm_archivos_td
        SET seq_proceso        = EN_num_secuencia,
            ubicacion          = ES_ubicacion,
            num_registros      = EN_num_registros,
            usu_ult_generacion = ES_nom_usuario,
            fec_ult_generacion = SYSDATE
        WHERE cod_universo     = ES_universo
        AND cod_archivo        = ES_archivo;
        COMMIT;
        RETURN 0;

        EXCEPTION
                WHEN OTHERS THEN
                RETURN 1;
END cm_acttrazarchivos_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION cm_marcaestadoextractor_fn(EN_num_secuencia IN NUMBER,
                                    ES_nuevo_estado  IN VARCHAR2) RETURN NUMBER
/*
/*
<Documentacisn TipoDoc = "Funcisn">
   <Elemento Nombre = "cm_marcaestadoextractor_fn" Lenguaje="PL/SQL" Fecha="06-05-2005" Versisn="1.0" Diseqador="Fabian Aedo" Programador="Fabian Aedo" Ambiente="BD">
   <Retorno>NUMBER</Retorno>
   <Descripcisn>Descripcisn</Descripcisn>
   <Parametros>
   <Entrada>
      <param nom="EN_num_secuencia" Tipo="INTEGER">Archivo</param>
      <param nom="ES_nuevo_estado" Tipo="STRING">Secuencia</param>
   <Salida>
      <param nom="" Tipo="">N/A</param>
   </Salida>
   </Parametros>
   </Elemento>
</Documentacisn>
*/
IS
        PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
        UPDATE cm_ejecuta_procesos_td
        SET cod_estaproc = ES_nuevo_estado
        WHERE seq_proceso = EN_num_secuencia;
        COMMIT;
        RETURN 0;

        EXCEPTION
                WHEN OTHERS THEN
                RETURN 1;
END cm_marcaestadoextractor_fn;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END cm_extractores_pg;
/
SHOW ERRORS
