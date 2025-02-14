package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosCorreoMovistarDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;

public class ProductoWeb {
	private final Logger logger = Logger.getLogger(ProductoWeb.class);	
	
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
	private int cantidadDesplegado;
	private Object contenidoWeb;
	
	private String cargoOcasional;
	private String cargoFrecuente;
	
	private ProductoOfertadoDTO productoDTO;
	private String numMaximoLista = null; 
	
	private String indAutoAfinidad = "N";
	private String tipoCobro;
	private String tipoCobroCargo;
	
	private LinkedHashMap listaLimiteConsumo = new LinkedHashMap();
	private LinkedHashMap listaLimiteConsumoValMtoLHM = new LinkedHashMap();
	private ArrayList listaLimiteConsumoValMto = new ArrayList();
	private String codLimConsuSeleccionado = "-1";
	private String codLimConsuInicial = "-1";
	private String mtoConsumido;
	private String mtoMinimo;
	private String mtoMaximo;
	private Float mtoConsumoConfigurado;
	private String idEspecProvision;
	private DatosCorreoMovistarDTO datosCorreoCliente;
	private FormularioDireccionDTO datosDireccionCorreoCliente;
	
	private static int sizeSelect = 0;
	
	//MIX-09003
	private String tipoPlanAdic;
	
	
	public ProductoWeb() {
	}

	public FormularioDireccionDTO getDatosDireccionCorreoCliente() {
		return datosDireccionCorreoCliente;
	}

	public void setDatosDireccionCorreoCliente(
			FormularioDireccionDTO datosDireccionCorreoCliente) {
		this.datosDireccionCorreoCliente = datosDireccionCorreoCliente;
	}

	public String getTipoCobro() {
		return tipoCobro;
	}

	public void setTipoCobro(String tipoCobro) {
		this.tipoCobro = tipoCobro;
	}

	public ProductoWeb(ProductoOfertadoDTO productoDTO) {
		
		logger.debug("(+)ProductoWEB*******");
		logger.debug("productoDTO.getCodEspecProd()="+productoDTO.getCodEspecProd());
		logger.debug("productoDTO.getDesProdOfertado()="+productoDTO.getDesProdOfertado());
		
		try {
		  //	this.numMaximoLista = productoDTO.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista();	
		this.numMaximoLista = productoDTO.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista();

		}
		catch (Exception e) 
		{	

		}
		
		/**
		 * Carga de info de cargo.
		 */
		CargoListDTO cargosProd=productoDTO.getCargoList();
		float totCargosOcasionales=0;
		float totCargosFrecuentes=0;
		
		if(cargosProd!=null&&cargosProd.getCargoList()!=null) 
		{
			for(int i=0;i<cargosProd.getCargoList().length;i++)
			{
				CargoDTO carg=cargosProd.getCargoList()[i];
				logger.debug("carg.getIdCargo()"+carg.getIdCargo());
				logger.debug("carg.getCodConcepto()"+carg.getCodConcepto());				
				logger.debug("carg.getDescripcion()"+carg.getDescripcion());
				logger.debug("carg.getTipoCargo()"+carg.getTipoCargo());
				logger.debug("carg.getTipoCobro()"+carg.getTipoCobro());
				if("O".equalsIgnoreCase(carg.getTipoCargo()))
				{
					totCargosOcasionales=totCargosOcasionales+Float.parseFloat(carg.getImporte());
				}
				else 
				{
					totCargosFrecuentes=totCargosFrecuentes+Float.parseFloat(carg.getImporte());
					/**
					 * @author rlozano
					 * @date 10-08-2009
					 * @description Se procede a cargar el valor del tipo de cobro slo cargos recurrentes
					 */
					this.tipoCobro=	carg.getTipoCobro();
					
					//(+) EV 22/10/2009  
					this.tipoCobroCargo = obtieneTipoCobroCargoRecurrente( carg.getTipoCobro(), cargosProd.getCargoList());
					logger.debug("this.tipoCobroCargo"+this.tipoCobroCargo);
					//(-)
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
		this.cantidadDesplegado = productoDTO.getCantidadDesplegado()!=0?productoDTO.getCantidadDesplegado():1;
		this.cantidadContratado = productoDTO.getCantidadDesplegado()!=0?productoDTO.getCantidadDesplegado():1;
		this.maximo = productoDTO.getMaxContrataciones()!=null?Integer.parseInt(productoDTO.getMaxContrataciones()):0;
		/* && this.maximo < 2*/
		if ((this.comportamiento.equals("PFRC"))||(this.comportamiento.equals("PAFN"))){
			//para determinar que paginas si son personalizables
			this.modificable=1;
			try{ 
				this.indAutoAfinidad = productoDTO.getEspecificacionProducto()
				.getEspecServicioClienteList().getEspecSerLisList()
				.getEspecServicioListaList()[0].getIndAutoAfinidad();
				if ((this.indAutoAfinidad).equals("S")) {
					//si es autoafin no se personalizable;
					this.modificable=0;			
				}else if (productoDTO.getIndCondicionContratacion().equals("D")){
					
					this.modificable=(this.cantidadContratado!=1)?0:1;
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
		this.correlativo= productoDTO.getCodCategoria();				
		this.personalizado = false;
		this.tipo = productoDTO.getCodCategoria();	
        // MIX - 09003 VMB 
		this.tipoPlanAdic = productoDTO.getTipoPlanAdic();
		// FIN MIX - 09003
		//Limite de Consumo
		extraerLimitesDeConsumoPlanAdicional();
		logger.debug("(-)ProductoWEB*******");

	}

	/* Si hay dos cargos recurrentes uno vencido y otro adelantado, se debe mostrar en la lista de planes
	 * como Vencido/Adelantado*/
	private String obtieneTipoCobroCargoRecurrente(String tipoCobroCargo, CargoDTO[] listaCargos){
		String tipoCobro = tipoCobroCargo;
		
		for(int i=0;i<listaCargos.length;i++)
		{
			CargoDTO cargo=listaCargos[i];
			if (cargo.getTipoCargo().equals("R")
				 && !cargo.getTipoCobro().equals(tipoCobroCargo)){
				tipoCobro = "VA";//Vencido/Adelantado;
				break;	
			}
		}
		
		return tipoCobro;
	}

	private void extraerLimitesDeConsumoPlanAdicional()
	{
		LimiteConsumoPlanAdicionalListDTO lista = new LimiteConsumoPlanAdicionalListDTO();
		LimiteConsumoPlanAdicionalDTO lc = null;
		int elemento = 0;
		if(productoDTO.getListaLimCons()!= null && productoDTO.getListaLimCons().getLimitesDeConsumo().length > 0)
		{
			lista.setLimitesDeConsumo(productoDTO.getListaLimCons().getLimitesDeConsumo());
			//logger.debug(" Existe LC: lista.getLimitesDeConsumo().length ["+lista.getLimitesDeConsumo().length+"]");		
			//logger.debug(" Existe LC: productoDTO.getIdProductoOfertado()["+productoDTO.getIdProductoOfertado()+"]");
			for(int i=0;i<lista.getLimitesDeConsumo().length;i++)
			{
				if(lista.getLimitesDeConsumo()[i].getIndDefault().equals("S"))
				{
					listaLimiteConsumo.put(lista.getLimitesDeConsumo()[i].getCodLimCons(), lista.getLimitesDeConsumo()[i].getDescripcion());
					lc = lista.getLimitesDeConsumo()[i];
					lc.setDescripcion(lc.getDescripcion()+" ["+lc.getMtoMinimo()+"-"+lc.getMtoMaximo()+"]");
					elemento = listaLimiteConsumoValMtoLHM.size();
					//verificarDespliegue(lc);
					listaLimiteConsumoValMtoLHM.put(elemento+""+lista.getLimitesDeConsumo()[i].getCodLimCons(),lc);
				}
			}
			
			for(int i=0;i<lista.getLimitesDeConsumo().length;i++)
			{
				if(!lista.getLimitesDeConsumo()[i].getIndDefault().equals("S"))
				{
					listaLimiteConsumo.put(lista.getLimitesDeConsumo()[i].getCodLimCons(), lista.getLimitesDeConsumo()[i].getDescripcion());
					lc = lista.getLimitesDeConsumo()[i];
					lc.setDescripcion(lc.getDescripcion()+" ["+lc.getMtoMinimo()+"-"+lc.getMtoMaximo()+"]");
					elemento = listaLimiteConsumoValMtoLHM.size();
					//verificarDespliegue(lc);
					listaLimiteConsumoValMtoLHM.put(elemento+""+lista.getLimitesDeConsumo()[i].getCodLimCons(),lc);
				}
			}
		}
		else{
			listaLimiteConsumo.put("-1","Sin Lista LC");
			lc = new LimiteConsumoPlanAdicionalDTO();
			lc.setCodLimCons("-0");
			lc.setDescripcion("SIN LIMITE");
			lc.setMtoConsumido(new Float(0));
			lc.setMtoMinimo(new Float(0));
			lc.setMtoMaximo(new Float(0));
			listaLimiteConsumoValMtoLHM.put("-0",lc);
		}
		Collection col = listaLimiteConsumoValMtoLHM.values();
		listaLimiteConsumoValMto.addAll(col);
		//logger.debug("fin listaLimiteConsumoValMto.size() ["+listaLimiteConsumoValMto.size()+"]");
		
	}
	
	private void verificarDespliegue(LimiteConsumoPlanAdicionalDTO lc) {
		/*int indice  = lc.getDescripcion().indexOf("LIMITE");
		int numChar = lc.getDescripcion().length();
		if(indice > -1)
		{
			lc.setDescripcion(lc.getDescripcion().substring(indice+7,numChar));
		}*/

		int sizeDesc = lc.getDescripcion().length();
		if(sizeDesc >sizeSelect){
			sizeSelect = sizeDesc;
		}
	}
	
	public void aplicarElementoSeleccionado()
	{
		LimiteConsumoPlanAdicionalListDTO lista = new LimiteConsumoPlanAdicionalListDTO();
		
		if(productoDTO.getListaLimCons()!= null)
		{
			lista.setLimitesDeConsumo(productoDTO.getListaLimCons().getLimitesDeConsumo());
					
			for(int i=0;i<lista.getLimitesDeConsumo().length;i++)
			{
				if(lista.getLimitesDeConsumo()[i].getIndDefault().equals("S"))
				this.codLimConsuSeleccionado = lista.getLimitesDeConsumo()[i].getCodLimCons();	
			}
						
		}
		
		
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

	public int getCantidadDesplegado() {
		return cantidadDesplegado;
	}

	public void setCantidadDesplegado(int cantidadDesplegado) {
		this.cantidadDesplegado = cantidadDesplegado;
	}

	public String getIndAutoAfinidad() {
		return indAutoAfinidad;
	}

	public void setIndAutoAfinidad(String indAutoAfinidad) {
		this.indAutoAfinidad = indAutoAfinidad;
	}

	public String getTipoCobroCargo() {
		return tipoCobroCargo;
	}

	public void setTipoCobroCargo(String tipoCobroCargo) {
		this.tipoCobroCargo = tipoCobroCargo;
	}

	public String getCodLimConsuSeleccionado() {
		return codLimConsuSeleccionado;
	}

	public void setCodLimConsuSeleccionado(String codLimConsuSeleccionado) {
		this.codLimConsuSeleccionado = codLimConsuSeleccionado;
	}

	public LinkedHashMap getListaLimiteConsumo() {
		return listaLimiteConsumo;
	}

	public void setListaLimiteConsumo(LinkedHashMap listaLimiteConsumo) {
		this.listaLimiteConsumo = listaLimiteConsumo;
	}

	public String getMtoConsumido() {
		return mtoConsumido;
	}

	public void setMtoConsumido(String mtoConsumido) {
		this.mtoConsumido = mtoConsumido;
	}

	public String getMtoMaximo() {
		return mtoMaximo;
	}

	public void setMtoMaximo(String mtoMaximo) {
		this.mtoMaximo = mtoMaximo;
	}

	public String getMtoMinimo() {
		return mtoMinimo;
	}

	public void setMtoMinimo(String mtoMinimo) {
		this.mtoMinimo = mtoMinimo;
	}

	public ArrayList getListaLimiteConsumoValMto() {
		return listaLimiteConsumoValMto;
	}

	public void setListaLimiteConsumoValMto(ArrayList listaLimiteConsumoValMto) {
		this.listaLimiteConsumoValMto = listaLimiteConsumoValMto;
	}

	public Float getMtoConsumoConfigurado() {
		return mtoConsumoConfigurado;
	}

	public void setMtoConsumoConfigurado(Float mtoConsumoConfigurado) {
		this.mtoConsumoConfigurado = mtoConsumoConfigurado;
	}
	
	public String getCodLimConsuInicial() {
		return codLimConsuInicial;
	}

	public void setCodLimConsuInicial(String codLimConsuInicial) {
		this.codLimConsuInicial = codLimConsuInicial;
	}

	public String getIdEspecProvision() {
		return idEspecProvision;
	}

	public void setIdEspecProvision(String idEspecProvision) {
		this.idEspecProvision = idEspecProvision;
	}

	public DatosCorreoMovistarDTO getDatosCorreoCliente() {
		return datosCorreoCliente;
	}

	public void setDatosCorreoCliente(DatosCorreoMovistarDTO datosCorreoCliente) {
		this.datosCorreoCliente = datosCorreoCliente;
	}

	public String getTipoPlanAdic() {
		return tipoPlanAdic;
	}

	public void setTipoPlanAdic(String tipoPlanAdic) {
		this.tipoPlanAdic = tipoPlanAdic;
	}
}
