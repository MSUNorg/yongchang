/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.service;

import java.util.*;

import javax.persistence.criteria.*;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yongchang.b2b.cons.EnumCollections.ItemState;
import com.yongchang.b2b.cons.EnumCollections.ItemSumState;
import com.yongchang.b2b.persistence.dao.ItemDao;
import com.yongchang.b2b.persistence.dao.ItemSumDao;
import com.yongchang.b2b.persistence.entity.Item;
import com.yongchang.b2b.persistence.entity.ItemSum;

/**
 * @author zxc Jun 16, 2016 3:41:09 PM
 */
@Service
@Transactional
public class ItemService {

    @Autowired
    private ItemDao    itemDao;
    @Autowired
    private ItemSumDao itemSumDao;

    public Item item(Long id) {
        if (id == null) return null;
        return itemDao.findOne(id);
    }

    public List<Item> listItemByBuyer(Integer type, Long userId) {
        return itemDao.findAllByTypeAndUserId(type, userId);
    }

    public List<Item> listItemByBuyer(Integer type) {
        return itemDao.findAllByType(type);
    }

    public List<Item> listItem(List<Long> ids) {
        return Lists.newArrayList(itemDao.findAll(ids));
    }

    public List<Item> listItem(String keyword) {
        if (StringUtils.isEmpty(keyword)) return Collections.<Item> emptyList();
        return itemDao.findByTitleLike(keyword);
    }

    public Page<Item> listItem(int page, int size) {
        return itemDao.findAll(pageRequest(page, size, null));
    }

    public List<Item> listItemByShowcase(int showcase) {
        return itemDao.findAllByShowcase(showcase);
    }

    public Page<Item> listItemProductId(Long productId, int page, int size) {
        return itemDao.findAllByProductId(productId, pageRequest(page, size, null));
    }

    public Page<Item> listItemByState(ItemState state, int page, int size) {
        return itemDao.findAllByState(state.getValue(), pageRequest(page, size, null));
    }

    public List<Item> listItemByState(ItemState state) {
        return itemDao.findAllByState(state.getValue());
    }

    public Page<Item> listItem(ItemState state, Long categoryId, String keyword, int page, int size) {
        if (StringUtils.isEmpty(keyword)) keyword = "_";
        if (categoryId == null) {
            return itemDao.findAll(state.getValue(), keyword, pageRequest(page, size, null));
        } else {
            return itemDao.findAll(state.getValue(), categoryId, keyword, pageRequest(page, size, null));
        }
    }

    public List<Item> listItem(ItemState state, Long categoryId, String keyword) {
        return itemDao.findAll(state.getValue(), categoryId, keyword);
    }

    public Page<Item> listItemBySupplier(Long userId, int page, int size) {
        return itemDao.findAllByUserId(userId, pageRequest(page, size, null));
    }

    public List<Item> listItemByCategoryIds(Collection<Long> categoryIds) {
        if (categoryIds == null || categoryIds.size() == 0) return Collections.<Item> emptyList();
        return itemDao.findByCategoryIds(categoryIds);
    }

    public void save(Item item) {
        itemDao.save(item);
    }

    public void del(Long id) {
        if (id == null) return;
        itemDao.delete(id);
    }

    // *************************************************************//
    public ItemSum itemSum(Long id) {
        if (id == null) return null;
        return itemSumDao.findOne(id);
    }

    public List<ItemSum> itemSum(final Date start, final Date end) {
        if (start == null) return Collections.<ItemSum> emptyList();
        return itemSumDao.findAll(timeSpecific(start, end));
    }

    public List<ItemSum> itemSumByItemId(Long itemId, final Date start, final Date end) {
        if (start == null) return Collections.<ItemSum> emptyList();
        return itemSumDao.findAll(timeSpecific(start, end));
    }

    public ItemSum getByItemIdAndSumDate(Long itemId, String sumDate) {
        if (itemId == null) return null;
        return itemSumDao.findByItemIdAndSumDate(itemId, sumDate);
    }

    public Page<ItemSum> getBySumDate(String sumDate, int page, int size) {
        if (StringUtils.isEmpty(sumDate)) return null;
        return itemSumDao.findBySumDate(sumDate, pageRequest(page, size, null));
    }

    public Page<ItemSum> getByStateAndSumDate(ItemSumState itemsumState, String sumDate, int page, int size) {
        if (StringUtils.isEmpty(sumDate)) return null;
        return itemSumDao.findByStateAndSumDate(itemsumState.getValue(), sumDate, pageRequest(page, size, null));
    }

    public List<ItemSum> getByStateAndSumDate(ItemSumState itemsumState, String sumDate) {
        if (StringUtils.isEmpty(sumDate)) return null;
        return itemSumDao.findByStateAndSumDate(itemsumState.getValue(), sumDate);
    }

    public Page<ItemSum> getByStateNotAndSumDate(ItemSumState itemsumState, String sumDate, int page, int size) {
        if (StringUtils.isEmpty(sumDate)) return null;
        return itemSumDao.findByStateNotAndSumDate(itemsumState.getValue(), sumDate, pageRequest(page, size, null));
    }

    public List<ItemSum> getByStateNotAndSumDate(ItemSumState itemsumState, String sumDate) {
        if (StringUtils.isEmpty(sumDate)) return null;
        return itemSumDao.findByStateNotAndSumDate(itemsumState.getValue(), sumDate);
    }

    public List<ItemSum> getBySumDate(String sumDate) {
        if (StringUtils.isEmpty(sumDate)) return null;
        return itemSumDao.findBySumDate(sumDate);
    }

    public Page<ItemSum> listItemSum(int page, int size) {
        return itemSumDao.findAll(pageRequest(page, size, null));
    }

    public void save(ItemSum itemSum) {
        itemSumDao.save(itemSum);
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

    private Specification<ItemSum> timeSpecific(final Date start, final Date end) {
        return new Specification<ItemSum>() {

            @Override
            public Predicate toPredicate(Root<ItemSum> r, CriteriaQuery<?> q, CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                predicate.getExpressions().add(
                // 添加日期查询,区间查询
                cb.between(r.<Date> get("createTime"), start, (end == null ? new Date() : end)));
                predicate.getExpressions().add(cb.notEqual(r.<Long> get("state"), ItemSumState.CLOAED.getValue()));
                return predicate;
            }
        };
    }
}
