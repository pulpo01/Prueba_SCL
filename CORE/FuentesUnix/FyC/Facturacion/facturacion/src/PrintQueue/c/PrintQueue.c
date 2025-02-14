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

