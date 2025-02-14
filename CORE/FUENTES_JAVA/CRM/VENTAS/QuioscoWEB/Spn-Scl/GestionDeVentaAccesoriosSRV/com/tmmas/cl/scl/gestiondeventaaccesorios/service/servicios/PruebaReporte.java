package com.tmmas.cl.scl.gestiondeventaaccesorios.service.servicios;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DetalleFacturaVO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.FacturaVO;

public class PruebaReporte {
	
	
	
	public static void main(String[] args) throws GeneralException {
		GestionDeVentaAccesoriosSRV accesoriosSRV = new GestionDeVentaAccesoriosSRV();
		FacturaVO facturaVO = new FacturaVO();
		DetalleFacturaVO detalleFacturaVO = new DetalleFacturaVO();
		byte[] pdfAsBytes = null;
		
		System.out.println("INICIO");
		
		//detalleFacturaVO = new DetalleFacturaVO[2];
		
		/*detalleFacturaVO.setDescripArticulo("Prueba 1");
		detalleFacturaVO.setNumCantidad(1);
		detalleFacturaVO.setNumCelular("12345678");
		detalleFacturaVO.setPrecioUnitario(54000);
		detalleFacturaVO.setSerieArticulo("543210987654321");*/
		
	/*	detalleFacturaVO[0].setDescripArticulo("Prueba 1");
		detalleFacturaVO[0].setNumCantidad(1);
		detalleFacturaVO[0].setNumCelular("12345678");
		detalleFacturaVO[0].setPrecioUnitario(54000);
		detalleFacturaVO[0].setSerieArticulo("543210987654321");
		
		detalleFacturaVO[1].setDescripArticulo("Prueba 2");
		detalleFacturaVO[1].setNumCantidad(1);
		detalleFacturaVO[1].setNumCelular("98765432");
		detalleFacturaVO[1].setPrecioUnitario(105000);
		detalleFacturaVO[1].setSerieArticulo("987652315469015");*/
		
		/*facturaVO.setImpuestoVenta(new Double("8750"));
		facturaVO.setNumFactura("98765421");
		facturaVO.setNumPago(5454);
		facturaVO.setSubTotal(new Double(159000));
		facturaVO.setTotalVenta(new Double(167750));*/		
		
		System.out.println("NumeroFactura: "+ facturaVO.getNumFactura());
		
		//facturaVO.setDetalleFacturaVO(detalleFacturaVO);
		facturaVO.setDetalleFacturaVO(new DetalleFacturaVO[2]);	
		facturaVO.getDetalleFacturaVO()[0] = new DetalleFacturaVO();
		facturaVO.getDetalleFacturaVO()[0].setDescripArticulo(detalleFacturaVO.getDescripArticulo());		
		facturaVO.getDetalleFacturaVO()[0].setNumCantidad(detalleFacturaVO.getNumCantidad());
		facturaVO.getDetalleFacturaVO()[0].setNumCelular(detalleFacturaVO.getNumCelular());
		facturaVO.getDetalleFacturaVO()[0].setPrecioUnitario(detalleFacturaVO.getPrecioUnitario());
		facturaVO.getDetalleFacturaVO()[0].setSerieArticulo(detalleFacturaVO.getSerieArticulo());
		
		detalleFacturaVO = new DetalleFacturaVO();
		
		/*detalleFacturaVO.setDescripArticulo("Prueba 2");
		detalleFacturaVO.setNumCantidad(1);
		detalleFacturaVO.setNumCelular("98765432");
		detalleFacturaVO.setPrecioUnitario(105000);
		detalleFacturaVO.setSerieArticulo("987652315469015");
*/
		facturaVO.getDetalleFacturaVO()[1] = new DetalleFacturaVO();
		facturaVO.getDetalleFacturaVO()[1].setDescripArticulo(detalleFacturaVO.getDescripArticulo());
		facturaVO.getDetalleFacturaVO()[1].setNumCantidad(detalleFacturaVO.getNumCantidad());
		facturaVO.getDetalleFacturaVO()[1].setNumCelular(detalleFacturaVO.getNumCelular());
		facturaVO.getDetalleFacturaVO()[1].setPrecioUnitario(detalleFacturaVO.getPrecioUnitario());
		facturaVO.getDetalleFacturaVO()[1].setSerieArticulo(detalleFacturaVO.getSerieArticulo());
				
		System.out.println("Numero Factura: "+ facturaVO.getNumFactura());
		
		pdfAsBytes =  accesoriosSRV.getFormFactura(facturaVO);

	}

}
