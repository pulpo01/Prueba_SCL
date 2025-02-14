#ifndef NO_INDENT
#ident "@(#)$RCSfile: shared_tables.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

///
/// \file shared_tables.h
///


#ifndef SHARED_TABLE_H
#define SHARED_TABLE_H

#ifdef WIN32
#pragma warning(disable:4786)
#pragma warning(disable:4503)
#endif

#include <iostream>
#include <vector>
#include <set>
#include <map>


#include "otl.h"
#include "myString.h"

#ifdef _USE_MT_CHARGE_SHARED_TABLES
#include "Thread.h"
#include "Mutex.h"
#include "server_exception.h"
#define NUM_OF_TABLES_TO_KEEP_IN_MEMORY 32
#endif
#include "process_clock.h"
#include "maps_tables.h"

using namespace std;

#ifdef _USE_MT_CHARGE_SHARED_TABLES
class SharedTables : public POSIXThread
#else
class SharedTables
#endif
{
public:

#ifdef _USE_MT_CHARGE_SHARED_TABLES
    enum MODE { MASTER, SLAVE };
#endif
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//     GENERAL
//////////////////////////////////////////////////////////////////////////////////////////////////////////
    void init(const STRING dbUserPass);
    void chargeAllTables();
    SharedTables();
    ~SharedTables();
    void clear();
#ifdef _USE_MT_CHARGE_SHARED_TABLES
    void setChargeTable(int id);
    void chargeTable();
    void joined();
    bool errorFound();
    ProcessCoreException getLogicError();
    otl_exception getOtlError();
    SHARED_TABLES_ERROR_TYPE getErrorType();
#endif


    static SH_GE_CLILOCPADRE_TO     _GE_CLILOCPADREHIJO_TO;
    static SH_FA_CONCEPTOS          _FA_CONCEPTOS;

private:

    otl_connect                     _db;
    STRING                          _dbUserPass;
    ProcessClock                    _clock;
    STRING                          _sysdateYYYYMMDDHH24MISS;

    void initializeConnDb();
    void closeConnDb();

#ifdef _USE_MT_CHARGE_SHARED_TABLES
    enum SHARED_TABLES_ERROR_TYPE { OTL_ERROR, LOGIC_ERROR };
    int                             _tableToCharge;
    bool                            _errorFound;
    SHARED_TABLES_ERROR_TYPE        _errorType;
    otl_exception                   _dbError;
    ProcessCoreException            _logicError;
    POSIXMutex                      _chargeCtrlMutex;
    MODE                            _chargerMode;
    void execute();
#endif

    void chargeGE_CLILOCPADREHIJO_TO();
    void chargeFA_CONCEPTOS();

};

#endif


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


