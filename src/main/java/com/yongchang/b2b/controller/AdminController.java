package com.yongchang.b2b.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yongchang.b2b.cons.*;
import com.yongchang.b2b.cons.EnumCollections.ItemState;
import com.yongchang.b2b.cons.EnumCollections.ItemSumState;
import com.yongchang.b2b.cons.EnumCollections.OrderState;
import com.yongchang.b2b.cons.EnumCollections.OrderType;
import com.yongchang.b2b.cons.EnumCollections.UserType;
import com.yongchang.b2b.persistence.entity.*;
import com.yongchang.b2b.support.JsonResult;

/**
 * 运营平台
 * 
 * @author zxc Jun 15, 2016 11:21:27 AM
 */
@Controller
@RequestMapping(value = "/admin")
@PreAuthorize("hasAuthority('ADMIN')")
public class AdminController extends BaseController {

    @Value("${resource.json}")
    private String resourceJsonStr;

    // 平台员工管理
    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public ModelAndView user(@RequestParam(value = "p", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<User> userList = userService.listUserByType(UserType.ADMIN, page, pagesize);
        return new ModelAndView("admin/sys/user")//
        .addObject("userList", userList);
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    public ModelAndView user_edit(@PathVariable(value = "id") Long id) {
        User user = userService.getUser(id);
        List<Role> roleList = userService.listRole();
        return new ModelAndView("admin/sys/userEdit")//
        .addObject("user", user)//
        .addObject("roleList", roleList);
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult user_del(@PathVariable(value = "id") Long id) {
        User user = userService.getUser(id);
        if (user == null) return fail("删除失败");
        userService.delUser(id);
        return ok("删除成功");
    }

    @RequestMapping(value = "/user", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult user(User user) {
        if (user == null) return fail("创建失败");
        if (StringUtils.isEmpty(user.getEmail()) || StringUtils.isEmpty(user.getPasswd())) return fail("参数错误");
        if (user.getId() == null) {
            User _user = userService.getUserByEmail(user.getEmail());
            if (_user != null && _user.getId() == user.getId()) return fail("员工已存在");
        }
        user.setPasswd(bCryptPasswordEncoder.encode(StringUtils.trim(user.getPasswd())));
        user.setType(EnumCollections.UserType.get(user.getType()).getValue());
        userService.save(user);
        return ok("成功");
    }

    @RequestMapping(value = "/role", method = RequestMethod.GET)
    public ModelAndView role() {
        List<Role> roleList = userService.listRole();
        JSONArray jsonarray = JSON.parseArray(resourceJsonStr);
        Map<String, String> map = Maps.newHashMap();
        for (Object json : jsonarray) {
            JSONObject _json = (JSONObject) json;
            map.put(_json.getString("link"), _json.getString("title"));
            JSONArray child = _json.getJSONArray("child");
            if (child != null) {
                for (Object childjson : child) {
                    JSONObject _childjson = (JSONObject) childjson;
                    map.put(_childjson.getString("link"), _childjson.getString("title"));
                }
            }
        }
        return new ModelAndView("admin/sys/role")//
        .addObject("roleList", roleList)//
        .addObject("map", map);
    }

    @RequestMapping(value = "/role/{id}", method = RequestMethod.GET)
    public ModelAndView role_edit(@PathVariable(value = "id") Long id) {
        Role role = userService.getRole(id);
        JSONArray jsonarray = JSON.parseArray(resourceJsonStr);
        return new ModelAndView("admin/sys/roleEdit")//
        .addObject("role", role)//
        .addObject("resourceJson", jsonarray);
    }

    @RequestMapping(value = "/role/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult role_del(@PathVariable(value = "id") Long id) {
        Role role = userService.getRole(id);
        if (role == null) return fail("删除失败");
        userService.delRole(id);
        return ok("删除成功");
    }

    @RequestMapping(value = "/role", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult role(Role role) {
        if (role == null) return fail("创建失败");
        if (role.getId() != null) {
            Role _role = userService.getRole(role.getId());
            _role.setName(role.getName());
            _role.setResource(role.getResource());
            _role.setState(role.getState());
            userService.save(_role);
        } else {
            userService.save(role);
        }
        return ok("成功");
    }

    // 平台店铺管理
    @RequestMapping(value = "/buyer", method = RequestMethod.GET)
    public ModelAndView buyer(@RequestParam(value = "p", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<User> userList = userService.listUserByType(UserType.BUYER, page, pagesize);
        return new ModelAndView("admin/store/buyer")//
        .addObject("userList", userList);
    }

    @RequestMapping(value = "/supplier", method = RequestMethod.GET)
    public ModelAndView supplier(@RequestParam(value = "p", defaultValue = "1") int page,
                                 @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<User> userList = userService.listUserByType(UserType.SUPPLIER, page, pagesize);
        return new ModelAndView("admin/store/supplier")//
        .addObject("userList", userList);
    }

    @RequestMapping(value = "/supplierItem/{userId}", method = RequestMethod.GET)
    public ModelAndView supplierItem(@RequestParam(value = "p", defaultValue = "1") int page,
                                     @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                     @PathVariable(value = "userId") Long userId) {
        Page<Item> itemList = null;
        if (userId != null && userId > 0) {
            itemList = itemService.listItemBySupplier(userId, page, pagesize);
        } else {
            itemList = itemService.listItem(page, pagesize);
        }
        return new ModelAndView("admin/store/supplierItem")//
        .addObject("itemList", itemList)//
        .addObject("userId", userId);
    }

    // 商品详情
    @RequestMapping(value = "/item/view/{id}", method = RequestMethod.GET)
    public ModelAndView view(@PathVariable Long id) {
        Item item = itemService.item(id);
        return new ModelAndView("admin/store/view")//
        .addObject("item", item);
    }

    @RequestMapping(value = "/item/view/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult viewModify(@PathVariable Long id, Item item) {
        Item _item = itemService.item(id);
        if (_item == null) return fail("修改失败");
        if (item != null) {
            _item.setImg(item.getImg());
            _item.setTitle(item.getTitle());
            _item.setItemPrice(item.getItemPrice());
            _item.setCount(item.getCount());
            _item.setDetail(item.getDetail());
            _item.setComment(item.getComment());
            _item.setState(item.getState());
        }
        // 审核通过,设置理由为空
        if (_item.getState() == 1) {
            _item.setDescription("");
        }
        itemService.save(_item);
        return ok("修改成功");
    }

    @RequestMapping(value = "/item/viewUpdate/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult viewUpdate(@PathVariable Long id, Item item) {
        Item _item = itemService.item(id);
        if (_item == null) return fail("修改失败");
        if (item != null) {
            _item.setState(item.getState());
            _item.setComment(item.getComment());
            if (item.getPriceAddAmount() != null) _item.setPriceAddAmount(item.getPriceAddAmount());
            if (item.getFreight() != null) _item.setFreight(item.getFreight());
            if (item.getLoss() != null) _item.setLoss(item.getLoss());
        }
        // 审核通过,设置理由为空
        if (_item.getState() == 1) _item.setDescription("");
        itemService.save(_item);
        return ok("修改成功");
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

    // 首页轮播
    @RequestMapping(value = "/item/showcase", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult itemShowcase(Long itemId, Integer state) {
        Item item = itemService.item(itemId);
        if (item == null) return fail("修改失败");
        item.setShowcase(state);
        itemService.save(item);
        return ok("修改成功");
    }

    @RequestMapping(value = "/supplierStore", method = RequestMethod.GET)
    public ModelAndView supplier_store(@RequestParam(value = "p", defaultValue = "1") int page,
                                       @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<User> userList = userService.listUserByType(UserType.SUPPLIER, page, pagesize);
        return new ModelAndView("admin/store/supplierStore")//
        .addObject("userList", userList);
    }

    @RequestMapping(value = "/store/{id}", method = RequestMethod.GET)
    public ModelAndView storeEdit(@PathVariable(value = "id") Long id, String type) {
        User user = userService.getUser(id);
        if (user != null) type = user.getTypeStr();
        return new ModelAndView("admin/store/store")//
        .addObject("user", user)//
        .addObject("storeType", type);
    }

    @RequestMapping(value = "/store", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult store(User user) {
        if (user == null) return fail("创建失败");
        if (StringUtils.isEmpty(user.getEmail()) || StringUtils.isEmpty(user.getPasswd())) return fail("参数错误");
        if (user.getId() == null) {
            User _user = userService.getUserByEmail(user.getEmail());
            if (_user != null && _user.getId() == user.getId()) return fail("用户已存在");
        }
        user.setPasswd(bCryptPasswordEncoder.encode(StringUtils.trim(user.getPasswd())));
        user.setType(EnumCollections.UserType.get(user.getType()).getValue());
        userService.save(user);
        return ok("保存成功");
    }

    @RequestMapping(value = "/store/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult store_del(@PathVariable(value = "id") Long id) {
        User user = userService.getUser(id);
        if (user == null) return fail("删除失败");
        userService.delUser(id);
        return ok("删除成功");
    }

    // 认证码管理
    @RequestMapping(value = "/code", method = RequestMethod.GET)
    public ModelAndView code(@RequestParam(value = "p", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Code> codeList = userService.listCode(page, pagesize);
        return new ModelAndView("admin/store/code")//
        .addObject("codeList", codeList);
    }

    @RequestMapping(value = "/code/{id}", method = RequestMethod.GET)
    public ModelAndView code_edit(@PathVariable(value = "id") Long id) {
        Code code = userService.getCode(id);
        return new ModelAndView("admin/store/codeEdit")//
        .addObject("code", code);
    }

    @RequestMapping(value = "/code/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult code_del(@PathVariable(value = "id") Long id) {
        Code code = userService.getCode(id);
        if (code == null) return fail("删除失败");
        userService.delCode(id);
        return ok("删除成功");
    }

    @RequestMapping(value = "/code", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult code(Code code) {
        if (code == null) return fail("创建失败");
        code.setCode(RandomStringUtils.randomAlphanumeric(6));
        userService.save(code);
        return ok("创建成功");
    }

    // 商品类目管理
    @RequestMapping(value = "/category", method = RequestMethod.GET)
    public ModelAndView category(@RequestParam(value = "p", defaultValue = "1") int page,
                                 @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize, Long categoryId) {
        Page<Category> categoryList = null;
        Category category = new Category();
        if (categoryId == null) {
            categoryList = categoryService.list(page, pagesize);
        } else {
            categoryList = categoryService.listParent(categoryId, page, pagesize);
            category = categoryService.category(categoryId);
        }
        return new ModelAndView("admin/product/category")//
        .addObject("category", category)//
        .addObject("categoryList", categoryList);
    }

    @RequestMapping(value = "/category/{id}", method = RequestMethod.GET)
    public ModelAndView category_edit(@PathVariable(value = "id") Long id) {
        Category category = categoryService.category(id);
        List<Category> parents = categoryService.listParent(null);
        return new ModelAndView("admin/product/categoryEdit")//
        .addObject("category", category)//
        .addObject("parents", parents);
    }

    @RequestMapping(value = "/category/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult category_del(@PathVariable(value = "id") Long id) {
        Category category = categoryService.category(id);
        if (category == null) return fail("删除失败");
        List<Product> list = productService.listProduct(id);
        if (list != null && list.size() != 0) return fail("删除失败,请先删除相关联的产品");
        categoryService.del(id);
        return ok("删除成功");
    }

    @RequestMapping(value = "/category/batchDel", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult category_batchDel(@RequestBody List<Long> categoryIds) {
        int count = 0;
        for (Long id : categoryIds) {
            Category category = categoryService.category(id);
            if (category == null) continue;
            List<Product> list = productService.listProduct(id);
            if (list != null && list.size() != 0) continue;
            categoryService.del(id);
            count++;
        }
        return ok("删除成功" + count + "项目");
    }

    @RequestMapping(value = "/category", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult category(Category category) {
        if (category == null) return fail("创建失败");
        if (StringUtils.isEmpty(category.getName())) return fail("参数错误");
        categoryService.save(category);
        return ok("创建成功");
    }

    // 商品规格管理
    @RequestMapping(value = "/model", method = RequestMethod.GET)
    public ModelAndView model(@RequestParam(value = "p", defaultValue = "1") int page,
                              @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Model> modelList = productService.listModel(page, pagesize);
        return new ModelAndView("admin/product/model")//
        .addObject("modelList", modelList);
    }

    @RequestMapping(value = "/model/{id}", method = RequestMethod.GET)
    public ModelAndView model_edit(@PathVariable(value = "id") Long id) {
        Model model = productService.model(id);
        return new ModelAndView("admin/product/modelEdit")//
        .addObject("model", model);
    }

    @RequestMapping(value = "/model/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult model_del(@PathVariable(value = "id") Long id) {
        Model model = productService.model(id);
        if (model == null) return fail("删除失败");
        productService.delModel(id);
        return ok("删除成功");
    }

    @RequestMapping(value = "/model/batchDel", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult model_batchDel(@RequestBody List<Long> modelIds) {
        int count = 0;
        for (Long id : modelIds) {
            Model model = productService.model(id);
            if (model == null) continue;
            productService.delModel(id);
            count++;
        }
        return ok("删除成功" + count + "项目");
    }

    @RequestMapping(value = "/model", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult model(Model model) {
        if (model == null) return fail("创建失败");
        if (StringUtils.isEmpty(model.getName()) || model.getWeight() == null) return fail("参数错误");
        productService.save(model);
        return ok("创建成功");
    }

    // 商品基础信息管理
    @RequestMapping(value = "/product", method = RequestMethod.GET)
    public ModelAndView product(@RequestParam(value = "p", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize, Long categoryId) {
        Page<Product> productList = null;
        Category category = new Category();
        if (categoryId == null) {
            productList = productService.listProduct(page, pagesize);
        } else {
            productList = productService.listProductByCategoryId(categoryId, page, pagesize);
            category = categoryService.category(categoryId);
        }
        return new ModelAndView("admin/product/product")//
        .addObject("category", category)//
        .addObject("productList", productList);
    }

    @RequestMapping(value = "/product/{id}", method = RequestMethod.GET)
    public ModelAndView product_edit(@PathVariable(value = "id") Long id) {
        Product product = productService.product(id);
        return new ModelAndView("admin/product/productEdit")//
        .addObject("product", product);
    }

    @RequestMapping(value = "/product/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult product_del(@PathVariable(value = "id") Long id) {
        Product product = productService.product(id);
        if (product == null) return fail("删除失败");
        Page<Item> list = itemService.listItemProductId(id, 1, 10);
        if (list != null && list.getContent() != null && list.getContent().size() != 0) {
            return fail("删除失败,请先删除相关联的供应商商品!");
        }
        productService.delProduct(id);
        return ok("删除成功");
    }

    @RequestMapping(value = "/product/batchDel", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult product_batchDel(@RequestBody List<Long> productIds) {
        int count = 0;
        for (Long id : productIds) {
            Product product = productService.product(id);
            if (product == null) continue;
            Page<Item> list = itemService.listItemProductId(id, 1, 10);
            if (list != null && list.getContent() != null && list.getContent().size() != 0) continue;
            productService.delProduct(id);
            count++;
        }
        return ok("删除成功" + count + "项目");
    }

    @RequestMapping(value = "/product", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult product(Product product) {
        if (product == null) return fail("创建失败");
        productService.save(product);
        return ok("创建成功");
    }

    // 订单管理
    @RequestMapping(value = "/order/summery", method = RequestMethod.GET)
    public ModelAndView summery(@RequestParam(value = "p", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        String sumDate = DateFormatUtils.format(new Date(), "yyyyMMdd");
        Page<ItemSum> itemSumList = itemService.getByStateAndSumDate(ItemSumState.NONE, sumDate, page, pagesize);
        return new ModelAndView("admin/order/summery")//
        .addObject("itemSumList", itemSumList);
    }

    @RequestMapping(value = "/order/summery/history", method = RequestMethod.GET)
    public ModelAndView summery_history(@RequestParam(value = "p", defaultValue = "1") int page,
                                        @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                        Date sumDate) {
        Page<ItemSum> itemSumList = itemService.listItemSum(page, pagesize);
        return new ModelAndView("admin/order/summeryHistory")//
        .addObject("itemSumList", itemSumList);
    }

    // 采购商品汇总下订单,平台向供应商下订单
    @RequestMapping(value = "/order", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult order(@RequestBody List<Map<String, Object>> items) {
        if (items == null || items.size() == 0) return fail("未选择商品");
        String sumDate = DateFormatUtils.format(new Date(), "yyyyMMdd");

        List<Long> ids = Lists.newArrayList();
        Map<Long, Float> itemCountMap = Maps.newHashMap();
        for (Map<String, Object> cart : items) {
            Long itemId = Long.parseLong((String) cart.get("id"));
            Float count = Float.parseFloat((String) cart.get("count"));
            ids.add(itemId);
            itemCountMap.put(itemId, count);
        }
        List<Item> itemList = itemService.listItem(ids);
        Map<Long, List<Item>> itemUserMap = toLongListMap(itemList, "userId");

        for (Long userId : itemUserMap.keySet()) {
            List<Item> list = itemUserMap.get(userId);
            boolean hasNonOrderItem = false;
            for (Item item : list) {
                ItemSum itemSum = itemService.getByItemIdAndSumDate(item.getId(), sumDate);
                if (itemSum == null || itemSum.getState() != ItemSumState.NONE.getValue()) continue;
                itemSum.setState(ItemSumState.ORDER.getValue());
                itemService.save(itemSum);
                hasNonOrderItem = true;
            }
            if (!hasNonOrderItem) return fail("下单失败");

            Order order = new Order(userId(), OrderType.BUY, OrderState.NORMAL);
            orderService.save(order);
            float totalAmount = 0;
            for (Item item : list) {
                Float count = itemCountMap.get(item.getId());
                OrderDetail orderDetail = new OrderDetail(item.getId(), order.getId(), count, item.getItemPrice(),
                                                          item.getItemPrice() * count, item.getUserId());
                orderService.save(orderDetail);
                totalAmount += orderDetail.getAmount();
            }
            order.setOrderPrice(totalAmount);
            orderService.save(order);
        }
        return ok("成功");
    }

    @RequestMapping(value = "/order/buyer", method = RequestMethod.GET)
    public ModelAndView order_buyer(@RequestParam(value = "p", defaultValue = "1") int page,
                                    @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                    String start, String end) {
        Page<Order> orderList = null;
        if (StringUtils.isNotEmpty(start) || StringUtils.isNotEmpty(end)) {
            Date startDate = genDay(start, -7);
            Date endDate = genDay(end, 0);
            orderList = orderService.listByType(OrderType.SELL, startDate, endDate, page, pagesize);
        } else {
            orderList = orderService.listByType(OrderType.SELL, page, pagesize);
        }
        return new ModelAndView("admin/order/buyer")//
        .addObject("orderList", orderList)//
        .addObject("start", start)//
        .addObject("end", end);
    }

    @RequestMapping(value = "/order/buyer/confirm/{orderId}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult order_buyer_confirm(@PathVariable(value = "orderId") Long orderId) {
        Order order = orderService.order(orderId);
        if (order == null) return fail("订单不存在");
        order.setPayState(1);
        orderService.save(order);
        return ok("成功");
    }

    @RequestMapping(value = "/order/supplier", method = RequestMethod.GET)
    public ModelAndView order_supplier(@RequestParam(value = "p", defaultValue = "1") int page,
                                       @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                       String start, String end) {
        Page<Order> orderList = null;
        if (StringUtils.isNotEmpty(start) || StringUtils.isNotEmpty(end)) {
            Date startDate = genDay(start, -7);
            Date endDate = genDay(end, 0);
            orderList = orderService.listByTypeAndUserId(OrderType.BUY, userId(), startDate, endDate, page, pagesize);
        } else {
            orderList = orderService.listByTypeAndUserId(OrderType.BUY, userId(), page, pagesize);
        }

        return new ModelAndView("admin/order/supplier")//
        .addObject("orderList", orderList)//
        .addObject("start", start)//
        .addObject("end", end);
    }

    @RequestMapping(value = "/order/supplier/cancel/{orderId}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult order_buyer_cancel(@PathVariable(value = "orderId") Long orderId) {
        Order order = orderService.order(orderId);
        if (order == null) return fail("订单不存在");
        order.setState(OrderState.CANCEL.getValue());// 取消订单
        orderService.save(order);
        return ok("成功");
    }

    // 历史订单
    @RequestMapping(value = "/order/supplier/history", method = RequestMethod.GET)
    public ModelAndView order_history(@RequestParam(value = "p", defaultValue = "1") int page,
                                      @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                      String start, String end) {
        Page<Order> orderList = orderService.listByTypeAndUserId(OrderType.BUY, userId(), page, pagesize);
        return new ModelAndView("admin/order/supplier")//
        .addObject("orderList", orderList);
    }

    @RequestMapping(value = "/order/detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@RequestParam(value = "p", defaultValue = "1") int page,
                               @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                               @PathVariable(value = "id") Long orderId) {
        Page<OrderDetail> detailList = orderService.listDetail(orderId, page, pagesize);
        Order order = orderService.order(orderId);
        return new ModelAndView("admin/order/detail")//
        .addObject("detailList", detailList)//
        .addObject("order", order);
    }

    @RequestMapping(value = "/itemSum/detail/{id}", method = RequestMethod.GET)
    public ModelAndView itemSumDetail(@RequestParam(value = "p", defaultValue = "1") int page,
                                      @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                                      @PathVariable(value = "id") Long itemSumId) {
        Page<OrderDetail> detailList = orderService.listDetailByItemSumId(itemSumId, page, pagesize);
        return new ModelAndView("admin/order/item")//
        .addObject("detailList", detailList);
    }

    // 采购订单发货
    @RequestMapping(value = "/order/detail", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult detail(Order orderForm) {
        if (orderForm == null) return fail("发货失败");
        Order order = orderService.order(orderForm.getId());
        if (order == null) return fail("发货失败");
        order.setExpresTime(new Date());
        order.setExpresType(orderForm.getExpresType());
        order.setExpresNum(orderForm.getExpresNum());
        order.setExpresPrice(orderForm.getExpresPrice());
        order.setExpresTime(orderForm.getExpresTime());
        order.setPayType("2");
        orderService.save(order);
        return ok("发货成功");
    }

    // 审核管理
    // 供货商品审核
    @RequestMapping(value = "/verify/supplierItem", method = RequestMethod.GET)
    public ModelAndView supplierItem(@RequestParam(value = "p", defaultValue = "1") int page,
                                     @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Item> itemList = itemService.listItemByState(ItemState.NONE, page, pagesize);
        return new ModelAndView("admin/verify/supplierItem")//
        .addObject("itemList", itemList);
    }

    // 需求管理
    @RequestMapping(value = "/require", method = RequestMethod.GET)
    public ModelAndView require(@RequestParam(value = "p", defaultValue = "1") int page,
                                @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize) {
        Page<Require> requireList = requireService.listRequire(page, pagesize);
        return new ModelAndView("admin/require/list")//
        .addObject("requireList", requireList);
    }

    @RequestMapping(value = "/require/{id}", method = RequestMethod.GET)
    public ModelAndView require_edit(@PathVariable(value = "id") Long id) {
        Require require = requireService.require(id);
        return new ModelAndView("admin/require/edit")//
        .addObject("deadline", dateFormat(require == null ? null : require.getDeadlineTime()))//
        .addObject("require", require);
    }

    @RequestMapping(value = "/require", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult require(Require require, String deadline) {
        if (require == null) return fail("创建失败");
        if (StringUtils.isEmpty(require.getTitle()) || StringUtils.isEmpty(deadline)) return fail("参数错误");
        if (require.getDeadlineTime() == null) {
            require.setDeadlineTime(genDay(deadline, 10));
        }
        requireService.save(require);
        return ok("创建成功");
    }

    @RequestMapping(value = "/require/del/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult require_del(@PathVariable(value = "id") Long id) {
        Require require = requireService.require(id);
        if (require == null) return fail("删除失败");
        List<Bid> bidList = requireService.listBid(require.getId());
        if (bidList != null && bidList.size() != 0) return fail("删除失败,已经有竞标");
        requireService.delRequire(id);
        return ok("删除成功");
    }

    // 竞标审核
    @RequestMapping(value = "/require/modify", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult requireModify(Long requireId, Integer state) {
        Require require = requireService.require(requireId);
        require.setState(state);
        requireService.save(require);
        return ok("修改成功");
    }

    // 竞标查询
    @RequestMapping(value = "/bid/{requireId}", method = RequestMethod.GET)
    public ModelAndView bid(@RequestParam(value = "p", defaultValue = "1") int page,
                            @RequestParam(value = "size", defaultValue = _PAGE_SIZE_) int pagesize,
                            @PathVariable(value = "requireId") Long requireId) {
        Page<Bid> bidList = requireService.listBid(requireId, page, pagesize);
        return new ModelAndView("admin/require/bidList")//
        .addObject("bidList", bidList)//
        .addObject("requireId", requireId);
    }

    // 竞标审核
    @RequestMapping(value = "/bid/modify", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult bidModify(Long bidId, Integer state) {
        Bid bid = requireService.bid(bidId);
        Require require = requireService.require(bid.getRequireId());
        if (bid == null || state == null || require == null) return fail("修改失败");
        if (state.intValue() == 1) {
            if (require.getFinishCount() + bid.getBidCount() > require.getRequireCount()) {
                return fail("修改失败,超过最大需求量");
            }
            require.setFinishCount(bid.getBidCount());
            requireService.save(require);
            // 审核通过自动创建供应商商品
            Item item = new Item();
            item.setUserId(bid.getUserId());
            item.setItemPrice(bid.getBidPrice());
            item.setProductId(require.getProductId());
            item.setTitle(require.getTitle());
            item.setCount(bid.getBidCount());
            itemService.save(item);
        }
        bid.setState(state);
        requireService.save(bid);
        return ok("修改成功");
    }
}
