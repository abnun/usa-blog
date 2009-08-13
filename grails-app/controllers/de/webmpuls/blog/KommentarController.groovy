package de.webmpuls.blog

class KommentarController
{

	def index =
	{
		redirect(action: list, params: params)
	}

	// the delete, save and update actions only accept POST requests
	static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

	def list =
	{
		params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
		[kommentarInstanceList: Kommentar.list(params), kommentarInstanceTotal: Kommentar.count()]
	}

	def show =
	{
		def kommentarInstance = Kommentar.get(params.id)

		if (!kommentarInstance)
		{
			flash.message = "Kommentar not found with id ${params.id}"
			redirect(action: list)
		}
		else
		{
			return [kommentarInstance: kommentarInstance]
		}
	}

	def delete =
	{
		def kommentarInstance = Kommentar.get(params.id)
		if (kommentarInstance)
		{
			try
			{
				kommentarInstance.delete(flush: true)
				flash.message = "Kommentar ${params.id} gelöscht"
				redirect(uri: '/')
			}
			catch (org.springframework.dao.DataIntegrityViolationException e)
			{
				flash.message = "Kommentar ${params.id} could not be deleted"
				redirect(action: show, id: params.id)
			}
		}
		else
		{
			flash.message = "Kommentar not found with id ${params.id}"
			redirect(action: list)
		}
	}

	def edit =
	{
		def kommentarInstance = Kommentar.get(params.id)

		if (!kommentarInstance)
		{
			flash.message = "Kommentar not found with id ${params.id}"
			redirect(action: list)
		}
		else
		{
			return [kommentarInstance: kommentarInstance]
		}
	}

	def update =
	{
		def kommentarInstance = Kommentar.get(params.id)
		if (kommentarInstance)
		{
			if (params.version)
			{
				def version = params.version.toLong()
				if (kommentarInstance.version > version)
				{

					kommentarInstance.errors.rejectValue("version", "kommentar.optimistic.locking.failure", "Another user has updated this Kommentar while you were editing.")
					render(view: 'edit', model: [kommentarInstance: kommentarInstance])
					return
				}
			}
			kommentarInstance.properties = params
			if (!kommentarInstance.hasErrors() && kommentarInstance.save())
			{
				flash.message = "Kommentar ${params.id} updated"
				redirect(action: show, id: kommentarInstance.id)
			}
			else
			{
				render(view: 'edit', model: [kommentarInstance: kommentarInstance])
			}
		}
		else
		{
			flash.message = "Kommentar not found with id ${params.id}"
			redirect(action: list)
		}
	}

	def create =
	{
		def kommentarInstance = new Kommentar()
		kommentarInstance.properties = params
		return ['kommentarInstance': kommentarInstance]
	}

	def save =
	{
		def kommentarInstance = new Kommentar(params)
		if (kommentarInstance.save())
		{
			flash.message = "Kommentar ${kommentarInstance.id} created"
			redirect(uri: '/')
		}
		else
		{
			render(view: 'create', model: [kommentarInstance: kommentarInstance])
		}
	}
}
