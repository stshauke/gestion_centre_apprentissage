<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="pagesParametres/header.jsp" %>

<header class="bg-primary text-white text-center py-5" style="background-image: url('/gestion_centre_apprentissage/assets/images/bg-image-01_V1.png'); background-size: cover; background-position: center;height: 350px;">
  <div class="container text-start">
    <h1>Bienvenue sur LinguApp</h1>
    <p class="lead">Apprenez une nouvelle langue facilement et rapidement.</p>
    <a href="#features" class="btn btn-light btn-lg mt-3">Découvrir les fonctionnalités</a>
  </div>
</header>

<section id="features" class="py-5">
  <div class="container">
    <div class="row text-center">
      <div class="col-lg-4">
        <div class="mb-4">
          <i class="bi bi-book-half fs-1 text-primary"></i>
        </div>
        <h3>Leçons interactives</h3>
        <p>Des leçons adaptées à votre niveau pour progresser à votre rythme.</p>
      </div>
      <div class="col-lg-4">
        <div class="mb-4">
          <i class="bi bi-chat-dots fs-1 text-primary"></i>
        </div>
        <h3>Pratique orale</h3>
        <p>Entraînez-vous avec des locuteurs natifs grâce à notre chatbot.</p>
      </div>
      <div class="col-lg-4">
        <div class="mb-4">
          <i class="bi bi-graph-up-arrow fs-1 text-primary"></i>
        </div>
        <h3>Suivi de progression</h3>
        <p>Gardez un oeil sur vos progrès avec des statistiques personnalisées.</p>
      </div>
    </div>
  </div>
</section>

<section id="about" class="bg-light py-5">
  <div class="container">
    <div class="row">
      <div class="col-md-6">
        <h2>A propos de LinguApp</h2>
        <p>LinguApp est une application d'apprentissage des langues conçue pour vous aider à atteindre vos objectifs linguistiques, qu'il s'agisse d'apprendre une nouvelle langue ou de perfectionner vos compétences existantes.</p>
      </div>
      <div class="col-md-6">
        <img src="/gestion_centre_apprentissage/assets/images/group-01-722x490.jpg" alt="A propos" class="img-fluid rounded">
      </div>
    </div>
  </div>
</section>

<section id="contact" class="py-5">
  <div class="container text-center">
    <h2>Contactez-nous</h2>
    <p class="mb-4">Une question ou une suggestion ? Nous sommes là pour vous !</p>
    <a href="mailto:support@linguapp.com" class="btn btn-primary">Envoyer un email</a>
  </div>
</section>

<%@ include file="pagesParametres/footer.jsp" %>
