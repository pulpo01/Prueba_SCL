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
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisión                                            : */
/**  %PR% */
/** Autor de la Revisión                                : */
/**  %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creación de la Revisión                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/