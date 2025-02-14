/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.factory;

import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.RangoDTO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.RangoVO;


/**
 * Factory method.
 * @author mwn40032
 *
 */
public class AsociaRangoFactoryVO
{
	public static RangoVO createRangoVO(RangoDTO dto)
	{
		if (dto == null)
			return null;
		
		RangoVO vo = new RangoVO();
/*		
		vo.setEstado(dto.getEstado());
		vo.setFechaAlta(dto.getFechaAlta() == null ? null: new Date(dto.getFechaAlta().getTime()));
		vo.setFechaBaja(dto.getFechaBaja() == null ? null: new Date(dto.getFechaBaja().getTime()));
		vo.setFechaRehabilitacion(dto.getFechaRehabilitacion() == null ? null: new Date(dto.getFechaRehabilitacion().getTime()));
		vo.setFechaSuspension(dto.getFechaSuspension() == null ? null: new Date(dto.getFechaSuspension().getTime()));
		vo.setNomUsuarOra(dto.getNomUsuarOra());
		vo.setNomUsuarOra(dto.getNomUsuarOra());
*/
		vo.setNumDesde(dto.getNumDesde());
		vo.setNumHasta(dto.getNumHasta());

		return vo;
	}
	
}
