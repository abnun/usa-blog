package de.webmpuls.blog

class JsecUser {
    String username
    String passwordHash
	Sex sex

    static constraints = {
        username(nullable: false, blank: false)
        sex(nullable: false, blank: false)
    }

	public String toString()
	{
		return username
	}
}
