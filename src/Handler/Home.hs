{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed (embedFile)
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")


getHomeR :: Handler Html
getHomeR = do 
    sess <- lookupSession "_NOME"
    defaultLayout $ do 
        -- addScriptRemote "url" -> CHAMA JS EXTERNO
        -- addScript (StaticR script_js), ONDE script 
        -- eh o nome do seu script.
        -- pasta css, arquivo: bootstrap.css
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_style_css)
        addScriptRemote "https://unpkg.com/animejs@3.0.1/lib/anime.min.js"
        addScriptRemote "https://unpkg.com/scrollreveal@4.0.0/dist/scrollreveal.min.js"
        
        
        toWidgetHead [julius|
            function ola(){
                alert("ola");
            }
        |]
        
        [whamlet|
            <div id="48248-6">
              <script src="//ads.themoneytizer.com/s/gen.js?type=6">
              <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=6">
                        
            <div style="text-align:center;" id="48248-31">
                <script src="//ads.themoneytizer.com/s/gen.js?type=31">
                <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=31">
        
            <div class="body-wrap">
                <header class="site-header">
                    <div class="container">
                        <div class="site-header-inner">
                            <div class="brand header-brand">
                                <h1 class="m-0">
                                    <a href="#">
                                        <img class="header-logo-image" src=@{StaticR img_logo_svg} alt="Logo">
                                        
                <main>
                    <section class="hero">
                        <div class="container">
                            <div class="hero-inner">
                                <div class="hero-copy">
                                    <h1 class="hero-title mt-0">Seja o melhor COACH do país com nosso incrível curso EAD.
                                    <p class="hero-paragraph">Aprenda com os maiores pandilhas que já habitaram a face da terra.
                                    <div class="hero-cta">
                                        <a class="button button-primary" href=@{AdminR}>Administrador Coach
                                        <a class="button" href=@{EntrarR}>Login de usuário
                                        <a class="button" href=@{SairR}>Sair da sessão
                                        
                                <div class="hero-figure anime-element">
                                    <svg class="placeholder" width="528" height="396" viewBox="0 0 528 396">
                                        <rect width="528" height="396" style="fill:transparent;" />
                                    <div class="hero-figure-box hero-figure-box-01" data-rotation="45deg">
                                    <div class="hero-figure-box hero-figure-box-02" data-rotation="-45deg">
                                    <div class="hero-figure-box hero-figure-box-03" data-rotation="0deg">
                                    <div class="hero-figure-box hero-figure-box-04" data-rotation="-135deg">
                                    <div class="hero-figure-box hero-figure-box-05">
                                    <div class="hero-figure-box hero-figure-box-06">
                                    <div class="hero-figure-box hero-figure-box-07">
                                    <div class="hero-figure-box hero-figure-box-08" data-rotation="-22deg">
                                    <div class="hero-figure-box hero-figure-box-09" data-rotation="-52deg">
                                    <div class="hero-figure-box hero-figure-box-10" data-rotation="-50deg">
                                    
                    <section class="features section">
                        <div class="container">
                            <div class="features-inner section-inner has-bottom-divider">
                                <div class="features-wrap">
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon01_svg} alt="Feature 01">
                                            <h4 class="feature-title mt-24">Mude seu Mindset
                                            <p class="text-sm mb-0">Aprenda 1001 técnicas revolucionárias para transformar sua visão de mundo. "O que você precisa não é de faculdade ou diploma. Você precisa mudar o seu Mindset." - Murilo Coach
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon02_svg} alt="Feature 02">
                                            <h4 class="feature-title mt-24">Learn English
                                            <p class="text-sm mb-0">Estudos apontam que 79% dos Brasileiros tendem a depositar mais confiança em alguem ou uma instituição que preza pela dificuldade e pela multinacionalidade de seu negócio
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon03_svg} alt="Feature 03">
                                            <h4 class="feature-title mt-24">Amplie seu MarketShare
                                            <p class="text-sm mb-0">Conheça que você não precisa ter algo de qualidade para ganhar dinheiro, aumente seu Market Share com nossa incrível metodologia.
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon04_svg} alt="Feature 04">
                                            <h4 class="feature-title mt-24">Soft Skills
                                            <p class="text-sm mb-0">Descubra que você não precisa saber absolutamente nada para se dar bem, esqueça as Hard Skills, o futuro é você dominar as Soft Skills.
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon05_svg} alt="Feature 05">
                                            <h4 class="feature-title mt-24">Seja Ardil
                                            <p class="text-sm mb-0">Aprenda as mais variadas técnicas de manipulação do vernáculo para que qualquer obstáculo moral, seja apenas um mero óbice insignificante.
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon06_svg} alt="Feature 06">
                                            <h4 class="feature-title mt-24">Machine Learning
                                            <p class="text-sm mb-0">A Tecnologia é incrível, tenha acesso em primeira mão das tendências de mercado para que você possa sempre ser o pioneiro no que o seu market niche demandar. aprenda agora sobre machine learning
                    <section class="pricing section">
                        <div class="container-sm">
                            <div class="pricing-inner section-inner">
                                <div class="pricing-header text-center">
                                    <h2 class="section-title mt-0">Lições para a Vida Toda
                                    <p class="section-paragraph mb-0">Esqueça tudo o que você ja viu até hoje, tenha acesso ao nosso conteudo e prepare-se para mudar vidas.
                            <div class="pricing-tables-wrap">
                                <div class="pricing-table">
                                    <div class="pricing-table-inner is-revealing">
                                        <div class="pricing-table-main">
                                            <div class="pricing-table-header pb-24">
                                                <div class="pricing-table-price">
                                                    <span class="pricing-table-price-currency h2">R$
                                                    <span class="pricing-table-price-amount h1">637
                                                    <span class="text-xs">/mês
                                            <div class="pricing-table-features-title text-xs pt-24 pb-24">Aproveite nosso pacote!
                                                <ul class="pricing-table-features list-reset text-xs">
                                                    <li>
                                                        <span>Mais de 450 horas de video aulas.
                                                    <li>
                                                        <span>Mestres Renomados no Mercado.
                                                    <li>
                                                        <span>ChatBot Coach Training Ⓡ incluso.<
                                                    <li>
                                                        <span>Palestas Secretas para Membros.
                    <section class="cta section">
                        <div class="container">
                            <div class="cta-inner section-inner">
                                <h3 class="section-title mt-0">Você tem dúvidas sobre nosso serviço?
                                <div class="cta-cta">
                                    <a class="button button-primary button-wide-mobile" href="#">Não seja um Perdedor.                                                                         
        
            <footer class="site-footer>
                <div id="48248-2">
                    <script src="//ads.themoneytizer.com/s/gen.js?type=2">
                    <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=2">
                <div class="container">
                <div class="site-footer-inner">
                    <div class="brand footer-brand">
                        <a href="#">
                            <img class="header-logo-image" src=@{StaticR img_logo_svg} alt="Logo">
                    <ul class="footer-links list-reset">
                        <li>
                            <a href="#">Contato
                        <li>
                            <a href="#">Sobre nós
                        <li>
                            <a href="#">FAQ's
                    <ul class="footer-social-links list-reset">
                        <li>
                            <a href="https://www.facebook.com/">
                                <span class="screen-reader-text">Facebook
                                <svg width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M6.023 16L6 9H3V6h3V4c0-2.7 1.672-4 4.08-4 1.153 0 2.144.086 2.433.124v2.821h-1.67c-1.31 0-1.563.623-1.563 1.536V6H13l-1 3H9.28v7H6.023z" fill="#0270D7"/>
                        <li>
                            <a href="https://twitter.com/">
                                <span class="screen-reader-text">Twitter
                                <svg width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M16 3c-.6.3-1.2.4-1.9.5.7-.4 1.2-1 1.4-1.8-.6.4-1.3.6-2.1.8-.6-.6-1.5-1-2.4-1-1.7 0-3.2 1.5-3.2 3.3 0 .3 0 .5.1.7-2.7-.1-5.2-1.4-6.8-3.4-.3.5-.4 1-.4 1.7 0 1.1.6 2.1 1.5 2.7-.5 0-1-.2-1.5-.4C.7 7.7 1.8 9 3.3 9.3c-.3.1-.6.1-.9.1-.2 0-.4 0-.6-.1.4 1.3 1.6 2.3 3.1 2.3-1.1.9-2.5 1.4-4.1 1.4H0c1.5.9 3.2 1.5 5 1.5 6 0 9.3-5 9.3-9.3v-.4C15 4.3 15.6 3.7 16 3z" fill="#0270D7"/>
                        <li>
                            <a href="https://www.google.com/">
                                <span class="screen-reader-text">Google
                                <svg width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M7.9 7v2.4H12c-.2 1-1.2 3-4 3-2.4 0-4.3-2-4.3-4.4 0-2.4 2-4.4 4.3-4.4 1.4 0 2.3.6 2.8 1.1l1.9-1.8C11.5 1.7 9.9 1 8 1 4.1 1 1 4.1 1 8s3.1 7 7 7c4 0 6.7-2.8 6.7-6.8 0-.5 0-.8-.1-1.2H7.9z" fill="#0270D7"/>
                    <div class="footer-copyright">&copy; 2019 BeCoach Brasil, todos os direitos reservados.
            <script src=@{StaticR js_main_min_js}>
        |]