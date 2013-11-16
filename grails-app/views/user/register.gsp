<html>
<head>
    <meta name='layout' content='main'/>
    <title><g:message code="springSecurity.login.title"/></title>
    <style type='text/css' media='screen'>
    #login {
        margin: 15px 0px;
        padding: 0px;
        text-align: center;
    }

    #login .inner {
        width: 340px;
        padding-bottom: 6px;
        margin: 60px auto;
        text-align: left;
        border: 1px solid #aab;
        background-color: #f0f0fa;
        -moz-box-shadow: 2px 2px 2px #eee;
        -webkit-box-shadow: 2px 2px 2px #eee;
        -khtml-box-shadow: 2px 2px 2px #eee;
        box-shadow: 2px 2px 2px #eee;
    }

    #login .inner .fheader {
        padding: 18px 26px 14px 26px;
        background-color: #f7f7ff;
        margin: 0px 0 14px 0;
        color: #2e3741;
        font-size: 18px;
        font-weight: bold;
    }

    #login .inner .cssform p {
        clear: left;
        margin: 0;
        padding: 4px 0 3px 0;
        padding-left: 105px;
        margin-bottom: 20px;
        height: 1%;
    }

    #login .inner .cssform input[type='text'] {
        width: 120px;
    }

    #login .inner .cssform label {
        font-weight: bold;
        float: left;
        text-align: right;
        margin-left: -105px;
        width: 110px;
        padding-top: 3px;
        padding-right: 10px;
    }

    #login #remember_me_holder {
        padding-left: 120px;
    }

    #login #submit {
        margin-left: 15px;
    }

    #login #remember_me_holder label {
        float: none;
        margin-left: 0;
        text-align: left;
        width: 200px
    }

    #login .inner .login_message {
        padding: 6px 25px 20px 25px;
        color: #c33;
    }

    #login .inner .text_ {
        width: 120px;
    }

    #login .inner .chk {
        height: 12px;
    }
    </style>
</head>

<body>
<div id='login'>
    <div class='inner'>
        <div class='fheader'><g:message code="springSecurity.login.header"/></div>

        <g:if test='${flash.message}'>
            <div class='login_message'>${flash.message}</div>
        </g:if>

        <g:if test='${!session.step}'>
            ${session.setAttribute('step','Step1')}
        </g:if>

        <g:if test="${session.step=='Step1'}">
            <h1>STEP 1</h1>
            <center><oauth:connect provider="google" >Login with Google</oauth:connect></center> <br />
            <center><oauth:connect provider="twitter">Login with Twitter</oauth:connect></center>
            <hr/>
        </g:if>

        <g:if test="${session.step=='Step2'}">

            <h1>STEP 2</h1>
            <g:form class="simpleform" url="[controller:'user',action:'register']">
                <fieldset>
                    <legend>User Registration</legend>
                    <p class="info">
                        Complete the form below to create an account!
                    </p>                                           <br/>
                    <g:hasErrors bean="${user}">
                        <div class="errors">
                            <g:renderErrors bean="${user}"/>
                        </div>
                    </g:hasErrors>

                    <label for="username">Username</label>
                    <div class="rightcol">
                        <g:textField name="username" value="${user?.username}"
                                     class="${hasErrors(bean:user,field:'username','errors')}"/>
                    </div>

                    <label for="email">Email</label>
                    <div class="rightcol">
                        <g:textField name="email"   value="${user?.email}"
                                     class="${hasErrors(bean:user,field:'email','errors')}" />
                    </div>

                    <label for="FirstName">Vorname</label>
                    <div class="rightcol">
                        <g:textField name="FirstName" value="${user?.firstName}"
                                     class="${hasErrors(bean:user,field:'firstName','errors')}" />
                    </div>

                    <label for="LastName">Nachname</label>
                    <div class="rightcol">
                        <g:textField name="LastName"  value="${user?.lastName}"
                                     class="${hasErrors(bean:user,field:'lastName','errors')}" />
                    </div>

                <!-- TOKENS -->
                    <label for="#">Tokens</label>
                    <div class="rightcol">
                    <g:each in="${user?.tokens}" var="entry">
                        ${entry.key} = ${entry.value}<br/>
                    </g:each>
                    </div>

                    <label>&nbsp;</label>
                    <div class="rightcol">
                        <g:submitButton class="button" name="submitButton" value="Create Account" />
                    </div>
                </fieldset>
            </g:form>


        </g:if>


        <g:link uri="/">Zurück</g:link>
    </div>
</div>
<script type='text/javascript'>
    <!--
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>
</body>
</html>
