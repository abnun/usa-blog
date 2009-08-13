
<%@ page import="de.webmpuls.blog.Post" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Post List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Post</g:link></span>
        </div>
        <div class="body">
            <h1>Post List</h1>
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
                        
                   	        <g:sortableColumn property="dateCreated" title="Erstellt am" />
                        
                   	        <th>Verfasser</th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${postInstanceList}" status="i" var="postInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${postInstance.id}">${fieldValue(bean:postInstance, field:'id')}</g:link></td>
                        
                            <td>${postInstance.titel}</td>
                        
                            <td>${postInstance.inhalt}</td>
                        
                            <td><g:formatDate date="${postInstance.dateCreated}" format="dd.MM.yyyy" /></td>
                        
                            <td>${fieldValue(bean:postInstance, field:'verfasser')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${postInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
