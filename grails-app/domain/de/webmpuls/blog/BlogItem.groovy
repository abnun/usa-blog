package de.webmpuls.blog

class BlogItem
{
	String inhalt
	String titel

	Boolean archive = false

	static mapping =
	{
		cache(true)
	}

    static constraints =
	{
		titel(nullable: true, blank: true)
		inhalt(nullable: true, blank: true, widget: 'textarea')
		archive(nullable: true)
    }
}
