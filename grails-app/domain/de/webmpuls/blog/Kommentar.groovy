package de.webmpuls.blog

class Kommentar extends BlogItem
{
	static belongsTo = [post: Post]

	Date dateCreated

	String verfasser

    static constraints =
	{
		verfasser(blank: false)
		titel(nullable: true, blank: true)
		inhalt(nullable: false, blank: false, widget: "textarea")
		archive(nullable: true)
		dateCreated(display: false)
    }

	static mapping =
	{
		sort("dateCreated")
		order("desc")
		cache(true)
	}

	public String toString()
	{
		return (titel ?: "${inhalt.substring(0, 10)} [...]")
	}
}
