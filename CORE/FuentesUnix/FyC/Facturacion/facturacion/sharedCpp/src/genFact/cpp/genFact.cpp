/*
 * genFact.cpp
 *
 *  Created on: 27-ago-2008
 *      Author: rao
 */

#include "genFact.h"

STRING getEnvVar(const char* envVar)
{
    STRING envVarValue;
    char* tmpValue;


    if(envVar == NULL)
    {
        STRING1000 errorMsg;
        errorMsg << "VARIABLE DE AMBIENTE DESCONOCIDA: []." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
    }

/* rao #ifndef WIN32 */
    tmpValue = getenv( envVar ); // C4996

    if( tmpValue != NULL )
    {
        envVarValue.clear();
        envVarValue = tmpValue;
    }

/*#else
    size_t requiredSize;
    getenv_s( &requiredSize, NULL, 0, envVar);

    if(requiredSize >= 256)
    {
        STRING1000 errorMsg;
        errorMsg << "EL VALOR DE LA VARIABLE DE AMBIENTE [" << envVar
                 << "] SUPERA EL MAXIMO PERMITIDO DE 256 CARACTERES..." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "PROCESO TERMINADO CON ERROR", LOGIC_ERROR);
    }

    if(requiredSize < 1) return envVarValue;

    tmpValue = new char[requiredSize];
    memset(tmpValue, 0x00, requiredSize);

    if (!tmpValue)
    {
        printf("Failed to allocate memory!\n");
        exit(1);
    }

    // Get the value of the LIB environment variable.
    getenv_s( &requiredSize, tmpValue, requiredSize, envVar);

    if( tmpValue != NULL )
    {
        envVarValue.clear();
        envVarValue = tmpValue;
    }

    delete[] tmpValue;
#endif
*/
    return envVarValue;
}
