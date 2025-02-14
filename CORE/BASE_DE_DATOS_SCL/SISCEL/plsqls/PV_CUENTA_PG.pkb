CREATE OR REPLACE PACKAGE BODY PV_CUENTA_PG AS

----------------------------------------------------------------------------------------------------------------------------
        PROCEDURE PV_OBTIENE_CLIENTE_CUENTA_PR(
          EO_Cliente                                    IN                           PV_CLIENTE_QT,
          SO_Lista_CliCuenta_Prepago    OUT NOCOPY               refCursor,
          SO_Lista_CliCuenta_Pospago    OUT NOCOPY               refCursor,
          SO_Lista_CliCuenta_Hibrido    OUT NOCOPY               refCursor,
      SN_cod_retorno                    OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno                   OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento                     OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_CLIENTE_CUENTA_PR"
              Lenguaje="PL/SQL"
              Fecha="04-06-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="EO_Cliente" Tipo="estructura">estructura de cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;

        BEGIN

                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                lv_ssql := 'SELECT DISTINCT a.cod_cliente,';
                lv_ssql := lv_ssql || ' a.nom_cliente';
                lv_ssql := lv_ssql || ' a.cod_ciclo,';
                lv_ssql := lv_ssql || ' a.cod_cuenta,a.nom_apeclien1,a.nom_apeclien2,a.num_ident,a.cod_tipident';
                lv_ssql := lv_ssql || ' FROM ge_clientes a, GA_CATRIBUTCLIE B';
                lv_ssql := lv_ssql || ' WHERE a.cod_cuenta = '||EO_Cliente.cod_cuenta;
                lv_ssql := lv_ssql || ' AND a.cod_cliente = b.cod_cliente';
                lv_ssql := lv_ssql || ' AND IND_AGENTE = ''N''';
                lv_ssql := lv_ssql || ' AND IND_SITUACION <> ''B''';
                lv_ssql := lv_ssql || ' AND COD_CICLO = '||CN_codciclo_prepago;
                lv_ssql := lv_ssql || ' AND A.IND_ALTA = ''M''';
                lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
                lv_ssql := lv_ssql || ' ORDER BY 1 desc';

                OPEN SO_Lista_CliCuenta_Prepago FOR
                        SELECT A.COD_CLIENTE, A.NOM_CLIENTE,    A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'I', NULL, NULL
                         FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
                         WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND COD_CICLO = CN_codciclo_prepago
                                  AND A.IND_ALTA = 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)
                         ORDER BY 1 desc;

                        lv_ssql := 'SELECT DISTINCT a.cod_cliente,';
                lv_ssql := lv_ssql || ' a.nom_cliente';
                lv_ssql := lv_ssql || ' a.cod_ciclo,';
                lv_ssql := lv_ssql || ' a.cod_cuenta,a.nom_apeclien1,a.nom_apeclien2,a.num_ident,a.cod_tipident';
                lv_ssql := lv_ssql || ' FROM ge_clientes a, GA_CATRIBUTCLIE B, GA_EMPRESA E';
                lv_ssql := lv_ssql || ' AND a.cod_cliente = b.cod_cliente';
                lv_ssql := lv_ssql || ' AND IND_AGENTE = ''N''';
                lv_ssql := lv_ssql || ' AND IND_SITUACION <> ''B''';
                lv_ssql := lv_ssql || ' AND COD_CICLO = '||CN_codciclo_prepago;
                lv_ssql := lv_ssql || ' AND A.IND_ALTA = ''M''';
                lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
                lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';
                lv_ssql := lv_ssql || ' ORDER BY 1 desc';

                OPEN SO_Lista_CliCuenta_Pospago FOR
                  SELECT A.COD_CLIENTE, A.NOM_CLIENTE,  A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, DECODE(COD_EMPRESA,NULL,'I','E'), COD_PLANTARIF, DECODE(COD_EMPRESA,NULL,0,COD_EMPRESA)
                         FROM GE_CLIENTES A, GA_CATRIBUTCLIE B, GA_EMPRESA E
                          WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND A.COD_CICLO <>  CN_codciclo_prepago
                                  AND A.IND_ALTA <> 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                  AND A.COD_CLIENTE = E.COD_CLIENTE(+)
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)
                         ORDER BY 1 desc;

                lv_ssql := 'SELECT DISTINCT a.cod_cliente,';
                lv_ssql := lv_ssql || ' a.nom_cliente';
                lv_ssql := lv_ssql || ' a.cod_ciclo,';
                lv_ssql := lv_ssql || ' a.cod_cuenta,a.nom_apeclien1,a.nom_apeclien2,a.num_ident,a.cod_tipident';
                lv_ssql := lv_ssql || ' FROM ge_clientes a, GA_CATRIBUTCLIE B';
                lv_ssql := lv_ssql || ' AND a.cod_cliente = b.cod_cliente';
                lv_ssql := lv_ssql || ' AND IND_AGENTE = ''N''';
                lv_ssql := lv_ssql || ' AND IND_SITUACION <> ''B''';
                lv_ssql := lv_ssql || ' AND COD_CICLO = '||CN_codciclo_prepago;
                lv_ssql := lv_ssql || ' AND A.IND_ALTA = ''M''';
                lv_ssql := lv_ssql || ' AND A.COD_CLIENTE  NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)';
                lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';
                lv_ssql := lv_ssql || ' ORDER BY 1 desc';


                OPEN SO_Lista_CliCuenta_Hibrido FOR
                        SELECT A.COD_CLIENTE, A.NOM_CLIENTE,    A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'I', NULL, NULL
                         FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
                         WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND COD_CICLO <>  CN_codciclo_prepago
                                  AND A.IND_ALTA <> 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                  AND A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)
                         ORDER BY 1 desc;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_CLIENTE_CUENTA_PR('||EO_Cliente.cod_cuenta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_OBTIENE_CLIENTE_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_CLIENTE_CUENTA_PR('||EO_Cliente.cod_cuenta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_OBTIENE_CLIENTE_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_CLIENTE_CUENTA_PR;

--------------------------------------------------------------------------------------------------------
        PROCEDURE PV_OBTIENE_SUBCUENTA_CUENTA_PR(
                  EO_Cliente          IN                           PV_CLIENTE_QT,
                      SO_Lista_SubCuentas OUT  NOCOPY      refCursor,
                  SN_cod_retorno          OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                  SV_mens_retorno         OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                  SN_num_evento           OUT NOCOPY       ge_errores_pg.evento)
          IS
         /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_SUBCUENTA_CUENTA_PR"
              Lenguaje="PL/SQL"
              Fecha="31-05-2007"
              Versión="La del package"
              Diseñador="Matías Guajardo"
              Programador="Matías Guajardo"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción></Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="EO_Cliente" Tipo="estructura">estructura de cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error          ge_errores_pg.DesEvent;
        LV_sSql               ge_errores_pg.vQuery;

        BEGIN
            SN_cod_retorno      := 0;
            SV_mens_retorno := NULL;
            SN_num_evento       := 0;

            IF trim(EO_Cliente.cod_valor) = '1' then

                lv_ssql := 'SELECT a.cod_cuenta,b.cod_subcuenta,b.des_subcuenta ';
                lv_ssql := lv_ssql || ' FROM  ga_cuentas a,ga_subcuentas b';
                lv_ssql := lv_ssql || ' WHERE  a.cod_cuenta = b.cod_cuenta';
                lv_ssql := lv_ssql || ' AND a.cod_cuenta = '||EO_Cliente.cod_cuenta;
                lv_ssql := lv_ssql || ' and rownum= 1';
                lv_ssql := lv_ssql || ' ORDER BY b.cod_subcuenta';

                OPEN SO_Lista_SubCuentas FOR
                SELECT a.cod_cuenta,
                       b.cod_subcuenta,
                       b.des_subcuenta
                FROM  ga_cuentas a,
                      ga_subcuentas b
                WHERE  a.cod_cuenta = b.cod_cuenta
                       AND a.cod_cuenta = EO_Cliente.cod_cuenta
                       and rownum= 1
                       ORDER BY b.cod_subcuenta;

            Else
                lv_ssql := 'SELECT a.cod_cuenta,b.cod_subcuenta,b.des_subcuenta ';
                lv_ssql := lv_ssql || ' FROM  ga_cuentas a,ga_subcuentas b';
                lv_ssql := lv_ssql || ' WHERE  a.cod_cuenta = b.cod_cuenta';
                lv_ssql := lv_ssql || ' AND a.cod_cuenta = '||EO_Cliente.cod_cuenta;
                lv_ssql := lv_ssql || ' ORDER BY b.cod_subcuenta';


                OPEN SO_Lista_SubCuentas FOR
                SELECT a.cod_cuenta,
                       b.cod_subcuenta,
                       b.des_subcuenta
                FROM  ga_cuentas a,
                      ga_subcuentas b
                WHERE  a.cod_cuenta = b.cod_cuenta
                       AND a.cod_cuenta = EO_Cliente.cod_cuenta
                ORDER BY b.cod_subcuenta;
            end if;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_SUBCUENTA_CUENTA_PR('||EO_Cliente.cod_cuenta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_OBTIENE_SUBCUENTA_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_SUBCUENTA_CUENTA_PR('||EO_Cliente.cod_cuenta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_OBTIENE_SUBCUENTA_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

        END PV_OBTIENE_SUBCUENTA_CUENTA_PR;

--------------------------------------------------------------------------------------------------------
        PROCEDURE PV_INS_CONTRATO_CUENTA_PR(
                         EO_PARAM            IN           PV_GA_ABOCEL_QT,
                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento
        )
        IS

        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_INS_CONTRATO_CUENTA_PR"
              Lenguaje="PL/SQL"
              Fecha="04-02-2008"
              Versión="La del package"
              Diseñador="**"
              Programador="**"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Ingreso en la tabla ga_contcta</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="EO_PARAM" Tipo="estructura">estructura de cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom="" Tipo=""></param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        LV_Fecha                        DATE;

        BEGIN

                sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;


                LV_sSql := 'TO_DATE('||EO_PARAM.FEC_ALTA||',''DD-MM-YYYY HH24:MI:SS'')';

                LV_Fecha:= TO_DATE(EO_PARAM.FEC_ALTA,'DD-MM-YYYY HH24:MI:SS');

                LV_sSql := 'INSERT INTO GA_CONTCTA';
                LV_sSql := LV_sSql || ' (COD_CUENTA, COD_PRODUCTO, COD_TIPCONTRATO,';
                LV_sSql := LV_sSql || '     NUM_CONTRATO, NUM_ANEXO, NUM_MESES, NUM_VENTA,';
                LV_sSql := LV_sSql || '         FEC_CONTRATO, NUM_ABONADOS)';
                LV_sSql := LV_sSql || 'VALUES ( '|| EO_PARAM.COD_CUENTA ||','|| EO_PARAM.COD_PRODUCTO ||','|| EO_PARAM.COD_TIPCONTRATO;
                LV_sSql := LV_sSql || '    ,'||EO_PARAM.NUM_CONTRATO||',' ||EO_PARAM.NUM_ANEXO||','|| EO_PARAM.NUM_MESES ;
                LV_sSql := LV_sSql || '    ,'||EO_PARAM.NUM_VENTA||','||LV_Fecha||', 1)';




                INSERT INTO GA_CONTCTA ( COD_CUENTA, COD_PRODUCTO, COD_TIPCONTRATO
                                        , NUM_CONTRATO, NUM_ANEXO,NUM_MESES
                                        , NUM_VENTA, FEC_CONTRATO, NUM_ABONADOS, NUM_ABONADO )
                VALUES ( EO_PARAM.COD_CUENTA, EO_PARAM.COD_PRODUCTO, EO_PARAM.COD_TIPCONTRATO
                           , EO_PARAM.NUM_CONTRATO, EO_PARAM.NUM_ANEXO, EO_PARAM.NUM_MESES
                           , EO_PARAM.NUM_VENTA, LV_Fecha, 1, NULL);

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := 149;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_INS_CONTRATO_CUENTA_PR('||EO_PARAM.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_INS_CONTRATO_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_INS_CONTRATO_CUENTA_PR('||EO_PARAM.NUM_ABONADO||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_INS_CONTRATO_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


        END PV_INS_CONTRATO_CUENTA_PR;

--------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_NUM_CLI_CUENTA_PR(
      EO_Cliente                        IN              PV_CLIENTE_QT,
      SN_MAX_CLI                                        OUT NOCOPY          NUMBER,
      SN_cod_retorno                    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno                   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      SN_num_evento                     OUT NOCOPY      ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "PV_OBTIENE_MAX_CLI_CUENTA_PR"
              Lenguaje="PL/SQL"
              Fecha="15-07-2008"
              Versión="La del package"
              Diseñador="Elizabeth Vera"
              Programador="Elizabeth Vera"
              Ambiente Desarrollo="BD">
              <Retorno>N/A</Retorno>>
              <Descripción>Obtiene el total de clientes, para la cuenta, y el tipo plan</Descripción>>
              <Parámetros>
                 <Entrada>
                            <param nom="EO_Cliente" Tipo="estructura">estructura de cliente</param>>
                 </Entrada>
                 <Salida>
                    <param nom=""SN_MAX_CLI Tipo="NUMBER">Devuelve el max de clientes por cuenta y por tipo de plan</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
                 </Salida>
              </Parámetros>
           </Elemento>
        </Documentación>
        */

        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql            ge_errores_pg.vQuery;
                N_MAX_CLI1                 NUMBER(5);
                N_MAX_CLI2                 NUMBER(5);

        BEGIN

            sn_cod_retorno  := 0;
            sv_mens_retorno := NULL;
            sn_num_evento   := 0;
                        SN_MAX_CLI      := 0;

                        IF (EO_Cliente.COD_TIPLAN = '1') THEN

                                    lv_ssql := 'SELECT COUNT(1)';
                        lv_ssql := lv_ssql || ' FROM GE_CLIENTES a, GA_CATRIBUTCLIE B';
                        lv_ssql := lv_ssql || ' WHERE a.cod_cuenta = '||EO_Cliente.cod_cuenta;
                        lv_ssql := lv_ssql || ' AND IND_AGENTE = ''N''';
                        lv_ssql := lv_ssql || ' AND IND_SITUACION <> ''B''';
                        lv_ssql := lv_ssql || ' AND COD_CICLO = '||CN_codciclo_prepago;
                        lv_ssql := lv_ssql || ' AND A.IND_ALTA = ''M''';
                        lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
                        lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';

                    SELECT COUNT(1)
                                        INTO SN_MAX_CLI
                                        FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
                    WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND COD_CICLO = CN_codciclo_prepago
                                  AND A.IND_ALTA = 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
                        END IF;

                        IF (EO_Cliente.COD_TIPLAN = '2') THEN

                                        lv_ssql := 'SELECT COUNT(1)';
                        lv_ssql := lv_ssql || ' FROM GE_CLIENTES a, GA_CATRIBUTCLIE B, GA_EMPRESA E';
                        lv_ssql := lv_ssql || ' WHERE a.cod_cuenta = '||EO_Cliente.cod_cuenta;
                        lv_ssql := lv_ssql || ' AND IND_AGENTE = ''N''';
                        lv_ssql := lv_ssql || ' AND IND_SITUACION <> ''B''';
                        lv_ssql := lv_ssql || ' AND COD_CICLO <> '||CN_codciclo_prepago;
                        lv_ssql := lv_ssql || ' AND A.IND_ALTA <> ''M''';
                        lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
                        lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = E.COD_CLIENTE(+)';
                        lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';

                                                -- (+)  EV 05/09/08
                       /* SELECT COUNT(1)
                                        INTO SN_MAX_CLI
                    FROM GE_CLIENTES A, GA_CATRIBUTCLIE B, GA_EMPRESA E
                    WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND A.COD_CICLO <>  CN_codciclo_prepago
                                  AND A.IND_ALTA <> 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                  AND A.COD_CLIENTE = E.COD_CLIENTE(+)
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);*/
                                                  --individuales
                                                  SELECT COUNT(1)
                                        INTO N_MAX_CLI1
                                        FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
                                        WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND A.COD_CICLO <>  CN_codciclo_prepago
                                  AND A.IND_ALTA <> 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                  AND A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);

                                                  --empresas
                                                  SELECT COUNT(1)
                                        INTO N_MAX_CLI2
                                        FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
                                        WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND A.COD_CICLO <>  CN_codciclo_prepago
                                  AND A.IND_ALTA <> 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                                                  --INI INC 197500 22-07-2013 MAV
                                                                  --AND A.COD_CLIENTE IN (SELECT c.cod_cliente FROM GA_EMPRESA C,GA_PLANTECPLSERV D
                                                                  --                                                         WHERE C.COD_CLIENTE   = A.COD_CLIENTE
                                                                  --                                                         AND   C.COD_PLANTARIF = D.COD_PLANTARIF
                                                                  --                                                         AND   D.COD_TECNOLOGIA = EO_Cliente.cod_tecnologia
                                                                  --                                          )
                                                                  AND A.COD_CLIENTE IN (SELECT c.cod_cliente FROM GA_EMPRESA C
                                                                                                                           WHERE C.COD_CLIENTE   = A.COD_CLIENTE
                                                                                                            )
                                                                  ----FIN INC 197500 22-07-2013 MAV
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);

                                            SN_MAX_CLI := N_MAX_CLI1 + N_MAX_CLI2;
                                                --(-)

                        END IF;


                        IF (EO_Cliente.COD_TIPLAN = '3') THEN

                                        lv_ssql := 'SELECT COUNT(1)';
                        lv_ssql := lv_ssql || ' FROM GE_CLIENTES a, GA_CATRIBUTCLIE B';
                        lv_ssql := lv_ssql || ' WHERE a.cod_cuenta = '||EO_Cliente.cod_cuenta;
                        lv_ssql := lv_ssql || ' AND IND_AGENTE = ''N''';
                        lv_ssql := lv_ssql || ' AND IND_SITUACION <> ''B''';
                        lv_ssql := lv_ssql || ' AND COD_CICLO <> '||CN_codciclo_prepago;
                        lv_ssql := lv_ssql || ' AND A.IND_ALTA <> ''M''';
                        lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
                        lv_ssql := lv_ssql || ' AND A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)';
                        lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';

                        SELECT COUNT(1)
                                        INTO SN_MAX_CLI
                    FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
                    WHERE  COD_CUENTA = EO_Cliente.cod_cuenta
                                  AND IND_AGENTE = 'N'
                                  AND IND_SITUACION <> 'B'
                                  AND COD_CICLO <>  CN_codciclo_prepago
                                  AND A.IND_ALTA <> 'M'
                                  AND A.COD_CLIENTE = B.COD_CLIENTE(+)
                                  AND A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)
                                  AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
                        END IF;

        EXCEPTION
          WHEN OTHERS THEN
              SN_cod_retorno := 156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'PV_OBTIENE_NUM_CLI_CUENTA_PR('||EO_Cliente.cod_cuenta||'); '||SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_OBTIENE_CLIENTE_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

  END PV_OBTIENE_NUM_CLI_CUENTA_PR;

--------------------------------------------------------------------------------------------
PROCEDURE PV_LISTA_CLIENTES_CUENTA_PR(
   EO_Cliente           IN               PV_CLIENTE_QT,
   SO_Lista_CliCuenta   OUT NOCOPY       refCursor,
   SN_cod_retorno       OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT NOCOPY       ge_errores_pg.evento
) IS
/*
<Documentación
 TipoDoc = "Procedure">>
  <Elemento
     Nombre = "PV_LISTA_CLIENTES_CUENTA_PR"
     Lenguaje="PL/SQL"
     Fecha="17-07-08"
     Versión="La del package"
     Diseñador="Elizabeth Vera"
     Programador="Elizabeth Vera
     Ambiente Desarrollo="BD">
     <Retorno>N/A</Retorno>>
     <Descripción>
                                         Lista clientes filtrando con cod_cliente, cod_cuenta, cod_tiplan
                 </Descripción>>
     <Parámetros>
        <Entrada>
                   <param nom="EO_Cliente" Tipo="estructura">estructura de cliente</param>>
        </Entrada>
        <Salida>
           <param nom="SO_Lista_CliCuenta" Tipo="refCursor"></param>>
           <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
           <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
           <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
        </Salida>
     </Parámetros>
  </Elemento>
</Documentación>
*/

   LV_des_error   ge_errores_pg.DesEvent;
   LV_sSql        ge_errores_pg.vQuery;
   nEsEmpresa     NUMBER(5) := 0;
BEGIN
   sn_cod_retorno  := 0;
   sv_mens_retorno := NULL;
   sn_num_evento       := 0;
   IF (EO_Cliente.COD_TIPLAN = '1') THEN
      lv_ssql := 'SELECT A.COD_CLIENTE, A.NOM_CLIENTE, A.COD_CICLO, A.COD_CUENTA,';
      lv_ssql := lv_ssql || ' A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT,';
      lv_ssql := lv_ssql || '  ''I'', NULL, NULL';
      lv_ssql := lv_ssql || ' FROM GE_CLIENTES A, GA_CATRIBUTCLIE B';
      lv_ssql := lv_ssql || ' WHERE A.COD_CLIENTE = ' || EO_Cliente.COD_CLIENTE;
      lv_ssql := lv_ssql || ' AND A.COD_CUENTA = ' || EO_Cliente.COD_CUENTA;
      lv_ssql := lv_ssql || ' AND A.IND_AGENTE = ''N''';
      lv_ssql := lv_ssql || ' AND A.IND_SITUACION <> ''B''';
      lv_ssql := lv_ssql || ' AND A.COD_CICLO = '||CN_codciclo_prepago;
      lv_ssql := lv_ssql || ' AND A.IND_ALTA = ''M''';
      lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
      lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';
      IF (EO_Cliente.COD_CLIENTE > 0) THEN
         OPEN SO_Lista_CliCuenta FOR
            SELECT A.COD_CLIENTE, A.NOM_CLIENTE, A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'I', NULL, NULL
            FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
            WHERE  A.COD_CLIENTE = EO_Cliente.COD_CLIENTE
            AND A.COD_CUENTA = EO_Cliente.COD_CUENTA
            AND A.IND_AGENTE = 'N'
            AND A.IND_SITUACION <> 'B'
            AND A.COD_CICLO = CN_codciclo_prepago
            -- AND A.IND_ALTA = 'M' -- COL 72181|18-12-2008|SAQL
            AND A.COD_CLIENTE = B.COD_CLIENTE(+)
            AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
      ELSE
         OPEN SO_Lista_CliCuenta FOR
            SELECT A.COD_CLIENTE, A.NOM_CLIENTE,    A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'I', NULL, NULL
            FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
            WHERE  A.COD_CUENTA = EO_Cliente.cod_cuenta
            AND IND_AGENTE = 'N'
            AND IND_SITUACION <> 'B'
            AND COD_CICLO = CN_codciclo_prepago
            -- AND A.IND_ALTA = 'M' -- COL 72181|18-12-2008|SAQL
            AND A.COD_CLIENTE = B.COD_CLIENTE(+)
            AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
      END IF;
   END IF;
   IF (EO_Cliente.COD_TIPLAN = '2') THEN
      lv_ssql := 'SELECT A.COD_CLIENTE, A.NOM_CLIENTE, A.COD_CICLO, A.COD_CUENTA,';
      lv_ssql := lv_ssql || ' A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT,';
      lv_ssql := lv_ssql || '  DECODE(COD_EMPRESA,NULL,''I'',''E''), COD_PLANTARIF, DECODE(COD_EMPRESA,NULL,0,COD_EMPRESA)';
      lv_ssql := lv_ssql || ' FROM GE_CLIENTES A, GA_CATRIBUTCLIE B, GA_EMPRESA E';
      lv_ssql := lv_ssql || ' WHERE A.COD_CLIENTE = ' || EO_Cliente.COD_CLIENTE;
      lv_ssql := lv_ssql || ' AND A.COD_CUENTA = ' || EO_Cliente.COD_CUENTA;
      lv_ssql := lv_ssql || ' AND A.IND_AGENTE = ''N''';
      lv_ssql := lv_ssql || ' AND A.IND_SITUACION <> ''B''';
      lv_ssql := lv_ssql || ' AND A.COD_CICLO <> '||CN_codciclo_prepago;
      lv_ssql := lv_ssql || ' AND A.IND_ALTA <> ''M''';
      lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
      lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = E.COD_CLIENTE(+)';
      lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';
      IF (EO_Cliente.COD_CLIENTE > 0) THEN
         --(+) ev 05/09/08
         SELECT COUNT(1) INTO nEsEmpresa FROM GA_EMPRESA
         WHERE COD_CLIENTE=EO_Cliente.COD_CLIENTE;
         IF (nEsEmpresa = 0)  THEN
            OPEN SO_Lista_CliCuenta FOR
               SELECT A.COD_CLIENTE, A.NOM_CLIENTE,  A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, DECODE(COD_EMPRESA,NULL,'I','E'), COD_PLANTARIF, DECODE(COD_EMPRESA,NULL,0,COD_EMPRESA)
               FROM GE_CLIENTES A, GA_CATRIBUTCLIE B, GA_EMPRESA E
               WHERE       A.COD_CLIENTE = EO_Cliente.COD_CLIENTE
               AND A.COD_CUENTA  = EO_Cliente.COD_CUENTA
               AND A.IND_AGENTE = 'N'
               AND A.IND_SITUACION <> 'B'
               AND A.COD_CICLO <>  CN_codciclo_prepago
               AND A.IND_ALTA <> 'M'
               AND A.COD_CLIENTE = B.COD_CLIENTE(+)
               AND A.COD_CLIENTE = E.COD_CLIENTE(+)
               AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
         ELSE
            OPEN SO_Lista_CliCuenta FOR
               SELECT A.COD_CLIENTE, A.NOM_CLIENTE,  A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'E', COD_PLANTARIF, DECODE(E.COD_EMPRESA,NULL,0,E.COD_EMPRESA)
               FROM GE_CLIENTES A, GA_CATRIBUTCLIE B, GA_EMPRESA E
               WHERE    A.COD_CLIENTE = EO_Cliente.COD_CLIENTE
               AND A.COD_CUENTA  = EO_Cliente.COD_CUENTA
               AND A.IND_AGENTE = 'N'
               AND A.IND_SITUACION <> 'B'
               AND A.COD_CICLO <>  CN_codciclo_prepago
               AND A.IND_ALTA <> 'M'
               AND A.COD_CLIENTE = B.COD_CLIENTE(+)
               AND A.COD_CLIENTE = E.COD_CLIENTE
               AND A.COD_CLIENTE IN (
                  --INI INC 197500 22-07-2013 MAV
                  --SELECT c.cod_cliente FROM GA_EMPRESA C,GA_PLANTECPLSERV D
                  --WHERE C.COD_CLIENTE   = A.COD_CLIENTE
                  --AND   C.COD_PLANTARIF = D.COD_PLANTARIF
                  --AND   D.COD_TECNOLOGIA = EO_Cliente.cod_tecnologia
                  SELECT c.cod_cliente FROM GA_EMPRESA C
                  WHERE C.COD_CLIENTE   = A.COD_CLIENTE
                  --FIN INC 197500 22-07-2013 MAV
               )
               AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
         END IF;
         --(-)
      ELSE
         OPEN SO_Lista_CliCuenta FOR
            --(+) ev 05/09/08
            /*
            SELECT A.COD_CLIENTE, A.NOM_CLIENTE,  A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, DECODE(COD_EMPRESA,NULL,'I','E'), COD_PLANTARIF, DECODE(COD_EMPRESA,NULL,0,COD_EMPRESA)
            FROM GE_CLIENTES A, GA_CATRIBUTCLIE B, GA_EMPRESA E
            WHERE       A.COD_CUENTA  = EO_Cliente.COD_CUENTA
            AND A.IND_AGENTE = 'N'
            AND A.IND_SITUACION <> 'B'
            AND A.COD_CICLO <>  CN_codciclo_prepago
            AND A.IND_ALTA <> 'M'
            AND A.COD_CLIENTE = B.COD_CLIENTE(+)
            AND A.COD_CLIENTE = E.COD_CLIENTE(+)
            AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate); */
            -- clientes individuales
            SELECT A.COD_CLIENTE, A.NOM_CLIENTE,  A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'I', '', 0
            FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
            WHERE       A.COD_CUENTA  = EO_Cliente.COD_CUENTA
            AND A.IND_AGENTE = 'N'
            AND A.IND_SITUACION <> 'B'
            AND A.COD_CICLO <>  CN_codciclo_prepago
            AND A.IND_ALTA <> 'M'
            AND A.COD_CLIENTE = B.COD_CLIENTE(+)
            AND A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)
            AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)
            UNION
            -- clientes empresa
            SELECT A.COD_CLIENTE, A.NOM_CLIENTE,  A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'E', COD_PLANTARIF, DECODE(E.COD_EMPRESA,NULL,0,E.COD_EMPRESA)
            FROM GE_CLIENTES A, GA_CATRIBUTCLIE B, GA_EMPRESA E
            WHERE       A.COD_CUENTA  = EO_Cliente.COD_CUENTA
            AND A.IND_AGENTE = 'N'
            AND A.IND_SITUACION <> 'B'
            AND A.COD_CICLO <>  CN_codciclo_prepago
            AND A.IND_ALTA <> 'M'
            AND A.COD_CLIENTE = B.COD_CLIENTE(+)
            AND A.COD_CLIENTE = E.COD_CLIENTE
            AND A.COD_CLIENTE IN (
               --INI INC 197500 22-07-2013 MAV
               --SELECT c.cod_cliente FROM GA_EMPRESA C,GA_PLANTECPLSERV D
               --WHERE C.COD_CLIENTE   = A.COD_CLIENTE
               --AND   C.COD_PLANTARIF = D.COD_PLANTARIF
               --AND   D.COD_TECNOLOGIA = EO_Cliente.cod_tecnologia
               SELECT c.cod_cliente FROM GA_EMPRESA C
               WHERE C.COD_CLIENTE   = A.COD_CLIENTE
               --FIN INC 197500 22-07-2013 MAV
            )
            AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
            --(-)
      END IF;
   END IF;
   IF (EO_Cliente.COD_TIPLAN = '3') THEN
      lv_ssql := 'SELECT A.COD_CLIENTE, A.NOM_CLIENTE, A.COD_CICLO, A.COD_CUENTA,';
      lv_ssql := lv_ssql || ' A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT,';
      lv_ssql := lv_ssql || '  ''I'', NULL, NULL';
      lv_ssql := lv_ssql || ' FROM GE_CLIENTES A, GA_CATRIBUTCLIE B';
      lv_ssql := lv_ssql || ' WHERE A.COD_CLIENTE = ' || EO_Cliente.COD_CLIENTE;
      lv_ssql := lv_ssql || ' AND A.COD_CUENTA = ' || EO_Cliente.COD_CUENTA;
      lv_ssql := lv_ssql || ' AND A.IND_AGENTE = ''N''';
      lv_ssql := lv_ssql || ' AND A.IND_SITUACION <> ''B''';
      lv_ssql := lv_ssql || ' AND A.COD_CICLO <> '||CN_codciclo_prepago;
      lv_ssql := lv_ssql || ' AND A.IND_ALTA <> ''M''';
      lv_ssql := lv_ssql || ' AND A.COD_CLIENTE = B.COD_CLIENTE(+)';
      lv_ssql := lv_ssql || ' A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)';
      lv_ssql := lv_ssql || ' AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate)';
      IF (EO_Cliente.COD_CLIENTE > 0) THEN
         OPEN SO_Lista_CliCuenta FOR
            SELECT A.COD_CLIENTE, A.NOM_CLIENTE,    A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'I', NULL, NULL
            FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
            WHERE        A.COD_CLIENTE = EO_Cliente.COD_CLIENTE
            AND A.COD_CUENTA  = EO_Cliente.COD_CUENTA
            AND A.IND_AGENTE = 'N'
            AND A.IND_SITUACION <> 'B'
            AND A.COD_CICLO <>  CN_codciclo_prepago
            AND A.IND_ALTA <> 'M'
            AND A.COD_CLIENTE = B.COD_CLIENTE(+)
            AND A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)
            AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
      ELSE
         OPEN SO_Lista_CliCuenta FOR
            SELECT A.COD_CLIENTE, A.NOM_CLIENTE,    A.COD_CICLO, A.COD_CUENTA, A.NOM_APECLIEN1, NOM_APECLIEN2, NUM_IDENT, COD_TIPIDENT, 'I', NULL, NULL
            FROM GE_CLIENTES A, GA_CATRIBUTCLIE B
            WHERE          A.COD_CUENTA = EO_Cliente.COD_CUENTA
            AND A.IND_AGENTE = 'N'
            AND A.IND_SITUACION <> 'B'
            AND A.COD_CICLO <>  CN_codciclo_prepago
            AND A.IND_ALTA <> 'M'
            AND A.COD_CLIENTE = B.COD_CLIENTE(+)
            AND A.COD_CLIENTE NOT IN (SELECT c.cod_cliente FROM GA_EMPRESA C WHERE C.COD_CLIENTE= A.COD_CLIENTE)
            AND sysdate BETWEEN B.fec_DESDE AND nvl(B.fec_hasta,sysdate);
      END IF;
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      NULL;
   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := CV_error_no_clasif;
      END IF;
      LV_des_error   := 'PV_LISTA_CLIENTES_CUENTA_PR('||EO_Cliente.cod_cuenta||'); '||SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_CUENTA_PG.PV_OBTIENE_CLIENTE_CUENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
END PV_LISTA_CLIENTES_CUENTA_PR;

--------------------------------------------------------------------------------------------

END PV_CUENTA_PG;
/
SHOW ERRORS
