package de.webmpuls.blog

class Album
{
	static hasMany = [bilder: Bild]

	Date dateCreated

	String name
	String beschreibung
	boolean sichtbar = true

	static mapping =
	{
		sort("dateCreated")
		order("desc")
		cache(true)
		bilder(sort: 'dateCreated', order: 'desc')
	}

    static constraints =
	{
		name(blank: false)
		sichtbar()
		beschreibung(widget: 'textarea')
		dateCreated(display: false)
    }

	public String toString()
	{
		String result = name.replaceAll(' ', '_')
		return result
	}
}
