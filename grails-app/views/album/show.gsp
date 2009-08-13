
<%@ page import="de.webmpuls.blog.Album" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Album '${albumInstance.name}'</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
	
            <div class="dialog">
				<%
				    def albumBilderList = albumInstance.bilder
				%>
				<g:if test="${albumBilderList && !albumBilderList.isEmpty()}">
					<table>
						<tr>
						<g:each in="${albumBilderList}" status="i" var="bildInstance">
							<g:if test="${bildInstance.exists()}">
								<g:if test="${i > 0 && 5 % i == 2}">
									<tr>
								</g:if>
								<td>
									<div class="thumbwrapper highslide-gallery" style="margin: auto">
										<br />
										<a class='highslide' href='${wm_media.mediaPath(albumId: albumInstance.id)}${bildInstance.getBigURL()}' onclick="return hs.expand(this, { captionText: '${bildInstance.bildUnterschrift}' })">
											<img src='${wm_media.mediaPath(albumId: albumInstance.id)}${bildInstance.getThumbNailURL()}' alt='${bildInstance.baseName}'/>
										</a>
										<jsec:isLoggedIn>
											<p class="meta" style="text-align: right;">
												<img src="${resource(dir: 'images/skin', file: 'database_edit.png')}" alt="Bild ändern" />
												<g:link controller="bild" action="edit" id="${bildInstance.id}" params="[albumId: albumInstance.id]">
													ändern
												</g:link>
											</p>
										</jsec:isLoggedIn>
									</div>
								</td>
								<g:if test="${i > 0 && 5 % i == 2}">
									</tr>
								</g:if>
							</g:if>
						</g:each>
						</tr>
					</table>
					<br />
					<br />
					<jsec:isLoggedIn>
						<img src="${resource(dir: 'images/skin', file: 'database_add.png')}" alt="Bilder hochladen" />
						<g:link controller="bild" action="create" params="['album.id': albumInstance.id]">
							Weitere Bilder hochladen
						</g:link>
					</jsec:isLoggedIn>
				</g:if>
				<g:else>
					Es sind noch keine Bilder in diesem Album vorhanden ...
					<br />
					<br />
					<jsec:isLoggedIn>
						<img src="${resource(dir: 'images/skin', file: 'database_add.png')}" alt="Bilder hochladen" />
						<g:link controller="bild" action="create" params="['album.id': albumInstance.id]">
							Neue Bilder hochladen
						</g:link>
					</jsec:isLoggedIn>
				</g:else>
            </div>
        </div>
    </body>
</html>
