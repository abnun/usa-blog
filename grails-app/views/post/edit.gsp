
<%@ page import="de.webmpuls.blog.JsecUser; de.webmpuls.blog.Post" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Post '${fieldValue(bean:postInstance,field:'titel')}' editieren</title>
    </head>
    <body>
        <div class="body">
            <h1>Post '${fieldValue(bean:postInstance,field:'titel')}' editieren</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${postInstance}">
            <div class="errors">
                <g:renderErrors bean="${postInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${postInstance?.id}" />
                <input type="hidden" name="version" value="${postInstance?.version}" />
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
                                    %{--<textarea rows="5" cols="40" name="inhalt">${fieldValue(bean:postInstance, field:'inhalt')}</textarea>--}%
									<fckeditor:editor
											name="inhalt"
											width="100%"
											height="500"
											toolbar="Standard"
											fileBrowser="default">
										${postInstance?.inhalt}
									</fckeditor:editor>
                                </td>
                            </tr> 
                        
                            %{--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated">Date Created:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:postInstance,field:'dateCreated','errors')}">
                                    <g:datePicker name="dateCreated" value="${postInstance?.dateCreated}" precision="minute" ></g:datePicker>
                                </td>
                            </tr>--}% 
                        
                            <input type="hidden" name="verfasser.id" value="${JsecUser.findByUsername(jsec.principal())?.id}" />
                        
                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="kommentare">Kommentare:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:postInstance,field:'kommentare','errors')}">
                                    <g:select name="kommentare"
from="${de.webmpuls.blog.Kommentar.list()}"
size="5" multiple="yes" optionKey="id"
value="${postInstance?.kommentare}" />

                                </td>
                            </tr>--> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Ändern" action="update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Wirklich löschen?');" value="Löschen" action="delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
