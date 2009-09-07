
<%@ page import="de.webmpuls.blog.Media.MediaUtils; de.webmpuls.blog.Album; de.webmpuls.blog.Bild" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'uploadify.css')}" />
		<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'swfobject.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.uploadify.v2.1.0.min.js')}"></script>

		<%
		    Album tmpAlbum = Album.get(params.album.id)

			String albumDate = ""
			if(tmpAlbum)
			{
				albumDate = formatDate(date: tmpAlbum.dateCreated, format: 'ddMMyyyy')
			}

		%>
		<jq:jquery>

			$('#albumFotos').uploadify({
				'uploader'  		: '${resource(dir: 'js/jquery', file: 'uploadify.swf')}',
				'script'    		: '${createLink(controller: 'bild', action: 'uploadFotos')}',
				'cancelImg' 		: '${resource(dir: 'images', file: 'cancel.png')}',
				'auto'      		: false,
				'fileDataName'		: 'fotos',
				'multi'				: true,
				'method'			: 'POST',
				'buttonText'		: 'Bilder waehlen',
				'fileDesc'			: 'Erlaubte Datei-Typen',
				'fileExt'			: '*.jpg;*.gif;*.JPG;*.jpeg;*.JPEG;*.GIF;*.png;*.PNG;*.avi;*.AVI',
				'folder'    		: '/${MediaUtils.DEFAULT_FOLDER}_${tmpAlbum.toString()}_${albumDate}',
				%{--'onComplete'		: function (evt, queueID, fileObj, response, data) { alert("Response: "+response);},--}%
				'onAllComplete'	: function(event, uploadObj) { alert(uploadObj.filesUploaded + ' Bild(er) hochgeladen. Anzahl der Fehler: ' + uploadObj.errors);},
				'onError'			: function(event, ID, fileObj, errorObj) { alert("Fehler: "+errorObj.info);}
			});

			$('#startUpload').click(function(){
			   	var queryString = { 'album.id': '${params.album.id}', 'rotate': $('#rotate').val() };
   				$('#albumFotos').uploadifySettings('scriptData', queryString);
        		$('#albumFotos').uploadifyUpload();
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

			Hier kannst du ein oder mehrere Bilder zum Album '${Album.get(params.album.id)?.name}' hochladen.
			<br />
			<br />
			<input type="file" name="albumFotos" id="albumFotos" />
			<br />
			Um <g:textField name="rotate" />° im Uhrzeigersinn drehen?
			<br />
			<br />
			<a id="startUpload" href="javascript:void(0);">Upload starten</a> | <a href="javascript:$('#albumFotos').uploadifyClearQueue();">Queue löschen</a>
			<br />
			<br />
			<g:link controller="album" action="show" id="${params.album.id}"><- Zurück zum Album</g:link>
        </div>
    </body>
</html>
