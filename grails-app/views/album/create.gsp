
<%@ page import="de.webmpuls.blog.Album" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Album erstellen</title>
    </head>
    <body>
        <div class="body">
            <h1>Album erstellen</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${albumInstance}">
            <div class="errors">
                <g:renderErrors bean="${albumInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
                                    <label for="sichtbar">Sichtbar im Web:</label>
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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Erstellen" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
