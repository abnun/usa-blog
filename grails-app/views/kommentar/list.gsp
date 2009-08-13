
<%@ page import="de.webmpuls.blog.Kommentar" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Kommentar List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Kommentar</g:link></span>
        </div>
        <div class="body">
            <h1>Kommentar List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />

						    <g:sortableColumn property="verfasser" title="Verfasser" />

                   	        <g:sortableColumn property="titel" title="Titel" />
                        
                   	        <g:sortableColumn property="inhalt" title="Inhalt" />
                        
                   	        <g:sortableColumn property="dateCreated" title="Date Created" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${kommentarInstanceList}" status="i" var="kommentarInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${kommentarInstance.id}">${fieldValue(bean:kommentarInstance, field:'id')}</g:link></td>

							<td>{fieldValue(bean:kommentarInstance, field:'verfasser')}</td>

                            <td>${kommentarInstance.titel}</td>

                            <td>${kommentarInstance.inhalt}</td>

                            <td><g:formatDate date="${kommentarInstance.dateCreated}" format="dd.MM.yyyy" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${kommentarInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
