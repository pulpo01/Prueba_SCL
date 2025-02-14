CREATE OR REPLACE PACKAGE IC_PROVISION_PG
/*
<Documentación
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "IC_PROVISION_PG"
      Lenguaje="PL/SQL"
      Fecha creación="06-09-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripción>Rutinas para Provision </Descripción>
      <Parámetros>
         <Entrada>N/A</Entrada>
         <Salida>N/A</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
        CV_error_no_clasif   CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
        CV_cod_modulo        CONSTANT VARCHAR2 (2)  := 'GA';
        CV_cod_moduloIC      CONSTANT VARCHAR2 (2)  := 'IC';
        CN_cod_producto      CONSTANT NUMBER(1)  := 1;
        CV_param_actabodef   CONSTANT VARCHAR2(8) :='ACT_DEF';
        CV_cod_actabodef     CONSTANT VARCHAR2 (2)  := 'XX';
        CV_version           CONSTANT VARCHAR2 (3)  := '1.0';
        CV_Altamira             CONSTANT VARCHAR2(3) := 'AA';
        CV_SituacionAAA         CONSTANT VARCHAR2(3) := 'AAA';
        CN_desbloqueado      CONSTANT NUMBER := 0;
        CN_EstPendActivacion CONSTANT NUMBER := 9;
        CV_DescEstado        CONSTANT VARCHAR2(16) := 'PENDIENTE';
        CN_Err_Cli           CONSTANT NUMBER(3) := 149;
        CV_Err_NoClasif      CONSTANT VARCHAR2(25) := 'Error no Clasificado';
        TYPE refCursor IS REF CURSOR;

------------------------------------------------------------
PROCEDURE IC_INSERTA_PR ( EO_PROVISION IN IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER );

------------------------------------------------------------
PROCEDURE IC_BUSCA_ABONADOS_PR (EN_COD_CLIENTE IN NUMBER,
                                EN_PRODCONTRATADO IN pr_productos_contratados_to.cod_prod_contratado%TYPE,
                                SO_ABONADOS OUT NOCOPY IC_PROVISION_LST_QT,
                                SN_ERROR OUT NOCOPY NUMBER,
                                SV_MENSAJE OUT NOCOPY VARCHAR2,
                                SN_EVENTO OUT NOCOPY NUMBER);

-----------------------------------------------------------
PROCEDURE IC_PROV_ABONADO_PR ( EO_PROVISION IN IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER );

------------------------------------------------------------
PROCEDURE IC_OBTIENE_ACTUACION_PR ( EO_PROVISION IN OUT NOCOPY IC_PROVISION_QT,
                                                               SN_COD_ESPEC_PROV OUT NOCOPY NUMBER,
                                                               SV_COD_ACTUACION OUT NOCOPY VARCHAR2,
                                                               SV_IND_BAJATRANS OUT NOCOPY VARCHAR2,
                                                               SV_COD_ACTABO OUT NOCOPY VARCHAR2,
                                                               SN_ERROR OUT NOCOPY NUMBER,
                                                               SV_MENSAJE OUT NOCOPY VARCHAR2,
                                                               SN_EVENTO OUT NOCOPY NUMBER );

------------------------------------------------------------
PROCEDURE IC_OBTIENE_CODPERIODICIDAD_PR ( EN_NUM_ABONADO IN NUMBER,
                                          SV_COD_PER_REC OUT NOCOPY VARCHAR2,
                                          SV_COD_PER_SMS OUT NOCOPY VARCHAR2,
                                          SN_ERROR OUT NOCOPY NUMBER,
                                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                                          SN_EVENTO OUT NOCOPY NUMBER );

------------------------------------------------------------
PROCEDURE IC_CODPERIODICIDAD_PR ( EN_NOM_CICLO IN VARCHAR2,
                                  EN_FILA      IN NUMBER,
                                  SV_CODPER OUT NOCOPY VARCHAR2,
                                  SN_ERROR OUT NOCOPY NUMBER,
                                  SV_MENSAJE OUT NOCOPY VARCHAR2,
                                  SN_EVENTO OUT NOCOPY NUMBER );
------------------------------------------------------------
PROCEDURE IC_ELIMINA_PR ( EO_PROVISION IN IC_PROVISION_QT,
                          SN_ERROR OUT NOCOPY NUMBER,
                          SV_MENSAJE OUT NOCOPY VARCHAR2,
                          SN_EVENTO OUT NOCOPY NUMBER );

END IC_PROVISION_PG;
/
SHOW ERRORS
