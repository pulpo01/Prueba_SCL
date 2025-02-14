#ifndef NO_INDENT
#ident "@(#)$RCSfile: record_fetcher.h,v $ $Revision: 1.5 $ $Date: 2008/06/16 18:29:00 $"
#endif

///
/// \file record_fetcher.h
///


#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef RECORD_FETCHER_H
#define RECORD_FETCHER_H

#include "LogBuffer.h"
#include "data_service.h"
#include "cliente_locutorio.h"

template <class T, int SIZE>
class FixedSizeRecordBuffer
{
public:
    FixedSizeRecordBuffer()
    {
        T t;
        int i;
        for(i = 0; i <= SIZE; i++)
        {
            _records.push_back(t);
        }
        _maxPos = SIZE-1;
        _lastPosFree = 0;
    };

    ~FixedSizeRecordBuffer()
    {
        _records.clear();
    };

    void clear()
    {
        _lastPosFree = 0;
    };

    bool push(const T& t)
    {
        if(isFull()) return false;
        _records[_lastPosFree] = t;
        _lastPosFree++;
        return true;
    };

    bool isFull()
    {
        if(_lastPosFree < 0) return true;
        if(_lastPosFree == _maxPos)
        {
            return true;
        }
        return false;
    };

    int size()
    {
        return _lastPosFree;
    };

    T& operator[](int pos)
    {
        if(pos < 0 || pos >= _lastPosFree)
        {
            STRING1000 errorMsg;
            errorMsg << "ERROR LOGICO, pos FUERA DE RANGO en (FixedSizeRecordBuffer)" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }
        return _records[pos];
    };

private:
    typedef std::vector<T> InnerVector;
    InnerVector     _records;
    int             _recordsInVector;
    int             _lastPosFree;
    int             _maxPos;
};





template <class T, int SIZE>
class VariableSizeRecordBuffer
{
public:
    VariableSizeRecordBuffer()
    {
        appendRecords();
        _lastPosUsed = -1;
    };

    ~VariableSizeRecordBuffer()
    {
        _records.clear();
    };

    void clear()
    {
        _lastPosUsed = -1;
    };

    void push(const T& t)
    {
        if(_lastPosUsed == _records.size() - 1)
            appendRecords();

        _lastPosUsed++;
        _records[_lastPosUsed] = t;
        return;
    };

    int size()
    {
        return (_lastPosUsed + 1);
    };

    T& operator[](int pos)
    {
        if(pos < 0 || pos > _lastPosUsed)
        {
            STRING1000 errorMsg;
            errorMsg << "ERROR LOGICO, pos FUERA DE RANGO en (VariableSizeRecordBuffer)" << ENDL;
            throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
        }
        return _records[pos];
    };

private:

    void appendRecords()
    {
        T t;
        int i;
        for(i = 0; i < SIZE; i++)
        {
            _records.push_back(t);
        }
    };

    typedef std::vector<T> InnerVector;
    InnerVector     _records;
    int             _lastPosUsed;
};





typedef FixedSizeRecordBuffer<RECORD_TOL_ACUMOPER_TO_DTO, 5000> BufferTOL_ACUMOPER_TO;

class RecordFetcher
{
public:
    RecordFetcher();
    ~RecordFetcher();
    void clear();
    void init(DataService* dbData);
    void prepare(ClienteLocutorioPadre* clientePadre,
                 const STRING16& fecEmision,
                 const int numJob);
    BufferTOL_ACUMOPER_TO* getChargedBuffer(LogBuffer* log);
private:

    DataService*            _dbData;
    ClienteLocutorioPadre*  _clientePadre;
    STRING16                _fecEmision;
    bool                    _pendingRecords;
    BufferTOL_ACUMOPER_TO   _buffer1;
    int                     _currentAbonado;
    int                     _currentClienteHijo;
    LogBuffer*              _log;
    int                     _numJob;
    void execute();
    bool chargeFromCliente(const int codCliente, const int numAbonado, const STRING16& fecEmision);
    bool insertRecords();
};






#endif RECORD_FETCHER_H




