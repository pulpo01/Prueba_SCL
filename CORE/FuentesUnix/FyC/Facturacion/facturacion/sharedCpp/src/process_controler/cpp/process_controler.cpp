#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_controler.cpp,v $ $Revision: 1.1 $ $Date: 2008/07/14 15:24:40 $"
#endif

///
/// \file process_controler.cpp
///

#include "process_controler.h"

ProcessControler::ProcessControler()
{
    _db = NULL;
    _codProceso = 0;
    _numJob = -99;
    _codCicloFact = -99;
    _seqRepro = 0;
    _reproMode = false;
    _indHostId = 0;
    _hostId[0] = '\0';
}

ProcessControler::~ProcessControler()
{
}

void ProcessControler::init(DataService* db,const int codigoProceso,const int numJob,const int codCicloFact,HostId * hostId)
{
    _db = db;
    _numJob = numJob;
    _codCicloFact = codCicloFact;
    _codProceso = codigoProceso;

    if (hostId->_hostIdValido)
    {
    	_indHostId = 1;
        strcpy (_hostId,hostId->_nombre);
    }
}

void ProcessControler::iniciaNormal()
{
    FA_TRAZAPROC_RECORDSET* records;
    RECORD_FA_TRAZAPROC_DTO record;
    RECORD_STAT_FA_TRAZAPROC_DTO statProc;

    records = &(_db->select_FA_TRAZAPROC(_codProceso, _codCicloFact, _hostId, _indHostId));

    if(records->NUM_OF_RECORDS > 0)
    {
        for(int i = 0; i < records->NUM_OF_RECORDS; i++)
        {
            record.clear();
            record = records->RECORDSET[i];

            if(record.COD_ESTAPREC != record.COD_ESTAPROC)
            {
                STRING1000 errorMsg;
                errorMsg << "ERROR PROCESO, NO HA TERMINADO:" << ENDL;
                errorMsg << "[COD_ESTAPREC] = [" << record.COD_ESTAPREC << "]" << ENDL;
                errorMsg << "[COD_ESTAPROC] = [" << record.COD_ESTAPROC << "]" << ENDL;
                errorMsg << "[COD_PROCPREC] = [" << record.COD_PROCPREC << "]" << ENDL;
                errorMsg << "[DES_PROCESO]  = [" << record.DES_PROCESO << "]" << ENDL;
                errorMsg << "[DES_PROCPREC] = [" << record.DES_PROCPREC << "]" << ENDL;
                throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
            }
        }
    }

    statProc = _db->selectSTAT_FA_TRAZAPROC(_codProceso, _codCicloFact, _hostId, _indHostId);

    if(!statProc.RECORD_FOUND)
    {
        _db->insert_FA_TRAZAPROC(_codCicloFact, _codProceso, COD_PROC_EST_RUN, _hostId ); ///< Inserta proceso en ejecucion.
        _db->commit();
        return;
    }

    if(statProc.COD_ESTAPROC == COD_PROC_EST_OK)
    {
        RECORD_FA_PROCFACT_DTO recordFA_PROCFACT;
        recordFA_PROCFACT = _db->select_FA_PROCFACT(_codProceso); ///< Se obtiene indicador de reproceso

        if(recordFA_PROCFACT.IND_REPROCESO == 0)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << _codProceso << " YA HA TERMINADO OK. Y NO REPROCESABLE" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
        }
        return;
    } else if(statProc.COD_ESTAPROC == COD_PROC_EST_RUN)
    {
        STRING1000 errorMsg;
        errorMsg << "PROCESO, " << _codProceso << " REGISTRADO EN EJECUCION, NO SE PUEDE CONTINUAR HASTA QUE TERMINE PROCESO EN EJECUCION" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
    } else if(statProc.COD_ESTAPROC == COD_PROC_EST_ERR)
    {
        STRING1000 errorMsg;
        errorMsg << "PROCESO, " << _codProceso << " REGISTRADO EN ERROR." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
    }

    STRING1000 errorMsg;
    errorMsg << "PROCESO, " << _codProceso << " CON ESTADO DESCONOCIDO: [" << statProc.COD_ESTAPROC << "]." << ENDL;
    throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);

    return;
}


void ProcessControler::iniciaProceso()
{
    if(_numJob > 0)
    {
#ifdef _JOB
        iniciaJob();
#endif
    }
    else
    {
        iniciaNormal();
    }
    return;
}



int ProcessControler::procesoEnError(std::ofstream& logFile, LogBuffer& logger)
{
    try
    {
        logger << "ROLLBACK..." << ENDLLOGGER;

        _db->rollback();

        if(_numJob > 0)
        {
#ifdef _JOB
            _db->update_FA_TRAZAPROC_JOB_TO(COD_PROC_EST_ERR, GLS_EST_ERR,
                                            _codCicloFact,
                                            _numJob,
                                            _seqRepro,
                                            _hostId,
                                            _indHostId);
#endif
            _db->commit();
        }
        else
        {
            _db->update_FA_TRAZAPROC(COD_PROC_EST_ERR, GLS_EST_ERR, _codCicloFact,_codProceso, _hostId, _indHostId);
            _db->commit();
        }
    }
    catch(otl_exception& error)
    {
        logger << "ERROR SQL EN PROCESO:" << ENDLLOGGER;
        logger << ": " << error.msg << ENDLLOGGER;
        logger << ": " << error.stm_text << ENDLLOGGER;
        logger << ": " << error.var_info<< ENDLLOGGER;
    }

    streamOutLog(logFile, logger);

    return 0;
}



void ProcessControler::finProcesoOk()
{
    if(_numJob > 0)
    {
#ifdef _JOB
        _db->update_FA_TRAZAPROC_JOB_TO(COD_PROC_EST_OK, GLS_EST_OK,
                                        _codCicloFact,
                                        _numJob,
                                        _seqRepro,
                                        _hostId,
                                        _indHostId);
#endif
        _db->commit();
    }
    else
    {
        _db->update_FA_TRAZAPROC(COD_PROC_EST_OK, GLS_EST_OK, _codCicloFact,_codProceso, _hostId, _indHostId);
        _db->commit();
    }
}


#ifdef _JOB
void ProcessControler::iniciaJob()
{
    if(!verificaJob())
    {
        STRING1000 errorMsg;
        errorMsg << "JOB = [" << _numJob << "] NO DISPONIBLE." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
    }

    if(!verificaCicloJob(_codCicloFact, _numJob))
    {
        STRING1000 errorMsg;
        errorMsg << "[COD_CICLFACT] = [" << _codCicloFact << "] NO DISPONIBLE PARA JOB = ["
                 << _numJob << "]..." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
    }

    RECORD_FA_PROCFACT_DTO recordFA_PROCFACT;

    recordFA_PROCFACT = _db->select_FA_PROCFACT(_codProceso);

    int maxSeqRepro = 0;

    maxSeqRepro = _db->select_FA_TRAZAPROC_JOB_TO_SEQ_REPRO(_codProceso,
                                                            _codCicloFact,
                                                            _numJob);

    if(maxSeqRepro > 0)
    {
        if(recordFA_PROCFACT.IND_REPROCESO == 0)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << _codProceso << " ENCONTRADO EN FA_TRAZAPROC_JOB_TO PARA JOB = ["
                     << _numJob << "] Y NO ES REPROCESABLE." << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
        }

        _reproMode = true;
    }

    _seqRepro = maxSeqRepro + 1;


    FA_TRAZAPROC_RECORDSET* records;
    RECORD_FA_TRAZAPROC_DTO record;
    RECORD_STAT_FA_TRAZAPROC_DTO statProc;

    records = &(_db->select_FA_TRAZAPROC_JOB_TO(_codProceso,
                                                _codCicloFact,
                                                _numJob,
                                                _seqRepro));

    if(records->NUM_OF_RECORDS > 0)
    {
        for(int i = 0; i < records->NUM_OF_RECORDS; i++)
        {
            record.clear();
            record = records->RECORDSET[i];

            if(record.COD_ESTAPREC != record.COD_ESTAPROC)
            {
                STRING1000 errorMsg;
                errorMsg << "ERROR PROCESO, NO HA TERMINADO PARA JOB[" << _numJob << "]:" << ENDL;
                errorMsg << "[COD_ESTAPREC] = [" << record.COD_ESTAPREC << "]" << ENDL;
                errorMsg << "[COD_ESTAPROC] = [" << record.COD_ESTAPROC << "]" << ENDL;
                errorMsg << "[COD_PROCPREC] = [" << record.COD_PROCPREC << "]" << ENDL;
                errorMsg << "[DES_PROCESO]  = [" << record.DES_PROCESO << "]" << ENDL;
                errorMsg << "[DES_PROCPREC] = [" << record.DES_PROCPREC << "]" << ENDL;
                errorMsg << "[SEC_REPROCESO]= [" << _seqRepro << "]" << ENDL;
                throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
            }
        }
    }

    if(_reproMode)
    {
        statProc = _db->selectSTAT_FA_TRAZAPROC(_codProceso, _codCicloFact, _numJob, maxSeqRepro);

        if(!statProc.RECORD_FOUND)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << _codProceso << " NO REGISTRADO PARA JOB[" << _numJob << "]"
                     << " SEC_REPRO[" << maxSeqRepro << "](max)" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
        }

        if(statProc.COD_ESTAPROC == COD_PROC_EST_RUN)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << _codProceso << " REGISTRADO EN EJECUCION EN JOB[" << _numJob << "]"
                     << " SEC_REPRO[" << maxSeqRepro << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
        }

        if(statProc.COD_ESTAPROC == COD_PROC_EST_ERR)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << _codProceso << " REGISTRADO EN ERROR EN JOB[" << _numJob << "]"
                     << " SEC_REPRO[" << maxSeqRepro << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
        }

        if(statProc.COD_ESTAPROC != COD_PROC_EST_OK)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << _codProceso << " CON ESTADO DESCONOCIDO: ["
                     << statProc.COD_ESTAPROC << "] EN JOB[" << _numJob << "] SEC_REPRO[" << maxSeqRepro << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
        }
    }

    _db->insert_FA_TRAZAPROC_JOB_TO(_numJob, _codCicloFact, _seqRepro);
    _db->commit();
    return;
}



bool ProcessControler::verificaJob()
{
    return _db->select_FA_JOBFACT_TO(_numJob, JOB_DISPONIBLE_STAT1, JOB_DISPONIBLE_STAT2);
}
#endif




void ProcessControler::streamOutLog(std::ofstream& logFile, LogBuffer& log)
{
    char*   pchar;

    while( (pchar = log.backLog()) != NULL )
    {
#ifdef _DEBUG
        cout << pchar;
        logFile << pchar;
#else
        logFile << pchar;
#endif
    }

#ifdef _DEBUG
    cout.flush();
    logFile.flush();
#else
    logFile.flush();
#endif

    log.clear();
    return;
}


bool ProcessControler::repro()
{
    return _reproMode;
}


int ProcessControler::getSeqRepro()
{
    return _seqRepro;
}


#ifdef _JOB
bool ProcessControler::verificaCicloJob(const int codCicloFact,
                                        const int numJob)
{
    return _db->select_FA_CRITERIOJOB_TO(codCicloFact,
                                         numJob);
}
#endif


