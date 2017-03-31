/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yongchang.b2b.persistence.entity.Slideshow;

/**
 * @author zxc Aug 14, 2016 12:38:49 PM
 */
public interface SlideshowDAO extends PagingAndSortingRepository<Slideshow, Long>, JpaSpecificationExecutor<Slideshow> {

    List<Slideshow> findAllByState(Integer state);
}
