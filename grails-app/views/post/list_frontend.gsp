<%@ page contentType="text/html;charset=UTF-8" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta name="layout" content="main"/>
	</head>
    <body>
		<wm_post:showArchive>
			<div class="message" style="background: none;">
				Wir haben ein paar Einträge ins <g:link controller="post" action="list_frontend_archive">Archiv</g:link> verschoben um Platz zu sparen!
				<br />
				<br />
				Klickt auf den Link <g:link controller="post" action="list_frontend_archive">Archiv</g:link>, um die alten Einträge zu lesen ...
			</div>
		</wm_post:showArchive>
		<g:if test="${postInstanceList}">
			<g:render template="/post/show" collection="${postInstanceList}" var="post" />
		</g:if>
    </body>
</html>