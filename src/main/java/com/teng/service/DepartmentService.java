package com.teng.service;

import com.teng.bean.Department;
import com.teng.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getAllDepts() {
        return departmentMapper.selectByExample(null);
    }
}
