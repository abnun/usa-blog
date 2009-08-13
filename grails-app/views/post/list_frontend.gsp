<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <body>
		<g:if test="${postInstanceList}">
			<g:render template="/post/show" collection="${postInstanceList}" var="post" />
		</g:if>
    </body>
</html>