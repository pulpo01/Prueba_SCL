package com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao.VentaAccesoriosDAO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ParametrosCargosAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosOutDTO;


public class VentaAccesoriosBO {
	
	private VentaAccesoriosDAO ventaAccesorioDAO = new VentaAccesoriosDAO();
	private static Category cat = Category.getInstance(VentaAccesoriosBO.class);

	public void insertAccesReservMovim(WsVentaAccesoriosOutDTO ventaAccesorio)throws GeneralException{		
		cat.debug("Inicio:InsertAccesReservMovim()");
		ventaAccesorioDAO.insertAccesReservMovim(ventaAccesorio);
		cat.debug("Fin:InsertAccesReservMovim()");		
	}//fin InsertAccesReservMovim

	public void insertSalidAccesMovim(WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{		
		cat.debug("Inicio:InsertAccesReservMovim()");
		ventaAccesorioDAO.insertSalidAccesMovim(ventaAccesoriosOutDTO);
		cat.debug("Fin:InsertAccesReservMovim()");		
	}//fin InsertAccesReservMovim
		
	public long getObtieneSecuencia(String nombreSecuencia)throws GeneralException{
		cat.debug("Inicio:getSecuenciaTransaccion()");
		long numTransaccion = 0;
		numTransaccion = ventaAccesorioDAO.getObtieneSecuencia(nombreSecuencia); 
		cat.debug("Fin:getSecuenciaTransaccion()");
		return numTransaccion;
	}
	
	public boolean validaNumeroSerie(ArticuloDTO articuloDTO)throws GeneralException{
		boolean retValue = false;
		cat.debug("Inicio:getSecuenciaTransaccion()");
		retValue =ventaAccesorioDAO.validaNumeroSerie(articuloDTO); 
		cat.debug("Fin:getSecuenciaTransaccion()");
		return retValue;
	}
	
	public void insertReservArticulo(WsVentaAccesoriosOutDTO ventaAccesorio)throws GeneralException{		
		cat.debug("Inicio:InsertReservArticulo()");
		ventaAccesorioDAO.insertReservArticulo(ventaAccesorio);
		cat.debug("Fin:InsertReservArticulo()");		
	}//fin InsertReservArticulo
	
	public WsVentaAccesoriosOutDTO obtieneDatosVendedor(WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{
		WsVentaAccesoriosOutDTO ventaAccesoriosOut = new WsVentaAccesoriosOutDTO();
		cat.debug("Inicio:obtieneDatosVendedor()");		
		ventaAccesoriosOut = ventaAccesorioDAO.obtieneDatosVendedor(ventaAccesoriosOutDTO);
		cat.debug("Fin:obtieneDatosVendedor()");
		return ventaAccesoriosOut;
	}//fin obtieneDatosVendedor
	
	public WsVentaAccesoriosOutDTO obtieneTipoDocumentacion(WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{
		WsVentaAccesoriosOutDTO ventaAccesoriosOut = new WsVentaAccesoriosOutDTO();
		cat.debug("Inicio:obtieneTipoDocumentacion()");		
		ventaAccesoriosOut = ventaAccesorioDAO.obtieneTipoDocumentacion(ventaAccesoriosOutDTO);
		cat.debug("Fin:obtieneTipoDocumentacion()");
		return ventaAccesoriosOut;
	}//fin obtieneTipoDocumentacion
	
	public void insertaVenta(WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{		
		cat.debug("Inicio:InsertaVenta()");
		ventaAccesorioDAO.insertaVenta(ventaAccesoriosOutDTO);
		cat.debug("Fin:InsertaVenta()");		
	}//fin InsertReservArticulo
	
	public WsVentaAccesoriosDTO obtieneCicloFactCliente(WsVentaAccesoriosDTO ventaAccesorio)throws GeneralException{
		cat.debug("Inicio:obtieneCicloFactCliente()");
		ventaAccesorio = ventaAccesorioDAO.obtieneCicloFactCliente(ventaAccesorio);
		cat.debug("Fin:obtieneCicloFactCliente()");
		return ventaAccesorio;
	}//fin obtieneCicloFactCliente
	
	public WsVentaAccesoriosOutDTO updateVenta(WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException{
		WsVentaAccesoriosOutDTO ventaAccesoriosOut = new WsVentaAccesoriosOutDTO();
		cat.debug("Inicio:updateVenta()");
		ventaAccesoriosOut = ventaAccesorioDAO.updateVenta(ventaAccesoriosOutDTO);
		cat.debug("Fin:updateVenta()");
		return ventaAccesoriosOut;
	}//fin updateVenta
	
	public WsVentaAccesoriosOutDTO eliminaReserva(long numTransaccion)throws GeneralException{
		WsVentaAccesoriosOutDTO ventaAccesoriosOut = new WsVentaAccesoriosOutDTO();
		cat.debug("Inicio:eliminaReserva()");
		ventaAccesoriosOut = ventaAccesorioDAO.eliminaReserva(numTransaccion);
		cat.debug("Fin:eliminaReserva()");
		return ventaAccesoriosOut;
	}//fin eliminaReserva
	
	public PrecioCargoDTO[] getPrecioCargoAccesorio_PrecioLista(ParametrosCargosAccesoriosDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:updateVenta()");
		PrecioCargoDTO[] retorno = null;
		retorno = ventaAccesorioDAO.getPrecioCargoAccesorio_PrecioLista(entrada);
		cat.debug("Fin:updateVenta()");
		return retorno;
	}//fin updateVenta
	
	public float getImpuesto(String codigoVendedor)throws GeneralException{
		float impuesto = 0;
		cat.debug("Inicio:getImpuesto()");		
		impuesto = ventaAccesorioDAO.getImpuesto(codigoVendedor);
		cat.debug("Fin:getImpuesto()");
		return impuesto;
	}//fin getImpuesto
	
	public String getZip(DireccionDTO direccion)throws GeneralException{
		String zip = null;
		cat.debug("Inicio:getZip()");		
		zip = ventaAccesorioDAO.getZip(direccion);
		cat.debug("Fin:getZip()");
		return zip;
	}//fin getImpuesto
	
	
	public String getNumCelularSeriePrepago(String numSerie, String numVenta)
	throws GeneralException{
		String numeroCelular = null;
		cat.debug("Inicio:getNumCelularSeriePrepago()");		
		numeroCelular = ventaAccesorioDAO.getNumCelularSeriePrepago(numSerie, numVenta);
		cat.debug("Fin:getNumCelularSeriePrepago()");
		return numeroCelular;
	}//fin getImpuesto	
	
	
	public DescuentoDTO[] getDescuentoAccesorio(ParametrosCargosAccesoriosDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getNumCelularSeriePrepago()");	
		DescuentoDTO[] resultado = null;
		resultado =   ventaAccesorioDAO.getDescuentoAccesorio(entrada);
		cat.debug("Fin:getDescuentoAccesorio()");
		return resultado;
	}		
	
	public WSCentralQuioscoOutDTO getCentralesQuiosco()
	throws GeneralException{
		cat.debug("Inicio:getNumCelularSeriePrepago()");	
		WSCentralQuioscoOutDTO resultado = null;
		resultado =   ventaAccesorioDAO.getCentralesQuiosco();
		cat.debug("Fin:getNumCelularSeriePrepago()");
		return resultado;
	}
		
}
