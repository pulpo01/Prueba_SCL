CREATE OR REPLACE PACKAGE BODY CO_AUDITORIA_PG AS
        CV_version      CONSTANT CHAR := '1';
        CV_subversion   CONSTANT CHAR := '0';
        CV_cod_modulo   CONSTANT VARCHAR2(2) := 'CO';
        CV_formato_sel2 CONSTANT VARCHAR2(12):='FORMATO_SEL2';
                CV_formato_sel7 CONSTANT VARCHAR2(12):='FORMATO_SEL7';
                CV_mod_general  CONSTANT VARCHAR2(2):='GE';
                CN_producto     CONSTANT NUMBER :=1;
                formato_sel2    VARCHAR2(12);
                formato_sel7    VARCHAR2(12);



PROCEDURE CO_INTERES_IN_PR (EVNum_Secuencia       IN VARCHAR2,
                            ENcod_tasa            IN co_intereses.cod_tasa%type,
                                                    ENnum_secuencia       IN co_intereses.num_secuencia%type,
                                                    ENfactor_int          IN co_intereses.factor_int%type,
                                                    ENfactor_dia          IN co_intereses.factor_dia%type,
                                                    EVind_fec_cobro       IN co_intereses.ind_fec_cobro%type,
                                                    ENdias_aplicacion     IN co_intereses.dias_aplicacion%type,
                                                    EDfec_vigencia_dd_dh  IN VARCHAR2,
                                                    EDfec_vigencia_hh_dh  IN VARCHAR2,
                                                    EDfec_creacion_dh     IN VARCHAR2,
                                                    EVnom_usuario         IN co_intereses.nom_usuario%type,
                                                    EVGlosa_Error        OUT NOCOPY VARCHAR2)
--VARCHAR2,--
IS
    LN_Existe        NUMBER;
        LN_Error         NUMBER;
        LN_NGlosa        NUMBER;
        LN_num_evento    NUMBER;
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        LV_Formato_sel2  VARCHAR(12);
    LV_Formato_sel7  VARCHAR(12);
        EXC_ERROR        EXCEPTION;

/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_INTERES_IN_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que Inserta Intereses</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENcod_tasa"           Tipo="co_intereses.cod_tasa%type">Código tasa de interes</param>
  <param nom="ENnum_secuencia"      Tipo="co_intereses.num_secuencia%type">secuencia</param>
  <param nom="ENfactor_int"         Tipo="co_intereses.factor_int%type">factor Int </param>
  <param nom="ENfactor_dia"         Tipo="co_intereses.factor_dia%type">facttor dia</param>
  <param nom="EVind_fec_cobro"      Tipo="co_intereses.ind_fec_cobro%type">ind fec_cobro</param>
  <param nom="ENdias_aplicacion"    Tipo="co_intereses.dias_aplicacion%type">dias de aplicacion</param>
  <param nom="EDfec_vigencia_dd_dh" Tipo="co_intereses.fec_vigencia_dd_dh%type">fecha de vigencia desde</param>
  <param nom="EDfec_vigencia_hh_dh" Tipo="co_intereses.fec_vigencia_hh_dh%type">fecha de vigencia hasta</param>
  <param nom="EDfec_creacion_dh"    Tipo="co_intereses.fec_creacion_dh%type">fecha creación</param>
  <param nom="EVnom_usuario"        Tipo="co_intereses.nom_usuario%type">nombre de usuario</param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error"" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

BEGIN

        LN_Error:=0;
        LN_NGlosa:=0;
        LV_sSql:='';


        BEGIN
--              LN_Error:= 1;
                SELECT a.val_parametro, b.val_parametro
                INTO  LV_Formato_sel2, LV_Formato_sel7
                FROM ged_parametros a, ged_parametros b
                WHERE a.cod_modulo= b.cod_modulo
                AND   a.cod_producto = b.cod_producto
                AND a.cod_modulo =CV_mod_general
                AND a.cod_producto =CN_producto
                AND a.nom_parametro =CV_formato_sel2
                AND b.nom_parametro =CV_formato_sel7;
    END;


        --Validaciones de parámetros
        IF NOT CO_TASA_INTERES_FN (ENcod_tasa) THEN
              LN_Error:= 621; ---{Error asociado}
              RAISE EXC_ERROR;
        END IF;

        --Validación de Fechas vigencia  (Fecha Hasta debe mayor que fecha desde)
        EVGlosa_Error:= 'Error en validación de Fechas';

        IF  TO_DATE(EDfec_vigencia_hh_dh, LV_Formato_sel2||' '||LV_Formato_sel7) < TO_DATE(EDfec_vigencia_dd_dh,LV_Formato_sel2||' '||LV_Formato_sel7)  THEN
      LN_Error:= 622;--{Error asociado}
             RAISE EXC_ERROR;
        END IF;


        --Validar la existencia del registro antes de insertarlo
        EVGlosa_Error:= 'Error en DML CO_INTERESES';
        SELECT count(1)
        INTO LN_Existe
        FROM CO_INTERESES
        WHERE   COD_TASA = ENcod_tasa
        AND NUM_SECUENCIA = ENnum_secuencia;

        IF LN_Existe > 0 THEN
             LN_Error:=623;--{Error asociado}
             RAISE EXC_ERROR;
        END IF;


        --DML INSERT
        BEGIN
--      LN_Error:= 1;
        LV_sSql := 'INSERT INTO CO_INTERESES  (COD_TASA, NUM_SECUENCIA, FACTOR_INT, FACTOR_DIA, IND_FEC_COBRO, DIAS_APLICACION, FEC_VIGENCIA_DD_DH,FEC_VIGENCIA_HH_DH, FEC_CREACION_DH, NOM_USUARIO'||') VALUES ('|| ENcod_tasa||',' || ENnum_secuencia||','|| ENfactor_int|| ','|| ENfactor_dia||','||   TRIM(EVind_fec_cobro) ||','|| ENdias_aplicacion|| ','|| TO_DATE(EDfec_vigencia_dd_dh,'DD-MM-YYYY')|| ',' || TO_DATE(EDfec_vigencia_hh_dh,'DD-MM-YYYY HH24:MI:SS')||','|| TO_DATE(EDfec_creacion_dh,'DD-MM-YYYY')||','|| EVnom_usuario||')';

                EVGlosa_Error:= 'Error al insertar en CO_INTERES';
                INSERT INTO CO_INTERESES (COD_TASA, NUM_SECUENCIA, FACTOR_INT, FACTOR_DIA,
                                          IND_FEC_COBRO, DIAS_APLICACION, FEC_VIGENCIA_DD_DH, FEC_VIGENCIA_HH_DH,
                                          FEC_CREACION_DH, NOM_USUARIO)
                VALUES (ENcod_tasa, ENnum_secuencia, ENfactor_int, ENfactor_dia, TRIM(EVind_fec_cobro), ENdias_aplicacion,
                        TO_DATE(EDfec_vigencia_dd_dh,LV_Formato_sel2),
                                TO_DATE(EDfec_vigencia_hh_dh,LV_Formato_sel2||' '||LV_Formato_sel7),
                                TO_DATE(EDfec_creacion_dh,LV_Formato_sel2),
                                EVnom_usuario);
        END;
    LN_Error := 0;
        LN_NGlosa:=1;
        RAISE EXC_ERROR;
    EXCEPTION
          WHEN EXC_ERROR THEN
                 BEGIN
                  IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                       BEGIN
                                                IF LN_NGlosa=1 THEN
                                                         EVGlosa_Error := 'OK';
                                            ELSE
                                                     EVGlosa_Error:= 'Error No clasificado';
                                                END IF;
                                   END;
                      END IF;
                          LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_IN_PR' ||' '|| EVGlosa_Error;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                     CV_version||'.'||CV_subversion,
                                                     USER, 'CO_AUDITORIA_PG.CO_INTERES_IN_PR',
                                                     LV_sSql , SQLCODE, EVGlosa_Error);

              -- Inserta error en ga_trasacabo
                          INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                          VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
         END;
--        ge_errores_pg.grabapl
          WHEN OTHERS THEN
                 BEGIN
                          EVGlosa_Error := SQLERRM;
                  -- Inserta error en ga_trasacabo
                          INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                          VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

                          LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_IN_PR' ||' '|| EVGlosa_Error;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                     CV_version||'.'||CV_subversion,
                                                     USER, 'CO_AUDITORIA_PG.CO_INTERES_IN_PR',
                                                     LV_sSql , SQLCODE, EVGlosa_Error);
         END;


 END;



PROCEDURE CO_INTERES_UP_PR (EVNum_Secuencia       IN VARCHAR2,
                            ENcod_tasa            IN co_intereses.cod_tasa%type,
                                                        ENnum_secuencia       IN co_intereses.num_secuencia%type,
                                                        ENfactor_int          IN co_intereses.factor_int%type,
                                                        ENfactor_dia          IN co_intereses.factor_dia%type,
                                                        EVind_fec_cobro       IN co_intereses.ind_fec_cobro%type,
                                                        ENdias_aplicacion     IN co_intereses.dias_aplicacion%type,
                                                        EDfec_vigencia_dd_dh  IN VARCHAR2,--co_intereses.fec_vigencia_dd_dh%type,
                                                        EDfec_vigencia_hh_dh  IN VARCHAR2,--co_intereses.fec_vigencia_hh_dh%type,
                                                        EDfec_creacion_dh     IN VARCHAR2,--co_intereses.fec_creacion_dh%type,
                                                        EVnom_usuario         IN co_intereses.nom_usuario%type,
                                                        EVGlosa_Error         OUT NOCOPY VARCHAR2)

/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_INTERES_UP_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que Actualiza Intereses</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENcod_tasa"           Tipo="co_intereses.cod_tasa%type">Código tasa de interes</param>
  <param nom="ENnum_secuencia"      Tipo="co_intereses.num_secuencia%type">secuencia</param>
  <param nom="ENfactor_int"         Tipo="co_intereses.factor_int%type">factor Int </param>
  <param nom="ENfactor_dia"         Tipo="co_intereses.factor_dia%type">facttor dia</param>
  <param nom="EVind_fec_cobro"      Tipo="co_intereses.ind_fec_cobro%type">ind fec_cobro</param>
  <param nom="ENdias_aplicacion"    Tipo="co_intereses.dias_aplicacion%type">dias de aplicacion</param>
  <param nom="EDfec_vigencia_dd_dh" Tipo="co_intereses.fec_vigencia_dd_dh%type">fecha de vigencia desde</param>
  <param nom="EDfec_vigencia_hh_dh" Tipo="co_intereses.fec_vigencia_hh_dh%type">fecha de vigencia hasta</param>
  <param nom="EDfec_creacion_dh"    Tipo="co_intereses.fec_creacion_dh%type">fecha creación</param>
  <param nom="EVnom_usuario"        Tipo="co_intereses.nom_usuario%type">nombre de usuario</param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
        LN_Error   NUMBER;
        LN_NGlosa  NUMBER;
    LN_num_evento    NUMBER;
        LV_Formato_sel2  VARCHAR(12);
    LV_Formato_sel7  VARCHAR(12);
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        EXC_ERROR  EXCEPTION;

BEGIN

    LN_Error:=0;
        LN_NGlosa:=0;

        BEGIN
                SELECT a.val_parametro, b.val_parametro
                INTO  LV_Formato_sel2, LV_Formato_sel7
                FROM ged_parametros a, ged_parametros b
                WHERE a.cod_modulo= b.cod_modulo
                AND   a.cod_producto = b.cod_producto
                AND a.cod_modulo =CV_mod_general
                AND a.cod_producto =CN_producto
                AND a.nom_parametro =CV_formato_sel2
                AND b.nom_parametro =CV_formato_sel7;
    END;

        --Validación de Fechas vigencia  (Fecha Hasta debe mayor que fecha desde)
        EVGlosa_Error:= 'Error en validación de Fechas';
--      LN_Error
        IF EDfec_vigencia_dd_dh is not null  AND EDfec_vigencia_hh_dh  is not null THEN
         IF  TO_DATE(EDfec_vigencia_hh_dh,LV_Formato_sel2||' '||LV_Formato_sel7) < TO_DATE(EDfec_vigencia_dd_dh,LV_Formato_sel2||' '||LV_Formato_sel7)  THEN
              LN_Error:= 622;--{Error asociado}
              RAISE EXC_ERROR ;
                 END IF;
        END IF;


        BEGIN
 --      LN_Error:= 1;
       LV_sSql := 'UPDATE CO_INTERESES  SET  FACTOR_INT =' || ENfactor_int ||', FACTOR_DIA =' || ENfactor_dia ||',    IND_FEC_COBRO ='|| TRIM(EVind_fec_cobro) ||', DIAS_APLICACION = '||ENdias_aplicacion ||', FEC_VIGENCIA_DD_DH = '|| TO_DATE(EDfec_vigencia_dd_dh,'DD-MM-YYYY')||',  FEC_VIGENCIA_HH_DH = '||TO_DATE(EDfec_vigencia_hh_dh,'DD-MM-YYYY HH24:MI:SS')||', FEC_CREACION_DH = '|| TO_DATE(EDfec_creacion_dh,'DD-MM-YYYY')||',  NOM_USUARIO = '|| EVnom_usuario||' WHERE COD_TASA = ' || ENcod_tasa || ' AND NUM_SECUENCIA = '|| ENnum_secuencia ||')';

                --DML UPDATE
                EVGlosa_Error:= 'Error en Update a CO_INTERESES';
        --      LN_Error
                UPDATE CO_INTERESES
                SET factor_int = DECODE( ENfactor_int, NULL, factor_int,ENfactor_int),
                    factor_dia = DECODE( ENfactor_dia, NULL, factor_dia, ENfactor_dia),
                    ind_fec_cobro = DECODE( EVind_fec_cobro, NULL, ind_fec_cobro, TRIM(EVind_fec_cobro)),
                    dias_aplicacion = DECODE( ENdias_aplicacion, NULL, dias_aplicacion, ENdias_aplicacion),
                    fec_vigencia_dd_dh = DECODE( EDfec_vigencia_dd_dh, NULL, fec_vigencia_dd_dh,TO_DATE(EDfec_vigencia_dd_dh,LV_Formato_sel2)),
                    fec_vigencia_hh_dh = DECODE( EDfec_vigencia_hh_dh, NULL, fec_vigencia_hh_dh,TO_DATE(EDfec_vigencia_hh_dh,LV_Formato_sel2||' '||LV_Formato_sel7)),
                    fec_creacion_dh = DECODE (EDfec_creacion_dh, NULL, fec_creacion_dh, TO_DATE(EDfec_creacion_dh,LV_Formato_sel2)),
                    nom_usuario = DECODE( EVnom_usuario, NULL, nom_usuario, EVnom_usuario)
                WHERE   COD_TASA= ENcod_tasa
                AND NUM_SECUENCIA= ENnum_secuencia;
        END;
    LN_Error := 0;
        LN_NGlosa:=1;
        RAISE EXC_ERROR;
EXCEPTION
        WHEN EXC_ERROR THEN
      BEGIN
             IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                      BEGIN
                                   IF LN_NGlosa=1 THEN
                                            EVGlosa_Error := 'OK';
                               ELSE
                                        EVGlosa_Error:= 'Error No clasificado';
                                   END IF;
                          END;
                 END IF;
         -- Inserta error en ga_trasacabo
         INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
         VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

         LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_UP_PR' ||' '|| EVGlosa_Error;
         LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'CO_AUDITORIA_PG.CO_INTERES_UP_PR',
                                                LV_sSql , SQLCODE, EVGlosa_Error);
      END;
        WHEN OTHERS THEN
           BEGIN
                  EVGlosa_Error := SQLERRM;
          -- Inserta error en ga_trasacabo
                  INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                  VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
                  LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_UP_PR' ||' '|| EVGlosa_Error;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                 CV_version||'.'||CV_subversion,
                                                 USER, 'CO_AUDITORIA_PG.CO_INTERES_UP_PR',
                                                 LV_sSql , SQLCODE, EVGlosa_Error);
       END;

END;



PROCEDURE CO_INTERES_DE_PR (EVNum_Secuencia  IN VARCHAR2,
                            ENcod_tasa       IN co_intereses.cod_tasa%type,
                            ENnum_secuencia  IN co_intereses.num_secuencia%type,
                            EVGlosa_Error    OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_INTERES_DE_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que Elimina Intereses</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENcod_tasa"           Tipo="co_intereses.cod_tasa%type">Código tasa de interes</param>
  <param nom="ENnum_secuencia"      Tipo="co_intereses.num_secuencia%type">secuencia</param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
    LN_num_evento    NUMBER;
        LN_Existe        NUMBER;
        LN_Error         NUMBER;
        LN_NGlosa        NUMBER;
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        EXC_ERROR  EXCEPTION;

BEGIN

        LN_Error:=0;
        LN_NGlosa:=0;

        --Validar la existencia del registro antes de borrarlo

        EVGlosa_Error:= 'Error en DML CO_INTERESES';
        SELECT count(1)
        INTO LN_Existe
        FROM CO_INTERESES
    WHERE       COD_TASA= ENcod_tasa
    AND NUM_SECUENCIA= ENnum_secuencia;

        IF LN_Existe=0  THEN
             BEGIN
                      LN_Error:= 5;--{Error asociado}
                  RAISE EXC_ERROR ;
                 END;
        END IF;



        BEGIN
                --DML DELETE
---             LN_Error:= 1;
                LV_sSql := ' DELETE FRO CO_INTERESES WHERE COD_TASA = ' || ENcod_tasa||' AND NUM_SECUENCIA = '||ENnum_secuencia;
                EVGlosa_Error:= 'Error en Delete CO_INTERESES';
                DELETE FROM CO_INTERESES
                WHERE   COD_TASA= ENcod_tasa
                AND NUM_SECUENCIA= ENnum_secuencia;
    END;

    LN_Error := 0;
        LN_NGlosa:=1;
        RAISE EXC_ERROR;
EXCEPTION
        WHEN EXC_ERROR THEN
           BEGIN
             IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                  BEGIN
                                   IF LN_NGlosa=1 THEN
                                                EVGlosa_Error := 'OK';
                                   ELSE
                                                EVGlosa_Error:= 'Error No clasificado';
                                   END IF;
                          END;
                 END IF;
         -- Inserta error en ga_trasacabo
             INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

                 LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_DE_PR' ||' '|| EVGlosa_Error;
         LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'CO_AUDITORIA_PG.CO_INTERES_DE_PR',
                                                LV_sSql , SQLCODE, EVGlosa_Error);
       END;
--        ge_errores_pg.grabapl
        WHEN OTHERS THEN
                 BEGIN
                          EVGlosa_Error := SQLERRM;
              -- Inserta error en ga_trasacabo
                      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                      VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

                          LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_DE_PR' ||' '|| EVGlosa_Error;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                     CV_version||'.'||CV_subversion,
                                                    USER, 'CO_AUDITORIA_PG.CO_INTERES_DE_PR',
                                                    LV_sSql , SQLCODE, EVGlosa_Error);
         END;
END;




---------------------------------------------------------------------------------------------------------------------
PROCEDURE CO_CATEGORIAS_IN_PR (EVNum_Secuencia   IN VARCHAR2,
                               ENcod_categoria   IN co_categorias_td.cod_categoria%type,
                               EVdes_categoria   IN co_categorias_td.des_categoria%type,
                               ENcod_tasa        IN co_categorias_td.cod_tasa%type,
                                               ENnro_dgracia     IN co_categorias_td.nro_dgracia%type,
                               EVGlosa_Error     OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_CATEGORIAS_IN_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que Inserta categorias</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENnum_secuencia"      Tipo="VARCHAR2">secuencia</param>
  <param nom="ENcod_categoria"      Tipo="co_categorias_td.cod_categoria%type">factor Int </param>
  <param nom="EVdes_categoria"      Tipo="co_categorias_td.des_categoria%type">facttor dia</param>
  <param nom="EVcod_tasa"           Tipo="co_categorias_td.cod_tasa%type">ind fec_cobro</param>
  <param nom="ENnro_dgracia"        Tipo="co_categorias_td.nro_dgracia%type">dias de aplicacion</param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
        LN_num_evento    NUMBER;
    LN_Existe        NUMBER;
        LN_Error         NUMBER;
        LN_NGlosa        NUMBER;
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        EXC_ERROR        EXCEPTION;

BEGIN

        LN_Error:=0;
        LN_NGlosa:=0;

        --Validaciones de parámetros
        IF NOT CO_TASA_INTERES_FN (ENcod_tasa) THEN
              LN_Error:= 1; ---{Error asociado}
              RAISE EXC_ERROR;
        END IF;

        --Validar la existencia del registro antes de insertarlo
    EVGlosa_Error:= 'Error en DML CO_CATEGORIAS_TD';
        SELECT count(1)
        INTO LN_Existe
        FROM CO_CATEGORIAS_TD
    WHERE       COD_CATEGORIA=ENcod_categoria;

        IF LN_Existe > 0 THEN
                LN_Error:=623;
                RAISE EXC_ERROR ;
        END IF;

        --DML INSERT
        BEGIN
--      LN_Error:= 1; poner codigo y sacar glosas
                LV_sSql := 'INSERT INTO CO_CATEGORIAS_TD  (COD_CATEGORIA, DES_CATEGORIA, COD_TASA, NRO_DGRACIA) VALUES ('|| ENcod_categoria||',' || EVdes_categoria||','|| ENcod_tasa|| ','|| ENnro_dgracia||')';

                INSERT INTO CO_CATEGORIAS_TD (COD_CATEGORIA, DES_CATEGORIA,
                COD_TASA, NRO_DGRACIA)
                VALUES (ENcod_categoria, EVdes_categoria, ENcod_tasa, ENnro_dgracia);
    END;

    LN_Error := 0;
        LN_NGlosa:=1;
    RAISE EXC_ERROR;
 EXCEPTION
          WHEN EXC_ERROR THEN
                 BEGIN
                  IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                       BEGIN
                                                IF LN_NGlosa=1 THEN
                                                         EVGlosa_Error := 'OK';
                                            ELSE
                                                     EVGlosa_Error:= 'Error No clasificado';
                                                END IF;
                                   END;
                      END IF;
              -- Inserta error en ga_trasacabo
                          INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                          VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

                          LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_CATEGORIAS_IN_PR' ||' '|| EVGlosa_Error;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                     CV_version||'.'||CV_subversion,
                                                     USER, 'CO_AUDITORIA_PG.CO_CATEGORIAS_IN_PR',
                                                     LV_sSql , SQLCODE, EVGlosa_Error);
         END;

          WHEN OTHERS THEN
                 BEGIN
                          EVGlosa_Error := SQLERRM;
                  -- Inserta error en ga_trasacabo
                          INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                          VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

                          LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_CATEGORIAS_IN_PR' ||' '|| EVGlosa_Error;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                     CV_version||'.'||CV_subversion,
                                                     USER, 'CO_AUDITORIA_PG.CO_CATEGORIAS_IN_PR',
                                                     LV_sSql , SQLCODE, EVGlosa_Error);
         END;


END;


PROCEDURE  CO_CATEGORIAS_UP_PR (EVNum_Secuencia   IN VARCHAR2,
                                ENcod_categoria   IN co_categorias_td.cod_categoria%type,
                                                                EVdes_categoria   IN co_categorias_td.des_categoria%type,
                                                                ENcod_tasa        IN co_categorias_td.cod_tasa%type,
                                                                ENnro_dgracia     IN co_categorias_td.nro_dgracia%type,
                                EVGlosa_Error     OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_CATEGORIAS_UP_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que Actualiza categorias</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENnum_secuencia"      Tipo="VARCHAR2">secuencia</param>
  <param nom="ENcod_categoria"      Tipo="co_categorias_td.cod_categoria%type">factor Int </param>
  <param nom="EVdes_categoria"      Tipo="co_categorias_td.des_categoria%type">facttor dia</param>
  <param nom="EVcod_tasa"           Tipo="co_categorias_td.cod_tasa%type">ind fec_cobro</param>
  <param nom="ENnro_dgracia"        Tipo="co_categorias_td.nro_dgracia%type">dias de aplicacion</param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
        LN_Error         NUMBER;
        LN_NGlosa        NUMBER;
        LN_num_evento    NUMBER;
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        EXC_ERROR        EXCEPTION;



BEGIN
    LN_Error:=0;
        LN_NGlosa:=0;

        --Validaciones de parámetros
    IF NOT CO_TASA_INTERES_FN (ENcod_tasa) THEN
                LN_Error:=621;
        RAISE EXC_ERROR ;
        END IF;

    BEGIN
                --DML UPDATE
--         LN_Error:= 1; y sacar glosa
       LV_sSql := 'UPDATE CO_CATEGORIAS_TD  SET  COD_TASA =' || ENcod_tasa ||', DES_CATEGORIA =' || EVdes_categoria ||',    NRO_DGRACIA ='|| ENnro_dgracia||' WHERE COD_CATEGORIA = ' || ENcod_categoria;

                EVGlosa_Error:= 'Error en Update a CO_CATEGORIAS_TD';
                UPDATE CO_CATEGORIAS_TD
                SET cod_tasa=DECODE(ENcod_tasa, NULL, cod_tasa, ENcod_tasa),
                des_categoria= DECODE(EVdes_categoria, NULL, des_categoria, EVdes_categoria),
                nro_dgracia= DECODE(ENnro_dgracia, NULL, nro_dgracia, ENnro_dgracia)
                WHERE COD_CATEGORIA= ENcod_categoria;
        END;

    LN_Error := 0;
        LN_NGlosa:=1;
        RAISE EXC_ERROR;
EXCEPTION
        WHEN EXC_ERROR THEN
           BEGIN
             IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                  BEGIN
                                   IF LN_NGlosa=1 THEN
                                                EVGlosa_Error := 'OK';
                                   ELSE
                                                EVGlosa_Error:= 'Error No clasificado';
                                   END IF;
                          END;
                 END IF;
         -- Inserta error en ga_trasacabo
             INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
                 LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_CATEGORIAS_UP_PR' ||' '|| EVGlosa_Error;
         LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'CO_AUDITORIA_PG.CO_CATEGORIAS_UP_PR',
                                                LV_sSql , SQLCODE, EVGlosa_Error);

       END;
--        ge_errores_pg.grabapl
        WHEN OTHERS THEN
                 BEGIN
                          EVGlosa_Error := SQLERRM;
              -- Inserta error en ga_trasacabo
                      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                      VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
                          LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_CATEGORIAS_UP_PR' ||' '|| EVGlosa_Error;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                     CV_version||'.'||CV_subversion,
                                                     USER, 'CO_AUDITORIA_PG.CO_CATEGORIAS_UP_PR',
                                                     LV_sSql , SQLCODE, EVGlosa_Error);

         END;
END;



PROCEDURE  CO_CATEGORIAS_DE_PR (EVNum_Secuencia   IN VARCHAR2,
                                ENcod_categoria   IN co_categorias_td.cod_categoria%type,
                                EVGlosa_Error     OUT NOCOPY VARCHAR2)
/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_CATEGORIAS_DE_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que elimina categorias</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENnum_secuencia"      Tipo="VARCHAR2">secuencia</param>
  <param nom="ENcod_categoria"      Tipo="co_categorias_td.cod_categoria%type">factor Int </param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
    LN_Existe        NUMBER;
        LN_Error         NUMBER(1):=0;
        LN_NGlosa        NUMBER(2):=0;
        LN_num_evento    NUMBER;
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        EXC_ERROR        EXCEPTION;

BEGIN
        --Validar la existencia del registro antes de insertarlo
    EVGlosa_Error:= 'Error en DML CO_CATEGORIAS_TD';
        SELECT count(1)
        INTO LN_Existe
        FROM CO_CATEGORIAS_TD
    WHERE COD_CATEGORIA= ENcod_categoria;

        IF LN_Existe=0 THEN
                LN_Error:= '2';
                RAISE EXC_ERROR ;
    END IF;

        --DML IDELETE
--      LN_Error:= 1; y sacar glosa
        LV_sSql := ' DELETE FRO CO_CATEGORIAS_TD WHERE COD_CATEGORIA = ' || ENcod_categoria;
    EVGlosa_Error:= 'Error en Delete CO_CATEGORIAS_TD';
        DELETE FROM CO_CATEGORIAS_TD
    WHERE COD_CATEGORIA=ENcod_categoria;

    LN_Error :=0;
        LN_NGlosa:=1;
        RAISE EXC_ERROR;
EXCEPTION
        WHEN EXC_ERROR THEN
           BEGIN
             IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                  BEGIN
                                   IF LN_NGlosa=1 THEN
                                                EVGlosa_Error := 'OK';
                                   ELSE
                                                EVGlosa_Error:= 'Error No clasificado';
                                   END IF;
                          END;
                 END IF;
         -- Inserta error en ga_trasacabo
             INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
             VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
                 LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_CATEGORIAS_DE_PR' ||' '|| EVGlosa_Error;
         LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'CO_AUDITORIA_PG.CO_CATEGORIAS_DE_PR',
                                                LV_sSql , SQLCODE, EVGlosa_Error);

       END;
--        ge_errores_pg.grabapl
        WHEN OTHERS THEN
                 BEGIN
                          EVGlosa_Error := SQLERRM;
              -- Inserta error en ga_trasacabo
                      INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                      VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
                  LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_CATEGORIAS_DE_PR' ||' '|| EVGlosa_Error;
              LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                     CV_version||'.'||CV_subversion,
                                                     USER, 'CO_AUDITORIA_PG.CO_CATEGORIAS_DE_PR',
                                                     LV_sSql , SQLCODE, EVGlosa_Error);

         END;
END;

---------------------------------------------------------------------------------------------------------------------
PROCEDURE CO_INTERES_REG_UP_PR (EVNum_Secuencia       IN VARCHAR2,
                                ENcod_tasa            IN co_intereses.cod_tasa%type,
                                                    ENnum_secuencia       IN co_intereses.num_secuencia%type,
                                                                EDfec_vigencia_hh_dh  IN VARCHAR2,--co_intereses.fec_vigencia_hh_dh%type,
                                                        EDfec_creacion_dh     IN VARCHAR2,--co_intereses.fec_creacion_dh%type,
                                                    EVnom_usuario         IN co_intereses.nom_usuario%type,
                                                            EVGlosa_Error         OUT NOCOPY VARCHAR2)

/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_INTERES_REG_UP_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que Actualiza Intereses</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENcod_tasa"           Tipo="co_intereses.cod_tasa%type">Código tasa de interes</param>
  <param nom="ENnum_secuencia"      Tipo="co_intereses.num_secuencia%type">secuencia</param>
  <param nom="EDfec_vigencia_hh_dh" Tipo="co_intereses.fec_vigencia_hh_dh%type">fecha de vigencia hasta</param>
  <param nom="EDfec_creacion_dh"    Tipo="co_intereses.fec_creacion_dh%type">fecha creación</param>
  <param nom="EVnom_usuario"        Tipo="co_intereses.nom_usuario%type">nombre de usuario</param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
        LN_Error   NUMBER;
        LN_NGlosa  NUMBER;
    LN_num_evento    NUMBER;
        LV_Formato_sel2  VARCHAR(12);
    LV_Formato_sel7  VARCHAR(12);
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        EXC_ERROR  EXCEPTION;

BEGIN

    LN_Error:=0;
        LN_NGlosa:=0;

        BEGIN
                SELECT a.val_parametro, b.val_parametro
                INTO  LV_Formato_sel2, LV_Formato_sel7
                FROM ged_parametros a, ged_parametros b
                WHERE a.cod_modulo= b.cod_modulo
                AND   a.cod_producto = b.cod_producto
                AND a.cod_modulo =CV_mod_general
                AND a.cod_producto =CN_producto
                AND a.nom_parametro =CV_formato_sel2
                AND b.nom_parametro =CV_formato_sel7;
    END;

        --Validación de Fechas vigencia  (Fecha Hasta debe mayor que fecha desde)
        EVGlosa_Error:= 'Error en validación de Fechas';
--      LN_Error
        IF EDfec_creacion_dh is not null  AND EDfec_vigencia_hh_dh  is not null THEN
         IF  TO_DATE(EDfec_vigencia_hh_dh,LV_Formato_sel2||' '||LV_Formato_sel7) < TO_DATE(EDfec_creacion_dh,LV_Formato_sel2||' '||LV_Formato_sel7)  THEN
              LN_Error:= 622;--{Error asociado}
              RAISE EXC_ERROR ;
                 END IF;
        END IF;


        BEGIN
 --      LN_Error:= 1;
       LV_sSql := 'UPDATE CO_INTERESES  SET FEC_VIGENCIA_HH_DH = '||TO_DATE(EDfec_vigencia_hh_dh,'DD-MM-YYYY HH24:MI:SS')||', FEC_CREACION_DH = '|| TO_DATE(EDfec_creacion_dh,'DD-MM-YYYY')||',  NOM_USUARIO = '|| EVnom_usuario||' WHERE COD_TASA = ' || ENcod_tasa || ' AND NUM_SECUENCIA = '|| ENnum_secuencia ||')';

                --DML UPDATE
                EVGlosa_Error:= 'Error en Update a CO_INTERESES';
        --      LN_Error
                UPDATE CO_INTERESES
                SET fec_vigencia_hh_dh = DECODE( EDfec_vigencia_hh_dh, NULL, fec_vigencia_hh_dh,TO_DATE(EDfec_vigencia_hh_dh,LV_Formato_sel2||' '||LV_Formato_sel7)),
                    fec_creacion_dh = DECODE (EDfec_creacion_dh, NULL, fec_creacion_dh, TO_DATE(EDfec_creacion_dh,LV_Formato_sel2)),
                    nom_usuario = DECODE( EVnom_usuario, NULL, nom_usuario, EVnom_usuario)
                WHERE   COD_TASA= ENcod_tasa
                AND NUM_SECUENCIA= ENnum_secuencia;
        END;
    LN_Error := 0;
        LN_NGlosa:=1;
        RAISE EXC_ERROR;
EXCEPTION
        WHEN EXC_ERROR THEN
      BEGIN
             IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                      BEGIN
                                   IF LN_NGlosa=1 THEN
                                            EVGlosa_Error := 'OK';
                               ELSE
                                        EVGlosa_Error:= 'Error No clasificado';
                                   END IF;
                          END;
                 END IF;
         -- Inserta error en ga_trasacabo
         INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
         VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

         LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_REG_UP_PR' ||' '|| EVGlosa_Error;
         LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'CO_AUDITORIA_PG.CO_INTERES_REG_UP_PR',
                                                LV_sSql , SQLCODE, EVGlosa_Error);
      END;
        WHEN OTHERS THEN
           BEGIN
                  EVGlosa_Error := SQLERRM;
          -- Inserta error en ga_trasacabo
                  INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                  VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
                  LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_REG_UP_PR' ||' '|| EVGlosa_Error;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                 CV_version||'.'||CV_subversion,
                                                 USER, 'CO_AUDITORIA_PG.CO_INTERES_REG_UP_PR',
                                                 LV_sSql , SQLCODE, EVGlosa_Error);
       END;

END;
PROCEDURE CO_INTERES_PENULREG_UP_PR (EVNum_Secuencia       IN VARCHAR2,
                                     ENcod_tasa            IN co_intereses.cod_tasa%type,
                                                         ENnum_secuencia       IN co_intereses.num_secuencia%type,
                                                                 EDfec_vigencia_hh_dh  IN VARCHAR2,--co_intereses.fec_vigencia_hh_dh%type,
                                                                 EVGlosa_Error         OUT NOCOPY VARCHAR2)

/*
<Documentación TipoDoc="Procedimiento">
<Elemento Nombre="CO_INTERES_PENULREG_UP_PR"
 Lenguaje="PL/SQL" Fecha="23-11-2005"
 Versión="1.0.0" Diseñador="****"
 Programador="***" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Procedimiento que Actualiza Intereses</Descripción>
<Parámetros>
<Entrada>
  <param nom="ENcod_tasa"           Tipo="co_intereses.cod_tasa%type">Código tasa de interes</param>
  <param nom="ENnum_secuencia"      Tipo="co_intereses.num_secuencia%type">secuencia</param>
  <param nom="EDfec_vigencia_hh_dh" Tipo="co_intereses.fec_vigencia_hh_dh%type">fecha de vigencia hasta</param>
  <param nom="EDfec_creacion_dh"    Tipo="co_intereses.fec_creacion_dh%type">fecha creación</param>
  <param nom="EVnom_usuario"        Tipo="co_intereses.nom_usuario%type">nombre de usuario</param>
</Entrada>
<Salida>
  <param nom="EVGlosa_Error" Tipo="VARCHAR">Descripción de error devuelto</param>
</Parámetros>
</Elemento>
</Documentación>
*/

IS
        LN_Error   NUMBER;
        LN_NGlosa  NUMBER;
    LN_num_evento    NUMBER;
        LV_Formato_sel2  VARCHAR(12);
    LV_Formato_sel7  VARCHAR(12);
        LV_mens_retorno  VARCHAR(2000);
        LV_sSql          VARCHAR(3000);
        EXC_ERROR  EXCEPTION;

BEGIN

    LN_Error:=0;
        LN_NGlosa:=0;

        BEGIN
                SELECT a.val_parametro, b.val_parametro
                INTO  LV_Formato_sel2, LV_Formato_sel7
                FROM ged_parametros a, ged_parametros b
                WHERE a.cod_modulo= b.cod_modulo
                AND   a.cod_producto = b.cod_producto
                AND a.cod_modulo =CV_mod_general
                AND a.cod_producto =CN_producto
                AND a.nom_parametro =CV_formato_sel2
                AND b.nom_parametro =CV_formato_sel7;
    END;


        BEGIN
 --      LN_Error:= 1;
       LV_sSql := 'UPDATE CO_INTERESES  SET FEC_VIGENCIA_HH_DH = '||TO_DATE(EDfec_vigencia_hh_dh,'DD-MM-YYYY HH24:MI:SS')||' WHERE COD_TASA = ' || ENcod_tasa || ' AND NUM_SECUENCIA = '|| ENnum_secuencia ||')';

                --DML UPDATE
                EVGlosa_Error:= 'Error en Update a CO_INTERESES';
        --      LN_Error
                UPDATE CO_INTERESES
                SET fec_vigencia_hh_dh = DECODE( EDfec_vigencia_hh_dh, NULL, fec_vigencia_hh_dh,TO_DATE(EDfec_vigencia_hh_dh,LV_Formato_sel2||' '||LV_Formato_sel7))
                WHERE   COD_TASA= ENcod_tasa
                AND NUM_SECUENCIA= ENnum_secuencia;
        END;
    LN_Error := 0;
        LN_NGlosa:=1;
        RAISE EXC_ERROR;
EXCEPTION
        WHEN EXC_ERROR THEN
      BEGIN
             IF NOT ge_errores_pg.MensajeError(LN_Error, EVGlosa_Error) THEN
                      BEGIN
                                   IF LN_NGlosa=1 THEN
                                            EVGlosa_Error := 'OK';
                               ELSE
                                        EVGlosa_Error:= 'Error No clasificado';
                                   END IF;
                          END;
                 END IF;
         -- Inserta error en ga_trasacabo
         INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
         VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);

        LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_PENULREG_UP_PR ' ||' '|| EVGlosa_Error;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno, CV_version||'.'||CV_subversion,USER, 'CO_AUDITORIA_PG.CO_INTERES_PENULREG_UP_PR', LV_sSql , SQLCODE, EVGlosa_Error);
      END;
        WHEN OTHERS THEN
           BEGIN
                  EVGlosa_Error := SQLERRM;
          -- Inserta error en ga_trasacabo
                  INSERT INTO GA_TRANSACABO(NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                  VALUES (TO_NUMBER(EVNum_Secuencia), LN_Error, EVGlosa_Error);
                  LV_mens_retorno:= 'CO_AUDITORIA_PG.CO_INTERES_PENULREG_UP_PR' ||' '|| EVGlosa_Error;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                 CV_version||'.'||CV_subversion,
                                                 USER, 'CO_AUDITORIA_PG.CO_INTERES_PENULREG_UP_PR',
                                                 LV_sSql , SQLCODE, EVGlosa_Error);
       END;

END;


---------------------------------------------------------------------------------------------------------------------

FUNCTION  CO_TASA_INTERES_FN (ENcod_tasa co_intereses.cod_tasa%type
) RETURN BOOLEAN

IS
    LN_Existe NUMBER;
BEGIN

        SELECT count(1)
        INTO LN_Existe
        FROM co_tasas_td
    WHERE       COD_TASA= ENcod_tasa;

        IF LN_Existe > 0 THEN
             RETURN TRUE;
        ELSE
             RETURN FALSE;
        END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
         RETURN FALSE;
END;




END CO_AUDITORIA_PG;
/
SHOW ERRORS
