CREATE OR REPLACE PROCEDURE PV_CAMBIONUMERO_PR (
    nNumAbonado                 IN NUMBER,              -- Numero de Abonado
        nNewCelular                     IN NUMBER,              -- Numero nuevo celular
        vRegCelu                        IN VARCHAR2,    -- Codigo de region
        vProvinCelu                     IN VARCHAR2,    -- Codigo de provincia
        vCiudCelu                       IN VARCHAR2,    -- Codigo de ciudad
        vCeldaCelu                      IN VARCHAR2,    -- Codigo de celda
        vCenCelu                        IN NUMBER,              -- Codigo de central
        vCodUsoNue                      IN NUMBER,              -- Codigo de uso
        sNomUsuarora            IN VARCHAR2,    -- Nombre de USUARIO
        nCodProducto            IN NUMBER,              -- Codigo de producto
        nCambioSTM                      IN NUMBER,              -- Representa el tipo de Movimiento 1=Baja, 2=Alta,3 Cambio de Red Fija.
        vACTUACION                      IN VARCHAR2,    -- Codigo de Actuacion
        vNumTransacVta          IN NUMBER,              -- Numero de transaccion de la venta
        nCOD_ERROR                      OUT NUMBER,             -- Codigo de Error
        sMEN_ERROR                      OUT VARCHAR2    -- Mensaje de Error
)

/******************************************************************************
AUTOR    : JOAN ZAMORANO J.
AREA     : POSTVENTA
EMPRESA  : TELEFONICA MOVIL SOLUTION S.A.
******************************************************************************/

IS

/********************************* Funcion bUpdAboCel de cambio de Numero Visual *************************************/

vCodCuenta GA_ABOCEL.COD_CUENTA%TYPE;
vCodCliente GA_ABOCEL.COD_CLIENTE%TYPE;
nNumCelular GA_ABOCEL.NUM_CELULAR%TYPE;

nIndSupertel GA_ABOCEL.IND_SUPERTEL%TYPE;
vNumTelefija GA_ABOCEL.NUM_TELEFIJA%TYPE;
nNumAbonadoPaso GA_ABOCEL.NUM_ABONADO%TYPE;
vNumMinMdnNvo GA_ABOCEL.NUM_MIN_MDN%TYPE;
vNumMinMdnAct GA_ABOCEL.NUM_MIN_MDN%TYPE;
vRegOrig GA_ABOCEL.COD_REGION%TYPE;
vProvOrig GA_ABOCEL.COD_PROVINCIA%TYPE;
vCiudOrig GA_ABOCEL.COD_CIUDAD%TYPE;
vCeldOrig GA_ABOCEL.COD_CELDA%TYPE;
vCentOrig GA_ABOCEL.COD_CENTRAL%TYPE;
vCodUsoDef GA_ABOCEL.COD_USO%TYPE;
vTipTermOrig GA_ABOCEL.TIP_TERMINAL%TYPE;
vNumSerie GA_ABOCEL.NUM_SERIE%TYPE;
vNumSerieHex GA_ABOCEL.NUM_SERIEHEX%TYPE;
vNumImei GA_ABOCEL.NUM_IMEI%TYPE;
vProcEqui GA_ABOCEL.IND_PROCEQUI%TYPE;
vClaseServicio GA_ABOCEL.CLASE_SERVICIO%TYPE;
vClaseServicioOrig GA_ABOCEL.CLASE_SERVICIO%TYPE;
vCodTecnologia GA_ABOCEL.COD_TECNOLOGIA%TYPE;

sNumMin VARCHAR2(100);
sNumMinNuev VARCHAR2(100);

nNumError NUMBER(2);
sMsgError VARCHAR2(100);
ALTASTM_SIN NUMBER(1); -- Cambio de Normal a STM
vSituacion VARCHAR2(3);

ERROR_PROCESO EXCEPTION;

sNOM_TABLA       GA_ERRORES.NOM_TABLA%TYPE;
sNOM_PROC        GA_ERRORES.NOM_PROC%TYPE;
sCOD_ACT         GA_ERRORES.COD_ACT%TYPE;
sCOD_SQLCODE GA_ERRORES.COD_SQLCODE%TYPE;
sCOD_SQLERRM GA_ERRORES.COD_SQLERRM%TYPE;
sERROR           VARCHAR2(2);

-- Variables de paso, se cargan con distintos valores segun necesidad
vRegion GA_ABOCEL.COD_REGION%TYPE;
vProvincia GA_ABOCEL.COD_PROVINCIA%TYPE;
vCiudad GA_ABOCEL.COD_CIUDAD%TYPE;
vCelda GA_ABOCEL.COD_CELDA%TYPE;
nCentral GA_ABOCEL.COD_CENTRAL%TYPE;
nCelu GA_ABOCEL.NUM_CELULAR%TYPE;
nCodUso GA_ABOCEL.COD_USO%TYPE;
nCodRetorno NUMBER(1);
vDesCadena VARCHAR2(255);
nRow NUMBER(10);
vComando VARCHAR2(50);

-- Fin Variables de paso, se cargan con distintos valores segun necesidad

-- Variables para bReutilNumeros
vCodSubAlm VARCHAR2(5);
nCodCentral NUMBER(3);
nCodCat NUMBER(2);
vRowID ROWID;
bNum_Duplicado BOOLEAN;
-- FIN Variables para bReutilNumeros

-- Variables para bReutilNumeros
bReutilNumeros BOOLEAN;
-- Fin Variables para bReutilNumeros

-- Variable para guardar numero de transacciones
vNumTran VARCHAR2(50);
-- Fin Variable para guardar numero de transacciones

-- Variables para bEjecutarPLCambCentral
nOk NUMBER(1);
-- Fin Variables para bEjecutarPLCambCentral

-- Variables para bAutenticacion2
nCodServSupl NUMBER(2);
vCodServicio VARCHAR2(3);
-- FIN Variables para bAutenticacion2

-- Variables para bInsertaMovimiento
nAuxCodActIC ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
vCodModulo ICC_MOVIMIENTO.COD_MODULO%TYPE;
vValParametro GED_PARAMETROS.VAL_PARAMETRO%TYPE;
vIMSI ICC_MOVIMIENTO.IMSI%TYPE;
vIdentAutenticacion VARCHAR2(50);
nPos NUMBER(3);
-- FIN Variables para bInsertaMovimiento

-- Variables para bEjecutarPLCambioNumero
vOrigen VARCHAR2(2);
-- FIN Variables para bEjecutarPLCambioNumero

BEGIN

/******************************************* inicializacion de variables ************************************/
        nNumError:=0;
        sMsgError:='Operacion Exitosa.';
        sNOM_TABLA:='';
        sCOD_ACT:='';
        ALTASTM_SIN:=4;
        vSituacion:='BAA';
        vComando:='';
        vCodModulo:='GA';
        vIdentAutenticacion:= '460001';

        BEGIN
                nNumError := 1;
                sMsgError := 'Error, al obtener Numero MIN MDN Actual';
                sNOM_TABLA:='FN_RECUPERA_NUM_MIN';
                sCOD_ACT:='S';

                --Recupera el numero de MIN MDN para el numero de telefono Actual.
                vNumMinMdnAct:=FN_RECUPERA_NUM_MIN(nNumAbonado);

                nNumError := 8;
                sMsgError := 'Error, al seleccionar desde GA_ABOCEL';
                sNOM_TABLA:='GA_ABOCEL';
                sCOD_ACT:='S';

                SELECT COD_CLIENTE, COD_CUENTA, NUM_CELULAR, COD_REGION, COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL, COD_USO, TIP_TERMINAL, CLASE_SERVICIO, NUM_SERIE, IND_PROCEQUI, COD_TECNOLOGIA, NUM_SERIEHEX, NUM_IMEI
                INTO vCodCliente, vCodCuenta, nNumCelular, vRegOrig, vProvOrig, vCiudOrig, vCeldOrig, vCentOrig, vCodUsoDef, vTipTermOrig, vClaseServicioOrig, vNumSerie, vProcEqui, vCodTecnologia, vNumSerieHex, vNumImei
                FROM GA_ABOCEL
                WHERE NUM_ABONADO = nNumAbonado;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
        BEGIN
                nNumError := 2;
                sMsgError := 'Error, al obtener Numero MIN MDN Nuevo';
                sNOM_TABLA:='GE_FN_MIN_DE_MDN';
                sCOD_ACT:='S';

                --Recupera el numero de MIN MDN para el nuevo numero de telefono.
                vNumMinMdnNvo:=GE_FN_MIN_DE_MDN(nNumCelular);

                IF (TO_NUMBER(vNumMinMdnNvo) in (0,1,2,3)) or (TO_NUMBER(vNumMinMdnNvo)<0) THEN
                   RAISE ERROR_PROCESO;
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
/******************************************* FIN inicializacion de variables ************************************/

/*********************************************** Funcion bUpdAboCel ***********************************************/
        BEGIN
                nNumError := 3;
                sMsgError := 'Error, el nuevo numero ya esta en uso';
                sNOM_TABLA:='GA_ABOCEL';
                sCOD_ACT:='S';

                SELECT NUM_ABONADO
                INTO nNumAbonadoPaso
                FROM GA_ABOCEL
                WHERE NUM_CELULAR = nNewCelular
                AND COD_SITUACION != vSituacion;

                IF nNumAbonadoPaso>0 THEN
                        RAISE ERROR_PROCESO;
                END IF;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         nNumError:=0;
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;

        BEGIN
                nNumError := 4;
                sMsgError := 'Error, al actualizar GA_ABOCEL';
                sNOM_TABLA:='GA_ABOCEL';
                sCOD_ACT:='U';

                UPDATE GA_ABOCEL SET
                        COD_SITUACION = 'CNP',
                        FEC_ULTMOD = SYSDATE,
                        COD_REGION = vRegCelu,
                        COD_PROVINCIA = vProvinCelu,
                        COD_CIUDAD = vCiudCelu,
                        COD_CELDA = vCeldaCelu,
                        COD_CENTRAL = vCenCelu,
                        NUM_CELULAR = nNewCelular,
                        COD_USO = vCodUsoNue,
                        COD_CENTRAL_PLEX = NULL,
                        NUM_CELULAR_PLEX = NULL,
                        IND_PLEXSYS = 0,
                        NUM_MIN_MDN = vNumMinMdnNvo
                WHERE COD_CUENTA= vCodCuenta
                        AND   COD_CLIENTE= vCodCliente
                        AND   NUM_ABONADO = nNumAbonado;


                /***************************************************************************************************/
                /***************** Cambiamos el Numero de Terminal para los servicios suplementarios ***************/
                /****************************************** del abonado ********************************************/

                nNumError := 5;
                sMsgError := 'Error, al actualizar GA_SERVSUPLABO';
                sNOM_TABLA:='GA_SERVSUPLABO';
                sCOD_ACT:='U';

                UPDATE GA_SERVSUPLABO SET NUM_TERMINAL = nNumCelular
                WHERE NUM_ABONADO = nNumAbonado
                AND IND_ESTADO <> 4;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;

        BEGIN
                /***************************************************************************************************************/
                /***************************** Insertarmos un registro de Cambio STM en GA_CTC_MOVIMIENTOS *********************/
                /***************************************************************************************************************/


                ---------------------------------------------bInsertaMovtoSTM2--------------------------------------------------

                -- Funcion que inserta un Movimientos en la tabla GA_CTC_MOVIMIENTOS

                nNumError := 6;
                sMsgError := 'Error, al seleccionar desde GA_ABOCEL';
                sNOM_TABLA:='GA_ABOCEL';
                sCOD_ACT:='S';

                -- Comprobacion de STM

                SELECT IND_SUPERTEL, NUM_TELEFIJA
                INTO nIndSupertel, vNumTelefija
                FROM GA_ABOCEL
                WHERE COD_CUENTA= vCodCuenta
                AND COD_CLIENTE= vCodCliente
                AND NUM_ABONADO = nNumAbonado;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                         RAISE ERROR_PROCESO;
        END;

        IF nIndSupertel<>0 and nCambioSTM=ALTASTM_SIN then
                BEGIN
                        -- nCambioSTM : Representa el tipo de Movimiento (3:indica cambio de numero)
                        -- sNum_Cel1 : Celular dado de alta;
                        -- sNum_Cel2 : Celular Nuevo.

                        nNumError := 7;
                        sMsgError := 'Error, al ingresar datos a GA_CTC_MOVIMIENTOS';
                        sNOM_TABLA:='GA_CTC_MOVIMIENTOS';
                        sCOD_ACT:='I';

                        INSERT INTO GA_CTC_MOVIMIENTOS (NUM_REDFIJA, FEC_MOVIMIENTO, TIP_MOVIMIENTO, NUM_CELULAR1, NUM_CELULAR2)
                        VALUES (vNumTelefija, SYSDATE, nCambioSTM, nNumCelular, nNewCelular); --revisar si esta bien, guiarse por el codigo en visual basic

                EXCEPTION
                        WHEN OTHERS THEN
                                 RAISE ERROR_PROCESO;
                ----------------------------------------------fin bInsertaMovtoSTM2---------------------------------------------
                END;
        END IF;

/******************************************* FIN Funcion bUpdAboCel ***********************************************/

/*********************************************** bInsModAboCel ****************************************************/
        BEGIN
                nNumError := 9;
                sMsgError := 'Error, al obtener Prefijo';
                sNOM_TABLA:='AL_FN_PREFIJO_NUMERO';
                sCOD_ACT:='S';

                sNumMin:= AL_FN_PREFIJO_NUMERO (nNewCelular) ;

                vRegion:=NULL;
                vProvincia:=NULL;
                vCiudad:=NULL;
                vCelda:=NULL;
                nCentral:=NULL;
                nCelu:=NULL;
                nCodUso:=NULL;

                IF vRegOrig<>vRegCelu then vRegion:=vRegCelu; end if;
                IF vProvOrig<>vProvinCelu then vProvincia:=vProvinCelu; end if;
                IF vCiudOrig<>vCiudCelu then vCiudad:=vCiudCelu; end if;
                IF vCeldOrig<>vCeldaCelu then vCelda:=vCeldaCelu; end if;
                IF vCentOrig<>vCenCelu then nCentral:=vCenCelu; end if;
                IF nNumCelular<>nNewCelular then nCelu:=nNumCelular; end if;
                IF vCodUsoDef<>vCodUsoNue then nCodUso:=vCodUsoNue; end if;

                nNumError := 10;
                sMsgError := 'Error, al ingresar datos a GA_MODABOCEL';
                sNOM_TABLA:='GA_MODABOCEL';
                sCOD_ACT:='I';

                INSERT INTO GA_MODABOCEL (NUM_ABONADO, COD_TIPMODI, FEC_MODIFICA, NOM_USUARORA,
                                COD_REGION, COD_PROVINCIA, COD_CIUDAD, COD_CELDA, COD_CENTRAL,
                                NUM_CELULAR, COD_USO, COD_CENTRAL_PLEX, NUM_CELULAR_PLEX, IND_PLEXSYS,NUM_MIN, NUM_MIN_MDN)
                VALUES (nNumAbonado, 'CN', SYSDATE, sNomUsuarora, vRegion, vProvincia, vCiudad, vCelda,
                                nCentral, nCelu, nCodUso, NULL, NULL, -1, sNumMin, vNumMinMdnAct);
        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;

/*********************************************** FIN bInsModAboCel ****************************************************/


/************************************************* bReutilNumeros **************************************************/
        --Inicializacion de variables para la funcion bReutilNumeros
        bNum_Duplicado:=TRUE;
        nCodUso:=NULL;
        --FIN Inicializacion de variables para la funcion bReutilNumeros

        IF nNumCelular <> nNewCelular THEN
                BEGIN
                        nNumError := 11;
                        sMsgError := 'Error, al seleccionar desde GA_CELNUM_USO';
                        sNOM_TABLA:='GA_CELNUM_USO';
                        sCOD_ACT:='S';

                        SELECT COD_SUBALM,COD_CENTRAL,COD_CAT,COD_USO
                        INTO vCodSubAlm, nCodCentral, nCodCat, nCodUso
                        FROM GA_CELNUM_USO
                        WHERE COD_PRODUCTO = nCodProducto
                        AND nNumCelular BETWEEN NUM_DESDE AND NUM_HASTA;

                EXCEPTION
                        WHEN OTHERS THEN
                                 RAISE ERROR_PROCESO;
                END;
        ---------------------------------------------------- bNum_Duplicado --------------------------------------------------
                BEGIN
                        nNumError := 12;
                        sMsgError := 'Error, al seleccionar desde GA_ABOCEL';
                        sNOM_TABLA:='GA_ABOCEL';
                        sCOD_ACT:='S';

                        SELECT ROWID
                        INTO vRowID
                        FROM GA_ABOCEL
                        WHERE NUM_CELULAR = nNumCelular
                        AND NUM_ABONADO != nNumAbonado
                        AND COD_SITUACION != vSituacion;

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                                BEGIN
                                        nNumError := 13;
                                        sMsgError := 'Error, al seleccionar desde AL_SERIES';
                                        sNOM_TABLA:='AL_SERIES';
                                        sCOD_ACT:='S';

                                        SELECT ROWID
                                        INTO vRowID
                                        FROM AL_SERIES
                                        WHERE NUM_TELEFONO = nNumCelular;

                                EXCEPTION
                                        WHEN NO_DATA_FOUND THEN
                                                BEGIN
                                                        nNumError := 14;
                                                        sMsgError := 'Error, al seleccionar desde AL_FIC_SERIES';
                                                        sNOM_TABLA:='AL_FIC_SERIES';
                                                        sCOD_ACT:='S';

                                                        SELECT ROWID
                                                        INTO vRowID
                                                        FROM AL_FIC_SERIES
                                                        WHERE NUM_TELEFONO = nNumCelular;

                                                EXCEPTION
                                                        WHEN NO_DATA_FOUND THEN
                                                                BEGIN
                                                                        nNumError := 15;
                                                                        sMsgError := 'Error, al seleccionar desde GA_RESNUMCEL';
                                                                        sNOM_TABLA:='GA_RESNUMCEL';
                                                                        sCOD_ACT:='S';

                                                                        SELECT ROWID
                                                                        INTO vRowID
                                                                        FROM GA_RESNUMCEL
                                                                        WHERE NUM_CELULAR = nNumCelular;

                                                                EXCEPTION
                                                                        WHEN NO_DATA_FOUND THEN
                                                                                BEGIN
                                                                                        nNumError := 16;
                                                                                        sMsgError := 'Error, al seleccionar desde GA_CELNUM_USO';
                                                                                        sNOM_TABLA:='GA_CELNUM_USO';
                                                                                        sCOD_ACT:='S';

                                                                                        SELECT ROWID
                                                                                        INTO vRowID
                                                                                        FROM GA_CELNUM_USO
                                                                                        WHERE nNumCelular BETWEEN NUM_DESDE AND NUM_HASTA
                                                                                        AND  NUM_SIGUIENTE <= nNumCelular;

                                                                                EXCEPTION
                                                                                        WHEN NO_DATA_FOUND THEN
                                                                                            bNum_Duplicado:=FALSE;
                                                                                        WHEN OTHERS THEN
                                                                                                 RAISE ERROR_PROCESO;
                                                                                END;
                                                                        WHEN OTHERS THEN
                                                                                 RAISE ERROR_PROCESO;
                                                                END;
                                                        WHEN OTHERS THEN
                                                                 RAISE ERROR_PROCESO;
                                                END;
                                        WHEN OTHERS THEN
                                                 RAISE ERROR_PROCESO;
                                END;
                        WHEN OTHERS THEN
                                 RAISE ERROR_PROCESO;
                END;
        -------------------------------------------------- FIN bNum_Duplicado ------------------------------------------------

                IF NOT bNum_Duplicado THEN
                        BEGIN
                                nNumError := 17;
                                sMsgError := 'Error, al ingresar datos a GA_CELNUM_REUTIL';
                                sNOM_TABLA:='GA_CELNUM_REUTIL';
                                sCOD_ACT:='I';

                                INSERT INTO GA_CELNUM_REUTIL (NUM_CELULAR,COD_SUBALM,COD_PRODUCTO,COD_CENTRAL,COD_CAT,COD_USO,FEC_BAJA,IND_EQUIPADO,USO_ANTERIOR)
                                VALUES(nNumCelular, vCodSubAlm, nCodProducto, nCodCentral, nCodCat, vCodUsoDef, SYSDATE, 1, nCodUso);

                        EXCEPTION
                                WHEN OTHERS THEN
                                         RAISE ERROR_PROCESO;
                        END;
                END IF;
        END IF;
/************************************************* FIN bReutilNumeros **************************************************/

/*********************************************** bEjecutarPLCambCentral ************************************************/
        IF vCentOrig<>vCenCelu THEN
            BEGIN
                        --Obtiene numero de transaccion

                        nNumError := 18;
                        sMsgError := 'Error, al seleccionar secuencia desde GA_SEQ_TRANSACABO';
                        sNOM_TABLA:='GA_SEQ_TRANSACABO';
                        sCOD_ACT:='S';

                        SELECT GA_SEQ_TRANSACABO.NEXTVAL
                        INTO vNumTran
                        FROM DUAL;

                        nNumError := 19;
                        sMsgError := 'Error, al ejecutar proceso P_CLOSERV_NUMERO';
                        sNOM_PROC := 'P_CLOSERV_NUMERO';
                        sNOM_TABLA:= '';
                        sCOD_ACT:= 'E';

                        p_closerv_numero (vNumTran, TO_CHAR(nCodProducto), TO_CHAR(nNumAbonado), vTipTermOrig, vCenCelu, '0');

                        nNumError := 20;
                        sMsgError := 'Error, al seleccionar desde GA_TRANSACABO';
                        sNOM_TABLA:='GA_TRANSACABO';
                        sCOD_ACT:='S';

                        SELECT COD_RETORNO, DES_CADENA
                        INTO nCodRetorno, vDesCadena
                        FROM GA_TRANSACABO
                        WHERE NUM_TRANSACCION = vNumTran;

                        nNumError := 21;
                        sMsgError := 'Error, al eliminar desde GA_TRANSACABO';
                        sNOM_TABLA:='GA_TRANSACABO';
                        sCOD_ACT:='D';

                        DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = vNumTran;

                        vDesCadena:=REPLACE(vDesCadena,'/','');

                        IF nCodRetorno=4 OR vDesCadena='' THEN
                            RAISE ERROR_PROCESO;
                        ELSE
                                vClaseServicio:=vDesCadena;
                        END IF;

                EXCEPTION
                        WHEN OTHERS THEN
                                 RAISE ERROR_PROCESO;
                END;
        END IF;
/********************************************* FIN bEjecutarPLCambCentral **********************************************/

/************************************************** bAutenticacion2 ****************************************************/

        BEGIN
                nNumError := 22;
                sMsgError := 'Error, al seleccionar secuencia desde GA_SEQ_TRANSACABO';
                sNOM_TABLA:='GA_SEQ_TRANSACABO';
                sCOD_ACT:='S';

                SELECT GA_SEQ_TRANSACABO.NEXTVAL
                INTO vNumTran
                FROM DUAL;

                nNumError := 23;
                sMsgError := 'Error, al ejecutar proceso GA_VALIDA_AUTENTICACION_PR';
                sNOM_PROC := 'GA_VALIDA_AUTENTICACION_PR';
                sNOM_TABLA:= '';
                sCOD_ACT:= 'E';

                GA_VALIDA_AUTENTICACION_PR (vNumTran, 'PV', vNumSerie, vProcEqui, '', vCodUsoDef);

                nNumError := 24;
                sMsgError := 'Error, al seleccionar desde GA_TRANSACABO';
                sNOM_TABLA:='GA_TRANSACABO';
                sCOD_ACT:='S';

                SELECT COD_RETORNO, DES_CADENA
                INTO nCodRetorno, vDesCadena
                FROM GA_TRANSACABO
                WHERE NUM_TRANSACCION = vNumTran;

                nNumError := 25;
                sMsgError := 'Error, al eliminar desde GA_TRANSACABO';
                sNOM_TABLA:='GA_TRANSACABO';
                sCOD_ACT:='D';

                DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = vNumTran;

                IF nCodRetorno=1 OR nCodRetorno=4 THEN
                   RAISE ERROR_PROCESO;
                END IF;

                IF nCodRetorno=2 THEN
                        BEGIN
                                nNumError := 26;
                                sMsgError := 'Error, al ingresar datos a ICT_AKEYS';
                                sNOM_TABLA:='ICT_AKEYS';
                                sCOD_ACT:='I';

                                INSERT INTO ICT_AKEYS
                                (NUM_ESN, FEC_ACTUALIZACION, ID_CARGA, COD_ESTADO)
                                VALUES (vNumSerie, SYSDATE, -1, -1);

                        EXCEPTION
                                WHEN OTHERS THEN
                                         RAISE ERROR_PROCESO;
                        END;
-------------------------------------------------- bAutenticacionServSuplabo -------------------------------------------
                        BEGIN
                                nNumError := 27;
                                sMsgError := 'Error, al seleccionar desde GA_SERVSUPL, GED_PARAMETROS';
                                sNOM_TABLA:='GA_SERVSUPL, GED_PARAMETROS';
                                sCOD_ACT:='S';

                                SELECT A.COD_SERVSUPL, A.COD_SERVICIO
                                INTO nCodServSupl, vCodServicio
                                FROM GA_SERVSUPL A, GED_PARAMETROS B
                                WHERE  A.COD_SERVICIO = B.VAL_PARAMETRO
                                AND B.NOM_PARAMETRO = 'IND_AUTENTICACION'
                                AND A.COD_PRODUCTO  = 1;

                                nNumError := 28;
                                sMsgError := 'Error, al seleccionar desde GA_SERVSUPLABO';
                                sNOM_TABLA:='GA_SERVSUPLABO';
                                sCOD_ACT:='S';

                                SELECT count(*)
                                INTO nRow
                                FROM GA_SERVSUPLABO
                                WHERE NUM_ABONADO =  nNumAbonado
                                AND  COD_SERVICIO = vCodServicio
                                AND  TRUNC(FEC_ALTABD) <= TRUNC(SYSDATE)
                                AND  FEC_BAJABD IS NULL;

                                IF nRow>0 THEN
------------------------------------------------- bDesActivarAutenticacion ---------------------------------------------
                                        BEGIN
                                                nNumError := 29;
                                                sMsgError := 'Error, al actualizar GA_SERVSUPLABO';
                                                sNOM_TABLA:='GA_SERVSUPLABO';
                                                sCOD_ACT:='U';

                                                UPDATE GA_SERVSUPLABO SET
                                                IND_ESTADO = 3,
                                                NOM_USUARORA = sNomUsuarora,
                                                FEC_BAJABD =  SYSDATE,
                                                COD_NIVEL = 0
                                                WHERE NUM_ABONADO = nNumAbonado
                                                AND COD_SERVICIO = vCodServicio
                                                AND cod_servSupl = nCodServSupl
                                                AND FEC_BAJABD IS NULL;

                                        EXCEPTION
                                                WHEN OTHERS THEN
                                                         RAISE ERROR_PROCESO;
                                        END;
--------------------------------------------- FIN bDesActivarAutenticacion ---------------------------------------------
                                END IF;

                        EXCEPTION
                                WHEN OTHERS THEN
                                         RAISE ERROR_PROCESO;
                        END;
-----------------------------------------------FIN bAutenticacionServSuplabo ---------------------------------------------
                END IF;

                IF nCodRetorno=3 THEN
                        BEGIN
                                nNumError := 30;
                                sMsgError := 'Error, al actualizar ICT_AKEYS';
                                sNOM_TABLA:='ICT_AKEYS';
                                sCOD_ACT:='U';

                                UPDATE ICT_AKEYS SET
                                FEC_ACTUALIZACION = SYSDATE,
                                COD_ESTADO = 1
                                WHERE NUM_ESN= vNumSerie;

                                vComando:= '460001';

                        EXCEPTION
                                WHEN OTHERS THEN
                                         RAISE ERROR_PROCESO;
                        END;
-------------------------------------------------- bAutenticacionServSuplabo ----------------------------------------------
                        BEGIN

                                nNumError := 31;
                                sMsgError := 'Error, al seleccionar desde GA_SERVSUPL A, GED_PARAMETROS B';
                                sNOM_TABLA:='GA_SERVSUPL A, GED_PARAMETROS B';
                                sCOD_ACT:='S';

                                SELECT A.COD_SERVSUPL, A.COD_SERVICIO
                                INTO nCodServSupl, vCodServicio
                                FROM GA_SERVSUPL A, GED_PARAMETROS B
                                WHERE  A.COD_SERVICIO = B.VAL_PARAMETRO
                                AND B.NOM_PARAMETRO = 'IND_AUTENTICACION'
                                AND A.COD_PRODUCTO  = 1;

                                nNumError := 32;
                                sMsgError := 'Error, al seleccionar desde GA_SERVSUPLABO';
                                sNOM_TABLA:='GA_SERVSUPLABO';
                                sCOD_ACT:='S';

                                SELECT count(*)
                                INTO nRow
                                FROM GA_SERVSUPLABO
                                WHERE NUM_ABONADO =  nNumAbonado
                                AND  COD_SERVICIO = vCodServicio
                                AND  TRUNC(FEC_ALTABD) <= TRUNC(SYSDATE)
                                AND  FEC_BAJABD IS NULL;

                                IF nRow=0 THEN
------------------------------------------------- bActivarAutenticacion ---------------------------------------------------
                                        BEGIN

                                                nNumError := 33;
                                                sMsgError := 'Error, al ingresar datos a GA_SERVSUPLABO';
                                                sNOM_TABLA:='GA_SERVSUPLABO';
                                                sCOD_ACT:='I';

                                                INSERT INTO GA_SERVSUPLABO
                                                (NUM_ABONADO,
                                                COD_SERVICIO,
                                                FEC_ALTABD,
                                                COD_SERVSUPL,
                                                COD_NIVEL,
                                                COD_PRODUCTO,
                                                NUM_TERMINAL,
                                                NOM_USUARORA,
                                                IND_ESTADO)
                                                VALUES (
                                                nNumAbonado,
                                                vCodServicio,
                                                SYSDATE,
                                                nCodServSupl,
                                                0,
                                                nCodProducto,
                                                nNumCelular,
                                                sNomUsuarora,
                                                1);

                                                nNumError := 34;
                                                sMsgError := 'Error, al actualizar GA_ABOCEL';
                                                sNOM_TABLA:='GA_ABOCEL';
                                                sCOD_ACT:='U';

                                                UPDATE GA_ABOCEL SET
                                                CLASE_SERVICIO = vClaseServicioOrig || vComando,
                                                FEC_ULTMOD = SYSDATE,
                                                NOM_USUARORA = sNomUsuarora
                                                WHERE NUM_ABONADO = nNumAbonado;

                                        EXCEPTION
                                                WHEN OTHERS THEN
                                                         RAISE ERROR_PROCESO;
                                        END;
------------------------------------------------ FIN bActivarAutenticacion ------------------------------------------------
                                END IF;

                        EXCEPTION
                                WHEN OTHERS THEN
                                         RAISE ERROR_PROCESO;

                        END;
-----------------------------------------------FIN bAutenticacionServSuplabo ----------------------------------------------
                END IF;

                IF nCodRetorno=5 THEN
-------------------------------------------------- bAutenticacionServSuplabo ----------------------------------------------
                   BEGIN

                                nNumError := 35;
                                sMsgError := 'Error, al seleccionar desde GA_SERVSUPL A, GED_PARAMETROS B';
                                sNOM_TABLA:='GA_SERVSUPL A, GED_PARAMETROS B';
                                sCOD_ACT:='S';

                                SELECT A.COD_SERVSUPL, A.COD_SERVICIO
                                INTO nCodServSupl, vCodServicio
                                FROM GA_SERVSUPL A, GED_PARAMETROS B
                                WHERE  A.COD_SERVICIO = B.VAL_PARAMETRO
                                AND B.NOM_PARAMETRO = 'IND_AUTENTICACION'
                                AND A.COD_PRODUCTO  = 1;

                                nNumError := 36;
                                sMsgError := 'Error, al seleccionar desde GA_SERVSUPLABO';
                                sNOM_TABLA:='GA_SERVSUPLABO';
                                sCOD_ACT:='S';

                                SELECT count(*)
                                INTO nRow
                                FROM GA_SERVSUPLABO
                                WHERE NUM_ABONADO =  nNumAbonado
                                AND  COD_SERVICIO = vCodServicio
                                AND  TRUNC(FEC_ALTABD) <= TRUNC(SYSDATE)
                                AND  FEC_BAJABD IS NULL;

                                IF nRow>0 THEN
------------------------------------------------- bDesActivarAutenticacion ------------------------------------------------
                                        BEGIN
                                                nNumError := 37;
                                                sMsgError := 'Error, al actualizar GA_SERVSUPLABO';
                                                sNOM_TABLA:='GA_SERVSUPLABO';
                                                sCOD_ACT:='U';

                                                UPDATE GA_SERVSUPLABO SET
                                                IND_ESTADO = 3,
                                                NOM_USUARORA = sNomUsuarora,
                                                FEC_BAJABD =  SYSDATE,
                                                COD_NIVEL = 0
                                                WHERE NUM_ABONADO = nNumAbonado
                                                AND COD_SERVICIO = vCodServicio
                                                AND cod_servSupl = nCodServSupl
                                                AND FEC_BAJABD IS NULL;

                                        EXCEPTION
                                                WHEN OTHERS THEN
                                                         RAISE ERROR_PROCESO;

                                        END;
--------------------------------------------- FIN bDesActivarAutenticacion ------------------------------------------------
                                ELSE
                                        RAISE ERROR_PROCESO;
                                END IF;
                   END;
-----------------------------------------------FIN bAutenticacionServSuplabo ----------------------------------------------
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
/************************************************* FIN bAutenticacion2 ****************************************************/

/*************************************************** bInsertaMovimiento ***************************************************/
        BEGIN
                nNumError := 38;
                sMsgError := 'Error, al seleccionar secuencia desde ICC_SEQ_NUMMOV';
                sNOM_TABLA:='ICC_SEQ_NUMMOV';
                sCOD_ACT:='S';

                SELECT ICC_SEQ_NUMMOV.NEXTVAL
                INTO vNumTran
                FROM DUAL;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
-------------------------------------------------------- sHazSqlMovi -------------------------------------------------------

-------------------------------------------------------- bObtieneMin -------------------------------------------------------
        BEGIN
                nNumError := 39;
                sMsgError := 'Error, al seleccionar Prefijo numero celular Original';
                sNOM_PROC := 'AL_FN_PREFIJO_NUMERO';
                sNOM_TABLA:= '';
                sCOD_ACT:= 'E';

                sNumMin:= AL_FN_PREFIJO_NUMERO (nNumCelular);

                nNumError := 40;
                sMsgError := 'Error, al seleccionar Prefijo numero celular Nuevo';
                sNOM_PROC := 'AL_FN_PREFIJO_NUMERO';
                sNOM_TABLA:= '';
                sCOD_ACT:= 'E';

                sNumMinNuev:=AL_FN_PREFIJO_NUMERO (nNewCelular);

                IF sNumMin='' OR sNumMinNuev='' THEN
                   RAISE ERROR_PROCESO;
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
------------------------------------------------------ FIN bObtieneMin -----------------------------------------------------
        BEGIN
                nNumError := 41;
                sMsgError := 'Error, al actualizar GA_ABOCEL';
                sNOM_TABLA:='GA_ABOCEL';
                sCOD_ACT:='U';

                UPDATE GA_ABOCEL SET NUM_MIN = sNumMinNuev
                WHERE NUM_ABONADO = nNumAbonado;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
-------------------------------------------------------- sCodActCen --------------------------------------------------------
        BEGIN
                nNumError := 42;
                sMsgError := 'Error, al seleccionar Codigo de actuacion central';
                sNOM_PROC := 'FN_CODACTCEN';
                sNOM_TABLA:= '';
                sCOD_ACT:= 'E';

                SELECT FN_CODACTCEN(nCodProducto, vACTUACION, vCodModulo, vCodTecnologia)
                INTO nAuxCodActIC
                FROM DUAL;

                IF nAuxCodActIC='' THEN
                   RAISE ERROR_PROCESO;
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
------------------------------------------------------ FIN sCodActCen ------------------------------------------------------

----------------------------------------------------- ObtieneGedParametros -------------------------------------------------
        BEGIN
                nNumError := 43;
                sMsgError := 'Error, al seleccionar desde GED_PARAMETROS';
                sNOM_TABLA:='GED_PARAMETROS';
                sCOD_ACT:='S';

                SELECT VAL_PARAMETRO
                INTO vValParametro
                FROM GED_PARAMETROS
                WHERE NOM_PARAMETRO = 'TECNOLOGIA_GSM'
                AND COD_MODULO = vCodModulo
                AND COD_PRODUCTO = nCodProducto;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
-------------------------------------------------- FIN ObtieneGedParametros ------------------------------------------------
        IF vValParametro=vCodTecnologia THEN
------------------------------------------------------- sRecuperaIMSI ------------------------------------------------------
                BEGIN
                        nNumError := 44;
                        sMsgError := 'Error, al seleccionar IMSI';
                        sNOM_PROC := 'FN_RECUPERA_IMSI';
                        sNOM_TABLA:= '';
                        sCOD_ACT:= 'E';

                        SELECT FN_RECUPERA_IMSI(vNumSerie)
                        INTO vIMSI
                        FROM DUAL;

                        IF vIMSI='' THEN
                           RAISE ERROR_PROCESO;
                        END IF;

                EXCEPTION
                        WHEN OTHERS THEN
                                 RAISE ERROR_PROCESO;
                END;
----------------------------------------------------- FIN sRecuperaIMSI ----------------------------------------------------
        END IF;

---------------------------------------------------- bExisteAutenticacion --------------------------------------------------
        BEGIN
                nNumError := 45;
                sMsgError := 'Error, al seleccionar funcion INSTR(vClaseServicio,vIdentAutenticacion,1)';
                sNOM_TABLA:='DUAL';
                sCOD_ACT:='S';

                SELECT INSTR(vClaseServicio,vIdentAutenticacion,1)
                INTO nPos
                FROM DUAL;

                IF nPos=0 THEN
                   vClaseServicio:=vClaseServicio || vComando;
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
-------------------------------------------------- FIN bExisteAutenticacion ------------------------------------------------
        BEGIN
                nNumError := 46;
                sMsgError := 'Error, al ingresar datos a ICC_MOVIMIENTO';
                sNOM_TABLA:='ICC_MOVIMIENTO';
                sCOD_ACT:='I';

                IF vValParametro=vCodTecnologia THEN
                        INSERT INTO ICC_MOVIMIENTO (
                        NUM_MOVIMIENTO,
                        NUM_ABONADO,
                        COD_ESTADO,
                        COD_MODULO,
                        NOM_USUARORA,
                        COD_CENTRAL,
                        COD_CENTRAL_NUE,
                        NUM_CELULAR,
                        NUM_CELULAR_NUE,
                        COD_ACTUACION,
                        FEC_INGRESO,
                        NUM_SERIE,
                        COD_SERVICIOS,
                        TIP_TERMINAL,
                        COD_ACTABO,
                        NUM_MIN,
                        NUM_MIN_NUE,
                        TIP_TECNOLOGIA,
                        IMSI,
                        IMEI,
                        ICC
                        ) VALUES (
                        vNumTran,
                        nNumAbonado,
                        '1',
                        vCodModulo,
                        sNomUsuarora,
                        vCentOrig, --CODIGO DE CENTRAL ANTIGUA
                        vCenCelu, --CODIGO DE CENTRAL NUEVA
                        nNumCelular, --NUMERO DE CELULAR ANTIGUO
                        nNewCelular, --NUMERO DE CELULAR NUEVO
                        nAuxCodActIC,
                        SYSDATE,
                        vNumSerieHex, --NUMERO DE SERIE HEXADECIMAL
                        vClaseServicio,
                        vTipTermOrig, --TIPO DE TERMINAL
                        vACTUACION,
                        sNumMin,
                        sNumMinNuev,
                        vCodTecnologia,
                        vIMSI,
                        vNumImei,
                        vNumSerie);
                ELSE
                        INSERT INTO ICC_MOVIMIENTO (
                        NUM_MOVIMIENTO,
                        NUM_ABONADO,
                        COD_ESTADO,
                        COD_MODULO,
                        NOM_USUARORA,
                        COD_CENTRAL,
                        COD_CENTRAL_NUE,
                        NUM_CELULAR,
                        NUM_CELULAR_NUE,
                        COD_ACTUACION,
                        FEC_INGRESO,
                        NUM_SERIE,
                        COD_SERVICIOS,
                        TIP_TERMINAL,
                        COD_ACTABO,
                        NUM_MIN,
                        NUM_MIN_NUE,
                        TIP_TECNOLOGIA
                        ) VALUES (
                        vNumTran,
                        nNumAbonado,
                        '1',
                        vCodModulo,
                        sNomUsuarora,
                        vCentOrig, --CODIGO DE CENTRAL ANTIGUA
                        vCenCelu, --CODIGO DE CENTRAL NUEVA
                        nNumCelular, --NUMERO DE CELULAR ANTIGUO
                        nNewCelular, --NUMERO DE CELULAR NUEVO
                        nAuxCodActIC,
                        SYSDATE,
                        vNumSerieHex, --NUMERO DE SERIE HEXADECIMAL
                        vClaseServicio,
                        vTipTermOrig, --TIPO DE TERMINAL
                        vACTUACION,
                        sNumMin,
                        sNumMinNuev,
                        vCodTecnologia);
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
----------------------------------------------------- FIN sHazSqlMovi ------------------------------------------------------

/************************************************** FIN bInsertaMovimiento *************************************************/

/************************************************** bEjecutarPLCambioNumero ************************************************/
        IF nNumCelular <> nNewCelular THEN
           vOrigen:='0';
        END IF;

        BEGIN
                nNumError := 47;
                sMsgError := 'Error, al seleccionar secuencia desde GA_SEQ_TRANSACABO';
                sNOM_TABLA:='GA_SEQ_TRANSACABO';
                sCOD_ACT:='S';

                SELECT GA_SEQ_TRANSACABO.NEXTVAL
                INTO vNumTran
                FROM DUAL;

                nNumError := 48;
                sMsgError := 'Error, al ejecutar proceso P_INTERFASES_ABONADOS';
                sNOM_PROC := 'P_INTERFASES_ABONADOS';
                sNOM_TABLA:= '';
                sCOD_ACT:= 'E';

                P_INTERFASES_ABONADOS (vNumTran, vACTUACION, nCodProducto, nNumAbonado, vOrigen, nNewCelular, '');

                nNumError := 49;
                sMsgError := 'Error, al seleccionar desde GA_TRANSACABO';
                sNOM_TABLA:='GA_TRANSACABO';
                sCOD_ACT:='S';

                SELECT COD_RETORNO, DES_CADENA
                INTO nCodRetorno, vDesCadena
                FROM GA_TRANSACABO
                WHERE NUM_TRANSACCION = vNumTran;

                nNumError := 50;
                sMsgError := 'Error, al eliminar desde GA_TRANSACABO';
                sNOM_TABLA:='GA_TRANSACABO';
                sCOD_ACT:='D';

                DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = vNumTran;

                IF nCodRetorno=4 THEN
                   RAISE ERROR_PROCESO;
                END IF;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;

/************************************************ FIN bEjecutarPLCambioNumero **********************************************/

/**************************************************** CambiaFrecCliente *****************************************************/

        BEGIN
                nNumError := 51;
                sMsgError := 'Error, al actualizar GA_NUMESPABO';
                sNOM_TABLA:='GA_NUMESPABO';
                sCOD_ACT:='U';

                UPDATE GA_NUMESPABO SET
                NUM_TELEFESP = nNewCelular
                WHERE NUM_TELEFESP =nNumCelular;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;

/************************************************** FIN CambiaFrecCliente ***************************************************/

/**************************************************** bBorraResNumCel ****************************************************/
        BEGIN
                nNumError := 52;
                sMsgError := 'Error, al eliminar desde GA_RESNUMCEL';
                sNOM_TABLA:='GA_RESNUMCEL';
                sCOD_ACT:='D';

                DELETE GA_RESNUMCEL
                WHERE NUM_TRANSACCION = vNumTransacVta
                AND NUM_LINEA = 1
                AND NUM_ORDEN = 1;

        EXCEPTION
                WHEN OTHERS THEN
                         RAISE ERROR_PROCESO;
        END;
/************************************************** FIN bBorraResNumCel **************************************************/

        nCOD_ERROR:=0;
        sMEN_ERROR:='Operacion Exitosa.';


EXCEPTION
        WHEN ERROR_PROCESO THEN
                BEGIN
                        sCOD_SQLCODE:=SQLCODE;
                        sCOD_SQLERRM:=SQLERRM;

                        ROLLBACK;

                        INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
                        NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
                        VALUES(vACTUACION,nNumAbonado,SYSDATE,1,sNOM_PROC,sNOM_TABLA,sCOD_ACT,
                        sCOD_SQLCODE,sCOD_SQLERRM);

                        nCOD_ERROR:=nNumError;
                        sMEN_ERROR:=sMsgError;
                END;

END;
/
SHOW ERRORS
