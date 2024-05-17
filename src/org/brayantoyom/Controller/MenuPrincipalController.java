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
        }if (event.getSource() == btnProgramador) {
            escenarioPrincipal.menuProgramadorView();
        }if (event.getSource() == btnCargos) {
            escenarioPrincipal.menuCargoEmpleadoView();
        }if (event.getSource() == btnProductos) {
            escenarioPrincipal.menuTipoProductoView();
        }if (event.getSource() == btnCompras) {
            escenarioPrincipal.menuCompras();
        }
    }
}
