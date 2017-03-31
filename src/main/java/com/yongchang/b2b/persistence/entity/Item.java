/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * @author zxc Jun 15, 2016 4:15:13 PM
 */
@Entity
@Table(name = "item")
public class Item extends IdEntity {

    private Date    createTime     = new Date();
    private int     state;                      // 状态: 0=未审核,1=正常出售中,2=停止

    private String  code;
    private String  title;
    private String  img;
    private Float   count          = 0f;
    private Float   itemPrice      = 0f;
    private Float   adjustPrice    = 0f;
    private String  unit;                       // 单位,如组,斤,瓶,kg
    private int     type;                       // 类型:1=缺货数量,平台或采购商,2=供货数量,供应商,0=可销售数量,平台
    private Long    productId;
    private Long    userId;
    private String  detail;
    private String  comment;                    // 平台评价
    private Integer showcase;                   // 橱窗推荐: 0=不推荐,1=推荐
    private String  description;                // 审核不通过说明

    // 20160822新需求增加字段
    private Float   freight        = 0f;        // 运费,单位元
    private Float   loss           = 0f;        // 损耗字段,单位元
    private Float   priceAddAmount = 0f;        // 加价幅度

    private Product product;
    private User    user;

    public String getDetail() {
        return detail;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Float getFreight() {
        return freight;
    }

    public void setFreight(Float freight) {
        this.freight = freight;
    }

    public Float getLoss() {
        return loss;
    }

    public void setLoss(Float loss) {
        this.loss = loss;
    }

    public Float getPriceAddAmount() {
        return priceAddAmount;
    }

    public void setPriceAddAmount(Float priceAddAmount) {
        this.priceAddAmount = priceAddAmount;
    }

    public Integer getShowcase() {
        return showcase;
    }

    public void setShowcase(Integer showcase) {
        this.showcase = showcase;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public Float getCount() {
        return count;
    }

    public void setCount(Float count) {
        this.count = count;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Float getItemPrice() {
        return itemPrice;
    }

    @Transient
    public String getItemPriceStr() {
        try {
            return itemPrice == null ? "*.00" : "*." + (StringUtils.split(itemPrice + "", ".")[1]);
        } catch (Exception e) {
        }
        return "*.00";
    }

    @Transient
    public String getItemFullPriceStr() {
        try {
            Float price = itemPrice + priceAddAmount + loss + freight;
            return price == null ? "*.00" : "*." + (StringUtils.split(price + "", ".")[1]);
        } catch (Exception e) {
        }
        return "*.00";
    }

    @Transient
    public Float getItemFullPrice() {
        try {
            Float price = itemPrice +priceAddAmount + loss + freight;
            return price == null ? 0f : price;
        } catch (Exception e) {
        }
        return 0f;
    }

    public void setItemPrice(Float itemPrice) {
        this.itemPrice = itemPrice;
    }

    public Float getAdjustPrice() {
        return adjustPrice;
    }

    public void setAdjustPrice(Float adjustPrice) {
        this.adjustPrice = adjustPrice;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "productId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
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
}
