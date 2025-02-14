package com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo;

import java.util.List;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao.TiendasDAO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO;

public class TiendasBO {
	
	private TiendasDAO tiendasDAO = new TiendasDAO();
	private static Category cat = Category.getInstance(TiendasBO.class);

	//Recuperar Tiendas
	public WsTiendasOutDTO getTiendas()throws GeneralException{
		cat.debug("Inicio:getTiendas()");
		cat.debug("Fin:getTiendas()");
		return tiendasDAO.getTiendas();
	}
	
//	Busca info de la tienda y el usuario
	public WsTiendaVendedorOutDTO getTiendaVendedor(String codTienda)throws GeneralException
	{
		cat.info("getTiendaVendedor():Inicio");
		cat.info("getTiendaVendedor():fin");
		return tiendasDAO.getTiendaVendedor(codTienda);
	}
	
	/*
	 * Metodo: insertTienda
	 * Descripcion: crea una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public WsInsertTiendaOutDTO insertTienda(TiendaDTO tiendaDTO)throws GeneralException{
		cat.info("insertTienda():Inicio");
		WsInsertTiendaOutDTO wsInsertTiendaOutDTO = tiendasDAO.insertTienda(tiendaDTO);
		cat.info("insertTienda():fin");
		return wsInsertTiendaOutDTO;
	}
	
	/*
	 * Metodo: obtieneListaTienda
	 * Descripcion: Obtiene una lista de tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public List obtieneListaTienda()throws GeneralException{
		cat.info("obtieneListaTienda():Inicio");
		List listaTienda = tiendasDAO.obtieneListaTienda();
		cat.info("obtieneListaTienda():fin");
		return listaTienda;
	}
	
	/*
	 * Metodo: updateTienda
	 * Descripcion: Actualiza una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public WsUpdateTiendaOutDTO updateTienda(TiendaDTO tiendaModDTO)throws GeneralException{
		cat.info("updateTienda():Inicio");
		WsUpdateTiendaOutDTO wsUpdateTiendaOutDTO = tiendasDAO.updateTienda(tiendaModDTO);
		cat.info("updateTienda():fin");
		return wsUpdateTiendaOutDTO;
	}
	
	/*
	 * Metodo: deleteTienda
	 * Descripcion: elimina una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public void deleteTienda(Long codTienda)throws GeneralException{
		cat.info("deleteTienda():Inicio");
		tiendasDAO.deleteTienda(codTienda);
		cat.info("deleteTienda():fin");
	}
	
	/*
	 * Metodo: obtieneListaCaja
	 * Descripcion: Obtiene una lista de Caja
	 * Fecha: 02/07/2010
	 * Developer: Jorge González N.
	 */
	public WsCajaOutDTO getListaCaja(String codOficina)throws GeneralException{
		cat.debug("Inicio:getListaCaja()");
		cat.debug("Fin:getListaCaja()");
		return tiendasDAO.getListaCaja(codOficina);
	}
	
}
