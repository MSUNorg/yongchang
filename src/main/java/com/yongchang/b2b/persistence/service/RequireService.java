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
import com.yongchang.b2b.persistence.dao.BidDao;
import com.yongchang.b2b.persistence.dao.RequireDao;
import com.yongchang.b2b.persistence.entity.Bid;
import com.yongchang.b2b.persistence.entity.Require;

/**
 * @author zxc Jul 29, 2016 3:59:48 PM
 */
@Service
@Transactional
public class RequireService {

    @Autowired
    private RequireDao requireDao;
    @Autowired
    private BidDao     bidDao;

    public Require require(Long id) {
        if (id == null) return null;
        return requireDao.findOne(id);
    }

    public List<Require> listRequire() {
        return Lists.newArrayList(requireDao.findAll());
    }

    public Page<Require> listRequire(int page, int size) {
        return requireDao.findAll(pageRequest(page, size, null));
    }

    public void save(Require require) {
        requireDao.save(require);
    }

    public void delRequire(Long id) {
        if (id == null) return;
        requireDao.delete(id);
    }

    // ********************************************************//
    public Bid bid(Long id) {
        if (id == null) return null;
        return bidDao.findOne(id);
    }

    public List<Bid> listBid() {
        return Lists.newArrayList(bidDao.findAll());
    }

    public Page<Bid> listBid(int page, int size) {
        return bidDao.findAll(pageRequest(page, size, null));
    }

    public Page<Bid> listBid(Long requireId, int page, int size) {
        return bidDao.findAllByRequireId(requireId, pageRequest(page, size, null));
    }

    public List<Bid> listBid(Long requireId) {
        return bidDao.findAllByRequireId(requireId);
    }

    public Page<Bid> listBidByUserId(Long userId, int page, int size) {
        return bidDao.findAllByUserId(userId, pageRequest(page, size, null));
    }

    public void save(Bid bid) {
        bidDao.save(bid);
    }

    public void delBid(Long id) {
        if (id == null) return;
        bidDao.delete(id);
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
