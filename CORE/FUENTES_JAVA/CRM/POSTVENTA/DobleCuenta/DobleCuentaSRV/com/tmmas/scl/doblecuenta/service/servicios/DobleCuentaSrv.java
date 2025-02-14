package com.tmmas.scl.doblecuenta.service.servicios;

import java.util.ArrayList;
import java.util.Date;
import java.util.StringTokenizer;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.businessobject.bo.AbonadoBOFactory;
import com.tmmas.scl.doblecuenta.businessobject.bo.ClienteBOFactory;
import com.tmmas.scl.doblecuenta.businessobject.bo.FacturaBOFactory;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.AbonadoBOIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.ClienteBOIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.FacturaBOFactoryIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.FacturaBOIT;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.service.interfaz.DobleCuentaSrvIF;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

public class DobleCuentaSrv implements DobleCuentaSrvIF{

	//private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(DobleCuentaSrv.class);

	private AbonadoBOFactoryIT factoryBO1 = new AbonadoBOFactory();
	private AbonadoBOIT abonadoBO = factoryBO1.getBusinessObject1();

	private ClienteBOFactoryIT factoryBO2 = new ClienteBOFactory();
	private ClienteBOIT clienteBO = factoryBO2.getBusinessObject1();
	
	private FacturaBOFactoryIT factoryBO3 = new FacturaBOFactory();
	private FacturaBOIT facturaBO = factoryBO3.getBusinessObject1();
	
	private CompositeConfiguration config; // MA
	
	private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaWeb/web/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaWeb.properties";
		     String strArchivoLog="DobleCuentaWeb.log";
		     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
	}
	

	public ClienteDTO[] obtenerListaClientesAsociados(ClienteDTO cliente) throws ProyectoException {

		System.out.println("entramos con exito obtenerListaClientesAsociadosSRV");
		ClienteDTO[] clienteList = null;
		try{
			
			setPropertieFile(); // MA
			
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaClientesAsociadosSRV():start");
			clienteList = clienteBO.obtenerListaClientesAsociados(cliente);
			logger.debug("obtenerListaClientesAsociadosSRV():end");
		} catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaClientesAsociadosSRV");
		return clienteList;
	}

	public ClienteDTO obtenerInformacionCliente(ClienteDTO clienteContratante) throws ProyectoException{

		System.out.println("entramos con exito obtenerInformacionClienteSRV");
		ClienteDTO respuesta = null;
		try{
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);
			setPropertieFile(); // MA
			
			logger.debug("obtenerInformacionClienteSRV():start");
			respuesta = clienteBO.obtenerInformacionCliente(clienteContratante);
			logger.debug("obtenerInformacionClienteSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerInformacionClienteSRV");
		return respuesta;
	}

	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException{

		System.out.println("entramos con exito obtenerListaAbonadoSRV");
		AbonadoDTO[] abonadosList = null;
		try{
			
			setPropertieFile(); // MA
			
			//String log = global.getValor("service.log");;
			//PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaAbonadoSRV():start");
			abonadosList = abonadoBO.obtenerListaAbonado(abonado);
			logger.debug("obtenerListaAbonadoSRV():end");
		} catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaAbonadoSRV");
		return abonadosList;
	}

	public ConceptoDTO[] obtenerListaConceptos() throws ProyectoException {
		
		System.out.println("entramos con exito obtenerListaConceptosSRV()");
		ConceptoDTO[] conceptos = null;
		try{
			
			setPropertieFile(); // MA
			
			//String log = global.getValor("service.log");;
			//PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaConceptosSRV():start");
			conceptos = facturaBO.obtenerListaConceptos();
			logger.debug("obtenerListaConceptosSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaConceptosSRV()");
		return conceptos;
	}
	
	
	public RetornoDTO insertaFacturacionDiferenciadaCabecera(FacturaDTO factura, ClienteDTO cliente) throws ProyectoException{
		
		System.out.println("entramos con exito insertaFacturacionDiferenciadaCabeceraSRV()");
		RetornoDTO respuesta = null;
		try{
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);
			
			setPropertieFile(); // MA
			
			logger.debug("insertaFacturacionDiferenciadaCabeceraSRV():start");
			respuesta = facturaBO.insertaFacturacionDiferenciadaCabecera(factura, cliente);
			logger.debug("insertaFacturacionDiferenciadaCabeceraSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		return respuesta;
	}
	
	
	public RetornoDTO insertarFacturacionDiferenciadaDetalle(FacturaDTO factura, AbonadoDTO abonado, ClienteDTO cliente, ConceptoDTO conceptos) throws ProyectoException{
		System.out.println("entramos con exito insertarFacturacionDiferenciadaDetalleSRV()");
		RetornoDTO respuesta = null;
		try{
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);
			
			setPropertieFile(); // MA
			
			logger.debug("insertaFacturacionDiferenciadaDetalleSRV():start");
			respuesta = facturaBO.insertarFacturacionDiferenciadaDetalle(factura, abonado, cliente, conceptos);
			logger.debug("insertaFacturacionDiferenciadaDetalleSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		return respuesta;
	}

	public RetornoDTO updateFacturacionDiferenciadaCabecera(ClienteDTO cliente, AbonadoDTO abonado, FacturaDTO factura) throws ProyectoException {
		System.out.println("entramos con exito insertarFacturacionDiferenciadaDetalleSRV()");
		RetornoDTO respuesta = null;
		try{
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);
			
			setPropertieFile(); // MA
			
			logger.debug("updateFacturacionDiferenciadaCabeceraSRV():start");
			respuesta = facturaBO.updateFacturacionDiferenciadaCabecera(cliente, abonado, factura);
			logger.debug("updateFacturacionDiferenciadaCabeceraSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		return respuesta;
		
	}

	public ClientesAsociadosDTO[] buscarClientesAsociados(ClienteDTO clienteContratante) throws ProyectoException {
		System.out.println("entramos con exito insertarFacturacionDiferenciadaDetalleSRV()");
		ClientesAsociadosDTO[] clientes = null;
		try{
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);
			
			setPropertieFile(); // MA
			
			logger.debug("buscarClientesAsociadosSRV():start");
			clientes = clienteBO.buscarClientesAsociados(clienteContratante);
			logger.debug("buscarClientesAsociadosSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		return clientes;
	}

	public RetornoDTO bajaMasivaFacturacion(FacturaDTO factura) throws ProyectoException {
		
		System.out.println("entramos con exito bajaMasivaFacturacionSRV()");
		RetornoDTO respuesta = null;
		try{
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);
			setPropertieFile(); // MA
			
			logger.debug("bajaMasivaFacturacionSRV():start");
			respuesta = facturaBO.bajaMasivaFacturacion(factura);
			logger.debug("bajaMasivaFacturacionSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("entramos con exito bajaMasivaFacturacionSRV()");
		return respuesta;
	}
	
	public long[][] ejecutaOS(String [] datosAsociadosChequeados, ClienteDTO cliente, FacturaDTO facturaDTO, long secuenciaInsertar, ArrayList listGri, RetornoDTO retorno) throws ProyectoException {
		System.out.println("entramos con exito ejecutaOS()");
		long [][]listaR = null;
		try{
			//String log = global.getValor("service.log");
			//PropertyConfigurator.configure(log);
			setPropertieFile(); // MA
			
			String fila="";
			String id_abon = "";
			String id_clien = "";
			String id_concep = "";
			String num = "";
			String valorRec= "";
			ClienteDTO clienteDT = new ClienteDTO();
			AbonadoDTO abonado = new AbonadoDTO();
			ConceptoDTO conceptos = new ConceptoDTO();
			long numSecEncabezadoFd = 0;
			long numSecDetalleFd = 0;
			logger.debug("DobleCuentaSrv->datosAsociadosChequeados.length="+ datosAsociadosChequeados.length);
			listaR = new long[datosAsociadosChequeados.length][2];
			for (int j =0; j< datosAsociadosChequeados.length;j++) {
				fila=datosAsociadosChequeados[j];
				StringTokenizer st=new StringTokenizer(fila,"|");
				id_abon = st.nextToken(); 
				id_clien = st.nextToken(); 
				id_concep = st.nextToken(); 
				valorRec = st.nextToken();
				num = id_abon;
				clienteDT.setCodClienteContra(cliente.getCodClienteContra());
				facturaDTO.setFecIngRegistro(new Date());
				facturaDTO.setCodCiclo(cliente.getCodCiclo());

				// -------llamada alservicio de insertaFacturacionDiferenciadaCabecera
				RetornoDTO retornoDTO = null;
				if(secuenciaInsertar == 0){
					System.out.println("Cliente contratante nuevo en doble cuenta.");
					retornoDTO = insertaFacturacionDiferenciadaCabecera(facturaDTO, clienteDT);
					retorno.setCodigo(retornoDTO.getCodigo());
					retorno.setDescripcion(retornoDTO.getDescripcion());
					retorno.setNumSecDetalleFd(retornoDTO.getNumSecDetalleFd());
					retorno.setNumSecEncabezadoFd(retornoDTO.getNumSecEncabezadoFd());
					retorno.setResultado(retornoDTO.isResultado());
					numSecEncabezadoFd = retornoDTO.getNumSecEncabezadoFd();
					listaR[j][0]=numSecEncabezadoFd;
					facturaDTO.setNumSecEncabezadoFd(numSecEncabezadoFd);
					secuenciaInsertar = numSecEncabezadoFd;
				}else{
					System.out.println("Cliente contratante antiguo en doble cuenta.");
					facturaDTO.setNumSecEncabezadoFd(secuenciaInsertar);					
				}
				
				clienteDT.setCodClienteAsoc(Long.parseLong(id_clien));
				abonado.setNumAbonado(num);
				conceptos.setCodConceptoOrig(Long.parseLong(id_concep));
				conceptos.setMontoConcepto(Float.parseFloat(valorRec));
				facturaDTO.setFecIngRegistro(new Date());
				facturaDTO.setFecCieRegistro(new Date());
				//-------llamada alservicio de insertarFacturacionDiferenciadaDetalle				
				retornoDTO = insertarFacturacionDiferenciadaDetalle(facturaDTO, abonado, clienteDT, conceptos);
				retorno.setCodigo(retornoDTO.getCodigo());
				retorno.setDescripcion(retornoDTO.getDescripcion());
				retorno.setNumSecDetalleFd(retornoDTO.getNumSecDetalleFd());
				retorno.setNumSecEncabezadoFd(retornoDTO.getNumSecEncabezadoFd());
				retorno.setResultado(retornoDTO.isResultado());
				numSecDetalleFd = retornoDTO.getNumSecDetalleFd();
				listaR[j][1]=numSecDetalleFd;
				//String guardado="";
				//guardado="guard";
			}
			
			
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito ejecutaOS()");
		return listaR;
		
	}
	
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws ProyectoException{
		
		System.out.println("entramos con exito obtenerSecuencia en SRV()");
		SecuenciaDTO respuesta = null;
		try{
			setPropertieFile(); // MA
			
			logger.debug("buscarClientesAsociadosSRV():start");
				respuesta = clienteBO.obtenerSecuencia(parametro);
			logger.debug("buscarClientesAsociadosSRV():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		return respuesta;
	}	
	
}
