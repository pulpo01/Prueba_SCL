CREATE OR REPLACE PACKAGE BODY PV_PAGOANTICIPADO_PG
AS
---------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENERSS_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                         EN_num_abonado    IN ga_abocel.num_abonado%type,
                         EV_cod_actabo     IN ga_actabo.cod_actabo%type,
						 EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERSS_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Diseñador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> número del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> número del abonado</param>
			<param nom="EV_cod_acatbo"     Tipo="VARCHAR2> codigo actuacion</param>
			<param nom="EN_cod_ciclfact"   Tipo="NUMBER> codigo ciclo</param>

        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
ERROR_PROCESO     EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
SN_CantAbonados   number(2);

CURSOR serv_cur IS
  SELECT a.cod_servicio
  FROM  ga_servsuplabo a
  WHERE a.num_abonado = EN_num_abonado
  AND a.cod_servicio in (SELECT v.cod_servicio FROM  ga_servsupl v
                       WHERE v.tip_cobro  = CV_TIP_COBRO)
  AND a.FEC_ALTABD is not null AND TRUNC(a.FEC_ALTABD)=TRUNC(SYSDATE)
  AND a.ind_estado < CN_ind_estado;

lv_cod_servicio    ga_servsuplabo.cod_servicio%type;
ln_cod_concepto    ga_actuaserv.cod_concepto%type;
ln_num_cobro       ga_cobros_adelantados_to.num_cobro%type:=0;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

      lv_sSql := 'SELECT a.cod_servicio ';
      lv_sSql := lv_sSql || ' FROM  ga_servsuplabo a';
      lv_sSql := lv_sSql || ' WHERE a.num_abonado = ' || EN_num_abonado;
      lv_sSql := lv_sSql || ' AND a.cod_servicio in (SELECT v.cod_servicio FROM  ga_servsupl v ';
      lv_sSql := lv_sSql || '                        WHERE v.tip_cobro  = ' || CV_TIP_COBRO || ')';
      lv_sSql := lv_sSql || ' AND a.FEC_ALTABD is not null AND TRUNC(a.FEC_ALTABD)=TRUNC(SYSDATE)';
      lv_sSql := lv_sSql || ' AND a.ind_estado < ' || CN_ind_estado;

      OPEN serv_cur ;
      LOOP
        FETCH serv_cur INTO lv_cod_servicio;
        EXIT WHEN serv_cur%NOTFOUND;

             lv_sSql := 'SELECT  A.cod_concepto ';
             lv_sSql := lv_sSql || ' FROM  ga_actuaserv A';
             lv_sSql := lv_sSql || ' WHERE A.cod_producto   = ' || CV_COD_PRODUCTO;
             lv_sSql := lv_sSql || '   AND A.cod_actabo     = ' || EV_cod_actabo;
             lv_sSql := lv_sSql || '   AND A.cod_tipserv    = ' || CV_COD_TIPSERV;
             lv_sSql := lv_sSql || '   AND A.cod_servicio   = ' || lv_cod_servicio;

          BEGIN
             SELECT  A.cod_concepto
             INTO    ln_cod_concepto
             FROM  ga_actuaserv A
             WHERE A.cod_producto   = CV_COD_PRODUCTO
               AND A.cod_actabo     = EV_cod_actabo
               AND A.cod_tipserv    = CV_COD_TIPSERV
               AND A.cod_servicio   = lv_cod_servicio;


            EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno:=1;
                 raise ERROR_PROCESO;
          END;

           
           
           lv_sSql := lv_sSql ||  'SELECT COUNT(1)' ;
           lv_sSql := lv_sSql ||  '    INTO SN_CantAbonados';
           lv_sSql := lv_sSql ||  '    FROM GA_COBROS_ADELANTADOS_TO';
           lv_sSql := lv_sSql ||  '    WHERE COD_CLIENTE='||EN_cod_cliente;
           lv_sSql := lv_sSql ||  '    AND NUM_abonado  ='|| EN_num_abonado;
           lv_sSql := lv_sSql ||  '    AND COD_CICLFACT ='||EN_cod_ciclfact;
           lv_sSql := lv_sSql ||  '    AND COD_CONCEPTO ='||ln_cod_concepto;
                
           SN_CantAbonados:=0;
                
           SELECT COUNT(1) 
           INTO SN_CantAbonados
           FROM GA_COBROS_ADELANTADOS_TO
           WHERE COD_CLIENTE = EN_cod_cliente
           AND NUM_abonado   = EN_num_abonado
           AND COD_CICLFACT  = EN_cod_ciclfact
           AND COD_CONCEPTO  = ln_cod_concepto;    
           
           if SN_CantAbonados=0 then
           

                        lv_sSql := 'FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(';
                        lv_sSql := lv_sSql || EN_cod_cliente || ',';
                        lv_sSql := lv_sSql || EN_num_abonado || ',0,';
                        lv_sSql := lv_sSql || EN_cod_ciclfact || ',';
                        lv_sSql := lv_sSql || ln_cod_concepto || ',0,';
                        lv_sSql := lv_sSql || CN_TIPO_SERVICIOSS || ',0,0,NULL,NULL)';
                      

                        FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(EN_cod_cliente,
                                                     EN_num_abonado,
                                                     0,--num_venta LLenado por Facturacion
                                                     EN_cod_ciclfact,
                                                     ln_cod_concepto,
                                                     0, --NUM_PROCESO LLenado por Facturacion
                                                     CN_TIPO_SERVICIOSS,
                                                     ln_num_cobro, --NUM_COBRO LLenado por Facturacion
                                                     SN_cod_retorno,
                                                     SV_mens_retorno,
                                                     SN_num_evento);
                       IF SN_cod_retorno <> 0 THEN
                            raise ERROR_PROCESO;
                       END IF;
                       
           end if;            
      END LOOP;
      CLOSE serv_cur;



    EXCEPTION
    WHEN ERROR_PROCESO THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('ERROR_PROCESO:PV_PAGOANTICIPADO_PG.PV_OBTENERSS_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERSS_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('NO_DATA_FOUND:PV_PAGOANTICIPADO_PG.PV_OBTENERSS_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERSS_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PAGOANTICIPADO_PG.PV_OBTENERSS_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERSS_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;

---------------------------------------------------------------------------------------------------------


PROCEDURE PV_OBTENERSS_AUX_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                         EN_num_abonado    IN ga_abocel.num_abonado%type,
                         EV_cod_actabo     IN ga_actabo.cod_actabo%type,
						 EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                         SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERSS__AUX_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Diseñador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> número del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> número del abonado</param>
			<param nom="EV_cod_acatbo"     Tipo="VARCHAR2> codigo actuacion</param>
			<param nom="EN_cod_ciclfact"   Tipo="NUMBER> codigo ciclo</param>

        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
    ERROR_PROCESO     EXCEPTION;
   lv_des_error      ge_errores_pg.DesEvent;
   lv_sSql           ge_errores_pg.vQuery;
   SN_CantAbonados   number(2);
   LV_COD_CICLFACT   FA_CICLFACT.COD_CICLFACT%TYPE; 
   LV_COD_CICLO      GA_ABOCEL.COD_CICLO%TYPE;
   LN_NUM_OS         PV_CAMCOM.NUM_OS%TYPE; 
   LV_CADENA_SS          GA_abocel.perfil_abonado%type;
   lv_cod_servicio2       GA_abocel.perfil_abonado%type;
   ln_max                INTEGER;
   ln_pos                INTEGER;
   ln_pos2               INTEGER;
   ln_pos3               INTEGER;
   LV_COD_NIVEL          GA_SERVSUPL.COD_NIVEL%TYPE;
   LV_COD_SERVSUPL       GA_SERVSUPL.COD_SERVSUPL%TYPE; 
   ln_cod_concepto       ga_actuaserv.COD_CONCEPTO%TYPE;

 

CURSOR serv_cur IS
SELECT  A.CLASE_SERVICIO_ACT
      FROM  PV_CAMCOM A 
      WHERE A.NUM_ABONADO =  EN_num_abonado AND
      A.NUM_OS =LN_NUM_OS;
      
 

lv_cod_servicio    ga_servsuplabo.cod_servicio%type;

ln_num_cobro       ga_cobros_adelantados_to.num_cobro%type:=0;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

   


      SELECT  MAX(A.NUM_OS) INTO LN_NUM_OS
      FROM  PV_CAMCOM A 
      WHERE A.NUM_ABONADO =  EN_num_abonado;
      
      dbms_output.PUT_LINE('LN_NUM_OS:'||LN_NUM_OS);
      
      OPEN serv_cur ;
      LOOP
        FETCH serv_cur INTO lv_cod_servicio2;        
        EXIT WHEN serv_cur%NOTFOUND;
        
        LV_CADENA_SS:=lv_cod_servicio2;
        ln_max       :=LENGTH(LV_CADENA_SS);
        ln_pos       := 1 ;
      
        IF (trim(LV_CADENA_SS) <> '*' OR ln_max = 0)then
      
        WHILE (LN_pos<= NVL(LN_MAX,0)) LOOP
                     if LN_pos= 1 then 
                      LV_COD_SERVSUPL:=TO_NUMBER(SUBSTR(LV_CADENA_SS,LN_POS, LN_POS + 1));
                      dbms_output.PUT_LINE('LV_COD_SERVSUPL:'|| LV_COD_SERVSUPL );              
                      LV_COD_NIVEL:=TO_NUMBER(SUBSTR(LV_CADENA_SS,(LN_POS + 2),6-2));
                      dbms_output.PUT_LINE(' LV_COD_NIVEL :'|| LV_COD_NIVEL );
                   else
                    
                      LV_COD_SERVSUPL:=TO_NUMBER(substr(SUBSTR(LV_CADENA_SS,LN_POS, LN_POS - 1),1,2));
                      dbms_output.PUT_LINE('LV_COD_SERVSUPL:'|| LV_COD_SERVSUPL );              
                      LV_COD_NIVEL:=TO_NUMBER(substr(SUBSTR(LV_CADENA_SS,LN_POS, LN_POS - 1),3,6));
                      dbms_output.PUT_LINE(' LV_COD_NIVEL :'|| LV_COD_NIVEL );  
                   end if;   
                      
       
                      begin      
                      SELECT  A.COD_SERVICIO 
                      INTO lv_cod_servicio
                      FROM GA_SERVSUPL A
                      WHERE 
                      A.COD_SERVSUPL = LV_COD_SERVSUPL AND 
                      A.COD_NIVEL    = LV_COD_NIVEL    AND 
                      A.TIP_COBRO ='A';
                      exception
                        when no_data_found then
                            null;
                      
                      end;
                      
        
                      IF TRIM(lv_cod_servicio) <> ' ' THEN
                             lv_sSql := 'SELECT  A.cod_concepto ';
                             lv_sSql := lv_sSql || ' FROM  ga_actuaserv A';
                             lv_sSql := lv_sSql || ' WHERE A.cod_producto   = ' || CV_COD_PRODUCTO;
                             lv_sSql := lv_sSql || '   AND A.cod_actabo     = ' || EV_cod_actabo;
                             lv_sSql := lv_sSql || '   AND A.cod_tipserv    = ' || CV_COD_TIPSERV;
                             lv_sSql := lv_sSql || '   AND A.cod_servicio   = ' || lv_cod_servicio;

                          BEGIN
                             SELECT  A.cod_concepto
                             INTO    ln_cod_concepto
                             FROM  ga_actuaserv A
                             WHERE A.cod_producto   = CV_COD_PRODUCTO
                               AND A.cod_actabo     = 'FA'
                               AND A.cod_tipserv    = CV_COD_TIPSERV
                               AND A.cod_servicio   = lv_cod_servicio;


                            EXCEPTION
                             WHEN NO_DATA_FOUND THEN
                                 null;
                                 --SN_cod_retorno:=1;
                                 --raise ERROR_PROCESO;
                          END;

                           
                           
                          
                           SN_CantAbonados:=0;
                                
                           SELECT  COD_CICLO 
                           INTO LV_COD_CICLO
                           FROM GA_ABOCEL WHERE NUM_ABONADO =EN_num_abonado;
                           
                           SELECT  COD_CICLFACT 
                           INTO LV_COD_CICLFACT 
                           FROM FA_CICLFACT 
                           WHERE COD_CICLO = LV_COD_CICLO
                           AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

                            lv_sSql := lv_sSql ||  'SELECT COUNT(1)' ;
                           lv_sSql := lv_sSql ||  '    INTO SN_CantAbonados';
                           lv_sSql := lv_sSql ||  '    FROM GA_COBROS_ADELANTADOS_TO';
                           lv_sSql := lv_sSql ||  '    WHERE COD_CLIENTE='||EN_cod_cliente;
                           lv_sSql := lv_sSql ||  '    AND NUM_abonado  ='|| EN_num_abonado;
                           lv_sSql := lv_sSql ||  '    AND COD_CICLFACT ='||LV_COD_CICLFACT;
                           lv_sSql := lv_sSql ||  '    AND COD_CONCEPTO ='||ln_cod_concepto;
                                
                           
                           SELECT COUNT(1) 
                           INTO SN_CantAbonados
                           FROM GA_COBROS_ADELANTADOS_TO
                           WHERE COD_CLIENTE = EN_cod_cliente
                           AND NUM_abonado   = EN_num_abonado
                           AND COD_CICLFACT  = LV_COD_CICLFACT
                           AND COD_CONCEPTO  = ln_cod_concepto;    

                           if SN_CantAbonados=0 AND  ln_cod_concepto > 0 then
                           
                                        lv_sSql := 'FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(';
                                        lv_sSql := lv_sSql || EN_cod_cliente || ',';
                                        lv_sSql := lv_sSql || EN_num_abonado || ',0,';
                                        lv_sSql := lv_sSql || EN_cod_ciclfact || ',';
                                        lv_sSql := lv_sSql || ln_cod_concepto || ',0,';
                                        lv_sSql := lv_sSql || CN_TIPO_SERVICIOSS || ',0,0,NULL,NULL)';
                                      

                                        FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(EN_cod_cliente,
                                                                     EN_num_abonado,
                                                                     0,--num_venta LLenado por Facturacion
                                                                     LV_COD_CICLFACT,
                                                                     ln_cod_concepto,
                                                                     0, --NUM_PROCESO LLenado por Facturacion
                                                                     CN_TIPO_SERVICIOSS,
                                                                     ln_num_cobro, --NUM_COBRO LLenado por Facturacion
                                                                     SN_cod_retorno,
                                                                     SV_mens_retorno,
                                                                     SN_num_evento);
                                       IF SN_cod_retorno <> 0 THEN
                                            raise ERROR_PROCESO;
                                       END IF;
                                       
                           end if;
                      END IF;       
                       
                ln_pos:=ln_pos+6;
                END LOOP;  
        END IF;
                    
      END LOOP;
      CLOSE serv_cur;
    


    EXCEPTION
    WHEN ERROR_PROCESO THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('ERROR_PROCESO:PV_PAGOANTICIPADO_PG.PV_OBTENERSS_AUX_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERSS_AUX_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('NO_DATA_FOUND:PV_PAGOANTICIPADO_PG.PV_OBTENERSS_AUX_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERSS_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PAGOANTICIPADO_PG.PV_OBTENERSS_AUX_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERSS_AUX_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;


PROCEDURE PV_OBTENERPLAN_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                           EN_num_abonado    IN ga_abocel.num_abonado%type,
                           EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                           EV_cod_plantarif  IN ga_abocel.cod_plantarif%type,
                           SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERPLAN_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Diseñador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> número del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> número del abonado</param>
            <param nom="EN_cod_ciclfact"   Tipo="NUMBER> codigo ciclo</param>
            <param nom="EV_cod_plantarif"  Tipo="VARCHAR2> codigo plan tarifario</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
ERROR_PROCESO     EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_cod_concepto   ga_actuaserv.cod_concepto%type;
ln_num_cobro      ga_cobros_adelantados_to.num_cobro%type:=0;
ln_count          number;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

         lv_sSql := 'SELECT 1 ';
         lv_sSql := lv_sSql || ' FROM ta_plantarif A';
         lv_sSql := lv_sSql || ' WHERE A.cod_plantarif =' || EV_cod_plantarif;
         lv_sSql := lv_sSql || ' AND A.tip_cobro  = ' || CV_TIP_COBRO ;

      BEGIN
         SELECT 1
         INTO ln_count
         FROM ta_plantarif A
         WHERE A.cod_plantarif = EV_cod_plantarif
         AND A.tip_cobro  = CV_TIP_COBRO ;

        EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 NULL;
      END;

         IF  ln_count = 1 THEN
             lv_sSql := 'SELECT min(to_number(A.cod_parametro)) ';
             lv_sSql := lv_sSql || ' FROM fad_parametros A';
             lv_sSql := lv_sSql || ' WHERE A.des_parametro = ' || 'CODIGO CARGO BASICO ADELANTADO';

           BEGIN
             SELECT min(to_number(A.cod_parametro))
             INTO  ln_cod_concepto
             FROM fad_parametros A
             WHERE A.des_parametro = 'CODIGO CARGO BASICO ADELANTADO';

             EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno:=1;
                 raise ERROR_PROCESO;
           END;

           lv_sSql := 'FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(';
           lv_sSql := lv_sSql || EN_cod_cliente || ',';
           lv_sSql := lv_sSql || EN_num_abonado || ',0,';
           lv_sSql := lv_sSql || EN_cod_ciclfact || ',';
           lv_sSql := lv_sSql || ln_cod_concepto || ',0,';
           lv_sSql := lv_sSql || CN_TIPO_SERVICIOPLAN || ',0,0,NULL,NULL)';

           FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(EN_cod_cliente,
                                         EN_num_abonado,
                                         0,--num_venta LLenado por Facturacion
                                         EN_cod_ciclfact,
                                         ln_cod_concepto,
                                         0, --NUM_PROCESO LLenado por Facturacion
                                         CN_TIPO_SERVICIOPLAN,
                                         ln_num_cobro, --NUM_COBRO LLenado por Facturacion
                                         SN_cod_retorno,
                                         SV_mens_retorno,
                                         SN_num_evento);

           IF SN_cod_retorno <> 0 THEN
                raise ERROR_PROCESO;
           END IF;
       END IF;

    EXCEPTION
    WHEN ERROR_PROCESO THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('ERROR_PROCESO:PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('NO_DATA_FOUND:PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;
---------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTENERPLAN_ADICIONAL_PR(EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                                    EN_num_abonado    IN ga_abocel.num_abonado%type,
                                    EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS

/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_OBTENERPLAN_ADICIONALPR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Diseñador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno> </Retorno>
        <Descripcion>
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> número del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> número del abonado</param>
            <param nom="EN_cod_ciclfact"   Tipo="NUMBER> codigo ciclo</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
ERROR_PROCESO     EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
ln_cod_concepto   ga_actuaserv.cod_concepto%type;
ln_cod_prod_ofertado pr_productos_contratados_to.cod_prod_ofertado%type;
ln_num_cobro       ga_cobros_adelantados_to.num_cobro%type:=0;

CURSOR adic_cur IS
 SELECT  A.cod_prod_ofertado
 FROM pr_productos_contratados_to A
 WHERE A.num_abonado_contratante = EN_num_abonado
 AND A.cod_cliente_contratante   = EN_cod_cliente
 AND SYSDATE BETWEEN A.fec_inicio_vigencia AND A.FEC_TERMINO_VIGENCIA
 AND a.cod_prod_ofertado in (SELECT v.cod_prod_ofertado FROM  PF_CONCEPTOS_PROD_TD v
                             WHERE v.tip_cobro  = CV_TIP_COBRO);

BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';

       lv_sSql := ' SELECT  A.cod_prod_ofertado ';
       lv_sSql := lv_sSql || ' FROM pr_productos_contratados_to A';
       lv_sSql := lv_sSql || ' WHERE A.num_abonado_contratante =' || EN_num_abonado;
       lv_sSql := lv_sSql || ' AND A.cod_cliente_contratante   =' || EN_cod_cliente;
       lv_sSql := lv_sSql || ' AND SYSDATE BETWEEN A.fec_inicio_vigencia AND A.FEC_TERMINO_VIGENCIA';

      OPEN adic_cur;
      LOOP
        FETCH adic_cur INTO ln_cod_prod_ofertado;
        EXIT WHEN adic_cur%NOTFOUND;

        BEGIN
         lv_sSql := 'SELECT A.cod_concepto ';
         lv_sSql := lv_sSql || ' from pf_conceptos_prod_td A ';
         lv_sSql := lv_sSql || ' WHERE A.cod_prod_ofertado =' || ln_cod_prod_ofertado;
         lv_sSql := lv_sSql || ' AND A.tip_cobro           =' || CV_TIP_COBRO;

         SELECT A.cod_concepto
         INTO ln_cod_concepto
         from pf_conceptos_prod_td A
         WHERE A.cod_prod_ofertado = ln_cod_prod_ofertado
         AND A.tip_cobro           = CV_TIP_COBRO;

         EXCEPTION
          WHEN NO_DATA_FOUND THEN
              NULL;
        END;

           lv_sSql := 'FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(';
           lv_sSql := lv_sSql || EN_cod_cliente || ',';
           lv_sSql := lv_sSql || EN_num_abonado || ',0,';
           lv_sSql := lv_sSql || EN_cod_ciclfact || ',';
           lv_sSql := lv_sSql || ln_cod_concepto || ',0,';
           lv_sSql := lv_sSql || CN_TIPO_SERVICIOADIC || ',0,0,NULL,NULL)';

           FA_SERVICIOS_FACTURACION_PG.FA_INSERTACOBROADELANTADO_PR(EN_cod_cliente,
                                         EN_num_abonado,
                                         0,--num_venta LLenado por Facturacion
                                         EN_cod_ciclfact,
                                         ln_cod_concepto,
                                         0, --NUM_PROCESO LLenado por Facturacion
                                         CN_TIPO_SERVICIOADIC,
                                         ln_num_cobro, --NUM_COBRO LLenado por Facturacion
                                         SN_cod_retorno,
                                         SV_mens_retorno,
                                         SN_num_evento);

           IF SN_cod_retorno <> 0 THEN
                raise ERROR_PROCESO;
           END IF;
    END LOOP;
    CLOSE     adic_cur;

    EXCEPTION
    WHEN ERROR_PROCESO THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('ERROR_PROCESO:PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_ADICIONAL_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_ADICIONAL_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=1;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('NO_DATA_FOUND:PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_ADICIONAL_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_ADICIONAL_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_ADICIONAL_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_OBTENERPLAN_ADICIONAL_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;

PROCEDURE PV_INICIO_PAGOANTICIPADO_PR(EN_num_abonado    IN ga_abocel.num_abonado%type,
                                 EN_cod_cliente    IN ga_abocel.cod_cliente%type,
                                 EV_cod_plantarif  IN  ta_plantarif.cod_plantarif%type,
                                 EV_cod_actabo     IN ga_actabo.cod_actabo%type,
                                 EN_cod_ciclfact   IN fa_ciclfact.cod_ciclfact%type,
                                 EN_aplica_pago    in number,
                                 SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                 SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                 SN_num_evento     OUT NOCOPY ge_errores_pg.Evento) IS
/*--
        <Documentacion TipoDoc = "Procedure">
            Elemento Nombre = "PV_INICIO_PAGOANTICIPADO_PR"
            Lenguaje="PL/SQL"
            Fecha="12/05/2009"
            Version="1.0.0"
            Diseñador="Vladimir Maureira"
            Programador="Vladimir Maureira
            Ambiente="BD"
        <Retorno>  BOOLEAN </Retorno>
        <Descripcion>
            retornar ciclo abonado
        </Descripcion>
        <Parametros>
        <Entrada>
            <param nom="EN_cod_cliente"    Tipo="NUMBER> número del cliente</param>
            <param nom="EN_num_abonado"    Tipo="NUMBER> número del abonado</param>
            <param nom="EV_cod_plantarif"  Tipo="VARCHAR2> plan Tarifario</param>
            <param nom="EV_cod_actabo"     Tipo="VARCHAR2> codigo actuacion</param>
            <param nom="EN_cod_ciclfact"   Tipo="NUMBER> codigo ciclo</param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"    Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"      Tipo="NUMBER"> numero de evento </param>
        </Salida>
        </Parametros>
        </Elemento>
        </Documentacion>
        --*/
ERROR_PROCESO     EXCEPTION;
lv_des_error      ge_errores_pg.DesEvent;
lv_sSql           ge_errores_pg.vQuery;
BEGIN
      SN_num_evento:= 0;
      SN_cod_retorno:=0;
      SV_mens_retorno:='';
      if EN_aplica_pago = 1 then -- aplica realizar pago anticipado

                  lv_sSql := 'PV_OBTENERSS_PR';
                  PV_OBTENERSS_PR(EN_cod_cliente,EN_num_abonado,EV_cod_actabo,EN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                  IF SN_cod_retorno <> 0 THEN
                     raise ERROR_PROCESO;
                  END IF;

                  lv_sSql := 'PV_OBTENERPLAN_PR';
                  PV_OBTENERPLAN_PR(EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,EV_cod_plantarif,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                  IF SN_cod_retorno <> 0 THEN
                     raise ERROR_PROCESO;
                  END IF;

                  lv_sSql := 'PV_OBTENERPLAN_ADICIONAL_PR';
                  PV_OBTENERPLAN_ADICIONAL_PR(EN_cod_cliente,EN_num_abonado,EN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                  IF SN_cod_retorno <> 0 THEN
                     raise ERROR_PROCESO;
                  END IF;

     end if;
    EXCEPTION
    WHEN ERROR_PROCESO THEN
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('ERROR_PROCESO:PV_PAGOANTICIPADO_PG.PV_INICIO_PAGOANTICIPADO_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_INICIO_PAGOANTICIPADO_PR', lv_sSql, SN_cod_retorno, LV_des_error );
     WHEN OTHERS THEN
          SN_cod_retorno:=4;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := CV_ERROR_NO_CLASIF;
          END IF;
          LV_des_error := SUBSTR('OTHERS:PV_PAGOANTICIPADO_PG.PV_INICIO_PAGOANTICIPADO_PR(); - '|| SQLERRM,1,CN_LARGOERRTEC);
          SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_LARGODESC);
          SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento,CV_MODULO_GA,SV_mens_retorno, '1.0', USER,
          'PV_PAGOANTICIPADO_PG.PV_INICIO_PAGOANTICIPADO_PR', lv_sSql, SN_cod_retorno, LV_des_error );
END;
END;
/
SHOW ERRORS