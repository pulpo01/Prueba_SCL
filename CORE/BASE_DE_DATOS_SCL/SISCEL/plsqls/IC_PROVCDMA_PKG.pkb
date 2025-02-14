CREATE OR REPLACE PACKAGE BODY IC_PROVCDMA_PKG AS


FUNCTION IC_TIPOABONADO_FN(V_NUM_MOV IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS

/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_TIPOABONADO_FN" Lenguaje="PL/SQL" Fecha="15-05-2006" Versión="1.0.0" Diseñador="TM-mAs" Programador="TM-mAs" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Retorna el tipo de abonado: 'PREPAGO' - 'POSPAGO' - 'HIBRIDO'</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="VARCHAR2">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_Abonado        ICC_MOVIMIENTO.NUM_ABONADO%TYPE;
LN_Uso            GA_ABOCEL.COD_USO%TYPE;
LN_Existe     NUMBER;
LV_Tipo       VARCHAR2(10) := '0';

CV_Tipo_Pre   CONSTANT    VARCHAR2(10) := 'PREPAGO';
CV_Tipo_Pos   CONSTANT    VARCHAR2(10) := 'POSPAGO';
CV_Tipo_Hib   CONSTANT    VARCHAR2(10) := 'HIBRIDO';
CN_Uso_Hib        CONSTANT        NUMBER          := 10;

error_proceso EXCEPTION;

  BEGIN

        -- obtiene abonado
        SELECT NVL(NUM_ABONADO, 0)
          INTO LN_Abonado
          FROM ICC_MOVIMIENTO
         WHERE NUM_MOVIMIENTO = V_NUM_MOV;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        -- busca diferenciar entre prepago y pospago
    SELECT COUNT(1)
          INTO LN_Existe
          FROM GA_ABOCEL
     WHERE NUM_ABONADO = LN_Abonado;

        IF SQLCODE <> 0 THEN
          RAISE error_proceso;
        END IF;

        IF LN_Existe > 0 THEN
           -- pospago o hibrido
           SELECT NVL(COD_USO,0)
             INTO LN_Uso
             FROM GA_ABOCEL
                WHERE NUM_ABONADO = LN_Abonado;

           IF LN_Uso = CN_Uso_Hib THEN
                  -- hibrido
                  LV_Tipo := CV_Tipo_Hib;
           ELSE
                  -- pospago
                  LV_Tipo := CV_Tipo_Pos;
           END IF;
        ELSE
                -- prepago
                LV_Tipo := CV_Tipo_Pre;
        END IF;

        RETURN LV_Tipo;

        EXCEPTION
           WHEN error_proceso THEN
              RETURN '0';
       WHEN NO_DATA_FOUND THEN
          RETURN '0';
       WHEN OTHERS THEN
          RETURN '0';
END IC_TIPOABONADO_FN;




FUNCTION IC_TT_FN (EV_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_TT_FN" Lenguaje="PL/SQL" Fecha="30-05-2006" Versión="1.0.0" Diseñador="TM-mAs" Programador="TM-mAs" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Retorna el Tipo de Tecnologia correspondiente al movimiento del abonado</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="VARCHAR2">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_TipTec       ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE;
error_proceso   EXCEPTION;

BEGIN

    SELECT NVL(TIP_TECNOLOGIA, CHR(0))
        INTO   LV_TipTec
        FROM   ICC_MOVIMIENTO
        WHERE  NUM_MOVIMIENTO=EV_num_mov;

    IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;

    RETURN LV_TipTec;

EXCEPTION
     WHEN error_proceso THEN
          RETURN '0';
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
                  RETURN '0';
END IC_TT_FN;

FUNCTION IC_STATIONID_FN (EV_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_STATIONID_FN" Lenguaje="PL/SQL" Fecha="30-05-2006" Versión="1.0.0" Diseñador="TM-mAs" Programador="TM-mAs" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Retorna el Station ID correspondiente al numero de celular</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="VARCHAR2">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_NumCelular           ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
LN_NumCelularNue        ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
LV_StationID            VARCHAR2(4) := '0';
CN_pos                          CONSTANT NUMBER := 3;
error_proceso           EXCEPTION;

BEGIN

    SELECT NVL(NUM_CELULAR, 0), NVL(NUM_CELULAR_NUE, 0)
        INTO   LN_NumCelular, LN_NumCelularNue
        FROM   ICC_MOVIMIENTO
        WHERE  NUM_MOVIMIENTO = EV_num_mov;

    IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;

        IF LN_NumCelularNue <> 0 THEN
           LV_StationID := SUBSTR(LN_NumCelularNue, length(LN_NumCelularNue) - CN_pos);
        ELSE
           LV_StationID := SUBSTR(LN_NumCelular, length(LN_NumCelular) - CN_pos);
        END IF;

    RETURN LV_StationID;

EXCEPTION
     WHEN error_proceso THEN
          RETURN '0';
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
                  RETURN '0';
END IC_STATIONID_FN;

FUNCTION IC_LINCDMA_FN (EV_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_LINCDMA_FN" Lenguaje="PL/SQL" Fecha="30-05-2006" Versión="1.0.0" Diseñador="TM-mAs" Programador="TM-mAs" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Retorna la linea CDMA asociada al numero de celular</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="VARCHAR2">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_NumCelular           ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
LN_NumCelularNue        ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
LV_NPA                          AL_CODIGO_EXTERNO.CODIGO_EXTERNO%TYPE;
LV_LinCdma                      VARCHAR2(30) := '0';
LV_inicel                       VARCHAR2(10) := '0';
LV_fincel                       VARCHAR2(10) := '0';

CN_larpos                       CONSTANT NUMBER := 4;
CN_inipos                       CONSTANT NUMBER := 1;
CN_pos                          CONSTANT NUMBER := 5;
CV_Plataforma           CONSTANT AL_CODIGO_EXTERNO.COD_PLATAFORMA%TYPE := 'HLRQ';
CV_Codigo                       CONSTANT AL_CODIGO_EXTERNO.TIP_CODIGO%TYPE := '10009';

error_proceso           EXCEPTION;

BEGIN

        -- obtiene numero de celular o numero de celular nuevo
    SELECT NVL(NUM_CELULAR, 0)
        INTO   LN_NumCelular
        FROM   ICC_MOVIMIENTO
        WHERE  NUM_MOVIMIENTO = EV_num_mov;

    IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;

        -- obtiene 7 ultimos digitos del numero de celular (LV_fincel)
        -- obtiene 4 primeros digitos del numero de celular - NDC* (LV_inicel)
        IF LN_NumCelular <> 0 THEN
           LV_inicel := SUBSTR(LN_NumCelular, CN_inipos, CN_larpos);
           LV_fincel := SUBSTR(LN_NumCelular, length(LN_NumCelular) - CN_pos);
        ELSE
           RAISE error_proceso;
        END IF;

        -- busca el codigo de NPA asociado al valor de NDC*
        SELECT NVL(CODIGO_EXTERNO,'0')
          INTO LV_NPA
          FROM AL_CODIGO_EXTERNO
         WHERE COD_PLATAFORMA = CV_Plataforma
           AND TIP_CODIGO = CV_Codigo
           AND CODIGO_INTERNO = LV_inicel;

        IF LV_NPA <> '0' THEN
           LV_LinCdma := LV_NPA || LV_fincel;
        END IF;

    RETURN LV_LinCdma;

EXCEPTION
     WHEN error_proceso THEN
          RETURN '0';
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
                  RETURN '0';
END IC_LINCDMA_FN;

FUNCTION IC_LINCDMA_NEW_FN (EV_num_mov IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2
IS
/*
<Documentación TipoDoc = "Función">
<Elemento Nombre = "IC_LINCDMA_FN" Lenguaje="PL/SQL" Fecha="30-05-2006" Versión="1.0.0" Diseñador="TM-mAs" Programador="TM-mAs" Ambiente="DEIMOS_COL">
<Retorno>VARCHAR2</Retorno>
<Descripción>Retorna la linea CDMA asociada al numero de celular</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_num_mov" Tipo="VARCHAR2">Número de movimiento</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_NumCelular           ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
LN_NumCelularNue        ICC_MOVIMIENTO.NUM_CELULAR%TYPE;
LV_NPA                  AL_CODIGO_EXTERNO.CODIGO_EXTERNO%TYPE;
LV_LinCdmaNew           VARCHAR2(30) := '0';
LV_inicel                       VARCHAR2(10) := '0';
LV_fincel                       VARCHAR2(10) := '0';

CN_larpos                       CONSTANT NUMBER := 4;
CN_inipos                       CONSTANT NUMBER := 1;
CN_pos                          CONSTANT NUMBER := 5;
CV_Plataforma           CONSTANT AL_CODIGO_EXTERNO.COD_PLATAFORMA%TYPE := 'HLRQ';
CV_Codigo                       CONSTANT AL_CODIGO_EXTERNO.TIP_CODIGO%TYPE := '10009';

error_proceso           EXCEPTION;

BEGIN

        -- obtiene numero de celular o numero de celular nuevo
    SELECT NVL(NUM_CELULAR_NUE, 0)
        INTO   LN_NumCelularNue
        FROM   ICC_MOVIMIENTO
        WHERE  NUM_MOVIMIENTO = EV_num_mov;

    IF SQLCODE <> 0 THEN
      RAISE error_proceso;
    END IF;

        -- obtiene 7 ultimos digitos del numero de celular (LV_fincel)
        -- obtiene 4 primeros digitos del numero de celular - NDC* (LV_inicel)
        IF LN_NumCelularNue <> 0 THEN
           LV_inicel := SUBSTR(LN_NumCelularNue, CN_inipos, CN_larpos);
           LV_fincel := SUBSTR(LN_NumCelularNue, length(LN_NumCelularNue) - CN_pos);
        ELSE
                RAISE error_proceso;
        END IF;

        -- busca el codigo de NPA asociado al valor de NDC*
        SELECT NVL(CODIGO_EXTERNO,'0')
          INTO LV_NPA
          FROM AL_CODIGO_EXTERNO
         WHERE COD_PLATAFORMA = CV_Plataforma
           AND TIP_CODIGO = CV_Codigo
           AND CODIGO_INTERNO = LV_inicel;

        IF LV_NPA <> '0' THEN
           LV_LinCdmaNew := LV_NPA || LV_fincel;
        END IF;

    RETURN LV_LinCdmaNew;

EXCEPTION
     WHEN error_proceso THEN
          RETURN '0';
     WHEN NO_DATA_FOUND   THEN
          RETURN '0';
     WHEN OTHERS THEN
                  RETURN '0';
END IC_LINCDMA_NEW_FN;

END  IC_PROVCDMA_PKG;
/
SHOW ERRORS
