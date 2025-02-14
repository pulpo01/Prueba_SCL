CREATE OR REPLACE PACKAGE BODY            Np_Gestor_Mayoristas_Pg IS

/*
<Documentación TipoDoc = "Package">
<Elemento Nombre = "NP_GESTOR_MAYORISTAS_PG" Lenguaje="PL/V_sSql" Fecha="06-11-2006" Versión="1.0" Diseñador="****" Programador="Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PKG  encargado de transacciones para el proyecto gestor de Mayoristas en NPW</Descripción>
<Parámetros>
    <Entrada>    </Entrada>
    <Salida>     </Salida>
</Parámetros>
</Elemento>
</Documentación>

 <FECHAMOD>  24-01-2006        </FECHAMOD>
 <AUTORMOD>  Zenén MUñoz H. </AUTORMOD>
 <VERSIONMOD> 1.1           </VERSIONMOD>
 <DESCMOD>  Se considera el artículo, en el proceso de descuento de los pedidos que realice un mayortista, incidencia: 37017 </DESCMOD>
  <FECHAMOD>  12-02-2006        </FECHAMOD>
  <VERSIONMOD> 1.2           </VERSIONMOD>
 <DESCMOD>  Se considera venta financiando mayorista inc .37443   </DESCMOD>
<FECHAMOD>  15-02-2006        </FECHAMOD>
<VERSIONMOD> 1.3           </VERSIONMOD>
<DESCMOD>  Modificaciones ne la forma de obtencion del descuento de las series Inc .37710    </DESCMOD>
<FECHAMOD>  16-02-2006        </FECHAMOD>
<VERSIONMOD> 1.4           </VERSIONMOD>
<DESCMOD>  Incorporacion de un control de error para la obtencion del precio de venta Inc .37757    </DESCMOD>
<FECHAMOD>  19-02-2007        </FECHAMOD>
<AUTORMOD>  Zenén Muñoz H. </AUTORMOD>
<VERSIONMOD> 1.5           </VERSIONMOD>
<DESCMOD>  Se elimina el número de meses (a.NUM_MESES      = 0) al rescatar el Precio de Venta   Inc .37713    </DESCMOD>
<FECHAMOD>  06-03-2007        </FECHAMOD>
<AUTORMOD>  Zenén Muñoz H. </AUTORMOD>
<VERSIONMOD> 1.6           </VERSIONMOD>
<DESCMOD>  Se realizan cambios en el calculo de descuento automatico, no calcula el descuento en ciertos casos.  Inc .38275  </DESCMOD>
<FECHAMOD>  08-03-2007        </FECHAMOD>
<AUTORMOD>  Zenén Muñoz H. </AUTORMOD>
<VERSIONMOD> 1.7           </VERSIONMOD>
<DESCMOD>  Se realizan cambios en el calculo del valor neto por unidad, menos el descuento de la línea. Inc .38366  </DESCMOD>
<FECHAMOD>  09-03-2007        </FECHAMOD>
<AUTORMOD>  Zenén Muñoz H. </AUTORMOD>
<VERSIONMOD> 1.8           </VERSIONMOD>
<DESCMOD>  Se realizan cambios en el calculo del valor neto por unidad, menos el descuento de la línea. Inc .38412
           Además se cambia el nro. de la venta que realiza la activación</DESCMOD>
<FECHAMOD>  12-03-2007        </FECHAMOD>
<AUTORMOD>  Zenén Muñoz H. </AUTORMOD>
<VERSIONMOD> 1.9           </VERSIONMOD>
<DESCMOD>  Cambios en la tabla NP_DETSER_ACTVTA_MAYORISTAS_TO, donde se redondea el valor Neto de SCL, según los valores de Venta público y descuento. Inc .38455
           Además se incorpora el parámetro: 'DURACIÓN DE SERIES INACTIVAS SELECCIONADAS(24/valor)'</DESCMOD>
<VERSIONMOD> 1.10           </VERSIONMOD>
<DESCMOD>  Cambios en el PL: NP_GESTOR_MAYORISTAS_PG, procedimiento NP_ALAMCENA_SERIE_PEDIDO_PR, donde se cambia la forma de grabar en la tabla: NP_DETVTA_NPW_DESCUENTO_TO.
 Inc. 38518 </DESCMOD>
<VERSIONMOD> 1.11           </VERSIONMOD>
<AUTORMOD>  Zenén Muñoz H. </AUTORMOD>
<DESCMOD>  Cambios en el PL's: NP_ALAMCENA_SERIE_PEDIDO_PR y NP_ALAMCENASERIE_NUEVA_PR, donde no se controlaba que un cliente tuviera más de un usuario. Ahora el usuario se obtiene del pedido
 Inc. 39457 </DESCMOD>
<FECHAMOD>  13-04-2007        </FECHAMOD>

<VERSIONMOD> 2.0           </VERSIONMOD>
<AUTORMOD>  Jubitza Villanueva Garrido</AUTORMOD>
<DESCMOD>  P-COL-07002 Fase 2 de mayoristas. (P-MIX-06003-G3LOG) </DESCMOD>
<FECHAMOD>  19-04-2007        </FECHAMOD>

<VERSIONMOD> 2.0           </VERSIONMOD>
<AUTORMOD>  Jubitza Villanueva Garrido</AUTORMOD>
<DESCMOD>  P-COL-07002 Fase 2 de mayoristas. (P-MIX-06003-G3LOG) Scope-Change Equipo Costo Cero. Merge incidencia 37992</DESCMOD>
<FECHAMOD>  02-08-2007        </FECHAMOD>

<VERSIONMOD> 2.0           </VERSIONMOD>
<AUTORMOD>  Maritza Tapia Alvarez</AUTORMOD>
<DESCMOD>  MIX-07005 de mayoristas. </DESCMOD>
<FECHAMOD>  26-09-2007        </FECHAMOD>

*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_COSTO_MININO_FN
(EN_cod_articulo                 IN                             AL_ARTICULOS.COD_ARTICULO%TYPE,
 SN_monto_min                   OUT    NOCOPY    NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_COSTO_MININO_FN"
      Lenguaje="PL/V_sSql"
      Fecha="02-08-2007"
      Versión="1.0"
      Diseñador="Jubitza Villanueva G.
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener el costo mínimo de una serie</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_cod_articulo"   Tipo="NUMERICO">Código de artículo</param>
            </Entrada>
         <Salida>
            <param nom="SN_monto_min"   Tipo="NUMERICO">Monto mínimo</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;
LV_tip_terminal            al_articulos.tip_terminal%TYPE;
LV_valor          ged_parametros.val_parametro%TYPE;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
        SV_mens_retorno:=NULL;
        SN_monto_min:=0;
  LV_tip_terminal:=NULL;

     LV_V_sSql:='SELECT b.TIP_TERMINAL INTO LV_tip_terminal '||
                                  ' FROM AL_ARTICULOS B '||
                                        ' WHERE B.COD_ARTICULO='||EN_cod_articulo;

        SELECT B.TIP_TERMINAL INTO LV_tip_terminal
          FROM AL_ARTICULOS B
         WHERE B.COD_ARTICULO=EN_cod_articulo;

        LV_valor:=NULL;
     LV_V_sSql:='IF LV_tip_terminal=''D'' or LV_tip_terminal=''T'' THEN';
        IF LV_tip_terminal='D' OR LV_tip_terminal='T' THEN ---es terminal
           LV_V_sSql:='SELECT A.VAL_PARAMETRO INTO LV_valor '||
                            'FROM GED_PARAMETROS A '||
                                                    'WHERE A.NOM_PARAMETRO=''MAY_MIN_EQUIPO'''||
                                                    ' AND A.COD_MODULO='||CV_cod_modulo||' AND A.COD_PRODUCTO=1';
                    SELECT A.VAL_PARAMETRO INTO LV_valor
                      FROM GED_PARAMETROS A
                     WHERE A.NOM_PARAMETRO='MAY_MIN_EQUIPO'
                          AND A.COD_MODULO=CV_cod_modulo
                                AND A.COD_PRODUCTO=1;

        ELSE
           LV_V_sSql:='IF LV_tip_terminal=''G''';
           IF LV_tip_terminal='G' THEN--es simcard....
                 LV_V_sSql:='SELECT A.VAL_PARAMETRO INTO LV_valor '||
                               'FROM GED_PARAMETROS A '||
                                                       'WHERE A.NOM_PARAMETRO=''MAY_MIN_SIMCARD'''||
                                                       ' AND A.COD_MODULO='||CV_cod_modulo||' AND A.COD_PRODUCTO=1';
                                SELECT A.VAL_PARAMETRO INTO LV_valor
                                  FROM GED_PARAMETROS A
                                 WHERE A.NOM_PARAMETRO='MAY_MIN_SIMCARD'
                                      AND A.COD_MODULO=CV_cod_modulo
                                            AND A.COD_PRODUCTO=1;
                    END IF;
        END IF;

        LV_V_sSql:='LV_valor:=TRIM(LV_valor)';
        LV_valor:=TRIM(LV_valor);
        LV_V_sSql:='IF LV_valor IS NOT NULL THEN';
        IF LV_valor IS NOT NULL THEN
           LV_V_sSql:='LV_valor:=TO_NUMBER(LV_valor)';
     LV_valor:=TO_NUMBER(LV_valor);
                    SN_monto_min:=LV_valor;
     END IF;

        RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_COSTO_MININO_FN('||EN_cod_articulo||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_COSTO_MININO_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_COSTO_MININO_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_CLIENTE_MAYORISTA_PR
(EN_cliente         IN npt_pedido.cod_cliente%TYPE,
 SN_EstadoCliente   OUT NOCOPY     NUMBER,
 SC_Error           OUT NOCOPY     VARCHAR2
)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_CLIENTE_MAYORISTA_PR" Lenguaje="PL/V_sSql" Fecha="06-11-2006" Versión="1.0" Diseñador="****" Programador="Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, que permite determinar si un cliente es o no un Mayorista</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_cliente" Tipo="NUMBER">Código de Cliente SCL </param>
    </Entrada>
    <Salida>
        <param nom="SN_EstadoCliente" Tipo="NUMBER">1: Cliente mayorista, 0:No es mayorista</param>
        <param nom="SC_Error" Tipo="STRING">Error en el PL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

   ERROR_DEMOSTRACION EXCEPTION;
   LV_cod_tipcomis_may ve_vendedores.cod_tipcomis%TYPE;
   LV_cod_tipcomis     ve_vendedores.cod_tipcomis%TYPE;
   LN_mayorista        NUMBER;

BEGIN
   SC_Error := '';
     BEGIN
       SELECT a.cod_valor
       INTO LV_cod_tipcomis_may
       FROM  ged_codigos a
       WHERE a.cod_modulo = 'VE'
       AND a.nom_tabla = 'VE_TIPCOMIS'
       AND a.nom_columna = 'COD_TIPCOMIS';
            EXCEPTION
             WHEN NO_DATA_FOUND THEN
           SC_Error := 'No existe parámetro para identificar a Cliente Mayorista';
                   SN_EstadoCliente := 0;
           LV_cod_tipcomis_may :='';

     END;

     IF LV_cod_tipcomis_may ='' THEN
             SN_ESTADOCLIENTE := 2;
         RAISE  ERROR_DEMOSTRACION;
          ELSE
       SELECT COUNT(DISTINCT a.cod_tipcomis)
       INTO LN_mayorista
       FROM ve_vendedores a
       WHERE a.cod_cliente = EN_cliente;

       IF LN_mayorista = 1 THEN
         SELECT DISTINCT a.cod_tipcomis
         INTO LV_cod_tipcomis
         FROM ve_vendedores a
         WHERE a.cod_cliente = EN_cliente;

         IF LV_cod_tipcomis <> LV_cod_tipcomis_may THEN
            SN_ESTADOCLIENTE := 0;
            RAISE  ERROR_DEMOSTRACION;
         END IF;
             SN_ESTADOCLIENTE := 1;
           ELSE
             SN_ESTADOCLIENTE := 0;
       END IF;
         END IF;

EXCEPTION
    WHEN ERROR_DEMOSTRACION THEN
        IF SN_ESTADOCLIENTE = 0 THEN
       SC_Error := 'Tipo de comisionista de Cliente, no corresponde a un Cliente Mayorista';
       SN_ESTADOCLIENTE :=2;
    END IF;
        IF SN_ESTADOCLIENTE = 2 THEN
       SC_Error := 'Cliente, posee más de un tipo de comisión';
       SN_ESTADOCLIENTE :=2;
    END IF;
    WHEN OTHERS THEN
        SN_ESTADOCLIENTE :=0;
        SC_Error := SQLCODE || ' - ' || SQLERRM;

END NP_CLIENTE_MAYORISTA_PR;

PROCEDURE NP_MONTO_DESSUGERIDO_PR
(EN_cliente          IN npt_pedido.cod_cliente%TYPE,
 EN_codArticulo      IN npt_detalle_pedido.cod_articulo%TYPE,
 EN_MontoDescuento   IN      NUMBER,
 EN_SecSerie         IN      NUMBER,
 EN_NumLinea         IN      NUMBER,
 SN_MontoSugerido    OUT NOCOPY     NUMBER,
 SN_CantidadSeries   OUT NOCOPY     NUMBER,
 SC_Error            OUT NOCOPY     VARCHAR2
)

IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_MONTO_DESSUGERIDO_PR" Lenguaje="PL/V_sSql" Fecha="06-11-2006" Versión="1.0" Diseñador="****" Programador="Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, que permite recuperar el monto de descuento sugerido para un Mayorista</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_cliente" Tipo="NUMBER">Código de Cliente SCL </param>
        <param nom="EN_codArticulo" Tipo="NUMBER">Código de Artículo SCL </param>
        <param nom="EN_MontoDescuento" Tipo="NUMBER">Monto de descuento sugerigo por usuario a descontar </param>
        <param nom="EN_SecSerie" Tipo="NUMBER">Secuencia de pedido que se esta ingresando al mayorista</param>
        <param nom="EN_NumLinea" Tipo="NUMBER">Número de la línea del pedido</param>
    </Entrada>
    <Salida>
        <param nom="SN_MontoSugerido" Tipo="NUMBER">Monto de descuento sugerigo por el PL a descontar</param>
        <param nom="SN_CantidadSeries" Tipo="NUMBER">Cantidad de series a descontar, según monto</param>
        <param nom="SC_Error" Tipo="STRING">Error en el PL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

   LV_cod_tipcomis_may ve_vendedores.cod_tipcomis%TYPE;
   LV_cod_tipcomis     ve_vendedores.cod_tipcomis%TYPE;
   LN_DesMayorista     NUMBER := 0;
   LN_DesMayoristaSg   NUMBER := 0;
   LN_CantSer          NUMBER := 0;

CURSOR leemonto IS
  SELECT num_serie, (mto_neto_ped - mto_neto_scl) diferencia
         FROM NP_DETSER_ACTVTA_MAYORISTAS_TO
   WHERE cod_cliente = EN_cliente
   AND cod_estado = 'PE'
   AND cod_articulo = EN_codArticulo
   AND mto_neto_ped > mto_neto_scl /*Omite los valores negativos para descuentos*/
   AND num_serie NOT IN (SELECT num_serie FROM NP_SERIES_MARCADAS_TO WHERE cod_cliente = EN_cliente)
   ORDER BY diferencia, num_serie;

BEGIN

DELETE NP_SERIES_MARCADAS_TO
WHERE COD_CLIENTE = EN_cliente
AND EN_SecSerie = IND_KEY
AND EN_NumLinea = LIN_DET_PEDIDO;

   FOR vleemonto IN  leemonto LOOP
       LN_DesMayorista := LN_DesMayorista +  vleemonto.diferencia;
       IF  LN_DesMayorista <= EN_MontoDescuento THEN
           LN_DesMayoristaSg := LN_DesMayorista;
           LN_CantSer := LN_CantSer + 1 ;
           BEGIN
              INSERT INTO NP_SERIES_MARCADAS_TO
              VALUES (EN_SecSerie, EN_NumLinea, vleemonto.num_serie, EN_cliente, EN_codArticulo, 1, vleemonto.diferencia, SYSDATE);
              EXCEPTION
                 WHEN DUP_VAL_ON_INDEX THEN
                      NULL;
           END;
       ELSE
           LN_DesMayorista := LN_DesMayorista -  vleemonto.diferencia;
       END IF;
   END LOOP;

   SN_MontoSugerido := LN_DesMayoristaSg;
   SN_CantidadSeries := LN_CantSer ;

EXCEPTION
    WHEN OTHERS THEN
        SC_Error := SQLCODE || ' - ' || SQLERRM;
        SN_MontoSugerido  := 0;
        SN_CantidadSeries := 0;

END NP_MONTO_DESSUGERIDO_PR;


PROCEDURE NP_ALAMCENA_SERIE_PEDIDO_PR
(EN_CodPedido        IN npt_pedido.cod_pedido%TYPE,
 EN_cliente          IN npt_pedido.cod_cliente%TYPE,
 EN_SecSerie         IN      NUMBER,
 SC_Error            OUT NOCOPY     VARCHAR2
)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_ALAMCENA_SERIE_PEDIDO_PR" Lenguaje="PL/V_sSql" Fecha="06-11-2006" Versión="1.0" Diseñador="****" Programador="Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, que permite almacenar las series que se consideran en el descuento de un pedido, y que corresponden a un mayorista</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_CodPedido" Tipo="NUMBER">Código del pedido actual del mayorista</param>
        <param nom="EN_cliente" Tipo="NUMBER">Código de Cliente SCL </param>
        <param nom="EN_SecSerie" Tipo="NUMBER">Secuencia de pedido que se esta ingresando al mayorista</param>
    </Entrada>
    <Salida>
        <param nom="SC_Error" Tipo="STRING">Error en el PL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

CURSOR leeDetVenta IS
   SELECT COD_ARTICULO, LIN_DET_PEDIDO, CAN_DETALLE_PEDIDO, MTO_UNI_DET_PEDIDO,
          PTJ_DES_DET_PEDIDO, MTO_NET_DET_PEDIDO, MTO_DES_DET_PEDIDO
   FROM npt_detalle_pedido a
   WHERE a.cod_pedido =  EN_CodPedido;

CURSOR leeDetSeries(EN_LINDET NUMBER) IS
   SELECT a.NUM_SERIE, a.LIN_DET_PEDIDO, COD_PEDIDO,  b.MTO_NETO_SCL, b.MTO_NETO_PED, MTO_DIFSERIE
   FROM NP_SERIES_MARCADAS_TO a, NP_DETSER_ACTVTA_MAYORISTAS_TO b
   WHERE a.cod_cliente = EN_cliente
   AND a.IND_KEY = EN_SecSerie
   AND a.LIN_DET_PEDIDO = EN_LINDET
   AND a.num_serie = b.num_serie
-- Incidencia 35518
   AND b.COD_ESTADO = 'AP';
-- fin Incidencia 35518

LS_usuario psd_usuario.UID_USUARIO%TYPE;

LN_ExisteSerieMay     NUMBER;
LN_MTOLINEA           NUMBER;
LN_SecMayorista       NUMBER;
LN_Pedido             npt_pedido.cod_pedido%TYPE;
LV_CADENA             VARCHAR2(150);

BEGIN

-- En incidencia: 38518, se agrega el literal: LV_CADENA, en el que se almacena
-- el detalle de los movimientos en el procedimiento.

  SELECT MAX(UPPER(UID_USUARIO)) INTO LS_usuario
  FROM psd_usuario
-- Inicio 39457 Z.M.H. 13-04-2007, cambio al obtener el código del usuario antes se obtenía según el Cliente
  WHERE cod_usuario  = (SELECT COD_USUARIO_CRE FROM npt_pedido
                        WHERE cod_pedido = EN_CodPedido);
-- Fin 39457

  SELECT MAX(cod_pedido) INTO LN_Pedido
  FROM NP_DETSER_ACTVTA_MAYORISTAS_TO
  WHERE cod_cliente = EN_cliente
  AND num_serie IN (SELECT num_serie FROM NP_SERIES_MARCADAS_TO
  WHERE cod_cliente =  EN_cliente
  AND ind_key = EN_SecSerie);


  UPDATE NP_DETSER_ACTVTA_MAYORISTAS_TO SET
    COD_ESTADO = 'AP',
    COD_USUARIO = LS_usuario,
    FEC_MOVIMIENTO = SYSDATE
    WHERE cod_cliente = EN_cliente
    AND num_serie IN (SELECT num_serie FROM NP_SERIES_MARCADAS_TO
    WHERE cod_cliente =  EN_cliente AND ind_key = EN_SecSerie)
-- Incidencia 35518
    AND COD_ESTADO = 'PE';
-- Fin 35518

  LV_CADENA := 'np_hist_movim_series_to ' || EN_SecSerie || ' - ' || EN_CodPedido;
  INSERT INTO np_hist_movim_series_to
  (cod_cliente, num_serie, fec_movimiento, cod_estado,
   cod_motivo, cod_pedido, cod_usuario, cod_estadoorigen)
  SELECT EN_cliente, num_serie, SYSDATE, 'AP', 0, LN_Pedido, USER, 'PE'
  FROM NP_SERIES_MARCADAS_TO
  WHERE cod_cliente =  EN_cliente
  AND ind_key = EN_SecSerie;

  LV_CADENA := 'NP_ENCVTA_MAYORISTA_TO ' || EN_SecSerie || ' - ' || EN_CodPedido;
  INSERT INTO NP_ENCVTA_MAYORISTA_TO
    SELECT EN_cliente, cod_pedido, COD_ARTICULO, LIN_DET_PEDIDO, CAN_DETALLE_PEDIDO, 0
    FROM npt_detalle_pedido
    WHERE cod_pedido =  EN_CodPedido;

  SELECT COUNT(1) INTO LN_ExisteSerieMay
  FROM NP_SERIES_MARCADAS_TO
  WHERE cod_cliente = EN_cliente
  AND IND_KEY = EN_SecSerie;

  IF LN_ExisteSerieMay > 0 THEN
     SELECT NP_VENTAMAYOR_SQ.NEXTVAL INTO LN_SecMayorista FROM dual;

     FOR vleeDetVenta IN  leeDetVenta LOOP
         SELECT NVL(SUM(MTO_DIFSERIE), 0) INTO LN_MTOLINEA
         FROM NP_SERIES_MARCADAS_TO
         WHERE cod_cliente = EN_cliente
         AND IND_KEY = EN_SecSerie
         AND LIN_DET_PEDIDO = vleeDetVenta.LIN_DET_PEDIDO;

         IF LN_MTOLINEA  > 0 THEN
            LV_CADENA := 'NP_DETVTA_MAYORISTA_TO ' || EN_SecSerie || ' - ' || EN_CodPedido;
            INSERT INTO NP_DETVTA_MAYORISTA_TO
               (COD_VTA_MAY, COD_CLIENTE, COD_PEDIDO, COD_ARTICULO, LIN_DET_PEDIDO,
                CAN_ARTICULO, MTO_NETO_NPW, PJE_DESC_CLIE, MTO_NETO_PED, MTO_DESC_MAY)
            VALUES
              (LN_SecMayorista, EN_cliente, EN_CodPedido, vleeDetVenta.COD_ARTICULO, vleeDetVenta.LIN_DET_PEDIDO,
              vleeDetVenta.CAN_DETALLE_PEDIDO, vleeDetVenta.MTO_UNI_DET_PEDIDO,
              vleeDetVenta.PTJ_DES_DET_PEDIDO,  vleeDetVenta.MTO_NET_DET_PEDIDO, LN_MTOLINEA );

           FOR VleeDetSeries IN leeDetSeries(vleeDetVenta.LIN_DET_PEDIDO) LOOP
              LV_CADENA := 'NP_DETVTA_NPW_DESCUENTO_TO ' || EN_SecSerie  || ' - ' || EN_CodPedido;
              INSERT INTO NP_DETVTA_NPW_DESCUENTO_TO
              (COD_VTA_MAY, NUM_SERIE, COD_PEDIDO_ORIGEN, LIN_DET_PEDIDO, MTO_NETO_PED,
               PJE_DESC_CLIE, MTO_NETO_CDES, MTO_NETO_SCL, MTO_DESC_MAY)
              SELECT LN_SecMayorista, VleeDetSeries.NUM_SERIE, VleeDetSeries.COD_PEDIDO, VleeDetSeries.LIN_DET_PEDIDO,
-- Inicio 38412
--                     (MTO_UNI_DET_PEDIDO - MTO_DES_DET_PEDIDO), PTJ_DES_DET_PEDIDO, MTO_DES_DET_PEDIDO,
                     (MTO_UNI_DET_PEDIDO - (MTO_UNI_DET_PEDIDO * PTJ_DES_DET_PEDIDO/100)), PTJ_DES_DET_PEDIDO, MTO_DES_DET_PEDIDO,
-- Fin 38412
                     vleeDetSeries.MTO_NETO_SCL, VleeDetSeries.MTO_DIFSERIE
              FROM npt_detalle_pedido
              WHERE cod_pedido = EN_CodPedido
-- Incidencia 35518
              AND   LIN_DET_PEDIDO = vleeDetVenta.LIN_DET_PEDIDO;
-- Fin 35518
           END LOOP;
         END IF;
     END LOOP;

     DELETE FROM NP_SERIES_MARCADAS_TO
     WHERE cod_cliente = EN_cliente
     AND IND_KEY = EN_SecSerie;

  END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        SC_Error := SQLCODE || ' - ' || SQLERRM || ' - ' || LV_CADENA;

END NP_ALAMCENA_SERIE_PEDIDO_PR;


PROCEDURE NP_ACTUALIZAESTADOSERIE_PR(
 ES_SERIE            IN NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE,
 EN_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
 EC_Error            OUT NOCOPY VARCHAR2
)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_ACTUALIZAESTADOSERIE_PR" Lenguaje="PL/V_sSql" Fecha="06-11-2006" Versión="1.0" Diseñador="****" Programador="Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, que permite actualizar el estado de las series de un pedido Mayorista - desde p_ga_respuesta</Descripción>
<Parámetros>
    <Entrada>
        <param nom="ES_SERIE" Tipo="VARCHAR">Serie del pedido mayorista</param>
        <param nom="EN_ABONADO" Tipo="NUMBER">Número del abonado que esta en la serie. </param>
    </Entrada>
    <Salida>
        <param nom="SC_Error" Tipo="STRING">Error en el PL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_CLIENTE           NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_CLIENTE%TYPE;
LN_PEDIDO            NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_PEDIDO%TYPE;
LN_DET_PEDIDO        NP_ENCVTA_MAYORISTA_TO.LIN_DET_PEDIDO%TYPE;
LN_ARTICULO          npt_detalle_pedido.COD_ARTICULO%TYPE;
LN_NUMVTA            npt_pedido.NUM_DOC_PEDIDO%TYPE;
LN_numventa             ga_abocel.num_venta%TYPE;
LN_MTODESCLIN        npt_detalle_pedido.MTO_NET_DET_PEDIDO%TYPE;
LN_MTONETLIN         npt_detalle_pedido.MTO_NET_DET_PEDIDO%TYPE;
LN_EstadoCliente     NUMBER;
LN_TipoCliente       NUMBER := 0;
LN_SerIme            NUMBER := 0;
LC_Error             VARCHAR(200);
LN_MTONETOSCL        NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE :=0;
LN_MTODESCUENTO      NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE :=0;
LN_STOCK             npt_detalle_pedido.TIP_STOCK%TYPE;
LN_USO               npt_detalle_pedido.COD_USO%TYPE;
LN_ESTADO            npt_detalle_pedido.COD_ESTADO%TYPE;
LS_SERIE             NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE;
LS_SERIE1            NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE := '';
LS_IMEI              ga_abocel.NUM_IMEI%TYPE;
LN_ABONADO              GA_ABOCEL.NUM_ABONADO%TYPE;
LV_plantarif         ga_abocel.cod_plantarif%TYPE;
LV_tipcontrato         ga_abocel.cod_tipcontrato%TYPE;
LN_modventa             ga_abocel.cod_modventa%TYPE;
LS_tipoprod             NUMBER;
LN_TpoVenta               VARCHAR(2);
LN_causa_venta         ga_abocel.COD_CAUSA_VENTA%TYPE;
LN_operacion         ga_abocel.COD_OPERACION%TYPE;
LN_cod_tiplan         ta_plantarif.COD_TIPLAN%TYPE;
LN_ind_externa         VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
LN_tipdcto             gad_descuentos.TIP_DESCUENTO%TYPE;
LN_profact             al_promfact.COD_PROMEDIO%TYPE;
LN_Registros         NUMBER(2):=0;

--Inicio Costo Cero
LN_monto_neto_scl    NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE;
LN_cod_retorno       ge_errores_pg.CodError;
LV_mens_retorno      ge_errores_pg.MsgError;
LN_num_evento        ge_errores_pg.Evento;
--Fin Costo Cero

LV_comisRetail      ga_ventas.cod_tipcomis%TYPE;          -- MIX-07005 11-09-2007
LV_EstadoSerie      NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE;  -- MIX-07005 11-09-2007
LN_cod_vendedor     ve_vendedores.cod_vende_raiz%TYPE;  -- MIX-07005 11-09-2007
LN_ind_canal        NP_DETSER_ACTVTA_MAYORISTAS_TO.ind_Canal%TYPE;  -- MIX-07005 11-09-2007


LV_moneda                                                ged_parametros.VAL_PARAMETRO%TYPE;
LV_categoria                                    ve_categorias.cod_categoria%TYPE;
LN_meses                                                    ga_percontrato.num_meses%TYPE;
LN_vendedor_vta                        ga_ventas.cod_vendedor%TYPE;
LN_cod_conceptoart   al_articulos.cod_conceptoart%TYPE;
LV_tipcomis                ga_ventas.cod_tipcomis%TYPE;

LV_error             VARCHAR2(200);
LV_des_error            ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;
SN_cod_retorno       ge_errores_pg.CodError;
SV_mens_retorno      ge_errores_pg.MsgError;
SN_num_evento        ge_errores_pg.Evento;


BEGIN

  LC_Error :='Obtiene datos de GA_ABOAMIST-GA_ABOCEL-TA_PLANTARIF ';
  SELECT 1 tipoprod, a.cod_modventa, a.cod_uso, a.COD_TIPCONTRATO, a.COD_PLANTARIF, 'VP' TpoVenta, a.COD_CAUSA_VENTA, a.COD_OPERACION, b.COD_TIPLAN
               ,a.num_serie, a.num_imei,  a.num_venta,a.cod_vendedor, 1
   INTO LS_tipoprod, LN_modventa, LN_USO, LV_TIPCONTRATO, LV_PLANTARIF, LN_TpoVenta, LN_CAUSA_VENTA, LN_operacion, LN_COD_TIPLAN
        ,LS_SERIE, LS_IMEI,LN_numventa,LN_cod_vendedor,LN_TipoCliente
            FROM ga_aboamist a, ta_plantarif b
   WHERE a.num_abonado   = EN_ABONADO AND
         a.COD_PLANTARIF = b.COD_PLANTARIF
   UNION
   SELECT 2 tipoprod, a.cod_modventa, a.cod_uso, a.COD_TIPCONTRATO, a.COD_PLANTARIF,
             DECODE(a.cod_uso, 2, 'VE', 'VD') TpoVenta, a.COD_CAUSA_VENTA, a.COD_OPERACION, b.COD_TIPLAN
               ,a.num_serie, a.num_imei,  a.num_venta,a.cod_vendedor, 2
   FROM ga_abocel a, ta_plantarif b
   WHERE a.num_abonado   = EN_ABONADO AND
         a.COD_PLANTARIF = b.COD_PLANTARIF AND
         b.COD_TIPLAN    = GN_tiplan_pos
   UNION
   SELECT 3 tipoprod, a.cod_modventa, a.cod_uso, a.COD_TIPCONTRATO, a.COD_PLANTARIF,
             DECODE(a.cod_uso, 2, 'VE', 'VD') TpoVenta, a.COD_CAUSA_VENTA, a.COD_OPERACION, b.COD_TIPLAN
               ,a.num_serie, a.num_imei,  a.num_venta,a.cod_vendedor, 2
   FROM ga_abocel a, ta_plantarif b
   WHERE a.num_abonado   = EN_ABONADO AND
         a.COD_PLANTARIF = b.COD_PLANTARIF AND
         b.COD_TIPLAN    = GN_tiplan_hib;


    -- INI 37992  Jonathan Ledesma  31/07/2007
    IF LS_tipoprod = 1 AND LN_CAUSA_VENTA IS NULL THEN
    LC_Error :='SELECT val_parametro FROM ged_parametros WHERE nom_parametro=COD_CAUSA_DSCTO_AMI';
    SELECT val_parametro
            INTO  LN_CAUSA_VENTA
           FROM  ged_parametros
           WHERE nom_parametro = 'COD_CAUSA_DSCTO_AMI'
            AND cod_modulo = 'GA'
           AND cod_producto = 1;
    END IF;
    -- FIN 37992  Jonathan Ledesma  31/07/2007

-- MIX-07005 11-09-2007
-- -- Tipo de comisionista retail parametrizado
   LC_Error :='SELECT a.val_parametro FROM ged_parametros a WHERE a.nom_parametro=TIP_COMISRET';
   SELECT a.val_parametro
   INTO LV_comisRetail
   FROM ged_parametros a
   WHERE a.nom_parametro ='TIP_COMISRET';
-- FIN MIX-07005 11-09-2007

    --Obtener moneda--
 LC_Error :='SELECT trim(a.val_parametro) FROM ged_parametros a WHERE a.nom_parametro='''||GV_MONEDALOCAL||'';
    SELECT trim(a.val_parametro) into LV_moneda
      FROM ged_parametros a
  WHERE a.nom_parametro=GV_MONEDALOCAL;

    --Obtener categoria del plan
    LC_Error :='SELECT a.cod_categoria FROM ve_catplantarif a WHERE a.cod_plantarif = '||LV_plantarif;
    SELECT a.cod_categoria into LV_categoria
   FROM ve_catplantarif a
  WHERE a.cod_plantarif = LV_plantarif;

    --Obtener nro de meses,,,
    LC_Error :='SELECT a.num_meses meses FROM ga_percontrato a WHERE a.cod_producto > 0  AND a.cod_tipcontrato = '||LV_tipcontrato;
    SELECT a.num_meses meses into LN_meses
      FROM ga_percontrato a
        WHERE a.cod_producto > 0  AND
        a.cod_tipcontrato = LV_tipcontrato;

    --Datos de la venta....
 LC_Error :='SELECT a.cod_vendedor FROM GA_VENTAS a  WHERE a.NUM_VENTA='||LN_numventa;
        SELECT a.cod_vendedor
        INTO LN_vendedor_vta
        FROM GA_VENTAS a
        WHERE a.NUM_VENTA = LN_numventa;

        LC_Error :='select a.COD_TIPCOMIS  FROM ve_vendedores a WHERE a.cod_vendedor ='||LN_vendedor_vta;
        select a.COD_TIPCOMIS
        INTO LV_tipcomis
        FROM ve_vendedores a
        WHERE a.cod_vendedor = LN_vendedor_vta;

        LC_Error :='SELECT a.IND_VTA_EXTERNA FROM VE_TIPCOMIS a WHERE a.COD_TIPCOMIS ='||LV_tipcomis;
        SELECT a.IND_VTA_EXTERNA
        INTO LN_ind_externa
        FROM VE_TIPCOMIS a
        WHERE a.COD_TIPCOMIS = LV_tipcomis;


WHILE LN_SerIme < 2 LOOP
  LN_SerIme := LN_SerIme + 1;
  -- Inicio de validacion por serie
  IF LN_SerIme = 2 THEN
     LS_SERIE := LS_IMEI;
     LC_Error := 'serie 2';
  END IF;
  -- fin cambio de serie a validar
  BEGIN
      SELECT a.cod_cliente
        INTO ln_cliente
        FROM npt_pedido a
       WHERE a.cod_pedido = (SELECT MAX(a.cod_pedido)
                                  FROM npt_serie_pedido a
                              WHERE a.cod_serie_pedido = ls_serie); --and
             --a.num_doc_pedido > 0;
       lc_error := 'cliente';
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
        ln_cliente := 0;
  END;


            NP_CLIENTE_MAYORISTA_PR (LN_CLIENTE, LN_EstadoCliente,  LC_Error);
            LC_Error:='valida cliente mayorista';


   IF (LN_EstadoCliente = GN_MAYORISTA) OR (TRIM(LV_tipcomis) = TRIM(LV_comisRetail)) THEN
      LC_Error := 'select npt_serie_pedido, Serie ' || LS_SERIE || ' Cliente ' || LN_CLIENTE;

               -- Rescata el último pedido y línea a la que pertenece la serie.
                 SELECT a.cod_pedido, a.lin_det_pedido
                      INTO LN_PEDIDO, LN_DET_PEDIDO
                   FROM npt_serie_pedido a
                  WHERE a.cod_serie_pedido = LS_SERIE     AND
                        a.cod_pedido      IN (SELECT MAX(b.cod_pedido)
                                                          FROM npt_serie_pedido b, npt_pedido c
                                                                                                    WHERE c.cod_cliente      = LN_CLIENTE   AND
                                                                                                                                     b.cod_pedido       = c.cod_pedido AND
                                                                                                                                           b.cod_serie_pedido = LS_SERIE);

     -- Actualiza la tabla encabezado de mayoristas, en dos
     LC_Error := 'Update NP_ENCVTA_MAYORISTA_TO, Serie ' || LS_SERIE || ' Cliente ' || LN_CLIENTE;
     UPDATE np_encvta_mayorista_to
           SET can_series_act = can_series_act + 1
      WHERE cod_pedido        = LN_pedido     AND
       lin_det_pedido = LN_det_pedido AND
        cod_cliente    = LN_cliente;

     LC_Error := 'select npt_detalle_pedido, Pedido ' || LN_PEDIDO || ' Línea ' || LN_DET_PEDIDO;
     SELECT cod_articulo, (mto_uni_det_pedido - mto_des_det_pedido), mto_net_det_pedido, tip_stock,cod_estado
       INTO LN_articulo, LN_mtodesclin, LN_mtonetlin, LN_stock, LN_estado
       FROM npt_detalle_pedido
      WHERE cod_pedido     = LN_pedido AND
                                          lin_det_pedido = LN_det_pedido;

        LC_Error := 'select npt_pedido, Pedido ' || LN_PEDIDO;
     SELECT NUM_DOC_PEDIDO INTO LN_NUMVTA
       FROM npt_pedido WHERE COD_PEDIDO = LN_PEDIDO;

    -- Se comenta por incidencia: 38275 Promedio de facturacion ' || LN_cliente;

        IF trim(LV_tipcomis) = trim(LV_comisRetail) THEN -- inicio MIX-07005 11-09-2007
           --Si retail, obtiene el precio desde la nueva matriz de precio.
                    LN_ind_canal := 1;
                        BEGIN
                                         LV_estadoserie :='PE';
                             LC_Error := 'Rescata Precio de Venta Retail, Pedido ' || LN_PEDIDO || ' Articulo ' || LN_ARTICULO ;
                                         SELECT a.precio_articulo
                                                                INTO ln_mtonetoscl
                                                                FROM AL_PRECIOS_RETAIL_TD a
                                                            WHERE a.cod_Vendedor = LN_cod_vendedor
                                                                 AND a.cod_Articulo = LN_articulo
                                      AND    SYSDATE BETWEEN a.fec_desde  AND NVL(a.fec_hasta, SYSDATE)
                                                                    AND a.cod_uso       = ln_uso    --USO DE LA VENTA...
                                                                    AND a.cod_estado    = ln_estado
                                                           AND    a.cod_categoria = LV_categoria
                                                                    AND    a.NUM_MESES        = LN_meses
                                                                    AND    a.ind_recambio  = 0;

                        EXCEPTION
                        WHEN OTHERS THEN
                            ln_mtonetoscl := 0;
                                  LV_estadoserie :=CV_SP;
                     END;

                           --NO APLICA DESCUENTOS AUTOMATICOS...
                                 ln_mtodescuento := 0;

       ELSE
                     LN_ind_canal := 0;
                     LV_estadoserie :='PE';
                     BEGIN
                          LC_Error := ' Rescata Precio de Venta, Pedido ' || LN_PEDIDO || ' Articulo ' || LN_ARTICULO ;
                       IF LN_TipoCliente = 1 THEN
                                    SELECT DISTINCT NVL(a.prc_venta, 0)
                                                        INTO ln_mtonetoscl
                                      FROM al_precios_venta a
                                     WHERE a.tip_stock    = 2           AND --- financiado mayorista
                                            a.cod_articulo = ln_articulo AND
                                                  a.cod_uso      = ln_uso      AND--uso de la venta
                                            a.cod_estado   = ln_estado   AND
                                                                       SYSDATE BETWEEN a.fec_desde  AND NVL(a.fec_hasta, SYSDATE) AND
                                                                       a.cod_moneda   = LV_moneda AND
                                                                       a.cod_categoria= LV_Categoria AND
                            -- Se comenta por incidencia: 38275 COD_PROMEDIO Y COD_ANTIGUEDAD=0...
                                                                   a.NUM_MESES      = LN_meses              AND
                                                                   a.ind_recambio = GN_INDRECAMBIO;
                     ELSE
                                            SELECT a.prc_venta INTO ln_mtonetoscl
                                            FROM al_precios_venta a, al_articulos b
                                            WHERE a.tip_stock     = 2           AND--- financiado mayorista
                                                              a.cod_articulo  = LN_articulo AND
                                                                                      a.cod_uso       = ln_uso      AND
                                                                                      a.cod_estado    = ln_estado   AND
                                                                                      SYSDATE BETWEEN a.fec_desde   AND NVL(a.fec_hasta, SYSDATE) AND
                                                                                      a.ind_recambio  = 0           AND
                                                                                      a.cod_modventa  = LN_modventa AND
                                                                                      a.num_meses     = LN_meses AND
                                                                                      a.cod_categoria = LV_categoria AND
                            -- Se comenta por incidencia: 38275 COD_PROMEDIO Y COD_ANTIGUEDAD=0...
                                                                                      a.cod_uso      <> 3              AND
                                                                                      a.cod_articulo  = b.cod_articulo AND
                                                                                      b.ind_equiacc   = 'E';
                     END IF;

                     EXCEPTION
                        WHEN OTHERS THEN
                        ln_mtonetoscl := 0;
                     END;
                -- Fin AL_PRECIOS_VENTA

              --Inicio DESCUENTOS AUTOMÁTICOS....
                     LN_MTODESCUENTO := 0;
                        LN_tipdcto:=0;
               LC_Error := '1.- Descuento Serie -' ||LS_SERIE;
               Begin

                          SELECT a.cod_conceptoart into LN_cod_conceptoart
                            FROM al_articulos a
                           WHERE a.cod_articulo = LN_articulo;
               EXCEPTION
                     WHEN OTHERS THEN
                         LN_cod_conceptoart:=null;
                     END;

                      LC_Error := '2.- Descuento Serie -' || LS_SERIE;

                         BEGIN
                                       IF LN_ind_externa=1 THEN
                                                   SELECT a.val_descuento, a.TIP_DESCUENTO
                                                              INTO ln_mtodescuento, LN_tipdcto
                                            FROM gad_descuentos a
                                           WHERE a.cod_operacion         = LN_TpoVenta   AND-- tpoventa - 'VE'venta celular 'VP' venta prepago 'VD'venta dealer  --venta
                                                 a.cod_antiguedad        = '01'            AND-- no existe antiguedad
                                                 a.cod_tipcontrato_nuevo = lv_tipcontrato  AND-- tipo contrato
                                                 a.num_meses_nuevo             = LN_meses        AND
                                                 SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                                                 a.ind_vta_externa       = LN_ind_externa  AND/* sindventaext */
                                                 a.cod_vendealer         = LN_vendedor_vta AND
                                                 a.cod_causa_dscto       = ln_causa_venta  AND
                                                 a.cod_categoria         = LV_categoria    AND-- categoria del plan prepago
                                                 a.cod_modventa          = LN_modventa     AND -- mod venta
                                                 a.tip_producto          = ls_tipoprod     AND-- 1prepago 2 pospago - 3 hibrido
                                                 a.cod_concepto          = LN_cod_conceptoart AND  -- Concepto Articulo
                                                 a.clase_descuento       = 'CON';
                                                ELSE
                                       SELECT a.val_descuento, a.TIP_DESCUENTO
                                                           INTO ln_mtodescuento, LN_tipdcto
                                            FROM gad_descuentos a
                                           WHERE a.cod_operacion         = LN_TpoVenta    AND-- tpoventa - 'VE'venta celular 'VP' venta prepago 'VD'venta dealer  --venta
                                                    a.cod_antiguedad        = '01'            AND-- no existe antiguedad
                                                       a.cod_tipcontrato_nuevo = lv_tipcontrato  AND-- tipo contrato
                                                       a.num_meses_nuevo             = LN_meses        AND
                                                                                        SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                                                                                        a.ind_vta_externa       = LN_ind_externa  AND/* sindventaext */
                                                                                        a.cod_causa_dscto       = ln_causa_venta  AND
                                                                                        a.cod_categoria               = LV_categoria    AND-- categoria del plan prepago
                                                       a.cod_modventa                                     = LN_modventa     AND -- mod venta
                                                       a.tip_producto                                     = ls_tipoprod     AND-- 1prepago 2 pospago - 3 hibrido
                                                       a.cod_concepto                                     = LN_cod_conceptoart AND  -- Concepto Articulo
                                                 a.clase_descuento       = 'CON';
                                            END IF;
                 EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                              BEGIN
                                                               IF LN_ind_externa=1 THEN
                                                                   SELECT a.val_descuento, a.TIP_DESCUENTO
                                                                                       INTO ln_mtodescuento, LN_tipdcto
                                                                   FROM gad_descuentos a
                                                                  WHERE a.cod_operacion         = LN_TpoVenta   AND-- tpoventa - 'VE'venta celular 'VP' venta prepago 'VD'venta dealer  --venta
                                                                           a.cod_antiguedad        = '01'            AND-- no existe antiguedad
                                                                                             a.cod_tipcontrato_nuevo = lv_tipcontrato  AND-- tipo contrato
                                                                                             a.num_meses_nuevo                         = LN_meses        AND
                                                                                                                        SYSDATE    BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                                                                                                                        a.ind_vta_externa       = LN_ind_externa  AND/* sindventaext */
                                                                                                                        a.cod_vendealer         IS NULL           AND
                                                                                                                        a.cod_causa_dscto       = ln_causa_venta  AND
                                                                                                                        a.cod_categoria               = LV_categoria    AND-- categoria del plan prepago
                                                                                                                        a.cod_modventa                   = LN_modventa     AND -- mod venta
                                                                                                                        a.tip_producto                   = ls_tipoprod     AND-- 1prepago 2 pospago - 3 hibrido
                                                                                                                        a.cod_concepto                   = LN_cod_conceptoart AND  -- Concepto Articulo
                                                                                                                  a.clase_descuento       = 'CON';
                                                            ELSE
                                                                    SELECT a.val_descuento, a.TIP_DESCUENTO
                                                                         INTO ln_mtodescuento, LN_tipdcto
                                                                   FROM gad_descuentos a
                                                                  WHERE a.cod_operacion         = LN_TpoVenta    AND-- tpoventa - 'VE'venta celular 'VP' venta prepago 'VD'venta dealer  --venta
                                                                           a.cod_antiguedad        = '01'            AND-- no existe antiguedad
                                                                              a.cod_tipcontrato_nuevo = lv_tipcontrato  AND-- tipo contrato
                                                                              a.num_meses_nuevo             = LN_meses        AND
                                                                                                                        SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                                                                                                                        a.ind_vta_externa       = LN_ind_externa  AND/* sindventaext */
                                                                                                                        a.cod_causa_dscto       = ln_causa_venta  AND
                                                                                                                        a.cod_categoria         = LV_categoria    AND-- categoria del plan prepago
                                                                                                                     a.cod_modventa             = LN_modventa     AND -- mod venta
                                                                                                                     a.tip_producto             = ls_tipoprod     AND-- 1prepago 2 pospago - 3 hibrido
                                                                                                                     a.cod_concepto             = LN_cod_conceptoart AND  -- Concepto Articulo
                                                                                                               a.clase_descuento       = 'CON';
                                                                  END IF;
                                  EXCEPTION
                                     WHEN OTHERS THEN
                                          LN_mtodescuento := 0;
                                                                        LN_tipdcto:=0;
                                     END;
               WHEN OTHERS THEN
                    LN_mtodescuento := 0;
                                            LN_tipdcto:=0;
               END;
                        -- FIN DESCUENTOS AUTOMATICOS...

               LC_Error := 'Calculo descuento tipo ' || LN_tipdcto || ' descuento ' || ln_mtodescuento ;
                  if LN_tipdcto = 1 then
                        ln_mtodescuento := (ln_mtonetoscl * ln_mtodescuento);
                                    if ln_mtodescuento<>0 then
                                       ln_mtodescuento:=ln_mtodescuento/ 100;
                                    else
                                      ln_mtodescuento := 0;
                                    end if;
                     end if;

  END IF;



      --Inicio Costo Cero...
            LN_monto_neto_scl:=0;
            IF TRIM(LV_estadoserie)<>CV_SP THEN
                     LC_Error := 'LN_monto_neto_scl:= round(ln_mtonetoscl - ln_mtodescuento); ln_mtonetoscl=' || ln_mtonetoscl || ' ;ln_mtodescuento= ' || ln_mtodescuento;
               LN_monto_neto_scl:= ROUND(ln_mtonetoscl - ln_mtodescuento);

               IF LN_monto_neto_scl=0 THEN
                           LC_Error:='IF NOT NP_OBTENER_COSTO_MININO_FN(LN_articulo,LN_monto_neto_scl,LN_cod_retorno,LV_mens_retorno,LN_num_evento) THEN';
                                    IF NOT NP_OBTENER_COSTO_MININO_FN(LN_articulo,LN_monto_neto_scl,LN_cod_retorno,LV_mens_retorno,LN_num_evento) THEN
                                       LN_monto_neto_scl:=0;
                                    END IF;
               END IF;
            END IF;
   --Fin Costo Cero...


         LC_Error := 'update np_detser_actvta_mayoristas_to, Pedido=' || LN_PEDIDO || ', Serie=' || LS_SERIE || ', Cliente=' || ln_cliente;
      UPDATE NP_DETSER_ACTVTA_MAYORISTAS_TO SET
             cod_estado     = LV_estadoserie,
             num_venta      = ln_numventa,-- 38412
             cod_usuario    = USER,
             fec_movimiento = SYSDATE,
             mto_neto_ped   = ln_mtodesclin,
                            -- 38455
             mto_neto_scl     = LN_monto_neto_scl,  --Equipo Costo Cero...
                            --inicio p-mix-07005...
                            cod_vendedor = LN_cod_vendedor,
                            ind_canal      = LN_ind_canal,
          num_abonado    = EN_abonado,
       cod_Categoria  = LV_categoria,
       num_meses      = LN_meses,
       ind_recambio   = 0
                            --fin p-mix-07005...

      WHERE num_serie   = ls_serie   AND
                                          cod_cliente = ln_cliente AND
                                          cod_pedido  = ln_pedido;

     INSERT INTO np_hist_movim_series_to
     (cod_cliente, num_serie, fec_movimiento, cod_estado, cod_motivo, cod_pedido, cod_usuario, cod_estadoorigen)
     VALUES
     (LN_CLIENTE, LS_SERIE, SYSDATE, LV_estadoserie, 0, LN_PEDIDO, USER, 'NU');

   END IF;
END LOOP;

EXCEPTION
WHEN OTHERS THEN
    SV_mens_retorno:=NULL;
    SN_num_evento:=0;
    EC_Error:='';
                LV_V_sSql:=SUBSTR(LC_Error||SQLERRM,1,CN_largoquery);
                SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_ACTUALIZAESTADOSERIE_PR('||ES_serie||','||EN_abonado||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_ACTUALIZAESTADOSERIE_PR', LV_V_sSql, SQLCODE, LV_des_error );
       --  RAISE_APPLICATION_ERROR(-20299, LC_Error||' '||SQLERRM);
END NP_ACTUALIZAESTADOSERIE_PR;

PROCEDURE NP_ALAMCENASERIE_NUEVA_PR
(EN_CodPedido        IN npt_pedido.cod_pedido%TYPE,
 SC_Error            OUT NOCOPY     VARCHAR2
)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_ALAMCENASERIE_NUEVA_PR" Lenguaje="PL/V_sSql" Fecha="06-11-2006" Versión="1.0" Diseñador="****" Programador="Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, que permite almacenar series nuevas de un pedido mayorista</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_CodPedido" Tipo="NUMBER">Código del Pedido Mayorista</param>
    </Entrada>
    <Salida>
        <param nom="SC_Error" Tipo="STRING">Error en el PL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

CURSOR leeDetPedido IS
    SELECT * FROM NP_ENCVTA_MAYORISTA_TO
    WHERE cod_pedido = EN_CodPedido;


LS_usuario   psd_usuario.UID_USUARIO%TYPE;
LN_TIPARTI   al_articulos.TIP_ARTICULO%TYPE;

BEGIN

    FOR vleeDetPedido IN  leeDetPedido LOOP

-- Desripción del usuario que estya asociado al cliente del pedido
        SELECT MAX(UPPER(UID_USUARIO)) INTO LS_usuario
        FROM psd_usuario
-- Inicio 39457 Z.M.H. 13-04-2007, cambio al obtener el código del usuario antes se obtenía según el Cliente
  WHERE cod_usuario  = (SELECT COD_USUARIO_CRE FROM npt_pedido
                        WHERE cod_pedido = EN_CodPedido);
-- Fin 39457

        SELECT TIP_ARTICULO INTO LN_TIPARTI FROM al_articulos
        WHERE cod_articulo = vleeDetPedido.COD_ARTICULO;

        IF LN_TIPARTI <> 20 THEN -- no es kit
           INSERT INTO NP_DETSER_ACTVTA_MAYORISTAS_TO
            (COD_CLIENTE, COD_PEDIDO, NUM_SERIE, COD_ESTADO, COD_ARTICULO,
             COD_MOTIVO, NUM_VENTA, COD_USUARIO, FEC_MOVIMIENTO,
             MTO_NETO_SCL, MTO_NETO_PED, IND_MOVIMIENTO)
           SELECT vleeDetPedido.COD_CLIENTE, EN_CodPedido, a.COD_SERIE_PEDIDO, 'NU', vleeDetPedido.COD_ARTICULO,
                  0, 0, LS_usuario, SYSDATE,
-- Fecha: 08-03-2007 Desc. Se realizan cambios en el calculo del valor neto por unidad, menos el descuento de la línea. Incidencia:   38366
--                  0, (b.MTO_UNI_DET_PEDIDO - b.MTO_DES_DET_PEDIDO), 'A'
                  0, (b.MTO_UNI_DET_PEDIDO - (b.MTO_UNI_DET_PEDIDO * b.PTJ_DES_DET_PEDIDO/100)), 'A'
-- Fin Incidencia:   38366
           FROM npt_serie_pedido a, npt_detalle_pedido b
           WHERE a.cod_pedido = vleeDetPedido.cod_pedido
           AND   a.LIN_DET_PEDIDO = vleeDetPedido.LIN_DET_PEDIDO
           AND   b.cod_pedido = vleeDetPedido.cod_pedido
           AND   b.LIN_DET_PEDIDO = vleeDetPedido.LIN_DET_PEDIDO;
        ELSE -- Para cuando es kit...
           INSERT INTO NP_DETSER_ACTVTA_MAYORISTAS_TO
              (COD_CLIENTE, COD_PEDIDO, NUM_SERIE, COD_ESTADO, COD_ARTICULO,
              COD_MOTIVO, NUM_VENTA, COD_USUARIO, FEC_MOVIMIENTO,
              MTO_NETO_SCL, MTO_NETO_PED, IND_MOVIMIENTO)
              SELECT vleeDetPedido.COD_CLIENTE, EN_CodPedido, b.num_serie, 'NU', vleeDetPedido.COD_ARTICULO,
                   0, 0, LS_usuario, SYSDATE, 0, 0, 'K'
           FROM npt_serie_pedido a, AL_COMPONENTE_KIT b
           WHERE a.cod_pedido = vleeDetPedido.cod_pedido
              AND a.LIN_DET_PEDIDO = vleeDetPedido.LIN_DET_PEDIDO
              AND a.COD_SERIE_PEDIDO = b.NUM_KIT
              AND EXISTS
                  (SELECT 1 FROM al_articulos
                   WHERE cod_articulo = b.cod_articulo
                   AND IND_EQUIACC = 'E');
        END IF;

  END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        SC_Error := SQLCODE || ' - ' || SQLERRM;

END NP_ALAMCENASERIE_NUEVA_PR;

PROCEDURE NP_ElIMINASERIE_BAJA_PR
(EN_CodPedido        IN npt_pedido.cod_pedido%TYPE,
 SC_Error            OUT NOCOPY     VARCHAR2
)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_ElIMINASERIE_BAJA_PR" Lenguaje="PL/V_sSql" Fecha="28-02-2007" Versión="1.0" Diseñador="****" Programador="Jorge Luengo" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, elimina series de tabla: NP_DETSER_ACTVTA_MAYORISTAS_TO, cuando un pedido es dado de baja</Descripción>
Parámetros>
    <Entrada>
        <param nom="EN_CodPedido" Tipo="NUMBER">Código del Pedido Mayorista</param>
    </Entrada>
    <Salida>
        <param nom="SC_Error" Tipo="STRING">Error en el PL</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_CodEstadoFlujo    NUMBER;

BEGIN

   SELECT MAX(COD_ESTADO_FLUJO)
   INTO LN_CodEstadoFlujo
   FROM npt_estado_pedido
   WHERE cod_pedido = EN_CodPedido;

   IF LN_CodEstadoFlujo >= 9 THEN
      DELETE FROM NP_DETSER_ACTVTA_MAYORISTAS_TO
         WHERE cod_pedido = EN_CodPedido AND cod_estado = 'NU';
   END IF;

   DELETE FROM NP_ENCVTA_MAYORISTA_TO
   WHERE cod_pedido = EN_CodPedido;

EXCEPTION
    WHEN OTHERS THEN
        SC_Error := SQLCODE || ' - ' || SQLERRM;

END NP_ElIMINASERIE_BAJA_PR;

PROCEDURE NP_LIMPIASERIEESTANCADA_PR
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_LIMPIASERIEESTANCADA_PR" Lenguaje="PL/V_sSql" Fecha="06-11-2006" Versión="1.0" Diseñador="****" Programador="Zenén MUñoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, que limpia la tabla: NP_SERIES_MARCADAS_TO, con series que no se consideraron en un pedido a descontar</Descripción>
<Parámetros>
    <Entrada>
    </Entrada>
    <Salida>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_ValorParam    NUMBER;
LN_CalculoHora   NUMBER;

BEGIN

   SELECT TO_NUMBER(valor_parametro) INTO LN_ValorParam
   FROM npt_parametro
   WHERE alias_parametro = 'SINCACTIVA';

   LN_CalculoHora := (3600*LN_ValorParam)/86400;

   DELETE FROM NP_SERIES_MARCADAS_TO
   WHERE (SYSDATE - fec_carga) >= LN_CalculoHora;

END NP_LIMPIASERIEESTANCADA_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_CAUSA_CAMBIO_FN
(EN_num_abonado                 IN                                 GA_EQUIPABOSER.NUM_ABONADO%TYPE,
 EV_num_serie                            IN                                    GA_EQUIPABOSER.NUM_SERIE%TYPE,
    SV_causa_cambio                OUT    NOCOPY    GA_EQUIPABOSER.COD_CAUSA%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_CAUSA_CAMBIO_FN"
      Lenguaje="PL/V_sSql"
      Fecha="12-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener la causa de cambio de serie o reposición de equipo</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_num_abonado"   Tipo="NUMERICO">Nro del abonado</param>
                                                    <param nom="EV_num_serie"   Tipo="CARACTER">Nro de serie</param>
            </Entrada>
         <Salida>
            <param nom="SV_causa_cambio"  Tipo="CARACTER">Causa del cambio de equipo</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql         ge_errores_pg.vQuery;
LD_fec_alta       ga_equipaboser.FEC_ALTA%TYPE;
LE_salir                                     EXCEPTION;
LE_error                                        EXCEPTION;
LN_hay                                                NUMBER(1);

CURSOR CU_causas (numabonado IN ga_equipaboser.num_abonado%TYPE) IS
    SELECT UNIQUE(c.COD_CAUSA),c.FEC_ALTA
                          FROM GA_EQUIPABOSER C
                         WHERE C.NUM_ABONADO=numabonado AND c.COD_CAUSA IS NOT NULL
          ORDER BY C.FEC_ALTA DESC;



BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
        SV_causa_cambio:=NULL;
        LD_fec_alta:=NULL;
  LN_hay:=0;


     LV_V_sSql:='SELECT UNIQUE(c.COD_CAUSA),c.FEC_ALTA INTO SV_causa_cambio,LD_fec_alta '||
                                     ' FROM GA_EQUIPABOSER C '||
                                                    ' WHERE C.NUM_ABONADO='||EN_num_abonado||
                                                    ' AND c.COD_CAUSA IS NOT NULL  '||
                                                    '    ORDER BY C.FEC_ALTA DESC';

  FOR C1 IN CU_causas(EN_num_abonado) LOOP
                        LN_hay:=1;
                     SV_causa_cambio:=C1.COD_CAUSA;
                        RAISE LE_salir;
        END LOOP;

        RAISE LE_salir;




EXCEPTION
WHEN LE_salir THEN
     IF LN_hay = 1 THEN
                 RETURN TRUE;
     ELSE
                SN_cod_retorno := '110';
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                  SV_mens_retorno:= CV_error_no_clasif;
                END IF;
                LV_des_error :=SUBSTR('LE_salir: NP_OBTENER_CAUSA_CAMBIO_FN('||EN_num_abonado||');-'||SQLERRM,1,CN_largoerrtec);
                SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_CAUSA_CAMBIO_FN', LV_V_sSql, SQLCODE, LV_des_error );
                            RETURN FALSE;
                    END IF;
WHEN LE_error THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('LE_error: NP_OBTENER_CAUSA_CAMBIO_FN('||EN_num_abonado||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_CAUSA_CAMBIO_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('OTHERS: NP_OBTENER_CAUSA_CAMBIO_FN('||EN_num_abonado||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_CAUSA_CAMBIO_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_CAUSA_CAMBIO_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_DATOS_ABONADO_FN
(EN_num_abonado                 IN                                 GA_ABOCEL.NUM_ABONADO%TYPE,
 SV_causabaja                   OUT    NOCOPY    GA_ABOCEL.COD_CAUSABAJA%TYPE,
    SN_num_venta                   OUT    NOCOPY    GA_ABOCEL.NUM_VENTA%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_DATOS_ABONADO_FN"
      Lenguaje="PL/V_sSql"
      Fecha="12-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener datos del abonado</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_num_abonado"   Tipo="NUMERICO">Nro del abonado</param>
            </Entrada>
         <Salida>
            <param nom="SV_causabaja"  Tipo="CARACTER">Causa de la baja</param>
            <param nom="SN_num_venta"   Tipo="NUMERICO">Nro de venta</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
        SV_causabaja:=NULL;
        SN_num_venta:=NULL;

        LV_V_sSql:='SELECT B.cod_causabaja,B.num_venta '||
                                        '     FROM GA_ABOCEL B'||
                               ' WHERE B.NUM_ABONADO = '||EN_num_abonado;

        SELECT B.cod_causabaja,B.num_venta
          INTO SV_causabaja,SN_num_venta
       FROM GA_ABOCEL B
   WHERE B.NUM_ABONADO = EN_num_abonado;

        RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
                                                        LV_V_sSql:='SELECT B.cod_causabaja,B.num_venta '||
                                                                                        '     FROM GA_ABOAMIST B '||
                                                                      ' WHERE B.NUM_ABONADO = '||EN_num_abonado;
                                                         BEGIN
                                                  SELECT B.cod_causabaja,B.num_venta
                                                                                  INTO SV_causabaja,SN_num_venta
                                                    FROM GA_ABOAMIST B
                                                   WHERE B.NUM_ABONADO = EN_num_abonado;
                                                         EXCEPTION
                                                         WHEN OTHERS THEN
                                                                    SN_cod_retorno := '110';
                                                                    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                                                                      SV_mens_retorno:= CV_error_no_clasif;
                                                                    END IF;
                                                                    LV_des_error :=SUBSTR('Others: NP_OBTENER_DATOS_ABONADO_FNN('||EN_num_abonado||');-'||SQLERRM,1,CN_largoerrtec);
                                                                    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
                                                                    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_DATOS_ABONADO_FN', LV_V_sSql, SQLCODE, LV_des_error );
                                                                                RETURN FALSE;
                                                            END;
                                                            RETURN TRUE;
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_DATOS_ABONADO_FN('||EN_num_abonado||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_DATOS_ABONADO_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_DATOS_ABONADO_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_ESTADO_INICIAL_FN
(EN_cod_cliente                 IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_cliente%TYPE,
 EN_cod_pedido                  IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_pedido%TYPE,
 EV_num_serie                   IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO.num_serie%TYPE,
 SV_estado_ini            OUT    NOCOPY    NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_estado%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_ESTADO_INICIAL_FN
      Lenguaje="PL/V_sSql"
      Fecha="12-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener estado inicial de la serie</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_cod_cliente"   Tipo="NUMERICO">Cliente</param>
                                                    <param nom="EN_cod_pedido"   Tipo="NUMERICO">Código del pedido</param>
                                                    <param nom="EV_num_serie"   Tipo="CARACTER">Nro de serie</param>
            </Entrada>
         <Salida>
            <param nom="SV_estado_ini"  Tipo="CARACTER">Estado inicial de la serie</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
        SV_estado_ini:=NULL;

        LV_V_sSql:='SELECT C.COD_ESTADO '||
                                  ' FROM NP_DETSER_ACTVTA_MAYORISTAS_TO C '||
                                     ' WHERE C.COD_CLIENTE='||EN_cod_cliente||
                                  ' AND C.COD_PEDIDO='||EN_COD_PEDIDO||
                                        ' AND C.NUM_SERIE='''||EV_num_serie||'''';

        SELECT C.COD_ESTADO INTO SV_estado_ini
          FROM NP_DETSER_ACTVTA_MAYORISTAS_TO C
         WHERE C.COD_CLIENTE=EN_cod_cliente
              AND C.COD_PEDIDO=EN_COD_PEDIDO
                    AND C.NUM_SERIE=EV_num_serie;

        RETURN TRUE;

EXCEPTION

WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_ESTADO_INICIAL_FN('||EN_cod_cliente||','||EN_cod_pedido||','||EV_num_Serie||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_ESTADO_INICIAL_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_ESTADO_INICIAL_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_PEDIDO_SERIE_FN
(EV_num_serie                   IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO.num_serie%TYPE,
 SN_cod_cliente                 OUT    NOCOPY    NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_cliente%TYPE,
 SN_cod_pedido                  OUT    NOCOPY    NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_pedido%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_PEDIDO_SERIE_FN"
      Lenguaje="PL/V_sSql"
      Fecha="12-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener cliente y último pedido al que pertenece la serie</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EV_num_serie"   Tipo="CARACTER">Nro de serie</param>
            </Entrada>
         <Salida>
                                             <param nom="SN_cod_cliente"   Tipo="NUMERICO">Cliente</param>
                                                <param nom="SN_cod_pedido"   Tipo="NUMERICO">Código del pedido</param>
               <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
        SN_COD_CLIENTE:=NULL;
        SN_COD_PEDIDO:=NULL;

        LV_V_sSql:='    SELECT A.COD_CLIENTE,A.COD_PEDIDO '||
                         '         FROM NPT_PEDIDO A '||
                            '  WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO) FROM NPT_SERIE_PEDIDO A '||
          '                             WHERE A.COD_SERIE_PEDIDO = '''||EV_num_serie||''')';

            SELECT A.COD_CLIENTE,A.COD_PEDIDO
              INTO SN_COD_CLIENTE,SN_COD_PEDIDO
     FROM NPT_PEDIDO A
    WHERE A.COD_PEDIDO = (SELECT MAX(A.COD_PEDIDO)
                                        FROM NPT_SERIE_PEDIDO A
                                       WHERE A.COD_SERIE_PEDIDO = EV_num_serie);

        RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
          SN_cod_retorno:=0;
          SN_num_evento:= 0;
                RETURN TRUE;

WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_PEDIDO_SERIE_FN('||EV_num_Serie||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_PEDIDO_SERIE_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_PEDIDO_SERIE_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_CONFIG_EVENTO_FN
(EV_cod_actabo                  IN                                 NP_CONFIG_EVENTO_TD.cod_actabo%TYPE,
   EV_estado_ini                  IN                                 NP_CONFIG_EVENTO_TD.estado_ini%TYPE,
   EV_cod_caucaser                IN                                 NP_CONFIG_EVENTO_TD.cod_caucaser%TYPE,
   SR_config_evento            OUT NOCOPY NP_CONFIG_EVENTO_TD%ROWTYPE,
   SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
   SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
   SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_CONFIG_EVENTO_FN"
      Lenguaje="PL/V_sSql"
      Fecha="08-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtiene la configuración de un evento</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EV_cod_actabo"   Tipo="CARACTER">Codigo de actabo</param>
                                                    <param nom="EV_estado_ini"   Tipo="CARACTER">Estado inicial de la serie</param>
                                                    <param nom="EV_cod_caucaser"   Tipo="CARACTER">Causa de cambio o reposición de la serie</param>
            </Entrada>
         <Salida>
                                                    <param nom="SR_config_evento"   Tipo="CARACTER">Razon de la baja</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;
LV_cod_actabo        NP_CONFIG_EVENTO_TD.cod_actabo%TYPE;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
  SR_config_evento.ESTADO_FINAL:=NULL;
  SR_config_evento.COD_MOTIVO:=NULL;
  SR_config_evento.IND_NOTA_FACT:=NULL;
  LV_cod_actabo:=NULL;


   --Inicio incidencia 60951 --
   LV_V_sSql:='select DISTINCT (a.cod_tipmodi) into LV_cod_actabo '||
              'from pv_actabo_tiplan a where a.cod_actabo='''||EV_cod_actabo||''' and rownum=1';
   begin
      select DISTINCT (a.cod_tipmodi) into LV_cod_actabo
      from pv_actabo_tiplan a where a.cod_actabo=EV_cod_actabo and rownum=1;
   exception
   when others then
        LV_cod_actabo:=EV_cod_actabo;
   end;
   --Fin incidencia 60951 ----


   LV_V_sSql:=' SELECT A.ESTADO_FINAL,A.COD_MOTIVO,A.IND_NOTA_FACT '||
              ' FROM NP_CONFIG_EVENTO_TD A '||
              ' WHERE A.COD_ACTABO='''||LV_cod_actabo||''''||
              '   AND A.ESTADO_INI='''||EV_estado_ini||''''||
              '   AND A.COD_CAUCASER='''||EV_COD_CAUCASER||'''';
           SELECT A.ESTADO_FINAL,A.COD_MOTIVO,A.IND_NOTA_FACT
                      INTO SR_config_evento.ESTADO_FINAL,
                           SR_config_evento.COD_MOTIVO,
                           SR_config_evento.IND_NOTA_FACT
             FROM NP_CONFIG_EVENTO_TD A
            WHERE A.COD_ACTABO=LV_cod_actabo
                       AND A.ESTADO_INI=EV_estado_ini
                                AND A.COD_CAUCASER=EV_COD_CAUCASER;

        RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
     RETURN TRUE;
                    NULL;
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_CONFIG_EVENTO_FN('||EV_cod_actabo||', '||EV_estado_ini||','|| EV_cod_caucaser||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_CONFIG_EVENTO_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_CONFIG_EVENTO_FN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_INFADIC_FN
(EN_num_abonado                 IN                                 ICC_MOVIMIENTO.num_abonado%TYPE,
 EV_cod_actabo                  IN                                 ICC_MOVIMIENTO.cod_actabo%TYPE,
 EV_num_serie                            IN                              ICC_MOVIMIENTO.num_serie%TYPE,
    SV_razon                          OUT NOCOPY    VARCHAR2,
    SV_causa                             OUT NOCOPY    VARCHAR2,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_INFADIC_BAJA_FN"
      Lenguaje="PL/V_sSql"
      Fecha="08-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Verifica la razón de la baja del abonado</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_num_abonado"   Tipo="NUMERICO">Nro del abonado</param>
                                                    <param nom="EV_cod_actabo"   Tipo="CARACTER">Codigo de actabo</param>
                                                    <param nom="EV_num_serie"   Tipo="CARACTER">Nro de serie</param>
            </Entrada>
         <Salida>
                                                    <param nom="SV_razon"   Tipo="CARACTER">Razon de la baja</param>
                                                    <param nom="SV_causa"   Tipo="CARACTER">Causa del cambio o la baja</param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_cod_causabaja  ga_abocel.cod_causabaja%TYPE;
LE_salir                            EXCEPTION;
LV_error                                        VARCHAR2(100);
LN_existe                                    NUMBER;
LN_num_venta                     GA_VENTAS.num_venta%TYPE;
LV_cod_causarec   GA_VENTAS.COD_CAUSAREC%TYPE;
LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;
LV_cod_tecno                        ga_abocel.cod_tecnologia%TYPE;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
  LV_error:=NULL;

     --Obtener información del abonado...
        LN_num_venta:=NULL;
        LV_cod_causabaja:=NULL;
     LV_V_sSql:='IF NOT NP_OBTENER_DATOS_ABONADO_FN(EN_num_abonado,LV_cod_causabaja,LN_num_venta,LV_num_serie,LV_num_imei,LV_cod_tecno,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
     IF NOT NP_OBTENER_DATOS_ABONADO_FN(EN_num_abonado,LV_cod_causabaja,LN_num_venta,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
     RAISE LE_salir;
     END IF;

        CASE EV_cod_actabo
         WHEN 'CE' THEN
                        --Obtener causa....
                        SV_causa:=NULL;
      SV_razon:=NULL;
                        IF NOT NP_OBTENER_CAUSA_CAMBIO_FN(EN_num_abonado,EV_num_serie,SV_causa,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                           RAISE LE_salir;
                        END IF;

         WHEN 'SA' THEN
                        --Obtener causa....
                        SV_causa:=NULL;
      SV_razon:=NULL;
                        IF NOT NP_OBTENER_CAUSA_CAMBIO_FN(EN_num_abonado,EV_num_serie,SV_causa,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                           RAISE LE_salir;
                        END IF;

         WHEN 'RV' THEN
         SV_causa:=NULL;
                     SV_razon:=NULL;
             --Verificar si la baja se produce por rechazo de venta.
                --a.- Rechazo de venta si en la ga_ventas existe una causa de rechazo de venta.
                    LV_cod_causarec:=NULL;
                    LV_V_sSql:='SELECT COD_CAUSAREC FROM GA_VENTAS '||
                                                    '    WHERE NUM_VENTA='||LN_num_venta;
                 BEGIN
                                  SELECT COD_CAUSAREC INTO LV_cod_causarec
                                          FROM GA_VENTAS
                                      WHERE NUM_VENTA=LN_num_venta;
                    EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                            LV_error:='No existe la VENTA: '||LN_num_venta;
                                        RAISE LE_salir;
                    END;

                    LV_V_sSql:='LV_cod_causarec IS NOT NULL THEN ';
                    IF LV_cod_causarec IS NOT NULL THEN
                       SV_causa:=LV_cod_causarec;
                                SV_razon:=CV_rechazo;
                    END IF;

        END CASE;
        RETURN TRUE;

EXCEPTION
WHEN LE_salir THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('LE_salir: NP_OBTENER_INFADIC_FN('||EN_num_abonado||', '||EV_cod_actabo||');-'||SQLERRM,1,CN_largoerrtec)||LV_error;
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_INFADIC_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_INFADIC_FN('||EN_num_abonado||', '||EV_cod_actabo||');-'||SQLERRM,1,CN_largoerrtec)||LV_error;
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_INFADIC_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_INFADIC_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_CAMBIA_ESTADO_SERIE_FN
(ER_det_serie                   IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO%ROWTYPE,
 EV_est_inicial     IN         NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_CAMBIA_ESTADO_SERIE_FN"
      Lenguaje="PL/V_sSql"
      Fecha="09-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Modifica el estado de una serie y registra motivo de cambio de estado</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="ER_det_serie"   Tipo="REGISTRO">Datos de la serie</param>
            </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LE_error                           EXCEPTION;
LV_error                                        VARCHAR2(100);
LN_existe                                    NUMBER;
LN_num_venta                     GA_VENTAS.num_venta%TYPE;
LV_cod_causarec   GA_VENTAS.COD_CAUSAREC%TYPE;
LN_cod_causarep            GA_VENTAS.COD_CAUSAREP%TYPE;
LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;
LR_hist_serie                    NP_HIST_MOVIM_SERIES_TO%ROWTYPE;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
        LR_hist_serie:=NULL;

  --Modificar datos de la serie en modelo mayorista...
     LV_V_sSql:='IF NOT NP_UPDATE_NPDETSERACTVTA_FN(ER_det_serie,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
        IF NOT NP_UPDATE_NPDETSERACTVTA_FN(ER_det_serie,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           RAISE LE_error;
        END IF;

        --Registrar motivo del cambio de estado de la serie....
        LR_hist_serie.COD_CLIENTE:=ER_det_serie.COD_CLIENTE;
        LR_hist_serie.NUM_SERIE:=ER_det_serie.NUM_SERIE;
        LR_hist_serie.FEC_MOVIMIENTO:=SYSDATE;
        LR_hist_serie.COD_ESTADO:=ER_det_serie.COD_ESTADO;
        LR_hist_serie.COD_MOTIVO:=ER_det_serie.COD_MOTIVO;
        LR_hist_serie.COD_PEDIDO:=ER_det_serie.COD_PEDIDO;
        LR_hist_serie.COD_USUARIO:=ER_det_serie.COD_USUARIO;
        LR_hist_serie.COD_ESTADOORIGEN:=EV_est_inicial;
     LV_V_sSql:='IF NOT NP_INSERT_NPHISTMOVSERIES_FN(ER_hist_serie,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
        IF NOT NP_INSERT_NPHISTMOVSERIES_FN(LR_hist_serie,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
           RAISE LE_error;
        END IF;

        RETURN TRUE;

EXCEPTION
WHEN LE_error THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('LE_error: NP_CAMBIA_ESTADO_SERIE_FN();-'||SQLERRM,1,CN_largoerrtec)||LV_error;
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_CAMBIA_ESTADO_SERIE_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_CAMBIA_ESTADO_SERIE_FN();-'||SQLERRM,1,CN_largoerrtec)||LV_error;
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_CAMBIA_ESTADO_SERIE_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_CAMBIA_ESTADO_SERIE_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_UPDATE_NPDETSERACTVTA_FN
(ER_det_serie                   IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO%ROWTYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_UPDATE_NPDETSERACTVTA_FN"
      Lenguaje="PL/V_sSql"
      Fecha="09-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Modifica datos de una serie en modelo mayorista</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="ER_det_serie"   Tipo="REGISTRO">Datos de la serie</param>
            </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;

     LV_V_sSql:='UPDATE NP_DETSER_ACTVTA_MAYORISTAS_TO B '||
                                  ' SET B.COD_ESTADO='''||ER_det_serie.COD_ESTADO||''','||
                            ' B.COD_MOTIVO='||ER_det_serie.COD_MOTIVO||','||
                                        ' B.NUM_DOCUMENTO='||ER_det_serie.NUM_DOCUMENTO||','||
                                        ' B.IND_NOTACDTO='||ER_det_serie.IND_NOTACDTO||','||
                                        ' B.IND_FACTMISC='||ER_det_serie.IND_FACTMISC||' ,'||
                                        ' B.FEC_MOVIMIENTO=SYSDATE, '||
                                        '    B.COD_CAUSA='||ER_det_serie.COD_CAUSA||' '||
                                        ' WHERE B.COD_CLIENTE='||ER_det_serie.COD_CLIENTE||
                                  ' AND B.COD_PEDIDO='||ER_det_serie.COD_PEDIDO||
                                        ' AND B.NUM_SERIE='''||ER_det_serie.NUM_SERIE||'''';


        UPDATE NP_DETSER_ACTVTA_MAYORISTAS_TO B
          SET B.COD_ESTADO=ER_det_serie.COD_ESTADO,
                    B.COD_MOTIVO=ER_det_serie.COD_MOTIVO,
                                B.NUM_DOCUMENTO=ER_det_serie.NUM_DOCUMENTO,
                                B.IND_NOTACDTO=ER_det_serie.IND_NOTACDTO,
                                B.IND_FACTMISC =ER_det_serie.IND_FACTMISC,
                                B.FEC_MOVIMIENTO=SYSDATE,
                                B.COD_CAUSA=ER_det_serie.COD_CAUSA
        WHERE B.COD_CLIENTE=ER_det_serie.COD_CLIENTE
          AND B.COD_PEDIDO=ER_det_serie.COD_PEDIDO
                AND B.NUM_SERIE=ER_det_serie.NUM_SERIE;


                RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_UPDATE_NPDETSERACTVTA_FN;- Cliente='||ER_det_serie.COD_CLIENTE||',pedido='||ER_det_serie.COD_PEDIDO||',serie='||ER_det_serie.NUM_SERIE||'-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_UPDATE_NPDETSERACTVTA_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_UPDATE_NPDETSERACTVTA_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_INSERT_NPHISTMOVSERIES_FN
(ER_hist_serie                  IN                                 NP_HIST_MOVIM_SERIES_TO%ROWTYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_INSERT_NPHISTMOVSERIES_FN"
      Lenguaje="PL/V_sSql"
      Fecha="09-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Registrar histórico de cambios de estado de serie</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="ER_hist_serie"   Tipo="REGISTRO">Datos del registro a insertar</param>
            </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;


        LV_V_sSql:=' INSERT INTO    NP_HIST_MOVIM_SERIES_TO '||
                ' (COD_CLIENTE,NUM_SERIE,FEC_MOVIMIENTO,'||
                                     ' COD_ESTADO,COD_MOTIVO,COD_PEDIDO,'||
                                        ' COD_USUARIO,COD_ESTADOORIGEN) VALUES('||
                                         ER_hist_serie.COD_CLIENTE||','''||ER_hist_serie.NUM_SERIE||''','||ER_hist_serie.FEC_MOVIMIENTO||','''||
                                         ER_hist_serie.COD_ESTADO||''','||ER_hist_serie.COD_MOTIVO||','||ER_hist_serie.COD_PEDIDO||','''||
                                         ER_hist_serie.COD_USUARIO||''','''||ER_hist_serie.COD_ESTADOORIGEN||''')';

  INSERT INTO    NP_HIST_MOVIM_SERIES_TO
         (COD_CLIENTE,NUM_SERIE,FEC_MOVIMIENTO,
             COD_ESTADO,COD_MOTIVO,COD_PEDIDO,
                COD_USUARIO,COD_ESTADOORIGEN)
        VALUES
         (ER_hist_serie.COD_CLIENTE,ER_hist_serie.NUM_SERIE,ER_hist_serie.FEC_MOVIMIENTO,
             ER_hist_serie.COD_ESTADO,ER_hist_serie.COD_MOTIVO,ER_hist_serie.COD_PEDIDO,
             ER_hist_serie.COD_USUARIO,ER_hist_serie.COD_ESTADOORIGEN);

        RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_INSERT_NPHISTMOVSERIES_FN();-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_INSERT_NPHISTMOVSERIES_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_INSERT_NPHISTMOVSERIES_FN;

--------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE NP_VALIDA_SERIESTEMP_PR(
EV_cod_cliente         IN VARCHAR2,
EV_cod_pedido          IN VARCHAR2,
EV_fec_desde_serie     IN VARCHAR2,
EV_fec_hasta_serie     IN VARCHAR2,
EV_ind_nota_fact       IN VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento>
   <Elemento
      Nombre = "NP_VALIDA_SERIESTEMP_PR"
      Lenguaje="PL/V_sSql"
      Fecha="22-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jorge Luengo"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Validación de series en mayoristas</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EV_cod_cliente"   Tipo="CARACTER">Codigo de cliente</param>
                                                    <param nom="EV_cod_pedido   Tipo="CARACTER">Codigo de pedido</param>
                                                    <param nom="EV_fec_desde_serie"   Tipo="CARACTER">Fecha desde</param>
                                                    <param nom="EV_fec_hasta_serie"   Tipo="CARACTER">Fecha desde</param>
                                                    <param nom="EV_ind_nota_fact"   Tipo="CARACTER">Fecha desde</param>

                </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS
LN_temp_cliente     NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_cliente%TYPE;
LN_temp_pedido         NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_pedido%TYPE;
LV_temp_estado         NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_estado%TYPE;
LV_temp_serie          NP_DETSER_ACTVTA_MAYORISTAS_TO.num_serie%TYPE;
LI_cod_error          INTEGER;


CURSOR valida_series  IS
       SELECT   a.num_serie
       FROM     AL_SERIES_TEMP_TO a
       WHERE    a.proc_invocador = 'MAY';

BEGIN
     FOR CC IN valida_series LOOP
         BEGIN
                    LI_cod_error := 0;

                         SELECT cod_cliente, cod_pedido, cod_estado
                         INTO   LN_temp_cliente, LN_temp_pedido, LV_temp_estado
                         FROM   NP_DETSER_ACTVTA_MAYORISTAS_TO
                         WHERE  num_serie = CC.num_serie
                         AND    TRUNC(fec_movimiento) BETWEEN TO_DATE(EV_fec_desde_serie, 'DD-MM-YYYY') AND TO_DATE(EV_fec_hasta_serie, 'DD-MM-YYYY')
                         AND    ind_notacdto = 0
                         AND    ind_factmisc = 0;

                         IF LN_temp_cliente <> TO_NUMBER(EV_cod_cliente) THEN
                            LI_cod_error := 2;
                         END IF;

                   IF TO_NUMBER(EV_cod_pedido) <> 0 AND LN_temp_pedido <> TO_NUMBER(EV_cod_pedido) THEN
                             LI_cod_error := 3;
                         END IF;
                         IF TRIM(EV_ind_nota_fact) = 'F' AND TRIM(LV_temp_estado) <> 'AP' THEN
                             LI_cod_error := 4;
                         ELSIF TRIM(EV_ind_nota_fact) = 'N' AND TRIM(LV_temp_estado) = 'NU' THEN
                                LI_cod_error := 5;
                         ELSIF TRIM(EV_ind_nota_fact) = 'N' AND TRIM(LV_temp_estado) = 'SP' THEN
                                LI_cod_error := 7;

                         END IF;

                         IF LI_cod_error <> 0 THEN
                                     UPDATE AL_SERIES_TEMP_TO
                                            SET cod_error = LI_cod_error
                                            WHERE num_serie = CC.num_serie;
                         END IF;

             EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                                UPDATE AL_SERIES_TEMP_TO
                                      SET cod_error = 1-- errro de no_existe en mayorista
                                      WHERE num_serie = CC.num_serie;

                  WHEN OTHERS THEN
                        UPDATE AL_SERIES_TEMP_TO
                              SET cod_error = 6-- error generico validand serie mayorista
                              WHERE num_serie = CC.num_serie;
          END;

    END LOOP;

EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20157, SQLCODE || ' - ' || SQLERRM);

END NP_VALIDA_SERIESTEMP_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_TIPPLAN_FN
(EN_num_abonado                 IN                                 GA_ABOCEL.NUM_ABONADO%TYPE,
 SV_cod_tiplan                        OUT NOCOPY    PV_ACTABO_TIPLAN.cod_tiplan%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = " NP_OBTENER_TIPPLAN_FN"
      Lenguaje="PL/V_sSql"
      Fecha="08-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener tipo de plan...</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_num_abonado"   Tipo="NUMERICO">Nro del abonado</param>
            </Entrada>
         <Salida>
               <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
                                            --
                 SV_COD_TIPLAN:=NULL;
                                            LV_V_sSql:=    'select b.COD_TIPLAN  into SV_COD_TIPLAN '||
                                                 ' from ga_aboamist a, ta_plantarif b '||
                                                 ' where a.num_abonado   = '||EN_num_abonado||' and '||
                                                    '        a.COD_PLANTARIF = b.COD_PLANTARIF '||
             ' union '||
                                           ' select b.COD_TIPLAN '||
                                     ' from ga_abocel a, ta_plantarif b '||
                                        ' where a.num_abonado   = '||EN_num_abonado||' and '||
                                           '          a.COD_PLANTARIF = b.COD_PLANTARIF and '||
                                              '       b.COD_TIPLAN    = '||GN_tiplan_pos||
                                        ' union '||
                                           ' select b.COD_TIPLAN '||
                                              ' from ga_abocel a, ta_plantarif b '||
                                           ' where a.num_abonado   = '||EN_num_abonado||' and '||
                                                    '                 a.COD_PLANTARIF = b.COD_PLANTARIF and '||
                                                    '                 b.COD_TIPLAN    = '||GN_tiplan_hib;

                   SELECT b.COD_TIPLAN  INTO SV_COD_TIPLAN
                                                   FROM ga_aboamist a, ta_plantarif b
                                                   WHERE a.num_abonado   = EN_num_abonado AND
                                                               a.COD_PLANTARIF = b.COD_PLANTARIF
             UNION
                                           SELECT b.COD_TIPLAN
                                      FROM ga_abocel a, ta_plantarif b
                                         WHERE a.num_abonado   = EN_num_abonado AND
                                                     a.COD_PLANTARIF = b.COD_PLANTARIF AND
                                                     b.COD_TIPLAN    = GN_tiplan_pos
                                        UNION
                                           SELECT b.COD_TIPLAN
                                               FROM ga_abocel a, ta_plantarif b
                                           WHERE a.num_abonado   = EN_num_abonado AND
                                                                         a.COD_PLANTARIF = b.COD_PLANTARIF AND
                                                                         b.COD_TIPLAN    = GN_tiplan_hib;

        RETURN TRUE;

EXCEPTION
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_TIPPLAN_FN('||EN_num_abonado||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_TIPPLAN_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_TIPPLAN_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_TIPOACCION_FN
(EV_cod_actabo                  IN                                 ICC_MOVIMIENTO.cod_actabo%TYPE,
 EV_cod_tiplan                        IN                                 PV_ACTABO_TIPLAN.cod_tiplan%TYPE,
 SV_cod_tipmodi                    OUT NOCOPY    VARCHAR2,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = ""
      Lenguaje="PL/V_sSql"
      Fecha="19-04-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener tipo de accion</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EV_cod_actabo"   Tipo="CARACTER">Codigo de actabo</param>
            </Entrada>
         <Salida>
                                                    <param nom="SV_cod_tipmodi"   Tipo="CARACTER">Tipo de accion.CE=Cambio Serie,SA=Cambio simcard,RE=Restitucion,BA=Rechazo de venta </param>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error         ge_errores_pg.DesEvent;
LV_V_sSql            ge_errores_pg.vQuery;

BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;
  SV_cod_tipmodi:=NULL;

        LV_V_sSql:='select DISTINCT(a.cod_tipmodi)'||
          '    from pv_actabo_tiplan a where a.cod_actabo='''||EV_cod_actabo||''||
                                        ' and a.cod_tiplan='''||EV_cod_tiplan||'';

  SELECT DISTINCT(a.cod_tipmodi)
        INTO SV_cod_tipmodi
        FROM pv_actabo_tiplan a WHERE a.cod_actabo=EV_cod_actabo AND a.cod_tiplan=EV_cod_tiplan;

        RETURN TRUE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
           RETURN TRUE;

WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_OBTENER_TIPOACCION_FN('||EV_cod_actabo||','||EV_cod_tiplan||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_TIPOACCION_FN', LV_V_sSql, SQLCODE, LV_des_error );
                RETURN FALSE;
END NP_OBTENER_TIPOACCION_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_MAIN_LIQ_MAYORISTAF2_PR
(EN_num_abonado                    IN                                 ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
    EV_cod_actabo                        IN                                 ICC_MOVIMIENTO.cod_actabo%TYPE,
 EV_num_serie                            IN                              ICC_MOVIMIENTO.num_serie%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
)

/*
<Documentación
  TipoDoc = "Procedimiento>
   <Elemento
      Nombre = "NP_MAIN_LIQ_MAYORISTAF2_PR"
      Lenguaje="PL/V_sSql"
      Fecha="09-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jubitza Villanueva G."
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Ejecutar liquidacion mayorista fase 2</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_num_abonado"   Tipo="NUMERICO">Nro del abonado</param>
                                                    <param nom="EV_cod_actabo"   Tipo="CARACTER">Codigo de actuacion</param>
                                                    <param nom="EV_num_serie"   Tipo="CARACTER">Nro de serie</param>
            </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_des_error            ge_errores_pg.DesEvent;
LV_V_sSql               ge_errores_pg.vQuery;
LR_config_evento              NP_CONFIG_EVENTO_TD%ROWTYPE;
LE_error                                              EXCEPTION;
LE_salir_sin_error            EXCEPTION;
LV_estado_ini        NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE;
LN_cod_cliente                      NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_CLIENTE%TYPE;
LN_COD_PEDIDO                       NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_PEDIDO%TYPE;
LV_razon                                           VARCHAR2(100);
LV_causa                                           VARCHAR2(3);
LR_det_serie                              NP_DETSER_ACTVTA_MAYORISTAS_TO%ROWTYPE;
LN_EstadoCliente     NUMBER;
LN_DET_PEDIDO        NP_ENCVTA_MAYORISTA_TO.LIN_DET_PEDIDO%TYPE;
LV_error             VARCHAR2(200);
LV_cod_tipmodi                            ICC_MOVIMIENTO.cod_actabo%TYPE;
LV_COD_TIPLAN                                PV_ACTABO_TIPLAN.cod_tiplan%TYPE;


BEGIN
  SN_cod_retorno:=0;
  SN_num_evento:= 0;

        --Obtener último pedido al que pertenece la serie....
        LN_cod_cliente:=NULL;
  LN_cod_pedido:=NULL;

        LV_V_sSql:='IF NP_OBTENER_PEDIDO_SERIE_FN('''||EV_num_serie||''','||'LN_cod_cliente,LN_cod_pedido,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
  IF NOT NP_OBTENER_PEDIDO_SERIE_FN(EV_num_serie,LN_cod_cliente,LN_cod_pedido,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                    RAISE LE_error;
        END IF;

        IF LN_cod_cliente IS NOT NULL AND LN_cod_pedido IS NOT NULL THEN
                        --Verificar si el cliente es mayorista...
                        LV_V_sSql:='NP_GESTOR_MAYORISTAS_PG.NP_CLIENTE_MAYORISTA_PR ('||LN_cod_cliente||', LN_estadocliente,  LV_error)';
                        Np_Gestor_Mayoristas_Pg.NP_CLIENTE_MAYORISTA_PR (LN_cod_cliente, LN_estadocliente,  LV_error);
                  IF LN_EstadoCliente = GN_mayorista THEN
                                            LV_razon:=NULL;
                                            LV_causa:='0';

                                            IF EN_NUM_ABONADO <> 0 THEN --NO ES ENTRADA EXTRA....
                                                        --Obtener tipo de plan...
                                                        LV_COD_TIPLAN:=NULL;
                                                        IF NOT NP_OBTENER_TIPPLAN_FN(EN_num_abonado,LV_COD_TIPLAN,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                           RAISE LE_error;
                                                     END IF;

                                                        --Obtener tipo de movimiento según el cod_actabo....
                                                        LV_cod_tipmodi:=NULL;
                                                        LV_V_sSql:='NP_OBTENER_TIPOACCION_FN('''||EV_COD_ACTABO||''','''||LV_COD_TIPLAN||''','''||LV_cod_tipmodi||''')';
                                                        IF NOT NP_OBTENER_TIPOACCION_FN(EV_COD_ACTABO,LV_COD_TIPLAN,LV_cod_tipmodi,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                           RAISE LE_error;
                                                        END IF;

                                                        --Si el tipo de movimiento no existe entonces es el cod_actabo el que manda....
                                                        IF LV_cod_tipmodi IS NULL THEN
                                                                    LV_cod_tipmodi:=EV_cod_actabo;
                                               END IF;

                                                        --Buscar causa de baja, cambio serie,cambio simcard...
                                                        LV_V_sSql:='IF LV_cod_tipmodi = RV OR LV_cod_tipmodi = CE or LV_cod_tipmodi = SA THEN';
                                                        IF LV_cod_tipmodi = 'RV' OR LV_cod_tipmodi = 'CE' OR LV_cod_tipmodi = 'SA' THEN
                                                                    LV_V_sSql:='IF NOT NP_OBTENER_INFADIC_FN('||EN_num_abonado||','''||LV_cod_tipmodi||''','''||EV_num_serie||''',LV_razon,LV_causa,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
                                                                    IF NOT NP_OBTENER_INFADIC_FN(EN_num_abonado,LV_cod_tipmodi,EV_num_serie,LV_razon,LV_causa,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                                                RAISE LE_error;
                                                                    END IF;
                                                        END IF;

                                                        --Liquidación mayorista aplicable a RV sólo si es por rechazo de venta....
                                                        LV_razon:=TRIM(LV_razon);
                                                        LV_V_sSql:='IF LV_cod_tipmodi=RV AND LV_razon<>CV_rechazo THEN';
                                                        IF LV_cod_tipmodi ='RV' AND LV_razon<>CV_rechazo THEN
                                                           RAISE LE_salir_sin_error;
                                                        END IF;
                                            ELSE
                                                        LV_cod_tipmodi:=EV_cod_actabo;
                                            END IF;


                                   --Obtener estado actual de la serie en mayorista...
                                            LV_estado_ini:=NULL;
                                            LV_V_sSql:='IF NOT NP_OBTENER_ESTADO_INICIAL_FN('||LN_cod_cliente||','||LN_COD_PEDIDO||','''||EV_num_serie||''',LV_estado_ini,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
                                            IF NOT NP_OBTENER_ESTADO_INICIAL_FN(LN_cod_cliente,LN_COD_PEDIDO,EV_num_serie,LV_estado_ini,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                  RAISE LE_error;
                                            END IF;

                                            --Obtener configuración de evento..
                                            IF LV_causa IS NULL THEN
                                               LV_causa:='0';
                                            END IF;

                                            LV_V_sSql:='IF NOT NP_OBTENER_CONFIG_EVENTO_FN('''||LV_cod_tipmodi||''','''||LV_estado_ini||''','''||trim(LV_causa)||''',LR_config_evento,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
                                            IF NOT NP_OBTENER_CONFIG_EVENTO_FN(LV_cod_tipmodi,LV_estado_ini,trim(LV_causa),LR_config_evento,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                  RAISE LE_error;
                                            END IF;

                                            --No existe configuración para el evento por tanto sale sin error....
                                            LV_V_sSql:='IF LR_config_evento.ESTADO_FINAL IS NULL AND LR_config_evento.COD_MOTIVO IS NULL AND LR_config_evento.IND_NOTA_FACT IS NULL THEN';
                                            IF LR_config_evento.ESTADO_FINAL IS NULL AND LR_config_evento.COD_MOTIVO IS NULL AND LR_config_evento.IND_NOTA_FACT IS NULL THEN
                                               RAISE LE_salir_sin_error;
                                            END IF;

                                            --Registrar nuevo estado de la serie y marcarla para cobranza según corresponda
                                            LR_det_serie.COD_CLIENTE:=LN_cod_cliente;
                                            LR_det_serie.COD_PEDIDO:=LN_COD_PEDIDO;
                                            LR_det_serie.NUM_SERIE:=EV_num_serie;
                                      LR_det_serie.COD_ESTADO:=LR_config_evento.ESTADO_FINAL;
                                            LR_det_serie.COD_MOTIVO:=LR_config_evento.COD_MOTIVO;
                                            LR_det_serie.COD_CAUSA:=LV_causa;        --arrastar a modelo mayorista causa de CE/RE, Baja..
                                            LR_det_serie.NUM_DOCUMENTO:=NULL;
                                            LR_det_serie.IND_NOTACDTO:=0;
                                   LR_det_serie.IND_FACTMISC:=0;
                                         IF LR_config_evento.IND_NOTA_FACT='NC' THEN
                                                  LR_det_serie.IND_NOTACDTO:=1;
                                            ELSE
                                               IF LR_config_evento.IND_NOTA_FACT='FM' THEN
                                                           LR_det_serie.IND_FACTMISC:=1;
                                                        END IF;
                                            END IF;

                                            LV_V_sSql:='IF NOT NP_CAMBIA_ESTADO_SERIE_FN(LR_det_serie,'''||LV_estado_ini||''',SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
                                         IF NOT NP_CAMBIA_ESTADO_SERIE_FN(LR_det_serie,LV_estado_ini,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                   RAISE LE_error;
                                            END IF;

                        END IF;
        END IF;

EXCEPTION
WHEN LE_salir_sin_error THEN
     NULL;
WHEN LE_error THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('LE_error: NP_MAIN_LIQ_MAYORISTAF2_PR('||EN_num_abonado||','''||EV_cod_actabo||''','''||EV_num_serie||''');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_MAIN_LIQ_MAYORISTAF2_PR', LV_V_sSql, SQLCODE, LV_des_error );
WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_MAIN_LIQ_MAYORISTAF2_PR('||EN_num_abonado||','''||EV_cod_actabo||''','''||EV_num_serie||''');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_MAIN_LIQ_MAYORISTAF2_PR', LV_V_sSql, SQLCODE, LV_des_error );
END NP_MAIN_LIQ_MAYORISTAF2_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_EE_MAYORISTAS_PR(
    EN_num_extra       IN al_ser_es_extras.num_extra%TYPE)
/*
<Documentación
  TipoDoc = "Procedimiento>
   <Elemento
      Nombre = "NP_EE_MAYORISTAS_PR"
      Lenguaje="PL/V_sSql"
      Fecha="22-03-2007"
      Versión="1.0"
      Diseñador="UU"
      Programador="Jorge Luengo"
      Ambiente Desarrollo="BD">
      <Retorno></Retorno>
      <Descripción>Ejecutar liquidacion mayorista fase 2 para las series de una entrada extra</Descripción>
      <Parámetros>
         <Entrada>
                                                    <param nom="EN_num_extra"   Tipo="NUMERICO">Nro entrada extra</param>
                </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
LN_num_abonado             icc_movimiento.num_abonado%TYPE;
LV_cod_actabo              icc_movimiento.cod_actabo%TYPE;
LV_num_serie                                 icc_movimiento.num_serie%TYPE;
LN_cod_retorno       ge_errores_pg.CodError;
LV_mens_retorno      ge_errores_pg.MsgError;
LN_num_evento        ge_errores_pg.Evento;




CURSOR series_entrada_extra  IS
       SELECT num_serie
       FROM al_ser_es_extras
       WHERE num_extra = EN_num_extra;

BEGIN
     FOR CC IN series_entrada_extra LOOP
            LN_num_abonado := 0;
                     LV_cod_actabo := 'EE';
                     LV_num_serie := CC.num_serie;

                     LN_cod_retorno:=0;
                        LV_mens_retorno:=NULL;
                        LN_num_evento:=0;
                        NP_MAIN_LIQ_MAYORISTAF2_PR(LN_num_abonado, LV_cod_actabo, LV_num_serie, LN_cod_retorno, LV_mens_retorno, LN_num_evento);
   END LOOP;

EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20157, SQLCODE || ' - ' || SQLERRM);

END NP_EE_MAYORISTAS_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_REGISTRAVALORSERIE_PR(
 ES_SERIE            IN NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE,
 EN_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
 EN_cod_cliente                  IN NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_cliente%TYPE,
 EV_cod_actabo         IN        ICC_MOVIMIENTO.cod_actabo%TYPE,
 SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
 SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
 SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)
IS
/*
<Documentación
  TipoDoc = "Procedimiento">
<Elemento
 Nombre = "NP_REGISTRAVALORSERIE_PR"
 Lenguaje="PL/V_sSql"
    Fecha="23-04-2007"
    Versión="1.0" Diseñador="****" P
    rogramador="Jubitza Villanueva G." Ambiente="BD">
<Retorno>NA</Retorno><Descripción>PL, que permite liquidar series de un pedido Mayorista - desde p_ga_respuesta</Descripción>
<Parámetros>
    <Entrada>
        <param nom="ES_SERIE" Tipo="VARCHAR">Serie del pedido mayorista</param>
        <param nom="EN_ABONADO" Tipo="NUMBER">Número del abonado que esta en la serie. </param>
    </Entrada>
    <Salida>
        <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>
        <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
        <param nom="SN_num_evento"    Tipo="ge_errores_pg.Evento">Detalle de eventos</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_PEDIDO            NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_PEDIDO%TYPE;
LN_DET_PEDIDO        NP_ENCVTA_MAYORISTA_TO.LIN_DET_PEDIDO%TYPE;
LN_ARTICULO          npt_detalle_pedido.COD_ARTICULO%TYPE;
LN_NUMVTA            npt_pedido.NUM_DOC_PEDIDO%TYPE;
LN_numventa             ga_abocel.num_venta%TYPE;
LN_MTODESCLIN        npt_detalle_pedido.MTO_NET_DET_PEDIDO%TYPE;
LN_MTONETLIN         npt_detalle_pedido.MTO_NET_DET_PEDIDO%TYPE;
LN_EstadoCliente     NUMBER;
LN_TipoCliente       NUMBER := 0;
LN_SerIme            NUMBER := 0;
LC_Error             VARCHAR(200);
LN_MTONETOSCL        NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE :=0;
LN_MTODESCUENTO      NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE :=0;
LN_STOCK             npt_detalle_pedido.TIP_STOCK%TYPE;
LN_USO               npt_detalle_pedido.COD_USO%TYPE;
LN_ESTADO            npt_detalle_pedido.COD_ESTADO%TYPE;
LS_SERIE             NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE;
LS_SERIE1            NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE := '';
LS_IMEI              ga_abocel.NUM_IMEI%TYPE;
LN_ABONADO                                      GA_ABOCEL.NUM_ABONADO%TYPE;
LV_plantarif                                 ga_abocel.cod_plantarif%TYPE;
LV_tipcontrato                         ga_abocel.cod_tipcontrato%TYPE;
LN_modventa                                     ga_abocel.cod_modventa%TYPE;

LS_tipoprod                                     NUMBER;

LN_TpoVenta               VARCHAR(2);
LN_causa_venta         ga_abocel.COD_CAUSA_VENTA%TYPE;
LN_operacion         ga_abocel.COD_OPERACION%TYPE;
LN_cod_tiplan         ta_plantarif.COD_TIPLAN%TYPE;
LN_ind_externa         VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE;
LN_tipdcto                  gad_descuentos.TIP_DESCUENTO%TYPE;
LN_profact                  al_promfact.COD_PROMEDIO%TYPE;
LN_Registros             NUMBER(2):=0;

LV_error           VARCHAR2(200);
LV_des_error          ge_errores_pg.DesEvent;
LV_V_sSql             ge_errores_pg.vQuery;
LV_cod_tipmodi                 ICC_MOVIMIENTO.cod_actabo%TYPE;
LE_salir_sin_error EXCEPTION;
LV_COD_TIPLAN                                PV_ACTABO_TIPLAN.cod_tiplan%TYPE;
LR_hist_serie                    NP_HIST_MOVIM_SERIES_TO%ROWTYPE;

LN_monto_neto_scl        NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE; --Costo Cero

LV_comisRetail  ga_ventas.cod_tipcomis%TYPE;          -- MIX-07005 11-09-2007
LV_EstadoSerie  NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE;  -- MIX-07005 11-09-2007
LN_cod_vendedor ve_vendedores.cod_vende_raiz%TYPE;  -- MIX-07005 11-09-2007
LN_ind_canal  NP_DETSER_ACTVTA_MAYORISTAS_TO.ind_Canal%TYPE;  -- MIX-07005 11-09-2007
LN_proc_dscto_manual   NP_DETSER_ACTVTA_MAYORISTAS_TO.PORC_DSCTO_MANUAL%TYPE;
LN_dscto_manual        NP_DETSER_ACTVTA_MAYORISTAS_TO.DSCTO_MANUAL%TYPE;
LN_cod_uso     ga_equipaboser.cod_uso%TYPE;
SV_causa                                                VARCHAR2(3);
SR_config_evento    NP_CONFIG_EVENTO_TD%ROWTYPE;
LS_cod_causa        ga_equipaboser.cod_Causa%TYPE;

---
LV_moneda                                                ged_parametros.VAL_PARAMETRO%TYPE;
LV_categoria                                    ve_categorias.cod_categoria%TYPE;
LN_meses                                                    ga_percontrato.num_meses%TYPE;
LN_vendedor_vta                        ga_ventas.cod_vendedor%TYPE;
LN_cod_conceptoart   al_articulos.cod_conceptoart%TYPE;
LV_tipcomis                ga_ventas.cod_tipcomis%TYPE;
LE_salir                                                    EXCEPTION;
LN_monto_neto_scl_aux   NP_DETSER_ACTVTA_MAYORISTAS_TO.MTO_NETO_SCL%TYPE;
LN_descuento_man        NP_DETSER_ACTVTA_MAYORISTAS_TO.DSCTO_MANUAL%TYPE;


BEGIN

  SN_cod_retorno:=0;
  SN_num_evento:= 0;
  SV_mens_retorno:=NULL;

  SELECT 1 tipoprod, a.cod_modventa, a.cod_uso, a.COD_TIPCONTRATO, a.COD_PLANTARIF, 'VP' TpoVenta, a.COD_CAUSA_VENTA, a.COD_OPERACION, b.COD_TIPLAN
               ,a.num_serie, a.num_imei,  a.num_venta,a.cod_vendedor, 1
   INTO LS_tipoprod, LN_modventa, LN_USO, LV_TIPCONTRATO, LV_PLANTARIF, LN_TpoVenta, LN_CAUSA_VENTA, LN_operacion, LN_COD_TIPLAN
        ,LS_SERIE, LS_IMEI,LN_numventa,LN_cod_vendedor,LN_TipoCliente
            FROM ga_aboamist a, ta_plantarif b
   WHERE a.num_abonado   = EN_ABONADO AND
         a.COD_PLANTARIF = b.COD_PLANTARIF
   UNION
   SELECT 2 tipoprod, a.cod_modventa, a.cod_uso, a.COD_TIPCONTRATO, a.COD_PLANTARIF,
             DECODE(a.cod_uso, 2, 'VE', 'VD') TpoVenta, a.COD_CAUSA_VENTA, a.COD_OPERACION, b.COD_TIPLAN
               ,a.num_serie, a.num_imei,  a.num_venta,a.cod_vendedor, 2
   FROM ga_abocel a, ta_plantarif b
   WHERE a.num_abonado   = EN_ABONADO AND
         a.COD_PLANTARIF = b.COD_PLANTARIF AND
         b.COD_TIPLAN    = GN_tiplan_pos
   UNION
   SELECT 3 tipoprod, a.cod_modventa, a.cod_uso, a.COD_TIPCONTRATO, a.COD_PLANTARIF,
             DECODE(a.cod_uso, 2, 'VE', 'VD') TpoVenta, a.COD_CAUSA_VENTA, a.COD_OPERACION, b.COD_TIPLAN
               ,a.num_serie, a.num_imei,  a.num_venta,a.cod_vendedor, 2
   FROM ga_abocel a, ta_plantarif b
   WHERE a.num_abonado   = EN_ABONADO AND
         a.COD_PLANTARIF = b.COD_PLANTARIF AND
         b.COD_TIPLAN    = GN_tiplan_hib;


        IF LS_tipoprod = 1 AND LN_CAUSA_VENTA IS NULL THEN
           SELECT val_parametro INTO  LN_CAUSA_VENTA
                            FROM  ged_parametros
                     WHERE nom_parametro = 'COD_CAUSA_DSCTO_AMI'
                             AND cod_modulo = 'GA'
                             AND cod_producto = 1;
        END IF;

-- MIX-07005 11-09-2007
-- -- Tipo de comisionista retail parametrizado
   SELECT val_parametro
   INTO LV_comisRetail
   FROM ged_parametros
   WHERE nom_parametro  ='TIP_COMISRET';
-- FIN MIX-07005 11-09-2007

    --Obtener moneda
        SELECT trim(a.val_parametro) into LV_moneda
      FROM ged_parametros a
  WHERE a.nom_parametro=GV_MONEDALOCAL;

    --Obtener categoria del plan
    SELECT cod_categoria into LV_categoria
   FROM ve_catplantarif a
  WHERE a.cod_plantarif = LV_plantarif;

    --Obtener nro de meses,,,
    SELECT num_meses meses into LN_meses
      FROM ga_percontrato a
        WHERE a.cod_producto > 0  AND
        a.cod_tipcontrato = LV_tipcontrato;

    --Datos de la venta....
        SELECT cod_vendedor
        INTO LN_vendedor_vta
        FROM GA_VENTAS a
        WHERE a.NUM_VENTA = LN_numventa;

        select COD_TIPCOMIS
        INTO LV_tipcomis
        FROM ve_vendedores
        WHERE cod_vendedor = LN_vendedor_vta;


        select COD_TIPCOMIS
        INTO LV_tipcomis
        FROM ve_vendedores
        WHERE cod_vendedor = LN_vendedor_vta;

        SELECT a.IND_VTA_EXTERNA
        INTO LN_ind_externa
        FROM VE_TIPCOMIS a
        WHERE a.COD_TIPCOMIS = LV_tipcomis;


     NP_CLIENTE_MAYORISTA_PR (EN_cod_cliente, LN_EstadoCliente,  LC_Error);

  IF (LN_EstadoCliente = GN_MAYORISTA) OR (trim(LV_tipcomis) = trim(LV_comisRetail)) THEN

               -- Rescata el último pedido y línea a la que pertenece la serie.
                        LV_V_sSql  :='SELECT a.cod_pedido, a.lin_det_pedido from FROM npt_serie_pedido a ';
                        BEGIN
                  SELECT a.cod_pedido, a.lin_det_pedido
                                INTO LN_PEDIDO, LN_DET_PEDIDO
                    FROM npt_serie_pedido a
                   WHERE a.cod_serie_pedido = ES_SERIE     AND
                            a.cod_pedido  IN (SELECT MAX(b.cod_pedido)
                                                                                       FROM npt_serie_pedido b, npt_pedido c
                                                                                                     WHERE c.cod_cliente = EN_cod_cliente   AND
                                                                                                                                               b.cod_pedido  = c.cod_pedido AND
                                                                                                                                                                 b.cod_serie_pedido = ES_SERIE);
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                            SN_cod_retorno:=1;
                                     RAISE LE_salir;
                    END;

            -- Actualiza la tabla encabezado de mayoristas, en dos
           LV_V_sSql  := 'Update NP_ENCVTA_MAYORISTA_TO, Serie ' || ES_serie || ' Cliente ' || EN_cod_cliente;
           UPDATE np_encvta_mayorista_to
                 SET can_series_act = can_series_act + 1
            WHERE cod_pedido = LN_pedido AND lin_det_pedido = LN_det_pedido AND
                                                 cod_cliente = EN_cod_cliente;

              LV_V_sSql  := 'select npt_detalle_pedido, Pedido ' || LN_PEDIDO || ' Línea ' || LN_DET_PEDIDO;
                    BEGIN
                                SELECT cod_articulo, (mto_uni_det_pedido - mto_des_det_pedido), mto_net_det_pedido, tip_stock,cod_estado
                             INTO LN_articulo, LN_mtodesclin, LN_mtonetlin, LN_stock, LN_estado
                             FROM npt_detalle_pedido
                            WHERE cod_pedido = LN_pedido AND lin_det_pedido = LN_det_pedido;
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                            SN_cod_retorno:=1;
                                     RAISE LE_salir;
                    END;


                    LV_V_sSql  := 'select npt_pedido, Pedido ' || LN_PEDIDO;
     BEGIN
                          SELECT NUM_DOC_PEDIDO INTO LN_NUMVTA FROM npt_pedido WHERE COD_PEDIDO = LN_PEDIDO;
                    EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                            SN_cod_retorno:=1;
                                     RAISE LE_salir;
                    END;

     ln_mtonetoscl := 0;
           LN_monto_neto_scl:=0;

     LV_V_sSql  := 'IF (LV_causa IS NULL OR TRIM(LV_causa)<>CV_causa_renorepo) THEN';


                    IF LN_EstadoCliente = GN_MAYORISTA  THEN --se mantiene fase 2
                         LV_estadoserie :='PE';
                         LN_ind_canal := 0;
                      BEGIN --Inicio AL_PRECIOS_VENTA...
                            LV_V_sSql := 'Rescata Precio de Venta, Pedido ' || LN_PEDIDO || ' Articulo ' || LN_ARTICULO ;
                                  IF LN_TipoCliente = 1 THEN
                                                SELECT DISTINCT NVL(a.prc_venta, 0) INTO ln_mtonetoscl
                                                  FROM al_precios_venta a
                                                 WHERE a.tip_stock    = 2          AND --- financiado mayorista
                                                             a.cod_articulo  = ln_articulo AND
                                                                                              a.cod_uso       = ln_uso      AND--uso de la venta
                                                                a.cod_estado    = ln_estado   AND
                                                                                                 SYSDATE BETWEEN a.fec_desde  AND NVL(a.fec_hasta, SYSDATE) AND
                                                                                           a.cod_moneda    = LV_moneda    AND
                                                                                           a.cod_categoria = LV_categoria AND
                                                                                           a.NUM_MESES        = LN_meses AND
                                                                                           a.ind_recambio  = GN_INDRECAMBIO;
                            ELSE
                                     SELECT NVL(a.prc_venta, 0)  INTO ln_mtonetoscl
                                     FROM al_precios_venta a, al_articulos b
                                     WHERE a.tip_stock     = 2           AND--- financiado mayorista
                                              a.cod_articulo   = LN_articulo AND
                                                                                  a.cod_uso       = ln_uso      AND
                                                                                  a.cod_estado    = ln_estado   AND
                                                                                  SYSDATE BETWEEN a.fec_desde   AND NVL(a.fec_hasta, SYSDATE) AND
                                                                                  a.ind_recambio  = 0           AND
                                                                                  a.cod_modventa  = LN_modventa AND
                                                                                  a.num_meses     = LN_meses     AND
                                                                                  a.cod_categoria = LV_categoria AND
                                                                                  a.cod_uso      <> 3            AND
                                                                                  a.cod_articulo  = b.cod_articulo AND
                                                                                  b.ind_equiacc   = 'E';
                                  END IF;
                   EXCEPTION
                        WHEN OTHERS THEN
                        ln_mtonetoscl := 0;
                END;    -- Fin AL_PRECIOS_VENTA


                                        --Obtener tipo de plan...
                                        LV_COD_TIPLAN:=NULL;
                                        LV_V_sSql:='NP_OBTENER_TIPPLAN_FN('||EN_abonado||','||LV_COD_TIPLAN||')';
                                        IF NOT NP_OBTENER_TIPPLAN_FN(EN_abonado,LV_COD_TIPLAN,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                              NULL;
                                        END IF;

                                        --Obtener tipo de movimiento según el cod_actabo....
                                        LV_cod_tipmodi:=NULL;
                                        IF LV_COD_TIPLAN IS NOT NULL THEN
                                                    LV_V_sSql:='NP_OBTENER_TIPOACCION_FN('''||EV_COD_ACTABO||''','''||LV_COD_TIPLAN||''','''||LV_cod_tipmodi||''')';
                                                    IF NOT NP_OBTENER_TIPOACCION_FN(EV_COD_ACTABO,LV_COD_TIPLAN,LV_cod_tipmodi,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                                       NULL;
                                                    END IF;
                                        END IF;

                                        --Si el tipo de movimiento no existe entonces es el cod_actabo el que manda....
                                        IF LV_cod_tipmodi IS NULL THEN
                                                    LV_cod_tipmodi:=EV_cod_actabo;
                                        END IF;

                                    --INICIO DESCUENTO AUTOMATICO...
                                 LN_MTODESCUENTO := 0;
                                    LN_tipdcto:=0;
                                 LC_Error := '1.- Descuento Serie -' ||LS_SERIE;

                           Begin
                                      SELECT a.cod_conceptoart into LN_cod_conceptoart
                                        FROM al_articulos a
                                       WHERE a.cod_articulo = LN_articulo;
                           EXCEPTION
                                 WHEN OTHERS THEN
                                     LN_cod_conceptoart:=null;
                                 END;

                                        BEGIN
                                     LC_Error := '2.- Descuento Serie -' || ES_serie;
                                                    IF LN_ind_externa=1 THEN
                                         select a.val_descuento, a.TIP_DESCUENTO
                                                               into ln_mtodescuento, LN_tipdcto
                                       from gad_descuentos a
                                      where a.cod_operacion  = LV_cod_tipmodi        and--  'CE' cambio de equipo 'SA' cambio simcard
                                                                             a.cod_antiguedad = '01'                  and-- no existe antiguedad
                                                  a.cod_tipcontrato_nuevo = lv_tipcontrato and-- tipo contrato
                                                  a.num_meses_nuevo = LN_meses             and
                                                                                            sysdate between a.fec_desde and nvl(a.fec_hasta, sysdate) and
                                                                                            a.ind_vta_externa = LN_ind_externa     and/* sindventaext */
                                                                                            a.cod_vendealer   = LN_vendedor_vta    and
                                                                                            a.cod_causa_dscto = ln_causa_venta     and
                                                                                            a.cod_categoria         = LV_categoria       and-- categoria del plan prepago
                                                                 a.cod_modventa             = LN_modventa        and -- mod venta
                                                  a.tip_producto          = ls_tipoprod        and-- 1prepago 2 pospago - 3 hibrido
                                                  a.cod_concepto          = LN_cod_conceptoart and  -- Concepto Articulo
                                            a.clase_descuento = 'CON';
                                 ELSE
                                           select a.val_descuento, a.TIP_DESCUENTO
                                                               into ln_mtodescuento, LN_tipdcto
                                       from gad_descuentos a
                                      where a.cod_operacion  = LV_cod_tipmodi        and--  'CE' cambio de equipo 'SA' cambio simcard
                                                                             a.cod_antiguedad = '01'                  and-- no existe antiguedad
                                                  a.cod_tipcontrato_nuevo = lv_tipcontrato and-- tipo contrato
                                                  a.num_meses_nuevo = LN_meses             and
                                                                                            sysdate between a.fec_desde and nvl(a.fec_hasta, sysdate) and
                                                                                            a.ind_vta_externa = LN_ind_externa     and/* sindventaext */
                                                                                            a.cod_causa_dscto = ln_causa_venta     and
                                                                                            a.cod_categoria         = LV_categoria       and-- categoria del plan prepago
                                                                 a.cod_modventa             = LN_modventa        and -- mod venta
                                                  a.tip_producto          = ls_tipoprod        and-- 1prepago 2 pospago - 3 hibrido
                                                  a.cod_concepto          = LN_cod_conceptoart and  -- Concepto Articulo
                                            a.clase_descuento = 'CON';
                                                END IF;
                               EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                                    begin
                                                              IF LN_ind_externa=1 THEN
                                                                     select a.val_descuento, a.TIP_DESCUENTO
                                                                          into ln_mtodescuento, LN_tipdcto
                                                                    from gad_descuentos a
                                                                   where a.cod_operacion         = LV_cod_tipmodi   and--
                                                                            a.cod_antiguedad        = '01'           and-- no existe antiguedad
                                                                               a.cod_tipcontrato_nuevo = lv_tipcontrato and-- tipo contrato
                                                                               a.num_meses_nuevo             = LN_meses and
                                                                                     sysdate                   between a.fec_desde and nvl(a.fec_hasta, sysdate) and
                                                                                                                a.ind_vta_externa       = LN_ind_externa  and/* sindventaext */
                                                                                                                a.cod_vendealer         IS NULL  and
                                                                                                                a.cod_causa_dscto       = ln_causa_venta and
                                                                                                                a.cod_categoria                                 = LV_categoria   and-- categoria del plan prepago
                                                                                     a.cod_modventa                   = LN_modventa    and -- mod venta
                                                                               a.tip_producto                   = ls_tipoprod    and-- 1prepago 2 pospago - 3 hibrido
                                                                               a.cod_concepto                   = LN_cod_conceptoart and  -- Concepto Articulo
                                                                         a.clase_descuento       = 'CON';
                                                                 ELSE
                                                                        select a.val_descuento, a.TIP_DESCUENTO
                                                                             into ln_mtodescuento, LN_tipdcto
                                                           from gad_descuentos a
                                                      where a.cod_operacion         = LV_cod_tipmodi   and-- tpoventa - 'VE'venta celular 'VP' venta prepago 'VD'venta dealer  --venta
                                                            a.cod_antiguedad        = '01'           and-- no existe antiguedad
                                                                                 a.cod_tipcontrato_nuevo = lv_tipcontrato and-- tipo contrato
                                                                                 a.num_meses_nuevo             = LN_meses and
                                                                                                            sysdate                   between a.fec_desde and nvl(a.fec_hasta, sysdate) and
                                                                                                            a.ind_vta_externa       = LN_ind_externa  and/* sindventaext */
                                                                                                            a.cod_causa_dscto       = ln_causa_venta and
                                                                                                            a.cod_categoria               = LV_categoria and-- categoria del plan prepago
                                                                                 a.cod_modventa             = LN_modventa    and -- mod venta
                                                            a.tip_producto             = ls_tipoprod    and-- 1prepago 2 pospago - 3 hibrido
                                                            a.cod_concepto             = LN_cod_conceptoart and  -- Concepto Articulo
                                                      a.clase_descuento       = 'CON';
                                               END IF;
                                  exception
                                  when others then
                                       LN_mtodescuento := 0;
                                                                        LN_tipdcto:=0;
                                  end;
                                  -- Fin Descuento.....
                                 WHEN OTHERS THEN
                                   LN_mtodescuento := 0;
                                                        LN_tipdcto:=0;
                              END;

                              LC_Error := 'Calculo descuento tipo ' || LN_tipdcto || ' descuento ' || ln_mtodescuento ;
                                 if LN_tipdcto = 1 then
                                        ln_mtodescuento := (ln_mtonetoscl * ln_mtodescuento);
                                                    if ln_mtodescuento<>0 then
                                                       ln_mtodescuento:=ln_mtodescuento/ 100;
                                                    else
                                                      ln_mtodescuento := 0;
                                                    end if;
                                  end if;
                                --FIN DESCUENTO AUTOMATICO...


              --Inicio Costo Cero...
                             LC_Error := 'LN_monto_neto_scl:= round(ln_mtonetoscl - ln_mtodescuento); ln_mtonetoscl=' || ln_mtonetoscl || ' ;ln_mtodescuento= ' || ln_mtodescuento;
                       LN_monto_neto_scl:= ROUND(ln_mtonetoscl - ln_mtodescuento);

                       IF LN_monto_neto_scl=0 THEN
                                   LC_Error:='IF NOT NP_OBTENER_COSTO_MININO_FN(LN_articulo,LN_monto_neto_scl,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
                                            IF NOT NP_OBTENER_COSTO_MININO_FN(LN_articulo,LN_monto_neto_scl,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                               LN_monto_neto_scl:=0;
                                            END IF;
                       END IF;
                       --Fin Costo Cero...

                    ELSE
                           LV_estadoserie :='PE';
                           LN_ind_canal := 1;
        END IF;


       LN_monto_neto_scl_aux:=0;
       LN_descuento_man:=0;
        begin
                 SELECT B.MTO_NETO_SCL,nvl(B.DSCTO_MANUAL,0)
                  into  LN_monto_neto_scl_aux,LN_descuento_man
                   FROM NP_DETSER_ACTVTA_MAYORISTAS_TO B
                  WHERE b.cod_cliente = EN_cod_cliente AND
                        b.cod_pedido  = ln_pedido  and
                        b.num_serie   = ES_serie;

        exception
        when others then
             null;
        end;

        if LN_descuento_man<>0 then
           LN_monto_neto_scl:=LN_monto_neto_scl_aux;
        end if;



          LC_Error := 'update np_detser_actvta_mayoristas_to, Pedido=' || LN_PEDIDO || ', Serie=' || LS_SERIE || ', Cliente=' || EN_cod_cliente;
        UPDATE NP_DETSER_ACTVTA_MAYORISTAS_TO SET
             cod_estado     = LV_estadoserie,
             num_venta      = ln_numventa,
             cod_usuario    = USER,
             fec_movimiento = SYSDATE,
             mto_neto_ped   = ln_mtodesclin,
             mto_neto_scl   = LN_monto_neto_scl, --Equipo Costo Cero...
                      num_documento=NULL,
                            ind_notacdto=0,
                            ind_factmisc =0,
                            --inicio p-mix-07005...
                            cod_vendedor   = LN_cod_vendedor,
                            ind_canal      = LN_ind_canal,
          num_abonado    = EN_abonado,
       cod_Categoria  = LV_categoria,
       num_meses      = LN_meses,
       ind_recambio   = 1
                            --fin p-mix-07005...
       WHERE cod_cliente = EN_cod_cliente AND
                                        cod_pedido  = ln_pedido  and
                                                    num_serie   = ES_serie;

                            --Registrar motivo del cambio de estado de la serie....
                            if LS_cod_causa is null then
                               LS_cod_causa:='0';
                            end if;
                            SN_cod_retorno:=0;
                            SV_mens_retorno:=NULL;
                            SN_num_evento:=0;
                            LV_V_sSql:='NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN';
             SR_config_evento:=NULL;
                            IF NOT NP_GESTOR_MAYORISTAS_PG.NP_OBTENER_CONFIG_EVENTO_FN(EV_cod_actabo,'NU',LS_cod_causa,SR_config_evento,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                                        SN_cod_retorno:=0;
                                        SV_mens_retorno:=NULL;
                                        SN_num_evento:=0;
                                        SR_config_evento.COD_MOTIVO:=0;
                            END IF;

                            LR_hist_serie.COD_CLIENTE:=EN_cod_cliente;
                            LR_hist_serie.NUM_SERIE:=ES_serie;
                            LR_hist_serie.FEC_MOVIMIENTO:=SYSDATE;
                            LR_hist_serie.COD_ESTADO:=LV_estadoserie;
                            LR_hist_serie.COD_MOTIVO:=SR_config_evento.COD_MOTIVO;
                            LR_hist_serie.COD_PEDIDO:=LN_PEDIDO;
                            LR_hist_serie.COD_USUARIO:=USER;
                            LR_hist_serie.COD_ESTADOORIGEN:='NU';
                         LV_V_sSql:='IF NOT NP_INSERT_NPHISTMOVSERIES_FN(ER_hist_serie,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN';
                            IF NOT NP_INSERT_NPHISTMOVSERIES_FN(LR_hist_serie,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
                            SN_cod_retorno:=4;
                                     RAISE LE_salir;
                            END IF;

 END IF;

EXCEPTION
WHEN LE_salir_sin_error THEN
     NULL;

WHEN LE_salir THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('LE_salir: NP_REGISTRAVALORSERIE_PR('||ES_serie||','||EN_abonado||','||EN_cod_cliente||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_REGISTRAVALORSERIE_PR', LV_V_sSql, SQLCODE, LV_des_error );

WHEN OTHERS THEN
    SN_cod_retorno := '110';
    IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
      SV_mens_retorno:= CV_error_no_clasif;
    END IF;
    LV_des_error :=SUBSTR('Others: NP_REGISTRAVALORSERIE_PR('||ES_serie||','||EN_abonado||','||EN_cod_cliente||');-'||SQLERRM,1,CN_largoerrtec);
    SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,CN_largodesc);
    SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_REGISTRAVALORSERIE_PR', LV_V_sSql, SQLCODE, LV_des_error );
END NP_REGISTRAVALORSERIE_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_OBTPRECIO_PUBLICO_PR(
EN_numtrans IN ga_transacabo.num_transaccion%TYPE,
ES_SERIE IN NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE,
EN_ABONADO IN GA_ABOCEL.NUM_ABONADO%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "NP_OBTPRECIO_PUBLICO_PR"
Lenguaje="PL/V_sSql" Fecha="04-09-2007"
Versión="1.0" Diseñador="****"
Programador="Jubitza Villanueva Garrido"
Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>PL, que obtiene el precio de venta a público</Descripción>
<Parámetros>
<Entrada>
<param nom="ES_SERIE" Tipo="VARCHAR">Serie del pedido mayorista</param>
<param nom="EN_ABONADO" Tipo="NUMBER">Número del abonado que esta en la serie. </param>
</Entrada>
<Salida>
<param nom="SN_precio" Tipo="number">PRecio venta a público</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

LN_PEDIDO NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_PEDIDO%TYPE;
LN_DET_PEDIDO NP_ENCVTA_MAYORISTA_TO.LIN_DET_PEDIDO%TYPE;
LN_ARTICULO npt_detalle_pedido.COD_ARTICULO%TYPE;
LN_TipoCliente NUMBER := 0;
LN_USO npt_detalle_pedido.COD_USO%TYPE;
LN_ESTADO npt_detalle_pedido.COD_ESTADO%TYPE;
LV_plantarif ga_abocel.cod_plantarif%TYPE;
LV_tipcontrato ga_abocel.cod_tipcontrato%TYPE;
LN_modventa ga_abocel.cod_modventa%TYPE;
LN_cod_tiplan ta_plantarif.COD_TIPLAN%TYPE;

--Inicio Costo Cero
LN_cod_retorno ge_errores_pg.CodError;
LV_mens_retorno ge_errores_pg.MsgError;
LN_num_evento ge_errores_pg.Evento;
--Fin Costo Cero
LV_codretorno ga_transacabo.cod_retorno%TYPE;
LV_desretorno ga_transacabo.des_cadena%TYPE;
LN_PRECIO NUMBER;
LV_moneda ged_parametros.VAL_PARAMETRO%TYPE;
LV_categoria ve_categorias.cod_categoria%TYPE;
LN_meses ga_percontrato.num_meses%TYPE;

BEGIN

        LN_PRECIO:=0;
        LN_cod_retorno:=0;
        LN_num_evento:=0;
        LV_mens_retorno:=NULL;
        LV_TIPCONTRATO:=NULL;
        LN_modventa:=NULL;
        LV_PLANTARIF:=NULL;
        LN_TipoCliente:=NULL;
        LN_PEDIDO:=NULL;
        LN_DET_PEDIDO:=NULL;
        LN_articulo:=NULL;
        LN_uso:=NULL;
        LN_estado:=NULL;

        -- SELECT a.COD_TIPCONTRATO,a.cod_modventa,a.COD_PLANTARIF,1
        SELECT a.COD_TIPCONTRATO,a.cod_modventa,a.COD_PLANTARIF,1, a.cod_uso
        INTO LV_TIPCONTRATO,LN_modventa,LV_PLANTARIF,LN_TipoCliente, LN_USO
        FROM ga_aboamist a, ta_plantarif b
        WHERE a.num_abonado = EN_ABONADO AND
        a.COD_PLANTARIF = b.COD_PLANTARIF
        UNION
        SELECT a.COD_TIPCONTRATO,a.cod_modventa,a.COD_PLANTARIF,2, a.cod_uso
        FROM ga_abocel a, ta_plantarif b
        WHERE a.num_abonado = EN_ABONADO AND
        a.COD_PLANTARIF = b.COD_PLANTARIF AND
        b.COD_TIPLAN = GN_tiplan_pos
        UNION
        SELECT a.COD_TIPCONTRATO,a.cod_modventa,a.COD_PLANTARIF,2, a.cod_uso
        FROM ga_abocel a, ta_plantarif b
        WHERE a.num_abonado = EN_ABONADO AND
        a.COD_PLANTARIF = b.COD_PLANTARIF AND
        b.COD_TIPLAN = GN_tiplan_hib;



        --Obtener moneda--
        SELECT trim(a.val_parametro) into LV_moneda
        FROM ged_parametros a
        WHERE a.nom_parametro=GV_MONEDALOCAL;

        --Obtener categoria del plan
        SELECT cod_categoria into LV_categoria
        FROM ve_catplantarif a
        WHERE a.cod_plantarif = LV_plantarif;

        --Obtener nro de meses,,,
        SELECT num_meses meses into LN_meses
        FROM ga_percontrato a
        WHERE a.cod_producto > 0 AND
        a.cod_tipcontrato = LV_tipcontrato;


        -- Rescata el último pedido y línea a la que pertenece la serie.
        SELECT a.cod_pedido, a.lin_det_pedido
        INTO LN_PEDIDO, LN_DET_PEDIDO
        FROM npt_serie_pedido a
        WHERE a.cod_serie_pedido = ES_SERIE AND
        a.cod_pedido IN (SELECT MAX(b.cod_pedido)
        FROM npt_serie_pedido b, npt_pedido c
        WHERE b.cod_pedido = c.cod_pedido AND
        b.cod_serie_pedido = ES_SERIE);

        -- SELECT b.cod_articulo, b.cod_uso,b.cod_estado
        -- INTO LN_articulo, LN_uso, LN_estado
        SELECT b.cod_articulo, b.cod_estado
        INTO LN_articulo, LN_estado
        FROM npt_detalle_pedido b
        WHERE b.cod_pedido = LN_pedido AND
        b.lin_det_pedido = LN_det_pedido;

        BEGIN

        IF LN_TipoCliente = 1 THEN

            SELECT DISTINCT NVL(a.prc_venta, 0)
            INTO LN_PRECIO
            FROM al_precios_venta a
            WHERE a.tip_stock = 2 AND --- financiado mayorista
                a.cod_articulo = ln_articulo AND
                a.cod_uso = ln_uso AND
                a.cod_estado = ln_estado AND
                SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
                a.cod_moneda = LV_moneda AND
                a.cod_categoria= LV_categoria AND
                a.NUM_MESES = LN_meses AND
                a.ind_recambio = GN_INDRECAMBIO;

        ELSE

            SELECT a.prc_venta INTO LN_PRECIO
            FROM al_precios_venta a, al_articulos b
            WHERE a.tip_stock = 2 AND--- financiado mayorista
            a.cod_articulo = LN_articulo AND
            a.cod_uso = ln_uso AND
            a.cod_estado = ln_estado AND
            SYSDATE BETWEEN a.fec_desde AND NVL(a.fec_hasta, SYSDATE) AND
            a.ind_recambio = 0 AND
            a.cod_modventa = LN_modventa AND
            a.num_meses = LN_meses AND
            a.cod_categoria = LV_categoria AND
            a.cod_uso <> 3 AND
            a.cod_articulo = b.cod_articulo AND
            b.ind_equiacc = 'E';

        END IF;
        EXCEPTION
        WHEN OTHERS THEN
           LN_PRECIO := 0;
        END;

        --Inicio Costo Cero...
        IF LN_PRECIO=0 THEN
            IF NOT NP_OBTENER_COSTO_MININO_FN(LN_articulo,LN_PRECIO,LN_cod_retorno,LV_mens_retorno,LN_num_evento) THEN
                LN_PRECIO:=0;
            END IF;
        END IF;
        --Fin Costo Cero...

        LV_codretorno:=0;
        LV_desretorno:=LN_PRECIO;
        INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
        VALUES (EN_numtrans, LV_codretorno, LV_desretorno);


EXCEPTION
WHEN OTHERS THEN
    LN_PRECIO:=0;
    LV_codretorno:=1;
    LV_desretorno:=LN_PRECIO;
    INSERT INTO ga_transacabo (num_transaccion, cod_retorno, des_cadena)
    VALUES (EN_numtrans, LV_codretorno, LV_desretorno);
    -- RAISE_APPLICATION_ERROR(-20299,SQLERRM);
END NP_OBTPRECIO_PUBLICO_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE al_insertar_precioretail_td_pr (
          ER_precios_td      IN   AL_PRECIOS_RETAIL_TD%ROWTYPE,
                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

IS
/*
 <Documentación TipoDoc = "PROCEDURE">
 <Elemento Nombre = " al_insertar_precioretail_td_pr "
     Lenguaje="PL/V_sSql"
        Fecha="09-07-2007"
        Versión="1.0.0"
        Diseñador="Jubitza Villanueva G."
        Programador="Jubitza Villanueva G."
        Ambiente="BD">
 <Retorno>NA</Retorno>
 <Descripción>Insertar Precios canal retail</Descripción>
 <Parámetros>
 <Entrada>
             <param nom="ER_precios_td"  Tipo="REGISTRO">Registro a insertar</param>>
 </Entrada>
 <Salida>>
 </Salida>>
 </Parámetros>
 <Versionmod></Versionmod>
<Fechamod></Fechamod>
<Desmod></Desmod>
 </Elemento>
 </Documentacion>
*/
LV_sV_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
BEGIN

    SN_cod_retorno:= 0;
    SN_NUM_EVENTO:=0;
    SV_MENS_RETORNO:=NULL;

                LV_sV_sSql:='INSERT INTO al_precios_retail_td '||
                         '(COD_VENDEDOR,COD_ARTICULO,PRECIO_ARTICULO,FEC_DESDE,'||
                                              ' FEC_HASTA,USU_CREACION,FEC_CREACION,'||
                                                    '    USU_ACTUALIZA,FEC_ACTUALIZA,COD_USO,COD_ESTADO,COD_CATEGORIA,'||
                                                    ' NUM_MESES,IND_RECAMBIO)'||
                                                    'VALUES ('||ER_precios_td.cod_vendedor||','||ER_precios_td.cod_articulo||','||
                                                    ' '||ER_precios_td.precio_articulo||','||
                                                    ' '||ER_precios_td.fec_desde||','||ER_precios_td.fec_hasta||','||
                                                    ' '||ER_precios_td.usu_creacion||','||ER_precios_td.fec_creacion||','||
                                                    ' '||ER_precios_td.usu_actualiza||','||ER_precios_td.fec_actualiza||','||
                                                    ' '||ER_precios_td.cod_uso||','||ER_precios_td.cod_estado||','||ER_precios_td.cod_categoria||','||
                                                    ' '||ER_precios_td.num_meses||','||ER_precios_td.ind_recambio||')';

       INSERT INTO AL_PRECIOS_RETAIL_TD
             (COD_VENDEDOR,COD_ARTICULO,PRECIO_ARTICULO,FEC_DESDE,
                                               FEC_HASTA,USU_CREACION,FEC_CREACION,
                                                        USU_ACTUALIZA,FEC_ACTUALIZA,
                                                        COD_USO,COD_ESTADO,COD_CATEGORIA,
                                                        NUM_MESES,IND_RECAMBIO)
                  VALUES (ER_precios_td.cod_vendedor,ER_precios_td.cod_articulo,
                               ER_precios_td.precio_articulo,
                                              ER_precios_td.fec_desde,ER_precios_td.fec_hasta,
                                              ER_precios_td.usu_creacion,ER_precios_td.fec_creacion,
                                                 ER_precios_td.usu_actualiza,ER_precios_td.fec_actualiza,
                                                    ER_precios_td.cod_uso,ER_precios_td.cod_estado,ER_precios_td.cod_categoria,
                                                    ER_precios_td.num_meses,ER_precios_td.ind_recambio);


EXCEPTION
WHEN OTHERS THEN
     SN_cod_retorno := 4; -- No se pudo agregar datos.
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='Others: al_insertar_precioretail_td_pr - ' || SUBSTR(SQLERRM,1,80);
                    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'al_insertar_precioretail_td_pr', LV_sV_sSql, SQLCODE, LV_des_error );
END al_insertar_precioretail_td_pr;
------------------------------------------------------------------------------------------------------
PROCEDURE al_insertar_precioretail_th_pr (
          ER_precios_td      IN       AL_PRECIOS_RETAIL_TD%ROWTYPE,
                EV_ind_accion      IN       VARCHAR2,
                SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
                SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
                SN_num_evento      OUT NOCOPY ge_errores_pg.Evento)

IS
/*
 <Documentación TipoDoc = "PROCEDURE">
 <Elemento Nombre = "al_insertar_precioretail_th_pr "
     Lenguaje="PL/V_sSql"
        Fecha="09-07-2007"
        Versión="1.0.0"
        Diseñador="Jubitza Villanueva G."
        Programador="Jubitza Villanueva G."
        Ambiente="BD">
 <Retorno>NA</Retorno>
 <Descripción>Insertar precios canal retail historico</Descripción>
 <Parámetros>
 <Entrada>
             <param nom="ER_precios_td"  Tipo="REGISTRO">Registro a insertar</param>>
 </Entrada>
 <Salida>>
 </Salida>>
 </Parámetros>
 <Versionmod></Versionmod>
<Fechamod></Fechamod>
<Desmod></Desmod>
 </Elemento>
 </Documentacion>
*/
LV_sV_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
LN_cantidad                NUMBER;


BEGIN

    SN_cod_retorno:= 0;
    SN_NUM_EVENTO:=0;
    SV_MENS_RETORNO:=NULL;

                LV_sV_sSql:='INSERT INTO al_precios_retail_th '||
                         '(COD_VENDEDOR, COD_ARTICULO,PRECIO_ARTICULO, FEC_DESDE, FEC_HASTA, USU_CREACION, '||
                                                    ' FEC_CREACION, USU_ACTUALIZA, FEC_ACTUALIZA,COD_ACCION,'||
                                                    '    COD_USO,COD_ESTADO,COD_CATEGORIA,NUM_MESES,IND_RECAMBIO) '||
                                                    'VALUES ('||ER_precios_td.cod_vendedor||','||ER_precios_td.cod_articulo||','||
                                                    ' '||ER_precios_td.precio_articulo||','||
                                                    ' '||ER_precios_td.fec_desde||','||ER_precios_td.fec_hasta||','||
                                                    ' '||ER_precios_td.usu_creacion||','||ER_precios_td.fec_creacion||','||
                                                    ' '||ER_precios_td.usu_actualiza||','||ER_precios_td.fec_actualiza||','||
                                                    ' '||EV_ind_accion||','||
                                                    ' '||ER_precios_td.cod_uso||','||ER_precios_td.cod_estado||','||
                                                    ' '||ER_precios_td.cod_categoria||','||ER_precios_td.num_meses||','||
                                                    ' '||ER_precios_td.ind_recambio||')';


       INSERT INTO AL_PRECIOS_RETAIL_TH
                       (COD_VENDEDOR, COD_ARTICULO,PRECIO_ARTICULO, FEC_DESDE, FEC_HASTA, USU_CREACION,
                                             FEC_CREACION, USU_ACTUALIZA, FEC_ACTUALIZA,COD_ACCION,
                                                COD_USO,COD_ESTADO,COD_CATEGORIA,NUM_MESES,IND_RECAMBIO)
          VALUES (ER_precios_td.cod_vendedor,ER_precios_td.cod_articulo,
                                             ER_precios_td.precio_articulo,
                                             ER_precios_td.fec_desde,ER_precios_td.fec_hasta,
                                             ER_precios_td.usu_creacion,ER_precios_td.fec_creacion,
                                                ER_precios_td.usu_actualiza,ER_precios_td.fec_actualiza,
                                                EV_ind_accion,
                                                ER_precios_td.cod_uso,ER_precios_td.cod_estado,
                                                ER_precios_td.cod_categoria,ER_precios_td.num_meses,
                                                ER_precios_td.ind_recambio);

EXCEPTION
WHEN OTHERS THEN
     SN_cod_retorno := 4; -- No se pudo agregar datos.
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='Others: al_insertar_precioretail_th_pr - ' || SUBSTR(SQLERRM,1,80);
                    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'al_insertar_precioretail_th_pr', LV_sV_sSql, SQLCODE, LV_des_error );
END al_insertar_precioretail_th_pr;
------------------------------------------------------------------------------------------------------
PROCEDURE al_modificar_precioretail_pr (
          ER_precios_td_a       IN  OUT NOCOPY AL_PRECIOS_RETAIL_TD%ROWTYPE,
          ER_precios_td_d       IN             AL_PRECIOS_RETAIL_TD%ROWTYPE,
                SN_cod_retorno        OUT NOCOPY ge_errores_pg.CodError,
                SV_mens_retorno       OUT NOCOPY ge_errores_pg.MsgError,
                SN_num_evento         OUT NOCOPY ge_errores_pg.Evento)

IS
/*
 <Documentación TipoDoc = "PROCEDURE">
 <Elemento Nombre = "al_modificar_precioretail_pr "
     Lenguaje="PL/V_sSql"
        Fecha="09-07-2007"
        Versión="1.0.0"
        Diseñador="Jubitza Villanueva G."
        Programador="Jubitza Villanueva G."
        Ambiente="BD">
 <Retorno>NA</Retorno>
 <Descripción>Insertar Precios canal retail</Descripción>
 <Parámetros>
 <Entrada>
             <param nom="ER_precios_td"  Tipo="REGISTRO">Registro a insertar</param>>
 </Entrada>
 <Salida>>
 </Salida>>
 </Parámetros>
 <Versionmod></Versionmod>
<Fechamod></Fechamod>
<Desmod></Desmod>
 </Elemento>
 </Documentacion>
*/
LV_sV_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
BEGIN

    SN_cod_retorno:= 0;
    SN_NUM_EVENTO:=0;
    SV_MENS_RETORNO:=NULL;
                ER_precios_td_a.usu_creacion:=NULL;
                ER_precios_td_a.fec_creacion:=NULL;

             LV_sV_sSql:='select    a.USU_CREACION from al_precios_retail_td  a ';
                begin
                        select    a.USU_CREACION, a.FEC_CREACION
                          into ER_precios_td_a.usu_creacion,
                                                    ER_precios_td_a.fec_creacion
                             from AL_PRECIOS_RETAIL_TD  a
                     WHERE a.COD_VENDEDOR  = ER_precios_td_a.cod_vendedor AND
                              a.COD_ARTICULO  = ER_precios_td_a.cod_articulo AND
                                                a.FEC_DESDE                 = ER_precios_td_a.fec_desde AND
                                                a.COD_USO       = ER_precios_td_a.cod_uso AND
                                                a.COD_ESTADO    = ER_precios_td_a.cod_estado AND
                                                a.COD_CATEGORIA = ER_precios_td_a.cod_categoria AND
                                                a.NUM_MESES     = ER_precios_td_a.num_meses AND
                                                A.IND_RECAMBIO  = ER_precios_td_a.ind_recambio;
                exception
                when others then
                     null;
                end;


                LV_sV_sSql:='UPDATE  al_precios_retail_td  a ';
       UPDATE  AL_PRECIOS_RETAIL_TD  a
             SET a.FEC_DESDE       = ER_precios_td_d.fec_desde,
                    a.FEC_HASTA       = ER_precios_td_d.fec_hasta,
                                a.USU_ACTUALIZA   = ER_precios_td_d.usu_actualiza,
                                a.FEC_ACTUALIZA   = ER_precios_td_d.fec_actualiza
             WHERE a.COD_VENDEDOR  = ER_precios_td_a.cod_vendedor AND
                      a.COD_ARTICULO  = ER_precios_td_a.cod_articulo AND
                                        a.FEC_DESDE                 = ER_precios_td_a.fec_desde AND
                                        a.COD_USO       = ER_precios_td_a.cod_uso AND
                                        a.COD_ESTADO    = ER_precios_td_a.cod_estado AND
                                        a.COD_CATEGORIA = ER_precios_td_a.cod_categoria AND
                                        a.NUM_MESES     = ER_precios_td_a.num_meses AND
                                        A.IND_RECAMBIO  = ER_precios_td_a.ind_recambio;


EXCEPTION
WHEN OTHERS THEN
     SN_cod_retorno := 2; -- No se pudo actualizar datos.
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='Others: al_modificar_precioretail_pr - ' || SUBSTR(SQLERRM,1,80);
                    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'al_modificar_precioretail_pr', LV_sV_sSql, SQLCODE, LV_des_error );
END al_modificar_precioretail_pr;
------------------------------------------------------------------------------------------------------
PROCEDURE al_mantenedor_preciosretail_pr (
          EN_cod_vendedor                 IN   al_precios_retail_td.cod_vendedor%TYPE,
                EN_cod_articulo           IN   al_precios_retail_td.cod_articulo%TYPE,
          EN_precio_articulo              IN   al_precios_retail_td.precio_articulo%TYPE,
          EV_fec_desde                             IN   VARCHAR2,
          EV_fec_hasta                             IN   VARCHAR2,
          EV_fec_desde_new                      IN   VARCHAR2,
          EV_fec_hasta_new                      IN   VARCHAR2,
                EV_usuario_crea        IN   al_precios_retail_td.usu_creacion%TYPE,
          EV_fec_crea                              IN   VARCHAR2,
                EV_usuario_mod         IN   al_precios_retail_td.usu_actualiza%TYPE,
          EV_ind_accion                                  IN   VARCHAR2,
                EV_formato                                                    IN   VARCHAR2,
             EN_cod_uso                                              IN   AL_PRECIOS_RETAIL_TD.COD_USO%TYPE,
                EN_cod_estado                                  IN   AL_PRECIOS_RETAIL_TD.COD_ESTADO%TYPE,
                EV_categoria                                      IN   AL_PRECIOS_RETAIL_TD.COD_CATEGORIA%TYPE,
                EN_num_meses                                      IN   AL_PRECIOS_RETAIL_TD.COD_USO%TYPE,
                EN_recambio                                          IN   AL_PRECIOS_RETAIL_TD.IND_RECAMBIO%TYPE
                )
IS
/*
 <Documentación TipoDoc = "PROCEDURE">
 <Elemento Nombre = "al_mantenedor_preciosretail_pr"
     Lenguaje="PL/V_sSql" Fecha="09-07-2007"
        Versión="1.0.0"
        Diseñador="Jubitza Villanueva G."
        Programador="Jubitza Villanueva G."
        Ambiente="BD">
 <Retorno>NA</Retorno>
 <Descripción>MANTENEDOR de Articulos equivalentes</Descripción>
 <Parámetros>
 <Entrada>
          <param nom="EV_traslape"  Tipo="CARACTER">1=Existe traslape generar rango nuevo</param>>
 </Entrada>
 <Salida>>
 </Salida>>
 </Parámetros>
 <Versionmod></Versionmod>
<Fechamod></Fechamod>
<Desmod></Desmod>
 </Elemento>
 </Documentacion>
*/

LV_sV_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
LN_cantidad                                NUMBER;
LV_ind_accion      VARCHAR2(10);
SN_cod_retorno     ge_errores_pg.CodError;
SV_mens_retorno    ge_errores_pg.MsgError;
SN_num_evento      ge_errores_pg.Evento;
ERROR_CONTROLADO         EXCEPTION;
LV_msg                                                    VARCHAR2(100);
LR_precios_td_a    AL_PRECIOS_RETAIL_TD%ROWTYPE;
LR_precios_td_d    AL_PRECIOS_RETAIL_TD%ROWTYPE;
LD_fec_desde                            AL_PRECIOS_RETAIL_TD.fec_desde%TYPE;
LD_fec_hasta                            AL_PRECIOS_RETAIL_TD.fec_hasta%TYPE;
LV_usu_crea                                AL_PRECIOS_RETAIL_TD.USU_CREACION%TYPE;

BEGIN
  SN_cod_retorno:= 0;
  SN_NUM_EVENTO:=0;
  SV_MENS_RETORNO:=NULL;
  LV_usu_crea:=NULL;

  --Validar datos...
     IF EN_cod_articulo IS NULL  OR EN_cod_vendedor IS NULL OR
           EV_fec_desde IS NULL OR EV_fec_hasta IS NULL OR
                    EV_ind_accion IS NULL THEN
              RAISE ERROR_CONTROLADO;
        END IF;

     LV_ind_accion:= UPPER(TRIM(EV_ind_accion));
     IF LV_ind_accion <> 'I' AND LV_ind_accion <> 'U' AND LV_ind_accion <> 'D' THEN
           RAISE ERROR_CONTROLADO;
     END IF;


     LR_precios_td_a:=NULL;
        LR_precios_td_a.COD_VENDEDOR:=EN_cod_vendedor;
        LR_precios_td_a.COD_ARTICULO:=EN_cod_articulo;
     LR_precios_td_a.PRECIO_ARTICULO:=EN_precio_articulo;
        LR_precios_td_a.USU_CREACION:=EV_usuario_crea;
        LR_precios_td_a.USU_ACTUALIZA:=EV_usuario_mod;
        LR_precios_td_a.COD_USO:=EN_cod_uso;
        LR_precios_td_a.COD_ESTADO:=EN_cod_estado;
        LR_precios_td_a.COD_CATEGORIA:=EV_categoria;
        LR_precios_td_a.NUM_MESES:=EN_num_meses;
        LR_precios_td_a.IND_RECAMBIO:=EN_recambio;
        LR_precios_td_a.FEC_DESDE :=TO_DATE(EV_fec_desde,EV_formato);
        LR_precios_td_a.FEC_HASTA :=TO_DATE(EV_fec_Hasta,EV_formato);

                 IF LV_ind_accion = 'I' THEN
                       LR_precios_td_a.FEC_CREACION :=SYSDATE;
                                LV_sV_sSql:='al_insertar_precioretail_td_pr(LR_precios_td_a,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO)';
                                al_insertar_precioretail_td_pr(LR_precios_td_a,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
                                IF SN_COD_RETORNO<>0 THEN
                                LV_msg:=' Al insertar tabla de precios canal retail';
                                            RAISE ERROR_CONTROLADO;
                 END IF;
                             LR_precios_td_d:=LR_precios_td_a;
              END IF;

                    IF LV_ind_accion = 'U' THEN
                       LR_precios_td_d:=LR_precios_td_a;
                    LD_FEC_DESDE:=TO_DATE(EV_fec_desde,EV_formato);
                       LD_FEC_HASTA:=TO_DATE(EV_fec_Hasta,EV_formato);
                                LR_precios_td_d.FEC_DESDE:=TO_DATE(EV_fec_desde_new,EV_formato);
                                LR_precios_td_d.FEC_HASTA:=TO_DATE(EV_fec_Hasta_new,EV_formato);
                                LR_precios_td_d.FEC_ACTUALIZA:=SYSDATE;
                       LR_precios_td_d.FEC_CREACION:=TO_DATE(EV_fec_crea,EV_formato);

                                LV_sV_sSql:='al_actualizar_precioretail_td_pr(LR_precios_td_a,LR_precios_td_d,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO)';
                                al_modificar_precioretail_pr(LR_precios_td_a,LR_precios_td_d,
                                                                                                                                                    SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
                                IF SN_COD_RETORNO<>0 THEN
                                LV_msg:=' Al modificar tabla de precios canal retail';
                                            RAISE ERROR_CONTROLADO;
                 END IF;
                 END IF;

                    IF LV_ind_accion = 'D' THEN
                             LR_precios_td_d:=LR_precios_td_a;
                       LR_precios_td_d.FEC_CREACION:=TO_DATE(EV_fec_crea,EV_formato);

                       BEGIN
            DELETE FROM AL_PRECIOS_RETAIL_TD  a
                                 WHERE a.COD_VENDEDOR  = LR_precios_td_a.cod_vendedor AND
                                          a.COD_ARTICULO  = LR_precios_td_a.cod_articulo AND
                                                            a.FEC_DESDE                 = LR_precios_td_a.fec_desde AND
                                                            a.COD_USO       = LR_precios_td_a.cod_uso AND
                                                            a.COD_ESTADO    = LR_precios_td_a.cod_estado AND
                                                            a.COD_CATEGORIA = LR_precios_td_a.cod_categoria AND
                                                            a.NUM_MESES     = LR_precios_td_a.num_meses AND
                                                            A.IND_RECAMBIO  = LR_precios_td_a.ind_recambio;
                      EXCEPTION
                            WHEN OTHERS THEN
                                 NULL;
                            END;
                    END IF;

                    LV_sV_sSql:='al_insertar_precioretail_th_pr(LR_precios_td_a,LV_ind_accion,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO)';
                    al_insertar_precioretail_th_pr(LR_precios_td_d,LV_ind_accion,SN_COD_RETORNO,SV_MENS_RETORNO,SN_NUM_EVENTO);
                    IF SN_COD_RETORNO<>0 THEN
                             LV_msg:=' Al insertar tabla de precios canal retail - historico';
                                RAISE ERROR_CONTROLADO;
              END IF;



EXCEPTION
WHEN ERROR_CONTROLADO THEN
              SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='ERROR_CONTROLADO: al_mantenedor_preciosretail_pr - ' || SUBSTR(SQLERRM,1,80);
                    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'al_mantenedor_preciosretail_pr', LV_sV_sSql, SQLCODE, LV_des_error );
                    RAISE_APPLICATION_ERROR  (-20001,'Error: '|| LV_msg);
WHEN OTHERS THEN
                SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='ERROR_CONTROLADO: al_mantenedor_preciosretail_pr - ' || SUBSTR(SQLERRM,1,80);
                    SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'al_mantenedor_preciosretail_pr', LV_sV_sSql, SQLCODE, LV_des_error );
                    RAISE_APPLICATION_ERROR  (-20001,'Error: '|| LV_msg);
END al_mantenedor_preciosretail_pr;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION NP_OBTENER_VALOR_FINAL_FN
(EN_mayorista      IN                             VARCHAR2,
 EN_FechaDesde      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.FEC_MOVIMIENTO%TYPE,
 EN_FechaHasta      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.FEC_MOVIMIENTO%TYPE,
 EN_serie          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE,
 EN_estado          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE,
 EN_financiado    IN                             VARCHAR2
) RETURN NUMBER

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_VALOR_FINAL_FN"
      Lenguaje="PL/V_sSql"
      Fecha="02-08-2007"
      Versión="1.0"
      Diseñador="Maritza Tapia A.
      Programador="Maritza Tapia A"
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener el total de consulta de composición Final</Descripción>
      <Parámetros>
         <Entrada>
                  param nom="EN_mayorista    "   Tipo="NUMERICO">Código de Mayorista</param>
                 param nom="EN_FechaDesde"      Tipo="Varchar">Fecha Desde</param>
                 param nom="EN_FechaHasta"      Tipo="Varchar">Fecha Hasta</param>
                 param nom="EN_serie"           Tipo="Varchar">Numero de Serie</param>
                 param nom="EN_estado"           Tipo="Varchar">Estado</param>
                  param nom="EN_financiado"       Tipo="Varchar">Financiamiento</param>
            </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
V_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
SN_cod_retorno          ge_errores_pg.CodError;
SV_mens_retorno         ge_errores_pg.MsgError;
SN_num_evento           ge_errores_pg.Evento;
LV_msg                    VARCHAR2(100);
LN_TOTAL                NUMBER(7);
sQuery                VARCHAR2(32767);



BEGIN
 SN_cod_retorno:= 0;
 SN_NUM_EVENTO:=0;
 SV_MENS_RETORNO:=CV_cero;


    V_sSql := 'SELECT SUM(d.total)';
    V_sSql := V_sSql  ||  '     INTO LN_TOTAL';
    V_sSql := V_sSql  ||  '     FROM ';
    V_sSql := V_sSql  ||  '     ( SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_abocel c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_serie ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)';
    V_sSql := V_sSql  ||  '     UNION';
    V_sSql := V_sSql  ||  '     SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_aboamist c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_serie ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)';
    V_sSql := V_sSql  ||  '     UNION';
    V_sSql := V_sSql  ||  '     SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_abocel c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_imei ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)';
    V_sSql := V_sSql  ||  '     UNION';
    V_sSql := V_sSql  ||  '     SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_aboamist c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_imei ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)    ';
    V_sSql := V_sSql  ||  '     )d;    ';



    LV_msg := 'Query que validará la cantidad total de registros';

    SELECT count(1)
    INTO LN_TOTAL
    FROM  (select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM     (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x,
                       ge_clientes b, ga_abocel c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_serie
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)
    AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie   = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    UNION
    select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x ,
                             ge_clientes b, ga_aboamist c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_serie
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)
    AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie     = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    UNION
    select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x, ge_clientes b,ga_abocel c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_imei
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)
    AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie     = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    UNION
    select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM     (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x, ge_clientes b, ga_aboamist c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_imei
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)
    AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie     = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    ) d;



    RETURN LN_TOTAL;

EXCEPTION
WHEN OTHERS THEN
     SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='ERROR_CONTROLADO: NP_OBTENER_VALOR_FINAL_FN - ' || SUBSTR(SQLERRM,1,80);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_VALOR_FINAL_FN', V_sSql, SQLCODE, LV_des_error );
     RAISE_APPLICATION_ERROR  (-20002,'Error: '|| LV_msg);
     RETURN -1;
END NP_OBTENER_VALOR_FINAL_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE NP_OBTENER_DATOS_FINAL_PR
(EN_mayorista      IN                             VARCHAR2,
 EN_FechaDesde      IN                             VARCHAR2,
 EN_FechaHasta      IN                             VARCHAR2,
 EN_serie          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE,
 EN_estado          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE ,
 EN_financiado    IN                             VARCHAR2,
 SV_mens_retorno  OUT NOCOPY VARCHAR2,
 tSeries          OUT NOCOPY refcursor
)

/*
<Documentación
  TipoDoc = "Procedure">
   <Elemento
      Nombre = "NP_OBTENER_VALOR_FINAL_FN"
      Lenguaje="PL/V_sSql"
      Fecha="02-08-2007"
      Versión="1.0"
      Diseñador="Maritza Tapia A.
      Programador="Maritza Tapia A"
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener el total de consulta de composición Final</Descripción>
      <Parámetros>
         <Entrada>
                  param nom="EN_mayorista    "   Tipo="NUMERICO">Código de Mayorista</param>
                 param nom="EN_FechaDesde"      Tipo="Varchar">Fecha Desde</param>
                 param nom="EN_FechaHasta"      Tipo="Varchar">Fecha Hasta</param>
                 param nom="EN_serie"           Tipo="Varchar">Numero de Serie</param>
                 param nom="EN_estado"           Tipo="Varchar">Estado</param>
                  param nom="EN_financiado"       Tipo="Varchar">Financiamiento</param>
            </Entrada>
         <Salida>
            <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="tSeries "         Tipo="Cursor">Consulta de composicion de Precio</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS

V_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
SN_cod_retorno          ge_errores_pg.CodError;
--SV_mens_retorno         ge_errores_pg.MsgError;
SN_num_evento           ge_errores_pg.Evento;
LV_msg                    VARCHAR2(100);
LN_TOTAL                NUMBER(7);


BEGIN
 SN_cod_retorno:= 0;
 SN_NUM_EVENTO:=0;
 SV_mens_retorno := CV_cero;


    V_sSql := 'OPEN tSeries FOR';
    V_sSql := V_sSql  ||  '     SELECT  cliente,   mayorista, serie,  estado, mto_scl,  mto_ped,  desct ,  modventa';
    V_sSql := V_sSql  ||  '     FROM ';
    V_sSql := V_sSql  ||  '     ( SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_abocel c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_serie ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)';
    V_sSql := V_sSql  ||  '     UNION';
    V_sSql := V_sSql  ||  '     SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_aboamist c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_serie ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)';
    V_sSql := V_sSql  ||  '     UNION';
    V_sSql := V_sSql  ||  '     SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_abocel c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_imei ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)';
    V_sSql := V_sSql  ||  '     UNION';
    V_sSql := V_sSql  ||  '     SELECT  count(1) total ';
    V_sSql := V_sSql  ||  '     FROM ga_aboamist c, ge_clientes b, np_detser_actvta_mayoristas_to a ';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente ';
    V_sSql := V_sSql  ||  '     AND a.num_serie = c.num_imei ';
    V_sSql := V_sSql  ||  '     AND a.cod_estado not in CV_NU';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)  ';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE(EN_FechaDesde,NULL,trunc(a.fec_movimiento),EN_FechaDesde)';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE(EN_FechaHasta,NULL,trunc(a.fec_movimiento),EN_FechaHasta)';
    V_sSql := V_sSql  ||  '     AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)    ';
    V_sSql := V_sSql  ||  '     )d;    ';



    LV_msg := 'Query que validará la cantidad total de registros';


    OPEN tSeries FOR
    SELECT  cliente,   mayorista, serie,  estado, mto_scl,  mto_ped,  desct ,  modventa
    FROM  (select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM     (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x,
                       ge_clientes b, ga_abocel c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_serie
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(to_date(EN_FechaDesde,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaDesde,'DD-MM-YYYY'))
    AND trunc(a.fec_movimiento)<= DECODE(to_date(EN_FechaHasta,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaHasta,'DD-MM-YYYY'))
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie   = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    UNION
    select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x ,
                             ge_clientes b, ga_aboamist c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_serie
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(to_date(EN_FechaDesde,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaDesde,'DD-MM-YYYY'))
    AND trunc(a.fec_movimiento)<= DECODE(to_date(EN_FechaHasta,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaHasta,'DD-MM-YYYY'))
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie     = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    UNION
    select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x, ge_clientes b,ga_abocel c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_imei
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(to_date(EN_FechaDesde,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaDesde,'DD-MM-YYYY'))
    AND trunc(a.fec_movimiento)<= DECODE(to_date(EN_FechaHasta,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaHasta,'DD-MM-YYYY'))
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie     = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    UNION
    select a.cod_cliente cliente,  b.nom_cliente || ' ' || b.nom_apeclien1 || ' ' || b.nom_apeclien2 mayorista, a.num_serie serie,
          decode(a.cod_estado, 'PE','Pendiente','SP','Sin Precio','RD','Recuperar Descuento','AP','Aplicado','DV','Devolución','ER','En Revisión','ND','No disponible','Sin Estado') estado,
          a.mto_neto_scl mto_scl, a.mto_neto_ped mto_ped, a.dscto_manual desct , decode(c.cod_modventa,7,'Financiado','No Financiado')  modventa
    FROM     (select DECODE(cod_modventa,7,0,1) COD, cod_modventa VAL from ge_modventa) x, ge_clientes b, ga_aboamist c, np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.num_serie = c.num_imei
    AND a.num_venta = c.num_venta
    AND a.cod_estado not in CV_NU
    AND a.num_venta = c.num_venta
    AND ( EN_financiado IS NULL OR (X.COD = EN_financiado AND      c.cod_modventa = X.VAL))
    AND trunc(a.fec_movimiento)>= DECODE(to_date(EN_FechaDesde,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaDesde,'DD-MM-YYYY'))
    AND trunc(a.fec_movimiento)<= DECODE(to_date(EN_FechaHasta,'DD-MM-YYYY'),NULL,trunc(a.fec_movimiento),to_date(EN_FechaHasta,'DD-MM-YYYY'))
    AND  a.cod_estado = DECODE(EN_estado, NULL, a.cod_estado,EN_estado)
    AND a.num_serie     = DECODE (EN_serie    , NULL, a.num_serie, EN_serie)
    AND a.cod_cliente   = DECODE (EN_mayorista, NULL, a.cod_cliente, EN_mayorista)
    ) d;

EXCEPTION
WHEN OTHERS THEN
     SN_cod_retorno := 156;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='ERROR_CONTROLADO: NP_OBTENER_DATOS_FINAL_PR - ' ; --|| SUBSTR(SQLERRM,1,80);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_DATOS_FINAL_PR', V_sSql, SQLCODE, LV_des_error );
     RAISE_APPLICATION_ERROR  (-20002,'Error: '|| LV_msg);
END NP_OBTENER_DATOS_FINAL_PR;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION NP_OBTENER_TOTAL_SERIESSP_FN
(EV_mayorista      IN                             VARCHAR2,
 EN_Articulo      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ARTICULO%TYPE,
 EV_Canal          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_VENDEDOR%TYPE,
 EV_FechaDesde      IN                             VARCHAR2,
 EV_FechaHasta      IN                             VARCHAR2
) RETURN NUMBER

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_TOTAL_SERIESSP_FN"
      Lenguaje="PL/V_sSql"
      Fecha="02-08-2007"
      Versión="1.0"
      Diseñador="Maritza Tapia A.
      Programador="Maritza Tapia A"
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener el total de consulta de composición Final</Descripción>
      <Parámetros>
         <Entrada>
                  param nom="EN_mayorista    "   Tipo="NUMERICO">Código de Mayorista</param>
                 param nom="EN_FechaDesde"      Tipo="Varchar">Fecha Desde</param>
                 param nom="EN_FechaHasta"      Tipo="Varchar">Fecha Hasta</param>
                 param nom="EN_serie"           Tipo="Varchar">Numero de Serie</param>
                 param nom="EN_estado"           Tipo="Varchar">Estado</param>
                  param nom="EN_financiado"       Tipo="Varchar">Financiamiento</param>
            </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
V_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
SN_cod_retorno          ge_errores_pg.CodError;
SV_mens_retorno         ge_errores_pg.MsgError;
SN_num_evento           ge_errores_pg.Evento;
LV_msg                    VARCHAR2(100);
LN_TOTAL                NUMBER(7);


BEGIN
 SN_cod_retorno:= 0;
 SN_NUM_EVENTO:=0;
 SV_MENS_RETORNO:=NULL;


    V_sSql := 'SELECT COUNT (1)';
    V_sSql := V_sSql  ||  '     FROM al_estados h, al_usos g,  al_articulos c, ge_clientes b, npt_detalle_pedido d,npt_serie_pedido e,  np_detser_actvta_mayoristas_to a';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente';
    V_sSql := V_sSql  ||  '     AND a.cod_articulo = c.cod_articulo';
    V_sSql := V_sSql  ||  '     AND a.cod_articulo = d.cod_articulo';
    V_sSql := V_sSql  ||  '     AND a.cod_pedido =   e.cod_pedido';
    V_sSql := V_sSql  ||  '     AND a.cod_pedido  = d.cod_pedido';
    V_sSql := V_sSql  ||  '     AND e.lin_det_pedido = d.lin_det_pedido';
 V_sSql := V_sSql  ||  '     AND e.cod_serie_pedido=a.num_serie';
    V_sSql := V_sSql  ||  '     AND g.cod_uso  = (select x.cod_uso from ga_abocel x where a.num_abonado = x.num_abonado union ';
    V_sSql := V_sSql  ||  '     select y.cod_uso from ga_aboamist y where  a.num_abonado = y.num_abonado)';
    V_sSql := V_sSql  ||  '     AND d.cod_estado = h.cod_estado';
    V_sSql := V_sSql  ||  '     AND a.cod_estado = CV_SP';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE('||EV_FechaDesde ||',NULL,trunc(a.fec_movimiento),to_date('||EV_FechaDesde||', dd-mm-yyyy))';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE('||EV_FechaHasta ||',NULL,trunc(a.fec_movimiento),to_date('||EV_FechaHasta||', dd-mm-yyyy))';
    V_sSql := V_sSql  ||  '     AND a.cod_articulo   = DECODE ('||EN_Articulo||', NULL,  a.cod_articulo, EN_Articulo)';
    V_sSql := V_sSql  ||  '     AND a.cod_vendedor   = DECODE ('||EV_Canal||', NULL, a.cod_vendedor, '|| EV_Canal||')';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE ('||EV_mayorista||', NULL, a.cod_cliente, '||EV_mayorista||');';



    LV_msg := 'Query que validará la cantidad total de registros';


    SELECT COUNT (1)
    INTO LN_TOTAL
    FROM al_usos g,  al_articulos c, ge_clientes b, npt_detalle_pedido d,npt_serie_pedido e,  np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.cod_articulo = c.cod_articulo
    AND a.cod_articulo = d.cod_articulo
    AND a.cod_pedido =   e.cod_pedido
    AND a.cod_pedido  = d.cod_pedido
    AND e.lin_det_pedido = d.lin_det_pedido
        AND e.cod_serie_pedido=a.num_serie
    AND g.cod_uso = (select x.cod_uso from ga_abocel x where a.num_abonado = x.num_abonado union  --27-12-2007
        select y.cod_uso from ga_aboamist y where  a.num_abonado = y.num_abonado) --27-12-2007
    AND a.cod_estado = CV_SP
    AND trunc(a.fec_movimiento)>= DECODE(EV_FechaDesde,NULL,trunc(a.fec_movimiento),EV_FechaDesde)
    AND trunc(a.fec_movimiento)<= DECODE(EV_FechaHasta,NULL,trunc(a.fec_movimiento),EV_FechaHasta)
    AND a.cod_articulo   = DECODE (EN_Articulo, NULL,  a.cod_articulo, EN_Articulo)
    AND a.cod_vendedor   = DECODE (EV_Canal, NULL, a.cod_vendedor, EV_Canal)
    AND a.cod_cliente   = DECODE (EV_mayorista, NULL, a.cod_cliente, EV_mayorista);

    RETURN LN_TOTAL;

EXCEPTION
WHEN OTHERS THEN
     SN_cod_retorno := 1;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='ERROR_CONTROLADO: NP_OBTENER_VALOR_FINAL_FN - ' ; --|| SUBSTR(SQLERRM,1,80);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_VALOR_FINAL_FN', V_sSql, SQLCODE, LV_des_error );
     RAISE_APPLICATION_ERROR  (-20002,'Error: '|| LV_msg);
     RETURN -1;
END NP_OBTENER_TOTAL_SERIESSP_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_OBTENER_SERIESSP_PR
(EV_mayorista      IN                             VARCHAR2,
 EN_Articulo      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ARTICULO%TYPE,
 EV_Canal          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_VENDEDOR%TYPE,
 EV_FechaDesde      IN                             VARCHAR2,
 EV_FechaHasta      IN                             VARCHAR2,
 SV_mens_retorno  OUT NOCOPY VARCHAR2,
 tSeries          OUT NOCOPY refcursor
)

/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_TOTAL_SERIESSP_FN"
      Lenguaje="PL/V_sSql"
      Fecha="02-08-2007"
      Versión="1.0"
      Diseñador="Maritza Tapia A.
      Programador="Maritza Tapia A"
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener el total de consulta de composición Final</Descripción>
      <Parámetros>
         <Entrada>
                  param nom="EN_mayorista    "   Tipo="NUMERICO">Código de Mayorista</param>
                 param nom="EN_FechaDesde"      Tipo="Varchar">Fecha Desde</param>
                 param nom="EN_FechaHasta"      Tipo="Varchar">Fecha Hasta</param>
                 param nom="EN_serie"           Tipo="Varchar">Numero de Serie</param>
                 param nom="EN_estado"           Tipo="Varchar">Estado</param>
                  param nom="EN_financiado"       Tipo="Varchar">Financiamiento</param>
            </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
V_sSql                  ge_errores_pg.vQuery;
LV_des_error             ge_errores_pg.DesEvent;
SN_cod_retorno          ge_errores_pg.CodError;
SN_num_evento           ge_errores_pg.Evento;
LV_msg                    VARCHAR2(100);
LN_TOTAL                NUMBER(7);


BEGIN
 SN_cod_retorno:= 0;
 SN_NUM_EVENTO:=0;
 SV_mens_retorno := CV_cero;


    V_sSql := 'SELECT a.cod_cliente,';
    V_sSql := V_sSql  ||  '     b.nom_cliente|| || b.nom_apeclien1|| || b.nom_apeclien2 mayorista,';
    V_sSql := V_sSql  ||  '     decode(a.cod_vendedor, NULL,0,a.cod_vendedor),  a. cod_articulo, c.des_articulo,';
    V_sSql := V_sSql  ||  '     a.num_serie , a.cod_pedido, to_char(a.fec_movimiento,dd-mm-yyyy hh24:mi:ss), g.des_uso, h.des_estado';
    V_sSql := V_sSql  ||  '     FROM al_estados h, al_usos g,  al_articulos c, ge_clientes b, npt_detalle_pedido d,npt_serie_pedido e,  np_detser_actvta_mayoristas_to a';
    V_sSql := V_sSql  ||  '     WHERE a.cod_cliente = b.cod_cliente';
    V_sSql := V_sSql  ||  '     AND a.cod_articulo = c.cod_articulo';
    V_sSql := V_sSql  ||  '     AND a.cod_articulo = d.cod_articulo';
    V_sSql := V_sSql  ||  '     AND a.cod_pedido =   e.cod_pedido';
    V_sSql := V_sSql  ||  '     AND a.cod_pedido  = d.cod_pedido';
    V_sSql := V_sSql  ||  '     AND e.lin_det_pedido = d.lin_det_pedido';
    V_sSql := V_sSql  ||  '     AND e.cod_serie_pedido=a.num_serie    ';
    V_sSql := V_sSql  ||  '     AND g.cod_uso =  (select x.cod_uso from ga_abocel x where a.num_abonado = x.num_abonado union ';
    V_sSql := V_sSql  ||  '     select y.cod_uso from ga_aboamist y where  a.num_abonado = y.num_abonado)';
    V_sSql := V_sSql  ||  '     AND d.cod_estado = h.cod_estado';
    V_sSql := V_sSql  ||  '     AND a.cod_estado = CV_SP';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)>= DECODE('||EV_FechaDesde ||',NULL,trunc(a.fec_movimiento),to_date('||EV_FechaDesde||', dd-mm-yyyy))';
    V_sSql := V_sSql  ||  '     AND trunc(a.fec_movimiento)<= DECODE('||EV_FechaHasta ||',NULL,trunc(a.fec_movimiento),to_date('||EV_FechaHasta||', dd-mm-yyyy))';
    V_sSql := V_sSql  ||  '     AND a.cod_articulo   = DECODE ('||EN_Articulo||', NULL,  a.cod_articulo, EN_Articulo)';
    V_sSql := V_sSql  ||  '     AND a.cod_vendedor   = DECODE ('||EV_Canal||', NULL, a.cod_vendedor, '|| EV_Canal||')';
    V_sSql := V_sSql  ||  '     AND a.cod_cliente   = DECODE ('||EV_mayorista||', NULL, a.cod_cliente, '||EV_mayorista||');';

 LV_msg := 'Query que validará la cantidad total de registros';

    OPEN tSeries FOR
    SELECT a.cod_cliente,
       b.nom_cliente|| ' '|| b.nom_apeclien1|| ' '|| b.nom_apeclien2 mayorista,
       decode(a.cod_vendedor, NULL,0, a.cod_vendedor),  a. cod_articulo, c.des_articulo,
       a.num_serie , a.cod_pedido, to_char(a.fec_movimiento,'dd-mm-yyyy hh24:mi:ss'), g.des_uso, h.des_estado
    FROM al_estados h, al_usos g,  al_articulos c, ge_clientes b, npt_detalle_pedido d,npt_serie_pedido e,  np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.cod_articulo = c.cod_articulo
    AND a.cod_articulo = d.cod_articulo
    AND a.cod_pedido =   e.cod_pedido
    AND a.cod_pedido  = d.cod_pedido
    AND e.lin_det_pedido = d.lin_det_pedido
    AND e.cod_serie_pedido=a.num_serie
    AND g.cod_uso =  (select x.cod_uso from ga_abocel x where a.num_abonado = x.num_abonado union  --27-12-2007
        select y.cod_uso from ga_aboamist y where  a.num_abonado = y.num_abonado) --27-12-2007
    AND d.cod_estado = h.cod_estado
    AND a.cod_estado = CV_SP
    AND trunc(a.fec_movimiento)>= DECODE(to_date(EV_FechaDesde,'dd-mm-yyyy'),NULL,trunc(a.fec_movimiento),to_date(EV_FechaDesde, 'dd-mm-yyyy'))
    AND trunc(a.fec_movimiento)<= DECODE(to_date(EV_FechaHasta,'dd-mm-yyyy'),NULL,trunc(a.fec_movimiento),to_date(EV_FechaHasta, 'dd-mm-yyyy'))
    AND a.cod_articulo   = DECODE (EN_Articulo, NULL,  a.cod_articulo, EN_Articulo)
    AND a.cod_vendedor   = DECODE (EV_Canal, NULL, a.cod_vendedor, EV_Canal)
    AND a.cod_cliente   = DECODE (EV_mayorista, NULL, a.cod_cliente, EV_mayorista);



EXCEPTION
WHEN OTHERS THEN
     SN_cod_retorno := 1;
     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
        SV_mens_retorno := CV_error_no_clasif;
     END IF;
     LV_des_error :='ERROR_CONTROLADO: NP_OBTENER_VALOR_FINAL_FN - ' ; --|| SUBSTR(SQLERRM,1,80);
     SN_num_evento := Ge_Errores_Pg.Grabarpl(SN_num_evento, CV_cod_modulo,SV_mens_retorno, CV_version, USER, 'NP_OBTENER_VALOR_FINAL_FN', V_sSql, SQLCODE, LV_des_error );
     RAISE_APPLICATION_ERROR  (-20002,'Error: '|| LV_msg);
END NP_OBTENER_SERIESSP_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE NP_UPDATE_SERIESSP_PR
(EV_mayorista      IN                             VARCHAR2,
 EN_Articulo      IN                             VARCHAR2,
 EV_Canal          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_VENDEDOR%TYPE,
 EV_FechaDesde      IN                             VARCHAR2,
 EV_FechaHasta      IN                             VARCHAR2,
 EN_Uso           IN                             AL_PRECIOS_RETAIL_TD.COD_USO%TYPE,
 EN_estado          IN                             AL_PRECIOS_RETAIL_TD.COD_ESTADO%TYPE,
 EV_Categoria     IN                             AL_PRECIOS_RETAIL_TD.COD_CATEGORIA%TYPE,
 EN_Meses          IN                             AL_PRECIOS_RETAIL_TD.NUM_MESES%TYPE,
 EV_Ventas        IN                             VARCHAR2
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "NP_OBTENER_TOTAL_SERIESSP_FN"
      Lenguaje="PL/V_sSql"
      Fecha="02-08-2007"
      Versión="1.0"
      Diseñador="Maritza Tapia A.
      Programador="Maritza Tapia A"
      Ambiente Desarrollo="BD">
      <Retorno>Boolean. False si se produce error</Retorno>
      <Descripción>Obtener el total de consulta de composición Final</Descripción>
      <Parámetros>
         <Entrada>
                  param nom="EN_mayorista    "   Tipo="NUMERICO">Código de Mayorista</param>
                 param nom="EN_FechaDesde"      Tipo="Varchar">Fecha Desde</param>
                 param nom="EN_FechaHasta"      Tipo="Varchar">Fecha Hasta</param>
                 param nom="EN_serie"           Tipo="Varchar">Numero de Serie</param>
                 param nom="EN_estado"           Tipo="Varchar">Estado</param>
                  param nom="EN_financiado"       Tipo="Varchar">Financiamiento</param>
            </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_msg                    VARCHAR2(100);
LN_TOTAL                NUMBER(7);
LN_precio               al_precios_retail_td.precio_articulo%TYPE;
LN_hay               number(1);


CURSOR leeserie IS
    SELECT a.cod_cliente, a.cod_pedido, a.num_serie, a.fec_movimiento, a.cod_articulo,a.cod_vendedor
    FROM  ge_clientes b, npt_detalle_pedido d, npt_serie_pedido e,  np_detser_actvta_mayoristas_to a
    WHERE a.cod_cliente = b.cod_cliente
    AND a.cod_pedido =   e.cod_pedido
    AND a.cod_pedido  = d.cod_pedido
    AND e.lin_det_pedido = d.lin_det_pedido
    AND e.cod_serie_pedido=a.num_serie
    AND EN_Uso = (select x.cod_uso from ga_abocel x where a.num_abonado = x.num_abonado union  --27-12-2007
        select y.cod_uso from ga_aboamist y where  a.num_abonado = y.num_abonado) --27-12-2007
    AND d.cod_estado = EN_estado
 AND a.cod_estado = CV_SP
 AND a.cod_categoria = EV_Categoria
    AND a.ind_recambio = EV_Ventas
    AND a.num_meses =   EN_Meses
 AND a.cod_cliente   =  DECODE (EV_mayorista, NULL, a.cod_cliente, EV_mayorista)
    AND a.cod_vendedor  = DECODE (EV_Canal, NULL, a.cod_vendedor, EV_Canal)
    AND trunc(a.fec_movimiento)>= DECODE(to_date(EV_FechaDesde,'DD-MM-YYYY'),NULL, trunc(a.fec_movimiento),to_date(EV_FechaDesde, 'dd-mm-yyyy'))
 AND trunc(a.fec_movimiento)<= DECODE(to_date(EV_FechaHasta,'DD-MM-YYYY'),NULL, trunc(a.fec_movimiento),to_date(EV_FechaHasta,'dd-mm-yyyy'))
 AND a.cod_articulo   = DECODE (EN_Articulo, NULL,  a.cod_articulo, EN_Articulo);

BEGIN

       FOR J IN leeserie LOOP
              LN_precio:=0;
              LN_hay:=1;
              begin
              SELECT NVL(a.precio_articulo,0) INTO LN_precio   FROM  al_precios_retail_td a
          Where  a.fec_hasta >= j.fec_movimiento
        AND    a.ind_recambio = EV_Ventas
        AND    a.num_meses =  EN_Meses
        AND    a.cod_categoria = EV_Categoria
        AND    a.cod_estado = EN_estado
        AND    a.cod_uso = EN_Uso
        AND    a.fec_desde <= j.fec_movimiento
        AND    a.cod_articulo = j.cod_articulo
            AND    a.cod_vendedor = j.cod_vendedor;
            exception
            when others then
                 LN_hay:=0;
            end;

            IF ln_hay=1 then
                       BEGIN
                                   UPDATE NP_DETSER_ACTVTA_MAYORISTAS_TO b
                                  SET  b.cod_estado     = CV_PE,
                                             b.mto_neto_scl   = LN_precio,
                                                                        b.fec_movimiento = SYSDATE
                                             WHERE b.cod_estado = CV_SP
                                                 AND b.num_serie = j.num_serie
                                                 AND b.cod_pedido = j.cod_pedido
                                                 AND b.cod_cliente = j.cod_cliente;

                                            --insertar el cambio en el historico de series.....

                                 INSERT INTO np_hist_movim_series_to
                                                                             (cod_cliente, num_serie, fec_movimiento, cod_estado, cod_motivo, cod_pedido, cod_usuario, cod_estadoorigen)
                                                                        VALUES
                                                                             (j.cod_cliente, j.num_serie    , SYSDATE, CV_PE, 0, j.cod_pedido, USER, CV_SP);
                       EXCEPTION
                       WHEN OTHERS THEN
                                NULL;
                       END;
            end if;
       END LOOP;


EXCEPTION
         WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20158, SQLCODE || ' - ' || SQLERRM);
END NP_UPDATE_SERIESSP_PR;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_VENDEDOR_FN(EN_Cod_Vendedor     IN          ve_vendedores.Cod_Vendedor%TYPE)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Funcion">
<Elemento Nombre = "AL_VALIDA_VENDEDOR_PR"
Lenguaje="PL/V_sSql" Fecha="23-10-2007"
Versión="1.0" Diseñador="****"
Programador="Luis Munoz"
 Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Valida Vendedor</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_Cod_Vendedor" Tipo="NUMBER">Codigo Vendedor</param>
    </Entrada>
    <Salida>
     <param nom="" Tipo="Boolean></param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

  LB_retorno BOOLEAN:=TRUE;
  LN_cantidad  NUMBER;
  LV_tipcomis  ve_vendedores.cod_tipcomis%TYPE;
  CN_producto     CONSTANT NUMBER(2):=1;
  CV_modulo     CONSTANT VARCHAR2(2):='AL';
  CV_comiret    CONSTANT VARCHAR2(15):='TIP_COMISRET';
  CN_cero        CONSTANT NUMBER(2):=0;

BEGIN

     BEGIN
        SELECT a.val_parametro  INTO LV_tipcomis
        From ged_parametros a
        Where a.nom_parametro = CV_comiret AND a.COD_MODULO=CV_modulo AND A.COD_PRODUCTO=CN_producto;
     EXCEPTION
        WHEN OTHERS THEN
         LB_retorno:=FALSE;
     END;

     IF LV_tipcomis IS NULL THEN
        LB_retorno:=FALSE;
     ELSE
         BEGIN
             SELECT count(1)
             INTO LN_cantidad
             FROM ve_vendedores a
             WHERE a.cod_vendedor=EN_Cod_Vendedor
               AND a.cod_tipcomis = LV_tipcomis;
         EXCEPTION
            WHEN OTHERS THEN
             LB_retorno:=FALSE;
         END;

         IF LN_cantidad = CN_cero THEN
            LB_retorno:=FALSE;
         END IF;
     END IF;

  RETURN LB_retorno;

END AL_VALIDA_VENDEDOR_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_ARTICULO_FN(EN_Cod_Articulo     IN          al_articulos.Cod_Articulo%TYPE)
RETURN BOOLEAN
IS
/*
<Documentación TipoDoc = "Funcion">
<Elemento Nombre = "AL_VALIDA_ARTICULO_PR"
Lenguaje="PL/V_sSql" Fecha="23-10-2007"
Versión="1.0" Diseñador="****"
Programador="Luis Munoz"
 Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Valida Articulo</Descripción>
<Parámetros>
    <Entrada>
        <param nom="EN_Cod_Articulo" Tipo="NUMBER">Codigo Articulo</param>
    </Entrada>
    <Salida>
     <param nom="" Tipo="Boolean></param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

  LB_retorno BOOLEAN:=TRUE;
  LN_cantidad  NUMBER;
  CN_uno        CONSTANT NUMBER(2):=1;
  CN_cero        CONSTANT NUMBER(2):=0;

BEGIN

     BEGIN
      SELECT count(1) INTO LN_cantidad
      FROM AL_ARTICULOS a
      WHERE a.cod_articulo =  EN_Cod_Articulo
        AND a.IND_SERIADO  = CN_uno;
     EXCEPTION
        WHEN OTHERS THEN
         LB_retorno:=FALSE;
     END;

     IF LN_cantidad = CN_cero THEN
        LB_retorno:=FALSE;
     END IF;

  RETURN LB_retorno;

END AL_VALIDA_ARTICULO_FN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_USO_FN (EN_cod_uso IN al_usos.cod_uso%type)
RETURN BOOLEAN
IS
/*
<<Documentación TipoDoc = "Función>
<Elemento Nombre = "AL_VALIDA_USO_FN Lenguaje="PL/SQL" Fecha="15-08-2007" Versión="1.1.0"
  Diseñador="Luis Munoz Programador="Luis Munoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Valida Uso</Descripción>
<Parámetros>
<Entrada>
 <param nom="EN_cod_uso" Tipo="NUMBER>Uso/param>
</Entrada>
<Salida>
 <param nom="" Tipo="Boolean></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=TRUE;
  LN_cantidad  NUMBER;
  CN_cero        CONSTANT NUMBER(2):=0;
  CN_prepago    CONSTANT NUMBER(2):=3;
  CN_postpago    CONSTANT NUMBER(2):=2;

BEGIN

         BEGIN
             SELECT COUNT(1) INTO LN_cantidad
             FROM  al_usos a
             WHERE a.cod_uso = EN_cod_uso;
         EXCEPTION
            WHEN OTHERS THEN
             LB_retorno:=FALSE;
         END;

         IF LN_cantidad = CN_cero THEN
            LB_retorno:=FALSE;
         END IF;


  RETURN LB_retorno;
END AL_VALIDA_USO_FN;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION AL_VALIDA_CATEGORIA_FN (EV_cod_categoria IN ve_categorias.cod_categoria%type)
RETURN BOOLEAN
IS
/*
<<Documentación TipoDoc = "Función>
<Elemento Nombre = "AL_VALIDA_CATEGORIA_FN Lenguaje="PL/SQL" Fecha="15-08-2007" Versión="1.1.0"
  Diseñador="Luis Munoz Programador="Luis Munoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Valida Categoria</Descripción>
<Parámetros>
<Entrada>
 <param nom="EN_cod_categoria" Tipo="NUMBER>Categoria/param>
</Entrada>
<Salida>
 <param nom="" Tipo="Boolean></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=TRUE;
  LN_cantidad  NUMBER;
  CN_cero        CONSTANT NUMBER(2):=0;

BEGIN



         BEGIN
             SELECT COUNT(1) INTO LN_cantidad
             FROM  ve_categorias a
             WHERE a.cod_categoria = EV_cod_categoria;
         EXCEPTION
            WHEN OTHERS THEN
             LB_retorno:=FALSE;
         END;

         IF LN_cantidad = CN_cero THEN
            LB_retorno:=FALSE;
         END IF;


  RETURN LB_retorno;
END AL_VALIDA_CATEGORIA_FN;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION AL_VALIDA_MESES_FN (EN_num_meses IN Ga_percontrato.num_meses%type)
RETURN BOOLEAN
IS
/*
<<Documentación TipoDoc = "Función>
<Elemento Nombre = "AL_VALIDA_MESES_FN Lenguaje="PL/SQL" Fecha="15-08-2007" Versión="1.1.0"
  Diseñador="Luis Munoz Programador="Luis Munoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Valida Meses</Descripción>
<Parámetros>
<Entrada>
 <param nom="EN_num_meses" Tipo="NUMBER>Meses/param>
</Entrada>
<Salida>
 <param nom="" Tipo="Boolean></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno BOOLEAN:=TRUE;
  LN_cantidad  NUMBER;
  CN_cero        CONSTANT NUMBER(2):=0;
    CN_uno        CONSTANT NUMBER(2):=1;

BEGIN



         BEGIN
             SELECT COUNT(1) INTO LN_cantidad
             FROM  Ga_percontrato a
             WHERE a.cod_producto = CN_uno
              AND  a.num_meses = EN_num_meses;
         EXCEPTION
            WHEN OTHERS THEN
             LB_retorno:=FALSE;
         END;

         IF LN_cantidad = CN_cero THEN
            LB_retorno:=FALSE;
         END IF;


  RETURN LB_retorno;
END AL_VALIDA_MESES_FN;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_ESTADO_FN (EN_cod_estado IN al_estados.cod_estado%type)
RETURN BOOLEAN
IS
/*
<<Documentación TipoDoc = "Función>
<Elemento Nombre = "AL_VALIDA_ESTADO_FN Lenguaje="PL/SQL" Fecha="15-08-2007" Versión="1.1.0"
  Diseñador="Luis Munoz Programador="Luis Munoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Valida Estado/Descripción>
<Parámetros>
<Entrada>
 <param nom="EN_cod_estado" Tipo="NUMBER>Meses/param>
</Entrada>
<Salida>
 <param nom="" Tipo="Boolean></param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
  LB_retorno     BOOLEAN:=TRUE;
  LN_cantidad      NUMBER;
  CN_cero       CONSTANT NUMBER(2):=0;

BEGIN


         BEGIN
             SELECT COUNT(1) INTO LN_cantidad
             FROM  AL_ESTADOS a
             WHERE a.cod_estado = EN_cod_estado;
         EXCEPTION
            WHEN OTHERS THEN
             LB_retorno:=FALSE;
         END;

         IF LN_cantidad = CN_cero THEN
            LB_retorno:=FALSE;
         END IF;


  RETURN LB_retorno;
END AL_VALIDA_ESTADO_FN;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE AL_VALIDA_PRECIOS_MASIVO_PR(EN_numproc    IN AL_PRECIOS_RETAIL_TT.num_proceso%TYPE,
                                      EV_flagvalpre IN VARCHAR2
)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_VALIDA_PRECIOS_MASIVO_PR" Lenguaje="PL/SQL" Fecha="16-08-2007" Versión="1.1.0"
  Diseñador="Luis Munoz Programador="Luis Munoz" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Valida las series para el proceso masivo</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_numproc  Tipo="Number">Numero Proceso</param>
<param nom="EV_flagvalpre Tipo="Number">Numero Proceso</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

---- Precios Masivos
CURSOR LC_PRECIOS (LN_Numproc AL_PRECIOS_RETAIL_TT.num_proceso%TYPE)
IS
  SELECT  a.cod_vendedor, a.cod_articulo, a.precio_articulo, a.cod_uso, a.cod_estado,a.cod_categoria, a.num_meses, a.ind_recambio
  FROM  AL_PRECIOS_RETAIL_TT a
  WHERE a.num_proceso = LN_Numproc;


e_Next_Record EXCEPTION;
LN_cantidad                    NUMBER;
BEGIN



             FOR LR_Pre IN LC_PRECIOS(EN_numproc) LOOP

                BEGIN

                    -- Vendedor Comisionista Retail no valido
                    IF NOT AL_VALIDA_VENDEDOR_FN(LR_Pre.cod_vendedor) THEN
                       UPDATE AL_PRECIOS_RETAIL_TT SET
                           cod_error = 476
                       WHERE num_proceso= EN_numproc
                         AND cod_vendedor  = LR_Pre.cod_vendedor
                         AND cod_articulo  = LR_Pre.cod_articulo
                         AND cod_uso       = LR_Pre.cod_uso
                         AND cod_estado    = LR_Pre.cod_estado
                         AND cod_categoria = LR_Pre.cod_categoria
                         AND num_meses     = LR_Pre.num_meses
                         AND ind_recambio  = LR_Pre.ind_recambio
                         AND cod_error     = 0;
                       RAISE e_Next_Record;
                       -- Articulo no es valido
                    ELSIF NOT AL_VALIDA_ARTICULO_FN(LR_Pre.cod_articulo) THEN
                           UPDATE AL_PRECIOS_RETAIL_TT SET
                               cod_error = 770
                           WHERE num_proceso= EN_numproc
                             AND cod_vendedor  = LR_Pre.cod_vendedor
                             AND cod_articulo  = LR_Pre.cod_articulo
                             AND cod_uso       = LR_Pre.cod_uso
                             AND cod_estado    = LR_Pre.cod_estado
                             AND cod_categoria = LR_Pre.cod_categoria
                             AND num_meses     = LR_Pre.num_meses
                             AND ind_recambio  = LR_Pre.ind_recambio
                             AND cod_error     = 0;
                           RAISE e_Next_Record;
                       -- Precio no valido
                    ELSIF EV_flagvalpre = 'TRUE' AND  (LR_Pre.precio_articulo = 0 OR  LR_Pre.precio_articulo < 0) THEN
                           UPDATE AL_PRECIOS_RETAIL_TT SET
                               cod_error = 1608
                           WHERE num_proceso= EN_numproc
                             AND cod_vendedor  = LR_Pre.cod_vendedor
                             AND cod_articulo  = LR_Pre.cod_articulo
                             AND cod_uso       = LR_Pre.cod_uso
                             AND cod_estado    = LR_Pre.cod_estado
                             AND cod_categoria = LR_Pre.cod_categoria
                             AND num_meses     = LR_Pre.num_meses
                             AND ind_recambio  = LR_Pre.ind_recambio
                             AND cod_error     = 0;
                           RAISE e_Next_Record;
                       -- Precio no valido
                    ELSIF EV_flagvalpre = 'FALSE' AND  LR_Pre.precio_articulo < 0 THEN
                           UPDATE AL_PRECIOS_RETAIL_TT SET
                               cod_error = 1608
                           WHERE num_proceso= EN_numproc
                             AND cod_vendedor  = LR_Pre.cod_vendedor
                             AND cod_articulo  = LR_Pre.cod_articulo
                             AND cod_uso       = LR_Pre.cod_uso
                             AND cod_estado    = LR_Pre.cod_estado
                             AND cod_categoria = LR_Pre.cod_categoria
                             AND num_meses     = LR_Pre.num_meses
                             AND ind_recambio  = LR_Pre.ind_recambio
                             AND cod_error     = 0;
                           RAISE e_Next_Record;
                            -- Uso no valido
                       ELSIF NOT AL_VALIDA_USO_FN(LR_Pre.cod_uso) THEN
                               UPDATE AL_PRECIOS_RETAIL_TT SET
                                   cod_error = 1612
                               WHERE num_proceso= EN_numproc
                                 AND cod_vendedor  = LR_Pre.cod_vendedor
                                 AND cod_articulo  = LR_Pre.cod_articulo
                                 AND cod_uso       = LR_Pre.cod_uso
                                 AND cod_estado    = LR_Pre.cod_estado
                                 AND cod_categoria = LR_Pre.cod_categoria
                                 AND num_meses     = LR_Pre.num_meses
                                 AND ind_recambio  = LR_Pre.ind_recambio
                                 AND cod_error     = 0;
                               RAISE e_Next_Record;
                               -- Categoria no valida
                          ELSIF  NOT AL_VALIDA_CATEGORIA_FN(LR_Pre.cod_categoria) THEN
                                   UPDATE AL_PRECIOS_RETAIL_TT SET
                                       cod_error = 160
                                   WHERE num_proceso= EN_numproc
                                     AND cod_vendedor  = LR_Pre.cod_vendedor
                                     AND cod_articulo  = LR_Pre.cod_articulo
                                     AND cod_uso       = LR_Pre.cod_uso
                                     AND cod_estado    = LR_Pre.cod_estado
                                     AND cod_categoria = LR_Pre.cod_categoria
                                     AND num_meses     = LR_Pre.num_meses
                                     AND ind_recambio  = LR_Pre.ind_recambio
                                     AND cod_error     = 0;
                                        RAISE e_Next_Record;
                               -- Meses no valido
                             ELSIF NOT AL_VALIDA_MESES_FN(LR_Pre.num_meses) THEN
                                       UPDATE AL_PRECIOS_RETAIL_TT SET
                                         cod_error = 1609
                                       WHERE num_proceso= EN_numproc
                                         AND cod_vendedor  = LR_Pre.cod_vendedor
                                         AND cod_articulo  = LR_Pre.cod_articulo
                                         AND cod_uso       = LR_Pre.cod_uso
                                         AND cod_estado    = LR_Pre.cod_estado
                                         AND cod_categoria = LR_Pre.cod_categoria
                                         AND num_meses     = LR_Pre.num_meses
                                         AND ind_recambio  = LR_Pre.ind_recambio
                                         AND cod_error     = 0;
                                            RAISE e_Next_Record;
                                   -- Indicador de recambio no valido
                                ELSIF LR_Pre.ind_recambio <> 0 AND  LR_Pre.ind_recambio <> 1 THEN
                                           UPDATE AL_PRECIOS_RETAIL_TT SET
                                             cod_error = 1610
                                           WHERE num_proceso= EN_numproc
                                             AND cod_vendedor  = LR_Pre.cod_vendedor
                                             AND cod_articulo  = LR_Pre.cod_articulo
                                             AND cod_uso       = LR_Pre.cod_uso
                                             AND cod_estado    = LR_Pre.cod_estado
                                             AND cod_categoria = LR_Pre.cod_categoria
                                             AND num_meses     = LR_Pre.num_meses
                                             AND ind_recambio  = LR_Pre.ind_recambio
                                             AND cod_error     = 0;
                                                RAISE e_Next_Record;
                                         --- Estado No valido
                                    ELSIF NOT AL_VALIDA_ESTADO_FN(LR_Pre.cod_estado) THEN
                                           UPDATE AL_PRECIOS_RETAIL_TT SET
                                             cod_error = 29
                                           WHERE num_proceso= EN_numproc
                                             AND cod_vendedor  = LR_Pre.cod_vendedor
                                             AND cod_articulo  = LR_Pre.cod_articulo
                                             AND cod_uso       = LR_Pre.cod_uso
                                             AND cod_estado    = LR_Pre.cod_estado
                                             AND cod_categoria = LR_Pre.cod_categoria
                                             AND num_meses     = LR_Pre.num_meses
                                             AND ind_recambio  = LR_Pre.ind_recambio
                                             AND cod_error     = 0;
                                                RAISE e_Next_Record;
                                    END IF;



                            --- Revisamos que NO procese duplicados, lo dejamos como ERROR
                            SELECT COUNT(1) INTO LN_cantidad
                            FROM  AL_PRECIOS_RETAIL_TT a
                            WHERE num_proceso   = EN_numproc
                              AND cod_vendedor  = LR_Pre.cod_vendedor
                              AND cod_articulo  = LR_Pre.cod_articulo
                              AND cod_uso       = LR_Pre.cod_uso
                              AND cod_estado    = LR_Pre.cod_estado
                              AND cod_categoria = LR_Pre.cod_categoria
                              AND num_meses     = LR_Pre.num_meses
                              AND ind_recambio  = LR_Pre.ind_recambio;

                            IF LN_cantidad > 1 THEN
                              --- Existen registros duplicadas en archivo de carga masiva de precios
                                  UPDATE AL_PRECIOS_RETAIL_TT SET cod_error = 1611
                                WHERE num_proceso   = EN_numproc
                                  AND cod_vendedor  = LR_Pre.cod_vendedor
                                  AND cod_articulo  = LR_Pre.cod_articulo
                                  AND cod_uso       = LR_Pre.cod_uso
                                  AND cod_estado    = LR_Pre.cod_estado
                                  AND cod_categoria = LR_Pre.cod_categoria
                                  AND num_meses     = LR_Pre.num_meses
                                  AND ind_recambio  = LR_Pre.ind_recambio;
                            END IF;


                EXCEPTION
                     WHEN E_NEXT_RECORD THEN NULL; -- ACÁ LLEGA SI TENGO ERROR EN ALGUN REGISTRO.

                END;

             END LOOP;



EXCEPTION
    WHEN OTHERS THEN
           raise_application_error(-20100, 'Error: '|| SQLERRM);
END AL_VALIDA_PRECIOS_MASIVO_PR;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE AL_INSERTA_PRECMASIVO_PR (EN_numproc AL_PRECIOS_RETAIL_TT.num_proceso%TYPE)
IS
/*
<Documentación TipoDoc = "Procedimiento">
<Elemento Nombre = "AL_INSERTA_PRECMASIVO_PR Lenguaje="PL/SQL" Fecha="16-03-2006" Versión="1.1.0"
  Diseñador="Luis Munoz" Programador=""Luis Munoz Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción> Inserta Precios Retail</Descripción>
<Parámetros>
<Entrada>
<param nom="EN_numproc  Tipo="Number">Numero Proceso</param>
</Entrada>
<Salida>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
--- Temporal de Precios
--------
CURSOR LC_PRECIOS (LN_Numproc AL_PRECIOS_RETAIL_TT.num_proceso%TYPE)
IS
  SELECT a.num_proceso, a.cod_vendedor, a.cod_articulo, a.precio_articulo, a.cod_uso, a.cod_estado,a.cod_categoria, a.num_meses, a.ind_recambio
  FROM  AL_PRECIOS_RETAIL_TT a
  WHERE a.num_proceso = LN_Numproc
    AND a.cod_error = 0;


--- Matriz de Precios
--------
CURSOR LC_MATRIZ (LN_vendedor AL_PRECIOS_RETAIL_TT.cod_vendedor%TYPE, LN_articulo AL_PRECIOS_RETAIL_TT.cod_articulo%TYPE,
                  LN_uso AL_PRECIOS_RETAIL_TT.cod_uso%TYPE, LN_estado AL_PRECIOS_RETAIL_TT.cod_estado%TYPE,
                  LN_categoria AL_PRECIOS_RETAIL_TT.cod_categoria%TYPE, LN_num_meses AL_PRECIOS_RETAIL_TT.num_meses%TYPE,
                  LN_ind_recambio AL_PRECIOS_RETAIL_TT.ind_recambio%TYPE)
IS
  SELECT a.usu_creacion,a.fec_creacion,a.usu_actualiza,a.fec_actualiza,a.precio_articulo,a.fec_desde,a.fec_hasta
  FROM  AL_PRECIOS_RETAIL_TD a
  WHERE a.cod_vendedor  = LN_vendedor
    AND a.cod_articulo  = LN_articulo
    AND ((SYSDATE BETWEEN a.fec_desde  AND a.fec_hasta)  OR ( SYSDATE <= a.fec_hasta))
    AND a.cod_uso       = LN_uso
    AND a.cod_estado    = LN_estado
    AND a.cod_categoria = LN_categoria
    AND a.num_meses     = LN_num_meses
    AND a.ind_recambio  = LN_ind_recambio
   ORDER BY a.fec_desde asc;


LN_cantidad           NUMBER;
LN_leidos_mat       NUMBER;
LV_FechaHoy             DATE;
LR_precios_td_a    AL_PRECIOS_RETAIL_TD%ROWTYPE;
SN_cod_retorno       NUMBER;
SV_mens_retorno       VARCHAR2(1000);
SN_num_evento       NUMBER;
Error_Inserta_Prec EXCEPTION;
BEGIN


           LV_FechaHoy := SYSDATE;


           FOR LC_PRE IN LC_PRECIOS(EN_numproc) LOOP

                   --- Validamos si existen Precios Vigentes
                   SELECT count(0)
                   INTO LN_cantidad
                   FROM AL_PRECIOS_RETAIL_TD  a
                   WHERE a.cod_vendedor= LC_PRE.cod_vendedor
                     AND a.cod_articulo= LC_PRE.cod_articulo
                     AND ((SYSDATE BETWEEN a.fec_desde  AND a.fec_hasta)  OR ( SYSDATE <= a.fec_hasta))
                     AND a.cod_uso= LC_PRE.cod_uso
                     AND a.cod_estado= LC_PRE.cod_estado
                     AND a.cod_categoria= LC_PRE.cod_categoria
                     AND a.num_meses= LC_PRE.num_meses
                     AND a.ind_recambio= LC_PRE.ind_recambio;

                    IF LN_cantidad > 0 THEN

                             LN_leidos_mat := 0;

                             FOR LC_MAT IN LC_MATRIZ(LC_PRE.cod_vendedor, LC_PRE.cod_articulo, LC_PRE.cod_uso, LC_PRE.cod_estado,
                                  LC_PRE.cod_categoria,LC_PRE.num_meses,LC_PRE.ind_recambio)
                             LOOP

                                   LN_leidos_mat := LN_leidos_mat + 1;

                                   IF LN_leidos_mat = 1 THEN

                                        -- Dejamos CERRADO el rango mas cercano...
                                          UPDATE AL_PRECIOS_RETAIL_TD
                                             SET fec_hasta = SYSDATE - (1/(24*60*60)),
                                                 usu_actualiza = USER,
                                                 fec_actualiza = LV_FechaHoy
                                          WHERE cod_vendedor  = LC_PRE.cod_vendedor
                                            AND cod_articulo  = LC_PRE.cod_articulo
                                            AND fec_desde     = LC_MAT.fec_desde
                                            AND cod_uso       = LC_PRE.cod_uso
                                            AND cod_estado    = LC_PRE.cod_estado
                                            AND cod_categoria = LC_PRE.cod_categoria
                                            AND num_meses     = LC_PRE.num_meses
                                            AND ind_recambio  = LC_PRE.ind_recambio;


                                        -- Pasamos a Historico el rango mas cernano CERRADO
                                        LR_precios_td_a:=NULL;
                                        LR_precios_td_a.COD_VENDEDOR     :=LC_PRE.cod_vendedor;
                                        LR_precios_td_a.COD_ARTICULO     :=LC_PRE.cod_articulo;
                                         LR_precios_td_a.PRECIO_ARTICULO    :=LC_MAT.precio_articulo;
                                        LR_precios_td_a.USU_CREACION    :=LC_MAT.usu_creacion;
                                        LR_precios_td_a.FEC_CREACION    :=LC_MAT.fec_creacion;
                                        LR_precios_td_a.USU_ACTUALIZA    :=USER;
                                        LR_precios_td_a.FEC_ACTUALIZA    :=SYSDATE;
                                        LR_precios_td_a.COD_USO            :=LC_PRE.cod_uso;
                                        LR_precios_td_a.COD_ESTADO        :=LC_PRE.cod_estado;
                                        LR_precios_td_a.COD_CATEGORIA    :=LC_PRE.cod_categoria;
                                        LR_precios_td_a.NUM_MESES        :=LC_PRE.num_meses;
                                        LR_precios_td_a.IND_RECAMBIO    :=LC_PRE.ind_recambio;
                                        LR_precios_td_a.FEC_DESDE         :=LC_MAT.fec_desde;
                                        LR_precios_td_a.FEC_HASTA         :=LC_MAT.fec_hasta;

                                        al_insertar_precioretail_th_pr (LR_precios_td_a,'U',SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno <> 0 THEN
                                              RAISE Error_Inserta_Prec;
                                        END IF;

                                        --- Creamos el nuevo rango en Matriz de Precios
                                        INSERT INTO AL_PRECIOS_RETAIL_TD
                                              (COD_VENDEDOR, COD_ARTICULO, PRECIO_ARTICULO, FEC_DESDE, FEC_HASTA, USU_CREACION, FEC_CREACION,
                                               USU_ACTUALIZA, FEC_ACTUALIZA, COD_USO, COD_ESTADO, COD_CATEGORIA, NUM_MESES, IND_RECAMBIO)
                                        VALUES
                                              (LC_PRE.cod_vendedor,LC_PRE.cod_articulo,LC_PRE.precio_articulo,LV_FechaHoy,TO_DATE('30/12/3000 23:59:59','DD/MM/YYYY HH24:MI:SS'),USER,SYSDATE,
                                              null,null,LC_PRE.cod_uso,LC_PRE.cod_estado,LC_PRE.cod_categoria,LC_PRE.num_meses,LC_PRE.ind_recambio);



                                        -- Pasamos a Historico EL NUEVO rEGISTROS
                                        LR_precios_td_a:=NULL;
                                        LR_precios_td_a.COD_VENDEDOR     :=LC_PRE.cod_vendedor;
                                        LR_precios_td_a.COD_ARTICULO     :=LC_PRE.cod_articulo;
                                         LR_precios_td_a.PRECIO_ARTICULO    :=LC_PRE.precio_articulo;
                                        LR_precios_td_a.USU_CREACION    :=USER;
                                        LR_precios_td_a.FEC_CREACION    :=LV_FechaHoy;
                                        LR_precios_td_a.USU_ACTUALIZA    :=null;
                                        LR_precios_td_a.FEC_ACTUALIZA    :=null;
                                        LR_precios_td_a.COD_USO            :=LC_PRE.cod_uso;
                                        LR_precios_td_a.COD_ESTADO        :=LC_PRE.cod_estado;
                                        LR_precios_td_a.COD_CATEGORIA    :=LC_PRE.cod_categoria;
                                        LR_precios_td_a.NUM_MESES        :=LC_PRE.num_meses;
                                        LR_precios_td_a.IND_RECAMBIO    :=LC_PRE.ind_recambio;
                                        LR_precios_td_a.FEC_DESDE         :=LV_FechaHoy;
                                        LR_precios_td_a.FEC_HASTA         :=TO_DATE('30/12/3000 23:59:59','DD/MM/YYYY HH24:MI:SS');
                                        al_insertar_precioretail_th_pr (LR_precios_td_a,'I',SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno <> 0 THEN
                                              RAISE Error_Inserta_Prec;
                                        END IF;



                                   ELSE

                                       -- Borramos precios futuros...

                                        DELETE AL_PRECIOS_RETAIL_TD
                                        WHERE cod_vendedor = LC_PRE.cod_vendedor
                                           AND  cod_articulo = LC_PRE.cod_articulo
                                           AND  fec_desde    = LC_MAT.fec_desde
                                           AND  cod_uso      = LC_PRE.cod_uso
                                           AND  cod_estado   = LC_PRE.cod_estado
                                           AND  cod_categoria = LC_PRE.cod_categoria
                                           AND  num_meses     = LC_PRE.num_meses
                                           AND  ind_recambio  = LC_PRE.ind_recambio;

                                        -- Pasamos a Historico los precios futuros...
                                        LR_precios_td_a:=NULL;
                                        LR_precios_td_a.COD_VENDEDOR     :=LC_PRE.cod_vendedor;
                                        LR_precios_td_a.COD_ARTICULO     :=LC_PRE.cod_articulo;
                                         LR_precios_td_a.PRECIO_ARTICULO    :=LC_MAT.precio_articulo;
                                        LR_precios_td_a.USU_CREACION    :=LC_MAT.usu_creacion;
                                        LR_precios_td_a.FEC_CREACION    :=LC_MAT.fec_creacion;
                                        LR_precios_td_a.USU_ACTUALIZA    :=USER;
                                        LR_precios_td_a.FEC_ACTUALIZA    :=SYSDATE;
                                        LR_precios_td_a.COD_USO            :=LC_PRE.cod_uso;
                                        LR_precios_td_a.COD_ESTADO        :=LC_PRE.cod_estado;
                                        LR_precios_td_a.COD_CATEGORIA    :=LC_PRE.cod_categoria;
                                        LR_precios_td_a.NUM_MESES        :=LC_PRE.num_meses;
                                        LR_precios_td_a.IND_RECAMBIO    :=LC_PRE.ind_recambio;
                                        LR_precios_td_a.FEC_DESDE         :=LC_MAT.fec_desde;
                                        LR_precios_td_a.FEC_HASTA         :=LC_MAT.fec_hasta;
                                        al_insertar_precioretail_th_pr (LR_precios_td_a,'D',SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                                        IF SN_cod_retorno <> 0 THEN
                                              RAISE Error_Inserta_Prec;
                                        END IF;

                                   END IF;


                             END LOOP;

                    ELSE
                       --- En caso que no existan Precios en Matriz
                           LR_precios_td_a:=NULL;
                           LR_precios_td_a.COD_VENDEDOR     :=LC_PRE.cod_vendedor;
                           LR_precios_td_a.COD_ARTICULO     :=LC_PRE.cod_articulo;
                           LR_precios_td_a.PRECIO_ARTICULO    :=LC_PRE.precio_articulo;
                           LR_precios_td_a.FEC_DESDE         :=LV_FechaHoy;
                           LR_precios_td_a.FEC_HASTA         :=TO_DATE('30/12/3000 23:59:59','DD/MM/YYYY HH24:MI:SS');
                           LR_precios_td_a.USU_CREACION        :=USER;
                           LR_precios_td_a.FEC_CREACION        :=LV_FechaHoy;
                           LR_precios_td_a.COD_USO            :=LC_PRE.cod_uso;
                           LR_precios_td_a.COD_ESTADO        :=LC_PRE.cod_estado;
                           LR_precios_td_a.COD_CATEGORIA    :=LC_PRE.cod_categoria;
                           LR_precios_td_a.NUM_MESES        :=LC_PRE.num_meses;
                           LR_precios_td_a.IND_RECAMBIO        :=LC_PRE.ind_recambio;

                           al_insertar_precioretail_td_pr (LR_precios_td_a,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                           IF SN_cod_retorno <> 0 THEN
                                  RAISE Error_Inserta_Prec;
                            END IF;

                           -- Pasamos a Historico EL NUEVO rEGISTROS
                           LR_precios_td_a:=NULL;
                           LR_precios_td_a.COD_VENDEDOR     :=LC_PRE.cod_vendedor;
                           LR_precios_td_a.COD_ARTICULO     :=LC_PRE.cod_articulo;
                           LR_precios_td_a.PRECIO_ARTICULO    :=LC_PRE.precio_articulo;
                           LR_precios_td_a.USU_CREACION        :=USER;
                           LR_precios_td_a.FEC_CREACION        :=LV_FechaHoy;
                           LR_precios_td_a.USU_ACTUALIZA    :=NULL;
                           LR_precios_td_a.FEC_ACTUALIZA    :=NULL;
                           LR_precios_td_a.COD_USO            :=LC_PRE.cod_uso;
                           LR_precios_td_a.COD_ESTADO        :=LC_PRE.cod_estado;
                           LR_precios_td_a.COD_CATEGORIA    :=LC_PRE.cod_categoria;
                           LR_precios_td_a.NUM_MESES        :=LC_PRE.num_meses;
                           LR_precios_td_a.IND_RECAMBIO        :=LC_PRE.ind_recambio;
                           LR_precios_td_a.FEC_DESDE         :=LV_FechaHoy;
                           LR_precios_td_a.FEC_HASTA         :=TO_DATE('30/12/3000 23:59:59','DD/MM/YYYY HH24:MI:SS');
                           al_insertar_precioretail_th_pr (LR_precios_td_a,'I',SN_cod_retorno,SV_mens_retorno,SN_num_evento);
                           IF SN_cod_retorno <> 0 THEN
                              RAISE Error_Inserta_Prec;
                           END IF;

                    END IF;
            END LOOP;



EXCEPTION
 WHEN Error_Inserta_Prec THEN
       raise_application_error(-20116, sqlerrm);
 WHEN OTHERS THEN
      raise_application_error(-20116, sqlerrm);
END AL_INSERTA_PRECMASIVO_PR;

END Np_Gestor_Mayoristas_Pg;
/
SHOW ERRORS
