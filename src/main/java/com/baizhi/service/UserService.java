package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    public Map selectAll(int page, int rows, String username);
    public boolean update(User u);
    public boolean deleteById(int[] ids);
    public User selectOne(int id);
    public boolean insertOne(User u);
}
