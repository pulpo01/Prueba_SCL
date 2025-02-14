/***************************************************************************/
/* definicion de prototipos												   */
/***************************************************************************/
/* Macro Funcion para testear NULL  */
#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

extern 	char	*pszEnviron 	( char *pszVarAmb
					, char *pszAmbiente);
extern 	char	*pszGetDateLog 	( void );
extern 	void	vFechaHora 		( void );
extern 	char 	*pszFechaHora 	( void );
extern 	int 	iMakeDir 		( char *pszDir);
extern 	long	lGetTimer 		( void );
extern 	char	*pszGetDate 	( void );
extern 	void	vWriteLog 		( FILE *Args, ...);

/* Funciones de Manejo de strings    */
extern  int     _strlen(char *);
extern  char    *_ltrim(char *);
extern  char    *_rtrim(char *) ;


/******************************************************************************************/
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
