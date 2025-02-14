CREATE OR REPLACE PACKAGE BODY IC_PARAMETROS_MULTIPLES_D_PG
IS
  CODIGO_MODULO CONSTANT VARCHAR2(2) := 'IC';

  FUNCTION IC_ELIMINAR_HIJO_FN
               (EN_codigo_padre IN ge_parametros_td.cod_parametro_padre%TYPE
               ,EN_codigo_hijo IN ge_parametros_td.cod_parametro%TYPE
               )
      RETURN NUMBER
         /*<Documentacion TipoDoc = "Funci¢n">
        <Elemento Nombre = "IC_ELIMINAR_HIJO_FN" Lenguaje="PL/SQL" Fecha="" Versi¢n"1.0.0" Dise?ador"DAVID SUTHERLAND" Programador="JAVIER LAMAS" Ambiente="BD">
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

          EXCEPTION
              WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR(-20100, 'Error en IC_PARAMETROS_MULTIPLES_D_PG ' || TO_CHAR(SQLCODE) || ': ' || SQLERRM);
  END IC_ELIMINAR_HIJO_FN;

 END IC_PARAMETROS_MULTIPLES_D_PG;
/
SHOW ERRORS
