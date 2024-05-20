package org.brayantoyom.system;

import java.io.InputStream;
import javafx.application.Application;
import static javafx.application.Application.launch;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import org.brayantoyom.controller.ClienteVistaController;
import org.brayantoyom.controller.MenuPrincipalController;
import org.brayantoyom.controller.ProgramadorController;
import javafx.application.Application;
import javafx.stage.Stage;
import javafx.scene.Scene;
import org.brayantoyom.controller.CargoEmpleadoController;
import org.brayantoyom.controller.ProveedoresController;
import org.brayantoyom.controller.TipoProductoController;
import org.brayantoyom.controller.ComprasController;
import org.brayantoyom.controller.ProductoController;

public class Main extends Application {

    private Stage escenarioPrincipal;
    private Scene escena;
    private final String URLVIEW = "/org/brayantoyom/view/";

    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("SuperMarket");
        menuPrincipalView();
        escenarioPrincipal.show();
        FXMLLoader.load(getClass().getResource("/org/brayantoyom/view/ViewMenuPrincipal.fxml"));

    }

    public Initializable cambiarEscena(String fxmlname, int width, int height) throws Exception {
        Initializable resultado;
        FXMLLoader loader = new FXMLLoader();

        InputStream file = Main.class.getResourceAsStream(URLVIEW + fxmlname);
        loader.setBuilderFactory(new JavaFXBuilderFactory());
        loader.setLocation(Main.class.getResource(URLVIEW + fxmlname));

        escena = new Scene((AnchorPane) loader.load(file), width, height);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();

        resultado = (Initializable) loader.getController();

        return resultado;
    }

    public void menuPrincipalView() {
        try {
            MenuPrincipalController menuPrincipalView = (MenuPrincipalController) cambiarEscena("ViewMenuPrincipal.fxml", 828, 517);
            menuPrincipalView.setEscenarioPrincipal(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void menuClienteView() {
        try {
            ClienteVistaController menuClienteView = (ClienteVistaController) cambiarEscena("ViewClientes.fxml", 1138, 679);
            menuClienteView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void menuCargoEmpleadoView() {
        try {
            CargoEmpleadoController menuCargoEmpleadoView = (CargoEmpleadoController) cambiarEscena("ViewCargos.fxml", 893, 550);
            menuCargoEmpleadoView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    
        public void menuProducto() {
        try {
            ProductoController ProductoView = (ProductoController) cambiarEscena("ViewProductos.fxml", 924, 588);
            ProductoView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }


    public void menuTipoProductoView() {
        try {
            TipoProductoController menuTipoProductoView = (TipoProductoController) cambiarEscena("ViewTipoProducto.fxml", 706, 386);
            menuTipoProductoView.setEscenarioPrincipal(this);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void menuProgramadorView() {
        try {
            ProgramadorController programadorView = (ProgramadorController) cambiarEscena("ViewProgramador.fxml", 886, 464);
            programadorView.setEscenarioPrincipal(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    
        public void menuProveedoresView() {
        try {
            ProveedoresController menuProveedoresView = (ProveedoresController) cambiarEscena("ViewProveedores.fxml", 1036, 684);
            menuProveedoresView.setEscenarioPrincipal(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        
    }
        
        public void menuComprasView() {
        try {
            ComprasController menuComprasView = (ComprasController) cambiarEscena("ViewCompras.fxml", 977, 625);
            menuComprasView.setEscenarioPrincipal(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }    
    }
        
        
    public static void main(String[] args) {
        launch(args);
    }

}
