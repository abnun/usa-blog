package de.webmpuls.blog

class InhaltController
{
	static navigation = [
		[group: 'menutop', order: 20, title: 'Route', action: 'route'],
		[group: 'menutop', order: 30, title: 'Impressum', action: 'impressum']
	]

    def index =
	{
		redirect(action: 'impressum')
	}

	def route
	{

	}

	def impressum =
	{
		
	}
}
