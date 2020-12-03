package com.ssafy.domain.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.ssafy.domain.BaseTimeEntity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor
public class UserSecure extends BaseTimeEntity{
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	@Column(nullable = false)
	private String name;
	
	@Column(nullable = false)
	private String email;
	
	@Column
	private String picture;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private Role role;

	@Builder
	public UserSecure(long id, String name, String email, String picture, Role role) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.picture = picture;
		this.role = role;
	}
	
	public UserSecure update(String name,String picture)
	{
		this.name=name;
		this.picture=picture;
		return this;
	}
	
	public String getRoleKey()
	{
		return this.role.getKey();
	}
	
	

}