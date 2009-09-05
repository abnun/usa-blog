<%@ page import="de.webmpuls.blog.Kommentar; de.webmpuls.blog.Post" %>
<%
    Post tmpPost = post
%>
<jsec:isLoggedIn>
	<g:javascript>
		function deletePostOrComment(formName)
		{
			if (confirm('Wirklich löschen?'))
			{
				document.forms[formName].submit();
			}
		}
	</g:javascript>
</jsec:isLoggedIn>
	<g:javascript>
		function toggleComments(id)
		{
			$('#truncatedComments_' + id).slideToggle("slow");
			$('#allComments_' + id).slideToggle("slow");
		}
	</g:javascript>

<div class="post">
	<div class="post_date">
		<span class="day"><g:formatDate date="${tmpPost.dateCreated}" format="dd" /></span><br/>
		<span class="month"><g:formatDate date="${tmpPost.dateCreated}" format="MM" /></span><br/>
		<span class="year"><g:formatDate date="${tmpPost.dateCreated}" format="yyyy" /></span>
	</div>
	<h1 class="title"><a name="#${tmpPost.titel}"></a>${tmpPost.titel}</h1>
	<p class="meta">Geschrieben von: <a href="javascript: void(0);">${tmpPost.verfasser?.username}</a>
	&nbsp;&bull;&nbsp; <g:if test="${tmpPost.kommentare}"><a href="#comments_${tmpPost.id}" class="comments">Kommentare (${tmpPost.kommentare ? tmpPost.kommentare.size() : '0'})</a></g:if><g:else><b style="color: black;">Kommentare (${tmpPost.kommentare ? tmpPost.kommentare.size() : '0'})</b></g:else><!-- &nbsp;&bull;&nbsp; <a href="#" class="permalink">Full article</a></p>-->
	<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <g:link controller="post" action="archive" id="${tmpPost.id}">Archiv (ja/nein)</g:link></jsec:hasRole>
	<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <g:link controller="post" action="edit" id="${tmpPost.id}">Ändern</g:link></jsec:hasRole>
	<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <g:link controller="post" action="edit2" id="${tmpPost.id}">Ändern (iPhone)</g:link></jsec:hasRole>
	<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <a href="javascript: deletePostOrComment('PostForm_${tmpPost.id}');">Löschen</a></jsec:hasRole>
	<g:form name="PostForm_${tmpPost.id}" controller="post" action="delete" id="${tmpPost.id}" method="post">
	</g:form>
	<div class="entry">
		${tmpPost.inhalt}
	</div>
</div>
<br />
<img src="${resource(dir: 'images/skin', file: 'database_add.png')}" alt="Neuer Kommentar" /> <g:link class="create" controller="kommentar" action="create" params="[postId: tmpPost.id]">Neuer Kommentar zu diesem Post</g:link>
<br />
<br />
	<g:if test="${tmpPost.kommentare}">
		<%
			int i = 0
			ArrayList tmpCommentList = tmpPost.kommentare?.sort{Kommentar a, Kommentar b -> b.dateCreated <=> a.dateCreated}.asList()
		%>
		<p class="meta" style="font-size: 11px; background-color: #efeffe;">Kommentare zu diesem Post:</p>
		<a name="comments_${tmpPost.id}"></a>
		<div id="truncatedComments_${tmpPost.id}">
			<g:while test="${i < 5 && (tmpCommentList != null && !tmpCommentList.isEmpty() && tmpCommentList.size() > i)}">
				<div class="post">
					<h3 class="title" style="font-size: 1.3em;">${tmpCommentList[i].titel != null ? tmpCommentList[i].titel.encodeAsHTML() : ''}</h3>
					<p class="meta">Geschrieben von: <b style="color: black;">${tmpCommentList[i].verfasser.encodeAsHTML()}</b> am <g:formatDate date="${tmpCommentList[i].dateCreated}" format="dd.MM.yyyy"/>
						<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <a href="javascript: deletePostOrComment('KommentarForm_${tmpCommentList[i].id}');">Kommentar löschen</a></jsec:hasRole>
						<g:form name="KommentarForm_${tmpCommentList[i].id}" controller="kommentar" action="delete" id="${tmpCommentList[i].id}" method="post">
						</g:form>
					</p>
					<div class="entry">
						${tmpCommentList[i].inhalt.encodeAsHTML()}
					</div>
				</div>
				<% i++ %>
				<g:if test="${i > 4 && tmpCommentList.size() > i}">
					Es werden fünf von ${tmpCommentList.size()} Kommentaren angezeigt. <a href="javascript:void(0);" onclick="toggleComments(${tmpPost.id});"><b>Hier</b></a> klicken
					um alle Kommentare zu diesem Post anzuzeigen.
					<br />
					<br />
				</g:if>
			</g:while>
		</div>
		<div id="allComments_${tmpPost.id}" style="display: none;">
			<g:if test="${tmpCommentList}">
				<g:each in="${tmpCommentList}" var="${tmpComment}">
					<div class="post">
						<h3 class="title" style="font-size: 1.3em;">${tmpComment.titel != null ? tmpComment.titel.encodeAsHTML() : ''}</h3>
						<p class="meta">Geschrieben von: <b style="color: black;">${tmpComment.verfasser.encodeAsHTML()}</b> am <g:formatDate date="${tmpComment.dateCreated}" format="dd.MM.yyyy"/>
							<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <a href="javascript: deletePostOrComment('KommentarForm_${tmpComment.id}');">Kommentar löschen</a></jsec:hasRole>
							<g:form name="KommentarForm_${tmpComment.id}" controller="kommentar" action="delete" id="${tmpComment.id}" method="post">
							</g:form>
						</p>
						<div class="entry">
							${tmpComment.inhalt.encodeAsHTML()}
						</div>
					</div>
				</g:each>
			</g:if>
		</div>
	</g:if>
<br />
<br />
<br />