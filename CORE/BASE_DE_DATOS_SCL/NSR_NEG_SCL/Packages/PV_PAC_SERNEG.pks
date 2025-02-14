CREATE OR REPLACE PACKAGE PV_PAC_SERNEG IS
   --******************************************************************************************
   --** PROGRAMA    PV_PAC_SERNEG.PCK           SISTEMA      SERIALES NEGATIVOS              **
   --** PROGRAMO    A LOT OF PEOPLE    INDRA    VER INICIAL  17-JUN-2003  14:20              **
   --**             FERNANDO CAMACHO   AZERTIA  VER FINAL    19-JUL-2007  09:20              **
   --** ACTUALIZO   FREDDY MELO ACOSTA AZERTIA               11 OCT 2007  17:30              **
   --**                                                                                      **
   --** DESCRIPCION Paquete de procedimientos para el Cargue y generacion de archivos de     **
   --**             archivos de Seriales Negativos desde aplicacio9nes WINDOWS. Se toma      **
   --**             este paquete del original de ELITE y se actualiza para su operacion      **
   --**             en SCL. Las adecuaciones implican modificar algunas tablas utilizadas    **
   --**             en ELITE. En esta version se omite el uso de la libreria ICEXESYS.       **
   --**             Se incluye la funcion SUBSTRING y se crean procedures para el manejo     **
   --**   11 OCT 2007. FREDDY MELO ACOSTA. AZERTIA. Cambio RELEASE 2.1.                      **
   --**   Se modifica PV_P_SERNEG_ALTA y PV_P_SERNEG_BAJA para permitir la grabacion del     **
   --**   usuario que relamente origina la accion y no el USER de conexion de la B.D.        **
   --**   Se genera MERGE de versiones para produccion: USUARIO grabador, MODULO SN y no PV  **
   --**                                                                                      **
   --**   02 NOV 2007. FREDDY MELO ACOSTA. AZERTIA. Cambio RELEASE 2.1. **
   --**   AHORA  debera tener en cuenta que el serial que se envia a historicos no tenga la  **
   --**   CAUSA_HIST en NULO. En tal caso, le pone el COD_CAUSA. CA-1178 31 OCT 2007.        **
   --**                                                                                      **
   --** NOTA        Y se queds pensativa al ver que el azul del cielo siempre alejandose iba **
   --**                                                                     Julio Florez     **
   --** ULTIMA MODIFICACION: 05/11/2007. Juan Carlos Ribero. Se agrega procedure             **
   --** PV_P_SERNEG_BORRA con el cual se borrar`n seriales sin validar su existencia en la   **
   --** tabla PVC_NSNEGAT.                                                                   **
   --******************************************************************************************
   TYPE SerialNegCurTyp    IS REF CURSOR;
   TYPE BuscarCurTyp       IS REF CURSOR;
   TYPE ListaDetalleCurTyp IS REF CURSOR;
   TYPE ListaMaestroCurTyp IS REF CURSOR;

    /*Procedimiento para dar de alta un serial de proceso individual*/
    -- Procedimiento ingresa un serial de proceso individual en la tabla pvc_nsnegat*/
    PROCEDURE PV_P_SERNEG_ALTA (
       P_NSRELECTRONICO  IN        VARCHAR2,
       P_CODOPERADOR     IN        VARCHAR2,
       P_CODARTICULO     IN        VARCHAR2,
       P_NSRMECANICO     IN        VARCHAR2,
       P_NSRHEXADECIMAL  IN        VARCHAR2,
       P_INDPROCEQUI     IN        VARCHAR2,
       P_CODABONADO      IN        VARCHAR2,
       P_CODMODULO       IN        VARCHAR2,
       P_INDESTADO       IN        VARCHAR2,
       P_NOMFICHERO      IN        VARCHAR2,
       P_CODCAUSA        IN        VARCHAR2,
       P_RESULTADO       OUT       VARCHAR2,
       P_DESERROR        OUT       VARCHAR2,
       P_CODERROR        OUT       NUMBER,
       P_NOMUSUARORA     IN        VARCHAR2 DEFAULT NULL);

    /* Procedimiento para dar de baja los seriales negativos de proceso individual*/

    PROCEDURE   PV_P_SERNEG_BORRA   (
       P_NSRELECTRONICO  IN        VARCHAR2,
       P_CODOPERADOR     IN        VARCHAR2,
       P_FICHEROFINAL    IN        VARCHAR2,
       P_INDESTADOFINAL  IN        VARCHAR2,
       P_CODCAUSAFINAL   IN        VARCHAR2,
       P_RESULTADO       IN  OUT   VARCHAR2,
       P_DESERROR        IN  OUT   VARCHAR2,
       P_CODERROR        OUT       NUMBER,
       P_CODCAUSA        IN        VARCHAR2 DEFAULT NULL,
       P_DFECHA          IN        VARCHAR2                   DEFAULT NULL,
       P_NOMUSUARORA     IN        VARCHAR2                   DEFAULT NULL);

END PV_PAC_SERNEG;
/
SHOW ERROR