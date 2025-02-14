package scorecliente;

public class ScoreClienteProxy implements scorecliente.ScoreCliente {
  private String _endpoint = null;
  private scorecliente.ScoreCliente scoreCliente = null;
  
  public ScoreClienteProxy() {
    _initScoreClienteProxy();
  }
  
  private void _initScoreClienteProxy() {
    try {
      scoreCliente = (new scorecliente.ScoreClienteServiceLocator()).getScoreCliente();
      if (scoreCliente != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)scoreCliente)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)scoreCliente)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (scoreCliente != null)
      ((javax.xml.rpc.Stub)scoreCliente)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public scorecliente.ScoreCliente getScoreCliente() {
    if (scoreCliente == null)
      _initScoreClienteProxy();
    return scoreCliente;
  }
  
  public sujetos.ResultadoFisico getSujetoFisico(java.lang.String i_creado_por, java.lang.String i_tarjeta, java.lang.String i_tipo_tarjeta, java.lang.String i_fecha_creacion, java.lang.String i_primer_nombre, java.lang.String i_segundo_nombre, java.lang.String i_primer_apellido, java.lang.String i_segundo_apellido, java.lang.String i_tipo_documento, java.lang.String i_documento, java.lang.String i_nit, java.lang.String i_fecha_nacimiento, java.lang.String i_capacidad_pago, java.lang.String i_nacionalidad, java.lang.String i_nivel_academico, java.lang.String i_estado_civil, java.lang.String i_tipo_empresa, java.lang.String i_antiguedad_laboral, java.lang.String i_tip_producto, java.lang.String i_cod_elementoid) throws java.rmi.RemoteException{
    if (scoreCliente == null)
      _initScoreClienteProxy();
    return scoreCliente.getSujetoFisico(i_creado_por, i_tarjeta, i_tipo_tarjeta, i_fecha_creacion, i_primer_nombre, i_segundo_nombre, i_primer_apellido, i_segundo_apellido, i_tipo_documento, i_documento, i_nit, i_fecha_nacimiento, i_capacidad_pago, i_nacionalidad, i_nivel_academico, i_estado_civil, i_tipo_empresa, i_antiguedad_laboral, i_tip_producto, i_cod_elementoid);
  }
  
  
}