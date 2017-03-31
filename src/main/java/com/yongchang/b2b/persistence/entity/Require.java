/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * @author zxc Jul 29, 2016 3:37:19 PM
 */
@Entity
@Table(name = "plat_require")
public class Require extends IdEntity {

    private Date    createTime   = new Date();
    private Date    deadlineTime;             // 截止日期
    private int     state;                    // 状态: 0=未审核,1=有效,2=停止

    private String  title;                    // 商品名称
    private Float   requireCount = 0f;        // 需求量
    private Float   finishCount  = 0f;        // 已中标量
    private Float   startPrice   = 0f;        // 竞标起始价

    private Long    productId;                // 关联商品基础信息id
    private Product product;

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "productId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getDeadlineTime() {
        return deadlineTime;
    }

    public void setDeadlineTime(Date deadlineTime) {
        this.deadlineTime = deadlineTime;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Float getRequireCount() {
        return requireCount;
    }

    public void setRequireCount(Float requireCount) {
        this.requireCount = requireCount;
    }

    public Float getFinishCount() {
        return finishCount;
    }

    public void setFinishCount(Float finishCount) {
        this.finishCount = finishCount;
    }

    public Float getStartPrice() {
        return startPrice;
    }

    public void setStartPrice(Float startPrice) {
        this.startPrice = startPrice;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }
}
