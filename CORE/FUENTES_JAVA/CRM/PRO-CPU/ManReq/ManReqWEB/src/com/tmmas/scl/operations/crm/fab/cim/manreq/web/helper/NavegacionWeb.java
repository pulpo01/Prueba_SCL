package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.BitaForm;

public class NavegacionWeb {
	private int accion;
	
	/* Variables de paso */
	private Object objElementoWeb;
	private String codElementoWeb;	
	
	/* Variables de navegacion */
    private String pagina;
    private String idPagina;
    
    /* Tipo de datos que maneja la navegacion : */
    private PaqueteWeb paqueteWeb;
	private ProductoWeb productoWeb;
    private ClienteFrmkDTO cliente;
    private AbonadoWeb abonadoAux;
    private AbonadoFrmkDTO abonado = null;
    ProductoContratadoFrecDTO [] productosContratadosFrecSess = null;

    /*paginas*/
    private HashMap historial;
	private String bitacora;
	private String bitacorac;//contratados y por defecto

    /*parametros de la venta*/
	private long codCliente;
	private String numVenta;
	private String numTransaccion;
	private String numEvento;
	private String codVendedor;
	private String flagCiclo;

	public NavegacionWeb(){
    	historial = new HashMap();
    }

	public void Grabar() {
		if (this.pagina.equals("productos")) {
			/**
			 * Si me encuentro en la pagina de productos debo saber que producto
			 * fueron los que clickie, para ello existe un string con los id de productos que
			 * fueron modificados (clickeados y cantidad)
			 */
			// si el usuario presiono cancelar, no hacer ningun cambio
			if (this.accion==BitaForm.ACEPTAR){				
				paqueteWeb = (PaqueteWeb) historial.get(this.idPagina);
				
				ArrayList productoDisponibles = paqueteWeb.getProductosDisponible();
				ArrayList productoDefectos = paqueteWeb.getProductoPorDefecto();
				ProductoWeb productoX;
				
				if (bitacora!=null){// se personalizo un producto disponible??				
					StringTokenizer productosChk = new StringTokenizer(bitacora,"|");
					ArrayList chequeados= new ArrayList();
					int max;
					int chk=0;
					while (productosChk.hasMoreTokens()) {				
						chequeados.add(productosChk.nextToken());
						chk++;
					}
					max=chk;
					String CodPadreChequeado="";
					ArrayList productoDisponibleAux = new ArrayList();;
					for (int prDispo=0;prDispo<productoDisponibles.size();prDispo++) {
						productoX = (ProductoWeb) productoDisponibles.get(prDispo);
						chk=0;
						productoX.setChequeado(false);
						for(chk=0;chk<max;chk++) {
							// guardar los productos que fueron chequados						
							//se concadena el codProducto + codPadre, para no dejar chequeado duplicidades
							
							String idProductoSeleccionado = (String) chequeados.get(chk);
							if (idProductoSeleccionado.equals("O." + productoX.getCodPadre() + "." + productoX.getCodigo())
							|| (CodPadreChequeado.endsWith(productoX.getCodPadre())))
							{
								productoX.setChequeado(true);
								if ((productoX.getPaquete().equals("1"))&&(productoX.getChequeado())){
									//marcando hijos de productos paquete
									CodPadreChequeado = productoX.getCodigo();
								}
							}
							else
							{
								//si no fue seleccionado el producto su cantidad contratada es la por defecto
								productoX.setCantidadContratado(productoX.getProductoDTO().getCantidadDesplegado());
							}
						}
						productoDisponibleAux.add(productoX);
					}
					paqueteWeb.setProductosDisponible(productoDisponibleAux);
					historial.put(this.idPagina, paqueteWeb);
				}
				if (bitacorac!=null){// se personalizo un producto disponible??				
					StringTokenizer productosChk = new StringTokenizer(bitacorac,"|");
					ArrayList chequeados= new ArrayList();
					int max;
					int chk=0;
					while (productosChk.hasMoreTokens()) {				
						chequeados.add(productosChk.nextToken());
						chk++;
					}
					max=chk;
					String CodPadreChequeado="";
					ArrayList productoDefectoAux = new ArrayList();;
					for (int prDispo=0;prDispo<productoDefectos.size();prDispo++) {
						productoX = (ProductoWeb) productoDefectos.get(prDispo);
						chk=0;
						//productoX.setChequeado(false);
						for(chk=0;chk<max;chk++) {
							// guardar los productos que fueron chequados						
							//se concadena el codProducto + codPadre, para no dejar chequeado duplicidades
							
							String idProductoSeleccionado = (String) chequeados.get(chk);
							StringTokenizer st = new StringTokenizer(idProductoSeleccionado,".");
							st.nextToken();
							//String [] prod = idProductoSeleccionado.split(".");
							String prodCont = st.nextToken();
							if (prodCont.equals(productoX.getIdProdContratado())
							//if (idProductoSeleccionado.equals("D." + productoX.getCodPadre() + "." + productoX.getCodigo())
							|| (CodPadreChequeado.endsWith(productoX.getCodPadre())))
							{
								productoX.setChequeado(false);
								if ((productoX.getPaquete().equals("1"))&&(productoX.getChequeado())){
									//marcando hijos de productos paquete
									CodPadreChequeado = productoX.getCodigo();
								}
							}
							else
							{
								//si no fue seleccionado el producto su cantidad contratada es la por defecto
								productoX.setCantidadContratado(productoX.getProductoDTO().getCantidadDesplegado());
							}
						}
						productoDefectoAux.add(productoX);
					}
					paqueteWeb.setProductoPorDefecto(productoDefectoAux);
					historial.put(this.idPagina, paqueteWeb);
				}
			}
		}
	}
	
	public void setCantidadesPorProductoOfertado(String idAbonado,String cantidades[], ProductoOfertadoListDTO productoOfertadoListCont){
		this.paqueteWeb = getPaqueteWeb(idAbonado);
		int recorreCantidades =0;
		ArrayList productoDisponibles = paqueteWeb.getProductosDisponible();
		ArrayList productoDisponibleAux = new ArrayList();
		for (int proCant=0;proCant<productoDisponibles.size();proCant++) {
			ProductoWeb productoX = (ProductoWeb) productoDisponibles.get(proCant);	
			
			if (productoX.getChequeado()){
				try{
					if(productoX.getEsHijo().equals("0"))
					{
						productoX.setCantidadContratado(Integer.parseInt(cantidades[recorreCantidades]));	
					}	
				}catch(Exception e){System.out.println(e.getMessage());}
				recorreCantidades++;
			}
			productoDisponibleAux.add(productoX);
		}
		paqueteWeb.setProductosDisponible(productoDisponibleAux);
		historial.put(idAbonado, paqueteWeb);			
	}
	
	public void creaProductoPorAbonado(AbonadoDTO abonadoDto,ClienteDTO cliente,OrdenServicioDTO ordenServicio) throws RemoteException, GeneralException{
		PaqueteWeb paqueteWeb= new PaqueteWeb(abonadoDto,cliente,ordenServicio);
		historial.put(String.valueOf(abonadoDto.getNumAbonado()), paqueteWeb);
	}
	
    public void AgregarElementoWeb(String _codElementoWeb,Object _objElementoWeb){
    	historial.put(_codElementoWeb, _objElementoWeb);
    }
    
    public Object getDatos(String codElementoWeb){
    	//Devolver cualquier objeto para castearlo desde afuera
    	objElementoWeb = historial.get(codElementoWeb);
    	return objElementoWeb;
    }
    
	public PaqueteWeb getPaqueteWeb(String idAbonadoCliente) {
		//Devolver solo paquetesWeb por id de abonado o cliente		
		objElementoWeb = historial.get(idAbonadoCliente);	
    	if (objElementoWeb instanceof PaqueteWeb) {
    		paqueteWeb = (PaqueteWeb) objElementoWeb;
    		return paqueteWeb;
    	}   
		return null;
	}

	public ProductoWeb getProductoWeb(String idPaquete) {
		//Devolver producto desde un paquete de producto o de un cliente		
		objElementoWeb = historial.get(idPaquete);
    	if (objElementoWeb instanceof ProductoWeb) {
    		productoWeb = (ProductoWeb) objElementoWeb;
    		return productoWeb;
    	} 		
		return null;
	}

	public void setPagina(String _pagina) {
		this.pagina=_pagina;
	}
	public void setAccion(int _accion) {
		this.accion=_accion;
	}
	public void setIdPagina(String idPagina) {
		this.idPagina=idPagina;
	}

	
	public String getCancelar() {
		// TODO preguntar por todas las paginas
		if (pagina.equals("NivelContracTile")){
			return "NoContratar";
		}
		if (pagina.equals("productos")){
			//independiente si preciono cancelar o aceptar va a 
			//la pagina de contratar, la diferencia es que no
			//guardo los cambios en cancelar
			return "irContratar";
		}
		return "Error";
	}

	public String getAceptar() {
		// TODO preguntar por todas las paginas
		if (pagina.equals("NivelContracTile")){
			return "Contratar";
		}
		if (pagina.equals("productos")){			
			//independiente si preciono cancelar o aceptar va a 
			//la pagina de contratar, la diferencia es que si
			//guardo los cambios en aceptar
			return "irContratar";
		}
		return "Error";
	}

	public String getSiguiente() {
		if (this.accion==BitaForm.ACEPTAR){
			return getAceptar();
		}
		if (this.accion==BitaForm.CANCELAR){
			return getCancelar();
		}
		return "Error";
		
	}

	public ArrayList getListaClienteAfines(String idAbonadoCliente, String idListaAfines) {
//		Obtencion de numeros frecuentes, a nivel de abonado para validacion
		getPaqueteWeb(idAbonadoCliente);
		return paqueteWeb.getListaClienteAfines(idListaAfines);
	}	

	public HashMap getTodosClienteAfines(String idAbonadoCliente) {
//		Obtencion de numeros frecuentes, a nivel de abonado para validacion
		getPaqueteWeb(idAbonadoCliente);
		return paqueteWeb.getTodosClienteAfines();
	}	

	public void setListaClienteAfines(String idAbonadoCliente, String idListaAfines, ArrayList clienteAfines) {
//		Obtencion de numeros frecuentes, a nivel de abonado para validacion
		getPaqueteWeb(idAbonadoCliente);
		paqueteWeb.setListaClienteAfines(idListaAfines,clienteAfines);
	}
	
	public ArrayList getListaProducNumFreq(String idAbonadoCliente){
//		Obtencion de numeros frecuentes, a nivel de abonado para validacion
		getPaqueteWeb(idAbonadoCliente);
		return paqueteWeb.getListaProducNumFreq();
	}
	
	public ArrayList getListaProducNoNumFreq(String idAbonadoCliente){
//		Obtencion de numeros no frecuentes, a nivel de abonado para validacion
		getPaqueteWeb(idAbonadoCliente);
		return paqueteWeb.getListaProducNoNumFreq();
	}
	
	/*********************************************************************************************/
	
	public ProductoContratadoFrecDTO[] getProductoNumFrecByAbonado(String idAbonadoCliente) {
		// TODO Auto-generated method stub
		getPaqueteWeb(idAbonadoCliente);
		return paqueteWeb.getNumFreqProductos();
	}

	public void setProductoNumFrecByAbonado(String idAbonadoCliente , ProductoContratadoFrecDTO[] productoFrec) {
		// TODO Auto-generated method stub
		getPaqueteWeb(idAbonadoCliente);
		paqueteWeb.setNumFreqProductos(productoFrec);
	}

	
	public void setBitacora(String bitacora) {
		this.bitacora=bitacora;
	}

    public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public String getNumEvento() {
		return numEvento;
	}

	public void setNumEvento(String numEvento) {
		this.numEvento = numEvento;
	}

	public String getNumTransaccion() {
		return numTransaccion;
	}

	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}

	public String getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}

	public String getPagina() {
		return pagina;
	}
    
   public AbonadoWeb getAbonadoWeb() {
		return abonadoAux;
	}

	public void setAbonadoWeb(AbonadoWeb abonadoWeb) {
		this.abonadoAux = abonadoWeb;
	}

	public ClienteFrmkDTO getClienteWeb() {
		return cliente;
	}

	public void setClienteWeb(ClienteFrmkDTO clienteVTA) {
		this.cliente = clienteVTA;
	}

	public String getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}

	public String getFlagCiclo() {
		return flagCiclo;
	}

	public void setFlagCiclo(String flagCiclo) {
		this.flagCiclo = flagCiclo;
	}

	public String getBitacorac() {
		return bitacorac;
	}

	public void setBitacorac(String bitacorac) {
		this.bitacorac = bitacorac;
	}
	
	
}
