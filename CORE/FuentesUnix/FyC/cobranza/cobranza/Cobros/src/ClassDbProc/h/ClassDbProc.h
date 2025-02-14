#ifndef NO_INDENT
#ident "@(#)$RCSfile: ClassDbProc.h,v $ $Revision: 1.44 $ $Date: 2008/06/20 19:34:37 $"
#endif

#ifndef _classdbproc_h
#define _classdbproc_h

#define CLEAR(x) memset(x,0x0,sizeof(x))
#define MAX_ARRAY 10000

#ifndef PROC
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <vector>
#include "hr_time_clock.h"
#endif

using namespace std;

struct estClientes
{
    char    szhRowid[19];
    long    lhNumSecuenci;
    int     ihCodTipDocum;
    long    lhCodVendedorAgente;
    char    szhLetra[2];
    int     ihCodCentrEmi;
    double  dhTotFactura;
    long    lhCodCliente;
    char    szhFecEmision[17];
    char    szhIndOrdenTotal[13];
    short   shIndSuperTel;
    long    lhNumFolio;
    char    szhNumCTC[13];
    char    szhFecVencimie[17];
    char    szhFecCaducida[17];
    long    lhNumSecuRel;   
    char    szhLetraRel[2];
    int     ihCodTipDocumRel;
    long    lhCodVendedorAgenteRel;
    int     ihCodCentrRel;         
    long    lhNumVenta;            
    long    lhNumTransaccion;      
    int     ihCodModVenta;         
    int     ihIndFactur;
    long    lhNumProceso;
    char    szhPrefPlaza[11];  
    char    szhCodOperadoraScl[6];
    char    szhCodPlaza[6];
    /*int     ihCodTipMovimie;
    int     ihNumCuotas;*/
    char    szhNomUsuarORA[31];
    char    szhCodTipIdent[3];     
    char    szhNumIdent[21]; 
    int     ihIndPasoCobro;      

    estClientes() : lhNumSecuenci(0),ihCodTipDocum(0),lhCodVendedorAgente(0),ihCodCentrEmi(0),dhTotFactura(0),lhCodCliente(0),shIndSuperTel(0),
                    lhNumFolio(0), lhNumSecuRel(0),ihCodTipDocumRel(0), lhCodVendedorAgenteRel(0), ihCodCentrRel(0),lhNumVenta(0), lhNumTransaccion(0), ihCodModVenta(0), 
                    ihIndFactur(0), lhNumProceso(0), ihIndPasoCobro(0) {};

    void limpia()
    {
        CLEAR(szhRowid);
        CLEAR(szhLetra);
        CLEAR(szhFecEmision);
        CLEAR(szhIndOrdenTotal);
        CLEAR(szhNumCTC);
        CLEAR(szhFecVencimie);
        CLEAR(szhFecCaducida);
        CLEAR(szhLetraRel);
        CLEAR(szhPrefPlaza);
        CLEAR(szhCodOperadoraScl);
        CLEAR(szhCodPlaza);
        CLEAR(szhNomUsuarORA);
        CLEAR(szhCodTipIdent);
        CLEAR(szhNumIdent);
    }

    void print(int reg)
    {
        cout << "REGISTRO NUMERO [" << reg << "]" << endl;
        cout << "******************************************************" << endl;
/*        cout << "szhRowid               : " << szhRowid << endl;;*/
        cout << "lhNumSecuenci          :[" << lhNumSecuenci << "]" << endl;
        cout << "ihCodTipDocum          :[" << ihCodTipDocum << "]" << endl;
        cout << "lhCodVendedorAgente    :[" << lhCodVendedorAgente << "]" << endl;
        cout << "szhLetra               :[" << szhLetra << "]" << endl;
        cout << "ihCodCentrEmi          :[" << ihCodCentrEmi << "]" << endl;
        cout << "dhTotFactura           :[" << dhTotFactura << "]" << endl;
        cout << "lhCodCliente           :[" << lhCodCliente << "]" << endl;
        cout << "szhFecEmision          :[" << szhFecEmision << "]" << endl;
        cout << "szhIndOrdenTotal       :[" << szhIndOrdenTotal << "]" << endl;
        cout << "shIndSuperTel          :[" << shIndSuperTel << "]" << endl;
        cout << "lhNumFolio             :[" << lhNumFolio << "]" << endl;
        cout << "szhNumCTC              :[" << szhNumCTC << "]" << endl;
        cout << "szhFecVencimie         :[" << szhFecVencimie << "]" << endl;
        cout << "szhFecCaducida         :[" << szhFecCaducida << "]" << endl;
        cout << "lhNumSecuRel           :[" << lhNumSecuRel << "]" << endl;
        cout << "szhLetraRel            :[" << szhLetraRel << "]" << endl;
        cout << "ihCodTipDocumRel       :[" << ihCodTipDocumRel << "]" << endl;
        cout << "lhCodVendedorAgenteRel :[" << lhCodVendedorAgenteRel << "]" << endl;
        cout << "ihCodCentrRel          :[" << ihCodCentrRel << "]" << endl;
        cout << "lhNumVenta             :[" << lhNumVenta << "]" << endl;
        cout << "lhNumTransaccion       :[" << lhNumTransaccion << "]" << endl;
        cout << "ihCodModVenta          :[" << ihCodModVenta << "]" << endl;
        cout << "ihIndFactur            :[" << ihIndFactur << "]" << endl;
        cout << "lhNumProceso           :[" << lhNumProceso << "]" << endl;
        cout << "szhPrefPlaza           :[" << szhPrefPlaza << "]" << endl;
        cout << "szhCodOperadoraScl     :[" << szhCodOperadoraScl << "]" << endl;
        cout << "szhCodPlaza            :[" << szhCodPlaza << "]" << endl;
        /*cout << "ihCodTipMovimie        :[" << ihCodTipMovimie << "]" << endl;*/
        /*cout << "ihNumCuotas            :[" << ihNumCuotas << "]" << endl;*/
        cout << "szhNomUsuarORA         :[" << szhNomUsuarORA << "]" << endl;
        cout << "szhCodTipIdent         :[" << szhCodTipIdent << "]" << endl;
        cout << "szhNumIdent            :[" << szhNumIdent << "]" << endl;
        cout << "ihIndPasoCobro         :[" << ihIndPasoCobro<< "]" << endl;
        cout << "******************************************************" << endl;
    }

};


struct NewtagConcCobr
{
  int    iCodConcCobr;
  int    iIndFactur  ;
  double dImpConcCobr;
  long   lSeqCuotas  ;
  int    iOrdCuota   ;
};

struct NewtagAboCobr
{
  long      lNumAbonado  ;
  int       iCodProducto ;
  int       iNumConceptos;
  vector<NewtagConcCobr> pConcCobr;
};

struct NewtagAcumAbo
{
  long      iNumReg;
  vector<NewtagAboCobr> pAboCobr;
};

struct sec_cartera_s
{
    int  cod_tipdocum;
    int  cod_vendedor_agente;
    char letra[2];
    int  cod_centremi;
    long num_secuenci;
    int  cod_concepto;
    int  columna;

    sec_cartera_s() : cod_tipdocum(0),cod_vendedor_agente(0),cod_centremi(0),num_secuenci(0),cod_concepto(0),columna(0){};

    void limpia()
    {
        cod_tipdocum=0;
        cod_vendedor_agente=0;
        CLEAR(letra);
        cod_centremi=0;
        num_secuenci=0;
        cod_concepto=0;
        columna=0;
    }

    void print()
    {
        cout << "cod_tipdocum         :" << cod_tipdocum << endl;;
        cout << "cod_vendedor_agente  :" << cod_vendedor_agente << endl;
        cout << "letra                :" << letra << endl;
        cout << "cod_centremi         :" << cod_centremi << endl;;
        cout << "num_secuenci         :" << num_secuenci << endl;
        cout << "cod_concepto         :" << cod_concepto << endl;
        cout << "columna              :" << columna << endl;
    }
};

struct cartera_s
{
    long   cod_cliente;
    long   num_secuenci;
    int    cod_tipdocum;
    int    cod_vendedor_agente;
    char   letra[2];
    int    cod_centremi;
    int    cod_concepto;
    int    columna;
    int    cod_producto;
    double importe_debe;
    double importe_haber;
    int    ind_contado;
    int    ind_facturado;
    char   fec_efectividad[15];
    char   fec_vencimie[15];
    char   fec_caducida[15];
    char   fec_antiguedad[15];
    long   num_abonado;
    long   num_folio;
    char   fec_pago[15];
    long   num_cuota;
    int    sec_cuota;
    long   num_transaccion;
    long   num_venta;
    char   num_folioctc[12];
    char   cod_operadora_scl[6];
    char   cod_plaza[6];
    char   pref_plaza[11];

    cartera_s() : cod_cliente(0),num_secuenci(0),cod_tipdocum(0),cod_vendedor_agente(0),cod_centremi(0),cod_concepto(0),
    columna(0),cod_producto(0),importe_debe(0),importe_haber(0),ind_contado(0),ind_facturado(0),num_abonado(0),
    num_folio(0),num_cuota(0),sec_cuota(0),num_transaccion(0),num_venta(0){};

    void limpia()
    {
      cod_cliente=0;
      num_secuenci=0;
      cod_tipdocum=0;
      cod_vendedor_agente=0;
      CLEAR(letra);
      cod_centremi=0;
      cod_concepto=0;
      columna=0;
      cod_producto=0;
      importe_debe=0.0;
      importe_haber=0.0;
      ind_contado=0;
      ind_facturado=0;
      CLEAR(fec_efectividad);
      CLEAR(fec_vencimie);
      CLEAR(fec_caducida);
      CLEAR(fec_antiguedad);
      num_abonado=0;
      num_folio=0;
      CLEAR(fec_pago);
      num_cuota=0;
      sec_cuota=0;
      num_transaccion=0;
      num_venta=0;
      CLEAR(num_folioctc);
      CLEAR(cod_operadora_scl);
      CLEAR(cod_plaza);
      CLEAR(pref_plaza);
    }

    void print()
    {
        cout << "cod_cliente         : " << cod_cliente << endl;;
        cout << "num_secuenci        : "  << num_secuenci << endl;
        cout << "cod_tipdocum        : "  << cod_tipdocum << endl;
        cout << "cod_vendedor_agente : " << cod_vendedor_agente << endl;
        cout << "letra               : "  << letra << endl;
        cout << "cod_centremi        : "  << cod_centremi << endl;
        cout << "cod_concepto        : "  << cod_concepto << endl;
        cout << "columna             : "  << columna << endl;
        cout << "cod_producto        : "  << cod_producto << endl;
        cout << "importe_debe        : " << importe_debe << endl;
        cout << "importe_haber       : "  << importe_haber << endl;
        cout << "ind_contado         : "  << ind_contado << endl;
        cout << "ind_facturado       : "  << ind_facturado << endl;
        cout << "fec_efectividad     : "  << fec_efectividad << endl;
        cout << "fec_vencimie        : "  << fec_vencimie << endl;
        cout << "fec_caducida        : " << fec_caducida << endl;;
        cout << "fec_antiguedad      : "  << fec_antiguedad << endl;
        cout << "num_abonado         : "  << num_abonado << endl;
        cout << "num_folio           : "  << num_folio << endl;
        cout << "fec_pago            : "  << fec_pago << endl;
        cout << "num_cuota           : "  << num_cuota << endl;
        cout << "sec_cuota           : " << sec_cuota << endl;
        cout << "num_transaccion     : "  << num_transaccion << endl;
        cout << "num_venta           : "  << num_venta << endl;
        cout << "num_folioctc        : "  << num_folioctc << endl;
        cout << "cod_operadora_scl   : "  << cod_operadora_scl << endl;
        cout << "cod_plaza           : "  << cod_plaza << endl;
        cout << "pref_plaza          : "  << pref_plaza << endl;
    }
};


using namespace std;

class ClassDbProc{
    
 private:
    
 public:

    ClassDbProc (){
    };

   ~ClassDbProc     ( ){ 
    }

    string userpass;
    vector <sec_cartera_s> vec_sec_cartera;
    vector <cartera_s> vec_cartera;

    /*int getDoctosClientes(vector <estClientes> &_vec_dcto_clientes,int tipo_docum , int ciclo , long cliente_ini , long cliente_fin, long lmaxArray);*/
    int getDoctosClientesArray( vector <estClientes> &_vec_dcto_clientes,int tipo_docum , int ciclo , long cliente_ini , long cliente_fin, long lmaxArray);
    int getDoctosClientesArray( vector <estClientes> &_vec_dcto_clientes,int tipo_docum , int ciclo , long cliente_ini , long cliente_fin, long lmaxArray,int multi);
    
    /* Inicio Requerimiento de Soporte - 69137 - 18.08.2007 */    
    /*int openCursorDoctosClientes(int tipo_docum,int ciclo,long cliente_ini , long cliente_fin);*/
    /*int closeCursorDoctosClientes();*/
    /*int getDocumentos(vector <estClientes> &_vec_dcto_clientes,int limite);*/
    /*int updateDocumentos(vector <estClientes> &_vec_dcto_clientes,long num_procesos);*/
    /*int getAbonadoConcepto(NewtagAcumAbo &acumabo,int _ind_ordentotal,int _concargo);*/
    /* Fin Requerimiento de Soporte - 69137 - 18.08.2007 */    

    int InsertaCarteras();    
    int LimpiarCarteras();
    int AcumSecCartera(sec_cartera_s &_mysec_cartera);
    int AcumCartera(cartera_s &_my_cartera);
    int getAbonadoConcepto2(NewtagAcumAbo &acumabo,int _ind_ordentotal,int _concargo);
    int InsertaSecCarteras();

};


#endif






