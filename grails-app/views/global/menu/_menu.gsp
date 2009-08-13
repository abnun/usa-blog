<div id="menu">
	<ul>
		<li><a href="${resource(dir: '')}">Blog</a></li>
		<nav:eachItem group="menutop">
			<li class="${Boolean.valueOf(it.active) ? 'navigation_active' : ''}"><a href="${it.link}">${it.title}</a></li>
		</nav:eachItem>
		%{--<li><a href="${createLink(controller: 'album', action: 'list_frontend')}">Fotoalben</a></li>--}%
		<li><a href="#">Route</a></li>
		<li><a href="#">Kontakt</a></li>
		<li><a href="#">Impressum</a></li>
	</ul>
	<ul>
		<li style="float: right;">
			<jsec:isNotLoggedIn>
				<g:link controller="auth" action="login" style="font-size: 10px;">Einloggen</g:link>
			</jsec:isNotLoggedIn>
			<jsec:isLoggedIn>
				<g:link controller="auth" action="signOut" style="font-size: 10px;">Ausloggen</g:link>
			</jsec:isLoggedIn>
		</li>
	</ul>
</div>
<!-- end #menu -->