CREATE OR REPLACE PACKAGE BODY PV_OOSS_PROMOCIONES_PG AS

-------------------------------------------------------------------------------
PROCEDURE PV_DATOS_ABONADO_PR(EN_NUM_ABONADO           IN              ga_aboamist.num_abonado%TYPE,
                              SO_DATOS_ABONADO         IN  OUT NOCOPY  refCursor/*,
                              SN_COD_RETORNO           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                              SV_MENS_RETORNO          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                              SN_NUM_EVENTO            OUT NOCOPY      ge_errores_pg.evento*/)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_LISTA_AUTORIZA_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_COD_CLIENTE" Tipo="NUMERICO"><param>>
             <param nom="SO_Lista_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
 sn_cod_retorno  ge_errores_td.cod_msgerror%TYPE;
 sv_mens_retorno ge_errores_td.cod_msgerror%TYPE;
 sn_num_evento   ge_errores_pg.evento; 
 --ln_num_abonado  ga_aboamist.num_abonado%TYPE;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
        
   --     ln_num_abonado := TO_NUMBER(en_num_abonado);

        LV_sSql:=' OPEN    SO_DATOS_ABONADO FOR';
        LV_sSql:=LV_sSql || ' SELECT  abon.cod_cliente';
        LV_sSql:=LV_sSql || '        ,abon.num_abonado';
        LV_sSql:=LV_sSql || '        ,clie.nom_cliente ||'' ''|| clie.nom_apeclien1 ||'' ''|| clie.nom_apeclien2';
        LV_sSql:=LV_sSql || '        ,abon.num_celular';        
        LV_sSql:=LV_sSql || '        ,abon.cod_situacion';
        LV_sSql:=LV_sSql || '        ,abon.tip_terminal';        
        LV_sSql:=LV_sSql || '        ,abon.cod_central';
        LV_sSql:=LV_sSql || '        ,abon.cod_plantarif';
        LV_sSql:=LV_sSql || '        ,abon.cod_tecnologia';
        LV_sSql:=LV_sSql || ' FROM    ga_aboamist abon, ge_clientes clie';
        LV_sSql:=LV_sSql || ' WHERE   abon.num_abonado  ='|| en_num_abonado;
        LV_sSql:=LV_sSql || ' AND     clie.cod_cliente  = abon.cod_cliente';        
         

        OPEN    SO_DATOS_ABONADO FOR
        SELECT  abon.cod_cliente
               ,abon.num_abonado
               ,abon.num_celular
               ,clie.nom_cliente ||' '|| clie.nom_apeclien1 ||' '|| clie.nom_apeclien2
               ,abon.cod_situacion
               ,abon.tip_terminal
               ,abon.cod_central
               ,abon.cod_plantarif
               ,abon.cod_tecnologia
        FROM    ga_aboamist abon, ge_clientes clie
        WHERE   abon.num_abonado  = en_num_abonado
        AND     clie.cod_cliente  = abon.cod_cliente;        


        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_DATOS_ABONADO_PR(' || 'SO_Lista_celulares'  || ')' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_OOSS_PROMOCIONES_PG.PV_DATOS_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_DATOS_ABONADO_PR;


PROCEDURE PV_REGISTRA_MOVIMIENTO_PR(EN_NUM_MOVIMIENTO       IN  ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                    EN_NUM_ABONADO          IN  ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                                    EN_COD_ESTADO           IN  ICC_MOVIMIENTO.COD_ESTADO%TYPE,
                                    EV_COD_ACTABO           IN  ICC_MOVIMIENTO.COD_ACTABO%TYPE,
                                    EV_COD_MODULO           IN  ICC_MOVIMIENTO.COD_MODULO%TYPE,
                                    EN_NUM_INTENTOS         IN  ICC_MOVIMIENTO.NUM_INTENTOS%TYPE,
                                    EV_DES_RESPUESTA        IN  ICC_MOVIMIENTO.DES_RESPUESTA%TYPE,
                                    EN_COD_ACTUACION        IN  ICC_MOVIMIENTO.COD_ACTUACION%TYPE,
                                    EV_NOM_USUARORA         IN  ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                                    EV_TIP_TERMINAL         IN  ICC_MOVIMIENTO.TIP_TERMINAL%TYPE,
                                    EN_COD_CENTRAL          IN  ICC_MOVIMIENTO.COD_CENTRAL%TYPE,
                                    EN_IND_BLOQUEO          IN  ICC_MOVIMIENTO.IND_BLOQUEO%TYPE,
                                    EN_NUM_CELULAR          IN  ICC_MOVIMIENTO.NUM_CELULAR%TYPE,
                                    EV_NUM_SERIE            IN  ICC_MOVIMIENTO.NUM_SERIE%TYPE,
                                    EV_COD_SERVICIOS        IN  ICC_MOVIMIENTO.COD_SERVICIOS%TYPE,
                                    EV_TIP_TECNOLOGIA       IN  ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                    SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento   OUT NOCOPY      ge_errores_pg.evento)
                                    
                                    
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_REGISTRA_MOVIMIENTO_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="" Tipo=""><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
        
     INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO
                                ,NUM_ABONADO   
                                ,COD_ESTADO    
                                ,COD_ACTABO    
                                ,COD_MODULO    
                                ,NUM_INTENTOS  
                                ,DES_RESPUESTA 
                                ,COD_ACTUACION 
                                ,NOM_USUARORA
                                ,FEC_INGRESO  
                                ,TIP_TERMINAL  
                                ,COD_CENTRAL   
                                ,IND_BLOQUEO   
                                ,NUM_CELULAR   
                                ,NUM_SERIE     
                                ,COD_SERVICIOS
                                ,TIP_TECNOLOGIA)
          	 VALUES             (EN_NUM_MOVIMIENTO
                                ,EN_NUM_ABONADO   
                                ,EN_COD_ESTADO    
                                ,EV_COD_ACTABO    
                                ,EV_COD_MODULO    
                                ,EN_NUM_INTENTOS  
                                ,EV_DES_RESPUESTA 
                                ,EN_COD_ACTUACION 
                                ,EV_NOM_USUARORA  
                                ,SYSDATE
                                ,EV_TIP_TERMINAL  
                                ,EN_COD_CENTRAL   
                                ,EN_IND_BLOQUEO   
                                ,EN_NUM_CELULAR   
                                ,EV_NUM_SERIE     
                                ,EV_COD_SERVICIOS
                                ,EV_TIP_TECNOLOGIA);


        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_REGISTRA_MOVIMIENTO_PR()' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_OOSS_PROMOCIONES_PG.PV_REGISTRA_MOVIMIENTO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REGISTRA_MOVIMIENTO_PR;

PROCEDURE PV_REGISTRA_PROMO_ABON_PR(EN_IDE_PROMOCION  IN PV_ABON_BENEF_PREPAGOS_TD.IDE_PROMOCION%TYPE,
                                    EN_NUM_ABONADO    IN PV_ABON_BENEF_PREPAGOS_TD.NUM_ABONADO%TYPE,  
                                    EV_NUM_FFODUO_01  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_01%TYPE,
                                    EV_NUM_FFODUO_02  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_02%TYPE,
                                    EV_NUM_FFODUO_03  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_03%TYPE,
                                    EV_NUM_FFODUO_04  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_04%TYPE,
                                    EV_NUM_FFODUO_05  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_05%TYPE,
                                    EV_NUM_FFODUO_06  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_06%TYPE,
                                    EV_NUM_FFODUO_07  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_07%TYPE,
                                    EV_NUM_FFODUO_08  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_08%TYPE,
                                    EV_NUM_FFODUO_09  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_09%TYPE,
                                    EV_NUM_FFODUO_10  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_10%TYPE,
                                    SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento   OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_REGISTRA_PROMO_ABON_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="" Tipo=""><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
         
         
        LV_sSql:=' INSERT INTO PV_ABON_BENEF_PREPAGOS_TD   (IDE_PROMOCION';
        LV_sSql:= LV_sSql ||',NUM_ABONADO';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_01';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_02';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_03';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_04';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_05';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_06';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_07';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_08';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_09';
        LV_sSql:= LV_sSql ||',NUM_FFODUO_10)';
        LV_sSql:= LV_sSql ||' VALUES (EN_IDE_PROMOCION';
        LV_sSql:= LV_sSql ||',' || EN_NUM_ABONADO;  
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_01;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_02;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_03;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_04;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_05;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_06;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_07;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_08;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_09;
        LV_sSql:= LV_sSql ||',' || EV_NUM_FFODUO_10 ||')';         
        
    INSERT INTO PV_ABON_BENEF_PREPAGOS_TD   (IDE_PROMOCION
                                            ,NUM_ABONADO
                                            ,NUM_FFODUO_01
                                            ,NUM_FFODUO_02
                                            ,NUM_FFODUO_03
                                            ,NUM_FFODUO_04
                                            ,NUM_FFODUO_05
                                            ,NUM_FFODUO_06
                                            ,NUM_FFODUO_07
                                            ,NUM_FFODUO_08
                                            ,NUM_FFODUO_09
                                            ,NUM_FFODUO_10)
                                     VALUES (EN_IDE_PROMOCION
                                            ,EN_NUM_ABONADO  
                                            ,EV_NUM_FFODUO_01
                                            ,EV_NUM_FFODUO_02
                                            ,EV_NUM_FFODUO_03
                                            ,EV_NUM_FFODUO_04
                                            ,EV_NUM_FFODUO_05
                                            ,EV_NUM_FFODUO_06
                                            ,EV_NUM_FFODUO_07
                                            ,EV_NUM_FFODUO_08
                                            ,EV_NUM_FFODUO_09
                                            ,EV_NUM_FFODUO_10);

        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_REGISTRA_PROMO_ABON_PR()' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_OOSS_PROMOCIONES_PG.PV_REGISTRA_PROMO_ABON_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REGISTRA_PROMO_ABON_PR;

PROCEDURE PV_DATOS_PROMO_ABONADO_PR(EN_IDE_PROMOCION         IN              pv_abon_benef_prepagos_td.ide_promocion%TYPE,
                                    EN_NUM_ABONADO           IN              pv_abon_benef_prepagos_td.num_abonado%TYPE,
                                    SO_DATOS_ABONADO         IN  OUT NOCOPY  refCursor)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_DATOS_PROMO_ABONADO_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_COD_CLIENTE" Tipo="NUMERICO"><param>>
             <param nom="SO_Lista_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
 sn_cod_retorno  ge_errores_td.cod_msgerror%TYPE;
 sv_mens_retorno ge_errores_td.cod_msgerror%TYPE;
 sn_num_evento   ge_errores_pg.evento; 
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
        

        LV_sSql:=' OPEN    SO_DATOS_ABONADO FOR';
        LV_sSql:=LV_sSql || ' SELECT   abon.ide_promocion';
        LV_sSql:=LV_sSql || ' ,abon.num_abonado';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_01';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_02';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_03';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_04';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_05';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_06';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_07';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_08';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_09';
        LV_sSql:=LV_sSql || ' ,abon.num_ffoduo_10';
        LV_sSql:=LV_sSql || ' FROM    pv_abon_benef_prepagos_td abon';
        LV_sSql:=LV_sSql || ' WHERE   abon.ide_promocion = ''' ||en_ide_promocion ||'''';
        LV_sSql:=LV_sSql || ' AND     abon.num_abonado   = ' ||  en_num_abonado;          

        OPEN    SO_DATOS_ABONADO FOR
        SELECT   abon.ide_promocion
                ,abon.num_abonado
                ,nvl(abon.num_ffoduo_01,-1)
                ,nvl(abon.num_ffoduo_02,-1)
                ,nvl(abon.num_ffoduo_03,-1)
                ,nvl(abon.num_ffoduo_04,-1)
                ,nvl(abon.num_ffoduo_05,-1)
                ,nvl(abon.num_ffoduo_06,-1)
                ,nvl(abon.num_ffoduo_07,-1)
                ,nvl(abon.num_ffoduo_08,-1)
                ,nvl(abon.num_ffoduo_09,-1)
                ,nvl(abon.num_ffoduo_10,-1)
        FROM    pv_abon_benef_prepagos_td abon
        WHERE   abon.ide_promocion = en_ide_promocion
        AND     abon.num_abonado   = en_num_abonado;        


        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_DATOS_PROMO_ABONADO_PR(' || 'SO_Lista_celulares'  || ')' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_OOSS_PROMOCIONES_PG.PV_DATOS_PROMO_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_DATOS_PROMO_ABONADO_PR;


PROCEDURE PV_ACTUALIZA_PROMO_ABON_PR(EN_IDE_PROMOCION  IN PV_ABON_BENEF_PREPAGOS_TD.IDE_PROMOCION%TYPE,
                                     EN_NUM_ABONADO    IN PV_ABON_BENEF_PREPAGOS_TD.NUM_ABONADO%TYPE,  
                                     EV_NUM_FFODUO_01  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_01%TYPE,
                                     EV_NUM_FFODUO_02  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_02%TYPE,
                                     EV_NUM_FFODUO_03  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_03%TYPE,
                                     EV_NUM_FFODUO_04  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_04%TYPE,
                                     EV_NUM_FFODUO_05  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_05%TYPE,
                                     EV_NUM_FFODUO_06  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_06%TYPE,
                                     EV_NUM_FFODUO_07  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_07%TYPE,
                                     EV_NUM_FFODUO_08  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_08%TYPE,
                                     EV_NUM_FFODUO_09  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_09%TYPE,
                                     EV_NUM_FFODUO_10  IN PV_ABON_BENEF_PREPAGOS_TD.NUM_FFODUO_10%TYPE,
                                     EN_COD_ESTADO     IN PV_ABON_BENEF_PREPAGOS_TD.COD_ESTADO%TYPE,
                                     SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento   OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ACTUALIZA_PROMO_ABON_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="" Tipo=""><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
        
        UPDATE PV_ABON_BENEF_PREPAGOS_TD SET
             NUM_FFODUO_01 = EV_NUM_FFODUO_01
            ,NUM_FFODUO_02 = EV_NUM_FFODUO_02
            ,NUM_FFODUO_03 = EV_NUM_FFODUO_03
            ,NUM_FFODUO_04 = EV_NUM_FFODUO_04
            ,NUM_FFODUO_05 = EV_NUM_FFODUO_05
            ,NUM_FFODUO_06 = EV_NUM_FFODUO_06
            ,NUM_FFODUO_07 = EV_NUM_FFODUO_07
            ,NUM_FFODUO_08 = EV_NUM_FFODUO_08
            ,NUM_FFODUO_09 = EV_NUM_FFODUO_09
            ,NUM_FFODUO_10 = EV_NUM_FFODUO_10
            ,COD_ESTADO    = EN_COD_ESTADO
        WHERE IDE_PROMOCION  = EN_IDE_PROMOCION
        AND   NUM_ABONADO    = EN_NUM_ABONADO;

        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_ACTUALIZA_PROMO_ABON_PR()' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_OOSS_PROMOCIONES_PG.PV_ACTUALIZA_PROMO_ABON_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ACTUALIZA_PROMO_ABON_PR;


PROCEDURE PV_ELIMINA_PROMO_ABONADO_PR(EN_IDE_PROMOCION        IN      pv_abon_benef_prepagos_td.ide_promocion%TYPE,
                                      EN_NUM_ABONADO          IN      pv_abon_benef_prepagos_td.num_abonado%TYPE,
                                      EN_COD_ESTADO           IN      pv_abon_benef_prepagos_td.cod_estado%TYPE,
                                      SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento   OUT NOCOPY      ge_errores_pg.evento)
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_ELIMINA_PROMO_ABONADO_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="EN_COD_CLIENTE" Tipo="NUMERICO"><param>>
             <param nom="SO_Lista_Abonado" Tipo="estructura"><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
        

        LV_sSql:='DELETE FROM pv_abon_benef_prepagos_td abon';
  
        
        IF en_cod_estado != 0 then
            DELETE FROM pv_abon_benef_prepagos_td abon
            WHERE   abon.ide_promocion = en_ide_promocion
            AND     abon.num_abonado   = en_num_abonado
            AND     abon.cod_estado    = en_cod_estado;
        ELSE
            DELETE FROM pv_abon_benef_prepagos_td abon
            WHERE   abon.num_abonado   = en_num_abonado
            AND     abon.cod_estado    = en_cod_estado;
        END IF;



        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_ELIMINA_PROMO_ABONADO_PR(' || 'SO_Lista_celulares'  || ')' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_OOSS_PROMOCIONES_PG.PV_ELIMINA_PROMO_ABONADO_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_ELIMINA_PROMO_ABONADO_PR;

PROCEDURE PV_REG_PROMO_MODIFICADA_PR(EN_IDE_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.IDE_PROMOCION%TYPE, 
                                     EV_NOM_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.NOM_PROMOCION%TYPE, 
                                     EV_DES_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.DES_PROMOCION%TYPE, 
                                     ED_FEC_INICIO	    IN PV_BENEFICIOS_PREPAGOS_TD.FEC_INICIO%TYPE,    
                                     ED_FEC_FIN	        IN PV_BENEFICIOS_PREPAGOS_TD.FEC_FIN%TYPE,       
                                     EN_CST_SUSCRIPCION IN PV_BENEFICIOS_PREPAGOS_TD.CST_SUSCRIPCION%TYPE,
                                     EN_CST_MENSUAL	    IN PV_BENEFICIOS_PREPAGOS_TD.CST_MENSUAL%TYPE,   
                                     EN_TEMPORALIDAD    IN PV_BENEFICIOS_PREPAGOS_TD.TEMPORALIDAD%TYPE,  
                                     EV_TIP_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.TIP_PROMOCION%TYPE, 
                                     EV_COD_TECNOLOGIA  IN PV_BENEFICIOS_PREPAGOS_TD.COD_TECNOLOGIA%TYPE,
                                     EV_SMS_BODY	    IN PV_BENEFICIOS_PREPAGOS_TD.SMS_BODY%TYPE,      
                                     EV_PLN_SOPORTA	    IN PV_BENEFICIOS_PREPAGOS_TD.PLN_SOPORTA%TYPE,   
                                     EV_TIP_MOVIMIEN    IN PV_BENEFICIOS_PREPAGOS_TD.TIP_MOVIMIEN%TYPE,  
                                     EV_LST_SUSCRIP	    IN PV_BENEFICIOS_PREPAGOS_TD.LST_SUSCRIP%TYPE,   
                                     EV_TIP_SUSCRIP	    IN PV_BENEFICIOS_PREPAGOS_TD.TIP_SUSCRIP%TYPE,   
                                     EV_FLG_RECORD	    IN PV_BENEFICIOS_PREPAGOS_TD.FLG_RECORD%TYPE,    
                                     EV_FRC_RECORD	    IN PV_BENEFICIOS_PREPAGOS_TD.FRC_RECORD%TYPE,    
                                     EV_FLG_CONFIRM	    IN PV_BENEFICIOS_PREPAGOS_TD.FLG_CONFIRM%TYPE,   
                                     EV_FLG_NORMALIZA   IN PV_BENEFICIOS_PREPAGOS_TD.FLG_NORMALIZA%TYPE, 
                                     EV_CNT_NUMEROS	    IN PV_BENEFICIOS_PREPAGOS_TD.CNT_NUMEROS%TYPE,   
                                     EV_FLG_ALTA	    IN PV_BENEFICIOS_PREPAGOS_TD.FLG_ALTA%TYPE, 
                                     SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento   OUT NOCOPY      ge_errores_pg.evento)
                                    
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_REG_PROMO_MODIFICADA_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="" Tipo=""><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
        


    INSERT INTO PV_BENEFICIOS_PREPAGOS_TD ( IDE_PROMOCION  
                                            ,NOM_PROMOCION  
                                            ,DES_PROMOCION  
                                            ,FEC_INICIO  
                                            ,FEC_FIN          
                                            ,CST_SUSCRIPCION
                                            ,CST_MENSUAL  
                                            ,TEMPORALIDAD  
                                            ,TIP_PROMOCION  
                                            ,COD_TECNOLOGIA    
                                            ,SMS_BODY  
                                            ,PLN_SOPORTA  
                                            ,TIP_MOVIMIEN  
                                            ,LST_SUSCRIP  
                                            ,TIP_SUSCRIP  
                                            ,FLG_RECORD  
                                            ,FRC_RECORD  
                                            ,FLG_CONFIRM  
                                            ,FLG_NORMALIZA  
                                            ,CNT_NUMEROS  
                                            ,FLG_ALTA)  
    VALUES (EN_IDE_PROMOCION                                          
           ,EV_NOM_PROMOCION                                   
           ,EV_DES_PROMOCION  
           ,ED_FEC_INICIO        
           ,ED_FEC_FIN             
           ,EN_CST_SUSCRIPCION           
           ,EN_CST_MENSUAL        
           ,EN_TEMPORALIDAD         
           ,EV_TIP_PROMOCION  
           ,EV_COD_TECNOLOGIA           
           ,EV_SMS_BODY        
           ,EV_PLN_SOPORTA        
           ,EV_TIP_MOVIMIEN         
           ,EV_LST_SUSCRIP        
           ,EV_TIP_SUSCRIP        
           ,EV_FLG_RECORD        
           ,EV_FRC_RECORD        
           ,EV_FLG_CONFIRM        
           ,EV_FLG_NORMALIZA  
           ,EV_CNT_NUMEROS        
           ,EV_FLG_ALTA);
     
        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_REG_PROMO_MODIFICADA_PR()' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AUTORIZA_RENOVA_PG.PV_REG_PROMO_MODIFICADA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_REG_PROMO_MODIFICADA_PR;


PROCEDURE PV_DEL_PROMO_MODIFICADA_PR(EN_IDE_PROMOCION   IN PV_BENEFICIOS_PREPAGOS_TD.IDE_PROMOCION%TYPE, 
                                     SN_cod_retorno  OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento   OUT NOCOPY      ge_errores_pg.evento)
                                    
IS
 /*
 <Documentación
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = "PV_DEL_PROMO_MODIFICADA_PR"
       Lenguaje="PL/SQL"
       Fecha="07-05-2008"
       Versión="La del package"
       Diseñador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripción></Descripción>>
       <Parámetros>
          <Entrada>
             <param nom="" Tipo=""><param>>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno" Tipo="NUMERICO">Codigo de Retorno</param>>
             <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>>
             <param nom="SN_num_evento" Tipo="NUMERICO">Numero de Evento</param>>
          </Salida>
       </Parámetros>
    </Elemento>
 </Documentación>
 */

 LV_des_error    ge_errores_pg.DesEvent;
 LV_sSql         ge_errores_pg.vQuery;
BEGIN
         sn_cod_retorno  := 0;
         sv_mens_retorno := NULL;
         sn_num_evento  := 0;
        



    DELETE FROM PV_BENEFICIOS_PREPAGOS_TD
    WHERE IDE_PROMOCION = EN_IDE_PROMOCION;
     
        EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := 156;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := CV_error_no_clasif;
             END IF;
             LV_des_error   := 'PV_OOSS_PROMOCIONES_PG.PV_DEL_PROMO_MODIFICADA_PR()' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo, SV_mens_retorno, CV_version, USER, 'PV_AUTORIZA_RENOVA_PG.PV_DEL_PROMO_MODIFICADA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_DEL_PROMO_MODIFICADA_PR;


END PV_OOSS_PROMOCIONES_PG;
/
SHOW ERRORS