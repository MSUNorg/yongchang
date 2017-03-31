/**
 * 
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.*;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * 每日商品订货汇总表
 * 
 * @author zxc
 */
@Entity
@Table(name = "item_sum")
public class ItemSum extends IdEntity {

    private Date   createTime = new Date();
    private String sumDate;                // 汇总日期

    private Float  count      = 0f;        // 缺货数量,供货数量,可销售数量
    private Long   itemId;                 // 供货id
    private int    state;                  // 处理状态: 0=未下单,1=已下单,2=关闭

    private Item   item;

    public ItemSum() {

    }

    public ItemSum(String sumDate, Long itemId) {
        this(sumDate, itemId, 0);
    }

    public ItemSum(String sumDate, Long itemId, float count) {
        this.sumDate = sumDate;
        this.itemId = itemId;
        this.count = count;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getSumDate() {
        return sumDate;
    }

    public void setSumDate(String sumDate) {
        this.sumDate = sumDate;
    }

    public Float getCount() {
        return count;
    }

    public void setCount(Float count) {
        this.count = count;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
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
}
