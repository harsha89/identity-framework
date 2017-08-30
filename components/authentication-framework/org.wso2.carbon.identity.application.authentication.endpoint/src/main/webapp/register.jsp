<%--
  ~ Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~  WSO2 Inc. licenses this file to you under the Apache License,
  ~  Version 2.0 (the "License"); you may not use this file except
  ~  in compliance with the License.
  ~  You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.owasp.encoder.Encode" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>



<%
         
       Map<String, String[]> attrList = request.getParameterMap();
       //String gender =request.getParameter("http://wso2.org/claims/gender");
       //String dob = request.getParameter("http://wso2.org/claims/dob");
       //String fullName = request.getParameter("http://wso2.org/claims/fullname");
       //String email = request.getParameter("http://wso2.org/claims/emailaddress");
       //String url = request.getParameter("http://wso2.org/claims/url");
       // String givenname= request.getParameter("http://wso2.org/claims/givenname");
         //String nickname= request.getParameter("http://wso2.org/claims/nickname");
   boolean isPasswordRequired = true;

  
%>

<fmt:bundle basename="org.wso2.carbon.identity.mgt.endpoint.i18n.Resources">
    <html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>WSO2 Identity Server</title>

        <link rel="icon" href="images/favicon.png" type="image/x-icon"/>
        <link href="libs/bootstrap_3.3.5/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/Roboto.css" rel="stylesheet">
        <link href="css/custom-common.css" rel="stylesheet">

        <!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
        
    </head>

    <body>

    <!-- header -->
    <header class="header header-default">
        <div class="container-fluid"><br></div>
        <div class="container-fluid">
            <div class="pull-left brand float-remove-xs text-center-xs">
                <a href="#">
                    <img src="images/logo-inverse.svg" alt="wso2" title="wso2" class="logo">

                    <h1><em>Identity Server</em></h1>
                </a>
            </div>
        </div>
    </header>

    <!-- page content -->
    <div class="container-fluid body-wrapper">

        <div class="row">
            <!-- content -->
            <div class="col-xs-12 col-sm-10 col-md-8 col-lg-5 col-centered wr-login">
                <form action="../commonauth" method="post" id="submitPassword">
                    <h3 class="wr-title lowercase blue-bg padding-double white boarder-bottom-blue margin-none">Claim Updates</h3>

                    <div class="clearfix"></div>
                    <div class="boarder-all "> 

                        <div class="alert alert-danger" id="error-msg" hidden="hidden">
                        </div>


                        <!-- validation -->
                        <div class="padding-double">
                            <div id="regFormError" class="alert alert-danger" style="display:none"></div>
                            <div id="regFormSuc" class="alert alert-success" style="display:none"></div>
                            <div class="alert alert-danger" id="error-msg" hidden="hidden">
                            </div> 
                             <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 form-group required">
                                <label class="control-label">Password</label>
                                <input id="password1" name="password1" type="password" class="form-control"
                                       data-match="reg-password" required>
                            </div>

                             <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 form-group required">
                                <label class="control-label">Confirm password</label>
                                <input id="password2" name="password2" type="password" class="form-control"
                                       data-match="reg-password" required>
                            </div>
                            <% 
                             for (Map.Entry<String, String[]> entry : attrList.entrySet()) {
                                if(!(entry.getKey().equals("missingClaims")) && !(entry.getKey().equals("spName"))  && !(entry.getKey().equals("sessionDataKey")) && !(entry.getKey().equals("http://wso2.org/claims/dob")) )  {
                              %>                         
                           <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 form-group required">
                                <label class="control-label"><%=entry.getKey()%></label>
                                <input id="samp" name="sample" type="text" value="<%=request.getParameter(entry.getKey())%>"
                                       class="form-control" required>
                            </div>
                            <% }
                             if(entry.getKey().equals("http://wso2.org/claims/dob")){
                             String dob = request.getParameter(entry.getKey());
                           %>
                           
                           <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 form-group required">
                                <label class="control-label"><%=entry.getKey()%></label>
                                <input id="samp" name="sample" type="text" value='<%=dob%>'
                                       class="form-control" required>
                            </div>
                        <%  }} %>

                           

                             <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
                            <input type="hidden" name="sessionDataKey" value='<%=Encode.forHtmlAttribute
                                (request.getParameter("sessionDataKey"))%>'/>
                        </div>
                            
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
                                <br/>
                                <button id="passwordSubmit"
                                        class="wr-btn grey-bg col-xs-12 col-md-12 col-lg-12 uppercase font-extra-large"
                                        type="submit">Submit
                                </button>
                            </div>
                            
                           
                            
                            <div class="clearfix">
                            

                            </div> <!--clearfix end -->
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- /content/body -->
       

        <!--end of fedarated-->

    </div>

    <!-- footer -->
    <footer class="footer" style="position:absolute">
        <div class="container-fluid">
            <p>WSO2 Identity Server | &copy;
                <script>document.write(new Date().getFullYear());</script>
                <a href="http://wso2.com/" target="_blank"><i class="icon fw fw-wso2"></i> Inc</a>. All Rights Reserved.
            </p>
        </div>
    </footer>

    <script src="libs/jquery_1.11.3/jquery-1.11.3.js"></script>
    <script src="libs/bootstrap_3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {

            $("#submitPassword").submit(function (e) {

                var password = $("#password1").val();
                var password2 = $("#password2").val();
                var error_msg = $("#error-msg");

                if (password != password2) {
                    error_msg.text("Passwords did not match. Please try again.");
                    error_msg.show();
                    $("html, body").animate({scrollTop: error_msg.offset().top}, 'slow');
                    return false;
                }

                return true;
            });
            

        });
       
        
    </script>
    </body>
    </html>
</fmt:bundle>


