/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package com.yongchang.b2b.persistence.service;

import java.text.ParseException;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.*;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yongchang.b2b.cons.EnumCollections.CartState;
import com.yongchang.b2b.cons.EnumCollections.OrderState;
import com.yongchang.b2b.cons.EnumCollections.OrderType;
import com.yongchang.b2b.persistence.dao.*;
import com.yongchang.b2b.persistence.entity.*;
import com.yongchang.b2b.persistence.entity.Order;

/**
 * @author zxc Jun 16, 2016 3:41:43 PM
 */
@Service
@Transactional
public class OrderService {

    @PersistenceContext
    EntityManager          em;

    @Autowired
    private CartDao        cartDao;
    @Autowired
    private OrderDao       orderDao;
    @Autowired
    private OrderDetailDao orderDetailDao;
    @Autowired
    private ItemSumDao     itemSumDao;

    public Cart cart(Long id) {
        if (id == null) return null;
        return cartDao.findOne(id);
    }

    public Page<Cart> listCartByUserId(Long userId, int page, int size) {
        return cartDao.findAllByUserId(userId, pageRequest(page, size, null));
    }

    public Page<Cart> listCartByUserIdAndState(Long userId, CartState state, int page, int size) {
        return cartDao.findAllByUserIdAndState(userId, state.getValue(), pageRequest(page, size, null));
    }

    public void save(Cart cart) {
        Cart existCart = cartDao.findByUserIdAndItemIdAndState(cart.getUserId(), cart.getItemId(),
                                                               CartState.NO_ORDER.getValue());
        if (existCart != null) {
            existCart.setCount(existCart.getCount() + cart.getCount());
            existCart.setAmount(existCart.getAmount() + cart.getAmount());
            cartDao.save(existCart);
        } else {
            cartDao.save(cart);
        }
    }

    public void delCart(Long id) {
        if (id == null) return;
        cartDao.delete(id);
    }

    // *************************************************************//
    public Order order(Long id) {
        if (id == null) return null;
        return orderDao.findOne(id);
    }

    public void delorder(Long id) {
        if (id == null) return;
        orderDao.delete(id);
    }

    public void orderConfirm(Long id) {
        // 供应商确认订单
        Order order = orderDao.findOne(id);
        order.setState(OrderState.CONFIRMED.getValue());

        // 连带确认采购商的订单
        List<Long> orderIds = Lists.newArrayList();
        List<OrderDetail> details = orderDetailDao.findAllByOrderId(order.getId());
        for (OrderDetail detail : details) {
            orderIds.addAll(orderDao.findAllByTypeAndItemIdAndState(OrderType.SELL.getValue(), detail.getItemId(),
                                                                    OrderState.NORMAL.getValue()));
        }
        if (!orderIds.isEmpty()) {
        	orderDao.updateOrdersState(OrderState.CONFIRMED.getValue(), orderIds);
        }
    }

    public void orderDeliver(Long id) {
        // 供应商订单发货
        Order order = orderDao.findOne(id);
        order.setState(OrderState.DELIVERED.getValue());

        // 连带发货采购商的订单
        List<Long> orderIds = Lists.newArrayList();
        List<OrderDetail> details = orderDetailDao.findAllByOrderId(order.getId());
        for (OrderDetail detail : details) {
            orderIds.addAll(orderDao.findAllByTypeAndItemIdAndState(OrderType.SELL.getValue(), detail.getItemId(),
                                                                    OrderState.CONFIRMED.getValue()));
        }
        if (!orderIds.isEmpty()) {
        	orderDao.updateOrdersState(OrderState.DELIVERED.getValue(), orderIds);
        }
    }

    public List<Order> listByType(final Date start, final Date end) {
        return orderDao.findAll(timeSpecific(start, end));
    }

    public List<Order> listByType(OrderType type) {
        return orderDao.findAllByType(type.getValue());
    }

    public List<Order> listByType(final OrderType type, final Date start, final Date end) {
        if (start == null) return null;
        return orderDao.findAll(new Specification<com.yongchang.b2b.persistence.entity.Order>() {

            @Override
            public Predicate toPredicate(Root<com.yongchang.b2b.persistence.entity.Order> r, CriteriaQuery<?> q,
                                         CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                // 添加日期查询,区间查询
                predicate.getExpressions().add(
                cb.between(r.<Date> get("createTime"), start, (end == null ? new Date() : end)));
                predicate.getExpressions().add(cb.equal(r.<Integer> get("type"), type.getValue()));
                return predicate;
            }
        });
    }

    public Page<Order> listByType(OrderType type, int page, int size) {
        return orderDao.findAllByType(type.getValue(), pageRequest(page, size, null));
    }

    public Page<Order> listByType(final OrderType type, final Date start, final Date end, int page, int size) {
        if (start == null) return null;
        return orderDao.findAll(new Specification<com.yongchang.b2b.persistence.entity.Order>() {

            @Override
            public Predicate toPredicate(Root<com.yongchang.b2b.persistence.entity.Order> r, CriteriaQuery<?> q,
                                         CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                // 添加日期查询,区间查询
                predicate.getExpressions().add(cb.between(r.<Date> get("createTime"), start,
                                                          (end == null ? new Date() : end)));
                predicate.getExpressions().add(cb.equal(r.<Integer> get("type"), type.getValue()));
                return predicate;
            }
        }, pageRequest(page, size, null));
    }

    public Page<Order> listByTypeAndUserId(OrderType type, Long userId, int page, int size) {
        return orderDao.findAllByTypeAndUserId(type.getValue(), userId, pageRequest(page, size, null));
    }

    public Page<Order> listByTypeAndUserId(final OrderType type, final Long userId, final Date start, final Date end,
                                           int page, int size) {
        return orderDao.findAll(new Specification<com.yongchang.b2b.persistence.entity.Order>() {

            @Override
            public Predicate toPredicate(Root<com.yongchang.b2b.persistence.entity.Order> r, CriteriaQuery<?> q,
                                         CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                // 添加日期查询,区间查询
                predicate.getExpressions().add(cb.between(r.<Date> get("createTime"), start,
                                                          (end == null ? new Date() : end)));
                predicate.getExpressions().add(cb.equal(r.<Integer> get("type"), type.getValue()));
                predicate.getExpressions().add(cb.equal(r.<Long> get("userId"), userId));
                return predicate;
            }
        }, pageRequest(page, size, null));
    }

    public List<Order> listByTypeAndUserId(OrderType type, Long userId) {
        return orderDao.findAllByTypeAndUserId(type.getValue(), userId);
    }

    public List<Order> listByTypeAndUserId(final OrderType type, final Long userId, final Date start, final Date end) {
        return orderDao.findAll(new Specification<com.yongchang.b2b.persistence.entity.Order>() {

            @Override
            public Predicate toPredicate(Root<com.yongchang.b2b.persistence.entity.Order> r, CriteriaQuery<?> q,
                                         CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                // 添加日期查询,区间查询
                predicate.getExpressions().add(
                cb.between(r.<Date> get("createTime"), start, (end == null ? new Date() : end)));
                predicate.getExpressions().add(cb.equal(r.<Integer> get("type"), type.getValue()));
                predicate.getExpressions().add(cb.equal(r.<Long> get("userId"), userId));
                return predicate;
            }
        });
    }

    public Page<Order> listByTypeAndItemUserId(OrderType type, Long itemUserId, int page, int size) {
        return orderDao.findAllByTypeAndItemUserId(type.getValue(), itemUserId, pageRequest(page, size, null));
    }

    public Page<Order> listByTypeAndItemUserId(OrderType type, Long itemUserId, Date start, Date end, int page, int size) {
        if (start == null) return null;
        return orderDao.findAllByTypeAndItemUserId(type.getValue(), itemUserId, start, end,
                                                   pageRequest(page, size, null));
    }

    public List<Order> listByTypeAndItemUserId(OrderType type, Long itemUserId) {
        return orderDao.findAllByTypeAndItemUserIdList(type.getValue(), itemUserId);
    }

    public List<Order> listByTypeAndItemUserId(OrderType type, Long itemUserId, Date start, Date end) {
        return orderDao.findAllByTypeAndItemUserIdList(type.getValue(), itemUserId, start, end);
    }

    /*
     * 今日订单
     */
    public Page<Order> listTodayByTypeAndUserId(OrderType type, Long userId, int page, int size) {
        Date date = new Date();
        try {
            date = DateFormatUtils.ISO_DATE_FORMAT.parse(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        // 创建时间>=今天00:00
        String sql = "select distinct o from  Order o " + "where o.type=:type and o.userId=:userId "
                     + "and o.createTime >=:createTime";
        javax.persistence.TypedQuery<Order> query = em.createQuery(sql, Order.class);
        query.setParameter("type", type.getValue());
        query.setParameter("userId", userId);
        query.setParameter("createTime", date);
        query.setFirstResult(page);
        query.setMaxResults(size);
        java.util.List<Order> ls = query.getResultList();
        System.out.println(ls.toString());
        return orderDao.findAllByTypeAndUserIdAndCreateTimeAfter(type.getValue(), userId, date,
                                                                 pageRequest(page, size, null));
    }

    /*
     * 历史订单
     */
    public Page<Order> listHistoryByTypeAndUserId(OrderType type, Long userId, int page, int size) {
        Date date = new Date();
        try {
            date = DateFormatUtils.ISO_DATE_FORMAT.parse(DateFormatUtils.format(new Date(), "yyyy-MM-dd"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        // 创建时间<今天00:00
        return orderDao.findAllByTypeAndUserIdAndCreateTimeBefore(type.getValue(), userId, date,
                                                                  pageRequest(page, size, null));
    }

    public void save(Order order) {
        orderDao.save(order);
    }

    // *************************************************************//
    public Page<Long> listGroupByItemId() {
        return orderDetailDao.findAllTop4(new PageRequest(0, 4));
    }

    public List<OrderDetail> listDetail(Long orderId) {
        if (orderId == null) return Collections.<OrderDetail> emptyList();
        return orderDetailDao.findAllByOrderId(orderId);
    }

    public Page<OrderDetail> listDetail(Long orderId, int page, int size) {
        if (orderId == null) return null;
        return orderDetailDao.findAllByOrderId(orderId, pageRequest(page, size, null));
    }

    public Page<OrderDetail> listDetailByItemSumId(Long itemSumId, int page, int size) {
        if (itemSumId == null) return null;
        ItemSum sum = itemSumDao.findOne(itemSumId);
        Date date = new Date();
        try {
            date = DateFormatUtils.ISO_DATE_FORMAT.parse(DateFormatUtils.format(sum.getCreateTime(), "yyyy-MM-dd"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return orderDetailDao.findAllByItemIdAndCreateTimeAfter(sum.getItemId(), date, pageRequest(page, size, null));
    }

    public OrderDetail orderDetail(Long id) {
        if (id == null) return null;
        return orderDetailDao.findOne(id);
    }

    public void save(OrderDetail orderDetail) {
        orderDetailDao.save(orderDetail);
    }

    public void delDetail(Long id) {
        if (id == null) return;
        orderDetailDao.delete(id);
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

    private Specification<com.yongchang.b2b.persistence.entity.Order> timeSpecific(final Date start, final Date end) {
        return new Specification<com.yongchang.b2b.persistence.entity.Order>() {

            @Override
            public Predicate toPredicate(Root<com.yongchang.b2b.persistence.entity.Order> r, CriteriaQuery<?> q,
                                         CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                // 添加日期查询,区间查询
                predicate.getExpressions().add(
                cb.between(r.<Date> get("createTime"), start, (end == null ? new Date() : end)));
                return predicate;
            }
        };
    }

    public List<OrderDetail> listDetailByType(final OrderType type, final Date start, final Date end) {
        if (start == null) return null;
        return orderDetailDao.findAll(new Specification<com.yongchang.b2b.persistence.entity.OrderDetail>() {

            @Override
            public Predicate toPredicate(Root<com.yongchang.b2b.persistence.entity.OrderDetail> r, CriteriaQuery<?> q,
                                         CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                // 添加日期查询,区间查询
                predicate.getExpressions().add(
                cb.between(r.<Date> get("createTime"), start, (end == null ? new Date() : end)));
                predicate.getExpressions().add(cb.equal(r.<Order> get("order").<Integer> get("type"), type.getValue()));
                return predicate;
            }
        });
    }

    public List<OrderDetail> listDetailByTypeAndUserId(final OrderType type, final Long userId, final Date start, final Date end) {
        return orderDetailDao.findAll(new Specification<com.yongchang.b2b.persistence.entity.OrderDetail>() {

            @Override
            public Predicate toPredicate(Root<com.yongchang.b2b.persistence.entity.OrderDetail> r, CriteriaQuery<?> q,
                                         CriteriaBuilder cb) {
                Predicate predicate = cb.conjunction();
                // 添加日期查询,区间查询
                predicate.getExpressions().add(
                cb.between(r.<Date> get("createTime"), start, (end == null ? new Date() : end)));
                predicate.getExpressions().add(cb.equal(r.<Order> get("order").<Integer> get("type"), type.getValue()));
                predicate.getExpressions().add(cb.equal(r.<Order> get("order").<Long> get("userId"), userId));
                return predicate;
            }
        });
    }
}
