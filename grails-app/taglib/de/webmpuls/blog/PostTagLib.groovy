package de.webmpuls.blog

class PostTagLib
{
	static namespace = "wm_post"

	def showArchive =
	{
		attrs, body ->

		def postInstanceList = Post.findAllWhere(archive: true)

		if(!postInstanceList.isEmpty())
		{
			out << body()
		}

		return out
	}
}
