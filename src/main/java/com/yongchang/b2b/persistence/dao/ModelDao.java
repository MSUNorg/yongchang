/**
 * 
 */
package com.yongchang.b2b.persistence.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Model;

/**
 * @author zxc
 */
public interface ModelDao extends PagingAndSortingRepository<Model, Long>, JpaSpecificationExecutor<Model> {

}
