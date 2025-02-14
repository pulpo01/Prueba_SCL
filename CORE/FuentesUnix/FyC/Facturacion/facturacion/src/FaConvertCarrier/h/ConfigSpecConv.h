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