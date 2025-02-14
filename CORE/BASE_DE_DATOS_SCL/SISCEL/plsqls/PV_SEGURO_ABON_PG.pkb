CREATE OR REPLACE PACKAGE BODY PV_SEGURO_ABON_PG AS

 PROCEDURE PV_CARGA_SEGURO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                              SO_Lista_Abonado         OUT NOCOPY      refCursor)

IS

/*
 <Documentaci¾n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versi¾n="PV_CARGA_SEGURO_PRPV_DESACTIVA_SEGURO_SEG_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¾n></Descripci¾n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¾n>
 */


 LV_DES_ERROR    GE_ERRORES_PG.DESEVENT;
 LV_SSQL         GE_ERRORES_PG.VQUERY;
 SN_COD_RETORNO  ge_errores_pg.CodError;
 SV_MENS_RETORNO ge_errores_pg.MsgError;
 SN_NUM_EVENTO   ge_errores_pg.Evento;

 error_exception  EXCEPTION;

BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

    OPEN SO_Lista_Abonado FOR
    SELECT
      COD_SEGURO    ,
      DES_SEGUR     ,
      NUM_MAXEV     ,
      TIP_COBERT    ,
      COD_CONCEPTO  ,
      DEDUCIBLE     ,
      IMP_SEGUR     ,
      FEC_INICIO    ,
      FEC_TERMINO
      FROM GA_TIPOSEGURO_TD
      WHERE SYSDATE BETWEEN FEC_INICIO AND FEC_TERMINO;


EXCEPTION
            WHEN error_exception THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  ' PV_CARGA_SEGURO_PR ('||'); - ' || SQLERRM;
                SV_mens_retorno :=  CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_SEGURO_ABON_PG.PV_CARGA_SEGURO_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_CARGA_SEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_SEGURO_ABON_PG.PV_CARGA_SEGURO_PR ',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_CARGA_SEGURO_PR;



PROCEDURE PV_CARGO_RECSEGURO_PR(EO_NUM_ABONADO           IN             GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE           IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PROD_CONTRA       IN              PR_PRODUCTOS_CONTRATADOS_TO.COD_PROD_CONTRATADO%TYPE,
                               EO_COD_CARGO_PROD_CONTRA IN              FA_CARGOS_REC_TO.COD_CARGO_CONTRATADO%TYPE,
                               EO_NUM_ABONADO_PAGO      IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                               EO_COD_CLIENTE_PAGO      IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                               EO_COD_PLANSERV          IN              GA_ABOCEL.COD_PLANSERV%TYPE,
                               EO_IND_COBPRORRATEA      IN              NUMBER,
                               EO_COD_CONCEPTO          IN              FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                               EO_FECHA_ALTA            IN              DATE,
                               EO_FECHA_BAJA            IN              DATE,
                               EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                               sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                               sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                               sn_num_evento            OUT NOCOPY      ge_errores_pg.evento)

IS

/*
 <Documentaci¾n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versi¾n="PV_CARGO_RECSEGURO_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¾n></Descripci¾n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¾n>
 */


 lv_des_error    ge_errores_pg.desevent;
 lv_ssql         ge_errores_pg.vquery;
 lo_cargos_rec     FA_CARGOS_REC_QT;




 error_exception1  EXCEPTION;



BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;
    lo_cargos_rec := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

    lo_cargos_rec.cod_clienteserv      := eo_cod_cliente;
    lo_cargos_rec.num_abonadoserv      := eo_num_abonado;
    lo_cargos_rec.cod_prod_contratado  := eo_cod_prod_contra;
    lo_cargos_rec.cod_cargo_contratado := eo_cod_cargo_prod_contra;
    lo_cargos_rec.cod_clientepago      := eo_cod_cliente_pago;
    lo_cargos_rec.num_abonadopago      := eo_num_abonado_pago;
    lo_cargos_rec.cod_planserv         := eo_cod_planserv;
    lo_cargos_rec.ind_cargopro         := eo_ind_cobprorratea;
    lo_cargos_rec.cod_concepto         := eo_cod_concepto;
    lo_cargos_rec.fec_alta             := eo_fecha_alta;
    lo_cargos_rec.fec_baja             := TO_DATE('31-12-3000','DD-MM-YYYY'); ----eo_fecha_baja;
    lo_cargos_rec.fec_desdecobr        := eo_fecha_alta;
    lo_cargos_rec.fec_hastacobr        := TO_DATE('31-12-3000','DD-MM-YYYY');
    lo_cargos_rec.fec_desdebloc        := eo_fecha_alta;
    lo_cargos_rec.fec_hastabloc        := TO_DATE('31-12-3000','DD-MM-YYYY');
    lo_cargos_rec.nom_usuario          := eo_usuario;


    lv_ssql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR('||eo_cod_cliente||', '||eo_num_abonado||', '||eo_cod_prod_contra||', '||eo_cod_cargo_prod_contra||', '||eo_cod_planserv||', '||eo_ind_cobprorratea||', '||eo_cod_concepto||')';
    fa_cargos_rec_sn_pg.fa_cargos_rec_alta_pr (lo_cargos_rec, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
    if (sn_cod_retorno != 0) then
        RAISE error_exception1;
    end if;

EXCEPTION
            WHEN error_exception1 THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  ' PV_CARGO_RECSEGURO_PR ('||'); - ' || SQLERRM;
                SV_mens_retorno :=  sv_mens_retorno; ----CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_SEGURO_ABON_PG.PV_CARGO_RECSEGURO_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_CARGO_RECSEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_SEGURO_ABON_PG.PV_CARGO_RECSEGURO_PR ',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_CARGO_RECSEGURO_PR;



PROCEDURE PV_ACTIVA_SEGURO_PR(EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                EO_COD_SEGURO            IN              VARCHAR2,
                                EO_NUM_EVENTO               IN              NUMBER,
                                EO_PRC_LISTA                IN              NUMBER,
                                EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS

/*
 <Documentaci¾n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versi¾n="PV_ACTIVA_SEGURO_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¾n></Descripci¾n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¾n>
 */

 lv_des_error    ge_errores_pg.desevent;
 lv_ssql         ge_errores_pg.vquery;
 sSegur         GA_TIPOSEGURO_TD.TIP_COBERT%TYPE;
 sfFechaHasta   date;
 slMeses    number;

  error_exception1  EXCEPTION;


BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;
    sSegur          := 0;
    sfFechaHasta    := NULL;
    slMeses        :=0;


--    lv_ssql :='select TIP_COBERT';
--    lv_ssql :=lv_ssql ||' into  sSegur';
--    lv_ssql :=lv_ssql ||' from GA_TIPOSEGURO_TD';
--    lv_ssql :=lv_ssql ||' where cod_seguro = ' || EO_COD_SEGURO ;

--    select TIP_COBERT
--    into  sSegur
--    from GA_TIPOSEGURO_TD
--    where cod_seguro =EO_COD_SEGURO;

--    IF sSegur = 1 THEN
--        -- corresponde a la seleccion de a±o calendario

--        lv_ssql :='SELECT TO_DATE(31/12 || TO_CHAR (SYSDATE,YYYY) ,DD/MM/YYYY)';
--        lv_ssql :=lv_ssql ||' INTO sfFechaHasta';
--        lv_ssql :=lv_ssql ||' FROM DUAL';

--        SELECT TO_DATE('31/12' || TO_CHAR (SYSDATE,'YYYY') ,'DD/MM/YYYY')
--        INTO sfFechaHasta
--        FROM DUAL;

--    ELSE
--        IF sSegur = 2 THEN
--            -- corresponde a la seleccion de meses por contratar
--            lv_ssql :='select MESES_MINIMO ';
--            lv_ssql :=lv_ssql ||' into slMeses';
--            lv_ssql :=lv_ssql ||' from ga_tipcontrato';
--            lv_ssql :=lv_ssql ||' where COD_TIPCONTRATO in (SELECT COD_TIPCONTRATO';
--            lv_ssql :=lv_ssql ||' FROM GA_ABOCEL ';
--            lv_ssql :=lv_ssql ||' WHERE NUM_ABONADO =' ||EO_NUM_ABONADO;

--            select MESES_MINIMO
--            into slMeses
--            from ga_tipcontrato
--            where COD_TIPCONTRATO in (SELECT COD_TIPCONTRATO
--            FROM GA_ABOCEL
--            WHERE NUM_ABONADO = EO_NUM_ABONADO);

--            --lv_ssql :='SELECT to_char(sysdate + numtoyminterval(slMeses,MONTH), MM/DD/YYYY) ';
--            lv_ssql :='SELECT TO_DATE(to_CHAR(sysdate + numtoyminterval(12, MONTH), DD/MM/YYYY),DD/MM/YYYY) ';
--            lv_ssql :=lv_ssql ||' INTO sfFechaHasta';
--            lv_ssql :=lv_ssql ||' FROM DUAL';

--            --SELECT to_char(sysdate + numtoyminterval(slMeses, 'MONTH'), 'MM/DD/YYYY')
--             SELECT TO_DATE(to_CHAR(sysdate + numtoyminterval(12, 'MONTH'), 'DD/MM/YYYY'),'DD/MM/YYYY')
--            into sfFechaHasta
--            FROM dual;

--        ELSE
--            -- corresponde a la selecci¾n por a±o continuado
--            
--                lv_ssql :='SELECT FEC_PRORROGA';
--                lv_ssql :=lv_ssql ||' INTO SFFECHAHASTA';
--                lv_ssql :=lv_ssql ||' FROM GA_ABOCEL ';
--                lv_ssql :=lv_ssql ||' WHERE NUM_ABONADO = ' || EO_NUM_ABONADO;

--                SELECT FEC_PRORROGA
--                    INTO sfFechaHasta
--                FROM GA_ABOCEL
--                WHERE NUM_ABONADO = EO_NUM_ABONADO;
--                
--                
--                
--                    lv_ssql :='SELECT FEC_ALTA ';
--                    lv_ssql :=lv_ssql ||' INTO SFFECHAHASTA';
--                    lv_ssql :=lv_ssql ||' FROM GA_ABOCEL ';
--                    lv_ssql :=lv_ssql ||' WHERE NUM_ABONADO = ' || EO_NUM_ABONADO;

--                IF sfFechaHasta IS NULL OR sfFechaHasta= '' THEN
--                    
--                    SELECT FEC_ALTA 
--                        INTO sfFechaHasta
--                    FROM GA_ABOCEL
--                    WHERE NUM_ABONADO = EO_NUM_ABONADO;

--                END IF;         
--                    
--                
--                SELECT SFFECHAHASTA+365 INTO sfFechaHasta FROM DUAL;
--                        
--                IF TRUNC(sfFechaHasta) <= TRUNC(SYSDATE) THEN
--                
--                    lv_ssql :='SUBSTR(SYSDATE,1,6)||-|| (TO_CHAR(SYSDATE,YYYY)+ 1) ';
--                    lv_ssql :=lv_ssql ||' INTO sfFechaHasta';
--                    lv_ssql :=lv_ssql ||' FROM DUAL';
--                
--                    SELECT SUBSTR(SYSDATE,1,6)||'-'|| (TO_CHAR(SYSDATE,'YYYY')+ 1)                            
--                    INTO sfFechaHasta
--                    From DUAL;                                        
--                    
--                 END IF;

--    END IF;

--    END IF;
    
    lv_ssql :='insert into  ga_seguroabonado_to  NUM_ABONADO    ,   COD_SEGURO     ,    NUM_EVENTOS    ,';
    lv_ssql :=lv_ssql ||' IMPORTE_EQUIPO   ,    FEC_ALTA         ,    FEC_FINCONTRATO  ,    FEC_MODIFICACION ,    NOM_USUARORA';
    lv_ssql :=lv_ssql ||' values  ( ';
    lv_ssql :=lv_ssql || EO_NUM_ABONADO||','|| EO_COD_SEGURO||','|| EO_NUM_EVENTO||','||EO_PRC_LISTA||','|| 'sysdate' ||','|| '31-12-3000'||','|| 'sysdate'||','|| EO_USUARIO||',)' ;

    insert into  ga_seguroabonado_to(
    NUM_ABONADO    ,
    COD_SEGURO     ,
    NUM_EVENTOS    ,
    IMPORTE_EQUIPO   ,
    FEC_ALTA         ,
    FEC_FINCONTRATO  ,
    FEC_MODIFICACION ,
    NOM_USUARORA   )
    values
    (
    EO_NUM_ABONADO,
    EO_COD_SEGURO,
    EO_NUM_EVENTO   ,
    EO_PRC_LISTA    ,
    sysdate ,
    TO_DATE('31-12-3000','DD-MM-YYYY'),  -----sfFechaHasta,
    sysdate,
    EO_USUARIO
    ) ;



EXCEPTION
            WHEN error_exception1 THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  'PV_ACTIVA_SEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno :=  CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_SEGURO_ABON_PG.PV_ACTIVA_SEGURO_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_ACTIVA_SEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  SV_mens_retorno;---CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_SEGURO_ABON_PG.PV_ACTIVA_SEGURO_PR',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_ACTIVA_SEGURO_PR;

PROCEDURE PV_DESACTIVA_SEGURO_PR(EO_NUM_ABONADO          IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                EO_COD_SEGURO            IN              VARCHAR2,
                                EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS

/*
 <Documentaci¾n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versi¾n="PV_DESACTIVA_SEGURO_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¾n></Descripci¾n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¾n>
 */

 lv_des_error    ge_errores_pg.desevent;
 lv_ssql         ge_errores_pg.vquery;
 lo_cargos_rec     FA_CARGOS_REC_QT;
 ld_fecha        date;
 ln_cod_cliente  ga_Abocel.cod_cliente%type;
 ln_cod_concepto GA_TIPOSEGURO_TD.COD_CONCEPTO%type;

 error_exception1  EXCEPTION;


BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;


    lv_ssql :=' update ga_seguroabonado_to';
    lv_ssql :=lv_ssql ||' set ';
    lv_ssql :=lv_ssql ||' FEC_FINCONTRATO   = '|| sysdate;
    lv_ssql :=lv_ssql ||' ,FEC_MODIFICACION = '|| sysdate;
    lv_ssql :=lv_ssql ||' ,NOM_USUARORA     = '|| EO_USUARIO;
    lv_ssql :=lv_ssql ||' where';
    lv_ssql :=lv_ssql ||' num_abonado ='|| EO_NUM_ABONADO;
    lv_ssql :=lv_ssql ||' and cod_seguro = '|| EO_COD_SEGURO;
    lv_ssql :=lv_ssql ||' (FEC_FINCONTRATO  IS NULL OR FEC_FINCONTRATO > SYSDATE)';

    update ga_seguroabonado_to
    set
    FEC_FINCONTRATO  = sysdate,
    FEC_MODIFICACION = sysdate,
    NOM_USUARORA    = EO_USUARIO
    where
    num_abonado =EO_NUM_ABONADO and
    cod_seguro = EO_COD_SEGURO  and
    (FEC_FINCONTRATO  IS NULL OR FEC_FINCONTRATO > SYSDATE);


    select  sysdate - (1/(24*60*60))
    into ld_fecha
    from dual;


    select  cod_cliente into ln_cod_cliente
    from  ga_abocel
    where num_abonado = eo_num_abonado;

    select  cod_concepto
    into ln_cod_concepto
    from GA_TIPOSEGURO_TD
    where  cod_seguro=EO_COD_SEGURO  and
    sysdate between fec_inicio and fec_termino;


    lo_cargos_rec := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

    lo_cargos_rec.cod_clienteserv      := ln_cod_cliente;
    lo_cargos_rec.num_abonadoserv      := eo_num_abonado;
    lo_cargos_rec.cod_prod_contratado  := 0;
    lo_cargos_rec.cod_cargo_contratado := 0;
    lo_cargos_rec.cod_concepto         := ln_cod_concepto;
    lo_cargos_rec.fec_alta             := ld_fecha;
    lo_cargos_rec.nom_usuario          := eo_usuario;



    lv_ssql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR('||ln_cod_cliente||', '||eo_num_abonado||', '||'0'||', '||'0'||', '||ln_cod_concepto||')';
    FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR (lo_cargos_rec, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
    if (sn_cod_retorno != 0) then
        RAISE error_exception1;
    end if;


EXCEPTION
            WHEN error_exception1 THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  'PV_DESACTIVA_SEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno :=  sv_mens_retorno; -----CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_SEGURO_ABON_PG.PV_DESACTIVA_SEGURO_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_DESACTIVA_SEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  sv_mens_retorno; -----CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_SEGURO_ABON_PG.PV_DESACTIVA_SEGURO_PR',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_DESACTIVA_SEGURO_PR;

 PROCEDURE PV_BAJA_CARGREC_PR   ( EO_NUM_ABONADO           IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                  EO_COD_SEGURO            IN              VARCHAR2,
                                  EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                  EN_CLIENTE_ORIGEN        IN              GA_ABOCEL.COD_CLIENTE%TYPE,
                                  sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                  sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                  sn_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS

/*
 <Documentaci¾n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versi¾n="PV_DESACTIVA_SEGURO_PR
       Dise±ador="NRCA"
       Programador="NRCA"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¾n></Descripci¾n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¾n>
 */

 lv_des_error    ge_errores_pg.desevent;
 lv_ssql         ge_errores_pg.vquery;
 lo_cargos_rec     FA_CARGOS_REC_QT;
 ld_fecha        date;
 ln_cod_cliente  ga_Abocel.cod_cliente%type;
 ln_cod_concepto GA_TIPOSEGURO_TD.COD_CONCEPTO%type;

 error_exception1  EXCEPTION;


BEGIN
    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;



    --Dar de baja el cobro del Seguro para el cliente origen

    select  cod_concepto
    into ln_cod_concepto
    from GA_TIPOSEGURO_TD
    where  cod_seguro=EO_COD_SEGURO  and
    sysdate between fec_inicio and fec_termino;

    select  sysdate - (1/(24*60*60))
    into ld_fecha
    from dual;

    lo_cargos_rec := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');

    lo_cargos_rec.cod_clienteserv      := EN_CLIENTE_ORIGEN;
    lo_cargos_rec.num_abonadoserv      := eo_num_abonado;
    lo_cargos_rec.cod_prod_contratado  := 0;
    lo_cargos_rec.cod_cargo_contratado := 0;
    lo_cargos_rec.cod_concepto         := ln_cod_concepto;
    lo_cargos_rec.fec_alta             := ld_fecha;
    lo_cargos_rec.nom_usuario          := eo_usuario;



    lv_ssql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR('||ln_cod_cliente||', '||eo_num_abonado||', '||'0'||', '||'0'||', '||ln_cod_concepto||')';
    FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR (lo_cargos_rec, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
    if (sn_cod_retorno != 0) then
        RAISE error_exception1;
    end if;



EXCEPTION
            WHEN error_exception1 THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  'PV_DESACTIVA_SEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno :=  sv_mens_retorno;----CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_SEGURO_ABON_PG.PV_DESACTIVA_SEGURO_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);


           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_DESACTIVA_SEGURO_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  SV_mens_retorno;---CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_SEGURO_ABON_PG.PV_DESACTIVA_SEGURO_PR',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );


END PV_BAJA_CARGREC_PR;

PROCEDURE PV_DESACTIVA_SEGURO_SEG_PR(EO_NUM_ABONADO          IN              GA_ABOCEL.NUM_ABONADO%TYPE,
                                EO_COD_SEGURO            IN              VARCHAR2,
                                EO_USUARIO               IN              GA_ABOCEL.NOM_USUARORA%TYPE,
                                sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                sn_num_evento            OUT NOCOPY      ge_errores_pg.evento)
IS

/*

 <Documentaci¾n
   TipoDoc = "Procedure">>
    <Elemento
       Nombre = ""
       Lenguaje="PL/SQL"
       Fecha="20-07-2009"
       Versi¾n="PV_DESACTIVA_SEGURO_SEG_PR
       Dise±ador="Orlando Cabezas"
       Programador="Orlando Cabezas"
       Ambiente Desarrollo="BD">
       <Retorno>N/A</Retorno>>
       <Descripci¾n></Descripci¾n>>
       <Parßmetros>
          <Entrada>
             <Entrada>
             <param nom="EO_NUM_ABONADO" Tipo="NUMERICO">NUMERO ABONADO<param>>
          </Entrada>
          </Entrada>
          <Salida>
             <param nom=" SO_Lista_AbonadoTipo="ESTRUCTURA">REGISTRO RESUMEN LLAMADAS<param>>
          </Salida>
       </Parßmetros>
    </Elemento>
 </Documentaci¾n>
 */

 

 lv_des_error    ge_errores_pg.desevent;
 lv_ssql         ge_errores_pg.vquery;
 lo_cargos_rec     FA_CARGOS_REC_QT;
 ld_fecha        date;
 ln_cod_cliente  ga_Abocel.cod_cliente%type;
 ln_cod_concepto GA_TIPOSEGURO_TD.COD_CONCEPTO%type;
 ln_cod_cargo    GA_TIPOSEGURO_TD.COD_CARGO%type;
error_exception1  EXCEPTION;

BEGIN

    sn_cod_retorno  := 0;
    sv_mens_retorno := NULL;
    sn_num_evento   := 0;

 
    lv_ssql :=' update ga_seguroabonado_to';
    lv_ssql :=lv_ssql ||' set ';
    lv_ssql :=lv_ssql ||' FEC_FINCONTRATO   = '|| sysdate;
    lv_ssql :=lv_ssql ||' ,FEC_MODIFICACION = '|| sysdate;
    lv_ssql :=lv_ssql ||' ,NOM_USUARORA     = '|| EO_USUARIO;
    lv_ssql :=lv_ssql ||' where';
    lv_ssql :=lv_ssql ||' num_abonado ='|| EO_NUM_ABONADO;
    lv_ssql :=lv_ssql ||' and cod_seguro = '|| EO_COD_SEGURO;
    lv_ssql :=lv_ssql ||' (FEC_FINCONTRATO  IS NULL OR FEC_FINCONTRATO > SYSDATE)';

 

    update ga_seguroabonado_to
    set
    FEC_FINCONTRATO  = sysdate,
    FEC_MODIFICACION = sysdate,
    NOM_USUARORA    = EO_USUARIO
    where
    num_abonado =EO_NUM_ABONADO and
    cod_seguro = EO_COD_SEGURO  and
    (FEC_FINCONTRATO  IS NULL OR FEC_FINCONTRATO > SYSDATE);

 
    select  sysdate - (1/(24*60*60))
    into ld_fecha
    from dual;

 
    select  cod_cliente into ln_cod_cliente
    from  ga_abocel
    where num_abonado = eo_num_abonado;

 

    select  cod_concepto, cod_cargo
    into ln_cod_concepto, ln_cod_cargo
    from GA_TIPOSEGURO_TD
    where  cod_seguro=EO_COD_SEGURO  and
    sysdate between fec_inicio and fec_termino;

 
    lo_cargos_rec := FA_CARGOS_REC_QT('','','','','','','','','','','','','','','','','','','','','','','','');
    lo_cargos_rec.cod_clienteserv      := ln_cod_cliente;
    lo_cargos_rec.num_abonadoserv      := eo_num_abonado;
    lo_cargos_rec.cod_prod_contratado  := 0;
    lo_cargos_rec.cod_cargo_contratado := ln_cod_cargo;
    lo_cargos_rec.cod_concepto         := ln_cod_concepto;
    lo_cargos_rec.fec_alta             := ld_fecha;
    lo_cargos_rec.nom_usuario          := eo_usuario;

 
    lv_ssql:= 'FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_SEG_PR('||ln_cod_cliente||', '||eo_num_abonado||', '||'0'||', '||'0'||', '||ln_cod_concepto||')';
    FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_SEG_PR (lo_cargos_rec, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
    if (sn_cod_retorno != 0) then
        RAISE error_exception1;
    end if;


EXCEPTION

            WHEN error_exception1 THEN
                SN_cod_retorno := -1;
                LV_des_error    :=  'PV_DESACTIVA_SEGURO_SEG_PR('||'); - ' || SQLERRM;
                SV_mens_retorno :=  sv_mens_retorno; ---CV_ERROR_NO_CLASIF;
                SN_num_evento   :=  Ge_Errores_Pg.Grabarpl(
                                    SN_num_evento,
                                    CV_COD_MODULO,
                                    SV_mens_retorno,
                                    '1.0',
                                    USER,
                                    'PV_SEGURO_ABON_PG.PV_DESACTIVA_SEGURO_SEG_PR',
                                    LV_sSql,
                                    SN_cod_retorno,
                                    LV_des_error);

           WHEN OTHERS THEN
                SN_cod_retorno := -1;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                       SV_mens_retorno := CV_ERROR_NO_CLASIF;
                END IF;
                LV_des_error     :=  'PV_DESACTIVA_SEGURO_SEG_PR('||'); - ' || SQLERRM;
                SV_mens_retorno  :=  SV_mens_retorno;----CV_ERROR_NO_CLASIF;
                SN_num_evento    :=  Ge_Errores_Pg.Grabarpl(
                                     SN_num_evento,
                                     CV_COD_MODULO ,
                                     SV_mens_retorno,
                                     '1.0',
                                     USER,
                                     'PV_SEGURO_ABON_PG.PV_DESACTIVA_SEGURO_SEG_PR',
                                     LV_sSQL, SN_cod_retorno, LV_des_error );

END PV_DESACTIVA_SEGURO_SEG_PR;


END PV_SEGURO_ABON_PG;
/
SHOW ERRORS

