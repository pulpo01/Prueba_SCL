/*==================================================================================
   Nombre      : lstEvalua.h
   Funcion     : Libreria 
   Autor       : GAC
   Creado      : Diciembre 2003
==================================================================================*/
/* Defincion de Constantes 																		 */
#include <thread.h>
#include <synch.h>
#define NUMFILAS		    30000
#define HOSTARRAY_CATEG  100      /* # de Categorias  */	

/* Variables definidas para tabla de estadisticas (Co_Estadiseva_to)					 */
char szPROCESO [20];
long lCliesxHilo[20];
int  iHilosFinal   ;
int  iCreaNodo     ;
mutex_t    bufferlock;
sema_t     semaflock;

/**********************************************************************************/

/* host array */
typedef struct CLIENTES
{
	  long   lCod_Cliente 			[NUMFILAS]   ;
	  char   szFec_Vencimiento		[NUMFILAS][9];
	  char   szFec_Prorroga   		[NUMFILAS][9];
	  char   szCod_Gestion  		[NUMFILAS][6];
	  double dSaldo_Vencido			[NUMFILAS]   ;
	  long   lSec_Moroso				[NUMFILAS]   ;
	  char   szCod_Categoria  		[NUMFILAS][6];	  
	  int    iflg_reclamo         [NUMFILAS];

} TCLIENTES;

/**********************************************************************************/
/* Declaración de estructuras para listas enlazadas  										 */

/* Lista para universo de Candidatos a morosos */
struct stCliente {
	long   lCod_Cliente        ; 
	char   szFec_Vencimiento[9];
	char   szFec_Prorroga   [9];
	char   szCod_Gestion    [6];
	double dSaldo_Vencido      ;
	double dSaldo_NoVencido    ;
	long   lSec_Moroso         ;
	char   szCod_Categoria  [6];
	long	 lCod_Cuenta	   ;
	char	 szNum_Ident    [21];
	char	 szCod_Tipident [3];
	char	 szCod_Ptogest  [6];
	char	 szCod_Comuna   [6];
	int 	 iCnt_Abocelu      ;
	int 	 iCnt_Abobeep      ;
	int    	iFlagGraba	   ; /* 0= inserta , 1= updatea */

	char	szCodTipClie	[2]; /* Tipo de Cliente */				/* Incoporado por PGonzalez 25-10-2004 MAS-04037 */
	double	dImportePago 	   ; /* Monto del Pago */                               /* Incoporado por PGonzalez 25-10-2004 MAS-04037 */
	int	iProcedencia	   ; /* Procedencia del registro Archivo = 0; BD = 1 */ /* Incoporado por PGonzalez 25-10-2004 MAS-04037 */
	int    iflg_reclamo;
};

typedef struct ACCIONES
{
	char szCod_Accion    [6];
	char szFec_Accion    [9];
	char szIndDuplicable [2];
	int  iFlagWrite         ;
	int  iFlagRutinas       ;
	char szCodParam	  [16];
	int  iNumProceso        ;	
	struct ACCIONES *sgte;
}ACCIONES;

typedef struct ACCIONES *lstAccCM;

/* Tipos de la lista: */
typedef struct TNodo
{
	struct stCliente Campo;
	struct TNodo *sgte;
	lstAccCM Accion_sgte;
	lstAccCM Accion_final;
}TNodo;

typedef struct TNodo *stLista;

lstAccCM stListaAcCM; 
stLista stListaClientes;
stLista stListaFinal;
/* Para ejecutar hilos */
stLista *pInicio;
stLista *pFinal;


/* Host array para las categorias */
typedef struct CATEGORIAS_CLTES
{
	char	szCodCategoria[HOSTARRAY_CATEG][6];
}td_CategoriaClientes;

/* Host array para las secuencias */
typedef struct SECUENCIA_PTOS
{
	int iNumDias[HOSTARRAY_CATEG];
	int iNumProceso[HOSTARRAY_CATEG];
}td_SecuenciaPtos;

/* Lista para universo de Criterios */
struct Criterio
{
	char szCodRutina  [6];  /* Codigo de identificacion de la rutina */
	char szNomRutina  [31]; /* Nommbre de la Funcion almacenada en la PL */
	char szTipRetorno [2];  /* 'N' Numerico, 'C' Caracter, 'S' String, 'D' Date */
	/* char szValRetorno [11];  Requerimiento Soporte RyC. - 27.07.2007 - Ticket 42058 - COL */
	char szValRetorno [18]; /* valor 1 (del rango, si lo hay) */
	char szValRango	[11]; /* valor 2 (o nulo si no hay rango) */
	char szIndExcluye [2];  /* Indica si se excluye */
	int iDiasProrroga  ;     /* numero de dias que se prorroga */
	int  iTipFuncion  ;     /* ejecucion mediante PL (0) o Dato Lista (1) */
	struct Criterio *sig;
};

typedef struct Criterio *lista_Crit;

/* Lista para universo de acciones */
struct Accion
{
	char szCodRutina     [6] ;  /* Codigo de identificacion de la rutina */
	char szIndProrroga   [2] ;  /* Indica si la Accisn es Prorrogable */
	char szIndDuplicable [2] ;  /* Indica si la Accisn es Duplicable */
	long lMaxDiario		    ;	 /* Indica si hay restriccion de generacion de acciones */		
	char szCodParam	   [16];	
	struct Accion *sig;
};

typedef struct Accion *lista_Acc;

/* Lista para universo Puntos de gestion */
struct Pto_Gest
{
	char szCodPtoGest  [6];
	 int iNumDias;
	char szAntPtoGest  [6];
	char szCodEstado   [2];
	char szCodGestion  [3];
	char szCodCategoria[6];
	char szIndProrroga [2];
	int  iNumProceso;
	lista_Acc  Acc_sig;
	lista_Crit Crit_sig;
	struct Pto_Gest *sig;
};

typedef struct Pto_Gest *lista_Pto;

/* Lista para secuenias de Puntos de gestion */
struct SecPtos
{
	int    iNumDias;
	int    iNumProceso;
	struct SecPtos *sig;
};

typedef struct SecPtos *lista_SecPtos;

/* Lista para universo de categorias */
struct Categorias
{
	char szCodCategoria[6];
	lista_Pto pto_sig;
	lista_SecPtos sec_sig;
	struct Categorias *sig;
};


typedef struct Categorias *lista_Categ;
lista_Categ  lsCat;

/****************************************************************/
/* Lista para universo de clientes con acciones                 */
/****************************************************************/
struct ClientesAcc
{
	long  lCod_cliente ;
	struct ClientesAcc *sig;
};

typedef struct ClientesAcc *Lista_Clie;
typedef struct ClientesAcc *Lista_Hilo;

/****************************************************************/
/* Lista para universo de clientes con acciones                 */
/****************************************************************/
struct stAcciones
{
	long  lCod_cliente   ;
	long  lNum_secuencia ;
	char  szCodAccion [6];
	struct stAcciones *sig;
};

typedef struct stAcciones *Lista_Acc;











