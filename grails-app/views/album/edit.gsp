
<%@ page import="de.webmpuls.blog.Album" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Album editieren</title>
    </head>
    <body>
        <div class="body">
            <h1>Album editieren</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${albumInstance}">
            <div class="errors">
                <g:renderErrors bean="${albumInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${albumInstance?.id}" />
                <input type="hidden" name="version" value="${albumInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:albumInstance,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:albumInstance,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sichtbar">Sichtbar:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:albumInstance,field:'sichtbar','errors')}">
                                    <g:checkBox name="sichtbar" value="${albumInstance?.sichtbar}" ></g:checkBox>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="beschreibung">Beschreibung:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:albumInstance,field:'beschreibung','errors')}">
                                    <textarea rows="5" cols="40" name="beschreibung">${fieldValue(bean:albumInstance, field:'beschreibung')}</textarea>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bilder">Bilder:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:albumInstance,field:'bilder','errors')}">
                                    
<ul>
<g:each var="b" in="${albumInstance?.bilder?}">
    <li><g:link controller="bild" action="edit" id="${b.id}">${b?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="bild" params="['album.id':albumInstance?.id]" action="create">Bilder hinzufügen</g:link>

                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="Ändern" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Wirklich löschen?');" action="delete" value="Löschen" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
