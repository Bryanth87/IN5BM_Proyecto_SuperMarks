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
import org.brayantoyom.bean.Compras;
import org.brayantoyom.db.Conexion;
import org.brayantoyom.system.Main;

public class ComprasController implements Initializable {

    private Main escenarioPrincipal;

    private enum operaciones {
        AGREGAR, ELIMINAR, EDITAR, ACTUALIZAR, CANCELAR, REPORTE, NINGUNO
    }
    private operaciones tipoDeOperaciones = operaciones.NINGUNO;
    private ObservableList<Compras> listaCompras;

    @FXML
    private TableView tblCompras;

    @FXML
    private TableColumn colNumbDocumentoCompras;

    @FXML
    private TableColumn colFechaDocumentoCompras;

    @FXML
    private TableColumn colDescripcioCompras;

    @FXML
    private TableColumn colTotalDocumentoCompras;

    @FXML
    private Button btnAgregar;

    @FXML
    private Button btnEliminar;

    @FXML
    private Button btnEditar;

    @FXML
    private Button btnReportes;

    @FXML
    private Button btnRegresar;

    @FXML
    private TextField txtNumDocumentoCompras;

    @FXML
    private TextField txtFechaDocumentoCompras;

    @FXML
    private TextField txtDescripcionCompras;

    @FXML
    private TextField txtTotalDocumentoCompras;

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        cargarDatos();
    }

    public void cargarDatos() {
        tblCompras.setItems(getCompras());
        colNumbDocumentoCompras.setCellValueFactory(new PropertyValueFactory<Compras, Integer>("numDocumento"));
        colFechaDocumentoCompras.setCellValueFactory(new PropertyValueFactory<Compras, Integer>("fechaDocumento"));
        colDescripcioCompras.setCellValueFactory(new PropertyValueFactory<Compras, Integer>("descripcion"));
        colTotalDocumentoCompras.setCellValueFactory(new PropertyValueFactory<Compras, Integer>("totalDocumento"));

    }

    public void seleccionarElementos() {

        txtNumDocumentoCompras.setText(String.valueOf(((Compras) tblCompras.getSelectionModel().getSelectedItem()).getNumDocumento()));
        txtFechaDocumentoCompras.setText(String.valueOf(((Compras) tblCompras.getSelectionModel().getSelectedItem()).getFechaDocumento()));
        txtDescripcionCompras.setText(String.valueOf(((Compras) tblCompras.getSelectionModel().getSelectedItem()).getDescripcion()));
        txtTotalDocumentoCompras.setText(String.valueOf(((Compras) tblCompras.getSelectionModel().getSelectedItem()).getTotalDocumento()));

    }

    public ObservableList<Compras> getCompras() {
        ArrayList<Compras> lista = new ArrayList<>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_listarCompras()}");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {
                lista.add(new Compras(resultado.getInt("numDocumento"),
                        resultado.getString("fechaDocumento"),
                        resultado.getString("descripcion"),
                        resultado.getDouble("totalDocumento")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaCompras = FXCollections.observableList(lista);
    }

    public void Agregar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                activarControles();
                btnAgregar.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReportes.setDisable(true);
                tipoDeOperaciones = operaciones.ACTUALIZAR;
                break;
            case ACTUALIZAR:
                Guardar();
                desactivarControles();
                limpiarControles();
                cargarDatos();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
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
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(true);
                btnReportes.setDisable(true);
                tipoDeOperaciones = operaciones.NINGUNO;
                break;
            default:
                if (tblCompras.getSelectionModel().getSelectedItem() != null) {
                    int respuesta = JOptionPane.showConfirmDialog(null, "Confirmar la eliminacion de registro",
                            "Eliminar Compras", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
                    if (respuesta == JOptionPane.YES_NO_OPTION) {
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_eliminarCompra(?)}");
                            procedimiento.setInt(1, ((Compras) tblCompras.getSelectionModel().getSelectedItem()).getNumDocumento());
                            procedimiento.execute();
                            listaCompras.remove(tblCompras.getSelectionModel().getSelectedItem());
                            limpiarControles();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Seleccione compra para eliminar");
                }
        }
    }

    public void Editar() {
        switch (tipoDeOperaciones) {
            case NINGUNO:
                if (tblCompras.getSelectionModel().getSelectedItem() != null) {
                    btnEditar.setText("Actualizar");
                    btnReportes.setText("Cancelar");
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    activarControles();
                    txtNumDocumentoCompras.setEditable(false);
                    tipoDeOperaciones = operaciones.ACTUALIZAR;
                } else {
                    JOptionPane.showConfirmDialog(null, "Debe de seleccionar una compra para editar");
                }
                break;
            case ACTUALIZAR:
                Actualizar();
                btnEditar.setText("Editar");
                btnReportes.setText("Reporte");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
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
                btnEditar.setText("Editar");
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                tipoDeOperaciones = operaciones.NINGUNO;
            case NINGUNO:
                break;
        }
    }

    public void Guardar() {
        Compras registro = new Compras();
        registro.setNumDocumento(Integer.parseInt(txtNumDocumentoCompras.getText()));
        registro.setFechaDocumento(txtFechaDocumentoCompras.getText());
        registro.setDescripcion(txtDescripcionCompras.getText());
        registro.setTotalDocumento(Double.parseDouble(txtTotalDocumentoCompras.getText()));
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_agregarCompra(?, ?, ?, ?)}");
            procedimiento.setInt(1, registro.getNumDocumento());
            procedimiento.setString(2, registro.getFechaDocumento());
            procedimiento.setString(3, registro.getDescripcion());
            procedimiento.setDouble(4, registro.getTotalDocumento());
            procedimiento.execute();
            listaCompras.add(registro);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void Actualizar() {
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("{call sp_actualizarCompra(?,?,?,?)}");
            Compras registro = (Compras) tblCompras.getSelectionModel().getSelectedItem();
            registro.setFechaDocumento(txtFechaDocumentoCompras.getText());
            registro.setDescripcion(txtDescripcionCompras.getText());
            registro.setTotalDocumento(Double.parseDouble(txtTotalDocumentoCompras.getText()));
            procedimiento.setInt(1, registro.getNumDocumento());
            procedimiento.setString(2, registro.getFechaDocumento());
            procedimiento.setString(3, registro.getDescripcion());
            procedimiento.setDouble(4, registro.getTotalDocumento());
            procedimiento.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void desactivarControles() {
        txtNumDocumentoCompras.setEditable(false);
        txtFechaDocumentoCompras.setEditable(false);
        txtDescripcionCompras.setEditable(false);
        txtTotalDocumentoCompras.setEditable(false);
        
    }

    public void activarControles() {
        txtNumDocumentoCompras.setEditable(true);
        txtFechaDocumentoCompras.setEditable(true);
        txtDescripcionCompras.setEditable(true);
        txtTotalDocumentoCompras.setEditable(true);
    }

    public void limpiarControles() {
        txtNumDocumentoCompras.clear();
        txtFechaDocumentoCompras.clear(); 
        txtDescripcionCompras.clear();
        txtTotalDocumentoCompras.clear();
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
