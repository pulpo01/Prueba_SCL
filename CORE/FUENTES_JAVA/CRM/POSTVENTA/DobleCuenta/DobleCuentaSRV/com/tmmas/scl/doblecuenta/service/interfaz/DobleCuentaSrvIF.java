package com.tmmas.scl.doblecuenta.service.interfaz;

import java.util.ArrayList;

import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

public interface DobleCuentaSrvIF {
	
	public ClienteDTO[] obtenerListaClientesAsociados(ClienteDTO cliente) throws ProyectoException;
	
	public ClienteDTO obtenerInformacionCliente(ClienteDTO clienteContratante) throws ProyectoException;
	
	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException;
	
	public ConceptoDTO[] obtenerListaConceptos() throws ProyectoException;
	
	public RetornoDTO insertaFacturacionDiferenciadaCabecera(FacturaDTO factura, ClienteDTO cliente) throws ProyectoException;
	
	public RetornoDTO insertarFacturacionDiferenciadaDetalle(FacturaDTO factura, AbonadoDTO abonado, ClienteDTO cliente, ConceptoDTO conceptos) throws ProyectoException;
	
	public RetornoDTO updateFacturacionDiferenciadaCabecera(ClienteDTO cliente, AbonadoDTO abonado, FacturaDTO factura) throws ProyectoException;
	
	public RetornoDTO bajaMasivaFacturacion(FacturaDTO factura) throws ProyectoException;
	
	public ClientesAsociadosDTO[] buscarClientesAsociados(ClienteDTO clienteContratante) throws ProyectoException;
	
	public long[][] ejecutaOS(String [] datosAsociadosChequeados, ClienteDTO cliente, FacturaDTO facturaDTO, long secuenciaInsertar, ArrayList listGri, RetornoDTO retorno) throws ProyectoException;
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO parametro) throws ProyectoException;
}
