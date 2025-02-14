CREATE OR REPLACE PROCEDURE CO_P_ARCHIVO_DICOM_TMC
(                 v_num_proceso     IN NUMBER
                  ,v_cod_proceso        IN VARCHAR2
                  ,v_numident           IN VARCHAR2
                  ,v_tipident           IN VARCHAR2
                  ,v_entidad            IN VARCHAR2
                  ,v_envio              IN VARCHAR2
                  ,v_usuario            IN VARCHAR2
                  ,v_mto_deuda_ant      IN NUMBER
                  ,v_mto_vencido        IN NUMBER
) IS

/*    Funcion        :Genera Registros en Formato DICOM TMC                                                             */
/*    Autor          :Ricardo Salazar                                                                                                   */
/*    Fecha          :30/05/2002                                                                                                                */
/*    Modificaciones :31/05/2002 (rmaturan)                                                                                             */
/*                      Manejo de exception para el PL                                                                  */
/*                   :11/06/2002 (Modesto Aranda)                                                                               */
/*                      se agrego caracter '#', el cual permite distinguir el fin de la */
/*                      cadena en  el  programa dicom.pc                                                                */
/*                   :26/06/2002 (Modesto Aranda)                                                                       */
/*                      Se elimina COMMIT y se mueve UPDATE que cambia estado de EP a SM*/
/*                   :08/07/2002 (Modesto Aranda)                                                                               */
/*                      Inicializacion variable  v_deuda_total                                                  */
/*                                       :12/07/2002 (Modesto Aranda)                                                                           */
/*                                          - Control de numero de decimales (segun operadora)                          */
/*                                          - Se utilizaran numeros en vez de letras para identificar el        */
/*                                                tipo de registro      (encabezado, detalle y pie)                             */
/*                                       :08/08/2002 (Modesto Aranda)                                                                           */
/*                                          - Reemplazo del cod_tip_docum por tip_transac                                       */
/*                                       :26/10/2002 (Modesto Aranda)                                                                           */
/*                                          - Se reemplazo el segundo NOM_APECLIEN1 por NOM_APECLIEN2           */
/*                        ya que figuraba dos veces el NOM_APECLIEN1                    */
/*                                        :15/01/2003 (Modesto Aranda)                                                                          */
/*                                              - Es reemplazado el Campo CNT_RUTS por CNT_NUM_IDENT                    */
/*                                          - Se agrego la acutializacion del campo IND_INFORMADO               */
/*    Ult.Paso Pruduc:23/10/2002 (TMC -->Produccion)                                                                    */
/*                   :12/06/2002 (DEIMOS)                                                                                               */
/*                    15/07/2002 (HELENA --> Puerto Rico)                                                               */

v_stg_general     VARCHAR2(1024);
v_stg_general2    VARCHAR2(1024);
v_stg_general3    VARCHAR2(1024);
v_reg_buenos      CO_ARCHIVOS.REG_BUENOS%TYPE;
v_mto_envio       CO_COBEXENV.MTO_ENVIO%TYPE;
v_cant_ruts       CO_COBEXENV.CNT_NUM_IDENT%TYPE;
v_deuda_total     CO_CARTERA.IMPORTE_DEBE%TYPE;
v_nom_archivo     CO_ARCHIVOS.NOM_ARCHIVO%TYPE;
v_total_reg       CO_ARCHIVOS.TOT_REGISTROS%TYPE;
v_stg_titulo      VARCHAR2(1024);
v_stg_titulo2     VARCHAR2(1024);
v_titulos_direc   VARCHAR2(1024);
v_exis_mto_buenos CO_ARCHIVOS.MTO_BUENOS%TYPE;
v_exis_reg_buenos CO_ARCHIVOS.REG_BUENOS%TYPE;
v_exis_total_reg  CO_ARCHIVOS.TOT_REGISTROS%TYPE;
szhNumIdentAux     GE_CLIENTES.NUM_IDENT%TYPE;
szhDigVer          GE_CLIENTES.NUM_IDENT%TYPE;
szhNomCliente      VARCHAR2(90);
ihTipCalle         NUMBER;
szhNomCalle        GE_DIRECCIONES.NOM_CALLE%TYPE;
szhNumCalle        GE_DIRECCIONES.NUM_CALLE%TYPE;
szhNroPiso         GE_DIRECCIONES.NUM_PISO%TYPE;
ihIndDpto          NUMBER;
ihTipDomic         NUMBER;
szhDesComuna       GE_COMUNAS.DES_COMUNA%TYPE;
szhDesCiudad       GE_CIUDADES.DES_CIUDAD%TYPE;
lhDirPostal        NUMBER;
szhTelContacto     GA_CUENTAS.TEL_CONTACTO%TYPE;
szhTipDocum        VARCHAR2(2);
szhTipMoneda       VARCHAR2(1);
szhTipDeudor       VARCHAR2(1);
szhRutDeuDirec     NUMBER;
szhDigDeuDirec     NUMBER;
szhTipTransac      VARCHAR2(1);
szhNumFolio        CO_DICOMDOC.NUM_FOLIO%TYPE;
dhImpDeuda         CO_DICOMDOC.IMPORTE_DEBE%TYPE;
szhFecVencimie     VARCHAR2(8);
ihTieneDoc         NUMBER := 0;
v_fin              CHAR(1):='#';
iDecimal           NUMBER(2):=0;--Decimales por Operadora.

 CURSOR C1(p1 VARCHAR2,p2 VARCHAR2) IS
       SELECT COD_CLIENTE
       FROM GE_CLIENTES
       WHERE COD_TIPIDENT = p1
       AND  NUM_IDENT = ltrim(rtrim(p2));

 C1_CLIENTE             C1%ROWTYPE;

  CURSOR C2(p3 NUMBER) IS
        SELECT  '1' TIP_TRANSAC,
                                RPAD(TO_CHAR(NUM_FOLIO), 16, ' ' ) NUM_FOLIO,
                                NVL(IMPORTE_DEBE, 0) IMPORTE_DEBE,
                                TO_CHAR( FEC_VENCIMIE, 'YYYYMMDD') FEC_VENCIMIE
                        FROM    CO_DICOMDOC
                        WHERE   NUM_IDENT               = v_numident
                        AND             COD_TIPIDENT    = v_tipident
                        AND             COD_CLIENTE     = p3
                        AND             NUM_PROCESO     = v_num_proceso
                UNION ALL
                SELECT  '2' TIP_TRANSAC,
                                RPAD(TO_CHAR(NUM_FOLIO), 16, ' ' ),
                        NVL(IMPORTE_DEBE, 0),
                        TO_CHAR( FEC_VENCIMIE, 'YYYYMMDD')
                        FROM    CO_HDICOMDOC
                        WHERE   NUM_IDENT               = v_numident
                        AND             COD_TIPIDENT    = v_tipident
                        AND             COD_CLIENTE     = p3
                        AND             NUM_PROCESO     = v_num_proceso;

  C2_DOCUM              C2%ROWTYPE;

BEGIN
    v_deuda_total := 0;
    v_total_reg :=0;
        /* Obtine la cantidad de decimales a utilizar */
    SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
    FROM   DUAL;
    v_nom_archivo:=v_cod_proceso||'_'||v_num_proceso||'.'||'txt';
        FOR C1_CLIENTE IN C1(v_tipident,v_numident) LOOP
            v_deuda_total := 0;
                v_reg_buenos:= 0;
                FOR C2_DOCUM IN C2(C1_CLIENTE.COD_CLIENTE) LOOP
            ihTieneDoc:=1;
                    v_total_reg := v_total_reg + 1;

                        szhTipTransac :=C2_DOCUM.TIP_TRANSAC;
                        szhNumFolio   :=C2_DOCUM.NUM_FOLIO;
                        dhImpDeuda    :=C2_DOCUM.IMPORTE_DEBE;
                        szhFecVencimie:=C2_DOCUM.FEC_VENCIMIE;

                        BEGIN
                              SELECT
                            LPAD(SUBSTR(REPLACE(GC.NUM_IDENT,'-',''),1,LENGTH(REPLACE(GC.NUM_IDENT,'-',''))-1),9,'0')
                                        ,       LPAD( SUBSTR( GC.NUM_IDENT, LENGTH( RTRIM( GC.NUM_IDENT) ), 1 ), 1, ' ')
                                        ,       RPAD(NVL(LTRIM(GC.NOM_APECLIEN1),' '),20,' ')||RPAD(NVL(LTRIM(GC.NOM_APECLIEN2),' '),20,' ')||RPAD(NVL(LTRIM(GC.NOM_CLIENTE),' '),40,' ')
                        ,   1                                                       /* TIPO CALLE */
                        ,       RPAD( NVL( RTRIM( G1.NOM_CALLE ),' '), 40, ' ')
                        ,       RPAD( NVL( RTRIM( G1.NUM_CALLE ),' '), 6, ' ')
                        ,       RPAD( NVL( RTRIM( G1.NUM_PISO ),' '), 5, ' ')
                                        ,   1                                                                                                           /* IND DPTO, LOCAL U OF.        */
                        ,   1                                                       /* TIPO DOMICILIO                   */
                        ,       RPAD( NVL( RTRIM( G5.DES_COMUNA ),' '), 20, ' ')
                        ,       RPAD( NVL( RTRIM( G4.DES_CIUDAD ),' '), 20, ' ')
                                        ,   0                                                                                                           /* CODIGO POSTAL */
                                        ,       RPAD( NVL( GA.TEL_CONTACTO, ' ' ), 12, ' ' )
                                        ,       'FA'
                                        ,       '$'
                                        ,       ' '
                                        ,       '000000000'
                                        ,       '0'
                                INTO
                                    szhNumIdentAux,
                                    szhDigVer,
                        szhNomCliente,
                        ihTipCalle,
                        szhNomCalle,
                        szhNumCalle,
                        szhNroPiso,
                                        ihIndDpto,
                                        ihTipDomic,
                        szhDesComuna,
                        szhDesCiudad,
                        lhDirPostal,
                        szhTelContacto,
                        szhTipDocum,
                        szhTipMoneda,
                        szhTipDeudor,
                        szhRutDeuDirec,
                        szhDigDeuDirec
                    FROM   GE_COMUNAS           G5
                         , GE_CIUDADES          G4
                         , GE_PROVINCIAS        G3
                         , GE_REGIONES          G2
                         , GE_DIRECCIONES   G1
                         , GA_DIRECCLI          G0
                         , GA_CUENTAS           GA
                         , GE_CLIENTES          GC
                    WHERE  GC.COD_CLIENTE               = C1_CLIENTE.COD_CLIENTE
                    AND    GA.COD_CUENTA                = GC.COD_CUENTA
                    AND    G0.COD_CLIENTE               = GC.COD_CLIENTE
                    AND    G0.COD_TIPDIRECCION  = 3
                    AND    G0.COD_DIRECCION             = G1.COD_DIRECCION
                    AND    G2.COD_REGION        = G1.COD_REGION
                    AND    G3.COD_REGION        = G1.COD_REGION
                    AND    G3.COD_PROVINCIA     = G1.COD_PROVINCIA
                    AND    G4.COD_REGION        = G1.COD_REGION
                    AND    G4.COD_PROVINCIA     = G1.COD_PROVINCIA
                    AND    G4.COD_CIUDAD        = G1.COD_CIUDAD
                    AND    G5.COD_REGION        = G1.COD_REGION
                    AND    G5.COD_PROVINCIA     = G1.COD_PROVINCIA
                    AND    G5.COD_COMUNA        = G1.COD_COMUNA;

            EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                     szhNomCliente:= null;
                        END;

                        v_stg_titulo:= 'SICOM'||'096786140'||5||lpad(v_reg_buenos,12,'0')||lpad(GE_PAC_GENERAL.REDONDEA(v_deuda_total, iDecimal, 0),18,'0');
            v_stg_titulo2:=     lpad(0,2,'0')||'I'||rpad(' ',216,' ')||v_fin;

                        v_stg_general:= 611681||lpad(szhNumIdentAux,9,' ')||rpad(szhDigVer,1,'0')||rpad(szhFecVencimie,8,' ')||rpad(szhNumFolio,16,' ');
                        v_stg_general:= v_stg_general||rpad(szhTipTransac,1,' ')||szhNomCliente||lpad(ihTipCalle,2,'0')||rpad(szhNomCalle,40,' ');

        --              DBMS_OUTPUT.PUT_LINE('v_stg_general   '||v_stg_general);

                        v_stg_general2:= rpad(szhNumCalle,6,' ')||rpad(szhNroPiso,5,' ')||lpad(ihIndDpto,1,'0')||lpad(ihTipDomic,1,'0');
                        v_stg_general2:= v_stg_general2||rpad(szhDesComuna,20,' ')||rpad(szhDesCiudad,20,' ')||lpad(lhDirPostal,7,'0')||rpad(szhTelContacto,12,' ');

                        --DBMS_OUTPUT.PUT_LINE('v_stg_general2: '||v_stg_general2);

                        v_stg_general3:= rpad(szhTipDocum,2,' ')||rpad(szhTipMoneda,2,' ')||lpad(GE_PAC_GENERAL.REDONDEA(dhImpDeuda, iDecimal, 0),12,'0')||lpad(0,2,'0');
                        v_stg_general3:= v_stg_general3||rpad(szhTipDeudor,1,' ')||rpad(szhRutDeuDirec,9,'0')||rpad(szhDigDeuDirec,1,'0')||v_fin;


                    INSERT INTO CO_DET_ARCHIVOS (NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO)
                        VALUES (v_num_proceso,v_cod_proceso,v_entidad,'2',v_stg_general||v_stg_general2||v_stg_general3);

                        v_deuda_total := v_deuda_total + dhImpDeuda;
                        v_reg_buenos:= v_reg_buenos + 1;
                END LOOP;
        BEGIN
                 UPDATE CO_DICOMDOC
                    SET IND_INFORMADO = 'S'
                  WHERE NUM_IDENT    = v_numident
                        AND COD_TIPIDENT = v_tipident
                        AND COD_CLIENTE  = C1_CLIENTE.COD_CLIENTE;
                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                       v_deuda_total := v_deuda_total ;
                END;
        END LOOP;

        if ihTieneDoc = 1 then
                BEGIN
                    SELECT MTO_BUENOS,REG_BUENOS,TOT_REGISTROS
                        INTO v_exis_mto_buenos,v_exis_reg_buenos,v_exis_total_reg
                        FROM CO_ARCHIVOS
                        WHERE NUM_PROCESO = v_num_proceso
                        AND COD_PROCESO = v_cod_proceso
                        AND NOM_ARCHIVO = v_nom_archivo;

                        EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                    v_exis_reg_buenos:= NULL;
                END;
                IF v_exis_mto_buenos IS NULL THEN
                   --insert co_archivos
                   INSERT INTO CO_ARCHIVOS(NUM_PROCESO, COD_PROCESO, FEC_PROCESO, COD_ENTIDAD, NOM_ARCHIVO, TOT_REGISTROS,
                   REG_BUENOS, MTO_BUENOS, NOM_USUARIO)
                   VALUES(v_num_proceso,v_cod_proceso,SYSDATE,v_entidad,v_nom_archivo,v_total_reg,v_reg_buenos,v_deuda_total,v_usuario);

                        INSERT INTO CO_DET_ARCHIVOS (NUM_PROCESO, COD_PROCESO, COD_ENTIDAD, TIP_REGITRO, TXT_REGISTRO)
                        VALUES (v_num_proceso,v_cod_proceso,v_entidad,'1',v_stg_titulo||v_stg_titulo2);

                ELSE
                   v_exis_mto_buenos:=v_deuda_total + v_exis_mto_buenos;
                   v_exis_reg_buenos:=v_exis_reg_buenos+v_reg_buenos;
               v_exis_total_reg:=v_exis_total_reg+v_total_reg;
               --update a la tabla co_archivos
                   UPDATE CO_ARCHIVOS SET
                   MTO_BUENOS = v_exis_mto_buenos,
                   REG_BUENOS = v_exis_reg_buenos,
                   TOT_REGISTROS = v_exis_total_reg
                   WHERE NUM_PROCESO = v_num_proceso
                   AND COD_PROCESO = v_cod_proceso
                   AND NOM_ARCHIVO = v_nom_archivo;

                   v_stg_titulo:= 'SICOM'||'096786140'||5||lpad(v_reg_buenos,12,'0')||lpad(GE_PAC_GENERAL.REDONDEA(v_exis_mto_buenos, iDecimal, 0),18,'0');
               v_stg_titulo2:=  lpad(0,2,'0')||'I'||rpad(' ',216,' ')||v_fin;

                   UPDATE CO_DET_ARCHIVOS SET
                   TXT_REGISTRO = v_stg_titulo||v_stg_titulo2
                   WHERE NUM_PROCESO = v_num_proceso
                   AND COD_PROCESO = v_cod_proceso
                   AND COD_ENTIDAD = v_entidad
                   AND TIP_REGITRO = '1';

                END IF;

                BEGIN
                        SELECT CNT_NUM_IDENT+1,MTO_ENVIO
                        INTO v_cant_ruts,v_mto_envio
                        FROM CO_COBEXENV
                    WHERE NUM_PROCESO = v_num_proceso
                        AND COD_ENTIDAD = v_entidad
                        AND COD_ENVIO = v_envio;

                        EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                    v_mto_envio:= NULL;
                                v_cant_ruts:=1;
                END;

                IF v_mto_envio IS NULL THEN
                   v_mto_envio:=v_deuda_total - v_mto_deuda_ant;

                   INSERT INTO CO_COBEXENV(NUM_PROCESO, COD_ENTIDAD, COD_ENVIO, CNT_NUM_IDENT, MTO_ENVIO)
                   VALUES(v_num_proceso,v_entidad,v_envio,v_cant_ruts,v_mto_envio);
                ELSE
                   v_mto_envio:=v_mto_envio + (v_deuda_total - v_mto_deuda_ant);
                   UPDATE CO_COBEXENV SET
                   CNT_NUM_IDENT = v_cant_ruts,
                   MTO_ENVIO = v_mto_envio
               WHERE NUM_PROCESO = v_num_proceso
               AND COD_ENTIDAD = v_entidad
                   AND COD_ENVIO = v_envio;
                END IF;

     END IF;

    UPDATE      CO_DICOM
        SET     COD_ENVIO = v_envio,
                        COD_MOVIMIENTO = 'SM',
                        FEC_MOVIMIENTO = SYSDATE,
                        NUM_PROCESO = v_num_proceso,
                        MTO_DEUDA = v_deuda_total,
                        MTO_VENCIDO = v_mto_vencido
        WHERE   NUM_IDENT = v_numident
        AND     COD_TIPIDENT = v_tipident;

         EXCEPTION
                         WHEN OTHERS THEN
                                  DBMS_OUTPUT.PUT_LINE(SQLERRM);
END CO_P_ARCHIVO_DICOM_TMC;
/
SHOW ERRORS
