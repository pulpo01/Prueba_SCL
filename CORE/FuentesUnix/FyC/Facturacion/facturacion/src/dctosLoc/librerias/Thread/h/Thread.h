#ifndef NO_INDENT
#ident "@(#)$RCSfile: Thread.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

///
/// \file Thread.h
///


#ifndef INCLUDE_THREAD_H
#define INCLUDE_THREAD_H

#ifndef WIN32
    #include <pthread.h>
    #include <sched.h>
    #include <sys/types.h>
    //#include "Mutex.h"

    #define THREAD_IDLE     0
    #define THREAD_RUNNING  1
    #define THREAD_DEAD     2
    #define THREAD_GCR      3

    extern "C"
	{
        typedef void* (*PTHREAD_EXE_HANDLER_FUNC)(void*);
	};

	typedef pthread_t    POSIXThreadType;

#else
    #include <windows.h>
    #include <process.h>

	typedef HANDLE    POSIXThreadType;

    // Define for compability...
    #define PTHREAD_SCOPE_SYSTEM 0
    #define PTHREAD_CREATE_DETACHED 0
    #define SCHED_OTHER 0
    #define PTHREAD_EXPLICIT_SCHED 0
#endif

class POSIXThread 
{

public:

    POSIXThread();
    virtual ~POSIXThread()=0;

    bool operator == (const POSIXThread& obj) const;
    bool operator != (const POSIXThread& obj) const;

    virtual bool  start();
    bool  setThreadState(int state);
    int   getThreadState();
    int  terminate();
    void  exit();

protected:

    virtual void execute()=0;
    static  void* threadFunction(void *);

    void    run();
    int     detach(void) const;
    void    yield(void)  const;
    int     self()       const;
    int     join(void);

    bool    setPriority(int priority);
    int     getPriority();

    bool    setThreadAttr(int contentionscope,
                          int detachstate,
                          int priority,
                          int policy,
                          int inheritsched);

private:

#ifdef WIN32
    bool create(void * (*function) (void *), void * arg);
#else
	pthread_attr_t    *_threadAttr;

#endif

    POSIXThreadType   _threadId;
	int               _currentState;
};


#endif
