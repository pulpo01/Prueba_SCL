#ifndef WIN32
#ident "@(#)$RCSfile: memoryCob.h,v $ $Revision: 1.16 $ $Date: 2008/06/19 19:17:51 $"
#endif


#ifndef _memoryCob_h
#define _memoryCob_h

#define CLEAR(x) memset(x,0x0,sizeof(x))
#define SQLNOTFOUND 1403

#ifndef PROC
#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <vector>
#include "hr_time_clock.h"
#endif

using namespace std;

typedef struct
{
   int  cod_concepto;
   char des_concepto[40];
   int  cod_tipconce;
   int  orden_can;
   int  cod_concfact;
   int  ind_porcentaje;

   void print()
   {
       printf("COD_CONCEPTOS  : [%ld]\n",cod_concepto);
       printf("DES_CONCEPTOS  : [%s]\n",des_concepto);
       printf("COD_TIPCONCE   : [%ld]\n",cod_tipconce);
       printf("ORDEN_CAN      : [%ld]\n",orden_can);
       printf("CON_CONCFACT   : [%ld]\n",cod_concfact);
       printf("IND_PORCENTAJE : [%ld]\n",ind_porcentaje);
   } 

}RECORD_CO_CONCEPTOS;


struct modVenta
{
    int     iIndPagado;
    int     iCodCauPago;
    char    szDesCauPago[41];

    modVenta() : iIndPagado(0),iCodCauPago(0){};

    void limpia()
    {
        CLEAR(szDesCauPago);
        iIndPagado=0;
        iCodCauPago=0;
    }

    void print()
    {
        cout << "iIndPagado   : " << iIndPagado << endl;;
        cout << "iCodCauPago  :"  << iCodCauPago << endl;
        cout << "szDesCauPago :"  << szDesCauPago << endl;
    }

};

struct llave_ged_parametros
{
    string cod_modulo;
    string nom_parametro;

    void limpia()
    {
        //CLEAR(cod_modulo);
        //CLEAR(nom_parametro);
        cod_modulo.clear();
        nom_parametro.clear();
    }

    void print()
    {
        cout << "cod_modulo     : " << cod_modulo << endl;;
        cout << "nom_parametro  : "  << nom_parametro << endl;
    }

    bool operator < (llave_ged_parametros x) const
    {
        return  (cod_modulo <  x.cod_modulo) ||
                (cod_modulo == x.cod_modulo && nom_parametro <  x.nom_parametro);
    }

};

struct ged_parametros
{
    char val_parametros[21];

    void limpia()
    {
        CLEAR(val_parametros);
    }

    void print()
    {
        cout << "val_parametro : " << val_parametros << endl;;
    }

};

typedef map<int, modVenta> RECORD_TABLE_MOD_VENTA;
typedef map <int, RECORD_CO_CONCEPTOS> RECORD_TABLE_CO_CONCEPTOS;
typedef map<int,int> RECORD_TABLE_COUNTER_FATIPMOV;
typedef map<llave_ged_parametros,ged_parametros> RECORD_TABLE_GED_PARAMETROS;

static RECORD_TABLE_MOD_VENTA _map_mod_venta;
static RECORD_TABLE_COUNTER_FATIPMOV _map_fatipmov;
static RECORD_TABLE_GED_PARAMETROS _map_ged_parametros;

class memoryCob{
    
 private:
    
 public:



    memoryCob (){

    };
    
    ~memoryCob     ( ){ 

    }

    RECORD_TABLE_CO_CONCEPTOS _mytable_co_conceptos;
    
public :

    int decimales;
    char sep_miles_montos[2];
    char sep_decimales_montos[2];
    char sep_decimales_oracle[2];
    int num_decimal_fact;
    int cod_tipo_foliacion;
    int cod_par_trafico;
    int ind_zonaimpocic;
    int mto_min_ajuste;
    int zona_imp_defecto;
    char documento_cero[2];

    int concrefa;
    bool chargeConCreFA();
    int getConCreFA();
    bool chargeModVenta();
    int selectModVenta(int cod_mod_venta,modVenta &_mod_Venta);
    bool chargeFaTipMovientoCounter();
    int selectFaTipMoviemientoCounter(int cod_tip_docum);
    bool chargeGedParametros();
    int settinParameters();
    int getDecimal();
    char * get_sep_miles_montos();
    char * get_sep_decimales_montos();
    char * get_sep_decimales_oracle();
    int get_num_decimal_fact();
    int get_cod_tipo_foliacion();
    int get_cod_par_trafico();
    int get_ind_zonaimpocic();
    int get_mto_min_ajuste();
    int get_zona_imp_defecto();
    char * get_documento_cero();
    char * GedCharParamFromGedParametros(char * cod_modulo,char * nom_parametro);
    int GedNumberParamFromGedParametros(char * cod_modulo,char * nom_parametro);
    int Rtrims(char *szVar);

};

#endif

