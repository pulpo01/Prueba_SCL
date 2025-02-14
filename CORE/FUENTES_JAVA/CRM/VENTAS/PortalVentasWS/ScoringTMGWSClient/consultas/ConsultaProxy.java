package consultas;

public class ConsultaProxy implements consultas.Consulta {
  private String _endpoint = null;
  private consultas.Consulta consulta = null;
  
  public ConsultaProxy() {
    _initConsultaProxy();
  }
  
  private void _initConsultaProxy() {
    try {
      consulta = (new consultas.ConsultaServiceLocator()).getConsulta();
      if (consulta != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)consulta)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)consulta)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (consulta != null)
      ((javax.xml.rpc.Stub)consulta)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public consultas.Consulta getConsulta() {
    if (consulta == null)
      _initConsultaProxy();
    return consulta;
  }
  
  public java.lang.String getDatos(java.lang.String valor) throws java.rmi.RemoteException{
    if (consulta == null)
      _initConsultaProxy();
    return consulta.getDatos(valor);
  }
  
  
}