#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_thread.h,v $ $Revision: 1.4 $ $Date: 2008/05/27 14:39:50 $"
#endif

///
/// \file process_thread.h
///


#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef PROCESS_THREAD_H
#define PROCESS_THREAD_H

#include "Thread.h"
#include "Mutex.h"



class ProcessThread : public POSIXThread
{
public:
    enum Status {FREE, BUSY};

private:
    POSIXMutex              _statusMutex;
    POSIXMutex              _processMutex;
    Status                  _currentStat;


public:
    ProcessThread()
    {
        _currentStat = FREE;
#ifndef WIN32
        if(!setThreadAttr(PTHREAD_SCOPE_SYSTEM, PTHREAD_CREATE_JOINABLE, 0, SCHED_OTHER, PTHREAD_EXPLICIT_SCHED))
        {
            throw ProcessCoreException("SharedTables : setting thread attributes -> FAIL\n");
        }
#endif
    };

    void clear()
    {
        _statusMutex.lock();
        if(_currentStat != BUSY) _currentStat = FREE;
        _statusMutex.unlock();
    };

    ~ProcessThread()
    {
    };

    void joined()
    {
        _processMutex.lock();
        _processMutex.unlock();
    };

    Status getStatus()
    {
        Status tmpVal;
        _statusMutex.lock();
        tmpVal = _currentStat;
        _statusMutex.unlock();
        return tmpVal;
    };

    bool start()
    {
        _statusMutex.lock();
        _currentStat = BUSY;
        _statusMutex.unlock();
        _processMutex.lock();
        return POSIXThread::start();
    }

    void signalThreadEnd()
    {
        _statusMutex.lock();
        _currentStat = FREE;
        _statusMutex.unlock();
        _processMutex.unlock();
    };
};




#endif //PROCESS_THREAD_H


