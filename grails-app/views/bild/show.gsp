
<%@ page import="de.webmpuls.blog.Bild" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Bild</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Bild List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Bild</g:link></span>
        </div>
        <div class="body">
            <h1>Show Bild</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:bildInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Base Name:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:bildInstance, field:'baseName')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Titel Bild:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:bildInstance, field:'titelBild')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Bild Unterschrift:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:bildInstance, field:'bildUnterschrift')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Date Created:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:bildInstance, field:'dateCreated')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">URL:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:bildInstance, field:'URL')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Thumb Nail URL:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:bildInstance, field:'thumbNailURL')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Album:</td>
                            
                            <td valign="top" class="value"><g:link controller="album" action="show" id="${bildInstance?.album?.id}">${bildInstance?.album?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${bildInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Wirklich loeschen?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
