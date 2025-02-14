/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.factory;

import java.util.Date;

import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.CargaAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.RangoDTO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.RangoVO;


/**
 * @author mwn40032
 *
 */
public class AsociaRangoFactoryDTO
{
	public static RangoDTO createRangoDTO(RangoVO vo)
	{
		if (vo == null)
			return null;
		
		RangoDTO dto = new RangoDTO();
/*		
		dto.setEstado(vo.getEstado());
		dto.setFechaAlta(vo.getFechaAlta());
		dto.setFechaBaja(vo.getFechaBaja());
		dto.setFechaRehabilitacion(vo.getFechaRehabilitacion());
		dto.setFechaSuspension(vo.getFechaSuspension());
		dto.setNomUsuarOra(vo.getNomUsuarOra());
		dto.setNomUsuarOra(vo.getNomUsuarOra());
*/		
		dto.setNumDesde(vo.getNumDesde());
		dto.setNumHasta(vo.getNumHasta());
		
		return dto;
	}
	
	public static RangoDTO createDummyRangoDTO(long numPiloto)
	{
		RangoDTO rangoDTO = new RangoDTO();
		
		rangoDTO.setNumDesde(numPiloto);
		rangoDTO.setNumHasta(numPiloto + 1);
/*		
		rangoDTO.setFechaAlta(new Date());
		rangoDTO.setFechaBaja(null);
		rangoDTO.setFechaSuspension(null);
		rangoDTO.setFechaRehabilitacion(null);
		rangoDTO.setEstado("1");
		rangoDTO.setNomUsuarOra("dummy");
*/		
		return rangoDTO;
	}
	
	public static CargaAsociaRangoDTO createDummyCargaAsociaRangoDTO()
	{
		CargaAsociaRangoDTO cargaAsociaRangoDTO = new CargaAsociaRangoDTO();
		long suma;
		int totalRangosAsociados = 2; 
		int totalRangosDisponibles = 10; 
		
		cargaAsociaRangoDTO.setNumAbonado(new Long(323));
		
		suma = 0;
		
		RangoDTO[] rangosAsociados = new RangoDTO[totalRangosAsociados]; 
		
		for(int i = 0; i < totalRangosAsociados; i++, suma += 100)
			rangosAsociados[i] = AsociaRangoFactoryDTO.createDummyRangoDTO(suma);
		
		cargaAsociaRangoDTO.setRangosAsociados(rangosAsociados);

		RangoDTO[] rangosDisponibles = new RangoDTO[totalRangosDisponibles]; 
		suma = 0;
		
		for(int i = 0; i < totalRangosDisponibles; i++, suma += 100)
			rangosDisponibles[i] = AsociaRangoFactoryDTO.createDummyRangoDTO(suma + 1000);
		
		cargaAsociaRangoDTO.setRangosDisponibles(rangosDisponibles);

		return cargaAsociaRangoDTO;
	}
		
}
