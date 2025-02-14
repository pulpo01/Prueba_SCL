/**
 * ReservaDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondeabonados.scl.cl.tmmas.com;

public class ReservaDTO  implements java.io.Serializable {
    private int codArticulo;

    private int codUso;

    private long codVendedor;

    private java.lang.String estadoReserva;

    private java.lang.String nomUsuario;

    private java.lang.String numeroSerie;

    private long numeroSolicitud;

    public ReservaDTO() {
    }

    public ReservaDTO(
           int codArticulo,
           int codUso,
           long codVendedor,
           java.lang.String estadoReserva,
           java.lang.String nomUsuario,
           java.lang.String numeroSerie,
           long numeroSolicitud) {
           this.codArticulo = codArticulo;
           this.codUso = codUso;
           this.codVendedor = codVendedor;
           this.estadoReserva = estadoReserva;
           this.nomUsuario = nomUsuario;
           this.numeroSerie = numeroSerie;
           this.numeroSolicitud = numeroSolicitud;
    }


    /**
     * Gets the codArticulo value for this ReservaDTO.
     * 
     * @return codArticulo
     */
    public int getCodArticulo() {
        return codArticulo;
    }


    /**
     * Sets the codArticulo value for this ReservaDTO.
     * 
     * @param codArticulo
     */
    public void setCodArticulo(int codArticulo) {
        this.codArticulo = codArticulo;
    }


    /**
     * Gets the codUso value for this ReservaDTO.
     * 
     * @return codUso
     */
    public int getCodUso() {
        return codUso;
    }


    /**
     * Sets the codUso value for this ReservaDTO.
     * 
     * @param codUso
     */
    public void setCodUso(int codUso) {
        this.codUso = codUso;
    }


    /**
     * Gets the codVendedor value for this ReservaDTO.
     * 
     * @return codVendedor
     */
    public long getCodVendedor() {
        return codVendedor;
    }


    /**
     * Sets the codVendedor value for this ReservaDTO.
     * 
     * @param codVendedor
     */
    public void setCodVendedor(long codVendedor) {
        this.codVendedor = codVendedor;
    }


    /**
     * Gets the estadoReserva value for this ReservaDTO.
     * 
     * @return estadoReserva
     */
    public java.lang.String getEstadoReserva() {
        return estadoReserva;
    }


    /**
     * Sets the estadoReserva value for this ReservaDTO.
     * 
     * @param estadoReserva
     */
    public void setEstadoReserva(java.lang.String estadoReserva) {
        this.estadoReserva = estadoReserva;
    }


    /**
     * Gets the nomUsuario value for this ReservaDTO.
     * 
     * @return nomUsuario
     */
    public java.lang.String getNomUsuario() {
        return nomUsuario;
    }


    /**
     * Sets the nomUsuario value for this ReservaDTO.
     * 
     * @param nomUsuario
     */
    public void setNomUsuario(java.lang.String nomUsuario) {
        this.nomUsuario = nomUsuario;
    }


    /**
     * Gets the numeroSerie value for this ReservaDTO.
     * 
     * @return numeroSerie
     */
    public java.lang.String getNumeroSerie() {
        return numeroSerie;
    }


    /**
     * Sets the numeroSerie value for this ReservaDTO.
     * 
     * @param numeroSerie
     */
    public void setNumeroSerie(java.lang.String numeroSerie) {
        this.numeroSerie = numeroSerie;
    }


    /**
     * Gets the numeroSolicitud value for this ReservaDTO.
     * 
     * @return numeroSolicitud
     */
    public long getNumeroSolicitud() {
        return numeroSolicitud;
    }


    /**
     * Sets the numeroSolicitud value for this ReservaDTO.
     * 
     * @param numeroSolicitud
     */
    public void setNumeroSolicitud(long numeroSolicitud) {
        this.numeroSolicitud = numeroSolicitud;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ReservaDTO)) return false;
        ReservaDTO other = (ReservaDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.codArticulo == other.getCodArticulo() &&
            this.codUso == other.getCodUso() &&
            this.codVendedor == other.getCodVendedor() &&
            ((this.estadoReserva==null && other.getEstadoReserva()==null) || 
             (this.estadoReserva!=null &&
              this.estadoReserva.equals(other.getEstadoReserva()))) &&
            ((this.nomUsuario==null && other.getNomUsuario()==null) || 
             (this.nomUsuario!=null &&
              this.nomUsuario.equals(other.getNomUsuario()))) &&
            ((this.numeroSerie==null && other.getNumeroSerie()==null) || 
             (this.numeroSerie!=null &&
              this.numeroSerie.equals(other.getNumeroSerie()))) &&
            this.numeroSolicitud == other.getNumeroSolicitud();
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        _hashCode += getCodArticulo();
        _hashCode += getCodUso();
        _hashCode += new Long(getCodVendedor()).hashCode();
        if (getEstadoReserva() != null) {
            _hashCode += getEstadoReserva().hashCode();
        }
        if (getNomUsuario() != null) {
            _hashCode += getNomUsuario().hashCode();
        }
        if (getNumeroSerie() != null) {
            _hashCode += getNumeroSerie().hashCode();
        }
        _hashCode += new Long(getNumeroSolicitud()).hashCode();
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ReservaDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "ReservaDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codArticulo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodArticulo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codUso");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodUso"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "CodVendedor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("estadoReserva");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "EstadoReserva"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomUsuario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "NomUsuario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroSerie");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "NumeroSerie"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroSolicitud");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeabonados.businessobject.dto", "NumeroSolicitud"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
