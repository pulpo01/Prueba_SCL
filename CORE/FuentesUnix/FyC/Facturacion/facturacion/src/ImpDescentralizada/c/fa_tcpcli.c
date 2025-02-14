#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
#include <unistd.h> /* close */

int TcpOpenSock(char *szHostIp,int iPort)
{
	int rc,sd;
	struct sockaddr_in localAddr, servAddr; 
	struct linger linger; /* usada para setsockopt() */
	
	
	
	servAddr.sin_family = AF_INET;
	servAddr.sin_addr.s_addr = inet_addr(szHostIp); 
	servAddr.sin_port = htons(iPort);
	
	/* crea el socket */
	sd = socket(AF_INET, SOCK_STREAM, 0);
  	if(sd<0) {
	    printf("No se pudo abrir el  socket\nAplicacion terminada con error\n");
	    exit(1); /*Si no es capaz de crear el socket abandona la aplicacion*/
  	}
  	linger.l_onoff = 1; /* Linger On=1 off=0 */
	linger.l_linger = 1; /*se cierra inmediatamente en 1 segundo*/

  	setsockopt(sd,SOL_SOCKET,SO_LINGER,(char *)&linger,sizeof(linger));
  	
  	
  	/* Enlaza con un puerto cualquiera  */
	  
	localAddr.sin_family = AF_INET;
	localAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	localAddr.sin_port = htons(0);
	  
	rc = bind(sd, (struct sockaddr *) &localAddr, sizeof(localAddr));
	if(rc<0) {
		printf("No se puede enlazar al port TCP %u\n",iPort);
		perror("error en la fucncion Bind\n");
		exit(1);
	}
	printf("Socket en TcpOpenSock %d\n",sd);
	rc=connect(sd, (struct sockaddr *) &servAddr, sizeof(servAddr));
	if(rc <0){
		close(sd);
		return(rc);
	}
	else
	  return(sd);
}


main(int argc,char **argv){
  int sd, rc, iControl,iEstado;  
  char buffer[500], pathname[500], arcpdf[22+1], secuencial[15+1], ack[2+1],execstr[150];
  char *hostip,*server_port,*aux;
  struct stat info_file;
  long lsecuen;
  FILE *arc;
  
  iControl=0;
  iEstado=1;
 
  if(argc < 5){
     printf("uso %s <file> <path> <host ip> <server port> \n",argv[0]);
     exit(1);
    }
    hostip=argv[3];
    server_port=argv[4];
    sprintf(pathname,"%s/%s",argv[2],argv[1]);
      
				
  /* conexion al server socket */
  
  sd=TcpOpenSock(hostip, atoi(server_port));
  while(sd<0 && iControl<3){
  	++iControl;
  	printf("Fallo en la conexion\nReintento [%2d]\n",iControl);
  	usleep(2000000);  	
  	sd=TcpOpenSock(hostip,atoi(server_port));
  }
  if(sd<0){
  	printf("No se logro la conexion despues de 3 Intentos\n"
  	       "Se abandona la ejecucion de: [%s]\n",argv[0]);
  	exit(1);
  }
   
 
 if( (arc=(fopen(pathname,"r"))) == NULL  ){
 	printf("El archivo %s \n %s no se encuentra \n"
 	       "Se hara abandono del programa [%s]\n",argv[1],pathname ,argv[0]);
 	exit(1);
    }else {fclose(arc);}
    
    stat(pathname,&info_file);
   
    printf ("Tamano del archivo = %d\n", info_file.st_size);

    sprintf(buffer,"%010u,%s",info_file.st_size,pathname);
    printf("%s\n",buffer);
   
    rc = send(sd, buffer,strlen(buffer) + 1, NULL);
    if(rc<0) {
      perror("No se puedo enviar la data \nError en funcion SEND\n");
      close(sd);
      exit(1);
    }
    fflush(stdin);
    
    rc = recv(sd, buffer,strlen(buffer)+1, NULL);
    buffer[rc]='\0';
    printf("\n\n%s",buffer);
    printf("Archivo %s:\ntotal data (%u)\n(%s)\n",argv[1],rc,buffer);
    if(rc<0) {
      perror("No se pudo recibir la respuesta desde el servidor\nError en la funcion RECV\n");
      close(sd);
      exit(1);
    }else{
     strncpy(ack,&buffer[0],2); 
     ack[2]='\0';
     strncpy(secuencial,&argv[1][3],15);
     secuencial[15]='\0';
     lsecuen=atol(secuencial);
     /*printf("ack= [%s]\n",ack);*/
     if (strncmp(ack,"OK",2)==0){
         printf("\n Archivo de datos fue transferido Satistfactoriamente\n");
         }
      if (strncmp(ack,"ER",2)==0){
 	  printf("\nArchivo no transferido \n");
/* TM-200502181278 20040222*/
          close(sd);
          exit(1);
 	}
       
    }
   close(sd); 
   return 0;
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

