package com.yongchang.b2b.controller;

import java.util.*;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.yongchang.b2b.cons.EnumCollections.ItemState;
import com.yongchang.b2b.cons.EnumCollections.UserType;
import com.yongchang.b2b.persistence.entity.*;
import com.yongchang.b2b.support.JsonResult;

/**
 * @author zxc Jun 7, 2016 2:47:04 PM
 */
@Controller
public class IndexController extends BaseController {

    // 首页
    @RequestMapping(value = { "/", "/index" }, method = RequestMethod.GET)
    public ModelAndView index() {
        // 热卖
        Page<Long> orderDetails = orderService.listGroupByItemId();
        List<Item> hots = itemService.listItem(orderDetails.getContent());
        // 限时
        List<Item> promotions = itemService.listItemByState(ItemState.NORMAL, 1, 4).getContent();
        // 精选

        // 轮播
        // List<Item> showcases = itemService.listItemByShowcase(1);
        List<Slideshow> showcases = cmsService.listByState(0);
        // 类目
        List<Category> categoryList = categoryService.listParent(null);
        return new ModelAndView("index")//
        .addObject("hots", hots)//
        .addObject("promotions", promotions)//
        .addObject("showcases", showcases)//
        .addObject("categoryList", categoryList);
    }

    // 商品搜索
    @RequestMapping(value = "/index/search", method = RequestMethod.GET)
    public ModelAndView search(String keyword) {
        keyword = StringUtils.trim(keyword);
        List<Item> itemList = itemService.listItem(keyword);
        return new ModelAndView("indexList")//
        .addObject("itemList", itemList);
    }

    // 类目下全部商品
    @RequestMapping(value = "/index/{categoryId}", method = RequestMethod.GET)
    public ModelAndView index(@PathVariable(value = "categoryId") Long categoryId) {
        Set<Long> categoryIds = categoryService.childrenIds(categoryId);
        List<Item> itemList = itemService.listItemByCategoryIds(categoryIds);

        // 类目
        List<Category> categoryList = categoryService.listParent(null);
        return new ModelAndView("indexList")//
        .addObject("itemList", itemList)//
        .addObject("categoryList", categoryList)//
        .addObject("categoryId", categoryId);
    }

    // 首页商品详情
    @RequestMapping(value = { "/item/{id}" })
    public ModelAndView detail(@PathVariable(value = "id") Long id) {
        Item item = itemService.item(id);

        // 热卖
        Page<Long> orderDetails = orderService.listGroupByItemId();
        List<Item> hots = itemService.listItem(orderDetails.getContent());
        return new ModelAndView("detail")//
        .addObject("hots", hots)//
        .addObject("item", item);
    }

    // 全部类目
    @RequestMapping(value = "/category", method = RequestMethod.POST)
    @ResponseBody
    public List<JSONObject> category(String root) {
        if (StringUtils.equals(root, "true")) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", "");
            jsonObject.put("text", "无");
            List<JSONObject> list = new LinkedList<JSONObject>();
            list.add(jsonObject);
            list.addAll(categoryService.tree());
            return list;
        }
        return categoryService.tree();
    }

    // 类目下产品列表
    @RequestMapping(value = "/{categoryId}/product", method = RequestMethod.POST)
    @ResponseBody
    public List<JSONObject> product(@PathVariable(value = "categoryId") Long categoryId) {
        if (categoryId == null) return Collections.<JSONObject> emptyList();
        List<Product> list = productService.listProduct(categoryId);
        List<JSONObject> jsons = new LinkedList<JSONObject>();
        for (Product product : list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", product.getId());
            jsonObject.put("text", product.getTitle());
            jsons.add(jsonObject);
        }
        return jsons;
    }

    // 全部商家json
    @RequestMapping(value = "store/{userType}", method = RequestMethod.GET)
    @ResponseBody
    public List<JSONObject> supplier(@RequestParam(value = "userType", defaultValue = "buyer") @PathVariable("userType") String userType) {
        List<JSONObject> jsons = new LinkedList<JSONObject>();
        List<User> userList = userService.listUserByType(UserType.get(userType));
        for (User user : userList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", user.getId());
            jsonObject.put("company", user.getCompany());
            jsons.add(jsonObject);
        }
        return jsons;
    }

    // 图片
    @RequestMapping(value = "/img", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> img(String img) {
        try {
            return ResponseEntity.ok()//
            .contentType(MediaType.IMAGE_JPEG)//
            .body(fileHelper.file(img));
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    // 上传文件
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult img(@RequestParam("imgfile") MultipartFile imgfile) {
        String img = fileHelper.upload2save(imgfile);
        if (StringUtils.isEmpty(img)) return fail("上传失败");
        return ok("上传成功", img);
    }
}
