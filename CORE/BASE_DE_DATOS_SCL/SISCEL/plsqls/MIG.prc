CREATE OR REPLACE PROCEDURE        MIG IS
--
-- Procedimiento de confeccion de matriculas de abonados
--
   V_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE;
   V_CLASESERVICIO GA_ABOCEL.CLASE_SERVICIO%TYPE;
   V_PERFILABONADO GA_ABOCEL.PERFIL_ABONADO%TYPE;
   V_SITUACION GA_ABOCEL.COD_SITUACION%TYPE;
   V_SERVSUPL_SER GA_SERVSUPLABO.COD_SERVSUPL%TYPE;
   V_NIVEL_SER GA_SERVSUPLABO.COD_NIVEL%TYPE;
   V_MODULO GA_SUSPREHABO.COD_MODULO%TYPE;
   V_SUSPENSION VARCHAR2(12);
   V_ROWID VARCHAR2(25);
   V_OTROS NUMBER(1) := 0;
   V_IND_CHUNGO NUMBER(1) := 0;
   V_COBROS NUMBER(1) := 0;
   V_NUMABO NUMBER(6) := 0;
   V_NUMABOOK NUMBER(6) := 0;
   V_NUMABOERR NUMBER(6) := 0;
   V_CONTABO NUMBER(5) := 0;
   V_SQLERRM VARCHAR2(50);
   CURSOR C_ABO IS
   SELECT NUM_ABONADO,COD_SITUACION,ROWID
     FROM GA_ABOCEL;
   CURSOR C_SER IS
   SELECT COD_SERVSUPL,COD_NIVEL
     FROM GA_SERVSUPLABO
    WHERE NUM_ABONADO = V_ABONADO
      AND IND_ESTADO = 2;
   CURSOR C_SUS IS
   SELECT COD_MODULO
     FROM GA_SUSPREHABO
    WHERE NUM_ABONADO = V_ABONADO
      AND TIP_REGISTRO = 2;
BEGIN
   OPEN C_ABO;
   LOOP
     BEGIN
        V_CLASESERVICIO := NULL;
        V_PERFILABONADO := NULL;
        FETCH C_ABO INTO V_ABONADO, V_SITUACION, V_ROWID;
        EXIT WHEN C_ABO%NOTFOUND;
        V_NUMABO := V_NUMABO + 1;
        V_CONTABO := V_CONTABO + 1;
        OPEN C_SER;
        LOOP
          BEGIN
             FETCH C_SER INTO V_SERVSUPL_SER, V_NIVEL_SER;
             EXIT WHEN C_SER%NOTFOUND;
             IF V_NIVEL_SER <> 0 THEN
                V_CLASESERVICIO := V_CLASESERVICIO ||
                                   LPAD(V_SERVSUPL_SER,2,0) ||
                                   LPAD(V_NIVEL_SER,4,0);
             END IF;
          EXCEPTION
             WHEN OTHERS THEN
           v_sqlerrm := substr(sqlerrm, 1, 50);
              dbms_output.put_line ('errol :'||v_sqlerrm);
                  V_IND_CHUNGO := 1;
                  EXIT;
          END;
        END LOOP;
        CLOSE C_SER;
        IF V_IND_CHUNGO = 0 THEN
           V_PERFILABONADO := V_CLASESERVICIO;
           IF V_SITUACION = 'SAA' THEN
              V_SUSPENSION := '150001160001';
              V_PERFILABONADO := V_PERFILABONADO || V_SUSPENSION;
           END IF;
           UPDATE GA_ABOCEL SET
                  CLASE_SERVICIO = V_CLASESERVICIO,
                  PERFIL_ABONADO = V_PERFILABONADO
            WHERE ROWID = V_ROWID;
            V_NUMABOOK := V_NUMABOOK + 1;
        ELSE
            dbms_output.put_line ('ab= '||v_abonado);
            exit;
            V_NUMABOERR := V_NUMABOERR +1;
            V_IND_CHUNGO := 0;
        END IF;
        IF V_CONTABO > 1000 THEN
           V_CONTABO := 0;
           COMMIT;
        END IF;
    EXCEPTION
      WHEN OTHERS THEN
           v_sqlerrm := substr(sqlerrm, 1, 50);
              dbms_output.put_line ('errol :'||v_sqlerrm);
              exit;
           V_NUMABOERR := V_NUMABOERR + 1;
    END;
   END LOOP;
   CLOSE C_ABO;
   COMMIT;
   dbms_output.put_line ('Abonados tratados : '||v_numabo);
   dbms_output.put_line ('Abonados Correctos: '||v_numabook);
   dbms_output.put_line ('Abonados Erroneos : '||v_numaboerr);
END;
/
SHOW ERRORS
