/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package yongchang;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.yongchang.b2b.Application;
import com.yongchang.b2b.persistence.dao.UserDao;
import com.yongchang.b2b.persistence.entity.User;

/**
 * @author zxc Jun 6, 2016 2:37:57 PM
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebAppConfiguration
public class ApplicationTests {

    @Autowired
    private UserDao userDao;

    @Test
    public void test() throws Exception {

        userDao.save(new User("AAA", "1232"));
        userDao.save(new User("BBB", "20"));
        userDao.save(new User("CCC", "30"));
        userDao.save(new User("DDD", "40"));
        userDao.save(new User("EEE", "50"));
        userDao.save(new User("FFF", "60"));
        userDao.save(new User("GGG", "70"));
        userDao.save(new User("HHH", "80"));
        userDao.save(new User("III", "90"));
        userDao.save(new User("JJJ", "100"));
        userDao.save(new User("张三", "100"));

        Assert.assertEquals(10, userDao.count());
        Assert.assertEquals("60", userDao.findByName("FFF").getPasswd());
        Assert.assertEquals("60", userDao.findByName("FFF").getPasswd());
        Assert.assertEquals("FFF", userDao.findByNameAndPasswd("FFF", "60").getName());
        userDao.delete(userDao.findByName("AAA"));
        Assert.assertEquals(9, userDao.count());
    }
}
