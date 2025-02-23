
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned int magic;
  };
  typedef struct sql_cursor sql_cursor;
  typedef struct sql_cursor SQL_CURSOR;
#endif /* SQL_CRSR */

/* Thread Safety */
typedef void * sql_context;
typedef void * SQL_CONTEXT;

/* Object support */
struct sqltvn
{
  unsigned char *tvnvsn; 
  unsigned short tvnvsnl; 
  unsigned char *tvnnm;
  unsigned short tvnnml; 
  unsigned char *tvnsnm;
  unsigned short tvnsnml;
};
typedef struct sqltvn sqltvn;

struct sqladts
{
  unsigned int adtvsn; 
  unsigned short adtmode; 
  unsigned short adtnum;  
  sqltvn adttvn[1];       
};
typedef struct sqladts sqladts;

static struct sqladts sqladt = {
  1,1,0,
};

/* Binding to PL/SQL Records */
struct sqltdss
{
  unsigned int tdsvsn; 
  unsigned short tdsnum; 
  unsigned char *tdsval[1]; 
};
typedef struct sqltdss sqltdss;
static struct sqltdss sqltds =
{
  1,
  0,
};

/* File name & Package Name */
struct sqlcxp
{
  unsigned short fillen;
           char  filnam[21];
};
static const struct sqlcxp sqlfpn =
{
    20,
    "./pc/EncriptaSha1.pc"
};


static unsigned int sqlctx = 55221619;


static struct sqlexd {
   unsigned long  sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
      const short *cud;
   unsigned char  *sqlest;
      const char  *stmt;
   sqladts *sqladtp;
   sqltdss *sqltdsp;
   unsigned char  **sqphsv;
   unsigned long  *sqphsl;
            int   *sqphss;
            short **sqpind;
            int   *sqpins;
   unsigned long  *sqparm;
   unsigned long  **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
   unsigned int   sqlcmax;
   unsigned int   sqlcmin;
   unsigned int   sqlcincr;
   unsigned int   sqlctimeout;
   unsigned int   sqlcnowait;
            int   sqfoff;
   unsigned int   sqcmod;
   unsigned int   sqfmod;
   unsigned char  *sqhstv[1];
   unsigned long  sqhstl[1];
            int   sqhsts[1];
            short *sqindv[1];
            int   sqinds[1];
   unsigned long  sqharm[1];
   unsigned long  *sqharc[1];
   unsigned short  sqadto[1];
   unsigned short  sqtdso[1];
} sqlstm = {12,1};

/* SQLLIB Prototypes */
extern void sqlcxt (void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlcx2t(void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlbuft(void **, char *);
extern void sqlgs2t(void **, char *);
extern void sqlorat(void **, unsigned int *, void *);

/* Forms Interface */
static const int IAPSUCC = 0;
static const int IAPFAIL = 1403;
static const int IAPFTL  = 535;
extern void sqliem(char *, int *);

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
};


/*
 *  sha1.c
 *
 *	Copyright (C) 1998
 *	Paul E. Jones <paulej@arid.us>
 *	All Rights Reserved
 *
 *****************************************************************************
 *	$Id: sha1.c,v 1.2 2004/03/27 18:00:33 paulej Exp $
 *****************************************************************************
 *
 *  Description:
 *      This file implements the Secure Hashing Standard as defined
 *      in FIPS PUB 180-1 published April 17, 1995.
 *
 *      The Secure Hashing Standard, which uses the Secure Hashing
 *      Algorithm (SHA), produces a 160-bit message digest for a
 *      given data stream.  In theory, it is highly improbable that
 *      two messages will produce the same message digest.  Therefore,
 *      this algorithm can serve as a means of providing a "fingerprint"
 *      for a message.
 *
 *  Portability Issues:
 *      SHA-1 is defined in terms of 32-bit "words".  This code was
 *      written with the expectation that the processor has at least
 *      a 32-bit machine word size.  If the machine word size is larger,
 *      the code should still function properly.  One caveat to that
 *      is that the input functions taking characters and character
 *      arrays assume that only 8 bits of information are stored in each
 *      character.
 *
 *  Caveats:
 *      SHA-1 is designed to work with messages less than 2^64 bits
 *      long. Although SHA-1 allows a message digest to be generated for
 *      messages of any number of bits less than 2^64, this
 *      implementation only works with messages with a length that is a
 *      multiple of the size of an 8-bit character.
 *
 */

#include "EncriptaSha1.h"

/*
 *  Define the circular shift macro
 */
#define SHA1CircularShift(bits,word) \
                ((((word) << (bits)) & 0xFFFFFFFF) | \
                ((word) >> (32-(bits))))     

/* Function prototypes */
void SHA1ProcessMessageBlock(SHA1Context *);
void SHA1PadMessage(SHA1Context *);

/*  
 *  SHA1Reset
 *
 *  Description:
 *      This function will initialize the SHA1Context in preparation
 *      for computing a new message digest.
 *
 *  Parameters:
 *      context: [in/out]
 *          The context to reset.
 *
 *  Returns:
 *      Nothing.
 *
 *  Comments:
 *
 */
void SHA1Reset(SHA1Context *context)
{
    context->Length_Low             = 0;
    context->Length_High            = 0;
    context->Message_Block_Index    = 0;

    context->Message_Digest[0]      = 0x67452301;
    context->Message_Digest[1]      = 0xEFCDAB89;
    context->Message_Digest[2]      = 0x98BADCFE;
    context->Message_Digest[3]      = 0x10325476;
    context->Message_Digest[4]      = 0xC3D2E1F0;

    context->Computed   = 0;
    context->Corrupted  = 0;
}

/*  
 *  SHA1Result
 *
 *  Description:
 *      This function will return the 160-bit message digest into the
 *      Message_Digest array within the SHA1Context provided
 *
 *  Parameters:
 *      context: [in/out]
 *          The context to use to calculate the SHA-1 hash.
 *
 *  Returns:
 *      1 if successful, 0 if it failed.
 *
 *  Comments:
 *
 */
int SHA1Result(SHA1Context *context)
{

    if (context->Corrupted)
    {
        return 0;
    }

    if (!context->Computed)
    {
        SHA1PadMessage(context);
        context->Computed = 1;
    }

    return 1;
}

/*  
 *  SHA1Input
 *
 *  Description:
 *      This function accepts an array of octets as the next portion of
 *      the message.
 *
 *  Parameters:
 *      context: [in/out]
 *          The SHA-1 context to update
 *      message_array: [in]
 *          An array of characters representing the next portion of the
 *          message.
 *      length: [in]
 *          The length of the message in message_array
 *
 *  Returns:
 *      Nothing.
 *
 *  Comments:
 *
 */
void SHA1Input(     SHA1Context         *context,
                    char                *message_array,
                    unsigned            length)
{
    if (!length)
    {
        return;
    }

    if (context->Computed || context->Corrupted)
    {
        context->Corrupted = 1;
        return;
    }

    while(length-- && !context->Corrupted)
    {
        context->Message_Block[context->Message_Block_Index++] =
                                                (*message_array & 0xFF);

        context->Length_Low += 8;
        /* Force it to 32 bits */
        context->Length_Low &= 0xFFFFFFFF;
        if (context->Length_Low == 0)
        {
            context->Length_High++;
            /* Force it to 32 bits */
            context->Length_High &= 0xFFFFFFFF;
            if (context->Length_High == 0)
            {
                /* Message is too long */
                context->Corrupted = 1;
            }
        }

        if (context->Message_Block_Index == 64)
        {
            SHA1ProcessMessageBlock(context);
        }

        message_array++;
    }
}

/*  
 *  SHA1ProcessMessageBlock
 *
 *  Description:
 *      This function will process the next 512 bits of the message
 *      stored in the Message_Block array.
 *
 *  Parameters:
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Comments:
 *      Many of the variable names in the SHAContext, especially the
 *      single character names, were used because those were the names
 *      used in the publication.
 *         
 *
 */
void SHA1ProcessMessageBlock(SHA1Context *context)
{
    const unsigned K[] =            /* Constants defined in SHA-1   */      
    {
        0x5A827999,
        0x6ED9EBA1,
        0x8F1BBCDC,
        0xCA62C1D6
    };
    int         t;                  /* Loop counter                 */
    unsigned    temp;               /* Temporary word value         */
    unsigned    W[80];              /* Word sequence                */
    unsigned    A, B, C, D, E;      /* Word buffers                 */

    /*
     *  Initialize the first 16 words in the array W
     */
    for(t = 0; t < 16; t++)
    {
        W[t]  = ((unsigned) context->Message_Block[t * 4]) << 24;
        W[t] |= ((unsigned) context->Message_Block[t * 4 + 1]) << 16;
        W[t] |= ((unsigned) context->Message_Block[t * 4 + 2]) << 8;
        W[t] |= ((unsigned) context->Message_Block[t * 4 + 3]);
    }

    for(t = 16; t < 80; t++)
    {
       W[t] = SHA1CircularShift(1,W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16]);
    }

    A = context->Message_Digest[0];
    B = context->Message_Digest[1];
    C = context->Message_Digest[2];
    D = context->Message_Digest[3];
    E = context->Message_Digest[4];

    for(t = 0; t < 20; t++)
    {
        temp =  SHA1CircularShift(5,A) +
                ((B & C) | ((~B) & D)) + E + W[t] + K[0];
        temp &= 0xFFFFFFFF;
        E = D;
        D = C;
        C = SHA1CircularShift(30,B);
        B = A;
        A = temp;
    }

    for(t = 20; t < 40; t++)
    {
        temp = SHA1CircularShift(5,A) + (B ^ C ^ D) + E + W[t] + K[1];
        temp &= 0xFFFFFFFF;
        E = D;
        D = C;
        C = SHA1CircularShift(30,B);
        B = A;
        A = temp;
    }

    for(t = 40; t < 60; t++)
    {
        temp = SHA1CircularShift(5,A) +
               ((B & C) | (B & D) | (C & D)) + E + W[t] + K[2];
        temp &= 0xFFFFFFFF;
        E = D;
        D = C;
        C = SHA1CircularShift(30,B);
        B = A;
        A = temp;
    }

    for(t = 60; t < 80; t++)
    {
        temp = SHA1CircularShift(5,A) + (B ^ C ^ D) + E + W[t] + K[3];
        temp &= 0xFFFFFFFF;
        E = D;
        D = C;
        C = SHA1CircularShift(30,B);
        B = A;
        A = temp;
    }

    context->Message_Digest[0] =
                        (context->Message_Digest[0] + A) & 0xFFFFFFFF;
    context->Message_Digest[1] =
                        (context->Message_Digest[1] + B) & 0xFFFFFFFF;
    context->Message_Digest[2] =
                        (context->Message_Digest[2] + C) & 0xFFFFFFFF;
    context->Message_Digest[3] =
                        (context->Message_Digest[3] + D) & 0xFFFFFFFF;
    context->Message_Digest[4] =
                        (context->Message_Digest[4] + E) & 0xFFFFFFFF;

    context->Message_Block_Index = 0;
}

/*  
 *  SHA1PadMessage
 *
 *  Description:
 *      According to the standard, the message must be padded to an even
 *      512 bits.  The first padding bit must be a '1'.  The last 64
 *      bits represent the length of the original message.  All bits in
 *      between should be 0.  This function will pad the message
 *      according to those rules by filling the Message_Block array
 *      accordingly.  It will also call SHA1ProcessMessageBlock()
 *      appropriately.  When it returns, it can be assumed that the
 *      message digest has been computed.
 *
 *  Parameters:
 *      context: [in/out]
 *          The context to pad
 *
 *  Returns:
 *      Nothing.
 *
 *  Comments:
 *
 */
void SHA1PadMessage(SHA1Context *context)
{
    /*
     *  Check to see if the current message block is too small to hold
     *  the initial padding bits and length.  If so, we will pad the
     *  block, process it, and then continue padding into a second
     *  block.
     */
    if (context->Message_Block_Index > 55)
    {
        context->Message_Block[context->Message_Block_Index++] = 0x80;
        while(context->Message_Block_Index < 64)
        {
            context->Message_Block[context->Message_Block_Index++] = 0;
        }

        SHA1ProcessMessageBlock(context);

        while(context->Message_Block_Index < 56)
        {
            context->Message_Block[context->Message_Block_Index++] = 0;
        }
    }
    else
    {
        context->Message_Block[context->Message_Block_Index++] = 0x80;
        while(context->Message_Block_Index < 56)
        {
            context->Message_Block[context->Message_Block_Index++] = 0;
        }
    }

    /*
     *  Store the message length as the last 8 octets
     */
    context->Message_Block[56] = (context->Length_High >> 24) & 0xFF;
    context->Message_Block[57] = (context->Length_High >> 16) & 0xFF;
    context->Message_Block[58] = (context->Length_High >> 8) & 0xFF;
    context->Message_Block[59] = (context->Length_High) & 0xFF;
    context->Message_Block[60] = (context->Length_Low >> 24) & 0xFF;
    context->Message_Block[61] = (context->Length_Low >> 16) & 0xFF;
    context->Message_Block[62] = (context->Length_Low >> 8) & 0xFF;
    context->Message_Block[63] = (context->Length_Low) & 0xFF;

    SHA1ProcessMessageBlock(context);
}

 /* ********************************************************************************* */
/* * FUNCION : EncriptarSHA1                                                        * */
/* * USO     : Se encarga de realizar la ejecuci�n de las funciones de Encriptacion * */
/* ********************************************************************************** */
BOOL EncriptarSHA1(char *cadena, char *szCadenaResultado)
{
    SHA1Context sha;
    int i,paso;
    SHA1Context resultado;

    SHA1Reset(&sha);
    SHA1Input(&sha, cadena, strlen(cadena));
    
    if (!SHA1Result(&sha))
    {
        return FALSE;
    }
    else
    {
    	for(i = 0; i < 5 ; i++)
    	{
            resultado.Message_Digest[i] = sha.Message_Digest[i];
        }
        
    sprintf(szCadenaResultado,"%08x%08x%08x%08x%08x\0"
                            ,resultado.Message_Digest[0], resultado.Message_Digest[1]
                            ,resultado.Message_Digest[2], resultado.Message_Digest[3]
                            ,resultado.Message_Digest[4]);                           
    }          
            
    return TRUE;
}

void lrtrim (const char *c, char *result)
{
   char *l;
   char *r;
   for(l=(char *)c;  *l==' '; l++);
   for(r=(char *)c+strlen(c)-1;  *r==' '; r--);

   strncpy(result, l, (r>=l)?r-l+1:1);
   result[r-l+1]=0;
}/* END trim */
 
/* ************************************************************************** */
/* * FUNCION : bfnEncriptaContTec                                           * */
/* * USO     : Encriptar Datos                                              * */
/* ************************************************************************** */
BOOL bfnEncriptaContTec (char   *szCadenaResultado, char   *szpref_folio,  
                         long   lCorre_Folio,       char   *szFecEmision,     
                         char   *szHorEmision,      double dhTotalFactura,     
                         double dhTotalIva,         char   *szKeyConTecnico,
                         char   *szCodIdTipDian,    char   *szhNumIdTrib,
                         char   *szNitOperadora  )
{
    char        modulo[]="bfnEncriptarDatos";
    char        szCadena               [500];
    char        szhPref_folio           [26]; /* P-MIX-09003 */
    char        szhCorre_folio          [25];
    char        szhFecEmision            [9];
    char        szhHorEmision            [7];
    char        szhTotalFactura         [23];
    char        szhTotalIva             [23];
    char        szhNitOperadora         [16];
    char        szhCodIdTipDian          [3];
    char        szhKeyConTecnico        [41];
    
    /* Prefijo Folio */
    memset(szhPref_folio,0,sizeof(szhPref_folio));
    strncpy(szhPref_folio,szpref_folio,25); /* P-MIX-09003 */
    lrtrim(szhPref_folio, szhPref_folio);
    
    /* N�mero Folio */
    memset(szhCorre_folio,0,sizeof(szhCorre_folio));
    /**/    
    sprintf(szhCorre_folio,"%ld",lCorre_Folio); 
    lrtrim(szhCorre_folio, szhCorre_folio);
    
    /* Fecha Emisi�n */
    memset(szhFecEmision,0,sizeof(szhFecEmision));
    strncpy(szhFecEmision,szFecEmision,8);
    lrtrim(szhFecEmision, szhFecEmision);
    
    /* Hora Emisi�n */    
    memset(szhHorEmision,0,sizeof(szhHorEmision));    
    strncpy(szhHorEmision,szHorEmision,6);    
    lrtrim(szhHorEmision, szhHorEmision);
    
    /* Total Factura */
    sprintf(szhTotalFactura,"%20.2f",dhTotalFactura);
    lrtrim(szhTotalFactura, szhTotalFactura);
    
    /* IVA Factura */
    sprintf(szhTotalIva,"%20.2f",dhTotalIva);
    lrtrim(szhTotalIva, szhTotalIva);
    
    /* NIT Operadora */
    memset(szhNitOperadora,0,sizeof(szhNitOperadora));
    strncpy(szhNitOperadora,szNitOperadora,15);    
    lrtrim(szhNitOperadora, szhNitOperadora);
    
    /* Tipo Iden. Documento*/
    memset(szhCodIdTipDian,0,sizeof(szhCodIdTipDian));    
    strncpy(szhCodIdTipDian,szCodIdTipDian,2);    
    lrtrim(szhCodIdTipDian, szhCodIdTipDian);
            
    /* Clave Contenido Tecnico */
    memset(szhKeyConTecnico,0,sizeof(szhKeyConTecnico));
    strncpy(szhKeyConTecnico,szKeyConTecnico,40);        
    lrtrim(szhKeyConTecnico, szhKeyConTecnico);
        
    /* Valores de Entrada */
    vDTrazasLog(modulo , "\n\t ** Campos a Encriptar **"
                         "\n\t *******************************"
                         "\n\t Prefijo Plaza    [%s]"
                         "\n\t Numero Factura   [%s]"
                         "\n\t Fecha Emision    [%s]"
                         "\n\t Hora Emision     [%s]"                         
                         "\n\t Valor Factura    [%s]"
                         "\n\t IVA Factura      [%s]"
                         "\n\t Nit Operadora    [%s]"
                         "\n\t Tipo Documento   [%s]"
                         "\n\t Numero Documento [%s]"
                         "\n\t Clave T�cnico    [%s]"                                                  
                       ,LOG05
                       ,szhPref_folio      , szhCorre_folio
                       ,szhFecEmision      , szhHorEmision
                       ,szhTotalFactura    , szhTotalIva
                       ,szhNitOperadora    , szhCodIdTipDian
                       ,szhNumIdTrib       , szhKeyConTecnico);                           
    
    /* Concatena campos a encriptar */
    sprintf(szCadena,"%s%s%s%s%s%s%s%s%s%s"
                    ,szpref_folio       , szhCorre_folio
                    ,szhFecEmision      , szhHorEmision
                    ,szhTotalFactura    , szhTotalIva
                    ,szhNitOperadora    , szhCodIdTipDian
                    ,szhNumIdTrib       , szhKeyConTecnico);
                    
    if (!EncriptarSHA1(szCadena, szCadenaResultado))
    {
        vDTrazasLog  ( modulo , "\n\tERROR - Al encriptar campos [%s]",LOG01,szCadena);
        vDTrazasError( modulo , "\n\tERROR - Al encriptar campos [%s]",LOG01,szCadena);
        return FALSE;        
    }
    

    vDTrazasLog(modulo , "\n\t** ENCRIPTACION **"
                         "\n\t******************",LOG05);
    vDTrazasLog(modulo , "\n\t\tCampos a Encriptar [%s]",LOG05,szCadena);
    vDTrazasLog(modulo , "\n\t\tCampos Encriptados [%s]",LOG05,szCadenaResultado);    
            
    return TRUE;                    
}/* END bfnEncriptaContTec */    

