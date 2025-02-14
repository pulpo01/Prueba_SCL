#ifndef NO_INDENT
#ident "@(#)$RCSfile: hr_time_clock.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 16:30:16 $"
#endif

///
/// \file hr_time_clock.h
///


#ifndef HR_TIME_CLOCK_H
#define HR_TIME_CLOCK_H

#ifndef WIN32
#include <sys/time.h>
#else
#include <windows.h>
#endif


#ifdef LIN32
extern unsigned rtime_sec();
extern unsigned rtime_nano();
#endif

#include <iostream>

using namespace std;

#ifndef LIN32
// SOLARIS && WINDOWS
class HighResolutionClock
{

private:

    double _start;
    double _end;
#ifdef WIN32
	LARGE_INTEGER _frequency;
	LARGE_INTEGER _counter;  //__int64
#endif

    double getTime()
    {
#ifdef OSX_32
        return 0;
#else
#ifndef WIN32
        return( (double) gethrtime() );
#else
		QueryPerformanceCounter(&_counter);
        return( (double) _counter.QuadPart / _frequency.QuadPart );
#endif
#endif
    };

public:

#ifdef WIN32
	HighResolutionClock::HighResolutionClock()
	{
	    QueryPerformanceFrequency(&_frequency);
	}
#endif

    void markStart()
    {
        _start = getTime();
    };

    void markEnd()
    {
        _end = getTime();
    };

    void markEnd(const char* msg)
    {
        markEnd();
        if(strlen(msg) == 0) return;

        cout << msg;
        cout << "\t\t\t";
        cout << getElapsedTimeSEC();
        cout << "\t\t\t";
        cout << "(secs)";
        cout << "\t\t\t";
        cout << getElapsedTimeMSEC();
        cout << "\t\t\t";
        cout << "(secs)";
        cout << "\t\t\t" << endl;
    };

    double getElapsedTimeMSEC()
    {
        double dt = 0;
#ifdef WIN32
        dt = (double)(_end - _start) * 1.00E-9;
#else
        dt = (double)(_end - _start);
#endif
        return dt;
    };

    double getElapsedTimeSEC()
    {
        double dt = 0.0;
#ifdef WIN32
		dt = ((double)(_end - _start));
#else
        dt = ((double)(_end - _start))*1.00E-9;
#endif
        return dt;
    };
};
#endif // ifndefLIN32


#ifdef LIN32
#ifndef INTEL
// POWER PC
class HighResolutionClock
{
private:
    
    unsigned long long _ullStart;
    unsigned long long _ullEnd;  

public :
    
    unsigned long long getTime()
    {
        unsigned int *p;
        unsigned int sec, nano;
        unsigned long long aux;

        sec = rtime_sec();
        nano = rtime_nano();

        p = (unsigned int *) &aux;
        *p = sec;
        *(p+1) = nano;
        
        return aux;
    };

    void markStart()
    {
        _ullStart = getTime();
    };

    void markEnd()
    {
        _ullEnd = getTime();
    };
    
    double getElapsedTimeSEC()
    {
        return( (double) (_ullEnd - _ullStart) / 207000000); // timebase : 207052000
    };

    double getElapsedTimeMSEC()
    {
        return( (double) (_ullEnd - _ullStart) / 207000000); // timebase : 207052000
    };

};

#else // INTEL
// INTEL 32
class HighResolutionClock
{
private:
    
    unsigned long long _ullStart;
    unsigned long long _ullEnd;  

public :
    
    unsigned long long getTime()
    {
        volatile unsigned long long temp;
        __asm__ __volatile__("mov %0=ar.itc" : "=r"(temp) :: "memory");
        return temp;
    };

    void markStart()
    {
        _ullStart = getTime();
    };

    void markEnd()
    {
        _ullEnd = getTime();
    };
    
    double getElapsedTimeSEC()
    {
        return( (double) (_ullEnd - _ullStart) / (1500 * 1000000)); // CPU -> MHZ : 1500
    };

    double getElapsedTimeMSEC()
    {
        return( (double) (_ullEnd - _ullStart) / (1500 * 1000000)); // CPU -> MHZ : 1500
    };

};

#endif //INTEL
#endif //LIN32


#endif //HR_TIME_CLOCK_H



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

