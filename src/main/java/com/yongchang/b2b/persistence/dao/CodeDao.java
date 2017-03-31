package com.yongchang.b2b.persistence.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Code;

/**
 * @author zxc Jun 16, 2016 3:33:48 PM
 */
public interface CodeDao extends PagingAndSortingRepository<Code, Long>, JpaSpecificationExecutor<Code> {

    Code findByCode(String code);

    Code findByCodeAndState(String code, int state);

    Code findByCodeAndStateAndType(String code, int state, int type);

    Page<Code> findAllByState(int state, Pageable pageRequest);
}
