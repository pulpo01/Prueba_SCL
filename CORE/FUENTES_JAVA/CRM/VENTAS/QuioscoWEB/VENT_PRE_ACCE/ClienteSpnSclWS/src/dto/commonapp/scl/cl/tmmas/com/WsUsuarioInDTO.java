/**
 * WsUsuarioInDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.scl.cl.tmmas.com;

public class WsUsuarioInDTO  implements java.io.Serializable {
    private java.lang.String codDireccion;

    private java.lang.String ingresosBrutosAnuales;

    private java.lang.String nomEmpresa;

    private java.lang.String nombre;

    private java.lang.String numeroIdentificacion;

    private java.lang.String ocupacion;

    private java.lang.String primerApellido;

    private java.lang.String segundoApellido;

    private java.lang.String tipIdentificacion;

    public WsUsuarioInDTO() {
    }

    public WsUsuarioInDTO(
           java.lang.String codDireccion,
           java.lang.String ingresosBrutosAnuales,
           java.lang.String nomEmpresa,
           java.lang.String nombre,
           java.lang.String numeroIdentificacion,
           java.lang.String ocupacion,
           java.lang.String primerApellido,
           java.lang.String segundoApellido,
           java.lang.String tipIdentificacion) {
           this.codDireccion = codDireccion;
           this.ingresosBrutosAnuales = ingresosBrutosAnuales;
           this.nomEmpresa = nomEmpresa;
           this.nombre = nombre;
           this.numeroIdentificacion = numeroIdentificacion;
           this.ocupacion = ocupacion;
           this.primerApellido = primerApellido;
           this.segundoApellido = segundoApellido;
           this.tipIdentificacion = tipIdentificacion;
    }


    /**
     * Gets the codDireccion value for this WsUsuarioInDTO.
     * 
     * @return codDireccion
     */
    public java.lang.String getCodDireccion() {
        return codDireccion;
    }


    /**
     * Sets the codDireccion value for this WsUsuarioInDTO.
     * 
     * @param codDireccion
     */
    public void setCodDireccion(java.lang.String codDireccion) {
        this.codDireccion = codDireccion;
    }


    /**
     * Gets the ingresosBrutosAnuales value for this WsUsuarioInDTO.
     * 
     * @return ingresosBrutosAnuales
     */
    public java.lang.String getIngresosBrutosAnuales() {
        return ingresosBrutosAnuales;
    }


    /**
     * Sets the ingresosBrutosAnuales value for this WsUsuarioInDTO.
     * 
     * @param ingresosBrutosAnuales
     */
    public void setIngresosBrutosAnuales(java.lang.String ingresosBrutosAnuales) {
        this.ingresosBrutosAnuales = ingresosBrutosAnuales;
    }


    /**
     * Gets the nomEmpresa value for this WsUsuarioInDTO.
     * 
     * @return nomEmpresa
     */
    public java.lang.String getNomEmpresa() {
        return nomEmpresa;
    }


    /**
     * Sets the nomEmpresa value for this WsUsuarioInDTO.
     * 
     * @param nomEmpresa
     */
    public void setNomEmpresa(java.lang.String nomEmpresa) {
        this.nomEmpresa = nomEmpresa;
    }


    /**
     * Gets the nombre value for this WsUsuarioInDTO.
     * 
     * @return nombre
     */
    public java.lang.String getNombre() {
        return nombre;
    }


    /**
     * Sets the nombre value for this WsUsuarioInDTO.
     * 
     * @param nombre
     */
    public void setNombre(java.lang.String nombre) {
        this.nombre = nombre;
    }


    /**
     * Gets the numeroIdentificacion value for this WsUsuarioInDTO.
     * 
     * @return numeroIdentificacion
     */
    public java.lang.String getNumeroIdentificacion() {
        return numeroIdentificacion;
    }


    /**
     * Sets the numeroIdentificacion value for this WsUsuarioInDTO.
     * 
     * @param numeroIdentificacion
     */
    public void setNumeroIdentificacion(java.lang.String numeroIdentificacion) {
        this.numeroIdentificacion = numeroIdentificacion;
    }


    /**
     * Gets the ocupacion value for this WsUsuarioInDTO.
     * 
     * @return ocupacion
     */
    public java.lang.String getOcupacion() {
        return ocupacion;
    }


    /**
     * Sets the ocupacion value for this WsUsuarioInDTO.
     * 
     * @param ocupacion
     */
    public void setOcupacion(java.lang.String ocupacion) {
        this.ocupacion = ocupacion;
    }


    /**
     * Gets the primerApellido value for this WsUsuarioInDTO.
     * 
     * @return primerApellido
     */
    public java.lang.String getPrimerApellido() {
        return primerApellido;
    }


    /**
     * Sets the primerApellido value for this WsUsuarioInDTO.
     * 
     * @param primerApellido
     */
    public void setPrimerApellido(java.lang.String primerApellido) {
        this.primerApellido = primerApellido;
    }


    /**
     * Gets the segundoApellido value for this WsUsuarioInDTO.
     * 
     * @return segundoApellido
     */
    public java.lang.String getSegundoApellido() {
        return segundoApellido;
    }


    /**
     * Sets the segundoApellido value for this WsUsuarioInDTO.
     * 
     * @param segundoApellido
     */
    public void setSegundoApellido(java.lang.String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }


    /**
     * Gets the tipIdentificacion value for this WsUsuarioInDTO.
     * 
     * @return tipIdentificacion
     */
    public java.lang.String getTipIdentificacion() {
        return tipIdentificacion;
    }


    /**
     * Sets the tipIdentificacion value for this WsUsuarioInDTO.
     * 
     * @param tipIdentificacion
     */
    public void setTipIdentificacion(java.lang.String tipIdentificacion) {
        this.tipIdentificacion = tipIdentificacion;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof WsUsuarioInDTO)) return false;
        WsUsuarioInDTO other = (WsUsuarioInDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codDireccion==null && other.getCodDireccion()==null) || 
             (this.codDireccion!=null &&
              this.codDireccion.equals(other.getCodDireccion()))) &&
            ((this.ingresosBrutosAnuales==null && other.getIngresosBrutosAnuales()==null) || 
             (this.ingresosBrutosAnuales!=null &&
              this.ingresosBrutosAnuales.equals(other.getIngresosBrutosAnuales()))) &&
            ((this.nomEmpresa==null && other.getNomEmpresa()==null) || 
             (this.nomEmpresa!=null &&
              this.nomEmpresa.equals(other.getNomEmpresa()))) &&
            ((this.nombre==null && other.getNombre()==null) || 
             (this.nombre!=null &&
              this.nombre.equals(other.getNombre()))) &&
            ((this.numeroIdentificacion==null && other.getNumeroIdentificacion()==null) || 
             (this.numeroIdentificacion!=null &&
              this.numeroIdentificacion.equals(other.getNumeroIdentificacion()))) &&
            ((this.ocupacion==null && other.getOcupacion()==null) || 
             (this.ocupacion!=null &&
              this.ocupacion.equals(other.getOcupacion()))) &&
            ((this.primerApellido==null && other.getPrimerApellido()==null) || 
             (this.primerApellido!=null &&
              this.primerApellido.equals(other.getPrimerApellido()))) &&
            ((this.segundoApellido==null && other.getSegundoApellido()==null) || 
             (this.segundoApellido!=null &&
              this.segundoApellido.equals(other.getSegundoApellido()))) &&
            ((this.tipIdentificacion==null && other.getTipIdentificacion()==null) || 
             (this.tipIdentificacion!=null &&
              this.tipIdentificacion.equals(other.getTipIdentificacion())));
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
        if (getCodDireccion() != null) {
            _hashCode += getCodDireccion().hashCode();
        }
        if (getIngresosBrutosAnuales() != null) {
            _hashCode += getIngresosBrutosAnuales().hashCode();
        }
        if (getNomEmpresa() != null) {
            _hashCode += getNomEmpresa().hashCode();
        }
        if (getNombre() != null) {
            _hashCode += getNombre().hashCode();
        }
        if (getNumeroIdentificacion() != null) {
            _hashCode += getNumeroIdentificacion().hashCode();
        }
        if (getOcupacion() != null) {
            _hashCode += getOcupacion().hashCode();
        }
        if (getPrimerApellido() != null) {
            _hashCode += getPrimerApellido().hashCode();
        }
        if (getSegundoApellido() != null) {
            _hashCode += getSegundoApellido().hashCode();
        }
        if (getTipIdentificacion() != null) {
            _hashCode += getTipIdentificacion().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(WsUsuarioInDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "WsUsuarioInDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codDireccion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "CodDireccion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ingresosBrutosAnuales");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "IngresosBrutosAnuales"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nomEmpresa");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NomEmpresa"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombre");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Nombre"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIdentificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "NumeroIdentificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("ocupacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "Ocupacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("primerApellido");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "PrimerApellido"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("segundoApellido");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "SegundoApellido"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipIdentificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.commonapp.dto", "TipIdentificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
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
