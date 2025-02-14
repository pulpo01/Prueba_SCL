#include <iostream>
#include <fstream>
#include <stack>
#include <sstream>
#include <string>
#include <map>
#include <iomanip>
#include <vector>
#include <cmath>
#include <ctime>
#include <cstdlib>
#include <dirent.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <fcntl.h>
#include "carga_inicial_ImpScl.h"
#include "NivelLog.h"
#include "token.h"
#include <errno.h> 


using namespace std;
int    NivelLog::actuallevel=1;
bool   NivelLog::yaactual=false;
struct sembuf operaciones[1];

extern int errno; 

NivelLog::NivelLog(int n):level(n){}

int NivelLog::ObtieneNivelLog(){
    return actuallevel;
}

void NivelLog::SetActual(bool v)
{
    yaactual=v;
}

void NivelLog::SetNivelLog(int i){
    actuallevel=i;
    yaactual = false;
}

bool NivelLog::ObtieneActual(){
    return yaactual;
}

ostream& operator<<(std::ostream& os, const NivelLog& n){
    
    int actuallevel=NivelLog::ObtieneNivelLog();
    if (!NivelLog::ObtieneActual()){
        std::cout << "################################################################################" << std::endl
                  << "# Nivel de log Actual: " << actuallevel << "                                                       #" << std::endl
                  << "# Para cambiar nivel de log actual, utilice la opcion -l con otro nivel        #" << std::endl
                  << "################################################################################" << std::endl;
        NivelLog::SetActual(true);
    }
                                                                                                                                                            
    if (n.level <= actuallevel){
        time_t secs_now;
        char str[22];
        tzset();
        time(&secs_now);
        strftime(str, 21, "%Y%m%d %H:%M:%S # ", localtime(&secs_now));
        return os << str;
    }
    static std::ostringstream aux;
    return aux;
}

/*****************************************************************************/
/* Funcion que recupera los rangos de clientes a procesar en la maquina      */
/*****************************************************************************/
int GetHostId (char *szHostID)
{
    string filename;
    string directorio;
    string linea;

    directorio = getenv("XPF_CFG");

    filename = directorio + "/" +"host_id.dat";

    ifstream file(filename.c_str());
    if (!file){
        cout << NivelLog(3) << "No fue posible abrir archivo de entrada [" <<  filename << "]" << endl;
        return (-1);
    }
    else 
    {
        getline(file, linea);
        file.close();
    }
    
    strcpy(szHostID,linea.c_str());
    return (0);
}

int login(char * user)
{
  try
  {
  otl_connect::otl_initialize(); 
  cout << NivelLog(3) <<"user : " << user << endl;
  db.rlogon(user);
  cout << NivelLog(3) <<"Login y Password Correctos" << endl;
  return 0;
  }
  catch(otl_exception& error)
  {
    cerr << error.msg << endl;
    cerr << error.stm_text << endl;
    cerr << error.var_info<< endl;
    return 1;
  }
}

int logout()
{
  try
  {
  db.logoff();
  cout << NivelLog(3) <<"Desconectandose de la Base de Datos" << endl;
  return 0;
  }
  catch(otl_exception& error)
  {
    cerr << error.msg << endl;
    cerr << error.stm_text << endl;
    cerr << error.var_info<< endl;
    return 1;
  }
}

bool check_dir(const string& sdir)
{
   DIR *dir= opendir(sdir.c_str());
   if (dir==NULL)
    return FALSE;
   else 
    return TRUE;
   closedir(dir);
}

int create_directory(const string& ciclo_facturacion, char * host_id)
{
try
  {
   int j=0;
   int i=0;
   int iIndNoHost=0;
   cout << NivelLog(3) <<"COMENZANDO A CREAR DIRECTORIOS DE TRABAJO" << endl;
   int encontrado;
   string path_defecto;
   otl_nocommit_stream qry1(1024,"SELECT PATHBIN FROM FA_DATOSGENER",db); 
   qry1 >> path_defecto;

   otl_nocommit_stream qry2(1024,"SELECT COD_TIPDOCUM, "
                                 "       COD_DESPACHO  "
                                 "  FROM FA_PROCIMPRESION_TD A " 
                                 " WHERE A.COD_CICLFACT = :ciclo<char[7]> "
                                 "   AND A.COD_ESTAPROC = 1 "
                                 "   AND (A.HOST_ID = :hostsID<char[21]> OR 1=:iIndNoHost<int>)" ,db);
	/* valida que el Host_ID este informado */
	if (strcmp(host_id, "-1")==0)
		iIndNoHost = 1;
		
   qry2 << ciclo_facturacion << host_id << iIndNoHost; 
   while (!qry2.eof())
   {
      int tip_docum ;
      string cod_despacho ;
      qry2 >> tip_docum >> cod_despacho;
      memset(memoria[j].directorio[i].zpath,'\0',sizeof(memoria[j].directorio[i].zpath));
      memset(memoria[j].directorio[i].zcod_despacho,'\0',sizeof(memoria[j].directorio[i].zcod_despacho));
      memoria[j].directorio[i].itip_docum = tip_docum ;
      strncpy(memoria[j].directorio[i].zcod_despacho,cod_despacho.c_str(),strlen(cod_despacho.c_str()));
      i++;
   }

   int l=0;
   otl_nocommit_stream qry3(1024,"SELECT DES_PARAMETRO, "
                                 "       VAL_CARACTER   "
                                 "  FROM FAD_PARAMETROS " 
                                 " WHERE DES_PARAMETRO LIKE 'IMP_RUTA%' ",db); 
   while (!qry3.eof())
   {
      string des_parametro ;
      string val_caracter ;

      qry3 >> des_parametro >> val_caracter;

      encontrado=0;
      for (l=0;l<i ;l++ )
      {
          ostringstream aux1;
          ostringstream aux2;
          string llave_td;
          aux1 << setw(2) << setfill('0') << memoria[j].directorio[l].itip_docum ;
          aux2 << memoria[j].directorio[l].zcod_despacho ;
          llave_td = "IMP_RUTA_" + aux1.str() + "_" + aux2.str();
          if (des_parametro==llave_td)
          {
             memset(memoria[j].directorio[l].zpath,'\0',sizeof(memoria[j].directorio[l].zpath));
             strncpy(memoria[j].directorio[l].zpath,val_caracter.c_str(),strlen(val_caracter.c_str()));
             encontrado=1;
          }
      }
   }
  
   for (l=0;l<i ;l++ )
   {
      if(strlen(memoria[j].directorio[l].zpath)==0)
      {
         memset(memoria[j].directorio[l].zpath,'\0',sizeof(memoria[j].directorio[l].zpath));
         strncpy(memoria[j].directorio[l].zpath,path_defecto.c_str(),strlen(path_defecto.c_str()));
      }
   }

   memoria[j].num_directorios = i;
   cout << NivelLog(3) <<"IMPRIMIENDO EXTRUCTURA DIRECTORIOS........." << endl;
   for (l=0;l<i ;l++ )
   {
        cout << NivelLog(3) <<"CREANDO DIRECTORIO PARA TIPO DE DOCUMENTO : " << memoria[j].directorio[l].itip_docum ;
        cout << NivelLog(3) <<" Y CODIGO DE DESPACHO : " << memoria[j].directorio[l].zcod_despacho << endl;
        cout << NivelLog(3) <<"DIRECTORIO : " << memoria[j].directorio[l].zpath << endl;
        string directory = memoria[j].directorio[l].zpath;
        if (directory.size()>1)
        {
           string slash = directory.substr(0,1);
           Tokenizer tok(directory,"/");
           int n= tok.Execute();
           cout << NivelLog(3) <<  "Valor de N :" << n << endl;
           int k;
           string dir_completo;
           for (k=0;k<n ;k++ )
           {
              string dir = tok.GetWord(k);
              cout << NivelLog(3) << "Directorios : " << dir << endl;
              dir_completo = dir_completo + slash + dir;
              if (!check_dir(dir_completo))
              {
                 cout << NivelLog(3) <<"DIRECTORIO NO EXISTE" << endl;
                 int ret=mkdir(dir_completo.c_str(),S_IRWXO | S_IRWXG | S_IRWXU);
                 if (ret==0)
                 {
                      cout << NivelLog(3) << "DIRECTORIO CREADO CON EXITO" << endl;
                 }
                 else 
                 {
                    cout << NivelLog(3) << "NO SE PUEDE CREAR EL DIRECTORIO SE TOMA DIRECTORIO POR DEFECTO" << endl;
                    memset(memoria[j].directorio[l].zpath,'\0',sizeof(memoria[j].directorio[l].zpath));
                    strncpy(memoria[j].directorio[l].zpath,path_defecto.c_str(),strlen(path_defecto.c_str()));
                    break;
                 }
                }
           }
           cout << NivelLog(3) << "Directorio Completo : " << dir_completo << endl;
        }
   }
   for (l=0;l<i ;l++ )
   {
         cout << NivelLog(3) << "TIPO DE DOCUMENTO  : " << memoria[j].directorio[l].itip_docum << endl;
         cout << NivelLog(3) << "CODIGO DE DESPACHO : " << memoria[j].directorio[l].zcod_despacho << endl;
         cout << NivelLog(3) << "DIRECTORIO FINAL   : " << memoria[j].directorio[l].zpath << endl;
   }
   return 0;
  }
  catch(otl_exception& error)
  {
    cerr << error.msg << endl;
    cerr << error.stm_text << endl;
    cerr << error.var_info<< endl;
    return 1;
  }
}

int actualiza_faprocimpresion(const string& ciclo_facturacion,int estado_ant , int estado_actual, char *host_id)
{
try
{
	int iIndNoHost=0;

   	cout << NivelLog(3) << "ACTUALIZANDO FA_PROCIMPRESION_TD EN ESTADO : " << estado_actual << endl;
   	otl_nocommit_stream qry(1024," UPDATE FA_PROCIMPRESION_TD SET COD_ESTAPROC = :estado_act<int>  "
                                "  WHERE COD_CICLFACT = :ciclo<char[7]> AND COD_ESTAPROC = :estado_ant<int> "
                                "    AND (HOST_ID = :hostsID<char[21]> OR 1=:iIndNoHost<int>)" ,db);
	/* valida que el Host_ID este informado */
	if (strcmp(host_id, "-1")==0)
		iIndNoHost = 1;
   	qry << estado_actual << ciclo_facturacion << estado_ant << host_id << iIndNoHost;
   	return 0;
}catch(otl_exception& error){

        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
   return 1;
}
}

int actualiza_faprocimpresion_cp(const string& ciclo_facturacion,int tipdoc,const string& tip_despacho,int estado_ant,int estado_act,char *host_id)
{
try
{
	int iIndNoHost=0;
    cout << NivelLog(3) << "TIPO DE DOCUMENTO : " << tipdoc << endl;
    cout << NivelLog(3) << "TIPO DE DESPACHO  : " << tip_despacho << endl;
    cout << NivelLog(3) << "ACTUALIZANDO FA_PROCIMPRESION_TD EN ESTADO : " << estado_act << endl;
    otl_nocommit_stream qry(1024," UPDATE FA_PROCIMPRESION_TD SET COD_ESTAPROC = :estado_act<int> "
                                " WHERE COD_CICLFACT = :ciclo<char[7]> AND COD_ESTAPROC = :estado_ant<int> "
                                  " AND COD_TIPDOCUM = :tipdocum<int>      "
                                  " AND COD_DESPACHO = :despacho<char[6]>  "
                                  " AND (HOST_ID   = :hostsID<char[21]> OR 1=:iIndNoHost<int>)" ,db);
	/* valida que el Host_ID este informado */
	if (strcmp(host_id, "-1")==0)
		iIndNoHost = 1;
                                
    qry << estado_act << ciclo_facturacion << estado_ant << tipdoc << tip_despacho << host_id << iIndNoHost;
    return 0;
}catch(otl_exception& error){

        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
   return 1;
}
}


int tiempo_configurado()
{
    try
    {
        cout << NivelLog(3) << "CONFIGURANDO TIEMPO DE VENCIMIENTO PARA CONCATENADOR....." << endl;
        long salida=0;
        otl_nocommit_stream qry(1024, "SELECT VAL_NUMERICO   "
                                      "  FROM FAD_PARAMETROS "
                                      " WHERE DES_PARAMETRO = 'IMP_MAX_MINUTOS_CONCATENACION'" ,db);
        qry >> salida;
        if (salida==0)
          tiempo_venci=1200;
        else 
          tiempo_venci=(salida*60);
        cout << NivelLog(3) << "IMP_MAX_MINUTOS_CONCATENACION : " << tiempo_venci << endl;
    }
    catch(otl_exception& error){
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        tiempo_venci=1200;
        cout << NivelLog(3) << "IMP_MAX_MINUTOS_CONCATENACION : " << tiempo_venci << endl;
    }
}

int chequea_tiempos(char * szHostId)
{
    ostringstream frecuencia;
    string filename;
    string directorio;
    string linea;
    int retorno_if=0;

    if(getenv("XPF_CFG"))
    {
      directorio = getenv("XPF_TMP");
    }

    filename = directorio + "/" +"tiempos_ImpScl.txt";

    ifstream file(filename.c_str());
    if (!file){
       cout << NivelLog(3) << "No fue posible abrir archivo de entrada [" <<  filename << "]" << endl;
       intentos++;
       retorno_if=-1;
    }
    else 
    {
      getline(file, linea);
      file.close();
      if (strlen(linea.c_str())!=14)
      {
         intentos++;
         retorno_if=-1;
      }
      else 
        intentos=0;
    }

    cout << NivelLog(3) << "INTENTOS DE LEER ARCHIVO :" << intentos << " INTENTOS DE LECTURA :" << intentos_lectura << endl;
    if ((intentos >= intentos_lectura))
    {
        if (todos==0)
        {
          cout <<  NivelLog(3) << "Se ACTUALIZAN Todos los Codigos de Despacho y Tipos de Documentos.a 0...." << endl ;
          actualiza_faprocimpresion(global_ciclo,1,0,szHostId);
        }
        else if(todos==2)
        { 
          cout <<  NivelLog(3) << "Se ACTUALIZA el Tipo de Documento  :" << tipo_documento << endl;
          cout <<  NivelLog(3) << "Se ACTUALIZA el Codigo de Despacho :" << despacho << endl;
          actualiza_faprocimpresion_cp(global_ciclo,tipo_documento,despacho,1,0,szHostId);
        }
        cout << NivelLog(3) << "SE CUMPLIO TIEMPO DE ESPERA o INTENTOS EN LEER EL ARCHIVO " << endl;
        cout << NivelLog(3) << "Se Comienza a Matar Proceso ImpresionScl y Carga Inicial" << endl;
        memoria[0].flag_proceso=2;
        logout();
        cout << NivelLog(3) << "SE COMIENZA A MATAR SEMAFOROS" << endl;
        destruir_semaforo(global_semid);
        cout << NivelLog(3) << "Se COMIENZA A MATAR MEMORIA COMPARTIDA" << endl;
        destroy_memory(global_ret);
        destroy_memory(global_clientes);
        destroy_memory(global_codcli);
        destroy_memory(global_numorden);
        exit(0);
    }

    if (retorno_if==-1)
    {
      return 0;
    }

    frecuencia << linea ;

    int   tm_isdst;
    cout << NivelLog(3) << "Ultimo Tiempo : " << time(0) << endl;
    time_t long_time;
    time(&long_time);
    struct tm *h=localtime(&long_time);

    h->tm_isdst = 1;
    h->tm_hour   = atoi(frecuencia.str().substr(0,2).c_str()) ;
    h->tm_min    = atoi(frecuencia.str().substr(2,2).c_str());
    h->tm_sec    = (atoi(frecuencia.str().substr(4,2).c_str())) -1;
    h->tm_mday   = atoi(frecuencia.str().substr(6,2).c_str());
    h->tm_mon    = (atoi(frecuencia.str().substr(8,2).c_str())) - 1;
    h->tm_year   = (atoi(frecuencia.str().substr(10,4).c_str())) -1900 ;
    long_time=mktime(h);
    cout << NivelLog(3) << "Tiempo Antes  : " << long_time << endl;
    long diff = time(0) - long_time ;

    cout << NivelLog(3) << "Diferencia : " << diff << endl;
    if (diff > tiempo_venci)
    {
       cout << NivelLog(3) << "SE CUMPLIO TIEMPO DE ESPERA o INTENTOS EN LEER EL  ARCHIVO " << endl;
       if (todos==0)
       {
          cout <<  NivelLog(3) << "Se ACTUALIZAN Todos los Codigos de Despacho y Tipos de Documentos.a 0...." << endl ;
          actualiza_faprocimpresion(global_ciclo,1,0,szHostId);
       }
       else if(todos==2)
       { 
          cout <<  NivelLog(3) << "Se ACTUALIZA el Tipo de Documento  :" << tipo_documento << endl;
          cout <<  NivelLog(3) << "Se ACTUALIZA el Codigo de Despacho :" << despacho << endl;
          actualiza_faprocimpresion_cp(global_ciclo,tipo_documento,despacho,1,0,szHostId);
       }
       cout << NivelLog(3) << "Se Comienza a Matar Proceso ImpresionScl y Carga Inicial" << endl;
       memoria[0].flag_proceso=2;
       logout();
       cout << NivelLog(3) << "SE COMIENZA A MATAR SEMAFOROS" << endl;
       destruir_semaforo(global_semid);
       cout << NivelLog(3) << "Se COMIENZA A MATAR MEMORIA COMPARTIDA" << endl;
       destroy_memory(global_ret);
       destroy_memory(global_clientes);
       destroy_memory(global_codcli);
       destroy_memory(global_numorden);
       exit(0);
    }
    return 0;
}

int carga_st_parametros()
{
    try
    {
        otl_nocommit_stream qry(1024, "SELECT   COD_PARAMETRO, "
                                      "         DES_PARAMETRO, "
                                      "         NVL(TIP_PARAMETRO,'NUMBER'), "
                                      "         NVL(VAL_NUMERICO,0), " 
                                      "         NVL(VAL_CARACTER,'0'), "
                                      "         TO_CHAR(NVL(VAL_FECHA,SYSDATE)), "
                                      "         vsize(NVL(VAL_CARACTER,'0')) "   
                                      "FROM     FAD_PARAMETROS "
                                      "WHERE    COD_MODULO='FA' "
                                      "ORDER BY COD_MODULO,COD_PARAMETRO" ,db); 
        ST_PARAMETROS_M val;
        int i = 0;
        int j = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLE ST_PARAMETROS " << endl;
        while (!qry.eof())
        {
            int cod_parametros ;
            string des_parametro;
            string tip_parametro;
            int  val_numerico; 
            string val_caracter;
            string val_fecha;
            int val_cantidad; 
            qry >> cod_parametros >> des_parametro >> tip_parametro >> val_numerico >> val_caracter 
                >> val_fecha >> val_cantidad ;
         
            memset(memoria[j].st_parametros[i].des_parametro,'\0',sizeof(memoria[j].st_parametros[i].des_parametro));
            memset(memoria[j].st_parametros[i].tip_parametro,'\0',sizeof(memoria[j].st_parametros[i].tip_parametro));
            memset(memoria[j].st_parametros[i].val_caracter,'\0',sizeof(memoria[j].st_parametros[i].val_caracter));
            memset(memoria[j].st_parametros[i].val_fecha,'\0',sizeof(memoria[j].st_parametros[i].val_fecha));	   
         
            memset(val.des_parametro,'\0',sizeof(val.des_parametro));
            memset(val.tip_parametro,'\0',sizeof(val.tip_parametro));
            memset(val.val_caracter,'\0',sizeof(val.val_caracter));
            memset(val.val_fecha,'\0',sizeof(val.val_fecha));	   
         
            val.cod_parametros = cod_parametros;   
            strncpy(val.des_parametro,des_parametro.c_str(),strlen(des_parametro.c_str()));
            strncpy(val.tip_parametro,tip_parametro.c_str(),strlen(tip_parametro.c_str()));
            val.val_numerico = val_numerico; 	 
            strncpy(val.val_caracter,val_caracter.c_str(),strlen(val_caracter.c_str())); 	  
            strncpy(val.val_fecha,val_fecha.c_str(),strlen(val_fecha.c_str()));
            val.val_cantidad = val_cantidad;  
            memoria[j].st_parametros[i] = val;
            i++;
        }
        memoria[j].st_parametros_reg = i ;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_st_parametros_ged()
{
    try
    {
        otl_nocommit_stream qry(1024,"SELECT NVL(A.VAL_PARAMETRO,'HH24MISS'),"
                                     "       NVL(B.VAL_PARAMETRO,'DDMMYYYY'),"
                                     "       SUBSTR(C.VAL_PARAMETRO,1,5) ,   "
                                     "       D.VAL_PARAMETRO,                "
                                     "       E.COD_ABONOCEL,                 "
                                     "       F.VAL_PARAMETRO                 "
                                     "  FROM GED_PARAMETROS A,GED_PARAMETROS B,GED_PARAMETROS C,GED_PARAMETROS D, FA_DATOSGENER E,"
                                     "       GED_PARAMETROS F "
                                     " WHERE A.COD_MODULO = 'GE'   AND A.COD_PRODUCTO=1"
                                     "   AND A.NOM_PARAMETRO ='FORMATO_SEL20'          "
                                     "   AND B.COD_MODULO= 'GE'   AND B.COD_PRODUCTO=1 "
                                     "   AND B.NOM_PARAMETRO ='FORMATO_SEL6'           "
                                     "   AND C.COD_MODULO= 'GE'   AND C.COD_PRODUCTO=1 "
                                     "   AND C.NOM_PARAMETRO ='IDIOMA_LOCAL'           "
                                     "   AND D.COD_MODULO= 'GE'   AND D.COD_PRODUCTO=1 "
                                     "   AND D.NOM_PARAMETRO ='NUM_DECIMAL'            "
                                     "   AND F.NOM_PARAMETRO = 'APLICA_CODAUTORIZA'    "
                                     "   AND F.COD_MODULO = 'FA'                       "
                                     "   AND F.COD_PRODUCTO = 1",db);
                                     
                                     
        ST_PARAMETROS_GED_M val;     
        int i = 0;                   
        int j = 0;                   
        cout << NivelLog(3) << "Comenzando a Leer TABLE ST_PARAMETROS_GED " << endl;
        while (!qry.eof())           
        {                            
            string szformato_fecha;  
            string szformato_hora;   
            string szNumDecimal;      
            string szIdiomaOper;    
            int iCodAbonoCel;        
            string sApli_Cod_Autorizacion;

            qry >> szformato_hora >> szformato_fecha >> szIdiomaOper >> szNumDecimal >> iCodAbonoCel >> sApli_Cod_Autorizacion;

            memset(memoria[j].st_parametros_ged.szformato_fecha,'\0',sizeof(memoria[j].st_parametros_ged.szformato_fecha));
            memset(memoria[j].st_parametros_ged.szformato_hora,'\0' ,sizeof(memoria[j].st_parametros_ged.szformato_hora));
            memset(memoria[j].st_parametros_ged.szNumDecimal,'\0'    ,sizeof(memoria[j].st_parametros_ged.szNumDecimal));
            memset(memoria[j].st_parametros_ged.szIdiomaOper,'\0'  ,sizeof(memoria[j].st_parametros_ged.szIdiomaOper));
            memset(memoria[j].st_parametros_ged.sAplica_Cod_Autorizacion,'\0'  ,sizeof(memoria[j].st_parametros_ged.sAplica_Cod_Autorizacion));

            memset(val.szformato_fecha,'\0',sizeof(val.szformato_fecha));
            memset(val.szformato_hora,'\0' ,sizeof(val.szformato_hora));
            memset(val.szNumDecimal,'\0'   ,sizeof(val.szNumDecimal));
            memset(val.szIdiomaOper,'\0'   ,sizeof(val.szIdiomaOper));
            memset(val.sAplica_Cod_Autorizacion,'\0'  ,sizeof(val.sAplica_Cod_Autorizacion));

            strncpy(val.szformato_fecha,szformato_fecha.c_str(),strlen(szformato_fecha.c_str()));
            strncpy(val.szformato_hora,szformato_hora.c_str(),strlen(szformato_hora.c_str()));
            strncpy(val.szNumDecimal,szNumDecimal.c_str(),strlen(szNumDecimal.c_str()));
            strncpy(val.szIdiomaOper,szIdiomaOper.c_str(),strlen(szIdiomaOper.c_str()));
            strncpy(val.sAplica_Cod_Autorizacion, sApli_Cod_Autorizacion.c_str(),strlen(sApli_Cod_Autorizacion.c_str()));

            val.iCodAbonoCel = iCodAbonoCel;
            memoria[j].st_parametros_ged = val;
            i++;
        }
        memoria[j].st_parametros_ged_reg = i;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

/*Modificación Proyecto Ecu-05002 Codigo de Autorización.
Se agrega funcion carga_st_codAutorizacion para rescatar el valor del codigo de autorizacion para los
documentos ciclicos y no ciclicos.
*/
int carga_st_codAutorizacion( string lcod_ciclo)
{
    try
    {
        string sCodi_Autorizacion;
        string szFecVencimiento;
        if (strlen(lcod_ciclo.c_str()) != 0)
        {
            otl_nocommit_stream qry(1024,"SELECT  DISTINCT B.COD_AUTORIZACION, NVL((TO_CHAR(B.FEC_TERMINO,'YYYYMMDD')),' ')"
                                         "  FROM  AL_AUTORIZACION_FOLIO_TD B, "
                                         "        GED_CODIGOS C, FA_CICLFACT D "
                                         " WHERE  D.COD_CICLFACT = :ciclo<char[7]>"
                                         "   AND  D.FEC_EMISION BETWEEN B.FEC_DESDE AND B.FEC_TERMINO"
                                         "   AND  B.COD_SISTEMA= C.COD_VALOR"
                                         "   AND  ROWNUM < 2",db);
            qry << lcod_ciclo;
            
            while (!qry.eof())
            {
                qry >> sCodi_Autorizacion >> szFecVencimiento;

                memset(memoria[0].st_parametros_ged.sCod_Autorizacion,'\0' ,sizeof(memoria[0].st_parametros_ged.sCod_Autorizacion));
                memset(memoria[0].st_parametros_ged.szFecVencimiento,'\0' ,sizeof(memoria[0].st_parametros_ged.szFecVencimiento));
                
                strncpy(memoria[0].st_parametros_ged.sCod_Autorizacion, sCodi_Autorizacion.c_str(),strlen(sCodi_Autorizacion.c_str()));strncpy(memoria[0].st_parametros_ged.sCod_Autorizacion, sCodi_Autorizacion.c_str(),strlen(sCodi_Autorizacion.c_str()));
                strncpy(memoria[0].st_parametros_ged.szFecVencimiento, szFecVencimiento.c_str(),strlen(szFecVencimiento.c_str()));
            }
        }
        else
        {
            otl_nocommit_stream qry(1024,"SELECT COD_AUTORIZACION "
                                         "FROM AL_AUTORIZACION_FOLIO_TD "
                                         "WHERE SYSDATE BETWEEN FEC_DESDE AND FEC_TERMINO",db);

            while (!qry.eof())
            {
                qry >> sCodi_Autorizacion;
                memset(memoria[0].st_parametros_ged.sCod_Autorizacion,'\0'  ,sizeof(memoria[0].st_parametros_ged.sCod_Autorizacion));
                memset(memoria[0].st_parametros_ged.szFecVencimiento,'\0' ,sizeof(memoria[0].st_parametros_ged.szFecVencimiento));
                
                strncpy(memoria[0].st_parametros_ged.sCod_Autorizacion, sCodi_Autorizacion.c_str(),strlen(sCodi_Autorizacion.c_str()));
                strncpy(memoria[0].st_parametros_ged.szFecVencimiento, "        ",strlen("        "));
            }
        }
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_codImptofact()
{
    long lcod_impfact;
    int i;
    
    try
    {
        otl_nocommit_stream qry(1024,"SELECT  VAL_NUMERICO"
                                   "  FROM FAD_PARAMETROS   "
                                   "  WHERE COD_PARAMETRO = 207",db); 
        i=0;
        while (!qry.eof())
        {
            qry >> lcod_impfact;
            memset(&memoria[0].st_concimptosfact[i].iCodConcepto, 0 ,sizeof(memoria[0].st_concimptosfact[i].iCodConcepto));
            memoria[0].st_concimptosfact[i].iCodConcepto=lcod_impfact;
            i++;
        }
        memoria[0].lNumConceptos=i;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

/* Funcion encargada de cargar datos de operadora para memoria compartida. */
int carga_codOper(void)
{
    int i;
    
    try
    {
        otl_nocommit_stream qry(1024,"SELECT COD_OPERADOR, "
                                     "       DES_OPERADOR "
                                     "FROM TA_OPERADORES  "
                                     "ORDER BY COD_OPERADOR ",db); 
        i=0;
        while (!qry.eof())
        {
            int       iCodOperador; 
            string    szDesOperador;

            qry >> iCodOperador >> szDesOperador;
            memset(&memoria[0].st_CodOper[i].iCodOperador, 0 ,sizeof(memoria[0].st_CodOper[i].iCodOperador));
            memset(&memoria[0].st_CodOper[i].szDesOperador, 0 ,sizeof(memoria[0].st_CodOper[i].szDesOperador));
            
            memoria[0].st_CodOper[i].iCodOperador = iCodOperador;
            strncpy(memoria[0].st_CodOper[i].szDesOperador, szDesOperador.c_str(),strlen(szDesOperador.c_str()));
            
            i++;
        }
        memoria[0].lCantOper=i;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_cat_imptos()
{
    try
    {
        int i;
        
        otl_nocommit_stream qry(1024,"SELECT  distinct "
                                     "   A.COD_CONCGENE," 
                                     "   B.COD_CATEIMP,"
                                     "   A.PRC_IMPUESTO,"
                                     "   A.COD_TIPIMPUES "
                                     "FROM GE_IMPUESTOS A, GE_TIPIMPUES B "
                                     "WHERE A.COD_TIPIMPUES = B.COD_TIPIMPUE "
                                     "ORDER BY A.COD_CONCGENE ASC",db); 
        i=0;
        while (!qry.eof())
        {
            int    icod_conc;
            int    icod_cat;
            double dprc_imp;
            int    iCodTipImpto;
            
            icod_conc    = 0;   
            icod_cat     = 0;    
            dprc_imp     = 0;    
            iCodTipImpto = 0;

            qry >> icod_conc >> icod_cat >> dprc_imp >> iCodTipImpto;
            
            memset(&memoria[0].stCocImptos[i].iCodConcepto ,   0 ,sizeof(memoria[0].stCocImptos[i].iCodConcepto));
            memset(&memoria[0].stCocImptos[i].iCodCategoria,   0 ,sizeof(memoria[0].stCocImptos[i].iCodCategoria));
            memset(&memoria[0].stCocImptos[i].dPrcImpuesto ,   0 ,sizeof(memoria[0].stCocImptos[i].dPrcImpuesto));
            memset(&memoria[0].stCocImptos[i].iCodTipImpto ,   0 ,sizeof(memoria[0].stCocImptos[i].iCodTipImpto));
            memset(&memoria[0].stCocImptos[i].szFlagImpto  ,'\0' ,sizeof(memoria[0].stCocImptos[i].szFlagImpto));

            memoria[0].stCocImptos[i].iCodConcepto  = icod_conc;
            memoria[0].stCocImptos[i].iCodCategoria = icod_cat;
            memoria[0].stCocImptos[i].dPrcImpuesto  = dprc_imp;
            memoria[0].stCocImptos[i].iCodTipImpto  = iCodTipImpto;
            strcpy(memoria[0].stCocImptos[i].szFlagImpto," ");

            i++;
        }
        memoria[0].lCantCocImpos=i;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_tip_trafico_ld()
{
    string szCodTipoTraficoLD;
    string szNomTipoTraficoLD;
    string szDesTipoTraficoLD;
    int i;

    try
    {
        otl_nocommit_stream qry(1024,"SELECT NOM_PARAMETRO, VAL_PARAMETRO, DES_PARAMETRO "
                                     "FROM GED_PARAMETROS "
                                     "WHERE NOM_PARAMETRO IN ('LLAMADA_LD_04','LLAMADA_LD_03')",db); 
        i=0;
        while (!qry.eof())
        {
            qry >> szCodTipoTraficoLD >> szNomTipoTraficoLD >> szDesTipoTraficoLD;
            
            memset(&memoria[0].stTipoTrafico[i].szCodTipoTraficoLD, 0 ,sizeof(memoria[0].stTipoTrafico[i].szCodTipoTraficoLD));
            memset(&memoria[0].stTipoTrafico[i].szNomTipoTraficoLD, 0 ,sizeof(memoria[0].stTipoTrafico[i].szNomTipoTraficoLD));
            memset(&memoria[0].stTipoTrafico[i].szDesTipoTraficoLD, 0 ,sizeof(memoria[0].stTipoTrafico[i].szDesTipoTraficoLD));

            strncpy(memoria[0].stTipoTrafico[i].szCodTipoTraficoLD, szCodTipoTraficoLD.c_str(),strlen(szCodTipoTraficoLD.c_str()));
            strncpy(memoria[0].stTipoTrafico[i].szNomTipoTraficoLD, szNomTipoTraficoLD.c_str(),strlen(szNomTipoTraficoLD.c_str()));
            strncpy(memoria[0].stTipoTrafico[i].szDesTipoTraficoLD, szDesTipoTraficoLD.c_str(),strlen(szDesTipoTraficoLD.c_str()));

            i++;
        }
        memoria[0].iCantTipoTrafico = i;
        cout << NivelLog(5) << "Salida carga_tip_trafico_ld OK!." << endl;
        return 0;
    }
    catch(otl_exception& error){
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info << endl;
        return 1;
    }
}

int Carga_Dat_Dominio()
{
    char szCod_Plan[6];
    char szCod_Thor[6];
    long lSeg_Inic;
    long lSeg_Adic;
    double dMto_Inic;
    double dMto_Adic;
    string szT_Cod_Llam;
    string szT_Cod_TDir;
    string szT_Cod_THor;
    string szT_Con_Cliente;
    string szT_Cod_Operador;
    string szT_Cod_TDia;
    string szT_Cod_SFran;
    char aux[10];
    int i;

    memoria[0].iNumReg_DatDomin = 0;
    try
    {
        aux[0]='\0';
        strncpy(aux,memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_Llam,6);
        szT_Cod_Llam = aux;
        aux[0]='\0';
        strncpy(aux,memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_TDir,6);
        szT_Cod_TDir = aux;
        aux[0]='\0';
        strncpy(aux,memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_THor,6);
        szT_Cod_THor = aux;
        aux[0]='\0';
        strncpy(aux,memoria[0].Parametros_Env.St_Par_Env.szTol_Con_Cliente,3);
        szT_Con_Cliente = aux;
        aux[0]='\0';
        strncpy(aux,memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_Operador,6);
        szT_Cod_Operador = aux;
        aux[0]='\0';
        strncpy(aux,memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_TDia,6);
        szT_Cod_TDia = aux;
        aux[0]='\0';
        strncpy(aux,memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_SFran,6);
        szT_Cod_SFran = aux;

        string consulta="SELECT B.COD_PLAN, B.SEG_INIC, B.SEG_ADIC, B.MTO_INIC, B.MTO_ADIC, A.COD_THOR "
                        "FROM TOL_AGRULLAM A, TOL_ESTCOBRO B"
                        " WHERE A.COD_SENTIDO = 'S'"
                          " AND A.COD_LLAM = '" + szT_Cod_Llam + "' "
                          " AND A.COD_TDIR = '" + szT_Cod_TDir + "' "
                          " AND A.COD_THOR = '" + szT_Cod_THor + "' "
                          " AND A.CON_CLIENTE = '" + szT_Con_Cliente + "' "
                          " AND A.FEC_INI_VIG <= SYSDATE"
                          " AND A.FEC_TER_VIG >= SYSDATE"
                          " AND B.COD_OPERADOR = '" + szT_Cod_Operador + "' "
                          " AND B.COD_PLAN <> ' '"
                          " AND B.COD_AGRULLAM = A.COD_AGRULLAM"
                          " AND B.COD_TDIA = '" + szT_Cod_TDia + "' "
                          " AND B.COD_SFRAN = '" + szT_Cod_SFran + "' "
                          " AND B.FEC_INI_VIG <= SYSDATE"
                          " AND B.FEC_TER_VIG >= SYSDATE";
        
        cout << NivelLog(3) << "--------------- Consulta de Dominios ---------------" << endl;
        cout << NivelLog(6) << consulta << endl;
        
        otl_nocommit_stream qry(1024,consulta.c_str(),db);                                   
                                     
        i=0;
        memset(memoria[0].stDat_Domin, 0 , sizeof(memoria[0].stDat_Domin));
        while (!qry.eof())
        {
          qry >> szCod_Plan >> lSeg_Inic >> lSeg_Adic >> dMto_Inic >> dMto_Adic >> szCod_Thor;
          strcpy(memoria[0].stDat_Domin[i].szCod_Plan,szCod_Plan);
          memoria[0].stDat_Domin[i].lSeg_Inic = lSeg_Inic;
          memoria[0].stDat_Domin[i].lSeg_Adic = lSeg_Adic;
          memoria[0].stDat_Domin[i].dMto_Inic = dMto_Inic;
          memoria[0].stDat_Domin[i].dMto_Adic = dMto_Adic;
          i++;
        }
        memoria[0].iNumReg_DatDomin=i;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int Consulta_GedParametros(char campo[50],char valor[50],char *salida, char modulo[10])
{
    char szQry[1024];

    try
    {
        sprintf(szQry,"SELECT VAL_PARAMETRO FROM GED_PARAMETROS WHERE %s = '%s' AND COD_MODULO ='%s'", campo,valor,modulo);
        otl_nocommit_stream qry(1024,szQry,db);
        cout << NivelLog(5) << "Consulta_GedParametros: Start consulta GED_PARAMETROS" << endl;
        if (qry.eof())
        {
            cout << NivelLog(5) << "Consulta_GedParametros: No se pudo cargar parametros desde GED_PARAMETROS" << endl;
            return -1;
        }
        else
        {
            cout << NivelLog(5) << "Valor rescatado: " << endl;
            qry >> salida;
        }
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int Carga_GedParam_Env()
{
    char szT_Cod_Llam[21];     
    char szT_Cod_TDir[21];     
    char szT_Cod_THor[21];     
    char szT_Cod_THor_Alta[21];
    char szT_Cod_THor_Baja[21];
    char szT_Con_Cliente[21];  
    char szT_Cod_Operador[21]; 
    char szT_Cod_TDia[21];     
    char szT_Cod_SFran[21];    
    int i;
    int retorno;
    try
    {
        retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_LLAM",szT_Cod_Llam,"FA");
        if (retorno == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_LLAM desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_TDIR",szT_Cod_TDir,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_TDIR desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_THOR",szT_Cod_THor,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_THOR desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_THOR_ALTA",szT_Cod_THor_Alta,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_THOR_ALTA desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_THOR_BAJA",szT_Cod_THor_Baja,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_THOR_BAJA desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_CON_CLIENTE",szT_Con_Cliente,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_CON_CLIENTE desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_OPERADOR",szT_Cod_Operador,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_OPERADOR desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_TDIA",szT_Cod_TDia,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_TDIA desde GED_PARAMETROS " << endl;
            return -1;
        }
        if (retorno= Consulta_GedParametros("NOM_PARAMETRO","TOL_COD_SFRAN",szT_Cod_SFran,"FA") == -1)
        {
            cout << NivelLog(5) << "No se pudo cargar TOL_COD_SFRAN desde GED_PARAMETROS " << endl;
            return -1;
        }
        
        memset(&memoria[0].Parametros_Env.St_Par_Env, 0 ,sizeof(memoria[0].Parametros_Env.St_Par_Env));
        
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_Llam,szT_Cod_Llam);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_TDir,szT_Cod_TDir);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_THor,szT_Cod_THor);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_THor_Alta,szT_Cod_THor_Alta);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_THor_Baja,szT_Cod_THor_Baja);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Con_Cliente,szT_Con_Cliente);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_Operador,szT_Cod_Operador);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_TDia,szT_Cod_TDia);
        strcpy(memoria[0].Parametros_Env.St_Par_Env.szTol_Cod_SFran,szT_Cod_SFran);
        
        cout << NivelLog(5) << "Salida Carga_GedParam_Env OK!." << endl;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_planes_tarifarios()
{
    try
    {
        otl_nocommit_stream qry(1024,"SELECT  COD_PLANTARIF, "
                                     "        DES_PLANTARIF, "
                                     "        NUM_UNIDADES, "
                                     "        IMP_CARGOBASICO, "
                                     "        IND_ARRASTRE, "
                                     "        COD_PRESTACION "        //P-MIX-09003
                                     "  FROM  TA_PLANTARIF A, "
                                     "        TA_CARGOSBASICO B "
                                     "  WHERE A.COD_PRODUCTO = 1 "
                                     "    AND A.COD_CARGOBASICO = B.COD_CARGOBASICO "
                                     "    AND A.COD_PRODUCTO = B.COD_PRODUCTO"
                                     "    AND (B.FEC_HASTA IS NULL OR B.FEC_HASTA > TRUNC(SYSDATE))",db); 
        PLAN_TARIFARIO_M val;
        int i = 0;
        int j = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLA PLAN_TARIFARIO " << endl;
        while (!qry.eof())
        {
            string szCod_Plantarif;
            string szDes_Plantarif;
            long lMinutosPlan;
            double dValorPlan;
            int iInd_Arrastre;
            string szCod_Prestacion;            
         
            qry >> szCod_Plantarif >> szDes_Plantarif >> lMinutosPlan >> dValorPlan >> iInd_Arrastre >> szCod_Prestacion; 
         
            memset(memoria[j].plan_tarifario[i].szCod_Plantarif,'\0',sizeof(memoria[j].plan_tarifario[i].szCod_Plantarif));
            memset(memoria[j].plan_tarifario[i].szDes_Plantarif,'\0',sizeof(memoria[j].plan_tarifario[i].szDes_Plantarif));
            memset(memoria[j].plan_tarifario[i].szCod_Prestacion,'\0',sizeof(memoria[j].plan_tarifario[i].szCod_Prestacion));            
            
            strncpy(memoria[j].plan_tarifario[i].szCod_Plantarif, szCod_Plantarif.c_str(),strlen(szCod_Plantarif.c_str()));
            strncpy(memoria[j].plan_tarifario[i].szDes_Plantarif, szDes_Plantarif.c_str(),strlen(szDes_Plantarif.c_str()));
            memoria[j].plan_tarifario[i].lMinutosPlan           = lMinutosPlan ;
            memoria[j].plan_tarifario[i].dValorPlan             = dValorPlan ;
            memoria[j].plan_tarifario[i].iInd_Arrastre          = iInd_Arrastre ;
            strncpy(memoria[j].plan_tarifario[i].szCod_Prestacion, szCod_Prestacion.c_str(),strlen(szCod_Prestacion.c_str()));            
           
            i++;
        }
        memoria[j].plan_tarifario_reg = i ;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_oficinas()
{
    try
    {
        otl_nocommit_stream qry(1024,"SELECT DISTINCT COD_OFICINA, "
                                     "                DES_OFICINA  " 
                                     "           FROM GE_OFICINAS  ",db); 
        OFICINA_HOSTS2_M val;
        int i = 0;
        int j = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLA OFICINA_HOSTS2 " << endl;
        while (!qry.eof())
        {
           string szCodOficina;
           string szDesOficina;

           qry >> szCodOficina >> szDesOficina ;  

           memset(memoria[j].oficina_hosts2[i].szCodOficina,'\0',sizeof(memoria[j].oficina_hosts2[i].szCodOficina));
           memset(memoria[j].oficina_hosts2[i].szDesOficina,'\0',sizeof(memoria[j].oficina_hosts2[i].szDesOficina));

           memset(val.szCodOficina,'\0',sizeof(val.szCodOficina));
           memset(val.szDesOficina,'\0',sizeof(val.szDesOficina));

           strncpy(val.szCodOficina,szCodOficina.c_str(),strlen(szCodOficina.c_str()));
           strncpy(val.szDesOficina,szDesOficina.c_str(),strlen(szDesOficina.c_str()));

           memoria[j].oficina_hosts2[i] = val;
           i++;
        }
        memoria[j].oficina_hosts2_reg = i;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_vendedores(const string& ciclo_facturacion)
{
    try
    {

        string qry ="SELECT DISTINCT A.COD_VENDEDOR, "
                    "                A.NOM_VENDEDOR  "
                    "FROM VE_VENDEDORES A, "
                    "    (SELECT DISTINCT COD_VENDEDOR FROM FA_FACTDOCU_" + ciclo_facturacion + ") B "
                    "WHERE A.COD_VENDEDOR = B.COD_VENDEDOR "
                    "ORDER BY A.COD_VENDEDOR";

        otl_nocommit_stream parm(1024, qry.c_str(),db);      
    
        VENDEDOR_HOSTS_M val;
        int i = 0;
        int j = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLA VENDEDOR_HOSTS " << endl;
        while (!parm.eof())
        {
            long   lCodVendedor;
            string szNomVendedor;

            parm >> lCodVendedor >> szNomVendedor ;

            memset(memoria[j].vendedor_hosts[i].szNomVendedor,'\0',sizeof(memoria[j].vendedor_hosts[i].szNomVendedor));

            memset(val.szNomVendedor,'\0',sizeof(val.szNomVendedor));

            strncpy(val.szNomVendedor,szNomVendedor.c_str(),strlen(szNomVendedor.c_str()));
            val.lCodVendedor = lCodVendedor;

            memoria[j].vendedor_hosts[i] = val;
            i++;
        }
        memoria[j].vendedor_hosts_reg = i ;
        cout << NivelLog(3) << "VENDEDOR : " << memoria[j].vendedor_hosts_reg << endl;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_tipdoc()
{
    try
    {
        otl_nocommit_stream qry(1024,"SELECT DISTINCT COD_TIPDOCUM, "
                                     "                DES_TIPDOCUM  " 
                                     "FROM   GE_TIPDOCUMEN          ",db); 
        TIPDOC_M val;
        int i = 0;
        int j = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLA TIPDOC " << endl;
        while (!qry.eof())
        {
           int    lCodTipDocum;
           string szDesTipDocum;

           qry >> lCodTipDocum >> szDesTipDocum ; 

           memset(memoria[j].tipdoc[i].szDesTipDocum,'\0',sizeof(memoria[j].tipdoc[i].szDesTipDocum));
           memset(val.szDesTipDocum,'\0',sizeof(val.szDesTipDocum));
           strncpy(val.szDesTipDocum,szDesTipDocum.c_str(),strlen(szDesTipDocum.c_str()));
           val.lCodTipDocum = lCodTipDocum;
           memoria[j].tipdoc[i] = val;
           i++;
        }
        memoria[j].tipdoc_reg = i ;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_st_ciclofact(const string& ciclo_facturacion)
{
    try
    {
        otl_nocommit_stream qry(1024,"SELECT  COD_CICLO, "
                                     "        TO_CHAR(FEC_DESDELLAM,'YYYYMMDD'), "
                                     "        TO_CHAR(FEC_HASTALLAM,'YYYYMMDD'), "
                                     "        TO_CHAR(FEC_EMISION,'YYYYMMDD'),   "
                                     "        TO_CHAR(ADD_MONTHS(FEC_EMISION,-1),'YYYYMM'), "
                                     "        TO_CHAR(ADD_MONTHS(FEC_EMISION,-2),'YYYYMM'), "
                                     "        TO_CHAR(ADD_MONTHS(FEC_EMISION,-3),'YYYYMM'), "
                                     "        TO_CHAR(ADD_MONTHS(FEC_EMISION,-4),'YYYYMM'), "
                                     "        TO_CHAR(ADD_MONTHS(FEC_EMISION,-5),'YYYYMM'), "
                                     "        TO_CHAR(ADD_MONTHS(FEC_EMISION,-6),'YYYYMM'), "
                                     "        IND_TASADOR, "
                                     "        TO_CHAR(FEC_DESDECFIJOS,'YYYYMMDD'), "
                                     "        TO_CHAR(FEC_HASTACFIJOS,'YYYYMMDD') "
                                     "FROM    FA_CICLFACT "
                                     "WHERE   COD_CICLFACT = :ciclo<char[7]> ",db); 
        ST_CICLOFACT_M val;
        int i = 0;
        int j = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLA ST_CICLOFACT " << endl;
        qry << ciclo_facturacion;
     
        while (!qry.eof())
        {
            int  cod_ciclo;
            string fec_desde;
            string fec_hasta;
            string szFecEmision;
            string szMesCiclo_0;
            string szMesCiclo_1;
            string szMesCiclo_2;
            string szMesCiclo_3;
            string szMesCiclo_4;
            string szMesCiclo_5;
            int iIndTasador;
            string szFec_Desde;
            string szFec_Hasta;            
         
            qry >> cod_ciclo >> fec_desde >> fec_hasta >> szFecEmision >> szMesCiclo_0 >> szMesCiclo_1 
                >> szMesCiclo_2 >> szMesCiclo_3 >> szMesCiclo_4 >> szMesCiclo_5 >> iIndTasador
                >> szFec_Desde >> szFec_Hasta; 
         
            memset(memoria[j].st_ciclofact.fec_desde,'\0',   sizeof(memoria[j].st_ciclofact.fec_desde));
            memset(memoria[j].st_ciclofact.fec_hasta,'\0',   sizeof(memoria[j].st_ciclofact.fec_hasta));
            memset(memoria[j].st_ciclofact.szFecEmision,'\0',sizeof(memoria[j].st_ciclofact.szFecEmision));
            memset(memoria[j].st_ciclofact.szMesCiclo_0,'\0',sizeof(memoria[j].st_ciclofact.szMesCiclo_0));
            memset(memoria[j].st_ciclofact.szMesCiclo_1,'\0',sizeof(memoria[j].st_ciclofact.szMesCiclo_1));
            memset(memoria[j].st_ciclofact.szMesCiclo_2,'\0',sizeof(memoria[j].st_ciclofact.szMesCiclo_2));
            memset(memoria[j].st_ciclofact.szMesCiclo_3,'\0',sizeof(memoria[j].st_ciclofact.szMesCiclo_3));
            memset(memoria[j].st_ciclofact.szMesCiclo_3,'\0',sizeof(memoria[j].st_ciclofact.szMesCiclo_3));
            memset(memoria[j].st_ciclofact.szMesCiclo_4,'\0',sizeof(memoria[j].st_ciclofact.szMesCiclo_4));
            memset(memoria[j].st_ciclofact.szMesCiclo_5,'\0',sizeof(memoria[j].st_ciclofact.szMesCiclo_5));
            memset(memoria[j].st_ciclofact.szFec_Desde,'\0',sizeof(memoria[j].st_ciclofact.szFec_Desde));
            memset(memoria[j].st_ciclofact.szFec_Hasta,'\0',sizeof(memoria[j].st_ciclofact.szFec_Hasta));            
         
            memset(val.fec_desde,'\0',   sizeof(val.fec_desde));
            memset(val.fec_hasta,'\0',   sizeof(val.fec_hasta));
            memset(val.szFecEmision,'\0',sizeof(val.szFecEmision));
            memset(val.szMesCiclo_0,'\0',sizeof(val.szMesCiclo_0));
            memset(val.szMesCiclo_1,'\0',sizeof(val.szMesCiclo_1));
            memset(val.szMesCiclo_2,'\0',sizeof(val.szMesCiclo_2));
            memset(val.szMesCiclo_3,'\0',sizeof(val.szMesCiclo_3));
            memset(val.szMesCiclo_4,'\0',sizeof(val.szMesCiclo_4));
            memset(val.szMesCiclo_5,'\0',sizeof(val.szMesCiclo_5));
            memset(val.szMesCiclo_5,'\0',sizeof(val.szFec_Desde));
            memset(val.szMesCiclo_5,'\0',sizeof(val.szFec_Hasta));

            val.cod_ciclo = cod_ciclo;
            strncpy(val.fec_desde,fec_desde.c_str(),strlen(fec_desde.c_str()));
            strncpy(val.fec_hasta,fec_hasta.c_str(),strlen(fec_hasta.c_str()));
            strncpy(val.szFecEmision,szFecEmision.c_str(),strlen(szFecEmision.c_str()));
            strncpy(val.szMesCiclo_0,szMesCiclo_0.c_str(),strlen(szMesCiclo_0.c_str()));
            strncpy(val.szMesCiclo_1,szMesCiclo_1.c_str(),strlen(szMesCiclo_1.c_str()));
            strncpy(val.szMesCiclo_2,szMesCiclo_2.c_str(),strlen(szMesCiclo_2.c_str()));
            strncpy(val.szMesCiclo_3,szMesCiclo_3.c_str(),strlen(szMesCiclo_3.c_str()));
            strncpy(val.szMesCiclo_4,szMesCiclo_4.c_str(),strlen(szMesCiclo_4.c_str()));
            strncpy(val.szMesCiclo_5,szMesCiclo_5.c_str(),strlen(szMesCiclo_5.c_str()));
            val.iIndTasador = iIndTasador;
            strncpy(val.szFec_Desde,szFec_Desde.c_str(),strlen(szFec_Desde.c_str()));
            strncpy(val.szFec_Hasta,szFec_Hasta.c_str(),strlen(szFec_Hasta.c_str()));
         
            memoria[j].st_ciclofact = val;
            i++;
        }
        memoria[j].st_ciclo_fact_reg = i ;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int carga_operadora_hosts()
{
    try
    {
       otl_nocommit_stream qry(1024,"SELECT  LTRIM(RTRIM(A.COD_OPERADORA_SCL)), "
                                    "                    A.COD_CLIENTE,         "
                                    "                    B.NOM_CLIENTE,         "
                                    "                    B.NUM_IDENTTRIB,       "
                                    "                    GE_FN_OBTIENE_DIRCLIE(COD_OPERADORA_SCL,12,0,3) "
                                    "  FROM  GE_OPERADORA_SCL A,GE_CLIENTES B "
                                    " WHERE  A.COD_CLIENTE=B.COD_CLIENTE "
                                    "   AND  A.COD_CLIENTE IS NOT NULL ",db); 
       OPERADORA_HOSTS_M val;
       int i = 0;
       int j = 0;
       cout << NivelLog(3) << "Comenzando a Leer TABLA OPERADORA HOSTS " << endl;
    
    
       while (!qry.eof())
       {
    
          string szCodOperadora;
          long lCodClienteOperadora;
          string szNomOperadora;
          string szNumIdenTRib;
          string szDireccion;
       
          qry >> szCodOperadora >> lCodClienteOperadora >> szNomOperadora >> szNumIdenTRib >> szDireccion; 
    
          memset(memoria[j].operadora_hosts[i].szCodOperadora,'\0',   sizeof(memoria[j].operadora_hosts[i].szCodOperadora));
          memset(memoria[j].operadora_hosts[i].szNomOperadora,'\0',   sizeof(memoria[j].operadora_hosts[i].szNomOperadora));
          memset(memoria[j].operadora_hosts[i].szNumIdenTRib,'\0',sizeof(memoria[j].operadora_hosts[i].szNumIdenTRib));
          memset(memoria[j].operadora_hosts[i].szDireccion,'\0',sizeof(memoria[j].operadora_hosts[i].szDireccion));
    
          memset(val.szCodOperadora,'\0',   sizeof(val.szCodOperadora));
          memset(val.szNomOperadora,'\0',   sizeof(val.szNomOperadora));
          memset(val.szNumIdenTRib,'\0',sizeof(val.szNumIdenTRib));
          memset(val.szDireccion,'\0',sizeof(val.szDireccion));
    
          val.lCodClienteOperadora = lCodClienteOperadora;
          strncpy(val.szCodOperadora,szCodOperadora.c_str(),strlen(szCodOperadora.c_str()));
          strncpy(val.szNomOperadora,szNomOperadora.c_str(),strlen(szNomOperadora.c_str()));
          strncpy(val.szNumIdenTRib,szNumIdenTRib.c_str(),strlen(szNumIdenTRib.c_str()));
          strncpy(val.szDireccion,szDireccion.c_str(),strlen(szDireccion.c_str()));
    
          memoria[j].operadora_hosts[i] = val;
          i++;
       }
       memoria[j].operadora_hosts_reg = i ;
       return 0;
    }catch(otl_exception& error){
    
            cerr << error.msg << endl;
            cerr << error.stm_text << endl;
            cerr << error.var_info<< endl;
       return 1;
    }
}

int carga_conceptos_tar()
{
    try
    {
        int iNumConceptos;
        otl_nocommit_stream qry1(1024,"SELECT   COUNT(1) FROM         "
                                      "(SELECT  COD_FACTURACION,      "
                                      "         IND_TABLA             "
                                      "  FROM   TA_CONCEPFACT UNION   "
                                      "SELECT   COD_CONCFACT,4        "
                                      "  FROM   FA_FACTCARRIERS     ) ",db); 
        qry1 >> iNumConceptos;
        
        otl_nocommit_stream qry2(1024,"SELECT  COD_FACTURACION,    "
                                      "        IND_TABLA           "
                                      "  FROM  TA_CONCEPFACT UNION "
                                      "SELECT  COD_CONCFACT,4      "
                                      "  FROM  FA_FACTCARRIERS     ",db); 
        CONCEPTOS_TAR_M val;
        int i = 0;
        int j = 0;
        int k = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLA CONCEPTOS_TAR " << endl;
        
        
        while (!qry2.eof())
        {
            int iCodConcepto;
            int iIndTabla;
            qry2 >> iCodConcepto >> iIndTabla; 
         
            val.iCodConcepto  = iCodConcepto;
            val.iIndTabla     = iIndTabla;
            val.iNumConceptos = iNumConceptos;
            memoria[j].conceptos_tar[i] = val;
            i++;
        }
        memoria[j].conceptos_tar_reg = i ;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}


int cuenta_codcli_hosts(const string& ciclo_facturacion)
{
    try
    {
        long contador = 0 ;


        string qry ="SELECT COUNT (A.COD_CLIENTE) "
                    "  FROM FA_FACTDOCU_" + ciclo_facturacion + " A, "
                    "       GE_CLIENTES B, "
                    "       (SELECT DISTINCT COD_CLIENTE,COD_COURRIER,COD_ZONACOURRIER " /* P-MIX-09003 140079 */
                    "        FROM   FA_CICLOCLI) C "                                     /* P-MIX-09003 140079 */
                    " WHERE A.TOT_FACTURA   >= 0 "
                    "   AND A.COD_CLIENTE   >= 0 "
                    "   AND A.NUM_FOLIO     >= 0 "
                    "   AND A.IND_IMPRESA    = 0 "                                       /* P-MIX-09003 140079 */
                    "   AND B.COD_CLIENTE = A.COD_CLIENTE "
                    "   AND C.COD_CLIENTE = A.COD_CLIENTE ";                             /* P-MIX-09003 140079 */

        otl_nocommit_stream parm(16384, qry.c_str(),db);
      
        cout << NivelLog(3) << "CONTANDO REGISTROS TABLA CODCLI_HOSTS_M " << endl;
        
        parm >> contador;
        return contador;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}


int carga_codcli_hosts(const string& ciclo_facturacion)
{
    try
    {
        string qry ="SELECT DISTINCT A.COD_CLIENTE, "
                    "       NVL(B.NOM_APODERADO ,'.'), "
                    "       NVL(D.COD_SERVICIO  ,'1'), "
                    "       NVL(B.COD_SISPAGO, 1), "
                    "       NVL(B.NUM_IDENT2,' '), "           /* P-MIX-09003 */
                    "       NVL(E.COD_COURRIER,' '), "         /* P-MIX-09003 */
                    "       NVL(E.COD_ZONACOURRIER,' ') "     /* P-MIX-09003 */               
                    "  FROM FA_FACTDOCU_" + ciclo_facturacion + " A, "
                    "       GE_CLIENTES B, "
                    "       FAD_IMPSERVCLIE D, "
                    "       FA_CICLOCLI E "
                    " WHERE A.TOT_FACTURA   >= 0 "
                    "   AND A.COD_CLIENTE   >= 0 "
                    "   AND A.NUM_FOLIO     >= 0 "
                    "   AND A.IND_IMPRESA    = 0 "            /* P-MIX-09003 140079 */
                    "   AND B.COD_CLIENTE = A.COD_CLIENTE "
                    "   AND A.COD_CLIENTE = D.COD_CLIENTE(+) "
                    "   AND A.FEC_EMISION BETWEEN D.FECHA_DESDE(+) AND D.FECHA_HASTA(+) "
                    "   AND B.COD_CLIENTE = E.COD_CLIENTE(+) "; /* P-MIX-09003 */             
                    
        otl_nocommit_stream parm(16384, qry.c_str(),db);

        CODCLI_HOSTS_M val;
        int i = 0;
        int j = 0;
        cout << NivelLog(3) << "Comenzando a Leer TABLA CODCLI_HOSTS_M " << endl;
        
        while (!parm.eof())
        {
            long   lCodCliente;
            string szNomApoderado;
            string szCodServicio;
            string szNumIdent2;            
            string szCodCourrier;
            string szCodZonaCourrier;            
            int    iCodSisPago;

            parm >> lCodCliente >> szNomApoderado >> szCodServicio >> iCodSisPago >> szNumIdent2 >> szCodCourrier >> szCodZonaCourrier; 
         
            memset(codcli_hosts[i].szNomApoderado,'\0',   sizeof(codcli_hosts[i].szNomApoderado));
            memset(codcli_hosts[i].szCodServicio, '\0',   sizeof(codcli_hosts[i].szCodServicio));
         
            memset(val.szNomApoderado,'\0',   sizeof(val.szNomApoderado));
            memset(val.szCodServicio, '\0',   sizeof(val.szCodServicio));

            memset(codcli_hosts[i].szNumIdent2,'\0',   sizeof(codcli_hosts[i].szNumIdent2));
            
            memset(val.szNumIdent2,'\0',   sizeof(val.szNumIdent2));            
            
            memset(codcli_hosts[i].szCodCourrier,'\0',   sizeof(codcli_hosts[i].szCodCourrier));
            memset(codcli_hosts[i].szCodZonaCourrier, '\0',   sizeof(codcli_hosts[i].szCodZonaCourrier));            
         
            memset(val.szCodCourrier,'\0',   sizeof(val.szCodCourrier));
            memset(val.szCodZonaCourrier,'\0',   sizeof(val.szCodZonaCourrier));            
         
            val.lCodCliente = lCodCliente;
            strncpy(val.szNomApoderado,szNomApoderado.c_str(),strlen(szNomApoderado.c_str()));
            strncpy(val.szCodServicio,szCodServicio.c_str(),strlen(szCodServicio.c_str()));
            strncpy(val.szNumIdent2,szNumIdent2.c_str(),strlen(szNumIdent2.c_str()));            
            strncpy(val.szCodCourrier,szCodCourrier.c_str(),strlen(szCodCourrier.c_str()));
            strncpy(val.szCodZonaCourrier,szCodZonaCourrier.c_str(),strlen(szCodZonaCourrier.c_str()));            
            val.iCodSisPago = iCodSisPago;
         
            codcli_hosts[i] = val;
            i++;
        }
        cout << NivelLog(3) << "CANTIDAD DE REGISTROS CODCLI_HOSTS_M : " << i << endl;
        memoria[j].codcli_hosts_reg = i ;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

string get_st_parametros(int cod_parametro,const string& tipo)
{
   int i = 0;
   int j = 0;
   string paso;
   string retorno;
   for (i=0 ; i < memoria[0].st_parametros_reg ; i++ )
   {
      if (memoria[j].st_parametros[i].cod_parametros == cod_parametro)
      {
         if (tipo=="SN")
         {
           paso = memoria[j].st_parametros[i].val_caracter;
           retorno = paso.substr(0,memoria[j].st_parametros[i].val_numerico);
           return retorno;
         }
         else if(tipo=="S")
         {
           retorno = memoria[j].st_parametros[i].val_caracter;
           return retorno;
         }
         else if(tipo=="N")
         {
           ostringstream aux;
           aux << memoria[j].st_parametros[i].val_numerico ;
           paso = aux.str();
           return paso;
         }
      }
   }
   return "";
}

int get_frecuencia()
{
   int i = 0;
   int j = 0;
   for (i=0 ; i < memoria[0].st_parametros_reg ; i++ )
   {
      if (strcmp(memoria[j].st_parametros[i].des_parametro,"IMP_NRO_CLIENTES_A_CARGAR_EN_MC")==0)
      {
         return memoria[j].st_parametros[i].val_numerico;
      }
   }
   return 0;
}

int get_nro_minimo()
{
   int i = 0;
   int j = 0;
   for (i=0 ; i < memoria[0].st_parametros_reg ; i++ )
   {
      if (strcmp(memoria[j].st_parametros[i].des_parametro,"IMP_NRO_MINIMO_CLIENTES_EN_MC")==0)
      {
         return memoria[j].st_parametros[i].val_numerico;
      }
   }
   return 0;
}

int carga_detalleoper()
{
    cout << NivelLog(3) << "Comenzando a Leer TABLA DETALLEOPER " << endl;
    string szWhere_Local;
    string szWhere_Interzona;
    string szWhere_LDI;
    string szWhere_Especiales;
    string szWhere_Especiales_data;
    string szIndFacturado;
    string szServicio;
    string iCodFormulario_s;
    int iCodFormulario;
    string iCtesXArchivo_s;
    int iCtesXArchivo;
    string iIndLocal_s;
    int iIndLocal;
    string iIndEspeciales_s;
    int iIndEspeciales; 
    string iIndInterzona_s;
    int iIndInterzona;
    string iIndRoaming_s;
    int iIndRoaming;
    string iIndCarrier_s;
    int iIndCarrier;
    string iIndLDI_s;
    int iIndLDI;
    string iInd_Agrupacion_s;
    int iInd_Agrupacion;

    szWhere_Local           = get_st_parametros(COD_MASK_WHERE_LOCALES,"SN");
    szWhere_Interzona       = get_st_parametros(COD_MASK_WHERE_INTERZONA,"SN");
    szWhere_LDI             = get_st_parametros(COD_MASK_WHERE_LDI,"SN");
    szWhere_Especiales      = get_st_parametros(COD_MASK_WHERE_ESPECIALES,"SN");
    szWhere_Especiales_data = get_st_parametros(COD_MASK_WHERE_ESPECIALESDATA,"SN");
    szIndFacturado          = get_st_parametros(COD_MASK_INDFACTURADO,"S");
    szServicio              = get_st_parametros(COD_MASK_SERVICIO,"S");
    iCodFormulario_s        = get_st_parametros(COD_MASK_FORMULARIO,"N");
    iCodFormulario          = atoi(iCodFormulario_s.c_str());
    iCtesXArchivo_s         = get_st_parametros(COD_MASK_CLIENTESXFILE,"N");
    iCtesXArchivo           = atoi(iCtesXArchivo_s.c_str());
    iIndLocal_s             = get_st_parametros(COD_MASK_LOCAL,"N");
    iIndLocal               = atoi(iIndLocal_s.c_str());
    iIndEspeciales_s        = get_st_parametros(COD_MASK_ESPECIALES,"N");
    iIndEspeciales          = atoi(iIndEspeciales_s.c_str());
    iIndInterzona_s         = get_st_parametros(COD_MASK_INTERZONA,"N");
    iIndInterzona           = atoi(iIndInterzona_s.c_str());
    iIndRoaming_s           = get_st_parametros(COD_MASK_ROAMING,"N");
    iIndRoaming             = atoi(iIndRoaming_s.c_str());
    iIndCarrier_s           = get_st_parametros(COD_MASK_CARRIER,"N");
    iIndCarrier             = atoi(iIndCarrier_s.c_str());
    iIndLDI_s               = get_st_parametros(COD_MASK_LDI,"N");
    iIndLDI                 = atoi(iIndLDI_s.c_str());
    iInd_Agrupacion_s       = get_st_parametros(COD_MASK_INDAGRUPACION,"N");
    iInd_Agrupacion         = atoi(iInd_Agrupacion_s.c_str());

    memset(memoria[0].detalleoper.szWhere_Local    ,'\0',   sizeof(memoria[0].detalleoper.szWhere_Local));
    memset(memoria[0].detalleoper.szWhere_Interzona,'\0',   sizeof(memoria[0].detalleoper.szWhere_Interzona));
    memset(memoria[0].detalleoper.szWhere_LDI,'\0',         sizeof(memoria[0].detalleoper.szWhere_LDI));
    memset(memoria[0].detalleoper.szWhere_Especiales,'\0',  sizeof(memoria[0].detalleoper.szWhere_Especiales));
    memset(memoria[0].detalleoper.szWhere_Especiales_data,'\0',  sizeof(memoria[0].detalleoper.szWhere_Especiales_data));
    memset(memoria[0].detalleoper.szIndFacturado,'\0',  sizeof(memoria[0].detalleoper.szIndFacturado));
    memset(memoria[0].detalleoper.szServicio,'\0',  sizeof(memoria[0].detalleoper.szServicio));

    strncpy(memoria[0].detalleoper.szWhere_Local,szWhere_Local.c_str(),strlen(szWhere_Local.c_str()));
    strncpy(memoria[0].detalleoper.szWhere_Interzona,szWhere_Interzona.c_str(),strlen(szWhere_Interzona.c_str()));
    strncpy(memoria[0].detalleoper.szWhere_LDI,szWhere_LDI.c_str(),strlen(szWhere_LDI.c_str()));
    strncpy(memoria[0].detalleoper.szWhere_Especiales,szWhere_Especiales.c_str(),strlen(szWhere_Especiales.c_str()));
    strncpy(memoria[0].detalleoper.szWhere_Especiales_data,szWhere_Especiales_data.c_str(),strlen(szWhere_Especiales_data.c_str()));
    strncpy(memoria[0].detalleoper.szIndFacturado,szIndFacturado.c_str(),strlen(szIndFacturado.c_str()));
    strncpy(memoria[0].detalleoper.szServicio,szServicio.c_str(),strlen(szServicio.c_str()));
    memoria[0].detalleoper.iCodFormulario = iCodFormulario ;
    memoria[0].detalleoper.iCtesXArchivo  = iCtesXArchivo ;
    memoria[0].detalleoper.iIndLocal = iIndLocal;
    memoria[0].detalleoper.iIndEspeciales = iIndEspeciales ;
    memoria[0].detalleoper.iIndInterzona = iIndInterzona ;
    memoria[0].detalleoper.iIndRoaming = iIndRoaming ;
    memoria[0].detalleoper.iIndCarrier = iIndCarrier ;
    memoria[0].detalleoper.iIndLDI = iIndLDI ;
    memoria[0].detalleoper.iInd_Agrupacion = iInd_Agrupacion ;

    otl_nocommit_stream qry(1024,"SELECT REG.COD_REGISTRO,  "
                                 "       REG.IND_IMPRESION, " 
                                 "       TO_NUMBER(REG.COD_TIPDOCUM) "
                                 "  FROM FA_REGISIMPRESION_TD REG, "
                                 "       FA_TIPDOCUMEN DOC "
                                 " WHERE REG.COD_TIPDOCUM = DOC.COD_TIPDOCUMMOV "
                                 "   AND DOC.IND_IMPRESION = 1 "
                                 "  ORDER BY REG.COD_TIPDOCUM, REG.COD_REGISTRO "
                                 ,db); 

   int i = 0;
   int j = 0;
   cout <<  NivelLog(3) << "Comenzando a ESTRUCTURA INTERNA DETALLEOPER " << endl;

   while (!qry.eof())
   {
       string  szCodRegistro;
       int     iIndImp;
       int     iCod_tipdocum;

       qry >> szCodRegistro >> iIndImp >> iCod_tipdocum; 
       
       memset(memoria[j].detalleoper.szCodRegistro[i],  '\0',   sizeof(memoria[j].detalleoper.szCodRegistro[i]));

       strncpy(memoria[j].detalleoper.szCodRegistro[i],szCodRegistro.c_str(),strlen(szCodRegistro.c_str()));
       memoria[j].detalleoper.iCod_tipdocum[i] = iCod_tipdocum;
       memoria[j].detalleoper.iIndImp[i] = iIndImp;
       i++;
   }
   memoria[j].detalleoper.iCantRegistros = i ;
}

int carga_minutos_adicionales()
{
    try
    {
        otl_nocommit_stream qry(1024,"SELECT A.COD_PLAN,          "
                                     "       B.CON_CLIENTE||B.COD_THOR||B.COD_TDIR, "
                                     "       A.MTO_ADIC           "
                                     "FROM   TOL_ESTCOBRO A,      "
                                     "       TOL_AGRULLAM B       "
                                     "WHERE  A.COD_OPERADOR > ' ' "
                                     "  AND  A.COD_PLAN > ' '     "
                                     "  AND  A.COD_AGRULLAM = B.COD_AGRULLAM "
                                     "  AND  B.COD_LLAM = 'LOC' "
                                     "  AND  B.COD_SENTIDO= 'S' "
                                     "  AND  A.COD_TDIA = '1' "
                                     "  AND  B.CON_CLIENTE in ('HM','VI') " 
                                     "  AND  B.COD_THOR in ('O','N') "
                                     "  AND  B.COD_TDIR in ('PP','PPR') "
                                  "ORDER BY  A.COD_PLAN,B.CON_CLIENTE,B.COD_THOR,B.COD_TDIR",db); 
        ST_MINUTOADICIONAL_M val;
        int i = 0;
        int j = 0;
        cout <<  NivelLog(3) << "Comenzando a Leer TABLA ST_MINUTOADICIONAL " << endl;
     
        while (!qry.eof())
        {
            string szCodPlan;
            string szLlaveMinutoAdicional;
            double dMtoAdicional;
         
            qry >> szCodPlan >> szLlaveMinutoAdicional >> dMtoAdicional; 
         
            memset(memoria[j].st_minutoadicional[i].szCodPlan,'\0',   sizeof(memoria[j].st_minutoadicional[i].szCodPlan));
            memset(memoria[j].st_minutoadicional[i].szLlaveMinutoAdicional, '\0',   sizeof(memoria[j].st_minutoadicional[i].szLlaveMinutoAdicional));
         
            memset(val.szCodPlan,'\0',   sizeof(val.szCodPlan));
            memset(val.szLlaveMinutoAdicional, '\0',   sizeof(val.szLlaveMinutoAdicional));
         
            val.dMtoAdicional = dMtoAdicional;
            strncpy(val.szCodPlan,szCodPlan.c_str(),strlen(szCodPlan.c_str()));
            strncpy(val.szLlaveMinutoAdicional,szLlaveMinutoAdicional.c_str(),strlen(szLlaveMinutoAdicional.c_str()));
         
         
            memoria[j].st_minutoadicional[i] = val;
            i++;
        }
        memoria[j].st_minutoadicional_reg = i ;
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int cuenta_clientes_todos(const string& ciclo_facturacion)
{
	        cout << NivelLog(3) << "--------------- cuenta_clientes_todos ---------------" << endl;
	
    try
    {
        int i=0;
        ostringstream aux;

        int cantidad_registros;
        string qry = "SELECT COUNT(1) "
                     "FROM   FA_FACTDOCU_" + ciclo_facturacion + " A, "
                     "       FA_FACTCLIE_" + ciclo_facturacion + " B, "
                     "       FA_CODESPACHO C,  "
                     "       FA_PARGENARCH D,  "
                     "       GE_OPERPLAZA_TD E "
                     "WHERE  A.TOT_FACTURA   >= 0 "
                     "  AND  A.COD_CLIENTE   >= 0 "
                     "  AND  A.NUM_FOLIO     >= 0 "
                     "  AND  A.IND_SUPERTEL   = 0 "
                     "  AND  A.IND_ANULADA    = 0 "
                     "  AND  A.IND_FACTUR     = 1 "
                     "  AND  A.IND_IMPRESA    = 0 "  /* RPL 11-05-2020 SE AGREGA FILTRO IND_IMPRESA=0 */
                     "  AND  B.IND_ORDENTOTAL = A.IND_ORDENTOTAL "
                     "  AND  C.COD_DESPACHO   = NVL(A.COD_DESPACHO,'DESNO') "
                     "  AND  D.COD_GENARCH(+) = C.COD_GENARCH "
                     "  AND  A.COD_OPERADORA  = E.COD_OPERADORA_SCL "
                     "  AND  A.COD_PLAZA      = E.COD_PLAZA "
                     "  AND  ((A.COD_CLIENTE BETWEEN " + cliente_inicial + " AND " + cliente_final + ")"
                     "        OR (1 <> " + rango_clientes + "))";

        cout << NivelLog(3) << "--------------- Consulta Cantidad de Clientes ---------------" << endl;
        cout << NivelLog(6) << qry << endl;

        otl_nocommit_stream parm(16384, qry.c_str(),db);
        parm >> cantidad_registros;
        cout <<  NivelLog(3) << "CANTIDAD DE CLIENTES : " << cantidad_registros << endl;
        memoria[0].cantidad_clientes = cantidad_registros;
        return cantidad_registros;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}

int cuenta_clientes(const string& ciclo_facturacion,int tipdoc,const string& tip_despacho)
{
		        cout << NivelLog(3) << "--------------- cuenta_clientes ---------------" << endl;
    try
    {
        int i=0;
        ostringstream aux;
        aux << tipdoc;
        int cantidad_registros;
        string qry = "SELECT COUNT(1) "
                     "FROM   FA_FACTDOCU_" + ciclo_facturacion + " A, "
                     "       FA_FACTCLIE_" + ciclo_facturacion + " B, "
                     "       FA_CODESPACHO C,                         "
                     "       FA_PARGENARCH D,                         "
                     "       GE_OPERPLAZA_TD E                        "
                     "WHERE  A.TOT_FACTURA   >= 0 "
                     "  AND  A.COD_CLIENTE   >= 0 "
                     "  AND  A.NUM_FOLIO     >= 0 "
                     "  AND  A.IND_SUPERTEL   = 0 "
                     "  AND  A.IND_ANULADA    = 0 "
                     "  AND  A.IND_FACTUR     = 1 "
                     "  AND  A.COD_TIPDOCUM   = " +aux.str() + 
                     "  AND  A.COD_DESPACHO   = " + "'" + tip_despacho + "'" + 
                     "  AND  B.IND_ORDENTOTAL = A.IND_ORDENTOTAL "
                     "  AND  C.COD_DESPACHO   = NVL(A.COD_DESPACHO,'DESNO') "
                     "  AND  D.COD_GENARCH(+) = C.COD_GENARCH "
                     "  AND  A.COD_OPERADORA  = E.COD_OPERADORA_SCL "
                     "  AND  A.COD_PLAZA      = E.COD_PLAZA "
                     "  AND  ((A.COD_CLIENTE BETWEEN " + cliente_inicial + " AND " + cliente_final + ")" 
                     "        OR (1 <> " + rango_clientes + "))";

        cout << NivelLog(3) << "--------------- Consulta Cantidad de Clientes ---------------" << endl;
        cout << NivelLog(6) << qry << endl;

        otl_nocommit_stream parm(16384, qry.c_str(),db);
        parm >> cantidad_registros;
        cout <<  NivelLog(3) << "CANTIDAD DE CLIENTES : " << cantidad_registros << endl;
        memoria[0].cantidad_clientes = cantidad_registros;
        return cantidad_registros;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}


int carga_clientes_cp(const string& ciclo_facturacion,int tipdoc,const string& tip_despacho,int frecuencia ,int sem_id, char * szHostId)
{
    try
    {
        int i=0;
        ostringstream aux;
        aux << tipdoc;
        long cont=0;
        string servicio_por_default=memoria[0].detalleoper.szServicio;
        
        string qry2 = "SELECT ROWIDTOCHAR(A.ROWID), "  
                            " A.IND_ORDENTOTAL,  "
                            " A.COD_CLIENTE,  "
                            " A.NUM_FOLIO,  "
                            " NVL(A.NUM_CTC,0), "
                            " TO_CHAR(A.FEC_EMISION,'YYYYMMDD'), "
                            " TO_CHAR(NVL(A.FEC_VENCIMIE,SYSDATE),'YYYYMMDDHH24MISS'), "
                            " A.COD_TIPDOCUM, "
                            " A.NUM_PROCESO, "
                            " C.COD_GENARCH, "
                            " NVL(D.NOM_HEADER,' '), "
                            " C.COD_PRIORIDAD, "
                            " NVL(A.COD_DESPACHO,'DESNO'), "
                            " A.TOT_FACTURA, "
                            " NVL(B.NUM_IDENTTRIB,''), "
                            " B.NOM_CLIENTE||' '||B.NOM_APECLIEN1||' '||B.NOM_APECLIEN2, "
                            " NVL(B.COD_IDIOMA,'1'), "
                            " DECODE(B.IND_DEBITO,'A','1','0'), "
                            " A.PREF_PLAZA, "
                            " A.COD_OPERADORA, "
                            " A.COD_PLAZA, "
                            " A.TOT_CARGOSME, "
                            " NVL(A.IMP_SALDOANT,0), "
                            " A.TOT_PAGAR, "
                            " A.TOT_CUOTAS, "
                            " A.COD_OFICINA, "
                            " A.COD_VENDEDOR, "
                            " A.NOM_USUARORA, "
                            " E.COD_OPERPLAZA, "
                            " A.COD_MONEDAIMP, "
                            " A.IMP_CONVERSION, "
                            " NVL(A.NUM_SECUREL,0), "
                            " NVL(A.LETRAREL,''), "
                            " NVL(A.COD_TIPDOCUMREL,0), "
                            " NVL(A.COD_VENDEDOR_AGENTEREL,0), "
                            " NVL(A.COD_CENTRREL,0), "
                            " NVL(A.NUM_VENTA,0), "
                            " (SELECT TO_CHAR(MIN(F.FEC_ALTA),'YYYYMMDD') FROM GA_INFACCEL F WHERE F.COD_CLIENTE = A.COD_CLIENTE), "
                            " NVL(G.COD_SERVICIO, " + servicio_por_default + "), "
                            " NVL(A.COD_SEGMENTACION,''), "                            
                            " A.NOM_EMAIL, "                                    
                            " NVL(B.COD_TIPIDTRIB,'00'), "                      
                            " TO_CHAR(A.FEC_EMISION,'DD-MM-YYYY HH24:MI:SS'), " 
                            " TO_CHAR(A.FEC_ULTMOD,'DD-MM-YYYY HH24:MI:SS'), "  
                            " A.CONT_TECNICO, "                                                             
                            " A.RESOLUCION, "                                   // P-MIX-09003
                            " TO_CHAR(A.FEC_RESOLUCION,'DD-MM-YYYY'), "         // P-MIX-09003
                            " A.SERIE, "                                        // P-MIX-09003
                            " NVL(A.ETIQUETA,' '), "                            // P-MIX-09003
                            " A.RAN_DESDE, "                                    // P-MIX-09003
                            " A.RAN_HASTA, "                                     // P-MIX-09003  
                            " NVL(A.COD_TIPOLOGIA,' '), "       // P-MIX-09003 141767
                            " NVL(A.COD_AREAIMPUTABLE,' '), "   // P-MIX-09003 141767
                            " NVL(A.COD_AREASOLICITANTE,' ') "  // P-MIX-09003 141767                                                                                  
                        "FROM FA_FACTDOCU_" + ciclo_facturacion + " A, "
                            " FA_FACTCLIE_" + ciclo_facturacion + " B, "
                            " FA_CODESPACHO C, "
                            " FA_PARGENARCH D, "
                            " GE_OPERPLAZA_TD E, "
                            " FAD_IMPSERVCLIE G "
                       "WHERE A.TOT_FACTURA >= 0 "
                        " AND A.COD_CLIENTE >= 0 "
                        " AND A.NUM_FOLIO >= 0 "
                        " AND A.IND_SUPERTEL = 0 "
                        " AND A.IND_ANULADA = 0 "
                        " AND A.IND_FACTUR = 1 "
                        " AND A.IND_IMPRESA = 0 "
                        " AND A.COD_TIPDOCUM = " + aux.str() + " "
                        " AND A.COD_DESPACHO = " + "'" + tip_despacho + "'" + " "
                        " AND B.IND_ORDENTOTAL = A.IND_ORDENTOTAL "
                        " AND C.COD_DESPACHO   = NVL(A.COD_DESPACHO,'DESNO') "
                        " AND D.COD_GENARCH(+) = C.COD_GENARCH "
                        " AND A.COD_OPERADORA  = E.COD_OPERADORA_SCL "
                        " AND A.COD_PLAZA      = E.COD_PLAZA "
                        " AND A.COD_CLIENTE    = G.COD_CLIENTE (+) "
                        " AND A.FEC_EMISION   >= G.FECHA_DESDE (+) "
                        " AND A.FEC_EMISION   <= G.FECHA_HASTA (+) "
                        " AND ((A.COD_CLIENTE BETWEEN " + cliente_inicial + " AND " + cliente_final + ")"
                              " OR (1 <> " + rango_clientes + "))"                              
                      " ORDER BY A.COD_TIPDOCUM, C.COD_GENARCH, A.COD_DESPACHO, A.COD_CLIENTE, A.IND_ORDENTOTAL";

        cout << NivelLog(3) << "--------------- Consulta Carga de Clientes ---------------" << endl;
        cout << NivelLog(6) << qry2 << endl;
        otl_nocommit_stream lista(16384, qry2.c_str(),db);
        cout <<  NivelLog(3) << "Frecuencia : " << frecuencia << endl;
        
        //RPL SE COMENTA TRIGGERON 17-05-2020
         //RPL 12-05-2020 SE DEJA ACA TRIGGERON
         //   cout << NivelLog(3) << "TRIGGERON" << endl;
            
        while (!lista.eof())
        {
        	   /* RPL SE QUITA FUNCION borra_facturados */
            //borra_facturados(sem_id);
            
            cout <<  NivelLog(3) << "Dentro While Carga Clientes... contador " << cont << endl;
            

            if (frecuencia>cont)
            {
                cout <<  NivelLog(3) << "Dentro if (frecuencia>cont)... contador " << cont << endl;            	
                lock(sem_id);
                cont++;
                //RPL 15-07-2020 SE CAMBIA FUNCION GET_REG_FREE PARA PASAR EL ULTIMO VALOR ASIGNADO A LA ESTRUCTURA Y NO RECORRERLA COMPLETA DESDE 0
                // i = get_reg_free();
                i = get_reg_free(i);
                cout <<  NivelLog(3) << "Insertando en ID : " << i << endl;              
                
                string  szRowid;
                long    lIndOrdenTotal;
                long    lCodCliente;
                long    lNum_Folio;
                string  szNumCtc;
                string  szFecEmision;
                string  szFecVencimie;
                int     iCodTipDocum;
                long    lNumProceso;
                string  szCodGenArch;
                string  szNomHeader;
                int     iCodPrioridad;
                string  szCodDespacho;
                double  dTotFactura;
                string  szRut_Cliente;
                string  szNombre_Clie;
                string  szCod_Idioma;
                string  szIndDebito;
                string  szPrefPlaza;
                string  szCodOperadora;
                string  szCodPlaza;
                double  dTotCargosMes;
                double  dImpSaldoAnt;
                double  dTotPagar;
                double  dTotCuotas;
                string  szCod_Oficina;
                long    lCodVendedor;
                string  szNomUsuarora;
                int     iCodOperPlaza;
                string  szCodMonedaImp;
                double  dImpConversion;
                long    lNumSecuRel;         
                string  szLetraRel;          
                int     iCodTipDocumRel;     
                long    lCodVendedorAgRel;   
                long    lCodCentrRel;        
                long    lNumVenta;
                string  szFecMinAlta;
                string  szCod_Servicio;
                string  szCodSegmentacion;
                string  szNomEmail;
                string  szCodIdent;
                string  szFecEmi;
                string  szFecUltMod;
                string  szContTecnico;
                string  szResolucion;        // P-MIX-09003
                string  szFecResolucion;     // P-MIX-09003
                string  szSerie;             // P-MIX-09003
                string  szEtiqueta;          // P-MIX-09003     
                long    lRanDesde;           // P-MIX-09003
                long    lRanHasta;           // P-MIX-09003                
                string  szCodTipologia;       // P-MIX-09003 141767
                string  szCodAreaImputable;   // P-MIX-09003 141767
                string  szCodAreaSolicitante; // P-MIX-09003 141767
                                                
                lista >> szRowid
                      >> lIndOrdenTotal
                      >> lCodCliente 
                      >> lNum_Folio
                      >> szNumCtc
                      >> szFecEmision
                      >> szFecVencimie
                      >> iCodTipDocum
                      >> lNumProceso
                      >> szCodGenArch
                      >> szNomHeader
                      >> iCodPrioridad
                      >> szCodDespacho
                      >> dTotFactura
                      >> szRut_Cliente
                      >> szNombre_Clie
                      >> szCod_Idioma
                      >> szIndDebito
                      >> szPrefPlaza
                      >> szCodOperadora
                      >> szCodPlaza
                      >> dTotCargosMes
                      >> dImpSaldoAnt
                      >> dTotPagar
                      >> dTotCuotas
                      >> szCod_Oficina
                      >> lCodVendedor
                      >> szNomUsuarora
                      >> iCodOperPlaza
                      >> szCodMonedaImp
                      >> dImpConversion
                      >> lNumSecuRel
                      >> szLetraRel
                      >> iCodTipDocumRel
                      >> lCodVendedorAgRel
                      >> lCodCentrRel
                      >> lNumVenta
                      >> szFecMinAlta
                      >> szCod_Servicio
                      >> szCodSegmentacion
                      >> szNomEmail              
                      >> szCodIdent              
                      >> szFecEmi                
                      >> szFecUltMod             
                      >> szContTecnico         
                      >> szResolucion        // P-MIX-09003
                      >> szFecResolucion     // P-MIX-09003
                      >> szSerie             // P-MIX-09003
                      >> szEtiqueta          // P-MIX-09003
                      >> lRanDesde           // P-MIX-09003
                      >> lRanHasta          // P-MIX-09003
                      >> szCodTipologia       // P-MIX-09003 141767
                      >> szCodAreaImputable   // P-MIX-09003 141767
                      >> szCodAreaSolicitante; // P-MIX-09003 141767                      

                memset(st_factclie[i].szRowid,'\0',   sizeof(st_factclie[i].szRowid));
                memset(st_factclie[i].szNumCtc,'\0',   sizeof(st_factclie[i].szNumCtc));
                memset(st_factclie[i].szFecEmision,'\0',   sizeof(st_factclie[i].szFecEmision));
                memset(st_factclie[i].szFecVencimie,'\0',   sizeof(st_factclie[i].szFecVencimie));
                memset(st_factclie[i].szCodGenArch,'\0',   sizeof(st_factclie[i].szCodGenArch));
                memset(st_factclie[i].szNomHeader,'\0',   sizeof(st_factclie[i].szNomHeader));
                memset(st_factclie[i].szCodDespacho,'\0',   sizeof(st_factclie[i].szCodDespacho));
                memset(st_factclie[i].szRut_Cliente,'\0',   sizeof(st_factclie[i].szRut_Cliente));
                memset(st_factclie[i].szNombre_Clie,'\0',   sizeof(st_factclie[i].szNombre_Clie));
                memset(st_factclie[i].szCod_Idioma,'\0',   sizeof(st_factclie[i].szCod_Idioma));
                memset(st_factclie[i].szIndDebito,'\0',   sizeof(st_factclie[i].szIndDebito));
                memset(st_factclie[i].szPrefPlaza,'\0',   sizeof(st_factclie[i].szPrefPlaza));
                memset(st_factclie[i].szCodOperadora,'\0',   sizeof(st_factclie[i].szCodOperadora));
                memset(st_factclie[i].szCodPlaza,'\0',   sizeof(st_factclie[i].szCodPlaza));
                memset(st_factclie[i].szCod_Oficina,'\0',   sizeof(st_factclie[i].szCod_Oficina));
                memset(st_factclie[i].szNomUsuarora,'\0',   sizeof(st_factclie[i].szNomUsuarora));
                memset(st_factclie[i].szCodMonedaImp,'\0',   sizeof(st_factclie[i].szCodMonedaImp));
                memset(st_factclie[i].szLetraRel,'\0',   sizeof(st_factclie[i].szLetraRel));
                memset(st_factclie[i].szFecMinAlta,'\0',   sizeof(st_factclie[i].szFecMinAlta));
                memset(st_factclie[i].szCod_Servicio,'\0',   sizeof(st_factclie[i].szCod_Servicio));
                memset(st_factclie[i].szCodSegmentacion,'\0',   sizeof(st_factclie[i].szCodSegmentacion));                
                memset(st_factclie[i].szNomEmail,'\0',   sizeof(st_factclie[i].szNomEmail));         
                memset(st_factclie[i].szCodIdent,'\0',   sizeof(st_factclie[i].szCodIdent));         
                memset(st_factclie[i].szFecEmi,'\0',   sizeof(st_factclie[i].szFecEmi));             
                memset(st_factclie[i].szFecUltMod,'\0',   sizeof(st_factclie[i].szFecUltMod));       
                memset(st_factclie[i].szContTecnico,'\0',   sizeof(st_factclie[i].szContTecnico));                   
                memset(st_factclie[i].szResolucion,'\0',   sizeof(st_factclie[i].szResolucion));       // P-MIX-09003
                memset(st_factclie[i].szFecResolucion,'\0',   sizeof(st_factclie[i].szFecResolucion)); // P-MIX-09003
                memset(st_factclie[i].szSerie,'\0',   sizeof(st_factclie[i].szSerie));                 // P-MIX-09003
                memset(st_factclie[i].szEtiqueta,'\0',   sizeof(st_factclie[i].szEtiqueta));           // P-MIX-09003
                
                memset(st_factclie[i].szCodTipologia,'\0',   sizeof(st_factclie[i].szCodTipologia));   // P-MIX-09003 141767
                memset(st_factclie[i].szCodAreaImputable,'\0',   sizeof(st_factclie[i].szCodAreaImputable));   // P-MIX-09003 141767
                memset(st_factclie[i].szCodAreaImputable,'\0',   sizeof(st_factclie[i].szCodAreaImputable));   // P-MIX-09003 141767                                
                
                strncpy(st_factclie[i].szRowid,szRowid.c_str(),strlen(szRowid.c_str()));
                st_factclie[i].lIndOrdenTotal = lIndOrdenTotal;
                st_factclie[i].lCodCliente    = lCodCliente;
                st_factclie[i].lNum_Folio     = lNum_Folio;
                strncpy(st_factclie[i].szNumCtc,szNumCtc.c_str(),strlen(szNumCtc.c_str()));
                strncpy(st_factclie[i].szFecEmision,szFecEmision.c_str(),strlen(szFecEmision.c_str()));
                strncpy(st_factclie[i].szFecVencimie,szFecVencimie.c_str(),strlen(szFecVencimie.c_str()));
                st_factclie[i].iCodTipDocum = iCodTipDocum;
                st_factclie[i].lNumProceso  = lNumProceso;
                strncpy(st_factclie[i].szCodGenArch,szCodGenArch.c_str(),strlen(szCodGenArch.c_str()));
                strncpy(st_factclie[i].szNomHeader,szNomHeader.c_str(),strlen(szNomHeader.c_str()));
                st_factclie[i].iCodPrioridad = iCodPrioridad;
                strncpy(st_factclie[i].szCodDespacho,szCodDespacho.c_str(),strlen(szCodDespacho.c_str()));
                st_factclie[i].dTotFactura = dTotFactura;
                strncpy(st_factclie[i].szRut_Cliente,szRut_Cliente.c_str(),strlen(szRut_Cliente.c_str()));
                strncpy(st_factclie[i].szNombre_Clie,szNombre_Clie.c_str(),strlen(szNombre_Clie.c_str()));
                strncpy(st_factclie[i].szCod_Idioma,szCod_Idioma.c_str(),strlen(szCod_Idioma.c_str()));
                strncpy(st_factclie[i].szIndDebito,szIndDebito.c_str(),strlen(szIndDebito.c_str()));
                strncpy(st_factclie[i].szPrefPlaza,szPrefPlaza.c_str(),strlen(szPrefPlaza.c_str()));
                strncpy(st_factclie[i].szCodOperadora,szCodOperadora.c_str(),strlen(szCodOperadora.c_str()));
                strncpy(st_factclie[i].szCodPlaza,szCodPlaza.c_str(),strlen(szCodPlaza.c_str()));
                st_factclie[i].dTotCargosMes = dTotCargosMes;
                st_factclie[i].dImpSaldoAnt = dImpSaldoAnt; 
                st_factclie[i].dTotPagar = dTotPagar;
                st_factclie[i].dTotCuotas = dTotCuotas;
                strncpy(st_factclie[i].szCod_Oficina,szCod_Oficina.c_str(),strlen(szCod_Oficina.c_str()));
                st_factclie[i].lCodVendedor = lCodVendedor;
                strncpy(st_factclie[i].szNomUsuarora,szNomUsuarora.c_str(),strlen(szNomUsuarora.c_str()));
                st_factclie[i].iCodOperPlaza = iCodOperPlaza;
                strncpy(st_factclie[i].szCodMonedaImp,szCodMonedaImp.c_str(),strlen(szCodMonedaImp.c_str()));
                st_factclie[i].dImpConversion = dImpConversion;
                st_factclie[i].lNumSecuRel = lNumSecuRel;                                         
                strncpy(st_factclie[i].szLetraRel,szLetraRel.c_str(),strlen(szLetraRel.c_str())); 
                st_factclie[i].iCodTipDocumRel   =  iCodTipDocumRel  ;                            
                st_factclie[i].lCodVendedorAgRel =  lCodVendedorAgRel;                            
                st_factclie[i].lCodCentrRel      =  lCodCentrRel     ;                            
                st_factclie[i].lNumVenta = lNumVenta;
                strncpy(st_factclie[i].szFecMinAlta,szFecMinAlta.c_str(),strlen(szFecMinAlta.c_str()));
                strncpy(st_factclie[i].szCod_Servicio,szCod_Servicio.c_str(),strlen(szCod_Servicio.c_str()));
                strncpy(st_factclie[i].szCodSegmentacion,szCodSegmentacion.c_str(),strlen(szCodSegmentacion.c_str()));
                strncpy(st_factclie[i].szNomEmail,szNomEmail.c_str(),strlen(szNomEmail.c_str())); 
                strncpy(st_factclie[i].szCodIdent,szCodIdent.c_str(),strlen(szCodIdent.c_str())); 
                strncpy(st_factclie[i].szFecEmi,szFecEmi.c_str(),strlen(szFecEmi.c_str()));       
                strncpy(st_factclie[i].szFecUltMod,szFecUltMod.c_str(),strlen(szFecUltMod.c_str()));
                strncpy(st_factclie[i].szContTecnico,szContTecnico.c_str(),strlen(szContTecnico.c_str()));
                
                strncpy(st_factclie[i].szResolucion,szResolucion.c_str(),strlen(szResolucion.c_str()));          // P-MIX-09003
                strncpy(st_factclie[i].szFecResolucion,szFecResolucion.c_str(),strlen(szFecResolucion.c_str())); // P-MIX-09003
                strncpy(st_factclie[i].szSerie,szSerie.c_str(),strlen(szSerie.c_str()));                         // P-MIX-09003
                strncpy(st_factclie[i].szEtiqueta,szEtiqueta.c_str(),strlen(szEtiqueta.c_str()));                // P-MIX-09003
                st_factclie[i].lRanDesde = lRanDesde;                                                            // P-MIX-09003
                st_factclie[i].lRanHasta = lRanHasta;                                                            // P-MIX-09003

                strncpy(st_factclie[i].szCodTipologia,szCodTipologia.c_str(),strlen(szCodTipologia.c_str()));                // P-MIX-09003 141767
                strncpy(st_factclie[i].szCodAreaImputable,szCodAreaImputable.c_str(),strlen(szCodAreaImputable.c_str()));                // P-MIX-09003 141767
                strncpy(st_factclie[i].szCodAreaSolicitante,szCodAreaSolicitante.c_str(),strlen(szCodAreaSolicitante.c_str()));                // P-MIX-09003 141767                                
                
                st_factclie[i].iestado = 0 ;

                Unlock(sem_id);
            }
            else  
            {
  /* RPL SE QUITA FUNCION borra_facturados */
  //              int clibres_1=0;
  //              clibres_1 = cuenta_libres();
  //              cout <<  NivelLog(3) << "(A) Libres : " << clibres_1 << "Frecuencia : " << frecuencia << endl;

  //             while (clibres_1<frecuencia) 
  //              {
                    chequea_tiempos(szHostId);
  //                  borra_facturados(sem_id);
  //              }
                cont=0;
            }
        }
        return 0;
    }    
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        cout << error.msg << endl;
        cout << error.stm_text << endl;
        cout << error.var_info<< endl;
        return 1;
    }
}


int carga_clientes_sp(const string& ciclo_facturacion,int frecuencia ,int sem_id,char *host_id)
{
    try
    {
        int i=0;
        long cont=0;
        string szIndNoHost="0";
        string servicio_por_default=memoria[0].detalleoper.szServicio;
        
      	/* valida que el Host_ID este informado */
	if (strcmp(host_id, "-1")==0)
	    szIndNoHost = "1";

        
        string qry2 = "SELECT ROWIDTOCHAR(A.ROWID), "  
                            " A.IND_ORDENTOTAL, "
                            " A.COD_CLIENTE, "
                            " A.NUM_FOLIO, "
                            " NVL(A.NUM_CTC,0), "
                            " TO_CHAR(A.FEC_EMISION,'YYYYMMDD'), "
                            " TO_CHAR(NVL(A.FEC_VENCIMIE,SYSDATE),'YYYYMMDDHH24MISS'), "
                            " A.COD_TIPDOCUM, "
                            " A.NUM_PROCESO, "
                            " C.COD_GENARCH, "
                            " NVL(D.NOM_HEADER,' '), "
                            " C.COD_PRIORIDAD, "
                            " NVL(A.COD_DESPACHO,'DESNO'), "
                            " A.TOT_FACTURA, "
                            " NVL(B.NUM_IDENTTRIB,''), "
                            " B.NOM_CLIENTE||' '||B.NOM_APECLIEN1||' '||B.NOM_APECLIEN2, "
                            " NVL(B.COD_IDIOMA,'1'), "
                            " DECODE(B.IND_DEBITO,'A','1','0'), "
                            " A.PREF_PLAZA, "
                            " A.COD_OPERADORA, "
                            " A.COD_PLAZA, "
                            " A.TOT_CARGOSME, "
                            " NVL(A.IMP_SALDOANT,0), "
                            " A.TOT_PAGAR, "
                            " A.TOT_CUOTAS, "
                            " A.COD_OFICINA, "
                            " A.COD_VENDEDOR, "
                            " A.NOM_USUARORA, "
                            " E.COD_OPERPLAZA, "
                            " A.COD_MONEDAIMP, "
                            " A.IMP_CONVERSION, "
                            " NVL(A.NUM_SECUREL,0), "
                            " NVL(A.LETRAREL,''), "
                            " NVL(A.COD_TIPDOCUMREL,0), "
                            " NVL(A.COD_VENDEDOR_AGENTEREL,0), "
                            " NVL(A.COD_CENTRREL,0), "
                            " NVL(A.NUM_VENTA,0), "
                            " (SELECT TO_CHAR(MIN(F.FEC_ALTA),'YYYYMMDD') FROM GA_INFACCEL F WHERE F.COD_CLIENTE = A.COD_CLIENTE), "
                            " NVL(G.COD_SERVICIO, " + servicio_por_default + "), "
                            " NVL(A.COD_SEGMENTACION,''), "                            
                            " A.NOM_EMAIL, "                                    
                            " NVL(B.COD_TIPIDTRIB,'00'), "                   
                            " TO_CHAR(A.FEC_EMISION,'DD-MM-YYYY HH24:MI:SS'), " 
                            " TO_CHAR(A.FEC_ULTMOD,'DD-MM-YYYY HH24:MI:SS'), "  
                            " A.CONT_TECNICO, "                                                             
                            " A.RESOLUCION, "                                   // P-MIX-09003
                            " TO_CHAR(A.FEC_RESOLUCION,'DD-MM-YYYY'), "         // P-MIX-09003                            
                            " A.SERIE, "                                        // P-MIX-09003
                            " NVL(A.ETIQUETA,' '), "                            // P-MIX-09003
                            " A.RAN_DESDE, "                                    // P-MIX-09003
                            " A.RAN_HASTA, "                                     // P-MIX-09003
                            " NVL(A.COD_TIPOLOGIA,' '), "       // P-MIX-09003 141767
                            " NVL(A.COD_AREAIMPUTABLE,' '), "   // P-MIX-09003 141767
                            " NVL(A.COD_AREASOLICITANTE,' ') "  // P-MIX-09003 141767
                       " FROM FA_FACTDOCU_" + ciclo_facturacion + " A, "
                            " FA_FACTCLIE_" + ciclo_facturacion + " B, "
                            " FA_CODESPACHO C, "
                            " FA_PARGENARCH D, "
                            " GE_OPERPLAZA_TD E, "
                            " FAD_IMPSERVCLIE G, "
                            " (SELECT F.cod_tipdocum,F.cod_despacho " 
                            "  FROM FA_PROCIMPRESION_TD F WHERE cod_ciclfact = " + ciclo_facturacion + " " 
                            "  AND COD_ESTAPROC = 1 "
                            "  AND (HOST_ID   = " + host_id +" OR 1 = " + szIndNoHost + ") ) AUX "
                       "WHERE A.TOT_FACTURA >= 0 "
                        " AND A.COD_CLIENTE >= 0 "
                        " AND A.NUM_FOLIO   >= 0 "
                        " AND A.IND_SUPERTEL = 0 "
                        " AND A.IND_ANULADA  = 0 "
                        " AND A.IND_FACTUR   = 1 "
                        " AND A.IND_IMPRESA  = 0 "
                        " AND A.COD_TIPDOCUM = AUX.COD_TIPDOCUM "
                        " AND A.COD_DESPACHO = AUX.COD_DESPACHO "
                        " AND B.IND_ORDENTOTAL = A.IND_ORDENTOTAL "
                        " AND C.COD_DESPACHO   = NVL(A.COD_DESPACHO,'DESNO') "
                        " AND D.COD_GENARCH(+) = C.COD_GENARCH "
                        " AND A.COD_OPERADORA  = E.COD_OPERADORA_SCL "
                        " AND A.COD_PLAZA = E.COD_PLAZA "
                        " AND A.COD_CLIENTE    = G.COD_CLIENTE (+) "
                        " AND A.FEC_EMISION    >= G.FECHA_DESDE (+) "
                        " AND A.FEC_EMISION    <= G.FECHA_HASTA (+) "
                        " AND ((A.COD_CLIENTE BETWEEN " + cliente_inicial + " AND " + cliente_final  + ")"
                              " OR (1 <> " + rango_clientes + "))"
                      " ORDER BY A.COD_TIPDOCUM, C.COD_GENARCH, A.COD_DESPACHO, A.COD_CLIENTE, A.IND_ORDENTOTAL";

 

        cout << NivelLog(3) << "--------------- Consulta Carga de Clientes ---------------" << endl;
        cout << NivelLog(6) << qry2 << endl;
        otl_nocommit_stream lista(16384, qry2.c_str(),db);
        cout <<  NivelLog(3) << "Frecuencia : " << frecuencia << endl;
        
                //RPL SE COMENTA TRIGGERON 17-05-2020
                 //RPL 12-05-2020 SE DEJA ACA TRIGGERON
                // cout << NivelLog(3) << "TRIGGERON" << endl;
        
        while (!lista.eof())
        {
        	   /* RPL SE QUITA FUNCION borra_facturados */
            //borra_facturados(sem_id);
            
   
            if (frecuencia>cont)
            {
            	  cout <<  NivelLog(6) << "carga_clientes_sp Dentro if (frecuencia>cont)... contador: " << cont << endl;            	
                lock(sem_id);
                cont++;
                //RPL 15-07-2020 SE CAMBIA FUNCION GET_REG_FREE PARA PASAR EL ULTIMO VALOR ASIGNADO A LA ESTRUCTURA Y NO RECORRERLA COMPLETA DESDE 0
                // i = get_reg_free();
                i = get_reg_free(i);                
                cout <<  NivelLog(3) << "Insertando en ID : " << i << endl;
                
                string  szRowid;
                long    lIndOrdenTotal;
                long    lCodCliente;
                long    lNum_Folio;
                string  szNumCtc;
                string  szFecEmision;
                string  szFecVencimie;
                int     iCodTipDocum;
                long    lNumProceso;
                string  szCodGenArch;
                string  szNomHeader;
                int     iCodPrioridad;
                string  szCodDespacho;
                double  dTotFactura;
                string  szRut_Cliente;
                string  szNombre_Clie;
                string  szCod_Idioma;
                string  szIndDebito;
                string  szPrefPlaza;
                string  szCodOperadora;
                string  szCodPlaza;
                double  dTotCargosMes;
                double  dImpSaldoAnt;
                double  dTotPagar;
                double  dTotCuotas;
                string  szCod_Oficina;
                long    lCodVendedor;
                string  szNomUsuarora;
                int     iCodOperPlaza;
                string  szCodMonedaImp;
                double  dImpConversion;
                long    lNumSecuRel;  
                string  szLetraRel;   
                int     iCodTipDocumRel;
                long    lCodVendedorAgRel;
                long    lCodCentrRel;     
                long    lNumVenta;
                string  szFecMinAlta;
                string  szCod_Servicio;
                string  szCodSegmentacion;
                string  szNomEmail;
                string  szCodIdent;
                string  szFecEmi;
                string  szFecUltMod;
                string  szContTecnico;                
                // P-MIX-09003
                string  szResolucion;
                string  szFecResolucion;
                string  szSerie;
                string  szEtiqueta;
                long    lRanDesde;
                long    lRanHasta;
                string  szCodTipologia;
                string  szCodAreaImputable;
                string  szCodAreaSolicitante;                                
                
                lista >> szRowid
                      >> lIndOrdenTotal
                      >> lCodCliente 
                      >> lNum_Folio
                      >> szNumCtc
                      >> szFecEmision
                      >> szFecVencimie
                      >> iCodTipDocum
                      >> lNumProceso
                      >> szCodGenArch
                      >> szNomHeader
                      >> iCodPrioridad
                      >> szCodDespacho
                      >> dTotFactura
                      >> szRut_Cliente
                      >> szNombre_Clie
                      >> szCod_Idioma
                      >> szIndDebito
                      >> szPrefPlaza
                      >> szCodOperadora
                      >> szCodPlaza
                      >> dTotCargosMes
                      >> dImpSaldoAnt
                      >> dTotPagar
                      >> dTotCuotas
                      >> szCod_Oficina
                      >> lCodVendedor
                      >> szNomUsuarora
                      >> iCodOperPlaza
                      >> szCodMonedaImp
                      >> dImpConversion
                      >> lNumSecuRel
                      >> szLetraRel
                      >> iCodTipDocumRel
                      >> lCodVendedorAgRel
                      >> lCodCentrRel
                      >> lNumVenta
                      >> szFecMinAlta
                      >> szCod_Servicio
                      >> szCodSegmentacion
                      >> szNomEmail                  
                      >> szCodIdent                  
                      >> szFecEmi                    
                      >> szFecUltMod                 
                      >> szContTecnico               
                      >> szResolucion                  // P-MIX-09003
                      >> szFecResolucion               // P-MIX-09003
                      >> szSerie                       // P-MIX-09003
                      >> szEtiqueta                    // P-MIX-09003
                      >> lRanDesde                     // P-MIX-09003
                      >> lRanHasta                    // P-MIX-09003
                      >> szCodTipologia               // P-MIX-09003
                      >> szCodAreaImputable           // P-MIX-09003
                      >> szCodAreaSolicitante;        // P-MIX-09003                                            

                memset(st_factclie[i].szRowid,'\0',   sizeof(st_factclie[i].szRowid));
                memset(st_factclie[i].szNumCtc,'\0',   sizeof(st_factclie[i].szNumCtc));
                memset(st_factclie[i].szFecEmision,'\0',   sizeof(st_factclie[i].szFecEmision));
                memset(st_factclie[i].szFecVencimie,'\0',   sizeof(st_factclie[i].szFecVencimie));
                memset(st_factclie[i].szCodGenArch,'\0',   sizeof(st_factclie[i].szCodGenArch));
                memset(st_factclie[i].szNomHeader,'\0',   sizeof(st_factclie[i].szNomHeader));
                memset(st_factclie[i].szCodDespacho,'\0',   sizeof(st_factclie[i].szCodDespacho));
                memset(st_factclie[i].szRut_Cliente,'\0',   sizeof(st_factclie[i].szRut_Cliente));
                memset(st_factclie[i].szNombre_Clie,'\0',   sizeof(st_factclie[i].szNombre_Clie));
                memset(st_factclie[i].szCod_Idioma,'\0',   sizeof(st_factclie[i].szCod_Idioma));
                memset(st_factclie[i].szIndDebito,'\0',   sizeof(st_factclie[i].szIndDebito));
                memset(st_factclie[i].szPrefPlaza,'\0',   sizeof(st_factclie[i].szPrefPlaza));
                memset(st_factclie[i].szCodOperadora,'\0',   sizeof(st_factclie[i].szCodOperadora));
                memset(st_factclie[i].szCodPlaza,'\0',   sizeof(st_factclie[i].szCodPlaza));
                memset(st_factclie[i].szCod_Oficina,'\0',   sizeof(st_factclie[i].szCod_Oficina));
                memset(st_factclie[i].szNomUsuarora,'\0',   sizeof(st_factclie[i].szNomUsuarora));
                memset(st_factclie[i].szCodMonedaImp,'\0',   sizeof(st_factclie[i].szCodMonedaImp));
                memset(st_factclie[i].szLetraRel,'\0',   sizeof(st_factclie[i].szLetraRel));
                memset(st_factclie[i].szFecMinAlta,'\0',   sizeof(st_factclie[i].szFecMinAlta));
                memset(st_factclie[i].szCod_Servicio,'\0',   sizeof(st_factclie[i].szCod_Servicio));
                memset(st_factclie[i].szCodSegmentacion,'\0',   sizeof(st_factclie[i].szCodSegmentacion));
                memset(st_factclie[i].szNomEmail,'\0',   sizeof(st_factclie[i].szNomEmail)); 
                memset(st_factclie[i].szCodIdent,'\0',   sizeof(st_factclie[i].szCodIdent)); 
                memset(st_factclie[i].szFecEmi,'\0',   sizeof(st_factclie[i].szFecEmi));     
                memset(st_factclie[i].szFecUltMod,'\0',   sizeof(st_factclie[i].szFecUltMod));
                memset(st_factclie[i].szContTecnico,'\0',   sizeof(st_factclie[i].szContTecnico));                
                memset(st_factclie[i].szResolucion,'\0',   sizeof(st_factclie[i].szResolucion));       // P-MIX-09003
                memset(st_factclie[i].szFecResolucion,'\0',   sizeof(st_factclie[i].szFecResolucion)); // P-MIX-09003
                memset(st_factclie[i].szSerie,'\0',   sizeof(st_factclie[i].szSerie));                 // P-MIX-09003
                memset(st_factclie[i].szEtiqueta,'\0',   sizeof(st_factclie[i].szEtiqueta));           // P-MIX-09003                
                memset(st_factclie[i].szCodTipologia,'\0',   sizeof(st_factclie[i].szCodTipologia));           // P-MIX-09003                
                memset(st_factclie[i].szCodAreaImputable,'\0',   sizeof(st_factclie[i].szCodAreaImputable));           // P-MIX-09003
                memset(st_factclie[i].szCodAreaSolicitante,'\0',   sizeof(st_factclie[i].szCodAreaSolicitante));           // P-MIX-09003                
                
                
                strncpy(st_factclie[i].szRowid,szRowid.c_str(),strlen(szRowid.c_str()));
                st_factclie[i].lIndOrdenTotal = lIndOrdenTotal;
                st_factclie[i].lCodCliente    = lCodCliente;
                st_factclie[i].lNum_Folio     = lNum_Folio;
                strncpy(st_factclie[i].szNumCtc,szNumCtc.c_str(),strlen(szNumCtc.c_str()));
                strncpy(st_factclie[i].szFecEmision,szFecEmision.c_str(),strlen(szFecEmision.c_str()));
                strncpy(st_factclie[i].szFecVencimie,szFecVencimie.c_str(),strlen(szFecVencimie.c_str()));
                st_factclie[i].iCodTipDocum = iCodTipDocum;
                st_factclie[i].lNumProceso  = lNumProceso;
                strncpy(st_factclie[i].szCodGenArch,szCodGenArch.c_str(),strlen(szCodGenArch.c_str()));
                strncpy(st_factclie[i].szNomHeader,szNomHeader.c_str(),strlen(szNomHeader.c_str()));
                st_factclie[i].iCodPrioridad = iCodPrioridad;
                strncpy(st_factclie[i].szCodDespacho,szCodDespacho.c_str(),strlen(szCodDespacho.c_str()));
                st_factclie[i].dTotFactura = dTotFactura;
                strncpy(st_factclie[i].szRut_Cliente,szRut_Cliente.c_str(),strlen(szRut_Cliente.c_str()));
                strncpy(st_factclie[i].szNombre_Clie,szNombre_Clie.c_str(),strlen(szNombre_Clie.c_str()));
                strncpy(st_factclie[i].szCod_Idioma,szCod_Idioma.c_str(),strlen(szCod_Idioma.c_str()));
                strncpy(st_factclie[i].szIndDebito,szIndDebito.c_str(),strlen(szIndDebito.c_str()));
                strncpy(st_factclie[i].szPrefPlaza,szPrefPlaza.c_str(),strlen(szPrefPlaza.c_str()));
                strncpy(st_factclie[i].szCodOperadora,szCodOperadora.c_str(),strlen(szCodOperadora.c_str()));
                strncpy(st_factclie[i].szCodPlaza,szCodPlaza.c_str(),strlen(szCodPlaza.c_str()));
                st_factclie[i].dTotCargosMes = dTotCargosMes;
                st_factclie[i].dImpSaldoAnt = dImpSaldoAnt; 
                st_factclie[i].dTotPagar = dTotPagar;
                st_factclie[i].dTotCuotas = dTotCuotas;
                strncpy(st_factclie[i].szCod_Oficina,szCod_Oficina.c_str(),strlen(szCod_Oficina.c_str()));
                st_factclie[i].lCodVendedor = lCodVendedor;
                strncpy(st_factclie[i].szNomUsuarora,szNomUsuarora.c_str(),strlen(szNomUsuarora.c_str()));
                st_factclie[i].iCodOperPlaza = iCodOperPlaza;
                strncpy(st_factclie[i].szCodMonedaImp,szCodMonedaImp.c_str(),strlen(szCodMonedaImp.c_str()));
                st_factclie[i].dImpConversion = dImpConversion;
                st_factclie[i].lNumSecuRel = lNumSecuRel;                                         
                strncpy(st_factclie[i].szLetraRel,szLetraRel.c_str(),strlen(szLetraRel.c_str())); 
                st_factclie[i].iCodTipDocumRel   =  iCodTipDocumRel  ;                            
                st_factclie[i].lCodVendedorAgRel =  lCodVendedorAgRel;                            
                st_factclie[i].lCodCentrRel      =  lCodCentrRel     ;                            
                st_factclie[i].lNumVenta = lNumVenta;
                strncpy(st_factclie[i].szFecMinAlta,szFecMinAlta.c_str(),strlen(szFecMinAlta.c_str()));
                strncpy(st_factclie[i].szCod_Servicio,szCod_Servicio.c_str(),strlen(szCod_Servicio.c_str()));
                strncpy(st_factclie[i].szCodSegmentacion,szCodSegmentacion.c_str(),strlen(szCodSegmentacion.c_str()));
                strncpy(st_factclie[i].szNomEmail,szNomEmail.c_str(),strlen(szNomEmail.c_str())); 
                strncpy(st_factclie[i].szCodIdent,szCodIdent.c_str(),strlen(szCodIdent.c_str())); 
                strncpy(st_factclie[i].szFecEmi,szFecEmi.c_str(),strlen(szFecEmi.c_str()));       
                strncpy(st_factclie[i].szFecUltMod,szFecUltMod.c_str(),strlen(szFecUltMod.c_str()));
                strncpy(st_factclie[i].szContTecnico,szContTecnico.c_str(),strlen(szContTecnico.c_str()));
                strncpy(st_factclie[i].szResolucion,szResolucion.c_str(),strlen(szResolucion.c_str()));          // P-MIX-09003
                strncpy(st_factclie[i].szFecResolucion,szFecResolucion.c_str(),strlen(szFecResolucion.c_str())); // P-MIX-09003                
                strncpy(st_factclie[i].szSerie,szSerie.c_str(),strlen(szSerie.c_str()));                         // P-MIX-09003                
                strncpy(st_factclie[i].szEtiqueta,szEtiqueta.c_str(),strlen(szEtiqueta.c_str()));                // P-MIX-09003
                st_factclie[i].lRanDesde = lRanDesde;                                                            // P-MIX-09003
                st_factclie[i].lRanHasta = lRanHasta;                                                            // P-MIX-09003
                
                strncpy(st_factclie[i].szCodTipologia,szCodTipologia.c_str(),strlen(szCodTipologia.c_str()));                // P-MIX-09003
                strncpy(st_factclie[i].szCodAreaImputable,szCodAreaImputable.c_str(),strlen(szCodAreaImputable.c_str()));                // P-MIX-09003
                strncpy(st_factclie[i].szCodAreaSolicitante,szCodAreaSolicitante.c_str(),strlen(szCodAreaSolicitante.c_str()));                // P-MIX-09003                
                                
                st_factclie[i].iestado = 0 ;

                Unlock(sem_id);
            }
            else
            {
            	        	   /* RPL SE QUITA FUNCION borra_facturados */
 //               int clibres_2=0;
 //               clibres_2=cuenta_libres();
 //               cout <<  NivelLog(3) << "(B) Libres : " << clibres_2 << " Frecuencia : " << frecuencia << endl;
 //               while (clibres_2<frecuencia) 
 //               {
 //                 borra_facturados(sem_id);
                  chequea_tiempos(host_id);
 //               }
                cont=0;
            }
        }
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}


int cuenta_numorden(int Cod_Formulario)
{
try
{
   int i = 0;
   otl_nocommit_stream cuenta(1024," SELECT COUNT(1) "
                                   " FROM   FAD_IMPCONCEPTOS A, "
                                   "        FAD_IMPSUBGRUPOS B  , "
                                   "        FAD_IMPGRUPOS C "
                                   " WHERE  A.COD_CONCEPTO  > 0 "
                                   "   AND  A.COD_SUBGRUPO  = B.COD_SUBGRUPO "
                                   "   AND  B.COD_GRUPO     = C.COD_GRUPO "
                                   "   AND  C.COD_FORMULARIO = :a<int> "
                                   " ORDER  BY A.COD_CONCEPTO ",db); 
   cout << NivelLog(3) << "Contando Numero de Ordenes " << endl;
   cuenta << Cod_Formulario;
   cuenta >> i;
   return i;
}catch(otl_exception& error){

        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
   return -1;
}
}


int carga_numorden(int Cod_Formulario)
{
    try
    {
       otl_nocommit_stream qry(1024,"SELECT C.NUM_ORDEN GRP,              "
                                    "       B.NUM_ORDEN SGRP,             "
                                    "       A.NUM_ORDEN CONC,             "
                                    "       C.COD_GRUPO,                  "
                                    "       B.COD_SUBGRUPO,               "  
                                    "       A.COD_CONCEPTO,               "
                                    "       NVL(B.COD_REGISTRO,'D3001') , "
                                    "       NVL(B.CRIT_ORDEN,0) ,         "
                                    "       NVL(B.COD_TIPLLAMADA,0) ,     "
                                    "       B.COD_TIPSUBGRUPO             "
                                    "FROM   FAD_IMPCONCEPTOS A,           "
                                    "       FAD_IMPSUBGRUPOS B,           "
                                    "       FAD_IMPGRUPOS C               "
                                    "WHERE  A.COD_CONCEPTO  > 0           "
                                    "  AND  A.COD_SUBGRUPO = B.COD_SUBGRUPO "
                                    "  AND  B.COD_GRUPO    = C.COD_GRUPO    "
                                    "  AND  C.COD_FORMULARIO= :a<int>       "
                                    "ORDER BY A.COD_CONCEPTO                  ",db); 
    
       qry << Cod_Formulario;
       int i = 0;
       int j = 0;
       cout << NivelLog(3) << "Comenzando a Leer NUM_ORDEN " << endl;
       while (!qry.eof())
       {
           int   	iNum_OrdenGr 	;
           int   	iNum_OrdenSubGr ;
            int   	iNum_OrdenConc  ;
           int	    iCodGrupo       ;
           int	    iCodSubGrupo    ;
           int	    iCodConcepto    ;
           string	szCodRegistro	;
           string    iCodCriterio	;
           int	    iTipo_Llamada	;
           int	    iTipo_SubGrupo	;
         
         
            qry >> iNum_OrdenGr  >> iNum_OrdenSubGr >> iNum_OrdenConc >> iCodGrupo >>  iCodSubGrupo  >> iCodConcepto 
               >> szCodRegistro >> iCodCriterio >> iTipo_Llamada	>> iTipo_SubGrupo;
         
         
            memset(numorden[i].szCodRegistro,'\0',sizeof(numorden[i].szCodRegistro));
         
            strncpy(numorden[i].szCodRegistro,szCodRegistro.c_str(),strlen(szCodRegistro.c_str()));
         
           numorden[i].iNum_OrdenGr = iNum_OrdenGr;
           numorden[i].iNum_OrdenSubGr = iNum_OrdenSubGr;
           numorden[i].iNum_OrdenConc  = iNum_OrdenConc;
           numorden[i].iCodGrupo = iCodGrupo;
           numorden[i].iCodSubGrupo = iCodSubGrupo;
           numorden[i].iCodConcepto = iCodConcepto;
           numorden[i].iCodCriterio = atoi(iCodCriterio.c_str());
           numorden[i].iTipo_Llamada = iTipo_Llamada;
           numorden[i].iTipo_SubGrupo = iTipo_SubGrupo;
            i++;
       }
       return 0;
    }
    catch(otl_exception& error)
    {
    
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1;
    }
}


int create_memory(long Size, int id_tabla)
{
   string dire_llave;
   string archivo_llave;
   if(getenv("XPF_CFG"))
   {
   	dire_llave = getenv("XPF_CFG");
   }
   archivo_llave = dire_llave + "/" +"datos_ImpScl.txt";
   cout << NivelLog(3) << "archivo_llave: " << archivo_llave << endl;
   key_t llave;
   llave = ftok(archivo_llave.c_str(),id_tabla);
   if (llave == -1)
   {
     cout <<  NivelLog(3) << "No consigo clave para memoria compartida : " << endl;
     exit(0);
   }

   cout <<  NivelLog(3) << "LLAVE : " << llave << endl;
   int ret = shmget(llave,Size,IPC_CREAT|0600);
   if (ret == -1)
   {
     cout <<  NivelLog(3) << "No consigo Id para memoria compartida Error:" << errno << " " <<strerror(errno) << endl;
   }
   cout <<  NivelLog(3) << "Memoria Compartida Creada" << endl;
   return ret;
}

int crear_semaforo(int id_tabla)
{
   int ret = 0;
   string dire_llave;
   string archivo_llave;
   if(getenv("XPF_CFG"))
   {
       dire_llave = getenv("XPF_CFG");
   }
   archivo_llave = dire_llave + "/" +  "datos_ImpScl.txt";
   
   key_t llave;
   id_tabla = id_tabla + 10 ;
   llave = ftok(archivo_llave.c_str(),id_tabla);
   if (llave == -1)
   {
     cout <<  NivelLog(3) << "No consigo clave para semaforo : " << endl;
     exit(0);
   }

   cout <<  NivelLog(3) << "LLAVE : " << llave << endl;
   ret = semget(llave,1,IPC_CREAT|0666 );
   if (ret == -1)
   {
     cout <<  NivelLog(3) << "No consigo Id para Semaforo" << endl;
   }
   else
   {
     cout <<  NivelLog(3) << "ID :" << ret << endl;
     cout <<  NivelLog(3) << "Semaforo Creado" << endl;
   }
   return ret;
}

int setear_semaforo(int sem_id)
{
   operaciones[0].sem_num =  0;
   operaciones[0].sem_op  =  1;
   operaciones[0].sem_flg =  0;

   cout <<  NivelLog(3) << "Seteando el Semaforo" << endl;
   int ret=semop(sem_id,operaciones,1);	

   cout <<  NivelLog(3) << "SEM ID :" << sem_id << endl;

   if (ret == -1)
   {
     cout <<  NivelLog(3) << "ERROR No se puede setear SEMAFORO" << endl;
   }
}

int valor_semaforo(int sem_id)
{
   int ret=semctl(sem_id,0,GETVAL,0);
   return ret;
}

int destruir_semaforo(int sem_id)
{
   int ret=semctl(sem_id,0,IPC_RMID,0);
   cout <<  NivelLog(3) << "Borrando Semaforo ID : " << sem_id << endl;
   return ret;
}

int lock(int sem_id)
{
   int ret = 0;
   cout <<  NivelLog(3) << "Haciendo Lock" << endl;
   operaciones[0].sem_num =  0;
   operaciones[0].sem_op  = -1;
   operaciones[0].sem_flg =  0;

   while(ret==0)
   {
    ret=valor_semaforo(sem_id);
    if (ret==1)
    {
      cout <<  NivelLog(3) << "Cambiando a Rojo" << endl;
      semop(sem_id,operaciones,1);
      return 0;
    }
    else if (ret==0)
    {
      cout <<  NivelLog(3) << "Semaforo en Rojo" << endl;
    }
   }
}

int Unlock(int sem_id)
{
   int ret = 1;
   cout <<  NivelLog(3) << "Haciendo UnLock" << endl;
   operaciones[0].sem_num =  0;
   operaciones[0].sem_op  =  1;
   operaciones[0].sem_flg =  0;

   while(ret==1)
   {
    ret=valor_semaforo(sem_id);
    if (ret==0)
    {
      cout <<  NivelLog(3) << "Cambiando a Verde" << endl;
      semop(sem_id,operaciones,1);
      return 0;
    }
    else if (ret==1)
    {
      cout <<  NivelLog(3) << "Semaforo ya esta en Verde" << endl;
      return 1;
    }
   }
}

int destroy_memory(int ret)
{
  cout <<  NivelLog(3) << "Borrando Memoria Compartida : " << ret <<  endl;
  shmctl(ret,IPC_RMID,0);
  return 0;
}

int asig_memory(long ret,int id_tabla)
{
   cout <<  NivelLog(3) << "Segmento de Memoria Asignado : " << ret << endl;
   if (id_tabla==1)
   {
     memoria = (MEMORIA *)shmat (ret,(char *)0 , 0);
     if (memoria == NULL)
     {
       cout <<  NivelLog(3) << "ERROR EN ASIGNAR MEMORIA PARA TABLA MEMORIA " << endl;
       return -1;
     }
   }
   else if (id_tabla==2)
   {
     st_factclie = (ST_FACTCLIE *)shmat (ret,(char *)0 , 0);
     if (st_factclie== NULL)
     {
       cout <<  NivelLog(3) << "ERROR EN ASIGNAR MEMORIA PARA TABLA CLIENTES" << endl;
       return -1;
     }
   }
   else if (id_tabla==3)
   {
     numorden = (NUMORDEN *)shmat (ret,(char *)0 , 0);
     if (numorden== NULL)
     {
       cout <<  NivelLog(3) << "ERROR EN ASIGNAR MEMORIA PARA TABLA NUMORDEN" << endl;
       return -1;
     }
   }
   else if (id_tabla==4)
   {
     codcli_hosts = (CODCLI_HOSTS_M *)shmat (ret,(char *)0 , 0);
     if (codcli_hosts== NULL)
     {
       cout <<  NivelLog(3) << "ERROR EN ASIGNAR MEMORIA PARA TABLA CODCLI_HOSTS_M" << endl;
       return -1;
     }
   }

   return 0;
}

int cuenta_facturados()
{
  int i;
  int contador = 0;
  for (i=0; i<total_regs; i++)
  {
   /* RPL 22-04-2020 se cambia estado a 3 que lo deja el impresor cuando genera el .tmp correctamente 
   y update el ind_impresa a 1, lo que significa que esta impreso */
   /*   if (st_factclie[i].iestado==2) */
   if (st_factclie[i].iestado==2)
      {
          contador ++;
      }
  }
  return contador;
}


int cuenta_libres()
{
  int i;
  int contador = 0;
  for (i=0; i<total_regs; i++)
  {
  	/* RPL 22-04-2020 se cambia a estado a 3 que lo deja el impresor cuando genera el .tmp correctamente, ya no lo marca el carga inicial */
   /*   if (st_factclie[i].iestado==2) */
   /* RPL 15062020 SE CAMBIA A ESTADO 0, ESTE ESTADO ES EL DE LOS DOCUMENTOS QUE AÚN NO SE IMPRIMEN  */
      if (st_factclie[i].iestado==0)
      {
      	    cout <<  NivelLog(6) << "RPL cuenta_libres VALOR i: " << i << endl;
      	    cout <<  NivelLog(6) << "RPL CUENTA LIBRES iestado=0, CLIENTE: " << st_factclie[i].lCodCliente << " IND_ORDENTOTAL: " << st_factclie[i].lIndOrdenTotal << endl;
           contador ++;
      }
  }
  return contador;
}


/* RPL 04-08-2020 SE CREA NUEVA FUNCION PARA CONTAR DOCUMENTOS ERRONEOS EN EL IMPRESOR (CON ANOMALIAS) QUE BAJAN EL PROCESO DE IMPRESION 
   SE CREA NUEVO ESTADO 6 CON ERROR */
int cuenta_erroneos()
{
  int i;
  int contador = 0;
  for (i=0; i<total_regs; i++)
  { 	
      if (st_factclie[i].iestado==6)
      {
           contador ++;
      }
  }
  return contador;
}

/* RPL 06-08-2020 SE CREA NUEVA FUNCION PARA CONTAR DOCUMENTOS QUE ESTAN ACTUALMENTE EN IMPRESION */
int cuenta_pendientes()
{
  int i;
  int contador = 0;
  for (i=0; i<total_regs; i++)
  {

      if (st_factclie[i].iestado==1)
      {
           contador ++;
      }
  }
  return contador;
}

/* RPL 21-04-2020 SE CAMBIA FUNCION DE LOCK Y DESLOCK DE SEMAFOROS PARA FACTURADOS  */
/* 
int borra_facturados(int sem_id)
{
  int i;
  int contador = 0 ;
  for (i=0; i<total_regs; i++)
  {
      if (st_factclie[i].iestado==2)
      {
        cout <<  NivelLog(3) << "Borrando Clientes Facturado" << endl;
        lock(sem_id);
        st_factclie[i].iestado=3;
        Unlock(sem_id);
        contador++;
      }
  }
}
*/

/* RPL 21-04-2020 se modifica funcion borra_facturados  */

int borra_facturados(int sem_id)
{
  int i;
  int contador = 0 ;
  lock(sem_id);
  for (i=0; i<total_regs; i++)
  {
      if (st_factclie[i].iestado==2)
      {
        cout <<  NivelLog(3) << "Borrando Clientes Facturado" << endl;
        st_factclie[i].iestado=3;
        Unlock(sem_id);
        contador++;
      }
  }
   Unlock(sem_id);
}

int setea_clientes(int sem_id)
{
     cout <<  NivelLog(3) << "Seteando Extructura Clientes" << endl;
     int i;
     lock(sem_id);
     for(i=0 ; i<total_regs ; i++)
     {
       memset(st_factclie[i].szRowid,'\0',   sizeof(st_factclie[i].szRowid));
       memset(st_factclie[i].szNumCtc,'\0',   sizeof(st_factclie[i].szNumCtc));
       memset(st_factclie[i].szFecEmision,'\0',   sizeof(st_factclie[i].szFecEmision));
       memset(st_factclie[i].szFecVencimie,'\0',   sizeof(st_factclie[i].szFecVencimie));
       memset(st_factclie[i].szCodGenArch,'\0',   sizeof(st_factclie[i].szCodGenArch));
       memset(st_factclie[i].szNomHeader,'\0',   sizeof(st_factclie[i].szNomHeader));
       memset(st_factclie[i].szCodDespacho,'\0',   sizeof(st_factclie[i].szCodDespacho));
       memset(st_factclie[i].szRut_Cliente,'\0',   sizeof(st_factclie[i].szRut_Cliente));
       memset(st_factclie[i].szNombre_Clie,'\0',   sizeof(st_factclie[i].szNombre_Clie));
       memset(st_factclie[i].szCod_Idioma,'\0',   sizeof(st_factclie[i].szCod_Idioma));
       memset(st_factclie[i].szIndDebito,'\0',   sizeof(st_factclie[i].szIndDebito));
       memset(st_factclie[i].szPrefPlaza,'\0',   sizeof(st_factclie[i].szPrefPlaza));
       memset(st_factclie[i].szCodOperadora,'\0',   sizeof(st_factclie[i].szCodOperadora));
       memset(st_factclie[i].szCodPlaza,'\0',   sizeof(st_factclie[i].szCodPlaza));
       memset(st_factclie[i].szCod_Oficina,'\0',   sizeof(st_factclie[i].szCod_Oficina));
       memset(st_factclie[i].szNomUsuarora,'\0',   sizeof(st_factclie[i].szNomUsuarora));
       st_factclie[i].lIndOrdenTotal=0;
       st_factclie[i].lCodCliente	=0;
       st_factclie[i].lNum_Folio	=0;
       st_factclie[i].iCodTipDocum	=0;
       st_factclie[i].lNumProceso	=0;
       st_factclie[i].iCodPrioridad	=0;
       st_factclie[i].dTotFactura	=0.0;
       st_factclie[i].dTotCargosMes	=0.0;
       st_factclie[i].dImpSaldoAnt	=0.0;
       st_factclie[i].dTotPagar		=0.0;
       st_factclie[i].dTotCuotas	=0.0;
       st_factclie[i].lCodVendedor	=0;
       st_factclie[i].iCodOperPlaza	=0;
       st_factclie[i].iNumAbonados	=0;
       st_factclie[i].iIndImprime	=0;
       st_factclie[i].iestado		=3;
     }
     Unlock(sem_id);
}

// RPL PROY CSR 20072020 SE DEJA COMENTADA FUNCION ANTERIOR get_reg_free
//int get_reg_free()
//{
//   int i;
//   for(i=0 ; i<total_regs ; i++)
//   {
//     if(st_factclie[i].iestado==3)
//        return i;
//   }
//   return -1;
//}
// RPL PROY CSR 17072020 SE CAMBIA FUNCION ger_reg_free para que no recorra la estructura completa cada vez que se consulta y solo obtenga el siguiente registro
int get_reg_free(int i)
{
   int x;
   for(x=i ; x<total_regs ; x++)
   {
     if(st_factclie[x].iestado==3)
        return x;
   }
   return -1;
}

bool bfnElimina_FadCTLImpres()
{
try
{

    cout <<  NivelLog(3) << "ELIMINANDO SECUENCIA EN FAD_CTLIMPRES......" << endl;
    szHModulo = "bfnElimina_FadCTLImpres";
    string Cod_Despacho = memoria[0].StParametrosEntrada.szCodDespacho;
    int iNum_SecuInfo =   memoria[0].StParametrosEntrada.lNum_SecuInfo ;
    otl_nocommit_stream borra(16384,"DELETE FROM FAD_CTLIMPRES "
                                    "WHERE NUM_SECUINFO = :a<int> AND "
                                    "      COD_TIPDOCUM = :b<int> AND "
                                    "      COD_DESPACHO = :ciclo<char[6]> ",db);

    borra  << iNum_SecuInfo << memoria[0].StParametrosEntrada.iCodTipDocum << Cod_Despacho ;

    db.commit();

    return(TRUE);
} catch(otl_exception& error)
{

        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return (FALSE);
}
}

bool bfnChequeaEstado (char *host_id)
{
try
{
    int     ihCod_Estaproc = 0;
    string  szhCodDespacho  ;
    int     ihCodTipDocum   ;
    int     lhCodCiclo      ;
	int 	iIndNoHost	   = 0;
    szHModulo = "";
    szHModulo = "bfnChequeaEstado";

    lhCodCiclo      = memoria[0].StParametrosEntrada.lCodCiclFact;
    szhCodDespacho  = memoria[0].StParametrosEntrada.szCodDespacho;
    ihCodTipDocum   = memoria[0].StParametrosEntrada.iCodTipDocum;
    

    otl_nocommit_stream cheq(16384,"SELECT COD_ESTAPROC "
                                   "  FROM FA_PROCIMPRESION_TD        "
                                   " WHERE COD_CICLFACT = :a<int>     "
                                     " AND COD_DESPACHO = :b<char[6]> "
                                     " AND COD_TIPDOCUM = :c<int>     "
                                     " AND (HOST_ID   = :hostsID<char[21]> OR 1=:iIndNoHost<int>)" ,db);
  	/* valida que el Host_ID este informado */
	if (strcmp(host_id, "-1")==0)
		iIndNoHost = 1;

    cheq << lhCodCiclo << szhCodDespacho << ihCodTipDocum << host_id << iIndNoHost;
    cheq >> ihCod_Estaproc ;
    cout <<  NivelLog(3) << "ESTADO EN FA_PROCIMPRESION_TD : " << ihCod_Estaproc << endl;

    if (ihCod_Estaproc == 1)
    {
        //vDTrazasLog(szModulo, "Estado del proceso : En Proceso. El proceso actual se aborta", LOG01);
        cout <<  NivelLog(3) << "Estado del proceso : En Proceso. El proceso actual se aborta" << endl;
        return (FALSE);
    }

    return (TRUE);
} catch(otl_exception& error)
{
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return (FALSE);
}
}


bool bfnActualizaRegprocImpres (char *host_id)
{
try
{
    cout <<  NivelLog(3) << "PROCESO bfnActualizaRegprocImpres ..." << endl;

    int     ihCod_Estaproc=0;
    string  szhCodDespacho = memoria[0].StParametrosEntrada.szCodDespacho;
    int     ihCodTipDocum  = memoria[0].StParametrosEntrada.iCodTipDocum;
    int     lhCodCiclo     = memoria[0].StParametrosEntrada.lCodCiclFact;
    string  szhglosa;
    int 	iIndNoHost = 0;

    cout <<  NivelLog(3) << "szhCodDespacho : " << szhCodDespacho << endl;
    cout <<  NivelLog(3) << "ihCodTipDocum  : " << ihCodTipDocum  << endl;
    cout <<  NivelLog(3) << "lhCodCiclo     : " << lhCodCiclo     << endl;

    szHModulo = "";
    szHModulo = "bfnActualizaRegprocImpres";

    otl_nocommit_stream qry(16384,"SELECT COD_ESTAPROC "
                                  "  FROM FA_PROCIMPRESION_TD "
                                  " WHERE COD_CICLFACT = :a<int> "
                                    " AND COD_TIPDOCUM = :b<int> "
                                    " AND COD_DESPACHO = :c<char[6]> "
                                    " AND (HOST_ID   = :hostsID<char[21]> OR 1=:iIndNoHost<int>)" ,db);
  	/* valida que el Host_ID este informado */
	if (strcmp(host_id, "-1")==0)
		iIndNoHost = 1;

    qry << lhCodCiclo << ihCodTipDocum << szhCodDespacho << host_id << iIndNoHost;
    qry >> ihCod_Estaproc ;
    cout <<  NivelLog(3) << "ESTADO PROC ANTES: " << ihCod_Estaproc << endl;

    if (ihCod_Estaproc == 1)
    {
        cout  << NivelLog(3) << szHModulo <<  " Estado del proceso : En Proceso. Proceso nuevo se aborta" <<  endl;
        return(FALSE);
    }

    ihCod_Estaproc=iPROC_EST_RUN;
    cout <<  NivelLog(3) <<  "ESTADO PROC DESPUES: " << ihCod_Estaproc << endl;
    szhglosa = szPROC_EST_RUN;

    otl_nocommit_stream actualiza(16384,"UPDATE FA_PROCIMPRESION_TD          "
                                        "   SET COD_ESTAPROC = :a<int> ,     "
                                        "       GLS_ESTAPROC = :b<char[52]> ,"
                                        "       FEC_INICIO   = SYSDATE       "
                                        " WHERE COD_CICLFACT = :c<int>       "
                                          " AND COD_TIPDOCUM = :d<int>       "
                                          " AND COD_DESPACHO = :e<char[6]>   "
                                          " AND (HOST_ID   = :hostsID<char[21]> OR 1=:iIndNoHost<int>)" ,db);
    actualiza << ihCod_Estaproc << szhglosa << lhCodCiclo << ihCodTipDocum << szhCodDespacho << host_id << iIndNoHost;

    db.commit();

   	return (TRUE);
}catch(otl_exception& error)
{

   cerr << error.msg << endl;
   cerr << error.stm_text << endl;
   cerr << error.var_info<< endl;
   return (FALSE);
}
}

int desgloza(const string& login)
{
    int i;
    int j=0;
    string temp1;
    string temp2;
    for(i=0 ; i<=strlen(login.c_str()) ; i++)
    {
        if (login.substr(i,1)=="/")
        {
            temp1=login.substr(0,i);
            j=i+1;
        }
        if ((login.substr(i,1)=="@") || (i==strlen(login.c_str())))
        {
            temp2=login.substr(j,i-j);
        }
    }
    memset(memoria[0].StParametrosEntrada.szUser,'\0',sizeof(memoria[0].StParametrosEntrada.szUser));
    memset(memoria[0].StParametrosEntrada.szPass,'\0',sizeof(memoria[0].StParametrosEntrada.szPass));
    strncpy(memoria[0].StParametrosEntrada.szUser,temp1.c_str(),strlen(temp1.c_str()));
    strncpy(memoria[0].StParametrosEntrada.szPass,temp2.c_str(),strlen(temp2.c_str()));
    cout << NivelLog(3) << "USER : " << memoria[0].StParametrosEntrada.szUser << endl;
    cout << NivelLog(3) << "PASSWORD :" << memoria[0].StParametrosEntrada.szPass << endl;
    return 0;	
}

int prepara_concatenador()
{
   int i;
   cout <<  NivelLog(5) << "FUNCION PARA LIMPIAR EXTRUCTURA DE CONCATENACION" << endl;
   for(i=0 ; i<2000 ; i++)
   {
    memset(memoria[0].concatenador[i].szupdate,'\0',sizeof(memoria[0].concatenador[i].szupdate));
    memset(memoria[0].concatenador[i].sznomarchivo,'\0',sizeof(memoria[0].concatenador[i].sznomarchivo));
    memset(memoria[0].concatenador[i].szCod_Despacho,'\0',sizeof(memoria[0].concatenador[i].szCod_Despacho));
    memoria[0].concatenador[i].marcador = 0 ;
   }
   return 0;
}

int escribe_archivo_tiempo()
{
   string comando;
   comando = "date +%H%M%S%d%m%Y > $XPF_TMP/tiempos_ImpScl.txt";
   system(comando.c_str());
   return 0;
}



int CheckParamEntrada(int argc, char * const argv[], ENTRADA * StParam)
{
   char        opt[]="u:c:f:r:n:t:d:l:i:k:a:z:";
   extern  char * optarg                 ;
   int         bOptUsuario             ;
   int         iOpt            =0      ;
   
   //memset(StParam,0,sizeof(ENTRADA));
    
   while ((iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
            case 'u':
              /*-------------------------------------
                USUARIO DE CONEXION ORACLE:
                -------------------------------------*/
                if(strlen (optarg))
                {
                    StParam->login ="";
                    StParam->login = optarg;
                    bOptUsuario = TRUE;
                    cout << NivelLog(1) << "user : " << StParam->login <<endl;
                }
                break;

            case 'c':
              /*-------------------------------------
                1: CICLO A PROCESAR :
                -------------------------------------*/
                if(strlen (optarg)) 
                {
                     StParam->ciclo_facturacion = "";
                     StParam->ciclo_facturacion = (string)optarg;
                     cout << NivelLog(1) << "ciclo_facturacion : " << StParam->ciclo_facturacion <<endl;
                }
                break;

            case 'f':
                if(strlen (optarg)) 
                {
                    StParam->frecuencia ="";
                    StParam->frecuencia = (string)optarg;
                    cout << NivelLog(1) << "frecuencia :" << StParam->frecuencia << endl;
                }
                break;

            case 'r':
                if(strlen (optarg)) 
                {
                    StParam->total_regs = "";
                    StParam->total_regs = (string)optarg;	
                    cout << NivelLog(1) << "total_regs : " << StParam->total_regs << endl;
                }
                break;
            case 'n':
                if(strlen (optarg)) 
                {
                    StParam->num_secuinfo="";
                    StParam->num_secuinfo = (string)optarg;
                    cout << NivelLog(1) << "num_secuinfo :" << StParam->num_secuinfo << endl;
                }
                break;
            case 't':
              /*-------------------------------------
                Tipo de Documento 
                -------------------------------------*/
                if(strlen (optarg))
                {
                    StParam->cod_tipdocum = "";
                    StParam->cod_tipdocum = (string)optarg;
                    cout << NivelLog(1) << "cod_tipdocum : " << StParam->cod_tipdocum << endl;
                    todos=1;
                }
                break;

            case 'd':
              /*-------------------------------------
                Codigo de Despacho :
                -------------------------------------*/
                if(strlen (optarg))
                {
                    StParam->cod_despacho = "" ;
                    StParam->cod_despacho = optarg;
                    cout << NivelLog(1) << "cod_despacho :" << StParam->cod_despacho << endl;
                    if (todos!=1)
                    {
                        cout << NivelLog(3) << "ERROR Falta Ingresar el Tipo de Documento en los Parametros de Entrada" << endl;
                        exit(0);
                    }
                    else if (StParam->cod_despacho != "")
                        todos=2;
                }
                break;
                
            case 'l':
              /*-------------------------------------
                NIVEL DE LOGEO :
                -------------------------------------*/
                if(strlen (optarg)) 
                {
                   StParam->nivel_de_log = "";
                   StParam->nivel_de_log = optarg ;
                   cout << NivelLog(1) << "nivel_de_log : " << StParam->nivel_de_log << endl;
                }
                break;
                
            case 'i':
              /*-------------------------------------
                INTENTOS :
                -------------------------------------*/
                if(strlen (optarg)) 
                {
                   intentos_lectura = atoi(optarg);
                   cout << NivelLog(1) << "Intentos Configurados : " << intentos_lectura << endl;
                }
                break;
                
            case 'a':
              /*-------------------------------------
                CLIENTE INICIAL :
                -------------------------------------*/
                rango_clientes = "0";
                if(strlen (optarg)) 
                {
                    cliente_inicial = "";
                    cliente_inicial = (string)optarg;
                    cout << NivelLog(1) << "Cliente Inicial : " << cliente_inicial << endl;
                    if (cliente_inicial != "-1")
                        rango_clientes = "1";
                }
                break;
                
            case 'z':
              /*-------------------------------------
                CLIENTE FINAL :
                -------------------------------------*/
                rango_clientes = "0";
                if(strlen (optarg)) 
                {
                    cliente_final = "";
                    cliente_final = (string)optarg;
                    cout << NivelLog(1) << "Cliente Final   : " << cliente_final << endl;
                    if (cliente_final != "-1")
                        rango_clientes = "1";
                }
                break;
        }
    }
    if(todos==1)
    {
        cout << NivelLog(1) << "FALTO INGRESAR EL CODIGO DE DESPACHO" << endl;
        exit(0);
    }

    return(0);
}


extern "C" void sigKillHandler( int p)
{
  cout << NivelLog(3) << "SEÑAL KILL DETECTADA A CARGA INICIAL" << endl;
  memoria[0].flag_proceso=0;
  destroy_memory(global_clientes);
  destroy_memory(global_codcli);
  destroy_memory(global_numorden);
  exit(0);
}

extern "C" void sigTermHandler( int p)
{
  cout << NivelLog(3) << "SEÑAL TERMINO DETECTADA A CARGA INICIAL" << endl;
  memoria[0].flag_proceso=0;
  destroy_memory(global_clientes);
  destroy_memory(global_codcli);
  destroy_memory(global_numorden);
  exit(0);

}



int main (int argc, char *argv[])
{

  //LINEACOMANDO StParametrosEntrada;

    int     frecuencia;
    int     size;
    long    size_clientes;
    int     sem_id;
    int     valor_sem;
    int     regs_numorden=0;
    long    codcli_regs=0;
    ENTRADA parametros;
    string  ciclo_facturacion;
    string  num_secuinfo;
    string  cod_tipdocum;
    string  cod_despacho;
    string  nivel_de_log;
    char    sApli_Cod_Autorizacion;
    char    sApli_S;
    int     retorno;


    cout << endl << "\tCarga_Inicial_ImpSCL MC version " __DATE__ " " __TIME__ << endl << endl;
 
    strcpy(&sApli_S,"S");
    if(CheckParamEntrada(argc,argv,&parametros)!=0)
    {
        cout << NivelLog(1) << "Falla en Parametros de Entrada" << endl ;
        exit(0);
    }
  
    signal(SIGKILL,sigKillHandler);
    signal(SIGTERM,sigTermHandler);

    ciclo_facturacion = argv[2];
    frecuencia = atoi(argv[3]);
    total_regs = atoi(argv[4]);
    num_secuinfo = argv[5];
    cod_tipdocum = argv[6];
    cod_despacho = argv[7];
    nivel_de_log = argv[8];

    cout <<  NivelLog(1) << "Ciclo de Facturacion : " << parametros.ciclo_facturacion << endl; 
    cout <<  NivelLog(1) << "Frecuencia           : " << parametros.frecuencia << endl;
    cout <<  NivelLog(1) << "Num Sec Info                    :" << parametros.num_secuinfo << endl;
    cout <<  NivelLog(1) << "Cod Tipo Docum                  :" << parametros.cod_tipdocum << endl;
    cout <<  NivelLog(1) << "Cod Despacho                    :" << parametros.cod_despacho << endl;    
    cout <<  NivelLog(1) << "Nivel de Log                    :" << parametros.nivel_de_log << endl;
    cout <<  NivelLog(1) << "Alocando en Memoria Tabla MEMORIA" << endl;
    int actuallevel = atoi(parametros.nivel_de_log.c_str());
    cout << NivelLog(1) << "Nivel de Log Configurado : " << actuallevel << endl;
    NivelLog::SetNivelLog(actuallevel);
       
    cout <<  NivelLog(1) << "Indicador de Rango   : " << rango_clientes << endl;;

    int ret_login=login((char *)parametros.login.c_str());
    if (ret_login==1)
    {
        cout << NivelLog(3) << "FALLA CON USUARIO Y PASSWORD" << endl;
        exit(0);
    }
    size = sizeof(MEMORIA); 
    cout << NivelLog(3) << "SIZE MEMORIA: " << size << endl; 

    int ret = create_memory(size,ID_MEMORIA);
    cout <<  NivelLog(3) << "DIRECCION DE MEMORIA : " << ret << endl;

    if (ret==-1)
    {
        cout << NivelLog(3) << "ERROR al formatear memoria con Tabla Memoria" << endl ;
        exit(0);
    }

    int ret_1=asig_memory(ret,ID_MEMORIA);

    if (ret_1==-1)
    {
        cout << NivelLog(3) << "ERROR al formatear memoria con Tabla MEMORIA" << endl ;
        exit(0);
    }

    global_ret = ret ;


    retorno= GetHostId(memoria[0].StParametrosEntrada.szHostId);
    if (retorno == -1)
    {
        cout << NivelLog(5) << "No esta configurado Host en Directorio " << getenv("XPF_CFG") << endl;
        strcpy(memoria[0].StParametrosEntrada.szHostId,"-1");
    }

    int retor=create_directory(parametros.ciclo_facturacion, memoria[0].StParametrosEntrada.szHostId);
    if (retor==1)
    {
        cout << NivelLog(3) << "Falla en Creacion Extructura de Directorios" << endl;
        db.commit();
        logout();
        destroy_memory(ret);
        exit(0);
    }
    cout << NivelLog(3) << "--------------- Carga Parametros ---------------"<< endl ;
    carga_st_parametros();
    cout << NivelLog(3) << "--------------- Carga Parametros Generales ---------------"<< endl ;
    carga_st_parametros_ged();
    cout << NivelLog(3) << "--------------- Carga Parametros de Ambiente ---------------"<< endl ;
    Carga_GedParam_Env();
    cout << NivelLog(3) << "--------------- Carga Planes Tarifarios ---------------"<< endl ;
    carga_planes_tarifarios();
    cout << NivelLog(3) << "--------------- Carga Oficinas ---------------"<< endl ;
    carga_oficinas();
    cout << NivelLog(3) << "--------------- Carga Vendedores ---------------"<< endl ;
    carga_vendedores(parametros.ciclo_facturacion);
    cout << NivelLog(3) << "--------------- Carga Tipos de Documentos ---------------"<< endl ;
    carga_tipdoc();
    cout << NivelLog(3) << "--------------- Carga Ciclo de Facturacion ---------------"<< endl ;
    carga_st_ciclofact(parametros.ciclo_facturacion);
    cout << NivelLog(3) << "--------------- Carga Operadora ---------------"<< endl ;
    carga_operadora_hosts();
    cout << NivelLog(3) << "--------------- Carga Conceptos de Tarificacion ---------------"<< endl ;
    carga_conceptos_tar();
    cout << NivelLog(3) << "--------------- Carga Detalles de Operadora ---------------"<< endl ;
    carga_detalleoper();
    cout << NivelLog(3) << "--------------- Carga Minutos Adicionales ---------------"<< endl ;
    carga_minutos_adicionales();
    cout << NivelLog(3) << "--------------- Carga Prepara Concatenador ---------------"<< endl ;
    prepara_concatenador();

/* Se agrega if para rescatar valor de codigo de autorizacon (si aplica).
*/
    cout << NivelLog(3) << "--------------- Carga Codigo de Autorizacion ---------------" << endl ;
    if (strcmp(memoria[0].st_parametros_ged.sAplica_Cod_Autorizacion,"S") == 0) 
    {
        carga_st_codAutorizacion(parametros.ciclo_facturacion);
    }
/*
Se agrega llamada a funcion carga_codImptofact para la carga de conceptos de factura a memoria compartida.
*/  
    cout << NivelLog(3) << "--------------- Carga Codigo Importe Facturable  ---------------" << endl ;
    carga_codImptofact();
  
/* Carga de codigo y descripcion de operadora en memoria compartida. */
    cout << NivelLog(3) << "--------------- Carga Codigo Operacion  ---------------" << endl ;
    carga_codOper();

    cout << NivelLog(3) << "--------------- Carga Categoria Impuestos  ---------------" << endl ;
    carga_cat_imptos();

    cout << NivelLog(3) << "--------------- Carga Tipo Trafico LD  ---------------" << endl ;
    carga_tip_trafico_ld();

    cout << NivelLog(3) << "--------------- Carga Datos Dominio  ---------------" << endl ;
    Carga_Dat_Dominio();

    cout << NivelLog(3) << "--------------- Carga Cuenta Cliente  ---------------" << endl ;
    codcli_regs=cuenta_codcli_hosts(parametros.ciclo_facturacion);
    cout << NivelLog(3) <<"CONTANDO TABLA CODCLI_HOSTS_M : " << codcli_regs << endl;
    int size_codcli=(sizeof(CODCLI_HOSTS_M) * codcli_regs);
    cout << NivelLog(3) <<"TAMAÑO DE MEMORIA EN KB CODCLI_HOSTS_M : " << size_codcli << endl;

    int ret_codcli = create_memory(size_codcli,ID_CODCLI);
    cout << NivelLog(3) << "DIRECCION DE MEMORIA PARA CODCLI_HOSTS_M: " << ret_codcli << endl;

    if (ret_codcli==-1)
    {
        cout <<  NivelLog(3) << "ERROR al crea memoria para tabla CODCLI_HOSTS_M" << endl ;
        exit(0);
    }

    int ret_4=asig_memory(ret_codcli,ID_CODCLI);

    if (ret_4==-1)
    {
        cout <<  NivelLog(3) << "ERROR Al formatear memoria con Tabla CODCLI_HOSTS_M" << endl ;
        exit(0);
    }

    global_codcli = ret_codcli;
    carga_codcli_hosts(parametros.ciclo_facturacion);
  
    regs_numorden = cuenta_numorden(memoria[0].detalleoper.iCodFormulario);
    int size_numorden = (sizeof(NUMORDEN) * regs_numorden);
    cout << NivelLog(3) << "Tamaño de memoria para NunOrden : " << size_numorden << endl ;

    int ret_numorden = create_memory(size_numorden,ID_NUMORDEN);
    cout << NivelLog(3) << "DIRECCION DE MEMORIA PARA NUMORDEN: " << ret_numorden << endl;

    if (ret_numorden==-1)
    {
        cout <<  NivelLog(3) << "ERROR al crea memoria para tabla NUMORDEN" << endl ;
        exit(0);
    }

    int ret_3=asig_memory(ret_numorden,ID_NUMORDEN);
  
    if (ret_3==-1)
    {
        cout <<  NivelLog(3) << "ERROR Al formatear memoria con Tabla NUMORDEN" << endl ;
        exit(0);
    }

    global_numorden = ret_numorden;
    cout << NivelLog(3) <<"REGS NUM ORDEN : " << regs_numorden << endl;

    carga_numorden(memoria[0].detalleoper.iCodFormulario);

    tiempo_configurado();

    memoria[0].StParametrosEntrada.lCodCiclFact = atol(parametros.ciclo_facturacion.c_str());
    memoria[0].StParametrosEntrada.lNum_SecuInfo = atol(parametros.num_secuinfo.c_str());
    memoria[0].StParametrosEntrada.iCodTipDocum = atoi(parametros.cod_tipdocum.c_str());
    memset(memoria[0].StParametrosEntrada.szCodDespacho,'\0',   sizeof(memoria[0].StParametrosEntrada.szCodDespacho));
    strncpy(memoria[0].StParametrosEntrada.szCodDespacho,parametros.cod_despacho.c_str(),strlen(parametros.cod_despacho.c_str()));
    memoria[0].StParametrosEntrada.iNivLog = atoi(parametros.nivel_de_log.c_str());
    memoria[0].StParametrosEntrada.iReproceso=FALSE;
    memoria[0].StParametrosEntrada.lProceso=0;
    memoria[0].flag_proceso=1;
    desgloza(parametros.login);
    memoria[0].iregs_numorden = regs_numorden;
    
     
    cout << NivelLog(3) << "Get Frecuencia : " << get_frecuencia() << endl;
    cout << NivelLog(3) << "Get Numero Min : " << get_nro_minimo() << endl;
  
    sem_id=crear_semaforo(ID_CLIENTES);
    global_semid = sem_id;

    cout << NivelLog(3) << "ID DE SEMAFORO : " << sem_id << endl;
    setear_semaforo(sem_id);
    valor_sem = valor_semaforo(sem_id);

    cout << NivelLog(3) << "VALOR SEMAFORO : " << valor_sem << endl;

    total_regs = atoi(parametros.total_regs.c_str());
    cout <<  NivelLog(3) << "TOTAL DE REGISTROS A RESERVAR EN MEMORIA : " << total_regs << endl;

    size_clientes = (sizeof(ST_FACTCLIE) * total_regs);

    cout << NivelLog(3) << "Size de Clientes : " << size_clientes << endl;
  
    int ret_clientes = create_memory(size_clientes,ID_CLIENTES);
    cout << NivelLog(3) << "DIRECCION DE MEMORIA PARA CLIENTES: " << ret_clientes << endl;
    if (ret_clientes==-1)
    {
        cout <<  NivelLog(3) << "ERROR al crea memoria para tabla CLIENTES" << endl ;
        exit(0);
    }
    int ret_2=asig_memory(ret_clientes,ID_CLIENTES);
  
    if (ret_2==-1)
    {
        cout <<  NivelLog(3) << "ERROR Al formatear memoria con Tabla CLIENTES" << endl ;
        exit(0);
    }
  
    global_clientes = ret_clientes;

    tipo_documento = atoi(parametros.cod_tipdocum.c_str());
    despacho = parametros.cod_despacho;
    global_ciclo = parametros.ciclo_facturacion;
    //cout << "TODOS :" << todos << endl;
    if (todos==0)
    {
        cout <<  NivelLog(3) << "Se ACTUALIZAN Todos los Codigos de Despacho y Tipos de Documentos....." << endl ;
        actualiza_faprocimpresion(parametros.ciclo_facturacion,4,1,memoria[0].StParametrosEntrada.szHostId);
    }
    else if(todos==2)
    { 
        cout <<  NivelLog(3) << "Se ACTUALIZA el Tipo de Documento  :" << parametros.cod_tipdocum << endl;
        cout <<  NivelLog(3) << "Se ACTUALIZA el Codigo de Despacho :" << parametros.cod_despacho << endl;
        actualiza_faprocimpresion_cp(parametros.ciclo_facturacion,atoi(parametros.cod_tipdocum.c_str()),parametros.cod_despacho,4,1, memoria[0].StParametrosEntrada.szHostId);
    }

    db.commit();

    if (todos==0)
    {
        cuenta_clientes_todos(parametros.ciclo_facturacion);
    }
    else if(todos==2)
    {   
        cuenta_clientes(parametros.ciclo_facturacion,memoria[0].StParametrosEntrada.iCodTipDocum,parametros.cod_despacho);
    }
    setea_clientes(sem_id);
    // RPL 12-05-2020 se cambia triggeron dentro de las funciones de carga_clientes para probar 
  //  cout << NivelLog(3) << "TRIGGERON" << endl;
        
    if (todos==0)
    {
        cout <<  NivelLog(3) << "Se Procesan Todos los Codigos de Despacho y Tipos de Documentos....." << endl ;
        carga_clientes_sp( parametros.ciclo_facturacion,
                           atoi(parametros.frecuencia.c_str()),
                           sem_id,  
                           memoria[0].StParametrosEntrada.szHostId);
    }
    else if(todos==2)
    {
        cout <<  NivelLog(3) << "Se Procesa el Tipo de Documento  :" << parametros.cod_tipdocum << endl;
        cout <<  NivelLog(3) << "Se Procesa el Codigo de Despacho :" << parametros.cod_despacho << endl;
        carga_clientes_cp( parametros.ciclo_facturacion,
                           memoria[0].StParametrosEntrada.iCodTipDocum,
                           parametros.cod_despacho,
                           atoi(parametros.frecuencia.c_str()),
                           sem_id, 
                           memoria[0].StParametrosEntrada.szHostId);
    }
    

  
    int flag_salida=0;

    cout << NivelLog(5) <<"SALIO DE CARGA CLIENTES" << endl;
    cout << NivelLog(5) <<"total_regs : " << total_regs << endl;
    
    //RPL PROY CSR 15-07-2020 POR PROBLEMA EN PRUEBAS CON LA OPERADORA SE DEJA ACA TRIGGERON
    cout << NivelLog(3) << "TRIGGERON" << endl;
    
    while(flag_salida==0)
    {
        int clibres=0;
        int cImpresos=0;
        int cPendientes=0;
        int cError=0;
        /* RPL SE CAMBIA A SLEEP 10*/
        sleep(10);
        chequea_tiempos(memoria[0].StParametrosEntrada.szHostId);
       /* RPL 22-04-2020 SE QUITA FUNCION borra_facturados de aca */
       // borra_facturados(sem_id);
        
        clibres=cuenta_libres();
        cout <<  NivelLog(3) << "Documentos que faltan por imprimir: " << clibres << endl;
        /* RPL 15062020 SE AGREGA VARIABLE QUE MUESTRA LOS REGISTROS YA IMPRESOS Y LOS QUE FALTAN  */
        
        cPendientes=cuenta_pendientes();
        cout <<  NivelLog(3) << "Documentos pendientes en impresion: " << cPendientes << endl;
        
        cImpresos=cuenta_facturados();
        cout <<  NivelLog(3) << "Documentos ya impresos: " << cImpresos << endl;
        // RPL 04-08-2020 SE AGREGA VARIABLE PARA GUARDAR DOCUMENTOS CON ERROR 
        cError=cuenta_erroneos();
        cout <<  NivelLog(3) << "Documentos con Error: " << cError << endl;

        cout <<  NivelLog(3) << "Total a imprimir: " << total_regs << endl;

        if((cImpresos+cError)==total_regs)
        {
            cout << NivelLog(3) << "No hay mas datos en Memoria Compartida  " << clibres << endl;
            flag_salida=1;
            memoria[0].flag_proceso=0;
        }
    }
    if (todos==0)
    {
        cout <<  NivelLog(3) << "Se ACTUALIZAN Todos los Codigos de Despacho y Tipos de Documentos....." << endl ;
        actualiza_faprocimpresion(parametros.ciclo_facturacion,1,2,memoria[0].StParametrosEntrada.szHostId);
    }
    else if(todos==2)
    { 
        cout <<  NivelLog(3) << "Se ACTUALIZA el Tipo de Documento  :" << parametros.cod_tipdocum << endl;
        cout <<  NivelLog(3) << "Se ACTUALIZA el Codigo de Despacho :" << parametros.cod_despacho << endl;
        actualiza_faprocimpresion_cp(parametros.ciclo_facturacion,atoi(parametros.cod_tipdocum.c_str()),parametros.cod_despacho,1,2,memoria[0].StParametrosEntrada.szHostId);
    }
    db.commit();
    logout();
    cout <<  NivelLog(3) << "Cantidad de Clientes Facturados : " << cuenta_facturados() << endl;
    destruir_semaforo(sem_id);
    destroy_memory(ret_clientes);
    destroy_memory(ret_codcli);
    destroy_memory(ret_numorden);
    //RPL probando 12-05-2020 se borra memoria faltante cuando termina de ejecutar
    destroy_memory(ret);
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
