#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_controler.cpp,v $ $Revision: 1.8 $ $Date: 2008/06/17 22:20:58 $"
#endif

///
/// \file process_controler.cpp
///




#include "process_controler.h"


ProcessControler::ProcessControler()
{
    _db = NULL;
    _numJob = -99;
    _codCicloFact = -99;
    _seqRepro = 0;
    _reproMode = false;
}



ProcessControler::~ProcessControler()
{
}



void ProcessControler::init(DataService* db, const int numJob, const int codCicloFact)
{
    _db = db;
    _numJob = numJob;
    _codCicloFact = codCicloFact;
}




void ProcessControler::iniciaProceso()
{
    if(_numJob > 0)
    {
        iniciaJob();
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
            _db->update_FA_TRAZAPROC_JOB_TO(PROC_EST_ERR, GLS_EST_ERR,
                                            _codCicloFact,
                                            _numJob,
                                            _seqRepro);
            _db->commit();
        }
        else
        {
            _db->update_FA_TRAZAPROC(PROC_EST_ERR, GLS_EST_ERR, _codCicloFact);
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
        _db->update_FA_TRAZAPROC_JOB_TO(PROC_EST_OK, GLS_EST_OK,
                                        _codCicloFact,
                                        _numJob,
                                        _seqRepro);
        _db->commit();
    }
    else
    {
        _db->update_FA_TRAZAPROC(PROC_EST_OK, GLS_EST_OK, _codCicloFact);
        _db->commit();
    }
}



void ProcessControler::iniciaNormal()
{
    FA_TRAZAPROC_RECORDSET* records;
    RECORD_FA_TRAZAPROC_DTO record;
    RECORD_STAT_FA_TRAZAPROC_DTO statProc;
    RECORD_FA_PROCFACT_DTO recordFA_PROCFACT;

    recordFA_PROCFACT = _db->select_FA_PROCFACT(COD_PROCESS_FACTURACION);


    records = &(_db->select_FA_TRAZAPROC(COD_PROCESS_FACTURACION, _codCicloFact));

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
                throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
            }
        }
    }

    statProc = _db->selectSTAT_FA_TRAZAPROC(COD_PROCESS_FACTURACION, _codCicloFact);

    if(!statProc.RECORD_FOUND)
    {
        _db->insert_FA_TRAZAPROC(_codCicloFact);
        _db->commit();
        return;
    }

    if(statProc.COD_ESTAPROC == PROC_EST_OK)
    {
        if(recordFA_PROCFACT.IND_REPROCESO == 0)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION << " YA HA TERMINADO OK. Y NO REPROCESABLE" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }

        return;
    }

    if(statProc.COD_ESTAPROC == PROC_EST_RUN)
    {
        STRING1000 errorMsg;
        errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION << " REGISTRADO EN EJECUCION." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    if(statProc.COD_ESTAPROC == PROC_EST_ERR)
    {
        STRING1000 errorMsg;
        errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION << " REGISTRADO EN ERROR." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    STRING1000 errorMsg;
    errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION << " CON ESTADO DESCONOCIDO: [" << statProc.COD_ESTAPROC << "]." << ENDL;
    throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);

    return;
}



void ProcessControler::iniciaJob()
{
    if(!verificaJob())
    {
        STRING1000 errorMsg;
        errorMsg << "JOB = [" << _numJob << "] NO DISPONIBLE." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    if(!verificaCicloJob(_codCicloFact, _numJob))
    {
        STRING1000 errorMsg;
        errorMsg << "[COD_CICLFACT] = [" << _codCicloFact << "] NO DISPONIBLE PARA JOB = ["
                 << _numJob << "]..." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    RECORD_FA_PROCFACT_DTO recordFA_PROCFACT;

    recordFA_PROCFACT = _db->select_FA_PROCFACT(COD_PROCESS_FACTURACION_JOB);

    int maxSeqRepro = 0;

    maxSeqRepro = _db->select_FA_TRAZAPROC_JOB_TO_SEQ_REPRO(COD_PROCESS_FACTURACION_JOB,
                                                            _codCicloFact,
                                                            _numJob);

    if(maxSeqRepro > 0)
    {
        if(recordFA_PROCFACT.IND_REPROCESO == 0)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION_JOB << " ENCONTRADO EN FA_TRAZAPROC_JOB_TO PARA JOB = ["
                     << _numJob << "] Y NO ES REPROCESABLE." << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }

        _reproMode = true;
    }

    _seqRepro = maxSeqRepro + 1;


    FA_TRAZAPROC_RECORDSET* records;
    RECORD_FA_TRAZAPROC_DTO record;
    RECORD_STAT_FA_TRAZAPROC_DTO statProc;

    records = &(_db->select_FA_TRAZAPROC_JOB_TO(COD_PROCESS_FACTURACION_JOB,
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
                throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
            }
        }
    }

    if(_reproMode)
    {
        statProc = _db->selectSTAT_FA_TRAZAPROC(COD_PROCESS_FACTURACION_JOB, _codCicloFact, _numJob, maxSeqRepro);

        if(!statProc.RECORD_FOUND)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION_JOB << " NO REGISTRADO PARA JOB[" << _numJob << "]"
                     << " SEC_REPRO[" << maxSeqRepro << "](max)" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }

        if(statProc.COD_ESTAPROC == PROC_EST_RUN)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION_JOB << " REGISTRADO EN EJECUCION EN JOB[" << _numJob << "]"
                     << " SEC_REPRO[" << maxSeqRepro << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }

        if(statProc.COD_ESTAPROC == PROC_EST_ERR)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION_JOB << " REGISTRADO EN ERROR EN JOB[" << _numJob << "]"
                     << " SEC_REPRO[" << maxSeqRepro << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }

        if(statProc.COD_ESTAPROC != PROC_EST_OK)
        {
            STRING1000 errorMsg;
            errorMsg << "PROCESO, " << COD_PROCESS_FACTURACION_JOB << " CON ESTADO DESCONOCIDO: ["
                     << statProc.COD_ESTAPROC << "] EN JOB[" << _numJob << "] SEC_REPRO[" << maxSeqRepro << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
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


bool ProcessControler::verificaCicloJob(const int codCicloFact,
                                        const int numJob)
{
    return _db->select_FA_CRITERIOJOB_TO(codCicloFact,
                                         numJob);
}



