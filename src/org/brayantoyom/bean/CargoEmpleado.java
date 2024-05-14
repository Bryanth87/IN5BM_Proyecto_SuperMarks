
package org.brayantoyom.bean;

public class CargoEmpleado {
    private int codigoCargoEmpleado;
    private String nombresCargo;
    private String descripcionCargo;

    public CargoEmpleado() {
        
    }

    public CargoEmpleado(int codigoCargoEmpleado, String nombresCargo, String descripcionCargo) {
        this.codigoCargoEmpleado = codigoCargoEmpleado;
        this.nombresCargo = nombresCargo;
        this.descripcionCargo = descripcionCargo;

    }

    public int getCodigoCargoEmpleado() {
        return codigoCargoEmpleado;
    }

    public void setCodigoCargoEmpleado(int codigoCargoEmpleado) {
        this.codigoCargoEmpleado = codigoCargoEmpleado;
    }

    public String getNombresCargo() {
        return nombresCargo;
    }

    public void setNombresCargo(String nombresCargo) {
        this.nombresCargo = nombresCargo;
    }

    public String getDescripcionCargo() {
        return descripcionCargo;
    }

    public void setDescripcionCargo(String descripcionCargo) {
        this.descripcionCargo = descripcionCargo;
    }
    
}

