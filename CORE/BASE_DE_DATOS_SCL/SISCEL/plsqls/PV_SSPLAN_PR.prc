CREATE OR REPLACE PROCEDURE PV_SSPLAN_PR(
        vPLANTARIF      IN VARCHAR2,
        vSERVICIO       IN VARCHAR2,            -- CODIGO DE SERVICIO
        vRELACION       IN VARCHAR2,            -- TIPO DE RELACION
        dDESDE          IN VARCHAR2 ,               -- FECHA DE INICIO
        dHASTA          IN VARCHAR2 ,           -- FECHA DE HASTA
        nMENSAJE        IN NUMBER,          -- MENSAJE DE ERROR
        nSERVSUPL       IN NUMBER,
        nInd_Accion     IN NUMBER,     -- flag para conocer que se realizara si una consulta o una actualizacion
        vRes            OUT VARCHAR2
)
IS

        sMsgError       VARCHAR2(5);         -- mensaje de verdadero o false
        nNumError       NUMBER(2);                      -- numero de mensaje
        mFecdes         DATE;                           -- fecha desde sujeta a modificacion
        sMsgerrores     VARCHAR2(70);       -- mensaje de error texto
        Rrespuesta      VARCHAR2(100);

        ERROR_PROCESO EXCEPTION;

        vCodProducto    GAD_SERVSUP_PLAN.COD_PRODUCTO%TYPE;
        vPlantarifa     GAD_SERVSUP_PLAN.COD_PLANTARIF%TYPE;
        vCodservicio    GAD_SERVSUP_PLAN.COD_SERVICIO%TYPE;
        vtiporelacion   GAD_SERVSUP_PLAN.TIP_RELACION%TYPE;
        vFecDesde       GAD_SERVSUP_PLAN.FEC_DESDE%TYPE;
        vFecHasta       GAD_SERVSUP_PLAN.FEC_HASTA%TYPE;
        vCodMensaje     GAD_SERVSUP_PLAN.COD_MENSAJE%TYPE;
        vformato        GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormato7       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN
/* INI COL|36787|07/03/2007|SAQL */
        --vformato := GE_FN_DEVVALPARAM('GA', 1, 'FORMATO_SEL2');
        --vformato7 := GE_FN_DEVVALPARAM('GA', 1, 'FORMATO_SEL7');
        vformato := GE_FN_DEVVALPARAM('GE', 1, 'FORMATO_SEL2');
        vformato7 := GE_FN_DEVVALPARAM('GE', 1, 'FORMATO_SEL7');
/* FIN COL|36787|07/03/2007|SAQL */

        vres :='TRUE';
        /*Rrespuesta := PV_FN_VER_EXIST(vPLANTARIF,vSERVICIO,vRELACION,TO_DATE(dDESDE,vformato));

        IF Rrespuesta = 'TRUE' AND nInd_Accion = 0
        THEN
                vres :='FALSE|01|Este Registro ya Existe en la Tabla';
                RAISE ERROR_PROCESO;
        End if;
         */
        IF vRELACION = '1' THEN
                dbms_output.put_line('**');
        ELSIF vRELACION = '2' THEN
                dbms_output.put_line('**');
        ELSIF vRELACION = '3'  THEN
                Rrespuesta :=  PV_FN_VER_INCOMP_SSPLAN(vPLANTARIF,vSERVICIO);
                IF Rrespuesta = 'TRUE' THEN
                        vres := 'FALSE|03|El servicio es incompatible con uno que ya existe';
                        RAISE ERROR_PROCESO;
                END IF;

                Rrespuesta := PV_FN_VER_INCOMP_SSPLAN_GRUPO(vPLANTARIF,nSERVSUPL);
                IF Rrespuesta= 'TRUE' THEN
                        vres:='FALSE|04|El servicio es incompatible con un grupo que ya existe';
                        RAISE ERROR_PROCESO;
                END IF;

        ELSIF vRELACION= '4' THEN

                Rrespuesta := PV_FN_VER_INCOMP_SSPLAN(vPLANTARIF,vSERVICIO);
                IF Rrespuesta = 'TRUE' THEN
                        vres := 'FALSE|05|El servicio es incompatible con uno que ya existe';
                        RAISE ERROR_PROCESO;
                END IF;

                Rrespuesta := PV_FN_VER_INCOMP_SSPLAN_GRUPO(vPLANTARIF,nSERVSUPL);
                IF Rrespuesta = 'TRUE' THEN
                        vres := 'FALSE|06|El servicio es incompatible con un grupo que ya existe';
                        RAISE ERROR_PROCESO;
                END IF;

        ELSIF vRELACION = '5' THEN
                dbms_output.put_line('**');
        END IF;

        Rrespuesta := PV_VER_VIGENCIA_FN(vPLANTARIF,
                                         vSERVICIO,
                                                                         vRELACION,
                                                                         TO_DATE(dDESDE,vformato||' '||vFormato7),
                                                                         TO_DATE(dHASTA,vformato||' '||vFormato7),
                                                                         nMENSAJE,
                                                                         nInd_Accion);

        vres:=Rrespuesta;

        raise ERROR_PROCESO;

EXCEPTION
        WHEN ERROR_PROCESO
        THEN
                dbms_output.put_line('-->'||vRes);
END PV_SSPLAN_PR;
/
SHOW ERRORS
