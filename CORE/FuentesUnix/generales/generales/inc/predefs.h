
#define IMPUESTO     1
#define DESCUENTO    2
#define ARTICULO     3
#define CARRIER      4

#define iACCESO_PARALLEL 2
#define iACCESO_MEM      1
#define iACCESO_ORACLE   0

/* Indicativo Estado (Fa_PreFactura) */
#define EST_NORMAL   0
#define EST_DTO      1 /* Apliacado Descuento */
#define EST_IMPTO    2 /* Apliacado Impuesto  */

/* Indicativo de Actuacion */
#define NORMAL       1
#define BAJA         2
#define TRASPASO     3
#define LIQUIDACION  4
#define RECHAZO      5

/**************************************************************/
/* Tipos de Facturas que tienen una relacion con los Tipos de */
/* Documentos definidos en Fa_DatosGener y que son defines de */
/* uso interno de Facturacion (la relacion es uno a uno)      */
/**************************************************************/
#define FACT_CONTADO     1    /* Factura Contado              */
#define FACT_CICLO       2    /* Factura Ciclo                */        
#define FACT_NOTACRED    3    /* Nota de Credito              */         
#define FACT_NOTADEBI    4    /* Nota de Debito               */         
#define FACT_MISCELAN    5    /* Factura Miscelanea           */
#define FACT_COMPRA      6    /* Factura de Compra            */
#define FACT_BAJA        7    /* Factura de Baja              */
#define FACT_LIQUIDACION 8    /* Factura de Liquidacion       */ 
#define FACT_RENTAPHONE  9    /* Factura de Rent Phone        */
#define FACT_ROAMINGVIS  10   /* Factura de Roaming Visitante */

/* Estado del Proceso */
#define PROC_EJECUTANDOSE 0
#define PROC_CORRECTO     1
#define PRE_INCORRECTO    2
#define COM_INCORRECTO    3
#define IMP_INCORRECTO    4

/* Estado Ciclo Facturacion */
#define CICL_NOFACTURADO   0
#define CICL_ENPROCESO     1
#define CICL_FACTURADO     2 


/* Productos */
#define iCELULAR  1
#define CELULAR   1
#define iBEEPER   2
#define BEEPER    2
#define iTRUNKING 3
#define iTREK     4
#define iGENERAL  5

/* IndTabal->(TA_CONCEPFACT) */
#define FRASOC     1
#define ACUMOPER   2
#define ROAMING    3

/* Tipo de Descuento */
#define NOTPORCIEN 0 /* No Expresado  en % */ 
#define PORCENTAJE 1 /* Expresado en %     */

/* IndCuadrante =1 (Ve_CtoPlan)=>Rango de Umbral en Ve_CuadCtoPlan */
#define IND_CUAD 1

/* Indicativo de Generacion de Cuotas en Ge_Cargos */
#define IND_CUOTA 1

/* Indicativo de Facturable */
#define FACTURABLE 1

/* Tipo de Cobro (Fa_GrupoCob) */
#define VENCIDO    0
#define ANTICIPADO 1

/* Tipo de Direccion de Facturacion */
#define TIPDIRECCION_FACTURA 1
#define iTIP_CORRESPONDENCIA 3

/* Tipo de Servicios */
#define SERV_OCASIONAL     "1"
#define SERV_SUPLEMENTARIO "2" 

/* Modulo de Facturacion or CodActAbo */
#define MOD_FACTURACION "FA"

/* Codigo de Tipo de Cuadrante en el Dto */
#define MONTO   0
#define VOLUMEN 1

/* IndNumero => NumPlexis 1 (Ga_Intar%) */
#define NO_PLEXIS 0

/* CodTipDescu Articulo */
#define TIPDESCU_ART "A"

/* Tipo de Plan Tarifario */
#define szINDIVIDUAL "I"
#define szHOLDING    "H"
#define szEMPRESA    "E"

/* Indicadores de Entrante/Saliente */
#define iENTRANTE 1
#define iSALIENTE 2

/* Franjas Horarias  (CodFranHoraSoc) */
#define iFRANBAJA   1
#define iFRANNORMAL 2

/* Palabra a Clave a sustituir en la Impresion por el Numero de Folio */
#define szClave_NumFolio "#Num_Folio#"

/* Modalidad de Venta Regalo */

#define iCONTADO        1
#define iCREDITO        2
#define iLEASING        4
#define iREGALO         5
#define iCUOTAS         7
#define iCONSIGNACION   8
#define iVENTASDEALER   9
#define iCARGOCUENTA   10
#define iCTDOCONSIG    11
#define iNVOREGALO     12 

/* Digito Verificador Modulo 11 : Resto 10 */
#define szDIG10 "K"

/* Indicativo de Bloqueo */
#define iBLOQUEO_NORMAL 0
#define iBLOQUEADO      1
#define iDESBLOQUEO     2
#define iBLOQUEO_FACTUR 3

/* Causa de Pago Supertelefono (Aplicacion de Pagos) */
#define iCAUPAGOSUPERTEL 4


/* Parametros Generales GED_PARAMETROS */

#define szGED_CODCONSIGNACION           1  /* Documento Venta Consignacion */
#define szGED_CODCONSIGNACION_NC        2  /* Nota de Credito Consignacion */
#define szNUM_DECIMAL				"NUM_DECIMAL"  /* Numero de Decimales a considerar */
#define szSEP_MILES_MONTOS			"SEP_MILES_MONTOS"  /* Caracter separados de miles */
#define szSEP_DECIMALES_MONTOS		"SEP_DECIMALES_MONTOS"  /* Caracter separador de decimales */
#define szSEP_DECIMALES_ORACLE		"SEP_DECIMALES_ORACLE"  /* Caracter separador de decimales */



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

