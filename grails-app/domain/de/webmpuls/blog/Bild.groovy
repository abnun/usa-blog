package de.webmpuls.blog

import de.webmpuls.blog.Album
import de.webmpuls.blog.Media.MediaUtils
import org.codehaus.groovy.grails.commons.ApplicationHolder
import java.text.SimpleDateFormat

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
		bigURL(display: false)
		tempURL(display: false)
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
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("ddMMyyyy")
		String albumDate = simpleDateFormat.format(album.dateCreated)

		String tmpFilePath = "${File.separator}${MediaUtils.DEFAULT_UPLOADS_FOLDER}${File.separator}${MediaUtils.DEFAULT_FOLDER_IMAGE}${File.separator}${MediaUtils.DEFAULT_FOLDER}_${album.toString()}_${albumDate}${File.separator}"

		String tmpFilePathBig = "${tmpFilePath}${getBigURL()}"
		String tmpFilePathNormal = "${tmpFilePath}${getURL()}"
		String tmpFilePathThumbNail = "${tmpFilePath}${getThumbNailURL()}"
		boolean bigExists = ApplicationHolder.getApplication().getMainContext().getResource(tmpFilePathBig).getFile().exists()
		boolean normalExists = ApplicationHolder.getApplication().getMainContext().getResource(tmpFilePathNormal).getFile().exists()
		boolean thumbNailExists = ApplicationHolder.getApplication().getMainContext().getResource(tmpFilePathThumbNail).getFile().exists()
		boolean exists = bigExists && normalExists && thumbNailExists
		if(!exists)
		{
			println("File '${tmpFilePathNormal}' does${exists ? '' : ' not'} exist")
		}
		return exists
	}

	public String toString()
	{
		return baseName
	}
}