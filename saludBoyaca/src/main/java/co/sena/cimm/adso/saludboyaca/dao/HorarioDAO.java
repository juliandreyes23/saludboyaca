/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.model.Horarios;
import java.util.List;

/**
 *
 * @author julia
 */
public interface HorarioDAO {
    List<Horarios> listarPorMedico (int idMedico);
    List <Horarios> listarTodos ();
    List<String> obtenerHorasDisponibles (int idMedico, String fecha);
}
