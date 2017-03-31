/**
 * 
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 规格说明表
 * 
 * @author zxc
 */
@Entity
@Table(name = "model")
public class Model extends IdEntity {

    private Date    createTime = new Date();

    private String  name;                   // 计量名称
    private Integer weight;                 // 重量换算(千克)
    private Integer state;                  // 状态: 0=有效,1=停止

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}
