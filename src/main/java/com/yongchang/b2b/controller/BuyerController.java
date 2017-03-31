package com.yongchang.b2b.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.data.domain.Page;
import org.springframework.http.*;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.Lists;
import com.yongchang.b2b.cons.EnumCollections.CartState;
import com.yongchang.b2b.cons.EnumCollections.ItemState;
import com.yongchang.b2b.cons.EnumCollections.ItemSumState;
import com.yongchang.b2b.cons.EnumCollections.OrderState;
import com.yongchang.b2b.cons.EnumCollections.OrderType;
import com.yongchang.b2b.persistence.entity.*;
import com.yongchang.b2b.support.JsonResult;

/**
 * 采购商
 * 
 * @author zxc Jun 15, 2016 11:26:12 AM
 */
@Controller
@RequestMapping(value = "/buyer")
@PreAuthorize("hasAuthority('BUYER')")
public class BuyerController extends BaseController {

    // 商品列表
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "p", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize, Long categoryId,
                             String keyword) {
        keyword = StringUtils.trim(keyword);
        Page<Item> itemList = null;
        Category category = null;
        if (categoryId != null) category = categoryService.category(categoryId);
        itemList = itemService.listItem(ItemState.NORMAL, categoryId, keyword, page, pagesize);

        return new ModelAndView("buyer/list")//
        .addObject("categoryId", categoryId)//
        .addObject("category", category)//
        .addObject("keyword", keyword)//
        .addObject("size", pagesize)//
        .addObject("itemList", itemList);
    }

    @RequestMapping(value = "/list/export", method = RequestMethod.POST)
    public ResponseEntity<byte[]> list_export(Long categoryId, String keyword) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "供货信息列表导出.csv");
        String name = "供货信息列表导出";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        List<Item> itemList = Lists.newArrayList();
        if (categoryId != null || StringUtils.isNotEmpty(keyword)) {
            itemList = itemService.listItem(ItemState.NORMAL, categoryId, keyword);
        } else {
            itemList = itemService.listItemByState(ItemState.NORMAL);
        }
        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "商品类别", "商品名称", "供货标题", "价格(元/千克)", "供应量(千克)" }, ",") + "\n");

        for (Item detail : itemList) {
            try {
                sb.append(detail.getProduct().getCategory().getName() + ",");
                sb.append(detail.getProduct().getTitle() + ",");
                sb.append(detail.getTitle() + ",");
                sb.append(float2formatPrice(detail.getItemPrice() + detail.getPriceAddAmount() //
                                            + detail.getFreight() + detail.getLoss()) + ",");
                sb.append(float2formatPrice(detail.getCount()) + "\r\n");
            } catch (Exception e) {
                continue;// 忽略空指针
            }
        }
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    // 商品详情
    @RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
    public ModelAndView view(@PathVariable Long id) {
        Item item = itemService.item(id);
        return new ModelAndView("buyer/view")//
        .addObject("item", item);
    }

    // 购物车列表
    @RequestMapping(value = "/cart", method = RequestMethod.GET)
    public ModelAndView require(@RequestParam(value = "p", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Cart> cartList = orderService.listCartByUserIdAndState(userId(), CartState.NO_ORDER, page, pagesize);
        return new ModelAndView("buyer/cart")//
        .addObject("cartList", cartList);
    }

    // 加入购物车
    @RequestMapping(value = "/cart", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult cart_add(Long itemId, Float count) {
        Item item = itemService.item(itemId);
        if (item == null) return fail("商品不存在");
        Product product = item.getProduct();
        if (product == null) return fail("关联产品已下架");

        float realPrice = item.getItemPrice() + item.getPriceAddAmount() + item.getFreight() + item.getLoss();
        orderService.save(new Cart(itemId, userId(), count, realPrice * count));
        return ok("成功");
    }

    // 移出购物车
    @RequestMapping(value = "/cart/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult cart_del(@PathVariable Long id) {
        Cart cart = orderService.cart(id);
        if (cart == null) return fail("删除失败");
        orderService.delCart(id);
        return ok("删除成功");
    }

    // 采购订单列表
    @RequestMapping(value = "/order", method = RequestMethod.GET)
    public ModelAndView order(@RequestParam(value = "p", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = "10") int pagesize) {
        Page<Order> orderList = orderService.listTodayByTypeAndUserId(OrderType.SELL, userId(), page, pagesize);
        return new ModelAndView("buyer/order")//
        .addObject("orderList", orderList);
    }

    // 删除订单
    @RequestMapping(value = "/order/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult order_del(@PathVariable Long id) {
        Order order = orderService.order(id);
        if (order == null) return fail("删除失败");
        orderService.delorder(id);
        return ok("删除成功");
    }

    // 历史订单
    @RequestMapping(value = "/order/history", method = RequestMethod.GET)
    public ModelAndView order_history(@RequestParam(value = "p", defaultValue = "1") int page,
                                      @RequestParam(value = "size", defaultValue = "10") int pagesize) {
        Page<Order> orderList = orderService.listHistoryByTypeAndUserId(OrderType.SELL, userId(), page, pagesize);
        return new ModelAndView("buyer/order")//
        .addObject("orderList", orderList);
    }

    // 查看订单详情分页
    @RequestMapping(value = "/order/detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable(value = "id") Long orderId) {
        List<OrderDetail> detailList = orderService.listDetail(orderId);
        Order order = orderService.order(orderId);
        return new ModelAndView("buyer/detail")//
        .addObject("detailList", detailList)//
        .addObject("order", order)//
        .addObject("orderId", order.getId());
    }

    @RequestMapping(value = "/order/detail/{orderId}", method = RequestMethod.POST)
    public ResponseEntity<byte[]> order_export_detail(@PathVariable("orderId") Long orderId) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "订单详情信息报表.csv");
        String name = "订单详情信息报表";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        List<OrderDetail> detailList = orderService.listDetail(orderId);

        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "商品类别", "商品名称", "价格(元/千克)", "采购量(千克)", "小计金额", "日期" }, ",") + "\n");

        Float total = 0f;
        for (OrderDetail detail : detailList) {
            try {
                sb.append(detail.getItem().getProduct().getCategory().getName() + ",");
                sb.append(detail.getItem().getTitle() + ",");
                sb.append(float2formatPrice(detail.getPrice()) + ",");
                sb.append(float2formatPrice(detail.getCount()) + ",");
                sb.append(float2formatPrice(detail.getAmount()) + ",");
                total += detail.getAmount();
                sb.append(DateFormatUtils.format(detail.getCreateTime(), "yyyy-MM-dd HH:mm:ss") + "\r\n");
            } catch (Exception e) {
                // 忽略空指针
                continue;
            }
        }
        sb.append(" , , , ," + float2formatPrice(total) + ", \r\n");
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    // 删除订单
    @RequestMapping(value = "/order/detail/del/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult detail_del(@PathVariable Long id) {
        OrderDetail orderDetail = orderService.orderDetail(id);
        if (orderDetail == null) return fail("删除失败");
        orderService.delDetail(id);
        return ok("删除成功");
    }

    // 生成订单
    @RequestMapping(value = "/order", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult order(@RequestBody List<Map<String, Object>> carts) {
        if (carts == null || carts.size() == 0) return fail("购物车为空");

        String sumDate = DateFormatUtils.format(new Date(), "yyyyMMdd");
        Order order = new Order(userId(), OrderType.SELL, OrderState.NORMAL);
        orderService.save(order);

        float totalAmount = 0;
        for (Map<String, Object> cart : carts) {
            Long cartId = Long.parseLong((String) cart.get("id"));
            Float count = Float.parseFloat((String) cart.get("count"));

            Cart _cart = orderService.cart(cartId);
            if (_cart == null) continue;
            Long itemId = _cart.getItem().getId();
            _cart.setState(CartState.ORDER.getValue());
            orderService.delCart(cartId);

            Item item = _cart.getItem();
            OrderDetail orderDetail = new OrderDetail(itemId, order.getId(), count, item.getItemFullPrice(),
                                                      item.getItemFullPrice() * count, item.getUserId());
            orderService.save(orderDetail);
            totalAmount += orderDetail.getAmount();

            // 增加当天该供货信息的采购量
            ItemSum itemSum = itemService.getByItemIdAndSumDate(itemId, sumDate);
            if (itemSum == null) itemSum = new ItemSum(sumDate, itemId);
            itemSum.setCount(count + itemSum.getCount());
            itemSum.setState(ItemSumState.NONE.getValue());
            itemService.save(itemSum);

            // 扣减该供货信息的相应供货量
            item.setCount(item.getCount() - count < 0 ? 0 : item.getCount() - count);
            itemService.save(item);
        }
        order.setOrderPrice(totalAmount);
        orderService.save(order);

        return ok("成功");
    }

    // 采购订单付款
    @RequestMapping(value = "/order/pay", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult pay(Order orderForm) {
        if (orderForm == null) return fail("付款失败");
        Order order = orderService.order(orderForm.getId());
        order.setPayState(1);
        order.setPayTime(new Date());
        orderService.save(order);
        return ok("付款成功");
    }

    @RequestMapping(value = "/order/cancel/{orderId}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult order_cancel(@PathVariable(value = "orderId") Long orderId) {
        Order order = orderService.order(orderId);
        if (order == null) return fail("订单不存在");
        order.setState(OrderState.CANCEL.getValue());// 取消订单
        orderService.save(order);

        for (OrderDetail orderDetail : order.getDetails()) {
            Item item = orderDetail.getItem();
            if (item == null) continue;
            String sumDate = DateFormatUtils.format(new Date(), "yyyyMMdd");
            ItemSum itemSum = itemService.getByItemIdAndSumDate(item.getId(), sumDate);
            if (itemSum == null) itemSum = new ItemSum(sumDate, item.getId());
            Float count = (itemSum.getCount() - orderDetail.getCount()) < 0 ? 0 : (itemSum.getCount() - orderDetail.getCount());
            itemSum.setCount(count);
            if (count <= 0) itemSum.setState(ItemSumState.CLOAED.getValue());
            itemService.save(itemSum);
        }
        return ok("成功");
    }
}
