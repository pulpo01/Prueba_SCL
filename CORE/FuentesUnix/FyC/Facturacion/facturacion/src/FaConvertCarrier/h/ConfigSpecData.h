//
// Hugo A. Sanchez D.
//
#ifndef ConfigSpecData_H
#define ConfigSpecData_H

#include "ConfigSpecLineData.h"
#include <vector>

using namespace std;

class ConfigSpecData : public vector<ConfigSpecLineData> {
public:
	vector<ConfigSpecLineData>::iterator itr;
};

#endif //ConfigSpecData_H

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