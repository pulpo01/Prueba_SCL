/********************************************************************************/
/*    Programa    : Errores de cobros. Version 1.1                              */
/*    Modulo      : COBROS y RECAUDACION                                        */
/*    Fichero     : coerr.h                                                     */
/*    Descripcion : Constantes de Error para el modulo de Cobros y Recaudacion  */
/*    Fecha       : 05-Junio-2002                                               */
/*    Autor       : ELCR                                                        */
/********************************************************************************/

#ifndef _ERR_H_
#define _ERR_H_
/* Errores Definidos */

#define OK                      0   /*Cuando todo ocurre correctamente.*/
#define ERR_COTIZA              1   /*Error al realizar cambio monetario*/
#define ERR_IMPORTE             2   /*Importe fuera de rango */
#define ERR_SELPAG              3   /*Error al recuperar datos de Pago */
#define ERR_PAGEFEC             4   /*Pago ya Efectuado*/
#define ERR_INSPAG              5   /*Error al insertar datos de Pago*/
#define ERR_SELIMPFAC           6   /*Error al Recuperar importe de Factura*/
#define ERR_IMPDIF              7   /*Importe Factura Contado distinto importe pago*/
#define ERR_SELCOL              8   /*Error al seleccionar columna nueva */
#define ERR_INSPAGCON           9   /*Error al insertar relacion pago concepto*/
#define ERR_MOVCON              10  /*Error al mover conceptos a cancelados*/
#define ERR_GENCRE              11  /*Error al generar credito*/
#define ERR_PARAME              12  /*Numero de Parametros incorrecto*/
#define ERR_DATGEN              13  /*Error al recuperar datso generales */
#define ERR_SELVEN              14  /*Error en select de dias de Vencimiento */
#define ERR_PAGRES              15  /*Cliente con pagos restringidos */
#define ERR_SELECT              16  /*Error al realizar una select*/
#define ERR_FECHA               17  /*No se pudo recuperar la fecha del sistema */

#define ERR_DEFPORCEN           66  /*Error no existen porcentajes definidos.*/
#define ERR_PORCEN              67  /*Error no encuentra el porcentaje del recargo.*/
#define ERR_PORCENVACIO         68  /*Error el array de porcentajes vacio.*/
#define ERR_DEFRECARGO          69  /*Error no existen recargos definidos.*/
#define ERR_RECARGOS            70  /*Error no encuentra el recargo buscado.*/
#define ERR_RECARVACIO          71  /*Error el array de recargos vacio.*/
#define ERR_FETCHNULL           72  /*Error fecha de vencimiento nula.*/
#define ERR_MODCONCEP           73  /*Error al modificar fecha vencimiento concepto.*/
#define ERR_PARAMETROS          74  /*Error en los parametros de la linea de comando.*/
#define ERR_OPENCURSOR          75  /*Error al abrir el cursor.*/
#define ERR_FETCH               76  /*Error al leer del fetch.*/
#define ERR_CLOSECURSOR         77  /*Error al cerrar el cursor.*/
#define ERR_COMMIT              78  /*Error en el commit.*/
#define ERR_ROLLBACK            79  /*Error en el rolback.*/
#define ERR_CONEXION            80  /*Error al conectarme a ORACLE.*/
#define ERR_DESCONEXION         81  /*Error al desconectarme de ORACLE.*/

#define ERR_DEFCAMPOS           82  /*Error no existen campos definidos.*/
#define ERR_CAMPOS              83  /*Error no encuentra el campo buscado.*/
#define ERR_DEFREGISTROS        84  /*Error no existen registros definidos.*/
#define ERR_REGISTROS           85  /*Error no encuentra el registro buscado.*/
#define ERR_DEFRELACION         86  /*Error no existen relaciones definidas.*/
#define ERR_RELACION            87  /*Error no encuentra la relacion buscada.*/
#define ERR_ABRIRFICH           88  /*Error al abrir el fichero.*/
#define ERR_DEFACUMULADOR       89  /*Error no existen acumuladores definidos.*/
#define ERR_ACUMULADOR          90  /*Error no encuentra el acumulador buscado.*/

#define ERR_DEFANOM             91  /* Error, no hay anomalias definidas.*/
#define ERR_ANOMALIA            92  /* Error, no se encuentra anomalia.*/
#define ERR_NUMPROC             93  /* Error, al obtener el numero de proceso.*/
#define ERR_COMFICH             94  /* Error, al comprobar proceso previo de fichero.*/
#define ERR_FICHPRO             95  /* Error, el fichero ya ha sido procesado.*/

#define ERR_IMPDEBE             96  /* Error, al obtener el importe al debe.*/
#define ERR_IMPHABER            97  /* Error, al obtener el importe al haber.*/
#define ERR_NUMABO              98  /* Error, al obtener el numero de abonado.*/
#define ERR_DIASDEU             99  /* Error, al obtener los dias de deuda.*/
#define ERR_ESTCUA              100 /* Error, al obtener el cuadro de estado.*/
#define ERR_BORREST             102 /* Error, al borrar la tabla de co_simestado.*/
#define ERR_DATLOG              103 /* Error, al obtener los datos del fichero LOG. */

#define ERR_DEFCANTI            104 /* Error, en la definicion de cantidad recargo. */
#define ERR_CANTI               105 /* Error, en la cantidad recargo. */
#define ERR_CANTIVACIO          106 /* Error, en la cantidad recargo esta vacio. */
#define ERR_CRECARTE            107 /* Error, detectado credito en cartera. */
#define ERR_INTPAGOSCONC        108 /* Error, al introducir en pagosconc. */
#define ERR_INTVENTA            109 /* Error, al introducir en co_carteventa. */
#define ERR_UPDATEVENTA         110 /* Error, al update ga_ventas. */
#define ERR_COLUMNA             111 /* Error, al obtener la columna en co_seccartera.*/
#define ERR_NOTVENTA            112 /* Error, al obtener la venta.*/
#define ERR_FAC2                113 /* Error, Factura duplicada en primera venta.*/
#define ERR_UPDATECARTE         114 /* Error, al efectuar un update en cartera.*/
#define ERR_PAGOSABO            115 /* Error, al efectuar un pago de un abonado.*/
#define ERR_DIASGRACIA          116 /* Error, al obtener los dias de gracia.*/
#define ERR_INTRECARCONC        117 /* Error, al Introducir en co_recarconc.*/
#define ERR_TOTCUOTA            118 /* Error, no se paga el total de la cuota.*/
#define ERR_UPDATECUOTA         119 /* Error, al efectuar update en fa_cuotas.*/
#define ERR_DEBCLI              120 /* Error, al obtener indicador debito de cliente.*/
#define ERR_FACUOTA             121 /* Error, al obtener la cuota de fa_cuotas.*/
#define ERR_GENPAG              122 /* Error, al obtener los datos generales pagare.*/
#define ERR_OBTIMPORPAG         123 /* Error, al obtener importe del pagare. */
#define ERR_COMPIMP             124 /* Error, al comprobar el importe del pagare.*/
#define ERR_IMPNOEX             125 /* Error, el importe del pagare no es exacto. */
#define ERR_NOCANCE             126 /* Error, no cancela. */
#define ERR_NODATPAG            128 /* Error, no existen datos del pagare. */
#define ERR_PLFACPAG            129 /* Error, al ejecutar el PL de Factur. de Pagare.*/
#define ERR_NODATCUO            130 /* Error, no ha datos en las cuotas.*/
#define ERR_TIPDOCUM            131 /* Error, en el tipo de documento.*/
#define ERR_ABC                 132 /* Error, al obtener ABC.*/
#define ERR_123                 133 /* Error, al obtener 123.*/
#define ERR_CLASI123            134 /* Error, al obtener clasificacion 123.*/
#define ERR_UPDCLASI            135 /* Error, al modificar la clasificacion.*/
#define ERR_FECHAFIN            136 /* Error, al obtener la fecha fin.*/
#define ERR_FACAJUSTE           137 /* Error, al obtener datos de fa_ajustes.*/
#define ERR_IMPCARR             138 /* Error, al obtener el importe del carrier.*/
#define ERR_COMPCARRIER         139 /* Error, al comprobar si concepto es carrier.*/
#define ERR_IMPCREDITO          140 /* Error, al comprobar el importe credito.*/
#define ERR_CONVERSION          141 /* Error, al realizar la conversion.*/
#define ERR_PLCUOPAG            142 /* Error, al ejecutar el PL de Factur. de Cuotas.*/
#define ERR_CARRABO             143 /* Error, al tratar los abonados en el carrier. */
#define ERR_UPDPROCESO          144 /* Error, en co_cancelados update ind_portador. */
#define ERR_FACTCLI             145 /* Error, al modificar fa_factcli de pagare. */
#define ERR_UPDPAC              146 /* Error, al modificar co_pagospac. */

#define ERR_UPDINFACCEL         147 /* Error, al modificar ga_infaccel. */
#define ERR_UPDINFACTREK        148 /* Error, al modificar ga_infactrek. */
#define ERR_UPDINFACBEEP        149 /* Error, al modificar ga_infacbeep. */
#define ERR_UPDINFACTRUNK       150 /* Error, al modificar ga_infactrunk. */
#define ERR_TRASPASO            151 /* Error, al efectuar el traspaso. */
#define ERR_DELPAGCONC          152 /* Error, al borrar co_pagconc en elpaso 1 venta.*/
#define ERR_LEERFICH            153 /* Error, al leer el fichero. */
#define ERR_DATABO              154 /* Error, al obtener los datos del abonado. */
#define ERR_UPDSITU             155 /* Error, al modificar la situacion del abonado. */
#define ERR_INSUSPREHABO        156 /* Error, al insertar susprehabo. */
#define ERR_INSMOVCENCELU       157 /* Error, al insertar mov celular la central. */
#define ERR_INSMOVMOROSO        158 /* Error, al insertar movimiento moroso. */
#define ERR_ABONOST             159 /* Error, el abonado no es de supertelefono. */
#define ERR_GETACTUACION        160 /* Error, al obterer la actuacion. */
#define ERR_OBTCAUSUSP          161 /* Error, al obtener la causa de suspension. */
#define ERR_SEQPROCESOSR        162 /* Error, al obtener la secuencia del procesoSR.*/
#define ERR_COMPMOVMOROSO       163 /* Error, comprobar si abonado suspendido antes.*/
#define ERR_DELMOVMOROSO        164 /* Error, al borrar lo movimientos anteriores.*/
#define ERR_MODESTADO           165 /* Error, al modificar el estado del abonado. */
#define ERR_ESTADONOSUSP        166 /* Error, con el estado no se puede suspender. */
#define ERR_YASUSPENDIDO        167 /* Error, el abonado ya estaba suspendido. */
#define ERR_SITUPROCESO         168 /* Error, situacion del abonado en proceso. */
#define ERR_INSPROCFICH         169 /* Error, al insertar el fichero procesado. */
#define ERR_NOREHAAUTO          170 /* Error, abonado no rehabilitable automaticamente.*/
#define ERR_NOSUSPAUTO          171 /* Error, abonado no suspendible automaticamente.*/
#define ERR_NOSUSPENDIDO        172 /* Error, abonado no estaba suspendido.*/
#define ERR_GETCUADRANTE        173 /* Error, al comprobar si el abonado cuadrante. */
#define ERR_IMPORTEDEUDA        174 /* Error, al obtener el importe de la deuda. */
#define ERR_DIASDEUDA           175 /* Error, al obtener los dias de deuda. */
#define ERR_CHECKINCI           176 /* Error, al comprobar incidencias no suspendibles. */
#define ERR_GETIMPTARI          177 /* Error, al obtener el importe tarificado. */
#define ERR_NOCUADRAN           178 /* Error, las condiciones del abonado no cuadrante. */
#define ERR_IMPUMBRAL           179 /* Error, importe umbral es superior a la deuda. */
#define ERR_INCIDEN             180 /* Error, abonado tiene una incidencia no suspendible.*/
#define ERR_CUADRAN             181 /* Error, las condiciones del abonado en cuadrante. */
#define ERR_MEIMPUMBRAL         182 /* Error, importe umbral menor que la deuda. */
#define ERR_INSMOVCENBEEP       183 /* Error, al insertar mov beep a la central. */
#define ERR_INSMOVCENTREK       184 /* Error, al insertar mov trek a la central. */
#define ERR_INSMOVCENTRUNK      185 /* Error, al insertar mov trunk a la central. */
#define ERR_MODDEBITO           186 /* Error, al modificar el indicador debito PAC. */
#define ERR_INSHCABUNIPAC       187 /* Error, al insertar en co_hcabunipac. */
#define ERR_DELCABUNIPAC        188 /* Error, al borrar en co_cabunipac. */
#define ERR_INSHISUNIPAC        189 /* Error, al insertar en co_histunipac. */
#define ERR_DELHISUNIPAC        190 /* Error, al borrar en co_histunipac. */
#define ERR_INSCABUNIPAC        191 /* Error, al insertar en co_cabunipac. */
#define ERR_FINDCLI             192 /* Error, cliente no encontrado. */
#define ERR_MODCLI              193 /* Error, al modificar cliente. */
#define ERR_INSUNIVERSO         194 /* Error, al insertar en universo. */
#define ERR_ZONACENTRAL         195 /* Error, universo, zona o central erronea. */
#define ERR_SUMIMPASIG          196 /*Error al sumar importe asignado*/
#define ERR_CALCOMISION         197 /*Error al calcular la comision*/
#define ERR_CODCOMISION         198 /*Error obteniendo los codigos de comision*/
#define ERR_INSASIGCOBRA        199 /*Error al insertar en CO_ASIGCOBRA*/
#define ERR_INSHIAGENDA         200 /*Error al insertar en CO_HISTAGENDA*/
#define ERR_INSHRESPUCO         201 /*Error al insertar en CO_HRESPUCOBRA*/
#define ERR_DELRESPUCOB         202 /*Error al borrar de CO_RESPUCOBRA*/
#define ERR_DELAGENDA           203 /*Error al borra de CO_AGENDA*/
#define ERR_CODCOBRADOR         204 /*Error obtenido codigos asociados al cobrador*/
#define ERR_INSCICLNUEVO        205 /*Error al insertar un ciclo nuevo*/
#define ERR_MAXCICLO            206 /*Error al seleccionar ultimo registro de ciclo*/
#define ERR_LEERFILE            207 /*Error al leer fichero Tecas*/
#define ERR_NUMREG              208 /*Error numero de registros incorrecto*/
#define ERR_GETSECUENCI         209 /*Error al recoger secuencia*/
#define ERR_INSPAGO             210 /*Error al insertar pago */
#define ERR_PAGSIS              211 /*Error Pago sistema*/
#define ERR_PAGMAN              212 /*Error Pago manual */
#define ERR_FECMAX              213 /*Error al seleccionar fecha maxima*/
#define ERR_DELCARTERA          214 /*Error al borrar cartera*/
#define ERR_UPDCARTERA          215 /*Error al modificar cartera*/
#define ERR_INSABONO            216 /*Error al insertar un abono*/
#define ERR_CONCREDITO          217 /*Error al recoger concepto credito*/
#define ERR_INSCART             218 /*Error al insertar en CO_CARTERA*/

#define ERR_INSEST              219 /*Error, al insertar el estado del cliente.*/
#define ERR_HAYMONTO            220 /*Error, despues de cancelar hay monto. */
#define ERR_FECVALOR            221 /*Error fecha valor mayor que sysdate.*/
#define ERR_NOTFOUND            222 /*Error no encuentra datos del concepto.*/
#define ERR_COUNT               223 /*Error al contar los registros.*/
#define ERR_MEMORIA             224 /*Error no existe memoria para cargar la tabla.*/
#define ERR_CALIMP              225 /*Error al calcular el importe.*/
#define ERR_DEBEHABER           226 /*Error importe debe mayor que haber.*/
#define ERR_HABERDEBE           227 /*Error importe haber mayor que debe.*/
#define ERR_IMPCERO             228 /*Error importe cero.*/
#define ERR_INTCARTE            229 /*Error al introducir en cartera.*/
#define ERR_BORRCARTE           230 /*Error al borrar de cartera.*/
#define ERR_INSCANCE            231 /*Error al insertar cancelados.*/
#define ERR_SELECTCANCE         232 /*Error en la select de cancelados.*/
#define ERR_DATCLI              233 /*Error al obtener un dato del cliente.*/
#define ERR_DEFCALIDAD          234 /*Error no existen calidades definidas.*/
#define ERR_DESCCALI            235 /*Error no encuentra descripcion calidad cliente.*/
#define ERR_SELINTERESAPLI      236 /*Error en la select de co_interesapli.*/
#define ERR_DELGECARGOS         237 /*Error al borrar de la GE_CARGOS.*/
#define ERR_DELINTERESAPLI      238 /*Error al borrar de la CO_INTERSAPLI.*/

#define ERR_DELCANCELADOS       250 /*Error al borrar en CO_CANCELADOS*/
#define ERR_INSTABAUX           251 /*Error al insertar Auxiliar al Desplicar Pago*/
#define ERR_INSCOSECARTERA      252 /*Error al insertar Insertar en CO_SECARTERA*/
#define ERR_SELDATPAGO          253 /*Error al obtener datos del pago*/
#define ERR_UPDSECUENCIA        254 /*Error updatenado GE_SECUENCIASEMI*/
#define ERR_SECUENCIA           255 /*Error al obtener el numero de secuencia de pago*/
#define ERR_INSCABANOM          256 /*Error al insertar la cabecera de la anomalia.*/
#define ERR_INSABOEVEN          257 /*Error al insertar en CO_ABONADOEVENTO */
#define ERR_RNGFECHA            258 /*Error al obtener el rango de CO_DETEVENTO */
#define ERR_OBTABC123           259 /*Error al obtener el ABC123 del Evento */
#define ERR_INCIPAC             260 /*Error al obtener los bancos PAC del Evento */
#define ERR_INCISAC             261 /*Error al obtener las incidencias SAC del Evento */
#define ERR_DEBAUTO             262 /*Error al obtener el debito auto. del abonado */
#define ERR_IMPCARTE            263 /*Error al obtener el importe cartera */
#define ERR_UPDESTADO           264 /*Error al modificar el estado de un abonado */
#define ERR_INSSIMULA           265 /*Error al Insertar en CO_SIMULAEVENTO */
#define ERR_UPDCANCE            266 /*Error al Modificar CO_CANCELADOS */
#define ERR_VECES               267 /*Error al obtener NUM_VECES de CO_EVENTO */
#define ERR_DELTRANS            269 /*Error al borrar de GA_TRANSACABO */
#define ERR_TRANSA              270 /*Error al obtener NUM_TRANSACCION de GA_TRANSACABO */
#define ERR_PL                  271 /*Error al lanzar un PL */
#define ERR_DELABOEVE           272 /*Error al borrar de CO_ABONADOEVENTO */
#define ERR_IMPORTES            273 /*Error al obtener importes de CO_DETEVENTO */
#define ERR_INSHISTABO          274 /*Error al Insertar en CO_HISTABOEVENTO */
#define ERR_INSHABOEVEN         275 /*Error en el Insert-Select en CO_HISTABOEVENTO */
#define ERR_INSHEVEN            276 /*Error al Insertar en CO_HISTEVENTO */
#define ERR_UPDEVEN             277 /*Error al updatear CO_EVENTOS */
#define ERR_UPDABOEVEN          278 /*Error al updatear CO_ABONADOEVENTO */
#define ERR_SEEKEVEN            279 /*Error al buscar evento suspendible CO_EVENTOS */
#define ERR_NUMDIAS             280 /*Error al buscar los dias CO_EVENTOS */
#define ERR_INSCARTERACC        281 /*Error al insertar en CO_CARTERACC */
#define ERR_UPDABONADO          282 /*Error al updatear Abonado */
#define ERR_UPDCLIENTES         283 /*Error al updatear GE_CLIENTES */
#define ERR_INSHDETEVEN         284 /*Error al insertar CO_DETEVENTO */
#define ERR_DELDETEVEN          285 /*Error al borrar CO_DETEVENTO */
#define ERR_INSHEVENTOABC123    286 /*Error al insertar CO_EVENTOABC123 */
#define ERR_DELEVENABC123       287 /*Error al borrar CO_EVENTOABC123 */
#define ERR_INSHEVENTOPAC       288 /*Error al insertar CO_HEVENTOPAC */
#define ERR_DELEVENTOPAC        289 /*Error al borrar CO_EVENTOPAC */
#define ERR_INSHEVENTOSAC       290 /*Error al insertar CO_HEVENTOSAC */
#define ERR_DELEVENTOSAC        291 /*Error al borrar CO_EVENTOSAC */
#define ERR_DELEVENTOS          292 /*Error al borrar CO_EVENTOS */

#define ERR_INSDEPEXTDEPEXISTE  300 /*Error al insertar en CO_DEPOSITO_EXTDEP   PK DUPLICADA */
#define ERR_INSANOMALIA         301 /*Error al insertar anomalia. CO_DEPOSITO_EXTANOM */

#define ERR_IMPMISCEL		    302 /* Error, importe miscelanea diferente a importe factura */
#define ERR_COCALCINTER		    303	/* Error en PL CO_CALC_INTERCOBRANZA */
#define ERR_DECIMAL			    304	/* Error en al recuperar decimales de uso de operadora */

#define  ERR_PROCREDITO    	    678
#define  ERR_PRODEBITO     	    679
#define  ERR_INSPAGOSCON   	    680
#define  ERR_CANCCRED      	    681
#define  ERR_SUMIMPORTE    	    682

/* ----- */
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

