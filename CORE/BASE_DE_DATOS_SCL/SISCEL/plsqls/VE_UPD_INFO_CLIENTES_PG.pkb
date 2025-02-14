CREATE OR REPLACE PACKAGE BODY VE_UPD_INFO_CLIENTES_PG AS

FUNCTION VE_REC_SECUENCIA_FN (EV_NOM_SECUENCIA IN     VARCHAR2) RETURN NUMBER
IS
LV_sql                 VARCHAR2(250);
LN_secuencia        NUMBER;
BEGIN

    LV_sql := 'SELECT '||EV_NOM_SECUENCIA||'.NEXTVAL FROM DUAL';

    EXECUTE IMMEDIATE LV_sql INTO LN_secuencia;
    RETURN LN_secuencia ;

END VE_REC_SECUENCIA_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_MAX_FACT_CONT_FN    (SN_COD_ERROR      OUT NOCOPY NUMBER,
                                 SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
                                 SV_SQL            OUT NOCOPY VARCHAR2
) RETURN NUMBER
IS

  LN_max_fact_cont  number;

BEGIN

    SV_SQL:='';

    LN_max_fact_cont := 0;

    SV_SQL:=  ' select val_parametro';
    SV_SQL:= SV_SQL || ' into LN_max_fact_cont ';
    SV_SQL:= SV_SQL || ' from ged_parametros ';
    SV_SQL:= SV_SQL || ' where nom_parametro = '''|| CV_nom_fact_cont ||'''';
    SV_SQL:= SV_SQL || ' and cod_modulo      = '''|| CV_cod_modulo ||'''';
    SV_SQL:= SV_SQL || ' and cod_producto    = '''|| CN_cod_producto ||'''';

    select val_parametro
    into LN_max_fact_cont
    from ged_parametros
    where nom_parametro= CV_nom_fact_cont
    and cod_modulo     = CV_cod_modulo
    and cod_producto   = CN_cod_producto;

    RETURN LN_max_fact_cont;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 114;
         SV_MENS_RETORNO := 'VE_MAX_FACT_CONT_FN' ||' : '||SQLERRM;
         RETURN 0;
END VE_MAX_FACT_CONT_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/

FUNCTION VE_REC_CICLO_FN    (EN_COD_CICLFACT   IN FA_CICLFACT.COD_CICLFACT%TYPE,
                             SN_COD_ERROR      OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO   OUT NOCOPY VARCHAR2,
                             SV_SQL            OUT NOCOPY VARCHAR2
) RETURN NUMBER
IS

  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;

BEGIN

    SV_SQL:='';

    SELECT   ciclo.cod_ciclo
    INTO   LN_cod_ciclo
    FROM   fa_ciclfact ciclo
    WHERE  ciclo.cod_ciclfact  =  en_cod_ciclfact;

    RETURN LN_cod_ciclo;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_ERROR    := 2449;
         SV_MENS_RETORNO := 'VE_REC_CICLO_FN';
         RETURN 0;
    WHEN OTHERS THEN
         SN_COD_ERROR    := 2438;
         SV_MENS_RETORNO := 'VE_REC_CICLO_FN' ||' : '||SQLERRM;
         RETURN 0;


END VE_REC_CICLO_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/

FUNCTION VE_REC_FA_HIST_FN  (EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                             EN_MAXFACT          IN NUMBER,
                             EM_TABLA            IN OUT NOCOPY TIP_ENLACE_HIST_LIST,
                             SN_COD_ERROR        OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO     OUT NOCOPY VARCHAR2,
                             SV_SQL              OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS


  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;

BEGIN

    SV_SQL:='';

    select hst.fa_histconc
    BULK   COLLECT INTO EM_TABLA
    from fa_enlacehist hst
    where hst.cod_ciclfact in (select distinct clie.cod_ciclfact
                  from ga_infaccel clie, fa_ciclfact fac
                  where clie.cod_cliente = en_cod_cliente
                  and   clie.cod_ciclfact = fac.cod_ciclfact
                  and   fac.fec_emision between add_months(trunc(sysdate),en_maxfact) and trunc(sysdate));


    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 2454;
         SV_MENS_RETORNO := 'VE_REC_FA_HIST_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_REC_FA_HIST_FN ;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_REC_MTO_FACT_FN (EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                             EV_FA_HISTOCONC     IN VARCHAR2,
                             EM_TABLA            IN OUT NOCOPY TIP_MTO_FACTURA_LIST,
                             SN_COD_ERROR        OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO     OUT NOCOPY VARCHAR2,
                             SV_SQL              OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS


  LN_cod_ciclo  fa_ciclfact.cod_ciclo%TYPE;

BEGIN

    SV_SQL:='';


    SV_SQL:='select sum(imp_concepto)';
    SV_SQL:= SV_SQL || ' from '||EV_FA_HISTOCONC||'  a , fa_histdocu b, ga_abocel c, fa_conceptos d ';
    SV_SQL:= SV_SQL || ' where a.ind_ordentotal= b.ind_ordentotal';
    SV_SQL:= SV_SQL || ' and a.cod_concepto = d.cod_concepto';
    SV_SQL:= SV_SQL || ' and a.num_abonado  = c.num_abonado';
    SV_SQL:= SV_SQL || ' and b.cod_cliente  =' || EN_COD_CLIENTE;
    SV_SQL:= SV_SQL || ' and c.cod_cliente  = b.cod_cliente ';
    SV_SQL:= SV_SQL || ' and c.cod_situacion not in ('''||CV_cod_situabaa||''')';
    SV_SQL:= SV_SQL || ' and a.cod_tipconce ='|| CN_cod_tipconce;
    SV_SQL:= SV_SQL || ' and a.num_venta    ='|| CN_num_venta;
    SV_SQL:= SV_SQL || ' and a.cod_producto ='|| CN_cod_producto;

    EXECUTE IMMEDIATE SV_SQL BULK COLLECT INTO EM_TABLA;

    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 2454;
         SV_MENS_RETORNO := 'VE_REC_MTO_FACT_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_REC_MTO_FACT_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_OBTIENE_MEDIA_FACT_FN(EN_COD_CLIENTE   IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                   SN_MED_FACTURA  OUT NUMBER,
                                   SN_COD_ERROR    OUT NOCOPY NUMBER,
                                   SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                                   SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
  I                     NUMBER;
  LV_MAXFACT            NUMBER;
  LV_FACTMAX            NUMBER;
  LN_MTO_FACTURA        NUMBER;
  LN_MAX_POND           NUMBER;
  LN_MAX_ENLACE         NUMBER;
  EM_ENLACE_HIST        TIP_ENLACE_HIST_LIST;
  EM_MTO_FACTURA        TIP_MTO_FACTURA_LIST;
  ERROR_FUNCION         EXCEPTION;
BEGIN
    SV_SQL:='';

    LV_MAXFACT := VE_MAX_FACT_CONT_FN (SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL);
    LV_FACTMAX := LV_MAXFACT;
    LV_MAXFACT := -(LV_MAXFACT);
    --LV_MAXFACT := -50;
    IF SN_COD_ERROR <0 THEN
        RAISE ERROR_FUNCION;
    END IF;


    IF NOT VE_REC_FA_HIST_FN  (EN_COD_CLIENTE,LV_MAXFACT,EM_ENLACE_HIST,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
        RAISE ERROR_FUNCION;
    END IF;

    LN_MAX_ENLACE:=EM_ENLACE_HIST.COUNT ;

    IF LV_FACTMAX <=LN_MAX_ENLACE  THEN
        LN_MTO_FACTURA := 0;
        LN_MAX_POND    := 0;
        FOR I IN 1..LV_FACTMAX LOOP
            IF NOT VE_REC_MTO_FACT_FN  (EN_COD_CLIENTE,EM_ENLACE_HIST(I).FA_HISTCONC,EM_MTO_FACTURA,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
            -- IF NOT VE_REC_MTO_FACT_FN  (EN_COD_CLIENTE,'FA_HISTCONC_10108',EM_MTO_FACTURA,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN

                RAISE ERROR_FUNCION;
            ELSE
                IF EM_MTO_FACTURA(1).MTO_FACTURA > 0 THEN
                    LN_MTO_FACTURA:= LN_MTO_FACTURA + EM_MTO_FACTURA(1).MTO_FACTURA;
                    LN_MAX_POND   := LN_MAX_POND + 1;
                END IF;
            END IF;
        END LOOP;

        IF LN_MAX_POND > 0 THEN
            SN_MED_FACTURA := LN_MTO_FACTURA / LN_MAX_POND;
        ELSE
            SN_MED_FACTURA := 0;
        END IF;
     ELSE
        SN_MED_FACTURA := -1;
     END IF;

    RETURN TRUE;
EXCEPTION
        WHEN ERROR_FUNCION THEN
         RETURN FALSE;

END VE_OBTIENE_MEDIA_FACT_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_REC_CLIE_FN  (EN_COD_CLIENTE     IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                          EN_COD_CLIENTE_FIN IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                          SN_COD_ERROR       OUT NOCOPY NUMBER,
                          SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                          SV_SQL             OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

BEGIN

    SV_SQL:='';

    IF EN_COD_CLIENTE IS NULL THEN
        SV_SQL := 'select a.cod_cliente from ge_clientes a ';
        SV_SQL := SV_SQL || ' where a.ind_alta = '''|| CV_ind_alta_pos || '''';
        SV_SQL := SV_SQL || ' and   a.cod_calificacion != '''|| CV_cod_cred_exc  || '''';
    ELSE
        SV_SQL := 'select a.cod_cliente from ge_clientes a ';
        SV_SQL := SV_SQL || ' where a.ind_alta = '''|| CV_ind_alta_pos || '''';
        SV_SQL := SV_SQL || ' and   a.cod_calificacion != '''|| CV_cod_cred_exc  || '''';
        IF EN_COD_CLIENTE_FIN IS NULL THEN
            SV_SQL := SV_SQL || ' and   a.cod_cliente = '|| en_cod_cliente ;
        ELSE
          SV_SQL := SV_SQL || ' and   a.cod_cliente between '|| en_cod_cliente ||' and '||en_cod_cliente_fin;
        END IF;
    END IF;


    RETURN TRUE;

END VE_REC_CLIE_FN ;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_VAL_CLIENTE_FN  (EN_COD_CLIENTE     IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                             SN_COD_ERROR       OUT NOCOPY NUMBER,
                             SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                             SV_SQL             OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

  ln_exis NUMBER;
  ln_prep NUMBER;
  ln_excp NUMBER;
  ln_abon NUMBER;
  ln_alta NUMBER;
  ln_baja NUMBER;
  ln_tup  NUMBER;
  ln_aexc NUMBER;
  ln_valr NUMBER;


BEGIN

    SV_SQL:='';


        SV_SQL:=' SELECT COUNT(1)';
        SV_SQL:=SV_SQL ||' INTO  ln_exis';
        SV_SQL:=SV_SQL ||' FROM  ge_clientes a';
        SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;

        SELECT COUNT(1)
        INTO  ln_exis
        FROM  ge_clientes a
        WHERE a.cod_cliente = en_cod_cliente;

        IF ln_exis > 0 THEN

            SV_SQL:=' SELECT COUNT(1)';
            SV_SQL:=SV_SQL ||' INTO  ln_prep';
            SV_SQL:=SV_SQL ||' FROM  ga_aboamist a';
            SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;
            SV_SQL:=SV_SQL ||' AND   a.cod_situacion NOT IN ('''|| CV_cod_situabaa || ''',''' || CV_cod_situabap ||''')';

            SELECT COUNT(1)
            INTO  ln_prep
            FROM  ga_aboamist a
            WHERE a.cod_cliente = en_cod_cliente
            AND   a.cod_situacion NOT IN (CV_cod_situabaa, CV_cod_situabap);

            IF ln_prep = 0 THEN

                SV_SQL:=' SELECT COUNT(1)';
                SV_SQL:=SV_SQL ||' INTO  ln_excp';
                SV_SQL:=SV_SQL ||' from ge_clientes a ';
                SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;
                SV_SQL :=SV_SQL|| ' and  a.ind_alta = '''|| CV_ind_alta_pos || '''';
                SV_SQL :=SV_SQL|| ' and   a.cod_crediticia = '''|| CV_cod_cred_exc  || '''';

                select count(1)
                INTO  ln_excp
                from ge_clientes a
                where a.cod_cliente = en_cod_cliente
                and   a.ind_alta = CV_ind_alta_pos
                and   a.cod_crediticia = CV_cod_cred_exc;

                IF ln_excp = 0 THEN

                    SV_SQL:=' SELECT COUNT(1)';
                    SV_SQL:=SV_SQL ||' INTO  ln_abon';
                    SV_SQL:=SV_SQL ||' FROM  ga_abocel a';
                    SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;

                    SELECT COUNT(1)
                    INTO  ln_abon
                    FROM  ga_abocel a
                    WHERE a.cod_cliente = en_cod_cliente;

                    IF ln_abon > 0 THEN

                        SV_SQL:=' SELECT COUNT(1)';
                        SV_SQL:=SV_SQL ||' INTO  ln_alta';
                        SV_SQL:=SV_SQL ||' FROM  ga_abocel a';
                        SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;
                        SV_SQL:=SV_SQL ||' AND   NOT EXISTS (SELECT 1 FROM ve_excepcion_planes_td b';
                        SV_SQL:=SV_SQL ||'                   WHERE a.cod_plantarif = b.cod_plantarif)';
                        SV_SQL:=SV_SQL ||' AND   a.cod_situacion NOT IN ('''|| CV_cod_situabaa || ''',''' || CV_cod_situabap ||''')';
                        SV_SQL:=SV_SQL ||' AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=0)';


                        SELECT COUNT(1)
                        INTO  ln_alta
                        FROM  ga_abocel a
                        WHERE a.cod_cliente = en_cod_cliente
                        AND   NOT EXISTS (SELECT 1 FROM ve_excepcion_planes_td b
                                          WHERE a.cod_plantarif = b.cod_plantarif)
                        AND   a.cod_situacion NOT IN (CV_cod_situabaa, CV_cod_situabap)
                        AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=0);



                        IF ln_alta > 0 THEN
                            ln_valr := 0;   -- Cliente valido para procesar
                        ELSE

                            SV_SQL:=' SELECT COUNT(1)';
                            SV_SQL:=SV_SQL ||' INTO  ln_tup';
                            SV_SQL:=SV_SQL ||' FROM  ga_abocel a';
                            SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;
                            SV_SQL:=SV_SQL ||' AND   a.cod_situacion NOT IN ('''|| CV_cod_situabaa || ''',''' || CV_cod_situabap ||''')';
                            SV_SQL:=SV_SQL ||' AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=1)';

                            SELECT COUNT(1)
                            INTO  ln_tup
                            FROM  ga_abocel a
                            WHERE a.cod_cliente = en_cod_cliente
                            AND   a.cod_situacion NOT IN (CV_cod_situabaa, CV_cod_situabap)
                            AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=1);

                            SV_SQL:=' SELECT COUNT(1)';
                            SV_SQL:=SV_SQL ||' INTO  ln_aexc';
                            SV_SQL:=SV_SQL ||' FROM  ga_abocel a';
                            SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;
                            SV_SQL:=SV_SQL ||' AND   EXISTS (SELECT 1 FROM ve_excepcion_planes_td b';
                            SV_SQL:=SV_SQL ||'              WHERE a.cod_plantarif = b.cod_plantarif)';
                            SV_SQL:=SV_SQL ||' AND   a.cod_situacion NOT IN ('''|| CV_cod_situabaa || ''',''' || CV_cod_situabap ||''')';

                            SELECT COUNT(1)
                            INTO  ln_aexc
                            FROM  ga_abocel a
                            WHERE a.cod_cliente = en_cod_cliente
                            AND   EXISTS (SELECT 1 FROM ve_excepcion_planes_td b
                                          WHERE a.cod_plantarif = b.cod_plantarif)
                            AND   a.cod_situacion NOT IN (CV_cod_situabaa, CV_cod_situabap);

                            IF ln_tup > 0 and ln_aexc = 0  THEN
                                ln_valr := 1121;   -- Cliente posee todos los abonados con tipo de prestación TUP.
                            ELSIF ln_tup = 0 and ln_aexc > 0 THEN
                                ln_valr := 1122;   -- Cliente posee todos los abonados con planes tarifarios excepcionados..
                            ELSIF ln_tup = 0 and ln_aexc = 0 THEN
                                ln_valr := 0;   -- Cliente valido
                            ELSE
                                ln_valr := 1112;-- Cliente  no cumple las condiciones principales para ser procesado
                            END IF;
                        END IF;
                    ELSE
                        ln_valr := 1111;   -- Cliente no posee abonados.
                    END IF;
                ELSE
                    ln_valr := 1120; -- Cliente excepcionado
                END IF;
            ELSE
                ln_valr := 314;   -- Cliente es Prepago
            END IF;
        ELSE
             ln_valr := 1965;   -- Cliente no existe
        END IF;

    SN_COD_ERROR := ln_valr;

    IF ln_valr = 0 THEN
        RETURN TRUE;
    ELSE
       RETURN FALSE;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 2687;
         SV_MENS_RETORNO := 'VE_VAL_CLIENTE_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_VAL_CLIENTE_FN ;

/*---------------------------------------------------------------------------------------------------------------------------------*/

FUNCTION VE_VAL_CLIE_ABO_FN  (EN_COD_CLIENTE     IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                              SN_COD_ERROR       OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                              SV_SQL             OUT NOCOPY VARCHAR2
) RETURN NUMBER
IS

  ln_baja NUMBER;
  ln_alta NUMBER;
  ln_valr NUMBER;


BEGIN

        SV_SQL:='';

        SV_SQL:=' SELECT COUNT(1)';
        SV_SQL:=SV_SQL ||' INTO  ln_alta';
        SV_SQL:=SV_SQL ||' FROM  ga_abocel a';
        SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;
        SV_SQL:=SV_SQL ||' AND   NOT EXISTS (SELECT 1 FROM ve_excepcion_planes_td b';
        SV_SQL:=SV_SQL ||'                   WHERE a.cod_plantarif = b.cod_plantarif)';
        SV_SQL:=SV_SQL ||' AND   a.cod_situacion NOT IN ('''|| CV_cod_situabaa || ''',''' || CV_cod_situabap ||''')';
        SV_SQL:=SV_SQL ||' AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=0)';


        SELECT COUNT(1)
        INTO  ln_alta
        FROM  ga_abocel a
        WHERE a.cod_cliente = en_cod_cliente
        AND   NOT EXISTS (SELECT 1 FROM ve_excepcion_planes_td b
                          WHERE a.cod_plantarif = b.cod_plantarif)
        AND   a.cod_situacion NOT IN (CV_cod_situabaa, CV_cod_situabap)
        AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=0);


        SV_SQL:=' SELECT COUNT(1)';
        SV_SQL:=SV_SQL ||' INTO  ln_baja';
        SV_SQL:=SV_SQL ||' FROM  ga_abocel a';
        SV_SQL:=SV_SQL ||' WHERE a.cod_cliente ='|| en_cod_cliente;
        SV_SQL:=SV_SQL ||' AND   NOT EXISTS (SELECT 1 FROM ve_excepcion_planes_td b';
        SV_SQL:=SV_SQL ||'                   WHERE a.cod_plantarif = b.cod_plantarif)';
        SV_SQL:=SV_SQL ||' AND   a.cod_situacion IN ('''|| CV_cod_situabaa || ''',''' || CV_cod_situabap ||''')';
        SV_SQL:=SV_SQL ||' AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=0)';

        SELECT  COUNT(1)
        INTO    ln_baja
        FROM    ga_abocel a
        WHERE   a.cod_cliente = en_cod_cliente
        AND     NOT EXISTS (SELECT 1 FROM ve_excepcion_planes_td b
                            WHERE a.cod_plantarif = b.cod_plantarif)
        AND   a.cod_situacion IN (CV_cod_situabaa, CV_cod_situabap)
        AND   nvl(a.cod_prestacion,0) in  (select cod_prestacion from ge_prestaciones_td where ind_excep_proceso=0);


        IF ln_baja = 0 AND  ln_alta = 0 THEN
           ln_valr := 0;     -- No cumple las condiciones
        ELSIF ln_alta > 0 THEN
           ln_valr := 1;     -- Posee abonados a procesar
        ELSIF ln_alta = 0 AND ln_baja > 0 THEN
           ln_valr := 2;     -- Todos los abonado estan de baja
        END IF;

    RETURN ln_valr;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 2687;
         SV_MENS_RETORNO := 'VE_VAL_CLIE_ABO_FN' ||' : '||SQLERRM;
         RETURN -1;
END VE_VAL_CLIE_ABO_FN ;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_REG_CLIE_HIST_FN (EN_COD_CLIENTE  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                              SN_COD_ERROR    OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
  EM_TABLA TIP_GE_MTOPREAUTOCLI_TH;
BEGIN

    SV_SQL:='';
    SV_SQL:='    SELECT   td.COD_CLIENTE';
    SV_SQL:=SV_SQL || '         ,td.MTO_PREAUTO';
    SV_SQL:=SV_SQL || '         ,td.COD_CREDITICIA';
    SV_SQL:=SV_SQL || '         ,td.FEC_MODIFICACION';
    SV_SQL:=SV_SQL || '         ,td.NOM_USUARORA';
    SV_SQL:=SV_SQL || ' BULK COLLECT INTO EM_TABLA';
    SV_SQL:=SV_SQL || ' FROM ge_mtopreautocli_th td';
    SV_SQL:=SV_SQL || ' WHERE th.cod_cliente = '|| en_cod_cliente;
    SELECT   td.COD_CLIENTE
            ,td.MTO_PREAUTO
            ,td.COD_CREDITICIA
            ,td.FEC_MODIFICACION
            ,td.NOM_USUARORA
    BULK COLLECT INTO EM_TABLA
    FROM ge_mtopreautocli_to td
    WHERE td.cod_cliente =  en_cod_cliente;

    FORALL i IN 1..EM_TABLA.COUNT
    INSERT INTO GE_MTOPREAUTOCLI_TH VALUES EM_TABLA(i);

    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 115;
         SV_MENS_RETORNO := 'VE_REG_CLIE_HIST_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_REG_CLIE_HIST_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_DEL_CLASIF_FN (SN_COD_ERROR    OUT NOCOPY NUMBER,
                           SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                           SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
    ln_valor              NUMBER;
    ERROR_FUNCION         EXCEPTION;
BEGIN

    SV_SQL:='';
    SV_SQL:=' select count(cod_valor) into ln_valor';
    SV_SQL:=SV_SQL || ' from GE_CREDITICIA_TD';
    

    select count(1)
    INTO ln_valor
    from GE_CREDITICIA_TD a
    where not exists (select 1 from ge_factorclasif_td b
                     where b.cod_clasif= a.COD_CREDITICIA);

    IF ln_valor > 0 THEN
        RAISE ERROR_FUNCION;
    END IF;

    RETURN TRUE;

EXCEPTION
    WHEN ERROR_FUNCION THEN
         SN_COD_ERROR    := 1125;
         SV_MENS_RETORNO := 'VE_DEL_CLASIF_FN';
         RETURN FALSE;
    WHEN OTHERS THEN
         SN_COD_ERROR    := 1124;
         SV_MENS_RETORNO := 'VE_DEL_CLASIF_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_DEL_CLASIF_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_DEL_CLIE_FN (EN_COD_CLIENTE  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                         SN_COD_ERROR    OUT NOCOPY NUMBER,
                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                         SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
BEGIN

    SV_SQL:='';
    SV_SQL:=' DELETE FROM ge_mtopreautocli_to th';
    SV_SQL:=SV_SQL || ' WHERE th.cod_cliente = '|| en_cod_cliente;

    DELETE FROM ge_mtopreautocli_to mto
    WHERE mto.cod_cliente =  en_cod_cliente;

    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := -1;
         SV_MENS_RETORNO := 'VE_DEL_CLIE_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_DEL_CLIE_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_REC_DTOS_CLIE_FN (EM_TABLA         IN OUT TIP_GE_MTOPREAUTOCLI_TO,
                              EN_MED_FACT      IN NUMBER,
                              SN_COD_ERROR    OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
  LN_COD_CLIENTE GE_CLIENTES.COD_CLIENTE%TYPE;
BEGIN

    SV_SQL:='';

    ln_cod_cliente := EM_TABLA(1).COD_CLIENTE;

    select co.cod_cliente
         ,(fc.porc_pre_aut*en_med_fact)/100
         ,fc.cod_clasif
         ,sysdate
         ,user
    BULK COLLECT INTO EM_TABLA
    from co_morosos co, ge_factorclasif_td fc
    where  co.cod_cliente  = ln_cod_cliente
    and   trunc(sysdate) - trunc(co.fec_ingreso) between fc.dias_mora_ini and fc.dias_mora_fin;

    IF EM_TABLA.COUNT = 0 THEN
        select ln_cod_cliente
             ,(fc.porc_pre_aut*en_med_fact)/100
             ,fc.cod_clasif
             ,sysdate
             ,user
        BULK COLLECT INTO EM_TABLA
        from   ge_factorclasif_td fc
        where  fc.cod_clasif = CV_calif_cred_a;
    END IF;
    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 1117;
         SV_MENS_RETORNO := 'VE_REC_DTOS_CLIE_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_REC_DTOS_CLIE_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_REG_CLIE_FN (EM_TABLA        IN  TIP_GE_MTOPREAUTOCLI_TO,
                         SN_COD_ERROR    OUT NOCOPY NUMBER,
                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                         SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

BEGIN

    SV_SQL:='';
    FORALL i IN 1..EM_TABLA.COUNT 
    INSERT INTO GE_MTOPREAUTOCLI_TO VALUES EM_TABLA(i);

    FOR i IN 1..EM_TABLA.COUNT LOOP
        UPDATE GE_CLIENTES SET COD_CREDITICIA=EM_TABLA(i).COD_CREDITICIA
        WHERE COD_CLIENTE=EM_TABLA(i).COD_CLIENTE;
    END LOOP;

    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR      := 1118;
         SV_MENS_RETORNO := 'VE_REG_CLIE_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_REG_CLIE_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_GED_PARAMETROS_FN(EV_NOM_PARAMETRO   IN  VARCHAR2,
                              EV_COD_MODULO      IN  VARCHAR2,
                              EN_COD_PRODUCTO    IN  VARCHAR2,
                              SV_DES_PARAMETRO   OUT VARCHAR2,
                              SN_COD_ERROR       OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                              SV_SQL             OUT NOCOPY VARCHAR2

) RETURN VARCHAR2
IS
   LV_VAL_PARAMETRO VARCHAR2(20);
BEGIN

    SV_SQL := ' SELECT VAL_PARAMETRO,DES_PARAMETRO';
    SV_SQL := SV_SQL || ' FROM   GED_PARAMETROS';
    SV_SQL := SV_SQL || ' WHERE  NOM_PARAMETRO =''' || EV_NOM_PARAMETRO ||'''';
    SV_SQL := SV_SQL || ' AND    COD_MODULO   = ''' || EV_COD_MODULO ||'''';
    SV_SQL := SV_SQL || ' AND    COD_PRODUCTO   = ' || EN_COD_PRODUCTO;

    SELECT VAL_PARAMETRO, DES_PARAMETRO
    INTO   LV_VAL_PARAMETRO,SV_DES_PARAMETRO
    FROM   GED_PARAMETROS
    WHERE  NOM_PARAMETRO = EV_NOM_PARAMETRO
    AND    COD_MODULO    = EV_COD_MODULO
    AND    COD_PRODUCTO  = EN_COD_PRODUCTO;

    RETURN LV_VAL_PARAMETRO;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
         SN_COD_ERROR    := 1362;
         SV_MENS_RETORNO := 'VE_GED_PARAMETROS_FN' ||' : '||' NO SE ENCUENTRA PARAMETROS DE SERVIDOR DE CORREOS.';
         RETURN '';
    WHEN OTHERS THEN
         SN_COD_ERROR    := 1362;
         SV_MENS_RETORNO := 'VE_GED_PARAMETROS_FN' ||' : '||SQLERRM;
         RETURN '';
END VE_GED_PARAMETROS_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_EMAIL_USU_FN(EM_TABLA        OUT TIP_EMAIL_USU_LIST,
                         SN_COD_ERROR    OUT NOCOPY NUMBER,
                         SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                         SV_SQL          OUT NOCOPY VARCHAR2

) RETURN BOOLEAN
IS
   LV_EMAIL VARCHAR2(100);
BEGIN

        SV_SQL := ' SELECT NOM_EMAIL';
        SV_SQL := SV_SQL || ' FROM GE_SEG_USUARIO A , GE_USUARIO_APLIC_TD B';
        SV_SQL := SV_SQL || ' WHERE A.NOM_USUARIO = B.NOM_USUARIO';
        SV_SQL := SV_SQL || ' AND    B.COD_PROGRAMA =''' || CV_cod_programa ||'''';


         SELECT A.NOM_EMAIL
         BULK COLLECT INTO EM_TABLA
         FROM GE_SEG_USUARIO A , GE_USUARIO_APLIC_TD B
         WHERE A.NOM_USUARIO = B.NOM_USUARIO
         AND    B.COD_PROGRAMA = CV_cod_programa;



    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 119;
         SV_MENS_RETORNO := 'VE_EMAIL_USU_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_EMAIL_USU_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_REC_INFO_CLIE_FN (EN_COD_CLIENTE  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                              SV_NOM_CLIENTE  OUT NOCOPY VARCHAR2,
                              SN_COD_ERROR    OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS
BEGIN

    SV_SQL:='';
    SV_SQL:=' select nom_cliente || '' '' || nom_apeclien1 || '' '' || nom_apeclien2';
    SV_SQL:=SV_SQL || ' from  ge_clientes';
    SV_SQL:=SV_SQL || ' where cod_cliente = '|| en_cod_cliente;

    select nom_cliente || ' ' || nom_apeclien1 || ' ' || nom_apeclien2
    INTO  SV_NOM_CLIENTE
    from  ge_clientes
    where cod_cliente =en_cod_cliente;

    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
         SN_COD_ERROR    := 2656;
         SV_MENS_RETORNO := 'VE_REC_INFO_CLIE_FN' ||' : '||SQLERRM;
         RETURN FALSE;
END VE_REC_INFO_CLIE_FN;
/*---------------------------------------------------------------------------------------------------------------------------------*/
FUNCTION VE_ENVIA_CORREO_FN  (EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                              EN_COD_CLIENTE_FIN  IN GE_CLIENTES.COD_CLIENTE%TYPE,
                              EV_CLASIF_CRED      IN VARCHAR2,
                              EN_MTO_PREAUTO      IN NUMBER,
                              SN_COD_ERROR    OUT NOCOPY NUMBER,
                              SV_MENS_RETORNO OUT NOCOPY VARCHAR2,
                              SV_SQL          OUT NOCOPY VARCHAR2
) RETURN BOOLEAN
IS

    LV_IPCORREO     VARCHAR2(20);
    LV_EMAIL        VARCHAR2(50);
    LV_EMAIL_USU    VARCHAR2(100);
    LV_NOM_CLIENTE  VARCHAR2(100);
    LV_DESC_PARAM   VARCHAR2(50);
    LV_Body         CLOB;
    EM_NOM_EMAIL    TIP_EMAIL_USU_LIST;
    ERROR_FUNCION   EXCEPTION;
BEGIN

        LV_EMAIL_USU := '';

        LV_IPCORREO := VE_GED_PARAMETROS_FN('IP_SERVCORREO',CV_cod_modulo,CN_cod_producto,LV_DESC_PARAM,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL);
        LV_EMAIL    := VE_GED_PARAMETROS_FN('DIREMAIL_CC_MPA',CV_cod_modulo,CN_cod_producto,LV_DESC_PARAM,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL);
        LV_EMAIL    := LV_DESC_PARAM;
        IF EN_COD_CLIENTE IS NOT NULL THEN
           IF NOT VE_REC_INFO_CLIE_FN(EN_COD_CLIENTE,LV_NOM_CLIENTE,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
               RAISE ERROR_FUNCION;
           END IF;
        END IF;

        IF NOT VE_EMAIL_USU_FN(EM_NOM_EMAIL,SN_COD_ERROR,SV_MENS_RETORNO,SV_SQL) THEN
            RAISE ERROR_FUNCION;
        END IF;

        FOR i IN 1..EM_NOM_EMAIL.COUNT LOOP
            IF LENGTH(EM_NOM_EMAIL(i).NOM_EMAIL)> 0 THEN
                LV_Body  := 'Estimado:' ||chr(13);
                LV_Body  := LV_Body  ||chr(13)|| 'Con fecha ' || TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS');
                LV_Body  := LV_Body  ||chr(13)|| 'Se ha realizado el proceso de actualización de clasificación crediticia (CC) y monto preautorizado (MPA).' ||chr(13);
                IF (EN_COD_CLIENTE IS NOT NULL) AND (EN_COD_CLIENTE_FIN IS NULL) THEN
                    LV_Body  := LV_Body ||chr(13)|| 'Código de Cliente: ' || TO_CHAR(EN_COD_CLIENTE)||chr(13);
                    LV_Body  := LV_Body ||chr(13)|| 'Nombre de Cliente: ' ||LV_NOM_CLIENTE||chr(13);
                    LV_Body  := LV_Body ||chr(13)|| 'Clasificación Crediticia: ' ||EV_CLASIF_CRED||chr(13);
                    LV_Body  := LV_Body ||chr(13)|| 'Monto preautorizado: ' || TO_CHAR(EN_MTO_PREAUTO);
                ELSIF (EN_COD_CLIENTE IS NOT NULL) AND (EN_COD_CLIENTE_FIN IS NOT NULL) THEN
                    LV_Body  := LV_Body ||chr(13)|| 'La evaluación corresponde al rango clientes entre:' || TO_CHAR(EN_COD_CLIENTE)||' y '|| TO_CHAR(EN_COD_CLIENTE_FIN)||chr(13);
                END IF;
                LV_Body  := LV_Body ||chr(13)|| 'Nota:';
                LV_Body  := LV_Body ||chr(13)|| 'Este correo es generado de manera automatica, por favor no lo conteste.';
                --VE_SERVICIOS_VENTA_PG.VE_ENVIAR_CORREO_PR(LV_EMAIL,'jorge.marin@soc.tm-mas.com',CV_subject,LV_Body,LV_IPCORREO);
                VE_SERVICIOS_VENTA_PG.VE_ENVIAR_CORREO_PR(LV_EMAIL,EM_NOM_EMAIL(i).NOM_EMAIL,CV_subject,LV_Body,LV_IPCORREO);
             END IF;

        END LOOP;

        RETURN TRUE;

EXCEPTION
        WHEN ERROR_FUNCION THEN
        RETURN FALSE;
END VE_ENVIA_CORREO_FN;

/*---------------------------------------------------------------------------------------------------------------------------------*/
PROCEDURE VE_CLASIF_CREDIT_PR(EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
                              EN_COD_CLIENTE_FIN  IN GE_CLIENTES.COD_CLIENTE%TYPE,
                              SV_MENS_RETORNO    OUT NOCOPY VARCHAR2,
                              SN_NUM_EVENTO      OUT NOCOPY NUMBER )
IS
  LV_Sql                VARCHAR2(2000);
  LV_MENSAJE_RETORNO    VARCHAR(100);
  LN_COD_ERROR          NUMBER:= 0;
  I                     NUMBER;
  LN_PROCESO            NUMBER;
  LN_N_MED_FACTURA      NUMBER;
  EM_CLIENTES           TIP_CLIENTE_LIST;
  EM_GE_MTOPREAUTOCLI   TIP_GE_MTOPREAUTOCLI_TO;
  LB_PROCESO            BOOLEAN;
  ERROR_FUNCION         EXCEPTION;
  lCursor               refCursor;
BEGIN
    LV_Sql:='';
    LB_PROCESO := FALSE;
    SN_NUM_EVENTO := 0;
    SV_MENS_RETORNO := '';
    IF NOT VE_DEL_CLASIF_FN  (LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
        RAISE ERROR_FUNCION;
    END IF;


    IF EN_COD_CLIENTE IS NOT NULL AND EN_COD_CLIENTE_FIN IS NULL THEN
        IF NOT VE_VAL_CLIENTE_FN  (EN_COD_CLIENTE,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
            RAISE ERROR_FUNCION;
        END IF;
    END IF;


    IF NOT VE_REC_CLIE_FN  (EN_COD_CLIENTE,EN_COD_CLIENTE_FIN,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
        RAISE ERROR_FUNCION;
    END IF;

    OPEN  lCursor  for LV_SQL;
    LOOP
        FETCH lCursor BULK COLLECT INTO EM_CLIENTES LIMIT 50000;
        FOR i IN 1..EM_CLIENTES.COUNT LOOP
            LN_PROCESO := VE_VAL_CLIE_ABO_FN(EM_CLIENTES(i).COD_CLIENTE,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL);
            IF LN_PROCESO <> CN_no_procc THEN
                IF NOT VE_OBTIENE_MEDIA_FACT_FN(EM_CLIENTES(i).COD_CLIENTE,LN_N_MED_FACTURA,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
                    RAISE ERROR_FUNCION;
                END IF;

                IF LN_N_MED_FACTURA != -1  THEN
                    IF NOT VE_REG_CLIE_HIST_FN(EM_CLIENTES(i).COD_CLIENTE,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
                        RAISE ERROR_FUNCION;
                    END IF;
                    IF NOT VE_DEL_CLIE_FN(EM_CLIENTES(i).COD_CLIENTE,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
                        RAISE ERROR_FUNCION;
                    END IF;
                    EM_GE_MTOPREAUTOCLI(1).COD_CLIENTE :=EM_CLIENTES(i).COD_CLIENTE;
                    IF NOT VE_REC_DTOS_CLIE_FN(EM_GE_MTOPREAUTOCLI,LN_N_MED_FACTURA,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
                        RAISE ERROR_FUNCION;
                    END IF;


                    IF LN_PROCESO = CN_clie_baja THEN
                        EM_GE_MTOPREAUTOCLI(1).MTO_PREAUTO:=0;
                        EM_GE_MTOPREAUTOCLI(1).COD_CREDITICIA  := CV_calif_cred_baja;
                    END IF;

                    IF NOT (LN_N_MED_FACTURA = -1 AND  EM_GE_MTOPREAUTOCLI(1).COD_CREDITICIA = CV_calif_cred_a)  THEN
                        IF NOT VE_REG_CLIE_FN(EM_GE_MTOPREAUTOCLI,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
                            RAISE ERROR_FUNCION;
                        END IF;
                    END IF;
                    LB_PROCESO := TRUE;
                END IF;
            END IF;
        END LOOP;
        EXIT WHEN lCursor%NOTFOUND ;
    END LOOP;
    CLOSE lCursor;

    IF EN_COD_CLIENTE IS NOT NULL AND EN_COD_CLIENTE_FIN IS NULL THEN
       IF LN_N_MED_FACTURA = -1 THEN
          LN_COD_ERROR := 1113;
          RAISE ERROR_FUNCION;
       END IF;
    END IF;

    IF LB_PROCESO THEN
        IF NOT VE_ENVIA_CORREO_FN(EN_COD_CLIENTE,EN_COD_CLIENTE_FIN,EM_GE_MTOPREAUTOCLI(1).COD_CREDITICIA,EM_GE_MTOPREAUTOCLI(1).MTO_PREAUTO,LN_COD_ERROR,SV_MENS_RETORNO,LV_SQL) THEN
            RAISE ERROR_FUNCION;
        END IF;
    END IF;

EXCEPTION
        WHEN ERROR_FUNCION THEN
                LV_MENSAJE_RETORNO:= SV_MENS_RETORNO;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_COD_ERROR,SV_MENS_RETORNO) THEN
                       SV_MENS_RETORNO := CV_error_no_clasif;
                END IF;
                SV_MENS_RETORNO := SV_MENS_RETORNO || ' ' || LV_MENSAJE_RETORNO;
                SN_NUM_EVENTO   := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'VE_UPD_INFO_CLIENTES_PG', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
                ROLLBACK;
        WHEN OTHERS THEN
                LV_MENSAJE_RETORNO:= SV_MENS_RETORNO;
                IF NOT GE_ERRORES_PG.MENSAJEERROR(LN_COD_ERROR,SV_MENS_RETORNO) THEN
                       SV_MENS_RETORNO := CV_error_no_clasif;
                END IF;
                SV_MENS_RETORNO := SV_MENS_RETORNO || ' ' || LV_MENSAJE_RETORNO;
                SN_NUM_EVENTO   := GE_ERRORES_PG.GRABARPL( SN_NUM_EVENTO, CV_COD_MODULO, SV_MENS_RETORNO, CV_VERSION, USER, 'VE_UPD_INFO_CLIENTES_PG', LV_Sql, LN_COD_ERROR, SV_MENS_RETORNO );
                ROLLBACK;
END VE_CLASIF_CREDIT_PR;

END VE_UPD_INFO_CLIENTES_PG;
/
SHOW ERRORS
