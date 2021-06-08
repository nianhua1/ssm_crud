<%--
  Created by IntelliJ IDEA.
  User: 年华
  Date: 2021/5/29
  Time: 21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工信息页面</title>
    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

    <!-- 修改员工的模态框 -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">修改员工</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@teng.com">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <!-- 部门提交部门id即可 -->
                                <select class="form-control" name="dId" id="depts_update_select">
                                </select>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 添加员工的模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">新增员工</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@teng.com">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <!-- 部门提交部门id即可 -->
                                <select class="form-control" name="dId" id="depts_add_select">
                                </select>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>
    <%--搭建显示的页面--%>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM_CRUD</h1>
            </div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            </div>
        </div>
        <%--数据部分--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all"/>
                            </th>
                            <th>id</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
        <%--分页部分--%>
        <div class="row">
            <%--分页信息--%>
            <div class="col-md-6" id="emps_pageInfo">

            </div>
            <%--分页条--%>
            <div class="col-md-6" id="emps_pageNav">

            </div>
        </div>
    </div>

    <script type="text/javascript">
        var totalPages;
        var currPageNo;

        $(function () {
            to_page(1);
        });
        function to_page(pageNo) {
            $.ajax({
                url:"${APP_PATH}/emps",
                type:"GET",
                data:"pageNo="+pageNo,
                success:function (result) {
                    // console.log(result);
                    //显示数据到表格中
                    dispaly_emps_list(result);
                    //显示分页信息
                    dispaly_emps_pageInfo(result);
                    //显示分页条
                    dispaly_emps_nav(result);
                }
            });
        }

        function dispaly_emps_list(result) {
            $("#emps_table tbody").empty();
            $.each(result.extendMap.pageInfo.list,function (index,item) {
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);

                /***
                 * <button class="btn btn-primary btn-sm" >
                 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                 编辑
                 </button>
                 */
                var editbtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_emp_btn")
                    .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
                editbtn.attr("edit_id",item.empId);
                /**
                 * <button class="btn btn-danger btn-sm">
                 <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                 删除
                 </button>
                 */
                var deletebtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_emp_btn")
                    .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
                deletebtn.attr("delete_id",item.empId);

                var btnTd = $("<td></td>").append(editbtn).append(" ").append(deletebtn);

                //将信息添加到列表中
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }

        function dispaly_emps_pageInfo(result){
            $("#emps_pageInfo").empty();
            $("#emps_pageInfo").append("当前"+
                result.extendMap.pageInfo.pageNum+"页,总"+
                result.extendMap.pageInfo.pages+"页，总"+
                result.extendMap.pageInfo.total+"条记录");
                totalPages = result.extendMap.pageInfo.total;
                currPageNo = result.extendMap.pageInfo.pageNum;

        }

        function dispaly_emps_nav(result) {
            $("#emps_pageNav").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            ul.append(firstPageLi).append(prePageLi);

            if(!result.extendMap.pageInfo.hasPreviousPage){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                firstPageLi.click(function () {
                    to_page(1);
                });

                prePageLi.click(function () {
                    to_page(result.extendMap.pageInfo.pageNum-1);
                });
            }

            $.each(result.extendMap.pageInfo.navigatepageNums,function (index,item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.extendMap.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                ul.append(numLi);
                numLi.click(function () {
                    to_page(item);
                });
            });


            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
            ul.append(nextPageLi).append(lastPageLi);

            if(!result.extendMap.pageInfo.hasNextPage){
                lastPageLi.addClass("disabled");
                nextPageLi.addClass("disabled");
            }else{
                lastPageLi.click(function () {
                    to_page(result.extendMap.pageInfo.pages);
                });

                nextPageLi.click(function () {
                    to_page(result.extendMap.pageInfo.pageNum+1);
                });
            }

            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#emps_pageNav");
        }

        $("#emp_add_btn").click(function () {
            //发送ajax请求获取部门
            get_Depts("#depts_add_select");

            $("#empAddModal").modal({
                backdrop:'static'
            });
        });

        function get_Depts(ele) {
            //清空下拉框
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    $.each(result.extendMap.depts,function (index,item) {
                        var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }
        //校验用户名是否可用
        $("#empName_add_input").change(function () {
            $.ajax({
                url:"${APP_PATH}/checkEmpName",
                type:"POST",
                data:"empName="+this.value,
                success:function (result) {
                    if(result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                    }else{
                        show_validate_msg("#empName_add_input","error",result.extendMap.java_va);
                    }
                }
            });
        });

        $("#emp_save_btn").click(function () {
            //检查输入合法性
            if(!check_input_info()){
                return false;
            }

            //发送ajax保存员工
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    //跳转之前判断后端校验
                    if(result.code == 100){
                        //关闭模态框
                        $("#empAddModal").modal('hide');
                        //跳转最后一页
                        to_page(totalPages);
                    }
                }
            });
        });

        //用户名和邮箱校验
        function check_input_info() {
            //校验用户名
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)){
                show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
                return false;
            }else{
                show_validate_msg("#empName_add_input","success","");
            }

            //2、校验邮箱信息
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_add_input","error","邮箱不合法！");
                return false;
            }else{
                show_validate_msg("#email_add_input","success","");
            }
            return true;
        }

        function show_validate_msg(ele,status,msg) {
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if("success"== status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //删除单个员工
        $(document).on("click",".delete_emp_btn",function () {
            var empId = $(this).attr("delete_id");
            var empName = $(this).parents("tr").find("td:eq(2)").text();

            if(confirm("你确定要删除【"+empName+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        if(result.code==100){
                            to_page(currPageNo);
                        }
                    }
                });
            }

        });

        //完成全选/全不选功能
        $("#check_all").click(function(){
            //attr获取checked是undefined;
            //我们这些dom原生的属性；attr获取自定义属性的值；
            //prop修改和读取dom原生属性的值
            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        //check_item
        $(document).on("click",".check_item",function(){
            //判断当前选择中的元素是否5个
            var flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        });

        //点击全部删除，就批量删除
        $("#emp_delete_all_btn").click(function(){
            //
            var empNames = "";
            var del_idstr = "";
            $.each($(".check_item:checked"),function(){
                //this
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                //组装员工id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //去除empNames多余的,
            empNames = empNames.substring(0, empNames.length-1);
            //去除删除的id多余的-
            del_idstr = del_idstr.substring(0, del_idstr.length-1);
            if(confirm("确认删除【"+empNames+"】吗？")){
                //发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function(result){
                        //回到当前页面
                        to_page(currPageNo);
                    }
                });
            }
        });

        $(document).on("click",".edit_emp_btn",function () {

            get_Depts("#depts_update_select");
            getEmp($(this).attr("edit_id"));
            $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));

            //alert($(this).attr("edit_id"));
            $("#empUpdateModal").modal({
                backdrop: 'static'
            });
        });
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    var empData = result.extendMap.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#depts_update_select").val([empData.dId]);
                }
            });
        }

        //点击更新，更新员工信息
        $("#emp_update_btn").click(function(){
            //验证邮箱是否合法
            //1、校验邮箱信息
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
                return false;
            }else{
                show_validate_msg("#email_update_input", "success", "");
            }

            //2、发送ajax请求保存更新的员工数据
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function(result){
                    //alert(result.msg);
                    //1、关闭对话框
                    $("#empUpdateModal").modal("hide");
                    //2、回到本页面
                    to_page(currPageNo);
                }
            });
        });

    </script>
</body>
</html>
