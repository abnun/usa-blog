
<%@ page import="de.webmpuls.blog.Bild" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Bild editieren</title>
    </head>
    <body>
        <div class="body">
            <h1>Bild editieren</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${bildInstance}">
            <div class="errors">
                <g:renderErrors bean="${bildInstance}" as="list" />
            </div>
            </g:hasErrors>
			<br />
			<g:form controller="bild" action="rotateFoto" id="${bildInstance.id}">
				Um <g:textField name="rotate" value="${params.rotate ?: ''}" />° im Uhrzeigersinn drehen?
				<br />
				<br />
				<g:submitButton name="rotateSubmit" value="Drehen" />
			</g:form>
			<br />
			<br />
            <g:form method="post" >
                <input type="hidden" name="id" value="${bildInstance?.id}" />
                <input type="hidden" name="version" value="${bildInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="baseName">Base Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:bildInstance,field:'baseName','errors')}">
                                    <input type="text" disabled="disabled" id="baseName" name="baseName" value="${fieldValue(bean:bildInstance,field:'baseName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="titelBild">Titel Bild:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:bildInstance,field:'titelBild','errors')}">
                                    <g:checkBox name="titelBild" value="${bildInstance?.titelBild}" ></g:checkBox>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bildUnterschrift">Bild Unterschrift:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:bildInstance,field:'bildUnterschrift','errors')}">
                                    <input type="text" id="bildUnterschrift" name="bildUnterschrift" value="${fieldValue(bean:bildInstance,field:'bildUnterschrift')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="album">Album:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:bildInstance,field:'album','errors')}">
                                    <g:select optionKey="id" from="${de.webmpuls.blog.Album.list()}" name="album.id" value="${bildInstance?.album?.id}" ></g:select>&nbsp;&nbsp;&nbsp;<g:link controller="album" action="show" id="${bildInstance?.album?.id}">-> Zum Album</g:link>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="Aendern" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Wirklich loeschen?');" action="delete" value="Loeschen" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
