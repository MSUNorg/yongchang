/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.yongchang.b2b.cons.EnumCollections;
import com.yongchang.b2b.cons.EnumCollections.Level;

/**
 * @author zxc Apr 28, 2016 12:05:36 PM
 */
@Entity
@Table(name = "user")
public class User extends IdEntity {

    private Date    createTime = new Date();
    private Date    updateTime = new Date();
    private Date    lastLoginTime;
    private String  name;
    private String  passwd;
    private String  realname;
    private String  phone;
    private String  email;
    private Integer state      = 0;         // 状态: 0=未审核,1=正常,2=停止
    private Integer type;                   // 0=admin管理员,1=buyer采购商,2=supplier供应商
    private Integer level;                  // 资质级别(A=1,B=2,C=3,D=4)
    private String  avatar;

    private String  company;
    private String  province;
    private String  city;
    private String  county;
    private String  address;
    private String  logo;
    private String  qq;
    private String  mobile;
    private String  aboutus;

    private Long    roleId;
    private Role    role;

    public User() {

    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "roleId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public User(String name, String passwd) {
        this.name = name;
        this.passwd = passwd;
    }

    public User(String name, String phone, String passwd) {
        this.name = name;
        this.phone = phone;
        this.passwd = passwd;
    }

    public User(String name, String phone, String passwd, String type) {
        this.name = name;
        this.phone = phone;
        this.passwd = passwd;
        this.type = EnumCollections.UserType.get(type).getValue();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getType() {
        return type;
    }

    @Transient
    public String getTypeStr() {
        return EnumCollections.UserType.get(type).getEn();
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getLevel() {
        return level;
    }

    @Transient
    public String getLevelStr() {
        return Level.get(level).getName();
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAboutus() {
        return aboutus;
    }

    public void setAboutus(String aboutus) {
        this.aboutus = aboutus;
    }
}
