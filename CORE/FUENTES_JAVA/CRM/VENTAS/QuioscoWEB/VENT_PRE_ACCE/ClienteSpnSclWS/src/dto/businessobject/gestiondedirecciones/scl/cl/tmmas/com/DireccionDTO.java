/**
 * DireccionDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com;

public class DireccionDTO  implements java.io.Serializable {
    private long codigoDirecion;

    private java.lang.String codigoOperadora;

    private dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ConceptoDireccionDTO[] conceptoDireccionDTOs;

    private java.lang.Integer formato;

    private java.lang.Integer tipo;

    public DireccionDTO() {
    }

    public DireccionDTO(
           long codigoDirecion,
           java.lang.String codigoOperadora,
           dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ConceptoDireccionDTO[] conceptoDireccionDTOs,
           java.lang.Integer formato,
           java.lang.Integer tipo) {
           this.codigoDirecion = codigoDirecion;
           this.codigoOperadora = codigoOperadora;
           this.conceptoDireccionDTOs = conceptoDireccionDTOs;
           this.formato = formato;
           this.tipo = tipo;
    }


    /**
     * Gets the codigoDirecion value for this DireccionDTO.
     * 
     * @return codigoDirecion
     */
    public long getCodigoDirecion() {
        return codigoDirecion;
    }


    /**
     * Sets the codigoDirecion value for this DireccionDTO.
     * 
     * @param codigoDirecion
     */
    public void setCodigoDirecion(long codigoDirecion) {
        this.codigoDirecion = codigoDirecion;
    }


    /**
     * Gets the codigoOperadora value for this DireccionDTO.
     * 
     * @return codigoOperadora
     */
    public java.lang.String getCodigoOperadora() {
        return codigoOperadora;
    }


    /**
     * Sets the codigoOperadora value for this DireccionDTO.
     * 
     * @param codigoOperadora
     */
    public void setCodigoOperadora(java.lang.String codigoOperadora) {
        this.codigoOperadora = codigoOperadora;
    }


    /**
     * Gets the conceptoDireccionDTOs value for this DireccionDTO.
     * 
     * @return conceptoDireccionDTOs
     */
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ConceptoDireccionDTO[] getConceptoDireccionDTOs() {
        return conceptoDireccionDTOs;
    }


    /**
     * Sets the conceptoDireccionDTOs value for this DireccionDTO.
     * 
     * @param conceptoDireccionDTOs
     */
    public void setConceptoDireccionDTOs(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ConceptoDireccionDTO[] conceptoDireccionDTOs) {
        this.conceptoDireccionDTOs = conceptoDireccionDTOs;
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ConceptoDireccionDTO getConceptoDireccionDTOs(int i) {
        return this.conceptoDireccionDTOs[i];
    }

    public void setConceptoDireccionDTOs(int i, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.ConceptoDireccionDTO _value) {
        this.conceptoDireccionDTOs[i] = _value;
    }


    /**
     * Gets the formato value for this DireccionDTO.
     * 
     * @return formato
     */
    public java.lang.Integer getFormato() {
        return formato;
    }


    /**
     * Sets the formato value for this DireccionDTO.
     * 
     * @param formato
     */
    public void setFormato(java.lang.Integer formato) {
        this.formato = formato;
    }


    /**
     * Gets the tipo value for this DireccionDTO.
     * 
     * @return tipo
     */
    public java.lang.Integer getTipo() {
        return tipo;
    }


    /**
     * Sets the tipo value for this DireccionDTO.
     * 
     * @param tipo
     */
    public void setTipo(java.lang.Integer tipo) {
        this.tipo = tipo;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof DireccionDTO)) return false;
        DireccionDTO other = (DireccionDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.codigoDirecion == other.getCodigoDirecion() &&
            ((this.codigoOperadora==null && other.getCodigoOperadora()==null) || 
             (this.codigoOperadora!=null &&
              this.codigoOperadora.equals(other.getCodigoOperadora()))) &&
            ((this.conceptoDireccionDTOs==null && other.getConceptoDireccionDTOs()==null) || 
             (this.conceptoDireccionDTOs!=null &&
              java.util.Arrays.equals(this.conceptoDireccionDTOs, other.getConceptoDireccionDTOs()))) &&
            ((this.formato==null && other.getFormato()==null) || 
             (this.formato!=null &&
              this.formato.equals(other.getFormato()))) &&
            ((this.tipo==null && other.getTipo()==null) || 
             (this.tipo!=null &&
              this.tipo.equals(other.getTipo())));
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
        _hashCode += new Long(getCodigoDirecion()).hashCode();
        if (getCodigoOperadora() != null) {
            _hashCode += getCodigoOperadora().hashCode();
        }
        if (getConceptoDireccionDTOs() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getConceptoDireccionDTOs());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getConceptoDireccionDTOs(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getFormato() != null) {
            _hashCode += getFormato().hashCode();
        }
        if (getTipo() != null) {
            _hashCode += getTipo().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(DireccionDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DireccionDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoDirecion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoDirecion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoOperadora");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "CodigoOperadora"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("conceptoDireccionDTOs");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ConceptoDireccionDTOs"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "ConceptoDireccionDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("formato");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "Formato"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "Tipo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
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
