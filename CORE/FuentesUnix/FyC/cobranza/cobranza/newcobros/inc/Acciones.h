/* ============================================================================= 
    Tipo        :  DEFINICIONES GENERALES
    Nombre      :  Acciones.h
    Descripcion :  Contiene las definiciones de los punteros a funcion, contenidos
                   en la biblioteca libAcciones.a
                   Al agregar o eliminar una funcion en dicha biblioteca, esto debe 
                   ser reflejado en este archivo, ya que posteriormente será enlazado 
                   con los procesos para generar las aplicaciones.
    Autor       :  Roy Barrera Richards                 
    Fecha       :  09 - Agosto - 2000 
 ============================================================================= */
/* Modificada 04-11-2004 por Proyecto P-MAS-04037 Mejoras Ejecutor y Excluidor */
/* ----------------------------------------------------------------------------- */
/* Define la cantidad de funciones (acciones) y Declara los prototipos de todas  */
/* ----------------------------------------------------------------------------- */
#define MAXACC  28   /* maximo de acciones */

char *szfnAsigCobExt(FILE **ptArchLog, long lCliente, sql_context ctxCont );        /*Asigna cliente a entidad de cobranza externa ( cobranza pre-judicial) */
char *szfnAsigCobJud(FILE **ptArchLog, long lCliente, sql_context ctxCont );        /*Asigna cliente a entidad de cobranza judicial */
char *szfnAsigEjecPerfil(FILE **ptArchLog, long lCodCliente, sql_context ctxCont);  /*Asigna Ejecutivo (a) por Perfil */
char *szfnAsigEJecCobCen(FILE **ptArchLog, long lCodCliente, sql_context ctxCont);  /*Asigna Agente de Cobranza Central */
char *szfnAsigEJecCobSuc(FILE **ptArchLog, long lCliente, sql_context ctxCont );    /*Asigna Agente de Cobranza de Sucursal */
char *szfnBaja(FILE **ptArchLog, long lCliente, sql_context ctxCont );              /*Da de baja a todos los abonados del cliente dado */
char *szfnBloquea(FILE **ptArchLog, long lCodCliente, sql_context ctxCont);         /*Bloquea a todos los abonados de un cliente */
char *szfnCtaFinal(FILE **ptArchLog, long lCliente, sql_context ctxCont );          /*Actualizacion de pto de gestion en la co_morosos */
char *szfnDesAsigCobExt(FILE **ptArchLog, long lCliente, sql_context ctxCont );     /*DesAsigna cliente de entidad de cobranza externa ( cobranza pre-judicial) */
char *szfnDesBloquea(FILE **ptArchLog, long lCodCliente, sql_context ctxCont);      /*DesBloquea a todos los abonados de un cliente */
char *szfnMensCorta(FILE **ptArchLog, long lCliente, sql_context ctxCont);          /*Envia mensajes cortos a abonados del cliente */
char *szfnNewMensCorta(FILE **ptArchLog, long lCliente, sql_context ctxCont);       /*Envia mensajes cortos a abonados del cliente */
char *szfnPreBaja(FILE **ptArchLog, long lCliente, sql_context ctxCont );           /*Actualizacion de pto de gestion en la co_morosos */
char *szfnRepone(FILE **ptArchLog, long lCliente, sql_context ctxCont);             /*Repone los abonados de un cliente. Basado en Exclu_dia */
char *szfnRepBi(FILE **ptArchLog, long lCliente, sql_context ctxCont);              /*Repone los abonados de un cliente. Basado en Exclu_dia */
char *szfnSuspeTot(FILE **ptArchLog, long lCliente, sql_context ctxCont);           /*Suspencion Bidireccional a todos los abonados de un cliente */
char *szfnSuspeUni(FILE **ptArchLog, long lCliente, sql_context ctxCont);           /*Suspencion Unidireccional a todos los abonados de un cliente */
char *szfnRevBaja(FILE **ptArchLog, long lCliente, sql_context ctxCont);            /*Reversa la baja de todos los abonados del cliente dado*/
char *szfnAsigDicom(FILE **ptArchLog, long lCliente, sql_context ctxCont);          /*Asigna a dicom un cliente dado */
char *szfnDesAsigDicom(FILE **ptArchLog, long lCliente, sql_context ctxCont);       /*DesAsigna de dicom un cliente dado */
char *szfnCartaCob(FILE **ptArchLog, long lCliente, sql_context ctxCont);           /*Envia registro en archivo para generacion de cartas de cobranza */
char *szfnOutBound(FILE **ptArchLog, long lCliente, sql_context ctxCont);           /*Inserta registros en archivo con los abonados de un cliente */
char *szfnEnrutamiento(FILE **ptArchLog, long lCliente, sql_context ctxCont );	   /*Indica a centrales enrutamiento de llamadas del cliente a servicio de cobro */
char *szfnDesEnrutamiento(FILE **ptArchLog, long lCliente, sql_context ctxCont );   /*Indica a centrales anulacion del enrutamiento de llamadas del cliente a servicio de cobro */
char *szfnSuspBeep(FILE **ptArchLog, long lCliente, sql_context ctxCont );		      /*Suspencion Unidireccional a todos los abonados beepers de un cliente */
char *szfnMensAviso(FILE **ptArchLog, long lCliente, sql_context ctxCont );		   /*Envia mensajes cortos a abonados del cliente */
char *szfnMensFact(FILE **ptArchLog, long lCliente, sql_context ctxCont );		      /*Envia mensajes al cliente en la factura */
char *szfnCambioNumero(FILE **ptArchLog, long lCliente, sql_context ctxCont );      /*Enruta llamadas a optros numeros de acuerdo al pto de gestion*/
/* ----------------------------------------------------------------------------- */
/* Define la estructura para almacenar los punteros a las funciones              */ 
/* ----------------------------------------------------------------------------- */
typedef struct func_acc
{
  char szCodigo[6];
  char *(*szNombre) (FILE **ArchLog , long, sql_context);
} PUNT_FUNCION_ACC;  /* Punteros a Funciones */

/* ----------------------------------------------------------------------------- */
/* Llenado de la estructura 'funcion' para manejar las invocaciones              */
/* Utilizar 'stAccion[i].szCodigo' 'stAccion[i].szNombre'*/
/* ----------------------------------------------------------------------------- */
PUNT_FUNCION_ACC stAccion[] =	{
                                    "ACEXT\0",szfnAsigCobExt
                                    ,"ACJUD\0",szfnAsigCobJud
                                    ,"AEPER\0",szfnAsigEjecPerfil
                                    ,"AEPLA\0",szfnAsigEJecCobCen
                                    ,"AEJCS\0",szfnAsigEJecCobSuc
                                    ,"BAJA\0" ,szfnBaja
                                    ,"BLOQU\0",szfnBloquea
                                    ,"CTAFN\0",szfnCtaFinal
                                    ,"DACEX\0",szfnDesAsigCobExt
                                    ,"DESBL\0",szfnDesBloquea
                                    ,"MENSJ\0",szfnMensCorta
                                    ,"NMENS\0",szfnNewMensCorta
                                    ,"MFACT\0",szfnMensFact
                                    ,"AVENC\0",szfnMensAviso 
                                    ,"PREBJ\0",szfnPreBaja
                                    ,"REPOS\0",szfnRepone
                                    ,"REPBI\0",szfnRepBi
                                    ,"SUSBI\0",szfnSuspeTot
                                    ,"SUSUN\0",szfnSuspeUni
									         ,"RBAJA\0",szfnRevBaja
									         ,"ASDIC\0",szfnAsigDicom
									         ,"DADIC\0",szfnDesAsigDicom
									         ,"CARTA\0",szfnCartaCob
                                    ,"OUTBD\0",szfnOutBound
                                    ,"ENRUT\0",szfnEnrutamiento
                                    ,"DENRT\0",szfnDesEnrutamiento
                                    ,"CANUM\0",szfnCambioNumero
								}; 
/* ----------------------------------------------------------------------------- */


/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisión                                            : */
/**  %PR% */
/** Autor de la Revisión                                : */
/**  %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creación de la Revisión                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

