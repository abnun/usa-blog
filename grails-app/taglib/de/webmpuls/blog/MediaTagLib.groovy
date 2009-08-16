package de.webmpuls.blog

import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import de.webmpuls.blog.Media.MediaUtils

class MediaTagLib
{
	static namespace = "wm_media"
	/**
	 * Gibt den Pfad zu den Bilder zurück.
	 */
	def mediaPath =
	{
		attrs ->

		if(!attrs['albumId'])
		{
			throwTagError('Tag [mediaPath] missing required attribute [albumId].')
		}
		else
		{
			Album tmpAlbum = Album.get(attrs['albumId'])
			
			String albumDate = formatDate(date: tmpAlbum.dateCreated, format: 'ddMMyyyy')

			String tmpPath = "${request.getContextPath()}/${MediaUtils.DEFAULT_UPLOADS_FOLDER}/${MediaUtils.DEFAULT_FOLDER_IMAGE}/${MediaUtils.DEFAULT_FOLDER}_${tmpAlbum.toString()}_${albumDate}/"

			out << tmpPath
		}

		return out
	}

}
