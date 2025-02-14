/**
 * MigracionPrepagoPostpagoDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package transport.serviciospostventasiga.scl.tmmas.com;

public class MigracionPrepagoPostpagoDTO  implements java.io.Serializable {
    private java.lang.String codError;

    private java.lang.String desError;

    private java.lang.Long numAbonado;

    private java.lang.Integer numEvento;

    private java.lang.String numOOSS;

    private java.lang.Long numVenta;

    public MigracionPrepagoPostpagoDTO() {
    }

    public MigracionPrepagoPostpagoDTO(
           java.lang.String codError,
           java.lang.String desError,
           java.lang.Long numAbonado,
           java.lang.Integer numEvento,
           java.lang.String numOOSS,
           java.lang.Long numVenta) {
           this.codError = codError;
           this.desError = desError;
           this.numAbonado = numAbonado;
           this.numEvento = numEvento;
           this.numOOSS = numOOSS;
           this.numVenta = numVenta;
    }


    /**
     * Gets the codError value for this MigracionPrepagoPostpagoDTO.
     * 
     * @return codError
     */
    public java.lang.String getCodError() {
        return codError;
    }


    /**
     * Sets the codError value for this MigracionPrepagoPostpagoDTO.
     * 
     * @param codError
     */
    public void setCodError(java.lang.String codError) {
        this.codError = codError;
    }


    /**
     * Gets the desError value for this MigracionPrepagoPostpagoDTO.
     * 
     * @return desError
     */
    public java.lang.String getDesError() {
        return desError;
    }


    /**
     * Sets the desError value for this MigracionPrepagoPostpagoDTO.
     * 
     * @param desError
     */
    public void setDesError(java.lang.String desError) {
        this.desError = desError;
    }


    /**
     * Gets the numAbonado value for this MigracionPrepagoPostpagoDTO.
     * 
     * @return numAbonado
     */
    public java.lang.Long getNumAbonado() {
        return numAbonado;
    }


    /**
     * Sets the numAbonado value for this MigracionPrepagoPostpagoDTO.
     * 
     * @param numAbonado
     */
    public void setNumAbonado(java.lang.Long numAbonado) {
        this.numAbonado = numAbonado;
    }


    /**
     * Gets the numEvento value for this MigracionPrepagoPostpagoDTO.
     * 
     * @return numEvento
     */
    public java.lang.Integer getNumEvento() {
        return numEvento;
    }


    /**
     * Sets the numEvento value for this MigracionPrepagoPostpagoDTO.
     * 
     * @param numEvento
     */
    public void setNumEvento(java.lang.Integer numEvento) {
        this.numEvento = numEvento;
    }


    /**
     * Gets the numOOSS value for this MigracionPrepagoPostpagoDTO.
     * 
     * @return numOOSS
     */
    public java.lang.String getNumOOSS() {
        return numOOSS;
    }


    /**
     * Sets the numOOSS value for this MigracionPrepagoPostpagoDTO.
     * 
     * @param numOOSS
     */
    public void setNumOOSS(java.lang.String numOOSS) {
        this.numOOSS = numOOSS;
    }


    /**
     * Gets the numVenta value for this MigracionPrepagoPostpagoDTO.
     * 
     * @return numVenta
     */
    public java.lang.Long getNumVenta() {
        return numVenta;
    }


    /**
     * Sets the numVenta value for this MigracionPrepagoPostpagoDTO.
     * 
     * @param numVenta
     */
    public void setNumVenta(java.lang.Long numVenta) {
        this.numVenta = numVenta;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof MigracionPrepagoPostpagoDTO)) return false;
        MigracionPrepagoPostpagoDTO other = (MigracionPrepagoPostpagoDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.codError==null && other.getCodError()==null) || 
             (this.codError!=null &&
              this.codError.equals(other.getCodError()))) &&
            ((this.desError==null && other.getDesError()==null) || 
             (this.desError!=null &&
              this.desError.equals(other.getDesError()))) &&
            ((this.numAbonado==null && other.getNumAbonado()==null) || 
             (this.numAbonado!=null &&
              this.numAbonado.equals(other.getNumAbonado()))) &&
            ((this.numEvento==null && other.getNumEvento()==null) || 
             (this.numEvento!=null &&
              this.numEvento.equals(other.getNumEvento()))) &&
            ((this.numOOSS==null && other.getNumOOSS()==null) || 
             (this.numOOSS!=null &&
              this.numOOSS.equals(other.getNumOOSS()))) &&
            ((this.numVenta==null && other.getNumVenta()==null) || 
             (this.numVenta!=null &&
              this.numVenta.equals(other.getNumVenta())));
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
        if (getCodError() != null) {
            _hashCode += getCodError().hashCode();
        }
        if (getDesError() != null) {
            _hashCode += getDesError().hashCode();
        }
        if (getNumAbonado() != null) {
            _hashCode += getNumAbonado().hashCode();
        }
        if (getNumEvento() != null) {
            _hashCode += getNumEvento().hashCode();
        }
        if (getNumOOSS() != null) {
            _hashCode += getNumOOSS().hashCode();
        }
        if (getNumVenta() != null) {
            _hashCode += getNumVenta().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(MigracionPrepagoPostpagoDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "MigracionPrepagoPostpagoDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "CodError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("desError");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "DesError"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numAbonado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "NumAbonado"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numEvento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "NumEvento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numOOSS");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "NumOOSS"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.scl.serviciospostventasiga.transport", "NumVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
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
