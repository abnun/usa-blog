<%@ page import="de.webmpuls.blog.Bild; de.webmpuls.blog.Album" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Fotoalben anzeigen</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
				<g:if test="${albumInstanceList}">
					<%
					    boolean showInfo = false
					    albumInstanceList.findAll
						{
							Album albumInstance ->
							if(albumInstance.sichtbar)
							{
								showInfo = true
							}
						}
					%>
					<g:if test="${showInfo}">
						<p>
							Um ein Album anzusehen, einfach auf das jeweilige Bild klicken.
						</p>
					</g:if>
					<g:else>
						Es sind noch keine Fotoalben vorhanden ...
					</g:else>
					<table>
						<g:each in="${albumInstanceList}" status="i" var="albumInstance">
							<g:if test="${albumInstance.sichtbar || jsec.principal()}">
								<g:if test="${i % 3 == 0}">
									<tr>
								</g:if>
										<td>
											<div class="thumbwrapper">
												<g:link action="show" id="${albumInstance.id}">
													<p class="meta">
														<b>${fieldValue(bean: albumInstance, field: 'name')}</b>
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
													<g:if test="${albumBilder && !albumBilder.isEmpty() && titelBild.exists()}">
														<img src="${wm_media.mediaPath(albumId: albumInstance.id)}${titelBild.getThumbNailURL()}" alt="${titelBild.baseName}"/>
													</g:if>
													<g:else>
														<img src="${resource(dir: 'images', file: 'nopicavailable.gif')}" alt="Kein Bild verfügbar"/>
													</g:else>
												</g:link>

												<jsec:isLoggedIn>
													<g:form name="DeleteAlbumForm_${albumInstance.id}" method="post" controller="album" action="delete" id="${albumInstance.id}"></g:form>
													<p class="meta" style="text-align: center;">
														<img src="${resource(dir: 'images/skin', file: 'database_delete.png')}" alt="Album löschen" />
														<a href="javascript: void(0);" onclick="if(confirm('Wirklich löschen?')) { document.forms['DeleteAlbumForm_${albumInstance.id}'].submit();}">
															<span style="text-align: left;">löschen</span>
														</a>
														<img src="${resource(dir: 'images/skin', file: 'database_edit.png')}" alt="Album ändern" />
														<g:link controller="album" action="edit" id="${albumInstance.id}">
															<span style="text-align: right;">ändern</span>
														</g:link>
													</p>
												</jsec:isLoggedIn>

											</div>
								<g:if test="${i > 1 && ((i + 1) % 3) == 0}">
									</tr>
								</g:if>
							</g:if>
						</g:each>
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
