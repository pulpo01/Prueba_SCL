#ident "@(#)$RCSfile: token.h,v $ $Revision: 1.5 $ $Date: 2004/04/16 21:07:35 $"
#ifndef TOKEN_H
#define TOKEN_H

//#include <iostream>
#include <algorithm>
#include <string>
#include <vector>

// Clase para poder tokenizar un string en base a varios separadores
class Tokenizer
{
    struct sep_par{
        int iBegin;
        int iEnd;
        bool operator< (sep_par z) const { return (iBegin < z.iBegin) || (iBegin==z.iBegin && iEnd < z.iEnd); }
    };

    std::string m_sText;
    unsigned int m_iWordCount;

    std::vector<std::string> m_vtSeparators;
    std::vector<sep_par> m_vtSepPositions;
    std::vector<sep_par> m_vtWords;
    
public:

    // Ojo, si usa ostringstream para dar como parametro al constructor, no inserte el std::ends
    // al final, por que el metodo Execute retornara un token mas de los que contiene realmente
    // el string contenido por el ostringstream
    Tokenizer(const std::string &sText, const std::string &sSep): m_sText(sText), m_iWordCount(0){
        SetSeparator(sSep);
    }

    Tokenizer(const std::string &sText, const std::vector<std::string> &vecsep): m_sText(sText),
        m_iWordCount(0), m_vtSeparators(vecsep) {};

    ~Tokenizer(){
        m_vtSeparators.clear();
        m_vtSepPositions.clear();
        m_vtWords.clear();
    }

    void SetSeparator(const std::string &sSep){ m_vtSeparators.push_back(sSep); }

    int Execute(){
        int iLength;

        sep_par aux;
        aux.iBegin = -1;
        aux.iEnd = -1;
        m_vtSepPositions.push_back(aux);

        std::string stmpeliminaralfinal;
        for(unsigned int i=0; i < m_vtSeparators.size(); i++){
            iLength = m_vtSeparators[i].size() - 1;
            for(int j=m_sText.find(stmpeliminaralfinal=m_vtSeparators[i]); j >=0; j=m_sText.find(m_vtSeparators[i], j+1) ){
                sep_par tmp;
                tmp.iBegin = j;
                tmp.iEnd   = j + iLength;
                m_vtSepPositions.push_back(tmp);
            }
        }
        
        aux.iBegin = m_sText.size();
        aux.iEnd   = m_sText.size();
        m_vtSepPositions.push_back(aux);
        
        sort(m_vtSepPositions.begin(), m_vtSepPositions.end());
        
        //Eliminar el mas pequeño de los que tienen repetidos.
        
        for(unsigned int i = 0; i < m_vtSepPositions.size()-1; i++){                
            if ( m_vtSepPositions[i].iEnd + 1 != m_vtSepPositions[i+1].iBegin ){
                aux.iBegin = m_vtSepPositions[i].iEnd +1;
                aux.iEnd   = m_vtSepPositions[i+1].iBegin -1;
                if(aux.iBegin <= aux.iEnd)
                    m_vtWords.push_back(aux);
            }
        }
        
        m_vtSepPositions.clear();
        m_iWordCount = m_vtWords.size();
        return m_iWordCount;
    }
    
    std::string GetWord(unsigned int i){
        if ( i < 0 || i >= m_iWordCount)
            return "";
        return m_sText.substr( m_vtWords[i].iBegin, m_vtWords[i].iEnd - m_vtWords[i].iBegin + 1);
    }

    int GetPosWord(unsigned int i){
        if ( i < 0 || i >= m_iWordCount)
            return -1;
        return  m_vtWords[i].iBegin;
    }
    
    std::string GetSeparator(unsigned int i){
  
        if ( i < 0 || i > m_iWordCount)
            return "";
        
        std::string sReturn;
        if ( i +1 <= m_vtWords.size() -1 )
            sReturn = m_sText.substr( m_vtWords[i].iEnd + 1, (m_vtWords[i+1].iBegin - 1) - (m_vtWords[i].iEnd + 1) + 1);
        else
            sReturn = m_sText.substr( m_vtWords[i].iEnd+1);
        return sReturn;
    }
    
    int GetPosSep(unsigned int i){
        if ( i +1 <= m_vtWords.size() -1 )
            return m_vtWords[i].iEnd+1;
        else
            return 0;
    }

    std::string FirstSeparatorIfExists(){
        if (m_vtWords.size()>0 && m_vtWords[0].iBegin >0)
            return m_sText.substr(0, m_vtWords[0].iBegin);
        else if (!m_sText.empty() && m_vtWords.size() == 0) 
            return m_sText;
        return "";
    }

    //////////////////////////////////////////////////////////////////////////
    //
    // Funcion que convierte un std::string del tipo:
    //     1, 4, 6-10
    //
    // En un vector del tipo con enteros que contiene los numeros
    //     1, 4, 6, 7, 8, 9, 10
    // 
    // Los casos raros lo ignora, por ejemplo
    //     1, 5-5-9,8-15,20-10,6-,-34, a
    //
    // retorna un vector con los siguientes elementos:
    //     1, 5, 8, 9, 10, 11, 12, 13, 14, 15, 6, 34, 0
    //////////////////////////////////////////////////////////////////////////
    static std::vector<int> strtovector(const std::string& sStr)
    {
        Tokenizer tokfield(sStr, ",");
        
        std::vector<int> vtAux;
        int iFields = tokfield.Execute();
        
        for(int i = 0; i < iFields; i++)
        {
            Tokenizer tokaux(tokfield.GetWord(i), "-");
            int iFields = tokaux.Execute();
            int iTo = atoi(tokaux.GetWord((iFields >1)?1:0).c_str());
            for(int j=atoi(tokaux.GetWord(0).c_str()); j <= iTo; j++)
                vtAux.push_back(j);
        }
        return vtAux;
    }
    

};

#endif // token_h

/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza : */
/** %ARCHIVE% */
/** Identificador en PVCS : */
/** %PID% */
/** Producto : */
/** %PP% */
/** Revisión : */
/** %PR% */
/** Autor de la Revisión : */
/** %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/** %PS% */
/** Fecha de Creación de la Revisión : */
/** %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

