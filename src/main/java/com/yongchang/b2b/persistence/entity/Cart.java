/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.yongchang.b2b.cons.EnumCollections.CartState;

/**
 * @author zxc Jun 29, 2016 2:11:53 PM
 */
@Entity
@Table(name = "cart")
public class Cart extends IdEntity {

    private Date    createTime = new Date();
    private Integer state;                  // 订单状态: 0=未下单,1=已下单,2=关闭,取消
    private Float   count      = 0f;        // 购买数量
    private Float   amount     = 0f;        // 商品总金额,小计金额,单位分

    private Long    itemId;                 // 商品id
    private Long    userId;                 // 下单者用户id

    private Item    item;
    private User    user;

    public Cart() {

    }

    public Cart(Long itemId, Long userId, float count, float amount) {
        this(itemId, userId, count, amount, CartState.NO_ORDER.getValue());
    }

    public Cart(Long itemId, Long userId, float count, float amount, int state) {
        this.itemId = itemId;
        this.userId = userId;
        this.count = count;
        this.amount = amount;
        this.state = state;
    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "itemId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public Float getCount() {
        return count;
    }

    public void setCount(Float count) {
        this.count = count;
    }

    public Float getAmount() {
        return amount;
    }

    public void setAmount(Float amount) {
        this.amount = amount;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
