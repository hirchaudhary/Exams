package com.hiral.belt.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hiral.belt.models.Pack;
import com.hiral.belt.repository.PackageRepository;

@Service
public class PackageService {
	private PackageRepository packageRepository;

	public PackageService(PackageRepository packageRepository) {
		this.packageRepository = packageRepository;
	}

	public void addPackage(Pack pack) {
		packageRepository.save(pack);
	}

	public List<Pack> findAll() {
		return (List<Pack>) packageRepository.findAll();
	}

	public Pack findOne(Long id) {
		return packageRepository.findOne(id);
	}

	public void update(Pack pack) {
		packageRepository.save(pack);
	}

	public void deleteById(Long id) {
		packageRepository.delete(id);
	}

}
