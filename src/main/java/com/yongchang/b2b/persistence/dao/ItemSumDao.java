/**
 * 
 */
package com.yongchang.b2b.persistence.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.ItemSum;

/**
 * @author zxc
 */
public interface ItemSumDao extends PagingAndSortingRepository<ItemSum, Long>, JpaSpecificationExecutor<ItemSum> {

    ItemSum findByItemIdAndSumDate(Long itemId, String sumDate);

    Page<ItemSum> findBySumDate(String sumDate, Pageable pageRequest);

    Page<ItemSum> findByStateAndSumDate(Integer state, String sumDate, Pageable pageRequest);

    List<ItemSum> findByStateAndSumDate(Integer state, String sumDate);

    List<ItemSum> findBySumDate(String sumDate);

    List<ItemSum> findAll(Specification<ItemSum> spec);

    List<ItemSum> findByItemId(Long itemId, Specification<ItemSum> spec);

    Page<ItemSum> findByStateNotAndSumDate(Integer state, String sumDate, Pageable pageRequest);

    List<ItemSum> findByStateNotAndSumDate(Integer state, String sumDate);
}
