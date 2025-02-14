/*******************************************************************************

   Fichero : GenORA.h

   Autor   : Manolo Oterino.

   Fecha   : 05/10/1995

   Descripcion: Declaracion de tipos y prototipos de funciones del programa
                             GenORA.pc

*******************************************************************************/

#ifndef _GENORAC_H_
#define _GENORAC_H_

#define ORA_NOTNULL       0
#define ORA_NULL         -1

#define NOT_FOUND  1403
#define SQLOK         0

#ifndef _GENORAC_H_
#define access extern
#else
#define access
#endif /* _GENORAC_H_  */
/******************************************************************************
                            PROTOTIPOS DE FUNCIONES
******************************************************************************/
int ifnConnectORA( char *szusr, char *szpsw );
/******************************************************************************
Funcion para conectarse a Oracle.
Entrada: nombre del usuario y password. 
Devuelve: 0 cuando la conexion ha sido posible, -1 en caso contrario. 
*******************************************************************************/

void vfnActivateRole (char *szUser);
/*******************************************************************************
Activa el ROLE TCP_UID para el ususario szUser.
Si el usario no lo tiene o ya lo tiene activado no hace nada.
Debe llamarse despues de realizar la conexion.
Utiliza la tabla TCP_PPR (Tcp Password Para Role).
*******************************************************************************/

int ifnDisConnORA( void ); 
/*******************************************************************************
Funcion para desconectarse de Oracle. ojo, hace Rollback: 
EXEC SQL ROLLBACK WORK RELEASE. 
Salida: 0 cuando la desconexion ha sido posible, -1 en caso contrario.
*******************************************************************************/

int ifnCommitWork( void );
/*******************************************************************************
Hace Commit Work:
EXEC SQL COMMIT WORK.
Salida: 0 cuando el Commit ha sido correcto, -1 en caso contrario.
*******************************************************************************/

int ifnRollBackWork( void ); 
/*******************************************************************************
Hace RollBack Work:
EXEC SQL ROLLBACK WORK.
Salida: 0 cuando el RollBack ha sido correcto, -1 en caso contrario.
*******************************************************************************/

int ifnCommitRelease( void );
/*******************************************************************************
Hace Commit y libera los recursos:
EXEC SQL COMMIT WORK RELEASE.
Salida: 0 cuando el Commit ha sido correcto, -1 en caso contrario.
*******************************************************************************/

int ifnRollBackRelease( void );
/*******************************************************************************
Hace RollBack y libera los recursos:
EXEC SQL ROLLBACK WORK RELEASE.
Salida: 0 cuando el RollBack ha sido correcto, -1 en caso contrario.
*******************************************************************************/

int ifnSetTransactionReadOnly( void );
/*******************************************************************************
Pone una Transaccion de solo lectura:
EXEC SQL SET TRANSACTION READ ONLY.
Salida: 0 cuando no ha existido error, -1 en caso contrario.
*******************************************************************************/

int ifnExecuteImmediate( char *szSQLStm );
/*******************************************************************************
Ejecuta una sentencia SQL directamente.
Entrada: Sentencia SQL a ejecutar.
Salida: 0 cuando la ejecucion ha sido correcta, -1 en caso contrario.
*******************************************************************************/
char *szfnORAerror( void );
/*******************************************************************************
Muestra el mensaje del Error de Oracle ocurrido.
*******************************************************************************/
char *CfnGetTime(int fmto);

#endif /* _GENORAC_H_ */



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

