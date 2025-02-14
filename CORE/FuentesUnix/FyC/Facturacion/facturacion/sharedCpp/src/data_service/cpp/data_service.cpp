#ifndef NO_INDENT
#ident "@(#)$RCSfile: data_service.cpp,v $ $Revision: 1.1 $ $Date: 2008/07/14 16:29:36 $"
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
    // GENERALES
    _mode = MAIN;
    _oracleEviroment = NULL;
    _oracleEviroment = new OraOciEnviroment(getErrorInOraOciNumber);
    _isCommitable = false;
    _FA_CICLFACT = NULL;
    _FA_CICLOCLI = NULL;
    _FA_PROCFACT = NULL;
    _FA_TRAZAPROC = NULL;
    _statFA_TRAZAPROC = NULL;
    _iFA_TRAZAPROC = NULL;
    _uFA_TRAZAPROC = NULL;
    _FA_PARAMETROS_SIMPLES_VW = NULL;
    _FA_RANGOSHOST_TO =  NULL;

    // CARGOSPUNTUALES
    _FA_CARGOSERVPUNTUAL_TO = NULL;
    _ABONADOS_INDENT_TRIBSINDESPA = NULL;
    _ABONADOS_INDENT_TRIBCONDESPA = NULL;
    _SERVSUPLABO_CICLFACT = NULL;
    _SERVSUPLABOSUSP_CICLFACT = NULL;
    _SELECT_GE_SEQ_CARGOS = NULL;
    _INSERT_GE_CARGOS = NULL;
    _UPDATE_GA_INFACCEL = NULL;

    // DESCUENTOSLOCUTORIOS
    //    _GAT_PLANDESCABO = NULL;
    //    _FAD_CONCEVAL = NULL;
    //    _FAD_CONCAPLI = NULL;
    //    _FAD_CUADRANDESC = NULL;
    //    _TOL_ACUMOPER_TO = NULL;
    //    _FA_DETDCTOCLIELOC_TO = NULL;
    //    _del_FA_DETDCTOCLIELOC_TO = NULL;
    //    _name_FA_DETDCTOCLIELOC_TO.clear();


#ifdef _JOB
//    _FA_CLIENTEJOB_TO = NULL;
//    _FA_TRAZAPROC_JOB_TO_SEQ_REPRO = NULL;
//    _statFA_TRAZAPROC_JOB_TO = NULL;
//    _FA_TRAZAPROC_JOB_TO = NULL;
//    _iFA_TRAZAPROC_JOB_TO = NULL;
//    _uFA_TRAZAPROC_JOB_TO = NULL;
//    _FA_JOBFACT_TO = NULL;
//    _FA_CRITERIOJOB_TO = NULL;
#endif

    _ciclo.clear();
    _job.clear();

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
    // GENERALES
    _FA_CICLOCLI_RECORDS.clear();
    _FA_TRAZAPROC_RECORDS.clear();
    if(_FA_CICLFACT != NULL) delete _FA_CICLFACT;
    if(_FA_CICLOCLI != NULL) delete _FA_CICLOCLI;
    if(_FA_PROCFACT != NULL) delete _FA_PROCFACT;
    if(_FA_TRAZAPROC != NULL) delete _FA_TRAZAPROC;
    if(_statFA_TRAZAPROC != NULL) delete _statFA_TRAZAPROC;
    if(_iFA_TRAZAPROC != NULL) delete _iFA_TRAZAPROC;
    if(_uFA_TRAZAPROC != NULL) delete _uFA_TRAZAPROC;
    if(_FA_PARAMETROS_SIMPLES_VW != NULL) delete _FA_PARAMETROS_SIMPLES_VW;
    if(_FA_RANGOSHOST_TO != NULL) delete _FA_RANGOSHOST_TO;


    // DESCUENTOS LOCUTORIO
    //    if(_GAT_PLANDESCABO != NULL) delete _GAT_PLANDESCABO;
    //    _GAT_PLANDESCABO_RECORDS.clear();
    //    if(_FAD_CONCEVAL != NULL) delete _FAD_CONCEVAL;
    //    _FAD_CONCEVAL_RECORDS.clear();
    //    if(_FAD_CONCAPLI != NULL) delete _FAD_CONCAPLI;
    //    _FAD_CONCAPLI_RECORDS.clear();
    //    if(_FAD_CUADRANDESC != NULL) delete _FAD_CUADRANDESC;
    //    _FAD_CUADRANDESC_RECORDS.clear();
    //    if(_TOL_ACUMOPER_TO != NULL) delete _TOL_ACUMOPER_TO;
    //    _recordTOL_ACUMOPER_TO.clear();
    //    if(_FA_DETDCTOCLIELOC_TO != NULL) delete _FA_DETDCTOCLIELOC_TO;
    //    if(_del_FA_DETDCTOCLIELOC_TO != NULL) delete _del_FA_DETDCTOCLIELOC_TO;

    // CARGOSPUNTUALES
    if(_FA_CARGOSERVPUNTUAL_TO != NULL) delete _FA_CARGOSERVPUNTUAL_TO;
    if(_ABONADOS_INDENT_TRIBSINDESPA != NULL) delete _ABONADOS_INDENT_TRIBSINDESPA;
    if(_ABONADOS_INDENT_TRIBCONDESPA != NULL) delete _ABONADOS_INDENT_TRIBCONDESPA;
    if(_SERVSUPLABO_CICLFACT != NULL) delete _SERVSUPLABO_CICLFACT;
    if(_SERVSUPLABOSUSP_CICLFACT != NULL) delete _SERVSUPLABOSUSP_CICLFACT;
    if(_INSERT_GE_CARGOS !=NULL) delete _INSERT_GE_CARGOS;
    if(_UPDATE_GA_INFACCEL !=NULL) delete _UPDATE_GA_INFACCEL;


#ifdef _JOB
//    if(_FA_CLIENTEJOB_TO != NULL) delete _FA_CLIENTEJOB_TO;
//    if(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO != NULL) delete _FA_TRAZAPROC_JOB_TO_SEQ_REPRO;
//    if(_statFA_TRAZAPROC_JOB_TO != NULL) delete _statFA_TRAZAPROC_JOB_TO;
//    if(_FA_TRAZAPROC_JOB_TO != NULL) delete _FA_TRAZAPROC_JOB_TO;
//    if(_iFA_TRAZAPROC_JOB_TO != NULL) delete _iFA_TRAZAPROC_JOB_TO;
//    if(_uFA_TRAZAPROC_JOB_TO != NULL) delete _uFA_TRAZAPROC_JOB_TO;
//    if(_FA_JOBFACT_TO != NULL) delete _FA_JOBFACT_TO;
//    if(_FA_CRITERIOJOB_TO != NULL) delete _FA_CRITERIOJOB_TO;
#endif

    _ciclo.clear();
    _job.clear();
//    _name_FA_DETDCTOCLIELOC_TO.clear();

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
        // GENERALES
        _FA_CICLFACT = new otl_stream(1024, QUERY_FA_CICLFACT, _db);
        _FA_CICLOCLI = new otl_stream(1024, QUERY_FA_CICLOCLI, _db);
        _FA_PROCFACT = new otl_stream(1024, QUERY_FA_PROCFACT, _db);
        _FA_TRAZAPROC = new otl_stream(1024, QUERY_FA_TRAZAPROC, _db);
        _statFA_TRAZAPROC = new otl_stream(1024, QUERY_STAT_FA_TRAZAPROC, _db);
        _iFA_TRAZAPROC = new otl_nocommit_stream(1024, QUERY_INSERT_FA_TRAZAPROC, _db);
        _uFA_TRAZAPROC = new otl_nocommit_stream(1024, QUERY_UPDATE_FA_TRAZAPROC, _db);
        _FA_PARAMETROS_SIMPLES_VW = new otl_nocommit_stream(1024, QUERY_FA_PARAMETROS_SIMPLES_VW, _db);

        _FA_RANGOSHOST_TO = new otl_stream(1024, QUERY_FA_RANGOSHOST_TO, _db);

        // CARGOSPUNTUALES
        _FA_CARGOSERVPUNTUAL_TO = new otl_nocommit_stream(1024,QUERY_FA_CARGOSERVPUNTUAL_TO,_db);
        _ABONADOS_INDENT_TRIBSINDESPA = new otl_nocommit_stream(2048,QUERY_ABONADOS_INDENT_TRIBSINDESPA,_db);
        _ABONADOS_INDENT_TRIBCONDESPA = new otl_nocommit_stream(2048,QUERY_ABONADOS_INDENT_TRIBCONDESPA,_db);
        _SERVSUPLABO_CICLFACT = new otl_nocommit_stream(512,QUERY_SERVSUPLABO_CICLFACT,_db);
        _SERVSUPLABOSUSP_CICLFACT = new otl_nocommit_stream(512,QUERY_SERVSUPLABOSUSP_CICLFACT,_db);
        _INSERT_GE_CARGOS = new otl_nocommit_stream(512,QUERY_INSERT_GE_CARGOS,_db);
        _UPDATE_GA_INFACCEL = new otl_nocommit_stream(512,QUERY_UPDATE_GA_INFACCEL,_db);


        // DESCUENTOS LOCUTORIOS
        //        _GAT_PLANDESCABO = new otl_stream(1024, QUERY_GAT_PLANDESCABO, _db);
        //        _FAD_CONCEVAL = new otl_stream(1024, QUERY_FAD_CONCEVAL, _db);
        //        _FAD_CONCAPLI = new otl_stream(1024, QUERY_FAD_CONCAPLI, _db);
        //        _FAD_CUADRANDESC = new otl_stream(1024, QUERY_FAD_CUADRANDESC, _db);


#ifdef _JOB
//        _FA_TRAZAPROC_JOB_TO_SEQ_REPRO = new otl_stream(1024, QUERY_FA_TRAZAPROC_JOB_TO_SEQ_REPRO, _db);
//        _FA_JOBFACT_TO = new otl_stream(1024, QUERY_FA_JOBFACT_TO, _db);
//        _statFA_TRAZAPROC_JOB_TO = new otl_stream(1024, QUERY_STAT_FA_TRAZAPROC_JOB_TO, _db);
//        _FA_TRAZAPROC_JOB_TO = new otl_stream(1024, QUERY_FA_TRAZAPROC_JOB_TO, _db);
//        _iFA_TRAZAPROC_JOB_TO = new otl_nocommit_stream(1024, QUERY_INSERT_FA_TRAZAPROC_JOB, _db);
//        _uFA_TRAZAPROC_JOB_TO = new otl_nocommit_stream(1024, QUERY_UPDATE_FA_TRAZAPROC_JOB_TO, _db);
//        _FA_CRITERIOJOB_TO = new otl_stream(1024, QUERY_FA_CRITERIOJOB_TO, _db);
//        _FA_CLIENTEJOB_TO = new otl_stream(1024, QUERY_FA_CLIENTEJOB_TO, _db);
#endif

    }
    else
    {
//        _TOL_ACUMOPER_TO = new otl_stream(1024, QUERY_TOL_ACUMOPER_TO, _db);
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
            throw ProcessCoreException((STRING1000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", DATA_ERROR);
         }

        tmpRec.COD_CICLOFACT = codCicloFact;
        *(_FA_CICLFACT) >> tmpRec.COD_CICLO;
        *(_FA_CICLFACT) >> tmpRec.FEC_DESDELLAM;
        *(_FA_CICLFACT) >> tmpRec.FEC_HASTALLAM;
        *(_FA_CICLFACT) >> tmpRec.FEC_EMISION;
        *(_FA_CICLFACT) >> tmpRec.FEC_DESDECFIJOS;
        *(_FA_CICLFACT) >> tmpRec.FEC_HASTACFIJOS;
        *(_FA_CICLFACT) >> tmpRec.DIA_PERIODO;
        tmpRec.IND_FACTURACION = indFacturacion;

         if(!_FA_CICLFACT->eof())
         {
            errorMsg << "ERROR AL BUSCAR EN FA_CICLFACT PARA [COD_CICLFACT] = [" << codCicloFact
                     << "], [IND_TASADOR] = [" << IND_TASACION_TOL;
            errorMsg << "], [IND_FACTURACION] = [" << indFacturacion << "]. Retorna mas de una fila";
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", DATA_ERROR);
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
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
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
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    _FA_CICLOCLI_RECORDS.NUM_OF_RECORDS = _FA_CICLOCLI_RECORDS.RECORDSET.size();
    return _FA_CICLOCLI_RECORDS;
}

#ifdef _JOB
//bool DataService::select_FA_CLIENTEJOB_TO(const int codCliente,
//                                          const int numJob,
//                                          const int codCiclo)
//{
//    STRING1000 errorMsg;
//
//    bool recordFound = false;
//
//    try
//    {
//        _FA_CLIENTEJOB_TO->clean(1);
//
//        *(_FA_CLIENTEJOB_TO) << codCliente;
//        *(_FA_CLIENTEJOB_TO) << numJob;
//        *(_FA_CLIENTEJOB_TO) << codCiclo;
//        *(_FA_CLIENTEJOB_TO) << NUM_PROCESO_FA_CICLOCLI;
//
//        recordFound = !_FA_CLIENTEJOB_TO->eof();
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FA_CLIENTEJOB_TO PARA [COD_CLIENTE] = [" << codCliente
//                 << "], [COD_CICLO] = [" << codCiclo;
//        errorMsg << "], [NUM_PROCESO] = [" << NUM_PROCESO_FA_CICLOCLI;
//        errorMsg << "], [NUM_JOB] = [" << numJob << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    return recordFound;
//}
#endif

//GAT_PLANDESCABO_RECORDSET& DataService::select_GAT_PLANDESCABO(const int codCliente,
//                                                               const int codCicloFact,
//                                                               const char* fecEmision)
//{
//    STRING1000 errorMsg;
//
//    _GAT_PLANDESCABO_RECORDS.clear();
//    RECORD_GAT_PLANDESCABO_DTO tmpRec;
//
//    try
//    {
//        _GAT_PLANDESCABO->clean(1);
//
//        *(_GAT_PLANDESCABO) << codCliente;
//        *(_GAT_PLANDESCABO) << codCicloFact;
//        *(_GAT_PLANDESCABO) << 0;
//        *(_GAT_PLANDESCABO) << 0;
//        *(_GAT_PLANDESCABO) << -1;
//        *(_GAT_PLANDESCABO) << fecEmision;
//        *(_GAT_PLANDESCABO) << DATE_FORMAT_YYYYMMDDHH24MISS;
//
//        while(!_GAT_PLANDESCABO->eof())
//        {
//            tmpRec.clear();
//            *(_GAT_PLANDESCABO) >> tmpRec.NUM_SECUENCIA;
//            *(_GAT_PLANDESCABO) >> tmpRec.COD_PLANDESC;
//            *(_GAT_PLANDESCABO) >> tmpRec.TIP_ENTIDAD;
//            *(_GAT_PLANDESCABO) >> tmpRec.COD_TIPEVAL;
//            *(_GAT_PLANDESCABO) >> tmpRec.COD_TIPAPLI;
//            *(_GAT_PLANDESCABO) >> tmpRec.COD_GRUPOEVAL;
//            *(_GAT_PLANDESCABO) >> tmpRec.COD_GRUPOAPLI;
//            *(_GAT_PLANDESCABO) >> tmpRec.NUM_CUADRANTE;
//            *(_GAT_PLANDESCABO) >> tmpRec.TIP_UNIDAD;
//            *(_GAT_PLANDESCABO) >> tmpRec.COD_CONCDESC;
//            *(_GAT_PLANDESCABO) >> tmpRec.MTO_MINFACT;
//
//            trim(tmpRec.COD_PLANDESC);
//            trim(tmpRec.TIP_ENTIDAD);
//            trim(tmpRec.COD_TIPEVAL);
//            trim(tmpRec.COD_TIPAPLI);
//            trim(tmpRec.TIP_UNIDAD);
//
//            _GAT_PLANDESCABO_RECORDS.RECORDSET.push_back(tmpRec);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN GAT_PLANDESCABO PARA [COD_CLIENTE] = [" << codCliente
//                 << "], [COD_CICLOFACT] = [" << codCicloFact;
//        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    _GAT_PLANDESCABO_RECORDS.NUM_OF_RECORDS = _GAT_PLANDESCABO_RECORDS.RECORDSET.size();
//    return _GAT_PLANDESCABO_RECORDS;
//}
//
//FAD_CONCEVAL_RECORDSET& DataService::select_FAD_CONCEVAL(const int codGrupo,
//                                                         const char* fecEmision)
//{
//    STRING1000 errorMsg;
//
//    _FAD_CONCEVAL_RECORDS.clear();
//    RECORD_FAD_CONCEVAL_DTO tmpRec;
//
//    try
//    {
//        _FAD_CONCEVAL->clean(1);
//
//        *(_FAD_CONCEVAL) << codGrupo;
//        *(_FAD_CONCEVAL) << fecEmision;
//        *(_FAD_CONCEVAL) << DATE_FORMAT_YYYYMMDDHH24MISS;
//
//        while(!_FAD_CONCEVAL->eof())
//        {
//            tmpRec.clear();
//            *(_FAD_CONCEVAL) >> tmpRec.COD_CONCEPTO;
//            *(_FAD_CONCEVAL) >> tmpRec.IND_OBLIGA;
//            *(_FAD_CONCEVAL) >> tmpRec.MTO_MINFACT;
//
//            trim(tmpRec.IND_OBLIGA);
//
//            _FAD_CONCEVAL_RECORDS.RECORDSET.push_back(tmpRec);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FAD_CONCEVAL PARA [COD_GRUPO] = [" << codGrupo;
//        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    _FAD_CONCEVAL_RECORDS.NUM_OF_RECORDS = _FAD_CONCEVAL_RECORDS.RECORDSET.size();
//    return _FAD_CONCEVAL_RECORDS;
//}
//
//FAD_CONCAPLI_RECORDSET& DataService::select_FAD_CONCAPLI(const int codGrupo,
//                                                         const char* fecEmision)
//{
//    STRING1000 errorMsg;
//
//    _FAD_CONCAPLI_RECORDS.clear();
//    RECORD_FAD_CONCAPLI_DTO tmpRec;
//
//    try
//    {
//        _FAD_CONCAPLI->clean(1);
//
//        *(_FAD_CONCAPLI) << codGrupo;
//        *(_FAD_CONCAPLI) << fecEmision;
//        *(_FAD_CONCAPLI) << DATE_FORMAT_YYYYMMDDHH24MISS;
//
//        while(!_FAD_CONCAPLI->eof())
//        {
//            tmpRec.clear();
//            *(_FAD_CONCAPLI) >> tmpRec.COD_CONCEPTO;
//            *(_FAD_CONCAPLI) >> tmpRec.COD_CONREL;
//
//            _FAD_CONCAPLI_RECORDS.RECORDSET.push_back(tmpRec);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FAD_CONCAPLI PARA [COD_GRUPO] = [" << codGrupo;
//        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    _FAD_CONCAPLI_RECORDS.NUM_OF_RECORDS = _FAD_CONCAPLI_RECORDS.RECORDSET.size();
//    return _FAD_CONCAPLI_RECORDS;
//}
//
//FAD_CUADRANDESC_RECORDSET& DataService::select_FAD_CUADRANDESC(const int codGrupo,
//                                                               const char* fecEmision)
//{
//    STRING1000 errorMsg;
//
//    _FAD_CUADRANDESC_RECORDS.clear();
//    RECORD_FAD_CUADRANDESC_DTO tmpRec;
//
//    try
//    {
//        _FAD_CUADRANDESC->clean(1);
//
//        *(_FAD_CUADRANDESC) << DECIMAL_FORMAT_12_2;
//        *(_FAD_CUADRANDESC) << DECIMAL_FORMAT_12_2;
//        *(_FAD_CUADRANDESC) << DECIMAL_FORMAT_8_2;
//        *(_FAD_CUADRANDESC) << codGrupo;
//        *(_FAD_CUADRANDESC) << fecEmision;
//        *(_FAD_CUADRANDESC) << DATE_FORMAT_YYYYMMDDHH24MISS;
//
//        while(!_FAD_CUADRANDESC->eof())
//        {
//            tmpRec.clear();
//            *(_FAD_CUADRANDESC) >> tmpRec.VAL_DESDE;
//            *(_FAD_CUADRANDESC) >> tmpRec.VAL_HASTA;
//            *(_FAD_CUADRANDESC) >> tmpRec.TIP_DESCUENTO;
//            *(_FAD_CUADRANDESC) >> tmpRec.VAL_DESCUENTO;
//            *(_FAD_CUADRANDESC) >> tmpRec.TIP_MONEDA;
//
//            trim(tmpRec.VAL_DESDE);
//            trim(tmpRec.VAL_HASTA);
//            trim(tmpRec.TIP_DESCUENTO);
//            trim(tmpRec.VAL_DESCUENTO);
//            trim(tmpRec.TIP_MONEDA);
//
//            _FAD_CUADRANDESC_RECORDS.RECORDSET.push_back(tmpRec);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FAD_CUADRANDESC PARA [COD_GRUPO] = [" << codGrupo;
//        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    _FAD_CUADRANDESC_RECORDS.NUM_OF_RECORDS = _FAD_CUADRANDESC_RECORDS.RECORDSET.size();
//    return _FAD_CUADRANDESC_RECORDS;
//}
//
//bool DataService::open_TOL_ACUMOPER_TO(const int codCliente,
//                                       const int numAbonado,
//                                       const char* fecEmision,
//                                       const int indFacturacion)
//{
//    STRING1000 errorMsg;
//
//    try
//    {
//        _TOL_ACUMOPER_TO->clean(1);
//
//        *(_TOL_ACUMOPER_TO) << codCliente;
//        *(_TOL_ACUMOPER_TO) << numAbonado;
//        *(_TOL_ACUMOPER_TO) << indFacturacion;
//        *(_TOL_ACUMOPER_TO) << NUM_PROCESO_TOL_ACUMOPER;
//        *(_TOL_ACUMOPER_TO) << fecEmision;
//        *(_TOL_ACUMOPER_TO) << DATE_FORMAT_YYYYMMDDHH24MISS;
//        *(_TOL_ACUMOPER_TO) << MTO_MIN_TOL_ACUMOPER;
//
//        if(_TOL_ACUMOPER_TO->eof()) return false;
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN TOL_ACUMOPER_TO PARA [COD_CLIENTE] = [" << codCliente;
//        errorMsg << "], [NUM_ABONADO] = [" << numAbonado;
//        errorMsg << "], [FEC_EMISION] = [" << fecEmision << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    _currentClient = codCliente;
//
//    return true;
//}
//
//
//
//RECORD_TOL_ACUMOPER_TO_DTO* DataService::fetch_TOL_ACUMOPER_TO()
//{
//    STRING1000 errorMsg;
//
//    try
//    {
//        _recordTOL_ACUMOPER_TO.clear();
//
//        if(_TOL_ACUMOPER_TO->eof()) return NULL;
//        {
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_OPERADOR;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_REGI;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_GRUPO;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_CICLFACT;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.IND_EXEDENTE;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_PLAN;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_CARG;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.TIP_DCTO;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.COD_DCTO;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.CNT_INICIAL;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.MTO_FACT;
//            *(_TOL_ACUMOPER_TO) >> _recordTOL_ACUMOPER_TO.DUR_FACT;
//
//
//            trim(_recordTOL_ACUMOPER_TO.COD_REGI);
//            trim(_recordTOL_ACUMOPER_TO.IND_EXEDENTE);
//            trim(_recordTOL_ACUMOPER_TO.COD_PLAN);
//            trim(_recordTOL_ACUMOPER_TO.TIP_DCTO);
//            trim(_recordTOL_ACUMOPER_TO.COD_DCTO);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL RECUPERAR REGISTROS EN TOL_ACUMOPER_TO:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    _recordTOL_ACUMOPER_TO.COD_CLIENTE = _currentClient;
//
//    return &_recordTOL_ACUMOPER_TO;
//}
//
//
//void DataService::delete_FA_DETDCTOCLIELOC(const int codCicloFact, const int numJob)
//{
//    STRING3000 errorMsg;
//
//    try
//    {
//        verifyQuery_FA_DETDCTOCLIELOC(codCicloFact, numJob);
//
//        _del_FA_DETDCTOCLIELOC_TO->clean(1);
//
//        *(_del_FA_DETDCTOCLIELOC_TO) << 0;
//
//        _del_FA_DETDCTOCLIELOC_TO->flush();
//    }
//    catch(otl_exception& error)
//    {
//        _del_FA_DETDCTOCLIELOC_TO->clean(1);
//        errorMsg << "ERROR AL BORRAR REGISTROS EN " << _name_FA_DETDCTOCLIELOC_TO << " : " << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    confirmChanges();
//    return;
//}
//
//void DataService::insert_FA_DETDCTOCLIELOC(RECORD_FA_DETDCTOCLIELOC_TO_DTO& recordOut,
//                                           const int codCicloFact,
//                                           const int numJob)
//{
//    STRING3000 errorMsg;
//
//    try
//    {
//        verifyQuery_FA_DETDCTOCLIELOC(codCicloFact, numJob);
//
//        _FA_DETDCTOCLIELOC_TO->clean(1);
//
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_CLIENTE;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_CICLO;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_PLANDESC;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.NUM_SECUENCIA;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.COD_GRUPOAPLI;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.NUM_CUADRANTE;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.VALOR_DCTO;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.TIP_DCTO;
//        *(_FA_DETDCTOCLIELOC_TO) << recordOut.TIP_ENTIDAD;
//
//        _FA_DETDCTOCLIELOC_TO->flush();
//
//        int ins_reg = 0 ;
//        if((ins_reg = _FA_DETDCTOCLIELOC_TO->get_rpc()) != 1)
//        {
//            errorMsg << "ERROR AL INSERTAR EN " << _name_FA_DETDCTOCLIELOC_TO
//                     << ": " << ins_reg << "REGISTRO INSERTADO PARA:" << ENDL;
//            errorMsg << "[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "]," << ENDL;
//            errorMsg << "[COD_CICLO]     = [" << recordOut.COD_CICLO << "]," << ENDL;
//            errorMsg << "[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "]," << ENDL;
//            errorMsg << "[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "]," << ENDL;
//            errorMsg << "[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "]," << ENDL;
//            errorMsg << "[NUM_CUADRANTE] = [" << recordOut.NUM_CUADRANTE << "]," << ENDL;
//            errorMsg << "[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "]," << ENDL;
//            errorMsg << "[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "]," << ENDL;
//            errorMsg << "[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "]," << ENDL;
//            throw ProcessCoreException((STRING3000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        _FA_DETDCTOCLIELOC_TO->clean(1);
//        errorMsg << "ERROR AL INSERTAR EN " << _name_FA_DETDCTOCLIELOC_TO
//                 << " PARA:" << ENDL;
//        errorMsg << "[COD_CLIENTE]   = [" << recordOut.COD_CLIENTE << "]," << ENDL;
//        errorMsg << "[COD_CICLO]     = [" << recordOut.COD_CICLO << "]," << ENDL;
//        errorMsg << "[COD_PLANDESC]  = [" << recordOut.COD_PLANDESC << "]," << ENDL;
//        errorMsg << "[NUM_SECUENCIA] = [" << recordOut.NUM_SECUENCIA << "]," << ENDL;
//        errorMsg << "[COD_GRUPOAPLI] = [" << recordOut.COD_GRUPOAPLI << "]," << ENDL;
//        errorMsg << "[NUM_CUADRANTE] = [" << recordOut.NUM_CUADRANTE << "]," << ENDL;
//        errorMsg << "[VALOR_DCTO]    = [" << recordOut.VALOR_DCTO << "]," << ENDL;
//        errorMsg << "[TIP_DCTO]      = [" << recordOut.TIP_DCTO << "]," << ENDL;
//        errorMsg << "[TIP_ENTIDAD]   = [" << recordOut.TIP_ENTIDAD << "]," << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    confirmChanges();
//    return;
//}
//
//void DataService::verifyQuery_FA_DETDCTOCLIELOC(const int codCicloFact, const int numJob)
//{
//    STRING16 ciclo;
//    STRING16 job;
//    STRING1000 queryText;
//
//    ciclo.clear();
//    job.clear();
//    queryText.clear();
//
//    ciclo << codCicloFact;
//    job << numJob;
//
//    if(_ciclo != ciclo || _job != job)
//    {
//        _ciclo = ciclo;
//        _job = job;
//
//        if(_FA_DETDCTOCLIELOC_TO != NULL)
//        {
//            _FA_DETDCTOCLIELOC_TO->close();
//            delete _FA_DETDCTOCLIELOC_TO;
//        }
//
//        if(_del_FA_DETDCTOCLIELOC_TO != NULL)
//        {
//            _del_FA_DETDCTOCLIELOC_TO->close();
//            delete _del_FA_DETDCTOCLIELOC_TO;
//        }
//
//        _name_FA_DETDCTOCLIELOC_TO.clear();
//        _name_FA_DETDCTOCLIELOC_TO = QUERY_FA_DETDCTOCLIELOC_TO_2;
//
//        _name_FA_DETDCTOCLIELOC_TO << "_" << _ciclo;
//
//        if(numJob > 0)
//        {
//            _name_FA_DETDCTOCLIELOC_TO << "_" << _job;
//        }
//
//        queryText << QUERY_FA_DETDCTOCLIELOC_TO_1
//                  << _name_FA_DETDCTOCLIELOC_TO
//                  << QUERY_FA_DETDCTOCLIELOC_TO_3;
//
//        _FA_DETDCTOCLIELOC_TO = new otl_nocommit_stream(1024, queryText.c_str(), _db);
//
//        queryText.clear();
//
//        queryText << QUERY_CLEAR_FA_DETDCTOCLIELOC_TO_1
//                  << _name_FA_DETDCTOCLIELOC_TO
//                  << QUERY_CLEAR_FA_DETDCTOCLIELOC_TO_3;
//
//        _del_FA_DETDCTOCLIELOC_TO = new otl_nocommit_stream(1024, queryText.c_str(), _db);
//    }
//}

#ifdef _JOB
//int DataService::select_FA_TRAZAPROC_JOB_TO_SEQ_REPRO(const int codProceso,
//                                                      const int codCicloFact,
//                                                      const int numJob)
//{
//    STRING1000 errorMsg;
//
//    int maxSeq = 0;
//
//    try
//    {
//        _FA_TRAZAPROC_JOB_TO_SEQ_REPRO->clean(1);
//
//        *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) << numJob;
//        *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) << codCicloFact;
//        *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) << codProceso;
//
//        if(!_FA_TRAZAPROC_JOB_TO_SEQ_REPRO->eof())
//        {
//            *(_FA_TRAZAPROC_JOB_TO_SEQ_REPRO) >> maxSeq;
//        }
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR MAX(SEC_REPROCESO) EN FA_TRAZAPROC_JOB_TO PARA:" << ENDL;
//        errorMsg << "[COD_PROCESO]  = [" << codProceso << "]" << ENDL;
//        errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]" << ENDL;
//        errorMsg << "[NUM_JOB]      = [" << numJob << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    return maxSeq;
//}
#endif



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
            throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
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
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return tmpRec;
}

FA_TRAZAPROC_RECORDSET& DataService::select_FA_TRAZAPROC(const int codProceso,
                                                         const int codCicloFact,
                                                         const char * hostId,
                                                         const int indHostId)
{
    STRING1000 errorMsg;

    _FA_TRAZAPROC_RECORDS.clear();
    RECORD_FA_TRAZAPROC_DTO tmpRec;

    try
    {
        _FA_TRAZAPROC->clean(1);

        *(_FA_TRAZAPROC) << codProceso;
        *(_FA_TRAZAPROC) << codCicloFact;
        *(_FA_TRAZAPROC) << hostId;
        *(_FA_TRAZAPROC) << indHostId;

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
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    _FA_TRAZAPROC_RECORDS.NUM_OF_RECORDS = _FA_TRAZAPROC_RECORDS.RECORDSET.size();
    return _FA_TRAZAPROC_RECORDS;
}



RECORD_STAT_FA_TRAZAPROC_DTO DataService::selectSTAT_FA_TRAZAPROC(const int codProceso,
                                                                  const int codCicloFact,
                                                                  const char * hostId,
                                                                  const int indHostId)
{
    STRING1000 errorMsg;

    RECORD_STAT_FA_TRAZAPROC_DTO tmpRec;
    tmpRec.clear();

    try
    {
        _statFA_TRAZAPROC->clean(1);

        *(_statFA_TRAZAPROC) << codCicloFact;
        *(_statFA_TRAZAPROC) << codProceso;
        *(_statFA_TRAZAPROC) << hostId;
        *(_statFA_TRAZAPROC) << indHostId;

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
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return tmpRec;
}


#ifdef _JOB
//RECORD_STAT_FA_TRAZAPROC_DTO DataService::selectSTAT_FA_TRAZAPROC(const int codProceso,
//                                                                  const int codCicloFact,
//                                                                  const int numJob,
//                                                                  const int seqRepro)
//{
//    STRING1000 errorMsg;
//
//    RECORD_STAT_FA_TRAZAPROC_DTO tmpRec;
//    tmpRec.clear();
//
//    try
//    {
//        _statFA_TRAZAPROC_JOB_TO->clean(1);
//
//        *(_statFA_TRAZAPROC_JOB_TO) << codCicloFact;
//        *(_statFA_TRAZAPROC_JOB_TO) << codProceso;
//        *(_statFA_TRAZAPROC_JOB_TO) << numJob;
//        *(_statFA_TRAZAPROC_JOB_TO) << seqRepro;
//
//        if(!_statFA_TRAZAPROC_JOB_TO->eof())
//        {
//            *(_statFA_TRAZAPROC_JOB_TO) >> tmpRec.COD_ESTAPROC;
//            *(_statFA_TRAZAPROC_JOB_TO) >> tmpRec.DES_PROCESO;
//            trim(tmpRec.DES_PROCESO);
//            tmpRec.RECORD_FOUND = true;
//        }
//        else
//            tmpRec.RECORD_FOUND = false;
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FA_TRAZAPROC_JOB_TO PARA [COD_PROCESO] = [" << codProceso;
//        errorMsg << "], [COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
//        errorMsg << "[NUM_JOB] = [" << numJob << "]," << ENDL;
//        errorMsg << "[SEC_REPROCESO] = [" << seqRepro << "]," << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    return tmpRec;
//}
//
//FA_TRAZAPROC_RECORDSET& DataService::select_FA_TRAZAPROC_JOB_TO(const int codProceso,
//                                                                const int codCicloFact,
//                                                                const int numJob,
//                                                                const int seqRepro)
//{
//    STRING1000 errorMsg;
//
//    _FA_TRAZAPROC_RECORDS.clear();
//    RECORD_FA_TRAZAPROC_DTO tmpRec;
//
//    try
//    {
//        _FA_TRAZAPROC_JOB_TO->clean(1);
//
//        *(_FA_TRAZAPROC_JOB_TO) << codProceso;
//        *(_FA_TRAZAPROC_JOB_TO) << numJob;
//        *(_FA_TRAZAPROC_JOB_TO) << seqRepro;
//        *(_FA_TRAZAPROC_JOB_TO) << codCicloFact;
//
//        while(!_FA_TRAZAPROC_JOB_TO->eof())
//        {
//            tmpRec.clear();
//            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.DES_PROCESO;
//            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.COD_PROCPREC;
//            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.DES_PROCPREC;
//            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.COD_ESTAPREC;
//            *(_FA_TRAZAPROC_JOB_TO) >> tmpRec.COD_ESTAPROC;
//
//            trim(tmpRec.DES_PROCESO);
//            trim(tmpRec.DES_PROCPREC);
//
//            _FA_TRAZAPROC_RECORDS.RECORDSET.push_back(tmpRec);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FA_TRAZAPROC_JOB_TO PARA [COD_PROCESO] = [" << codProceso;
//        errorMsg << "], [COD_CICLFACT] = [" << codCicloFact
//                 << "], [NUM_JOB] = [" << numJob
//                 << "], [SEC_REPROCESO] = [" << seqRepro << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    _FA_TRAZAPROC_RECORDS.NUM_OF_RECORDS = _FA_TRAZAPROC_RECORDS.RECORDSET.size();
//    return _FA_TRAZAPROC_RECORDS;
//}
#endif

bool DataService::insert_FA_TRAZAPROC(const int codCicloFact,
                                      const int codProceso,
                                      const int codEstadoProceso,
                                      const char * hostId)
{
    STRING3000 errorMsg;

    try
    {
        _iFA_TRAZAPROC->clean(1);

        *(_iFA_TRAZAPROC) << codCicloFact;
        *(_iFA_TRAZAPROC) << codProceso;
        *(_iFA_TRAZAPROC) << codEstadoProceso;
        *(_iFA_TRAZAPROC) << GLS_EST_RUN;
        *(_iFA_TRAZAPROC) << 0;
        *(_iFA_TRAZAPROC) << 0;
        *(_iFA_TRAZAPROC) << 0;
        *(_iFA_TRAZAPROC) << hostId;

        _iFA_TRAZAPROC->flush();

        int ins_reg = 0 ;
        if((ins_reg = _iFA_TRAZAPROC->get_rpc()) != 1)
        {
            errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC: " << ins_reg << "REGISTRO INSERTADO PARA:" << ENDL;
            errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
            errorMsg << "[COD_PROCESO]  = [" << codProceso << "]" << ENDL;
            throw ProcessCoreException((STRING3000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
        }
    }
    catch(otl_exception& error)
    {
        _iFA_TRAZAPROC->clean(1);
        errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC PARA:" << ENDL;
        errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
        errorMsg << "[COD_PROCESO]  = [" << codProceso << "]," << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    confirmChanges();

    return false;
}


bool DataService::update_FA_TRAZAPROC(const int codStatProc,
                                      const char* textStat,
                                      const int codCicloFact,
                                      const int codProceso,
                                      const char * hostId,
                                      const int indHostId)
{
   STRING3000           errorMsg;

   try
   {
        _uFA_TRAZAPROC->clean(1);

        *(_uFA_TRAZAPROC) << codStatProc;
        *(_uFA_TRAZAPROC) << textStat;
        *(_uFA_TRAZAPROC) << codCicloFact;
        *(_uFA_TRAZAPROC) << codProceso;
        *(_uFA_TRAZAPROC) << hostId;
        *(_uFA_TRAZAPROC) << indHostId;

        _uFA_TRAZAPROC->flush();
   }
   catch(otl_exception& error)
   {
        errorMsg << "ERROR EN UPDATE REGISTRO EN FA_TRAZAPROC:" << ENDL;
        errorMsg << "\t[COD_ESTAPROC] = [" << codStatProc << "]," << ENDL;
        errorMsg << "\t[GLS_PROCESO] = [" << textStat << "]," << ENDL;
        errorMsg << "\t[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
        errorMsg << "\t[COD_PROCESO] = [" << codProceso << "]," << ENDL;

        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING3000&) errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
   }

   confirmChanges();

    return false;
}

#ifdef _JOB
//bool DataService::insert_FA_TRAZAPROC_JOB_TO(const int numJob,
//                                             const int codCicloFact,
//                                             const int seqRepro)
//{
//    STRING3000 errorMsg;
//
//    try
//    {
//        _iFA_TRAZAPROC_JOB_TO->clean(1);
//
//        *(_iFA_TRAZAPROC_JOB_TO) << numJob;
//        *(_iFA_TRAZAPROC_JOB_TO) << seqRepro;
//        *(_iFA_TRAZAPROC_JOB_TO) << codCicloFact;
//        *(_iFA_TRAZAPROC_JOB_TO) << COD_PROCESS_FACTURACION_JOB;
//        *(_iFA_TRAZAPROC_JOB_TO) << PROC_EST_RUN;
//        *(_iFA_TRAZAPROC_JOB_TO) << GLS_EST_RUN;
//        *(_iFA_TRAZAPROC_JOB_TO) << 0;
//        *(_iFA_TRAZAPROC_JOB_TO) << 0;
//        *(_iFA_TRAZAPROC_JOB_TO) << 0;
//
//        _iFA_TRAZAPROC_JOB_TO->flush();
//
//        int ins_reg = 0 ;
//        if((ins_reg = _iFA_TRAZAPROC_JOB_TO->get_rpc()) != 1)
//        {
//            errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC_JOB_TO: " << ins_reg << "REGISTRO INSERTADO PARA:" << ENDL;
//            errorMsg << "[COD_CICLFACT]   = [" << codCicloFact << "]," << ENDL;
//            errorMsg << "[COD_PROCESO]    = [" << COD_PROCESS_FACTURACION_JOB << "]," << ENDL;
//            errorMsg << "[NUM_JOB]   = [" << numJob << "]," << ENDL;
//            throw ProcessCoreException((STRING3000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//        }
//    }
//    catch(otl_exception& error)
//    {
//        _iFA_TRAZAPROC_JOB_TO->clean(1);
//        errorMsg << "ERROR AL INSERTAR EN FA_TRAZAPROC_JOB_TO PARA:" << ENDL;
//        errorMsg << "[COD_CICLFACT]   = [" << codCicloFact << "]," << ENDL;
//        errorMsg << "[COD_PROCESO]    = [" << COD_PROCESS_FACTURACION_JOB << "]," << ENDL;
//        errorMsg << "[NUM_JOB]   = [" << numJob << "]," << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING3000&) errorMsg, (char*) "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    confirmChanges();
//
//    return false;
//}
//
//
//bool DataService::update_FA_TRAZAPROC_JOB_TO(const int codStatProc,
//                                             const char* textStat,
//                                             const int codCicloFact,
//                                             const int numJob,
//                                             const int seqRepro)
//{
//   STRING3000           errorMsg;
//
//   try
//   {
//        _uFA_TRAZAPROC_JOB_TO->clean(1);
//
//        *(_uFA_TRAZAPROC_JOB_TO) << codStatProc;
//        *(_uFA_TRAZAPROC_JOB_TO) << textStat;
//        *(_uFA_TRAZAPROC_JOB_TO) << codCicloFact;
//        *(_uFA_TRAZAPROC_JOB_TO) << COD_PROCESS_FACTURACION_JOB;
//        *(_uFA_TRAZAPROC_JOB_TO) << numJob;
//        *(_uFA_TRAZAPROC_JOB_TO) << seqRepro;
//
//        _uFA_TRAZAPROC_JOB_TO->flush();
//   }
//   catch(otl_exception& error)
//   {
//        errorMsg << "ERROR EN UPDATE REGISTRO EN FA_TRAZAPROC_JOB_TO:" << ENDL;
//        errorMsg << "\t[COD_ESTAPROC] = [" << codStatProc << "]," << ENDL;
//        errorMsg << "\t[GLS_PROCESO] = [" << textStat << "]," << ENDL;
//        errorMsg << "\t[COD_CICLFACT] = [" << codCicloFact << "]," << ENDL;
//        errorMsg << "\t[COD_PROCESO] = [" << COD_PROCESS_FACTURACION_JOB << "]," << ENDL;
//        errorMsg << "\t[NUM_JOB] = [" << numJob << "]," << ENDL;
//        errorMsg << "\t[SEC_REPROCESO] = [" << seqRepro << "]," << ENDL;
//
//        errorMsg << "SQL_ERROR_MSG = [" << (char*) error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING3000&) errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//   }
//
//   confirmChanges();
//
//    return false;
//}
//
//
//bool DataService::select_FA_JOBFACT_TO(const int numJob,
//                                       const int codStat1,
//                                       const int codStat2)
//{
//    STRING1000 errorMsg;
//
//    bool recordFound = false;
//
//    try
//    {
//        _FA_JOBFACT_TO->clean(1);
//
//        *(_FA_JOBFACT_TO) << numJob;
//        *(_FA_JOBFACT_TO) << codStat1;
//        *(_FA_JOBFACT_TO) << codStat2;
//
//        recordFound = !_FA_JOBFACT_TO->eof();
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FA_JOBFACT_TO PARA [NUM_JOB] = [" << numJob
//                 << "], [COD_ESTADO] = [" << codStat1 << "] or "
//                 << "[COD_ESTADO] = [" << codStat2 << "]:" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    return recordFound;
//}
//
//
//bool DataService::select_FA_CRITERIOJOB_TO(const int codCiclFact,
//                                           const int numJob)
//{
//    STRING1000 errorMsg;
//
//    bool recordFound = false;
//
//    try
//    {
//        _FA_CRITERIOJOB_TO->clean(1);
//
//        *(_FA_CRITERIOJOB_TO) << codCiclFact;
//        *(_FA_CRITERIOJOB_TO) << numJob;
//
//        recordFound = !_FA_CRITERIOJOB_TO->eof();
//    }
//    catch(otl_exception& error)
//    {
//        errorMsg << "ERROR AL BUSCAR EN FA_CRITERIOJOB_TO PARA:";
//        errorMsg << "[NUM_JOB]         = [" << numJob << "]" << ENDL;
//        errorMsg << "[COD_CICLFACT]    = [" << codCiclFact << "]" << ENDL;
//        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
//        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
//        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
//        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
//    }
//
//    return recordFound;
//}
#endif

STRING DataService::select_FA_PARAMETROS_SIMPLES_VW(const STRING &nom_parametro)
{
    STRING1000 errorMsg;

    char valor_texto[251];
    memset(valor_texto,0x00,sizeof(valor_texto));

    try
    {
        _FA_PARAMETROS_SIMPLES_VW->clean(1);

        *(_FA_PARAMETROS_SIMPLES_VW) << nom_parametro;

        *(_FA_PARAMETROS_SIMPLES_VW) >> valor_texto;

    }
    catch(otl_exception& error)
    {
        if (valor_texto==NULL)
            return "";
        else
        {
            errorMsg << "ERROR AL BUSCAR EN FA_PARAMETOS_SIMPLES_VW PARA:";
            errorMsg << "[NOM_PARAMETRO]    = [" << nom_parametro << "]" << ENDL;
            errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
            errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
            errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
        }
    }

    return (STRING)valor_texto;
}


vector <RECORD_FA_CARGOSERVPUNTUAL_TO> DataService::select_FA_CARGOSERVPUNTUAL_TO(const STRING &cod_despacho)
{
    STRING1000 errorMsg;

    vector <RECORD_FA_CARGOSERVPUNTUAL_TO> _this_vector;
    _this_vector.clear();

    RECORD_FA_CARGOSERVPUNTUAL_TO _my_cargoservpuntual;

    try
    {
        _FA_CARGOSERVPUNTUAL_TO->clean(1);

        *(_FA_CARGOSERVPUNTUAL_TO) << 1 << 0.0 ;

        while(!_FA_CARGOSERVPUNTUAL_TO->eof())
        {
            _my_cargoservpuntual.clear();

            *(_FA_CARGOSERVPUNTUAL_TO) >> _my_cargoservpuntual.COD_PRODUCTO
                                       >> _my_cargoservpuntual.COD_SERVICIO
                                       >> _my_cargoservpuntual.COD_TIPIDENT
                                       >> _my_cargoservpuntual.IND_FACTURAELECTRONICA
                                       >> _my_cargoservpuntual.COD_CONCEPTO
                                       >> _my_cargoservpuntual.COD_MONEDA
                                       >> _my_cargoservpuntual.MTO_CARGO;

            _this_vector.push_back(_my_cargoservpuntual);
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_CARGOSERVPUNTUAL_TO";
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return _this_vector;
}

vector <RECORD_CLIENTE_ABONADO> DataService::select_ABONADOS_INDENT(const int cod_ciclfact,
                                                                    const int cod_ciclo,
                                                                    const STRING &fec_emision,
                                                                    const STRING &cod_tipident,
                                                                    const STRING &cod_despacho,
                                                                    const STRING &cod_servicio,
                                                                    const int    ind_electronica,
                                                                    const bool   indRango,
                                                                    const int    clienteIni,
                                                                    const int    clienteFin,
                                                                    const STRING &fec_desde) /*P-COL-08013 MAC*/
{
    STRING1000 errorMsg;

    vector <RECORD_CLIENTE_ABONADO> _this_vector;
    _this_vector.clear();

    RECORD_CLIENTE_ABONADO _my_cliente_abonado;

    int flagRango;

    if (indRango)
        flagRango = 1;
    else
        flagRango = 0;

    try
    {
        if (ind_electronica) {
            _ABONADOS_INDENT_TRIBCONDESPA->clean(1);

            *(_ABONADOS_INDENT_TRIBCONDESPA) << fec_emision.c_str()
                                             << DATE_FORMAT_YYYYMMDDHH24MISS
                                             << fec_emision.c_str()
                                             << DATE_FORMAT_YYYYMMDDHH24MISS
                                             << cod_ciclo
                                             << cod_tipident.c_str()
                                             << flagRango
                                             << clienteIni
                                             << clienteFin
                                             << cod_ciclfact
                                             << cod_despacho.c_str()
                                             << ind_electronica
                                             << cod_ciclfact
                                             << fec_desde.c_str()
                                             << DATE_FORMAT_YYYYMMDDHH24MISS;

            while(!_ABONADOS_INDENT_TRIBCONDESPA->eof())
            {
                _my_cliente_abonado.clear();

                *(_ABONADOS_INDENT_TRIBCONDESPA) >> _my_cliente_abonado.COD_CLIENTE >> _my_cliente_abonado.NUM_ABONADO >> _my_cliente_abonado.IND_BLOQUEO;

                _this_vector.push_back(_my_cliente_abonado);
            }
        }
        else {
            _ABONADOS_INDENT_TRIBSINDESPA->clean(1);

            *(_ABONADOS_INDENT_TRIBSINDESPA) << fec_emision.c_str()
                                             << DATE_FORMAT_YYYYMMDDHH24MISS
                                             << fec_emision.c_str()
                                             << DATE_FORMAT_YYYYMMDDHH24MISS
                                             << cod_ciclo
                                             << cod_tipident.c_str()
                                             << flagRango
                                             << clienteIni
                                             << clienteFin
                                             << cod_ciclfact
                                             << cod_despacho.c_str()
                                             << ind_electronica
                                             << cod_ciclfact
                                             << fec_desde.c_str()
                                             << DATE_FORMAT_YYYYMMDDHH24MISS;

            while(!_ABONADOS_INDENT_TRIBSINDESPA->eof())
            {
                _my_cliente_abonado.clear();

                *(_ABONADOS_INDENT_TRIBSINDESPA) >> _my_cliente_abonado.COD_CLIENTE >> _my_cliente_abonado.NUM_ABONADO >> _my_cliente_abonado.IND_BLOQUEO;

                _this_vector.push_back(_my_cliente_abonado);
            }
        }
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN ABONADOS_INDENT_TRIBCONDESPA" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return _this_vector;
}

bool DataService::select_SERVSUPLABO_CICLFACT(int cod_ciclo,
                                              long num_abonado,
                                              const STRING &cod_servicio,
                                              const STRING &fecHastaCFijo,
                                              const STRING &fecDesdeCFijo,
                                              const STRING &fecEmision
                                              )
{
    STRING1000 errorMsg;
    long contador;

    contador = 0;

    try
    {
        //HighResolutionClock hrClock;
        //hrClock.markStart();
        _SERVSUPLABO_CICLFACT->clean(1);

        *(_SERVSUPLABO_CICLFACT) << num_abonado
                                 << cod_servicio.c_str()
                                 << fecHastaCFijo.c_str()
                                 << DATE_FORMAT_YYYYMMDDHH24MISS
                                 << fecDesdeCFijo.c_str()
                                 << DATE_FORMAT_YYYYMMDDHH24MISS
                                 << fecEmision.c_str()
                                 << DATE_FORMAT_YYYYMMDDHH24MISS;

        *(_SERVSUPLABO_CICLFACT) >> contador;

        //hrClock.markEnd();
        //cout << "num_abonado :" << num_abonado << endl;
        //cout << "cod_servicio :" << cod_servicio << endl;
        //cout << "fecha_emision : " << fecha_emision << endl;
        //cout << "\t[select_SERVSUPLABO_CICLFACT]: eTimeMSEC = [" << hrClock.getElapsedTimeMSEC() << "]..." << endl;
        //cout << "\t[select_SERVSUPLABO_CICLFACT]: eTimeSEC  = [" << hrClock.getElapsedTimeSEC()  << "]..." << endl << endl;

        if(contador>0)
            return true;
        else
            return false;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN _SERVSUPLABO_CICLFACT "<< ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return false;
}

/*inicio P-COL-08013 MAC*/
bool DataService::select_SERVSUPLABOSUSP_CICLFACT(int cod_ciclo,
                                              long num_abonado,
                                              const STRING &cod_servicio,
                                              const STRING &fecHastaCFijo,
                                              const STRING &fecDesdeCFijo,
                                              const STRING &fecEmision
                                              )
{
    STRING1000 errorMsg;
    long contador;

    contador = 0;

    try
    {
        //HighResolutionClock hrClock;
        //hrClock.markStart();
        _SERVSUPLABOSUSP_CICLFACT->clean(1);

        *(_SERVSUPLABOSUSP_CICLFACT) << num_abonado
                                 << cod_servicio.c_str()
                                 << fecHastaCFijo.c_str()
                                 << DATE_FORMAT_YYYYMMDDHH24MISS
                                 << fecDesdeCFijo.c_str()
                                 << DATE_FORMAT_YYYYMMDDHH24MISS
                                 << fecEmision.c_str()
                                 << DATE_FORMAT_YYYYMMDDHH24MISS;

        *(_SERVSUPLABOSUSP_CICLFACT) >> contador;

        //hrClock.markEnd();
        //cout << "num_abonado :" << num_abonado << endl;
        //cout << "cod_servicio :" << cod_servicio << endl;
        //cout << "fecha_emision : " << fecha_emision << endl;
        //cout << "\t[select_SERVSUPLABOSUSP_CICLFACT]: eTimeMSEC = [" << hrClock.getElapsedTimeMSEC() << "]..." << endl;
        //cout << "\t[select_SERVSUPLABOSUSP_CICLFACT]: eTimeSEC  = [" << hrClock.getElapsedTimeSEC()  << "]..." << endl << endl;

        if(contador>0)
            return true;
        else
            return false;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN _SERVSUPLABOSUSP_CICLFACT "<< ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return false;
}
/*fin P-COL-08013 MAC*/

long DataService::select_GE_SEQ_CARGOS()
{
    STRING1000 errorMsg;
    long secuencia;

    secuencia = 0;
    try
    {
        _SELECT_GE_SEQ_CARGOS = new otl_nocommit_stream(512,QUERY_SELECT_GE_SEQ_CARGOS,_db);
        //_SELECT_GE_SEQ_CARGOS->clean(1);
        //_SELECT_GE_SEQ_CARGOS->flush();
        *(_SELECT_GE_SEQ_CARGOS) >> secuencia;

        if(_SELECT_GE_SEQ_CARGOS != NULL) delete _SELECT_GE_SEQ_CARGOS;

        return secuencia;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN _SELECT_GE_SEQ_CARGOS";
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return 0;
}

bool DataService::insertGE_CARGOS(GE_CARGOS &this_gecargos)
{
    STRING1000 errorMsg;
    long secuencia;

    secuencia = 0;
    try
    {
        _INSERT_GE_CARGOS->clean(1);

        *(_INSERT_GE_CARGOS) << this_gecargos.COD_CLIENTE
                             << this_gecargos.COD_PRODUCTO
                             << this_gecargos.COD_CONCEPTO
                             << this_gecargos.IMP_CARGO
                             << this_gecargos.COD_MONEDA
                             << this_gecargos.COD_PLANCOM
                             << this_gecargos.NUM_UNIDADES
                             << this_gecargos.IND_FACTUR
                             << this_gecargos.NUM_TRANSACCION
                             << this_gecargos.NUM_VENTA
                             << this_gecargos.NUM_ABONADO
                             << this_gecargos.COD_CICLFACT
                             << this_gecargos.NUM_FACTURA;

        _INSERT_GE_CARGOS->flush();

        int ins_reg = 0 ;
        if((ins_reg = _INSERT_GE_CARGOS->get_rpc()) != 1)
        {
             errorMsg << "ERROR AL INSERTAR  0 REGISTRO EN _INSERT_GE_CARGOS" <<  ENDL;
             errorMsg << "COD_CLIENTE     :" << this_gecargos.COD_CLIENTE << ENDL;
             errorMsg << "COD_PRODUCTO    :" <<this_gecargos.COD_PRODUCTO << ENDL;
             errorMsg << "COD_CONCEPTO    :" <<this_gecargos.COD_CONCEPTO << ENDL;
             errorMsg << "IMP_CARGO       :" <<this_gecargos.IMP_CARGO << ENDL;
             errorMsg << "COD_MONEDA      :" <<this_gecargos.COD_MONEDA << ENDL;
             errorMsg << "COD_PLANCOM     :" <<this_gecargos.COD_PLANCOM << ENDL;
             errorMsg << "NUM_UNIDADES    :" <<this_gecargos.NUM_UNIDADES << ENDL;
             errorMsg << "IND_FACTUR      :" <<this_gecargos.IND_FACTUR << ENDL;
             errorMsg << "NUM_TRANSACCION :" <<this_gecargos.NUM_TRANSACCION << ENDL;
             errorMsg << "NUM_VENTA       :" <<this_gecargos.NUM_VENTA << ENDL;
             errorMsg << "NUM_ABONADO     :" <<this_gecargos.NUM_ABONADO << ENDL;
             errorMsg << "COD_CICLFACT    :" <<this_gecargos.COD_CICLFACT << ENDL;
             errorMsg << "NUM_FACTURA     :" <<this_gecargos.NUM_FACTURA << ENDL;
             errorMsg << "NOM_USUARORA    :" <<this_gecargos.NOM_USUARORA << ENDL;
             return false;
        }

        return true;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN _SELECT_GE_SEQ_CARGOS";
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        errorMsg << "ERROR AL INSERTAR  0 REGISTRO EN _INSERT_GE_CARGOS" <<  ENDL;
        errorMsg << "COD_CLIENTE     :" << this_gecargos.COD_CLIENTE << ENDL;
        errorMsg << "COD_PRODUCTO    :" <<this_gecargos.COD_PRODUCTO << ENDL;
        errorMsg << "COD_CONCEPTO    :" <<this_gecargos.COD_CONCEPTO << ENDL;
        errorMsg << "IMP_CARGO       :" <<this_gecargos.IMP_CARGO << ENDL;
        errorMsg << "COD_MONEDA      :" <<this_gecargos.COD_MONEDA << ENDL;
        errorMsg << "COD_PLANCOM     :" <<this_gecargos.COD_PLANCOM << ENDL;
        errorMsg << "NUM_UNIDADES    :" <<this_gecargos.NUM_UNIDADES << ENDL;
        errorMsg << "IND_FACTUR      :" <<this_gecargos.IND_FACTUR << ENDL;
        errorMsg << "NUM_TRANSACCION :" <<this_gecargos.NUM_TRANSACCION << ENDL;
        errorMsg << "NUM_VENTA       :" <<this_gecargos.NUM_VENTA << ENDL;
        errorMsg << "NUM_ABONADO     :" <<this_gecargos.NUM_ABONADO << ENDL;
        errorMsg << "COD_CICLFACT    :" <<this_gecargos.COD_CICLFACT << ENDL;
        errorMsg << "NUM_FACTURA     :" <<this_gecargos.NUM_FACTURA << ENDL;
        errorMsg << "NOM_USUARORA    :" <<this_gecargos.NOM_USUARORA << ENDL;
        return false;
        //throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return true;
}

bool DataService::update_GA_INFACCEL(GE_CARGOS &this_gecargos,int indicador, int indicadorCobro)
{
    STRING1000 errorMsg;
    try
    {
        _UPDATE_GA_INFACCEL->clean(1);

        *(_UPDATE_GA_INFACCEL) << indicador
                               << indicadorCobro
                               << this_gecargos.COD_CLIENTE
                               << this_gecargos.NUM_ABONADO
                               << this_gecargos.COD_CICLFACT;

        _UPDATE_GA_INFACCEL->flush();

        int up_reg = 0 ;
        if((up_reg = _UPDATE_GA_INFACCEL->get_rpc()) != 1)
        {
             errorMsg << "ERROR AL HACER UPDATE 0 REGISTRO EN _UPDATE_GA_INFACCEL" <<  ENDL;
             errorMsg << "IND_COBRODETLLAM : " << indicador << ENDL;
             errorMsg << "COD_CLIENTE      :" << this_gecargos.COD_CLIENTE << ENDL;
             errorMsg << "NUM_ABONADO      :" <<this_gecargos.NUM_ABONADO << ENDL;
             errorMsg << "COD_CICLFACT     :" <<this_gecargos.COD_CICLFACT << ENDL;
             return false;
        }
        return true;
    }
    catch(otl_exception& error)
    {
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        errorMsg << "ERROR AL INSERTAR  0 REGISTRO EN _INSERT_GE_CARGOS" <<  ENDL;
        errorMsg << "ERROR AL HACER UPDATE 0 REGISTRO EN _UPDATE_GA_INFACCEL" <<  ENDL;
        errorMsg << "IND_COBRODETLLAM : " << indicador << ENDL;
        errorMsg << "COD_CLIENTE      :" << this_gecargos.COD_CLIENTE << ENDL;
        errorMsg << "NUM_ABONADO      :" <<this_gecargos.NUM_ABONADO << ENDL;
        errorMsg << "COD_CICLFACT     :" <<this_gecargos.COD_CICLFACT << ENDL;
        return false;
        //throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return true;
}

RECORD_FA_RANGOSHOST_TO_DTO DataService::selectFA_RANGOSHOST_TO(const STRING & hostId,
                                                                const int codCicloFact)
{
    STRING1000 errorMsg;

    RECORD_FA_RANGOSHOST_TO_DTO tmpRec;
    tmpRec.clear();

    try
    {
        _FA_RANGOSHOST_TO->clean(1);

        *(_FA_RANGOSHOST_TO) << codCicloFact
                             << hostId.c_str();

        if(!_FA_RANGOSHOST_TO->eof())
        {
            *(_FA_RANGOSHOST_TO) >> tmpRec.COD_CLIENTEINI;
            *(_FA_RANGOSHOST_TO) >> tmpRec.COD_CLIENTEFIN;
            tmpRec.RECORD_FOUND = true;
        }
        else
            tmpRec.RECORD_FOUND = false;
    }
    catch(otl_exception& error)
    {
        errorMsg << "ERROR AL BUSCAR EN FA_RANGOSHOST_TO PARA:" << ENDL;
        errorMsg << "[HOST_ID]  = [" << hostId << "]" << ENDL;
        errorMsg << "[COD_CICLFACT] = [" << codCicloFact << "]:" << ENDL;
        errorMsg << "SQL_ERROR_MSG = [" << error.msg << "]" << ENDL;
        errorMsg << "SQL_ERROR_TXT = [" << error.stm_text << "]" << ENDL;
        errorMsg << "SQL_VAR_INFO  = [" << error.var_info << "]" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, "PROCESO TERMINADO CON ERROR", OTL_SQL_ERROR);
    }

    return tmpRec;
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


