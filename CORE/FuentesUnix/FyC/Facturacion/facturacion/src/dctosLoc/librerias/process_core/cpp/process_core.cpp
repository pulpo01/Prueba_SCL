#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_core.cpp,v $ $Revision: 1.9 $ $Date: 2008/08/02 19:29:11 $"
#endif

#include "process_core.h"


///
/// \file process_core.cpp
///


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
volatile bool ProcessCore::_keepRuning;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


ProcessCore::ProcessCore()
{
    _sharedData = NULL;
    _dataBaseData = NULL;
    _clientePadre = NULL;
    _errorType = PROCESS;
    _errorFound = false;
    _keepRuning = true;

}


void ProcessCore::init(SharedTables* shData, DataService* dbData, int logLevel)
{
    _sharedData = shData;
    _dataBaseData = dbData;
    _log.level(logLevel);
    _fetcher.init(dbData);
}


ProcessCore::~ProcessCore()
{
}



bool ProcessCore::prepare(ClienteLocutorioPadre& clientePadre,
                          const RECORD_FA_CICLFACT_DTO& infCiclo,
                          const int numJob)
{
    STRING1000 errorMsg;
    _clientePadre = &clientePadre;
    _infCiclo = infCiclo;
    _job = numJob;
    _fecEmi = infCiclo.FEC_EMISION;

    if(_log[9])
    {
        _log << INDENT4LOGGER << "@Preparando proceso Cliente Padre [" << clientePadre.COD_CLIENTE << "@]..." << ENDLLOGGER;
    }

    _matrix.clear();

    if(_log[9])
        _log << INDENT5LOGGER << "@Cargando Plan Bolsa en Matriz de Descuento..." << ENDLLOGGER;

    if((*_clientePadre).PLAN_BOLSA.COD_PLAN.empty())
    {
        if(_log[9])
            _log << INDENT5LOGGER << "@Plan Bolsa no encontrado [COD_PLAN] = []..." << ENDLLOGGER;
    }
    else
    {
        _matrix.setPlanBolsa((*_clientePadre).PLAN_BOLSA);
    }

    if(_log[9])
        _log << INDENT5LOGGER << "@Cargando Cliente padre en Matriz de Descuento..." << ENDLLOGGER;

    _matrix.push_back(_clientePadre->COD_CLIENTE);

    for(int clie = 0; clie < (*_clientePadre).HIJOS.getNumOfRecords(); clie++)
    {
        if(_log[9])
            _log << INDENT5LOGGER << "@Cargando Cliente hijo [" << clie << "@]:[" <<  (*_clientePadre).HIJOS[clie].COD_CLIENTE
                 << "@] en Matriz de Descuento..." << ENDLLOGGER;

        _matrix.push_back((*_clientePadre).HIJOS[clie].COD_CLIENTE);
    }

    if(!(*_clientePadre).PLAN_BOLSA.COD_PLAN.empty())
    {
        if(_log[9])
            _log << INDENT5LOGGER << "@Cargando Conceptos Plan Bolsa [COD_PLAN]: [" << (*_clientePadre).PLAN_BOLSA.COD_PLAN
                 << "@] en Matriz de Descuento..." << ENDLLOGGER;

        for(int concepto = 0; concepto < (*_clientePadre).PLAN_BOLSA.CRITERIO_EVAL.getNumOfRecords(); concepto++)
        {
            if(_log[9])
                _log << INDENT6LOGGER << "@Concepto EVAL [" << concepto << "@]:["
                     <<  (*_clientePadre).PLAN_BOLSA.CRITERIO_EVAL[concepto].COD_CONCEPTO << "@]..." << ENDLLOGGER;

            _matrix.push_back((*_clientePadre).PLAN_BOLSA.CRITERIO_EVAL[concepto].COD_CONCEPTO);
        }

        for(int concepto = 0; concepto < (*_clientePadre).PLAN_BOLSA.CRITERIO_APLI.getNumOfRecords(); concepto++)
        {
            if(_log[9])
                _log << INDENT6LOGGER << "@Concepto APLI [" << concepto << "@]:["
                     <<  (*_clientePadre).PLAN_BOLSA.CRITERIO_APLI[concepto].COD_CONCEPTO_DESCONTAR << "@]..." << ENDLLOGGER;

            _matrix.push_back((*_clientePadre).PLAN_BOLSA.CRITERIO_APLI[concepto].COD_CONCEPTO_DESCONTAR);
        }
    }


    if(_log[9])
        _log << INDENT5LOGGER << "@Cargando Conceptos Planes Add en Matriz de Descuento..." << ENDLLOGGER;

    for(int planAdd = 0; planAdd < (*_clientePadre).PLANES_ADD.getNumOfRecords(); planAdd++)
    {
        if(_log[9])
            _log << INDENT6LOGGER << "@Plan [" << planAdd << "@]:["
            <<  (*_clientePadre).PLANES_ADD[planAdd].COD_PLAN << "@]..." << ENDLLOGGER;

        for(int concepto = 0; concepto < (*_clientePadre).PLANES_ADD[planAdd].CRITERIO_EVAL.getNumOfRecords(); concepto++)
        {
            if(_log[9])
                _log << INDENT7LOGGER << "@Concepto EVAL [" << concepto << "@]:["
                     <<  (*_clientePadre).PLANES_ADD[planAdd].CRITERIO_EVAL[concepto].COD_CONCEPTO << "@]..." << ENDLLOGGER;

            _matrix.push_back((*_clientePadre).PLANES_ADD[planAdd].CRITERIO_EVAL[concepto].COD_CONCEPTO);
        }

        for(int concepto = 0; concepto < (*_clientePadre).PLANES_ADD[planAdd].CRITERIO_APLI.getNumOfRecords(); concepto++)
        {
            if(_log[9])
                _log << INDENT7LOGGER << "@Concepto APLI [" << concepto << "@]:["
                     <<  (*_clientePadre).PLANES_ADD[planAdd].CRITERIO_APLI[concepto].COD_CONCEPTO_DESCONTAR << "@]..." << ENDLLOGGER;

            _matrix.push_back((*_clientePadre).PLANES_ADD[planAdd].CRITERIO_APLI[concepto].COD_CONCEPTO_DESCONTAR);
        }
    }

    if(_log[9])
       _log << INDENT5LOGGER << "@Matriz de Descuento OK..." << ENDLLOGGER;

    _fetcher.prepare(&clientePadre, _fecEmi, _job);



#ifdef _USE_ORA_OCI_NUMBER
    /// Definicion de precision decimal interna a partir de TOL_PARAM
    (_dataBaseData->getEnv())->setDr(_parameters._redondeo_interno);
#endif

    return true;
}




void ProcessCore::clear() throw()
{
    _log.clear();
    _matrix.clear();
    _clientePadre = NULL;
    _fetcher.clear();
    _infCiclo.clear();
    _job = 0;
    _fecEmi.clear();
    _errorType = PROCESS;
    _errorFound = false;
    _keepRuning = true;
}



bool ProcessCore::exec()
{
    BufferTOL_ACUMOPER_TO* buffer = NULL;
    int recordCount = 0;
    int recordProc = 0;

    if(_log[9])
        _log << INDENT4LOGGER << "@Inicio Procesamiento de trafico..." << ENDLLOGGER;


    while(1)
    {
        if(!keepRuning()) return false;

        _hrClock.markStart();
        buffer = _fetcher.getChargedBuffer(&_log);
        _hrClock.markEnd();

        _timer.setLastElapTimeSQL_MSEC(_hrClock.getElapsedTimeMSEC());
        _timer.setLastElapTimeSQL_SEC(_hrClock.getElapsedTimeSEC());

        if(buffer->size() == 0) break;

        _hrClock.markStart();
        for(int i = 0; i < buffer->size(); i++)
        {
            recordCount++;
            if(processRecord((*buffer)[i]))
                recordProc++;
        }
        _hrClock.markEnd();

        _timer.setLastElapTimeApp_MSEC(_hrClock.getElapsedTimeMSEC());
        _timer.setLastElapTimeApp_SEC(_hrClock.getElapsedTimeSEC());
    }

    if(_log[9])
    {
        _log << INDENT4LOGGER << "@Total procesado para:" << ENDLLOGGER;
        _log << INDENT5LOGGER << "@[COD_CLIENTE] = [" << _clientePadre->COD_CLIENTE << "@]:" << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[" << recordProc << "@] registros de [" << recordCount << "@]." << ENDLLOGGER;
    }

    if(_log[9])
    {
        _log << INDENT4LOGGER << "@Estadisticas de proceso:" << ENDLLOGGER;
        _log << INDENT5LOGGER << "@[SQL_TIME]:." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[AVG_SQL_TIME_SEC]    = [" << _timer._avgElapTimeSQL_SEC << "@]." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[AVG_SQL_TIME_MSEC]   = [" << _timer._avgElapTimeSQL_MSEC << "@]." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[TOTAL_SQL_TIME_SEC]  = [" << _timer._totalTimeSQL_SEC << "@]." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[TOTAL_SQL_TIME_MSEC] = [" << _timer._totalTimeSQL_MSEC << "@]." << ENDLLOGGER;

        _log << INDENT5LOGGER << "@[CPU_TIME]:." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[AVG_CPU_TIME_SEC]    = [" << _timer._avgElapTimeApp_SEC << "@]." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[AVG_CPU_TIME_MSEC]   = [" << _timer._avgElapTimeApp_MSEC << "@]." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[TOTAL_CPU_TIME_SEC]  = [" << _timer._totalTimeApp_SEC << "@]." << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[TOTAL_CPU_TIME_MSEC] = [" << _timer._totalTimeApp_MSEC << "@]." << ENDLLOGGER;
    }

    if(_log[9])
        _log << INDENT4LOGGER << "@Evaluando planes de descuento..." << ENDLLOGGER;

    streamOutResults();

    return true;
}


bool ProcessCore::processRecord(const RECORD_TOL_ACUMOPER_TO_DTO& record)
{
    ConceptoTrafico tmpRec;

    tmpRec.clear();

    SH_FA_CONCEPTOS::iterator itr;

    itr = _sharedData->_FA_CONCEPTOS.find(record.COD_CARG);

    if(itr == _sharedData->_FA_CONCEPTOS.end())
    {
        //if(_log[9])
        //    _log << INDENT5LOGGER << "@Se rechaza concepto [" << record.COD_CARG << "@] no se encontro en FA_CONCEPTOS..." << ENDLLOGGER;

        return false;
    }

    tmpRec.TIP_CONCEPTO << (itr->second).COD_TIPCONCE;

    tmpRec.COD_CLIENTE = record.COD_CLIENTE;
    tmpRec.COD_CONCEPTO << record.COD_CARG;
    tmpRec.DUR_FACT = record.DUR_FACT;
    tmpRec.MTO_FACT = record.MTO_FACT;
    tmpRec.NUM_UNIDADES = record.CNT_INICIAL;


    _matrix[tmpRec.COD_CONCEPTO][tmpRec.COD_CLIENTE] += tmpRec;

    return true;
}






void ProcessCore::execute()
{
    try
    {
        if(!exec())
            if(_log[9])
                _log << INDENT4LOGGER << "@Procesamiento Interrumpido..." << ENDLLOGGER;
    }
    catch(otl_exception& error)
    {
        _errorType = SQL;
        _errorFound = true;
        _keepRuning = false;
        _errorSql = error;
    }
    catch(ProcessCoreException& error)
    {
        _errorType = PROCESS;
        _errorFound = true;
        _keepRuning = false;
        _errorProcess = error;
    }

    signalThreadEnd();
}







void ProcessCore::streamOutResults()
{
    STRING1000 evalMsg;
    RECORD_FA_DETDCTOCLIELOC_TO_DTO recordOut;
    int solCuadrantePlanBolsa;


    if(_log[9])
    {
        _log << INDENT5LOGGER << "@Evaluando plan Bolsa:" << ENDLLOGGER;
        _log << INDENT6LOGGER << "@[COD_PLAN]   = [" << _clientePadre->PLAN_BOLSA.COD_PLAN << "@]" << ENDLLOGGER;
    }

    evalMsg.clear();
    solCuadrantePlanBolsa = _matrix.getCuadranEvalPlanBolsa(evalMsg);

    if(_log[9])
        _log << INDENT7LOGGER << "@..." << evalMsg << "..." << ENDLLOGGER;


    _outputBuffer.clear();

    if(solCuadrantePlanBolsa >= 0)
    {
        recordOut.clear();
        chargeRecordOut(recordOut,
                        _clientePadre->COD_CLIENTE,
                        _infCiclo.COD_CICLO,
                        _clientePadre->PLAN_BOLSA,
                        solCuadrantePlanBolsa);
        if(recordOut.VALOR_DCTO > 0)
        {
            if(_log[9])
            {
                _log << INDENT5LOGGER << "@Insertando resultado:" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_CICLO]     = [" << recordOut.COD_CICLO << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "@]" << ENDLLOGGER;
            }

            _outputBuffer.push(recordOut);
            //_dataBaseData->insert_FA_DETDCTOCLIELOC(recordOut, _infCiclo.COD_CICLOFACT, _job);
        }
        else
        {
            if(_log[9])
            {
                _log << INDENT5LOGGER << "@[VALOR_DCTO] = 0 para:" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                _log << INDENT7LOGGER << "@No genera registro de descuento..." << ENDLLOGGER;
            }
        }

        for(int i = 0; i < _clientePadre->HIJOS.getNumOfRecords(); i++)
        {
            recordOut.clear();
            chargeRecordOut(recordOut,
                            _clientePadre->HIJOS[i].COD_CLIENTE,
                            _infCiclo.COD_CICLO,
                            _clientePadre->PLAN_BOLSA,
                            solCuadrantePlanBolsa);
            if(recordOut.VALOR_DCTO > 0)
            {
                if(_log[9])
                {
                    _log << INDENT5LOGGER << "@Insertando resultado:" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_CICLO]     = [" << recordOut.COD_CICLO << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "@]" << ENDLLOGGER;
                }

                _outputBuffer.push(recordOut);
                //_dataBaseData->insert_FA_DETDCTOCLIELOC(recordOut, _infCiclo.COD_CICLOFACT, _job);
            }
            else
            {
                if(_log[9])
                {
                    _log << INDENT5LOGGER << "@[VALOR_DCTO] = 0 para:" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                    _log << INDENT7LOGGER << "@No genera registro de descuento..." << ENDLLOGGER;
                }
            }
        }
    }
    else
    {
        if(_log[9])
            _log << INDENT5LOGGER << "@No Aplica plan [" << _clientePadre->PLAN_BOLSA.COD_PLAN << "@] (plan bolsa)" << ENDLLOGGER;
    }

    int solCuadrantePlanAdd;
    for(int plan = 0; plan < _clientePadre->PLANES_ADD.getNumOfRecords(); plan++)
    {

        if(_log[9])
        {
            _log << INDENT5LOGGER << "@Evaluando plan:" << ENDLLOGGER;
            _log << INDENT6LOGGER << "@[COD_PLAN]   = [" << _clientePadre->PLANES_ADD[plan].COD_PLAN << "@]" << ENDLLOGGER;
        }

        evalMsg.clear();
        solCuadrantePlanAdd = _matrix.getCuadranEvalRemanPlan(_clientePadre->PLANES_ADD[plan], solCuadrantePlanBolsa, evalMsg);

        if(_log[9])
            _log << INDENT7LOGGER << "@..." << evalMsg << "..." << ENDLLOGGER;

        if(solCuadrantePlanAdd < 0)
        {
            if(_log[9])
                _log << INDENT5LOGGER << "@No Aplica plan [" << _clientePadre->PLANES_ADD[plan].COD_PLAN << "@]" << ENDLLOGGER;
            continue;
        }
        recordOut.clear();
        chargeRecordOut(recordOut,
                        _clientePadre->COD_CLIENTE,
                        _infCiclo.COD_CICLO,
                        _clientePadre->PLANES_ADD[plan],
                        solCuadrantePlanAdd);
        if(recordOut.VALOR_DCTO > 0)
        {
            if(_log[9])
            {
                _log << INDENT5LOGGER << "@Insertando resultado:" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_CICLO]     = [" << recordOut.COD_CICLO << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "@]" << ENDLLOGGER;
            }

            _outputBuffer.push(recordOut);
            //_dataBaseData->insert_FA_DETDCTOCLIELOC(recordOut, _infCiclo.COD_CICLOFACT, _job);
        }
        else
        {
            if(_log[9])
            {
                _log << INDENT5LOGGER << "@[VALOR_DCTO] = 0 para:" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                _log << INDENT7LOGGER << "@No genera registro de descuento..." << ENDLLOGGER;
            }
        }


        for(int hijo = 0; hijo < _clientePadre->HIJOS.getNumOfRecords(); hijo++)
        {
            recordOut.clear();
            chargeRecordOut(recordOut,
                            _clientePadre->HIJOS[hijo].COD_CLIENTE,
                            _infCiclo.COD_CICLO,
                            _clientePadre->PLANES_ADD[plan],
                            solCuadrantePlanAdd);
            if(recordOut.VALOR_DCTO > 0)
            {
                if(_log[9])
                {
                    _log << INDENT5LOGGER << "@Insertando resultado:" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_CICLO]     = [" << recordOut.COD_CICLO << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "@]" << ENDLLOGGER;
                }

                _outputBuffer.push(recordOut);
                //_dataBaseData->insert_FA_DETDCTOCLIELOC(recordOut, _infCiclo.COD_CICLOFACT, _job);
            }
            else
            {
                if(_log[9])
                {
                    _log << INDENT5LOGGER << "@[VALOR_DCTO] = 0 para:" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "@]" << ENDLLOGGER;
                    _log << INDENT6LOGGER << "@[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "@]" << ENDLLOGGER;
                    _log << INDENT7LOGGER << "@No genera registro de descuento..." << ENDLLOGGER;
                }
            }
        }
    }
}



void ProcessCore::chargeRecordOut(RECORD_FA_DETDCTOCLIELOC_TO_DTO& recordOut,
                                  const int codCliente,
                                  const int codCiclo,
                                  const PlanDescuento& plan,
                                  const int cuadrante)
{
    recordOut.COD_CLIENTE   = codCliente;
    recordOut.COD_CICLO  = codCiclo;
    recordOut.COD_PLANDESC  = plan.COD_PLAN;
    recordOut.NUM_SECUENCIA = plan.NUM_SEC;
    recordOut.COD_GRUPOAPLI = atoi(plan.CRITERIO_APLI.COD_GRUPO.c_str());
    recordOut.NUM_CUADRANTE = plan.CUADRANTE_PLAN.NUM_CUADRANTE;
    recordOut.TIP_DCTO      = const_cast<Cuadrante&>(plan.CUADRANTE_PLAN)[cuadrante]._tipoDcto;
    recordOut.TIP_ENTIDAD   = plan.TIP_ENTIDAD;

    if(recordOut.TIP_DCTO == "M")
        recordOut.VALOR_DCTO = _matrix.getTotalDctoCliente(codCliente, cuadrante);
    else
        recordOut.VALOR_DCTO = const_cast<Cuadrante&>(plan.CUADRANTE_PLAN)[cuadrante]._valDcto;

    return;
}



void ProcessCore::check()
{
    if(_errorFound)
    {
        if(_errorType == PROCESS) throw _errorProcess;
        if(_errorType == SQL) throw _errorSql;
    }

    return;
}




LogBuffer& ProcessCore::backLog()
{
    return _log;
}






void ProcessCore::streamOutResults(DataService* dbData)
{
    for(int i = 0; i < _outputBuffer.size(); i++)
    {
        dbData->insert_FA_DETDCTOCLIELOC(_outputBuffer[i], _infCiclo.COD_CICLOFACT, _job);
    }
}





bool ProcessCore::keepRuning()
{
    bool runStat;

    runStat = _keepRuning;

    return runStat;
}




ClienteLocutorioPadre* ProcessCore::getClientePadre()
{
    return _clientePadre;
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


