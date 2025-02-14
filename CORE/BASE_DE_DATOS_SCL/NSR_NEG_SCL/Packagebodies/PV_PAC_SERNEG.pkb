CREATE OR REPLACE PACKAGE BODY PV_PAC_SERNEG IS
   --******************************************************************************************
   --** PROGRAMA    PV_PAC_SERNEG.PCK           SISTEMA      SERIALES NEGATIVOS              **
   --** PROGRAMO    A LOT OF PEOPLE.    INDRA    VER INICIAL  17-JUN-2003  14:20             **
   --**             FERNANDO CAMACHO.   AZERTIA  VER FINAL    19-JUL-2007  09:20             **
   --** ACTUALIZO   FREDDY MELO ACOSTA. AZERTIA               02-NOV-2007  17:30             **
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
   --** NOTA        "El mundo era tan reciente que muchas cosas carecian de nombre..."       **
   --**                                                         Gabriel Garcia Marquez       **
   --** 05/11/2007. Juan Carlos Ribero. Se agrega procedure             **
   --** PV_P_SERNEG_BORRA con el cual se borraràn seriales sin validar su existencia en la   **
   --** tabla PVC_NSNEGAT.                                                                   **
   --** ULTIMA MODIFICACION: 28/02/2008. Juan Carlos Ribero - INDRA. Se modifica proceso de  **
   --** ingreso de un serial negativo para que asigne un cero al campo NSR_HEXADECIMAL si la **
   --** tecnologia es GSM.																	                                 **
   --******************************************************************************************
   V_EXCEPTION_SINIESTRO  EXCEPTION;

   -- Procedimiento ingresa un serial de proceso individual en la tabla pvc_nsnegat*/
   PROCEDURE  PV_P_SERNEG_ALTA (
      P_NSRELECTRONICO  IN  VARCHAR2,
      P_CODOPERADOR     IN  VARCHAR2,
      P_CODARTICULO     IN  VARCHAR2,
      P_NSRMECANICO     IN  VARCHAR2,
      P_NSRHEXADECIMAL  IN  VARCHAR2,
      P_INDPROCEQUI     IN  VARCHAR2,
      P_CODABONADO      IN  VARCHAR2,
      P_CODMODULO       IN  VARCHAR2,
      P_INDESTADO       IN  VARCHAR2,
      P_NOMFICHERO      IN  VARCHAR2,
      P_CODCAUSA        IN  VARCHAR2,
      P_RESULTADO       OUT VARCHAR2,
      P_DESERROR        OUT VARCHAR2,
      P_CODERROR        OUT NUMBER,
      P_NOMUSUARORA     IN  VARCHAR2 DEFAULT NULL) IS
      VP_TIPTECNOLOGIA  VARCHAR2(255);
      VP_TAMASERIAL     NUMBER(4);

      -- Freddy Melo Acosta (AZERTIA) 17 de Sept de 2007 09:30
      -- Modificacion del proceso para recibir el USER que graba los datos sobre
      -- la variable VP_USUARIO como copia de lo ingresado en P_NOMUSUARORA.
      VP_USUARIO        VARCHAR2(70)  :=  P_NOMUSUARORA;
      -- PL/SQL Block
      -- 04/03/2008 (JQM): Variable temporal para almacenar valor de P_NSRHEXADECIMAL, validar tipo de tecnologia y utilizar en los inserts
      VP_NSRHEXADECIMAL_TEMP VARCHAR2(8) := '0';
   BEGIN
      -- Verificacion del contenido del usuario del sistema que hace la operacion.
      /*IF VP_USUARIO IS NULL THEN
         VP_USUARIO := USER;
      END IF;

      -- Paso 1: Obtiene la tecnología
      P_CODERROR := 801;
      P_DESERROR := 'Va a PV_OBTIENE_TECNOLOGIA';
      PV_OBTIENE_TECNOLOGIA (P_CODARTICULO, VP_TIPTECNOLOGIA,
       										 P_RESULTADO, P_DESERROR, P_CODERROR);
      IF P_RESULTADO = 'C' THEN
         P_CODERROR := 802;
         P_DESERROR := 'Evalua P_INDPROCEQUI y si P_CODARTICULO is NULL';
         IF P_INDPROCEQUI = 'E' AND P_CODARTICULO IS NULL THEN
            VP_TAMASERIAL := LENGTH(P_NSRELECTRONICO);
            IF VP_TAMASERIAL = 15 THEN
               VP_TIPTECNOLOGIA :='GSM';
            END IF; -- IF VP_TAMASERIAL = 15 THEN
         END IF; -- IF P_INDPROCEQUI = 'E' AND P_CODARTICULO IS NULL THEN
      END IF; -- IF P_RESULTADO = 'C' THEN

      -- Paso 2
      -- Inserta los datos en PVC_NSNEGAT
      IF P_RESULTADO = 'C' THEN
         BEGIN
         	  -- 04/03/2008 (JQM): Variable temporal para almacenar valor de P_NSRHEXADECIMAL, validar tipo de tecnologia y utilizar en los inserts
            -- 28/02/2008. Juan Carlos Ribero - INDRA. Inicio.
         	  -- Si la tecnologia es GSM el valor para NSR_HEXADECIMAL siempre debe ser cero.
            IF VP_TIPTECNOLOGIA = 'GSM' THEN
            	VP_NSRHEXADECIMAL_TEMP := '0';
            ELSE
              VP_NSRHEXADECIMAL_TEMP := P_NSRHEXADECIMAL;
            END IF;

            -- 28/02/2008. Juan Carlos Ribero - INDRA. Fin.
            P_CODERROR := 803;
            P_DESERROR := P_DESERROR || '  >INSERTA EN PVC_NSNEGAT = ';
            -- 04/03/2008 (JQM): Se utliza variable temporal para almacenar valor de NSR_HEXADECIMAL.
            INSERT INTO PVC_NSNEGAT
               (NSR_ELECTRONICO, FEC_ALTA, NOM_USUARORA, COD_OPERADOR,
               COD_ARTICULO, NSR_MECANICO, NSR_HEXADECIMAL, IND_PROCEQUI,
               COD_ABONADO, COD_MODULO,  IND_ESTADO, NOM_FICHERO,
               COD_CAUSA, TIP_TECNOLOGIA)
            VALUES  (P_NSRELECTRONICO,  SYSDATE, VP_USUARIO,
               P_CODOPERADOR, P_CODARTICULO, P_NSRMECANICO,
               VP_NSRHEXADECIMAL_TEMP, P_INDPROCEQUI, P_CODABONADO,
               P_CODMODULO, P_INDESTADO, P_NOMFICHERO,
               P_CODCAUSA, VP_TIPTECNOLOGIA);
            IF SQL%ROWCOUNT <> 0 THEN
               P_RESULTADO := 'C';
            ELSE
               P_RESULTADO := 'E';
               P_DESERROR  := P_DESERROR||'; no se inserto registro en PVC_NSNEGAT';
            END IF;
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
               P_DESERROR  := P_DESERROR || ('ERROR. El registro con serial ' || P_NSRELECTRONICO || ' y operador '  || TO_CHAR(P_CODOPERADOR)) || ' ya existe. ';
               P_RESULTADO := 'E';
               P_CODERROR  := 20301;
            WHEN OTHERS THEN
               P_DESERROR := P_DESERROR || ' ERROR. Falló el proceso de INS en PV_P_SERNEG_ALTA: '||SQLERRM;
               P_RESULTADO := 'E';
               P_CODERROR := 20302;
               -- RAISE_APPLICATION_ERROR (-20302, P_DESERROR ||  SQLERRM);
         END;
      END IF;*/

	  P_RESULTADO := 'C';
      -- Salida correcta
      IF P_RESULTADO = 'C' THEN
         P_CODERROR := 0;
         P_DESERROR := '0K';
      END IF;
   EXCEPTION WHEN OTHERS THEN
      P_DESERROR := ' ERROR. Falló el proceso de alta PV_P_SERNEG_ALTA ';
      P_RESULTADO := 'E';
      P_CODERROR := 20303;
   END;   -- PROCEDURE PV_P_SERNEG_ALTA


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
       P_NOMUSUARORA     IN        VARCHAR2                   DEFAULT NULL) IS
       VP_CODOPERADORBS  VARCHAR2(255);
       dFecha            DATE                              := NULL;
       -- Freddy Melo Acosta (AZERTIA) 17 de Sept de 2007 09:30
       -- Modificacion del proceso para recibir el USER que graba los datos sobre
       -- la variable VP_USUARIO como copia de lo ingresado en P_NOMUSUARORA.
       VP_USUARIO        VARCHAR2(70)  :=  P_NOMUSUARORA;
       -- PL/SQL Block

   BEGIN
       -- Paso 1: Verificacion del contenido del usuario del sistema que hace la operacion.
       /*IF VP_USUARIO IS NULL THEN
          VP_USUARIO := USER;
       END IF;

       -- Paso 2: Inserta el registro en PVC_HISTNSNEGAT
       IF (P_DFECHA IS NOT NULL) THEN
          P_CODERROR := 813;
          P_DESERROR := 'dFecha '||P_DFECHA;
          dFecha     := TO_DATE (P_DFECHA,'dd/mm/yyyy hh24:mi:ss');
       END IF;
       P_RESULTADO := 'E';
       P_CODERROR := 814;
       P_DESERROR := 'Va a PV_INSERTA_PVCLOGNSNEGAT';
       PV_INSERTA_PVCLOGNSNEGAT (P_NSRELECTRONICO, P_CODOPERADOR, P_INDESTADOFINAL, P_FICHEROFINAL,
          P_CODCAUSAFINAL, P_RESULTADO, P_DESERROR, P_CODERROR, P_CODCAUSA, dFecha, VP_USUARIO);

       -- Paso 2: Borra el registro en PVC_NSNEGAT
       IF P_RESULTADO = 'C' THEN
          P_RESULTADO := 'E';
          P_CODERROR  := 815;
          P_DESERROR  := 'Va a PV_BORRA_PVCNSNEGAT';
          PV_BORRA_PVCNSNEGAT  (P_NSRELECTRONICO, P_CODOPERADOR,
             P_RESULTADO, P_DESERROR, P_CODERROR, P_CODCAUSA, dFecha);
       END IF;*/

	   P_RESULTADO := 'C';
       -- Salida correcta
       IF P_RESULTADO = 'C' THEN
          P_DESERROR := 'Dado de baja el serial ' || P_NSRELECTRONICO || 'con operador '  || TO_CHAR(P_CODOPERADOR);
          P_CODERROR := 0;
          COMMIT;
       ELSE
          ROLLBACK;
       END IF;
   EXCEPTION  WHEN OTHERS THEN
       P_CODERROR  := 20339;
     	 P_DESERROR  := 'Error en PV_P_SERNEG_BORRA, SQLERRM : '||SQLERRM;
     	 P_RESULTADO := 'E';
   END PV_P_SERNEG_BORRA;    --PROCEDURE PV_P_SERNEG_BORRA

END; --PACKAGE BODY PV_PAC_SERNEG
/
SHOW ERROR