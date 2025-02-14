CREATE OR REPLACE FUNCTION GE_EJECUTA_PERFILES_FN (V_USUARIO IN GE_PERFIL_TO.NOM_USUARIO%TYPE,
           V_PERFIL IN GE_PERFIL_TO.NOM_PERFIL%TYPE, V_PARAM_ENTRADA VARCHAR2 ) RETURN VARCHAR2
---------------------------------------------------------------------------------------------
-- Funcion de Validacion de Perfiles
-- Autor   : Maritza Tapia A
-- Fecha   : 02 Enero de 2003
---------------------------------------------------------------------------------------------
         IS
     Error_Proceso_General  EXCEPTION;
     V_GLOSA_ERROR  VARCHAR2(20);
         V_GRUPO        GE_PERFIL_GRUPO_TO.COD_GRUPO%TYPE;
         V_NOM_PERFIL   GE_PERFIL_TO.NOM_PERFIL%TYPE;
     V_PARAM_SALIDA VARCHAR2(2000) := '';
         V_COMANDO_SQL  VARCHAR2(2000);
         V_SIGUE                BOOLEAN;
         V_GRPUSUARIO   GE_SEG_GRPUSUARIO.COD_GRUPO%TYPE;

---------------------------------------------------------------------------------------------
-- CURSOR : Los grupos asociados al perfil
---------------------------------------------------------------------------------------------
        CURSOR GRUPO_PERFIL IS
        SELECT  COD_GRUPO
        FROM    GE_PERFIL_GRUPO_TO
        WHERE   NOM_PERFIL = v_perfil;

        BEGIN
        v_sigue:=TRUE;
---------------------------------------------------------------------------------------------
-- Validacion  parametros de entrada
---------------------------------------------------------------------------------------------
          IF V_USUARIO IS NULL OR V_USUARIO = '' THEN
                    V_PARAM_SALIDA := 'ERROR GE_EJECUTA_PERFILES_FN: Parametro de entrada, Usuario';
                        RAISE ERROR_PROCESO_GENERAL;
                        V_SIGUE:=FALSE;
          END IF;
          IF V_PERFIL IS NULL OR V_PERFIL = '' THEN
                        V_PARAM_SALIDA := 'ERROR GE_EJECUTA_PERFILES_FN: Parametro de entrada, Perfil';
                        RAISE  ERROR_PROCESO_GENERAL;
                        V_SIGUE:=FALSE;
          END IF;

---------------------------------------------------------------------------------------------
-- Valida que exista el perfil
---------------------------------------------------------------------------------------------
        BEGIN
           SELECT NOM_PERFIL INTO V_NOM_PERFIL
           FROM  GE_PERFIL_TO
           WHERE NOM_PERFIL = V_PERFIL;

           EXCEPTION
                    WHEN NO_DATA_FOUND  THEN
                        V_PARAM_SALIDA := 'TRUE';
                        RAISE  ERROR_PROCESO_GENERAL;
                        V_SIGUE:=FALSE;
        END;

---------------------------------------------------------------------------------------------
-- Valida que exista el usuario asociado al grupo
---------------------------------------------------------------------------------------------

        OPEN GRUPO_PERFIL;
        LOOP
                FETCH GRUPO_PERFIL INTO V_GRUPO;
                BEGIN
                   SELECT COD_GRUPO INTO V_GRPUSUARIO
                   FROM GE_SEG_GRPUSUARIO
                   WHERE COD_GRUPO = V_GRUPO
                   AND   NOM_USUARIO = V_USUARIO;
                EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                                V_SIGUE:=FALSE;
                            V_PARAM_SALIDA := 'TRUE';
                                RAISE  ERROR_PROCESO_GENERAL;
           END;
           EXIT WHEN GRUPO_PERFIL%NOTFOUND;
        END LOOP;
        CLOSE GRUPO_PERFIL;

---------------------------------------------------------------------------------------------
--Ejecuta el Perfil
---------------------------------------------------------------------------------------------

        IF V_SIGUE THEN
      IF TRIM(V_PARAM_ENTRADA) = '' OR V_PARAM_ENTRADA IS NULL THEN
         V_COMANDO_SQL:='SELECT '||V_PERFIL||' FROM DUAL';
         EXECUTE IMMEDIATE V_COMANDO_SQL INTO V_PARAM_SALIDA;
          ELSE
             V_COMANDO_SQL:='SELECT '||V_PERFIL||'('||V_PARAM_ENTRADA||') FROM DUAL';
         EXECUTE IMMEDIATE V_COMANDO_SQL INTO V_PARAM_SALIDA;
          END IF;
        END IF;

        RETURN V_PARAM_SALIDA;
---------------------------------------------------------------------------------------------
-- Control de errores
---------------------------------------------------------------------------------------------
        EXCEPTION
                 WHEN ERROR_PROCESO_GENERAL THEN
                  RETURN V_PARAM_SALIDA;
                 WHEN NO_DATA_FOUND THEN
                      RETURN 'ERROR GE_EJECUTA_PERFILES_FN: No existe datos';
             WHEN OTHERS THEN
                  RETURN 'ERROR GE_EJECUTA_PERFILES_FN, SQLERRM : ' || SQLERRM;
END GE_EJECUTA_PERFILES_FN;
/
SHOW ERRORS
