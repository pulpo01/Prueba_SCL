#ifndef NO_INDENT
#ident "@(#)$RCSfile: dctosLoc.cpp,v $ $Revision: 1.12 $ $Date: 2008/06/18 00:03:32 $"
#endif

///
/// \file dctosLoc.cpp
///



#include "hr_time_clock.h"
#include "process_core.h"
#include "process_clock.h"
#include "Indent.h"
#include "LogBuffer.h"
#include "cliente_locutorio_factory.h"
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
        cout <<                                 " \t<" << argv0 << ">" << endl;
        cout <<                                 " \t-c<codCicloFact>" << endl;
        cout <<                                 " \t-j<numJob>" << endl;
        cout <<                                 " \t-u<[user]/[pass]>" << endl;
        cout <<                                 " \t-l<log level(0-9)>" << endl;
        cout << endl;
#else
        cout << "PID[" << processID << "]: " << endl;
        cout <<                                 " \t<" << argv0 << ">" << endl;
        cout <<                                 " \t<codCicloFact>" << endl;
        cout <<                                 " \t<numJob>" << endl;
        cout <<                                 " \t<[user]/[pass]@[db_sid]>" << endl;
        cout <<                                 " \t<log level(0-9)>" << endl;
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
            case 'j':
                if ( strlen (optarg) )
                {
                    pArguments._numJob = (atoi(optarg) > 0)?atoi(optarg) : -1;
                }
                break;
            default:
                break;
        }
    }
#endif
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
STRING getEnvVar(const char* envVar)
{
    STRING envVarValue;
    char* tmpValue;


    if(envVar == NULL)
    {
        STRING1000 errorMsg;
        errorMsg << "VARIABLE DE AMBIENTE DESCONOCIDA: []." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

#ifndef WIN32
    tmpValue = getenv( envVar ); // C4996

    if( tmpValue != NULL )
    {
        envVarValue.clear();
        envVarValue = tmpValue;
    }

#else
    size_t requiredSize;
    getenv_s( &requiredSize, NULL, 0, envVar);

    if(requiredSize >= 256)
    {
        STRING1000 errorMsg;
        errorMsg << "EL VALOR DE LA VARIABLE DE AMBIENTE [" << envVar
                 << "] SUPERA EL MAXIMO PERMITIDO DE 256 CARACTERES..." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    if(requiredSize < 1) return envVarValue;

    tmpValue = new char[requiredSize];
    memset(tmpValue, 0x00, requiredSize);

    if (!tmpValue)
    {
        printf("Failed to allocate memory!\n");
        exit(1);
    }

    // Get the value of the LIB environment variable.
    getenv_s( &requiredSize, tmpValue, requiredSize, envVar);

    if( tmpValue != NULL )
    {
        envVarValue.clear();
        envVarValue = tmpValue;
    }

    delete[] tmpValue;
#endif

    return envVarValue;
}

void verifyDir(char* dirPath)
{
    STRING1000 tmpCommand;
    tmpCommand.clear();
    tmpCommand << "mkdir -p ";
    tmpCommand << dirPath;
    system(tmpCommand.c_str());
}


STRING1000 getLogFileName(const char* pName, ProgramArguments& pArguments)
{
    STRING1000  logPath;
    STRING      fileName;
    STRING      varEnv;



    fileName.clear();
    logPath.clear();

    fileName << pName << "_" << pArguments._processStartTime.substr(0,8);
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
    ProgramArguments pArguments;

#ifndef WIN32
    pArguments._processID = getpid();
#else
    pArguments._processID = _getpid();
#endif

    std::stringstream indentInfo;

    printOutIndentInfo(argv[0], indentInfo);

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
    pArguments._numJob = atoi(argv[2]);
    pArguments._userAndPassword = argv[3];
    pArguments._logLevel = atoi(argv[4]);
#else
    getArguments(argc, argv, pArguments);
#endif

//////////////////////////////////////////////////////////////////////////////////////////

    cout << "PID[" << pArguments._processID << "]: " << endl; 
    cout << "\t" << "[codCicloFact]   = [" << pArguments._codCicloFact << "]" << endl;
    cout << "\t" << "[numJob]         = [" << pArguments._numJob << "]" << endl;
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
    ProcessControler controler;

    cout << "Verificando Inicio de Ejeccion segun scheduling de proceso..." << endl;


    try
    {
        controler.init(&myDataService, pArguments._numJob, pArguments._codCicloFact);
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

    pArguments._logFileName = getLogFileName("dctosLoc", pArguments);

    if(pArguments._numJob > -1)
    {
        if(controler.repro())
        {
            pArguments._logFileName << "_" << controler.getSeqRepro();
        }
        else
        {
            pArguments._logFileName << "_1";
        }
    }

    cout << "Creando Archivo de Log: [" << pArguments._logFileName << "]..." << endl;

    pArguments._logFile.open(pArguments._logFileName.c_str(), std::ofstream::out);

    if(!pArguments._logFile.is_open())
    {
        cout << "No se pudo crear archivo de Log: [" << pArguments._logFileName << "]..." << endl;
        return 0;
    }

    pArguments._logFile << indentInfo.str();

    pArguments._logFile << "PID[" << pArguments._processID << "]: " << endl; 
    pArguments._logFile << "\t" << "[codCicloFact]   = [" << pArguments._codCicloFact << "]" << endl;
    pArguments._logFile << "\t" << "[numJob]         = [" << pArguments._numJob << "]" << endl;
    pArguments._logFile << "\t" << "[dbConnectString]= [" << pArguments._userAndPassword << "]" << endl;
    pArguments._logFile << "\t" << "[logLevel]       = [" << pArguments._logLevel << "]" << endl;



//////////////////////////////////////////////////////////////////////////////////////////

    pArguments._logger.level(pArguments._logLevel);










//////////////////////////////////////////////////////////////////////////////////////////
    SharedTables    shTables;

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

    pArguments._logger << "@Carga Finalizada..." << ENDLLOGGER;








//////////////////////////////////////////////////////////////////////////////////////////
    ClientesPadresArray* clientesLoc = NULL;

    ClienteLocutorioFactory factoryClientes;

    pArguments._logger << "@Creando instancias Clientes Locutorios..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        factoryClientes.init(myDataService, shTables, pArguments._logger);
        clientesLoc = &(factoryClientes.build(pArguments._codCicloFact, pArguments._numJob));
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR CREANDO LISTA DE CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.msg << ENDLLOGGER;
        pArguments._logger << "@: " << error.stm_text << ENDLLOGGER;
        pArguments._logger << "@: " << error.var_info<< ENDLLOGGER;

        return controler.procesoEnError(pArguments._logFile, pArguments._logger);;
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR CREANDO LISTA DE CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;

        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }

    pArguments._logger << "@Num Clientes Locutorios Padres = [" << clientesLoc->getNumOfRecords() << "@]" << ENDLLOGGER;








//////////////////////////////////////////////////////////////////////////////////////////
    if(clientesLoc->getNumOfRecords() < 1)
    {
        pArguments._logger << "@No se han encontrado Clientes Locutorios a procesar..." << ENDLLOGGER;
        pArguments._logger << "@Registrando Estado Final del Proceso (commit)..." << ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);

        try
        {
            controler.finProcesoOk();
            myDataService.commit();
            pArguments._logger << "@Cerrando Servicio de Base de datos Principal..." << ENDLLOGGER;
            controler.streamOutLog(pArguments._logFile, pArguments._logger);
            myDataService.closeConnDb();

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

        pArguments._logger << "@Cerrando Archivo Log..." << ENDLLOGGER;
        controler.streamOutLog(pArguments._logFile, pArguments._logger);

        pArguments._logFile.close();

        return 1;
    }










//////////////////////////////////////////////////////////////////////////////////////////

    RECORD_FA_CICLFACT_DTO infoCiclo;
    infoCiclo.clear();
    infoCiclo = factoryClientes.getCicloFactRecord();

    ProcessCore* pCoreArray;
    DataService* pDataService;

    pArguments._logger << "@Creando instancias de procesamiento x Cliente Locutorio..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);


    pCoreArray      = new ProcessCore[clientesLoc->getNumOfRecords()];
    pDataService    = new DataService[clientesLoc->getNumOfRecords()];

    try
    {
        for(int i = 0; i< clientesLoc->getNumOfRecords(); i++)
        {
            pArguments._logger << INDENT2LOGGER << "@Instancia[" << i << "@] = Cliente Loc [" 
                               << (*clientesLoc)[i].COD_CLIENTE << "@]..." << ENDLLOGGER;

            pArguments._logger << INDENT3LOGGER << "@Iniciando conexion a Base de Datos..." << ENDLLOGGER;

            pDataService[i].setMode(DataService::FETCHER);
            pDataService[i].initializeConnDb(pArguments._userAndPassword);
            pCoreArray[i].init(&shTables, &pDataService[i], pArguments._logLevel);
            pCoreArray[i].clear();

            pArguments._logger << INDENT3LOGGER << "@Preparando proceso..." << ENDLLOGGER;

            pCoreArray[i].prepare((*clientesLoc)[i], infoCiclo, pArguments._numJob);
        }
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR CREANDO INSTANCIAS DE PROCESOS PARA CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.msg << ENDLLOGGER;
        pArguments._logger << "@: " << error.stm_text << ENDLLOGGER;
        pArguments._logger << "@: " << error.var_info<< ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR CREANDO LISTA DE CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }







//////////////////////////////////////////////////////////////////////////////////////////
    pArguments._logger << "@Iniciando instancias de procesamiento (threads)..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    for(int i = 0; i< clientesLoc->getNumOfRecords(); i++)
    {
        pArguments._logger << INDENT2LOGGER << "@Start thread[" << i << "@]..." << ENDLLOGGER;
        pCoreArray[i].start();
    }








//////////////////////////////////////////////////////////////////////////////////////////
    pArguments._logger << "@Esperando fin procesamiento (threads)..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    for(int i = 0; i< clientesLoc->getNumOfRecords(); i++)
        pCoreArray[i].joined();








//////////////////////////////////////////////////////////////////////////////////////////

    pArguments._logger << "@Verificando Estado procesamiento (threads)..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        for(int i = 0; i< clientesLoc->getNumOfRecords(); i++)
        {
            pArguments._logger << INDENT2LOGGER << "@Check thread[" << i << "@]..." << ENDLLOGGER;
            pArguments._logger << "@---------------------[ LOG THREAD[" << i << "@] ]-------------------------" << ENDLLOGGER;
            controler.streamOutLog(pArguments._logFile, pArguments._logger);
            controler.streamOutLog(pArguments._logFile, pCoreArray[i].backLog());
            pCoreArray[i].check();
        }
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR EN INSTANCIA PARA CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.msg << ENDLLOGGER;
        pArguments._logger << "@: " << error.stm_text << ENDLLOGGER;
        pArguments._logger << "@: " << error.var_info<< ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR EN INSTANCIA PARA CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }






//////////////////////////////////////////////////////////////////////////////////////////

    pArguments._logger << "@Insertando resultados en Base de Datos..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        pArguments._logger << "@Limpiando tabla destino..." << ENDLLOGGER;
        myDataService.delete_FA_DETDCTOCLIELOC(pArguments._codCicloFact, pArguments._numJob);
        for(int i = 0; i< clientesLoc->getNumOfRecords(); i++)
        {
            pArguments._logger << INDENT2LOGGER << "@Insertando resultados, Cliente Locutorio["
                               << i << "@][" << pCoreArray[i].getClientePadre()->COD_CLIENTE
                               << "@]..." << ENDLLOGGER;
            controler.streamOutLog(pArguments._logFile, pArguments._logger);
            pCoreArray[i].streamOutResults(&myDataService);
        }
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR SQL EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.msg << ENDLLOGGER;
        pArguments._logger << "@: " << error.stm_text << ENDLLOGGER;
        pArguments._logger << "@: " << error.var_info<< ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR EN INSTANCIA PARA CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }







//////////////////////////////////////////////////////////////////////////////////////////

    pArguments._logger << "@Cerrando Conexiones Base de Datos (threads)..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        for(int i = 0; i< clientesLoc->getNumOfRecords(); i++)
        {
            pArguments._logger << INDENT2LOGGER << "@Close DB thread[" << i << "@]..." << ENDLLOGGER;
            pDataService[i].closeConnDb();
        }
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR SQL EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.msg << ENDLLOGGER;
        pArguments._logger << "@: " << error.stm_text << ENDLLOGGER;
        pArguments._logger << "@: " << error.var_info<< ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR EN INSTANCIA BD PARA CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        delete[] pCoreArray;
        delete[] pDataService;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }






//////////////////////////////////////////////////////////////////////////////////////////

    pArguments._logger << "@Finalizando Ejecucion..." << ENDLLOGGER;
    controler.streamOutLog(pArguments._logFile, pArguments._logger);

    try
    {
        delete[] pCoreArray;
        delete[] pDataService;
    }
    catch(otl_exception& error)
    {
        pArguments._logger << "ERROR SQL EN PROCESO:" << ENDLLOGGER;
        pArguments._logger << ": " << error.msg << ENDLLOGGER;
        pArguments._logger << ": " << error.stm_text << ENDLLOGGER;
        pArguments._logger << ": " << error.var_info<< ENDLLOGGER;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }
    catch(ProcessCoreException& error)
    {
        pArguments._logger << "ERROR EN INSTANCIA PARA CLIENTES LOCUTORIOS:" << ENDLLOGGER;
        pArguments._logger << "@: " << error.what() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errCase() << ENDLLOGGER;
        pArguments._logger << "@: " << error.errNum() << ENDLLOGGER;
        return controler.procesoEnError(pArguments._logFile, pArguments._logger);
    }






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
