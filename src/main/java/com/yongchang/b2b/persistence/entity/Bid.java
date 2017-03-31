/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * @author zxc Jul 29, 2016 3:52:23 PM
 */
@Entity
@Table(name = "bid")
public class Bid extends IdEntity {

    private Date    createTime = new Date();
    private int     state;                  // 状态: 0=未审核,1=审核通过,2=审核不通过

    private Float   bidCount   = 0f;        // 供应重量
    private Float   bidPrice   = 0f;        // 竞标的价格
    private Long    requireId;              // 平台需求id
    private Long    userId;                 // 竞标者id
    private Require require;
    private User    user;

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "requireId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public Require getRequire() {
        return require;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setRequire(Require require) {
        this.require = require;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public Float getBidCount() {
        return bidCount;
    }

    public void setBidCount(Float bidCount) {
        this.bidCount = bidCount;
    }

    public Float getBidPrice() {
        return bidPrice;
    }

    public void setBidPrice(Float bidPrice) {
        this.bidPrice = bidPrice;
    }

    public Long getRequireId() {
        return requireId;
    }

    public void setRequireId(Long requireId) {
        this.requireId = requireId;
    }
}
