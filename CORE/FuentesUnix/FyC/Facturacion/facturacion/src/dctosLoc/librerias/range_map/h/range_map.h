#ifndef NO_INDENT
#ident "@(#)$RCSfile: range_map.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

#ifndef RANGE_MAP_H
#define RANGE_MAP_H

#include <map>

///
/// \file range_map.h
///



//! Tipos de Filtros para limite inferior
/*! 
    Este \c enum define los tipos de filtros validos para rango inferior
    en la clase range_map.
*/
enum LOWER_BOUND_FILTER_TYPE
{
    GR = 0, //!< (Greather than): Mayor que (>).
    GQ = 1  //!< (Greather or equal than): Mayor o igual que (>=).
};


//! Tipos de Filtros para limite superior
/*! 
    Este \c enum define los tipos de filtros validos para rango superior
    en la clase range_map.
*/
enum UPPER_BOUND_FILTER_TYPE
{
    LE = 0, //!< (Less than): Menor que (<).
    LQ = 1  //!< (Less or equal than): Menor o igual que (<=).
};

/*
lower_range:
    0. Search of type: all Y in MAP where Y <= X
    1. We must change the < operator in the MAP by >
       in order to create a inverse order in the MAP.
    2. MAP.lower_bound(X):
       find the first element where Y <= X for all Y in MAP.
       Y++ until end() for the entire collection of all Y in MAP where Y <= X.
    3. MAP.upper_bound(X):
       find the first element where Y < X for all Y in MAP
       Y++ until end() for the entire collection of all Y in MAP where Y < X.

upper_range:
    0. Search of type: all Y in MAP where Y >= X
    1. We must keep the < operator in the MAP
    2. MAP.lower_bound(X):
       find the first element where Y >= X for all Y in MAP.
       Y++ until end() for the entire collection of all Y in MAP where Y >= X.
    3. MAP.upper_bound(X):
       find the first element where Y > X for all Y in MAP
       Y++ until end() for the entire collection of all Y in MAP where Y > X.

*/



//! LLave para rango inferior.
/*! 
    Esta clase template define una clave o llave de acceso para el rango
    inferior de la range_map. El rango inferior se implementa en la forma
    \c std::map<LowerKey, ...> y se debe tomar en cuenta los siguientes aspectos:
    \li La clase \b V debe poseer los operadores \b = y \b > definidos.
    \li La clase \b LowerKey permite realizar busquedas del tipo: todo \b Y en 
        \c std::map<LowerKey, ...> donde Y <= X.
    \li \c std::map<LowerKey, ...>.\c lower_bound(X) = buscar el primer elemento
        donde Y <= X para todo Y en \c std::map<LowerKey, ...>.
    \li \c std::map<LowerKey, ...>.\c upper_bound(X) = buscar el primer elemento
        donde Y < X para todo Y en \c std::map<LowerKey, ...>.

*/
template<class V> class LowerKey
{
public:
    V _key; //!< LLave interna de la clase.

    //! Constructor por defecto de la clase;
    LowerKey()
    {
    }

    //! Constructor de la clase para objeto tipo \b V.
    /*!
        \param z : Objeto tipo \b V.
    */
    LowerKey(V z)
    {
        _key = z;
    }

    //! Destructor de la clase.
    ~LowerKey()
    {
    }

    //! Operador < (menor que)
    /*!
        Permite cambiar el sentido de la operacio \b < permitiendo crear
        un arreglo en sentido inverso para \c std::map<LowerKey, ...>.
        \param z : Objeto LowerKey a comparar.
        \return (\c true / \c false) _key > z._key
    */
    bool operator < (LowerKey z) const
    {
        return _key > z._key;
    }


    //! Operador = (igualdad)
    /*!
        \param z : Objeto LowerKey a copiar.
        \return (*this)
    */
    LowerKey operator = (V z)
    {
        _key = z;
        return *this;
    }

};



//! LLave para rango superior.
/*! 
    Esta clase template define una clave o llave de acceso para el rango
    superior de la range_map. El rango superior se implementa en la forma
    \c std::map<UpperKey, ...> y se debe tomar en cuenta los siguientes aspectos:
    \li La clase \b V debe poseer los operadores \b = y \b < definidos.
    \li La clase \b UpperKey permite realizar busquedas del tipo: todo \b Y en 
        \c std::map<UpperKey, ...> donde Y >= X.
    \li \c std::map<UpperKey, ...>.\c lower_bound(X) = buscar el primer elemento
        donde Y >= X para todo Y en \c std::map<UpperKey, ...>.
    \li \c std::map<UpperKey, ...>.\c upper_bound(X) = buscar el primer elemento
        donde Y > X para todo Y en \c std::map<UpperKey, ...>.

*/
template<class V> class UpperKey
{
public:
    V _key; //!< LLave interna de la clase.

    //! Constructor por defecto de la clase;
    UpperKey()
    {
    }

    //! Constructor de la clase para objeto tipo \b V.
    /*!
        \param z : Objeto tipo \b V.
    */
    UpperKey(V z)
    {
        _key = z;
    }

    //! Destructor de la clase.
    ~UpperKey()
    {
    }

    //! Operador < (menor que)
    /*!
        \param z : Objeto UpperKey a comparar.
        \return (\c true / \c false) _key < z._key
    */
    bool operator < (UpperKey z) const
    {
        return _key < z._key;
    }

    //! Operador = (igualdad)
    /*!
        \param z : Objeto UpperKey a copiar.
        \return (*this)
    */
    UpperKey operator = (V z)
    {
        _key = z;
        return *this;
    }

};


//! Arreglo tipo <\b A, \b B, \b C, \b D>.
/*! 
    Esta clase template define un arreglo multiple de tipo <\b A, \b B, \b C, \b D> donde:
    \li \b A = LLave que permite busquedas tipo = (igualdad).
    \li \b B = LLave que permite busquedas tipo > (mayor) o >= (mayor o igual).
    \li \b C = LLave que permite busquedas tipo < (menor) o <= (menor o igual).
    \li \b D = Elemento asociado a la llave multiple.\n
    Ejemplo:\n
    Si se define range_map<int,int,int,int> los siguientes tipos de busqueda son posibles:
    \li buscar \b D donde \b A = 1, 22 >= \b B , 33 <= \b C (1, 22, >=, 33, <=).
    \li buscar \b D donde \b A = 1, 22 >  \b B , 33 <= \b C (1, 22, > , 33, <=).
    \li buscar \b D donde \b A = 1, 22 >= \b B , 33 <  \b C (1, 22, >=, 33, < ).
    \li buscar \b D donde \b A = 1, 22 >  \b B , 33 <  \b C (1, 22, > , 33, < ).\n
    Esta clase ha sido implementada para poder recrear busqudas en memoria y evitar acessos
    a base de datos. Las instrucciones equivalentes en \b SQL a las busquedas anteriores
    serian las siquientes:
    \li \c SELECT \b D \c FROM \b TABLE \c WHERE \b A = 1
        \c AND \b B <= 22 \c AND \b C >= 33.
    \li \c SELECT \b D \c FROM \b TABLE \c WHERE \b A = 1
        \c AND \b B < 22 \c AND \b C >= 33.
    \li \c SELECT \b D \c FROM \b TABLE \c WHERE \b A = 1
        \c AND \b B <= 22 \c AND \b C > 33.
    \li \c SELECT \b D \c FROM \b TABLE \c WHERE \b A = 1
        \c AND \b B < 22 \c AND \b C > 33.\n
    Este arreglo se ha basado en la creacion de una estructura de tres (3) \c std::map anidados de la
    siguiente forma:
    \li <map<A, map<B, map<C, D>>>

*/
template <class V, class W, class X, class Z> class range_map
{
public:

    //! Definicion de tipo para el rango superior (X).
    typedef UpperKey<X> UpperBound;

    //! Definicion de tipo para el tercer \c std::map. Corresponde a: <map<A, map<B, \b map <C, D>>>
    typedef std::map<UpperBound, Z> Third_MAP;

    //! Definicion de tipo para el rango inferior (W).
    typedef LowerKey<W> LowerBound;

    //! Definicion de tipo para el segundo \c std::map. Corresponde a: <map<A, \b map <B, map<C, D>>>
    typedef std::map<LowerBound, Third_MAP> Second_MAP;

    //! Definicion de tipo para el primer \c std::map. Corresponde a: <\b map <A, map<B, map<C, D>>>
    typedef std::map<V, Second_MAP> First_MAP;

private:
    //! Miembro principal arreglo <map<A, map<B, map<C, D>>>
    First_MAP _firstMap;

public:

    //! Iterador sobre registros en range_map
    /*! Esta clase permite la creacion de un iterador para recorrer el arreglo de la range_map
        de manera secuencial. 
    */
    class rows_iterator
    {
    public:
        V first;    //!< Primer miembro del elemento apuntado por el itreador <\b A, B, C, D>.
        W second;   //!< Segundo miembro del elemento apuntado por el itreador <A, \b B, C, D>.
        X third;    //!< Tercer miembro del elemento apuntado por el itreador <A, B, \b C, D>.
        Z fourth;   //!< Cuarto miembro del elemento apuntado por el itreador <A, B, C, \b D>.
        bool _eof;  //!< Indicador de fin de arreglo.

        //! Constructor de la clase.
        rows_iterator()
        {
            _eof = true;
        }

        //! Este metodo inicializa el estado del iterador.
        /*!
            Este metodo es utilizado para establecer la asociacion entre una instancia de la clase
            y el primer registro de un arreglo range_map.
            \param map1 : Apunta al miembro principal de un arreglo range_map.
            \param map2 : Apunta al rango inferior de un arreglo range_map.
            \param map3 : Apunta al rango superior de un arreglo range_map.
            \param itr1 : Iterador sobre el miembro principal de un arreglo range_map.
            \param itr2 : Iterador sobre el rango inferior de un arreglo range_map.
            \param itr2 : Iterador sobre el rango superior de un arreglo range_map.
            \sa First_MAP, Second_MAP y Third_MAP.

        */
        void set(   First_MAP* map1,
                    Second_MAP* map2,
                    Third_MAP* map3,
                    const typename First_MAP::iterator itr1, 
                    const typename Second_MAP::iterator itr2, 
                    const typename Third_MAP::iterator itr3)
        {
            _firstMapPtr  = map1;
            _secondMapPtr = map2;
            _thirdMapPtr  = map3;
            _firstItr  = itr1;
            _secondItr = itr2;
            _thirdItr  = itr3;

            first  = (V)_firstItr->first;
            second = (W)_secondItr->first._key;
            third  = (X)_thirdItr->first._key;
            fourth = _thirdItr->second;
            _eof = false;
        }

        //! Operador de comparacion.
        bool operator == (rows_iterator z)
        {
            return (_eof == z._eof);
        }

        //! Operador diferencia.
        bool operator != (rows_iterator z)
        {
            return (_eof != z._eof);
        }


        //! Operador de navegacion entre registros.
        rows_iterator& operator ++ (int z)
        {
            if(_eof) return *this;

            int i = 0;
            do
            {
                if(goToNextInThirdMap()) continue;

                if(goToNextInSecondMap()) continue;

                if(goToNextInFirstMap()) continue;

                _eof = true;

                break;
            }while(++i<z);

            return *this;
        }


    private:
        First_MAP*  _firstMapPtr;   //!< Puntero a arreglo principal de range_map. Corresponde a: <\b map <A, map<B, map<C, D>>>
        Second_MAP* _secondMapPtr;  //!< Puntero al rango inferior de range_map. Corresponde a: <map <A, \b map <B, map<C, D>>>
        Third_MAP*  _thirdMapPtr;   //!< Puntero al rango superior de range_map. Corresponde a: <map<A, map<B, \b map <C, D>>>

        typename First_MAP::iterator  _firstItr;    //!< Iterador sobre arreglo principal de range_map. Corresponde a: <\b map <A, map<B, map<C, D>>>
        typename Second_MAP::iterator _secondItr;   //!< Iterador sobre rango inferior de range_map. Corresponde a: <map <A, \b map <B, map<C, D>>>
        typename Third_MAP::iterator  _thirdItr;    //!< Iterador sobre rango superior de range_map. Corresponde a: <map<A, map<B, \b map <C, D>>>

        //! Carga valores para el rango superior de la range_map asociada. Corresponde a: <map<A, map<B, \b map <C, D>>>
        /*!
            Carga los valores para: third = \b C y fourth = \b D .
            \return \c true.
            \sa third, fourth .
        */
        bool chargeThirdValues()
        {
            third  = (X)_thirdItr->first._key;
            fourth = _thirdItr->second;
            _eof = false;
            return true;
        }

        //! Carga valores para el rango inferior de la range_map asociada. Corresponde a: <map <A, \b map <B, map<C, D>>>
        /*!
            Carga el valor de second = \b B .
            \return \c false si no existen registros asociados al rango superior map<C,D> apuntado por \b B .
            \sa second .
        */
        bool chargeSecondValues()
        {
            second = (W)_secondItr->first._key;
            _thirdMapPtr = &_secondItr->second;
            _thirdItr = _thirdMapPtr->begin();
            if(_thirdItr == _thirdMapPtr->end()) return false;
            return chargeThirdValues();
        }

        //! Carga valores para el primer arreglo de la range_map asociada. . Corresponde a: <\b map <A, map<B, map<C, D>>>
        /*!
            Carga el valor de first = \b A .
            \return \c false si no existen registros asociados al rango inferior map<B, ...> apuntado por \b A .
            \sa first .
        */
        bool chargeFirstValues()
        {
            first = (V)_firstItr->first;
            _secondMapPtr = &_firstItr->second;
            _secondItr = _secondMapPtr->begin();
            if(_secondItr == _secondMapPtr->end()) return false;
            return chargeSecondValues();
        }

        //! Mueve iterador en el rango superior a la proxima posicion < \b C, ...>.
        /*!
            \return \c false si se llego al fin del arreglo en el rango superior map<C, ...>.
        */
        bool goToNextInThirdMap()
        {
            if(_thirdItr != _thirdMapPtr->end())
            {
                _thirdItr++;
            }

            if(_thirdItr != _thirdMapPtr->end())
            {
                return chargeThirdValues();
            }
            return false;
        }

        //! Mueve iterador en el rango inferior a la proxima posicion < \b B, ...>..
        /*!
            \return \c false si se llego al fin del arreglo en el rango inferior. map<B, ...>
        */
        bool goToNextInSecondMap()
        {
            if(_secondItr != _secondMapPtr->end())
            {
                _secondItr++;
            }

            if(_secondItr != _secondMapPtr->end())
            {
                if(!chargeSecondValues())
                {
                    return goToNextInSecondMap();
                }
                return true;
            }

            return false;
        }

        //! Mueve iterador en el arreglo principal de range_map < \b A, ...>..
        /*!
            \return \c false si se llego al fin del arreglo de la range_map asociada al iterador.
        */
        bool goToNextInFirstMap()
        {
            if(_firstItr != _firstMapPtr->end())
            {
                _firstItr++;
            }

            if(_firstItr != _firstMapPtr->end())
            {
                if(!chargeFirstValues())
                {
                    return goToNextInFirstMap();
                }

                return true;
            }

            return false;
        }
    };


    //! Ir a primera posicion en el arreglo range_map.
    /*!
        Este metodo coloca un iterador en la primera posicion del arreglo rang_map.\n
        El siguiente ejemplo muestra la utilizacion de este metodo:\n
        \n
        rows_iterator a;\n
        range_map<int,int,int,int> b;\n
        \n
        for(a = b.begin(); a != b.end(); a++)\n
        {\n
            cout << a.first << a.second << a.third << a.fouth;\n
        }\n
        \n
        \return Iterador (range_map::rows_iterator) sobre la primera posicion del arreglo range_map.
    */
    rows_iterator begin()
    {
        rows_iterator itr;

        First_MAP*  firstMapPtr;
        Second_MAP* secondMapPtr;
        Third_MAP*  thirdMapPtr;

        typename First_MAP::iterator  firstItr;
        typename Second_MAP::iterator secondItr;
        typename Third_MAP::iterator  thirdItr;

        firstMapPtr = &_firstMap;

        firstItr = firstMapPtr->begin();

        if(firstItr == firstMapPtr->end())
        {
            return itr;
        }

        secondMapPtr = &firstItr->second;

        secondItr = secondMapPtr->begin();

        if(secondItr == secondMapPtr->end())
        {
            return itr;
        }

        thirdMapPtr = &secondItr->second;

        thirdItr = thirdMapPtr->begin();

        if(thirdItr == thirdMapPtr->end())
        {
            return itr;
        }

        itr.set(firstMapPtr, secondMapPtr, thirdMapPtr, firstItr, secondItr, thirdItr);

        return itr;
    }

    //! Ir al final del arreglo range_map.
    /*!
        Este metodo coloca un iterador en una posicion EOF (fin) del arreglo rang_map.
        \return Iterador (range_map::rows_iterator) sobre posicion EOF del arreglo range_map.
        \sa begin().
    */
    rows_iterator end()
    {
        rows_iterator itr;
        return itr;
    }



    //! Iterador de seleccion.
    /*! Esta clase permite la navegacion y busqueda de registros dentro del arreglo range_map.
        Un crierio de busqueda puede ser especificado y el iterador apuntara al primer registro
        del conjunto de registros que cumplen con el criterio de busqueda. El oprador ++ permite
        pasar de un registro al otro de la seleccion. Lo siguiente es un ejemplo de busqueda y
        navegacion dentro de la range_map:\n
        \n
        select_iterator a;\n
        range_map<int,int,int,int> b;\n
        \n
        a = b.select(1, 22, GQ, 33, LQ);\n
        \n
        for(; a != b.end_select(); a++)\n
        {\n
            cout << a.first << a.second << a.third << a.fouth;\n
        }\n
    */
    class select_iterator
    {
    public:
        V first;    //!< Primer miembro del elemento apuntado por el itreador <\b A, B, C, D>.
        W second;   //!< Segundo miembro del elemento apuntado por el itreador <A, \b B, C, D>.
        X third;    //!< Tercer miembro del elemento apuntado por el itreador <A, B, \b C, D>.
        Z fourth;   //!< Cuarto miembro del elemento apuntado por el itreador <A, B, C, \b D>.
        bool _eof;  //!< Indicador de fin de arreglo.
    private:
        First_MAP*  _firstMapPtr;   //!< Puntero a arreglo principal de range_map. Corresponde a: <\b map <A, map<B, map<C, D>>>
        Second_MAP* _secondMapPtr;  //!< Puntero al rango inferior de range_map. Corresponde a: <map <A, \b map <B, map<C, D>>>
        Third_MAP*  _thirdMapPtr;   //!< Puntero al rango superior de range_map. Corresponde a: <map<A, map<B, \b map <C, D>>>

        typename First_MAP::iterator  _firstItr;    //!< Iterador sobre arreglo principal de range_map. Corresponde a: <\b map <A, map<B, map<C, D>>>
        typename Second_MAP::iterator _secondItr;   //!< Iterador sobre rango inferior de range_map. Corresponde a: <map <A, \b map <B, map<C, D>>>
        typename Third_MAP::iterator  _thirdItr;    //!< Iterador sobre rango superior de range_map. Corresponde a: <map<A, map<B, \b map <C, D>>>

        V _keySearchCriteria;               //!< Criterio de Busqueda para primer elemento: <\b A, B, C, D>.
        LowerBound _lowerSearchCriteria;    //!< Criterio de Busqueda para segundo elemento: <A, \b B, C, D> (rango inferior).
        UpperBound _upperSearchCriteria;    //!< Criterio de Busqueda para tercer elemento: <A, B, \b C, D> (rango superior).
        LOWER_BOUND_FILTER_TYPE _lowerFilter;   //!< Tipo Criterio de busqueda (> / >=) para rango inferior: <A, \b B, C, D>.
        UPPER_BOUND_FILTER_TYPE _upperFilter;   //!< Tipo Criterio de busqueda (< / <=) para rango superior: <A, B, \b C, D>.


    public:

        //! Constructor de la clase.
        select_iterator()
        {
            clear();
        }

        //! Este metodo inicializa el estado del iterador.
        /*!
            Este metodo es utilizado para establecer la asociacion entre una instancia de la clase
            y el primer registro de un arreglo range_map.
            \param map1             : Apunta al miembro principal de un arreglo range_map.
            \param searchCriteria   : Criterio para el primer elemento del arreglo (=) <\b A, B, C, D>.
            \param lower            : Criterio para el segundo elemento del arreglo (rango inferior) <A, \b B, C, D>.
            \param lowerFilter      : Tipo Criterio de busqueda (> / >=) para rango inferior: <A, \b B, C, D>.
            \param upper            : Criterio para el tercer elemento del arreglo (rango superior) <A, B, \b C, D>.
            \param upperFilter      : Tipo Criterio de busqueda (< / <=) para rango superior: <A, B, \b C, D>.
            \sa _keySearchCriteria, _lowerSearchCriteria,
                _upperSearchCriteria, _lowerFilter, _upperFilter,
                LOWER_BOUND_FILTER_TYPE, y UPPER_BOUND_FILTER_TYPE.
        */
        void set(   First_MAP* map1,
                    const V searchCriteria,
                    const W lower,
                    LOWER_BOUND_FILTER_TYPE lowerFilter,
                    const X upper,
                    UPPER_BOUND_FILTER_TYPE upperFilter)
        {
            _firstMapPtr  = map1;

            _keySearchCriteria = (V)searchCriteria;
            _lowerSearchCriteria = (W)lower;
            _upperSearchCriteria = (X)upper;
            _lowerFilter = lowerFilter;
            _upperFilter = upperFilter;

            if(!goToFirstInFirstMap())
            {
                clear();
                return;
            }

            if(!goToFirstInSecondMap())
            {
                clear();
                return;
            }

            if(!goToFirstInThirdMap())
            {
                if(!goToNextInSecondMap())
                {
                    clear();
                    return;
                }
            }
            
            _eof = false;

            return;
        }

        //! Operador == (comparacion igualdad)
        /*!
            Permite operaciones de tipo :\n
            \b A == \b B.\n
            Donde:\n
            \b A es select_iterator.\n
            \b B es select_iterator.\n
            \return \c true : si \b A y \b B estan en EOF. o  \b A y \b B no estan en EOF.
        */
        bool operator == (select_iterator z)
        {
            return (_eof == z._eof);
        }


        //! Operador == (comparacion diferencia)
        /*!
            Permite operaciones de tipo :\n
            \b A <> \b B.\n
            Donde:\n
            \b A es select_iterator.\n
            \b B es select_iterator.\n
            \return \c true : si \b A esta en EOF y \b B no estan en EOF.
        */
        bool operator != (select_iterator z)
        {
            return (_eof != z._eof);
        }

        //! Operador ++ (navegacion entre registros)
        /*!
            Permite operaciones de tipo :\n
            \b A ++.\n
            \b A ++ \b N.\n
            Donde:\n
            \b A es select_iterator.\n
            \b N es \c int.
            \param z : \c int Entero que indica el numero de posiciones a avanzar el iterador.
            \return \c *this : select_iterator \b A.
        */
        select_iterator& operator ++ (int z)
        {
            if(_eof) return *this;

            int i = 0;
            do
            {
                if(goToNextInThirdMap()) continue;

                if(goToNextInSecondMap()) continue;

                //if(goToNextInFirstMap()) continue;

                _eof = true;

                break;
            }while(++i<z);

            return *this;
        }


    private:

        //! Coloca el iterador en estado EOF.
        void clear()
        {
            _eof = true;
        }

        //! Carga valores para el rango superior de la range_map asociada. Corresponde a: <map<A, map<B, \b map <C, D>>>
        /*!
            Carga los valores para: third = \b C y fourth = \b D .
            \return \c true.
            \sa third, fourth .
        */
        bool chargeThirdValues()
        {
            third  = (X)_thirdItr->first._key;
            fourth = _thirdItr->second;
            _eof = false;
            return true;
        }

        //! Carga valores para el rango inferior de la range_map asociada. Corresponde a: <map <A, \b map <B, map<C, D>>>
        /*!
            Carga el valor de second = \b B .
            \return \c false si no existen registros asociados al rango superior map<C,D> apuntado por \b B .
            \sa second .
        */
        bool chargeSecondValues()
        {
            second = (W)_secondItr->first._key;
            _thirdMapPtr = &_secondItr->second;

            if(_upperFilter == LE)
            {
                if((_thirdItr = _thirdMapPtr->upper_bound(_upperSearchCriteria)) == _thirdMapPtr->end()) return false;
            }
            else
            {
                if((_thirdItr = _thirdMapPtr->lower_bound(_upperSearchCriteria)) == _thirdMapPtr->end()) return false;
            }

            //_thirdItr = _thirdMapPtr->begin();
            //if(_thirdItr == _thirdMapPtr->end()) return false;
            return chargeThirdValues();
        }

        //! Carga valores para el primer arreglo de la range_map asociada. . Corresponde a: <\b map <A, map<B, map<C, D>>>
        /*!
            Carga el valor de first = \b A .
            \return \c false si no existen registros asociados al rango inferior map<B, ...> apuntado por \b A .
            \sa first .
        */
        bool chargeFirstValues()
        {
            first = _firstItr->first;
            _secondMapPtr = &_firstItr->second;

            if(_lowerFilter == GR)
            {
                if((_secondItr = _secondMapPtr->upper_bound(_lowerSearchCriteria)) == _secondMapPtr->end()) return false;
            }
            else
            {
                if((_secondItr = _secondMapPtr->lower_bound(_lowerSearchCriteria)) == _secondMapPtr->end()) return false;
            }

            //_secondItr = _secondMapPtr->begin();
            //if(_secondItr == _secondMapPtr->end()) return false;
            return chargeSecondValues();
        }


        //! Mueve iterador en el rango superior a la proxima posicion < \b C, ...>.
        /*!
            \return \c false si se llego al fin del arreglo en el rango superior map<C, ...>.
        */
        bool goToNextInThirdMap()
        {
            if(_thirdItr != _thirdMapPtr->end())
            {
                _thirdItr++;
            }

            if(_thirdItr != _thirdMapPtr->end())
            {
                return chargeThirdValues();
            }
            return false;
        }


        //! Mueve iterador en el rango inferior a la proxima posicion < \b B, ...>..
        /*!
            \return \c false si se llego al fin del arreglo en el rango inferior. map<B, ...>
        */
        bool goToNextInSecondMap()
        {
            if(_secondItr != _secondMapPtr->end())
            {
                _secondItr++;
            }

            if(_secondItr != _secondMapPtr->end())
            {
                if(!chargeSecondValues())
                {
                    return goToNextInSecondMap();
                }
                return true;
            }

            return false;
        }


        //! Mueve iterador en el arreglo principal de range_map < \b A, ...>..
        /*!
            \return \c false si se llego al fin del arreglo de la range_map asociada al iterador.
        */
        bool goToNextInFirstMap()
        {
            if(_firstItr != _firstMapPtr->end())
            {
                _firstItr++;
            }

            if(_firstItr != _firstMapPtr->end())
            {
                if(!chargeFirstValues())
                {
                    return goToNextInFirstMap();
                }

                return true;
            }

            return false;
        }

        //! Mueve el iterador a la primera posicion del rango superior. Corresponde a: <map<A, map<B, \b map <C, D>>>
        /*!
            Mueve el iterador segun el criterio definido por _upperSearchCriteria.
            Carga los valores para: third = \b C y fourth = \b D .
            \return \c false si no existen registros en map<C, D>.
            \sa third, fourth, _upperSearchCriteria.
        */
        bool goToFirstInThirdMap()
        {
            if(_upperFilter == LE)
            {
                if((_thirdItr = _thirdMapPtr->upper_bound(_upperSearchCriteria)) == _thirdMapPtr->end()) return false;
            }
            else
            {
                if((_thirdItr = _thirdMapPtr->lower_bound(_upperSearchCriteria)) == _thirdMapPtr->end()) return false;
            }

            third = (X)_thirdItr->first._key;
            fourth = _thirdItr->second;
            return true;
        }

        //! Mueve el iterador a la primera posicion del rango inferior. Corresponde a: <map <A, \b map <B, map<C, D>>>
        /*!
            Mueve el iterador segun el criterio definido por _lowerSearchCriteria.
            Carga el valor de: second = \b B .
            \return \c false si no existen registros en map<B, ...>.
            \sa second, _lowerSearchCriteria.
        */
        bool goToFirstInSecondMap()
        {
            if(_lowerFilter == GR)
            {
                if((_secondItr = _secondMapPtr->upper_bound(_lowerSearchCriteria)) == _secondMapPtr->end()) return false;
            }
            else
            {
                if((_secondItr = _secondMapPtr->lower_bound(_lowerSearchCriteria)) == _secondMapPtr->end()) return false;
            }

            second = (W)_secondItr->first._key;
            _thirdMapPtr = &_secondItr->second;
            return true;
        }

        //! Mueve el iterador a la primera posicion del arreglo principal de la range_map. Corresponde a: <\b map <A, map<B, map<C, D>>>
        /*!
            Mueve el iterador segun el criterio definido por _keySearchCriteria.
            Carga el valor de: first = \b A .
            \return \c false si no existen registros en map<A, ...>.
            \sa first, _keySearchCriteria.
        */
        bool goToFirstInFirstMap()
        {
            if((_firstItr = _firstMapPtr->find(_keySearchCriteria)) == _firstMapPtr->end()) return false;
            first = (V)_firstItr->first;
            _secondMapPtr = &_firstItr->second;
            return true;
        }
    };


    //! Selecciona una coleccion de registros
    /*!
        Este metodo se utiliza para selecccionar un conjunto de registros dentro de la range_map
        y para los criterios pasados en argumento EX: select where A = V and B >= W and C <= X ... (A,B,>=,C,<=).
        \param first        : Criterio para el primer elemento del arreglo (=) <\b A, B, C, D>.
        \param lower        : Criterio para el segundo elemento del arreglo (rango inferior) <A, \b B, C, D>.
        \param lowerFilter  : Tipo Criterio de busqueda (> / >=) para rango inferior: <A, \b B, C, D>.
        \param upper        : Criterio para el tercer elemento del arreglo (rango superior) <A, B, \b C, D>.
        \param upperFilter  : Tipo Criterio de busqueda (< / <=) para rango superior: <A, B, \b C, D>.
        \return Iterador select_iterator apuntando al primer registros de la coleccion o EOF si la coleccion esta vacia.
    */
    select_iterator select( const V first,
                            const W lower,
                            LOWER_BOUND_FILTER_TYPE lowerFilter,
                            const X upper,
                            UPPER_BOUND_FILTER_TYPE upperFilter)
    {
        select_iterator itr;

        itr.set(&_firstMap, first, lower, lowerFilter, upper, upperFilter);

        return itr;
    }


    //! Fin de coleccion.
    /*!
        \return Iterador select_iterator apuntando a EOF.
    */
    select_iterator end_select()
    {
        select_iterator itr;
        return itr;
    }





    //! Busqueda de registros en range_map
    /*!
        Este metodo es utilizado para validar si un registro existe dentro de la range_map.
        \param first  :Criterio para el primer elemento del arreglo (=) <\b A, B, C, D>.
        \param second :Criterio para el segundo elemento del arreglo (rango inferior) <A, \b B, C, D>.
        \param third  :Criterio para el tercer elemento del arreglo (rango superior) <A, B, \b C, D>.
        \return \c true si el registro existe dentro de la range_map, \c false sino es encontrado.
    */
    bool find(V first, W second, X third)
    {
        typename First_MAP::iterator  firstItr;
        firstItr = _firstMap.find(first);
        if(firstItr == _firstMap.end()) return false;

        typename Second_MAP::iterator secondItr;
        LowerBound lower(second);
        secondItr = (firstItr->second).find(lower);
        if(secondItr == (firstItr->second).end()) return false;

        typename Third_MAP::iterator  thirdItr;
        UpperBound upper(third);
        thirdItr = (secondItr->second).find(upper);
        if(thirdItr == (secondItr->second).end()) return false;

        return true;
    }


    //! Insertar registros en range_map
    /*!
        Este metodo es utilizado para insertar registros dentro de la rang_map.
        \param first  :Primer elemento del arreglo (llave) <\b A, B, C, D>.
        \param second :Segundo elemento del arreglo (rango inferior) <A, \b B, C, D>.
        \param third  :Tercer elemento del arreglo (rango superior) <A, B, \b C, D>.
        \param fourth :Cuarto elemento del arreglo <A, B, C, \b D >.
    */
    void insert(V first, W second, X third, Z fourth)
    {
        (((_firstMap[first])[second])[third]) = fourth;
    }


    //! Insertar registros en range_map
    /*!
        Este metodo es utilizado para insertar registros dentro de la rang_map.
        \param first  :Primer elemento del arreglo (llave) <\b A, B, C, D>.
        \param second :Segundo elemento del arreglo (rango inferior) <A, \b B, C, D>.
        \param third  :Tercer elemento del arreglo (rango superior) <A, B, \b C, D>.
        \return fourth :Cuarto elemento del arreglo <A, B, C, \b D >.
    */
    Z& insert(V first, W second, X third)
    {
        return (((_firstMap[first])[second])[third]);
    }

    //! Elimina todos los registros de la range_map.
    void clear()
    {
        _firstMap.clear();
    }


};







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


