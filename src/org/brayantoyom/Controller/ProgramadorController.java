
package org.brayantoyom.Controller;
 
import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import org.brayantoyom.system.Main;
 

public class ProgramadorController implements Initializable {
   private Main escenarioPrincipal;
    @FXML private Button btnRegresar;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
 
    }
 
    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
 
    
    @FXML
  public void handleButtonAction (ActionEvent event){
        if (event.getSource() == btnRegresar){
        escenarioPrincipal.menuPrincipalView();
        }
    } 
}