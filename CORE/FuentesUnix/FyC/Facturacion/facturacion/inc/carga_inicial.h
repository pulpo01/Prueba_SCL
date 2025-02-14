#define ERROR_SEM_LOCK			6
#define ERROR_SEM_LOCK_AND_WAIT 	7
#define ERROR_SEM_UNLOCK        	10

#define CANT_TH   			2
#define CANT_CTX  			2

#define TH_DATOS      			0
#define TH_CLIENTES      		1

typedef struct tag_PARAM
{
  void  *p1;
  void  *p2;
  void  *p3;
  void  *p4;
  void  *p5;
}PARAM;

int ifnCopiarShared( void);
BOOL bfnCargarShared( char  *szTable);

void * fncDatos( void* pArg);
void * fncClientes( void* pArg);
void * fncAnexos( void* pArg);
void * fncDirecciones( void* pArg);
void * fncGrupoCob( void* pArg);
void * fncUnipac( void* pArg);
