<%@ page contentType="text/html;charset=UTF-8" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta name="layout" content="main"/>
	</head>
    <body>
		<g:if test="${postInstanceList}">
			<g:render template="/post/show" collection="${postInstanceList}" var="post" />
		</g:if>
    </body>
</html>