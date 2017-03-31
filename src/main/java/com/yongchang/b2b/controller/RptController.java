/**
 * 
 */
package com.yongchang.b2b.controller;

import java.util.*;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.data.domain.Page;
import org.springframework.http.*;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.yongchang.b2b.cons.EnumCollections.ItemState;
import com.yongchang.b2b.cons.EnumCollections.ItemSumState;
import com.yongchang.b2b.cons.EnumCollections.OrderState;
import com.yongchang.b2b.cons.EnumCollections.OrderType;
import com.yongchang.b2b.cons.EnumCollections.UserType;
import com.yongchang.b2b.persistence.entity.*;

/**
 * 报表服务
 * 
 * @author zxc
 */
@Controller
@RequestMapping(value = "/admin/rpt")
@PreAuthorize("hasAuthority('ADMIN')")
public class RptController extends BaseController {

    // 每日汇总采购量列表报表(可以把每日汇总的蔬菜采购量列表导出，可以把每天的订单列表导出;把每天的item_sum导出来，这个是汇总每天的)
    @RequestMapping(value = "/itemSum", method = RequestMethod.GET)
    public ModelAndView itemSum(@RequestParam(value = "p", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        String sumDate = DateFormatUtils.format(new Date(), "yyyyMMdd");
        Page<ItemSum> itemSumList = itemService.getByStateNotAndSumDate(ItemSumState.CLOAED, sumDate, page, pagesize);
        return new ModelAndView("admin/rpt/itemSum")//
        .addObject("itemSumList", itemSumList);
    }

    @RequestMapping(value = "/itemSum", method = RequestMethod.POST)
    public ResponseEntity<byte[]> itemSum_export() throws Exception {
        String sumDate = DateFormatUtils.format(new Date(), "yyyyMMdd");
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "每日汇总采购量列表报表-" + sumDate + ".csv");
        String name = "每日汇总采购量列表报表-" + sumDate;
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        List<ItemSum> itemSumList = itemService.getByStateNotAndSumDate(ItemSumState.CLOAED, sumDate);

        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "编号", "商品名称", "需求量(千克)", "供应价格(元/千克)", "金额(元)", //
                "供应商", "汇总日期", "成本", "运费", "损耗", "利润", "状态" }, ",") + "\n");
        for (ItemSum itemSum : itemSumList) {
            try {
                sb.append(itemSum.getId() + ",");
                sb.append(itemSum.getItem().getTitle() + ",");
                sb.append(itemSum.getCount() + ",");
                if (itemSum.getItem() == null) continue;

                sb.append(float2formatPrice(itemSum.getItem().getItemFullPrice()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getItemFullPrice()) + ",");
                if (itemSum.getItem().getUser() != null) {
                    sb.append(itemSum.getItem().getUser().getCompany() + ",");
                } else {
                    sb.append(" ,");
                }
                sb.append(DateFormatUtils.format(itemSum.getCreateTime(), "yyyy-MM-dd HH:mm:ss") + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getItemPrice()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getFreight()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getLoss()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getPriceAddAmount()) + ",");
                sb.append(ItemState.get(itemSum.getState()).getName() + "\r\n");
            } catch (Exception e) {
                continue;
            }
        }
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    // 商品汇总信息报表 (可以按照日，月，季度，年周期，统计每种蔬菜的销量,金额,订单金额)
    @RequestMapping(value = "/item", method = RequestMethod.GET)
    public ModelAndView item(String start, String end) {
        Date startDate = genDay(start, -7);
        Date endDate = genDay(end, 0);

        List<ItemSum> itemSumList = itemService.itemSum(startDate, endDate);
        return new ModelAndView("admin/rpt/item")//
        .addObject("itemSumList", itemSumList)//
        .addObject("start", start)//
        .addObject("end", end);
    }

    @RequestMapping(value = "/item", method = RequestMethod.POST)
    public ResponseEntity<byte[]> item_export(String start, String end) throws Exception {
        Date startDate = genDay(start, -7);
        Date endDate = genDay(start, 0);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "商品汇总信息报表.csv");
        String name = "商品汇总信息报表";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        List<ItemSum> itemSumList = itemService.itemSum(startDate, endDate);
        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "编号", "商品名称", "需求量(千克)", "供应价格(元/千克)", "金额(元)",//
                "供应商", "汇总日期", "成本", "运费", "损耗", "利润", "状态" }, ",") + "\n");
        for (ItemSum itemSum : itemSumList) {
            if (itemSum == null || itemSum.getItem() == null) continue;
            try {
                sb.append(itemSum.getId() + ",");
                sb.append(itemSum.getItem().getTitle() + ",");
                sb.append(itemSum.getCount() + ",");

                sb.append(float2formatPrice(itemSum.getItem().getItemFullPrice()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getItemFullPrice()) + ",");
                if (itemSum.getItem().getUser() != null) {
                    sb.append(itemSum.getItem().getUser().getCompany() + ",");
                } else {
                    sb.append(" ,");
                }
                sb.append(itemSum.getSumDate() + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getItemPrice()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getFreight()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getLoss()) + ",");
                sb.append(float2formatPrice(itemSum.getCount() * itemSum.getItem().getPriceAddAmount()) + ",");
                sb.append(ItemState.get(itemSum.getState()).getName() + "\r\n");
            } catch (Exception e) {
                continue;
            }
        }
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    // 订单汇总信息报表(把每天的供应商订单明细列出来,用于跟供应商结算)
    @RequestMapping(value = "/order/supplier", method = RequestMethod.GET)
    public ModelAndView order_supplier(@RequestParam(value = "p", defaultValue = "1") int page,
                                       @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                       Long storeId, String start, String end) {
        Date startDate = genDay(start, -7);
        Date endDate = genDay(end, 0);

        Page<Order> orderList = null;
        if (storeId == null) {
            orderList = orderService.listByType(OrderType.BUY, startDate, endDate, page, pagesize);
        } else {
            orderList = orderService.listByTypeAndItemUserId(OrderType.BUY, storeId, startDate, endDate, page, pagesize);
        }

        // 全部供应商
        List<User> userList = userService.listUserByType(UserType.SUPPLIER);
        return new ModelAndView("admin/rpt/order")//
        .addObject("userList", userList)//
        .addObject("userType", "supplier")//
        .addObject("storeId", storeId)//
        .addObject("orderList", orderList)//
        .addObject("start", start)//
        .addObject("end", end);
    }

    @RequestMapping(value = "/order/supplier", method = RequestMethod.POST)
    public ResponseEntity<byte[]> order_export_supplier(Long storeId, String start, String end) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "供应商订单汇总信息报表.csv");
        String name = "供应商订单汇总信息报表";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        Date startDate = genDay(start, -7);
        Date endDate = genDay(end, 0);

        List<Order> orderList = new ArrayList<Order>();
        if (storeId == null) {
            orderList = orderService.listByType(OrderType.BUY, startDate, endDate);
        } else {
            orderList = orderService.listByTypeAndItemUserId(OrderType.BUY, storeId, startDate, endDate);
        }

        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "订单编号", "供应商", "订单金额", "下单时间", "状态" }, ",") + "\n");

        Float total = 0f;
        for (Order order : orderList) {
            try {
                sb.append(order.getOrderNum() + ",");
                if (order.getDetails() != null) {
                    Iterator<OrderDetail> iterator = order.getDetails().iterator();
                    sb.append(iterator.hasNext() ? iterator.next().getItemUser().getCompany() + "," : " ,");
                } else {
                    sb.append(" ,");
                }
                sb.append(float2formatPrice(order.getOrderPrice()) + ",");
                total += order.getOrderPrice();
                sb.append(DateFormatUtils.format(order.getCreateTime(), "yyyy-MM-dd HH:mm:ss") + ",");
                sb.append(OrderState.get(order.getState()).getName() + "\r\n");
            } catch (Exception e) {
                continue;
            }
        }
        sb.append(" , , , , \r\n");
        sb.append(" ,金额合计: ," + float2formatPrice(total) + " , , \r\n");
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    // 订单汇总信息报表(把每天的采购商订单明细列出来,用于跟采购商结算)
    @RequestMapping(value = "/order/buyer", method = RequestMethod.GET)
    public ModelAndView order_buyer(@RequestParam(value = "p", defaultValue = "1") int page,
                                    @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                    Long storeId, String start, String end) {
        Date startDate = genDay(start, -7);
        Date endDate = genDay(end, 0);

        Page<Order> orderList = null;
        if (storeId == null) {
            orderList = orderService.listByType(OrderType.SELL, startDate, endDate, page, pagesize);
        } else {
            orderList = orderService.listByTypeAndUserId(OrderType.SELL, storeId, startDate, endDate, page, pagesize);
        }

        // 全部采购商
        List<User> userList = userService.listUserByType(UserType.BUYER);
        return new ModelAndView("admin/rpt/order")//
        .addObject("userList", userList)//
        .addObject("userType", "buyer")//
        .addObject("storeId", storeId)//
        .addObject("orderList", orderList)//
        .addObject("start", start)//
        .addObject("end", end);
    }

    @RequestMapping(value = "/order/buyer", method = RequestMethod.POST)
    public ResponseEntity<byte[]> order_export_buyer(Long storeId, String start, String end) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "订单汇总信息报表.csv");
        String name = "采购商订单汇总信息报表";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        Date startDate = genDay(start, -7);
        Date endDate = genDay(end, 0);

        List<Order> orderList = new ArrayList<Order>();
        if (storeId == null) {
            orderList = orderService.listByType(OrderType.SELL, startDate, endDate);
        } else {
            orderList = orderService.listByTypeAndUserId(OrderType.SELL, storeId, startDate, endDate);
        }

        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "订单编号", "采购商", "订单金额", "下单时间", "状态" }, ",") + "\n");

        Float total = 0f;
        for (Order order : orderList) {
            try {
                sb.append(order.getOrderNum() + ",");
                if (order.getUser() != null) {
                    sb.append(order.getUser().getCompany() + ",");
                } else {
                    sb.append(" ,");
                }
                sb.append(float2formatPrice(order.getOrderPrice()) + ",");
                total += order.getOrderPrice();
                sb.append(DateFormatUtils.format(order.getCreateTime(), "yyyy-MM-dd HH:mm:ss") + ",");
                sb.append(OrderState.get(order.getState()).getName() + "\r\n");
            } catch (Exception e) {
                _.error("order_export_buyer error!", e);
                continue;
            }
        }
        sb.append(" , , , , \r\n");
        sb.append(" ,金额合计: ," + float2formatPrice(total) + " , , \r\n");
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    // 导出所有采购商品详情Excel
    @RequestMapping(value = "/order/buyer/itemsum", method = RequestMethod.POST)
    public ResponseEntity<byte[]> itemsum_export_buyer(Long storeId, String start, String end) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "采购商品详情报表.csv");
        String name = "采购商品详情报表";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        Date startDate = genDay(start, -7);
        Date endDate = genDay(end, 0);

        List<OrderDetail> detailList = new ArrayList<OrderDetail>();
        if (storeId != null) {
            detailList = orderService.listDetailByTypeAndUserId(OrderType.SELL, storeId, startDate, endDate);
        } else {
            detailList = orderService.listDetailByType(OrderType.SELL, startDate, endDate);
        }

        HashMap<Long, User> userMap = new HashMap<Long, User>();
        HashMap<Long, Item> itemMap = new HashMap<Long, Item>();
        StringBuilder sb = new StringBuilder();
        sb.append(StringUtils.join(new String[] { "采购商", "商品名称", "采购量(千克)", "采购价格(元/千克)", "销售额", //
                "供应商", "下单日期", "订单状态" }, ",") + "\n");
        for (OrderDetail detail : detailList) {
            try {
                Order order = detail.getOrder();
                User buyer = userMap.get(order.getUserId());
                if (buyer == null) {
                    buyer = order.getUser();
                    userMap.put(order.getUserId(), buyer);
                }
                Item item = itemMap.get(detail.getItemId());
                if (item == null) {
                    item = detail.getItem();
                    itemMap.put(detail.getItemId(), item);
                }
                User supplier = userMap.get(item.getUserId());
                if (supplier == null) {
                    supplier = item.getUser();
                    userMap.put(item.getUserId(), supplier);
                }

                sb.append(buyer.getCompany() + ",");
                sb.append(item.getTitle() + ",");
                sb.append(detail.getCount() + ",");
                sb.append(float2formatPrice(detail.getPrice()) + ",");
                sb.append(float2formatPrice(detail.getAmount()) + ",");
                sb.append(supplier.getCompany() + ",");
                sb.append(DateFormatUtils.format(detail.getCreateTime(), "yyyy-MM-dd HH:mm:ss") + ",");
                sb.append(OrderState.get(order.getState()).getName() + "\r\n");
            } catch (Exception e) {
                _.error("itemsum_export_buyer error!", e);
                continue;
            }
        }

        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }

    // **************************************************************************************//
    // 订单详情
    @RequestMapping(value = "/order/detail/{userType}/{orderId}", method = RequestMethod.GET)
    public ModelAndView order_detail(@PathVariable("orderId") Long orderId, @PathVariable("userType") String userType) {
        List<OrderDetail> detailList = orderService.listDetail(orderId);

        return new ModelAndView("admin/rpt/orderDetail")//
        .addObject("userType", userType)//
        .addObject("orderId", orderId)//
        .addObject("detailList", detailList);
    }

    @RequestMapping(value = "/order/detail/{userType}/{orderId}", method = RequestMethod.POST)
    public ResponseEntity<byte[]> order_export_detail(@PathVariable("userType") String userType,
                                                      @PathVariable("orderId") Long orderId) throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "订单汇总信息报表.csv");
        String name = "订单详情信息报表";
        name = new String(name.getBytes(), "ISO8859-1");
        headers.set("content-disposition", "attachment;filename=" + name + ".csv");

        List<OrderDetail> detailList = orderService.listDetail(orderId);

        StringBuilder sb = new StringBuilder();
        if (StringUtils.equals("buyer", userType)) {
            sb.append(StringUtils.join(new String[] { "采购商名称", "商品名称", "采购价格", "重量", "金额", "日期" }, ",") + "\n");
        } else {
            sb.append(StringUtils.join(new String[] { "供应商名称", "商品名称", "供应价格", "重量", "金额", "日期" }, ",") + "\n");
        }

        Float total = 0f;
        for (OrderDetail detail : detailList) {
            try {
                if (StringUtils.equals("buyer", userType)) {
                    sb.append(detail.getOrder().getUser().getCompany() + ",");
                } else {
                    sb.append(detail.getItemUser().getCompany() + ",");
                }
                sb.append(detail.getItem().getTitle() + ",");
                sb.append(float2formatPrice(detail.getPrice()) + ",");
                sb.append(float2formatPrice(detail.getCount()) + ",");
                sb.append(float2formatPrice(detail.getAmount()) + ",");
                total += detail.getAmount();
                sb.append(DateFormatUtils.format(detail.getCreateTime(), "yyyy-MM-dd HH:mm:ss") + "\r\n");
            } catch (Exception e) {
                _.error("order_export_detail error!", e);
                continue;
            }
        }
        sb.append(" , , , , , , \r\n");
        sb.append(" , , ,金额合计: ," + float2formatPrice(total) + ", , \r\n");
        return new ResponseEntity<byte[]>(sb.toString().getBytes(), headers, HttpStatus.CREATED);
    }
}
