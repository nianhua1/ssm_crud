package com.teng.test;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.teng.bean.Department;
import com.teng.bean.Employee;
import com.teng.dao.DepartmentMapper;
import com.teng.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * 测试Mappeer
 * @author shkstart
 * @create 2021-05-29 21:12
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private DepartmentMapper departmentMapper;

    @Test
    public void testCRUD(){
//        System.out.println(employeeMapper);
//        System.out.println(departmentMapper);
//        Department department = departmentMapper.selectByPrimaryKey(1);
//        System.out.println(department);

        PageHelper.startPage(1,5);
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        PageInfo pageInfo = new PageInfo(employees,5);
        for (Employee employee : employees) {
            System.out.println(employee);
        }

        System.out.println("当前页面："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.print("连续显示的页面：");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int num : nums) {
            System.out.println(" "+num);
        }
    }
}
