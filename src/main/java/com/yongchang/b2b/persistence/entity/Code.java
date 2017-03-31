/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author zxc Jun 15, 2016 4:44:36 PM
 */
@Entity
@Table(name = "code")
public class Code extends IdEntity {

    private Date   createTime = new Date();
    private Date   lostTime;
    private String code;                   // 认证码
    private int    type;                   // 认证码类型(1=供应商,2采购商)
    private int    state;                  // 状态: 0=正常,未使用,1=已使用,2=过期
    private int    level;                  // 资质级别(A=1,B=2,C=3,D=4)

    public Date getCreateTime() {
        return createTime;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getLostTime() {
        return lostTime;
    }

    public void setLostTime(Date lostTime) {
        this.lostTime = lostTime;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}
