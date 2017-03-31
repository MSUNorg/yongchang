/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.service;

import java.util.*;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.yongchang.b2b.persistence.dao.CategoryDao;
import com.yongchang.b2b.persistence.entity.Category;

/**
 * @author zxc Jun 16, 2016 3:40:35 PM
 */
@Service
@Transactional
public class CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    public Category category(Long id) {
        if (id == null) return null;
        return categoryDao.findOne(id);
    }

    public List<JSONObject> tree() {
        List<Category> list = listParent(null);
        return list2tree(list);
    }

    public Set<Long> childrenIds(Long id) {
        if (id == null) return Collections.<Long> emptySet();
        Category category = categoryDao.findOne(id);
        if (category == null) return Collections.<Long> emptySet();
        Set<Long> result = Sets.newHashSet();
        return list4ids(Lists.newArrayList(new Category[] { category }), result);
    }

    public Page<Category> list(int page, int size) {
        return categoryDao.findAll(pageRequest(page, size, null));
    }

    public Page<Category> listParent(Long id, int page, int size) {
        return categoryDao.findByParentId(id, pageRequest(page, size, null));
    }

    public List<Category> listParent(Long id) {
        return categoryDao.findByParentId(id);
    }

    public List<Category> list2ndLevel() {
        return categoryDao.find2ndLevel();
    }

    public void save(Category category) {
        categoryDao.save(category);
    }

    public void del(Long id) {
        if (id == null) return;
        categoryDao.delete(id);
    }

    // 创建分页请求
    private PageRequest pageRequest(int pageNumber, int pageSize, String sortType) {
        Sort sort = new Sort(Direction.DESC, "id");
        if (StringUtils.equalsIgnoreCase("auto", sortType)) {
            sort = new Sort(Direction.DESC, "id");
        } else if (StringUtils.equalsIgnoreCase("update_time", sortType)) {
            sort = new Sort(Direction.DESC, "update_time");
        }
        return new PageRequest(pageNumber - 1, pageSize, sort);
    }

    private Set<Long> list4ids(Collection<Category> list, Set<Long> result) {
        for (Category category : list) {
            if (category.getChildren() != null && category.getChildren().size() > 0) {
                result.addAll(list4ids(category.getChildren(), result));
            }
            result.add(category.getId());
        }
        return result;
    }

    private List<JSONObject> list2tree(Collection<Category> list) {
        List<JSONObject> result = new LinkedList<JSONObject>();
        for (Category category : list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", category.getId());
            jsonObject.put("text", category.getName());
            if (category.getChildren() != null && category.getChildren().size() > 0) {
                jsonObject.put("children", list2tree(category.getChildren()));
            }
            result.add(jsonObject);
        }
        return result;
    }
}
