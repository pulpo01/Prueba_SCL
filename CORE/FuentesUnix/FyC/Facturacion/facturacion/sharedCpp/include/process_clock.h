#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_clock.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 15:23:18 $"
#endif

///
/// \file process_clock.h
///



#ifndef PROCESS_CLOCK_H
#define PROCESS_CLOCK_H

#include <time.h>
#include <string>

using namespace std;

class ProcessClock
{
private:
    void fecha_sistema(char *Fecha, int Forma)
    {
       time_t now;
       struct tm * tm_time;
       now     = time(NULL);
       tm_time = localtime(&now);
       if (Forma==1)
       {
           sprintf(Fecha, "%04d%02d%02d%02d%02d%02d", 
               tm_time->tm_year + 1900, tm_time->tm_mon + 1 ,tm_time->tm_mday, 
                tm_time->tm_hour, tm_time->tm_min, tm_time->tm_sec);
       }
       else
        {   
           sprintf(Fecha, "%02d:%02d:%02d %02d/%02d/%04d", 
               tm_time->tm_hour, tm_time->tm_min, tm_time->tm_sec,
               tm_time->tm_mday, tm_time->tm_mon + 1 , tm_time->tm_year + 1900);
        }
    }

public:
    string sysDateyyyymmddhh24miss()
    {
        string returnDate;

        char tmpBuffer[20];
        memset(tmpBuffer, 0x00, sizeof(tmpBuffer));

        fecha_sistema(tmpBuffer, 1);

        returnDate = tmpBuffer;

        return returnDate;
    }


};


#endif



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


