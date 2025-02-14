#ifndef NO_INDENT
#ident "@(#)$RCSfile: cliente_locutorio_factory.cpp,v $ $Revision: 1.7 $ $Date: 2008/08/04 21:25:27 $"
#endif

///
/// \file cliente_locutorio_factory.cpp
///



#include "cliente_locutorio_factory.h"


ClienteLocutorioFactory::ClienteLocutorioFactory()
{
    _dataServ = NULL;
    _shTables = NULL;
    _log = NULL;
}



ClienteLocutorioFactory::~ClienteLocutorioFactory()
{
}



void ClienteLocutorioFactory::clear()
{
    _recordCicloFact.clear();
}



void ClienteLocutorioFactory::init(DataService& dts, SharedTables& sht, LogBuffer& log)
{
    _dataServ = &dts;
    _shTables = &sht;
    _log = &log;
}



ClientesPadresArray& ClienteLocutorioFactory::build(const int codCicloFact,
                                                    const int numJob)
{
    STRING1000 errorMsg;
    RECORD_FA_CICLFACT_DTO recordCicloFact;

    if((*_log)[9])
    {
        *_log << INDENT2LOGGER << "@Buscar ciclo en FA_CICLFACT para:" << ENDLLOGGER;
        *_log << INDENT3LOGGER << "@[COD_CICLOFACT] =[" << codCicloFact << "@]" << ENDLLOGGER;
    }

    if(numJob < 0)
        recordCicloFact = _dataServ->select_FA_CICLFACT(codCicloFact, IND_FACTURACION_PROC);
    else
        recordCicloFact = _dataServ->select_FA_CICLFACT(codCicloFact, IND_FACTURACION_PROC_JOB);

    _recordCicloFact = recordCicloFact;

    if((*_log)[9])
    {
        *_log << INDENT3LOGGER << "@Registro Encontrado:" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[COD_CICLOFACT]  =[" << recordCicloFact.COD_CICLOFACT << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[COD_CICLO]      =[" << recordCicloFact.COD_CICLO << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[FEC_DESDELLAM]  =[" << recordCicloFact.FEC_DESDELLAM << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[FEC_HASTALLAM]  =[" << recordCicloFact.FEC_HASTALLAM << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[FEC_EMISION]    =[" << recordCicloFact.FEC_EMISION << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[DIA_PERIODO]    =[" << recordCicloFact.DIA_PERIODO << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[IND_FACTURACION]=[" << recordCicloFact.IND_FACTURACION << "@]" << ENDLLOGGER;
    }


    SH_GE_CLILOCPADRE_TO::iterator itrPadre;
    SH_GE_CLILOCHIJO_TO::iterator itrHijo;

    if((*_log)[9])
    {
        *_log << INDENT2LOGGER << "@Recorriendo Clientes Locutorios Padres(COD_CLI_PADRE = 0):" << ENDLLOGGER;
    }

    itrPadre = _shTables->_GE_CLILOCPADREHIJO_TO.find(0);

    if(itrPadre == _shTables->_GE_CLILOCPADREHIJO_TO.end())
    {
        errorMsg << "NO SE HAN ENCONTRADO CLIENTES PADRES EN GE_CLILOCPADREHIJO_TO PARA: [COD_CLI_PADRE] = [0]." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", DATA_ERROR);

    }

    for(itrHijo = (itrPadre->second).begin(); itrHijo != (itrPadre->second).end(); itrHijo++)
    {
        chargeClientePadre(*itrHijo, recordCicloFact, numJob, codCicloFact);
    }

    return _clientesPadres;
}



void ClienteLocutorioFactory::chargeClientePadre(const int codClientePadre,
                                                 const RECORD_FA_CICLFACT_DTO& recordCicloFact,
                                                 const int numJob,
                                                 const int codCicloFact)
{
    int totalAbonados = 0;
    STRING16 currentFecAlta;
    STRING16 currentFecBaja;
    FA_CICLOCLI_RECORDSET* abonados = NULL;
    RECORD_FA_CICLOCLI_DTO recordFA_CICLOCLI;

    if((*_log)[9])
        *_log << INDENT2LOGGER << "@Cargando Cliente Padre: [" << codClientePadre << "@].." << ENDLLOGGER;

    if((*_log)[9])
    {
        *_log << INDENT3LOGGER << "@Buscando Abonados para:" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[COD_CLIENTE]   = [" << codClientePadre << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[COD_CICLO]     = [" << recordCicloFact.COD_CICLO << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[COD_CICLOFACT] = [" << codCicloFact << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[NUM_PROCESO]   = [" << NUM_PROCESO_FA_CICLOCLI << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[IND_MASCARA]   = [" << IND_MASCARA_FA_CICLOCLI << "@]" << ENDLLOGGER;
    }

    abonados = getAbonadosFromFA_CICLOCLI(codClientePadre,
                                          recordCicloFact.COD_CICLO,
                                          codCicloFact,
                                          numJob);

    if((*_log)[9])
        *_log << INDENT3LOGGER << "@Total Abonados Cliente Padre: [" << abonados->NUM_OF_RECORDS << "@].." << ENDLLOGGER;

    ClienteLocutorioPadre clientePadre;
    clientePadre.clear();
    clientePadre.COD_CLIENTE = codClientePadre;
    clientePadre.COD_CICLO = recordCicloFact.COD_CICLO;
    clientePadre.MIN_FEC_ALTA = DATE_MAX_VALUE_YYYYMMDDHH24MISS;
    clientePadre.MAX_FEC_BAJA = "0";

    if(abonados->NUM_OF_RECORDS != 0)
    {
        if((*_log)[9])
            *_log << INDENT3LOGGER << "@Verifica Cliente en ciclo/Job: [" << recordCicloFact.COD_CICLO << "@/" << numJob << "@].." << ENDLLOGGER;

        if(!existeEnJob(clientePadre.COD_CLIENTE, recordCicloFact.COD_CICLO, numJob))
        {
            if((*_log)[9])
                *_log << INDENT4LOGGER << "@Cliente No registrdo para el job.." << ENDLLOGGER;
            return;
        }

        for(int i = 0; i < abonados->NUM_OF_RECORDS; i++)
        {
            recordFA_CICLOCLI.clear();
            recordFA_CICLOCLI = abonados->RECORDSET[i];
            currentFecAlta.clear();
            currentFecBaja.clear();
            currentFecAlta = recordFA_CICLOCLI.FEC_ALTA;
            currentFecBaja = recordFA_CICLOCLI.FEC_BAJA;
            if(currentFecAlta < clientePadre.MIN_FEC_ALTA) clientePadre.MIN_FEC_ALTA = currentFecAlta;
            if(currentFecBaja > clientePadre.MAX_FEC_BAJA) clientePadre.MAX_FEC_BAJA = currentFecBaja;
            clientePadre.ABONADOS.push_back(recordFA_CICLOCLI.NUM_ABONADO);
            totalAbonados++;
        }
    }

    ClienteLocutorio clienteHijo;
    SH_GE_CLILOCPADRE_TO::iterator itrPadre;

    if((*_log)[9])
        *_log << INDENT3LOGGER << "@Carga Clientes Hijos:.." << ENDLLOGGER;


    itrPadre = _shTables->_GE_CLILOCPADREHIJO_TO.find(codClientePadre);

    if(itrPadre != _shTables->_GE_CLILOCPADREHIJO_TO.end())
    {
        SH_GE_CLILOCHIJO_TO::iterator itrHijo;

        for(itrHijo = (itrPadre->second).begin(); itrHijo != (itrPadre->second).end(); itrHijo++)
        {
            clienteHijo.clear();
            clienteHijo.COD_CLIENTE = *itrHijo;

            if((*_log)[9])
            {
                *_log << INDENT4LOGGER << "@Cargando Cliente Hijo: [" << clienteHijo.COD_CLIENTE << "@].." << ENDLLOGGER;
                *_log << INDENT4LOGGER << "@Verifica Cliente en ciclo/Job: [" << recordCicloFact.COD_CICLO << "@/" << numJob << "@].." << ENDLLOGGER;
            }

            if(!existeEnJob(clienteHijo.COD_CLIENTE, recordCicloFact.COD_CICLO, numJob)) continue;

            if((*_log)[9])
            {
                *_log << INDENT4LOGGER << "@Buscando Abonados para:" << ENDLLOGGER;
                *_log << INDENT5LOGGER << "@[COD_CLIENTE]   = [" << clienteHijo.COD_CLIENTE << "@]" << ENDLLOGGER;
                *_log << INDENT5LOGGER << "@[COD_CICLO]     = [" << recordCicloFact.COD_CICLO << "@]" << ENDLLOGGER;
                *_log << INDENT5LOGGER << "@[COD_CICLOFACT] = [" << codCicloFact << "@]" << ENDLLOGGER;
                *_log << INDENT5LOGGER << "@[NUM_PROCESO]   = [" << NUM_PROCESO_FA_CICLOCLI << "@]" << ENDLLOGGER;
                *_log << INDENT5LOGGER << "@[IND_MASCARA]   = [" << IND_MASCARA_FA_CICLOCLI << "@]" << ENDLLOGGER;
            }

            abonados = NULL;
            abonados = getAbonadosFromFA_CICLOCLI(clienteHijo.COD_CLIENTE,
                                                  recordCicloFact.COD_CICLO,
                                                  codCicloFact,
                                                  numJob);

            if((*_log)[9])
                *_log << INDENT4LOGGER << "@Total Abonados Cliente Hijo: [" << abonados->NUM_OF_RECORDS << "@].." << ENDLLOGGER;

            if(abonados->NUM_OF_RECORDS == 0)
            {
                if((*_log)[9])
                    *_log << INDENT5LOGGER << "@Se descarta Cliente Hijo.." << ENDLLOGGER;
                continue;
            }

            for(int i = 0; i < abonados->NUM_OF_RECORDS; i++)
            {
                recordFA_CICLOCLI.clear();
                recordFA_CICLOCLI = abonados->RECORDSET[i];
                currentFecAlta.clear();
                currentFecBaja.clear();
                currentFecAlta = recordFA_CICLOCLI.FEC_ALTA;
                currentFecBaja = recordFA_CICLOCLI.FEC_BAJA;
                if(currentFecAlta < clientePadre.MIN_FEC_ALTA) clientePadre.MIN_FEC_ALTA = currentFecAlta;
                if(currentFecBaja > clientePadre.MAX_FEC_BAJA) clientePadre.MAX_FEC_BAJA = currentFecBaja;
                clienteHijo.ABONADOS.push_back(recordFA_CICLOCLI.NUM_ABONADO);
                totalAbonados++;
            }

            clientePadre.HIJOS.push_back(clienteHijo.COD_CLIENTE, clienteHijo);
        }
    }
    else
    {
        if((*_log)[9])
            *_log << INDENT4LOGGER << "@No se encontraron clientes Hijos.." << ENDLLOGGER;
    }


    if((*_log)[9])
        *_log << INDENT3LOGGER << "@Total Abonados Cliente Padre + Hijos = [" << totalAbonados << "@]." << ENDLLOGGER;

    if(totalAbonados < 1)
    {
        if((*_log)[9])
            *_log << INDENT4LOGGER << "@Se descarta Cliente Locutorio Padre + Hijos: Total Abonados = 0..." << ENDLLOGGER;
        return;
    }


    DECIMAL_NUMBER factorProrateo;
    factorProrateo = 1;

    STRING16 fechaDesdeCiclo;
    STRING16 fechaHastaCiclo;
    fechaDesdeCiclo = recordCicloFact.FEC_DESDELLAM;
    fechaHastaCiclo = recordCicloFact.FEC_HASTALLAM;

    if((*_log)[9])
    {
        *_log << INDENT3LOGGER << "@Calcula Factor de prorateo para:." << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[FEC_DESDELLAM] = [" << fechaDesdeCiclo << "@]." << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[FEC_HASTALLAM] = [" << fechaHastaCiclo << "@]." << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[MIN_FEC_ALTA]  = [" << clientePadre.MIN_FEC_ALTA << "@]." << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[MAX_FEC_BAJA]  = [" << clientePadre.MAX_FEC_BAJA << "@]." << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[DIA_PERIODO]   = [" << recordCicloFact.DIA_PERIODO << "@]." << ENDLLOGGER;
    }


    factorProrateo = getFactorProrateo(fechaDesdeCiclo,
                                       fechaHastaCiclo,
                                       clientePadre.MIN_FEC_ALTA,
                                       clientePadre.MAX_FEC_BAJA,
                                       recordCicloFact.DIA_PERIODO);

    if((*_log)[9])
        *_log << INDENT5LOGGER << "@Factor Prorateo = [" << factorProrateo << "@]." << ENDLLOGGER;


    if(!cargaPlanesDcto(clientePadre, recordCicloFact, codCicloFact, factorProrateo, numJob))
    {
        if((*_log)[9])
        {
            *_log << INDENT4LOGGER << "@No se han encontrado planes de dcto validos:" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@Se descarta Cliente Locutorio Padre + Hijos..." << ENDLLOGGER;
        }
        return;
    }

    _clientesPadres.push_back(clientePadre.COD_CLIENTE, clientePadre);

}


bool ClienteLocutorioFactory::existeEnJob(const int codCliente,
                                          const int codCiclo,
                                          const int numJob)
{
    if(numJob < 0) return true;

    return _dataServ->select_FA_CLIENTEJOB_TO(codCliente, numJob, codCiclo);
}



bool ClienteLocutorioFactory::cargaPlanesDcto(ClienteLocutorioPadre& clientePadre,
                                              const RECORD_FA_CICLFACT_DTO& recordCicloFact,
                                              const int codCicloFact,
                                              const DECIMAL_NUMBER factorProrateo,
                                              const int numJob)
{
    if((*_log)[9])
    {
        *_log << INDENT3LOGGER << "@Carga Planes Dcto para:" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[COD_CLIENTE]  = [" << clientePadre.COD_CLIENTE << "@] (padre)" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[COD_CICLFACT] = [" << codCicloFact << "@]" << ENDLLOGGER;
        *_log << INDENT4LOGGER << "@[FEC_EMISION]  = [" << recordCicloFact.FEC_EMISION << "@]" << ENDLLOGGER;
    }

    GAT_PLANDESCABO_RECORDSET* planes = NULL;

    planes = &(_dataServ->select_GAT_PLANDESCABO(clientePadre.COD_CLIENTE,
                                                 codCicloFact,
                                                 recordCicloFact.FEC_EMISION,
                                                 numJob));

    if((*_log)[9])
        *_log << INDENT5LOGGER << "@Total Planes Dcto: [" << planes->NUM_OF_RECORDS << "@]." << ENDLLOGGER;

    if(planes->NUM_OF_RECORDS == 0) return false;

    PlanDescuento planDcto;
    RECORD_GAT_PLANDESCABO_DTO plan;
    bool planFound = false;

    if((*_log)[9])
        *_log << INDENT3LOGGER << "@Verificando Planes de Dcto:" << ENDLLOGGER;

    for(int i = 0; i < planes->NUM_OF_RECORDS; i++)
    {
        planDcto.clear();
        plan.clear();

        plan = planes->RECORDSET[i];
        planDcto.COD_CONCEPTO   << plan.COD_CONCDESC;
        planDcto.COD_PLAN       = plan.COD_PLANDESC;
        planDcto.MTO_MIN        = plan.MTO_MINFACT;
        planDcto.NUM_SEC        = plan.NUM_SECUENCIA;
        planDcto.TIP_ENTIDAD    = plan.TIP_ENTIDAD;
        planDcto.TIP_UNIDAD     = plan.TIP_UNIDAD;

        if((*_log)[9])
        {
            *_log << INDENT3LOGGER << "@Plan Dcto [" << i << "@]:" << ENDLLOGGER;
            *_log << INDENT4LOGGER << "@[COD_PLAN]     = [" << planDcto.COD_PLAN << "@]" << ENDLLOGGER;
            *_log << INDENT4LOGGER << "@[NUM_SEC]      = [" << planDcto.NUM_SEC << "@]" << ENDLLOGGER;
            *_log << INDENT4LOGGER << "@[TIP_ENTIDAD]  = [" << planDcto.TIP_ENTIDAD << "@]" << ENDLLOGGER;
            *_log << INDENT4LOGGER << "@[TIP_UNIDAD]   = [" << planDcto.TIP_UNIDAD << "@]" << ENDLLOGGER;
            *_log << INDENT4LOGGER << "@[MTO_MIN]      = [" << planDcto.MTO_MIN << "@]" << ENDLLOGGER;
            *_log << INDENT4LOGGER << "@[COD_CONCEPTO] = [" << planDcto.COD_CONCEPTO << "@]" << ENDLLOGGER;
        }


        if(planDcto.TIP_ENTIDAD != "C" && planDcto.TIP_ENTIDAD != "B")
        {
            if((*_log)[9])
                *_log << INDENT5LOGGER << "@Se descarta plan: TIP_ENTIDAD debe tener valor C/B..." << ENDLLOGGER;
            continue;
        }

        if((*_log)[9])
        {
            *_log << INDENT4LOGGER << "@Recuperando conceptos EVAL para:" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[COD_GRUPOEVAL] = [" << plan.COD_GRUPOEVAL << "@]" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[COD_TIPEVAL]   = [" << plan.COD_TIPEVAL << "@]" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[FEC_EMISION]   = [" << recordCicloFact.FEC_EMISION << "@]" << ENDLLOGGER;
        }

        if(!cargaConceptosEval(planDcto, plan.COD_GRUPOEVAL, plan.COD_TIPEVAL, recordCicloFact.FEC_EMISION))
        {
            if((*_log)[9])
                *_log << INDENT4LOGGER << "@Se descarta plan..." << ENDLLOGGER;
            continue;
        }

        if((*_log)[9])
        {
            *_log << INDENT4LOGGER << "@Recuperando conceptos APLI para:" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[COD_GRUPOAPLI] = [" << plan.COD_GRUPOAPLI << "@]" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[COD_TIPAPLI]   = [" << plan.COD_TIPAPLI << "@]" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[FEC_EMISION]   = [" << recordCicloFact.FEC_EMISION << "@]" << ENDLLOGGER;
        }

        if(!cargaConceptosApli(planDcto, plan.COD_GRUPOAPLI, plan.COD_TIPAPLI, recordCicloFact.FEC_EMISION))
        {
            if((*_log)[9])
                *_log << INDENT4LOGGER << "@Se descarta plan..." << ENDLLOGGER;
            continue;
        }

        if((*_log)[9])
        {
            *_log << INDENT4LOGGER << "@Recuperando ccuadrantes para:" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[NUM_CUADRANTE] = [" << plan.NUM_CUADRANTE << "@]" << ENDLLOGGER;
            *_log << INDENT5LOGGER << "@[FEC_EMISION]   = [" << recordCicloFact.FEC_EMISION << "@]" << ENDLLOGGER;
        }

        if(!cargaCuadrantes(planDcto, plan.NUM_CUADRANTE, recordCicloFact.FEC_EMISION))
        {
            if((*_log)[9])
                *_log << INDENT4LOGGER << "@Se descarta plan..." << ENDLLOGGER;
            continue;
        }

        if(planDcto.TIP_ENTIDAD == "B")
        {
            if((*_log)[9])
                *_log << INDENT4LOGGER << "@[TIP_ENTIDAD] = [B], Plan Bolsa reconocido..." << ENDLLOGGER;

            prorateaPlanDcto(planDcto, factorProrateo);
            clientePadre.PLAN_BOLSA = planDcto;
        }
        else
        {
            clientePadre.PLANES_ADD.push_back(planDcto.COD_PLAN, planDcto);
        }

        planFound = true;
    }

    return planFound;
}



bool ClienteLocutorioFactory::cargaConceptosEval(PlanDescuento& planDcto,
                                                 const int codGrupo,
                                                 const char* codTipo,
                                                 const char* fecEmi)
{
    FAD_CONCEVAL_RECORDSET* records = NULL;
    RECORD_FAD_CONCEVAL_DTO record;
    ConceptoEvalDcto cptoEval;
    planDcto.CRITERIO_EVAL.COD_GRUPO << codGrupo;
    planDcto.CRITERIO_EVAL.COD_TIPO = codTipo;

    if(planDcto.CRITERIO_EVAL.COD_TIPO != "C")
    {
        if((*_log)[9])
            *_log << INDENT6LOGGER << "COD_TIPOEVAL <> C" << ENDLLOGGER;
        return false;
    };

    records = &(_dataServ->select_FAD_CONCEVAL(codGrupo, fecEmi));

    if((*_log)[9])
        *_log << INDENT6LOGGER << "@Total Conceptos EVAL: [" << records->NUM_OF_RECORDS << "@]." << ENDLLOGGER;

    if(records->NUM_OF_RECORDS == 0)
    {
        if((*_log)[9])
            *_log << INDENT7LOGGER << "Num Conceptos EVAL < 1" << ENDLLOGGER;
        return false;
    }

    for(int i = 0; i < records->NUM_OF_RECORDS; i++)
    {
        record.clear();
        record = records->RECORDSET[i];
        cptoEval.clear();
        cptoEval.COD_CONCEPTO << record.COD_CONCEPTO;
        cptoEval.ES_REQUERIDO = (strcmp(record.IND_OBLIGA, "1") == 0);
        cptoEval.MTO_MIN = record.MTO_MINFACT;

        if((*_log)[9])
        {
            *_log << INDENT7LOGGER << "@Concepto EVAL [" << i << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[COD_CONCEPTO] = [" << cptoEval.COD_CONCEPTO << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[ES_REQUERIDO] = [" << cptoEval.ES_REQUERIDO << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[MTO_MIN]      = [" << cptoEval.MTO_MIN << "@]:" << ENDLLOGGER;
        }

        planDcto.CRITERIO_EVAL.push_back(cptoEval.COD_CONCEPTO, cptoEval);
    }

    if((*_log)[9])
        *_log << INDENT6LOGGER << "@Conceptos EVAL OK..." << ENDLLOGGER;

    return true;
}


bool ClienteLocutorioFactory::cargaConceptosApli(PlanDescuento& planDcto, const int codGrupo, const char* codTipo, const char* fecEmi)
{
    FAD_CONCAPLI_RECORDSET* records = NULL;
    RECORD_FAD_CONCAPLI_DTO record;
    ConceptoApliDcto cptoApli;
    planDcto.CRITERIO_APLI.COD_GRUPO << codGrupo;
    planDcto.CRITERIO_APLI.COD_TIPO = codTipo;

    if(planDcto.CRITERIO_APLI.COD_TIPO != "C")
    {
        if((*_log)[9])
            *_log << INDENT6LOGGER << "COD_TIPOAPLI <> C" << ENDLLOGGER;
        return false;
    };

    records = &(_dataServ->select_FAD_CONCAPLI(codGrupo, fecEmi));

    if((*_log)[9])
        *_log << INDENT6LOGGER << "@Total Conceptos APLI: [" << records->NUM_OF_RECORDS << "@]." << ENDLLOGGER;

    if(records->NUM_OF_RECORDS == 0)
    {
        if((*_log)[9])
            *_log << INDENT7LOGGER << "Num Conceptos APLI < 1" << ENDLLOGGER;
        return false;
    }

    for(int i = 0; i < records->NUM_OF_RECORDS; i++)
    {
        record.clear();
        record = records->RECORDSET[i];
        cptoApli.clear();
        cptoApli.COD_CONCEPTO_DESCONTAR << record.COD_CONCEPTO;
        cptoApli.COD_CONCEPTO_DESCUENTO << record.COD_CONREL;

        if((*_log)[9])
        {
            *_log << INDENT7LOGGER << "@Concepto APLI [" << i << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[COD_CONCEPTO] = [" << cptoApli.COD_CONCEPTO_DESCONTAR << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[COD_CONREL]   = [" << cptoApli.COD_CONCEPTO_DESCUENTO << "@]:" << ENDLLOGGER;
        }

        planDcto.CRITERIO_APLI.push_back(cptoApli.COD_CONCEPTO_DESCONTAR, cptoApli);
    }

    if((*_log)[9])
        *_log << INDENT6LOGGER << "@Conceptos APLI OK..." << ENDLLOGGER;

    return true;
}


bool ClienteLocutorioFactory::cargaCuadrantes(PlanDescuento& planDcto, const int codGrupo, const char* fecEmi)
{
    FAD_CUADRANDESC_RECORDSET* records = NULL;
    RECORD_FAD_CUADRANDESC_DTO record;
    RegistroCuadrante q;
    planDcto.CUADRANTE_PLAN.NUM_CUADRANTE = codGrupo;

    records = &(_dataServ->select_FAD_CUADRANDESC(codGrupo, fecEmi));

    if((*_log)[9])
        *_log << INDENT6LOGGER << "@Total Cuadrantes: [" << records->NUM_OF_RECORDS << "@]." << ENDLLOGGER;

    if(records->NUM_OF_RECORDS == 0)
    {
        if((*_log)[9])
            *_log << INDENT7LOGGER << "Num Cuadrantes < 1" << ENDLLOGGER;
        return false;
    }

    for(int i = 0; i < records->NUM_OF_RECORDS; i++)
    {
        record.clear();
        record = records->RECORDSET[i];
        q.clear();
        q._tipoDcto = record.TIP_DESCUENTO;
        q._tipoMoneda = record.TIP_MONEDA;
        q._valDcto = atof(record.VAL_DESCUENTO);
        q._valDesde = atof(record.VAL_DESDE);
        q._valHasta = atof(record.VAL_HASTA);

        if((*_log)[9])
        {
            *_log << INDENT7LOGGER << "@Cuadrante [" << i << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[TIP_DESCUENTO] = [" << q._tipoDcto << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[TIP_MONEDA]    = [" << q._tipoMoneda << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[VAL_DESCUENTO] = [" << q._valDcto << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[VAL_DESDE]     = [" << q._valDesde << "@]:" << ENDLLOGGER;
            *_log << INDENT8LOGGER << "@[VAL_HASTA]     = [" << q._valHasta << "@]:" << ENDLLOGGER;
        }

        if(q._tipoDcto == "M" && planDcto.TIP_ENTIDAD != "B")
        {
            if((*_log)[9])
                *_log << INDENT9LOGGER << "TIP_DCTO == M (monto) para TIP_ENTIDAD <> B (plan bolsa)" << ENDLLOGGER;
            return false;
        }
        planDcto.CUADRANTE_PLAN.push_back(q);
    }

    if((*_log)[9])
        *_log << INDENT6LOGGER << "@Cuadrante OK..." << ENDLLOGGER;

    return true;
}




DECIMAL_NUMBER ClienteLocutorioFactory::getFactorProrateo(const STRING16& fechaDesdeCiclo,
                                                          const STRING16& fechaHastaCiclo,
                                                          const STRING16& minFecAlta,
                                                          const STRING16& maxFecBaja,
                                                          const int diasPeriodo)
{
    DECIMAL_NUMBER factorPro;
    int fecCIni;
    int fecCEnd;
    int fecAlta;
    int fecBaja;

    fecCIni = atoi(fechaDesdeCiclo.substr(0,8).c_str());
    fecCEnd = atoi(fechaHastaCiclo.substr(0,8).c_str());
    fecAlta = atoi(minFecAlta.substr(0,8).c_str());
    fecBaja = atoi(maxFecBaja.substr(0,8).c_str());
    factorPro = 1;

    int caso = -1;

    if(fecAlta <= fecCIni && fecBaja >= fecCEnd) caso = 0;
    if(fecAlta  > fecCIni && fecBaja >= fecCEnd) caso = 1;
    if(fecAlta <= fecCIni && fecBaja <  fecCEnd) caso = 2;
    if(fecAlta  > fecCIni && fecBaja <  fecCEnd) caso = 3;

    int diasAlta = 0;

    switch(caso)
    {
        case(0):
            factorPro = 1;
            return factorPro;
        case(1):
            bRestaFechas(fechaHastaCiclo.substr(0,8).c_str(), minFecAlta.substr(0,8).c_str(), &diasAlta);
            break;
        case(2):
            bRestaFechas(maxFecBaja.substr(0,8).c_str(), fechaDesdeCiclo.substr(0,8).c_str(), &diasAlta);
            break;
        case(3):
            bRestaFechas(maxFecBaja.substr(0,8).c_str(), minFecAlta.substr(0,8).c_str(), &diasAlta);
            break;
        default:
            break;
    }

    factorPro = (static_cast<double>(diasAlta)/static_cast<double>(diasPeriodo));

    return factorPro;
}





void ClienteLocutorioFactory::prorateaPlanDcto(PlanDescuento& planDcto, const DECIMAL_NUMBER& factorProrateo)
{
    RegistroCuadrante* rq = NULL;

    if((*_log)[9])
        *_log << INDENT4LOGGER << "@Prorateando Cuadrantes:" << ENDLLOGGER;


    for(int q = 0; q < planDcto.CUADRANTE_PLAN.getNumOfRecords(); q++)
    {
        rq = &(planDcto.CUADRANTE_PLAN[q]);

        if((*_log)[9])
        {
            *_log << INDENT5LOGGER << "@Cuadrante [" << q << "@] (ANTES):" << ENDLLOGGER;
            *_log << INDENT6LOGGER << "@[VAL_DESCUENTO] = [" << rq->_valDcto << "@]:" << ENDLLOGGER;
            *_log << INDENT6LOGGER << "@[VAL_DESDE]     = [" << rq->_valDesde << "@]:" << ENDLLOGGER;
            *_log << INDENT6LOGGER << "@[VAL_HASTA]     = [" << rq->_valHasta << "@]:" << ENDLLOGGER;
        }

        rq->_valDesde = (rq->_valDesde * factorProrateo);
        rq->_valHasta = (rq->_valHasta * factorProrateo);
        if(rq->_tipoDcto == "M")
            rq->_valDcto = (rq->_valDcto * factorProrateo);

        if((*_log)[9])
        {
            *_log << INDENT5LOGGER << "@Cuadrante [" << q << "@] (DESPUES):" << ENDLLOGGER;
            *_log << INDENT6LOGGER << "@[VAL_DESCUENTO] = [" << rq->_valDcto << "@]:" << ENDLLOGGER;
            *_log << INDENT6LOGGER << "@[VAL_DESDE]     = [" << rq->_valDesde << "@]:" << ENDLLOGGER;
            *_log << INDENT6LOGGER << "@[VAL_HASTA]     = [" << rq->_valHasta << "@]:" << ENDLLOGGER;
        }
    }
};


RECORD_FA_CICLFACT_DTO& ClienteLocutorioFactory::getCicloFactRecord()
{
    return _recordCicloFact;
}




FA_CICLOCLI_RECORDSET* ClienteLocutorioFactory::getAbonadosFromFA_CICLOCLI(const int codCliente,
                                                                           const int codCiclo,
                                                                           const int codCicloFact,
                                                                           const int numJob)
{
    FA_CICLOCLI_RECORDSET* abonados = NULL;

    if(numJob < 0)
    {
        abonados = &(_dataServ->select_FA_CICLOCLI(codCliente,
                                                   codCiclo,
                                                   codCicloFact,
                                                   NUM_PROCESO_FA_CICLOCLI,
                                                   IND_MASCARA_FA_CICLOCLI));
    }
    else
    {
        abonados = &(_dataServ->select_FA_CICLOCLI_JOB(codCliente,
                                                       codCiclo,
                                                       codCicloFact,
                                                       NUM_PROCESO_FA_CICLOCLI));
    }

    return abonados;
}




