package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.transaction.SystemException;

import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;

public class ProductoWeb {
	private ArrayList detalleProduc;
	private String Nombre;
	private String linea;
	private String correlativo;
	private String codigo;
	private boolean personalizado;
	private int modificable;
	private String comportamiento;
	private int maximo;
	private String tipo;
	private String pagina;
	private String paquete;
	private boolean chequeado=false;
	private String codPadre;
	private String codProducto;
	private int sizePaq;
	private int cantidadContratado;
	private String idProdContratado=null;
	private String indCondicionContratacion=null;
	private String esHijo="0";
	private Object contenidoWeb;
	private String esAutoAfin="0";
	private ProductoOfertadoDTO productoDTO;
	private String numMaximoLista = null; 
	private String cargoOcasional;
	private String cargoFrecuente;
	
	
	public ProductoWeb(ProductoOfertadoDTO productoDTO) {
		
		
		try {
		  //	this.numMaximoLista = productoDTO.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista();	
		this.numMaximoLista = productoDTO.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista();
		//System.out.println("el numero maximo de la lista es --------------------" + numMaximoLista);
		} catch (Exception e) {
			//System.out.println("Sin getNumMaximoLista  -------------------- "+e.getMessage());	
			//e.printStackTrace();// TODO: handle exception
		}
		
		/**
		 * Carga de info de cargo.
		 */
		CargoListDTO cargosProd=productoDTO.getCargoList();
		float totCargosOcasionales=0;
		float totCargosFrecuentes=0;
		
		if(cargosProd!=null)
		{
			for(int i=0;i<cargosProd.getCargoList().length;i++)
			{
				CargoDTO carg=cargosProd.getCargoList()[i];
				if("O".equalsIgnoreCase(carg.getTipoCargo()))
				{
					totCargosOcasionales=totCargosOcasionales+Float.parseFloat(carg.getImporte());
				}
				else 
				{
					totCargosFrecuentes=totCargosFrecuentes+Float.parseFloat(carg.getImporte());
				}
			}
		}
		
		DecimalFormat df = new DecimalFormat();
		df.applyPattern("###,##0.0;-#,##0.0");		
		this.cargoOcasional=df.format(totCargosOcasionales);
		this.cargoFrecuente=df.format(totCargosFrecuentes);
		
		
		this.productoDTO = productoDTO;
		this.pagina = "SelecProducTem"; //depende que clase de producto sea , el valor de la pagina sera... yoda
		this.paquete = productoDTO.getIndPaquete();		
		this.Nombre = productoDTO.getDesProdOfertado();
		this.codProducto = productoDTO.getIdentificadorProductoOfertado();
		if (!productoDTO.getIndPaquete().equals("0")){
//			this.linea= productoDTO.getEspecificacionProducto().getIndTipoPlataforma();
			this.codigo= productoDTO.getIdProductoOfertado();
			this.comportamiento =  "PACK";
//			this.sizePaq = se llena desde afuera ...(paqueteWeb)
		}
		else
		{
			
//			this.linea= productoDTO.getEspecificacionProducto().getIndTipoPlataforma();			
			this.codigo= productoDTO.getIdProductoOfertado();
			this.comportamiento =  productoDTO.getEspecificacionProducto().getTipoComportamiento();

		}
		System.out.println("ProductoWeb comportamiento "+comportamiento);	
		if ((this.comportamiento.equals("PFRC"))||(this.comportamiento.equals("PAFN"))){
			//para determinar que paginas si son personalizables
			this.modificable=1;
			try{ 
				if (productoDTO.getEspecificacionProducto()
				.getEspecServicioClienteList().getEspecSerLisList()
				.getEspecServicioListaList()[0].getIndAutoAfinidad()
				.equals("S")) {
					//si es autoafin no se personalizable;
					this.modificable=0;			
				}			
			}catch(Exception e){
				this.modificable=1;
			}
		}
		else
		{
			//para determinar que paginas si son personalizables
			this.modificable=0;
		}
		this.cantidadContratado = productoDTO.getCantidadDesplegado();
		this.correlativo= productoDTO.getCodCategoria();				
		this.personalizado = false;
		this.maximo = productoDTO.getCantidadDesplegado();
		this.tipo = productoDTO.getCodCategoria();
		

		
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getComportamiento() {
		return comportamiento;
	}

	public void setComportamiento(String comportamiento) {
		this.comportamiento = comportamiento;
	}

	public String getCorrelativo() {
		return correlativo;
	}

	public void setCorrelativo(String correlativo) {
		this.correlativo = correlativo;
	}

	public ArrayList getDetalleProduc() {
		return detalleProduc;
	}

	public void setDetalleProduc(ArrayList detalleProduc) {
		this.detalleProduc = detalleProduc;
	}

	public String getLinea() {
		return linea;
	}

	public void setLinea(String linea) {
		this.linea = linea;
	}

	public int getMaximo() {
		return maximo;
	}

	public void setMaximo(int maximo) {
		this.maximo = maximo;
	}

	public String getNombre() {
		return Nombre;
	}

	public void setNombre(String nombre) {
		Nombre = nombre;
	}

	public String getPagina() {
		return pagina;
	}

	public void setPagina(String pagina) {
		this.pagina = pagina;
	}

	public boolean isPersonalizado() {
		return personalizado;
	}

	public void setPersonalizado(boolean personalizado) {
		this.personalizado = personalizado;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getPaquete() {
		return paquete;
	}

	public void setPaquete(String paquete) {
		this.paquete = paquete;
	}

	public void setChequeado(boolean chequeado) {
		this.chequeado=chequeado;
	}

	public boolean getChequeado() {
		return chequeado;
	}
	public void setCodPadre(String codPadre) {
		this.codPadre=codPadre;
	}

	public String getCodPadre() {
		return codPadre;
	}
	
	public String toString(){
		return codPadre;
	}

	public void setSizePaq(int cantProduc) {
		//si es paquete el producto, cuantos productos tiene
		this.sizePaq=cantProduc;
	}

	public int getSizePaq() {
		//si es paquete el producto, cuantos productos tiene
		return sizePaq;
	}

	public ProductoOfertadoDTO getProductoDTO() {
		return productoDTO;
	}

	public void setProductoDTO(ProductoOfertadoDTO productoDTO) {
		this.productoDTO = productoDTO;
	}

	public String getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}

	public int getModificable() {
		return modificable;
	}

	public void setModificable(int modificable) {
		this.modificable = modificable;
	}

	public String getNumMaximoLista() {
		return numMaximoLista;
	}

	public void setNumMaximoLista(String numMaximoLista) {
		this.numMaximoLista = numMaximoLista;
	}
	
	
	public int getCantidadContratado() {
		return cantidadContratado;
	}

	public void setCantidadContratado(int cantidadContratado) {
		this.cantidadContratado = cantidadContratado;
	}

	public String getIdProdContratado() {
		return idProdContratado;
	}

	public void setIdProdContratado(String idProdContratado) {
		this.idProdContratado = idProdContratado;
	}

	public String getIndCondicionContratacion() {
		return indCondicionContratacion;
	}

	public void setIndCondicionContratacion(String indCondicionContratacion) {
		this.indCondicionContratacion = indCondicionContratacion;
	}

	public String getEsHijo() {
		return esHijo;
	}

	public void setEsHijo(String esHijo) {
		this.esHijo = esHijo;
	}

	public String getEsAutoAfin() {
		return esAutoAfin;
	}

	public void setEsAutoAfin(String esAutoAfin) {
		this.esAutoAfin = esAutoAfin;
	}

	public String getCargoFrecuente() {
		return cargoFrecuente;
	}

	public void setCargoFrecuente(String cargoFrecuente) {
		this.cargoFrecuente = cargoFrecuente;
	}

	public String getCargoOcasional() {
		return cargoOcasional;
	}

	public void setCargoOcasional(String cargoOcasional) {
		this.cargoOcasional = cargoOcasional;
	}
}
