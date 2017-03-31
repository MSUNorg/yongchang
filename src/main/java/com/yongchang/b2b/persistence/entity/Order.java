/**
 * 
 */
package com.yongchang.b2b.persistence.entity;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.yongchang.b2b.cons.EnumCollections.OrderState;
import com.yongchang.b2b.cons.EnumCollections.OrderType;

/**
 * 订单表:1=平台向供应商下的订单,2=采购商向平台下的订单
 * 
 * @author zxc
 */
@Entity
@Table(name = "store_order")
public class Order extends IdEntity {

    private Date             createTime  = new Date();
    private Date             updateTime  = new Date();
    private String           orderNum;                                // 订单编号
    private String           name;                                    // 订单名称
    private int              state;                                   // 订单状态: 0=未审核,1=正常,2=停止
    private int              type;                                    // 订单类型(1=供货单,2=采购单)
    private Float            orderPrice  = 0f;                        // 订单价格,单位元
    private Float            adjustPrice = 0f;                        // 订单调整价格,单位元

    private String           remark;                                  // 订单备注
    private String           consignee;                               // 收货人
    private String           province;                                // 省份
    private String           city;                                    // 城市
    private String           area;                                    // 区县
    private String           address;                                 // 地址
    private String           zipcode;                                 // 区号
    private String           telNum;                                  // 电话
    private String           mobile;                                  // 手机

    private String           expresType;                              // 物流公司
    private Date             expresTime;                              // 物流时间
    private String           expresNum;                               // 物流单号
    private Float            expresPrice = 0f;                        // 物流价格

    private Date             payTime;                                 // 支付时间
    private int              payState;                                // 支付状态: 0=未支付,1=已支付,2=已发货
    private String           payType;                                 // 支付类型 (网上支付，货到付款)
    private String           payPlat;                                 // 支付平台 例如 支付宝
    private String           payMethod;                               // 支付方式 银行/或者货到付款的现金/POST机

    private int              invoice;                                 // 是否需要发票:0=不需要,1=需要
    private String           invoiceType;                             // 发票类型(个人，公司)
    private String           invoiceTitle;                            // 发票抬头

    private Long             userId;                                  // 下单者用户id

    private Set<OrderDetail> details     = new HashSet<OrderDetail>();
    private User             user;

    public Order() {

    }

    // 注意:这里的默认值
    public Order(Long userId, OrderType type, OrderState state) {
        this.userId = userId;
        this.type = type.getValue();
        this.state = state.getValue();
        String code = String.valueOf(Math.floor((Math.random() * 1000000)) + 1000000).substring(1, 4);
        this.orderNum = (new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())) + code;
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

    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REMOVE }, mappedBy = "order")
    public Set<OrderDetail> getDetails() {
        return details;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public void setDetails(Set<OrderDetail> details) {
        this.details = details;
    }

    public void addOrderItem(OrderDetail orderDetail) {
        orderDetail.setOrder(this);
        this.details.add(orderDetail);
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
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

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getTelNum() {
        return telNum;
    }

    public void setTelNum(String telNum) {
        this.telNum = telNum;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getExpresType() {
        return expresType;
    }

    public void setExpresType(String expresType) {
        this.expresType = expresType;
    }

    public Date getExpresTime() {
        return expresTime;
    }

    public void setExpresTime(Date expresTime) {
        this.expresTime = expresTime;
    }

    public String getExpresNum() {
        return expresNum;
    }

    public void setExpresNum(String expresNum) {
        this.expresNum = expresNum;
    }

    public Float getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Float orderPrice) {
        this.orderPrice = orderPrice;
    }

    public Float getAdjustPrice() {
        return adjustPrice;
    }

    public void setAdjustPrice(Float adjustPrice) {
        this.adjustPrice = adjustPrice;
    }

    public Float getExpresPrice() {
        return expresPrice;
    }

    public void setExpresPrice(Float expresPrice) {
        this.expresPrice = expresPrice;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public int getPayState() {
        return payState;
    }

    public void setPayState(int payState) {
        this.payState = payState;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getPayPlat() {
        return payPlat;
    }

    public void setPayPlat(String payPlat) {
        this.payPlat = payPlat;
    }

    public String getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(String payMethod) {
        this.payMethod = payMethod;
    }

    public int getInvoice() {
        return invoice;
    }

    public void setInvoice(int invoice) {
        this.invoice = invoice;
    }

    public String getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(String invoiceType) {
        this.invoiceType = invoiceType;
    }

    public String getInvoiceTitle() {
        return invoiceTitle;
    }

    public void setInvoiceTitle(String invoiceTitle) {
        this.invoiceTitle = invoiceTitle;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
