/****************************************************************************/
/*                                                                          */
/*    Programa    : anomalias de cobros.                                    */
/*                                                                          */
/*    Modulo      : COBROS.                                                 */
/*                                                                          */
/*    Fichero     : coanom.h                                                 */
/*                                                                          */
/*    Descripcion : Constantes de anomalias para el modulo de cobros.       */
/*                                                                          */
/*    Programador : Julia Serrano Pozo.                                     */
/*                                                                          */
/*    Fecha       : 05-05-1997                                              */
/*                                                                          */
/****************************************************************************/
#ifndef _ANOM_H_
#define _ANOM_H_

#define A_DATABO        	1	/* Error, al obtener datos del abonado. */
#define A_UPDSITU       	2  	/* Error, al modificar la situacion del abonado. */
#define A_INSUSPREHABO  	3  	/* Error, al insertar susprehabo. */
#define A_INSMOVCENCELU 	4  	/* Error, al insertar mov celular a la central. */
#define A_INSMOVCENBEEP 	5  	/* Error, al insertar mov beeper a la central. */
#define A_INSMOVCENTREK 	6  	/* Error, al insertar mov trek a la central. */
#define A_INSMOVCENTRUNK 	7  	/* Error, al insertar mov trunking a la central. */
#define A_INSMOVMOROSO  	8  	/* Error, al insertar movimiento moroso. */
#define A_ABONOST       	9  	/* Error, el abonado no es de supertelefono. */
#define A_COMPMOVMOROSO 	10 	/* Error, al comprobar si abonado suspendido antes.*/
#define A_DELMOVMOROSO  	11  /* Error, al borrar los movimientos anteriores. */
#define A_MODESTADO     	12  /* Error, al modificar el estado del abonado. */
#define A_ESTADONOSUSP 		13  /* Error, con el estado no se puede suspender. */ 
#define A_YASUSPENDIDO 		14  /* Error, el abonado ya estaba suspendido. */     
#define A_SITUPROCESO  		15  /* Error, situacion del abonado en proceso. */    
#define A_NOREHAAUTO   		16  /* Error, abonado no rehabilitable auotmaticamente.*/
#define A_NOSUSPAUTO   		17  /* Error, abonado no suspendible automaticamente.*/
#define A_NOSUSPENDIDO 		18  /* Error, abonado no estaba suspendido antes. */
#define A_GETCUADRANTE 		19  /* Error, al comprobar si el abonado cuadrante. */
#define A_IMPORTEDEUDA 		20  /* Error, al obtener el importe de la deuda. */   
#define A_DIASDEUDA    		21  /* Error, al obtener los dias de deuda. */
#define A_GETIMPORTE   		22  /* Error, al obtener los dias e importe de deuda. */
#define A_CHECKINCI    		23  /* Error, al comprobar incidencias no suspendibles.*/
#define A_GETIMPTARI   		24  /* Error, al obtener el importe tarificado .*/
#define A_SIMSUSOK	 		100 /* La simulacion de Suspension correcta */
#define A_SIMREHOK	  		101 /* La simulacion de Rehabilitacion correcta */
#define A_SIMINCIDEN  		102 /* El abonado tiene una incidencia no suspendible */
#define A_SIMIMPUMBRAL 		103 /* Abonado tiene importe umbral mayor que deuda. */
#define A_SIMMEIMPUMBRAL 	104 /* Abonado tiene importe umbral menor que deuda. */
#define A_SIMNOCUADRAN 		105 /* Condiciones Abonado no estan en el cuadrante. */
#define A_SIMCUADRAN 		106 /* Condiciones Abonado estan en el cuadrante. */
#define A_GETSECUENCI 		107 /* Anomalia al obtener el numero de secuencia. */
#define A_SELECT 			108 /* Anomalia al realizar un select . */
#define A_INSPAGO 			109 /* Anomalia al Insertar un pago . */
#define A_OPENCURSOR 		110 /* Anomalia al abrir un cursor en un pago . */
#define A_FETCH 			111 /* Anomalia en el fetch de un cursor en un pago . */
#define A_CLOSECURSOR 		112 /* Anomalia al cerrar un cursor en un pago . */
#define A_PAGO 				113 /* Anomalia al realizar un pago . */
#define A_FINDCLI 			114 /* Anomalia al Obtener datos del cliente . */
#define A_INSCOSECARTERA 	115 /* Anomalia al insertar en cosecartera. */
#define A_INSCARTERA 		116 /* Anomalia al insertar en cocartera. */
#define A_CANCELACION 		117 /* Anomalia al realizar la cancelacion de creditos.*/
#define A_NUMERO 			118 /* Anomalia al buscar un celular/beeper en Teca03.*/
#define A_FOLIO 			119 /* Anomalia al buscar un folio en Teca03.*/
#define A_GETCARTERA 		120 /* Anomalia al obtener datos de cartera en Teca03.*/
#define A_MTOPAGO 			121 /* Anomalia Mto. del pago no concuerda con saldo de la factura.*/
#define A_NOBAJA 			122 /* Anomalia Abonado NO esta de Baja.*/
#define A_CASTIGO 			123 /* Anomalia Castigo Duplicado.*/
#define A_FECHAPAGO 		125 /* Anomalia de TECA Pago con Fecha mayor a Hoy */
/* victor */
#define A_RecExtNull 		400 /* Anomalia al insertar. Campo Null COD_RECEXT*/
#define A_BancoNull 		401 /* Anomalia al insertar. Campo Null COD_BANCO*/
#define A_NoCuentaNull 		402 /* Anomalia al insertar. Campo Null NUM_CUENTACTE*/
#define A_NumBoletaNull 	403 /* Anomalia al insertar. Campo Null NUM_BOLETA*/
#define A_NumDocumNull 		404 /* Anomalia al insertar. Campo Null NUM_DOCUMDEP*/
#define A_TipDocNull 		405 /* Anomalia al insertar. Campo Null COD_TIPDOCUM */
#define A_FechaPagNull 		406 /* Anomalia al insertar. Campo Null FEC_PAGO*/
#define A_FechaCobNull 		407 /* Anomalia al insertar. Campo Null FEC_COBRANZA*/
#define A_ImpPagoNull 		408 /* Anomalia al insertar. Campo Null IMP_DEPOSITO*/
#define A_BancoNoExiste 	409 /* Anomalia Cod Banco no existe en tabla GE_BANCO */
#define A_CtaCteNoExiste 	410 /* Anomalia Num Cta Cte no existe en tabla GE_BANCO_CTA_CTE */
/* ----- */
#endif  /* _ANOM_H_ */


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

