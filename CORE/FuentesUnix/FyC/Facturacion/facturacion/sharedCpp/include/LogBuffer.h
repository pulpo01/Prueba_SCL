#ifndef NO_INDENT
#ident "@(#)$RCSfile: LogBuffer.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 15:21:29 $"
#endif

#ifndef LOG_BUFFER_H
#define LOG_BUFFER_H

///
/// \file LogBuffer.h
///


#include "myString.h"

using namespace std;

//\ Tamano initial del buffer de log.
#define LOG_BUFFER_INIT_SIZE  90000
//\ Tamano que se agrega al buffer de log cada vez que se supera el tamano previamente reservado para el log.
#define LOG_BUFFER_ADD_SIZE	   5000
//\ Tamano para guardar una informacion numerica dentro del buffer de log.
#define STR_SIZE 5


///
/// \brief BasicLog es un contenedor basico de informaciones.
/// \n     BasicLog no puede contener informaciones y solo define los metodos basicos que implementan los objetos heredados, tal como el LogBuffer.
///
class BasicLog
{
public:
     virtual BasicLog& operator<<(char* str){return *this;};
     virtual BasicLog& operator<<(unsigned char* str){return *this;};
     virtual BasicLog& operator<<(const char* str){return *this;};
     virtual BasicLog& operator<<(const char str){return *this;};
     virtual BasicLog& operator<<(int value){return *this;};
     virtual BasicLog& operator<<(long value){return *this;};
     virtual BasicLog& operator<<(double value){return *this;};

     // 2.7 format record
     virtual BasicLog& operator<<(const STRING_REC& value){return *this;};
     virtual BasicLog& operator<<(const STRING16& value){return *this;};
     virtual BasicLog& operator<<(const STR_REC_32& value){return *this;};

     virtual BasicLog& operator<<(const STRING& value){return *this;};
     virtual BasicLog& operator<<(const STRING1000& value){return *this;};
     virtual BasicLog& operator<<(const STRING3000& value){return *this;};
     //template <int SIZE> BasicLog& operator<<(const MyString<SIZE>& value);
};

//template <int SIZE> BasicLog& BasicLog::operator<<(const MyString<SIZE>& value){return *this;};

///
/// \brief LogBuffer es un contenedor de informaciones.
/// \n      LogBuffer puede contener informaciones de tipo, caracteres, objetos STRING, interos o reales.
///
class LogBuffer : public BasicLog
{

private:
    
	char					*_logBuffer;             ///< Buffer utilizado para guardar la informacion de log.
                            //\ NUM_BUFFER -> define in "myString.h"
	char					_intToChar[NUM_BUFFER];  ///< Buffer utilizado para convertir interos a caracteres.
	char					_identifier;             ///< Caracter indicando la pertenencia a una zona de memoria fija.

	STRING					_doubleToChar;           ///< STRING utilizado para convertir double a caracteres.

	int						_level;                  ///< Nivel maximo de log que se pueda guardar dentro del buffer de log _logBuffer.
	int						_realPrecision;          ///< Cantidad de decimales utilizados para la convercion de un double a cadena de caracteres.
	int						_cursor;                 ///< Cursor utilizado para recorrer el buffer _logBuffer al momento de recuperar la informacion de log.
	int						_sizeBuff;               ///< Cantidad actual de caracteres guardados dentro del buffer de log _logBuffer.
	int						_maxSizeBuff;            ///< Cantidad maxima de caracteres que se pueden guardar dentro del buffer de log _logBuffer.

	const static unsigned char	_CMD_PRT;            ///< Flag indicando que el tipo de informacion guardada dentro del buffer de log es un puntero sobre una cadena de caracteres.
	const static unsigned char	_CMD_STR;            ///< Flag indicando que el tipo de informacion guardada dentro del buffer de log es una cadena de caracteres.
	const static unsigned char	_CMD_NUM;            ///< Flag indicando que el tipo de informacion guardada dentro del buffer de log es una cadena de caracteres representando un numero (intero o double).

	bool manageMemoryBuff(int addSize);
	char* intToChar(int numToConv);
	char* doubleToChar(double realToConv);
	char* getBuffer();

public:

    LogBuffer(char identifier);
	LogBuffer();
    ~LogBuffer();

    void clear();
	void coutLog();
	void level(int level);
	
    int  getLevel();
	int getRealPrecision();
	char getIdentifier();
	int getCursor();
	int getSizeBuff();
	int getMaxSizeBuff();

    bool operator[](const int n);

    BasicLog& operator<<(char* str);
    BasicLog& operator<<(unsigned char* str);
    BasicLog& operator<<(const char* str);
    BasicLog& operator<<(const char str);
    BasicLog& operator<<(int value);
    BasicLog& operator<<(long value);
    BasicLog& operator<<(double value);

    //template <int SIZE> BasicLog& operator<<(const MyString<SIZE>& value);
    BasicLog& operator<<(const STRING_REC& value);
    BasicLog& operator<<(const STRING16& value);
    BasicLog& operator<<(const STR_REC_32& value);

    BasicLog& operator<<(const STRING& value);
    BasicLog& operator<<(const STRING1000& value);
    BasicLog& operator<<(const STRING3000& value);

    LogBuffer& operator=(LogBuffer& buffLog);
    LogBuffer& operator+=(LogBuffer& buffLog);
    char* backLog();

};


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
/*
template <int SIZE>
BasicLog& LogBuffer::operator<<(const MyString<SIZE>& value)
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
*/
#endif // LogBuffer


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
/** Autor de la Revisión                                : */
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


