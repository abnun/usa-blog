
<%@ page import="de.webmpuls.blog.Media.MediaUtils; de.webmpuls.blog.Album; de.webmpuls.blog.Bild" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'uploadify.css')}" />
		<g:javascript library="jquery" />
		<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'swfobject.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.uploadify.v2.0.3.js')}"></script>
		<jq:jquery>
			$('#albumFotos').uploadify({
				'uploader'  		: '${resource(dir: 'js/jquery', file: 'uploadify.swf')}',
				'script'    		: '${createLink(controller: 'bild', action: 'uploadFotos')}',
				'cancelImg' 		: '${resource(dir: 'images', file: 'cancel.png')}',
				'auto'      		: true,
				'fileDataName'		: 'fotos',
				'multi'				: true,
				'buttonText'		: 'Fotos auswaehlen',
				'fileDesc'			: 'Erlaubte Datei-Typen',
				'fileExt'			: '*.jpg;*.gif;*.JPG;*.jpeg;*.JPEG;*.GIF;*.png;*.PNG',
				'folder'    : '/${MediaUtils.DEFAULT_FOLDER}_${params.album.id}',
				'scriptData'		: {'album.id': '${params.album.id}'}
			});
		</jq:jquery>
        <title>Bilder hochladen</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${bildInstance}">
            <div class="errors">
                <g:renderErrors bean="${bildInstance}" as="list" />
            </div>
            </g:hasErrors>

			Hier kannst du ein oder mehrere Bilder zum Album '${Album.get(params.album.id)}' hochladen.
			<br />
			<br />
			<input type="file" name="albumFotos" id="albumFotos" />
			<br />
			<a href="javascript:$('#albumFotos').uploadifyClearQueue();">Queue löschen</a>
			<br />
			<br />
			<g:link controller="album" action="show" id="${params.album.id}"><- Zurück zum Album</g:link>
        </div>
    </body>
</html>
