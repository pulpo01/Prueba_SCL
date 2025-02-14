#ifndef NO_INDENT
#ident "@(#)$RCSfile: LogBuffer.cpp,v $ $Revision: 1.1 $ $Date: 2008/07/14 15:21:20 $"
#endif

#include "LogBuffer.h"

///
/// \file LogBuffer.cpp
///



const unsigned char LogBuffer::_CMD_PRT = 'P';
const unsigned char LogBuffer::_CMD_STR = 'S';
const unsigned char LogBuffer::_CMD_NUM = 'N';

///
/// \brief Funcionalidad : Constructor con el identifier indicando cual es el caracter marcando la pertenencia a una zona de memoria fija.
/// \n                     Al recibir un mensaje empezando con el identificador se guarda solemente el puntero sobre la zona de memoria por interpretar este mensaje como ubicado en la zona fija de memoria.
///
LogBuffer::LogBuffer(char identifier)
{
	_level = 9;
	_realPrecision = 4;
	_identifier = identifier;
	_cursor = 0;
	_sizeBuff = 0;
	_maxSizeBuff = LOG_BUFFER_INIT_SIZE;

	if( (_logBuffer = new char[LOG_BUFFER_INIT_SIZE]) == NULL)
		cout << "Error Allocating memory for logBuffer [" << LOG_BUFFER_INIT_SIZE << "] bytes" << endl;
	else
		memset(_logBuffer,'\0', LOG_BUFFER_INIT_SIZE * sizeof(char));
}

LogBuffer::LogBuffer()
{
	_level = 9;
	_realPrecision = 4;
	_identifier = '@';
	_cursor = 0;
	_sizeBuff = 0;
	_maxSizeBuff = LOG_BUFFER_INIT_SIZE;

	if( (_logBuffer = new char[LOG_BUFFER_INIT_SIZE]) == NULL)
			cout << "Error Allocating memory for logBuffer [" << LOG_BUFFER_INIT_SIZE << "] bytes" << endl;
	else
		memset(_logBuffer,'\0', LOG_BUFFER_INIT_SIZE * sizeof(char));
}

LogBuffer::~LogBuffer()
{
	if(_logBuffer != NULL)
		delete [] _logBuffer;
}

void LogBuffer::clear()
{	
	_level = 9;
	_cursor = 0;
	_sizeBuff = 0;

	if(_logBuffer != NULL)
		memset(_logBuffer, '\0', _maxSizeBuff);
}

void LogBuffer::level(int level){ _level = level; }

int LogBuffer::getLevel(){ return _level; }
int LogBuffer::getRealPrecision(){ return _realPrecision; };
char LogBuffer::getIdentifier(){ return _identifier; };
int LogBuffer::getCursor(){ return _cursor; };
int LogBuffer::getSizeBuff(){ return _sizeBuff; };
int LogBuffer::getMaxSizeBuff(){ return _maxSizeBuff; };
char* LogBuffer::getBuffer(){ return _logBuffer; };

///
/// \brief Funcionalidad : Maneja el Tamano del buffer utilizado para guardar las informaciones de log.
/// \li 1.Verifica que al agregar addSize informacion de log al buffer, no se supera el tamano maximo allocado previamente para el buffer.
/// \li 2.Al superar el tamano maximo, se alloca nuevamente memoria al buffer.
///
bool LogBuffer::manageMemoryBuff(int addSize)
{
	_sizeBuff += addSize;
	char *pLogBuffer = NULL;

	if(_sizeBuff > _maxSizeBuff)
	{
		_maxSizeBuff += ( (_sizeBuff-_maxSizeBuff) > LOG_BUFFER_ADD_SIZE ? (_sizeBuff-_maxSizeBuff) : LOG_BUFFER_ADD_SIZE);
		if( (pLogBuffer = new char[_maxSizeBuff]) == NULL )
		{
#ifdef _DEBUG
			cout << "Error realloc memory for logBuffer [" << _maxSizeBuff << "] bytes..." << endl;
#endif
			return false;
		}
		else{
#ifdef _DEBUG
			cout << "realloc memory for logBuffer [" << _maxSizeBuff << "] bytes..." << endl;
#endif
                        strcpy(pLogBuffer, _logBuffer);
                        delete [] _logBuffer;
                        _logBuffer = pLogBuffer;
		}
	}
	
	return true;
}

///
/// \brief Funcionalidad : Iguala el LogBuffer de destino con el LogBuffer de origen.
/// \li 1.Verifica que el tamano del buffer de informaciones de log de destino no sea menor al tamano del buffer de informaciones de log de origen. 
/// \n    En caso contrario realloca memoria al buffer de destino para que ambos buffer tengan el mismo tamano.
/// \li 2.Iguala todos los valores de las variables del LogBuffer de destino con los valores del LogBuffer de origen, incluyendo el buffer de informaciones del log
///
LogBuffer& LogBuffer::operator=(LogBuffer& buffLog)
{
	int newMaxSizeBuff = buffLog.getMaxSizeBuff();
	
	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	if(newMaxSizeBuff != _maxSizeBuff)
	{
		_maxSizeBuff = newMaxSizeBuff;

		delete [] _logBuffer;
		if( (_logBuffer = new char[_maxSizeBuff]) == NULL)
		{
#ifdef _DEBUG
			cout << "Operator = -> Error Allocating memory for logBuffer [" << _maxSizeBuff << "] bytes" << endl;
#endif
			return *this;
		}

		memset(_logBuffer, '\0', _maxSizeBuff * sizeof(char));
		_sizeBuff = buffLog.getSizeBuff();
		memcpy(_logBuffer, buffLog.getBuffer(), _sizeBuff);

		_level = buffLog.getLevel();
		_realPrecision = buffLog.getRealPrecision();
		_identifier = buffLog.getIdentifier();
		_cursor = buffLog.getCursor();
	}
	else
	{
		memset(_logBuffer, '\0', _maxSizeBuff);
		_sizeBuff = buffLog.getSizeBuff();
		memcpy(_logBuffer, buffLog.getBuffer(), _sizeBuff);

		_level = buffLog.getLevel();
		_realPrecision = buffLog.getRealPrecision();
		_identifier = buffLog.getIdentifier();
		_cursor = buffLog.getCursor();
	}

	return *this;
}

///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino, las informaciones de log del buffer de origen.
/// \n Verifica que el tamano maximo del buffer de informaciones de log de destino pueda recibir todas las informaciones del buffer de log de origen. 
/// \n En caso contrario realloca memoria al buffer de destino pa que pueda contener ambos informaciones de log.
///
LogBuffer& LogBuffer::operator+=(LogBuffer& buffLog)
{
	char* pLogBuffer = NULL;
	int   newSizeBuff = _sizeBuff;
	
	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	newSizeBuff += buffLog.getSizeBuff();
	if(newSizeBuff > _maxSizeBuff)
	{
		_maxSizeBuff = newSizeBuff + LOG_BUFFER_ADD_SIZE;
		pLogBuffer = _logBuffer;
		_logBuffer = NULL;
		if( (_logBuffer = new char[_maxSizeBuff]) == NULL)
		{
#ifdef _DEBUG
			cout << "Operator = -> Error Allocating memory for logBuffer [" << _maxSizeBuff << "] bytes" << endl;
#endif
			return *this;
		}

		memset(_logBuffer, '\0', _maxSizeBuff * sizeof(char));
		memcpy(_logBuffer, pLogBuffer, _sizeBuff);
		memcpy(_logBuffer+_sizeBuff, buffLog.getBuffer(), buffLog.getSizeBuff());
		_sizeBuff = newSizeBuff;
		delete [] pLogBuffer;
	}
	else
	{
		memcpy(_logBuffer+_sizeBuff, buffLog.getBuffer(), buffLog.getSizeBuff());
		_sizeBuff += buffLog.getSizeBuff();
	}

	return *this;
}

///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino las informaciones contenidas dentro del puntero recibido de argumento.
/// \li 1.Verifica que el buffer de informaciones de log no sea null, lo que implica que el objeto no es valido.
/// \li 2.Verifica que la direcion pasada en argumento como informacion a agregar al buffer de log no comienze con el _identifier. 
/// \li 2.A. En caso del identifier, agrega al buffer de log un flag indicando que la informacion agregada al log es un puntero _CMD_PRT y el puntero.
/// \li 2.B. En caso contrario agrega al buffer de log un flag indicando que la informacion agregada al log es una cadena de caracteres _CMD_STR, 
/// \n       el tamano de la cadena de caracteres incluido dentro del buffer de log con un tamano de STR_SIZE y la cadena de caracteres con el fin de cadena (size+1).
/// \li 3.Verifica que la informacion a agregar no supere el tamano maximo del buffer de informaciones de log con el metodo manageMemoryBuff().
/// \li 4.Agrega la informacion nueva dentro del buffer de informaciones de log.
///
BasicLog& LogBuffer::operator<<(char* str)
{
	int		size = 0;
	int		cursor = _sizeBuff;
	char	*pChar = NULL;

	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	if( str[0] == _identifier )
	{
		if(!manageMemoryBuff( sizeof(unsigned char) + sizeof(char *) ))
			return *this;

		strncpy(_logBuffer + cursor, (const char*) &_CMD_PRT, sizeof(unsigned char));
		cursor += sizeof(unsigned char);
		memcpy((char*) (_logBuffer + cursor), (char**) &(++str), sizeof(char *));
	}
	else
	{
		size = strlen(str);
		pChar = intToChar(size);

		if(!manageMemoryBuff( sizeof(unsigned char) + STR_SIZE + size+1 ))
			return *this;

		strncpy(_logBuffer + cursor, (const char*) &_CMD_STR, sizeof(unsigned char));
		cursor += sizeof(unsigned char);
		strncpy(_logBuffer + cursor, pChar, STR_SIZE);
		cursor += STR_SIZE;
		strncpy(_logBuffer + cursor, str, size+1); // +1 to get \0 write inside _logBuffer...
	}

    return *((BasicLog*)this);
}




BasicLog& LogBuffer::operator<<(unsigned char* str)
{
    return this->operator <<(reinterpret_cast<char*>(str));
}


///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino las informaciones contenidas dentro del puntero constante recibido de argumento.
/// \li 1.Verifica que el buffer de informaciones de log no sea null, lo que implica que el objeto no es valido.
/// \li 2.Verifica que la direcion pasada en argumento como informacion a agregar al buffer de log no comienze con el _identifier. 
/// \li 2.A. En caso del identifier, agrega al buffer de log un flag indicando que la informacion agregada al log es un puntero _CMD_PRT y el puntero.
/// \li 2.B. En caso contrario agrega al buffer de log un flag indicando que la informacion agregada al log es una cadena de caracteres _CMD_STR, 
/// \n       el tamano de la cadena de caracteres incluido dentro del buffer de log con un tamano de STR_SIZE y la cadena de caracteres con el fin de cadena (size+1).
/// \li 3.Verifica que la informacion a agregar no supere el tamano maximo del buffer de informaciones de log con el metodo manageMemoryBuff().
/// \li 4.Agrega la informacion nueva dentro del buffer de informaciones de log.
///
BasicLog& LogBuffer::operator<<(const char* str)
{
	int		size = 0;
	int		cursor = _sizeBuff;
	char	*pChar = NULL;

	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	if( str[0] == _identifier )
	{
		if(!manageMemoryBuff( sizeof(unsigned char) + sizeof(char *) ))
			return *this;

		strncpy(_logBuffer + cursor, (const char*) &_CMD_PRT, sizeof(unsigned char));
		cursor += sizeof(unsigned char);
		memcpy((char*) (_logBuffer + cursor), (char**) &(++str), sizeof(char *));
	}
	else
	{
		size = strlen(str);
		pChar = intToChar(size);

		if(!manageMemoryBuff( sizeof(unsigned char) + STR_SIZE + size+1 ))
			return *this;

		strncpy(_logBuffer + cursor, (const char*) &_CMD_STR, sizeof(unsigned char));
		cursor += sizeof(unsigned char);
		strncpy(_logBuffer + cursor, pChar, STR_SIZE);
		cursor += STR_SIZE;
		strncpy(_logBuffer + cursor, str, size+1); // +1 to get \0 write inside _logBuffer...
	}

    return *((BasicLog*)this);
}

///
/// \brief Funcionalidad : No agrega al buffer de log argumentos de tipo cadena constante de caracter.
/// \n     metodo no implementado.
///
BasicLog& LogBuffer::operator<<(const char str)
{
    return *((BasicLog*)this);
}

///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino el valor del intero recibido de argumento.
/// \li 1.Verifica que el buffer de informaciones de log no sea null, lo que implica que el objeto no es valido.
/// \li 2.Converte el intero recibido en argumento a una cadena de caracter con el metodo intToChar().
/// \li 3.Converte el tamano de la cadena de caracter del intero convertido a caracter nuevamente a caracter con el metodo intToChar().
/// \li 3.Verifica que la informacion a agregar no supere el tamano maximo del buffer de informaciones de log con el metodo manageMemoryBuff().
/// \n    El tamano de informaciones a agregar corresponde al flag indicando un numero _CMD_NUM, 
/// \n    el tamano de la cadena de caracter del intero convertido a caracter 
/// \n    y el valor del intero pasado en caracter.
/// \n    La informacion de tamano de la cadena representando el intero pasado en argumento esta metida dentro del buffer con un tamano fijo de STR_SIZE, 
/// \n    se supone que el tamano de los interos no superan 10 caracteres lo que implica 2 caracteres para marcar el tamano -> 10 contiene 2 caracteres).
/// \li 4.Agrega la informacion nueva dentro del buffer de informaciones de log.
///
BasicLog& LogBuffer::operator<<(int value)
{
	int		size = 0;
	int		cursor = _sizeBuff;
	char	*pChar = NULL;
	char	*pSize = NULL;
	
	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	pChar = intToChar(value);
	size = strlen(pChar);
	pSize = intToChar(size);

	if(!manageMemoryBuff( sizeof(unsigned char) + STR_SIZE + size+1 ))
		return *this;

	strncpy(_logBuffer + cursor, (const char*) &_CMD_NUM, sizeof(unsigned char));
	cursor += sizeof(unsigned char);
	strncpy(_logBuffer + cursor, pSize, STR_SIZE);
	cursor += STR_SIZE;
	pChar = intToChar(value); // como se comparte la variable en funcion intToChar() -> se debe recalcular...
	strncpy(_logBuffer + cursor, pChar, size+1); // +1 to get \0 write inside _logBuffer...

	return *((BasicLog*)this);
}


BasicLog& LogBuffer::operator<<(long value)
{
    int iValue;

    iValue = static_cast<int>(value);

    return ((*this) << iValue);
}


///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino el valor del double recibido de argumento.
/// \li 1.Verifica que el buffer de informaciones de log no sea null, lo que implica que el objeto no es valido.
/// \li 2.Converte el double recibido en argumento a una cadena de caracter con el metodo intToChar().
/// \li 3.Converte el tamano de la cadena de caracter del double convertido a caracter nuevamente a caracter con el metodo intToChar().
/// \li 3.Verifica que la informacion a agregar no supere el tamano maximo del buffer de informaciones de log con el metodo manageMemoryBuff().
/// \n    El tamano de informaciones a agregar corresponde al flag indicando un numero _CMD_NUM, 
/// \n    el tamano de la cadena de caracter del double convertido a caracter 
/// \n    y el valor del double pasado en caracter.
/// \n    La informacion de tamano de la cadena representando el double pasado en argumento esta metida dentro del buffer con un tamano fijo de STR_SIZE, 
/// \n    se supone que el tamano de los doubles no superan 10 caracteres con la precision que se necesita dentro del procesamiento, lo que implica 2 caracteres para marcar el tamano -> 10 contiene 2 caracteres).
/// \li 4.Agrega la informacion nueva dentro del buffer de informaciones de log.
///
BasicLog& LogBuffer::operator<<(double value)
{
	int		size = 0;
	int		cursor = _sizeBuff;
	char	*pChar = NULL;
	char	*pSize = NULL;

	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	pChar = doubleToChar(value);
	size = strlen(pChar);
	pSize = intToChar(size);

	if(!manageMemoryBuff( sizeof(unsigned char) + STR_SIZE + size+1 ))
		return *this;

	strncpy(_logBuffer + cursor, (const char*) &_CMD_NUM, sizeof(unsigned char));
	cursor += sizeof(unsigned char);
	strncpy(_logBuffer + cursor, pSize, STR_SIZE);
	cursor += STR_SIZE;
	strncpy(_logBuffer + cursor, pChar, size+1); // +1 to get \0 write inside _logBuffer...

    return *((BasicLog*)this);
}


BasicLog& LogBuffer::operator<<(const STR_REC_32& value)
{
    *this << value.c_str();
    return *((BasicLog*)this);
}


BasicLog& LogBuffer::operator<<(const STRING_REC& value)
{
    *this << value.c_str();
    return *((BasicLog*)this);
}



BasicLog& LogBuffer::operator<<(const STRING16& value)
{
    *this << value.c_str();
    return *((BasicLog*)this);
}


///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino el valor STRING recibido en argumento.
/// \li 1.Verifica que el buffer de informaciones de log no sea null, lo que implica que el objeto no es valido.
/// \li 2.Converte el tamano de la cadena de caracter del STRING a caracter con el metodo intToChar().
/// \li 3.Verifica que la informacion a agregar no supere el tamano maximo del buffer de informaciones de log con el metodo manageMemoryBuff().
/// \n    El tamano de informaciones a agregar corresponde al flag indicando una cadena de caracter _CMD_STR, 
/// \n    el tamano de la cadena de caracter del STRING convertido a caracter 
/// \n    y el valor de la cadena de caracter del STRING+1 para tener el fin de cadena.
/// \li 4.Agrega la informacion nueva dentro del buffer de informaciones de log.
///
BasicLog& LogBuffer::operator<<(const STRING& value)
{
	int size = 0;
	int	cursor = _sizeBuff;
	char *pChar = NULL;

	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	size = value.size();
	pChar = intToChar(size);

	if(!manageMemoryBuff( sizeof(unsigned char) + STR_SIZE + size+1 ))
		return *this;

	strncpy(_logBuffer + cursor, (const char*) &_CMD_STR, sizeof(unsigned char));
	cursor += sizeof(unsigned char);
	strncpy(_logBuffer + cursor, pChar, STR_SIZE);
	cursor += STR_SIZE;
	strncpy(_logBuffer + cursor, value.c_str(), size+1); // +1 to get \0 write inside _logBuffer...
	
	return *((BasicLog*)this);
}

///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino el valor STRING1000 recibido en argumento.
/// \li 1.Verifica que el buffer de informaciones de log no sea null, lo que implica que el objeto no es valido.
/// \li 2.Converte el tamano de la cadena de caracter del STRING1000 a caracter con el metodo intToChar().
/// \li 3.Verifica que la informacion a agregar no supere el tamano maximo del buffer de informaciones de log con el metodo manageMemoryBuff().
/// \n    El tamano de informaciones a agregar corresponde al flag indicando una cadena de caracter _CMD_STR, 
/// \n    el tamano de la cadena de caracter del STRING1000 convertido a caracter 
/// \n    y el valor de la cadena de caracter del STRING1000+1 para tener el fin de cadena.
/// \li 4.Agrega la informacion nueva dentro del buffer de informaciones de log.
///
BasicLog& LogBuffer::operator<<(const STRING1000& value)
{
	int size = 0;
	int	cursor = _sizeBuff;
	char *pChar = NULL;

	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	size = value.size();
	pChar = intToChar(size);

	if(!manageMemoryBuff( sizeof(unsigned char) + STR_SIZE + size+1 ))
		return *this;

	strncpy(_logBuffer + cursor, (const char*) &_CMD_STR, sizeof(unsigned char));
	cursor += sizeof(unsigned char);
	strncpy(_logBuffer + cursor, pChar, STR_SIZE);
	cursor += STR_SIZE;
	strncpy(_logBuffer + cursor, value.c_str(), size+1); // +1 to get \0 write inside _logBuffer...
	
	return *((BasicLog*)this);
}
  
///
/// \brief Funcionalidad : Agrega al buffer de informaciones de log de destino el valor STRING3000 recibido en argumento.
/// \li 1.Verifica que el buffer de informaciones de log no sea null, lo que implica que el objeto no es valido.
/// \li 2.Converte el tamano de la cadena de caracter del STRING3000 a caracter con el metodo intToChar().
/// \li 3.Verifica que la informacion a agregar no supere el tamano maximo del buffer de informaciones de log con el metodo manageMemoryBuff().
/// \n    El tamano de informaciones a agregar corresponde al flag indicando una cadena de caracter _CMD_STR, 
/// \n    el tamano de la cadena de caracter del STRING3000 convertido a caracter 
/// \n    y el valor de la cadena de caracter del STRING3000+1 para tener el fin de cadena.
/// \li 4.Agrega la informacion nueva dentro del buffer de informaciones de log.
///
BasicLog& LogBuffer::operator<<(const STRING3000& value)
{
	int size = 0;
	int	cursor = _sizeBuff;
	char *pChar = NULL;

	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return *this;

	size = value.size();
	pChar = intToChar(size);

	if(!manageMemoryBuff( sizeof(unsigned char) + STR_SIZE + size+1 ))
		return *this;

	strncpy(_logBuffer + cursor, (const char*) &_CMD_STR, sizeof(unsigned char));
	cursor += sizeof(unsigned char);
	strncpy(_logBuffer + cursor, pChar, STR_SIZE);
	cursor += STR_SIZE;
	strncpy(_logBuffer + cursor, value.c_str(), size+1); // +1 to get \0 write inside _logBuffer...
	
	return *((BasicLog*)this);
}

///
/// \brief Funcionalidad : Convierte un double a cadena de caracter.
///
char* LogBuffer::doubleToChar(double realToConv)
{
	long long	integralInt = 0;
	double	integralDouble = 0.0;
	double	decimalDouble = 0.0;
    _doubleToChar = "";
	
	decimalDouble = modf(realToConv, &integralDouble);
	integralInt = static_cast<long long>(integralDouble);
	
	// Put into string integer value of double
	_doubleToChar << integralInt;
	_doubleToChar << ".";

	// Put into string double value of double
	for(int i = 0; i < _realPrecision; i++)
	{
		decimalDouble *= 10;
		decimalDouble = modf(decimalDouble, &integralDouble);
		integralInt = static_cast<long long>(integralDouble);
		_doubleToChar << integralInt;
	}

	return _doubleToChar.c_str();
}

///
/// \brief Funcionalidad : Convierte un int a cadena de caracter.
///
char* LogBuffer::intToChar(int numToConv)
{
	int		dix = 1, cant = 1, ind = 0;
	int		numTmp = abs(numToConv);
	bool	bNegativo = false;

	memset(_intToChar, '\0', NUM_BUFFER);

	if(numTmp != numToConv)
	{
		bNegativo = true;
		numToConv = numTmp;
	}

	while(1)
	{
		numTmp /= 10;
		if( numTmp >= 1)
		{
			cant++;
			dix*=10;
		}
		else
			break;
	}

	if(cant > NUM_BUFFER-1)
	{
#ifdef _DEBUG
		cout << "Converting number to long (max size = 10)..." << endl;
#endif
		return NULL;
	}

	if(bNegativo)
	{
		_intToChar[ind++] = '-';
		if(cant > 1) 
			cant++;
	}

	_intToChar[ind++] = numToConv / dix + '0';
	for(; ind < cant-1; ind++, dix /= 10)
		_intToChar[ind] = numToConv % dix / (dix/10) + '0';

	if(cant > 1)
		_intToChar[ind++] = numToConv % 10 + '0';
	
	_intToChar[ind] = '\0';

	return _intToChar;
};

///
/// \brief Funcionalidad : Envia el contenido del buffer de informaciones de log a la session.
///
void LogBuffer::coutLog()
{
  	char*	pchar;

    while( (pchar = backLog()) != NULL )
		cout << pchar;

	_cursor = 0;
}

///
/// \brief Funcionalidad : Indica si el level pasado en argumento no supera el level del LogBuffer.
/// \n     Permite identificar las informaciones que se pueden integrar al buffer de log segun el level asociado a esas informaciones.
///
bool LogBuffer::operator[](const int n)
{
	if(n <= _level && n >= 0)
		return true;
	else
		return false;
}

///
/// \brief Funcionalidad : Devuelve toda la informacion contenida dentro del buffer del LogBuffer. Esa operacion se puede hacer solo una vez 
///                        y despues del metodo se necesita limpiar todas las variables con el metodo clear() para poder reutilizar el LogBuffer.
/// \li 1.Recupera el flag indicando el tipo de informacion contenida en el log.
/// \li 2.Segun el tipo de informacion devuelve el puntero del buffer que contiene la informacion anteriormente guardada.
/// \n Se usa la variable _cursor para recorrer el buffer.
///
char* LogBuffer::backLog()
{
	unsigned char	CMD;
	char			charSize[STR_SIZE];

	int				size = 0;
	char			*pLog = NULL;

	// Fatal error -> LogBuffer invalid
	if(_logBuffer == NULL)
		return NULL;

	CMD = _logBuffer[_cursor++];
	switch(CMD)
	{
		case _CMD_PRT :

			memcpy((char **) &pLog, (char*) (_logBuffer + _cursor), sizeof(char *));
		    _cursor += sizeof(char*);
			break;
		case _CMD_STR :
		case _CMD_NUM :
		
			memset(charSize,'\0',STR_SIZE);
			strncpy(charSize,_logBuffer+_cursor,STR_SIZE);
			size = atoi(charSize);
	
			_cursor += STR_SIZE;
			pLog = _logBuffer+_cursor;
			_cursor += size+1; // +1 to get '\0' ...
			break;
		default :
			break;
	}

	return pLog;
}


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
