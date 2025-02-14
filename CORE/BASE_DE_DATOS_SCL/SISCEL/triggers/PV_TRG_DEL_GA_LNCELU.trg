CREATE OR REPLACE TRIGGER PV_TRG_DEL_GA_LNCELU
 BEFORE 
 DELETE
 ON GA_LNCELU
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW 
DECLARE

  nAbonado           ga_abocel.num_abonado%type;
  sCodTecnologia   ga_abocel.cod_tecnologia%type;
  sCodOperadora       PV_SERIELN_INT_TO.COD_OPERADORA%type;


  sCodModelo     al_articulos.cod_modelo%TYPE;
  sDesFabricante al_fabricantes.des_fabricante%TYPE;

  v_proceso        VARCHAR2(25);
  s_tabla           VARCHAR2(15);

  nCant               NUMBER(2);
  nError           NUMBER(2);
  nTraza           NUMBER(2);
  nSecuencia       NUMBER(9);
  sMsgTraza           VARCHAR2(100);
  sDiasForma       VARCHAR2(20);
  dFecSiniestro       GA_SINIESTROS.FEC_SINIESTRO%TYPE;
  sCodEstado       GA_SINIESTROS.COD_ESTADO%TYPE;

  sTipTerminal       GA_SINIESTROS.TIP_TERMINAL%TYPE;
  sSimCard       VARCHAR2(1);
  sAplicaLN       GED_PARAMETROS.VAL_PARAMETRO%TYPE;

  ErrorTriger       EXCEPTION;

BEGIN
    SELECT UPPER(VAL_PARAMETRO)
    INTO sAplicaLN
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO = 'APLIC_OPER_LN'
    AND COD_MODULO = 'GA'
    AND COD_PRODUCTO = 1;

    IF sAplicaLN ='TRUE' THEN
          INSERT INTO GA_HISTLNCELU(NUM_SERIE, IND_PROCEQUI, COD_OPERADOR, COD_FABRICANTE,
             COD_ARTICULO, NUM_SERIEMEC, NUM_CELULAR, NUM_ABONADO, COD_CLIENTE, FEC_ALTA,
             IND_RESTRICCION, COD_ASEG, FEC_CONSTPOL, NUM_CONSTPOL, TIP_ABONADO, COD_CAUSA, IND_INFORMADO,
             NOM_USUARORA, FEC_BAJA,TIP_LISTA,DES_CAUSA,DES_MARCA_EQUIPO)
             VALUES(:OLD.NUM_SERIE, :OLD.IND_PROCEQUI, :OLD.COD_OPERADOR, :OLD.COD_FABRICANTE,
            :OLD.COD_ARTICULO, :OLD.NUM_SERIEMEC, :OLD.NUM_CELULAR, :OLD.NUM_ABONADO, :OLD.COD_CLIENTE, :OLD.FEC_ALTA,
             :OLD.IND_RESTRICCION, :OLD.COD_ASEG, :OLD.FEC_CONSTPOL, :OLD.NUM_CONSTPOL,
             :OLD.TIP_ABONADO, :OLD.COD_CAUSA, :OLD.IND_INFORMADO, USER, SYSDATE,:OLD.TIP_LISTA,:OLD.DES_CAUSA,:OLD.DES_MARCA_EQUIPO);


        BEGIN

              SELECT VAL_PARAMETRO
                 INTO sDiasForma
                 FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO = 'NUM_DIAS_FORM_SINIES'
                  AND COD_MODULO = 'GA'
                  AND COD_PRODUCTO = 1;

           SELECT rtrim(ltrim(VAL_PARAMETRO))
             INTO sSimCard
             FROM GED_PARAMETROS
            WHERE NOM_PARAMETRO = 'COD_SIMCARD_GSM'
              AND COD_MODULO = 'AL'
              AND COD_PRODUCTO = 1;

            sCodEstado := NULL;

            IF :OLD.NUM_ABONADO > 0 THEN

               BEGIN
                  SELECT COD_ESTADO,FEC_SINIESTRO, TIP_TERMINAL
                    INTO sCodEstado,dFecSiniestro,sTipTerminal
                    FROM GA_SINIESTROS
                   WHERE NUM_ABONADO = :OLD.NUM_ABONADO
                     AND NUM_SERIE    = :OLD.NUM_SERIE;
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                           sCodEstado := NULL;
                    WHEN OTHERS THEN
                           sCodEstado := NULL;
               END;

            END IF;

            IF sCodEstado = 'AN' and trunc(:OLD.FEC_CONSTPOL) <= (trunc(dFecSiniestro) + to_number(sDiasForma))
               AND sTipTerminal <> sSimCard THEN

                 SELECT NVL(count(1),0)
                   INTO nCant
                   FROM ged_codigos
                  WHERE nom_tabla = 'GA_LNCELU'
                    AND nom_columna = 'COD_CAUSA'
                    AND cod_valor = :OLD.COD_CAUSA;

                IF nCant > 0 THEN

                    SELECT VAL_PARAMETRO
                      INTO sCodOperadora
                        FROM GED_PARAMETROS
                     WHERE NOM_PARAMETRO = 'COD_OPERTMOVIL'
                       AND COD_MODULO = 'GA'
                       AND COD_PRODUCTO = 1;

                     BEGIN
                         SELECT COD_TECNOLOGIA
                           INTO sCodTecnologia
                           FROM GA_ABOCEL
                          WHERE NUM_ABONADO = :OLD.NUM_ABONADO;

                           s_tabla := 'C';

                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                              s_tabla := 'P';

                             SELECT COD_TECNOLOGIA
                               INTO sCodTecnologia
                               FROM GA_ABOAMIST
                              WHERE NUM_ABONADO = :OLD.NUM_ABONADO;
                    END;

                    SELECT PV_LNINT_SQ.NEXTVAL
                      INTO nSecuencia
                       FROM DUAL;


                    SELECT b.cod_modelo, c.des_fabricante
                    INTO sCodModelo, sDesFabricante
                    FROM ga_equipaboser a, al_articulos b, al_fabricantes c
                    WHERE a.num_abonado = :OLD.NUM_ABONADO
                    AND a.num_serie= :OLD.NUM_SERIE
                    AND b.cod_articulo=a.cod_articulo
                    AND c.cod_fabricante=b.cod_fabricante
                    AND a.fec_alta = (SELECT MAX(d.fec_alta) FROM ga_equipaboser d
                                      WHERE d.num_abonado=a.num_abonado
                                      AND d.num_serie = a.num_serie);



                     INSERT INTO PV_SERIELN_INT_TO(NUM_SECUENCIA, COD_ACCION, COD_OPERADORA, FEC_INGRESO, COD_MARCA,
                                                     COD_MODELO, COD_TECNOLOGIA, TIP_ABONADO, NUM_SERIE, FEC_CONSPOL,
                                                  NUM_CONSPOL, COD_CAUSA)
                                               VALUES(nSecuencia,'E',sCodOperadora,sysdate,sDesFabricante,
                                                          sCodModelo,sCodTecnologia,s_tabla,:OLD.NUM_SERIE,:OLD.FEC_CONSTPOL,


                                                 :OLD.NUM_CONSTPOL,:OLD.COD_CAUSA);

               END IF;

            END IF;
        END;
    END IF;

    EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR  (-20002,'ERROR INESPERADO EN TRIGGER : ORA-'||TO_CHAR(SQLCODE)||'.',TRUE);



END PV_TRG_DEL_GA_LNCELU;
/
SHOW ERRORS