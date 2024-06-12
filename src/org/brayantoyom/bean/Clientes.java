
package org.brayantoyom.bean;

public class Clientes {
    private int codigoCliente;
    private String nombresClientes;
    private String apellidosCliente;
    private String NITCliente;
    private String telefonoCliente;
    private String direccionCliente;
    private String correoCliente;


    public Clientes() {
    }

    public Clientes(int codigoCliente, String nombresClientes, String apellidosCliente, String NITCliente, String telefonoCliente, String direccionCliente, String correoCliente) {
        this.codigoCliente = codigoCliente;
        this.nombresClientes = nombresClientes;
        this.apellidosCliente = apellidosCliente;
        this.NITCliente = NITCliente;
        this.telefonoCliente = telefonoCliente;
        this.direccionCliente = direccionCliente;
        this.correoCliente = correoCliente;
    }

    public int getCodigoCliente() {
        return codigoCliente;
    }

    public void setCodigoCliente(int codigoCliente) {
        this.codigoCliente = codigoCliente;
    }

    public String getNombresClientes() {
        return nombresClientes;
    }

    public void setNombresClientes(String nombresClientes) {
        this.nombresClientes = nombresClientes;
    }

    public String getApellidosCliente() {
        return apellidosCliente;
    }

    public void setApellidosCliente(String apellidosCliente) {
        this.apellidosCliente = apellidosCliente;
    }

    public String getNITCliente() {
        return NITCliente;
    }

    public void setNITCliente(String NITCliente) {
        this.NITCliente = NITCliente;
    }

    public String getTelefonoCliente() {
        return telefonoCliente;
    }

    public void setTelefonoCliente(String telefonoCliente) {
        this.telefonoCliente = telefonoCliente;
    }

    public String getDireccionCliente() {
        return direccionCliente;
    }

    public void setDireccionCliente(String direccionCliente) {
        this.direccionCliente = direccionCliente;
    }

    public String getCorreoCliente() {
        return correoCliente;
    }

    public void setCorreoCliente(String correoCliente) {
        this.correoCliente = correoCliente;
    }

}