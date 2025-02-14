/*************************************
Autor : VMB
*************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sqlda.h>
#include <signal.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>

/*************************************
 Declaracion de Constantes
*************************************/
#define      debug1           0
#define      debug            0
#define      true             1
#define      false            0
#define      SqlNotFound      1403
#define      SqlNull          1405
#define      SqlORADUP        1
#define      SqlOk            0
#define      SQLORA_NULL      -1
#define      SQLMANYROWS      2112
#define      and              &&
#define      or               ||
#define      NE               !=
#define      EQ               ==
#define      blanco           32
#define      MaxReg           500
#define      Maxprefespe      500
#define      MaxReg           500 
#define      MAXFILE 215

FILE *p=NULL;
long sector=0;
char lineafile[MAXFILE];
char lineanueva[210];
char szclave[11];
char reglinea[41];
char parte[10];
char char_actual[1];
char num_ret[40];
char szdurreal[21];
char szdurtarifada[21];
char szdurdescontada[21];
char szmreal[31];
char szmfacturado[31];
char szmdescontado[31];
char szcantreal[21];
char szcanttar[21];
char szcantdesc[21];
char szcantmreal[31];
char szcantmfact[31];
char szcantmdesc[31];
char szregistros[21];  
char szcanreg[21];
char curtimeI[20],curtimeF[20];

/**********************************
definicion de funciones especiales
***********************************/
double          round1() ;
double          atof1() ;
double          power1() ;
extern void sigTermHandler(int p);
/************************************************************/
/* Funcion    :sigTermHandler                               */
/* Objetivo   :                                             */
/************************************************************/
extern void sigTermHandler(int p)
{
 printf ("Programa recibe Kill(%d) \n",p);
 exit(1);
}
/************************************************************/
/* Funcion    :fncommand                                    */
/* Objetivo   :Ejecuta comandos de UNIX                     */
/************************************************************/
fncommand(cmd,buff_cmd)
char *cmd;
char *buff_cmd;
{
   FILE *pf;
   char *p_aux;
   pf = popen(cmd, "r");
   if (pf == NULL)
       strcpy(buff_cmd, "E   Error en ejecucion del comando");
   else
       {
       strcpy(buff_cmd,"\n");
       while (fgets(buff_cmd + strlen(buff_cmd),512,pf))
           if (strlen(buff_cmd) > 5000)
              break;
       }
   p_aux = buff_cmd;
   *(p_aux + strlen(buff_cmd) + 1) = 0;
   pclose(pf);
}
/************************************************************/
/* Funcion    :fnsaca_command                               */
/* Objetivo   :Retorna Salida   segun comando UNIX          */
/************************************************************/
fnsaca_command(buff_arch1,nombre_arch)
char *buff_arch1;
char *nombre_arch;
{
    char *p_aux;
    char *p_aux1;
    for (p_aux = buff_arch1,p_aux1 = nombre_arch
              ;*p_aux != 10 and *p_aux != 13 and *p_aux != 0;p_aux++)
    {
        if (*p_aux != blanco) 
           {
           *p_aux1 = *p_aux ;
           p_aux1++;
           }
        *p_aux  = blanco;
    }
    *(p_aux - 1)  = blanco;
    *p_aux  = blanco;
    *p_aux1 = 0;
   if (strlen(nombre_arch) > 10)
      return(true);
   else
      return(false);
}
/************************************************************/
/* Funcion    :trim                                         */
/* Objetivo   :                                             */
/************************************************************/
trim(szpalabra,iini,ilargo,szvuelta)
char *szpalabra;
int iini;
int ilargo;
char *szvuelta;
{
    int ii,icr;
    szpalabra += iini - 1;
    for (ii=iini;ii<=(iini + ilargo -1);ii++)
    {
        if (*szpalabra NE blanco)
           {
           *szvuelta = *szpalabra;
           szvuelta++;
           }
        szpalabra++;
    }
   *szvuelta = 0;
}
/************************************************************/
/* Funcion    : mid                                         */
/* Objetivo   :                                             */
/************************************************************/
mid(szpalabra,iini,ilargo,szvuelta)
char *szpalabra;
int iini;
int ilargo;
char *szvuelta;
{
    int ii,icr;
    icr = true;
    if (ilargo < 0)
       {
       ilargo *= -1;
       icr = false;
       }
    szpalabra += iini - 1;
    for (ii=iini;ii<=(iini + ilargo -1);ii++)
    {
        *szvuelta = *szpalabra;
        szvuelta++;szpalabra++;
    }

  if (icr)
   *szvuelta = 0;
}
/************************************************************/
/* Funcion    :fncarga_char                                 */
/* Objetivo   :                                             */
/************************************************************/
char *fncarga_char(char campos[30],int numero,int decimales)
{
 char bl[2];
 int i,largo;

 largo=strlen(campos);
 if (decimales>0) {
  for(i=1;i<=largo;i++) 
    if (campos[i] EQ '.') {
  mid(campos,1,i + decimales + 1,campos);
  break;
    }
 }   

 largo=strlen(campos);
 if (largo>numero) 
    mid(campos,1,numero,campos);

 strcpy(bl," ");
 for(i=1;i<=numero-largo;i++) 
   strcat(campos,bl);
  return(campos);
}
/************************************************************/
/* Funcion    :round1                                       */
/* Objetivo   :                                             */
/************************************************************/
double round1(numero, decimales)
double          numero ;
unsigned        decimales ;
{
  double          res ;
  unsigned        flag_signo = 0 ;
  unsigned        actual ;
  unsigned        ii ;

  parte[0] = '\0' ;
  if(numero < 0 ) 
  {
    flag_signo = 1 ;
    numero = numero*(-1) ;
  }
  if( decimales > 6 ) decimales = 6 ;
  res = numero  ;
  for(ii = 0 ;; ii++ )
  {
    res =(res - (int)res)*10 ;
    actual = (int)res ;

    if(decimales <= ii )
    {
      res = atof(parte) ;
      if( actual >= 5 ) res = res + 1. ;
      res = res/power1(10.0, (double)ii) ;
      break ;
    }
    itoa1(actual, char_actual) ;
    strcat(parte, char_actual) ;
  }
  res = (int)numero + res ;
  if( flag_signo == 1)
    res = res*(-1) ;
  return(res) ;
}
/************************************************************/
/* Funcion    :itoa1                                        */
/* Objetivo   :                                             */
/************************************************************/
itoa1(n, s)
char  s[] ;
int     n ;
{
  int     i, sign ;
  if ((sign = n ) < 0 )   /*anota el signo */
    n = -n ;        /*transforma n a positivo*/
  i = 0 ;
  do  {                   /* genera digitos en orden inverso */
    s[i++] = n % 10 + '0' ; 
  }while ((n /= 10) > 0) ;        /* lo elimina   */
  if(sign < 0)
    s[i++] = '-' ;
  s[i] = '\0' ;
  reverse1(s) ;
}
/************************************************************/
/* Funcion    :reverse1                                     */
/* Objetivo   :                                             */
/************************************************************/
reverse1(s)
char    s[] ;
{
  int     c, i, j ;
  for(i=0, j = strlen(s)-1; i < j ; i++, j--) {
    c= s[i] ;
    s[i] = s[j] ;
    s[j] = c ;
  }

}
/************************************************************/
/* Funcion    :power1                                       */
/* Objetivo   :                                             */
/************************************************************/
double power1(x, n)
double  x ;
double  n ;
{
  double  p ;
  for(p = 1.0 ; n > 0 ; --n)
    p = p * x ;
  return(p) ;
}
/************************************************************/
/* Funcion    :ipower1                                      */
/* Objetivo   :                                             */
/************************************************************/
int ipower1(x, n)
int x ;
int n ;
{
  int p ;
  for(p = 1 ; n > 0 ; --n)
    p = p * x ;
  return(p) ;
}
/************************************************************/
/* Funcion    :fnEstadistica                                */
/* Objetivo   :                                             */
/************************************************************/
fnEstadistica(char *szbusqueda,char *sznomfile,char *nom_empa,char *szcodigo,int icantidadRegistros,long ldurreal,long ldurtarifada,long ldurdescontada,double dmreal,double dmfacturado,double dmdescontado)
{
   int bindica=true;
   sector=0;  
   trim(szbusqueda,1,strlen(szbusqueda),szbusqueda);
   printf ("sznomfile [%s] szcodigo [%s]\n",sznomfile,szcodigo);
   fnFilePatron(&p,sznomfile,2,szcodigo,"");
   while((fgets(lineafile,MAXFILE,p) NE NULL)){   
   
        mid(lineafile,1,40,reglinea);
        mid(lineafile,31,10,szclave);
        trim(szclave,1,strlen(szclave),szclave);
        sector=ftell(p);
		printf ("szclave [%s] [%s]\n",szclave,szbusqueda);
      if (strcmp(szclave,szbusqueda) EQ 0){
        sector-=211; 
        if (sector< 0) sector=0;
        fseek(p,sector,SEEK_SET);
        mid(lineafile,41,20,szregistros);
        mid(lineafile,61,20,szdurreal);
        mid(lineafile,81,20,szdurtarifada);
        mid(lineafile,101,20,szdurdescontada);
        mid(lineafile,121,30,szmreal);
        mid(lineafile,151,30,szmfacturado);
        mid(lineafile,181,30,szmdescontado);

        sprintf(szcanreg,"%d",atol(szregistros)+icantidadRegistros);
        sprintf(szcantreal,"%d",atol(szdurreal)+ldurreal);
        sprintf(szcanttar,"%d",atol(szdurtarifada)+ldurtarifada);
        sprintf(szcantdesc,"%d",atol(szdurdescontada)+ldurdescontada);
        sprintf(szcantmreal,"%.5f",atof(szmreal)+dmreal);
        sprintf(szcantmfact,"%.5f",atof(szmfacturado)+dmfacturado);
        sprintf(szcantmdesc,"%.5f",atof(szmdescontado)+dmdescontado);

        strcpy(szcanreg,fncarga_char(szcanreg,20,0));
        strcpy(szcantreal,fncarga_char(szcantreal,20,0));
        strcpy(szcanttar,fncarga_char(szcanttar,20,0));
        strcpy(szcantdesc,fncarga_char(szcantdesc,20,0));
        strcpy(szcantmreal,fncarga_char(szcantmreal,30,0));
        strcpy(szcantmfact,fncarga_char(szcantmfact,30,0));
        strcpy(szcantmdesc,fncarga_char(szcantmdesc,30,0));
        sprintf(lineanueva,"%s%s%s%s%s%s%s%s\n",reglinea,szcanreg,szcantreal,szcanttar,szcantdesc,szcantmreal,szcantmfact,szcantmdesc);
        fputs(lineanueva,p);
        bindica=false;
        break;
       }      
  }    
    
  if (bindica){
      sprintf(szcanreg,"%d",icantidadRegistros);
      sprintf(szcantreal,"%d",ldurreal);
      sprintf(szcanttar,"%d",ldurtarifada);
      sprintf(szcantdesc,"%d",ldurdescontada);
      sprintf(szcantmreal,"%.5f",dmreal);
      sprintf(szcantmfact,"%.5f",dmfacturado);
      sprintf(szcantmdesc,"%.5f",dmdescontado);
    
      strcpy(szcanreg,fncarga_char(szcanreg,20,0));
      strcpy(szcantreal,fncarga_char(szcantreal,20,0));
      strcpy(szcanttar,fncarga_char(szcanttar,20,0));
      strcpy(szcantdesc,fncarga_char(szcantdesc,20,0));
      strcpy(szcantmreal,fncarga_char(szcantmreal,30,0));
      strcpy(szcantmfact,fncarga_char(szcantmfact,30,0));
      strcpy(szcantmdesc,fncarga_char(szcantmdesc,30,0));
      strcpy(szbusqueda,fncarga_char(szbusqueda,10,0));
      fprintf(p,"%s%s%s%s%s%s%s%s%s",nom_empa,szbusqueda,szcanreg,szcantreal,szcanttar,szcantdesc,szcantmreal,szcantmfact,szcantmdesc);
      fprintf(p,"\n");
    }
    fclose(p);
}

