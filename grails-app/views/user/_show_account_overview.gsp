<%@ page import="de.webmpuls.blog.Sex; de.webmpuls.blog.JsecUser" %>
<h2>Account Übersicht</h2>
<table>
	<tr>
		<td>
			<g:if test="${JsecUser.findByUsername(jsec.principal())?.sex == Sex.MALE}">
				<img src="${resource(dir: 'images', file: 'images_male1.jpg')}" alt="icon male"/>
			</g:if>
			<g:elseif test="${JsecUser.findByUsername(jsec.principal())?.sex == Sex.FEMALE}">
				<img src="${resource(dir: 'images', file: 'images_female1.jpg')}" alt="icon female"/>
			</g:elseif>
		</td>
		<td>
			Hallo <jsec:principal/>,
			<br/>
			schön, dass du dich wieder eingeloggt hast!
		</td>
	</tr>
</table>
<jsec:hasRole name="Administrator">
	Du bist in der Gruppe "Administrator" und darfst scharfe Sachen machen :-)
	<br />
	<br />
	<ul style="list-style: square;">
		<li style="line-height: inherit;">
			<g:link controller="album" action="list_frontend">Fotoalben verwalten und Fotos hochladen</g:link>
		</li>
		<li style="line-height: inherit;">
			<g:link controller="news" action="createOrEdit">Die News ändern</g:link>
		</li>
		<li style="line-height: inherit;">
			<g:link controller="post" action="create">Einen neuen Post schreiben</g:link>
		</li>
		<li style="line-height: inherit;">
			<g:link controller="post" action="create2">Einen neuen Post schreiben (iPhone)</g:link>
		</li>
	</ul>
</jsec:hasRole>