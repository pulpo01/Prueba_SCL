//
// Hugo A. Sanchez D.
//
#ifndef ConfigSpec_H
#define ConfigSpec_H

#include "ConfigSpecLine.h"
#include <vector>

using namespace std;

class ConfigSpec : public vector<ConfigSpecLine> {
public:
	vector<ConfigSpecLine>::iterator itr;
};

#endif //ConfigSpec_H

/******************************************************************************************/
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/