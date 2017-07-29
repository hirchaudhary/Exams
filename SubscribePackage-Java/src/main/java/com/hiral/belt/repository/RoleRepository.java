package com.hiral.belt.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.hiral.belt.models.Role;

@Repository
public interface RoleRepository extends CrudRepository<Role, Long> {

	Role findByName(String name);

}
