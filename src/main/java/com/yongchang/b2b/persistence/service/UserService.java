/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yongchang.b2b.cons.EnumCollections.CodeState;
import com.yongchang.b2b.cons.EnumCollections.UserType;
import com.yongchang.b2b.persistence.dao.*;
import com.yongchang.b2b.persistence.entity.*;

/**
 * @author zxc Jun 6, 2016 2:07:27 PM
 */
@Service
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private CodeDao codeDao;

    public User getUser(String name) {
        if (StringUtils.isEmpty(name)) return null;
        return userDao.findByName(name);
    }

    public User getUserByEmail(String email) {
        if (StringUtils.isEmpty(email)) return null;
        return userDao.findByEmail(email);
    }

    public User getUserByPhone(String phone) {
        if (StringUtils.isEmpty(phone)) return null;
        return userDao.findByPhone(phone);
    }

    public User getUser(String name, String passwd) {
        // password = Util.entryptPassword(password);
        return userDao.findByNameAndPasswd(name, passwd);
    }

    public void save(User user) {
        userDao.save(user);
    }

    public User getUser(Long id) {
        return userDao.findOne(id);
    }

    public void delUser(Long id) {
        if (id == null) return;
        userDao.delete(id);
    }

    public Page<User> listUserByType(UserType type, int page, int size) {
        return userDao.findAllByType(type.getValue(), pageRequest(page, size, null));
    }

    public List<User> listUserByType(UserType type) {
        return userDao.findAllByType(type.getValue());
    }

    // *************************************************************//
    public void delRole(Long id) {
        if (id == null) return;
        roleDao.delete(id);
    }

    public Role getRole(Long id) {
        if (id == null) return null;
        return roleDao.findOne(id);
    }

    public List<Role> listRole() {
        return Lists.newArrayList(roleDao.findAll());
    }

    public void save(Role role) {
        roleDao.save(role);
    }

    // *************************************************************//
    public void delCode(Long id) {
        if (id == null) return;
        codeDao.delete(id);
    }

    public Code getCode(Long id) {
        if (id == null) return null;
        return codeDao.findOne(id);
    }

    public Code getCode(String code) {
        if (StringUtils.isEmpty(code)) return null;
        return codeDao.findByCode(code);
    }

    public Code getCode(String code, UserType type) {
        if (StringUtils.isEmpty(code)) return null;
        return codeDao.findByCodeAndStateAndType(code, CodeState.NORMAL.getValue(), type.getValue());
    }

    public Page<Code> listCode(int page, int size) {
        return codeDao.findAll(pageRequest(page, size, null));
    }

    public Page<Code> listCodeByState(CodeState codeState, int page, int size) {
        return codeDao.findAllByState(codeState.getValue(), pageRequest(page, size, null));
    }

    public void save(Code code) {
        codeDao.save(code);
    }

    // 创建分页请求
    private PageRequest pageRequest(int pageNumber, int pageSize, String sortType) {
        Sort sort = new Sort(Direction.DESC, "id");
        if (StringUtils.equalsIgnoreCase("auto", sortType)) {
            sort = new Sort(Direction.DESC, "id");
        } else if (StringUtils.equalsIgnoreCase("update_time", sortType)) {
            sort = new Sort(Direction.DESC, "update_time");
        }
        return new PageRequest(pageNumber - 1, pageSize, sort);
    }
}
