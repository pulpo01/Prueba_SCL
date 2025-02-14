package com.tmmas.scl.framework.ProductDomain.bo.interfaces;

import com.tmmas.scl.framework.ProductDomain.dto.GaAboMailTODTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSuPlDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSupDefDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public interface ServiciosSuplementariosBOIT {

	public ReglasSSDTO[] getReglasdeValidacionSS(UsuarioAbonadoDTO usuarioAbonado, AbonadoDTO abonado) throws ProductException;
	public SSuplementarioDTO[] obtenerServiciosDisplonibles(UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException;
	public SSuplementarioDTO[] obtenerServiciosContratados(UsuarioAbonadoDTO usuarioAbonado, long opcion) throws ProductException;
	public void actDesactSS(ClienteOSSesionDTO sessionData, String listServAct, String listServDesac, String montoTotal, UsuarioSistemaDTO usuarioSistema, String comentario) throws ProductException;
	public SSuplementarioDTO[] getServiciosBBContratados(UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public GaServSupDefDTO[] getObtieneListCodServPorDef(GaServSupDefDTO gaServSupDefDTO) throws ProductException;
	public GaServSuPlDTO getEstadoCorreoServSupl(GaServSuPlDTO gaServSuPlDTO) throws ProductException;
	public GaAboMailTODTO[] getAbomailTOxNumAbonado (GaAboMailTODTO gaAboMailTODTO)throws  ProductException;
	
} // ServiciosSuplementariosBOIT
