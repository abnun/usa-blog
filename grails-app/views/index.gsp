<html>
    <head>
        <title>USA Blog: Claudi und Markus</title>
		<meta name="layout" content="main" />
    </head>
    <body>
        <div class="dialog" style="margin-left:20px;width:60%;">

			<ul>
              <g:each var="c" in="${grailsApplication.controllerClasses}">
                    <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
              </g:each>
            </ul>
        </div>

		<g:include controller="post" action="list_frontend" />

    </body>
</html>