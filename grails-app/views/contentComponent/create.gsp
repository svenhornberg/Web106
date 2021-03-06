<!DOCTYPE html>
<html>
<head>
    <title>Textbaustein erstellen</title>

    <g:render template="/shared/header" />
<g:javascript library="jquery" />
<r:require module="jquery-ui"/>
<r:layoutResources />

<script type="text/javascript">
        $(function() {


                
        });
</script>


        
</head>
<body>

	<div id="menu" class="pure-g-r">

		<div id="nav" class="pure-u-1-6">

			<g:render template="/shared/backendsidebar" />

		</div>
		<div id="main" class="pure-u-5-6">
		<g:form name="createComponentForm" action="createComponent" >
	        <div class="contentPadding">
			<br>
			<div id="m1" class="pure-g-r">
				<div class="pure-u-1-8">
					Legen Sie Ihren Inhalt an:
				</div>
			</div>
			<div id="m2" class="pure-g-r">
				<div class="pure-u-1-8">Name:</div>
				<div class="pure-u-1-8"><g:textField name="name" required="true" /></div>
			</div>
		
			<br>
			<div id="m3" class="pure-g-r">
				<div class="pure-u-1-2">
				<g:textArea name="text" rows="5" cols="40" required="true" />
				</div>
			</div>
			<div id="m4" class="pure-g-r">
				<div class="pure-u-1-2">
				<g:actionSubmit class="pure-button" value="Anlegen" action="createComponent" />
				</div>
			</div>
			
		</g:form>
            </div>
		</div>
	</div>
</body>
</html>