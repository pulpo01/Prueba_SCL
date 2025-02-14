#ifndef NO_INDENT
#ident "@(#)$RCSfile: cliente_locutorio.h,v $ $Revision: 1.5 $ $Date: 2008/05/22 16:42:14 $"
#endif

///
/// \file cliente_locutorio.h
///

#ifdef WIN32
#pragma warning(disable:4786)
#endif

#ifndef CLIENTE_LOC_H
#define CLIENTE_LOC_H

#include <set>
#include <map>
#include "myString.h"
#include "plan_discount.h"
#include "simple_container_interface.h"

typedef SimpleSetInterface<int> AbonadosCliente;


class ClienteLocutorio
{
public:
    int             COD_CLIENTE;
    STRING16        COD_PLAN_TARIF;
    STRING16        TIP_PLAN_TRIF;
    int             COD_CICLO;
    bool            ACTIVE_FOR_JOB;
    AbonadosCliente ABONADOS;

    ClienteLocutorio(){ clear(); };
    ~ClienteLocutorio(){};

    void clear()
    {
        COD_CLIENTE = 0;
        COD_PLAN_TARIF.clear();
        TIP_PLAN_TRIF.clear();
        COD_CICLO = 0;
        ABONADOS.clear();
        ACTIVE_FOR_JOB = false;
    };
};


typedef SimpleMapInterface<int, ClienteLocutorio> ClientesLocutoriosHijos;
typedef SimpleMapInterface<STRING16, PlanDescuento> PlanesDescuento;


class ClienteLocutorioPadre : public  ClienteLocutorio
{
public:
    ClientesLocutoriosHijos HIJOS;
    PlanDescuento           PLAN_BOLSA;
    PlanesDescuento         PLANES_ADD;
    STRING16                MIN_FEC_ALTA;
    STRING16                MAX_FEC_BAJA;

    ClienteLocutorioPadre() : ClienteLocutorio() { clear(); };
    ~ClienteLocutorioPadre(){};

    void chargePlanDcto(PlanDescuento& pd)
    {
    };

    void clear()
    {
        ClienteLocutorio::clear();
        HIJOS.clear();
        PLAN_BOLSA.clear();
        PLANES_ADD.clear();
        MIN_FEC_ALTA.clear();
        MAX_FEC_BAJA.clear();
    };
private:
    void proRateaPlanDcto(PlanDescuento& pd)
    {
        // falta ver como se verifica el prorrateo
    };
};

#endif //CLIENTE_LOC_H

