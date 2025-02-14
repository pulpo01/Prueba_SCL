#ifndef NO_INDENT
#ident "@(#)$RCSfile: eval_discount_matrix.cpp,v $ $Revision: 1.6 $ $Date: 2008/06/03 19:48:43 $"
#endif

///
/// \file eval_discount_matrix.cpp
///


/*
 *  eval_discount_matrix.cpp
 *  dctosLoc
 *
 *  Created by Hector Maldonado on 5/4/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#include "eval_discount_matrix.h"

//////////////////////////////////////////////////////////////////////////////////////////
AcumCuadrantePlan::AcumCuadrantePlan()
{
    _idCuadrante = -1;
    _valDctoReman = NULL;
    _dctoAcum = 0;
    _tipoDcto.clear();
}



AcumCuadrantePlan::AcumCuadrantePlan(const int idCuadra, DECIMAL_NUMBER* valDcto, const STRING16& tipDcto)
{
    set(idCuadra, valDcto, tipDcto);
}


AcumCuadrantePlan::~AcumCuadrantePlan()
{
}


void AcumCuadrantePlan::set(const int idCuadra, DECIMAL_NUMBER* valDcto, const STRING16& tipDcto)
{
    _idCuadrante = idCuadra;
    _valDctoReman = NULL;
    if(valDcto != NULL)
        _valDctoReman = valDcto;
    _dctoAcum = 0;
    _tipoDcto = tipDcto;
}



AcumCuadrantePlan& AcumCuadrantePlan::operator+=(const DECIMAL_NUMBER& rhs)
{
    if(_tipoDcto == "M")
    {
        discountAmount(rhs);
    }
    else if(_tipoDcto == "P")
    {
        discountPercent(rhs);
    }
    else
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, TIPO_DCTO <> M/P en (AcumCuadrantePlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }
    return *this;
}

int AcumCuadrantePlan::getId()
{
    return _idCuadrante;
}

DECIMAL_NUMBER AcumCuadrantePlan::getDctoAcum()
{
    return _dctoAcum;
}


DECIMAL_NUMBER AcumCuadrantePlan::getValDctoReman()
{
    if(_valDctoReman == NULL)
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, VAL_DCTO NO INICIALIZADO en (AcumCuadrantePlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    return *_valDctoReman;
}


DECIMAL_NUMBER* AcumCuadrantePlan::getPValDctoReman()
{
    return _valDctoReman;
}


STRING16 AcumCuadrantePlan::getTipDcto()
{
    return _tipoDcto;
}



void AcumCuadrantePlan::discountAmount(const DECIMAL_NUMBER& importe)
{
    if(_valDctoReman == NULL)
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, VAL_DCTO NO INICIALIZADO en (AcumCuadrantePlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    if(importe < *_valDctoReman)
    {
        _dctoAcum += importe;
        (*_valDctoReman) -= importe;
    }
    else
    {
        _dctoAcum += (*_valDctoReman);
        (*_valDctoReman) = 0;
    }
}


void AcumCuadrantePlan::discountPercent(const DECIMAL_NUMBER& importe)
{
    if(_valDctoReman == NULL)
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, VAL_DCTO NO INICIALIZADO en (AcumCuadrantePlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    _dctoAcum += (importe * ((*_valDctoReman)/100));
}











//////////////////////////////////////////////////////////////////////////////////////////
CuadrantesAplicPlan::CuadrantesAplicPlan()
{
}

CuadrantesAplicPlan::~CuadrantesAplicPlan()
{
}

CuadrantesAplicPlan& CuadrantesAplicPlan::operator+=(DECIMAL_NUMBER& importe)
{
    TableCuadrantes::iterator itr;

    for(itr = _cuadrantes.begin(); itr != _cuadrantes.end(); itr++)
    {
        (itr->second) += importe;
    }

    return *this;
}


bool CuadrantesAplicPlan::push_back(int idCuadrante, 
                                    DECIMAL_NUMBER* valDctoReman, 
                                    const STRING16& tipDcto)
{
    if(valDctoReman == NULL)
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, VAL_DCTO NO INICIALIZADO en (AcumCuadrantePlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    TableCuadrantes::iterator itr;

    itr = _cuadrantes.find(idCuadrante);

    if(itr != _cuadrantes.end()) return false;

    AcumCuadrantePlan newItem(idCuadrante, valDctoReman, tipDcto);

    _cuadrantes[idCuadrante] = newItem;

    return true;
}


void CuadrantesAplicPlan::clear()
{
    _cuadrantes.clear();
}


int CuadrantesAplicPlan::geNumOfCuadrantes()
{
    return _cuadrantes.size();
}


DECIMAL_NUMBER CuadrantesAplicPlan::getDctoAcum(int idCuadrante)
{
    DECIMAL_NUMBER tmpVal = -1;

    TableCuadrantes::iterator itr;

    itr = _cuadrantes.find(idCuadrante);

    if(itr == _cuadrantes.end())
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, VAL_DCTO NO INICIALIZADO en (AcumCuadrantePlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    tmpVal = (itr->second).getDctoAcum();

    return tmpVal;
}


DECIMAL_NUMBER CuadrantesAplicPlan::getValDctoReman(int idCuadrante)
{
    DECIMAL_NUMBER tmpVal = -1;

    TableCuadrantes::iterator itr;

    itr = _cuadrantes.find(idCuadrante);

    if(itr == _cuadrantes.end())
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, NO SE HAN ENCONTRADO CUADRANTE PARA: [idCuadrante] = [" << idCuadrante
                 << "] EN CUADRANTES APLICACION PLAN (CuadrantesAplicPlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    tmpVal = (itr->second).getValDctoReman();

    return tmpVal;
}


STRING16 CuadrantesAplicPlan::getTipDcto(int idCuadrante)
{
    TableCuadrantes::iterator itr;

    itr = _cuadrantes.find(idCuadrante);

    if(itr == _cuadrantes.end())
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, NO SE HAN ENCONTRADO CUADRANTE PARA: [idCuadrante] = [" << idCuadrante
                 << "] EN CUADRANTES APLICACION PLAN (CuadrantesAplicPlan)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    return (itr->second).getTipDcto();
}






//////////////////////////////////////////////////////////////////////////////////////////
AcumConcepto::AcumConcepto()
{
    clear();
}



AcumConcepto::AcumConcepto(const STRING16& concEval, CuadrantesAplicPlan* cApliPlan)
{
    clear();
    set(concEval, cApliPlan);
}



AcumConcepto::~AcumConcepto()
{
}


void AcumConcepto::clear()
{
    _conceptoEval.clear();
    _acumValorConcepto = 0;
    _acumDurConcepto = 0;
    _existeConcepto = false;
    _calculaAplica = false;
    _cuadrantesAplica.clear();
}



void AcumConcepto::set(const STRING16& concEval, CuadrantesAplicPlan* cApliPlan)
{
    clear();
    _conceptoEval = concEval;

    if(cApliPlan != NULL)
    {
        _calculaAplica = true;
        _cuadrantesAplica = *cApliPlan;
    }
}



AcumConcepto& AcumConcepto::operator +=(ConceptoTrafico& rhs)
{
    _existeConcepto = true;
    _acumValorConcepto += rhs.MTO_FACT;
    _acumDurConcepto += rhs.DUR_FACT;

    if(_calculaAplica)
        _cuadrantesAplica += rhs.MTO_FACT;

    return *this;
}




DECIMAL_NUMBER AcumConcepto::getAcumValorConcepto()
{
    return _acumValorConcepto;
}



int AcumConcepto::getAcumDurConcepto()
{
    return _acumDurConcepto;
}



DECIMAL_NUMBER AcumConcepto::getDctoAcumFor(int idCuadrante)
{
    DECIMAL_NUMBER tmpVal = 0;

    if(_calculaAplica)
    {
        tmpVal = _cuadrantesAplica.getDctoAcum(idCuadrante);
    }

    return tmpVal;
}



STRING16 AcumConcepto::getCodConcepto()
{
    return _conceptoEval;
}



bool AcumConcepto::existeConcepto()
{
    return _existeConcepto;
}



bool AcumConcepto::calculaAplicacion()
{
    return _calculaAplica;
}









//////////////////////////////////////////////////////////////////////////////////////////
MatrizEvalRow::MatrizEvalRow()
{
    clear();
}



MatrizEvalRow::~MatrizEvalRow()
{
    /*clear();*/
}



MatrizEvalRow::MatrizEvalRow(const STRING16& conceptoEval, CuadrantesAplicPlan* cApliPlan)
{
    set(conceptoEval, cApliPlan);
}




void MatrizEvalRow::set(const STRING16& conceptoEval, CuadrantesAplicPlan* cApliPlan)
{
    clear();

    _conceptoEval = conceptoEval;

    if(cApliPlan != NULL)
    {
        _cuadrantesAplica = *cApliPlan;
        _calculaAplica = true;
    }
}



AcumConcepto& MatrizEvalRow::operator [](int codCliente)
{
    TablaClientes::iterator itr;

    itr = _clientesLoc.find(codCliente);

    if(itr == _clientesLoc.end())
    {
        STRING1000 errorMsg;
        errorMsg << "ERROR LOGICO, NO SE HAN ENCONTRADO CLIENTE PARA: [codCliente] = [" << codCliente
                 << "] EN (MatrizEvalRow)" << ENDL;
        throw ProcessCoreException((STRING1000&)  errorMsg, (char*) "XXXX", LOGIC_ERROR);
    }

    return (itr->second);
}



bool MatrizEvalRow::push_back(int codCliente)
{
    TablaClientes::iterator itr;
    AcumConcepto* tmpAC;

    itr = _clientesLoc.find(codCliente);

    if(itr != _clientesLoc.end())
    {
        return false;
    }

    tmpAC = &(_clientesLoc[codCliente]);

    if(_calculaAplica)
    {
        (*tmpAC).set(_conceptoEval, &_cuadrantesAplica);
    }
    else
    {
        (*tmpAC).set(_conceptoEval, NULL);
    }

    return true;
}



void MatrizEvalRow::clear()
{
    _conceptoEval.clear();
    _calculaAplica = false;
    _cuadrantesAplica.clear();
    _clientesLoc.clear();
}




DECIMAL_NUMBER MatrizEvalRow::getAcumValorConcepto()
{
    TablaClientes::iterator itr;
    DECIMAL_NUMBER totalAcum;

    totalAcum = 0;

    for(itr = _clientesLoc.begin(); itr != _clientesLoc.end(); itr++)
    {
        totalAcum += (itr->second).getAcumValorConcepto();
    }

    return totalAcum;
}



DECIMAL_NUMBER MatrizEvalRow::getRemanAcumValorConcepto(int idCuadrante)
{
    TablaClientes::iterator itr;
    DECIMAL_NUMBER totalAcum;
    DECIMAL_NUMBER remanConcepto;

    totalAcum = 0;

    for(itr = _clientesLoc.begin(); itr != _clientesLoc.end(); itr++)
    {
        remanConcepto = 0;
        remanConcepto = (itr->second).getAcumValorConcepto() - (itr->second).getDctoAcumFor(idCuadrante);
        totalAcum += remanConcepto;
    }

    return totalAcum;
}



int MatrizEvalRow::getAcumDurConcepto()
{
    if(!existeConcepto()) return 0;

    TablaClientes::iterator itr;
    int totalAcum;

    totalAcum = 0;

    for(itr = _clientesLoc.begin(); itr != _clientesLoc.end(); itr++)
    {
        totalAcum += (itr->second).getAcumDurConcepto();
    }

    return totalAcum;
}



int MatrizEvalRow::getRemanAcumDurConcepto(int idCuadrante)
{
    DECIMAL_NUMBER totalValAcum;
    DECIMAL_NUMBER totalValReman;
    int totalDurAcum;
    int totalDurReman;

    totalValAcum = getAcumValorConcepto();

    if(!existeConcepto() || totalValAcum < 0.0001) return 0;

    totalValReman = getRemanAcumValorConcepto(idCuadrante);
    totalDurAcum = getAcumDurConcepto();

    totalDurReman = static_cast<int>((totalValReman * totalDurAcum)/totalValAcum);

    return totalDurReman;
}



DECIMAL_NUMBER MatrizEvalRow::getDctoAcumFor(int idCuadrante)
{
    TablaClientes::iterator itr;
    DECIMAL_NUMBER totalAcum;

    totalAcum = 0;

    for(itr = _clientesLoc.begin(); itr != _clientesLoc.end(); itr++)
    {
        totalAcum += (itr->second).getDctoAcumFor(idCuadrante);
    }

    return totalAcum;
}



STRING16 MatrizEvalRow::getCodConcepto()
{
    return _conceptoEval;
}



bool MatrizEvalRow::existeConcepto()
{
    TablaClientes::iterator itr;

    for(itr = _clientesLoc.begin(); itr != _clientesLoc.end(); itr++)
    {
        if((itr->second).existeConcepto()) return true;
    }

    return false;
}



bool MatrizEvalRow::calculaAplicacion()
{
    return _calculaAplica;
}













//////////////////////////////////////////////////////////////////////////////////////////
MatrizEvalDcto::MatrizEvalDcto()
{
    clear();
}



MatrizEvalDcto::~MatrizEvalDcto()
{
    /*clear();*/
}




bool MatrizEvalDcto::setPlanBolsa(const PlanDescuento& planDesc)
{
    if(_calculaAplica)
    {
        return false;
    }

    _planBolsa = planDesc;

    _calculaAplica = true;

    int idCuadrante;
    RegistroCuadrante* cuadrante;

    for(idCuadrante = 0; idCuadrante < _planBolsa.CUADRANTE_PLAN.getNumOfRecords(); idCuadrante++)
    {
        cuadrante = NULL;
        cuadrante = &(_planBolsa.CUADRANTE_PLAN[idCuadrante]);
        _cuadrantesAplica.push_back(idCuadrante, &(cuadrante->_valDcto), cuadrante->_tipoDcto);
    }

    if(idCuadrante == 0) _calculaAplica = false;

    return true;
}



void MatrizEvalDcto::push_back(const STRING16& codConcepto)
{
    TablaConceptos::iterator itr;

    itr = _conceptos.find(codConcepto);

    if(itr != _conceptos.end()) return;

    MatrizEvalRow newRow;
    MatrizEvalRow* pRow;
    ConceptoApliDcto* tmpCApli = NULL;

    if(_calculaAplica)
    {
        tmpCApli = _planBolsa.CRITERIO_APLI.find(const_cast<STRING16&>(codConcepto));
        if(tmpCApli == NULL)
            newRow.set(codConcepto, NULL);
        else
            newRow.set(codConcepto, &_cuadrantesAplica);
    }
    else
        newRow.set(codConcepto, NULL);

    pRow = &(_conceptos[codConcepto]);
    (*pRow) = newRow;

    ConjuntoClientes::iterator itr2;

    for(itr2 = _clientes.begin(); itr2 != _clientes.end(); itr2++)
    {
        (*pRow).push_back(*itr2);
    }
}




void MatrizEvalDcto::push_back(int codCliente)
{
    ConjuntoClientes::iterator itr;

    itr = _clientes.find(codCliente);

    if(itr != _clientes.end()) return;

    _clientes.insert(codCliente);

    TablaConceptos::iterator itr2;

    for(itr2 = _conceptos.begin(); itr2 != _conceptos.end(); itr2++)
    {
        (itr2->second).push_back(codCliente);
    }

    _otrosConceptos.push_back(codCliente);
}





void MatrizEvalDcto::clear()
{
    _calculaAplica = false;
    _cuadrantesAplica.clear();
    _conceptos.clear();
    _clientes.clear();

    STRING16 tmp;
    tmp = "OTROS";
    _otrosConceptos.clear();
    _otrosConceptos.set(tmp, NULL);
}




MatrizEvalRow& MatrizEvalDcto::operator [](const STRING16& codConcepto)
{
    TablaConceptos::iterator itr;

    itr = _conceptos.find(codConcepto);

    if(itr == _conceptos.end())
    {
        return _otrosConceptos;
    }

    return (itr->second);
}



int MatrizEvalDcto::getCuadranEvalPlanBolsa(STRING1000& msg)
{
    if(!_calculaAplica)
    {
        msg << "No Aplica Plan Bolsa...";
        return -1;
    }

    int conceptoEval;
    int idCuadrante;
    DECIMAL_NUMBER totalEval;
    DECIMAL_NUMBER mtoConcepto;
    RegistroCuadrante cuadrante;
    ConceptoEvalDcto cEval;

    totalEval = 0;

    totalEval = getTotalAcum();

    if(totalEval < _planBolsa.MTO_MIN)
    {
        msg << "[TOTAL_ACUMULADO] = [" << totalEval << "] < [MTO_MINFACT](plan) = ["
            << _planBolsa.MTO_MIN << "]";
        return -1;
    }

    totalEval = 0;

    for(conceptoEval = 0; conceptoEval < _planBolsa.CRITERIO_EVAL.getNumOfRecords(); conceptoEval++)
    {
        mtoConcepto = 0;
        cEval.clear();
        cEval = _planBolsa.CRITERIO_EVAL[conceptoEval];

        mtoConcepto = ((*this)[cEval.COD_CONCEPTO]).getAcumValorConcepto();

        if(_planBolsa.TIP_UNIDAD == "MI")
            totalEval += ((*this)[cEval.COD_CONCEPTO]).getAcumDurConcepto();
        else
        {
            totalEval += mtoConcepto;
        }

        if( (cEval.MTO_MIN > 0) && (mtoConcepto < cEval.MTO_MIN) )
        {
            msg << "[TOTAL_CONCEPTO](" << cEval.COD_CONCEPTO << ") = [" << mtoConcepto << "] < [MTO_MIN](concepto) = ["
                << cEval.MTO_MIN << "]";
            return -1;
        }

        if(cEval.ES_REQUERIDO && !((*this)[cEval.COD_CONCEPTO]).existeConcepto())
        {
            msg << "Concepto (" << cEval.COD_CONCEPTO << ") es requerido y no se ha encontrado en trafico...";
            return -1;
        }
    }

    if(totalEval <= 0.0000001)
    {
        msg << "Monto Total de evaluacion = [0]...";
        return -1;
    }


    for(idCuadrante = 0; idCuadrante < _planBolsa.CUADRANTE_PLAN.getNumOfRecords(); idCuadrante++)
    {
        cuadrante.clear();
        cuadrante = _planBolsa.CUADRANTE_PLAN[idCuadrante];
        if(totalEval >= cuadrante._valDesde && totalEval <= cuadrante._valHasta) return idCuadrante;
    }

    msg << "No se ha encontrado cuadrante valido para [TOTAL_EVAL] = [" << totalEval << "]";

    return -1;
}



int MatrizEvalDcto::getCuadranEvalRemanPlan(PlanDescuento& planDesc, int idCuadrantePlanBolsa, STRING1000& msg)
{
    int conceptoEval;
    int idCuadrante;
    DECIMAL_NUMBER totalEval;
    DECIMAL_NUMBER mtoConcepto;
    RegistroCuadrante cuadrante;
    ConceptoEvalDcto cEval;
    bool calculaAplica = _calculaAplica;

    if(idCuadrantePlanBolsa < 0) calculaAplica = false;

    totalEval = 0;

    if(calculaAplica)
        totalEval = getTotalRemanAcum(idCuadrantePlanBolsa);
    else
        totalEval = getTotalAcum();

    if(totalEval < planDesc.MTO_MIN)
    {
        msg << "[TOTAL_ACUMULADO] = [" << totalEval << "] < [MTO_MINFACT](plan) = ["
            << planDesc.MTO_MIN << "]";
        return -1;
    }

    totalEval = 0;

    for(conceptoEval = 0; conceptoEval < planDesc.CRITERIO_EVAL.getNumOfRecords(); conceptoEval++)
    {
        mtoConcepto = 0;
        cEval.clear();
        cEval = planDesc.CRITERIO_EVAL[conceptoEval];

        if(!calculaAplica)
        {
            mtoConcepto = ((*this)[cEval.COD_CONCEPTO]).getAcumValorConcepto();
            if(planDesc.TIP_UNIDAD == "MI")
                totalEval += ((*this)[cEval.COD_CONCEPTO]).getAcumDurConcepto();
            else
                totalEval += mtoConcepto;
        }
        else
        {
            mtoConcepto = ((*this)[cEval.COD_CONCEPTO]).getRemanAcumValorConcepto(idCuadrantePlanBolsa);
            if(planDesc.TIP_UNIDAD == "MI")
                totalEval += ((*this)[cEval.COD_CONCEPTO]).getRemanAcumDurConcepto(idCuadrantePlanBolsa);
            else
                totalEval += mtoConcepto;
        }

        if( (cEval.MTO_MIN > 0) && (mtoConcepto < cEval.MTO_MIN) )
        {
            msg << "[TOTAL_CONCEPTO](" << cEval.COD_CONCEPTO << ") = [" << mtoConcepto << "] < [MTO_MIN](concepto) = ["
                << cEval.MTO_MIN << "]";
            return -1;
        }


        if(cEval.ES_REQUERIDO && !((*this)[cEval.COD_CONCEPTO]).existeConcepto())
        {
            msg << "Concepto (" << cEval.COD_CONCEPTO << ") es requerido y no se ha encontrado en trafico...";
            return -1;
        }

    }

    if(totalEval <= 0.0000001)
    {
        msg << "Monto Total de evaluacion = [0]...";
        return -1;
    }


    for(idCuadrante = 0; idCuadrante < planDesc.CUADRANTE_PLAN.getNumOfRecords(); idCuadrante++)
    {
        cuadrante.clear();
        cuadrante = planDesc.CUADRANTE_PLAN[idCuadrante];
        if(totalEval >= cuadrante._valDesde && totalEval <= cuadrante._valHasta) return idCuadrante;
    }

    msg << "No se ha encontrado cuadrante valido para [TOTAL_EVAL] = [" << totalEval << "]";

    return -1;
}







DECIMAL_NUMBER MatrizEvalDcto::getTotalAcum()
{
    DECIMAL_NUMBER totalAcum;
    TablaConceptos::iterator itr;

    totalAcum = 0;

    for(itr = _conceptos.begin(); itr != _conceptos.end(); itr++)
    {
        totalAcum += (itr->second).getAcumValorConcepto();
    }

    totalAcum += _otrosConceptos.getAcumValorConcepto();

    return totalAcum;
}



DECIMAL_NUMBER MatrizEvalDcto::getTotalDctoCliente(int codCliente, int idCuadrantePlanBolsa)
{
    DECIMAL_NUMBER totalAcum;
    TablaConceptos::iterator itr;
    
    totalAcum = 0;
    
    for(itr = _conceptos.begin(); itr != _conceptos.end(); itr++)
    {
        totalAcum += (itr->second)[codCliente].getDctoAcumFor(idCuadrantePlanBolsa);
    }
    
    return totalAcum;
}



DECIMAL_NUMBER MatrizEvalDcto::getTotalRemanAcum(int idCuadrante)
{
    DECIMAL_NUMBER totalAcum;
    TablaConceptos::iterator itr;

    totalAcum = 0;

    for(itr = _conceptos.begin(); itr != _conceptos.end(); itr++)
    {
        totalAcum += (itr->second).getRemanAcumValorConcepto(idCuadrante);
    }

    totalAcum += _otrosConceptos.getAcumValorConcepto();

    return totalAcum;
}







