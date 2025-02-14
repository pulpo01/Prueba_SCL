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
#include <cstring>
#include "concatenador.h"
#include "NivelLog.h"

using namespace std;

int NivelLog::actuallevel=1;
bool NivelLog::yaactual=false;
struct sembuf operaciones[1];

int h=0;

long lNroJob=0;
string szNroJob;

int iCOD_PROCESO = NRO_COD_PROCESO ;

string g_strFechaActual;
int g_strHostId;
long g_Cod_CiclFact;



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
        //actuallevel = NivelLog::ObtieneNivelLog();
        std::cout << "################################################################################" << std::endl
                  << "# Nivel de log Actual: " << actuallevel << "                                                       #" << std::endl
                  << "# Para cambiar nivel de log actual, utilice la opcion -l con otro nivel        #" << std::endl
                  << "################################################################################" << std::endl;
        NivelLog::SetActual(true);
    }

    if (n.level <= actuallevel){
        time_t secs_now;
        char str[22]="";
        string strCad;

        tzset();
        time(&secs_now);
        strftime(str, 21, "%Y%m%d %H:%M:%S # ", localtime(&secs_now));

		strCad=str;

		os << strCad;

        return os;
    }

    static std::ostringstream aux;
    return aux;
}

int login(char * user)
{
  try
  {
  otl_connect::otl_initialize();
  cout << NivelLog(3) << "user : " << user << endl;
  db.rlogon(user);
  cout << NivelLog(3) << "Login y Password Correctos" << endl;
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
  cout << NivelLog(3) << "Desconectandose de la Base de Datos" << endl;
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

int tasa_de_refresco()
{
try
{
   cout << NivelLog(3) << "EXTRAYENDO TASA DE REFRESCO." << endl;
   long salida=0;
   otl_nocommit_stream qry(1024, "SELECT nvl(VAL_NUMERICO,500) "
                                 "  FROM FAD_PARAMETROS        "
                                 " WHERE COD_PARAMETRO = 203   "
                                 "   AND COD_MODULO = 'FA'     "
                                 "   AND DES_PARAMETRO = 'IMP_NRO_MAX_CLIENTES_ARCHTMP'" ,db);
   qry >> salida;
   cout << NivelLog(3) << "TASA DE REFRESCO : " << salida << endl;
   return salida;
}
catch(otl_exception& error)
{
   cerr << error.msg << endl;
   cerr << error.stm_text << endl;
   cerr << error.var_info<< endl;
}
}



string strObtenerFechaSistema(void)
{

	time_t secs_now;
	char str[22];
	string strCad;

	tzset();
	time(&secs_now);
	strftime(str, 21, "%Y%m%d%H%M%S", localtime(&secs_now));

    strCad = str;

    return strCad;

}


void genera_arch_detalles(int tip_documento,const string& despacho,const string& directorio)
{
try
{
   ostringstream aux1 ;
   ostringstream aux2;
   string  szhDesc_MensLin ;
   int     ihCorr_Mensaje ;
   string  ihNum_Linea ;
   int     ihCant_Caract ;
   string  ihCodIdioma ;
   ofstream fp;
   ostringstream sCicloFact;
   //string  strHostId;
   ostringstream  strHostId;

   aux1 << tip_documento ;
   sCicloFact << g_Cod_CiclFact;
   //strHostId = g_strHostId;
   strHostId << g_strHostId;

   string filename = directorio + "/DetMsg_" + aux1.str() + "_" + despacho + "_" + sCicloFact.str() +"_" + strHostId.str() + "_" + g_strFechaActual  +".dat";



   fp.open(filename.c_str(), ofstream::out | ofstream::app);
   if (!fp)
   {
       cout << NivelLog(3) << "No se puede abrir archivo de salida DETALLE DE MENSAJES" << filename << endl;
       exit(0);
   }

   cout << NivelLog(3) << "GENERA ARCHIVO CON DETALLES" << endl;
   string qry = "    SELECT B.CORR_MENSAJE, "
                "           B.NUM_LINEA, "
                "           C.CANT_CARACTLIN, "
                "           SUBSTR(B.DESC_MENSLIN,1,132), "
                "           B.COD_IDIOMA "
                "     FROM FA_PARMENSAJE C , "
                "          FA_MENSAJES B , "
                "     (SELECT UNIQUE CORR_MENSAJE, NUM_LINEAS, COD_BLOQUE,IND_FACTURADO, COD_FORMULARIO "
                "        FROM FA_MENSCICLO "
                "       WHERE COD_FORMULARIO > 0  AND COD_CLIENTE > 0 "
                "         AND COD_BLOQUE     > 0  AND CORR_MENSAJE > 0 "
                "         AND COD_ORIGEN IS NOT NULL) A "
                "       WHERE A.IND_FACTURADO  = 'I' "
                "         AND A.COD_FORMULARIO = " + aux1.str() + " "
                "         AND A.CORR_MENSAJE   = B.CORR_MENSAJE "
                "         AND A.COD_FORMULARIO = C.COD_FORMULARIO "
                "         AND A.COD_BLOQUE     = C.COD_BLOQUE "
                "       ORDER BY B.CORR_MENSAJE, B.NUM_LINEA";
  otl_nocommit_stream detalle(16384, qry.c_str(),db);
  //ihCorr_Mensaje[i],ihNum_Linea[i],ihCant_Caract[i],szCodIdioma,szhDesc_MensLin[i]
  while (!detalle.eof())
  {
    detalle >> ihCorr_Mensaje >> ihNum_Linea >> ihCant_Caract >> szhDesc_MensLin >> ihCodIdioma;
    ostringstream aux5;
    aux5 << setw(5) << setfill('0') << left << ihCodIdioma;
    fp << setw(8) << setfill('0') << ihCorr_Mensaje;
    fp << setw(2) << setfill('0') << ihNum_Linea;
    fp << setw(3) << setfill('0') << ihCant_Caract;
    fp << aux5.str();
    fp << " " << szhDesc_MensLin << endl;
  }
  fp.close();
}
catch(otl_exception& error)
{
   cerr << error.msg << endl;
   cerr << error.stm_text << endl;
   cerr << error.var_info<< endl;
}
}




void trae_llaves(int ciclo_facturacion)
{
    try
    {
       long cuotas=0;
       long pagar=0;
       long saldoant=0;
       string ciclo;
       string qry;
       ostringstream aux1;
       aux1 << ciclo_facturacion ;
       ciclo = aux1.str();
       int i=0;
       cout << NivelLog(3) << "LLAVES DE FACTURACION." << endl;

       if( !lNroJob )
       {
   		  qry = "SELECT   distinct A.COD_TIPDOCUM, NVL(A.COD_DESPACHO,'DESNO')"
                "  FROM   FA_FACTDOCU_" + ciclo + " A, "
                "         FA_TIPDOCUMEN  B "
                " WHERE   A.TOT_FACTURA   >= 0 "
                "    AND  A.NUM_FOLIO     >= 0 "
                "    AND  A.IND_SUPERTEL   = 0 "
                "    AND  A.IND_ANULADA    = 0 "
                "    AND  A.IND_FACTUR     = 1 "
                "    AND  A.IND_IMPRESA    = 1 "
                "    AND  A.COD_TIPDOCUM   = B.COD_TIPDOCUMMOV ";
	  }else{
   		  qry = "SELECT   distinct A.COD_TIPDOCUM, NVL(A.COD_DESPACHO,'DESNO')"
                "  FROM   FA_FACTDOCU_" + ciclo + "_" + szNroJob + " A, "
                "         FA_TIPDOCUMEN  B "
                " WHERE   A.TOT_FACTURA   >= 0 "
                "    AND  A.NUM_FOLIO     >= 0 "
                "    AND  A.IND_SUPERTEL   = 0 "
                "    AND  A.IND_ANULADA    = 0 "
                "    AND  A.IND_FACTUR     = 1 "
                "    AND  A.IND_IMPRESA    = 1 "
                "    AND  A.COD_TIPDOCUM   = B.COD_TIPDOCUMMOV ";

	  }
      otl_nocommit_stream parm(16384, qry.c_str(),db);
      while (!parm.eof())
      {
        string archivo;
        ostringstream aux2;
        ostringstream sCicloFact;
        //string strHostId;
        ostringstream strHostId;

        sCicloFact << g_Cod_CiclFact;
        //strHostId = g_strHostId;
        strHostId << g_strHostId;

        parm >> llaves[i].itipdocum >> llaves[i].szCod_Despacho;
        aux2 << setw(2) << setfill('0') << llaves[i].itipdocum ;
        archivo = dir_archivo();
        archivo = archivo + ciclo + "/ImprScl_01_" + aux2.str() + llaves[i].szCod_Despacho + "_" + sCicloFact.str()
        			+ "_" + strHostId.str() + "_" + g_strFechaActual + ".dat";
        llaves[i].szNom_Archivo = archivo;
        trae_totales(ciclo_facturacion ,llaves[i].itipdocum,llaves[i].szCod_Despacho, &cuotas , &pagar , &saldoant);
        llaves[i].tot_cuotas = cuotas;
        llaves[i].tot_pagar = pagar;
        llaves[i].tot_saldoant = saldoant;
        llaves[i].num_clientes = cuenta_cliente(ciclo_facturacion ,llaves[i].itipdocum,llaves[i].szCod_Despacho);
        i++;
      }
      nro_llaves = i;
    }
    catch(otl_exception& error)
    {
       cerr << error.msg << endl;
       cerr << error.stm_text << endl;
       cerr << error.var_info<< endl;
    }
}



void trae_totales(int ciclo_facturacion ,int tipo_documento,const string& tipo_despacho, long * tot_cuotas , long * tot_pagar , long * tot_saldoant)
{
try
    {
        string qry;
        string ciclo;
        ostringstream aux1;
        aux1 << ciclo_facturacion ;
        ciclo = aux1.str();
        int i=0;
        cout << NivelLog(3) << "SUMAS POR LLAVES." << endl;

        if( !lNroJob )
        {
	        qry = "SELECT   sum(TOT_CUOTAS),sum(TOT_PAGAR),sum(IMP_SALDOANT) "
                  "  FROM   FA_FACTDOCU_" + ciclo +
                  " WHERE   COD_TIPDOCUM = :a<int> "
                  "   AND   COD_DESPACHO = :b<char[7]> "
                  "    AND  IND_IMPRESA    = 1 ";
		}else{
	        qry = "SELECT   sum(TOT_CUOTAS),sum(TOT_PAGAR),sum(IMP_SALDOANT) "
                  "  FROM   FA_FACTDOCU_" + ciclo + "_" + szNroJob +
                  " WHERE   COD_TIPDOCUM = :a<int> "
                  "   AND   COD_DESPACHO = :b<char[7]> "
                  "    AND  IND_IMPRESA    = 1 ";
		}
        otl_nocommit_stream parm(16384, qry.c_str(),db);
        parm << tipo_documento << tipo_despacho ;
        parm >> *tot_cuotas >> *tot_pagar >> *tot_saldoant;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
    }
}


int cuenta_cliente(int ciclo_facturacion ,int tipo_documento,const string& tipo_despacho)
{
    try
    {
        string ciclo;
        string qry;
        ostringstream aux1;
        aux1 << ciclo_facturacion ;
        ciclo = aux1.str();
        int i=0;
        cout << NivelLog(3) << "CUENTA CLIENTES POR LLAVES." << endl;

        if( !lNroJob )
        {
        	qry = "SELECT   COUNT(1) "
                  "  FROM   FA_FACTDOCU_" + ciclo +
                  " WHERE   COD_TIPDOCUM = :a<int> "
                  "   AND   COD_DESPACHO = :b<char[7]> "
                  "   AND   IND_IMPRESA    = 1 ";
        }else{
        	qry = "SELECT   COUNT(1) "
                  "  FROM   FA_FACTDOCU_" + ciclo + "_" + szNroJob +
                  " WHERE   COD_TIPDOCUM = :a<int> "
                  "   AND   COD_DESPACHO = :b<char[7]> "
                  "   AND   IND_IMPRESA    = 1 ";
        }
        otl_nocommit_stream parm(16384, qry.c_str(),db);
        parm << tipo_documento << tipo_despacho ;
        parm >> i;
        return i ;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
    }
}



string trae_secuencial()
{
    try
    {
        string secuencial;
        cout << NivelLog(3) << "LLAVES DE FACTURACION." << endl;
        otl_nocommit_stream sec(16384,"SELECT ltrim(rtrim(FA_SEQ_CTLINFORMES.NEXTVAL)) FROM DUAL",db);
        sec >> secuencial ;
        return secuencial;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
    }
}


int update_fadocuclie(const string& szupdate)
{
    try
    {
        cout << NivelLog(3) << "ACTUALIZANDO GRUPO DE CLIENTES...." << endl;
        string qry = szupdate;
        cout << NivelLog(3)<< "QUERY : " << qry << endl;
        otl_nocommit_stream qry2(16384, qry.c_str(),db);
        return 0 ;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
        return 1 ;
    }
}

string dir_archivo()
{
    string directorio;
    if(getenv("XPF_DAT"))
    {
        directorio = getenv("XPF_DAT");
    }

    if( !lNroJob )
    {
    	directorio = directorio + "/ImpresionScl/ciclo/";
    }else{
		directorio = directorio + "/" + szNroJob + "/ImpresionScl/ciclo/";
	}

    return directorio;
}


int Cuenta_Impresores_con_psx()
{
	char cmd[99];
	char buf[5000];
	FILE *ptr;
	int cnt=0;

	strcpy(cmd, "ps -fea|grep -w 'ImpresionScl '|grep -v grep| wc -l");
	if ((ptr = popen(cmd, "r")) != NULL)
	{
		fgets(buf, 5000, ptr);
	  cnt = atoi(buf);
	}
	/*
	if ((ptr = popen(cmd, "r")) != NULL)
	{
			while (fgets(buf, 5000, ptr) != NULL)
			{
				cnt++;
			}
	}
	*/
	pclose(ptr);
	return(cnt);
}

int fn_cuenta_archivos(const string& directorio)
{
	char * cmd;
	string cmd2;
	char buf[5000];
	FILE *ptr;
	int cnt=0;

	cmd2.clear();
	cmd2 = "cd " + directorio + "; du -a . |egrep 'ImpScl_02_.*\\.tmp|ImpScl_02_.*\\.err' |awk '{if (length($2) > 31  && length($2) < 35) {print substr($2, 3);}}'|wc -l";
	
	cmd = new char [cmd2.size()+1];
	strcpy (cmd, cmd2.c_str());

	if ((ptr = popen(cmd, "r")) != NULL)
	{
			
			fgets(buf, 5000, ptr);
			cnt = atoi(buf);
/*			
			while (fgets(buf, 5000, ptr) != NULL)
			{
				cnt++;
			}
*/
	}
	pclose(ptr);
	return(cnt);
}



void concatenar(const string& directorio, int intervalo_paso)
{
    int i=1;
    int iMalo;
    int bueno;




    string filename;
    string borra_archivo;
    string ruta;
    string filename_a_concat;
    string borra_archivo_concatenar;
    string rescato_archivos_tmp;
    ostringstream aux;
    string ruta2;
    string texto;
		ifstream file_a_leer;  //declaro archivo como lectura
		string privilegios_archivo;
    string elimina_archivos;
    string coddespacho;
    char Cod_DespachoAux[6];
    int codtipdocum;
		string extension;
		size_t pos;
    ofstream fp;
    char * cstr, *p;
   /* RPL se agrega hAux 20-04-2020  */
    int hAux=0;

    filename.clear();
    filename = "borra_archivos_tmp.txt";

    borra_archivo.clear();
    borra_archivo = "rm -f " + directorio + "/" + filename;
    system(borra_archivo.c_str());



    ruta.clear();
    ruta = directorio + "/" + filename;

    fp.open(ruta.c_str(), ofstream::out | ofstream::app);   // aca se almacenan los nombres de los archivos .tmp que se eliminaran
    if (!fp)
    {
        cout << NivelLog(3) << "No se puede abrir archivo de salida " << filename << endl;
        exit(0);
    }
    cout << NivelLog(3) << "ARCHIVO DE ESCRITURA ABIERTO: " << ruta << endl;

    filename_a_concat.clear();
    filename_a_concat = "a_concatenar.txt";

    borra_archivo_concatenar.clear();
    borra_archivo_concatenar = "rm -f " + directorio + "/" + filename_a_concat;
    system(borra_archivo_concatenar.c_str());

    aux.clear();
    aux << intervalo_paso;

   	rescato_archivos_tmp.clear();
   	rescato_archivos_tmp  = "cd ";
   	rescato_archivos_tmp += directorio;
   	/*rescato_archivos_tmp += "; ls -1t Imp*.tmp Imp*.err | tail -";*/
   	rescato_archivos_tmp += "; du -a . |egrep 'ImpScl_02_.*\\.tmp|ImpScl_02_.*\\.err' |awk '{if (length($2) > 31  && length($2) < 35) {print substr($2, 3);}}'| head -";
   	rescato_archivos_tmp += (string)aux.str();
   	rescato_archivos_tmp += " > ";
   	rescato_archivos_tmp += filename_a_concat;

   	cout << NivelLog(3) << "Instruccion :" << rescato_archivos_tmp << endl;

    system(rescato_archivos_tmp.c_str());

    ruta2.clear();
    ruta2 = directorio + "/" + filename_a_concat;
 
 /* RPL 07-04-2020 probando cambio de funcion */
		//file_a_leer.open(ruta2.c_str(), ios::noreplace);  //abre archivo a_concatenar.txt
		file_a_leer.open(ruta2.c_str(), ios_base::out);  //abre archivo a_concatenar.txt	
    if (!file_a_leer)
    {
        cout << NivelLog(3) << "No se puede abrir archivo :" << filename_a_concat << endl;
        exit(0);
    }

    cout << NivelLog(3) << "ARCHIVO DE LECTURA ABIERTO: " << ruta2 << endl;

		while(!file_a_leer.eof())
		{
				texto.clear();
				getline(file_a_leer,texto);

				if (strcmp(texto.c_str(),"") == 0)
    			continue;

				cout << NivelLog(3) << "Archivo [" << texto << "]" << endl;

			  cstr = new char [texto.size()+1];
			  strcpy (cstr, texto.c_str());
			  
			  cout << NivelLog(3) << "cstr [" << cstr << "]" << endl;

			  coddespacho.clear();
			  codtipdocum = 0;
   		 	//cout << NivelLog(3) << "coddespacho [" << coddespacho << "]" << endl;
    		//cout << NivelLog(3) << "codtipdocum [" << codtipdocum << "]" << endl;

				
				p = (char *) malloc(sizeof(20));
				
				memset(p, 0, sizeof(p));
				
			  p=strtok (cstr,"_");
			  i = 1;
			  while (p!=NULL)
			  {
			  	if (i == 2)
			    	codtipdocum = atoi(p);
			  	if (i == 3)
			  	{
			  		coddespacho.clear();
			  		coddespacho = p;
			  	}
			  	i++;
			    p=strtok(NULL,"_");
			  }

			  delete[] cstr;


			  pos = texto.find(".");

			  extension.clear();
			  extension = texto.substr(pos + 1);

				if (strcmp(extension.c_str(),"tmp") == 0)
    			bueno = 0;
    		else
    		  bueno = 1;

        escribe_archivo_tiempo();

        ostringstream aux2;
        aux2.clear();
        aux2 << "cat " << directorio + "/" + texto << " ";
        iMalo=0;

        if (bueno==0)
        {
        	
        		cout << NivelLog(3) << "RPL bueno== 0 valor aux2: [" << aux2 << "]" << endl;

            aux2 << " >> " << directorio << "/ImprScl_01_" << codtipdocum << "_" << coddespacho
            	 << "_" << g_Cod_CiclFact << "_" << g_strHostId  << "_" << g_strFechaActual << ".dat";
            	 
						strcpy(Cod_DespachoAux,"");
						strncpy(Cod_DespachoAux, coddespacho.c_str(),strlen(coddespacho.c_str()));
						cout << NivelLog(6) << "RPL Cod_DespachoAux 1: [" << Cod_DespachoAux << "]" << endl;
						
						cout << NivelLog(6) << "RPL strlen(coddespacho.c_str()): [" << strlen(coddespacho.c_str()) << "]" << endl;       		
            cout << NivelLog(6) << "RPL coddespacho.c_str(): [" << coddespacho.c_str() << "]" << endl;
						
						strcpy(Cod_DespachoAux,coddespacho.c_str());
						
						cout << NivelLog(6) << "RPL Cod_DespachoAux 2: [" << Cod_DespachoAux << "]" << endl;

						
				    if (h == 0)
			    	{
			      		mi_conjunto[h].itipdocum = codtipdocum;
			      		strncpy(mi_conjunto[h].szCod_Despacho, coddespacho.c_str(),strlen(coddespacho.c_str()));
//			      		cout << NivelLog(3) << "IF 0" << endl;
			      		h++;
			      		/*	RPL PRUEBA VALOR h 20-04-2020 */
			    	cout << NivelLog(6) << "RPL VALOR DE h dentro h == 0: [" << h << "]" << endl;
			    	
			    	}
			    	
			    /*	RPL PRUEBA VALOR h 20-04-2020 */
			    	cout << NivelLog(6) << "RPL VALOR DE h: [" << h << "]" << endl;
			    	
			    	/* RPL SE AGREGA VALIDACION QUE h aumente de 1 en 1 PARA PRUEBA*/
			    /*
			    	hAux=h;
			    	
			    	if (hAux!=h+1 && hAux>0){
			    		
			    		cout << NivelLog(3) << "VALIDACION RPL VALOR DE h: [" << h << "]" << endl;
			    		cout << NivelLog(3) << "VALIDACION RPL VALOR DE hAux: [" << hAux << "]" << endl;
			    		
			    		h=hAux+1;
			    					    		
			    		cout << NivelLog(3) << "VALIDACION RPL INCREMENTO NO CORRESPONDE, SE REASIGNA VALOR DE h : [" << h << "]" << endl;		
				
			    	} */


            int x;
            int sw=0;
            for (x=0; x < h ; x++)
            {
            		/* AQUI VOY  ---> falta compilar y volver a probar !!!! */
            	  cout << NivelLog(3) << "ACHE [" << h << "]" << endl;

	            	cout << NivelLog(3) << "codtipdocum [" << codtipdocum << "]" <<endl;
	            	/* RPL Cod_DespachoAux esta malo hay que arreglarlo y dejar el valor sin basura para que funcione, esto se corrige cuando se asigna el valor */
	            	cout << NivelLog(3) << "Cod_DespachoAux [" << Cod_DespachoAux << "]" <<endl;

	            	cout << NivelLog(3) << "mi_conjunto[x].itipdocum [" << mi_conjunto[x].itipdocum << "]" << endl;
	            	cout << NivelLog(3) << "mi_conjunto[x].szCod_Despacho [" <<  mi_conjunto[x].szCod_Despacho << "]" << endl;
	            	cout << NivelLog(3) << "---------------------- x = [" << x << "]----------------------" << endl;

	            	if ((codtipdocum == mi_conjunto[x].itipdocum) && (strcmp(Cod_DespachoAux, mi_conjunto[x].szCod_Despacho)==0))
	            	{
	            		  cout << NivelLog(3) << "IF --> sw=1" << endl;
	            			sw = 1;
	            			break;
	            	}
            }

          	if (sw == 0)
          	{
								mi_conjunto[h].itipdocum = codtipdocum;
            		strncpy(mi_conjunto[h].szCod_Despacho, coddespacho.c_str(),strlen(coddespacho.c_str()));
            		cout << NivelLog(3) << "IF --> sw=0" << endl;
            		h++;
            		cout << NivelLog(6) << "RPL VALOR DE h sw==0 : [" << h << "]" << endl;
          	}
          	            
        }
        else if (bueno==1)
        {
            aux2 << " >> " << directorio << "/ImprScl_01_" << codtipdocum << "_" << coddespacho
            	 << "_" << g_Cod_CiclFact << "_" << g_strHostId << ".err";
            iMalo=1;
        }

        string comando;
        comando.clear();
        comando = "";
        comando = aux2.str();

        cout << NivelLog(3) << "COMANDO :" << comando << endl;
        int ret=system(comando.c_str());
        if (ret==0 && iMalo==0)
        {
            cout << NivelLog(3) << "CONCATENACION EXITOSA - archivo : " << texto << endl;
            fp << "rm " << texto << ";" << endl;
        }
        else
        {
        		if (ret==0)
        			fp << "rm " << texto << ";" << endl;
        		else
            	cout << NivelLog(3) << "CONCATENACION ERRONEA - archivo : " << texto << endl;
        }
		}
		file_a_leer.close();  //cierra archiv



		/* PASANDO PRIVILEGIOS DE EJECUCION A ARCHIVO .TXT CON LA ELIMINACION DE LOS ARCHIVOS QUE YA FUERON CONCATENADOS */
		privilegios_archivo.clear();
		privilegios_archivo = "chmod 777 " + directorio + "/" + filename;
		system(privilegios_archivo.c_str());

		cout << NivelLog(3) << "ASIGNANDO PRIVILEGIOS DE EJECUCION A ARCHIVO : " << privilegios_archivo << endl;

		/* ELIMINANDO LOS ARCHIVOS QUE YA FUERON CONCATENADOS */

   	elimina_archivos.clear();
   	elimina_archivos  = "cd ";
   	elimina_archivos += directorio;
   	elimina_archivos += "; . ./";
   	elimina_archivos += filename;

		int ret=system (elimina_archivos.c_str());
    if (ret==0 && iMalo==0)
    {

				cout << NivelLog(3) << "ELIMINANDO TODOS LOS ARCHIVOS .TMP CONCATENADOS : [" << ret << "]  comando -> [" << elimina_archivos << "]" << endl;
    }
    else
    {
    	  cout << NivelLog(3) << "ELIMINACION DE ARCHIVOS .TMP ERRONEA : [" << ret << "]  comando -> [" << elimina_archivos << "]" << endl;
    }

}

int escribe_archivo_tiempo()
{
    string comando;
    comando = "date +%H%M%S%d%m%Y > $XPF_TMP/tiempos_ImpScl.txt";
    system(comando.c_str());
    return 0;
}


int insert_into_FAD_CTLIMPRES(const string& secuencial)
{
    try
    {
        int i = 0 ;
        int sec = atoi(secuencial.c_str());
        otl_nocommit_stream ins(16384,"INSERT INTO FAD_CTLIMPRES(COD_INFORME,     "
                                                                "NUM_SECUINFO,    "
                                                                "COD_TIPIMPRES,   "
                                                                "COD_TIPDOCUM,    "
                                                                "COD_DESPACHO,    "
                                                                "NOM_ARCHIVO,     "
                                                                "NUM_CLIENTES,    "
                                                                "TOT_FACTURAS,    "
                                                                "TOT_CUOTAS,      "
                                                                "TOT_PAGAR,       "
                                                                "TOT_SALDOANT,    "
                                                                "TOT_LOCALES,     "
                                                                "TOT_INTERZONA,   "
                                                                "TOT_ESPECIALES,  "
                                                                "TOT_CARRIER,     "
                                                                "TOT_ROAMING,     "
                                                                "COD_ESTADO)      "
                                                         "values('IMPRES',        "
                                                                "   :a<int>,      "
                                                                "   1,            "
                                                                "   :b<int>,      "
                                                                "   :c<char[7]>,  "
                                                                "   :d<char[255]>,"
                                                                "   :e<int>,      "
                                                                "   0,            "
                                                                "   :f<double>,     "
                                                                "   :g<double>,     "
                                                                "   :h<double>,     "
                                                                "   0,            "
                                                                "   0,            "
                                                                "   0,            "
                                                                "   0,            "
                                                                "   0,            "
                                                                "   0)",db);
        for (i=0;i<nro_llaves;i++ )
        {
            cout << NivelLog(3) << "INSERTANDO LLAVES A FAD_CTLIMPRES" << endl;
            cout << NivelLog(3) << "NUM SEC INFO        :" << sec << endl;
            cout << NivelLog(3) << "TIPO DE DOCUMENTO   :" << llaves[i].itipdocum << endl;
            cout << NivelLog(3) << "CODIGO  DE DESPACHO :" << llaves[i].szCod_Despacho << endl;
            cout << NivelLog(3) << "NOMBRE ARCHIVO      :" << llaves[i].szNom_Archivo << endl;
            cout << NivelLog(3) << "NUMERO DE CLIENTES  :" << llaves[i].num_clientes   << endl;
            cout << NivelLog(3) << "TOTAL CUOTAS        :" << llaves[i].tot_cuotas << endl;
            cout << NivelLog(3) << "TOTAL A PAGAR       :" << llaves[i].tot_pagar << endl;
            cout << NivelLog(3) << "SALDO ANTERIOR      :" << llaves[i].tot_saldoant << endl;

            double cuotas =   llaves[i].tot_cuotas;
            double pagar =    llaves[i].tot_pagar;
            double saldoant = llaves[i].tot_saldoant;
            ins << sec << llaves[i].itipdocum
                << llaves[i].szCod_Despacho
                << llaves[i].szNom_Archivo
                << llaves[i].num_clientes
                << cuotas
                << pagar
                << saldoant ;
        }
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
    }
}

int update_FA_PROCIMPRESION(const string& ciclo_facturacion, const string host_id)
{
    string actualizacion;
    string consulta;
    ostringstream aux;
    int i,j;
    int ind_impresa;
    int cant_procesados;
    int cant_total;
    int  itipdocum;
    char szCod_Despacho[6];

    long lClieIni =-1L;
    long lClieFin =-1L;
    int  iExisteRango = 0;
    string szExisteRango = "0";

    try
    {
        itipdocum = 0;
        strcpy(szCod_Despacho,"");
        cout << NivelLog(3) << "FA_PROC ciclo_facturacion = ["  << ciclo_facturacion << "]" << endl;
        cout << NivelLog(3) << "FA_PROC host_id = ["  << host_id << "]" << endl;
        

        otl_nocommit_stream qryRng(512,"SELECT COD_CLIENTEINI, COD_CLIENTEFIN "
									   "FROM FA_RANGOSHOST_TO "
									   "WHERE COD_CICLFACT = :f1<char[10]> "
									   "AND HOST_ID = :f2<char[21]>"
									   ,db);

        qryRng << ciclo_facturacion << host_id;

        while (!qryRng.eof())
        {
            qryRng >> lClieIni >> lClieFin;
            iExisteRango = 1;
            szExisteRango = "1";
        }

        /* for (i=0;i<MAX_CONJUNTO;i++) */
        for (i=0;i < h;i++)
        {
						if ((itipdocum == mi_conjunto[i].itipdocum) && (strcmp(szCod_Despacho,mi_conjunto[i].szCod_Despacho)==0))
            		continue;

            cout << NivelLog(5) << " i = ["  << i << "] CONJUNTO.TIPDOCUM [" << mi_conjunto[i].itipdocum << "] - CONJUNTO.CODESPACHO [" << mi_conjunto[i].szCod_Despacho << "]" << endl;

 						itipdocum = mi_conjunto[i].itipdocum;
						strcpy(szCod_Despacho,mi_conjunto[i].szCod_Despacho);
        }

				itipdocum = 0;
        strcpy(szCod_Despacho,"");

        cout << NivelLog(5) << "Funcion update_FA_PROCIMPRESION: ClieIni: [" << lClieIni << "], ClieFin: [" << lClieFin << "]" << endl;

        /*for (i=0;i<MAX_CONJUNTO;i++) */
        for (i=0;i < h;i++)
        {
            ind_impresa     = 0;
            cant_procesados = 0;
            cant_total      = 0;

            ostringstream aux_tip_docum;
            ostringstream aux_cod_despa;
            string stip_docum("");
            string scod_despa("");

            string sdescripcion("");
            string sestado("");

            aux_tip_docum << mi_conjunto[i].itipdocum;
            aux_cod_despa << mi_conjunto[i].szCod_Despacho;

            stip_docum = aux_tip_docum.str();
            scod_despa = aux_cod_despa.str();

            if ((itipdocum == mi_conjunto[i].itipdocum) && (strcmp(szCod_Despacho,mi_conjunto[i].szCod_Despacho)==0))
                continue;

            if ((stip_docum == "") || (scod_despa == ""))
                return 0;

            consulta = "";
            /* consulta += "SELECT IND_IMPRESA,"; */ /* PGG - 169364 - 15-09-2011  */
            consulta += "SELECT COD_CICLFACT,"; /* PGG - 169364 - 15-09-2011 */
            consulta += "       COUNT(1),";

            if( !lNroJob )
            {
            	consulta += "       (SELECT COUNT(1) FROM FA_FACTDOCU_" + ciclo_facturacion;
            }else{
            	consulta += "       (SELECT COUNT(1) FROM FA_FACTDOCU_" + ciclo_facturacion + "_" + szNroJob;
            }

            consulta += "        WHERE IND_ORDENTOTAL > 0";
            consulta += "        AND COD_TIPDOCUM = " + stip_docum;
            consulta += "        AND COD_DESPACHO = '" + scod_despa + "' ";
            consulta += "        AND ((COD_CLIENTE BETWEEN :clieIni<long> AND :clieFin<long>) OR (1<>:opcRng<int>)) )";
            if( !lNroJob )
            {
	            consulta += "FROM FA_FACTDOCU_" + ciclo_facturacion;
			}else{
	            consulta += "FROM FA_FACTDOCU_" + ciclo_facturacion + "_" + szNroJob;
			}
            consulta += " WHERE IND_IMPRESA IN (1, 9) "; /* PGG - 169364 - 15-09-2011 - Se agrega el nueve */
            consulta += " AND COD_TIPDOCUM = " + stip_docum;
            consulta += " AND COD_DESPACHO = '" + scod_despa + "'";
            consulta += " AND IND_ORDENTOTAL > 0 ";
            consulta += " AND ((COD_CLIENTE BETWEEN :clieIni<long> AND :clieFin<long>) OR (1<>:opcRng<int>))";
            /* consulta += " GROUP BY IND_IMPRESA"; */ /* PGG - 169364 - 15-09-2011 */
            consulta += " GROUP BY COD_CICLFACT"; /* PGG - 169364 - 15-09-2011 - Se cambia  */

            cout << NivelLog(5) << "--------------- Consulta de Documentos Procesados por Conjunto ---------------" << endl;
            cout << NivelLog(5) << consulta << endl;

            otl_nocommit_stream qry1(1024,consulta.c_str(),db);

            qry1 << lClieIni << lClieFin << iExisteRango << lClieIni << lClieFin << iExisteRango;

            while (!qry1.eof())
            {
                qry1 >> ind_impresa >> cant_procesados >> cant_total;
                ind_impresa = 1; /* PGG - 169364 - 15-09-2011 - Se cambia  */
            }

            if (cant_total == 0)
            {
                if( !lNroJob )
                {
                	cout << NivelLog(3) << "Tabla de Ciclo: FA_FACTDOCU_" << ciclo_facturacion << " Sin Datos" << endl;
                }else{
                	cout << NivelLog(3) << "Tabla de Ciclo: FA_FACTDOCU_" << ciclo_facturacion << "_" << lNroJob << " Sin Datos" << endl;
                }

                return -1;
            }

            if (ind_impresa == 1)
            {
                if (cant_procesados == cant_total)
                {
                    sdescripcion = "SUB PROCESO TERMINO OK";
                    sestado      = "3";
                }
                else
                {
                    sdescripcion = "SUB PROCESO TERMINO NOOK";
                    sestado      = "2";
                }
            }
            else
            {
                sdescripcion = "SUB PROCESO TERMINO NOOK";
                sestado      = "2";
            }
            actualizacion = "";
            actualizacion = actualizacion + "UPDATE FA_PROCIMPRESION_TD ";
            actualizacion = actualizacion + "SET FEC_TERMINO = SYSDATE,";
            actualizacion = actualizacion + "    GLS_ESTAPROC = '" + sdescripcion + "',";
            actualizacion = actualizacion + "    COD_ESTAPROC = " + sestado;
            actualizacion = actualizacion + " WHERE COD_CICLFACT = " + ciclo_facturacion;
            actualizacion = actualizacion + " AND COD_TIPDOCUM = " + stip_docum;
            actualizacion = actualizacion + " AND COD_DESPACHO = '" + scod_despa + "'";
            actualizacion = actualizacion + " AND (HOST_ID = '" + host_id + "'  OR 1<>" + szExisteRango + ")" ;

            cout << NivelLog(5) << "--------------- Actualizacion de Documentos Procesados por Conjunto ---------------" << endl;
            cout << NivelLog(5) << actualizacion << endl;

            otl_nocommit_stream qry2(1024,actualizacion.c_str(),db);

            itipdocum = mi_conjunto[i].itipdocum;
            strcpy(szCod_Despacho,mi_conjunto[i].szCod_Despacho);
        }
        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
    }
}

int insert_into_FA_TRAZAPROC(const string& ciclo_facturacion,const string& host_id, const string& opcion)
{
    int ind_impresa;
    int cant_procesados;
    int cant_total;

    string consulta;
    string actualizacion;
    string szCod_Proceso;

    ostringstream aux;

    aux << iCOD_PROCESO;
    szCod_Proceso = aux.str();

    long lClieIni =-1L;
    long lClieFin =-1L;
    long lCodEstaproc=-1L;
    int  iExisteRango = 0;

    try
    {

/*
        otl_nocommit_stream qryRng(512,"SELECT MIN() "
									   "FROM FA_RANGOSHOST_TO "
									   "WHERE COD_CICLFACT = :f1<char[10]> "
									   "AND HOST_ID = :f2<char[21]>"
									   ,db);
*/

				cout << NivelLog(3) << "FATRAZA ciclo_facturacion =[" << ciclo_facturacion << "]" << endl;				
  			cout << NivelLog(3) << "FATRAZA host_id =[" << host_id << "]" << endl;
  			  			cout << NivelLog(3) << "opcion =[" << opcion << "]" << endl;

  			
				/* PGG - 169364 - 15-09-2011 */
				otl_nocommit_stream qryRng(512,"SELECT MIN(NVL(COD_ESTAPROC,0)) "
											"FROM FA_PROCIMPRESION_TD "
											"WHERE COD_CICLFACT = :f1<char[10]> "
											"AND ((HOST_ID = :f2<char[21]>) OR (1<> :f3<char[2]>))"
											,db);

        qryRng << ciclo_facturacion << host_id << opcion; 

        while (!qryRng.eof())
        {
            /*qryRng >> lClieIni >> lClieFin; */ /* PGG - 169364 - 15-09-2011 */
            qryRng >> lCodEstaproc; /* PGG - 169364 - 15-09-2011 */
            iExisteRango = 1;
        }

        cout << NivelLog(5) << "Funcion insert_into_FA_TRAZAPROC: lCodEstaproc =[" << lCodEstaproc << "]" << endl;


        if (lCodEstaproc == 3)
        {
            string scant_proc("");
            aux << cant_procesados;
            scant_proc = aux.str();
            
            if( !lNroJob )
            {
                actualizacion = actualizacion + "UPDATE FA_TRAZAPROC ";
                actualizacion = actualizacion + "SET COD_ESTAPROC = 3,";
                actualizacion = actualizacion + "    GLS_PROCESO = 'Proceso de Impresion Terminado OK',";
                actualizacion = actualizacion + "    FEC_TERMINO = SYSDATE,";
                actualizacion = actualizacion + "    COD_CLIENTE = 0 ";
                actualizacion = actualizacion + " WHERE COD_PROCESO = " + szCod_Proceso ;
                actualizacion = actualizacion + " AND COD_CICLFACT = " + ciclo_facturacion;
                actualizacion = actualizacion + " AND ( HOST_ID = '" + host_id + "' OR (1 <> " + opcion + "))";
      			}
      			else
      			{
             		actualizacion = "\n UPDATE FA_TRAZAPROC_JOB_TO "
                                "\n SET COD_ESTAPROC  = 3,"
                                "\n    GLS_PROCESO    = 'Proceso de Impresion Terminado OK',"
                                "\n    FEC_TERMINO    = SYSDATE,"
                                "\n    COD_CLIENTE    = 0 "
                                "\n WHERE COD_PROCESO = " + szCod_Proceso      +
                                "\n AND COD_CICLFACT  = " + ciclo_facturacion  +
                                "\n AND NUM_JOB       = " + szNroJob           +
                                "\n AND SEC_REPROCESO = (SELECT MAX(SEC_REPROCESO) FROM FA_TRAZAPROC_JOB_TO "
                                "\n                       WHERE COD_CICLFACT = " + ciclo_facturacion +
                                "\n                         AND NUM_JOB      = " + szNroJob          +
                                "\n                         AND COD_PROCESO  = " + szCod_Proceso     + " )"
                                "\n AND ( HOST_ID = '" + host_id + "' OR (1 <> " + opcion + "))";
      			}
                        
        }
        else
        {
        	if( !lNroJob )
            {
		            actualizacion = actualizacion + "UPDATE FA_TRAZAPROC ";
		            actualizacion = actualizacion + "SET COD_ESTAPROC = 2,";
		            actualizacion = actualizacion + "    GLS_PROCESO = 'Proceso de Impresion Terminado con ERROR',";
		            actualizacion = actualizacion + "    FEC_TERMINO = SYSDATE,";
		            actualizacion = actualizacion + "    COD_CLIENTE = 0 ";
		            actualizacion = actualizacion + " WHERE COD_PROCESO = " + szCod_Proceso ;
		            actualizacion = actualizacion + " AND COD_CICLFACT = " + ciclo_facturacion;
		            actualizacion = actualizacion + " AND ( HOST_ID = '" + host_id + "' OR (1 <> " + opcion + "))";
	    			}
	    			else
	    			{
                actualizacion = "\n UPDATE FA_TRAZAPROC_JOB_TO "
                                "\n SET COD_ESTAPROC  = 2,"
                                "\n     GLS_PROCESO   = 'Proceso de Impresion Terminado con ERROR',"
                                "\n     FEC_TERMINO   = SYSDATE,"
                                "\n     COD_CLIENTE   = 0 "
                                "\n WHERE COD_PROCESO = " + szCod_Proceso        +
                                "\n AND COD_CICLFACT  = " + ciclo_facturacion    +
                                "\n AND NUM_JOB       = " + szNroJob             +
                                "\n AND SEC_REPROCESO = (SELECT MAX(SEC_REPROCESO) FROM FA_TRAZAPROC_JOB_TO "
                                "\n                       WHERE COD_CICLFACT = " + ciclo_facturacion +
                                "\n                         AND NUM_JOB      = " + szNroJob          +
                                "\n                         AND COD_PROCESO  = " + szCod_Proceso     + " )"
                                "\n AND ( HOST_ID = '" + host_id + "' OR (1 <> " + opcion + "))";
	    			}
        }

        cout << NivelLog(5) << "--------------- Actualizacion de Documentos Procesados ---------------" << endl;
        cout << NivelLog(5) << actualizacion << endl;

        otl_nocommit_stream qry2(1024,actualizacion.c_str(),db);

        return 0;
    }
    catch(otl_exception& error)
    {
        cerr << error.msg << endl;
        cerr << error.stm_text << endl;
        cerr << error.var_info<< endl;
    }
}

int CheckParamEntrada(int argc, char * const argv[], ENTRADA * StParam)
{
   char        opt[]="u:c:l:j:";
   extern  char * optarg                 ;
   int         bOptUsuario             ;
   int         iOpt            =0      ;

   //memset(StParam,0,sizeof(ENTRADA));

   while ((iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
            case 'j':
              /*-------------------------------------
                JOB
                -------------------------------------*/
                if(strlen (optarg))
                {
                    szNroJob ="";
                    szNroJob = (string)optarg;
                    lNroJob = atol(szNroJob.c_str());
                    iCOD_PROCESO = NRO_COD_PROCESO_JOB ;
                    cout << "### MODO SIMULACION JOB : " << lNroJob << endl;
                    cout <<  NivelLog(1) << "*********** MODO SIMULACION JOB : " << lNroJob << "**************" << endl;
                }
                break;
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
        }
    }

    return(0);
}

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



int main (int argc, char *argv[])
{
    int i = 0 ;
    int cuenta;
    int cuenta_tmp; /* PGG - AISLANDO EL CONCATENADOR - 1-08-2011 */
    int intervalo;
    string secuencia;

    string directorio;
    ostringstream aux1;

    string ciclo_facturacion;
    string host_id;
    ostringstream aux2;
    ostringstream aux3;
    ENTRADA parametros;

    string filename2;
    string borra_archivo2;
    string filename_a_concat2;
    string borra_archivo_concatenar2;
    char szHostId_Paso[20];
    int retorno;


    if(CheckParamEntrada(argc,argv,&parametros)!=0)
    {
        cout << NivelLog(1) << "Falla en Parametros de Entrada" << endl ;
        exit(0);
    }

    /* Obtener Fecha Actual */
    g_strFechaActual = strObtenerFechaSistema();
    g_Cod_CiclFact = atol(parametros.ciclo_facturacion.c_str());    
    
/* PGG - CORRIGIENDO EL NOMBRE DEL ARCHIVO .DAT	- FALTA EL HOSTID - 19-08-2011 */    
		retorno= GetHostId(szHostId_Paso);
    if (retorno == -1)
    {
        cout << NivelLog(5) << "No esta configurado Host en Directorio " << getenv("XPF_CFG") << endl;
        strcpy(szHostId_Paso,"-1");
    }
    
    g_strHostId = atoi(szHostId_Paso);

/* PGG - CORRIGIENDO EL NOMBRE DEL ARCHIVO .DAT	- FALTA EL HOSTID - 19-08-2011 */
    
//    system("export HOST_ID=`cat $XPF_CFG/host_id.dat`");
//    if(getenv("HOST_ID"))
//    {
//        g_strHostId = atoi(getenv("HOST_ID"));
//    }


    if(getenv("XPF_DAT"))
    {
        directorio = getenv("XPF_DAT");
    }

    cout << NivelLog(3) << "MODULO DE CONCATENACION" << endl;
    /*long size ;*/

    int actuallevel = atoi(parametros.nivel_de_log.c_str());

    cout << NivelLog(3) << "Nivel de Log Configurado : " << actuallevel << endl;
    NivelLog::SetNivelLog(actuallevel);

    int ret_login=login((char *)parametros.login.c_str());
    if (ret_login==1)
    {
        cout << NivelLog(3) << "FALLA CON USUARIO Y PASSWORD" << endl;
        exit(0);
    }

    intervalo=tasa_de_refresco();
    cout << NivelLog(3) << "ARMADO DIRECTORIO DE TRABAJO...." << endl;

    if( !lNroJob )
    {
        aux1 << "/ImpresionScl/ciclo/" << g_Cod_CiclFact ;
    }else{
        aux1 << "/jobs/" << lNroJob << "/ImpresionScl/ciclo/" << g_Cod_CiclFact;
    }

    directorio = directorio + aux1.str();
    cout << NivelLog(3) << "DIRECTORIO DE TRABAJO : " << directorio << endl;
    int a=0;
    memset(mi_conjunto,'\0',sizeof(CONJUNTO));
    while (a==0)
    {
				
        cout << NivelLog(3) << "CANTIDAD DE ARCHIVOS TMP y ERR : " << fn_cuenta_archivos(directorio) << endl;

        cuenta_tmp = fn_cuenta_archivos(directorio);

        escribe_archivo_tiempo();
        if ((cuenta_tmp>intervalo) || (Cuenta_Impresores_con_psx()==0))
        {
        	 /* HAY MAS DE 300 ARCHIVOS .TMP... QUE COMIENSE LA CONCATENASOUND */
            concatenar(directorio, intervalo);
        }
        if (Cuenta_Impresores_con_psx()==0)
        {
            cout << NivelLog(3) << "FIN DE CONCATENACION ADIOS" << endl;
				    cuenta_tmp = fn_cuenta_archivos(directorio);
				    escribe_archivo_tiempo();
				    concatenar(directorio, cuenta_tmp);
            a=1;
        }
    } //FIN DE WHILE

    filename2.clear();
    filename2 = "borra_archivos_tmp.txt";
    borra_archivo2.clear();
    borra_archivo2 = "rm -f " + directorio + "/" + filename2;
    system(borra_archivo2.c_str());


    filename_a_concat2.clear();
    filename_a_concat2 = "a_concatenar.txt";
    borra_archivo_concatenar2.clear();
    borra_archivo_concatenar2 = "rm -f " + directorio + "/" + filename_a_concat2;
    system(borra_archivo_concatenar2.c_str());

    trae_llaves(g_Cod_CiclFact);
    secuencia=trae_secuencial();
    for (i=0;i<nro_llaves;i++ )
    {
        genera_arch_detalles(llaves[i].itipdocum,llaves[i].szCod_Despacho,directorio);
    }

    if( !lNroJob )
    {
    	insert_into_FAD_CTLIMPRES(secuencia);
    }

    aux2 << g_Cod_CiclFact;
    aux3 << g_strHostId;

    ciclo_facturacion = aux2.str();    
    host_id = aux3.str();

    update_FA_PROCIMPRESION(ciclo_facturacion, host_id);
    
    if (host_id == "-1")
        insert_into_FA_TRAZAPROC(ciclo_facturacion,host_id,"0");
    else
        insert_into_FA_TRAZAPROC(ciclo_facturacion,host_id,"1");


    db.commit();
    logout();
}
