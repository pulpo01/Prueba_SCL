#ifndef NO_INDENT
#ident "@(#)$RCSfile: Indent.h,v $ $Revision: 1.1 $ $Date: 2008/07/14 16:47:23 $"
#endif

///
/// \file Indent.h
///


#ifndef INDENT_H
#define INDENT_H

#define INIT_SIZE 256
#define ADD_SIZE  100

bool allocMemory(char **pCaracters, int size)
{
	if( (*pCaracters = (char*) malloc(size * sizeof(char))) == NULL)
		return false;
	else
	{
		memset(*pCaracters,'\0',size);
	    return true;
	}
}

void deallocMemory(char *pCaracters)
{
	if( pCaracters !=  NULL)
		free(pCaracters);
}

bool manageMemory(char **pCaracters, int size,  int* pMaxSize)
{
	if(size > *pMaxSize)
	{
		*pMaxSize += ( (size-*pMaxSize) > ADD_SIZE ? (size-*pMaxSize) : ADD_SIZE);
		if( (*pCaracters = (char*) realloc(*pCaracters, *pMaxSize * sizeof(char))) == NULL )
			return false;
		else
            memset((char*) (*pCaracters+(size-1)),'\0',*pMaxSize-(size-1));
	}
	
	return true;
}

void clearMemory(char *pCaracters, int start,  int size)
{
    memset((char*) (pCaracters+start),'\0',size);
}

char* getIndentInfo(char *binaryFile) 
{
    static int        delimiters[] = { '@','(','#',')','$' };
	static const int  cantDelimiters = sizeof(delimiters)/sizeof(int);
    static FILE       *pFDesc = NULL;
    static char       *pAllFName = NULL;

	char              *pFName = NULL;
	char              *pInfo = NULL;
	char              *pChar = NULL;
	char              *pResult = NULL;

	int               sInfo = INIT_SIZE;
	int               sFName = INIT_SIZE;
	int               sAllFName = INIT_SIZE;
	int               i = 0, j = 0, carac = 0;

	//\ Init Static Values (First funcion call)
    if(pFDesc == NULL) 
    {
        if( (pFDesc=fopen( binaryFile, "rb" )) == NULL ) return NULL;
		if(!allocMemory(&pAllFName,sAllFName)) return NULL;
	}
    
	//\ Allocate Local Values (Every funcion call)
	if(!allocMemory(&pInfo, sInfo)) return NULL;
	if(!allocMemory(&pFName,sFName)) return NULL;

    while( (carac=fgetc(pFDesc)) != EOF )
    {
		//\ Get start of Indent values...
        if ( carac == delimiters[j++] )
        {
            if(j == cantDelimiters)
            {
				//\ Init Var
				j = 0;
				i = 0;
				clearMemory(pInfo,0,sInfo);
				clearMemory(pFName,0,sFName);

				//\ Get Indent Info...
				while(  manageMemory(&pInfo,i,&sInfo) && 
						(carac=fgetc(pFDesc)) )
                    pInfo[i++] = carac;

				//\ Get FileName...
                if( (pChar=strchr(pInfo,' ')) == NULL ) 
					return NULL;
				pChar++;
				i = 0;
				while(  manageMemory(&pFName,i,&sFName) && 
						(*pChar != ' ') )
                    pFName[i++] = *pChar++;

				//\ Check if FileName already processed...
                pChar = strstr(pAllFName, pFName);
                if ( (pChar == NULL) && 
                     manageMemory(&pAllFName,strlen(pAllFName)+strlen(pInfo)+1,&sAllFName) ) 
                {
					i = strlen(pAllFName);
                    strcat(pAllFName,pInfo);
					pResult = pAllFName+i;
					break;
                }
            }
        }
        else
            j = 0;
    };

	//\ Desallocate Local Values (Every funcion call)
	deallocMemory(pInfo);
    deallocMemory(pFName);
	
	//\ End of binaryFile...
	//\ Desallocate Static Values (Last funcion call)
	if(carac == EOF)
    {
		fclose(pFDesc);
		deallocMemory(pAllFName);
	}

    return pResult;
}

#endif

