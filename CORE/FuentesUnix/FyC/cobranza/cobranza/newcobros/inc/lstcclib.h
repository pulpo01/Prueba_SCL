/**********************************************************************/
/* FICHERO    : lstcclib.h                                            */
/* DESCRIPCION: Tipos de datos y cabeceras de las PRIMITIVAS para una */
/*              LISTA SIMPLEMENTE ENLAZADA CON CABECERA.              */
/* AUTOR      : Johnny Cortés                                         */
/* Fecha      : 06/12/2003                                            */
/* Version    : 1.0                                                   */
/**********************************************************************/
int  Inicializar_lista(stLista *list);
int  Lista_vacia(stLista list);
int  Insertar_pos (stLista ant, struct stCliente e, long pos);
int  Insertar_orden (stLista ant, struct stCliente e);
int  Borrar_elemento(stLista ant, int pos);
long Long_lista(stLista list);
void Vaciar_lista(stLista list);
void Destruir_lista(stLista *list);
int  Leer_element (stLista list, long pos, struct stCliente *e);
long Posic_lista(stLista list, struct stCliente e, long pos);
int  Actualiza_lista(stLista list, struct stCliente e, long pos);
/*****************************************************************************************************/
/*****************************************************************************************************/
int  ifnIniListCateg(lista_Categ *list);
int  ifnIniListCrit(lista_Crit *list);
int  ifnIniListAcc(lista_Acc *list);
int  ifnIniListPto(lista_Pto *list);
int  ifnIniListSecPto(lista_SecPtos *list);
int  ifnInsertaCateg (lista_Categ *ant);
int  ifnInsertaCrit(lista_Crit *ant);
int  ifnInsertaAcc(lista_Acc *ant);
int  ifnInsertaPto (lista_Pto *ant);
int  ifnInsertaSecPto(lista_SecPtos *ant);
void vfnMuestraCateg(lista_Categ list);
void vfnMuestraListaCrit(lista_Crit list);
void vfnMuestraListaAcc(lista_Acc list);
void vfnMuestraLista(lista_Pto list);
void vfnMuestraListaSecPto(lista_SecPtos list);
int  ifnBorraCateg(lista_Categ *ant);
int  ifnBorraCrit(lista_Crit *ant);
int  ifnBorraAcc(lista_Acc *ant);
int  ifnBorraPto(lista_Pto *ant);
int  ifnBorraSecPto(lista_SecPtos *ant);
void vfnBorraListaCateg(lista_Categ *list);
void vfnBorraListaCrit(lista_Crit *list);
void vfnBorraListaAcc(lista_Acc *list);
void vfnBorraListaPto(lista_Pto *list);
void vfnBorraListaSecPto(lista_SecPtos *list);
/*****************************************************************************************************/
/*****************************************************************************************************/
int ifnIniListAccion(stLista lstCLTE, lstAccCM NodoAcc);
int ifnInsertaNodoAcc(stLista lstCLTE, lstAccCM NodoAcc );
int ifnBorraNodoAccion(lstAccCM *ant);
void vfnEliminaNodoAccion(lstAccCM *list);
/*****************************************************************************************************/
/*****************************************************************************************************/
/*P-MAS-04037 */
int ifnInsertaClie(Lista_Clie *ant);
void vfnBorraListaClie(Lista_Clie *list);
int ifnBorraCli(Lista_Clie *ant);
int ifnInsertaClieHilo(Lista_Hilo *ant);
int ifnInsertaNodoAccion(Lista_Acc *ant);
void vfnBorraNodoAcc(Lista_Acc *list);
int ifnBorraNodoAcc(Lista_Acc *ant);
void vfnBorraListaHilo(Lista_Hilo *list);
/*****************************************************************************************************
	Funciones para listas enlazadas.
*****************************************************************************************************/
/* Inicializa una lista simplemente enlazada y CON cabecera. */
/* Devuelve -1 en caso de ERROR. */
int Inicializar_lista(stLista *list){
	if (((*list)=(struct TNodo *) malloc(sizeof(struct TNodo))) == NULL)
		return -1;
	(*list)->sgte=NULL;
	return 0;
}

/***************************************************************/
/* Devuelve TRUE si la lista está vacía. */
int Lista_vacia(stLista list){
	if (list != NULL ) {
	   if (list->sgte) return 0;
	}
	return 1;
}

/***************************************************************/
/* Inserta el elemento e en la posición pos de la lista ant. */
/* Si pos<=1 inserta en la primera posición. */
/* Si pos>longitud_lista, inserta en la última posición. */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int Insertar_pos (stLista ant, struct stCliente e, long pos){
	stLista p, L=ant->sgte;
	long i=1;

	if ((p=(struct TNodo *) malloc(sizeof(struct TNodo))) == NULL)
		return -1;
	p->Campo=e;
	p->Accion_sgte = NULL;
	while (L && i<pos){ /* Hallar posición en la que insertar */
		ant=L;
		L=L->sgte;
		i++;
	} /* end while */
	ant->sgte=p; /* Insertar elemento apuntado por p, entre anterior y L */
	p->sgte=L;
	return 0;
}

/***************************************************************/
/* Inserta el elemento e en la lista ant ordenadamente por */
/* el campo elem.num */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int Insertar_orden (stLista ant, struct stCliente e){
	stLista pf, L=ant->sgte;
	unsigned i=1;

	if ((pf=(struct TNodo *) malloc(sizeof(struct TNodo))) == NULL)
		return -1;
	pf->Campo=e;
	pf->Accion_sgte = NULL;
	while (L && e.lCod_Cliente > L->Campo.lCod_Cliente){ /* Hallar posición en la que insertar */
		ant=L;
		L=L->sgte;
		i++;
	}
	ant->sgte=pf; /* Insertar elemento apuntado por p, entre anterior y L */
	pf->sgte=L;
	return 0;
}

/***************************************************************/
/* Borra el elemento en la posición pos de la lista ant. */
/* Si la pos=1 borra el primer elemento. */
/* Devuelve -1 si no existe la posición: */
/* pila vacía, pos<1 o pos>long */
int Borrar_elemento(stLista ant, int pos){
long i=1;
stLista L=NULL;

	if (ant != NULL ) L=ant->sgte;
	if (Lista_vacia(ant) || pos<1)
		return -1;  /*Posición NO válida */
	while (L && i<pos){ /* Situarse en la posición a borrar */
		ant=L;
		L=L->sgte;
		i++;
	} /* end while */
	if (L){
		/* Borrar elemento apuntado por L, teniendo un puntero al anterior */
		ant->sgte=L->sgte;
		free(L);
		return 0;
	} /* end if */
	return -1; /* La lista tiene menos de pos elementos */
}

/***************************************************************/
/* Devuelve la longitud de la lista list (núm. de elementos). */
long Long_lista(stLista list){
	long i=0;
	list=list->sgte;

	while (list) {
		list=list->sgte;
		i++;
	}
	return i;
}

/***************************************************************/
/* Vacía la lista totalmente, dejándola inicializada. */
/* Tras esta operación NO es necesario inicializarla. */
void Vaciar_lista(stLista list){

	while (Borrar_elemento (list,1) != -1);
}

/***************************************************************/
/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void Destruir_lista(stLista *list){
	Vaciar_lista(*list);
	free(*list); /* Liberar la cabecera */
	*list=NULL;
}

/***************************************************************/
/* Devuelve en e, el elemento que está en la posición pos */
/* de la lista list. */
/* Si no existe esa posición, devuelve -1. En otro caso 0. */
int Leer_element (stLista list, long pos, struct stCliente *e){
	long i=0;

	if (Lista_vacia(list)) {
		return -1;
	}

	while (list && i<pos) { /* Localizar la posición pos */
		i++;
		list=list->sgte;
	} /* end while */
	if (list){
		*e=list->Campo;
		/*printf("e.lCod_Cliente   [%ld]\n",e->lCod_Cliente);
		printf("e.szCod_Tipident [%s]\n",e->szCod_Tipident);
		printf("e.szCod_Comuna [%s]\n",e->szCod_Comuna);
		printf("e.szCod_Ptogest [%s]\n",e->szCod_Ptogest);
		printf("e.szNum_Ident [%s]\n",e->szNum_Ident);*/
		return 0;
	} /* end if */
	return -2;
}

/***************************************************************/
/* Actualiza la posición pos de la lista list con el elemento e*/
/* Devuelve -1 si no existe esa posición. */
int Actualiza_lista(stLista list, struct stCliente e, long pos){
	long i=1;

	if (Lista_vacia(list) || pos<1) return -1; /* Posición no válida */
	list=list->sgte; /* Saltar cabecera */
	while (list && i<pos) { /* Ir a la posición pos */
		list=list->sgte;
		i++;
	} /* end while */
	if (!list) return -1; /* Posición no existe */
	list->Campo=e; /* Actualización */
	return 0;
}

/***************************************************************/
/* Devuelve la posición de la primera ocurrencia del elemento */
/* e en la lista list, a partir de la posición pos (inclusive).*/
/* Esta ocurrencia será considerada por el campo elem.num */
/* Devuelve 0 si no ha sido encontrada. */
/* Con esta función, cambiando pos, podremos encontrar TODAS */
/* las ocurrencias de un elemento en la lista. */
long Posic_lista(stLista list, struct stCliente e, long pos){
	long i=1;

	list=list->sgte; /* Saltar cabecera */
	while (list && i<pos) { /* Ir a la posición pos */
		list=list->sgte;
		i++;
	} /* end while */
	if (!list) return 0; /* No existe posición pos, luego... */
	while (list && e.lCod_Cliente!=list->Campo.lCod_Cliente) { /* Intentar encontrar el elemento */
		list=list->sgte;
		i++;
	} /* end while */
	if (!list) return 0; /* No encontrado */
		return i; /* Encontrado en la posición i */
}


/* FIN de las PRIMITIVAS de la LISTA SIMPLEMENTE ENLAZADA CON CABECERA */


/* Inicializa una lista simplemente enlazada y CON cabecera. */
/* Devuelve -1 en caso de ERROR. */
int ifnIniListCateg(lista_Categ *list)
{
	char modulo[] = "Inicia_lista";
	
	if (( (*list) = (struct Categorias *) malloc(sizeof(struct Categorias))) == NULL)
		return -1;
	(*list)->sig=NULL;

	return 0;
}

/***************************************************************/
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaCateg (lista_Categ *ant){
	lista_Categ p;

	if ((p=(struct Categorias *) malloc(sizeof(struct Categorias))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; /* Insertar elemento apuntado por p, entre anterior y L */
	return 0;
}

/***************************************************************/
/* Muestra todos los elementos de la lista list por su orden. */
void vfnMuestraListaCrit(lista_Crit list)
{
	lista_Crit p = list;
	char modulo[] = "vfnMuestraListaCrit";

        while (p != NULL) 
	{
                ifnTrazasLog(modulo,"\t\tszCodRutina,szNomRutina ->(%s, %s) \n",LOG05, p->szCodRutina, p->szNomRutina);
		p = p->sig;
	}
        /*ifnTrazasLog(modulo,"\t\tp -> NULL \n\n",LOG05);*/
}

/***************************************************************/
/* Muestra todos los elementos de la lista list por su orden. */
void vfnMuestraListaAcc(lista_Acc list){
	lista_Acc p = list;
	char modulo[] = "vfnMuestraListaAcc";

        while (p != NULL) 
	{
                ifnTrazasLog(modulo,"\t\tszCodAccion -> %s \n",LOG05, p->szCodRutina);
		p = p->sig;
	}
        /*ifnTrazasLog(modulo,"\t\tp -> NULL \n\n",LOG05);*/
}

/***************************************************************/
/* Muestra todos los elementos de la lista list por su orden. */
void vfnMuestraLista(lista_Pto list)
{
	lista_Pto p = list;
	char modulo[] = "vfnMuestraLista";

        while (p != NULL) 
	{
                ifnTrazasLog(modulo,"\tCodPtoGest,Num_dias ->(%s, %d) \n",LOG05, p->szCodPtoGest, p->iNumDias);
                vfnMuestraListaCrit(p->Crit_sig);
                vfnMuestraListaAcc(p->Acc_sig);
		p = p->sig;
	}
        /*ifnTrazasLog(modulo,"\tp -> NULL \n\n",LOG05);*/
}


/***************************************************************/
/* Muestra todos los elementos de la lista list por su orden. */
void vfnMuestraCateg(lista_Categ list)
{
	lista_Categ p = list;
	lista_Pto pPtoAux;
	char modulo[] = "vfnMuestraLista";

   while (p != NULL) 
	{
                ifnTrazasLog(modulo,"szCodCategoria -> %s \n",LOG05,p->szCodCategoria);
                pPtoAux = p->pto_sig;
                vfnMuestraLista(pPtoAux);
		p = p->sig;
	}
        /*ifnTrazasLog(modulo,"p -> NULL \n\n",LOG05);*/
}
/***************************************************************/
/* Borra el elemento en la posición pos de la lista ant. */
/* pila vacía, pos<1 o pos>long */
int ifnBorraCateg(lista_Categ *ant){
	lista_Categ aux ;

	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}

/***************************************************************/
/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaCrit(lista_Crit *list){
	lista_Crit L = NULL;
	
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   ifnBorraCrit(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}

/***************************************************************/
/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaAcc(lista_Acc *list){
	lista_Acc L = NULL;
	
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   ifnBorraAcc(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}


/***************************************************************/
/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaPto(lista_Pto *list){
	lista_Pto L = NULL;
	lista_Acc LAcciones = NULL;
	lista_Crit LCriterios = NULL;
	
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   LAcciones = L->Acc_sig;
	   vfnBorraListaAcc(&LAcciones);
	   LCriterios = L->Crit_sig;
	   vfnBorraListaCrit(&LCriterios);
	   ifnBorraPto(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}

/***************************************************************/
/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaCateg(lista_Categ *list){
	lista_Categ L = NULL;
	lista_Pto LPtos = NULL;
	
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   LPtos = L->pto_sig;
	   vfnBorraListaPto(&LPtos);
	   ifnBorraCateg(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}



/***************************************************************/
/* Inicializa una lista simplemente enlazada y CON cabecera. */

/* Devuelve -1 en caso de ERROR. */
int ifnIniListPto(lista_Pto *list)
{
	char modulo[] = "Inicia_lista";
	
	if (( (*list) = (struct Pto_Gest *) malloc(sizeof(struct Pto_Gest))) == NULL)
		return -1;
	(*list)->sig=NULL;

	return 0;
}

/***************************************************************/
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaPto (lista_Pto *ant){
	lista_Pto p;

	if ((p=(struct Pto_Gest *) malloc(sizeof(struct Pto_Gest))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; /* Insertar elemento apuntado por p, entre anterior y L */
	return 0;
}
/***************************************************************/
/* Borra el elemento en la posición pos de la lista ant. */
/* pila vacía, pos<1 o pos>long */
int ifnBorraPto(lista_Pto *ant){
	lista_Pto aux ;

	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}



/* Inicializa una lista simplemente enlazada y CON cabecera. */

/* Devuelve -1 en caso de ERROR. */
int ifnIniListCrit(lista_Crit *list)
{
	char modulo[] = "Inicia_lista";
	
	if (( (*list) = (struct Criterio *) malloc(sizeof(struct Criterio))) == NULL)
		return -1;
	(*list)->sig=NULL;

	return 0;
}

/***************************************************************/
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaCrit(lista_Crit *ant){
	lista_Crit p;

	if ((p=(struct Criterio *) malloc(sizeof(struct Criterio))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; /* Insertar elemento apuntado por p, entre anterior y L */
	return 0;
}

/***************************************************************/
/* Borra el elemento en la posición pos de la lista ant. */
int ifnBorraCrit(lista_Crit *ant){
	lista_Crit aux ;

	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}


/* Inicializa una lista simplemente enlazada y CON cabecera. */

/* Devuelve -1 en caso de ERROR. */
int ifnIniListAcc(lista_Acc *list)
{
	char modulo[] = "Inicia_lista";
	
	if (( (*list) = (struct Accion *) malloc(sizeof(struct Accion))) == NULL)
		return -1;
	(*list)->sig=NULL;

	return 0;
}

/***************************************************************/
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaAcc(lista_Acc *ant){
	lista_Acc p;

	if ((p=(struct Accion *) malloc(sizeof(struct Accion))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; /* Insertar elemento apuntado por p, entre anterior y L */
	return 0;
}

/***************************************************************/
/* Borra el elemento en la posición pos de la lista ant. */
int ifnBorraAcc(lista_Acc *ant){
	lista_Acc aux ;

	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}
/* Inicializa una lista simplemente enlazada . */
/* Devuelve -1 en caso de ERROR. */
int ifnIniListSecPto(lista_SecPtos *list)
{
	char modulo[] = "Inicia_lista";
	
	if (( (*list) = (struct SecPtos *) malloc(sizeof(struct SecPtos))) == NULL)
		return -1;
	(*list)->sig=NULL;

	return 0;
}

/***************************************************************/
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaSecPto(lista_SecPtos *ant){
	lista_SecPtos p;

	if ((p=(struct SecPtos *) malloc(sizeof(struct SecPtos))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; /* Insertar elemento apuntado por p, entre anterior y L */
	return 0;
}

/***************************************************************/
/* Muestra todos los elementos de la lista list por su orden. */
void vfnMuestraListaSecPto(lista_SecPtos list)
{
	lista_SecPtos p = list;
	char modulo[] = "vfnMuestraListaCrit";

        while (p != NULL) 
	{
                ifnTrazasLog(modulo,"\t\t NumDias, NumProceso ->(%ld, %ld) \n",LOG05, p->iNumDias, p->iNumProceso);
		p = p->sig;
	}
        /*ifnTrazasLog(modulo,"\t\tp -> NULL \n\n",LOG05);*/
}
/***************************************************************/
/* Borra el elemento en la posición pos de la lista ant. */
/* pila vacía, pos<1 o pos>long */
int ifnBorraSecPto(lista_SecPtos *ant){
	lista_SecPtos aux ;

	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}
/***************************************************************/
/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaSecPto(lista_SecPtos *list){
	lista_SecPtos L = NULL;
	
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   ifnBorraSecPto(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}

/* acciones morosos */
int ifnIniListAccion(stLista lstCLTE, lstAccCM NodoAcc){
        lstCLTE->Accion_sgte  = NodoAcc;
        lstCLTE->Accion_final = NodoAcc;
	return 0;
}

int ifnInsertaNodoAcc(stLista lstCLTE, lstAccCM NodoAcc ){
lstAccCM lstsgte;
	lstsgte = lstCLTE->Accion_final;
        lstsgte->sgte= NodoAcc;
        lstCLTE->Accion_final=NodoAcc;
	return 0;
}

int ifnBorraNodoAccion(lstAccCM *ant){
	lstAccCM aux ;

	if ((*ant) == NULL)
	   return -1; 
	else{
		aux = (*ant);
		(*ant)=aux->sgte;
		free(aux);
		return 0;
	} 
}

void vfnEliminaNodoAccion(lstAccCM *list){
	lstAccCM L = NULL;
	
	if ((*list) != NULL)
	  L = (*list)->sgte;
	  
	while (L != NULL){
	   ifnBorraNodoAccion(&L);
	}
	free((*list));
	(*list)=NULL;
}


/*************************************************************************/
/* FUNCIONES DE LISTAS ENLAZADAS	CLIENTES P-MAS-04037	(ejecutor)		    */
/*************************************************************************/
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaClie(Lista_Clie *ant)
{
	Lista_Clie p;
	if ((p=(struct ClientesAcc *) malloc(sizeof(struct ClientesAcc))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; 
	return 0;
}

/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaClie(Lista_Clie *list)
{
	Lista_Clie L = NULL;
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   ifnBorraCli(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}

/* Borra el elemento en la posición pos de la lista ant. */
int ifnBorraCli(Lista_Clie *ant)
{
	Lista_Clie aux ;
	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}


/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaClieHilo(Lista_Hilo *ant)
{
	Lista_Hilo p;
	if ((p=(struct ClientesAcc *) malloc(sizeof(struct ClientesAcc))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; 
	return 0;
}

/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaHilo(Lista_Hilo *list)
{
	Lista_Hilo L = NULL;
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   ifnBorraCli(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}

/* Borra el elemento en la posición pos de la lista ant. */
int ifnBorraHilo(Lista_Hilo *ant)
{
	Lista_Hilo aux ;
	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}

/*************************************************************************/
/* FUNCIONES DE LISTAS ENLAZADAS	ACCIONES P-MAS-04037	(ejecutor)		    */
/*************************************************************************/
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaNodoAccion(Lista_Acc *ant)
{
	Lista_Acc p;
	if ((p=(struct stAcciones *) malloc(sizeof(struct stAcciones))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p; 
	return 0;
}

/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraNodoAcc(Lista_Acc *list)
{
	Lista_Acc L = NULL;
	if ((*list) != NULL)
	  L = (*list)->sig;
	  
	while (L != NULL){
	   ifnBorraNodoAcc(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}

/* Borra el elemento en la posición pos de la lista ant. */
int ifnBorraNodoAcc(Lista_Acc *ant)
{
	Lista_Acc aux ;
	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */ 
}
