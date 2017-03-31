package com.yongchang.b2b.cons;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

/**
 * 枚举类集合(value=0的情况一般作为默认值,int类型初始化值为0)
 * 
 * @author zxc Jun 21, 2016 8:22:27 PM
 */
public class EnumCollections implements Definition {

    public static List<Level>      levelList      = Collections.unmodifiableList(Arrays.asList(Level.values()));
    public static List<OrderState> orderStateList = Collections.unmodifiableList(Arrays.asList(OrderState.values()));

    public static String enumName(String enumClassName, Integer v) throws Exception {
        Object _enum = getEnum(enumClassName, v);
        if (_enum == null) return StringUtils.EMPTY;
        Method _mth = _enum.getClass().getDeclaredMethod("getName");
        return (String) _mth.invoke(_enum);
    }

    @SuppressWarnings("unchecked")
    private static <E extends Enum<E>> E getEnum(String enumClassName, Integer v) {
        try {
            Class<?> c = Class.forName("com.yongchang.b2b.cons.EnumCollections$" + enumClassName);
            Object[] consts = c.getEnumConstants();
            Class<?> sub = consts[0].getClass();
            Method mth = sub.getDeclaredMethod("get", int.class);
            return (E) mth.invoke(consts[0], v);
        } catch (Exception e) {
            _.error("getEnum error!", e);
        }
        return null;
    }

    public enum Level {// 资质级别(A=1,B=2,C=3,D=4)
        A("A级", 1), B("B级", 2), C("C级", 3), D("D级", 4);

        private String name;
        private int    value;

        private Level(String name, int value) {
            this.name = name;
            this.value = value;
        }

        public static Level get(int value) {
            for (Level _enum : values())
                if (_enum.value == value) return _enum;
            return A;
        }

        public String getName() {
            return name;
        }

        public int getValue() {
            return value;
        }
    }

    public enum UserType {// 会员类型(0=admin管理员,1=buyer采购商,2=supplier供应商)
        ADMIN("管理员", 0, "admin"), BUYER("采购商", 1, "buyer"), SUPPLIER("供应商", 2, "supplier");

        private String name;
        private int    value;
        private String en;

        private UserType(String name, int value, String en) {
            this.name = name;
            this.value = value;
            this.en = en;
        }

        public static UserType get(int value) {
            for (UserType _enum : values())
                if (_enum.value == value) return _enum;
            return BUYER;
        }

        public static UserType get(String en) {
            for (UserType _enum : values())
                if (StringUtils.equalsIgnoreCase(en, _enum.en)) return _enum;
            return BUYER;
        }

        public String getName() {
            return name;
        }

        public String getEn() {
            return en;
        }

        public int getValue() {
            return value;
        }
    }

    public enum OrderType {// 订单类型(1=平台向供应商下的订单;2=采购商向平台下的订单)
        BUY("采购单", 1, "supplier"), SELL("供货单", 2, "buyer");

        private String name;
        private int    value;
        private String en;

        private OrderType(String name, int value, String en) {
            this.name = name;
            this.value = value;
            this.en = en;
        }

        public static OrderType get(int value) {
            for (OrderType _enum : values())
                if (_enum.value == value) return _enum;
            return BUY;
        }

        public static OrderType get(String en) {
            for (OrderType _enum : values())
                if (StringUtils.equalsIgnoreCase(en, _enum.en)) return _enum;
            return BUY;
        }

        public String getName() {
            return name;
        }

        public String getEn() {
            return en;
        }

        public int getValue() {
            return value;
        }
    }

    public enum CartState {// 购物车状态: 0=未下单,1=已下单,2=关闭,取消
        NO_ORDER("未下单", 0), ORDER("已下单", 1), CLOAED("关闭", 2);

        private String name;
        private int    value;

        private CartState(String name, int value) {
            this.name = name;
            this.value = value;
        }

        public static CartState get(int value) {
            for (CartState _enum : values())
                if (_enum.value == value) return _enum;
            return NO_ORDER;
        }

        public String getName() {
            return name;
        }

        public int getValue() {
            return value;
        }
    }

    public enum OrderState {// 订单状态: 0=未审核,1=正常,2=已确认,3=已发货,4=已收货,5=完成
        NONE("未审核", 0), NORMAL("正常", 1), CONFIRMED("已确认", 2), DELIVERED("已发货", 3), RECEIVED("已收货", 4), CLOAED("完成", 5),
        CANCEL("取消", 6);

        private String name;
        private int    value;

        private OrderState(String name, int value) {
            this.name = name;
            this.value = value;
        }

        public static OrderState get(int value) {
            for (OrderState _enum : values())
                if (_enum.value == value) return _enum;
            return NONE;
        }

        public String getName() {
            return name;
        }

        public int getValue() {
            return value;
        }
    }

    public enum UserState {// 状态: 0=未审核,1=正常,2=停止
        NONE("未审核", 0), NORMAL("正常", 1), CLOAED("停止", 2);

        private String name;
        private int    value;

        private UserState(String name, int value) {
            this.name = name;
            this.value = value;
        }

        public static UserState get(int value) {
            for (UserState _enum : values())
                if (_enum.value == value) return _enum;
            return NONE;
        }

        public String getName() {
            return name;
        }

        public int getValue() {
            return value;
        }
    }

    public enum ItemSumState {// 处理状态: 0=未下单,1=已下单,2=关闭
        NONE("未下单", 0), ORDER("已下单", 1), CLOAED("关闭", 2);

        private String name;
        private int    value;

        private ItemSumState(String name, int value) {
            this.name = name;
            this.value = value;
        }

        public static ItemSumState get(int value) {
            for (ItemSumState _enum : values())
                if (_enum.value == value) return _enum;
            return NONE;
        }

        public String getName() {
            return name;
        }

        public int getValue() {
            return value;
        }
    }

    public enum ItemState {// 状态:0=未审核,1=正常出售中,2=停止
        NONE("未审核", 0), NORMAL("正常出售中", 1), CLOAED("停止", 2);

        private String name;
        private int    value;

        private ItemState(String name, int value) {
            this.name = name;
            this.value = value;
        }

        public static ItemState get(int value) {
            for (ItemState _enum : values())
                if (_enum.value == value) return _enum;
            return NONE;
        }

        public String getName() {
            return name;
        }

        public int getValue() {
            return value;
        }
    }

    public enum CodeState {// 状态: 0=正常,未使用,1=已使用,2=过期
        NORMAL("正常", 0), USED("已使用", 1), CLOAED("过期", 2);

        private String name;
        private int    value;

        private CodeState(String name, int value) {
            this.name = name;
            this.value = value;
        }

        public static CodeState get(int value) {
            for (CodeState _enum : values())
                if (_enum.value == value) return _enum;
            return CLOAED;
        }

        public String getName() {
            return name;
        }

        public int getValue() {
            return value;
        }
    }
}
