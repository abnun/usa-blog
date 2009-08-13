
<%@ page import="de.webmpuls.blog.Post" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Post</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Post List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Post</g:link></span>
        </div>
        <div class="body">
            <h1>Show Post</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:postInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Titel:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:postInstance, field:'titel')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Inhalt:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:postInstance, field:'inhalt')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Erstellt am:</td>

							<td valign="top" class="value"><g:formatDate date="${postInstance.dateCreated}" format="dd.MM.yyyy" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Verfasser:</td>
                            
                            <td valign="top" class="value"><g:link controller="jsecUser" action="show" id="${postInstance?.verfasser?.id}">${postInstance?.verfasser?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Kommentare:</td>
                            
                            <td  valign="top" style="text-align:left;" class="value">
                                <ul>
                                <g:each var="k" in="${postInstance.kommentare}">
                                    <li><g:link controller="kommentar" action="show" id="${k.id}">${k?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${postInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
