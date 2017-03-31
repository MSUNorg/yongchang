/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * @author zxc Jun 15, 2016 4:08:52 PM
 */
@Entity
@Table(name = "product")
public class Product extends IdEntity {

    private Date     createTime     = new Date();
    private String   code;                       // 商品编码
    private String   title;                      // 商品标题
    private String   introduction;               // 商品说明
    private String   content;                    // 商品具体内容
    private int      state;                      // 状态: 0=未审核,1=正常出售中,2=停止
    private String   unit;                       // 单位,如组,斤,瓶,kg

    private Float    price          = 0f;        // 商品价格,单位元
    private Float    salesPrice     = 0f;        // 商品销售价格,单位元
    private Integer  salesNum;                   // 商品已销售数量
    private String   brand;                      // 品牌
    private String   model;                      // 规格
    private String   produce;                    // 产地
    private String   envionment;                 // 存储环境
    private String   service;                    // 支持服务(24小时退换货,限时配送,自提)

    private Float    freight        = 0f;        // 运费,单位元
    private Float    loss           = 0f;        // 损耗字段,单位元

    private Long     categoryId;                 // 商品类别id
    private Float    minOrderQty    = 0f;        // 最小订购重量
    private Float    priceAddAmount = 0f;        // 加价幅度

    private Category category;

    public Date getCreateTime() {
        return createTime;
    }

    public Float getMinOrderQty() {
        return minOrderQty;
    }

    public void setMinOrderQty(Float minOrderQty) {
        this.minOrderQty = minOrderQty;
    }

    public Float getPriceAddAmount() {
        return priceAddAmount;
    }

    public void setPriceAddAmount(Float priceAddAmount) {
        this.priceAddAmount = priceAddAmount;
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

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Integer getSalesNum() {
        return salesNum;
    }

    public void setSalesNum(Integer salesNum) {
        this.salesNum = salesNum;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getProduce() {
        return produce;
    }

    public void setProduce(String produce) {
        this.produce = produce;
    }

    public String getEnvionment() {
        return envionment;
    }

    public void setEnvionment(String envionment) {
        this.envionment = envionment;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Float getSalesPrice() {
        return salesPrice;
    }

    public void setSalesPrice(Float salesPrice) {
        this.salesPrice = salesPrice;
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

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinColumn(name = "categoryId", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
