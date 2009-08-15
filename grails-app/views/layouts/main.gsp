<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
		<meta name="keywords" content=""/>
		<meta name="description" content=""/>
		<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

		<title><g:layoutTitle default="USA Blog: Claudi und Markus" /></title>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" />
		<script type="text/javascript" src="${resource(dir: 'highslide', file: 'highslide-with-gallery.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'highslide', file: 'highslide_de.js')}"></script>
		<link rel="stylesheet" type="text/css" href="${resource(dir: 'highslide', file: 'highslide.css')}" />
		<!--[if lt IE 7]>
			<link rel="stylesheet" type="text/css" href="${resource(dir: 'highslide', file: 'highslide-ie6.css')}" />
		<![endif]-->
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />

		<g:layoutHead />
        <g:javascript library="application" />

		<g:javascript>
			hs.graphicsDir = '${resource(dir: 'highslide/graphics/')}';
			hs.align = 'center';
			hs.transitions = ['expand', 'crossfade'];
			hs.fadeInOut = true;
			hs.dimmingOpacity = 0.8;
			hs.outlineType = 'outer-glow';
    		hs.wrapperClassName = 'outer-glow';
			hs.showCredits = false;
			hs.marginBottom = 105 // make room for the thumbstrip and the controls
//			hs.numberPosition = 'caption';

			// Add the slideshow providing the controlbar and the thumbstrip
			hs.addSlideshow({
				//slideshowGroup: 'group1',
				interval: 4000,
				repeat: false,
				useControls: true,
				overlayOptions: {
					className: 'text-controls',
					position: 'bottom center',
					relativeTo: 'viewport',
					offsetY: -60
				},
				thumbstrip: {
					position: 'bottom center',
					mode: 'horizontal',
					relativeTo: 'viewport'
				}
			});
		</g:javascript>
		<style type="text/css">
			.highslide-caption {
				color: white;
				/*text-transform: uppercase;*/
			}
			.highslide-controls a {
				border-bottom-style: none; 
			}

			.highslide-thumbstrip-horizontal img {
				height: 50px;
			}
		</style>

    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
		<div id="wrapper">
			<g:render template="/global/header/header" />

			<g:render template="/global/menu/menu" />

			<div id="page">
				<div id="content">
					<g:layoutBody />
				</div>
				<!-- end #content -->

				<g:render template="/global/sidebar/sidebar" />

				<div style="clear: both;">&nbsp;</div>
			</div>
			<!-- end #page -->
    </div>
</body>
</html>