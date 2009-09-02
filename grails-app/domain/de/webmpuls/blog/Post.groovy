package de.webmpuls.blog

class Post extends BlogItem
{
	static hasMany = [kommentare: Kommentar]

	Date dateCreated
	Date lastUpdated

	JsecUser verfasser

	static mapping =
	{
		sort("dateCreated")
		order("desc")
		cache(true)
		kommentare(sort: 'dateCreated', order: 'desc')
	}

    static constraints =
	{
		titel(nullable: false, blank: false)
		inhalt(nullable: false, blank: false, widget: 'textarea')
		archive(nullable: true)
		dateCreated(display: false)
		lastUpdated(display: false)
		verfasser(display: false)
    }
}
