/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yongchang.b2b.persistence.dao.SlideshowDAO;
import com.yongchang.b2b.persistence.entity.Slideshow;

/**
 * @author zxc Aug 14, 2016 12:41:37 PM
 */
@Service
@Transactional
public class CMSService {

    @Autowired
    private SlideshowDAO slideshowDAO;

    public Slideshow slideshow(Long id) {
        if (id == null) return null;
        return slideshowDAO.findOne(id);
    }

    public List<Slideshow> list() {
        return Lists.newArrayList(slideshowDAO.findAll());
    }

    public List<Slideshow> listSort() {
        return Lists.newArrayList(slideshowDAO.findAll(pageRequest(1, 10, "turn")));
    }

    public List<Slideshow> listByState(int state) {
        return slideshowDAO.findAllByState(state);
    }

    public void save(Slideshow slideshow) {
        slideshowDAO.save(slideshow);
    }

    public void del(Long id) {
        if (id == null) return;
        slideshowDAO.delete(id);
    }

    // 创建分页请求
    private PageRequest pageRequest(int pageNumber, int pageSize, String sortType) {
        Sort sort = new Sort(Direction.DESC, "id");
        if (StringUtils.equalsIgnoreCase("auto", sortType)) {
            sort = new Sort(Direction.DESC, "id");
        } else if (StringUtils.equalsIgnoreCase("turn", sortType)) {
            sort = new Sort(Direction.DESC, "turn");
        }
        return new PageRequest(pageNumber - 1, pageSize, sort);
    }
}
