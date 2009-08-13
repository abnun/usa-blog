<%@ page import="de.webmpuls.blog.News" %>
<g:if test="${newsInstance}">

	<%
		News tmpNews = newsInstance
	%>
	<h2>${tmpNews.titel}</h2>
	<p>${tmpNews.inhalt}</p>
</g:if>