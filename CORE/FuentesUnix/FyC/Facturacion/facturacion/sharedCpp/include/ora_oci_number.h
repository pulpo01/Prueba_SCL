#ifndef NO_INDENT
#ident "@(#)$RCSfile: ora_oci_number.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 16:30:29 $"
#endif

///
/// \file ora_oci_number.h
///


#ifndef ORA_OCI_NUMBER_H
#define ORA_OCI_NUMBER_H

#include <stdio.h>
#include <string.h>
#include <oci.h>


//! Numero de digitos decimales por defecto.
/*!
    Cuando no se especifica, los objetos OraOciNumber utilizan
    por defecto esta cantidad de digitos decimales.
*/
#define ORAOCI_DEFAULT_DEC_PREC 3

//! Largo maximo de numero representado por OraOciNumber.
/*!
    El numero de digitos de cualquier numero representado por la clase
    OraOciNumber no podra exeder eta cantidad de digitos, incluido el
    separador decimal y simbolo de signo.
*/
#define ORAOCI_MAX_NUM_LEN 100


//! Maximo numero de digitos decimales que se pueden representar por la clase OraOciNumber.
/*!
    Este valor define la maxima presicion que se puede manejar con la clase OraOciNumber.
*/
#define ORAOCI_MAX_DEC_PREC 10


extern "C"
{
    //! Define HANDLER (puntero) sobre funcion de alocacion dinamica de memoria.
    typedef dvoid* (*MALLOC_FUNC_POINTER)(dvoid *, size_t);

    //! Define HANDLER (puntero) sobre funcion de realocacion dinamica de memoria.
    typedef dvoid* (*REALLOC_FUNC_POINTER)(dvoid *, dvoid *, size_t);

    //! Define HANDLER (puntero) sobre funcion de liberacion dinamica de memoria.
    typedef void (*FREE_FUNC_POINTER)(dvoid *, dvoid *);
};

//! Tipo definido de puntero sobre funcion.
/*!
    Este tipo designa un puntero para una funcion del tipo:
    \c void \c funcion(\c const \c char*, \c int) \n
    Este tipo es utilizado para facilitar la opcion de sobrecarga de funciones
    para el manejo de errores.\n
    La funcion de este tipo maneja los siguientes argumentos:
    \li 1. (const char*): Cadena de caracteres con la descripcion del error.
    \li 2. (int)        : Codigo del error oci.lib.
*/
typedef void (*ORAOCI_NUM_ERROR_HANDLER_FUNC)(const char*, int);



//! Clase para manejo de excepciones OraOciNumber.
/*! 
    Esta clase es utilizada para capturar los errores generados al
    realizar operaciones con la clase OraOciNumber.

    Los errores generados por la clase OraOciNumber son encapsulados por
    esta clase. La informacion asociada al error puede ser recuperada por
    los metodos miembros: 
    \li what()
    \li errNum()
*/
class OraOciNumberException
{
private:

    char    _msg[1024]; //!< Contiene la descripcion del error generado.
    int     _cod;       //!< Contiene el codigo de error generado.

public:

    //! Contructor por defecto de la clase OraOciNumberException
    /*!
        Este constructor instancia la clase con valores por defecto vacios
        para cada uno de sus miembros.
        \sa OraOciNumberException(const char* msg, int code),
        ~OraOciNumberException(), what() y errNum()
    */
    OraOciNumberException() throw()
    {
        _cod = 0;
        memset(_msg, 0x00, sizeof(_msg));
    };

    //! Contructor de la clase OraOciNumberException
    /*!
        Este constructor instancia la clase con los valores que identifican el error generado.
        \param msg  :es una cadena de caracteres con la descripcion del error.
        \param code :es un numero entero que identifica el codigo de error segun la libreria oci.lib.
        \sa OraOciNumberException(), ~OraOciNumberException(), what() y errNum()
    */
    OraOciNumberException(const char* msg, int code) throw()
    {
        memset(_msg, 0x00, sizeof(_msg));
        strncpy(_msg, msg, (sizeof(_msg) - 1));
        _cod = 0;
        _cod = code;
    };

    //! Destructor de la clase OraOciNumberException
    ~OraOciNumberException() throw() {};

    //! Recupera la descripcion del error.
    /*!
        \return Cadena de caracteres con la descripcion del error generado.
        \sa OraOciNumberException(), OraOciNumberException(const char* msg, int code),
        \sa ~OraOciNumberException() y errNum()
    */
    const char* what() const throw() { return (char*) _msg;};

    //! Recupera el codigo (ID) del error.
    /*!
        \return ID del error generado segun la libreria oci.lib.
        \sa OraOciNumberException(), OraOciNumberException(const char* msg, int code),
        \sa ~OraOciNumberException() y what()
    */
    int errNum() const throw() {return _cod;};

};




//! Clase para definicion de ambiente para la clase OraOciNumber.
/*! 
    Esta clase encapsula el ambiente OCI asociado a la clase OraOciNumber.
    Cada instancia de la clase OraOciNumber debe estar asociado a un unico Ambiente OCI
    que definira el manejo de errores y otros aspectos relacionados con la libreria oci.lib.
    Para mayor detalle sobre ambientes OCI se recomienda ver la documentacion de \b Oracle \b Call \b Interface.
*/
class OraOciEnviroment
{
private:
    //! Puntero sobre HANDLER OCIError
    /*! Este miembro encapula los errores generados
        por la libreria oci.lib.
    */
    OCIError*                       _err;

    //! Puntero sobre HANDLER OCIEnv
    /*! Este miembro encapsula el enviroment OCI necesario para
        activar las funcionalidades de la libreria OCI.
    */
    OCIEnv*                         _env;

    //! Puntero sobre funcion de manejo de errores. 
    /*! Este puntero es utilizado para definir una funcion alternativa
        de manejo de errores asociados al enviroment OCI, esto permite customizar
        el manejo de errores y excepciones generados por la clase OraOciNumber.
        \sa ORAOCI_NUM_ERROR_HANDLER_FUNC.
    */
    ORAOCI_NUM_ERROR_HANDLER_FUNC   _erf;

    //! Cantidad de decimales por defecto. 
    /*! Este miembro de la clase permite definir la cantidad de decimales
        a ser utilizados globalmente por todos las objetos OraOciNumber asociados
        al Ambiente.
    */
    int                             _dr;

public:
    //! Retorna HANDLER para el manejo de errores
    /*!
        \return Puntero OCIError
        \sa _erf
    */
    OCIError* getErr()
    {
        return _err;
    };

    //! Retorna HANDLER del Ambiente OCI
    /*!
        \return Puntero OCIEnv
        \sa _env
    */
    OCIEnv* getEnv()
    {
        return _env;
    };

    //! Retorna HANDLER de la funcion de Menejo de errores
    /*!
        \return Puntero ORAOCI_NUM_ERROR_HANDLER_FUNC
        \sa _erf
    */
    ORAOCI_NUM_ERROR_HANDLER_FUNC getErf()
    {
        return _erf;
    };

    //! Retorna numero de decimales
    /*!
        \return Entero que define el nuemro de decimales a utilizar en el calculo de numeros reales
        \sa _dr
    */
    int getDr()
    {
        return _dr;
    };

    //! Cambia la cantidad de decimales.
    /*!
        El valor debe ser > 0 y menor que ORAOCI_MAX_DEC_PREC 
        \return Entero que define el nuemro de decimales a utilizar en el calculo de numeros reales
        \sa _dr y getDr()
    */
    int setDr(int dr)
    {
        if(dr >= 0 && dr < ORAOCI_MAX_DEC_PREC) _dr = dr;
        return _dr;
    };


    //! Contructor por defecto de la clase OraOciEnviroment.
    /*!
        Este constructor se encarga de instanciar los objetos OCI necesarios para el manejo
        de la clase OraOciNumber. La utilizacion de este constructor crea un Ambiente OCI con
        sus valores por defecto. La precision decimal es definida por ORAOCI_DEFAULT_DEC_PREC
        y no se define funcion alternativa para el manejo de errores (_erf = NULL).
    */
    OraOciEnviroment()
    {
        _dr = ORAOCI_DEFAULT_DEC_PREC;

        OCIEnvCreate((OCIEnv **) &_env,
                     (ub4) OCI_OBJECT,
                     (dvoid *)NULL,
                     (MALLOC_FUNC_POINTER) NULL,
                     (REALLOC_FUNC_POINTER) NULL,
                     (FREE_FUNC_POINTER) NULL,
                     (size_t) NULL,
                     (dvoid **) NULL);

        OCIHandleAlloc((dvoid *) _env,
                       (dvoid **) &_err,
                       OCI_HTYPE_ERROR,
                       (size_t) NULL,
                       (dvoid **) NULL);

        _erf = NULL;
    };

    /// This constructor takes an error function handler to customize
    /// errors management for the OraOciNumber class

    //! Contructor de la clase OraOciEnviroment.
    /*!
        Este constructor se encarga de instanciar los objetos OCI necesarios para el manejo
        de la clase OraOciNumber. La utilizacion de este constructor crea un Ambiente OCI con
        sus valores por defecto. La precision decimal es definida por ORAOCI_DEFAULT_DEC_PREC
        y se define la funcion alternativa para el manejo de errores segun el argumento erf.
        \param erf Puntero sobre una funcion tipo ORAOCI_NUM_ERROR_HANDLER_FUNC para el manejo
        alternativo de errores en la clase OraOciNumber.

        \sa _erf y OraOciEnviroment().
    */
    OraOciEnviroment(ORAOCI_NUM_ERROR_HANDLER_FUNC erf)
    {
        _dr = ORAOCI_DEFAULT_DEC_PREC;

        OCIEnvCreate((OCIEnv **) &_env,
                     (ub4) OCI_OBJECT,
                     (dvoid *)NULL,
                     (MALLOC_FUNC_POINTER) NULL,
                     (REALLOC_FUNC_POINTER) NULL,
                     (FREE_FUNC_POINTER) NULL,
                     (size_t) NULL,
                     (dvoid **) NULL);

        OCIHandleAlloc((dvoid *) _env,
                       (dvoid **) &_err,
                       OCI_HTYPE_ERROR,
                       (size_t) NULL,
                       (dvoid **) NULL);

        if(erf == NULL)
        {
            _erf = NULL;
        }
        else
        {
            _erf = erf;
        }
    };

    //! Destructor de la clase OraOciEnviroment.
    /*!
        Elimina los objetos OCI creados dentro del Ambiente.
        \sa _err y _env.
    */
    ~OraOciEnviroment()
    {
        OCIHandleFree((dvoid *) _err, OCI_HTYPE_ERROR);
        OCIHandleFree((dvoid *) _env, OCI_HTYPE_ENV);
    };
};


//! Clase de manejo de numeros enteros/reales de tipo ORACLE NUMBER.
/*! 
    Esta clase sirve para failitar el manejo de numeros decimales y evitar la perdida
    de precision provocada por los tipos \c float y \c double de punto flotante. Esta
    clase encapsula principalmente un objeto de tipo OCINumber de la libreria oci.lib (\b Oracle
    \b Call \b Interface ). Este objetro permite realizar opercaiones arithmeticas sobre reales
    de la misma manera como se realizan las operaciones entre objetos tipo NUMBER en una base de
    datos ORACLE.\n\n

    Las siguientes opreaciones basicas han sido definidas: (A,B y C son objetos OraOciNumber)
    \li C = A + B.
    \li A = A + B, A += B.
    \li C = A - B.
    \li A = A - B, A -= B.
    \li C = A / B.
    \li A = A / B, A /= B.
    \li C = A * B.
    \li A = A * B, A *= B.
    \nOperaciones de asignacion:
    \li A = (int)1
    \li A = (double)1
    \li A = (float)1
    \li C = (A (+-/*) (int,double,float)2)
*/
class OraOciNumber
{
protected:
    //! Miembro principal tipo OCINumber
    /*! Este miembro encapsula los datos necesarios para la realizacion
        de operaciones arithmeticas para objetos tipo \b NUMBER de la libreria oci.lib
        (\b Oracle \b Call \b Interface ).
    */
    OCINumber           _num;

    //! Puntero para el manejo de errores.
    /*! Este miembro es un puntero al HANDLER de errores asociado al Ambiente OCI
        y que permite recuperar cualquier error en las operaciones realizadas con
        la libreria oci.lib (\b Oracle \b Call \b Interface ).
        \sa OraOciEnviroment.
    */
    OCIError*           _err;

    //! Puntero para definicion de Ambiente OCI.
    /*! Este miembro es un puntero al HANDLER del Ambiente OCI que permite 
        habilitar las funciones y metodos de la libreria oci.lib (\b Oracle \b Call \b Interface ).
        \sa OraOciEnviroment.
    */
    OCIEnv*             _env;

    //! Puntero a funcion alternativa de manejo de errores.
    /*! Este miembro es un puntero a una funcion de manejo de errores que permite redefinir
        la captura de errores generados en la libreria oci.lib (\b Oracle \b Call \b Interface ).
        \sa OraOciEnviroment y ORAOCI_NUM_ERROR_HANDLER_FUNC.
    */
    ORAOCI_NUM_ERROR_HANDLER_FUNC  _erf;

    //! Numero de decimales.
    /*! Este miembro especiica la cantidad de posiciones decimales a utilizar en las operaciones
        arithmeticas en la libreria oci.lib (\b Oracle \b Call \b Interface ).
        \sa OraOciEnviroment.
    */
    int         _decimalPrec;


    //! Inicia Ambiente OCI.
    /*!
        \param env :Puntero a HANDLER de Ambiente OCIEnv.
        \param err :Puntero a HANDLER de Errores OCIError.
        \sa OraOciEnviroment
    */
    void initEnviroment(OCIEnv* env, OCIError* err)
    {

        _env = env;
        _err = err;

    };

    
    //! Carga de valor entero.
    /*!
        Este metodo es utilizado para la carga de valores enteros (\c int) en la clase
        \param value :Valor a entero a cargar.
    */
    void chargeInt(const int value)
    {
        if(OCINumberFromInt(_err, (CONST dvoid*) &value, (uword) sizeof(int), OCI_NUMBER_SIGNED, &_num))
        {
            throwError((dvoid *) _err);
        }
    };


    //! Default constructor available only by heritance -> allow constructor without OraOciEnviroment
    OraOciNumber(){}

private:

    //! Buffer de Numero en formato Texto.
    /*! Este miembro guarda la representacion del Numero encapsulado (entero o real) en formato texto.
    */
    char        _buffer[ORAOCI_MAX_NUM_LEN + 1];

    //! Buffer de formato Texto.
    /*! Este miembro guarda el formato de salida de texto de la representacion 
        del Numero encapsulado (entero o real). Ex: \b 9999999999990D9999 indica
        un formato de 14 digitos para la parte entera y 4 digitos para la parte decimal.
    */
    char        _formatString[ORAOCI_MAX_NUM_LEN + 1];


    //! Recupera la cantidad de digitos decimales del numero pasado en argumento.
    /*!
        \return Numnero de digitos decimales.
        \param str       :Cadena de caracteres que contiene la representacion de un numero en formato texto.
        \param intLength :Largo de la Cadena str.
    */
    int getNumOfDecPlaces(const char* str, int* intLength)
    {
        char* ptr = (char*)str;
        int len = strlen(str);
        int i, iLen;

        iLen = 0;

        for(i = 0; i < len; i++)
        {
            if( (*ptr == '.') || (*ptr == ',') )break;
            ptr++;
            iLen++;
        }

        if(intLength != NULL) *intLength = iLen;

        if(i == len) return 0;

        return (len - i -1);
    };


    //! Elimina espacios de la cadena pasada en argumento.
    /*!
        \param szpalabra :Cadena de caracteres.
    */
    void trim(char* szpalabra)
    {
        trim(szpalabra, 1, strlen(szpalabra), szpalabra);
    };


    //! Elimina espacios de la cadena pasada en argumento.
    /*!
        \param szpalabra :Cadena de caracteres a limpiar de espacios.
        \param iini      :Posicion de inicio para aplicacion de borrado de espacios.
        \param ilargo    :Largo de la cadena a limpiar.
        \param szvuelta  :Cadena de caracteres donde se guardara el resultado.
    */
    void trim(char *szpalabra, int iini, int ilargo, char* szvuelta)
    {
        int ii;
        szpalabra += iini - 1;
        for (ii=iini;ii<=(iini + ilargo -1);ii++)
        {
            if (*szpalabra != 32)
               {
               *szvuelta = *szpalabra;
               szvuelta++;
               }
            szpalabra++;
        }
       *szvuelta = 0;
    };


    //! Construye formato de texto para trasformacion NUMBER -> CHAR.
    /*!
        Este metodo permite construir un formato del tipo \b 9999999D9999 en base a la
        cantidad de digitos para la parte entera y decimal pasados en argumento.
        \param decPrec          :Cantidad de digitos decimales.
        \param intLength        :Cantidad de digitos para la parte entera.
        \param formatString     :Cadena que contiene el formato retornado.
        \param formatStringSize :Largo de la cadena \c formatString.
    */
    void setOraOciNumberDecimalPrecision(int decPrec, int intLength, char* formatString, int formatStringSize)
    {
        memset(formatString, 0x00, formatStringSize);

        char intPart[ORAOCI_MAX_NUM_LEN + 1];
        char decPart[ORAOCI_MAX_NUM_LEN + 1];

        //int intLength =0;
        //intLength =0;
        //intLength = ORAOCI_MAX_NUM_LEN - decPrec - 1;

        memset(intPart, 0x00, sizeof(intPart));
        memset(decPart, 0x00, sizeof(decPart));

        if(intLength > 0)
        {
            memset(intPart, '9', intLength); //intLength);
            intPart[intLength] = '0';
        }
        if(decPrec > 0) memset(decPart, '9', decPrec);

        if(intLength > 0) strcat(formatString, intPart);


        if(decPrec > 0)
        {
            strcat(formatString, "D");
            //strcat(formatString, "0D");
            strcat(formatString, decPart);
        }

        return;
    };


    //! Construye formato de texto para trasformacion NUMBER -> CHAR.
    /*!
        Este metodo permite construir un formato del tipo \b 9999999D9999 en base a la
        cantidad de digitos para la parte entera y decimal pasados en argumento.
        \param decPrec          :Cantidad de digitos decimales.
        \param intLength        :Cantidad de digitos para la parte entera.
        \param formatString     :Cadena que contiene el formato retornado.
    */
    void setOraOciNumberDecimalPrecision(int decPrec, char* formatString, int formatStringSize)
    {
        memset(formatString, 0x00, formatStringSize);

        char intPart[ORAOCI_MAX_NUM_LEN + 1];
        char decPart[ORAOCI_MAX_NUM_LEN + 1];

        int intLength =0;
        intLength = ORAOCI_MAX_NUM_LEN - decPrec - 1;

        memset(intPart, 0x00, sizeof(intPart));
        memset(decPart, 0x00, sizeof(decPart));

        memset(intPart, '9', 9); //intLength);
        memset(decPart, '9', decPrec);

        strcat(formatString, intPart);


        if(decPrec > 0)
        {
            strcat(formatString, "0D");
            strcat(formatString, decPart);
        }

        return;
    };


    //! Carga de valor real.
    /*!
        Este metodo es utilizado para la carga de valores reales (\c double) en la clase
        \param value :Valor a real a cargar.
    */
    void chargeDbl(const double value)
    {
        if(OCINumberFromReal(_err, (CONST dvoid*) &value, (uword) sizeof(double), &_num))
        {
            throwError((dvoid *) _err);
        }
    };


    //! Carga de valor texto.
    /*!
        Este metodo es utilizado para la carga de valores reales o enteros a partir
        de una cadena de caracteres.
        \param str :Cadena de caracteres que representa un numero entero o real.
    */
    void chargeStr(const char* str)
    {
        char formatString[ORAOCI_MAX_NUM_LEN + 1];
        char tmpBuffer[ORAOCI_MAX_NUM_LEN + 1];

        memset(tmpBuffer, 0x00, sizeof(tmpBuffer));

        strcpy(tmpBuffer, str);
        trim(tmpBuffer);

        int integerPlaces;

        int decimalPlaces = getNumOfDecPlaces(tmpBuffer, &integerPlaces);

        setOraOciNumberDecimalPrecision(decimalPlaces, integerPlaces, formatString, sizeof(formatString));

        if(OCINumberFromText(_err, 
                             (CONST text*) tmpBuffer,
                             (ub4) strlen(tmpBuffer),
                             (CONST text*) formatString,
                             (ub4) strlen(formatString),
                             (CONST text*) NULL,
                             (ub4) 0,
                             &_num))
        {
            throwError((dvoid *) _err);
        }
    };


    //! Carga de valor a partir de otro objeto OraOciNumber.
    /*!
        Este metodo es utilizado para la carga de valores a partir
        de otro objeto de tipo OraOciNumber.
        \param value :Objeto OraOciNumber.
    */
    void chargeOraOciNumber(const OraOciNumber& value)
    {
        OraOciNumber* ptr = (OraOciNumber*)&value;

        chargeInt(0);

        if(OCINumberAdd(_err,
                        &_num,
                        &ptr->_num,
                        &_num))
        {
            throwError((dvoid *) _err);
        }
    };


    //! Metodo de manejo de errores.
    /*!
        Este metodo recupera los errors que puedan surgir en la ejecucion de las funciones
        y metodos de la libreria oci.lib. Este metodo lanza una excepcion de tipo OraOciNumberException
        con el error detectado, o ejecuta la funcion redefinida para el manejo de errores.
        \param err :HANDLER de error OCI.
        \sa OraOciEnviroment y ORAOCI_NUM_ERROR_HANDLER_FUNC.
    */
    void throwError(dvoid* err)
    {
        char buffer[1024];
        int errcode = 0;

        memset(buffer, 0x00, sizeof(1024));

        OCIErrorGet(err,
                    (ub4) 1,
                    (text *) NULL,
                    &errcode,
                    (text *) buffer,
                    (ub4) sizeof(buffer),
                    (ub4) OCI_HTYPE_ERROR);

        if(_erf == NULL) throw OraOciNumberException(buffer, errcode);

        _erf(buffer, errcode);
    };

   

public:

    //! Constructor de la clase.
    /*!
        Este constructor ha sido definido para recibir un argumento de tipo OraOciEnviroment
        de manera que toda instancia de la clase tenga un Ambiente OCI asociado. Este aspecto
        es particularmente importante cuando se utiliza la clase en ambientes multithreading.\n
        En programacion MT se recomienda la creacion de un ambiente OraOciEnviroment por cada thread.
        Se puede utilizar un unico ambiente para todos los instancias de esta clase, pero esto aumentara
        la probabilidad de locks y contencion en cada thread generando una perdida importante de esacalabilidad.
        \param env :Ambiente OCI OraOciEnviroment.
        \sa OraOciEnviroment.
    */
    OraOciNumber(OraOciEnviroment* env)
    {
        if(env == NULL)
        {
            throw OraOciNumberException("UNDEFINED ENVIROMENT IN OraOciNumber CONSTRUCTOR", 0);
        }

        _erf = env->getErf();
        _decimalPrec = env->getDr();
        initEnviroment(env->getEnv(), env->getErr());
        chargeInt(0);
    };


    //! Constructor de la clase.
    /*!
        Este constructor permite la instanciacion de la clase en funcion de otro objeto OraOciNumber.
        La clase instanciada de esta forma compartira el mismo Ambiente OCI (OraOciEnviroment) que la del objeto
        OraOciNumber pasado en argumento.
        \param value :Objeto OraOciNumber.
        \sa OraOciEnviroment.
    */
    OraOciNumber(const OraOciNumber& value)
    {
        _erf = value._erf;
        _decimalPrec = value._decimalPrec;
        initEnviroment(value._env, value._err);
        chargeOraOciNumber(value);
    };


    //! Destructor de la clase.
    ~OraOciNumber(){};

    //! Retorna el formato tipo \b 999999999D9999.
    /*!
        Este metodo permite recuperar el formato de transformacion a texto utilizado por la clase
        para realizar transformaciones NUMBER -> CHAR.
        \return Cadena de caracteres con el formato de transformacion.
        \sa setOraOciNumberDecimalPrecision.
    */
    char*  fmt()
    {
        setOraOciNumberDecimalPrecision(_decimalPrec, _formatString, sizeof(_formatString));
        return _formatString;
    }


    //! Retorna numero en formato texto.
    /*!
        Este metodo retorna la representacion del numero encapsulado en la clase
        en formato texto. Es equivalente a TO_CHAR(NUMBER).
        \return Cadena de caracteres con el numero en formato texto.
        \sa _buffer, chargeStr.
    */
    char*  c_str()
    {
        ub4 bufferLen(ORAOCI_MAX_NUM_LEN);
        memset(_buffer, 0x00, sizeof(_buffer));
        char* ptr;
        ptr = _buffer;

        char formatString[ORAOCI_MAX_NUM_LEN + 1];

        setOraOciNumberDecimalPrecision(_decimalPrec, formatString, sizeof(formatString));

	    if(OCINumberToText(_err,
                           &_num,
                           (CONST text*) formatString,
                           (ub4) strlen(formatString),
                           (CONST text*) NULL,
                           (ub4) 0,
                           &bufferLen,
                           (text*)ptr))
        {
            throwError((dvoid *) _err);
        }

        trim(ptr);

        return ptr;
    };


    //! Retorna numero en formato \c double.
    /*!
        Este metodo retorna la representacion del numero encapsulado en la clase
        en formato \c double.
        \return Numero en formato \c double.
        \sa chargeDbl.
    */
    double v_dbl()
    {
        double value;

        if(OCINumberToReal(_err,
                           &_num,
                           (uword) sizeof(double),
                           (dvoid*) &value))
        {
            throwError((dvoid *) _err);
        }

        return value;
    };


    //! Retorna numero en formato \c int.
    /*!
        Este metodo retorna la representacion del numero encapsulado en la clase
        en formato \c int.
        \return Numero en formato \c int.
        \sa chargeInt.
    */
    int    v_int()
    {
        int i;
        double tmpDbl;
        tmpDbl = v_dbl();

        if(tmpDbl < 0)
        {
            if(tmpDbl > -1)
            {
                if(tmpDbl > -0.50) return 0;
                return -1;
            }
        }
        else
        {
            if(tmpDbl < 1)
            {
                if(tmpDbl < 0.50) return 0;
                return 1;
            }
        }

        OCINumber tmpNum;

        // La utilizacion de la funcion OCINumberToInt genera exepciones cuando se intenta convertir a entero
        // un numero decimal proximo a cero (0). El error encontrado es el codigo 22054 "underflow error". Esto
        // significa que el numero que se quiere convertir es muy pequeno y no tiene cavida en el buffer destino,
        // en este caso "INT". Este caso se presenta para valores en el rango [0,1].

        if(OCINumberRound (_err,
                          &_num,
                           0,
                           &tmpNum))
        {
            throwError((dvoid *) _err);
        }



        if(OCINumberToInt(_err,
                          &tmpNum,
                          (uword) sizeof(int),
                          (uword) OCI_NUMBER_SIGNED,
                          (dvoid*) &i))
        {
            throwError((dvoid *) _err);
        }
        return i;
    };



    //! Operador Igualdad con tipo INT.
    /*!
        Este operador permite operaciones del tipo:
        \li A = B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es de tipo \c int.
        \return \c *this (A)
        \param rhs :(right hand side) Numero tipo \c int.
        \sa chargeInt.
    */
    OraOciNumber& operator=(const int& rhs)
    {
        chargeInt(rhs);
        return *this;
    };


    //! Operador Igualdad con tipo \c double.
    /*!
        Este operador permite operaciones del tipo:
        \li A = B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es de tipo \c double.
        \return \c *this (A)
        \param rhs :(right hand side) Numero tipo \c double.
        \sa chargeDbl.
    */
    OraOciNumber& operator=(const double& rhs)
    {
        chargeDbl(rhs);
        return *this;
    };



    //! Operador Igualdad con tipo \c char*.
    /*!
        Este operador permite operaciones del tipo:
        \li A = "3.1416".\n
        Donde:
        \li A es OraOciNumber.
        \return \c *this (A)
        \param rhs :(right hand side) Cadena de caracteres representando un numero.
        \sa chargeStr.
    */
    OraOciNumber& operator=(const char* rhs)
    {
        chargeStr(rhs);
        return *this;
    };



    //! Operador Igualdad con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A = B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.
        \return \c *this (A)
        \param value :Objeto OraOciNumber.
        \sa chargeOraOciNumber.
    */
    OraOciNumber& operator=(const OraOciNumber& value)
    {
        chargeOraOciNumber(value);
        return *this;
    };



    //! Operador += con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A += B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.
        \return \c *this (A)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator-=, operator*= y operator/=.
        \sa operator+=(OraOciNumber& lhs, T rhs).
    */
    OraOciNumber& operator+=(OraOciNumber& rhs)
    {
        if(OCINumberAdd(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &_num))
        {
            throwError((dvoid *) _err);
        }
        return *this;
    };

    //! Operador -= con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A -= B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.
        \return \c *this (A)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator+=, operator*= y operator/=.
        \sa operator-=(OraOciNumber& lhs, T rhs).
    */
    OraOciNumber& operator-=(OraOciNumber& rhs)
    {
        if(OCINumberSub(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &_num))
        {
            throwError((dvoid *) _err);
        }
        return *this;
    };



    //! Operador *= con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A *= B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.
        \return \c *this (A)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator+=, operator-= y operator/=.
        \sa operator*=(OraOciNumber& lhs, T rhs).
    */
    OraOciNumber& operator*=(OraOciNumber& rhs)
    {
        if(OCINumberMul(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &_num))
        {
            throwError((dvoid *) _err);
        }
        return *this;
    };


    //! Operador /= con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A /= B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.
        \return \c *this (A)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator+=, operator-= y operator*=.
        \sa operator/=(OraOciNumber& lhs, T rhs).
    */
    OraOciNumber& operator/=(OraOciNumber& rhs)
    {
        if(OCINumberDiv(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &_num))
        {
            throwError((dvoid *) _err);
        }
        return *this;
    };



    //! Operador + con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A + B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        El objeto (C) retornado hereda el ambiente OraOciEnviroment de A.
        \return  OraOciNumber (C)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator+=, operator-, operator* y operator/.
    */
    OraOciNumber operator+(OraOciNumber& rhs)
    {
        OraOciNumber result(*this);
        result += rhs;
        return result;
    };




    //! Operador - con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A - B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        El objeto (C) retornado hereda el ambiente OraOciEnviroment de A.
        \return  OraOciNumber (C)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator-=, operator+, operator* y operator/.
    */
    OraOciNumber operator-(OraOciNumber& rhs)
    {
        OraOciNumber result(*this);
        result -= rhs;
        return result;
    };



    //! Operador * con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A * B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        El objeto (C) retornado hereda el ambiente OraOciEnviroment de A.
        \return  OraOciNumber (C)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator*=, operator+, operator- y operator/.
    */
    OraOciNumber operator*(OraOciNumber& rhs)
    {
        OraOciNumber result(*this);
        result *= rhs;
        return result;
    };



    //! Operador / con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A / B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        El objeto (C) retornado hereda el ambiente OraOciEnviroment de A.
        \return  OraOciNumber (C)
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator/=, operator+, operator- y operator*.
    */
    OraOciNumber operator/(OraOciNumber& rhs)
    {
        OraOciNumber result(*this);
        result /= rhs;
        return result;
    };





    
    //! Operador == con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A == B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        \return  \c true si A == B, \c false si A != B
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator!=, operator<, operator<=, operator> y operator>=.
        \sa operator==(OraOciNumber& lhs, T rhs)
    */
    bool operator==(OraOciNumber& rhs)
    {    
        sword result;
        if(OCINumberCmp(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &result))
        {
            throwError((dvoid *) _err);
        }

        return (result == 0);
    };



    //! Operador != con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A != B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        \return  \c false si A == B, \c true si A != B
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator==, operator<, operator<=, operator> y operator>=.
        \sa operator!=(OraOciNumber& lhs, T rhs)
    */
    bool operator!=(OraOciNumber& rhs)
    {
        sword result;
        if(OCINumberCmp(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &result))
        {
            throwError((dvoid *) _err);
        }

        return (result != 0);
    };



    //! Operador < con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A < B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        \return  \c true si A < B, \c false si A >= B
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator==, operator!=, operator<=, operator> y operator>=.
        \sa operator<(OraOciNumber& lhs, T rhs)
    */
    bool operator <(OraOciNumber& rhs)
    {
        sword result;
        if(OCINumberCmp(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &result))
        {
            throwError((dvoid *) _err);
        }

        return (result < 0);
    };



    //! Operador <= con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A <= B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        \return  \c true si A <= B, \c false si A > B
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator==, operator!=, operator<, operator> y operator>=.
        \sa operator<=(OraOciNumber& lhs, T rhs)
    */
    bool operator<=(OraOciNumber& rhs)
    {
        sword result;
        if(OCINumberCmp(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &result))
        {
            throwError((dvoid *) _err);
        }

        return (result <= 0);
    };



    //! Operador > con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A > B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        \return  \c true si A > B, \c false si A <= B
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator==, operator!=, operator<, operator<= y operator>=.
        \sa operator>(OraOciNumber& lhs, T rhs)
    */
    bool operator >(OraOciNumber& rhs)
    {
        sword result;
        if(OCINumberCmp(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &result))
        {
            throwError((dvoid *) _err);
        }

        return (result > 0);
    };



    //! Operador >= con tipo OraOciNumber.
    /*!
        Este operador permite operaciones del tipo:
        \li A >= B.\n
        Donde:
        \li A es OraOciNumber.
        \li B es OraOciNumber.\n
        \return  \c true si A >= B, \c false si A < B
        \param rhs :(right hand side) Objeto OraOciNumber.
        \sa operator==, operator!=, operator<, operator<= y operator>.
        \sa operator>=(OraOciNumber& lhs, T rhs)
    */
    bool operator>=(OraOciNumber& rhs)
    {
        sword result;
        if(OCINumberCmp(_err,
                        &_num,
                        (OCINumber*)&rhs._num,
                        &result))
        {
            throwError((dvoid *) _err);
        }

        return (result >= 0);
    };




    //! Cambia el valor de numero de digitos decimales (set decimal precision).
    /*!
        \return Numero de de digitos decimales.
        \param decimalPrecision :Numero de de digitos decimales.
    */
    int sdp(int decimalPrecision)
    {
        if((decimalPrecision > 0) && (decimalPrecision <= ORAOCI_MAX_DEC_PREC))
        {
            _decimalPrec = decimalPrecision;
        }

        return _decimalPrec;
    };



#ifdef _IOSTREAM_

    //! Operador << compatible con \c std::ostream.
    /*!
        Permite realizar operaciones con objetos std::ostream de tipo:
        \li O << A.\n
        Donde:
        \li A es OraOciNumber.
        \li O es std::ostream.
        \return Objeto std::ostream (O).
        \param o :Objeto std::ostream.
        \param n :Objeto OraOciNumber.
    */
    friend std::ostream& operator<<(std::ostream& o, const OraOciNumber& n)
    { 
        OraOciNumber* ptr = (OraOciNumber*) &n;
        return o << ptr->c_str(); 
    }


    //! Operador << compatible con \c std::ostream.
    /*!
        Permite realizar operaciones con objetos std::ostream de tipo:
        \li O << A.\n
        Donde:
        \li A es OraOciNumber.
        \li O es std::ostream.
        \return Objeto std::ostream (O).
        \param o :Objeto std::ostream.
        \param n :Objeto OraOciNumber.
    */
    friend std::ostream& operator<<(std::ostream& o, OraOciNumber& n)
    { return o << n.c_str(); }


#endif


#ifdef __OTL_H__


    //! Operador << compatible con \c otl_stream.
    /*!
        Permite realizar operaciones con objetos otl_stream de tipo:
        \li O << A.\n
        Donde:
        \li A es OraOciNumber.
        \li O es otl_stream.
        \return Objeto otl_stream (O).
        \param os :otl_stream.
        \param n  :Objeto OraOciNumber.
    */
    friend otl_stream& operator<<(otl_stream& os, const OraOciNumber& n)
    {
        OraOciNumber* ptr = (OraOciNumber*) &n;
        os << ptr->c_str();
        return os;
    }

    //! Operador << compatible con \c otl_stream.
    /*!
        Permite realizar operaciones con objetos otl_stream de tipo:
        \li O << A.\n
        Donde:
        \li A es OraOciNumber.
        \li O es otl_stream.
        \return Objeto otl_stream (O).
        \param os :otl_stream.
        \param n  :Objeto OraOciNumber.
    */
    friend otl_stream& operator<<(otl_stream& os, OraOciNumber& n)
    {
        os << n.c_str();
        return os;
    }


    //! Operador >> compatible con \c otl_stream.
    /*!
        Este operador permite recuperar valores desde un otl_stream siempre y cuando
        el valor devuelto sea de tipo NUMBER.\n
        Permite realizar operaciones con objetos otl_stream de tipo:
        \li O >> A.\n
        Donde:
        \li A es OraOciNumber.
        \li O es otl_stream.
        \return Objeto otl_stream (O).
        \param os :otl_stream.
        \param n  :Objeto OraOciNumber.
    */
    friend otl_stream& operator>>(otl_stream& os, OraOciNumber& n)
    {
        double value = 0.0;

        os >> value;
        n = value;
        return os;
    }


#endif






};


//! Operador += generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A += I.
    \li A += D.
    \li A += C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (A).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator+=(OraOciNumber& rhs)
*/
template<class T> OraOciNumber& operator+=(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;

    return (lhs) += aux;
}


//! Operador -= generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A -= I.
    \li A -= D.
    \li A -= C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (A).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator-=(OraOciNumber& rhs)
*/
template<class T> OraOciNumber& operator-=(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;

    return (lhs) -= aux;
}



//! Operador *= generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A *= I.
    \li A *= D.
    \li A *= C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (A).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator*=(OraOciNumber& rhs)
*/
template<class T> OraOciNumber& operator*=(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;

    return (lhs) *= aux;
}


//! Operador /= generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A /= I.
    \li A /= D.
    \li A /= C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (A).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator/=(OraOciNumber& rhs)
*/
template<class T> OraOciNumber& operator/=(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;

    return (lhs) /= aux;
}
















//! Operador + generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A + I.
    \li A + D.
    \li A + C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (R) el cual hereda el ambiente OraOciEnviroment de A..
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator+(OraOciNumber& rhs)
*/
template<class T> OraOciNumber operator+(OraOciNumber& lhs, T rhs)
{
    OraOciNumber result(lhs);
    OraOciNumber aux(lhs);
    aux = rhs;
    result += aux;
    return result;
}



//! Operador - generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A - I.
    \li A - D.
    \li A - C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (R) el cual hereda el ambiente OraOciEnviroment de A..
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator-(OraOciNumber& rhs)
*/
template<class T> OraOciNumber operator-(OraOciNumber& lhs, T rhs)
{
    OraOciNumber result(lhs);
    OraOciNumber aux(lhs);
    aux = rhs;
    result -= aux;
    return result;
}




//! Operador * generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A * I.
    \li A * D.
    \li A * C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (R) el cual hereda el ambiente OraOciEnviroment de A..
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator*(OraOciNumber& rhs)
*/

template<class T> OraOciNumber operator*(OraOciNumber& lhs, T rhs)
{
    OraOciNumber result(lhs);
    OraOciNumber aux(lhs);
    aux = rhs;
    result *= aux;
    return result;
}




//! Operador / generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A / I.
    \li A / D.
    \li A / C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return Objeto OraOciNumber (R) el cual hereda el ambiente OraOciEnviroment de A..
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator/(OraOciNumber& rhs)
*/

template<class T> OraOciNumber operator/(OraOciNumber& lhs, T rhs)
{
    OraOciNumber result(lhs);
    OraOciNumber aux(lhs);
    aux = rhs;
    result /= aux;
    return result;
}













//! Operador == generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A == I.
    \li A == D.
    \li A == C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return \c true (igual), \c false (diferente).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator==(OraOciNumber& rhs)
*/
template<class T> bool operator==(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;
    return ((lhs) == aux);
}



//! Operador != generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A != I.
    \li A != D.
    \li A != C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return \c true (diferente), \c false (igual).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator!=(OraOciNumber& rhs)
*/
template<class T> bool operator!=(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;
    return ((lhs) != aux);
}




//! Operador < generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A < I.
    \li A < D.
    \li A < C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return \c true (A < I/D/C), \c false (A >= I/D/C).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator<(OraOciNumber& rhs)
*/
template<class T> bool operator<(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;
    return ((lhs) < aux);
}




//! Operador <= generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A <= I.
    \li A <= D.
    \li A <= C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return \c true (A <= I/D/C), \c false (A > I/D/C).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator<=(OraOciNumber& rhs)
*/
template<class T> bool operator<=(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;
    return ((lhs) <= aux);
}




//! Operador > generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A > I.
    \li A > D.
    \li A > C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return \c true (A > I/D/C), \c false (A <= I/D/C).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator>(OraOciNumber& rhs)
*/
template<class T> bool operator>(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;
    return ((lhs) > aux);
}




//! Operador >= generico para Objetos tipo T.
/*!
    Este operador (template) permite la compatibilidad de las siguientes Operaciones:
    \li A >= I.
    \li A >= D.
    \li A >= C.\n
    Donde :
    \li A es OraOciNumber.
    \li I es \c int .
    \li D es \c double .
    \li C es \c char* .
    \return \c true (A >= I/D/C), \c false (A < I/D/C).
    \param lhs :(left hand side) ObjetoOraOciNumber.
    \param rhs :(right hand side) Objeto tipo T (\c int \c double \c char*).
    \sa OraOciNumber::operator=(const int& rhs),
    \sa OraOciNumber::operator=(const double& rhs),
    \sa OraOciNumber::operator=(const char* rhs).
    \sa OraOciNumber::operator>=(OraOciNumber& rhs)
*/
template<class T> bool operator>=(OraOciNumber& lhs, T rhs)
{
    OraOciNumber aux(lhs);
    aux = rhs;
    return ((lhs) >= aux);
}





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
