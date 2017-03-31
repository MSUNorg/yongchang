/*
 * 
 */
package com.yongchang.b2b.support;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author zxc Apr 28, 2016 11:57:42 AM
 */
public class JsonResult {

    private boolean          status;
    private String           message;
    private Object           data;

    public static JsonResult success = JsonResult.successMsg("成功");
    public static JsonResult fail    = JsonResult.failMsg("失败");

    public JsonResult() {

    }

    public JsonResult(boolean status, String message) {
        this.status = status;
        this.message = message;
    }

    public JsonResult(boolean status, String message, Object data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    public static JsonResult success() {
        return success(null, "");
    }

    public static JsonResult success(Object data) {
        return success(data, "");
    }

    public static JsonResult successMsg(String msg) {
        return success(null, msg);
    }

    public static JsonResult success(Object data, String msg) {
        JsonResult result = new JsonResult();
        result.setStatus(true);
        result.setData(data);
        result.setMessage(msg);
        return result;
    }

    public static JsonResult fail() {
        return fail(null, "");
    }

    public static JsonResult failMsg(String msg) {
        return fail(null, msg);
    }

    public static JsonResult fail(Object data) {
        return fail(data, "");
    }

    public static JsonResult fail(Object data, String msg) {
        JsonResult result = new JsonResult();
        result.setStatus(false);
        result.setData(data);
        result.setMessage(msg);
        return result;
    }

    public Boolean getStatus() {
        return status;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        try {
            return new ObjectMapper().writeValueAsString(this);
        } catch (JsonProcessingException e) {
            return super.toString();
        }
    }
}
