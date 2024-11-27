<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="wide wow-animation" lang="en">
  <head>
    <title>Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width height=device-height initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <!-- <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,600,700,800,900%7CBaloo"> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">


    <style>.ie-panel{display: none;background: #212121;padding: 10px 0;box-shadow: 3px 3px 5px 0 rgba(0,0,0,.3);clear: both;text-align:center;position: relative;z-index: 1;} html.ie-10 .ie-panel, html.lt-ie-10 .ie-panel {display: block;}</style>
  </head>
  <body>
    <div class="ie-panel"><a href=""><img src="images/ie8-panel/warning_bar_0000_us.jpg" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today."></a></div>
    <div class="preloader">
      <div class="preloader-inner">
        <div class="preloader-top">
          <div class="preloader-top-sun">
            <div class="preloader-top-sun-bg"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-0"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-45"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-90"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-135"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-180"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-225"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-270"></div>
            <div class="preloader-top-sun-line preloader-top-sun-line-315"></div>
          </div>
        </div>
        <div class="preloader-bottom">
          <div class="preloader-bottom-line preloader-bottom-line-lg"></div>
          <div class="preloader-bottom-line preloader-bottom-line-md"></div>
          <div class="preloader-bottom-line preloader-bottom-line-sm"></div>
          <div class="preloader-bottom-line preloader-bottom-line-xs"></div>
        </div>
      </div>
    </div>
    <div class="page">
      <!-- Banner-<a class="section section-banner text-center d-none d-xl-block" href="https://www.templatemonster.com/intense-multipurpose-html-template.html" style="background-image: url(images/banner/background-04-1920x60.jpg); background-image: -webkit-image-set( url(images/banner/background-04-1920x60.jpg) 1x, url(images/banner/background-04-3840x120.jpg) 2x )"><img src="images/banner/foreground-04-1600x60.png" srcset="images/banner/foreground-04-1600x60.png 1x, images/banner/foreground-04-3200x120.png 2x" alt="" width="1600" height="310"></a>-->
      <!-- Page Header-->
      <header class="section page-header page-header-2 section-custom-1-ally">
        <!-- RD Navbar-->
        <div class="rd-navbar-wrap">
          <nav class="rd-navbar rd-navbar-creative" data-layout="rd-navbar-fixed" data-sm-layout="rd-navbar-fixed" data-md-layout="rd-navbar-fixed" data-md-device-layout="rd-navbar-fixed" data-lg-layout="rd-navbar-static" data-lg-device-layout="rd-navbar-fixed" data-xl-layout="rd-navbar-static" data-xl-device-layout="rd-navbar-static" data-lg-stick-up-offset="155px" data-xl-stick-up-offset="155px" data-xxl-stick-up-offset="155px" data-lg-stick-up="true" data-xl-stick-up="true" data-xxl-stick-up="true">
            <div class="rd-navbar-main-outer">
              <div class="rd-navbar-main">
                <!-- RD Navbar Panel-->
                <div class="rd-navbar-panel">
                  <!-- RD Navbar Toggle-->
                  <button class="rd-navbar-toggle" data-rd-navbar-toggle=".rd-navbar-nav-wrap, .rd-navbar-toggle-element"><span class="rd-navbar-toggle-inner"><span class="rd-navbar-toggle-element"><span></span></span><span class="rd-navbar-toggle-text on">Menu</span><span class="rd-navbar-toggle-text off">Close</span></span></button>
                  <!-- RD Navbar Brand-->
                  <div class="rd-navbar-brand"><a class="brand" href="index.html"><img class="brand-logo-dark" src="images/logo-default-195x39.png" alt="" width="195" height="39"/><img class="brand-logo-light" src="images/logo-inverse-195x39.png" alt="" width="195" height="39"/></a>
                  </div>
                </div>
                <div class="rd-navbar-aside-outer">
                  <button class="rd-navbar-aside-toggle" data-multitoggle="#rd-navbar-aside" aria-label="Aside Toggle"><span></span></button>
                  <div class="rd-navbar-aside" id="rd-navbar-aside">
                    <ul class="rd-navbar-aside-list">
                      <li><span class="icon mdi mdi-map-marker"></span><a href="#">9 Valley St. Brooklyn, NY 11203</a></li>
                      <li><span class="icon mdi mdi-phone"></span><a href="tel:#">1-800-346-6277</a></li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="rd-navbar-nav-wrap">
                <!-- RD Navbar Nav-->
                <ul class="rd-navbar-nav">
                  <li class="rd-nav-item active"><a class="rd-nav-link" href="index.html">Home</a></li>
                  <li class="rd-nav-item"><a class="rd-nav-link" href="${pageContext.request.contextPath}/list">Apprenants</a></li>
                   <li class="rd-nav-item"><a class="rd-nav-link" href="${pageContext.request.contextPath}/cours/list-cours">Cours</a></li> 
                  <li class="rd-nav-item"><a class="rd-nav-link" href="${pageContext.request.contextPath}/salles/list-salle">Salles</a></li>
                  <li class="rd-nav-item"><a class="rd-nav-link" href="${pageContext.request.contextPath}/abonnements/list-abonnements">Abonnement</a></li>

                </ul>
              </div>
            </div>
          </nav>
        </div>
      
      </header>