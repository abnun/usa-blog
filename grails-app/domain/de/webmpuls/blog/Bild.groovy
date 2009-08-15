package de.webmpuls.blog

import de.webmpuls.blog.Album
import de.webmpuls.blog.Media.MediaUtils
import org.codehaus.groovy.grails.commons.ApplicationHolder

class Bild
{
	static transients = ['URL', 'thumbNailURL', 'bigURL', 'tempURL', 'exists']
	
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

	public String getTempURL()
	{
		return "${baseName}${MediaUtils.TEMP}${MediaUtils.SUFFIX}"
	}

	public boolean exists()
	{
		String tmpFilePathBig = "${File.separator}${MediaUtils.DEFAULT_UPLOADS_FOLDER}${File.separator}${MediaUtils.DEFAULT_FOLDER}_${album.id}${File.separator}${getBigURL()}"
		String tmpFilePathNormal = "${File.separator}${MediaUtils.DEFAULT_UPLOADS_FOLDER}${File.separator}${MediaUtils.DEFAULT_FOLDER}_${album.id}${File.separator}${getURL()}"
		String tmpFilePathThumbNail = "${File.separator}${MediaUtils.DEFAULT_UPLOADS_FOLDER}${File.separator}${MediaUtils.DEFAULT_FOLDER}_${album.id}${File.separator}${getThumbNailURL()}"
		boolean bigExists = ApplicationHolder.getApplication().getMainContext().getResource(tmpFilePathBig).getFile().exists()
		boolean normalExists = ApplicationHolder.getApplication().getMainContext().getResource(tmpFilePathNormal).getFile().exists()
		boolean thumbNailExists = ApplicationHolder.getApplication().getMainContext().getResource(tmpFilePathThumbNail).getFile().exists()
		boolean exists = bigExists && normalExists && thumbNailExists
		//println("File '${tmpFilePath}' does${exists ? '' : ' not'} exist")
		return exists
	}

	public String toString()
	{
		return baseName
	}
}