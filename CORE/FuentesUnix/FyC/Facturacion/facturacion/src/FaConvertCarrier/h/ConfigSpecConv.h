//
// Hugo A. Sanchez D.
//
#ifndef ConfigSpecConv_H
#define ConfigSpecConv_H

#include "ConfigSpecLineConv.h"
#include <vector>

using namespace std;

class ConfigSpecConv : public vector<ConfigSpecLineConv> {
public:
	vector<ConfigSpecLineConv>::iterator itrconv;
};

#endif //ConfigSpecConv_H

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