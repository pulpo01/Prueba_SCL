package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.util.Date;

public interface IVentaDTO {

	public abstract ClienteFrmkDTO getCliente();

	public abstract void setCliente(ClienteFrmkDTO cliente);

	public abstract Date getFecVenta();

	public abstract void setFecVenta(Date fecVenta);

	public abstract Long getNumVenta();

	public abstract void setNumVenta(Long numVenta);

}