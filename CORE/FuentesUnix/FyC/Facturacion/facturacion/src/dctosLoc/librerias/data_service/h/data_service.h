#ifndef NO_INDENT
#ident "@(#)$RCSfile: data_service.h,v $ $Revision: 1.9 $ $Date: 2008/08/04 21:25:28 $"
#endif

///
/// \file data_service.h
///


#ifndef DATA_SERVICE_H
#define DATA_SERVICE_H

#ifdef WIN32
#pragma warning(disable:4786)
#endif

#include <string>
#include <iostream>
#include "otl.h"
#include "myString.h"
#include "process_core_exception.h"
#include "maps_tables.h"


/// OraOciNumber deals with decimals precisions
/// and real arithmetic
#include "ora_oci_number.h"

/// Definition of error function handler for 
/// error from the OraOciNumber class
void getErrorInOraOciNumber(const char* msg, int numError);


using namespace std;


class DataService
{
public:
    enum QUERY_MODE
    {
        MAIN = 0,
        FETCHER = 1
    };

private:

    otl_connect                     _db;
    STRING                          _connectString;
    bool                            _isCommitable;
    QUERY_MODE                      _mode;

    otl_stream*                     _FA_CICLFACT;
    otl_stream*                     _FA_CICLOCLI;
    otl_stream*                     _FA_CICLOCLI_JOB;
    FA_CICLOCLI_RECORDSET           _FA_CICLOCLI_RECORDS;
    otl_stream*                     _FA_CLIENTEJOB_TO;

    otl_stream*                     _GAT_PLANDESCABO;
    STRING16                        _ciclo_GAT_PLANDESCABO;
    STRING16                        _job_GAT_PLANDESCABO;

    GAT_PLANDESCABO_RECORDSET       _GAT_PLANDESCABO_RECORDS;
    otl_stream*                     _FAD_CONCEVAL;
    FAD_CONCEVAL_RECORDSET          _FAD_CONCEVAL_RECORDS;
    otl_stream*                     _FAD_CONCAPLI;
    FAD_CONCAPLI_RECORDSET          _FAD_CONCAPLI_RECORDS;
    otl_stream*                     _FAD_CUADRANDESC;
    FAD_CUADRANDESC_RECORDSET       _FAD_CUADRANDESC_RECORDS;

    otl_stream*                     _TOL_ACUMOPER_TO;
    RECORD_TOL_ACUMOPER_TO_DTO      _recordTOL_ACUMOPER_TO;
    int                             _currentClient;

    otl_nocommit_stream*            _FA_DETDCTOCLIELOC_TO;
    otl_nocommit_stream*            _del_FA_DETDCTOCLIELOC_TO;
    STRING16                        _ciclo;
    STRING16                        _job;
    STRING32                        _name_FA_DETDCTOCLIELOC_TO;

    otl_stream*                     _FA_PROCFACT;
    otl_stream*                     _FA_TRAZAPROC_JOB_TO_SEQ_REPRO;
    otl_stream*                     _FA_TRAZAPROC;
    otl_stream*                     _statFA_TRAZAPROC;
    otl_stream*                     _statFA_TRAZAPROC_JOB_TO;
    otl_stream*                     _FA_TRAZAPROC_JOB_TO;
    FA_TRAZAPROC_RECORDSET          _FA_TRAZAPROC_RECORDS;
    otl_nocommit_stream*            _iFA_TRAZAPROC;
    otl_nocommit_stream*            _uFA_TRAZAPROC;
    otl_nocommit_stream*            _iFA_TRAZAPROC_JOB_TO;
    otl_nocommit_stream*            _uFA_TRAZAPROC_JOB_TO;
    otl_stream*                     _FA_JOBFACT_TO;
    otl_stream*                     _FA_CRITERIOJOB_TO;


    /// Enviroment for the OraOciNumber in multiThreading enviroment
    /// each thread must have un oracle enviroment associated with it
    /// in order to grant thread free.

    OraOciEnviroment*            _oracleEviroment; 

    void clear();
    void confirmChanges();

public:

    DataService();
    ~DataService();
    void initializeConnDb(const STRING& dbUserPassSid);
    bool reInitializeConnDb(const STRING& dbUserPassSid);
    void closeConnDb();
    void commit();
    void rollback();
    void setMode(QUERY_MODE mode);
    void setCicloInfo(const int codCicloFact, const int numJob);

    STRING sysDateyyyymmddhh24miss();
    char* toChar(int number);
    float round(float Value, int NumPlaces);
    double round(double Value, int NumPlaces);
    /// This functions returns the oracle enviroment needed by the OraOciNumber class
    OraOciEnviroment* getEnv();

    RECORD_FA_CICLFACT_DTO select_FA_CICLFACT(const int codCicloFact,
                                              const int indFacturacion);
    FA_CICLOCLI_RECORDSET& select_FA_CICLOCLI(const int codCliente,
                                              const int codCiclo,
                                              const int codCicloFact,
                                              const int numProc,
                                              const int indMask);

    FA_CICLOCLI_RECORDSET& select_FA_CICLOCLI_JOB(const int codCliente,
                                                  const int codCiclo,
                                                  const int codCicloFact,
                                                  const int numProc);

    bool select_FA_CLIENTEJOB_TO(const int codCliente,
                                 const int numJob,
                                 const int codCiclo);

    void verifyQuery_GAT_PLANDESCABO(const int codCicloFact, const int numJob);

    GAT_PLANDESCABO_RECORDSET& select_GAT_PLANDESCABO(const int codCliente,
                                                      const int codCicloFact,
                                                      const char* fecEmision,
                                                      const int numJob);

    FAD_CONCEVAL_RECORDSET& select_FAD_CONCEVAL(const int codGrupo,
                                                const char* fecEmision);
    FAD_CONCAPLI_RECORDSET& select_FAD_CONCAPLI(const int codGrupo,
                                                const char* fecEmision);
    FAD_CUADRANDESC_RECORDSET& select_FAD_CUADRANDESC(const int codGrupo,
                                                      const char* fecEmision);

    bool open_TOL_ACUMOPER_TO(const int codCliente,
                              const int numAbonado,
                              const char* fecEmision,
                              const int indFacturacion);

    RECORD_TOL_ACUMOPER_TO_DTO* fetch_TOL_ACUMOPER_TO();

    void delete_FA_DETDCTOCLIELOC(const int codCicloFact, const int numJob);

    void insert_FA_DETDCTOCLIELOC(RECORD_FA_DETDCTOCLIELOC_TO_DTO& recordOut,
                                  const int codCicloFact,
                                  const int numJob);

    void verifyQuery_FA_DETDCTOCLIELOC(const int codCicloFact, const int numJob);

    RECORD_FA_PROCFACT_DTO select_FA_PROCFACT(const int codProceso);

    int select_FA_TRAZAPROC_JOB_TO_SEQ_REPRO(const int codProceso,
                                             const int codCicloFact,
                                             const int numJob);

    FA_TRAZAPROC_RECORDSET& select_FA_TRAZAPROC(const int codProceso,
                                                const int codCicloFact);

    RECORD_STAT_FA_TRAZAPROC_DTO selectSTAT_FA_TRAZAPROC(const int codProceso,
                                                         const int codCicloFact);

    RECORD_STAT_FA_TRAZAPROC_DTO selectSTAT_FA_TRAZAPROC(const int codProceso,
                                                         const int codCicloFact,
                                                         const int numJob,
                                                         const int seqRepro);


    FA_TRAZAPROC_RECORDSET& select_FA_TRAZAPROC_JOB_TO(const int codProceso,
                                                       const int codCicloFact,
                                                       const int numJob,
                                                       const int seqRepro);
    bool insert_FA_TRAZAPROC(const int codCicloFact);

    bool update_FA_TRAZAPROC(const int codStatProc,
                             const char* textStat,
                             const int codCicloFact);

    bool insert_FA_TRAZAPROC_JOB_TO(const int numJob,
                                    const int codCicloFact,
                                    const int seqRepro);

    bool update_FA_TRAZAPROC_JOB_TO(const int codStatProc,
                                    const char* textStat,
                                    const int codCicloFact,
                                    const int numJob,
                                    const int seqRepro);

    bool select_FA_JOBFACT_TO(const int numJob, const int codStat1, const int codStat2);

    bool select_FA_CRITERIOJOB_TO(const int codCiclFact,
                                  const int numJob);



}; // class DataService

#endif // DATA_SERVICE_H


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


