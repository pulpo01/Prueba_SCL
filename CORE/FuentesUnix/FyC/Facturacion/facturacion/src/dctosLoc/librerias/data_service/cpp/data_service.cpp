#ifndef NO_INDENT
#ident "@(#)$RCSfile: data_service.cpp,v $ $Revision: 1.12 $ $Date: 2008/08/04 21:25:28 $"
#endif


#include "data_service.h"

///
/// \file data_service.cpp 
///



void getErrorInOraOciNumber(const char* msg, int numError)
{
    throw ProcessCoreException((char*) msg, (char*) "1000", OTL_SQL_FATAL_ERROR, (char*) "01");
}


DataService::DataService()
{
    _mode = MAIN;
    _oracleEviroment = NULL;
    _oracleEviroment = new OraOciEnviroment(getErrorInOraOciNumber);

    _isCommitable = false;

    _FA_CICLFACT = NULL;
    _FA_CICLOCLI = NULL;
    _FA_CICLOCLI_JOB = NULL;
    _FA_CLIENTEJOB_TO = NULL;

    _GAT_PLANDESCABO = NULL;
    _ciclo_GAT_PLANDESCABO.clear();
    _job_GAT_PLANDESCABO.clear();

    _FAD_CONCEVAL = NULL;
    _FAD_CONCAPLI = NULL;
    _FAD_CUADRANDESC = NULL;
    _FA_PROCFACT = NULL;
    _FA_TRAZAPROC_JOB_TO_SEQ_REPRO = NULL;
    _FA_TRAZAPROC = NULL;
    _statFA_TRAZAPROC = NULL;
    _statFA_TRAZAPROC_JOB_TO = NULL;
    _FA_TRAZAPROC_JOB_TO = NULL;
    _iFA_TRAZAPROC = NULL;
    _uFA_TRAZAPROC = NULL;
    _iFA_TRAZAPROC_JOB_TO = NULL;
    _uFA_TRAZAPROC_JOB_TO = NULL;
    _FA_JOBFACT_TO = NULL;
    _FA_CRITERIOJOB_TO = NULL;

    _TOL_ACUMOPER_TO = NULL;
    _FA_DETDCTOCLIELOC_TO = NULL;
    _del_FA_DETDCTOCLIELOC_TO = NULL;
    _ciclo.clear();
    _job.clear();
    _name_FA_DETDCTOCLIELOC_TO.clear();



}

DataService::~DataService()
{
    try
    {
        clear();
        closeConnDb();
    }
    catch(otl_exception& error)
    {
        cout << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        cout << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        cout << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
    }
    catch(ProcessCoreException& error)
    {
        cout << "ERROR       = [" << (char*) error.what() << "]" << ENDL;
        cout << "ERROR_ID    = [" << error.errNum() << "]" << ENDL;
        cout << "ERROR_CASE  = [" << error.errCase() << "]" << ENDL;
    }
}

bool DataService::reInitializeConnDb(const STRING& dbUserPassSid)
{
    try
    {
        clear();
        closeConnDb();
        initializeConnDb(dbUserPassSid);
    }
    catch(otl_exception& error)
    {
        cout << "FAIL RE-INIT CONNECION DB..." << ENDL;
        cout << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        cout << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        cout << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        return false;
    }
    return true;
}

void DataService::clear()
{
    _FA_CICLOCLI_RECORDS.clear();
    if(_FA_CICLFACT != NULL) delete _FA_CICLFACT;
    if(_FA_CICLOCLI != NULL) delete _FA_CICLOCLI;
    if(_FA_CICLOCLI_JOB != NULL) delete _FA_CICLOCLI_JOB;
    if(_FA_CLIENTEJOB_TO != NULL) delete _FA_CLIENTEJOB_TO;

    if(_GAT_PLANDESCABO != NULL) delete _GAT_PLANDESCABO;
    _GAT_PLANDESCABO_RECORDS.clear();
    _ciclo_GAT_PLANDESCABO.clear();
    _job_GAT_PLANDESCABO.clear();


    if(_FAD_CONCEVAL != NULL) delete _FAD_CONCEVAL;
    _FAD_CONCEVAL_RECORDS.clear();
    if(_FAD_CONCAPLI != NULL) delete _FAD_CONCAPLI;
    _FAD_CONCAPLI_RECORDS.clear();
    if(_FAD_CUADRANDESC != NULL) delete _FAD_CUADRANDESC;
    _FAD_CUADRANDESC_RECORDS.clear();

    if(_FA_PROCFACT != NULL) delete _FA_PROCFACT;
    if(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO != NULL) delete _FA_TRAZAPROC_JOB_TO_SEQ_REPRO;
    if(_FA_TRAZAPROC != NULL) delete _FA_TRAZAPROC;
    if(_statFA_TRAZAPROC != NULL) delete _statFA_TRAZAPROC;
    if(_statFA_TRAZAPROC_JOB_TO != NULL) delete _statFA_TRAZAPROC_JOB_TO;
    if(_FA_TRAZAPROC_JOB_TO != NULL) delete _FA_TRAZAPROC_JOB_TO;
    if(_iFA_TRAZAPROC != NULL) delete _iFA_TRAZAPROC;
    if(_uFA_TRAZAPROC != NULL) delete _uFA_TRAZAPROC;
    if(_iFA_TRAZAPROC_JOB_TO != NULL) delete _iFA_TRAZAPROC_JOB_TO;
    if(_uFA_TRAZAPROC_JOB_TO != NULL) delete _uFA_TRAZAPROC_JOB_TO;
    if(_FA_JOBFACT_TO != NULL) delete _FA_JOBFACT_TO;
    if(_FA_CRITERIOJOB_TO != NULL) delete _FA_CRITERIOJOB_TO;
    _FA_TRAZAPROC_RECORDS.clear();


    if(_TOL_ACUMOPER_TO != NULL) delete _TOL_ACUMOPER_TO;
    _recordTOL_ACUMOPER_TO.clear();

    if(_FA_DETDCTOCLIELOC_TO != NULL) delete _FA_DETDCTOCLIELOC_TO;
    if(_del_FA_DETDCTOCLIELOC_TO != NULL) delete _del_FA_DETDCTOCLIELOC_TO;
    _ciclo.clear();
    _job.clear();
    _name_FA_DETDCTOCLIELOC_TO.clear();

}

void DataService::initializeConnDb(const STRING& dbUserPassSid)
{
    //\ La llamada a este methodo debe realizarse con try - catch de otlexeption
    //\ para recuperar todo posible error en la conexion a la base de datos o 
    //\ en la llamada a las queries de carga de datos

    _connectString = dbUserPassSid;
    _db.rlogon(_connectString.c_str());
    //_timeFetcher = new otl_stream(1024, "select to_char(sysdate,'yyyy-mm-dd@hh24:mi:ss') from dual where 1 = :test<int>", _db);

    if(_mode == MAIN)
    {
        _FA_CICLFACT = new otl_stream(1024, QUERY_FA_CICLFACT, _db);
        _FA_CICLOCLI = new otl_stream(1024, QUERY_FA_CICLOCLI, _db);
        _FA_CICLOCLI_JOB = new otl_stream(1024, QUERY_FA_CICLOCLI_JOB, _db);
        _FA_CLIENTEJOB_TO = new otl_stream(1024, QUERY_FA_CLIENTEJOB_TO, _db);

        _FAD_CONCEVAL = new otl_stream(1024, QUERY_FAD_CONCEVAL, _db);
        _FAD_CONCAPLI = new otl_stream(1024, QUERY_FAD_CONCAPLI, _db);
        _FAD_CUADRANDESC = new otl_stream(1024, QUERY_FAD_CUADRANDESC, _db);

        _FA_PROCFACT = new otl_stream(1024, QUERY_FA_PROCFACT, _db);
        _FA_TRAZAPROC_JOB_TO_SEQ_REPRO = new otl_stream(1024, QUERY_FA_TRAZAPROC_JOB_TO_SEQ_REPRO, _db);
        _FA_TRAZAPROC = new otl_stream(1024, QUERY_FA_TRAZAPROC, _db);
        _statFA_TRAZAPROC = new otl_stream(1024, QUERY_STAT_FA_TRAZAPROC, _db);
        _statFA_TRAZAPROC_JOB_TO = new otl_stream(1024, QUERY_STAT_FA_TRAZAPROC_JOB_TO, _db);
        _FA_TRAZAPROC_JOB_TO = new otl_stream(1024, QUERY_FA_TRAZAPROC_JOB_TO, _db);
        _iFA_TRAZAPROC = new otl_nocommit_stream(1024, QUERY_INSERT_FA_TRAZAPROC, _db);
        _uFA_TRAZAPROC = new otl_nocommit_stream(1024, QUERY_UPDATE_FA_TRAZAPROC, _db);
        _iFA_TRAZAPROC_JOB_TO = new otl_nocommit_stream(1024, QUERY_INSERT_FA_TRAZAPROC_JOB, _db);
        _uFA_TRAZAPROC_JOB_TO = new otl_nocommit_stream(1024, QUERY_UPDATE_FA_TRAZAPROC_JOB_TO, _db);
        _FA_JOBFACT_TO = new otl_stream(1024, QUERY_FA_JOBFACT_TO, _db);
        _FA_CRITERIOJOB_TO = new otl_stream(1024, QUERY_FA_CRITERIOJOB_TO, _db);
    }
    else
    {
        _TOL_ACUMOPER_TO = new otl_stream(1024, QUERY_TOL_ACUMOPER_TO, _db);
    }

}


void DataService::closeConnDb(){
    rollback();   //\ -> Throw ProcessCoreException
    _db.logoff(); //\ -> Throw otl_exception
}


void DataService::commit()
{
    STRING1000 errorMsg;

    if(!_isCommitable) return;

    try
    {
#ifndef _ENABLE_UPDATE_INSERT
        _db.rollback();
#else
        _db.commit();
#endif
    }
    catch(otl_exception& error)
    {
        errorMsg << "COMMIT ERROR:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&) errorMsg, (char*) "1000", OTL_SQL_FATAL_ERROR, (char*) "01");
    }
    _isCommitable = false;
}

void DataService::rollback()
{
    STRING1000 errorMsg;

    if(!_isCommitable) return;

    try
    {
        _db.rollback();
    }
    catch(otl_exception& error)
    {
        errorMsg << "ROLLBACK ERROR:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&) errorMsg, (char*) "1001", OTL_SQL_FATAL_ERROR, (char*) "01");
    }
    _isCommitable = false;
}

void DataService::setMode(QUERY_MODE mode)
{
    _mode = mode;
}


void DataService::confirmChanges()
{
    _isCommitable = true;
}

STRING DataService::sysDateyyyymmddhh24miss()
{
    char   charTime[256];
    STRING   resString;
    memset(charTime,'\0',sizeof(charTime));
    //*(_timeFetcher) << 1;
    //*(_timeFetcher) >> charTime;
    resString = charTime;
    return resString;
}





float DataService::round(float Value, int NumPlaces){
    int k, Temp;
    float Factor;
    Factor = 1;
    for (k = 0; k < NumPlaces; k++)
      Factor = Factor * 10;
    Temp = (int) (Value * Factor + 0.5);
    return Temp / Factor;
}


double DataService::round(double Value, int NumPlaces){
    int k, Temp;
    double Factor;
    Factor = 1;
    for (k = 0; k < NumPlaces; k++)
      Factor = Factor * 10;
    Temp = (int) (Value * Factor + 0.5);
    return Temp / Factor;
}

OraOciEnviroment* DataService::getEnv()
{
    return _oracleEviroment;
}



RECORD_FA_CICLFACT_DTO DataService::select_FA_CICLFACT(const int codCicloFact,
                                                       const int indFacturacion)
{
    STRING1000 errorMsg;
    RECORD_FA_CICLFACT_DTO tmpRec;

    tmpRec.clear();

    try
    {
        _FA_CICLFACT->clean(1);

        *(_FA_CICLFACT) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_FA_CICLFACT) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_FA_CICLFACT) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_FA_CICLFACT) << codCicloFact;
        *(_FA_CICLFACT) << IND_TASACION_TOL;
        *(_FA_CICLFACT) << indFacturacion;

        if(_FA_CICLFACT->eof())
        {
            errorMsg << "NO EXISTE REGISTRO EN FA_CICLFACT PARA [COD_CICLFACT] = [" << codCicloFact
                     << "], [IND_TASADOR] = [" << IND_TASACION_TOL;
            errorMsg << "], [IND_FACTURACION] = [" << indFacturacion << "].";
            throw ProcessCoreException((STRING1000&) errorMsg, (char*) "XXXX", DATA_ERROR);
         }

        tmpRec.COD_CICLOFACT = codCicloFact;
        *(_FA_CICLFACT) >> tmpRec.COD_CICLO;
        *(_FA_CICLFACT) >> tmpRec.FEC_DESDELLAM;
        *(_FA_CICLFACT) >> tmpRec.FEC_HASTALLAM;
        *(_FA_CICLFACT) >> tmpRec.FEC_EMISION;
        *(_FA_CICLFACT) >> tmpRec.DIA_PERIODO;
        tmpRec.IND_FACTURACION = indFacturacion;
         
         if(!_FA_CICLFACT->eof())
         {
            errorMsg << "ERROR AL BUSCAR EN FA_CICLFACT PARA [COD_CICLFACT] = [" << codCicloFact
                     << "], [IND_TASADOR] = [" << IND_TASACION_TOL;
            errorMsg << "], [IND_FACTURACION] = [" << indFacturacion << "]. Retorna mas de una fila";
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", DATA_ERROR);
         }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_CICLFACT PARA [COD_CICLFACT] = [" << codCicloFact
                 << "], [IND_TASADOR] = [" << IND_TASACION_TOL;
        errorMsg << "], [IND_FACTURACION] = [" << indFacturacion << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    trim(tmpRec.FEC_DESDELLAM);
    trim(tmpRec.FEC_HASTALLAM);
    trim(tmpRec.FEC_EMISION);

    return tmpRec;
}



FA_CICLOCLI_RECORDSET& DataService::select_FA_CICLOCLI(const int codCliente,
                                                       const int codCiclo,
                                                       const int codCicloFact,
                                                       const int numProc,
                                                       const int indMask)
{
    STRING1000 errorMsg;

    _FA_CICLOCLI_RECORDS.clear();
    RECORD_FA_CICLOCLI_DTO tmpRec;

    try
    {
        _FA_CICLOCLI->clean(1);

        *(_FA_CICLOCLI) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_FA_CICLOCLI) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_FA_CICLOCLI) << codCliente;
        *(_FA_CICLOCLI) << codCiclo;
        *(_FA_CICLOCLI) << codCicloFact;
        *(_FA_CICLOCLI) << numProc;
        *(_FA_CICLOCLI) << indMask;

        while(!_FA_CICLOCLI->eof())
        {
            tmpRec.clear();
            *(_FA_CICLOCLI) >> tmpRec.NUM_ABONADO;
            *(_FA_CICLOCLI) >> tmpRec.FEC_ALTA;
            *(_FA_CICLOCLI) >> tmpRec.FEC_BAJA;

            trim(tmpRec.FEC_ALTA);
            trim(tmpRec.FEC_BAJA);

            _FA_CICLOCLI_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_CICLOCLI PARA [COD_CLIENTE] = [" << codCliente
                 << "], [COD_CICLO] = [" << codCiclo;
        errorMsg << "], [NUM_PROCESO] = [" << NUM_PROCESO_FA_CICLOCLI;
        errorMsg << "], [IND_MASCARA] = [" << IND_MASCARA_FA_CICLOCLI << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _FA_CICLOCLI_RECORDS.NUM_OF_RECORDS = _FA_CICLOCLI_RECORDS.RECORDSET.size();
    return _FA_CICLOCLI_RECORDS;
}





FA_CICLOCLI_RECORDSET& DataService::select_FA_CICLOCLI_JOB(const int codCliente,
                                                           const int codCiclo,
                                                           const int codCicloFact,
                                                           const int numProc)
{
    STRING1000 errorMsg;

    _FA_CICLOCLI_RECORDS.clear();
    RECORD_FA_CICLOCLI_DTO tmpRec;

    try
    {
        _FA_CICLOCLI_JOB->clean(1);

        *(_FA_CICLOCLI_JOB) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_FA_CICLOCLI_JOB) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_FA_CICLOCLI_JOB) << codCliente;
        *(_FA_CICLOCLI_JOB) << codCiclo;
        *(_FA_CICLOCLI_JOB) << codCicloFact;
        *(_FA_CICLOCLI_JOB) << numProc;


        while(!_FA_CICLOCLI_JOB->eof())
        {
            tmpRec.clear();
            *(_FA_CICLOCLI_JOB) >> tmpRec.NUM_ABONADO;
            *(_FA_CICLOCLI_JOB) >> tmpRec.FEC_ALTA;
            *(_FA_CICLOCLI_JOB) >> tmpRec.FEC_BAJA;

            trim(tmpRec.FEC_ALTA);
            trim(tmpRec.FEC_BAJA);

            _FA_CICLOCLI_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_CICLOCLI PARA [COD_CLIENTE] = [" << codCliente
                 << "], [COD_CICLO] = [" << codCiclo;
        errorMsg << "], [NUM_PROCESO] >= [" << NUM_PROCESO_FA_CICLOCLI << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _FA_CICLOCLI_RECORDS.NUM_OF_RECORDS = _FA_CICLOCLI_RECORDS.RECORDSET.size();
    return _FA_CICLOCLI_RECORDS;
}




bool DataService::select_FA_CLIENTEJOB_TO(const int codCliente,
                                          const int numJob,
                                          const int codCiclo)
{
    STRING1000 errorMsg;

    bool recordFound = false;

    try
    {
        _FA_CLIENTEJOB_TO->clean(1);

        *(_FA_CLIENTEJOB_TO) << codCliente;
        *(_FA_CLIENTEJOB_TO) << numJob;
        *(_FA_CLIENTEJOB_TO) << codCiclo;
        *(_FA_CLIENTEJOB_TO) << NUM_PROCESO_FA_CICLOCLI;

        recordFound = !_FA_CLIENTEJOB_TO->eof();
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_CLIENTEJOB_TO PARA [COD_CLIENTE] = [" << codCliente
                 << "], [COD_CICLO] = [" << codCiclo;
        errorMsg << "], [NUM_PROCESO] = [" << NUM_PROCESO_FA_CICLOCLI;
        errorMsg << "], [NUM_JOB] = [" << numJob << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    return recordFound;
}




void DataService::verifyQuery_GAT_PLANDESCABO(const int codCicloFact,
                                              const int numJob)
{
    STRING16 ciclo;
    STRING16 job;
    STRING1000 queryText;

    ciclo.clear();
    job.clear();
    queryText.clear();

    ciclo << codCicloFact;
    job << numJob;

    if(_ciclo_GAT_PLANDESCABO != ciclo || _job_GAT_PLANDESCABO != job)
    {
        _ciclo_GAT_PLANDESCABO = ciclo;
        _job_GAT_PLANDESCABO = job;

        if(_GAT_PLANDESCABO != NULL)
        {
            _GAT_PLANDESCABO->close();
            delete _GAT_PLANDESCABO;
        }

        queryText << QUERY_GAT_PLANDESCABO_1;

        if(numJob > 0)
        {
            queryText << "_" << _ciclo_GAT_PLANDESCABO
                      << "_" << _job_GAT_PLANDESCABO;
        }

        queryText << QUERY_GAT_PLANDESCABO_2;

        _GAT_PLANDESCABO = new otl_stream(1024, queryText.c_str(), _db);
    }
}





GAT_PLANDESCABO_RECORDSET& DataService::select_GAT_PLANDESCABO(const int codCliente,
                                                               const int codCicloFact,
                                                               const char* fecEmision,
                                                               const int numJob)
{
    STRING1000 errorMsg;

    _GAT_PLANDESCABO_RECORDS.clear();
    RECORD_GAT_PLANDESCABO_DTO tmpRec;

    try
    {
        verifyQuery_GAT_PLANDESCABO(codCicloFact, numJob);

        _GAT_PLANDESCABO->clean(1);

        *(_GAT_PLANDESCABO) << codCliente;
        *(_GAT_PLANDESCABO) << codCicloFact;
        *(_GAT_PLANDESCABO) << 0;
        *(_GAT_PLANDESCABO) << 0;
        *(_GAT_PLANDESCABO) << -1;
        *(_GAT_PLANDESCABO) << fecEmision;
        *(_GAT_PLANDESCABO) << DATE_FORMAT_YYYYMMDDHH24MISS;

        while(!_GAT_PLANDESCABO->eof())
        {
            tmpRec.clear();
            *(_GAT_PLANDESCABO) >> tmpRec.NUM_SECUENCIA;
            *(_GAT_PLANDESCABO) >> tmpRec.COD_PLANDESC;
            *(_GAT_PLANDESCABO) >> tmpRec.TIP_ENTIDAD;
            *(_GAT_PLANDESCABO) >> tmpRec.COD_TIPEVAL;
            *(_GAT_PLANDESCABO) >> tmpRec.COD_TIPAPLI;
            *(_GAT_PLANDESCABO) >> tmpRec.COD_GRUPOEVAL;
            *(_GAT_PLANDESCABO) >> tmpRec.COD_GRUPOAPLI;
            *(_GAT_PLANDESCABO) >> tmpRec.NUM_CUADRANTE;
            *(_GAT_PLANDESCABO) >> tmpRec.TIP_UNIDAD;
            *(_GAT_PLANDESCABO) >> tmpRec.COD_CONCDESC;
            *(_GAT_PLANDESCABO) >> tmpRec.MTO_MINFACT;

            trim(tmpRec.COD_PLANDESC);
            trim(tmpRec.TIP_ENTIDAD);
            trim(tmpRec.COD_TIPEVAL);
            trim(tmpRec.COD_TIPAPLI);
            trim(tmpRec.TIP_UNIDAD);

            _GAT_PLANDESCABO_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN GAT_PLANDESCABO PARA [COD_CLIENTE] = [" << codCliente
                 << "], [COD_CICLOFACT] = [" << codCicloFact;
        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _GAT_PLANDESCABO_RECORDS.NUM_OF_RECORDS = _GAT_PLANDESCABO_RECORDS.RECORDSET.size();
    return _GAT_PLANDESCABO_RECORDS;
}





FAD_CONCEVAL_RECORDSET& DataService::select_FAD_CONCEVAL(const int codGrupo,
                                                         const char* fecEmision)
{
    STRING1000 errorMsg;

    _FAD_CONCEVAL_RECORDS.clear();
    RECORD_FAD_CONCEVAL_DTO tmpRec;

    try
    {
        _FAD_CONCEVAL->clean(1);

        *(_FAD_CONCEVAL) << codGrupo;
        *(_FAD_CONCEVAL) << fecEmision;
        *(_FAD_CONCEVAL) << DATE_FORMAT_YYYYMMDDHH24MISS;

        while(!_FAD_CONCEVAL->eof())
        {
            tmpRec.clear();
            *(_FAD_CONCEVAL) >> tmpRec.COD_CONCEPTO;
            *(_FAD_CONCEVAL) >> tmpRec.IND_OBLIGA;
            *(_FAD_CONCEVAL) >> tmpRec.MTO_MINFACT;

            trim(tmpRec.IND_OBLIGA);

            _FAD_CONCEVAL_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FAD_CONCEVAL PARA [COD_GRUPO] = [" << codGrupo;
        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _FAD_CONCEVAL_RECORDS.NUM_OF_RECORDS = _FAD_CONCEVAL_RECORDS.RECORDSET.size();
    return _FAD_CONCEVAL_RECORDS;
}


FAD_CONCAPLI_RECORDSET& DataService::select_FAD_CONCAPLI(const int codGrupo,
                                                         const char* fecEmision)
{
    STRING1000 errorMsg;

    _FAD_CONCAPLI_RECORDS.clear();
    RECORD_FAD_CONCAPLI_DTO tmpRec;

    try
    {
        _FAD_CONCAPLI->clean(1);

        *(_FAD_CONCAPLI) << codGrupo;
        *(_FAD_CONCAPLI) << fecEmision;
        *(_FAD_CONCAPLI) << DATE_FORMAT_YYYYMMDDHH24MISS;

        while(!_FAD_CONCAPLI->eof())
        {
            tmpRec.clear();
            *(_FAD_CONCAPLI) >> tmpRec.COD_CONCEPTO;
            *(_FAD_CONCAPLI) >> tmpRec.COD_CONREL;

            _FAD_CONCAPLI_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FAD_CONCAPLI PARA [COD_GRUPO] = [" << codGrupo;
        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _FAD_CONCAPLI_RECORDS.NUM_OF_RECORDS = _FAD_CONCAPLI_RECORDS.RECORDSET.size();
    return _FAD_CONCAPLI_RECORDS;
}


FAD_CUADRANDESC_RECORDSET& DataService::select_FAD_CUADRANDESC(const int codGrupo,
                                                               const char* fecEmision)
{
    STRING1000 errorMsg;

    _FAD_CUADRANDESC_RECORDS.clear();
    RECORD_FAD_CUADRANDESC_DTO tmpRec;

    try
    {
        _FAD_CUADRANDESC->clean(1);

        *(_FAD_CUADRANDESC) << DECIMAL_FORMAT_12_2;
        *(_FAD_CUADRANDESC) << DECIMAL_FORMAT_12_2;
        *(_FAD_CUADRANDESC) << DECIMAL_FORMAT_8_2;
        *(_FAD_CUADRANDESC) << codGrupo;
        *(_FAD_CUADRANDESC) << fecEmision;
        *(_FAD_CUADRANDESC) << DATE_FORMAT_YYYYMMDDHH24MISS;

        while(!_FAD_CUADRANDESC->eof())
        {
            tmpRec.clear();
            *(_FAD_CUADRANDESC) >> tmpRec.VAL_DESDE;
            *(_FAD_CUADRANDESC) >> tmpRec.VAL_HASTA;
            *(_FAD_CUADRANDESC) >> tmpRec.TIP_DESCUENTO;
            *(_FAD_CUADRANDESC) >> tmpRec.VAL_DESCUENTO;
            *(_FAD_CUADRANDESC) >> tmpRec.TIP_MONEDA;

            trim(tmpRec.VAL_DESDE);
            trim(tmpRec.VAL_HASTA);
            trim(tmpRec.TIP_DESCUENTO);
            trim(tmpRec.VAL_DESCUENTO);
            trim(tmpRec.TIP_MONEDA);

            _FAD_CUADRANDESC_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FAD_CUADRANDESC PARA [COD_GRUPO] = [" << codGrupo;
        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _FAD_CUADRANDESC_RECORDS.NUM_OF_RECORDS = _FAD_CUADRANDESC_RECORDS.RECORDSET.size();
    return _FAD_CUADRANDESC_RECORDS;
}






bool DataService::open_TOL_ACUMOPER_TO(const int codCliente,
                                       const int numAbonado,
                                       const char* fecEmision,
                                       const int indFacturacion)
{
    STRING1000 errorMsg;

    try
    {
        _TOL_ACUMOPER_TO->clean(1);

        *(_TOL_ACUMOPER_TO) << codCliente;
        *(_TOL_ACUMOPER_TO) << numAbonado;
        *(_TOL_ACUMOPER_TO) << indFacturacion;
        *(_TOL_ACUMOPER_TO) << NUM_PROCESO_TOL_ACUMOPER;
        *(_TOL_ACUMOPER_TO) << fecEmision;
        *(_TOL_ACUMOPER_TO) << DATE_FORMAT_YYYYMMDDHH24MISS;
        *(_TOL_ACUMOPER_TO) << MTO_MIN_TOL_ACUMOPER;

        if(_TOL_ACUMOPER_TO->eof()) return false;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN TOL_ACUMOPER_TO PARA [COD_CLIENTE] = [" << codCliente;
        errorMsg << "], [NUM_ABONADO] = [" << numAbonado;
        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _currentClient = codCliente;

    return true;
}



RECORD_TOL_ACUMOPER_TO_DTO* DataService::fetch_TOL_ACUMOPER_TO()
{
    STRING1000 errorMsg;

    try
    {
        _recordTOL_ACUMOPER_TO.clear();

        if(_TOL_ACUMOPER_TO->eof()) return NULL;
        {
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_OPERADOR;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_REGI;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_GRUPO;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_CICLFACT;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.IND_EXEDENTE;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_PLAN;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_CARG;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.TIP_DCTO;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_DCTO;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.CNT_INICIAL;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.MTO_FACT;
            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.DUR_FACT;


            trim(_recordTOL_ACUMOPER_TO.COD_REGI);
            trim(_recordTOL_ACUMOPER_TO.IND_EXEDENTE);
            trim(_recordTOL_ACUMOPER_TO.COD_PLAN);
            trim(_recordTOL_ACUMOPER_TO.TIP_DCTO);
            trim(_recordTOL_ACUMOPER_TO.COD_DCTO);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL RECUPERAR REGISTROS EN TOL_ACUMOPER_TO:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _recordTOL_ACUMOPER_TO.COD_CLIENTE = _currentClient;

    return &_recordTOL_ACUMOPER_TO;
}


void DataService::delete_FA_DETDCTOCLIELOC(const int codCicloFact, const int numJob)
{
    STRING3000 errorMsg;
 
    try
    {
        verifyQuery_FA_DETDCTOCLIELOC(codCicloFact, numJob);

        _del_FA_DETDCTOCLIELOC_TO->clean(1);
        
        *(_del_FA_DETDCTOCLIELOC_TO) << 0;

        _del_FA_DETDCTOCLIELOC_TO->flush();
    }
    catch(otl_exception& error)
    {
        _del_FA_DETDCTOCLIELOC_TO->clean(1);
        errorMsg << "ERROR AL BORRAR REGISTROS EN " << _name_FA_DETDCTOCLIELOC_TO << " : " << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "XXXX", OTL_SQL_ERROR);
    }

    confirmChanges();
    return;
}



void DataService::insert_FA_DETDCTOCLIELOC(RECORD_FA_DETDCTOCLIELOC_TO_DTO& recordOut,
                                           const int codCicloFact,
                                           const int numJob)
{
    STRING3000 errorMsg;
 
    try
    {
        verifyQuery_FA_DETDCTOCLIELOC(codCicloFact, numJob);

        _FA_DETDCTOCLIELOC_TO->clean(1);
        
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_CLIENTE;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_CICLO;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_PLANDESC;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.NUM_SECUENCIA;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_GRUPOAPLI;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.NUM_CUADRANTE;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.VALOR_DCTO;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.TIP_DCTO;
        *(_FA_DETDCTOCLIELOC_TO) << recordOut.TIP_ENTIDAD;

        _FA_DETDCTOCLIELOC_TO->flush();

        int ins_reg = 0 ;
        if((ins_reg = _FA_DETDCTOCLIELOC_TO->get_rpc()) != 1)
        {
            errorMsg << "ERROR AL INSERTAR EN " << _name_FA_DETDCTOCLIELOC_TO
                     << ": " << ins_reg << "REGISTRO INSERTADO PARA:" << ENDL;
            errorMsg << "[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "]," << ENDL;
            errorMsg << "[COD_CICLO]     = [" << recordOut.COD_CICLO << "]," << ENDL;
            errorMsg << "[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "]," << ENDL;
            errorMsg << "[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "]," << ENDL;
            errorMsg << "[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "]," << ENDL;
            errorMsg << "[NUM_CUADRANTE] = [" << recordOut.NUM_CUADRANTE << "]," << ENDL;
            errorMsg << "[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "]," << ENDL;
            errorMsg << "[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "]," << ENDL;
            errorMsg << "[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "]," << ENDL;
            throw ProcessCoreException((STRING3000&) errorMsg, (char*) "XXXX", OTL_SQL_ERROR);
        }
    }
    catch(otl_exception& error)
    {
        _FA_DETDCTOCLIELOC_TO->clean(1);
        errorMsg << "ERROR AL INSERTAR EN " << _name_FA_DETDCTOCLIELOC_TO
                 << " PARA:" << ENDL;
        errorMsg << "[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "]," << ENDL;
        errorMsg << "[COD_CICLO]     = [" << recordOut.COD_CICLO << "]," << ENDL;
        errorMsg << "[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "]," << ENDL;
        errorMsg << "[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "]," << ENDL;
        errorMsg << "[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "]," << ENDL;
        errorMsg << "[NUM_CUADRANTE] = [" << recordOut.NUM_CUADRANTE << "]," << ENDL;
        errorMsg << "[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "]," << ENDL;
        errorMsg << "[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "]," << ENDL;
        errorMsg << "[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "]," << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "XXXX", OTL_SQL_ERROR);
    }

    confirmChanges();
    return;
}


void DataService::verifyQuery_FA_DETDCTOCLIELOC(const int codCicloFact, const int numJob)
{
    STRING16 ciclo;
    STRING16 job;
    STRING1000 queryText;

    ciclo.clear();
    job.clear();
    queryText.clear();

    ciclo << codCicloFact;
    job << numJob;

    if(_ciclo != ciclo || _job != job)
    {
        _ciclo = ciclo;
        _job = job;

        if(_FA_DETDCTOCLIELOC_TO != NULL)
        {
            _FA_DETDCTOCLIELOC_TO->close();
            delete _FA_DETDCTOCLIELOC_TO;
        }

        if(_del_FA_DETDCTOCLIELOC_TO != NULL)
        {
            _del_FA_DETDCTOCLIELOC_TO->close();
            delete _del_FA_DETDCTOCLIELOC_TO;
        }

        _name_FA_DETDCTOCLIELOC_TO.clear();
        _name_FA_DETDCTOCLIELOC_TO = QUERY_FA_DETDCTOCLIELOC_TO_2;

        _name_FA_DETDCTOCLIELOC_TO << "_" << _ciclo;

        if(numJob > 0)
        {
            _name_FA_DETDCTOCLIELOC_TO << "_" << _job;
        }

        queryText << QUERY_FA_DETDCTOCLIELOC_TO_1
                  << _name_FA_DETDCTOCLIELOC_TO
                  << QUERY_FA_DETDCTOCLIELOC_TO_3;

        _FA_DETDCTOCLIELOC_TO = new otl_nocommit_stream(1024, queryText.c_str(), _db);

        queryText.clear();

        queryText << QUERY_CLEAR_FA_DETDCTOCLIELOC_TO_1
                  << _name_FA_DETDCTOCLIELOC_TO
                  << QUERY_CLEAR_FA_DETDCTOCLIELOC_TO_3;

        _del_FA_DETDCTOCLIELOC_TO = new otl_nocommit_stream(1024, queryText.c_str(), _db);
    }
}



int DataService::select_FA_TRAZAPROC_JOB_TO_SEQ_REPRO(const int codProceso,
                                                      const int codCicloFact,
                                                      const int numJob)
{
    STRING1000 errorMsg;

    int maxSeq = 0;

    try
    {
        _FA_TRAZAPROC_JOB_TO_SEQ_REPRO->clean(1);

        *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) << numJob;
        *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) << codCicloFact;
        *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) << codProceso;

        if(!_FA_TRAZAPROC_JOB_TO_SEQ_REPRO->eof())
        {
            *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) >> maxSeq;
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR MAX(SEC_REPROCESO) EN FA_TRAZAPROC_JOB_TO PARA:" << ENDL;
        errorMsg << "[COD_PROCESO]  = [" << codProceso << "]" << ENDL;
        errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]" << ENDL;
        errorMsg << "[NUM_JOB]      = [" << numJob << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    return maxSeq;
}




RECORD_FA_PROCFACT_DTO DataService::select_FA_PROCFACT(const int codProceso)
{
    STRING1000 errorMsg;

    RECORD_FA_PROCFACT_DTO tmpRec;

    tmpRec.clear();

    try
    {
        _FA_PROCFACT->clean(1);

        *(_FA_PROCFACT) << codProceso;

        if(_FA_PROCFACT->eof())
        {
            errorMsg << "NO SE ENCONTRO REGISTRO EN FA_PROCFACT PARA [COD_PROCESO] = [" << codProceso;
            errorMsg << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
        }

        tmpRec.COD_PROCESO = codProceso;
        *(_FA_PROCFACT) >> tmpRec.IND_REPROCESO;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_PROCFACT PARA [COD_PROCESO] = [" << codProceso;
        errorMsg << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    return tmpRec;
}




FA_TRAZAPROC_RECORDSET& DataService::select_FA_TRAZAPROC(const int codProceso,
                                                         const int codCicloFact)
{
    STRING1000 errorMsg;

    _FA_TRAZAPROC_RECORDS.clear();
    RECORD_FA_TRAZAPROC_DTO tmpRec;

    try
    {
        _FA_TRAZAPROC->clean(1);

        *(_FA_TRAZAPROC) << codProceso;
        *(_FA_TRAZAPROC) << codCicloFact;

        while(!_FA_TRAZAPROC->eof())
        {
            tmpRec.clear();
            *(_FA_TRAZAPROC) >> tmpRec.DES_PROCESO;
            *(_FA_TRAZAPROC) >> tmpRec.COD_PROCPREC;
            *(_FA_TRAZAPROC) >> tmpRec.DES_PROCPREC;
            *(_FA_TRAZAPROC) >> tmpRec.COD_ESTAPREC;
            *(_FA_TRAZAPROC) >> tmpRec.COD_ESTAPROC;

            trim(tmpRec.DES_PROCESO);
            trim(tmpRec.DES_PROCPREC);

            _FA_TRAZAPROC_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_TRAZAPROC PARA [COD_PROCESO] = [" << codProceso;
        errorMsg << "], [COD_CICLFACT] = [" << codCicloFact << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _FA_TRAZAPROC_RECORDS.NUM_OF_RECORDS = _FA_TRAZAPROC_RECORDS.RECORDSET.size();
    return _FA_TRAZAPROC_RECORDS;
}



RECORD_STAT_FA_TRAZAPROC_DTO DataService::selectSTAT_FA_TRAZAPROC(const int codProceso,
                                                                  const int codCicloFact)
{
    STRING1000 errorMsg;

    RECORD_STAT_FA_TRAZAPROC_DTO tmpRec;
    tmpRec.clear();

    try
    {
        _statFA_TRAZAPROC->clean(1);

        *(_statFA_TRAZAPROC) << codCicloFact;
        *(_statFA_TRAZAPROC) << codProceso;

        if(!_statFA_TRAZAPROC->eof())
        {
            *(_statFA_TRAZAPROC) >> tmpRec.COD_ESTAPROC;
            *(_statFA_TRAZAPROC) >> tmpRec.DES_PROCESO;
            trim(tmpRec.DES_PROCESO);
            tmpRec.RECORD_FOUND = true;
        }
        else
            tmpRec.RECORD_FOUND = false;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_TRAZAPROC PARA:" << ENDL;
        errorMsg << "[COD_PROCESO]  = [" << codProceso << "]" << ENDL;
        errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    return tmpRec;
}






RECORD_STAT_FA_TRAZAPROC_DTO DataService::selectSTAT_FA_TRAZAPROC(const int codProceso,
                                                                  const int codCicloFact,
                                                                  const int numJob,
                                                                  const int seqRepro)
{
    STRING1000 errorMsg;

    RECORD_STAT_FA_TRAZAPROC_DTO tmpRec;
    tmpRec.clear();

    try
    {
        _statFA_TRAZAPROC_JOB_TO->clean(1);

        *(_statFA_TRAZAPROC_JOB_TO) << codCicloFact;
        *(_statFA_TRAZAPROC_JOB_TO) << codProceso;
        *(_statFA_TRAZAPROC_JOB_TO) << numJob;
        *(_statFA_TRAZAPROC_JOB_TO) << seqRepro;

        if(!_statFA_TRAZAPROC_JOB_TO->eof())
        {
            *(_statFA_TRAZAPROC_JOB_TO) >> tmpRec.COD_ESTAPROC;
            *(_statFA_TRAZAPROC_JOB_TO) >> tmpRec.DES_PROCESO;
            trim(tmpRec.DES_PROCESO);
            tmpRec.RECORD_FOUND = true;
        }
        else
            tmpRec.RECORD_FOUND = false;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_TRAZAPROC_JOB_TO PARA [COD_PROCESO] = [" << codProceso;
        errorMsg << "], [COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
        errorMsg << "[NUM_JOB] = [" << numJob << "]," << ENDL;
        errorMsg << "[SEC_REPROCESO] = [" << seqRepro << "]," << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    return tmpRec;
}




FA_TRAZAPROC_RECORDSET& DataService::select_FA_TRAZAPROC_JOB_TO(const int codProceso,
                                                                const int codCicloFact,
                                                                const int numJob,
                                                                const int seqRepro)
{
    STRING1000 errorMsg;

    _FA_TRAZAPROC_RECORDS.clear();
    RECORD_FA_TRAZAPROC_DTO tmpRec;

    try
    {
        _FA_TRAZAPROC_JOB_TO->clean(1);

        *(_FA_TRAZAPROC_JOB_TO) << codProceso;
        *(_FA_TRAZAPROC_JOB_TO) << numJob;
        *(_FA_TRAZAPROC_JOB_TO) << seqRepro;
        *(_FA_TRAZAPROC_JOB_TO) << codCicloFact;

        while(!_FA_TRAZAPROC_JOB_TO->eof())
        {
            tmpRec.clear();
            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.DES_PROCESO;
            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.COD_PROCPREC;
            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.DES_PROCPREC;
            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.COD_ESTAPREC;
            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.COD_ESTAPROC;

            trim(tmpRec.DES_PROCESO);
            trim(tmpRec.DES_PROCPREC);

            _FA_TRAZAPROC_RECORDS.RECORDSET.push_back(tmpRec);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_TRAZAPROC_JOB_TO PARA [COD_PROCESO] = [" << codProceso;
        errorMsg << "], [COD_CICLFACT] = [" << codCicloFact
                 << "], [NUM_JOB] = [" << numJob
                 << "], [SEC_REPROCESO] = [" << seqRepro << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    _FA_TRAZAPROC_RECORDS.NUM_OF_RECORDS = _FA_TRAZAPROC_RECORDS.RECORDSET.size();
    return _FA_TRAZAPROC_RECORDS;
}


bool DataService::insert_FA_TRAZAPROC(const int codCicloFact)
{
    STRING3000 errorMsg;
 
    try
    {
        _iFA_TRAZAPROC->clean(1);

        *(_iFA_TRAZAPROC) << codCicloFact;
        *(_iFA_TRAZAPROC) << COD_PROCESS_FACTURACION;
        *(_iFA_TRAZAPROC) << PROC_EST_RUN;
        *(_iFA_TRAZAPROC) << GLS_EST_RUN;
        *(_iFA_TRAZAPROC) << 0;
        *(_iFA_TRAZAPROC) << 0;
        *(_iFA_TRAZAPROC) << 0;

        _iFA_TRAZAPROC->flush();

        int ins_reg = 0 ;
        if((ins_reg = _iFA_TRAZAPROC->get_rpc()) != 1)
        {
            errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC: " << ins_reg << "REGISTRO INSERTADO PARA:" << ENDL;
            errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
            errorMsg << "[COD_PROCESO]  = [" << COD_PROCESS_FACTURACION << "]" << ENDL;
            throw ProcessCoreException((STRING3000&) errorMsg, (char*) "XXXX", OTL_SQL_ERROR);
        }
    }
    catch(otl_exception& error)
    {
        _iFA_TRAZAPROC->clean(1);
        errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC PARA:" << ENDL;
        errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
        errorMsg << "[COD_PROCESO]  = [" << COD_PROCESS_FACTURACION << "]," << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "XXXX", OTL_SQL_ERROR);
    }

    confirmChanges();

    return false;
}


bool DataService::update_FA_TRAZAPROC(const int codStatProc,
                                      const char* textStat,
                                      const int codCicloFact)
{
   STRING3000           errorMsg;

   try
   {
        _uFA_TRAZAPROC->clean(1);

        *(_uFA_TRAZAPROC) << codStatProc;
        *(_uFA_TRAZAPROC) << textStat;
        *(_uFA_TRAZAPROC) << codCicloFact;
        *(_uFA_TRAZAPROC) << COD_PROCESS_FACTURACION;

        _uFA_TRAZAPROC->flush();
   }
   catch(otl_exception& error)
   {
        errorMsg << "ERROR EN UPDATE REGISTRO EN FA_TRAZAPROC:" << ENDL;
        errorMsg << "\t[COD_ESTAPROC] = [" << codStatProc << "]," << ENDL;
        errorMsg << "\t[GLS_PROCESO] = [" << textStat << "]," << ENDL;
        errorMsg << "\t[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
        errorMsg << "\t[COD_PROCESO] = [" << COD_PROCESS_FACTURACION << "]," << ENDL;

        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, "XXXX", OTL_SQL_ERROR);
   }
   
   confirmChanges();

    return false;
}


bool DataService::insert_FA_TRAZAPROC_JOB_TO(const int numJob,
                                             const int codCicloFact,
                                             const int seqRepro)
{
    STRING3000 errorMsg;
 
    try
    {
        _iFA_TRAZAPROC_JOB_TO->clean(1);

        *(_iFA_TRAZAPROC_JOB_TO) << numJob;
        *(_iFA_TRAZAPROC_JOB_TO) << seqRepro;
        *(_iFA_TRAZAPROC_JOB_TO) << codCicloFact;
        *(_iFA_TRAZAPROC_JOB_TO) << COD_PROCESS_FACTURACION_JOB;
        *(_iFA_TRAZAPROC_JOB_TO) << PROC_EST_RUN;
        *(_iFA_TRAZAPROC_JOB_TO) << GLS_EST_RUN;
        *(_iFA_TRAZAPROC_JOB_TO) << 0;
        *(_iFA_TRAZAPROC_JOB_TO) << 0;
        *(_iFA_TRAZAPROC_JOB_TO) << 0;

        _iFA_TRAZAPROC_JOB_TO->flush();

        int ins_reg = 0 ;
        if((ins_reg = _iFA_TRAZAPROC_JOB_TO->get_rpc()) != 1)
        {
            errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC_JOB_TO: " << ins_reg << "REGISTRO INSERTADO PARA:" << ENDL;
            errorMsg << "[COD_CICLFACT]   = [" << codCicloFact << "]," << ENDL;
            errorMsg << "[COD_PROCESO]    = [" << COD_PROCESS_FACTURACION_JOB << "]," << ENDL;
            errorMsg << "[NUM_JOB]   = [" << numJob << "]," << ENDL;
            throw ProcessCoreException((STRING3000&) errorMsg, (char*) "XXXX", OTL_SQL_ERROR);
        }
    }
    catch(otl_exception& error)
    {
        _iFA_TRAZAPROC_JOB_TO->clean(1);
        errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC_JOB_TO PARA:" << ENDL;
        errorMsg << "[COD_CICLFACT]   = [" << codCicloFact << "]," << ENDL;
        errorMsg << "[COD_PROCESO]    = [" << COD_PROCESS_FACTURACION_JOB << "]," << ENDL;
        errorMsg << "[NUM_JOB]   = [" << numJob << "]," << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "XXXX", OTL_SQL_ERROR);
    }

    confirmChanges();

    return false;
}


bool DataService::update_FA_TRAZAPROC_JOB_TO(const int codStatProc,
                                             const char* textStat,
                                             const int codCicloFact,
                                             const int numJob,
                                             const int seqRepro)
{
   STRING3000           errorMsg;

   try
   {
        _uFA_TRAZAPROC_JOB_TO->clean(1);

        *(_uFA_TRAZAPROC_JOB_TO) << codStatProc;
        *(_uFA_TRAZAPROC_JOB_TO) << textStat;
        *(_uFA_TRAZAPROC_JOB_TO) << codCicloFact;
        *(_uFA_TRAZAPROC_JOB_TO) << COD_PROCESS_FACTURACION_JOB;
        *(_uFA_TRAZAPROC_JOB_TO) << numJob;
        *(_uFA_TRAZAPROC_JOB_TO) << seqRepro;

        _uFA_TRAZAPROC_JOB_TO->flush();
   }
   catch(otl_exception& error)
   {
        errorMsg << "ERROR EN UPDATE REGISTRO EN FA_TRAZAPROC_JOB_TO:" << ENDL;
        errorMsg << "\t[COD_ESTAPROC] = [" << codStatProc << "]," << ENDL;
        errorMsg << "\t[GLS_PROCESO] = [" << textStat << "]," << ENDL;
        errorMsg << "\t[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
        errorMsg << "\t[COD_PROCESO] = [" << COD_PROCESS_FACTURACION_JOB << "]," << ENDL;
        errorMsg << "\t[NUM_JOB] = [" << numJob << "]," << ENDL;
        errorMsg << "\t[SEC_REPROCESO] = [" << seqRepro << "]," << ENDL;

        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, "XXXX", OTL_SQL_ERROR);
   }
   
   confirmChanges();

    return false;
}


bool DataService::select_FA_JOBFACT_TO(const int numJob,
                                       const int codStat1,
                                       const int codStat2)
{
    STRING1000 errorMsg;

    bool recordFound = false;

    try
    {
        _FA_JOBFACT_TO->clean(1);

        *(_FA_JOBFACT_TO) << numJob;
        *(_FA_JOBFACT_TO) << codStat1;
        *(_FA_JOBFACT_TO) << codStat2;

        recordFound = !_FA_JOBFACT_TO->eof();
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_JOBFACT_TO PARA [NUM_JOB] = [" << numJob
                 << "], [COD_ESTADO] = [" << codStat1 << "] or "
                 << "[COD_ESTADO] = [" << codStat2 << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    return recordFound;
}






bool DataService::select_FA_CRITERIOJOB_TO(const int codCiclFact,
                                           const int numJob)
{
    STRING1000 errorMsg;

    bool recordFound = false;

    try
    {
        _FA_CRITERIOJOB_TO->clean(1);

        *(_FA_CRITERIOJOB_TO) << codCiclFact;
        *(_FA_CRITERIOJOB_TO) << numJob;

        recordFound = !_FA_CRITERIOJOB_TO->eof();
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_CRITERIOJOB_TO PARA:";
        errorMsg << "[NUM_JOB]         = [" << numJob << "]" << ENDL;
        errorMsg << "[COD_CICLFACT]    = [" << codCiclFact << "]" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "XXXX", OTL_SQL_ERROR);
    }

    return recordFound;
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


