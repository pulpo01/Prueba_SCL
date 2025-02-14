package com.tmmas.scl.wsventaenlace.transport.dto.ventaenlace;

import com.tmmas.scl.wsventaenlace.transport.dto.OOSSFase2DTO;
import com.tmmas.scl.wsventaenlace.transport.vo.ventaenlace.VentaEnlaceE1VO;

public class ValidacionesVentaEnlaceE1DTO extends OOSSFase2DTO {

	private VentaEnlaceE1VO ventaEnlaceE1VO;
	private VentaEnlaceE1DTO ventaEnlaceE1DTO;

	public VentaEnlaceE1VO getVentaEnlaceE1VO() {
		return ventaEnlaceE1VO;
	}

	public void setVentaEnlaceE1VO(VentaEnlaceE1VO ventaEnlaceE1VO) {
		this.ventaEnlaceE1VO = ventaEnlaceE1VO;
	}

	public VentaEnlaceE1DTO getVentaEnlaceE1DTO() {
		return ventaEnlaceE1DTO;
	}

	public void setVentaEnlaceE1DTO(VentaEnlaceE1DTO ventaEnlaceE1DTO) {
		this.ventaEnlaceE1DTO = ventaEnlaceE1DTO;
	}
}
