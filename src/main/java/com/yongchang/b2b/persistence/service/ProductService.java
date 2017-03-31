/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yongchang.b2b.persistence.dao.ModelDao;
import com.yongchang.b2b.persistence.dao.ProductDao;
import com.yongchang.b2b.persistence.entity.Model;
import com.yongchang.b2b.persistence.entity.Product;

/**
 * @author zxc Jun 16, 2016 3:41:25 PM
 */
@Service
@Transactional
public class ProductService {

    @Autowired
    private ProductDao productDao;
    @Autowired
    private ModelDao   modelDao;

    public Product product(Long id) {
        if (id == null) return null;
        return productDao.findOne(id);
    }

    public List<Product> listProduct() {
        return Lists.newArrayList(productDao.findAll());
    }

    public Page<Product> listProduct(int page, int size) {
        return productDao.findAll(pageRequest(page, size, null));
    }

    public Page<Product> listProductByCategoryId(Long categoryId, int page, int size) {
        return productDao.findAllByCategoryId(categoryId, pageRequest(page, size, null));
    }

    public List<Product> listProduct(Long categoryId) {
        return productDao.findAllByCategoryId(categoryId);
    }

    public void save(Product product) {
        productDao.save(product);
    }

    public void delProduct(Long id) {
        if (id == null) return;
        productDao.delete(id);
    }

    // *************************************************************//
    public Model model(Long id) {
        if (id == null) return null;
        return modelDao.findOne(id);
    }

    public Page<Model> listModel(int page, int size) {
        return modelDao.findAll(pageRequest(page, size, null));
    }

    public void save(Model model) {
        modelDao.save(model);
    }

    public void delModel(Long id) {
        if (id == null) return;
        modelDao.delete(id);
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
}
