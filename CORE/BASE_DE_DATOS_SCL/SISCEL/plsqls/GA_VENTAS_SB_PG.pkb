CREATE OR REPLACE PACKAGE BODY GA_VENTAS_SB_PG
IS

-- GA_VENTAS_SB_PG v1.1 COL-78448;05-03-2009; AVC

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_INSERT_VENTA_PR (
      SO_VENTAS                    IN OUT NOCOPY        VE_TIPOS_PG. TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "GA_INSERT_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="03-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera El código del proceso de venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;


                LV_sSql:=   LV_sSql||' INSERT INTO GA_VENTAS( NUM_VENTA, COD_PRODUCTO, COD_OFICINA, COD_TIPCOMIS, COD_VENDEDOR,';
                LV_sSql:=   LV_sSql||'  COD_VENDEDOR_AGENTE, NUM_UNIDADES, FEC_VENTA, COD_REGION, COD_PROVINCIA,';
                LV_sSql:=   LV_sSql||'  COD_CIUDAD, IND_ESTVENTA, NUM_TRANSACCION, IND_PASOCOB, NOM_USUAR_VTA,';
                LV_sSql:=   LV_sSql||'  IND_VENTA, COD_MONEDA, COD_CAUSAREC, IMP_VENTA, COD_TIPCONTRATO, NUM_CONTRATO,';
                LV_sSql:=   LV_sSql||'  IND_TIPVENTA, COD_CLIENTE, COD_MODVENTA, TIP_VALOR, COD_CUOTA, COD_TIPTARJETA,';
                LV_sSql:=   LV_sSql||'  NUM_TARJETA, COD_AUTTARJ, FEC_VENCITARJ, COD_BANCOTARJ, NUM_CTACORR, NUM_CHEQUE,';
                LV_sSql:=   LV_sSql||'  COD_BANCO, COD_SUCURSAL, FEC_CUMPLIMENTA, FEC_RECDOCUM, FEC_ACEPREC, NOM_USUAR_ACEREC,';
                LV_sSql:=   LV_sSql||'  NOM_USUAR_RECDOC, NOM_USUAR_CUMPL, IND_OFITER, IND_CHKDICOM, NUM_CONSULTA, COD_VENDEALER,';
                LV_sSql:=   LV_sSql||'  NUM_FOLDEALER, COD_DOCDEALER, IND_DOCCOMP, OBS_INCUMP, COD_CAUSAREP, FEC_RECPROV,';
                LV_sSql:=   LV_sSql||'  NOM_USUAR_RECPROV, NUM_DIAS, OBS_RECPROV, IMP_ABONO, IND_ABONO, FEC_RECEP_ADMVTAS,';
                LV_sSql:=   LV_sSql||'  USU_RECEP_ADMVTAS, OBS_GRALCUMPL, IND_CONT_TELEF, FECHA_CONT_TELEF, USUARIO_CONT_TELEF,';
                LV_sSql:=   LV_sSql||'  MTO_GARANTIA, TIP_FOLIACION, COD_TIPDOCUM, COD_PLAZA, COD_OPERADORA, NUM_PROCESO';
                LV_sSql:=   LV_sSql||')';

                LV_sSql:=   LV_sSql||' VALUES(';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_VENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_PRODUCTO||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_OFICINA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_TIPCOMIS||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_VENDEDOR||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_VENDEDOR_AGENTE||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_UNIDADES||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FEC_VENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_REGION||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_PROVINCIA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_CIUDAD||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_ESTVENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_TRANSACCION||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_PASOCOB||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NOM_USUAR_VTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_VENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_MONEDA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_CAUSAREC||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IMP_VENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_TIPCONTRATO||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_CONTRATO||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_TIPVENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_CLIENTE||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_MODVENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).TIP_VALOR||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_CUOTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_TIPTARJETA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_TARJETA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_AUTTARJ||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FEC_VENCITARJ||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_BANCOTARJ||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_CTACORR||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_CHEQUE||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_BANCO||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_SUCURSAL||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FEC_CUMPLIMENTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FEC_RECDOCUM||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FEC_ACEPREC||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NOM_USUAR_ACEREC||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NOM_USUAR_RECDOC||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NOM_USUAR_CUMPL||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_OFITER||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_CHKDICOM||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_CONSULTA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_VENDEALER||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_FOLDEALER||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_DOCDEALER||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_DOCCOMP||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).OBS_INCUMP||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_CAUSAREP||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FEC_RECPROV||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NOM_USUAR_RECPROV||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_DIAS||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).OBS_RECPROV||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IMP_ABONO||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_ABONO||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FEC_RECEP_ADMVTAS||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).USU_RECEP_ADMVTAS||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).OBS_GRALCUMPL||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).IND_CONT_TELEF||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).FECHA_CONT_TELEF||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).USUARIO_CONT_TELEF||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).MTO_GARANTIA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).TIP_FOLIACION||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_TIPDOCUM||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_PLAZA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).COD_OPERADORA||',';
                LV_sSql:=   LV_sSql|| SO_VENTAS(1).NUM_PROCESO||')';


                INSERT INTO GA_VENTAS( NUM_VENTA, COD_PRODUCTO, COD_OFICINA, COD_TIPCOMIS, COD_VENDEDOR,
                                                           COD_VENDEDOR_AGENTE, NUM_UNIDADES, FEC_VENTA, COD_REGION, COD_PROVINCIA,
                                                           COD_CIUDAD, IND_ESTVENTA, NUM_TRANSACCION, IND_PASOCOB, NOM_USUAR_VTA,
                                                           IND_VENTA, COD_MONEDA, COD_CAUSAREC, IMP_VENTA, COD_TIPCONTRATO, NUM_CONTRATO,
                                                           IND_TIPVENTA, COD_CLIENTE, COD_MODVENTA, TIP_VALOR, COD_CUOTA, COD_TIPTARJETA,
                                                           NUM_TARJETA, COD_AUTTARJ, FEC_VENCITARJ, COD_BANCOTARJ, NUM_CTACORR, NUM_CHEQUE,
                                                           COD_BANCO, COD_SUCURSAL, FEC_CUMPLIMENTA, FEC_RECDOCUM, FEC_ACEPREC, NOM_USUAR_ACEREC,
                                                           NOM_USUAR_RECDOC, NOM_USUAR_CUMPL, IND_OFITER, IND_CHKDICOM, NUM_CONSULTA, COD_VENDEALER,
                                                           NUM_FOLDEALER, COD_DOCDEALER, IND_DOCCOMP, OBS_INCUMP, COD_CAUSAREP, FEC_RECPROV,
                                                           NOM_USUAR_RECPROV, NUM_DIAS, OBS_RECPROV, IMP_ABONO, IND_ABONO, FEC_RECEP_ADMVTAS,
                                                           USU_RECEP_ADMVTAS, OBS_GRALCUMPL, IND_CONT_TELEF, FECHA_CONT_TELEF, USUARIO_CONT_TELEF,
                                                           MTO_GARANTIA, TIP_FOLIACION, COD_TIPDOCUM, COD_PLAZA, COD_OPERADORA, NUM_PROCESO
                )

                                        VALUES(SO_VENTAS(1).NUM_VENTA,SO_VENTAS(1).COD_PRODUCTO,SO_VENTAS(1).COD_OFICINA,SO_VENTAS(1).COD_TIPCOMIS,
                                               SO_VENTAS(1).COD_VENDEDOR,SO_VENTAS(1).COD_VENDEDOR_AGENTE,SO_VENTAS(1).NUM_UNIDADES,SO_VENTAS(1).FEC_VENTA,
                                                   SO_VENTAS(1).COD_REGION,SO_VENTAS(1).COD_PROVINCIA,SO_VENTAS(1).COD_CIUDAD,SO_VENTAS(1).IND_ESTVENTA,SO_VENTAS(1).NUM_TRANSACCION,
                                                   SO_VENTAS(1).IND_PASOCOB,SO_VENTAS(1).NOM_USUAR_VTA,SO_VENTAS(1).IND_VENTA,SO_VENTAS(1).COD_MONEDA,SO_VENTAS(1).COD_CAUSAREC,
                                                   SO_VENTAS(1).IMP_VENTA,SO_VENTAS(1).COD_TIPCONTRATO,SO_VENTAS(1).NUM_CONTRATO,SO_VENTAS(1).IND_TIPVENTA,SO_VENTAS(1).COD_CLIENTE,
                                                   SO_VENTAS(1).COD_MODVENTA,SO_VENTAS(1).TIP_VALOR,SO_VENTAS(1).COD_CUOTA,SO_VENTAS(1).COD_TIPTARJETA,SO_VENTAS(1).NUM_TARJETA,
                                                   SO_VENTAS(1).COD_AUTTARJ,SO_VENTAS(1).FEC_VENCITARJ,SO_VENTAS(1).COD_BANCOTARJ,SO_VENTAS(1).NUM_CTACORR,SO_VENTAS(1).NUM_CHEQUE,
                                                   SO_VENTAS(1).COD_BANCO,SO_VENTAS(1).COD_SUCURSAL,SO_VENTAS(1).FEC_CUMPLIMENTA,SO_VENTAS(1).FEC_RECDOCUM,SO_VENTAS(1).FEC_ACEPREC,
                                                   SO_VENTAS(1).NOM_USUAR_ACEREC,SO_VENTAS(1).NOM_USUAR_RECDOC,SO_VENTAS(1).NOM_USUAR_CUMPL,SO_VENTAS(1).IND_OFITER,SO_VENTAS(1).IND_CHKDICOM,
                                                   SO_VENTAS(1).NUM_CONSULTA,DECODE(SO_VENTAS(1).COD_VENDEALER,0,NULL,SO_VENTAS(1).COD_VENDEALER),SO_VENTAS(1).NUM_FOLDEALER,SO_VENTAS(1).COD_DOCDEALER,SO_VENTAS(1).IND_DOCCOMP,
                                                   SO_VENTAS(1).OBS_INCUMP,SO_VENTAS(1).COD_CAUSAREP,SO_VENTAS(1).FEC_RECPROV,SO_VENTAS(1).NOM_USUAR_RECPROV,SO_VENTAS(1).NUM_DIAS,
                                                   SO_VENTAS(1).OBS_RECPROV,SO_VENTAS(1).IMP_ABONO,SO_VENTAS(1).IND_ABONO,SO_VENTAS(1).FEC_RECEP_ADMVTAS,SO_VENTAS(1).USU_RECEP_ADMVTAS,
                                                   SO_VENTAS(1).OBS_GRALCUMPL,SO_VENTAS(1).IND_CONT_TELEF,SO_VENTAS(1).FECHA_CONT_TELEF,SO_VENTAS(1).USUARIO_CONT_TELEF,SO_VENTAS(1).MTO_GARANTIA,
                                                   SO_VENTAS(1).TIP_FOLIACION,SO_VENTAS(1).COD_TIPDOCUM,SO_VENTAS(1).COD_PLAZA,SO_VENTAS(1).COD_OPERADORA,SO_VENTAS(1).NUM_PROCESO);
                EXCEPTION

        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_INSERT_VENTA_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_INSERT_VENTA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_INSERT_VENTA_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_UPDATE_VENTA_ESCA_PR (
      SO_VENTAS                    IN OUT NOCOPY        VE_TIPOS_PG. TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "GA_INSERT_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="03-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera El código del proceso de venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                UPDATE ga_ventas SET
                         IND_ESTVENTA    = SO_VENTAS(1).IND_ESTVENTA,
                         NUM_TRANSACCION = SO_VENTAS(1).NUM_TRANSACCION,--<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                         TIP_VALOR       = SO_VENTAS(1).TIP_VALOR,--<Código de la forma de pago seleccionada por el vendedor en el presupuesto>
                         COD_TIPTARJETA  = NULL,
                         NUM_TARJETA     = NULL,
                         COD_AUTTARJ     = NULL,
                         FEC_VENCITARJ   = NULL,
                         COD_BANCOTARJ   = NULL,
                         IMP_VENTA       = SO_VENTAS(1).IMP_VENTA,--<Suma de los cargos, impuestos,descuentos, ¿menos el monto de la garantía?>
						 NUM_CONTRATO           = SO_VENTAS(1).NUM_CONTRATO,
						--INI INC-78448; COL; 05-03-2009; AVC
						 FEC_RECDOCUM    = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_RECDOCUM),
						 FEC_ACEPREC     = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_ACEPREC),
						 NOM_USUAR_ACEREC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_ACEREC),
						 NOM_USUAR_RECDOC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_RECDOC)
						 --FIN INC-78448; COL; 05-03-2009; AVC
                WHERE NUM_VENTA        = SO_VENTAS(1).NUM_VENTA;


        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPDATE_VENTA_ESCA_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPDATE_VENTA_ESCA_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_UPDATE_VENTA_ESCB_PR (
      SO_VENTAS                    IN OUT NOCOPY        VE_TIPOS_PG. TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "GA_INSERT_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="03-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera El código del proceso de venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                UPDATE ga_ventas SET
                         IND_ESTVENTA    = SO_VENTAS(1).IND_ESTVENTA,
                         NUM_TRANSACCION = SO_VENTAS(1).NUM_TRANSACCION,--<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                         TIP_VALOR       = SO_VENTAS(1).TIP_VALOR,--<Código de la forma de pago seleccionada por el vendedor en el presupuesto>
                         NUM_CHEQUE      = NULL,
                         NUM_CTACORR     = NULL,
                         COD_BANCO       = NULL,
                         COD_SUCURSAL    = NULL,
                         IMP_VENTA       = SO_VENTAS(1).IMP_VENTA,--<Suma de los cargos, impuestos,descuentos, ¿menos el monto de la garantía?>
                         NUM_CONTRATO    = SO_VENTAS(1).NUM_CONTRATO,
						 --INI INC-78448; COL; 05-03-2009; AVC
						 FEC_RECDOCUM    = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_RECDOCUM),
						 FEC_ACEPREC     = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_ACEPREC),
						 NOM_USUAR_ACEREC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_ACEREC),
						 NOM_USUAR_RECDOC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_RECDOC)
						 --FIN INC-78448; COL; 05-03-2009; AVC
                WHERE NUM_VENTA           = SO_VENTAS(1).NUM_VENTA;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPDATE_VENTA_ESCA_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPDATE_VENTA_ESCB_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_UPDATE_VENTA_ESCC_PR (
      SO_VENTAS                    IN OUT NOCOPY        VE_TIPOS_PG. TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "GA_INSERT_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="03-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera El código del proceso de venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                UPDATE ga_ventas SET
                        IND_ESTVENTA    = SO_VENTAS(1).IND_ESTVENTA,
                        NUM_TRANSACCION = SO_VENTAS(1).NUM_TRANSACCION,--<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                        TIP_VALOR       = SO_VENTAS(1).TIP_VALOR,--<Código de la forma de pago seleccionada por el vendedor en el presupuesto>
                        IMP_VENTA       = SO_VENTAS(1).IMP_VENTA,--<Suma de los cargos, impuestos,descuentos, ¿menos el monto de la garantía?>
                        NUM_CONTRATO    = SO_VENTAS(1).NUM_CONTRATO,
						--INI INC-78448; COL; 05-03-2009; AVC
						 FEC_RECDOCUM    = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_RECDOCUM),
						 FEC_ACEPREC     = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_ACEPREC),
						 NOM_USUAR_ACEREC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_ACEREC),
						 NOM_USUAR_RECDOC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_RECDOC)
						 --FIN INC-78448; COL; 05-03-2009; AVC
                        WHERE NUM_VENTA = SO_VENTAS(1).NUM_VENTA;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPDATE_VENTA_ESCA_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPDATE_VENTA_ESCC_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_UPDATE_VENTA_ESCD_PR (
      SO_VENTAS                    IN OUT NOCOPY        VE_TIPOS_PG. TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "GA_INSERT_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="03-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera El código del proceso de venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                UPDATE ga_ventas SET
                       IND_ESTVENTA     = SO_VENTAS(1).IND_ESTVENTA,
                       NUM_TRANSACCION  = SO_VENTAS(1).NUM_TRANSACCION,--<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                       TIP_VALOR        = NULL,--<Código de la forma de pago seleccionada por el vendedor en el presupuesto>
                       COD_TIPTARJETA   = NULL,
                       NUM_TARJETA      = NULL,
                       COD_AUTTARJ      = NULL,
                       FEC_VENCITARJ    = NULL,
                       COD_BANCOTARJ    = NULL,
                       NUM_CHEQUE       = NULL,
                       NUM_CTACORR      = NULL,
                       COD_BANCO        = NULL,
                       COD_SUCURSAL     = NULL,
                       IMP_VENTA        = SO_VENTAS(1).IMP_VENTA,--<Suma de los cargos, impuestos,descuentos, ¿menos el monto de la garantía?>
                       NUM_CONTRATO     = SO_VENTAS(1).NUM_CONTRATO,
				       --INI INC-78448; COL; 05-03-2009; AVC
					   FEC_RECDOCUM    = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_RECDOCUM),
					   FEC_ACEPREC     = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_ACEPREC),
					   NOM_USUAR_ACEREC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_ACEREC),
				 	   NOM_USUAR_RECDOC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_RECDOC)
					   --FIN INC-78448; COL; 05-03-2009; AVC
                 WHERE NUM_VENTA  = SO_VENTAS(1).NUM_VENTA;


        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPDATE_VENTA_ESCA_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPDATE_VENTA_ESCD_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GA_UPDATE_VENTA_PR (
      SO_VENTAS                    IN OUT NOCOPY        VE_TIPOS_PG. TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "GA_INSERT_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="15-05-2007"
              Versión="La del package"
              Diseñador="Héctor Hermosilla"
              Programador="Héctor Hermosilla"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Actualiza tabla GA_Venta con el valor del importe</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
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
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;

                IF SO_VENTAS(1).IMP_ABONO IS NOT NULL AND SO_VENTAS(1).IND_ABONO = 1 THEN
                        LV_sSql:= 'UPDATE ga_ventas a'
                                          || ' SET a.imp_venta = ' || SO_VENTAS(1).IMP_VENTA || ','
                                          || ' a.imp_abono = ' || SO_VENTAS(1).IMP_ABONO || ','
                                          || ' a.ind_abono = ' || SO_VENTAS(1).IND_ABONO
                                          || ' WHERE a.num_venta ' || SO_VENTAS(1).NUM_VENTA;

                        UPDATE ga_ventas a
                        SET a.imp_venta = SO_VENTAS(1).IMP_VENTA,--<Suma de los cargos, impuestos,descuentos, ¿menos el monto de la garantía?>
                               a.imp_abono = SO_VENTAS(1).IMP_ABONO,
                               a.ind_abono = SO_VENTAS(1).IND_ABONO,
						       --INI INC-78448; COL; 05-03-2009; AVC
						 	   FEC_RECDOCUM    = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_RECDOCUM),
						       FEC_ACEPREC     = decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', fec_venta, FEC_ACEPREC),
						       NOM_USUAR_ACEREC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_ACEREC),
						       NOM_USUAR_RECDOC= decode(SO_VENTAS(1).IND_ESTVENTA, 'AC', NOM_USUAR_VTA, NOM_USUAR_RECDOC)
						       --FIN INC-78448; COL; 05-03-2009; AVC
                        WHERE a.num_venta = SO_VENTAS(1).NUM_VENTA;
                ELSE
                        LV_sSql:= 'UPDATE ga_ventas a'
                                          || ' SET a.imp_venta = ' || SO_VENTAS(1).IMP_VENTA || ','
                                          || ' WHERE a.num_venta ' || SO_VENTAS(1).NUM_VENTA;

                        UPDATE ga_ventas a
                        SET a.imp_venta = SO_VENTAS(1).IMP_VENTA  --<Suma de los cargos, impuestos,descuentos, ¿menos el monto de la garantía?>
                        WHERE a.num_venta       = SO_VENTAS(1).NUM_VENTA;
                END IF;

        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPDATE_VENTA  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPDATE_VENTA_PR;
      PROCEDURE GA_UPD_SITVENTA_PR (
      EN_NUM_VENTA             IN  GA_VENTAS.NUM_VENTA%TYPE,
      EV_COD_SITUACION         IN  GA_VENTAS.IND_ESTVENTA%TYPE,
      EN_IMP_VENTA             IN  GA_VENTAS.IMP_VENTA%TYPE,      
      EV_NOM_USUARIO           IN  GA_VENTAS.NOM_USUAR_VTA%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
      
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        BEGIN
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
            
            UPDATE GA_VENTAS 
            SET IND_ESTVENTA=EV_COD_SITUACION
            ,IMP_VENTA=EN_IMP_VENTA
            WHERE NUM_VENTA=EN_NUM_VENTA;
            
      
        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPD_SITVENTA_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPD_SITVENTA_PR;
        
        
        
        PROCEDURE GA_UPD_ABONO_PR (
      EN_NUM_VENTA             IN  GA_VENTAS.NUM_VENTA%TYPE,
      EN_IMP_ABONO             IN  GA_VENTAS.IMP_ABONO%TYPE,        
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
      
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        BEGIN
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
            
            UPDATE GA_VENTAS 
            SET IMP_ABONO=EN_IMP_ABONO
            ,IND_ABONO=1
            WHERE NUM_VENTA=EN_NUM_VENTA;
        
        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPD_ABONO_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPD_ABONO_PR;
PROCEDURE GA_UPD_MODVENTA_PR (
      EN_NUM_VENTA             IN  GA_VENTAS.NUM_VENTA%TYPE,
      EN_COD_MODVENTA          IN  GA_VENTAS.COD_MODVENTA%TYPE, 
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
      
        LV_des_error       ge_errores_pg.DesEvent;
        LV_sSql                    ge_errores_pg.vQuery;
        BEGIN
            sn_cod_retorno      := 0;
            sv_mens_retorno := NULL;
            sn_num_evento       := 0;
            
            UPDATE GA_VENTAS 
            SET COD_MODVENTA=EN_COD_MODVENTA
            WHERE NUM_VENTA=EN_NUM_VENTA;
            
            
            UPDATE GA_ABOCEL
            SET COD_MODVENTA=EN_COD_MODVENTA
            WHERE NUM_VENTA=EN_NUM_VENTA;
            
            UPDATE GA_ABOAMIST 
            SET COD_MODVENTA=EN_COD_MODVENTA
            WHERE NUM_VENTA=EN_NUM_VENTA;
        
        EXCEPTION
        WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := ' GA_UPD_MODVENTA_PR  ('||'); - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
        END GA_UPD_MODVENTA_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


END GA_VENTAS_SB_PG; 
/
SHOW ERRORS
