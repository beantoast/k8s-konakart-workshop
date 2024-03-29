<%--
//
// (c) 2012 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is free software; you can redistribute
// it and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
--%>
<%@include file="Taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
"http://www.w3.org/TR/html4/strict.dtd">
<% String enabledRum = System.getenv("ELASTIC_APM_RUM_ENABLED"); %>
<% String distributedTracing = System.getenv("ELASTIC_APM_DISTRIBUTED_TRACING_ENABLED"); %>
<% String serverUrl = System.getenv("ELASTIC_APM_SERVER_URL"); %>
<% String appUrl = System.getenv("MY_APP_URL"); %>
<% String env = System.getenv("ELASTIC_APM_ENVIRONMENT"); %>
<% String frontendSvc = System.getenv("MY_FRONTEND_SVC"); 
   if(frontendSvc == null){
		 frontendSvc = "konakart-rum";
	 }
%>
<% com.konakart.al.KKAppEng kkEng = (com.konakart.al.KKAppEng) session.getAttribute("konakartKey");%>

 <%if (kkEng != null) {%>
 	<tiles:useAttribute id="contentClass" name="contentClass" classname="java.lang.String" ignore="true"/>
    <%kkEng.setContentClass(contentClass);%>
    <% if (kkEng.getProductMgr().getCurrentCategoriesLength() == 0 && contentClass.equalsIgnoreCase("narrow")){%>
    	<%kkEng.setContentClass("wide");%>
    <% } %>
    <% int menuType =  kkEng.getPropertyAsInt("menu.type", 1);%>
    <tiles:useAttribute id="defName" name="defName" classname="java.lang.String" ignore="true"/>

    <%if (kkEng.isPortlet()) {%>
    	<%@include file="LiferayIncludes.jsp" %>
	    <%request.getSession().setAttribute("konakartKey", kkEng); %>
	    <% boolean dontSetContext =  kkEng.getPropertyAsBoolean("dont.set.portlet.context.path", false);%>
	    <%if (!dontSetContext) {%>
		    <%kkEng.setPortletContextPath(request.getContextPath());%>
		    <input id="kk_context" type="hidden" value="<%=request.getContextPath()%>"/>
	    <% } %>
		<input id="kk_portlet_id" type="hidden" value="<%=request.getAttribute("PORTLET_ID")%>"/>
		<input id="kk_sample_url" type="hidden" value="<s:url action='KK_ACTION'/>"/>
		<input type="hidden" value="<%=kkEng.getXsrfToken()%>" id="kk_xsrf_token"/>
		<div id="kk-portlet-body">
    <% } else { %>
		<html>
			<head>
		    <% if (enabledRum != null && enabledRum.equals("true")) { %>
				<script src="<%=kkEng.getScriptBase()%>/elastic-apm-rum.umd.min.js" crossorigin></script>
				<script>
          elasticApm.init({
            serviceName: '<%=frontendSvc%>',
					  serverUrl: '<%=serverUrl%>'
				 <% if (env != null) { %>
						,environment: '<%=env%>'
				 <% } %>
				 <% if (distributedTracing != null && distributedTracing.equals("true")) { %>
				  <%@ page import="co.elastic.apm.api.ElasticApm,co.elastic.apm.api.Transaction" %>
          <% Transaction transaction = ElasticApm.currentTransaction(); %>
					  ,distributedTracingOrigins: ['<%=appUrl%>'],
				    pageLoadTraceId: "<%=transaction.getTraceId()%>",
            pageLoadSpanId: "<%=transaction.ensureParentId()%>"
         <% } %>
          })
				</script>
        <% } %>
				<meta name="rum" content="<%=enabledRum%>"/>
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=1" />
				<title><%=kkEng.getPageTitle()%></title>
				<meta name="keywords" content="<%=kkEng.getMetaKeywords()%>" />
				<meta name="description" content="<%=kkEng.getMetaDescription()%>" />
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<%for (java.util.Iterator<String> iterator = kkEng.getMetaList().iterator(); iterator.hasNext();) {out.print(iterator.next());}%>
				<link type="text/css" rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
				<link type="text/css" rel="stylesheet" href="<%=kkEng.getStyleBase()%>/jquery.selectboxit.css" />
				<link type="text/css" rel="stylesheet" href="<%=kkEng.getStyleBase()%>/font-awesome/css/font-awesome.css" />
				<link type='text/css' rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600,700'  >
				<link type="text/css" rel="stylesheet" href="<%=kkEng.getStyleBase()%>/jcarousel.css" />
				<link type="text/css" rel="stylesheet" href="<%=kkEng.getStyleBase()%>/kk-style.css" />

				<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
				<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.validate.min.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.selectboxit.min.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.ui.datepicker-en.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.ui.datepicker-de.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.ui.datepicker-pt.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.ui.datepicker-es.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/ddpowerzoomer.js">
				/***********************************************
				* Image Power Zoomer- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
				* This notice MUST stay intact for legal use
				* Visit Dynamic Drive at http://www.dynamicdrive.com/ for this script and 100s more
				***********************************************/
				</script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.jcarousel.min.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.touchSwipe.min.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery.cookie.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/jquery-backward-timer.min.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/kk.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/kk.proddetails.js"></script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/kk.validation.js"></script>
				<%if (menuType == 2) {%>
					<link type="text/css" rel="stylesheet" href="<%=kkEng.getStyleBase()%>/smartmenus.css" />
					<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/smartmenus.js"></script>
				<% } %>

				<script>
				// Picture element HTML5 shiv
				document.createElement( "picture" );
				</script>
				<script type="text/javascript" src="<%=kkEng.getScriptBase()%>/picturefill-min.js"></script>
				<%
				// Set the base
				String scheme = pageContext.getRequest().getScheme()+"://";
				String server = pageContext.getRequest().getServerName();
				int port = pageContext.getRequest().getServerPort();
				String path = session.getServletContext().getContextPath();
				String base = scheme+server+((port==80)?"":":"+port)+path+"/";
				%>
				<base href="<%=base%>"/>
				<!-- The version below for obtaining the base is sometimes better on IIS.             -->
				<!-- If you rely on the above for getting the base you get http://localhost so unless -->
				<!-- IIS is configured to Rewrite the outbound URLs it fails.                         -->
				<!-- base href="<%=kkEng.getConfig("KK_BASE_URL") %>"/ -->
				<!--- KonaKart v9.4.0.2.${SVN_REVISION} -->
			</head>
			<%if (defName != null) {%>
				<body id="<%=defName%>">
			<%} else {%>
				<body>
			<%}%>

			<% boolean showMessengerPlugin =  kkEng.getConfigAsBoolean("MODULE_OTHER_MESSENGER_PLUGIN_STATUS", false, false, false);%>
			<%if (showMessengerPlugin && !(defName != null && defName.equals("catalog.login.page"))) {%>
				<script>
				  window.fbAsyncInit = function() {
				    FB.init({
				      appId            : '<%=kkEng.getConfig("MODULE_OTHER_MESSENGER_PLUGIN_FACEBOOK_APP_ID") %>',
				      autoLogAppEvents : true,
				      xfbml            : true,
				      version          : 'v6.0'
				    });
				  };

				  (function(d, s, id){
				     var js, fjs = d.getElementsByTagName(s)[0];
				     if (d.getElementById(id)) {return;}
				     js = d.createElement(s); js.id = id;
				     js.src = "https://connect.facebook.net/en_US/sdk/xfbml.customerchat.js";
				     fjs.parentNode.insertBefore(js, fjs);
				   }(document, 'script', 'facebook-jssdk'));
				</script>
				<div class="fb-customerchat"
 					page_id="<%=kkEng.getConfig("MODULE_OTHER_MESSENGER_PLUGIN_FACEBOOK_PAGE_ID") %>"
 					minimized="<%=kkEng.getConfig("MODULE_OTHER_MESSENGER_PLUGIN_MINIMIZED") %>">
				</div>
			<%}%>

			<input type="hidden" value="<%=kkEng.getXsrfToken()%>" id="kk_xsrf_token"/>
	<%}%>
	<%=kkEng.getAnalyticsCode()%>
	<script language="JavaScript" type="text/javascript">
		if (top.location != location) {
					top.location.href = document.location.href ;
			}

			// Set jquery validation messages
			jQuery.validator.messages = {
					state: '<%=kkEng.getMsg("jquery.validator.required")%>',
					country: '<%=kkEng.getMsg("jquery.validator.required")%>',
					required: '<%=kkEng.getMsg("jquery.validator.required")%>',
					creditcard: '<%=kkEng.getMsg("jquery.validator.creditcard")%>',
					digits: '<%=kkEng.getMsg("jquery.validator.digits")%>',
					maxlength: jQuery.validator.format('<%=kkEng.getMsg("jquery.validator.maxlength")%> {0} <%=kkEng.getMsg("jquery.validator.maxlength1")%>'),
					minlength: jQuery.validator.format('<%=kkEng.getMsg("jquery.validator.minlength")%> {0} <%=kkEng.getMsg("jquery.validator.minlength1")%>'),
					expirydate: '<%=kkEng.getMsg("jquery.validator.expiryMMYY")%>',
					email:	'<%=kkEng.getMsg("jquery.validator.email")%>',
					url:	'<%=kkEng.getMsg("jquery.validator.url")%>',
					number:	'<%=kkEng.getMsg("jquery.validator.number")%>',
 					equalTo: '<%=kkEng.getMsg("jquery.validator.equalTo")%>',
 					phone_regex: '<%=kkEng.getMsg("jquery.validator.phone")%>'
		};
	</script>

				<tiles:insertAttribute name="header1" />
				<tiles:insertAttribute name="header2" />
	    		<div id="page-container">
	    			<div id="page" class="<tiles:insertAttribute name="pageClass"/>">
						<tiles:insertAttribute name="header3" />
						<tiles:insertAttribute name="header4" />
						<tiles:insertAttribute name="left1" />
						<div id="content" class="<%=kkEng.getContentClass()%>">
							<tiles:insertAttribute name="body1" />
					 		<tiles:insertAttribute name="body2" />
							<tiles:insertAttribute name="body3" />
							<tiles:insertAttribute name="body4" />
							<tiles:insertAttribute name="body5" />
							<tiles:insertAttribute name="body6" />
				    	</div>
						<tiles:insertAttribute name="footer1" />
		    		</div>
	    		</div>
				<tiles:insertAttribute name="footer2" />

    <%if (!kkEng.isPortlet()) {%>
			</body>
		</html>
	<%} else {%>
		</div>
	<%}%>
<%}%>