package com.yongchang.b2b.persistence.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Cart;

/**
 * @author zxc Jun 29, 2016 2:15:57 PM
 */
public interface CartDao extends PagingAndSortingRepository<Cart, Long>, JpaSpecificationExecutor<Cart> {

    Page<Cart> findAllByUserId(Long userId, Pageable pageRequest);

    Page<Cart> findAllByUserIdAndState(Long userId, int state, Pageable pageRequest);
    
    Cart findByUserIdAndItemIdAndState(Long userId, Long itemId, int state);
}
