
<%@ page import="de.webmpuls.blog.News" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>News List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New News</g:link></span>
        </div>
        <div class="body">
            <h1>News List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="titel" title="Titel" />
                        
                   	        <g:sortableColumn property="inhalt" title="Inhalt" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${newsInstanceList}" status="i" var="newsInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${newsInstance.id}">${fieldValue(bean:newsInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:newsInstance, field:'titel')}</td>
                        
                            <td>${fieldValue(bean:newsInstance, field:'inhalt')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${newsInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
