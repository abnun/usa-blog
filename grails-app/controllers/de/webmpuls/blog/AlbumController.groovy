package de.webmpuls.blog

import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import de.webmpuls.blog.Media.MediaUtils

class AlbumController
{
	static navigation = [
		group: 'menutop',
		order: 30,
		title: 'Fotoalben',
		action: 'list_frontend'
	]

	def index =
	{
		redirect(action: list, params: params)
	}

	// the delete, save and update actions only accept POST requests
	static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

	def list =
	{
		params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
		[albumInstanceList: Album.list(params), albumInstanceTotal: Album.count()]
	}

	def list_frontend =
	{
		params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
		[albumInstanceList: Album.list(params), albumInstanceTotal: Album.count()]
	}

	def show =
	{
		def albumInstance = Album.get(params.id)

		if (!albumInstance)
		{
			flash.message = "Album mit id '${params.id}' nicht gefunden."
			redirect(action: 'list_frontend')
		}
		else
		{
			return [albumInstance: albumInstance]
		}
	}

	def delete =
	{
		def albumInstance = Album.get(params.id)
		if (albumInstance)
		{
			try
			{
				albumInstance.delete(flush: true)
				flash.message = "Album '${albumInstance.name}' gelöscht."
				redirect(action: 'list_frontend')
			}
			catch (org.springframework.dao.DataIntegrityViolationException e)
			{
				flash.message = "Album '${albumInstance.name}' konnte nicht gelöscht werden."
				redirect(action: show, id: params.id)
			}
		}
		else
		{
			flash.message = "Album mit id '${params.id}' nicht gefunden"
			redirect(action: 'list_frontend')
		}
	}

	def edit =
	{
		def albumInstance = Album.get(params.id)

		if (!albumInstance)
		{
			flash.message = "Album not found with id ${params.id}"
			redirect(action: list)
		}
		else
		{
			return [albumInstance: albumInstance]
		}
	}

	def update =
	{
		println("params -> $params")
		def albumInstance = Album.get(params.id)
		if (albumInstance)
		{
			if (params.version)
			{
				def version = params.version.toLong()
				if (albumInstance.version > version)
				{

					albumInstance.errors.rejectValue("version", "album.optimistic.locking.failure", "Another user has updated this Album while you were editing.")
					render(view: 'edit', model: [albumInstance: albumInstance])
					return
				}
			}

			println(albumInstance.name)

			if(params.name != albumInstance.name)
			{
				if(!renameAlbumDirectory(albumInstance, params.name))
				{
					flash.message = "Der Name des Albums darf nur Buchstaben, Zahlen und Unterstriche enthalten!"
					render(view: 'edit', model: [albumInstance: albumInstance])
				}
			}

			albumInstance.properties = params
			if (!albumInstance.hasErrors() && albumInstance.save())
			{
				flash.message = "Album '${albumInstance.name}' geändert."
				redirect(action: show, id: albumInstance.id)
			}
			else
			{
				render(view: 'edit', model: [albumInstance: albumInstance])
			}
		}
		else
		{
			flash.message = "Album not found with id ${params.id}"
			redirect(action: list)
		}
	}

	def create =
	{
		def albumInstance = new Album()
		albumInstance.properties = params
		return ['albumInstance': albumInstance]
	}

	def save =
	{
		def albumInstance = new Album(params)
		if (albumInstance.save())
		{
			flash.message = "Album '${albumInstance.name}' erstellt."
			redirect(action: 'list_frontend')
		}
		else
		{
			render(view: 'create', model: [albumInstance: albumInstance])
		}
	}

	private boolean renameAlbumDirectory(Album tmpAlbum, String newAlbumName)
	{
		boolean isOk = false

		boolean newAlbumNameIsValid = (newAlbumName == /\w+/)
		if (tmpAlbum && newAlbumNameIsValid)
		{

			String albumDate = formatDate(date: tmpAlbum.dateCreated, format: 'ddMMyyyy')

			String tmpSourceFolderString = ((GrailsApplicationAttributes) grailsAttributes).
					getApplicationContext().getResource("${File.separator}${MediaUtils.DEFAULT_UPLOADS_FOLDER}${File.separator}${MediaUtils.DEFAULT_FOLDER_IMAGE}${File.separator}${MediaUtils.DEFAULT_FOLDER}_${tmpAlbum.toString()}_${albumDate}").getFile().getAbsolutePath()

			String tmpTargetFolderString = tmpSourceFolderString.replaceFirst(tmpAlbum.toString(), newAlbumName)

			String tmpCommand1 = "mv ${tmpSourceFolderString} ${tmpTargetFolderString}"

			println(tmpCommand1)

			Process process = null

			try
			{
				process = tmpCommand1.execute()
				//println process.in.text
				process.waitFor()
				Thread.sleep(2000)
				isOk = true
			}
			catch (Exception e)
			{
				e.printStackTrace()
				return false
			}
		}
		return isOk
	}
}