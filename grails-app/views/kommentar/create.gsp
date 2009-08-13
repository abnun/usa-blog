
<%@ page import="de.webmpuls.blog.Kommentar" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Neuen Kommentar erstellen</title>
    </head>
    <body>
		<jsec:isLoggedIn>
			<div class="nav">
				<span class="menuButton"><a class="home" href="${resource(dir: '')}">Home</a></span>
				<span class="menuButton"><g:link class="list" action="list">Kommentar List</g:link></span>
			</div>
		</jsec:isLoggedIn>
        <div class="body">
            <h1>Neuen Kommentar erstellen</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${kommentarInstance}">
            <div class="errors">
                <g:renderErrors bean="${kommentarInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>

							<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="verfasser">Verfasser:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:kommentarInstance,field:'verfasser','errors')}">
                                    <input type="text" id="verfasser" name="verfasser" value="${fieldValue(bean:kommentarInstance,field:'verfasser')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="titel">Titel:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:kommentarInstance,field:'titel','errors')}">
                                    <input type="text" id="titel" name="titel" value="${fieldValue(bean:kommentarInstance,field:'titel')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inhalt">Inhalt:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:kommentarInstance,field:'inhalt','errors')}">
                                    <textarea rows="5" cols="40" name="inhalt">${fieldValue(bean:kommentarInstance, field:'inhalt')}</textarea>
                                </td>
                            </tr> 
                        
                            %{--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated">Date Created:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:kommentarInstance,field:'dateCreated','errors')}">
                                    <g:datePicker name="dateCreated" value="${kommentarInstance?.dateCreated}" precision="minute" ></g:datePicker>
                                </td>
                            </tr>--}% 

							<input type="hidden" name="post.id" value="${params.postId ?: kommentarInstance?.post?.id}" />

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
