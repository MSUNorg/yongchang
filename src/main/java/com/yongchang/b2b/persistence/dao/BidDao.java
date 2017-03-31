package com.yongchang.b2b.persistence.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Bid;

/**
 * @author zxc Jul 29, 2016 3:58:40 PM
 */
public interface BidDao extends PagingAndSortingRepository<Bid, Long>, JpaSpecificationExecutor<Bid> {

    List<Bid> findAllByRequireId(Long requireId);

    Page<Bid> findAllByRequireId(Long requireId, Pageable paramPageable);

    Page<Bid> findAllByUserId(Long userId, Pageable paramPageable);
}
