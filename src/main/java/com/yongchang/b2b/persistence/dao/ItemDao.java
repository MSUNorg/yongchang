package com.yongchang.b2b.persistence.dao;

import java.util.Collection;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.yongchang.b2b.persistence.entity.Item;

/**
 * @author zxc Jun 16, 2016 3:36:24 PM
 */
public interface ItemDao extends PagingAndSortingRepository<Item, Long>, JpaSpecificationExecutor<Item> {

    Page<Item> findAllByProductId(Long productId, Pageable pageRequest);

    Page<Item> findAllByUserId(Long userId, Pageable pageRequest);

    Page<Item> findAllByState(Integer state, Pageable pageRequest);

    List<Item> findAllByState(Integer state);

    @Query("select e from Item e where e.title like %:keyword% and e.state= :itemState and e.product.categoryId= :categoryId")
    Page<Item> findAll(@Param("itemState") Integer state, @Param("categoryId") Long categoryId,
                       @Param("keyword") String keyword, Pageable pageRequest);

    @Query("select e from Item e where e.title like %:keyword% and e.state= :state and e.product.categoryId= :categoryId")
    List<Item> findAll(@Param("state") Integer state, @Param("categoryId") Long categoryId,
                       @Param("keyword") String keyword);

    @Query("select e from Item e where e.title like %:keyword% and e.state= :itemState")
    Page<Item> findAll(@Param("itemState") Integer state, @Param("keyword") String keyword, Pageable pageRequest);

    @Query("select e from Item e where e.title like %:keyword% and e.state= :state")
    List<Item> findAll(@Param("state") Integer state, @Param("keyword") String keyword);

    List<Item> findAllByShowcase(Integer showcase);

    @Query("select e from Item e where e.title like %:keyword%")
    List<Item> findByTitleLike(@Param("keyword") String keyword);

    @Query("select e from Item e where e.product.categoryId IN :categoryIds")
    List<Item> findByCategoryIds(@Param(value = "categoryIds") Collection<Long> categoryIds);

    @Query("select distinct orderDetail.item from OrderDetail orderDetail where orderDetail.order.type=?1 and orderDetail.order.userId=?2")
    List<Item> findAllByTypeAndUserId(Integer type, Long userId);

    @Query("select distinct orderDetail.item from OrderDetail orderDetail where orderDetail.order.type=?1")
    List<Item> findAllByType(Integer type);
}
