package com.hiral.belt.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.hiral.belt.models.Pack;

@Repository
public interface PackageRepository extends CrudRepository<Pack, Long> {

}
