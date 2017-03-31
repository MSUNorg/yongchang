/**
 * 
 */
package com.yongchang.b2b.persistence.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Lists;

/**
 * @author zxc
 */
@Entity
@Table(name = "role")
public class Role extends IdEntity {

    private Date         createTime   = new Date();
    private String       name;
    private Integer      state        = 0;                   // 状态: 0=未审核,1=正常,2=停止

    private String       resource;                           // 可访问资源列表
    private List<String> resourceList = Lists.newArrayList();

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

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    @Transient
    public List<String> getResourceList() {
        return (List<String>) (StringUtils.isNotEmpty(resource) ? Lists.newArrayList(StringUtils.split(resource, ",")) : resourceList);
    }

    public void setResourceList(List<String> resourceList) {
        this.resourceList = resourceList;
    }
}
