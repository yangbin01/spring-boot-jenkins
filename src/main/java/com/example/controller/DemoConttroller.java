package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yangbin
 * @date 2020/8/18 12:40
 * @description
 */

@RestController
public class DemoConttroller {

    @GetMapping("/hello/{name}")
    public String hello(@PathVariable  String name){
        return "hello  aaa:  " + name;
    }

}
