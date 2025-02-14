

#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_controler.h,v $ $Revision: 1.5 $ $Date: 2008/06/17 22:20:58 $"
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
#include "LogBuffer.h"



class ProcessControler
{
public:
    ProcessControler();
    ~ProcessControler();
    void init(DataService* db, const int numJob, const int codCicloFact);

    void iniciaProceso();
    int procesoEnError(std::ofstream& logFile, LogBuffer& logger);
    void finProcesoOk();
    static void streamOutLog(std::ofstream& logFile, LogBuffer& log);
    bool repro();
    int getSeqRepro();
private:
    void iniciaNormal();
    void iniciaJob();
    bool verificaJob();
    bool verificaCicloJob(const int codCicloFact,
                          const int numJob);

    DataService*    _db;
    int             _numJob;
    int             _codCicloFact;
    int             _seqRepro;
    bool            _reproMode;
};



#endif //PROCESS_CONTROLER_H
