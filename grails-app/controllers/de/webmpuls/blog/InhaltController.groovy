package de.webmpuls.blog

class InhaltController
{
	static navigation = [
		[group: 'menutop', order: 40, title: 'Route', action: 'route'],
		[group: 'menutop', order: 50, title: 'Impressum', action: 'impressum']
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
