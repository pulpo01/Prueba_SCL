

#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_controler.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 15:24:49 $"
#endif

///
/// \file process_controler.h
///


#ifndef PROCESS_CONTROLER_H
#define PROCESS_CONTROLER_H

#ifdef WIN32
#pragma warning(disable:4786)
#endif

#include <string>
#include <iostream>
#include <fstream>
#include "data_service.h"
#include "HostId.h"
#include "LogBuffer.h"

class ProcessControler
{
public:
    ProcessControler();
    ~ProcessControler();
    void init(DataService* db, const int codigoProceso, const int numJob, const int codCicloFact, HostId* hostId);

    void iniciaProceso();
    int procesoEnError(std::ofstream& logFile, LogBuffer& logger);
    void finProcesoOk();
    static void streamOutLog(std::ofstream& logFile, LogBuffer& log);
    bool repro();
    int getSeqRepro();
private:
    void iniciaNormal();

#ifdef _JOB
    void iniciaJob();
    bool verificaJob();
    bool verificaCicloJob(const int codCicloFact,
                          const int numJob);
#endif

    DataService*    _db;
    int 			_codProceso;
    int             _numJob;
    int             _codCicloFact;
    int             _seqRepro;
    bool            _reproMode;
    int 			_indHostId;
    char			_hostId[20+1];
};



#endif //PROCESS_CONTROLER_H
