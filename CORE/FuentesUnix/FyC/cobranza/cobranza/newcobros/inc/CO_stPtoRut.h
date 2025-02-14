/* ============================================================================= */
/*
	Tipo        :  	ESTRUCTURAS DE USO GENERAL 

	Nombre      :  	CO_stPtoRut.h 

	Descripcion :  	Header de estructuras para CO_generales.pc

	Autor       : 
	Fecha       :	10-04-2001.	 

*/ 
/* ============================================================================= */

#define HOSTARRAY_CRITER       150      /* Criterios */
#define HOSTARRAY_PTOGES       150      /* Puntos de Gestion */
#define HOSTARRAY_PTORUT       500      /* Puntos de Gestion y validaciones rutinas */

typedef struct PTOGESTION
{
	char szCodPtoGest  	[HOSTARRAY_PTOGES][6];
	 int  iNumDias       [HOSTARRAY_PTOGES]   ;
	char szAntPtoGest   [HOSTARRAY_PTOGES][6];
	char szCodEstado    [HOSTARRAY_PTOGES][2];
	char szCodGestion   [HOSTARRAY_PTOGES][3];
	char szCodCategoria [HOSTARRAY_PTOGES][6];
	char szIndProrroga  [HOSTARRAY_PTOGES][2];
	int	 iNumProceso    [HOSTARRAY_PTOGES]   ;
} td_PtoGestion ;

typedef struct RUTINA
{
	char szTipRutina	[HOSTARRAY_CRITER][2];  /* 'C' Criterio o 'A' Accion */
	char szCodRutina	[HOSTARRAY_CRITER][6];  /* Codigo de identificacion de la rutina */
	char szTipRetorno	[HOSTARRAY_CRITER][2];  /* 'N' Numerico, 'C' Caracter, 'S' String, 'D' Date */
	char szValRetorno	[HOSTARRAY_CRITER][11]; /* valor 1 (del rango, si lo hay) */
	char szValRango		[HOSTARRAY_CRITER][11]; /* valor 2 (o nulo si no hay rango) */
	char szIndExcluye	[HOSTARRAY_CRITER][2];  /* Indica si se excluye */
	 int iDiasProrroga	[HOSTARRAY_CRITER];     /* numero de dias que se prorroga */
	char szIndProrroga	[HOSTARRAY_CRITER][2];  /* Indica si la Accisn es Prorrogable */
	char szIndDuplicable[HOSTARRAY_CRITER][2];  /* Indica si la Accisn es Duplicable */
	long lMaxDiario		[HOSTARRAY_CRITER];		/* Indica si hay restriccion de generacion de acciones */		
	char szCodParam		[HOSTARRAY_CRITER][16];	
} td_Rutina ;

typedef struct PTORUTINA
{
	char szTipRutina  	[HOSTARRAY_PTORUT][2];
	char szCodPtoGest  	[HOSTARRAY_PTORUT][6];
	char szCodCategoria [HOSTARRAY_PTORUT][6];
	int iNumDias        [HOSTARRAY_PTORUT]   ;
	char szCodRutina   	[HOSTARRAY_PTORUT][6];  /* Codigo de identificacion de la rutina */
	char szTipRetorno  	[HOSTARRAY_PTORUT][2];  /* 'N' Numerico, 'C' Caracter, 'S' String, 'D' Date */
	char szValRetorno  	[HOSTARRAY_PTORUT][11]; /* valor 1 (del rango, si lo hay) */
	char szValRango    	[HOSTARRAY_PTORUT][11]; /* valor 2 (o nulo si no hay rango) */
	char szIndExcluye  	[HOSTARRAY_PTORUT][2];  /* Indica si se excluye */
	int iDiasProrroga  	[HOSTARRAY_PTORUT];     /* numero de dias que se prorroga */
	char szIndProrroga 	[HOSTARRAY_PTORUT][2];  /* Indica si la Accisn es Prorrogable */
} td_PtoRutina ;

typedef struct CRITERIOS
{
	char szCodRutina	[HOSTARRAY_CRITER][6];  /* Codigo de identificacion de la rutina */
	char szNomRutina        [HOSTARRAY_CRITER][31]; /* Nommbre de la Funcion almacenada en la PL */
	char szTipRetorno	[HOSTARRAY_CRITER][2];  /* 'N' Numerico, 'C' Caracter, 'S' String, 'D' Date */
	char szValRetorno	[HOSTARRAY_CRITER][11]; /* valor 1 (del rango, si lo hay) */
	char szValRango		[HOSTARRAY_CRITER][11]; /* valor 2 (o nulo si no hay rango) */
	char szIndExcluye	[HOSTARRAY_CRITER][2];  /* Indica si se excluye */
	 int iDiasProrroga	[HOSTARRAY_CRITER];     /* numero de dias que se prorroga */
} td_Criterio ;

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
