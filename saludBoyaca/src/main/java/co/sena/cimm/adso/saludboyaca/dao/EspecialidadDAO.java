/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.sena.cimm.adso.saludboyaca.dao;

import co.sena.cimm.adso.saludboyaca.model.Especialidades;
import java.util.List;

/**
 *
 * @author julia
 */
public interface EspecialidadDAO {
    List<Especialidades> listarTodas();
    Especialidades buscarPorId(int id);
}
