package com.yongchang.b2b.controller;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.data.domain.Page;
import org.springframework.http.*;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.yongchang.b2b.cons.EnumCollections.OrderState;
import com.yongchang.b2b.cons.EnumCollections.OrderType;
import com.yongchang.b2b.persistence.entity.*;
import com.yongchang.b2b.support.JsonResult;

/**
 * 供货商
 * 
 * @author zxc Jun 15, 2016 11:26:12 AM
 */
@Controller
@RequestMapping(value = "/supplier")
@PreAuthorize("hasAuthority('SUPPLIER')")
public class SupplierController extends BaseController {

    // 供货列表
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "p", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Item> itemList = itemService.listItemBySupplier(userId(), page, pagesize);
        return new ModelAndView("supplier/list")//
        .addObject("itemList", itemList);
    }

    // 商品详情
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ModelAndView item(@PathVariable("id") Long id) {
        Item item = itemService.item(id);
        return new ModelAndView("supplier/item")//
        .addObject("item", item);
    }

    // 发布供货商品
    @RequestMapping(value = "/item/publish", method = RequestMethod.GET)
    public ModelAndView itemForm(@ModelAttribute Item item, Model model) {
        return new ModelAndView("supplier/itemEdit");
    }

    // 编辑供货商品
    @RequestMapping(value = "/item/edit/{id}", method = RequestMethod.GET)
    public ModelAndView itemUpdate(@PathVariable(value = "id") Long id) {
        Item item = itemService.item(id);
        return new ModelAndView("supplier/itemEdit")//
        .addObject("item", item);
    }

    @RequestMapping(value = "/item/edit/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult code_del(@PathVariable(value = "id") Long id) {
        Item item = itemService.item(id);
        if (item == null) return fail("删除失败");
        itemService.del(id);
        return ok("删除成功");
    }

    // 保存供货商品
    @RequestMapping(value = "/item/save", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult itemCreate(Item item) {
        if (item == null) return ok("创建失败");
        item.setUserId(userId());
        item.setItemPrice(item.getItemPrice());
        Long productId = item.getProductId();
        if (productId != null && item.getId() == null) {
            Product product = productService.product(productId);
            if (product != null) {
                item.setFreight(product.getFreight() == null ? 0f : product.getFreight());
                item.setLoss(product.getLoss() == null ? 0f : product.getLoss());
                item.setPriceAddAmount(product.getPriceAddAmount() == null ? 0f : product.getPriceAddAmount());
            }
        }
        item.setFreight(item.getFreight() == null ? 0f : item.getFreight());
        item.setLoss(item.getLoss() == null ? 0f : item.getLoss());
        item.setPriceAddAmount(item.getPriceAddAmount() == null ? 0f : item.getPriceAddAmount());
        itemService.save(item);
        return ok("创建成功");
    }

    // 暂停供货商品
    @RequestMapping(value = "/item/modify", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult itemModify(Long itemId, Integer state) {
        Item item = itemService.item(itemId);
        if (item == null) return fail("修改失败");
        item.setState(state);
        itemService.save(item);
        return ok("修改成功");
    }

    // 供货订单列表
    @RequestMapping(value = "/order", method = RequestMethod.GET)
    public ModelAndView order(@RequestParam(value = "p", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Order> orderList = orderService.listByTypeAndItemUserId(OrderType.BUY, userId(), page, pagesize);
        return new ModelAndView("supplier/order")//
        .addObject("orderList", orderList);
    }

    // 我的订单列表,历史订单
    @RequestMapping(value = "/order/history", method = RequestMethod.GET)
    public ModelAndView order_history(@RequestParam(value = "p", defaultValue = "1") int page,
                                      @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Order> orderList = orderService.listByTypeAndItemUserId(OrderType.BUY, userId(), page, pagesize);
        return new ModelAndView("supplier/order")//
        .addObject("orderList", orderList);
    }

    @RequestMapping(value = "/order/history", method = RequestMethod.POST)
    public ResponseEntity<byte[]> order_export() throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "我的订单导出.csv");
        String name = "我的订单导出";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        List<Order> orderList = orderService.listByTypeAndItemUserId(OrderType.BUY, userId());
        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "编号", "订单金额", "下单时间", "状态" }, ",") + "\n");
        for (Order order : orderList) {
            sb.append(order.getId() + ",");
            sb.append(order.getOrderPrice() + ",");
            sb.append(DateFormatUtils.format(order.getCreateTime(), "yyyy-MM-dd HH:mm:ss") + ",");
            sb.append(OrderState.get(order.getState()).getName() + "\r\n");
        }
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/order/detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@RequestParam(value = "p", defaultValue = "1") int page,
                               @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                               @PathVariable(value = "id") Long orderId) {
        Page<OrderDetail> detailList = orderService.listDetail(orderId, page, pagesize);
        return new ModelAndView("supplier/detail")//
        .addObject("detailList", detailList)//
        .addObject("orderId", orderId);
    }

    @RequestMapping(value = "/order/detail/{orderId}", method = RequestMethod.POST)
    public ResponseEntity<byte[]> order_export_detail(@PathVariable("orderId") Long orderId) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "订单汇总信息报表.csv");
        String name = "订单汇总信息报表";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        List<OrderDetail> detailList = orderService.listDetail(orderId);

        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "商品类别", "商品名称", "价格(元/千克)", "供应量(千克)", "小计金额", "日期" }, ",") + "\n");

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

    @RequestMapping(value = "/order/confirm", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult orderConfirm(Long orderId) {
        if (orderId == null) return fail("确认失败");
        try {
            orderService.orderConfirm(orderId);
        } catch (Exception e) {
            return fail("确认失败");
        }
        return ok("确认成功");
    }

    @RequestMapping(value = "/order/deliver", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult orderDeliver(Long orderId) {
        if (orderId == null) return fail("发货失败");
        try {
            orderService.orderDeliver(orderId);
        } catch (Exception e) {
            return fail("发货失败");
        }
        return ok("发货成功");
    }

    // 需求列表
    @RequestMapping(value = "/require", method = RequestMethod.GET)
    public ModelAndView require(@RequestParam(value = "p", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Require> requireList = requireService.listRequire(page, pagesize);
        return new ModelAndView("supplier/require")//
        .addObject("requireList", requireList);
    }

    // 竞标列表
    @RequestMapping(value = "/require/bid", method = RequestMethod.GET)
    public ModelAndView bid(@RequestParam(value = "p", defaultValue = "1") int page,
                            @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Bid> bidList = requireService.listBidByUserId(userId(), page, pagesize);
        return new ModelAndView("supplier/bid")//
        .addObject("bidList", bidList);
    }

    // 需求竞标编辑
    @RequestMapping(value = "/require/bid/{requireId}", method = RequestMethod.GET)
    public ModelAndView bidEdit(@PathVariable(value = "requireId") Long requireId) {
        Require require = requireService.require(requireId);
        return new ModelAndView("supplier/bidEdit")//
        .addObject("require", require)//
        .addObject("requireId", requireId);
    }

    // 提交需求竞标
    @RequestMapping(value = "/require/bid", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult bid(Bid bid) {
        if (bid == null) return fail("创建失败");
        if (bid.getRequireId() == null) return fail("参数错误");
        Require require = requireService.require(bid.getRequireId());
        if (require == null) return fail("参数错误");
        if (require.getDeadlineTime().getTime() <= new Date().getTime()) return fail("竞标截止时间过期了");

        bid.setUserId(userId());
        requireService.save(bid);
        return ok("竞标申请成功");
    }

    @RequestMapping(value = "/require/bid/del/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult bid_del(@PathVariable(value = "id") Long id) {
        Bid bid = requireService.bid(id);
        if (bid == null) return fail("删除失败");
        requireService.delBid(id);
        return ok("删除成功");
    }
}
