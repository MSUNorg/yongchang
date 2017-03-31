/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.User;

/**
 * @author zxc Jun 6, 2016 2:06:18 PM
 */
public interface UserDao extends PagingAndSortingRepository<User, Long>, JpaSpecificationExecutor<User> {

    User findByName(String name);

    User findByPhone(String phone);

    User findByEmail(String email);

    User findByNameAndPasswd(String name, String passwd);
    
    Page<User> findAllByType(Integer type, Pageable pageRequest);

    List<User> findAllByType(Integer type);
}
