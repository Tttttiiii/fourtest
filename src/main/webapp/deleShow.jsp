<%@ page language="java" import="java.util.*,com.four.dbutil.*,com.four.entity.*,com.four.model.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>显示数据页面</title>
  </head>
  <body>
    <%
    int id=Integer.parseInt(request.getParameter("id"));
     Model model=new Model();
	%>
	删除完成，请查看删除后的结果
	<%=model.delete(id) %>
	<form action="allShow.jsp">
	<input type="submit" value="显示所有用户">
	</form>
  <br/>
    <button onclick="window.location.href='../fourtest_war_exploded/index.jsp'" type="button" id="upfile-btn">返回首页</button>
  </body>
</html>
