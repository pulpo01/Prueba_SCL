#ifndef NO_INDENT
#ident "@(#)$RCSfile: shared_tables.cpp,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

///
/// \file shared_tables.cpp
///


#include "shared_tables.h"

#ifndef WIN32
#ifdef _DEBUG
#include <unistd.h>
#endif
#endif



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
SH_GE_CLILOCPADRE_TO            SharedTables::_GE_CLILOCPADREHIJO_TO;
SH_FA_CONCEPTOS                 SharedTables::_FA_CONCEPTOS;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
SharedTables::SharedTables()
{
#ifdef _USE_MT_CHARGE_SHARED_TABLES
    _tableToCharge = 0;
    _errorFound = false;
    _errorType = LOGIC_ERROR;
    _chargerMode = SharedTables::SLAVE;

#ifndef WIN32
    if(!setThreadAttr(PTHREAD_SCOPE_SYSTEM, PTHREAD_CREATE_JOINABLE, 0, SCHED_OTHER, PTHREAD_EXPLICIT_SCHED))
    {
        throw ServerException("SharedTables : setting thread attributes -> FAIL\n");
    }
#endif

#endif
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
SharedTables::~SharedTables()
{

#ifdef _USE_MT_CHARGE_SHARED_TABLES
    if(_chargerMode == SharedTables::MASTER) clear();
#else
    clear();
#endif
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::clear()
{
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::closeConnDb()
{
    _db.logoff();
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::initializeConnDb()
{
    _db.rlogon(_dbUserPass.c_str());
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::init(const STRING dbUserPass)
{
    _dbUserPass = dbUserPass;
    _sysdateYYYYMMDDHH24MISS = _clock.sysDateyyyymmddhh24miss().c_str();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::chargeAllTables()
{
    initializeConnDb();

    chargeGE_CLILOCPADREHIJO_TO();
    chargeFA_CONCEPTOS();

    closeConnDb();
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef _USE_MT_CHARGE_SHARED_TABLES
void SharedTables::chargeProcessTables()
{
#ifdef _DEBUG
    cout << "MT Charging process tables..." << endl;
#endif

    SharedTables tables[NUM_OF_TABLES_TO_KEEP_IN_MEMORY+1];

    _chargerMode = SharedTables::MASTER;

    for(int i = 1; i < NUM_OF_TABLES_TO_KEEP_IN_MEMORY+1; i++)
    {
        tables[i].init(_dbUserPass);
        tables[i].initializeConnDb();
        tables[i].setChargeTable(i);
        tables[i].start();
    }

#ifdef _DEBUG
    cout << "Waiting while charging..." << endl;
#endif

    for(int i = 1; i < NUM_OF_TABLES_TO_KEEP_IN_MEMORY+1; i++)
    {
        tables[i].joined();
    }


#ifdef _DEBUG
    cout << "Closing conecctions..." << endl;
#endif

    for(int i = 1; i < NUM_OF_TABLES_TO_KEEP_IN_MEMORY+1; i++)
    {
        tables[i].closeConnDb();
        if(tables[i].errorFound())
        {
            _errorFound = true;
            _errorType = tables[i].getErrorType();
            if(_errorType == OTL_ERROR)
                _dbError = tables[i].getOtlError();
            else
                _logicError = tables[i].getLogicError();
        }
    }

    if(_errorFound)
    {
        if(_errorType == OTL_ERROR) throw _dbError;
        else throw _logicError;
    }
}

#else
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#endif //_USE_MT_CHARGE_SHARED_TABLES



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef _USE_MT_CHARGE_SHARED_TABLES
void SharedTables::setChargeTable(int id)
{
    _tableToCharge = id;
}


void SharedTables::joined()
{
    _chargeCtrlMutex.lock();
    _chargeCtrlMutex.unlock();
    //join();
}

void SharedTables::chargeTable()
{
    switch(_tableToCharge)
    {
        case(1):
            chargeTolCentral();
            break;
        case(2):
            chargeTolPaisoperadora();
            break;
        case(3):
            chargeTolRuta();
            break;
        case(4):
            chargeTaMccMnc();
            break;
        case(5):
            #ifdef _INCLUDE_VALIDADOR
            #ifndef _INCLUDE_ROAMING
            chargeTolPrefijosTd();
            #endif
            #endif
            break;
        case(6):
            #ifdef _INCLUDE_VALIDADOR
            chargeTolRannume();
            #endif
            break;
        case(7):
            #ifdef _INCLUDE_VALIDADOR
            #ifndef _INCLUDE_ROAMING
            chargeTolEscenarios();
            #endif
            #endif
            break;
        case(8):
            #ifdef _INCLUDE_VALIDADOR
            chargeTolCronograma();
            #endif
            break;
        case(9):
            #ifdef _INCLUDE_VALIDADOR
            #ifndef _INCLUDE_ROAMING
            chargeTolMatubicacion();
            #endif
            #endif
            break;
        case(10):
            #ifdef _INCLUDE_VALIDADOR
            #ifndef _INCLUDE_ROAMING
            chargeTolMatalm();
            #endif
            #endif
            break;
        case(11):
            #ifdef _INCLUDE_VALIDADOR
            chargeTolTipoLLam();
            #endif
            break;
        case(12):
            #ifdef _INCLUDE_VALIDADOR
            chargeTolCalenda();
            #endif
            break;
        case(13):
            #ifdef _INCLUDE_VALIDADOR
            chargeTolHoraPlan();
            #endif
            break;
        case(14):
            #ifdef _INCLUDE_VALIDADOR
            chargeTolHoraDia();
            #endif
            break;
        case(15):
            chargeTolPlan();
            break;
        case(16):
            #ifdef _INCLUDE_VALIDADOR
            #ifndef _INCLUDE_ROAMING
            chargeTolAgrullam();
            #endif
            #endif
            break;
        case(17):
            #ifdef _INCLUDE_VALIDADOR
            chargeTolOperadora();
            #endif
            break;
        case(18):
            chargeTolUnidad();
            break;
        case(19):
            #ifdef _INCLUDE_VALIDADOR
            #ifdef _INCLUDE_ROAMING
            chargeTolOpeRoaming();
            #endif
            #endif
            break;
        case(20):
            #ifdef _INCLUDE_VALIDADOR
            #ifdef _INCLUDE_ROAMING
            chargeTolTipoLLamRo();
            #endif
            #endif
            break;
        case(21):
            #ifdef _INCLUDE_VALIDADOR
            #ifdef _INCLUDE_ROAMING
            chargeTolRelOperadora();
            #endif
            #endif
            break;
        case(22):
            #ifdef _INCLUDE_VALORIZADOR
            chargeTolDetbolsa();
            #endif
            break;
        case(23):
            #ifdef _INCLUDE_VALORIZADOR
            chargeTolAgruserv_td();
            #endif
            break;
        case(24):
            #ifdef _INCLUDE_VALORIZADOR
            chargeTolBolsaPlan();
            #endif
            break;
        case(25):
            #ifdef _INCLUDE_VALORIZADOR
            chargeSeTolPlan();
            #endif
            break;
        case(26):
            #ifdef _INCLUDE_MINLIBRES
            chargeTolDetDesto();
            #endif
            break;
        case(27):
            #ifdef _INCLUDE_MINLIBRES
            #ifdef _ENABLE_SEARCH_DESC_LLAM
            chargeTolMultiidioma();
            #endif
            #endif
            break;
        case(28):
            #ifdef _INCLUDE_VALORIZADOR
            #ifndef _USE_FETCH_TARIF_DIRECT_FROM_DATABASE
            chargeSuTolPlanEsttarif();
            #endif
            #endif
            break;
        case(29):
            #ifdef _INCLUDE_VALORIZADOR
            #ifndef _USE_FETCH_TARIF_DIRECT_FROM_DATABASE
            chargePfTolEsttarif();
            #endif
            #endif
            break;
        case(30):
            #ifdef _INCLUDE_VALORIZADOR
            #ifndef _USE_FETCH_TARIF_DIRECT_FROM_DATABASE
            chargePfTolTarifaFranja();
            #endif
            #endif
            break;
        case(31):
            #ifdef _INCLUDE_VALORIZADOR
            #ifndef _USE_FETCH_ESCENARIO_DIRECT_FROM_DATABASE
            chargeSuTolPlanEscenario();
            #endif
            #endif
            break;
        case(32):
            #ifdef _INCLUDE_VALORIZADOR
            #ifndef _USE_FETCH_ESCENARIO_DIRECT_FROM_DATABASE
            chargeSuTolDetEscenario();
            #endif
            #endif
            break;
        default:
            break;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::execute()
{
    _chargeCtrlMutex.lock();

    try
    {
        chargeTable();
    }
    catch(otl_exception& error)
    {
        _errorFound = true;
        _errorType = OTL_ERROR;
        _dbError = error;
    }
    catch(ProcessCoreException& error)
    {
        _errorFound = true;
        _errorType = LOGIC_ERROR;
        _logicError = error;
    }

    _chargeCtrlMutex.unlock();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool SharedTables::errorFound()
{
    return _errorFound;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
SharedTables::SHARED_TABLES_ERROR_TYPE SharedTables::getErrorType()
{
    return _errorType;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ProcessCoreException SharedTables::getLogicError()
{
    return _logicError;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
otl_exception SharedTables::getOtlError()
{
    return _dbError;
}

#endif //_USE_MT_CHARGE_SHARED_TABLES



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::chargeGE_CLILOCPADREHIJO_TO()
{
    STRING1000 errorMsg;

#ifdef _DEBUG
    int counter = 0;
    cout << "Start Charging GE_CLILOCPADREHIJO_TO..." << endl;
#endif

    otl_stream pmt(1024, QUERY_SH_GE_CLILOCPADREHIJO_TO, _db);

    if(pmt.eof())
    {
        errorMsg << "ERROR: NO SE ENCONTRARON REGISTROS EN GE_CLILOCPADREHIJO_TO...";

        throw ProcessCoreException(errorMsg, (char *) "XXXX", PROGRAM_ERROR);
    }

    int codClienteP;
    int codClienteH;
    STRING16 tipoCliente;

    while(!pmt.eof())
    {
#ifdef _DEBUG
        counter++;
#endif

        codClienteP = -1;
        codClienteH = -1;
        tipoCliente.clear();

        pmt >> codClienteH;
        pmt >> codClienteP;
        pmt >> tipoCliente;

        //trim(codClienteP);
        //trim(codClienteH);
        trim(tipoCliente);

        (_GE_CLILOCPADREHIJO_TO[codClienteP]).insert(codClienteH);
    }

#ifdef _DEBUG
    cout << "GE_CLILOCPADREHIJO_TO charged (" << counter << ") registers"<< endl;
#endif

    return;
}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SharedTables::chargeFA_CONCEPTOS()
{
    STRING1000 errorMsg;
    
#ifdef _DEBUG
    int counter = 0;
    cout << "Start Charging FA_CONCEPTOS..." << endl;
#endif
    
    otl_stream pmt(1024, QUERY_SH_FA_CONCEPTOS, _db);
    
    if(pmt.eof())
    {
        errorMsg << "ERROR: NO SE ENCONTRARON REGISTROS EN FA_CONCEPTOS...";
        
        throw ProcessCoreException(errorMsg, (char *) "XXXX", PROGRAM_ERROR);
    }
    
    int codConcepto;
    RECORD_FA_CONCEPTOS_DTO tmpRC;
    
    while(!pmt.eof())
    {
#ifdef _DEBUG
        counter++;
#endif
        
        codConcepto = 0;
        tmpRC.clear();
        
        pmt >> codConcepto;
        pmt >> tmpRC.COD_PRODUCTO;
        pmt >> tmpRC.COD_TIPCONCE;
        
        _FA_CONCEPTOS[codConcepto] = tmpRC;
    }
    
#ifdef _DEBUG
    cout << "_FA_CONCEPTOS charged (" << counter << ") registers"<< endl;
#endif
    
    return;
}



/******************************************************************************************/
/** Informacion de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revision                                            : */
/**  %PR% */
/** Autor de la Revision                                : */
/**  %AUTHOR% */
/** Estado de la Revision ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creacion de la Revision                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/









