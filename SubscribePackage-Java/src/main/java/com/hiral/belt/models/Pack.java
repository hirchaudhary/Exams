package com.hiral.belt.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "packages")
public class Pack {
	@Id
	@GeneratedValue
	private Long id;

	@Size(min = 1, message = "* Can't be empty")
	private String name;

	@NotNull
	private Double cost;

	private boolean availability;

	@OneToMany(mappedBy = "packages", fetch = FetchType.LAZY)
	private List<User> users;

	@DateTimeFormat(pattern = "MM:dd:yyyy HH:mm:ss")
	private Date createdAt;

	@DateTimeFormat(pattern = "MM:dd:yyyy HH:mm:ss")
	private Date updatedAt;

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

	public Pack(Long id, String name, Double cost, boolean availability, List<User> users) {
		super();
		this.id = id;
		this.name = name;
		this.cost = cost;
		this.availability = availability;
		this.users = users;
		this.createdAt = new Date();
		this.updatedAt = new Date();
	}

	public Pack() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getCost() {
		return cost;
	}

	public void setCost(Double cost) {
		this.cost = cost;
	}

	public boolean isAvailability() {
		return availability;
	}

	public void setAvailability(boolean availability) {
		this.availability = availability;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

}
