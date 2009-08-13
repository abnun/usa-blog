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
			String tmpPath = "${request.getContextPath()}/uploads/${MediaUtils.DEFAULT_FOLDER}_${attrs['albumId']}/"

			out << tmpPath
		}

		return out
	}

}
