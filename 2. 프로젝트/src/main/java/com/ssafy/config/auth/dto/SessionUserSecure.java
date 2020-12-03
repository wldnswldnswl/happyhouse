package com.ssafy.config.auth.dto;

import java.io.Serializable;

import com.ssafy.domain.user.UserSecure;

import lombok.Getter;

@Getter
public class SessionUserSecure implements Serializable{
	
	private String name;
    private String email;
    private String picture;

    public SessionUserSecure(UserSecure user) {
        this.name = user.getName();
        this.email = user.getEmail();
        this.picture = user.getPicture();
    }

}
