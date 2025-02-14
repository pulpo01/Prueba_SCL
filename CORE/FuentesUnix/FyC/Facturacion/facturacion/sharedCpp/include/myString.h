#ifndef NO_INDENT
#ident "@(#)$RCSfile: myString.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 15:22:14 $"
#endif

///
/// \file myString.h
///


#ifndef MY_STRING_H
#define MY_STRING_H

#ifdef _WIN32
#pragma warning(disable:4267)
#pragma warning(disable:4244)
#pragma warning(disable:4996)
#endif // _WIN32

#include "math.h"
#include <string>
#include <iostream>

// Util for writing message
#define INDENT1 "\t"
#define INDENT2 "\t\t"
#define INDENT3 "\t\t\t"
#define INDENT4 "\t\t\t\t"
#define INDENT5 "\t\t\t\t\t"
#define ENDL "\n";

#define _DEFAULT_PRECISION_FOR_REAL_VALUES 10

#define NUM_BUFFER 22
//#define SHOW_COUT
#define NEW_COUT

using namespace std;

///
/// \brief MyString es un TEMPLATE, cuyo valor indica el tamano de un buffer permitiendo manejar informacion de tipo caracteres.
///
template <int SIZE = 256> class MyString
{
private:

    char        _pBuffer[SIZE];
    char        _sizeBuffer[NUM_BUFFER]; //\ Utilizado para calculo int -> char (retorno del metodo)
    char        *_pBufferMem;

    int         _capacity;
    int         _size;
    int         _realPrecision;

    bool        _allocMade;

   	inline void constructor(char *pInputChar, int size);
	void clean();
    int         binaryMerge(char* pOutput, const char* pInput);

	void newAdd(char *pCarac, int size);
	void softAdd(char *pCarac, int size);
	inline bool compareEquality(char *pChar, int size);
	inline bool compareDiff(char *pChar, int size);
    inline bool compareEqualityConst(char *pChar, int size) const;
    inline bool compareDiffConst(char *pChar, int size) const;

public:

    MyString(string inputString);
    MyString(char *pInputCarac);
    MyString(const char *pInputCarac);
    MyString(const MyString<SIZE> &myConstString);
    MyString();

    ~MyString();

    inline int size();
    inline int length();
    inline int capacity();
    inline bool empty();
    inline char* c_str();
    inline void clear();

    inline int size() const;
    inline int length() const;
    inline int capacity() const;
    inline bool empty() const;
    inline char* c_str() const;
    inline void clear() const;

    void updateSize();

    int  find_first_of(char *pChar);
    int find(char *pChar);

    void erase(int start, int end);
    void erase(int start);

    MyString<SIZE> substr(int start, int end);
    MyString<SIZE> substr(int start, int end) const;

    int operator[](int i);

    inline bool operator>(string &str);
    inline bool operator>(const char *pCarac);
    inline bool operator>(MyString<SIZE> &myString);
    inline bool operator>(MyString<SIZE> myString) const;

    inline bool operator<(string &str);
    inline bool operator<(const char *pCarac);
    inline bool operator<(MyString<SIZE> &myString);
    inline bool operator<(MyString<SIZE> myString) const;

    template <int SIZE_FOREIGN> inline bool operator!=(const MyString<SIZE_FOREIGN> &myString) const;
    template <int SIZE_FOREIGN> inline bool operator!=(const MyString<SIZE_FOREIGN> &myString) ;
    template <int SIZE_FOREIGN> inline bool operator!=(MyString<SIZE_FOREIGN> &myString) const;
    template <int SIZE_FOREIGN> inline bool operator!=(MyString<SIZE_FOREIGN> &myString) ;

    inline bool  operator!=(MyString<SIZE> &myString) const;
    inline bool operator!=(const MyString<SIZE> &myString) const;
    inline bool operator!=(const MyString<SIZE> &myString);
    inline bool operator!=(MyString<SIZE> &myString);
    inline bool operator!=(const char *pCarac);
    inline bool operator!=(char *pCarac);
    inline bool operator!=(string &str);

    template <int SIZE_FOREIGN> inline bool operator==(const MyString<SIZE_FOREIGN> &myString) const;
    template <int SIZE_FOREIGN> inline bool operator==(const MyString<SIZE_FOREIGN> &myString) ;
    template <int SIZE_FOREIGN> inline bool operator==(MyString<SIZE_FOREIGN> &myString) const;
    template <int SIZE_FOREIGN> inline bool operator==(MyString<SIZE_FOREIGN> &myString) ;

    inline bool operator==(MyString<SIZE> &myString) const;
    inline bool operator==(const MyString<SIZE> &myString) const;
    inline bool operator==(MyString<SIZE> &myString);
    inline bool operator==(const MyString<SIZE> &myString);
    inline bool operator==(const char *pCarac);
    inline bool operator==(char *pCarac);
    inline bool operator==(string &str);

    MyString<SIZE>& operator+=(char *pCarac);
    inline MyString<SIZE>& operator+=(string &str);
    inline MyString<SIZE>& operator+=(const char *pCarac);
    inline MyString<SIZE>& operator+=(MyString<SIZE> &myString);
    inline MyString<SIZE>& operator+=(const MyString<SIZE> &myString);

    MyString<SIZE>& operator=(char *pCarac);
	inline MyString<SIZE>& operator=(const MyString<SIZE> &myString);
	template <int SIZE_FOREIGN> inline MyString<SIZE>& operator=(const MyString<SIZE_FOREIGN> &myString);
    inline MyString<SIZE>& operator=(const char *pCarac);
    inline MyString<SIZE>& operator=(string &str);

    MyString<SIZE>& operator<<(unsigned char &uChar);
    MyString<SIZE>& operator<<(double real);
	inline MyString<SIZE>& operator<<(int i);
    inline MyString<SIZE>& operator<<(long i);
    inline MyString<SIZE>& operator<<(long long i);
    inline MyString<SIZE>& operator<<(MyString<SIZE> &myString);
    inline MyString<SIZE>& operator<<(char *pChar);
    inline MyString<SIZE>& operator<<(const char *pChar);
    inline MyString<SIZE>& operator<<(unsigned char* uChar);

    MyString<SIZE>& operator|(const char* pValue);

    char* intToChar(int numToConv);

    char* longToChar(long numToConv);

    char* longlongToChar(long long numToConv);

    void add(int fieldSize, char filler, bool left, char *data);

    int setPrecision(int precision);
};

template <int SIZE> void MyString<SIZE>::add(int fieldSize, char filler, bool left, char *data)
{
    char fillerBuff[256];
    char tmpData[256];
    int fillerSize;

    /* Corregir el caso cuando strlen(data) > fieldSize */

    tmpData[0] = '\0';
    fillerSize =  fieldSize - strlen(data);

    if(fillerSize > 0)
    {
        strcpy(tmpData, data);
        memset(fillerBuff, filler, fillerSize);
        fillerBuff[fillerSize] = '\0';
    }
    else
    {
        fillerBuff[0] = '\0';
        if(left)
        {
            strncpy(tmpData, data, fieldSize);
            tmpData[fieldSize] = '\0';
        }
        else strcpy(tmpData, data+(fillerSize*(-1)));
    }

    if(left)
    {
        *this += tmpData;
        *this += fillerBuff;
    }
    else
    {
        *this += fillerBuff;
        *this += tmpData;
    }

    //int prueba = strlen(_pBufferMem);
}

template <int SIZE> inline void MyString<SIZE>::constructor(char *pInputChar, int size)
{
     if(size >= SIZE)
    {
        _allocMade = true;
	    _realPrecision = _DEFAULT_PRECISION_FOR_REAL_VALUES;
	    _size = size;
        _capacity = size+1;

        _pBufferMem = new char[_capacity];
        memset(_pBufferMem,'\0',_capacity);
        strncpy(_pBufferMem, pInputChar, _size);
    }
    else
    {
        _allocMade = false;
	    _realPrecision = _DEFAULT_PRECISION_FOR_REAL_VALUES;
	    _size = size;
        _capacity = SIZE;
        _pBufferMem = _pBuffer;

        _pBufferMem[0] = '\0';
	    if(pInputChar != NULL)
            {
		    memcpy(_pBufferMem, pInputChar, _size);
            _pBufferMem[size] = '\0';
            }
    }
}

template <int SIZE> MyString<SIZE>::MyString(string inputString)
{
	constructor((char*) inputString.c_str(), inputString.size());
}

template <int SIZE> MyString<SIZE>::MyString(char *pInputCarac)
    {
    constructor((char*) pInputCarac, strlen(pInputCarac));
    }

template <int SIZE> MyString<SIZE>::MyString(const char *pInputCarac)
    {
    constructor((char*) pInputCarac, strlen(pInputCarac));
}

template <int SIZE> MyString<SIZE>::MyString(const MyString<SIZE> &myString)
{
    constructor((char*) myString.c_str(), myString.size());
    }

template <int SIZE> MyString<SIZE>::MyString()
{
	constructor((char*) NULL, 0);
}

template <int SIZE> MyString<SIZE>::~MyString()
{
    if(_allocMade)
        delete [] _pBufferMem;
};

/////////////////////////////////////////////////////////////////////
template <int SIZE> inline int MyString<SIZE>::size(){ return _size; };
template <int SIZE> inline int MyString<SIZE>::size() const { return _size; };
template <int SIZE> inline int MyString<SIZE>::length(){ return _size; };
template <int SIZE> inline int MyString<SIZE>::length() const { return _size; };
template <int SIZE> inline int MyString<SIZE>::capacity(){ return _capacity; };
template <int SIZE> inline int MyString<SIZE>::capacity() const { return _capacity; };
template <int SIZE> inline bool MyString<SIZE>::empty() { return (_size==0); };
template <int SIZE> inline bool MyString<SIZE>::empty() const { return (_size==0); };
template <int SIZE> inline char* MyString<SIZE>::c_str(){ return _pBufferMem; };
template <int SIZE> inline char* MyString<SIZE>::c_str() const { return _pBufferMem; };

template <int SIZE> void MyString<SIZE>::clean()
{
    if(_allocMade)
	{
        delete [] _pBufferMem;
        _allocMade = false;
	}

    _capacity = SIZE;
    _size = 0;
    _pBufferMem = _pBuffer;
    _pBufferMem[0]='\0';
};

template <int SIZE> inline void MyString<SIZE>::clear(){ clean(); };
template <int SIZE> inline void MyString<SIZE>::clear() const{ clean(); };

template <int SIZE> void MyString<SIZE>::updateSize()
{
    int size = 0;

    while(size <= _capacity)
    {
        if (*(_pBufferMem+size) == '\0')
        {
            _size = size;
            break;
        }
        else
            size++;
    }
}

/////////////////////////////////////////////////////////////////////
/// \ Busca dentro del buffer del objeto la cadena completa comenzando desde el puntero pChar
/// \ Al encontrarla, devuelve el indice de comienzo de la cadena dentro del buffer del objeto.
/// \ Al no encontrar devuelve 0
/// \ OJO : este metodo no funciona como el metodo del string STL
template <int SIZE> int MyString<SIZE>::find_first_of(char *pChar)
{
    int        cursorBuffer = 0;
    int        cursorLookFor = 0;
    int        cursorResult = -1;
    int        lookForSize = strlen(pChar);

    while(cursorBuffer < _size)
    {
        if (*(_pBufferMem+cursorBuffer) == *pChar)
        {
            cursorResult = cursorBuffer;
            cursorLookFor = 0;
            while( (*(_pBufferMem+cursorBuffer) == *(pChar+cursorLookFor)) &&
				(cursorLookFor++ < lookForSize) ){ cursorBuffer++; }

            if(cursorLookFor == lookForSize)
                break;
        }
        else
            cursorBuffer++;
    }

    return cursorResult;
}

/////////////////////////////////////////////////////////////////////
/// \ Busca dentro del buffer del objeto la cadena completa comenzando desde el puntero pChar
/// \ Al encontrarla, devuelve el indice de comienzo de la cadena dentro del buffer del objeto.
/// \ Al no encontrar devuelve 0
template <int SIZE> int MyString<SIZE>::find(char *pChar)
{
    char *pResult = NULL;

    if( (pResult = strstr(_pBufferMem, pChar)) != NULL )
        return( (pResult-_pBufferMem+1) );
    else
        return 0;
}


/////////////////////////////////////////////////////////////////////
template <int SIZE> void MyString<SIZE>::erase(int start, int end)
{
    MyString<SIZE>    newMyString;
    char            *pChar;

    #ifdef SHOW_COUT
    cout << "MyString erase(int start, int end)" << endl;
    #endif

    if( (start < _size) && (end <= _size) && (start < end) )
    {
        if((start+(_size-end+1)) < SIZE)
        {
            pChar = newMyString.c_str();
            strncpy(pChar, _pBufferMem, start);
            strncat(pChar+start , _pBufferMem+end, (_size-end));
            *(pChar+start+(_size-end)+1) = '\0';
        }
        else
        {
            newMyString = _pBufferMem;
            newMyString.clear();
            pChar = newMyString.c_str();
            strncpy(pChar, _pBufferMem, start);
            strncat(pChar+start , _pBufferMem+end, (_size-end));
        }
        newMyString.updateSize();
        *this = newMyString;
    }
}

template <int SIZE> void MyString<SIZE>::erase(int start)
{
    MyString<SIZE>    newMyString;
    char            *pChar;

    #ifdef SHOW_COUT
    cout << "MyString erase(int start)" << endl;
    #endif

    if( (start <= _size) )
    {
        if((start+1) < SIZE)
        {
            pChar = newMyString.c_str();
            strncpy(pChar , _pBufferMem, start);
            *(pChar+start) = '\0';
        }
        else
        {
            newMyString = _pBufferMem;
            newMyString.clear();
            strncpy(newMyString.c_str() , _pBufferMem, start);
        }
        newMyString.updateSize();
        *this = newMyString;
    }
}

/////////////////////////////////////////////////////////////////////
template <int SIZE> MyString<SIZE> MyString<SIZE>::substr(int start, int end)
{
    MyString<SIZE>    mySubString;
	char           *pChar= NULL;

    #ifdef SHOW_COUT
    cout << "MyString substr(int start, int end)" << endl;
    #endif

    if(start >= _size) return mySubString;

    if((start+end) <= _size /*&& (start < end)*/ )
    {
        if((start+end) < SIZE)
		{
			pChar = mySubString.c_str();
            strncpy(pChar , _pBufferMem+start, end);
			pChar[end] = '\0';
		}
        else
        {
            mySubString = _pBufferMem;
            mySubString.clear();
			pChar = mySubString.c_str();
            strncpy(pChar , _pBufferMem+start, end);
			pChar[end] = '\0';
        }

        mySubString.updateSize();
    }
    else
    {
        if((start+end) < SIZE)
        {
            pChar = mySubString.c_str();
            strncpy(pChar , _pBufferMem+start, (_size-start));
            pChar[_size-start] = '\0';
            //strncpy(mySubString.c_str() , _pBufferMem+start, (_size-start));
        }
        else
        {
            mySubString = _pBufferMem;
            mySubString.clear();

            pChar = mySubString.c_str();
            strncpy(pChar , _pBufferMem+start, (_size-start));
            pChar[_size-start] = '\0';

            //strncpy(mySubString.c_str() , _pBufferMem+start, (_size-start));
        }

        mySubString.updateSize();
    }

    return mySubString;
}

template <int SIZE> MyString<SIZE> MyString<SIZE>::substr(int start, int end) const
{
    MyString<SIZE>    mySubString;
    char           *pChar= NULL;

    #ifdef SHOW_COUT
    cout << "MyString substr(int start, int end) const" << endl;
    #endif

    if(start >= _size) return mySubString;

    if((start+end) <= _size /*&& (start < end)*/ )
    {
        if((start+end) < SIZE)
		{
			pChar = mySubString.c_str();
            strncpy(pChar , _pBufferMem+start, end);
            pChar[end] = '\0';
		}
        else
        {
            mySubString = _pBufferMem;
            mySubString.clear();
			pChar = mySubString.c_str();
            strncpy(pChar , _pBufferMem+start, end);
			pChar[end] = '\0';
        }

        mySubString.updateSize();
    }
    else
    {
        if((start+end) < SIZE)
            strncpy(mySubString.c_str() , _pBufferMem+start, (_size-start));
        else
        {
            mySubString = _pBufferMem;
            mySubString.clear();
            strncpy(mySubString.c_str() , _pBufferMem+start, (_size-start));
        }

        mySubString.updateSize();
    }

    return mySubString;
}

/////////////////////////////////////////////////////////////////////
template <int SIZE> int MyString<SIZE>::operator[](int i)
{
    #ifdef SHOW_COUT
    cout << "operator[]" << endl;
    #endif

    return *(_pBufferMem+i);
}









/////////////////////////////////////////////////////////////////////
template <int SIZE> inline bool MyString<SIZE>::operator>(string &str)
{
    return (strcmp(str.c_str(), _pBufferMem) < 0 ? true : false);
};

template <int SIZE> inline bool MyString<SIZE>::operator>(const char *pCarac)
{
    return (strcmp(pCarac, _pBufferMem) < 0 ? true : false);
};

template <int SIZE> inline bool MyString<SIZE>::operator>(MyString<SIZE> &myString)
{
    return (strcmp(myString.c_str(), _pBufferMem) < 0 ? true : false);
};

template <int SIZE> inline bool MyString<SIZE>::operator>(MyString<SIZE> myString) const
{
    return (strcmp(myString.c_str(), _pBufferMem) < 0 ? true : false);
};








/////////////////////////////////////////////////////////////////////
template <int SIZE> inline bool MyString<SIZE>::operator<(string &str)
{
    return (strcmp(str.c_str(), _pBufferMem) > 0 ? true : false);
};

template <int SIZE> inline bool MyString<SIZE>::operator<(const char *pCarac)
{
      return (strcmp(pCarac, _pBufferMem) > 0 ? true : false);
};

template <int SIZE> inline bool MyString<SIZE>::operator<(MyString<SIZE> &myString)
{
     return (strcmp(myString.c_str(), _pBufferMem) > 0 ? true : false);
};

template <int SIZE> inline bool MyString<SIZE>::operator<(MyString<SIZE> myString) const
{
     return (strcmp(myString.c_str(), _pBufferMem) > 0 ? true : false);
};








/////////////////////////////////////////////////////////////////////
template <int SIZE> inline bool MyString<SIZE>::compareDiff(char *pChar, int size)
{
    bool bReturn = true;

    if(size == _size)
        bReturn = (strcmp(pChar, _pBufferMem) == 0 ? false : true);

    return bReturn;
};

template <int SIZE> inline bool MyString<SIZE>::compareDiffConst(char *pChar, int size) const
{
    bool bReturn = true;

    if(size == _size)
        bReturn = (strcmp(pChar, _pBufferMem) == 0 ? false : true);

    return bReturn;
};

template <int SIZE> inline bool MyString<SIZE>::operator!=(string &str)
{
    return compareDiff(str.c_str(), str.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator!=(char *pCarac)
{
    return compareDiff(pCarac, (int) strlen(pCarac));
};

template <int SIZE> inline bool MyString<SIZE>::operator!=(const char *pCarac)
{
    return compareDiff((char*) pCarac, (int) strlen(pCarac));
};

template <int SIZE> inline bool MyString<SIZE>::operator!=(MyString<SIZE> &myString)
{
    return compareDiff(myString.c_str(), myString.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator!=(const MyString<SIZE> &myString)
{
    return compareDiff(myString.c_str(), myString.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator!=(const MyString<SIZE> &myString) const
{
    return compareDiffConst(myString.c_str(), myString.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator!=(MyString<SIZE> &myString) const
{
	return compareDiffConst(myString.c_str(), myString.size());
};

template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator!=(MyString<SIZE_FOREIGN> &myString)
{
    return compareDiffConst(myString.c_str(), myString.size());
};

template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator!=(const MyString<SIZE_FOREIGN> &myString)
{
    return compareDiffConst(myString.c_str(), myString.size());
};

template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator!=(MyString<SIZE_FOREIGN> &myString) const
{
    return compareDiffConst(myString.c_str(), myString.size());
};

template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator!=(const MyString<SIZE_FOREIGN> &myString) const
{
    return compareDiffConst(myString.c_str(), myString.size());
};




/////////////////////////////////////////////////////////////////////
template <int SIZE> inline bool MyString<SIZE>::compareEquality(char *pChar, int size)
{
	bool bReturn;

    if(size != _size)
        bReturn = false;
    else
        bReturn = (strcmp(pChar, _pBufferMem) == 0 ? true : false);

    return bReturn;
};

template <int SIZE> inline bool MyString<SIZE>::compareEqualityConst(char *pChar, int size) const
{
	bool bReturn;

    if(size != _size)
        bReturn = false;
    else
        bReturn = (strcmp(pChar, _pBufferMem) == 0 ? true : false);

    return bReturn;
};

template <int SIZE> inline bool MyString<SIZE>::operator==(string &str)
{
	return compareEquality(str.c_str(), str.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator==(char *pCarac)
{
    return compareEquality(pCarac, (int) strlen(pCarac));
};

template <int SIZE> inline bool MyString<SIZE>::operator==(const char *pCarac)
{
	return compareEquality((char*) pCarac, (int) strlen(pCarac));
};

template <int SIZE> inline bool MyString<SIZE>::operator==(MyString<SIZE> &myString)
{
	return compareEquality(myString.c_str(), myString.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator==(const MyString<SIZE> &myString)
{
    return compareEquality((char*) myString.c_str(), myString.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator==(const MyString<SIZE> &myString) const
{
	return compareEqualityConst((char*) myString.c_str(), myString.size());
};

template <int SIZE> inline bool MyString<SIZE>::operator==(MyString<SIZE> &myString) const
{
   	return compareEqualityConst(myString.c_str(), myString.size());
};


template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator==(MyString<SIZE_FOREIGN> &myString)
{
    return compareEquality(myString.c_str(), myString.size());
};

template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator==(const MyString<SIZE_FOREIGN> &myString)
{
    return compareEquality(myString.c_str(), myString.size());
};

template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator==(MyString<SIZE_FOREIGN> &myString) const
{
    return compareEquality(myString.c_str(), myString.size());
};

template <int SIZE >
template <int SIZE_FOREIGN> inline bool MyString<SIZE>::operator==(const MyString<SIZE_FOREIGN> &myString) const
{
    return compareEquality(myString.c_str(), myString.size());
};





/////////////////////////////////////////////////////////////////////
template <int SIZE> MyString<SIZE>& MyString<SIZE>::operator+=(char *pCarac)
{
    char            *pMyChar = NULL;
    int                size = strlen(pCarac);

    if(size > ((_capacity-1) - _size))
    {
        _capacity = _size + size + 1;
        pMyChar = _pBufferMem;
        _pBufferMem = new char[_capacity];
        memset(_pBufferMem,'\0', _capacity);
        strncpy(_pBufferMem, pMyChar, _size);
        strncpy(_pBufferMem+_size, pCarac, size);
        _size += size;

        if(_allocMade)
            delete [] pMyChar;

        _allocMade = true;
    }
    else
    {
        strncpy(_pBufferMem+_size, pCarac, size);
        _pBufferMem[_size+size]='\0';
        _size += size;
    }

    return *this;
}

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator+=(const MyString<SIZE> &myString)
{
    (*this) += (char*) myString.c_str();
    return *this;
}

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator+=(MyString<SIZE> &myString)
    {
	(*this) += (char*) myString.c_str();
    return *this;
    }

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator+=(const char *pCarac)
    {
   (*this) += (char*) pCarac;
   return *this;
    }

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator+=(string &str)
{
   (*this) += (char*) str.c_str();
    return *this;
}









/////////////////////////////////////////////////////////////////////
template <int SIZE> MyString<SIZE>& MyString<SIZE>::operator=(char *pCarac)
{
    int size = strlen(pCarac);

    if(size >= _capacity)
    {
	    _size = size;
	    _capacity = _size+1;
	    if(_allocMade)
            delete _pBufferMem;

        _allocMade = true;
        _pBufferMem = new char[_capacity];
        memset(_pBufferMem, '\0', _capacity);
        strncpy(_pBufferMem, pCarac, _size);
    }
    else
    {
	    _size = size;
        memcpy(_pBufferMem, pCarac, _size);
        _pBufferMem[_size] = '\0';
    }

    return *this;
};

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator=(string &str)
{
    (*this) = (char*) str.c_str();
    return *this;
};

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator=(const char *pCarac)
{
    (*this) = (char*) pCarac;
    return *this;
};

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator=(const MyString<SIZE> &myString)
{
    (*this) = (char*) myString.c_str();
    return *this;
};

template <int SIZE >
template <int SIZE_FOREIGN> inline MyString<SIZE>& MyString<SIZE>::operator=(const MyString<SIZE_FOREIGN> &myString)
{
    (*this) = (char*) myString.c_str();
    return *this;
};







//////////////////////////////////////////////////////////////////////////////////
template <int SIZE> MyString<SIZE>& MyString<SIZE>::operator<<(unsigned char &uChar)
    {
	char *pMyChar = NULL;
	char *pCarac = (char*) &uChar;
    int  size = 1;

    if(size > ((_capacity-1) - _size))
    {
        _capacity = _size + size + 1;
        pMyChar = _pBufferMem;
        _pBufferMem = new char[_capacity];
        memset(_pBufferMem,'\0', _capacity);
        strncpy(_pBufferMem, pMyChar, _size);
        strncpy(_pBufferMem+_size, pCarac, size);
        _size += size;

        if(_allocMade)
            delete [] pMyChar;

        _allocMade = true;
    }
    else
    {
        strncpy(_pBufferMem+_size, pCarac, size);
        _pBufferMem[_size+size]='\0';
        _size += size;
    }

    return *this;
};

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator<<(MyString<SIZE> &myString)
{
    *this += (char*) myString.c_str();
    return *this;
};

template <int SIZE> inline  MyString<SIZE>& MyString<SIZE>::operator<<(char *pChar)
    {
    *this += (char*) pChar;
    return *this;
};

template <int SIZE> inline  MyString<SIZE>& MyString<SIZE>::operator<<(const char *pChar)
    {
    *this += (char*) pChar;
    return *this;
};

template <int SIZE> inline MyString<SIZE>& MyString<SIZE>::operator<<(unsigned char* uChar)
    {
    *this += (char*) uChar;
    return *this;
};

template <int SIZE> inline  MyString<SIZE>& MyString<SIZE>::operator<<(int i)
{
	*this += (char*) intToChar(i);
    return *this;
};



template <int SIZE> inline  MyString<SIZE>& MyString<SIZE>::operator<<(long i)
{
	*this += (char*) longToChar(i);
    return *this;
};


template <int SIZE> inline  MyString<SIZE>& MyString<SIZE>::operator<<(long long i)
{
	*this += (char*) longlongToChar(i);
    return *this;
};







template <int SIZE> MyString<SIZE>& MyString<SIZE>::operator<<(double real)
{

//#ifdef WIN32
//    char tmpBuffer[50];
//
//    memset(tmpBuffer, 0x00, sizeof(tmpBuffer));
//
//    sprintf(tmpBuffer, "%.4f", real);
//
//    *this << tmpBuffer;
//
//    return *this;
//
//#endif

    long long      integralInt = 0;
    double    integralDouble = 0.0;
    double    decimalDouble = 0.0;

    decimalDouble = modf(real, &integralDouble);
    integralInt = static_cast<long long>(integralDouble);

    // put into string integer value of double
    *this << integralInt;
    *this << ".";

    // put into string double value of double
    for(int i = 0; i < _realPrecision; i++)
    {
        decimalDouble *= 10;
        decimalDouble = modf(decimalDouble, &integralDouble);
        integralInt = static_cast<long long>(integralDouble);
        *this << integralInt;
    }

    return *this;
};

template <int SIZE> MyString<SIZE>& MyString<SIZE>::operator|(const char* pValue)
{
    char            *pMyChar = NULL;
    int                size = strlen(pValue);

    #ifdef SHOW_COUT
    cout << "operator&&(const char* value)" << endl;
    #endif

    if(size > ((_capacity-1) - _size))
    {
        #ifdef NEW_COUT
		cout << "New operator&&(const char* value)" << endl;
        #endif

        pMyChar = _pBufferMem;
        _capacity = size + _size + 1;
        _pBufferMem = new char[_capacity];
        memset(_pBufferMem,'\0', _capacity);
        strncpy(_pBufferMem, pMyChar, _size);
        _size = binaryMerge(_pBufferMem,pValue);

        if(_allocMade)
            delete[] pMyChar;

        _allocMade = true;
    }
    else
        _size = binaryMerge(_pBufferMem,pValue);

    return *this;
}

template <int SIZE> int MyString<SIZE>::binaryMerge(char* pOutput, const char* pInput)
{
    int sizeA = strlen(pOutput);
    int sizeB = strlen(pInput);
    int sizeMin = (sizeA <= sizeB) ? sizeA : sizeB;
    int sizeMax = (sizeA <= sizeB) ? sizeB : sizeA;

    for(int i = 0; i < sizeMin; i++)
        pOutput[i] = (pOutput[i] | pInput[i]);

    for(int j = sizeMin; j < sizeB; j++)
        pOutput[j] = pInput[j];

    return sizeMax;
}

template <int SIZE> char* MyString<SIZE>::intToChar(int numToConv)
{
    int        dix = 1, cant = 1, ind = 0;
    int        numTmp = abs(numToConv);
    bool    bNegativo = false;

    memset(_sizeBuffer, '\0', sizeof(_sizeBuffer));

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

    if(cant > 10)
    {
#ifdef _DEBUG
        cout << "Converting number to long (max size = 10)..." << endl;
#endif
        return _sizeBuffer;
    }

    if(bNegativo)
    {
        _sizeBuffer[ind++] = '-';
        if(cant > 1)
            cant++;
    }

    _sizeBuffer[ind++] = numToConv / dix + '0';
    for(; ind < cant-1; ind++, dix /= 10)
        _sizeBuffer[ind] = numToConv % dix / (dix/10) + '0';

    if(cant > 1)
        _sizeBuffer[ind++] = numToConv % 10 + '0';

    _sizeBuffer[ind] = '\0';

    return _sizeBuffer;
};


template <int SIZE> char* MyString<SIZE>::longToChar(long numToConv)
{
    long long tmpValue;

    tmpValue = static_cast<long long>(numToConv);

    return longlongToChar(numToConv);
};



template <int SIZE> char* MyString<SIZE>::longlongToChar(long long numToConv)
{
    long long        dix = 1, cant = 1, ind = 0;
    long long        numTmp; // = abs(numToConv);
    bool    bNegativo = false;

    if(numToConv < 0)
    {
        numTmp = numToConv * -1;
    }
    else
    {
        numTmp = numToConv;
    }

    memset(_sizeBuffer, '\0', sizeof(_sizeBuffer));

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

    if(cant >= NUM_BUFFER)
    {
#ifdef _DEBUG
        cout << "Converting number to long (max size = 20)..." << endl;
#endif
        return _sizeBuffer;
    }

    if(bNegativo)
    {
        _sizeBuffer[ind++] = '-';
        if(cant > 1)
            cant++;
    }

    _sizeBuffer[ind++] = numToConv / dix + '0';
    for(; ind < cant-1; ind++, dix /= 10)
        _sizeBuffer[ind] = numToConv % dix / (dix/10) + '0';

    if(cant > 1)
        _sizeBuffer[ind++] = numToConv % 10 + '0';

    _sizeBuffer[ind] = '\0';

    return _sizeBuffer;
}






template <int SIZE> int MyString<SIZE>::setPrecision(int precision)
{
    if(precision <= 0 || precision > 10) return _realPrecision;

    _realPrecision = precision;
    return precision;
}








/// global methods to ensure compatibility with different kinds of MyString objects.

//#ifndef WIN32
template<int SIZE_A, int SIZE_B> inline MyString<SIZE_A>& operator<<(MyString<SIZE_A>& A, const MyString<SIZE_B>& B)
{
    A << B.c_str();
    return A;
};
//#endif

// global method to ensure compatibility whith ostream

template<int SIZE> inline  std::ostream& operator<<(std::ostream& os, MyString<SIZE> &myString)
{
    os << myString.c_str();
    return os;
}

template<int SIZE> inline  std::ostream& operator<<(std::ostream& os, const MyString<SIZE> &myString)
{
    os << myString.c_str();
    return os;
}


#ifdef __OTL_H__


template<int SIZE> inline  otl_stream& operator<<(otl_stream& os, const MyString<SIZE> &myString)
{
    os << myString.c_str();
    return os;
}

template<int SIZE> inline  otl_stream& operator<<(otl_stream& os, MyString<SIZE> &myString)
{
    os << myString.c_str();
    return os;
}

template<int SIZE> otl_stream& operator>>(otl_stream& os, const MyString<SIZE> &myString)
{
    char tmpBuffer[5000];
    memset(tmpBuffer, 0x00, sizeof(tmpBuffer));

    os >> tmpBuffer;
    myString = (char*)tmpBuffer;

    return os;
}

template<int SIZE> otl_stream& operator>>(otl_stream& os, MyString<SIZE> &myString)
{
    char tmpBuffer[5000];
    memset(tmpBuffer, 0x00, sizeof(tmpBuffer));

    os >> tmpBuffer;
    myString = (char*)tmpBuffer;

    return os;
}


#endif

typedef MyString<16> STRING16;
typedef MyString<32> STRING32;
typedef MyString<256> STRING;
typedef MyString<1000> STRING1000;
typedef MyString<3000> STRING3000;
typedef MyString<5000> STRING5000;

typedef MyString<32> STR_REC_32;
typedef MyString<48> STRING_REC;



#ifdef WIN32
/*
template<int SIZE_A, int SIZE_B> inline MyString<SIZE_A>& operator<<(MyString<SIZE_A>& A, const MyString<SIZE_B>& B)
{
    A << B.c_str();
    return A;
};

template<int SIZE_B> inline MyString<1000>& operator<<(MyString<1000>& A, const MyString<SIZE_B>& B)
{
    A << B.c_str();
    return A;
};

template<int SIZE_B> inline MyString<3000>& operator<<(MyString<3000>& A, const MyString<SIZE_B>& B)
{
    A << B.c_str();
    return A;
};
*/
#endif

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




