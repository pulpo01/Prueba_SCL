package com.tmmas.scl.wsportal.businessobject.dao.testunit;

import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.AtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class PruebaUnitMod {

	
	public static void main(String[] args) {
		
		//Prueba 1
		//pruebaAtencionCliente();
		
		//prueba 2
		//Datos de entrada
		//Long numAbon = Long.valueOf("4527383");
		Long numAbon = Long.valueOf("4571560");
		
		//Long numAbon = Long.valueOf("14");
		pruebaObtenerDatosAbonado(numAbon);
	}
	
	private static void pruebaAtencionCliente(){
		
		System.out.println("INICIO");
		PruebaUnitDAO pruebaUnitDAO = new PruebaUnitDAO();
		
		try {
			System.out.println("1");
			ListaAtencionClienteDTO listaAtencionClienteDTO = pruebaUnitDAO.consultaAtencion();
			System.out.println("2");
			System.out.println("CodError: "+null == listaAtencionClienteDTO.getCodError() ? "" : listaAtencionClienteDTO.getCodError());
			System.out.println("DesError: "+null == listaAtencionClienteDTO.getDesError() ? "" : listaAtencionClienteDTO.getDesError());
			System.out.println("3");
			AtencionClienteDTO[] atencionClienteDTO = listaAtencionClienteDTO.getArrayAtencionCliente();
			System.out.println("4");
			int largo = atencionClienteDTO.length;
			System.out.println("5");
			for (int i = 0; i < largo; i++) {
				System.out.println("6");
				System.out.println("getDesAtencion: "+atencionClienteDTO[i].getDesAtencion());
				System.out.println("getIndObserv: "+atencionClienteDTO[i].getIndObserv());
				System.out.println("getCodAtencion: "+atencionClienteDTO[i].getCodAtencion());
				System.out.println("getGrpAtencion: "+atencionClienteDTO[i].getGrpAtencion());
				System.out.println("getNumNivel: "+atencionClienteDTO[i].getNumNivel());
				System.out.println("7");
			}
			System.out.println("8");
			
		} catch (PortalSACException e) {
			System.out.println("9");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("FIN");
		//atencionPackageDAO.consultaCuenta(codCuenta);
		
		//atencionPackageDAO.IngresoAtencion(resgistroAtencionDTO);
		//atencionPackageDAO.ObtenerDatosAbonado(numAbonado);
		
		//atencionPackageDAO.ObtenerListDatosAbonados(codCliente);
		
	}
	
	private static void pruebaObtenerDatosAbonado(Long numAbonado){
		
		System.out.println("INICIO");
		PruebaUnitDAO pruebaUnitDAO = new PruebaUnitDAO();
		
		try {
			System.out.println("1");
			AbonadoDTO abonadoDTO = pruebaUnitDAO.ObtenerDatosAbonado(numAbonado);
			System.out.println("2");
			System.out.println("3");
			System.out.println("4");
			System.out.println("5");
			System.out.println("6");
			if( null != abonadoDTO ){
				System.out.println("getNumAbonado: "+abonadoDTO.getNumAbonado());
				System.out.println("getNumCelular: "+abonadoDTO.getNumCelular());
				System.out.println("getCodUso: "+abonadoDTO.getCodUso());
				System.out.println("getNomUsuario: "+abonadoDTO.getNomUsuario());
				System.out.println("getApellidoPaterno: "+abonadoDTO.getApellidoPaterno());
				System.out.println("getApellidoMaterno: "+abonadoDTO.getApellidoMaterno());
			}
			System.out.println("7");
			System.out.println("8");
			
		} catch (PortalSACException e) {
			System.out.println("9");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("FIN");
		//atencionPackageDAO.consultaCuenta(codCuenta);
		
		//atencionPackageDAO.IngresoAtencion(resgistroAtencionDTO);
		//atencionPackageDAO.ObtenerDatosAbonado(numAbonado);
		
		//atencionPackageDAO.ObtenerListDatosAbonados(codCliente);
		
	}

}
