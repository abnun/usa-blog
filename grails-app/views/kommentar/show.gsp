
<%@ page import="de.webmpuls.blog.Kommentar" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Kommentar</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Kommentar List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Kommentar</g:link></span>
        </div>
        <div class="body">
            <h1>Show Kommentar</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:kommentarInstance, field:'id')}</td>
                            
                        </tr>

						<tr class="prop">
                            <td valign="top" class="name">Verfasser:</td>

                            <td valign="top" class="value">${kommentarInstance.verfasser}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Titel:</td>

                            <td valign="top" class="value">${kommentarInstance.titel}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Inhalt:</td>

                            <td valign="top" class="value">${kommentarInstance.inhalt}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Erstellt am:</td>

                            <td valign="top" class="value"><g:formatDate date="${kommentarInstance.dateCreated}" format="dd.MM.yyyy" /></td>

                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${kommentarInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Wirklich loeschen?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
