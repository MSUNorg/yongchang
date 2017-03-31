package com.yongchang.b2b.persistence.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.TemporalType;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.yongchang.b2b.persistence.entity.Order;

/**
 * @author zxc Jun 16, 2016 3:35:44 PM
 */
public interface OrderDao extends PagingAndSortingRepository<Order, Long>, JpaSpecificationExecutor<Order> {

    @Query("select distinct o from Order o where o.state!=6 and o.type=?1")
    List<Order> findAllByType(Integer type);

    @Query("select distinct o from Order o where o.state!=6 and o.type=?1")
    Page<Order> findAllByType(Integer type, Pageable pageRequest);

    @Query("select distinct o from Order o where o.state!=6 and o.type=?1 and o.userId=?2")
    List<Order> findAllByTypeAndUserId(Integer type, Long userId);

    @Query("select distinct o from Order o where o.state!=6 and o.type=?1 and o.userId=?2")
    Page<Order> findAllByTypeAndUserId(Integer type, Long userId, Pageable pageRequest);

    @Query("select distinct orderDetail.order from OrderDetail orderDetail where orderDetail.order.type=?1 and orderDetail.order.userId=?2 and orderDetail.order.createTime >=?3")
    Page<Order> findAllByTypeAndUserIdAndCreateTimeAfter(Integer type, Long userId, Date date, Pageable pageRequest);

    Page<Order> findAllByTypeAndUserIdAndCreateTimeBefore(Integer type, Long userId, Date date, Pageable pageRequest);

    @Query("select distinct orderDetail.order from OrderDetail orderDetail where orderDetail.order.type=?1 and orderDetail.itemUserId=?2")
    Page<Order> findAllByTypeAndItemUserId(Integer type, Long itemUserId, Pageable pageRequest);

    @Query("select distinct orderDetail.order from OrderDetail orderDetail where orderDetail.order.type = :type and orderDetail.itemUserId = :itemUserId and orderDetail.createTime BETWEEN :start AND :end")
    Page<Order> findAllByTypeAndItemUserId(@Param("type") Integer type, @Param("itemUserId") Long itemUserId,
                                           @Param("start") @Temporal(TemporalType.DATE) Date start,
                                           @Param("end") @Temporal(TemporalType.DATE) Date end, Pageable pageRequest);

    @Query("select distinct orderDetail.order from OrderDetail orderDetail where orderDetail.order.type=?1 and orderDetail.itemUserId=?2")
    List<Order> findAllByTypeAndItemUserIdList(Integer type, Long itemUserId);

    @Query("select distinct orderDetail.order from OrderDetail orderDetail where orderDetail.order.type = :type and orderDetail.itemUserId = :itemUserId and orderDetail.createTime BETWEEN :start AND :end")
    List<Order> findAllByTypeAndItemUserIdList(@Param("type") Integer type, @Param("itemUserId") Long itemUserId,
                                               @Param("start") @Temporal(TemporalType.DATE) Date start,
                                               @Param("end") @Temporal(TemporalType.DATE) Date end);

    @Query("select distinct orderDetail.order.id from OrderDetail orderDetail where orderDetail.order.type=?1 and orderDetail.itemId=?2 and orderDetail.order.state=?3")
    List<Long> findAllByTypeAndItemIdAndState(Integer type, Long itemId, Integer state);

    @Query("select distinct orderDetail.order from OrderDetail orderDetail where orderDetail.order.type=?1 and orderDetail.order.state=?2 and orderDetail.itemUserId=?3")
    Page<Order> findAllByTypeAndStateAndItemUserId(Integer type, Integer state, Long itemUserId, Pageable pageRequest);

    @Modifying
    @Query("update Order o set o.state=?1 where o.id in (?2)")
    void updateOrdersState(Integer state, List<Long> orderIds);
}
