<%@ page import="de.webmpuls.blog.Post" %>
<%
    Post tmpPost = post
%>
<g:javascript>
	function deleteComment(formName)
	{
		if(confirm('Wirklich löschen?'))
		{
			document.forms[formName].submit();
		}
	}
</g:javascript>
<div class="post">
	<h1 class="title"><a name="#${tmpPost.titel}"></a>${tmpPost.titel}</h1>
	<p class="meta">Geschrieben von: <a href="">${tmpPost.verfasser?.username}</a> am <g:formatDate date="${tmpPost.dateCreated}" format="dd.MM.yyyy" />
	&nbsp;&bull;&nbsp; <g:if test="${tmpPost.kommentare}"><a href="#comments_${tmpPost.id}" class="comments">Kommentare (${tmpPost.kommentare ? tmpPost.kommentare.size() : '0'})</a></g:if><g:else><b style="color: black;">Kommentare (${tmpPost.kommentare ? tmpPost.kommentare.size() : '0'})</b></g:else><!-- &nbsp;&bull;&nbsp; <a href="#" class="permalink">Full article</a></p>-->
	<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <g:link controller="post" action="edit" id="${tmpPost.id}">Post ändern</g:link></jsec:hasRole>
	<div class="entry">
		${tmpPost.inhalt}
	</div>
</div>
	<g:if test="${tmpPost.kommentare}">
		<%
			int i = 0
			List tmpCommentList = tmpPost.kommentare?.asList()
		%>
		<p class="meta" style="font-size: 11px; background-color: #efeffe;">Kommentare zu diesem Post:</p>
		<a name="comments_${tmpPost.id}"></a>
		<div class="truncatedComments">
			<g:while test="${i < 3 && (tmpCommentList != null && !tmpCommentList.isEmpty() && tmpCommentList.size() > i)}">
				<g:if test="${i > 0}">
					<!--<br/>-->
				</g:if>
				<div class="post">
					<h3 class="title" style="font-size: 1.3em;">${tmpCommentList[i].titel.encodeAsHTML()}</h3>
					<p class="meta">Geschrieben von: <b style="color: black;">${tmpCommentList[i].verfasser.encodeAsHTML()}</b> am <g:formatDate date="${tmpCommentList[i].dateCreated}" format="dd.MM.yyyy"/>
						<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <a href="javascript: deleteComment('KommentarForm_${tmpCommentList[i].id}');">Kommentar löschen</a></jsec:hasRole>
						<g:form name="KommentarForm_${tmpCommentList[i].id}" controller="kommentar" action="delete" id="${tmpCommentList[i].id}" method="post">
						</g:form>
					</p>
					<div class="entry">
						${tmpCommentList[i].inhalt.encodeAsHTML()}
					</div>
				</div>
				<g:if test="${tmpCommentList.size() > 2}">
					Es werden zwei von ${tmpCommentList.size()} Kommentaren angezeigt. <a href=""><b>Hier</b></a> klicken
					um alle Kommentare zu diesem Post anzuzeigen.
				</g:if>
				<% i++ %>
			</g:while>
		</div>
		<div class="allComments" style="display: none;">
			<g:if test="${tmpCommentList}">
				<g:each in="${tmpCommentList}" var="${tmpComment}">
					<g:if test="${i > 0}">
						<!--<br/>-->
					</g:if>
					<div class="post">
						<h3 class="title" style="font-size: 1.3em;">${tmpComment.titel.encodeAsHTML()}</h3>
						<p class="meta">Geschrieben von: <a href="javascript: void(0);">${tmpComment.verfasser.encodeAsHTML()}</a> am <g:formatDate date="${tmpComment.dateCreated}" format="dd.MM.yyyy"/>
							<jsec:hasRole name="Administrator">&nbsp;&bull;&nbsp; <a href="javascript: deleteComment('KommentarForm_${tmpComment.id}');">Kommentar löschen</a></jsec:hasRole>
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
<img src="${resource(dir: 'images/skin', file: 'database_add.png')}" alt="Neuer Kommentar" /> <g:link class="create" controller="kommentar" action="create" params="[postId: tmpPost.id]">Neuer Kommentar zu diesem Post</g:link>
<br />
<br />
<br />