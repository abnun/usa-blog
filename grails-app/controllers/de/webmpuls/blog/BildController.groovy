package de.webmpuls.blog

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartFile
import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import de.webmpuls.blog.Media.MediaUtils
import grails.util.GrailsUtil
import javax.servlet.http.HttpServletResponse

class BildController
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
		[bildInstanceList: Bild.list(params), bildInstanceTotal: Bild.count()]
	}

	def show =
	{
		def bildInstance = Bild.get(params.id)

		if (!bildInstance)
		{
			flash.message = "Bild not found with id ${params.id}"
			redirect(action: list)
		}
		else
		{
			return [bildInstance: bildInstance]
		}
	}

	def delete =
	{
		def bildInstance = Bild.get(params.id)
		if (bildInstance)
		{
			try
			{
				bildInstance.delete(flush: true)
				flash.message = "Bild '${bildInstance.baseName}' gelöscht."

				if(params.albumId)
				{
					redirect(controller: 'album', action: 'show', id: params.albumId)
					return false
				}
				else
				{
					redirect(action: list)
					return false
				}
			}
			catch (org.springframework.dao.DataIntegrityViolationException e)
			{
				flash.message = "Bild '${bildInstance.baseName}' konnte nicht gelöscht werden."
				redirect(action: show, id: params.id)
			}
		}
		else
		{
			flash.message = "Bild mit der id '${params.id}' konnte nicht gefunden werden."
			redirect(action: list)
		}
	}

	def edit =
	{
		def bildInstance = Bild.get(params.id)

		if (!bildInstance)
		{
			flash.message = "Bild mit der id '${params.id}' konnte nicht gefunden werden."
			redirect(controller: 'album', action: 'show', id: params.albumId)
		}
		else
		{
			return [bildInstance: bildInstance]
		}
	}

	def update =
	{
		def bildInstance = Bild.get(params.id)
		if (bildInstance)
		{
			if (params.version)
			{
				def version = params.version.toLong()
				if (bildInstance.version > version)
				{

					bildInstance.errors.rejectValue("version", "bild.optimistic.locking.failure", "Another user has updated this Bild while you were editing.")
					render(view: 'edit', model: [bildInstance: bildInstance])
					return
				}
			}
			bildInstance.properties = params
			if (!bildInstance.hasErrors() && bildInstance.save())
			{
				flash.message = "Bild '${bildInstance.baseName}' geändert."
				redirect(controller: 'album', action: 'show', id: bildInstance.album?.id)
			}
			else
			{
				render(view: 'edit', model: [bildInstance: bildInstance])
			}
		}
		else
		{
			flash.message = "Bild mit der id '${params.id}' konnte nicht gefunden werden."
			redirect(controller: 'album', action: 'show', id: params.albumId)
		}
	}

	def create =
	{
		def bildInstance = new Bild()
		bildInstance.properties = params
		return ['bildInstance': bildInstance]
	}

	def save =
	{
		def bildInstance = new Bild(params)
		if (bildInstance.save())
		{
			flash.message = "Bild ${bildInstance.id} created"
			redirect(action: show, id: bildInstance.id)
		}
		else
		{
			render(view: 'create', model: [bildInstance: bildInstance])
		}
	}

	def uploadFotos =
	{
		println params
		if(request instanceof MultipartHttpServletRequest)
		{
			MultipartFile foto = request.getFile('fotos')
			if (!foto.empty)
			{
				String uploadFolder = params.folder

				File tmpUploadFolder = null

				if(uploadFolder)
				{
					tmpUploadFolder = ((GrailsApplicationAttributes)grailsAttributes).
							getApplicationContext().getResource( File.separator + "uploads" + uploadFolder ).getFile()

					uploadFolder = getUploadPath(uploadFolder, tmpUploadFolder).getAbsolutePath()
					println uploadFolder
				}

				Bild tmpBild = new Bild(baseName: params['Filename'], album: Album.get(params.album.id))

				String newFilePath = "${uploadFolder}${File.separator}${tmpBild.getURL()}"

				File newFile = new File(newFilePath)

				foto.transferTo(newFile)
				Thread.sleep(2000) 

				String rotateDegrees = params.rotate

				boolean isOk = processImg(newFilePath, uploadFolder, tmpUploadFolder, tmpBild, rotateDegrees)

				if(isOk && newFile.exists() && newFile.size() > 0)
				{
					Bild newBild = new Bild(baseName: params['Filename'], album: Album.get(params.album.id))
					Bild existingBild = Bild.findByBaseName(params['Filename'])
					if(existingBild)
					{
						newBild = existingBild
					}

					if(newBild.save(flush: true))
					{
						println("Foto '${newBild.getURL()}' erfolgreich gespeichert.")
					}
					else
					{
						newBild.errors.allErrors.each
						{
							println it
						}

						//response.sendError(500, 'Foto konnte nicht geladen werden.');
						response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR)
						response.outputStream << "Foto konnte nicht geladen werden."
						response.outputStream.flush()
					}

					//response.sendError(200, 'Foto erfolgreich hochgeladen.');
					response.setStatus(HttpServletResponse.SC_OK)
					response.outputStream << "Foto erfolgreich hochgeladen."
					response.outputStream.flush()
				}
				else
				{
					//response.sendError(500, 'Foto konnte nicht geladen werden.');
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR)
					response.outputStream << "Foto konnte nicht geladen werden."
					response.outputStream.flush()
				}

			}
			else
			{
				flash.message = 'file cannot be empty'
				render(view: 'uploadForm')
			}
		}
		else
		{
			//response.sendError(500, 'Foto konnte nicht geladen werden.');
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR)
			response.outputStream << "Foto konnte nicht geladen werden."
			response.outputStream.flush()
		}
	}

	private boolean processImg(String fileName, String uploadFolder, File tmpUploadFolder, Bild targetFile, String rotateDegrees)
	{
		final String original = fileName
		println("OS -> ${System.getProperty("os.name")}")
		if(GrailsUtil.environment == "development" && !System.getProperty("os.name").contains("Mac"))
		{
			original = "\"${original}\""
		}

		boolean isOk = false
//		def t = Thread.start
//		{

			final String uploadPathThumbNail = "${getUploadPath(uploadFolder,tmpUploadFolder).getAbsolutePath()}${File.separator}${targetFile.getThumbNailURL()}"
			final String uploadPathBig = "${getUploadPath(uploadFolder,tmpUploadFolder).getAbsolutePath()}${File.separator}${targetFile.getBigURL()}"

			if(GrailsUtil.environment == "development" && !System.getProperty("os.name").contains("Mac"))
			{
				uploadPathThumbNail = "\"${uploadPathThumbNail}\""
				uploadPathBig = "\"${uploadPathBig}\""
			}

			String cmdRotate = ""

			Process process = null

			println "Env -> ${System.getenv().get("PATH")}"
			println "User -> ${System.getenv().get("USER")}"
			println "Shell -> ${System.getenv().get("SHELL")}"

			if(rotateDegrees)
			{
				cmdRotate = "mogrify -rotate \"${rotateDegrees}\" ${original}"
				println cmdRotate
				try
				{
					process = cmdRotate.execute()
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

			String cmd = createCmd(original, MediaUtils.THUMBNAIL, createDimentions(150, 140), uploadPathThumbNail)
			try
			{
				process = cmd.execute()
				process.waitFor()
				isOk = true
			}
			catch(Exception e)
			{
				e.printStackTrace()
				return false
			}

			String cmdMain = createCmd(original, MediaUtils.THUMBNAIL, createDimentions(400, 0), uploadPathBig)
			try
			{
				Process processMain = cmdMain.execute()
				processMain.waitFor()
				isOk = true
			}
			catch(Exception e)
			{
				e.printStackTrace()
				return false
			}

			//             def waterMarkCmd = ["cmd /c composite -compose atop watermark.png", 'imgs/main_' + fileName, 'imgs/wm_' + fileName]
			//             waterMarkCmd.join(" ").execute()
//		}
		return isOk
	}

	/*private String getExtension(MultipartFile file)
		 {
			 String contentType = file.getContentType();
			 String fileExtension = null;
			 if (contentType.equalsIgnoreCase("image/pjpeg") || contentType.equalsIgnoreCase("image/jpeg")) {
				 fileExtension = ".jpg";
			 }
			 else if (contentType.equalsIgnoreCase("image/gif")) {
				 fileExtension = ".gif";
			 }
			 else if (contentType.equalsIgnoreCase("image/x-png")) {
				 fileExtension = ".png";
			 }

			 return fileExtension;
		 }*/

	private String createCmd(String inpath,String action,String options,String outpath)
	{
		//@todo Need os specific code here... Remove c for Linux.....
		def cmd = ['cmd', '/c', 'convert', inpath, action, options, outpath]

		if(GrailsUtil.environment == "production" || System.getProperty("os.name").contains("Mac"))
		{
			cmd = ['convert', inpath, action, options, outpath]
		}

		String execString = cmd.join(" ")
		println execString
		return execString;
	}

	private String createDimentions(int width, int height)
	{
		StringBuffer sb = new StringBuffer();
		if (width > 0)
		{
			sb.append(width);
		}

		sb.append('x');
		if (height > 0)
		{
			sb.append(height)
		}

		return sb.toString()
	}

	private File getUploadPath(String uploadFolder, File tmpUploadFolder)
	{
		if(!tmpUploadFolder.exists())
		{
			tmpUploadFolder.mkdir()
		}

		return tmpUploadFolder
	}
}