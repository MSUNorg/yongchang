/*
 * 
 */
package com.yongchang.b2b.support;

import java.io.*;
import java.nio.file.Paths;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Component;
import org.springframework.util.DigestUtils;
import org.springframework.web.multipart.MultipartFile;

import com.yongchang.b2b.cons.Definition;

/**
 * 文件上传下载
 * 
 * @author zxc May 25, 2016 4:27:37 PM
 */
@Component
public class FileHelper implements Definition {

    @Value("${file.path}")
    private String         FILE_PATH;
    @Autowired
    private ResourceLoader resourceLoader;

    public String upload2save(MultipartFile uploadfile) {
        if (uploadfile == null || uploadfile.isEmpty()) return "";
        try {
            // String filename = uploadfile.getOriginalFilename();
            String filepath = Paths.get(FILE_PATH, uuid() + ".jpg").toString();
            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(filepath)));
            stream.write(uploadfile.getBytes());
            stream.close();
            return filepath;
        } catch (Exception e) {
            _.error("upload2save file error!", e);
        }
        return "";
    }

    public Resource file(String file) {
        try {
            if (resourceLoader.getResource("file:" + Paths.get(file).toString()).getFile().exists()) {
                return resourceLoader.getResource("file:" + Paths.get(file).toString());
            }
        } catch (Exception e) {
            _.error("resourceLoader.getResource error!", e);
        }
        return resourceLoader.getResource("classpath:static/images/noimages.png");
    }

    private static String uuid() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    public static String md5(InputStream input) {
        String md5 = "";
        try {
            md5 = DigestUtils.md5DigestAsHex(IOUtils.toByteArray(input));
            IOUtils.closeQuietly(input);
        } catch (Exception e) {
            _.error("FileMD5 error!", e);
        }
        return md5;
    }
}
