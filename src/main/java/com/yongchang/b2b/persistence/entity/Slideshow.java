/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author zxc Aug 14, 2016 12:38:38 PM
 */
@Entity
@Table(name = "slideshow")
public class Slideshow extends IdEntity {

    private Date    createTime = new Date();
    private int     state;                  // 状态: 0=有效,1=无效

    private String  title;                  // 标题,可为空
    private String  link;                   // 跳转链接,可为空
    private String  pic;                    // 图片,可为空
    private int     type;                   // 类型
    private Integer turn;                   // 排序

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getTurn() {
        return turn;
    }

    public void setTurn(Integer turn) {
        this.turn = turn;
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

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
