/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * 订单子项
 * 
 * @author zxc Jun 27, 2016 2:35:30 PM
 */
@Entity
@Table(name = "order_detail")
public class OrderDetail extends IdEntity {

    private Date   createTime  = new Date();
    private Date   updateTime  = new Date();
    private String title;                   // 商品标题
    private String img;                     // 商品主图片
    private Float  price       = 0f;        // 商品价格,单位元
    private Float  adjustPrice = 0f;        // 订单调整价格,单位元
    private Float  count       = 0f;        // 购买数量
    private Float  amount      = 0f;        // 商品总金额,小计金额,单位元

    private Long   itemId;                  // 商品id
    private Long   orderId;                 // 订单id
    private Long   itemUserId;              // 商品用户id

    private Item   item;
    private Order  order;
    private User   itemUser;

    public OrderDetail() {

    }

    public OrderDetail(Long itemId, float count) {
        this.itemId = itemId;
        this.count = count;
    }

    public OrderDetail(Long itemId, Long orderId, float count, float price, float amount, Long itemUserId) {
        this.itemId = itemId;
        this.orderId = orderId;
        this.count = count;
        this.price = price;
        this.amount = amount;
        this.itemUserId = itemUserId;
    }

    public Long getItemUserId() {
        return itemUserId;
    }

    public void setItemUserId(Long itemUserId) {
        this.itemUserId = itemUserId;
    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "itemUserId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public User getItemUser() {
        return itemUser;
    }

    public void setItemUser(User itemUser) {
        this.itemUser = itemUser;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Float getCount() {
        return count;
    }

    public void setCount(Float count) {
        this.count = count;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Float getAdjustPrice() {
        return adjustPrice;
    }

    public void setAdjustPrice(Float adjustPrice) {
        this.adjustPrice = adjustPrice;
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

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
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

    @ManyToOne(cascade = { CascadeType.MERGE, CascadeType.REFRESH }, optional = true)
    @JoinColumn(name = "orderId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }
}
