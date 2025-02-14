CREATE OR REPLACE PROCEDURE        CO_BAJAS_ABO( vp_secuencia IN VARCHAR2, vp_num_abonado IN VARCHAR2, vp_cod_accion IN VARCHAR2 ) IS
vp_retorno          NUMBER;
vp_gls_error        VARCHAR2(255);
vp_cnt_abonados     NUMBER;
vp_cnt_abonados_cf  NUMBER;
vp_cod_gestion      VARCHAR2(2);
vp_cod_cliente      NUMBER := 0;
vp_sec_moroso_orig  NUMBER;
vp_sec_moroso       NUMBER;
ERROR_PROCESO EXCEPTION;
BEGIN
   vp_retorno := 0;
   vp_gls_error := 'OK';
   SELECT  COD_CLIENTE, SEC_MOROSO /* este query solo puede dar un registro, si no hay registros retorna OK */
   INTO    vp_cod_cliente, vp_sec_moroso_orig
   FROM (  SELECT  M.COD_CLIENTE, M.SEC_MOROSO
           FROM    CO_MOROSOS M, GA_ABOCEL A
           WHERE   A.NUM_ABONADO = TO_NUMBER(vp_num_abonado)
           AND     A.COD_CLIENTE = M.COD_CLIENTE
           UNION
           SELECT  M.COD_CLIENTE, M.SEC_MOROSO
           FROM    CO_MOROSOS M, GA_ABOBEEP A
           WHERE   A.NUM_ABONADO = TO_NUMBER(vp_num_abonado)
           AND     A.COD_CLIENTE = M.COD_CLIENTE
   );
   IF vp_cod_cliente > 0 THEN /* si encontro registros */
           vp_retorno := 1;
           vp_gls_error := 'Select CNT_ABONADOS';
           SELECT  COUNT(*)
           INTO    vp_cnt_abonados
           FROM (  SELECT  NUM_ABONADO
                   FROM    GA_ABOCEL
                   WHERE   COD_CLIENTE = vp_cod_cliente
                   AND     NUM_ABONADO != TO_NUMBER(vp_num_abonado)
                   AND     COD_SITUACION != 'BAA'
                   UNION ALL
                   SELECT  NUM_ABONADO
                   FROM    GA_ABOBEEP
                   WHERE   COD_CLIENTE = vp_cod_cliente
                   AND     NUM_ABONADO != TO_NUMBER(vp_num_abonado)
                   AND     COD_SITUACION != 'BAA'
           );
           IF vp_cnt_abonados = 0 THEN /* no hay otros abonados que no estan de baja */
                   IF vp_cod_accion = 'BAJA' THEN
                           vp_retorno := 2;
                           vp_gls_error := 'Select CNT_ABONADOS_CF';
                           SELECT  COUNT(*) /* ve si hay alguno con baja por morosidad */
                           INTO    vp_cnt_abonados_cf
                           FROM (  SELECT  NUM_ABONADO
                                   FROM    GA_ABOCEL
                                   WHERE   COD_CLIENTE = vp_cod_cliente
                                   AND     NUM_ABONADO != TO_NUMBER(vp_num_abonado)
                                   AND     COD_SITUACION = 'BAA'
                                   AND     COD_CAUSABAJA IN ( '90', '76', '43' )
                                   UNION ALL
                                   SELECT  NUM_ABONADO
                                   FROM    GA_ABOBEEP
                                   WHERE   COD_CLIENTE = vp_cod_cliente
                                   AND     NUM_ABONADO != TO_NUMBER(vp_num_abonado)
                                   AND     COD_SITUACION = 'BAA'
                                   AND     COD_CAUSABAJA IN ( '90', '76', '43' )
                           );
                           IF vp_cnt_abonados_cf > 0 THEN
                                   vp_cod_gestion := 'CF';
                           ELSE
                                   vp_cod_gestion := 'BA';
                           END IF;
                           vp_sec_moroso := vp_sec_moroso_orig;
                   ELSE /* ANULACION DE BAJA */
                           vp_cod_gestion := 'MR';
                           vp_sec_moroso := 0;
                   END IF;
                   vp_retorno := 3;
                   vp_gls_error := 'UPDATE CO_MOROSOS';
                   UPDATE  CO_MOROSOS
                   SET     COD_GESTION = vp_cod_gestion,
                           SEC_MOROSO  = vp_sec_moroso
                   WHERE   COD_CLIENTE = vp_cod_cliente;
           END IF;
   END IF;
   vp_retorno := 0;
   vp_gls_error := 'OK';
   RAISE ERROR_PROCESO;
   EXCEPTION
      WHEN ERROR_PROCESO THEN
           INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia), vp_retorno, vp_gls_error);
      WHEN DUP_VAL_ON_INDEX THEN
           INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia), vp_retorno, vp_gls_error);
      WHEN NO_DATA_FOUND THEN
           INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia), vp_retorno, vp_gls_error);
      WHEN OTHERS THEN
           INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
           VALUES (TO_NUMBER(vp_secuencia), vp_retorno, vp_gls_error);
END CO_BAJAS_ABO;
/
SHOW ERRORS
