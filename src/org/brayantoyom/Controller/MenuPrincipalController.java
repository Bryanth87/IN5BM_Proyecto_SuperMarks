package org.brayantoyom.Controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.MenuItem;
import org.brayantoyom.system.Main;

public class MenuPrincipalController implements Initializable {

    private Main escenarioPrincipal;
    
    @FXML
    MenuItem btnMenuClientes;
    
    @FXML
    MenuItem btnProgramador;
    
    @FXML
    MenuItem btnCargos;
    
    @FXML
    MenuItem btnProductos;
    
    @FXML
    MenuItem btnCompras;

    @FXML
    MenuItem btnProveedores;
    
    @FXML 
    MenuItem btnProducto;

    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }

    public Main getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;

    }

    @FXML
    public void handleButtonAction(ActionEvent event) {
        if (event.getSource() == btnMenuClientes) {
            escenarioPrincipal.menuClienteView();

        } else if (event.getSource() == btnProgramador) {
            escenarioPrincipal.menuProgramadorView();
        } else if (event.getSource() == btnCargos) {
            escenarioPrincipal.menuCargoEmpleadoView();
        } else if (event.getSource() == btnProductos) {
            escenarioPrincipal.menuTipoProductoView();
        } else if (event.getSource() == btnCompras) {
            escenarioPrincipal.menuComprasView();
        } else if (event.getSource() == btnProveedores) {
            escenarioPrincipal.menuProveedoresView();
        } else if(event.getSource() == btnProducto){
            escenarioPrincipal.menuProducto();
        }
    }
}
