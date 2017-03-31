package com.yongchang.b2b.persistence.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Product;

/**
 * @author zxc Jun 16, 2016 3:34:43 PM
 */
public interface ProductDao extends PagingAndSortingRepository<Product, Long>, JpaSpecificationExecutor<Product> {

    List<Product> findAllByCategoryId(Long categoryId);

    Page<Product> findAllByCategoryId(Long categoryId, Pageable paramPageable);
}
