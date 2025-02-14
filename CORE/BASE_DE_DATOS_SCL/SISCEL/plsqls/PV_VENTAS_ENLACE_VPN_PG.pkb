CREATE OR REPLACE PACKAGE BODY Pv_ventas_enlace_vpn_Pg
AS

PROCEDURE PV_ACTUALIZA_RANGOSFIJOS_PR(
  EN_NUM_ABONADO        IN NUMBER,      -- Numero de Abonado
  EV_ACTUACION          IN VARCHAR2,     -- Codigo de Actuacion
  EV_USUARORA           IN VARCHAR2     -- Nombre de usuario
  )

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ACTUALIZA_RANGOSFIJOS_PR
      Lenguaje="PL/SQL"
      Fecha="09-06-2009"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción> Actualiza rangos fijos</Descripción>
      <Parámetros>
         <Entrada>
              <param nom="EN_NUM_ABONADO"            Tipo="Varchar2">Numero de Abonado       </param>
              <param nom="EV_ACTUACION"            Tipo="Varchar2">Codigo de Actuacion       </param>
              <param nom="EV_USUARORA"            Tipo="Varchar2">Nombre de usuario       </param>
         /Entrada>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;

    LN_NumError         NUMBER (2);   -- numero de error
    LV_MsgError         VARCHAR(60);  -- mensaje de error
    LB_CargoBasico        BOOLEAN;

    LV_cen_fijas        VARCHAR2(100);
    LV_pre_numfija      VARCHAR2(2);
    LV_enlace_fija      VARCHAR2(10);
    LN_cantpiloto       NUMBER(7);
    LN_cantidad         NUMBER(7);
    LN_cod_central      GA_ABOCEL.COD_CENTRAL%TYPE;
    LN_num_celular      GA_ABOCEL.NUM_CELULAR%TYPE;
    LN_cod_cliente      GA_ABOCEL.COD_CLIENTE%TYPE;
    LV_cod_plantarif    GA_ABOCEL.COD_PLANTARIF%TYPE;
    LV_cod_tecnologia   GA_ABOCEL.COD_TECNOLOGIA%TYPE;

    ERROR_CONTROLADO    EXCEPTION;

    LV_NomTabla         GA_ERRORES.NOM_TABLA%TYPE;
    LV_Nom_Proc         GA_ERRORES.NOM_PROC%TYPE;
    LV_Cod_Act             GA_ERRORES.COD_ACT%TYPE;
    LV_Cod_SQLCODE         GA_ERRORES.COD_SQLCODE%TYPE;
    LV_Cod_SQLERRM         GA_ERRORES.COD_SQLERRM%TYPE;
    LV_ERROR                 VARCHAR2(2);


    LN_cod_retorno      ge_errores_pg.CodError;
    LV_mens_retorno     ge_errores_pg.MsgError;
    LN_num_evento       ge_errores_pg.Evento;

    LN_Cont            NUMBER;
    LN_Columna         NUMBER;
    LN_Largo           NUMBER;
    LN_Pos1            NUMBER;
    LN_ValidaCenFija   NUMBER; --0 No es central fija 1 es central fija
    LV_Estado          GA_RANGOS_FIJOS_TO.ESTADO%TYPE;
    ----TYPE REFCURSOR     IS REF CURSOR;
    TYPE tipoArray     IS VARRAY(20) OF  VARCHAR2(30);
    LA_arregloSalida tipoArray := tipoArray();
    LC_RangosPiloto    REFCURSOR;
    LN_NumDesde       GA_NRO_PILOTO_RANGO_TO.NUM_DESDE%TYPE;

BEGIN

     -- Inicializacion de Variables
     LN_NumError:=0;
     LV_MsgError:='Operacion Exitosa';
     LV_Nom_Proc:='GA_PR_SUSPVOLUNT_FIJO';


     BEGIN
          LN_NumError := 11;
           LV_MsgError := 'Error al obtener datos en GED_PARAMETROS';
           LV_NomTabla:='GED_PARAMETROS';
     -- Obtenemos el parametro para ver si aplica el proyecto Ventas Enlace Fija P-MIX-09002
       SELECT VAL_PARAMETRO INTO LV_enlace_fija
       FROM GED_PARAMETROS
       WHERE NOM_PARAMETRO = 'ENLACE_FIJA'
         AND COD_MODULO='GA'
         AND COD_PRODUCTO=1;
       EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 RAISE ERROR_CONTROLADO;
     END;


     --- aplica el proyecto Ventas Enlace
     IF UPPER(RTRIM(LTRIM(LV_enlace_fija))) = 'TRUE' THEN

            LN_NumError := 12;
             LV_MsgError := 'Error al obtener datos en GA_ABOCEL';
             LV_NomTabla:='GA_ABOCEL';
        BEGIN
        -- Obtenemos datos del abonado
            SELECT a.cod_central,a.num_celular,a.cod_cliente, a.cod_plantarif, a.cod_tecnologia
            INTO  LN_cod_central, LN_num_celular, LN_cod_cliente, LV_cod_plantarif, LV_cod_tecnologia
            FROM GA_ABOCEL a
            WHERE a.NUM_ABONADO =EN_NUM_ABONADO
             AND a.IND_SUPERTEL <> 7;
          EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 RAISE ERROR_CONTROLADO;
        END;

        

            --- DIVISIBLE POR 100, el 1er digito es igual al valor de parametro a ver si es PILOTO
            IF  (MOD(LN_num_celular,100)) = 0 AND LV_pre_numfija = SUBSTR(LN_num_celular,1,1) THEN
                    -- Obtenemos el PILOTO
                    SELECT COUNT(1) INTO LN_cantpiloto
                    FROM GA_NRO_PILOTO_RANGO_TO
                    WHERE NUM_PILOTO = LN_num_celular;

                    IF LN_cantpiloto = 0 THEN
                       LN_NumError := 18;
                           LV_MsgError := 'No existen rangos asociados al numero Piloto';
                           LV_NomTabla:='GA_NRO_PILOTO_RANGO_TO';
                       RAISE ERROR_CONTROLADO;
                    END IF;


                    OPEN LC_RangosPiloto FOR
                    SELECT a.NUM_DESDE
                    FROM GA_NRO_PILOTO_RANGO_TO a
                    WHERE a.NUM_PILOTO = LN_num_celular;

                    IF (EV_ACTUACION = 'ST') THEN
                        LV_Estado := '4';
                        --Actualiza el estado de los rangos asociados al numero piloto
                        LOOP
                        FETCH LC_RangosPiloto INTO LN_NumDesde;
                        EXIT WHEN LC_RangosPiloto%NOTFOUND;
                            UPDATE GA_RANGOS_FIJOS_TO SET FECHA_SUSPENSION = SYSDATE,
                                                               FECHA_MODIFICACION = SYSDATE,
                                                          NOM_USUARORA = EV_USUARORA,
                                                          ESTADO = LV_Estado
                            WHERE NUM_DESDE = LN_NumDesde;
                        END LOOP;
                    ELSIF (EV_ACTUACION = 'RT') THEN
                        LV_Estado := '2';
                        --Actualiza el estado de los rangos asociados al numero piloto
                        LOOP
                        FETCH LC_RangosPiloto INTO LN_NumDesde;
                        EXIT WHEN LC_RangosPiloto%NOTFOUND;
                            UPDATE GA_RANGOS_FIJOS_TO SET FECHA_REHABILITACION = SYSDATE,
                                                          FECHA_MODIFICACION = SYSDATE,
                                                          NOM_USUARORA = EV_USUARORA,
                                                          ESTADO = LV_Estado
                            WHERE NUM_DESDE = LN_NumDesde;
                        END LOOP;
                    ELSIF (EV_ACTUACION = 'BA') THEN
                        LV_Estado := '3';
                        --Actualiza el estado de los rangos asociados al numero piloto
                        LOOP
                        FETCH LC_RangosPiloto INTO LN_NumDesde;
                        EXIT WHEN LC_RangosPiloto%NOTFOUND;
                            UPDATE GA_RANGOS_FIJOS_TO SET FECHA_BAJA = SYSDATE,
                                                             FECHA_MODIFICACION = SYSDATE,
                                                          NOM_USUARORA = EV_USUARORA,
                                                          ESTADO = LV_Estado
                            WHERE NUM_DESDE = LN_NumDesde;
                        END LOOP;
                    ELSIF (EV_ACTUACION = 'AB') THEN
                        LV_Estado := '2';
                        LOOP
                        FETCH LC_RangosPiloto INTO LN_NumDesde;
                        EXIT WHEN LC_RangosPiloto%NOTFOUND;
                            UPDATE GA_RANGOS_FIJOS_TO SET FECHA_ALTA = SYSDATE,
                                                          FECHA_MODIFICACION = SYSDATE,
                                                          NOM_USUARORA = EV_USUARORA,
                                                          ESTADO = LV_Estado
                            WHERE NUM_DESDE = LN_NumDesde;
                        END LOOP;
                    END IF;
            ELSE
                 LN_NumError := 19;
                 LV_MsgError := 'Error numero debe ser PILOTO';
                 LV_NomTabla:='GA_ABOCEL';
                 RAISE ERROR_CONTROLADO;
            END IF;
        END IF;

    

    LN_NumError:=0;
    LV_MsgError:='Operacion Exitosa';
EXCEPTION
    WHEN ERROR_CONTROLADO THEN
         NULL;

END PV_ACTUALIZA_RANGOSFIJOS_PR;

PROCEDURE PV_ACT_TRANSACABO_PR (
        nNUM_TRANSACCION     IN   GA_TRANSACABO.NUM_TRANSACCION%TYPE,   --Numero de transaccion
        nCOD_RETORNO         IN   GA_TRANSACABO.COD_RETORNO%TYPE,       --Codigo de retorno
        sDES_CADENA          IN   GA_TRANSACABO.DES_CADENA%TYPE, --Descripcion del retorno
        SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
        SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
        SN_num_evento        OUT NOCOPY ge_errores_pg.Evento)

IS
   LV_des_error     ge_errores_pg.desevent;
   LV_sSql          ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno     := 0;
   SV_mens_retorno := NULL;
   SN_num_evento     := 0;

   LV_sSql := 'UPDATE GA_TRANSACABO';
   LV_sSql := ' SET COD_RETORNO = ' || nCOD_RETORNO;
   LV_sSql := ' AND DES_CADENA = ' || sDES_CADENA;
   LV_sSql := ' WHERE NUM_TRANSACCION = ' || nNUM_TRANSACCION;

   UPDATE GA_TRANSACABO
      SET COD_RETORNO = nCOD_RETORNO,
          DES_CADENA = sDES_CADENA
      WHERE NUM_TRANSACCION = nNUM_TRANSACCION;

EXCEPTION
WHEN OTHERS THEN
   SN_cod_retorno := 4;
   SV_mens_retorno := 'Error en ejecución PL-SQL PV_ACT_TRANSACABO_PR.';
   LV_des_error := SQLERRM;
   SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'PV_ACT_TRANSACABO_PR', LV_sSql, SQLCODE, LV_des_error );

END PV_ACT_TRANSACABO_PR;

PROCEDURE PV_VALTEL_FIJA_MOVIL_PR (
   v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
   -- vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
    vMENSAJE        OUT  VARCHAR2
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALTEL_FIJA_MOVIL_PR
-- * Descripcion        : PERMITE RESTRINGIR LA EJECUCIóN DE OOSS (WS Y VB) PARA ABONADOS O CLIENTES DEL TIPO RED FIJA.
-- *
-- * Fecha de creacion  : 13-04-2009
-- * Responsable        : Area Postventa
-- *************************************************************

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        nCOD_CLIENTEO     GA_ABOCEL.COD_CLIENTE%TYPE;
        nCOD_CLIENTED     GA_ABOCEL.COD_CLIENTE%TYPE;
        nABONADO            GA_ABOCEL.NUM_ABONADO%TYPE;
        nCod_OS                 CI_TIPORSERV.COD_OS%TYPE;
        iNUM_CELULAR           GA_ABOCEL.NUM_celular%TYPE;


        ---TYPE refcursor IS REF CURSOR;


       vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        nExistencia       number;
        nPos1              number;
        nLargo             number;
        nColumna        number;
        iCont              number;

        LV_sSql               ge_errores_pg.vQuery;
        vCentrales_fijas    varchar2(20);
        vVarAux1            varchar2(20);
        vVarAux2            varchar2(20);
          TYPE tipoArray IS VARRAY(20) OF  varchar2(30);


          LA_arregloSalida tipoArray := tipoArray();

        nCodCentral      ga_abocel.COD_CENTRAL%type;
        nCodCentralD     ga_abocel.COD_CENTRAL%type;
        vPlanTarif       ta_plantarif.COD_PLANTARIF%type;
        vCodTiplan       ta_plantarif.COD_TIPLAN%type;
        vTipPlan         ta_plantarif.TIP_PLANTARIF%type;
        vTipRed          ta_plantarif.TIP_RED%type;

        ERROR_CLIENTE_ORIGEN EXCEPTION;
        ERROR_CLIENTE_DESTINO EXCEPTION;

        SC_CODCENTRALESCLIENTEO REFCURSOR;
        SC_CODCENTRALESCLIENTED REFCURSOR;
BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);

         nABONADO                   := TO_NUMBER(string(5));
        nCOD_CLIENTEO           :=TO_NUMBER(string(6));
         nCod_OS                      :=TO_NUMBER(string(9));
        nCOD_CLIENTED           :=TO_NUMBER(string(16));

    bRESULTADO:='TRUE';
    VMENSAJE:=' Transacción Exitosa ';
    /*
 nCOD_CLIENTEO           := 2844751;
 nABONADO                   := 4571559;
  nCOD_CLIENTED           :=65041933;
 nCod_OS                      :='10503';        */

    BEGIN
--  obtenemos el valor de las centrales fijas
    select VAL_PARAMETRO into vCentrales_fijas
    from ged_parametros where NOM_PARAMETRO='CEN_FIJAS';

     nColumna:=1;
    nPos1:=0;
    iCont:=0;
    select LENGTH (vCentrales_fijas) into nLargo from dual;
    LOOP

        select INSTR(vCentrales_fijas , ',', nColumna, 1) into nPos1 from dual;

        iCont := iCont + 1;
        LA_arregloSalida.extend;
        IF (nPos1 != 0 ) THEN
            LA_arregloSalida(iCont) := TRIM(SUBSTR(vCentrales_fijas,nColumna,nPos1-nColumna));

            nColumna:= nPos1+1;

        ELSIF nPos1=0 then
            LA_arregloSalida(iCont) := TRIM(SUBSTR(vCentrales_fijas,nColumna,nLargo));

            EXIT;

        END IF;

    END LOOP;

    IF nCod_OS in( '21003','22400')  then
    --validamos que el numero piloto del abonado tenga central VPN

            SELECT a.COD_CENTRAL into nCodCentral
            FROM GA_ABOCEL A
            WHERE a.NUM_ABONADO =nABONADO;
            --AND a.COD_SITUACION NOT IN ('BAA', 'BAP');

                iCont:=1;
                nColumna:=LA_arregloSalida.count;
                loop
                    if (icont >nColumna) then
                       exit;
                    end if;

                    if (nCodCentral = LA_arregloSalida(iCont)) then
                        exit;
                    end if;
                    iCont:=iCont+1;
                end loop;

                IF icont > nColumna then
                    bRESULTADO:='FALSE';
                    VMENSAJE:=' El número piloto no se encuentra asociado a la central VPN ';
                    RETURN;
                END IF;

    END IF;

    IF nCod_OS in( '10090', '10095' )  then

    select ga.num_celular into iNUM_CELULAR from ga_abocel ga
    where ga.num_abonado = nABONADO
      and ga.IND_SUPERTEL <> 7;


    select count (1) into iCont  from
    GA_NRO_PILOTO_RANGO_TO
    where NUM_PILOTO = iNUM_CELULAR;

                    if (iCont < 1) then
                        bRESULTADO:='FALSE';
                        VMENSAJE:=' Transacción permitida solo para clientes E1 ';
                     RETURN;
                    end if;

    END IF;


    IF nCod_OS in( '10271', '10270', '10020', '10100', '10060', '10231', '10070', '10222','10232','10290', '10095','10539','10530' )  then

            SELECT a.COD_CENTRAL into nCodCentral
            FROM GA_ABOCEL A
            WHERE a.NUM_ABONADO =nABONADO
             and a.IND_SUPERTEL <> 7;
            --AND a.COD_SITUACION NOT IN ('BAA', 'BAP');

                iCont:=1;
                nColumna:=LA_arregloSalida.count;
                loop
                    if (icont >nColumna) then
                       exit;
                    end if;

                    if (nCodCentral = LA_arregloSalida(iCont)) then
                        bRESULTADO:='FALSE';
                        VMENSAJE:=' Transacción no permitida para clientes E1 ';
                        exit;
                    end if;
                iCont:=iCont+1;
                end loop;

    END IF;

    --- 10-07-2009, Solución Bug OOSS 10760
    IF nCod_OS = '10760'  THEN

            BEGIN
                SELECT a.COD_PLANTARIF into vPlanTarif
                FROM GA_EMPRESA A
                WHERE a.COD_CLIENTE =nCOD_CLIENTEO;
            EXCEPTION
            WHEN OTHERS THEN
                 null;
            END;

            BEGIN
                SELECT a.COD_TIPLAN, a.TIP_PLANTARIF, a.TIP_RED
                into vCodTiplan, vTipPlan, vTipRed
                FROM TA_PLANTARIF A
                WHERE a.COD_PLANTARIF = vPlanTarif;
            EXCEPTION
            WHEN OTHERS THEN
                 null;
            END;

            IF vTipPlan = 'E' AND vCodTiplan = '2' AND vTipRed ='F' THEN  -- Plan Empresa y PosPago, Red FIJA
               bRESULTADO:='FALSE';
               VMENSAJE:=' Transacción no permitida para clientes E1 ';
               RETURN;
            END IF;

    END IF;

    IF nCod_OS in  ( '10503' , '10506', '10504', '10505',  '10507','10508')  then
         OPEN SC_CODCENTRALESCLIENTEO FOR
            SELECT GA.COD_CENTRAL
            FROM GA_ABOCEL GA
            WHERE GA.COD_CLIENTE = nCOD_CLIENTEO
            AND GA.COD_SITUACION NOT IN ('BAA', 'BAP')
            AND GA.IND_SUPERTEL <> 7;

            LOOP
            FETCH SC_CODCENTRALESCLIENTEO INTO nCodCentral;
            EXIT WHEN SC_CODCENTRALESCLIENTEO%NOTFOUND;


                iCont:=1;
                nColumna:=LA_arregloSalida.count;
                loop
                    if (icont >nColumna) then
                       exit;
                    end if;
                    if (nCodCentral = LA_arregloSalida(iCont)) then

                       RAISE ERROR_CLIENTE_ORIGEN;
                    end if;
                iCont:=iCont+1;
                end loop;
             END LOOP;

             OPEN SC_CODCENTRALESCLIENTED FOR
                  SELECT GA.COD_CENTRAL
                  FROM GA_ABOCEL GA
                  WHERE GA.COD_CLIENTE = NCOD_CLIENTED
                  AND GA.COD_SITUACION NOT IN ('BAA', 'BAP')
                  AND GA.IND_SUPERTEL <> 7;

            LOOP
            FETCH SC_CODCENTRALESCLIENTED INTO nCodCentral;
            EXIT WHEN SC_CODCENTRALESCLIENTED%NOTFOUND;

            SELECT INSTR(vCentrales_fijas,nCodCentral, 1, 1 ) into nExistencia
            FROM DUAL;

                iCont:=1;
                nColumna:=LA_arregloSalida.count;
                loop
                    if (icont >nColumna) then
                       exit;
                    end if;
                    if (nCodCentral = LA_arregloSalida(iCont)) then

                       RAISE ERROR_CLIENTE_DESTINO;
                    end if;
                iCont:=iCont+1;
                end loop;
             END LOOP;

    END IF;
EXCEPTION
WHEN ERROR_CLIENTE_ORIGEN THEN
                      bRESULTADO:='FALSE';
                        VMENSAJE:=' Transacción no permitida para cliente Origen E1 ';


WHEN ERROR_CLIENTE_DESTINO THEN
                      bRESULTADO:='FALSE';
                        VMENSAJE:=' Transacción no permitida para cliente Destino E1 ';


WHEN OTHERS THEN
                       bRESULTADO:='FALSE';
                       vMENSAJE:='Error de Acceso';

END;
END PV_VALTEL_FIJA_MOVIL_PR;


PROCEDURE PV_INS_HISTASOCIA_RANGO_PR(
    EN_NUM_PILOTO       IN GA_NRO_PILOTO_RANGO_TH.NUM_PILOTO%TYPE,
    EN_NUM_DESDE        IN GA_NRO_PILOTO_RANGO_TH.NUM_DESDE%TYPE,
    ED_FECHA_HISTORICO  IN GA_NRO_PILOTO_RANGO_TH.FECHA_HISTORICO%TYPE,
    EV_NOM_USUARORA     IN GA_NRO_PILOTO_RANGO_TH.NOM_USUARORA%TYPE,
    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_INS_HISTASOCIA_RANGO_PR"
      Lenguaje="PL/SQL"
      Fecha="09-06-2009"
      Versión="1.0"
      Diseñador="Ricardo Quezada"
      Programador="Ricardo Quezada"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Actualiza la suspénsion</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_PILOTO"  Tipo="NRO_PILOTO_RANGO_TH.NUM_PILOTO%TYPE">Numero piloto</param>
            <param nom="EN_NUM_DESDE"  Tipo="GA_NRO_PILOTO_RANGO_TH.NUM_DESDE%TYPE">Numero inicial del rango</param>
            <param nom="ED_FECHA_HISTORICO"  Tipo="GA_NRO_PILOTO_RANGO_TH.FECHA_HISTORICO%TYPE">Fecha del paso a historico</param>
            <param nom="EV_NOM_USUARORA"  Tipo="GA_NRO_PILOTO_RANGO_TH.NOM_USUARORA%TYPE">Nombre de usuario SCL</param>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"  Tipo="Number">Codigo de Retorno</param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2">Mensaje de Retorno</param>
           <param nom="SN_NUM_EVENTO"   Tipo="Number">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;

BEGIN

    sn_cod_retorno    := 0;
    sv_mens_retorno   := NULL;
    sn_num_evento     := 0;

    LV_sSql := 'INSERT INTO GA_NRO_PILOTO_RANGO_TH (NUM_PILOTO, NUM_DESDE, FECHA_HISTORICO, NOM_USUARORA)'
            || 'VALUES (' || EN_NUM_PILOTO || ',' || EN_NUM_DESDE || ',' || ED_FECHA_HISTORICO || ',' || EV_NOM_USUARORA || ')';

    INSERT INTO GA_NRO_PILOTO_RANGO_TH (NUM_PILOTO, NUM_DESDE, FECHA_HISTORICO, NOM_USUARORA)
    VALUES (EN_NUM_PILOTO, EN_NUM_DESDE, ED_FECHA_HISTORICO, EV_NOM_USUARORA);
    
    
    LV_sSql := 'INSERT INTO GA_NRO_PILOTO_ABO_TO (NUM_PILOTO, NUM_DESDE, NOM_USUARORA, ESTADO,'
            || 'ULTIMO_CREADO,OPERACION,NUM_VENTA,FECHA_REGISTRO)'
            || 'VALUES (' || EN_NUM_PILOTO || ',' || EN_NUM_DESDE || ',' || EV_NOM_USUARORA 
            || ',INICIAL, NULL,ELIMINAR, NULL,'||SYSDATE||');';
            
    INSERT INTO GA_NRO_PILOTO_ABO_TO ( NUM_PILOTO, NUM_DESDE, NOM_USUARORA, 
                ESTADO, ULTIMO_CREADO, OPERACION, NUM_VENTA,FECHA_REGISTRO)
    VALUES (EN_NUM_PILOTO, EN_NUM_DESDE, EV_NOM_USUARORA,'INICIAL', NULL,'ELIMINAR', NULL,SYSDATE);

EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('PV_INS_HISTASOCIA_RANGO_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_VENTAS_ENLACE_VPN_PG.PV_INS_HISTASOCIA_RANGO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END PV_INS_HISTASOCIA_RANGO_PR;


PROCEDURE PV_IN_NUM_PILOTO_PR(
          EV_NUM_PILOTO         IN GA_NRO_PILOTO_RANGO_TO.NUM_PILOTO%TYPE,
          EV_FECHA              IN GA_NRO_PILOTO_RANGO_TO.NUM_DESDE%TYPE,
          EV_USUARIO            IN GA_NRO_PILOTO_RANGO_TO.NOM_USUARORA%TYPE,
          SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
          SV_MENS_RETORNO   OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
          SN_NUM_EVENTO     OUT NOCOPY GE_ERRORES_PG.EVENTO
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_IN_NUM_PILOTO_PR"
      Lenguaje="PL/SQL"
      Fecha="09-06-2009"
      Versión="1.0"
      Diseñador="**"
      Programador="**"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  Registra número piloto </Descripción>
      <Parámetros>
         <Entrada>
                          <param nom="EV_NUM_PILOTO" Tipo="Number"     >Número Piloto o Celular </param>
                          <param nom="EV_USUARIO"    Tipo="Varchar2"  >Nombre de usuario      </param>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO"   Tipo="Number"     >Codigo de Retorno      </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"    Tipo="Number"     >Numero de Evento </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS PRAGMA AUTONOMOUS_TRANSACTION;
  LV_des_error          ge_errores_pg.desevent;
  LV_sSql               ge_errores_pg.vQuery;
  LV_contAbo              NUMBER;

BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
     SN_num_evento     := 0;
     


       LV_sSql := 'INSERT INTO GA_NRO_PILOTO_RANGO_TO'
       || ' (NUM_PILOTO'
       || ', NUM_DESDE'
       || ', NOM_USUARORA )'
       || ' VALUES ('
       || EV_NUM_PILOTO
       ||',' || EV_FECHA
       ||',' || EV_USUARIO
       ||')';

       INSERT INTO GA_NRO_PILOTO_RANGO_TO
       (NUM_PILOTO
       , NUM_DESDE
       , NOM_USUARORA)
       VALUES
       (
         EV_NUM_PILOTO
       , EV_FECHA
       , EV_USUARIO
       );
       
        -- EV_NUM_PILOTO corresponde a GA_ABOCEL.NUM_CELULAR. Si este está en 
        -- 'AAA' indica que este PL se está llamando desde Posventa.
        -- En cualquier otro caso, no ejecutar el INSERT siguiente.
       
        SELECT count(1) 
            INTO LV_contAbo 
        FROM 
            ga_abocel a 
        WHERE 
            a.cod_situacion = 'AAA' 
            AND a.num_celular = EV_NUM_PILOTO;
            
        IF (LV_contAbo > 0) THEN 
            
            LV_sSql := 'INSERT INTO GA_NRO_PILOTO_ABO_TO (NUM_PILOTO, NUM_DESDE, NOM_USUARORA'
            || ', ESTADO , ULTIMO_CREADO , OPERACION , NUM_VENTA,FECHA_REGISTRO)'
            || ' VALUES (' || EV_NUM_PILOTO ||',' || EV_FECHA ||',' || EV_USUARIO
            ||',INICIAL,NULL,CREAR,NULL,'||SYSDATE
            ||')';

            INSERT INTO GA_NRO_PILOTO_ABO_TO( NUM_PILOTO, NUM_DESDE, NOM_USUARORA, ESTADO,
                   ULTIMO_CREADO, OPERACION, NUM_VENTA, FECHA_REGISTRO)
            VALUES (EV_NUM_PILOTO, EV_FECHA, EV_USUARIO,'INICIAL', NULL,'CREAR', NULL, SYSDATE);
       
        END IF;
       
        COMMIT;

EXCEPTION

          WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;

            LV_des_error := SUBSTR('PV_IN_NUM_PILOTO_PR('|| EV_NUM_PILOTO || EV_FECHA || EV_USUARIO || '); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_IN_NUM_PILOTO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END PV_IN_NUM_PILOTO_PR;


PROCEDURE PV_OBT_RANGOS_DISPONIBLES_PR(
    EN_COD_CENTRAL  IN ICG_CENTRAL.COD_CENTRAL%TYPE,
    SC_RANGOS_DISP  OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBT_RANGOS_DISPONIBLES_PR
      Lenguaje="PL/SQL"
      Fecha="09-06-2009"
      Versión="1.0"
      Diseñador="**"
      Programador="Héctor Hermosilla"
      Ambiente Desarrollo="BD">
      <Retorno>REFCURSOR</Retorno>
      <Descripción>  Obtiene listado de rangos disponibles </Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="SC_RANGOS_DISP Tipo="REFCURSOR">Cursor que contiene los rangos disponibles</param>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         <Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
    LN_COD_RETORNO       GE_ERRORES_TD.COD_MSGERROR%TYPE;
    LV_MENS_RETORNO      GE_ERRORES_TD.DET_MSGERROR%TYPE;
    LN_NUM_EVENTO        GE_ERRORES_PG.EVENTO;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;


    LV_sSql:= 'SELECT rango.NUM_DESDE, rango.NUM_HASTA,';
    LV_sSql:= LV_sSql ||' rango.FECHA_ALTA, rango.FECHA_BAJA,';
    LV_sSql:= LV_sSql ||' rango.FECHA_SUSPENSION, rango.ESTADO,';
    LV_sSql:= LV_sSql ||' rango.NOM_USUARORA, rango.FECHA_REHABILITACION, rango.FECHA_MODIFICACION';
    LV_sSql:= LV_sSql ||' FROM GA_RANGOS_FIJOS_TO rango';
    LV_sSql:= LV_sSql ||' WHERE rango.NUM_DESDE';
    LV_sSql:= LV_sSql ||' NOT IN(SELECT NUM_DESDE FROM GA_NRO_PILOTO_RANGO_TO)';
    LV_sSql:= LV_sSql ||' AND COD_CENTRAL =' || EN_COD_CENTRAL;
    LV_sSql:= LV_sSql ||' ORDER BY estado';


    OPEN SC_RANGOS_DISP FOR LV_sSql;

EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('PV_OBT_RANGOS_DISPONIBLES_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'Pv_ventas_enlace_vpn_HH_Pg.PV_OBT_RANGOS_DISPONIBLES_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END PV_OBT_RANGOS_DISPONIBLES_PR;

PROCEDURE PV_ACTUALIZA_ESTADO_RANGO_PR(
    EN_NUM_DESDE        IN GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE,
    EN_ESTADO            IN GA_RANGOS_FIJOS_TO.ESTADO%TYPE,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_ACTUALIZA_ESTADO_RANGO_PR"
      Lenguaje="PL/SQL"
      Fecha="09-06-2009"
      Versión="1.0"
      Diseñador="**"
      Programador="J. Alejandro Zepeda C."
      Ambiente Desarrollo="BD">
      <Retorno>REFCURSOR</Retorno>
      <Descripción> Actualiza estado y fecha de modificacion del rango</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
           <param nom="EN_NUM_DESDE  Tipo="GA_RANGOS_FIJOS_TO.NUM_DESDE">Inicio de rango</param>
           <param nom="EN_ESTADO  Tipo="GA_RANGOS_FIJOS_TO.ESTADO">Estado del rango</param>
           <param nom="SN_COD_RETORNO"     Tipo="Number"    >Codigo de Retorno     </param>
           <param nom="SV_MENS_RETORNO" Tipo="Varchar2"    >Mensaje de Retorno     </param>
           <param nom="SN_NUM_EVENTO"     Tipo="Number"    >Numero de Evento     </param>
         <Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
    LN_COD_RETORNO       GE_ERRORES_TD.COD_MSGERROR%TYPE;
    LV_MENS_RETORNO      GE_ERRORES_TD.DET_MSGERROR%TYPE;
    LN_NUM_EVENTO        GE_ERRORES_PG.EVENTO;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

    LV_sSql:= 'UPDATE GA_RANGOS_FIJOS_TO ';
    LV_sSql:= LV_sSql || ' SET ESTADO = ' || EN_ESTADO;
    LV_sSql:= LV_sSql || ', FECHA_MODIFICACION = SYSDATE WHERE NUM_DESDE = ' || EN_NUM_DESDE;


    UPDATE GA_RANGOS_FIJOS_TO
           SET ESTADO = EN_ESTADO, FECHA_MODIFICACION = SYSDATE
    WHERE NUM_DESDE = EN_NUM_DESDE;

EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('PV_ACTUALIZA_ESTADO_RANGO_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'Pv_ventas_enlace_vpn_HH_Pg.PV_ACTUALIZA_ESTADO_RANGO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END PV_ACTUALIZA_ESTADO_RANGO_PR;

PROCEDURE PV_OBTS_DATOS_RANGO_PR(
    EN_NUM_ABONADO  in GA_ABOCEl.NUM_ABONADO%TYPE,
    SC_DATOS_RANGOS  OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PPV_OBTS_DATOS_RANGO_PR
      Lenguaje="PL/SQL"
      Fecha="15-04-2009"
      Versión="1.0"
      Diseñador="**"
      Programador="ALEJANDRO DÍAZ"
      Ambiente Desarrollo="BD">
      <Retorno>DATOS VARIOS</Retorno>
      <Descripción>  OBTIENE DATOS DE LOS RANGOS </Descripción>
      <Parámetros>
         <Entrada>EN_NUM_ABONADO<Entrada>
         </Entrada>
         <Salida>
           <param nom="  Tipo="R">/param>
           <
         <Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
    LN_COD_RETORNO       GE_ERRORES_TD.COD_MSGERROR%TYPE;
    LV_MENS_RETORNO      GE_ERRORES_TD.DET_MSGERROR%TYPE;
    LN_NUM_EVENTO        GE_ERRORES_PG.EVENTO;


BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
     SN_num_evento     := 0;

LV_sSql:= 'select rango.NUM_DESDE, rango.NUM_HASTA, rango.FECHA_ALTA, rango.FECHA_BAJA, rango.FECHA_SUSPENSION, rango.ESTADO, rango.NOM_USUARORA, rango.FECHA_REHABILITACION, rango.FECHA_MODIFICACION ' ;
LV_sSql:= LV_sSql ||'from GA_RANGOS_FIJOS_TO rango inner join GA_NRO_PILOTO_RANGO_TO piloto on rango.num_desde = piloto.num_desde inner join GA_ABOCEL abonado on abonado.num_celular = piloto.num_piloto ';
LV_sSql:= LV_sSql ||'where abonado.num_abonado ='|| EN_NUM_ABONADO;
LV_sSql:= LV_sSql ||' and abonado.IND_SUPERTEL <> 7';



    OPEN SC_DATOS_RANGOS FOR LV_sSql;

            SN_cod_retorno := 0;
            SV_mens_retorno := 'OK';
            SN_num_evento := 0;


EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('PV_CAUSA_BAJA_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_BAJA_ABONADO_VPN_PG.PV_CAUSA_BAJA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END PV_OBTS_DATOS_RANGO_PR;

PROCEDURE PV_DEL_RANGOS_PILOTO_PR(
    EN_NUM_DESDE          IN         GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE ,
    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_DEL_RANGOS_PILOTO_PR
      Lenguaje="PL/SQL"
      Fecha="15-04-2009"
      Versión="1.0"
      Diseñador="**"
      Programador="ALEJANDRO DÍAZ"
      Ambiente Desarrollo="BD">
      <Retorno>DATOS VARIOS</Retorno>
      <Descripción>  OBTIENE DATOS DE LOS RANGOS </Descripción>
      <Parámetros>
         <Entrada>EN_NUM_ABONADO<Entrada>
         </Entrada>
         <Salida>
           <param nom="  Tipo="R">/param>
           <
         <Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
    LN_COD_RETORNO       GE_ERRORES_TD.COD_MSGERROR%TYPE;
    LV_MENS_RETORNO      GE_ERRORES_TD.DET_MSGERROR%TYPE;
    LN_NUM_EVENTO        GE_ERRORES_PG.EVENTO;


BEGIN
     SN_cod_retorno  := 0;
     SV_mens_retorno := '';
     SN_num_evento     := 0;

DELETE FROM GA_NRO_PILOTO_RANGO_TO WHERE NUM_DESDE = EN_NUM_DESDE;


            SN_cod_retorno := 0;
            SV_mens_retorno := 'OK';
            SN_num_evento := 0;


EXCEPTION
        WHEN OTHERS THEN
             SN_cod_retorno := GV_error_others;
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                    SV_mens_retorno := gv_error_no_clasif;
             END IF;
             LV_des_error := SUBSTR('PV_CAUSA_BAJA_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
             SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_BAJA_ABONADO_VPN_PG.PV_CAUSA_BAJA_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END PV_DEL_RANGOS_PILOTO_PR;

FUNCTION IC_CONS_RANGOS_E1_FN (V_Num_Movimiento  IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE) RETURN VARCHAR2

/*
<Documentación
   TipoDoc = "Funcion">
   <Elemento
      Nombre = "IC_CONS_RANGOS_E1_FN""
      Lenguaje="PL/SQL"
      Fecha creación="12-11-2009"
      Creado por="TMAS."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Retorna los Rangos de numeros asociados a un numero piloto</Descripción>
      <Parámetros>
         <Entrada>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql          VARCHAR2(1000);
LV_Salida       VARCHAR2(1000);
LV_estado       VARCHAR2(1);
LN_Can_Filas    NUMBER;
LN_num_celular  icc_movimiento.NUM_CELULAR%TYPE;
LN_num_desde    GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE;
LN_num_hasta    GA_RANGOS_FIJOS_TO.NUM_HASTA%TYPE;
LN_estado       GA_RANGOS_FIJOS_TO.ESTADO%TYPE;
SN_ERROR        NUMBER;
SV_MENSAJE      ge_errores_td.det_msgerror%TYPE;
SN_EVENTO       NUMBER;


CURSOR c_rangos (n_celular icc_movimiento.NUM_ABONADO%TYPE)IS
        SELECT b.estado, b.num_desde, b.num_hasta  
        FROM GA_NRO_PILOTO_RANGO_TO a, GA_RANGOS_FIJOS_TO b
        WHERE num_piloto = n_celular
          AND a.num_desde = b.num_desde;

BEGIN
        SN_ERROR   := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO  := 0;
        LV_Salida  := '';
        LV_Sql     := 'OPEN c_rangos; LOOP FETCH c_rangos';

        SELECT NUM_CELULAR
        INTO LN_num_celular
        FROM ICC_MOVIMIENTO
        WHERE NUM_MOVIMIENTO = V_Num_Movimiento;

        OPEN c_rangos(LN_num_celular) ;

        FETCH c_rangos INTO LN_estado, LN_num_desde, LN_num_hasta;                             
        IF c_rangos%NOTFOUND THEN
            LV_Salida  := 'NOT_FOUND';
            RETURN LV_Salida;
        END IF;
                
        LOOP
            EXIT WHEN c_rangos%NOTFOUND;
            IF (LN_estado = 3 OR LN_estado = 7) THEN
                LV_estado := 'B';
            ELSE
                LV_estado := 'A';
            END IF;                
            LV_Salida := LV_Salida || LV_estado || '-' || TO_CHAR(LN_num_desde) || '-' || TO_CHAR(LN_num_hasta) || '!';
            FETCH c_rangos INTO LN_estado, LN_num_desde, LN_num_hasta;                             
        END LOOP;
-- 
        IF LENGTH(LV_Salida) > 1 THEN
            LV_Salida := SUBSTR(LV_Salida,1,LENGTH(LV_Salida)-1);
        END IF;
        RETURN LV_Salida;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                LV_Salida := 'MOVIMIENTO NOT FOUND';
             RETURN LV_Salida;                                           
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'PV_VENTAS_ENLACE_VPN_PG.IC_CONS_RANGOS_E1_FN', SQLERRM, '1',USER, 'IC_CONS_RANGOS_E1_FN', LV_Sql, SN_ERROR, SV_MENSAJE );
             RETURN 'ERROR: ' || SN_ERROR || SV_MENSAJE;  
END IC_CONS_RANGOS_E1_FN; 

PROCEDURE PV_insta_movimiento_PR(num_movimiento             icc_movimiento.num_movimiento%TYPE,
                            EN_num_abonado                icc_movimiento.num_abonado%TYPE,
                            EN_cod_estado                 icc_movimiento.cod_estado%TYPE,
                            EV_cod_actabo                 icc_movimiento.cod_actabo%TYPE,
                            EV_cod_modulo                 icc_movimiento.cod_modulo%TYPE,
                            EN_num_intentos               icc_movimiento.num_intentos%TYPE,
                            EN_cod_central_nue            icc_movimiento.cod_central_nue%TYPE,
                            EV_des_respuesta              icc_movimiento.des_respuesta%TYPE,
                            EN_cod_actuacion              icc_movimiento.cod_actuacion%TYPE,
                            EV_nom_usuarora               icc_movimiento.nom_usuarora%TYPE,
                            ED_fec_ingreso                icc_movimiento.fec_ingreso%TYPE,
                            EV_tip_terminal               icc_movimiento.tip_terminal%TYPE,
                            EN_cod_central                icc_movimiento.cod_central%TYPE,
                            ED_fec_lectura                icc_movimiento.fec_lectura%TYPE,
                            EN_ind_bloqueo                icc_movimiento.ind_bloqueo%TYPE,
                            ED_fec_ejecucion              icc_movimiento.fec_ejecucion%TYPE,
                            EV_tip_terminal_nue           icc_movimiento.tip_terminal_nue%TYPE,
                            EN_num_movant                 icc_movimiento.num_movant%TYPE,
                            EN_num_celular                icc_movimiento.num_celular%TYPE,
                            EN_num_movpos                 icc_movimiento.num_movpos%TYPE,
                            EV_num_serie                  icc_movimiento.num_serie%TYPE,
                            EV_num_personal               icc_movimiento.num_personal%TYPE,
                            EN_num_celular_nue            icc_movimiento.num_celular_nue%TYPE,
                            EV_num_serie_nue              icc_movimiento.num_serie_nue%TYPE,
                            EV_num_personal_nue           icc_movimiento.num_personal_nue%TYPE,
                            EV_num_msnb                   icc_movimiento.num_msnb%TYPE,
                            EV_num_msnb_nue               icc_movimiento.num_msnb_nue%TYPE,
                            EV_cod_suspreha               icc_movimiento.cod_suspreha%TYPE,
                            EV_cod_servicios              icc_movimiento.cod_servicios%TYPE,
                            EV_num_min                    icc_movimiento.num_min%TYPE,
                            EV_num_min_nue                icc_movimiento.num_min_nue%TYPE,
                            EV_sta                        icc_movimiento.sta%TYPE,
                            EN_cod_mensaje                icc_movimiento.cod_mensaje%TYPE,
                            EV_param1_mens                icc_movimiento.param1_mens%TYPE,
                            EV_param2_mens                icc_movimiento.param2_mens%TYPE,
                            EV_param3_mens                icc_movimiento.param3_mens%TYPE,
                            EV_plan                       icc_movimiento.PLAN%TYPE,
                            EN_carga                      icc_movimiento.carga%TYPE,
                            EN_valor_plan                 icc_movimiento.valor_plan%TYPE,
                            EV_pin                        icc_movimiento.pin%TYPE,
                            ED_fec_expira                 icc_movimiento.fec_expira%TYPE,
                            EV_des_mensaje                icc_movimiento.des_mensaje%TYPE,
                            EV_cod_pin                    icc_movimiento.cod_pin%TYPE,
                            EV_cod_idioma                 icc_movimiento.cod_idioma%TYPE,
                            EN_cod_enrutamiento           icc_movimiento.cod_enrutamiento%TYPE,
                            EN_tip_enrutamiento           icc_movimiento.tip_enrutamiento%TYPE,
                            EV_des_origen_pin             icc_movimiento.des_origen_pin%TYPE,
                            EN_num_lote_pin               icc_movimiento.num_lote_pin%TYPE,
                            EV_num_serie_pin              icc_movimiento.num_serie_pin%TYPE,
                            EV_tip_tecnologia             icc_movimiento.tip_tecnologia%TYPE,
                            EV_imsi                       icc_movimiento.imsi%TYPE,
                            EV_imsi_nue                   icc_movimiento.imsi_nue%TYPE,
                            EV_imei                       icc_movimiento.imei%TYPE,
                            EV_imei_nue                   icc_movimiento.imei_nue%TYPE,
                            EV_icc                        icc_movimiento.icc%TYPE,
                            EV_icc_nue                          icc_movimiento.icc_nue%TYPE,
                            SN_cod_retorno                OUT NOCOPY ge_errores_pg.CodError,
                            SV_mens_retorno               OUT NOCOPY ge_errores_pg.MsgError,
                            SN_num_evento                 OUT NOCOPY ge_errores_pg.Evento
                            ) IS

LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                       GE_ERRORES_PG.vQuery;

BEGIN

    sSql := 'INSERT INTO ICC_MOVIMIENTO ( num_movimiento, num_abonado, cod_estado, cod_actabo, cod_modulo,';
    sSql := sSql || ' num_intentos, cod_central_nue, des_respuesta, cod_actuacion, nom_usuarora, fec_ingreso,';
    sSql := sSql || ' tip_terminal, cod_central, fec_lectura, ind_bloqueo, fec_ejecucion, tip_terminal_nue, num_movant,';
    sSql := sSql || ' num_celular, num_movpos, num_serie, num_personal, num_celular_nue, num_serie_nue, num_personal_nue,';
    sSql := sSql || ' num_msnb, num_msnb_nue, cod_suspreha, cod_servicios, num_min, num_min_nue, sta, cod_mensaje,';
    sSql := sSql || ' param1_mens, param2_mens, param3_mens, plan, carga, valor_plan, pin, fec_expira, des_mensaje,';
    sSql := sSql || ' cod_pin, cod_idioma, cod_enrutamiento, tip_enrutamiento, des_origen_pin, num_lote_pin,';
    sSql := sSql || ' num_serie_pin, tip_tecnologia, imsi, imsi_nue, imei, imei_nue, icc,icc_nue ) ';
    sSql := sSql || ' VALUES (' || num_movimiento || ',' || EN_num_abonado || ',' || EN_cod_estado || ',' || EV_cod_actabo || ',' || EV_cod_modulo || ',';
    sSql := sSql || EN_num_intentos || ',' || EN_cod_central_nue || ',' || EV_des_respuesta || ',' || EN_cod_actuacion || ',' || EV_nom_usuarora || ',' || ED_fec_ingreso|| ',';
    sSql := sSql || EV_tip_terminal || ',' || EN_cod_central || ',' || ED_fec_lectura || ',' || EN_ind_bloqueo || ',' || ED_fec_ejecucion || ',' || EV_tip_terminal_nue || ',' || EN_num_movant|| ',';
    sSql := sSql || EN_num_celular || ',' || EN_num_movpos || ',' || EV_num_serie || ',' || EV_num_personal || ',' || EN_num_celular_nue || ',' || EV_num_serie_nue || ',' || EV_num_personal_nue|| ',';
    sSql := sSql || EV_num_msnb || ',' || EV_num_msnb_nue || ',' || EV_cod_suspreha || ',' || EV_cod_servicios || ',' || EV_num_min || ',' || EV_num_min_nue || ',' || EV_sta || ',' || EN_cod_mensaje|| ',';
    sSql := sSql || EV_param1_mens || ',' || EV_param2_mens || ',' || EV_param3_mens || ',' || EV_plan || ',' || EN_carga || ',' || EN_valor_plan || ',' || EV_pin || ',' || ED_fec_expira || ',' || EV_des_mensaje|| ',';
    sSql := sSql || EV_cod_pin || ',' || EV_cod_idioma || ',' || EN_cod_enrutamiento || ',' || EN_tip_enrutamiento || ',' || EV_des_origen_pin || ',' || EN_num_lote_pin|| ',';
    sSql := sSql || EV_num_serie_pin || ',' || EV_tip_tecnologia || ',' || EV_imsi || ',' || EV_imsi_nue || ',' || EV_imei || ',' || EV_imei_nue || ',' || EV_icc || ',' || EV_icc_nue || ')';

    INSERT INTO ICC_MOVIMIENTO ( num_movimiento, num_abonado, cod_estado, cod_actabo, cod_modulo,
    num_intentos, cod_central_nue, des_respuesta, cod_actuacion, nom_usuarora, fec_ingreso,
    tip_terminal, cod_central, fec_lectura, ind_bloqueo, fec_ejecucion, tip_terminal_nue, num_movant,
    num_celular, num_movpos, num_serie, num_personal, num_celular_nue, num_serie_nue, num_personal_nue,
    num_msnb, num_msnb_nue, cod_suspreha, cod_servicios, num_min, num_min_nue, sta, cod_mensaje,
    param1_mens, param2_mens, param3_mens, PLAN, carga, valor_plan, pin, fec_expira, des_mensaje,
    cod_pin, cod_idioma, cod_enrutamiento, tip_enrutamiento, des_origen_pin, num_lote_pin,
    num_serie_pin, tip_tecnologia, imsi, imsi_nue, imei, imei_nue, icc,icc_nue )
    VALUES (num_movimiento,EN_num_abonado,EN_cod_estado,EV_cod_actabo,EV_cod_modulo,
    EN_num_intentos,EN_cod_central_nue,EV_des_respuesta,EN_cod_actuacion,EV_nom_usuarora,ED_fec_ingreso,
    EV_tip_terminal,EN_cod_central,ED_fec_lectura,EN_ind_bloqueo,ED_fec_ejecucion,EV_tip_terminal_nue,EN_num_movant,
    EN_num_celular,EN_num_movpos,EV_num_serie,EV_num_personal,EN_num_celular_nue,EV_num_serie_nue,EV_num_personal_nue,
    EV_num_msnb,EV_num_msnb_nue,EV_cod_suspreha,EV_cod_servicios,EV_num_min,EV_num_min_nue,EV_sta,EN_cod_mensaje,
    EV_param1_mens,EV_param2_mens,EV_param3_mens,EV_plan,EN_carga,EN_valor_plan,EV_pin,ED_fec_expira,EV_des_mensaje,
    EV_cod_pin,EV_cod_idioma,EN_cod_enrutamiento,EN_tip_enrutamiento,EV_des_origen_pin,EN_num_lote_pin,
    EV_num_serie_pin,EV_tip_tecnologia,EV_imsi,EV_imsi_nue,EV_imei,EV_imei_nue,EV_icc,EV_icc_nue);

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución PL-SQL PV_insta_movimiento_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'PV_insta_movimiento_PR', sSql, SQLCODE, LV_des_error );
END PV_insta_movimiento_PR;
      PROCEDURE PV_insertar_os_PR ( EV_num_os IN NUMBER,
                                    EV_cod_os IN VARCHAR2,
                                    EV_producto IN NUMBER,
                                    EV_tip_inter IN NUMBER,
                                    EV_cod_inter IN NUMBER,
                                    EV_usuario IN VARCHAR2,
                                    EV_fecha IN DATE,
                                    EV_comentario IN VARCHAR2,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)  IS

    /*
    <Documentación
      TipoDoc = "Procedure">>
       <Elemento
          Nombre = "TV_insertar_os_PR
          Lenguaje="PL/SQL"
          Fecha="17-03-2008"
          Versión="La del package"
          Diseñador="Matias Guajardo"
          Programador="Matias Guajardo"
          Ambiente Desarrollo="BD">
          <Retorno>N/A</Retorno>>
          <Descripción>Inserta OOSS</Descripción>>
          <Parámetros>
             <Entrada>
                <param nom="ci_orserv Tipo="ESTRUCTURA">Estructura de OOSS</param>>
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

    LV_des_error                   ge_errores_pg.DesEvent;
    LV_sSql                           ge_errores_pg.vQuery;

    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

    INSERT INTO
        ci_orserv(num_os, cod_os, producto, tip_inter, cod_inter, usuario, fecha, comentario )
    VALUES
        (EV_num_os, EV_cod_os, EV_producto, EV_tip_inter, EV_cod_inter ,EV_usuario, EV_fecha, EV_comentario);


    EXCEPTION
    WHEN OTHERS THEN
          SN_cod_retorno := 205;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := 'ggg';
          END IF;
          LV_des_error := ' FALLO EN Pv_AbonoLimiteConsumo_Pg.PV_insertar_os_PR. ERROR: ' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,1, USER, 'PV_insertar_os_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    END PV_insertar_os_PR;
        PROCEDURE PV_CON_DATOS_OOSS_PR (EV_cod_os IN OUT NOCOPY VARCHAR2,
                                    SV_cod_tipmodi OUT VARCHAR2,
                                    SV_grupo OUT VARCHAR2,
                                    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                   SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                   SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)  IS


    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "PV_CON_DATOS_OOSS_PR"
    Lenguaje="PL/SQL"
    Fecha="17-03-2008"
    Versión="1.0.0"
    Diseñador="Matías Guajardo"
    Programador="Matías Guajardo"
    Ambiente="BD">
    <Retorno>  </Retorno>
    <Descripción> Consulta de clientes </Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EV_cod_os" Tipo="VARCHAR2"> </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error                   ge_errores_pg.DesEvent;
    LV_sSql                           ge_errores_pg.vQuery;

    BEGIN
      sn_cod_retorno     := 0;
      sv_mens_retorno := NULL;
      sn_num_evento     := 0;

      SELECT a.cod_tipmodi,a.grupo
      INTO SV_cod_tipmodi, SV_grupo
      FROM  ci_tiporserv a
      WHERE a.COD_OS = EV_cod_os;

   EXCEPTION
    WHEN OTHERS THEN
          SN_cod_retorno := 205;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := 'ggg';
          END IF;
          LV_des_error   := 'Pv_AbonoLimiteConsumo_Pg ('||EV_cod_os ||'); '||SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,1, USER, 'PV_CON_DATOS_OOSS_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    END PV_CON_DATOS_OOSS_PR;
PROCEDURE PV_REC_SECUENCIA_PR ( EV_NOM_SECUENCIA   IN VARCHAR2,
                                SN_secuencia       OUT NOCOPY NUMBER,
                                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                               SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                               SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS


    /*
    <Documentación
       TipoDoc = "FUNCTION">
       <Elemento
          Nombre = "PR_SECUENCIA_PRODUCTO_FN"
          Lenguaje="PL/SQL"
          Fecha creación="Marzo-2008"
          Creado por="Matias Guajardo U."
          Fecha modificacion=""
          Modificado por=""
          Ambiente Desarrollo="BD">
          <Retorno>n/a</Retorno>
          <Descripción> Retorna secuencia de cualquier tabla </Descripción>
          <Parámetros>         <Entrada>
             </Entrada>
             <Salida>
             </Salida>
          </Parámetros>
       </Elemento>
    </Documentación>
    */

    LV_sql                  VARCHAR2(250);
    SV_sql                  VARCHAR2(250);
    LV_des_error            ge_errores_pg.DesEvent;
    LV_sSql                 ge_errores_pg.vQuery;

    BEGIN

      SV_sql := 'SELECT '||EV_NOM_SECUENCIA||'.NEXTVAL FROM DUAL';
      EXECUTE IMMEDIATE SV_sql
      INTO SN_secuencia;
    --RETURN LN_secuencia ;

     EXCEPTION
    WHEN OTHERS THEN
          SN_cod_retorno := 205;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := 'ggg';
          END IF;
          LV_des_error := ' FALLO EN PV_ooss_PG.PV_REC_SECUENCIA_PR. ERROR: ' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,1, USER, 'PV_REC_SECUENCIA_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END  PV_REC_SECUENCIA_PR;
    PROCEDURE PV_CNSLTA_DAT_BASICOSCLT_PR(
    EN_COD_CLIENTE                IN GE_CLIENTES.COD_CLIENTE%TYPE,
    SV_NOM_CLIENTE              OUT GE_CLIENTES.NOM_CLIENTE%TYPE,
    SV_NOM_APECLIEN1            OUT GE_CLIENTES.NOM_APECLIEN1%TYPE,
    SV_NOM_APECLIEN2            OUT GE_CLIENTES.NOM_APECLIEN2%TYPE,
    SV_COD_TIPIDENT             OUT GE_TIPIDENT.COD_TIPIDENT%TYPE,
    SV_DES_TIPIDENT             OUT GE_TIPIDENT.DES_TIPIDENT%TYPE,
    SV_NUM_IDENT                OUT GE_CLIENTES.NUM_IDENT%TYPE,
    SN_COD_CUENTA               OUT GA_CUENTAS.COD_CUENTA%TYPE,
    SV_DES_CUENTA               OUT GA_CUENTAS.DES_CUENTA%TYPE,
    SN_COD_RETORNO                   OUT NOCOPY   GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO                  OUT NOCOPY   GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                     OUT NOCOPY    GE_ERRORES_PG.EVENTO
  )
 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_cnslta_dat_basicosclt_pr"
      Lenguaje="PL/SQL"
      Fecha="08-07-2008"
      Versión="1.0"
      Diseñador="Santiago Ventura
      Programador="Santiago Ventura
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  consultar los datos basicos del cliente </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo Cliente</param>
         </Entrada>
         <Salida>
            <param nom="SV_NOM_CLIENTE   Tipo="Varchar2>Nombre del Cliente</param>
           <param nom="SV_NOM_APECLIEN1  Tipo="Varchar2"">Primer apellido del Cliente</param>
           <param nom="SV_NOM_APECLIEN2  Tipo="Varchar2"">Segundo apellido del Cliente </param>
           <param nom="SV_COD_TIPIDENT  Tipo="Varchar2"">Código del tipo de Identificacion</param>
           <param nom="SV_DES_TIPIDENT  Tipo="Varchar2"">Descripcion del tipo de Identificacion</param>
           <param nom="SV_NUM_IDENT  Tipo="Varchar2"">Número Identificación </param>
           <param nom="SN_COD_CUENTA  Tipo="Number"">Codigo de la Cuenta del Cliente</param>
           <param nom="SV_DES_CUENTA  Tipo="Varchar2"">Descripcion de la Cuenta del Cliente</param>
            <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
BEGIN
     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

            LV_sSql:=' SELECT A.NOM_CLIENTE, A.NOM_APECLIEN1, A.NOM_APECLIEN2, A.COD_TIPIDENT, B.DES_TIPIDENT, A.NUM_IDENT, A.COD_CUENTA, C.DES_CUENTA '||
            ' FROM GE_CLIENTES A, GE_TIPIDENT B, GA_CUENTAS C  '||
            ' WHERE A.COD_CLIENTE ='|| EN_COD_CLIENTE ||' AND  '||
            ' A.COD_TIPIDENT = B.COD_TIPIDENT AND  '||
            ' A.COD_CUENTA = C.COD_CUENTA ';

            SELECT A.NOM_CLIENTE, A.NOM_APECLIEN1, A.NOM_APECLIEN2, A.COD_TIPIDENT, B.DES_TIPIDENT, A.NUM_IDENT, A.COD_CUENTA, C.DES_CUENTA
            INTO SV_NOM_CLIENTE, SV_NOM_APECLIEN1, SV_NOM_APECLIEN2, SV_COD_TIPIDENT, SV_DES_TIPIDENT, SV_NUM_IDENT, SN_COD_CUENTA, SV_DES_CUENTA
            FROM GE_CLIENTES A, GE_TIPIDENT B, GA_CUENTAS C
            WHERE A.COD_CLIENTE = EN_COD_CLIENTE  AND A.COD_TIPIDENT = B.COD_TIPIDENT AND A.COD_CUENTA = C.COD_CUENTA;

             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
             SN_num_evento := 0;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
                         SN_cod_retorno := 222;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('pv_cnslta_dat_basicosclt_pr(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_CambioDatosCliente_PG.pv_cnslta_dat_basicosclt_pr', LV_sSql, SN_cod_retorno, LV_des_error );

        WHEN OTHERS THEN
                     SN_cod_retorno := GV_error_others;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('pv_cnslta_dat_basicosclt_pr(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_CambioDatosCliente_PG.pv_cnslta_dat_basicosclt_pr', LV_sSql, SN_cod_retorno, LV_des_error );
END PV_CNSLTA_DAT_BASICOSCLT_PR;

PROCEDURE PV_cnslta_parametro_PR(    EN_cod_producto      IN ged_parametros.cod_producto%TYPE,
                                       EV_cod_modulo         IN ged_parametros.cod_modulo%TYPE,
                                    EV_nom_parametro      IN ged_parametros.nom_parametro%TYPE,
                                    SV_val_parametro     OUT NOCOPY ged_parametros.val_parametro%TYPE,
                                    SV_des_parametro     OUT NOCOPY ged_parametros.des_parametro%TYPE,
                                    SV_nom_usuario          OUT NOCOPY ged_parametros.nom_usuario%TYPE,
                                    SD_fec_alta          OUT NOCOPY ged_parametros.fec_alta%TYPE,
                                      SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento          OUT NOCOPY ge_errores_pg.Evento)   IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "PV_cnslta_parametro_PR"
Lenguaje="PL/SQL"
Fecha="17-03-2008"
Versión="1.0.0"
Diseñador="Patricio Gallegos"
Programador="Patricio Gallegos"
Ambiente="BD">
<Retorno> Valor parámetro </Retorno>
<Descripción> Consulta y retorna valor parámetro configurado en la tabla GED_PARAMETROS</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_cod_producto"  Tipo="NUMBER"> </param>
        <param nom="EV_cod_modulo"  Tipo="VARCHAR"> </param>
        <param nom="EV_nom_parametro"  Tipo="VARCHAR"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_val_parametro"  Tipo="VARCHAR"> </param>
        <param nom="SV_des_parametro"  Tipo="VARCHAR"> </param>
        <param nom="SV_nom_usuario"  Tipo="VARCHAR"> </param>
        <param nom="SD_fec_alta"  Tipo="DATE"> </param>
        <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
        <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                       GE_ERRORES_PG.vQuery;

BEGIN

    sSql := 'SELECT a.val_parametro, a.des_parametro, a.nom_usuario, a.fec_alta';
    sSql := sSql || ' INTO SV_val_parametro, SV_des_parametro, SV_nom_usuario, SD_fec_alta';
    sSql := sSql || ' FROM ged_parametros a';
    sSql := sSql || ' WHERE a.cod_producto = ' || EN_cod_producto;
    sSql := sSql || ' AND a.cod_modulo = ' || EV_cod_modulo;
    sSql := sSql || ' AND a.nom_parametro = ' || EV_nom_parametro;

    SELECT a.val_parametro, a.des_parametro, a.nom_usuario, a.fec_alta
    INTO SV_val_parametro, SV_des_parametro, SV_nom_usuario, SD_fec_alta
    FROM ged_parametros a
    WHERE a.cod_producto = EN_cod_producto
    AND a.cod_modulo = EV_cod_modulo
    AND a.nom_parametro = EV_nom_parametro;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
WHEN NO_DATA_FOUND THEN
SV_val_parametro := NULL;
SV_des_parametro:= NULL;
SV_nom_usuario := NULL;
SD_fec_alta := NULL;

WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución PL-SQL PV_cnslta_parametro_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'PV_cnslta_parametro_PR', sSql, SQLCODE, LV_des_error );
END PV_cnslta_parametro_PR;
PROCEDURE PV_cnslta_parametro_LK_PR(EN_cod_producto      IN ged_parametros.cod_producto%TYPE,
                                       EV_cod_modulo         IN ged_parametros.cod_modulo%TYPE,
                                    EV_nom_parametro      IN ged_parametros.nom_parametro%TYPE,
                                    SC_PARAMETROS        OUT NOCOPY REFCURSOR,
                                      SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                    SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_num_evento          OUT NOCOPY ge_errores_pg.Evento)   IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "PV_cnslta_parametro_LK_PR"
Lenguaje="PL/SQL"
Fecha="17-03-2008"
Versión="1.0.0"
Diseñador="Patricio"
Programador="Patricio"
Ambiente="BD">
<Retorno> Valor parámetro </Retorno>
<Descripción> Consulta y retorna valor parámetro configurado en la tabla GED_PARAMETROS</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_cod_producto"  Tipo="NUMBER"> </param>
        <param nom="EV_cod_modulo"  Tipo="VARCHAR"> </param>
        <param nom="EV_nom_parametro"  Tipo="VARCHAR"> </param>
    </Entrada>
    <Salida>
        <param nom="SC_PARAMETROS"     Tipo="REFCURSOR> PARAMETROS</param>
        <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
        <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                       GE_ERRORES_PG.vQuery;

BEGIN

    sSql := 'SELECT a.val_parametro, a.des_parametro, a.nom_usuario, a.fec_alta, a.nom_parametro';
    sSql := sSql || ' FROM ged_parametros a';
    sSql := sSql || ' WHERE a.cod_producto = ' || EN_cod_producto;
    sSql := sSql || ' AND a.cod_modulo = ' || EV_cod_modulo;
    sSql := sSql || ' AND a.nom_parametro like ' || EV_nom_parametro || '%';

    OPEN SC_PARAMETROS FOR
    SELECT a.val_parametro, a.des_parametro, a.nom_usuario, a.fec_alta, a.nom_parametro
    FROM ged_parametros a
    WHERE a.cod_producto = EN_cod_producto
    AND a.cod_modulo = EV_cod_modulo
    AND a.nom_parametro like EV_nom_parametro || '%';

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución PL-SQL PV_cnslta_parametro_LK_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'PV_cnslta_parametro_LK_PR', sSql, SQLCODE, LV_des_error );
END PV_cnslta_parametro_LK_PR;
PROCEDURE PV_EJEC_PV_GRUPO_TEC_FN_PR( EV_CODTECNOLOGIA       IN VARCHAR2,
                                            SV_GRUPOTECNOLOGIA     OUT NOCOPY VARCHAR2,
                                          SN_cod_retorno         OUT NOCOPY ge_errores_pg.CodError,
                                             SV_mens_retorno        OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_num_evento          OUT NOCOPY ge_errores_pg.Evento) IS

    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "PV_EJEC_PV_GRUPO_TEC_FN_PR"
    Lenguaje="PL/SQL"
    Fecha="21-04-2008"
    Versión="1.0.0"
    Diseñador="Héctor Hermosilla"
    Programador="Héctor Hermosilla"
    Ambiente="BD">
    <Descripción> Ejecuta PL GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN</Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EV_CODTECNOLOGIA"       Tipo="VARCHAR2"> Codigo Tecnologia </param>
        </Entrada>
        <Salida>
            <param nom="SV_GRUPOTECNOLOGIA"    Tipo="VARCHAR2"> Grupo Tecnologia </param>
            <param nom="SN_cod_retorno"        Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"       Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"         Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */
    LV_des_error                   ge_errores_pg.DesEvent;
    LV_sSql                           ge_errores_pg.vQuery;

    ERROR_EJECUCION               EXCEPTION;
    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;
        LV_sSQL:= 'GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(' || EV_CODTECNOLOGIA || ')';
        SV_GRUPOTECNOLOGIA:= GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(EV_CODTECNOLOGIA);
        IF (SV_GRUPOTECNOLOGIA ='ERROR') THEN
            RAISE ERROR_EJECUCION;
        END IF;

    EXCEPTION
    WHEN ERROR_EJECUCION THEN
          SN_cod_retorno := 237;
          LV_des_error   := 'GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(' || EV_CODTECNOLOGIA || '); ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1, USER, 'PV_intermediario_PG.PV_EJEC_PV_GRUPO_TEC_FN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );
      WHEN OTHERS THEN
          SN_cod_retorno := 237;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := 'PV_intermediario_PG.PV_EJEC_PV_GRUPO_TEC_FN_PR';
          END IF;
          LV_des_error   := 'GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(' || EV_CODTECNOLOGIA || '); ' || SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,1, USER, 'PV_intermediario_PG.PV_EJEC_PV_GRUPO_TEC_FN_PR', LV_sSQL, SN_cod_retorno, LV_des_error );

    END PV_EJEC_PV_GRUPO_TEC_FN_PR;
PROCEDURE PV_CONS_CICLO_FACT_HIB_PR(
    EN_COD_CICLO         IN   FA_CICLFACT.COD_CICLO%TYPE,
    EN_COD_CLIENTE       IN  GA_INFACCEL.COD_CLIENTE %TYPE,
    EN_NUM_ABONADO  IN GA_INFACCEL.NUM_ABONADO%TYPE,
    SN_EXISTE                  OUT NOCOPY NUMBER,
    SN_COD_RETORNO    OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
   /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_CICLO_FACT_HIB_PR"
      Lenguaje="PL/SQL"
      Fecha="08-07-2008"
      Versión="1.0"
      Diseñador="ALEJANDRO DIAZ
      Programador="ALEJANDRO DIAZ
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
     <Descripción> Consultamos SI ES VALIDO EL CICLO DEL ABONADO HIBRIDO</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CICLO" Tipo="Number">codigo del ciclo del abonado </param>
          <param nom="EN_COD_CLIENTE" Tipo="Number">codigo del ciiente</param>
          <param nom="EN_NUM_ABONADO" Tipo="Number">numero del abonado</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SN_EXISTE   Tipo="Number>si es 0 no es valido , si es uno es valido</param>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;
    LN_COD_CICLFACT           NUMBER;
BEGIN
     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

        LV_sSql:= '  SELECT COD_CICLFACT'||
                         ' FROM FA_CICLFACT'||
                       ' WHERE COD_CICLO ='|| EN_COD_CICLO||
                       ' AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM';

          SELECT COD_CICLFACT into LN_COD_CICLFACT
         FROM FA_CICLFACT
         WHERE COD_CICLO = EN_COD_CICLO
         AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

        LV_sSql:= null;
        LV_sSql:= '  SELECT COUNT(1)'||
                      ' FROM GA_INFACCEL'||
                      ' WHERE  cod_cliente ='||EN_COD_CLIENTE||
                      ' AND NUM_ABONADO  ='||EN_NUM_ABONADO||
                      ' AND COD_CICLFACT ='|| LN_COD_CICLFACT;

        SELECT COUNT(1) INTO SN_EXISTE
        FROM GA_INFACCEL
        WHERE  cod_cliente =EN_COD_CLIENTE
        AND NUM_ABONADO  =EN_NUM_ABONADO
        AND COD_CICLFACT = LN_COD_CICLFACT;

             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
             SN_num_evento := 0;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                    SN_cod_retorno := 998;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('PV_CONS_CICLO_FACT_HIB_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_RECARGA_PREPAGO_PG.PV_CONS_CICLO_FACT_HIB_PR', LV_sSql, SN_cod_retorno, LV_des_error );

         WHEN OTHERS THEN
                     SN_cod_retorno := 998;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('PV_CONS_CICLO_FACT_HIB_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_RECARGA_PREPAGO_PG.PV_CONS_CICLO_FACT_HIB_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END  PV_CONS_CICLO_FACT_HIB_PR;
PROCEDURE PV_cons_deuda_cliente_PR(     en_num_abonado        IN co_cartera.NUM_ABONADO%TYPE,
                                     sn_count                       OUT NOCOPY NUMBER,
                                  SN_cod_retorno            OUT NOCOPY ge_errores_pg.CodError,
                                  SV_mens_retorno           OUT NOCOPY ge_errores_pg.MsgError,
                                  SN_num_evento             OUT NOCOPY ge_errores_pg.Evento) IS

LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                       GE_ERRORES_PG.vQuery;

BEGIN

    sSql := ' select count(1) from co_cartera'||
                '  where num_abonado =' ||en_num_abonado||
               '  and importe_debe>importe haber';

    SELECT COUNT (1) INTO sn_count FROM co_cartera
    WHERE num_abonado = en_num_abonado
    AND importe_debe>importe_haber;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
WHEN OTHERS THEN
         SN_cod_retorno := 156;
         SV_mens_retorno := 'Error en ejecución PL-SQL PV_cons_deuda_cliente_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'PV_cons_deuda_cliente_PR', sSql, SQLCODE, LV_des_error );
END PV_cons_deuda_cliente_PR;
PROCEDURE PV_cnslta_categoria_plan_PR(    EN_cod_producto        IN ve_catplantarif.cod_producto%TYPE,
                                           EV_cod_plantarif      IN ve_catplantarif.cod_plantarif%TYPE,
                                        SV_cod_categoria     OUT NOCOPY ve_catplantarif.cod_categoria%TYPE,
                                           SN_cod_retorno          OUT NOCOPY ge_errores_pg.CodError,
                                        SV_mens_retorno         OUT NOCOPY ge_errores_pg.MsgError,
                                        SN_num_evento           OUT NOCOPY ge_errores_pg.Evento)   IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "PV_cnslta_categoria_plan_PR"
Lenguaje="PL/SQL"
Fecha="17-03-2008"
Versión="1.0.0"
Diseñador="Patricio Gallegos"
Programador="Patricio Gallegos"
Ambiente="BD">
<Retorno> Código categoría configurada para el plan tarifario </Retorno>
<Descripción> Consulta y retorna código categoría configurada para el plan tarifario</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_cod_producto"  Tipo="NUMBER"> </param>
        <param nom="EV_cod_plantarif"  Tipo="VARCHAR"> </param>
    </Entrada>
    <Salida>
        <param nom="SV_cod_categoria"  Tipo="VARCHAR"> </param>
        <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
        <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
        <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LV_des_error               GE_ERRORES_PG.DesEvent;
sSql                       GE_ERRORES_PG.vQuery;

BEGIN

    sSql := 'SELECT a.cod_categoria INTO SV_cod_categoria';
    sSql := sSql || ' FROM ve_catplantarif a';
    sSql := sSql || ' WHERE a.cod_producto = ' || EN_cod_producto;
    sSql := sSql || ' AND a.cod_plantarif = ' || EV_cod_plantarif;
    sSql := sSql || ' AND SYSDATE BETWEEN a.fec_efectividad AND NVL(a.fec_finefectividad,SYSDATE)';

    SELECT a.cod_categoria INTO SV_cod_categoria
    FROM ve_catplantarif a
    WHERE a.cod_producto = EN_cod_producto
    AND a.cod_plantarif = EV_cod_plantarif
    AND SYSDATE BETWEEN a.fec_efectividad AND NVL(a.fec_finefectividad,SYSDATE);

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
WHEN OTHERS THEN
         SN_cod_retorno := 4;
         SV_mens_retorno := 'Error en ejecución PL-SQL PV_cnslta_categoria_plan_PR.';
        LV_des_error := SQLERRM;
        SN_num_evento:= Ge_Errores_Pg.Grabarpl( 0, 'PV', SV_mens_retorno, '1.0', USER,
        'PV_cnslta_categoria_plan_PR', sSql, SQLCODE, LV_des_error );
END PV_cnslta_categoria_plan_PR;

    PROCEDURE PV_con_cliente_empresa_PR (EV_cod_cliente     IN NUMBER,
                                         EV_cod_producto    IN NUMBER,
                                         SV_tip_plantarif   OUT NOCOPY VARCHAR2,
                                         SV_cod_plantarif   OUT NOCOPY VARCHAR2,
                                         SV_des_plantarif   OUT NOCOPY VARCHAR2,
                                         SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento) IS

    /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "PV_con_cliente_empresa_PR"
    Lenguaje="PL/SQL"
    Fecha="17-03-2008"
    Versión="1.0.0"
    Diseñador="Matías Guajardo"
    Programador="Matías Guajardo"
    Ambiente="BD">
    <Retorno>  </Retorno>
    <Descripción> Consulta para saber si es empresa </Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EV_cod_cliente Tipo="NUMBER"> </param>
            <param nom="EV_cod_producto Tipo="NUMBER"> </param>
        </Entrada>
        <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */


    LV_des_error                   ge_errores_pg.DesEvent;
    LV_sSql                           ge_errores_pg.vQuery;


    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;


    SELECT  C.TIP_PLANTARIF, A.COD_PLANTARIF, C.DES_PLANTARIF
    INTO SV_tip_plantarif, SV_cod_plantarif, SV_des_plantarif
    FROM GA_EMPRESA A, GE_CLIENTES B, TA_PLANTARIF C
    WHERE B.COD_CLIENTE = EV_cod_cliente
    AND B.COD_CLIENTE = A.COD_CLIENTE
    AND A.COD_PLANTARIF = C.COD_PLANTARIF
    AND A.COD_PRODUCTO = C.COD_PRODUCTO
    AND A.COD_PRODUCTO = EV_cod_producto
    AND ROWNUM=1;

    EXCEPTION
    WHEN OTHERS THEN
          SN_cod_retorno := 205;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := 'ggg';
          END IF;
          LV_des_error   := 'Pv_AbonoLimiteConsumo_Pg ('||EV_cod_cliente||'); '||SQLERRM;
          LV_des_error   := 'Pv_AbonoLimiteConsumo_Pg ('||EV_cod_producto||'); '||SQLERRM;
          SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,1, USER, 'PV_con_cliente_empresa_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    END PV_con_cliente_empresa_PR;
    PROCEDURE PV_con_abonado_pospago_PR (EV_num_abonado     IN OUT NOCOPY NUMBER,
                                         SC_abonados        OUT NOCOPY RefCursor,
                                         SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)  IS

       /*
    <Documentación TipoDoc = "Procedimiento">
    <Elemento Nombre = "PV_con_abonado_pospago_PR"
    Lenguaje="PL/SQL"
    Fecha="17-03-2008"
    Versión="1.0.0"
    Diseñador="Matías Guajardo"
    Programador="Matías Guajardo"
    Ambiente="BD">
    <Retorno>  </Retorno>
    <Descripción> Consulta de abonados pospago</Descripción>
    <Parámetros>
        <Entrada>
            <param nom="EV_num_abonado Tipo="NUMBER"> </param>
          </Entrada>
        <Salida>
            <param nom="SC_abonados"    Tipo="CURSOR>    Cursor de salida </param>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
        </Salida>
    </Parámetros>
    </Elemento>
    </Documentación>
    */

    LV_des_error                   ge_errores_pg.DesEvent;
    LV_sSql                           ge_errores_pg.vQuery;
    l_vCursor                   RefCursor;

    BEGIN
        sn_cod_retorno     := 0;
        sv_mens_retorno := NULL;
        sn_num_evento     := 0;

        OPEN l_vCursor FOR
        SELECT NUM_ABONADO, COD_PRODUCTO, COD_CUENTA,
           COD_SUBCUENTA, COD_CLIENTE, COD_USUARIO,
           COD_SITUACION, COD_ESTADO,COD_VENDEDOR,
           COD_VENDEDOR_AGENTE, CLASE_SERVICIO, COD_CARGOBASICO,
           COD_CREDCON, COD_CREDMOR, COD_LIMCONSUMO, COD_PLANSERV,
           COD_PLANTARIF, COD_TIPCONTRATO, COD_USO,
           FEC_ACTCEN, FEC_ALTA, FEC_BAJA, FEC_BAJACEN, FEC_FINCONTRA, FEC_ULTMOD,
           IND_FACTUR, IND_PROCALTA, IND_PROCEQUI, IND_REHABI,
           IND_SEGURO, IND_SUSPEN, NOM_USUARORA, NUM_ANEXO,
           NUM_CONTRATO, NUM_SERIE, NUM_SERIEMEC, PERFIL_ABONADO,
           COD_CENTRAL, NUM_VENTA, COD_EMPRESA, COD_HOLDING, COD_MODVENTA, COD_CAUSABAJA,
           COD_CICLO, COD_GRPSERV, FEC_ACEPVENTA, FEC_CUMPLAN, NUM_PERCONTRATO,
           TIP_PLANTARIF, TIP_TERMINAL, FEC_CUMPLIMEN, FEC_RECDOCUM,
           IND_INSGUIAS, NUM_CELULAR, COD_CENTRAL_PLEX, COD_REGION,
           COD_PROVINCIA, COD_CIUDAD, IND_PLEXSYS, NUM_CELULAR_PLEX,
           NUM_SERIEHEX, COD_CELDA, NUM_PERSONAL, COD_CARRIER,
           COD_OPREDFIJA, IND_PREPAGO, IND_SUPERTEL, NUM_TELEFIJA,
           COD_VENDEALER, IND_DISP, IND_EQPRESTADO,
           FEC_PRORROGA, NUM_MIN, NUM_IMEI, COD_TECNOLOGIA
    FROM GA_ABOCEL ga
    WHERE ga.num_abonado = EV_num_abonado
    AND ga.IND_SUPERTEL <> 7;

    SC_abonados := l_vCursor;

    EXCEPTION
    WHEN OTHERS THEN
          SN_cod_retorno := 205;
          IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
             SV_mens_retorno := 'ggg';
          END IF;
          LV_des_error := ' FALLO EN Pv_AbonoLimiteConsumo_Pg.PV_con_abonado_pospago_PR. ERROR: ' || SQLERRM;
             SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno,1, USER, 'PV_con_abonado_pospago_PR', LV_sSQL, SN_cod_retorno, LV_des_error );


    END PV_con_abonado_pospago_PR;
PROCEDURE pv_cnslta_vende_usuario_pr (
    EV_nom_usuario                  IN   GE_SEG_USUARIO.NOM_USUARIO%type,
    SN_cod_vendedor               OUT GE_SEG_USUARIO.COD_VENDEDOR%type,
    SN_cod_tipcomis                 OUT GE_SEG_USUARIO.COD_TIPCOMIS%type,
    SN_cod_oficina                   OUT GE_SEG_USUARIO.COD_OFICINA%type,
    SN_cod_retorno                   OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno                  OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                    OUT NOCOPY    ge_errores_pg.Evento
   )
 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ga_indicador_format_fech_pr"
      Lenguaje="PL/SQL"
      Fecha="10-06-2008"
      Versión="1.0"
      Diseñador="Alejandro Diaz"
      Programador="Yesenia Osses V."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>  buscar al abonado</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de Celular</param>
         </Entrada>
         <Salida>
            <param nom="SC_factura" Tipo="GURSOR" >Cursor de indicadores de formato de fecha/param>
            <param nom="SN_cod_retorno"  Tipo="NUMERICO" >Código de Retorno (descripción de error)</param>
            <param nom="SV_mens_retorno"  Tipo="VARCHAR" >Mensaje de Retorno (código de error)</param>
            <param nom="SN_num_evento"  Tipo="NUMERICO" >Número de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql                  ge_errores_pg.vQuery;
    abonado                  number;
BEGIN

     SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;

            LV_sSql:=' SELECT COD_VENDEDOR, COD_TIPCOMIS, COD_OFICINA FROM GE_SEG_USUARIO WHERE NOM_USUARIO = '||EV_nom_usuario;

            --obtenemos el vendedor, el comisionista, y el codigo de oficina<
            SELECT COD_VENDEDOR, COD_TIPCOMIS, COD_OFICINA into SN_cod_vendedor, SN_cod_tipcomis, SN_cod_oficina
            FROM GE_SEG_USUARIO WHERE NOM_USUARIO = EV_nom_usuario;

             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
             SN_num_evento := 0;
        /* El Cod_oficina no se ocupara, ya que es tema de ventas */
EXCEPTION
           WHEN NO_DATA_FOUND THEN
                      SN_cod_retorno := 151;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('pv_cnslta_vende_usuario_pr(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_CAMSIMCARD_PG.pv_cnslta_vende_usuario_pr', LV_sSql, SN_cod_retorno, LV_des_error );

            WHEN OTHERS THEN
                     SN_cod_retorno := GV_error_others;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('pv_cnslta_vende_usuario_pr(''); - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_CAMSIMCARD_PG.pv_cnslta_vende_usuario_pr', LV_sSql, SN_cod_retorno, LV_des_error );

END pv_cnslta_vende_usuario_pr;
PROCEDURE GA_ELIMINA_RANGOS_PR (
    EV_num_celular                 IN   GA_ABOCEL.NUM_CELULAR%TYPE,
    SN_cod_retorno                  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno                 OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                   OUT NOCOPY    ge_errores_pg.Evento
   )
IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql                  ge_errores_pg.vQuery;
    abonado                  number;
BEGIN

      UPDATE GA_RANGOS_FIJOS_TO 
      SET ESTADO=1
      WHERE 
      NUM_DESDE IN 
      (SELECT NUM_DESDE 
      FROM GA_NRO_PILOTO_RANGO_TO 
      WHERE NUM_PILOTO= EV_NUM_CELULAR );
                      
      DELETE FROM 
      GA_NRO_PILOTO_RANGO_TO
      WHERE NUM_PILOTO= EV_NUM_CELULAR;


EXCEPTION
           WHEN NO_DATA_FOUND THEN
                      SN_cod_retorno := 151;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('GA_ELIMINA_RANGOS_PR; - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ELIMINA_RANGOS_PR', LV_sSql, SN_cod_retorno, LV_des_error );

            WHEN OTHERS THEN
                     SN_cod_retorno := GV_error_others;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('GA_ELIMINA_RANGOS_PR; - ' || SQLERRM,1,GN_largoerrtec);
                      SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'GA_ELIMINA_RANGOS_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END GA_ELIMINA_RANGOS_PR;

END Pv_ventas_enlace_vpn_Pg;
/
SHOW ERRORS