/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.model.Citas;
import java.util.List;

/**
 *
 * @author julia
 */
public interface CitaDAO {
    boolean insertar(Citas c);
    boolean actualizar(Citas c);
    Citas buscarPorId(int id);   
    List<Citas> listarTodas();
    List<Citas> listarPorPaciente(int idPaciente);
    List<Citas> listarPorMedico(int idMedico);
    boolean cambiarEstado(int idCita, String nuevoEstado);
    boolean eliminar(int idCita);
}
