package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import java.util.Map;
@Controller
public class UserController {
    @Autowired
    private UserService us;

    @RequestMapping("/selectAll")
    public @ResponseBody Map selectAll(Integer page, Integer rows, String username){
        System.out.println(page+"controller"+rows+"***"+username);
        return  us.selectAll(page,rows,username);
    }

    @RequestMapping("/delete")
    public @ResponseBody boolean delete(int[] ids){
        return us.deleteById(ids);
    }

    @RequestMapping("/insert")
    public @ResponseBody boolean insert(User u){
        return us.insertOne(u);
    }

    @RequestMapping("/update")
    public @ResponseBody boolean update(User u){
        return us.update(u);
    }
}
