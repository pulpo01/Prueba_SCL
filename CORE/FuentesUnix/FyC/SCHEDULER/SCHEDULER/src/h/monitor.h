#include <sys/ipc.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/procfs.h>
#include <netinet/in.h>
#include <sys/msg.h>
#include <netdb.h>
#include <signal.h>
#include <string.h>
#include <errno.h>
#include <time.h>
#include <fcntl.h>
#include <stdlib.h>
#include <dirent.h>
#include <unistd.h>
#include <sqlcpr.h>
#include <sqlda.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>

#define MSGSZ       500
#define MAX_PENDING	100
#define BUFFER_SIZE	10000
#define FACTOR		1000
#define KEYCOLASCH  000002
#define BEGIN_STR	"#BEGIN#\n"
#define END_STR		"#END#\n"
#define BEGIN_SIZE	8
#define END_SIZE	6
#define begin       {
#define end         }
#define and         &&
#define or          ||
#define NE          !=
#define Gtrue       1
#define Gfalse      0
#define SqlNull     1405
#define SqlORADUP   1
#define SqlOk       0
#define SQLORA_NULL -1
#define SQLMANYROWS 2112 
#define SqlNotFound 1403
#define blanco      32
/*
   Manejo de Versiones -HOM- rast TM-200608082112, Inc 35422
*/
#define PROG_VERDES    "1.0"
#define FEC_VERDES     "00-00-0000"
#define PROG_VERSOP    "1.2"
#define FEC_VERSOP     "13-11-2007"

extern int errno;
char LineaComando[500];
int  Njobs;

/*===============================================================*/
/* Declare the message structure.                                */
/*===============================================================*/
typedef struct _msgbuf 
{
    long    mtype;
    char    mtext[MSGSZ];
} message_buf;

void mid(szpalabra,iini,ilargo,szvuelta)
char *szpalabra;
int iini;
int ilargo;
char *szvuelta;
{
    int ii,icr;
    icr = Gtrue;
    if (ilargo < 0)
       {
       ilargo *= -1;
       icr = Gfalse;
       }
	szpalabra += iini - 1;
    for (ii=iini;ii<=(iini + ilargo -1);ii++)
    {
        *szvuelta = *szpalabra;
        szvuelta++;szpalabra++;
    }

    if (icr) *szvuelta = 0;
}

int sep_parameter( char * origin ) {

  int    i,j=0,l;

  if ( (l = strlen(origin)) < 1 )
    return 0;

  for ( i = 0; i < l; i++ )
    if ( origin[i] == '|' ) {
      origin[i] = ' '; j++;
    }
  return j;
}

void log(FILE * logf, char *logs ) {

  time_t      now;
  struct tm * tm_time;

  now = time(NULL);
  tm_time = localtime(&now);
  fprintf( logf, "[%02d:%02d:%02d %02d/%02d/%02d]: %s\n",
           tm_time->tm_hour, tm_time->tm_min, tm_time->tm_sec,
           tm_time->tm_mday, tm_time->tm_mon, tm_time->tm_year,
           logs );
  fflush( logf );
}

int read_line( int sock, char * buff ) {

   int j = 0;
/*
   Se agrega variable l -HOM- rast TM-200608082112, Inc 35422
*/
   int l = 0;
   char c;

   for (;;)
   {
      l = read(sock,&c,1);
      if ( l < 0 )
      {
         buff[j] = 0;
         return -1;
      }

      if ( c == '\n' )
      {
         buff[j] = 0;
         return j;
      }

      if (l == 0)
      {
         fprintf(stdout,"Sock sin datos\n");
         buff[j] = 0;
         return -1;
      }

      buff[j++] = c;
   }
}

int write_begin( int sock, FILE * logf ) 
{
   char logs[BUFFER_SIZE];
   int tmp_wr;

   tmp_wr = write(sock,BEGIN_STR,BEGIN_SIZE);

   if ( tmp_wr != BEGIN_SIZE )
      return -1;

   return 1;
}

int write_end( int sock, FILE * logf ) 
{
   char logs[BUFFER_SIZE];
   int itmp_wr;

   itmp_wr = write(sock,END_STR,END_SIZE);

   if ( itmp_wr != END_SIZE )
      return -1;

   return 1;
}

int write_single( int sock, FILE * logf, char * buff ) 
{
   char logs[BUFFER_SIZE];
   int  buflen;
   int  itmp_wr;

   buflen = strlen(buff) - 1;
   while ( (buflen+1) && (buff[buflen] == '\n') )
      buff[buflen--] = 0;

   buff[++buflen] = '\n';
   buff[++buflen] = '\0';

   itmp_wr = write_begin(sock,logf);
   if ( itmp_wr < 0 )
      return -1;

   itmp_wr = write(sock,buff,buflen);
   if ( itmp_wr != buflen )
      return -2;

   itmp_wr = write_end(sock,logf);
   if ( itmp_wr < 0 )
      return -3;

   return 1;
}

int write_multi( int sock, FILE * logf, char * buff ) 
{
   char logs[BUFFER_SIZE];
   int  buflen;
   int  itmp_wr;

   buflen = strlen(buff) - 1;

   while ( (buflen+1) && (buff[buflen] == '\n') )
      buff[buflen--] = 0;

   buff[++buflen] = '\n';
   buff[++buflen] = '\0';

   itmp_wr = write(sock,buff,buflen);
   if ( itmp_wr != buflen )
      return -1;

   return 1;
}


int read_single( int sock, FILE * logf, char * cmd, char * param ) 
{
   char logs[BUFFER_SIZE];
   char * pos;
   int  itmp_rd;

   itmp_rd = read_line(sock,cmd);
   if ( itmp_rd < 0 )
      return -1;

   if ( (pos = strstr(cmd,"+")) == NULL )
      param[0] = 0;
   else 
   {
      strcpy( param, pos+1 );
      *pos = 0;
   }
   return 1;
}

void trim(szpalabra,iini,ilargo,szvuelta)
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
