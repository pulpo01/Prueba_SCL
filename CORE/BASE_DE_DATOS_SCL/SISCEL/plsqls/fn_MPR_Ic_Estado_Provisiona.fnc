CREATE OR REPLACE FUNCTION fn_MPR_Ic_Estado_Provisiona
(p_Num_Movimiento IN Icc_Comproc.Num_Movimiento%TYPE, p_modo IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
    /***************************************************************************************************
 Proposito:
 Retornar las respuestas de los comandos (icc_comproc) de un movimiento.

 Entrada:

 Numero de un movimiento de la tabla icc_movmiento
 Modo (1,2)

 Salidas:
 Modo 1 retorna icg_codrespuesta.COD_RESPUESTA
 Modo 2 retorna icg_codrespuesta.NOM_RESPUESTA

 El formato de la salida debe ser un string


   REVISIONES:
   Version      Fecha       Autor              Descripcion
   ---------  ----------  ------------------- -------------------------------------------------------
    1.0        08-07-2003  RPORTUGAL-JBUSTOS  CONSTRUCCION DE LA FUNCION DE ACUERDO A ESPECIFICACION

   ***************************************************************************************************/
   v_PLSQLBlock1  VARCHAR2(32767);
   v_PLSQLCursor2 VARCHAR2(1023);
   v_PLSQLTable1  VARCHAR2(31);
   v_PLSQLCount1  NUMBER;
   v_PLSQLCount2  NUMBER;
   v_PLSQLCount3  NUMBER;
   v_PLSQLCod_MPR NUMBER:=91;
   v_PLSQLString1 VARCHAR2(32767):= ''; --TO_CHAR(p_Num_Movimiento) || ';';
   --v_PLSQLString2 VARCHAR2(63):= 'ERROR: EL MOVIMIENTO[' ||  TO_CHAR(p_Num_Movimiento) || '] NO FUE ENCONTRADO';
   v_PLSQLString2 VARCHAR2(127):= 'ERROR: ERROR=0,DESC=OK NO FUE ENCONTRADO EN TABLA ICG_CODRESPUESTA';
   v_PLSQLString3 VARCHAR2(63) :='SIN EJECUCION DE COMANDOS';
   v_PLSQLString4 VARCHAR2(127) :='EXISTEN REGISTROS QUE NO CORRESPONDEN AL SISTEMA DE PREPAGO';
   v_PLSQLString5 VARCHAR2(127) :='ERROR: MODO NO VALIDOS, DEBEN SER [1] & [2]';
   v_PLSQLString6 VARCHAR2(63) :='ERROR=0,DESC=OK';
   v_PLSQLFlags1  BOOLEAN:=FALSE;
   v_PLSQLFlags2  BOOLEAN:=TRUE;
   v_num_intentos ICC_MOVIMIENTO.NUM_INTENTOS%TYPE;

   CURSOR c_AllComProc IS
   SELECT 'ICC_COMPROC' Table_Name FROM DUAL
   /************************************************************
   --Activar en caso que se deseee buscar tambien en historicos
   UNION
   SELECT Table_Name
   FROM All_Tables
   WHERE Table_Name LIKE 'ICC_HISTCOM%'
   AND SUBSTR(Table_Name,14,2)='20'
   --La siguiente linea fue usada solo para pruebas en tabla copiadas
   --de los historicos verdaderos y llamadas IC_HISTCOMmmyyyy_, dado que
   --para hacer las pruebas no se tenian privilegios de acceso a las
   --historicas verdaderas.
   --AND SUBSTR(Table_Name,18,1)='_'
   ************************************************************/
   ;
   PROCEDURE pDyn_interno (
      p_Cod_Comando   IN ICC_COMPROC.COD_COMANDO%TYPE,
      p_Cod_Lenguaje  IN ICC_COMPROC.COD_LENGUAJE%TYPE,
      p_Des_Respuesta IN ICC_COMPROC.DES_RESPUESTA%TYPE,
      p_Tip_Respuesta IN ICC_COMPROC.TIP_RESPUESTA%TYPE,
      p_Modo          IN NUMBER,
      p_Salida        IN OUT v_PLSQLString1%TYPE
   ) IS
      v_Pos1           INTEGER;
      v_LenPos1        INTEGER;
      v_Des_Comando    VARCHAR2(255);
      v_Des_Respuesta  VARCHAR2(255);
      v_Nom_Respuesta1 Icg_CodRespuesta.Nom_Respuesta%TYPE;
      v_Nom_Respuesta2 Icg_CodRespuesta.Nom_Respuesta%TYPE;
      v_Cod_Respuesta  Icg_CodRespuesta.Cod_Respuesta%TYPE;
      v2_Des_Respuesta VARCHAR2(255);
      v_CodsLen_Com1   VARCHAR2(255):='ICG_COMANDO.DES_COMANDO NULO PARA COMANDO ';
      v_CodsLen_Com2   VARCHAR2(255):='NO EXISTE ICG_COMANDO.DES_COMANDO PARA COMANDO ';
      v_CodsLen_Com3   VARCHAR2(255):='COMANDO SIN PROCESAR ';
      v_CodsLen_Com4   VARCHAR2(255):='NO EXISTE ICG_CODRESPUESTA.DES_COMANDO PARA NOM_RESPUESTA IN (''';
      v_String10       VARCHAR2(63) :='STATUS=NAK';
      v_String20       VARCHAR2(63) :='SUBERROR=';
      v_String31       VARCHAR2(15) :='0123456789';
      v_String32       VARCHAR2(1) :=',';
      v_String41       VARCHAR2(1) :='(';
      v_String42       VARCHAR2(1) :=')';
      v_String50       VARCHAR2(63) :='COMANDO EXITOSO[1]';
      v_String60       VARCHAR2(63) :='NO EXISTE ENTRADA EN TABLA ICG_CODRESPUESTA: [';
      v_String70       VARCHAR2(127) :='ERROR: NO VALIDO CONTENIDO DE ICC_COMPROC.DES_RESPUESTA: [';
      v_PLSQLFlags1s1  BOOLEAN:=FALSE;
   BEGIN
      IF p_Tip_Respuesta=0
      THEN
         p_Salida:= p_Salida || v_String50 || ' ';
      ELSE
         v_Des_Respuesta:=LTRIM(RTRIM(p_Des_Respuesta)) || '|';
         v_LenPos1:= LENGTH(v_Des_Respuesta);
         DBMS_OUTPUT.PUT_LINE(v_LenPos1);
         IF v_LenPos1>6 THEN
            IF SUBSTR(v_Des_Respuesta,1,6)='ERROR=' THEN
              v_Pos1:=INSTR(v_Des_Respuesta,',');
              IF v_Pos1<1 THEN
                 v_Pos1:=INSTR(v_Des_Respuesta,'|');
     END IF;
              v_Des_Respuesta:=SUBSTR(v_Des_Respuesta, 1, v_Pos1-1);
            ELSE
               v2_Des_Respuesta:=v_String70 || p_Des_Respuesta || ']';
               v_Des_Respuesta:=NULL;
               v_PLSQLFlags1s1:=TRUE;
            END IF;
         ELSE
            v2_Des_Respuesta:=v_String70 || p_Des_Respuesta || ']';
            v_Des_Respuesta:=NULL;
            v_PLSQLFlags1s1:=TRUE;
         END IF;
         DBMS_OUTPUT.PUT_LINE(v_Des_Respuesta);
         IF v_Des_Respuesta IS NOT NULL THEN
            BEGIN
                IF p_Modo=1 THEN
                    SELECT Cod_Respuesta
                    INTO v2_Des_Respuesta
                    FROM Icg_CodRespuesta
                    WHERE
                    Nom_Respuesta LIKE v_Des_Respuesta || '%'
                    AND ROWNUM=1;
                ELSIF p_Modo=2 THEN
                    SELECT Des_Respuesta
                    INTO v2_Des_Respuesta
                    FROM Icg_CodRespuesta
                    WHERE
                    Nom_Respuesta LIKE v_Des_Respuesta || '%'
                    AND ROWNUM=1;
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                   IF p_Modo=1 THEN
                      v2_Des_Respuesta:= '-1';
                   ELSE
                      v2_Des_Respuesta:= v_String60 || v_Des_Respuesta || ']';
                   END IF;
            END;
         ELSE
           IF NOT v_PLSQLFlags1s1 THEN
             v2_Des_Respuesta:= v_CodsLen_Com3;
           END IF;
         END IF;
         p_Salida:= p_Salida || v2_Des_Respuesta || '';
      END IF;

      EXCEPTION
         WHEN OTHERS THEN RAISE;
   END pDyn_interno;

BEGIN
   IF p_Modo NOT IN (1,2) THEN RETURN v_PLSQLString5; END IF;
   IF p_Num_Movimiento = '-1' THEN RETURN ''; END IF;
   FOR v_Rec IN c_AllComProc LOOP
      BEGIN
      v_PLSQLTable1:= v_Rec.table_name;
      v_PLSQLBlock1:= 'SELECT COUNT(*) ' ||
              '  FROM ' || v_PLSQLTable1 ||
              '  WHERE num_movimiento = ' || TO_CHAR(p_Num_Movimiento) ||
              '  AND ROWNUM<2';
        EXECUTE IMMEDIATE v_PLSQLBlock1
    INTO v_PLSQLCount1;
      IF v_PLSQLCount1>0 THEN
      v_PLSQLFlags1:= TRUE;
      EXIT;
       END IF;
   EXCEPTION
       WHEN OTHERS THEN NULL;
   END;
   END LOOP;

   BEGIN
      SELECT num_intentos
      INTO v_num_intentos
      FROM icc_movimiento
      WHERE num_movimiento=p_Num_Movimiento;
      --v_PLSQLString1:= v_PLSQLString1 || v_num_intentos || ';';
   EXCEPTION
      WHEN NO_DATA_FOUND THEN v_PLSQLFlags2:= FALSE;
      WHEN OTHERS THEN RETURN 'ERROR [' || SQLCODE || ']  ' || SQLERRM;
   END;

   IF NOT v_PLSQLFlags1 AND v_PLSQLFlags2 THEN
      RETURN v_PLSQLString1 || v_PLSQLString3;
   ELSIF v_PLSQLFlags1 AND NOT v_PLSQLFlags2 THEN
      NULL;
   ELSIF NOT v_PLSQLFlags1 AND NOT v_PLSQLFlags2 THEN
      BEGIN
         IF p_Modo=1 THEN
             SELECT Cod_Respuesta
             INTO v_PLSQLString1
             FROM Icg_CodRespuesta
             WHERE
             Nom_Respuesta = v_PLSQLString6
             AND ROWNUM=1;
         ELSE
             SELECT Des_Respuesta
             INTO v_PLSQLString1
             FROM Icg_CodRespuesta
             WHERE
             Nom_Respuesta = v_PLSQLString6
             AND ROWNUM=1;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
             v_PLSQLString1:= v_PLSQLString2;
       END;

      RETURN v_PLSQLString1;
   END IF;
   /********************************************************************************************************************************************************************************
   -- En caso de querer revisar tambien los archivos historicos en la busqueda del num_movimiento activar este bloque y
   -- desactivar el FOR..END LOOP de mas abajo a cambio .
   v_PLSQLCursor2:= 'SELECT Cod_Lenguaje, Cod_Comando, NVL(Des_Respuesta, '''') Des_Respuesta, Tip_Respuesta ' ||
        '  FROM ' || v_PLSQLTable1 ||
     '  WHERE num_movimiento=' || p_Num_Movimiento;

   v_PLSQLBlock1:=  'BEGIN' ||
        '  FOR v_Rec IN (' || v_PLSQLCursor2 || ') LOOP' ||
     '    pDyn_interno (v_Rec.Cod_Comando, v_Rec.Cod_Lenguaje, v_Rec.Des_Respuesta, v_Rec.Tip_respuesta, :Salida);' ||
        '  END LOOP;' ||
        'END;';
   EXECUTE IMMEDIATE v_PLSQLBlock1 USING IN OUT v_PLSQLString1;
  **********************************************************************************************************************************************************************************/

   SELECT COUNT(*) INTO v_PLSQLCount2 FROM icc_comproc WHERE num_movimiento=p_Num_Movimiento AND cod_sistema=v_PLSQLCod_MPR;
   SELECT COUNT(*) INTO v_PLSQLCount3 FROM icc_comproc WHERE num_movimiento=p_Num_Movimiento;
   IF v_PLSQLCount2=v_PLSQLCount3 THEN
      FOR v_Rec IN (SELECT Cod_Lenguaje, Cod_Comando, NVL(Des_Respuesta,'') Des_Respuesta, Tip_Respuesta FROM icc_comproc WHERE num_movimiento=p_Num_Movimiento AND ROWNUM=1 ORDER BY num_orden) LOOP
         pDyn_interno (v_Rec.Cod_Comando, v_Rec.Cod_Lenguaje, v_Rec.Des_Respuesta, v_Rec.Tip_respuesta, p_Modo, v_PLSQLString1);
      END LOOP;
   ELSE
      v_PLSQLString1:=v_PLSQLString4;
   END IF;
   /********************************************************************************************************************************************************************************
   -- En caso de querer revisar tambien los archivos historicos en la busqueda del num_movimiento activar este bloque y
   --IF v_PLSQLTable1<>'ICC_COMPROC' THEN v_PLSQLString1:= v_PLSQLTable1 || ': ' || v_PLSQLString1; END IF;
  **********************************************************************************************************************************************************************************/
   RETURN v_PLSQLString1;
   EXCEPTION
      WHEN OTHERS THEN RETURN 'ERROR [' || SQLCODE || ']  ' || SQLERRM;
END fn_MPR_Ic_Estado_Provisiona;
/
SHOW ERRORS
