/*                                                                          */
/*    Programa    : Errores de cobros.                                      */
/*                                                                          */
/*    Modulo      : COBROS.                                                 */
/*                                                                          */
/*    Fichero     : err.h                                                   */
/*                                                                          */
/*    Descripcion : Constantes de Error para el modulo de cobros.           */
/*                                                                          */
/*    Programador : Julia Serrano Pozo.                                     */
/*                                                                          */
/*    Fecha       : 11-12-1995                                              */
/*                                                                          */
/****************************************************************************/
/* Incorporado por PGonzaleg por motivos de falla en la compilacion	    */
/*	de prebilling ya que requiere este .h				    */
/*	19-03-2002. Procesos de ordenamiento de fuentes	                    */
/****************************************************************************/

#ifndef _ERR_H_
#define _ERR_H_

#define OK                0  /*Cuando todo ocurre correctamente.*/
#define ERR_COTIZA        1  /*Error al realizar cambio monetario*/
#define ERR_IMPORTE       2  /*Importe fuera de rango */
#define ERR_SELPAG        3  /*Error al recuperar datos de Pago */
#define ERR_PAGEFEC       4  /*Pago ya Efectuado*/
#define ERR_INSPAG        5  /*Error al insertar datos de Pago*/
#define ERR_SELIMPFAC     6  /*Error al Recuperar importe de Factura*/
#define ERR_IMPDIF        7  /*Importe Factura Contado distinto importe pago*/
#define ERR_SELCOL        8  /*Error al seleccionar columna nueva */
#define ERR_INSPAGCON     9  /*Error al insertar relacion pago concepto*/
#define ERR_MOVCON       10  /*Error al mover conceptos a cancelados*/
#define ERR_GENCRE       11  /*Error al generar credito*/
#define ERR_PARAME       12  /*Numero de Parametros incorrecto*/
#define ERR_DATGEN       13  /*Error al recuperar datso generales */
#define ERR_SELVEN       14  /*Error en select de dias de Vencimiento */
#define ERR_PAGRES       15  /*Cliente con pagos restringidos */
#define ERR_SELECT       16  /*Error al realizar una select*/
#define ERR_FECHA        17  /*No se pudo recuperar la fecha del sistema */

#define ERR_FECVALOR     51  /*Error fecha valor mayor que sysdate.*/
#define ERR_NOTFOUND     52  /*Error no encuentra datos del concepto.*/
#define ERR_COUNT        53  /*Error al contar los registros.*/
#define ERR_MEMORIA      54  /*Error no existe memoria para cargar la tabla.*/
#define ERR_CALIMP       55  /*Error al calcular el importe.*/
#define ERR_DEBEHABER    56  /*Error importe debe mayor que haber.*/
#define ERR_HABERDEBE    57  /*Error importe haber mayor que debe.*/
#define ERR_IMPCERO      58  /*Error importe cero.*/
#define ERR_INTCARTE     59  /*Error al introducir en cartera.*/
#define ERR_BORRCARTE    60  /*Error al borrar de cartera.*/
#define ERR_INSCANCE     61  /*Error al insertar cancelados.*/
#define ERR_SELECTCANCE  62  /*Error en la select de cancelados.*/
#define ERR_DATCLI       63  /*Error al obtener un dato del cliente.*/
#define ERR_DEFCALIDAD   64  /*Error no existen calidades definidas.*/
#define ERR_DESCCALI     65  /*Error no encuentra descripcion calidad cliente.*/
#define ERR_DEFPORCEN    66  /*Error no existen porcentajes definidos.*/
#define ERR_PORCEN       67  /*Error no encuentra el porcentaje del recargo.*/
#define ERR_PORCENVACIO  68  /*Error el array de porcentajes vacio.*/
#define ERR_DEFRECARGO   69  /*Error no existen recargos definidos.*/
#define ERR_RECARGOS     70  /*Error no encuentra el recargo buscado.*/
#define ERR_RECARVACIO   71  /*Error el array de recargos vacio.*/
#define ERR_FETCHNULL    72  /*Error fecha de vencimiento nula.*/
#define ERR_MODCONCEP    73  /*Error al modificar fecha vencimiento concepto.*/
#define ERR_PARAMETROS   74  /*Error en los parametros de la linea de comando.*/
#define ERR_OPENCURSOR   75  /*Error al abrir el cursor.*/
#define ERR_FETCH        76  /*Error al leer del fetch.*/
#define ERR_CLOSECURSOR  77  /*Error al cerrar el cursor.*/
#define ERR_COMMIT       78  /*Error en el commit.*/
#define ERR_ROLLBACK     79  /*Error en el rolback.*/
#define ERR_CONEXION     80  /*Error al conectarme a ORACLE.*/
#define ERR_DESCONEXION  81  /*Error al desconectarme de ORACLE.*/


#define ERR_DEFCAMPOS    82  /*Error no existen campos definidos.*/
#define ERR_CAMPOS       83  /*Error no encuentra el campo buscado.*/
#define ERR_DEFREGISTROS 84  /*Error no existen registros definidos.*/
#define ERR_REGISTROS    85  /*Error no encuentra el registro buscado.*/
#define ERR_DEFRELACION  86  /*Error no existen relaciones definidas.*/
#define ERR_RELACION     87  /*Error no encuentra la relacion buscada.*/
#define ERR_ABRIRFICH    88  /*Error al abrir el fichero.*/
#define ERR_DEFACUMULADOR 89  /*Error no existen acumuladores definidos.*/
#define ERR_ACUMULADOR   90  /*Error no encuentra el acumulador buscado.*/

#define ERR_DEFANOM            91  /* Error, no hay anomalias definidas.*/
#define ERR_ANOMALIA     92  /* Error, no se encuentra anomalia.*/
#define ERR_NUMPROC      93  /* Error, al obtener el numero de proceso.*/
#define ERR_COMFICH      94  /* Error, al comprobar proceso previo de fichero.*/
#define ERR_FICHPRO      95  /* Error, el fichero ya ha sido procesado.*/

#define ERR_IMPDEBE      96  /* Error, al obtener el importe al debe.*/
#define ERR_IMPHABER     97  /* Error, al obtener el importe al haber.*/
#define ERR_NUMABO       98  /* Error, al obtener el numero de abonado.*/
#define ERR_DIASDEU      99  /* Error, al obtener los dias de deuda.*/
#define ERR_ESTCUA      100  /* Error, al obtener el cuadro de estado.*/
#define ERR_INSEST      101  /* Error, al insertar el estado del cliente.*/
#define ERR_BORREST     102  /* Error, al borrar la tabla de co_simestado.*/
#define ERR_DATLOG      103  /* Error, al obtener los datos del fichero LOG. */


#define ERR_DEFCANTI    104  /* Error, en la definicion de cantidad recargo. */
#define ERR_CANTI       105  /* Error, en la cantidad recargo. */
#define ERR_CANTIVACIO  106  /* Error, en la cantidad recargo esta vacio. */
#define ERR_CRECARTE    107  /* Error, detectado credito en cartera. */
#define ERR_INTPAGOSCONC 108  /* Error, al introducir en pagosconc. */
#define ERR_INTVENTA    109  /* Error, al introducir en co_carteventa. */
#define ERR_UPDATEVENTA    110  /* Error, al update ga_ventas. */
#define ERR_COLUMNA     111  /* Error, al obtener la columna en co_seccartera.*/
#define ERR_NOTVENTA    112  /* Error, al obtener la venta.*/
#define ERR_FAC2        113  /* Error, Factura duplicada en primera venta.*/
#define ERR_UPDATECARTE 114  /* Error, al efectuar un update en cartera.*/
#define ERR_PAGOSABO    115  /* Error, al efectuar un pago de un abonado.*/
#define ERR_DIASGRACIA  116  /* Error, al obtener los dias de gracia.*/
#define ERR_INTRECARCONC 117  /* Error, al Introducir en co_recarconc.*/
#define ERR_TOTCUOTA    118  /* Error, no se paga el total de la cuota.*/
#define ERR_UPDATECUOTA 119  /* Error, al efectuar update en fa_cuotas.*/
#define ERR_DEBCLI      120  /* Error, al obtener indicador debito de cliente.*/
#define ERR_FACUOTA     121  /* Error, al obtener la cuota de fa_cuotas.*/
#define ERR_GENPAG      122  /* Error, al obtener los datos generales pagare.*/
#define ERR_OBTIMPORPAG 123  /* Error, al obtener importe del pagare. */
#define ERR_COMPIMP     124  /* Error, al comprobar el importe del pagare.*/
#define ERR_IMPNOEX     125  /* Error, el importe del pagare no es exacto. */
#define ERR_NOCANCE     126  /* Error, no cancela. */
#define ERR_HAYMONTO    127  /* Error, despues de cancelar hay monto. */
#define ERR_NODATPAG    128  /* Error, no existen datos del pagare. */
#define ERR_PLFACPAG    129  /* Error, al ejecutar el PL de Factur. de Pagare.*/
#define ERR_NODATCUO    130  /* Error, no ha datos en las cuotas.*/
#define ERR_TIPDOCUM    131  /* Error, en el tipo de documento.*/
#define ERR_ABC         132  /* Error, al obtener ABC.*/
#define ERR_123         133  /* Error, al obtener 123.*/
#define ERR_CLASI123    134  /* Error, al obtener clasificacion 123.*/
#define ERR_UPDCLASI    135  /* Error, al modificar la clasificacion.*/
#define ERR_FECHAFIN    136  /* Error, al obtener la fecha fin.*/
#define ERR_FACAJUSTE   137  /* Error, al obtener datos de fa_ajustes.*/
#define ERR_IMPCARR     138  /* Error, al obtener el importe del carrier.*/
#define ERR_COMPCARRIER  139  /* Error, al comprobar si concepto es carrier.*/
#define ERR_IMPCREDITO  140  /* Error, al comprobar el importe credito.*/
#define ERR_CONVERSION  141  /* Error, al realizar la conversion.*/
#define ERR_PLCUOPAG    142  /* Error, al ejecutar el PL de Factur. de Cuotas.*/
#define ERR_CARRABO     143  /* Error, al tratar los abonados en el carrier. */
#define ERR_UPDPROCESO  144  /* Error, en co_cancelados update ind_portador. */
#define ERR_FACTCLI     145  /* Error, al modificar fa_factcli de pagare. */
#define ERR_UPDPAC      146  /* Error, al modificar co_pagospac. */

#define ERR_UPDINFACCEL 147  /* Error, al modificar ga_infaccel. */
#define ERR_UPDINFACTREK 148  /* Error, al modificar ga_infactrek. */
#define ERR_UPDINFACBEEP 149  /* Error, al modificar ga_infacbeep. */
#define ERR_UPDINFACTRUNK 150  /* Error, al modificar ga_infactrunk. */
#define ERR_TRASPASO    151  /* Error, al efectuar el traspaso. */
#define ERR_DELPAGCONC  152  /* Error, al borrar co_pagconc en elpaso 1 venta.*/
#endif  /* _ERR_H_ */


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

