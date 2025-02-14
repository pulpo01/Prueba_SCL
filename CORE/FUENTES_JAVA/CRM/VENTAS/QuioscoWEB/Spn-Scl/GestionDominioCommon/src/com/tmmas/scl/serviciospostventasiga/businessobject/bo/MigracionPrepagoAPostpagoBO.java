package com.tmmas.scl.serviciospostventasiga.businessobject.bo;

import java.sql.SQLException;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.MigracionPrepagoAPostpagoDAO;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.RegistraOOSSDAO;
import com.tmmas.scl.serviciospostventasiga.transport.AbonadoVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ClienteSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.DatosGeneralesDTO;
import com.tmmas.scl.serviciospostventasiga.transport.EntradaOOSSDTO;
import com.tmmas.scl.serviciospostventasiga.transport.EquipoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.EquipoVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.GenericoOOSSDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MovimientoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.OOSSDTO;
import com.tmmas.scl.serviciospostventasiga.transport.OOSSVO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesIndemnizacionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesServiciosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesTarifariosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ServiciosSuplementariosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ServiciosSuplementariosVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.TipoContratoSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.UsuarioSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.ValorPlanDTO;
import com.tmmas.scl.serviciospostventasiga.transport.VentaDTO;

public class MigracionPrepagoAPostpagoBO {

	private MigracionPrepagoAPostpagoDAO migracionDAO = new MigracionPrepagoAPostpagoDAO();
	
	public void getUsuarioPrepago(UsuarioSIGADTO usuarioSIGADTO) throws GeneralException{
		migracionDAO.getUsuarioPrepago(usuarioSIGADTO);
	}
	
	public void getDatosSerSupl(ServiciosSuplementariosVtaDTO ss) throws GeneralException
	{
		migracionDAO.getDatosSerSupl(ss);
	}
	
	public void getUsosLinea (AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getUsosLinea(abonadoVtaDTO);
	}
	
	public void getDatosAbonado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getDatosAbonado(abonadoVtaDTO);
	}
	
	public PlanesTarifariosDTO getPLanesTarifarios()throws GeneralException
	{
		return migracionDAO.getPLanesTarifarios();
	}
	
	public PlanesServiciosDTO getPlanesServ(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		return migracionDAO.getPlanesServ(abonadoVtaDTO);
	}
	
	public PlanesIndemnizacionDTO getPlanesIndem()throws GeneralException
	{
		return migracionDAO.getPlanesIndem();
	}
	
	public void obtieneImei(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.obtieneImei(abonadoVtaDTO);
	}
	
	public void obtieneSerie(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.obtieneSerie(abonadoVtaDTO);
	}
	
	public void getCodArticulo(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCodArticulo(abonadoVtaDTO);
	}
	
	public void getDatosEquipo(EquipoDTO equipoDTO)throws GeneralException
	{
		migracionDAO.getDatosEquipo(equipoDTO);
	}
	
	public ServiciosSuplementariosDTO getCadenaServSuplementarios(AbonadoVtaDTO abonadoDTO, String tipoAbonado)throws GeneralException
	{
		return migracionDAO.getCadenaServSuplementarios(abonadoDTO, tipoAbonado);
	}
	
	public ServiciosSuplementariosDTO[] getServSuplementarios(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		return migracionDAO.getServSuplementarios(abonadoVtaDTO);
	}
	
	public void getOficinaPrincipal(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getOficinaPrincipal(abonadoVtaDTO);
	}
	
	public void getFechaFinContrato(TipoContratoSIGADTO tipoContrato)throws GeneralException
	{
		migracionDAO.getFechaFinContrato(tipoContrato);
	}
	
	public void getNumAbonado(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getNumAbonado(abonadoVtaDTO);
	}
	
	public void getFechaCumplimiento(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getFechaCumplimiento(abonadoVtaDTO);
	}
	
	public void getPrefijo(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getPrefijo(abonadoVtaDTO);
	}
	
	public void getSubalm(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getSubalm(abonadoVtaDTO);
	}
	
	public void insertaAbonado(AbonadoVtaDTO entrada)throws GeneralException
	{
		migracionDAO.insertaAbonado(entrada);
	}
	
	public void insertaEquipo(EquipoVtaDTO entrada)throws GeneralException
	{
		migracionDAO.insertaEquipo(entrada);
	}
	
	public void insertaServSupl(ServiciosSuplementariosVtaDTO entrada)throws GeneralException
	{
		migracionDAO.insertaServSupl(entrada);
	}
	
	public void insertaVenta(VentaDTO ventaDTO)throws GeneralException
	{
		migracionDAO.insertaVenta(ventaDTO);
	}
	
	public void getNumVenta(VentaDTO ventaDTO)throws GeneralException
	{
		migracionDAO.getNumVenta(ventaDTO);
	}
	
	public void obtieneImpuesto(VentaDTO ventaDTO)throws GeneralException
	{
		migracionDAO.obtieneImpuesto(ventaDTO);
	}
	
	public void getNumMeses(TipoContratoSIGADTO tipoContratoSIGADTO)throws GeneralException
	{
		migracionDAO.getNumMeses(tipoContratoSIGADTO);
	}
	
	public void insertaMovimiento(MovimientoDTO movimientoDTO)throws GeneralException
	{
		migracionDAO.insertaMovimiento(movimientoDTO);
	}
	
	public void getCodCiclo(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCodCiclo(abonadoVtaDTO);
	}
	
	public void getDatos(DatosGeneralesDTO datosGeneralesDTO) throws GeneralException
	{
		migracionDAO.getDatos(datosGeneralesDTO);
	}
	
	public void getCodCuenta(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCodCuenta(abonadoVtaDTO);
	}
	
	public void getDireccion(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getDireccion(abonadoVtaDTO);
	}
	
	public void getCargoBasico(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCargoBasico(abonadoVtaDTO);
	}
	
	public void getCodVendedor(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCodVendedor(abonadoVtaDTO);
	}
	
	public void getCodLimCons(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCodLimCons(abonadoVtaDTO);
	}
	
	public void getCodBodega(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCodBodega(abonadoVtaDTO);
	}
	
	public void getCodPlaza(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.getCodPlaza(abonadoVtaDTO);
	}
	
	public void getNumContrato(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		 migracionDAO.getNumContrato(abonadoVtaDTO);
	}
	public void obtieneParametro(DatosGeneralesDTO datosGeneralesDTO)throws GeneralException
	{
		migracionDAO.obtieneParametro(datosGeneralesDTO);
	}
	
	public void obtencionCodCred(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException
	{
		migracionDAO.obtencionCodCred(abonadoVtaDTO);
	}
	
	public void inscribeOOSS(OOSSDTO ooss) throws GeneralException
	{
		migracionDAO.inscribeOOSS(ooss);
	}
	
	public String obtencionSSPorDefecto(String codActabo)throws GeneralException{
		return migracionDAO.obtencionSSPorDefecto(codActabo);
	}
	
	//regstro de ooss
	public GenericoOOSSDTO insertarOOSS(OOSSVO oOSSVO)throws GeneralException,SQLException,Exception{
		GenericoOOSSDTO frmkRespuesta = new GenericoOOSSDTO();
			EntradaOOSSDTO frmkOOSSDTO = new EntradaOOSSDTO();
			frmkOOSSDTO.setSCodOS(oOSSVO.getCodOS());//OOSS.codigo
			frmkOOSSDTO.setSCodUsuario(oOSSVO.getNomUsuarioSCL());
			frmkOOSSDTO.setSComentario(oOSSVO.getComentario());
			frmkOOSSDTO.setLNumAbonado(new Long(oOSSVO.getNumAbonado()));
			RegistraOOSSDAO frmkOOSSDAO = new RegistraOOSSDAO();
			try{
				frmkRespuesta = frmkOOSSDAO.inscribeOOSS(frmkOOSSDTO);
				if(frmkRespuesta.getCodError() != 0){
					System.out.println("OOSS NO registrada!!!");
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
			return frmkRespuesta;

	}
	
	public void creaUsuario(UsuarioSIGADTO usuarioSIGADTO) throws GeneralException{
		migracionDAO.creaUsuario(usuarioSIGADTO);
	}
	
	public void obtencionEstadoIncompletoUsuario(UsuarioSIGADTO usuarioSIGADTO) throws GeneralException{
		migracionDAO.obtencionEstadoIncompletoUsuario(usuarioSIGADTO);
	}
	
	public void obtencionCodUsuario(UsuarioSIGADTO usuarioSIGADTO) throws GeneralException{
		migracionDAO.obtencionCodUsuario(usuarioSIGADTO);
	}
	
	public void obtencionDatosCliente(ClienteSIGADTO clienteSIGADTO) throws GeneralException{
		migracionDAO.obtencionDatosCliente(clienteSIGADTO);
	}
	
	public void inscripcionDirecciones(AbonadoVtaDTO abonadoVtaDTO)throws GeneralException{
		migracionDAO.inscripcionDirecciones(abonadoVtaDTO);
	}
	
	public String obtencionValorPlan(ValorPlanDTO valorPlanDTO)throws GeneralException
	{
		return migracionDAO.obtencionValorPlan(valorPlanDTO);
	}
	//retulizacion siga
//	public LimConsumoDTO getLimiteConsumo(LimConsumoDTO limConsumoDTO)
//	throws GeneralException
//	{
//		//cat.debug("BO Abonado:insertGaDocVentas():inicio");
//		limConsumoDTO=migracionDAO.getLimiteConsumo(limConsumoDTO);
//		//.debug("BO Abonado:insertGaDocVentas():fin");
//		return limConsumoDTO;
//	}
}
