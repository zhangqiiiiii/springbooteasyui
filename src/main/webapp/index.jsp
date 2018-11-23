<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP '模板.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css">
	<script type="text/javascript">
	$(function(){
		$("#list").datagrid({    
			title:"用户信息表",
		    url:"selectAll",
		    pagination:true,
		    columns:[[    
				{checkbox:true},
		        {title:'编号',field:"id",},    
		        {title:'用户名',field:"name",},
		        {title:"密码",field:"psw",},
		        
		        
		    ]],
		    iconCls:"icon-search",
			width:400,
			toolbar:"#myToolbar",
			 //双击修改用户信息
			onDblClickRow:function(rowIndex, rowData){
				//把要修改的数据填写到对话框中
				$("#userid").val(rowData.id);
				$("#username").val(rowData.name);
				$("#password").val(rowData.psw);
				//双击打开修改窗口
				$("#update").dialog("open");
			}, 
		});  
		
		
		//修改窗口
		$("#update").dialog({
		    title:"修改用户信息",    
		    width: 400,    
		    height: 200,    
		    closed: true,    
		});    
		//结束的修改
		
		//添加窗口
	$("#add").dialog({    
	    title: "添加用户信息",    
	    width: 400,    
	    height: 200,    
	    closed: true,    
	});  
	//结束的添加窗口
	
	//修改的用户名验证
		$("#username").validatebox({
			required:true,
			missingMessage:"请输入用户名",
			validType:"length[2,16]",
			invalidMessage:"请输入4到16位",
		});
		
		
		//修改的密码验证
		$("#password").validatebox({
			required:true,
			missingMessage:"请输入密码",
			validType:"length[4,16]",
			invalidMessage:"请输入4到16位",
		});
		//结束的验证
			
			//添加的用户名验证
		$("#addusername").validatebox({
			required:true,
			missingMessage:"请输入用户名",
			validType:"length[2,16]",
			invalidMessage:"请输入4到16位",
		});
		
		
		//添加的密码验证
		$("#addpassword").validatebox({
			required:true,
			missingMessage:"请输入密码",
			validType:"length[4,16]",
			invalidMessage:"请输入4到16位",
		});
		//结束的验证
	
	});
	
	//添加按钮
	function add(){
		$("#add").dialog("open");
	}
	//结束的添加按钮
	
	
	//搜索
	function searchUser(){
		var username=$("#name").val();
		//调用load方法完成,显示第一页
		$("#list").datagrid("load",{"username":username});
	}
	//结束的搜索
	
	//执行修改操作
	function clickUpdate(){
		//通过form控件的submit方法完成数据的提交
		$("#updateForm").form("submit",{
			url:"update.do",
			success: function(data){
				if(data=="true"){
					//关闭修改窗口
					$("#update").dialog("close");
					//刷新当前页
					$("#list").datagrid("reload");
				}else{
				alert("修改失败");	
				}
			},
		});
	} 
	//执行结束的修改操作
	
	
	//执行添加操作
	function clickAdd(){
		$("#addForm").form("submit",{
			url:"insert.do",
			success:function(data){
				if(data=="true"){
					//关闭修改窗口
					$("#add").dialog("close");
					//刷新当前页
					$("#list").datagrid("load");
				}else{
				alert("添加失败");	
				}
			}
		});
	}
	//结束的添加操作
	
	//批量删除
		function doMultiDelete(){
			//alert(0)
			//1.获取到所有选中的行：通过datagrid的getSelections方法获取到
			var allSelectedRows = $("#list").datagrid("getSelections");
			if(allSelectedRows.length==0){
				//alert("请选中要删除的数据");
				$.messager.alert("提示框","请选中要删除的数据","warning");
			}else{
				//确认是否删除
				//var isConfirm = confirm("确认真的要删除选中的内容吗？");
				$.messager.confirm("确认框","确认真的要删除选中的内容吗？",function(result){
					alert(result+"resulttttttttttttttttttttt");
					if(result){
						//alert(0);
						//执行删除操作
						//alert("执行删除操作");
						//1.获取到所有选中的id
						var ids = new Array(allSelectedRows.length);
						for(var i=0;i<allSelectedRows.length;i++){
							ids[i]=allSelectedRows[i].id;
						}
						
						//2.发送ajax请求到后台，执行删除操作
						$.ajax({
							url:"delete.do",
							//data:"ids="+ids,
							
							data:{"ids":ids},//这样写发送到后台的参数名是ids[]
							//在使用json格式的数据作为参数往后台传递的时候，
							//数组数据会被jquery做进一步的处理===>key[]作为发送到后台的参数名
							//jquery的深度序列化
							
							//不让jquery做深度序列化
							traditional:true,
							 
							success:function(data){
								//alert(data);
								if(data){
									//alert("删除成功");
									$.messager.show({
										title:"删除提示",
										msg:"删除成功",
										showSpeed:5000,
										showType:"fade"
									});
									$("#list").datagrid("reload");
								}else{
									alert("删除失败");
								}
							}
						});
						
					}
				
				});
			}
			
		}
		//批量删除====END====
			
		
	</script>
  </head>
  
  <body>
  <div id="myToolbar">
	  	 用户名：<input id="name"/><input type="button" onclick="searchUser()" value="搜索"/><br>
  		<a href="JavaScript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add()">添加</a>
  		<a href="JavaScript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="doMultiDelete()">批量删除</a>
  	</div>
 
    <table id="list"></table>
    
    <div id="update">
    <form id="updateForm" method="post">
    		<input type="hidden" name="id" id="userid">
   		 用户名：<input type="text" id="username" name="name" />
		密 码：<input type="text" id="password" name="psw" />
		<input type="button" onclick="clickUpdate()"  value="修改"/>
    </form>
    </div>
	
	  <div id="add">
    <form id="addForm" method="post">
    	<!--<input type="hidden" name="id" id="userid"> -->
   		 用户名：<input type="text" id="addusername" name="name" />
		密 码：<input type="text" id="addpassword" name="psw" />
		<input type="button" onclick="clickAdd()"  value="添加"/>
    </form>
    </div>
	
  </body>
</html>
