
<%@ page import="de.webmpuls.blog.Bild; de.webmpuls.blog.Album" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Album Liste</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
				<g:if test="${albumInstanceList}">
					<table>
					<tr>
						<g:each in="${albumInstanceList}" status="i" var="albumInstance">
							<g:if test="${albumInstance.sichtbar}">
								<g:if test="${i > 0 && 5 % i == 2}">
									<tr>
								</g:if>
										<td>
											<div class="thumbwrapper">
												<g:link action="show" id="${albumInstance.id}">
													<p class="meta">
														${fieldValue(bean: albumInstance, field: 'name')}
													</p>
													<%
														List albumBilder = albumInstance.bilder?.asList()

														Bild titelBild = null
														if(albumBilder && !albumBilder.isEmpty())
														{
															titelBild = albumBilder[0]
														}

														ArrayList titelBilder = new ArrayList()
														albumBilder.findAll
														{
															if(it.titelBild == true)
															{
																titelBilder.add(it)
															}
														}

														if(!titelBilder.isEmpty())
														{
															titelBild = titelBilder[0]
														}

													%>
													<g:if test="${albumBilder && !albumBilder.isEmpty()}">
														<g:if test="${titelBild.exists()}">
															<img src="${wm_media.mediaPath(albumId: albumInstance.id)}${titelBild.getThumbNailURL()}" alt="${titelBild.baseName}"/>
														</g:if>
													</g:if>

													<g:else>
														<img src="${resource(dir: 'images', file: 'nopicavailable.gif')}" alt="Kein Bild verfügbar"/>
													</g:else>
												</g:link>

												<jsec:isLoggedIn>
													<p class="meta" style="text-align: right;">
														<img src="${resource(dir: 'images/skin', file: 'database_edit.png')}" alt="Album ändern" />
														<g:link controller="album" action="edit" id="${albumInstance.id}">
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
						<img src="${resource(dir: 'images/skin', file: 'database_add.png')}" alt="Album erstellen" />
						<g:link controller="album" action="create">
							Neues Album anlegen
						</g:link>
					</jsec:isLoggedIn>
				</g:if>
				<g:else>
					Es sind noch keine Fotoalben vorhanden ...
					<br />
					<br />
					<jsec:isLoggedIn>
						<img src="${resource(dir: 'images/skin', file: 'database_add.png')}" alt="Album erstellen" />
						<g:link controller="album" action="create">
							Neues Album anlegen
						</g:link>
					</jsec:isLoggedIn>
				</g:else>
            </div>
        </div>
    </body>
</html>
