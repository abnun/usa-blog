import org.jsecurity.crypto.hash.Sha1Hash
import de.webmpuls.blog.JsecRole
import de.webmpuls.blog.JsecUser
import de.webmpuls.blog.JsecUserRoleRel
import de.webmpuls.blog.Post
import de.webmpuls.blog.Sex

class BootStrap
{

	def init =
	{
		servletContext ->

		// Administrator user and role if none exist.
		def roles = JsecRole.list()
		def users = JsecUser.list()

		Integer rolesSize = roles.size()
		Integer usersSize = users.size()

		JsecRole adminRole = null
		JsecUser adminUser1 = null
		JsecUser adminUser2 = null
		if(rolesSize == 0 && usersSize == 0)
		{
			adminRole = new JsecRole(name: "Administrator").save()
			adminUser1 = new JsecUser(username: "Markus", passwordHash: new Sha1Hash("xkermitS01").toHex(), sex: Sex.MALE).save()
			adminUser2 = new JsecUser(username: "Claudi", passwordHash: new Sha1Hash("13schlumpfine").toHex(), sex: Sex.FEMALE).save()
			new JsecUserRoleRel(user: adminUser1, role: adminRole).save()
			new JsecUserRoleRel(user: adminUser2, role: adminRole).save(flush: true)
		}
			roles = JsecRole.list()
			users = JsecUser.list()

			rolesSize = roles.size()
			usersSize = users.size()

			println("###########################")
			println("There are $rolesSize Roles:")
			for(JsecRole role : roles)
			{
				println("-> $role.name")
			}
			println("###########################")
			println("###########################")
			println("There are $usersSize Users:")
			for(JsecUser user : users)
			{
				println("-> $user.username (${JsecUserRoleRel.findByUser(user)?.role?.name})")
			}

			def posts = Post.list()

			Integer postsSize = posts.size()

			if(postsSize == 0)
			{
				Post post1 = new Post(titel: "Willkommen zu unserem USA Blog",
						inhalt: '''Hier werden wir die nächsten drei Wochen über unseren USA-Urlaub berichten und unsere
						Urlaubsfotos einstellen. <br/><br/>Viel Spaß beim Lesen, Anschauen und Kommentieren! :-)''',
						verfasser: adminUser1).save(flush: true)
			}
	}
	def destroy =
	{
	}
} 