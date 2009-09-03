
<%@ page import="de.webmpuls.blog.News" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>News editieren</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">News List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New News</g:link></span>
        </div>
        <div class="body">
            <h1>News editieren</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${newsInstance}">
            <div class="errors">
                <g:renderErrors bean="${newsInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${newsInstance?.id}" />
                <input type="hidden" name="version" value="${newsInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="titel">Titel:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsInstance,field:'titel','errors')}">
                                    <input type="text" id="titel" name="titel" value="${fieldValue(bean:newsInstance,field:'titel')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inhalt">Inhalt:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsInstance,field:'inhalt','errors')}">
                                    <textarea rows="5" cols="40" name="inhalt">${fieldValue(bean:newsInstance, field:'inhalt')}</textarea>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Aendern" action="update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Wirklich loeschen?');" action="delete" value="Loeschen" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
