/***************************************************************************/
/* Definicion de constantes, tipos y estructuras usadas por los distintos  */
/* modulos del subsistema de prefacturacion. Inicialmente, solo por el     */
/* programa "check_interfaz.pc".                                           */
/*                                                                         */
/* Por William Sepulveda V.                                                */
/*-------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                */
/* Viernes 23 de julio de 1999.                                            */
/***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <strings.h>
#include <errno.h>
#include <sys/timeb.h>
#include <sys/stat.h>
#include <time.h>
#include <geora.h>
#include <utils.h>

#define MAX_BUFF     400000
/* #define MAX_OCURR      2000 */
#define PATH			100
#define TRUE              1
#define FALSE             0
#define SQLNOTFOUND     1403 /*  SE dejo no ansi */
#define SQLTMR        -2112
#define SQLOK             0
#define RET_OK            0
#define PROD_CELULAR      1
#define FAILURE          -1
#define ANOM10          -10
#define ANOM11          -11
#define ANOM12          -12
#define ANOM13          -13
#define ANOM14          -14
#define ANOM15          -15
#define ANOM16          -16
#define ANOM21			-21
#define ANOM22			-22
#define ANOM23			-23
#define ANOM24			-24
#define ANOM25			-25
#define ANOM26			-26
#define ANOM27			-27
#define ANOM40          -40
#define ANOM41          -41
#define ANOM42          -42
#define ANOM43          -43
#define ANOM44          -44
#define ANOM45          -45
#define RESTO           -77
#define ANOM80			-80
#define ANOM81			-81
#define ANOM82			-82
#define ANOM83			-83
#define ANOM84			-84
#define ANOM85			-85
#define ANOM86			-86
#define ANOM87			-87
#define ANOM88			-88
#define ANOM89			-89
#define ANOM95          -95     	/* Abonado dado de alta con posterioridad a la fecha de termino del periodo */
#define ANOM98			-98		/* Abonado de Baja en GA_ABOCEL o en GA_ABOBEEP */
#define ANOM99          -99     	/* Abonado de Baja en GA_HABOCEL o GA_HABOBEEP (rechazo de venta) */

#define FEC_CAMBIO_BAJAS	"19990803235959"

/* Definicion de tipos */
/*--------------------------------------------------*/
typedef 	struct REG_FA_CICLFACT
{
	int		cod_ciclo;
	char	fec_desde[15];
	char	fec_hasta[15];
}rg_fa_ciclfact;


typedef 	struct REG_FA_CICLOCLI
{
	char	rowid[19];
	long	cod_cliente;
	long	num_abonado;
	int		cod_producto;
	long	num_proceso;
	int		ind_gravedad;
	int		pos_empresa;

}rg_fa_ciclocli;

typedef 	struct REG_GA_INTARCEL
{
	long	num_abonado;
	char	cod_plantarif[3];
	char	cod_cargobasico[3];
	char	tip_plantarif[2];
	int	cod_grupo;
}rg_ga_intarcel;

typedef 	struct REG_GA_EMPRESA
{
	long	cod_cliente;
	long	cod_empresa;
	int		cod_ciclo;
	char	cod_plantarif[4];
}rg_ga_empresa;


typedef 	struct REG_GA_INFACCEL
{
	int		cod_cliente;
	int		num_abonado;
	char	num_telefija[16];
	int		cod_supertel;
}rg_ga_infaccel;

typedef 	struct REG_GA_ABOCEL
{
	int	cod_cliente;
	int	num_abonado;
	int	cod_ciclo;
	char	num_telefija[16];
	int	cod_opredfija;
}rg_ga_abocel;

typedef 	struct REG_GE_CARGOS
{
	int	cod_cliente;
	int	num_abonado;
}rg_ge_cargos;

int		cod_ciclfact;
char	username[30]="";
char	passwd[30]="";



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

