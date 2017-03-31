package com.yongchang.b2b.persistence.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Category;

/**
 * @author zxc Jun 16, 2016 3:32:41 PM
 */
public interface CategoryDao extends PagingAndSortingRepository<Category, Long>, JpaSpecificationExecutor<Category> {

    List<Category> findByParentId(Long id);

    Page<Category> findByParentId(Long id, Pageable paramPageable);

    @Query("select e from Category e where e.parent!=null")
    List<Category> find2ndLevel();
}
