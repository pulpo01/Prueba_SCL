#ifndef NO_INDENT
#ident "@(#)$RCSfile: eval_discount_matrix.h,v $ $Revision: 1.4 $ $Date: 2008/06/02 17:23:06 $"
#endif

///
/// \file eval_discount_matrix.h
///


#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef EVAL_DISCOUNT_MATRIX_H
#define EVAL_DISCOUNT_MATRIX_H

#include <set>
#include <map>
#include "myString.h"
#include "plan_discount.h"
#include "process_core_exception.h"


//////////////////////////////////////////////////////////////////////////////////////////
class AcumCuadrantePlan
{
public:
    AcumCuadrantePlan();
    AcumCuadrantePlan(const int idCuadra, DECIMAL_NUMBER* valDcto, const STRING16& tipDcto);
    ~AcumCuadrantePlan();

    void set(const int idCuadra, DECIMAL_NUMBER* valDcto, const STRING16& tipDcto);
    AcumCuadrantePlan& operator+=(const DECIMAL_NUMBER& rhs);
    
    int getId();
    DECIMAL_NUMBER getDctoAcum();
    DECIMAL_NUMBER getValDctoReman();
    DECIMAL_NUMBER* getPValDctoReman();
    STRING16 getTipDcto();
private:
    int                 _idCuadrante;
    DECIMAL_NUMBER      _dctoAcum;
    DECIMAL_NUMBER*     _valDctoReman;
    STRING16            _tipoDcto;

    void discountAmount(const DECIMAL_NUMBER& importe);
    void discountPercent(const DECIMAL_NUMBER& importe);
};


//////////////////////////////////////////////////////////////////////////////////////////
class CuadrantesAplicPlan
{
public:
    CuadrantesAplicPlan();
    ~CuadrantesAplicPlan();

    CuadrantesAplicPlan& operator+=(DECIMAL_NUMBER& importe);

    bool push_back(int idCuadrante, DECIMAL_NUMBER* valDctoReman, const STRING16& tipDcto);
    void clear();
    int geNumOfCuadrantes();
    DECIMAL_NUMBER getDctoAcum(int idCuadrante);
    DECIMAL_NUMBER getValDctoReman(int idCuadrante);
    STRING16 getTipDcto(int idCuadrante);
private:
    typedef std::map<int, AcumCuadrantePlan> TableCuadrantes;
    TableCuadrantes _cuadrantes;
};



//////////////////////////////////////////////////////////////////////////////////////////
class ConceptoTrafico
{
public:
    int             COD_CLIENTE;
    STRING16        COD_CONCEPTO;
    STRING16        TIP_CONCEPTO;
    DECIMAL_NUMBER  MTO_FACT;
    int             DUR_FACT;
    int             NUM_UNIDADES;

    ConceptoTrafico(){ clear(); };
    ~ConceptoTrafico(){};

    void clear()
    {
        COD_CLIENTE = 0;
        COD_CONCEPTO.clear();
        TIP_CONCEPTO.clear();
        MTO_FACT = 0;
        DUR_FACT = 0;
        NUM_UNIDADES = 0;
    }
};


//////////////////////////////////////////////////////////////////////////////////////////
class AcumConcepto
{
public:
    AcumConcepto();
    AcumConcepto(const STRING16& concEval, CuadrantesAplicPlan* cApliPlan);
    ~AcumConcepto();

    void clear();
    void set(const STRING16& concEval, CuadrantesAplicPlan* cApliPlan);
    AcumConcepto& operator +=(ConceptoTrafico& rhs);

    DECIMAL_NUMBER getAcumValorConcepto();
    int getAcumDurConcepto();
    DECIMAL_NUMBER getDctoAcumFor(int idCuadrante);
    STRING16 getCodConcepto();
    bool existeConcepto();
    bool calculaAplicacion();

private:
    STRING16                    _conceptoEval;
    DECIMAL_NUMBER              _acumValorConcepto;
    int                         _acumDurConcepto;
    bool                        _existeConcepto;
    bool                        _calculaAplica;
    CuadrantesAplicPlan         _cuadrantesAplica;
};



//////////////////////////////////////////////////////////////////////////////////////////
class MatrizEvalRow
{
public:
    MatrizEvalRow();
    ~MatrizEvalRow();
    MatrizEvalRow(const STRING16& conceptoEval, CuadrantesAplicPlan* cApliPlan);

    void set(const STRING16& conceptoEval, CuadrantesAplicPlan* cApliPlan);
    AcumConcepto& operator [](int codCliente);
    bool push_back(int codCliente);
    void clear();

    DECIMAL_NUMBER getAcumValorConcepto();
    DECIMAL_NUMBER getRemanAcumValorConcepto(int idCuadrante);
    int getAcumDurConcepto();
    int getRemanAcumDurConcepto(int idCuadrante);
    DECIMAL_NUMBER getDctoAcumFor(int idCuadrante);
    STRING16 getCodConcepto();
    bool existeConcepto();
    bool calculaAplicacion();

private:
    typedef std::map<int, AcumConcepto> TablaClientes;
    STRING16            _conceptoEval;
    bool                _calculaAplica;
    CuadrantesAplicPlan _cuadrantesAplica;
    TablaClientes       _clientesLoc;
};




//////////////////////////////////////////////////////////////////////////////////////////
class MatrizEvalDcto
{
public:
    MatrizEvalDcto();
    ~MatrizEvalDcto();

    bool setPlanBolsa(const PlanDescuento& planDesc);
    void push_back(const STRING16& codConcepto);
    void push_back(int codCliente);
    void clear();

    MatrizEvalRow& operator [](const STRING16& codConcepto);
    int getCuadranEvalPlanBolsa(STRING1000& msg);
    int getCuadranEvalRemanPlan(PlanDescuento& planDesc, int idCuadrantePlanBolsa, STRING1000& msg);
    DECIMAL_NUMBER getTotalAcum();
    DECIMAL_NUMBER getTotalDctoCliente(int codCliente, int idCuadrantePlanBolsa);
    DECIMAL_NUMBER getTotalRemanAcum(int idCuadrante);
private:
    typedef std::map<STRING16, MatrizEvalRow> TablaConceptos;
    typedef set<int> ConjuntoClientes;
    PlanDescuento       _planBolsa;
    bool                _calculaAplica;
    CuadrantesAplicPlan _cuadrantesAplica;
    TablaConceptos      _conceptos;
    MatrizEvalRow       _otrosConceptos;
    ConjuntoClientes    _clientes;
};

#endif //EVAL_DISCOUNT_MATRIX_H



