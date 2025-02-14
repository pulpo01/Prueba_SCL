#ifndef NO_INDENT
#ident "@(#)$RCSfile: simple_container_interface.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

///
/// \file simple_container_interface.h
///


#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef SIMPLE_CONTAINER_INTERFACE_H
#define SIMPLE_CONTAINER_INTERFACE_H

#include <set>
#include <map>
#include "process_core_exception.h"

template < class  Key, class Record>
class SimpleMapInterface
{
public:
    SimpleMapInterface(){ clear(); };

    ~SimpleMapInterface(){};

    void clear(){ _records.clear(); };

    void push_back(Key& k, Record& r)
    {
        typename TableRecords::iterator itr;
        itr = _records.find(k);
        if(itr != _records.end()) return;

        _records[k] = r;
    };

    int getNumOfRecords(){ return _records.size(); };

    Record& operator[] (int index)
    {
        if(index < 0 || index >= static_cast<int>(_records.size()))
        {
            STRING1000 errorMsg;
            errorMsg << "ERROR LOGICO, [index] FUERA DE RANGO EN (SimpleMapInterface)" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }
        
        typename TableRecords::iterator itr;
        itr = _records.begin();
        int i = 0;
        while(i++ < index) itr++;

        return itr->second;
    };

    Record* find(Key& k)
    {
        typename TableRecords::iterator itr;
        itr = _records.find(k);
        if(itr == _records.end()) return NULL;

        return &(itr->second);
    };
private:
    typedef typename std::map<Key, Record> TableRecords;
    TableRecords _records;
};


template < class  Key>
class SimpleSetInterface
{
public:
    SimpleSetInterface(){ clear(); };

    ~SimpleSetInterface(){};

    void clear(){ _records.clear(); };

    void push_back(Key& k)
    {
        typename SetOfRecords::iterator itr;
        itr = _records.find(k);
        if(itr != _records.end()) return;

        _records.insert(k);
    };

    int getNumOfRecords(){ return _records.size(); };

    Key& operator[] (int index)
    {
        if(index < 0 || index >= static_cast<int>(_records.size()))
        {
            STRING1000 errorMsg;
            errorMsg << "ERROR LOGICO, [index] FUERA DE RANGO EN (SimpleSetInterface)" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }
        
        typename SetOfRecords::iterator itr;
        itr = _records.begin();
        int i = 0;
        while(i++ < index) itr++;

        return (const_cast<Key&>(*itr));
    };

    bool find(Key& k)
    {
        typename SetOfRecords::iterator itr;
        itr = _records.find(k);
        return (itr != _records.end());
    };

private:
    typedef typename std::set<Key> SetOfRecords;
    SetOfRecords _records;
};




#endif // SIMPLE_CONTAINER_INTERFACE_H

