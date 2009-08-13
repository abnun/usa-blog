
<%@ page import="de.webmpuls.blog.Bild" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Bild List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Bild</g:link></span>
        </div>
        <div class="body">
            <h1>Bild List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="baseName" title="Base Name" />
                        
                   	        <g:sortableColumn property="titelBild" title="Titel Bild" />
                        
                   	        <g:sortableColumn property="bildUnterschrift" title="Bild Unterschrift" />
                        
                   	        <g:sortableColumn property="dateCreated" title="Date Created" />
                        
                   	        <g:sortableColumn property="URL" title="URL" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${bildInstanceList}" status="i" var="bildInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${bildInstance.id}">${fieldValue(bean:bildInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:bildInstance, field:'baseName')}</td>
                        
                            <td>${fieldValue(bean:bildInstance, field:'titelBild')}</td>
                        
                            <td>${fieldValue(bean:bildInstance, field:'bildUnterschrift')}</td>
                        
                            <td>${fieldValue(bean:bildInstance, field:'dateCreated')}</td>
                        
                            <td>${fieldValue(bean:bildInstance, field:'URL')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${bildInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
