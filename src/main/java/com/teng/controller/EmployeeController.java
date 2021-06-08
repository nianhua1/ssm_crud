package com.teng.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.teng.bean.Employee;
import com.teng.bean.Msg;
import com.teng.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author shkstart
 * @create 2021-05-29 21:13
 */
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    /**
     * 更新员工
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmpInfo(employee);
        return Msg.success();
    }
    /**
     * 根据id获取员工信息
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmpById(@PathVariable("id")Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().addExtend("emp",employee);

    }

    /**
     * 删除员工
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            List<Integer> idList = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String str_id : str_ids) {
                idList.add(Integer.parseInt(str_id));
            }
            employeeService.deleteAllEmp(idList);

        }else{
            employeeService.deleteEmpById(Integer.parseInt(ids));
        }
        return Msg.success();
    }

    /**
     * 保存员工
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee){
            employeeService.saveEmployee(employee);
            return Msg.success();
    }

    /**
     * 检查用户名
     */
    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg checkEmpName(@RequestParam("empName") String empName){
        System.out.println(".........");
       boolean result =  employeeService.checkName(empName);
       if(result){
           return Msg.success().addExtend("java_va","用户名可用");
       }else{
           return Msg.fail().addExtend("java_va","用户名不可用");
       }
    }

    /**
     *
     * @param pageNo
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pageNo", defaultValue = "1")Integer pageNo){
        //在查询之前调用，传入页面及每页的大小
        PageHelper.startPage(pageNo,5);
        //startPage后面紧跟的查询为分页查询
        List<Employee> employees = employeeService.getAllEmps();

        //使用pageInfo包装查询后的结果,只需要将PageInfo交给页面就行了
        //PageInfo封装了详细的分页信息，包括查询出来的信息,传入需要连续显示的页数
        PageInfo pageInfo = new PageInfo(employees,5);
        return Msg.success().addExtend("pageInfo",pageInfo);
    }



    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pageNo", defaultValue = "1")Integer pageNo, Model model){
        //在查询之前调用，传入页面及每页的大小
        PageHelper.startPage(pageNo,5);
        //startPage后面紧跟的查询为分页查询
        List<Employee> employees = employeeService.getAllEmps();
        //封装到PageInfo对象中
        PageInfo pageInfo = new PageInfo(employees,5);
        //使用pageInfo包装查询后的结果,只需要将PageInfo交给页面就行了
        //PageInfo封装了详细的分页信息，包括查询出来的信息,传入需要连续显示的页数
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
