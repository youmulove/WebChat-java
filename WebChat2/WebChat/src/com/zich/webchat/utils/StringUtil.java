package com.zich.webchat.utils;

import java.util.UUID;

/**
 * @author :  zich
 */
public class StringUtil {

    public static String getGuid(){
        return UUID.randomUUID().toString().trim().replaceAll("-", "").toLowerCase();
    }

}
