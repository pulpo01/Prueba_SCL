package com.tmmas.scl.framework.ProductDomain.bo.interfaces;

import com.tmmas.scl.framework.ProductDomain.dto.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;

public interface SiniestroBOIT {

	public TipoSiniestroDTO[] obtenerTiposDeSiniestros (UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public CausaSiniestroDTO[] obtenerCausasSiniestro (UsuarioAbonadoDTO usuarioAbonado, String Actabo) throws ProductException;
	public TipoSuspencionDTO[] obtenerTiposDeSuspencion () throws ProductException;
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	//public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException;
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario, String numeroDesvio) throws ProductException;
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public void anulaSinistroAbonado (SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException;
	public CambioPlanPendienteDTO validarCambioPlanPendiente(CambioPlanPendienteDTO cambioPlan) throws ProductException;
		//Incluido santiago ventura 23-03-2010
	public void anulaNumeroConstanciaPolicial (SiniestrosDTO siniestros) throws ProductException;
}
