package com.baizhi.dao;

import com.baizhi.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    public List<User> selectAll(@Param("start") int start,
                                @Param("pagesize") int pagesize,
                                @Param("username") String username);
    public void insertOne(User u);
    public void deleteByIds(int[] ids);
    public User selectOne(int id);
    public void updateOne(User u);
    public int getCount(@Param("username") String username);
}
