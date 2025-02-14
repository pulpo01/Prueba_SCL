/**
 * 
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;
import java.util.ArrayList;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;

/**
 * @author santiago ventura
 *
 */
public class AbonadoNumerosFrecuentesDTO implements Serializable{
	 
	private AbonadoDTO[] abonadoDTO;
	private ArrayList numerosFrecuentesTipoListDTO = null;//Array de NumeroFrecuenteTipoListDTO
			
	/**
	 * 
	 */
	public AbonadoNumerosFrecuentesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * @return the abonadoDTO
	 */
	public AbonadoDTO[] getAbonadoDTO() {
		return abonadoDTO;
	}
	/**
	 * @param abonadoDTO the abonadoDTO to set
	 */
	public void setAbonadoDTO(AbonadoDTO[] abonadoDTO) {
		this.abonadoDTO = abonadoDTO;
	}
	/**
	 * @return the numerosFrecuentesTipoListDTO
	 */
	public ArrayList getNumerosFrecuentesTipoListDTO() {
		return numerosFrecuentesTipoListDTO;
	}
	/**
	 * @param numerosFrecuentesTipoListDTO the numerosFrecuentesTipoListDTO to set
	 */
	public void setNumerosFrecuentesTipoListDTO(ArrayList numerosFrecuentesTipoListDTO) {
		this.numerosFrecuentesTipoListDTO = numerosFrecuentesTipoListDTO;
	}

}
