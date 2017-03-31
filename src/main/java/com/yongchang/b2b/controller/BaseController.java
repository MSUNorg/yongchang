/**
 * 
 */
package com.yongchang.b2b.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.yongchang.b2b.cons.Definition;
import com.yongchang.b2b.persistence.entity.User;
import com.yongchang.b2b.persistence.service.*;
import com.yongchang.b2b.support.FileHelper;
import com.yongchang.b2b.support.JsonResult;

/**
 * @author zxc
 */
public class BaseController implements Definition {

    @Autowired
    protected UserService        userService;
    @Autowired
    protected ProductService     productService;
    @Autowired
    protected ItemService        itemService;
    @Autowired
    protected CategoryService    categoryService;
    @Autowired
    protected OrderService       orderService;
    @Autowired
    protected RequireService     requireService;
    @Autowired
    protected CMSService         cmsService;

    @Autowired
    protected FileHelper         fileHelper;

    @Autowired
    protected HttpServletRequest request;
    @Autowired
    BCryptPasswordEncoder        bCryptPasswordEncoder;

    public User user() {
        User user = userService.getUserByEmail(request.getRemoteUser());
        return user;
    }

    public Long userId() {
        User user = userService.getUserByEmail(request.getRemoteUser());
        return user.getId();
    }

    public JsonResult ok(String msg) {
        return JsonResult.successMsg(msg);
    }

    public JsonResult ok(String msg, Object data) {
        return JsonResult.success(data, msg);
    }

    public JsonResult fail(String msg) {
        return JsonResult.failMsg(msg);
    }

    public <T extends Object> Map<Long, List<T>> toLongListMap(Collection<T> values, String property) {
        Map<Long, List<T>> valueMap = new HashMap<Long, List<T>>(values.size());
        for (T value : values) {
            try {
                String propertyValue = BeanUtils.getProperty(value, property);
                Long longValue = NumberUtils.toLong(propertyValue);
                if (longValue == null) continue;
                List<T> list = valueMap.get(longValue);
                if (list == null) {
                    list = new ArrayList<T>();
                    valueMap.put(longValue, list);
                }
                list.add(value);
            } catch (Exception e) {
                _.error(e.getMessage(), e);
                continue;
            }
        }
        return valueMap;
    }

    public String dateFormat(Date date) {
        return f.format(date == null ? new Date() : date);
    }

    public Date genDay(String dateStr, int amount) {
        Date date = null;
        try {
            if (StringUtils.isNotEmpty(dateStr)) date = f.parse(dateStr);
        } catch (Exception e) {
            _.error("SimpleDateFormat parse date error!", e);
        }
        if (date == null) date = DateUtils.addDays(new Date(), amount);
        return date;
    }

    public static String float2formatPrice(Float price) {
        if (price == null) return "";
        BigDecimal b = new BigDecimal(price);
        float f = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
        DecimalFormat fnum = new DecimalFormat("#0.00");
        return fnum.format(f);
    }
}
