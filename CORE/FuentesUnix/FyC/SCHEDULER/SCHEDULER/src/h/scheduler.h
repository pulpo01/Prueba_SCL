#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <time.h>

int SENAL_STOP =0;
int SENAL_PAUSA=0;

void SCHfecha_sistema(char *Fecha, int Forma)
{
/*  Formatos de Fecha del Sistema 
	0 = 'hh24:mi:ss dd/mm/yyyy'
	1 = 'yyyymmddhh24miss'		*/
   time_t now;
   struct tm * tm_time;
   now     = time(NULL);
   tm_time = localtime(&now);
   if (Forma==1)
   {
	   sprintf(Fecha, "%04ld%02d%02d%02d%02d%02d", 
	       tm_time->tm_year + 1900, tm_time->tm_mon + 1 ,tm_time->tm_mday, 
            tm_time->tm_hour, tm_time->tm_min, tm_time->tm_sec);
   }
   else
	{   
	   sprintf(Fecha, "%02d:%02d:%02d %02d/%02d/%04ld", 
	       tm_time->tm_hour, tm_time->tm_min, tm_time->tm_sec,
           tm_time->tm_mday, tm_time->tm_mon + 1 , tm_time->tm_year + 1900);
    }
}

extern void senal_pausa(int p)
{
   char FechaSistema[30];
   signal(SIGUSR1,senal_pausa);
   SCHfecha_sistema(FechaSistema,0);
   printf ("--->>> Se recibe senal de PAUSA [%s]         <<<---- \n",FechaSistema);
   SENAL_PAUSA = 1;	
}

extern void senal_terminar(int p)
{
   char FechaSistema[30];
   signal(SIGUSR2,senal_terminar);
   SCHfecha_sistema(FechaSistema,0);
   printf ("--->>> Se recibe senal de TERMINO [%s]       <<<---- \n",FechaSistema);
   SENAL_STOP = 1;
}

extern void senal_continue(int p)
{
   char FechaSistema[30];
   signal(SIGCONT,senal_continue);
   SCHfecha_sistema(FechaSistema,0);
   printf ("--->>> Se recibe senal de CONTINUACION [%s]  <<<---- \n",FechaSistema);
   SENAL_PAUSA = 0;	
}

void ejecuta_accion()
{
	if (SENAL_PAUSA) pause();
}
