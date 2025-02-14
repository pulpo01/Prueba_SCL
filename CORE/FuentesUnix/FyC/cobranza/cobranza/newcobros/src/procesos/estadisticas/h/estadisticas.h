/* ============================================================================= */
/*
    Tipo        :  COLA DE PROCESO

    Nombre      :  estadisticas.h

    Descripcion :  Header para estadisticas.pc
    
    Autor       :  Manuel Garcia G.
    Fecha       :  Febrero 2001.
*/ 
/* ============================================================================= */

 
#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
 	#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403  /*  100:Ansi    1403:Oracle */

#define szVERSION			"6.0.0"		/* Nueva version para TMG-TMS*/

/*
#define ARRAY_DOCS       10000
#define ARRAY_AUX        10000
#define HOSTARRAY_MOVTOS 30000

typedef struct MOVTOS_CLIENTES
{
    char szNumIdent    [HOSTARRAY_MOVTOS][12];
    char szCodTipIdent [HOSTARRAY_MOVTOS][3];
    char szRutSantiago [HOSTARRAY_MOVTOS][2]; 
    char szCodEntidad  [HOSTARRAY_MOVTOS][6]; 
}td_Movtos_Clientes ;
*/

typedef struct ANALISIS {
	long	sec_analisis;
	char    fecha_analisis[11];
} td_Analis;

typedef struct DET_ANALISIS {
	long	sec_analisis;
	char    fec_actual[11];
	char    cod_categoria[6];
	long 	cnt_rut_saldo;
	long	cnt_cliente_saldo;
	long	cnt_abocelu_saldo;
	long	cnt_abobeep_saldo;
	double	deu_vencida_saldo;
	long 	cnt_rut_recup;
	long	cnt_cliente_recup;
	long	cnt_abocelu_recup;
	long	cnt_abobeep_recup;
	double	deu_vencida_recup;
} td_DetAnalis;
	
typedef struct MOROSOS {
	char    szFecAnalisis[11];
	char    szCodCategoria[6];
	char 	szCodGestion[6];
	long	iCntRut;
	long	iCntCliente;
	long	iCntAbocelu;
	long	iCntAbobeep;
	double	iDeudaVencida;
} td_Morosos;

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int 	ifnValidaParametros();
int 	ifnConexionDB();
int 	ifnPreparaArchivoLog();
int 	ifnAbreArchivoLog();
void 	vfnCierraArchivoLog();
int 	ifnEjecutaCola();
int 	ifnGeneraEstadisticas( char*  );
int 	ifnAnalisisMorosos( char*  );
int 	ifnEstadisticaMorosos( char*  );



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

