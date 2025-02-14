CREATE OR REPLACE PACKAGE BODY MAS_SERVICE_DML.IC_PROVISION_VENTA_PG AS
------------------------------------------------------------
PROCEDURE IC_BUSCA_CLIENTE_PR (EO_PROVISION IN OUT IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER)
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_BUSCA_CLIENTE_PR "
      Lenguaje="PL/SQL"
      Fecha creación="11-10-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Busca los datos de cliente para ejecutar movimiento </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_sSql VARCHAR2(3000);
    LV_CODPROCESO VARCHAR2(3);
    LV_NUMPROCESO VARCHAR2(11);
BEGIN
    SN_ERROR := 0;
    SV_MENSAJE := NULL;
    SN_EVENTO := 0;

    LV_sSql := 'SELECT a.cod_cliente, a.num_celular, a.num_abonado, a.tip_terminal, ';
    LV_sSql := LV_sSql || ' a.cod_central, a.num_serie, a.cod_tecnologia';
    LV_sSql := LV_sSql || ' FROM ga_abocel a, pr_productos_contratados_to b';
    LV_sSql := LV_sSql || ' WHERE a.num_abonado = b.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND a.cod_cliente = b.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND b.cod_prod_contratado = '|| EO_PROVISION.COD_PROD_CONTRAT;
    LV_sSql := LV_sSql || ' UNION';
    LV_sSql := LV_sSql || ' SELECT c.cod_cliente, c.num_celular, c.num_abonado, c.tip_terminal, ';
    LV_sSql := LV_sSql || ' c.cod_central, c.num_serie, c.cod_tecnologia';
    LV_sSql := LV_sSql || ' FROM ga_aboamist c, pr_productos_contratados_to b';
    LV_sSql := LV_sSql || ' WHERE c.num_abonado = b.num_abonado_contratante';
    LV_sSql := LV_sSql || ' AND c.cod_cliente = b.cod_cliente_contratante';
    LV_sSql := LV_sSql || ' AND b.cod_prod_contratado = '|| EO_PROVISION.COD_PROD_CONTRAT;

    SELECT a.cod_cliente, a.num_celular, a.num_abonado, a.tip_terminal,
           a.cod_central, a.num_serie, a.cod_tecnologia
    INTO   EO_PROVISION.COD_CLIENTE,
           EO_PROVISION.NUM_CELULAR,
           EO_PROVISION.NUM_ABONADO,
           EO_PROVISION.TIP_TERMINAL,
           EO_PROVISION.COD_CENTRAL,
           EO_PROVISION.NUM_SERIE,
           EO_PROVISION.COD_TECNOLOGIA
    FROM   ga_abocel a, pr_productos_contratados_to b
    WHERE  a.num_abonado = b.num_abonado_contratante
--1    AND       a.cod_cliente = b.cod_cliente_contratante
    AND       b.cod_prod_contratado = EO_PROVISION.COD_PROD_CONTRAT
    UNION
    SELECT c.cod_cliente, c.num_celular, c.num_abonado, c.tip_terminal,
           c.cod_central, c.num_serie, c.cod_tecnologia
    FROM   ga_aboamist c, pr_productos_contratados_to b
    WHERE  c.num_abonado = b.num_abonado_contratante
--1    AND       c.cod_cliente = b.cod_cliente_contratante
    AND       b.cod_prod_contratado = EO_PROVISION.COD_PROD_CONTRAT;

/*1 Se comenta la relacion a través de código de cliente para dar soporte a los cambios de plan */

EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_ERROR := 149;
             SV_MENSAJE := 'No se ha podido recuperar datos de Cliente para Producto Contratado';
             SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO, CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_BUSCA_CLIENTE_PR', LV_sSql, SN_ERROR, SV_MENSAJE );
         WHEN OTHERS THEN
             SN_ERROR := SQLCODE;
             SV_MENSAJE := SQLERRM;
             SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO, CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_BUSCA_CLIENTE_PR', LV_sSql, SN_ERROR, SV_MENSAJE );
END IC_BUSCA_CLIENTE_PR;
------------------------------------------------------------
PROCEDURE IC_BUSCA_SERVICIO_PR (EO_PROVISION IN OUT IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER)
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_BUSCA_SERVICIO_PR "
      Lenguaje="PL/SQL"
      Fecha creación="11-10-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Busca los datos de especificacion de servicio</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_sSql VARCHAR2(3000);
    errorEjecucion EXCEPTION;
BEGIN
    SN_ERROR := 0;
    SV_MENSAJE := NULL;
    SN_EVENTO := 0;


    LV_sSql := 'SELECT a.cod_prov_serv, a.ind_tipo_servicio ';
    LV_sSql := LV_sSql || ' FROM   SE_DETALLES_ESPECIFICACION_TO A, ';
    LV_sSql := LV_sSql || ' PR_PRODUCTOS_CONTRATADOS_TO b, ';
    LV_sSql := LV_sSql || ' PF_PRODUCTOS_OFERTADOS_TD c';
    LV_sSql := LV_sSql || ' WHERE  a.COD_ESPEC_PROD = c.COD_ESPEC_PROD';
    LV_sSql := LV_sSql || ' AND      b.COD_PROD_OFERTADO = c.COD_PROD_OFERTADO;';
    LV_sSql := LV_sSql || ' AND      b.cod_prod_contratado = ' || EO_PROVISION.COD_PROD_CONTRAT;

    SELECT a.cod_prov_serv, a.ind_tipo_servicio
    INTO   EO_PROVISION.COD_PROV_SERV,
           EO_PROVISION.TIP_SER
    FROM   SE_DETALLES_ESPECIFICACION_TO A,
           PR_PRODUCTOS_CONTRATADOS_TO b,
           PF_PRODUCTOS_OFERTADOS_TD c
    WHERE  a.cod_espec_prod = c.cod_espec_prod
    AND       b.cod_prod_ofertado = c.cod_prod_ofertado
    AND       b.cod_prod_contratado = EO_PROVISION.COD_PROD_CONTRAT;
--    AND       a.IND_TIPO_SERVICIO = CV_Altamira;

    IF (EO_PROVISION.COD_PROV_SERV IS NULL) THEN
        RAISE NO_DATA_FOUND;
    END IF;

EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_ERROR := 854;
             SV_MENSAJE := 'No se ha podido recuperar Servicios a Provisionar para Producto Contratado';
             SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO,  CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_BUSCA_SERVICIO_PR', LV_sSql, SN_ERROR, SV_MENSAJE );
         WHEN OTHERS THEN
             SN_ERROR := SQLCODE;
             SV_MENSAJE := SQLERRM;
             SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO,  CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_BUSCA_SERVICIO_PR', LV_sSql, SN_ERROR, SV_MENSAJE );
END IC_BUSCA_SERVICIO_PR;

------------------------------------------------------------
PROCEDURE IC_BUSCA_ABONADOS_PR (EN_COD_CLIENTE IN NUMBER,
                                EN_PRODCONTRATADO IN pr_productos_contratados_to.cod_prod_contratado%TYPE,
                                SO_ABONADOS OUT NOCOPY IC_PROVISION_LST_QT,
                                SN_ERROR OUT NOCOPY NUMBER,
                                SV_MENSAJE OUT NOCOPY VARCHAR2,
                                SN_EVENTO OUT NOCOPY NUMBER)
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_BUSCA_ABONADOS_PR "
      Lenguaje="PL/SQL"
      Fecha creación="03-11-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Busca los abonados del cliente</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_COD_CLIENTE"         Tipo="NUMERICO"> Object Type </param>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
    LV_sSql VARCHAR2(3000);
BEGIN
    SN_ERROR := 0;
    SV_MENSAJE := NULL;
    SN_EVENTO := 0;

    LV_sSql := 'SELECT IC_PROVISION_QT(a.COD_CLIENTE,NULL,NULL,NULL,NULL,NULL,';
    LV_sSql := LV_sSql || ' a.NUM_CELULAR,a.NUM_ABONADO,a.TIP_TERMINAL,a.COD_CENTRAL,a.NUM_SERIE,a.COD_TECNOLOGIA,';
    LV_sSql := LV_sSql || ' NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)';
    LV_sSql := LV_sSql || ' BULK COLLECT INTO SO_ABONADOS';
    LV_sSql := LV_sSql || ' FROM ga_abocel a, pf_productos_ofertados_td b, pr_productos_contratados_to c';
    LV_sSql := LV_sSql || ' WHERE a.COD_CLIENTE = '||EN_COD_CLIENTE;
    LV_sSql := LV_sSql || ' AND a.cod_situacion IN (''AAA'', ''AOP'', ''TVP'', ''ATP'')';
    LV_sSql := LV_sSql || ' AND a.COD_USO = DECODE(b.tipo_plataforma,''1'',3,''2'',2,''3'',10)';
    LV_sSql := LV_sSql || ' AND b.cod_prod_ofertado = c.cod_prod_ofertado';
    LV_sSql := LV_sSql || ' AND c.cod_prod_contratado = '||EN_PRODCONTRATADO;
    LV_sSql := LV_sSql || ' AND a.COD_CLIENTE = c.COD_CLIENTE_beneficiario';

    -- La condicion se puede cambiar de acuerdo a nuevas definiciones.-
    SELECT IC_PROVISION_QT(a.COD_CLIENTE,NULL,NULL,NULL,NULL,NULL,
    a.NUM_CELULAR,a.NUM_ABONADO,a.TIP_TERMINAL,a.COD_CENTRAL,a.NUM_SERIE,a.COD_TECNOLOGIA,
    NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
    BULK COLLECT INTO SO_ABONADOS
    FROM ga_abocel a, pf_productos_ofertados_td b, pr_productos_contratados_to c
    WHERE a.COD_CLIENTE = EN_COD_CLIENTE
    AND a.cod_situacion IN ('AAA', 'AOP', 'TVP', 'ATP')
    AND a.COD_USO = DECODE(b.tipo_plataforma,'1',3,'2',2,'3',10)
    AND b.cod_prod_ofertado = c.cod_prod_ofertado
    AND c.cod_prod_contratado = EN_PRODCONTRATADO
    AND a.COD_CLIENTE = c.COD_CLIENTE_beneficiario;


EXCEPTION
         WHEN NO_DATA_FOUND THEN
             SN_ERROR := 149;
             SV_MENSAJE := 'No se ha podido recuperar datos de Cliente para Producto Contratado';
             SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO,  CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_BUSCA_ABONADOS_PR', LV_sSql, SN_ERROR, SV_MENSAJE );
         WHEN OTHERS THEN
             SN_ERROR := SQLCODE;
             SV_MENSAJE := SQLERRM;
             SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO,  CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_BUSCA_ABONADOS_PR', LV_sSql, SN_ERROR, SV_MENSAJE );
END IC_BUSCA_ABONADOS_PR;

------------------------------------------------------------
PROCEDURE IC_INSERTA_PR ( EO_PROVISION IN IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_INSERTA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="03-11-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Genera un nuevo Movimiento con los datos ingresados </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type de la tabla ICC_MOVIMIENTO </param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);
LN_total          number:=0;
LN_Indice         number;
EO_PROVISION_TMP IC_PROVISION_QT := EO_PROVISION;
LO_PROVISION_ABO IC_PROVISION_QT := IC_PROVISION_QT();
LO_ABONADOS  IC_PROVISION_LST_QT;
ERROR_CONTROLADO EXCEPTION;

BEGIN
   SN_ERROR := 0;
   SV_MENSAJE := NULL;
   SN_EVENTO := 0;


    -- Validaciones previas.-
       IF EO_PROVISION_TMP.NUM_ABONADO = 0 OR EO_PROVISION_TMP.NUM_ABONADO IS NULL  THEN
           IF EO_PROVISION_TMP.COD_CLIENTE = 0 OR EO_PROVISION_TMP.COD_CLIENTE IS NULL THEN
              SN_ERROR := 877;
              SV_MENSAJE := 'Falta Parametro de Abonado o Cliente';
              RAISE ERROR_CONTROLADO;
           END IF;
       END IF;

       -- Funcionalidad por cliente.-
       IF EO_PROVISION_TMP.NUM_ABONADO = 0 AND EO_PROVISION_TMP.COD_CLIENTE IS NOT NULL THEN

              LV_Sql := 'IC_BUSCA_ABONADOS_PR('||EO_PROVISION_TMP.COD_CLIENTE||', '||EO_PROVISION_TMP.COD_PROD_CONTRAT||')';
           -- Se buscan los abonados del cliente.-
           IC_BUSCA_ABONADOS_PR(EO_PROVISION_TMP.COD_CLIENTE,EO_PROVISION_TMP.COD_PROD_CONTRAT, LO_ABONADOS,SN_ERROR,SV_MENSAJE,SN_EVENTO);
           IF SN_ERROR != 0 THEN
              RAISE ERROR_CONTROLADO;
           END IF;

           -- Se procesa la lista de abonados.-
           LN_total:=LO_ABONADOS.count;
           FOR LN_Indice IN 1..LN_total LOOP

               -- Asigna valores propios del abonado a estructura.-
               -- Se debe asegurar que todos los campos tengan un valor atribuible al abonado especifico
               -- y que no provenga de un ciclo anterior.-
               LO_PROVISION_ABO.COD_CLIENTE     := EO_PROVISION_TMP.COD_CLIENTE;
               LO_PROVISION_ABO.COD_PROV_SERV   := EO_PROVISION_TMP.COD_PROV_SERV;
               LO_PROVISION_ABO.TIP_ACCION      := EO_PROVISION_TMP.TIP_ACCION;
               LO_PROVISION_ABO.TIP_SER         := EO_PROVISION_TMP.TIP_SER;
               LO_PROVISION_ABO.COD_PROD_CONTRAT:= EO_PROVISION_TMP.COD_PROD_CONTRAT;
               LO_PROVISION_ABO.FECHA_EJECUCION := EO_PROVISION_TMP.FECHA_EJECUCION;
               LO_PROVISION_ABO.NUM_CELULAR     := LO_ABONADOS(LN_Indice).NUM_CELULAR;
               LO_PROVISION_ABO.NUM_ABONADO     := LO_ABONADOS(LN_Indice).NUM_ABONADO;
               LO_PROVISION_ABO.TIP_TERMINAL    := LO_ABONADOS(LN_Indice).TIP_TERMINAL;
               LO_PROVISION_ABO.COD_CENTRAL     := LO_ABONADOS(LN_Indice).COD_CENTRAL;
               LO_PROVISION_ABO.NUM_SERIE       := LO_ABONADOS(LN_Indice).NUM_SERIE;
               LO_PROVISION_ABO.COD_TECNOLOGIA  := LO_ABONADOS(LN_Indice).COD_TECNOLOGIA;
               LO_PROVISION_ABO.ID_PLAN         := EO_PROVISION_TMP.ID_PLAN;
               LO_PROVISION_ABO.IMPORTE         := EO_PROVISION_TMP.IMPORTE;
               LO_PROVISION_ABO.COD_MONEDA      := EO_PROVISION_TMP.COD_MONEDA;
               LO_PROVISION_ABO.USUARIO         := EO_PROVISION_TMP.USUARIO;
               LO_PROVISION_ABO.COD_CAUSA       := EO_PROVISION_TMP.COD_CAUSA;
               LO_PROVISION_ABO.MONTO_BONIF     := EO_PROVISION_TMP.MONTO_BONIF;
               LO_PROVISION_ABO.TIPO_BONO       := EO_PROVISION_TMP.TIPO_BONO;
               LO_PROVISION_ABO.COD_PERIODIF    := EO_PROVISION_TMP.COD_PERIODIF;
               LO_PROVISION_ABO.FECHA_EJEC_BONO := EO_PROVISION_TMP.FECHA_EJEC_BONO;
               LO_PROVISION_ABO.NUM_MOVANT      := EO_PROVISION_TMP.NUM_MOVANT;
               LO_PROVISION_ABO.NOM_USUARORA    := EO_PROVISION_TMP.NOM_USUARORA;

               LV_Sql := ' IC_PROV_ABONADO_PR('
                        ||', '||'LO_PROVISION_ABO.COD_CLIENTE     : '||LO_PROVISION_ABO.COD_CLIENTE
                        ||', '||'LO_PROVISION_ABO.COD_PROV_SERV   : '||LO_PROVISION_ABO.COD_PROV_SERV
                        ||', '||'LO_PROVISION_ABO.TIP_ACCION      : '||LO_PROVISION_ABO.TIP_ACCION
                        ||', '||'LO_PROVISION_ABO.TIP_SER         : '||LO_PROVISION_ABO.TIP_SER
                        ||', '||'LO_PROVISION_ABO.COD_PROD_CONTRAT: '||LO_PROVISION_ABO.COD_PROD_CONTRAT
                        ||', '||'LO_PROVISION_ABO.FECHA_EJECUCION : '||LO_PROVISION_ABO.FECHA_EJECUCION
                        ||', '||'LO_PROVISION_ABO.NUM_CELULAR     : '||LO_PROVISION_ABO.NUM_CELULAR
                        ||', '||'LO_PROVISION_ABO.NUM_ABONADO     : '||LO_PROVISION_ABO.NUM_ABONADO
                        ||', '||'LO_PROVISION_ABO.TIP_TERMINAL    : '||LO_PROVISION_ABO.TIP_TERMINAL
                        ||', '||'LO_PROVISION_ABO.COD_CENTRAL     : '||LO_PROVISION_ABO.COD_CENTRAL
                        ||', '||'LO_PROVISION_ABO.NUM_SERIE       : '||LO_PROVISION_ABO.NUM_SERIE
                        ||', '||'LO_PROVISION_ABO.COD_TECNOLOGIA  : '||LO_PROVISION_ABO.COD_TECNOLOGIA
                        ||', '||'LO_PROVISION_ABO.ID_PLAN         : '||LO_PROVISION_ABO.ID_PLAN
                        ||', '||'LO_PROVISION_ABO.IMPORTE         : '||LO_PROVISION_ABO.IMPORTE
                        ||', '||'LO_PROVISION_ABO.COD_MONEDA      : '||LO_PROVISION_ABO.COD_MONEDA
                        ||', '||'LO_PROVISION_ABO.USUARIO         : '||LO_PROVISION_ABO.USUARIO
                        ||', '||'LO_PROVISION_ABO.COD_CAUSA       : '||LO_PROVISION_ABO.COD_CAUSA
                        ||', '||'LO_PROVISION_ABO.MONTO_BONIF     : '||LO_PROVISION_ABO.MONTO_BONIF
                        ||', '||'LO_PROVISION_ABO.TIPO_BONO       : '||LO_PROVISION_ABO.TIPO_BONO
                        ||', '||'LO_PROVISION_ABO.COD_PERIODIF    : '||LO_PROVISION_ABO.COD_PERIODIF
                        ||', '||'LO_PROVISION_ABO.FECHA_EJEC_BONO : '||LO_PROVISION_ABO.FECHA_EJEC_BONO
                        ||', '||'LO_PROVISION_ABO.NUM_MOVANT      : '||LO_PROVISION_ABO.NUM_MOVANT
                        ||', '||'LO_PROVISION_ABO.NOM_USUARORA    : '||LO_PROVISION_ABO.NOM_USUARORA||')';
               IC_PROV_ABONADO_PR (LO_PROVISION_ABO, SN_ERROR, SV_MENSAJE, SN_EVENTO);
               IF SN_ERROR != 0 THEN
                   RAISE ERROR_CONTROLADO;
               END IF;
           END LOOP;
       END IF;

    -- Funcionalidad por Abonado.-
    IF EO_PROVISION_TMP.NUM_ABONADO <> 0 THEN
        LV_Sql := ' IC_PROV_ABONADO_PR('
        ||', '||'EO_PROVISION.COD_CLIENTE     : '||EO_PROVISION.COD_CLIENTE
        ||', '||'EO_PROVISION.COD_PROV_SERV   : '||EO_PROVISION.COD_PROV_SERV
        ||', '||'EO_PROVISION.TIP_ACCION      : '||EO_PROVISION.TIP_ACCION
        ||', '||'EO_PROVISION.TIP_SER         : '||EO_PROVISION.TIP_SER
        ||', '||'EO_PROVISION.COD_PROD_CONTRAT: '||EO_PROVISION.COD_PROD_CONTRAT
        ||', '||'EO_PROVISION.FECHA_EJECUCION : '||EO_PROVISION.FECHA_EJECUCION
        ||', '||'EO_PROVISION.NUM_CELULAR     : '||EO_PROVISION.NUM_CELULAR
        ||', '||'EO_PROVISION.NUM_ABONADO     : '||EO_PROVISION.NUM_ABONADO
        ||', '||'EO_PROVISION.TIP_TERMINAL    : '||EO_PROVISION.TIP_TERMINAL
        ||', '||'EO_PROVISION.COD_CENTRAL     : '||EO_PROVISION.COD_CENTRAL
        ||', '||'EO_PROVISION.NUM_SERIE       : '||EO_PROVISION.NUM_SERIE
        ||', '||'EO_PROVISION.COD_TECNOLOGIA  : '||EO_PROVISION.COD_TECNOLOGIA
        ||', '||'EO_PROVISION.ID_PLAN         : '||EO_PROVISION.ID_PLAN
        ||', '||'EO_PROVISION.IMPORTE         : '||EO_PROVISION.IMPORTE
        ||', '||'EO_PROVISION.COD_MONEDA      : '||EO_PROVISION.COD_MONEDA
        ||', '||'EO_PROVISION.USUARIO         : '||EO_PROVISION.USUARIO
        ||', '||'EO_PROVISION.COD_CAUSA       : '||EO_PROVISION.COD_CAUSA
        ||', '||'EO_PROVISION.MONTO_BONIF     : '||EO_PROVISION.MONTO_BONIF
        ||', '||'EO_PROVISION.TIPO_BONO       : '||EO_PROVISION.TIPO_BONO
        ||', '||'EO_PROVISION.COD_PERIODIF    : '||EO_PROVISION.COD_PERIODIF
        ||', '||'EO_PROVISION.FECHA_EJEC_BONO : '||EO_PROVISION.FECHA_EJEC_BONO
        ||', '||'EO_PROVISION.NUM_MOVANT      : '||EO_PROVISION.NUM_MOVANT
        ||', '||'EO_PROVISION.NOM_USUARORA    : '||EO_PROVISION.NOM_USUARORA||')';
        IC_PROV_ABONADO_PR (EO_PROVISION, SN_ERROR, SV_MENSAJE, SN_EVENTO);
    END IF;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
           IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
              SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
           END IF;
           SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_VENTA_PG.IC_INSERTA_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO, CV_cod_modulo, 'Error en centrales '||SN_ERROR||' '||SV_MENSAJE, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_INSERTA_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_INSERTA_PR;


------------------------------------------------------------
PROCEDURE IC_PROV_ABONADO_PR ( EO_PROVISION IN IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_PROV_ABONADO_PR"
      Lenguaje="PL/SQL"
      Fecha creación="11-10-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion="Carlos Sellao H"
      Modificado por="03-11-2008"
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Genera un nuevo Movimiento con los datos ingresados </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type de la tabla ICC_MOVIMIENTO </param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);
LO_MOVIM        ICC_MOVIMIENTO_QT := ICC_MOVIMIENTO_QT;
LO_DETMOV        IC_DETALLEMOV_TO_QT := IC_DETALLEMOV_TO_QT;
LV_HayAnt       varchar2(20) := 'TRUE';
LV_CodPerREC      ged_parametros.val_parametro%TYPE;
LV_CodPerSMS      ged_parametros.val_parametro%TYPE;
LN_NUM_MOVANT     ICC_MOVIMIENTO.NUM_MOVANT%TYPE;

LV_des_error       ge_errores_pg.DesEvent;

EO_PROVISION_TMP IC_PROVISION_QT := EO_PROVISION;

ERROR_CONTROLADO EXCEPTION;

BEGIN
   SN_ERROR := 0;
   SV_MENSAJE := NULL;
   SN_EVENTO := 0;

   -- Validaciones --

   IF EO_PROVISION_TMP.TIP_ACCION IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.TIP_ACCION)) IS NULL THEN
       SN_ERROR := 300112;
       SV_MENSAJE := 'Falta Parametro Tipo de Accion';
       RAISE ERROR_CONTROLADO;
   END IF;

   -- EN EL CASO DE UNA BAJA, SE BUSCAN LOS DATOS NECESARIOS PARA GENERAR EL MOVIMIENTO
   IF EO_PROVISION_TMP.TIP_ACCION = '2' THEN

        IF (EO_PROVISION_TMP.NUM_CELULAR IS NULL) THEN
            LV_Sql := 'IC_BUSCA_CLIENTE_PR(EO_PROVISION_TMP)';
            IC_BUSCA_CLIENTE_PR(EO_PROVISION_TMP,SN_ERROR,SV_MENSAJE,SN_EVENTO);
            IF (SN_ERROR != 0) THEN
                IF (SN_ERROR = 149) THEN
                    SN_ERROR := 0;
                END IF;
                RAISE ERROR_CONTROLADO;
            END IF;
        END IF;
          LV_Sql := 'IC_BUSCA_SERVICIO_PR(EO_PROVISION_TMP)';
          IC_BUSCA_SERVICIO_PR(EO_PROVISION_TMP,SN_ERROR,SV_MENSAJE,SN_EVENTO);
       IF (SN_ERROR != 0) THEN
             IF (SN_ERROR = 854) THEN
                SN_ERROR := 0;
          END IF;
          RAISE ERROR_CONTROLADO;
       END IF;

   END IF;


   IF EO_PROVISION_TMP.FECHA_EJECUCION IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.FECHA_EJECUCION)) IS NULL THEN
       SN_ERROR := 200302;
       SV_MENSAJE := 'Falta Parametro Fecha de Ejecucion';
       RAISE ERROR_CONTROLADO;
   END IF;

   IF EO_PROVISION_TMP.NUM_CELULAR IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.NUM_CELULAR)) IS NULL THEN
          SN_ERROR := 142;
       SV_MENSAJE := 'Falta Parametro Numero de Celular';
       EO_PROVISION_TMP.NUM_CELULAR := 0;
   END IF;

   IF EO_PROVISION_TMP.NUM_ABONADO IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.NUM_ABONADO)) IS NULL THEN
          SN_ERROR := 218;
       SV_MENSAJE := 'Falta Parametro Numero de Abonado';
       EO_PROVISION_TMP.NUM_ABONADO := 0;
   END IF;

   IF EO_PROVISION_TMP.TIP_TERMINAL IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.TIP_TERMINAL)) IS NULL THEN
       SN_ERROR := 259;
       SV_MENSAJE := 'Falta Parametro Tipo de Terminal';
       RAISE ERROR_CONTROLADO;
   END IF;

   IF EO_PROVISION_TMP.COD_CENTRAL IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.COD_CENTRAL)) IS NULL THEN
       SN_ERROR := 38;
       SV_MENSAJE := 'Falta Parametro Codigo de Central';
       RAISE ERROR_CONTROLADO;
   END IF;

   IF EO_PROVISION_TMP.NUM_SERIE IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.NUM_SERIE)) IS NULL THEN
       SN_ERROR := 107;
       SV_MENSAJE := 'Falta Parametro Numero de Serie';
       RAISE ERROR_CONTROLADO;
   END IF;

   IF EO_PROVISION_TMP.COD_TECNOLOGIA IS NULL OR LENGTH(TRIM(EO_PROVISION_TMP.COD_TECNOLOGIA)) IS NULL THEN
       EO_PROVISION_TMP.COD_TECNOLOGIA := 'TDMA';
   END IF;

   -- Preparacion de Datos --

   LO_MOVIM.COD_PROD_CONTRATADO := EO_PROVISION_TMP.COD_PROD_CONTRAT;
   LO_MOVIM.FEC_ACTIVACION := EO_PROVISION_TMP.FECHA_EJECUCION;
   LO_MOVIM.NUM_CELULAR := EO_PROVISION_TMP.NUM_CELULAR;
   LO_MOVIM.NUM_ABONADO := EO_PROVISION_TMP.NUM_ABONADO;
   LO_MOVIM.TIP_TERMINAL := EO_PROVISION_TMP.TIP_TERMINAL;
   LO_MOVIM.COD_CENTRAL := EO_PROVISION_TMP.COD_CENTRAL;
   LO_MOVIM.NUM_SERIE := EO_PROVISION_TMP.NUM_SERIE;
   LO_MOVIM.TIP_TECNOLOGIA := EO_PROVISION_TMP.COD_TECNOLOGIA;
   LO_MOVIM.ICC := EO_PROVISION_TMP.NUM_SERIE;

   IF EO_PROVISION_TMP.NUM_MOVANT = 0 THEN
     LN_NUM_MOVANT:=NULL;
   ELSE
     LN_NUM_MOVANT:=EO_PROVISION_TMP.NUM_MOVANT;
   END IF;

   LO_MOVIM.NUM_MOVANT := LN_NUM_MOVANT; -- EO_PROVISION_TMP.NUM_MOVANT;  Dependencia de movimientos

   --LO_MOVIM.COD_ESTADO := 1; P-CSR-11002 JLGN 15-11-2011
   LO_MOVIM.COD_ESTADO := 9;
   LO_MOVIM.COD_MODULO := CV_cod_modulo;
   LO_MOVIM.DES_RESPUESTA := 'PENDIENTE';

   -- Valida dependencia del movimiento.-


      IF   (  EO_PROVISION_TMP.COD_TECNOLOGIA='GSM' OR
              EO_PROVISION_TMP.COD_TECNOLOGIA='FIJO'    ) THEN


           -- IF (EO_PROVISION_TMP.NUM_MOVANT IS NOT NULL) THEN
            IF (LN_NUM_MOVANT IS NOT NULL) THEN

                -- LV_HayAnt := IC_DEPENDENCIA_SP_PG.IC_VALIDA_DEPENDENCIA_FN(EO_PROVISION_TMP.NUM_MOVANT);
                  LV_HayAnt := IC_DEPENDENCIA_SP_PG.IC_VALIDA_DEPENDENCIA_FN(LN_NUM_MOVANT);
            END IF;

           -- Define estado para Movimientos Dependientes y Movimientos Programados.-
            --Si el mov anterior no está en tablas o la fecha de activacion es mayor al sysdate.-
            --IF ((LV_HayAnt = 'FALSE')  OR  (TRUNC(EO_PROVISION.FECHA_EJECUCION) > TRUNC(SYSDATE))) THEN
            --    LO_MOVIM.IND_BLOQUEO := 1;
            --    LO_MOVIM.COD_ESTADO := CN_EstPendActivacion;  -- Estado 9.-
            --    LO_MOVIM.DES_RESPUESTA := 'PENDIENTE DE ACTIVACION';
            --ELSE
                LO_MOVIM.IND_BLOQUEO := 0;
            --END IF;


            IF EO_PROVISION_TMP.NOM_USUARORA IS NULL THEN
               LO_MOVIM.NOM_USUARORA := USER;
            ELSE
               LO_MOVIM.NOM_USUARORA := EO_PROVISION_TMP.NOM_USUARORA;
            END IF;
           LO_MOVIM.FEC_INGRESO := SYSDATE;
           LO_MOVIM.NUM_INTENTOS := 0;
           --LO_MOVIM.COD_ACTABO := 'XX'; -- se obtiene por configuracion.-


           LV_Sql := ' IC_OBTIENE_ACTUACION_PR ( EO_PROVISION_TMP, '||LO_MOVIM.COD_ESPEC_PROV||', '||LO_MOVIM.COD_ACTUACION||', '||LO_MOVIM.IND_BAJATRANS||' )';
           IC_OBTIENE_ACTUACION_PR ( EO_PROVISION_TMP, LO_MOVIM.COD_ESPEC_PROV, LO_MOVIM.COD_ACTUACION, LO_MOVIM.IND_BAJATRANS, LO_MOVIM.COD_ACTABO, SN_ERROR, SV_MENSAJE, SN_EVENTO );

           IF SN_ERROR != 0 THEN
                  SN_ERROR := 33;
               SV_MENSAJE := 'Fallo IC_OBTIENE_ACTUACION_PR';
             RAISE ERROR_CONTROLADO;
           END IF;

            -- Obtener IMSI e IMEI --
            LV_Sql := ' SELECT num_imei, num_serie';
            LV_Sql := LV_Sql || ' FROM   ga_abocel';
            LV_Sql := LV_Sql || ' WHERE  num_abonado = '||LO_MOVIM.NUM_ABONADO;
            LV_Sql := LV_Sql || ' UNION';
            LV_Sql := LV_Sql || ' SELECT num_imei, num_serie';
            LV_Sql := LV_Sql || ' FROM   ga_aboamist';
            LV_Sql := LV_Sql || ' WHERE  num_abonado = '||LO_MOVIM.NUM_ABONADO;
            BEGIN
                SELECT num_imei, num_serie
                INTO   LO_MOVIM.IMEI, LO_MOVIM.NUM_SERIE
                FROM   ga_abocel
                WHERE  num_abonado = LO_MOVIM.NUM_ABONADO
                UNION
                SELECT num_imei, num_serie
                FROM   ga_aboamist
                WHERE  num_abonado = LO_MOVIM.NUM_ABONADO;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    LO_MOVIM.IMEI := NULL;
            END;

            LV_Sql := 'SELECT FRECUPERSIMCARD_FN('||LO_MOVIM.NUM_SERIE||',''IMSI'') FROM DUAL';
            BEGIN
                SELECT FRECUPERSIMCARD_FN(LO_MOVIM.NUM_SERIE,'IMSI') INTO LO_MOVIM.IMSI FROM DUAL;
            EXCEPTION
                WHEN OTHERS THEN
                    LO_MOVIM.IMSI := NULL;
            END;

           -- Grabar el Movimiento --

           LV_Sql := ' IC_MOVIMIENTO_SP_PG.IC_INSERTA_MOV_PR( LO_MOVIM, SN_ERROR, SV_MENSAJE, SN_EVENTO )';

           IC_MOVIMIENTO_SP_PG.IC_INSERTA_MOV_PR( LO_MOVIM, SN_ERROR, SV_MENSAJE, SN_EVENTO );

           IF SN_ERROR != 0 THEN
                  SN_ERROR := 775;
               SV_MENSAJE := 'Fallo IC_MOVIMIENTO_SP_PG';
             RAISE ERROR_CONTROLADO;
           END IF;


           -- Grabar Dependencia de Movimiento.-

           IF (LV_HayAnt = 'FALSE') THEN  --Si el mov anterior no está en tablas.-

            -- LV_Sql := 'IC_DEPENDENCIA_SP_PG.IC_INSERTA_DEPENDENCIA_PR('||LO_MOVIM.NUM_MOVIMIENTO||', '||EO_PROVISION_TMP.NUM_MOVANT||')';
                -- IC_DEPENDENCIA_SP_PG.IC_INSERTA_DEPENDENCIA_PR(LO_MOVIM.NUM_MOVIMIENTO, EO_PROVISION_TMP.NUM_MOVANT, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                LV_Sql := 'IC_DEPENDENCIA_SP_PG.IC_INSERTA_DEPENDENCIA_PR('||LO_MOVIM.NUM_MOVIMIENTO||', '||LN_NUM_MOVANT||')';
                IC_DEPENDENCIA_SP_PG.IC_INSERTA_DEPENDENCIA_PR(LO_MOVIM.NUM_MOVIMIENTO, LN_NUM_MOVANT, SN_ERROR, SV_MENSAJE, SN_EVENTO );



                IF SN_ERROR != 0 THEN
                   RAISE ERROR_CONTROLADO;
                END IF;
           END IF;


           -- Grabar Movimiento Programado.-

           IF (TRUNC(EO_PROVISION.FECHA_EJECUCION) > TRUNC(SYSDATE)) THEN

                LV_Sql := 'IC_PROGRAMACION_SP_PG.IC_INSERTA_PROGRAMADO_PR('||LO_MOVIM.NUM_MOVIMIENTO||', '||EO_PROVISION.FECHA_EJECUCION||')';
                IC_PROGRAMACION_SP_PG.IC_INSERTA_PROGRAMADO_PR(LO_MOVIM.NUM_MOVIMIENTO, EO_PROVISION.FECHA_EJECUCION, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                IF SN_ERROR != 0 THEN
                   RAISE ERROR_CONTROLADO;
                END IF;
           END IF;


           -- Grabar ID de Transaccion -- Solo si es un ALTA marcado con ind_bajatrans = 0.-
           IF LO_MOVIM.IND_BAJATRANS = 0 THEN

                 LV_Sql := 'IC_SECTRANSACCION_SP_PG.IC_INSERTA_SEC_PR('||LO_MOVIM.COD_PROD_CONTRATADO||', '||LO_MOVIM.NUM_CELULAR||', '||LO_MOVIM.NUM_MOVIMIENTO||')';
               IC_SECTRANSACCION_SP_PG.IC_INSERTA_SEC_PR( LO_MOVIM.COD_PROD_CONTRATADO, LO_MOVIM.NUM_CELULAR, LO_MOVIM.NUM_MOVIMIENTO, SN_ERROR, SV_MENSAJE, SN_EVENTO );

               IF SN_ERROR != 0 THEN
                   SN_ERROR := 775;
                   SV_MENSAJE := 'Fallo IC_SECTRANSACCION_SP_PG';
                 RAISE ERROR_CONTROLADO;
               END IF;
           END IF;

           -- Inicio Incidencia 135552
           -- EN EL CASO DE UN ALTA DE PA, SE REGISTRA.-
           IF EO_PROVISION_TMP.TIP_ACCION = '1' THEN
               LV_Sql := 'SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR('||LO_MOVIM.NUM_ABONADO||','||LO_MOVIM.COD_PROD_CONTRATADO||','||LO_MOVIM.COD_ESPEC_PROV||')';
               SE_PROD_PROVISIONADO_TO_SP_PG.SE_GRABA_PA_PR(LO_MOVIM.NUM_ABONADO,LO_MOVIM.COD_PROD_CONTRATADO,LO_MOVIM.COD_ESPEC_PROV,SN_ERROR,SV_MENSAJE,SN_EVENTO);
               IF (SN_ERROR != 0) THEN
                  RAISE ERROR_CONTROLADO;
               END IF;
           ELSIF EO_PROVISION_TMP.TIP_ACCION = '2' THEN
                 DELETE FROM SE_PROD_PROVISIONADO_TO
                 WHERE num_abonado = LO_MOVIM.NUM_ABONADO
                 AND cod_prod_contratado = LO_MOVIM.COD_PROD_CONTRATADO;
           END IF;
           -- Fin Incidencia 135552

           -- Grabar Detalle del Movimiento --

           LV_Sql := ' IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO )';

           LO_DETMOV.NUM_MOVIMIENTO := LO_MOVIM.NUM_MOVIMIENTO;

           IF EO_PROVISION_TMP.COD_CLIENTE IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.COD_CLIENTE)) IS NOT NULL THEN
                   LO_DETMOV.NOM_SUBPARAMETRO := 'CLIENTE';
                   LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.COD_CLIENTE;

                   IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                   IF SN_ERROR != 0 THEN
                      SN_ERROR := 775;
                   SV_MENSAJE := 'Fallo [1] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                     RAISE ERROR_CONTROLADO;
                   END IF;
           END IF;

           IF EO_PROVISION_TMP.NUM_CELULAR IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.NUM_CELULAR)) IS NOT NULL THEN
                   LO_DETMOV.NOM_SUBPARAMETRO := 'CELULAR';
                   LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.NUM_CELULAR;

                   IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                   IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [2] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                     RAISE ERROR_CONTROLADO;
                   END IF;
           END IF;

           IF EO_PROVISION_TMP.ID_PLAN IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.ID_PLAN)) IS NOT NULL THEN
                   LO_DETMOV.NOM_SUBPARAMETRO := 'PLAN';
                   LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.ID_PLAN;

                   IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                   IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [3] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                     RAISE ERROR_CONTROLADO;
                   END IF;
           END IF;

           IF EO_PROVISION_TMP.IMPORTE IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.IMPORTE)) IS NOT NULL THEN
                    LO_DETMOV.NOM_SUBPARAMETRO := 'IMPORTE';
                    LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.IMPORTE;

                    IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                    IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [4] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                      RAISE ERROR_CONTROLADO;
                    END IF;
           END IF;

           IF EO_PROVISION_TMP.COD_MONEDA IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.COD_MONEDA)) IS NOT NULL THEN
                    LO_DETMOV.NOM_SUBPARAMETRO := 'MONEDA';
                    LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.COD_MONEDA;

                    IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                    IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [5] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                      RAISE ERROR_CONTROLADO;
                    END IF;
           END IF;

           IF EO_PROVISION_TMP.USUARIO IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.USUARIO)) IS NOT NULL THEN
                    LO_DETMOV.NOM_SUBPARAMETRO := 'USUARIO';
                    LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.USUARIO;

                    IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                    IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [6] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                      RAISE ERROR_CONTROLADO;
                    END IF;
           END IF;

           IF EO_PROVISION_TMP.COD_CAUSA IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.COD_CAUSA)) IS NOT NULL THEN
                    LO_DETMOV.NOM_SUBPARAMETRO := 'CAUSA';
                    LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.COD_CAUSA;

                    IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                    IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [7] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                      RAISE ERROR_CONTROLADO;
                    END IF;
           END IF;

           IF EO_PROVISION_TMP.MONTO_BONIF IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.MONTO_BONIF)) IS NOT NULL THEN
                    LO_DETMOV.NOM_SUBPARAMETRO := 'CANTBONO';
                    LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.MONTO_BONIF;

                    IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                    IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [8] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                      RAISE ERROR_CONTROLADO;
                    END IF;
           END IF;

           IF EO_PROVISION_TMP.TIPO_BONO IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.TIPO_BONO)) IS NOT NULL THEN
                    LO_DETMOV.NOM_SUBPARAMETRO := 'TIPBONO';
                    LO_DETMOV.VAL_SUBPARAMETRO := EO_PROVISION_TMP.TIPO_BONO;

                    IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                    IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [9] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                      RAISE ERROR_CONTROLADO;
                    END IF;
           END IF;


           -- Obtiene los codigos de periodicidad para Bonos en Dinero y SMS.-
           IF EO_PROVISION_TMP.TIPO_BONO IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.TIPO_BONO)) IS NOT NULL THEN

               IF EO_PROVISION_TMP.TIPO_BONO = 'SMS' OR EO_PROVISION_TMP.TIPO_BONO = 'MNT' THEN

                   IC_OBTIENE_CODPERIODICIDAD_PR (EO_PROVISION_TMP.NUM_ABONADO, LV_CodPerREC, LV_CodPerSMS, SN_ERROR, SV_MENSAJE, SN_EVENTO);
                   IF SN_ERROR != 0 THEN
                            SN_ERROR := 775;
                         SV_MENSAJE := 'Fallo [10] IC_OBTIENE_CODPERIODICIDAD_PR';
                         RAISE ERROR_CONTROLADO;
                   END IF;

                   IF EO_PROVISION_TMP.TIPO_BONO = 'MNT' THEN
                       IF LV_CodPerREC IS NOT NULL AND LENGTH(TRIM(LV_CodPerREC)) IS NOT NULL THEN
                                LO_DETMOV.NOM_SUBPARAMETRO := 'CODPER1_REC';
                                LO_DETMOV.VAL_SUBPARAMETRO := LV_CodPerREC;

                                IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                                IF SN_ERROR != 0 THEN
                                       SN_ERROR := 775;
                                    SV_MENSAJE := 'Fallo [10] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                                    RAISE ERROR_CONTROLADO;
                                END IF;
                       END IF;
                   END IF;

                   IF EO_PROVISION_TMP.TIPO_BONO = 'SMS' THEN
                       IF LV_CodPerSMS IS NOT NULL AND LENGTH(TRIM(LV_CodPerSMS)) IS NOT NULL THEN
                                LO_DETMOV.NOM_SUBPARAMETRO := 'CODPER2_SMS';
                                LO_DETMOV.VAL_SUBPARAMETRO := LV_CodPerSMS;

                                IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                                IF SN_ERROR != 0 THEN
                                    SN_ERROR := 775;
                                    SV_MENSAJE := 'Fallo [10] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                                    RAISE ERROR_CONTROLADO;
                                END IF;
                       END IF;
                   END IF;

               END IF;

           END IF;

           IF EO_PROVISION_TMP.FECHA_EJEC_BONO IS NOT NULL AND LENGTH(TRIM(EO_PROVISION_TMP.FECHA_EJEC_BONO)) IS NOT NULL THEN
                    LO_DETMOV.NOM_SUBPARAMETRO := 'FEC_EJEC';
                    LO_DETMOV.VAL_SUBPARAMETRO := TO_CHAR(EO_PROVISION_TMP.FECHA_EJEC_BONO, 'YYYYMMDD');

                    IC_DETALLEMOVIMIENTO_TO_SP_PG.IC_INSERTA_DETMOV_PR( LO_DETMOV, SN_ERROR, SV_MENSAJE, SN_EVENTO );

                    IF SN_ERROR != 0 THEN
                        SN_ERROR := 775;
                     SV_MENSAJE := 'Fallo [11] IC_DETALLEMOVIMIENTO_TO_SP_PG';
                      RAISE ERROR_CONTROLADO;
                    END IF;
           END IF;

           SV_MENSAJE := 'Movimiento Generado: '||LO_MOVIM.NUM_MOVIMIENTO;

   ELSE
        SN_ERROR   := 0;
        SV_MENSAJE := 'Tecnologia no es GSM';
        SN_EVENTO  := 0;
        RAISE ERROR_CONTROLADO;
   END IF;

EXCEPTION
    WHEN ERROR_CONTROLADO THEN
        LV_DES_ERROR := 'IC_PROVISION_VENTA_PG.IC_PROV_ABONADO_PR('||SV_MENSAJE||'['||SQLERRM||'])';
        IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
            SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
        END IF;
    SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_VENTA_PG.IC_PROV_ABONADO_PR', LV_Sql, SN_ERROR, LV_DES_ERROR );
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                LV_DES_ERROR := 'IC_PROVISION_VENTA_PG.IC_PROV_ABONADO_PR('||SQLERRM||')';
                SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO, CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_PROV_ABONADO_PR', LV_Sql, SN_ERROR, LV_DES_ERROR );
END IC_PROV_ABONADO_PR;

------------------------------------------------------------

PROCEDURE IC_OBTIENE_ACTUACION_PR ( EO_PROVISION IN OUT NOCOPY IC_PROVISION_QT,
                                                               SN_COD_ESPEC_PROV OUT NOCOPY NUMBER,
                                                               SV_COD_ACTUACION OUT NOCOPY VARCHAR2,
                                                               SV_IND_BAJATRANS OUT NOCOPY VARCHAR2,
                                                               SV_COD_ACTABO OUT NOCOPY VARCHAR2,
                                                               SN_ERROR OUT NOCOPY NUMBER,
                                                               SV_MENSAJE OUT NOCOPY VARCHAR2,
                                                               SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_OBTIENE_ACTUACION_PR"
      Lenguaje="PL/SQL"
      Fecha creación="11-10-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion="Carlos Sellao H"
      Modificado por="03-11-2008"
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Obtiene cod_espec_prov, cod_actuacion e ind_bajatrans para el movimiento a generar </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="SN_COD_ESPEC_PROV"       Tipo="NUMERICO">Codigo Espec</param>
            <param nom="SV_COD_ACTUACION"      Tipo="CARACTER">Actuacion</param>
            <param nom="SV_IND_BAJATRANS"      Tipo="CARACTER">Ind. baja</param>
            <param nom="SV_COD_ACTABO"      Tipo="CARACTER">Cod. actabo</param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);

ERROR_CONTROLADO EXCEPTION;

BEGIN
        SN_ERROR := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO := 0;

        BEGIN
                LV_Sql := 'SELECT  COD_ESPEC_PROV';
                LV_Sql := LV_Sql || ' FROM  SE_DETALLE_PROVISIONAMIENTO_TD';
                LV_Sql := LV_Sql || ' WHERE COD_PROV_SERV = ' ||EO_PROVISION.COD_PROV_SERV;
                LV_Sql := LV_Sql || ' AND     TIPO_ACCION = ' ||EO_PROVISION.TIP_ACCION;
                LV_Sql := LV_Sql || ' AND     TIPO_SER = ' ||EO_PROVISION.TIP_SER;

                SELECT  COD_ESPEC_PROV
                INTO    SN_COD_ESPEC_PROV
                FROM   SE_DETALLE_PROVISIONAMIENTO_TD
                WHERE COD_PROV_SERV = EO_PROVISION.COD_PROV_SERV
                AND     TIPO_ACCION = EO_PROVISION.TIP_ACCION
                AND     IND_TIPO_SERVICIO = EO_PROVISION.TIP_SER;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        SN_ERROR := 1004;
                        SV_MENSAJE := 'No se ha podido recuperar datos de Detalle Provisionamiento';
                        RAISE ERROR_CONTROLADO;
        END;

        BEGIN

                LV_Sql := ' SELECT COD_ACTUACION, IND_BAJATRANS';
                LV_Sql := LV_Sql || ' INTO   SV_COD_ACTUACION, SV_IND_BAJATRANS';
                LV_Sql := LV_Sql || ' FROM  SE_ESPEC_PROVISIONAMIENTO_TD';
                LV_Sql := LV_Sql || ' WHERE COD_ESPEC_PROV = ' ||SN_COD_ESPEC_PROV;

                SELECT COD_ACTUACION, IND_BAJATRANS
                INTO   SV_COD_ACTUACION, SV_IND_BAJATRANS
                FROM  SE_ESPEC_PROVISIONAMIENTO_TD
                WHERE COD_ESPEC_PROV = SN_COD_ESPEC_PROV;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        SN_ERROR := 1005;
                        SV_MENSAJE := 'No se ha podido recuperar datos de Especificacion Provisionamiento';
                        RAISE ERROR_CONTROLADO;
        END;

        -- Obtiene un actabo para la actuacion en Centrales.-
        BEGIN

                LV_Sql := ' SELECT val_parametro INTO SV_COD_ACTABO';
                LV_Sql := LV_Sql || ' FROM  ged_parametros';
                LV_Sql := LV_Sql || ' WHERE nom_parametro = ''ACT_''' ||TO_CHAR(SV_COD_ACTUACION);
                LV_Sql := LV_Sql || ' AND cod_modulo' || CV_cod_moduloIC;
                LV_Sql := LV_Sql || ' AND cod_producto = ' || TO_CHAR(CN_cod_producto);

                SELECT val_parametro
                INTO   SV_COD_ACTABO
                FROM  ged_parametros
                WHERE nom_parametro = 'ACT_' || TO_CHAR(SV_COD_ACTUACION)
                AND cod_modulo = CV_cod_moduloIC
                AND cod_producto = CN_cod_producto;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                   -- Obtiene un actabo por defecto.-
                   BEGIN

                       LV_Sql := ' SELECT val_parametro INTO SV_COD_ACTABO';
                       LV_Sql := LV_Sql || ' FROM  ged_parametros';
                       LV_Sql := LV_Sql || ' WHERE nom_parametro = ' || CV_param_actabodef;
                       LV_Sql := LV_Sql || ' AND cod_modulo' || CV_cod_moduloIC;
                       LV_Sql := LV_Sql || ' AND cod_producto = ' || TO_CHAR(CN_cod_producto);

                       SELECT val_parametro
                       INTO SV_COD_ACTABO
                       FROM ged_parametros
                       WHERE nom_parametro = CV_param_actabodef
                       AND cod_modulo = CV_cod_moduloIC
                       AND cod_producto = CN_cod_producto;
                   EXCEPTION
                      WHEN OTHERS THEN
                        SN_ERROR := 1005;
                        SV_MENSAJE := 'No se ha podido recuperar datos de Especificacion Provisionamiento';
                        RAISE ERROR_CONTROLADO;
                   END;
        END;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
           IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
              SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
           END IF;
           SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_VENTA_PG.IC_OBTIENE_ACTUACION_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO, CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_OBTIENE_ACTUACION_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_OBTIENE_ACTUACION_PR;


--------------------------------------------------
PROCEDURE IC_OBTIENE_CODPERIODICIDAD_PR ( EN_NUM_ABONADO IN NUMBER,
                                          SV_COD_PER_REC OUT NOCOPY VARCHAR2,
                                          SV_COD_PER_SMS OUT NOCOPY VARCHAR2,
                                          SN_ERROR OUT NOCOPY NUMBER,
                                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                                          SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_OBTIENE_CODPERIODICIDAD_PR"
      Lenguaje="PL/SQL"
      Fecha creación="01-02-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Obtiene cod_espec_prov, cod_actuacion e ind_bajatrans para el movimiento a generar </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NUM_ABONADO"         Tipo="NUMERICO"> Numero de Abonado </param>
         </Entrada>
         <Salida>
            <param nom="SN_COD_PER_REC"       Tipo="CARACTER">Codigo de periodicidad para Recarga en dinero</param>
            <param nom="SN_COD_PER_SMS"       Tipo="CARACTER">Codigo de periodicidad para Recarga en SNS</param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);
LV_nomciclo  ged_parametros.nom_parametro%TYPE;
LN_cod_ciclo ga_abocel.cod_ciclo%TYPE;
ERROR_CONTROLADO EXCEPTION;

BEGIN
        SN_ERROR := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO := 0;

        BEGIN
                LV_Sql := 'SELECT abo.cod_ciclo';
                LV_Sql := LV_Sql||' INTO LN_cod_ciclo';
                LV_Sql := LV_Sql||' FROM ga_abocel abo';
                LV_Sql := LV_Sql||' WHERE abo.num_abonado = '||EN_NUM_ABONADO;

                SELECT  abo.cod_ciclo
                INTO    LN_cod_ciclo
                FROM    ga_abocel abo
                WHERE   abo.num_abonado = EN_NUM_ABONADO;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        BEGIN
                                LV_Sql := 'SELECT abo.cod_ciclo';
                                LV_Sql := LV_Sql||' INTO LN_cod_ciclo';
                                LV_Sql := LV_Sql||' FROM ga_aboamist abo';
                                LV_Sql := LV_Sql||' WHERE abo.num_abonado = '||EN_NUM_ABONADO;

                                SELECT  abo.cod_ciclo
                                INTO    LN_cod_ciclo
                                FROM    ga_aboamist abo
                                WHERE   abo.num_abonado = EN_NUM_ABONADO;
                        EXCEPTION
                                WHEN OTHERS THEN
                                    SN_ERROR := 1004;
                                    SV_MENSAJE := 'No se ha podido recuperar datos de Detalle Provisionamiento';
                                    RAISE ERROR_CONTROLADO;
                        END;

                WHEN OTHERS THEN
                        SN_ERROR := 1004;
                        SV_MENSAJE := 'No se ha podido recuperar datos de Detalle Provisionamiento';
                        RAISE ERROR_CONTROLADO;
        END;

        LV_nomciclo := 'PERCICLO_'||TO_CHAR(LN_cod_ciclo);

        IC_CODPERIODICIDAD_PR( LV_nomciclo, 1, SV_COD_PER_REC, SN_ERROR, SV_MENSAJE, SN_EVENTO);
        IF SN_ERROR != 0 THEN
                SN_ERROR := 775;
             SV_MENSAJE := 'Fallo [10] IC_CODPERIODICIDAD_PR';
             RAISE ERROR_CONTROLADO;
        END IF;

        IC_CODPERIODICIDAD_PR( LV_nomciclo, 2, SV_COD_PER_SMS, SN_ERROR, SV_MENSAJE, SN_EVENTO);
        IF SN_ERROR != 0 THEN
                SN_ERROR := 775;
             SV_MENSAJE := 'Fallo [10] IC_CODPERIODICIDAD_PR';
             RAISE ERROR_CONTROLADO;
        END IF;


EXCEPTION
        WHEN ERROR_CONTROLADO THEN
           IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
              SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
           END IF;
           SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_VENTA_PG.IC_OBTIENE_CODPERIODICIDAD_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO, CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_OBTIENE_CODPERIODICIDAD_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_OBTIENE_CODPERIODICIDAD_PR;




PROCEDURE IC_CODPERIODICIDAD_PR ( EN_NOM_CICLO IN VARCHAR2,
                                  EN_FILA      IN NUMBER,
                                  SV_CODPER OUT NOCOPY VARCHAR2,
                                  SN_ERROR OUT NOCOPY NUMBER,
                                  SV_MENSAJE OUT NOCOPY VARCHAR2,
                                  SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_CODPERIODICIDAD_PR"
      Lenguaje="PL/SQL"
      Fecha creación="01-02-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Obtiene el codigo de periodicidad configurado para el ciclo de facturacion </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_NOM_CICLO"       Tipo="VARCHAR2">Nemotecnico que identifica al ciclo de facturacion</param>
            <param nom="EN_FILA"            Tipo="NUMERICO">numero de fila en la configuracion</param>
         </Entrada>
         <Salida>
            <param nom="SV_CODPER"      Tipo="CARACTER">Codigo de periodicidad</param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);
LV_cadena ged_parametros.val_parametro%TYPE;
ERROR_CONTROLADO EXCEPTION;

BEGIN

        SN_ERROR := 0;
        SV_MENSAJE := NULL;
        SN_EVENTO := 0;

        LV_Sql := 'SELECT TRIM(valor_texto) INTO  LV_cadena';
        LV_Sql := LV_Sql || ' FROM (SELECT ROWNUM ROWNUMP, VALOR_TEXTO';
        LV_Sql := LV_Sql || '       FROM IC_PARAMETROS_MULTIPLES_VW';
        LV_Sql := LV_Sql || '       WHERE COD_MODULO = '''|| CV_cod_moduloIC ||'''';
        LV_Sql := LV_Sql || '         AND NOM_PARAMETRO = '''|| EN_nom_ciclo ||'''';
        LV_Sql := LV_Sql || '      )';
        LV_Sql := LV_Sql || ' WHERE ROWNUMP = '|| TO_CHAR(EN_fila);

        SELECT TRIM(valor_texto)
        INTO  LV_cadena
        FROM(
              SELECT ROWNUM ROWNUMP, VALOR_TEXTO
                FROM IC_PARAMETROS_MULTIPLES_VW
               WHERE COD_MODULO = CV_cod_moduloIC
                 AND NOM_PARAMETRO = EN_nom_ciclo
            )
        WHERE ROWNUMP=EN_fila;

        IF LENGTH(LV_cadena) = 0 THEN
                LV_cadena := 'FALSE:SIN VALORES';
        END IF;

        SV_CODPER := LV_cadena;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
           IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
              SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
           END IF;
           SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_VENTA_PG.IC_CODPERIODICIDAD_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := Ge_Errores_Pg.GrabarPL(SN_EVENTO, CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_CODPERIODICIDAD_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_CODPERIODICIDAD_PR;

------------------------------------------------------------
PROCEDURE IC_ELIMINA_PR ( EO_PROVISION IN IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_INSERTA_PR"
      Lenguaje="PL/SQL"
      Fecha creación="03-11-2008"
      Creado por="Carlos Sellao H."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción> Genera un nuevo Movimiento con los datos ingresados </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type </param>
         </Entrada>
         <Salida>
            <param nom="EO_PROVISION"         Tipo="OBJETO"> Object Type de la tabla ICC_MOVIMIENTO </param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="CARACTER">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(1000);
LN_total          number:=0;
LN_Indice         number;
EO_PROVISION_TMP IC_PROVISION_QT := EO_PROVISION;
LN_MOVIMIENTO icc_movimiento.num_movimiento%TYPE;
LC_MOVIMIENTOS refcursor;

ERROR_CONTROLADO EXCEPTION;

BEGIN
   SN_ERROR := 0;
   SV_MENSAJE := NULL;
   SN_EVENTO := 0;


    -- Validaciones previas.-
    IF EO_PROVISION_TMP.COD_PROD_CONTRAT = 0 OR EO_PROVISION_TMP.COD_PROD_CONTRAT IS NULL  THEN
           SN_ERROR := 1424;
           SV_MENSAJE := 'Falta Parametro de Producto Contratado';
           RAISE ERROR_CONTROLADO;
    END IF;

    LV_Sql := 'SELECT NUM_MOVIMIENTO';
    LV_Sql := LV_Sql || ' FROM ICC_MOVIMIENTO';
    LV_Sql := LV_Sql || ' WHERE COD_PROD_CONTRATADO = '|| EO_PROVISION_TMP.COD_PROD_CONTRAT;

    OPEN LC_MOVIMIENTOS FOR
    SELECT num_movimiento
    FROM icc_movimiento
    WHERE cod_prod_contratado = EO_PROVISION_TMP.COD_PROD_CONTRAT;

    LOOP
        FETCH LC_MOVIMIENTOS INTO LN_MOVIMIENTO;

        EXIT WHEN LC_MOVIMIENTOS%NOTFOUND;

        LV_Sql:= 'DELETE ic_sectransaccion_to WHERE num_mov_origen = '||LN_MOVIMIENTO;

        DELETE ic_sectransaccion_to
        WHERE num_mov_origen = LN_MOVIMIENTO;

        LV_Sql:= 'DELETE ic_detalle_movimiento_to WHERE num_movimiento = '||LN_MOVIMIENTO;

        DELETE ic_detalle_movimiento_to
        WHERE num_movimiento = LN_MOVIMIENTO;

        LV_Sql:= 'DELETE ic_programacion_movimiento_to WHERE num_movimiento = '||LN_MOVIMIENTO;

        DELETE ic_programacion_movimiento_to
        WHERE num_movimiento = LN_MOVIMIENTO;

        LV_Sql:= 'DELETE ic_movimiento_dependiente_to WHERE num_movimiento = '||LN_MOVIMIENTO;

        DELETE ic_movimiento_dependiente_to
        WHERE num_movimiento = LN_MOVIMIENTO;

        LV_Sql:= 'DELETE icc_movimiento WHERE num_movimiento = '||LN_MOVIMIENTO;

        DELETE icc_movimiento
        WHERE num_movimiento = LN_MOVIMIENTO;
    END LOOP;

EXCEPTION
        WHEN ERROR_CONTROLADO THEN
           IF NOT Ge_Errores_Pg.MensajeError(SN_ERROR,SV_MENSAJE) THEN
              SV_MENSAJE := CV_error_no_clasif||' ( '||SV_MENSAJE||' )';
           END IF;
           SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SN_ERROR || ' ' || SV_MENSAJE, CV_version, USER, 'IC_PROVISION_VENTA_PG.IC_ELIMINA_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
        WHEN OTHERS THEN
                SN_ERROR := SQLCODE;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := Ge_Errores_Pg.GrabarPL( SN_EVENTO, CV_cod_modulo, SQLERRM, CV_version,USER, 'IC_PROVISION_VENTA_PG.IC_ELIMINA_PR', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_ELIMINA_PR;

END IC_PROVISION_VENTA_PG;
/
