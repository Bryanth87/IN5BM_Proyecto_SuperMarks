package org.brayantoyom.Controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javax.swing.JOptionPane;
import org.brayantoyom.bean.CargoEmpleado;
import org.brayantoyom.db.Conexion;
import org.brayantoyom.system.Main;

public class CargoEmpleadoController implements Initializable {

    private int op;
    private ObservableList<CargoEmpleado> listaCargoEmpleado;
    private Main escenarioPrincipal;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, NINGUNO
    }

    private operaciones tipoDeOperaciones = operaciones.NINGUNO;
    @FXML
    private Button btnRegresar;
    @FXML
    private TextField txtCodigoCargoEmpleado;

    @FXML
    private TextField txtNombresCargo;

    @FXML
    private TextField txtDescripcionCargo;

    @FXML
    private TableView tblCargoEmpleado;

    @FXML
    private TableColumn colCodigoCargoEmpleado;

    @FXML
    private TableColumn colNombresCargo;

    @FXML
    private TableColumn colDescripcionCargo;

    @FXML
    private Button btnAgregarCargoEmpleado;

    @FXML
    private Button btnEliminarCargoEmpleado;

    @FXML
    private Button btnEditarCargoEmpleado;

    @FXML
    private Button btnReportes;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarDatos();

    }

    public void cargarDatos() {
        tblCargoEmpleado.setItems(getEmpleados());
        colCodigoCargoEmpleado.setCellValueFactory(new PropertyValueFactory<CargoEmpleado, Integer>("codigoCargoEmpleado"));
        colNombresCargo.setCellValueFactory(new PropertyValueFactory<CargoEmpleado, Integer>("nombresCargo"));
        colDescripcionCargo.setCellValueFactory(new PropertyValueFactory<CargoEmpleado, Integer>("descripcionCargo"));

    }

    public void seleccionarElementos() {
        txtCodigoCargoEmpleado.setText(String.valueOf(((CargoEmpleado) tblCargoEmpleado.getSelectionModel().getSelectedItem()).getCodigoCargoEmpleado()));
        txtNombresCargo.setText((((CargoEmpleado) tblCargoEmpleado.getSelectionModel().getSelectedItem()).getNombresCargo()));
        txtDescripcionCargo.setText((((CargoEmpleado) tblCargoEmpleado.getSelectionModel().getSelectedItem()).getDescripcionCargo()));
    }

    public ObservableList<CargoEmpleado> getEmpleados() {
        ArrayList<CargoEmpleado> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarCargoEmpleado()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new CargoEmpleado(resultado.getInt("codigoCargoEmpleado"),
                        resultado.getString("nombresCargo"),
                        resultado.getString("descripcionCargo")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaCargoEmpleado = FXCollections.observableList(lista);
    }

    public void Agregar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                activarControles();
                btnAgregarCargoEmpleado.setText("Guardar");
                btnEliminarCargoEmpleado.setText("Cancelar");
                btnEditarCargoEmpleado.setDisable(true);
                btnReportes.setDisable(true);
                tipoDeOperaciones = operaciones.ACTUALIZAR;
                break;
            case ACTUALIZAR:
                Guardar();
                desactivarControles();
                limpiarControles();
                cargarDatos();
                btnAgregarCargoEmpleado.setText("Agregar");
                btnEliminarCargoEmpleado.setText("Eliminar");
                btnEditarCargoEmpleado.setDisable(false);
                btnReportes.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
        }
    }

    public void Eliminar() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControles();
                limpiarControles();
                btnAgregarCargoEmpleado.setText("Agregar");
                btnEliminarCargoEmpleado.setText("Eliminar");
                btnEditarCargoEmpleado.setDisable(true);
                btnReportes.setDisable(true);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
            default:
                if (tblCargoEmpleado.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Confirmar la eliminacion de registro",
                            "Eliminar Empleados", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_NO_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_eliminarCargoEmpleado(?)}");
                            procedimiento.setInt(1, ((CargoEmpleado) tblCargoEmpleado.getSelectionModel().getSelectedItem()).getCodigoCargoEmpleado());
                            procedimiento.execute();
                            listaCargoEmpleado.remove(tblCargoEmpleado.getSelectionModel().getSelectedItem());
                            limpiarControles();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Debe de seleccionar un Empleado para eliminar");
                }
        }
    }

    public void Editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblCargoEmpleado.getSelectionModel().getSelectedItem() != null) {
                    btnEditarCargoEmpleado.setText("Actualizar");
                    btnReportes.setText("Cancelar");
                    btnAgregarCargoEmpleado.setDisable(true);
                    btnEliminarCargoEmpleado.setDisable(true);
                    activarControles();
                    txtCodigoCargoEmpleado.setEditable(false);
                    tipoDeOperaciones = operaciones.ACTUALIZAR;
                } else {
                    JOptionPane.showConfirmDialog(null, "Debe de seleccionar un Empleado para editar");
                }
                break;
            case ACTUALIZAR:
                Actualizar();
                btnEditarCargoEmpleado.setText("Editar");
                btnReportes.setText("Reporte");
                btnAgregarCargoEmpleado.setDisable(false);
                btnEliminarCargoEmpleado.setDisable(false);
                desactivarControles();
                limpiarControles();
                tipoDeOperaciones = operaciones.NINGUNO;
                cargarDatos();
                break;
        }
    }

    public void Reporte() {
        switch (tipoDeOperaciones) {
            case ACTUALIZAR:
                desactivarControles();
                limpiarControles();
                btnReportes.setText("Reporte");
                btnEditarCargoEmpleado.setText("Editar");
                btnAgregarCargoEmpleado.setDisable(false);
                btnEliminarCargoEmpleado.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
            case NINGUNO:
                break;
        }
    }

    public void Guardar() {
        CargoEmpleado registro = new CargoEmpleado();
        registro.setCodigoCargoEmpleado(Integer.parseInt(txtCodigoCargoEmpleado.getText()));
        registro.setNombresCargo(txtNombresCargo.getText());
        registro.setDescripcionCargo(txtDescripcionCargo.getText());
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_agregarCargoEmpleado(?, ?, ?)}");
            procedimiento.setInt(1, registro.getCodigoCargoEmpleado());
            procedimiento.setString(2, registro.getNombresCargo());
            procedimiento.setString(3, registro.getDescripcionCargo());
            procedimiento.execute();
            listaCargoEmpleado.add(registro);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void Actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_actualizarCargoEmpleado(?,?,?)}");
            CargoEmpleado registro = (CargoEmpleado) tblCargoEmpleado.getSelectionModel().getSelectedItem();
            registro.setNombresCargo(txtNombresCargo.getText());
            registro.setDescripcionCargo(txtDescripcionCargo.getText());
            procedimiento.setInt(1, registro.getCodigoCargoEmpleado());
            procedimiento.setString(2, registro.getNombresCargo());
            procedimiento.setString(3, registro.getDescripcionCargo());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void desactivarControles() {
        txtCodigoCargoEmpleado.setEditable(false);
        txtNombresCargo.setEditable(false);
        txtDescripcionCargo.setEditable(false);
    }

    public void activarControles() {
        txtCodigoCargoEmpleado.setEditable(true);
        txtNombresCargo.setEditable(true);
        txtDescripcionCargo.setEditable(true);
    }

    public void limpiarControles() {
        txtCodigoCargoEmpleado.clear();
        txtNombresCargo.clear();
        txtDescripcionCargo.clear();
    }

    public Main getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Main escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }

    @FXML
    public void handleButtonAction(ActionEvent event) {
        if (event.getSource() == btnRegresar) {
            escenarioPrincipal.menuPrincipalView();
        }
    }
}
