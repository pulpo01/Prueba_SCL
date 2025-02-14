#ifndef NO_INDENT
#ident "@(#)$RCSfile: maps_tables.cpp,v $ $Revision: 1.3 $ $Date: 2008/05/22 17:36:00 $"
#endif

#include "maps_tables.h"


///
/// \file maps_tables.cpp
///




STRING date_minus_day(const char* yyyymmdd, int days)
{
    int year = 0;
    int month = 0;
    int day = 0;

    STRING strDate;
    strDate.clear();

    if(yyyymmdd == NULL) return strDate;

    if(strlen(yyyymmdd) != 8) return strDate;

    if(days < 0) return strDate;

    if(days == 0)
    {
        strDate = yyyymmdd;
        return strDate;
    }


    char strYear[4+1];
    char strMonth[2+1];
    char strDay[2+1];

    memset(strYear, 0x00, sizeof(strYear));
    memset(strMonth, 0x00, sizeof(strMonth));
    memset(strDay, 0x00, sizeof(strDay));

    strncpy(strYear, yyyymmdd, 4);
    strncpy(strMonth, yyyymmdd+4, 2);
    strncpy(strDay, yyyymmdd+6, 2);

    year = atoi(strYear);
    month = atoi(strMonth);
    day = atoi(strDay);

    if(year < 0) return strDate;
    if(month > 12 || month < 1) return strDate;
    if(day > 31 || day < 1) return strDate;

    int remaining_days = days;

    do
    {
        day--;
        remaining_days--;
        if(day == 0)
        {
            month--;
            if(month == 0)
            {
                year--;
                month = 12;
                day = 31;
            }
            else
            {
                switch(month)
                {
                    case(1):
                        day = 31;
                        break;
                    case(2):
                        if(year%4 == 0) day = 29;
                        else day = 28;
                        break;
                    case(3):
                        day = 31;
                        break;
                    case(4):
                        day = 30;
                        break;
                    case(5):
                        day = 31;
                        break;
                    case(6):
                        day = 30;
                        break;
                    case(7):
                        day = 31;
                        break;
                    case(8):
                        day = 31;
                        break;
                    case(9):
                        day = 30;
                        break;
                    case(10):
                        day = 31;
                        break;
                    case(11):
                        day = 30;
                        break;
                    case(12):
                        day = 31;
                        break;
                    default:
                        day = 0;
                        break;
                }
            }
        }
    }while(remaining_days > 0);

    strDate << year;

    if(month < 10) strDate << "0";

    strDate << month;

    if(day < 10) strDate << "0";

    strDate << day;

    return strDate;
}

void trim(MyString<>& s )
{
	int j;
	for( j=s.length()-1; j >=0  &&  isspace(s[j]); j-- )
	{
	}
	s.erase( j + 1);

	int len = s.length();
	for( j=0; j < len  &&  isspace(s[j]); j++ )
	{
	}
	s.erase( 0, j );
}

void trim( string& s )
{
	int j;
	for( j=s.length()-1; j >=0  &&  isspace(s[j]); j-- )
	{
	}
	s.erase( j + 1);

	int len = s.length();
	for( j=0; j < len  &&  isspace(s[j]); j++ )
	{
	}
	s.erase( 0, j );
}

void trim(char* szpalabra)
{
    trim(szpalabra, 1, strlen(szpalabra), szpalabra);
}


void trim(const char* szpalabra)
{
    trim((char *) szpalabra, 1, strlen(szpalabra), (char *) szpalabra);
}

void trim(char *szpalabra, int iini, int ilargo, char* szvuelta)
{
    int ii;
    szpalabra += iini - 1;
    for (ii=iini;ii<=(iini + ilargo -1);ii++)
    {
        if (*szpalabra != 32)
           {
           *szvuelta = *szpalabra;
           szvuelta++;
           }
        szpalabra++;
    }
   *szvuelta = 0;
}




long gregorianoajuliano(int dia, int mes, int anno)
{
   /* dada una fecha del calendario gregoriano, obtiene */
   /*un entero que la representa */
   long tmes, tanno;
   long jdia;
   /* marzo es el mes 0 del año */
   if (mes > 2)
   {
      tmes = mes - 3;
      tanno = anno;
   }
   else
   /* febrero es el mes 11 del año anterior. */
   {
      tmes = mes + 9;
      tanno = anno - 1;
   }
   jdia = (tanno / 4000) * 1460969;
   tanno = (tanno % 4000);
   jdia = jdia +
      (((tanno / 100) * 146097) / 4) +
      (((tanno % 100) * 1461) / 4) +
      (((153 * tmes) + 2) / 5) +
      dia +
      1721119;
   return jdia;
}


/*****************************************************************************/
/*                      funcion : bRestaFechas                               */
/* -Funcion que resta Fecha1 y Fecha2                                        */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
bool bRestaFechas (char *szFecha1,char *szFecha2,int *iNumDias)
{
    char szDia1 [3];
    char szMes1 [3];
    char szAno1 [5];
    char szDia2 [3];
    char szMes2 [3];
    char szAno2 [5];
    long lValjul ;

        sprintf ( szDia1, "%c%c", szFecha1[6],szFecha1[7]);
        sprintf ( szMes1, "%c%c", szFecha1[4],szFecha1[5]);
        sprintf ( szAno1, "%c%c%c%c", szFecha1[0],szFecha1[1],szFecha1[2],szFecha1[3]);

        sprintf ( szDia2, "%c%c", szFecha2[6],szFecha2[7]);
        sprintf ( szMes2, "%c%c", szFecha2[4],szFecha2[5]);
        sprintf ( szAno2, "%c%c%c%c", szFecha2[0],szFecha2[1],szFecha2[2],szFecha2[3]);

        lValjul = gregorianoajuliano(atoi(szDia1),atoi(szMes1),atoi(szAno1)) - gregorianoajuliano(atoi(szDia2),atoi(szMes2),atoi(szAno2));

        lValjul = (lValjul <= 0)?(-1*(lValjul)):(lValjul+1);

    *iNumDias =(int)lValjul;

    return (true);

}


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


