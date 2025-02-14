CREATE OR REPLACE PROCEDURE CO_P_ARCHIVO_DICOM_PTR
(                 v_num_proceso    IN NUMBER
                  ,v_cod_proceso   IN VARCHAR2
                  ,v_numident      IN VARCHAR2
                  ,v_tipident      IN VARCHAR2
                  ,v_entidad       IN VARCHAR2
                  ,v_envio         IN VARCHAR2
                  ,v_usuario       IN VARCHAR2
                  ,v_mto_deuda_ant IN NUMBER
                  ,v_mto_vencido   IN NUMBER
)IS
/*    Funcion        :Genera Registros en Formato EQUIFAX MPR                                                   */
/*    Autor          :Ricardo Salazar                                                                                                   */
/*    Fecha          :30/05/2002                                                                                                                */
/*    Modificaciones :31/05/2002 (rmaturan)                                                                                             */
/*                      Manejo de exception para el PL                                                                  */
/*                      Considerar un todas los Clientes por Num_Ident                                  */
/*                      Un abonado por Cliente                                                                                  */
/*                   :11/06/2002 (Modesto Aranda)                                                                               */
/*                      se agrego caracter '#', el cual permite distinguir el fin de la */
/*                      cadena en  el  programa dicom.pc                                                                */
/*                   :26/06/2002 (Modesto Aranda)                                                                               */
/*                      Se elimina COMMIT y se mueve UPDATE que cambia estado de EP a SM*/
/*                   :08/07/2002 (Modesto Aranda)                                                                               */
/*                      Inicializacion variable  v_fin ='#'                                                             */
/*                                          - Control de numero de decimales (segun operadora)                          */
/*                                          - Cambio de campo utilizado para obtener descripcion campos         */
/*                                                direccion      (DES_PARAMDIR -> CAPTION)                                                      */
/*                                          - Se utilizaran numeros en vez de letras para identificar el        */
/*                                                tipo de registro      (encabezado, detalle y pie)                                     */
/*                                       :08/08/2002 (Modesto Aranda)                                                                           */
/*                                              - Cambio de forma de obtener la direccion. Se reemplazo uso de  */
/*                                                funcion por query.                                                                                    */
/*                                              - Modificacion del calculo de la deuda                                                  */
/*                                       :23/08/2002 (Modesto Aranda)                                                                           */
/*                                              - Se cambia el query que obtiene los clientes debido a que se   */
/*                                                agrego el campo IND_INFORMADO a la tabla CO_DICOM                             */
/*                                        :15/01/2003 (Modesto Aranda)                                                                          */
/*                                              - Es reemplazado el Campo CNT_RUTS por CNT_NUM_IDENT                    */
/*    Ult.Paso Pruduc:04/07/2002 (TMC --> BREGO)                                                                                */
/*                   :12/06/2002 (DEIMOS)                                                                                               */
/*                    15/07/2002 (HELENA --> Puerto Rico)                                                               */
/*                    23/08/2002 (TMC --> Produccion Chile)                                                             */
/*                    23/08/2002 (MPR --> Produccion Ptr.)                                                              */


        v_nom_cliente     GE_CLIENTES.NOM_CLIENTE%TYPE;
        v_apellidos       VARCHAR2(50);
        v_num_celular     GA_ABOCEL.NUM_CELULAR%TYPE;
        v_direccion           VARCHAR2(500);
        v_resto_cad       VARCHAR2(500);
        v_cod_tipident    GE_CLIENTES.COD_TIPIDENT%TYPE;
        v_num_ident       GE_CLIENTES.NUM_IDENT%TYPE;
        v_fec_vencimiento CO_CARTERA.FEC_VENCIMIE%TYPE;
        v_deuda_venc      CO_CARTERA.IMPORTE_DEBE%TYPE;
        v_deuda_total     CO_CARTERA.IMPORTE_DEBE%TYPE;
        v_stg_general     VARCHAR2(1024);
        v_stg_general2    VARCHAR2(1024);
        v_stg_titulo      VARCHAR2(1024);
        v_titulos_direc   VARCHAR2(1024);
        v_tel_particular  VARCHAR(15);
        v_fec_alta        VARCHAR2(10);
        v_fec_baja        VARCHAR2(10);
        ilarDir                   NUMBER;
        ii                                NUMBER;
        v_dias_moroso     NUMBER;
        v_nom_archivo     CO_ARCHIVOS.NOM_ARCHIVO%TYPE;
        v_exis_reg        CO_ARCHIVOS.NUM_PROCESO%TYPE;
        v_exis_mto_buenos CO_ARCHIVOS.MTO_BUENOS%TYPE;
        v_exis_reg_buenos CO_ARCHIVOS.reg_buenos%TYPE;
        v_exis_total_reg  CO_ARCHIVOS.TOT_REGISTROS%TYPE;
        v_reg_buenos      CO_ARCHIVOS.REG_BUENOS%TYPE;
        v_total_reg       CO_ARCHIVOS.TOT_REGISTROS%TYPE;
        v_mto_envio       CO_COBEXENV.MTO_ENVIO%TYPE;
        v_cant_ruts       CO_COBEXENV.CNT_NUM_IDENT%TYPE;
        v_cod_cliente     GE_CLIENTES.COD_CLIENTE%TYPE;
        v_fin             CHAR(1):='#';
        iDecimal          NUMBER(2):=0;--Decimales por Operadora.
        v_FecVencimie     CO_DICOMDOC.FEC_VENCIMIE%TYPE;

/*      CURSOR C1(p1 VARCHAR2,p2 VARCHAR2) IS
       SELECT COD_CLIENTE
       FROM GE_CLIENTES
       WHERE COD_TIPIDENT = p1
       AND  NUM_IDENT = ltrim(rtrim(p2)); */

        CURSOR C1(p1 VARCHAR2,p2 VARCHAR2) IS
        SELECT UNIQUE A.COD_CLIENTE
          FROM CO_DICOMDOC D, CO_ACCIONES A
         WHERE D.NUM_IDENT = ltrim(rtrim(p2))
           AND D.COD_TIPIDENT = p1
           AND D.COD_CLIENTE = A.COD_CLIENTE
           AND A.NUM_SECUENCIA > 0
           AND A.COD_ESTADO = 'EJE'
           AND A.COD_RUTINA = 'ASDIC'
           AND D.IND_INFORMADO = 'N';

    C1_CLIENTE          C1%ROWTYPE;

BEGIN
        v_deuda_total := 0;
        v_reg_buenos  := 0;
        v_total_reg   := 0;
        v_stg_general := '';
        v_nom_archivo:=v_cod_proceso||'_'||v_num_proceso||'.'||'txt';
        v_total_reg := v_total_reg + 1;
        /* Obtine la cantidad de decimales a utilizar */
    SELECT GE_PAC_GENERAL.PARAM_GENERAL('num_decimal')
    INTO   iDecimal
        FROM   DUAL;

        /* UN REGISTRO POR CLIENTE DE CADA NUM_IDENT */
        FOR C1_CLIENTE IN C1(v_tipident,v_numident) LOOP
                BEGIN
                    v_cod_cliente :='';
                    v_nom_cliente := '';
                        v_apellidos   := '';
                        v_num_celular := '';
                        v_cod_tipident:= '';
                        v_num_ident       := '';
                        v_tel_particular := '';
                        v_fec_alta:= '';
                        v_fec_baja:= '';

                        SELECT A.COD_CLIENTE
                                   ,A.NOM_CLIENTE
                                   ,A.NOM_APECLIEN1||' '||A.NOM_APECLIEN2
                                   ,A.COD_TIPIDENT
                                   ,A.NUM_IDENT
                                   ,A.TEF_CLIENTE1
                                   ,TO_CHAR(A.FEC_ALTA,'MMDDYY')
                                   ,TO_CHAR(A.FEC_BAJA,'DDMMYY')
                        INTO v_cod_cliente
                                 ,v_nom_cliente
                                 ,v_apellidos
                                 ,v_cod_tipident
                                 ,v_num_ident
                                 ,v_tel_particular
                                 ,v_fec_alta
                                 ,v_fec_baja
                        FROM GE_CLIENTES A
                        WHERE A.COD_CLIENTE = C1_CLIENTE.COD_CLIENTE;

                        EXCEPTION
                                 WHEN NO_DATA_FOUND THEN
                                            v_cod_cliente := NULL;
                                    v_nom_cliente := NULL;
                                                v_apellidos   := NULL;
                                                v_num_celular := NULL;
                                                v_cod_tipident:= NULL;
                                                v_num_ident       := NULL;
                                                v_tel_particular := NULL;
                                                v_fec_alta:= NULL;
                                                v_fec_baja:= NULL;
                END;

                BEGIN
                /* SOLO UN ABONADO POR CLIENTE SINO CELULAR = 0*/

                        SELECT NVL(B.NUM_CELULAR,0)  /* obtiene numero de celular */
                        INTO v_num_celular
                        FROM GE_CLIENTES A,GA_ABOCEL B
                        WHERE A.COD_CLIENTE = v_cod_cliente
                        AND A.COD_CLIENTE = B.COD_CLIENTE
                        AND B.FEC_BAJA = A.FEC_BAJA
                        AND ROWNUM < 2;

                        EXCEPTION
                            WHEN OTHERS THEN
                            v_num_celular:= 0;
                END;

                BEGIN
                        SELECT NVL(DIR.DES_DIREC1,' ')||';'||NVL(DIR.DES_DIREC2,' ')||';'||NVL(COM.DES_COMUNA,' ')
                                        ||';'||NVL(PROV.COD_PROVINCIA,' ')||';'||NVL(DIR.ZIP,' ')
                      INTO v_direccion
                          FROM GA_DIRECCLI DIREC ,GE_COMUNAS COM ,GE_DIRECCIONES DIR ,GE_PROVINCIAS PROV
                         WHERE DIREC.COD_CLIENTE= v_cod_cliente
                           AND DIREC.COD_TIPDIRECCION= 3
                           AND DIREC.COD_DIRECCION= DIR.COD_DIRECCION
                           AND DIR.COD_COMUNA=COM.COD_COMUNA
                           AND DIR.COD_PROVINCIA=PROV.COD_PROVINCIA;
                 EXCEPTION
                            WHEN OTHERS THEN
                            v_direccion:= NULL;
                END;

                v_resto_cad   := 'a';
                v_deuda_venc:='';
                BEGIN
                        SELECT SUM (NVL(IMPORTE_DEBE, 0) -  NVL(IMPORTE_HABER, 0)), MIN(FEC_VENCIMIE)
                        INTO v_deuda_venc, v_FecVencimie
                        FROM    CO_DICOMDOC
                        WHERE   NUM_IDENT               = v_numident
                          AND   COD_TIPIDENT    = v_tipident
                          AND   COD_CLIENTE     = v_cod_cliente;
                        EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                  v_deuda_venc:= null;
                END;
            BEGIN
                        UPDATE CO_DICOMDOC
                           SET IND_INFORMADO = 'S'
                         WHERE NUM_IDENT    = v_numident
                           AND COD_TIPIDENT = v_tipident
                           AND COD_CLIENTE  = C1_CLIENTE.COD_CLIENTE;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                    v_deuda_venc:=v_deuda_venc;
                END;
                v_dias_moroso:= ROUND(sysdate - v_FecVencimie);
                IF v_deuda_venc IS NOT NULL THEN
                    v_titulos_direc:= '';

                        v_stg_general:= v_cod_cliente||';'||v_nom_cliente||';'||v_apellidos||';'||v_numident;
                    v_stg_general := v_stg_general||';'||v_direccion||';'||v_tel_particular||';'||v_num_celular;
                v_stg_general := v_stg_general||';'||v_fec_alta||';'||1||';'||v_fec_baja||';'||GE_PAC_GENERAL.REDONDEA(v_deuda_venc, iDecimal, 0);
                v_stg_general := v_stg_general||';'||v_dias_moroso||';'||v_fin;

                    INSERT INTO CO_DET_ARCHIVOS
                                   (NUM_PROCESO, COD_PROCESO, COD_ENTIDAD,TIP_REGITRO, TXT_REGISTRO)
                        VALUES (v_num_proceso,v_cod_proceso,v_entidad,'2',v_stg_general );

                        v_deuda_total := v_deuda_total + v_deuda_venc;
                        v_reg_buenos:= v_reg_buenos + 1;
                END IF; --v_deuda_venc

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
                   INSERT INTO CO_ARCHIVOS
                                  (NUM_PROCESO, COD_PROCESO, FEC_PROCESO,COD_ENTIDAD, NOM_ARCHIVO, TOT_REGISTROS,REG_BUENOS, MTO_BUENOS, NOM_USUARIO)
                   VALUES(v_num_proceso,v_cod_proceso,SYSDATE,v_entidad,v_nom_archivo,v_total_reg,v_reg_buenos,v_deuda_total,v_usuario);

               v_titulos_direc:= v_titulos_direc||';'||'DIRECCION1'||';'||'DIRECCION2'||';';
               v_titulos_direc:= v_titulos_direc||'CIUDAD'||';'||'PAIS'||';'||'ZONA POSTAL';
               v_stg_titulo:='CUENTA'||';'||'NOMBRE'||';'||'APELLIDOS'||';'||'SEGURO_SOCIAL'||v_titulos_direc||';';
                   v_stg_titulo:=v_stg_titulo||'TEL_RESIDENCIAL'||';'||'TEL_MOVIL'||';'||'FECHA_ACTIVACION'||';'||'ECOA'||';';
                   v_stg_titulo:=v_stg_titulo||'FECHA_CANCELACION'||';'||'BALANCE_FINAL'||';'||'DIAS DE MOROSIDAD'||';'||v_fin;

               INSERT INTO CO_DET_ARCHIVOS
                                  (NUM_PROCESO, COD_PROCESO, COD_ENTIDAD,TIP_REGITRO, TXT_REGISTRO)
                   VALUES (v_num_proceso,v_cod_proceso,v_entidad,'1',v_stg_titulo );
                ELSE
                   v_exis_mto_buenos:=v_deuda_total + v_exis_mto_buenos;
                   v_exis_reg_buenos:=v_exis_reg_buenos+v_reg_buenos;
                   v_exis_total_reg:=v_exis_total_reg+v_total_reg;
               --update a la tabla co_archivos
                   UPDATE CO_ARCHIVOS
                   SET    MTO_BUENOS = v_exis_mto_buenos,
                                  REG_BUENOS = v_exis_reg_buenos,
                                  TOT_REGISTROS = v_exis_total_reg
                   WHERE NUM_PROCESO = v_num_proceso
                   AND COD_PROCESO = v_cod_proceso
                   AND NOM_ARCHIVO = v_nom_archivo;
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

                   INSERT INTO CO_COBEXENV
                                  (NUM_PROCESO, COD_ENTIDAD, COD_ENVIO, CNT_NUM_IDENT,MTO_ENVIO)
                   VALUES (v_num_proceso,v_entidad,v_envio,v_cant_ruts,v_mto_envio);
                ELSE
                   v_mto_envio:=v_mto_envio + (v_deuda_total - v_mto_deuda_ant);
                   UPDATE CO_COBEXENV
                   SET   CNT_NUM_IDENT = v_cant_ruts,
                                 MTO_ENVIO = v_mto_envio
               WHERE NUM_PROCESO = v_num_proceso
               AND COD_ENTIDAD = v_entidad
                   AND COD_ENVIO = v_envio;
                END IF;
        END LOOP; /* FOR C1_CLIENTE IN C1(v_tipident,v_numident) */

        UPDATE  CO_DICOM
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
END CO_P_ARCHIVO_DICOM_PTR;
/
SHOW ERRORS
