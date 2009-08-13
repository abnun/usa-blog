package de.webmpuls.blog

import de.webmpuls.blog.Album
import de.webmpuls.blog.Media.MediaUtils
import org.codehaus.groovy.grails.commons.ApplicationHolder

class Bild
{
	static transients = ['URL', 'thumbNailURL', 'bigURL', 'exists']
	
	static belongsTo = [album: Album]

	Date dateCreated
	
	String baseName
	String bildUnterschrift
	boolean titelBild = false

	static mapping =
	{
		sort("dateCreated")
		order("desc")
		cache(true)
	}

    static constraints =
	{
		baseName()
		titelBild()
		bildUnterschrift(nullable: true, blank: true)
		dateCreated(display: false)
		URL(display: false)
		thumbNailURL(display: false)
    }

	public String getURL()
	{
		return "${baseName}${MediaUtils.NORMAL}${MediaUtils.SUFFIX}"
	}

	public String getBigURL()
	{
		return "${baseName}${MediaUtils.BIG}${MediaUtils.SUFFIX}"
	}

	public String getThumbNailURL()
	{
		return "${baseName}${MediaUtils.THUMBNAIL}${MediaUtils.SUFFIX}"
	}

	public boolean exists()
	{
		String tmpFilePath = "${File.separator}${MediaUtils.DEFAULT_UPLOADS_FOLDER}${File.separator}${MediaUtils.DEFAULT_FOLDER}_${album.id}${File.separator}${getURL()}"
		boolean exists = ApplicationHolder.getApplication().getMainContext().getResource(tmpFilePath).getFile().exists()
		println("File '${tmpFilePath}' does${exists ? '' : ' not'} exist")
		return exists
	}
}