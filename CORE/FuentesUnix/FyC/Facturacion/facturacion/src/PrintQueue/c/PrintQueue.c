#include <stdio.h>
int main (int argc,char *argv[])
{

    char szComando[254]="";
    int  ret;

    printf ("Numero de Parametros [%d]\n",argc);
    printf ("Parametro 0 [%s]\n",argv[0]);
    printf ("Parametro 1 [%s]\n",argv[1]);
    printf ("Parametro 2 [%s]\n",argv[2]);
    if (argc != 3 )
    {
        printf("Faltan Parametro...\n");
        return -1;
    }
    sprintf(szComando,"/usr/bin/awk '{print \"            \"$0}' %s|/usr/bin/lp -d %s\n",argv[2],argv[1]);
    printf ("Comando [%s]\n",szComando);
    ret=system (szComando);
    printf ("Retorno  [%d]\n",ret);
    return(ret);
}


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

