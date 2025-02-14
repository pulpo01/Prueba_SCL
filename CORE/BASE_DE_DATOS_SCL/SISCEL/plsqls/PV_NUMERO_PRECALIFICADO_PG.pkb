CREATE OR REPLACE PACKAGE BODY PV_NUMERO_PRECALIFICADO_PG AS
/******************************************************************************
   NAME:       PV_NUMERO_PRECALIFICADO_PG
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        27/05/2010             1. Created this package body.
******************************************************************************/

PROCEDURE PV_RESCATA_NUMEROCALIFICADO_PR (EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                                          ENCarga         IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                                          RCelular   IN OUT NOCOPY TCelularCalif)
IS
BEGIN

     SELECT *
     BULK COLLECT INTO RCelular
     FROM PV_CALIFICA_CELULAR_TO A
     WHERE EXISTS (SELECT 1 FROM PV_CARGA_CALICELU_TO B
                   WHERE b.nom_archivo=EVNombreArchivo
                     AND b.nro_carga=ENCarga
                     AND b.num_celular=a.num_celular);
                     
END PV_RESCATA_NUMEROCALIFICADO_PR;

PROCEDURE PV_RESCATA_ABONADOS_PR (EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                                  ENCarga         IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                                  RAbonados   IN OUT NOCOPY TAbonados)
IS
 LVSituacion  VARCHAR2(3):='AAA';
BEGIN

     SELECT *
     BULK COLLECT INTO RAbonados
     FROM GA_ABOAMIST A
     WHERE EXISTS (SELECT 1 FROM PV_CARGA_CALICELU_TO b 
                   WHERE b.nom_archivo=EVNombreArchivo 
                     AND b.nro_carga=ENCarga 
                     AND b.num_celular=a.num_celular)
          AND a.cod_situacion=LVSituacion;
END PV_RESCATA_ABONADOS_PR;     
FUNCTION PV_VALIDA_ABONADOPREPAGO_PR(EN_Celular  IN PV_CARGA_CALICELU_TO.num_celular%type,
                                     RAbonados   IN  TAbonados,
                                     SN_Abonado   IN OUT NOCOPY PV_CARGA_CALICELU_TO.num_abonado%type)
RETURN BOOLEAN
IS
LB_Ret    Boolean:=FALSE;
BEGIN
    SN_Abonado:=null;
    IF RAbonados.LAST IS NOT NULL THEN
         FOR i IN RAbonados.FIRST .. RAbonados.LAST LOOP
            IF RAbonados(i).num_celular=EN_Celular THEN
               SN_Abonado:=RAbonados(i).num_abonado;
               LB_Ret:= TRUE;
               EXIT;
            END IF;
         END LOOP;
    ELSE
       RETURN FALSE;  
    END IF;
    
    IF  LB_Ret THEN
        RETURN TRUE;        
    ELSE
            RETURN FALSE;  
    END IF ;
END PV_VALIDA_ABONADOPREPAGO_PR;
FUNCTION PV_VALIDA_CELULARCAL_FN(EN_Celular  IN PV_CARGA_CALICELU_TO.num_celular%type,
                                  RCelular   IN  TCelularCalif,
                                  SV_Califica IN OUT NOCOPY PV_CALIFICA_CELULAR_TO.cod_califica%type)
RETURN BOOLEAN
IS
LRet PLS_INTEGER:=0;
BEGIN
    SV_Califica:=null;
    IF RCelular.LAST IS NOT NULL THEN
     FOR i IN RCelular.FIRST .. RCelular.LAST LOOP
        IF RCelular(i).num_celular=EN_Celular THEN
            SV_Califica:=RCelular(i).cod_califica;
            LRet:=1;
            EXIT;
        END IF;
     END LOOP;
     
       IF  LRet=0 THEN
            RETURN FALSE;    ---No existe    
       ELSE
            RETURN TRUE;   --Existe combinacion califica-celular 
       END IF ;
    ELSE
         RETURN FALSE;
    END IF; 
END PV_VALIDA_CELULARCAL_FN;
PROCEDURE PV_TRASPASA_REGISTROSCV (EV_Califica  IN PV_CALIFICA_CELULAR_TH.cod_califica%type,
                                   EN_Celular   IN PV_CALIFICA_CELULAR_TH.num_celular%type,
                                   EN_Abonado   IN PV_CALIFICA_CELULAR_TH.num_abonado%type,
                                   EN_Vendedor  IN PV_CALIFICA_CELULAR_TH.cod_vendedor%type,
                                   EN_Usuario   IN PV_CALIFICA_CELULAR_TH.nom_usuario%type,
                                   EN_FecIngreso IN PV_CALIFICA_CELULAR_TH.fecha_carga%type,
                                   RNroPrecalCV IN OUT NOCOPY TCargaCalifCV)
IS
indice   number;
LN_Vigente PLS_INTEGER:=0;
BEGIN
    IF RNroPrecalCV.last is null THEN
        indice:=CN_uno;
    ELSE
        indice:=RNroPrecalCV.last + CN_uno;
    END IF;
    RNroPrecalCV(indice).cod_califica:=EV_Califica;
    RNroPrecalCV(indice).num_celular:=EN_Celular;
    RNroPrecalCV(indice).num_abonado:=EN_Abonado;
    RNroPrecalCV(indice).cod_vendedor:=EN_Vendedor;
    RNroPrecalCV(indice).vigencia:=LN_Vigente;
    RNroPrecalCV(indice).fec_historico:=sysdate;
    RNroPrecalCV(indice).nom_usuario:=EN_Usuario;
    RNroPrecalCV(indice).fecha_carga:=EN_FecIngreso;
END PV_TRASPASA_REGISTROSCV;
PROCEDURE PV_TRASPASA_REGISTROSOK (EV_Califica IN PV_CALIFICA_CELULAR_TO.cod_califica%type,
                                   EN_Celular  IN PV_CALIFICA_CELULAR_TO.num_celular%type,
                                   EN_Abonado  IN PV_CALIFICA_CELULAR_TO.num_abonado%type,
                                   EN_Vendedor IN PV_CALIFICA_CELULAR_TO.cod_vendedor%type,
                                   EN_Vigencia IN PV_CALIFICA_CELULAR_TO.vigencia%type,
                                   EN_Usuario  IN PV_CALIFICA_CELULAR_TO.nom_usuario%type,
                                   EN_FecIngreso IN PV_CALIFICA_CELULAR_TO.fecha_carga%type                                   ,
                                   RNroPrecal  IN OUT NOCOPY TCargaCalifOK)
IS
indice   number;
BEGIN
    IF RNroPrecal.last is null THEN
        indice:=CN_uno;
    ELSE
        indice:=RNroPrecal.last + CN_uno;
    END IF;
    RNroPrecal(indice).cod_califica:=EV_Califica;
    RNroPrecal(indice).num_celular:=EN_Celular;
    RNroPrecal(indice).num_abonado:=EN_Abonado;
    RNroPrecal(indice).cod_vendedor:=EN_Vendedor;
    RNroPrecal(indice).vigencia:=EN_Vigencia;
    RNroPrecal(indice).nom_usuario:=EN_Usuario;
    RNroPrecal(indice).fecha_carga:=EN_FecIngreso;
END PV_TRASPASA_REGISTROSOK;
PROCEDURE PV_CAMBIA_PROCESOCARGA_PR(EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                               ENCarga         IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                               RProcesoUP      IN  TProceso,
                               RAbonadoUP      IN  TAbonado,
                               RCalificaUP     IN  TCalifica,
                               RCelularUP      IN  TCelular)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    IF RProcesoUP.last is not null THEN
        FORALL   iInd  IN 1 .. RProcesoUP.COUNT
        SAVE EXCEPTIONS
        UPDATE PV_CARGA_CALICELU_TO
        SET cod_proceso=RProcesoUP(iInd),
            num_abonado=RAbonadoUP(iInd)
        WHERE cod_califica=RCalificaUP(iInd)
        AND num_celular= RCelularUP(iInd)
         AND nom_archivo=EVNombreArchivo
        AND nro_carga=ENCarga;
        COMMIT;                  
    END IF;
    
EXCEPTION
  WHEN OTHERS THEN
  ROLLBACK;
END PV_CAMBIA_PROCESOCARGA_PR;
PROCEDURE PV_CAMBIA_PROCESOCARGA2_PR(EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                               ENCarga         IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                               RProcesoUP      IN  TProceso,
                               RAbonadoUP      IN  TAbonado,
                               RCalificaUP     IN  TCalifica,
                               RCelularUP      IN  TCelular)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

    IF RProcesoUP.last is not null THEN
        FOR   iInd  IN 1 .. RProcesoUP.COUNT LOOP
          UPDATE PV_CARGA_CALICELU_TO
        SET cod_proceso=RProcesoUP(iInd),
            num_abonado=RAbonadoUP(iInd)
        WHERE cod_califica=RCalificaUP(iInd)
        AND num_celular= RCelularUP(iInd)
         AND nom_archivo=EVNombreArchivo
        AND nro_carga=ENCarga;
        COMMIT;                  
        END LOOP;
    END IF;
EXCEPTION
  WHEN OTHERS THEN
  ROLLBACK;
END PV_CAMBIA_PROCESOCARGA2_PR; 
PROCEDURE PV_CAMBIA_PROCCEL_PR(EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                               ENCarga        IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                               ENCalifica     IN PV_CARGA_CALICELU_TO.cod_califica%type,
                               ENCelular      IN PV_CARGA_CALICELU_TO.num_celular%type,
                               ENProceso      IN PV_CARGA_CALICELU_TO.cod_proceso%type,
                               ENAbonado      IN PV_CARGA_CALICELU_TO.num_abonado%type)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
     UPDATE PV_CARGA_CALICELU_TO
     SET cod_proceso=ENProceso,
         num_abonado=ENAbonado
     WHERE cod_califica=ENCalifica
     AND num_celular= ENCelular
     AND nom_archivo=EVNombreArchivo
     AND nro_carga=ENCarga   ;
     COMMIT;
EXCEPTION
  WHEN OTHERS THEN
  ROLLBACK;
END PV_CAMBIA_PROCCEL_PR;
PROCEDURE PV_CAMBIA_PROCESO_PR(EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                                ENCarga         IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                                ENProceso       IN PV_CARGA_CALICELU_TO.cod_proceso%type)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
     UPDATE PV_CARGA_CALICELU_TO
     SET cod_proceso=ENProceso
     WHERE nom_archivo=EVNombreArchivo
     AND nro_carga=ENCarga
     AND cod_proceso=CNProcCarga;
     COMMIT;
EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
END ;
FUNCTION PV_VALIDA_CELULAR_FN (EN_Celular  IN PV_CALIFICA_CELULAR_TO.num_celular%type,
                                EN_Abonado  IN PV_CALIFICA_CELULAR_TO.num_abonado%type,
                               SV_Califica IN OUT NOCOPY PV_CALIFICA_CELULAR_TO.cod_califica%type)
RETURN BOOLEAN
IS
LRet PLS_INTEGER:=0;
BEGIN
        BEGIN
       SELECT cod_califica
       INTO   SV_Califica
       FROM PV_CALIFICA_CELULAR_TO
       WHERE num_celular=EN_Celular
          AND num_abonado=EN_Abonado;
          LRet:=1 ;   
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             SV_Califica:=null;
             LRet:=0 ;
       END;   
       IF  LRet=0 THEN
            RETURN FALSE;    ---No existe    
       ELSE
            RETURN TRUE;   --Existe combinacion califica-celular 
       END IF ;
END PV_VALIDA_CELULAR_FN;


PROCEDURE PV_VALIDA_PREPAGO_PR (EN_Celular          IN PV_CARGA_CALICELU_TO.num_celular%type,
                                SV_Situacion        IN OUT NOCOPY ga_aboamist.cod_situacion%type,
                                SN_Abonado          IN OUT NOCOPY PV_CARGA_CALICELU_TO.num_abonado%type)
IS
BEGIN
       SELECT num_abonado, cod_situacion
       INTO   SN_Abonado,SV_Situacion
       FROM ga_aboamist
       WHERE num_celular=EN_Celular
        and fec_alta = (SELECT max(fec_alta) from ga_aboamist where num_celular=EN_Celular)
        AND rownum =1;
EXCEPTION
      WHEN NO_DATA_FOUND THEN
          SN_Abonado:=null;
          SV_Situacion:=null;
END PV_VALIDA_PREPAGO_PR;
FUNCTION PV_VALIDA_CALIFICACION_FN(EV_CodCalifica   IN PV_CALIFICACION_TD.cod_califica%type,
                                   GR_CALIFICA      IN TCalificaciones,
                                      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)  
RETURN BOOLEAN
IS
LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;       
BEGIN
        SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
    IF GR_CALIFICA.last IS NOT NULL THEN
        FOR iInd IN  GR_CALIFICA.first..GR_CALIFICA.last LOOP
            --Validando cod_califica
            IF GR_CALIFICA(iInd).cod_califica =    EV_CodCalifica THEN 
                RETURN TRUE;
            END IF;
        END LOOP;
        RETURN FALSE;
     ELSE
        RETURN FALSE;
     END IF;   
EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 0;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      LV_des_error := 'PV_VALIDA_CALIFICACION_FN - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1.0', USER, 'PV_NUMERO_PRECALIFICADO_PG.xxx', LV_sSql, SN_cod_retorno, SV_mens_retorno );    
END PV_VALIDA_CALIFICACION_FN;

PROCEDURE PV_RECUPERA_CALIFICACIONES_PR(GR_CALIFICA  IN OUT NOCOPY TCalificaciones)
IS
BEGIN

     SELECT *
     BULK COLLECT INTO GR_CALIFICA
     FROM PV_CALIFICACION_TD
     WHERE vig_califica=CN_Vigente;
END PV_RECUPERA_CALIFICACIONES_PR;


  PROCEDURE PV_PROCESA_NRO_CALIFICADO_PR(EVNombreArchivo IN PV_CARGA_CALICELU_TO.NOM_ARCHIVO%type,
                                      ENCarga         IN PV_CARGA_CALICELU_TO.NRO_CARGA%type,
                                      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)  IS
    LV_des_error      ge_errores_pg.DesEvent;
    LV_sSql           ge_errores_pg.vQuery;
    
    LN_Abonado        PV_CARGA_CALICELU_TO.num_abonado%type;                                      
    LV_Califica       PV_CALIFICA_CELULAR_TO.cod_califica%type;
    LBDHayDatos       Boolean:=TRUE;
    LBRetorno         Boolean;
    indice            number;
    iInd              number := 1;
    RCalifica         TCalificaciones;
    RNroPrecal        TCargaCalifOK;
    RNroPrecalCV      TCargaCalifCV;
    RCelular          TCelular;
    RCelularUP        TCelular;
    RAbonado          TAbonado;
    RAbonadoUP        TAbonado;
    RCalificaUP       TCalifica;
    RCalificaIns      TCalifica;
    RCelularC         TCelularCalif;
    RProcesoUP        TProceso;
    
    LNNroReg          PLS_INTEGER:=0;
    LVSituacion  VARCHAR2(3):='AAA';
    --LNCantRegUp       PLS_INTEGER:=0;
  BEGIN
    SN_cod_retorno := 0;
    SN_num_evento  := 0;
    SV_mens_retorno:= '';
    
    RNroPrecal.delete;
    RNroPrecalCV.delete;
    RCalificaIns.delete;
    RCelular.delete;
    RAbonado.delete;    
    RCalifica.delete;
    RProcesoUP.delete;
    RAbonadoUP.delete;
    RCalificaUP.delete;
    RCelularUP.delete;
    RCargaCalific.delete;
    
    
    BEGIN
        LV_sSql:=' SELECT a.cod_califica, a.num_celular,a.nom_archivo,a.cod_proceso, a.fecha_carga, b.num_abonado, a.cod_vendedor, a.vigencia, a.nom_usuario,a.nro_carga, c.cod_califica';
        LV_sSql:=LV_sSql ||' FROM PV_CARGA_CALICELU_TO a, ga_aboamist b,PV_CALIFICA_CELULAR_TO c';
        LV_sSql:=LV_sSql ||' WHERE a.nom_archivo='||EVNombreArchivo;
        LV_sSql:=LV_sSql ||' AND a.nro_carga='||ENCarga;
        LV_sSql:=LV_sSql ||' AND a.cod_proceso='||CNProcCarga;
        LV_sSql:=LV_sSql ||' AND b.cod_situacion(+)='||LVSituacion;
        LV_sSql:=LV_sSql ||' AND a.num_celular=b.num_celular(+)';
        LV_sSql:=LV_sSql ||' AND a.num_celular=c.num_celular(+) ';
        
        SELECT a.cod_califica, a.num_celular,a.nom_archivo,a.cod_proceso, a.fecha_carga, b.num_abonado, a.cod_vendedor, a.vigencia, a.nom_usuario,a.nro_carga, c.cod_califica
        BULK COLLECT INTO RCargaCalific
        FROM PV_CARGA_CALICELU_TO a, ga_aboamist b,PV_CALIFICA_CELULAR_TO c
        WHERE a.nom_archivo=EVNombreArchivo
        AND a.nro_carga=ENCarga
        AND a.cod_proceso=CNProcCarga
        AND b.cod_situacion(+)=LVSituacion
        AND a.num_celular=b.num_celular(+)
        AND a.num_celular=c.num_celular(+); 
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
          LBDHayDatos:=FALSE;
     -- WHEN OTHERS THEN
--             SN_cod_retorno := 3543;--     Error al cargar lista.
--             RAISE ERROR_CONTROLADO;          
    END;
    
    IF RCargaCalific.last is null THEN
        LBDHayDatos:=FALSE;
    END IF;
    
    IF LBDHayDatos THEN
        LV_sSql:='PV_RECUPERA_CALIFICACIONES_PR(RCalifica)';
        PV_RECUPERA_CALIFICACIONES_PR(RCalifica);
        BEGIN 
            FOR iInd IN  RCargaCalific.first..RCargaCalific.last LOOP
                LN_Abonado:=null;
                --Validando cod_califica
                LV_sSql:='PV_VALIDA_CALIFICACION_FN('||RCargaCalific(iInd).cod_califica||',RCalifica,SN_cod_retorno,SN_num_evento,SV_mens_retorno';
                IF NOT PV_VALIDA_CALIFICACION_FN(RCargaCalific(iInd).cod_califica,RCalifica,SN_cod_retorno,SN_num_evento,SV_mens_retorno) THEN
                   RCargaCalific(iInd).cod_proceso:= CNProcErrCal ; ---Existencia de Código de Calificacion
                ELSE
                    LN_Abonado:=RCargaCalific(iInd).num_abonado;
                    IF   LN_Abonado IS NULL THEN
                        RCargaCalific(iInd).cod_proceso:= CNProcErrAbo ; ---Existencia Abonado Prepago
                    ELSE
                        RCargaCalific(iInd).num_abonado:=LN_Abonado;
                        LV_Califica:=RCargaCalific(iInd).obs; 
                        IF LV_Califica IS NOT  NULL   THEN      
                          --Existe CE
                          IF LV_Califica <> RCargaCalific(iInd).cod_califica THEN
                          --EXiste y es otra calificacion-> Cierro Vigencia, (Eliminar e Insertar en Historica)
                            RCargaCalific(iInd).cod_proceso:=CNProcCierreVig;
                            LV_sSql:='PV_TRASPASA_REGISTROSOK';
                            PV_TRASPASA_REGISTROSOK(RCargaCalific(iInd).cod_califica,
                                                    RCargaCalific(iInd).num_celular,
                                                    RCargaCalific(iInd).num_abonado,
                                                    RCargaCalific(iInd).cod_vendedor,
                                                    RCargaCalific(iInd).vigencia,
                                                    RCargaCalific(iInd).nom_usuario,
                                                    RCargaCalific(iInd).fecha_carga,
                                                    RNroPrecal);
                            LV_sSql:='PV_TRASPASA_REGISTROSCV';                        
                            PV_TRASPASA_REGISTROSCV(LV_Califica,
                                                    RCargaCalific(iInd).num_celular,
                                                    RCargaCalific(iInd).num_abonado,
                                                    RCargaCalific(iInd).cod_vendedor,
                                                    RCargaCalific(iInd).nom_usuario,
                                                    RCargaCalific(iInd).fecha_carga,
                                                    RNroPrecalCV);   
                            IF RCelular.last is null THEN
                                indice:=CN_uno;
                            ELSE
                                indice:=RCelular.last + CN_uno;
                            END IF;                                             
                            RCelular(indice):=RCargaCalific(iInd).num_celular;
                            RAbonado(indice):=RCargaCalific(iInd).num_abonado;
                            RCalificaIns(indice):=LV_Califica;
                          ELSE
                            ---No deberia considerar este registro  
                            RCargaCalific(iInd).cod_proceso:= CNProcNoCargar;
                            
                          END IF;
                        ELSE
                          --No Existe -> Inserto Registro Vigente ;
                           RCargaCalific(iInd).cod_proceso:= CNProcValidaOK ; --Insertar 
                           
                           LV_sSql:='PV_TRASPASA_REGISTROSOK';
                           PV_TRASPASA_REGISTROSOK( RCargaCalific(iInd).cod_califica,
                                                    RCargaCalific(iInd).num_celular,
                                                    RCargaCalific(iInd).num_abonado,
                                                    RCargaCalific(iInd).cod_vendedor,
                                                    RCargaCalific(iInd).vigencia,
                                                    RCargaCalific(iInd).nom_usuario,
                                                    RCargaCalific(iInd).fecha_carga,
                                                    RNroPrecal);
                        END IF;
                    END IF;
                END IF;
                IF RProcesoUP.last is null THEN
                    indice:=CN_uno;
                ELSE
                    indice:=RProcesoUP.last + CN_uno;
                END IF;
                RProcesoUP(indice):=RCargaCalific(iInd).cod_proceso;
                RAbonadoUP(indice):=RCargaCalific(iInd).num_abonado;
                RCalificaUP(indice):=RCargaCalific(iInd).cod_califica;
                RCelularUP(indice):=RCargaCalific(iInd).num_celular;
            END LOOP;
        EXCEPTION
          WHEN OTHERS THEN
             SN_cod_retorno := 3540;--Error en Validación Calificacion Celular.
             RAISE ERROR_CONTROLADO;
        END;


        BEGIN
            IF RCelular.last is not null THEN     
                LV_sSql:=' DELETE PV_CALIFICA_CELULAR_TO';           
                FORALL   iInd  IN 1 .. RCelular.COUNT
                SAVE EXCEPTIONS
                DELETE PV_CALIFICA_CELULAR_TO 
                WHERE cod_califica=RCalificaIns(iInd) 
                  AND num_celular=RCelular (iInd)
                  AND num_abonado=RAbonado(iInd);
                COMMIT;
                RCelular.delete;
            END IF;
            IF RNroPrecalCV.last is not null THEN   
                LV_sSql:=' INSERT INTO PV_CALIFICA_CELULAR_TH';  
                FORALL   iInd  IN 1 .. RNroPrecalCV.COUNT
                SAVE EXCEPTIONS
                INSERT INTO PV_CALIFICA_CELULAR_TH VALUES RNroPrecalCV(iInd);
                COMMIT;
                RNroPrecalCV.delete; 
            END IF;
            IF RNroPrecal.last is not null THEN    
                LV_sSql:=' INSERT INTO PV_CALIFICA_CELULAR_TO';  
                FORALL   iInd  IN 1 .. RNroPrecal.COUNT
                SAVE EXCEPTIONS
                INSERT INTO PV_CALIFICA_CELULAR_TO VALUES RNroPrecal(iInd);
                COMMIT;
                RNroPrecal.delete;
            END IF;
            
        EXCEPTION
        WHEN OTHERS THEN
           rollback;
           SN_cod_retorno := 3541;--Error al procesar registros (Borrado e Insertado).
           RAISE ERROR_CONTROLADO;
            
        END;
        LV_sSql:='PV_CAMBIA_PROCESOCARGA_PR('||EVNombreArchivo||','||ENCarga||',RProcesoUP,RAbonadoUP,RCalificaUP,RCelularUP)'; 
        PV_CAMBIA_PROCESOCARGA_PR(EVNombreArchivo,ENCarga,RProcesoUP,RAbonadoUP,RCalificaUP,RCelularUP);
        RProcesoUP.delete;
        RAbonadoUP.delete;
        RCalificaUP.delete;
        RCelularUP.delete;
        RCargaCalific.delete;
        RCalificaIns.delete;
        
            
           
    END IF;
EXCEPTION
WHEN ERROR_CONTROLADO THEN
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
       SV_mens_retorno:= CV_ErrorNoCla;
    END IF;
    LV_des_error   :=SUBSTR(' PV_PROCESA_NRO_CALIFICADO_PR'||' - '||SQLERRM,1,250);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,250) || LV_des_error;   
    SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV',SV_mens_retorno,'1.0' , USER, 'PV_NUMERO_PRECALIFICADO_PG.PV_PROCESA_NRO_CALIFICADO_PR', LV_sSql, SN_cod_retorno, SV_mens_retorno );
--WHEN OTHERS THEN
--      SN_cod_retorno := 3542;--Error Procesando Numero PreCalificado.
--      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
--          SV_mens_retorno := CV_ErrorNoCla;
--      END IF;
--      LV_des_error := 'PV_PROCESA_NRO_CALIFICADO_PR - ' || SQLERRM;
--      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'PV', SV_mens_retorno, '1.0', USER, 'PV_NUMERO_PRECALIFICADO_PG.PV_PROCESA_NRO_CALIFICADO_PR', LV_sSql, SN_cod_retorno, SV_mens_retorno );
  END PV_PROCESA_NRO_CALIFICADO_PR;


END PV_NUMERO_PRECALIFICADO_PG;
/
SHOW ERROR