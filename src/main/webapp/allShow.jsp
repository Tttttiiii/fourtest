<%@ page language="java" import="java.util.*,com.four.dbutil.*,com.four.entity.*,com.four.model.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>显示数据页面</title>
  </head>
  <body>
  	<h3 id="excel-info"></h3>
	<script>
		let msg = "${msg }";
		let h3 = document.getElementById("excel-info");
		if (msg != ""){
			h3.innerHTML = msg;
		}else {
			h3.innerHTML = "";
		}
	</script>
    <%
     Model model=new Model();
 	 ArrayList<User> arraylist=model.userSelect();
			%>
			数据库中所有用户
			<table border="1">
			<%for(int i=0;i<arraylist.size();i++){%>
				<tr>
				<td><%=arraylist.get(i).getId()%></td>
				<td><%=arraylist.get(i).getName() %></td>
				<td><%=arraylist.get(i).getPassword() %></td>
				</tr>
		<% 	
		}
     %>
     </table>
	<br/>
	<button onclick="window.location.href='../fourtest_war_exploded/index.jsp'" type="button" id="upfile-btn">返回首页</button>
  </body>
</html>
