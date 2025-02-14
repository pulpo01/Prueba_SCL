#ifndef NO_INDENT
#ident "@(#)$RCSfile: data_service.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 16:29:47 $"
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
#include "hr_time_clock.h"
#include "predefFact.h"


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
    OraOciEnviroment*            _oracleEviroment;

    otl_stream*                     _FA_CICLFACT;
    otl_stream*                     _FA_CICLOCLI;
    FA_CICLOCLI_RECORDSET           _FA_CICLOCLI_RECORDS;

    STRING16                        _ciclo;
    STRING16                        _job;
    otl_stream*                     _FA_PROCFACT;
    otl_stream*                     _FA_TRAZAPROC;
    otl_stream*                     _statFA_TRAZAPROC;

    FA_TRAZAPROC_RECORDSET          _FA_TRAZAPROC_RECORDS;
    otl_nocommit_stream*            _iFA_TRAZAPROC;
    otl_nocommit_stream*            _uFA_TRAZAPROC;
    otl_stream*                     _FA_PARAMETROS_SIMPLES_VW;
    otl_stream*                     _FA_RANGOSHOST_TO;

    // DESCUENTOS LOCUTORIOS
    //    STRING32                        _name_FA_DETDCTOCLIELOC_TO;
    //    otl_stream*                     _GAT_PLANDESCABO;
    //    GAT_PLANDESCABO_RECORDSET       _GAT_PLANDESCABO_RECORDS;
    //    otl_stream*                     _FAD_CONCEVAL;
    //    FAD_CONCEVAL_RECORDSET          _FAD_CONCEVAL_RECORDS;
    //    otl_stream*                     _FAD_CONCAPLI;
    //    FAD_CONCAPLI_RECORDSET          _FAD_CONCAPLI_RECORDS;
    //    otl_stream*                     _FAD_CUADRANDESC;
    //    FAD_CUADRANDESC_RECORDSET       _FAD_CUADRANDESC_RECORDS;
    //    otl_stream*                     _TOL_ACUMOPER_TO;
    //    RECORD_TOL_ACUMOPER_TO_DTO      _recordTOL_ACUMOPER_TO;
    //    int                             _currentClient;
    //    otl_nocommit_stream*            _FA_DETDCTOCLIELOC_TO;
    //    otl_nocommit_stream*            _del_FA_DETDCTOCLIELOC_TO;

    // CARGOS PUNTUALES
    otl_stream*                     _FA_CARGOSERVPUNTUAL_TO;
    otl_stream*                     _ABONADOS_INDENT_TRIBSINDESPA;
    otl_stream*                     _ABONADOS_INDENT_TRIBCONDESPA;
    otl_stream*                     _SERVSUPLABO_CICLFACT;
    otl_stream*                     _SERVSUPLABOSUSP_CICLFACT;
    otl_stream*                     _SELECT_GE_SEQ_CARGOS;
    otl_stream*                     _INSERT_GE_CARGOS;
    otl_stream*                     _UPDATE_GA_INFACCEL;


#ifdef _JOB
    otl_stream*                     _FA_CLIENTEJOB_TO;
    otl_nocommit_stream*            _iFA_TRAZAPROC_JOB_TO;
    otl_nocommit_stream*            _uFA_TRAZAPROC_JOB_TO;
    otl_stream*                     _FA_JOBFACT_TO;
    otl_stream*                     _FA_CRITERIOJOB_TO;
    otl_stream*                     _FA_TRAZAPROC_JOB_TO;
    otl_stream*                     _FA_TRAZAPROC_JOB_TO_SEQ_REPRO;
    otl_stream*                     _statFA_TRAZAPROC_JOB_TO;
#endif

    /// Enviroment for the OraOciNumber in multiThreading enviroment
    /// each thread must have un oracle enviroment associated with it
    /// in order to grant thread free.


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


    GAT_PLANDESCABO_RECORDSET& select_GAT_PLANDESCABO(const int codCliente,
                                                      const int codCicloFact,
                                                      const char* fecEmision);
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

    FA_TRAZAPROC_RECORDSET& select_FA_TRAZAPROC(const int codProceso,
												const int codCicloFact,
												const char * hostId,
												const int indHostId);

    RECORD_STAT_FA_TRAZAPROC_DTO selectSTAT_FA_TRAZAPROC(const int codProceso,
                                                         const int codCicloFact,
                                                         const char * hostId,
                                                         const int indHostId);
    RECORD_FA_RANGOSHOST_TO_DTO selectFA_RANGOSHOST_TO(const STRING & hostId,
                                                       const int codCicloFact);

    bool insert_FA_TRAZAPROC(const int codCicloFact,
							 const int codProceso,
							 const int codEstadoProceso,
							 const char * hostId);

    bool update_FA_TRAZAPROC(const int codStatProc,
                             const char* textStat,
                             const int codCicloFact,
                             const int codProceso,
                             const char * hostId,
                             const int indHostId);

#ifdef _JOB
    bool select_FA_CLIENTEJOB_TO(const int codCliente,
                                 const int numJob,
                                 const int codCiclo);
    int select_FA_TRAZAPROC_JOB_TO_SEQ_REPRO(const int codProceso,
                                             const int codCicloFact,
                                             const int numJob);
    RECORD_STAT_FA_TRAZAPROC_DTO selectSTAT_FA_TRAZAPROC(const int codProceso,
                                                         const int codCicloFact,
                                                         const int numJob,
                                                         const int seqRepro);
    FA_TRAZAPROC_RECORDSET& select_FA_TRAZAPROC_JOB_TO(const int codProceso,
                                                       const int codCicloFact,
                                                       const int numJob,
                                                       const int seqRepro);
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
#endif

    STRING select_FA_PARAMETROS_SIMPLES_VW(const STRING &nom_parametro);
    vector <RECORD_FA_CARGOSERVPUNTUAL_TO> select_FA_CARGOSERVPUNTUAL_TO(const STRING &cod_despacho);
    //vector <RECORD_CLIENTE_ABONADO> select_ABONADOS_INDENT(const int cod_ciclfact,int cod_ciclo,STRING &fec_emision,STRING &cod_tipident,STRING &cod_despacho,STRING &cod_servicio,int ind_electronica,bool   indRango,int 	 clienteIni,int 	 clienteFin);
    vector <RECORD_CLIENTE_ABONADO> select_ABONADOS_INDENT( const int cod_ciclfact,
															const int cod_ciclo,
															const STRING &fec_emision,
															const STRING &cod_tipident,
															const STRING &cod_despacho,
															const STRING &cod_servicio,
															const int    ind_electronica,
															const bool   indRango,
															const int 	 clienteIni,
															const int 	 clienteFin,
															const STRING &fec_desde); /*P-COL-08013 MAC*/
    bool select_SERVSUPLABO_CICLFACT(int cod_ciclo,
    								          long num_abonado,
    								          const STRING &cod_servicio, 
    								          const STRING &fecHastaCFijo,
                                     const STRING &fecDesdeCFijo,
                                     const STRING &fecEmision);
/*inicio P-COL-08013 MAC*/
    bool select_SERVSUPLABOSUSP_CICLFACT(int cod_ciclo,
    								          long num_abonado,
    								          const STRING &cod_servicio, 
    								          const STRING &fecHastaCFijo,
                                     const STRING &fecDesdeCFijo,
                                     const STRING &fecEmision);
/*fin P-COL-08013 MAC*/

    long select_GE_SEQ_CARGOS();
    bool insertGE_CARGOS(GE_CARGOS &this_gecargos);
    bool update_GA_INFACCEL(GE_CARGOS &this_gecargos,int indicador, int indicadorCobro);


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


