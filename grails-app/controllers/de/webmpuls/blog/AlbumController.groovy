package de.webmpuls.blog

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
}