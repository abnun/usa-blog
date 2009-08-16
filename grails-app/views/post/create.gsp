
<%@ page import="de.webmpuls.blog.JsecUser; de.webmpuls.blog.Post" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Neuen Post schreiben</title>
    </head>
    <body>
        <div class="body">
            <h1>Neuen Post schreiben</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${postInstance}">
            <div class="errors">
                <g:renderErrors bean="${postInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table style="width: 100%;">
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="titel">Titel:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:postInstance,field:'titel','errors')}">
                                    <input type="text" id="titel" name="titel" value="${fieldValue(bean:postInstance,field:'titel')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inhalt">Inhalt:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:postInstance,field:'inhalt','errors')}">
									<fckeditor:editor
											name="inhalt"
											width="100%"
											height="500"
											toolbar="Standard"
											fileBrowser="default">
										${postInstance?.inhalt}
									</fckeditor:editor>
                                    %{--<textarea rows="5" cols="40" name="inhalt">${fieldValue(bean:postInstance, field:'inhalt')}</textarea>--}%
                                </td>
                            </tr>

							%{--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated">Date Created:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:postInstance,field:'dateCreated','errors')}">
                                    <g:datePicker name="dateCreated" value="${postInstance?.dateCreated}" precision="minute" ></g:datePicker>
                                </td>
                            </tr> --}%
                        	
                            <input type="hidden" name="verfasser.id" value="${JsecUser.findByUsername(jsec.principal())?.id}" />
                        
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
