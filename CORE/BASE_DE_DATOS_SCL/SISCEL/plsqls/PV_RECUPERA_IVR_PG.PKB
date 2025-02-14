CREATE OR REPLACE PACKAGE BODY          "PV_RECUPERA_IVR_PG"    
IS
--
   PROCEDURE pv_rec_val_abonado_pr (
      EN_celular    IN       GA_ABOCEL.num_celular%TYPE,
      EN_norden     IN       SP_ORDENES_REPARACION.num_orden%TYPE,
      SV_respuesta  OUT      NOCOPY VARCHAR2,
      SN_codresul   OUT      NOCOPY NUMBER
   )
   IS

/*
<Documentacisn TipoDoc = "Procedimiento">
<Elemento Nombre = "pv_rec_val_abonado_pr" Lenguaje="PL/SQL" Fecha="24-01-2005" Versisn"1.0.0" Diseqador"Christian Estay" Programador="Claudio Machuca/Orlando Cabezas" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripcisn>"Procedimiento Padre encargado de gatillar una serie de otros procedimientos y su funcionalidad es rescatar en un solo string caracteristicas generales como minutos consumidos,minutos totales, minutos pendientes ,saldo , fecha de vencimiento o estado de la Orden de Reparacisn" </Descripcisn>
<Parametros>
<Entrada>
<param nom="EN_celular" Tipo="GA_ABOCEL.num_celular%TYPE">"Corresponde al numero celular del abonado"</param>
<param nom="EN_norden " Tipo="SP_ORDENES_REPARACION.num_orden%TYPE">"Corresponde al numero de orden de reparacisn"</param>
</Entrada>
<Salida>
<param nom="SV_respuesta" Tipo="VARCHAR2">"Cadena de string que entrega informacisn como minutos consumidos , min. pendiente min. total , saldo ,fech. venc. o estado de la orden de reparacisn"</param>
<param nom="SN_codresul " Tipo="NUMBER">"Entrega el resultado de la Transacisn"</param>
</Salida>
</Parametros>
</Elemento>
</Documentacisn>
*/

-- Datos que recupera el package
      TN_abonado      GA_ABOCEL.num_abonado%TYPE;
      TN_cliente      GA_ABOCEL.cod_cliente%TYPE;
      TN_ind_disp     GA_ABOCEL.ind_disp%TYPE;
      TV_situacion    GA_ABOCEL.cod_situacion%TYPE;

-- Variables de Paso
      TV_modcli       VARCHAR2 (1)                   := ' ';
      TN_minpen       NUMBER                         := 0;
      TN_minconsu     NUMBER                         := 0;
      TN_salfactu     NUMBER                         := 0;
      TV_estorden     VARCHAR2 (30)                   := ' ';
      TV_prepago      VARCHAR2 (1)                   := ' ';
      TN_valcon       TOL_ACUMBOLSA_GRAL.val_consumido%TYPE:=0;
      TN_valtot       TOL_ACUMBOLSA_GRAL.val_inicial%TYPE:=0;
      TN_valpen       TOL_ACUMBOLSA_GRAL.val_disponible%TYPE:=0;
      TV_fechacie     VARCHAR2(8):=' ';
      TV_fechafac     VARCHAR2(8):=' ';
      TV_sqlcode      GA_ERRORES.cod_sqlcode%TYPE:=' ';
      TV_sqlerrm      GA_ERRORES.cod_sqlerrm%TYPE:=' ';

--  Manejo de Error
      error_proceso   EXCEPTION;
   BEGIN
      SV_respuesta:=' ';
      SN_codresul :=0;
      GV_rutina   := 'PV_RECUPERA_IVR_PG.PV_REC_VAL_ABONADO_PR';
      GV_formato  := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL6');  -- se va a utilizar formato DDMMAAAA

-- Se valida que entregue celular o numero de orden
      IF EN_celular IS NULL AND EN_norden IS NULL
      THEN
         TV_sqlcode := CV_20102;
         TV_sqlerrm := 'Debe indicar celular y/o orden de reparacion :';
         GV_nomtabla := 'S/Tabla';
         RAISE error_proceso;
      END IF;

      IF EN_celular = CN_0 AND EN_norden = CN_0
      THEN
         TV_sqlcode := CV_20102;
         TV_sqlerrm := 'Debe indicar celular y/o orden de reparacion :';
         GV_nomtabla := 'S/Tabla';
         RAISE error_proceso;
      END IF;

      IF (EN_celular > CN_0 AND EN_norden > CN_0)
      THEN
         TV_sqlcode := CV_20103;
         TV_sqlerrm := 'Debe indicar celular u orden, no ambas';
         GV_nomtabla := 'S/Tabla';
         RAISE error_proceso;
      END IF;

      TV_sqlcode := ' '; -- limpio variables de retorno error
      TV_sqlerrm := ' ';

      IF EN_celular > 0
      THEN
-- ********************************************************************
-- RECUPERAR DATOS DEL ABONADO
-- ********************************************************************
         BEGIN
            SELECT NVL (ind_disp, 1)
                , num_abonado
                , cod_cliente
                , cod_situacion
              INTO TN_ind_disp
                 , TN_abonado
                 , TN_cliente
                 , TV_situacion
              FROM GA_ABOCEL
             WHERE num_celular   = EN_celular
             AND   cod_situacion = CV_activo;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               TV_sqlcode := CV_20104;
               TV_sqlerrm := 'Celular No PostPago o Celular no Activo';
               GV_nomtabla := 'GA_ABOCEL';
               RAISE error_proceso;
            WHEN OTHERS
            THEN
               TV_sqlcode := CV_20105;
               TV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
               GV_nomtabla := 'GA_ABOCEL';
               RAISE error_proceso;
         END;
-- ********************************************************************
-- VERIFICAR QUE ABONADO NO SEA PREPAGO
-- ********************************************************************
         TV_prepago:='N';
         BEGIN
            SELECT 'S'
              INTO TV_prepago
              FROM GA_ABOAMIST
             WHERE num_abonado = TN_abonado;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               TV_prepago:='N';
            WHEN OTHERS
            THEN
               TV_sqlcode := CV_20106;
               TV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
               GV_nomtabla := 'GA_ABOAMIST';
               RAISE error_proceso;
         END;
         IF TV_prepago = 'S'
         THEN
             TV_sqlcode := CV_20107;
             TV_sqlerrm := 'Cliente es Prepago';
             GV_nomtabla := 'GA_ABOAMIST';
             RAISE error_proceso;
         END IF;
         -- solicita total consumido
         pv_obt_minutos_abonado_pr (TN_abonado,
                                       TN_cliente,
                                       TN_valtot,
                                       TN_valcon,
                                       TN_valpen,
                                       TV_fechacie,
                                       TV_sqlcode,
                                       TV_sqlerrm
                                      );

         IF TV_sqlerrm != CV_espacio
         THEN
            RAISE error_proceso;
         END IF;
         -- solicita saldo de factura
         pv_obt_saldo_factura_pr (TN_abonado,
                                  TN_cliente,
                                  TN_salfactu,
                                  TV_fechafac,
                                  TV_sqlcode,
                                  TV_sqlerrm
                                 );
         IF TV_sqlerrm != CV_espacio
         THEN
            RAISE error_proceso;
         END IF;
      ELSE -- solicita estado de Orden
         pv_obt_estado_orden_pr (EN_norden,
                                 TV_estorden,
                                 TV_sqlcode,
                                 TV_sqlerrm
                                );

         IF TV_sqlerrm != CV_espacio
         THEN
            RAISE error_proceso;
         END IF;
      END IF;
---   se ejecutaron los procedimientos, ahora debo armar el string de salida
      IF EN_celular > 0
      THEN
         SV_respuesta:='Min PLAN= '||LPAD(TO_CHAR(TN_valtot),6,0);
         SV_respuesta:=SV_respuesta||'   Min  Cons= '||LPAD(TO_CHAR(TN_valcon),6,0);
         SV_respuesta:=SV_respuesta||'   Min Exc= '||LPAD(TO_CHAR(TN_valpen),6,0);
         SV_respuesta:=SV_respuesta||'   Prox Fact= '||TV_fechacie;
         SV_respuesta:=SV_respuesta||'   Ult. Factura=  '||LPAD(TO_CHAR(TN_salfactu),12,0);
         SV_respuesta:=SV_respuesta||'   Fecha Venc.= '||TV_fechafac;
      ELSE
         SV_respuesta:='Est Orden= '||TV_estorden;
      END IF;
   EXCEPTION
      WHEN error_proceso
      THEN
         SV_respuesta:=TV_sqlerrm;
         INSERT INTO GA_ERRORES
                     (cod_producto
                    , cod_actabo
                    , codigo
                    , fec_error
                    , nom_proc
                    , nom_tabla
                    , cod_act
                    , cod_sqlcode
                    , cod_sqlerrm
                     )
              VALUES (CN_1
                    , CV_modulo
                    , CN_0
                    , SYSDATE
                    , GV_rutina
                    , GV_nomtabla
                    , CV_act
                    , TV_sqlcode
                    , TV_sqlerrm
                     );

         COMMIT;
/*    Detalle conversion de codigos a un valor unico para IVR
Valor                   Significado                     Codigos Error Programa
------------------------------------------------------------------------------
0                       Exito
1                       Error en Parametros             20101, 20102, 20103
2                       Error en Situacion Abonado      20104, 20105, 20106, 20107
3                       Error en Minutos Consumidos     20108, 20109, 20110, 20111, 20112, 20113, 20114 ,20115, 20116 ,20117 ,20118, 20119
4                       Error en Saldo Factura          20120, 20121
5                       Error en Estado Orden           20122, 20123
*/
         IF TV_sqlcode = CV_20101 OR
            TV_sqlcode = CV_20102 OR
            TV_sqlcode = CV_20103
         THEN
            SN_codresul:=1;
         ELSIF TV_sqlcode = CV_20104 OR
               TV_sqlcode = CV_20105 OR
               TV_sqlcode = CV_20106 OR
               TV_sqlcode = CV_20107
         THEN
            SN_codresul:=2;
         ELSIF TV_sqlcode = CV_20108 OR
               TV_sqlcode = CV_20109 OR
               TV_sqlcode = CV_20110 OR
               TV_sqlcode = CV_20111 OR
               TV_sqlcode = CV_20112 OR
               TV_sqlcode = CV_20113 OR
               TV_sqlcode = CV_20114 OR
               TV_sqlcode = CV_20115 OR
               TV_sqlcode = CV_20116 OR
               TV_sqlcode = CV_20117 OR
               TV_sqlcode = CV_20118 OR
               TV_sqlcode = CV_20119
         THEN
            SN_codresul:=3;
         ELSIF TV_sqlcode = CV_20120 OR
               TV_sqlcode = CV_20121
         THEN
            SN_codresul:=4;
         ELSE
            SN_codresul:=5;
         END IF;
   END pv_rec_val_abonado_pr;

--
   PROCEDURE pv_obt_minutos_abonado_pr (
      EN_abonado    IN       GA_ABOCEL.num_abonado%TYPE,
      EN_cliente    IN       GA_ABOCEL.cod_cliente%TYPE,
      SN_valtot     OUT      NOCOPY TOL_ACUMBOLSA_GRAL.val_inicial%TYPE,
      SN_valcon     OUT      NOCOPY TOL_ACUMBOLSA_GRAL.val_consumido%TYPE,
      SN_valpen     OUT      NOCOPY TOL_ACUMBOLSA_GRAL.val_disponible%TYPE,
      SV_fechacie   OUT      NOCOPY VARCHAR2,
      SV_sqlcode    OUT      NOCOPY GA_ERRORES.cod_sqlcode%TYPE,
      SV_sqlerrm    OUT      NOCOPY GA_ERRORES.cod_sqlerrm%TYPE
   )
   IS

/*
<Documentacisn TipoDoc = "Procedimiento">
<Elemento Nombre = "pv_obt_minutos_abonado_pr  " Lenguaje="PL/SQL" Fecha="24-01-2005" Versisn"1.0.0" Diseqador"Christian Estay" Programador="Claudio Machuca/Orlando Cabezas" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripcisn>"Procedimiento Hijo que rescata caracteristicas generales como minutos consumidos,minutos totales, minutos pendientes ,fecha de vencimiento " </Descripcisn>
<Parametros>
<Entrada>
<param nom="EN_abonado " Tipo="GA_ABOCEL.num_abonado%TYPE">"Corresponde al numero del abonado"</param>
<param nom="EN_cliente" Tipo="GA_ABOCEL.cod_cliente%TYPE">"Corresponde al numero del cliente"</param>
</Entrada>
<Salida>
<param nom="SN_valtot" Tipo="TOL_ACUMBOLSA_GRAL.val_inicial%TYPE">"Corresponde a min. total del abonado"</param>
<param nom="SN_valcon" Tipo="TOL_ACUMBOLSA_GRAL.val_consumido%TYPE">"Corresponde a min. consumidos del abonado"</param>
<param nom="SN_valpen" Tipo="TOL_ACUMBOLSA_GRAL.val_disponible%TYPE">"Corresponde a min. pendientes del abonado"</param>
<param nom="SV_fechacie" Tipo="VARCHAR2">"Corresponde a Fecha de Cierre del abonado"</param>
<param nom="SV_sqlcode" Tipo="GA_ERRORES.cod_sqlcode%TYPE">"Corresponde al codigo ORACLE de la Transaccion"</param>
<param nom="SV_sqlerrm" Tipo="GA_ERRORES.cod_sqlerrm%TYPE">"Corresponde a la glosa errror de ORACLE de la Transaccion"</param>
</Salida>
</Parametros>
</Elemento>
</Documentacisn>
*/

-- Datos que recupera el package
      TN_ciclo   FA_CICLOCLI.cod_ciclo%TYPE;

-- OCB-INI PAN_04002_R06
      TN_bolsa   TOL_CLIENTE.cod_bolsa%TYPE;
      TN_unidad  TOL_BOLSA_TD.ind_unidad%TYPE;
      TN_TASA    TOL_CRONOGRAMA.fec_tasa%TYPE;
-- OCB-FIN PAN_04002_R06

   BEGIN
      SN_valcon := 0;
      SN_valtot := 0;
      SV_fechacie := ' ';
      GV_rutina := 'PV_RECUPERA_IVR_PG.pv_obt_minutos_abonado_pr';
      SV_sqlcode := ' '; -- limpio variables de retorno error
      SV_sqlerrm := ' ';

-- OCB-INI PAN_04002_R06 / COMENTAR OBTENCISN DEL CICLO DEL CLIENTE
-- Rescato ciclo del cliente
--      BEGIN
--         SELECT cod_ciclo
--           INTO TN_ciclo
--           FROM FA_CICLOCLI
--          WHERE cod_cliente = EN_cliente
--            AND num_abonado = EN_abonado
--            AND cod_producto = CN_1;
-- OCB-FIN PAN_04002_R06 / COMENTAR OBTENCISN DEL CICLO DEL CLIENTE


-- OCB-INI PAN_04002_R06
      BEGIN
         SELECT cod_ciclo
               ,cod_bolsa
            INTO TN_ciclo
                ,TN_bolsa
           FROM TOL_CLIENTE
         WHERE cod_cliente =  EN_cliente
         AND   cod_abonado =  EN_abonado
         AND   SYSDATE    >=  fec_ini_vig
         AND   SYSDATE    <=  NVL(fec_ter_vig,SYSDATE);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SV_sqlcode := '-20108';
            SV_sqlerrm := 'No existe ciclo asociado al cliente';
            GV_nomtabla := 'TOL_CLIENTE';
            RETURN;
         WHEN OTHERS
         THEN
            SV_sqlcode := '-20109';
            SV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
            GV_nomtabla := 'TOL_CLIENTE';
            RETURN;
      END;

      BEGIN
         SELECT ind_unidad
            INTO TN_unidad
           FROM TOL_BOLSA_TD
           WHERE cod_bolsa = TN_bolsa;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SV_sqlcode := '-20110';
            SV_sqlerrm := 'No existe unidad de medidad';
            GV_nomtabla := 'TOL_BOLSA_TD';
            RETURN;
         WHEN OTHERS
         THEN
            SV_sqlcode := '-20111';
            SV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
            GV_nomtabla := 'TOL_BOLSA_TD';
            RETURN;
      END;

      IF  trim(TN_unidad) !='M' THEN
          SV_sqlcode := '-20112';
          SV_sqlerrm := 'No existe unidad de medidad de minutos';
          GV_nomtabla := 'TOL_BOLSA_TD';
          RETURN;
      END IF;

      BEGIN
         SELECT FEC_TASA
            INTO TN_TASA
           FROM TOL_CRONOGRAMA
           WHERE cod_ciclo = TN_ciclo
             AND SYSDATE  >= fec_inic
             AND SYSDATE  <= NVL(fec_term,SYSDATE);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SV_sqlcode := '-20113';
            SV_sqlerrm := 'No existe periodo vigente';
            GV_nomtabla := 'TOL_CRONOGRAMA';
            RETURN;
         WHEN OTHERS
         THEN
            SV_sqlcode := '-20114';
            SV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
            GV_nomtabla := 'TOL_CRONOGRAMA';
            RETURN;
      END;


-- OCB-FIN PAN_04002_R06

-- Rescato fecha cierre ciclo
      BEGIN
         SELECT TO_CHAR (fec_hastallam, GV_formato)
           INTO SV_fechacie
           FROM FA_CICLFACT
          WHERE cod_ciclo = TN_ciclo
          AND SYSDATE  >= fec_desdellam
          AND SYSDATE  <= fec_hastallam;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SV_sqlcode := '-20115';
            SV_sqlerrm := 'No existe fecha cierre ciclo ';
            GV_nomtabla := 'FA_CICLFACT';
            RETURN;
         WHEN TOO_MANY_ROWS
         THEN
            SV_sqlcode := '-20116';
            SV_sqlerrm := 'Ciclo tiene mas de 1 fila ';
            GV_nomtabla := 'FA_CICLFACT';
            RETURN;
         WHEN OTHERS
         THEN
            SV_sqlcode := '-20117';
            SV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
            GV_nomtabla := 'FA_CICLFACT';
            RETURN;
      END;

      BEGIN
         SELECT val_inicial
              , val_consumido,
                val_disponible
           INTO SN_valtot
              , SN_valcon
              , SN_valpen
           FROM TOL_ACUMBOLSA_GRAL
          WHERE cod_abonado = EN_abonado
          AND   cod_cliente = EN_cliente
          AND   cod_ciclo   = TN_ciclo
-- OCB-INI PAN_04002_R06
          AND   cod_bolsa   = TN_bolsa
          AND   fec_tasa    = TN_TASA;
-- OCB-FIN PAN_04002_R06
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SV_sqlcode := '-20118';
            SV_sqlerrm :=
                   'Cliente sin trafico '
                || TO_CHAR (EN_abonado)
                || '-'
                || TO_CHAR (EN_cliente)
                || '-'
                || TO_CHAR(TN_ciclo);
            GV_nomtabla := 'TOL_ACUMBOLSA_GRAL';
            RETURN;
         WHEN OTHERS
         THEN
            SV_sqlcode := '-20119';
            SV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
            GV_nomtabla := 'TOL_ACUMBOLSA_GRAL';
            RETURN;
      END;
   END pv_obt_minutos_abonado_pr;

--

   PROCEDURE pv_obt_saldo_factura_pr (
      EN_abonado    IN       GA_ABOCEL.num_abonado%TYPE,
      EN_cliente    IN       GA_ABOCEL.cod_cliente%TYPE,
      SN_salfactu   OUT      NOCOPY fa_histdocu.tot_pagar%TYPE,
      SV_fecven     OUT      NOCOPY VARCHAR2,
      SV_sqlcode    OUT      NOCOPY GA_ERRORES.cod_sqlcode%TYPE,
      SV_sqlerrm    OUT      NOCOPY GA_ERRORES.cod_sqlerrm%TYPE
   )
   IS

/*
<Documentacisn TipoDoc = "Procedimiento">
<Elemento Nombre = "pv_obt_saldo_factura_pr " Lenguaje="PL/SQL" Fecha="24-01-2005" Versisn"1.0.0" Diseqador"Christian Estay" Programador="Claudio Machuca/Orlando Cabezas" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripcisn>"Procedimiento Hijo que rescata caracteristicas como saldo y fecha de vencimiento " </Descripcisn>
<Parametros>
<Entrada>
<param nom="EN_abonado " Tipo="GA_ABOCEL.num_abonado%TYPE">"Corresponde al numero del abonado"</param>
<param nom="EN_cliente" Tipo="GA_ABOCEL.cod_cliente%TYPE">"Corresponde al numero del cliente"</param>
</Entrada>
<Salida>
<param nom="SN_salfactu" Tipo="fa_histdocu.tot_pagar%TYPE">"Corresponde al Saldo "</param>
<param nom="SV_fecven" Tipo="VARCHAR2">"Corresponde a Fecha de Emision"</param>
<param nom="SV_sqlcode" Tipo="GA_ERRORES.cod_sqlcode%TYPE">"Corresponde al codigo ORACLE de la Transaccion"</param>
<param nom="SV_sqlerrm" Tipo="GA_ERRORES.cod_sqlerrm%TYPE">"Corresponde a la glosa errror de ORACLE de la Transaccion"</param>
</Salida>
</Parametros>
</Elemento>
</Documentacisn>
*/

-- Variables del proceso

-- Constantes del Proceso

   BEGIN
      SN_salfactu := 0;
      SV_fecven := ' ';
      GV_rutina := 'PV_RECUPERA_IVR_PG.PV_OBT_SALDO_FACT_PR';
      SV_sqlcode := CV_espacio;
      SV_sqlerrm := CV_espacio;

-- Rescato estado ultima factura
      BEGIN
         SELECT tot_pagar
              , TO_CHAR (fec_emision, GV_formato)
           INTO SN_salfactu
              , SV_fecven
           FROM fa_histdocu a
          WHERE a.cod_cliente = EN_cliente
          AND   a.cod_tipdocum <> CN_25
          AND   a.fec_emision IN (SELECT MAX (b.fec_emision)
                                     FROM fa_histdocu b
                                    WHERE b.cod_cliente = a.cod_cliente);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SV_sqlcode := '-20120';
            SV_sqlerrm := 'No existe factura asociada al numero de celular';
            GV_nomtabla := 'FA_HISTDOCU';
            RETURN;
         WHEN OTHERS
         THEN
            SV_sqlcode := '-20121';
            SV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
            GV_nomtabla := 'FA_HISTDOCU';
            RETURN;
      END;
   END pv_obt_saldo_factura_pr;

--

   PROCEDURE pv_obt_estado_orden_pr (
      EN_norden     IN       SP_ORDENES_REPARACION.num_orden%TYPE,
      SV_estorden   OUT      NOCOPY SP_ESTADOS_ORDEN.des_estado_orden%TYPE,
      SV_sqlcode    OUT      NOCOPY GA_ERRORES.cod_sqlcode%TYPE,
      SV_sqlerrm    OUT      NOCOPY GA_ERRORES.cod_sqlerrm%TYPE
   )
   IS


/*
<Documentacisn TipoDoc = "Procedimiento">
<Elemento Nombre = "pv_obt_estado_orden_pr" Lenguaje="PL/SQL" Fecha="24-01-2005" Versisn"1.0.0" Diseqador"Christian Estay" Programador="Claudio Machuca/Orlando Cabezas" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripcisn>"Procedimiento Hijo que rescata caracteristicas como saldo y fecha de vencimiento " </Descripcisn>
<Parametros>
<Entrada>
<param nom="EN_norden" Tipo="SP_ORDENES_REPARACION.num_orden%TYPE">"Corresponde al numero de Orden de Reparacion"</param>
</Entrada>
<Salida>
<param nom="SV_estorden" Tipo="SP_ESTADOS_ORDEN.des_estado_orden">"Corresponde a la Glosa de estado de Reparacisn"</param>
<param nom="SV_sqlcode" Tipo="GA_ERRORES.cod_sqlcode%TYPE">"Corresponde al codigo ORACLE de la Transaccion"</param>
<param nom="SV_sqlerrm" Tipo="GA_ERRORES.cod_sqlerrm%TYPE">"Corresponde a la glosa errror de ORACLE de la Transaccion"</param>
</Salida>
</Parametros>
</Elemento>
</Documentacisn>
*/


-- Variables del Proceso
      TN_num_orden   SP_ORDENES_REPARACION.num_orden%TYPE;
   BEGIN
      SV_estorden := ' ';
      GV_rutina := 'PV_RECUPERA_IVR_PG.PV_ESTADO_ORDEN_PR';
      SV_sqlcode := CV_espacio;
      SV_sqlerrm := CV_espacio;

-- Rescato estado de la orden de reparacion
      BEGIN
         SELECT b.des_estado_orden
           INTO SV_estorden
           FROM SP_ORDENES_REPARACION a, SP_ESTADOS_ORDEN b
          WHERE a.num_orden        = EN_norden
          AND   a.cod_estado_orden = b.cod_estado_orden;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SV_sqlcode := '-20122';
            SV_sqlerrm :=
               'No existe estado de servicio solicitado al numero de orden';
            GV_nomtabla := 'SP_ORDENES_REPARACION';
            RETURN;
         WHEN OTHERS
         THEN
            SV_sqlcode := '-20123';
            SV_sqlerrm := 'Error Oracle '||SUBSTR(SQLERRM,1,40);
            GV_nomtabla := 'SP_ORDENES_REPARACION';
            RETURN;
      END;
   END pv_obt_estado_orden_pr;
--
END PV_RECUPERA_IVR_PG;
/
SHOW ERRORS
