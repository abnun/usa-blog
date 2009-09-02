import org.jsecurity.crypto.hash.Sha1Hash
import de.webmpuls.blog.JsecRole
import de.webmpuls.blog.JsecUser
import de.webmpuls.blog.JsecUserRoleRel
import de.webmpuls.blog.Post
import de.webmpuls.blog.Sex
import org.codehaus.groovy.grails.commons.ConfigurationHolder

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
				Post post1 = new Post(titel: "Hallöchen...",
						inhalt: '''<p>...ihr armen und gr&ouml;&szlig;tenteils arbeitenden Daheimgebliebenen,</p>
<p>damit ihr uns in den n&auml;chsten drei Wochen nicht allzu sehr vermisst und auch ab und zu was von uns h&ouml;rt, haben wir (na ja, gut, Markus) einen Blog f&uuml;r unsere USA-Reise erstellt.</p>
<p>Hier k&ouml;nnt ihr jeden Tag lesen und sehen</p>
<ul>
    <li>ob wir in New York neben Shopping auch noch Zeit f&uuml;r Freiheitsstatue und Co gehabt haben,</li>
    <li>ob wir in Las Vegas unsere letzte Kohle verzockt oder doch die Dollarzeichen geleuchtet und wir uns von Elvis (oder macht das jetzt Michael????) am 09.09.09 haben trauen lassen,</li>
    <li>ob unser Mietwagen die Hitze des Death Valleys und wir die B&auml;ren im Yosemite Nationalpark &uuml;berlebt haben und</li>
    <li>ob wir in San Francisco in Schlaghosen mit den Hippies gefeiert oder welche Stars wir in Hollywood getroffen haben.</li>
</ul>
<p>Nat&uuml;rlich freuen wir uns auch &uuml;ber ein paar News von zuhause, wie das Weindorf so ist, wer mit wem und vor allem wann und wo, was der kleine Zwerg so macht und wie es Herrn Oleander so geht.....<br />
<br />
Also, viel Spa&szlig; beim Lesen, Fotos schauen und Kommentieren! :-)</p>
<p>Claudi &amp; Markus</p>
<p>PS: Und trinkt ein, zwei, drei Fl&auml;schen auf dem Weindorf f&uuml;r uns mit..........</p>''',
						verfasser: adminUser2).save(flush: true)
			}

			println("###########################")
			println("###########################")
			println(ConfigurationHolder.getConfig().flatten().toMapString())
	}
	def destroy =
	{
	}
} 