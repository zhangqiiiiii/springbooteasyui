package com.baizhi.service;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserServiceImpl implements  UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public Map selectAll(int page,int rows,String username) {
        System.out.println(page+"*****"+rows);
        Map map=new HashMap();
        if(username!=null&&!"".equals(username)){
            username="%"+username+"%";
        }else{
            username=null;
        }
        int start=(page-1)*rows;
        System.out.println(start+"****"+rows+"******"+username);
        List<User> list=userDao.selectAll(start,rows,username);
        int count = userDao.getCount(username);
        map.put("rows",list);
        map.put("total",count);
        return map;
    }

    @Override
    public boolean update(User u) {
        try {
            userDao.updateOne(u);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteById(int[] ids) {
        try {
            userDao.deleteByIds(ids);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public User selectOne(int id) {

        return  userDao.selectOne(id);
    }

    @Override
    public boolean insertOne(User u) {
        try {
            userDao.insertOne(u);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
