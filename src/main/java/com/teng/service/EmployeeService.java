package com.teng.service;

import com.teng.bean.Employee;
import com.teng.bean.EmployeeExample;
import com.teng.bean.EmployeeExample.*;
import com.teng.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shkstart
 * @create 2021-05-29 21:16
 */
@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAllEmps() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public boolean checkName(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    public void saveEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteAllEmp(List<Integer> idList) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(idList);
        employeeMapper.deleteByExample(example);
    }

    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    public void updateEmpInfo(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
}
