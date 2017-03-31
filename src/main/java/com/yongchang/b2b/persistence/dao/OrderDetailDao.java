package com.yongchang.b2b.persistence.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.OrderDetail;

/**
 * @author zxc Jun 27, 2016 3:04:44 PM
 */
public interface OrderDetailDao extends PagingAndSortingRepository<OrderDetail, Long>, JpaSpecificationExecutor<OrderDetail> {

    Page<OrderDetail> findAllByOrderId(Long orderId, Pageable pageRequest);

    Page<OrderDetail> findAllByItemIdAndCreateTimeAfter(Long itemId, Date createTime, Pageable pageRequest);

    List<OrderDetail> findAllByOrderId(Long orderId);

    @Query("select DISTINCT orderDetail.itemId from OrderDetail orderDetail group by orderDetail.itemId order by count(orderDetail.id) DESC")
    Page<Long> findAllTop4(Pageable pageable);
}
