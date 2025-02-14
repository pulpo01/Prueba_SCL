#ifndef NO_INDENT
#ident "@(#)$RCSfile: process_core_exception.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

#ifndef PROCESS_CORE_EXCEPTION_H
#define PROCESS_CORE_EXCEPTION_H

///
/// \file process_core_exception.h
///


#include <iostream>
#include <string>
#include <sstream>
#include <exception>

#include "myString.h"

#define LOGIC_ERROR 1
#define DATA_ERROR 2
#define PROGRAM_ERROR 3
#define OTL_SQL_ERROR 4
#define OTL_SQL_FATAL_ERROR 5
#define PROGRAM_FATAL_ERROR 6


class ProcessCoreException : public std::exception
{
private:

    STRING3000      _msg;
    int                _errorCase;
    STRING            _errorNum;

public:

    ProcessCoreException() throw() {};
    ProcessCoreException(const char* msg) throw() {_msg = msg;};
    ProcessCoreException(const std::string &msg) throw() {_msg = msg.c_str();};

    ProcessCoreException(const std::ostringstream &msg, const std::string &errNum, const int &errCase, const std::string &ticketNum) throw()
    {
         _msg = (msg.str()).c_str();
        _errorNum = errNum.c_str();
        _errorCase = errCase;
    };

    ProcessCoreException(const std::ostringstream &msg, char *errNum, const int &errCase, char *ticketNum) throw()
    {
        _msg = (msg.str()).c_str();
        _errorNum = errNum;
        _errorCase = errCase;
    };

    ProcessCoreException(char *msg, char *errNum, const int &errCase, char *ticketNum) throw()
    {
        _msg = msg;
        _errorNum = errNum;
        _errorCase = errCase;
    };

    ProcessCoreException(char *msg, char *errNum, const int &errCase) throw()
    {
        _msg = msg;
        _errorNum = errNum;
        _errorCase = errCase;
    };

    template<int SIZE> ProcessCoreException(MyString<SIZE>& msg, const char *errNum, const int &errCase, const char *ticketNum) throw()
    {
        _msg = msg.c_str();
        _errorNum = errNum;
        _errorCase = errCase;
    }

    template<int SIZE> ProcessCoreException(MyString<SIZE>& msg, const char *errNum, const int &errCase) throw()
    {
        _msg = msg.c_str();
        _errorNum = errNum;
        _errorCase = errCase;
    }


    ~ProcessCoreException() throw() {};

    const char* what() const throw() { return (char*) _msg.c_str();};
    const char* errNum() const throw() {return (char*) _errorNum.c_str();};
    const int errCase() const  throw() {return _errorCase;};
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


