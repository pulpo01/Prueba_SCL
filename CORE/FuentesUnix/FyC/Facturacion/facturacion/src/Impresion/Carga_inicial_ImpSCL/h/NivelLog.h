#ident "@(#)$RCSfile: NivelLog.h,v $ $Revision: 1.4 $ $Date: 2004/03/24 19:50:56 $"
#ifndef _NIVEL_LOG_
#define _NIVEL_LOG_

#include <iostream>
#include <string>
#include <sstream>

class NivelLog{

    static int actuallevel;
    static bool yaactual;
    int level;
 public:
    NivelLog(int n);
    friend std::ostream& operator<<(std::ostream& os, const NivelLog& n);

    static void SetNivelLog(int);
        
 private :    
    static bool NivelLog::ObtieneActual();
    static int ObtieneNivelLog();
    static void NivelLog::SetActual(bool);
    
};

// Funcion para enviar advertencias al log, siempre con el mismo formato y
// que siempre aparezca en el log, sin importar el nivel de log utilizado en el
// momento.
// ejemplo de Uso:
// cout << Warning << "Test" << endl;
inline std::ostream& Warning(std::ostream& os){
    return os << NivelLog(1) << "ADVERTENCIA: ";
}

// Funcion para enviar errores al log, siempre con el mismo formato y
// que siempre aparezca en el log, sin importar el nivel de log utilizado en el
// momento.
// ejemplo de Uso:
// cout << Error << "Test" << endl;
inline std::ostream& Error(std::ostream& os){    
    return os << NivelLog(1) << "ERROR: ";
}


#endif

