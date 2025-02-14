CREATE OR REPLACE PROCEDURE        CE_P_GENERA_PERIODO_CONCILIA(
  stipperdia  IN VARCHAR2,
  shorario  IN VARCHAR2,
  sempresa IN VARCHAR2,
  resul IN OUT VARCHAR2,
  iparamconcil in NUMBER,
  stiparchivo in VARCHAR2,
  sPerConciliacion IN VARCHAR
  )
IS
  sFECHA		 VARCHAR2(8);
  scod_periodo   VARCHAR2(8);
  sdia           VARCHAR2(11);
  sfec_diafest   VARCHAR2(11);
  inum           number(10);
  inum1          number(10);
  marca          NUMBER(4);
  concatena		 VARCHAR(15);
/******************************************************************************
   NOMBRE:     CMD_COMVERSE
   OBJETIVO:   GENERA UN NUEVO PERIODO EN CET_PERIODOSERV
   Ver        Fecha        Autor
   ---------  ----------  ---------------
   1.0        04/12/2000  MARITZA TAPIA A.
******************************************************************************/
ERROR_PROCESO EXCEPTION;
BEGIN
resul:='OK';
marca :=1;
SELECT TO_CHAR(TO_DATE(sPerConciliacion,'YYMMDD'),'YYYYMMDD')
INTO   sFECHA
FROM   DUAL;
IF ltrim(rtrim(stipperdia)) ='D' AND ltrim(rtrim(shorario)) ='N'  THEN

   SELECT TO_CHAR(TO_DATE(sFECHA,'YYYYMMDD') + 1, 'YYYYMMDD')
   INTO scod_periodo
   FROM DUAL;

END IF;
IF stipperdia ='D' AND shorario ='F'  THEN
                   marca :=52;
                   marca :=58;
                   SELECT TO_CHAR(TO_DATE(sFECHA,'YYYYMMDD'), 'DAY')
                   INTO sdia
           FROM DUAL;
           marca :=63;
                   IF ltrim(rtrim(sdia)) = 'FRIDAY' THEN
              inum:=3;
                      LOOP
                    marca :=66;
                                SELECT decode(count(FEC_DIAFEST),0,'salir')
                                        INTO sfec_diafest
                                        FROM TA_DIASFEST
                                        WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'YYYYMMDD')+ inum;
                                        EXIT WHEN sfec_diafest = 'salir';
                                        inum := inum + 1;
                          END LOOP;
                     marca :=74;
                         SELECT TO_CHAR(TO_DATE(sFECHA, 'YYYYMMDD') + inum ,'YYYYMMDD')
                                 INTO scod_periodo
                                         FROM  DUAL;
               ELSE
                     marca :=80;
                     IF  ltrim(rtrim(sdia)) = 'MONDAY' OR ltrim(rtrim(sdia))= 'TUESDAY' OR ltrim(rtrim(sdia))='WEDNESDAY' OR ltrim(rtrim(sdia))='THURSDAY' THEN
              inum1:= 1;
                         LOOP
                    marca :=82;
                                SELECT decode(count(FEC_DIAFEST),0,'salir')
                                        INTO sfec_diafest
                                        FROM TA_DIASFEST
                                        WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'YYYYMMDD')+ inum1;
                                        EXIT WHEN sfec_diafest = 'salir';
                                        inum1:= inum1 + 1;
                     END LOOP;
                      marca :=92;
                              SELECT TO_CHAR(TO_DATE(sFECHA, 'YYYYMMDD') + inum1 ,'YYYYMMDD')
                                          INTO  scod_periodo
                                          FROM  DUAL;
           			END IF;
              END IF;
END IF;
marca :=98;
IF stipperdia ='S' AND shorario ='N'  THEN
           SELECT TO_CHAR(TO_DATE(sFECHA,'YYYYMMDD'), 'DAY')
           INTO sdia
           FROM DUAL;
        -- IF sdia = 'MONDAY' THEN
          --     marca :=105;
           -- SELECT TO_CHAR(SYSDATE,'DD/MM/YYYY')||' 00:00:00'
           -- INTO   sfec_desde
           -- FROM DUAL;
         -- END IF;
               marca :=112;
 --     SELECT TO_CHAR(SYSDATE, 'DAY')
  --        INTO sdia
   --   FROM DUAL;
          IF ltrim(rtrim(sdia))='SUNDAY' THEN
               marca :=117;
             SELECT  TO_CHAR(TO_DATE(sFECHA, 'YYYYMMDD') + 7,'YYYYMMDD')
             INTO   scod_periodo
             FROM DUAL;
          END IF;
END IF;
marca :=123;
IF stipperdia ='B' AND shorario ='F' THEN
           marca :=124;
               --    SELECT TO_CHAR(SYSDATE,'DD/MM/YYYY')||' 14:00:00'
               --INTO   sfec_desde
           --FROM DUAL;
                   marca :=130;
           SELECT TO_CHAR(TO_DATE(sFECHA,'YYYYMMDD'), 'DAY')
           INTO sdia
           FROM DUAL;
                   IF ltrim(rtrim(sdia)) = 'FRIDAY' THEN
              inum:=4;
                      LOOP
                    marca :=136;
                                SELECT decode(count(FEC_DIAFEST),0,'salir')
                                        INTO sfec_diafest
                                        FROM TA_DIASFEST
                                        WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'YYYYMMDD')+ inum;
                                        EXIT WHEN sfec_diafest = 'salir';
                                        inum := inum + 1;
                  END LOOP;
                       marca :=145;
                              SELECT TO_CHAR(TO_DATE(sFECHA ,'YYYYMMDD')+ inum, 'YYYYMMDD')
                                          INTO scod_periodo
                                          FROM  DUAL;
               ELSE
                    IF ltrim(rtrim(sdia)) = 'MONDAY' OR ltrim(rtrim(sdia))= 'TUESDAY' OR ltrim(rtrim(sdia))='WEDNESDAY' OR ltrim(rtrim(sdia))='THURSDAY' THEN
              inum1:= 2;
                         LOOP
                         marca :=153;
                                SELECT decode(count(FEC_DIAFEST),0,'salir')
                                        INTO sfec_diafest
                                        FROM TA_DIASFEST
                                        WHERE FEC_DIAFEST = TO_DATE(sFECHA ,'YYYYMMDD')+ inum1;
                                        EXIT WHEN sfec_diafest = 'salir';
                                        inum1 := inum1 + 1;
                     END LOOP;
                                      marca :=161;
                              SELECT TO_CHAR(TO_DATE(sFECHA ,'YYYYMMDD')+ inum1, 'YYYYMMDD')
                                          INTO  scod_periodo
                                          FROM  DUAL;
            END IF;
                 END IF;
END IF;
marca :=170;
IF stipperdia ='B' AND shorario ='N' THEN
       marca :=169;
       marca :=175;
           SELECT TO_CHAR(TO_DATE(sFECHA,'YYYYMMDD')+ 2, 'YYYYMMDD')
           INTO  scod_periodo
           FROM DUAL;
END IF;
IF stipperdia ='M' AND shorario ='N' THEN
       marca :=180;
           SELECT TO_CHAR(TO_DATE(sFECHA,'YYYYMMDD')+ 1, 'YYYYMMDD')
           INTO scod_periodo
           FROM DUAL;
       marca :=187;
END IF;
marca :=195;
IF stipperdia ='C' AND shorario ='N' THEN
       marca :=193;
           SELECT TO_CHAR(TO_DATE(sFECHA,'YYYYMMDD')+ 1, 'YYYYMMDD')
           INTO   scod_periodo
           FROM DUAL;
       marca :=198;

END IF;

marca :=228;

concatena := stiparchivo||sempresa||scod_periodo;
UPDATE CED_PARAMETROS SET VAL_CARACTER = concatena
WHERE COD_PARAMETRO = iparamconcil;

    marca :=250;
        EXCEPTION
        WHEN OTHERS THEN
            resul := SQLERRM ||'linea: '||marca;
                ROLLBACK;
END CE_P_GENERA_PERIODO_CONCILIA;
/
SHOW ERRORS
