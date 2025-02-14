CREATE OR REPLACE PACKAGE cm_extractores_pg
/*
<Documentacisn TipoDoc = "Package">
   <Elemento Nombre = "cm_extractores_pg" Lenguaje="PL/SQL" Fecha="06-05-2005" Versisn="1.0" Diseqador="Fabian Aedo" Programador="Fabian Aedo" Ambiente="BD">
   <Retorno>N/A</Retorno>
   <Descripcisn>Descripcisn</Descripcisn>
   <Parametros>
   <Entrada>
      <param nom="" Tipo="">N/A</param>
   <Salida>
      <param nom="" Tipo="">N/A</param>
   </Salida>
   </Parametros>
   </Elemento>
</Documentacisn>
*/
IS
/*
<Documentacisn TipoDoc = "constante">
   <Elemento Nombre = "constantes" Fecha="05-06-2005">
      <Descripcisn>Definicisn de constantes del package</Descripcisn>
      <Constantes>
         <Const Nombre="CS_est_iniciado">Proceso iniciado</Const>
         <Const Nombre="CS_est_term_ok">Proceso terminado con exito</Const>
         <Const Nombre="CS_est_term_error">Proceso terminado con error</Const>
         <Const Nombre="CS_est_no_iniciado">Proceso no iniciado</Const>
         <Const Nombre="CN_crea_traza">Crea traza</Const>
         <Const Nombre="CN_cierra_traza_exito">Cierra traza con ixito</Const>
         <Const Nombre="CN_cierra_traza_error">Cierra traza con error</Const>
      </Constantes>
   </Elemento>
</Documentacisn>
*/
        CS_est_iniciado         CONSTANT CM_EJECUTA_PROCESOS_TD.COD_ESTAPROC%TYPE := 'I';
        CS_est_term_exito       CONSTANT CM_EJECUTA_PROCESOS_TD.COD_ESTAPROC%TYPE := 'T';
        CS_est_term_error       CONSTANT CM_EJECUTA_PROCESOS_TD.COD_ESTAPROC%TYPE := 'F';
        CS_est_no_iniciado      CONSTANT CM_EJECUTA_PROCESOS_TD.COD_ESTAPROC%TYPE := 'N';
        CN_crea_traza           CONSTANT NUMBER(1) := 1;
        CN_cierra_traza_exito   CONSTANT NUMBER(1) := 2;
        CN_cierra_traza_error   CONSTANT NUMBER(1) := 3;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION cm_acttrazextractores_fn(EN_num_secuencia IN NUMBER,
                                  ES_num_proceso   IN VARCHAR2,
                                  EN_cod_error     IN NUMBER,
                                  ES_gls_error     IN VARCHAR2,
                                  EN_cod_accion    IN NUMBER) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION cm_acttrazarchivos_fn(ES_archivo       IN VARCHAR2,
                               ES_universo      IN VARCHAR2,
                               EN_num_secuencia IN NUMBER,
                               ES_ubicacion     IN VARCHAR2,
                               EN_num_registros IN NUMBER,
                               ES_nom_usuario   IN VARCHAR2) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION cm_marcaestadoextractor_fn(EN_num_secuencia IN NUMBER,
                                    ES_nuevo_estado  IN VARCHAR2) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END cm_extractores_pg;
/
SHOW ERRORS
