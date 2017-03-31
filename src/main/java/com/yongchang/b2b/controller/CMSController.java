package com.yongchang.b2b.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.yongchang.b2b.persistence.entity.Slideshow;
import com.yongchang.b2b.support.JsonResult;

/**
 * @author zxc Aug 14, 2016 12:45:30 PM
 */
@Controller
@RequestMapping(value = "/admin/cms/")
@PreAuthorize("hasAuthority('ADMIN')")
public class CMSController extends BaseController {

    // 首页轮播图管理
    @RequestMapping(value = "/slideshow", method = RequestMethod.GET)
    public ModelAndView slideshow() {
        List<Slideshow> list = cmsService.listSort();
        return new ModelAndView("admin/cms/slideshow")//
        .addObject("list", list);
    }

    @RequestMapping(value = "/slideshow/{id}", method = RequestMethod.GET)
    public ModelAndView slideshow_edit(@PathVariable(value = "id") Long id) {
        Slideshow slideshow = cmsService.slideshow(id);
        return new ModelAndView("admin/cms/slideshowEdit")//
        .addObject("slideshow", slideshow);
    }

    @RequestMapping(value = "/slideshow/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult slideshow_del(@PathVariable(value = "id") Long id) {
        Slideshow slideshow = cmsService.slideshow(id);
        if (slideshow == null) return fail("删除失败");
        cmsService.del(id);
        return ok("删除成功");
    }

    @RequestMapping(value = "/slideshow", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult slideshow(Slideshow slideshow) {
        if (slideshow == null) return fail("创建失败");
        if (StringUtils.isEmpty(slideshow.getPic())) return fail("参数错误,图片不能为空!");
        cmsService.save(slideshow);
        return ok("创建成功");
    }
}
