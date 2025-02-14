CREATE OR REPLACE PACKAGE BODY PV_COBRAR_PG AS




 PROCEDURE PV_CARGO_DESCUENTO_PR(
                         EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                         SV_GLOSA         IN OUT NOCOPY VARCHAR2)




/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_DESCUENTO_PR"
      Lenguaje="PL/SQL"
      Fecha="20-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas "
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>


                        <param nom="EV_COD_OPERA    "   Tipo="VARCHAR2">codigo operacion</param>
                        <param nom="EV_TIP_CONT    "   Tipo="VARCHAR2">tipo contrato</param>
            <param nom="EN_MES      "   Tipo="NUMERICO">mes actual</param>
                        <param nom="EV_COD_ANT       "   Tipo="VARCHAR2">codigo antiguedad</param>
            <param nom="EV_ESTADO_EQ  "   Tipo="VARCHAR2">estado equipo</param>
                        <param nom="EV_COD_CNUE     "   Tipo="VARCHAR2">contrato nuevo</param>
                        <param nom="EV_MESNUE     "   Tipo="NUMERICO">mes nuevo</param>
                        <param nom="EN_COD_ARTI        "   Tipo="NUMERICO">articulo</param>
                        <param nom="EV_COD_CAUSA    "   Tipo="VARCHAR2">causa</param>
                        <param nom="EV_COD_CAUSA_NUE      "   Tipo="VARCHAR2">causa nueva</param>
                        <param nom="EV_COD_CATEG    "   Tipo="varchar2">categoria</param>
                        <param nom="EN_COD_MODVTA   "   Tipo="numerico">modo venta</param>
                        <param nom="EN_COD_CLIENTE           "   Tipo="NUMERICO">cliente</param>
                        <param nom="EN_COD_VENDE       "   Tipo="numerico">vendedor</param>
                        <param nom="EN_TIP_ABONADO  "   Tipo="varchar2">tipo abonado</param>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

                    </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

Lv_SqlFinal                VARCHAR2(30000);
Lv_SqlFinal2               VARCHAR2(30000);
LV_CLASE_DESC              ged_parametros.VAL_PARAMETRO%type;
LV_gsCantidadDecimalesFact ged_parametros.VAL_PARAMETRO%type;

LV_v_VALDTO_SEL            VARCHAR2(16);
LV_v_CONDESC_SEL           VARCHAR2(4);

LN_vValCero         NUMBER(2);
LN_NumMesFac        NUMBER(2);
LN_sValPromFact     NUMBER(8);
LN_sCodPromFact     AL_PROMFACT.COD_PROMEDIO%type;
LN_sindventaext     NUMBER(1);
LN_COD_CONCEPTO_AUX NUMBER(4);


LN_v_TIP_DESC_SEL   GAD_DESCUENTOS.TIP_DESCUENTO%TYPE;
LN_v_COD_MON_SEL    GAD_DESCUENTOS.COD_MONEDA%TYPE;
LN_v_VALDTO_SEL     GAD_DESCUENTOS.VAL_DESCUENTO%TYPE :=0;
LN_v_CONDESC_SEL    GAD_DESCUENTOS.COD_CONCEPTO_DSCTO%TYPE:=0;

LV_ESTADO_EQ        PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE;
LV_COD_CAUSA        PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE;

LN_VAL_MIN                      PV_TMPPARAMETROS_SALIDA_TT.VAL_MIN%TYPE;
LN_VAL_MAX          PV_TMPPARAMETROS_SALIDA_TT.VAL_MAX%TYPE;
LV_sDesEquipo           PV_TMPPARAMETROS_SALIDA_TT.DES_SERV%TYPE;
LN_sPrecioEquipo    PV_TMPPARAMETROS_SALIDA_TT.IMP_CARGO%TYPE;
LN_lValDescuento    PV_TMPPARAMETROS_SALIDA_TT.VAL_DTO%TYPE;
LN_LVAL             PV_TMPPARAMETROS_SALIDA_TT.VAL_DTO%TYPE;
LN_COD_CONCEPTOART_AUX AL_ARTICULOS.COD_CONCEPTOART%TYPE;
LN_FLG_ART          INTEGER;

LN_cursor_name          INTEGER;
LN_v_resul              INTEGER;

LV_v_posee_nc           BOOLEAN;
LN_LINE_DESC            BINARY_INTEGER := 0;

BEGIN
    dbms_output.put_line('PV_CARGO_DESCUENTO_PR - SV_RETORNO :'||SV_RETORNO);

     IF SV_RETORNO = '0' THEN


                         LN_vValCero    :=0;
                         LN_NumMesFac   :=6;
                         LN_sValPromFact:=0;
                         LN_sCodPromFact:=0;

                         /* PENDIENTE LLEVAR LOS PARAMETROS A UNA FUNCIÓN  !!!!*/

                         select TRIM(VAL_PARAMETRO)
                         INTO  LV_CLASE_DESC
                         from ged_parametros
                         where
                         cod_modulo   ='GA' AND
                         COD_PRODUCTO = 1 AND
                         NOM_PARAMETRO='CLASE_DESCUENTO';

                         select TRIM(VAL_PARAMETRO)
                         INTO  LV_gsCantidadDecimalesFact
                         from ged_parametros
                         where
                         cod_modulo   ='GE' AND
                         COD_PRODUCTO = 1 AND
                         NOM_PARAMETRO='NUM_DECIMAL_FACT';


                         Lv_SqlFinal2 := 'SELECT ROUND(SUM(TOT_FACTURA)/DECODE(COUNT(*),0,1,COUNT(*)))';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' FROM FA_HISTDOCU';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' WHERE COD_TIPDOCUM IN ';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) AND';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' FEC_EMISION BETWEEN SYSDATE - (' || LN_NumMesFac || '] * 30) AND SYSDATE AND';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' COD_CLIENTE = ' || EN_COD_CLIENTE  ;
                        dbms_output.put_line('PV_CARGO_DESCUENTO_PR - Lv_SqlFinal2 :'||Lv_SqlFinal2);

                         SELECT NVL(ROUND(SUM(TOT_FACTURA)/DECODE(COUNT(*),0,1,COUNT(*))),0)
                         INTO
                         LN_sValPromFact
                         FROM FA_HISTDOCU
                         WHERE COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = 1) AND
                         FEC_EMISION BETWEEN SYSDATE - ( LN_NumMesFac  * 30) AND SYSDATE AND COD_CLIENTE =  EN_COD_CLIENTE;


                         Lv_SqlFinal2 := 'SELECT COD_PROMEDIO';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' FROM AL_PROMFACT';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' WHERE  '|| LN_sValPromFact || ' BETWEEN FACT_DESDE AND FACT_HASTA';

                         dbms_output.put_line('PV_CARGO_DESCUENTO_PR - Lv_SqlFinal2 :'||Lv_SqlFinal2);
                         SELECT COD_PROMEDIO
                         INTO LN_sCodPromFact
                         FROM AL_PROMFACT
                         WHERE   LN_sValPromFact BETWEEN FACT_DESDE AND FACT_HASTA;

                         LN_LINE_DESC       := ind_parametros - 1;
                         LN_COD_CONCEPTO_AUX:= tab_parametros(LN_LINE_DESC).COD_CONCEPTO;

                         Lv_SqlFinal2 := 'SELECT DISTINCT COD_CONCEPTOART';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' FROM AL_ARTICULOS';
                         Lv_SqlFinal2 := Lv_SqlFinal2 || ' WHERE COD_CONCEPTOART= '||LN_COD_CONCEPTO_AUX;
                         dbms_output.put_line('PV_CARGO_DESCUENTO_PR - Lv_SqlFinal2 :'||Lv_SqlFinal2);
                         BEGIN

                         LN_FLG_ART:=1;
                         LV_CLASE_DESC:='ART';
                         SELECT DISTINCT COD_CONCEPTOART INTO  LN_COD_CONCEPTOART_AUX
                         FROM AL_ARTICULOS
                         WHERE COD_CONCEPTOART= LN_COD_CONCEPTO_AUX;
                         EXCEPTION
                                           WHEN NO_DATA_FOUND THEN
                                                        LN_FLG_ART:=0;
                                                        LV_CLASE_DESC:='CON';
                         END;

                     Lv_SqlFinal2 := ' SELECT a.ind_vta_externa ';
                     Lv_SqlFinal2 := Lv_SqlFinal2 || ' FROM   ve_tipcomis a, ve_vendedores b';
                     Lv_SqlFinal2 := Lv_SqlFinal2 || ' WHERE  b.cod_vendedor = '|| EN_COD_VENDE ;
                     Lv_SqlFinal2 := Lv_SqlFinal2 || ' AND    a.cod_tipcomis = b.cod_tipcomis';
                      dbms_output.put_line('PV_CARGO_DESCUENTO_PR - Lv_SqlFinal2 :'||Lv_SqlFinal2);
                     SELECT a.ind_vta_externa
                         INTO LN_sindventaext
                     FROM   ve_tipcomis a, ve_vendedores b
                     WHERE  b.cod_vendedor = EN_COD_VENDE
                     AND    a.cod_tipcomis = b.cod_tipcomis;



                     --If TRIM(LV_CLASE_DESC) = 'ART' Then
                         IF LN_FLG_ART= 1 THEN

                             Lv_SqlFinal := ' SELECT a.tip_descuento, a.cod_moneda,  NVL(a.val_descuento,0) , NVL(a.cod_concepto_dscto,0)';
                             Lv_SqlFinal := Lv_SqlFinal || '   FROM   gad_descuentos a';
                             Lv_SqlFinal := Lv_SqlFinal || '   WHERE  a.cod_operacion         = :EV_COD_OPERA';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.tip_contrato_actual   = :EV_TIP_CONT';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.num_meses_actual      = :EN_MES';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.cod_antiguedad        = :EV_COD_ANT';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.cod_promfact          = :LN_sCodPromFact';
                                dbms_output.put_line('PV_CARGO_DESCUENTO_PR - Lv_SqlFinal :'||Lv_SqlFinal);
                                     If TRIM(EV_ESTADO_EQ) <> '' Then
                                               LV_ESTADO_EQ:=EV_ESTADO_EQ;
                                   Lv_SqlFinal := Lv_SqlFinal || ' AND    a.cod_estado_dev    = :LV_ESTADO_EQ';
                             Else
                                               LV_ESTADO_EQ:='B';
                                   Lv_SqlFinal := Lv_SqlFinal || ' AND    a.Cod_estado_dev    = :LV_ESTADO_EQ';
                             End If;

                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.cod_tipcontrato_nuevo = :EV_COD_CNUE';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.num_meses_nuevo       = :EV_MESNUE';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.cod_articulo          = :EN_COD_ARTI';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    sysdate       BETWEEN a.fec_desde AND nvl(a.fec_hasta, sysdate)';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.clase_descuento       =  :LV_CLASE_DESC';
dbms_output.put_line('PV_CARGO_DESCUENTO_PR - Lv_SqlFinal :'||Lv_SqlFinal);

                                         LN_cursor_name := DBMS_SQL.OPEN_CURSOR;
                                     DBMS_SQL.PARSE(LN_cursor_name,Lv_SqlFinal, DBMS_SQL.native);

                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_COD_OPERA',TO_CHAR(EV_COD_OPERA));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_TIP_CONT',TO_CHAR(EV_TIP_CONT));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EN_MES',TO_CHAR(EN_MES));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_COD_ANT',TO_CHAR(EV_COD_ANT));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':LN_sCodPromFact',TO_CHAR(LN_sCodPromFact));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':LV_ESTADO_EQ',TO_CHAR(LV_ESTADO_EQ));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_COD_CNUE',TO_CHAR(EV_COD_CNUE));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_MESNUE',TO_CHAR(EV_MESNUE));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EN_COD_ARTI',TO_CHAR(EN_COD_ARTI));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':LV_CLASE_DESC',TO_CHAR(LV_CLASE_DESC));



                      Else


                             Lv_SqlFinal := ' SELECT a.tip_descuento, a.cod_moneda, NVL(a.val_descuento,0) , NVL(a.cod_concepto_dscto,0)';
                             Lv_SqlFinal := Lv_SqlFinal || '   FROM   gad_descuentos a';
                             Lv_SqlFinal := Lv_SqlFinal || '   WHERE  a.cod_operacion         = :Ev_COD_OPERA';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.cod_antiguedad        = :EV_COD_ANT';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.cod_tipcontrato_nuevo = :EV_COD_CNUE';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.num_meses_nuevo       = :EV_MESNUE';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    sysdate       BETWEEN a.fec_desde AND nvl(a.fec_hasta, sysdate)';
                             Lv_SqlFinal := Lv_SqlFinal || '   AND    a.ind_vta_externa       = :LN_sindventaext' ;

                             If  LN_sindventaext  = 1 Then
                                Lv_SqlFinal := Lv_SqlFinal || '     AND    a.cod_vendealer     = :EN_COD_VENDE';
                             End If;

                             If TRIM(EV_COD_CAUSA_NUE) = '' Then
                                             LV_COD_CAUSA:= EV_COD_CAUSA;
                                                 Lv_SqlFinal := Lv_SqlFinal || ' AND    a.cod_causa_dscto       = :LV_COD_CAUSA' ;
                                         ELSE
                                             LV_COD_CAUSA:= EV_COD_CAUSA_NUE ;
                                             Lv_SqlFinal := Lv_SqlFinal || ' AND    a.cod_causa_dscto       = :LV_COD_CAUSA';
                                         END IF;


                             Lv_SqlFinal := Lv_SqlFinal || ' AND    a.cod_categoria         = :EV_COD_CATEG';
                             Lv_SqlFinal := Lv_SqlFinal || ' AND    a.cod_modventa          = :EN_COD_MODVTA';
                             Lv_SqlFinal := Lv_SqlFinal || ' AND    a.tip_producto          = :EN_TIP_ABONADO';
                             Lv_SqlFinal := Lv_SqlFinal || ' AND    a.cod_concepto          = :LN_COD_CONCEPTO_AUX' ;
                             Lv_SqlFinal := Lv_SqlFinal || ' AND    a.clase_descuento       = :LV_CLASE_DESC' ;

dbms_output.put_line('PV_CARGO_DESCUENTO_PR - Lv_SqlFinal :'||Lv_SqlFinal);
                                         LN_cursor_name := DBMS_SQL.OPEN_CURSOR;
                                     DBMS_SQL.PARSE(LN_cursor_name,Lv_SqlFinal, DBMS_SQL.native);

                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_COD_OPERA',    TO_CHAR(EV_COD_OPERA));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_COD_ANT',      TO_CHAR(EV_COD_ANT));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_COD_CNUE',     TO_CHAR(EV_COD_CNUE));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_MESNUE',       TO_CHAR(EV_MESNUE));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':LN_sindventaext', TO_CHAR(LN_sindventaext));

                                         If  LN_sindventaext  = 1 Then
                                                  DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EN_COD_VENDE',    TO_CHAR(EN_COD_VENDE));
                                         END IF;

                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':LV_COD_CAUSA',    TO_CHAR(LV_COD_CAUSA));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EV_COD_CATEG',    TO_CHAR(EV_COD_CATEG));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EN_COD_MODVTA',   TO_CHAR(EN_COD_MODVTA));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':EN_TIP_ABONADO',  TO_CHAR(EN_TIP_ABONADO));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':LN_COD_CONCEPTO_AUX',TO_CHAR(LN_COD_CONCEPTO_AUX));
                                         DBMS_SQL.BIND_VARIABLE(LN_cursor_name, ':LV_CLASE_DESC',   TO_CHAR(LV_CLASE_DESC));



                      End If;



                      DBMS_SQL.DEFINE_COLUMN(LN_cursor_name, 1, LN_v_TIP_DESC_SEL,5);
                      DBMS_SQL.DEFINE_COLUMN(LN_cursor_name, 2, LN_v_COD_MON_SEL,3);
                          DBMS_SQL.DEFINE_COLUMN(LN_cursor_name, 3, LV_v_VALDTO_SEL,14.4);
                          DBMS_SQL.DEFINE_COLUMN(LN_cursor_name, 4, LV_v_CONDESC_SEL,4);

                      LN_v_resul:=DBMS_SQL.EXECUTE(LN_cursor_name);
                          LV_v_posee_nc:=FALSE;
                          LOOP
                                  IF DBMS_SQL.FETCH_ROWS(LN_cursor_name) = 0 THEN
                                          EXIT;
                              END IF;

                              DBMS_SQL.column_value(LN_cursor_name, 1,LN_v_TIP_DESC_SEL);
                                  DBMS_SQL.column_value(LN_cursor_name, 2,LN_v_COD_MON_SEL);
                                  DBMS_SQL.column_value(LN_cursor_name, 3,LV_v_VALDTO_SEL);
                                  DBMS_SQL.column_value(LN_cursor_name, 4,LV_v_CONDESC_SEL);

                                  LN_v_VALDTO_SEL:=LV_v_VALDTO_SEL;
                                  LN_v_CONDESC_SEL:=LV_v_CONDESC_SEL;

                                  If LN_v_VALDTO_SEL > 0 Then
                                 LN_VAL_MIN:=tab_parametros(LN_LINE_DESC).VAL_MIN;
                                         LN_VAL_MAX:=tab_parametros(LN_LINE_DESC).VAL_MAX;

                                 LN_VAL_MIN := (LN_VAL_MIN) - (((LN_VAL_MIN) * (LN_v_VALDTO_SEL)) / 100);
                                         LN_VAL_MAX := (LN_VAL_MAX) - (((LN_VAL_MAX) * (LN_v_VALDTO_SEL)) / 100);

                                         LV_sDesEquipo    := tab_parametros(LN_LINE_DESC).DES_SERV;
                                 LN_sPrecioEquipo := tab_parametros(LN_LINE_DESC).IMP_CARGO;

                                 LN_LINE_DESC := LN_LINE_DESC + 1;


                             If LN_v_TIP_DESC_SEL = 1 Then
                                LN_lValDescuento := (LN_sPrecioEquipo) - ((LN_sPrecioEquipo) * ((LN_v_VALDTO_SEL) / 100));
                                LN_LVAL          := ((LN_sPrecioEquipo) * ((LN_v_VALDTO_SEL) / 100));
                                LV_sDesEquipo    := LV_sDesEquipo || ' C/DCTO DE:(' || LN_v_VALDTO_SEL || '%)';

                                LN_lValDescuento := (LN_lValDescuento);

                                 Else
                                LN_LVAL          := (LN_v_VALDTO_SEL);
                                LN_lValDescuento := (LN_sPrecioEquipo) - (LN_v_VALDTO_SEL);
                                LV_sDesEquipo    := LV_sDesEquipo || ' C/DCTO DE:($ ' || LN_v_VALDTO_SEL || ')';

                                    LN_lValDescuento := (LN_lValDescuento);

                                         End If;



                                 If (LN_LVAL) < (LN_sPrecioEquipo) Then

                                  If LN_lValDescuento < 0 Then
                                                     LN_lValDescuento := 0;
                                                  END IF;

                                          SELECT PV_SEQ_NUMOS.NEXTVAL INTO GN_NUM_MOVIMIENTO FROM   DUAL ;
                                                  tab_parametros(LN_LINE_DESC).NUM_MOVIMIENTO:=   GN_NUM_MOVIMIENTO  ;
                                                  tab_parametros(LN_LINE_DESC).COD_ACTABO:=       tab_parametros(LN_LINE_DESC-1).COD_ACTABO           ;
                                          tab_parametros(LN_LINE_DESC).IND_FACTUR:=       tab_parametros(LN_LINE_DESC-1).IND_FACTUR           ;
                                          tab_parametros(LN_LINE_DESC).NUM_UNIDADES:=     tab_parametros(LN_LINE_DESC-1).NUM_UNIDADES         ;
                                          tab_parametros(LN_LINE_DESC).COD_CONCEPTO:=     tab_parametros(LN_LINE_DESC-1).COD_CONCEPTO         ;
                                          tab_parametros(LN_LINE_DESC).COD_ARTICULO:=     tab_parametros(LN_LINE_DESC-1).COD_ARTICULO         ;
                                          tab_parametros(LN_LINE_DESC).COD_BODEGA:=       tab_parametros(LN_LINE_DESC-1).COD_BODEGA           ;
                                          Tab_parametros(LN_LINE_DESC).NUM_SERIE:=        tab_parametros(LN_LINE_DESC-1).NUM_SERIE            ;
                                          tab_parametros(LN_LINE_DESC).IND_EQUIPO:=       tab_parametros(LN_LINE_DESC-1).IND_EQUIPO           ;
                                          tab_parametros(LN_LINE_DESC).COD_CLIENTE:=      tab_parametros(LN_LINE_DESC-1).COD_CLIENTE          ;
                                          tab_parametros(LN_LINE_DESC).NUM_ABONADO:=      tab_parametros(LN_LINE_DESC-1).NUM_ABONADO          ;
                                          Tab_parametros(LN_LINE_DESC).NUM_CELULAR:=      tab_parametros(LN_LINE_DESC-1).NUM_CELULAR          ;
                                          tab_parametros(LN_LINE_DESC).COD_PLANCOM:=      tab_parametros(LN_LINE_DESC-1).COD_PLANCOM          ;
                                          tab_parametros(LN_LINE_DESC).CLASE_SERVICIO_ACT:= tab_parametros(LN_LINE_DESC-1).CLASE_SERVICIO_ACT ;
                                          tab_parametros(LN_LINE_DESC).CLASE_SERVICIO_DES:= tab_parametros(LN_LINE_DESC-1).CLASE_SERVICIO_DES ;
                                          tab_parametros(LN_LINE_DESC).PARAM1_MENS:=      tab_parametros(LN_LINE_DESC-1).PARAM1_MENS          ;
                                          tab_parametros(LN_LINE_DESC).PARAM2_MENS:=      tab_parametros(LN_LINE_DESC-1).PARAM2_MENS          ;
                                          Tab_parametros(LN_LINE_DESC).PARMA3_MENS:=      tab_parametros(LN_LINE_DESC-1).PARMA3_MENS          ;
                                          tab_parametros(LN_LINE_DESC).CLASE_SERVICIO:=   tab_parametros(LN_LINE_DESC-1).CLASE_SERVICIO       ;
                                          tab_parametros(LN_LINE_DESC).DES_MONEDA:=       tab_parametros(LN_LINE_DESC-1).DES_MONEDA           ;
                                          tab_parametros(LN_LINE_DESC).COD_MONEDA:=       tab_parametros(LN_LINE_DESC-1).COD_MONEDA           ;
                                          tab_parametros(LN_LINE_DESC).COD_CICLO:=        tab_parametros(LN_LINE_DESC-1).COD_CICLO            ;
                                          tab_parametros(LN_LINE_DESC).FACT_CONT:=        tab_parametros(LN_LINE_DESC-1).FACT_CONT            ;
                                          tab_parametros(LN_LINE_DESC).VAL_MIN:=          tab_parametros(LN_LINE_DESC-1).VAL_MIN              ;
                                          tab_parametros(LN_LINE_DESC).VAL_MAX:=          tab_parametros(LN_LINE_DESC-1).VAL_MAX              ;
                                          tab_parametros(LN_LINE_DESC).P_DESC :=          tab_parametros(LN_LINE_DESC-1).P_DESC               ;
                                                  tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                                                  tab_parametros(ind_parametros).DES_ERROR          :='OK';


                                                  tab_parametros(LN_LINE_DESC-1).VAL_MIN:=0;
                                  tab_parametros(LN_LINE_DESC-1).VAL_MAX:=0;

                                                  tab_parametros(LN_LINE_DESC).DES_SERV:=LV_sDesEquipo ;
                                                  tab_parametros(LN_LINE_DESC).imp_cargo :=LN_lValDescuento ;
                                                  tab_parametros(LN_LINE_DESC).TIP_DTO:=  LN_v_TIP_DESC_SEL ;
                                                  tab_parametros(LN_LINE_DESC).val_dto:=  LV_v_VALDTO_SEL ;


                                                  tab_parametros(LN_LINE_DESC).VAL_MIN:=LN_VAL_MIN;
                                  tab_parametros(LN_LINE_DESC).VAL_MAX:=LN_VAL_MAX;
                                                  tab_parametros(LN_LINE_DESC).P_DESC:= 9;
                                  tab_parametros(LN_LINE_DESC).COD_CONCEPTO_DTO:=LN_v_CONDESC_SEL;

                                                  ind_parametros:= LN_LINE_DESC + 1;

                                         END IF;
                                  End If;
                          END LOOP;

                          DBMS_SQL.close_cursor(LN_cursor_name);
         END IF;


EXCEPTION
       WHEN NO_DATA_FOUND THEN
             SV_RETORNO :='0';
                     SV_GLOSA   :='OK';

       WHEN OTHERS THEN

                         SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_DESCUENTO_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                     tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                          ind_parametros := ind_parametros + 1;
                         PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA ) ;

             SV_RETORNO :='4';
                     SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
                     
                     dbms_output.put_line('PV_CARGO_DESCUENTO_PR - SV_GLOSA :'||SV_GLOSA);
             BEGIN
                     IF Lv_n_num_evento = -1 THEN
                        Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en PV_CARGO_DESCUENTO_PR ','1',USER,'PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
                     ELSE
                        Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en PV_CARGO_DESCUENTO_PR','1',USER,'PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
                     END IF;
                 END;
END PV_CARGO_DESCUENTO_PR;


PROCEDURE PV_INS_TMPPARAMETROS_SALIDA_PR( EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                          SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                                  SV_GLOSA         IN OUT NOCOPY VARCHAR2)
/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_INS_TMPPARAMETROS_SALIDA_PR"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                     <param nom=" EN_COD_PRODUCTO   "   Tipo="NUMERICO">PRODUCTO</param>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

                    </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

Lv_SqlFinal         VARCHAR2(5000);
LN_INDICE                       BINARY_INTEGER := 0;
BEGIN
 dbms_output.put_line('VALOR  :'||SV_RETORNO);

    IF SV_RETORNO = '0' THEN
dbms_output.put_line('ANTES DEL PV_TMPPARAMETROS_SALIDA_TT :');
                delete from  PV_TMPPARAMETROS_SALIDA_TT
                where
                cod_cliente  = tab_parametros(0).COD_CLIENTE;
                
                dbms_output.put_line('DESPESUES DEL PV_TMPPARAMETROS_SALIDA_TT : '||tab_parametros(0).COD_CLIENTE);

        WHILE LN_INDICE <= ind_parametros - 1 LOOP
                     Lv_SqlFinal :=' INSERT INTO PV_TMPPARAMETROS_SALIDA_TT';
                     Lv_SqlFinal := Lv_SqlFinal || '( NUM_MOVIMIENTO,COD_ACTABO,IND_FACTUR,DES_SERV';
                         Lv_SqlFinal := Lv_SqlFinal || ',NUM_UNIDADES,COD_CONCEPTO,IMP_CARGO,COD_ARTICULO';
                         Lv_SqlFinal := Lv_SqlFinal || ',COD_BODEGA,NUM_SERIE,IND_EQUIPO,COD_CLIENTE';
                         Lv_SqlFinal := Lv_SqlFinal || ',NUM_ABONADO,TIP_DTO,VAL_DTO,COD_CONCEPTO_DTO';
                         Lv_SqlFinal := Lv_SqlFinal || ',NUM_CELULAR,COD_PLANCOM,CLASE_SERVICIO_ACT,CLASE_SERVICIO_DES';
             Lv_SqlFinal := Lv_SqlFinal || ',PARAM1_MENS,PARAM2_MENS,PARMA3_MENS,CLASE_SERVICIO,DES_MONEDA,COD_MONEDA,COD_CICLO,FACT_CONT,VAL_MIN,VAL_MAX,P_DESC,COD_ERROR,DES_ERROR';
                     Lv_SqlFinal := Lv_SqlFinal || '   ) VALUES ( ';
                     Lv_SqlFinal := Lv_SqlFinal || tab_parametros(LN_INDICE).NUM_MOVIMIENTO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_ACTABO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).IND_FACTUR;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).DES_SERV;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).NUM_UNIDADES;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_CONCEPTO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| Tab_parametros(LN_INDICE).IMP_CARGO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| Tab_parametros(LN_INDICE).COD_ARTICULO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_BODEGA;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).NUM_SERIE;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).IND_EQUIPO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_CLIENTE;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).NUM_ABONADO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).TIP_DTO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).VAL_DTO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_CONCEPTO_DTO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).NUM_CELULAR;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_PLANCOM;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).CLASE_SERVICIO_ACT;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).CLASE_SERVICIO_DES;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).PARAM1_MENS;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).PARAM2_MENS;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).PARMA3_MENS;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).CLASE_SERVICIO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).DES_MONEDA;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_MONEDA;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_CICLO;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).FACT_CONT;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).VAL_MIN;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).VAL_MAX;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).P_DESC;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).COD_ERROR;
                         Lv_SqlFinal := Lv_SqlFinal || ', '|| tab_parametros(LN_INDICE).DES_ERROR;



                 Lv_SqlFinal := Lv_SqlFinal || ') ';

                     INSERT INTO PV_TMPPARAMETROS_SALIDA_TT
                               (
                                  NUM_MOVIMIENTO
                                                 ,COD_ACTABO
                                                 ,IND_FACTUR
                                                 ,DES_SERV
                                                 ,NUM_UNIDADES
                                                 ,COD_CONCEPTO
                                                 ,IMP_CARGO
                                                 ,COD_ARTICULO
                                                 ,COD_BODEGA
                                                 ,NUM_SERIE
                                                 ,IND_EQUIPO
                                                 ,COD_CLIENTE
                                                 ,NUM_ABONADO
                                                 ,TIP_DTO
                                                 ,VAL_DTO
                                                 ,COD_CONCEPTO_DTO
                                                 ,NUM_CELULAR
                                                 ,COD_PLANCOM
                                                 ,CLASE_SERVICIO_ACT
                                                 ,CLASE_SERVICIO_DES
                                                 ,PARAM1_MENS
                                                 ,PARAM2_MENS
                                                 ,PARMA3_MENS
                                                 ,CLASE_SERVICIO
                                                 ,DES_MONEDA
                                                 ,COD_MONEDA
                                                 ,COD_CICLO
                                                 ,FACT_CONT
                                                 ,VAL_MAX
                                                 ,VAL_MIN
                                                 ,P_DESC
                                                 ,COD_ERROR
                                                 ,DES_ERROR
                                   )
                       VALUES
                              (
                                  tab_parametros(LN_INDICE).NUM_MOVIMIENTO
                                                 ,tab_parametros(LN_INDICE).COD_ACTABO
                                                 ,tab_parametros(LN_INDICE).IND_FACTUR
                                                 ,tab_parametros(LN_INDICE).DES_SERV
                                                 ,tab_parametros(LN_INDICE).NUM_UNIDADES
                                                 ,tab_parametros(LN_INDICE).COD_CONCEPTO
                                                 ,tab_parametros(LN_INDICE).IMP_CARGO
                                                 ,tab_parametros(LN_INDICE).COD_ARTICULO
                                                 ,tab_parametros(LN_INDICE).COD_BODEGA
                                                 ,tab_parametros(LN_INDICE).NUM_SERIE
                                                 ,tab_parametros(LN_INDICE).IND_EQUIPO
                                                 ,tab_parametros(LN_INDICE).COD_CLIENTE
                                                 ,tab_parametros(LN_INDICE).NUM_ABONADO
                                                 ,tab_parametros(LN_INDICE).TIP_DTO
                                                 ,tab_parametros(LN_INDICE).VAL_DTO
                                                 ,tab_parametros(LN_INDICE).COD_CONCEPTO_DTO
                                                 ,tab_parametros(LN_INDICE).NUM_CELULAR
                                                 ,tab_parametros(LN_INDICE).COD_PLANCOM
                                                 ,tab_parametros(LN_INDICE).CLASE_SERVICIO_ACT
                                                 ,tab_parametros(LN_INDICE).CLASE_SERVICIO_DES
                                                 ,tab_parametros(LN_INDICE).PARAM1_MENS
                                                 ,tab_parametros(LN_INDICE).PARAM2_MENS
                                                 ,tab_parametros(LN_INDICE).PARMA3_MENS
                                                 ,tab_parametros(LN_INDICE).CLASE_SERVICIO
                                                 ,tab_parametros(LN_INDICE).DES_MONEDA
                                                 ,tab_parametros(LN_INDICE).COD_MONEDA
                                                 ,tab_parametros(LN_INDICE).COD_CICLO
                                                 ,tab_parametros(LN_INDICE).FACT_CONT
                                                 ,tab_parametros(LN_INDICE).VAL_MIN
                                                 ,tab_parametros(LN_INDICE).VAL_MAX
                                                 ,tab_parametros(LN_INDICE).P_DESC
                                                 ,tab_parametros(LN_INDICE).COD_ERROR
                                                 ,tab_parametros(LN_INDICE).DES_ERROR

                               );

                                           LN_INDICE := LN_INDICE + 1;


                        END LOOP;
        END IF;
EXCEPTION
       WHEN OTHERS THEN
             SV_RETORNO :='4';
                     SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
       BEGIN
             IF Lv_n_num_evento = -1 THEN
                Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en INSERCIÓN PV_TMPPARAMETROS_SALIDA_TT ','1',USER,'PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
             ELSE
                Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en INSERCIÓN PV_TMPPARAMETROS_SALIDA_TT','1',USER,'PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
             END IF;
       END;

END PV_INS_TMPPARAMETROS_SALIDA_PR;


PROCEDURE PV_CARGO_MAESTRO_OCASIONAL_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EN_COD_OS        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 )
/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_MAESTRO_OCASIONAL_PR"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_COD_PRODUCTO  "   Tipo="NUMERICO">producto</param>
                        <param nom="EN_COD_ACTABO    "   Tipo="varchar2">CODIGO ACTUACION </param>
                        <param nom="EN_COD_PLANSERV  "   Tipo="VARCHAR2">CODIGO PLAN SERVICIO</param>
                        <param nom="EN_TIP_SERVICIO  "   Tipo="NUMERICO">TIPO SERVICIO</param>
                        <param nom="EN_COD_CLIENTE   "   Tipo="NUMERICO">CODIGO CLIENTE</param>
                        <param nom="EN_NUM_ABONADO   "   Tipo="NUMERICO">NUM_ABONADO</param>
                        <param nom="EN_COD_PLANCOM   "   Tipo="NUMERICO">COD_PLAN COMERCIAL</param>
                        <param nom="EN_NUM_CELULAR   "   Tipo="NUMERICO">NUM_CELULAR</param>
                        <param nom="EN_COD_OS        "   Tipo="VARCHAR2">CODIGO OOSS</param>

                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    Lv_SqlFinal         VARCHAR2(5000);
    LV_COD_ACTUACION    VARCHAR2(2);

        CURSOR  CUR_ACTUAC IS
        SELECT A.COD_ACTUACION
    FROM  PV_OOSS_ACTUACION_TD A
    WHERE A.COD_OS    = EN_COD_OS AND
              A.FLG_ESTADO= 'TRUE';





BEGIN

     IF SV_RETORNO='0' THEN
                     Lv_SqlFinal :='SELECT A.COD_ACTUACION  FROM  PV_OOSS_ACTUACION_TD A';
             Lv_SqlFinal := Lv_SqlFinal || ' WHERE A.COD_OS    = '|| EN_COD_OS ;
                 Lv_SqlFinal := Lv_SqlFinal || ' AND A.FLG_ESTADO= TRUE';
                 dbms_output.put_line('PV_CARGO_MAESTRO_OCASIONAL_PR - Lv_SqlFinal :'||Lv_SqlFinal);

                     SV_RETORNO :='0';
                         SV_GLOSA   :='';
           --  ind_parametros:=0;
                     OPEN CUR_ACTUAC  ;
                     LOOP
                       FETCH CUR_ACTUAC   INTO LV_COD_ACTUACION;
                           EXIT WHEN CUR_ACTUAC %NOTFOUND;
                           IF SV_RETORNO ='0' THEN

                              Lv_SqlFinal :='PV_COBRAR_PG.PV_CARGO_OCASIONAL_PR('||EN_COD_PRODUCTO||','||LV_COD_ACTUACION||','||EN_COD_PLANSERV||','||EN_TIP_SERVICIO||','||EN_COD_CLIENTE||','||EN_NUM_ABONADO||','||EN_COD_PLANCOM||','||EN_NUM_CELULAR||','||SV_RETORNO||','||SV_GLOSA||')';
                          PV_COBRAR_PG.PV_CARGO_OCASIONAL_PR(EN_COD_PRODUCTO,LV_COD_ACTUACION,EN_COD_PLANSERV,EN_TIP_SERVICIO,EN_COD_CLIENTE,EN_NUM_ABONADO,
                                                                             EN_COD_PLANCOM,EN_NUM_CELULAR,EV_COD_OPERA,EV_TIP_CONT,EN_MES,EV_COD_ANT,EV_ESTADO_EQ,EV_COD_CNUE,EV_MESNUE,EN_COD_ARTI,EV_COD_CAUSA,
                                                                                                         EV_COD_CAUSA_NUE,EV_COD_CATEG,EN_COD_MODVTA,EN_COD_VENDE,EN_TIP_ABONADO,SV_RETORNO,SV_GLOSA);
dbms_output.put_line(Lv_SqlFinal);
                                                                                                         
                                                                                                         
                           END IF;
                     END LOOP;
                     CLOSE CUR_ACTUAC ;


         END IF;
dbms_output.put_line('PV_CARGO_MAESTRO_OCASIONAL_PR - SV_GLOSA :'||SV_GLOSA);                                  
EXCEPTION

   WHEN NO_DATA_FOUND THEN
       BEGIN
             SV_RETORNO :='0';
                         SV_GLOSA   :='OK';
dbms_output.put_line('PV_CARGO_MAESTRO_OCASIONAL_PR - SV_GLOSA :'||SV_GLOSA);                         
       END;
   WHEN OTHERS THEN
       BEGIN
                         SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_MAESTRO_OCASIONAL_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                     tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                          ind_parametros := ind_parametros + 1;
                         PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA )  ;

             SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
                         dbms_output.put_line('PV_CARGO_MAESTRO_OCASIONAL_PR - SV_GLOSA :'||SV_GLOSA);
             IF Lv_n_num_evento = -1 THEN
                Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CUR_ACTUAC ','1',USER,'PV_COBRAR_PG.PV_CARGO_MAESTRO_OCASIONAL_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
             ELSE
                Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CUR_ACTUAC ','1',USER,'PV_COBRAR_PG.PV_CARGO_MAESTRO_OCASIONAL_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
             END IF;
       END;
END PV_CARGO_MAESTRO_OCASIONAL_PR;



PROCEDURE
PV_CARGO_MAESTRO_SEG_PR(
                          EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EN_COD_OS        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EN_COD_PLANTARIFANT   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_ANT%TYPE,
                                                 EN_COD_PLANTARIFNUE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_NUE%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 )
/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_MAESTRO_OCASIONAL_PR"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_COD_PRODUCTO  "   Tipo="NUMERICO">producto</param>
                        <param nom="EN_COD_ACTABO    "   Tipo="varchar2">CODIGO ACTUACION </param>
                        <param nom="EN_COD_PLANSERV  "   Tipo="VARCHAR2">CODIGO PLAN SERVICIO</param>
                        <param nom="EN_TIP_SERVICIO  "   Tipo="NUMERICO">TIPO SERVICIO</param>
                        <param nom="EN_COD_CLIENTE   "   Tipo="NUMERICO">CODIGO CLIENTE</param>
                        <param nom="EN_NUM_ABONADO   "   Tipo="NUMERICO">NUM_ABONADO</param>
                        <param nom="EN_COD_PLANCOM   "   Tipo="NUMERICO">COD_PLAN COMERCIAL</param>
                        <param nom="EN_NUM_CELULAR   "   Tipo="NUMERICO">NUM_CELULAR</param>
                        <param nom="EN_COD_OS        "   Tipo="VARCHAR2">CODIGO OOSS</param>

                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    Lv_SqlFinal         VARCHAR2(5000);
    LV_COD_ACTUACION    VARCHAR2(2);

        CURSOR  CUR_ACTUAC IS
        SELECT A.COD_ACTUACION
    FROM  PV_OOSS_ACTUACION_TD A
    WHERE A.COD_OS    = EN_COD_OS AND
              A.FLG_ESTADO= 'TRUE';




BEGIN

     IF SV_RETORNO='0' THEN
                     Lv_SqlFinal :='SELECT A.COD_ACTUACION  FROM  PV_OOSS_ACTUACION_TD A';
             Lv_SqlFinal := Lv_SqlFinal || ' WHERE A.COD_OS    = '|| EN_COD_OS ;
                 Lv_SqlFinal := Lv_SqlFinal || ' AND A.FLG_ESTADO= TRUE';

                     SV_RETORNO :='0';
                         SV_GLOSA   :='';
           --  ind_parametros:=0;
                     OPEN CUR_ACTUAC  ;
                     LOOP
                       FETCH CUR_ACTUAC   INTO LV_COD_ACTUACION;
                           EXIT WHEN CUR_ACTUAC %NOTFOUND;
                           IF SV_RETORNO ='0' THEN

                              Lv_SqlFinal :='PV_COBRAR_PG.PV_CARGO_SEGMENTACION_PR('||EN_COD_PRODUCTO||','||LV_COD_ACTUACION||','||EN_COD_PLANSERV||','||EN_TIP_SERVICIO||','||EN_COD_CLIENTE||','||EN_NUM_ABONADO||','||EN_COD_PLANCOM||','||EN_NUM_CELULAR||','||SV_RETORNO||','||SV_GLOSA||')';
                          PV_COBRAR_PG.PV_CARGO_SEGMENTACION_PR(EN_COD_PRODUCTO,LV_COD_ACTUACION,EN_COD_PLANSERV,EN_TIP_SERVICIO,EN_COD_CLIENTE,EN_NUM_ABONADO,
                                                                             EN_COD_PLANCOM,EN_NUM_CELULAR,EV_COD_OPERA,EV_TIP_CONT,EN_MES,EV_COD_ANT,EV_ESTADO_EQ,EV_COD_CNUE,EV_MESNUE,EN_COD_ARTI,EV_COD_CAUSA,
                                                                                                         EV_COD_CAUSA_NUE,EV_COD_CATEG,EN_COD_MODVTA,EN_COD_VENDE,EN_TIP_ABONADO,EN_COD_PLANTARIFANT ,EN_COD_PLANTARIFNUE,SV_RETORNO,SV_GLOSA);
dbms_output.put_line('PV_CARGO_MAESTRO_SEG_PR - Lv_SqlFinal :'||Lv_SqlFinal);
                           END IF;
                     END LOOP;
                     CLOSE CUR_ACTUAC ;


         END IF;
EXCEPTION

   WHEN NO_DATA_FOUND THEN
       BEGIN
             SV_RETORNO :='0';
                         SV_GLOSA   :='OK';
       END;
   WHEN OTHERS THEN
       BEGIN
                         SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_MAESTRO_SEG_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                     tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                          ind_parametros := ind_parametros + 1;
                         PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA )  ;

             SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
dbms_output.put_line('PV_CARGO_MAESTRO_SEG_PR - SV_GLOSA :'||SV_GLOSA);                         
             IF Lv_n_num_evento = -1 THEN
                Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CUR_ACTUAC ','1',USER,'PV_COBRAR_PG.PV_CARGO_MAESTRO_SEG_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
             ELSE
                Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CUR_ACTUAC ','1',USER,'PV_COBRAR_PG.PV_CARGO_MAESTRO_SEG_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
             END IF;
       END;
END PV_CARGO_MAESTRO_SEG_PR;




PROCEDURE PV_CARGO_OCASIONAL_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 )
/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_OCASIONAL_PR"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_COD_PRODUCTO  "   Tipo="NUMERICO">producto</param>
                        <param nom="EN_COD_ACTABO    "   Tipo="varchar2">CODIGO ACTUACION </param>
                        <param nom="EN_COD_PLANSERV  "   Tipo="VARCHAR2">CODIGO PLAN SERVICIO</param>
                        <param nom="EN_TIP_SERVICIO  "   Tipo="NUMERICO">TIPO SERVICIO</param>
                        <param nom="EN_COD_CLIENTE   "   Tipo="NUMERICO">CODIGO CLIENTE</param>
                        <param nom="EN_NUM_ABONADO   "   Tipo="NUMERICO">NUM_ABONADO</param>
                        <param nom="EN_COD_PLANCOM   "   Tipo="NUMERICO">COD_PLAN COMERCIAL</param>
                        <param nom="EN_NUM_CELULAR   "   Tipo="NUMERICO">NUM_CELULAR</param>
                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    Lv_SqlFinal         VARCHAR2(5000);
        LV_COD_PLANSERV         VARCHAR2(3);


        CURSOR  CARGO_OCASIONAL IS
        SELECT C.IND_AUTMAN, C.DES_SERVICIO, '1'           ,
               B.IMP_TARIFA, D.DES_MONEDA  , A.COD_CONCEPTO, B.COD_MONEDA
    FROM  GA_ACTUASERV A, GA_TARIFAS B,
              GA_SERVICIOS C,GE_MONEDAS D
    WHERE A.COD_PRODUCTO = EN_COD_PRODUCTO
    AND A.COD_ACTABO     = EN_COD_ACTABO
    AND A.COD_TIPSERV    = EN_TIP_SERVICIO
    AND B.COD_PRODUCTO   = A.COD_PRODUCTO
    AND B.COD_ACTABO     = A.COD_ACTABO
    AND B.COD_TIPSERV    = A.COD_TIPSERV
    AND B.COD_SERVICIO   = A.COD_SERVICIO
    AND TO_NUMBER(TRIM(B.COD_PLANSERV))   = TO_NUMBER(TRIM(LV_COD_PLANSERV))
    AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
    AND C.COD_PRODUCTO   = A.COD_PRODUCTO
    AND C.COD_SERVICIO   = A.COD_SERVICIO
    AND D.COD_MONEDA     = B.COD_MONEDA;


BEGIN

     LV_COD_PLANSERV    :=EN_COD_PLANSERV;
     dbms_output.put_line('PV_CARGO_OCASIONAL_PR - SV_RETORNO :'||SV_RETORNO);                         
     IF SV_RETORNO='0' THEN
        dbms_output.put_line('1.-PV_COBRAR_PG.PV_CARGO_OCASIONAL_PR');
                     Lv_SqlFinal :='SELECT C.IND_AUTMAN, C.DES_SERVICIO, 1 ,';
                         Lv_SqlFinal :=Lv_SqlFinal || 'B.IMP_TARIFA, D.DES_MONEDA  , A.COD_CONCEPTO, B.COD_MONEDA';
                     Lv_SqlFinal :=Lv_SqlFinal || 'FROM  GA_ACTUASERV A, GA_TARIFAS B,GA_SERVICIOS C, GE_MONEDAS D';
                     Lv_SqlFinal :=Lv_SqlFinal || 'WHERE A.COD_PRODUCTO = '||EN_COD_PRODUCTO;
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_ACTABO     = '||EN_COD_ACTABO;
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_TIPSERV    = '||EN_TIP_SERVICIO;
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_PRODUCTO   = A.COD_PRODUCTO';
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_ACTABO     = A.COD_ACTABO';
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_TIPSERV    = A.COD_TIPSERV';
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_SERVICIO   = A.COD_SERVICIO';
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_PLANSERV   = '||LV_COD_PLANSERV;
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)';
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND C.COD_PRODUCTO   = A.COD_PRODUCTO';
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND C.COD_SERVICIO   = A.COD_SERVICIO';
                     Lv_SqlFinal :=Lv_SqlFinal || 'AND D.COD_MONEDA     = B.COD_MONEDA';

                     SV_RETORNO :='0';
                         SV_GLOSA   :='';

                     OPEN CARGO_OCASIONAL ;
                     LOOP
                       FETCH CARGO_OCASIONAL INTO GV_IND_FACTUR, GV_DES_SERV  ,GN_NUM_UNIDADES,
                                                      GN_IMP_CARGO , GV_DES_MONEDA,GN_COD_CONCEPTO,
                                                                                  GV_COD_MONEDA;
                           EXIT WHEN CARGO_OCASIONAL%NOTFOUND;

                           SELECT PV_SEQ_NUMOS.NEXTVAL INTO GN_NUM_MOVIMIENTO FROM   DUAL;

                           tab_parametros(ind_parametros).NUM_MOVIMIENTO     := GN_NUM_MOVIMIENTO;
                       tab_parametros(ind_parametros).IND_FACTUR         := GV_IND_FACTUR;
                       tab_parametros(ind_parametros).DES_SERV           := GV_DES_SERV ;
                       tab_parametros(ind_parametros).NUM_UNIDADES       := GN_NUM_UNIDADES;
                           tab_parametros(ind_parametros).IMP_CARGO          := GN_IMP_CARGO;
                           tab_parametros(ind_parametros).COD_CONCEPTO       := GN_COD_CONCEPTO;
                           tab_parametros(ind_parametros).COD_MONEDA         := GV_COD_MONEDA;
                           tab_parametros(ind_parametros).DES_MONEDA         := GV_DES_MONEDA;
                           tab_parametros(ind_parametros).COD_ACTABO         := EN_COD_ACTABO;
                           tab_parametros(ind_parametros).COD_CLIENTE        := EN_COD_CLIENTE;
                           tab_parametros(ind_parametros).NUM_ABONADO        := EN_NUM_ABONADO;
                           tab_parametros(ind_parametros).NUM_CELULAR        := EN_NUM_CELULAR;
                           tab_parametros(ind_parametros).COD_PLANCOM        := EN_COD_PLANCOM;

                           tab_parametros(ind_parametros).COD_ARTICULO       := NULL;
                           tab_parametros(ind_parametros).COD_BODEGA         := NULL;
                           tab_parametros(ind_parametros).NUM_SERIE          := NULL;
                           tab_parametros(ind_parametros).IND_EQUIPO         := NULL;
                           tab_parametros(ind_parametros).TIP_DTO            := NULL;
                           tab_parametros(ind_parametros).VAL_DTO            := NULL;
                           tab_parametros(ind_parametros).COD_CONCEPTO_DTO   := NULL;
                           tab_parametros(ind_parametros).CLASE_SERVICIO_ACT := NULL;
                           tab_parametros(ind_parametros).CLASE_SERVICIO_DES := NULL;
                           tab_parametros(ind_parametros).PARAM1_MENS        := NULL;
                           tab_parametros(ind_parametros).PARAM2_MENS        := NULL;
                           tab_parametros(ind_parametros).PARMA3_MENS        := NULL;
                           tab_parametros(ind_parametros).CLASE_SERVICIO     := NULL;
                           tab_parametros(ind_parametros).COD_CICLO          := NULL;
                           tab_parametros(ind_parametros).FACT_CONT          := 1;
                           tab_parametros(ind_parametros).VAL_MIN            := NULL;
                           tab_parametros(ind_parametros).VAL_MAX            := NULL;
                           tab_parametros(ind_parametros).P_DESC             := 1;
                           tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                           tab_parametros(ind_parametros).DES_ERROR          :='OK';



                       ind_parametros := ind_parametros + 1;

                           -- LLAMA FUNCIÓN DE DESCUENTOS POR CONSTRUIR --
dbms_output.put_line('3.-PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR');
                           PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR(
                                                EV_COD_OPERA,EV_TIP_CONT,EN_MES,EV_COD_ANT,EV_ESTADO_EQ,EV_COD_CNUE,EV_MESNUE,EN_COD_ARTI,EV_COD_CAUSA,
                                               EV_COD_CAUSA_NUE,EV_COD_CATEG,EN_COD_MODVTA,EN_COD_CLIENTE,EN_COD_VENDE,EN_TIP_ABONADO,SV_RETORNO,SV_GLOSA);

                     END LOOP;
                     CLOSE CARGO_OCASIONAL;
         END IF;
EXCEPTION

   WHEN NO_DATA_FOUND THEN
       BEGIN
             SV_RETORNO :='0';
                         SV_GLOSA   :='OK';
       END;
      WHEN OTHERS THEN
       BEGIN

                 SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_OCASIONAL_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                      tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                         ind_parametros := ind_parametros + 1;
                         PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );
                         dbms_output.put_line(SV_GLOSA);

             SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
dbms_output.put_line('PV_CARGO_OCASIONAL_PR - SV_GLOSA :'||SV_GLOSA);                         
             IF Lv_n_num_evento = -1 THEN
                Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CARGO_OCASIONAL','1',USER,'PV_COBRAR_PG.PV_CARGO_OCASIONAL_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
             ELSE
                Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CARGO_OCASIONAL','1',USER,'PV_COBRAR_PG.PV_CARGO_OCASIONAL_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
             END IF;
       END;
END PV_CARGO_OCASIONAL_PR;





PROCEDURE PV_CARGO_OCASIONALTRASPP_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EN_COD_OS        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EN_TIP_PANTALLA  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_PANTALLA%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 )
/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_OCASIONALTRASPP_PR"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_COD_PRODUCTO  "   Tipo="NUMERICO">producto</param>
                        <param nom="EN_COD_ACTABO    "   Tipo="varchar2">CODIGO ACTUACION </param>
                        <param nom="EN_COD_PLANSERV  "   Tipo="VARCHAR2">CODIGO PLAN SERVICIO</param>
                        <param nom="EN_TIP_SERVICIO  "   Tipo="NUMERICO">TIPO SERVICIO</param>
                        <param nom="EN_COD_CLIENTE   "   Tipo="NUMERICO">CODIGO CLIENTE</param>
                        <param nom="EN_NUM_ABONADO   "   Tipo="NUMERICO">NUM_ABONADO</param>
                        <param nom="EN_COD_PLANCOM   "   Tipo="NUMERICO">COD_PLAN COMERCIAL</param>
                        <param nom="EN_NUM_CELULAR   "   Tipo="NUMERICO">NUM_CELULAR</param>
                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    Lv_SqlFinal         VARCHAR2(5000);
    LV_COD_PLANSERV     VARCHAR2(3);
    LV_CONCEPTO_AUX     GA_ACTUASERV.COD_CONCEPTO%TYPE;
    LV_CONCEPTO_AUX2    GA_ACTUASERV.COD_CONCEPTO%TYPE;
    LV_VAL_AUX          GA_TARIFAS.IMP_TARIFA%TYPE;  

    CURSOR  CARGO_OCASIONAL IS
    SELECT  
    C.IND_AUTMAN, C.DES_SERVICIO, '1', B.IMP_TARIFA, D.DES_MONEDA,
    A.COD_CONCEPTO, B.COD_MONEDA
    FROM  GA_ACTUASERV A, GA_TARIFAS B, GA_SERVICIOS C,GE_MONEDAS D 
    WHERE A.COD_PRODUCTO = EN_COD_PRODUCTO
    AND A.COD_ACTABO = EN_COD_ACTABO
    AND A.COD_TIPSERV = EN_TIP_SERVICIO
    AND A.COD_CONCEPTO = LV_CONCEPTO_AUX  
    AND B.COD_PRODUCTO = A.COD_PRODUCTO
    AND B.COD_ACTABO = A.COD_ACTABO
    AND B.COD_TIPSERV = A.COD_TIPSERV
    AND B.COD_SERVICIO = A.COD_SERVICIO
    AND TO_NUMBER(TRIM(B.COD_PLANSERV)) = TO_NUMBER(TRIM(LV_COD_PLANSERV))
    AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
    AND C.COD_PRODUCTO = A.COD_PRODUCTO
    AND C.COD_SERVICIO = A.COD_SERVICIO
    AND D.COD_MONEDA = B.COD_MONEDA;
    
    
    
    /*CURSOR  CARGO_OCASIONAL1 IS
    SELECT  
    C.IND_AUTMAN, C.DES_SERVICIO, '1', LV_VAL_AUX , D.DES_MONEDA,
    A.COD_CONCEPTO, B.COD_MONEDA
    FROM  GA_ACTUASERV A, GA_TARIFAS B, GA_SERVICIOS C,GE_MONEDAS D 
    WHERE A.COD_PRODUCTO = EN_COD_PRODUCTO
    AND A.COD_ACTABO = EN_COD_ACTABO
    AND A.COD_TIPSERV =  EN_TIP_SERVICIO
    AND A.COD_CONCEPTO = LV_CONCEPTO_AUX2 
    AND B.COD_PRODUCTO = A.COD_PRODUCTO
    AND B.COD_ACTABO = A.COD_ACTABO
    AND B.COD_TIPSERV = A.COD_TIPSERV
    AND B.COD_SERVICIO = A.COD_SERVICIO
    AND TO_NUMBER(TRIM(B.COD_PLANSERV)) = TO_NUMBER(TRIM(LV_COD_PLANSERV))
    AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
    AND C.COD_PRODUCTO = A.COD_PRODUCTO
    AND C.COD_SERVICIO = A.COD_SERVICIO
    AND D.COD_MONEDA = B.COD_MONEDA;
    */


BEGIN


      
     
     LV_COD_PLANSERV    :=EN_COD_PLANSERV;
     SELECT TO_NUMBER(TRIM(VAL_PARAMETRO))
     INTO  LV_CONCEPTO_AUX
     FROM ged_parametros
     WHERE cod_modulo    = 'GA'
     AND cod_producto  = 1
     AND nom_parametro ='CONC_PREPAGO';
              
     
     /*SELECT TO_NUMBER(TRIM(VAL_PARAMETRO))
     INTO  LV_CONCEPTO_AUX2
     FROM ged_parametros
     WHERE cod_modulo    = 'GA'
     AND cod_producto  = 1
     AND nom_parametro ='CONC_PREPAGO_HIBRIDO';
     */
     
             
     
     
     
     dbms_output.put_line('PV_CARGO_OCASIONALTRASPP_PR - SV_RETORNO :'||SV_RETORNO);                         
     IF SV_RETORNO='0' THEN
                     
                    Lv_SqlFinal :=Lv_SqlFinal || ' SELECT'; 
                    Lv_SqlFinal :=Lv_SqlFinal || 'C.IND_AUTMAN, C.DES_SERVICIO, 1, B.IMP_TARIFA, D.DES_MONEDA,';
                    Lv_SqlFinal :=Lv_SqlFinal || 'A.COD_CONCEPTO, B.COD_MONEDA';
                    Lv_SqlFinal :=Lv_SqlFinal || 'FROM  GA_ACTUASERV A, GA_TARIFAS B, GA_SERVICIOS C,GE_MONEDAS D'; 
                    Lv_SqlFinal :=Lv_SqlFinal || 'WHERE A.COD_PRODUCTO = '||EN_COD_PRODUCTO;
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_ACTABO = '||EN_COD_ACTABO;
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_TIPSERV = '||EN_TIP_SERVICIO;
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_CONCEPTO = '||LV_CONCEPTO_AUX;  
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_PRODUCTO = A.COD_PRODUCTO';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_ACTABO = A.COD_ACTABO';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_TIPSERV = A.COD_TIPSERV';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_SERVICIO = A.COD_SERVICIO';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND TO_NUMBER(TRIM(B.COD_PLANSERV)) = '||'TO_NUMBER(TRIM('||LV_COD_PLANSERV||'))';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND C.COD_PRODUCTO = A.COD_PRODUCTO';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND C.COD_SERVICIO = A.COD_SERVICIO';
                    Lv_SqlFinal :=Lv_SqlFinal || 'AND D.COD_MONEDA = B.COD_MONEDA';

                     SV_RETORNO :='0';
                     SV_GLOSA   :='';
                     
     
                     
                     IF  EN_TIP_PANTALLA= 28 OR EN_TIP_PANTALLA= 29 THEN

                                 OPEN CARGO_OCASIONAL ;
                                 LOOP
                                   FETCH CARGO_OCASIONAL INTO GV_IND_FACTUR, GV_DES_SERV  ,GN_NUM_UNIDADES,
                                                                  GN_IMP_CARGO , GV_DES_MONEDA,GN_COD_CONCEPTO,
                                                                                              GV_COD_MONEDA;
                                       EXIT WHEN CARGO_OCASIONAL%NOTFOUND;

                                       SELECT PV_SEQ_NUMOS.NEXTVAL INTO GN_NUM_MOVIMIENTO FROM   DUAL;

                                       tab_parametros(ind_parametros).NUM_MOVIMIENTO     := GN_NUM_MOVIMIENTO;
                                       tab_parametros(ind_parametros).IND_FACTUR         := GV_IND_FACTUR;
                                       tab_parametros(ind_parametros).DES_SERV           := GV_DES_SERV ;
                                       tab_parametros(ind_parametros).NUM_UNIDADES       := GN_NUM_UNIDADES;
                                       tab_parametros(ind_parametros).IMP_CARGO          := GN_IMP_CARGO;
                                       tab_parametros(ind_parametros).COD_CONCEPTO       := GN_COD_CONCEPTO;
                                       tab_parametros(ind_parametros).COD_MONEDA         := GV_COD_MONEDA;
                                       tab_parametros(ind_parametros).DES_MONEDA         := GV_DES_MONEDA;
                                       tab_parametros(ind_parametros).COD_ACTABO         := EN_COD_ACTABO;
                                       tab_parametros(ind_parametros).COD_CLIENTE        := EN_COD_CLIENTE;
                                       tab_parametros(ind_parametros).NUM_ABONADO        := EN_NUM_ABONADO;
                                       tab_parametros(ind_parametros).NUM_CELULAR        := EN_NUM_CELULAR;
                                       tab_parametros(ind_parametros).COD_PLANCOM        := EN_COD_PLANCOM;

                                       tab_parametros(ind_parametros).COD_ARTICULO       := NULL;
                                       tab_parametros(ind_parametros).COD_BODEGA         := NULL;
                                       tab_parametros(ind_parametros).NUM_SERIE          := NULL;
                                       tab_parametros(ind_parametros).IND_EQUIPO         := NULL;
                                       tab_parametros(ind_parametros).TIP_DTO            := NULL;
                                       tab_parametros(ind_parametros).VAL_DTO            := NULL;
                                       tab_parametros(ind_parametros).COD_CONCEPTO_DTO   := NULL;
                                       tab_parametros(ind_parametros).CLASE_SERVICIO_ACT := NULL;
                                       tab_parametros(ind_parametros).CLASE_SERVICIO_DES := NULL;
                                       tab_parametros(ind_parametros).PARAM1_MENS        := NULL;
                                       tab_parametros(ind_parametros).PARAM2_MENS        := NULL;
                                       tab_parametros(ind_parametros).PARMA3_MENS        := NULL;
                                       tab_parametros(ind_parametros).CLASE_SERVICIO     := NULL;
                                       tab_parametros(ind_parametros).COD_CICLO          := NULL;
                                       tab_parametros(ind_parametros).FACT_CONT          := 1;
                                       tab_parametros(ind_parametros).VAL_MIN            := NULL;
                                       tab_parametros(ind_parametros).VAL_MAX            := NULL;
                                       tab_parametros(ind_parametros).P_DESC             := 1;
                                       tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                                       tab_parametros(ind_parametros).DES_ERROR          :='OK';



                                   ind_parametros := ind_parametros + 1;

                                      

                                 END LOOP;
                                 CLOSE CARGO_OCASIONAL;
                     END IF; 
                     
                     
                     
                     /*IF EN_TIP_PANTALLA= 29 THEN
                     
                        Lv_SqlFinal :=Lv_SqlFinal || ' SELECT'; 
                        Lv_SqlFinal :=Lv_SqlFinal || 'C.IND_AUTMAN, C.DES_SERVICIO, 1, LV_VAL_AUX, D.DES_MONEDA,';
                        Lv_SqlFinal :=Lv_SqlFinal || 'A.COD_CONCEPTO, B.COD_MONEDA';
                        Lv_SqlFinal :=Lv_SqlFinal || 'FROM  GA_ACTUASERV A, GA_TARIFAS B, GA_SERVICIOS C,GE_MONEDAS D'; 
                        Lv_SqlFinal :=Lv_SqlFinal || 'WHERE A.COD_PRODUCTO = '||EN_COD_PRODUCTO;
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_ACTABO = '||EN_COD_ACTABO;
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_TIPSERV = '||EN_TIP_SERVICIO;
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND A.COD_CONCEPTO = '||LV_CONCEPTO_AUX2;  
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_PRODUCTO = A.COD_PRODUCTO';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_ACTABO = A.COD_ACTABO';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_TIPSERV = A.COD_TIPSERV';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND B.COD_SERVICIO = A.COD_SERVICIO';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND TO_NUMBER(TRIM(B.COD_PLANSERV)) = '||'TO_NUMBER(TRIM('||LV_COD_PLANSERV||'))';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND C.COD_PRODUCTO = A.COD_PRODUCTO';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND C.COD_SERVICIO = A.COD_SERVICIO';
                        Lv_SqlFinal :=Lv_SqlFinal || 'AND D.COD_MONEDA = B.COD_MONEDA';
                     
                     
                     
                                 OPEN CARGO_OCASIONAL ;
                                             LOOP
                                               FETCH CARGO_OCASIONAL1 INTO GV_IND_FACTUR, GV_DES_SERV  ,GN_NUM_UNIDADES,
                                                                              GN_IMP_CARGO , GV_DES_MONEDA,GN_COD_CONCEPTO,
                                                                                                          GV_COD_MONEDA;
                                                   EXIT WHEN CARGO_OCASIONAL1%NOTFOUND;

                                                   SELECT PV_SEQ_NUMOS.NEXTVAL INTO GN_NUM_MOVIMIENTO FROM   DUAL;

                                                   tab_parametros(ind_parametros).NUM_MOVIMIENTO     := GN_NUM_MOVIMIENTO;
                                                   tab_parametros(ind_parametros).IND_FACTUR         := GV_IND_FACTUR;
                                                   tab_parametros(ind_parametros).DES_SERV           := GV_DES_SERV ;
                                                   tab_parametros(ind_parametros).NUM_UNIDADES       := GN_NUM_UNIDADES;
                                                   tab_parametros(ind_parametros).IMP_CARGO          := GN_IMP_CARGO;
                                                   tab_parametros(ind_parametros).COD_CONCEPTO       := GN_COD_CONCEPTO;
                                                   tab_parametros(ind_parametros).COD_MONEDA         := GV_COD_MONEDA;
                                                   tab_parametros(ind_parametros).DES_MONEDA         := GV_DES_MONEDA;
                                                   tab_parametros(ind_parametros).COD_ACTABO         := EN_COD_ACTABO;
                                                   tab_parametros(ind_parametros).COD_CLIENTE        := EN_COD_CLIENTE;
                                                   tab_parametros(ind_parametros).NUM_ABONADO        := EN_NUM_ABONADO;
                                                   tab_parametros(ind_parametros).NUM_CELULAR        := EN_NUM_CELULAR;
                                                   tab_parametros(ind_parametros).COD_PLANCOM        := EN_COD_PLANCOM;

                                                   tab_parametros(ind_parametros).COD_ARTICULO       := NULL;
                                                   tab_parametros(ind_parametros).COD_BODEGA         := NULL;
                                                   tab_parametros(ind_parametros).NUM_SERIE          := NULL;
                                                   tab_parametros(ind_parametros).IND_EQUIPO         := NULL;
                                                   tab_parametros(ind_parametros).TIP_DTO            := NULL;
                                                   tab_parametros(ind_parametros).VAL_DTO            := NULL;
                                                   tab_parametros(ind_parametros).COD_CONCEPTO_DTO   := NULL;
                                                   tab_parametros(ind_parametros).CLASE_SERVICIO_ACT := NULL;
                                                   tab_parametros(ind_parametros).CLASE_SERVICIO_DES := NULL;
                                                   tab_parametros(ind_parametros).PARAM1_MENS        := NULL;
                                                   tab_parametros(ind_parametros).PARAM2_MENS        := NULL;
                                                   tab_parametros(ind_parametros).PARMA3_MENS        := NULL;
                                                   tab_parametros(ind_parametros).CLASE_SERVICIO     := NULL;
                                                   tab_parametros(ind_parametros).COD_CICLO          := NULL;
                                                   tab_parametros(ind_parametros).FACT_CONT          := 1;
                                                   tab_parametros(ind_parametros).VAL_MIN            := NULL;
                                                   tab_parametros(ind_parametros).VAL_MAX            := NULL;
                                                   tab_parametros(ind_parametros).P_DESC             := 1;
                                                   tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                                                   tab_parametros(ind_parametros).DES_ERROR          :='OK';



                                               ind_parametros := ind_parametros + 1;

                                                  

                                             END LOOP;
                                             CLOSE CARGO_OCASIONAL1;
                     
                     
                     
                     END IF;   */    
         END IF;
EXCEPTION

   WHEN NO_DATA_FOUND THEN
       BEGIN
       
             SV_RETORNO :='0';
                         SV_GLOSA   :='OK';
       END;
      WHEN OTHERS THEN
       BEGIN

                         SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_OCASIONALTRASPP_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                         tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                         ind_parametros := ind_parametros + 1;
                         PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );
                         COMMIT;
                         dbms_output.put_line(SV_GLOSA);

             SV_RETORNO :='4';
             SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
            dbms_output.put_line('PV_CARGO_OCASIONALTRASPP_PR - SV_GLOSA :'||SV_GLOSA);                         
             IF Lv_n_num_evento = -1 THEN
                Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CARGO_OCASIONAL','1',USER,'PV_COBRAR_PG.PV_CARGO_OCASIONALTRASPP_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
             ELSE
                Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CARGO_OCASIONAL','1',USER,'PV_COBRAR_PG.PV_CARGO_OCASIONALTRASPP_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
             END IF;
       END;
END PV_CARGO_OCASIONALTRASPP_PR;




PROCEDURE PV_COBRO_INDEMNIZACION_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 )

/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_COBRO_INDEMNIZACION_PR"
      Lenguaje="PL/SQL"
      Fecha="24-11-2006"
      Versión="1.0"
      Diseñador="PAGC"
      Programador="PAGC"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_COD_PRODUCTO  "   Tipo="NUMERICO">producto</param>
                        <param nom="EN_COD_CAUSA     "   Tipo="varchar2">CODIGO CAUSA CAMBIO SERIE o SIMCARD </param>
                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

        LV_IndAutman    VARCHAR2(1);
        LV_Monto        VARCHAR2(255);
        LV_CodConcepto  fa_conceptos.cod_concepto%TYPE;
        LV_des_concepto fa_conceptos.des_concepto%TYPE;
        LV_cod_moneda   ge_monedas.cod_moneda%TYPE;
        LV_des_moneda   ge_monedas.des_moneda%TYPE;
        ERR_INDEM               EXCEPTION;
        Lv_SqlFinal     VARCHAR2(5000);
        LN_cantdecimalesfact INTEGER;
BEGIN

         Lv_SqlFinal := 'PV_PENALIZACION_PG.PV_INDEMNIZACION_PR';

         PV_PENALIZACION_PG.PV_INDEMNIZACION_PR(EN_NUM_ABONADO,
                                                          'GA',
                                                          LV_IndAutman,
                                                      LV_Monto,
                                                          LV_CodConcepto,
                                                          SV_RETORNO,
                                                          SV_GLOSA);

                                                          
                                                          
        IF NOT SV_RETORNO = '0' THEN
           RAISE ERR_INDEM;
        END IF;
         dbms_output.put_line('ANTES--------------LV_Monto :['||LV_Monto||']');
        IF length(LV_Monto) > 0 THEN
         dbms_output.put_line('DESPUES ---------------LV_Monto :['||LV_Monto||']');
         dbms_output.put_line('LV_IndAutman :['||LV_IndAutman||']');
         dbms_output.put_line('LV_codconcepto :['||LV_codconcepto||']');
         
         
             Lv_SqlFinal := 'SELECT TO_NUMBER(TRIM(VAL_PARAMETRO)) INTO  LN_cantdecimalesfact FROM ged_parametros';

                 SELECT TO_NUMBER(TRIM(VAL_PARAMETRO))
                 INTO  LN_cantdecimalesfact
                 FROM ged_parametros
                 WHERE cod_modulo    = 'GE'
                 AND cod_producto  = 1
                 AND nom_parametro ='NUM_DECIMAL_FACT';

                 LV_Monto := TO_CHAR(ROUND(TO_NUMBER(LV_Monto) , LN_cantdecimalesfact));

                 Lv_SqlFinal := 'SELECT FROM fa_conceptos a, ge_monedas d';

                 SELECT a.des_concepto,d.cod_moneda, d.des_moneda
                 INTO LV_des_concepto, LV_cod_moneda, LV_des_moneda
                 FROM fa_conceptos a, ge_monedas d
                 WHERE a.cod_concepto = LV_CodConcepto
                 AND d.cod_moneda = a.cod_moneda;

                 SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                 FROM   DUAL;

                 tab_parametros(ind_parametros).IND_FACTUR         := LV_indautman;
                 tab_parametros(ind_parametros).DES_SERV           := LV_des_concepto;
                 tab_parametros(ind_parametros).NUM_UNIDADES       := 1;
                 tab_parametros(ind_parametros).IMP_CARGO          := TO_NUMBER(LV_Monto);
                 tab_parametros(ind_parametros).COD_CONCEPTO       := TO_NUMBER(LV_codconcepto);
                 tab_parametros(ind_parametros).COD_MONEDA         := LV_cod_moneda;
                 tab_parametros(ind_parametros).DES_MONEDA         := LV_des_moneda;
                 tab_parametros(ind_parametros).cod_cliente        := EN_COD_CLIENTE ;
                 tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                 tab_parametros(ind_parametros).DES_ERROR          :='OK';

                 ind_parametros := ind_parametros + 1;

                 Lv_SqlFinal := 'PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR';
                
                dbms_output.put_line('1.-PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR');
                 PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR(
                                         EV_COD_OPERA,EV_TIP_CONT,EN_MES,EV_COD_ANT,EV_ESTADO_EQ,EV_COD_CNUE,EV_MESNUE,EN_COD_ARTI,EV_COD_CAUSA,
                                         EV_COD_CAUSA_NUE,EV_COD_CATEG,EN_COD_MODVTA,EN_COD_CLIENTE,EN_COD_VENDE,EN_TIP_ABONADO,SV_RETORNO,SV_GLOSA);

        ELSE
                SV_RETORNO := '0';
                SV_GLOSA := 'OK';
dbms_output.put_line('PV_COBRO_INDEMNIZACION_PR - SV_GLOSA :'||SV_GLOSA);                                         
        END IF;

EXCEPTION
                 WHEN ERR_INDEM THEN
                     SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_COBRO_INDEMNIZACION_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                     tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                          ind_parametros := ind_parametros + 1;
                         PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );
dbms_output.put_line('PV_COBRO_INDEMNIZACION_PR - SV_GLOSA :'||SV_GLOSA);
                 WHEN OTHERS THEN
                     SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_COBRO_INDEMNIZACION_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                     tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                          ind_parametros := ind_parametros + 1;
                         PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );


             SV_RETORNO :='4';
                         SV_GLOSA   := SUBSTR(SQLERRM,1, 255);
dbms_output.put_line('PV_COBRO_INDEMNIZACION_PR - SV_GLOSA :'||SV_GLOSA);                                                                  
             IF Lv_n_num_evento = -1 THEN
                Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error PV_COBRO_INDEMNIZACION_PR','1',USER,'PV_COBRAR_PG.PV_COBRO_INDEMNIZACION_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
             ELSE
                Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error PV_COBRO_INDEMNIZACION_PR','1',USER,'PV_COBRAR_PG.PV_COBRO_INDEMNIZACION_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
             END IF;

END PV_COBRO_INDEMNIZACION_PR;

PROCEDURE PV_CARGO_SEGMENTACION_PR(
                                                 EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EV_PLANTARIF_ANT IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 EV_PLANTARIF_NUE IN TA_PLANTARIF.COD_PLANTARIF%TYPE,--CALCULAR
                                                 SV_RETORNO         IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA                IN OUT NOCOPY VARCHAR2
                                                                  )

/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_SEGMENTACION_PR"
      Lenguaje="PL/SQL"
      Fecha="05-07-2007"
      Versión="1.0"
      Diseñador="Orlando Cabezas"
      Programador="Nicolás Contreras"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción>Generacion de Cargos</Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EV_SEGMENTACION_ORIGEN"   Tipo="STRING">Codigo Segmentacion Origen</param>
                        <param nom="EV_SEGMENTACION_DESTINO"  Tipo="STRING">Codigo Segmentacion Destino</param>
                        <param nom="EV_PLANTARIF_ACT"         Tipo="STRING">CODIGO PLAN TARIFARIO</param>
                        <param nom="EV_PLANTARIF_NUE"         Tipo="STRING">CODIGO PLAN TARIFARIO NUEVO</param>
                        <param nom="EV_CARBASICO_ORIG"        Tipo="NUMERICO">CODIGO CLIENTE</param>
                        <param nom="EV_CARBASICO_DEST"        Tipo="NUMERICO">NUM_ABONADO</param>
                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

           
   V_SEG_ORIGEN          VARCHAR2(2);
   Lv_SqlFinal           VARCHAR2(5000);
   LV_COD_PLANSERV       VARCHAR2(3);
   GV_TIPO_CARGO         NUMBER(1);
   GN_COD_CONCEPTO               FA_CONCEPTOS.COD_CONCEPTO%TYPE;
   EV_SEG_ORIGEN         NUMBER(1);
   EV_SEG_DESTINO        NUMBER(1);
   EV_CARGOBASICO_ORIGEN VARCHAR2(3);
   EV_CARGOBASICO_DEST   VARCHAR2(3);
   EV_IMPCARGO_ORIGEN    NUMBER(12,4);
   EV_IMPCARGO_DESTINO   NUMBER(12,4);
   EV_VALOR              VARCHAR2(5); --TRUE O FALSE
   EV_MIN                VARCHAR2(2);
   EV_DIFERENCIA         VARCHAR2(10);
   EV_COD_OPTA           VARCHAR2(5);
   EV_APLICACARGOS       VARCHAR2(5);
   AUX_COD_CLIENTE2      PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE;
   EV_TIP_SEG_ORIGEN     GA_VALOR_CLI.COD_VALOR%type;
   EV_TIP_SEG_DESTINO    GA_VALOR_CLI.COD_VALOR%type;
   flg_estado  boolean := TRUE;
   CURSOR CARGOSEGMENTACION IS

   SELECT 'A', A.DES_CONCEPTO,'1', B.IMP_CARGO,
   C.DES_MONEDA, A.COD_CONCEPTO, B.COD_MONEDA,B.TIPO_CARGO
   FROM PV_SEGMENTACION_CARGOS_TD B, GE_MONEDAS C, FA_CONCEPTOS A
   WHERE
   B.COD_SEG_ORIG  = EV_SEG_ORIGEN      AND
   B.COD_SEG_DES   = EV_SEG_DESTINO     AND
   B.COD_CONCEPTO  = A.COD_CONCEPTO     AND
   B.TIPO_SEG_ORIG = EV_TIP_SEG_ORIGEN  AND
   B.TIPO_SEG_DES  = EV_TIP_SEG_DESTINO AND
   C.COD_MONEDA = B.COD_MONEDA
   AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,TO_DATE('31-12-3000','DD-MM-YYYY'))
   ORDER BY COD_SEG_ORIG,COD_SEG_DES,TIPO_CARGO;

BEGIN

   --Se obtiene la segmentacion
   dbms_output.put_line('ENTRA :- PV_CARGO_SEGMENTACION_PR');
   dbms_output.put_line('ENTRA :- PV_CARGO_SEGMENTACION_PR EV_PLANTARIF_ANT:'||EV_PLANTARIF_ANT);
   dbms_output.put_line('ENTRA :- PV_CARGO_SEGMENTACION_PR EV_PLANTARIF_NUE:'||EV_PLANTARIF_NUE);
  BEGIN
      SELECT COD_TIPLAN,COD_CARGOBASICO
      INTO EV_SEG_ORIGEN,EV_CARGOBASICO_ORIGEN
      FROM TA_PLANTARIF
      WHERE COD_PLANTARIF=EV_PLANTARIF_ANT
      AND COD_PRODUCTO=1;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
               EV_SEG_ORIGEN:=1;
           EV_CARGOBASICO_ORIGEN:=NULL;
                   EV_IMPCARGO_ORIGEN:=0;
                   NULL;
   END;

   BEGIN
      SELECT COD_TIPLAN,COD_CARGOBASICO
      INTO  EV_SEG_DESTINO,EV_CARGOBASICO_DEST
      FROM TA_PLANTARIF
      WHERE COD_PLANTARIF=EV_PLANTARIF_NUE;

      EXCEPTION
       WHEN NO_DATA_FOUND THEN
               EV_SEG_DESTINO:=1;
                   EV_CARGOBASICO_DEST:=NULL;
                   EV_IMPCARGO_DESTINO:=0;

                   NULL;
   END;

   dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - EN_COD_ACTABO :'||EN_COD_ACTABO);
   IF EN_COD_ACTABO ='BA' THEN
           --Se obtiene Segmento origen para Cliente origen
           SELECT COD_CLIENTE
           INTO AUX_COD_CLIENTE2
           FROM GA_ABOCEL
           WHERE NUM_ABONADO =EN_NUM_ABONADO;

           SELECT COD_VALOR
           INTO EV_TIP_SEG_ORIGEN
           FROM GA_VALOR_CLI
           WHERE COD_CLIENTE= AUX_COD_CLIENTE2 ;
dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - EV_TIP_SEG_ORIGEN :'||EV_TIP_SEG_ORIGEN);


           --Una vez obtenido esto se obtiene la segmentacion destino
           SELECT COD_VALOR
           INTO  EV_TIP_SEG_DESTINO
           FROM GA_VALOR_CLI
           WHERE COD_CLIENTE= EN_COD_CLIENTE ;--destino
           dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - EV_TIP_SEG_DESTINO :'||EV_TIP_SEG_DESTINO);

   ELSE
             --Se obtiene Segmento origen para Cliente origen
           SELECT COD_CLIENTE
           INTO AUX_COD_CLIENTE2
           FROM GA_ABOCEL
           WHERE NUM_ABONADO =EN_NUM_ABONADO;

           SELECT COD_VALOR
           INTO  EV_TIP_SEG_DESTINO
           FROM GA_VALOR_CLI
           WHERE COD_CLIENTE= AUX_COD_CLIENTE2 ;--destino


           SELECT COD_VALOR
           INTO EV_TIP_SEG_ORIGEN
           FROM GA_VALOR_CLI
           WHERE COD_CLIENTE= EN_COD_CLIENTE ;


           --Una vez obtenido esto se obtiene la segmentacion destino

   END IF;


   --CARGOS BASICOS
   
      IF EV_CARGOBASICO_DEST IS NULL OR EV_CARGOBASICO_ORIGEN IS NULL THEN
         NULL; --no hago nada
      ELSE
             SELECT IMP_CARGOBASICO
             INTO EV_IMPCARGO_ORIGEN
             FROM TA_CARGOSBASICO
             WHERE COD_CARGOBASICO= EV_CARGOBASICO_ORIGEN
             AND SYSDATE BETWEEN fec_desde AND fec_hasta;
dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - EV_IMPCARGO_ORIGEN :'||EV_IMPCARGO_ORIGEN);
             
             SELECT IMP_CARGOBASICO
             INTO EV_IMPCARGO_DESTINO
             FROM TA_CARGOSBASICO
             WHERE COD_CARGOBASICO= EV_CARGOBASICO_DEST
             AND SYSDATE BETWEEN fec_desde AND fec_hasta;
             
dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - EV_IMPCARGO_DESTINO :'||EV_IMPCARGO_DESTINO);
          END IF;

        IF EV_SEG_DESTINO=1 THEN

           SELECT  ge_fn_devvalparam('GA', 1, 'MIN_OPTARAMISTAR')
           INTO EV_MIN
           FROM DUAL;

           SELECT  ge_fn_devvalparam('GA', 1, 'COD_OPTAAMISTAR')
           INTO EV_COD_OPTA
           FROM DUAL;

dbms_output.put_line('PV_CARGO_SEGMENTACION_PR -  EV_MIN:'||EV_MIN);           
       SELECT trunc((sysdate - (ADD_MONTHS(FEC_ACEPVENTA,EV_MIN))))
       INTO EV_DIFERENCIA
       FROM GA_ABOCEL
       WHERE NUM_ABONADO = EN_NUM_ABONADO;
dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - EV_DIFERENCIA :'||EV_DIFERENCIA);           
       IF EV_DIFERENCIA <> 0 THEN
          If (EV_DIFERENCIA > 0) AND ( EV_COD_CAUSA= EV_COD_OPTA) Then
             EV_APLICACARGOS := 'TRUE';
          Else
             EV_APLICACARGOS := 'FALSE';  --no cumple permanencia ->> se debe aplicar cargo
          End If;
       End If;
   ELSE
      EV_APLICACARGOS:='TRUE';
   END IF;

   dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - EV_APLICACARGOS :'||EV_APLICACARGOS);           
   SV_RETORNO :='0';
   SV_GLOSA   :='';
     OPEN CARGOSEGMENTACION ;
                     LOOP
                           flg_estado:= TRUE;
                       FETCH CARGOSEGMENTACION INTO GV_IND_FACTUR, GV_DES_SERV  ,GN_NUM_UNIDADES,
                                                      GN_IMP_CARGO , GV_DES_MONEDA,GN_COD_CONCEPTO,
                                                                                  GV_COD_MONEDA,GV_TIPO_CARGO;
                           EXIT WHEN CARGOSEGMENTACION%NOTFOUND;


                           --AQUI SE TOMA DECISION

                           /*

                           IF EV_IMPCARGO_DESTINO < EV_IMPCARGO_ORIGEN THEN
                              EV_VALOR:='TRUE';
                           ELSE
                              EV_VALOR:='FALSE';
                           END IF;

                                */

                           IF (EV_APLICACARGOS='TRUE' AND GV_TIPO_CARGO=4) THEN --OR (EV_VALOR='FALSE' AND GV_TIPO_CARGO=3)  THEN
                                SV_RETORNO :='0';
                                        SV_GLOSA   :='OK';
                                                    flg_estado:= FALSE;
                       ELSE
                              IF GV_TIPO_CARGO=1 THEN
                                     IF EV_IMPCARGO_DESTINO <> 0  THEN
                                            GN_IMP_CARGO:= (EV_IMPCARGO_DESTINO * GN_IMP_CARGO )/100;
                                         END IF;
                                  END IF;
                           END IF;

                           IF   flg_estado THEN

                                  SELECT PV_SEQ_NUMOS.NEXTVAL INTO GN_NUM_MOVIMIENTO FROM  DUAL;

                              tab_parametros(ind_parametros).NUM_MOVIMIENTO     := GN_NUM_MOVIMIENTO;
                          tab_parametros(ind_parametros).IND_FACTUR         := GV_IND_FACTUR;
                          tab_parametros(ind_parametros).DES_SERV           := GV_DES_SERV ;
                          tab_parametros(ind_parametros).NUM_UNIDADES       := GN_NUM_UNIDADES;
                              tab_parametros(ind_parametros).IMP_CARGO          := GN_IMP_CARGO;
                              tab_parametros(ind_parametros).COD_CONCEPTO       := GN_COD_CONCEPTO;
                              tab_parametros(ind_parametros).COD_MONEDA         := GV_COD_MONEDA;
                              tab_parametros(ind_parametros).DES_MONEDA         := GV_DES_MONEDA;
                              tab_parametros(ind_parametros).COD_ACTABO         := EN_COD_ACTABO;
                              tab_parametros(ind_parametros).COD_CLIENTE        := EN_COD_CLIENTE;
                              tab_parametros(ind_parametros).NUM_ABONADO        := EN_NUM_ABONADO;
                              tab_parametros(ind_parametros).NUM_CELULAR        := EN_NUM_CELULAR;
                              tab_parametros(ind_parametros).COD_PLANCOM        := EN_COD_PLANCOM;
                              tab_parametros(ind_parametros).COD_ARTICULO       := NULL;
                              tab_parametros(ind_parametros).COD_BODEGA         := NULL;
                              tab_parametros(ind_parametros).NUM_SERIE          := NULL;
                              tab_parametros(ind_parametros).IND_EQUIPO         := NULL;
                              tab_parametros(ind_parametros).TIP_DTO            := NULL;
                              tab_parametros(ind_parametros).VAL_DTO            := NULL;
                              tab_parametros(ind_parametros).COD_CONCEPTO_DTO   := NULL;
                              tab_parametros(ind_parametros).CLASE_SERVICIO_ACT := NULL;
                              tab_parametros(ind_parametros).CLASE_SERVICIO_DES := NULL;
                              tab_parametros(ind_parametros).PARAM1_MENS        := NULL;
                              tab_parametros(ind_parametros).PARAM2_MENS        := NULL;
                              tab_parametros(ind_parametros).PARMA3_MENS        := NULL;
                              tab_parametros(ind_parametros).CLASE_SERVICIO     := NULL;
                              tab_parametros(ind_parametros).COD_CICLO          := NULL;
                              tab_parametros(ind_parametros).FACT_CONT          := 1;
                              tab_parametros(ind_parametros).VAL_MIN            := NULL;
                              tab_parametros(ind_parametros).VAL_MAX            := NULL;
                              tab_parametros(ind_parametros).P_DESC             := 1;
                              tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                              tab_parametros(ind_parametros).DES_ERROR          :='OK';

                                  ind_parametros := ind_parametros + 1;





                              --LLAMA FUNCIÓN DE DESCUENTOS POR CONSTRUIR --
                         dbms_output.put_line('2.-PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR');
                                     PV_COBRAR_PG.PV_CARGO_DESCUENTO_PR(
                                                 EV_COD_OPERA,EV_TIP_CONT,EN_MES,EV_COD_ANT,EV_ESTADO_EQ,EV_COD_CNUE,EV_MESNUE,EN_COD_ARTI,EV_COD_CAUSA,
                                                 EV_COD_CAUSA_NUE,EV_COD_CATEG,EN_COD_MODVTA,EN_COD_CLIENTE,EN_COD_VENDE,EN_TIP_ABONADO,SV_RETORNO,SV_GLOSA);

                                 END IF;

                     END LOOP;
                     CLOSE CARGOSEGMENTACION;



EXCEPTION
   WHEN NO_DATA_FOUND THEN
       BEGIN
             SV_RETORNO :='0';
                         SV_GLOSA   :='OK';
dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - SV_GLOSA :'||SV_GLOSA);                                                             
       END;
      WHEN OTHERS THEN
       BEGIN

                 SV_RETORNO:=0;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_SEGMENTACION_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                      tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                         ind_parametros := ind_parametros + 1;
                         PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );

             SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
   dbms_output.put_line('PV_CARGO_SEGMENTACION_PR - SV_GLOSA :'||SV_GLOSA);                                    
             IF Lv_n_num_evento = -1 THEN
                Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CARGOSEGMENTACION','1',USER,'PV_COBRAR_PG.PV_CARGO_SEGMENTACION_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
             ELSE
                Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CARGOSEGMENTACION','1',USER,'PV_COBRAR_PG.PV_CARGO_SEGMENTACION_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
             END IF;
       END;
END PV_CARGO_SEGMENTACION_PR;

PROCEDURE PV_CARGO_ADELANTADO_PR(
                                                 EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EV_PLANTARIF_ANT  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 EV_PLANTARIF_NUE  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                  SV_record         OUT NOCOPY refcursor,
                                                 SV_RETORNO         IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA                IN OUT NOCOPY VARCHAR2
                                                 )   


IS

/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_ADELANTADO_PR"
      Lenguaje="PL/SQL"
      Fecha="1-05-2010"
      Versión="1.0"
      Diseñador="Orlando Cabezas"
      Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción>Generacion de Cargos</Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EV_SEGMENTACION_ORIGEN"   Tipo="STRING">Codigo Segmentacion Origen</param>
                        <param nom="EV_SEGMENTACION_DESTINO"  Tipo="STRING">Codigo Segmentacion Destino</param>
                        <param nom="EV_PLANTARIF_ACT"         Tipo="STRING">CODIGO PLAN TARIFARIO</param>
                        <param nom="EV_PLANTARIF_NUE"         Tipo="STRING">CODIGO PLAN TARIFARIO NUEVO</param>
                        <param nom="EV_CARBASICO_ORIG"        Tipo="NUMERICO">CODIGO CLIENTE</param>
                        <param nom="EV_CARBASICO_DEST"        Tipo="NUMERICO">NUM_ABONADO</param>
                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/



           
   Lv_SqlFinal           VARCHAR2(5000);
  
   flg_estado  boolean := TRUE;
   LV_CADENA_SS          GA_abocel.perfil_abonado%type;
   ln_max                INTEGER;
   ln_pos                INTEGER;
   ln_pos2               INTEGER;
   ln_pos3               INTEGER;
   LV_COD_NIVEL          GA_SERVSUPL.COD_NIVEL%TYPE;
   LV_COD_SERVSUPL       GA_SERVSUPL.COD_SERVSUPL%TYPE; 
   ln_cod_concepto       ga_actuaserv.COD_CONCEPTO%TYPE;
   lv_cod_servicio       ga_servsupl.cod_servicio%type;
   
   lv_DES_SERVICIO       GA_SERVICIOS.DES_SERVICIO%TYPE;   
   lv_IND_AUTMAN         GA_SERVICIOS.IND_AUTMAN%TYPE;
   lv_IMP_TARIFA         GA_TARIFAS.IMP_TARIFA%TYPE;
   lv_IMP_TARIFA_PRO     GA_TARIFAS.IMP_TARIFA%TYPE;
   lv_DES_MONEDA         GE_MONEDAS.DES_MONEDA%TYPE;   
   lv_COD_MONEDA         GE_MONEDAS.COD_MONEDA%TYPE;
   SN_codRetorno         ge_errores_pg.CodError;
   SV_menRetorno         ge_errores_pg.MsgError;
   SN_numEvento          ge_errores_pg.Evento;
   
   FACT_IMPOR            EXCEPTION;
   

BEGIN
dbms_output.put_line('PV_CARGO_ADELANTADO_PR - inicio :');
      LV_CADENA_SS :=EV_ESTADO_EQ;
      ln_max       :=LENGTH(LV_CADENA_SS);
      ln_pos       := 1 ;
      SV_RETORNO :='1';
                SV_GLOSA   :='NO_DATA';
        
      WHILE (LN_pos<= NVL(LN_MAX,0)) LOOP
                LN_pos2 :=INSTR(LV_CADENA_SS,'|');
                
                IF LN_POS2= 0 THEN 
                      LN_POS2:=LN_MAX;
                      LN_pos3 :=INSTR(LV_CADENA_SS,'*');
                           
                      LV_COD_SERVSUPL:=TO_NUMBER(SUBSTR(LV_CADENA_SS,1,LN_POS3 - 1));
                      LV_COD_NIVEL:=TO_NUMBER(SUBSTR(LV_CADENA_SS,(LN_POS3 + 1),(LN_POS2-LN_POS3-1)) );
                      
                      dbms_output.put_line('GRUPO :'|| LV_COD_SERVSUPL);  
                      dbms_output.put_line('NIVEL :'|| LV_COD_NIVEL);
               
                
                ELSE
                      LN_pos3 :=INSTR(LV_CADENA_SS,'*');
                   
                      LV_COD_SERVSUPL:=TO_NUMBER(SUBSTR(LV_CADENA_SS,1,LN_POS3 - 1));
               
                      LV_COD_NIVEL:=TO_NUMBER(SUBSTR(LV_CADENA_SS,(LN_POS3 + 1),(LN_POS2-LN_POS3-1)) );
                      dbms_output.put_line('GRUPO :'|| LV_COD_SERVSUPL);  
                      dbms_output.put_line('NIVEL :'|| LV_COD_NIVEL);  
                
                END IF;
                
                
                LV_CADENA_SS:=SUBSTR(LV_CADENA_SS,LN_POS2+1,LN_MAX); 
                
                dbms_output.put_line('PV_CARGO_ADELANTADO_PR - trata cadena  :'||LV_CADENA_SS);
                
                
                BEGIN
                
                    Lv_SqlFinal:='SELECT cod_servicio'; 
                    Lv_SqlFinal:= Lv_SqlFinal || ' into lv_cod_servicio';
                    Lv_SqlFinal:= Lv_SqlFinal || ' FROM  ga_servsupl';
                    Lv_SqlFinal:= Lv_SqlFinal || ' WHERE tip_cobro  = A';
                    Lv_SqlFinal:= Lv_SqlFinal || ' and   COD_SERVSUPL = ' || LV_COD_SERVSUPL;
                    Lv_SqlFinal:= Lv_SqlFinal || ' and   COD_NIVEL    = ' || LV_COD_NIVEL;
                    
                    
                    SELECT cod_servicio 
                    into lv_cod_servicio
                    FROM  ga_servsupl
                    WHERE tip_cobro  = 'A'
                    and   COD_SERVSUPL = LV_COD_SERVSUPL
                    and   COD_NIVEL    = LV_COD_NIVEL;
                    
                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            lv_cod_servicio:='';
                            
                
                END;    


dbms_output.put_line('PV_CARGO_ADELANTADO_PR - obtiene servicio  :'||lv_cod_servicio||'-'||TRIM(lv_cod_servicio) );

                IF TRIM(lv_cod_servicio) <> ' ' THEN

dbms_output.put_line('PV_CARGO_ADELANTADO_PR - pasa  :');                
                
                            Lv_SqlFinal:= ' SELECT C.IND_AUTMAN, C.DES_SERVICIO,B.IMP_TARIFA,D.DES_MONEDA,  B.COD_MONEDA';
                            Lv_SqlFinal:= Lv_SqlFinal || ' into  lv_IND_AUTMAN, lv_DES_SERVICIO,lv_IMP_TARIFA,lv_DES_MONEDA,lv_COD_MONEDA';
                            Lv_SqlFinal:= Lv_SqlFinal || ' FROM  GA_ACTUASERV A, GA_TARIFAS B,';
                            Lv_SqlFinal:= Lv_SqlFinal || ' GA_SERVICIOS C,GE_MONEDAS D';
                            Lv_SqlFinal:= Lv_SqlFinal || ' WHERE A.COD_PRODUCTO = ' || EN_COD_PRODUCTO;
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND A.COD_ACTABO     = ' || EN_COD_ACTABO;
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND A.COD_TIPSERV    = ' || CV_COD_TIPSERV;
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND A.cod_servicio   = ' || lv_cod_servicio;
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_PRODUCTO   = A.COD_PRODUCTO';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_ACTABO     = A.COD_ACTABO';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_TIPSERV    = A.COD_TIPSERV';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_SERVICIO   = A.COD_SERVICIO';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND TO_NUMBER(TRIM(B.COD_PLANSERV))   = TO_NUMBER(TRIM('||EN_COD_PLANSERV||'))';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND C.COD_PRODUCTO   = A.COD_PRODUCTO';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND C.COD_SERVICIO   = A.COD_SERVICIO';
                            Lv_SqlFinal:= Lv_SqlFinal || ' AND D.COD_MONEDA     = B.COD_MONEDA';
                            Lv_SqlFinal:= Lv_SqlFinal || ' and rownum= 1';
                
                                           
dbms_output.put_line('PV_CARGO_ADELANTADO_PR - tarifa 1  :'||lv_cod_servicio||'-'||EN_COD_PLANSERV||'-'||CV_COD_TIPSERV);

                            BEGIN
                            
                            SELECT C.IND_AUTMAN, C.DES_SERVICIO,B.IMP_TARIFA,D.DES_MONEDA,  B.COD_MONEDA,A.COD_CONCEPTO
                            into  lv_IND_AUTMAN, lv_DES_SERVICIO,lv_IMP_TARIFA,lv_DES_MONEDA,lv_COD_MONEDA,ln_cod_concepto
                            FROM  GA_ACTUASERV A, GA_TARIFAS B,
                            GA_SERVICIOS C,GE_MONEDAS D
                            WHERE A.COD_PRODUCTO = EN_COD_PRODUCTO
                            AND A.COD_ACTABO     = 'SS'
                            AND A.COD_TIPSERV    = CV_COD_TIPSERV
                            AND A.cod_servicio   = lv_cod_servicio
                            AND B.COD_PRODUCTO   = A.COD_PRODUCTO
                            AND B.COD_ACTABO     = A.COD_ACTABO
                            AND B.COD_TIPSERV    = A.COD_TIPSERV
                            AND B.COD_SERVICIO   = A.COD_SERVICIO
                            AND TO_NUMBER(TRIM(B.COD_PLANSERV))   = TO_NUMBER(TRIM(EN_COD_PLANSERV))
                            AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
                            AND C.COD_PRODUCTO   = A.COD_PRODUCTO
                            AND C.COD_SERVICIO   = A.COD_SERVICIO
                            AND D.COD_MONEDA     = B.COD_MONEDA
                            and rownum= 1;
                            EXCEPTION
                                WHEN OTHERS THEN 
                                    ln_cod_concepto:=0;
                                
                            END;
                            
                            
dbms_output.put_line('PV_CARGO_ADELANTADO_PR - tarifa 2  :');
                            
                             Lv_SqlFinal:='FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR('|| EN_NUM_ABONADO ||  ','
                                                                              || lv_IMP_TARIFA     || ','
                                                                              || lv_IMP_TARIFA_PRO || ',' 
                                                                              || SN_codRetorno     || ','
                                                                              || SV_menRetorno     || ','
                                                                              || SN_numEvento      || ')';
                                                                              
                                                                              
                            
                            FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR(   EN_NUM_ABONADO   ,
                                                                              lv_IMP_TARIFA    ,
                                                                              lv_IMP_TARIFA_PRO, 
                                                                              SN_codRetorno  ,
                                                                              SV_menRetorno  ,
                                                                              SN_numEvento   );
                                                                              
                            
dbms_output.put_line('PV_CARGO_ADELANTADO_PR - prorratea :'||SN_codRetorno );
                            IF SN_codRetorno = 0  AND ln_cod_concepto> 0 THEN

dbms_output.put_line('PV_CARGO_ADELANTADO_PR - entra cursor  :' );

SV_RETORNO :='0';
      SV_GLOSA   :='OK';
                                           SELECT PV_SEQ_NUMOS.NEXTVAL INTO GN_NUM_MOVIMIENTO FROM  DUAL; 
                                           OPEN  SV_record  FOR
                                           SELECT GN_NUM_MOVIMIENTO,lv_IND_AUTMAN,lv_DES_SERVICIO,1,lv_IMP_TARIFA_PRO,ln_cod_concepto,
                                                  lv_COD_MONEDA,lv_DES_MONEDA,EN_COD_ACTABO,EN_COD_CLIENTE,EN_NUM_ABONADO,EN_NUM_CELULAR,EN_COD_PLANCOM,
                                                  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,0,'OK'
                                           FROM DUAL; 
                                           dbms_output.put_line('PV_CARGO_ADELANTADO_PR - SALE cursor  :' );

                                          /*

                                          tab_parametros(ind_parametros).NUM_MOVIMIENTO     := GN_NUM_MOVIMIENTO;
                                          tab_parametros(ind_parametros).IND_FACTUR         := lv_IND_AUTMAN;
                                          tab_parametros(ind_parametros).DES_SERV           := lv_DES_SERVICIO ;
                                          tab_parametros(ind_parametros).NUM_UNIDADES       := 1;
                                          tab_parametros(ind_parametros).IMP_CARGO          := lv_IMP_TARIFA_PRO;
                                          tab_parametros(ind_parametros).COD_CONCEPTO       := ln_cod_concepto;
                                          tab_parametros(ind_parametros).COD_MONEDA         := lv_COD_MONEDA;
                                          tab_parametros(ind_parametros).DES_MONEDA         := lv_DES_MONEDA;
                                          tab_parametros(ind_parametros).COD_ACTABO         := EN_COD_ACTABO;
                                          tab_parametros(ind_parametros).COD_CLIENTE        := EN_COD_CLIENTE;
                                          tab_parametros(ind_parametros).NUM_ABONADO        := EN_NUM_ABONADO;
                                          tab_parametros(ind_parametros).NUM_CELULAR        := EN_NUM_CELULAR;
                                          tab_parametros(ind_parametros).COD_PLANCOM        := EN_COD_PLANCOM;
                                          tab_parametros(ind_parametros).COD_ARTICULO       := NULL;
                                          tab_parametros(ind_parametros).COD_BODEGA         := NULL;
                                          tab_parametros(ind_parametros).NUM_SERIE          := NULL;
                                          tab_parametros(ind_parametros).IND_EQUIPO         := NULL;
                                          tab_parametros(ind_parametros).TIP_DTO            := NULL;
                                          tab_parametros(ind_parametros).VAL_DTO            := NULL;
                                          tab_parametros(ind_parametros).COD_CONCEPTO_DTO   := NULL;
                                          tab_parametros(ind_parametros).CLASE_SERVICIO_ACT := NULL;
                                          tab_parametros(ind_parametros).CLASE_SERVICIO_DES := NULL;
                                          tab_parametros(ind_parametros).PARAM1_MENS        := NULL;
                                          tab_parametros(ind_parametros).PARAM2_MENS        := NULL;
                                          tab_parametros(ind_parametros).PARMA3_MENS        := NULL;
                                          tab_parametros(ind_parametros).CLASE_SERVICIO     := NULL;
                                          tab_parametros(ind_parametros).COD_CICLO          := NULL;
                                          tab_parametros(ind_parametros).FACT_CONT          := 1;
                                          tab_parametros(ind_parametros).VAL_MIN            := NULL;
                                          tab_parametros(ind_parametros).VAL_MAX            := NULL;
                                          tab_parametros(ind_parametros).P_DESC             := 1;
                                          tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                                          tab_parametros(ind_parametros).DES_ERROR          :='OK';

                                          ind_parametros := ind_parametros + 1;*/
                                           ln_pos:=ln_pos2+1 ;
                                          
                            ELSE  
                                /*IF SN_codRetorno > 1 THEN            
                                   RAISE FACT_IMPOR;        
                                END IF;*/
                                NULL;  
                            END IF;             
                END IF;
                
                ln_pos:=ln_pos2+1 ;
                
      END LOOP;
      
 
      
       dbms_output.put_line('PV_CARGO_ADELANTADO_PR - salio bien de cargos adelantados :');  
          

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       BEGIN
                SV_RETORNO :='1';
                SV_GLOSA   :='NO_DATA';
                dbms_output.put_line('PV_CARGO_ADELANTADO_PR - SV_GLOSA :'||SV_GLOSA);                                                             
       END;
       
       WHEN FACT_IMPOR THEN
       BEGIN

                         SV_RETORNO:=2;
                         SV_GLOSA:= SUBSTR('Error FA_getProrrateo_PR:' || SQLERRM,1,255);
                         /*SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                         tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                         ind_parametros := ind_parametros + 1;
                         PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );

                         SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
                         dbms_output.put_line('FA_getProrrateo_PR - SV_GLOSA :'||SV_GLOSA);
                                                             
                         IF Lv_n_num_evento = -1 THEN
                            Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
                         ELSE
                            Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
                         END IF;*/
       END;
       
       
      WHEN OTHERS THEN
       BEGIN

                         SV_RETORNO:=2;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_ADELANTADO_PR:' || SQLERRM,1,255);
                        /* SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                         tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                         ind_parametros := ind_parametros + 1;
                         PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );

                         SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
                         dbms_output.put_line('PV_CARGO_ADELANTADO_PR - SV_GLOSA :'||SV_GLOSA);
                                                             
                         IF Lv_n_num_evento = -1 THEN
                            Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'PV_COBRAR_PG.PV_CARGO_ADELANTADO_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
                         ELSE
                            Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'PV_COBRAR_PG.PV_CARGO_ADELANTADO_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
                         END IF;*/
       END;

END PV_CARGO_ADELANTADO_PR;                                                         





PROCEDURE PV_CARGO_ADELANSS_TRASABO_PR(
                                                 EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EV_PLANTARIF_ANT  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 EV_PLANTARIF_NUE  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                               --   SV_record         OUT NOCOPY refcursor,
                                                 SV_RETORNO         IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA                IN OUT NOCOPY VARCHAR2
                                                 )   


IS

/*
<Documentación
  TipoDoc = "PROCEDIMIENTO">
   <Elemento
      Nombre = "PV_CARGO_ADELANSS_TRASABO_PR"
      Lenguaje="PL/SQL"
      Fecha="1-05-2010"
      Versión="1.0"
      Diseñador="Orlando Cabezas"
      Programador="Orlando Cabezas"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción>Generacion de Cargos</Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EV_SEGMENTACION_ORIGEN"   Tipo="STRING">Codigo Segmentacion Origen</param>
                        <param nom="EV_SEGMENTACION_DESTINO"  Tipo="STRING">Codigo Segmentacion Destino</param>
                        <param nom="EV_PLANTARIF_ACT"         Tipo="STRING">CODIGO PLAN TARIFARIO</param>
                        <param nom="EV_PLANTARIF_NUE"         Tipo="STRING">CODIGO PLAN TARIFARIO NUEVO</param>
                        <param nom="EV_CARBASICO_ORIG"        Tipo="NUMERICO">CODIGO CLIENTE</param>
                        <param nom="EV_CARBASICO_DEST"        Tipo="NUMERICO">NUM_ABONADO</param>
                   </Entrada>
         <Salida>
                    <param nom="SV_RETORNO    "   Tipo="NUMERICO">RETORNO PROCESO</param>
                        <param nom="SV_GLOSA      "   Tipo="VARCHAR2">DESCRIPCION RETORNO</param>

         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/



           
   Lv_SqlFinal           VARCHAR2(5000);
  
   flg_estado  boolean := TRUE;
   LV_CADENA_SS          GA_abocel.perfil_abonado%type;
   ln_max                INTEGER;
   ln_pos                INTEGER;
   ln_pos2               INTEGER;
   ln_pos3               INTEGER;
   LV_COD_NIVEL          GA_SERVSUPL.COD_NIVEL%TYPE;
   LV_COD_SERVSUPL       GA_SERVSUPL.COD_SERVSUPL%TYPE; 
   ln_cod_concepto       ga_actuaserv.COD_CONCEPTO%TYPE;
   lv_cod_servicio       ga_servsupl.cod_servicio%type;
   
   lv_DES_SERVICIO       GA_SERVICIOS.DES_SERVICIO%TYPE;   
   lv_IND_AUTMAN         GA_SERVICIOS.IND_AUTMAN%TYPE;
   lv_IMP_TARIFA         GA_TARIFAS.IMP_TARIFA%TYPE;
   lv_IMP_TARIFA_PRO     GA_TARIFAS.IMP_TARIFA%TYPE;
   lv_DES_MONEDA         GE_MONEDAS.DES_MONEDA%TYPE;   
   lv_COD_MONEDA         GE_MONEDAS.COD_MONEDA%TYPE;
   SN_codRetorno         ge_errores_pg.CodError;
   SV_menRetorno         ge_errores_pg.MsgError;
   SN_numEvento          ge_errores_pg.Evento;
   
   CURSOR serv_cur IS
      SELECT a.cod_servicio
      FROM  ga_servsuplabo a
      WHERE a.num_abonado = EN_NUM_ABONADO
      AND a.cod_servicio in (SELECT v.cod_servicio FROM  ga_servsupl v
                           WHERE v.tip_cobro  = 'A')
      AND a.FEC_ALTABD is not null AND TRUNC(A.FEC_ALTABD)= TRUNC(SYSDATE)
      AND a.ind_estado < 3;
   
   FACT_IMPOR            EXCEPTION;
   

BEGIN


   
      OPEN serv_cur ;
      LOOP
       FETCH serv_cur INTO lv_cod_servicio;
       EXIT WHEN serv_cur%NOTFOUND;
        
        
       dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - inicio :');
       SV_RETORNO :='1';
       SV_GLOSA   :='NO_DATA';


       IF TRIM(lv_cod_servicio) <> ' ' THEN

                                                   dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - pasa  :');                
                                        
                                                    Lv_SqlFinal:= ' SELECT C.IND_AUTMAN, C.DES_SERVICIO,B.IMP_TARIFA,D.DES_MONEDA,  B.COD_MONEDA';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' into  lv_IND_AUTMAN, lv_DES_SERVICIO,lv_IMP_TARIFA,lv_DES_MONEDA,lv_COD_MONEDA';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' FROM  GA_ACTUASERV A, GA_TARIFAS B,';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' GA_SERVICIOS C,GE_MONEDAS D';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' WHERE A.COD_PRODUCTO = ' || EN_COD_PRODUCTO;
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND A.COD_ACTABO     = ' || EN_COD_ACTABO;
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND A.COD_TIPSERV    = ' || CV_COD_TIPSERV;
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND A.cod_servicio   = ' || lv_cod_servicio;
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_PRODUCTO   = A.COD_PRODUCTO';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_ACTABO     = A.COD_ACTABO';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_TIPSERV    = A.COD_TIPSERV';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND B.COD_SERVICIO   = A.COD_SERVICIO';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND TO_NUMBER(TRIM(B.COD_PLANSERV))   = TO_NUMBER(TRIM('||EN_COD_PLANSERV||'))';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND C.COD_PRODUCTO   = A.COD_PRODUCTO';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND C.COD_SERVICIO   = A.COD_SERVICIO';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' AND D.COD_MONEDA     = B.COD_MONEDA';
                                                    Lv_SqlFinal:= Lv_SqlFinal || ' and rownum= 1';
                                        
                                                                   
                                                    dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - tarifa 1  :'||lv_cod_servicio||'-'||EN_COD_PLANSERV||'-'||CV_COD_TIPSERV);

                                                    BEGIN
                                                    
                                                    SELECT C.IND_AUTMAN, C.DES_SERVICIO,B.IMP_TARIFA,D.DES_MONEDA,  B.COD_MONEDA,A.COD_CONCEPTO
                                                    into  lv_IND_AUTMAN, lv_DES_SERVICIO,lv_IMP_TARIFA,lv_DES_MONEDA,lv_COD_MONEDA,ln_cod_concepto
                                                    FROM  GA_ACTUASERV A, GA_TARIFAS B,
                                                    GA_SERVICIOS C,GE_MONEDAS D
                                                    WHERE A.COD_PRODUCTO = EN_COD_PRODUCTO
                                                    AND A.COD_ACTABO     = 'SS'
                                                    AND A.COD_TIPSERV    = CV_COD_TIPSERV
                                                    AND A.cod_servicio   = lv_cod_servicio
                                                    AND B.COD_PRODUCTO   = A.COD_PRODUCTO
                                                    AND B.COD_ACTABO     = A.COD_ACTABO
                                                    AND B.COD_TIPSERV    = A.COD_TIPSERV
                                                    AND B.COD_SERVICIO   = A.COD_SERVICIO
                                                    AND TO_NUMBER(TRIM(B.COD_PLANSERV))   = TO_NUMBER(TRIM(EN_COD_PLANSERV))
                                                    AND SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE)
                                                    AND C.COD_PRODUCTO   = A.COD_PRODUCTO
                                                    AND C.COD_SERVICIO   = A.COD_SERVICIO
                                                    AND D.COD_MONEDA     = B.COD_MONEDA
                                                    and rownum= 1;
                                                    EXCEPTION
                                                        WHEN OTHERS THEN 
                                                            ln_cod_concepto:=0;
                                                        
                                                    END;
                                                    
                                                    
                                                    dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - tarifa 2  :');
                                                    
                                                     Lv_SqlFinal:='FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR('|| EN_NUM_ABONADO ||  ','
                                                                                                      || lv_IMP_TARIFA     || ','
                                                                                                      || lv_IMP_TARIFA_PRO || ',' 
                                                                                                      || SN_codRetorno     || ','
                                                                                                      || SV_menRetorno     || ','
                                                                                                      || SN_numEvento      || ')';
                                                                                                      
                                                                                                      
                                                    
                                                    FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR(   EN_NUM_ABONADO   ,
                                                                                                      lv_IMP_TARIFA    ,
                                                                                                      lv_IMP_TARIFA_PRO, 
                                                                                                      SN_codRetorno  ,
                                                                                                      SV_menRetorno  ,
                                                                                                      SN_numEvento   );
                                                                                                      
                                                    
                                                    dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - prorratea :'||SN_codRetorno );
                                                    IF SN_codRetorno = 0  AND ln_cod_concepto> 0 THEN

                                                                  dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - entra cursor  :' );

                                                                  SV_RETORNO :='0';
                                                                  SV_GLOSA   :='OK';
                                                                   
                                                                  SELECT PV_SEQ_NUMOS.NEXTVAL INTO GN_NUM_MOVIMIENTO FROM  DUAL; 
                                                                   
                                                                  
                                                                  

                                                                  tab_parametros(ind_parametros).NUM_MOVIMIENTO     := GN_NUM_MOVIMIENTO;
                                                                  tab_parametros(ind_parametros).IND_FACTUR         := lv_IND_AUTMAN;
                                                                  tab_parametros(ind_parametros).DES_SERV           := lv_DES_SERVICIO ;
                                                                  tab_parametros(ind_parametros).NUM_UNIDADES       := 1;
                                                                  tab_parametros(ind_parametros).IMP_CARGO          := lv_IMP_TARIFA_PRO;
                                                                  tab_parametros(ind_parametros).COD_CONCEPTO       := ln_cod_concepto;
                                                                  tab_parametros(ind_parametros).COD_MONEDA         := lv_COD_MONEDA;
                                                                  tab_parametros(ind_parametros).DES_MONEDA         := lv_DES_MONEDA;
                                                                  tab_parametros(ind_parametros).COD_ACTABO         := EN_COD_ACTABO;
                                                                  tab_parametros(ind_parametros).COD_CLIENTE        := EN_COD_CLIENTE;
                                                                  tab_parametros(ind_parametros).NUM_ABONADO        := EN_NUM_ABONADO;
                                                                  tab_parametros(ind_parametros).NUM_CELULAR        := EN_NUM_CELULAR;
                                                                  tab_parametros(ind_parametros).COD_PLANCOM        := EN_COD_PLANCOM;
                                                                  tab_parametros(ind_parametros).COD_ARTICULO       := NULL;
                                                                  tab_parametros(ind_parametros).COD_BODEGA         := NULL;
                                                                  tab_parametros(ind_parametros).NUM_SERIE          := NULL;
                                                                  tab_parametros(ind_parametros).IND_EQUIPO         := NULL;
                                                                  tab_parametros(ind_parametros).TIP_DTO            := NULL;
                                                                  tab_parametros(ind_parametros).VAL_DTO            := NULL;
                                                                  tab_parametros(ind_parametros).COD_CONCEPTO_DTO   := NULL;
                                                                  tab_parametros(ind_parametros).CLASE_SERVICIO_ACT := NULL;
                                                                  tab_parametros(ind_parametros).CLASE_SERVICIO_DES := NULL;
                                                                  tab_parametros(ind_parametros).PARAM1_MENS        := 'ADELANTADO';
                                                                  tab_parametros(ind_parametros).PARAM2_MENS        := NULL;
                                                                  tab_parametros(ind_parametros).PARMA3_MENS        := NULL;
                                                                  tab_parametros(ind_parametros).CLASE_SERVICIO     := NULL;
                                                                  tab_parametros(ind_parametros).COD_CICLO          := NULL;
                                                                  tab_parametros(ind_parametros).FACT_CONT          := 1;
                                                                  tab_parametros(ind_parametros).VAL_MIN            := NULL;
                                                                  tab_parametros(ind_parametros).VAL_MAX            := NULL;
                                                                  tab_parametros(ind_parametros).P_DESC             := 1;
                                                                  tab_parametros(ind_parametros).COD_ERROR          := 0 ;
                                                                  tab_parametros(ind_parametros).DES_ERROR          :='OK';
                                                                  dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - SALE cursor  :' );
                                                                  ind_parametros := ind_parametros + 1;
                                                                   ln_pos:=ln_pos2+1 ;
                                                                  
                                                    ELSE  
                                                        IF SN_codRetorno > 1 THEN            
                                                           RAISE FACT_IMPOR;        
                                                        END IF;
                                                        NULL;  
                                                    END IF;             
                                       
                                        
                                        ln_pos:=ln_pos2+1 ;
       END IF;         
      END LOOP;
      
 
      
       dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - salio bien de cargos adelantados :');  
          

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       BEGIN
                SV_RETORNO :='1';
                SV_GLOSA   :='NO_DATA';
                dbms_output.put_line('PV_CARGO_ADELANSS_TRASABO_PR - SV_GLOSA :'||SV_GLOSA);                                                             
       END;
       
       WHEN FACT_IMPOR THEN
       BEGIN

                         SV_RETORNO:=2;
                         SV_GLOSA:= SUBSTR('Error FA_getProrrateo_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                         tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                         ind_parametros := ind_parametros + 1;
                         PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );

                         SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
                         dbms_output.put_line('FA_getProrrateo_PR - SV_GLOSA :'||SV_GLOSA);
                                                             
                         IF Lv_n_num_evento = -1 THEN
                            Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
                         ELSE
                            Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'FA_SERVICIOS_FACTURACION_PG.FA_getProrrateo_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
                         END IF;
       END;
       
       
      WHEN OTHERS THEN
       BEGIN

                         SV_RETORNO:=2;
                         SV_GLOSA:= SUBSTR('Error PV_CARGO_ADELANTADO_PR:' || SQLERRM,1,255);
                         SELECT PV_SEQ_NUMOS.NEXTVAL INTO tab_parametros(ind_parametros).NUM_MOVIMIENTO
                         FROM   DUAL;
                         tab_parametros(ind_parametros).cod_cliente       := EN_COD_CLIENTE ;
                         tab_parametros(ind_parametros).COD_ERROR         := 4 ;
                         tab_parametros(ind_parametros).DES_ERROR         := SV_GLOSA ;
                         ind_parametros := ind_parametros + 1;
                         PV_COBRAR_PG.PV_INS_TMPPARAMETROS_SALIDA_PR( 1, SV_RETORNO,SV_GLOSA );

                         SV_RETORNO :='4';
                         SV_GLOSA   :=SUBSTR(SQLERRM,1, 255);
                         dbms_output.put_line('PV_CARGO_ADELANTADO_PR - SV_GLOSA :'||SV_GLOSA);
                                                             
                         IF Lv_n_num_evento = -1 THEN
                            Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'PV_COBRAR_PG.PV_CARGO_ADELANTADO_PR',Lv_SqlFinal,SQLCODE,SQLERRM);
                         ELSE
                            Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en CURSOR CARGOADELANTADO','1',USER,'PV_COBRAR_PG.PV_CARGO_ADELANTADO_PR',Lv_SqlFinal,SQLCODE, SQLERRM);
                         END IF;
       END;

END PV_CARGO_ADELANSS_TRASABO_PR;                                                         





END PV_COBRAR_PG;
/
SHOW ERRORS