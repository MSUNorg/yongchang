package com.yongchang.b2b.persistence.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Require;

/**
 * @author zxc Jul 29, 2016 3:58:29 PM
 */
public interface RequireDao extends PagingAndSortingRepository<Require, Long>, JpaSpecificationExecutor<Require> {

}
