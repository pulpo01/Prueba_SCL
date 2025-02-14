CREATE OR REPLACE PACKAGE BODY Pv_Consultas_Portal_Pg
AS

------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_OOSS_X_USUARIO_PR(
    EV_NOM_USUARIO                IN  GA_USUARIOS.NOM_USUARIO%TYPE,
    SC_BLOQ_OOSS                 OUT NOCOPY REFCURSOR,
    SV_NOM_OPERADOR                 OUT NOCOPY GE_SEG_USUARIO.NOM_OPERADOR%TYPE,
    SV_DES_OFICINA                 OUT NOCOPY GE_OFICINAS.DES_OFICINA%TYPE,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )

 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_OOS_X_USUARIO_PR"
      Lenguaje="PL/SQL"
      Fecha="26-11-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar las ordenes de servicio asociadas a un usuario</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA_DEST" Tipo="Number">Codigo de la cuenta destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_SUBCUENTAS   Tipo="Cursor>ursor con DAtos de la subcuentas</param>
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

    LN_CANTIDAD           NUMBER(5):=0;
    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    SN_cod_retorno  := 0;
    SV_mens_retorno := '';
    SN_num_evento     := 0;



       -- LV_sSql:= ' SELECT a.COD_SUBCUENTA, a.DES_SUBCUENTA'||
       --           ' FROM GA_SUBCUENTAS a'||
       --           ' WHERE a.COD_CUENTA ='||EN_COD_CUENTA_DEST;


        SELECT  NVL(COUNT(1), 0)
           INTO LN_CANTIDAD
           FROM    GE_SEG_USUARIO a
           WHERE   a.NOM_USUARIO = EV_NOM_USUARIO;

        IF LN_CANTIDAD > 0 THEN

            -- Recupera datos del usuario en SCL
            SELECT A.NOM_OPERADOR   , B.DES_OFICINA
              INTO SV_NOM_OPERADOR    , SV_DES_OFICINA
              FROM GE_SEG_USUARIO  A, GE_OFICINAS B
              WHERE A.NOM_USUARIO = EV_NOM_USUARIO
                AND A.COD_OFICINA = B.COD_OFICINA;

            OPEN SC_BLOQ_OOSS FOR
                SELECT B.COD_OS, DES_VALOR, B.DESCRIPCION
                FROM CI_USRORSERV a, CI_TIPORSERV b, GED_CODIGOS c
                WHERE a.COD_OS      =  b.COD_OS
                  AND A.USUARIO     = EV_NOM_USUARIO
                  AND B.COD_OS      = c.COD_VALOR
                  AND COD_MODULO    = 'GA'
                  AND NOM_TABLA     = 'CI_TIPORSERV'
                  AND NOM_COLUMNA   = 'IND_PORTAL'
                ORDER BY B.DESCRIPCION;

        ELSE

            SN_cod_retorno  := 1;
            RAISE ERROR_CONTROLADO;

        END IF;

        SN_cod_retorno := 0;
        SV_mens_retorno := 'OK';
        SN_num_evento := 0;

EXCEPTION

        WHEN ERROR_CONTROLADO THEN

            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
               SV_mens_retorno := gv_error_no_clasif;
            END IF;
            LV_des_error := 'PV_CONSULTAS_ADICIONALES_PG.PV_CONS_OOS_X_USUARIO_PR; - ' || SQLERRM;
            SN_num_evento     := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_CONSULTAS_ADICIONALES_PG.PV_CONS_OOS_X_USUARIO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

        WHEN OTHERS THEN
                     SN_cod_retorno := GV_error_others;
                     IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                        SV_mens_retorno := gv_error_no_clasif;
                     END IF;
                     LV_des_error := SUBSTR('PV_CONS_OOS_X_USUARIO_PR(''); - ' || SQLERRM,1,GN_largoerrtec);
                     SV_mens_retorno:=SUBSTR(SV_mens_retorno,1,gn_largodesc);
                     SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, GV_cod_modulo,SV_mens_retorno, '1.0', USER, 'PV_CONSULTAS_ADICIONALES_PG.PV_CONS_OOS_X_USUARIO_PR', LV_sSql, SN_cod_retorno, LV_des_error );

END  PV_CONS_OOSS_X_USUARIO_PR;
-----------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_TOT_CLIE_X_CUENTA_PR(
    EN_COD_CUENTA                   IN  GA_CUENTAS.COD_CUENTA%TYPE,
    SN_TOTAL_CLIENTES            OUT NOCOPY NUMBER
  )

 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_CUENTA_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una cuenta en SCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo de la cuenta destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos de la cuenta /param>
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
-- El control de la existencia se realiza en el Web-Service

      SELECT COUNT(1) INTO SN_TOTAL_CLIENTES
      FROM GE_CLIENTES C
      WHERE C.COD_CUENTA = EN_COD_CUENTA;


END PV_CONS_TOT_CLIE_X_CUENTA_PR;
------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_CUENTA_DETALLE_PR(
    EN_COD_CUENTA                   IN  GA_CUENTAS.COD_CUENTA%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )

 /*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_CUENTA_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una cuenta en SCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo de la cuenta destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos de la cuenta /param>
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
    LN_TOTAL_CLIENTES     NUMBER;
    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
       SN_cod_retorno  := 0;

       BEGIN

          PV_CONS_TOT_CLIE_X_CUENTA_PR(EN_COD_CUENTA, LN_TOTAL_CLIENTES);

           OPEN SC_BLOQ_CUENTA  FOR
              SELECT a.COD_CUENTA, a.DES_CUENTA, a.NOM_RESPONSABLE, c.DES_TIPIDENT, a.NUM_IDENT,
                   TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ), DECODE(TIP_CUENTA, 'P', 'PERSONA', 'E', 'EMPRESA',  'R', 'RECIDENCIAL'),
                   b.DES_CATEGORIA, TEL_CONTACTO, LN_TOTAL_CLIENTES TOT_CLIENTES
              FROM GA_CUENTAS a, GE_CATEGORIAS b, GE_TIPIDENT c
              WHERE A.COD_CUENTA = EN_COD_CUENTA
                AND A.COD_CATEGORIA = B.COD_CATEGORIA
                AND A.COD_TIPIDENT  = C.COD_TIPIDENT;
       END;


END PV_CONS_CUENTA_DETALLE_PR;
------------------------------------------------------------------------------------------------------------
PROCEDURE PV_ES_CLIENTE_DEALER_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SN_dealer                    OUT NOCOPY NUMBER,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_CANT_ABON_CLIENTE_PR
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una cuenta en SCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del cliente destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS


BEGIN
    -- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    SELECT COUNT(1)
    INTO SN_dealer
    FROM GA_ABOAMIST A
    WHERE A.COD_CLIENTE = EN_COD_CLIENTE
    AND A.COD_SITUACION != 'BAA'
    AND A.COD_CLIENTE = A.COD_CLIENTE_DIST
    AND ROWNUM < 2;


END PV_ES_CLIENTE_DEALER_PR;
------------------------------------------------------------------------------------------------------------
PROCEDURE PV_REC_INGRESO_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SN_monto_ingreso             OUT NOCOPY NUMBER,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_CANT_ABON_CLIENTE_PR
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una cuenta en SCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del cliente destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS


BEGIN
    -- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    SELECT b.mto_renta
    INTO SN_monto_ingreso
    FROM ert_solicitud b
    WHERE b.num_solicitud = (SELECT MAX(s.NUM_SOLICITUD)
                             FROM ert_solicitud s, ge_clientes c
                             WHERE s.num_ident_cliente = c.num_ident
                             AND s.cod_tipident = c.cod_tipident
                             AND c.cod_cliente =  1
                             AND s.mto_renta>0
                            );
EXCEPTION
  WHEN NO_DATA_FOUND THEN
     SN_monto_ingreso := 0;

END PV_REC_INGRESO_CLIENTE_PR;

PROCEDURE PV_CONS_CLIENTE_DETALLE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_CLIENTE_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una cuenta en SCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del cliente destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
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
    LN_cod_catimpos       NUMBER;
    LV_des_catimpos       VARCHAR2(1000);
    LN_es_dealer NUMBER;
    ln_monto_ingreso NUMBER;
    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    -- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;
    BEGIN
          SELECT B.COD_CATIMPOS, B.DES_CATIMPOS
          INTO LN_cod_catimpos, LV_des_catimpos
          FROM GE_CATIMPCLIENTES A, GE_CATIMPOSITIVA B
          WHERE COD_CLIENTE = EN_COD_CLIENTE
          AND A.COD_CATIMPOS = B.COD_CATIMPOS
          AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;
    EXCEPTION
         WHEN NO_DATA_FOUND THEN
                 LN_cod_catimpos :=0;
                LV_des_catimpos := ' ';
    END;


    PV_REC_INGRESO_CLIENTE_PR(EN_COD_CLIENTE,LN_monto_ingreso, SN_COD_RETORNO , SV_MENS_RETORNO,  SN_NUM_EVENTO );


    PV_ES_CLIENTE_DEALER_PR(EN_COD_CLIENTE,LN_es_dealer,
                           SN_COD_RETORNO,
                           SV_MENS_RETORNO,
                           SN_NUM_EVENTO);

       OPEN SC_BLOQ_CLIENTE  FOR
           SELECT a.COD_CLIENTE, NOM_CLIENTE||' '||NOM_APECLIEN1||' '||NOM_APECLIEN2,
                        B.DES_TIPIDENT, a.NUM_IDENT,
                  DECODE(IND_TIPPERSONA, 'F', 'PERSONA FISICA', 'J', 'EMPRESA',  'SIN ASIGNACION') IND_TIPPERSONA,
                  C.DES_CATEGORIA, A.COD_CICLO, DECODE(COD_CATRIBUT, 'F', 'FACTURA', 'B', 'BOLETA') COD_CATRIBUT,
                  TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ),
                  TO_CHAR(A.FEC_ACEPVENT, 'DD-MM-YYYY' ),
                  TO_CHAR(A.FEC_BAJA, 'DD-MM-YYYY' ),
                  A.TEF_CLIENTE1,
                  a.NOM_EMAIL,
                  LN_cod_catimpos COD_CATIMPOS, LV_des_catimpos DES_CATIMPOS, LN_es_dealer IND_DEALER, LN_monto_ingreso IMP_INGRESO,
                  DECODE(a.ind_debito , 'M', 'MANUAL', 'A', 'AUTOMATICO') IND_DEBITO,
                  LPAD(SUBSTR(a.NUM_TARJETA,-4),LENGTH(a.NUM_TARJETA),'*')NUM_TARJETA,
                  A.FEC_VENCITARJ
              FROM GE_CLIENTES a, GE_TIPIDENT B, GE_CATEGORIAS C, GA_CATRIBUTCLIE D
              WHERE A.COD_CLIENTE   = EN_COD_CLIENTE
                AND A.COD_TIPIDENT  = B.COD_TIPIDENT
                AND A.COD_CATEGORIA = C.COD_CATEGORIA
                AND A.COD_CLIENTE   = D.COD_CLIENTE
                AND SYSDATE BETWEEN D.FEC_DESDE AND FEC_HASTA;


END PV_CONS_CLIENTE_DETALLE_PR;

PROCEDURE PV_CONS_CANT_ABON_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_CANT_ABON_CLIENTE_PR
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una cuenta en SCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del cliente destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS


BEGIN
    -- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

       OPEN SC_BLOQ_CLIENTE  FOR
           SELECT M.COD_TIPLAN, C.DES_VALOR DES_TIPLAN, M.COD_TECNOLOGIA, T.DES_TECNOLOGIA, M.COD_SITUACION, S.DES_SITUACION, M.TOTAL
             FROM (
                   SELECT P.COD_TIPLAN, COD_TECNOLOGIA, A.COD_SITUACION , COUNT(1) TOTAL
                   FROM GA_ABOCEL A, TA_PLANTARIF P
                   WHERE A.COD_PLANTARIF = P.COD_PLANTARIF
                   AND A.COD_PRODUCTO = P.COD_PRODUCTO
                   AND A. COD_CLIENTE =EN_COD_CLIENTE
                   --AND A.COD_SITUACION != 'BAA'
                   GROUP BY P.COD_TIPLAN, A.COD_TECNOLOGIA, A.COD_SITUACION
                   UNION ALL
                   SELECT P.COD_TIPLAN, COD_TECNOLOGIA, A.COD_SITUACION, COUNT(1) TOTAL
                   FROM GA_ABOAMIST A, TA_PLANTARIF P
                   WHERE A.COD_PLANTARIF = P.COD_PLANTARIF
                   AND A.COD_PRODUCTO = P.COD_PRODUCTO
                   AND A. COD_CLIENTE =EN_COD_CLIENTE
                  -- AND A.COD_SITUACION != 'BAA'
                   GROUP BY P.COD_TIPLAN, A.COD_TECNOLOGIA, A.COD_SITUACION
                  ) M,
                   GED_CODIGOS C,
                   AL_TECNOLOGIA T,
                   GA_SITUABO S
           WHERE M.COD_TIPLAN = C.COD_VALOR
           AND C.COD_MODULO ='GE'
           AND C.NOM_TABLA ='TA_PLANTARIF'
           AND NOM_COLUMNA ='COD_TIPLAN'
           AND M.COD_TECNOLOGIA = T.COD_TECNOLOGIA
           AND M.COD_SITUACION = S.COD_SITUACION;


END PV_CONS_CANT_ABON_CLIENTE_PR;
------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_ABONADO_DETALLE_PR(
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_ABONADO_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de un abonadoSCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo de abonado</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_ABONADO   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;


       BEGIN
              OPEN SC_BLOQ_ABONADO  FOR
            SELECT A.NUM_ABONADO, A.NUM_CELULAR, A.COD_USUARIO,
                  B.NOM_USUARIO||'  '||B.NOM_APELLIDO1,
                    A.COD_SITUACION, C.DES_SITUACION, A.COD_TIPCONTRATO, D.DES_TIPCONTRATO,
                  DECODE(A.TIP_PLANTARIF, 'I', 'INDIVIDUAL', 'E', 'EMPRESA') TIPO_PLAN,
                  A.COD_PLANTARIF, E.DES_PLANTARIF,
                  TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ),
                  TO_CHAR(A.FEC_BAJA, 'DD-MM-YYYY' ),
                  TO_CHAR(A.FEC_ACTCEN, 'DD-MM-YYYY' ),
                  TO_CHAR(A.FEC_ACEPVENTA, 'DD-MM-YYYY' ),
                  TO_CHAR(A.FEC_FINCONTRA, 'DD-MM-YYYY' ),
                  A.NUM_VENTA,
                  DECODE(A.COD_USO,2,'POSPAGO', 10, 'HIBRIDO', 3, 'PREPAGO') USO
             FROM GA_ABOCEL A, GA_USUARIOS B, GA_SITUABO C, GA_TIPCONTRATO D,
                    TA_PLANTARIF E
             WHERE A.NUM_ABONADO =  EN_NUM_ABONADO
               AND A.COD_USUARIO = B.COD_USUARIO
               AND A.COD_SITUACION = C.COD_SITUACION
               AND A.COD_PRODUCTO  = D.COD_PRODUCTO
               AND A.COD_TIPCONTRATO= D.COD_TIPCONTRATO
               AND A.COD_PRODUCTO  = E.COD_PRODUCTO
               AND A.COD_PLANTARIF  = E.COD_PLANTARIF
           UNION
             SELECT A.NUM_ABONADO, A.NUM_CELULAR, A.COD_USUARIO,
                    B.NOM_USUARIO||'  '||B.NOM_APELLIDO1,
                    A.COD_SITUACION, C.DES_SITUACION, A.COD_TIPCONTRATO, D.DES_TIPCONTRATO,
                    DECODE(A.TIP_PLANTARIF, 'I', 'INDIVIDUAL', 'E', 'EMPRESA') TIPO_PLAN,
                    A.COD_PLANTARIF, E.DES_PLANTARIF,
                    TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ),
                    TO_CHAR(A.FEC_BAJA, 'DD-MM-YYYY' ),
                    TO_CHAR(A.FEC_ACTCEN, 'DD-MM-YYYY' ),
                    TO_CHAR(A.FEC_ACEPVENTA, 'DD-MM-YYYY' ),
                    TO_CHAR(A.FEC_FINCONTRA, 'DD-MM-YYYY' ),
                    A.NUM_VENTA,
                    DECODE(A.COD_USO,2,'POSPAGO', 10, 'HIBRIDO', 3, 'PREPAGO') USO
                FROM GA_ABOAMIST A, GA_USUAMIST B, GA_SITUABO C, GA_TIPCONTRATO D,
                     TA_PLANTARIF E
                WHERE A.NUM_ABONADO = EN_NUM_ABONADO
                  AND A.COD_USUARIO = B.COD_USUARIO
                  AND A.COD_SITUACION = C.COD_SITUACION
                  AND A.COD_PRODUCTO  = D.COD_PRODUCTO
                  AND A.COD_TIPCONTRATO= D.COD_TIPCONTRATO
                  AND A.COD_PRODUCTO  = E.COD_PRODUCTO
                  AND A.COD_PLANTARIF  = E.COD_PLANTARIF;



       END;

END PV_CONS_ABONADO_DETALLE_PR;

------------------------------------------------------------------------------------------------------------
 PROCEDURE PV_CONS_EQUISIM_DETALLE_OLD_PR(
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_ABONADO_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de un abonadoSCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo de abonado</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_ABONADO   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;


       BEGIN
              OPEN SC_BLOQ_ABONADO  FOR
          SELECT --- DATOS DEL EQUIPO
                 A.NUM_SERIE, B.COD_MODELO, A.COD_ARTICULO, B.DES_ARTICULO,
                 DECODE(A.IND_PROCEQUI, 'I', 'INTERNA', 'E', 'EXTERNA', 'S', 'SUBSIDIADO' ,'SIN PROCEDENCIA' )IND_PROCEEQUI,
                    TO_CHAR(C.FEC_ALTA, 'DD-MM-YYYY')FEC_ALTA, A.IND_EQPRESTADO,
                    --- DATOS DE LA SIMCARD
                    C.NUM_SERIE, C.NUM_IMEI, C.COD_MODELO, C.COD_ARTICULO, C.DES_ARTICULO,
                    DECODE(A.IND_PROCEQUI, 'I', 'INTERNA', 'E', 'EXTERNA', 'S', 'SUBSIDIADO' ,'SIN PROCEDENCIA' )IND_PROCEEQUI,
                    TO_CHAR(C.FEC_ALTA, 'DD-MM-YYYY')FEC_ALTA
            FROM GA_EQUIPABOSER A,
                  AL_ARTICULOS B,
                 (
                     SELECT D.NUM_SERIE, D.NUM_IMEI, E.COD_MODELO, D.COD_ARTICULO, E.DES_ARTICULO,
                              DECODE(D.IND_PROCEQUI, 'I', 'INTERNA', 'E', 'EXTERNA', 'S', 'SUBSIDIADO' ,'SIN PROCEDENCIA' )IND_PROCEEQUI,
                          D.FEC_ALTA, D.IND_EQPRESTADO, D.NUM_ABONADO
                    FROM GA_EQUIPABOSER D, AL_ARTICULOS E
                    WHERE D.NUM_ABONADO  = EN_NUM_ABONADO
                      AND D.COD_ARTICULO = E.COD_ARTICULO
                       AND D.TIP_TERMINAL = GV_TIP_SIM
                ) C
           WHERE A.NUM_ABONADO  = EN_NUM_ABONADO
             AND A.COD_ARTICULO = B.COD_ARTICULO
             AND A.TIP_TERMINAL = GV_TIP_TERMINAL
                AND A.NUM_ABONADO  = C.NUM_ABONADO(+);


       END;

END PV_CONS_EQUISIM_DETALLE_OLD_PR;


------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DIRECCION_DETALLE_PR(
    EN_COD_DIRECCION               IN  GE_DIRECCIONES.COD_DIRECCION%TYPE,
    EN_COD_TIPDIRECCION          IN  GE_TIPDIRECCION.COD_TIPDIRECCION%TYPE,
    SC_BLOQ_DIRECCION            OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_DIRECCION_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una dirección</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_DIRECCION" Tipo="Number">Codigo de dirección </param>
          <param nom="EN_COD_TIPDIRECCION" Tipo="Number">Codigo de tipo de dirección </param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_DIRECCION   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;


       BEGIN
              OPEN SC_BLOQ_DIRECCION  FOR
                SELECT F.DES_COMUNA, E.DES_CIUDAD, D.DES_PROVINCIA, C.DES_REGION,
                     A.NOM_CALLE,  A.NUM_CALLE,  A.NUM_PISO,      A.ZIP,
                     A.OBS_DIRECCION,
                     A.COD_COMUNA, A.COD_CIUDAD, A.COD_PROVINCIA, A.COD_REGION,A.DES_DIREC1
                  FROM GE_DIRECCIONES A, GA_DIRECCLI   B,
                       GE_REGIONES    C, GE_PROVINCIAS D,
                       GE_CIUDADES    E, GE_COMUNAS    F
                  WHERE A.COD_DIRECCION    = EN_COD_DIRECCION
                    AND A.COD_DIRECCION    = B.COD_DIRECCION
                    AND B.COD_TIPDIRECCION = EN_COD_TIPDIRECCION
                    AND A.COD_REGION       = C.COD_REGION
                    AND A.COD_REGION       = D.COD_REGION
                    AND A.COD_PROVINCIA    = D.COD_PROVINCIA
                    AND A.COD_REGION       = E.COD_REGION
                    AND A.COD_PROVINCIA    = E.COD_PROVINCIA
                    AND A.COD_CIUDAD       = E.COD_CIUDAD
                    AND A.COD_REGION       = F.COD_REGION
                    AND A.COD_PROVINCIA    = F.COD_PROVINCIA
                    AND A.COD_COMUNA       = F.COD_COMUNA;


       END;

END PV_CONS_DIRECCION_DETALLE_PR;


------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CUENTA_X_COD_PR(
    EN_COD_CUENTA                   IN  GA_CUENTAS.COD_CUENTA%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_X_COD_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cuenta</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    --LV_des_error          ge_errores_pg.desevent;
    --LV_sSql               ge_errores_pg.vQuery;

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    SN_cod_retorno  := 0;

       BEGIN
             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
          SN_num_evento := 0;
              OPEN SC_BLOQ_CUENTA  FOR
                   SELECT A.COD_CUENTA, A.DES_CUENTA,  TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ),
                          DECODE(TIP_CUENTA, 'P', 'PERSONA', 'E', 'EMPRESA',  'R', 'RESIDENCIAL') TIP_CUENTA,
                          TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD')
                   FROM GA_CUENTAS A
                   WHERE A.COD_CUENTA =EN_COD_CUENTA
                   ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;
       END;

END PV_CONS_GRILLA_CUENTA_X_COD_PR;
------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CUENTA_X_DES_PR(
    EN_DES_CUENTA                   IN  GA_CUENTAS.DES_CUENTA%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_X_DES_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front por des_cuenta</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_DES_CUENTA" Tipo="Number">Descripción del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
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
    LV_DES_CUENTA         GA_CUENTAS.DES_CUENTA%TYPE;

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    -- El error se controla en el WS.
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */

       BEGIN
          LV_DES_CUENTA := '%'|| upper(EN_DES_CUENTA) ||'%';
              OPEN SC_BLOQ_CUENTA  FOR
                   SELECT A.COD_CUENTA, A.DES_CUENTA, TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ),
                          DECODE(TIP_CUENTA, 'P', 'PERSONA', 'E', 'EMPRESA',  'R', 'RESIDENCIAL') TIP_CUENTA,
                          TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
                   FROM GA_CUENTAS A
                   WHERE upper(DES_CUENTA)  LIKE LV_DES_CUENTA
                   ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;


       END;

END PV_CONS_GRILLA_CUENTA_X_DES_PR;

------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CUENTA_X_IDE_PR(
       EN_NUM_IDENT                 IN  GA_CUENTAS.NUM_IDENT%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_X_NUM_IDENT_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front por num_ident</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_NUM_IDENT" Tipo="Number">Busqueda por num_ident/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
      -- El error se controla en el Ws
      SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;
     *               Se agrega a Select TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */


       BEGIN

              OPEN SC_BLOQ_CUENTA  FOR
                   SELECT A.COD_CUENTA, A.DES_CUENTA, TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ),
                          DECODE(TIP_CUENTA, 'P', 'PERSONA', 'E', 'EMPRESA',  'R', 'RESIDENCIAL') TIP_CUENTA,
                          TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
                   FROM GA_CUENTAS A
                   WHERE NUM_IDENT    =EN_NUM_IDENT
                   ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;


       END;

END PV_CONS_GRILLA_CUENTA_X_IDE_PR;

------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CLIE_X_CUEN_PR(
    EN_COD_CUENTA                 IN  GE_CLIENTES.COD_CUENTA%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_CLIE_X_CUEN_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front por cod_cuenta</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_NUM_IDENT" Tipo="Number">Busqueda por cod_cuenta/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;
     *               Se agrega a Select TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */


       BEGIN

              OPEN SC_BLOQ_CLIENTE  FOR
               SELECT a.COD_CLIENTE, NOM_CLIENTE||' '||NOM_APECLIEN1||' '||NOM_APECLIEN2 NOMBRE,
                        DECODE(IND_TIPPERSONA, 'F', 'PERSONA FISICA', 'J', 'EMPRESA',  'SIN ASIGNACION') IND_TIPPERSONA,
                        TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ) , A.COD_CUENTA,
                        TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
                  FROM GE_CLIENTES a
                 WHERE A.COD_CUENTA =  EN_COD_CUENTA
                 ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;


       END;

END PV_CONS_GRILLA_CLIE_X_CUEN_PR;


------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CLIE_X_COD_PR(
    EN_COD_CLIENTE                 IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_CLIE_X_COD_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front por cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_NUM_IDENT" Tipo="Number">Busqueda por cod_cliente/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN

-- El control de la existencia se realiza en el Web-Service
      SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select  TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */


       BEGIN

              OPEN SC_BLOQ_CLIENTE  FOR
               SELECT a.COD_CLIENTE, NOM_CLIENTE||' '||NOM_APECLIEN1||' '||NOM_APECLIEN2 NOMBRE,
                        DECODE(IND_TIPPERSONA, 'F', 'PERSONA FISICA', 'J', 'EMPRESA',  'SIN ASIGNACION') IND_TIPPERSONA,
                        TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ), A.COD_CUENTA,
                        TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
                  FROM GE_CLIENTES a
                 WHERE A.COD_CLIENTE =  EN_COD_CLIENTE
                 ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;

        END;

END PV_CONS_GRILLA_CLIE_X_COD_PR;

------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_GRILLA_CLIE_X_NOM_PR(
    EN_NOM_CLIENTE               IN  GE_CLIENTES.NOM_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_X_NOM_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front por nom_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_DES_CUENTA" Tipo="Number">nombre del cliente/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursor>ursor con datos del clienteparam>
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
    LV_NOM_CLIENTE        GE_CLIENTES.NOM_CLIENTE%TYPE;

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */

       BEGIN
         -- LV_NOM_CLIENTE := '%'||EN_NOM_CLIENTE||'%';
          --LV_NOM_CLIENTE := EN_NOM_CLIENTE||'%';
              OPEN SC_BLOQ_CLIENTE  FOR
                    SELECT a.COD_CLIENTE, NOM_CLIENTE||' '||NOM_APECLIEN1||' '||NOM_APECLIEN2 NOMBRE,
                         DECODE(IND_TIPPERSONA, 'F', 'PERSONA FISICA', 'J', 'EMPRESA',  'SIN ASIGNACION') IND_TIPPERSONA,
                         TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ), A.COD_CUENTA,
                         TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' )
                     FROM GE_CLIENTES a
                     WHERE upper(A.NOM_CLIENTE) LIKE '%' || upper(EN_NOM_CLIENTE) || '%'
                     ORDER BY TO_DATE(TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;

       END;

END PV_CONS_GRILLA_CLIE_X_NOM_PR;
------------------------------------------------------------------------------------------------------------

PROCEDURE PV_CONS_GRILLA_ABO_X_CEL_PR(
    EN_NUM_CELULAR               IN  GA_ABOCEL.NUM_CELULAR%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_ABO_X_CEL_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front por num celular</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_NUM_IDENT" Tipo="Number">Busqueda por num_celular/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_ABONADO   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;


    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un  ORDER BY TO_DATE(Z.FEC_ALTAORD, 'DD-MM-YYYY') ASC;
     *               Se agrega a Select TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' ), NVL(TO_CHAR(A.FEC_BAJA, 'YYYY-MM-DD' ),' ')
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */

       BEGIN

              OPEN SC_BLOQ_ABONADO  FOR
              SELECT * FROM (
              SELECT A.NUM_ABONADO, A.NUM_CELULAR, C.DES_SITUACION,
                         TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ) FEC_ALTAORD, NVL(TO_CHAR(A.FEC_BAJA, 'DD-MM-YYYY' ),' '),A.NUM_VENTA,
                       DECODE(A.COD_USO,2,'POSPAGO', 10, 'HIBRIDO', 3, 'PREPAGO') COD_USO,
                      B.NOM_USUARIO, A.COD_CLIENTE,  A.COD_CUENTA,
                      TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' ),
                      NVL(TO_CHAR(A.FEC_BAJA, 'YYYY-MM-DD' ),' ')
                 FROM GA_ABOCEL A, GA_USUARIOS B, GA_SITUABO C
                WHERE A.NUM_CELULAR = EN_NUM_CELULAR
                    AND A.COD_USUARIO = B.COD_USUARIO
                    AND A.COD_SITUACION = C.COD_SITUACION
              UNION
                SELECT A.NUM_ABONADO, A.NUM_CELULAR, C.DES_SITUACION,
                       TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ) FEC_ALTAORD, NVL(TO_CHAR(A.FEC_BAJA, 'DD-MM-YYYY' ), ' '),A.NUM_VENTA,
                       DECODE(A.COD_USO,2,'POSPAGO', 10, 'HIBRIDO', 3, 'PREPAGO') COD_USO,
                       B.NOM_USUARIO,A.COD_CLIENTE,  A.COD_CUENTA,
                       TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' ),
                       NVL(TO_CHAR(A.FEC_BAJA, 'YYYY-MM-DD' ), ' ')
                  FROM GA_ABOAMIST A, GA_USUAMIST B, GA_SITUABO C
                  WHERE A.NUM_CELULAR = EN_NUM_CELULAR
                     AND A.COD_USUARIO = B.COD_USUARIO
                     AND A.COD_SITUACION = C.COD_SITUACION)  Z
                     ORDER BY TO_DATE(Z.FEC_ALTAORD, 'DD-MM-YYYY') ASC;


       END;

END PV_CONS_GRILLA_ABO_X_CEL_PR;

PROCEDURE PV_CONS_GRILLA_ABO_X_CLI_PR(
    EN_COD_CLIENTE               IN  GA_ABOCEL.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_ABO_X_CLi_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front por codigo de cliente/Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_NUM_IDENT" Tipo="Number">Busqueda por ncod_cliente/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un Z ORDER BY TO_DATE(Z.FEC_ALTAORD, 'DD-MM-YYYY') ASC;
     *               Se agrega a Select  TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' ), NVL(TO_CHAR(A.FEC_BAJA, 'YYYY-MM-DD' ), '  ' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */


       BEGIN

              OPEN SC_BLOQ_CLIENTE  FOR
              SELECT * FROM (
              SELECT A.NUM_ABONADO, A.NUM_CELULAR, C.DES_SITUACION,
                         TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ) FEC_ALTAORD, NVL(TO_CHAR(A.FEC_BAJA, 'DD-MM-YYYY' ), '  ' ),A.NUM_VENTA,
                       DECODE(A.COD_USO,2,'POSPAGO', 10, 'HIBRIDO', 3, 'PREPAGO') COD_USO,
                      B.NOM_USUARIO, A.COD_CLIENTE,  A.COD_CUENTA,
                      TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' ),
                      NVL(TO_CHAR(A.FEC_BAJA, 'YYYY-MM-DD' ), '  ' )
                 FROM GA_ABOCEL A, GA_USUARIOS B, GA_SITUABO C
                WHERE A.COD_CLIENTE = EN_COD_CLIENTE
                    AND A.COD_USUARIO = B.COD_USUARIO
                    AND A.COD_SITUACION = C.COD_SITUACION
              UNION
                SELECT A.NUM_ABONADO, A.NUM_CELULAR, C.DES_SITUACION,
                       TO_CHAR(A.FEC_ALTA, 'DD-MM-YYYY' ) FEC_ALTAORD, NVL(TO_CHAR(A.FEC_BAJA, 'DD-MM-YYYY' ), '  '),A.NUM_VENTA,
                       DECODE(A.COD_USO,2,'POSPAGO', 10, 'HIBRIDO', 3, 'PREPAGO') COD_USO,
                       B.NOM_USUARIO, A.COD_CLIENTE,  A.COD_CUENTA,
                       TO_CHAR(A.FEC_ALTA, 'YYYY-MM-DD' ),
                       NVL(TO_CHAR(A.FEC_BAJA, 'YYYY-MM-DD' ), '  ')
                  FROM GA_ABOAMIST A, GA_USUAMIST B, GA_SITUABO C
                  WHERE A.COD_CLIENTE = EN_COD_CLIENTE
                     AND A.COD_USUARIO = B.COD_USUARIO
                     AND A.COD_SITUACION = C.COD_SITUACION) Z
                     ORDER BY TO_DATE(Z.FEC_ALTAORD, 'DD-MM-YYYY') ASC;


       END;

END PV_CONS_GRILLA_ABO_X_CLI_PR;

PROCEDURE PV_CONS_GRILLA_DIR_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_DIR_X_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN

-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

       BEGIN
              OPEN SC_BLOQ_CLIENTE  FOR
                      SELECT A.COD_TIPDIRECCION, B.DES_TIPDIRECCION, A.COD_DIRECCION
                           FROM GA_DIRECCLI A, GE_TIPDIRECCION B
                           WHERE A.COD_CLIENTE      =EN_COD_CLIENTE
                             AND A.COD_TIPDIRECCION = B.COD_TIPDIRECCION;


       END;

END PV_CONS_GRILLA_DIR_X_CLI_PR;

PROCEDURE PV_CONS_GRILLA_FAC_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_FAC_X_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_EMISION, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(A.FEC_EMISION, 'YYYY-MM-DD' ), TO_CHAR(A.FEC_VENCIMIE, 'YYYY-MM-DD' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 16/08/2010
     *
     */

       BEGIN
              OPEN SC_BLOQ_CLIENTE  FOR
                    SELECT A.NUM_FOLIO,
                         B.DES_TIPDOCUM,
                         TO_CHAR(A.FEC_EMISION, 'DD-MM-YYYY' ),
                         TO_CHAR(A.FEC_VENCIMIE, 'DD-MM-YYYY' ),
                         A.ACUM_IVA, A.TOT_FACTURA,
                         A.COD_CICLFACT,
                         TO_CHAR(A.FEC_EMISION, 'YYYY-MM-DD' ),
                         TO_CHAR(A.FEC_VENCIMIE, 'YYYY-MM-DD' )
                     FROM FA_HISTDOCU A, GE_TIPDOCUMEN B
                     WHERE A.COD_CLIENTE      = EN_COD_CLIENTE
                     AND A.COD_TIPDOCUM       = B.COD_TIPDOCUM
                     AND A.COD_TIPDOCUM = 2
                     ORDER BY TO_DATE(TO_CHAR(A.FEC_EMISION, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;

       END;

END PV_CONS_GRILLA_FAC_X_CLI_PR;


PROCEDURE PV_CONS_GRILLA_CC_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_CC_X_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursorrsor con datos del clienteparam>
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

    --ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

       BEGIN
              OPEN SC_BLOQ_CLIENTE  FOR
              SELECT a.cod_cliente,  a.num_abonado, a.cod_tipdocum, b.des_tipdocum,
                     a.importe_debe, a.importe_haber, c.acum_netograv
              FROM   co_cartera a, ge_tipdocumen b, fa_histdocu c
              WHERE  a.cod_cliente  = EN_COD_CLIENTE
              AND    a.cod_cliente = c.cod_cliente
              AND    a.cod_tipdocum = b.cod_tipdocum
              AND    a.cod_tipdocum = c.cod_tipdocum
              AND    a.num_folio = c.num_folio;

       END;

END PV_CONS_GRILLA_CC_X_CLI_PR;

PROCEDURE PV_CONS_GRILLA_PAGOS_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_PAGOS_X_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN

-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

       BEGIN
              OPEN SC_BLOQ_CLIENTE  FOR
                 SELECT A.NUM_SECUENCI,
                      TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY' ),
                      A.COD_TIPDOCUM,
                      B.DES_TIPDOCUM,
                      A.IMP_PAGO
                 FROM CO_PAGOS A, GE_TIPDOCUMEN B
                 WHERE A.COD_CLIENTE  = EN_COD_CLIENTE
                   AND A.COD_TIPDOCUM = B.COD_TIPDOCUM;

       END;

END PV_CONS_GRILLA_PAGOS_X_CLI_PR;


PROCEDURE PV_CONS_GRILLA_AJUSTE_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    EN_COD_TIPDOCUM              IN CO_AJUSTES.COD_TIPDOCUM%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_AJUSTE_X_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

       BEGIN
              OPEN SC_BLOQ_CLIENTE  FOR
                    SELECT A.NUM_SECUENCI,
                         TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY' ),
                         A.COD_TIPDOCUM, B.DES_TIPDOCUM,
                         A.IMPORTE_DEBE
                   FROM CO_AJUSTES A , GE_TIPDOCUMEN B
                   WHERE A.COD_CLIENTE  = EN_COD_CLIENTE
                     AND A.COD_TIPDOCUM = EN_COD_TIPDOCUM
                     AND A.COD_TIPDOCUM = B.COD_TIPDOCUM;



       END;

END PV_CONS_GRILLA_AJUSTE_X_CLI_PR;

PROCEDURE PV_CONS_GRILLA_OS_X_CUENTA_PR(
    EN_COD_CUENTA                   IN  GA_CUENTAS.COD_CUENTA%TYPE,
    SC_BLOQ_CUENTA               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_OS_X_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_CUENTA</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursorrsor con datos del clienteparam>
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

    --ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(Z.FECHAORD, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(a.fecha,'YYYY-MM-DD')
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */

       BEGIN
              OPEN SC_BLOQ_CUENTA  FOR
              SELECT * FROM (
                 SELECT a.num_os,b.descripcion, a.usuario,TO_CHAR(a.fecha, 'DD-MM-YYYY') FECHAORD,
                      'OK' status, a.cod_os, a.comentario, TO_CHAR(a.fecha, 'YYYY-MM-DD')
               FROM   ci_orserv a, ci_tiporserv b
               WHERE  a.cod_os = b.cod_os
               AND    a.tip_inter = GV_TIP_INTER_CUENTA
               AND    a.cod_inter = EN_COD_CUENTA
               UNION
               SELECT a.num_os, c.descripcion, a.usuario,TO_CHAR(a.fh_ejecucion, 'DD-MM-YYYY') FECHAORD,
                      a.status, a.cod_os, a.comentario, TO_CHAR(a.fh_ejecucion, 'YYYY-MM-DD')
               FROM   pv_iorserv a, pv_camcom b , ci_tiporserv c
               WHERE  a.num_os = b.num_os
                AND    a.tip_sujeto = GV_TIP_SUJETO_CUENTA
               AND    b.cod_cuenta = EN_COD_CUENTA
               AND    a.cod_os = c.cod_os
                 UNION
                  SELECT a.num_os, c.descripcion, a.usuario,TO_CHAR(a.fh_historico, 'DD-MM-YYYY') FECHAORD,
                      a.status, a.cod_os, a.comentario, TO_CHAR(a.fh_historico, 'YYYY-MM-DD')
               FROM   pvh_iorserv a, pvh_camcom b , ci_tiporserv c
               WHERE  a.num_os = b.num_os
                AND    a.tip_sujeto = GV_TIP_SUJETO_CUENTA
               AND    b.cod_cuenta = EN_COD_CUENTA
               AND    a.cod_os = c.cod_os) Z
               ORDER BY TO_DATE(Z.FECHAORD, 'DD-MM-YYYY') ASC;

       END;

END PV_CONS_GRILLA_OS_X_CUENTA_PR;

PROCEDURE PV_CONS_GRILLA_OS_X_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_BLOQ_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_OS_X_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_CLIENTE</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursor con datos del cliente </param>
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

    --ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(Z.FECHAORD, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(a.fecha,'YYYY-MM-DD')
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */

       BEGIN
              OPEN SC_BLOQ_CLIENTE  FOR
              SELECT * FROM (
                 SELECT a.num_os,b.descripcion, a.usuario,TO_CHAR(a.fecha,'DD-MM-YYYY') FECHAORD,
                      'OK' status, a.cod_os, a.comentario, TO_CHAR(a.fecha,'YYYY-MM-DD')
               FROM   ci_orserv a, ci_tiporserv b
               WHERE  a.cod_os = b.cod_os
               AND    a.tip_inter = GV_TIP_INTER_CLIENTE
               AND    a.cod_inter = EN_COD_CLIENTE
               UNION
               SELECT a.num_os, c.descripcion, a.usuario,TO_CHAR(a.fh_ejecucion,'DD-MM-YYYY') FECHAORD,
                      a.status, a.cod_os, a.comentario, TO_CHAR(a.fh_ejecucion,'YYYY-MM-DD')
               FROM   pv_iorserv a, pv_camcom b , ci_tiporserv c
               WHERE  a.num_os = b.num_os
                AND    a.tip_sujeto = GV_TIP_SUJETO_CLIENTE
               AND    b.cod_cliente = EN_COD_CLIENTE
               AND    a.cod_os = c.cod_os
                 UNION
                  SELECT a.num_os, c.descripcion, a.usuario,TO_CHAR(a.fh_historico,'DD-MM-YYYY') FECHAORD,
                      a.status, a.cod_os, a.comentario, TO_CHAR(a.fh_historico,'YYYY-MM-DD')
               FROM   pvh_iorserv a, pvh_camcom b , ci_tiporserv c
               WHERE  a.num_os = b.num_os
                AND    a.tip_sujeto = GV_TIP_SUJETO_CLIENTE
               AND    b.cod_cliente = EN_COD_CLIENTE
               AND    a.cod_os = c.cod_os) Z
               ORDER BY TO_DATE(Z.FECHAORD, 'DD-MM-YYYY') ASC;

       END;

END PV_CONS_GRILLA_OS_X_CLIENTE_PR;

PROCEDURE PV_CONS_GRILLA_OS_X_ABON_PR(
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_OS_X_ABON_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or NUM_ABONADO</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_ABONADO" Tipo="Number">Numero de abonado</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_ABONADO   Tipo="Cursor con datos del abonado</param>
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

    --ERROR_CONTROLADO      EXCEPTION;

BEGIN

-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(Z.FECHAORD, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(a.fecha,'YYYY-MM-DD')
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */


       BEGIN
              OPEN SC_BLOQ_ABONADO  FOR
              SELECT * FROM (
                 SELECT a.num_os,b.descripcion, a.usuario,TO_CHAR(a.fecha,'DD-MM-YYYY') FECHAORD,
                      'OK' status, a.cod_os, a.comentario, TO_CHAR(a.fecha,'YYYY-MM-DD')
               FROM   ci_orserv a, ci_tiporserv b
               WHERE  a.cod_os = b.cod_os
               AND    a.tip_inter = GV_TIP_INTER_ABONADO
               AND    a.cod_inter = EN_NUM_ABONADO
               UNION
               SELECT a.num_os, c.descripcion, a.usuario,TO_CHAR(a.fh_ejecucion,'DD-MM-YYYY') FECHAORD,
                      a.status, a.cod_os, a.comentario, TO_CHAR(a.fh_ejecucion,'YYYY-MM-DD')
               FROM   pv_iorserv a, pv_camcom b , ci_tiporserv c
               WHERE  a.num_os = b.num_os
                AND    a.tip_sujeto = GV_TIP_SUJETO_ABONADO
               AND    b.num_abonado = EN_NUM_ABONADO
               AND    a.cod_os = c.cod_os
                 UNION
                  SELECT a.num_os, c.descripcion, a.usuario,TO_CHAR(a.fh_historico,'DD-MM-YYYY') FECHAORD,
                      a.status, a.cod_os, a.comentario, TO_CHAR(a.fh_historico ,'YYYY-MM-DD')
               FROM   pvh_iorserv a, pvh_camcom b , ci_tiporserv c
               WHERE  a.num_os = b.num_os
                AND    a.tip_sujeto = GV_TIP_SUJETO_ABONADO
               AND    b.num_abonado = EN_NUM_ABONADO
               AND    a.cod_os = c.cod_os) Z
               ORDER BY TO_DATE(Z.FECHAORD, 'DD-MM-YYYY') ASC;

         /*EXCEPTION WHEN NO_DATA_FOUND THEN
                   SV_MENS_RETORNO:='No se puede recuperar cliente ';
                   SN_COD_RETORNO := 20;
                     RAISE ERROR_CONTROLADO;*/
       END;


END PV_CONS_GRILLA_OS_X_ABON_PR;



PROCEDURE PV_CONS_GRILLA_SS_X_ABON_PR(
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_OS_X_ABON_P"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_CUENTA</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    -- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

       BEGIN
              OPEN SC_BLOQ_ABONADO  FOR
             SELECT A.COD_SERVICIO,
                 A.DES_SERVICIO,
                 TO_CHAR(H.FEC_ALTABD,  'DD-MM-YYYY') FEC_ALTABD,
                 TO_CHAR(H.FEC_ALTACEN, 'DD-MM-YYYY') FEC_ALTACEN,
                 F.IMP_TARIFA,
                 --I.DES_CONCEPTO
                 H.COD_CONCEPTO
            FROM GA_SERVSUPL A, GA_ACTUASERV B,
                 GA_TARIFAS C
               , GE_MONEDAS D, GA_ACTUASERV E, GA_TARIFAS F, GE_MONEDAS G, GA_SERVSUPLABO H,
                 FA_CONCEPTOS I
              WHERE A.COD_PRODUCTO      = 1
              AND A.COD_NIVEL         =  H.COD_NIVEL
              AND A.COD_SERVICIO      = H.COD_SERVICIO
              AND H.NUM_ABONADO       = EN_NUM_ABONADO
              AND H.IND_ESTADO        < 3
              AND A.IND_COMERC        = 1
              AND A.TIP_SERVICIO      = '1'--LV_TIP_SERVICIO
              AND A.COD_PRODUCTO      = B.COD_PRODUCTO(+)
              AND A.COD_SERVICIO      = B.COD_SERVICIO(+)
              AND B.COD_ACTABO(+)     = 'SS'
              AND B.COD_TIPSERV(+)    = '2'
              AND B.COD_PRODUCTO      = C.COD_PRODUCTO(+)
              AND B.COD_ACTABO        = C.COD_ACTABO(+)
              AND B.COD_TIPSERV       = C.COD_TIPSERV(+)
              AND B.COD_SERVICIO      = C.COD_SERVICIO(+)
              AND C.COD_PLANSERV(+)   ='1' --EV_COD_PLANSERV
              AND SYSDATE BETWEEN C.FEC_DESDE(+) AND NVL(C.FEC_HASTA(+), SYSDATE)
              AND C.COD_MONEDA        = D.COD_MONEDA(+)
              AND A.COD_PRODUCTO      = E.COD_PRODUCTO(+)
              AND A.COD_SERVICIO      = E.COD_SERVICIO(+)
              AND E.COD_ACTABO(+)     = 'FA'
              AND E.COD_TIPSERV(+)    = '2'
              AND E.COD_PRODUCTO      = F.COD_PRODUCTO(+)
              AND E.COD_ACTABO        = F.COD_ACTABO(+)
              AND E.COD_TIPSERV       = F.COD_TIPSERV(+)
              AND E.COD_SERVICIO      = F.COD_SERVICIO(+)
              AND F.COD_PLANSERV(+)   = '1'--1EV_COD_PLANSERV
              AND SYSDATE BETWEEN F.FEC_DESDE(+) AND NVL(F.FEC_HASTA(+), SYSDATE)
              AND F.COD_MONEDA        = G.COD_MONEDA(+)
              AND E.COD_CONCEPTO      = I.COD_CONCEPTO(+);

        END;

END PV_CONS_GRILLA_SS_X_ABON_PR;


PROCEDURE PV_CONS_GRILLA_BP_X_ABON_PR(
    EN_COD_CLIENTE               IN  GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_BP_X_ABON_P"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_CUENTA</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(B.FEC_INGRESO, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(FEC_INGRESO, 'YYYY-MM-DD'), TO_CHAR(FEC_ESTADO, 'YYYY-MM-DD')
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 16/08/2010
     *
     */

    -- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

       BEGIN
              OPEN SC_BLOQ_ABONADO  FOR
                  SELECT A.CNT_PERIODOS,
                       TO_CHAR(FEC_INGRESO, 'DD-MM-YYYY'),
                       E.DES_VALOR DES_ESTADO,
                       NVL(B.VAL_ACUMULADO, 0) VAL_ACUMULADO,
                       NVL(VAL_BENEFICIO, 0) VAL_BENEFICIO,
                       TO_CHAR(FEC_ESTADO, 'DD-MM-YYYY'),
                       G.DES_VALOR DES_TIPLAN,
                       B.COD_PLAN COD_PLAN,
                       A.DES_PLAN DES_PLAN,
                       TO_CHAR(FEC_INGRESO, 'YYYY-MM-DD'),
                       TO_CHAR(FEC_ESTADO, 'YYYY-MM-DD')
                  FROM BPD_PLANES A,
                       BPT_BENEFICIARIOS B,
                       GED_CODIGOS C,
                       GED_CODIGOS D,
                       GED_CODIGOS E,
                       GED_CODIGOS F,
                       GED_CODIGOS G
                   WHERE B.COD_CLIENTE      = EN_COD_CLIENTE
                     AND B.NUM_ABONADO      = EN_NUM_ABONADO
                     AND A.COD_PLAN         = B.COD_PLAN
                     AND A.FEC_DESDEAPLI    = B.FEC_DESDEAPLI
                     AND A.TIP_ENTIDAD      = 'A'
                     AND C.COD_MODULO       = 'BP'
                     AND C.NOM_TABLA        = 'BPD_PLANES'
                     AND C.NOM_COLUMNA      = 'TIP_BENEFICIO'
                     AND C.COD_VALOR        = A.TIP_BENEFICIO
                     AND D.COD_MODULO       = 'BP'
                     AND D.NOM_TABLA        = 'BPD_PLANES'
                     AND D.NOM_COLUMNA      = 'TIP_PERIODO'
                     AND D.COD_VALOR        = A.TIP_PERIODO
                     AND E.COD_MODULO       = 'BP'
                     AND E.NOM_TABLA        = 'BPT_BENEFICIARIOS'
                     AND E.NOM_COLUMNA      = 'COD_ESTADO'
                     AND E.COD_VALOR        = B.COD_ESTADO
                     AND F.COD_MODULO(+)    = 'BP'
                     AND F.NOM_TABLA(+)     = 'BPD_PLANES'
                     AND F.NOM_COLUMNA(+)   = 'TIP_VALOR'
                     AND F.COD_VALOR(+)     = NVL(A.TIP_VALOR,'M')
                     AND G.COD_MODULO       = 'GE'
                     AND G.NOM_TABLA        = 'TA_PLANTARIF'
                     AND G.NOM_COLUMNA      = 'COD_TIPLAN'
                     AND G.COD_VALOR        = A.COD_TIPLAN
                     ORDER BY TO_DATE(TO_CHAR(B.FEC_INGRESO, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;

       END;


END PV_CONS_GRILLA_BP_X_ABON_PR;

PROCEDURE PV_CONS_GRILLA_LC_X_ABON_PR(
    EN_COD_CLIENTE               IN  GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_BP_X_ABON_P"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_CUENTA</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN

    -- El control de la existencia se realiza en el Web-Service
      SN_cod_retorno  := 0;

       BEGIN
              OPEN SC_BLOQ_ABONADO  FOR
                 SELECT  B.COD_LIMCONS,
                       C.DESCRIPCION,
                       C.COD_UMBRAL_MIN,
                       D.DES_UMBRAL,
                       1--E.ACU_CONSUMO
                  FROM GA_ABOCEL A,
                       GA_LIMITE_CLIABO_TO B,
                       TOL_LIMITE_TD C,
                       TOL_UMBRAL_TD D
                       --LC_ACUMULA_00 E
                  WHERE A.NUM_ABONADO      = EN_NUM_ABONADO
                    AND A.COD_CLIENTE      = EN_COD_CLIENTE
                    AND A.COD_CLIENTE      = B.COD_CLIENTE
                    AND A.NUM_ABONADO      = B.NUM_ABONADO
                    AND B.COD_LIMCONS      = A.COD_LIMCONSUMO
                    AND B.COD_LIMCONS      = C.COD_LIMCONS
                    AND C.COD_UMBRAL_MIN   = D.COD_UMBRAL
                    AND B.FEC_DESDE <= SYSDATE
                    AND NVL(B.FEC_HASTA,SYSDATE+1) >= SYSDATE
                    AND C.FEC_DESDE <= SYSDATE
                    AND NVL(C.FEC_HASTA,SYSDATE+1) >= SYSDATE;
        /*
                    AND A.COD_CLIENTE      = E.COD_CLIENTE
                    AND A.NUM_ABONADO      = E.COD_ABONADO
                    AND B.COD_LIMCONS      = E.COD_LIMITE
                    AND E.FEC_TASA    IN
                    ( SELECT COD_CICLFACT
                         FROM FA_CICLFACT
                         WHERE SYSDATE BETWEEN FEC_DESDELLAM
                           AND FEC_HASTALLAM
                           AND COD_CICLO = A.COD_CICLO
                    )
                    AND A.COD_CICLO   = E.COD_CICLO;
                    */

       END;

END PV_CONS_GRILLA_LC_X_ABON_PR;

PROCEDURE PV_CONS_GRILLA_PLC_X_ABON_PR(
    EN_COD_CLIENTE               IN  GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_PLC_X_ABON_PR
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_CUENTA</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN

    -- El control de la existencia se realiza en el Web-Service
      SN_cod_retorno  := 0;

       BEGIN

              OPEN SC_BLOQ_ABONADO  FOR
              SELECT A.DES_PAGO,
                     TO_CHAR(A.FEC_VALOR, 'DD-MM-YYYY') FEC_VALOR,
                     A.NOM_USUARORA, A.IMP_PAGO
                FROM TOL_PAGO_LIMITE_TH A
                WHERE A.COD_TIPDOCUM  = GV_COD_TIPDOCUM_CERO
                  AND A.COD_CLIENTE   = EN_COD_CLIENTE
                  AND A.COD_ABONADO   = EN_NUM_ABONADO;
       END;

END PV_CONS_GRILLA_PLC_X_ABON_PR;

PROCEDURE PV_CONS_GRILLA_DETLLAM_X_PR(
    EN_COD_CLIENTE               IN  GA_ABOCEL.COD_CLIENTE%TYPE,
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    EN_COD_CICLFACT                 IN  FA_HISTDOCU.COD_CICLFACT%TYPE,
    EN_TIPO_LLAMADA              IN  GED_CODIGOS.DES_VALOR%TYPE,
    SC_BLOQ_LLAMADAS              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_PLC_X_ABON_PR
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_CUENTA</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursorrsor con datos del clienteparam>
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

    V_fa_detcelular    fa_enlacehist.fa_detcelular%TYPE;
    V_fa_detroaming   fa_enlacehist.fa_detroaming%TYPE;
    V_fa_histdocu   fa_enlacehist.fa_histdocu%TYPE;
    V_fa_histconc   fa_enlacehist.fa_histconc%TYPE;
    N_cod_tipalmac   fa_enlacehist.cod_tipalmac%TYPE;
    N_ind_tasador   fa_enlacehist.ind_tasador%TYPE;
    GV_nom_tabla   CONSTANT VARCHAR2 (11):= 'SCH_CODIGOS';
    GV_cod_trana   CONSTANT VARCHAR2 (4) := 'ROAM';
    GV_cod_tipo    CONSTANT VARCHAR2 (7) := 'CODLLAM';
    V_cod_sent CONSTANT VARCHAR2 (5) := 'S';


    ERROR_CONTROLADO      EXCEPTION;

BEGIN

    -- El control de la existencia se realiza en el Web-Service
      SN_cod_retorno  := 0;

       -- Cursor dinamico.
       BEGIN

          -- Obtiene el Ciclo de Facturación
          IF NOT FA_GENERAL_PG.fa_valida_ciclo_fn (EN_cod_ciclfact,SN_cod_retorno,SV_mens_retorno,SN_num_evento) THEN
            SN_cod_retorno:= -1;
          END IF;

          -- Obtencion de la Tabla de Historica
          IF NOT FA_GENERAL_PG.fa_cons_tablas_enlacehist_fn(EN_cod_ciclfact, V_fa_detcelular, V_fa_detroaming, V_fa_histdocu, V_fa_histconc, N_cod_tipalmac, N_ind_tasador,SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
             SN_cod_retorno:= -1;
             raise error_controlado;
          END IF;

          IF v_fa_detcelular IS NULL THEN
             SN_cod_retorno:= -1;
             SV_mens_retorno := 'No se encontró tabla detalle asociada al ciclo consultado (ciclo:' || EN_cod_ciclfact || ')';
             raise error_controlado;
          END IF;

          LV_sSql := 'SELECT TO_CHAR(TO_DATE(date_start_charg, ''YYYYMMDD''),''DD-MM-YYYY'') AS fec_llamada , a_susc_number AS celular_orig, b_susc_number AS celular_dest,';
          LV_sSql := LV_sSql || ' dur_Real AS duracion, mto_fact AS valor, time_start_charg||'||''' '''||'||des_destino AS horario ';
          LV_sSql := LV_sSql || ' FROM ta_tipohorario t, ' || V_fa_detcelular;
          LV_sSql := LV_sSql || ' M, ged_codigos g, sch_codigos c ';
          LV_sSql := LV_sSql || ' WHERE num_abon = ' || EN_num_abonado;
          LV_sSql := LV_sSql || ' AND num_clie= ' || EN_COD_CLIENTE;
          LV_sSql := LV_sSql || ' AND cod_llam= g.cod_valor AND G.cod_modulo= '''|| GV_cod_modulo||'''';
          LV_sSql := LV_sSql || ' AND G.nom_tabla= '''|| GV_nom_tabla ||''' AND G.des_valor= '''|| EN_TIPO_LLAMADA||'''';
          LV_sSql := LV_sSql || ' AND cod_trana not in (''' || GV_cod_trana || ''') AND T.cod_tipohorario = cod_thor';
          LV_sSql := LV_sSql || ' AND C.cod_param=cod_llam AND C.cod_tipo= '''|| GV_cod_tipo ||'''';
          LV_sSql := LV_sSql || ' AND cod_sent = '''|| V_cod_sent ||'''';

          OPEN  SC_BLOQ_LLAMADAS FOR LV_sSql;

          END;

      SN_cod_retorno  := 0;
      SV_mens_retorno := '';
EXCEPTION
   WHEN ERROR_CONTROLADO THEN
      null;
   WHEN OTHERS THEN
      if sqlcode = -942 then -- table or view does not exist
         SN_cod_retorno:= -1;
         SV_mens_retorno := sqlerrm || '(table : ' || V_fa_detcelular || ')';
      else
         SN_cod_retorno:= -1;
         SV_mens_retorno := sqlerrm ;
      end if;
      OPEN  SC_BLOQ_LLAMADAS FOR 'select 1 from dual';
END PV_CONS_GRILLA_DETLLAM_X_PR;
-------------------------------------------------------------------------------
PROCEDURE PV_CONS_DEUDA_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SN_MONTO_DEUDA               OUT NOCOPY NUMBER,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_DEUDA_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de una cuenta en SCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del cliente destino</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
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
    LN_cod_catimpos       NUMBER;
    LV_des_catimpos       VARCHAR2(1000);
    LN_es_dealer NUMBER;
    ln_monto_ingreso NUMBER;
    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    -- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;
    SELECT NVL(SUM(a.importe_debe - a.importe_haber),0)
    INTO SN_MONTO_DEUDA
    FROM CO_CARTERA A
    WHERE A.COD_CLIENTE = en_cod_cliente
    AND A.IND_FACTURADO = 1
    AND NOT EXISTS (SELECT 1
                    FROM CO_CODIGOS b
                    WHERE b.nom_tabla = 'CO_CARTERA'
                    AND b.nom_columna = 'COD_TIPDOCUM'
                    AND TO_NUMBER(b.cod_valor) = a.cod_tipdocum);

EXCEPTION
 WHEN NO_DATA_FOUND THEN
    SN_MONTO_DEUDA := 0;
 WHEN OTHERS THEN
    RAISE;

END PV_CONS_DEUDA_CLIENTE_PR;

PROCEDURE PV_CONS_DOC_FACT_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    EV_FEC_INI                   IN VARCHAR2,
    EV_FEC_FIN                   IN VARCHAR2,
    EV_FORMATO_FEC               IN VARCHAR2,
    SC_DOC_CLIENTE               OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_FAC_X_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

    BEGIN
       IF TO_DATE(EV_fec_ini, EV_formato_fec) >= TO_DATE(EV_fec_fin, EV_formato_fec)  THEN
            SN_COD_RETORNO := 11;
            SV_MENS_RETORNO := 'La fecha inicial debe ser menor a la fecha final de búsqueda';
            RETURN;
       END IF;
    EXCEPTION

       WHEN OTHERS THEN
          SN_COD_RETORNO := 10;
          SV_MENS_RETORNO := 'La fecha no tiene el formato adecuado';
          RETURN;
    END;


    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_EMISION, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(A.FEC_EMISION, 'YYYY-MM-DD' ), TO_CHAR(A.FEC_VENCIMIE, 'YYYY-MM-DD' )
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 17/08/2010
     *
     */

    OPEN SC_DOC_CLIENTE  FOR
                    SELECT A.NUM_FOLIO,
                         A.COD_TIPDOCUM,
                         B.DES_TIPDOCUM,
                         NULL OBS_DOCUM,
                         TO_CHAR(A.FEC_EMISION, 'DD-MM-YYYY' ) FEC_EMISION,
                         TO_CHAR(A.FEC_VENCIMIE, 'DD-MM-YYYY' ) FEC_VENCIMIE,
                         A.ACUM_IVA TOT_IVA,
                         A.TOT_FACTURA, ind_ordentotal,
                         TO_CHAR(A.FEC_EMISION, 'YYYY-MM-DD' ),
                         TO_CHAR(A.FEC_VENCIMIE, 'YYYY-MM-DD' ),
                         a.acum_netograv
                     FROM FA_HISTDOCU A, GE_TIPDOCUMEN B
                     WHERE A.COD_CLIENTE      = EN_COD_CLIENTE
                     AND A.COD_TIPDOCUM       = B.COD_TIPDOCUM
                     AND TRUNC(A.FEC_EMISION) BETWEEN TO_DATE(EV_fec_ini, EV_formato_fec) AND TO_DATE(EV_fec_fin, EV_formato_fec)
                     AND A.COD_TIPDOCUM IN (SELECT TO_NUMBER(T.COD_VALOR)
                                            FROM GED_CODIGOS T
                                            WHERE T.COD_MODULO = 'GE'
                                            AND T.NOM_TABLA = 'DOC_CARGOS_CARTERA'
                                            AND T.NOM_COLUMNA ='COD_TIPDOCUM' )
                                            ORDER BY TO_DATE(TO_CHAR(A.FEC_EMISION, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC; --KVV 22-11-2010
--                                               UNION --REGISTRO DE LA CO_CARTERA
--                    SELECT A.NUM_FOLIO,
--                    A.COD_TIPDOCUM,
--                    B.DES_TIPDOCUM, 
--                    NULL OBS_DOCUM,
--                    TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY' ) FEC_EMISION,
--                    TO_CHAR(A.FEC_VENCIMIE, 'DD-MM-YYYY' ) FEC_VENCIMIE,
--                    0 TOT_IVA,
--                    IMPORTE_DEBE TOT_FACTURA,
--                    0 IND_ORDENTOTAL,
--                    TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYY-MM-DD' ) FEC_EMISION,
--                    TO_CHAR(A.FEC_VENCIMIE, 'YYYY-MM-DD' ) FEC_VENCIMIE,0 ACUM_NETOGRAV
--                    FROM CO_CARTERA A,GE_TIPDOCUMEN B     
--                    WHERE A.COD_CLIENTE=EN_COD_CLIENTE
--                    AND  A.COD_TIPDOCUM       = B.COD_TIPDOCUM
--                    AND TRUNC(A.FEC_EFECTIVIDAD) BETWEEN TO_DATE(EV_fec_ini, EV_formato_fec) AND TO_DATE(EV_fec_fin, EV_formato_fec)
--                    AND A.COD_TIPDOCUM IN (SELECT TO_NUMBER(T.COD_VALOR)
--                                            FROM GED_CODIGOS T
--                                            WHERE T.COD_MODULO = 'GE'
--                                            AND T.NOM_TABLA = 'DOC_CARGOS_CARTERA'
--                                            AND T.NOM_COLUMNA ='COD_TIPDOCUM' )
--                     ORDER BY 5 ASC;


END PV_CONS_DOC_FACT_X_CLI_PR;

PROCEDURE PV_CONS_DOC_PAGOS_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    EV_FEC_INI                   IN VARCHAR2,
    EV_FEC_FIN                   IN VARCHAR2,
    EV_FORMATO_FEC               IN VARCHAR2,
    SC_DOC_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_DOC_PAGOS_X_CLI_PR
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN

-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;
    BEGIN
       IF TO_DATE(EV_fec_ini, EV_formato_fec) >= TO_DATE(EV_fec_fin, EV_formato_fec)  THEN
            SN_COD_RETORNO := 11;
            SV_MENS_RETORNO := 'La fecha inicial debe ser menor a la fecha final de búsqueda';
            RETURN;
       END IF;
    EXCEPTION

       WHEN OTHERS THEN
          SN_COD_RETORNO := 10;
          SV_MENS_RETORNO := 'La fecha no tiene el formato adecuado';
          RETURN;
    END;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un Z ORDER BY TO_DATE(Z.FEC_EMISION, 'DD-MM-YYYY') ASC
     *               Se agrega a Select TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYY-MM-DD' ), NULL FEC_VENCIMIE2
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 18/08/2010
     *
     */

              OPEN SC_DOC_CLIENTE  FOR
              SELECT * FROM (
                 SELECT A.NUM_SECUENCI NUM_FOLIO,
                      A.COD_TIPDOCUM,
                        B.DES_TIPDOCUM,
                      A.DES_PAGO OBS_DOCUM,
                      TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY' ) FEC_EMISION,
                      NULL FEC_VENCIMIE,
                      0 TOT_IVA,
                      A.IMP_PAGO,
                      TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYY-MM-DD' ),
                      NULL FEC_VENCIMIE2
                 FROM CO_PAGOS A, GE_TIPDOCUMEN B
                 WHERE A.COD_CLIENTE  = EN_COD_CLIENTE
                   AND A.COD_TIPDOCUM = B.COD_TIPDOCUM
                   AND A.COD_TIPDOCUM NOT IN (9,10,32)
                   AND TRUNC(A.FEC_EFECTIVIDAD)  BETWEEN TO_DATE(EV_fec_ini, EV_formato_fec) AND TO_DATE(EV_fec_fin, EV_formato_fec)
                   AND A.COD_TIPDOCUM IN (SELECT TO_NUMBER(T.COD_VALOR)
                                            FROM GED_CODIGOS T
                                            WHERE T.COD_MODULO = 'GE'
                                            AND T.NOM_TABLA = 'DOC_ABONOS_CARTERA'
                                            AND T.NOM_COLUMNA ='COD_TIPDOCUM' )
                UNION ALL
                  SELECT A.NUM_SECUENCI NUM_FOLIO,
                      A.COD_TIPDOCUM,
                        B.DES_TIPDOCUM,
                      A.DES_PAGO OBS_DOCUM,
                      TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY' ) FEC_EMISION,
                      NULL FEC_VENCIMIE,
                      NULL TOT_IVA,
                      A.IMP_PAGO,
                      TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYY-MM-DD' ),
                      NULL FEC_VENCIMIE2
                 FROM CO_CARTERA C, CO_PAGOS A, GE_TIPDOCUMEN B
                 WHERE A.COD_CLIENTE = C.COD_CLIENTE
                   AND A.NUM_SECUENCI = C.NUM_SECUENCI
                   AND A.COD_CLIENTE  = EN_COD_CLIENTE
                   AND A.COD_TIPDOCUM = B.COD_TIPDOCUM
                   AND C.IND_FACTURADO = 1
                   AND A.COD_TIPDOCUM =32
                   AND C.COD_TIPDOCUM = A.COD_TIPDOCUM
                   AND TRUNC(A.FEC_EFECTIVIDAD)  BETWEEN TO_DATE(EV_fec_ini, EV_formato_fec) AND TO_DATE(EV_fec_fin, EV_formato_fec)
                   )Z ORDER BY TO_DATE(Z.FEC_EMISION, 'DD-MM-YYYY') ASC;


END PV_CONS_DOC_PAGOS_X_CLI_PR;
-------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_DOC_AJUSTES_X_CLI_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    EV_FEC_INI                   IN VARCHAR2,
    EV_FEC_FIN                   IN VARCHAR2,
    EV_FORMATO_FEC               IN VARCHAR2,
    SC_DOC_CLIENTE              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_DOC_AJUSTES_X_CLI_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cliente</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo del CLIENTE/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CLIENTE   Tipo="Cursorrsor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    BEGIN
       IF TO_DATE(EV_fec_ini, EV_formato_fec) >= TO_DATE(EV_fec_fin, EV_formato_fec)  THEN
            SN_COD_RETORNO := 11;
            SV_MENS_RETORNO := 'La fecha inicial debe ser menor a la fecha final de búsqueda';
            RETURN;
       END IF;
    EXCEPTION

       WHEN OTHERS THEN
          SN_COD_RETORNO := 10;
          SV_MENS_RETORNO := 'La fecha no tiene el formato adecuado';
          RETURN;
    END;
    SN_cod_retorno  := 0;

    /*
     * Modificacion
     * Descripcion:  Se agrega a la query un ORDER BY TO_DATE(TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;
     *               Se agrega a Select TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYY-MM-DD' ), NULL FEC_VENCIMIE
     *               para el ordenamiento de la tabla
     * Developer: Gabriel Moraga L.
     * Fecha: 18/08/2010
     *
     */

    OPEN SC_DOC_CLIENTE  FOR
                    SELECT A.NUM_SECUENCI NUM_FOLIO,
                         A.COD_TIPDOCUM,
                         B.DES_TIPDOCUM,
                         A.DES_OBSERVA,
                         TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY' ) FEC_EMISION,
                         NULL FEC_VENCIMIE,
                         0 TOT_IVA,
                         A.IMPORTE_DEBE,
                         TO_CHAR(A.FEC_EFECTIVIDAD, 'YYYY-MM-DD' ),
                         NULL FEC_VENCIMIE
                   FROM CO_AJUSTES A , GE_TIPDOCUMEN B
                   WHERE A.COD_CLIENTE  = EN_COD_CLIENTE
                     AND A.COD_TIPDOCUM = B.COD_TIPDOCUM
                     AND TRUNC(A.FEC_EFECTIVIDAD)  BETWEEN TO_DATE(EV_fec_ini, EV_formato_fec) AND TO_DATE(EV_fec_fin, EV_formato_fec)
                     AND A.COD_TIPDOCUM IN (SELECT TO_NUMBER(T.COD_VALOR)
                                            FROM GED_CODIGOS T
                                            WHERE T.COD_MODULO = 'GE'
                                            AND T.NOM_TABLA = 'DOC_AJUSTE_CARTERA'
                                            AND T.NOM_COLUMNA ='COD_TIPDOCUM')
                                            ORDER BY TO_DATE(TO_CHAR(A.FEC_EFECTIVIDAD, 'DD-MM-YYYY'), 'DD-MM-YYYY') ASC;

END PV_CONS_DOC_AJUSTES_X_CLI_PR;
---------------------------------------------------------------------------------------
PROCEDURE PV_CONS_EQUISIM_DETALLE_PR(
    EN_NUM_ABONADO               IN  GA_ABOCEL.NUM_ABONADO%TYPE,
    SC_BLOQ_ABONADO              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_ABONADO_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de un abonadoSCL</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CLIENTE" Tipo="Number">Codigo de abonado</param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_ABONADO   Tipo="Cursor>ursor con datos del clienteparam>
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

    ERROR_CONTROLADO      EXCEPTION;

SV_NUM_IMEI GA_ABOCEL.NUM_IMEI%TYPE;
SV_NUM_SERIE GA_ABOCEL.NUM_SERIE%TYPE;
SV_FEC_ALTA_EQUIP VARCHAR2(10);
SV_COD_ARTICULO_EQUIP AL_ARTICULOS.COD_ARTICULO%TYPE;
SV_IND_PROCEQUI_EQUIP VARCHAR2(100);
SV_IND_PRESTADO_EQUIP GA_EQUIPABOSER.IND_EQPRESTADO%TYPE;
SV_FEC_ALTA_SIM VARCHAR2(10);
SV_COD_ARTICULO_SIM AL_ARTICULOS.COD_ARTICULO%TYPE;
SV_IND_PROCEQUI_SIM VARCHAR2(100);
LV_COD_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
LV_DES_TECNOLOGIA AL_TECNOLOGIA.DES_TECNOLOGIA%TYPE;
LV_NUM_SERIE_EQUIP GA_ABOCEL.NUM_SERIE%TYPE;
LV_TIP_TERMINAL GA_ABOCEL.TIP_TERMINAL%TYPE;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;


   BEGIN
       --Se recuperan series del abonado
       SELECT P.num_imei, P.num_serie, p.cod_tecnologia, t.des_tecnologia, p.tip_terminal
       INTO  SV_NUM_IMEI, SV_NUM_SERIE, LV_cod_tecnologia, lv_des_tecnologia, lv_tip_terminal
       FROM GA_ABOCEL P, AL_TECNOLOGIA T
       WHERE P.num_abonado = EN_NUM_ABONADO
       AND P.COD_TECNOLOGIA = T.COD_TECNOLOGIA
       UNION
       SELECT O.num_imei, O.num_serie, o.cod_tecnologia, p.des_tecnologia, o.tip_terminal
       FROM GA_ABOAMIST O, AL_TECNOLOGIA P
       WHERE O.num_abonado = EN_NUM_ABONADO
       AND O.COD_TECNOLOGIA = P.COD_TECNOLOGIA;
   EXCEPTION
      WHEN TOO_MANY_ROWS THEN
         SN_cod_retorno := 101;
         SV_mens_retorno := 'Error, se ha econtrado mas de un abonado para el número de abonado de búsqueda';
         RETURN;
      WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 100;
         SV_mens_retorno := 'Abonado no existe';
         RETURN;
      WHEN OTHERS THEN
         SN_cod_retorno := 102;
         SV_mens_retorno := 'Ha ocurrido un error al recuperar datos del abonado';
         RETURN;
   END;


   BEGIN
      ---Datos del equipo
      IF LV_COD_TECNOLOGIA = 'GSM' THEN
         LV_NUM_SERIE_EQUIP := SV_NUM_IMEI;
         LV_TIP_TERMINAL := GV_TIP_TERMINAL;
      ELSE
         LV_NUM_SERIE_EQUIP := SV_NUM_SERIE;
      END IF;

      SV_mens_retorno := 'No se ha encontrado serie del equipo';

      SELECT TO_CHAR(M.FEC_ALTA,'DD-MM-YYYY'), M.COD_ARTICULO,DECODE(M.IND_PROCEQUI, 'I', 'INTERNA', 'E', 'EXTERNA', 'S', 'SUBSIDIADO' ,'SIN PROCEDENCIA' )IND_PROCEEQUI,
             M.IND_EQPRESTADO
      INTO SV_FEC_ALTA_EQUIP, SV_COD_ARTICULO_EQUIP, SV_IND_PROCEQUI_EQUIP, SV_IND_PRESTADO_EQUIP
      FROM GA_EQUIPABOSER M
      WHERE M.NUM_ABONADO = EN_NUM_ABONADO
      AND M.NUM_SERIE =  LV_NUM_SERIE_EQUIP
      AND FEC_ALTA = (SELECT MAX(FEC_ALTA)
                      FROM GA_EQUIPABOSER D
                      WHERE D.NUM_ABONADO  = EN_NUM_ABONADO
                      AND TIP_TERMINAL = LV_TIP_TERMINAL
                      AND NUM_SERIE = LV_NUM_SERIE_EQUIP
                     );


      IF LV_COD_TECNOLOGIA ='GSM' THEN
             --Datos de la simcard
          SELECT TO_CHAR(M.FEC_ALTA,'DD-MM-YYYY'), M.COD_ARTICULO,DECODE(M.IND_PROCEQUI, 'I', 'INTERNA', 'E', 'EXTERNA', 'S', 'SUBSIDIADO' ,'SIN PROCEDENCIA' )IND_PROCEEQUI
          INTO SV_FEC_ALTA_SIM, SV_COD_ARTICULO_SIM, SV_IND_PROCEQUI_SIM
          FROM GA_EQUIPABOSER M
          WHERE M.NUM_ABONADO = EN_NUM_ABONADO
          AND M.NUM_SERIE = SV_NUM_SERIE
          AND FEC_ALTA = (SELECT MAX(FEC_ALTA)
                       FROM GA_EQUIPABOSER D
                       WHERE D.NUM_ABONADO  = EN_NUM_ABONADO
                        AND TIP_TERMINAL = GV_TIP_SIM
                       AND NUM_SERIE = SV_NUM_SERIE
                       );
      END IF;

   EXCEPTION
      WHEN TOO_MANY_ROWS THEN
         SN_cod_retorno := 103;
         SV_mens_retorno := 'Error, se ha econtrado mas de una serie asociada al abonado';
         RETURN;
      WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 104;
        -- SV_mens_retorno := 'No se ha encontrado serie en registros de cambios de series';
         RETURN;
      WHEN OTHERS THEN
         SN_cod_retorno := 105;
         SV_mens_retorno := 'Ha ocurrido un error al recuperar datos de la serie';
         RETURN;
   END;
   SV_mens_retorno :=NULL;

   IF LV_COD_TECNOLOGIA ='GSM' THEN
       --Datos del artículo
          OPEN SC_BLOQ_ABONADO  FOR
          SELECT SV_NUM_SERIE NUM_SERIE,
                EQUIP.COD_MODELO,
                EQUIP.COD_ARTICULO,
                EQUIP.DES_ARTICULO,
                SV_IND_PROCEQUI_EQUIP,
                SV_FEC_ALTA_EQUIP,
                SV_IND_PRESTADO_EQUIP IND_EQPRESTADO,
                SV_NUM_SERIE NUM_SERIE2,
                SV_NUM_IMEI NUM_IEMI,
                SIM.COD_MODELO,
                SIM.COD_ARTICULO,
                SIM.DES_ARTICULO,
                SV_IND_PROCEQUI_SIM,
                SV_FEC_ALTA_SIM,
                EQUIP.COD_GAMA,
                G.DESCRIPCION_VALOR DES_GAMA,
                LV_DES_TECNOLOGIA DES_TECNOLOGIA
          FROM AL_ARTICULOS SIM, AL_ARTICULOS EQUIP, AL_GAMA_VW G
          WHERE SIM.COD_ARTICULO = SV_COD_ARTICULO_SIM
          AND EQUIP.COD_ARTICULO = SV_COD_ARTICULO_EQUIP
          AND EQUIP.COD_GAMA = TO_NUMBER(G.VALOR(+));
   ELSE
      --Datos del artículo
          OPEN SC_BLOQ_ABONADO  FOR
          SELECT SV_NUM_SERIE NUM_SERIE,
                EQUIP.COD_MODELO,
                EQUIP.COD_ARTICULO,
                EQUIP.DES_ARTICULO,
                SV_IND_PROCEQUI_EQUIP,
                SV_FEC_ALTA_EQUIP,
                SV_IND_PRESTADO_EQUIP IND_EQPRESTADO,
                NULL NUM_SERIE2,
                NULL NUM_IEMI,
                NULL COD_MODELO,
                NULL COD_ARTICULO,
                NULL DES_ARTICULO,
                NULL,
                NULL,
                EQUIP.COD_GAMA,
                G.DESCRIPCION_VALOR DES_GAMA,
                LV_DES_TECNOLOGIA DES_TECNOLOGIA
          FROM  AL_ARTICULOS EQUIP, AL_GAMA_VW G
          WHERE
           EQUIP.COD_ARTICULO = SV_COD_ARTICULO_EQUIP
          AND EQUIP.COD_GAMA = TO_NUMBER(G.VALOR(+));

   END IF;
EXCEPTION
 WHEN OTHERS THEN
         SN_cod_retorno := 106;
         SV_mens_retorno := 'Ha ocurrido un error en el proceso de recuparación del detalle de serie';
         RETURN;

END PV_CONS_EQUISIM_DETALLE_PR;


---------------------------------------------------------------------------------------
PROCEDURE PV_CONS_PLANES_X_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_PLANES              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_ABONADO_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de un abonadoSCL</Descripción>
      <Parámetros>
         <Entrada>
                      <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_ABONADO   Tipo="Cursor>ursor con datos del clienteparam>
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
lv_cod_concepto NUMBER;
BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;


   BEGIN
       --Se recuperan series del abonado
       SELECT cod_abonocel
       INTO lv_cod_concepto
       FROM fa_datosgener;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         lv_cod_concepto:= NULL;
      WHEN OTHERS THEN
         SN_cod_retorno := 200;
         SV_mens_retorno := 'Ha ocurrido un error al recuperar concepto facturable';
         RETURN;
   END;

   --Datos del artículo
   OPEN SC_PLANES  FOR
        SELECT DISTINCT e.cod_plantarif, p.des_plantarif, c.imp_cargobasico, lv_cod_concepto
        FROM ga_empresa e, ta_plantarif p, ta_cargosbasico c
        WHERE cod_cliente = EN_COD_CLIENTE
        AND e.cod_producto = p.cod_producto
        AND e.cod_plantarif = p.cod_plantarif
        AND p.cod_producto = c.cod_producto
        AND p.cod_cargobasico = c.cod_cargobasico
        AND SYSDATE BETWEEN c.fec_desde AND nvl(c.fec_hasta,sysdate);
        
        

EXCEPTION
 WHEN OTHERS THEN
         SN_cod_retorno := 206;
         SV_mens_retorno := 'Ha ocurrido un error en el proceso de recuparación planes por cliente';
         RETURN;

END PV_CONS_PLANES_X_CLIENTE_PR;




---------------------------------------------------------------------------------------
/*PROCEDURE PV_CONS_SS_X_CLIENTE_PR(
    EN_COD_CLIENTE               IN  GE_CLIENTES.COD_CLIENTE%TYPE,
    SC_SERVSUPL                  OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )*/
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_ABONADO_DETALLE_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consultar el detalle de un abonadoSCL</Descripción>
      <Parámetros>
         <Entrada>
                      <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_ABONADO   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
/*IS
    LV_des_error          ge_errores_pg.desevent;
    LV_sSql               ge_errores_pg.vQuery;

BEGIN
-- El control de la existencia se realiza en el Web-Service
    SN_cod_retorno  := 0;

   --Datos del artículo
   OPEN SC_SERVSUPL FOR
         SELECT s.cod_servicio, b.des_servicio, NULL, s.cod_concepto,DECODE(s.ind_estado,1,'ACTIVO',2,'ACTIVO','INACTIVO') estado_ss,
               TO_CHAR(s.fec_altabd,'DD-MM-YYYY') fec_altabd, TO_CHAR(s.fec_bajabd,'DD-MM-YYYY') fec_bajabd,
               TO_CHAR(s.fec_altacen ,'DD-MM-YYYY') fec_altacen, TO_CHAR(s.fec_bajacen ,'DD-MM-YYYY') fec_bajacen
        FROM   ga_servsuplcli_to s, ga_servsupl b
        WHERE  cod_cliente = EN_COD_CLIENTE
        AND    s.cod_producto = b.cod_producto
        AND    s.cod_servicio = b.cod_servicio
        ORDER BY  estado_ss ASC;
        
        --AND    s.fec_bajabd IS NULL; --Se comenta esta linea ya que es sentido de la busqueda es traer los servicios auque se encuentren de baja

END PV_CONS_SS_X_CLIENTE_PR;*/

PROCEDURE pv_cons_cbplan_clte_pr(
    EN_num_os                     ci_orserv.num_os%TYPE,
    SC_datcamplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )
IS

LN_cod_cliente                     ga_intarcel.cod_cliente%TYPE;
LD_fecha                         ci_orserv.fecha%TYPE;
LV_usuario                         ci_orserv.usuario%TYPE;
LV_comentario                    ci_orserv.comentario%TYPE;
LV_cod_plantarif_ori             ga_intarcel.cod_plantarif%TYPE;
LV_cod_plantarif_dno             ga_intarcel.cod_plantarif%TYPE;
LD_fec_proxplan                     ga_intarcel.fec_hasta%TYPE;
LD_fec_desde                     ga_intarcel.fec_desde%TYPE;
LV_des_plantarif_ori             ta_plantarif.des_plantarif%TYPE;
LV_des_plantarif_dno             ta_plantarif.des_plantarif%TYPE;
LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno := 1;
     SV_mens_retorno := 'No existe n° orden de servicio.';

    SELECT fecha, cod_inter, usuario, comentario
    INTO LD_fecha, LN_cod_cliente, LV_usuario, LV_comentario
    FROM ci_orserv
    WHERE num_os = EN_num_os;

     SN_cod_retorno := 2;
     SV_mens_retorno := 'No existe información del plan origen.';

    --Obtener plan para la fecha de ejecución de la orden de servicio.
    SELECT cod_plantarif, fec_hasta + (((1/24)/60)/60)
    INTO LV_cod_plantarif_ori, LD_fec_proxplan
    FROM ga_intarcel
    WHERE cod_cliente = LN_cod_cliente
    AND num_abonado = 0
    AND LD_fecha BETWEEN fec_desde AND fec_hasta
    UNION
    SELECT cod_plantarif, fec_hasta
    FROM gah_intarcel
    WHERE cod_cliente = LN_cod_cliente
    AND num_abonado = 0
    AND LD_fecha BETWEEN fec_desde AND fec_hasta;

     SN_cod_retorno := 3;
     SV_mens_retorno := 'No existe información del plan destino.';

    SELECT cod_plantarif, fec_desde
    INTO LV_cod_plantarif_dno, LD_fec_desde
    FROM ga_intarcel
    WHERE cod_cliente = LN_cod_cliente
    AND num_abonado = 0
    AND LD_fec_proxplan BETWEEN fec_desde AND fec_hasta
    UNION
    SELECT cod_plantarif, fec_hasta
    FROM gah_intarcel
    WHERE cod_cliente = LN_cod_cliente
    AND num_abonado = 0
    AND LD_fec_proxplan  BETWEEN fec_desde AND fec_hasta;

     SN_cod_retorno := 5;
     SV_mens_retorno := 'No existen datos del plan origen.';

    SELECT des_plantarif INTO LV_des_plantarif_ori
    FROM ta_plantarif
    WHERE cod_producto = GV_COD_PRODUCTO
    AND cod_plantarif = LV_cod_plantarif_ori;

     SN_cod_retorno := 6;
     SV_mens_retorno := 'No existen datos del plan destino.';

    SELECT des_plantarif INTO LV_des_plantarif_dno
    FROM ta_plantarif
    WHERE cod_producto = GV_COD_PRODUCTO
    AND cod_plantarif = LV_cod_plantarif_dno;

    OPEN SC_datcamplan FOR
     SELECT LV_des_plantarif_ori, LV_des_plantarif_dno, TO_CHAR(LD_fec_desde,'DD-MM-YYYY'), LV_usuario, LV_comentario
    FROM DUAL;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_cbplan_clte_pr', sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_cbplan_clte_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_cbplan_clte_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_cbplan_clte_pr;

PROCEDURE pv_cons_cbplan_abo_pos_pr(
    EN_num_os                     ci_orserv.num_os%TYPE,
    SC_datcamplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )
IS

LN_num_abonado                     ga_intarcel.num_abonado%TYPE;
LD_fecha                         ci_orserv.fecha%TYPE;
LV_usuario                         ci_orserv.usuario%TYPE;
LV_comentario                    ci_orserv.comentario%TYPE;
LV_cod_plantarif_ori             ga_intarcel.cod_plantarif%TYPE;
LV_cod_plantarif_dno             ga_intarcel.cod_plantarif%TYPE;
LD_fec_proxplan                     ga_intarcel.fec_hasta%TYPE;
LD_fec_desde                     ga_intarcel.fec_desde%TYPE;
LV_des_plantarif_ori             ta_plantarif.des_plantarif%TYPE;
LV_des_plantarif_dno             ta_plantarif.des_plantarif%TYPE;
LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno := 1;
     SV_mens_retorno := 'No existe n° orden de servicio.';

    SELECT fecha - (((1/24)/60)), cod_inter, usuario, comentario
    INTO LD_fecha, LN_num_abonado, LV_usuario, LV_comentario
    FROM ci_orserv
    WHERE num_os = EN_num_os;

     SN_cod_retorno := 2;
     SV_mens_retorno := 'No existe información del plan origen.';

    --Obtener plan para la fecha de ejecución de la orden de servicio.
    SELECT cod_plantarif, fec_hasta + (((1/24)/60)/60)
    INTO LV_cod_plantarif_ori, LD_fec_proxplan
    FROM ga_intarcel
    WHERE cod_cliente > 0
    AND num_abonado = LN_num_abonado
    AND LD_fecha BETWEEN fec_desde AND fec_hasta
    UNION
    SELECT cod_plantarif, fec_hasta
    FROM gah_intarcel
    WHERE cod_cliente > 0
    AND num_abonado = LN_num_abonado
    AND LD_fecha BETWEEN fec_desde AND fec_hasta;

     SN_cod_retorno := 3;
     SV_mens_retorno := 'No existe información del plan destino.';

    SELECT cod_plantarif, fec_desde
    INTO LV_cod_plantarif_dno, LD_fec_desde
    FROM ga_intarcel
    WHERE cod_cliente > 0
    AND num_abonado = LN_num_abonado
    AND LD_fec_proxplan BETWEEN fec_desde AND fec_hasta
    UNION
    SELECT cod_plantarif, fec_hasta
    FROM gah_intarcel
    WHERE cod_cliente > 0
    AND num_abonado = LN_num_abonado
    AND LD_fec_proxplan  BETWEEN fec_desde AND fec_hasta;

     SN_cod_retorno := 5;
     SV_mens_retorno := 'No existen datos del plan origen.';

    SELECT des_plantarif INTO LV_des_plantarif_ori
    FROM ta_plantarif
    WHERE cod_producto = GV_COD_PRODUCTO
    AND cod_plantarif = LV_cod_plantarif_ori;

     SN_cod_retorno := 6;
     SV_mens_retorno := 'No existen datos del plan destino.';

    SELECT des_plantarif INTO LV_des_plantarif_dno
    FROM ta_plantarif
    WHERE cod_producto = GV_COD_PRODUCTO
    AND cod_plantarif = LV_cod_plantarif_dno;

    OPEN SC_datcamplan FOR
     SELECT LV_des_plantarif_ori, LV_des_plantarif_dno, TO_CHAR(LD_fec_desde,'DD-MM-YYYY'), LV_usuario, LV_comentario
    FROM DUAL;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_cbplan_abo_pos_pr', sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_cbplan_abo_pos_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_cbplan_abo_pos_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_cbplan_abo_pos_pr;


PROCEDURE pv_cons_cbplan_abo_pre_pr(
    EN_num_os                     ci_orserv.num_os%TYPE,
    SC_datcamplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )
IS

LN_num_abonado                     ga_intarcel.num_abonado%TYPE;
LD_fecha                         ci_orserv.fecha%TYPE;
LD_fecha_CPP                     ci_orserv.fecha%TYPE;
LV_usuario                         ci_orserv.usuario%TYPE;
LV_comentario                    ci_orserv.comentario%TYPE;
LV_cod_plantarif_ori             ga_intarcel.cod_plantarif%TYPE;
LV_cod_plantarif_dno             ga_intarcel.cod_plantarif%TYPE;
LD_fec_proxplan                     ga_intarcel.fec_hasta%TYPE;
LD_fec_desde                     ga_intarcel.fec_desde%TYPE;
LD_fec_aux                     ga_intarcel.fec_desde%TYPE;
LV_des_plantarif_ori             ta_plantarif.des_plantarif%TYPE;
LV_des_plantarif_dno             ta_plantarif.des_plantarif%TYPE;
TYPE REFCURSOR IS REF CURSOR;
c_planes REFCURSOR;
LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno := 1;
     SV_mens_retorno := 'No existe n° orden de servicio.';

    SELECT fecha - (((1/24)/60)), fecha, cod_inter, usuario, comentario
    INTO LD_fecha, LD_fecha_CPP, LN_num_abonado, LV_usuario, LV_comentario
    FROM ci_orserv
    WHERE num_os = EN_num_os;


    --Obtener plan para la fecha de ejecución de la orden de servicio.
    OPEN c_planes FOR
    SELECT cod_plantarif, fec_modifica
    FROM ga_modabocel
    WHERE  num_abonado = LN_num_abonado
    AND COD_TIPMODI = 'C7'
    AND FEC_MODIFICA >= LD_fecha
    ORDER BY FEC_MODIFICA ASC;

    --recuperar plan anterior
    FETCH c_planes INTO LV_cod_plantarif_ori, LD_fec_aux;

    IF c_planes%notfound THEN
       SN_cod_retorno := 2;
        SV_mens_retorno := 'No existe información del plan origen.';
    END IF;

    --recuperar plan posterior
    FETCH c_planes INTO LV_cod_plantarif_dno, LD_fec_desde;

    IF c_planes%notfound THEN
        SN_cod_retorno := 3;
       SV_mens_retorno := 'No existe información del plan destino.';
       SELECT COD_PLANTARIF
       INTO LV_cod_plantarif_dno
       FROM GA_ABOAMIST
       WHERE num_abonado = LN_num_abonado;
    END IF;
    CLOSE C_PLANES;

     SN_cod_retorno := 5;
     SV_mens_retorno := 'No existen datos del plan origen.';

    SELECT des_plantarif INTO LV_des_plantarif_ori
    FROM ta_plantarif
    WHERE cod_producto = GV_COD_PRODUCTO
    AND cod_plantarif = LV_cod_plantarif_ori;

     SN_cod_retorno := 6;
     SV_mens_retorno := 'No existen datos del plan destino.';

    SELECT des_plantarif INTO LV_des_plantarif_dno
    FROM ta_plantarif
    WHERE cod_producto = GV_COD_PRODUCTO
    AND cod_plantarif = LV_cod_plantarif_dno;

    OPEN SC_datcamplan FOR
     SELECT LV_des_plantarif_ori, LV_des_plantarif_dno, TO_CHAR(LD_fecha_CPP,'DD-MM-YYYY'), LV_usuario, LV_comentario
    FROM DUAL;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_cbplan_abo_pre_pr', sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_cbplan_abo_pre_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_cbplan_abo_pre_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_cbplan_abo_pre_pr;


PROCEDURE pv_cons_plan_abo_pr(
    EN_num_abonado                 ga_abocel.num_abonado%TYPE,
    SC_datosplan                 OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )
IS

LN_cod_concepto                     fa_datosgener.cod_abonocel%TYPE;
LV_cod_plantarif                 ta_plantarif.cod_plantarif%TYPE;
LV_des_plantarif                 ta_plantarif.des_plantarif%TYPE;
LV_cod_cargobasico                 ta_cargosbasico.cod_cargobasico%TYPE;
LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

     SN_cod_retorno := 1;
     SV_mens_retorno := 'No existe configuración fa_datosgener.';

    SELECT cod_abonocel
    INTO LN_cod_concepto
    FROM fa_datosgener;

     SN_cod_retorno := 2;
     SV_mens_retorno := 'No existe datos del abonado y plan.';
    
    /*
    SELECT b.cod_plantarif, b.des_plantarif, b.cod_cargobasico
    INTO LV_cod_plantarif, LV_des_plantarif, LV_cod_cargobasico
    FROM ga_abocel a, ta_plantarif b
    WHERE a.num_abonado = EN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif
    AND a.cod_producto = b.cod_producto;
    */
    
    SELECT b.cod_plantarif, b.des_plantarif, b.cod_cargobasico
    INTO LV_cod_plantarif, LV_des_plantarif, LV_cod_cargobasico
    FROM ga_abocel a, ta_plantarif b
    WHERE a.num_abonado = EN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif
    AND a.cod_producto = b.cod_producto
            union
            SELECT b.cod_plantarif, b.des_plantarif, b.cod_cargobasico
    FROM ga_aboamist a, ta_plantarif b
    WHERE a.num_abonado = EN_num_abonado
    AND a.cod_plantarif = b.cod_plantarif
    AND a.cod_producto = b.cod_producto;
    
     SN_cod_retorno := 3;
     SV_mens_retorno := 'No existe datos del cargo básico.';

    OPEN SC_datosplan FOR
    SELECT LV_cod_plantarif, LV_des_plantarif,a.imp_cargobasico, LN_cod_concepto
    FROM ta_cargosbasico a
    WHERE a.cod_producto = GV_COD_PRODUCTO
    AND a.cod_cargobasico = LV_cod_cargobasico;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_plan_abo_pr', sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_plan_abo_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_plan_abo_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_plan_abo_pr;

PROCEDURE pv_cons_ss_abo_pr(
    EN_num_abonado                 ga_abocel.num_abonado%TYPE,
    SC_datosSS                      OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )

IS

LV_cod_planserv                  ga_abocel.cod_planserv%TYPE;
LV_cod_plantarif                 ga_abocel.cod_plantarif%TYPE;
LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno := 'OK';
        SN_num_evento := 0;

        sSql:= 'SELECT cod_planserv, cod_plantarif FROM ga_abocel WHERE num_abonado = '||EN_num_abonado||'';

        /*
        SELECT cod_planserv, cod_plantarif
        INTO LV_cod_planserv, LV_cod_plantarif
        FROM ga_abocel
        WHERE num_abonado = EN_num_abonado;
        */

        SELECT cod_planserv, cod_plantarif
        INTO LV_cod_planserv, LV_cod_plantarif
        FROM ga_abocel
        WHERE num_abonado = EN_num_abonado
        union
        SELECT cod_planserv, cod_plantarif
        FROM ga_aboamist
        WHERE num_abonado = EN_num_abonado;

        sSql:= 'SELECT b.cod_servicio,b.des_servicio,c.imp_tarifa,a.cod_concepto,DECODE(a.ind_estado,1,"ACTIVO",2,"ACTIVO","INACTIVO") estado_ss,'
             ||'TO_CHAR(a.fec_altabd,"DD-MM-YYYY HH24:MI:SS") fec_altabd,TO_CHAR(a.fec_bajabd,"DD-MM-YYYY HH24:MI:SS") fec_bajabd '
             ||'TO_CHAR(a.fec_altacen,"DD-MM-YYYY HH24:MI:SS") fec_altacen,TO_CHAR(a.fec_bajacen,"DD-MM-YYYY HH24:MI:SS") fec_bajacen '
             ||'FROM ga_servsuplabo a, ga_servsupl b, gad_servsup_plan g, ga_tarifas c, ga_actuaserv d '
             ||'WHERE a.num_abonado = '||EN_num_abonado||' '
             ||'AND b.cod_producto = 1 '
             ||'AND b.cod_servicio = a.cod_servicio '
             ||'AND g.cod_producto = b.cod_producto '
             ||'AND g.cod_plantarif = '||LV_cod_plantarif||' '
             ||'AND g.cod_servicio = b.cod_servicio '
             ||'AND g.tip_relacion = 2 '
             ||'AND g.fec_desde <= '||SYSDATE||' '
             ||'AND g.fec_hasta >= '||SYSDATE||' '
             ||'AND c.cod_actabo = FA '
             ||'AND c.cod_producto = 1 '
             ||'AND c.cod_servicio = g.cod_servicio '
             ||'AND c.cod_tipserv = d.cod_tipserv '
             ||'AND c.cod_planserv = '||LV_cod_planserv||' '
             ||'AND c.fec_desde <= '||SYSDATE||' '
             ||'AND c.fec_hasta >= '||SYSDATE||' '
             ||'AND d.COD_ACTABO = FA '
             ||'AND d.cod_producto = 1 '
             ||'AND d.cod_servicio = c.cod_servicio';

        OPEN SC_datosSS FOR
        SELECT /*+ index (A, PK_GA_SERVSUPLABO) */ b.cod_servicio, b.des_servicio,
              (SELECT NVL (c.imp_tarifa, 0)
                 FROM ga_tarifas c, ga_abocel d
                WHERE c.cod_servicio = a.cod_servicio
                  AND c.cod_actabo = 'FA'
                  AND c.cod_producto = 1
                  AND d.num_abonado = a.num_abonado
                  AND c.cod_planserv = d.cod_planserv) as imp_tarifa,
                  a.cod_concepto,
       DECODE (a.ind_estado, 1, 'ACTIVO', 2, 'ACTIVO', 'INACTIVO') estado_ss,
       TO_CHAR (a.fec_altabd, 'DD-MM-YYYY') fec_altabd,
       TO_CHAR (a.fec_bajabd, 'DD-MM-YYYY') fec_bajabd,
       TO_CHAR (a.fec_altacen, 'DD-MM-YYYY') fec_altacen,
       TO_CHAR (a.fec_bajacen, 'DD-MM-YYYY') fec_bajacen
  FROM ga_servsuplabo a, ga_servsupl b
 WHERE a.num_abonado = EN_num_abonado
   AND b.cod_producto = 1
   AND b.cod_servicio = a.cod_servicio
   order by a.IND_ESTADO ASC;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 3;
             SV_mens_retorno := 'No existe número de abonado postpago.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_ss_abo_pr', sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_ss_abo_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_ss_abo_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_ss_abo_pr;

PROCEDURE pv_cons_detalle_plan_pr(
    EV_cod_plantarif             ta_plantarif.cod_plantarif%TYPE,
    SC_detplan                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )
IS

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

    OPEN SC_detplan FOR
    SELECT a.cod_plantarif, a.des_plantarif, a.cod_cargobasico, b.cod_limconsumo, b.imp_limconsumo
    FROM ta_plantarif a, ta_limconsumo b
    WHERE a.cod_producto = GV_COD_PRODUCTO
    AND a.cod_plantarif = EV_cod_plantarif
    AND a.cod_producto = b.cod_producto
    AND a.cod_limconsumo = b.cod_limconsumo;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_detalle_plan_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_detalle_plan_pr', sSql, SQLCODE, LV_des_error );

END pv_cons_detalle_plan_pr;

PROCEDURE pv_cons_ss_defplan_x_abo_pr(
    EN_num_abonado                  ga_abocel.num_abonado%TYPE,
    SC_servsup                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )

IS

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;
LN_cod_central                     ga_abocel.cod_central%TYPE;
LN_cod_producto                     ga_abocel.cod_producto%TYPE;
LV_tip_terminal                     ga_abocel.tip_terminal%TYPE;
LN_cod_sistema                     icg_central.cod_sistema%TYPE;
LV_cod_tecnologia                 ga_abocel.cod_tecnologia%TYPE;
LV_cod_plantarif                 ga_abocel.cod_plantarif%TYPE;

BEGIN

    SELECT cod_central, cod_producto, tip_terminal, cod_tecnologia, cod_plantarif
    INTO LN_cod_central, LN_cod_producto, LV_tip_terminal, LV_cod_tecnologia, LV_cod_plantarif
    FROM ga_abocel WHERE num_abonado = EN_num_abonado
    UNION
    SELECT cod_central, cod_producto, tip_terminal, cod_tecnologia, cod_plantarif
    FROM ga_aboamist WHERE num_abonado = EN_num_abonado;

    SELECT cod_sistema INTO LN_cod_sistema
    FROM icg_central
    WHERE cod_central = LN_cod_central
    AND cod_producto = LN_cod_producto;

    OPEN SC_servsup FOR
    SELECT a.cod_servicio, a.des_servicio
    FROM ga_servsuplabo d,ga_servsupl a,icg_serviciotercen b,gad_servsup_plan c
    WHERE c.cod_producto = LN_cod_producto
    AND b.cod_producto = a.cod_producto
    AND b.tip_terminal = LV_tip_terminal
    AND b.cod_sistema = LN_cod_sistema
    AND b.cod_servicio = a.cod_servsupl
    AND b.tip_tecnologia = LV_cod_tecnologia
    AND a.cod_servicio = c.cod_servicio
    AND a.cod_producto = c.cod_producto
    AND c.cod_plantarif = LV_cod_plantarif
    AND c.tip_relacion = 3
    AND a.cod_servicio=d.cod_servicio
    AND d.num_abonado = EN_num_abonado
    AND d.ind_estado < 3
    AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 3;
             SV_mens_retorno := 'No existe número de abonado postpago.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_ss_defplan_x_abo_pr', sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_ss_defplan_x_abo_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_ss_defplan_x_abo_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_ss_defplan_x_abo_pr;

/*PROCEDURE pv_cons_ss_defplan_x_cli_pr(
    EN_cod_cliente                  IN ge_clientes.cod_cliente%TYPE,
    SC_servsup                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )

IS

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

LV_cod_plantarif                 ga_abocel.cod_plantarif%TYPE;

BEGIN
    SV_mens_retorno := 'No se encontró cliente empresa.';
    SELECT cod_plantarif
    INTO LV_cod_plantarif
    FROM ga_empresa WHERE cod_cliente = EN_cod_cliente;


    OPEN SC_servsup FOR
    SELECT a.cod_servicio, a.des_servicio,decode(a.ind_aplica,'A','ABONADO','C','CLIENTE') Aplica
    FROM gad_servsup_plan c, ga_servsupl a
    WHERE c.cod_producto = 1
    AND c.cod_plantarif =  LV_cod_plantarif
    AND a.cod_servicio = c.cod_servicio
    AND a.cod_producto = c.cod_producto
    AND c.tip_relacion = 3
    AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 3;
             --SV_mens_retorno := 'No existe número de abonado postpago.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_ss_defplan_x_cli_pr', sSql, SQLCODE, LV_des_error );
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_ss_defplan_x_cli_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_ss_defplan_x_cli_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_ss_defplan_x_cli_pr;
*/
PROCEDURE pv_cons_numfrec_plan_pr(
    EN_num_abonado                  ga_abocel.num_abonado%TYPE,
    SC_numfrec                     OUT NOCOPY REFCURSOR,
    SN_cod_retorno               OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno              OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
    SN_num_evento                OUT NOCOPY ge_errores_pg.evento
    )
IS

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

  OPEN SC_numfrec FOR
  SELECT DECODE(tip_frecuente,'F','FIJO','M','MOVIL',tip_frecuente), num_telefesp
  FROM ga_numespabo
  WHERE num_abonado = EN_num_abonado;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
         WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_numfrec_plan_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_numfrec_plan_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_numfrec_plan_pr;

PROCEDURE pv_graba_traza_usr_pr(EV_cod_evento     ga_traza_usuario_to.cod_evento%TYPE,
                                  EV_nom_usuario     ga_traza_usuario_to.nom_usuario%TYPE,
                                EN_num_celular     ga_abocel.num_celular%TYPE,
                                EN_num_abonado     ga_abocel.num_abonado%TYPE,
                                EN_cod_cliente     ga_abocel.cod_cliente%TYPE,
                                EN_cod_cuenta     ga_abocel.cod_cuenta%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento)

IS

LT_trzusr            GA_REGISTRO_ACCESO_PG.tip_ga_traza_usuario_to;
LV_sqlcode            ge_errores_td.cod_msgerror%TYPE;
LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

ERR_REGISTRAR        EXCEPTION;

BEGIN

     LT_trzusr(1).nom_usuario := EV_nom_usuario;
     LT_trzusr(1).cod_evento := EV_cod_evento;
     LT_trzusr(1).fec_audit := SYSDATE;

     IF NVL(EN_num_celular,0) > 0 THEN
         SELECT ge_trza_sq.NEXTVAL INTO LT_trzusr(1).num_correl FROM DUAL;
         LT_trzusr(1).tip_entidad := '1';
        LT_trzusr(1).val_entidad := EN_num_celular;
         IF NOT GA_REGISTRO_ACCESO_PG.GA_REGISTRA_ACCESO_USUARIO_FN( LT_trzusr, LV_sqlcode, LV_des_error ) THEN
             SN_cod_retorno := 1;
            RAISE ERR_REGISTRAR;
        END IF;
     END IF;

     IF NVL(EN_num_abonado,0) > 0 THEN
         SELECT ge_trza_sq.NEXTVAL INTO LT_trzusr(1).num_correl FROM DUAL;
         LT_trzusr(1).tip_entidad := '2';
        LT_trzusr(1).val_entidad := EN_num_abonado;
         IF NOT GA_REGISTRO_ACCESO_PG.GA_REGISTRA_ACCESO_USUARIO_FN( LT_trzusr, LV_sqlcode, LV_des_error ) THEN
           SN_cod_retorno := 2;
           RAISE ERR_REGISTRAR;
        END IF;
     END IF;

     IF NVL(EN_cod_cliente,0) > 0 THEN
         SELECT ge_trza_sq.NEXTVAL INTO LT_trzusr(1).num_correl FROM DUAL;
         LT_trzusr(1).tip_entidad := '3';
        LT_trzusr(1).val_entidad := EN_cod_cliente;
         IF NOT GA_REGISTRO_ACCESO_PG.GA_REGISTRA_ACCESO_USUARIO_FN( LT_trzusr, LV_sqlcode, LV_des_error ) THEN
           SN_cod_retorno := 3;
           RAISE ERR_REGISTRAR;
        END IF;
     END IF;

     IF NVL(EN_cod_cuenta,0) > 0 THEN
         SELECT ge_trza_sq.NEXTVAL INTO LT_trzusr(1).num_correl FROM DUAL;
         LT_trzusr(1).tip_entidad := '4';
        LT_trzusr(1).val_entidad := EN_cod_cuenta;
         IF NOT GA_REGISTRO_ACCESO_PG.GA_REGISTRA_ACCESO_USUARIO_FN( LT_trzusr, LV_sqlcode, LV_des_error ) THEN
           SN_cod_retorno := 4;
           RAISE ERR_REGISTRAR;
        END IF;
     END IF;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
    WHEN ERR_REGISTRAR THEN
        SV_mens_retorno := 'Error en ejecución PL-SQL pv_graba_traza_usr_pr.';
        SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
        'pv_graba_traza_usr_pr', sSql, LV_sqlcode, LV_des_error );
    WHEN OTHERS THEN
             SN_cod_retorno := 5;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_graba_traza_usr_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_graba_traza_usr_pr', sSql, SQLCODE, LV_des_error );
END pv_graba_traza_usr_pr;

PROCEDURE pv_cons_seg_grupo_pr(EV_nom_usuario            ge_seg_grpusuario.nom_usuario%TYPE,
                                 SC_grupos                 OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento

 )
IS

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;
ln_num_version number;
BEGIN
    SELECT MAX(F.NUM_VERSION)
    INTO LN_num_version
    FROM GE_PROGRAMAS F
    WHERE F.COD_PROGRAMA = GV_cod_pragrama;

--     OPEN SC_grupos FOR
--     SELECT a.cod_grupo, b.des_grupo
--     FROM ge_seg_grpusuario a, ge_seg_grupo b
--     WHERE a.nom_usuario = EV_nom_usuario
--     AND a.cod_grupo = b.cod_grupo;

    OPEN SC_grupos FOR
    SELECT a.cod_grupo, b.des_grupo
    FROM ge_seg_grpusuario a, ge_seg_grupo b
    WHERE a.nom_usuario = EV_nom_usuario
    AND a.cod_grupo = b.cod_grupo
    AND A.COD_GRUPO IN (
    SELECT  DISTINCT P.COD_GRUPO
    FROM GE_SEG_PERFILES P
    WHERE P.COD_PROGRAMA = GV_cod_pragrama
    AND P.NUM_VERSION = LN_num_version );

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
    WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_seg_grupo_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_seg_grupo_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_seg_grupo_pr;

PROCEDURE pv_cons_perfil_segur_pr(EV_cod_grupo       ge_seg_perfiles.cod_grupo%TYPE,
                                  EV_cod_programa       ge_seg_perfiles.cod_programa%TYPE,
                                EN_num_version       ge_seg_perfiles.num_version%TYPE,
                                  SC_perfil           OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento
                                  )
IS

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

    OPEN SC_perfil FOR
    SELECT a.cod_proceso, b.des_proceso
    FROM ge_seg_perfiles a, ge_seg_procesos b
    WHERE a.cod_proceso = b.cod_proceso
    AND a.cod_grupo = EV_cod_grupo
    AND a.cod_programa = EV_cod_programa
    AND a.num_version = EN_num_version;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
    WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_perfil_segur_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_perfil_segur_pr', sSql, SQLCODE, LV_des_error );

END pv_cons_perfil_segur_pr;

PROCEDURE pv_valida_verfactura_pr(EN_cod_cliente       ge_clientes.cod_cliente%TYPE,
                                  EN_ind_ordentotal         fa_histdocu.num_secuenci%TYPE,
                                SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento           OUT NOCOPY ge_errores_pg.evento
                                  )

IS

LN_valor                         NUMBER(1);
LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

     SELECT 1 INTO LN_valor FROM fa_histdocu
     WHERE cod_cliente = EN_cod_cliente
     AND ind_ordentotal = EN_ind_ordentotal;

     SN_cod_retorno := 0;
     SV_mens_retorno := 'Código de cliente ' || EN_cod_cliente || ' válido. ' ;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
             SN_cod_retorno := 1;
             SV_mens_retorno := 'Código de cliente ' || EN_cod_cliente || ' inválido. ' ;
    WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_valida_verfactura_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_valida_verfactura_pr', sSql, SQLCODE, LV_des_error );
END pv_valida_verfactura_pr;













------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_TIPO_SUSPENSION_PR(
    SC_BLOQ_TIP_SUSP              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_X_COD_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cuenta</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    --LV_des_error          ge_errores_pg.desevent;
    --LV_sSql               ge_errores_pg.vQuery;

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    SN_cod_retorno  := 0;

       BEGIN
             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
          SN_num_evento := 0;
              OPEN SC_BLOQ_TIP_SUSP     FOR
                   SELECT a.cod_valor, a.des_valor
                        FROM ged_codigos a
                        WHERE a.cod_modulo = 'GA' AND
                        a.nom_tabla = 'GA_SINIESTROS' AND
                        a.nom_columna = 'TIP_SUSPENSION'
                        ORDER BY DES_VALOR ASC;
       END;

END PV_CONS_TIPO_SUSPENSION_PR;
------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_TIPO_SINIESTRO_PR(
    SC_BLOQ_TIP_SINI              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_X_COD_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cuenta</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    --LV_des_error          ge_errores_pg.desevent;
    --LV_sSql               ge_errores_pg.vQuery;

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    SN_cod_retorno  := 0;

       BEGIN
             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
          SN_num_evento := 0;
              OPEN SC_BLOQ_TIP_SINI      FOR
                   SELECT a.cod_valor, a.des_valor
                        FROM ged_codigos a
                        WHERE a.cod_modulo = 'GA'
                        AND
                        a.nom_tabla = 'GA_SINIESTROS' AND
                        a.nom_columna = 'TIP_SINIESTRO'
                        ORDER BY DES_VALOR ASC;
       END;

END PV_CONS_TIPO_SINIESTRO_PR;
------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------
PROCEDURE PV_CONS_CAUSA_SINIESTRO_PR(
    SC_BLOQ_CAU_SINI              OUT NOCOPY REFCURSOR,
    SN_COD_RETORNO               OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO              OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO                OUT NOCOPY GE_ERRORES_PG.EVENTO
  )
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CONS_GRILLA_X_COD_CUENTA_PR"
      Lenguaje="PL/SQL"
      Fecha="01-12-2008"
      Versión="1.0"
      Diseñador=""
      Programador="""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Consulta para generar la grilla en el front or cod_cuenta</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EN_COD_CUENTA" Tipo="Number">Codigo del CUENTA/param>
            <>
         </Entrada>
         <Salida>
           <param nom="SC_BLOQ_CUENTA   Tipo="Cursor>ursor con datos del clienteparam>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    --LV_des_error          ge_errores_pg.desevent;
    --LV_sSql               ge_errores_pg.vQuery;

    ERROR_CONTROLADO      EXCEPTION;

BEGIN
    SN_cod_retorno  := 0;

       BEGIN
             SN_cod_retorno := 0;
             SV_mens_retorno := 'OK';
          SN_num_evento := 0;
              OPEN SC_BLOQ_CAU_SINI
          FOR
                SELECT cod_causa, des_causa FROM GA_CAUSINIE
                WHERE cod_modulo = 'PV'
                ORDER BY des_causa ASC;
       END;

END PV_CONS_CAUSA_SINIESTRO_PR;
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_obtiene_ooss_agendadas_pr(en_num_dato          NUMBER,
                                         en_tip_dato          NUMBER,
                                       sc_ooss_agendada     OUT NOCOPY refcursor,
                                       sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                       sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                       sn_cod_resultado        OUT NOCOPY NUMBER
)

IS

ln_valor               NUMBER(1);
ln_cantidad           NUMBER;
error_controlado      EXCEPTION;

BEGIN

     sn_cod_retorno     := 0;
     sv_mens_retorno    := 'OK';
    sn_cod_resultado   := 0;

    IF en_tip_dato = 1 THEN

        SELECT count(1)
        INTO   ln_cantidad
        FROM   pv_iorserv a, pv_erecorrido b, pv_camcom c, fa_intqueueproc d, fa_intprocesos e, ci_tiporserv f
        WHERE  a.FH_EJECUCION > SYSDATE -- Se agrega 17/10/2010
        AND    a.num_os = b.num_os
        AND    a.cod_estado = b.cod_estado
        AND    a.num_os = c.num_os
        --AND    b.tip_estado not in (4,5) -- Se modifica valores original(3,4,5)
        AND    a.cod_modgener = d.cod_modgener
        AND    d.cod_proceso = e.cod_proceso
        AND    e.cod_aplic = GV_cod_aplicacion
        AND    c.cod_cliente = en_num_dato
        AND    a.cod_os = f.cod_os
        AND    f.grupo = '8'; --Grupo cliente


        IF ln_cantidad = 0 THEN
            sn_cod_resultado   := 1;
            RAISE error_controlado;
        END IF;
        OPEN sc_ooss_agendada FOR
            SELECT a.num_os, a.descripcion, a.cod_estado, TO_CHAR(a.fecha_ing,'DD-MM-YYYY hh24:mi:ss'), TO_CHAR(a.fh_ejecucion,'DD-MM-YYYY hh24:mi:ss'),
                   a.usuario, a.comentario, b.descripcion, a.status, e.des_proceso
            FROM   pv_iorserv a, pv_erecorrido b, pv_camcom c, fa_intqueueproc d, fa_intprocesos e, ci_tiporserv f
            WHERE  a.FH_EJECUCION > SYSDATE -- Se agrega 17/10/2010
            AND    a.num_os = b.num_os
            AND    a.cod_estado = b.cod_estado
            AND    a.num_os = c.num_os
            --AND    b.tip_estado not in (4,5) -- Se modifica valores original(3,4,5)
            AND    a.cod_modgener = d.cod_modgener
            AND    d.cod_proceso = e.cod_proceso
            AND    e.cod_aplic = GV_cod_aplicacion
            AND    c.cod_cliente = en_num_dato
            AND    a.cod_os = f.cod_os
            AND    f.grupo = '8'; --Grupo cliente

    END IF;

    IF en_tip_dato = 2 THEN

        SELECT count(1)
        INTO   ln_cantidad
        FROM   pv_iorserv a, pv_erecorrido b, pv_camcom c, fa_intqueueproc d, fa_intprocesos e, ci_tiporserv f
        WHERE  a.FH_EJECUCION > SYSDATE -- Se agrega 17/10/2010
        AND    a.num_os = b.num_os
        AND    a.cod_estado = b.cod_estado
        AND    a.num_os = c.num_os
        --AND    b.tip_estado not in (4,5) -- Se modifica valores original(3,4,5)
        AND    a.cod_modgener = d.cod_modgener
        AND    d.cod_proceso = e.cod_proceso
        AND    e.cod_aplic = GV_cod_aplicacion
        AND    c.num_abonado = en_num_dato
        AND    a.cod_os = f.cod_os
        AND    f.grupo = '1'; --Grupo Abonado

        IF ln_cantidad = 0 THEN
            sn_cod_resultado   := 1;
            RAISE error_controlado;
        END IF;

        OPEN sc_ooss_agendada FOR
            SELECT a.num_os, a.descripcion, a.cod_estado, TO_CHAR(a.fecha_ing,'DD-MM-YYYY hh24:mi:ss'), TO_CHAR(a.fh_ejecucion,'DD-MM-YYYY hh24:mi:ss'),
                   a.usuario, a.comentario, b.descripcion, a.status, e.des_proceso
            FROM   pv_iorserv a, pv_erecorrido b, pv_camcom c, fa_intqueueproc d, fa_intprocesos e, ci_tiporserv f
            WHERE  a.FH_EJECUCION > SYSDATE -- Se agrega 17/10/2010
            AND    a.num_os = b.num_os
            AND    a.cod_estado = b.cod_estado
            AND    a.num_os = c.num_os
            --AND    b.tip_estado not in (4,5) -- Se modifica valores original(3,4,5)
            AND    a.cod_modgener = d.cod_modgener
            AND    d.cod_proceso = e.cod_proceso
            AND    e.cod_aplic = GV_cod_aplicacion
            AND    c.num_abonado = en_num_dato
            AND    a.cod_os = f.cod_os
            AND    f.grupo = '1'; --Grupo Abonado

    END IF;

    IF en_tip_dato = 3 THEN

        SELECT count(1)
        INTO   ln_cantidad
        FROM   pv_iorserv a, pv_erecorrido b, pv_camcom c, fa_intqueueproc d, fa_intprocesos e, ci_tiporserv f
        WHERE  a.FH_EJECUCION > SYSDATE -- Se agrega 17/10/2010
        AND    a.num_os = b.num_os
        AND    a.cod_estado = b.cod_estado
        AND    a.num_os = c.num_os
        --AND    b.tip_estado not in (4,5) -- Se modifica valores original(3,4,5)
        AND    a.cod_modgener = d.cod_modgener
        AND    d.cod_proceso = e.cod_proceso
        AND    e.cod_aplic = GV_cod_aplicacion
        AND    c.cod_cuenta = en_num_dato
        AND    a.cod_os = f.cod_os
        AND    f.grupo = '5'; --Grupo cuenta

        IF ln_cantidad = 0 THEN
            sn_cod_resultado   := 1;
            RAISE error_controlado;
        END IF;

        OPEN sc_ooss_agendada FOR
            SELECT a.num_os, a.descripcion, a.cod_estado, TO_CHAR(a.fecha_ing,'DD-MM-YYYY hh24:mi:ss'), TO_CHAR(a.fh_ejecucion,'DD-MM-YYYY hh24:mi:ss'),
                   a.usuario, a.comentario, b.descripcion, a.status, e.des_proceso
            FROM   pv_iorserv a, pv_erecorrido b, pv_camcom c, fa_intqueueproc d, fa_intprocesos e, ci_tiporserv f
            WHERE  a.FH_EJECUCION > SYSDATE -- Se agrega 17/10/2010
            AND    a.num_os = b.num_os
            AND    a.cod_estado = b.cod_estado
            AND    a.num_os = c.num_os
            --AND    b.tip_estado not in (4,5) -- Se modifica valores original(3,4,5)
            AND    a.cod_modgener = d.cod_modgener
            AND    d.cod_proceso = e.cod_proceso
            AND    e.cod_aplic = GV_cod_aplicacion
            AND    c.cod_cuenta = en_num_dato
            AND    a.cod_os = f.cod_os
            AND    f.grupo = '5'; --Grupo cuenta

    END IF;

EXCEPTION
    WHEN error_controlado  THEN
             sn_cod_retorno  := 3;
             sv_mens_retorno := 'No se encontró información';

    WHEN OTHERS THEN
             sn_cod_retorno  := 4;
             sv_mens_retorno := 'Ocurrió un error al intentar obtener la información';
            sn_cod_resultado:= 1;
END pv_obtiene_ooss_agendadas_pr;

------------------------------------------------------------------------------------------------------------
PROCEDURE pv_cons_ooss_proceso_pr(ev_nom_usuario     IN  pv_iorserv.usuario%TYPE,
                                  sn_cod_resultado   OUT NOCOPY NUMBER
)
IS

ln_ooss NUMBER;

BEGIN
    ln_ooss := 0;
    sn_cod_resultado := 0;

    SELECT  COUNT(1)
    INTO    ln_ooss
        FROM   pv_iorserv i, pv_erecorrido r
        WHERE  i.usuario = ev_nom_usuario
        AND    NVL(i.FH_EJECUCION,SYSDATE) <= SYSDATE
        AND    i.cod_estado >= 10
        AND    i.cod_estado <= 999
        AND    r.cod_estado = i.cod_estado
        AND    r.num_os = i.num_os;

    IF ln_ooss = 0 THEN
        sn_cod_resultado := 1;
    END IF;

END pv_cons_ooss_proceso_pr;

------------------------------------------------------------------------------------------------------------
PROCEDURE pv_obtiene_ooss_proceso_pr(ev_nom_usuario   IN  pv_iorserv.usuario%TYPE,
                                     sc_ooss_proceso  OUT NOCOPY refcursor
)
IS

BEGIN
    /*
    OPEN sc_ooss_proceso FOR
         SELECT i.num_os, i.cod_os, i.descripcion, r.tip_estado, r.descripcion,
               TO_CHAR(i.fecha_ing,'DD-MM-YYYY hh24:mi:ss'), i.status, i.comentario
        FROM   pv_iorserv i, pv_erecorrido r
        WHERE  i.usuario = ev_nom_usuario
        AND    NVL(i.FH_EJECUCION,SYSDATE) <= SYSDATE
        AND    i.cod_estado >= 10
        AND    i.cod_estado <= 999
        AND    r.cod_estado = i.cod_estado
        AND    r.num_os = i.num_os;
        */
        
        OPEN sc_ooss_proceso FOR
         SELECT i.num_os, i.cod_os, i.descripcion, r.cod_estado, r.descripcion,
               TO_CHAR(i.fecha_ing,'DD-MM-YYYY hh24:mi:ss'), i.status, i.comentario
        FROM   pv_iorserv i, pv_erecorrido r
        WHERE  i.usuario = ev_nom_usuario
        AND    NVL(i.FH_EJECUCION,SYSDATE) <= SYSDATE
        AND    i.cod_estado >= 10
        AND    i.cod_estado <= 999
        AND    r.cod_estado = i.cod_estado
        AND    r.num_os = i.num_os;
        
        
END pv_obtiene_ooss_proceso_pr;

------------------------------------------------------------------------------------------------------------
PROCEDURE pv_obtiene_ss_por_ooss_pr (en_num_os          IN pv_camcom.num_os%TYPE,
                                     sc_ss_ooss         OUT NOCOPY refcursor,
                                     sn_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento      OUT NOCOPY ge_errores_pg.evento
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_obtiene_ss_por_ooss_pr"
      Lenguaje="PL/SQL"
      Fecha creación="03-08-2010"
      Creado por="Jorge González"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Consulta SS por numero de OOSS
      </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_os" Tipo="NUMBER">
            </param>
         </Entrada>
         <Salida>
            <param nom="sc_ss_ooss       Tipo="CURSOR">cursor con datos</param>
            <param nom="sn_cod_retorno"  Tipo="NUMBER">codigo de Error</param>
            <param nom="sv_mens_retorno" Tipo="VARCHAR2">mensaje de error</param>
            <param nom="sn_num_evento"   Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

lv_ssactivados      pv_camcom.clase_servicio_act%TYPE;
lv_ssdesactivados   pv_camcom.clase_servicio_des%TYPE;
lv_des_error        ge_errores_pg.desevent;
ssql                ge_errores_pg.vquery;
ln_cantidadssact    NUMBER;
ln_cantidadssdes    NUMBER;
ln_ss               NUMBER;
ln_cuenta1          NUMBER;
ln_cuenta2          NUMBER;
ln_cuenta3          NUMBER;
ln_num_ooss         pv_iorserv.num_os%TYPE;
lv_des_ss           ga_servsupl.des_servicio%TYPE;
lv_ssact            pv_camcom.clase_servicio_act%TYPE;
lv_ssdes            pv_camcom.clase_servicio_des%TYPE;
ln_cod_ss           ga_servsupl.cod_servsupl%TYPE;
ln_codserv_ss       ga_servsupl.cod_servicio%TYPE;
ln_cod_nvl          ga_servsupl.cod_nivel%TYPE;
Lt_Data             PV_SS_OOSS_OT:= PV_SS_OOSS_OT();
i                   PLS_INTEGER:=0;
error_controlado    EXCEPTION;
error_controlado2   EXCEPTION;


BEGIN
    sn_cod_retorno     := 0;
    sv_mens_retorno    := 'OK';
    sn_num_evento      := 0;
    ln_ss              := 1;

/*
    ssql := 'SELECT pc.clase_servicio_act,LENGTH(pc.clase_servicio_act),pc.clase_servicio_des,LENGTH(pc.clase_servicio_des) '
          ||'FROM   pv_iorserv pi, pv_camcom pc , ci_tiporserv ct '
          ||'WHERE  pi.num_os = pc.num_os '
          ||'AND    pi.cod_os = ct.cod_os '
          ||'AND    pc.num_os = '||en_num_os||' '
          ||'AND    pi.cod_os IN (10120,10760) '
          ||'UNION '
          ||'SELECT phc.clase_servicio_act,LENGTH(phc.clase_servicio_act),phc.clase_servicio_des,LENGTH(phc.clase_servicio_des) '
          ||'FROM   pvh_iorserv phi, pvh_camcom phc , ci_tiporserv ct '
          ||'WHERE  phi.num_os = phc.num_os '
          ||'AND    phi.cod_os = ct.cod_os '
          ||'AND    phc.num_os = '||en_num_os||' '
          ||'AND    phi.cod_os IN (10120,10760)';

*/
     
        /*
        SELECT COUNT (0) --pc.clase_servicio_act,LENGTH(pc.clase_servicio_act),pc.clase_servicio_des,LENGTH(pc.clase_servicio_des)
        INTO   ln_cuenta1 --lv_ssactivados,ln_cantidadssact,lv_ssdesactivados,ln_cantidadssdes
        FROM   pv_iorserv pi, pv_camcom pc , ci_tiporserv ct
        WHERE  pi.num_os = pc.num_os
        AND    pi.cod_os = ct.cod_os
        AND    pc.num_os = en_num_os
        AND    pi.cod_os NOT IN (10120,10760);
        
        SELECT COUNT (0)--phc.clase_servicio_act,LENGTH(phc.clase_servicio_act),phc.clase_servicio_des,LENGTH(phc.clase_servicio_des)
        INTO   ln_cuenta2 
        FROM   pvh_iorserv phi, pvh_camcom phc , ci_tiporserv ct
        WHERE  phi.num_os = phc.num_os
        AND    phi.cod_os = ct.cod_os
        AND    phc.num_os = en_num_os
        AND    phi.cod_os NOT IN (10120,10760);
    */
    
        SELECT COUNT (*)
        INTO ln_cuenta1
        FROM CI_ORSERV a
        WHERE  a.num_os = en_num_os
        AND    a.cod_os NOT IN (10120,10760);
       
        SELECT COUNT (*)
        INTO ln_cuenta2
        FROM pv_iorserv b
        WHERE  b.num_os = en_num_os
        AND    b.cod_os NOT IN (10120,10760);
       
        SELECT COUNT (*)
        INTO ln_cuenta3
        FROM pvh_iorserv c
        WHERE  c.num_os = en_num_os
        AND    c.cod_os NOT IN (10120,10760);
    
        IF (ln_cuenta1 + ln_cuenta2 + ln_cuenta3) > 0 THEN 
            OPEN sc_ss_ooss FOR
            SELECT COD_SERVSUPL,
                   DES_SERVICIO,
                   TIPO_ACCION
            FROM   TABLE (CAST (Lt_Data AS PV_SS_OOSS_OT));
            
            RAISE error_controlado;
        ELSE
            BEGIN
                
                SELECT pc.clase_servicio_act,LENGTH(pc.clase_servicio_act),pc.clase_servicio_des,LENGTH(pc.clase_servicio_des)
                INTO   lv_ssactivados,ln_cantidadssact,lv_ssdesactivados,ln_cantidadssdes
                FROM   pv_iorserv pi, pv_camcom pc , ci_tiporserv ct
                WHERE  pi.num_os = pc.num_os
                AND    pi.cod_os = ct.cod_os
                AND    pc.num_os = en_num_os
                AND    pi.cod_os IN (10120,10760)
                UNION   
                SELECT phc.clase_servicio_act,LENGTH(phc.clase_servicio_act),phc.clase_servicio_des,LENGTH(phc.clase_servicio_des)
                FROM   pvh_iorserv phi, pvh_camcom phc , ci_tiporserv ct
                WHERE  phi.num_os = phc.num_os
                AND    phi.cod_os = ct.cod_os
                AND    phc.num_os = en_num_os
                AND    phi.cod_os IN (10120,10760);
                
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    OPEN sc_ss_ooss FOR
                        SELECT COD_SERVSUPL,
                               DES_SERVICIO,
                               TIPO_ACCION
                        FROM   TABLE (CAST (Lt_Data AS PV_SS_OOSS_OT));
                    RAISE  error_controlado2;
            END;
        END IF ;
      
    --SS ACTIVADOS

    IF ln_cantidadssact IS NOT NULL THEN

        IF ln_cantidadssact >= 6 THEN

            WHILE ln_ss <= ln_cantidadssact LOOP

                ssql := 'select SUBSTR(pc.clase_servicio_act,ln_ss,6)'
                      ||'from   pv_camcom pc '
                      ||'where  pc.num_os = '||en_num_os||'';

                SELECT SUBSTR(pc.clase_servicio_act,ln_ss,6)
                INTO   lv_ssact
                FROM   pv_camcom pc
                WHERE  pc.num_os = en_num_os
                UNION
                SELECT SUBSTR(phc.clase_servicio_act,ln_ss,6)
                FROM   pvh_camcom phc
                WHERE  phc.num_os = en_num_os;

                ssql := 'select to_number(SUBSTR(lv_ssact,1,2)) from dual';

                SELECT TO_NUMBER(SUBSTR(lv_ssact,1,2)) INTO ln_cod_ss FROM dual;

                ssql := 'select to_number(SUBSTR(lv_ssact,5,2)) from dual';

                SELECT TO_NUMBER(SUBSTR(lv_ssact,5,2)) INTO ln_cod_nvl FROM dual;

                ssql := 'select gs.des_servicio '
                      ||'from   ga_servsupl gs '
                      ||'where  gs.cod_servsupl = '||ln_cod_ss||' '
                      ||'and    gs.cod_nivel = '||ln_cod_nvl||'';

                SELECT gs.cod_servicio, gs.des_servicio
                INTO   ln_codserv_ss,lv_des_ss
                FROM   ga_servsupl gs
                WHERE  gs.cod_servsupl = ln_cod_ss
                AND    gs.cod_nivel = ln_cod_nvl;

                i:= i + 1;

                Lt_Data.EXTEND;

                Lt_Data (i) := PV_SS_OOSS_QT(NULL, NULL, NULL);

                Lt_Data (lt_data.LAST).cod_servsupl := ln_codserv_ss;
                Lt_Data (lt_data.LAST).des_servicio := lv_des_ss;
                Lt_Data (lt_data.LAST).tipo_accion  := 'ACTIVADO';

                ln_ss := ln_ss + 6;

            END LOOP;

        END IF;

    END IF;

    --SS DESACTIVADOS

    ln_ss := 1;

     IF ln_cantidadssdes IS NOT NULL THEN

        IF ln_cantidadssdes >= 6 THEN

            WHILE ln_ss <= ln_cantidadssdes LOOP

                ssql := 'select SUBSTR(pc.clase_servicio_des,ln_ss,6)'
                      ||'from   pv_camcom pc '
                      ||'where  pc.num_os = '||en_num_os||'';

                SELECT SUBSTR(pc.clase_servicio_des,ln_ss,6)
                INTO   lv_ssdes
                FROM   pv_camcom pc
                WHERE  pc.num_os = en_num_os
                UNION
                SELECT SUBSTR(phc.clase_servicio_des,ln_ss,6)
                FROM   pvh_camcom phc
                WHERE  phc.num_os = en_num_os;

                ssql := 'select to_number(SUBSTR(lv_ssdes,1,2)) from dual';

                SELECT TO_NUMBER(SUBSTR(lv_ssdes,1,2)) INTO ln_cod_ss FROM dual;

                ssql := 'select to_number(SUBSTR(lv_ssdes,5,2)) from dual';

                SELECT TO_NUMBER(SUBSTR(lv_ssdes,5,2)) INTO ln_cod_nvl FROM dual;

                ssql := 'select gs.des_servicio '
                      ||'from   ga_servsupl gs '
                      ||'where  gs.cod_servsupl = '||ln_cod_ss||' '
                      ||'and    gs.cod_nivel = '||ln_cod_nvl||'';

                SELECT gs.cod_servicio, gs.des_servicio
                INTO   ln_codserv_ss,lv_des_ss
                FROM   ga_servsupl gs
                WHERE  gs.cod_servsupl = ln_cod_ss
                AND    gs.cod_nivel = ln_cod_nvl;


                i:= i + 1;

                Lt_Data.EXTEND;

                Lt_Data (i) := PV_SS_OOSS_QT(NULL, NULL, NULL);

                Lt_Data (lt_data.LAST).cod_servsupl := ln_codserv_ss;
                Lt_Data (lt_data.LAST).des_servicio := lv_des_ss;
                Lt_Data (lt_data.LAST).tipo_accion  := 'DESACTIVADO';

                ln_ss := ln_ss + 6;

            END LOOP;

        END IF;

    END IF;


    OPEN sc_ss_ooss FOR
       SELECT COD_SERVSUPL,
              DES_SERVICIO,
              TIPO_ACCION
       FROM   TABLE (CAST (Lt_Data AS PV_SS_OOSS_OT));


EXCEPTION
    WHEN error_controlado  THEN
             sn_cod_retorno  := 3;
             sv_mens_retorno := 'Esta OOSS no corresponde a una OOSS de Activación/Desactivación de SS (OOSS 10120 ó OOSS 10760)' ;
             lv_des_error    := SQLERRM;
             sn_num_evento   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'pv_obtiene_ss_por_ooss_pr', ssql, SQLCODE, lv_des_error );
    WHEN error_controlado2  THEN
             sn_cod_retorno  := 1;
             sv_mens_retorno := 'No existe información para la Orden de servicio' ;
             --sv_mens_retorno := 'Esta OOSS no corresponde a una OOSS de Activación/Desactivación de SS (OOSS 10120 ó OOSS 10760)' ;
             lv_des_error    := SQLERRM;
             sn_num_evento   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'pv_obtiene_ss_por_ooss_pr', ssql, SQLCODE, lv_des_error );         
    WHEN NO_DATA_FOUND THEN
    
             OPEN sc_ss_ooss FOR
             SELECT COD_SERVSUPL,
                    DES_SERVICIO,
                    TIPO_ACCION
             FROM   TABLE (CAST (Lt_Data AS PV_SS_OOSS_OT));
    
             sn_cod_retorno  := 1;
             sv_mens_retorno := 'No existe información para la Orden de servicio' ;
             --sv_mens_retorno := 'Esta OOSS no corresponde a una OOSS de Activación/Desactivación de SS (OOSS 10120 ó OOSS 10760)' ;
             lv_des_error    := SQLERRM;
             sn_num_evento   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'pv_obtiene_ss_por_ooss_pr', ssql, SQLCODE, lv_des_error );
    WHEN OTHERS THEN
    
            OPEN sc_ss_ooss FOR
             SELECT COD_SERVSUPL,
                    DES_SERVICIO,
                    TIPO_ACCION
             FROM   TABLE (CAST (Lt_Data AS PV_SS_OOSS_OT));
             
             sn_cod_retorno  := 4;
             sv_mens_retorno := 'Error en ejecución PL-SQL pv_obtiene_ss_por_ooss_pr.';
            lv_des_error    := SQLERRM;
            sn_num_evento   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'pv_obtiene_ss_por_ooss_pr', ssql, SQLCODE, lv_des_error );
END pv_obtiene_ss_por_ooss_pr;
------------------------------------------------------------------------------------------------------------
PROCEDURE pv_inserta_comentario_pr( EV_comentario           CI_ORSERV.COMENTARIO%TYPE,
                                    EN_num_os               CI_ORSERV.NUM_OS%TYPE,
                                    SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento           OUT NOCOPY ge_errores_pg.evento
                                    )

IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_inserta_comentario_pr"
      Lenguaje="PL/SQL"
      Fecha="05-08-2010"
      Versión="1.0"
      Diseñador="Gabriel Moraga L."
      Programador="Gabriel Moraga L."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Inserta el comentario de una orden de servicio</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EV_comentario" Tipo="VARCHAR2">Comentario relacionado</param>
          <param nom="EN_num_os" Tipo="NUMBER">Numero de Orden de servicio</param>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

    ssql := ' UPDATE CI_ORSERV '
          ||' SET COMENTARIO = '||EV_comentario||' '
          ||' WHERE NUM_OS = '||EN_num_os||' ';

    UPDATE CI_ORSERV
    SET COMENTARIO = EV_comentario
    WHERE NUM_OS = EN_num_os;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK' ;

EXCEPTION
    WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_inserta_comentario_pr';
             LV_des_error := SQLERRM;
             SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
             'pv_inserta_comentario_pr', sSql, SQLCODE, LV_des_error );

END pv_inserta_comentario_pr;

------------------------------------------------------------------------------------------------------------

PROCEDURE pv_insert_pv_iorserv_pr( EV_comentario           PV_IORSERV.COMENTARIO%TYPE,
                                               EN_num_os               PV_IORSERV.NUM_OS%TYPE,
                                               SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                               SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                               SN_num_evento           OUT NOCOPY ge_errores_pg.evento
                                               )

IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "pv_inserta_comentario_pv_iorserv_pr"
      Lenguaje="PL/SQL"
      Fecha="13-08-2010"
      Versión="1.0"
      Diseñador="Gabriel Moraga L."
      Programador="Gabriel Moraga L."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Inserta el comentario de una orden de servicio</Descripción>
      <Parámetros>
         <Entrada>
          <param nom="EV_comentario" Tipo="VARCHAR2">Comentario relacionado</param>
          <param nom="EN_num_os" Tipo="NUMBER">Numero de Orden de servicio</param>
         </Entrada>
         <Salida>
           <param nom="SN_COD_RETORNO" Tipo="Number">Codigo de Retorno</param>
            <param nom="SV_MENS_RETORNO Tipo="Varchar2">Mensaje de Retorno</param>
            <param nom="SN_NUM_EVENTO Tipo="Number>Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;

BEGIN

    ssql := ' UPDATE PV_IORSERV '
          ||' SET COMENTARIO = '||EV_comentario||' '
          ||' WHERE NUM_OS = '||EN_num_os||' ';

    UPDATE PV_IORSERV
    SET COMENTARIO = EV_comentario
    WHERE NUM_OS = EN_num_os;

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK' ;

EXCEPTION
    WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_inserta_comentario_pv_iorserv_pr';
             LV_des_error := SQLERRM;
             SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
             'pv_inserta_comentario_pv_iorserv_pr', sSql, SQLCODE, LV_des_error );

END pv_insert_pv_iorserv_pr;

------------------------------------------------------------------------------------------------------------


--KVV 09-11-2010 RA-MIX-10008
PROCEDURE pv_cons_seg_grupo_pr(EV_nom_usuario            ge_seg_grpusuario.nom_usuario%TYPE,
                                EV_COD_PROGRAMA           GE_PROGRAMAS.COD_PROGRAMA%TYPE,
                                SC_grupos                 OUT NOCOPY REFCURSOR,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento

 )
IS

LV_des_error                        ge_errores_pg.DesEvent;
sSql                                ge_errores_pg.vQuery;
ln_num_version number;
BEGIN
    SELECT MAX(F.NUM_VERSION)
    INTO LN_num_version
    FROM GE_PROGRAMAS F
    WHERE F.COD_PROGRAMA = EV_COD_PROGRAMA;

--     OPEN SC_grupos FOR
--     SELECT a.cod_grupo, b.des_grupo
--     FROM ge_seg_grpusuario a, ge_seg_grupo b
--     WHERE a.nom_usuario = EV_nom_usuario
--     AND a.cod_grupo = b.cod_grupo;

    OPEN SC_grupos FOR
    SELECT a.cod_grupo, b.des_grupo
    FROM ge_seg_grpusuario a, ge_seg_grupo b
    WHERE a.nom_usuario = EV_nom_usuario
    AND a.cod_grupo = b.cod_grupo
    AND A.COD_GRUPO IN (
    SELECT  DISTINCT P.COD_GRUPO
    FROM GE_SEG_PERFILES P
    WHERE P.COD_PROGRAMA = EV_COD_PROGRAMA
    AND P.NUM_VERSION = LN_num_version );

    SN_cod_retorno := 0;
    SV_mens_retorno := 'OK';
    SN_num_evento := 0;

EXCEPTION
    WHEN OTHERS THEN
             SN_cod_retorno := 4;
             SV_mens_retorno := 'Error en ejecución PL-SQL pv_cons_seg_grupo_pr.';
            LV_des_error := SQLERRM;
            SN_num_evento:= Ge_Errores_Pg.Grabarpl(0, 'PV', SV_mens_retorno, '1.0', USER,
            'pv_cons_seg_grupo_pr', sSql, SQLCODE, LV_des_error );
END pv_cons_seg_grupo_pr;

PROCEDURE pv_obtiene_dominio_pr(EV_cod_ooss      GED_PARAMETROS.NOM_PARAMETRO%TYPE,
                                SV_dominio_ooss  OUT GED_PARAMETROS.VAL_PARAMETRO%TYPE,
                                SN_cod_retorno   OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY ge_errores_pg.evento

 )
IS

LN_count NUMBER := 0;
LV_aux_dominio  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
lv_des_error VARCHAR2 (300);
lv_ssql VARCHAR2 (1000);
lv_procedure VARCHAR2 (50) := 'pv_obtiene_dominio_pr';


BEGIN
 sn_cod_retorno := 0;
 sv_mens_retorno := 'OK';
 sn_num_evento := 0; 
    
 LV_aux_dominio := 'DOMINIO_'||EV_cod_ooss; 
    
 SELECT   count(1) INTO LN_count 
  FROM   ged_parametros
 WHERE   nom_parametro = LV_aux_dominio 
   AND   cod_modulo =  gv_cod_modulo
   AND   cod_producto = GV_COD_PRODUCTO;
 
    lv_ssql := 'SELECT   val_parametro
                  FROM   ged_parametros
                 WHERE   nom_parametro = '|| LV_aux_dominio;
    lv_ssql := lv_ssql || ' AND   cod_mudulo = ' || gv_cod_modulo; 
    lv_ssql := lv_ssql || ' AND   cod_producto = ' || GV_COD_PRODUCTO;

IF LN_count > 0 THEN
    SELECT   val_parametro INTO SV_dominio_ooss 
      FROM   ged_parametros
     WHERE   nom_parametro = LV_aux_dominio 
       AND   cod_modulo =  gv_cod_modulo
       AND   cod_producto = GV_COD_PRODUCTO;
ELSE 
    SV_dominio_ooss := NULL;
END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    sn_cod_retorno := 890069;
    IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := gv_error_no_clasif;
    END IF;
    lv_des_error := gv_package || lv_procedure || '(''); ' || SQLERRM;
    sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, gv_cod_modulo, sv_mens_retorno, '1.0', USER,
                                            lv_procedure, lv_ssql, sn_cod_retorno, lv_des_error);
    WHEN OTHERS THEN
    SN_cod_retorno := 4;
    IF NOT ge_errores_pg.mensajeerror (sn_cod_retorno, sv_mens_retorno) THEN
        sv_mens_retorno := gv_error_no_clasif;
    END IF;
    LV_des_error := gv_package || lv_procedure || '(''); ' || SQLERRM;
    SN_num_evento:= Ge_Errores_Pg.Grabarpl(sn_num_evento, gv_cod_modulo, SV_mens_retorno, '1.0', USER,
                                           lv_procedure, lv_ssql, SQLCODE, LV_des_error );
END pv_obtiene_dominio_pr;

------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_CAMPOS_DIR_PR ( SC_CAMPOS_DIR      OUT NOCOPY REFCURSOR,
                                     SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                     SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                     SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_CAMPOS_DIR_PR"
      Lenguaje="PL/SQL"
      Fecha creación="07-06-2011"
      Creado por="Everis"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Obtiene campos de direcciones segun operadora
      </Descripción>
      <Parámetros>
         <Entrada>
            
         </Entrada>
         <Salida>
            <param nom="SC_CAMPOS_DIR   Tipo="CURSOR">cursor con datos</param>
            <param nom="SN_COD_RETORNO"  Tipo="NUMBER">codigo de Error</param>
            <param nom="SV_MENS_RETORNO" Tipo="VARCHAR2">mensaje de error</param>
            <param nom="SN_NUM_EVENTO"   Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DES_ERROR        VARCHAR2 (300);
SSQL                GE_ERRORES_PG.VQUERY;
COD_OPERADORA_SCL   GE_OPERADORA_SCL.COD_OPERADORA_SCL%TYPE;

BEGIN
    
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO    := 'OK';
    SN_NUM_EVENTO      := 0;

    -- obtener la operadora
    SSQL := 'ge_fn_operadora_scl';

    COD_OPERADORA_SCL := ge_fn_operadora_scl;

    -- obtener el cursor con los campos a mostrar para la direccion
    SSQL := ' SELECT A.COD_PARAMDIR, A.TIP_DAT, A.SEC_DAT, A.CAPTION, B.ORDEN, A.LARGO, B.IND_OBLIGATORIO ' ||
            ' FROM GE_PARAMDIR A, GE_PARAMDIROPERAD B ' || 
            ' WHERE B.COD_OPERAD = ' || COD_OPERADORA_SCL  || 
            ' AND B.COD_PARAMDIR = A.COD_PARAMDIR ' || 
            ' ORDER BY B.ORDEN ';

    OPEN SC_CAMPOS_DIR FOR
        SELECT A.COD_PARAMDIR, A.TIP_DAT, A.SEC_DAT, A.CAPTION, B.ORDEN, A.LARGO, B.IND_OBLIGATORIO
        FROM GE_PARAMDIR A, GE_PARAMDIROPERAD B 
        WHERE B.COD_OPERAD = COD_OPERADORA_SCL 
        AND B.COD_PARAMDIR = A.COD_PARAMDIR 
        ORDER BY B.ORDEN; 
  

EXCEPTION
         
    WHEN OTHERS THEN
             
        SN_COD_RETORNO  := 4;
        SV_MENS_RETORNO := 'Error en ejecución PL-SQL PV_OBTIENE_CAMPOS_DIR_PR.';
        LV_DES_ERROR    := SQLERRM;
        SN_NUM_EVENTO   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'PV_OBTIENE_CAMPOS_DIR_PR', ssql, SQLCODE, lv_des_error );
        
END PV_OBTIENE_CAMPOS_DIR_PR;

------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_DIR_POR_CLIENTE_PR ( EV_COD_CLIENTE       IN  VARCHAR2,
                                          EN_TIP_SUJETO        IN  GE_DIRPARAOPERAD.TIP_SUJETO%TYPE,   
                                          EN_COD_TIPDIRECCION  IN  NUMBER,
                                          EN_COD_DISPLAY       IN  GE_DIRPARAOPERAD.COD_DISPLAY%TYPE,
                                          SV_DIRECCION         OUT NOCOPY VARCHAR2,
                                          SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                          SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                          SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_DIR_POR_CLIENTE_PR"
      Lenguaje="PL/SQL"
      Fecha creación="13-06-2011"
      Creado por="Everis"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Obtiene los datos de la direccion de un cliente según campos por operadora
      </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_COD_CLIENTE" Tipo="VARCHAR2">Codigo de Cliente a bucar direccion</param>
            <param nom="EN_TIP_SUJETO" Tipo="NUMBER">Tipo de Sujeto</param>
            <param nom="EN_COD_TIPDIRECCION" Tipo="NUMBER">Tipo de Direccion</param>
            <param nom="EN_COD_DISPLAY" Tipo="NUMBER">Despliegue de direccion</param>            
         </Entrada>
         <Salida>
            <param nom="SV_DIRECCION"   Tipo="CURSOR">datos de la direccion del cliente</param>
            <param nom="SN_COD_RETORNO"  Tipo="NUMBER">codigo de Error</param>
            <param nom="SV_MENS_RETORNO" Tipo="VARCHAR2">mensaje de error</param>
            <param nom="SN_NUM_EVENTO"   Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DES_ERROR        VARCHAR2 (300);
SSQL                GE_ERRORES_PG.VQUERY;

BEGIN
    
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO    := 'OK';
    SN_NUM_EVENTO      := 0;

    -- obtener los datos de la direccion del cliente
    SSQL := 'ge_fn_obtiene_dirclie(' || EV_COD_CLIENTE || ','
                                     || EN_TIP_SUJETO || ','
                                     || EN_COD_TIPDIRECCION || ','
                                     || EN_COD_DISPLAY || ')';

    SV_DIRECCION := ge_fn_obtiene_dirclie(EV_COD_CLIENTE,
                                          EN_TIP_SUJETO,
                                          EN_COD_TIPDIRECCION,
                                          EN_COD_DISPLAY
                                         );


EXCEPTION
         
    WHEN OTHERS THEN
             
        SN_COD_RETORNO  := 4;
        SV_MENS_RETORNO := 'Error en ejecución PL-SQL PV_OBTIENE_DIR_POR_CLIENTE_PR.';
        LV_DES_ERROR    := SQLERRM;
        SN_NUM_EVENTO   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'PV_OBTIENE_DIR_POR_CLIENTE_PR', ssql, SQLCODE, lv_des_error );
        
END PV_OBTIENE_DIR_POR_CLIENTE_PR;

------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_ESTADOS_PR ( SC_ESTADOS_DIR     OUT NOCOPY REFCURSOR,
                                  SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                  SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                  SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_ESTADOS_PR"
      Lenguaje="PL/SQL"
      Fecha creación="13-06-2011"
      Creado por="Everis"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Obtiene los estados geograficos
      </Descripción>
      <Parámetros>
         <Entrada>
            
         </Entrada>
         <Salida>
            <param nom="SC_ESTADOS_DIR  Tipo="CURSOR">cursor con datos</param>
            <param nom="SN_COD_RETORNO"  Tipo="NUMBER">codigo de Error</param>
            <param nom="SV_MENS_RETORNO" Tipo="VARCHAR2">mensaje de error</param>
            <param nom="SN_NUM_EVENTO"   Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DES_ERROR        VARCHAR2 (300);
SSQL                GE_ERRORES_PG.VQUERY;
COD_OPERADORA_SCL   GE_OPERADORA_SCL.COD_OPERADORA_SCL%TYPE;

BEGIN
    
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO    := 'OK';
    SN_NUM_EVENTO      := 0;

    -- obtener el cursor con los campos a mostrar para la direccion
    SSQL := ' SELECT COD_ESTADO, DES_ESTADO FROM GE_ESTADOS  ' || 
            '  ORDER BY 2 ';

    OPEN SC_ESTADOS_DIR FOR
        SELECT COD_ESTADO, DES_ESTADO FROM GE_ESTADOS 
        ORDER BY 2; 
  

EXCEPTION
         
    WHEN OTHERS THEN
             
        SN_COD_RETORNO  := 4;
        SV_MENS_RETORNO := 'Error en ejecución PL-SQL PV_OBTIENE_ESTADOS_PR.';
        LV_DES_ERROR    := SQLERRM;
        SN_NUM_EVENTO   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'PV_OBTIENE_ESTADOS_PR', ssql, SQLCODE, lv_des_error );
        
END PV_OBTIENE_ESTADOS_PR;

------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_PUEBLO_POR_EST_PR ( EV_COD_ESTADO        IN  GE_PUEBLOS.COD_ESTADO%TYPE,
                                         SC_PUEBLOS_DIR       OUT NOCOPY REFCURSOR,
                                         SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                         SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                         SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_PUEBLO_POR_EST_PR"
      Lenguaje="PL/SQL"
      Fecha creación="13-06-2011"
      Creado por="Everis"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Obtiene los pueblos por estado geografico
      </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_COD_ESTADO" Tipo="VARCHAR2">Codigo de Estado geografico</param>            
         </Entrada>
         <Salida>
            <param nom="SC_PUEBLOS_DIR"   Tipo="CURSOR">Cursor con los datos de pueblos</param>
            <param nom="SN_COD_RETORNO"  Tipo="NUMBER">codigo de Error</param>
            <param nom="SV_MENS_RETORNO" Tipo="VARCHAR2">mensaje de error</param>
            <param nom="SN_NUM_EVENTO"   Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DES_ERROR        VARCHAR2 (300);
SSQL                GE_ERRORES_PG.VQUERY;

BEGIN
    
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO    := 'OK';
    SN_NUM_EVENTO      := 0;

    -- obtener los pueblos segun estado geografico
    SSQL := ' SELECT COD_PUEBLO, DES_PUEBLO ' || 
            ' FROM GE_PUEBLOS ' ||
            ' WHERE COD_ESTADO = ' || EV_COD_ESTADO ||
            ' ORDER BY 2 ';
                        
    OPEN SC_PUEBLOS_DIR FOR
        SELECT COD_PUEBLO, DES_PUEBLO 
        FROM GE_PUEBLOS
        WHERE COD_ESTADO = EV_COD_ESTADO
        ORDER BY 2;


EXCEPTION
         
    WHEN OTHERS THEN
             
        SN_COD_RETORNO  := 4;
        SV_MENS_RETORNO := 'Error en ejecución PL-SQL PV_OBTIENE_PUEBLO_POR_EST_PR.';
        LV_DES_ERROR    := SQLERRM;
        SN_NUM_EVENTO   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'PV_OBTIENE_PUEBLO_POR_EST_PR', ssql, SQLCODE, lv_des_error );
        
END PV_OBTIENE_PUEBLO_POR_EST_PR;

------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_TIPO_CALLE_PR (SC_CALLES_DIR        OUT NOCOPY REFCURSOR,
                                    SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_TIPO_CALLE_PR"
      Lenguaje="PL/SQL"
      Fecha creación="13-06-2011"
      Creado por="Everis"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Obtiene los tipos de calles
      </Descripción>
      <Parámetros>
         <Entrada>            
         </Entrada>
         <Salida>
            <param nom="SC_CALLES_DIR"   Tipo="CURSOR">Cursor con los tipos de calles</param>
            <param nom="SN_COD_RETORNO"  Tipo="NUMBER">codigo de Error</param>
            <param nom="SV_MENS_RETORNO" Tipo="VARCHAR2">mensaje de error</param>
            <param nom="SN_NUM_EVENTO"   Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DES_ERROR        VARCHAR2 (300);
SSQL                GE_ERRORES_PG.VQUERY;

BEGIN
    
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO    := 'OK';
    SN_NUM_EVENTO      := 0;

    -- obtener los tipos de calles
    
    SSQL := ' SELECT VALOR, DESCRIPCION_VALOR ' || 
            ' FROM GE_TIPOS_CALLES_VW ' ||
            ' Where ind_estado = ''V''' ||
            ' ORDER BY 1 ';
                        
    OPEN SC_CALLES_DIR FOR
        SELECT VALOR, DESCRIPCION_VALOR 
        FROM GE_TIPOS_CALLES_VW
        WHERE IND_ESTADO = 'V'
        ORDER BY 1;


EXCEPTION
         
    WHEN OTHERS THEN
             
        SN_COD_RETORNO  := 4;
        SV_MENS_RETORNO := 'Error en ejecución PL-SQL PV_OBTIENE_TIPO_CALLE_PR.';
        LV_DES_ERROR    := SQLERRM;
        SN_NUM_EVENTO   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'PV_OBTIENE_TIPO_CALLE_PR', ssql, SQLCODE, lv_des_error );
        
END PV_OBTIENE_TIPO_CALLE_PR;

------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_ZIP_CODE_PR ( EV_COD_ZONA          IN  GE_ZIPCODE_TD.COD_ZONA%TYPE,
                                   SC_ZIPCODE_DIR       OUT NOCOPY REFCURSOR,
                                   SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                   SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                   SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_ZIP_CODE_PR"
      Lenguaje="PL/SQL"
      Fecha creación="17-06-2011"
      Creado por="Everis"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Obtiene los ZIP CODE
      </Descripción>
      <Parámetros>
         <Entrada>            
            <param nom="EV_COD_ZONA" Tipo="VARCHAR2">Codigo de la zona</param>         
         </Entrada>
         <Salida>
            <param nom="SC_ZIPCODE_DIR"   Tipo="CURSOR">Cursor con los Zip Code</param>
            <param nom="SN_COD_RETORNO"  Tipo="NUMBER">codigo de Error</param>
            <param nom="SV_MENS_RETORNO" Tipo="VARCHAR2">mensaje de error</param>
            <param nom="SN_NUM_EVENTO"   Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DES_ERROR        VARCHAR2 (300);
SSQL                GE_ERRORES_PG.VQUERY;

BEGIN
    
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO    := 'OK';
    SN_NUM_EVENTO      := 0;

    -- obtener los Zip Code
                        
    SSQL := ' SELECT ZIP ' ||
            ' FROM GE_ZIPCODE_TD ' ||
            ' WHERE COD_ZONA = ' || EV_COD_ZONA;
                            
    OPEN SC_ZIPCODE_DIR FOR
        SELECT ZIP 
        FROM GE_ZIPCODE_TD 
        WHERE COD_ZONA = EV_COD_ZONA;


EXCEPTION
         
    WHEN OTHERS THEN
             
        SN_COD_RETORNO  := 4;
        SV_MENS_RETORNO := 'Error en ejecución PL-SQL PV_OBTIENE_ZIP_CODE_PR.';
        LV_DES_ERROR    := SQLERRM;
        SN_NUM_EVENTO   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'PV_OBTIENE_ZIP_CODE_PR', ssql, SQLCODE, lv_des_error );
        
END PV_OBTIENE_ZIP_CODE_PR;

------------------------------------------------------------------------------------------------------------

PROCEDURE PV_OBTIENE_PARAM_ZIP_CODE_PR ( SV_PARAM_ZIPCODE     OUT NOCOPY GED_PARAMETROS.VAL_PARAMETRO%TYPE,
                                         SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                         SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                         SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
)
IS

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_OBTIENE_PARAM_ZIP_CODE_PR"
      Lenguaje="PL/SQL"
      Fecha creación="17-06-2011"
      Creado por="Everis"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Obtiene el valor del parametro TABLA_ZIPCODE
      </Descripción>
      <Parámetros>
         <Entrada>            
         </Entrada>
         <Salida>
            <param nom="SV_PARAM_ZIPCODE" Tipo="VARCHAR2">Valor del Parametro</param>
            <param nom="SN_COD_RETORNO"   Tipo="NUMBER">codigo de Error</param>
            <param nom="SV_MENS_RETORNO"  Tipo="VARCHAR2">mensaje de error</param>
            <param nom="SN_NUM_EVENTO"    Tipo="NUMBER">numero de evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

LV_DES_ERROR        VARCHAR2 (300);
SSQL                GE_ERRORES_PG.VQUERY;

BEGIN
    
    SN_COD_RETORNO     := 0;
    SV_MENS_RETORNO    := 'OK';
    SN_NUM_EVENTO      := 0;

    SSQL := ' SELECT VAL_PARAMETRO ' || 
            ' FROM GED_PARAMETROS ' || 
            ' WHERE NOM_PARAMETRO = ''TABLA_ZIPCODE''' ||
            ' AND COD_MODULO = ''GA''' || 
            ' AND COD_PRODUCTO = 1';
        

    SELECT VAL_PARAMETRO 
    INTO SV_PARAM_ZIPCODE
    FROM GED_PARAMETROS 
    WHERE NOM_PARAMETRO = 'TABLA_ZIPCODE'
        AND COD_MODULO = 'GA' 
        AND COD_PRODUCTO = 1;
                

EXCEPTION
         
    WHEN OTHERS THEN
             
        SN_COD_RETORNO  := 4;
        SV_MENS_RETORNO := 'Error en ejecución PL-SQL PV_OBTIENE_PARAM_ZIP_CODE_PR.';
        LV_DES_ERROR    := SQLERRM;
        SN_NUM_EVENTO   := ge_errores_pg.grabarpl(0, 'PV', sv_mens_retorno, '1.0', USER,'PV_OBTIENE_PARAM_ZIP_CODE_PR', ssql, SQLCODE, lv_des_error );
        
END PV_OBTIENE_PARAM_ZIP_CODE_PR;

------------------------------------------------------------------------------------------------------------

END Pv_Consultas_Portal_Pg;
/

SHOW ERRORS