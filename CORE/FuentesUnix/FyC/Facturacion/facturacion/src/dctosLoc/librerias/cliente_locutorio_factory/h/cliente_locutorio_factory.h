#ifndef NO_INDENT
#ident "@(#)$RCSfile: cliente_locutorio_factory.h,v $ $Revision: 1.6 $ $Date: 2008/08/04 21:25:28 $"
#endif

///
/// \file cliente_locutorio_factory.h
///

#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef CLIENTE_LOC_FACTORY_H
#define CLIENTE_LOC_FACTORY_H

#include "LogBuffer.h"
#include "cliente_locutorio.h"
#include "data_service.h"
#include "shared_tables.h"



typedef SimpleMapInterface<int, ClienteLocutorioPadre> ClientesPadresArray;


class ClienteLocutorioFactory
{
public:
    ClienteLocutorioFactory();
    ~ClienteLocutorioFactory();

    void clear();
    void init(DataService& dts, SharedTables& sht, LogBuffer& log);
    ClientesPadresArray& build(const int codCicloFact,
                               const int numJob);
    RECORD_FA_CICLFACT_DTO& getCicloFactRecord();
private:
    DataService*            _dataServ;
    SharedTables*           _shTables;
    LogBuffer*              _log;
    ClientesPadresArray     _clientesPadres;
    RECORD_FA_CICLFACT_DTO  _recordCicloFact;

    void chargeClientePadre(const int codClientePadre,
                            const RECORD_FA_CICLFACT_DTO& recordCicloFact,
                            const int numJob,
                            const int codCicloFact);
    bool existeEnJob(const int codCliente, const int codCiclo, const int numJob);

    bool cargaPlanesDcto(ClienteLocutorioPadre& clientePadre,
                         const RECORD_FA_CICLFACT_DTO& recordCicloFact,
                         const int codCicloFact,
                         const DECIMAL_NUMBER factorProrateo,
                         const int numJob);

    bool cargaConceptosEval(PlanDescuento& planDcto,
                            const int codGrupo,
                            const char* codTipo,
                            const char* fecEmi);
    bool cargaConceptosApli(PlanDescuento& planDcto,
                            const int codGrupo,
                            const char* codTipo,
                            const char* fecEmi);
    bool cargaCuadrantes(PlanDescuento& planDcto,
                         const int codGrupo,
                         const char* fecEmi);

    DECIMAL_NUMBER getFactorProrateo(const STRING16& fechaDesdeCiclo,
                                     const STRING16& fechaHastaCiclo,
                                     const STRING16& minFecAlta,
                                     const STRING16& maxFecBaja,
                                     const int diasPeriodo);
    void prorateaPlanDcto(PlanDescuento& planDcto, const DECIMAL_NUMBER& factorProrateo);

    FA_CICLOCLI_RECORDSET* getAbonadosFromFA_CICLOCLI(const int codCliente,
                                                      const int codCiclo,
                                                      const int codCicloFact,
                                                      const int numJob);
};





#endif //CLIENTE_LOC_FACTORY_H
