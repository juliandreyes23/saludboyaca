/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.model.Pacientes;
import java.util.List;

/**
 *
 * @author julia
 */
public interface PacienteDAO {
    
    boolean insertar(Pacientes p);
    boolean actualizar(Pacientes p);
    boolean eliminar(int id);
    Pacientes buscarPorDocumento(String documento);
    Pacientes buscarPorId(int id);
    List<Pacientes> listarTodos();
    List<String> listarEps();
    
    
    
}
