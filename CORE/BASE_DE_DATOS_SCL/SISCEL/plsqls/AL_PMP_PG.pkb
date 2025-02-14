CREATE OR REPLACE PACKAGE BODY  AL_PMP_PG AS
PROCEDURE AL_AUDIT_REVERSA_PMP_PR (EV_Mensaje      IN AL_PMP_REVERSA_TO.det_mensaje%type,
                                   SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
PRAGMA AUTONOMOUS_TRANSACTION;

   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
   sSql:='INSERT INTO AL_PMP_REVERSA_TO (NOM_USUARIO, FEC_CAMBIO, DET_MENSAJE) ';
   sSql:=sSql||' VALUES (USER, sysdate, null) ';
   INSERT INTO AL_PMP_REVERSA_TO (NOM_USUARIO, FEC_CAMBIO, DET_MENSAJE)
   VALUES (USER, sysdate, EV_Mensaje);
   COMMIT;
EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 2912; --Problemas al registrar auditoria de reversa PMP
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_AUDIT_REVERSA_PMP_PR - '|| SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_AUDIT_REVERSA_PMP_PR', sSql, SN_cod_retorno, V_des_error );
      ROLLBACK;
END AL_AUDIT_REVERSA_PMP_PR;
----------------------------------------------------------------------------------------------
PROCEDURE AL_SUMA_DEVOLUCION_PR (EN_NumOrdenD    IN al_cabecera_ordenes3.num_orden%TYPE,
                                 EN_Articulo     IN al_articulos.cod_articulo%TYPE,
                                 EN_dec          IN NUMBER,
                                 SN_Precio       OUT NOCOPY al_lineas_ordenes3.PRC_UNIDAD%TYPE,
                                 SN_cantidad     OUT NOCOPY number,
                                 SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error          ge_errores_pg.DesEvent;
   sSql                 ge_errores_pg.vQuery;
   ERROR_CONTROLADO     EXCEPTION;
   le_salir_loop        EXCEPTION;
   ln_precio            al_lineas_ordenes3.PRC_UNIDAD%TYPE;

CURSOR C_LinOrd(EN_NumOrdenD    IN al_cabecera_ordenes3.num_orden%TYPE,
                EN_cod_articulo IN al_articulos.cod_articulo%TYPE) is

select c.num_serie
from al_cabecera_ordenes3 a ,al_lineas_ordenes3 b, al_series_ordenes3 c
where a.num_orden=EN_NumOrdenD  and
a.num_orden=b.num_orden and
b.num_orden=c.num_orden and
b.num_linea=c.num_linea and
b.cod_articulo=EN_cod_articulo;


BEGIN
       SN_cod_retorno :=  0;
       SN_num_evento  :=  0;
       SV_mens_retorno:= ' ';
       SN_cantidad:=0;
       SN_Precio:=0;

       for c1 in C_LinOrd(EN_NumOrdenD,EN_articulo) loop
       begin
           ln_precio:=0;
           begin
                sSql:='select (a.prc_unidad + nvl(a.prc_ff,0) + nvl(a.prc_adic,0)) into ln_precio from al_hlineas_ordenes2 a where a.num_orden=( '||
                      'select max(b.num_orden) from al_hseries_ordenes2  b where b.num_serie='''||c1.num_serie||''')'||
                      'and a.cod_articulo='||EN_articulo;
                select (a.prc_unidad + nvl(a.prc_ff,0) + nvl(a.prc_adic,0)) into ln_precio from al_hlineas_ordenes2 a where a.num_orden=(
                       select max(b.num_orden) from al_hseries_ordenes2  b where b.num_serie=c1.num_serie)
                       and a.cod_articulo=EN_articulo;
           exception
           when no_data_found then
                begin
                    select (a.prc_unidad + nvl(a.prc_ff,0) + nvl(a.prc_adic,0)) into ln_precio from al_lineas_ordenes2 a where a.num_orden=(
                       select max(b.num_orden) from al_series_ordenes2  b where b.num_serie=c1.num_serie)
                       and a.cod_articulo=EN_articulo;
                exception
                when no_data_found then
                    null;
                    ln_precio:=0;
                when others then
                    SN_cod_retorno:=156;
                    raise le_salir_loop;    
                end;                
           when others then
                SN_cod_retorno:=156;
                raise le_salir_loop;
           end;
           SN_precio:= SN_precio + ln_precio;
           SN_cantidad:= SN_cantidad + 1;
       exception
       when le_salir_loop then
           SN_cod_retorno:=156;
           raise ERROR_CONTROLADO;
       when others then
           SN_cod_retorno:=156;
           raise ERROR_CONTROLADO;
       end;
       end loop;

       SN_precio:= round(SN_precio,EN_dec);

EXCEPTION
WHEN ERROR_CONTROLADO THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_SUMA_DEVOLUCION_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_SUMA_DEVOLUCION_PR', sSql, SN_cod_retorno, V_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_SUMA_DEVOLUCION_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_SUMA_DEVOLUCION_PR', sSql, SN_cod_retorno, V_des_error );
END AL_SUMA_DEVOLUCION_PR;

PROCEDURE AL_MODIFICA_PMP_PR (SR_PmpArt       IN al_pmp_articulo%ROWTYPE,
                              SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                              SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                              SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
   sSql:='UPDATE al_pmp_articulo ';
   sSql:=sSql||'SET  prec_pmp=     '||SR_PmpArt.prec_pmp||',';
   sSql:=sSql||'     can_stock=  '||SR_PmpArt.can_stock||',';
   sSql:=sSql||'     fec_periodo='||SR_PmpArt.fec_periodo||',';
   sSql:=sSql||'     fec_ult_mod='||SR_PmpArt.fec_ult_mod||',';
   sSql:=sSql||'     ind_calculo='||SR_PmpArt.ind_calculo||',';
   sSql:=sSql||'     num_orden=  '||SR_PmpArt.num_orden||',';
   sSql:=sSql||'     can_ingresos='||SR_PmpArt.can_ingresos||',';
   sSql:=sSql||'     can_salidas='||SR_PmpArt.can_salidas||',';
   sSql:=sSql||'     ,nom_usuario='||user;
   sSql:=sSql||' WHERE cod_articulo='||SR_PmpArt.cod_articulo;
   sSql:=sSql||' AND fec_ult_mod = (SELECT max(fec_ult_mod) FROM al_pmp_articulo WHERE cod_articulo='||SR_PmpArt.cod_articulo||')';


   UPDATE al_pmp_articulo
   SET  prec_pmp=    SR_PmpArt.prec_pmp,
        can_stock=  SR_PmpArt.can_stock,
        fec_periodo=SR_PmpArt.fec_periodo,
        fec_ult_mod=SR_PmpArt.fec_ult_mod,
        ind_calculo=SR_PmpArt.ind_calculo,
        num_orden=  SR_PmpArt.num_orden,
        can_ingresos=SR_PmpArt.can_ingresos,
        can_salidas=SR_PmpArt.can_salidas,
        nom_usuario=USER
   WHERE cod_articulo=SR_PmpArt.cod_articulo
   AND fec_ult_mod = (SELECT MAX(fec_ult_mod) FROM al_pmp_articulo WHERE cod_articulo=SR_PmpArt.cod_articulo);


EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 742;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_MODIFICA_PMP_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_MODIFICA_PMP_PR', sSql, SN_cod_retorno, V_des_error );
END AL_MODIFICA_PMP_PR;
PROCEDURE AL_PMP_VIGENTE_PR (EN_Articulo     IN al_articulos.cod_articulo%TYPE,
                             SN_Pmp_vig      OUT NOCOPY al_pmp_articulo.prec_pmp%TYPE,
                             SR_PmpArt       OUT NOCOPY al_pmp_articulo%ROWTYPE,
                             SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
   BEGIN
   sSql:='  SELECT cod_articulo,fec_periodo,fec_ult_mod,can_stock,NVL(prec_pmp,0) prec_pmp,cod_operadora_scl,fec_dia_pmp,can_salidas,can_entradas,can_ingresos,ind_calculo,num_orden,nom_usuario';
   sSql:=sSql||'FROM al_pmp_articulo ';
   sSql:=sSql||'WHERE cod_articulo= '||EN_Articulo;
   sSql:=sSql||'  AND fec_ult_mod = (SELECT max(fec_ult_mod) FROM al_pmp_articulo WHERE cod_articulo='||EN_Articulo||')';
   SELECT cod_articulo,fec_periodo,fec_ult_mod,can_stock,NVL(prec_pmp,0) prec_pmp,cod_operadora_scl,fec_dia_pmp,can_salidas,can_entradas,can_ingresos,ind_calculo,num_orden,nom_usuario
   INTO SR_PmpArt.cod_articulo,SR_PmpArt.fec_periodo,SR_PmpArt.fec_ult_mod,SR_PmpArt.can_stock,SR_PmpArt.prec_pmp,SR_PmpArt.cod_operadora_scl,SR_PmpArt.fec_dia_pmp,SR_PmpArt.can_salidas,SR_PmpArt.can_entradas,SR_PmpArt.can_ingresos,SR_PmpArt.ind_calculo,SR_PmpArt.num_orden,SR_PmpArt.nom_usuario
   FROM al_pmp_articulo
   WHERE cod_articulo= EN_Articulo
     AND fec_ult_mod = (SELECT MAX(fec_ult_mod) FROM al_pmp_articulo WHERE cod_articulo=EN_Articulo);
     SN_Pmp_vig:=SR_PmpArt.prec_pmp;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
         SN_Pmp_vig:=CN_cero;
   END;

--   DBMS_OUTPUT.PUT_LINE ( 'SR_PmpArt.can_ingresos = ' || SR_PmpArt.can_ingresos );
-- DBMS_OUTPUT.PUT_LINE ( 'SN_Pmp_vig= ' ||SN_Pmp_vig );


EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 749;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_PMP_VIGENTE_PR - '||EN_Articulo||' - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_PMP_VIGENTE_PR', sSql, SN_cod_retorno, V_des_error );
END AL_PMP_VIGENTE_PR;
PROCEDURE AL_INSERTA_PMP_PR (SR_PmpArt       IN al_pmp_articulo%ROWTYPE,
                             SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
BEGIN

   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
    sSql:='INSERT INTO AL_PMP_ARTICULO (cod_articulo,fec_periodo,fec_ult_mod,can_stock,prec_pmp,cod_operadora_scl,fec_dia_pmp,can_salidas,can_entradas,can_ingresos,ind_calculo,num_orden,nom_usuario)';
   sSql:=sSql||'VALUES('||SR_PmpArt.cod_articulo||','||SR_PmpArt.fec_periodo||','||SR_PmpArt.fec_ult_mod||',';
    sSql:=sSql||SR_PmpArt.can_stock||','||SR_PmpArt.prec_pmp||','||SR_PmpArt.cod_operadora_scl||',';
  sSql:=sSql||SR_PmpArt.fec_dia_pmp||','||SR_PmpArt.can_salidas||','||SR_PmpArt.can_entradas||','||SR_PmpArt.can_ingresos||','||SR_PmpArt.ind_calculo||','||SR_PmpArt.num_orden||','||user||')';
    INSERT INTO AL_PMP_ARTICULO (cod_articulo,fec_periodo,fec_ult_mod,can_stock,prec_pmp,cod_operadora_scl,fec_dia_pmp,can_salidas,can_entradas,can_ingresos,ind_calculo,num_orden,NOM_USUARIO)
    VALUES(SR_PmpArt.cod_articulo,SR_PmpArt.fec_periodo,SR_PmpArt.fec_ult_mod,SR_PmpArt.can_stock,SR_PmpArt.prec_pmp,SR_PmpArt.cod_operadora_scl,SR_PmpArt.fec_dia_pmp,SR_PmpArt.can_salidas,SR_PmpArt.can_entradas,SR_PmpArt.can_ingresos,SR_PmpArt.ind_calculo,SR_PmpArt.num_orden,USER);
EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 740;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_INSERTA_PMP_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_INSERTA_PMP_PR', sSql, SN_cod_retorno, V_des_error );
END AL_INSERTA_PMP_PR;
PROCEDURE AL_PASO_HISTORICO_PMP_PR (SR_PmpArt       IN al_pmp_articulo%ROWTYPE,
                                    ED_FechaHistorico  IN al_pmp_articulo_th.fec_ult_mod%type,
                                    SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   LD_fec_dia_pmp   al_pmp_articulo_th.fec_dia_pmp%type;
BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   LD_fec_dia_pmp:=ED_FechaHistorico-1 / (24 * 60 * 60);
   SV_mens_retorno:= ' ';
 --  DBMS_OUTPUT.PUT_LINE ( 'SR_PmpArt.cod_articulo = ' || SR_PmpArt.cod_articulo );
    sSql:='INSERT INTO AL_PMP_ARTICULO_TH (cod_articulo,fec_ult_mod,fec_periodo,can_stock,prec_pmp,cod_operadora_scl,fec_dia_pmp,can_salidas,can_entradas,can_ingresos,ind_calculo,num_orden,nom_usuario)';
    sSql:=sSql||'VALUES('||SR_PmpArt.cod_articulo||','||SR_PmpArt.fec_ult_mod||','||SR_PmpArt.fec_periodo||','||SR_PmpArt.can_stock||','||SR_PmpArt.prec_pmp||',';
    sSql:=sSql||SR_PmpArt.cod_operadora_scl||','||LD_fec_dia_pmp||','||SR_PmpArt.can_salidas||','||SR_PmpArt.can_entradas||','||SR_PmpArt.can_ingresos||',';
    sSql:=sSql||SR_PmpArt.ind_calculo||','||SR_PmpArt.num_orden||','||SR_PmpArt.NOM_USUARIO||')';
    INSERT INTO AL_PMP_ARTICULO_TH (cod_articulo,fec_ult_mod,fec_periodo,can_stock,prec_pmp,cod_operadora_scl,fec_dia_pmp,can_salidas,can_entradas,can_ingresos,ind_calculo,num_orden,NOM_USUARIO)
    VALUES(SR_PmpArt.cod_articulo,SR_PmpArt.fec_ult_mod,SR_PmpArt.fec_periodo,SR_PmpArt.can_stock,SR_PmpArt.prec_pmp,
           SR_PmpArt.cod_operadora_scl,LD_fec_dia_pmp,SR_PmpArt.can_salidas,SR_PmpArt.can_entradas,SR_PmpArt.can_ingresos,
           SR_PmpArt.ind_calculo,SR_PmpArt.num_orden,SR_PmpArt.NOM_USUARIO);
EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 745;-- Problema al ingresar información del PMP a historicos.-
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_PASO_HISTORICO_PMP_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_PASO_HISTORICO_PMP_PR', sSql, SN_cod_retorno, V_des_error );
END AL_PASO_HISTORICO_PMP_PR;
PROCEDURE AL_STOCK_VIGENTE_PR (EN_Articulo   IN al_articulos.cod_articulo%TYPE,
                               EV_ParamKit   IN VARCHAR2,
                               SN_TotalStock   OUT NOCOPY NUMBER,
                               SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                               SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                               SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   LN_StockArt      NUMBER(9);
   LN_StockKit      NUMBER(9);
BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
   --1.- Stock Articulo
   BEGIN
        sSql:='SELECT sum(can_stock) ';
        sSql:=sSql||'FROM al_stock a, al_tipos_stock b ';
        sSql:=sSql||'WHERE a.cod_articulo='||EN_Articulo;
        sSql:=sSql||'  AND b.ind_valorar=1';
        sSql:=sSql||'  AND b.tip_stock=a.tip_stock';
        SELECT nvl(SUM(a.can_stock),CN_cero)
        INTO LN_StockArt
        FROM al_stock a, al_tipos_stock b
        WHERE a.cod_articulo=EN_Articulo
          AND b.ind_valorar=CN_uno
          AND b.tip_stock=a.tip_stock;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
         LN_StockArt:=CN_cero;
   END;
 --  DBMS_OUTPUT.PUT_LINE ( 'LN_StockArt = ' || LN_StockArt ||' PAra el Articulo : '|| EN_Articulo);
   IF EV_ParamKit='TRUE' THEN
   --2.- Stock Kit
        BEGIN
            sSql:='  SELECT nvl(sum(a.can_stock),0) ';
            sSql:=sSql||'  FROM al_plantillas_kit c, al_stock a, al_tipos_stock b ';
            sSql:=sSql||'  WHERE c.cod_articulo='||EN_Articulo;
            sSql:=sSql||'    AND b.ind_valorar=1';
            sSql:=sSql||'    AND b.tip_stock=a.tip_stock ';
            sSql:=sSql||'    AND a.cod_articulo=c.cod_kit';
            SELECT NVL(SUM(a.can_stock * c.can_articulo),CN_cero)
            INTO LN_StockKit
            FROM al_plantillas_kit c, al_stock a, al_tipos_stock b
            WHERE c.cod_articulo=EN_Articulo
              AND b.ind_valorar=CN_uno
              AND b.tip_stock=a.tip_stock
              AND a.cod_articulo=c.cod_kit;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN
             LN_StockKit:=CN_cero;
        END;
   ELSE
        LN_StockKit:=CN_cero;
   END IF;
 --  DBMS_OUTPUT.PUT_LINE ( 'LN_StockKit = ' || LN_StockKit );
   --3.- Stock Total
   SN_TotalStock:=LN_StockArt + LN_StockKit ;
 --  DBMS_OUTPUT.PUT_LINE ( 'SN_TotalStock = ' || SN_TotalStock );
EXCEPTION
WHEN OTHERS THEN
      SN_cod_retorno := 10;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_STOCK_VIGENTE_PR (Articulo - '||EN_Articulo||' - '  || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_STOCK_VIGENTE_PR', sSql, SN_cod_retorno, V_des_error );
END AL_STOCK_VIGENTE_PR;

PROCEDURE AL_PMP_KIT_PR (EN_Articulo     IN al_pmp_articulo.cod_articulo%TYPE,
                         ED_FecPmp       IN DATE,
                         EV_CalKit       IN VARCHAR2,
                         EN_NumOrdenC    IN al_cabecera_ordenes1.num_orden%TYPE,
                         EV_ParamKit     IN VARCHAR2,
                         EN_Cantidad     IN al_lineas_ordenes2.can_orden%TYPE,
                         EN_dec          in number,
                         SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento   OUT NOCOPY ge_errores_pg.evento,
                         EV_tipo         IN VARCHAR2 DEFAULT 'ING')
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   LN_PmpKit        al_pmp_articulo.prec_pmp%TYPE:=CN_cero;
   LN_PmpKit1       al_pmp_articulo.prec_pmp%TYPE:=CN_cero;
   LN_PmpArt        al_pmp_articulo.prec_pmp%TYPE:=CN_cero;
   LR_PmpArt        al_pmp_articulo%ROWTYPE;
   LR_PmpKitV       al_pmp_articulo%ROWTYPE;
   LN_CodKit        al_plantillas_kit.cod_kit%TYPE;
   LN_CodArticulo   al_plantillas_kit.cod_articulo%TYPE;
   LN_StockKit      NUMBER(15);
   le_salir_loop1   exception;
   le_salir_loop2   exception;
   LN_no_existe_pmp_art  number(1);

   LN_stock          al_pmp_articulo.can_stock%TYPE;
   CURSOR C_Kit (EN_Articulo al_pmp_articulo.cod_articulo%TYPE)
   IS
    SELECT DISTINCT cod_kit
    FROM al_plantillas_kit
    WHERE cod_articulo=EN_Articulo;


   CURSOR C_ArtKit (EN_Kit al_pmp_articulo.cod_articulo%TYPE)
   IS
    SELECT cod_articulo
    FROM al_plantillas_kit
    WHERE cod_kit=EN_Kit;
BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';

   FOR C1 IN C_Kit(EN_Articulo) LOOP
   begin
        LN_PmpKit:=0;
        LN_StockKit:=0;
         FOR C2 IN C_ArtKit(C1.cod_kit) LOOP
         begin
   --        DBMS_OUTPUT.PUT_LINE ( '(PMP KIT) C2.COD_ARTICULO = ' || C2.COD_ARTICULO );
             sSql:='AL_PMP_VIGENTE_PR('||C2.COD_ARTICULO||',LN_PmpArt,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
              AL_PMP_VIGENTE_PR(C2.COD_ARTICULO,LN_PmpArt,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
              IF SN_cod_retorno<> CN_cero THEN
                 RAISE le_salir_loop2;
              END IF;
              sSql:='LN_PmpKit:='||LN_PmpKit||' + '||LN_PmpArt ;
              LN_PmpKit:=LN_PmpKit + LN_PmpArt ;

              sSql:='AL_STOCK_VIGENTE_PR('||C2.COD_ARTICULO||',''FALSE'',LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
              AL_STOCK_VIGENTE_PR(C2.COD_ARTICULO,'FALSE',LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
              IF SN_cod_retorno<> CN_cero THEN
                  RAISE ERROR_CONTROLADO;
              END IF;
              if EV_TIPO ='DEV' then
                 LN_StockKit:=LN_StockKit-LN_Stock;
              else
                 LN_StockKit:=LN_StockKit+LN_Stock;
              end if;


        exception
        when le_salir_loop2 then
             RAISE le_salir_loop1;
        end;
        END LOOP;

       LN_PmpKit:=ROUND(NVL(LN_PmpKit,0),EN_dec);
       LN_StockKit:=NVL(LN_StockKit,0);
      -- DBMS_OUTPUT.PUT_LINE ( 'LN_PmpKitt = ' || LN_PmpKit );
            --Obtener informacion del kit
            LN_no_existe_pmp_art:=1;
            BEGIN
                SELECT cod_articulo,fec_periodo,fec_ult_mod,can_stock,round(NVL(prec_pmp,0),en_dec) prec_pmp,cod_operadora_scl,fec_dia_pmp,can_salidas,can_entradas,can_ingresos,ind_calculo,num_orden
                       ,NOM_USUARIO
                INTO LR_PmpKitV.cod_articulo,LR_PmpKitV.fec_periodo,LR_PmpKitV.fec_ult_mod,LR_PmpKitV.can_stock,LR_PmpKitV.prec_pmp,LR_PmpKitV.cod_operadora_scl,LR_PmpKitV.fec_dia_pmp,LR_PmpKitV.can_salidas,LR_PmpKitV.can_entradas,LR_PmpKitV.can_ingresos,LR_PmpKitV.ind_calculo,LR_PmpKitV.num_orden
                     ,LR_PmpKitV.NOM_USUARIO
                FROM al_pmp_articulo
                WHERE cod_articulo= C1.cod_kit
                  AND fec_ult_mod = (SELECT MAX(fec_ult_mod) FROM al_pmp_articulo WHERE cod_articulo=C1.cod_kit);
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   LN_no_existe_pmp_art:=0;
            END;
            if LN_no_existe_pmp_art=1 then
                LR_PmpKitV.ind_calculo:=EV_CalKit;
             --Traspaso Historico
                 sSql:='AL_PASO_HISTORICO_PMP_PR (LR_PmpKitV,'||ED_FecPmp||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                 AL_PASO_HISTORICO_PMP_PR (LR_PmpKitV,ED_FecPmp,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                 IF SN_cod_retorno <> CN_cero THEN
                    RAISE le_salir_loop1;
                 end if;

                --Modificar
                LR_PmpKitV.can_stock:=LN_StockKit;
                LR_PmpKitV.prec_pmp:=LN_PmpKit;
                LR_PmpKitV.fec_periodo:=TRUNC(ED_FecPmp);
                LR_PmpKitV.fec_dia_pmp:=sysdate;
                LR_PmpKitV.fec_ult_mod:=ED_FecPmp;
                LR_PmpKitV.ind_calculo:=EV_CalKit;
                LR_PmpKitV.num_orden:=EN_NumOrdenC;
                LR_PmpKitV.can_salidas:=EN_Cantidad;
                sSql:='AL_MODIFICA_PMP_PR (LR_PmpKitV,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';

                AL_MODIFICA_PMP_PR (LR_PmpKitV,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                IF SN_cod_retorno<> CN_cero THEN
                   RAISE le_salir_loop1;
                END IF;
            else
               --Insertar
                LR_PmpKitV.cod_articulo:=C1.cod_kit;
                LR_PmpKitV.fec_periodo:=TRUNC(ED_FecPmp);
                LR_PmpKitV.fec_ult_mod:=ED_FecPmp;
                LR_PmpKitV.can_stock:=LN_StockKit;
                LR_PmpKitV.prec_pmp:=LN_PmpKit;
                LR_PmpKitV.cod_operadora_scl:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                LR_PmpKitV.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
                if EV_tipo='DEV' then
                    LR_PmpKitV.can_salidas:=EN_Cantidad;
                    LR_PmpKitV.can_entradas:=CN_cero;
                    LR_PmpKitV.can_ingresos:=CN_cero;
                else
                    LR_PmpKitV.can_salidas:=CN_cero;
                    LR_PmpKitV.can_entradas:=CN_cero;
                    LR_PmpKitV.can_ingresos:=EN_Cantidad;
                end if;
                LR_PmpKitV.ind_calculo:=EV_CalKit;
                LR_PmpKitV.num_orden:=EN_NumOrdenC;
                sSql:='AL_INSERTA_PMP_PR (LR_PmpKitV,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                AL_INSERTA_PMP_PR (LR_PmpKitV,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno<> CN_cero THEN
                   RAISE le_salir_loop1;
                END IF;
            END IF;

   exception
   when le_salir_loop1 then
        raise error_controlado;
   end;
   END LOOP;

EXCEPTION
WHEN ERROR_CONTROLADO THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_PMP_KIT_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_PMP_KIT_PR', sSql, SN_cod_retorno, V_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_PMP_KIT_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_PMP_KIT_PR', sSql, SN_cod_retorno, V_des_error );
END AL_PMP_KIT_PR;
PROCEDURE AL_CALCULA_PMP_PR (EN_Articulo     IN al_articulos.cod_articulo%TYPE,
                             EN_NumOrdenC    IN al_cabecera_ordenes1.num_orden%TYPE,
                             EN_Cantidad     IN al_lineas_ordenes2.can_orden%TYPE,
                             EN_PrcUnidad    IN al_lineas_ordenes2.prc_unidad%TYPE,
                             SN_Pmp          OUT NOCOPY al_pmp_articulo.prec_pmp%TYPE,
                             SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   LN_PmpVig        al_pmp_articulo.prec_pmp%TYPE;
   LN_Pmp           al_pmp_articulo.prec_pmp%TYPE;
   LR_PmpArt        al_pmp_articulo%ROWTYPE;
   LN_Stock         NUMBER(15);

   LD_FecPmp        DATE;
   LV_FecPmp        VARCHAR2(25);
   LV_ValParKit     VARCHAR2(20);
   LN_StockNuevo    NUMBER(15);
   ln_dec           NUMBER(1);

BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
   BEGIN
        sSql:='SELECT val_parametro ' ;
        sSql:=sSql||'FROM ged_parametros ';
        sSql:=sSql||'WHERE nom_parametro='||CV_PmpConKit;
        sSql:=sSql||'  AND cod_modulo=AL';
        sSql:=sSql||'  AND cod_producto=1';
        SELECT val_parametro
        INTO LV_ValParKit
        FROM ged_parametros
        WHERE nom_parametro=CV_PmpConKit
          AND cod_modulo=CV_modulo
          AND cod_producto=CN_uno;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 1362;
         RAISE ERROR_CONTROLADO;
   END;

   LN_DEC:=0;
   BEGIN
      SELECT NVL(valor_numerico,0)  INTO LN_DEC
        From AL_PARAMETROS_SIMPLES_VW  WHERE cod_modulo='AL'
        AND nom_parametro='CANT_DECIMALES_PMP';
   EXCEPTION
     WHEN OTHERS THEN
        LN_DEC:=0;
   END;



   sSql:='AL_PMP_VIGENTE_PR('||EN_Articulo||',LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_PMP_VIGENTE_PR(EN_Articulo,LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno<> CN_cero THEN
       RAISE ERROR_CONTROLADO;
   END IF;

   sSql:='AL_STOCK_VIGENTE_PR('||EN_Articulo||',LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_STOCK_VIGENTE_PR(EN_Articulo,LV_ValParKit,LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno<> CN_cero THEN
       RAISE ERROR_CONTROLADO;
   END IF;

   BEGIN
        sSql:='LN_Pmp:=(('||EN_Cantidad||' * '||EN_PrcUnidad||') + ( '||LN_Stock||' * '||LN_PmpVig||')) / ('||EN_Cantidad||' + '||LN_Stock||')' ;
        LN_Pmp:=((EN_Cantidad * EN_PrcUnidad) + ( LN_Stock * LN_PmpVig)) / (EN_Cantidad + LN_Stock) ;
        LN_Pmp:=ROUND(LN_Pmp,LN_DEC);
 EXCEPTION
     WHEN OTHERS THEN
       SN_cod_retorno := 2840;--Problemas al Calcular PMP
       RAISE ERROR_CONTROLADO;
   END;
   sSql:='LN_StockNuevo:=('||EN_Cantidad||' + '||LN_Stock||')';
   LN_StockNuevo:=(EN_Cantidad + LN_Stock);
   LD_FecPmp:=SYSDATE;
   LV_FecPmp:=TO_CHAR(SYSDATE,'DD-MM-YYYY hh24:mm:ss');
   IF LN_PmpVig<> CN_cero THEN
        --Traspaso Historico
        sSql:='AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,'||LD_FecPmp||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        LR_PmpArt.prec_pmp:=round(LR_PmpArt.prec_pmp,ln_dec);
        AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,LD_FecPmp,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
               RAISE ERROR_CONTROLADO;
        END IF;
   END IF;
   IF LN_PmpVig = CN_cero THEN
        --Insertar
        LR_PmpArt.cod_articulo:=EN_Articulo;
        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
        LR_PmpArt.can_stock:=LN_StockNuevo;
        LR_PmpArt.prec_pmp:=LN_Pmp;
        LR_PmpArt.cod_operadora_scl:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
        LR_PmpArt.can_salidas:=CN_cero;
        LR_PmpArt.can_entradas:=CN_cero;
        LR_PmpArt.can_ingresos:=EN_Cantidad;
        LR_PmpArt.ind_calculo:=CV_IndCal;
        LR_PmpArt.num_orden:=EN_NumOrdenC;
        sSql:='AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
           RAISE ERROR_CONTROLADO;
        END IF;
   ELSE
        --Modificar
        LR_PmpArt.can_stock:=LN_StockNuevo;
        LR_PmpArt.prec_pmp:=LN_Pmp;
        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
        LR_PmpArt.ind_calculo:=CV_IndCal;
        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
        LR_PmpArt.can_ingresos:=EN_Cantidad;
        LR_PmpArt.can_salidas:=CN_cero;
        LR_PmpArt.num_orden:=EN_NumOrdenC;
        sSql:='AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
           RAISE ERROR_CONTROLADO;
        END IF;
   END IF;

   IF LV_ValParKit='TRUE' THEN
        --Calculo PMP Kit
        sSql:='AL_PMP_KIT_PR ('||EN_Articulo||','||LD_FecPmp||','||CV_IndCal||','||EN_NumOrdenC||','||LV_ValParKit||','||EN_cantidad||','||LN_DEC||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_PMP_KIT_PR (EN_Articulo,LD_FecPmp,CV_IndCal,EN_NumOrdenC,LV_ValParKit,EN_cantidad,LN_DEC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
               RAISE ERROR_CONTROLADO;
        END IF;
   END IF;
   SN_Pmp:=LN_Pmp;
EXCEPTION
WHEN ERROR_CONTROLADO THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_CALCULA_PMP_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_CALCULA_PMP_PR', sSql, SN_cod_retorno, V_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_CALCULA_PMP_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_CALCULA_PMP_PR', sSql, SN_cod_retorno, V_des_error );
END AL_CALCULA_PMP_PR;

PROCEDURE AL_CALCULA_PMP_DEV_PR (EN_Articulo     IN al_articulos.cod_articulo%TYPE,
                             EN_NumOrdenC    IN al_cabecera_ordenes3.num_orden%TYPE,
                             EN_Cantidad     IN al_lineas_ordenes2.can_orden%TYPE,
                             EN_PrcUnidad    IN al_lineas_ordenes2.prc_unidad%TYPE,
                             SN_Pmp          OUT NOCOPY al_pmp_articulo.prec_pmp%TYPE,
                             SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   LN_PmpVig        al_pmp_articulo.prec_pmp%TYPE;
   LN_Pmp           al_pmp_articulo.prec_pmp%TYPE;
   LR_PmpArt        al_pmp_articulo%ROWTYPE;
   LN_Stock         NUMBER(15);

   LD_FecPmp        DATE;
   LV_FecPmp        VARCHAR2(25);
   LV_ValParKit     VARCHAR2(20);
   LN_StockNuevo    NUMBER(15);
   ln_dec           NUMBER(1);
   LN_Preciotot_dev    al_lineas_ordenes2.prc_unidad%TYPE;
   LN_cantot_dev  al_lineas_ordenes2.can_orden%TYPE;

BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
   BEGIN
        sSql:='SELECT val_parametro ' ;
        sSql:=sSql||'FROM ged_parametros ';
        sSql:=sSql||'WHERE nom_parametro='||CV_PmpConKit;
        sSql:=sSql||'  AND cod_modulo=AL';
        sSql:=sSql||'  AND cod_producto=1';
        SELECT val_parametro
        INTO LV_ValParKit
        FROM ged_parametros
        WHERE nom_parametro=CV_PmpConKit
          AND cod_modulo=CV_modulo
          AND cod_producto=CN_uno;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 1362;
         RAISE ERROR_CONTROLADO;
   END;

   LN_DEC:=0;
   BEGIN
      SELECT NVL(valor_numerico,0)  INTO LN_DEC
        From AL_PARAMETROS_SIMPLES_VW  WHERE cod_modulo='AL'
        AND nom_parametro='CANT_DECIMALES_PMP';
   EXCEPTION
     WHEN OTHERS THEN
        LN_DEC:=0;
   END;


   sSql:='AL_PMP_VIGENTE_PR('||EN_Articulo||',LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_PMP_VIGENTE_PR(EN_Articulo,LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno<> CN_cero THEN
       RAISE ERROR_CONTROLADO;
   END IF;

   sSql:='AL_STOCK_VIGENTE_PR('||EN_Articulo||',LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_STOCK_VIGENTE_PR(EN_Articulo,LV_ValParKit,LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno<> CN_cero THEN
       RAISE ERROR_CONTROLADO;
   END IF;

   --obtiene sumatoria de precio de series devueltas....
   LN_Preciotot_dev:=0;
   LN_cantot_dev:=0;
   sSql:='AL_SUMA_DEVOLUCION_PR('||EN_NumOrdenC||','||EN_Articulo||','||LN_DEC||',LN_Preciotot_dev,LN_cantot_dev,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_SUMA_DEVOLUCION_PR (EN_NumOrdenC,EN_Articulo,LN_DEC,LN_Preciotot_dev,LN_cantot_dev,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

   LN_Stock := LN_Stock + LN_cantot_dev;
   LN_StockNuevo:=LN_Stock;
   
   
   BEGIN
        sSql:='LN_Pmp:=(('||LN_Stock ||'*'|| LN_PmpVig||') - '||LN_Preciotot_dev||')/'||LN_Stock||'-'||LN_cantot_dev;
        LN_Pmp:=((LN_Stock * LN_PmpVig) -  LN_Preciotot_dev) / LN_StockNuevo;
        LN_Pmp:=ROUND(LN_Pmp,LN_DEC);
        
      --  sSql:='LN_Pmp:=(('||EN_Cantidad||' * '||EN_PrcUnidad||') + ( '||LN_Stock||' * '||LN_PmpVig||')) / ('||EN_Cantidad||' + '||LN_Stock||')' ;
       -- LN_Pmp:=((EN_Cantidad * EN_PrcUnidad) + ( LN_Stock * LN_PmpVig)) / (EN_Cantidad + LN_Stock) ;
        LN_Pmp:=ROUND(LN_Pmp,LN_DEC);
 EXCEPTION
     WHEN OTHERS THEN
       SN_cod_retorno := 2840;--Problemas al Calcular PMP
       RAISE ERROR_CONTROLADO;
   END;


   LD_FecPmp:=SYSDATE;
   LV_FecPmp:=TO_CHAR(SYSDATE,'DD-MM-YYYY hh24:mm:ss');
   IF LN_PmpVig<> CN_cero THEN
        --Traspaso Historico
        sSql:='AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,'||LD_FecPmp||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        LR_PmpArt.prec_pmp:=round(LR_PmpArt.prec_pmp,ln_dec);
        AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,LD_FecPmp,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
               RAISE ERROR_CONTROLADO;
        END IF;
   END IF;
   IF LN_PmpVig = CN_cero THEN
        --Insertar
        LR_PmpArt.cod_articulo:=EN_Articulo;
        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
        LR_PmpArt.can_stock:=LN_StockNuevo;
        LR_PmpArt.prec_pmp:=LN_Pmp;
        LR_PmpArt.cod_operadora_scl:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
        LR_PmpArt.can_salidas:=CN_cero;
        LR_PmpArt.can_entradas:=CN_cero;
        LR_PmpArt.can_ingresos:=EN_Cantidad;
        LR_PmpArt.ind_calculo:=CV_IndCal;
        LR_PmpArt.num_orden:=EN_NumOrdenC;
        sSql:='AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
           RAISE ERROR_CONTROLADO;
        END IF;
   ELSE
        --Modificar
        LR_PmpArt.can_stock:=LN_StockNuevo;
        LR_PmpArt.prec_pmp:=LN_Pmp;
        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
        LR_PmpArt.ind_calculo:=CV_IndCal;
        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
        LR_PmpArt.can_ingresos:=EN_Cantidad;
        LR_PmpArt.can_salidas:=CN_cero;
        LR_PmpArt.num_orden:=EN_NumOrdenC;
        sSql:='AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
           RAISE ERROR_CONTROLADO;
        END IF;
   END IF;

   IF LV_ValParKit='TRUE' THEN
        --Calculo PMP Kit
        sSql:='AL_PMP_KIT_PR ('||EN_Articulo||','||LD_FecPmp||','||CV_IndCal||','||EN_NumOrdenC||','||LV_ValParKit||','||EN_cantidad||','||LN_DEC||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_PMP_KIT_PR (EN_Articulo,LD_FecPmp,CV_IndCal,EN_NumOrdenC,LV_ValParKit,EN_cantidad,LN_DEC,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
               RAISE ERROR_CONTROLADO;
        END IF;
   END IF;
   SN_Pmp:=LN_Pmp;
EXCEPTION
WHEN ERROR_CONTROLADO THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_CALCULA_PMP_DEV_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_CALCULA_PMP_DEV_PR', sSql, SN_cod_retorno, V_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_CALCULA_PMP_DEV_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_CALCULA_PMP_DEV_PR', sSql, SN_cod_retorno, V_des_error );
END AL_CALCULA_PMP_DEV_PR;

PROCEDURE AL_PMP_PR (EN_NumOrdenC     IN al_cabecera_ordenes1.num_orden%TYPE,
                     EN_NumOrdenI     IN al_cabecera_ordenes1.num_orden%TYPE)

IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   SN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
   SV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
   SN_num_evento    ge_errores_pg.evento;
   LR_LinOrd        al_lineas_ordenes2%rowtype;
   LN_PMP           al_pmp_articulo.prec_pmp%type;
   LB_Resultado     boolean:=TRUE;
   LV_Eventos       VARCHAR2(100);
   LBhay            boolean;
   ln_moneda_stock   al_datos_generales.cod_moneda_val%TYPE;
   ln_precio         al_pmp_articulo.prec_pmp%type;
   LN_moneda         al_cabecera_ordenes1.cod_moneda%type;
   ln_cambio_origen  ge_conversion.cambio%TYPE;
   ln_cambio_destino ge_conversion.cambio%TYPE;
   LB_calcula         boolean;
   LB_unavez         boolean;

   CURSOR C_LinOrd(EN_NumOrdenC  IN al_cabecera_ordenes2.num_orden%TYPE,
                   EN_NumOrdenI     IN al_cabecera_ordenes1.num_orden%TYPE)
   IS
   SELECT b.num_linea, b.cod_articulo, b.can_orden,  (b.prc_unidad  + b.prc_adic + b.prc_ff) prc_unidad
   FROM al_cabecera_ordenes2 a, al_lineas_ordenes2 b, al_tipos_stock c
   WHERE a.num_orden_ref=EN_NumOrdenC
     AND a.num_orden=EN_NumOrdenI
     and b.tip_stock=c.tip_stock --solucion incidencia....
     and c.ind_valorar=1
     AND a.num_orden=b.num_orden
     AND a.tip_orden=b.tip_orden;

BEGIN

       SN_cod_retorno :=  0;
       SN_num_evento  :=  0;
       SV_mens_retorno:= ' ';
       ln_cambio_origen:=NULL;
       ln_cambio_destino:=NULL;
       LB_calcula:=false;
       LB_unavez:=true;

       --Moneda de la OC.....
       LN_moneda:=NULL;
       ssql:='select trim(cod_moneda) into LN_moneda from al_cabecera_ordenes1  where num_orden='||EN_NumOrdenC;
       select trim(cod_moneda) into LN_moneda from al_cabecera_ordenes1  where num_orden=EN_NumOrdenC;

       --Obtener moneda en que se encuentra valorado el stock
       ln_moneda_stock:=null;
       ssql:='select trim(cod_moneda_val) into ln_moneda_stock from al_datos_generales';
       select trim(cod_moneda_val) into ln_moneda_stock from al_datos_generales;

       if LN_moneda<>ln_moneda_stock then
          LB_calcula:=TRUE;
       end if;

       LBhay:=false;

       LB_Resultado:=true;
       for c1 in C_LinOrd(EN_NumOrdenC,EN_NumOrdenI) loop
       begin
         LBhay:=true;
         if LB_calcula  then
            if LB_unavez then
                ln_precio:= c1.prc_unidad;
                ssql:='SELECT a.cambio into ln_cambio_destino FROM  ge_conversion a' ||
                      ' WHERE a.cod_moneda = ' ||ln_moneda||
                      ' AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta';
                SELECT a.cambio into ln_cambio_destino FROM  ge_conversion a
                 WHERE a.cod_moneda = ln_moneda
                   AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta;

                ln_precio:=ln_precio *  ln_cambio_destino;
                LB_unavez:=false;
            end if;
         else
             ln_precio:= c1.prc_unidad;
         end if;

         sSql:='AL_CALCULA_PMP_PR ('||c1.cod_articulo||','||EN_NumOrdenC||','||c1.can_orden||','||ln_precio||','||LN_PMP||',SN_cod_retorno,SV_mens_retorno,SN_num_evento )';
         AL_CALCULA_PMP_PR (c1.cod_articulo,EN_NumOrdenC,c1.can_orden,ln_precio,LN_PMP,SN_cod_retorno,SV_mens_retorno,SN_num_evento );
         IF SN_cod_retorno <> CN_Cero THEN
            LB_Resultado:=FALSE;
            LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
         END IF;
       exception
       when others then
           LB_Resultado:=FALSE;
           SN_cod_retorno:=156;
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           V_des_error := 'AL_PMP_PR - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_PMP_PR', sSql, SN_cod_retorno, V_des_error );
           LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
       end;
       end loop;
       if lbhay then
           IF NOT LB_Resultado THEN
              RAISE_APPLICATION_ERROR(-20158, SN_cod_retorno ||'- Evento: '||LV_Eventos || ' - ' || 'Problemas al Calcular PMP para la Orden '||EN_NumOrdenC);
           END IF;
       end if;
END AL_PMP_PR;


PROCEDURE AL_REVERSA_PMP_PR (EN_NumOrdenC    IN al_cabecera_ordenes1.num_orden%TYPE,
                             EN_Precio       IN varchar2,
                             EN_Articulo     IN al_lineas_ordenes1.cod_articulo%TYPE,
                             EV_tipo         IN varchar2)

IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   SN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
   SV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
   SN_num_evento    ge_errores_pg.evento;
   LB_Resultado     boolean:=TRUE;
   LV_Eventos       VARCHAR2(100);
   LN_OrdenMax      al_pmp_articulo_th.num_orden%type;
   LN_PrcPMP        al_pmp_articulo_th.prec_pmp%type;
   LN_CanStock      al_pmp_articulo_th.can_stock%type;
   LN_PMPNuevo      al_pmp_articulo_th.prec_pmp%type;
   LN_CanOrd        al_lineas_ordenes1.can_orden%TYPE;
   LR_PmpArt        al_pmp_articulo%ROWTYPE;
   LD_FecPmp        DATE;
   LN_PmpVig        al_pmp_articulo_th.prec_pmp%type;
   LV_ValParKit     VARCHAR2(20);
   LV_Mensaje       AL_PMP_REVERSA_TO.det_mensaje%type;
   LN_StockInv      al_stock.can_stock%type;
   LN_Precio        al_lineas_ordenes1.prc_unidad%TYPE;
   LN_ingresos      al_pmp_articulo_th.can_ingresos%TYPE;
   LD_fec_dia_pmp   al_pmp_articulo_th.fec_dia_pmp%TYPE;
   i                NUMBER(1);
   LBhay        boolean;
   Ld_fec_ult_mod   al_pmp_articulo_th.fec_ult_mod%type;
   ln_dec           number(1);

cursor ord_ing (EN_NumOrdenC in al_cabecera_ordenes2.num_orden_ref%type) Is
select a.num_orden num_orden, nvl(sum(b.can_orden),0) can_orden
from  al_cabecera_ordenes2 a, al_lineas_ordenes2 b, al_tipos_stock c
WHERE a.num_orden_ref  = EN_NumOrdenC
and a.tip_orden=2
and a.num_orden=b.num_orden
and b.tip_stock=c.tip_stock
and c.ind_valorar=1
group by a.num_orden
order by a.num_orden desc;

cursor ord_ing_hist (EN_NumOrdenC in al_Hcabecera_ordenes2.num_orden_ref%type) Is
select a.num_orden num_orden, nvl(sum(b.can_orden),0) can_orden
from  al_hcabecera_ordenes2 a, al_hlineas_ordenes2 b, al_tipos_stock c
WHERE a.num_orden_ref  = EN_NumOrdenC
and a.tip_orden=2
and a.num_orden=b.num_orden
and b.tip_stock=c.tip_stock
and c.ind_valorar=1
group by a.num_orden
order by a.num_orden desc;

BEGIN

   sSql:='SELECT NVL(valor_numerico,0)  INTO LN_DEC From AL_PARAMETROS_SIMPLES_VW  WHERE cod_modulo=AL and AND nom_parametro=CANT_DECIMALES_PMP ';
   LN_DEC:=0;
   BEGIN
      SELECT NVL(valor_numerico,0)  INTO LN_DEC
        From AL_PARAMETROS_SIMPLES_VW  WHERE cod_modulo='AL'
        AND nom_parametro='CANT_DECIMALES_PMP';
   EXCEPTION
     WHEN OTHERS THEN
        LN_DEC:=0;
   END;


  sSql:='LN_precio:=TO_NUMBER(EN_precio) ';
  LN_precio:=TO_number(EN_precio);


  if EV_tipo='V' then ---orden de compra pendiente....
       --obtener la cantidad articulos de las ordenes de ingreso asociadas a la orden de compra...
       sSql:=' SELECT nvl(sum(can_orden),0) ';
       sSql:= sSql||' FROM al_cabecera_ordenes2 a, al_lineas_ordenes2 b ';
       sSql:= sSql||' WHERE a.num_orden_ref  ='|| EN_NumOrdenC ||' and a.num_orden=b.num_orden and b.tip_orden=2 and b.COD_ARTICULO='||EN_articulo;
       select  nvl(sum(can_orden),CN_cero) INTO  LN_CanOrd
        from al_cabecera_ordenes2 a, al_lineas_ordenes2 b  where
        a.num_orden_ref= EN_NumOrdenC and a.num_orden=b.num_orden and b.tip_orden=2 and b.COD_ARTICULO=EN_articulo;

       LBhay:=false;
       i:=1;
       LN_ingresos:=0;
       for c1 in ord_ing(EN_NumOrdenC) loop
         LN_ingresos:=c1.can_orden;
         LBhay:=true;
         if i=2 then
            exit;
         end if;
         i:=i+1;
       end loop;

       if LBhay then
           BEGIN
                sSql:='SELECT val_parametro ' ;
                sSql:=sSql||'FROM ged_parametros ';
                sSql:=sSql||'WHERE nom_parametro='||CV_PmpConKit;
                sSql:=sSql||'  AND cod_modulo=AL';
                sSql:=sSql||'  AND cod_producto=1';
                SELECT val_parametro    INTO LV_ValParKit
                FROM ged_parametros
                WHERE nom_parametro=CV_PmpConKit
                  AND cod_modulo=CV_modulo
                  AND cod_producto=CN_uno;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno := 1362;
                 LB_Resultado:=FALSE;
                 LV_Eventos:='Error='|| SN_cod_retorno||' - ';
           END;



           IF LB_Resultado THEN

                BEGIN
                    sSql:=' SELECT max(fec_ult_mod)  INTO Ld_fec_ult_mod ';
                    sSql:= sSql||' FROM AL_PMP_ARTICULO_TH ';
                    sSql:= sSql||' WHERE cod_articulo='||EN_Articulo;

                    SELECT max(fec_ult_mod)  INTO Ld_fec_ult_mod
                    FROM AL_PMP_ARTICULO_TH
                    WHERE cod_articulo=EN_Articulo;

                    sSql:=' SELECT prec_pmp, can_stock,can_ingresos, fec_dia_pmp ';
                    sSql:= sSql||' FROM AL_PMP_ARTICULO_TH ';
                    sSql:= sSql||' WHERE cod_articulo='||EN_Articulo;
                    sSql:= sSql||'  and fec_ult_mod='||Ld_fec_ult_mod;
                    SELECT prec_pmp, can_stock,can_ingresos, fec_dia_pmp
                    INTO LN_PrcPMP,LN_CanStock,LN_ingresos, LD_fec_dia_pmp
                    FROM AL_PMP_ARTICULO_TH
                    WHERE cod_articulo=EN_Articulo
                     and fec_ult_mod=Ld_fec_ult_mod;
                    sSql:=' LN_PMPNuevo:=(('||LN_CanOrd||'* '||LN_Precio||') + ('||LN_CanStock||'* '||LN_PrcPMP||'))/ ('||LN_CanOrd||'+'||LN_CanStock||')';
                    LN_PMPNuevo:=((LN_CanOrd* LN_Precio) + (LN_CanStock* LN_PrcPMP))/ (LN_CanOrd+LN_CanStock);

                EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        LN_PrcPMP:=0;
                        LN_CanStock:=0;
                        --Stock Lo que hay en Inventario
                        sSql:='AL_STOCK_VIGENTE_PR('||EN_Articulo||',LN_StockInv,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_STOCK_VIGENTE_PR(EN_Articulo,LV_ValParKit,LN_StockInv,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno<> CN_cero THEN
                           LB_Resultado:=FALSE;
                           LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;

                        LN_CanStock:=LN_StockInv;
                        LN_PrcPMP:= LN_Precio;
                        sSql:=' LN_PMPNuevo:=( ('||LN_CanStock||' * '||LN_PrcPMP||') / '||LN_CanStock||')';
                        LN_PMPNuevo:=( (LN_CanStock * LN_PrcPMP) / LN_CanStock);

                END;
                LD_FecPmp:=sysdate;

                LN_PMPNuevo:=round(LN_PMPNuevo,ln_dec);

                --Datos PMP Vigente
                sSql:='AL_PMP_VIGENTE_PR('||EN_Articulo||',LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                AL_PMP_VIGENTE_PR(EN_Articulo,LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno = CN_cero THEN
                    IF LN_PmpVig <> CN_cero  THEN --Existe PMP Vigente
                        sSql:='AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,'||LD_FecPmp||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,LD_FecPmp,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno= CN_cero THEN
                           --DBMS_OUTPUT.PUT_LINE ( 'LR_PmpArt.can_ingresos= '||LR_PmpArt.can_ingresos);
                           --Modificar
                            LR_PmpArt.can_stock:=LN_CanStock;
                            LR_PmpArt.prec_pmp:=LN_PMPNuevo;
                            LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
                            LR_PmpArt.fec_ult_mod:=LD_FecPmp;
                            LR_PmpArt.ind_calculo:=CV_IndCalR;
                            LR_PmpArt.num_orden:=EN_NumOrdenC;
                            LR_PmpArt.fec_dia_pmp:=LD_fec_dia_pmp;

                            sSql:='AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                            AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                            IF SN_cod_retorno<> CN_cero THEN
                              LB_Resultado:=FALSE;
                              LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                            END IF;
                        ELSE
                            LB_Resultado:=FALSE;
                            LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;
                    ELSE
                      --Inserta PMP
                        LR_PmpArt.cod_articulo:=EN_Articulo;
                        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
                        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
                        LR_PmpArt.can_stock:=LN_CanStock;
                        LR_PmpArt.prec_pmp:=LN_PMPNuevo;
                        LR_PmpArt.cod_operadora_scl:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        LR_PmpArt.can_salidas:=CN_cero;
                        LR_PmpArt.can_entradas:=CN_cero;
                        LR_PmpArt.can_ingresos:=LN_Ingresos;
                        LR_PmpArt.ind_calculo:=CV_IndCalR;
                        LR_PmpArt.num_orden:=EN_NumOrdenC;
                        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
                        sSql:='AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno<> CN_cero THEN
                           LB_Resultado:=FALSE;
                           LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;
                    END IF;
                ELSE
                    LB_Resultado:=FALSE;
                    LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                END IF;

                IF LB_Resultado THEN
                    --KIT
                   IF LV_ValParKit='TRUE' THEN
                        --Calculo PMP Kit
                        sSql:='AL_PMP_KIT_PR ('||EN_Articulo||','||LD_FecPmp||','||CV_IndCalR||','||EN_NumOrdenC||','||LV_ValParKit||','||LN_CanOrd||','||ln_dec||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_PMP_KIT_PR (EN_Articulo,LD_FecPmp,CV_IndCalR,EN_NumOrdenC,LV_ValParKit,LN_CanOrd,ln_dec,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno<> CN_cero THEN
                               LB_Resultado:=FALSE;
                               LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;
                   END IF;
                END IF;

                ---Actualiza Precio O/C
                UPDATE al_lineas_ordenes3
                SET  prc_unidad=LN_Precio
                WHERE num_orden=EN_NumOrdenC
                  AND tip_orden=CN_uno
                  AND cod_articulo=EN_Articulo;
                ---Actualiza Precio O/I
                UPDATE al_lineas_ordenes2 a
                SET a.prc_unidad=LN_Precio
                WHERE EXISTS (SELECT 1 FROM al_cabecera_ordenes2 b WHERE b.num_orden_ref=EN_NumOrdenC AND b.num_orden=a.num_orden AND b.tip_orden=a.tip_orden)
                  AND a.cod_articulo=EN_Articulo;


               --Registrar Usuario Reversa
               IF NOT LB_Resultado THEN
                LV_Mensaje:=substr('Error en calcular PMP para deolucion:'|| LV_Eventos,150) ;
               END IF;
               AL_AUDIT_REVERSA_PMP_PR (LV_Mensaje,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

           END IF;

           IF NOT LB_Resultado THEN
              RAISE_APPLICATION_ERROR(-20158, SN_cod_retorno ||'- Evento: '||LV_Eventos || ' - ' || 'Problemas al Reversar PMP para la Orden '||EN_NumOrdenC);
           END IF;

     end if; --lb_hay

  else
    ---orden de compra en histórico.....
       --obtener la cantidad articulos de las ordenes de ingreso asociadas a la orden de compra...
       sSql:=' SELECT nvl(sum(can_orden),0) ';
       sSql:= sSql||' FROM al_hcabecera_ordenes2 a, al_hlineas_ordenes2 b ';
       sSql:= sSql||' WHERE a.num_orden_ref  ='|| EN_NumOrdenC ||' and a.num_orden=b.num_orden and b.tip_orden=2 and b.COD_ARTICULO='||EN_articulo;
       select  nvl(sum(can_orden),CN_cero) INTO  LN_CanOrd
        from al_hcabecera_ordenes2 a, al_hlineas_ordenes2 b  where
        a.num_orden_ref= EN_NumOrdenC and a.num_orden=b.num_orden and b.tip_orden=2 and b.COD_ARTICULO=EN_articulo;

       LBhay:=false;
       i:=1;
       LN_ingresos:=0;
       for c1 in ord_ing_hist(EN_NumOrdenC) loop
         LN_ingresos:=c1.can_orden;
         LBhay:=true;
         if i=2 then
            exit;
         end if;
         i:=i+1;
       end loop;

       if LBhay then
           BEGIN
                sSql:='SELECT val_parametro ' ;
                sSql:=sSql||'FROM ged_parametros ';
                sSql:=sSql||'WHERE nom_parametro='||CV_PmpConKit;
                sSql:=sSql||'  AND cod_modulo=AL';
                sSql:=sSql||'  AND cod_producto=1';
                SELECT val_parametro    INTO LV_ValParKit
                FROM ged_parametros
                WHERE nom_parametro=CV_PmpConKit
                  AND cod_modulo=CV_modulo
                  AND cod_producto=CN_uno;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
                 SN_cod_retorno := 1362;
                 LB_Resultado:=FALSE;
                 LV_Eventos:='Error='|| SN_cod_retorno||' - ';
           END;


           IF LB_Resultado THEN
                BEGIN
                    sSql:=' SELECT max(fec_ult_mod)  INTO Ld_fec_ult_mod ';
                    sSql:= sSql||' FROM AL_PMP_ARTICULO_TH ';
                    sSql:= sSql||' WHERE cod_articulo='||EN_Articulo;

                    SELECT max(fec_ult_mod)  INTO Ld_fec_ult_mod
                    FROM AL_PMP_ARTICULO_TH
                    WHERE cod_articulo=EN_Articulo;

                    sSql:=' SELECT prec_pmp, can_stock,can_ingresos, fec_dia_pmp ';
                    sSql:= sSql||' FROM AL_PMP_ARTICULO_TH ';
                    sSql:= sSql||' WHERE cod_articulo='||EN_Articulo;
                    sSql:= sSql||'  and fec_ult_mod='||Ld_fec_ult_mod;
                    SELECT prec_pmp, can_stock,can_ingresos, fec_dia_pmp
                    INTO LN_PrcPMP,LN_CanStock,LN_ingresos, LD_fec_dia_pmp
                    FROM AL_PMP_ARTICULO_TH
                    WHERE cod_articulo=EN_Articulo
                     and fec_ult_mod=Ld_fec_ult_mod;
                    sSql:=' LN_PMPNuevo:=(('||LN_CanOrd||'* '||LN_Precio||') + ('||LN_CanStock||'* '||LN_PrcPMP||'))/ ('||LN_CanOrd||'+'||LN_CanStock||')';
                    LN_PMPNuevo:=((LN_CanOrd* LN_Precio) + (LN_CanStock* LN_PrcPMP))/ (LN_CanOrd+LN_CanStock);

                EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                        LN_PrcPMP:=0;
                        LN_CanStock:=0;
                        --Stock Lo que hay en Inventario
                        sSql:='AL_STOCK_VIGENTE_PR('||EN_Articulo||',LN_StockInv,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_STOCK_VIGENTE_PR(EN_Articulo,LV_ValParKit,LN_StockInv,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno<> CN_cero THEN
                           LB_Resultado:=FALSE;
                           LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;

                        LN_CanStock:=LN_StockInv;
                        LN_PrcPMP:= LN_Precio;
                        sSql:=' LN_PMPNuevo:=( ('||LN_CanStock||' * '||LN_PrcPMP||') / '||LN_CanStock||')';
                        LN_PMPNuevo:=( (LN_CanStock * LN_PrcPMP) / LN_CanStock);

                END;
                LD_FecPmp:=sysdate;
                LN_PMPNuevo:=round(LN_PMPNuevo,ln_dec);
                --Datos PMP Vigente
                sSql:='AL_PMP_VIGENTE_PR('||EN_Articulo||',LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                AL_PMP_VIGENTE_PR(EN_Articulo,LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                IF SN_cod_retorno = CN_cero THEN
                    IF LN_PmpVig <> CN_cero  THEN --Existe PMP Vigente
                        LR_PmpArt.ind_calculo:=CV_IndCalD;
                        sSql:='AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,'||LD_FecPmp||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,LD_FecPmp,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno= CN_cero THEN
                           --DBMS_OUTPUT.PUT_LINE ( 'LR_PmpArt.can_ingresos= '||LR_PmpArt.can_ingresos);
                           --Modificar
                            LR_PmpArt.can_stock:=LN_CanStock;
                            LR_PmpArt.prec_pmp:=LN_PMPNuevo;
                            LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
                            LR_PmpArt.fec_ult_mod:=LD_FecPmp;
                            LR_PmpArt.ind_calculo:=CV_IndCalR;
                            LR_PmpArt.num_orden:=EN_NumOrdenC;
                            LR_PmpArt.fec_dia_pmp:=LD_fec_dia_pmp;
                            sSql:='AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                            AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

                            IF SN_cod_retorno<> CN_cero THEN
                              LB_Resultado:=FALSE;
                              LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                            END IF;
                        ELSE
                            LB_Resultado:=FALSE;
                            LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;
                    ELSE
                      --Inserta PMP
                        LR_PmpArt.cod_articulo:=EN_Articulo;
                        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
                        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
                        LR_PmpArt.can_stock:=LN_CanStock;
                        LR_PmpArt.prec_pmp:=LN_PMPNuevo;
                        LR_PmpArt.cod_operadora_scl:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        LR_PmpArt.can_salidas:=CN_cero;
                        LR_PmpArt.can_entradas:=CN_cero;
                        LR_PmpArt.can_ingresos:=LN_Ingresos;
                        LR_PmpArt.ind_calculo:=CV_IndCalR;
                        LR_PmpArt.num_orden:=EN_NumOrdenC;
                        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
                        sSql:='AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno<> CN_cero THEN
                           LB_Resultado:=FALSE;
                           LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;
                    END IF;
                ELSE
                    LB_Resultado:=FALSE;
                    LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                END IF;

                IF LB_Resultado THEN
                   --KIT
                   IF LV_ValParKit='TRUE' THEN
                        --Calculo PMP Kit
                        sSql:='AL_PMP_KIT_PR ('||EN_Articulo||','||LD_FecPmp||','||CV_IndCalR||','||EN_NumOrdenC||','||LV_ValParKit||','||LN_CanOrd||','||ln_dec||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
                        AL_PMP_KIT_PR (EN_Articulo,LD_FecPmp,CV_IndCalR,EN_NumOrdenC,LV_ValParKit,LN_CanOrd,ln_dec,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                        IF SN_cod_retorno<> CN_cero THEN
                               LB_Resultado:=FALSE;
                               LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
                        END IF;
                   END IF;
                END IF;

                ---Actualiza Precio O/C
                UPDATE al_hlineas_ordenes1
                SET  prc_unidad=LN_Precio
                WHERE num_orden=EN_NumOrdenC
                  AND tip_orden=CN_uno
                  AND cod_articulo=EN_Articulo;

               ---Actualiza Precio O/I
                UPDATE al_hlineas_ordenes2 a
                SET a.prc_unidad=LN_Precio
                WHERE EXISTS (SELECT 1 FROM al_hcabecera_ordenes2 b WHERE b.num_orden_ref=EN_NumOrdenC AND b.num_orden=a.num_orden AND b.tip_orden=a.tip_orden)
                  AND a.cod_articulo=EN_Articulo;

               --Registrar Usuario Reversa
               IF NOT LB_Resultado THEN
                LV_Mensaje:=substr('Error en Recalcular PMP'|| LV_Eventos,150) ;
               END IF;
               AL_AUDIT_REVERSA_PMP_PR (LV_Mensaje,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

           END IF;

           IF NOT LB_Resultado THEN
              RAISE_APPLICATION_ERROR(-20158, SN_cod_retorno ||'- Evento: '||LV_Eventos || ' - ' || 'Problemas al Reversar PMP para la Orden '||EN_NumOrdenC);
           END IF;

     end if; --lb_hay

  end if;


EXCEPTION
  WHEN OTHERS THEN
     RAISE_APPLICATION_ERROR(-20175, SQLCODE ||' - '||SQLERRM || ' - ' || 'Problemas al Reversar PMP para la Orden '||EN_NumOrdenC);
END AL_REVERSA_PMP_PR;
----------------------------------------------------------------------------------------------
PROCEDURE AL_RECALCULA_PMP_PR (EN_Articulo     IN al_articulos.cod_articulo%TYPE,
                             EN_NumOrdenD    IN al_cabecera_ordenes3.num_orden%TYPE,
                             SN_Pmp          OUT NOCOPY al_pmp_articulo.prec_pmp%TYPE,
                             SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento   OUT NOCOPY ge_errores_pg.evento)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   LN_PmpVig        al_pmp_articulo.prec_pmp%TYPE;
   LN_Pmp           al_pmp_articulo.prec_pmp%TYPE;
   LR_PmpArt        al_pmp_articulo%ROWTYPE;
   LN_Stock         NUMBER(15);

   LD_FecPmp        DATE;
   LV_FecPmp        VARCHAR2(25);
   LV_ValParKit     VARCHAR2(20);
   LN_StockNuevo    NUMBER(15);
   ln_dec           NUMBER(1);
   LN_Preciotot_dev    al_lineas_ordenes2.prc_unidad%TYPE;
   LN_cantot_dev  al_lineas_ordenes2.can_orden%TYPE;
BEGIN
   SN_cod_retorno :=  0;
   SN_num_evento  :=  0;
   SV_mens_retorno:= ' ';
   BEGIN
        sSql:='SELECT val_parametro ' ;
        sSql:=sSql||'FROM ged_parametros ';
        sSql:=sSql||'WHERE nom_parametro='||CV_PmpConKit;
        sSql:=sSql||'  AND cod_modulo=AL';
        sSql:=sSql||'  AND cod_producto=1';
        SELECT val_parametro
        INTO LV_ValParKit
        FROM ged_parametros
        WHERE nom_parametro=CV_PmpConKit
          AND cod_modulo=CV_modulo
          AND cod_producto=CN_uno;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 1362;
         RAISE ERROR_CONTROLADO;
   END;

   LN_DEC:=0;
   BEGIN
      SELECT NVL(valor_numerico,0)  INTO LN_DEC
        From AL_PARAMETROS_SIMPLES_VW  WHERE cod_modulo='AL'
        AND nom_parametro='CANT_DECIMALES_PMP';
   EXCEPTION
     WHEN OTHERS THEN
        LN_DEC:=0;
   END;

   sSql:='AL_PMP_VIGENTE_PR('||EN_Articulo||',LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_PMP_VIGENTE_PR(EN_Articulo,LN_PmpVig,LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno<> CN_cero THEN
       RAISE ERROR_CONTROLADO;
   END IF;

   sSql:='AL_STOCK_VIGENTE_PR('||EN_Articulo||',LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_STOCK_VIGENTE_PR(EN_Articulo,LV_ValParKit,LN_Stock,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
   IF SN_cod_retorno<> CN_cero THEN
       RAISE ERROR_CONTROLADO;
   END IF;


   --obtiene sumatoria de precio de series devueltas....
   LN_Preciotot_dev:=0;
   LN_cantot_dev:=0;
   sSql:='AL_SUMA_DEVOLUCION_PR('||EN_NumOrdenD||','||EN_Articulo||','||LN_DEC||',LN_Preciotot_dev,LN_cantot_dev,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
   AL_SUMA_DEVOLUCION_PR (EN_NumOrdenD,EN_Articulo,LN_DEC,LN_Preciotot_dev,LN_cantot_dev,SN_cod_retorno,SV_mens_retorno,SN_num_evento);

   --LN_StockNuevo:=(LN_Stock-LN_cantot_dev);
   
   LN_StockNuevo:=LN_Stock;
   LN_Stock := LN_Stock + LN_cantot_dev;
   
   
   BEGIN
        sSql:='LN_Pmp:=(('||LN_Stock ||'*'|| LN_PmpVig||') - '||LN_Preciotot_dev||')/'||LN_Stock||'-'||LN_cantot_dev;
        LN_Pmp:=((LN_Stock * LN_PmpVig) -  LN_Preciotot_dev) / LN_StockNuevo;
        LN_Pmp:=ROUND(LN_Pmp,LN_DEC);
   EXCEPTION
     WHEN OTHERS THEN
       SN_cod_retorno := 2840;--Problemas al Calcular PMP
       RAISE ERROR_CONTROLADO;
   END;


   LD_FecPmp:=SYSDATE;
   LV_FecPmp:=TO_CHAR(SYSDATE,'DD-MM-YYYY hh24:mm:ss');
   IF LN_PmpVig<> CN_cero THEN
        --Traspaso Historico
        sSql:='AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,'||LD_FecPmp||',SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        LR_PmpArt.prec_pmp:=round(LR_PmpArt.prec_pmp,ln_dec);
        AL_PASO_HISTORICO_PMP_PR (LR_PmpArt,LD_FecPmp,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
               RAISE ERROR_CONTROLADO;
        END IF;
   END IF;

   IF LN_PmpVig = CN_cero THEN
        --Insertar
        LR_PmpArt.cod_articulo:=EN_Articulo;
        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
        LR_PmpArt.can_stock:=LN_StockNuevo;
        LR_PmpArt.prec_pmp:=LN_Pmp;
        LR_PmpArt.cod_operadora_scl:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
        LR_PmpArt.can_salidas:=LN_cantot_dev;
        LR_PmpArt.can_entradas:=CN_cero;
        LR_PmpArt.can_ingresos:=CN_cero;
        LR_PmpArt.ind_calculo:=CV_IndCalD;
        LR_PmpArt.num_orden:=EN_NumOrdenD;
        sSql:='AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_INSERTA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
           RAISE ERROR_CONTROLADO;
        END IF;
   ELSE
        --Modificar
        LR_PmpArt.can_stock:=LN_StockNuevo;
        LR_PmpArt.prec_pmp:=LN_Pmp;
        LR_PmpArt.fec_periodo:=TRUNC(LD_FecPmp);
        LR_PmpArt.fec_ult_mod:=LD_FecPmp;
        LR_PmpArt.ind_calculo:=CV_IndCalD;
        LR_PmpArt.fec_dia_pmp:=to_date('31-12-3000 23:59:59','dd-mm-yyyy hh24:mi:ss');
        LR_PmpArt.can_salidas:=LN_cantot_dev;
        LR_PmpArt.can_entradas:=CN_cero;
        LR_PmpArt.can_ingresos:=CN_cero;
        LR_PmpArt.num_orden:=EN_NumOrdenD;
        sSql:='AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento)';
        AL_MODIFICA_PMP_PR (LR_PmpArt,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
        IF SN_cod_retorno<> CN_cero THEN
           RAISE ERROR_CONTROLADO;
        END IF;
   END IF;

   IF LV_ValParKit='TRUE' THEN
        --Calculo PMP Kit
        sSql:='AL_PMP_KIT_PR ('||EN_Articulo||','||LD_FecPmp||','||CV_IndCalD||','||EN_NumOrdenD||','||LV_ValParKit||','||LN_cantot_dev||','||LN_DEC||',SN_cod_retorno,SV_mens_retorno,SN_num_evento,DEV)';
        AL_PMP_KIT_PR (EN_Articulo,LD_FecPmp,CV_IndCalD,EN_NumOrdenD,LV_ValParKit,LN_cantot_dev,LN_DEC,SN_cod_retorno,SV_mens_retorno,SN_num_evento,'DEV');
        IF SN_cod_retorno<> CN_cero THEN
               RAISE ERROR_CONTROLADO;
        END IF;
   END IF;
   SN_Pmp:=LN_Pmp;

EXCEPTION
WHEN ERROR_CONTROLADO THEN
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_RECALCULA_PMP_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_RECALCULA_PMP_PR', sSql, SN_cod_retorno, V_des_error );
WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := CV_ErrorNoCla;
      END IF;
      V_des_error := 'AL_RECALCULA_PMP_PR - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_RECALCULA_PMP_PR', sSql, SN_cod_retorno, V_des_error );
END AL_RECALCULA_PMP_PR;
----------------------------------------------------------------------------------------------
PROCEDURE AL_RECALCULOXDEV_PMP_PR (EN_NumOrdenD    IN al_cabecera_ordenes3.num_orden%TYPE)
IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   SN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
   SV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
   SN_num_evento    ge_errores_pg.evento;
   LB_Resultado     boolean;
   LN_PMP           al_pmp_articulo.prec_pmp%type;
   salir_loop       exception;


CURSOR C_LinOrd(EN_NumOrdenD  IN al_cabecera_ordenes3.num_orden%TYPE)  IS
   SELECT b.num_linea, b.cod_articulo, b.can_orden, b.prc_unidad
   FROM al_cabecera_ordenes3 a, al_lineas_ordenes3 b,  al_tipos_stock c
   WHERE a.num_orden=EN_NumOrdenD
     and b.tip_stock=c.tip_stock --solucion incidencia....
     and c.ind_valorar=1
     AND a.num_orden=b.num_orden
     AND a.tip_orden=b.tip_orden;

BEGIN
       SN_cod_retorno :=  0;
       SN_num_evento  :=  0;
       SV_mens_retorno:= ' ';
       LB_Resultado:=true;
       LN_pmp:=null;

       for c1 in C_LinOrd(EN_NumOrdenD) loop
       begin
             sSql:='AL_RECALCULA_PMP_PR ('||c1.cod_articulo||','||EN_NumOrdenD||','||LN_PMP||',SN_cod_retorno,SV_mens_retorno,SN_num_evento )';
             AL_RECALCULA_PMP_PR (c1.cod_articulo,EN_NumOrdenD,LN_PMP,SN_cod_retorno,SV_mens_retorno,SN_num_evento );
             IF SN_cod_retorno <> CN_Cero THEN
                raise salir_loop;
             END IF;

      exception
       when salir_loop then
           SN_cod_retorno:=156;
           LB_Resultado:=false;
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           V_des_error := 'AL_RECALCULOXDEV_PMP_PR - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_RECALCULOXDEV_PMP_PR', sSql, SN_cod_retorno, V_des_error );
       when others then
           SN_cod_retorno:=156;
           LB_Resultado:=false;
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           V_des_error := 'AL_RECALCULOXDEV_PMP_PR - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_RECALCULOXDEV_PMP_PR', sSql, SN_cod_retorno, V_des_error );
       end;
       end loop;

       IF NOT LB_Resultado THEN
           RAISE_APPLICATION_ERROR(-20158, SN_cod_retorno ||'- Evento: '||SN_num_evento || ' - ' || 'Problemas al Recalcular PMP para la Orden Dev. '||EN_NumOrdenD);
       END IF;


EXCEPTION
WHEN OTHERS THEN
     RAISE_APPLICATION_ERROR(-20176, SQLCODE ||' - '||SQLERRM || ' - ' || 'Problemas al Recalcular PMP para la Orden Dev. '||EN_NumOrdenD);
END AL_RECALCULOXDEV_PMP_PR;

PROCEDURE AL_PMP_DEV_PR (EN_NumOrdenC   IN al_cabecera_ordenes3.num_orden%TYPE,
                         EN_NumOrdenI   IN al_cabecera_ordenes2.num_orden%TYPE)

IS
   V_des_error      ge_errores_pg.DesEvent;
   sSql             ge_errores_pg.vQuery;
   SN_cod_retorno   ge_errores_td.cod_msgerror%TYPE;
   SV_mens_retorno  ge_errores_td.det_msgerror%TYPE;
   SN_num_evento    ge_errores_pg.evento;
   LR_LinOrd        al_lineas_ordenes2%rowtype;
   LN_PMP           al_pmp_articulo.prec_pmp%type;
   LB_Resultado     boolean:=TRUE;
   LV_Eventos       VARCHAR2(100);
   LBhay            boolean;
   ln_moneda_stock   al_datos_generales.cod_moneda_val%TYPE;
   ln_precio         al_pmp_articulo.prec_pmp%type;
   LN_moneda         al_cabecera_ordenes1.cod_moneda%type;
   ln_cambio_origen  ge_conversion.cambio%TYPE;
   ln_cambio_destino ge_conversion.cambio%TYPE;
   LB_calcula         boolean;
   LB_unavez         boolean;

   CURSOR C_LinOrd(EN_NumOrdenC  IN al_cabecera_ordenes3.num_orden%TYPE,
                   EN_NumOrdenI  IN al_cabecera_ordenes1.num_orden%TYPE)
   IS
   SELECT b.num_linea, b.cod_articulo, b.can_orden,  (b.prc_unidad  + b.prc_adic + b.prc_ff) prc_unidad
   FROM al_cabecera_ordenes2 a, al_lineas_ordenes2 b, al_tipos_stock c
   WHERE a.num_orden_ref=EN_NumOrdenC
     AND a.num_orden=EN_NumOrdenI
     and b.tip_stock=c.tip_stock 
     and c.ind_valorar=1
     AND a.num_orden=b.num_orden
     AND a.tip_orden=b.tip_orden;

BEGIN

       SN_cod_retorno :=  0;
       SN_num_evento  :=  0;
       SV_mens_retorno:= ' ';
       ln_cambio_origen:=NULL;
       ln_cambio_destino:=NULL;
       LB_calcula:=false;
       LB_unavez:=true;

       --Moneda de la OC.....
       LN_moneda:=NULL;
       ssql:='select trim(cod_moneda) into LN_moneda from al_cabecera_ordenes3  where num_orden='||EN_NumOrdenC;
       select trim(cod_moneda) into LN_moneda from al_cabecera_ordenes3  where num_orden=EN_NumOrdenC;

       --Obtener moneda en que se encuentra valorado el stock
       ln_moneda_stock:=null;
       ssql:='select trim(cod_moneda_val) into ln_moneda_stock from al_datos_generales';
       select trim(cod_moneda_val) into ln_moneda_stock from al_datos_generales;

       if LN_moneda<>ln_moneda_stock then
          LB_calcula:=TRUE;
       end if;

       LBhay:=false;

       LB_Resultado:=true;
       for c1 in C_LinOrd(EN_NumOrdenC,EN_NumOrdenI) loop
       begin
         LBhay:=true;
         if LB_calcula  then
            if LB_unavez then
                ln_precio:= c1.prc_unidad;
                ssql:='SELECT a.cambio into ln_cambio_destino FROM  ge_conversion a' ||
                      ' WHERE a.cod_moneda = ' ||ln_moneda||
                      ' AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta';
                SELECT a.cambio into ln_cambio_destino FROM  ge_conversion a
                 WHERE a.cod_moneda = ln_moneda
                   AND SYSDATE BETWEEN a.fec_desde AND a.fec_hasta;

                ln_precio:=ln_precio *  ln_cambio_destino;
                LB_unavez:=false;
            end if;
         else
             ln_precio:= c1.prc_unidad;
         end if;

         sSql:='AL_CALCULA_PMP_DEV_PR ('||c1.cod_articulo||','||EN_NumOrdenC||','||c1.can_orden||','||ln_precio||','||LN_PMP||',SN_cod_retorno,SV_mens_retorno,SN_num_evento )';
         AL_CALCULA_PMP_DEV_PR (c1.cod_articulo,EN_NumOrdenC,c1.can_orden,ln_precio,LN_PMP,SN_cod_retorno,SV_mens_retorno,SN_num_evento );
         IF SN_cod_retorno <> CN_Cero THEN
            LB_Resultado:=FALSE;
            LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
         END IF;
       exception
       when others then
           LB_Resultado:=FALSE;
           SN_cod_retorno:=156;
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           V_des_error := 'AL_PMP_DEV_PR - ' || SQLERRM;
           SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'AL', SV_mens_retorno, '1.0', USER, 'AL_PMP_PG.AL_CALCULA_PMP_DEV_PR', sSql, SN_cod_retorno, V_des_error );
           LV_Eventos:=LV_Eventos || ' - '|| SN_num_evento;
       end;
       end loop;
       if lbhay then
           IF NOT LB_Resultado THEN
              RAISE_APPLICATION_ERROR(-20158, SN_cod_retorno ||'- Evento: '||LV_Eventos || ' - ' || 'Problemas al Calcular PMP para la Orden de Devolucion:'||EN_NumOrdenC);
           END IF;
       end if;
END AL_PMP_DEV_PR;


END AL_PMP_PG; 
/
SHOW ERRORS
