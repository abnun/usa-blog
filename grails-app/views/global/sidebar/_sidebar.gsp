<div id="sidebar">
	<ul>
		<li>
			<g:include controller="news" action="show_frontend" />
		</li>
		<li>
			<jsec:isLoggedIn>
				<g:render template="/user/show_account_overview" />
			</jsec:isLoggedIn>
		</li>
		<!--<li>
			<h2>Categories</h2>
			<ul>
				<li><a href="#">Uncategorized</a> (3)</li>
				<li><a href="#">Lorem Ipsum</a> (42)</li>
				<li><a href="#">Urna Congue Rutrum</a> (28)</li>
				<li><a href="#">Augue Praesent</a> (55)</li>
				<li><a href="#">Vivamus Fermentum</a> (13)</li>
			</ul>
		</li>
		<li>
			<h2>Archives</h2>
			<ul>
				<li><a href="#">December 2007</a>&nbsp;(29)</li>
				<li><a href="#">November 2007</a>&nbsp;(30)</li>
				<li><a href="#">October 2007</a>&nbsp;(31)</li>
				<li><a href="#">September 2007</a>&nbsp;(30)</li>
			</ul>
		</li>-->
	</ul>
</div>
<!-- end #sidebar -->