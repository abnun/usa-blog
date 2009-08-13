
<%@ page import="de.webmpuls.blog.News" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Neue News erstellen</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">News List</g:link></span>
        </div>
        <div class="body">
            <h1>Neue News erstellen</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${newsInstance}">
            <div class="errors">
                <g:renderErrors bean="${newsInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
                    <span class="button"><input class="save" type="submit" value="Erstellen" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
