#ifndef NO_INDENT
#ident "@(#)$RCSfile: plan_discount.h,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

///
/// \file plan_discount.h
///


#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef PLAN_DISCOUNT_H
#define PLAN_DISCOUNT_H



typedef double DECIMAL_NUMBER;

#include "simple_container_interface.h"
#include "myString.h"


//////////////////////////////////////////////////////////////////////////////////////////
class RegistroCuadrante
{
public:
    DECIMAL_NUMBER  _valDesde;
    DECIMAL_NUMBER  _valHasta;
    STRING16        _tipoDcto;
    DECIMAL_NUMBER  _valDcto;
    STRING16        _tipoMoneda;

    RegistroCuadrante(){clear();};
    ~RegistroCuadrante(){};
    void clear()
    {
        _valDesde = -1;
        _valHasta = -1;
        _tipoDcto.clear();
        _valDcto = -1;
        _tipoMoneda.clear();
    };

    bool operator < (RegistroCuadrante rhs) const
    {
        return (_valDesde < rhs._valDesde);
    };
};



//////////////////////////////////////////////////////////////////////////////////////////

class Cuadrante : public SimpleSetInterface<RegistroCuadrante>
{
public:
    int NUM_CUADRANTE;
    Cuadrante() : SimpleSetInterface<RegistroCuadrante>(){ clear(); };
    ~Cuadrante(){};
    RegistroCuadrante& operator[] (int index)
    {
        return SimpleSetInterface<RegistroCuadrante>::operator [](index);
    };
    void clear()
    {
        NUM_CUADRANTE = -1;
        SimpleSetInterface<RegistroCuadrante>::clear();
    };
};





//////////////////////////////////////////////////////////////////////////////////////////
class GrupoConceptos
{
public:
    STRING16    COD_GRUPO;
    STRING16    COD_TIPO;

    GrupoConceptos(){ clear(); };
    ~GrupoConceptos(){ /*clear();*/ };

    void clear()
    {
        COD_GRUPO.clear();
        COD_TIPO.clear();
    };
};



//////////////////////////////////////////////////////////////////////////////////////////
class ConceptoEvalDcto
{
public:
    STRING16        COD_CONCEPTO;
    bool            ES_REQUERIDO;
    DECIMAL_NUMBER  MTO_MIN;

    ConceptoEvalDcto(){ clear(); };
    ~ConceptoEvalDcto(){ /*clear();*/ };

    void clear()
    {
        COD_CONCEPTO.clear();
        ES_REQUERIDO = false;
        MTO_MIN = 0;
    };

    STRING16 getCodConcepto()
    {
        return COD_CONCEPTO;
    };
};




//////////////////////////////////////////////////////////////////////////////////////////
class ConceptoApliDcto
{
public:
    STRING16        COD_CONCEPTO_DESCONTAR;
    STRING16        COD_CONCEPTO_DESCUENTO;

    ConceptoApliDcto(){ clear(); };
    ~ConceptoApliDcto(){ /*clear();*/ };

    void clear()
    {
        COD_CONCEPTO_DESCONTAR.clear();
        COD_CONCEPTO_DESCUENTO.clear();
    };

    STRING16 getCodConcepto()
    {
        return COD_CONCEPTO_DESCONTAR;
    };
};




//////////////////////////////////////////////////////////////////////////////////////////
template < class TYPE_CONCEPTO>
class CriterioPlan : public GrupoConceptos, public SimpleMapInterface<STRING16, TYPE_CONCEPTO>
{
public:
    CriterioPlan() : GrupoConceptos(), SimpleMapInterface<STRING16, TYPE_CONCEPTO>(){};
    void clear()
    {
        GrupoConceptos::clear();
        SimpleMapInterface<STRING16, TYPE_CONCEPTO>::clear();
    };
};



//////////////////////////////////////////////////////////////////////////////////////////

typedef CriterioPlan<ConceptoEvalDcto> CriterioEval;
typedef CriterioPlan<ConceptoApliDcto> CriterioApli;



//////////////////////////////////////////////////////////////////////////////////////////
class PlanDescuento
{
public:
    STRING16        COD_PLAN;
    STRING16        COD_ESTADO;
    STRING16        TIP_ENTIDAD;
    STRING16        TIP_UNIDAD;
    STRING16        COD_CONCEPTO;
    DECIMAL_NUMBER  MTO_MIN;
    int             NUM_SEC;

    Cuadrante       CUADRANTE_PLAN;
    CriterioEval    CRITERIO_EVAL;
    CriterioApli    CRITERIO_APLI;

    void clear()
    {
        COD_PLAN.clear();
        COD_ESTADO.clear();
        TIP_ENTIDAD.clear();
        TIP_UNIDAD.clear();
        COD_CONCEPTO.clear();
        MTO_MIN = 0;
        NUM_SEC = -1;
        CUADRANTE_PLAN.clear();
        CRITERIO_EVAL.clear();
        CRITERIO_APLI.clear();
    };

    PlanDescuento()
    {
        clear();
    };

    ~PlanDescuento()
    {
    };
};





#endif //EVAL_DISCOUNT_MATRIX_H


