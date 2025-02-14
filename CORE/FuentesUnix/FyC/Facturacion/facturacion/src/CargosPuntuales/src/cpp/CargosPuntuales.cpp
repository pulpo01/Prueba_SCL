#ifndef NO_INDENT
#ident "@(#)$RCSfile: CargosPuntuales.cpp,v $ $Revision: 1.1 $ $Date: 2008/07/14 15:26:28 $"
#endif

///
/// \file dctosLoc.cpp
///

#include "hr_time_clock.h"
//#include "process_core.h"
#include "process_clock.h"
#include "Indent.h"
#include "LogBuffer.h"
//#include "cliente_locutorio_factory.h"
#include "process_controler.h"

#ifndef WIN32
#include <unistd.h>
#else
#include <process.h>
#endif

#include <fstream>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void printHelpArgInfo(int processID, const char* argv0)
{
#ifndef WIN32
        cout << "PID[" << processID << "]: " << endl;
        cout << " \t<" << argv0 << ">" << endl;
        cout << " \t-c<codCicloFact>" << endl;
#ifdef _JOB
        cout << " \t-j<numJob>" << endl;
#endif
        cout << " \t-u<[user]/[pass]>" << endl;
        cout << " \t-l<log level(0-9)>" << endl;
        cout << endl;
#else
        cout << "PID[" << processID << "]: " << endl;
        cout << " \t<" << argv0 << ">" << endl;
        cout << " \t<codCicloFact>" << endl;
#ifdef _JOB
        cout << " \t<numJob>" << endl;
#endif
        cout << " \t<[user]/[pass]@[db_sid]>" << endl;
        cout << " \t<log level(0-9)>" << endl;
        cout << endl;
#endif
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void printOutIndentInfo(char* argv, std::stringstream& str)
{
    STRING Indent;
    STRING FileName;
    STRING Revision;
    STRING Date;

    char* pChar = NULL;
    int    start = 0;
    int    end = 0;

    str << "------------------------------------VERSIONES----------------------------------------" << endl;

    while( (pChar = getIndentInfo(argv)) != NULL )
    {
        Indent = pChar;

        //\ Get FileName
        start = Indent.find((char*) " ");
        end = Indent.find((char*) ",");
        FileName = Indent.substr(start,(end-1)-start);
        Indent.erase(0,end-1);

        //\ Get Revision
        end = Indent.find((char*) "Revision:");
        Indent.erase(0,end-1);
        end = Indent.find((char*) " $");
        Revision = Indent.substr(0,end-1);
        Indent.erase(0,end-1);

        //\ Get Date
        end = Indent.find((char*) "Date:");
        Indent.erase(0,end-1);
        end = Indent.find((char*) " $");
        Date = Indent.substr(0,end-1);

        str << "[File: " << FileName << "] [" <<  Revision << "] [" << Date << "]" << endl;
    }

    str << endl;
    str << "--------------------------------------MODES-----------------------------------------" << endl;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct ProgramArguments
{
    int             _processID;
    STRING          _userAndPassword;
    int             _numJob;
    int             _logLevel;
    int             _codCicloFact;
    STRING1000      _logFileName;
    std::ofstream   _logFile;
    STRING          _processStartTime;
    LogBuffer       _logger;
    HostId			_hostId;

    ProgramArguments()
    {
        _processID = 0;
        _userAndPassword.clear();
        _numJob = -1;
        _logLevel = 9;
        _codCicloFact = -1;
        _logFileName.clear();
        _processStartTime.clear();
        _logger.clear();
    }
};


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void getArguments(int argc, char* const* argv, ProgramArguments& pArguments)
{
#ifndef WIN32

  extern char* optarg;

    char opt[]="u:c:l:j:";
    int iOpt = 0;
    while ( (iOpt=getopt(argc,argv,opt) ) !=EOF)
    {
        switch (iOpt)
        {
            case 'u':
                if ( strlen (optarg) )
                {
                    pArguments._userAndPassword.clear();
                    pArguments._userAndPassword << optarg;
                }
                break;
            case 'l':
                if ( strlen (optarg) )
                {
                    pArguments._logLevel = (atoi(optarg) > 0)?atoi(optarg) : 9;
                }
                break;
            case 'c':
                if ( strlen (optarg) )
                {
                    pArguments._codCicloFact = (atoi(optarg) > 0)?atoi(optarg) : -1;
                }
                break;
#ifdef _JOB
            case 'j':                                                          // P-COL-08012
                if ( strlen (optarg) )                                         // P-COL-08012
                {                                                              // P-COL-08012
                    pArguments._numJob = (atoi(optarg) > 0)?atoi(optarg) : -1; // P-COL-08012
                }                                                              // P-COL-08012
                break;
#endif                                                                         // P-COL-08012
            default:
                break;
        }
    }
#endif
}


void verifyDir(char* dirPath)
{
    STRING1000 tmpCommand;
    tmpCommand.clear();
    tmpCommand << "mkdir -p ";
    tmpCommand << dirPath;
    system(tmpCommand.c_str());
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
STRING1000 getLogFileName(const char* pName, ProgramArguments& pArguments)
{
    STRING1000  logPath;
    STRING      fileName;
    STRING      varEnv;

    fileName.clear();
    logPath.clear();

    fileName << pName << "_" << pArguments._processStartTime.substr(0,14) << ".log";
    varEnv.clear();
    varEnv << getEnvVar(ENV_VAR_FOR_LOGPATH);

    if(varEnv.empty())
        varEnv = ".";

    if(pArguments._numJob < 0)
    {
        logPath << varEnv << "/" << pName << "/" << pArguments._codCicloFact << "/"
                << pArguments._processStartTime.substr(0,8) << "/";
    }
    else
    {
        logPath << varEnv << "/jobs/" << pArguments._numJob << "/" << pName << "/" << pArguments._codCicloFact << "/"
                << pArguments._processStartTime.substr(0,8) << "/";
    }

#ifdef WIN32
    logPath.clear();
#else
    verifyDir(logPath.c_str());
#endif
    logPath << fileName;

    return logPath;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int main(int argc, char *argv[])
{

	cout << endl << "Modulo de Cargos Puntuales version " __DATE__ " " __TIME__ << endl << endl;
    ProgramArguments pArguments;

#ifndef WIN32
    pArguments._processID = getpid();
#else
    pArguments._processID = _getpid();
#endif

    std::stringstream indentInfo;

//    printOutIndentInfo(argv[0], indentInfo);

    cout << indentInfo.str();

    if(argc < 4)
    {
        printHelpArgInfo(pArguments._processID, argv[0]);
        return 0;
    }

    ProcessClock myclock;
    pArguments._processStartTime.clear();
    pArguments._processStartTime = myclock.sysDateyyyymmddhh24miss();

#ifdef WIN32
    pArguments._codCicloFact = atoi(argv[1]);
#ifdef _JOB
    pArguments._numJob = atoi(argv[2]);
#else
    pArguments._numJob = -1;
#endif
    pArguments._userAndPassword = argv[3];
    pArguments._logLevel = atoi(argv[4]);
#else
    getArguments(argc, argv, pArguments);
#endif

//////////////////////////////////////////////////////////////////////////////////////////

    cout << "PID[" << pArguments._processID << "]: " << endl;
    cout << "\t" << "[codCicloFact]   = [" << pArguments._codCicloFact << "]" << endl;
#ifdef _JOB
    cout << "\t" << "[numJob]         = [" << pArguments._numJob << "]" << endl;
#endif
    cout << "\t" << "[dbConnectString]= [" << pArguments._userAndPassword << "]" << endl;
    cout << "\t" << "[logLevel]       = [" << pArguments._logLevel << "]" << endl;

//////////////////////////////////////////////////////////////////////////////////////////

    cout << "Inicializando Servicio de Base de datos Principal..." << endl;

    DataService myDataService;
    myDataService.setMode(DataService::MAIN);

    try
    {
        myDataService.initializeConnDb(pArguments._userAndPassword);
    }
    catch(otl_exception& error)
    {
        cout << "ERROR INICIALIZANDO CONEXION A BASE DE DATOS:" << endl;
        cout << ": " << error.msg << endl;
        cout << ": " << error.stm_text << endl;
        cout << ": " << error.var_info<< endl;
        return 1;
    }
    catch(ProcessCoreException& error)
    {
        cout << "ERROR INICIALIZANDO CONEXION A BASE DE DATOS:" << endl;
        cout << ": " << error.what() << endl;
        cout << ": " << error.errCase() << endl;
        cout << ": " << error.errNum() << endl;
        return 1;
    }

//////////////////////////////////////////////////////////////////////////////////////////

	cout << "Verificando Ejecucion en Modalidad de Host_Id..." << endl;

	try{
		pArguments._hostId.validaHostId(&myDataService,pArguments._codCicloFact);
		cout << "HOST_ID [" << pArguments._hostId._nombre << "]";
		if (pArguments._hostId._hostIdValido){
			cout << "CLIENTE INICIAL :" << pArguments._hostId._clienteInicial << endl;
			cout << "CLIENTE FINAL   :" << pArguments._hostId._clienteFinal << endl;
		} else {
			cout << "NO CONFIGURADO " << endl;
		}
	}
	catch(otl_exception& error)
	{
		cout << "ERROR VALIDANDO EJECUCION EN HOST_ID:" << endl;
		cout << ": " << error.msg << endl;
		cout << ": [" << error.stm_text << "]" << endl;
		cout << ": " << error.var_info<< endl;

		return 0;
	}
	catch(ProcessCoreException& error)
	{
		cout << "NO SE HA PODIDO VALIDANDO EJECUCION EN HOST_ID:" << endl;
		cout << ": " << error.what() << endl;
		cout << ": " << error.errCase() << endl;
		cout << ": " << error.errNum() << endl;

		return 0;
	}

//////////////////////////////////////////////////////////////////////////////////////////

	ProcessControler controler;

//    cout << "Verificando Inicio de Ejeccion segun scheduling de proceso..." << endl;

    try
    {
    	controler.init(&myDataService,
						COD_PROCESS_CARGOSPUNTUALES,
					    pArguments._numJob,
					    pArguments._codCicloFact,
					    &pArguments._hostId);
        controler.iniciaProceso();
    }
    catch(otl_exception& error)
    {
        cout << "ERROR VERIFICANDO SCHEDULING DE PROCESO:" << endl;
        cout << ": " << error.msg << endl;
        cout << ": " << error.stm_text << endl;
        cout << ": " << error.var_info<< endl;

        return 0;
    }
    catch(ProcessCoreException& error)
    {
        cout << "NO SE HA PODIDO INICIAR PROCESO:" << endl;
        cout << ": " << error.what() << endl;
        cout << ": " << error.errCase() << endl;
        cout << ": " << error.errNum() << endl;

        return 0;
    }

    cout << "Proceso OK para ejecucion..." << endl;


//////////////////////////////////////////////////////////////////////////////////////////
    pArguments._logFileName.clear();

    pArguments._logFileName = getLogFileName("CargosPuntuales", pArguments);

    cout << "Creando Archivo de Log: [" << pArguments._logFileName << "]..." << endl;

    pArguments._logFile.open(pArguments._logFileName.c_str(), std::ofstream::out);

    if(!pArguments._logFile.is_open())
    {
        cout << "No se pudo crear archivo de Log: [" << pArguments._logFileName << "]..." << endl;
        return 0;
    }

    pArguments._logFile << indentInfo.str();

	pArguments._logFile << endl << "Modulo de Cargos Puntuales version " __DATE__ " " __TIME__ << endl << endl;
    pArguments._logFile << "PID[" << pArguments._processID << "]: " << endl;
    pArguments._logFile << "\t" << "[codCicloFact]   = [" << pArguments._codCicloFact << "]" << endl;
#ifdef _JOB
//    pArguments._logFile << "\t" << "[numJob]         = [" << pArguments._numJob << "]" << endl;
#endif
    pArguments._logFile << "\t" << "[dbConnectString]= [" << pArguments._userAndPassword << "]" << endl;
    pArguments._logFile << "\t" << "[logLevel]       = [" << pArguments._logLevel << "]" << endl;

    if (pArguments._logLevel > 4)
    {
    	pArguments._logFile << "CONSULTAS A BASE DE DATOS " << endl;
        pArguments._logFile << "CONSULTA CARGOS PUNTUALES = [" << QUERY_FA_CARGOSERVPUNTUAL_TO << "]" << endl << endl;
        pArguments._logFile << "CONSULTA ABONADOS FISICOS = [" << QUERY_ABONADOS_INDENT_TRIBSINDESPA << "]" << endl << endl;
        pArguments._logFile << "CONSULTA ABONADOS ELECTR  = [" << QUERY_ABONADOS_INDENT_TRIBCONDESPA << "]" << endl << endl;
        pArguments._logFile << "CONSULTA SERVICIOS        = [" << QUERY_SERVSUPLABO_CICLFACT << "]" << endl << endl << endl;
	}

//////////////////////////////////////////////////////////////////////////////////////////

    pArguments._logger.level(pArguments._logLevel);


    STRING cod_despacho;
    cod_despacho.clear();

    STRING cod_serv_predef;
    cod_serv_predef.clear();

    //\Try Principal
    try
    {
        int cont_true           = 0;
        int cont_false          = 0;
        long numero_insertados  = 0;
        long numero_fallidos    = 0;
        long updates_ok         = 0;
        long updates_nook       = 0;

        //Obteniendo Arrglo de FA_CICLFACT
        pArguments._logger << "VALIDACION CICLO DE FACTURACION [" << pArguments._codCicloFact << "]" << ENDLLOGGER;

        RECORD_FA_CICLFACT_DTO info_ciclfact;
        info_ciclfact.clear();
        info_ciclfact = myDataService.select_FA_CICLFACT(pArguments._codCicloFact, 1);

        pArguments._logger << "\tCODIGO DE CICLO  :[" << info_ciclfact.COD_CICLO << "]" << ENDLLOGGER;
        pArguments._logger << "\tFECHA DE EMISION :[" << info_ciclfact.FEC_EMISION << "]" << ENDLLOGGER;

        //Obteniendo cod_despacho
        cod_despacho=myDataService.select_FA_PARAMETROS_SIMPLES_VW(PAR_GEN_COD_DESPACHO_ELECTR);
        pArguments._logger << "\tCODIGO DE DESPACHO ELECTRONICO :[" << cod_despacho << "]" << ENDLLOGGER;

        //Obteniendo PARAM_SERV_DEFAULT
        cod_serv_predef=myDataService.select_FA_PARAMETROS_SIMPLES_VW(PAR_GEN_COD_SERV_DEFAULT);
        pArguments._logger << "\tCODIGO DE SS BASE :[" << cod_serv_predef << "]" << ENDLLOGGER;

        //Obteniendo Arrglo de FA_CARGOSERVPUNTUAL_TO
        vector <RECORD_FA_CARGOSERVPUNTUAL_TO> vec_cargos_puntuales;
        vec_cargos_puntuales.clear();
        vec_cargos_puntuales = myDataService.select_FA_CARGOSERVPUNTUAL_TO(cod_despacho);

        HighResolutionClock hrClock;
        hrClock.markStart();
        for(unsigned int i=0 ; i<vec_cargos_puntuales.size() ; i++)
        {
            vector <RECORD_CLIENTE_ABONADO> _my_cliente_abonado;
            _my_cliente_abonado.clear();
             //Cargando en memoria Cliente y Abonado

            pArguments._logger << "BUSCANDO CLIENTES PARA EL CARGO PUNTUAL :" << ENDLLOGGER;
            pArguments._logger << "\tCOD_TIPIDENT  :[" << vec_cargos_puntuales[i].COD_TIPIDENT << "]" << ENDLLOGGER;
            pArguments._logger << "\tCOD_SERVICIO  :[" << vec_cargos_puntuales[i].COD_SERVICIO << "]" << ENDLLOGGER;
            pArguments._logger << "\tIND. TIPO DE DISTRIBUCION :[" << vec_cargos_puntuales[i].IND_FACTURAELECTRONICA << "]" << ENDLLOGGER;
            pArguments._logger << "\tcodCicloFact  :[" << pArguments._codCicloFact << "]" << ENDLLOGGER;
            pArguments._logger << "\tCOD_CICLO     :[" << info_ciclfact.COD_CICLO << "]" << ENDLLOGGER;
            pArguments._logger << "\tFEC_EMISION   :[" << info_ciclfact.FEC_EMISION << "]" << ENDLLOGGER;
            pArguments._logger << "\tcod_despacho  :[" << cod_despacho << "]" << ENDLLOGGER;
            pArguments._logger << "\thostIdValido  :[" << pArguments._hostId._hostIdValido << "]" << ENDLLOGGER;
            pArguments._logger << "\tclienteInicial:[" << pArguments._hostId._clienteInicial << "]" << ENDLLOGGER;
            pArguments._logger << "\tclienteFinal  :[" << pArguments._hostId._clienteFinal << "]" << ENDLLOGGER;
            pArguments._logger << "\tFEC_DESDELLAM :[" << info_ciclfact.FEC_DESDELLAM << "]" << ENDLLOGGER;

            _my_cliente_abonado = myDataService.select_ABONADOS_INDENT( pArguments._codCicloFact,
                                                                        info_ciclfact.COD_CICLO,
                                                                        info_ciclfact.FEC_EMISION,
                                                                        vec_cargos_puntuales[i].COD_TIPIDENT,
                                                                        cod_despacho,
                                                                        vec_cargos_puntuales[i].COD_SERVICIO,
                                                                        vec_cargos_puntuales[i].IND_FACTURAELECTRONICA,
                                                                        pArguments._hostId._hostIdValido,
                                                                        pArguments._hostId._clienteInicial,
                                                                        pArguments._hostId._clienteFinal,
                                                                        info_ciclfact.FEC_DESDELLAM);/*P-COL-08013 MAC*/

            pArguments._logger << "\tCANTIDAD DE REGISTROS OBTENIDOS : [" << (int)_my_cliente_abonado.size() << "]" << ENDLLOGGER;

            for(unsigned int j=0 ;j<_my_cliente_abonado.size();j++)
            {
            	if (pArguments._logLevel > 4)
            	{
                	pArguments._logger << "\tVALIDANDO CLIENTE :[" << _my_cliente_abonado[j].COD_CLIENTE << "]" << ENDLLOGGER;
                	pArguments._logger << "\t\tABONADO  :[" << _my_cliente_abonado[j].NUM_ABONADO << "]" << ENDLLOGGER;
                	pArguments._logger << "\t\tSERVICIO :[" << vec_cargos_puntuales[i].COD_SERVICIO << "]" << ENDLLOGGER;
                	pArguments._logger << "\t\tBLOQUEO  :[" << _my_cliente_abonado[j].IND_BLOQUEO << "]" << ENDLLOGGER;/*P-COL-08013 MAC*/
				}
                bool resp;
				                
            	 if (_my_cliente_abonado[j].IND_BLOQUEO == 0 ) /*P-COL-08013 MAC*/
            	 {
	                pArguments._logger << "BUSCANDO EN select__SERVSUPLABO_CICLFACT." <<  ENDLLOGGER;/*P-COL-08013 MAC*/
                   pArguments._logger << "\t NUM_ABONADO     :[" << _my_cliente_abonado[j].NUM_ABONADO << "]" << ENDLLOGGER;
                   pArguments._logger << "\t COD_SERVICIO    :[" << vec_cargos_puntuales[i].COD_SERVICIO << "]" << ENDLLOGGER;
                   pArguments._logger << "\t FEC_HASTACFIJOS :[" << info_ciclfact.FEC_HASTACFIJOS << "]" << ENDLLOGGER;
                   pArguments._logger << "\t FEC_DESDECFIJOS :[" << info_ciclfact.FEC_DESDECFIJOS << "]" << ENDLLOGGER;
                   pArguments._logger << "\t FEC_EMISION     :[" << info_ciclfact.FEC_EMISION << "]" << ENDLLOGGER;
                   pArguments._logger << "\t cod_serv_predef :[" << cod_serv_predef << "]" << ENDLLOGGER;

	                resp = myDataService.select_SERVSUPLABO_CICLFACT(pArguments._codCicloFact,
	                                                                _my_cliente_abonado[j].NUM_ABONADO,
	                                                                vec_cargos_puntuales[i].COD_SERVICIO,
	                                                                info_ciclfact.FEC_HASTACFIJOS,
	                                                                info_ciclfact.FEC_DESDECFIJOS,
	                                                                info_ciclfact.FEC_EMISION);

                   pArguments._logger << "\t resp :[" << resp << "]" << ENDLLOGGER;
	                if (resp && cod_serv_predef != "") // valida que si el servicio por defecto esta definido
	                {
	                    resp = myDataService.select_SERVSUPLABO_CICLFACT(pArguments._codCicloFact,
	                                                                    _my_cliente_abonado[j].NUM_ABONADO,
	                                                                    cod_serv_predef,
	                                                                    info_ciclfact.FEC_HASTACFIJOS,
	                                                                    info_ciclfact.FEC_DESDECFIJOS,
	                                                                    info_ciclfact.FEC_EMISION);
                       pArguments._logger << "\t resp :[" << resp << "]" << ENDLLOGGER;
	                }
                /*inicio P-COL-08013 MAC*/
                } else {
               	
	                pArguments._logger << "BUSCANDO EN select__SERVSUPLABOSUSP_CICLFACT." <<  ENDLLOGGER;/*P-COL-08013 MAC*/
                   pArguments._logger << "\t NUM_ABONADO     :[" << _my_cliente_abonado[j].NUM_ABONADO << "]" << ENDLLOGGER;
                   pArguments._logger << "\t COD_SERVICIO    :[" << vec_cargos_puntuales[i].COD_SERVICIO << "]" << ENDLLOGGER;
                   pArguments._logger << "\t FEC_HASTACFIJOS :[" << info_ciclfact.FEC_HASTACFIJOS << "]" << ENDLLOGGER;
                   pArguments._logger << "\t FEC_DESDECFIJOS :[" << info_ciclfact.FEC_DESDECFIJOS << "]" << ENDLLOGGER;
                   pArguments._logger << "\t FEC_EMISION     :[" << info_ciclfact.FEC_EMISION << "]" << ENDLLOGGER;
                   pArguments._logger << "\t cod_serv_predef :[" << cod_serv_predef << "]" << ENDLLOGGER;

	                resp = myDataService.select_SERVSUPLABOSUSP_CICLFACT(pArguments._codCicloFact,
	                                                                _my_cliente_abonado[j].NUM_ABONADO,
	                                                                vec_cargos_puntuales[i].COD_SERVICIO,
	                                                                info_ciclfact.FEC_HASTACFIJOS,
	                                                                info_ciclfact.FEC_DESDECFIJOS,
	                                                                info_ciclfact.FEC_EMISION);

                   pArguments._logger << "\t resp :[" << resp << "]" << ENDLLOGGER;
	                if (resp && cod_serv_predef != "") // valida que si el servicio por defecto esta definido
	                {
	                    resp = myDataService.select_SERVSUPLABOSUSP_CICLFACT(pArguments._codCicloFact,
	                                                                    _my_cliente_abonado[j].NUM_ABONADO,
	                                                                    cod_serv_predef,
	                                                                    info_ciclfact.FEC_HASTACFIJOS,
	                                                                    info_ciclfact.FEC_DESDECFIJOS,
	                                                                    info_ciclfact.FEC_EMISION);
                       pArguments._logger << "\t resp :[" << resp << "]" << ENDLLOGGER;
	                }
	             }
	             /*inicio P-COL-08013 MAC*/
	             
                if(resp)
                {
	            	if (pArguments._logLevel > 4)
	                    pArguments._logger << "\t\tPOSEE SERVICIOS REQUERIDOS " << ENDLLOGGER;
                    GE_CARGOS mycargo;
                    mycargo.clear();
                    mycargo.COD_CLIENTE = _my_cliente_abonado[j].COD_CLIENTE;
                    mycargo.COD_PRODUCTO = 1;
                    mycargo.COD_CONCEPTO = vec_cargos_puntuales[i].COD_CONCEPTO;
                    mycargo.IMP_CARGO = vec_cargos_puntuales[i].MTO_CARGO;
                    strncpy(mycargo.COD_MONEDA,vec_cargos_puntuales[i].COD_MONEDA,strlen(vec_cargos_puntuales[i].COD_MONEDA));
                    mycargo.COD_PLANCOM = 1;
                    mycargo.NUM_UNIDADES = 1;
                    mycargo.IND_FACTUR = 1;
                    mycargo.NUM_TRANSACCION = 0;
                    mycargo.NUM_VENTA = 0;
                    mycargo.NUM_ABONADO = _my_cliente_abonado[j].NUM_ABONADO;
                    mycargo.COD_CICLFACT = pArguments._codCicloFact;
                    mycargo.NUM_FACTURA = 0;
                    strncpy(mycargo.NOM_USUARORA,pArguments._userAndPassword.c_str(),30);
                    if(myDataService.insertGE_CARGOS(mycargo))
                        numero_insertados++;
                    else
                        numero_fallidos++;
                    if(myDataService.update_GA_INFACCEL(mycargo,1,1))
                        updates_ok++;
                    else
                        updates_nook++;
                    cont_true++;
                   	if (pArguments._logLevel > 4)
	            		pArguments._logger << "\t\tSE GENERO CARGO [" << mycargo.COD_CONCEPTO << "]" << ENDLLOGGER;
                }
                else
                {
                    if (pArguments._logLevel > 4)
                    	pArguments._logger << "\t\tNO POSEE SERVICIOS REQUERIDOS " << ENDLLOGGER;
                    cont_false++;
				}
	            controler.streamOutLog(pArguments._logFile, pArguments._logger);
            }
            hrClock.markEnd();
        }

        pArguments._logger << "CANTIDAD DE MATCH EN GA_SERVSUPLABO" << ENDLLOGGER;
        pArguments._logger << "\tENCONTRADOS    : [" << cont_true << "]" << ENDLLOGGER;
        pArguments._logger << "\tNO ENCONTRADOS : [" << cont_false << "]" << ENDLLOGGER;
        pArguments._logger << "CARGOS PROCESADOS " << ENDLLOGGER;
        pArguments._logger << "\tCANTIDAD DE REGISTROS INSERTADOS    :" << numero_insertados << ENDLLOGGER;
        pArguments._logger << "\tCANTIDAD DE REGISTROS NO INSERTADOS :" << numero_fallidos << ENDLLOGGER;
        pArguments._logger << "CANTIDAD DE UPDATES GA_INFACCEL          :" << updates_ok << ENDLLOGGER;
        pArguments._logger << "CANTIDAD DE UPDATES FALLIDOS GA_INFACCEL :" << updates_nook << ENDLLOGGER;
        pArguments._logger << "\t[TIEMPO UNIVERSO PROCESADO()]: eTimeMSEC = [" << hrClock.getElapsedTimeMSEC() << "]..." << ENDLLOGGER;
        pArguments._logger << "\t[TIEMPO UNIVERSO PROCESADO()]: eTimeSEC  = [" << hrClock.getElapsedTimeSEC()  << "]..." << ENDLLOGGER;
        pArguments._logger << "PROCESO TERMINADO OK" << ENDLLOGGER;
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR SQL EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << ": " << error.msg << ENDLLOGGER;
        pArguments._logger << ": " << error.stm_text << ENDLLOGGER;
        pArguments._logger << ": " << error.var_info<< ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);
        return 0;
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);
        return 0;
    }


//////////////////////////////////////////////////////////////////////////////////////////
//\ TODO ESTOY HAY QUE VER SI SE USA

  /*  SharedTables    shTables;

    pArguments._logger << "@Cargando Tablas en memoria..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        shTables.init(pArguments._userAndPassword);
        shTables.chargeAllTables();
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR CARGANDO TABLAS EN MEMORIA:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.msg << ENDLLOGGER;
        pArguments._logger << "@: " << error.stm_text << ENDLLOGGER;
        pArguments._logger << "@: " << error.var_info<< ENDLLOGGER;

        return controler.procesoEnError(pArguments._logFile, pArguments._logger);;
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "@ERROR CARGANDO TABLAS EN MEMORIA:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;

        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }

    pArguments._logger << "@Carga Finalizada..." << ENDLLOGGER;*/

//////////////////////////////////////////////////////////////////////////////////////////



    pArguments._logger << "@Registrando Estado Final del Proceso (commit)..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        controler.finProcesoOk();
        myDataService.commit();
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR SQL EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << ": " << error.msg << ENDLLOGGER;
        pArguments._logger << ": " << error.stm_text << ENDLLOGGER;
        pArguments._logger << ": " << error.var_info<< ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);
        return 0;
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);
        return 0;
    }


//////////////////////////////////////////////////////////////////////////////////////////

    pArguments._logger << "@Cerrando Servicio de Base de datos Principal..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        myDataService.closeConnDb();
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR SQL EN PROCESO: " << ENDLLOGGER;
        pArguments._logger << ": " << error.msg << ENDLLOGGER;
        pArguments._logger << ": " << error.stm_text << ENDLLOGGER;
        pArguments._logger << ": " << error.var_info<< ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);
        return 0;
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);
        return 0;
    }


//////////////////////////////////////////////////////////////////////////////////////////
    pArguments._logger << "@Cerrando Archivo Log..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    pArguments._logFile.close();

    return 1;
}
