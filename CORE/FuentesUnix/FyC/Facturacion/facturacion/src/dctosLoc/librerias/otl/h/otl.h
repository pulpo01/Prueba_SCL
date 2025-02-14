#ifndef NO_INDENT
#ident "@(#)$RCSfile: otl.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

///
/// \file otl.h
///


#ifndef WIN32
#include <sys/time.h>
#else
#include <windows.h>
#endif

#ifndef OTL_INCLUDE_FILE_FOR_VOO_H
#define OTL_INCLUDE_FILE_FOR_VOO_H

static char const otl_h_version[]="@(#)$RCSfile: otl.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $";

///
/// \file otl.h
///

//#define OTL_ORA8I    // Compile OTL 4.0/OCI8
#define OTL_ORA10G 
//#define OTL_ORA9I 
#define OTL_STL      // Turn on STL features
#define OTL_ANSI_CPP // Turn on ANSI C++ typecasts
#define OTL_ADD_NULL_TERMINATOR_TO_STRING_SIZE
#define OTL_DEFAULT_STRING_NULL_TO_VAL ""
#include "otlv4.h"   // include the OTL 4.0 header file

class myotl
{
	public:
    static void MyVersion()
    {
        std::cout << "VERSION otl.h :" << otl_h_version << std::endl;
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


