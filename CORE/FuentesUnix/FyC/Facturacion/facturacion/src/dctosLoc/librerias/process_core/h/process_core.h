#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_core.h,v $ $Revision: 1.5 $ $Date: 2008/06/17 15:34:09 $"
#endif

///
/// \file process_core.h
///


#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef PROCESS_CORE_H
#define PROCESS_CORE_H

#include "LogBuffer.h"
#include "shared_tables.h"
#include "data_service.h"
#include "process_thread.h"
#include "cliente_locutorio.h"
#include "eval_discount_matrix.h"
#include "record_fetcher.h"
#include "hr_time_clock.h"

class ProcessTimer
{
public:
    double      _avgElapTimeSQL_SEC;
    double      _avgElapTimeApp_SEC;
    double      _avgElapTimeSQL_MSEC;
    double      _avgElapTimeApp_MSEC;

    double      _totalTimeSQL_SEC;
    double      _totalTimeApp_SEC;
    double      _totalTimeSQL_MSEC;
    double      _totalTimeApp_MSEC;

    void clear()
    {
        _avgElapTimeSQL_SEC = 0.0;
        _avgElapTimeApp_SEC = 0.0;
        _avgElapTimeSQL_MSEC = 0.0;
        _avgElapTimeApp_MSEC = 0.0;

        _totalTimeSQL_SEC = 0.0;
        _totalTimeApp_SEC = 0.0;
        _totalTimeSQL_MSEC = 0.0;
        _totalTimeApp_MSEC = 0.0;
    };

    ProcessTimer(){ clear(); };

    void setLastElapTimeSQL_SEC(double et)
    {
        _avgElapTimeSQL_SEC = (_avgElapTimeSQL_SEC + et)/2;
        _totalTimeSQL_SEC += et;
    };

    void setLastElapTimeSQL_MSEC(double et)
    {
        _avgElapTimeSQL_MSEC = (_avgElapTimeSQL_MSEC + et)/2;
        _totalTimeSQL_MSEC += et;
    };

    void setLastElapTimeApp_SEC(double et)
    {
        _avgElapTimeApp_SEC = (_avgElapTimeApp_SEC + et)/2;
        _totalTimeApp_SEC += et;
    };

    void setLastElapTimeApp_MSEC(double et)
    {
        _avgElapTimeApp_MSEC = (_avgElapTimeApp_MSEC + et)/2;
        _totalTimeApp_MSEC += et;
    };

};


class ProcessCore : public ProcessThread
{
public:
    ProcessCore();
    ~ProcessCore();
    void init(SharedTables* shData, DataService* dbData, int logLevel);
    bool prepare(ClienteLocutorioPadre& clientePadre,
                 const RECORD_FA_CICLFACT_DTO& infCiclo,
                 const int numJob);
    void clear() throw();
    LogBuffer& backLog();
    void check();
    void streamOutResults(DataService* dbData);
    ClienteLocutorioPadre* getClientePadre();
private:

    enum ERROR_TYPE
    {
        SQL = 0,
        PROCESS = 1
    };

    typedef VariableSizeRecordBuffer<RECORD_FA_DETDCTOCLIELOC_TO_DTO, 100> RECORD_FA_DETDCTOCLIELOC_BUFFER;

    bool exec();
    void execute();
    bool processRecord(const RECORD_TOL_ACUMOPER_TO_DTO& record);
    void streamOutResults();
    void chargeRecordOut(RECORD_FA_DETDCTOCLIELOC_TO_DTO& recordOut,
                         const int codCliente,
                         const int codCicloFact,
                         const PlanDescuento& plan,
                         const int cuadrante);
    bool keepRuning();

    SharedTables*                   _sharedData;
    DataService*                    _dataBaseData;
    ClienteLocutorioPadre*          _clientePadre;
    RECORD_FA_CICLFACT_DTO          _infCiclo;
    int                             _job;
    STRING16                        _fecEmi;
    LogBuffer                       _log;
    MatrizEvalDcto                  _matrix;
    RecordFetcher                   _fetcher;

    ERROR_TYPE                      _errorType;
    bool                            _errorFound;
    otl_exception                   _errorSql;
    ProcessCoreException            _errorProcess;
    HighResolutionClock             _hrClock;
    ProcessTimer                    _timer;
    RECORD_FA_DETDCTOCLIELOC_BUFFER _outputBuffer;
    static volatile bool            _keepRuning;


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


