#ifndef NO_INDENT
#ident "@(#)$RCSfile: Thread.cpp,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif
 
///
/// \file Thread.cpp
///


#include "Thread.h"




///////////////////////////////////////////////////////////////////////////////////////////////
POSIXThread::POSIXThread(void)
{
#ifndef WIN32
	_threadAttr = NULL;
    _currentState = THREAD_IDLE;
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
POSIXThread::~POSIXThread(void)
{
#ifndef WIN32
	if(_threadAttr != NULL) delete _threadAttr;
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
bool POSIXThread::operator==(const POSIXThread& obj) const
{
#ifndef WIN32
   return (pthread_equal(_threadId, _threadId) != 0);
#else
   return true;
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
bool POSIXThread::operator!=(const POSIXThread& obj) const
{
#ifndef WIN32
   return !operator==(obj);
#else
   return true;
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
void POSIXThread::run()
{
#ifndef WIN32
    setThreadState(THREAD_RUNNING); 
    execute();
    setThreadState(THREAD_DEAD);    
#else
	execute();
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
void* POSIXThread::threadFunction(void* pt)
{
    POSIXThread* thrd = reinterpret_cast<POSIXThread*>(pt);

    if(thrd){ thrd->run(); }

    return NULL;
}




///////////////////////////////////////////////////////////////////////////////////////////////
bool POSIXThread::start()
{
#ifndef WIN32
   if (pthread_create(&_threadId,_threadAttr,(PTHREAD_EXE_HANDLER_FUNC)&(POSIXThread::threadFunction),this) == 0){

      pthread_detach(_threadId);
      return true;  
   
   }else{

      setThreadState(THREAD_DEAD);
      return false;
   }   
#else
    return(create(threadFunction, this)); 
#endif
}





///////////////////////////////////////////////////////////////////////////////////////////////
int POSIXThread::self() const
{
   return (int)_threadId;
}





///////////////////////////////////////////////////////////////////////////////////////////////
int POSIXThread::detach(void) const
{
   POSIXThreadType tempThreadID = _threadId;
   tempThreadID = 0; // this is done so as not to get an "unused-warning"

#ifndef WIN32   
   return(pthread_detach(_threadId));
#else
   return 0;
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
bool POSIXThread::setThreadState(int state)
{
   _currentState = state;
   return true;
}




///////////////////////////////////////////////////////////////////////////////////////////////
bool POSIXThread::setThreadAttr(int contentionscope, int detachstate, int priority, int policy, int inheritsched)
{
#ifndef WIN32
	int rc;

    if(_threadAttr != NULL){ return false; }

    if(contentionscope != PTHREAD_SCOPE_SYSTEM && contentionscope != PTHREAD_SCOPE_PROCESS)
    {
        /*
             PTHREAD_SCOPE_SYSTEM
                   Indicates system  scheduling  contention  scope.  This
                   thread  is  permanently "bound" to an LWP, and is also
                   called a bound thread.

             PTHREAD_SCOPE_PROCESS
                   Indicates process scheduling  contention  scope.  This
                   thread is not "bound" to an LWP, and is also called an
                   unbound thread. PTHREAD_SCOPE_PROCESS, or unbound,  is
                   the default.
        */
        return false;
    }

    if(detachstate != PTHREAD_CREATE_DETACHED && detachstate != PTHREAD_CREATE_JOINABLE)
    {
        /*
         The     detachstate     can     be     set     to     either
         PTHREAD_CREATE_DETACHED   or    PTHREAD_CREATE_JOINABLE.   A
         value of  PTHREAD_CREATE_DETACHED causes all threads created
         with attr to be in the detached state, whereas using a value
         of PTHREAD_CREATE_JOINABLE causes all threads  created  with
         attr  to  be in the joinable state. The default value of the
         detachstate attribute is PTHREAD_CREATE_JOINABLE.
        */
        return false;
    }

    if((priority > 10) || (priority < 0)) return false;

    if(policy != SCHED_FIFO && policy != SCHED_RR && policy != SCHED_OTHER)
    {
        /*
         The supported values of policy include  SCHED_FIFO, SCHED_RR
         and  SCHED_OTHER, which are defined by the header <sched.h>.
         When threads executing with the scheduling policy SCHED_FIFO
         or   SCHED_RR are waiting on a mutex, they acquire the mutex
         in priority order when the mutex is unlocked.
        */
        return false;
    }

    if(inheritsched != PTHREAD_INHERIT_SCHED && inheritsched != PTHREAD_EXPLICIT_SCHED)
    {
        /*
         PTHREAD_INHERIT_SCHED
               Specifies that the scheduling  policy  and  associated
               attributes  are  to  be  inherited  from  the creating
               thread, and the scheduling  attributes  in  this  attr
               argument are to be ignored.

         PTHREAD_EXPLICIT_SCHED
               Specifies that the scheduling  policy  and  associated
               attributes  are  to be set to the corresponding values
               from this attribute object.
        */
        return false;
    }

    _threadAttr = new pthread_attr_t;

    rc = pthread_attr_init(_threadAttr);
    if (rc)
    {
        delete _threadAttr;
        _threadAttr = NULL;
        return false;
    }
 
    rc = pthread_attr_setscope(_threadAttr, contentionscope);
    if (rc)
    {
        delete _threadAttr;
        _threadAttr = NULL;
        return false;
    }

    rc = pthread_attr_setdetachstate(_threadAttr, detachstate);
    if (rc)
    {
        delete _threadAttr;
        _threadAttr = NULL;
        return false;
    }

    rc = pthread_attr_setschedpolicy(_threadAttr, policy);
    if (rc)
    {
         delete _threadAttr;
        _threadAttr = NULL;
        return false;
    }

    rc = pthread_attr_setinheritsched(_threadAttr, inheritsched);
    if (rc)
    {
        delete _threadAttr;
        _threadAttr = NULL;
        return false;
    }

    return true;
#else
    return true; 
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
#ifdef WIN32
bool POSIXThread::create(void * (*function) (void *), void * arg) 
{
   if( (_threadId = CreateThread(0, 0,(LPTHREAD_START_ROUTINE) *function,(LPVOID) arg, 0, 0)) == NULL )
	   return false;
   else
	   return true;
}
#endif





///////////////////////////////////////////////////////////////////////////////////////////////
int POSIXThread::join(void)
{
#ifndef WIN32
   int status = 0;

   if (pthread_join(_threadId, (void**)&status) != 0)
   //{
   //   POSIXSynchronousEvent("POSIXThread::join() - Failed to join thread.",_threadId);      
   //}

   return status;
#else
    return((int)WaitForSingleObject(_threadId, INFINITE)); 
#endif
}





///////////////////////////////////////////////////////////////////////////////////////////////
void POSIXThread::yield(void) const 
{
#ifndef WIN32
    sched_yield();
#else
    Sleep(0); 
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
int POSIXThread::terminate()
{
#ifndef WIN32
   return( pthread_cancel(_threadId) );
#else
   return 0;
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
void POSIXThread::exit()
{
#ifndef WIN32
   pthread_exit((void**)0);
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
bool POSIXThread::setPriority(int priority)
{
#ifndef WIN32
   if ((priority > 10) || (priority < 0)) return false;

   struct sched_param threadParameter;

   threadParameter.sched_priority = priority;

   if (pthread_setschedparam(_threadId, SCHED_OTHER, &threadParameter) != 0){

	   return false;

   }else{

      return true;

   }
#else
   return false;
#endif
}




///////////////////////////////////////////////////////////////////////////////////////////////
int POSIXThread::getPriority()
{
#ifndef WIN32
   struct sched_param threadParameter;
   int                policy = 0;

   if(pthread_getschedparam(_threadId, &policy, &threadParameter) == 0){
	   
	   return -1;
   
   }else{

      return threadParameter.sched_priority;

   }
#else
   return -1;
#endif
}

