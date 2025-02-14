CREATE OR REPLACE PACKAGE BODY AL_PARAMETROS_MULTIPLES_D_PG
IS
  CODIGO_MODULO CONSTANT VARCHAR2(2) := 'AL';


  FUNCTION AL_ELIMINAR_PADRE_FN
               (EN_codigo IN ge_parametros_td.cod_parametro%TYPE
               )
      RETURN NUMBER
         /*<Documentacion TipoDoc = "Funci¢n">
        <Elemento Nombre = "AL_ELIMINAR_PADRE_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise?ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
        <Retorno>NUMBER</Retorno>
        <Descripcion>Elimina logicamente  un parametro del tipo multiple (con hijos)/Descripci¢n>
        <Parametros>
        <Entrada>
        <param nom="EN_codigo" Tipo="NUMBER">Codigo del parametro</param>
        </Entrada>
        <Salida>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentaci¢n>
        */
  IS
      LN_registros_afectados NUMBER;

          BEGIN
              LN_registros_afectados := GE_PARAMETROS_MUL_KNL_D_PG.GE_ELIMINAR_PADRE_FN(EN_codigo , CODIGO_MODULO);
                  RETURN LN_registros_afectados;

          EXCEPTION
              WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR(-20100, 'Error en AL_PARAMETROS_MULTIPLES_D_PG ' || TO_CHAR(SQLCODE) || ': ' || SQLERRM);
  END AL_ELIMINAR_PADRE_FN;

  FUNCTION AL_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
               )
      RETURN NUMBER
         /*<Documentacion TipoDoc = "Funci¢n">
        <Elemento Nombre = "AL_ELIMINAR_HIJO_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise?ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
        <Retorno>NUMBER</Retorno>
        <Descripcion>Elimina logicamente  un parametro del tipo multiple (con hijos)/Descripci¢n>
        <Parametros>
        <Entrada>
        <param nom="EN_codigo_padre" Tipo="NUMBER">Codigo padre del parametro</param>
        <param nom="EN_codigo_hijo" Tipo="NUMBER">Codigo del parametro a eliminar</param>
        </Entrada>
        <Salida>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentaci¢n>
        */
  IS
      LN_registros_afectados NUMBER;
          BEGIN

              LN_registros_afectados := GE_PARAMETROS_MUL_KNL_D_PG.GE_ELIMINAR_HIJO_FN(EN_codigo_padre,EN_codigo_hijo, CODIGO_MODULO);
                  RETURN LN_registros_afectados;

          RETURN  LN_registros_afectados;

          EXCEPTION
              WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR(-20100, 'Error en AL_PARAMETROS_MULTIPLES_D_PG ' || TO_CHAR(SQLCODE) || ': ' || SQLERRM);
  END AL_ELIMINAR_HIJO_FN;

 END AL_PARAMETROS_MULTIPLES_D_PG;
/
SHOW ERRORS
