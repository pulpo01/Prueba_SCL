CREATE OR REPLACE PACKAGE BODY FA_UTILFAC_PG is
FUNCTION FA_BUSCA_INDICES_FN
        ( p_vSQL IN VARCHAR2 ) RETURN VARCHAR2 IS
--
  CURSOR c_buscador(p_tabla VARCHAR2) IS
         SELECT INDEX_NAME
           FROM ALL_INDEXES
         WHERE TABLE_NAME = p_tabla
           AND OWNER = 'SISCEL';

  v_vSalida VARCHAR2(4000);
  v_vTabla VARCHAR2(50);
  BEGIN
    v_vTabla := p_vSQL;
    --
    v_vSalida := '';
  --
    FOR CC in c_buscador(v_vTabla) LOOP
      v_vSalida := v_vSalida || cc.INDEX_NAME || ':';
    END LOOP;
  --
    RETURN (v_vSalida);
  END FA_BUSCA_INDICES_FN;
----------------------------------------------------------------------
FUNCTION FA_BUSCA_PERMISOS_FN
        ( p_vSQL IN VARCHAR2 ) RETURN VARCHAR2 IS
--
  CURSOR c_buscador_priv(p_tabla VARCHAR2) IS
         SELECT 'GRANT '   ||
                PRIVILEGE  ||
                ' ON '     ||
                TABLE_NAME ||
                ' TO '     ||
                GRANTEE COMANDO
           FROM ALL_TAB_PRIVS
         WHERE TABLE_NAME = p_tabla
           AND GRANTOR = 'SISCEL';

  v_vSalida VARCHAR2(4000);
  v_vTabla VARCHAR2(50);
  BEGIN
    v_vTabla := p_vSQL;
    --
    v_vSalida := '';
  --
    FOR CC in c_buscador_priv(v_vTabla) LOOP
      v_vSalida := v_vSalida || cc.COMANDO || ':';
    END LOOP;
  --
    RETURN (v_vSalida);
  END FA_BUSCA_PERMISOS_FN;
----------------------------------------------------------------------
FUNCTION FA_OBTIENE_DESC_INDICES_FN
        ( p_vSQL IN VARCHAR2 ) RETURN VARCHAR2 IS
--
  CURSOR c_creador(p_indice VARCHAR2) IS
         SELECT IX.INDEX_NAME AS NOMBRE , 0 AS POSICION ,
                'CREATE ' || DECODE( UNIQUENESS , 'NONUNIQUE' , '' , UNIQUENESS ) || ' INDEX ' || INDEX_NAME ||
                ' ON ' || TABLE_NAME || ' (' AS COMANDO
           FROM ALL_INDEXES IX
          WHERE IX.INDEX_NAME  = p_indice
            AND  NOT EXISTS( SELECT 1
                               FROM   ALL_CONSTRAINTS CO
                              WHERE  CO.CONSTRAINT_NAME  = IX.INDEX_NAME
                                AND  CO.CONSTRAINT_TYPE IN ( 'P' , 'U' ) )
            AND    IX.OWNER = 'SISCEL'
         UNION  ALL
         SELECT IX.INDEX_NAME AS NOMBRE , 1 + CO.COLUMN_POSITION / 1000 POSICION ,
                DECODE( CO.COLUMN_POSITION , 1 , '   ' , ' , ' ) ||  CO.COLUMN_NAME  AS COMANDO
           FROM ALL_IND_COLUMNS CO , ALL_INDEXES  IX
          WHERE  IX.INDEX_NAME = p_indice
            AND  IX.INDEX_NAME = CO.INDEX_NAME
            AND  NOT EXISTS( SELECT 1
                               FROM ALL_CONSTRAINTS CO
                              WHERE CO.CONSTRAINT_NAME = IX.INDEX_NAME
                                AND CO.CONSTRAINT_TYPE IN ( 'P' , 'U' )
                                AND CO.OWNER = 'SISCEL')
            AND CO.TABLE_OWNER = IX.OWNER
            AND IX.OWNER      = 'SISCEL'
         UNION  ALL
         SELECT IX.INDEX_NAME AS NOMBRE , 2 AS POSICION ,
                ' ) TABLESPACE ' || TABLESPACE_NAME ||
                ' PCTFREE ' || PCT_FREE ||
                ' INITRANS ' || INI_TRANS || ' MAXTRANS ' || MAX_TRANS
           FROM ALL_INDEXES IX
          WHERE IX.INDEX_NAME  = p_indice
            AND NOT EXISTS( SELECT 1
                              FROM ALL_CONSTRAINTS CO
                             WHERE CO.CONSTRAINT_NAME = IX.INDEX_NAME
                               AND CO.CONSTRAINT_TYPE IN ( 'P' , 'U' )
                               AND CO.OWNER = 'SISCEL')
            AND IX.OWNER = 'SISCEL'
         UNION  ALL
         -- CO-0085 02/05/2006
		SELECT IX.INDEX_NAME AS NOMBRE , 3 AS POSICION ,
		--                ' STORAGE ( INITIAL ' || INITIAL_EXTENT || ' NEXT ' || NEXT_EXTENT || ' PCTINCREASE ' || PCT_INCREASE ||
		                ' STORAGE ( INITIAL ' || INITIAL_EXTENT || ' PCTINCREASE ' || PCT_INCREASE ||
		                ' MINEXTENTS ' || MIN_EXTENTS || ' MAXEXTENTS ' || MAX_EXTENTS || ')'
		                --' FREELISTS ' || FREELISTS || ' FREELIST GROUPS '|| FREELIST_GROUPS ||' )'
		FROM ALL_INDEXES IX
          WHERE IX.INDEX_NAME  = p_indice
            AND NOT EXISTS( SELECT 1
                              FROM ALL_CONSTRAINTS CO
                             WHERE CO.CONSTRAINT_NAME  = IX.INDEX_NAME
                               AND CO.CONSTRAINT_TYPE IN ( 'P' , 'U' )
                               AND CO.OWNER = 'SISCEL')
           AND    IX.OWNER = 'SISCEL'
         ORDER  BY 1 , 2;
  --
  v_vSalida VARCHAR2(4000);
  v_vIndice VARCHAR2(50);
  --
  BEGIN

    v_vIndice := p_vSQL;
        --
    v_vSalida := '';
  --
    FOR CC in c_creador(v_vIndice) LOOP
      v_vSalida := v_vSalida || cc.COMANDO;
    END LOOP;
  --
    RETURN (v_vSalida);
  END FA_OBTIENE_DESC_INDICES_FN;
----------------------------------------------------------------------
  PROCEDURE FA_DESECHA_INDICES_PR
        ( p_ind_tasador IN FA_CICLFACT.IND_TASADOR%type ) IS
  v_vTabla  VARCHAR2(50);
  v_vIndice  VARCHAR2(50);
  v_vSQL    VARCHAR2(400);
  v_vCadena VARCHAR2(500);
  v_vCadAux VARCHAR2(400);

  BEGIN
    IF p_ind_tasador = 1 THEN
      v_vTabla := 'PF_TOLTARIFICA';
    ELSE
      v_vTabla := 'PF_TARIFICADAS';
    END IF;

    v_vCadena := FA_BUSCA_INDICES_FN(v_vTabla);

    WHILE length(v_vCadena) > 0 LOOP
        v_vIndice :=  SUBSTR(v_vCadena,1,INSTR(v_vCadena,':')-1);
        v_vSQL := 'DROP INDEX ' || v_vIndice;
        EXECUTE IMMEDIATE v_vSQL ;
        v_vCadAux := SUBSTR(v_vCadena,INSTR(v_vCadena,':')+1,LENGTH(v_vCadena));
        v_vCadena := v_vCadAux;
    END LOOP;

  END FA_DESECHA_INDICES_PR;
----------------------------------------------------------------------
  PROCEDURE FA_EJECUTA_DML_PR
           (p_vSQL IN VARCHAR2) IS
    v_vSQL    VARCHAR2(4000);
  BEGIN
     v_vSQL := p_vSQL;
     EXECUTE IMMEDIATE v_vSQL ;
  END FA_EJECUTA_DML_PR;
----------------------------------------------------------------------
  PROCEDURE FA_HISTORICO_DE_LLAMADAS_PR(v_ciclofact IN FA_CICLFACT.COD_CICLFACT%type) is
      v_vSQLRenombraTabla   VARCHAR2(5000);
      v_vSQLCreaTablaPF     VARCHAR2(500);
      v_vSQLBorraIndicePF   VARCHAR2(500);
      v_vSQLCreaIndicePF    VARCHAR2(500);
      v_vSQLCreaPermisosPF  VARCHAR2(500);
      v_vSQLCreaPermisosDet VARCHAR2(500);
      v_vSQLCreaIndiceDet   VARCHAR2(500);
      v_vSQLDesechaTabla    VARCHAR2(500);
      v_vOper               VARCHAR2(10);
      v_vTablaDET           VARCHAR2(300);
      v_vTablaPF            VARCHAR2(300);
      v_ind_tasador         NUMBER(2);
      v_vDatoIndice         VARCHAR2(500);
      v_iExisteVal          NUMBER(2);
      vDescError            VARCHAR2(1000);
      v_Flag                NUMBER(6);
      v_vCadenaIndice      VARCHAR2(5000);
      v_vCadenaPermisos    VARCHAR2(1000);
      v_vCadenaSinomino    VARCHAR2(1000);
      v_vIndicePF          VARCHAR2(1000);
      v_vCadenaCreacionPF  VARCHAR2(5000);
      v_vAuxiliar3         VARCHAR2(5000);
      v_vCadenaCreacionDET VARCHAR2(5000);
      v_vAuxiliar1         VARCHAR2(5000);
      v_vAuxiliar2         VARCHAR2(5000);
      szhPathDir           FAD_PARAMETROS.VAL_CARACTER%TYPE;
      sControlPath         VARCHAR2(1);
      szhNombArchLog       VARCHAR2 (128);
      szhModoOpen          VARCHAR2 (1);
      fh                   utl_file.FILE_TYPE ;
      DATO_INDICE_NOEXISTE EXCEPTION;
      DATO_INDICE_SINVALOR EXCEPTION;
      DATO_INDICE_SINCREAR EXCEPTION;
  BEGIN
     szhPathDir:=' ';
     SELECT  VAL_CARACTER
     INTO    szhPathDir
     FROM    FAD_PARAMETROS
     WHERE   COD_MODULO = 'FA'
     AND     COD_PARAMETRO = 3;

     szhNombArchLog := 'HISTORICO_DE_LLAMADAS_' || v_ciclofact || '.log' ;
     szhModoOpen := 'w';
     fh := utl_file.fopen(szhPathDir,szhNombArchLog,szhModoOpen);

     utl_file.Put_Line(fh,'------------------------------------------------------');
     SELECT IND_TASADOR
     INTO v_ind_tasador
     FROM FA_CICLFACT
     WHERE COD_CICLFACT = ltrim(rtrim(v_ciclofact));

     v_vTablaDET := 'FA_DETCELULAR_' || ltrim(rtrim(v_ciclofact));

     IF v_ind_tasador = 1 THEN
        v_vTablaPF := 'PF_TOLTARIFICA';
     ELSE
        v_vTablaPF := 'PF_TARIFICADAS';
     END IF;

     v_vSQLRenombraTabla := 'RENAME ' || v_vTablaPF || ' TO ' || v_vTablaDET;
     v_vSQLCreaTablaPF   := 'CREATE TABLE ' || v_vTablaPF || ' AS SELECT * FROM ' || v_vTablaDET || ' WHERE ROWNUM < 1';

     SELECT count(1)
     INTO v_iExisteVal
     FROM FAD_PARAMETROS
     WHERE DES_PARAMETRO = 'IMP_DATOS_INDEX_FA_DETCELULAR'
       AND COD_MODULO = 'FA';

     IF v_iExisteVal != 1 THEN
        RAISE DATO_INDICE_NOEXISTE;
     ELSE
        v_vDatoIndice := '';

        SELECT NVL(UPPER(VAL_CARACTER),'NO_EXISTE')
        INTO v_vDatoIndice
        FROM FAD_PARAMETROS
        WHERE DES_PARAMETRO = 'IMP_DATOS_INDEX_FA_DETCELULAR'
          AND COD_MODULO = 'FA';

        IF v_vDatoIndice = 'NO_EXISTE' THEN
           RAISE DATO_INDICE_SINVALOR;
        ELSE
           v_vSQLCreaIndiceDet := '';
           v_vSQLCreaIndiceDet := v_vSQLCreaIndiceDet || 'CREATE INDEX AK_FA_DETCELULAR_' || ltrim(rtrim(v_ciclofact));
           v_vSQLCreaIndiceDet := v_vSQLCreaIndiceDet || ' ON FA_DETCELULAR_'  || ltrim(rtrim(v_ciclofact));
           v_vSQLCreaIndiceDet := v_vSQLCreaIndiceDet || ' ' || ltrim(rtrim(v_vDatoIndice));
        END IF;
     END IF;


    v_vCadenaIndice := FA_BUSCA_INDICES_FN(v_vTablaPF);
    v_vCadenaPermisos := FA_BUSCA_PERMISOS_FN(v_vTablaPF);

    v_vAuxiliar1 := '';
    v_vAuxiliar1 := v_vCadenaIndice;
    v_vCadenaCreacionPF := '';
    v_Flag := 0;

    WHILE length(v_vAuxiliar1) > 0 LOOP
        v_vIndicePF :=  SUBSTR(v_vAuxiliar1,1,INSTR(v_vAuxiliar1,':')-1);
        v_vAuxiliar3 := FA_OBTIENE_DESC_INDICES_FN(v_vIndicePF);
        IF length(ltrim(rtrim(v_vAuxiliar3))) = 0 THEN
            RAISE DATO_INDICE_SINCREAR;
        END IF;
        v_vSQLBorraIndicePF := 'DROP INDEX ' || v_vIndicePF;
        utl_file.Put_Line(fh,'00000:' || v_vSQLBorraIndicePF);
        EXECUTE IMMEDIATE v_vSQLBorraIndicePF;
        v_vCadenaCreacionPF := v_vCadenaCreacionPF || v_vAuxiliar3  || ':';
        v_vAuxiliar2 := SUBSTR(v_vAuxiliar1,INSTR(v_vAuxiliar1,':')+1,LENGTH(v_vAuxiliar1));
        v_vAuxiliar1 := v_vAuxiliar2;
    END LOOP;

    v_Flag := 20003;

    utl_file.Put_Line(fh,'20003:' || v_vSQLRenombraTabla);
    EXECUTE IMMEDIATE v_vSQLRenombraTabla;
    v_Flag := 20004;

    utl_file.Put_Line(fh,'20004:' || v_vSQLCreaTablaPF);
    EXECUTE IMMEDIATE v_vSQLCreaTablaPF;
    v_Flag := 20005;

    v_vAuxiliar1 := '';
    v_vAuxiliar1 := v_vCadenaCreacionPF;
    WHILE length(v_vAuxiliar1) > 0 LOOP
        v_vSQLCreaIndicePF :=  SUBSTR(v_vAuxiliar1,1,INSTR(v_vAuxiliar1,':')-1);
        utl_file.Put_Line(fh,'20005:' || v_vSQLCreaIndicePF);
        EXECUTE IMMEDIATE v_vSQLCreaIndicePF ;
        v_vAuxiliar2 := SUBSTR(v_vAuxiliar1,INSTR(v_vAuxiliar1,':')+1,LENGTH(v_vAuxiliar1));
        v_vAuxiliar1 := v_vAuxiliar2;
    END LOOP;
    v_Flag := 20006;

    v_vAuxiliar1 := '';
    v_vAuxiliar1 := v_vCadenaPermisos;
    WHILE length(v_vAuxiliar1) > 0 LOOP
        v_vSQLCreaPermisosPF :=  SUBSTR(v_vAuxiliar1,1,INSTR(v_vAuxiliar1,':')-1);
        utl_file.Put_Line(fh,'20006:' || v_vSQLCreaPermisosPF);
        EXECUTE IMMEDIATE v_vSQLCreaPermisosPF ;
        v_vAuxiliar2 := SUBSTR(v_vAuxiliar1,INSTR(v_vAuxiliar1,':')+1,LENGTH(v_vAuxiliar1));
        v_vAuxiliar1 := v_vAuxiliar2;
    END LOOP;
    v_Flag := 20008;

--  v_vCadenaSinomino := 'CREATE PUBLIC SYNONYM ' || v_vTablaPF || ' FOR SISCEL.' || v_vTablaPF;
--  utl_file.Put_Line(fh,'20007:' || v_vCadenaSinomino);
--  EXECUTE IMMEDIATE v_vCadenaSinomino;
--  v_Flag := 20008;


     SELECT count(1)
     INTO v_iExisteVal
     FROM   ALL_SYNONYMS
     WHERE  OWNER        = 'PUBLIC'
       AND  SYNONYM_NAME = v_vTablaDET ;

    IF v_iExisteVal = 0 THEN
        v_vCadenaSinomino := 'CREATE PUBLIC SYNONYM ' || v_vTablaDET || ' FOR SISCEL.' || v_vTablaDET;
        utl_file.Put_Line(fh,'20008:' || v_vCadenaSinomino);
        EXECUTE IMMEDIATE v_vCadenaSinomino;
        v_Flag := 20009;
    END IF;

    v_vSQLCreaPermisosDet := 'GRANT SELECT ON ' || v_vTablaDET || ' TO SISCEL_SELECT';
    utl_file.Put_Line(fh,'20009:' || v_vSQLCreaPermisosDet);
    EXECUTE IMMEDIATE v_vSQLCreaPermisosDet;
    v_Flag := 20010;

    v_vSQLCreaPermisosDet := 'GRANT SELECT ON ' || v_vTablaDET || ' TO INTERNET_SELECT';
    utl_file.Put_Line(fh,'20010:' || v_vSQLCreaPermisosDet);
    EXECUTE IMMEDIATE v_vSQLCreaPermisosDet;
    v_Flag := 20011;

    utl_file.Put_Line(fh,'20011:' || v_vSQLCreaIndiceDet);
    EXECUTE IMMEDIATE v_vSQLCreaIndiceDet;
    utl_file.fclose(fh);


  EXCEPTION
    WHEN DATO_INDICE_NOEXISTE THEN
        vDescError := 'No existe Parámetro IMP_DATOS_INDEX_FA_DETCELULAR';
        RAISE_APPLICATION_ERROR(-20001, vDescError);
    WHEN DATO_INDICE_SINVALOR THEN
        vDescError := 'No existe VAL_CARATER para IMP_DATOS_INDEX_FA_DETCELULAR';
        RAISE_APPLICATION_ERROR(-20002, vDescError);
    WHEN DATO_INDICE_SINCREAR THEN
        vDescError := 'No se podrá recrear ' || v_vIndicePF;
        RAISE_APPLICATION_ERROR(-20007, vDescError);
    WHEN OTHERS THEN
        vDescError := 'Error inesperado, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM;
        IF v_Flag = 0 OR v_Flag = 20003 THEN
            WHILE length(v_vCadenaCreacionPF) > 0  LOOP
                v_vSQLCreaIndicePF :=  SUBSTR(v_vCadenaCreacionPF,1,INSTR(v_vCadenaCreacionPF,':')-1);
                utl_file.Put_Line(fh,'EXCEPTION 20003:' || v_vSQLCreaIndicePF);
                EXECUTE IMMEDIATE v_vSQLCreaIndicePF ;
                v_vAuxiliar2 := SUBSTR(v_vCadenaCreacionPF,INSTR(v_vCadenaCreacionPF,':')+1,LENGTH(v_vCadenaCreacionPF));
                v_vCadenaCreacionPF := v_vAuxiliar2;
            END LOOP;
            RAISE_APPLICATION_ERROR(-20003, vDescError);
        END IF;
        IF v_Flag = 20004 THEN
            v_vSQLRenombraTabla := 'RENAME ' || v_vTablaDET || 'TO ' || v_vTablaPF;
            EXECUTE IMMEDIATE v_vSQLRenombraTabla;
            WHILE length(v_vCadenaCreacionPF) > 0 LOOP
                v_vSQLCreaIndicePF :=  SUBSTR(v_vCadenaCreacionPF,1,INSTR(v_vCadenaCreacionPF,':')-1);
                utl_file.Put_Line(fh,'EXCEPTION 20004:' || v_vSQLCreaIndicePF);
                EXECUTE IMMEDIATE v_vSQLCreaIndicePF ;
                v_vAuxiliar2 := SUBSTR(v_vCadenaCreacionPF,INSTR(v_vCadenaCreacionPF,':')+1,LENGTH(v_vCadenaCreacionPF));
                v_vCadenaCreacionPF := v_vAuxiliar2;
            END LOOP;
            RAISE_APPLICATION_ERROR(-20004, vDescError);
        END IF;
        IF v_Flag = 20005 THEN
            v_vSQLDesechaTabla := 'DROP TABLE ' || v_vTablaPF;
            utl_file.Put_Line(fh,'EXCEPTION 20005:' || v_vSQLDesechaTabla);
            EXECUTE IMMEDIATE v_vSQLDesechaTabla;
            v_vSQLRenombraTabla := 'RENAME ' || v_vTablaDET || ' TO ' || v_vTablaPF;
            utl_file.Put_Line(fh,'EXCEPTION 20005:' || v_vSQLRenombraTabla);
            EXECUTE IMMEDIATE v_vSQLRenombraTabla;
            WHILE length(v_vCadenaCreacionPF) > 0 LOOP
                v_vSQLCreaIndicePF :=  SUBSTR(v_vCadenaCreacionPF,1,INSTR(v_vCadenaCreacionPF,':')-1);
                utl_file.Put_Line(fh,'EXCEPTION 20005:' || v_vSQLCreaIndicePF);
                EXECUTE IMMEDIATE v_vSQLCreaIndicePF ;
                v_vAuxiliar2 := SUBSTR(v_vCadenaCreacionPF,INSTR(v_vCadenaCreacionPF,':')+1,LENGTH(v_vCadenaCreacionPF));
                v_vCadenaCreacionPF := v_vAuxiliar2;
            END LOOP;
            RAISE_APPLICATION_ERROR(-20005, vDescError);
        END IF;
        IF v_Flag = 20006 THEN
            utl_file.Put_Line(fh,'EXCEPTION 20006: FALLO ' || v_vSQLCreaPermisosPF);
            vDescError := vDescError || ' (No puede crear Permisos:' || v_vTablaPF || ' ) ';
            RAISE_APPLICATION_ERROR(-20006, vDescError);
        END IF;
--      IF v_Flag = 20007 THEN
--          vDescError := vDescError || ' (No puede crear Sinomino:' || v_vTablaPF || ' ) ';
--          RAISE_APPLICATION_ERROR(-20007, vDescError);
--      END IF;
        IF v_Flag = 20008 THEN
            utl_file.Put_Line(fh,'EXCEPTION 20008: FALLO ' || v_vCadenaSinomino);
            vDescError := vDescError || ' (No puede crear Sinomino:' || v_vTablaDET || ' ) ';
            RAISE_APPLICATION_ERROR(-20008, vDescError);
        END IF;
        IF v_Flag = 20009 THEN
            utl_file.Put_Line(fh,'EXCEPTION 20009: FALLO ' || v_vSQLCreaPermisosDet);
            RAISE_APPLICATION_ERROR(-20009, vDescError);
        END IF;
        IF v_Flag = 20010 THEN
            utl_file.Put_Line(fh,'EXCEPTION 20010: FALLO ' || v_vSQLCreaPermisosDet);
            RAISE_APPLICATION_ERROR(-20010, vDescError);
        END IF;
        IF v_Flag = 20011 THEN
            utl_file.Put_Line(fh,'EXCEPTION 20011: FALLO ' || v_vSQLCreaIndiceDet);
            vDescError := vDescError || '(FAD_PARAMETROS.DES_PARAMETRO = IMP_DATOS_INDEX_FA_DETCELULAR)';
            RAISE_APPLICATION_ERROR(-20011, vDescError);
        END IF;

        utl_file.fclose(fh);
  END FA_HISTORICO_DE_LLAMADAS_PR;
END FA_UTILFAC_PG;
/
SHOW ERRORS
