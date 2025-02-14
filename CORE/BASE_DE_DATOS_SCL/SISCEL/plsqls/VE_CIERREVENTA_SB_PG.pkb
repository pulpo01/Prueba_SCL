CREATE OR REPLACE PACKAGE BODY VE_CIERREVENTA_SB_PG
IS

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE VE_CODIGO_PROCS_VENTA_PR (
      SO_MATRIZESTADOS             IN OUT NOCOPY        VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "VE_CODIGO_PROCS_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="02-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera El código del proceso de venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_MATRIZESTADOS Tipo="estructura">estructura de ve_matrizestado_td</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_MATRIZESTADOS Tipo="estructura">estructura de ve_matrizestado_td</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMBER">Numero de Evento</param>>
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
                --SO_MATRIZESTADOS(1).formulario:='FrmVenta2'; desde el java
                LV_sSql:= 'SELECT DISTINCT(cod_proceso)';
                LV_sSql:= LV_sSql || ' FROM ve_matrizestados_td';
                LV_sSql:= LV_sSql || ' WHERE cod_programa = '||SO_MATRIZESTADOS(1).cod_programa;
                LV_sSql:= LV_sSql || ' AND ind_ofiter = '||SO_MATRIZESTADOS(1).ind_ofiter;
                LV_sSql:= LV_sSql || ' AND formulario = '||SO_MATRIZESTADOS(1).formulario;

                SELECT DISTINCT(cod_proceso)
                INTO   SO_MATRIZESTADOS(1).cod_proceso
                FROM   ve_matrizestados_td
                WHERE  cod_programa = SO_MATRIZESTADOS(1).cod_programa--<Código de programa del sistema en ejecución>
                AND    ind_ofiter =SO_MATRIZESTADOS(1).ind_ofiter-- <tipo de venta, puede ser en terreno =  "T" o en oficina = "O">
                AND    formulario = SO_MATRIZESTADOS(1).formulario;


        EXCEPTION
                WHEN NO_DATA_FOUND THEN
              SN_cod_retorno := -1;--No existe codigo de proceso de venta con los parametros ingresados
                  SO_MATRIZESTADOS(1).cod_proceso:=0;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'NO_DATA_FOUND:VE_CODIGO_PROCS_VENTA_PR; - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,
                  'VE_CIERREVENTA_SB_PG.VE_CODIGO_PROCS_VENTA_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );

                WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de proceso de venta
                  SO_MATRIZESTADOS(1).cod_proceso:=0;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'OTHERS:VE_CODIGO_PROCS_VENTA_PR; - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,
                  'VE_CIERREVENTA_SB_PG.VE_CODIGO_PROCS_VENTA_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
        END VE_CODIGO_PROCS_VENTA_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_CODIGO_ESTFINAL_VENTA_PR (
      SO_MATRIZESTADOS             IN OUT NOCOPY        VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD,
          Fec_Venta                                IN                           VE_MATRIZESTADOS_TD.FEC_DESDE%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "VE_CODIGO_PROCS_VENTA_PR
              Lenguaje="PL/SQL"
              Fecha="02-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera El código del Estado Final de  La venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_MATRIZESTADOS Tipo="estructura">estructura de ve_matrizestado_td</param>>
                 </Entrada>
                 <Salida>
                    <param nom="SO_MATRIZESTADOS Tipo="estructura">estructura de ve_matrizestado_td</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMBER">Numero de Evento</param>>
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
                LV_sSql:= 'SELECT cod_estadodestino ';
                LV_sSql:= LV_sSql||' FROM ve_matrizestados_td ';
                LV_sSql:= LV_sSql||' WHERE cod_programa = SO_MATRIZESTADOS(1).cod_programa ';
                LV_sSql:= LV_sSql||' AND ind_ofiter = SO_MATRIZESTADOS(1).ind_ofiter ';
                LV_sSql:= LV_sSql||' AND formulario = SO_MATRIZESTADOS(1).formulario ';
                LV_sSql:= LV_sSql||' AND cod_proceso = SO_MATRIZESTADOS(1).cod_proceso ';
                LV_sSql:= LV_sSql||' AND Fec_Venta BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE)';

                SELECT cod_estadodestino
                INTO SO_MATRIZESTADOS(1).cod_estadodestino
                FROM ve_matrizestados_td
                WHERE cod_programa = SO_MATRIZESTADOS(1).cod_programa
                        AND ind_ofiter = SO_MATRIZESTADOS(1).ind_ofiter
                        AND formulario = SO_MATRIZESTADOS(1).formulario
                        AND cod_proceso = SO_MATRIZESTADOS(1).cod_proceso
                        AND Fec_Venta BETWEEN fec_desde AND NVL(fec_hasta, SYSDATE);



        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  SN_cod_retorno := -1;--No existe Codigo de estado final de la venta con los parametros ingresados
                  SO_MATRIZESTADOS(1).cod_estadodestino:=0;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'NO_DATA_FOUND:VE_CODIGO_ESTFINAL_VENTA_PR; - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,
                  'VE_CIERREVENTA_SB_PG.VE_CODIGO_ESTFINAL_VENTA_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );

                WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar codigo de estado final de la venta
                  SO_MATRIZESTADOS(1).cod_estadodestino:=0;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'OTHERS:VE_CODIGO_ESTFINAL_VENTA_PR; - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,
                  'VE_CIERREVENTA_SB_PG.VE_CODIGO_ESTFINAL_VENTA_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
        END VE_CODIGO_ESTFINAL_VENTA_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE VE_NUM_UNIDADES_VENTA_PR (
      SO_ABOCEL                IN OUT NOCOPY    VE_TIPOS_PG.TIP_GA_ABOCEL,
          NUM_UNIDADES                     OUT NOCOPY           GA_ABOCEL.NUM_VENTA%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento)

        IS
        /*
        <Documentación
          TipoDoc = "Procedure">>
           <Elemento
              Nombre = "VE_CODIGO_PROCS_VENTA_PR"
              Lenguaje="PL/SQL"
              Fecha="02-05-2007"
              Versión="La del package"
              Diseñador="Raúl Lozano"
              Programador="Raúl Lozano"
              Ambiente Desarrollo="BD">
              <Retorno>SO_cuenta</Retorno>>
              <Descripción>Recupera Numero de Unidades por Venta</Descripción>>
              <Parámetros>
                 <Entrada>
                    <param nom="SO_ABOCEL" Tipo="estructura">estructura de GA_ABOCEL</param>>
                 </Entrada>
                 <Salida>
                    <param nom="NUM_UNIDADES" Tipo="NUMBER">numero de unidades vendidas</param>>
                    <param nom="SN_cod_retorno" Tipo="NUMBER">Codigo de Retorno</param>>
                    <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de Retorno</param>>
                    <param nom="SN_num_evento" Tipo="NUMBER">Numero de Evento</param>>
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
                LV_sSql := 'SELECT COUNT(NUM_VENTA)';
                LV_sSql := LV_sSql ||' FROM GA_ABOCEL';
                LV_sSql := LV_sSql ||' WHERE NUM_VENTA=SO_ABOCEL(1).NUM_VENTA';

                SELECT COUNT(NUM_VENTA)
                INTO   NUM_UNIDADES
                FROM   GA_ABOCEL
                WHERE  NUM_VENTA = SO_ABOCEL(1).NUM_VENTA;
                
                IF NUM_UNIDADES=0 THEN 
                   LV_sSql := 'SELECT COUNT(NUM_VENTA)';
                   LV_sSql := LV_sSql ||' FROM GA_ABOAMIST';
                   LV_sSql := LV_sSql ||' WHERE NUM_VENTA=SO_ABOCEL(1).NUM_VENTA';

                   SELECT COUNT(NUM_VENTA)
                   INTO   NUM_UNIDADES
                   FROM   GA_ABOAMIST
                   WHERE  NUM_VENTA = SO_ABOCEL(1).NUM_VENTA;
                END IF; 
                
                
                
                

        EXCEPTION
                WHEN OTHERS THEN
              SN_cod_retorno := -1;--Problemas al recuperar Numero de Unidades
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
              END IF;
                  LV_des_error   := 'OTHERS:VE_NUM_UNIDADES_VENTA_PR; - ' || SQLERRM;
              SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER,
                  'VE_CIERREVENTA_SB_PG.VE_NUM_UNIDADES_VENTA_PR ', LV_sSQL, SN_cod_retorno, LV_des_error );
        END VE_NUM_UNIDADES_VENTA_PR;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END VE_CIERREVENTA_SB_PG;
/
SHOW ERRORS