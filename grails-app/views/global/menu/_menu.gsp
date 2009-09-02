<div id="menu">
	<ul>
		<nav:eachItem group="menutop" actionMatch="true">
			<li class="${Boolean.valueOf(it.active) ? 'navigation_active' : ''}"><a href="${it.link}">${it.title}</a></li>
		</nav:eachItem>
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