#ifndef NO_INDENT
#ident "@(#)$RCSfile: record_fetcher.cpp,v $ $Revision: 1.5 $ $Date: 2008/08/02 19:29:11 $"
#endif

///
/// \file record_fetcher.cpp
///



#include "record_fetcher.h"



RecordFetcher::RecordFetcher()
{
    _clientePadre = NULL;
    _buffer1.clear();
    _dbData = NULL;
    _pendingRecords = false;
    _currentAbonado = 0;
    _currentClienteHijo = -1;
    _log = NULL;
    _numJob = -1;
}


RecordFetcher::~RecordFetcher()
{
}


void RecordFetcher::clear()
{
    _clientePadre = NULL;
    _buffer1.clear();
    _pendingRecords = false;
    _currentAbonado = 0;
    _currentClienteHijo = -1;
    _log = NULL;
    _numJob = -1;
}

void RecordFetcher::init(DataService* dbData)
{
    _dbData = dbData;
}



void RecordFetcher::prepare(ClienteLocutorioPadre* clientePadre,
                            const STRING16& fecEmision,
                            const int numJob)
{
    _clientePadre = clientePadre;
    _fecEmision = fecEmision;
    _numJob = numJob;
}


BufferTOL_ACUMOPER_TO* RecordFetcher::getChargedBuffer(LogBuffer* log)
{
    if(log == NULL)
    {
        STRING1000 errorMsg;
        errorMsg << "LOG NO INICIALIZADO EN (RecordFetcher)." << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    _log = log;

    execute();
    return &_buffer1;
}



void RecordFetcher::execute()
{
    _buffer1.clear();

    if(_pendingRecords)
    {
        if(!insertRecords())
        {
            // Indica que se ha llenado el buffer
            return;
        }
        // Indica que se ha terminado el cursor de registros pendientes
        _currentAbonado++;
    }

    if(_currentClienteHijo < 0)
    {
        for(_currentAbonado; _currentAbonado < _clientePadre->ABONADOS.getNumOfRecords(); _currentAbonado++)
        {
            if(!chargeFromCliente(_clientePadre->COD_CLIENTE,
                                  _clientePadre->ABONADOS[_currentAbonado],
                                  _fecEmision)) return; // Se ha llenado el buffer con registros
            // Se continua llenando el Buffer
            // con registros del proximo abonado
        }

        // Se ha terminado la lista de abonados
        _currentClienteHijo = 0;
        _currentAbonado = 0;
    }

    for(_currentClienteHijo; _currentClienteHijo < _clientePadre->HIJOS.getNumOfRecords(); _currentClienteHijo++)
    {
        for(_currentAbonado; _currentAbonado < _clientePadre->HIJOS[_currentClienteHijo].ABONADOS.getNumOfRecords(); _currentAbonado++)
        {
            if(!chargeFromCliente(_clientePadre->HIJOS[_currentClienteHijo].COD_CLIENTE,
                                  _clientePadre->HIJOS[_currentClienteHijo].ABONADOS[_currentAbonado],
                                  _fecEmision)) return; // Se ha llenado el buffer con registros
            // Se continua llenando el Buffer
            // con registros del proximo abonado
        }

        // Se ha terminado la lista de abonados
        _currentAbonado = 0;
    }
}



bool RecordFetcher::chargeFromCliente(const int codCliente, const int numAbonado, const STRING16& fecEmision)
{
    if(_buffer1.isFull()) return false;

    if(_pendingRecords)
    {
        // Se debe vaciar el cursor activo
        if(insertRecords())
        {
            // Indica que se ha terminado el cursor de registros pendientes
            return chargeFromCliente(codCliente, numAbonado, fecEmision);
        }
        // Se ha llenado el buffer con registros
        return false;
    }
    else
    {
        //if((*_log)[9])  // Genera realloc en log
        //{
        //std::cout << INDENT4LOGGER << "@Fecth TOL_ACUMOPER_TO para:" << ENDLLOGGER;
        //std::cout << INDENT5LOGGER << "@[COD_CLIENTE] = [" << codCliente << "@]" << ENDLLOGGER;
        //std::cout << INDENT5LOGGER << "@[NUM_ABONADO] = [" << numAbonado << "@]" << ENDLLOGGER;
        //std::cout << INDENT5LOGGER << "@[FEC_EMISION] = [" << fecEmision << "@]" << ENDLLOGGER;
        //}

        if(_numJob < 0)
        {
            if(!_dbData->open_TOL_ACUMOPER_TO(codCliente, numAbonado, fecEmision.c_str(), IND_FACTURACION_PROC))
            {
                //if((*_log)[9])
                //// Se indica que se puede continuar ingresando registros
                return true;
            }
        }
        else
        {
            if(!_dbData->open_TOL_ACUMOPER_TO(codCliente, numAbonado, fecEmision.c_str(), IND_FACTURACION_PROC_JOB))
            {
                //if((*_log)[9])
                //std::cout << INDENT6LOGGER << "@Sin Registros..." << ENDLLOGGER;
                // Se indica que se puede continuar ingresando registros
                return true;
            }
        }

        //std::cout << INDENT6LOGGER << "@Con Registros..." << ENDLLOGGER;
    }

    if(insertRecords())
    {
        // Indica que se ha terminado el cursor de registros pendientes
        return true;
    }

    // Se ha llenado el buffer con registros
    return false;
}

bool RecordFetcher::insertRecords()
{
    RECORD_TOL_ACUMOPER_TO_DTO* record = NULL;

    record = _dbData->fetch_TOL_ACUMOPER_TO();

    if(record == NULL)
    {
        // Se ha agotado los registros del cursor
        _pendingRecords = false;

        // Se indica que se puede continuar ingresando registros
        // para pasar al siguiente registro sin importar si el
        // buffer esta lleno
        return true;
    }

    do
    {
        if(_buffer1.isFull())
        {
            // Se indica que existen registros pendientes
            _pendingRecords = true;
            // Se indica que no se puede seguir ingresando registros
            return false;
        }

        _buffer1.push(*record);

        if(_buffer1.isFull())
        {
            // Se indica que existen registros pendientes
            _pendingRecords = true;
            // Se indica que no se puede seguir ingresando registros
            return false;
        }
    }
    while((record = _dbData->fetch_TOL_ACUMOPER_TO()) != NULL);

    // Se ha agotado los registros del cursor
    _pendingRecords = false;

    // Se indica que se puede continuar ingresando registros
    // para pasar al siguiente registro sin importar si el
    // buffer esta lleno
    return true;
}







