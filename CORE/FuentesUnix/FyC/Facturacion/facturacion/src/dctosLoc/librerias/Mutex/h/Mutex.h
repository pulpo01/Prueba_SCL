#ifndef NO_INDENT
#ident "@(#)$RCSfile: Mutex.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

///
/// \file Mutex.h
///


#ifndef INCLUDE_MUTEX_H
#define INCLUDE_MUTEX_H

#ifndef WIN32
    #include <pthread.h>
    typedef pthread_mutex_t LockType;
#else
    #include <windows.h>
    #include <process.h>
    /*
    #ifdef __GNUWIN32__ 
    #include "winbase.h"
    typedef long LockType;
    #else
    typedef volatile unsigned long LockType;
    #endif
    */

    typedef volatile unsigned long LockType;
    enum { UNLOCKED = 0, LOCKED = 1 };
#endif

class POSIXMutex
{

public:
    
	POSIXMutex();
    ~POSIXMutex();

    void lock() volatile; 
	void unlock() volatile;
private :

#ifdef WIN32
	void yield(void) volatile;
	int getNumProcessors(void) volatile;
#endif

	LockType _mutexLock;

};

#endif // INCLUDE_MUTEX_H

